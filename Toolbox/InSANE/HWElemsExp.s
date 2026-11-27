RExp21x:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   SpecialExp1Input
            bfextu  (A0){1:16},D0
            beq.w   Small21
            fint.x  FP0,FP3
            fsne    D1
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            fsub.x  FP3,FP0
CommonBackEnd:
            bsr.w   ExpApprox
            tst.b   D1
            beq.b   ResultDelivered
            moveq   #1,D1
            fadd.l  D1,FP0
            fmove.l #$4000,FP1
            fcmp.x  FP3,FP1
            fbne.w  .L9
            fmove.l #$2000,FP3
            fscale.x FP3,FP0
.L9:
            fscale.x FP3,FP0
            fsub.l  D1,FP0
            moveq   #$20,D0
ResultDelivered:
            jmp     (A4)
RExp1x:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   SpecialExp1Input
            bfextu  (A0){1:16},D0
            beq.b   Smalle1
            bsr.w   Split
            btst    #6,D0
            beq.b   CommonBackEnd
            move.l  #$80000,D0
            move.w  (A0),D1
            bmi.b   .L12
            move.l  #$7F800000,D1
            fmove.s D1,FP0
            bra.b   ResultDelivered
.L12:
            move.b  #$40,D0
            fmove.l #$FFFFFFFF,FP0
            jmp     (A4)
Small21:
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
Smalle1:
            move.l  #$280000,D0
            jmp     (A4)
SpecialExp1Input:
            bmi.b   .L16
            btst    #$1E,D0
            beq.b   .L16
            bcc.b   .L16
            moveq   #-1,D0
            fmove.l D0,FP0
.L16:
            moveq   #0,D0
            jmp     (A4)
SpecialExpInput:
            bpl.b   .L18
            fmovecr.x #$32,FP0
            bra.b   .L19
.L18:
            btst    #$1E,D0
            beq.b   .L19
            bcc.b   .L19
            fmovecr.x #$F,FP0
.L19:
            moveq   #0,D0
            jmp     (A4)
ExpApprox:
            fbeq.w  .L1
            fmove.x FP0,FP2
            fmul.x  FP2,FP0
            lea     (EXP21P.w,PC),A0
            bsr.w   PolyEval
            fmul.x  FP1,FP2
            lea     (EXP21Q.w,PC),A0
            bsr.w   PolyEval
            fsub.x  FP2,FP1
            fscale.b #1,FP2
            fdiv.x  FP1,FP2
            fmove.x FP2,FP0
            move.l  #$80000,D0
            ori.l   #$20,D0
.L1:
            rts
Split:
            fmovecr.x #$30,FP1
            fmove.x FP0,FP3
            frem.x  FP1,FP0
            fsub.x  FP0,FP3
            fdiv.x  FP1,FP3
            fint.x  FP3,FP3
            fsne    D1
            fdiv.x  FP1,FP0
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            rts
RExp2x:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   SpecialExpInput
            fint.x  FP0,FP3
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            fsub.x  FP3,FP0
BackEnd:
            bsr.w   ExpApprox
            moveq   #1,D1
            fadd.l  D1,FP0
            fmove.l #$FFFFC001,FP1
            fsub.x  FP3,FP1
            fbgt.w  .L6
            fbeq.w  .L3
            bra.b   .L4
.L3:
            fmove.l #1,FP1
            fcmp.x  FP1,FP0
            fbge.w  .L4
            ori.l   #$200000,D0
.L4:
            fmove.l #$4000,FP1
            fcmp.x  FP3,FP1
            fbne.w  .L5
            fmove.l #$2000,FP3
            fscale.x FP3,FP0
.L5:
            fscale.x FP3,FP0
            jmp     (A4)
.L6:
            fmove.l #$FFFFC001,FP3
            fscale.x FP3,FP0
            fneg.x  FP1,FP1
            fscale.x FP1,FP0
            btst    #$13,D0
            beq.b   .L7
            ori.l   #$200000,D0
.L7:
            jmp     (A4)
RExpx:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   SpecialExpInput
            bsr.w   Split
            btst    #6,D0
            beq.w   BackEnd
            move.l  #$80000,D0
            move.w  (A0),D1
            bmi.b   .L9
            move.l  #$7F800000,D1
            fmove.s D1,FP0
            jmp     (A4)
.L9:
            move.l  #$280040,D0
            fmovecr.x #$F,FP0
            jmp     (A4)
