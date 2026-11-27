DivUp:
            divu.w  D1,D0
            swap    D0
            tst.w   D0
            beq.b   .L1
            clr.w   D0
            swap    D0
            addq.w  #1,D0
            bra.b   .L2
.L1:
            swap    D0
.L2:
            rts
RoundAlloc:
            move.l  D1,-(SP)
            move.l  D0,-(SP)
            move.l  D1,D0
            move.l  ($1C,A2),D1
            bsr.b   DivUp
            move.l  D0,D1
            move.l  (SP)+,D0
            move.l  D1,-(SP)
            move.l  ($1C,A2),D1
            bsr.b   DivUp
            move.l  (SP)+,D1
            bsr.b   DivUp
            mulu.w  D1,D0
            move.l  (SP)+,D1
            rts
QWordSearch:
            move.l  D2,-(SP)
            move.l  (2,A0),D2
.L1:
            beq.b   .L4
            movea.l D2,A0
            cmp.w   (0,A0,D1.w),D0
            beq.b   .L2
            move.l  (A0),D2
            bra.b   .L1
.L2:
            moveq   #0,D0
.L3:
            move.l  (SP)+,D2
            tst.w   D0
            rts
.L4:
            moveq   #-1,D0
            bra.b   .L3
GetVCBRfn:
            movem.l D1/A0,-(SP)
            moveq   #$4E,D1
            lea     ($356).w,A0
            bsr.b   QWordSearch
            bne.b   .L2
            movea.l A0,A2
.L1:
            movem.l (SP)+,D1/A0
            rts
.L2:
            moveq   #-$23,D0
            bra.b   .L1
GetVCBDrv:
            movem.l D1-D2,-(SP)
            move.w  D0,D1
            move.w  D0,D2
            neg.w   D2
            movea.l ($358).w,A2
.L1:
            move.l  A2,D0
            beq.b   .L5
            cmp.w   ($48,A2),D1
            beq.b   .L3
            tst.w   ($48,A2)
            bne.b   .L2
            cmp.w   ($4A,A2),D2
            beq.b   .L3
.L2:
            movea.l (A2),A2
            bra.b   .L1
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1-D2
            rts
.L5:
            moveq   #-$23,D0
            bra.b   .L4
sub_4080F4FA:
            movea.l ($372).w,A3
            movem.l D1/A1,-(SP)
            moveq   #0,D1
            move.w  D0,D1
            bsr.w   sub_40810604
            bne.b   .L1
            subi.w  #$8001,D1
            adda.w  D1,A3
            moveq   #-$23,D0
            move.l  (A3),D1
            beq.b   .L1
            movea.l D1,A2
            moveq   #0,D0
.L1:
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
MarkVCB:
            bsr.b   sub_4080F52E
MarkVCBTime:
            move.l  TimeLM,($E,A2)
            rts
sub_4080F52E:
            st      (6,A2)
            rts
FlushMDB:
            move.l  ($6D0).w,-(SP)
            rts
vFlushMDB:
            move.l  (SP)+,-(A6)
            movem.l D0-D2/A0-A1,-(A6)
            tst.b   (6,A2)
            bpl.w   .L1
            movea.l ($54,A2),A1
            move.w  ($4E,A2),D0
            moveq   #0,D1
            moveq   #2,D2
            jsr     (GetBlock.w,PC)
            bne.w   .L1
            movea.l A0,A1
            lea     (8,A2),A0
            move.l  #$A2,D0
            _BlockMove
            lea     ($5E,A2),A0
            lea     ($40,A1),A1
            moveq   #$42,D0
            _BlockMove
            suba.w  #$40,A1
            movea.l ($34E).w,A3
            move.w  ($A4,A2),D1
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($26,A3,D1.w),A0
            lea     ($86,A1),A1
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  ($C,A3,D1.w),D0
            move.l  D0,($82,A1)
            bclr    #7,(4,A3,D1.w)
            move.l  ($1C,A2),D1
            jsr     DivUp
            move.w  D0,($A0,A2)
            move.w  ($A6,A2),D1
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($26,A3,D1.w),A0
            lea     ($96,A1),A1
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  ($C,A3,D1.w),D0
            move.l  D0,($92,A1)
            bclr    #7,(4,A3,D1.w)
            move.l  ($1C,A2),D1
            jsr     DivUp
            move.w  D0,($A2,A2)
            moveq   #1,D1
            movea.l A1,A0
            movea.l ($54,A2),A1
            jsr     (RelBlock.w,PC)
            clr.b   (6,A2)
.L1:
            movem.l (A6)+,D0-D2/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
