            include "Include/ROMHeader.s"

            EXPORT  DoOpenLap

            SECTION "ATBoot_NetBootlmgr",CODE

DoOpenLap:
            bsr.w   InstallDRVRs_DRVR_50
            bne.w   .L4
            bsr.w   ReadPRAM_DRVR_50
            moveq   #1,D2
            moveq   #$10,D0
            addi.w  #$30A,D0
            _NewPtrSysClear
            bne.w   .L4
            move.w  D2,(A0)
            movea.l ExpandMem,A1
            lea     ($74,A1),A1
            move.l  A0,(A1)
            move.l  D1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($74,A0),A0
            lea     LAPMgrPtr,A1
            movea.l UTableBase,A2
            moveq   #$24,D1
            movea.l (0,A2,D1.w),A2
            movea.l (A2),A2
            movea.l (A2),A2
            move.w  (8,A2),D1
            move.w  (-2,A2,D1.w),D1
            lea     (0,A2,D1.w),A3
            move.l  A3,D0
            _StripAddress
            move.l  D0,(A1)
            moveq   #$10,D0
            jsr     (2,A3)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            move.l  (SP)+,D1
            tst.b   D1
            bne.b   .L1
            bsr.w   InstallPrintAtlk_DRVR_50
            bra.b   .L2
.L1:
            bsr.w   ATlkInit
            bne.b   .L4
.L2:
            lea     ($30A,A3),A3
            tst.l   (8,A3)
            bne.b   .L3
            bset    #5,(6,A3)
.L3:
            moveq   #0,D0
.L4:
            rts
ATlkInit:
            movem.l D4,-(SP)
            moveq   #-1,D4
            bsr.w   InstallADEV
            move.l  D1,($312,A3)
            tst.w   D0
            beq.b   .ATlkIDone
            bsr.w   InstallE
.ATlkIDone:
            movem.l (SP)+,D4
            rts
InstallE:
            exg     D0,D1
            st      PortBUse
            moveq   #-$B,D0
            _DrvrRemove
            moveq   #-$A,D0
            _DrvrRemove
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            move.l  ($1EE,A1),D0
            beq.b   .L1
            movea.l D0,A0
            move.w  #$A9A0,D0
            _SetTrapAddress
.L1:
            movea.l A1,A0
            _DisposPtr
            move.l  MinusOne,LAPMgrPtr
            move.l  D1,D0
            rts
InstallPrintAtlk_DRVR_50:
            move.w  #1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L1
            move.l  #$53432020,D1
            move.w  #$101,D1
            move.w  #$FFFF,D4
            bsr.b   InstallTheAtlk
.L1:
            rts
GetRomAtlk_DRVR_50:
            move.l  D2,-(SP)
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  (SP)+,D2
            rts
InstallTheAtlk:
            movem.l D2-D4/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A0),A0
            tst.w   D4
            bpl.b   .L1
            moveq   #0,D4
.L1:
            moveq   #1,D0
            jsr     (2,A0)
            movem.l (SP)+,D2-D4/A0/A2-A3
            tst.w   D0
            rts
InstallADEV:
            moveq   #0,D2
            clr.w   D0
            move.b  D1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L4
            move.l  D1,D3
            bsr.b   InstallTheAtlk
            beq.b   .L2
.L1:
            move.w  D0,D2
            bra.b   .L4
.L2:
            bsr.b   CheckPramVal_DRVR_50
            bne.b   .L1
            cmp.l   D1,D3
            beq.b   .L3
            bsr.w   WritePRAM_DRVR_50
.L3:
            moveq   #0,D0
            nop
.L4:
            tst.w   D0
            rts
CheckPramVal_DRVR_50:
            moveq   #0,D0
            move.b  D3,D1
            tst.w   D4
            bmi.b   .L1
            cmp.l   D1,D3
            beq.b   .L1
            movea.l (A0),A0
            bsr.w   DoAShutdown
            moveq   #-1,D0
.L1:
            tst.w   D0
            rts
DoAShutdown:
            movem.l D0-D3/A0-A3,-(SP)
            moveq   #2,D0
            jsr     (2,A0)
            movem.l (SP)+,D0-D3/A0-A3
            rts
InstallDRVRs_DRVR_50:
            moveq   #-$B,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #-$A,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
sub_408562F2:
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            move.w  D3,-(SP)
            not.w   (SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,-(SP)
            move.l  A0,D0
            beq.b   InstallDRVRs_DRVR_50.L1
            move.w  D3,D0
            _DrvrInstall async
            movea.l UTableBase,A0
            not.w   D3
            lsl.w   #2,D3
            movea.l (0,A0,D3.w),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A1),(A0)
            movea.l (A0),A1
            move.b  (A1),(4,A0)
            bclr    #6,(5,A0)
            moveq   #0,D0
            rts
ReadPRAM_DRVR_50:
            clr.l   -(SP)
            btst    #$E,HWCfgFlags
            beq.b   .L1
            movea.l SP,A0
            move.l  #$400E0,D0
            _ReadXPRam
.L1:
            move.l  (SP)+,D1
            rts
WritePRAM_DRVR_50:
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            movea.l SP,A0
            move.l  #$400E0,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l (SP)+,A0
            rts

            EVEN
