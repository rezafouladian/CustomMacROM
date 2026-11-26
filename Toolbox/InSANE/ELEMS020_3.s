            include "Include/ROMHeader.s"

            EXPORT  ATANTOP,COSTOP,RANDTOP,SINTOP,TANTOP

            IMPORT  ATANQ_PACK_5_2,COSQ_PACK_5_2,ELCLASSX,ERRORNAN,FPK1,FPK3
            IMPORT  FPK34,FPK78,FPKARAND,FPKATNCONS_PACK_5_2,FPKFOURTH,FPKHALF
            IMPORT  FPKPI2_PACK_5_2,FPKPRAND,FPKX2_PACK_5_2,FPKX2FX2_PACK_5_2,P1STUFF,RESULTDELIVERED
            IMPORT  SINQ_PACK_5_2,A0TOA1,POLYEVAL,CLEARUFLOW,FORCEUFLOW,FORCEINEXACT
            IMPORT  TESTDIVZER,TANQ_PACK_5_2

            SECTION "ELEMS020_3",CODE

SINTOP:
            moveq   #$21,D0
            moveq   #0,D2
            subq.b  #1,D1
            beq.w   RESULTDELIVERED
SINCOSCOM:
            bmi.w   ERRORNAN
            bsr.b   TRIGREDUCTION
            btst    #0,D2
            bne.b   .L35
            bsr.b   SINGUTS
            bra.b   .L36
.L35:
            bsr.w   COSGUTS
.L36:
            andi.w  #3,D2
            subq.w  #2,D2
            bmi.b   TRIGFINI
            bchg    #7,(A4)
TRIGFINI:
            bsr.w   CLEARUFLOW
            bsr.w   FORCEINEXACT
            pea     (A4)
            pea     (-4,A6)
            bsr.w   ELCLASSX
            move.w  (-4,A6),D0
            bpl.b   .L38
            neg.w   D0
.L38:
            subq.w  #6,D0
            bne.b   .L39
            bsr.w   FORCEUFLOW
.L39:
            bra.w   RESULTDELIVERED
COSTOP:
            moveq   #$21,D0
            moveq   #1,D2
            subq.b  #1,D1
            bne.b   SINCOSCOM
            bra.w   P1STUFF
TRIGREDUCTION:
            pea     (FPKPI2_PACK_5_2.w,PC)
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            add.w   D0,D2
            rts
SINGUTS:
            lea     (SINQ_PACK_5_2.w,PC),A2
            bsr.b   sub_408EAB38
            pea     (A4)
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A0)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            rts
sub_408EAB2A:
            bsr.b   sub_408EAB38
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            rts
sub_408EAB38:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            exg     A1,A2
            lea     (-$24,A6),A0
            bsr.w   POLYEVAL
            pea     (A0)
            lea     (-$1A,A6),A0
            bsr.w   POLYEVAL
            pea     (A0)
            move.w  #6,-(SP)
            jsr     (A3)
            rts
COSGUTS:
            lea     (COSQ_PACK_5_2.w,PC),A2
            bsr.b   sub_408EAB2A
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (FPKFOURTH.w,PC)
            pea     (A2)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L1
            pea     (FPKHALF.w,PC)
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A0)
            move.w  #2,-(SP)
            jsr     (A3)
            movea.l A4,A1
            bsr.w   A0TOA1
            pea     (FPK1.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
.L1:
            bclr    #7,(A4)
            pea     (FPKHALF.w,PC)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A0)
            movea.l A4,A0
            movea.l A2,A1
            bsr.w   A0TOA1
            pea     (FPKHALF.w,PC)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            bchg    #7,(A4)
            pea     (FPK78.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
TANTOP:
            moveq   #$21,D0
            moveq   #0,D2
            subq.b  #1,D1
            bmi.w   ERRORNAN
            beq.w   RESULTDELIVERED
            bsr.w   TRIGREDUCTION
            bsr.b   sub_408EAC48
            ror.w   #1,D2
            bcc.b   .L3
            bchg    #7,(A4)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            lea     (FPK1.w,PC),A0
            movea.l A4,A1
            bsr.w   A0TOA1
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   TESTDIVZER
            beq.b   .L3
            bchg    #7,(A4)
.L3:
            bra.w   TRIGFINI
sub_408EAC48:
            lea     (TANQ_PACK_5_2.w,PC),A2
            bsr.w   sub_408EAB2A
            movea.l A4,A0
            lea     (-$2E,A6),A1
            bsr.w   A0TOA1
            pea     (A2)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            lea     (-$1A,A6),A0
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (FPKFOURTH.w,PC)
            pea     (A2)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L1
            pea     (FPK3.w,PC)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A0)
            clr.w   -(SP)
            jsr     (A3)
            bra.b   .L2
.L1:
            pea     (A0)
            movea.l A4,A0
            lea     (-$24,A6),A1
            bsr.w   A0TOA1
            pea     (FPK34.w,PC)
            pea     (A1)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (FPK3.w,PC)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     (FPKFOURTH.w,PC)
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A1,A0
.L2:
            pea     (A0)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
ATANTOP:
            subq.b  #1,D1
            bge.b   .L4
            lea     (FPKPI2_PACK_5_2.w,PC),A0
            movea.l A4,A1
            bsr.w   A0TOA1
            clr.b   D1
            or.w    D1,(A4)
            bra.b   .L5
.L4:
            bne.b   .L6
.L5:
            bra.w   RESULTDELIVERED
.L6:
            bclr    #7,(A4)
            bsr.b   sub_408EAD12
            clr.b   D1
            or.w    D1,(A4)
            bra.w   TRIGFINI
sub_408EAD12:
            moveq   #0,D2
            pea     (FPK1.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            bls.b   .L1
            moveq   #-1,D2
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            lea     (FPK1.w,PC),A0
            movea.l A4,A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
.L1:
            move.l  (A4)+,-(SP)
            move.l  (A4)+,-(SP)
            move.w  (A4),-(SP)
            subq.l  #8,A4
            pea     (FPKATNCONS_PACK_5_2.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L2
            lea     (ATANQ_PACK_5_2.w,PC),A2
            bsr.w   sub_408EAB38
            pea     (A0)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            bra.w   .L3
.L2:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (FPKX2_PACK_5_2.w,PC)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            lea     (FPK1.w,PC),A0
            lea     (-$24,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (FPK1.w,PC)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     (FPK1.w,PC)
            pea     (-$10,A6)
            clr.w   -(SP)
            jsr     (A3)
            pea     (FPKX2_PACK_5_2.w,PC)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$2E,A6),A1
            bsr.w   A0TOA1
            pea     (-$10,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (-$24,A6)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            lea     (ATANQ_PACK_5_2.w,PC),A2
            bsr.w   sub_408EAB38
            pea     (A0)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (FPKX2FX2_PACK_5_2.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            pea     (-$2E,A6)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.L3:
            lea     (-8,A6),A1
            move.w  (SP)+,(A1)
            move.l  (SP)+,-(A1)
            move.l  (SP)+,-(A1)
            pea     (A1)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            tst.w   D2
            bne.b   .L4
            bchg    #7,(A4)
            rts
.L4:
            pea     (FPKPI2_PACK_5_2.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
RANDTOP:
            move.w  (A4),D1
            bmi.b   .L7
            move.l  (2,A4),D2
            bpl.b   .L7
            move.l  (6,A4),D0
            bne.b   .L7
            move.l  #$401E,D0
            sub.w   D1,D0
            ble.b   .L7
            cmpi.w  #$1F,D0
            bgt.b   .L7
            bfins   D2,D1{0:D0}
            bne.b   .L7
            lsr.l   D0,D2
            mulu.l  #$41A7,D1:D2
            divu.l  #$7FFFFFFF,D1:D2
            bfffo   D1{0:0},D2
            move.w  #$401E,D0
            lsl.l   D2,D1
            sub.w   D2,D0
            tst.b   D3
            bpl.b   .L6
            move.w  D0,(-2,A4)
.L6:
            move.w  D0,(A4)+
            move.l  D1,(A4)+
            clr.l   (A4)
            move.w  (-2,A6),FPState
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            adda.w  (SP),SP
            rts
.L7:
            pea     (FPKARAND.w,PC)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (FPKPRAND.w,PC)
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            tst.b   (A4)
            bpl.b   .L8
            pea     (FPKPRAND.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.L8:
            bra.w   RESULTDELIVERED

            EVEN
