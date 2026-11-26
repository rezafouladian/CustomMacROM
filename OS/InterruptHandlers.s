            include "Include/ROMHeader.s"

            EXPORT  ClearASCInt,ClearSCSIInt,DebugUtil,DisableASCInts,DisableIntSources,DisableSCSIInts
            EXPORT  Enable60HzInts,EnableASCInts,EnableParityInts,EnableSCSIInts,EnableSlotInts,EnableSWIMIOPInts
            EXPORT  GOTSLOTHANDLER,InitIntHandler,INTHANDLERNOVIA2,PollDone,PowerOff,PowerOffCont
            EXPORT  RunDone,RunKBD,SCCIOPBYPASSINT

            IMPORT  clock,DEBUGENTERCONT,DEBUGEXITCONT,DEBUGPWRMGRADBPATCH1,DEBUGUTILRUNKBDPATCH,INITSLOTINTSPATCH
            IMPORT  IOPINTERRUPT,OSSSLOTINT,PMGRPOWEROFFPATCH,POWEROFFPATCH,RBVSLOTINT,SlotInt
            IMPORT  VBLInt

            SECTION "InterruptHandlers",CODE

IntHnd:
            rte
.L1:
            dc.w    $4E73
            ds.b    12
sub_40809B10:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L4,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B20:
            movem.l D0-D3/A0-A3,-(SP)
            lea     SCCIOPBYPASSINT,A3
            bra.b   sub_40809B60.L1
.L1:
            dc.w    $4E73
            ds.b    4
sub_40809B30:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L9,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B40:
            movem.l D0-D3/A0-A3,-(SP)
            lea     sub_40809B60.L7,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B50:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L7,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B60:
            movem.l D0-D3/A0-A3,-(SP)
            lea     .L6,A3
.L1:
            tst.b   MMU32bit
            bne.b   .L4
.L2:
            jsr     (A3)
            tst.l   ($D94).w
            beq.b   .L3
            moveq   #7,D0
            and.b   ($20,SP),D0
            bne.b   .L3
            movea.l ($6E4).w,A0
            jsr     (A0)
.L3:
            movem.l (SP)+,D0-D3/A0-A3
            rte
.L4:
            btst    #0,($B73).w
            beq.b   .L2
            moveq   #0,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            jsr     (A3)
            tst.l   ($D94).w
            beq.b   .L5
            moveq   #7,D0
            and.b   ($20,SP),D0
            bne.b   .L5
            movea.l ($6E4).w,A0
            jsr     (A0)
.L5:
            moveq   #1,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D0-D3/A0-A3
            rte
            dc.w    0
.L6:
            movea.l VIA,A1
            moveq   #$7F,D0
            and.b   (vIFR,A1),D0
            and.b   (vIER,A1),D0
            movea.w .L8(PC,D0.w*2),A0
            movea.l (A0),A0
            jmp     (A0)
            ds.b    10
.L7:
            dc.w    $2278,$0CEC,$707F,$C029,$1A03,$41F8,$0BDE,$C029
            dc.w    $1C13,$D0FB,$0206,$2050,$4ED0
.L8:
            dc.w    $01AE,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A6,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01AA,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A6,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            ds.b    6
SCCIOPBYPASSINT:
            movea.l SCCRd,A0
            move.b  (A0),D0
            movea.l SCCWr,A1
            move.b  #2,(A1)
            lea     Lvl2DT,A2
            moveq   #$E,D0
            and.b   (A0),D0
            cmpi.b  #8,D0
            blt.b   .L1
            addq.w  #2,A0
            addq.w  #2,A1
.L1:
            movea.l (0,A2,D0.w*2),A2
            jmp     (A2)
            ds.b    10
ExtBInt:
            move.b  (A0),D0
            lea     SCCBSts,A3
            lea     ExtStsDT,A2
            bra.b   ExtABInt
            ds.b    4
ExtAInt:
            move.b  (A0),D0
            lea     SCCASts,A3
            lea     ($2C6).w,A2
ExtABInt:
            move.b  #15,(A1)
            move.b  (A3),D1
            move.b  D0,(A3)
            eor.b   D0,D1
            and.b   (A0),D1
            move.b  #$10,(A1)
            movea.l (A2),A2
            jmp     (A2)
            dc.w    0
.L4:
            moveq   #0,D0
            jmp     (IOPINTERRUPT.w,PC)
            ds.b    10
.L5:
            move.b  #1,($1A00,A1)
.L6:
            moveq   #1,D0
            jmp     (IOPINTERRUPT.w,PC)
            ds.b    4
.L7:
            movea.l VIA2,A1
            move.w  ($202,A1),D0
            btst    #6,D0
            bne.b   .L15
.L8:
            btst    #$B,D0
            bne.w   sub_40809B60.L6
            btst    #$A,D0
            bne.b   .L13
            rts
.L15:
            moveq   #7,D1
            and.b   (6,A1),D1
            bne.b   .L6
            bra.b   .L8
            ds.b    8
.L9:
            movea.l VIA2,A1
            move.w  ($202,A1),D0
            btst    #9,D0
            bne.b   .L16
.L10:
            btst    #8,D0
            bne.b   .L12
.L11:
            movea.l ($D74).w,A0
            jmp     (A0)
.L16:
            moveq   #7,D1
            and.b   (9,A1),D1
            beq.b   .L10
            movea.l ($D7C).w,A0
            jmp     (A0)
.L12:
            moveq   #7,D1
            and.b   (8,A1),D1
            beq.b   .L11
            movea.l ($D80).w,A0
            jmp     (A0)
            ds.b    10
.L13:
            lea     (-$17F9,A1),A1
            movea.l ($196).w,A0
            jmp     (A0)
            movea.l ($19A).w,A0
            jmp     (A0)
sub_40809E00:
            bset    #6,NMIFlag
            bne.b   .L1
            move    (SP),SR
            movem.l D0/A0,-(SP)
            _PowerOff
            movem.l (SP)+,D0/A0
.L1:
            rte
PowerOff:
            bsr.w   WaitAWhile
            bsr.l   PMGRPOWEROFFPATCH
            BigJmp  POWEROFFPATCH,A0
PowerOffCont:
            movea.l VIA2,A0
            bra.b   .L1
            ds.b    4
.L1:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   WaitAWhile
            bset    #7,($204,A0)
WaitAWhile:
            move.l  #$FE0C0000,D0
.L1:
            move.w  TimeDBRA,D0
.L2:
            dbra    D0,.L2
            addq.l  #1,D0
            bne.b   .L1
            rts
InitIntHandler:
            lea     Lvl1DT,A0
            lea     GOTSLOTHANDLER.L6,A1
            moveq   #$F,D0
.L1:
            move.l  A1,(A0)+
            dbra    D0,.L1
            lea     (clock.w,PC),A0
            move.l  A0,Lvl1DT
            lea     (VBLInt.w,PC),A0
            move.l  A0,($196).w
            btst    #2,HWCfgFlags
            beq.b   .L2
            lea     ($1B6).w,A2
            lea     ExtBInt,A0
            move.l  A0,(A2)
            lea     ExtAInt,A0
            move.l  A0,($10,A2)
            lea     ExtStsDT,A2
            lea     GOTSLOTHANDLER.L6,A0
            move.l  A0,(A2)+
            move.l  A0,(A2)+
            move.l  A0,(A2)+
            move.l  A0,(A2)+
.L2:
            lea     ($D70).w,A2
            moveq   #7,D0
.L3:
            move.l  A0,(A2)+
            dbra    D0,.L3
            lea     (SlotInt.w,PC),A0
            bra.l   INITSLOTINTSPATCH
            dc.w    0
INTHANDLERNOVIA2:
            lea     (RBVSLOTINT.w,PC),A0
            btst    #5,($DD2).w                     ; TestFor RBVExists
            bne.b   GOTSLOTHANDLER
            lea     (OSSSLOTINT.w,PC),A0
            btst    #2,($DD1).w                     ; TestFor OSSExists
            nop
GOTSLOTHANDLER:
            move.l  A0,($D74).w
            lea     Lev1AutoVector,A2
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            lea     sub_40809B50,A0
            move.l  A0,(A2)+
            lea     sub_40809B30,A0
            move.l  A0,(A2)+
.L1:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            bne.b   .L2
            lea     sub_40809B60,A0
            move.l  A0,(A2)+
            lea     sub_40809B40,A0
            move.l  A0,(A2)+
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L2
            lea     ExtABInt.L5,A0
            move.l  A0,($D70).w
.L2:
            lea     sub_40809B20.L1,A0
            move.l  A0,(A2)+
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .L3
            lea     sub_40809B10,A0
            move.l  A0,(A2)+
.L3:
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            bne.b   .L4
            lea     sub_40809B20,A0
            move.l  A0,(A2)+
.L4:
            lea     IntHnd.L1,A0
            move.l  A0,(A2)+
            lea     IntHnd,A0
            cmpi.b  #0,BoxFlag
            bne.b   .L5
            lea     sub_40809E00,A0
.L5:
            move.l  A0,(A2)+
.L6:
            rts
DisableIntSources:
            movea.l VIA,A0
            move.b  #$7F,(vIER,A0)
            movea.l VIA2,A0
            btst    #3,($DD2).w                     ; TestFor VIA2Exists
            bne.b   .L1
            btst    #5,($DD2).w                     ; TestFor RBVExists
            beq.b   .L2
.L1:
            move.b  #$7F,($1C13,A0)
.L2:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L4
            movea.l VIA2,A0
            lea     0.w(A0),A0
            moveq   #$E,D0
.L3:
            clr.b   (A0)+
            dbra    D0,.L3
            movea.l VIA2,A0
            move.b  #1,($B,A0)
            move.b  #4,(7,A0)
.L4:
            rts
Enable60HzInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #1,($A,A0)
            rts
.L1:
            movea.l VIA,A0
            move.b  #$82,(vIER,A0)
            rts
            ds.b    12
EnableSlotInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L2
            movea.l VIA2,A0
            lea     0.w(A0),A0
            moveq   #5,D0
.L1:
            move.b  #2,(A0)+
            dbra    D0,.L1
            rts
.L2:
            movea.l VIA2,A0
            move.b  #$82,($1C13,A0)
            rts
EnableSWIMIOPInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #1,(6,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$81,($1C13,A0)
            rts
EnableASCInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #2,(8,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$90,($1C13,A0)
            rts
DisableASCInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            clr.b   (8,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$10,($1C13,A0)
            rts
ClearASCInt:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$90,($1A03,A0)
            rts
EnableSCSIInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #2,(9,A0)
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #$88,($1C13,A0)
            rts
.L2:
            move.b  #$88,($1C13,A0)
            rts
            rts
DisableSCSIInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            clr.b   (9,A0)
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #8,($1C13,A0)
            rts
.L2:
            move.b  #8,($1C13,A0)
            rts
            rts
ClearSCSIInt:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #$88,($1A03,A0)
            rts
.L2:
            move.b  #$88,($1A03,A0)
            rts
            dc.w    $4E75
            ds.b    4
DebugUtil:
            lea     .table,A0
            cmp.l   (A0)+,D0
            bhi.b   .tooBig
            add.w   D0,D0
            adda.w  (A0,D0.w),A0
            jmp     (A0)
.tooBig:
            moveq   #paramErr,D0
            rts
.table:
            dc.l    (.last-.first)/2-1              ; Highest selector supported
.first:
            dc.w    .getMax-.first                  ; 0
            dc.w    DebugEnter-.first               ; 1
            dc.w    DebugExit-.first                ; 2
            dc.w    DebugPoll-.first                ; 3
.last:
.getMax:
            move.l  .table,D0
            rts
DebugEnter:
            bra.w   DoDebugEnter
            ds.b    8
DebugExit:
            bra.w   DoDebugExit
DebugPoll:
            btst    #2,HWCfgFlags
            beq.b   PollDone
            bsr.l   DEBUGPWRMGRADBPATCH1
            nop
            movea.l VIA,A1
            btst    #2,(vIFR,A1)
            beq.b   PollDone
            bsr.b   RunKBD
            nop
PollDone:
            moveq   #0,D0
            rts
RunKBD:
            movem.l D3/A3,-(SP)
            btst    #2,HWCfgFlags
            beq.b   RunDone
            bsr.l   DEBUGUTILRUNKBDPATCH
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            move.l  #$8080001,D0
            jsr     (IOPINTERRUPT.w,PC)
            bra.b   RunDone
.L1:
            movea.l VIA,A1
            movea.l ($19A).w,A0
            jsr     (A0)
            nop
RunDone:
            movem.l (SP)+,D3/A3
            rts
EnableParityInts:
            btst    #4,($DD1).w                     ; TestFor RPUExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #7,($E,A0)
.L1:
            rts
DoDebugEnter:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            bsr.b   RunKBD
.L1:
            move.l  A0,-(SP)
            BigJsr  DEBUGENTERCONT,A0
            movea.l (SP)+,A0
            rts
DoDebugExit:
            move.l  A0,-(SP)
            BigJsr  DEBUGEXITCONT,A0
            movea.l (SP)+,A0
            rts
            dc.b    'GaryGaryGaryGary'

            EVEN
