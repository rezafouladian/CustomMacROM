            bfextu  (-$7D,A6){2:2},D1
            move.l  D1,(-$54,A6)
            bra.b   sub_408915C0.L1
            btst    #5,(-$7D,A6)
            beq.w   sub_40891138
            btst    #4,(-$7D,A6)
            beq.b   .L4
            btst    #7,(A0)
            bne.b   .L6
            bsr.w   sub_408914A8
            bra.w   sub_40890AB4.L4
.L4:
            btst    #7,(A0)
            beq.b   .L5
            bsr.w   sub_408914B0
            bra.w   sub_40890AB4.L4
.L5:
            bsr.w   sub_408914C0
            bra.w   sub_40890AB4.L4
.L6:
            bsr.w   sub_408914D0
            bra.w   sub_40890AB4.L4
            move.l  #1,(-$54,A6)
            bra.b   sub_408915C0.L1
sub_408915C0:
            bfextu  (-$7D,A6){2:2},D1
            move.l  D1,(-$54,A6)
.L1:
            bclr    #7,(A0)
            sne     (2,A0)
            cmpi.w  #$403E,(A0)
            bgt.b   .L7
            cmpi.w  #$3FFD,(A0)
            bgt.b   .L9
            btst    #1,(-$51,A6)
            beq.b   .L5
            tst.b   (2,A0)
            bne.b   .L3
            cmpi.b  #3,(-$51,A6)
            beq.b   .L2
            bsr.w   sub_408914C0
            bra.w   sub_40890AB4.L4
.L2:
            bsr.w   sub_408914A8
            bra.w   sub_40890AB4.L4
.L3:
            cmpi.b  #2,(-$51,A6)
            beq.b   .L4
            bsr.w   sub_408914D0
            bra.w   sub_40890AB4.L4
.L4:
            bsr.w   sub_408914B0
            bra.w   sub_40890AB4.L4
.L5:
            tst.b   (2,A0)
            bne.b   .L6
            bsr.w   sub_408914C0
            bra.w   sub_40890AB4.L4
.L6:
            bsr.w   sub_408914D0
            bra.w   sub_40890AB4.L4
.L7:
            bfclr   (2,A0){0:8}
            beq.b   .L8
            bset    #7,(A0)
.L8:
            fmove.l FPCR,-(SP)
            fmove.l #0,FPCR
            fmove.x (A0),FP0
            fmove.l (SP)+,FPCR
            rts
.L9:
            moveq   #0,D0
            move.l  #$403E,D1
            bsr.w   sub_4088FDD0
            move.l  (-$54,A6),D1
            bsr.w   round
            bsr.w   sub_4088FCF8
            bfclr   (2,A0){0:8}
            beq.b   .L10
            bset    #7,(A0)
.L10:
            fmove.l FPCR,-(SP)
            fmove.l #0,FPCR
            fmove.x (A0),FP0
            fmove.l (SP)+,FPCR
            rts
