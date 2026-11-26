            include "Include/ROMHeader.s"

            EXPORT  INITWINDOWSRGNPATCH,InstallFPSP,INSTALLPRIVTRAP,WINDOWMGRPATCH

            IMPORT  INITWINDOWSCRTRETURN,INITWINDOWSLCDRETURN,INITWINDOWSRGNRETURN

            SECTION "Part7",CODE

WINDOWMGRPATCH:
INITWINDOWSFRAMEPATCH:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            bra.l   INITWINDOWSLCDRETURN
.L1:
            move.l  A4,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            bra.l   INITWINDOWSCRTRETURN
INITWINDOWSRGNPATCH:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            move.l  A4,-(SP)
            _FrameRect
            bra.l   INITWINDOWSRGNRETURN
.L1:
            move.l  A4,-(SP)
            move.l  #$100010,-(SP)
            _FrameRoundRect
            bra.l   INITWINDOWSRGNRETURN
            ds.b    444
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
            dc.w    $8040,$2010,$0804,$0201
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
            dc.w    $3F81,$407E,$3F6A,0
.L3:
            dc.w    $3C01,$43FE,$3BCD,0
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
            dc.w    $007A,$02B0,$0296,$0020,$010C,$02DE,$018A,$0020
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
            dc.w    $009C,$00A2,$00A8,$00AC,$00B0,$00B4,$00B8,$00BC
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
            dc.w    $0012,$FF92,$FFF6,$FFF6
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
            dc.w    $3FFD,0,$9A20,$9A84,$FBCF,$F798
            ds.b    4
.L16:
            dc.w    $3FFD,0,$9A20,$9A84,$FBCF,$F799
            ds.b    4
.L17:
            ds.b    4
            dc.w    $0303,$0202,$0302,$0203,$0203,$0302
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
            dc.w    $7FFF
            ds.b    14
.L5:
            dc.w    $7FFE,0,$FFFF,$FFFF,$FFFF,$FFFF
            ds.b    4
.L8:
            dc.b    $40,$7E,$00,$00,$FF,$FF,$FF
            ds.b    9
.L6:
            dc.b    $43,$FE,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$F8
            ds.b    5
.L7:
            dc.w    $00C6,$00D4,$00DC,$00FA,$016A,$0176,$017C,$0196
            dc.w    $011C,$012A,$0132,$014C,$01D0,$01D0,$01D0,$01D0
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
            ds.b    16
.L9:
            dc.w    $3F81
            ds.b    14
.L5:
            dc.w    $3C01
            ds.b    14
.L6:
            ds.b    11
            dc.b    $01
            ds.b    4
.L10:
            dc.w    $3F81
            ds.b    4
            dc.b    $01
            ds.b    9
.L7:
            dc.w    $3C01
            ds.b    8
            dc.b    $08
            ds.b    5
.L8:
            dc.w    $0034,$0042,$0050,$0072,$00E6,$00F2,$00FE,$011C
            dc.w    $0090,$009E,$00AC,$00CC,$0090,$009E,$00AC,$00CC
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
            dc.w    $003A,$0042,$004A,$0050,$0056,$005C,$0062,$0068
            dc.w    $006E,$0076,$007E,$0084,$008A,$0090,$0096,$009C
            dc.w    $00A2,$00AA,$00B2,$00B8,$00BE,$00C4,$00CA,$00D0
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
            dc.w    $FFFF
            ds.b    10
.L2:
            dc.w    $7FFF
            ds.b    10
.L3:
            dc.w    $7FFF,0,$FFFF,$FFFF,$FFFF,$FFFF
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
            dc.b    $3F,$FF,$00,$00,$80
            ds.b    7
.L7:
            dc.w    $8000,0
.L8:
            dc.w    $BFFF,0,$C90F,$DAA2,$2168,$C235
            ds.b    4
            dc.w    $7FFF,0,$FFFF,$FFFF,$FFFF,$FFFF
            ds.b    4
.L9:
            dc.w    $092E,$092E,$092E,$092E,$092E,$092E,$092E,$092E
            dc.w    $080C,$03EE,$03FA,$FE40,$0818,$03D2,$03D2,$03D2
            dc.w    $1020,$03EE,$03FA,$FE40,$101C,$03D2,$03D2,$03D2
            dc.w    $0856,$03EE,$03FA,$FE40,$03D8,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $0436,$03EE,$042A,$FE40,$25C2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $1B54,$03EE,$0454,$FE40,$1B50,$03D2,$03D2,$03D2
            dc.w    $10E2,$03EE,$0406,$FE40,$10DE,$03D2,$03D2,$03D2
            dc.w    $21BE,$03EE,$0412,$FE40,$21BA,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $213A,$03EE,$FC56,$FE40,$2136,$03D2,$03D2,$03D2
            dc.w    $0F08,$03EE,$FC56,$FE40,$0F04,$03D2,$03D2,$03D2
            dc.w    $1234,$03EE,$FC56,$FE40,$121C,$03D2,$03D2,$03D2
            dc.w    $16C8,$03EE,$FC56,$FE40,$16C4,$03D2,$03D2,$03D2
            dc.w    $19A6,$0748,$041E,$FE40,$1982,$03D2,$03D2,$03D2
            dc.w    $1E0C,$0748,$041E,$FE40,$1DF0,$03D2,$03D2,$03D2
            dc.w    $1F70,$0748,$041E,$FE40,$1F54,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $0460,$FBEC,$042A,$FE40,$048C,$03D2,$03D2,$03D2
            dc.w    $0498,$FBEC,$042A,$FE40,$04C4,$03D2,$03D2,$03D2
            dc.w    $04D0,$FBEC,$042A,$FE40,$04FC,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $0F8C,$0748,$0724,$FE40,$0F74,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $20A4,$0708,$FC56,$FE40,$2096,$03D2,$03D2,$03D2
            dc.w    $123A,$0748,$FC56,$FE40,$1220,$03D2,$03D2,$03D2
            dc.w    $0780,$03EE,$FC56,$FE40,$0790,$03D2,$03D2,$03D2
            dc.w    $07A4,$03EE,$FC56,$FE40,$07C4,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $0528,$0528,$0528,$0528,$0528,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $05CA,$05CA,$05CA,$05CA,$05CA,$03D2,$03D2,$03D2
            dc.w    $066C,$066C,$066C,$066C,$066C,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
            dc.w    $13F0,$06B4,$06D4,$06E2,$13E0,$03D2,$03D2,$03D2
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
            dc.w    $4000,0,$C90F,$DAA2,$2168,$C235
.L2:
            dc.w    $4000,0,$C90F,$DAA2,$2168,$C234
.L3:
            dc.w    $4000,0,$C90F,$DAA2,$2168,$C235
.L4:
            dc.w    $3FFD,0,$9A20,$9A84,$FBCF,$F798,$4000,0
            dc.w    $ADF8,$5458,$A2BB,$4A9A,$3FFF,0,$B8AA,$3B29
            dc.w    $5C17,$F0BC,$3FFD,0,$DE5B,$D8A9,$3728,$7195
            ds.b    12
.L5:
            dc.w    $3FFD,0,$9A20,$9A84,$FBCF,$F798,$4000,0
            dc.w    $ADF8,$5458,$A2BB,$4A9A,$3FFF,0,$B8AA,$3B29
            dc.w    $5C17,$F0BB,$3FFD,0,$DE5B,$D8A9,$3728,$7195
            ds.b    12
.L6:
            dc.w    $3FFD,0,$9A20,$9A84,$FBCF,$F799,$4000,0
            dc.w    $ADF8,$5458,$A2BB,$4A9B,$3FFF,0,$B8AA,$3B29
            dc.w    $5C17,$F0BC,$3FFD,0,$DE5B,$D8A9,$3728,$7195
            ds.b    12
.L7:
            dc.w    $3FFE,0,$B172,$17F7,$D1CF,$79AC,$4000,0
            dc.b    $93,$5D,$8D,$DD,$AA,$A8,$AC,$17,$3F,$FF,$00,$00,$80
            ds.b    7
.L8:
            dc.b    $40,$02,$00,$00,$A0
            ds.b    7
            dc.b    $40,$05,$00,$00,$C8
            ds.b    7
            dc.w    $400C,0,$9C40
            ds.b    6
            dc.b    $40,$19,$00,$00,$BE,$BC,$20
            ds.b    5
            dc.w    $4034,0,$8E1B,$C9BF,$0400,0,$4069,0
            dc.w    $9DC5,$ADA8,$2B70,$B59E,$40D3,0,$C278,$1F49
            dc.w    $FFCF,$A6D5,$41A8,0,$93BA,$47C9,$80E9,$8CE0
            dc.w    $4351,0,$AA7E,$EBFB,$9DF9,$DE8E,$46A3,0
            dc.w    $E319,$A0AE,$A60E,$91C7,$4D48,0,$C976,$7586
            dc.w    $8175,$0C17,$5A92,0,$9E8B,$3B5D,$C53D,$5DE5
            dc.w    $7525,0,$C460,$5202,$8A20,$979B
.L9:
            dc.w    $3FFE,0,$B172,$17F7,$D1CF,$79AB,$4000,0
            dc.b    $93,$5D,$8D,$DD,$AA,$A8,$AC,$16,$3F,$FF,$00,$00,$80
            ds.b    7
.L10:
            dc.b    $40,$02,$00,$00,$A0
            ds.b    7
            dc.b    $40,$05,$00,$00,$C8
            ds.b    7
            dc.w    $400C,0,$9C40
            ds.b    6
            dc.b    $40,$19,$00,$00,$BE,$BC,$20
            ds.b    5
            dc.w    $4034,0,$8E1B,$C9BF,$0400,0,$4069,0
            dc.w    $9DC5,$ADA8,$2B70,$B59D,$40D3,0,$C278,$1F49
            dc.w    $FFCF,$A6D5,$41A8,0,$93BA,$47C9,$80E9,$8CDF
            dc.w    $4351,0,$AA7E,$EBFB,$9DF9,$DE8D,$46A3,0
            dc.w    $E319,$A0AE,$A60E,$91C6,$4D48,0,$C976,$7586
            dc.w    $8175,$0C17,$5A92,0,$9E8B,$3B5D,$C53D,$5DE5
            dc.w    $7525,0,$C460,$5202,$8A20,$979A
.L11:
            dc.w    $3FFE,0,$B172,$17F7,$D1CF,$79AC,$4000,0
            dc.b    $93,$5D,$8D,$DD,$AA,$A8,$AC,$17,$3F,$FF,$00,$00,$80
            ds.b    7
.L12:
            dc.b    $40,$02,$00,$00,$A0
            ds.b    7
            dc.b    $40,$05,$00,$00,$C8
            ds.b    7
            dc.w    $400C,0,$9C40
            ds.b    6
            dc.b    $40,$19,$00,$00,$BE,$BC,$20
            ds.b    5
            dc.w    $4034,0,$8E1B,$C9BF,$0400,0,$4069,0
            dc.w    $9DC5,$ADA8,$2B70,$B59E,$40D3,0,$C278,$1F49
            dc.w    $FFCF,$A6D6,$41A8,0,$93BA,$47C9,$80E9,$8CE0
            dc.w    $4351,0,$AA7E,$EBFB,$9DF9,$DE8E,$46A3,0
            dc.w    $E319,$A0AE,$A60E,$91C7,$4D48,0,$C976,$7586
            dc.w    $8175,$0C18,$5A92,0,$9E8B,$3B5D,$C53D,$5DE6
            dc.w    $7525,0,$C460,$5202,$8A20,$979B
            ds.b    8
.L13:
            dc.w    $40C6,$2D38,$D3D6,$4634
.L14:
            dc.b    $3D,$6F,$90,$AE,$B1,$E7,$5C,$C7,$7F,$FB,$00,$00,$80
            ds.b    11
            dc.w    $BD6A,$AA77,$CCC9,$94F5,$3DE6,$1209,$7AAE,$8DA1
            dc.w    $BE5A,$E645,$2A11,$8AE4,$3EC7,$1DE3,$A534,$1531
            dc.w    $BF2A,$01A0,$1A01,$8B59
            ds.b    8
            dc.w    $3FF8,0,$8888,$8888,$8888,$59AF
            ds.b    4
            dc.w    $BFFC,0,$AAAA,$AAAA,$AAAA,$AA99
            ds.b    4
            dc.w    $3D2A,$C4D0,$D601,$1EE3,$BDA9,$396F,$9F45,$AC19
            dc.w    $3E21,$EED9,$0612,$C972,$BE92,$7E4F,$B79D,$9FCF
            dc.w    $3EFA,$01A0,$1A01,$D423,$3FE4,$5F30,$6DC9,$C883
            dc.w    $BFF5,0,$B60B,$60B6,$0B61,$D438
            ds.b    4
            dc.w    $3FFA,0,$AAAA,$AAAA,$AAAA,$AB5E,$BF00,0
            dc.w    $3EA0,$B759,$F50F,$8688,$BEF2,$BAA5,$A892,$4F04
            dc.w    $BF34,$6F59,$B39B,$A65F
            ds.b    8
            dc.b    $3F,$F6,$00,$00,$E0,$73,$D3,$FC,$19,$9C,$4A
            ds.b    5
            dc.w    $3FF9,0,$D23C,$D684,$15D9,$5FA1
            ds.b    4
            dc.w    $BFFC,0,$8895,$A6C5,$FB42,$3BCA
            ds.b    4
            dc.w    $BFFD,0,$EEF5,$7E0D,$A84B,$C8CE
            ds.b    4
            dc.w    $C004,0,$C90F,$DAA2,$2168,$C235,$2180,0
            dc.w    $C004,0,$C2C7,$5BCD,$105D,$7C23,$A0D0,0
            dc.w    $C004,0,$BC7E,$DCF7,$FF52,$3611,$A1E8,0
            dc.w    $C004,0,$B636,$5E22,$EE46,$F000,$2148,0
            dc.w    $C004,0,$AFED,$DF4D,$DD3B,$A9EE,$A120,0
            dc.w    $C004,0,$A9A5,$6078,$CC30,$63DD,$21FC,0
            dc.w    $C004,0,$A35C,$E1A3,$BB25,$1DCB,$2110,0
            dc.w    $C004,0,$9D14,$62CE,$AA19,$D7B9,$A158,0
            dc.w    $C004,0,$96CB,$E3F9,$990E,$91A8,$21E0,0
            dc.w    $C004,0,$9083,$6524,$8803,$4B96,$20B0,0
            dc.w    $C004,0,$8A3A,$E64F,$76F8,$0584,$A188,0
            dc.w    $C004,0,$83F2,$677A,$65EC,$BF73,$21C4,0
            dc.w    $C003,0,$FB53,$D14A,$A9C2,$F2C2,$2000,0
            dc.w    $C003,0,$EEC2,$D3A0,$87AC,$669F,$2138,0
            dc.w    $C003,0,$E231,$D5F6,$6595,$DA7B,$A130,0
            dc.w    $C003,0,$D5A0,$D84C,$437F,$4E58,$9FC0,0
            dc.w    $C003,0,$C90F,$DAA2,$2168,$C235,$2100,0
            dc.w    $C003,0,$BC7E,$DCF7,$FF52,$3611,$A168,0
            dc.w    $C003,0,$AFED,$DF4D,$DD3B,$A9EE,$A0A0,0
            dc.w    $C003,0,$A35C,$E1A3,$BB25,$1DCB,$2090,0
            dc.w    $C003,0,$96CB,$E3F9,$990E,$91A8,$2160,0
            dc.w    $C003,0,$8A3A,$E64F,$76F8,$0584,$A108,0
            dc.w    $C002,0,$FB53,$D14A,$A9C2,$F2C2,$1F80,0
            dc.w    $C002,0,$E231,$D5F6,$6595,$DA7B,$A0B0,0
            dc.w    $C002,0,$C90F,$DAA2,$2168,$C235,$2080,0
            dc.w    $C002,0,$AFED,$DF4D,$DD3B,$A9EE,$A020,0
            dc.w    $C002,0,$96CB,$E3F9,$990E,$91A8,$20E0,0
            dc.w    $C001,0,$FB53,$D14A,$A9C2,$F2C2,$1F00,0
            dc.w    $C001,0,$C90F,$DAA2,$2168,$C235,$2000,0
            dc.w    $C001,0,$96CB,$E3F9,$990E,$91A8,$2060,0
            dc.w    $C000,0,$C90F,$DAA2,$2168,$C235,$1F80,0
            dc.b    $BF,$FF,$00,$00,$C9,$0F,$DA,$A2,$21,$68,$C2,$35,$1F
            ds.b    19
            dc.w    $3FFF,0,$C90F,$DAA2,$2168,$C235,$9F00,0
            dc.w    $4000,0,$C90F,$DAA2,$2168,$C235,$9F80,0
            dc.w    $4001,0,$96CB,$E3F9,$990E,$91A8,$A060,0
            dc.w    $4001,0,$C90F,$DAA2,$2168,$C235,$A000,0
            dc.w    $4001,0,$FB53,$D14A,$A9C2,$F2C2,$9F00,0
            dc.w    $4002,0,$96CB,$E3F9,$990E,$91A8,$A0E0,0
            dc.w    $4002,0,$AFED,$DF4D,$DD3B,$A9EE,$2020,0
            dc.w    $4002,0,$C90F,$DAA2,$2168,$C235,$A080,0
            dc.w    $4002,0,$E231,$D5F6,$6595,$DA7B,$20B0,0
            dc.w    $4002,0,$FB53,$D14A,$A9C2,$F2C2,$9F80,0
            dc.w    $4003,0,$8A3A,$E64F,$76F8,$0584,$2108,0
            dc.w    $4003,0,$96CB,$E3F9,$990E,$91A8,$A160,0
            dc.w    $4003,0,$A35C,$E1A3,$BB25,$1DCB,$A090,0
            dc.w    $4003,0,$AFED,$DF4D,$DD3B,$A9EE,$20A0,0
            dc.w    $4003,0,$BC7E,$DCF7,$FF52,$3611,$2168,0
            dc.w    $4003,0,$C90F,$DAA2,$2168,$C235,$A100,0
            dc.w    $4003,0,$D5A0,$D84C,$437F,$4E58,$1FC0,0
            dc.w    $4003,0,$E231,$D5F6,$6595,$DA7B,$2130,0
            dc.w    $4003,0,$EEC2,$D3A0,$87AC,$669F,$A138,0
            dc.w    $4003,0,$FB53,$D14A,$A9C2,$F2C2,$A000,0
            dc.w    $4004,0,$83F2,$677A,$65EC,$BF73,$A1C4,0
            dc.w    $4004,0,$8A3A,$E64F,$76F8,$0584,$2188,0
            dc.w    $4004,0,$9083,$6524,$8803,$4B96,$A0B0,0
            dc.w    $4004,0,$96CB,$E3F9,$990E,$91A8,$A1E0,0
            dc.w    $4004,0,$9D14,$62CE,$AA19,$D7B9,$2158,0
            dc.w    $4004,0,$A35C,$E1A3,$BB25,$1DCB,$A110,0
            dc.w    $4004,0,$A9A5,$6078,$CC30,$63DD,$A1FC,0
            dc.w    $4004,0,$AFED,$DF4D,$DD3B,$A9EE,$2120,0
            dc.w    $4004,0,$B636,$5E22,$EE46,$F000,$A148,0
            dc.w    $4004,0,$BC7E,$DCF7,$FF52,$3611,$21E8,0
            dc.w    $4004,0,$C2C7,$5BCD,$105D,$7C23,$20D0,0
            dc.w    $4004,0,$C90F,$DAA2,$2168,$C235,$A180,0
.L15:
            dc.w    $3FDC,0,$82E3,$0865,$4361,$C4C6
            ds.b    4
.L16:
            dc.w    $3FA5
            dc.b    'UUUUD1'
.L17:
            dc.w    $3FC5,$5555,$5555,$4018
.L18:
            dc.w    $3F81,$1111,$1117,$4385
.L19:
            dc.w    $3FA5
            dc.b    'UUUUOZ'
.L20:
            dc.w    $3FC5
            dc.b    'UUUUUU'
            ds.b    8
.L21:
            dc.w    $3EC7,$1DE3,$A577,$4682
.L22:
            dc.w    $3EFA,$01A0,$19D7,$CB68
.L23:
            dc.w    $3F2A,$01A0,$1A01,$9DF3
.L24:
            dc.w    $3F56,$C16C,$16C1,$70E2
.L25:
            dc.w    $3F81,$1111,$1111,$1111
.L26:
            dc.w    $3FA5
            dc.b    'UUUUUU'
.L27:
            dc.w    $3FFC,0,$AAAA,$AAAA,$AAAA,$AAAB
            ds.b    4
.L28:
            dc.w    $48B0
            ds.b    6
.L29:
            dc.w    $3730
            ds.b    6
.L30:
            dc.b    $3F,$FF,$00,$00,$80
            ds.b    11
            dc.w    $3FFF,0,$8164,$D1F3,$BC03,$0774,$9F84,$1A9B
            dc.w    $3FFF,0,$82CD,$8698,$AC2B,$A1D8,$9FC1,$D5B9
            dc.w    $3FFF,0,$843A,$28C3,$ACDE,$4048,$A072,$8369
            dc.w    $3FFF,0,$85AA,$C367,$CC48,$7B14,$1FC5,$C95C
            dc.w    $3FFF,0,$871F,$6196,$9E8D,$1010,$1EE8,$5C9F
            dc.w    $3FFF,0,$8898,$0E80,$92DA,$8528,$9FA2,$0729
            dc.w    $3FFF,0,$8A14,$D575,$496E,$FD9C,$A07B,$F9AF
            dc.w    $3FFF,0,$8B95,$C1E3,$EA8B,$D6E8,$A002,$0DCF
            dc.w    $3FFF,0,$8D1A,$DF5B,$7E5B,$A9E4,$205A,$63DA
            dc.w    $3FFF,0,$8EA4,$398B,$45CD,$53C0,$1EB7,$0051
            dc.w    $3FFF,0,$9031,$DC43,$1466,$B1DC,$1F6E,$B029
            dc.w    $3FFF,0,$91C3,$D373,$AB11,$C338,$A078,$1494
            dc.w    $3FFF,0,$935A,$2B2F,$13E6,$E92C,$9EB3,$19B0
            dc.w    $3FFF,0,$94F4,$EFA8,$FEF7,$0960,$2017,$457D
            dc.w    $3FFF,0,$9694,$2D37,$2018,$5A00,$1F11,$D537
            dc.w    $3FFF,0,$9837,$F051,$8DB8,$A970,$9FB9,$52DD
            dc.w    $3FFF,0,$99E0,$4593,$20B7,$FA64,$1FE4,$3087
            dc.w    $3FFF,0,$9B8D,$39B9,$D54E,$5538,$1FA2,$A818
            dc.w    $3FFF,0,$9D3E,$D9A7,$2CFF,$B750,$1FDE,$494D
            dc.w    $3FFF,0,$9EF5,$3260,$91A1,$11AC,$2050,$4890
            dc.w    $3FFF,0,$A0B0,$510F,$B971,$4FC4,$A073,$691C
            dc.w    $3FFF,0,$A270,$4303,$0C49,$6818,$1F9B,$7A05
            dc.w    $3FFF,0,$A435,$15AE,$09E6,$80A0,$A079,$7126
            dc.w    $3FFF,0,$A5FE,$D6A9,$B151,$38EC,$A071,$A140
            dc.b    $3F,$FF,$00,$00,$A7,$CD,$93,$B4,$E9
            dc.b    'e5h Ob'
            dc.b    $DA,$3F,$FF,$00,$00,$A9,$A1,$5A,$B4,$EA,$7C,$0E,$F8,$1F,$28,$3C
            dc.b    $4A,$3F,$FF,$00,$00,$AB,$7A,$39,$B5,$A9,$3E,$D3,$38,$9F,$9A,$7F
            dc.b    $DC,$3F,$FF,$00,$00,$AD,$58,$3E,$EA,$42,$A1,$4A,$C8,$A0,$5B,$3F
            dc.b    $AC,$3F,$FF,$00,$00,$AF,$3B,$78,$AD,$69,$0A,$43,$74,$1F,$DF,$26
            dc.b    $10,$3F,$FF,$00,$00,$B1,$23,$F5,$81,$D2,$AC,$25,$90,$9F,$70,$5F
            dc.b    $90,$3F,$FF,$00,$00,$B3,$11,$C4,$12,$A9,$11,$24,$88,$20,$1F,$67
            dc.b    $8A,$3F,$FF,$00,$00,$B5,$04,$F3,$33,$F9,$DE,$64,$84,$1F,$32,$FB
            dc.b    $13,$3F,$FF,$00,$00,$B6,$FD,$91,$E3,$28,$D1,$77,$90,$20,$03,$8B
            dc.b    $30,$3F,$FF,$00,$00,$B8,$FB,$AF,$47,$62,$FB,$9E,$E8,$20,$0D,$C3
            dc.b    $CC,$3F,$FF,$00,$00,$BA,$FF,$5A,$B2,$13,$3E,$45,$FC,$9F,$8B,$2A
            dc.b    $E6,$3F,$FF,$00,$00,$BD,$08,$A3,$9F,$58,$0C,$36,$C0,$A0,$2B,$BF
            dc.b    $70,$3F,$FF,$00,$00,$BF,$17,$99,$B6,$7A,$73,$10,$84,$A0,$0B,$F5
            dc.b    $18,$3F,$FF,$00,$00,$C1,$2C,$4C,$CA,$66,$70,$94,$58,$A0,$41,$DD
            dc.b    $41,$3F,$FF,$00,$00,$C3,$46,$CC,$DA,$24,$97,$64,$08,$9F,$DF,$13
            dc.b    $7B,$3F,$FF,$00,$00,$C5,$67,$2A,$11,$55,$06,$DA,$DC,$20,$1F,$15
            dc.b    $68,$3F,$FF,$00,$00,$C7,$8D,$74,$C8,$AB,$B9,$B1,$5C,$1F,$C1,$3A
            dc.b    $2E,$3F,$FF,$00,$00,$C9,$B9,$BD,$86,$6E,$2F,$27,$A4,$A0,$3F,$8F
            dc.b    $03,$3F,$FF,$00,$00,$CB,$EC,$14,$FE,$F2,$72,$7C,$5C,$1F,$F4,$90
            dc.b    $7D,$3F,$FF,$00,$00,$CE,$24,$8C,$15,$1F,$84,$80,$E4,$9E,$6E,$53
            dc.b    $E4,$3F,$FF,$00,$00,$D0,$63,$33,$DA,$EF,$2B,$25,$94,$1F,$D6,$D4
            dc.b    $5C,$3F,$FF,$00,$00,$D2,$A8,$1D,$91,$F1,$2A,$E4,$5C,$A0,$76,$ED
            dc.b    $B9,$3F,$FF,$00,$00,$D4,$F3,$5A,$AB,$CF,$ED,$FA,$20,$9F,$A6,$DE
            dc.b    $21,$3F,$FF,$00,$00,$D7,$44,$FC,$CA,$D6,$9D,$6A,$F4,$1E,$E6,$9A
            dc.b    $2F,$3F,$FF,$00,$00,$D9,$9D,$15,$C2,$78,$AF,$D7,$B4,$20,$7F,$43
            dc.b    $9F,$3F,$FF,$00,$00,$DB,$FB,$B7,$97,$DA,$F2,$37,$54,$20,$1E,$C2
            dc.b    $07,$3F,$FF,$00,$00,$DE,$60,$F4,$82,$5E,$0E,$91,$24,$9E,$8B,$E1
            dc.b    $75,$3F,$FF,$00,$00,$E0,$CC,$DE,$EC,$2A,$94,$E1,$10,$20,$03,$2C
            dc.b    $4B,$3F,$FF,$00,$00,$E3,$3F,$89,$72,$BE,$8A,$5A,$50,$20,$04,$DF
            dc.b    $F5,$3F,$FF,$00,$00,$E5,$B9,$06,$E7,$7C,$83,$48,$A8,$1E,$72,$F4
            dc.b    $7A,$3F,$FF,$00,$00,$E8,$39,$6A,$50,$3C,$4B,$DC,$68,$1F,$72,$2F
            dc.b    $22,$3F,$FF,$00,$00,$EA,$C0,$C6,$E7,$DD,$24,$39,$30,$A0,$17,$E9
            dc.b    $45,$3F,$FF,$00,$00,$ED,$4F,$30,$1E,$D9,$94,$2B,$84,$1F,$40,$1A
            dc.b    $5B,$3F,$FF,$00,$00,$EF,$E4,$B9,$9B,$DC,$DA,$F5,$CC,$9F,$B9,$A9
            dc.b    $E3,$3F,$FF,$00,$00,$F2,$81,$77,$3C,$59,$FF,$B1,$38,$20,$74,$4C
            dc.b    $05,$3F,$FF,$00,$00,$F5,$25,$7D,$15,$24,$86,$CC,$2C,$1F,$77,$3A
            dc.b    $19,$3F,$FF,$00,$00,$F7,$D0,$DF,$73,$0A,$D1,$3B,$B8,$1F,$FE,$90
            dc.b    $D5,$3F,$FF,$00,$00,$FA,$83,$B2,$DB,$72,$2A,$03,$3C,$A0,$41,$ED
            dc.b    $22,$3F,$FF,$00,$00,$FD,$3E,$0C,$0C,$F4,$86,$C1,$74,$1F,$85,$3F
            dc.b    $3A
.L31:
            dc.w    $406A,$934F,$0979,$A371
.L32:
            dc.w    $3F73,$4413,$509F,$8000
.L33:
            dc.w    $BFCD,0,$C021,$9DC1,$DA99,$4FD2
            ds.b    4
.L34:
            dc.w    $4000,0,$935D,$8DDD,$AAA8,$AC17
            ds.b    4
.L35:
            dc.w    $3FFE,0,$B172,$17F7,$D1CF,$79AC
            ds.b    4
.L36:
            dc.w    $3F56,$C16D,$6F7B,$D0B2
.L37:
            dc.w    $3F81,$1112,$302C,$712C
.L38:
            dc.w    $3FA5,$5555,$5555,$4CC1
.L39:
            dc.w    $3FC5
            dc.b    'UUUUJT'
.L40:
            dc.w    $3FE0
            ds.b    14
.L41:
            dc.b    $3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $3F73,$8000,$3FFF,0,$8164,$D1F3,$BC03,$0773
            dc.w    $3FBE,$F7CA,$3FFF,0,$82CD,$8698,$AC2B,$A1D7
            dc.w    $3FBD,$F8A9,$3FFF,0,$843A,$28C3,$ACDE,$4046
            dc.w    $3FBC,$D7C9,$3FFF,0,$85AA,$C367,$CC48,$7B15
            dc.w    $BFBD,$E8DA,$3FFF,0,$871F,$6196,$9E8D,$1010
            dc.w    $3FBD,$E85C,$3FFF,0,$8898,$0E80,$92DA,$8527
            dc.w    $3FBE,$BBF1,$3FFF,0,$8A14,$D575,$496E,$FD9A
            dc.w    $3FBB,$80CA,$3FFF,0,$8B95,$C1E3,$EA8B,$D6E7
            dc.w    $BFBA,$8373,$3FFF,0,$8D1A,$DF5B,$7E5B,$A9E6
            dc.w    $BFBE,$9670,$3FFF,0,$8EA4,$398B,$45CD,$53C0
            dc.w    $3FBD,$B700,$3FFF,0,$9031,$DC43,$1466,$B1DC
            dc.w    $3FBE,$EEB0,$3FFF,0,$91C3,$D373,$AB11,$C336
            dc.w    $3FBB,$FD6D,$3FFF,0,$935A,$2B2F,$13E6,$E92C
            dc.w    $BFBD,$B319,$3FFF,0,$94F4,$EFA8,$FEF7,$0961
            dc.w    $3FBD,$BA2B,$3FFF,0,$9694,$2D37,$2018,$5A00
            dc.w    $3FBE,$91D5,$3FFF,0,$9837,$F051,$8DB8,$A96F
            dc.w    $3FBE,$8D5A,$3FFF,0,$99E0,$4593,$20B7,$FA65
            dc.w    $BFBC,$DE7B,$3FFF,0,$9B8D,$39B9,$D54E,$5539
            dc.w    $BFBE,$BAAF,$3FFF,0,$9D3E,$D9A7,$2CFF,$B751
            dc.w    $BFBD,$86DA,$3FFF,0,$9EF5,$3260,$91A1,$11AE
            dc.w    $BFBE,$BEDD,$3FFF,0,$A0B0,$510F,$B971,$4FC2
            dc.w    $3FBC,$C96E,$3FFF,0,$A270,$4303,$0C49,$6819
            dc.w    $BFBE,$C90B,$3FFF,0,$A435,$15AE,$09E6,$809E
            dc.w    $3FBB,$D1DB,$3FFF,0,$A5FE,$D6A9,$B151,$38EA
            dc.w    $3FBC,$E5EB,$3FFF,0,$A7CD,$93B4,$E965,$356A
            dc.w    $BFBE,$C274,$3FFF,0,$A9A1,$5AB4,$EA7C,$0EF8
            dc.w    $3FBE,$A83C,$3FFF,0,$AB7A,$39B5,$A93E,$D337
            dc.w    $3FBE,$CB00,$3FFF,0,$AD58,$3EEA,$42A1,$4AC6
            dc.w    $3FBE,$9301,$3FFF,0,$AF3B,$78AD,$690A,$4375
            dc.w    $BFBD,$8367,$3FFF,0,$B123,$F581,$D2AC,$2590
            dc.w    $BFBE,$F05F,$3FFF,0,$B311,$C412,$A911,$2489
            dc.w    $3FBD,$FB3C,$3FFF,0,$B504,$F333,$F9DE,$6484
            dc.w    $3FBE,$B2FB,$3FFF,0,$B6FD,$91E3,$28D1,$7791
            dc.w    $3FBA,$E2CB,$3FFF,0,$B8FB,$AF47,$62FB,$9EE9
            dc.w    $3FBC,$DC3C,$3FFF,0,$BAFF,$5AB2,$133E,$45FB
            dc.w    $3FBE,$E9AA,$3FFF,0,$BD08,$A39F,$580C,$36BF
            dc.w    $BFBE,$AEFD,$3FFF,0,$BF17,$99B6,$7A73,$1083
            dc.w    $BFBC,$BF51,$3FFF,0,$C12C,$4CCA,$6670,$9456
            dc.w    $3FBE,$F88A,$3FFF,0,$C346,$CCDA,$2497,$6407
            dc.w    $3FBD,$83B2,$3FFF,0,$C567,$2A11,$5506,$DADD
            dc.w    $3FBD,$F8AB,$3FFF,0,$C78D,$74C8,$ABB9,$B15D
            dc.w    $BFBD,$FB17,$3FFF,0,$C9B9,$BD86,$6E2F,$27A3
            dc.w    $BFBE,$FE3C,$3FFF,0,$CBEC,$14FE,$F272,$7C5D
            dc.w    $BFBB,$B6F8,$3FFF,0,$CE24,$8C15,$1F84,$80E4
            dc.w    $BFBC,$EE53,$3FFF,0,$D063,$33DA,$EF2B,$2595
            dc.w    $BFBD,$A4AE,$3FFF,0,$D2A8,$1D91,$F12A,$E45A
            dc.w    $3FBC,$9124,$3FFF,0,$D4F3,$5AAB,$CFED,$FA1F
            dc.w    $3FBE,$B243,$3FFF,0,$D744,$FCCA,$D69D,$6AF4
            dc.w    $3FBD,$E69A,$3FFF,0,$D99D,$15C2,$78AF,$D7B6
            dc.w    $BFB8,$BC61,$3FFF,0,$DBFB,$B797,$DAF2,$3755
            dc.w    $3FBD,$F610,$3FFF,0,$DE60,$F482,$5E0E,$9124
            dc.w    $BFBD,$8BE1,$3FFF,0,$E0CC,$DEEC,$2A94,$E111
            dc.w    $3FBA,$CB12,$3FFF,0,$E33F,$8972,$BE8A,$5A51
            dc.w    $3FBB,$9BFE,$3FFF,0,$E5B9,$06E7,$7C83,$48A8
            dc.w    $3FBC,$F2F4,$3FFF,0,$E839,$6A50,$3C4B,$DC68
            dc.w    $3FBE,$F22F,$3FFF,0,$EAC0,$C6E7,$DD24,$392F
            dc.w    $BFBD,$BF4A,$3FFF,0,$ED4F,$301E,$D994,$2B84
            dc.w    $3FBE,$C01A,$3FFF,0,$EFE4,$B99B,$DCDA,$F5CB
            dc.w    $3FBE,$8CAC,$3FFF,0,$F281,$773C,$59FF,$B13A
            dc.w    $BFBC,$BB3F,$3FFF,0,$F525,$7D15,$2486,$CC2C
            dc.w    $3FBE,$F73A,$3FFF,0,$F7D0,$DF73,$0AD1,$3BB9
            dc.w    $BFB8,$B795,$3FFF,0,$FA83,$B2DB,$722A,$033A
            dc.w    $3FBE,$F84B,$3FFF,0,$FD3E,$0C0C,$F486,$C175
            dc.w    $BFBE,$F581
.L42:
            dc.w    $4000,0,$C90F,$DAA2,$2168,$C235
            ds.b    4
.L43:
            dc.w    $3FFF,0,$C90F,$DAA2,$2168,$C235
            ds.b    4
.L44:
            dc.w    $BFF6,$687E,$3149,$87D8
.L45:
            dc.w    $4002,$AC69,$34A2,$6DB3
.L46:
            dc.w    $BFC2,$476F,$4E1D,$A28E
.L47:
            dc.w    $3FB3,$4444,$7F87,$6989
.L48:
            dc.w    $BFB7,$44EE,$7FAF,$45DB
.L49:
            dc.w    $3FBC,$71C6,$4694,$0220
.L50:
            dc.w    $BFC2,$4924,$9218,$72F9
.L51:
            dc.w    $3FC9,$9999,$9999,$8FA9
.L52:
            dc.w    $BFD5
            dc.b    'UUUUUU'
.L53:
            dc.w    $BFB7,$0BF3,$9853,$9E6A
.L54:
            dc.w    $3FBC,$7187,$962D,$1D7D
.L55:
            dc.w    $BFC2,$4924,$8271,$07B8
.L56:
            dc.w    $3FC9,$9999,$9996,$263E
.L57:
            dc.w    $BFD5
            dc.b    'UUUUU6'
.L58:
            dc.b    $00,$01,$00,$00,$80
            ds.b    11
.L59:
            dc.w    $3FFB,0,$83D1,$52C5,$060B,$7A51
            ds.b    4
            dc.w    $3FFB,0,$8BC8,$5445,$6549,$8B8B
            ds.b    4
            dc.w    $3FFB,0,$93BE,$4060,$1762,$6B0D
            ds.b    4
            dc.w    $3FFB,0,$9BB3,$078D,$35AE,$C202
            ds.b    4
            dc.w    $3FFB,0,$A3A6,$9A52,$5DDC,$E7DE
            ds.b    4
            dc.w    $3FFB,0,$AB98,$E943,$6276,$5619
            ds.b    4
            dc.w    $3FFB,0,$B389,$E502,$F9C5,$9862
            ds.b    4
            dc.w    $3FFB,0,$BB79,$7E43,$6B09,$E6FB
            ds.b    4
            dc.w    $3FFB,0,$C367,$A5C7,$39E5,$F446
            ds.b    4
            dc.w    $3FFB,0,$CB54,$4C61,$CFF7,$D5C6
            ds.b    4
            dc.w    $3FFB,0,$D33F,$62F8,$2488,$533E
            ds.b    4
            dc.w    $3FFB,0,$DB28,$DA81,$6240,$4C77
            ds.b    4
            dc.w    $3FFB,0,$E310,$A407,$8AD3,$4F18
            ds.b    4
            dc.w    $3FFB,0,$EAF6,$B0A8,$188E,$E1EB
            ds.b    4
            dc.w    $3FFB,0,$F2DA,$F194,$9DBE,$79D5
            ds.b    4
            dc.w    $3FFB,0,$FABD,$5813,$61D4,$7E3E
            ds.b    4
            dc.w    $3FFC,0,$8346,$AC21,$0959,$ECC4
            ds.b    4
            dc.w    $3FFC,0,$8B23,$2A08,$3042,$82D8
            ds.b    4
            dc.w    $3FFC,0,$92FB,$70B8,$D29A,$E2F9
            ds.b    4
            dc.w    $3FFC,0,$9ACF,$476F,$5CCD,$1CB4
            ds.b    4
            dc.w    $3FFC,0,$A29E,$7630,$4954,$F23F
            ds.b    4
            dc.w    $3FFC,0,$AA68,$C5D0,$8AB8,$5230
            ds.b    4
            dc.w    $3FFC,0,$B22D,$FFFD,$9D53,$9F83
            ds.b    4
            dc.w    $3FFC,0,$B9ED,$EF45,$3E90,$0EA5
            ds.b    4
            dc.w    $3FFC,0,$C1A8,$5F1C,$C75E,$3EA5
            ds.b    4
            dc.w    $3FFC,0,$C95D,$1BE8,$2813,$8DE6
            ds.b    4
            dc.w    $3FFC,0,$D10B,$F300,$840D,$2DE4
            ds.b    4
            dc.w    $3FFC,0,$D8B4,$B2BA,$6BC0,$5E7A
            ds.b    4
            dc.w    $3FFC,0,$E057,$2A6B,$B423,$35F6
            ds.b    4
            dc.w    $3FFC,0,$E7F3,$2A70,$EA9C,$AA8F
            ds.b    4
            dc.w    $3FFC,0,$EF88,$8432,$64EC,$EFAA
            ds.b    4
            dc.w    $3FFC,0,$F717,$0A28,$ECC0,$6666
            ds.b    4
            dc.w    $3FFD,0,$812F,$D288,$332D,$AD32
            ds.b    4
            dc.w    $3FFD,0,$88A8,$D1B1,$218E,$4D64
            ds.b    4
            dc.w    $3FFD,0,$9012,$AB3F,$23E4,$AEE8
            ds.b    4
            dc.w    $3FFD,0,$976C,$C3D4,$11E7,$F1B9
            ds.b    4
            dc.w    $3FFD,0,$9EB6,$8949,$3889,$A227
            ds.b    4
            dc.w    $3FFD,0,$A5EF,$72C3,$4487,$361B
            ds.b    4
            dc.w    $3FFD,0,$AD17,$00BA,$F07A,$7227
            ds.b    4
            dc.w    $3FFD,0,$B42C,$BCFA,$FD37,$EFB7
            ds.b    4
            dc.w    $3FFD,0,$BB30,$3A94,$0BA8,$0F89
            ds.b    4
            dc.w    $3FFD,0,$C221,$15C6,$FCAE,$BBAF
            ds.b    4
            dc.w    $3FFD,0,$C8FE,$F3E6,$8633,$1221
            ds.b    4
            dc.w    $3FFD,0,$CFC9,$8330,$B400,$0C70
            ds.b    4
            dc.w    $3FFD,0,$D680,$7AA1,$102C,$5BF9
            ds.b    4
            dc.w    $3FFD,0,$DD23,$99BC,$3125,$2AA3
            ds.b    4
            dc.w    $3FFD,0,$E3B2,$A855,$6B8F,$C517
            ds.b    4
            dc.b    $3F,$FD,$00,$00,$EA
            dc.b    '-vOd1Y'
            dc.b    $89
            ds.b    4
            dc.w    $3FFD,0,$F3BF,$5BF8,$BAD1,$A21D
            ds.b    4
            dc.w    $3FFE,0,$801C,$E39E,$0D20,$5C9A
            ds.b    4
            dc.w    $3FFE,0,$8630,$A2DA,$DA1E,$D066
            ds.b    4
            dc.w    $3FFE,0,$8C1A,$D445,$F3E0,$9B8C
            ds.b    4
            dc.w    $3FFE,0,$91DB,$8F16,$64F3,$50E2
            ds.b    4
            dc.w    $3FFE,0,$9773,$1420,$365E,$538C
            ds.b    4
            dc.w    $3FFE,0,$9CE1,$C8E6,$A0B8,$CDBA
            ds.b    4
            dc.w    $3FFE,0,$A228,$32DB,$CADA,$AE09
            ds.b    4
            dc.w    $3FFE,0,$A746,$F2DD,$B760,$2294
            ds.b    4
            dc.w    $3FFE,0,$AC3E,$C0FB,$997D,$D6A2
            ds.b    4
            dc.w    $3FFE,0,$B110,$688A,$EBDC,$6F6A
            ds.b    4
            dc.w    $3FFE,0,$B5BC,$C490,$59EC,$C4B0
            ds.b    4
            dc.w    $3FFE,0,$BA44,$BC7D,$D470,$782F
            ds.b    4
            dc.w    $3FFE,0,$BEA9,$4144,$FD04,$9AAC
            ds.b    4
            dc.w    $3FFE,0,$C2EB,$4ABB,$6616,$28B6
            ds.b    4
            dc.w    $3FFE,0,$C70B,$D54C,$E602,$EE14
            ds.b    4
            dc.w    $3FFE,0,$CD00,$0549,$ADEC,$7159
            ds.b    4
            dc.w    $3FFE,0,$D484,$57D2,$D8EA,$4EA3
            ds.b    4
            dc.w    $3FFE,0,$DB94,$8DA7,$12DE,$CE3B
            ds.b    4
            dc.w    $3FFE,0,$E238,$55F9,$69E8,$096A
            ds.b    4
            dc.w    $3FFE,0,$E877,$1129,$C435,$3259
            ds.b    4
            dc.w    $3FFE,0,$EE57,$C16E,$0D37,$9C0D
            ds.b    4
            dc.w    $3FFE,0,$F3E1,$0211,$A87C,$3779
            ds.b    4
            dc.w    $3FFE,0,$F919,$039D,$758B,$8D41
            ds.b    4
            dc.w    $3FFE,0,$FE05,$8B8F,$6493,$5FB3
            ds.b    4
            dc.w    $3FFF,0,$8155,$FB49,$7B68,$5D04
            ds.b    4
            dc.w    $3FFF,0,$8388,$9E35,$49D1,$08E1
            ds.b    4
            dc.w    $3FFF,0,$859C,$FA76,$511D,$724B
            ds.b    4
            dc.w    $3FFF,0,$8795,$2ECF,$FF81,$31E7
            ds.b    4
            dc.w    $3FFF,0,$8973,$2FD1,$9557,$641B
            ds.b    4
            dc.w    $3FFF,0,$8B38,$CAD1,$0193,$2A35
            ds.b    4
            dc.w    $3FFF,0,$8CE7,$A8D8,$301E,$E6B5
            ds.b    4
            dc.w    $3FFF,0,$8F46,$A39E,$2EAE,$5281
            ds.b    4
            dc.w    $3FFF,0,$922D,$A7D7,$9188,$8487
            ds.b    4
            dc.w    $3FFF,0,$94D1,$9FCB,$DEDF,$5241
            ds.b    4
            dc.w    $3FFF,0,$973A,$B944,$19D2,$A08B
            ds.b    4
            dc.w    $3FFF,0,$996F,$F00E,$08E1,$0B96
            ds.b    4
            dc.w    $3FFF,0,$9B77,$3F95,$1232,$1DA7
            ds.b    4
            dc.w    $3FFF,0,$9D55,$CC32,$0F93,$5624
            ds.b    4
            dc.w    $3FFF,0,$9F10,$0575,$006C,$C571
            ds.b    4
            dc.w    $3FFF,0,$A0A9,$C290,$D97C,$C06C
            ds.b    4
            dc.w    $3FFF,0,$A226,$59EB,$EBC0,$630A
            ds.b    4
            dc.w    $3FFF,0,$A388,$B4AF,$F6EF,$0EC9
            ds.b    4
            dc.w    $3FFF,0,$A4D3,$5F10,$61D2,$92C4
            ds.b    4
            dc.w    $3FFF,0,$A608,$95DC,$FBE3,$187E
            ds.b    4
            dc.w    $3FFF,0,$A72A,$51DC,$7367,$BEAC
            ds.b    4
            dc.w    $3FFF,0,$A83A,$5153,$0956,$168F
            ds.b    4
            dc.w    $3FFF,0,$A93A,$2007,$7539,$546E
            ds.b    4
            dc.w    $3FFF,0,$AA9E,$7245,$023B,$2605
            ds.b    4
            dc.w    $3FFF,0,$AC4C,$84BA,$6FE4,$D58F
            ds.b    4
            dc.w    $3FFF,0,$ADCE,$4A4A,$606B,$9712
            ds.b    4
            dc.w    $3FFF,0,$AF2A,$2DCD,$8D26,$3C9C
            ds.b    4
            dc.w    $3FFF,0,$B065,$6F81,$F222,$65C7
            ds.b    4
            dc.w    $3FFF,0,$B184,$6515,$0F71,$496A
            ds.b    4
            dc.w    $3FFF,0,$B28A,$AA15,$6F9A,$DA35
            ds.b    4
            dc.w    $3FFF,0,$B37B,$44FF,$3766,$B895
            ds.b    4
            dc.w    $3FFF,0,$B458,$C3DC,$E963,$0433
            ds.b    4
            dc.w    $3FFF,0,$B525,$529D,$5622,$46BD
            ds.b    4
            dc.w    $3FFF,0,$B5E2,$CCA9,$5F9D,$88CC
            ds.b    4
            dc.w    $3FFF,0,$B692,$CADA,$7ACA,$1ADA
            ds.b    4
            dc.w    $3FFF,0,$B736,$AEA7,$A692,$5838
            ds.b    4
            dc.w    $3FFF,0,$B7CF,$AB28,$7E9F,$7B36
            ds.b    4
            dc.w    $3FFF,0,$B85E,$CC66,$CB21,$9835
            ds.b    4
            dc.w    $3FFF,0,$B8E4,$FD5A,$20A5,$93DA
            ds.b    4
            dc.w    $3FFF,0,$B99F,$41F6,$4AFF,$9BB5
            ds.b    4
            dc.w    $3FFF,0,$BA7F,$1E17,$842B,$BE7B
            ds.b    4
            dc.w    $3FFF,0,$BB47,$1285,$7637,$E17D
            ds.b    4
            dc.w    $3FFF,0,$BBFA,$BE8A,$4788,$DF6F
            ds.b    4
            dc.w    $3FFF,0,$BC9D,$0FAD,$2B68,$9D79
            ds.b    4
            dc.w    $3FFF,0,$BD30,$6A39,$471E,$CD86
            ds.b    4
            dc.w    $3FFF,0,$BDB6,$C731,$856A,$F18A
            ds.b    4
            dc.w    $3FFF,0,$BE31,$CAC5,$02E8,$0D70
            ds.b    4
            dc.w    $3FFF,0,$BEA2,$D55C,$E331,$94E2
            ds.b    4
            dc.w    $3FFF,0,$BF0B,$10B7,$C031,$28F0
            ds.b    4
            dc.w    $3FFF,0,$BF6B,$7A18,$DACB,$778D
            ds.b    4
            dc.w    $3FFF,0,$BFC4,$EA46,$63FA,$18F6
            ds.b    4
            dc.w    $3FFF,0,$C018,$1BDE,$8B89,$A454
            ds.b    4
            dc.w    $3FFF,0,$C065,$B066,$CFBF,$6439
            ds.b    4
            dc.w    $3FFF,0,$C0AE,$345F,$5634,$0AE6
            ds.b    4
            dc.w    $3FFF,0,$C0F2,$2291,$9CB9,$E6A7
            ds.b    4
.L60:
            dc.w    $3FFD,0,$DE5B,$D8A9,$3728,$7195
            ds.b    4
.L61:
            dc.w    $3FFF,0,$B8AA,$3B29,$5C17,$F0BC
            ds.b    4
            dc.w    $3FFE,$F07D,$3FFF,$8841,$3FFE,$8000,$3FFF,$C000
            dc.w    $3FFE,0,$B172,$17F7,$D1CF,$79AC
            ds.b    4
.L62:
            dc.w    $3F80
            dc.b    $00
            dc.b    $00
.L63:
            ds.b    4
            dc.w    $7F80,0
.L64:
            dc.w    $BF80,0,$3FC2,$499A,$B5E4,$040B,$BFC5,$55B5
            dc.w    $848C,$B7DB,$3FC9,$9999,$987D,$8730,$BFCF,$FFFF
            dc.w    $FF6F,$7E97,$3FD5,$5555,$5555,$55A4,$BFE0
            ds.b    5
            dc.b    $08,$3F,$17,$54,$96,$AD,$D7,$DA,$D6,$3F,$3C,$71,$C2,$FE,$80,$C7
            dc.b    $E0,$3F,$62,$49,$24,$92,$8B,$CC,$FF,$3F,$89,$99,$99,$99,$99,$95
            dc.b    $EC,$3F,$B5
            dc.b    'UUUUUU@'
            ds.b    7
.L65:
            dc.b    $3F,$99,$00,$00,$80
            ds.b    11
            dc.w    $3FFE,0,$FE03,$F80F,$E03F,$80FE
            ds.b    4
            dc.w    $3FF7,0,$FF01,$5358,$833C,$47E2
            ds.b    4
            dc.w    $3FFE,0,$FA23,$2CF2,$5213,$8AC0
            ds.b    4
            dc.w    $3FF9,0,$BDC8,$D83E,$AD88,$D549
            ds.b    4
            dc.w    $3FFE,0,$F660,$3D98,$0F66,$03DA
            ds.b    4
            dc.w    $3FFA,0,$9CF4,$3DCF,$F5EA,$FD48
            ds.b    4
            dc.w    $3FFE,0,$F2B9,$D648,$0F2B,$9D65
            ds.b    4
            dc.w    $3FFA,0,$DA16,$EB88,$CB8D,$F614
            ds.b    4
            dc.w    $3FFE,0,$EF2E,$B71F,$C434,$5238
            ds.b    4
            dc.w    $3FFB,0,$8B29,$B775,$1BD7,$0743
            ds.b    4
            dc.w    $3FFE,0,$EBBD,$B2A5,$C161,$9C8C
            ds.b    4
            dc.w    $3FFB,0,$A8D8,$39F8,$30C1,$FB49
            ds.b    4
            dc.w    $3FFE,0,$E865,$AC7B,$7603,$A197
            ds.b    4
            dc.w    $3FFB,0,$C61A,$2EB1,$8CD9,$07AD
            ds.b    4
            dc.w    $3FFE,0,$E525,$982A,$F70C,$880E
            ds.b    4
            dc.w    $3FFB,0,$E2F2,$A47A,$DE3A,$18AF
            ds.b    4
            dc.w    $3FFE,0,$E1FC,$780E,$1FC7,$80E2
            ds.b    4
            dc.w    $3FFB,0,$FF64,$898E,$DF55,$D551
            ds.b    4
            dc.w    $3FFE,0,$DEE9,$5C4C,$A037,$BA57
            ds.b    4
            dc.w    $3FFC,0,$8DB9,$56A9,$7B3D,$0148
            ds.b    4
            dc.w    $3FFE,0,$DBEB,$61EE,$D19C,$5958
            ds.b    4
            dc.w    $3FFC,0,$9B8F,$E100,$F47B,$A1DE
            ds.b    4
            dc.w    $3FFE,0,$D901,$B203,$6406,$C80E
            ds.b    4
            dc.w    $3FFC,0,$A937,$2F1D,$0DA1,$BD17
            ds.b    4
            dc.w    $3FFE,0,$D62B,$80D6,$2B80,$D62C
            ds.b    4
            dc.w    $3FFC,0,$B6B0,$7F38,$CE90,$E46B
            ds.b    4
            dc.w    $3FFE,0,$D368,$0D36,$80D3,$680D
            ds.b    4
            dc.w    $3FFC,0,$C3FD,$0329,$0648,$8481
            ds.b    4
            dc.w    $3FFE,0,$D0B6,$9FCB,$D258,$0D0B
            ds.b    4
            dc.w    $3FFC,0,$D11D,$E0FF,$15AB,$18CA
            ds.b    4
            dc.w    $3FFE,0,$CE16,$8A77,$2508,$0CE1
            ds.b    4
            dc.w    $3FFC,0,$DE14,$33A1,$6C66,$B150
            ds.b    4
            dc.w    $3FFE,0,$CB87,$27C0,$65C3,$93E0
            ds.b    4
            dc.w    $3FFC,0,$EAE1,$0B5A,$7DDC,$8ADD
            ds.b    4
            dc.w    $3FFE,0,$C907,$DA4E,$8711,$46AD
            ds.b    4
            dc.w    $3FFC,0,$F785,$6E5E,$E2C9,$B291
            ds.b    4
            dc.w    $3FFE,0,$C698,$0C69,$80C6,$980C
            ds.b    4
            dc.w    $3FFD,0,$8201,$2CA5,$A682,$06D7
            ds.b    4
            dc.w    $3FFE,0,$C437,$2F85,$5D82,$4CA6
            ds.b    4
            dc.w    $3FFD,0,$882C,$5FCD,$7256,$A8C5
            ds.b    4
            dc.w    $3FFE,0,$C1E4,$BBD5,$95F6,$E947
            ds.b    4
            dc.w    $3FFD,0,$8E44,$C60B,$4CCF,$D7DE
            ds.b    4
            dc.w    $3FFE,0,$BFA0,$2FE8,$0BFA,$02FF
            ds.b    4
            dc.w    $3FFD,0,$944A,$D09E,$F435,$1AF6
            ds.b    4
            dc.w    $3FFE,0,$BD69,$1047,$0766,$1AA3
            ds.b    4
            dc.w    $3FFD,0,$9A3E,$ECD4,$C3EA,$A6B2
            ds.b    4
            dc.w    $3FFE,0,$BB3E,$E721,$A54D,$880C
            ds.b    4
            dc.w    $3FFD,0,$A021,$8434,$353F,$1DE8
            ds.b    4
            dc.w    $3FFE,0,$B921,$43FA,$36F5,$E02E
            ds.b    4
            dc.w    $3FFD,0,$A5F2,$FCAB,$BBC5,$06DA
            ds.b    4
            dc.w    $3FFE,0,$B70F,$BB5A,$19BE,$3659
            ds.b    4
            dc.w    $3FFD,0,$ABB3,$B8BA,$2AD3,$62A5
            ds.b    4
            dc.w    $3FFE,0,$B509,$E68A,$9B94,$821F
            ds.b    4
            dc.w    $3FFD,0,$B164,$1795,$CE3C,$A97B
            ds.b    4
            dc.w    $3FFE,0,$B30F,$6352,$8917,$C80B
            ds.b    4
            dc.w    $3FFD,0,$B704,$7551,$5D0F,$1C61
            ds.b    4
            dc.w    $3FFE,0,$B11F,$D3B8,$0B11,$FD3C
            ds.b    4
            dc.w    $3FFD,0,$BC95,$2AFE,$EA3D,$13E1
            ds.b    4
            dc.w    $3FFE,0,$AF3A,$DDC6,$80AF,$3ADE
            ds.b    4
            dc.w    $3FFD,0,$C216,$8ED0,$F458,$BA4A
            ds.b    4
            dc.w    $3FFE,0,$AD60,$2B58,$0AD6,$02B6
            ds.b    4
            dc.w    $3FFD,0,$C788,$F439,$B316,$3BF1
            ds.b    4
            dc.w    $3FFE,0,$AB8F,$69E2,$8359,$CD11
            ds.b    4
            dc.w    $3FFD,0,$CCEC,$AC08,$BF04,$565D
            ds.b    4
            dc.w    $3FFE,0,$A9C8,$4A47,$A07F,$5638
            ds.b    4
            dc.w    $3FFD,0,$D242,$0487,$2DD8,$5160
            ds.b    4
            dc.w    $3FFE,0,$A80A,$80A8,$0A80,$A80B
            ds.b    4
            dc.w    $3FFD,0,$D789,$4992,$3BC3,$588A
            ds.b    4
            dc.w    $3FFE,0,$A655,$C439,$2D7B,$73A8
            ds.b    4
            dc.w    $3FFD,0,$DCC2,$C4B4,$9887,$DACC
            ds.b    4
            dc.w    $3FFE,0,$A4A9,$CF1D,$9683,$3751
            ds.b    4
            dc.w    $3FFD,0,$E1EE,$BD3E,$6D6A,$6B9E
            ds.b    4
            dc.w    $3FFE,0,$A306,$5E3F,$AE7C,$D0E0
            ds.b    4
            dc.w    $3FFD,0,$E70D,$785C,$2F9F,$5BDC
            ds.b    4
            dc.w    $3FFE,0,$A16B,$312E,$A8FC,$377D
            ds.b    4
            dc.w    $3FFD,0,$EC1F,$392C,$5179,$F283
            ds.b    4
            dc.w    $3FFE,0,$9FD8,$09FD,$809F,$D80A
            ds.b    4
            dc.w    $3FFD,0,$F124,$40D3,$E361,$30E6
            ds.b    4
            dc.w    $3FFE,0,$9E4C,$AD23,$DD5F,$3A20
            ds.b    4
            dc.w    $3FFD,0,$F61C,$CE92,$3466,$00BB
            ds.b    4
            dc.w    $3FFE,0,$9CC8,$E160,$C3FB,$19B9
            ds.b    4
            dc.w    $3FFD,0,$FB09,$1FD3,$8145,$630A
            ds.b    4
            dc.w    $3FFE,0,$9B4C,$6F9E,$F03A,$3CAA
            ds.b    4
            dc.w    $3FFD,0,$FFE9,$7042,$BFA4,$C2AD
            ds.b    4
            dc.w    $3FFE,0,$99D7,$22DA,$BDE5,$8F06
            ds.b    4
            dc.w    $3FFE,0,$825E,$FCED,$4936,$9330
            ds.b    4
            dc.w    $3FFE,0,$9868,$C809,$868C,$8098
            ds.b    4
            dc.w    $3FFE,0,$84C3,$7A7A,$B9A9,$05C9
            ds.b    4
            dc.w    $3FFE,0,$9701,$2E02,$5C04,$B809
            ds.b    4
            dc.w    $3FFE,0,$8722,$4C2E,$8E64,$5FB7
            ds.b    4
            dc.w    $3FFE,0,$95A0,$2568,$095A,$0257
            ds.b    4
            dc.w    $3FFE,0,$897B,$8CAC,$9F7D,$E298
            ds.b    4
            dc.w    $3FFE,0,$9445,$8094,$4580,$9446
            ds.b    4
            dc.w    $3FFE,0,$8BCF,$55DE,$C4CD,$05FE
            ds.b    4
            dc.w    $3FFE,0,$92F1,$1384,$0497,$889C
            ds.b    4
            dc.w    $3FFE,0,$8E1D,$C0FB,$89E1,$25E5
            ds.b    4
            dc.w    $3FFE,0,$91A2,$B3C4,$D5E6,$F809
            ds.b    4
            dc.w    $3FFE,0,$9066,$E68C,$955B,$6C9B
            ds.b    4
            dc.w    $3FFE,0,$905A,$3863,$3E06,$C43B
            ds.b    4
            dc.w    $3FFE,0,$92AA,$DE74,$C7BE,$59E0
            ds.b    4
            dc.w    $3FFE,0,$8F17,$79D9,$FDC3,$A219
            ds.b    4
            dc.w    $3FFE,0,$94E9,$BFF6,$1584,$5643
            ds.b    4
            dc.w    $3FFE,0,$8DDA,$5202,$3769,$4809
            ds.b    4
            dc.w    $3FFE,0,$9723,$A1B7,$2013,$4203
            ds.b    4
            dc.w    $3FFE,0,$8CA2,$9C04,$6514,$E023
            ds.b    4
            dc.w    $3FFE,0,$9958,$99C8,$90EB,$8990
            ds.b    4
            dc.w    $3FFE,0,$8B70,$344A,$139B,$C75A
            ds.b    4
            dc.w    $3FFE,0,$9B88,$BDAA,$3A3D,$AE2F
            ds.b    4
            dc.w    $3FFE,0,$8A42,$F870,$5669,$DB46
            ds.b    4
            dc.w    $3FFE,0,$9DB4,$224F,$FFE1,$157C
            ds.b    4
            dc.w    $3FFE,0,$891A,$C73A,$E981,$9B50
            ds.b    4
            dc.w    $3FFE,0,$9FDA,$DC26,$8B7A,$12DA
            ds.b    4
            dc.w    $3FFE,0,$87F7,$8087,$F780,$87F8
            ds.b    4
            dc.w    $3FFE,0,$A1FC,$FF17,$CE73,$3BD4
            ds.b    4
            dc.w    $3FFE,0,$86D9,$0544,$7A34,$ACC6
            ds.b    4
            dc.w    $3FFE,0,$A41A,$9E8F,$5446,$FB9F
            ds.b    4
            dc.w    $3FFE,0,$85BF,$3761,$2CEE,$3C9B
            ds.b    4
            dc.w    $3FFE,0,$A633,$CD7E,$6771,$CD8B
            ds.b    4
            dc.w    $3FFE,0,$84A9,$F9C8,$084A,$9F9D
            ds.b    4
            dc.w    $3FFE,0,$A848,$9E60,$0B43,$5A5E
            ds.b    4
            dc.w    $3FFE,0,$8399,$3052,$3FBE,$3368
            ds.b    4
            dc.w    $3FFE,0,$AA59,$233C,$CCA4,$BD49
            ds.b    4
            dc.w    $3FFE,0,$828C,$BFBE,$B9A0,$20A3
            ds.b    4
            dc.w    $3FFE,0,$AC65,$6DAE,$6BCC,$4985
            ds.b    4
            dc.w    $3FFE,0,$8184,$8DA8,$FAF0,$D277
            ds.b    4
            dc.w    $3FFE,0,$AE6D,$8EE3,$60BB,$2468
            ds.b    4
            dc.w    $3FFE,0,$8080,$8080,$8080,$8081
            ds.b    4
            dc.w    $3FFE,0,$B071,$97A2,$3C46,$C654
            ds.b    4
INSTALLPRIVTRAP:
            btst    #4,HWCfgFlags
            beq.b   .L2
            lea     PRIVTRAP881,A0
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            lea     PRIVTRAP040,A0
.L1:
            move.w  #$A097,D0
            _SetOSTrapAddress
.L2:
            rts
PRIVTRAP881:
            cmpi.w  #0,D0
            beq.b   .L1
            cmpi.w  #1,D0
            beq.b   .L3
            cmpi.w  #2,D0
            beq.b   .L4
            move.w  #$FE16,D0
            _SysError
            rts
.L1:
            fnop
            move.l  A0,D1
            fsave   -(SP)
            fmove.l FPSR,D0
            andi.w  #$FF,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            fmove.l FPCR,D0
            and.w   D1,D0
            andi.l  #$FF00,D0
            beq.b   .L2
            lea     .L2,A0
            fmove.l A0,FPIAR
            moveq   #0,D0
            move.b  (1,SP),D0
            bclr    #3,(0,SP,D0.w)
.L2:
            frestore (SP)+
            rts
.L3:
            movea.w #$C0,A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            rts
.L4:
            movea.w #$C0,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            rts
            dc.w    0
PRIVTRAP040:
            cmpi.w  #0,D0
            beq.b   SetExcept040
            cmpi.w  #1,D0
            beq.b   GetTrapVec040
            cmpi.w  #2,D0
            beq.b   SetTrapVec040
            move.w  #$FE16,D0
            _SysError
            rts
GetTrapVec040:
            movea.w #$C4,A1
            move.l  ($1FCC).w,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)+
            move.l  ($1FD0).w,(A0)+
            move.l  ($1FD4).w,(A0)+
            move.l  ($1FD8).w,(A0)+
            move.l  ($1FDC).w,(A0)+
            rts
SetTrapVec040:
            movea.w #$C4,A1
            move.l  (A0)+,($1FCC).w
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)
            move.l  (A0)+,($1FD0).w
            move.l  (A0)+,($1FD4).w
            move.l  (A0)+,($1FD8).w
            move.l  (A0)+,($1FDC).w
            rts
SetExcept040:
            fnop
            move.l  A0,D1
            fmove.l FPSR,D0
            andi.w  #$FF,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            fmove.l FPCR,D0
            and.w   D0,D1
            andi.l  #$FF00,D1
            bne.b   .L1
            rts
.L1:
            btst    #$F,D1
            beq.b   .L2
            fmove.s #"$7FFFFFFF",FP1
            fbgt.w  .L5
            fnop
            rts
.L2:
            btst    #$E,D1
            beq.b   .L3
            fcmp.s  #"$7FBFFFFF",FP1
            bra.b   .L5
.L3:
            btst    #$D,D1
            beq.b   .L4
            fmove.s #"$7F800000",FP1
            fsub.x  FP1,FP1
            bra.b   .L5
.L4:
            btst    #$C,D1
            beq.b   .L6
            fmove.s #"$7F000000",FP1
            dc.w    $F200,$04E3
.L5:
            fnop
            rts
.L6:
            btst    #$B,D1
            beq.b   .L7
            fmove.s #"$1F000000",FP1
            dc.w    $F200,$04E3,$60E6
.L7:
            btst    #$A,D1
            beq.b   .L8
            fmove.b #1,FP1
            fdiv.b  #0,FP1
            bra.b   .L5
.L8:
            fmove.b #1,FP1
            fadd.s  #"$00800000",FP1
            bra.b   .L5
            ds.b    10
JMFBDRVR:
            dc.b    $4C
            ds.b    7
            dc.b    $0B,$6A,$00,$00,$0D,$E0,$13,$82,$13,$58,$18
            dc.b    '.Display_Video_Apple_MDC'
            dc.b    $00,$01,$10,$07,$03,$01,$00,$FF,$03,$01,$00,$FF,$FF,$00,$90,$01
            dc.b    $20,$02,$40,$04,$80,$00,$00,$03,$66,$00,$C0,$20,$02,$00,$F8,$00
            dc.b    $04,$00,$24,$00,$03,$00,$00,$00,$90,$01,$1E,$00,$16,$00,$1E,$00
            dc.b    $12,$00,$03,$00,$00,$06,$CC,$00,$4E,$00,$06,$00,$06,$00,$00,$01
            dc.b    $4C,$00,$C8,$20,$02,$00,$FC,$00,$04,$00,$48,$00,$03,$00,$00,$00
            dc.b    $90,$01,$1E,$00,$1A,$00,$1E,$00,$0E,$00,$03,$00,$00,$06,$CC,$00
            dc.b    $4E,$00,$06,$00,$06,$00,$00,$01,$4C,$00,$D0,$20,$02,$00,$FE,$00
            dc.b    $04,$00,$90,$00,$03,$00,$00,$00,$90,$01,$1E,$00,$1C,$00,$1E,$00
            dc.b    $0C,$00,$03,$00,$00,$06,$CC,$00,$4E,$00,$06,$00,$06,$00,$00,$01
            dc.b    $4C,$00,$D8,$20,$02,$00,$FF,$00,$04,$01,$20,$00,$03,$00,$00,$00
            dc.b    $90,$01,$1E,$00,$1D,$00,$1E,$00,$0B,$00,$03,$00,$00,$06,$CC,$00
            dc.b    $4E,$00,$06,$00,$06,$00,$00,$01,$4C,$0E,$06,$02,$00,$FF,$06,$02
            dc.b    $00,$FF,$FF,$00,$50,$00,$A0,$01,$40,$02,$80,$00,$00,$03,$66,$00
            dc.b    $A0,$00,$02,$00,$F0,$00,$04,$00,$14,$00,$03,$00,$00,$00,$A0,$01
            dc.b    $3E,$00,$12,$00,$26,$00,$22,$00,$03,$00,$00,$06,$CC,$00,$54,$00
            dc.b    $06,$00,$06,$00,$00,$01,$78,$00,$A8,$00,$02,$00,$F8,$00,$04,$00
            dc.b    $28,$00,$03,$00,$00,$00,$A0,$01,$3E,$00,$1A,$00,$26,$00,$1A,$00
            dc.b    $03,$00,$00,$06,$CC,$00,$54,$00,$06,$00,$06,$00,$00,$01,$78,$00
            dc.b    $B0,$00,$02,$00,$FC,$00,$04,$00,$50,$00,$03,$00,$00,$00,$A0,$01
            dc.b    $3E,$00,$1E,$00,$26,$00,$16,$00,$03,$00,$00,$06,$CC,$00,$54,$00
            dc.b    $06,$00,$06,$00,$00,$01,$78,$00,$B8,$00,$02,$00,$FE,$00,$04,$00
            dc.b    $A0,$00,$03,$00,$00,$00,$A0,$01,$3E,$00,$20,$00,$26,$00,$14,$00
            dc.b    $03,$00,$00,$06,$CC,$00,$54,$00,$06,$00,$06,$00,$00,$01,$78,$1A
            dc.b    $0C,$05,$02,$00,$0C,$05,$02,$00,$FF,$00,$50,$00,$A0,$01,$40,$02
            dc.b    $80,$0A,$00,$01,$E0,$00,$80,$00,$82,$00,$E0,$00,$50,$00,$14,$00
            dc.b    $03,$00,$00,$01,$3A,$02,$7E,$00,$34,$00,$3E,$00,$68,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$00,$88,$00
            dc.b    $82,$00,$F0,$00,$50,$00,$28,$00,$03,$00,$00,$01,$2A,$02,$7E,$00
            dc.b    $44,$00,$3E,$00,$58,$00,$03,$00,$00,$03,$C0,$00,$4E,$00,$06,$00
            dc.b    $06,$00,$04,$03,$20,$00,$90,$00,$82,$00,$F8,$00,$50,$00,$50,$00
            dc.b    $03,$00,$00,$01,$22,$02,$7E,$00,$4C,$00,$3E,$00,$50,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$00,$98,$00
            dc.b    $82,$00,$FC,$00,$50,$00,$A0,$00,$03,$00,$00,$01,$1E,$02,$7E,$00
            dc.b    $50,$00,$3E,$00,$4C,$00,$03,$00,$00,$03,$C0,$00,$4E,$00,$06,$00
            dc.b    $06,$00,$04,$03,$20,$00,$9A,$00,$86,$00,$FF,$00,$1E,$00,$F0,$00
            dc.b    $03,$00,$00,$01,$40,$02,$7E,$00,$53,$00,$3E,$00,$49,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$29,$14,$09
            dc.b    $04,$00,$14,$09,$04,$01,$FF,$00,$40,$00,$80,$01,$00,$02,$00,$08
            dc.b    $00,$01,$80,$00,$80,$00,$82,$00,$E0,$00,$50,$00,$10,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$24,$00,$1E,$00,$38,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$00,$88,$00,$82,$00
            dc.b    $F0,$00,$50,$00,$20,$00,$03,$00,$00,$01,$00,$01,$FE,$00,$34,$00
            dc.b    $1E,$00,$28,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00,$02,$00
            dc.b    $04,$02,$60,$00,$90,$00,$82,$00,$F8,$00,$50,$00,$40,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$3C,$00,$1E,$00,$20,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$00,$98,$00,$82,$00
            dc.b    $FC,$00,$50,$00,$80,$00,$03,$00,$00,$01,$00,$01,$FE,$00,$40,$00
            dc.b    $1E,$00,$1C,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00,$02,$00
            dc.b    $04,$02,$60,$00,$9A,$00,$86,$00,$FF,$00,$1E,$00,$C0,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$43,$00,$1E,$00,$19,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$FF,$FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$04,$00,$04,$00,$04
            ds.b    5
            dc.w    $0240,$0080,$8112,$00E0,$0100,$0100,$0003,0
            dc.w    $0160,$02FE,$0031,$0043,$0036,$0003,0,$023F
            dc.w    $0028,$0005,$0005,$005E,$0193,$0088,$8112,$00F0
            dc.w    $0100,$0100,$0003,0,$0150,$02FE,$0041,$0043
            dc.w    $0026,$0003,0,$023F,$0028,$0005,$0005,$005E
            dc.w    $0193,$0090,$8112,$00F8,$0100,$0100,$0003,0
            dc.w    $0148,$02FE,$0049,$0043,$001E,$0003,0,$023F
            dc.w    $0028,$0005,$0005,$005E,$0193,$0098,$8112,$00FC
            dc.b    $01
            ds.b    4
            dc.b    $03,$00,$00,$01,$44,$02,$FE,$00,$4D,$00,$43,$00,$1A,$00,$03,$00
            dc.b    $00,$02,$3F,$00,$28,$00,$05,$00,$05,$00,$5E,$01,$93
            ds.b    4
            dc.w    $FFFF,$FFFF,$FFFF,$0400,$0400,$0400,$0400,0
            dc.b    $02,$40,$00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00C9
            dc.b    $81,$32,$00,$FC,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0150,$02FE,$0041,$0043,$0026,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00D1
            dc.b    $81,$32,$00,$FE,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0148,$02FE,$0049,$0043,$001E,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00D9
            dc.b    $81,$32,$00,$FF,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0144,$02FE,$004D,$0043,$001A,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$FFFF
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$01,$20,$02,$7E,$00
            dc.b    $71,$00,$43,$00,$76,$00,$03,$00,$00,$02,$0F,$00,$58,$00,$05,$00
            dc.b    $05,$00,$5E,$01,$93,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$10,$02,$7E,$00,$81,$00,$43,$00,$66,$00,$03,$00
            dc.b    $00,$02,$0F,$00,$58,$00,$05,$00,$05,$00,$5E,$01,$93,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$01,$08,$02,$7E,$00
            dc.b    $89,$00,$43,$00,$5E,$00,$03,$00,$00,$02,$0F,$00,$58,$00,$05,$00
            dc.b    $05,$00,$5E,$01,$93,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$04,$02,$7E,$00,$8D,$00,$43,$00,$5A,$00,$03,$00
            dc.b    $00,$02,$0F,$00,$58,$00,$05,$00,$05,$00,$5E,$01,$93
            ds.b    5
            dc.b    $FF,$FF,$FF,$FF,$FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01
            dc.b    $E0,$00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0120,$027E,$0071,$0043,$0076,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00C9
            dc.b    $81,$32,$00,$FC,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0110,$027E,$0081,$0043,$0066,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00D1
            dc.b    $81,$32,$00,$FE,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0108,$027E,$0089,$0043,$005E,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00D9
            dc.b    $81,$32,$00,$FF,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0104,$027E,$008D,$0043,$005A,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$009A
            dc.w    $8116,$00FF,0,$00F0
            ds.b    6
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0101,$027E,$0090,$0043,$0057,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$0101
            dc.w    $0101
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$01,$36,$02,$7E,$00
            dc.b    $12,$00,$3A,$00,$3A,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$26,$02,$7E,$00,$22,$00,$3A,$00,$2A,$00,$03,$00
            dc.b    $00,$01,$E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$01,$1E,$02,$7E,$00
            dc.b    $2A,$00,$3A,$00,$22,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$1A,$02,$7E,$00,$2E,$00,$3A,$00,$1E,$00,$03,$00
            dc.b    $00,$01,$E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$01,$01,$01
            dc.b    $01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$C1,$81
            dc.b    $32,$00,$F8,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02
            dc.b    $00,$07,$03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00
            dc.b    $00,$01,$36,$02,$7E,$00,$12,$00,$3A,$00,$3A,$00,$03,$00,$00,$01
            dc.b    $E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$C9,$81,$32,$00
            dc.b    $FC,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07
            dc.b    $03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01
            dc.b    $26,$02,$7E,$00,$22,$00,$3A,$00,$2A,$00,$03,$00,$00,$01,$E0,$00
            dc.b    $21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$D1,$81,$32,$00,$FE,$00
            dc.b    $60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00
            dc.b    $00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1E,$02
            dc.b    $7E,$00,$2A,$00,$3A,$00,$22,$00,$03,$00,$00,$01,$E0,$00,$21,$00
            dc.b    $06,$00,$06,$00,$6E,$01,$4A,$00,$D9,$81,$32,$00,$FF,$00,$60,$01
            dc.b    $00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00
            dc.b    $02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1A,$02,$7E,$00
            dc.b    $2E,$00,$3A,$00,$1E,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$9A,$81,$16,$00,$FF,$00,$00,$00,$F0,$00
            dc.b    $1B,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00,$04,$0D
            dc.b    $06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1D,$02,$7E,$00,$2B,$00
            dc.b    $3A,$00,$21,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00,$06,$00
            dc.b    $6E,$01,$4A,$01,$01,$01,$01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$80,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$00,$F4,$01,$FE,$00
            dc.b    $54,$00,$3A,$00,$78,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$00,$E4,$01,$FE,$00,$64,$00,$3A,$00,$68,$00,$03,$00
            dc.b    $00,$01,$B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$00,$DC,$01,$FE,$00
            dc.b    $6C,$00,$3A,$00,$60,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$00,$D8,$01,$FE,$00,$70,$00,$3A,$00,$5C,$00,$03,$00
            dc.b    $00,$01,$B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$01,$01,$01
            dc.b    $01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$80,$00,$C1,$81
            dc.b    $32,$00,$F8,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02
            dc.b    $00,$07,$03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00
            dc.b    $00,$00,$F4,$01,$FE,$00,$54,$00,$3A,$00,$78,$00,$03,$00,$00,$01
            dc.b    $B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$C9,$81,$32,$00
            dc.b    $FC,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07
            dc.b    $03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00
            dc.b    $E4,$01,$FE,$00,$64,$00,$3A,$00,$68,$00,$03,$00,$00,$01,$B0,$00
            dc.b    $51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$D1,$81,$32,$00,$FE,$00
            dc.b    $60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00
            dc.b    $00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$DC,$01
            dc.b    $FE,$00,$6C,$00,$3A,$00,$60,$00,$03,$00,$00,$01,$B0,$00,$51,$00
            dc.b    $06,$00,$06,$00,$6E,$01,$4A,$00,$D9,$81,$32,$00,$FF,$00,$60,$01
            dc.b    $00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00
            dc.b    $02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$D8,$01,$FE,$00
            dc.b    $70,$00,$3A,$00,$5C,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$9A,$81,$16,$00,$FF,$00,$00,$00,$F0,$00
            dc.b    $1B,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00,$04,$0D
            dc.b    $06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$D5,$01,$FE,$00,$73,$00
            dc.b    $3A,$00,$59,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00,$06,$00
            dc.b    $6E,$01,$4A
.L1:
            dc.b    $01,$03,$0F,$FF,$FF
            dc.b    'Software by Casey King, Hardware by James Lundblad and Moham'
            dc.b    'med Sritip$'
            dc.w    $A440,$7024,$A722,$6600,$0268,$2348,$0014,$A029
            dc.w    $2010,$A055,$2640,$223C,$F000,0,$1029,$0028
            dc.w    $EFC1,$0104,$2041,$2748,$0018,$2F08,$9EFC,$0038
            dc.w    $204F,$1140,$0031,$514F,$208F,$7011,$A06E,$0C2F
            dc.w    0,$0006,$6706,$08EB,$000C,$001E,$4FEF,$0040
            dc.w    $205F,$1629,$0029,$0803,$0004,$6606,$08EB,$0008
            dc.w    $0010,$0803,$0005,$6606,$08EB,$000D,$0010,$7001
            dc.w    $A05D,$3F00,$203C,$0020,0,$E9F0,$1503,$0800
            dc.w    $0C01,$0007,$661C,$2200,$2F09,$2248,$6100,$0932
            dc.w    $225F,$0C00,$0014,$6606,$123C,$0004,$600E,$4201
            dc.w    $600A,$0C01,0,$6604,$123C,$0007,$301F,$A05D
            dc.w    $0801,0,$6718,$08EB,$0009,$0010,$0881,$0002
            dc.w    $660C,$08EB,$000F,$0010,$08EB,$000C,$0010,$2001
            dc.w    $0C40,$0007,$6200,$019A,$303B,$0206,$4EFB,$0002
            dc.w    $0030,$0028,$0018,$0020,$0038,$0028,$0010,$0020
            dc.w    $41FA,$F552,$6000,$009E,$41FA,$F628,$6000,$0096
            dc.w    $41FA,$F3D6,$6000,$008E,$41FA,$F484,$6000,$0086
            dc.w    $08EB,$000D,$001E,$6006,$08AB,$000D,$001E,$08EB
            dc.w    $000B,$0010,$0803,$0003,$6606,$08EB,$000F,$001E
            dc.w    $082B,$000D,$0010,$672C,$082B,$000F,$001E,$6612
            dc.w    $0C01,$0004,$6706,$41FA,$F6B8,$6048,$41FA,$FA78
            dc.w    $6042,$0C01,$0004,$6706,$41FA,$F86A,$6036,$41FA
            dc.w    $FC68,$6030,$08EB,$000E,$001E,$082B,$000F,$001E
            dc.w    $6612,$0C01,$0004,$6706,$41FA,$F73C,$6016,$41FA
            dc.w    $FAFC,$6010,$0C01,$0004,$6706,$41FA,$F8EE,$6004
            dc.w    $41FA,$FCEC,$2748,$0012,$3741,$001C,$0883,$0003
            dc.w    $0883,$0004,$0883,$0005,$9EFC,$0038,$7010,$A71E
            dc.w    $6600,$00B4,$2748,$0008,$6100,$05AA,$6600,$00A8
            dc.w    $204F,$1169,$0028,$0031,$4268,$0032,$4228,$0030
            dc.w    $317C,$0003,$0028,$317C,$0001,$002A,$317C,$0001
            dc.w    $002C,$317C,$0019,$002E,$4228,$0034,$7015,$A06E
            dc.w    $117C,$0040,$0032,$7006,$A06E,$117C,$0080,$0032
            dc.w    $7005,$A06E,$661C,$2050,$2748,$0020,$5448,$4A18
            dc.w    $66FC,$5248,$2008,$0280,$FFFF,$FFFE,$2740,$000C
            dc.w    $603C,$700C,$0640,$0100,$A71E,$663A,$2748,$0020
            dc.w    $2748,$000C,$317C,$0019,$0002,$317C,$0001,$0006
            dc.w    $317C,$0100,$0008,$317C,$0008,$000A,$41E8,$000C
            dc.w    $303C,$00FF,$7200,$10C1,$5241,$51C8,$FFFA,$4FEF
            dc.w    $0038,$7000
.L2:
            rts
            movea.l ($14,A1),A0
            _DisposHandle
            lea     ($38,SP),SP
            moveq   #-$17,D0
            bra.b   .L2
            move.l  A0,-(SP)
            move.l  A1,D0
            _StripAddress
            movea.l D0,A1
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            move.l  ($1C,A0),D0
            _StripAddress
            movea.l D0,A2
            move.w  ($1A,A0),D0
            cmpi.w  #9,D0
            bhi.b   .L4
            move.w  .L3(PC,D0.w*2),D0
            jmp     .L3(PC,D0.w)
.L3:
            dc.w    .L7-.L3
            dc.w    .L5-.L3
            dc.w    .L8-.L3
            dc.w    .L12-.L3
            dc.w    SetGamma-.L3
            dc.w    SetGamma.L13-.L3
            dc.w    SetGamma.L17-.L3
            dc.w    sub_40896BDE-.L3
            dc.w    sub_40896C78-.L3
            dc.w    sub_40896C78.L1-.L3
.L4:
            moveq   #-$11,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movea.l (SP)+,A0
            bra.w   sub_40896C78.L22
.L7:
            move.w  #$80,(A2)
            move.w  #$80,(A3)
            move.w  #1,D1
            moveq   #0,D4
            move.w  D4,(6,A2)
            bsr.w   sub_40896FF8
            bsr.w   JMFBSetPage
            move.l  (4,A3),(8,A2)
            bsr.w   GrayScreen_JMFBDriver
            bra.b   .L5
.L8:
            move.w  (A2),D1
            bsr.w   sub_40896EF8
            bne.b   .L4
            move.w  (6,A2),D0
            move.w  D0,D4
            bsr.w   ChkPage_JMFBDriver
            bne.b   .L4
            move.w  (A2),D2
            cmp.w   (A3),D2
            beq.b   .L11
            move.w  (A2),(A3)
            movea.l ($C,A3),A0
            move.w  (4,A0),D3
            move.w  (8,A0),D2
            lsr.w   #1,D2
            lea     ($C,A0),A0
            adda.w  D3,A0
            move.b  (0,A0,D2.w),D3
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L9
            ori     #$200,SR
            andi    #$FAFF,SR
.L9:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D2
.L10:
            move.l  D3,(A0)
            move.l  D3,(A0)
            move.l  D3,(A0)
            dbra    D2,.L10
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bsr.w   sub_40896FF8
.L11:
            bsr.w   JMFBSetPage
            move.l  (4,A3),(8,A2)
            bra.w   .L5
.L12:
            move.l  (A2),D0
            beq.w   .L4
            btst    #$A,($10,A3)
            bne.w   .L4
SetEntCom:
            movem.l D4-D7/A4-A6,-(SP)
            move.w  ($10,A3),D5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L1
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L1:
            move.w  (A3),D1
            subi.w  #$80,D1
            lea     JMFBDRVR.L1,A3
            moveq   #0,D6
            move.b  (0,A3,D1.w),D6
            move.w  (6,A2),D3
            cmp.w   D6,D3
            bhi.w   .L13
            move.w  (4,A2),D0
            addq.w  #1,D0
            bmi.w   .L13
            move.l  SP,D1
            move.l  D1,D0
            neg.w   D0
            andi.w  #3,D0
            beq.b   .L2
            suba.w  D0,SP
.L2:
            move.l  D1,-(SP)
            move.l  D3,D4
            addq.w  #1,D4
            asl.w   #2,D4
            suba.w  D4,SP
            movea.l SP,A0
            move.l  (A2),D0
            _StripAddress
            movea.l D0,A3
.L3:
            bsr.w   GetGammaCSpec
            move.l  D2,(A0)+
            dbra    D3,.L3
            move.w  (6,A2),D3
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D1
            move    SR,D6
            moveq   #7,D0
            ror.w   #8,D6
            and.b   D6,D0
            rol.w   #8,D6
            subq.w  #2,D0
            bge.b   .L4
            ori     #$200,SR
            andi    #$FAFF,SR
.L4:
            bsr.w   WaitVSync_JMFBDriver
            movea.l ($18,A3),A3
            adda.l  #$200204,A3
            move.w  (4,A2),D7
            bpl.b   .L8
.L5:
            move.l  (SP)+,D2
            move.l  D2,(-4,A3)
            lsr.l   #8,D2
            btst    #$C,D5
            beq.b   .L6
            clr.l   (A3)
            clr.l   (A3)
            move.l  D2,(A3)
            bra.b   .L7
.L6:
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
.L7:
            dbra    D3,.L5
            bra.b   .L12
.L8:
            move.l  D7,(-4,A3)
.L9:
            move.l  (SP)+,D2
            lsr.l   #8,D2
            btst    #$C,D5
            beq.b   .L10
            clr.l   (A3)
            clr.l   (A3)
            move.l  D2,(A3)
            bra.b   .L11
.L10:
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
.L11:
            dbra    D3,.L9
.L12:
            move.w  D1,D0
            _SwapMMUMode
            move    D6,SR
            movea.l (SP)+,SP
            movem.l (SP)+,D4-D7/A4-A6
            bra.w   JMFBDRVR.L5
.L13:
            movem.l (SP)+,D4-D7/A4-A6
            bra.w   JMFBDRVR.L4
GetGammaCSpec:
            move.l  D3,-(SP)
            move.w  (A3)+,D3
            move.w  (A3)+,D0
            move.w  (A3)+,D1
            move.w  (A3)+,D2
            tst.w   D5
            bpl.b   .L1
            btst    #$A,D5
            bne.b   .L1
            mulu.w  #$4CCC,D0
            mulu.w  #$970A,D1
            mulu.w  #$1C29,D2
            add.l   D1,D0
            add.l   D2,D0
            bfextu  D0{0:D7},D1
            move.w  D1,D0
            move.w  D1,D2
            bra.b   .L2
.L1:
            bfextu  D0{16:D7},D0
            bfextu  D1{16:D7},D1
            bfextu  D2{16:D7},D2
.L2:
            move.b  (0,A6,D2.w),D2
            lsl.l   #8,D2
            move.b  (0,A5,D1.w),D2
            lsl.l   #8,D2
            move.b  (0,A4,D0.w),D2
            lsl.l   #8,D2
            move.b  D3,D2
            move.l  (SP)+,D3
            rts
SetGamma:
            move.l  (A2),D0
            beq.w   .L6
            movea.l D0,A2
            tst.w   (A2)
            bne.w   JMFBDRVR.L4
            cmpi.w  #6,($1C,A3)
            bne.b   .L1
            tst.w   (2,A2)
            beq.b   .L2
.L1:
            cmpi.w  #$19,(2,A2)
            bne.w   JMFBDRVR.L4
            tst.w   (4,A2)
            beq.b   .L2
            move.w  ($C,A2),D0
            cmp.w   ($16,A3),D0
            beq.b   .L2
            addq.w  #1,D0
            bne.w   JMFBDRVR.L4
.L2:
            movea.l ($C,A3),A0
            move.w  (4,A2),D0
            cmp.w   (4,A0),D0
            bne.b   .L3
            move.w  (6,A2),D0
            cmp.w   (6,A0),D0
            beq.b   .L4
            bgt.b   .L3
            movea.l ($20,A3),A0
            _DisposPtr
            clr.l   ($20,A3)
.L3:
            move.w  (8,A2),D0
            mulu.w  (6,A2),D0
            add.w   (4,A2),D0
            addi.w  #$C,D0
            _NewPtrSys
            bne.w   JMFBDRVR.L4
            move.l  ($20,A3),D0
            move.l  A0,($C,A3)
            tst.l   D0
            beq.b   .L4
            movea.l D0,A0
            _DisposPtr
            movea.l ($C,A3),A0
            move.l  A0,($20,A3)
.L4:
            move.w  (6,A2),D0
            move.w  (4,A2),D1
            move.w  (8,A2),D2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            mulu.w  D0,D2
            add.w   D1,D2
            subq.w  #1,D2
.L5:
            move.b  (A2)+,D0
            move.b  D0,(A0)+
            dbra    D2,.L5
            bra.b   .L9
.L6:
            movea.l ($C,A3),A0
            move.w  (4,A0),D0
            move.w  (6,A0),D2
            subq.w  #1,D2
            lea     ($C,A0),A0
            adda.w  D0,A0
.L7:
            move.w  #$FF,D0
.L8:
            move.b  D0,(A0)
            not.b   (A0)+
            dbra    D0,.L8
            dbra    D2,.L7
.L9:
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L10
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L10:
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L11
            ori     #$200,SR
            andi    #$FAFF,SR
.L11:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D0
            moveq   #0,D1
.L12:
            move.b  (0,A4,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A5,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A6,D1.w),D2
            move.l  D2,(A0)
            addq.w  #1,D1
            dbra    D0,.L12
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bra.w   JMFBDRVR.L5
.L13:
            move.w  (A3),D1
            move.w  D1,(A2)
            bsr.w   sub_40896EF8
            bne.w   JMFBDRVR.L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_JMFBDriver
            bne.w   JMFBDRVR.L4
            bsr.w   GrayScreen_JMFBDriver
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L14
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L14:
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L15
            ori     #$200,SR
            andi    #$FAFF,SR
.L15:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D0
            moveq   #0,D1
.L16:
            move.b  (0,A4,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A5,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A6,D1.w),D2
            move.l  D2,(A0)
            addq.w  #1,D1
            dbra    D0,.L16
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bra.w   JMFBDRVR.L5
.L17:
            btst    #$C,($10,A3)
            beq.b   .L18
            move.b  #1,(A2)
.L18:
            moveq   #0,D1
            bsr.b   sub_40896BD4
            bra.w   JMFBDRVR.L5
sub_40896BD4:
            move.b  (A2),D0
            bfins   D0,($10,A3){D1:1}
            rts
sub_40896BDE:
            moveq   #1,D1
            bsr.b   sub_40896BD4
            bne.b   .L1
            bsr.b   EnableVGuts_JMFBDriver
            bne.w   JMFBDRVR.L4
            bra.w   JMFBDRVR.L5
.L1:
            bsr.b   DisableVGuts_JMFBDriver
            bra.w   JMFBDRVR.L5
DisableVGuts_JMFBDriver:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D3
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            clr.w   D0
            move.b  ($28,A1),D0
            movea.l ($18,A3),A0
            adda.l  #$20013C,A0
            move.l  #7,(A0)
            move.w  D3,D0
            _SwapMMUMode
            movea.l (8,A3),A0
            _SIntRemove
            move    (SP)+,SR
            rts
EnableVGuts_JMFBDriver:
            movea.l (8,A3),A0
            lea     BeginIH,A2
            move.l  A2,D0
            _StripAddress
            movea.l D0,A2
            move.w  #6,(4,A0)
            move.l  A2,(8,A0)
            movea.l ($18,A3),A2
            adda.l  #$200148,A2
            move.l  A2,($C,A0)
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntInstall
            bne.b   .L1
            adda.w  #$FFF4,A2
            moveq   #1,D0
            _SwapMMUMode
            move.l  #5,(A2)
            _SwapMMUMode
            cmp.w   D1,D1
            rts
.L1:
            moveq   #1,D0
            rts
sub_40896C78:
            move.l  (A2),D0
            beq.w   JMFBDRVR.L4
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L4
            bra.w   SetEntCom
.L1:
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  ($28,A1),($31,A0)
            clr.b   ($33,A0)
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (A2),(3,SP)
            move.l  SP,(4,A0)
            _sPutPRAMRec
            lea     ($40,SP),SP
            bra.w   JMFBDRVR.L5
            move.l  A1,D0
            _StripAddress
            movea.l D0,A1
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            bsr.w   DisableVGuts_JMFBDriver
            movea.l ($20,A3),A0
            _DisposPtr
            movea.l ($14,A1),A0
            _DisposHandle
            movea.l (8,A3),A0
            _DisposPtr
            moveq   #0,D0
            rts
            move.l  A0,-(SP)
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #9,D0
            bhi.b   .L3
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L3-.L2
            dc.w    .L3-.L2
            dc.w    .L6-.L2
            dc.w    .L7-.L2
            dc.w    .L12-.L2
            dc.w    .L15-.L2
            dc.w    .L17-.L2
            dc.w    .L19-.L2
            dc.w    .L20-.L2
            dc.w    .L21-.L2
.L3:
            moveq   #-$12,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            movea.l (SP)+,A0
            bra.w   .L22
.L6:
            move.w  (A3),(A2)
            move.w  (2,A3),(6,A2)
            move.l  (4,A3),(8,A2)
            bra.b   .L4
.L7:
            move.l  (A2),D0
            beq.b   .L3
            _StripAddress
            movea.l D0,A0
            move.w  (A3),D1
            subi.w  #$80,D1
            lea     JMFBDRVR.L1,A3
            moveq   #0,D3
            move.b  (0,A3,D1.w),D3
            move.w  (6,A2),D4
            tst.w   D4
            bmi.b   .L3
            cmp.w   D3,D4
            bhi.b   .L3
            move.w  D4,D2
            cmpi.w  #$FFFF,(4,A2)
            beq.b   .L9
            move.w  D4,D1
            add.w   (4,A2),D2
.L8:
            move.w  D2,(0,A0,D1.w*8)
            subq.w  #1,D2
            dbra    D1,.L8
.L9:
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            movea.l ($18,A3),A3
            adda.l  #$200204,A3
            moveq   #1,D0
            _SwapMMUMode
.L10:
            move.w  (A0),D1
            cmp.w   D3,D1
            bhi.b   .L11
            move.l  D1,(-4,A3)
            move.l  (A3),D1
            move.b  D1,(2,A0)
            move.b  D1,(3,A0)
            move.l  (A3),D1
            move.b  D1,(4,A0)
            move.b  D1,(5,A0)
            move.l  (A3),D1
            move.b  D1,(6,A0)
            move.b  D1,(7,A0)
.L11:
            addq.l  #8,A0
            dbra    D4,.L10
            _SwapMMUMode
            bra.w   .L4
.L12:
            move.w  (A2),D1
            move.w  D1,D2
            bsr.w   sub_40896EF8
            bne.w   .L3
            subi.w  #$80,D2
            movea.l ($12,A3),A0
            btst    #$D,($10,A3)
            bne.b   .L13
            move.b  (-$16,A0,D2.w),D1
            ext.w   D1
            bra.b   .L14
.L13:
            move.b  (-$11,A0,D2.w),D1
            ext.w   D1
.L14:
            addq.w  #1,D1
            move.w  D1,(6,A2)
            bra.w   .L4
.L15:
            move.w  (A3),D1
            move.w  D1,(A2)
            bsr.w   sub_40896EF8
            move.w  (6,A2),D0
            bsr.w   ChkPage_JMFBDriver
            bne.w   .L3
            move.w  (A3),D1
            subi.w  #$80,D1
            movea.l ($12,A3),A0
            mulu.w  (-$C,A0,D1.w*2),D0
            mulu.w  (-2,A0),D0
            move.l  D0,D1
            bsr.w   sub_40897218
            add.l   D1,D0
            add.l   ($18,A3),D0
            btst    #8,($10,A3)
            bne.b   .L16
            bfextu  D0{4:4},D1
            bfins   D1,D0{8:4}
.L16:
            move.l  D0,(8,A2)
            bra.w   .L4
.L17:
            moveq   #0,D1
.L18:
            bfextu  ($10,A3){D1:1},D0
            move.b  D0,(A2)
            bra.w   .L4
.L19:
            moveq   #1,D1
            bra.b   .L18
.L20:
            move.l  ($C,A3),(A2)
            bra.w   .L4
.L21:
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  ($28,A1),($31,A0)
            clr.b   ($33,A0)
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (3,SP),(A2)
            lea     ($40,SP),SP
            bra.w   .L4
.L22:
            btst    #9,(6,A0)
            beq.b   .L23
            rts
.L23:
            movea.l JIODone,A0
            jmp     (A0)
            movem.l D2-D6,-(SP)
            clr.w   D0
            moveq   #9,D5
            moveq   #4,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D0
            lsl.b   #2,D0
            moveq   #2,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D6
            andi.b  #1,D6
            lsr.b   #1,D2
            or.b    D6,D2
            or.b    D2,D0
            lsl.b   #2,D0
            moveq   #1,D3
            lsl.l   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            lsr.l   #1,D2
            or.b    D2,D0
            movem.l (SP)+,D2-D6
            rts
sub_40896EF8:
            subi.w  #$80,D1
            bmi.b   .L5
            cmpi.w  #4,D1
            bgt.b   .L5
            bclr    #$A,($10,A3)
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            cmpi.w  #4,D1
            ble.b   .L4
            btst    #$D,($10,A3)
            bne.b   .L2
            cmpi.w  #8,D1
            beq.b   .L4
            btst    #9,($10,A3)
            bne.b   .L5
            btst    #8,($10,A3)
            beq.b   .L5
            btst    #$D,($1E,A3)
            beq.b   .L1
            btst    #$F,($1E,A3)
            beq.b   .L5
.L1:
            bset    #$A,($10,A3)
            bra.b   .L4
.L2:
            btst    #9,($10,A3)
            bne.b   .L5
            btst    #$D,($1E,A3)
            beq.b   .L3
            btst    #$F,($1E,A3)
            beq.b   .L5
.L3:
            cmpi.w  #8,D1
            bne.b   .L5
.L4:
            cmp.w   D1,D1
            bra.b   .L6
.L5:
            st      D1
            tst.b   D1
.L6:
            rts
ChkPage_JMFBDriver:
            movem.l D2-D3/A0-A1,-(SP)
            tst.w   D0
            bmi.b   .L3
            moveq   #0,D3
            move.w  (A2),D2
            subi.w  #$80,D2
            movea.l ($12,A3),A1
            btst    #$D,($10,A3)
            bne.b   .L1
            move.b  (-$16,A1,D2.w),D3
            ext.w   D3
            cmp.w   D3,D0
            bra.b   .L2
.L1:
            move.b  (-$11,A1,D2.w),D3
            ext.w   D3
            cmp.w   D3,D0
.L2:
            sgt     D2
            tst.b   D2
            bra.b   .L4
.L3:
            st      D2
            tst.b   D2
.L4:
            movem.l (SP)+,D2-D3/A0-A1
            rts
WaitVSync_JMFBDriver:
            movem.l D0/A0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            movea.l ($18,A3),A0
            adda.l  #$2001C0,A0
.L2:
            bfextu  (A0){29:1},D0
            cmpi.b  #1,D0
            bne.b   .L2
.L3:
            bfextu  (A0){29:1},D0
            cmpi.b  #0,D0
            bne.b   .L3
.L4:
            bfextu  (A0){29:1},D0
            cmpi.b  #1,D0
            bne.b   .L4
            move    (SP)+,SR
            movem.l (SP)+,D0/A0
            rts
sub_40896FF8:
            movem.l D0-D2/A0-A4,-(SP)
            cmpi.w  #$10,D1
            bgt.w   .L16
            move.w  (A2),(A3)
            movea.l ($12,A3),A0
            cmpi.w  #1,D1
            beq.b   .L4
            cmpi.w  #2,D1
            beq.b   .L3
            cmpi.w  #4,D1
            beq.b   .L2
            cmpi.w  #8,D1
            beq.b   .L1
            adda.w  #$A0,A0
            bra.b   .L4
.L1:
            adda.w  #$78,A0
            bra.b   .L4
.L2:
            adda.w  #$50,A0
            bra.b   .L4
.L3:
            adda.w  #$28,A0
.L4:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L5
            ori     #$200,SR
            andi    #$FAFF,SR
.L5:
            bsr.w   WaitVSync_JMFBDriver
            btst    #$E,($1E,A3)
            beq.b   .L6
            move.w  (A3),D2
            subi.w  #$80,D2
            mulu.w  #$16,D2
            adda.l  D2,A0
.L6:
            movea.l ($18,A3),A1
            move.w  ($1E,A3),D2
            movea.l A3,A4
            movea.l A1,A3
            adda.l  #$200208,A1
            moveq   #0,D0
            move.w  (A0)+,D0
            move.l  D0,(A1)
            movea.l A3,A1
            adda.l  #$200000,A1
            movea.l A1,A2
            move.w  #2,D1
            moveq   #0,D0
            move.w  (A0)+,D0
            btst    #$C,($1E,A4)
            bne.b   .L7
            ori.w   #$2000,D0
.L7:
            move.l  D0,(A1)+
.L8:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L8
            movea.l A3,A1
            adda.l  #$200300,A1
            btst    #$E,D2
            beq.b   .L12
            btst    #$C,($1E,A4)
            bne.b   .L10
            move.w  #2,D1
            moveq   #0,D0
.L9:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L9
            adda.w  #$10,A0
            bra.b   .L12
.L10:
            addq.l  #6,A0
            move.w  #$F,D1
            moveq   #0,D0
.L11:
            move.b  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L11
.L12:
            adda.w  #0,A2
            btst    #$C,($1E,A4)
            bne.b   .L13
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$2000,D1
            move.l  D1,(A2)
.L13:
            move.w  #5,D1
.L14:
            dbra    D1,.L14
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$8000,D1
            move.l  D1,(A2)
            movea.l A3,A1
            adda.l  #$200100,A1
            move.w  #$E,D1
            moveq   #0,D0
.L15:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L15
            move.l  #4,(A1)
            move.l  #5,(A1)
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #8,D1
            move.l  D1,(A2)
            movea.l A4,A3
            bsr.w   WaitVSync_JMFBDriver
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$40,D1
            move.l  D1,(A2)
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
.L16:
            movem.l (SP)+,D0-D2/A0-A4
            rts
JMFBSetPage:
            movem.l D0-D5/A0,-(SP)
            move.w  D4,(2,A3)
            move.w  (A3),D1
            subi.w  #$80,D1
            movea.l ($12,A3),A0
            move.w  (-$C,A0,D1.w*2),D2
            mulu.w  D2,D4
            mulu.w  (-2,A0),D4
            bsr.w   sub_40897218
            add.l   D0,D4
            move.l  D4,D5
            moveq   #1,D0
            _SwapMMUMode
            btst    #$B,($10,A3)
            beq.b   .L6
            btst    #$D,($10,A3)
            beq.b   .L1
            subi.l  #$400,D4
            bra.b   .L2
.L1:
            cmpi.b  #3,D1
            bgt.b   .L4
            subi.l  #$1400,D4
.L2:
            movea.l ($18,A3),A0
            addi.w  #$2000,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L3:
            move.l  #$FFFFFFFF,(A0)+
            dbra    D2,.L3
            bra.b   .L6
.L4:
            subi.l  #$A00,D4
            movea.l ($18,A3),A0
            addi.w  #$A00,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L5:
            clr.l   (A0)+
            dbra    D2,.L5
.L6:
            add.l   ($18,A3),D5
            btst    #8,($10,A3)
            bne.b   .L7
            bfextu  D5{4:4},D3
            bfins   D3,D5{8:4}
.L7:
            move.l  D5,(4,A3)
            movea.l ($18,A3),A0
            adda.l  #$200000,A0
            addq.l  #8,A0
            cmpi.b  #3,D1
            ble.b   .L8
            asr.l   #2,D4
            dc.w    $4C3C,$4004,0,$0003,$E28C
.L8:
            lsr.l   #5,D4
            move.l  D4,(A0)
            _SwapMMUMode
            movem.l (SP)+,D0-D5/A0
            rts
sub_40897218:
            btst    #$B,($10,A3)
            bne.b   .L2
            btst    #9,($10,A3)
            beq.b   .L1
            move.l  #$80,D0
            bra.b   .L4
.L1:
            move.l  #$A00,D0
            bra.b   .L4
.L2:
            cmpi.w  #$83,(A3)
            bgt.b   .L3
            move.l  #$2000,D0
            bra.b   .L4
.L3:
            move.l  #$A00,D0
.L4:
            rts
GrayScreen_JMFBDriver:
            movem.l D0-D6/A0-A1,-(SP)
            move.w  (A3),D1
            subi.w  #$80,D1
            move.w  D1,D3
            lea     .L13,A1
            move.l  (0,A1,D3.w*4),D5
            movea.l ($12,A3),A1
            move.w  (-$C,A1,D1.w*2),D4
            move.w  (-2,A1),D3
            subq.w  #1,D3
            movea.l (4,A3),A1
            btst    #8,($10,A3)
            bne.b   .L1
            move.l  A1,D0
            andi.l  #$FF0FFFFF,D0
            movea.l D0,A1
.L1:
            moveq   #1,D0
            _SwapMMUMode
            cmpi.b  #4,D1
            beq.b   .L7
.L2:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            move.w  D2,D7
            subq.w  #1,D2
.L3:
            move.l  D5,(A0)+
            dbra    D2,.L3
            not.l   D5
            adda.w  D4,A1
            dbra    D3,.L2
            btst    #$B,($10,A3)
            beq.b   .L12
            btst    #$F,($1E,A3)
            beq.b   .L12
            move.w  D7,D2
            btst    #$D,($1E,A3)
            bne.b   .L4
            mulu.w  #$32,D2
            bra.b   .L5
.L4:
            mulu.w  #$3A,D2
.L5:
            subq.w  #1,D2
.L6:
            move.l  #$FFFFFFFF,(A0)+
            dbra    D2,.L6
            bra.b   .L12
.L7:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            move.w  D2,D7
            subq.w  #1,D2
.L8:
            move.l  D5,(A0)+
            not.l   D5
            dbra    D2,.L8
            not.l   D5
            adda.w  D4,A1
            dbra    D3,.L7
            btst    #$B,($10,A3)
            beq.b   .L12
            btst    #$F,($1E,A3)
            beq.b   .L12
            move.w  D7,D2
            btst    #$D,($1E,A3)
            bne.b   .L9
            mulu.w  #$32,D2
            bra.b   .L10
.L9:
            mulu.w  #$3A,D2
.L10:
            subq.w  #1,D2
.L11:
            clr.l   (A0)+
            dbra    D2,.L11
.L12:
            _SwapMMUMode
            movem.l (SP)+,D0-D6/A0-A1
            rts
.L13:
            dc.b    $AA,$AA,$AA,$AA,$CC,$CC,$CC,$CC,$F0,$F0,$F0,$F0,$FF,$00,$FF
            ds.b    5
BeginIH:
            movem.l D1-D2/A0-A1,-(SP)
            moveq   #1,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D1-D2/A0-A1
            move.l  D1,-(SP)
.L1:
            move.l  ($84,A1),D1
            andi.w  #8,D1
            bne.b   .L1
            move.l  (SP)+,D1
            move.l  #1,(A1)
            movem.l D1-D2/A0-A1,-(SP)
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D1-D2/A0-A1
            move.l  A1,D0
            rol.l   #8,D0
            andi.w  #$F,D0
            movea.l ($D28).w,A0
            jsr     (A0)
            moveq   #1,D0
            rts
JMFBDRVRSIZE:
            dc.w    0,$1A20
            ds.b    12
JMFBPRIMARYINIT:
            dc.w    $4E71
            movem.l D0-D7/A0-A4,-(SP)
            move.w  #1,(2,A0)
            move.l  #$F0000000,D1
            move.b  (A0),D0
            bfins   D0,D1{4:4}
            movea.l D1,A1
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  D0,($31,A0)
            clr.b   ($33,A0)
            clr.b   D6
            _sVersion
            sne     D6
            moveq   #1,D0
            _SwapMMUMode
            move.l  D0,-(SP)
            move.l  #$200000,D1
            bfextu  (0,A1,D1.l){20:3},D4
            cmpi.b  #7,D4
            bne.b   .L2
            bsr.w   GetXtndSense
            cmpi.b  #$14,D0
            bne.b   .L1
            move.b  #4,D4
            bra.b   .L3
.L1:
            move.b  #$F0,D4
            bra.b   .L3
.L2:
            cmpi.b  #0,D4
            bne.b   .L3
            move.b  #7,D4
.L3:
            move.l  (SP)+,D0
            _SwapMMUMode
            move.l  D4,D5
            move.b  #$F0,D3
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (3,SP),D1
            sf      D2
            movea.l A1,A3
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D7
            bsr.w   pGetClockType
            cmp.b   (6,SP),D0
            beq.b   .L4
            move.b  D0,(6,SP)
            st      D2
.L4:
            move.w  D7,D0
            _SwapMMUMode
            bfextu  D1{29:3},D0
            cmp.b   D4,D0
            beq.b   .L5
            st      D2
            bra.b   .L8
.L5:
            move.b  D4,D0
            andi.b  #3,D0
            cmpi.b  #0,D0
            bne.b   .L8
            clr.b   (5,SP)
            tst.b   D6
            beq.b   .L6
            cmpi.b  #$84,(2,SP)
            bne.b   .L6
            move.b  #$FF,(5,SP)
.L6:
            move.l  (A0),(4,A0)
            _sPutPRAMRec
            btst    #3,D1
            beq.b   .L7
            bset    #3,D4
.L7:
            cmp.b   (4,SP),D1
            beq.b   .L8
            st      D2
.L8:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D7
            move.l  #$F4B00,D1
            move.l  #$AAAAAAAA,D5
            move.l  D5,(0,A1,D1.l)
            move.l  MinusOne,-(SP)
            addq.w  #4,SP
            cmp.l   (0,A1,D1.l),D5
            bne.b   .L9
            bset    #5,D4
.L9:
            bset    #7,D4
            tst.b   D6
            beq.b   .L10
            bset    #4,D4
            bra.b   .L11
.L10:
            move.b  D4,D3
            bchg    #3,D3
.L11:
            tst.b   D2
            beq.b   .L12
            move.b  D4,(3,SP)
            move.b  D4,(4,SP)
            move.b  #$80,(2,SP)
            clr.b   (5,SP)
            move.l  SP,(4,A0)
            _sPutPRAMRec
.L12:
            addq.w  #8,SP
            bclr    #4,D4
            bclr    #4,D3
            move.w  D7,D0
            _SwapMMUMode
            lea     pGetClockType.L3,A2
            moveq   #$B,D1
.L13:
            move.b  (A2)+,D2
            tst.b   D6
            bne.b   .L14
            bset    #4,D2
.L14:
            move.b  D2,($32,A0)
            _sDeleteSRTRec
            dbra    D1,.L13
            clr.w   D7
            btst    #0,D4
            beq.b   .L15
            bclr    #2,D4
.L15:
            lea     pGetClockType.L3,A2
            moveq   #$B,D1
.L16:
            move.b  (A2)+,D2
            cmp.b   D3,D2
            bne.b   .L17
            tst.b   D6
            bne.b   .L17
            bclr    #4,D2
            move.b  D2,($32,A0)
            move.l  #1,($18,A0)
            clr.b   ($33,A0)
            _sSetsRsrcState
            clr.l   ($18,A0)
            bra.b   .L19
.L17:
            cmp.b   D4,D2
            beq.b   .L19
            tst.b   D6
            beq.b   .L18
            bset    #4,D2
.L18:
            move.b  D2,($32,A0)
            _sDeleteSRTRec
            addq.w  #1,D7
.L19:
            dbra    D1,.L16
            cmpi.w  #$C,D7
            beq.w   .L55
            move.b  D4,D2
            andi.b  #7,D4
            tst.b   D6
            beq.b   .L21
            move.b  ($31,A0),D3
            subq.w  #2,SP
            movea.l SP,A0
            _GetVideoDefault
            cmp.b   (A0),D3
            bne.b   .L20
            bclr    #4,D2
            cmp.b   (1,A0),D2
            bne.b   .L20
            bset    #4,D2
            move.b  D2,(1,A0)
            _SetVideoDefault
            bclr    #4,D2
.L20:
            addq.w  #2,SP
.L21:
            cmpi.b  #2,D4
            beq.b   .L22
            cmpi.b  #3,D4
            beq.b   .L23
            cmpi.b  #1,D4
            beq.b   .L24
            cmpi.b  #4,D4
            beq.b   .L25
            cmpi.b  #0,D4
            beq.b   .L29
            lea     pGetClockType.L13,A0
            bra.b   .L33
.L22:
            lea     pGetClockType.L12,A0
            bra.b   .L33
.L23:
            lea     pGetClockType.L15,A0
            bra.b   .L33
.L24:
            lea     pGetClockType.L14,A0
            bra.b   .L33
.L25:
            btst    #5,D2
            beq.b   .L27
            btst    #3,D2
            beq.b   .L26
            lea     pGetClockType.L9,A0
            bra.b   .L33
.L26:
            lea     pGetClockType.L11,A0
            bra.b   .L33
.L27:
            btst    #3,D2
            beq.b   .L28
            lea     pGetClockType.L8,A0
            bra.b   .L33
.L28:
            lea     pGetClockType.L10,A0
            bra.b   .L33
.L29:
            btst    #5,D2
            beq.b   .L31
            btst    #3,D2
            beq.b   .L30
            lea     pGetClockType.L5,A0
            bra.b   .L33
.L30:
            lea     pGetClockType.L7,A0
            bra.b   .L33
.L31:
            btst    #3,D2
            beq.b   .L32
            lea     pGetClockType.L4,A0
            bra.b   .L33
.L32:
            lea     pGetClockType.L6,A0
.L33:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            movea.l A1,A3
            adda.l  #$200208,A1
            moveq   #0,D0
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            movea.l A3,A1
            adda.l  #$200000,A1
            movea.l A1,A2
            move.w  #3,D1
            moveq   #0,D0
.L34:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L34
            bsr.w   pGetClockType
            move.l  D0,-(SP)
            movea.l A3,A1
            adda.l  #$200300,A1
            cmpi.w  #0,D0
            bne.b   .L36
            move.w  #2,D1
            moveq   #0,D0
.L35:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L35
            adda.w  #$10,A0
            bra.b   .L38
.L36:
            addq.l  #6,A0
            move.w  #$F,D1
            moveq   #0,D0
.L37:
            move.b  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L37
.L38:
            adda.w  #0,A2
            move.l  (SP)+,D0
            cmpi.w  #0,D0
            bne.b   .L39
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$2000,D1
            move.l  D1,(A2)
.L39:
            move.w  TimeDBRA,D1
.L40:
            dbra    D1,.L40
            move.w  TimeDBRA,D1
.L41:
            dbra    D1,.L41
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$8000,D1
            move.l  D1,(A2)
            movea.l A3,A1
            adda.l  #$200100,A1
            move.w  #$E,D1
            moveq   #0,D0
.L42:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L42
            move.l  #6,(A1)
            move.l  #7,(A1)
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #8,D1
            move.l  D1,(A2)
            movea.l A2,A4
            movea.l A3,A1
            move.l  #$200204,D1
            clr.l   (-4,A1,D1.l)
            bra.b   .L43
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            bra.b   .L44
.L43:
            move.l  #$FF,(0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
.L44:
            movea.l A3,A2
            andi.b  #3,D4
            cmpi.b  #0,D4
            beq.b   .L46
            move.w  #$A00,D3
            lsr.w   #2,D3
            subq.w  #1,D3
.L45:
            clr.l   (A2)+
            dbra    D3,.L45
            bra.b   .L48
.L46:
            move.w  #$2000,D3
            lsr.w   #2,D3
            subq.w  #1,D3
.L47:
            move.l  #$FFFFFFFF,(A2)+
            dbra    D3,.L47
.L48:
            movea.l A3,A2
            cmpi.b  #0,D4
            beq.b   .L49
            adda.w  #$A00,A2
            bra.b   .L50
.L49:
            adda.w  #$2000,A2
.L50:
            move.l  #$AAAAAAAA,D5
            move.w  (A0)+,D3
.L51:
            move.w  (A0),D1
.L52:
            move.l  D5,(A2)+
            dbra    D1,.L52
            not.l   D5
            dbra    D3,.L51
            btst    #3,D2
            bne.b   .L54
            move.w  #$39FF,D1
.L53:
            move.l  #$FFFFFFFF,(A2)+
            dbra    D1,.L53
.L54:
            move.l  (A4),D1
            andi.w  #$F1FF,D1
            ori.w   #$40,D1
            move.l  D1,(A4)
            move.w  (SP)+,D0
            _SwapMMUMode
.L55:
            lea     ($38,SP),SP
            movem.l (SP)+,D0-D7/A0-A4
            rts
GetXtndSense:
            movem.l D2-D6,-(SP)
            clr.w   D0
            moveq   #9,D5
            moveq   #4,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D0
            lsl.b   #2,D0
            moveq   #2,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D6
            andi.b  #1,D6
            lsr.b   #1,D2
            or.b    D6,D2
            or.b    D2,D0
            lsl.b   #2,D0
            moveq   #1,D3
            lsl.l   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            lsr.l   #1,D2
            or.b    D2,D0
            movem.l (SP)+,D2-D6
            rts
pGetClockType:
            move.l  A0,-(SP)
            movea.l A3,A0
            adda.l  #$200300,A0
            move.l  #$55,(A0)
            move.l  (A0),D0
            andi.w  #$FF,D0
            cmpi.w  #$55,D0
            bne.b   .L1
            move.l  #$AA,(A0)
            move.l  (A0),D0
            andi.w  #$FF,D0
            cmpi.w  #$AA,D0
            bne.b   .L1
            clr.w   D0
            bra.b   .L2
.L1:
            move.w  #$FFFF,D0
.L2:
            movea.l (SP)+,A0
            rts
.L3:
            dc.w    $84A4,$81A1,$86A6,$83A3,$82A2,$8CAC
.L4:
            dc.b    $00,$80,$81,$12,$00,$E0,$01,$00,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$023F
            dc.w    $00FF
.L5:
            dc.b    $00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$023F
            dc.w    $00FF
.L6:
            dc.b    $00,$80,$81,$12,$00,$E0,$01,$00,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0114,$0266,$007D,$0043,$0082,$0003
            dc.w    0,$0205,$0062,$0005,$0005,$005E,$0193,$01DF
            dc.w    $00FF
.L7:
            dc.b    $00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0114,$0266,$007D,$0043,$0082,$0003
            dc.w    0,$0205,$0062,$0005,$0005,$005E,$0193,$01DF
            dc.w    $00FF
.L8:
            dc.w    $0080,$0112,$00E0,$0100,$0100,$001B,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0004,$0D06,$0401,0
            dc.w    $0003,0,$0136,$027E,$0012,$003A,$003A,$0003
            dc.w    0,$01E0,$0021,$0006,$0006,$006E,$014A,$01DF
            dc.w    $00FF
.L9:
            dc.w    $00C1,$0132,$00F8,$00E0,$0100,$006C,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$0136,$027E,$0012,$003A,$003A,$0003
            dc.w    0,$01E0,$0021,$0006,$0006,$006E,$014A,$01DF
            dc.w    $00FF
.L10:
            dc.w    $0080,$0112,$00E0,$0100,$0100,$001B,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0004,$0D06,$0401,0
            dc.w    $0003,0,$00F4,$01FE,$0054,$003A,$0078,$0003
            dc.w    0,$01B0,$0051,$0006,$0006,$006E,$014A,$017F
            dc.w    $00FF
.L11:
            dc.w    $00C1,$0132,$00F8,$00E0,$0100,$006C,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$00F4,$01FE,$0054,$003A,$0078,$0003
            dc.w    0,$01B0,$0051,$0006,$0006,$006E,$014A,$017F
            dc.w    $00FF
.L12:
            dc.w    $0080,$0082,$00E0,$0050,$0010,$002F,$00F0,0
            dc.b    $0E,$05,$00,$00,$0F
            ds.b    4
            dc.b    $03,$0D,$06,$04,$01,$00,$00,$00,$03,$00,$00,$01,$00,$01,$FE,$00
            dc.b    $2A,$00,$1E,$00,$32,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00
            dc.b    $02,$00,$04,$02,$60,$01,$7F,$00,$0F
.L13:
            dc.w    $00C0,$0082,$00F8,$0050,$0014,$0011,$002D,0
            dc.w    $0F07,0,$0501,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$0050,$009E,$000A,$000E,$001A,$0003
            dc.w    0,$03C0,$004E,$0006,$0006,$0004,$00C8,$01DF
            dc.w    $0013
.L14:
            dc.w    $00A0,$0002,$00F0,$0050,$0014,$002B,$003C,0
            dc.w    $0E07,0,$0601,0,$0001,$0D06,$0401,0
            dc.w    $0003,0,$00A0,$013E,$0012,$0026,$0022,$0003
            dc.w    0,$06CC,$0054,$0006,$0006,0,$0178,$0365
            dc.w    $0013
.L15:
            dc.w    $00C0,$2002,$00F8,$0050,$0024,$0005,$0004,0
            dc.w    $0E0B,0,$0301,0,$0001,$0D06,$0401,0
            dc.w    $0003,0,$0090,$011E,$0016,$001E,$0012,$0003
            dc.w    0,$06CC,$004E,$0006,$0006,0,$014C,$0365
            dc.w    $0023
            ds.b    14
TFBDRVR:
            dc.b    $4C
            ds.b    8
            dc.b    $2E,$00,$00,$01,$1E,$05,$8E,$00,$EA,$18
            dc.b    '.Display_Video_Apple_TFB'
            dc.b    $00,$00,$06,$26,$49,$70,$18,$A4,$40,$70,$18,$A7,$22,$66,$00,$00
            dc.b    $AC,$27,$48,$00,$14,$A0,$29,$22,$50,$49,$FA,$08,$EC,$70,$10,$A7
            dc.b    $1E,$66,$00,$00,$92,$23,$48,$00,$0C,$31,$7C,$00,$06,$00,$04,$21
            dc.b    $4C,$00,$08,$21,$6B,$00,$2A,$00,$0C,$70,$00,$10,$2B,$00,$28,$A0
            dc.b    $75,$66,$6C,$70,$00,$30,$3C,$01,$0C,$A7,$1E,$66,$56,$23,$48,$00
            dc.b    $10,$42,$98,$70,$01,$20,$C0,$20,$FC,$01,$00,$00,$08,$30,$3C,$00
            dc.b    $FF,$12,$00,$46,$01,$10,$C1,$51,$C8,$FF,$F8,$42,$69,$00,$14,$20
            dc.b    $6B,$00,$2A,$22,$3C,$00,$04,$23,$FC,$21,$BC,$4D,$41,$43,$32,$18
            dc.b    $00,$2F,$3C,$FF,$FF,$FF,$FF,$42,$9F,$20,$30,$18,$00,$0C,$80,$4D
            dc.b    $41,$43,$32,$56,$E9,$00,$16,$D1,$FC,$00,$0A,$00,$03,$42,$10,$70
            dc.b    $00
.L1:
            rts
            movea.l ($C,A1),A0
            moveq   #0,D0
            move.b  ($28,A3),D0
            _SIntRemove
            movea.l ($C,A1),A0
            _DisposPtr
            movea.l ($14,A3),A0
            _DisposHandle
            moveq   #-$17,D0
            bra.b   .L1
            movea.l ($2A,A1),A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            movea.l ($14,A1),A2
            movea.l (A2),A2
            movea.l ($C,A2),A0
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntRemove
            movea.l ($C,A2),A0
            _DisposPtr
            movea.l ($10,A2),A0
            _DisposPtr
            movea.l ($14,A1),A0
            _DisposHandle
            moveq   #0,D0
            rts
            movem.l D4/A0/A4,-(SP)
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #7,D0
            bhi.b   .L4
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L7-.L2
            dc.w    .L5-.L2
            dc.w    .L8-.L2
            dc.w    sub_40897D3E.L3-.L2
            dc.w    sub_40897D3E.L20-.L2
            dc.w    sub_40897D3E.L29-.L2
            dc.w    sub_40897D3E.L30-.L2
            dc.w    sub_40897D3E.L31-.L2
.L3:
            addq.w  #4,SP
.L4:
            moveq   #-$11,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movem.l (SP)+,D4/A0/A4
            bra.w   WaitVSync_TFBDriver.L4
.L7:
            bsr.w   sub_40898346
            move.w  #$80,(A2)
            move.w  #1,D1
            moveq   #0,D0
            move.w  D0,(6,A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            bsr.w   TFBSetDepth
            bsr.w   TFBSetPage
            move.l  (8,A3),(8,A2)
            bsr.w   GrayScreen_TFBDriver
            bra.b   .L5
.L8:
            move.w  (A2),D1
            bsr.w   ChkMode_TFBDriver
            bne.b   .L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.b   .L4
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (A2),D2
            cmp.w   (4,A3),D2
            beq.b   .L9
            bsr.b   sub_40897D3E
            bsr.w   TFBSetDepth
            bsr.w   TFBSetPage
            bra.b   .L10
.L9:
            bsr.w   TFBSetPage
.L10:
            move.l  (8,A3),(8,A2)
            bra.b   .L5
sub_40897D3E:
            movem.l D0-D1/A0-A1,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            bsr.w   WaitVSync_TFBDriver
            movea.l ($14,A1),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            move.w  (4,A0),D0
            lea     ($C,A0),A0
            adda.w  D0,A0
            move.w  #$80,D1
            move.b  (0,A0,D1.w),D1
            not.b   D1
            movea.l ($2A,A1),A0
            adda.l  #$90018,A0
            move.w  #$FF,D0
.L2:
            move.b  D1,(A0)
            move.b  D1,(A0)
            move.b  D1,(A0)
            dbra    D0,.L2
            move    (SP)+,SR
            movem.l (SP)+,D0-D1/A0-A1
            rts
.L3:
            move.l  (A2),D0
            beq.w   TFBDRVR.L4
            movem.l D5-D7/A5-A6,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            move.w  ($14,A0),D5
            movea.l ($10,A0),A0
            move.w  (4,A0),D0
            lea     ($C,A0),A4
            adda.w  D0,A4
            movea.l A4,A5
            movea.l A4,A6
            cmpi.w  #1,(6,A0)
            beq.b   .L4
            move.w  (8,A0),D0
            move.w  ($A,A0),D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L4:
            suba.w  #$80,SP
            bsr.w   CvtIndex
            movea.l (A2),A0
            move.w  (4,A2),D1
            bmi.b   .L7
            cmpi.w  #$FF,D6
            bne.b   .L5
            cmpi.w  #4,(6,A2)
            bgt.w   .L13
.L5:
            movea.l SP,A3
            move.w  (6,A2),D0
.L6:
            move.w  D1,(A3)+
            move.l  (A0)+,D2
            move.w  D2,(A3)+
            move.l  (A0)+,(A3)+
            addq.w  #1,D1
            dbra    D0,.L6
            movea.l SP,A0
.L7:
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L8
            ori     #$200,SR
            andi    #$FAFF,SR
.L8:
            bsr.w   WaitVSync_TFBDriver
            move.w  (6,A2),D0
            movea.l ($2A,A1),A3
            adda.l  #$90018,A3
.L9:
            move.l  (A0)+,D2
            swap    D2
            moveq   #-1,D1
            move.w  D2,D1
            cmp.w   D6,D1
            bhi.b   .L11
            rol.l   D7,D1
            move.b  D1,(4,A3)
            swap    D2
            move.l  (A0)+,D3
            move.l  D3,D4
            swap    D3
            tst.w   D5
            bpl.b   .L10
            mulu.w  #$4CCC,D2
            mulu.w  #$970A,D3
            mulu.w  #$1C28,D4
            add.l   D3,D2
            add.l   D4,D2
            rol.l   #8,D2
            andi.w  #$FF,D2
            move.b  (0,A4,D2.w),D2
            not.b   D2
            move.b  D2,(A3)
            move.b  D2,(A3)
            move.b  D2,(A3)
            dbra    D0,.L9
            bra.b   .L12
.L10:
            ror.w   #8,D2
            moveq   #0,D1
            move.b  D2,D1
            move.b  (0,A4,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
            ror.w   #8,D3
            moveq   #0,D1
            move.b  D3,D1
            move.b  (0,A5,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
            ror.w   #8,D4
            moveq   #0,D1
            move.b  D4,D1
            move.b  (0,A6,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
.L11:
            dbra    D0,.L9
.L12:
            move    (SP)+,SR
            lea     ($80,SP),SP
            movem.l (SP)+,D5-D7/A5-A6
            bra.w   TFBDRVR.L5
.L13:
            move.l  SP,D1
            move.l  D1,D0
            neg.w   D0
            andi.w  #3,D0
            beq.b   .L14
            suba.w  D0,SP
.L14:
            move.l  D1,-(SP)
            _StackSpace
            cmpi.l  #$500,D0
            blt.w   TFBDRVR.L3
            suba.w  #$400,SP
            move.w  (4,A2),D1
            lea     (0,SP,D1.w*4),A3
            move.w  (6,A2),D0
            movea.l (A2),A0
.L15:
            cmp.w   D6,D1
            bgt.b   .L17
            tst.w   D5
            bpl.b   .L16
            move.l  (A0)+,D2
            move.w  (A0)+,D3
            move.w  (A0)+,D4
            mulu.w  #$4CCC,D2
            mulu.w  #$970A,D3
            mulu.w  #$1C28,D4
            add.l   D3,D2
            add.l   D4,D2
            rol.l   #8,D2
            moveq   #0,D3
            move.b  D2,D3
            move.b  (0,A4,D3.w),D2
            move.b  D2,D3
            lsl.l   #8,D3
            move.b  D2,D3
            lsl.l   #8,D3
            move.b  D2,D3
            move.l  D3,(A3)+
            addq.w  #1,D1
            dbra    D0,.L15
            bra.b   .L17
.L16:
            moveq   #0,D2
            move.b  (6,A0),D2
            move.b  (0,A6,D2.w),D3
            lsl.l   #8,D3
            move.b  (4,A0),D2
            move.b  (0,A5,D2.w),D3
            lsl.l   #8,D3
            move.b  (2,A0),D2
            move.b  (0,A4,D2.w),D3
            move.l  D3,(A3)+
            addq.w  #1,D1
            addq.w  #8,A0
            dbra    D0,.L15
.L17:
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L18
            ori     #$200,SR
            andi    #$FAFF,SR
.L18:
            movea.l A3,A0
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A3
            adda.l  #$90003,A3
            moveq   #0,D1
            move.b  (5,A2),D1
            not.b   D1
            move.w  (6,A2),D0
            sub.w   D0,D1
            not.b   D1
            move.b  D1,($19,A3)
            adda.w  #$15,A3
.L19:
            move.l  -(A0),D1
            not.l   D1
            move.b  D1,(A3)
            lsr.l   #8,D1
            move.b  D1,(A3)
            lsr.l   #8,D1
            move.b  D1,(A3)
            dbra    D0,.L19
            move    (SP)+,SR
            lea     ($400,SP),SP
            movea.l (SP)+,SP
            lea     ($80,SP),SP
            movem.l (SP)+,D5-D7/A5-A6
            bra.w   TFBDRVR.L5
.L20:
            move.l  A1,-(SP)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.l  (A2),D0
            beq.w   .L26
            movea.l D0,A1
            tst.l   (A1)
            bne.b   .L25
            cmpi.w  #8,($A,A1)
            bne.b   .L25
            cmpi.w  #$100,(8,A1)
            bne.b   .L25
            movea.l ($10,A3),A0
            move.w  (4,A1),D0
            cmp.w   (4,A0),D0
            bne.b   .L21
            move.w  (6,A1),D0
            cmp.w   (6,A0),D0
            beq.b   .L22
            bgt.b   .L21
            _DisposPtr
            clr.l   ($10,A3)
.L21:
            move.w  #$100,D0
            mulu.w  (6,A1),D0
            add.w   (4,A1),D0
            addi.w  #$C,D0
            _NewPtrSys
            bne.b   .L25
            move.l  ($10,A3),D0
            move.l  A0,($10,A3)
            tst.l   D0
            beq.b   .L22
            movea.l D0,A0
            _DisposPtr
            movea.l ($10,A3),A0
.L22:
            move.w  (6,A1),D0
            move.w  (4,A1),D1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.w  #$100,D2
            mulu.w  D0,D2
            add.w   D1,D2
            subq.w  #1,D2
.L23:
            move.b  (A1)+,(A0)+
            dbra    D2,.L23
.L24:
            movea.l (SP)+,A1
            bra.w   TFBDRVR.L5
.L25:
            movea.l (SP)+,A1
            bra.w   TFBDRVR.L4
.L26:
            movea.l ($10,A3),A0
            move.w  (4,A0),D0
            move.w  (6,A0),D2
            subq.w  #1,D2
            lea     ($C,A0),A0
            adda.w  D0,A0
.L27:
            move.w  #$FF,D0
.L28:
            move.b  D0,(A0)
            not.b   (A0)+
            dbra    D0,.L28
            dbra    D2,.L27
            bra.b   .L24
.L29:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D1
            bsr.w   ChkMode_TFBDriver
            bne.w   TFBDRVR.L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.w   TFBDRVR.L4
            bsr.w   GrayScreen_TFBDriver
            bra.w   TFBDRVR.L5
.L30:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  ($14,A3),D0
            move.b  (A2),D1
            bfins   D1,D0{16:1}
            move.w  D0,($14,A3)
            bra.w   TFBDRVR.L5
.L31:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  ($14,A3),D0
            move.b  (A2),D1
            bfins   D1,D0{17:1}
            move.w  D0,($14,A3)
            btst    #$E,D0
            beq.b   .L32
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            movea.l ($C,A3),A0
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntRemove
            bra.w   TFBDRVR.L5
.L32:
            movea.l ($C,A3),A0
            lea     GrayScreen_TFBDriver.L6,A4
            move.w  #6,(4,A0)
            move.l  A4,(8,A0)
            move.l  ($2A,A1),($C,A0)
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntInstall
            bne.w   TFBDRVR.L4
            movea.l ($2A,A1),A0
            adda.l  #$A0003,A0
            clr.b   (A0)
            bra.w   TFBDRVR.L5
            move.l  A0,-(SP)
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #8,D0
            bhi.b   .L34
            lsl.w   #1,D0
            move.w  .L33(PC,D0.w),D0
            jmp     .L33(PC,D0.w)
.L33:
            dc.w    .L34-.L33
            dc.w    .L34-.L33
            dc.w    .L37-.L33
            dc.w    .L38-.L33
            dc.w    GECom.L3-.L33
            dc.w    GECom.L6-.L33
            dc.w    GECom.L7-.L33
            dc.w    GECom.L8-.L33
            dc.w    GECom.L9-.L33
.L34:
            moveq   #-$12,D0
            bra.b   .L36
.L35:
            moveq   #0,D0
.L36:
            movea.l (SP)+,A0
            bra.w   WaitVSync_TFBDriver.L4
.L37:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),(A2)
            move.w  (6,A3),(6,A2)
            move.l  (8,A3),(8,A2)
            bra.b   .L35
.L38:
            move.l  (A2),D0
            beq.b   .L34
            movea.l D0,A0
            move.w  (6,A2),D0
            cmpi.w  #$FFFF,(4,A2)
            beq.b   GECom
            move.w  D0,D1
            move.w  D0,D2
            add.w   (4,A2),D2
.L39:
            move.w  D2,(0,A0,D1.w*8)
            subq.w  #1,D2
            dbra    D1,.L39
GECom:
            movem.l D6-D7,-(SP)
            bsr.w   CvtIndex
            movea.l ($2A,A1),A3
            adda.l  #$90003,A3
.L1:
            move.w  (A0),D1
            cmp.w   D6,D1
            bhi.b   .L2
            ori.l   #$FFFF0000,D1
            rol.l   D7,D1
            move.b  D1,($19,A3)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(2,A0)
            move.b  D1,(3,A0)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(4,A0)
            move.b  D1,(5,A0)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(6,A0)
            move.b  D1,(7,A0)
.L2:
            addq.l  #8,A0
            dbra    D0,.L1
            movem.l (SP)+,D6-D7
            bra.w   sub_40897D3E.L35
.L3:
            move.w  (A2),D1
            bsr.w   ChkMode_TFBDriver
            bne.w   sub_40897D3E.L34
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            bne.b   .L4
            moveq   #4,D0
            bra.b   .L5
.L4:
            moveq   #3,D0
.L5:
            divu.w  D1,D0
            addq.w  #1,D0
            move.w  D0,(6,A2)
            bra.w   sub_40897D3E.L35
.L6:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D1
            bsr.w   ChkMode_TFBDriver
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.w   sub_40897D3E.L34
            move.w  (4,A3),D1
            subi.w  #$80,D1
            lea     GrayScreen_TFBDriver.L5,A0
            mulu.w  (4,A0,D1.w*8),D0
            mulu.w  (6,A0,D1.w*8),D0
            moveq   #$20,D1
            add.l   D1,D0
            add.l   ($2A,A1),D0
            move.l  D0,(8,A2)
            bra.w   sub_40897D3E.L35
.L7:
            clr.w   (A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            tst.w   ($14,A3)
            bpl.w   sub_40897D3E.L35
            move.b  #1,(A2)
            bra.w   sub_40897D3E.L35
.L8:
            clr.w   (A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            btst    #$E,($14,A3)
            beq.w   sub_40897D3E.L35
            move.b  #1,(A2)
            bra.w   sub_40897D3E.L35
.L9:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.l  ($10,A3),(A2)
            bra.w   sub_40897D3E.L35
WaitVSync_TFBDriver:
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            movea.l ($2A,A1),A0
            adda.l  #$D0003,A0
.L2:
            move.b  (A0),D0
            btst    #0,D0
            bne.b   .L2
.L3:
            move.b  (A0),D0
            btst    #0,D0
            beq.b   .L3
            move    (SP)+,SR
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            rts
.L4:
            btst    #9,(6,A0)
            beq.b   .L5
            rts
.L5:
            movea.l JIODone,A0
            jmp     (A0)
CvtIndex:
            movem.l D0/D4/A3,-(SP)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D7
            subi.w  #$80,D7
            moveq   #1,D4
            lsl.w   D7,D4
            move.w  D4,D0
            subq.w  #1,D0
            moveq   #2,D6
            lsl.w   D0,D6
            subq.w  #1,D6
            moveq   #8,D7
            sub.w   D4,D7
            movem.l (SP)+,D0/D4/A3
            rts
ChkMode_TFBDriver:
            subi.w  #$80,D1
            bmi.b   .L2
            cmpi.w  #3,D1
            bgt.b   .L2
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            cmpi.w  #8,D1
            bne.b   .L1
            move.l  A0,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            movea.l (SP)+,A0
            bne.b   .L2
.L1:
            cmp.w   D1,D1
.L2:
            rts
ChkPage_TFBDriver:
            movem.l D2/A0,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            bne.b   .L1
            moveq   #4,D2
            bra.b   .L2
.L1:
            moveq   #3,D2
.L2:
            divu.w  D1,D2
            cmp.w   D2,D0
            sgt     D2
            tst.b   D2
            movem.l (SP)+,D2/A0
            rts
sub_40898346:
            movem.l D0/A0-A1,-(SP)
            movea.l ($2A,A1),A0
            adda.l  #$8FFFF,A0
            lea     .L2,A1
            moveq   #$F,D0
.L1:
            move.b  (A1)+,(A0)
            subq.w  #4,A0
            dbra    D0,.L1
            movem.l (SP)+,D0/A0-A1
            rts
.L2:
            dc.w    $DFB8,$FFFF,$E11A,$88B9,$FAFD,$FDFE,$F0BE,$FA37
TFBSetDepth:
            movem.l D0-D2/A0-A1,-(SP)
            move.w  (A2),(4,A3)
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A0
            adda.l  #$80003,A0
            cmpi.w  #8,D1
            bgt.b   .L4
            moveq   #0,D0
.L1:
            lsr.w   #1,D1
            bcs.b   .L2
            addq.w  #1,D0
            bra.b   .L1
.L2:
            move.b  #$B7,($3C,A0)
            lea     .L5,A1
            lsl.w   #4,D0
            adda.w  D0,A1
            moveq   #$F,D0
.L3:
            move.b  (A1)+,D1
            not.b   D1
            move.b  D1,(A0)
            addq.w  #4,A0
            dbra    D0,.L3
.L4:
            movem.l (SP)+,D0-D2/A0-A1
            rts
.L5:
            dc.w    $2047,$0008,$1EE5,$7746,$0502,$0201,$0F41,$05C8
            dc.w    $4047,$0008,$3CE5,$7746,$0506,$0604,$2004,$0BD8
            dc.w    $8047,$0008,$78E5,$7746,$050E,$0E0A,$428A,$16E8
            dc.w    $0047,$0008,$F0E5,$7746,$051E,$1E16,$8696,$2DF9
TFBSetPage:
            movem.l D0-D1/A0-A1,-(SP)
            move.w  D0,(6,A3)
            move.w  (A2),D1
            subi.w  #$80,D1
            lea     GrayScreen_TFBDriver.L5,A0
            mulu.w  (4,A0,D1.w*8),D0
            mulu.w  (6,A0,D1.w*8),D0
            moveq   #$20,D1
            add.l   D1,D0
            move.l  D0,D1
            movea.l ($2A,A1),A0
            add.l   A0,D0
            move.l  D0,(8,A3)
            lsr.l   #2,D1
            adda.l  #$80003,A0
            not.w   D1
            move.b  D1,($C,A0)
            lsr.w   #8,D1
            move.b  D1,(8,A0)
            movem.l (SP)+,D0-D1/A0-A1
            rts
GrayScreen_TFBDriver:
            movem.l D0-D4/A0-A1,-(SP)
            move.w  (4,A3),D1
            subi.w  #$80,D1
            cmpi.w  #3,D1
            bne.b   .L1
            tst.b   ($16,A3)
            bne.b   .L4
.L1:
            lea     .L5,A1
            move.l  (0,A1,D1.w*8),D0
            move.w  (4,A1,D1.w*8),D4
            move.w  (6,A1,D1.w*8),D3
            subq.w  #1,D3
            move.l  D0,D1
            not.l   D1
            movea.l (8,A3),A1
.L2:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L3:
            move.l  D0,(A0)+
            dbra    D2,.L3
            exg     D0,D1
            adda.w  D4,A1
            dbra    D3,.L2
.L4:
            movem.l (SP)+,D0-D4/A0-A1
            rts
.L5:
            dc.w    $AAAA,$AAAA,$0080,$01E0,$CCCC,$CCCC,$0100,$01E0
            dc.w    $F0F0,$F0F0,$0200,$01E0,$FF00,$FF00,$0400,$01E0
.L6:
            dc.w    $2049,$2009,$D1FC,$000A,$0003,$4210,$E198,$0240
            dc.w    $000F,$2078,$0D28,$4E90,$7001,$4E75
TFBDRVRSIZE:
            dc.w    0,$094E
            ds.b    14
TFBPRIMARYINIT:
            dc.w    $6020
.L1:
            dc.w    $DFB8,$FFFF,$E11A,$88B9,$FAFD,$FDFE,$F0BE,$FA37
.L2:
            dc.w    $2047,$0008,$1EE5,$7746,$0502,$0201,$0F41,$05C8
            movem.l D0-D3/A0-A2,-(SP)
            move.w  #1,(2,A0)
            movea.l A0,A3
            moveq   #0,D0
            move.b  (A0),D0
            lsl.w   #4,D0
            or.b    (A0),D0
            ori.w   #$F00,D0
            swap    D0
            lsl.l   #4,D0
            movea.l D0,A2
            movea.l A2,A0
            adda.l  #$8FFFF,A0
            lea     .L1,A1
            moveq   #$F,D0
.L3:
            move.b  (A1)+,(A0)
            subq.w  #4,A0
            dbra    D0,.L3
            movea.l A2,A0
            adda.l  #$80003,A0
            lea     .L2,A1
            moveq   #$F,D0
.L4:
            move.b  (A1)+,D1
            not.b   D1
            move.b  D1,(A0)
            addq.w  #4,A0
            dbra    D0,.L4
            movea.l A2,A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L5
            ori     #$200,SR
            andi    #$FAFF,SR
.L5:
            movea.l A2,A0
            adda.l  #$90003,A0
            moveq   #0,D0
            not.b   D0
            move.b  D0,($19,A0)
            adda.w  #$15,A0
            moveq   #-1,D1
            move.w  #$17F,D0
.L6:
            move.b  D1,(A0)
            dbra    D0,.L6
            moveq   #0,D1
            move.w  #$17F,D0
.L7:
            move.b  D1,(A0)
            dbra    D0,.L7
            move    (SP)+,SR
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  (A3),($31,A0)
            clr.b   ($33,A0)
            move.l  #$423FC,D1
            move.l  #'MAC2',(0,A2,D1.l)
            move.l  #$FFFFFFFF,-(SP)
            addq.w  #4,SP
            move.l  (0,A2,D1.l),D0
            cmpi.l  #'MAC2',D0
            beq.b   .L8
            move.b  #$80,($32,A0)
            bra.b   .L9
.L8:
            clr.b   (0,A2,D1.l)
            move.b  #$81,($32,A0)
.L9:
            _sDeleteSRTRec
            bne.b   .L10
            move.w  #2,(2,A3)
.L10:
            lea     ($38,SP),SP
            move.l  #$AAAAAAAA,D0
            move.l  D0,D1
            not.l   D1
            move.w  #$80,D4
            move.w  #$7FF,D3
            movea.l A2,A1
.L11:
            movea.l A1,A0
            move.w  #$1F,D2
.L12:
            move.l  D0,(A0)+
            dbra    D2,.L12
            exg     D0,D1
            adda.w  D4,A1
            dbra    D3,.L11
            movem.l (SP)+,D0-D3/A0-A2
            rts
            ds.b    6

            EVEN
