            include "Include/ROMHeader.s"

            EXPORT  BacklightPatch,DEBUGPWRMGRADBPATCH1,DEBUGPWRMGRADBPATCH2,InitADBPatchPwrMgr,PMGRPOWEROFFPATCH,PwrCntrlPatch

            IMPORT  EgretCheck,ExplicitRequestDone,GetHardwareInfo,ImplicitRequestDone,PollDone,RdXByte
            IMPORT  ReInit,RunDone,RunKBD,StartBoot,USTPMGRSENDBYTE

            SECTION "PwrControlsPatches",CODE

PwrCntrlPatch:
PORTABLECHECK:
            btst    #$18,D2
            beq.w   .L4
            adda.l  (8,A1),A1
            movea.l (A1),A1
            cmpi.l  #'SARA',(-$30,A1)
            bne.b   .L1
            clr.l   (-$30,A1)
            movea.l (-$34,A1),A0
            jmp     (A0)
.L1:
            clr.l   (-$30,A1)
            cmpi.b  #9,D2
            bne.w   .L4
            btst    #0,($50FB4000).l
            beq.w   .L4
            move.l  A6,D4
            BigBSR6 GetHardwareInfo,A0
            movea.l (8,A0),A2
            move.w  #$73,D1
            BigBSR6 RdXByte,A0
            andi.w  #2,D1
            move.l  D4,D5
            move.b  ($50F84000).l,D2
            andi.w  #2,D2
            cmp.b   D1,D2
            beq.b   .L3
            move.b  D1,($50F84000).l
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l ($2C,A0),A3
            move.b  #$D0,D3
            BigBSR5 USTPMGRSENDBYTE,A0
            moveq   #0,D3
            BigBSR5 USTPMGRSENDBYTE,A0
            move.l  #$10000000,D3
.L2:
            dbra    D3,.L2
.L3:
            movea.l D5,A6
.L4:
            RTS6
BacklightPatch:
            bsr.b   BklightInstall
            movea.l (SP)+,A0
            subq.w  #4,SP
            move.l  #'SERD',-(SP)
            jmp     (A0)
BklightInstall:
            movem.l D0-D3/A0-A3,-(SP)
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L4
            move.l  #'DRVR',D1
            move.w  #$BF81,D2
            bsr.b   sub_4088AD42
            beq.b   .L2
            movea.l UTableBase,A0
            move.l  #$BC,D3
.L1:
            addq.l  #4,D3
            tst.l   (0,A0,D3.w)
            bne.b   .L1
            move.l  D3,D0
            lsr.l   #2,D0
            addq.l  #1,D0
            neg.l   D0
            _DrvrInstall
            tst.l   D0
            bne.b   .L3
            movea.l (0,A0,D3.w),A3
            movea.l (A3),A3
            move.l  A1,(A3)
            movea.l (A1),A1
            move.w  (A1),(4,A3)
            move.w  (2,A1),($22,A3)
            move.w  (4,A1),($24,A3)
            move.w  (6,A1),($26,A3)
            bset    #6,(5,A3)
            lea     InitADBPatchPwrMgr.L2,A1
            bsr.b   sub_4088AD52
.L2:
            movem.l (SP)+,D0-D3/A0-A3
            rts
.L3:
            movea.l A1,A0
            _DisposHandle
.L4:
            movem.l (SP)+,D0-D3/A0-A3
            rts
sub_4088AD42:
            subq.l  #4,SP
            move.l  D1,-(SP)
            move.w  D2,-(SP)
            _GetResource
            movea.l (SP),A1
            _DetachResource
            move.l  A1,D0
            rts
sub_4088AD52:
            movem.l D1-D2/A0-A3,-(SP)
            suba.w  #$32,SP
            movea.l SP,A0
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            lea     ($32,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            rts
PMGRPOWEROFFPATCH:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L3
            lea     (-$10,SP),SP
            clr.w   (2,SP)
            move.w  #$21,(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($10,SP),SP
            _HideCursor
            clr.l   WarmStart
            lea     (-$10,SP),SP
            clr.w   (2,SP)
            move.w  #$7E,(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($10,SP),SP
            tst.w   D0
            bne.b   .L2
.L1:
            bra.b   .L1
.L2:
            move.w  #6,D0
            _Sleep
            BigJsr  StartBoot,A0
.L3:
            rts
DEBUGPWRMGRADBPATCH1:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            movea.l VIA,A1
            btst    #4,(vIFR,A1)
            beq.b   .L2
            bsr.l   RunKBD
            bra.b   .L2
.L1:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L3
            bsr.l   RunKBD
.L2:
            addq.l  #4,SP
            bra.l   PollDone
.L3:
            rts
DEBUGPWRMGRADBPATCH2:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            movea.l VIA,A1
            movea.l ($1A2).w,A0
            jsr     (A0)
            addq.l  #4,SP
            bra.l   RunDone
.L1:
            rts
STARTREQPMGR:
            movea.l VIA,A1
            move.b  #$10,(vIER,A1)
            suba.w  #$C,SP
            movea.l SP,A0
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            moveq   #3,D0
            add.b   D2,D0
            move.w  D0,-(SP)
            move.w  #$20,-(SP)
            moveq   #0,D0
            tst.l   D3
            bpl.b   .L1
            moveq   #4,D0
            move.b  ($16C,A3),D3
            bmi.b   .L4
            lsl.b   #4,D3
            ori.b   #$C,D3
.L1:
            move.b  D3,(A0)+
            move.b  D0,(A0)+
            move.b  D2,(A0)+
            bra.b   .L3
.L2:
            move.b  (A2)+,(A0)+
.L3:
            dbra    D2,.L2
            movea.l SP,A0
            _PMgrOp
.L4:
            lea     ($18,SP),SP
            move.b  #$90,(vIER,A1)
            rts
REQDONEPMGR:
            movea.l ADBBase,A3
            move.b  (A0)+,D1
            move.b  (A0)+,D0
            moveq   #8,D3
            and.b   D0,D3
            neg.l   D3
            move.b  D1,D3
            move.b  D3,(fDBCmd,A3)
            move.b  D3,(pollCmd,A3)
            lsr.b   #4,D1
            bset    #7,D1
            tst.l   D3
            bpl.b   .L2
            move.w  (devMap,A3),D2
            bset    D1,D2
.L1:
            addq.b  #1,D1
            andi.b  #$F,D1
            btst    D1,D2
            beq.b   .L1
.L2:
            move.b  D1,($16C,A3)
            moveq   #0,D2
            move.b  (A0)+,D2
            movea.l A0,A2
            btst    #2,D0
            bne.b   .L3
            bclr    #7,($16C,A3)
            bsr.l   ExplicitRequestDone
            rts
.L3:
            bsr.l   ImplicitRequestDone
            rts
InitADBPatchPwrMgr:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            lea     STARTREQPMGR,A0
            move.l  A0,($130,A3)
            lea     REQDONEPMGR,A0
            move.l  A0,($19A).w
            bra.l   ReInit
.L1:
            bra.l   EgretCheck
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
            dc.b    'NEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEATNEAT'
.L2:
            dc.b    10,'.Backlight'
            ds.b    7

            EVEN
