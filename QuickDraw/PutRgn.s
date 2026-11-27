PutRgn:
            link.w  A6,#0
            movem.l D7/A2-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($14,A6),A3
            movea.l ($C,A6),A2
            movea.l (A3),A0
            moveq   #0,D7
            move.w  (A0),D7
            add.l   D7,D7
            moveq   #0,D0
            move.w  (A2),D0
            add.l   D0,D7
            cmpi.l  #$FF00,D7
            blt.b   .L1
            move.w  #$FF6D,QDErr
            bra.w   .L7
.L1:
            movea.l (8,A6),A1
            cmp.w   (A1),D7
            bls.b   .L2
            addi.w  #$100,D7
            move.w  D7,(A1)
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            bsr.l   SetHSize
            movea.l (A3),A0
            movea.l ($C,A6),A2
.L2:
            movea.l (A4),A1
            moveq   #0,D0
            move.w  (A2),D0
            adda.l  D0,A1
            cmpi.w  #$A,(A0)
            bne.b   .L3
            addq.w  #2,A0
            move.l  (A0),(A1)+
            move.w  (A0)+,(A1)+
            move.w  (A0)+,D0
            move.l  (A0),D1
            move.w  D1,(A1)+
            move.w  (A0),(A1)+
            move.w  D0,(A1)+
            move.l  D1,(A1)+
            bra.b   .L6
.L3:
            lea     ($A,A0),A0
.L4:
            move.l  (A0)+,D7
.L5:
            move.l  D7,(A1)+
            move.w  (A0)+,D7
            move.l  D7,(A1)+
            move.w  (A0)+,D7
            cmpi.w  #$7FFF,D7
            bne.b   .L5
            cmpi.w  #$7FFF,(A0)
            bne.b   .L4
.L6:
            suba.l  (A4),A1
            move.w  A1,(A2)
.L7:
            movem.l (SP)+,D7/A2-A4
            unlk    A6
            rtd     #$10
            ds.b    4
