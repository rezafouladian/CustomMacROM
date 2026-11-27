unfl:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            bsr.w   sub_4088D960
            btst    #3,(-$7E,A6)
            beq.b   .L2
            btst    #1,(-$DC,A6)
            beq.b   .L1
            bfextu  (-$F0,A6){6:3},D0
            bclr    D0,(-$11B,A6)
            bsr.w   sub_4088DBD0
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
.L1:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FD0).w,-(SP)
            rts
.L2:
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            andi.b  #3,D0
            beq.b   .L4
            btst    #1,(-$DC,A6)
            beq.b   .L3
            bfextu  (-$F0,A6){6:3},D0
            bclr    D0,(-$11B,A6)
            bsr.w   sub_4088DBD0
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
.L3:
            move.b  #$C4,($B,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($C4).w,-(SP)
            rts
.L4:
            bclr    #1,(-$DC,A6)
            beq.b   .L5
            bfextu  (-$F0,A6){6:3},D0
            bclr    D0,(-$11B,A6)
            bsr.w   sub_4088DBD0
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            rte
.L5:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            unlk    A6
            rte
sub_4088D960:
            bsr.w   sub_40890602
            clr.w   -(SP)
            move.w  D0,-(SP)
            btst    #1,(-$DC,A6)
            beq.b   .L2
            lea     (-$10C,A6),A0
            move.w  (-$F0,A6),D1
            andi.w  #$7F,D1
            cmpi.w  #$30,D1
            beq.b   .L1
            cmpi.w  #$33,D1
            bne.b   .L3
.L1:
            moveq   #0,D0
            move.w  #1,(SP)
            bra.b   .L3
.L2:
            lea     (-$D8,A6),A0
.L3:
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FD4A
            bfextu  (-$7D,A6){2:2},D1
            add.l   (SP)+,D1
            bsr.w   round
            bsr.w   g_opcls
            cmpi.b  #3,D0
            bne.b   .L5
            bsr.w   sub_40890674
            tst.b   D0
            beq.b   .L4
            tst.b   (4,A0)
            bmi.b   .L4
            subq.w  #1,(A0)
.L4:
            bsr.w   sub_4088E71C
            bra.b   .L7
.L5:
            bsr.w   sub_4088E71C
            tst.l   (4,A0)
            bne.b   .L6
            tst.l   (8,A0)
            bne.b   .L6
            bset    #2,(-$7C,A6)
.L6:
            btst    #7,(A0)
            beq.b   .L7
            bset    #3,(-$7C,A6)
.L7:
            btst    #1,(-$7A,A6)
            beq.b   .L8
            bset    #5,(-$79,A6)
.L8:
            rts
