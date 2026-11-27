FP020:
            subq.l  #4,SP
            movem.l D0/A0,-(SP)
DISPBASE:
            moveq   #0,D0
            move.w  ($10,SP),D0
            bftst   D0{18:3}
            beq.b   DISP1
            btst    #0,D0
            beq.b   DISP2
DISP1:
            andi.w  #$1F,D0
            add.w   D0,D0
            move.w  D1CASE(PC,D0.w),D0
            lea     DISPBASE(PC,D0.w),A0
VECTOROFF:
            move.l  A0,(8,SP)
            movem.l (SP)+,D0/A0
            rts
DISP2:
            andi.w  #$1E,D0
            move.w  D2CASE(PC,D0.w),D0
            lea     DISPBASE(PC,D0.w),A0
            bra.b   VECTOROFF
D1CASE:
            dc.w    QADDX_PACK_4_2-DISPBASE
            dc.w    QSETENV_PACK_4_2-DISPBASE
            dc.w    QSUBX_PACK_4_2-DISPBASE
            dc.w    QGETENV_PACK_4_2-DISPBASE
            dc.w    QMULX_PACK_4_2-DISPBASE
            dc.w    QSETHV_PACK_4_2-DISPBASE
            dc.w    QDIVX_PACK_4_2-DISPBASE
            dc.w    QGETHV_PACK_4_2-DISPBASE
            dc.w    QCMPX_PACK_4_2-DISPBASE
            dc.w    QD2B-DISPBASE
            dc.w    QCMPX_PACK_4_2-DISPBASE
            dc.w    QB2D-DISPBASE
            dc.w    QREMX_PACK_4_2-DISPBASE
            dc.w    QNEG_PACK_4_2-DISPBASE
            dc.w    QX2X_PACK_4_2-DISPBASE
            dc.w    QABS_PACK_4_2-DISPBASE
            dc.w    QX2X_PACK_4_2-DISPBASE
            dc.w    QCPYSGN_PACK_4_2-DISPBASE
            dc.w    QSQRTX_PACK_4_2-DISPBASE
            dc.w    QNEXTB-DISPBASE
            dc.w    QRINTX_PACK_4_2-DISPBASE
            dc.w    QSETXCP_PACK_4_2-DISPBASE
            dc.w    QTINTX_PACK_4_2-DISPBASE
            dc.w    QPROCENTRY_PACK_4_2-DISPBASE
            dc.w    QSCALBX_PACK_4_2-DISPBASE
            dc.w    QPROCEXIT_PACK_4_2-DISPBASE
            dc.w    QLOGBX_PACK_4_2-DISPBASE
            dc.w    QTESTXCP_PACK_4_2-DISPBASE
            dc.w    QCLASSX_PACK_4_2-DISPBASE
D2CASE:
            dc.w    QADDB-DISPBASE
            dc.w    QSUBB-DISPBASE
            dc.w    QMULB-DISPBASE
            dc.w    QDIVB-DISPBASE
            dc.w    QCMPB-DISPBASE
            dc.w    QCMPB-DISPBASE
            dc.w    QREMB-DISPBASE
            dc.w    QB2X-DISPBASE
            dc.w    QX2B-DISPBASE
            dc.w    QSQRTX_PACK_4_2-DISPBASE
            dc.w    QRINTX_PACK_4_2-DISPBASE
            dc.w    QTINTX_PACK_4_2-DISPBASE
            dc.w    QSCALBX_PACK_4_2-DISPBASE
            dc.w    QLOGBX_PACK_4_2-DISPBASE
            dc.w    QCLASSB-DISPBASE
UNPACKXX:
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            movea.l A4,A3
            move.l  D4,D3
            movea.l D5,A2
            lsr.b   #1,D6
            move.l  D0,D1
            clr.w   D1
            add.l   D0,D0
            add.l   D1,D0
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
UNPACKED2:
            asl.b   #1,D6
            bvc.b   .L9
            bset    #6,D6
.L9:
            roxr.b  #1,D6
            moveq   #0,D7
            tst.w   D0
            bne.b   NAN2OPS
            swap    D0
            jmp     (A0)
UNPACKXB:
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            movea.l A4,A3
            move.l  D4,D3
            movea.l D5,A2
            lsr.b   #1,D6
            move.l  D0,D1
            clr.w   D1
            add.l   D0,D0
            add.l   D1,D0
            move.l  D6,D1
            clr.w   D1
            rol.l   #6,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            movea.l ($E,A6),A1
            bsr.w   UNPBOP
            bra.b   UNPACKED2
INVALIDOP:
            bset    #8,D6
            swap    D0
            bset    #$1E,D0
            move.l  D0,D4
            moveq   #0,D5
            movea.w #$7FFF,A4
            bra.w   PACKX
NAN2OPS:
            lea     FINI2OPS,A0
            subq.w  #2,D0
            beq.b   NANSRC
            subq.w  #2,D0
            beq.b   NANDST
            move.l  D3,D7
            move.l  #$FF0000,D1
            and.l   D1,D7
            and.l   D4,D1
            cmp.l   D7,D1
            bgt.b   NANSRC
NANDST:
            add.b   D6,D6
            movea.l A3,A4
            move.l  D3,D4
            move.l  A2,D5
NANSRC:
            bfextu  D6{11:5},D1
            subq.w  #8,D1
            beq.b   NANCMP
            subq.w  #2,D1
            bne.b   FPNANOUT
            bset    #8,D6
NANCMP:
            moveq   #2,D7
            bra.w   FINICMPS
FPNANOUT:
            bsr.b   FPNANIN
            bra.w   PACKX
FPNANIN:
            move.l  D4,D1
            bclr    #$1E,D1
            or.l    D5,D1
            bne.b   .L1
            moveq   #$15,D4
            swap    D4
            bset    #$1E,D4
.L1:
            rts
UNPXOP:
            move.w  (A1)+,D1
            bpl.b   .L1
            bset    #7,D6
            bclr    #$F,D1
.L1:
            btst    #$15,D6
            beq.b   .L2
            addq.w  #2,A1
.L2:
            move.l  (A1)+,D4
            move.l  (A1),D5
            cmpi.w  #$7FFF,D1
            beq.b   UNP0.L7
            tst.l   D4
            bpl.b   UNPNRM.L4
UNPNRM:
            ext.l   D1
            movea.l D1,A4
            rts
.L4:
            tst.l   D4
            bne.b   UNP0.L6
            tst.l   D5
            bne.b   UNP0.L6
UNP0:
            suba.l  A4,A4
            addi.l  #$20000,D0
            rts
.L6:
            subq.w  #1,D1
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L6
            bra.b   UNPNRM
.L7:
            movea.w #$7FFF,A4
            bclr    #$1F,D4
            tst.l   D4
            bne.b   .L8
            tst.l   D5
            bne.b   .L8
            addi.l  #$40000,D0
            rts
.L8:
            bset    #$1E,D4
            bne.b   .L9
            bset    #8,D6
.L9:
            addq.w  #2,D0
            rts
UNPBOP:
            move.w  .L1(PC,D1.w),D1
            jmp     UNPBOP(PC,D1.w)
.L1:
            dc.w    UNPDBL-UNPBOP
            dc.w    UNPSGL-UNPBOP
            dc.w    UNPXOP-UNPBOP
            dc.w    UNPI16-UNPBOP
            dc.w    UNPI32-UNPBOP
            dc.w    UNPC64-UNPBOP
UNPI16:
            moveq   #0,D4
            move.w  #$400E,D1
            move.l  D4,D5
            move.w  (A1),D4
            swap    D4
            bra.b   UNPIGEN
UNPI32:
            move.w  #$401E,D1
            moveq   #0,D5
            move.l  (A1),D4
UNPIGEN:
            beq.b   UNP0
            bpl.b   UNPIUNR
            bset    #7,D6
            neg.l   D4
            bmi.b   UNPNRM
UNPIUNR:
            bfffo   D4{0:0},D2
            sub.w   D2,D1
            lsl.l   D2,D4
            bra.w   UNPNRM
UNPC64:
            move.w  #$403E,D1
            move.l  (A1)+,D4
            move.l  (A1),D5
            bne.b   .L7
            tst.l   D4
            beq.w   UNP0
            bpl.b   UNPIUNR
            bset    #7,D6
            neg.l   D4
            bpl.b   UNPIUNR
            movea.w #$7FFF,A4
            bclr    #7,D6
            moveq   #$14,D4
            swap    D4
            bset    #$1E,D4
            addq.w  #2,D0
            rts
.L7:
            tst.l   D4
            bpl.b   .L8
            bset    #7,D6
            neg.l   D5
            negx.l  D4
            tst.l   D4
.L8:
            bne.w   UNP0.L6
            subi.w  #$20,D1
            exg     D4,D5
            tst.l   D4
            bpl.b   UNPIUNR
            bra.w   UNPNRM
UNPSGL:
            moveq   #0,D5
            move.l  (A1),D4
            bpl.b   .L10
            bset    #7,D6
.L10:
            bfextu  D4{1:8},D1
            beq.b   .L11
            lsl.l   #8,D4
            cmpi.b  #$FF,D1
            beq.w   UNP0.L7
            addi.w  #$3F80,D1
            bset    #$1F,D4
            bra.w   UNPNRM
.L11:
            lsl.l   #8,D4
            beq.w   UNP0
            move.w  #$3F81,D1
            bra.w   UNPIUNR
UNPDBL:
            move.l  (A1),D4
            bpl.b   .L13
            bset    #7,D6
.L13:
            move.l  (4,A1),D5
            bfextu  D4{1:11},D1
            bfextu  D5{0:11},D2
            lsl.l   #8,D4
            lsl.l   #8,D5
            lsl.l   #3,D4
            lsl.l   #3,D5
            or.w    D2,D4
            bclr    #$1F,D4
            tst.l   D1
            bne.b   .L14
            move.w  #$3C01,D1
            bra.w   UNPNRM.L4
.L14:
            cmpi.w  #$7FF,D1
            beq.w   UNP0.L7
            bset    #$1F,D4
            addi.w  #$3C00,D1
            bra.w   UNPNRM
RTSHIFT:
            cmpi.w  #$42,D0
            bls.b   .L1
            move.w  #$42,D0
.L1:
            cmpi.w  #$20,D0
            blt.b   .L2
            tst.l   D7
            sne     D3
            move.l  D5,D7
            move.l  D4,D5
            or.b    D3,D7
            moveq   #0,D4
            subi.w  #$20,D0
            bne.b   .L1
            rts
.L2:
            bfins   D7,D3{0:D0}
            sne     D3
            lsr.l   D0,D7
            bfins   D5,D7{0:D0}
            lsr.l   D0,D5
            bfins   D4,D5{0:D0}
            lsr.l   D0,D4
            or.b    D3,D7
            rts
ZNORMCOERCEX:
            moveq   #0,D7
            tst.l   D4
            bne.b   NORMX
            tst.l   D5
            bne.b   NORMX
            suba.l  A4,A4
            bra.w   PACKX
NORMX:
            tst.l   D4
            bmi.w   COERCEX
.L1:
            subq.l  #1,A4
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L1
            bra.w   COERCEX
NORMCOERCE:
            tst.l   D4
            bmi.b   COERCE
.L1:
            subq.l  #1,A4
            add.l   D7,D7
            addx.l  D5,D5
            addx.l  D4,D4
            bpl.b   .L1
COERCE:
            move.w  FPState,D1
            bftst   D1{25:2}
            beq.w   COERCEX
            bpl.w   COERCED
COERCES:
            bsr.b   SCOERCE
            bra.w   COERCESDONE
SCOERCE:
            move.l  #$3F81,D0
            sub.l   A4,D0
            ble.b   .L1
            bset    #9,D6
            movea.w #$3F81,A4
            bsr.w   RTSHIFT
.L1:
            tst.l   D5
            sne     D0
            or.b    D0,D7
            add.b   D4,D4
            roxr.l  #1,D7
            or.b    D4,D7
            moveq   #0,D5
            clr.b   D4
            tst.l   D7
            bne.b   .L2
            bclr    #9,D6
            bra.b   RNDOVERS
.L2:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L3
            tst.b   D6
            bpl.b   RNDUPS
            bra.b   RNDOVERS
.L3:
            btst    #$D,D1
            bne.b   RNDOVERS
            tst.b   D6
            bpl.b   RNDOVERS
            bra.b   RNDUPS
.L4:
            add.l   D7,D7
            bcc.b   RNDOVERS
            bne.b   RNDUPS
            btst    #8,D4
            beq.b   RNDOVERS
RNDUPS:
            addi.l  #$100,D4
            bcc.b   RNDOVERS
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERS:
            movea.w #$407E,A3
            cmpa.l  A4,A3
            blt.b   .L1
            rts
.L1:
            bset    #$A,D6
            bset    #$C,D6
            movea.w #$7FFF,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            bne.b   .L2
            rts
.L2:
            cmpi.b  #$60,D1
            beq.b   HUGES
            tst.b   D6
            bmi.b   .L3
            cmpi.b  #$20,D1
            bne.b   HUGES
            rts
.L3:
            cmpi.b  #$40,D1
            bne.b   HUGES
            rts
HUGES:
            moveq   #-1,D4
            movea.l A3,A4
            clr.b   D4
            rts
COERCED:
            bsr.b   DCOERCE
COERCESDONE:
            btst    #9,D6
            beq.w   PACKX
            move.w  A4,D3
            beq.w   PACKX
            tst.l   D4
            bne.b   .L3
            tst.l   D5
            bne.b   .L2
            suba.l  A4,A4
            bra.w   PACKX
.L2:
            subq.w  #1,A4
            add.l   D5,D5
            addx.l  D4,D4
.L3:
            bpl.b   .L2
            bra.w   PACKX
DCOERCE:
            move.l  #$3C01,D0
            sub.l   A4,D0
            ble.b   .L1
            bset    #9,D6
            movea.w #$3C01,A4
            bsr.w   RTSHIFT
.L1:
            move.l  #$7FF,D0
            and.w   D5,D0
            andi.w  #$F800,D5
            lsl.w   #5,D0
            swap    D0
            tst.l   D7
            sne     D0
            move.l  D0,D7
            tst.l   D7
            bne.b   .L2
            bclr    #9,D6
            bra.b   RNDOVERD
.L2:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L3
            tst.b   D6
            bpl.b   RNDUPD
            bra.b   RNDOVERD
.L3:
            btst    #$D,D1
            bne.b   RNDOVERD
            tst.b   D6
            bpl.b   RNDOVERD
            bra.b   RNDUPD
.L4:
            add.l   D7,D7
            bcc.b   RNDOVERD
            bne.b   RNDUPD
            btst    #$B,D5
            beq.b   RNDOVERD
RNDUPD:
            moveq   #0,D0
            move.l  #$800,D2
            add.l   D2,D5
            addx.l  D0,D4
            bcc.b   RNDOVERD
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERD:
            movea.w #$43FE,A3
            cmpa.l  A4,A3
            blt.b   .L7
            rts
.L7:
            bset    #$A,D6
            bset    #$C,D6
            movea.w #$7FFF,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            bne.b   .L8
            rts
.L8:
            cmpi.b  #$60,D1
            beq.b   HUGED
            tst.b   D6
            bmi.b   .L9
            cmpi.b  #$20,D1
            bne.b   HUGED
            rts
.L9:
            cmpi.b  #$40,D1
            bne.b   HUGED
            rts
HUGED:
            moveq   #-1,D4
            movea.l A3,A4
            move.l  #$FFFFF800,D5
            rts
COERCEX:
            move.l  A4,D0
            bpl.b   ROUNDX
            neg.l   D0
            bset    #9,D6
            suba.l  A4,A4
            bsr.w   RTSHIFT
ROUNDX:
            tst.l   D7
            bne.b   .L1
            bclr    #9,D6
            bra.b   RNDOVERX
.L1:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L15
            bmi.b   .L2
            tst.b   D6
            bpl.b   RNDUPX
            bra.b   RNDOVERX
.L2:
            btst    #13,D1
            bne.b   RNDOVERX
            tst.b   D6
            bpl.b   RNDOVERX
            bra.b   RNDUPX
.L15:
            add.l   D7,D7
            bcc.b   RNDOVERX
            bne.b   RNDUPX
            btst    #0,D5
            beq.b   RNDOVERX
RNDUPX:
            moveq   #0,D0
            addq.l  #1,D5
            addx.l  D0,D4
            bcc.b   RNDOVERX
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERX:
            movea.w #$7FFF,A3
            cmpa.l  A3,A4
            blt.b   PACKX
            bset    #$A,D6
            bset    #$C,D6
            movea.w A3,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            beq.b   PACKX
            cmpi.b  #$60,D1
            beq.b   HUGEOUT
            tst.b   D6
            bmi.b   .L18
            cmpi.b  #$20,D1
            beq.b   PACKX
            bra.b   HUGEOUT
.L18:
            cmpi.b  #$40,D1
            beq.b   PACKX
HUGEOUT:
            subq.w  #1,A4
            not.l   D4
            not.l   D5
PACKX:
            move.w  A4,D3
            movea.l ($A,A6),A3
            tst.b   D6
            bpl.b   .L21
            bset    #$F,D3
.L21:
            move.w  D3,(A3)+
            btst    #$15,D6
            beq.b   .L22
            addq.w  #2,A3
.L22:
            move.l  D4,(A3)+
            move.l  D5,(A3)
            jmp     (A0)
FINI2OPS:
            clr.w   D7
FINICMPS:
            movea.w #$A4A,A1
            move.w  (A1),D0
            clr.b   D6
            or.w    D6,D0
            move.w  D0,(A1)+
            lsr.w   #8,D6
            and.w   D6,D0
            bne.b   HALT2OP
FINISH2:
            move    D7,CCR
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            rtd     #$A
HALT2OP:
            lea     FINISH2,A4
HALTCOMMON:
            move.w  D7,-(SP)
            move.w  D0,-(SP)
            pea     (SP)
            movem.l (6,A6),D0-D3
            movem.l D0-D3,-(SP)
            addq.w  #2,SP
            movea.l (A1),A1
            jsr     (A1)
            move.l  (SP)+,D7
            jmp     (A4)
FINI1OP:
            movea.w #$A4A,A1
            clr.w   D7
            move.w  (A1),D0
            clr.b   D6
            or.w    D6,D0
            move.w  D0,(A1)+
            ror.w   #8,D6
            and.w   D6,D0
            bne.b   HALT1OP
FINISH1:
            move    D7,CCR
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            rtd     #6
HALT1OP:
            lea     FINISH1,A4
            bra.b   HALTCOMMON
RDSTSGN:
            add.b   D6,D6
RDST:
            move.l  A2,D5
            move.l  D3,D4
            movea.l A3,A4
            bra.w   PACKX
;
