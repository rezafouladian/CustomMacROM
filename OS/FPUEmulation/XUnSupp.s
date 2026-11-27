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
