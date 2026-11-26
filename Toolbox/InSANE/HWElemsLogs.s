            include "Include/ROMHeader.s"

            EXPORT  RLn1x,RLnx,RLog21x,RLog2x

            IMPORT  FPKSQRT2,FPKSQRTHALF,LOG21P,LOG21Q,PolyEval

            SECTION "HWElemsLogs",CODE

RLog2x:
            fmove.l FPSR,D0
            bsr.w   Classify
            bsr.w   ArgReduce
            fsub.l  #1,FP0
            fsne    D1
            bsr.w   Log2Approx
            tst.b   D1
            beq.b   .L3
            move.l  #$80000,D0
.L3:
            jmp     (A4)
RLog21x:
            fmove.x FP0,FP1
            fadd.l  #1,FP0
            fmove.l FPSR,D0
            bsr.w   Classify
            fmove.l FPSR,D1
            swap    D1
            fcmp.x  (FPKSQRT2.w,PC),FP0
            fbgt.w  .L5
            fcmp.x  (FPKSQRTHALF.w,PC),FP0
            fblt.w  .L5
            fmove.l #0,FP3
            fmove.x FP1,FP0
            bfextu  (A0){1:16},D0
            beq.b   Log21Denormal
            moveq   #1,D1
            bra.b   .L6
.L5:
            bsr.w   ArgReduce
            fsub.l  #1,FP0
            fsne    D1
.L6:
            bsr.w   Log2Approx
            tst.b   D1
            bne.b   .L7
            btst    #$13,D1
            beq.b   .L8
.L7:
            move.l  #$80000,D0
.L8:
            jmp     (A4)
Log21Denormal:
            fbeq.w  .L10
            fmovecr.x #$30,FP1
            fdiv.x  FP1,FP0
            move.l  #$200000,D0
.L10:
            jmp     (A4)
RLn1x:
            fmove.x FP0,FP1
            fadd.l  #1,FP0
            fmove.l FPSR,D0
            bsr.b   Classify
            fcmp.x  (FPKSQRT2.w,PC),FP0
            fbgt.w  .L12
            fcmp.x  (FPKSQRTHALF.w,PC),FP0
            fblt.w  .L12
            fmove.l #0,FP3
            fmove.x FP1,FP0
            bfextu  (A0){1:16},D0
            beq.b   .L14
            bra.b   .L13
.L12:
            bsr.b   ArgReduce
            fsub.l  #1,FP0
.L13:
            bsr.b   Log2Approx
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
            move.l  #$80000,D0
            jmp     (A4)
.L14:
            fbeq.w  .L15
            move.l  #$200000,D0
.L15:
            jmp     (A4)
RLnx:
            fmove.l FPSR,D0
            bsr.b   Classify
            bsr.b   ArgReduce
            fsub.l  #1,FP0
            bsr.b   Log2Approx
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
            fbeq.w  .L17
            move.l  #$80000,D0
            jmp     (A4)
.L17:
            moveq   #8,D0
            jmp     (A4)
Classify:
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bcs.w   LogNeg
            bne.b   BadStuff
            rts
ArgReduce:
            fgetexp.x FP0,FP3
            fgetman.x FP0,FP0
            fcmp.x  (FPKSQRT2.w,PC),FP0
            fblt.w  .L1
            fadd.w  #1,FP3
            fdiv.w  #2,FP0
.L1:
            rts
Log2Approx:
            fmove.x FP0,FP2
            fadd.l  #2,FP2
            fdiv.x  FP2,FP0
            fmove.x FP0,FP2
            fmul.x  FP2,FP0
            lea     (LOG21P.w,PC),A0
            bsr.w   PolyEval
            fmul.x  FP1,FP2
            lea     (LOG21Q.w,PC),A0
            bsr.w   PolyEval
            fmove.l FPSR,D0
            bclr    #5,D0
            fmove.l D0,FPSR
            fdiv.x  FP1,FP2
            fmove.x FP2,FP0
            fadd.x  FP3,FP0
            rts
BadStuff:
            addq.l  #4,SP
            bmi.b   LogZero
            jmp     (A4)
LogZero:
            fmove.x #"$FFFF00000000000000000000",FP0
            move.l  #$100000,D0
            jmp     (A4)
LogNeg:
            addq.l  #4,SP
            lsl.l   #1,D0
            bcs.b   LogZero
            btst    #$1E,D0
            bne.b   .L4
            fmove.x #"$7FFF00004024000000000000",FP0
            move.l  #$800008,D0
.L4:
            jmp     (A4)

            EVEN
