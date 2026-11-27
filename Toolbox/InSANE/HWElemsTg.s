RTan:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   BadBoys
            movem.l A1,-(SP)
            movea.l A0,A1
            fmove.x (FPKPI2.w,PC),FP1
            frem.x  FP1,FP0
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     (TANP.w,PC),A0
            bsr.w   PolyEval
            fmove.x FP1,FP2
            lea     (TANQ.w,PC),A0
            bsr.w   PolyEval
            fdiv.x  FP1,FP2
            fmul.x  FP0,FP2
            fmove.x FP0,FP1
            fmul.x  FP3,FP1
            fmul.x  FP1,FP2
            fcmp.s  #"$3E800000",FP0
            fbgt.w  BigBabe
            fmul.x  FP3,FP0
            fdiv.w  #3,FP0
            fadd.x  FP2,FP0
            fadd.x  FP3,FP0
            bra.b   LastCheck
BigBabe:
            fmove.x FP3,FP1
            fadd.x  #"$BFFEBFFEC000000000000000",FP1
            fdiv.w  #3,FP1
            fmul.x  FP0,FP1
            fadd.x  FP2,FP1
            fdiv.w  #4,FP0
            fadd.x  FP1,FP0
            fadd.x  FP3,FP0
LastCheck:
            fmove.l FPSR,D0
            swap    D0
            lsr.b   #1,D0
            bcc.b   .L8
            fmove.w #$FFFF,FP1
            fdiv.x  FP0,FP1
            fmove.x FP1,FP0
            btst    #$A,D0
            beq.b   .L8
            fneg.x  FP0,FP0
.L8:
            bfextu  (A1){1:16},D0
            movea.l (SP)+,A1
            beq.b   .L9
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L9:
            move.l  #$280000,D0
            jmp     (A4)
BadBoys:
            bmi.b   tgOut
            btst    #29,D0
            bne.b   tgOut
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
tgOut:
            moveq   #0,D0
            jmp     (A4)
