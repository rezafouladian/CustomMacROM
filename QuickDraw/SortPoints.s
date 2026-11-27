SortPoints:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($A,A6),A3
            move.w  A3,D3
            andi.w  #3,D3
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.b   .L12
            lsl.l   #2,D0
            movea.l A3,A4
            adda.l  D0,A4
            subq.w  #4,A4
            move.l  SP,D4
            movem.l A3-A4,-(SP)
.L1:
            movem.l (SP)+,A3-A4
.L2:
            movea.l A3,A1
            movea.l A4,A2
            move.l  A3,D0
            add.l   A4,D0
            roxr.l  #1,D0
            andi.w  #$FFFC,D0
            or.w    D3,D0
            movea.l D0,A0
            move.w  (2,A0),D1
            move.w  (A0),D2
.L3:
            bra.b   .L5
.L4:
            addq.w  #4,A1
.L5:
            cmp.w   (A1),D2
            bgt.b   .L4
            blt.b   .L6
            cmp.w   (2,A1),D1
            bgt.b   .L4
.L6:
            bra.b   .L8
.L7:
            subq.w  #4,A2
.L8:
            cmp.w   (A2),D2
            blt.b   .L7
            bgt.b   .L9
            cmp.w   (2,A2),D1
            blt.b   .L7
.L9:
            cmpa.l  A2,A1
            bgt.b   .L10
            move.l  (A1),D0
            move.l  (A2),(A1)+
            move.l  D0,(A2)
            subq.w  #4,A2
.L10:
            cmpa.l  A2,A1
            bls.b   .L3
            cmpa.l  A4,A1
            bcc.b   .L11
            movem.l A1/A4,-(SP)
.L11:
            movea.l A2,A4
            cmpa.l  A4,A3
            bcs.b   .L2
            cmpa.l  D4,SP
            bne.b   .L1
.L12:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #6
CullPoints:
            link.w  A6,#0
            movem.l D0-D7/A1-A5,-(SP)
            movea.l (8,A6),A0
            move.w  (A0),D0
            ble.b   .L5
            movea.l ($C,A6),A1
            movea.l A1,A3
            ext.l   D0
            lsl.l   #2,D0
            adda.l  D0,A3
            subq.w  #4,A3
            move.l  A1,D5
            movea.l A1,A2
            bra.b   .L3
.L1:
            addq.w  #4,A1
            bra.b   .L3
.L2:
            move.l  (A1)+,D0
            cmp.l   (A1),D0
            beq.b   .L1
            move.l  D0,(A2)+
.L3:
            cmpa.l  A3,A1
            blt.b   .L2
            bgt.b   .L4
            move.l  (A1)+,(A2)+
.L4:
            move.l  A2,D0
            sub.l   D5,D0
            lsr.w   #2,D0
            movea.l (8,A6),A0
            move.w  D0,(A0)
.L5:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #8
            dc.w    0
