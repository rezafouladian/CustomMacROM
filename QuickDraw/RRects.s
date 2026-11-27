StdRRect:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            move.b  ($10,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L2
            move.b  D7,-(SP)
            jsr     PutPicVerb
            movea.l ($5C,A3),A0
            movea.l (A0),A0
            move.l  (8,A6),D0
            cmp.l   ($52,A0),D0
            beq.b   .L1
            move.l  D0,($52,A0)
            move.l  D0,-(SP)
            moveq   #$B,D0
            jsr     DPutPicOp
            jsr     PutPicLong
.L1:
            moveq   #$40,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     PutPicRect
.L2:
            pea     sub_408345E0
            pea     GetRect_RRects
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #$A
GetRect_RRects:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l ($C,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
sub_408345E0:
            move.l  ($C,A6),-(SP)
            clr.b   -(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A68.w])
.L1:
            move.b  #1,(SP)
.L2:
            move.l  (8,A6),-(SP)
            jsr     ([$1A60.w])
            clr.w   -(SP)
            move.w  #$168,-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    10
FrameRoundRect:
            moveq   #0,D0
            bra.b   CallRRect
PaintRoundRect:
            moveq   #1,D0
            bra.b   CallRRect
EraseRoundRect:
            moveq   #2,D0
            bra.b   CallRRect
InvertRoundRect:
            moveq   #3,D0
            bra.b   CallRRect
FillRoundRect:
            moveq   #0,D0
            bra.b   FillCRoundRect.L1
FillCRoundRect:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallRRect:
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  D1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($10BC).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($C,A0),A0
.L1:
            jmp     (A0)
            ds.b    6
