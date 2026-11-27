RSin:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   .L33
            movem.l A1,-(SP)
            movea.l A0,A1
            movem.l D2,-(SP)
            bcc.b   .L27
            moveq   #1,D2
            bra.b   .L28
.L27:
            moveq   #0,D2
.L28:
            fmove.x (FPKPI2.w,PC),FP1
            frem.x  FP1,FP0
            fmove.l FPSR,D0
            swap    D0
            move.b  D0,D1
            lsr.b   #1,D0
            bcc.b   .L29
            bsr.w   UseCos
            subq.b  #1,D2
            bmi.b   .L30
            fmul.w  #$FFFF,FP0
            bra.b   .L30
.L29:
            bsr.w   UseSin
.L30:
            movem.l (SP)+,D2
            andi.b  #3,D1
            subq.b  #2,D1
            bmi.b   .L31
            fmul.w  #$FFFF,FP0
.L31:
            bfextu  (A1){1:16},D0
            movea.l (SP)+,A1
            beq.b   .L32
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L32:
            move.l  #$280000,D0
            jmp     (A4)
.L33:
            bmi.b   .L34
            btst    #$1D,D0
            bne.b   .L34
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
.L34:
            moveq   #0,D0
            jmp     (A4)
RCos:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   .L41
            movem.l D2,-(SP)
            bcc.b   .L36
            moveq   #1,D2
            bra.b   .L37
.L36:
            moveq   #0,D2
.L37:
            fmove.x (FPKPI2.w,PC),FP1
            frem.x  FP1,FP0
            fmove.l FPSR,D0
            swap    D0
            move.b  D0,D1
            lsr.b   #1,D0
            bcs.b   .L38
            bsr.b   UseCos
            bra.b   .L39
.L38:
            bsr.w   UseSin
            subq.b  #1,D2
            bmi.b   .L39
            fmul.w  #$FFFF,FP0
.L39:
            movem.l (SP)+,D2
            andi.b  #3,D1
            subq.b  #1,D1
            bmi.b   .L40
            subq.b  #2,D1
            bpl.b   .L40
            fmul.w  #$FFFF,FP0
.L40:
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L41:
            bmi.b   .L43
            btst    #$1D,D0
            bne.b   .L42
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
.L42:
            moveq   #0,D0
            jmp     (A4)
.L43:
            fmove.w #1,FP0
            moveq   #0,D0
            jmp     (A4)
UseCos:
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     (COSP.w,PC),A0
            bsr.w   PolyEval
            fmove.x FP1,FP2
            lea     (COSQ.w,PC),A0
            bsr.w   PolyEval
            fdiv.x  FP1,FP2
            fmul.x  FP0,FP2
            fmul.x  FP0,FP2
            fcmp.x  #"$3FFD3FFD8000000000000000",FP0
            fblt.w  .L1
            fabs.x  FP3,FP3
            fsub.x  #"$3FFE3FFE8000000000000000",FP3
            fmove.x FP3,FP1
            fdiv.w  #2,FP1
            fmul.x  FP1,FP3
            fsub.x  FP2,FP3
            fadd.x  FP1,FP3
            fmul.w  #$FFFF,FP3
            fadd.x  #"$3FFE3FFEE000000000000000",FP3
            fmove.x FP3,FP0
            rts
.L1:
            fdiv.w  #2,FP0
            fsub.x  FP0,FP2
            fadd.w  #1,FP2
            fmove.x FP2,FP0
            rts
UseSin:
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     (SINP.w,PC),A0
            bsr.w   PolyEval
            fmove.x FP1,FP2
            lea     (SINQ.w,PC),A0
            bsr.w   PolyEval
            fdiv.x  FP1,FP2
            fmul.x  FP3,FP0
            fmul.x  FP0,FP2
            fsub.x  FP2,FP3
            fmove.x FP3,FP0
            rts
