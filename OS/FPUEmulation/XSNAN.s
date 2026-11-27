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
