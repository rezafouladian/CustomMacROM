RgnOp:
            link.w  A6,#-$56
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$56,A6)
            lea     (-$4E,A6),A2
            lea     ($18,A6),A0
            bsr.w   EXPAND
            movea.l A0,A3
            lea     ($14,A6),A0
            bsr.w   EXPAND
            movea.l A0,A4
            lea     SectScan,A0
            move.w  ($C,A6),D0
            beq.b   .L1
            lea     DiffScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     UnionScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     XorScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     InsetScan,A0
.L1:
            move.l  A0,(-$52,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            subi.l  #$640,D0
            cmpi.l  #$C8,D0
            bge.b   .L2
            move.w  #$28,D0
            bra.b   .L4
.L2:
            divs.w  #5,D0
            bvc.b   .L3
            move.w  #$7530,D0
.L3:
            bclr    #0,D0
.L4:
            suba.w  D0,SP
            move.l  SP,(-4,A6)
            suba.w  D0,SP
            move.l  SP,(-8,A6)
            suba.w  D0,SP
            move.l  SP,(-$C,A6)
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            suba.w  D0,SP
            move.l  SP,(-$14,A6)
            movea.l ($10,A6),A0
            movea.l (A0),A0
            move.l  A0,(-$1E,A6)
            andi.w  #$FFF8,($E,A6)
            moveq   #0,D4
            move.w  ($E,A6),D4
            adda.l  D4,A0
            move.l  A0,(-$22,A6)
            movea.l (-4,A6),A0
            move.l  A0,D4
            move.w  #$7FFF,D0
            move.w  D0,(A0)
            movea.l (-8,A6),A0
            move.l  A0,D5
            move.w  D0,(A0)
            movea.l (-$C,A6),A0
            move.l  A0,D6
            move.w  D0,(A0)
            movea.l (-$10,A6),A0
            move.l  A0,D7
            move.w  (A3)+,(-$16,A6)
            move.w  (A4)+,(-$18,A6)
            cmpi.w  #8,($C,A6)
            bne.b   .L5
            move.w  D0,(-$18,A6)
.L5:
            move.w  (-$16,A6),D0
            cmp.w   (-$18,A6),D0
            beq.b   UPDATEA.L1
            bgt.b   UPDATEA.L2
            bsr.b   UPDATEA
            bra.b   UPDATEA.L3
UPDATEA:
            move.w  (-$16,A6),(-$1A,A6)
            movea.l A3,A0
            movea.l D4,A1
            movea.l D7,A2
            jsr     XorScan
            movea.l A0,A3
            move.w  (A3)+,(-$16,A6)
            exg     D4,D7
            rts
.L1:
            cmpi.w  #$7FFF,D0
            beq.w   EXPAND.L5
            bsr.b   UPDATEA
.L2:
            move.w  (-$18,A6),(-$1A,A6)
            movea.l A4,A0
            movea.l D5,A1
            movea.l D7,A2
            jsr     XorScan
            movea.l A0,A4
            move.w  (A4)+,(-$18,A6)
            exg     D7,D5
.L3:
            movea.l D4,A0
            movea.l D5,A1
            movea.l D7,A2
            move.w  ($A,A6),D2
            pea     CHANGES
            move.l  (-$52,A6),-(SP)
            rts
CHANGES:
            movea.l D7,A0
            movea.l D6,A1
            movea.l (-$14,A6),A2
            jsr     XorScan
            exg     D7,D6
            movea.l (-$14,A6),A0
            movea.l (-$1E,A6),A1
            movea.l (-$22,A6),A2
            move.l  (-$1A,A6),D0
            bra.b   .L2
.L1:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            move.w  (A0)+,D0
            move.l  D0,(A1)+
.L2:
            cmpa.l  A2,A1
            bcs.b   .L3
            tst.b   (8,A6)
            beq.w   EXPAND.L4
            move.l  A0,D1
            movea.l ($18,A6),A0
            suba.l  (A0),A3
            movea.l ($14,A6),A0
            suba.l  (A0),A4
            movea.l ($10,A6),A0
            suba.l  (A0),A1
            suba.l  (A0),A2
            lea     ($100,A2),A2
            movem.l D0-D2/A0-A2,-(SP)
            move.l  A0,-(SP)
            move.w  A2,-(SP)
            bsr.l   SetHSize
            movem.l (SP)+,D0-D2/A0-A2
            movea.l ($18,A6),A0
            adda.l  (A0),A3
            movea.l ($14,A6),A0
            adda.l  (A0),A4
            movea.l ($10,A6),A0
            adda.l  (A0),A1
            adda.l  (A0),A2
            move.l  A2,(-$22,A6)
            movea.l D1,A0
.L3:
            cmpi.w  #$7FFF,(A0)
            bne.b   .L1
            move.l  A1,(-$1E,A6)
            bra.w   RgnOp.L5
EXPAND:
            movea.l (A0),A1
            movea.l (A1),A1
            cmpi.w  #$A,(A1)
            bne.b   .L3
            move.l  A2,(A0)
            lea     (-6,A2),A0
            move.l  A0,(A2)+
            move.l  (2,A1),(A2)+
            move.w  (8,A1),(A2)
            move.w  #$7FFF,D0
            cmp.w   (A2)+,D0
            bne.b   .L1
            subq.w  #1,(-2,A2)
.L1:
            move.w  D0,(A2)+
            move.w  (6,A1),(A2)
            cmp.w   (A2)+,D0
            bne.b   .L2
            subq.w  #1,(-2,A2)
.L2:
            move.w  (4,A1),(A2)+
            move.w  (8,A1),(A2)+
            move.w  D0,(A2)+
            move.w  D0,(A2)+
            movea.l A0,A1
.L3:
            lea     ($A,A1),A0
            rts
.L4:
            move.l  A1,(-$1E,A6)
.L5:
            move.l  (-$1E,A6),D0
            movea.l ($10,A6),A0
            sub.l   (A0),D0
            lsr.w   #2,D0
            move.w  D0,($1C,A6)
            movea.l (-$56,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$14
            ds.b    8
SectScan:
            clr.w   D2
            clr.w   D3
            bra.b   UnionScan.L2
DiffScan:
            clr.w   D2
            bra.b   UnionScan.L1
UnionScan:
            moveq   #-1,D2
.L1:
            moveq   #-1,D3
.L2:
            move.w  (A0)+,D0
            move.w  (A1)+,D1
.L3:
            cmp.w   D1,D0
            blt.b   .L5
            bgt.b   .L7
            cmpi.w  #$7FFF,D0
            beq.b   .L9
            cmp.w   D3,D2
            bne.b   .L4
            move.w  D0,(A2)+
.L4:
            move.w  (A0)+,D0
            not.w   D2
            move.w  (A1)+,D1
            not.w   D3
            bra.b   .L3
.L5:
            tst.w   D3
            beq.b   .L6
            move.w  D0,(A2)+
.L6:
            move.w  (A0)+,D0
            not.w   D2
            bra.b   .L3
.L7:
            tst.w   D2
            beq.b   .L8
            move.w  D1,(A2)+
.L8:
            move.w  (A1)+,D1
            not.w   D3
            bra.b   .L3
.L9:
            move.w  #$7FFF,(A2)+
            rts
            ds.b    4
InsetScan:
            tst.w   D2
            blt.b   .L2
.L1:
            cmpi.w  #$7FFF,(A0)
            beq.b   .L7
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            add.w   D2,D0
            sub.w   D2,D1
            cmp.w   D1,D0
            bge.b   .L1
            move.w  D0,(A2)+
            move.w  D1,(A2)+
            bra.b   .L1
.L2:
            movea.w #$8001,A1
            bra.b   .L6
.L3:
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            add.w   D2,D0
            sub.w   D2,D1
            cmp.w   A1,D0
            bgt.b   .L4
            subq.w  #2,A2
            bra.b   .L5
.L4:
            move.w  D0,(A2)+
.L5:
            move.w  D1,(A2)+
            movea.w D1,A1
.L6:
            cmpi.w  #$7FFF,(A0)
            bne.b   .L3
.L7:
            move.w  #$7FFF,(A2)+
            rts
.L8:
            cmpi.w  #$7FFF,D0
            beq.b   .L7
XorScan:
            move.w  (A0)+,D0
            move.w  (A1)+,D1
.L1:
            cmp.w   D1,D0
            beq.b   InsetScan.L8
            blt.b   .L2
            move.w  D1,(A2)+
            move.w  (A1)+,D1
            bra.b   .L1
.L2:
            move.w  D0,(A2)+
            move.w  (A0)+,D0
            bra.b   .L1
