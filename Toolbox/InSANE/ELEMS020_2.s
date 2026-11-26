            include "Include/ROMHeader.s"

            EXPORT  ANNUITYTOP,COMPOUNDTOP,EXP1TOP,EXPTOP,XPWRITOP,XPWRYTOP

            IMPORT  DIVM0STUFF,DIVP0STUFF,ERRORNAN,EXP21P_PACK_5_2,EXP21Q_PACK_5_2,FPK0
            IMPORT  FPK1,FPK2,FPKINF,FPKLOGE2,FPKM1,M0STUFF
            IMPORT  M1STUFF,MINFSTUFF,P0STUFF,P1STUFF,PINFSTUFF,RESULTDELIVERED
            IMPORT  ELEMS020,CLASSIFY,A0TOA1,POLYEVAL,CLEARUFLOW,CLEAROFLOW
            IMPORT  CLEARINVALID,CLEARINEXACT,FORCEOFLOW,FORCEUFLOW,FORCEDIVZER,FORCEINEXACT
            IMPORT  TESTUFLOW,TESTOFLOW,TESTINVALID,TESTINEXACT,SCALBXX,ELI2X

            SECTION "ELEMS020_2",CODE

EXPTOP:
            subq.b  #1,D1
            beq.b   P1STUFF
            bgt.b   .EXPNONZERO
            tst.w   D1
            bmi.b   P0STUFF
            bra.b   RESULTDELIVERED
.EXPNONZERO:
            btst    #1,D3
            beq.b   .EXPR
            bsr.b   SPLIT2
            bra.b   .EXPROOT
.EXPR:
            bsr.b   SPLIT
            bsr.w   TESTOFLOW
            beq.b   .EXPROOT
            bsr.w   FORCEINEXACT
            tst.w   D1
            bpl.b   PINFSTUFF
            bsr.w   CLEAROFLOW
            bsr.w   FORCEUFLOW
            bra.w   P0STUFF
.EXPROOT:
            bsr.w   EXPAPPROX
            pea     (FPK1.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   SCALBXX
            tst.w   (2,A4)
            bmi.b   RESULTDELIVERED
            bfextu  (A4){1:15},D0
            bne.b   RESULTDELIVERED
            bsr.w   TESTINEXACT
            beq.b   RESULTDELIVERED
            bsr.w   FORCEUFLOW
            bra.b   RESULTDELIVERED
SPLIT2:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            bsr.w   CLEARINEXACT
            pea     (A1)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            rts
SPLIT:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (FPKLOGE2.w,PC)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            pea     (A4)
            pea     (A1)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bra.w   CLEARINEXACT
EXP1TOP:
            subq.b  #1,D1
            bgt.b   .EXP1FINITE
            beq.b   .EXPEASY
            tst.w   D1
            bmi.w   M1STUFF
.EXPEASY:
            bra.w   RESULTDELIVERED
.EXP1FINITE:
            subq.b  #1,D1
            btst    #1,D3
            beq.b   .EXP1R
            tst.b   D1
            beq.b   .EXP21RNORM
            pea     (FPKLOGE2.w,PC)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.EXP1OUT:
            bsr.w   FORCEUFLOW
            bsr.w   FORCEINEXACT
            bra.b   .EXP1RDONE
.EXP21RNORM:
            bsr.w   SPLIT2
            bra.b   .EXP1ROOT
.EXP1R:
            tst.b   D1
            bne.b   .EXP1OUT
            bsr.b   SPLIT
            bsr.w   TESTOFLOW
            beq.b   .EXP1ROOT
            bsr.w   FORCEINEXACT
            tst.w   D1
            bpl.w   PINFSTUFF
            bsr.w   CLEAROFLOW
            bra.w   M1STUFF
.EXP1ROOT:
            bsr.b   EXPAPPROX
            move.l  (-$E,A6),D0
            or.l    (-$A,A6),D0
            beq.b   .EXP1RDONE
            pea     (FPK1.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   SCALBXX
            pea     (FPK1.w,PC)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            bsr.w   CLEARUFLOW
.EXP1RDONE:
            bra.w   RESULTDELIVERED
EXPAPPROX:
            move.l  (2,A4),D0
            or.l    (6,A4),D0
            bne.b   EXPHARD
            rts
EXPHARD:
            lea     (-$24,A6),A1
            movea.l A4,A0
            bsr.w   A0TOA1
            pea     (A1)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$1A,A6),A0
            lea     (EXP21P_PACK_5_2.w,PC),A1
            lea     (-$24,A6),A2
            bsr.w   POLYEVAL
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$1A,A6),A0
            lea     (EXP21Q_PACK_5_2.w,PC),A1
            lea     (-$24,A6),A2
            bsr.w   POLYEVAL
            pea     (A4)
            pea     (-$1A,A6)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (FPK2.w,PC)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   FORCEINEXACT
            bra.w   CLEARUFLOW
XPWRITOP:
            movea.l D4,A0
            move.w  (A0),D2
            beq.w   P1STUFF
            subq.b  #1,D1
            bgt.b   .FINPWRI
            asr.w   #1,D2
            bcs.b   .L3
            bclr    #7,(A4)
.L3:
            addx.w  D2,D2
            bpl.w   RESULTDELIVERED
            tst.b   D1
            bpl.b   .ZPWRNEG
            tst.b   (A4)
            bpl.w   P0STUFF
            bra.w   M0STUFF
.ZPWRNEG:
            tst.b   (A4)
            bpl.w   DIVP0STUFF
            bra.w   DIVM0STUFF
.FINPWRI:
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            bhi.b   .XPWRBIG
            bsr.b   XPWRK
            bra.w   RESULTDELIVERED
.XPWRBIG:
            move.w  (A4),-(SP)
            bclr    #7,(A4)
            move.l  D4,-(SP)
            pea     (-$10,A6)
            move.l  (SP),D4
            bsr.w   ELI2X
            bsr.w   XPWRY
            move.w  (SP)+,D0
            bpl.b   .L8
            asr.w   #1,D2
            bcc.b   .L8
            bset    #7,(A4)
.L8:
            bra.w   RESULTDELIVERED
XPWRK:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            bsr.b   XPWRKLOOP
            tst.w   D2
            bmi.b   .XPWRKDIV
.XPWRKSTORE:
            movea.l A1,A0
            movea.l A4,A1
            bra.w   A0TOA1
.XPWRKDIV:
            lea     (FPK1.w,PC),A0
            lea     (A4),A1
            bsr.w   A0TOA1
            bsr.w   TESTUFLOW
            bne.b   .XPWRKCLEAR
            bsr.w   TESTOFLOW
            bne.b   .XPWRKCLEAR
            pea     (-$10,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            rts
.XPWRKCLEAR:
            bsr.w   CLEAROFLOW
            bsr.w   CLEARUFLOW
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            move.w  D2,D0
            bpl.b   .L4
            neg.w   D0
.L4:
            bsr.b   XPWRKLOOP
            bra.b   .XPWRKSTORE
XPWRKLOOP:
            lea     (FPK1.w,PC),A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            bra.b   .XKLPENTRY
.XKLPTOP:
            pea     (A4)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.XKLPENTRY:
            lsr.w   #1,D0
            bcc.b   .XKLPSKIP
            pea     (A4)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
.XKLPSKIP:
            tst.w   D0
            bne.b   .XKLPTOP
            rts
XPWRY:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   ELEMS020
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bsr.w   ELEMS020
            movea.l A1,A0
            movea.l A4,A1
            bra.w   A0TOA1
XPWRYTOP:
            tst.w   D1
            bmi.b   .NEGPWRY
            bsr.b   XPWRYCOM
            bra.w   RESULTDELIVERED
.XPWRY9ERR:
            addq.l  #4,SP
.XPWRYERR:
            bsr.w   CLEARINEXACT
            moveq   #$25,D0
            bra.w   ERRORNAN
.NEGPWRY:
            tst.b   D2
            beq.b   .XPWRYERR
            movea.l D4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            bsr.w   TESTINEXACT
            bne.b   .XPWRYERR
            pea     (FPK2.w,PC)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            move.w  FPState,(-6,A6)
            bsr.w   CLEARINEXACT
            bclr    #7,(A4)
            bsr.b   XPWRYCOM
            btst    #4,(-6,A6)
            beq.b   .L5
            bchg    #7,(A4)
.L5:
            bra.w   RESULTDELIVERED
XPWRYCOM:
            subq.b  #1,D1
            bne.b   .NONPWRY
            subq.b  #1,D2
            beq.b   XPWRYTOP.XPWRY9ERR
            tst.w   D2
            bpl.b   .L1
            bsr.w   FORCEDIVZER
            lea     (FPKINF.w,PC),A0
            bra.b   .L2
.L1:
            lea     (FPK0.w,PC),A0
.L2:
            movea.l A4,A1
            bra.w   A0TOA1
.NONPWRY:
            bpl.b   .FINPWRY
            subq.b  #1,D2
            bne.b   .XPWRYOK
            bra.w   XPWRYTOP.XPWRY9ERR
.FINPWRY:
            subq.b  #1,D2
            bpl.b   .XPWRYOK
            pea     (FPK1.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.w   XPWRYTOP.XPWRY9ERR
.XPWRYOK:
            move.w  D2,D6
            move.l  D4,-(SP)
            pea     (-4,A6)
            move.w  #$2010,-(SP)
            jsr     (A3)
            bsr.w   TESTINVALID
            sne     D7
            bsr.w   CLEARINVALID
            bsr.w   TESTINEXACT
            sne     D1
            or.b    D1,D7
            bne.b   .XPWRYHARD
            move.w  (-4,A6),D2
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            ble.w   XPWRK
.XPWRYHARD:
            bsr.w   CLEARINEXACT
            bsr.w   XPWRY
            tst.b   D6
            bmi.w   CLEARINEXACT
            rts
COMPOUNDTOP:
            pea     (FPKM1.w,PC)
            move.l  D5,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            blt.w   ERRFINAN
            bgt.b   .CMPGTM1
            subq.b  #1,D2
            bne.b   .CMPM1N
.CMPTOZERO:
            bra.w   P1STUFF
.CMPM1N:
            movea.l D4,A0
            tst.b   (A0)
            bmi.w   DIVP0STUFF
.CMPZERO:
            bra.w   P0STUFF
.CMPGTM1:
            subq.b  #1,D2
            beq.b   .CMPTOZERO
            bgt.b   .CMPTOFIN
            subq.b  #1,D1
            beq.b   ERRFINAN
            eor.w   D2,D1
            bmi.b   .CMPZERO
            bra.w   PINFSTUFF
.CMPTOFIN:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   A0TOA1
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .cmpbasee
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   ELEMS020
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bra.b   .cmpresult
.cmpbasee:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #8,-(SP)
.cmpresult:
            bsr.w   CLEARUFLOW
            bsr.w   ELEMS020
            movea.l A1,A0
            movea.l A4,A1
            bsr.w   A0TOA1
            bra.w   RESULTDELIVERED
ERRFINAN:
            moveq   #$26,D0
            bra.w   ERRORNAN
ANNUITYTOP:
            pea     (FPKM1.w,PC)
            move.l  D5,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            blt.b   ERRFINAN
            bne.b   .ANNOK
            subq.b  #1,D2
            beq.b   .ANN0
            tst.w   D2
            bpl.w   DIVP0STUFF
.ANNM1:
            bra.w   M1STUFF
.ANNOK:
            subq.b  #1,D2
            bne.b   .ANNXN
.ANN0:
            bra.w   P0STUFF
.ANNXN:
            subq.b  #1,D1
            bgt.b   .ANNROK
            blt.b   .ANNRINF
.ANNSRC:
            movea.l A4,A1
            movea.l D4,A0
            bsr.w   A0TOA1
            bra.w   RESULTDELIVERED
.ANNRINF:
            tst.w   D2
            bpl.b   .ANN0
            pea     (FPKM1.w,PC)
            move.l  D4,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.b   .ANNM1
            bgt.w   M0STUFF
            bra.w   MINFSTUFF
.ANNROK:
            tst.b   D2
            bpl.b   .ANNDOIT
            eor.w   D2,D1
            bmi.b   .ANNSRC
            movea.l D5,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            movea.l A4,A1
            lea     (FPK1.w,PC),A0
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            bra.w   RESULTDELIVERED
.ANNDOIT:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   A0TOA1
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .annbasee
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   ELEMS020
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            cmpi.w  #$4007,(A1)
            blt.b   .L26
            movea.l D5,A0
            cmpi.w  #$407F,(A0)
            bge.b   .annspecial
.L26:
            pea     (A1)
            move.w  #$E,-(SP)
            bra.b   .annresult
.annbasee:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (A1)
            move.w  #$C,-(SP)
.annresult:
            bsr.w   ELEMS020
            bchg    #7,(A1)
            move.l  D5,-(SP)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
.annclear:
            bsr.w   CLEARUFLOW
            bsr.w   CLEAROFLOW
            movea.l A1,A0
            bsr.w   CLASSIFY
            subq.b  #3,D0
            bne.b   .L30
            bsr.w   FORCEOFLOW
            bra.b   .ANNDOUT
.L30:
            subq.b  #2,D0
            beq.b   .ANNDOUT
            bsr.w   FORCEUFLOW
.ANNDOUT:
            lea     (-$1A,A6),A0
            movea.l A4,A1
            bsr.w   A0TOA1
            bra.w   RESULTDELIVERED
.annspecial:
            movea.l D5,A0
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   ELEMS020
            lea     (-$24,A6),A1
            movea.l D4,A0
            bsr.w   A0TOA1
            pea     (FPK1.w,PC)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     (A1)
            lea     (-$1A,A6),A1
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (A1)
            move.w  #$A,-(SP)
            bsr.w   ELEMS020
            bchg    #7,(A1)
            bra.b   .annclear

            EVEN
