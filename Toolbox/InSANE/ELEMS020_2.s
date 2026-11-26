            include "Include/ROMHeader.s"

            EXPORT  ANNUITYTOP,COMPOUNDTOP,EXP1TOP,EXPTOP,XPWRITOP,XPWRYTOP

            IMPORT  DIVM0STUFF,DIVP0STUFF,ERRORNAN,EXP21P_PACK_5_2,EXP21Q_PACK_5_2,FPK0
            IMPORT  FPK1,FPK2,FPKINF,FPKLOGE2,FPKM1,M0STUFF
            IMPORT  M1STUFF,MINFSTUFF,P0STUFF,P1STUFF,PINFSTUFF,RESULTDELIVERED
            IMPORT  RsrcPACK_5_2,CLASSIFY,A0TOA1,POLYEVAL,CLEARUFLOW,CLEAROFLOW
            IMPORT  CLEARINVALID,CLEARINEXACT,FORCEOFLOW,FORCEUFLOW,FORCEDIVZER,FORCEINEXACT
            IMPORT  TESTUFLOW,TESTOFLOW,TESTINVALID,TESTINEXACT,SCALBXX,ELI2X

            SECTION "ELEMS020_2",CODE

EXPTOP:
            subq.b  #1,D1
            beq.b   P1STUFF
            bgt.b   .L18
            tst.w   D1
            bmi.b   P0STUFF
            bra.b   RESULTDELIVERED
.L18:
            btst    #1,D3
            beq.b   .L19
            bsr.b   sub_408EA53E
            bra.b   .L20
.L19:
            bsr.b   sub_408EA560
            bsr.w   TESTOFLOW
            beq.b   .L20
            bsr.w   FORCEINEXACT
            tst.w   D1
            bpl.b   PINFSTUFF
            bsr.w   CLEAROFLOW
            bsr.w   FORCEUFLOW
            bra.w   P0STUFF
.L20:
            bsr.w   sub_408EA62A
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
sub_408EA53E:
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
sub_408EA560:
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
            bgt.b   .L3
            beq.b   .L2
            tst.w   D1
            bmi.w   M1STUFF
.L2:
            bra.w   RESULTDELIVERED
.L3:
            subq.b  #1,D1
            btst    #1,D3
            beq.b   .L6
            tst.b   D1
            beq.b   .L5
            pea     (FPKLOGE2.w,PC)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.L4:
            bsr.w   FORCEUFLOW
            bsr.w   FORCEINEXACT
            bra.b   .L8
.L5:
            bsr.w   sub_408EA53E
            bra.b   .L7
.L6:
            tst.b   D1
            bne.b   .L4
            bsr.b   sub_408EA560
            bsr.w   TESTOFLOW
            beq.b   .L7
            bsr.w   FORCEINEXACT
            tst.w   D1
            bpl.w   PINFSTUFF
            bsr.w   CLEAROFLOW
            bra.w   M1STUFF
.L7:
            bsr.b   sub_408EA62A
            move.l  (-$E,A6),D0
            or.l    (-$A,A6),D0
            beq.b   .L8
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
.L8:
            bra.w   RESULTDELIVERED
sub_408EA62A:
            move.l  (2,A4),D0
            or.l    (6,A4),D0
            bne.b   .L1
            rts
.L1:
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
            bgt.b   .L5
            asr.w   #1,D2
            bcs.b   .L3
            bclr    #7,(A4)
.L3:
            addx.w  D2,D2
            bpl.w   RESULTDELIVERED
            tst.b   D1
            bpl.b   .L4
            tst.b   (A4)
            bpl.w   P0STUFF
            bra.w   M0STUFF
.L4:
            tst.b   (A4)
            bpl.w   DIVP0STUFF
            bra.w   DIVM0STUFF
.L5:
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            bhi.b   .L7
            bsr.b   sub_408EA70C
            bra.w   RESULTDELIVERED
.L7:
            move.w  (A4),-(SP)
            bclr    #7,(A4)
            move.l  D4,-(SP)
            pea     (-$10,A6)
            move.l  (SP),D4
            bsr.w   ELI2X
            bsr.w   sub_408EA792
            move.w  (SP)+,D0
            bpl.b   .L8
            asr.w   #1,D2
            bcc.b   .L8
            bset    #7,(A4)
.L8:
            bra.w   RESULTDELIVERED
sub_408EA70C:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            bsr.b   sub_408EA766
            tst.w   D2
            bmi.b   .L2
.L1:
            movea.l A1,A0
            movea.l A4,A1
            bra.w   A0TOA1
.L2:
            lea     (FPK1.w,PC),A0
            lea     (A4),A1
            bsr.w   A0TOA1
            bsr.w   TESTUFLOW
            bne.b   .L3
            bsr.w   TESTOFLOW
            bne.b   .L3
            pea     (-$10,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            rts
.L3:
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
            bsr.b   sub_408EA766
            bra.b   .L1
sub_408EA766:
            lea     (FPK1.w,PC),A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            bra.b   .L2
.L1:
            pea     (A4)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.L2:
            lsr.w   #1,D0
            bcc.b   .L3
            pea     (A4)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
.L3:
            tst.w   D0
            bne.b   .L1
            rts
sub_408EA792:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bsr.w   RsrcPACK_5_2
            movea.l A1,A0
            movea.l A4,A1
            bra.w   A0TOA1
XPWRYTOP:
            tst.w   D1
            bmi.b   .L4
            bsr.b   sub_408EA828
            bra.w   RESULTDELIVERED
.L2:
            addq.l  #4,SP
.L3:
            bsr.w   CLEARINEXACT
            moveq   #$25,D0
            bra.w   ERRORNAN
.L4:
            tst.b   D2
            beq.b   .L3
            movea.l D4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            bsr.w   TESTINEXACT
            bne.b   .L3
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
            bsr.b   sub_408EA828
            btst    #4,(-6,A6)
            beq.b   .L5
            bchg    #7,(A4)
.L5:
            bra.w   RESULTDELIVERED
sub_408EA828:
            subq.b  #1,D1
            bne.b   .L3
            subq.b  #1,D2
            beq.b   XPWRYTOP.L2
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
.L3:
            bpl.b   .L4
            subq.b  #1,D2
            bne.b   .L5
            bra.w   XPWRYTOP.L2
.L4:
            subq.b  #1,D2
            bpl.b   .L5
            pea     (FPK1.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.w   XPWRYTOP.L2
.L5:
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
            bne.b   .L7
            move.w  (-4,A6),D2
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            ble.w   sub_408EA70C
.L7:
            bsr.w   CLEARINEXACT
            bsr.w   sub_408EA792
            tst.b   D6
            bmi.w   CLEARINEXACT
            rts
COMPOUNDTOP:
            pea     (FPKM1.w,PC)
            move.l  D5,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            blt.w   ERRFINAN
            bgt.b   .L12
            subq.b  #1,D2
            bne.b   .L10
.L9:
            bra.w   P1STUFF
.L10:
            movea.l D4,A0
            tst.b   (A0)
            bmi.w   DIVP0STUFF
.L11:
            bra.w   P0STUFF
.L12:
            subq.b  #1,D2
            beq.b   .L9
            bgt.b   .L13
            subq.b  #1,D1
            beq.b   ERRFINAN
            eor.w   D2,D1
            bmi.b   .L11
            bra.w   PINFSTUFF
.L13:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   A0TOA1
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .L14
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bra.b   .L15
.L14:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #8,-(SP)
.L15:
            bsr.w   CLEARUFLOW
            bsr.w   RsrcPACK_5_2
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
            bne.b   .L19
            subq.b  #1,D2
            beq.b   .L20
            tst.w   D2
            bpl.w   DIVP0STUFF
.L18:
            bra.w   M1STUFF
.L19:
            subq.b  #1,D2
            bne.b   .L21
.L20:
            bra.w   P0STUFF
.L21:
            subq.b  #1,D1
            bgt.b   .L24
            blt.b   .L23
.L22:
            movea.l A4,A1
            movea.l D4,A0
            bsr.w   A0TOA1
            bra.w   RESULTDELIVERED
.L23:
            tst.w   D2
            bpl.b   .L20
            pea     (FPKM1.w,PC)
            move.l  D4,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.b   .L18
            bgt.w   M0STUFF
            bra.w   MINFSTUFF
.L24:
            tst.b   D2
            bpl.b   .L25
            eor.w   D2,D1
            bmi.b   .L22
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
.L25:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   A0TOA1
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .L27
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            cmpi.w  #$4007,(A1)
            blt.b   .L26
            movea.l D5,A0
            cmpi.w  #$407F,(A0)
            bge.b   .L32
.L26:
            pea     (A1)
            move.w  #$E,-(SP)
            bra.b   .L28
.L27:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (A1)
            move.w  #$C,-(SP)
.L28:
            bsr.w   RsrcPACK_5_2
            bchg    #7,(A1)
            move.l  D5,-(SP)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
.L29:
            bsr.w   CLEARUFLOW
            bsr.w   CLEAROFLOW
            movea.l A1,A0
            bsr.w   CLASSIFY
            subq.b  #3,D0
            bne.b   .L30
            bsr.w   FORCEOFLOW
            bra.b   .L31
.L30:
            subq.b  #2,D0
            beq.b   .L31
            bsr.w   FORCEUFLOW
.L31:
            lea     (-$1A,A6),A0
            movea.l A4,A1
            bsr.w   A0TOA1
            bra.w   RESULTDELIVERED
.L32:
            movea.l D5,A0
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   RsrcPACK_5_2
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
            bsr.w   RsrcPACK_5_2
            bchg    #7,(A1)
            bra.b   .L29

            EVEN
