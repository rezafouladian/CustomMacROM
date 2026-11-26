            include "Include/ROMHeader.s"

            EXPORT  AttachVBL,BadTrap,CacheFlush,CacheTrap,ClearASCInt,ClearSCSIInt
            EXPORT  DebugUtil,DequeueTrap,DisableASCInts,DisableIntSources,DisableSCSIInts,DoVBLTask
            EXPORT  DTCore,EMT1010,Enable60HzInts,EnableASCInts,EnableParityInts,EnableSCSIInts
            EXPORT  EnableSlotInts,EnableSWIMIOPInts,GetTrapAddress,GOTSLOTHANDLER,InitDispatcher,InitIntHandler
            EXPORT  InitQueue,InitVBLQs,INTHANDLERNOVIA2,PollDone,PowerOff,PowerOffCont
            EXPORT  QStuff,RunDone,RunKBD,SCCIOPBYPASSINT,SetTrapAddress,SlotVInstall
            EXPORT  SlotVRemove,VBLCore,vCacheFlush,vDisptch,VRemove

            IMPORT  CACHEVECTORPATCH,clock,CmdDone,DEBUGENTERCONT,DEBUGEXITCONT,DEBUGPWRMGRADBPATCH1
            IMPORT  DEBUGUTILRUNKBDPATCH,DISPATCHPATCH,FSQueueSync,INITSLOTINTSPATCH,IOPINTERRUPT,OSSSLOTINT
            IMPORT  PMGRPOWEROFFPATCH,POWEROFFPATCH,RBVSLOTINT,SlotInt,SysErr1

            SECTION "Part4",CODE

CacheProc:
CTrapTbl:
            dc.w    GetCSize-CTrapTbl               ; 0
            dc.w    SetCSize-CTrapTbl               ; 1
            dc.w    GetApZnSiz-CTrapTbl             ; 2
            dc.w    SetApZnSiz-CTrapTbl             ; 3
            dc.w    GetMaxCXfr-CTrapTbl             ; 4
            dc.w    SetMaxCXfr-CTrapTbl             ; 5
            dc.w    GetCStatus-CTrapTbl             ; 6
            dc.w    SetCStatus-CTrapTbl             ; 7
CacheTrap:
            cmpi.w  #(CacheTrap-CTrapTbl)/2,D0
            bcs.b   .L1
            moveq   #paramErr,D0
            rts
.L1:
            lea     CTrapTbl,A1
            add.w   D0,D0
            adda.w  (0,A1,D0.w),A1
            jmp     (A1)
CTExit:
            jmp     (CmdDone.w,PC)
GetCSize:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetCSize:
            jsr     (FSQueueSync.w,PC)
            move.l  ($1C,A0),D0                     ; ioMisc
            moveq   #15,D1
            lsr.l   D1,D0
            move.b  D0,($20A).w                     ; CacheConfig
            moveq   #0,D0
            bra.b   CTExit
GetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($20,A1),($1C,A0)               ; CacheMinZn -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($1C,A0),($20,A1)               ; ioMisc -> CacheMinZn
            moveq   #0,D0
            bra.b   CTExit
GetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($12,A1),($1C,A0)               ; CacheByteLim -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  ($1C,A0),D1                     ; ioMisc
            cmp.l   D1,D0
            bcc.b   .L1
            moveq   #paramErr,D0
            bra.w   CTExit
.L1:
            move.l  D1,($12,A1)                     ; CacheByteLim
            moveq   #0,D0
            bra.w   CTExit
GetCStatus:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            moveq   #0,D0
            tst.b   ($11,A1)                        ; CurEnable
            beq.b   .L1
            btst    #5,($20B).w                     ; CacheEnable
            beq.b   .L1
            moveq   #1,D0
.L1:
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.w   CTExit
SetCStatus:
            jsr     (FSQueueSync.w,PC)
            tst.l   ($1C,A0)                        ; ioMisc
            beq.b   .L1
            bset    #5,($20B).w                     ; CacheEnable
            bra.b   .L2
.L1:
            bclr    #5,($20B).w                     ; CacheEnable
.L2:
            moveq   #0,D0
            bra.w   CTExit
            ds.b    10
QStuff:
Enqueue:
            move    SR,-(SP)
            addq.w  #2,A1
            ori     #$700,SR
            clr.l   (A0)
            tst.l   (A1)+
            bne.b   .L1
            move.l  A0,(A1)
            move.l  A0,-(A1)
            bra.b   .L2
.L1:
            move.l  A2,-(SP)
            movea.l (A1),A2
            move.l  A0,(A2)
            move.l  A0,(A1)
            movea.l (SP)+,A2
            subq.w  #4,A1
.L2:
            subq.w  #2,A1
            move    (SP)+,SR
            rts
DequeueTrap:
            move    SR,-(SP)
            movem.l A2-A3,-(SP)
            ori     #$700,SR
            movea.l (2,A1),A2
            movea.l A2,A3
.L1:
            cmpa.l  A3,A0
            beq.b   .L2
            movea.l A3,A2
            movea.l (A2),A3
            cmpa.l  (6,A1),A2
            bne.b   .L1
            moveq   #-1,D0
            bra.b   .L4
.L2:
            cmpa.l  A2,A3
            bne.b   .L5
            move.l  (A2),(2,A1)
            bne.b   .L3
            clr.l   (6,A1)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,A2-A3
            move    (SP)+,SR
            rts
.L5:
            move.l  (A3),(A2)
            cmpa.l  (6,A1),A3
            bne.b   .L3
            move.l  A2,(6,A1)
            bra.b   .L3
InitQueue:
            clr.w   (A1)+
            clr.l   (A1)+
            clr.l   (A1)
            subq.w  #6,A1
            rts
            ds.b    8
EMT1010:
Dispatcher:
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            movea.l ($A,SP),A2
            move.w  (A2)+,D2
            cmpi.w  #$A800,D2
            bcs.b   .L2
            subi.w  #$AC00,D2
            bcc.b   .L1
            move.l  ($1E00.w,D2.w*4),(8,SP)
            move.l  A2,($C,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rts
            ds.b    8
.L1:
            move.l  ($E00.w,D2.w*4),(8,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rtd     #4
.L2:
            move.l  D1,-(SP)
            move.l  A1,-(SP)
            move.w  D2,D1
            move.l  A2,($14,SP)
            andi.w  #$100,D2
            bne.b   .L3
            move.b  D1,D2
            move.l  A0,-(SP)
            jsr     ([DispatchTab.w,D2.w*4])
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
            ds.b    6
.L3:
            move.b  D1,D2
            jsr     ([D2.w*4])
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
sub_40809A34:
            lsl.w   #6,D1
            bpl.b   .L2
            bcc.b   .L3
.L1:
            andi.w  #$3FF,D0
            lea     ($E00.w,D0.w*4),A1
            rts
.L2:
            andi.w  #$1FF,D0
            moveq   #-$57,D1
            add.w   D0,D1
            bgt.b   .L1
            beq.b   .L3
            addq.w  #8,D1
            ble.b   .L3
            subq.w  #5,D1
            bne.b   .L1
.L3:
            andi.w  #$FF,D0
            lea     (DispatchTab.w,D0.w*4),A1
            rts
GetTrapAddress:
            bsr.b   sub_40809A34
            movea.l (A1),A0
            moveq   #0,D0
            rts
SetTrapAddress:
            bsr.b   sub_40809A34
            bra.l   DISPATCHPATCH
CacheFlush:
            move.l  ($6F4).w,-(SP)
            rts
vCacheFlush:
            movec   CACR,D1
            addq.w  #8,D1
            movec   D1,CACR
            rts
            lea     EMT1010,A0
            beq.b   .L1
            lea     EMT1010,A0
.L1:
            move.l  A0,LineAVector
InitDispatcher:
            lea     BadTrap,A4
            movea.l ROMBase,A3
            movea.l A3,A2
            lea     ($E00).w,A1
            movea.l A3,A0
            adda.l  ($22,A0),A0
            moveq   #$7F,D2
            move.w  #$3FF,D0
.L1:
            move.b  (A0)+,D1
            bmi.b   .L5
            lsl.w   #8,D1
            move.b  (A0)+,D1
.L2:
            add.w   D1,D1
            beq.b   .L7
            adda.w  D1,A2
.L3:
            move.l  A2,(A1)+
.L4:
            dbra    D0,.L1
            lea     DispatchTab,A1
            bra.b   .L1
.L5:
            and.w   D2,D1
            beq.b   .L6
            cmp.w   D2,D1
            bne.b   .L2
            movea.l (A0)+,A2
            adda.l  A3,A2
            bra.b   .L3
.L6:
            move.l  A4,(A1)+
            bra.b   .L4
.L7:
            bra.l   CACHEVECTORPATCH
            ds.b    4
BadTrap:
            movem.l D0-D7/A0-A7,seVars
            moveq   #$C,D0
            jmp     (SysErr1.w,PC)
            ds.b    14
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
            lea     VBLInt,A0
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
DTCore:
DTInstall:
            cmpi.w  #7,(4,A0)
            bne.b   .L1
            lea     DTQueue,A1
            jsr     QStuff
            moveq   #0,D0
            rts
.L1:
            moveq   #-2,D0
            rts
DisptchTsk:
            move.l  ($6E4).w,-(SP)
            rts
vDisptch:
            btst    #6,VBLQueue
            bne.b   .L1
            bset    #6,DTQueue
            beq.b   .L3
.L1:
            rts
.L2:
            movea.l D0,A0
            lea     DTQueue,A1
            jsr     DequeueTrap
            movea.l (8,A0),A2
            movea.l ($C,A0),A1
            andi    #$F8FF,SR
            jsr     (A2)
.L3:
            ori     #$700,SR
            move.l  ($D94).w,D0
            bne.b   .L2
            bclr    #6,DTQueue
            rts
            ds.b    6
VBLCore:
VInstall:
            lea     VBLQueue,A1
.L1:
            cmpi.w  #1,(4,A0)
            bne.b   .L4
            move.w  ($A,A0),D1
            beq.b   .L3
            tst.w   ($C,A0)
            beq.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            move.l  ($A,A1),D0
            swap    D0
            moveq   #0,D2
            move.w  D0,D2
            divu.w  D1,D2
            swap    D2
            move.w  D2,D0
            swap    D0
            divu.w  D1,D0
            swap    D0
            sub.w   ($C,A0),D0
            neg.w   D0
            bpl.b   .L2
            add.w   D1,D0
.L2:
            add.w   D0,($A,A0)
            move    (SP)+,SR
.L3:
            jsr     QStuff
            moveq   #0,D0
            rts
.L4:
            moveq   #-2,D0
            rts
VRemove:
            cmpi.w  #1,(4,A0)
            bne.b   VInstall.L4
            move.l  A1,-(SP)
            lea     VBLQueue,A1
            jsr     DequeueTrap
            movea.l (SP)+,A1
.L1:
            rts
VBLInt:
            addq.l  #1,Ticks
            move.b  #2,($1A00,A1)
            bset    #6,VBLQueue
            bne.b   VRemove.L1
            move    #$2000,SR
            move.l  StkLowPt,D0
            beq.b   .L2
            cmpa.l  D0,SP
            bcc.b   .L1
            move.l  SP,StkLowPt
.L1:
            movea.l ApplZone,A1
            cmpa.l  (A1),SP
            bcc.b   .L2
            moveq   #$1C,D0
            _SysError
.L2:
            lea     VBLQueue,A1
.L3:
            lea     (2,A1),A0
.L4:
            move.l  (A0),D0
            beq.b   .L5
            movea.l D0,A0
            subq.w  #1,($A,A0)
            bne.b   .L4
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            movea.l (6,A0),A1
            jsr     (A1)
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            tst.w   ($A,A0)
            bne.b   .L4
            jsr     DequeueTrap
            bra.b   .L4
.L5:
            bclr    #6,(A1)
            rts
GetSlotVBLQHdr:
            ext.w   D0
            cmpi.w  #$E,D0
            bgt.b   .L1
            movea.l ([$D04.w],D0.w*4),A1
            rts
.L1:
            move.w  #$FEAF,D0
            addq.w  #4,SP
            rts
SlotVInstall:
            bsr.b   GetSlotVBLQHdr
            bra.w   VInstall.L1
SlotVRemove:
            bsr.b   GetSlotVBLQHdr
            cmpi.w  #1,(4,A0)
            bne.w   VInstall.L4
            jmp     DequeueTrap
AttachVBL:
            bsr.b   GetSlotVBLQHdr
            move.l  A1,($D10).w
            moveq   #0,D0
            rts
DoVBLTask:
            bsr.b   GetSlotVBLQHdr
            addq.l  #1,($A,A1)
            cmpa.l  ($D10).w,A1
            bne.b   .L1
            move.l  JCrsrTask,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  A1,-(SP)
            jsr     (A0)
            movea.l (SP)+,A1
.L1:
            bra.w   VBLInt.L3
InitVBLQs:
            lea     DoVBLTask,A0
            move.l  A0,($D28).w
            clr.l   ($D10).w
            rts
            dc.w    0

            EVEN
