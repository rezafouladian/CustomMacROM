            include "Include/ROMHeader.s"

            EXPORT  InstallFPSP

            SECTION "FPEmulation",CODE

InstallFPSP:
            movec   VBR,A0
            move.l  ($2C,A0),($1FC8).w
            lea     fline,A1
            move.l  A1,($2C,A0)
            lea     bsun,A1
            move.l  A1,($C0,A0)
            lea     unfl,A1
            move.l  A1,($CC,A0)
            lea     operr,A1
            move.l  A1,($D0,A0)
            lea     ovfl,A1
            move.l  A1,($D4,A0)
            lea     snan,A1
            move.l  A1,($D8,A0)
            lea     unsupp,A1
            move.l  A1,($DC,A0)
            rts
.L1:
            dc.w    $F27F,0
sub_4088D248:
            subq.l  #1,D0
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
            rts
bsun:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            move.l  (6,A6),(-$78,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FCC).w,-(SP)
            rts
operr:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            btst    #4,(-$DB,A6)
            beq.b   .L1
            move.l  (-$E4,A6),D0
            bfextu  D0{3:3},D0
            cmpi.b  #0,D0
            beq.b   .L2
            cmpi.b  #4,D0
            beq.w   .L7
            cmpi.b  #6,D0
            beq.w   .L9
.L1:
            bset    #5,(-$7A,A6)
            bset    #7,(-$79,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FD4).w,-(SP)
            rts
.L2:
            moveq   #4,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.w   .L11
            cmpi.l  #$80000000,(-$D0,A6)
            bne.b   .L3
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L3
            move.l  #$80000000,D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L3:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L5
.L4:
            move.l  (-$D0,A6),D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L5:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$4000,D0
            bcc.w   .L12
            move.l  (-$D0,A6),D0
            andi.l  #$7FFF0000,D0
            cmpi.l  #$7FFF0000,D0
            beq.b   .L4
            tst.l   (-$D0,A6)
            bpl.b   .L6
            cmpi.l  #$FFFFFFFF,(-$D4,A6)
            beq.b   .L4
            bra.w   .L12
.L6:
            tst.l   (-$D4,A6)
            beq.b   .L4
            bra.w   .L12
.L7:
            moveq   #2,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.w   .L11
            cmpi.l  #$FFFF8000,(-$D0,A6)
            bne.b   .L8
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L8
            move.l  #$80000000,D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L8:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L12
            move.l  (-$D0,A6),D0
            swap    D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L9:
            moveq   #1,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.b   .L11
            cmpi.l  #$FFFFFF80,(-$D0,A6)
            bne.b   .L10
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L10
            move.l  #$80000000,D0
            bsr.b   operr_store
            bra.w   check_upper.L4
.L10:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L12
            move.l  (-$D0,A6),D0
            asl.l   #8,D0
            swap    D0
            bsr.b   operr_store
            bra.w   check_upper.L4
.L11:
            ori.l   #$2080,(-$7C,A6)
            move.l  (-$C8,A6),D0
            bsr.b   operr_store
            bra.w   check_upper.L3
.L12:
            ori.l   #$2080,(-$7C,A6)
            bclr    #1,(-$7A,A6)
            bclr    #3,(-$79,A6)
            fmove.l #0,FPSR
            tst.w   (-$D8,A6)
            blt.b   .L13
            move.l  #$7FFFFFFF,D0
            bsr.b   operr_store
            bra.b   check_upper.L3
.L13:
            move.l  #$80000000,D0
            bsr.b   operr_store
            bra.b   check_upper.L3
operr_store:
            move.l  D0,(-$54,A6)
            movea.l (-$78,A6),A0
            sub.l   D0,D0
            move.w  (A0),D0
            bftst   D0{26:3}
            bne.b   .L3
            andi.l  #7,D0
            cmpi.l  #4,D1
            beq.b   .L1
            cmpi.l  #2,D1
            bne.b   .L2
            ori.l   #8,D0
            bra.b   .L2
.L1:
            ori.l   #$10,D0
.L2:
            move.l  D0,D1
            bra.w   sub_40890882
.L3:
            lea     (-$54,A6),A0
            movea.l ($C,A6),A1
            move.l  D1,D0
            bsr.w   sub_4088D248
            rts
check_upper:
            cmpi.l  #$FFFFFFFF,(-$D4,A6)
            bne.b   .L1
            cmpi.w  #$C000,(-$D8,A6)
            beq.b   .L2
            cmpi.w  #$BFFF,(-$D8,A6)
            beq.b   .L2
.L1:
            moveq   #1,D0
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            btst    #5,(-$7E,A6)
            beq.b   .L4
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FD4).w,-(SP)
            rts
.L4:
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            andi.b  #3,D0
            beq.b   .L5
            move.b  #$C4,($B,A6)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($C4).w,-(SP)
            rts
.L5:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            unlk    A6
            rte
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
snan:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            btst    #6,(-$7E,A6)
            bne.b   .L1
            bsr.w   move_out
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            andi.b  #3,D0
            beq.b   .L6
            move.b  #$C4,($B,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($C4).w,-(SP)
            rts
.L1:
            btst    #5,(-$E4,A6)
            beq.w   move_out.L7
            bsr.w   move_out
.L2:
            move.b  (SP),(-$45,A6)
            cmpi.b  #$40,(SP)
            bne.b   .L3
            moveq   #$D,D0
            bra.b   .L4
.L3:
            moveq   #$B,D0
.L4:
            clr.l   (SP)
.L5:
            clr.l   -(SP)
            dbra    D0,.L5
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FDC).w,-(SP)
            rts
.L6:
            bclr    #2,(-$DC,A6)
            move.b  (SP),(-$45,A6)
            cmpi.b  #$40,(SP)
            bne.b   .L7
            moveq   #$D,D0
            bra.b   .L8
.L7:
            moveq   #$B,D0
.L8:
            clr.l   (SP)
.L9:
            clr.l   -(SP)
            dbra    D0,.L9
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            rte
move_out:
            movea.l ($C,A6),A0
            bfextu  (-$E4,A6){3:3},D0
            cmpi.l  #0,D0
            beq.b   .L1
            cmpi.l  #4,D0
            beq.b   .L2
            cmpi.l  #6,D0
            beq.b   .L3
            rts
.L1:
            move.l  (-$C8,A6),D1
            moveq   #4,D0
            bset    #$1E,D1
            tst.l   A0
            beq.b   .L4
            move.l  D1,(A0)
            rts
.L2:
            move.l  (-$C8,A6),D1
            moveq   #2,D0
            bset    #$1E,D1
            tst.l   A0
            beq.b   .L4
            swap    D1
            move.w  D1,(A0)
            swap    D1
            rts
.L3:
            move.l  (-$C8,A6),D1
            moveq   #1,D0
            bset    #$1E,D1
            tst.l   A0
            beq.b   .L4
            rol.l   #8,D1
            move.b  D1,(A0)
            ror.l   #8,D1
            rts
.L4:
            move.l  D1,(-$54,A6)
            movea.l (-$78,A6),A0
            move.w  (A0),D1
            andi.l  #7,D1
            cmpi.l  #4,D0
            beq.b   .L5
            cmpi.l  #2,D0
            bne.b   .L6
            ori.l   #8,D1
            bra.w   sub_40890882
.L5:
            ori.l   #$10,D1
            bra.w   sub_40890882
.L6:
            bra.w   sub_40890882
.L7:
            move.l  (-$E0,A6),D0
            bfextu  D0{0:3},D0
            cmpi.b  #3,D0
            bne.b   .L8
            move.w  (-$D8,A6),D0
            bra.b   .L9
.L8:
            move.w  (-$CC,A6),D0
.L9:
            btst    #$F,D0
            beq.b   .L10
            bset    #3,(-$7C,A6)
            bra.w   snan.L2
.L10:
            bclr    #3,(-$7C,A6)
            bra.w   snan.L2
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
fline:
            cmpi.w  #$202C,(6,SP)
            beq.w   unsupp.L3
            subq.l  #4,SP
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            movea.l ($A,A6),A0
            move.l  (A0),D0
            bfextu  D0{4:3},D1
            cmpi.b  #1,D1
            bne.b   .L3
            bfextu  D0{16:6},D1
            cmpi.b  #$17,D1
            bne.b   .L3
            cmpi.b  #$40,(SP)
            bne.b   .L1
            suba.w  #$28,SP
            move.b  #$40,(SP)
            move.b  #$28,(1,SP)
            clr.w   (2,SP)
            bra.b   .L2
.L1:
            cmpi.b  #$41,(SP)
            bne.w   InstallFPSP.L1
            suba.w  #$30,SP
            move.b  #$41,(SP)
            move.b  #$30,(1,SP)
            clr.w   (2,SP)
.L2:
            move.w  (8,A6),(4,A6)
            move.l  ($A,A6),(6,A6)
            fmove.l (6,A6),FPIAR
            moveq   #4,D1
            add.l   D1,(6,A6)
            move.w  #$202C,($A,A6)
            clr.l   ($C,A6)
            move.w  D0,(-$E4,A6)
            clr.l   (-$DC,A6)
            bset    #5,(-$DB,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            bra.w   unsupp.L4
.L3:
            movem.l (-$C0,A6),D0-D1/A0-A1
            frestore (SP)+
            unlk    A6
            addq.l  #4,SP
            move.l  ($1FC8).w,-(SP)
            rts
unsupp:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            move.b  (SP),(-$45,A6)
            move.b  (SP),D0
            andi.b  #$F0,D0
            cmpi.b  #$40,D0
            bne.w   InstallFPSP.L1
            fmove.l #0,FPSR
            fmove.l #0,FPCR
            move.l  (-$7C,A6),D1
            btst    #5,(-$E4,A6)
            bne.b   .fmove_con
            andi.l  #$FF00FF,D1
            bra.b   .usend_fix
.fmove_con:
            andi.l  #$FFF40FF,D1
.usend_fix:
            move.l  D1,(-$7C,A6)
            st      (-$47,A6)
            bsr.w   get_op
            bsr.w   res_func
            clr.l   -(SP)
            move.b  (-$45,A6),(SP)
            bra.w   gen_except
.L3:
            link.w  A6,#-$C0
            fsave   -(SP)
.L4:
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            move.b  (SP),D0
            andi.b  #$F0,D0
            cmpi.b  #$40,D0
            bne.w   InstallFPSP.L1
            move.l  (-$7C,A6),D0
            andi.l  #$FF,D0
            move.l  D0,(-$7C,A6)
            fmove.l #0,FPSR
            fmove.l #0,FPCR
            clr.b   (-$47,A6)
            bsr.w   get_op
            clr.b   (-$4C,A6)
            bsr.w   do_func
            fsave   -(SP)
            tst.b   (-$4C,A6)
            bne.b   .L5
            bsr.b   sto_res
.L5:
            bra.w   gen_except
sto_res:
            bfextu  (-$E4,A6){6:3},D0
            cmpi.b  #3,D0
            ble.b   .L1
            fmovem.x FP0,-(SP)
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x (SP)+,D0
            rts
.L1:
            cmpi.b  #0,D0
            beq.b   .L4
            cmpi.b  #1,D0
            beq.b   .L3
            cmpi.b  #2,D0
            beq.b   .L2
            fmovem.x FP0,(-$8C,A6)
            rts
.L2:
            fmovem.x FP0,(-$98,A6)
            rts
.L3:
            fmovem.x FP0,(-$A4,A6)
            rts
.L4:
            fmovem.x FP0,(-$B0,A6)
            rts
sub_4088DBD0:
            cmpi.b  #$40,(4,SP)
            bne.w   .L22
            move.b  (-$11C,A6),D0
            andi.b  #$FE,D0
            beq.w   .L22
            move.w  (-$E4,A6),D0
            andi.w  #$E000,D0
            bne.w   .L11
            bfextu  (-$E4,A6){3:3},D0
            bfextu  (-$F0,A6){6:3},D1
            cmp.b   D0,D1
            beq.b   .L1
            bfextu  (-$E4,A6){6:3},D0
            cmp.b   D0,D1
            beq.b   .L1
            bfextu  (-$F4,A6){6:3},D1
            cmp.b   D0,D1
            beq.b   .L3
            bfextu  (-$E4,A6){3:3},D0
            cmp.b   D0,D1
            beq.b   .L3
            bne.w   .L22
.L1:
            bfextu  (-$E4,A6){3:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$CC,A6)
            move.b  #$12,D0
            bfins   D0,(-$E4,A6){0:6}
            btst    #6,(-$CC,A6)
            beq.b   .L2
            bclr    #4,(-$E8,A6)
            bra.w   .L22
.L2:
            bset    #4,(-$E8,A6)
            bra.w   .L22
.L3:
            move.l  (-$E8,A6),(-$54,A6)
            move.l  (-$E4,A6),(-$50,A6)
            move.l  (-$E0,A6),(-$44,A6)
            andi.l  #$E0000000,(-$44,A6)
            clr.b   (-$11C,A6)
            move.l  (SP)+,D1
            frestore (SP)+
            fsave   -(SP)
            cmpi.w  #$4060,(SP)
            beq.w   .L10
            bfextu  (-$F4,A6){6:3},D0
            cmpi.l  #3,D0
            bgt.b   .L7
            beq.b   .L6
            cmpi.l  #1,D0
            blt.b   .L5
            beq.b   .L4
            fmovem.x FP2,(-$98,A6)
            bra.b   .L7
.L4:
            fmovem.x FP1,(-$A4,A6)
            bra.b   .L7
.L5:
            fmovem.x FP0,(-$B0,A6)
            bra.b   .L7
.L6:
            fmovem.x FP3,(-$8C,A6)
.L7:
            moveq   #$16,D0
            clr.l   (SP)
.L8:
            clr.l   -(SP)
            dbra    D0,.L8
            move.l  #$40600000,-(SP)
            move.l  (-$54,A6),(-$E8,A6)
            move.l  (-$50,A6),(-$E4,A6)
            move.l  (-$44,A6),(-$E0,A6)
            move.b  #6,(-$11C,A6)
            move.l  D1,-(SP)
            bfextu  (-$E4,A6){3:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$CC,A6)
            move.b  #$12,D0
            bfins   D0,(-$E4,A6){0:6}
            btst    #6,(-$CC,A6)
            beq.b   .L9
            bclr    #4,(-$E8,A6)
            bra.w   .L22
.L9:
            bset    #4,(-$E8,A6)
            bra.w   .L22
.L10:
            jmp     InstallFPSP.L1
.L11:
            move.w  (-$E4,A6),D0
            andi.w  #$FC00,D0
            cmpi.w  #$4400,D0
            bne.w   .L22
            bfextu  (-$E4,A6){6:3},D0
            bfextu  (-$F0,A6){6:3},D1
            cmp.b   D0,D1
            beq.w   .L17
            bfextu  (-$F4,A6){6:3},D1
            cmp.b   D0,D1
            bne.w   .L22
            move.l  (-$E8,A6),(-$54,A6)
            move.l  (-$E4,A6),(-$50,A6)
            move.l  (-$E0,A6),(-$44,A6)
            andi.l  #$E0000000,(-$44,A6)
            clr.b   (-$11C,A6)
            move.l  (-$CC,A6),(-$64,A6)
            move.l  (-$C8,A6),(-$60,A6)
            move.l  (-$C4,A6),(-$5C,A6)
            move.l  (SP)+,D1
            frestore (SP)+
            fsave   -(SP)
            cmpi.w  #$4060,(SP)
            beq.w   .L21
            bfextu  (-$F4,A6){6:3},D0
            cmpi.l  #3,D0
            bgt.b   .L15
            beq.b   .L14
            cmpi.l  #1,D0
            blt.b   .L13
            beq.b   .L12
            fmovem.x FP2,(-$98,A6)
            bra.b   .L15
.L12:
            fmovem.x FP1,(-$A4,A6)
            bra.b   .L15
.L13:
            fmovem.x FP0,(-$B0,A6)
            bra.b   .L15
.L14:
            fmovem.x FP3,(-$8C,A6)
.L15:
            moveq   #$16,D0
            clr.l   (SP)
.L16:
            clr.l   -(SP)
            dbra    D0,.L16
            move.l  #$40600000,-(SP)
            move.l  (-$54,A6),(-$E8,A6)
            move.l  (-$50,A6),(-$E4,A6)
            move.l  (-$44,A6),(-$E0,A6)
            move.b  #6,(-$11C,A6)
            move.l  (-$64,A6),(-$CC,A6)
            move.l  (-$60,A6),(-$C8,A6)
            move.l  (-$5C,A6),(-$C4,A6)
            move.l  D1,-(SP)
.L17:
            move.b  #$15,D0
            bfins   D0,(-$E4,A6){0:6}
            cmpi.w  #$407F,(-$CC,A6)
            bne.b   .L18
            move.w  #$43FF,(-$CC,A6)
            bra.b   .L22
.L18:
            cmpi.w  #$C07F,(-$CC,A6)
            bne.b   .L19
            move.w  #$C3FF,(-$CC,A6)
            bra.b   .L22
.L19:
            cmpi.w  #$3F80,(-$CC,A6)
            bne.b   .L20
            move.w  #$3C00,(-$CC,A6)
            bra.b   .L22
.L20:
            cmpi.w  #$BF80,(-$CC,A6)
            bne.b   .L22
            move.w  #$BC00,(-$CC,A6)
            bra.b   .L22
.L21:
            jmp     InstallFPSP.L1
.L22:
            rts
.L23:
            dc.w    $0102,$0106,$0106,$017E,$017E,$0106,$010E,$010E
            dc.w    $0146
gen_except:
            cmpi.b  #0,(1,SP)
            beq.w   sub_4088DECC.L5
            cmpi.b  #$28,(1,SP)
            beq.b   sub_4088DECC.L2
            cmpi.b  #$30,(1,SP)
            beq.b   sub_4088DECC.L2
            cmpi.b  #$60,(1,SP)
            bne.w   InstallFPSP.L1
            lea     ($124,SP),A1
            move.l  (-$CC,A6),(-$CC,A1)
            move.l  (-$C8,A6),(-$C8,A1)
            move.l  (-$C4,A6),(-$C4,A1)
            move.l  (-$E4,A6),(-$E4,A1)
            bsr.b   sub_4088DECC
            move.l  D0,(-$F0,A1)
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            move.l  (-$7C,A6),(-$100,A1)
            ori.l   #$1800000,(-$DC,A1)
            bra.w   sub_4088DECC.L7
sub_4088DECC:
            move.l  (-$E4,A6),D0
            andi.l  #$3FF0000,D0
            bfextu  D0{10:4},D1
            lsr.b   #1,D1
            bcc.b   .L1
            bset    #3,D1
.L1:
            bfins   D1,D0{10:4}
            rts
.L2:
            cmpi.b  #$28,(1,SP)
            bne.b   .L3
            lea     ($EC,SP),A1
            bra.b   .L4
.L3:
            cmpi.b  #$30,(1,SP)
            bne.w   InstallFPSP.L1
            lea     ($F4,SP),A1
.L4:
            move.l  (-$E4,A6),(-$E4,A1)
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            bra.w   .L7
.L5:
            addq.l  #4,SP
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            cmpi.b  #$60,(1,SP)
            bne.b   .L6
            clr.w   (-$EC,A6)
            btst    #5,(-$E4,A6)
            bne.b   .L6
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
.L6:
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            bfffo   D0{24:8},D1
            lea     sub_4088DBD0.L23,A0
            subi.b  #$18,D1
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
            bra.w   .L7
            bset    #2,(-$DC,A6)
            bra.b   .L15
            tst.b   (-$47,A6)
            bne.b   .L16
            bset    #1,(-$DC,A6)
            bclr    #2,(-$DC,A6)
            bra.b   .L15
.L16:
            tst.b   (-$49,A6)
            bne.b   .L17
            bset    #1,(-$DC,A6)
.L17:
            bclr    #2,(-$DC,A6)
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A6)
.L15:
            bclr    #5,(-$DB,A6)
            bra.w   .L7
            btst    #1,(-$7E,A6)
            beq.b   .L18
            btst    #4,(-$7A,A6)
            beq.b   .L18
            bra.b   .L19
.L18:
            tst.b   (-$47,A6)
            beq.b   .L20
            tst.b   (-$49,A6)
            bne.w   .L7
.L20:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            unlk    A6
            bra.w   .L21
.L19:
            tst.b   (-$47,A6)
            beq.b   .L22
            tst.b   (-$46,A6)
            beq.b   .L16
            clr.b   (-$11C,A6)
            bset    #2,(-$DC,A6)
            move.w  (-$CC,A6),(-$D8,A6)
            move.l  (-$C8,A6),(-$D4,A6)
            move.l  (-$C4,A6),(-$D0,A6)
            bset    #4,(-$E0,A6)
            bclr    #5,(-$DB,A6)
            bra.b   .L7
.L22:
            move.b  (SP),(-$45,A6)
            cmpi.b  #$60,(1,SP)
            beq.b   .L23
            cmpi.b  #$40,(SP)
            bne.b   .L24
            moveq   #$D,D0
            bra.b   .L25
.L24:
            cmpi.b  #$41,(SP)
            bne.w   InstallFPSP.L1
            moveq   #$B,D0
            clr.w   (-$EC,A6)
.L25:
            clr.l   (SP)
.L26:
            clr.l   -(SP)
            dbra    D0,.L26
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
.L23:
            move.l  (-$74,A6),(-$10C,A6)
            move.l  (-$70,A6),(-$108,A6)
            move.l  (-$6C,A6),(-$104,A6)
            bset    #1,(-$DC,A6)
            bclr    #2,(-$DC,A6)
            bclr    #5,(-$DB,A6)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A6)
.L7:
            cmpi.b  #$28,(1,SP)
            bne.b   .L8
            moveq   #$D,D0
            bra.b   .L9
.L8:
            cmpi.b  #$30,(1,SP)
            bne.b   .L12
            moveq   #$B,D0
            clr.w   (-$EC,A6)
.L9:
            move.b  (SP),(-$45,A6)
            clr.l   (SP)
.L10:
            clr.l   -(SP)
            dbra    D0,.L10
            lea     ($124,SP),A1
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.l  (-$74,A6),(-$10C,A1)
            move.l  (-$70,A6),(-$108,A1)
            move.l  (-$6C,A6),(-$104,A1)
            btst    #2,(-$DC,A1)
            bne.b   .L11
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A1)
            bra.b   .L12
.L11:
            bfextu  (-$7C,A6){17:4},D0
            bfins   D0,(-$EB,A1){4:4}
            move.l  (-$7C,A6),(-$100,A1)
            ori.l   #$1800000,(-$DC,A1)
.L12:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
.L21:
            btst    #7,(SP)
            bne.b   .L13
            btst    #6,(SP)
            bne.b   .L13
            rte
.L13:
            bftst   (6,SP){0:4}
            bne.b   .L14
            subq.w  #4,SP
            move.l  (4,SP),(SP)
            move.l  (8,SP),(4,SP)
            suba.w  #$64,SP
            fsave   (SP)
            fmove.l FPIAR,($6C,SP)
            frestore (SP)
            lea     ($64,SP),SP
.L14:
            move.w  #$2024,(6,SP)
            move.l  TraceVector,-(SP)
            rts
get_op:
            clr.b   (-$48,A6)
            tst.b   (-$47,A6)
            beq.b   .L2
            btst    #5,(-$E4,A6)
            bne.w   .L13
            btst    #6,(-$E4,A6)
            beq.b   .L1
            bfextu  (-$E4,A6){3:3},D0
            cmpi.b  #3,D0
            beq.w   .L12
.L1:
            bsr.w   chk_dy_mo
            tst.b   (-$48,A6)
            beq.b   .L6
            btst    #7,(-$E0,A6)
            beq.b   .L6
            bra.b   .L5
.L2:
            bfextu  (-$E4,A6){0:6},D0
            cmpi.l  #$17,D0
            bne.b   .L3
            rts
.L3:
            btst    #2,(-$DC,A6)
            bne.w   .L12
            move.b  (-$E8,A6),D0
            or.b    (-$E0,A6),D0
            bmi.b   .L4
            rts
.L4:
            btst    #7,(-$E0,A6)
            beq.b   .L6
            bsr.w   chk_dy_mo
            tst.b   (-$48,A6)
            beq.b   .L6
.L5:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            beq.b   .L6
            lea     (-$D8,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E0,A6)
.L6:
            btst    #7,(-$E8,A6)
            beq.w   .L14
            btst    #5,(-$E8,A6)
            bne.b   .L8
.L7:
            move.w  (-$CC,A6),D0
            andi.w  #$7FFF,D0
            beq.w   .L14
            lea     (-$CC,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E8,A6)
            rts
.L8:
            btst    #4,(-$E4,A6)
            bne.b   .L9
            move.w  #$3F81,D1
            bra.b   .L10
.L9:
            move.w  #$3C01,D1
.L10:
            btst    #7,(-$CC,A6)
            beq.b   .L11
            bset    #$F,D1
.L11:
            move.w  D1,(-$CC,A6)
            move.w  (-$E4,A6),D1
            andi.w  #$E3FF,D1
            ori.w   #$800,D1
            move.w  D1,(-$E4,A6)
            lea     (-$CC,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E8,A6)
            rts
.L12:
            move.l  (-$D0,A6),(-$CC,A6)
            bsr.b   chk_dy_mo
            bsr.w   sub_4088E308
            tst.b   (-$48,A6)
            beq.b   .L14
            bfextu  (-$E4,A6){6:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$D8,A6)
            btst    #7,(-$E0,A6)
            bne.w   .L5
            move.b  (-$E0,A6),D0
            andi.b  #$F0,D0
            tst.b   D0
            bne.b   .L14
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFF,D0
            bge.b   .L14
            ori.b   #$10,(-$E0,A6)
            bra.b   .L14
.L13:
            clr.b   (-$48,A6)
            bfextu  (-$E4,A6){4:2},D0
            cmpi.b  #3,D0
            bne.w   .L7
.L14:
            rts
chk_dy_mo:
            move.w  (-$E4,A6),D0
            btst    #5,D0
            beq.b   .L2
            btst    #4,D0
            beq.b   .L1
            andi.w  #$7F,D0
            cmpi.w  #$38,D0
            bne.b   .L2
.L1:
            st      (-$48,A6)
            rts
.L2:
            clr.b   (-$48,A6)
            rts
sub_4088E2D0:
            clr.l   (-$54,A6)
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FC90
            btst    #7,(4,A0)
            bne.b   .L1
            ori.b   #$80,(-$54,A6)
.L1:
            cmpi.w  #$3FFF,(A0)
            bgt.b   .L2
            bset    #4,(-$54,A6)
.L2:
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
.L3:
            rts
sub_4088E308:
            move.w  (-$E4,A6),D0
            andi.w  #$3B,D0
            beq.w   .L5
            move.w  (-$CC,A6),D0
            bfextu  D0{20:12},D1
            cmpi.w  #$FFF,D1
            bne.b   .L2
            bfextu  D0{17:3},D1
            cmpi.w  #7,D1
            bne.b   .L2
            tst.l   (-$C8,A6)
            bne.b   .L1
            tst.l   (-$C4,A6)
            bne.b   .L1
            bra.w   .L11
.L1:
            btst    #6,(-$C8,A6)
            bne.w   .L11
            ori.l   #$1004080,(-$7C,A6)
            bra.w   .L11
.L2:
            move.w  (-$CA,A6),D0
            andi.w  #$F,D0
            tst.w   D0
            bne.b   .L4
            tst.l   (-$C8,A6)
            bne.b   .L4
            tst.l   (-$C4,A6)
            bne.b   .L4
            tst.l   (-$CC,A6)
            bge.b   .L3
            move.l  #$80000000,(-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.w   .L11
.L3:
            clr.l   (-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.w   .L11
.L4:
            fmovem.x FP0,-(SP)
            bsr.w   sub_4088E4FE
            fmove.x FP0,(-$CC,A6)
            fmovem.x (SP)+,FP0
            fmove.l #0,FPSR
            bra.w   .L11
.L5:
            move.w  (-$CC,A6),D0
            bfextu  D0{20:12},D1
            cmpi.w  #$FFF,D1
            bne.b   .L8
            bfextu  D0{17:3},D1
            cmpi.w  #7,D1
            bne.b   .L8
            tst.l   (-$C8,A6)
            bne.b   .L6
            tst.l   (-$C4,A6)
            bne.b   .L6
            ori.l   #$2000000,(-$7C,A6)
            tst.l   (-$CC,A6)
            bge.w   .L11
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L11
.L6:
            ori.l   #$1000000,(-$7C,A6)
            move.b  #$60,(-$E8,A6)
            btst    #6,(-$C8,A6)
            bne.b   .L7
            ori.l   #$1004080,(-$7C,A6)
            btst    #6,(-$7E,A6)
            bne.b   .L7
            bset    #6,(-$C8,A6)
.L7:
            tst.l   (-$CC,A6)
            bge.b   .L11
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L11
.L8:
            move.w  (-$CA,A6),D0
            andi.w  #$F,D0
            tst.w   D0
            bne.b   .L10
            tst.l   (-$C8,A6)
            bne.b   .L10
            tst.l   (-$C4,A6)
            bne.b   .L10
            tst.l   (-$CC,A6)
            bge.b   .L9
            ori.l   #$C000000,(-$7C,A6)
            move.l  #$80000000,(-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.b   .L11
.L9:
            ori.l   #$4000000,(-$7C,A6)
            clr.l   (-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.b   .L11
.L10:
            fmovem.x FP0,-(SP)
            bsr.w   sub_4088E4FE
            fmove.x FP0,(-$CC,A6)
            fmovem.x (SP)+,FP0
.L11:
            move.w  (-$E4,A6),D0
            andi.w  #$FBFF,D0
            move.w  D0,(-$E4,A6)
            move.w  (-$CC,A6),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$7FFF,D1
            bne.b   .L13
            move.l  (-$C8,A6),D1
            bne.b   .L12
            move.l  (-$C4,A6),D1
            bne.b   .L12
            move.b  #$40,(-$E8,A6)
            moveq   #$40,D0
            rts
.L12:
            move.b  #$60,(-$E8,A6)
            moveq   #$60,D0
            rts
.L13:
            tst.w   D1
            bne.b   .L14
            move.b  #$30,(-$E8,A6)
            moveq   #$20,D0
            rts
.L14:
            cmpi.w  #$3FFF,D1
            ble.b   .L15
            clr.b   (-$E8,A6)
            bra.b   .L16
.L15:
            move.b  #$10,(-$E8,A6)
.L16:
            moveq   #0,D0
            rts
            dc.w    $4E75
            ds.b    4
            dc.w    $0203,$0203,$0203,$0302,$0302,$0203
sub_4088E4FE:
            fmove.l #0,FPCR
            movem.l D2-D5,-(SP)
            moveq   #2,D2
            moveq   #4,D3
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            move.l  (A0),D4
            moveq   #0,D1
            dc.w    $4C3C,$1001,0,$000A,$E9C4,$08C4,$D280,$5803
            dc.w    $51CA,$FFEE,$0804,$001E,$6702,$4481,$0481,0
            dc.b    $00,$10,$6C,$0E,$44,$81,$00,$84,$40
            ds.b    4
            dc.b    $90,$40,$00,$00,$00,$2D,$41,$FF,$AC,$72,$01,$F2,$3C,$58,$00,$00
            dc.b    $00,$E9,$D0,$07,$04,$F2,$00,$58,$22,$28,$30,$1C,$00,$76,$00,$74
            dc.b    $07,$F2,$3C,$58,$23,$00,$0A,$E9,$C4,$08,$C4,$F2,$00,$58,$22,$58
            dc.b    $03,$51,$CA,$FF,$EE,$52,$81,$0C,$81,$00,$00,$00,$02,$6F,$DA,$08
            dc.b    $10,$00,$1F,$67,$04,$F2,$00,$00,$1A,$22,$2E,$FF,$AC,$0C,$81,$00
            dc.b    $00,$00,$1B,$6F,$00,$00,$DC,$08,$10,$00,$1E,$66,$70,$72,$00,$28
            dc.b    $10,$E9,$C4,$07,$04,$66,$24,$52,$81,$7A,$01,$28,$30,$5C,$00,$66
            dc.b    $08,$50,$81,$52,$85,$28,$30,$5C,$00,$76,$00,$74,$07,$E9,$C4,$08
            dc.b    $C4,$66,$08,$58,$83,$52,$81,$51,$CA,$FF,$F4,$20,$01,$22,$2E,$FF
            dc.b    $AC,$92,$80,$6C,$10,$44,$81,$28,$10,$00,$84,$40
            ds.b    4
            dc.b    $90,$40,$00,$00,$00,$43,$FA,$50,$02,$76,$00,$F2,$3C,$58,$80,$00
            dc.b    $01,$74,$03,$E2,$80,$64,$06,$F2,$31,$48,$A3,$30,$00,$06,$83,$00
            dc.b    $00,$00,$0C,$4A,$80,$66,$EC,$F2,$00,$04,$23,$60,$64,$72,$00,$7A
            dc.b    $02,$28,$30,$5C,$00,$66,$08,$53,$85,$50,$81,$28,$30,$5C,$00,$76
            dc.b    $1C,$74,$07,$E9,$C4,$08,$C4,$66,$08,$59,$83,$52,$81,$51,$CA,$FF
            dc.b    $F4,$20,$01,$22,$2E,$FF,$AC,$92,$80,$6E,$10,$44,$81,$28,$10,$02
            dc.b    $84,$BF,$FF,$FF,$FF,$02,$90,$BF,$FF,$FF,$FF,$43,$FA,$4F,$9C,$76
            dc.b    $00,$F2,$3C,$58,$80,$00,$01,$74,$03,$E2,$80,$64,$06,$F2,$31,$48
            dc.b    $A3,$30,$00,$06,$83,$00,$00,$00,$0C,$4A,$80,$66,$EC,$F2,$00,$04
            dc.b    $20,$26,$2E,$FF,$80,$E9,$C3,$26,$82,$28,$10,$E5,$82,$E9,$C4,$00
            dc.b    $02,$D4,$80,$43,$FA,$FE,$56,$10,$31,$20,$00,$76,$00,$EF,$C3,$06
            dc.b    $82,$F2,$03,$90,$00,$E2,$80,$64,$06,$43,$FA,$50,$CE,$60,$0E,$E2
            dc.b    $80,$64,$06,$43,$FA,$50,$04,$60,$04,$43,$FA,$4F,$3E,$20,$01,$6A
            dc.b    $08,$44,$80,$00,$90,$40,$00,$00,$00,$76,$00,$F2,$3C,$58,$80,$00
            dc.b    $01,$E2,$80,$64,$06,$F2,$31,$48,$A3,$30,$00,$06,$83,$00,$00,$00
            dc.b    $0C,$4A,$80,$66,$EC,$08,$10,$00,$1E,$67,$06,$F2,$00,$04,$20,$60
            dc.b    $04,$F2,$00,$04,$23,$F2,$00,$A8,$00,$08,$80,$00,$09,$F2,$00,$88
            dc.b    $00,$67,$08,$00,$AE,$00,$00,$01,$08,$FF,$84,$4C,$DF,$00,$3C,$4E
            dc.b    $75
.L1:
            dc.l    $80402010,$08040201
sub_4088E71C:
            btst    #1,(-$DC,A6)
            beq.w   .L9
            move.l  (-$F0,A6),D0
            bfextu  D0{6:3},D0
.L1:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            beq.b   .L3
            cmpi.w  #$7FFF,D1
            beq.b   .L3
            tst.l   (4,A0)
            bmi.b   .L3
            bne.b   .L2
            tst.l   (8,A0)
            bne.b   .L2
            clr.w   (A0)
            bra.b   .L3
.L2:
            move.l  D0,-(SP)
            bsr.w   sub_4088FCF8
            move.l  (SP)+,D0
.L3:
            lea     sub_4088E4FE.L1,A1
            move.b  (0,A1,D0.w),D0
            tst.b   (2,A0)
            beq.b   .L4
            bset    #7,(A0)
.L4:
            fmovem.x (A0),D0
            cmpi.b  #$80,D0
            bne.b   .L5
            fmovem.x FP0,(-$B0,A6)
            rts
.L5:
            cmpi.b  #$40,D0
            bne.b   .L6
            fmovem.x FP1,(-$A4,A6)
            rts
.L6:
            cmpi.b  #$20,D0
            bne.b   .L7
            fmovem.x FP2,(-$98,A6)
            rts
.L7:
            cmpi.b  #$10,D0
            bne.b   .L8
            fmovem.x FP3,(-$8C,A6)
            rts
.L8:
            rts
.L9:
            bsr.w   g_opcls
            cmpi.b  #3,D0
            beq.b   .L10
            move.l  (-$E4,A6),D0
            bfextu  D0{6:3},D0
            bra.w   .L1
.L10:
            bsr.w   sub_40890674
            movea.l A0,A1
            movea.l ($C,A6),A0
            tst.l   D0
            beq.w   sub_4088E89C
            cmpi.l  #1,D0
            beq.b   sub_4088E838
sub_4088E7D4:
            moveq   #0,D0
            move.w  (A1),D0
            subi.w  #$3FFF,D0
            cmpi.w  #$4000,D0
            beq.b   .L1
            addi.w  #$3FF,D0
            swap    D0
            lsl.l   #4,D0
            tst.b   (2,A1)
            beq.b   .L3
            bset    #$1F,D0
            bra.b   .L3
.L1:
            move.l  #$7FF00000,D0
            clr.l   (4,A1)
            tst.b   (2,A1)
            beq.b   .L2
            bset    #$1F,D0
.L2:
            move.l  D0,(A1)
            bra.b   .L4
.L3:
            move.l  (4,A1),D1
            bfextu  D1{1:20},D1
            or.l    D1,D0
            move.l  D0,(A1)
            move.l  (4,A1),D1
            moveq   #$15,D0
            lsl.l   D0,D1
            move.l  D1,(4,A1)
            move.l  (8,A1),D1
            bfextu  D1{0:21},D0
            or.l    D0,(4,A1)
.L4:
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            rts
sub_4088E838:
            moveq   #0,D0
            move.w  (A1),D0
            subi.w  #$3FFF,D0
            cmpi.w  #$4000,D0
            beq.b   .L1
            addi.w  #$7F,D0
            swap    D0
            lsl.l   #7,D0
            tst.b   (2,A1)
            beq.b   .L2
            bset    #$1F,D0
            bra.b   .L2
.L1:
            move.l  #$7F800000,D0
            tst.b   (2,A1)
            beq.b   .L3
            bset    #$1F,D0
            bra.b   .L3
.L2:
            move.l  (4,A1),D1
            bfextu  D1{1:23},D1
            or.l    D1,D0
.L3:
            move.l  D0,(-$54,A6)
            moveq   #4,D0
            tst.l   A0
            beq.b   .L4
            lea     (-$54,A6),A1
            move.l  (A1),(A0)
            rts
.L4:
            movea.l (-$78,A6),A0
            sub.l   D1,D1
            move.w  (A0),D1
            andi.w  #7,D1
            ori.b   #$10,D1
            bra.w   sub_40890882
sub_4088E89C:
            tst.b   (2,A1)
            beq.b   .L1
            bset    #7,(A1)
.L1:
            clr.b   (2,A1)
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            rts
            ds.b    14
.L2:
            dc.l    $3F81407E,$3F6A0000
.L3:
            dc.l    $3C0143FE,$3BCD0000
res_func:
            clr.b   (-$4A,A6)
            clr.b   (-$49,A6)
            clr.b   (-$46,A6)
            tst.b   (-$48,A6)
            beq.b   .L3
            bfextu  (-$E0,A6){0:3},D0
            bmi.b   .L1
            cmpi.b  #1,D0
            bne.b   .L3
            bfclr   (-$D8,A6){1:15}
            bra.b   .L3
.L1:
            lea     (-$D8,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L2
            bset    #7,(A0)
.L2:
            bfclr   (-$E0,A6){0:4}
            bset    #4,(-$E0,A6)
            ori.b   #$F,(-$4A,A6)
.L3:
            lea     (-$CC,A6),A0
            btst    #5,(-$E4,A6)
            bne.w   .L107
            bfextu  (-$E8,A6){0:3},D0
            bmi.w   .L24
            cmpi.b  #1,D0
            bne.b   .L4
            bfclr   (-$CC,A6){1:15}
.L4:
            tst.b   (-$48,A6)
            bne.w   .L27
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            btst    #0,D0
            bne.w   .L27
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.b  #$3B,D0
            tst.b   D0
            beq.w   .L11
            cmpi.b  #$18,D0
            beq.b   .L9
            cmpi.b  #$1A,D0
            beq.b   .L10
            move.w  (A0),D0
            bclr    #$F,D0
            sne     (2,A0)
            beq.b   .L5
            ori.l   #$8000000,(-$7C,A6)
.L5:
            cmpi.w  #$7FFF,D0
            bne.b   .L7
            tst.l   (4,A0)
            bne.b   .L6
            tst.l   (8,A0)
            bne.b   .L6
            ori.l   #$2000000,(-$7C,A6)
            rts
.L6:
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            rts
.L7:
            tst.l   (4,A0)
            bne.b   .L8
            tst.l   (8,A0)
            bne.b   .L8
            ori.l   #$4000000,(-$7C,A6)
.L8:
            rts
.L9:
            move.b  (-$E8,A6),D0
            btst    #5,D0
            bne.w   .L97
            bclr    #7,(A0)
            bra.b   .L11
.L10:
            move.b  (-$E8,A6),D0
            btst    #5,D0
            bne.w   .L97
            bchg    #7,(A0)
.L11:
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            bne.w   .L97
            btst    #2,(-$E3,A6)
            bne.b   .L12
            btst    #6,(-$E3,A6)
            bne.b   .L14
            bfextu  (-$7D,A6){0:2},D0
            beq.w   .L21
            cmpi.b  #1,D0
            beq.b   .L14
.L12:
            bfextu  (-$7D,A6){2:2},D1
            ori.l   #$20000,D1
            move.l  D1,-(SP)
            bclr    #7,(A0)
            sne     (2,A0)
            moveq   #2,D0
            move.w  (A0),D1
            cmpi.w  #$3C01,D1
            blt.b   .L17
            move.l  (SP)+,D1
            moveq   #0,D0
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L13
            bset    #7,(A0)
.L13:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$43FF,D1
            bge.b   .L16
            bra.w   .L21
.L14:
            bfextu  (-$7D,A6){2:2},D1
            ori.l   #$10000,D1
            move.l  D1,-(SP)
            bclr    #7,(A0)
            sne     (2,A0)
            moveq   #1,D0
            move.w  (A0),D1
            cmpi.w  #$3F81,D1
            blt.b   .L17
            move.l  (SP)+,D1
            moveq   #0,D0
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L15
            bset    #7,(A0)
.L15:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$407F,D1
            blt.b   .L21
.L16:
            bsr.w   sub_40890AB4
            bra.b   .L21
.L17:
            bsr.w   sub_4088FD4A
            move.l  (SP)+,D1
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L18
            bset    #7,(A0)
.L18:
            ori.l   #$800,(-$7C,A6)
            btst    #1,(-$7A,A6)
            beq.b   .L19
            ori.l   #$20,(-$7C,A6)
.L19:
            tst.l   (4,A0)
            bne.b   .L20
            tst.l   (8,A0)
            bne.b   .L20
            andi.w  #$8000,(A0)
            bra.b   .L22
.L20:
            bsr.w   sub_4088FCF8
            bra.b   .L23
.L21:
            tst.l   (4,A0)
            bne.b   .L23
            tst.l   (8,A0)
            bne.b   .L23
.L22:
            ori.l   #$4000000,(-$7C,A6)
.L23:
            tst.w   (A0)
            bpl.w   .L97
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L97
.L24:
            tst.b   (-$48,A6)
            bne.b   .L25
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            btst    #0,D0
            bne.b   .L25
            st      (-$46,A6)
            bra.b   .L29
.L25:
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L26
            bset    #7,(A0)
.L26:
            bfclr   (-$E8,A6){0:4}
            bset    #4,(-$E8,A6)
            ori.b   #$F0,(-$4A,A6)
.L27:
            tst.b   (-$4A,A6)
            bne.w   .L50
.L28:
            move.b  #$FE,(-$11C,A6)
            bclr    #2,(-$DC,A6)
            clr.w   (-$EC,A6)
            st      (-$49,A6)
            rts
.L29:
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.b  #$3B,D0
            tst.b   D0
            beq.b   .L36
            cmpi.b  #$18,D0
            beq.b   .L34
            cmpi.b  #$1A,D0
            beq.b   .L35
            move.w  (A0),D0
            bclr    #$F,D0
            sne     (2,A0)
            beq.b   .L30
            ori.l   #$8000000,(-$7C,A6)
.L30:
            cmpi.w  #$7FFF,D0
            bne.b   .L32
            tst.l   (4,A0)
            bne.b   .L31
            tst.l   (8,A0)
            bne.b   .L31
            ori.l   #$2000000,(-$7C,A6)
            rts
.L31:
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            rts
.L32:
            tst.l   (4,A0)
            bne.b   .L33
            tst.l   (8,A0)
            bne.b   .L33
            ori.l   #$4000000,(-$7C,A6)
.L33:
            rts
.L34:
            bclr    #7,(A0)
            bra.b   .L36
.L35:
            bchg    #7,(A0)
.L36:
            btst    #2,(-$E3,A6)
            bne.b   .L37
            btst    #6,(-$E3,A6)
            bne.b   .L39
            bfextu  (-$7D,A6){0:2},D0
            tst.b   D0
            beq.b   .L41
            cmpi.b  #1,D0
            beq.b   .L39
.L37:
            bfextu  (-$7D,A6){2:2},D1
            tst.w   (A0)
            blt.b   .L38
            cmpi.b  #3,D1
            bne.b   .L42
            bra.b   .L43
.L38:
            cmpi.b  #2,D1
            bne.b   .L45
            bra.w   .L46
.L39:
            bfextu  (-$7D,A6){2:2},D1
            tst.w   (A0)
            blt.b   .L40
            cmpi.b  #3,D1
            bne.b   .L42
            bra.w   .L48
.L40:
            cmpi.b  #2,D1
            bne.b   .L45
            bra.w   .L49
.L41:
            ori.l   #$800,(-$7C,A6)
            tst.w   (A0)
            beq.w   .L97
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L97
.L42:
            clr.l   (A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            ori.l   #$4000A28,(-$7C,A6)
            bra.w   .L97
.L43:
            move.l  #$3BCD0000,(A0)
.L44:
            move.l  #$80000000,(4,A0)
            clr.l   (8,A0)
            ori.l   #$A28,(-$7C,A6)
            bra.w   .L97
.L45:
            move.l  #$80000000,(A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            ori.l   #$C000A28,(-$7C,A6)
            bra.w   .L97
.L46:
            move.l  #$BBCD0000,(A0)
.L47:
            move.l  #$80000000,(4,A0)
            clr.l   (8,A0)
            ori.l   #$8000A28,(-$7C,A6)
            bra.w   .L97
.L48:
            move.l  #$3F6A0000,(A0)
            bra.b   .L44
.L49:
            move.l  #$BF6A0000,(A0)
            bra.b   .L47
.L50:
            tst.b   (-$48,A6)
            beq.w   .L28
            move.w  (-$E4,A6),D0
            andi.w  #$3B,D0
            cmpi.w  #$22,D0
            beq.w   .L56
            cmpi.w  #$28,D0
            beq.w   .L65
            cmpi.w  #$23,D0
            beq.w   .L78
            cmpi.w  #$38,D0
            beq.w   .L75
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L51
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$7FFF,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.w   .L80
.L51:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
            clr.b   (-$10A,A6)
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.b   .L52
            st      (-$10A,A6)
.L52:
            bclr    #2,(-$DC,A6)
            ori.l   #$1048,(-$7C,A6)
            clr.w   (-$EC,A6)
            lea     (-$10C,A6),A0
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L54
            btst    #2,D0
            bne.b   .L53
            moveq   #1,D0
            bra.b   .L55
.L53:
            moveq   #2,D0
            bra.b   .L55
.L54:
            bfextu  (-$7D,A6){0:2},D0
.L55:
            bsr.w   sub_408904E2
            bfclr   (-$10A,A6){0:8}
            beq.w   .L92
            bset    #7,(-$10C,A6)
            bra.w   .L92
.L56:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L57
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.b   .L58
.L57:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
.L58:
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.w   .L60
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L59
            move.w  (-$D8,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$D8,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$CC,A6),FP0
            fadd.x  (-$D8,A6),FP0
            lea     (-$10C,A6),A0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L59:
            move.w  (-$CC,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$CC,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$CC,A6),FP0
            fadd.x  (-$D8,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L60:
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L62
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            bsr.w   round
            bfclr   (-$CA,A6){0:8}
            beq.b   .L61
            bset    #7,(-$CC,A6)
.L61:
            lea     (-$10C,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            tst.w   (-$CC,A6)
            bgt.b   .L64
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L64
.L62:
            lea     (-$D8,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$D8,A6)
            sne     (-$D6,A6)
            bsr.w   round
            bfclr   (-$D6,A6){0:8}
            beq.b   .L63
            bset    #7,(-$D8,A6)
.L63:
            lea     (-$10C,A6),A0
            move.l  (-$D8,A6),(A0)
            move.l  (-$D4,A6),(4,A0)
            move.l  (-$D0,A6),(8,A0)
            tst.w   (-$D8,A6)
            bgt.b   .L64
            ori.l   #$8000000,(-$7C,A6)
.L64:
            move.w  (-$10C,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$7FFF,D0
            bne.w   .L87
            ori.l   #$2001048,(-$7C,A6)
            clr.l   (4,A0)
            bra.w   .L87
.L65:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L66
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.b   .L67
.L66:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
.L67:
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            bne.w   .L69
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L68
            move.w  (-$D8,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$D8,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$D8,A6),FP0
            fsub.x  (-$CC,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L68:
            move.w  (-$CC,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$CC,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$D8,A6),FP0
            fsub.x  (-$CC,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L69:
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L72
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            eori.w  #$8000,(-$CC,A6)
            tst.w   (-$CC,A6)
            bgt.b   .L70
            ori.l   #$8000000,(-$7C,A6)
.L70:
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            bsr.w   round
            bfclr   (-$CA,A6){0:8}
            beq.b   .L71
            bset    #7,(-$CC,A6)
.L71:
            lea     (-$10C,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bra.b   .L74
.L72:
            lea     (-$D8,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$D8,A6)
            sne     (-$D6,A6)
            bsr.w   round
            bfclr   (-$D6,A6){0:8}
            beq.b   .L73
            bset    #7,(-$D8,A6)
.L73:
            lea     (-$10C,A6),A0
            move.l  (-$D8,A6),(A0)
            move.l  (-$D4,A6),(4,A0)
            move.l  (-$D0,A6),(8,A0)
            tst.w   (-$D8,A6)
            bgt.b   .L74
            ori.l   #$8000000,(-$7C,A6)
.L74:
            move.w  (-$10C,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$7FFF,D0
            bne.w   .L87
            ori.l   #$2001048,(-$7C,A6)
            clr.l   (4,A0)
            bra.w   .L87
.L75:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L76
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            tst.w   (-$CC,A6)
            bge.b   .L77
            rts
.L76:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
            tst.w   (-$D8,A6)
            blt.b   .L77
            rts
.L77:
            ori.l   #$8000000,(-$7C,A6)
            rts
.L78:
            cmpi.b  #$FF,(-$4A,A6)
            beq.b   .L80
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L79
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            add.l   D1,D0
            bgt.w   .L28
            btst    #5,(-$E8,A6)
            bne.w   .L28
            bra.b   .L80
.L79:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            add.l   D1,D0
            bgt.w   .L28
            btst    #5,(-$E0,A6)
            bne.w   .L28
.L80:
            bclr    #2,(-$DC,A6)
            ori.l   #$A28,(-$7C,A6)
            clr.w   (-$EC,A6)
            clr.b   (-$10A,A6)
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.b   .L81
            st      (-$10A,A6)
.L81:
            lea     (-$10C,A6),A0
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L83
            btst    #2,D0
            bne.b   .L82
            moveq   #1,D0
            bra.b   .L84
.L82:
            moveq   #2,D0
            bra.b   .L84
.L83:
            bfextu  (-$7D,A6){0:2},D0
.L84:
            bsr.w   sub_40890720
            tst.w   (A0)
            beq.b   .L86
            tst.l   (4,A0)
            bne.b   .L85
            tst.l   (8,A0)
            bne.b   .L85
            clr.w   (A0)
            bra.b   .L86
.L85:
            bsr.w   sub_4088FCF8
.L86:
            bfclr   (-$10A,A6){0:8}
            beq.b   .L92
            bset    #7,(-$10C,A6)
            bra.b   .L92
.L87:
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L89
            btst    #2,D0
            bne.b   .L88
            moveq   #1,D0
            bra.b   .L90
.L88:
            moveq   #2,D0
            bra.b   .L90
.L89:
            bfextu  (-$7D,A6){0:2},D0
            tst.b   D0
            beq.b   .L92
.L90:
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   sub_408904E2
            bfclr   (-$10A,A6){0:8}
            beq.b   .L91
            bset    #7,(-$10C,A6)
.L91:
            ori.l   #$1248,(-$7C,A6)
.L92:
            bfextu  (-$E4,A6){6:3},D0
            cmpi.b  #3,D0
            ble.b   .L93
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x (-$10C,A6),D0
            rts
.L93:
            cmpi.b  #0,D0
            beq.b   .L96
            cmpi.b  #1,D0
            beq.b   .L95
            cmpi.b  #2,D0
            beq.b   .L94
            move.l  (-$10C,A6),(-$8C,A6)
            move.l  (-$108,A6),(-$88,A6)
            move.l  (-$104,A6),(-$84,A6)
            rts
.L94:
            move.l  (-$10C,A6),(-$98,A6)
            move.l  (-$108,A6),(-$94,A6)
            move.l  (-$104,A6),(-$90,A6)
            rts
.L95:
            move.l  (-$10C,A6),(-$A4,A6)
            move.l  (-$108,A6),(-$A0,A6)
            move.l  (-$104,A6),(-$9C,A6)
            rts
.L96:
            move.l  (-$10C,A6),(-$B0,A6)
            move.l  (-$108,A6),(-$AC,A6)
            move.l  (-$104,A6),(-$A8,A6)
            rts
.L97:
            btst    #6,(-$7A,A6)
            beq.b   .L99
            btst    #6,(-$7E,A6)
            beq.b   .L99
            move.l  (-$CC,A6),(-$D8,A6)
            tst.b   (-$CC,A6)
            blt.b   .L98
            rts
.L98:
            ori.l   #3,(-$7C,A6)
            rts
.L99:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$40,D0
            bne.b   .L100
            ori.l   #$2000000,(-$7C,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L102
.L100:
            cmpi.b  #$60,D0
            bne.b   .L101
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L102
.L101:
            cmpi.b  #$20,D0
            bne.b   .L102
            ori.l   #$4000000,(-$7C,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
.L102:
            bfextu  (-$E4,A6){6:3},D0
            cmpi.b  #3,D0
            ble.b   .L103
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x (-$CC,A6),D0
            rts
.L103:
            cmpi.b  #0,D0
            beq.b   .L106
            cmpi.b  #1,D0
            beq.b   .L105
            cmpi.b  #2,D0
            beq.b   .L104
            move.l  (-$CC,A6),(-$8C,A6)
            move.l  (-$C8,A6),(-$88,A6)
            move.l  (-$C4,A6),(-$84,A6)
            rts
.L104:
            move.l  (-$CC,A6),(-$98,A6)
            move.l  (-$C8,A6),(-$94,A6)
            move.l  (-$C4,A6),(-$90,A6)
            rts
.L105:
            move.l  (-$CC,A6),(-$A4,A6)
            move.l  (-$C8,A6),(-$A0,A6)
            move.l  (-$C4,A6),(-$9C,A6)
            rts
.L106:
            move.l  (-$CC,A6),(-$B0,A6)
            move.l  (-$C8,A6),(-$AC,A6)
            move.l  (-$C4,A6),(-$A8,A6)
            rts
.L107:
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.w  #$C00,D0
            cmpi.w  #$C00,D0
            beq.w   set_xop.L4
            bra.b   .L109
.L108:
            dc.l    $007A02B0,$02960020,$010C02DE,$018A0020
.L109:
            bfextu  (-$E4,A6){3:3},D1
            lea     .L108,A0
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
mvout_end:
            btst    #1,(-$7A,A6)
            beq.b   .L1
            btst    #3,(-$7A,A6)
            beq.b   .L1
            bset    #5,(-$79,A6)
.L1:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            fmove.l #0,FPSR
            bfclr   (-$CA,A6){0:8}
            beq.b   .L2
            bset    #7,(-$CC,A6)
.L2:
            rts
sub_4088F5EC:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            fmove.l #0,FPSR
            bfclr   (-$CA,A6){0:8}
            beq.b   .L1
            bset    #7,(-$CC,A6)
.L1:
            rts
            moveq   #4,D0
            btst    #7,(-$E8,A6)
            bne.w   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.d  #"$41DFFFFFFFC00000",FP0
            fbge.w  .L2
            fcmp.d  #"$C1E0000000000000",FP0
            fble.w  .L3
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.l FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.w   .L12
.L2:
            move.l  #$7FFFFFFF,(-$54,A6)
            fbeq.w  .L12
            fcmp.d  #"$41DFFFFFFFE00000",FP0
            fbge.w  .L11
            bra.w   .L10
.L3:
            move.l  #$80000000,(-$54,A6)
            fbeq.w  .L12
            fcmp.d  #"$C1E0000000100000",FP0
            fblt.w  .L11
            bra.w   .L10
            moveq   #2,D0
            btst    #7,(-$E8,A6)
            bne.w   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.s  #"$46FFFE00",FP0
            fbge.w  .L4
            fcmp.s  #"$C7000000",FP0
            fble.w  .L5
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.w FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.w   .L12
.L4:
            move.w  #$7FFF,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$46FFFF00",FP0
            fbge.w  .L11
            bra.w   .L10
.L5:
            move.w  #$8000,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$C7000080",FP0
            fblt.w  .L11
            bra.w   .L10
            moveq   #1,D0
            btst    #7,(-$E8,A6)
            bne.b   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.s  #"$42FE0000",FP0
            fbge.w  .L6
            fcmp.s  #"$C3000000",FP0
            fble.w  .L7
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.b FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.b   .L12
.L6:
            move.b  #$7F,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$42FF0000",FP0
            fbge.w  .L11
            bra.b   .L10
.L7:
            move.b  #$80,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$C3008000",FP0
            fblt.w  .L11
            bra.b   .L10
.L8:
            clr.l   (-$54,A6)
            bfextu  (-$7D,A6){2:2},D1
            cmpi.b  #2,D1
            bmi.b   .L10
            bne.b   .L9
            tst.w   (-$CC,A6)
            bpl.b   .L10
            move.l  #$FFFFFFFF,(-$54,A6)
            bra.b   .L10
.L9:
            tst.w   (-$CC,A6)
            bmi.b   .L10
            lea     (-$54,A6),A1
            adda.l  D0,A1
            subq.l  #1,A1
            bset    #0,(A1)
.L10:
            ori.l   #$208,(-$7C,A6)
            bra.b   .L12
.L11:
            fmovem.x FP0,(-$D8,A6)
            ori.l   #$2080,(-$7C,A6)
.L12:
            movea.l ($C,A6),A1
            tst.l   A1
            beq.b   .L13
            lea     (-$54,A6),A0
            bsr.w   sub_4088D248
            bra.w   sub_4088F5EC
.L13:
            move.l  D0,D1
            movea.l (-$78,A6),A0
            sub.l   D0,D0
            move.w  (A0),D0
            andi.w  #7,D0
            cmpi.l  #4,D1
            beq.b   .L14
            cmpi.l  #2,D1
            bne.b   .L15
            ori.l   #8,D0
            bra.b   .L15
.L14:
            ori.l   #$10,D0
.L15:
            move.l  D0,D1
            bsr.w   sub_40890882
            bra.w   sub_4088F5EC
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L19
            moveq   #0,D0
            bra.b   .L16
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L22
            move.w  (A0),D0
            lea     sub_4088E89C.L2,A1
            cmp.w   (A1),D0
            blt.w   .L20
            cmp.w   (2,A1),D0
            bgt.w   .L24
            moveq   #1,D0
            bra.b   .L16
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L23
            move.w  (A0),D0
            lea     sub_4088E89C.L3,A1
            cmp.w   (A1),D0
            blt.w   .L21
            cmp.w   (2,A1),D0
            bgt.w   .L25
            moveq   #2,D0
.L16:
            bfextu  (-$7D,A6){2:2},D1
            swap    D0
            add.l   D0,D1
            moveq   #0,D0
            bsr.w   round
            movea.l A0,A1
            movea.l ($C,A6),A0
            bfextu  (-$E4,A6){3:3},D1
            cmpi.b  #2,D1
            bgt.b   .L18
            bne.b   .L17
            bsr.w   sub_4088E89C
            bra.w   mvout_end
.L17:
            bsr.w   sub_4088E838
            bra.w   mvout_end
.L18:
            bsr.w   sub_4088E7D4
            bra.w   mvout_end
.L19:
            bsr.w   set_xop
            bset    #4,(-$DF,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E89C
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L20:
            bset    #4,(-$E8,A6)
            cmp.w   (4,A1),D0
            ble.b   .L22
            moveq   #1,D0
            move.l  #$3F81,D1
            bsr.w   sub_4088FA04
            bsr.w   sub_4088E838
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L21:
            bset    #4,(-$E8,A6)
            cmp.w   (4,A1),D0
            ble.b   .L23
            move.l  #$3C01,D1
            moveq   #2,D0
            bsr.w   sub_4088FA04
            bsr.w   sub_4088E7D4
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L22:
            move.l  (-$7C,A6),-(SP)
            moveq   #1,D0
            bsr.w   sub_40890720
            move.l  (SP)+,(-$7C,A6)
            moveq   #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E838
            ori.l   #$A28,(-$7C,A6)
            bra.w   mvout_end
.L23:
            move.l  (-$7C,A6),-(SP)
            moveq   #2,D0
            bsr.w   sub_40890720
            move.l  (SP)+,(-$7C,A6)
            moveq   #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E7D4
            ori.l   #$A28,(-$7C,A6)
            bra.w   mvout_end
.L24:
            move.l  (-$7C,A6),-(SP)
            moveq   #1,D0
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bsr.w   sub_408904E2
            move.l  (SP)+,(-$7C,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E838
            ori.l   #$1248,(-$7C,A6)
            bra.w   mvout_end
.L25:
            move.l  (-$7C,A6),-(SP)
            moveq   #2,D0
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bsr.w   sub_408904E2
            move.l  (SP)+,(-$7C,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E7D4
            ori.l   #$1248,(-$7C,A6)
            bra.w   mvout_end
sub_4088FA04:
            move.l  D0,-(SP)
            moveq   #0,D0
            bsr.w   sub_4088FDD0
            bfextu  (-$7D,A6){2:2},D1
            swap    D1
            move.w  (2,SP),D1
            swap    D1
            bsr.w   round
            move.w  #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            addq.w  #4,SP
            rts
set_xop:
            move.l  (A0),(-$10C,A6)
            move.l  (4,A0),(-$108,A6)
            move.l  (8,A0),(-$104,A6)
            bfclr   (-$10A,A6){0:8}
            beq.b   .L1
            bset    #7,(-$10C,A6)
.L1:
            bfclr   (-$E8,A6){5:4}
            rts
.L2:
            dc.w    $0042,$0078,$008A,$009C,$0042
.L3:
            dc.l    $009C00A2,$00A800AC,$00B000B4,$00B800BC
.L4:
            lea     .L2,A0
            move.w  (-$E8,A6),D0
            bfextu  D0{16:3},D0
            adda.w  (0,A0,D0.w*2),A0
            jmp     (A0)
sub_4088FA80:
            movea.l ($C,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            clr.b   (-$11C,A6)
            bfclr   (-$E0,A6){0:3}
            rts
            move.w  (-$E4,A6),D0
            btst    #$C,D0
            bne.b   .L1
            movea.l (-$78,A6),A0
            move.l  (A0),D0
            bra.b   .L2
.L1:
            bfextu  D0{25:3},D0
            lea     set_xop.L3,A0
            adda.w  (0,A0,D0.w*2),A0
            jmp     (A0)
.L2:
            andi.w  #$7F,D0
            bfexts  D0{25:7},D0
            lea     (-$CC,A6),A0
            bsr.w   sub_4088FF40
            lea     (-$74,A6),A0
            bra.b   sub_4088FA80
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            bra.b   sub_4088FA80
            fmove.l #0,FPSR
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            bra.b   sub_4088FA80
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            bra.b   sub_4088FA80
            move.l  (-$C0,A6),D0
            bra.b   .L2
            move.l  (-$BC,A6),D0
            bra.b   .L2
            move.l  D2,D0
            bra.b   .L2
            move.l  D3,D0
            bra.b   .L2
            move.l  D4,D0
            bra.b   .L2
            move.l  D5,D0
            bra.b   .L2
            move.l  D6,D0
            bra.b   .L2
            move.l  D7,D0
            bra.b   .L2
round:
            bsr.b   sub_4088FB88
            tst.l   D0
            bne.b   .L1
            swap    D1
            bra.w   sub_4088FB88.L12
.L1:
            ori.l   #$208,(-$7C,A6)
            lea     .L2,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
.L2:
            dc.w    $003A,$0034,$001E,$0008,$4841,$4A28,$0002,$6B00
            dc.w    $0138,$70FF,$43FA,$0096,$D2F1,$1200,$4ED1
            swap    D1
            tst.b   (2,A0)
            bpl.w   sub_4088FB88.L12
            moveq   #-1,D0
            lea     sub_4088FB88.L6,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
            swap    D1
            bra.w   sub_4088FB88.L12
            swap    D1
            asl.l   #1,D0
            bcc.w   sub_4088FB88.L12
            lea     sub_4088FB88.L6,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
sub_4088FB88:
            swap    D1
            cmpi.w  #0,D1
            bne.b   .L1
            bra.b   .L5
.L1:
            movem.l D2-D3,-(SP)
            cmpi.w  #1,D1
            bne.b   .L2
            bfextu  (4,A0){24:2},D3
            moveq   #$1E,D2
            lsl.l   D2,D3
            move.l  (4,A0),D2
            andi.l  #$3F,D2
            bne.b   .L3
            tst.l   (8,A0)
            bne.b   .L3
            tst.l   D0
            bne.b   .L3
            bra.b   .L4
.L2:
            bfextu  (8,A0){21:2},D3
            moveq   #$1E,D2
            lsl.l   D2,D3
            move.l  (8,A0),D2
            andi.l  #$1FF,D2
            bne.b   .L3
            tst.l   D0
            bne.b   .L3
            bra.b   .L4
.L3:
            bset    #$1D,D3
.L4:
            move.l  D3,D0
            movem.l (SP)+,D2-D3
.L5:
            swap    D1
            rts
.L6:
            dc.w    $0034,$0008,$005E,$005E,$06A8,0,$0100,$0004
            dc.w    $640A,$E4E8,$0004,$E4E8,$0006,$5250,$4A80,$6606
            dc.w    $0268,$FE00,$0006,$02A8,$FFFF,$FF00,$0004,$42A8
            dc.w    $0008,$4E75
            addq.l  #1,(8,A0)
            bcc.b   .L7
            addq.l  #1,(4,A0)
            bcc.b   .L7
            roxr    (4,A0)
            roxr    (6,A0)
            roxr    (8,A0)
            roxr    ($A,A0)
            addq.w  #1,(A0)
.L7:
            tst.l   D0
            bne.b   .L8
            andi.b  #$FE,($B,A0)
.L8:
            rts
            addi.l  #$800,(8,A0)
            bcc.b   .L9
            addq.l  #1,(4,A0)
            bcc.b   .L9
            roxr    (4,A0)
            roxr    (6,A0)
            roxr    (8,A0)
            roxr    ($A,A0)
            addq.w  #1,(A0)
.L9:
            tst.l   D0
            bne.b   .L10
            andi.w  #$F000,($A,A0)
.L10:
            andi.l  #$FFFFF800,(8,A0)
            rts
.L11:
            dc.l    $0012FF92,$FFF6FFF6
.L12:
            lea     .L11,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
            rts
sub_4088FC90:
            move.w  (A0),D0
            cmpi.w  #$40,D0
            bmi.b   .L1
            bsr.b   sub_4088FCF8
            rts
.L1:
            movem.l D2-D3/D5-D6,-(SP)
            move.l  (4,A0),D1
            move.l  (8,A0),D2
            bfffo   D1{0:0},D3
            beq.b   .L3
            cmp.w   D3,D0
            bmi.b   .L2
            bsr.b   sub_4088FCF8
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L2:
            move.l  D2,D6
            lsl.l   D0,D2
            lsl.l   D0,D1
            moveq   #$20,D5
            sub.l   D0,D5
            lsr.l   D5,D6
            or.l    D6,D1
            moveq   #0,D0
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            move.l  D2,(8,A0)
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L3:
            bfffo   D2{0:0},D3
            beq.b   .L4
            addi.w  #$20,D3
            cmp.w   D3,D0
            bmi.b   .L2
            bsr.b   sub_4088FCF8
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L4:
            clr.w   (A0)
            movem.l (SP)+,D2-D3/D5-D6
            rts
sub_4088FCF8:
            move.l  D7,-(SP)
            bfffo   (4,A0){0:0},D7
            beq.b   .L1
            move.l  D6,-(SP)
            sub.w   D7,(A0)
            move.l  (4,A0),D0
            move.l  (8,A0),D1
            lsl.l   D7,D0
            move.l  D1,D6
            lsl.l   D7,D6
            move.l  D6,(8,A0)
            moveq   #$20,D6
            sub.l   D7,D6
            lsr.l   D6,D1
            or.l    D1,D0
            move.l  D0,(4,A0)
            movem.l (SP)+,D6-D7
            rts
.L1:
            move.w  (A0),D0
            move.l  (8,A0),D1
            subi.w  #$20,D0
            bfffo   D1{0:0},D7
            sub.w   D7,D0
            lsl.l   D7,D1
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            clr.l   (8,A0)
            move.l  (SP)+,D7
            rts
sub_4088FD4A:
            btst    #6,(A0)
            beq.b   .L1
            bset    #7,(A0)
.L1:
            cmpi.b  #0,D0
            bne.b   .L2
            moveq   #0,D1
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L2:
            cmpi.l  #1,D0
            beq.b   .L3
            move.w  #$3C01,D1
            move.l  D1,D0
            sub.w   (A0),D0
            cmpi.w  #$43,D0
            bpl.b   .L4
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L3:
            move.w  #$3F81,D1
            move.l  D1,D0
            sub.w   (A0),D0
            cmpi.w  #$43,D0
            bpl.b   .L4
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L4:
            tst.l   (4,A0)
            bne.b   .L5
            tst.l   (8,A0)
            bne.b   .L5
            bra.b   .L6
.L5:
            ori.l   #$208,(-$7C,A6)
            move.l  #$20000000,D0
.L6:
            move.w  D1,(A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            rts
.L7:
            ori.l   #$208,(-$7C,A6)
.L8:
            rts
sub_4088FDD0:
            move.l  (8,A0),(-8,A6)
            moveq   #0,D0
            btst    #1,(-$DC,A6)
            beq.b   .L1
            move.l  (-$E8,A6),D0
            lsl.l   #6,D0
            andi.l  #$E0000000,D0
.L1:
            move.l  D0,(-4,A6)
            move.l  D1,D0
            sub.w   (A0),D1
            beq.b   .L2
            cmpi.w  #$20,D1
            blt.b   .L3
            cmpi.w  #$40,D1
            blt.b   .L5
            bra.w   .L8
.L2:
            clr.b   D1
            move.l  (-4,A6),D0
            rts
.L3:
            move.l  D2,-(SP)
            move.w  D0,(A0)
            moveq   #$20,D0
            sub.w   D1,D0
            bfextu  (4,A0){D0:0},D2
            move.l  D2,(8,A0)
            bfextu  (4,A0){0:D0},D2
            move.l  D2,(4,A0)
            bfextu  (-4,A6){D0:D1},D2
            bfextu  (-8,A6){D0:0},D0
            tst.l   D2
            sne     D0
            clr.b   D1
            bftst   D0{2:30}
            beq.b   .L4
            bset    #$1D,D0
            st      D1
.L4:
            andi.l  #$E0000000,D0
            move.l  (SP)+,D2
            rts
.L5:
            move.l  D2,-(SP)
            move.w  D0,(A0)
            subi.w  #$20,D1
            moveq   #$20,D0
            sub.w   D1,D0
            bfextu  (4,A0){0:D0},D2
            bfextu  (4,A0){D0:0},D1
            bftst   D1{2:30}
            bne.b   .L6
            bftst   (-8,A6){D0:0}
            bne.b   .L6
            tst.l   (-4,A6)
            bne.b   .L6
            move.l  D1,D0
            clr.b   D1
            bra.b   .L7
.L6:
            move.l  D1,D0
            bset    #$1D,D0
            st      D1
.L7:
            clr.l   (4,A0)
            move.l  D2,(8,A0)
            andi.l  #$E0000000,D0
            move.l  (SP)+,D2
            rts
.L8:
            move.w  D0,(A0)
            tst.w   (2,A0)
            bge.b   .L9
            ori.l   #$80000000,(A0)
.L9:
            cmpi.w  #$40,D1
            beq.b   .L10
            cmpi.w  #$41,D1
            beq.b   .L11
            clr.l   (4,A0)
            clr.l   (8,A0)
            move.l  #$20000000,D0
            st      D1
            rts
.L10:
            move.l  (4,A0),D0
            bfextu  D0{2:30},D1
            andi.l  #$C0000000,D0
            bra.b   .L12
.L11:
            move.l  (4,A0),D0
            bfextu  D0{1:31},D1
            andi.l  #$80000000,D0
            lsr.l   #1,D0
.L12:
            tst.l   D1
            bne.b   .L13
            tst.l   (8,A0)
            bne.b   .L13
            tst.b   (-4,A6)
            bne.b   .L13
            clr.b   D1
            bra.b   .L14
.L13:
            bset    #$1D,D0
            st      D1
.L14:
            clr.l   (4,A0)
            clr.l   (8,A0)
            rts
            dc.w    0
.L15:
            dc.l    $3FFD0000,$9A209A84,$FBCFF798,$00000000 ; label changed <1/2/91, JPO>
.L16:
            dc.l    $3FFD0000,$9A209A84,$FBCFF799,$00000000
.L17:
            dc.l    $00000000,$03030202,$03020203,$02030302
sub_4088FF40:
            movem.l D2-D7/A2,-(SP)
            fmovem.x FP0-FP2,-(SP)
            fmove.l #$20,FPCR
            move.l  (A0),(-$50,A6)
            move.l  D0,D7
            clr.b   (-$4B,A6)
            move.w  (-$E8,A6),D0
            andi.w  #$E000,D0
            beq.b   .L3
            move.w  (A0),D0
            andi.w  #$7FFF,D0
            move.l  (4,A0),D1
            move.l  (8,A0),D2
.L1:
            subq.w  #1,D0
            lsl.l   #1,D2
            roxl.l  #1,D1
            tst.l   D1
            bge.b   .L1
            tst.w   D0
            bgt.b   .L2
            st      (-$4B,A6)
.L2:
            andi.w  #$7FFF,D0
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            move.l  D2,(8,A0)
.L3:
            move.l  (A0),(-$64,A6)
            move.l  (4,A0),(-$60,A6)
            move.l  (8,A0),(-$5C,A6)
            andi.l  #$7FFFFFFF,(-$64,A6)
            tst.b   (-$4B,A6)
            beq.b   .L4
            move.l  #$FFFFECBB,D6
            bra.b   .L6
.L4:
            move.w  (-$64,A6),D0
            move.w  #$3FFF,(-$64,A6)
            fmove.x (-$64,A6),FP0
            subi.w  #$3FFF,D0
            fadd.w  D0,FP0
            fsub.b  #1,FP0
            fbge.w  .L5
            fmul.x  sub_4088FDD0.L16,FP0
            fmove.l FP0,D6
            bra.b   .L6
.L5:
            fmul.x  sub_4088FDD0.L15,FP0
            fmove.l FP0,D6
.L6:
            fmove.l #0,FPSR
            clr.w   D5
.L7:
            tst.l   D7
            ble.b   .L8
            move.l  D7,D4
            bra.b   .L9
.L8:
            move.l  D6,D4
            sub.l   D7,D4
            addq.l  #1,D4
.L9:
            tst.l   D4
            ble.b   .L10
            cmpi.l  #$11,D4
            ble.b   .L11
            moveq   #$11,D4
            tst.l   D7
            ble.b   .L11
            ori.l   #$2080,(-$7C,A6)
            bra.b   .L11
.L10:
            moveq   #1,D4
.L11:
            tst.l   D7
            bgt.b   .L12
            cmp.l   D6,D7
            blt.b   .L12
            move.l  D7,D6
.L12:
            move.l  D6,D0
            addq.l  #1,D0
            sub.l   D4,D0
            swap    D5
            clr.w   D5
            clr.w   D2
            tst.l   D0
            bge.b   .L14
            addq.w  #1,D5
            cmpi.l  #$FFFFECD4,D0
            bgt.b   .L13
            addi.l  #$18,D0
            moveq   #$18,D2
.L13:
            neg.l   D0
.L14:
            fmove.b #1,FP1
            bfextu  (-$80,A6){26:2},D1
            lsl.w   #1,D1
            add.w   D5,D1
            lsl.w   #1,D1
            tst.l   (-$50,A6)
            bge.b   .L15
            addq.l  #1,D1
.L15:
            lea     sub_4088FDD0.L17,A2
            move.b  (0,A2,D1.w),D3
            lsl.l   #4,D3
            fmove.l D3,FPCR
            lsr.l   #4,D3
            tst.b   D3
            bne.b   .L16
            lea     sub_408934EA.L8,A1
            bra.b   .L18
.L16:
            lsr.b   #1,D3
            bcc.b   .L17
            lea     sub_408934EA.L12,A1
            bra.b   .L18
.L17:
            lea     sub_408934EA.L10,A1
.L18:
            moveq   #0,D3
.L19:
            lsr.l   #1,D0
            bcc.b   .L20
            fmul.x  (0,A1,D3.w),FP1
.L20:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L19
            fmove.l #0,FPSR
            fmove.l #$10,FPCR
            fmove.x (A0),FP0
            fabs.x  FP0,FP0
            tst.w   D5
            bne.b   .L21
            fdiv.x  FP1,FP0
            bra.b   .L25
.L21:
            tst.b   (-$4B,A6)
            beq.b   .L23
            fmovem.x FP1,-(SP)
            move.l  (8,A0),-(SP)
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            moveq   #$12,D3
.L22:
            clr.l   -(SP)
            dbra    D3,.L22
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.b  #$10,($44,SP)
            move.w  #$23,($40,SP)
            move.b  #$FE,(8,SP)
            frestore (SP)+
            fmul.x  ($24,A1),FP0
            fmul.x  ($30,A1),FP0
            bra.b   .L25
.L23:
            tst.w   D2
            beq.b   .L24
            fmul.x  ($24,A1),FP0
            fmul.x  ($30,A1),FP0
.L24:
            fmul.x  FP1,FP0
.L25:
            fmove.l FPSR,D0
            fmove.x FP0,(-$64,A6)
            lea     (-$64,A6),A2
            btst    #9,D0
            beq.b   .L26
            ori.l   #1,(8,A2)
            fmove.x (-$64,A6),FP0
.L26:
            move.l  (-$80,A6),(-$54,A6)
            andi.l  #$30,(-$80,A6)
            movem.l D0-D1/A0-A1,-(SP)
            move.l  (-$54,A6),-(SP)
            move.l  (-$50,A6),-(SP)
            lea     (-$64,A6),A0
            fmove.x FP0,(A0)
            tst.l   (-$50,A6)
            bge.b   .L27
            ori.l   #$80000000,(A0)
.L27:
            move.l  (-$7C,A6),-(SP)
            bsr.w   sub_408915C0
            move.b  (SP),(-$7C,A6)
            addq.l  #4,SP
            move.l  (SP)+,(-$50,A6)
            move.l  (SP)+,(-$54,A6)
            movem.l (SP)+,D0-D1/A0-A1
            move.l  (-$50,A6),(-$64,A6)
            move.l  (-$54,A6),(-$80,A6)
            swap    D5
            tst.w   D5
            bne.w   .L33
            fmove.b #1,FP2
            move.l  D4,D0
            subq.l  #1,D0
            moveq   #0,D3
.L28:
            lsr.l   #1,D0
            bcc.b   .L29
            fmul.x  (0,A1,D3.w),FP2
.L29:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L28
            tst.b   (-$4B,A6)
            beq.b   .L30
            fabs.x  FP0,FP0
            bra.b   .L31
.L30:
            fabs.x  FP0,FP0
            fcmp.x  FP2,FP0
            fbge.w  .L31
            subq.l  #1,D6
            move.w  #1,D5
            fmove.l #$20,FPCR
            fmul.b  #$A,FP2
            bra.w   .L7
.L31:
            fmul.b  #$A,FP2
            fcmp.x  FP2,FP0
            fblt.w  .L36
            fbgt.w  .L32
            fdiv.b  #$A,FP0
            addq.l  #1,D6
            bra.b   .L36
.L32:
            addq.l  #1,D6
            move.w  #1,D5
            fmove.l #$20,FPCR
            bra.w   .L7
.L33:
            fmove.b #1,FP2
            move.l  D4,D0
            moveq   #0,D3
.L34:
            lsr.l   #1,D0
            bcc.b   .L35
            fmul.x  (0,A1,D3.w),FP2
.L35:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L34
            fabs.x  FP0,FP0
            fcmp.x  FP2,FP0
            fbne.w  .L36
            fdiv.b  #$A,FP0
            addq.l  #1,D6
            addq.l  #1,D4
            fmul.b  #$A,FP2
.L36:
            fmove.l #$10,FPCR
            fdiv.x  FP2,FP0
            lea     (-$74,A6),A0
            fmove.x FP0,(A0)
            move.l  (4,A0),D2
            move.l  (8,A0),D3
            clr.l   (4,A0)
            clr.l   (8,A0)
            move.l  (A0),D0
            swap    D0
            beq.b   .L38
            subi.l  #$3FFD,D0
            tst.l   D0
            bgt.b   .L38
            neg.l   D0
.L37:
            lsr.l   #1,D2
            roxr.l  #1,D3
            dbra    D0,.L37
.L38:
            tst.l   D2
            bne.b   .L39
            tst.l   D3
            beq.b   .L40
.L39:
            moveq   #0,D1
            addi.l  #$80,D3
            addx.l  D1,D2
            andi.l  #$FFFFFF80,D3
.L40:
            move.l  D4,D0
            addq.l  #3,A0
            bsr.w   sub_40890392
            tst.b   (-$4B,A6)
            beq.b   .L43
            ftst.x  FP0
            fbeq.w  .L41
            fmove.l D6,FP0
            fabs.x  FP0,FP0
            bra.b   .L45
.L41:
            tst.l   D7
            blt.b   .L42
            fmove.w #$1345,FP0
            bra.b   .L45
.L42:
            fmove.l D6,FP0
            fabs.x  FP0,FP0
            bra.b   .L45
.L43:
            ftst.x  FP0
            fbne.w  .L44
            fmove.b #1,FP0
            bra.b   .L45
.L44:
            fmove.l D6,FP0
            fabs.x  FP0,FP0
.L45:
            fdiv.x  ($18,A1),FP0
            fmove.x FP0,(-$64,A6)
            move.l  (4,A2),D2
            move.l  (8,A2),D3
            move.w  (A2),D0
            beq.b   .L47
            subi.w  #$3FFD,D0
            neg.w   D0
.L46:
            lsr.l   #1,D2
            roxr.l  #1,D3
            dbra    D0,.L46
.L47:
            moveq   #0,D1
            addi.l  #$80,D3
            addx.l  D1,D2
            andi.l  #$FFFFFF80,D3
            moveq   #4,D0
            lea     (-$54,A6),A0
            bsr.b   sub_40890392
            move.l  (-$54,A6),D0
            moveq   #$C,D1
            lsr.l   D1,D0
            bfins   D0,(-$74,A6){4:12}
            lsr.l   D1,D0
            bfins   D0,(-$74,A6){16:4}
            tst.b   D0
            beq.b   .L48
            ori.l   #$2080,(-$7C,A6)
.L48:
            moveq   #0,D0
            andi.b  #$F,(-$74,A6)
            tst.l   (-$50,A6)
            bge.b   .L49
            moveq   #2,D0
.L49:
            tst.l   D6
            bge.b   .L50
            addq.l  #1,D0
.L50:
            bfins   D0,(-$74,A6){0:2}
            fmove.l #0,FPSR
            fmovem.x (SP)+,FP0-FP2
            movem.l (SP)+,D2-D7/A2
            rts
sub_40890392:
            movem.l D0-D7,-(SP)
            moveq   #1,D7
            subq.l  #1,D0
.L1:
            move.l  D2,D4
            move.l  D3,D5
            bfextu  D2{0:3},D1
            asl.l   #3,D2
            bfextu  D3{0:3},D6
            asl.l   #3,D3
            or.l    D6,D2
            asl.l   #1,D5
            roxl.l  #1,D4
            swap    D6
            addx.w  D6,D1
            add.l   D5,D3
            nop
            addx.l  D4,D2
            nop
            addx.w  D6,D1
            swap    D6
            tst.w   D7
            beq.b   .L2
            swap    D7
            asl.w   #4,D7
            add.w   D1,D7
            move.b  D7,(A0)+
            swap    D7
            clr.w   D7
            dbra    D0,.L1
            bra.b   .L3
.L2:
            swap    D7
            move.w  D1,D7
            swap    D7
            addq.w  #1,D7
            dbra    D0,.L1
            swap    D7
            lsl.w   #4,D7
            move.b  D7,(A0)+
.L3:
            movem.l (SP)+,D0-D7
            rts
            dc.w    0
.L4:
            dc.l    $7FFF0000,$00000000,$00000000,$00000000
.L5:
            dc.l    $7FFE0000,$FFFFFFFF,$FFFFFFFF,$00000000
.L8:
            dc.l    $407E0000,$FFFFFF00,$00000000,$00000000
.L6:
            dc.l    $43FE0000,$FFFFFFFF,$FFFFF800,$00000000
.L7:
            dc.l    $00C600D4,$00DC00FA,$016A0176,$017C0196
            dc.l    $011C012A,$0132014C,$01D001D0,$01D001D0
ovf_r_k:
            lea     (-$CC,A6),A0
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            tst.b   (-$47,A6)
            beq.b   .L1
            btst    #6,(-$E3,A6)
            beq.b   .L1
            moveq   #1,D0
            btst    #2,(-$E3,A6)
            beq.b   sub_408904E2
            addq.l  #1,D0
            bra.b   sub_408904E2
.L1:
            bfextu  (-$7D,A6){0:2},D0
            bra.b   sub_408904E2
ovf_r_x2:
            btst    #1,(-$DC,A6)
            beq.b   .L4
            move.w  (-$F0,A6),D0
            andi.w  #$7F,D0
            btst    #6,D0
            beq.b   .L2
            btst    #5,D0
            beq.b   .L1
            moveq   #2,D0
            bra.b   sub_408904E2
.L1:
            moveq   #1,D0
            bra.b   sub_408904E2
.L2:
            cmpi.w  #$30,D0
            beq.b   .L3
            cmpi.w  #$33,D0
            bne.b   .L6
.L3:
            moveq   #0,D0
            bra.b   sub_408904E2
.L4:
            move.w  (-$E4,A6),D0
            andi.l  #$44,D0
            btst    #6,D0
            beq.b   .L6
            addq.l  #1,D0
            btst    #2,D0
            beq.b   .L5
            addq.l  #1,D0
.L5:
            andi.b  #3,D0
            bra.b   sub_408904E2
.L6:
            bfextu  (-$7D,A6){0:2},D0
            bra.b   sub_408904E2
sub_408904DE:
            bsr.w   sub_40890674
sub_408904E2:
            lsl.l   #2,D0
            bfextu  (-$7D,A6){2:2},D1
            or.l    D1,D0
            lea     sub_40890392.L7,A1
            adda.w  (0,A1,D0.w*2),A1
            jmp     (A1)
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890392.L5,A1
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L1
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.w   .L6
.L1:
            lea     sub_40890392.L5,A1
            bra.w   .L6
            tst.b   (2,A0)
            beq.b   .L2
            lea     sub_40890392.L5,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L2:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L6
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890392.L6,A1
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L3
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.b   .L6
.L3:
            lea     sub_40890392.L6,A1
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L4
            lea     sub_40890392.L6,A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L4:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L6
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L5
            lea     sub_40890392.L8(PC),A1
            bra.b   .L5
            tst.b   (2,A0)
            beq.b   .L7
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.b   .L6
.L7:
            lea     sub_40890392.L8(PC),A1
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L8
            lea     sub_40890392.L8(PC),A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L8:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L6
.L5:
            tst.b   (2,A0)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            move.w  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  (8,A1),(8,A0)
            rts
            rts
sub_40890602:
            bsr.b   g_opcls
            cmpi.w  #3,D0
            bne.b   .L1
            bsr.b   sub_40890674
            rts
.L1:
            btst    #1,(-$DC,A6)
            beq.b   .L3
            move.l  (-$F0,A6),D0
            bfextu  D0{9:2},D0
            btst    #1,D0
            beq.b   .L5
            cmpi.l  #2,D0
            beq.b   .L2
            moveq   #2,D0
            rts
.L2:
            moveq   #1,D0
            rts
.L3:
            move.w  (-$E4,A6),D0
            andi.l  #$44,D0
            btst    #6,D0
            beq.b   .L5
            addq.l  #1,D0
            btst    #2,D0
            beq.b   .L4
            addq.l  #1,D0
.L4:
            andi.b  #3,D0
            rts
.L5:
            move.l  (-$80,A6),D0
            bfextu  D0{24:2},D0
            rts
g_opcls:
            btst    #1,(-$DC,A6)
            beq.b   .L1
            moveq   #0,D0
            rts
.L1:
            move.l  (-$E4,A6),D0
            bfextu  D0{0:3},D0
            rts
sub_40890674:
            btst    #1,(-$DC,A6)
            beq.b   .L1
            moveq   #0,D0
            rts
.L1:
            move.l  (-$E4,A6),D0
            bfextu  D0{3:3},D0
            cmpi.b  #1,D0
            bne.b   .L2
            moveq   #1,D0
            rts
.L2:
            cmpi.b  #5,D0
            bne.b   .L3
            moveq   #2,D0
            rts
.L3:
            moveq   #0,D0
            rts
.L4:
            dc.l    $00000000,$00000000,$00000000,$00000000
.L9:
            dc.l    $3F810000,$00000000,$00000000,$00000000
.L5:
            dc.l    $3C010000,$00000000,$00000000,$00000000
.L6:
            dc.l    $00000000,$00000000,$00000001,$00000000
.L10:
            dc.l    $3F810000,$00000100,$00000000,$00000000
.L7:
            dc.l    $3C010000,$00000000,$00000800,$00000000
.L8:
            dc.l    $00340042,$00500072,$00E600F2,$00FE011C
            dc.l    $0090009E,$00AC00CC,$0090009E,$00AC00CC
sub_40890720:
            lsl.l   #2,D0
            bfextu  (-$7D,A6){2:2},D1
            or.l    D1,D0
            lea     sub_40890674.L8,A1
            adda.w  (0,A1,D0.w*2),A1
            jmp     (A1)
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L1
            lea     sub_40890674.L6,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L1:
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L6
            tst.b   (2,A0)
            beq.b   .L2
            lea     sub_40890674.L4,A1
            ori.l   #$C000000,(-$7C,A6)
            bra.w   .L6
.L2:
            lea     sub_40890674.L6,A1
            bra.w   .L6
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L3
            lea     sub_40890674.L7,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L3:
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L4
            lea     sub_40890674.L5,A1
            ori.l   #$C000000,(-$7C,A6)
            bra.b   .L6
.L4:
            lea     sub_40890674.L7,A1
            bra.b   .L6
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L5
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L5
            tst.b   (2,A0)
            beq.b   .L8
            lea     sub_40890674.L10(PC),A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L8:
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L9
            lea     sub_40890674.L9(PC),A1
            ori.l   #$C000000,(-$7C,A6)
            bra.b   .L6
.L9:
            lea     sub_40890674.L10(PC),A1
            bra.b   .L6
.L5:
            tst.b   (2,A0)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            move.w  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  (8,A1),(8,A0)
            rts
.L7:
            dc.l    $003A0042,$004A0050,$0056005C,$00620068
            dc.l    $006E0076,$007E0084,$008A0090,$0096009C
            dc.l    $00A200AA,$00B200B8,$00BE00C4,$00CA00D0
sub_40890882:
            lea     sub_40890720.L7,A0
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
            move.b  (-$54,A6),(-$BD,A6)
            rts
            move.b  (-$54,A6),(-$B9,A6)
            rts
            move.b  (-$54,A6),D2
            rts
            move.b  (-$54,A6),D3
            rts
            move.b  (-$54,A6),D4
            rts
            move.b  (-$54,A6),D5
            rts
            move.b  (-$54,A6),D6
            rts
            move.b  (-$54,A6),D7
            rts
            move.w  (-$54,A6),(-$BE,A6)
            rts
            move.w  (-$54,A6),(-$BA,A6)
            rts
            move.w  (-$54,A6),D2
            rts
            move.w  (-$54,A6),D3
            rts
            move.w  (-$54,A6),D4
            rts
            move.w  (-$54,A6),D5
            rts
            move.w  (-$54,A6),D6
            rts
            move.w  (-$54,A6),D7
            rts
            move.l  (-$54,A6),(-$C0,A6)
            rts
            move.l  (-$54,A6),(-$BC,A6)
            rts
            move.l  (-$54,A6),D2
            rts
            move.l  (-$54,A6),D3
            rts
            move.l  (-$54,A6),D4
            rts
            move.l  (-$54,A6),D5
            rts
            move.l  (-$54,A6),D6
            rts
            move.l  (-$54,A6),D7
            rts
.L1:
            dc.l    $FFFF0000,$00000000,$00000000
.L2:
            dc.l    $7FFF0000,$00000000,$00000000
.L3:
            dc.l    $7FFF0000,$FFFFFFFF,$FFFFFFFF  ; added <4/9/91, JPO>			<T3>
.L4:
            bset    #3,(-$7C,A6)
            fmove.l #0,FPSR
            btst    #2,(-$7E,A6)
            bne.b   sub_4089099A.L1
            bra.b   .L6
.L5:
            fmove.l #0,FPSR
            btst    #2,(-$7E,A6)
            bne.b   sub_4089099A
            btst    #7,(-$CC,A6)
            beq.b   .L7
.L6:
            fmovem.x .L1(PC),FP0
            bset    #3,(-$7C,A6)
            bra.b   .L8
.L7:
            fmovem.x .L2(PC),FP0
.L8:
            ori.l   #$2000410,(-$7C,A6)
            rts
sub_4089099A:
            btst    #7,(-$CC,A6)
            beq.b   .L1
            bset    #3,(-$7C,A6)
.L1:
            ori.l   #$2000410,(-$7C,A6)
            st      (-$4C,A6)
            rts
sub_408909B6:
            ori.l   #$1002080,(-$7C,A6)
            btst    #5,(-$7E,A6)
            bne.b   .L1
            fmovem.x sub_40890882.L3(PC),FP0
            rts
.L1:
            st      (-$4C,A6)
            rts
sub_408909D4:
            clr.l   (-$74,A6)
            clr.l   (-$70,A6)
            clr.l   (-$6C,A6)
            tst.b   (A0)
            bpl.b   .L1
            bset    #7,(-$74,A6)
.L1:
            lea     (-$74,A6),A0
            ori.l   #$A28,(-$7C,A6)
            btst    #3,(-$7E,A6)
            beq.b   .L2
            bfclr   (-$E8,A6){5:3}
            bset    #4,(-$DF,A6)
            bset    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
.L2:
            bfextu  (-$7D,A6){0:2},D0
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_40890720
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
            bset    #7,(-$74,A6)
.L3:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            beq.b   .L5
            tst.l   (4,A0)
            bmi.b   .L5
            bne.b   .L4
            tst.l   (8,A0)
            bne.b   .L4
            bfclr   (A0){1:15}
            bra.b   .L5
.L4:
            bsr.w   sub_4088FCF8
.L5:
            fmovem.x (A0),FP0
            rts
t_ovfl2:
            ori.l   #$1048,(-$7C,A6)
            move.l  (-$CC,A6),(-$74,A6)
            move.l  (-$C8,A6),(-$70,A6)
            move.l  (-$C4,A6),(-$6C,A6)
            move.b  (-$7D,A6),D0
            andi.b  #$C0,D0
            beq.b   sub_40890AB4.L1
            cmpi.b  #$40,D0
            bne.b   .L1
            tst.b   (-$C4,A6)
            bne.b   .L2
            move.l  (-$C8,A6),D0
            andi.l  #$FF,D0
            bne.b   .L2
            bra.b   sub_40890AB4.L1
.L1:
            move.l  (-$C4,A6),D0
            andi.l  #$7FF,D0
            beq.b   sub_40890AB4.L1
.L2:
            ori.l   #$200,(-$7C,A6)
            bra.b   sub_40890AB4.L1
sub_40890AB4:
            ori.l   #$1248,(-$7C,A6)
.L1:
            btst    #4,(-$7E,A6)
            beq.b   .L2
            clr.l   (-$74,A6)
            clr.l   (-$70,A6)
            clr.l   (-$6C,A6)
            bfclr   (-$E8,A6){5:3}
            bclr    #4,(-$DF,A6)
            bset    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
.L2:
            bsr.w   ovf_r_k
            bfclr   (-$CA,A6){0:8}
            beq.b   .L3
            bset    #7,(-$CC,A6)
            bset    #7,(-$74,A6)
.L3:
            fmovem.x (-$CC,A6),FP0
            rts
.L4:
            ori.l   #$208,(-$7C,A6)
            rts
sub_40890B12:
            ori.l   #$208,(-$7C,A6)
            btst    #3,(-$7A,A6)
            beq.b   .L1
            bset    #5,(-$79,A6)
.L1:
            rts
            btst    #7,(-$D8,A6)
            beq.b   .L2
            bset    #3,(-$7C,A6)
.L2:
            btst    #6,(-$D4,A6)
            beq.b   .L4
            fmove.l D1,FPCR
            fmove.x (-$D8,A6),FP0
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            bne.b   .L3
            btst    #6,(-$C8,A6)
            bne.b   .L3
            ori.l   #$1004080,(-$7C,A6)
.L3:
            rts
.L4:
            btst    #6,(-$7E,A6)
            beq.b   .L5
            ori.b   #$60,(-$E0,A6)
            st      (-$4C,A6)
            ori.l   #$1004080,(-$7C,A6)
            rts
.L5:
            bset    #6,(-$D4,A6)
            fmove.l D1,FPCR
            fmove.x (-$D8,A6),FP0
            ori.l   #$1004080,(-$7C,A6)
            rts
            btst    #7,(-$CC,A6)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            btst    #6,(-$C8,A6)
            beq.b   .L7
            fmove.l D1,FPCR
            fmove.x (-$CC,A6),FP0
            rts
.L7:
            btst    #6,(-$7E,A6)
            beq.b   .L8
            ori.b   #$60,(-$E8,A6)
            st      (-$4C,A6)
            ori.l   #$1004080,(-$7C,A6)
            rts
.L8:
            bset    #6,(-$C8,A6)
            fmove.l D1,FPCR
            fmove.x (-$CC,A6),FP0
            ori.l   #$1004080,(-$7C,A6)
            rts
.L16:
            ori.l   #$A28,(-$7C,A6)
            bra.b   .L10
.L9:
            ori.l   #$800,(-$7C,A6)
.L10:
            btst    #3,(-$7E,A6)
            beq.b   .L13
            move.l  A0,-(SP)
            move.l  (A0),(-$74,A6)
            move.l  (4,A0),(-$70,A6)
            move.l  (8,A0),(-$6C,A6)
            lea     (-$74,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            tst.w   (A0)
            beq.b   .L11
            bsr.w   sub_4088FCF8
.L11:
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L12
            bset    #7,(A0)
.L12:
            bfclr   (-$E8,A6){5:3}
            bset    #4,(-$DF,A6)
            bclr    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
            movea.l (SP)+,A0
.L13:
            bfextu  (-$7D,A6){0:2},D0
            bne.b   .L14
            btst    #7,(A0)
            beq.b   .L15
            bset    #3,(-$7C,A6)
            bra.b   .L15
.L14:
            ori.l   #$A28,(-$7C,A6)
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_40890720
            bfclr   (2,A0){0:8}
            beq.b   .L15
            bset    #7,(A0)
.L15:
            bra.w   sub_408909D4.L3
sub_40890C9C:
            link.w  A2,#-$C0
            fsave   -(SP)
            tst.b   (1,SP)
            beq.b   .L5
            btst    #2,(-$DC,A2)
            beq.b   .L4
            btst    #7,(-$E0,A2)
            beq.b   .L2
            lea     (-$D8,A2),A0
            btst    #7,(A0)
            sne     (2,A0)
            bclr    #7,(-$E0,A2)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L1
            bset    #7,(A0)
.L1:
            btst    #7,(-$E8,A2)
            beq.b   .L4
.L2:
            lea     (-$CC,A2),A0
            btst    #7,(A0)
            sne     (2,A0)
            bclr    #7,(-$E8,A2)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
.L3:
            move.b  #$FE,(-$11C,A2)
            clr.w   (-$EC,A2)
            bclr    #2,(-$DC,A2)
.L4:
            frestore (SP)+
            unlk    A2
            rts
.L5:
            addq.l  #4,SP
            unlk    A2
            rts
            ds.b    8
.L6:
            dc.l    $3FFF0000,$80000000,$00000000  ; 10 ^ 0
.L7:
            dc.w    $8000,0
.L8:
            dc.l    $BFFF0000,$C90FDAA2,$2168C235  ; -PI/2
            dc.l    $00000000                      ; added <4/9/91, JPO>				<T3>
            dc.l    $7FFF0000,$FFFFFFFF,$FFFFFFFF,$00000000 ; added <4/9/91, JPO>			<T3>
.L9:
            dc.l    $092E092E,$092E092E,$092E092E,$092E092E
            dc.l    $080C03EE,$03FAFE40,$081803D2,$03D203D2
            dc.l    $102003EE,$03FAFE40,$101C03D2,$03D203D2
            dc.l    $085603EE,$03FAFE40,$03D803D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $043603EE,$042AFE40,$25C203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $1B5403EE,$0454FE40,$1B5003D2,$03D203D2
            dc.l    $10E203EE,$0406FE40,$10DE03D2,$03D203D2
            dc.l    $21BE03EE,$0412FE40,$21BA03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $213A03EE,$FC56FE40,$213603D2,$03D203D2
            dc.l    $0F0803EE,$FC56FE40,$0F0403D2,$03D203D2
            dc.l    $123403EE,$FC56FE40,$121C03D2,$03D203D2
            dc.l    $16C803EE,$FC56FE40,$16C403D2,$03D203D2
            dc.l    $19A60748,$041EFE40,$198203D2,$03D203D2
            dc.l    $1E0C0748,$041EFE40,$1DF003D2,$03D203D2
            dc.l    $1F700748,$041EFE40,$1F5403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $0460FBEC,$042AFE40,$048C03D2,$03D203D2
            dc.l    $0498FBEC,$042AFE40,$04C403D2,$03D203D2
            dc.l    $04D0FBEC,$042AFE40,$04FC03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $0F8C0748,$0724FE40,$0F7403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $20A40708,$FC56FE40,$209603D2,$03D203D2
            dc.l    $123A0748,$FC56FE40,$122003D2,$03D203D2
            dc.l    $078003EE,$FC56FE40,$079003D2,$03D203D2
            dc.l    $07A403EE,$FC56FE40,$07C403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $05280528,$05280528,$052803D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $05CA05CA,$05CA05CA,$05CA03D2,$03D203D2
            dc.l    $066C066C,$066C066C,$066C03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
do_func:
            clr.b   (-$46,A6)
            bfextu  (-$E4,A6){0:6},D0
            cmpi.l  #$17,D0
            bne.b   .L1
            bra.w   sub_408915C0.L11
.L1:
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            cmpi.l  #$38,D0
            bge.b   .L2
            bfextu  (-$E8,A6){0:3},D1
            lsl.l   #3,D0
            add.l   D1,D0
            lea     sub_40890C9C.L9,A1
            adda.w  (0,A1,D0.w*2),A1
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D1
            andi.l  #$FF,D1
            fmove.l #0,FPCR
            jmp     (A1)
.L2:
            st      (-$4C,A6)
            rts
sub_40891138:
            btst    #7,(A0)
            bne.b   .L1
            bsr.w   sub_408914C0
            bra.w   sub_40890AB4.L4
.L1:
            bsr.w   sub_408914D0
            bra.w   sub_40890AB4.L4
            btst    #7,(A0)
            bne.w   sub_408914D0
            bra.w   sub_408914C0
            btst    #7,(A0)
            bne.w   sub_40891496
            bra.w   .L4
            btst    #7,(A0)
            bne.w   sub_408914B0
            bra.w   sub_408914A8
            btst    #7,(A0)
            bne.w   .L3
            bra.w   .L2
            btst    #7,(A0)
            bne.w   sub_408914C0
            bra.w   .L4
            btst    #7,(A0)
            bne.w   sub_408909B6
            bra.w   .L4
            fmovem.x (A0),FP0
            fcmp.b  #$FF,FP0
            fbgt.w  sub_408931B0.L1
            fbeq.w  sub_40890882.L4
            fmove.l #0,FPSR
            bra.w   sub_408909B6
            dc.w    $0810,$0007,$6600,$02F6,$6000,$02C6,$0810,$0007
            dc.b    $66,$00,$F7,$F0,$0C,$50,$3F,$FF,$66,$00,$1F,$C4,$0C,$A8,$80
            ds.b    4
            dc.b    $04,$66,$00,$1F,$B8,$4A,$A8,$00,$08,$66,$00,$1F,$B0,$F2,$3C,$58
            dc.b    $00,$00,$00,$4E,$75
            btst    #7,(A0)
            beq.w   sub_4089313C
            bra.w   sub_408909B6
            btst    #7,(A0)
            bne.w   sub_408909B6
            cmpi.w  #$3FFF,(A0)
            bne.w   sub_408931B0.L6
            cmpi.l  #$80000000,(4,A0)
            bne.w   sub_408931B0.L6
            tst.l   (8,A0)
            bne.w   sub_408931B0.L6
            fmove.b #0,FP0
            rts
            btst    #7,(A0)
            beq.w   sub_408931B0.L5
            bra.w   sub_408909B6
            btst    #7,(A0)
            bne.w   sub_408909B6
            cmpi.w  #$3FFF,(A0)
            bne.w   sub_408931B0.L9
            cmpi.l  #$80000000,(4,A0)
            bne.w   sub_408931B0.L9
            tst.l   (8,A0)
            bne.w   sub_408931B0.L9
            fmove.b #0,FP0
            rts
            btst    #7,(A0)
            beq.w   sub_408931B0.L7
            bra.w   sub_408909B6
            dc.w    $0558,$004A,$0070,$0042,$004E,$004A,$004E,$0042
            dc.w    $004A,$004A,$004A,$0042,$0046,$0046,$0046,$0046
            dc.w    $E9EE,$0003,$FF18,$E9EE,$1003,$FF20,$0880,$0002
            dc.w    $0881,$0002,$E509,$8200,$43FA,$FFC6,$D2F1,$1200
            dc.w    $4ED1,$6000,$F8F4,$6000,$F87A,$6000,$F702,$122E
            dc.w    $FF34,$102E,$FF28,$B101,$0801,$0007,$6706,$08EE
            dc.w    $0007,$FF85,$0800,$0007,$6700,$01EE,$6000,$01FA
            dc.w    $122E,$FF34,$102E,$FF28,$B101,$0801,$0007,$6706
            dc.w    $08EE,$0007,$FF85,$4A2E,$FF20,$6A08,$41EE,$FF28
            dc.w    $6000,$F908,$F22E,$9000,$FF80,$F22E,$4800,$FF28
            dc.w    $4E75,$04BC,$004A,$0070,$0042,$004E,$004A,$004E
            dc.w    $0042,$004A,$004A,$004A,$0042,$0046,$0046,$0046
            dc.w    $0046,$E9EE,$0003,$FF18,$E9EE,$1003,$FF20,$0880
            dc.w    $0002,$0881,$0002,$E509,$8200,$43FA,$FFC6,$D2F1
            dc.w    $1200,$4ED1,$6000,$F852,$6000,$F7D8,$6000,$F660
            dc.w    $122E,$FF34,$102E,$FF28,$B101,$0801,$0007,$6706
            dc.w    $08EE,$0007,$FF85,$0800,$0007,$6700,$014C,$6000
            dc.w    $0158,$122E,$FF34,$102E,$FF28,$B101,$0801,$0007
            dc.w    $6706,$08EE,$0007,$FF85,$4A2E,$FF20,$6A08,$41EE
            dc.w    $FF28,$6000,$F866,$F22E,$9000,$FF80,$F22E,$4800
            dc.w    $FF28,$4E75,$0606,$0606,$0042,$0064,$004A,$004A
            dc.w    $0042,$0064,$0058,$0058,$0042,$0064,$0046,$0046
            dc.w    $0046,$0046,$E9EE,$0003,$FF18,$E9EE,$1003,$FF20
            dc.w    $0880,$0002,$0881,$0002,$E509,$8200,$43FA,$FFC6
            dc.w    $D2F1,$1200,$4ED1,$6000,$F5C6,$6000,$F736,$082E
            dc.w    $0007,$FF28,$6700,$00C2,$6000,$00CE,$082E,$0007
            dc.w    $FF28,$6778,$6000,$0088,$6000,$F78E,$082E,$0007
            dc.w    $FF34,$6708,$F23A,$4400,$F91C,$6006,$F23C,$5800
            dc.w    0,$F23A,$D040,$F902,$6000,$0FA2,$F23A,$4880
            dc.w    $F918,$6100,$0F98,$6000,$F576,$2D6E,$FF34,$FF8C
            dc.w    $2D6E,$FF38,$FF90,$2D6E,$FF3C,$FF94,$08EE,$0006
            dc.w    $FF90,$F22E,$D040,$FF8C,$6100,$0F72,$6000,$F73A
.L2:
            fmove.x sub_408934EA.L43,FP0
            bra.w   sub_40890AB4.L4
.L3:
            fmove.x sub_40890C9C.L8,FP0
            ori.l   #$8000000,(-$7C,A6)
            bra.w   sub_40890AB4.L4
.L4:
            fmove.s #"$7F800000",FP0
            ori.l   #$2000000,(-$7C,A6)
            rts
sub_40891496:
            fmove.s #"$FF800000",FP0
            ori.l   #$A000000,(-$7C,A6)
            rts
sub_408914A8:
            fmove.x sub_40890C9C.L6,FP0
            rts
sub_408914B0:
            fmove.b #$FF,FP0
            ori.l   #$8000000,(-$7C,A6)
            rts
sub_408914C0:
            fmove.b #0,FP0
            ori.l   #$4000000,(-$7C,A6)
            rts
sub_408914D0:
            fmove.s sub_40890C9C.L7,FP0
            ori.l   #$C000000,(-$7C,A6)
            rts
            move.w  (A0),D0
            bclr    #$F,D0
            subi.w  #$3FFF,D0
            fmove.w D0,FP0
            rts
            bclr    #7,(A0)
            bsr.w   sub_4088FCF8
            move.w  (A0),D0
            subi.w  #$3FFF,D0
            fmove.w D0,FP0
            rts
sub_40891504:
            move.l  (-$80,A6),D0
            andi.l  #$FFFFFF00,D0
            fmove.l D0,FPCR
            move.w  (A0),D0
            ori.w   #$7FFF,D0
            bclr    #$E,D0
            move.w  D0,(A0)
            fmove.x (A0),FP0
            rts
            move.l  (4,A0),D0
            move.l  (8,A0),D1
            bsr.b   sub_40891538
            move.l  D0,(4,A0)
            move.l  D1,(8,A0)
            bra.b   sub_40891504
sub_40891538:
            tst.l   D0
            bne.b   .L2
            tst.l   D1
            bne.b   .L1
            bra.b   .L3
.L1:
            move.l  D3,-(SP)
            exg     D0,D1
            bfffo   D0{0:0},D3
            lsl.l   D3,D0
            move.l  (SP)+,D3
            bra.b   .L3
.L2:
            movem.l D3/D5-D6,-(SP)
            bfffo   D0{0:0},D3
            lsl.l   D3,D0
            move.l  D1,D6
            lsl.l   D3,D1
            moveq   #$20,D5
            sub.l   D3,D5
            lsr.l   D5,D6
            or.l    D6,D0
            movem.l (SP)+,D3/D5-D6
.L3:
            rts
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
.L11:
            bfextu  (-$E4,A6){9:7},D0
            bfextu  (-$80,A6){26:2},D1
            tst.b   D0
            beq.b   .L13
            cmpi.b  #$A,D0
            ble.b   .L12
            cmpi.b  #$E,D0
            ble.b   .L16
            cmpi.b  #$2F,D0
            ble.b   .L12
            cmpi.b  #$3F,D0
            ble.b   .L19
.L12:
            fmove.b #0,FP0
            rts
.L13:
            tst.b   D1
            beq.b   .L14
            cmpi.b  #3,D1
            beq.b   .L15
            lea     sub_408934EA.L2,A0
            bra.w   .L22
.L14:
            lea     sub_408934EA.L1,A0
            bra.w   .L22
.L15:
            lea     sub_408934EA.L3,A0
            bra.b   .L22
.L16:
            subi.l  #$B,D0
            tst.b   D1
            beq.b   .L17
            cmpi.b  #3,D1
            beq.b   .L18
            lea     sub_408934EA.L5,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L17:
            lea     sub_408934EA.L4,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L18:
            lea     sub_408934EA.L6,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L19:
            subi.l  #$30,D0
            tst.b   D1
            beq.b   .L20
            cmpi.b  #3,D1
            beq.b   .L21
            lea     sub_408934EA.L9,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
            bra.b   .L22
.L20:
            lea     sub_408934EA.L7,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
            bra.b   .L22
.L21:
            lea     sub_408934EA.L11,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
.L22:
            ori.l   #$208,(-$7C,A6)
.L23:
            mulu.l  #$C,D0
            move.l  D1,(-$54,A6)
            bfextu  (-$80,A6){24:2},D1
            tst.l   D1
            bne.b   .L24
            fmovem.x (0,A0,D0.w),FP0
            rts
.L24:
            swap    D1
            add.l   (-$54,A6),D1
            move.l  (0,A0,D0.w),(-$74,A6)
            move.l  (4,A0,D0.w),(-$70,A6)
            move.l  (8,A0,D0.w),(-$6C,A6)
            moveq   #0,D0
            lea     (-$74,A6),A0
            btst    #7,(A0)
            sne     (2,A0)
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L25
            bset    #7,(A0)
.L25:
            fmovem.x (A0),FP0
            rts
            ds.b    8
            dc.w    $42AE,$FFBC,$6008,$2D7C,0,$0001,$FFBC
            movem.l D2-D7/A2,-(SP)
            suba.l  A2,A2
            bfextu  (A0){1:15},D3
            move.l  (8,A0),D5
            move.l  (4,A0),D4
            bmi.b   .L27
            bne.b   .L26
            move.l  D5,D4
            moveq   #0,D5
            subi.l  #$20,D3
            bfffo   D4{0:0},D6
            lsl.l   D6,D4
            sub.l   D6,D3
            bra.b   .L27
.L26:
            bfffo   D4{0:0},D6
            sub.l   D6,D3
            lsl.l   D6,D4
            bfextu  D5{0:D6},D7
            lsl.l   D6,D5
            or.l    D7,D4
.L27:
            bfextu  (-$C,A0){1:15},D0
            move.l  (-4,A0),D2
            move.l  (-8,A0),D1
            bmi.b   .L29
            bne.b   .L28
            move.l  D2,D1
            moveq   #0,D2
            subi.l  #$20,D0
            bfffo   D1{0:0},D6
            lsl.l   D6,D1
            sub.l   D6,D0
            bra.b   .L29
.L28:
            bfffo   D1{0:0},D6
            sub.l   D6,D0
            lsl.l   D6,D1
            bfextu  D2{0:D6},D7
            lsl.l   D6,D2
            or.l    D7,D1
.L29:
            move.l  D3,(-$3C,A6)
            sub.l   D3,D0
            bge.b   .L30
            add.l   D3,D0
            suba.l  A1,A1
            bra.b   .L35
.L30:
            movea.l D0,A1
            moveq   #0,D3
            andi.l  #$1F,D0
            beq.b   .L31
            bfextu  D1{0:D0},D3
            lsl.l   D0,D1
            bfextu  D2{0:D0},D6
            lsl.l   D0,D2
            or.l    D6,D1
.L31:
            bsr.w   sub_40891984
            move.l  A1,D6
            bfextu  D6{16:11},D6
            beq.b   .L33
            movea.l D6,A1
            moveq   #0,D2
.L32:
            bsr.w   sub_40891984
            subq.l  #1,A1
            move.l  A1,D6
            bne.b   .L32
.L33:
            move.l  D1,D2
            move.l  D3,D1
            move.l  (-$3C,A6),D3
            movea.l D0,A1
            move.l  D3,D0
            tst.l   D1
            bne.b   .L34
            tst.l   D2
            beq.w   .L42
            move.l  D2,D1
            moveq   #0,D2
            subi.l  #$20,D0
            bfffo   D1{0:0},D6
            lsl.l   D6,D1
            sub.l   D6,D0
            bra.b   .L35
.L34:
            bmi.b   .L35
            bfffo   D1{0:0},D6
            sub.l   D6,D0
            lsl.l   D6,D1
            bfextu  D2{0:D6},D7
            lsl.l   D6,D2
            or.l    D7,D1
.L35:
            cmpi.l  #$40,D0
            bge.b   .L36
            addi.l  #$7E,D0
            addi.l  #$7E,D3
            addq.l  #1,A2
.L36:
            move.w  D0,(-$64,A6)
            clr.w   (-$62,A6)
            move.l  D1,(-$60,A6)
            move.l  D2,(-$5C,A6)
            move.w  D3,(-$74,A6)
            clr.w   (-$72,A6)
            move.l  D4,(-$70,A6)
            move.l  D5,(-$6C,A6)
            fmove.x (-$64,A6),FP0
            tst.l   (-$44,A6)
            beq.b   .L39
            subq.l  #1,D3
            cmp.l   D3,D0
            blt.b   .L39
            bgt.b   .L38
            cmp.l   D4,D1
            bne.b   .L37
            cmp.l   D5,D2
            beq.b   .L43
.L37:
            bcs.b   .L39
.L38:
            fsub.x  (-$74,A6),FP0
            addq.l  #1,A1
.L39:
            move.w  (-$C,A0),D6
            bpl.b   .L40
            fneg.x  FP0,FP0
.L40:
            move.w  (A0),D7
            eor.w   D7,D6
            lsr.l   #8,D6
            andi.l  #$80,D6
            move.l  A1,D7
            andi.l  #$7F,D7
            or.l    D7,D6
            swap    D6
            fmove.l FPSR,D7
            andi.l  #$FF00FFFF,D7
            or.l    D6,D7
            fmove.l D7,FPSR
            move.l  A2,D0
            movem.l (SP)+,D2-D7/A2
            fmove.l (-$80,A6),FPCR
            tst.l   D0
            beq.b   .L41
            fmul.s  #"$00800000",FP0
            bra.w   sub_40890C9C
.L41:
            fmove.x FP0,FP0
            rts
.L42:
            fmove.b #0,FP0
            bra.b   .L39
.L43:
            move.l  A1,D6
            andi.b  #1,D6
            beq.b   .L39
            addq.l  #1,A1
            fneg.x  FP0,FP0
            bra.b   .L39
sub_40891984:
            divu.l  D4,D3:D1
            bvs.b   .L4
            move.l  D1,D0
            move.l  D1,D7
            mulu.l  D5,D6:D7
.L1:
            move.l  D2,D1
            sub.l   D7,D1
            subx.l  D6,D3
            bcc.b   .L3
.L2:
            subq.l  #1,D0
            add.l   D5,D1
            addx.l  D4,D3
            bcc.b   .L2
.L3:
            rts
.L4:
            move.l  D5,D6
            moveq   #0,D7
            move.l  D1,D3
            moveq   #0,D0
            bra.b   .L1
            dc.b    $3F,$FF,$40,$0C,$F2,$3C,$90
            ds.b    5
            dc.w    $7200,$322E,$FF28,$5BEE,$FFAC,$0281,0,$7FFF
            dc.w    $302E,$FF34,$0240,$7FFF,$02FA,0,$FFD8,$642A
            dc.w    $0C40,$400C,$6C00,$0252,$102E,$FF20,$0200,$00E0
            dc.w    $4A00,$6708,$41EE,$FF28,$6000,$F20E,$F22E,$9000
            dc.w    $FF80,$F22E,$4800,$FF28,$4E75
            fmove.x (-$CC,A6),FP0
            fmove.l #$10,FPCR
            fmove.l FP0,D0
            fmove.l #0,FPSR
            tst.w   (-$CC,A6)
            blt.w   .L11
            tst.w   D1
            beq.w   .L24
            add.l   D0,D1
            beq.b   .L8
            cmpi.l  #$7FFF,D1
            bge.b   .L6
            tst.b   (-$54,A6)
            beq.b   .L5
            ori.w   #$8000,D1
.L5:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L6:
            tst.b   (-$54,A6)
            beq.b   .L7
            ori.w   #$8000,D1
.L7:
            move.w  (-$D8,A6),(-$CC,A6)
            move.l  (-$D4,A6),(-$C8,A6)
            move.l  (-$D0,A6),(-$C4,A6)
            bra.w   t_ovfl2
.L8:
            tst.b   (-$54,A6)
            beq.b   .L9
            ori.w   #$8000,D1
.L9:
            tst.l   (-$D4,A6)
            blt.b   .L10
            move.w  D1,(-$D8,A6)
            ori.l   #$800,(-$7C,A6)
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.L10:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L11:
            add.l   D0,D1
            beq.b   .L8
            blt.b   .L13
            tst.b   (-$54,A6)
            beq.b   .L12
            ori.w   #$8000,D1
.L12:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L13:
            move.w  D1,D0
            movem.l D2-D3,-(SP)
            move.l  (-$D4,A6),D1
            move.l  (-$D0,A6),D2
            moveq   #0,D3
            cmpi.w  #$FFE0,D0
            bgt.b   .L14
            move.l  D2,D3
            move.l  D1,D2
            moveq   #0,D1
            addi.w  #$20,D0
            beq.b   .L16
            cmpi.w  #$FFE0,D0
            bge.b   .L14
            moveq   #0,D2
            moveq   #1,D3
            bra.b   .L16
.L14:
            lsr.l   #1,D1
            roxr.l  #1,D2
            roxr.l  #1,D3
            bcc.b   .L15
            ori.b   #1,D3
.L15:
            addq.w  #1,D0
            bne.b   .L14
.L16:
            clr.w   (-$D8,A6)
            tst.b   (-$54,A6)
            beq.b   .L17
            ori.w   #$8000,(-$D8,A6)
.L17:
            ori.l   #$800,(-$7C,A6)
            tst.l   D3
            beq.b   .L21
            ori.l   #$A28,(-$7C,A6)
            bfextu  (-$7D,A6){2:2},D0
            beq.b   .L19
            btst    #1,D0
            beq.b   .L21
            btst    #0,D0
            bne.b   .L18
            tst.b   (-$54,A6)
            bne.b   .L20
            bra.b   .L21
.L18:
            tst.b   (-$54,A6)
            beq.b   .L20
            bra.b   .L21
.L19:
            tst.l   D3
            bpl.b   .L21
            bftst   D3{1:31}
            bne.b   .L20
            btst    #0,D2
            beq.b   .L21
.L20:
            moveq   #0,D0
            addq.l  #1,D2
            addx.l  D0,D1
.L21:
            move.l  D1,(-$D4,A6)
            move.l  D2,(-$D0,A6)
            move.l  D2,D0
            movem.l (SP)+,D2-D3
            or.l    D1,D0
            bne.b   .L22
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L22:
            ori.l   #$800,(-$7C,A6)
            tst.b   (-$54,A6)
            beq.b   .L23
            ori.l   #$8000000,(-$7C,A6)
.L23:
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.L24:
            movem.l D2-D3,-(SP)
            move.w  (-$D8,A6),D1
            move.l  (-$D4,A6),D2
            move.l  (-$D0,A6),D3
.L25:
            tst.l   D2
            blt.b   .L26
            tst.l   D0
            beq.b   .L28
            subq.l  #1,D0
            lsl.l   #1,D3
            roxl.l  #1,D2
            bra.b   .L25
.L26:
            add.w   D0,D1
            tst.b   (-$54,A6)
            beq.b   .L27
            ori.l   #$8000,D1
.L27:
            movem.w D1,(-$D8,A6)
            movem.l D2,(-$D4,A6)
            movem.l D3,(-$D0,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            movem.l (SP)+,D2-D3
            rts
.L28:
            tst.b   (-$54,A6)
            beq.b   .L29
            ori.l   #$8000000,(-$7C,A6)
            ori.l   #$8000,D1
.L29:
            movem.w D1,(-$D8,A6)
            movem.l D2,(-$D4,A6)
            movem.l D3,(-$D0,A6)
            ori.l   #$800,(-$7C,A6)
            movem.l (SP)+,D2-D3
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
            tst.b   (-$54,A6)
            beq.b   .L30
            ori.l   #$8000,D1
.L30:
            move.l  (-$D4,A6),(-$C8,A6)
            move.l  (-$D0,A6),(-$C4,A6)
            tst.w   (-$CC,A6)
            blt.b   .L31
            move.w  D1,(-$CC,A6)
            bra.w   t_ovfl2
.L31:
            move.w  D1,(-$CC,A6)
            lea     (-$CC,A6),A0
            bra.w   sub_408909D4
            dc.w    $6000,$EF92,$2010,$3028,$0004,$0280,$7FFF,$FFFF
            dc.w    $0C80,$3FFF,$8000,$6C44,$F210,$4818,$F200,$0080
            dc.w    $F200,$049A,$F200,$0022,$F23C,$44A2,$3F80,0
            dc.b    $F2,$00,$04,$20,$20,$10,$02,$80,$80
            ds.b    4
            dc.b    $80,$3F,$00,$00,$00,$2F,$00,$F2,$10,$F0,$80,$2F,$01,$72,$00,$61
            dc.b    $00,$16,$74,$F2,$1F,$90,$00,$F2,$1F,$44,$23,$60,$00,$EE,$54,$F2
            dc.b    $10,$48,$18,$F2,$3C,$44,$38,$3F,$80,$00,$00,$F2,$92,$EC,$E8,$60
            dc.b    $00,$EC,$92,$F2,$3C,$44,$00,$3F,$80,$00,$00,$F2,$01,$90,$00,$F2
            dc.b    $3C,$44,$22,$00,$80,$00,$00,$60,$00,$EE,$28,$F2,$10,$48,$00,$20
            dc.b    $10,$30,$28,$00,$04,$02,$80,$7F,$FF,$FF,$FF,$0C,$80,$40,$0C,$B1
            dc.b    $67,$6E,$32,$F2,$00,$00,$18,$2F,$01,$72,$00,$F2,$10,$F0,$80,$61
            dc.b    $00,$09,$F4,$F2,$3C,$44,$23,$3F,$00,$00,$00,$22,$1F,$F2,$3C,$44
            dc.b    $80,$3E,$80,$00,$00,$F2,$00,$00,$A0,$F2,$01,$90,$00,$F2,$00,$04
            dc.b    $22,$60,$00,$ED,$DE,$0C,$80,$40,$0C,$B2,$B3,$6E,$2A,$F2,$00,$00
            dc.b    $18,$F2,$3A,$54,$28,$1A,$DA,$F2,$3A,$54,$28,$1A,$DC,$2F,$01,$72
            dc.b    $00,$F2,$10,$F0,$80,$61,$00,$09,$AE,$F2,$1F,$90,$00,$F2,$3A,$48
            dc.b    $23,$1A,$CE,$60,$00,$ED,$AC,$F2,$3C,$88
            ds.b    5
            dc.w    $0890,$0007,$F210,$D080,$6000,$ED3A,$6000,$EE7A
            dc.w    $F210,$4800,$2010,$3028,$0004,$2240,$0280,$7FFF
            dc.w    $FFFF,$0C80,$400C,$B167,$6E52,$F200,$0018
            movem.l D1/A1,-(SP)
            fmovem.x FP0,(A0)
            moveq   #0,D1
            bsr.w   sub_408928B4
            fmove.l #0,FPCR
            movem.l (SP)+,D1/A1
            fmove.x FP0,FP1
            fadd.s  #"$3F800000",FP1
            fmove.x FP0,-(SP)
            fdiv.x  FP1,FP0
            move.l  A1,D0
            andi.l  #$80000000,D0
            ori.l   #$3F000000,D0
            fadd.x  (SP)+,FP0
            move.l  D0,-(SP)
            fmove.l D1,FPCR
            fmul.s  (SP)+,FP0
            bra.w   sub_40890B12
            cmpi.l  #$400CB2B3,D0
            bgt.w   sub_40890AB4
            fabs.x  FP0,FP0
            fsub.d  sub_408934EA.L13,FP0
            clr.l   -(SP)
            move.l  #$80000000,-(SP)
            move.l  A1,D0
            andi.l  #$80000000,D0
            ori.l   #$7FFB0000,D0
            move.l  D0,-(SP)
            fsub.d  sub_408934EA.L14,FP0
            move.l  D1,-(SP)
            moveq   #0,D1
            fmovem.x FP0,(A0)
            bsr.w   setox
            fmove.l (SP)+,FPCR
            fmul.x  (SP)+,FP0
            bra.w   sub_40890B12
            dc.w    $3FD7,$8000,$3FFF,$DDCE,$6000,$EDB8,$F210,$4800
            dc.w    $F22E,$6800,$FFE0,$2010,$3028,$0004,$2D40,$FFE0
            dc.w    $0280,$7FFF,$FFFF,$04FA,0,$FFD6,$655C,$202E
            dc.w    $FFE0,$2D40,$FFBC,$0280,$7FFF,0,$0680,$0001
            dc.w    0,$2D40,$FFE0,$02AE,$8000,0,$FFBC,$F22E
            dc.w    $4800,$FFE0,$2F01,$7200,$F210,$F080,$6100,$0A20
            dc.w    $221F,$F200,$0080,$F23C,$44A2,$4000,0,$202E
            dc.w    $FFBC,$F22E,$6880,$FFF0,$B1AE,$FFF0,$F201,$9000
            dc.w    $F22E,$4820,$FFF0,$6000,$EC54,$0C80,$3FFF,$8000
            dc.w    $6D76,$0C80,$4004,$8AA1,$6E00,$0080,$202E,$FFE0
            dc.w    $2D40,$FFBC,$0280,$7FFF,0,$0680,$0001,0
            dc.w    $2D40,$FFE0,$02AE,$8000,0,$FFBC,$202E,$FFBC
            dc.w    $F22E,$4800,$FFE0,$2F01,$7200,$F210,$F080,$6100
            dc.w    $0800,$221F,$202E,$FFBC,$F23C,$4422,$3F80,0
            dc.w    $0A80,$C000,0,$F200,$4480,$F200,$00A0,$202E
            dc.w    $FFBC,$0080,$3F80,0,$F200,$4400,$F201,$9000
            dc.w    $F200,$0422,$6000,$EBD6,$426E,$FFE2,$F201,$9000
            dc.w    $F22E,$4800,$FFE0,$6000,$EBC4,$202E,$FFE0,$0280
            dc.b    $80
            ds.b    4
            dc.b    $80,$3F,$80,$00,$00,$F2,$00,$44,$00,$02,$80,$80,$00,$00,$00,$0A
            dc.b    $80,$80,$80,$00,$00,$F2,$01,$90,$00,$F2,$00,$44,$22,$60,$00,$EB
            dc.b    $98,$60,$00,$EC,$7A,$F2,$3C,$44,$00,$3F,$80,$00,$00,$F2,$3C,$88
            ds.b    5
            dc.w    $6000,$EB80,$42AE,$FFBC,$6008,$2D7C,0,$0001
            dc.w    $FFBC,$F210,$4800,$2010,$3028,$0004,$F22E,$6800
            dc.w    $FFE0,$0280,$7FFF,$FFFF,$0C80,$3FD7,$8000,$6C04
            dc.w    $6000,$014E,$0C80,$4004,$BC7E,$6D06,$6100,$05A0
            dc.w    $6024,$F200,$0080,$F23A,$54A3,$18DE,$43FA,$1B62
            dc.w    $F22E,$6080,$FFB0,$202E,$FFB0,$E980,$D3C0,$F219
            dc.w    $4828,$F211,$4428,$202E,$FFB0,$D0AE,$FFBC,$E298
            dc.w    $6B7C,$F22E,$6800,$FFE0,$F200,$0023,$F23A,$5580
            dc.w    $1830,$F23A,$5500,$1832,$F200,$0080,$F200,$04A3
            dc.w    $E298,$0280,$8000,0,$B1AE,$FFE0,$F200,$05A3
            dc.w    $F200,$0523,$F23A,$55A2,$1818,$F23A,$5522,$181A
            dc.w    $F200,$05A3,$F200,$0523,$F23A,$55A2,$1814,$F23A
            dc.w    $4922,$181E,$F200,$0CA3,$F200,$0123,$F23A,$48A2
            dc.w    $1820,$F22E,$4823,$FFE0,$F200,$08A2,$F200,$0423
            dc.w    $F201,$9000,$F22E,$4822,$FFE0,$6000,$EA96,$F200
            dc.w    $0023,$F23A,$5500,$180A,$F23A,$5580,$180C,$F200
            dc.w    $0080,$F200,$04A3,$F22E,$6800,$FFE0,$E298,$0280
            dc.w    $8000,0,$F200,$0523,$B1AE,$FFE0,$0280,$8000
            dc.w    0,$F200,$05A3,$0080,$3F80,0,$2D40,$FFAC
            dc.w    $F23A,$5522,$17DC,$F23A,$55A2,$17DE,$F200,$0523
            dc.w    $F200,$05A3,$F23A,$5522,$17D8,$F23A,$49A2,$17E2
            dc.w    $F200,$0523,$F200,$0CA3,$F23A,$4922,$17E4,$F23A
            dc.w    $44A2,$17EA,$F200,$0823,$F200,$0422,$F22E,$4823
            dc.w    $FFE0,$F201,$9000,$F22E,$4422,$FFAC,$6000,$EA04
            dc.w    $202E,$FFBC,$6E12,$426E,$FFE2,$F201,$9000,$F22E
            dc.w    $4800,$FFE0,$6000,$E9EC,$F23C,$4400,$3F80,0
            dc.w    $F201,$9000,$F23C,$4428,$0080,0,$6000,$E9D4
            dc.w    $F23C,$4480,$3F80,0,$6100,$028A,$6000,$EAAA
            dc.w    $2D7C,0,$0004,$FFBC,$F210,$4800,$2010,$3028
            dc.w    $0004,$F22E,$6800,$FFE0,$0280,$7FFF,$FFFF,$0C80
            dc.w    $3FD7,$8000,$6C04,$6000,$022C,$0C80,$4004,$BC7E
            dc.w    $6D06,$6100,$03EA,$6024,$F200,$0080,$F23A,$54A3
            dc.w    $1728,$43FA,$19AC,$F22E,$6080,$FFB0,$202E,$FFB0
            dc.w    $E980,$D3C0,$F219,$4828,$F211,$4428,$202E,$FFB0
            dc.w    $E298,$6A00,$0106,$F22E,$6800,$FF8C,$F200,$0023
            dc.w    $F23A,$5480,$167C,$F23A,$5500,$16C6,$F200,$00A3
            dc.w    $2F02,$2400,$F200,$0123,$E29A,$0282,$8000,0
            dc.w    $F23A,$54A2,$1664,$B182,$0282,$8000,0,$F23A
            dc.w    $5522,$16A6,$F200,$00A3,$B5AE,$FF8C,$241F,$F200
            dc.w    $0123,$E298,$0280,$8000,0,$F23A,$54A2,$1642
            dc.w    $2D7C,$3F80,0,$FFAC,$B1AE,$FFAC,$F23A,$5522
            dc.w    $1680,$F200,$00A3,$F200,$0123,$F22E,$6800,$FF9C
            dc.w    $F23A,$54A2,$1624,$B1AE,$FF9C,$F23A,$5522,$166A
            dc.w    $F200,$00A3,$F200,$0123,$F23A,$54A2,$1614,$F23A
            dc.w    $5522,$165E,$F200,$00A3,$F200,$0123,$F23A,$48A2
            dc.w    $1610,$F23A,$4922,$165A,$F200,$00A3,$F200,$0123
            dc.w    $F23A,$48A2,$160C,$F23A,$4922,$1656,$F200,$00A3
            dc.w    $F200,$0823,$F22E,$48A3,$FF8C,$F23A,$4422,$164E
            dc.w    $F22E,$4823,$FF9C,$2F01,$0281,0,$00FF,$F201
            dc.w    $9000,$F22E,$48A2,$FF8C,$6100,$012A,$F21F,$9000
            dc.w    $F22E,$4422,$FFAC,$6000,$E85A,$F22E,$6800,$FF8C
            dc.w    $F200,$0023,$F23A,$5480,$15C8,$F23A,$5500,$1572
            dc.w    $F200,$00A3,$F22E,$6800,$FF9C,$F200,$0123,$E298
            dc.w    $0280,$8000,0,$F23A,$54A2,$15AE,$F23A,$5522
            dc.w    $1558,$B1AE,$FF8C,$B1AE,$FF9C,$F200,$00A3,$0080
            dc.w    $3F80,0,$2D40,$FFAC,$F200,$0123,$F23A,$54A2
            dc.w    $1590,$F23A,$5522,$153A,$F200,$00A3,$F200,$0123
            dc.w    $F23A,$54A2,$1584,$F23A,$5522,$152E,$F200,$00A3
            dc.w    $F200,$0123,$F23A,$54A2,$1578,$F23A,$5522,$1522
            dc.w    $F200,$00A3,$F200,$0123,$F23A,$48A2,$1574,$F23A
            dc.w    $4922,$151E,$F200,$00A3,$F200,$0123,$F23A,$48A2
            dc.w    $1570,$F23A,$4922,$151A,$F200,$00A3,$F200,$0823
            dc.w    $F23A,$44A2,$1568,$F22E,$4823,$FF8C,$F22E,$48A3
            dc.w    $FF9C,$2F01,$0281,0,$00FF,$F201,$9000,$F22E
            dc.w    $44A2,$FFAC,$613E,$F21F,$9000,$F22E,$4822,$FF8C
            dc.w    $6000,$E770,$426E,$FFE2,$F23C,$4480,$3F80,0
            dc.w    $2F01,$0281,0,$00FF,$F201,$9000,$F23C,$44A8
            dc.w    $0080,0,$610E,$F21F,$9000,$F22E,$4800,$FFE0
            dc.w    $6000,$E740,$E9EE,$0343,$FF1C,$0C00,$0003,$6F12
            dc.w    $F227,$E002,$7207,$9280,$7000,$03C0,$F21F,$D800
            dc.w    $4E75
            cmpi.b  #0,D0
            beq.b   .L34
            cmpi.b  #1,D0
            beq.b   .L33
            cmpi.b  #2,D0
            beq.b   .L32
            fmovem.x FP1,(-$8C,A6)
            rts
.L32:
            fmovem.x FP1,(-$98,A6)
            rts
.L33:
            fmovem.x FP1,(-$A4,A6)
            rts
.L34:
            fmovem.x FP1,(-$B0,A6)
            rts
            dc.w    $6000,$E7D2,$F210,$4800,$2010,$3028,$0004,$0280
            dc.w    $7FFF,$FFFF,$0C80,$3FD7,$8000,$6C04,$6000,$011C
            dc.w    $0C80,$4004,$BC7E,$6D0C,$6100,$0120,$202E,$FFB0
            dc.w    $E298,$6026,$F200,$0080,$F23A,$54A3,$1458,$43FA
            dc.w    $16DC,$F200,$6080,$E980,$D3C0,$F219,$4828,$F211
            dc.w    $4428,$EA98,$0280,$8000,0,$6B6A,$F200,$0080
            dc.w    $F200,$04A3,$F23A,$5580,$1454,$F23A,$5500,$1456
            dc.w    $F200,$05A3,$F200,$0523,$F23A,$55A2,$1450,$F23A
            dc.w    $4922,$145A,$F200,$05A3,$F200,$0523,$F23A,$49A2
            dc.w    $145C,$F23A,$4922,$1466,$F200,$05A3,$F200,$0523
            dc.w    $F23A,$49A2,$1468,$F200,$0123,$F200,$0CA3,$F200
            dc.w    $0822,$F23C,$44A2,$3F80,0,$F201,$9000,$F200
            dc.w    $0420,$6000,$E62A,$F200,$0080,$F200,$0023,$F23A
            dc.w    $5580,$13EA,$F23A,$5500,$13EC,$F200,$01A3,$F200
            dc.w    $0123,$F23A,$55A2,$13E6,$F23A,$4922,$13F0,$F200
            dc.w    $01A3,$F200,$0123,$F23A,$49A2,$13F2,$F23A,$4922
            dc.w    $13FC,$F200,$01A3,$F200,$0123,$F23A,$49A2,$13FE
            dc.w    $F200,$0523,$F200,$0C23,$F200,$08A2,$F23C,$4422
            dc.w    $3F80,0,$F227,$6880,$0A97,$8000,0,$F201
            dc.w    $9000,$F21F,$4820,$6000,$E5B6,$F227,$6800,$F201
            dc.w    $9000,$F21F,$4800,$6000,$E5A6,$F227,$E03C,$2F02
            dc.w    $F23C,$4480
            ds.b    4
            dc.w    $0C80,$7FFE,$FFFF,$6656,$2D7C,$7FFE,0,$FF9C
            dc.w    $2D7C,$C90F,$DAA2,$FFA0,$42AE,$FFA4,$F200,$003A
            dc.w    $2D7C,$7FDC,0,$FFC0,$2D7C,$85A3,$08D3,$FFC4
            dc.w    $42AE,$FFC8,$F294,$000E,$006E,$8000,$FF9C,$006E
            dc.w    $8000,$FFC0,$F22E,$4822,$FF9C,$F200,$0080,$F22E
            dc.w    $4822,$FFC0,$F200,$00A8,$F22E,$48A2,$FFC0,$F22E
            dc.w    $6800,$FFD0,$302E,$FFD0,$2240,$0280,0,$7FFF
            dc.w    $0480,0,$3FFF,$0C80,0,$001C,$6F0C,$0480
            dc.w    0,$001B,$42AE,$FFB0,$600A,$7000,$2D7C,0
            dc.w    $0001,$FFB0,$243C,0,$3FFE,$9480,$2D7C,$A2F9
            dc.w    $836E,$FF90,$2D7C,$4E44,$152A,$FF94,$3D42,$FF8C
            dc.w    $F200,$0100,$F22E,$4923,$FF8C,$2409,$4842,$0282
            dc.b    $80
            ds.b    4
            dc.b    $82,$5F,$00,$00,$00,$2D,$42,$FF,$AC,$24,$00,$06,$82,$00,$00,$3F
            dc.b    $FF,$F2,$2E,$45,$22,$FF,$AC,$3D,$42,$FF,$9C,$42,$6E,$FF,$9E,$2D
            dc.b    $7C,$C9,$0F,$DA,$A2,$FF,$A0,$42,$AE,$FF,$A4,$F2,$2E,$45,$28,$FF
            dc.b    $AC,$06,$80,$00,$00,$3F,$DD,$3D,$40,$FF,$C0,$42,$6E,$FF,$C2,$2D
            dc.b    $7C,$85,$A3,$08,$D3,$FF,$C4,$42,$AE,$FF,$C8,$20,$2E,$FF,$B0,$F2
            dc.b    $00,$0A,$00,$F2,$2E,$4A,$23,$FF,$9C,$F2,$00,$0A,$80,$F2,$2E,$4A
            dc.b    $A3,$FF,$C0,$F2,$00,$11,$80,$F2,$00,$15,$A2,$F2,$00,$0E,$28,$F2
            dc.b    $00,$0C,$28,$F2,$00,$16,$22,$F2,$00,$01,$80,$F2,$00,$10,$A8,$F2
            dc.b    $00,$04,$22,$4A,$80,$6E,$0C,$F2,$00,$01,$A8,$F2,$00,$0C,$A2,$60
            dc.b    $00,$FF,$08,$F2,$2E,$61,$00,$FF,$B0,$24,$1F,$F2,$1F,$D0,$3C,$4E
            dc.b    $75
            move.l  (A0),D0
            andi.l  #$80000000,D0
            ori.l   #$800000,D0
            move.l  D0,-(SP)
            fmove.s #"$3F800000",FP0
            fmove.l D1,FPCR
            fadd.s  (SP)+,FP0
            bra.w   sub_40890B12
setox:
            move.l  (A0),D0
            andi.l  #$7FFF0000,D0
            cmpi.l  #$3FBE0000,D0
            bge.b   .L1
            bra.w   .L5
.L1:
            move.w  (4,A0),D0
            cmpi.l  #$400CB167,D0
            blt.b   .L2
            bra.w   .L6
.L2:
            fmove.x (A0),FP0
            fmove.x FP0,FP1
            fmul.s  #"$42B8AA3B",FP0
            fmovem.x FP2-FP3,-(SP)
            clr.l   (-$50,A6)
            fmove.l FP0,D0
            lea     sub_408934EA.L30,A1
            fmove.l D0,FP0
            move.l  D0,(-$54,A6)
            andi.l  #$3F,D0
            lsl.l   #4,D0
            adda.l  D0,A1
            move.l  (-$54,A6),D0
            asr.l   #6,D0
            addi.w  #$3FFF,D0
            move.w  sub_408934EA.L15,(-$54,A6)
.L3:
            fmove.x FP0,FP2
            fmul.s  #"$BC317218",FP0
            fmul.x  sub_408934EA.L15,FP2
            fadd.x  FP1,FP0
            fadd.x  FP2,FP0
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.s #"$3AB60B70",FP2
            fmul.x  FP1,FP2
            fmove.x FP1,FP3
            fmul.s  #"$3C088895",FP3
            fadd.d  sub_408934EA.L16,FP2
            fadd.d  sub_408934EA.L17,FP3
            fmul.x  FP1,FP2
            move.w  D0,(-$74,A6)
            clr.w   (-$72,A6)
            move.l  #$80000000,(-$70,A6)
            clr.l   (-$6C,A6)
            fmul.x  FP1,FP3
            fadd.s  #"$3F000000",FP2
            fmul.x  FP0,FP3
            fmul.x  FP1,FP2
            fadd.x  FP3,FP0
            fmove.x (A1)+,FP1
            fadd.x  FP2,FP0
            fmul.x  FP1,FP0
            fmovem.x (SP)+,FP2-FP3
            fadd.s  (A1),FP0
            fadd.x  FP1,FP0
            move.l  (-$50,A6),D0
            tst.l   D0
            beq.b   .L4
            fmul.x  (-$64,A6),FP0
.L4:
            fmove.l D1,FPCR
            fmul.x  (-$74,A6),FP0
            bra.w   sub_40890B12
.L5:
            fmovem.x (A0),FP0
            fmove.l D1,FPCR
            fadd.s  #"$3F800000",FP0
            bra.w   sub_40890B12
.L6:
            cmpi.l  #$400CB27C,D0
            bgt.b   .L7
            fmove.x (A0),FP0
            fmove.x FP0,FP1
            fmul.s  #"$42B8AA3B",FP0
            fmovem.x FP2-FP3,-(SP)
            move.l  #1,(-$50,A6)
            fmove.l FP0,D0
            lea     sub_408934EA.L30,A1
            fmove.l D0,FP0
            move.l  D0,(-$54,A6)
            andi.l  #$3F,D0
            lsl.l   #4,D0
            adda.l  D0,A1
            move.l  (-$54,A6),D0
            asr.l   #6,D0
            move.l  D0,(-$54,A6)
            asr.l   #1,D0
            sub.l   D0,(-$54,A6)
            addi.w  #$3FFF,D0
            move.w  D0,(-$64,A6)
            clr.w   (-$62,A6)
            move.l  #$80000000,(-$60,A6)
            clr.l   (-$5C,A6)
            move.l  (-$54,A6),D0
            addi.w  #$3FFF,D0
            bra.w   .L3
.L7:
            fmove.l D1,FPCR
            move.l  (A0),D0
            bclr    #7,(A0)
            tst.l   D0
            bmi.w   sub_408909D4
            bra.w   sub_40890AB4
            bra.w   sub_40890B12.L16
sub_408928B4:
            move.l  (A0),D0
            andi.l  #$7FFF0000,D0
            cmpi.l  #$3FFD0000,D0
            bge.b   .L1
            bra.w   .L6
.L1:
            move.w  (4,A0),D0
            cmpi.l  #$4004C215,D0
            ble.b   .L2
            bra.w   .L9
.L2:
            fmove.x (A0),FP0
            fmove.x FP0,FP1
            fmul.s  #"$42B8AA3B",FP0
            fmovem.x FP2-FP3,-(SP)
            fmove.l FP0,D0
            lea     sub_408934EA.L30,A1
            fmove.l D0,FP0
            move.l  D0,(-$54,A6)
            andi.l  #$3F,D0
            lsl.l   #4,D0
            adda.l  D0,A1
            move.l  (-$54,A6),D0
            asr.l   #6,D0
            move.l  D0,(-$54,A6)
            fmove.x FP0,FP2
            fmul.s  #"$BC317218",FP0
            fmul.x  sub_408934EA.L15,FP2
            fadd.x  FP1,FP0
            fadd.x  FP2,FP0
            addi.w  #$3FFF,D0
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.s #"$3950097B",FP2
            fmul.x  FP1,FP2
            fmove.x FP1,FP3
            fmul.s  #"$3AB60B6A",FP3
            fadd.d  sub_408934EA.L18,FP2
            fadd.d  sub_408934EA.L19,FP3
            move.w  D0,(-$40,A6)
            clr.w   (-$3E,A6)
            move.l  #$80000000,(-$3C,A6)
            clr.l   (-$38,A6)
            fmul.x  FP1,FP2
            move.l  (-$54,A6),D0
            neg.w   D0
            fmul.x  FP1,FP3
            addi.w  #$3FFF,D0
            fadd.d  sub_408934EA.L20,FP2
            fadd.s  #"$3F000000",FP3
            fmul.x  FP1,FP2
            ori.w   #$8000,D0
            move.w  D0,(-$30,A6)
            clr.w   (-$2E,A6)
            move.l  #$80000000,(-$2C,A6)
            clr.l   (-$28,A6)
            fmul.x  FP3,FP1
            fmul.x  FP0,FP2
            fadd.x  FP1,FP0
            fadd.x  FP2,FP0
            fmovem.x (SP)+,FP2-FP3
            fmul.x  (A1),FP0
            move.l  (-$54,A6),D0
            cmpi.l  #$3F,D0
            ble.b   .L3
            fmove.s ($C,A1),FP1
            fadd.x  (-$30,A6),FP1
            fadd.x  FP1,FP0
            fadd.x  (A1),FP0
            bra.b   .L5
.L3:
            cmpi.l  #$FFFFFFFD,D0
            bge.b   .L4
            fadd.s  ($C,A1),FP0
            fadd.x  (A1),FP0
            fadd.x  (-$30,A6),FP0
            bra.b   .L5
.L4:
            fmove.x (A1)+,FP1
            fadd.s  (A1),FP0
            fadd.x  (-$30,A6),FP1
            fadd.x  FP1,FP0
.L5:
            fmove.l D1,FPCR
            fmul.x  (-$40,A6),FP0
            bra.w   sub_40890B12
.L6:
            cmpi.l  #$3FBE0000,D0
            bge.b   .L8
            cmpi.l  #$330000,D0
            blt.b   .L7
            move.l  #$80010000,(-$40,A6)
            move.l  #$80000000,(-$3C,A6)
            clr.l   (-$38,A6)
            fmove.x (A0),FP0
            fmove.l D1,FPCR
            fadd.x  (-$40,A6),FP0
            bra.w   sub_40890B12
.L7:
            fmove.x (A0),FP0
            fmul.d  sub_408934EA.L28,FP0
            move.l  #$80010000,(-$40,A6)
            move.l  #$80000000,(-$3C,A6)
            clr.l   (-$38,A6)
            fadd.x  (-$40,A6),FP0
            fmove.l D1,FPCR
            fmul.d  sub_408934EA.L29,FP0
            bra.w   sub_40890B12
.L8:
            fmove.x (A0),FP0
            fmul.x  FP0,FP0
            fmovem.x FP2-FP3,-(SP)
            fmove.s #"$2F30CAA8",FP1
            fmul.x  FP0,FP1
            fmove.s #"$310F8290",FP2
            fadd.s  #"$32D73220",FP1
            fmul.x  FP0,FP2
            fmul.x  FP0,FP1
            fadd.s  #"$3493F281",FP2
            fadd.d  sub_408934EA.L21,FP1
            fmul.x  FP0,FP2
            fmul.x  FP0,FP1
            fadd.d  sub_408934EA.L22,FP2
            fadd.d  sub_408934EA.L23,FP1
            fmul.x  FP0,FP2
            fmul.x  FP0,FP1
            fadd.d  sub_408934EA.L24,FP2
            fadd.d  sub_408934EA.L25,FP1
            fmul.x  FP0,FP2
            fmul.x  FP0,FP1
            fadd.d  sub_408934EA.L26,FP2
            fadd.x  sub_408934EA.L27,FP1
            fmul.x  FP0,FP2
            fmul.x  FP0,FP1
            fmul.x  FP0,FP2
            fmul.x  (A0),FP1
            fmul.s  #"$3F000000",FP0
            fadd.x  FP2,FP1
            fmovem.x (SP)+,FP2-FP3
            fadd.x  FP1,FP0
            fmove.l D1,FPCR
            fadd.x  (A0),FP0
            bra.w   sub_40890B12
.L9:
            move.l  (A0),D0
            tst.l   D0
            bgt.w   setox.L1
            fmove.s #"$BF800000",FP0
            fmove.l D1,FPCR
            fadd.s  #"$00800000",FP0
            bra.w   sub_40890B12
            fmove.l D1,FPCR
            fmove.s #"$3F800000",FP0
            move.l  (A0),D0
            ori.l   #$800001,D0
            fadd.s  D0,FP0
            bra.w   sub_40890B12
            fmovem.x (A0),FP0
            move.l  (A0),D0
            move.w  (4,A0),D0
            fmove.x FP0,(-$74,A6)
            andi.l  #$7FFFFFFF,D0
            cmpi.l  #$3FB98000,D0
            bge.b   .L10
            bra.w   sub_40892C84
.L10:
            cmpi.l  #$400D80C0,D0
            ble.b   .L11
            bra.w   sub_40892C84
.L11:
            fmove.x FP0,FP1
            fmul.s  #"$42800000",FP1
            fmove.l FP1,(-$54,A6)
            fmove.l FPSR,D0
            andi.w  #$200,D0
            bne.b   TWOMAIN1
            move.l  (-$54,A6),D0
            bftst   D0{26:6}
            bne.b   TWOMAIN1
            asr.l   #6,D0
            addi.l  #$3FFF,D0
            bmi.b   .L12
            cmpi.l  #$7FFF,D0
            bge.b   TWOMAIN1
            move.w  D0,(-$74,A6)
            move.w  #$3FFF,(-$64,A6)
            bra.b   .L13
.L12:
            addi.l  #$3FFF,D0
            clr.l   (-$74,A6)
            move.w  D0,(-$64,A6)
.L13:
            move.l  #$80000000,(-$70,A6)
            clr.l   (-$6C,A6)
            fmove.x (-$74,A6),FP0
            move.l  #$80000000,(-$60,A6)
            clr.l   (-$5C,A6)
            fmove.l D1,FPCR
            fmul.x  (-$64,A6),FP0
            rts
TWOMAIN1:
            move.l  D2,-(SP)
            lea     sub_408934EA.L41,A1
            fmove.l (-$54,A6),FP1
            move.l  (-$54,A6),D0
            move.l  D0,D2
            andi.l  #$3F,D0
            asl.l   #4,D0
            adda.l  D0,A1
            asr.l   #6,D2
            move.l  D2,D0
            asr.l   #1,D0
            sub.l   D0,D2
            addi.l  #$3FFF,D2
            move.w  D2,(-$64,A6)
            move.l  (SP)+,D2
            fmul.s  #"$3C800000",FP1
            move.l  (A1)+,(-$40,A6)
            move.l  (A1)+,(-$3C,A6)
            move.l  (A1)+,(-$38,A6)
            move.w  (A1)+,(-$30,A6)
            clr.w   (-$2E,A6)
            fsub.x  FP1,FP0
            move.w  (A1)+,(-$2C,A6)
            clr.w   (-$2A,A6)
            clr.l   (-$28,A6)
            add.w   D0,(-$40,A6)
            fmul.x  sub_408934EA.L35,FP0
            add.w   D0,(-$30,A6)
            bra.w   sub_40892C84.L5
sub_40892C84:
            cmpi.l  #$3FFF8000,D0
            bgt.b   .L1
            fmove.l D1,FPCR
            fadd.s  #"$3F800000",FP0
            bra.w   sub_40890B12
.L1:
            move.l  (-$74,A6),D0
            tst.l   D0
            bmi.b   .L2
            bclr    #7,(A0)
            bra.w   sub_40890AB4
.L2:
            bclr    #7,(A0)
            bra.w   sub_408909D4
            fmove.l D1,FPCR
            fmove.s #"$3F800000",FP0
            move.l  (A0),D0
            ori.l   #$800001,D0
            fadd.s  D0,FP0
            bra.w   sub_40890B12
            fmovem.x (A0),FP0
            move.l  (A0),D0
            move.w  (4,A0),D0
            fmove.x FP0,(-$74,A6)
            andi.l  #$7FFFFFFF,D0
            cmpi.l  #$3FB98000,D0
            bge.b   .L3
            bra.b   sub_40892C84
.L3:
            cmpi.l  #$400B9B07,D0
            ble.b   .L4
            bra.b   sub_40892C84
.L4:
            fmove.x FP0,FP1
            fmul.d  sub_408934EA.L31,FP1
            fmove.l FP1,(-$54,A6)
            move.l  D2,-(SP)
            lea     sub_408934EA.L41,A1
            fmove.l (-$54,A6),FP1
            move.l  (-$54,A6),D0
            move.l  D0,D2
            andi.l  #$3F,D0
            asl.l   #4,D0
            adda.l  D0,A1
            asr.l   #6,D2
            move.l  D2,D0
            asr.l   #1,D0
            sub.l   D0,D2
            addi.l  #$3FFF,D2
            move.w  D2,(-$64,A6)
            move.l  (SP)+,D2
            fmove.x FP1,FP2
            fmul.d  sub_408934EA.L32,FP1
            move.l  (A1)+,(-$40,A6)
            fmul.x  sub_408934EA.L33,FP2
            move.l  (A1)+,(-$3C,A6)
            move.l  (A1)+,(-$38,A6)
            fsub.x  FP1,FP0
            move.w  (A1)+,(-$30,A6)
            fsub.x  FP2,FP0
            clr.w   (-$2E,A6)
            move.w  (A1)+,(-$2C,A6)
            clr.w   (-$2A,A6)
            clr.l   (-$28,A6)
            fmul.x  sub_408934EA.L34,FP0
            add.w   D0,(-$40,A6)
            add.w   D0,(-$30,A6)
.L5:
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.d sub_408934EA.L36,FP2
            fmove.d sub_408934EA.L37,FP3
            fmul.x  FP1,FP2
            fmul.x  FP1,FP3
            fadd.d  sub_408934EA.L38,FP2
            fadd.d  sub_408934EA.L39,FP3
            fmul.x  FP1,FP2
            fmul.x  FP1,FP3
            fadd.d  sub_408934EA.L40,FP2
            fmul.x  FP0,FP3
            fmul.x  FP1,FP2
            fadd.x  FP3,FP0
            fadd.x  FP2,FP0
            fmul.x  (-$40,A6),FP0
            fadd.x  (-$30,A6),FP0
            fadd.x  (-$40,A6),FP0
            fmove.l D1,FPCR
            clr.w   (-$62,A6)
            move.l  #$80000000,(-$60,A6)
            clr.l   (-$5C,A6)
            fmul.x  (-$64,A6),FP0
            bra.w   sub_40890B12
            fmove.l D1,FPCR
            fmove.x sub_408934EA.L43,FP0
            bra.w   sub_40890B12
            fmove.x (A0),FP0
            move.l  (A0),D0
            move.w  (4,A0),D0
            andi.l  #$7FFFFFFF,D0
            cmpi.l  #$3FFF8000,D0
            bge.b   .L6
            fmove.s #"$3F800000",FP1
            fadd.x  FP0,FP1
            fneg.x  FP0,FP0
            fadd.s  #"$3F800000",FP0
            fdiv.x  FP1,FP0
            fsqrt.x FP0,FP0
            fmovem.x FP0,(A0)
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   sub_40892F1E
            fmove.l (SP)+,FPCR
            fadd.x  FP0,FP0
            bra.w   sub_40890B12
.L6:
            fabs.x  FP0,FP0
            fcmp.s  #"$3F800000",FP0
            fbgt.w  sub_408909B6
            move.l  (A0),D0
            move.w  (4,A0),D0
            cmpi.l  #0,D0
            bgt.b   .L7
            fmove.x sub_408934EA.L42,FP0
            fmove.l D1,FPCR
            fadd.s  #"$00800000",FP0
            bra.w   sub_40890B12
.L7:
            fmove.l D1,FPCR
            fmove.s #"$00000000",FP0
            rts
            dc.w    $6000,$DD60,$F210,$4800,$2010,$3028,$0004,$0280
            dc.w    $7FFF,$FFFF,$0C80,$3FFF,$8000,$6C36,$F23C,$4480
            dc.w    $3F80,0,$F200,$00A8,$F227,$E004,$F23C,$4500
            dc.w    $3F80,0,$F200,$0122,$F200,$08A3,$F21F,$D020
            dc.w    $F200,$0484,$F200,$0420,$F210,$F080,$613A,$6000
            dc.w    $DC2C,$F200,$0018,$F23C,$4438,$3F80,0,$F292
            dc.b    $DA,$C0,$F2,$3A,$48,$00,$17,$64,$20,$10,$02,$80,$80
            ds.b    4
            dc.b    $80,$3F,$80,$00,$00,$2F,$00,$F2,$01,$90,$00,$F2,$1F,$44,$23,$60
            dc.b    $00,$DB,$FA,$60,$00,$DC,$DC
sub_40892F1E:
            fmove.x (A0),FP0
            move.l  (A0),D0
            move.w  (4,A0),D0
            fmove.x FP0,(-$74,A6)
            andi.l  #$7FFFFFFF,D0
            cmpi.l  #$3FFB8000,D0
            bge.b   .L1
            bra.w   .L3
.L1:
            cmpi.l  #$4002FFFF,D0
            ble.b   .L2
            bra.w   .L5
.L2:
            clr.w   (-$72,A6)
            andi.l  #$F8000000,(-$70,A6)
            ori.l   #$4000000,(-$70,A6)
            clr.l   (-$6C,A6)
            fmove.x FP0,FP1
            fmul.x  (-$74,A6),FP1
            fsub.x  (-$74,A6),FP0
            fadd.s  #"$3F800000",FP1
            fdiv.x  FP1,FP0
            move.l  D2,-(SP)
            move.l  D0,D2
            andi.l  #$7800,D0
            andi.l  #$7FFF0000,D2
            subi.l  #$3FFB0000,D2
            asr.l   #1,D2
            add.l   D2,D0
            asr.l   #7,D0
            lea     sub_408934EA.L59,A1
            adda.l  D0,A1
            move.l  (A1)+,(-$64,A6)
            move.l  (A1)+,(-$60,A6)
            move.l  (A1)+,(-$5C,A6)
            move.l  (-$74,A6),D0
            andi.l  #$80000000,D0
            or.l    D0,(-$64,A6)
            move.l  (SP)+,D2
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.d sub_408934EA.L44,FP2
            fadd.x  FP1,FP2
            fmul.x  FP1,FP2
            fmul.x  FP0,FP1
            fadd.d  sub_408934EA.L45,FP2
            fmul.d  sub_408934EA.L46,FP1
            fmul.x  FP2,FP1
            fadd.x  FP1,FP0
            fmove.l D1,FPCR
            fadd.x  (-$64,A6),FP0
            bra.w   sub_40890B12
            cmpi.l  #$3FFF8000,D0
            bgt.w   .L5
.L3:
            cmpi.l  #$3FD78000,D0
            blt.b   .L4
            fmul.x  FP0,FP0
            clr.w   (-$72,A6)
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.d sub_408934EA.L47,FP2
            fmove.d sub_408934EA.L48,FP3
            fmul.x  FP1,FP2
            fmul.x  FP1,FP3
            fadd.d  sub_408934EA.L49,FP2
            fadd.d  sub_408934EA.L50,FP3
            fmul.x  FP1,FP2
            fmul.x  FP3,FP1
            fadd.d  sub_408934EA.L51,FP2
            fadd.d  sub_408934EA.L52,FP1
            fmul.x  FP0,FP2
            fmul.x  (-$74,A6),FP0
            fadd.x  FP2,FP1
            fmul.x  FP1,FP0
            fmove.l D1,FPCR
            fadd.x  (-$74,A6),FP0
            bra.w   sub_40890B12
.L4:
            clr.w   (-$72,A6)
            fmove.l D1,FPCR
            fmove.x (-$74,A6),FP0
            bra.w   sub_40890B12
.L5:
            cmpi.l  #$40638000,D0
            bgt.w   .L7
            fmove.s #"$BF800000",FP1
            fdiv.x  FP0,FP1
            fmove.x FP1,FP0
            fmul.x  FP0,FP0
            fmove.x FP1,(-$74,A6)
            fmove.x FP0,FP1
            fmul.x  FP1,FP1
            fmove.d sub_408934EA.L53,FP3
            fmove.d sub_408934EA.L54,FP2
            fmul.x  FP1,FP3
            fmul.x  FP1,FP2
            fadd.d  sub_408934EA.L55,FP3
            fadd.d  sub_408934EA.L56,FP2
            fmul.x  FP3,FP1
            fmul.x  FP0,FP2
            fadd.d  sub_408934EA.L57,FP1
            fmul.x  (-$74,A6),FP0
            fadd.x  FP2,FP1
            fmul.x  FP1,FP0
            fadd.x  (-$74,A6),FP0
            fmove.l D1,FPCR
            btst    #7,(A0)
            beq.b   .L6
            fadd.x  sub_40890C9C.L8,FP0
            bra.w   sub_40890B12
.L6:
            fadd.x  sub_408934EA.L43,FP0
            bra.w   sub_40890B12
.L7:
            btst    #7,(A0)
            beq.b   .L8
            fmove.x sub_40890C9C.L8,FP0
            fmove.l D1,FPCR
            fadd.x  sub_408934EA.L58,FP0
            bra.w   sub_40890B12
.L8:
            fmove.x sub_408934EA.L43,FP0
            fmove.l D1,FPCR
            fsub.x  sub_408934EA.L58,FP0
            bra.w   sub_40890B12
sub_4089313C:
            tst.l   (A0)
            bmi.w   sub_408909B6
            bsr.b   lognrm
            bra.b   sub_408931B0
lognrm:
            movem.l D3-D7,-(SP)
            move.l  (4,A0),D4
            move.l  (8,A0),D5
            moveq   #0,D3
            bfffo   D4{0:0},D6
            bne.b   .L1
            move.l  D5,D4
            moveq   #0,D5
            moveq   #$20,D3
            bfffo   D4{0:0},D6
.L1:
            lsl.l   D6,D4
            add.l   D6,D3
            move.l  D5,D7
            lsl.l   D6,D5
            neg.b   D6
            addi.b  #$20,D6
            lsr.l   D6,D7
            neg.l   D3
            or.l    D7,D4
            clr.l   (-$74,A6)
            move.l  D4,(-$70,A6)
            move.l  D5,(-$6C,A6)
            move.l  D3,(-$54,A6)
            movem.l (SP)+,D3-D7
            lea     (-$74,A6),A0
            rts
slogn:
            tst.l   (A0)
            bmi.w   sub_408909B6
            clr.l   (-$54,A6)
            move.l  (A0),(-$74,A6)
            move.l  (4,A0),(-$70,A6)
            move.l  (8,A0),(-$6C,A6)
            lea     (-$74,A6),A0
sub_408931B0:
            move.l  (A0),D0
            move.w  (4,A0),D0
            fmove.x (A0),FP0
            dc.w    $04FA,0,$1D52,$6400,$00DE,$E080,$E080,$0480
            dc.w    0,$3FFF,$D0AE,$FFAC,$41FA,$1DDC,$F200,$4080
            dc.w    $2D7C,$3FFF,0,$FF8C,$2D6E,$FF90,$FFA0,$02AE
            dc.w    $FE00,0,$FFA0,$00AE,$0100,0,$FFA0,$202E
            dc.w    $FFA0,$0280,$7E00,0,$E080,$E080,$E880,$D1C0
            dc.w    $F22E,$4800,$FF8C,$2D7C,$3FFF,0,$FF9C,$42AE
            dc.w    $FFA4,$F22E,$4828,$FF9C,$F227,$E00C,$F210,$4823
            dc.w    $F23A,$48A3,$1CF2,$F200,$0100,$F200,$0923,$F22E
            dc.w    $6880,$FFC0,$F200,$0980,$F200,$0880,$F23A,$54A3
            dc.w    $1CF6,$F23A,$5523,$1CF8,$F23A,$54A2,$1CFA,$F23A
            dc.w    $5522,$1CFC,$F200,$0CA3,$F200,$0D23,$F23A,$54A2
            dc.w    $1CF6,$F23A,$5522,$1CF8,$F200,$0CA3,$D0FC,$0010
            dc.w    $F200,$0D23,$F200,$00A3,$F200,$0822,$F210,$48A2
            dc.w    $F21F,$D030,$F200,$0422,$F201,$9000,$F22E,$4822
            dc.w    $FFC0,$6000,$D874,$F200,$0080,$F23A,$44A8,$1C88
            dc.w    $F23A,$4422,$1C82,$F200,$04A2,$F200,$00A0,$F227
            dc.w    $E00C,$F200,$0400,$F200,$0023,$F22E,$6880,$FFD0
            dc.w    $F200,$0080,$F200,$04A3,$F23A,$5580,$1C9A,$F23A
            dc.w    $5500,$1C9C,$F200,$05A3,$F200,$0523,$F23A,$55A2
            dc.w    $1C96,$F23A,$5522,$1C98,$F200,$0CA3,$F200,$0123
            dc.w    $F23A,$54A2,$1C92,$F22E,$4823,$FFD0,$F200,$08A2
            dc.w    $F21F,$D030,$F200,$0423,$F201,$9000,$F22E,$4822
            dc.w    $FFD0,$6000,$D7F4,$4E75,$6000,$D8D4
.L1:
            fmove.x (A0),FP0
            fabs.x  FP0,FP0
            fcmp.x  sub_408934EA.L65,FP0
            fbgt.w  .L2
            fmove.l #0,FPSR
            fmove.l D1,FPCR
            fmove.x (A0),FP0
            bra.w   sub_40890B12
.L2:
            fmove.x (A0),FP0
            clr.l   (-$54,A6)
            fmove.x FP0,FP1
            fadd.s  sub_408934EA.L62,FP0
            fmove.x FP0,(-$74,A6)
            move.w  (-$70,A6),(-$72,A6)
            move.l  (-$74,A6),D0
            tst.l   D0
            ble.w   .L3
            dc.w    $04FA,0,$1BA0,$6500,$FE48,$04FA,0,$1B8E
            dc.w    $650E,$F200,$04A2,$F23A,$4422,$1BA2,$6000,$FF22
            dc.w    $2D6E,$FF90,$FFA0,$02AE,$FE00,0,$FFA0,$00AE
            dc.w    $0100,0,$FFA0,$0C80,$3FFF,$8000,$6C44,$F23A
            dc.w    $4400,$1BE2,$2D7C,$3FFF,0,$FF9C,$42AE,$FFA4
            dc.w    $F22E,$4828,$FF9C,$202E,$FFA0,$0280,$7E00,0
            dc.w    $E080,$E080,$E880,$F200,$04A2,$F227,$E00C,$F200
            dc.w    $0422,$41FA,$1BC8,$D1C0,$F23A,$4480,$1B4C,$6000
            dc.w    $FE32,$F23A,$4400,$1B36,$2D7C,$3FFF,0,$FF9C
            dc.w    $42AE,$FFA4,$F22E,$4828,$FF9C,$202E,$FFA0,$0280
            dc.w    $7E00,0,$E080,$E080,$E880,$F200,$0422,$F227
            dc.w    $E00C,$41FA,$1B88,$D1C0,$F23A,$4480,$1B04,$6000
            dc.w    $FDF2
.L3:
            tst.l   D0
            bmi.b   .L4
            fmove.s sub_408934EA.L64,FP0
            fmove.l D1,FPCR
            bra.w   sub_40890882.L5
.L4:
            fmove.s sub_408934EA.L63,FP0
            fmove.l D1,FPCR
            bra.w   sub_408909B6
.L5:
            tst.l   (A0)
            bmi.w   sub_408909B6
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   sub_4089313C
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L60,FP0
            bra.w   sub_40890B12
.L6:
            tst.l   (A0)
            bmi.w   sub_408909B6
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   slogn
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L60,FP0
            bra.w   sub_40890B12
.L7:
            tst.l   (A0)
            bmi.w   sub_408909B6
            bsr.w   lognrm
            tst.l   (8,A0)
            bne.b   .L8
            move.l  (4,A0),D0
            lsl.l   #1,D0
            bne.b   .L8
            move.l  (-$54,A6),D0
            bra.b   .L10
.L8:
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   sub_408931B0
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L61,FP0
            bra.w   sub_40890B12
.L9:
            tst.l   (A0)
            bmi.w   sub_408909B6
            tst.l   (8,A0)
            bne.b   sub_408934EA
            move.l  (4,A0),D0
            andi.l  #$7FFFFFFF,D0
            bne.b   sub_408934EA
            move.w  (A0),D0
.L10:
            subi.w  #$3FFF,D0
            fmove.l D1,FPCR
            fmove.w D0,FP0
            rts
sub_408934EA:
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   slogn
            fmove.l (SP)+,FPCR
            fmul.x  .L61,FP0
            bra.w   sub_40890B12
.L1:
            dc.l    $40000000,$C90FDAA2,$2168C235  ; pi
.L2:
            dc.l    $40000000,$C90FDAA2,$2168C234  ; pi
.L3:
            dc.l    $40000000,$C90FDAA2,$2168C235  ; pi
.L4:
            dc.l    $3FFD0000,$9A209A84,$FBCFF798  ; log10(2)
            dc.l    $40000000,$ADF85458,$A2BB4A9A  ; e
            dc.l    $3FFF0000,$B8AA3B29,$5C17F0BC  ; log2(e)
            dc.l    $3FFD0000,$DE5BD8A9,$37287195  ; log10(e)
            dc.l    $00000000,$00000000,$00000000  ; 0.0
.L5:
            dc.l    $3FFD0000,$9A209A84,$FBCFF798  ; log10(2)
            dc.l    $40000000,$ADF85458,$A2BB4A9A  ; e
            dc.l    $3FFF0000,$B8AA3B29,$5C17F0BB  ; log2(e)
            dc.l    $3FFD0000,$DE5BD8A9,$37287195  ; log10(e)
            dc.l    $00000000,$00000000,$00000000  ; 0.0
.L6:
            dc.l    $3FFD0000,$9A209A84,$FBCFF799  ; log10(2)
            dc.l    $40000000,$ADF85458,$A2BB4A9B  ; e
            dc.l    $3FFF0000,$B8AA3B29,$5C17F0BC  ; log2(e)
            dc.l    $3FFD0000,$DE5BD8A9,$37287195  ; log10(e)
            dc.l    $00000000,$00000000,$00000000  ; 0.0
.L7:
            dc.l    $3FFE0000,$B17217F7,$D1CF79AC  ; ln(2)
            dc.l    $40000000,$935D8DDD,$AAA8AC17  ; ln(10)
            dc.l    $3FFF0000,$80000000,$00000000  ; 10 ^ 0
.L8:
            dc.l    $40020000,$A0000000,$00000000  ; 10 ^ 1
            dc.l    $40050000,$C8000000,$00000000  ; 10 ^ 2
            dc.l    $400C0000,$9C400000,$00000000  ; 10 ^ 4
            dc.l    $40190000,$BEBC2000,$00000000  ; 10 ^ 8
            dc.l    $40340000,$8E1BC9BF,$04000000  ; 10 ^ 16
            dc.l    $40690000,$9DC5ADA8,$2B70B59E  ; 10 ^ 32
            dc.l    $40D30000,$C2781F49,$FFCFA6D5  ; 10 ^ 64
            dc.l    $41A80000,$93BA47C9,$80E98CE0  ; 10 ^ 128
            dc.l    $43510000,$AA7EEBFB,$9DF9DE8E  ; 10 ^ 256
            dc.l    $46A30000,$E319A0AE,$A60E91C7  ; 10 ^ 512
            dc.l    $4D480000,$C9767586,$81750C17  ; 10 ^ 1024
            dc.l    $5A920000,$9E8B3B5D,$C53D5DE5  ; 10 ^ 2048
            dc.l    $75250000,$C4605202,$8A20979B  ; 10 ^ 4096
.L9:
            dc.l    $3FFE0000,$B17217F7,$D1CF79AB  ; ln(2)
            dc.l    $40000000,$935D8DDD,$AAA8AC16  ; ln(10)
            dc.l    $3FFF0000,$80000000,$00000000  ; 10 ^ 0
.L10:
            dc.l    $40020000,$A0000000,$00000000  ; 10 ^ 1
            dc.l    $40050000,$C8000000,$00000000  ; 10 ^ 2
            dc.l    $400C0000,$9C400000,$00000000  ; 10 ^ 4
            dc.l    $40190000,$BEBC2000,$00000000  ; 10 ^ 8
            dc.l    $40340000,$8E1BC9BF,$04000000  ; 10 ^ 16
            dc.l    $40690000,$9DC5ADA8,$2B70B59D  ; 10 ^ 32
            dc.l    $40D30000,$C2781F49,$FFCFA6D5  ; 10 ^ 64
            dc.l    $41A80000,$93BA47C9,$80E98CDF  ; 10 ^ 128
            dc.l    $43510000,$AA7EEBFB,$9DF9DE8D  ; 10 ^ 256
            dc.l    $46A30000,$E319A0AE,$A60E91C6  ; 10 ^ 512
            dc.l    $4D480000,$C9767586,$81750C17  ; 10 ^ 1024
            dc.l    $5A920000,$9E8B3B5D,$C53D5DE5  ; 10 ^ 2048
            dc.l    $75250000,$C4605202,$8A20979A  ; 10 ^ 4096
.L11:
            dc.l    $3FFE0000,$B17217F7,$D1CF79AC  ; ln(2)
            dc.l    $40000000,$935D8DDD,$AAA8AC17  ; ln(10)
            dc.l    $3FFF0000,$80000000,$00000000  ; 10 ^ 0
.L12:
            dc.l    $40020000
            dc.l    $A0000000
            dc.l    $00000000
            dc.l    $40050000
            dc.l    $C8000000
            dc.l    $00000000
            dc.l    $400C0000
            dc.l    $9C400000
            dc.l    $00000000
            dc.l    $40190000
            dc.l    $BEBC2000
            dc.l    $00000000
            dc.l    $40340000
            dc.l    $8E1BC9BF
            dc.l    $04000000
            dc.l    $40690000
            dc.l    $9DC5ADA8
            dc.l    $2B70B59E
            dc.l    $40D30000
            dc.l    $C2781F49
            dc.l    $FFCFA6D6
            dc.l    $41A80000
            dc.l    $93BA47C9
            dc.l    $80E98CE0
            dc.l    $43510000
            dc.l    $AA7EEBFB
            dc.l    $9DF9DE8E
            dc.l    $46A30000
            dc.l    $E319A0AE
            dc.l    $A60E91C7
            dc.l    $4D480000
            dc.l    $C9767586
            dc.l    $81750C18
            dc.l    $5A920000
            dc.l    $9E8B3B5D
            dc.l    $C53D5DE6
            dc.l    $75250000
            dc.l    $C4605202
            dc.l    $8A20979B
            dc.l    $00000000
            dc.l    $00000000
.L13:
            dc.l    $40C62D38,$D3D64634            ; 16381 LOG2 LEAD
.L14:
            dc.l    $3D6F90AE,$B1E75CC7            ; 16381 LOG2 TRAIL
            dc.l    $7FFB0000,$80000000,$00000000,$00000000
            dc.l    $BD6AAA77,$CCC994F5
            dc.l    $3DE61209,$7AAE8DA1
            dc.l    $BE5AE645,$2A118AE4
            dc.l    $3EC71DE3,$A5341531
            dc.l    $BF2A01A0,$1A018B59,$00000000,$00000000
            dc.l    $3FF80000,$88888888,$888859AF,$00000000
            dc.l    $BFFC0000,$AAAAAAAA,$AAAAAA99,$00000000
            dc.l    $3D2AC4D0,$D6011EE3
            dc.l    $BDA9396F,$9F45AC19
            dc.l    $3E21EED9,$0612C972
            dc.l    $BE927E4F,$B79D9FCF
            dc.l    $3EFA01A0,$1A01D423
            dc.l    $3FE45F30,$6DC9C883
            dc.l    $BFF50000,$B60B60B6,$0B61D438,$00000000
            dc.l    $3FFA0000,$AAAAAAAA,$AAAAAB5E
            dc.l    $BF000000
            dc.l    $3EA0B759,$F50F8688
            dc.l    $BEF2BAA5,$A8924F04
            dc.l    $BF346F59,$B39BA65F,$00000000,$00000000
            dc.l    $3FF60000,$E073D3FC,$199C4A00,$00000000
            dc.l    $3FF90000,$D23CD684,$15D95FA1,$00000000
            dc.l    $BFFC0000,$8895A6C5,$FB423BCA,$00000000
            dc.l    $BFFD0000,$EEF57E0D,$A84BC8CE,$00000000
            dc.l    $C0040000,$C90FDAA2,$2168C235,$21800000
            dc.l    $C0040000,$C2C75BCD,$105D7C23,$A0D00000
            dc.l    $C0040000,$BC7EDCF7,$FF523611,$A1E80000
            dc.l    $C0040000,$B6365E22,$EE46F000,$21480000
            dc.l    $C0040000,$AFEDDF4D,$DD3BA9EE,$A1200000
            dc.l    $C0040000,$A9A56078,$CC3063DD,$21FC0000
            dc.l    $C0040000,$A35CE1A3,$BB251DCB,$21100000
            dc.l    $C0040000,$9D1462CE,$AA19D7B9,$A1580000
            dc.l    $C0040000,$96CBE3F9,$990E91A8,$21E00000
            dc.l    $C0040000,$90836524,$88034B96,$20B00000
            dc.l    $C0040000,$8A3AE64F,$76F80584,$A1880000
            dc.l    $C0040000,$83F2677A,$65ECBF73,$21C40000
            dc.l    $C0030000,$FB53D14A,$A9C2F2C2,$20000000
            dc.l    $C0030000,$EEC2D3A0,$87AC669F,$21380000
            dc.l    $C0030000,$E231D5F6,$6595DA7B,$A1300000
            dc.l    $C0030000,$D5A0D84C,$437F4E58,$9FC00000
            dc.l    $C0030000,$C90FDAA2,$2168C235,$21000000
            dc.l    $C0030000,$BC7EDCF7,$FF523611,$A1680000
            dc.l    $C0030000,$AFEDDF4D,$DD3BA9EE,$A0A00000
            dc.l    $C0030000,$A35CE1A3,$BB251DCB,$20900000
            dc.l    $C0030000,$96CBE3F9,$990E91A8,$21600000
            dc.l    $C0030000,$8A3AE64F,$76F80584,$A1080000
            dc.l    $C0020000,$FB53D14A,$A9C2F2C2,$1F800000
            dc.l    $C0020000,$E231D5F6,$6595DA7B,$A0B00000
            dc.l    $C0020000,$C90FDAA2,$2168C235,$20800000
            dc.l    $C0020000,$AFEDDF4D,$DD3BA9EE,$A0200000
            dc.l    $C0020000,$96CBE3F9,$990E91A8,$20E00000
            dc.l    $C0010000,$FB53D14A,$A9C2F2C2,$1F000000
            dc.l    $C0010000,$C90FDAA2,$2168C235,$20000000
            dc.l    $C0010000,$96CBE3F9,$990E91A8,$20600000
            dc.l    $C0000000,$C90FDAA2,$2168C235,$1F800000
            dc.l    $BFFF0000,$C90FDAA2,$2168C235,$1F000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $3FFF0000,$C90FDAA2,$2168C235,$9F000000
            dc.l    $40000000,$C90FDAA2,$2168C235,$9F800000
            dc.l    $40010000,$96CBE3F9,$990E91A8,$A0600000
            dc.l    $40010000,$C90FDAA2,$2168C235,$A0000000
            dc.l    $40010000,$FB53D14A,$A9C2F2C2,$9F000000
            dc.l    $40020000,$96CBE3F9,$990E91A8,$A0E00000
            dc.l    $40020000,$AFEDDF4D,$DD3BA9EE,$20200000
            dc.l    $40020000,$C90FDAA2,$2168C235,$A0800000
            dc.l    $40020000,$E231D5F6,$6595DA7B,$20B00000
            dc.l    $40020000,$FB53D14A,$A9C2F2C2,$9F800000
            dc.l    $40030000,$8A3AE64F,$76F80584,$21080000
            dc.l    $40030000,$96CBE3F9,$990E91A8,$A1600000
            dc.l    $40030000,$A35CE1A3,$BB251DCB,$A0900000
            dc.l    $40030000,$AFEDDF4D,$DD3BA9EE,$20A00000
            dc.l    $40030000,$BC7EDCF7,$FF523611,$21680000
            dc.l    $40030000,$C90FDAA2,$2168C235,$A1000000
            dc.l    $40030000,$D5A0D84C,$437F4E58,$1FC00000
            dc.l    $40030000,$E231D5F6,$6595DA7B,$21300000
            dc.l    $40030000,$EEC2D3A0,$87AC669F,$A1380000
            dc.l    $40030000,$FB53D14A,$A9C2F2C2,$A0000000
            dc.l    $40040000,$83F2677A,$65ECBF73,$A1C40000
            dc.l    $40040000,$8A3AE64F,$76F80584,$21880000
            dc.l    $40040000,$90836524,$88034B96,$A0B00000
            dc.l    $40040000,$96CBE3F9,$990E91A8,$A1E00000
            dc.l    $40040000,$9D1462CE,$AA19D7B9,$21580000
            dc.l    $40040000,$A35CE1A3,$BB251DCB,$A1100000
            dc.l    $40040000,$A9A56078,$CC3063DD,$A1FC0000
            dc.l    $40040000,$AFEDDF4D,$DD3BA9EE,$21200000
            dc.l    $40040000,$B6365E22,$EE46F000,$A1480000
            dc.l    $40040000,$BC7EDCF7,$FF523611,$21E80000
            dc.l    $40040000,$C2C75BCD,$105D7C23,$20D00000
            dc.l    $40040000,$C90FDAA2,$2168C235,$A1800000
.L15:
            dc.l    $3FDC0000,$82E30865,$4361C4C6,$00000000
.L16:
            dc.l    $3FA55555,$55554431
.L17:
            dc.l    $3FC55555,$55554018
.L18:
            dc.l    $3F811111,$11174385
.L19:
            dc.l    $3FA55555,$55554F5A
.L20:
            dc.l    $3FC55555,$55555555,$00000000,$00000000
.L21:
            dc.l    $3EC71DE3,$A5774682
.L22:
            dc.l    $3EFA01A0,$19D7CB68
.L23:
            dc.l    $3F2A01A0,$1A019DF3
.L24:
            dc.l    $3F56C16C,$16C170E2
.L25:
            dc.l    $3F811111,$11111111
.L26:
            dc.l    $3FA55555,$55555555
.L27:
            dc.l    $3FFC0000,$AAAAAAAA,$AAAAAAAB
            dc.l    $00000000
.L28:
            dc.l    $48B00000,$00000000
.L29:
            dc.l    $37300000,$00000000
.L30:
            dc.l    $3FFF0000,$80000000,$00000000,$00000000
            dc.l    $3FFF0000,$8164D1F3,$BC030774,$9F841A9B
            dc.l    $3FFF0000,$82CD8698,$AC2BA1D8,$9FC1D5B9
            dc.l    $3FFF0000,$843A28C3,$ACDE4048,$A0728369
            dc.l    $3FFF0000,$85AAC367,$CC487B14,$1FC5C95C
            dc.l    $3FFF0000,$871F6196,$9E8D1010,$1EE85C9F
            dc.l    $3FFF0000,$88980E80,$92DA8528,$9FA20729
            dc.l    $3FFF0000,$8A14D575,$496EFD9C,$A07BF9AF
            dc.l    $3FFF0000,$8B95C1E3,$EA8BD6E8,$A0020DCF
            dc.l    $3FFF0000,$8D1ADF5B,$7E5BA9E4,$205A63DA
            dc.l    $3FFF0000,$8EA4398B,$45CD53C0,$1EB70051
            dc.l    $3FFF0000,$9031DC43,$1466B1DC,$1F6EB029
            dc.l    $3FFF0000,$91C3D373,$AB11C338,$A0781494
            dc.l    $3FFF0000,$935A2B2F,$13E6E92C,$9EB319B0
            dc.l    $3FFF0000,$94F4EFA8,$FEF70960,$2017457D
            dc.l    $3FFF0000,$96942D37,$20185A00,$1F11D537
            dc.l    $3FFF0000,$9837F051,$8DB8A970,$9FB952DD
            dc.l    $3FFF0000,$99E04593,$20B7FA64,$1FE43087
            dc.l    $3FFF0000,$9B8D39B9,$D54E5538,$1FA2A818
            dc.l    $3FFF0000,$9D3ED9A7,$2CFFB750,$1FDE494D
            dc.l    $3FFF0000,$9EF53260,$91A111AC,$20504890
            dc.l    $3FFF0000,$A0B0510F,$B9714FC4,$A073691C
            dc.l    $3FFF0000,$A2704303,$0C496818,$1F9B7A05
            dc.l    $3FFF0000,$A43515AE,$09E680A0,$A0797126
            dc.l    $3FFF0000,$A5FED6A9,$B15138EC,$A071A140
            dc.l    $3FFF0000,$A7CD93B4,$E9653568,$204F62DA
            dc.l    $3FFF0000,$A9A15AB4,$EA7C0EF8,$1F283C4A
            dc.l    $3FFF0000,$AB7A39B5,$A93ED338,$9F9A7FDC
            dc.l    $3FFF0000,$AD583EEA,$42A14AC8,$A05B3FAC
            dc.l    $3FFF0000,$AF3B78AD,$690A4374,$1FDF2610
            dc.l    $3FFF0000,$B123F581,$D2AC2590,$9F705F90
            dc.l    $3FFF0000,$B311C412,$A9112488,$201F678A
            dc.l    $3FFF0000,$B504F333,$F9DE6484,$1F32FB13
            dc.l    $3FFF0000,$B6FD91E3,$28D17790,$20038B30
            dc.l    $3FFF0000,$B8FBAF47,$62FB9EE8,$200DC3CC
            dc.l    $3FFF0000,$BAFF5AB2,$133E45FC,$9F8B2AE6
            dc.l    $3FFF0000,$BD08A39F,$580C36C0,$A02BBF70
            dc.l    $3FFF0000,$BF1799B6,$7A731084,$A00BF518
            dc.l    $3FFF0000,$C12C4CCA,$66709458,$A041DD41
            dc.l    $3FFF0000,$C346CCDA,$24976408,$9FDF137B
            dc.l    $3FFF0000,$C5672A11,$5506DADC,$201F1568
            dc.l    $3FFF0000,$C78D74C8,$ABB9B15C,$1FC13A2E
            dc.l    $3FFF0000,$C9B9BD86,$6E2F27A4,$A03F8F03
            dc.l    $3FFF0000,$CBEC14FE,$F2727C5C,$1FF4907D
            dc.l    $3FFF0000,$CE248C15,$1F8480E4,$9E6E53E4
            dc.l    $3FFF0000,$D06333DA,$EF2B2594,$1FD6D45C
            dc.l    $3FFF0000,$D2A81D91,$F12AE45C,$A076EDB9
            dc.l    $3FFF0000,$D4F35AAB,$CFEDFA20,$9FA6DE21
            dc.l    $3FFF0000,$D744FCCA,$D69D6AF4,$1EE69A2F
            dc.l    $3FFF0000,$D99D15C2,$78AFD7B4,$207F439F
            dc.l    $3FFF0000,$DBFBB797,$DAF23754,$201EC207
            dc.l    $3FFF0000,$DE60F482,$5E0E9124,$9E8BE175
            dc.l    $3FFF0000,$E0CCDEEC,$2A94E110,$20032C4B
            dc.l    $3FFF0000,$E33F8972,$BE8A5A50,$2004DFF5
            dc.l    $3FFF0000,$E5B906E7,$7C8348A8,$1E72F47A
            dc.l    $3FFF0000,$E8396A50,$3C4BDC68,$1F722F22
            dc.l    $3FFF0000,$EAC0C6E7,$DD243930,$A017E945
            dc.l    $3FFF0000,$ED4F301E,$D9942B84,$1F401A5B
            dc.l    $3FFF0000,$EFE4B99B,$DCDAF5CC,$9FB9A9E3
            dc.l    $3FFF0000,$F281773C,$59FFB138,$20744C05
            dc.l    $3FFF0000,$F5257D15,$2486CC2C,$1F773A19
            dc.l    $3FFF0000,$F7D0DF73,$0AD13BB8,$1FFE90D5
            dc.l    $3FFF0000,$FA83B2DB,$722A033C,$A041ED22
            dc.l    $3FFF0000,$FD3E0C0C,$F486C174,$1F853F3A
.L31:
            dc.l    $406A934F,$0979A371            ; 64LOG10/LOG2
.L32:
            dc.l    $3F734413,$509F8000            ; LOG2/64LOG10
.L33:
            dc.l    $BFCD0000,$C0219DC1,$DA994FD2,$00000000
.L34:
            dc.l    $40000000,$935D8DDD,$AAA8AC17,$00000000
.L35:
            dc.l    $3FFE0000,$B17217F7,$D1CF79AC,$00000000
.L36:
            dc.l    $3F56C16D,$6F7BD0B2            ; <1/7/91, JPO>
.L37:
            dc.l    $3F811112,$302C712C            ; <1/7/91, JPO>
.L38:
            dc.l    $3FA55555,$55554CC1            ; <1/7/91, JPO>
.L39:
            dc.l    $3FC55555,$55554A54            ; <1/7/91, JPO>
.L40:
            dc.l    $3FE00000,$00000000,$00000000,$00000000 ; <1/7/91, JPO>
.L41:
            dc.l    $3FFF0000,$80000000,$00000000,$3F738000
            dc.l    $3FFF0000,$8164D1F3,$BC030773,$3FBEF7CA
            dc.l    $3FFF0000,$82CD8698,$AC2BA1D7,$3FBDF8A9
            dc.l    $3FFF0000,$843A28C3,$ACDE4046,$3FBCD7C9
            dc.l    $3FFF0000,$85AAC367,$CC487B15,$BFBDE8DA
            dc.l    $3FFF0000,$871F6196,$9E8D1010,$3FBDE85C
            dc.l    $3FFF0000,$88980E80,$92DA8527,$3FBEBBF1
            dc.l    $3FFF0000,$8A14D575,$496EFD9A,$3FBB80CA
            dc.l    $3FFF0000,$8B95C1E3,$EA8BD6E7,$BFBA8373
            dc.l    $3FFF0000,$8D1ADF5B,$7E5BA9E6,$BFBE9670
            dc.l    $3FFF0000,$8EA4398B,$45CD53C0,$3FBDB700
            dc.l    $3FFF0000,$9031DC43,$1466B1DC,$3FBEEEB0
            dc.l    $3FFF0000,$91C3D373,$AB11C336,$3FBBFD6D
            dc.l    $3FFF0000,$935A2B2F,$13E6E92C,$BFBDB319
            dc.l    $3FFF0000,$94F4EFA8,$FEF70961,$3FBDBA2B
            dc.l    $3FFF0000,$96942D37,$20185A00,$3FBE91D5
            dc.l    $3FFF0000,$9837F051,$8DB8A96F,$3FBE8D5A
            dc.l    $3FFF0000,$99E04593,$20B7FA65,$BFBCDE7B
            dc.l    $3FFF0000,$9B8D39B9,$D54E5539,$BFBEBAAF
            dc.l    $3FFF0000,$9D3ED9A7,$2CFFB751,$BFBD86DA
            dc.l    $3FFF0000,$9EF53260,$91A111AE,$BFBEBEDD
            dc.l    $3FFF0000,$A0B0510F,$B9714FC2,$3FBCC96E
            dc.l    $3FFF0000,$A2704303,$0C496819,$BFBEC90B
            dc.l    $3FFF0000,$A43515AE,$09E6809E,$3FBBD1DB
            dc.l    $3FFF0000,$A5FED6A9,$B15138EA,$3FBCE5EB
            dc.l    $3FFF0000,$A7CD93B4,$E965356A,$BFBEC274
            dc.l    $3FFF0000,$A9A15AB4,$EA7C0EF8,$3FBEA83C
            dc.l    $3FFF0000,$AB7A39B5,$A93ED337,$3FBECB00
            dc.l    $3FFF0000,$AD583EEA,$42A14AC6,$3FBE9301
            dc.l    $3FFF0000,$AF3B78AD,$690A4375,$BFBD8367
            dc.l    $3FFF0000,$B123F581,$D2AC2590,$BFBEF05F
            dc.l    $3FFF0000,$B311C412,$A9112489,$3FBDFB3C
            dc.l    $3FFF0000,$B504F333,$F9DE6484,$3FBEB2FB
            dc.l    $3FFF0000,$B6FD91E3,$28D17791,$3FBAE2CB
            dc.l    $3FFF0000,$B8FBAF47,$62FB9EE9,$3FBCDC3C
            dc.l    $3FFF0000,$BAFF5AB2,$133E45FB,$3FBEE9AA
            dc.l    $3FFF0000,$BD08A39F,$580C36BF,$BFBEAEFD
            dc.l    $3FFF0000,$BF1799B6,$7A731083,$BFBCBF51
            dc.l    $3FFF0000,$C12C4CCA,$66709456,$3FBEF88A
            dc.l    $3FFF0000,$C346CCDA,$24976407,$3FBD83B2
            dc.l    $3FFF0000,$C5672A11,$5506DADD,$3FBDF8AB
            dc.l    $3FFF0000,$C78D74C8,$ABB9B15D,$BFBDFB17
            dc.l    $3FFF0000,$C9B9BD86,$6E2F27A3,$BFBEFE3C
            dc.l    $3FFF0000,$CBEC14FE,$F2727C5D,$BFBBB6F8
            dc.l    $3FFF0000,$CE248C15,$1F8480E4,$BFBCEE53
            dc.l    $3FFF0000,$D06333DA,$EF2B2595,$BFBDA4AE
            dc.l    $3FFF0000,$D2A81D91,$F12AE45A,$3FBC9124
            dc.l    $3FFF0000,$D4F35AAB,$CFEDFA1F,$3FBEB243
            dc.l    $3FFF0000,$D744FCCA,$D69D6AF4,$3FBDE69A
            dc.l    $3FFF0000,$D99D15C2,$78AFD7B6,$BFB8BC61
            dc.l    $3FFF0000,$DBFBB797,$DAF23755,$3FBDF610
            dc.l    $3FFF0000,$DE60F482,$5E0E9124,$BFBD8BE1
            dc.l    $3FFF0000,$E0CCDEEC,$2A94E111,$3FBACB12
            dc.l    $3FFF0000,$E33F8972,$BE8A5A51,$3FBB9BFE
            dc.l    $3FFF0000,$E5B906E7,$7C8348A8,$3FBCF2F4
            dc.l    $3FFF0000,$E8396A50,$3C4BDC68,$3FBEF22F
            dc.l    $3FFF0000,$EAC0C6E7,$DD24392F,$BFBDBF4A
            dc.l    $3FFF0000,$ED4F301E,$D9942B84,$3FBEC01A
            dc.l    $3FFF0000,$EFE4B99B,$DCDAF5CB,$3FBE8CAC
            dc.l    $3FFF0000,$F281773C,$59FFB13A,$BFBCBB3F
            dc.l    $3FFF0000,$F5257D15,$2486CC2C,$3FBEF73A
            dc.l    $3FFF0000,$F7D0DF73,$0AD13BB9,$BFB8B795
            dc.l    $3FFF0000,$FA83B2DB,$722A033A,$3FBEF84B
            dc.l    $3FFF0000,$FD3E0C0C,$F486C175,$BFBEF581
.L42:
            dc.l    $40000000,$C90FDAA2,$2168C235,$00000000
.L43:
            dc.l    $3FFF0000,$C90FDAA2,$2168C235,$00000000
.L44:
            dc.l    $BFF6687E,$314987D8
.L45:
            dc.l    $4002AC69,$34A26DB3
.L46:
            dc.l    $BFC2476F,$4E1DA28E
.L47:
            dc.l    $3FB34444,$7F876989
.L48:
            dc.l    $BFB744EE,$7FAF45DB
.L49:
            dc.l    $3FBC71C6,$46940220
.L50:
            dc.l    $BFC24924,$921872F9
.L51:
            dc.l    $3FC99999,$99998FA9
.L52:
            dc.l    $BFD55555,$55555555
.L53:
            dc.l    $BFB70BF3,$98539E6A
.L54:
            dc.l    $3FBC7187,$962D1D7D
.L55:
            dc.l    $BFC24924,$827107B8
.L56:
            dc.l    $3FC99999,$9996263E
.L57:
            dc.l    $BFD55555,$55555536
.L58:
            dc.l    $00010000,$80000000,$00000000,$00000000
.L59:
            dc.l    $3FFB0000,$83D152C5,$060B7A51,$00000000
            dc.l    $3FFB0000,$8BC85445,$65498B8B,$00000000
            dc.l    $3FFB0000,$93BE4060,$17626B0D,$00000000
            dc.l    $3FFB0000,$9BB3078D,$35AEC202,$00000000
            dc.l    $3FFB0000,$A3A69A52,$5DDCE7DE,$00000000
            dc.l    $3FFB0000,$AB98E943,$62765619,$00000000
            dc.l    $3FFB0000,$B389E502,$F9C59862,$00000000
            dc.l    $3FFB0000,$BB797E43,$6B09E6FB,$00000000
            dc.l    $3FFB0000,$C367A5C7,$39E5F446,$00000000
            dc.l    $3FFB0000,$CB544C61,$CFF7D5C6,$00000000
            dc.l    $3FFB0000,$D33F62F8,$2488533E,$00000000
            dc.l    $3FFB0000,$DB28DA81,$62404C77,$00000000
            dc.l    $3FFB0000,$E310A407,$8AD34F18,$00000000
            dc.l    $3FFB0000,$EAF6B0A8,$188EE1EB,$00000000
            dc.l    $3FFB0000,$F2DAF194,$9DBE79D5,$00000000
            dc.l    $3FFB0000,$FABD5813,$61D47E3E,$00000000
            dc.l    $3FFC0000,$8346AC21,$0959ECC4,$00000000
            dc.l    $3FFC0000,$8B232A08,$304282D8,$00000000
            dc.l    $3FFC0000,$92FB70B8,$D29AE2F9,$00000000
            dc.l    $3FFC0000,$9ACF476F,$5CCD1CB4,$00000000
            dc.l    $3FFC0000,$A29E7630,$4954F23F,$00000000
            dc.l    $3FFC0000,$AA68C5D0,$8AB85230,$00000000
            dc.l    $3FFC0000,$B22DFFFD,$9D539F83,$00000000
            dc.l    $3FFC0000,$B9EDEF45,$3E900EA5,$00000000
            dc.l    $3FFC0000,$C1A85F1C,$C75E3EA5,$00000000
            dc.l    $3FFC0000,$C95D1BE8,$28138DE6,$00000000
            dc.l    $3FFC0000,$D10BF300,$840D2DE4,$00000000
            dc.l    $3FFC0000,$D8B4B2BA,$6BC05E7A,$00000000
            dc.l    $3FFC0000,$E0572A6B,$B42335F6,$00000000
            dc.l    $3FFC0000,$E7F32A70,$EA9CAA8F,$00000000
            dc.l    $3FFC0000,$EF888432,$64ECEFAA,$00000000
            dc.l    $3FFC0000,$F7170A28,$ECC06666,$00000000
            dc.l    $3FFD0000,$812FD288,$332DAD32,$00000000
            dc.l    $3FFD0000,$88A8D1B1,$218E4D64,$00000000
            dc.l    $3FFD0000,$9012AB3F,$23E4AEE8,$00000000
            dc.l    $3FFD0000,$976CC3D4,$11E7F1B9,$00000000
            dc.l    $3FFD0000,$9EB68949,$3889A227,$00000000
            dc.l    $3FFD0000,$A5EF72C3,$4487361B,$00000000
            dc.l    $3FFD0000,$AD1700BA,$F07A7227,$00000000
            dc.l    $3FFD0000,$B42CBCFA,$FD37EFB7,$00000000
            dc.l    $3FFD0000,$BB303A94,$0BA80F89,$00000000
            dc.l    $3FFD0000,$C22115C6,$FCAEBBAF,$00000000
            dc.l    $3FFD0000,$C8FEF3E6,$86331221,$00000000
            dc.l    $3FFD0000,$CFC98330,$B4000C70,$00000000
            dc.l    $3FFD0000,$D6807AA1,$102C5BF9,$00000000
            dc.l    $3FFD0000,$DD2399BC,$31252AA3,$00000000
            dc.l    $3FFD0000,$E3B2A855,$6B8FC517,$00000000
            dc.l    $3FFD0000,$EA2D764F,$64315989,$00000000
            dc.l    $3FFD0000,$F3BF5BF8,$BAD1A21D,$00000000
            dc.l    $3FFE0000,$801CE39E,$0D205C9A,$00000000
            dc.l    $3FFE0000,$8630A2DA,$DA1ED066,$00000000
            dc.l    $3FFE0000,$8C1AD445,$F3E09B8C,$00000000
            dc.l    $3FFE0000,$91DB8F16,$64F350E2,$00000000
            dc.l    $3FFE0000,$97731420,$365E538C,$00000000
            dc.l    $3FFE0000,$9CE1C8E6,$A0B8CDBA,$00000000
            dc.l    $3FFE0000,$A22832DB,$CADAAE09,$00000000
            dc.l    $3FFE0000,$A746F2DD,$B7602294,$00000000
            dc.l    $3FFE0000,$AC3EC0FB,$997DD6A2,$00000000
            dc.l    $3FFE0000,$B110688A,$EBDC6F6A,$00000000
            dc.l    $3FFE0000,$B5BCC490,$59ECC4B0,$00000000
            dc.l    $3FFE0000,$BA44BC7D,$D470782F,$00000000
            dc.l    $3FFE0000,$BEA94144,$FD049AAC,$00000000
            dc.l    $3FFE0000,$C2EB4ABB,$661628B6,$00000000
            dc.l    $3FFE0000,$C70BD54C,$E602EE14,$00000000
            dc.l    $3FFE0000,$CD000549,$ADEC7159,$00000000
            dc.l    $3FFE0000,$D48457D2,$D8EA4EA3,$00000000
            dc.l    $3FFE0000,$DB948DA7,$12DECE3B,$00000000
            dc.l    $3FFE0000,$E23855F9,$69E8096A,$00000000
            dc.l    $3FFE0000,$E8771129,$C4353259,$00000000
            dc.l    $3FFE0000,$EE57C16E,$0D379C0D,$00000000
            dc.l    $3FFE0000,$F3E10211,$A87C3779,$00000000
            dc.l    $3FFE0000,$F919039D,$758B8D41,$00000000
            dc.l    $3FFE0000,$FE058B8F,$64935FB3,$00000000
            dc.l    $3FFF0000,$8155FB49,$7B685D04,$00000000
            dc.l    $3FFF0000,$83889E35,$49D108E1,$00000000
            dc.l    $3FFF0000,$859CFA76,$511D724B,$00000000
            dc.l    $3FFF0000,$87952ECF,$FF8131E7,$00000000
            dc.l    $3FFF0000,$89732FD1,$9557641B,$00000000
            dc.l    $3FFF0000,$8B38CAD1,$01932A35,$00000000
            dc.l    $3FFF0000,$8CE7A8D8,$301EE6B5,$00000000
            dc.l    $3FFF0000,$8F46A39E,$2EAE5281,$00000000
            dc.l    $3FFF0000,$922DA7D7,$91888487,$00000000
            dc.l    $3FFF0000,$94D19FCB,$DEDF5241,$00000000
            dc.l    $3FFF0000,$973AB944,$19D2A08B,$00000000
            dc.l    $3FFF0000,$996FF00E,$08E10B96,$00000000
            dc.l    $3FFF0000,$9B773F95,$12321DA7,$00000000
            dc.l    $3FFF0000,$9D55CC32,$0F935624,$00000000
            dc.l    $3FFF0000,$9F100575,$006CC571,$00000000
            dc.l    $3FFF0000,$A0A9C290,$D97CC06C,$00000000
            dc.l    $3FFF0000,$A22659EB,$EBC0630A,$00000000
            dc.l    $3FFF0000,$A388B4AF,$F6EF0EC9,$00000000
            dc.l    $3FFF0000,$A4D35F10,$61D292C4,$00000000
            dc.l    $3FFF0000,$A60895DC,$FBE3187E,$00000000
            dc.l    $3FFF0000,$A72A51DC,$7367BEAC,$00000000
            dc.l    $3FFF0000,$A83A5153,$0956168F,$00000000
            dc.l    $3FFF0000,$A93A2007,$7539546E,$00000000
            dc.l    $3FFF0000,$AA9E7245,$023B2605,$00000000
            dc.l    $3FFF0000,$AC4C84BA,$6FE4D58F,$00000000
            dc.l    $3FFF0000,$ADCE4A4A,$606B9712,$00000000
            dc.l    $3FFF0000,$AF2A2DCD,$8D263C9C,$00000000
            dc.l    $3FFF0000,$B0656F81,$F22265C7,$00000000
            dc.l    $3FFF0000,$B1846515,$0F71496A,$00000000
            dc.l    $3FFF0000,$B28AAA15,$6F9ADA35,$00000000
            dc.l    $3FFF0000,$B37B44FF,$3766B895,$00000000
            dc.l    $3FFF0000,$B458C3DC,$E9630433,$00000000
            dc.l    $3FFF0000,$B525529D,$562246BD,$00000000
            dc.l    $3FFF0000,$B5E2CCA9,$5F9D88CC,$00000000
            dc.l    $3FFF0000,$B692CADA,$7ACA1ADA,$00000000
            dc.l    $3FFF0000,$B736AEA7,$A6925838,$00000000
            dc.l    $3FFF0000,$B7CFAB28,$7E9F7B36,$00000000
            dc.l    $3FFF0000,$B85ECC66,$CB219835,$00000000
            dc.l    $3FFF0000,$B8E4FD5A,$20A593DA,$00000000
            dc.l    $3FFF0000,$B99F41F6,$4AFF9BB5,$00000000
            dc.l    $3FFF0000,$BA7F1E17,$842BBE7B,$00000000
            dc.l    $3FFF0000,$BB471285,$7637E17D,$00000000
            dc.l    $3FFF0000,$BBFABE8A,$4788DF6F,$00000000
            dc.l    $3FFF0000,$BC9D0FAD,$2B689D79,$00000000
            dc.l    $3FFF0000,$BD306A39,$471ECD86,$00000000
            dc.l    $3FFF0000,$BDB6C731,$856AF18A,$00000000
            dc.l    $3FFF0000,$BE31CAC5,$02E80D70,$00000000
            dc.l    $3FFF0000,$BEA2D55C,$E33194E2,$00000000
            dc.l    $3FFF0000,$BF0B10B7,$C03128F0,$00000000
            dc.l    $3FFF0000,$BF6B7A18,$DACB778D,$00000000
            dc.l    $3FFF0000,$BFC4EA46,$63FA18F6,$00000000
            dc.l    $3FFF0000,$C0181BDE,$8B89A454,$00000000
            dc.l    $3FFF0000,$C065B066,$CFBF6439,$00000000
            dc.l    $3FFF0000,$C0AE345F,$56340AE6,$00000000
            dc.l    $3FFF0000,$C0F22291,$9CB9E6A7,$00000000
.L60:
            dc.l    $3FFD0000,$DE5BD8A9,$37287195  ; log10(e)
            dc.l    $00000000                      ; 0.0
.L61:
            dc.l    $3FFF0000,$B8AA3B29,$5C17F0BC,$00000000
            dc.l    $3FFEF07D,$3FFF8841
            dc.l    $3FFE8000,$3FFFC000
            dc.l    $3FFE0000,$B17217F7,$D1CF79AC,$00000000
.L62:
            dc.w    $3F80
            dc.b    $00
            dc.b    $00
.L63:
            dc.l    $00000000
            dc.l    $7F800000
.L64:
            dc.l    $BF800000
            dc.l    $3FC2499A,$B5E4040B
            dc.l    $BFC555B5,$848CB7DB
            dc.l    $3FC99999,$987D8730
            dc.l    $BFCFFFFF,$FF6F7E97
            dc.l    $3FD55555,$555555A4
            dc.l    $BFE00000,$00000008
            dc.l    $3F175496,$ADD7DAD6
            dc.l    $3F3C71C2,$FE80C7E0
            dc.l    $3F624924,$928BCCFF
            dc.l    $3F899999,$999995EC
            dc.l    $3FB55555,$55555555
            dc.l    $40000000,$00000000
.L65:
            dc.l    $3F990000,$80000000,$00000000,$00000000
            dc.l    $3FFE0000,$FE03F80F,$E03F80FE,$00000000
            dc.l    $3FF70000,$FF015358,$833C47E2,$00000000
            dc.l    $3FFE0000,$FA232CF2,$52138AC0,$00000000
            dc.l    $3FF90000,$BDC8D83E,$AD88D549,$00000000
            dc.l    $3FFE0000,$F6603D98,$0F6603DA,$00000000
            dc.l    $3FFA0000,$9CF43DCF,$F5EAFD48,$00000000
            dc.l    $3FFE0000,$F2B9D648,$0F2B9D65,$00000000
            dc.l    $3FFA0000,$DA16EB88,$CB8DF614,$00000000
            dc.l    $3FFE0000,$EF2EB71F,$C4345238,$00000000
            dc.l    $3FFB0000,$8B29B775,$1BD70743,$00000000
            dc.l    $3FFE0000,$EBBDB2A5,$C1619C8C,$00000000
            dc.l    $3FFB0000,$A8D839F8,$30C1FB49,$00000000
            dc.l    $3FFE0000,$E865AC7B,$7603A197,$00000000
            dc.l    $3FFB0000,$C61A2EB1,$8CD907AD,$00000000
            dc.l    $3FFE0000,$E525982A,$F70C880E,$00000000
            dc.l    $3FFB0000,$E2F2A47A,$DE3A18AF,$00000000
            dc.l    $3FFE0000,$E1FC780E,$1FC780E2,$00000000
            dc.l    $3FFB0000,$FF64898E,$DF55D551,$00000000
            dc.l    $3FFE0000,$DEE95C4C,$A037BA57,$00000000
            dc.l    $3FFC0000,$8DB956A9,$7B3D0148,$00000000
            dc.l    $3FFE0000,$DBEB61EE,$D19C5958,$00000000
            dc.l    $3FFC0000,$9B8FE100,$F47BA1DE,$00000000
            dc.l    $3FFE0000,$D901B203,$6406C80E,$00000000
            dc.l    $3FFC0000,$A9372F1D,$0DA1BD17,$00000000
            dc.l    $3FFE0000,$D62B80D6,$2B80D62C,$00000000
            dc.l    $3FFC0000,$B6B07F38,$CE90E46B,$00000000
            dc.l    $3FFE0000,$D3680D36,$80D3680D,$00000000
            dc.l    $3FFC0000,$C3FD0329,$06488481,$00000000
            dc.l    $3FFE0000,$D0B69FCB,$D2580D0B,$00000000
            dc.l    $3FFC0000,$D11DE0FF,$15AB18CA,$00000000
            dc.l    $3FFE0000,$CE168A77,$25080CE1,$00000000
            dc.l    $3FFC0000,$DE1433A1,$6C66B150,$00000000
            dc.l    $3FFE0000,$CB8727C0,$65C393E0,$00000000
            dc.l    $3FFC0000,$EAE10B5A,$7DDC8ADD,$00000000
            dc.l    $3FFE0000,$C907DA4E,$871146AD,$00000000
            dc.l    $3FFC0000,$F7856E5E,$E2C9B291,$00000000
            dc.l    $3FFE0000,$C6980C69,$80C6980C,$00000000
            dc.l    $3FFD0000,$82012CA5,$A68206D7,$00000000
            dc.l    $3FFE0000,$C4372F85,$5D824CA6,$00000000
            dc.l    $3FFD0000,$882C5FCD,$7256A8C5,$00000000
            dc.l    $3FFE0000,$C1E4BBD5,$95F6E947,$00000000
            dc.l    $3FFD0000,$8E44C60B,$4CCFD7DE,$00000000
            dc.l    $3FFE0000,$BFA02FE8,$0BFA02FF,$00000000
            dc.l    $3FFD0000,$944AD09E,$F4351AF6,$00000000
            dc.l    $3FFE0000,$BD691047,$07661AA3,$00000000
            dc.l    $3FFD0000,$9A3EECD4,$C3EAA6B2,$00000000
            dc.l    $3FFE0000,$BB3EE721,$A54D880C,$00000000
            dc.l    $3FFD0000,$A0218434,$353F1DE8,$00000000
            dc.l    $3FFE0000,$B92143FA,$36F5E02E,$00000000
            dc.l    $3FFD0000,$A5F2FCAB,$BBC506DA,$00000000
            dc.l    $3FFE0000,$B70FBB5A,$19BE3659,$00000000
            dc.l    $3FFD0000,$ABB3B8BA,$2AD362A5,$00000000
            dc.l    $3FFE0000,$B509E68A,$9B94821F,$00000000
            dc.l    $3FFD0000,$B1641795,$CE3CA97B,$00000000
            dc.l    $3FFE0000,$B30F6352,$8917C80B,$00000000
            dc.l    $3FFD0000,$B7047551,$5D0F1C61,$00000000
            dc.l    $3FFE0000,$B11FD3B8,$0B11FD3C,$00000000
            dc.l    $3FFD0000,$BC952AFE,$EA3D13E1,$00000000
            dc.l    $3FFE0000,$AF3ADDC6,$80AF3ADE,$00000000
            dc.l    $3FFD0000,$C2168ED0,$F458BA4A,$00000000
            dc.l    $3FFE0000,$AD602B58,$0AD602B6,$00000000
            dc.l    $3FFD0000,$C788F439,$B3163BF1,$00000000
            dc.l    $3FFE0000,$AB8F69E2,$8359CD11,$00000000
            dc.l    $3FFD0000,$CCECAC08,$BF04565D,$00000000
            dc.l    $3FFE0000,$A9C84A47,$A07F5638,$00000000
            dc.l    $3FFD0000,$D2420487,$2DD85160,$00000000
            dc.l    $3FFE0000,$A80A80A8,$0A80A80B,$00000000
            dc.l    $3FFD0000,$D7894992,$3BC3588A,$00000000
            dc.l    $3FFE0000,$A655C439,$2D7B73A8,$00000000
            dc.l    $3FFD0000,$DCC2C4B4,$9887DACC,$00000000
            dc.l    $3FFE0000,$A4A9CF1D,$96833751,$00000000
            dc.l    $3FFD0000,$E1EEBD3E,$6D6A6B9E,$00000000
            dc.l    $3FFE0000,$A3065E3F,$AE7CD0E0,$00000000
            dc.l    $3FFD0000,$E70D785C,$2F9F5BDC,$00000000
            dc.l    $3FFE0000,$A16B312E,$A8FC377D,$00000000
            dc.l    $3FFD0000,$EC1F392C,$5179F283,$00000000
            dc.l    $3FFE0000,$9FD809FD,$809FD80A,$00000000
            dc.l    $3FFD0000,$F12440D3,$E36130E6,$00000000
            dc.l    $3FFE0000,$9E4CAD23,$DD5F3A20,$00000000
            dc.l    $3FFD0000,$F61CCE92,$346600BB,$00000000
            dc.l    $3FFE0000,$9CC8E160,$C3FB19B9,$00000000
            dc.l    $3FFD0000,$FB091FD3,$8145630A,$00000000
            dc.l    $3FFE0000,$9B4C6F9E,$F03A3CAA,$00000000
            dc.l    $3FFD0000,$FFE97042,$BFA4C2AD,$00000000
            dc.l    $3FFE0000,$99D722DA,$BDE58F06,$00000000
            dc.l    $3FFE0000,$825EFCED,$49369330,$00000000
            dc.l    $3FFE0000,$9868C809,$868C8098,$00000000
            dc.l    $3FFE0000,$84C37A7A,$B9A905C9,$00000000
            dc.l    $3FFE0000,$97012E02,$5C04B809,$00000000
            dc.l    $3FFE0000,$87224C2E,$8E645FB7,$00000000
            dc.l    $3FFE0000,$95A02568,$095A0257,$00000000
            dc.l    $3FFE0000,$897B8CAC,$9F7DE298,$00000000
            dc.l    $3FFE0000,$94458094,$45809446,$00000000
            dc.l    $3FFE0000,$8BCF55DE,$C4CD05FE,$00000000
            dc.l    $3FFE0000,$92F11384,$0497889C,$00000000
            dc.l    $3FFE0000,$8E1DC0FB,$89E125E5,$00000000
            dc.l    $3FFE0000,$91A2B3C4,$D5E6F809,$00000000
            dc.l    $3FFE0000,$9066E68C,$955B6C9B,$00000000
            dc.l    $3FFE0000,$905A3863,$3E06C43B,$00000000
            dc.l    $3FFE0000,$92AADE74,$C7BE59E0,$00000000
            dc.l    $3FFE0000,$8F1779D9,$FDC3A219,$00000000
            dc.l    $3FFE0000,$94E9BFF6,$15845643,$00000000
            dc.l    $3FFE0000,$8DDA5202,$37694809,$00000000
            dc.l    $3FFE0000,$9723A1B7,$20134203,$00000000
            dc.l    $3FFE0000,$8CA29C04,$6514E023,$00000000
            dc.l    $3FFE0000,$995899C8,$90EB8990,$00000000
            dc.l    $3FFE0000,$8B70344A,$139BC75A,$00000000
            dc.l    $3FFE0000,$9B88BDAA,$3A3DAE2F,$00000000
            dc.l    $3FFE0000,$8A42F870,$5669DB46,$00000000
            dc.l    $3FFE0000,$9DB4224F,$FFE1157C,$00000000
            dc.l    $3FFE0000,$891AC73A,$E9819B50,$00000000
            dc.l    $3FFE0000,$9FDADC26,$8B7A12DA,$00000000
            dc.l    $3FFE0000,$87F78087,$F78087F8,$00000000
            dc.l    $3FFE0000,$A1FCFF17,$CE733BD4,$00000000
            dc.l    $3FFE0000,$86D90544,$7A34ACC6,$00000000
            dc.l    $3FFE0000,$A41A9E8F,$5446FB9F,$00000000
            dc.l    $3FFE0000,$85BF3761,$2CEE3C9B,$00000000
            dc.l    $3FFE0000,$A633CD7E,$6771CD8B,$00000000
            dc.l    $3FFE0000,$84A9F9C8,$084A9F9D,$00000000
            dc.l    $3FFE0000,$A8489E60,$0B435A5E,$00000000
            dc.l    $3FFE0000,$83993052,$3FBE3368,$00000000
            dc.l    $3FFE0000,$AA59233C,$CCA4BD49,$00000000
            dc.l    $3FFE0000,$828CBFBE,$B9A020A3,$00000000
            dc.l    $3FFE0000,$AC656DAE,$6BCC4985,$00000000
            dc.l    $3FFE0000,$81848DA8,$FAF0D277,$00000000
            dc.l    $3FFE0000,$AE6D8EE3,$60BB2468,$00000000
            dc.l    $3FFE0000,$80808080,$80808081,$00000000
            dc.l    $3FFE0000,$B07197A2,$3C46C654,$00000000

            EVEN
