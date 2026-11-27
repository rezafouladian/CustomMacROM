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
