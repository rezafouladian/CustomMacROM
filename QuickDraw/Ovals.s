StdOval:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            bsr.l   PutPicVerb
            moveq   #$50,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  (8,A6),-(SP)
            bsr.l   PutPicRect
.L1:
            pea     StdDraw_Ovals
            pea     GetRect_Ovals
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
GetRect_Ovals:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Ovals:
            movea.l (8,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-4,A6)
            move.l  A0,-(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  A0,-(SP)
            move.l  (-4,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A68.w])
.L1:
            move.b  #1,-(SP)
            bra.b   .L3
.L2:
            clr.b   -(SP)
.L3:
            move.l  (-4,A6),-(SP)
            jsr     ([$1A60.w])
            clr.w   -(SP)
            move.w  #$168,-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    14
FrameOval:
            moveq   #0,D0
            bra.b   CallOval
PaintOval:
            moveq   #1,D0
            bra.b   CallOval
EraseOval:
            moveq   #2,D0
            bra.b   CallOval
InvertOval:
            moveq   #3,D0
            bra.b   CallOval
FillOval:
            moveq   #0,D0
            bra.b   FillCOval.L1
FillCOval:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallOval:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($10D8).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($10,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
