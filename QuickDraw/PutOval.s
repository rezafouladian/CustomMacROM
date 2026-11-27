PutOval:
            link.w  A6,#-$36
            movem.l D0-D7/A1-A5,-(SP)
            movea.l ($18,A6),A0
            lea     (-$2E,A6),A1
            move.w  ($16,A6),D2
            move.w  ($14,A6),D1
            bsr.l   InitOval
            move.w  (-$C,A6),(-$34,A6)
            move.w  (-8,A6),(-$36,A6)
            move.w  ($14,A6),D0
            asr.w   #1,D0
            add.w   (-$2E,A6),D0
            move.w  D0,(-$30,A6)
            movea.l ($18,A6),A0
            add.w   (4,A0),D0
            sub.w   (A0),D0
            sub.w   ($14,A6),D0
            move.w  D0,(-$32,A6)
            movea.l ($10,A6),A3
            movea.l (A3),A3
            movea.l A3,A2
            movea.l ($C,A6),A0
            adda.w  (A0),A3
            movea.l A2,A1
            movea.l (8,A6),A0
            adda.w  (A0),A1
            move.w  (-$2E,A6),D6
            move.w  (-$34,A6),D5
            bsr.w   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
.L1:
            cmp.w   (-$30,A6),D6
            blt.b   .L2
            cmp.w   (-$32,A6),D6
            blt.b   .L4
.L2:
            movem.l D6/A1-A3,-(SP)
            lea     (-$2E,A6),A3
            move.w  D6,D0
            bsr.l   BumpOval
            movem.l (SP)+,D6/A1-A3
            move.w  (-$C,A6),D5
            cmp.w   (-$34,A6),D5
            beq.b   .L3
            bsr.b   PUTPT
            move.w  (-$34,A6),D5
            bsr.b   PUTPT
            move.w  (-$C,A6),(-$34,A6)
.L3:
            move.w  (-8,A6),D5
            cmp.w   (-$36,A6),D5
            beq.b   .L4
            bsr.b   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
            move.w  (-8,A6),(-$36,A6)
.L4:
            addq.w  #1,D6
            cmp.w   (-$2C,A6),D6
            blt.b   .L1
            move.w  (-$34,A6),D5
            bsr.b   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
            suba.l  A2,A3
            movea.l ($C,A6),A0
            move.w  A3,(A0)
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$14
PUTPT:
            cmpa.l  A1,A3
            blt.b   .L2
            suba.l  A2,A3
            suba.l  A2,A1
            cmpa.l  #$FC00,A1
            blt.b   .L1
            adda.l  A2,A3
            adda.l  A2,A1
            move.w  #$FF6D,QDErr
            rts
.L1:
            lea     ($400,A1),A1
            movem.l D0-D7/A0-A3,-(SP)
            movea.l (8,A6),A0
            move.w  A1,(A0)
            move.l  ($10,A6),-(SP)
            move.w  A1,-(SP)
            bsr.l   SetHSize
            movem.l (SP)+,D0-D7/A0-A3
            movea.l ($10,A6),A2
            movea.l (A2),A2
            adda.l  A2,A3
            adda.l  A2,A1
.L2:
            cmpa.l  A2,A3
            beq.b   .L3
            cmp.w   (-2,A3),D5
            bne.b   .L3
            cmp.w   (-4,A3),D6
            bne.b   .L3
            subq.w  #4,A3
            rts
.L3:
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            rts
            ds.b    10
