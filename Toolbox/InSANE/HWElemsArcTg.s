RAtan:
            movem.l A1-A3,-(SP)
            movea.l A0,A3
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bcs.b   .L13
            suba.l  A1,A1
            bra.b   .L14
.L13:
            movea.w #1,A1
.L14:
            bne.w   .L22
            fabs.x  FP0,FP0
            fcmp.w  #1,FP0
            fble.w  .L15
            movea.w #1,A2
            fmove.w #1,FP3
            fdiv.x  FP0,FP3
            fmove.x FP3,FP0
            bra.b   .L16
.L15:
            suba.l  A2,A2
            fmove.x FP0,FP3
.L16:
            fcmp.x  (FPKATNCONS.w,PC),FP0
            fbgt.w  .L21
            fmul.x  FP0,FP0
            lea     (ATANP.w,PC),A0
            bsr.w   PolyEval
            fmove.x FP1,FP2
            lea     (ATANQ.w,PC),A0
            bsr.w   PolyEval
            fdiv.x  FP1,FP2
            fmul.x  FP3,FP2
            fsub.x  FP2,FP3
            fmove.x FP3,FP0
.L17:
            move.w  A2,D1
            beq.b   .L18
            fmove.x (FPKPI2.w,PC),FP1
            fsub.x  FP0,FP1
            fmove.x FP1,FP0
.L18:
            move.w  A1,D1
            beq.b   .L19
            fmul.b  #$FF,FP0
.L19:
            bfextu  (A3){1:16},D0
            movem.l (SP)+,A1-A3
            beq.b   .L20
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L20:
            move.l  #$80000,D0
            jmp     (A4)
.L21:
            fmovem.x FP4-FP5,-(SP)
            fmul.x  (FPKX2.w,PC),FP3
            fmove.w #1,FP2
            fdiv.x  FP3,FP2
            fadd.w  #1,FP2
            fadd.w  #1,FP3
            fmove.x FP0,FP1
            fsub.x  (FPKX2.w,PC),FP1
            fmove.x FP1,FP4
            fdiv.x  FP3,FP1
            fdiv.x  FP2,FP4
            fmove.x FP1,FP3
            fmul.x  FP1,FP1
            fmove.x FP0,FP2
            fmove.x FP1,FP0
            lea     (ATANP.w,PC),A0
            bsr.w   PolyEval
            fmove.x FP1,FP5
            lea     (ATANQ.w,PC),A0
            bsr.w   PolyEval
            fdiv.x  FP1,FP5
            fmul.x  FP3,FP5
            fadd.x  (FPKX2FX2.w,PC),FP5
            fadd.x  FP4,FP5
            fsub.x  FP2,FP5
            fmove.x FP5,FP0
            fmul.b  #$FF,FP0
            fmovem.x (SP)+,FP4-FP5
            bra.w   .L17
.L22:
            bmi.b   .L23
            btst    #$1D,D0
            beq.b   .L24
.L23:
            movem.l (SP)+,A1-A3
            moveq   #0,D0
            jmp     (A4)
.L24:
            fmove.x (FPKPI2.w,PC),FP0
            move.w  A1,D1
            beq.b   .L25
            fmul.b  #$FF,FP0
.L25:
            movem.l (SP)+,A1-A3
            moveq   #0,D0
            jmp     (A4)
