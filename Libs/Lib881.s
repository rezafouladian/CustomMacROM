            include "Include/ROMHeader.s"

            IMPORT  A

            SECTION "Lib881",CODE

_FC2X:
            movem.l D0-D1,-(SP)
            movem.l ([$10.w,SP]),D0-D1
            tst.l   D1
            bgt.b   .L1
            beq.b   .L3
            addq.l  #1,D0
.L1:
            fmove.l D0,FP0
            fscale.w #$20,FP0
            fadd.l  D1,FP0
            bvc.b   .L2
            fadd.s  #"$5F800000",FP0
.L2:
            movem.l (SP)+,D0-D1
            fmove.x FP0,([4.w,SP])
            rts
.L3:
            neg.l   D0
            bvs.b   .L4
            neg.l   D0
            bra.b   .L1
.L4:
            fmove.s #"$7FC01400",FP0
            bra.b   .L2
            ds.b    4
_fprocENTRYsp:
            fmove.l (SP)+,FPIAR
            clr.l   -(SP)
            fmovem.x (SP),FP0
            fmovem.l FPCR/FPSR,-(SP)
            clr.l   -(SP)
            move.l  (4,SP),-(SP)
            andi.l  #$FF,(SP)
            fmovem.l (SP)+,FPCR/FPSR
            fmovem.x FP0,-(SP)
            clr.l   (SP)+
            fmove.l FPIAR,-(SP)
            rts
            ds.b    6
_fprocEXITsp:
            fmove.w D1,FP1
            fmove.l FPSR,-(SP)
            move.w  (2,SP),D1
            clr.l   (SP)+
            fmovem.l (4,SP),FPCR/FPSR
            or.w    D1,($A,SP)
            and.w   (5,SP),D1
            fmove.l (8,SP),FPSR
            tst.b   D1
            beq.b   .L1
            fnop
            nop
            fsave   -(SP)
            bclr    #$1B,($18,SP)
            frestore (SP)+
            fnop
.L1:
            fmove.w FP1,D1
            move.l  (SP),($14,SP)
            lea     ($14,SP),SP
            rts
            ds.b    8

            EVEN
