            include "Include/ROMHeader.s"

            EXPORT  FlushApplNM,NMGNEFILTER,NMInit,NMTask,_NMInstall_,_NMRemove_

            IMPORT  BlockMove_2,Delay_2,Dequeue_2,DisposHandle,DisposPtr,Enqueue_2
            IMPORT  GetHandleSize_2,HGetState,HLock_2,HSetState,NGETTRAPADDRESS,NMInstall
            IMPORT  NMRemove,NewSCPtr,NewSHandle,StripAddress_2,equalstring,disable
            IMPORT  spl_,A

            SECTION "NotificationMgrC",CODE

getpid:
            subq.l  #4,SP
            move.w  #$8F,-(SP)
            moveq   #1,D0
            move.b  D0,-(SP)
            jsr     (NGETTRAPADDRESS.w,PC)
            subq.l  #4,SP
            move.w  #$9F,-(SP)
            moveq   #1,D0
            move.b  D0,-(SP)
            jsr     (NGETTRAPADDRESS.w,PC)
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            beq.b   .L1
            subq.l  #2,SP
            moveq   #$13,D0
            move.w  D0,-(SP)
            _OSDispatch
            move.w  (SP)+,D0
            bra.b   .L2
.L1:
            moveq   #-1,D0
.L2:
            rts
            ds.b    14
GetFreeAux:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l (6,A4),A3
            move.l  A3,D0
            beq.b   .L1
            tst.w   (4,A3)
            bne.b   .L1
            move.l  A3,D0
            bra.b   .L2
.L1:
            moveq   #0,D0
.L2:
            movem.l (SP)+,A3-A4
            rts
            ds.b    14
AddAuxRec:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            move.l  A4,-(SP)
            jsr     GetFreeAux
            tst.l   D0
            addq.l  #4,SP
            bne.b   .L1
            move.l  (8,A6),-(SP)
            jsr     (NewSCPtr.w,PC)
            movea.l D0,A3
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     (Enqueue_2.w,PC)
            lea     ($C,SP),SP
.L1:
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    8
LinkAuxRec:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.w  #$FFFF,(4,A3)
            addq.w  #1,(6,A3)
            move.l  (8,A4),(8,A3)
            move.l  A3,(8,A4)
            movem.l (SP)+,A3-A4
            rts
            ds.b    10
UnLinkAuxRecs:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l (8,A4),A3
            moveq   #0,D0
            move.l  D0,(8,A4)
            bra.b   .L2
.L1:
            subq.w  #1,(6,A3)
            movea.l (8,A3),A3
.L2:
            move.l  A3,D0
            bne.b   .L1
            movem.l (SP)+,A3-A4
            rts
            ds.b    10
InsertMarkRec:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($B60).w,A0
            movea.l ($C,A0),A3
            move.w  ($C,A4),D6
            move.w  ($E,A4),D7
            bra.b   .L2
.L1:
            movea.l (A3),A3
.L2:
            move.l  A3,D0
            beq.b   .L4
            cmp.w   ($E,A3),D7
            bne.b   .L3
            cmp.w   ($C,A3),D6
            beq.b   .L4
.L3:
            tst.w   (4,A3)
            bne.b   .L1
.L4:
            move.l  A3,D0
            bne.b   .L5
            movea.l ($B60).w,A0
            pea     ($A,A0)
            jsr     GetFreeAux
            movea.l D0,A3
            addq.l  #4,SP
.L5:
            move.l  A3,D0
            beq.b   .L6
            move.w  D6,($C,A3)
            move.w  D7,($E,A3)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     LinkAuxRec
            addq.l  #8,SP
.L6:
            move.l  A3,D0
            movem.l (SP)+,D6-D7/A3-A4
            rts
            ds.b    12
InsertIconRec:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($B60).w,A0
            pea     ($14,A0)
            jsr     GetFreeAux
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #4,SP
            beq.b   .L1
            move.l  ($10,A4),($C,A3)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     LinkAuxRec
            addq.l  #8,SP
.L1:
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    12
ValidIconRec:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            bra.b   .L3
.L1:
            movea.l (A4),A3
            tst.w   (4,A4)
            beq.b   .L2
            movea.l ($B60).w,A0
            pea     ($14,A0)
            move.l  A4,-(SP)
            jsr     (Dequeue_2.w,PC)
            move.l  A4,-(SP)
            jsr     (DisposPtr.w,PC)
            lea     ($C,SP),SP
.L2:
            movea.l A3,A4
.L3:
            move.l  A4,D0
            beq.b   .L4
            tst.w   (6,A4)
            beq.b   .L1
.L4:
            move.l  A4,D0
            movem.l (SP)+,A3-A4
            rts
            dc.w    0
NMInit:
            moveq   #$34,D0
            move.l  D0,-(SP)
            jsr     (NewSCPtr.w,PC)
            move.l  D0,($B60).w
            movea.l ($B60).w,A0
            move.b  #1,($32,A0)
            moveq   #$20,D0
            move.l  D0,-(SP)
            jsr     (NewSHandle.w,PC)
            movea.l ($B60).w,A0
            move.l  D0,($2A,A0)
            addq.l  #8,SP
            rts
            ds.b    6
_NMInstall_:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            moveq   #8,D0
            cmp.w   (4,A3),D0
            beq.b   .L1
            move.w  #$FED5,D0
            bra.b   .L2
.L1:
            clr.w   (6,A3)
            moveq   #0,D0
            move.l  D0,(8,A3)
            jsr     getpid
            move.w  D0,($C,A3)
            movea.l ($B60).w,A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            jsr     (Enqueue_2.w,PC)
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
            ds.b    6
_NMRemove_:
            movem.l D7/A3,-(SP)
            movea.l ($C,SP),A3
            moveq   #8,D0
            cmp.w   (4,A3),D0
            beq.b   .L1
            move.w  #$FED5,D0
            bra.b   .L4
.L1:
            movea.l ($B60).w,A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            jsr     (Dequeue_2.w,PC)
            move.w  D0,D7
            addq.l  #8,SP
            bne.b   .L3
            moveq   #$30,D0
            and.w   (6,A3),D0
            cmpi.w  #$10,D0
            bne.b   .L2
            movea.l ($B60).w,A0
            ori.w   #2,(A0)
.L2:
            move.l  A3,-(SP)
            jsr     UnLinkAuxRecs
            addq.l  #4,SP
.L3:
            move.w  D7,D0
.L4:
            movem.l (SP)+,D7/A3
            rts
            ds.b    4
AddrInRange:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A3
            move.l  A3,-(SP)
            jsr     (StripAddress_2.w,PC)
            movea.l D0,A3
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            jsr     (StripAddress_2.w,PC)
            addq.l  #4,SP
            move.l  D0,D1
            move.l  (SP)+,D0
            cmpa.l  D1,A3
            bcs.b   .L1
            move.l  D0,-(SP)
            move.l  ($10,A6),-(SP)
            jsr     (StripAddress_2.w,PC)
            addq.l  #4,SP
            move.l  D0,D1
            move.l  (SP)+,D0
            cmp.l   A3,D1
            bcs.b   .L1
            moveq   #1,D0
.L1:
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    4
CopyString:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            moveq   #0,D0
            move.b  (A3),D0
            addq.l  #1,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     (BlockMove_2.w,PC)
            lea     ($C,SP),SP
            movem.l (SP)+,A3-A4
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    6
FlushApplNM:
            movem.l D7/A3-A4,-(SP)
            move.l  SysZone,D0
            cmp.l   ApplZone,D0
            beq.b   .L4
            jsr     (disable.w,PC)
            move.l  D0,D7
            movea.l ($B60).w,A0
            movea.l (2,A0),A3
            bra.b   .L3
.L1:
            movea.l (A3),A4
            move.l  BufPtr,-(SP)
            move.l  ApplZone,-(SP)
            move.l  A3,-(SP)
            jsr     AddrInRange
            tst.b   D0
            lea     ($C,SP),SP
            beq.b   .L2
            move.l  A3,-(SP)
            jsr     (NMRemove.w,PC)
            addq.l  #4,SP
.L2:
            movea.l A4,A3
.L3:
            move.l  A3,D0
            bne.b   .L1
            move.l  D7,-(SP)
            jsr     (spl_.w,PC)
            addq.l  #4,SP
.L4:
            movem.l (SP)+,D7/A3-A4
            rts
            ds.b    14
NMFILTER:
            link.w  A6,#-$E
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #3,D0
            cmp.w   (A3),D0
            bne.b   .L3
            move.l  #$FF,D7
            and.l   (2,A3),D7
            cmpi.b  #3,D7
            beq.b   .L1
            cmpi.b  #$D,D7
            bne.b   .L3
.L1:
            move.l  A4,-(SP)
            moveq   #1,D0
            move.w  D0,-(SP)
            pea     (-$E,A6)
            pea     (-$C,A6)
            pea     (-8,A6)
            _GetDItem
            moveq   #4,D0
            cmp.w   (-$E,A6),D0
            bne.b   .L2
            move.l  (-$C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            _HiliteControl
            pea     (-8,A6)
            moveq   #8,D0
            move.l  D0,-(SP)
            jsr     (Delay_2.w,PC)
            move.l  (-$C,A6),-(SP)
            moveq   #0,D0
            move.w  D0,-(SP)
            _HiliteControl
            addq.l  #8,SP
.L2:
            movea.l (8,A6),A0
            move.w  #1,(A0)
            move.b  #1,($14,A6)
            bra.b   .L5
.L3:
            movea.l ($B60).w,A0
            moveq   #2,D0
            and.w   (A0),D0
            beq.b   .L4
            move.b  #1,($14,A6)
            bra.b   .L5
.L4:
            clr.b   ($14,A6)
.L5:
            movem.l (-$1A,A6),D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$C,SP
            jmp     (A0)
DEFBUTPROC:
            link.w  A6,#-$20
            move.l  A3,-(SP)
            movea.l ($A,A6),A3
            pea     (-$20,A6)
            _GetPenState
            moveq   #3,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            _PenSize
            move.l  A3,-(SP)
            move.w  (8,A6),-(SP)
            pea     (-$E,A6)
            pea     (-$C,A6)
            pea     (-8,A6)
            _GetDItem
            pea     (-8,A6)
            moveq   #$10,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            _FrameRoundRect
            pea     (-$20,A6)
            _SetPenState
            movea.l (-$24,A6),A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
            ds.b    6
FindItem:
            link.w  A6,#-$100
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            lea     (-$100,A6),A3
            subq.l  #2,SP
            move.l  A4,-(SP)
            _CountMItems
            move.w  (SP)+,D7
            bra.b   .L3
.L1:
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            move.l  A3,-(SP)
            _GetItem
            subq.l  #2,SP
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            moveq   #1,D1
            move.b  D1,-(SP)
            jsr     (equalstring.w,PC)
            tst.b   (SP)+
            beq.b   .L2
            move.w  D7,D0
            bra.b   .L4
.L2:
            subq.w  #1,D7
.L3:
            tst.w   D7
            bgt.b   .L1
            moveq   #0,D0
.L4:
            movem.l (-$10C,A6),D7/A3-A4
            unlk    A6
            rts
GetAppleMenu:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            moveq   #0,D0
            movea.l D0,A3
            move.l  MenuList,(-4,A6)
            beq.b   .L1
            movea.l (-4,A6),A0
            movea.l (A0),A4
            move.l  A4,D0
            beq.b   .L1
            tst.w   (A4)
            beq.b   .L1
            movea.l (6,A4),A3
            movea.l (A3),A0
            cmpi.w  #$114,($E,A0)
            beq.b   .L1
            moveq   #0,D0
            movea.l D0,A3
.L1:
            move.l  A3,D0
            movem.l (-$C,A6),A3-A4
            unlk    A6
            rts
CallMBarProc_2:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            movea.l MenuList,A3
            move.l  A3,D0
            beq.b   .L1
            movea.l (A3),A4
            move.l  A4,D0
            beq.b   .L1
            move.w  (4,A4),D7
            bra.b   .L2
.L1:
            moveq   #0,D0
            bra.b   .L4
.L2:
            move.w  #$FFFF,ROMMapInsert
            subq.l  #4,SP
            move.l  #'MBDF',-(SP)
            move.w  D7,-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L3
            move.l  A3,-(SP)
            jsr     (HGetState.w,PC)
            move.w  D0,D5
            move.l  A3,-(SP)
            jsr     (HLock_2.w,PC)
            subq.l  #4,SP
            moveq   #7,D0
            and.w   D7,D0
            move.w  D0,-(SP)
            move.w  ($A,A6),-(SP)
            move.w  ($E,A6),-(SP)
            move.l  ($10,A6),-(SP)
            movea.l (A3),A0
            jsr     (A0)
            move.l  (SP)+,D6
            ext.l   D5
            move.l  D5,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState.w,PC)
            move.l  D6,D0
            lea     ($10,SP),SP
            bra.b   .L4
.L3:
            moveq   #0,D0
.L4:
            movem.l (-$14,A6),D5-D7/A3-A4
            unlk    A6
            rts
            dc.w    0
SwapItemMarks:
            link.w  A6,#-2
            movem.l D7/A3,-(SP)
            move.w  ($C,A6),D7
            movea.l ($E,A6),A3
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            pea     (-2,A6)
            _GetItmMark
            move.w  (-2,A6),D0
            cmp.w   ($A,A6),D0
            bne.b   .L1
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            move.w  (8,A6),-(SP)
            _SetItmMark
.L1:
            movem.l (-$A,A6),D7/A3
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$A,SP
            jmp     (A0)
            dc.w    0
ClearMarks:
            movem.l D7/A3,-(SP)
            movea.l ($C,SP),A3
            subq.l  #2,SP
            move.l  A3,-(SP)
            _CountMItems
            move.w  (SP)+,D7
            bra.b   .L2
.L1:
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            subq.w  #1,D7
            moveq   #$13,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.w  D1,-(SP)
            jsr     SwapItemMarks
.L2:
            tst.w   D7
            bgt.b   .L1
            movem.l (SP)+,D7/A3
            rts
            dc.w    0
SWAPDAMARK:
            link.w  A6,#-$156
            movem.l D5-D7/A3-A4,-(SP)
            jsr     GetAppleMenu
            movea.l D0,A4
            move.l  A4,D0
            beq.w   .L6
            movea.l ($C,A6),A0
            move.w  ($C,A0),D5
            movea.l ($C,A6),A0
            move.w  ($E,A0),D6
            bge.b   .L1
            movea.l UTableBase,A0
            move.w  D6,D0
            not.w   D0
            ext.l   D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),D0
            bra.b   .L2
.L1:
            moveq   #0,D0
.L2:
            movea.l D0,A3
            clr.w   D7
            ext.l   D5
            moveq   #-1,D0
            cmp.l   D5,D0
            beq.b   .L4
            move.l  A3,D0
            beq.b   .L3
            movea.l SysZone,A0
            move.l  (A0),-(SP)
            move.l  SysZone,-(SP)
            movea.l (A3),A0
            move.l  (A0),-(SP)
            jsr     AddrInRange
            tst.b   D0
            lea     ($C,SP),SP
            bne.b   .L3
            jsr     getpid
            cmp.w   D5,D0
            beq.b   .L3
            moveq   #0,D0
            movea.l D0,A3
.L3:
            move.l  A3,D0
            bne.b   .L4
            subq.l  #4,SP
            move.w  D5,-(SP)
            pea     (-$156,A6)
            moveq   #$17,D0
            move.w  D0,-(SP)
            _OSDispatch
            pea     (-$128,A6)
            move.l  A4,-(SP)
            jsr     FindItem
            move.w  D0,D7
            lea     ($C,SP),SP
.L4:
            move.l  A3,D0
            beq.b   .L5
            move.w  #$FFFF,ROMMapInsert
            subq.l  #4,SP
            move.l  #'DRVR',-(SP)
            move.w  D6,D0
            not.w   D0
            move.w  D0,-(SP)
            _GetResource
            pea     (-$106,A6)
            pea     (-$104,A6)
            pea     (-$100,A6)
            _GetResInfo
            pea     (-$100,A6)
            move.l  A4,-(SP)
            jsr     FindItem
            move.w  D0,D7
            addq.l  #8,SP
.L5:
            tst.w   D7
            beq.b   .L6
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            move.l  (8,A6),-(SP)
            jsr     SwapItemMarks
.L6:
            movem.l (-$16A,A6),D5-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    10
MarkItem:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            tst.w   ($E,A4)
            beq.b   .L1
            move.l  A4,-(SP)
            jsr     InsertMarkRec
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #4,SP
            beq.b   .L2
            ori.w   #1,(6,A4)
            move.l  ($C,A6),-(SP)
            jsr     (spl_.w,PC)
            move.l  A3,-(SP)
            moveq   #0,D0
            move.w  D0,-(SP)
            moveq   #$13,D1
            move.w  D1,-(SP)
            jsr     SWAPDAMARK
            addq.l  #4,SP
            bra.b   .L2
.L1:
            ori.w   #1,(6,A4)
.L2:
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
RotateIcon:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            tst.l   ($10,A3)
            beq.b   .L1
            move.l  A3,-(SP)
            jsr     InsertIconRec
            tst.l   D0
            addq.l  #4,SP
            beq.b   .L2
            ori.w   #2,(6,A3)
            bra.b   .L2
.L1:
            ori.w   #2,(6,A3)
.L2:
            movea.l (-4,A6),A3
            unlk    A6
            rts
            ds.b    14
DoSound:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($14,A4),A3
            ori.w   #8,(6,A4)
            move.l  A3,D0
            beq.b   .L2
            move.l  ($C,A6),-(SP)
            jsr     (spl_.w,PC)
            cmpa.l  #$FFFFFFFF,A3
            addq.l  #4,SP
            bne.b   .L1
            moveq   #3,D0
            move.w  D0,-(SP)
            _SysBeep
            bra.b   .L2
.L1:
            subq.l  #2,SP
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            moveq   #0,D1
            move.b  D1,-(SP)
            _SndPlay
            addq.l  #2,SP
.L2:
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            dc.w    0
DoDialog:
            link.w  A6,#-$118
            movem.l D5-D7/A3-A4,-(SP)
            move.l  ($C,A6),D5
            movea.l (8,A6),A0
            tst.l   ($18,A0)
            bne.b   .L1
            movea.l (8,A6),A0
            ori.w   #$30,(6,A0)
            bra.w   .L11
.L1:
            movea.l ($B60).w,A0
            move.w  (A0),D0
            btst    #0,D0
            beq.b   .L2
            movea.l (8,A6),A0
            ori.w   #$80,(6,A0)
            bra.w   .L11
.L2:
            movea.l ($B60).w,A0
            ori.w   #1,(A0)
            movea.l (8,A6),A0
            ori.w   #$90,(6,A0)
            movea.l (8,A6),A0
            move.l  ($18,A0),-(SP)
            pea     (-$110,A6)
            jsr     CopyString
            move.l  D5,-(SP)
            jsr     (spl_.w,PC)
            _InitCursor
            pea     (-$114,A6)
            _GetPort
            subq.l  #2,SP
            _CurResFile
            move.w  (SP)+,D6
            moveq   #0,D0
            move.w  D0,-(SP)
            _UseResFile
            subq.l  #4,SP
            moveq   #1,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.l  D1,-(SP)
            moveq   #-1,D0
            move.l  D0,-(SP)
            _GetNewDialog
            movea.l (SP)+,A3
            move.w  D6,-(SP)
            _UseResFile
            move.l  A3,-(SP)
            moveq   #2,D0
            move.w  D0,-(SP)
            pea     (-$10,A6)
            pea     (-$C,A6)
            pea     (-8,A6)
            _GetDItem
            move.l  A3,-(SP)
            moveq   #2,D0
            move.w  D0,-(SP)
            move.w  (-$10,A6),-(SP)
            pea     DEFBUTPROC
            pea     (-8,A6)
            _SetDItem
            move.l  A3,-(SP)
            moveq   #3,D0
            move.w  D0,-(SP)
            pea     (-$10,A6)
            pea     (-$C,A6)
            pea     (-8,A6)
            _GetDItem
            move.l  (-$C,A6),-(SP)
            pea     (-$110,A6)
            _SetIText
            movea.l WMgrPort,A0
            lea     ($10,A0),A0
            move.l  A0,(-$118,A6)
            move.w  (A0),D0
            ext.l   D0
            tst.w   ROM85
            addq.l  #4,SP
            bge.b   .L3
            moveq   #$14,D1
            bra.b   .L4
.L3:
            move.w  MBarHeight,D1
            ext.l   D1
.L4:
            move.l  D1,D7
            add.l   D0,D7
            lea     ($10,A3),A4
            move.l  A3,-(SP)
            movea.l (-$118,A6),A0
            movea.l (-$118,A6),A1
            move.w  (2,A1),D0
            add.w   (6,A0),D0
            sub.w   (6,A4),D0
            move.w  (2,A4),D1
            add.w   D0,D1
            ext.l   D1
            asr.l   #1,D1
            move.w  D1,-(SP)
            movea.l (-$118,A6),A0
            move.w  (4,A0),D0
            sub.w   D7,D0
            sub.w   (4,A4),D0
            move.w  (A4),D1
            add.w   D0,D1
            ext.l   D1
            asr.l   #2,D1
            ext.l   D7
            add.l   D7,D1
            move.w  D1,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            _MoveWindow
            move.l  A3,-(SP)
            _ShowWindow
            pea     NMFILTER
            pea     (-$E,A6)
            _ModalDialog
            jsr     (disable.w,PC)
            move.l  D0,D5
            movea.l ($B60).w,A0
            moveq   #2,D0
            and.w   (A0),D0
            bne.b   .L5
            movea.l (8,A6),A0
            ori.w   #$20,(6,A0)
            movea.l (8,A6),A0
            andi.w  #$FF7F,(6,A0)
            bra.b   .L6
.L5:
            movea.l ($B60).w,A0
            andi.w  #$FFFD,(A0)
.L6:
            movea.l ($B60).w,A0
            move.l  (2,A0),(8,A6)
            bra.b   .L9
.L7:
            movea.l (8,A6),A0
            move.w  #$90,D0
            and.w   (6,A0),D0
            cmpi.w  #$80,D0
            bne.b   .L8
            movea.l (8,A6),A0
            andi.w  #$FF7F,(6,A0)
            bra.b   .L10
.L8:
            movea.l (8,A6),A0
            move.l  (A0),(8,A6)
.L9:
            tst.l   (8,A6)
            bne.b   .L7
.L10:
            move.l  D5,-(SP)
            jsr     (spl_.w,PC)
            move.l  A3,-(SP)
            _DisposDialog
            move.l  (-$114,A6),-(SP)
            _SetPort
            movea.l ($B60).w,A0
            andi.w  #$FFFE,(A0)
            addq.l  #4,SP
.L11:
            movem.l (-$12C,A6),D5-D7/A3-A4
            unlk    A6
            rts
            ds.b    4
DoRespProc:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($1C,A4),A3
            ori.w   #$40,(6,A4)
            move.l  A3,D0
            beq.b   .L2
            cmpa.l  #$FFFFFFFF,A3
            bne.b   .L1
            move.l  A4,-(SP)
            jsr     (NMRemove.w,PC)
            addq.l  #4,SP
            bra.b   .L2
.L1:
            move.l  ($C,A6),-(SP)
            jsr     (spl_.w,PC)
            move.l  A4,-(SP)
            jsr     (A3)
            addq.l  #4,SP
.L2:
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    12
NMGNEFILTER:
            movem.l D7/A3-A4,-(SP)
            movea.l ($B60).w,A0
            movea.l ($1E,A0),A3
            moveq   #3,D0
            and.b   AlarmSt,D0
            bne.b   .L2
            move.l  A3,D0
            bne.w   .L3
            move.w  #$FFFF,ROMMapInsert
            subq.l  #4,SP
            move.l  #'SICN',-(SP)
            move.w  #$BFFF,-(SP)
            _GetResource
            movea.l (SP)+,A4
            move.l  A4,D0
            beq.b   .L3
            move.l  A4,-(SP)
            jsr     (GetHandleSize_2.w,PC)
            move.l  D0,D7
            moveq   #$24,D0
            move.l  D0,-(SP)
            jsr     (NewSCPtr.w,PC)
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #8,SP
            beq.b   .L1
            move.l  D7,-(SP)
            jsr     (NewSHandle.w,PC)
            move.l  D0,($10,A3)
            addq.l  #4,SP
            beq.b   .L1
            move.l  D7,-(SP)
            movea.l ($10,A3),A0
            move.l  (A0),-(SP)
            move.l  (A4),-(SP)
            jsr     (BlockMove_2.w,PC)
            move.w  #8,(4,A3)
            moveq   #-1,D0
            move.l  D0,($14,A3)
            move.l  A3,-(SP)
            jsr     (NMInstall.w,PC)
            movea.l ($B60).w,A0
            move.l  A3,($1E,A0)
            lea     ($10,SP),SP
.L1:
            move.l  A4,-(SP)
            _ReleaseResource
            bra.b   .L3
.L2:
            move.l  A3,D0
            beq.b   .L3
            move.l  A3,-(SP)
            jsr     (NMRemove.w,PC)
            move.l  ($10,A3),-(SP)
            jsr     (DisposHandle.w,PC)
            movea.l ($B60).w,A0
            moveq   #0,D0
            move.l  D0,($1E,A0)
            addq.l  #8,SP
.L3:
            movem.l (SP)+,D7/A3-A4
            rts
NMTask:
            link.w  A6,#-4
            movem.l D4-D7/A3-A4,-(SP)
            jsr     (disable.w,PC)
            move.l  D0,D7
            movea.l ($B60).w,A0
            movea.l (2,A0),A4
            bra.b   .L2
.L1:
            movea.l (A4),A4
.L2:
            move.l  A4,D0
            beq.b   .L3
            move.w  #$80,D0
            and.w   (6,A4),D0
            bne.b   .L1
.L3:
            move.l  A4,D0
            beq.b   .L9
            move.w  (6,A4),D6
            moveq   #1,D0
            and.w   D6,D0
            bne.b   .L4
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            jsr     MarkItem
            addq.l  #8,SP
            bra.b   .L9
.L4:
            moveq   #2,D0
            and.w   D6,D0
            bne.b   .L5
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            jsr     RotateIcon
            addq.l  #8,SP
            bra.b   .L9
.L5:
            moveq   #8,D0
            and.w   D6,D0
            bne.b   .L6
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            jsr     DoSound
            addq.l  #8,SP
            bra.b   .L9
.L6:
            moveq   #$10,D0
            and.w   D6,D0
            bne.b   .L7
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            jsr     DoDialog
            addq.l  #8,SP
            bra.b   .L9
.L7:
            moveq   #$40,D0
            and.w   D6,D0
            bne.b   .L8
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            jsr     DoRespProc
            addq.l  #8,SP
            bra.b   .L9
.L8:
            ori.w   #$8080,(6,A4)
.L9:
            move.l  D7,-(SP)
            jsr     (spl_.w,PC)
            movea.l ($B60).w,A0
            pea     ($A,A0)
            moveq   #$10,D0
            move.l  D0,-(SP)
            jsr     AddAuxRec
            movea.l ($B60).w,A0
            pea     ($14,A0)
            moveq   #$10,D0
            move.l  D0,-(SP)
            jsr     AddAuxRec
            jsr     GetAppleMenu
            movea.l D0,A4
            movea.l ($B60).w,A0
            movea.l ($C,A0),A3
            move.l  A4,D0
            lea     ($14,SP),SP
            beq.b   .L13
            movea.l ($B60).w,A0
            cmpa.l  ($22,A0),A4
            beq.b   .L13
            move.l  A4,-(SP)
            jsr     ClearMarks
            addq.l  #4,SP
            bra.b   .L13
.L10:
            move.l  (A3),(-4,A6)
            tst.w   (4,A3)
            beq.b   .L12
            tst.w   (6,A3)
            bne.b   .L11
            move.l  A3,-(SP)
            moveq   #$13,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.w  D1,-(SP)
            jsr     SWAPDAMARK
            movea.l ($B60).w,A0
            pea     ($A,A0)
            move.l  A3,-(SP)
            jsr     (Dequeue_2.w,PC)
            move.l  A3,-(SP)
            jsr     (DisposPtr.w,PC)
            lea     ($C,SP),SP
            bra.b   .L12
.L11:
            move.l  A4,D0
            beq.b   .L12
            movea.l ($B60).w,A0
            cmpa.l  ($22,A0),A4
            beq.b   .L12
            move.l  A3,-(SP)
            moveq   #0,D0
            move.w  D0,-(SP)
            moveq   #$13,D1
            move.w  D1,-(SP)
            jsr     SWAPDAMARK
.L12:
            movea.l (-4,A6),A3
.L13:
            move.l  A3,D0
            bne.b   .L10
            movea.l ($B60).w,A0
            move.l  A4,($22,A0)
            move.l  Ticks,D4
            movea.l ($B60).w,A0
            move.l  D4,D5
            sub.l   ($2E,A0),D5
            moveq   #1,D0
            cmp.l   D5,D0
            bgt.w   .L19
            movea.l ($B60).w,A0
            movea.l ($26,A0),A3
            movea.l ($B60).w,A0
            tst.b   ($32,A0)
            beq.b   .L16
            moveq   #$3C,D0
            cmp.l   D5,D0
            bgt.b   .L19
            move.l  A3,D0
            beq.b   .L14
            move.l  (A3),D0
            bra.b   .L15
.L14:
            movea.l ($B60).w,A0
            move.l  ($16,A0),D0
.L15:
            move.l  D0,-(SP)
            jsr     ValidIconRec
            movea.l D0,A4
            cmpa.l  A4,A3
            addq.l  #4,SP
            beq.b   .L19
            movea.l A4,A3
            movea.l ($B60).w,A0
            move.l  A3,($26,A0)
            move.l  A3,D0
            beq.b   .L16
            moveq   #$20,D0
            move.l  D0,-(SP)
            movea.l ($B60).w,A0
            movea.l ($2A,A0),A0
            move.l  (A0),-(SP)
            movea.l ($C,A3),A0
            move.l  (A0),-(SP)
            jsr     (BlockMove_2.w,PC)
            lea     ($C,SP),SP
.L16:
            movea.l ($B60).w,A0
            move.l  D4,($2E,A0)
            move.l  A3,D0
            beq.b   .L17
            movea.l ($B60).w,A0
            movea.l ($2A,A0),A0
            bra.b   .L18
.L17:
            movea.w #0,A0
.L18:
            move.l  A0,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #$D,D1
            move.l  D1,-(SP)
            jsr     CallMBarProc_2
            movea.l ($B60).w,A0
            move.b  D0,($32,A0)
            lea     ($C,SP),SP
.L19:
            movem.l (-$1C,A6),D4-D7/A3-A4
            unlk    A6
            rts
            ds.b    8

            EVEN
