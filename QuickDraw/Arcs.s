StdArc:
            link.w  A6,#-4
            movem.l D4/D7/A3-A4,-(SP)
            move.b  ($10,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            bsr.l   PutPicVerb
            moveq   #$60,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  ($C,A6),-(SP)
            bsr.l   PutPicRect
            move.w  ($A,A6),-(SP)
            bsr.l   PutPicWord
            move.w  (8,A6),-(SP)
            bsr.l   PutPicWord
.L1:
            pea     sub_4083BB98
            pea     GetRect_Arcs
            jsr     ([$1AA0.w])
            movem.l (SP)+,D4/D7/A3-A4
            unlk    A6
            rtd     #$A
GetRect_Arcs:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l ($C,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
sub_4083BB98:
            movea.l ($C,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-4,A6)
            move.l  A0,-(SP)
            clr.b   -(SP)
            tst.b   D7
            bne.b   .L1
            move.b  #1,(SP)
.L1:
            move.l  (-4,A6),-(SP)
            jsr     ([$1A60.w])
            move.w  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    8
FrameArc:
            moveq   #0,D0
            bra.b   CallArc
PaintArc:
            moveq   #1,D0
            bra.b   CallArc
EraseArc:
            moveq   #2,D0
            bra.b   CallArc
InvertArc:
            moveq   #3,D0
            bra.b   CallArc
FillArc:
            moveq   #0,D0
            bra.b   FillCArc.L1
FillCArc:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallArc:
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
            movea.l ($10F4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($14,A0),A0
.L1:
            jmp     (A0)
            ds.b    6
