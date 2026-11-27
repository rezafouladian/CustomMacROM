ovfl:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            bset    #3,(-$79,A6)
            bsr.w   ovf_adj
            btst    #4,(-$7E,A6)
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
            move.l  ($1FD8).w,-(SP)
            rts
.L2:
            btst    #1,(-$7E,A6)
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
ovf_adj:
            btst    #1,(-$DC,A6)
            beq.b   .L1
            lea     (-$10C,A6),A0
            bra.b   .L2
.L1:
            lea     (-$CC,A6),A0
.L2:
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   g_opcls
            cmpi.w  #3,D0
            bne.b   .L3
            move.b  (-$7C,A6),(-$54,A6)
            bsr.w   sub_408904DE
            move.b  (-$54,A6),(-$7C,A6)
            bra.w   sub_4088E71C
.L3:
            bsr.w   ovf_r_x2
            bra.w   sub_4088E71C
