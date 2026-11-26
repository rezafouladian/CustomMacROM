            include "Include/ROMHeader.s"

            EXPORT  PolyEval

            SECTION "HWElemsCommon",CODE

PolyEval:
            move.w  (A0)+,D0
            fmove.x (A0)+,FP1
PolyLoop:
            fmul.x  FP0,FP1
            fadd.x  (A0)+,FP1
            dbra    D0,PolyLoop
            rts

            EVEN
