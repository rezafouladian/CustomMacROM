PackRgn:
            link.w  A6,#-8
            movem.l D0-D7/A1-A4,-(SP)
            movea.l ($E,A6),A4
            movea.l (8,A6),A3
            move.w  ($C,A6),D6
            movea.l (A3),A1
            move.w  (A1),D5
            movea.l (A4),A0
            moveq   #$A,D7
            clr.l   (-8,A6)
            clr.l   (-4,A6)
            cmpi.w  #4,D6
            bgt.b   .L1
            blt.b   .L8
            move.l  (A0),(-8,A6)
            move.l  ($C,A0),(-4,A6)
            bra.b   .L8
.L1:
            move.w  (A0),(-8,A6)
            move.w  (2,A0),D1
            move.w  D1,D2
            move.w  D6,D3
.L2:
            subq.w  #1,D3
            blt.b   .L4
            move.l  (A0)+,D0
            cmp.w   D1,D0
            bge.b   .L3
            move.w  D0,D1
            bra.b   .L2
.L3:
            cmp.w   D2,D0
            ble.b   .L2
            move.w  D0,D2
            bra.b   .L2
.L4:
            move.w  D1,(-6,A6)
            move.w  D2,(-2,A6)
            move.w  (-4,A0),(-4,A6)
            moveq   #3,D5
            add.w   D6,D5
            lsl.w   #2,D5
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            bsr.l   SetHSize
            movea.l (A4),A0
            movea.l (A3),A1
            adda.w  D7,A1
            subq.w  #1,D6
            move.w  (A0)+,D0
            move.w  #$7FFF,D1
            bra.b   .L6
.L5:
            cmp.w   (A0)+,D0
            beq.b   .L7
            move.w  D1,(A1)+
            move.w  (-2,A0),D0
.L6:
            move.w  D0,(A1)+
.L7:
            move.w  (A0)+,(A1)+
            dbra    D6,.L5
            move.w  D1,(A1)+
            move.w  D1,(A1)+
            movea.l (A3),A0
            suba.l  A0,A1
            move.w  A1,D7
.L8:
            movea.l (A3),A0
            move.w  D7,(A0)+
            move.l  (-8,A6),(A0)+
            move.l  (-4,A6),(A0)+
            cmp.w   D7,D5
            beq.b   .L9
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            bsr.l   SetHSize
.L9:
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            rtd     #$A
            ds.b    8
