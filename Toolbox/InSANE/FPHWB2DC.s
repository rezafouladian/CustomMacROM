QL2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2800,D7
            bra.b   N2Dec
QI2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2000,D7
            bra.b   N2Dec
QC2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$3000,D7
            bra.b   N2Dec
QS2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$1000,D7
            bra.b   N2Dec
QD2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$800,D7
            bra.b   N2Dec
QX2DEC96:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            moveq   #$20,D7
            bra.b   N2Dec
QX2DEC:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            clr.w   D7
N2Dec:
            pea     (-2,A6)
            bsr.w   QPROCENTRY
            bclr    #7,($A4B).w
            move.w  (-2,A6),D3
            andi.w  #$6000,D3
            beq.b   .L1
            move.w  D3,(-4,A6)
            pea     (-4,A6)
            bsr.w   QSETENV
.L1:
            movea.l ($40,A6),A3
            lea     (-$10,A6),A0
            move.l  A0,($40,A6)
            move.l  A3,-(SP)
            move.l  A0,-(SP)
            move.w  D7,-(SP)
            addi.w  #$E,(SP)
            bsr.w   FP68K
            tst.b   D7
            beq.b   .L2
            move.l  (-$C,A6),(-$E,A6)
            move.l  (-8,A6),(-$A,A6)
.L2:
            movea.l ($44,A6),A1
            move.l  (A1),D2
            movea.l ($3C,A6),A1
            move.w  (A0)+,D0
            clr.w   (A1)
            bclr    #$F,D0
            beq.b   .L12
            move.b  #1,(A1)
.L12:
            move.l  (A0)+,D4
            move.l  (A0),D5
            move.b  #1,(4,A1)
            cmpi.w  #$7FFF,D0
            bne.b   .L14
            move.l  D4,D0
            andi.l  #$7FFFFFFF,D0
            bne.b   .L15
            tst.l   D5
            bne.b   .L15
            moveq   #$49,D0
.L13:
            move.b  D0,(5,A1)
            bra.w   BDFIN
.L14:
            tst.l   D4
            bne.b   BD1
            tst.l   D5
            bne.b   BD1
            moveq   #$30,D0
            bra.b   .L13
.L15:
            bset    #$1E,D4
            bne.b   .L16
            clr.w   -(SP)
            pea     (SP)
            bsr.w   QSETXCP
            lea     (2,SP),SP
.L16:
            addq.l  #4,A1
            move.b  #$11,(A1)+
            move.b  #$4E,(A1)+
            bsr.b   sub_408EDFC4
            move.l  D5,D4
            bsr.b   sub_408EDFC4
            suba.w  #$16,A1
            bra.w   BDFIN
sub_408EDFC4:
            moveq   #8,D0
.L1:
            rol.l   #4,D4
            moveq   #$F,D1
            and.b   D4,D1
            ori.b   #$30,D1
            cmpi.b  #$39,D1
            ble.b   .L2
            addq.b  #7,D1
.L2:
            move.b  D1,(A1)+
            subq.w  #1,D0
            bne.b   .L1
            rts
BD1:
            tst.l   D4
            bmi.b   .L5
.L4:
            subq.w  #1,D0
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L4
.L5:
            move.l  D4,D1
            move.w  D0,D1
            subi.w  #$3FFF,D1
            swap    D1
            add.w   D1,D1
            move.l  #$4D104D42,D0
            tst.l   D1
            bpl.b   .L6
            addq.w  #1,D0
.L6:
            move.l  D0,D4
            swap    D4
            mulu.w  D1,D4
            clr.w   D4
            swap    D4
            swap    D1
            move.w  D1,D5
            muls.w  D0,D5
            swap    D5
            ext.l   D5
            add.l   D5,D4
            swap    D0
            muls.w  D1,D0
            add.l   D0,D4
            swap    D4
            move.w  D2,D1
            bmi.b   .L7
            cmpi.w  #$2000,D1
            blt.b   .L8
            move.w  #$2000,D1
            bra.b   .L8
.L7:
            cmpi.w  #$E000,D1
            bgt.b   .L8
            move.w  #$E000,D1
.L8:
            swap    D2
            ror.w   #8,D2
            tst.b   D2
            bne.b   .loop
            tst.w   D1
            bgt.b   .loop
            moveq   #1,D1
.loop:
            addq.w  #1,D4
            move.w  D1,D5
            tst.b   D2
            beq.b   .L10
            add.w   D4,D5
.L10:
            cmpi.w  #$13,D5
            ble.b   .L11
            move.w  #$13,D5
.L11:
            move.w  D5,(2,A1)
            sub.w   D4,(2,A1)
            tst.w   D5
            bgt.b   .L12
            moveq   #1,D5
.L12:
            move.l  ($40,A6),-(SP)
            move.l  A1,-(SP)
            move.b  D5,(4,A1)
            jsr     sub_408EE5AA
            cmp.b   (4,A1),D5
            bcs.b   .loop
            neg.w   (2,A1)
BDFIN:
            pea     (-4,A6)
            bsr.w   QGETENV
            move.w  (-4,A6),D0
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            pea     (-2,A6)
            bsr.w   QSETENV
            ror.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   NoHalts
            move.l  (4,A6),(-6,A6)
            move.w  D0,(-$A,A6)
            pea     (-$A,A6)
            move.l  ($44,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($3C,A6),-(SP)
            move.w  D7,-(SP)
            addi.w  #$B,(SP)
            pea     (-4,A6)
            bsr.w   QGETHV
            movea.l (-4,A6),A0
            jsr     (A0)
NoHalts:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($C,SP)
            lea     ($C,SP),SP
            rts
QDEC2L:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2800,D7
            move.w  #$6000,D0
            bra.b   NoRound
QDEC2I:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2000,D7
            move.w  #$6000,D0
            bra.b   NoRound
QDEC2C:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$3000,D7
            move.w  #$6000,D0
            bra.b   NoRound
QDEC2S:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$1000,D7
            move.w  #$6040,D0
            bra.b   NoRound
QDEC2D:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$800,D7
            move.w  #$6060,D0
NoRound:
            pea     (-2,A6)
            bsr.w   QPROCENTRY
            move.w  (-2,A6),D3
            and.w   D0,D3
            ori.w   #$80,FPState
            bra.b   SetIt
QDEC2X96:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            moveq   #$20,D7
            move.w  #$6060,D0
            bra.b   Dec2N
QDEC2X:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            clr.w   D7
            move.w  #$6060,D0
Dec2N:
            pea     (-2,A6)
            bsr.w   QPROCENTRY
            bclr    #7,($A4B).w
            move.w  (-2,A6),D3
            and.w   D0,D3
            beq.b   drpad
SetIt:
            move.w  D3,(-4,A6)
            pea     (-4,A6)
            bsr.w   QSETENV
drpad:
            movea.l ($3C,A6),A3
            cmpi.w  #$20,D7
            ble.b   .L1
            lea     (-$10,A6),A0
            move.l  A0,($3C,A6)
.L1:
            movea.l ($40,A6),A2
            lea     (4,A2),A4
            moveq   #0,D4
            move.l  D4,D5
            move.b  (A4)+,D6
            beq.b   DBZSTO
            move.b  (A4),D0
            cmpi.b  #$49,D0
            beq.b   DBNFIN
            cmpi.b  #$4E,D0
            bne.b   DBZER
            move.b  (-1,A4),D2
            addq.l  #1,A4
            subq.b  #1,D2
            moveq   #8,D0
            cmpi.b  #4,D2
            bge.b   .L2
            subq.b  #4,D0
            add.b   D2,D0
.L2:
            bsr.b   .L3
            move.l  D5,D4
            moveq   #0,D5
            moveq   #8,D0
            bsr.b   .L3
            bra.b   .L6
.L3:
            rol.l   #4,D5
            subq.b  #1,D2
            bmi.b   .L5
            move.b  (A4)+,D1
            cmpi.b  #$39,D1
            ble.b   .L4
            addi.b  #9,D1
.L4:
            andi.b  #$F,D1
            or.b    D1,D5
.L5:
            subq.w  #1,D0
            bne.b   .L3
            rts
.L6:
            bset    #$1E,D4
            move.l  D4,D0
            swap    D0
            andi.b  #$FF,D0
            bne.b   DBNFIN
            ori.w   #$15,D0
            swap    D0
            move.l  D0,D4
DBNFIN:
            move.w  #$7FFF,D0
            bra.b   DBSSTO
DBZER:
            cmpi.b  #$30,D0
            bne.b   SIGDIGS
DBZSTO:
            moveq   #0,D0
DBSSTO:
            tst.b   (A2)
            beq.b   .L1
            bset    #$F,D0
.L1:
            movea.l ($3C,A6),A0
            move.w  D0,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.b   NoDigs
BrnDd:
            move.w  (2,A2),-(SP)
            moveq   #0,D0
            move.b  D6,D0
            subi.w  #$13,D0
            sub.w   D0,(2,A2)
            move.l  ($3C,A6),-(SP)
            move.l  ($40,A6),-(SP)
            jsr     BIGD2X
            move.w  (SP)+,(2,A2)
            bra.b   NoDigs
SIGDIGS:
            cmpi.b  #$13,D6
            bhi.b   BrnDd
            move.l  ($3C,A6),-(SP)
            move.l  ($40,A6),-(SP)
            jsr     BIGD2X
NoDigs:
            cmpi.w  #$20,D7
            blt.b   .L14
            bgt.b   .L12
            move.l  (6,A3),(8,A3)
            move.l  (2,A3),(4,A3)
            bra.b   .L14
.L12:
            pea     (-$10,A6)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #$10,(SP)
            bsr.w   FP68K
            pea     (-4,A6)
            bsr.w   QGETENV
            move.w  (-4,A6),D0
            btst    #8,D0
            beq.b   .L13
            andi.w  #$E1FF,D0
            bra.b   .L15
.L13:
            cmpi.w  #$1000,D7
            ble.b   .L15
            andi.w  #$FDFF,D0
            bra.b   .L15
.L14:
            pea     (-4,A6)
            bsr.w   QGETENV
            move.w  (-4,A6),D0
.L15:
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            pea     (-2,A6)
            bsr.w   QSETENV
            ror.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   NoHlts
            move.l  (4,A6),(-6,A6)
            move.w  D0,(-$A,A6)
            pea     (-$A,A6)
            subq.w  #4,SP
            move.l  ($40,A6),-(SP)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #9,(SP)
            pea     (-4,A6)
            bsr.w   QGETHV
            movea.l (-4,A6),A0
            jsr     (A0)
NoHlts:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),(8,SP)
            lea     (8,SP),SP
            rts
BIGD2X:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            blt.w   SigDiv
            bsr.w   sub_408EEA06
            bsr.w   a2b
            bsr.w   StoD
            move.l  (-$10,A6),(-$C,A6)
            bsr.w   cXb2a
            movea.l A1,A3
            move.w  #$4F,D6
            move.w  D1,D2
            movea.l A3,A2
.L1:
            subi.w  #$10,D6
            move.w  (A2)+,D0
            bne.b   .L3
            dbra    D2,.L1
.L2:
            addq.w  #1,D6
            lsl.w   #1,D0
.L3:
            bpl.b   .L2
            moveq   #-1,D5
            bsr.w   Roundit
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            add.w   (A0),D7
            addi.w  #$400E,D7
            bsr.w   StuffIt
            tst.l   D4
            bmi.b   .L5
.L4:
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L4
.L5:
            movea.l ($3C,A6),A0
            cmpi.w  #$7FFF,D7
            bcc.b   .L7
            asl.w   #1,D7
.L6:
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.w   DoneB2X
.L7:
            move.w  #2,-(SP)
            pea     (SP)
            bsr.w   QSETXCP
            move.w  #4,(SP)
            pea     (SP)
            bsr.w   QSETXCP
            lea     (2,SP),SP
            pea     (-$14,A6)
            bsr.w   QGETENV
            lea     (-$14,A6),A4
            move.w  (A4),D2
            btst    #$E,D2
            bne.b   .L8
            btst    #$D,D2
            beq.b   .L10
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L10
            bra.b   .L9
.L8:
            btst    #$D,D2
            bne.b   .L9
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L10
.L9:
            move.w  #$FFFC,D7
            moveq   #-1,D4
            moveq   #-1,D5
            bra.b   .L6
.L10:
            move.w  #$FFFE,D7
            moveq   #0,D4
            moveq   #0,D5
            bra.b   .L6
StuffIt:
            moveq   #0,D4
            moveq   #0,D5
            moveq   #0,D6
            tst.w   D1
            bgt.b   .L1
            move.w  (A3)+,D4
            swap    D4
            rts
.L1:
            move.l  (A3)+,D4
            subq.w  #2,D1
            bgt.b   .L2
            blt.w   NormIt
            move.w  (A3)+,D5
            swap    D5
            rts
.L2:
            move.l  (A3)+,D5
            subq.w  #2,D1
            bgt.b   .L3
            blt.w   NormIt
            move.w  (A3)+,D6
            swap    D6
            rts
.L3:
            move.l  (A3)+,D6
            rts
.L4:
            move.w  D1,D4
            cmp.w   D3,D1
            bge.b   .L5
            move.w  D3,D4
.L5:
            tst.w   D4
            beq.b   RtDvWS
            lea     (2,A1),A2
            lea     (2,A3),A4
            moveq   #0,D2
.L6:
            addq.w  #1,D2
            cmp.w   D2,D1
            bge.b   .L7
            clr.w   (A2)
.L7:
            cmp.w   D2,D3
            bge.b   .L8
            clr.w   (A4)
.L8:
            cmpm.w  (A4)+,(A2)+
            bne.b   RtDvWS
            cmp.w   D2,D4
            bgt.b   .L6
            bra.b   RtDvWS
SigDiv:
            bsr.w   SizeExtN
            bsr.w   StoD
            bsr.w   Nrmlz10
            movea.l A4,A3
            moveq   #4,D6
            cmp.w   (A3),D0
            beq.b   StuffIt.L4
RtDvWS:
            bhi.b   .L11
            addq.w  #1,D3
            clr.w   -(A3)
            moveq   #5,D6
.L11:
            move.w  D3,D2
            asl.w   #4,D2
            sub.w   D7,D2
            addi.w  #$3FFE,D2
            move.w  D2,-(SP)
            bsr.w   BgnDiv
            moveq   #0,D6
            move.w  (A3),D0
            bra.b   .L13
.L12:
            addq.w  #1,D6
            lsl.w   #1,D0
.L13:
            bpl.b   .L12
            move.w  (SP)+,D7
            movea.l D7,A1
            sub.w   D6,D7
            bmi.b   Dnrml
            addi.w  #$3F,D6
            moveq   #-1,D5
            bsr.w   Roundit
            move.l  A1,D7
            bsr.w   StuffIt
NormIt:
            tst.l   D4
            bmi.b   .L16
.L15:
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L15
.L16:
            movea.l ($3C,A6),A0
            asl.w   #1,D7
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.w   DoneB2X
NeedWrd:
            tst.w   D0
            bge.b   .L1
            clr.w   -(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            subi.w  #$10,D7
            addi.w  #$10,D0
.L1:
            rts
Dnrml:
            move.l  A1,D0
            cmpi.w  #$FFBE,D0
            bpl.b   .L3
            move.w  #$FFBE,D7
            move.w  D7,D0
            sub.w   D6,D7
.L3:
            add.w   D7,D6
            bsr.b   NeedWrd
            bsr.b   NeedWrd
            bsr.b   NeedWrd
            bsr.b   NeedWrd
            bsr.b   NeedWrd
            addi.w  #$3F,D6
            move.w  D0,-(SP)
            moveq   #-1,D5
            movea.l A3,A1
            bsr.w   Roundit
            movea.l A1,A3
            move.w  (SP)+,D7
            bsr.w   StuffIt
            tst.l   D4
            bmi.b   .L5
.L4:
            tst.w   D7
            ble.b   .L5
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L4
.L5:
            movea.l ($3C,A6),A0
            asl.w   #1,D7
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            tst.l   D4
            bmi.b   .L6
            move.w  #1,-(SP)
            pea     (SP)
            move.w  #$15,-(SP)
            _FP68K
            move.w  #4,(SP)
            pea     (SP)
            move.w  #$15,-(SP)
            _FP68K
            lea     (2,SP),SP
.L6:
            bra.w   DoneB2X
StoD:
            moveq   #0,D3
            movea.l (-$10,A6),A3
            subq.l  #2,A3
            clr.w   (A3)+
            movea.l ($38,A6),A0
            movea.l ($3C,A6),A4
            tst.b   (A0)
            beq.b   .L1
            bset    #7,(A4)
            bra.b   .L2
.L1:
            bclr    #7,(A4)
.L2:
            addq.l  #4,A0
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L5
.L3:
            moveq   #$F,D7
            and.b   (A0)+,D7
            movea.l A3,A4
            move.w  D3,D4
.L4:
            move.w  -(A4),D6
            mulu.w  #$A,D6
            add.l   D6,D7
            move.w  D7,(A4)
            clr.w   D7
            swap    D7
            dbra    D4,.L4
            beq.b   .L5
            move.w  D7,-(A4)
            addq.w  #1,D3
.L5:
            dbra    D0,.L3
            rts
sub_408EE5AA:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            ble.b   .L1
            bsr.w   sub_408EEA06
            bsr.w   XbyA
            bra.b   .L2
.L1:
            bsr.w   SizeExtN
            bsr.w   sub_408EE890
            bsr.w   DivX
            moveq   #0,D5
            bsr.w   Roundit
.L2:
            bsr.w   MakeStr
.L3:
            unlk    A6
            movem.l (SP)+,D0-D7/A1-A4
            movea.l (SP)+,A0
            lea     (8,SP),SP
            jmp     (A0)
DoneB2X:
            pea     (-$14,A6)
            bsr.w   QGETENV
            lea     (-$14,A6),A0
            move.w  (A0),D4
            andi.w  #$60,D4
            beq.b   sub_408EE5AA.L3
            pea     a2b.L2
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   FP68K
            pea     (-$14,A6)
            bsr.w   QGETENV
            lea     (-$14,A6),A0
            move.w  (A0),D4
            andi.w  #$FF9F,D4
            move.w  D4,(A0)
            pea     (-$14,A6)
            bsr.w   QSETENV
            pea     a2b.L2
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   FP68K
            bra.b   sub_408EE5AA.L3
MakeStr:
            movea.l (-$C,A6),A1
            clr.l   (A1)
            moveq   #0,D3
            tst.w   D6
            movea.l A1,A2
            bmi.b   .L3
            addq.w  #1,D1
.BinLoop:
            moveq   #$F,D5
            cmp.w   D5,D6
            bge.b   .L1
            move.w  D6,D5
.L1:
            subq.w  #1,D1
            blt.b   .L2
            move.w  (A3)+,D2
.L2:
            movea.l A1,A2
            add.w   D2,D2
            move.l  D3,D7
            lea     (4,A2),A2
.L5:
            move.l  -(A2),D0                        ; next long of BCD string
            abcd    D0,D0
            ror.l   #8,D0
            abcd    D0,D0
            ror.l   #8,D0
            abcd    D0,D0
            ror.l   #8,D0
            abcd    D0,D0
            ror.l   #8,D0
            move.l  D0,(A2)
            dbra    D7,.L5
            moveq   #0,D0
            abcd    D0,D0
            beq.b   .L6                             ; no carry out
            addq.l  #1,D3                           ; add a long to the string
            move.l  D0,-(A2)
.L6:
            dbra    D5,.L2
            subi.w  #16,D6
            bge.b   .BinLoop
            movea.l ($38,A6),A0                     ; decimal record
            addq.w  #4,A0                           ; string
            lea     (1,A0),A1
            moveq   #0,D5
            move.b  (A0),D5
.L7:
            bsr.b   BD1OUT
            bsr.b   BD1OUT
            bsr.b   BD1OUT
            bsr.b   BD1OUT
            dbra    D3,.L7
            move.w  A1,D0
            sub.w   A0,D0
            subq.b  #1,D0
            beq.b   .L3
            move.b  D0,(A0)
            rts
.L3:                                        ; RtnZero
            movea.l ($38,A6),A0
            addq.w  #4,A0
            move.w  #$130,(A0)
            rts
BD1OUT:
            moveq   #0,D1
            move.b  (A2)+,D1
            ror.w   #4,D1
            bsr.b   BD1DIGOUT
            rol.w   #4,D1
BD1DIGOUT:
            tst.w   D6
            bpl.b   .L1
            tst.b   D1
            beq.b   .L3
            moveq   #0,D6
.L1:
            subq.l  #1,D5
            bmi.b   .L2
            ori.b   #$30,D1
            move.b  D1,(A1)
.L2:
            addq.l  #1,A1
            sub.b   D1,D1
.L3:
            rts
XbyA:
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D6
            movea.l ($3C,A6),A0
            move.w  (A0)+,D7
            bclr    #$F,D7
            subi.w  #$403F,D7
            add.w   D6,D7
            move.w  (A0)+,D3
            move.w  (A0)+,D4
            move.w  (A0)+,D5
            move.w  (A0)+,D6
            movea.l (-4,A6),A3
            adda.w  #$10,A3
            movea.l (-4,A6),A1
            subq.l  #2,A1
            movea.l (-$C,A6),A4
            subq.l  #2,A4
            move.w  (A1),D0
            move.w  D0,D2
            mulu.w  D6,D2
            move.l  D2,(A3)
            move.w  D0,D2
            mulu.w  D4,D2
            move.l  D2,-(A3)
            clr.w   -(A3)
            lea     (4,A3),A3
            move.w  D0,D2
            mulu.w  D5,D2
            add.l   D2,(A3)
            mulu.w  D3,D0
            move.l  D0,(A4)+
            addx.l  -(A4),-(A3)
            movea.l D1,A2
            subq.w  #1,D1
            bmi.b   .L4
.L1:
            lea     (4,A3),A3
            move.w  -(A1),D0
            move.w  D0,D2
            mulu.w  D6,D2
            add.l   D2,(A3)
            move.w  D0,D2
            mulu.w  D4,D2
            move.l  D2,(A4)+
            addx.l  -(A4),-(A3)
            bcc.b   .L2
            move.w  #1,-(A3)
            bra.b   .L3
.L2:
            clr.w   -(A3)
.L3:
            lea     (4,A3),A3
            move.w  D0,D2
            mulu.w  D5,D2
            add.l   D2,(A3)
            mulu.w  D3,D0
            move.l  D0,(A4)+
            addx.l  -(A4),-(A3)
            dbra    D1,.L1
.L4:
            move.l  A2,D1
            addq.w  #4,D1
            move.w  D1,D6
            addq.w  #1,D6
            asl.w   #4,D6
            add.w   D7,D6
            moveq   #0,D5
Roundit:
            tst.w   D6
            bge.b   .L2
            cmpi.w  #$FFBE,D6
            bpl.b   .L1
            move.w  #$FFBE,D6
.L1:
            clr.w   -(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            blt.b   .L1
.L2:
            bsr.w   RndStk
            tst.w   D5
            beq.w   .L9
            move.w  D6,D2
            lsr.w   #4,D2
            lsl.w   #1,D2
            lea     (0,A3,D2.w),A2
            move.w  (A2),D4
            move.w  D6,D3
            andi.w  #$F,D3
            move.w  #$8000,D0
            ror.w   D3,D0
            and.w   D0,D4
            beq.b   .L3
            addq.w  #1,D5
.L3:
            move.w  #4,-(SP)
            pea     (SP)
            bsr.w   QSETXCP
            lea     (2,SP),SP
            pea     (-$14,A6)
            bsr.w   QGETENV
            lea     (-$14,A6),A0
            move.w  (A0),D2
            bclr    #7,D2
            tst.b   ($A4B).w
            bpl.b   .L4
            bset    #7,D2
.L4:
            move.w  D2,D4
            andi.w  #$E0,D4
            beq.b   .L5
            or.w    D0,(A2)
            bra.b   .L9
.L5:
            btst    #$E,D2
            bne.b   .L11
            btst    #$D,D2
            bne.b   .L12
            cmpi.w  #5,D5
            blt.b   .L9
.L6:
            add.w   D0,(A2)
            bcc.b   .L9
.L7:
            cmpa.l  A2,A3
            beq.b   .L8
            addq.w  #1,-(A2)
            bcs.b   .L7
            bra.b   .L9
.L8:
            move.w  #1,-(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            lea     ($10,A1),A1
.L9:
            tst.w   (A3)
            bne.b   .L10
            lea     (2,A3),A3
            subq.w  #1,D1
            subi.w  #$10,D6
.L10:
            rts
.L11:
            btst    #$D,D2
            bne.b   .L9
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L6
            bra.b   .L9
.L12:
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L6
            bra.b   .L9
RndStk:
            clr.w   D5
            move.w  D6,D3
            addq.w  #1,D3
            move.l  D3,D4
            lsr.w   #4,D4
            cmp.w   D1,D4
            ble.b   .L1
            rts
.L1:
            andi.w  #$F,D3
            move.w  #$8000,D0
            ror.w   D3,D0
            move.w  D4,D2
            lsl.w   #1,D2
            lea     (0,A3,D2.w),A2
            and.w   (A2),D0
            beq.b   .L2
            moveq   #4,D5
.L2:
            move.w  #$7FFF,D0
            lsr.w   D3,D0
            and.w   (A2)+,D0
            beq.b   .L5
.L3:
            addq.w  #2,D5
            rts
.L4:
            tst.w   (A2)+
            bne.b   .L3
.L5:
            addq.w  #1,D4
            cmp.w   D1,D4
            ble.b   .L4
            rts
sub_408EE890:
            movea.l ($3C,A6),A0
            move.w  (A0)+,D6
            bclr    #$F,D6
            subi.w  #$400C,D6
            movea.l (-$10,A6),A3
            suba.w  #$34,A3
            move.l  (A0)+,(A3)
            move.l  (A0)+,(4,A3)
            moveq   #3,D3
Nrmlz10:
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            sub.w   (A0),D7
            move.w  D1,D5
            asl.w   #1,D5
            move.w  (A1),D0
            bmi.b   .L3
.L1:
            subq.w  #1,D7
            move.w  D1,D4
            lea     (2,A1,D5.w),A0
            move    #0,CCR
.L2:
            roxl    -(A0)
            dbra    D4,.L2
            bpl.b   .L1
            move.w  (A1),D0
.L3:
            rts
DivX:
            sub.w   D7,D6
            ble.w   BgnDiv.L6
            move.w  D6,D4
            asr.w   #4,D6
            andi.w  #$F,D4
            beq.b   .L2
            addq.w  #1,D3
            clr.w   -(A3)
            subq.w  #1,D4
.L1:
            asl     (8,A3)
            roxl    (6,A3)
            roxl    (4,A3)
            roxl    (2,A3)
            roxl    (A3)
            dbra    D4,.L1
            bra.b   BgnDiv
.L2:
            cmp.w   (A3),D0
            bhi.b   .L3
            addq.w  #1,D3
            clr.w   -(A3)
            bra.b   BgnDiv
.L3:
            subq.w  #1,D6
BgnDiv:
            bsr.b   PadIt
            movea.l A3,A0
.L1:
            move.l  (A0),D2
            divu.w  D0,D2
            bvs.w   DecrIt.L2
            swap    D2
            move.l  D2,(A0)
            swap    D2
            lea     (2,A0),A0
            cmpi.w  #2,D5
            blt.b   .L4
            beq.b   .L2
            move.w  D5,D7
            bclr    #1,D7
            bsr.b   MandS
            moveq   #0,D4
            move.w  -(A4),D1
            subx.w  D4,D1
            move.w  D1,(A4)
            negx.w  D7
            tst.w   D7
            bne.b   .L2
            bsr.b   DecrIt
.L2:
            move.w  D5,D7
            btst    #1,D7
            bne.b   .L3
            subq.w  #2,D7
.L3:
            bsr.b   MandS
            negx.w  D7
            tst.w   D7
            bne.b   .L4
            bsr.b   DecrIt
.L4:
            dbra    D6,.L1
.L5:
            suba.l  A3,A0
            move.w  A0,D6
            move.w  D3,D1
            asl.w   #3,D6
            subq.w  #3,D6
            rts
.L6:
            movea.l A3,A0
            clr.w   -(A3)
            bra.b   .L5
PadIt:
            move.w  D1,D7
            add.w   D6,D7
            addq.w  #1,D7
            sub.w   D3,D7
            ble.b   .L2
            move.w  D3,D2
            asl.w   #1,D2
            lea     (2,A3,D2.w),A2
            add.w   D7,D3
            asr.w   #1,D7
.L1:
            clr.l   (A2)+
            dbra    D7,.L1
.L2:
            rts
MandS:
            lea     (2,A1,D7.w),A2
            lea     (2,A0,D7.w),A4
            subq.w  #2,D7
            asr.w   #2,D7
            move    #0,CCR
.L1:
            move.l  -(A2),D4
            mulu.w  D2,D4
            move.l  -(A4),D1
            subx.l  D4,D1
            move.l  D1,(A4)
            dbra    D7,.L1
            rts
DecrIt:
            subq.w  #1,(-2,A0)
            move.l  D5,D1
            lea     (2,A1,D1.w),A2
            lea     (2,A0,D1.w),A4
            asr.w   #1,D1
            move    #0,CCR
.L1:
            addx.w  -(A2),-(A4)
            dbra    D1,.L1
            bcc.b   DecrIt
            rts
.L2:
            clr.w   (A0)+
            move.w  D5,D7
            beq.b   DecrIt
            lea     (2,A1,D7.w),A2
            lea     (0,A0,D7.w),A4
            asr.w   #1,D7
            subq.w  #1,D7
            move    #0,CCR
.L3:
            subx.w  -(A2),-(A4)
            dbra    D7,.L3
            bsr.b   DecrIt
            bra.w   BgnDiv.L4
SizeExtN:
            neg.w   D0
            cmpi.w  #$1458,D0
            bcs.b   sub_408EEA06.L1
            move.w  #$1457,D0
            move.w  D0,D1
            neg.w   D1
            move.w  D1,(A0)
            bra.b   sub_408EEA06.L1
sub_408EEA06:
            cmpi.w  #$1390,D0
            bcs.b   .L1
            move.w  #$138F,D0
            move.w  D0,(A0)
.L1:
            moveq   #0,D4
            move.w  D0,D4
            addi.w  #$20F,D4
            andi.b  #$F8,D4
            cmpi.w  #$C40,D4
            bcs.b   .L2
            move.w  #$C40,D4
.L2:
            move.w  D4,D5
            asr.w   #2,D5
            move.l  D0,D1
            _StackSpace
            cmp.l   D4,D0
            bpl.b   .L3
            moveq   #$1C,D0
            _SysError
.L3:
            move.l  D1,D0
            movea.l (SP)+,A1
            suba.w  D4,SP
            move.l  A1,-(SP)
            lea     (-$28,A6),A1
            move.l  A1,(-4,A6)
            suba.w  D4,A1
            move.l  A1,(-$10,A6)
            adda.w  D5,A1
            move.l  A1,(-$C,A6)
            adda.w  D5,A1
            move.l  A1,(-8,A6)
            movea.l (-4,A6),A1
            moveq   #0,D2
            move.w  D0,D2
            divu.w  #$15,D2
            move.w  D2,D0
            swap    D2
            cmpi.w  #7,D2
            blt.b   Frst7
            cmpi.w  #$E,D2
            bge.b   Third7
            moveq   #1,D1
            lea     a2b.L3,A2
            subq.w  #7,D2
            asl.w   #2,D2
            move.l  (0,A2,D2.w),-(A1)
            bra.b   GotTen2
Third7:
            moveq   #2,D1
            lea     a2b.L4,A2
            subi.w  #$E,D2
            mulu.w  #6,D2
            move.l  (2,A2,D2.w),-(A1)
            bra.b   GotTen
Frst7:
            moveq   #0,D1
            lea     a2b.L2,A2
            asl.w   #1,D2
GotTen:
            move.w  (0,A2,D2.w),-(A1)
GotTen2:
            tst.w   D0
            bne.b   MakeTen
            rts
MakeTen:
            bsr.b   a2c
            moveq   #3,D2
            movea.l (-8,A6),A2
            subq.l  #4,A2
            move.l  #$4D6E2EF5,(A2)
            move.l  #$1B1AE,-(A2)
            bra.b   BigLoop
DoItAgn:
            bsr.b   a2c
notOdd:
            bsr.b   bXb2b
BigLoop:
            asr.w   #1,D0
            bcc.b   notOdd
            bsr.b   cXb2a
            tst.w   D0
            bgt.b   DoItAgn
            rts
cXb2a:
            move.w  D2,D1
            add.w   D3,D1
            addq.w  #1,D1
            move.w  D3,D7
            addq.w  #1,D7
            lsr.w   #1,D7
            movea.l (-4,A6),A1
.L1:
            clr.l   -(A1)
            dbra    D7,.L1
            movea.l (-4,A6),A4
            subq.l  #2,A4
            movea.l (-8,A6),A2
            subq.l  #2,A2
            move.w  D2,D5
            bra.b   .L3
.L2:
            clr.w   -(A1)
            subq.l  #2,A2
            subq.l  #2,A4
.L3:
            movea.l A4,A1
            movea.l (-$C,A6),A3
            move.w  D3,D6
.L4:
            move.w  -(A3),D7
            mulu.w  (A2),D7
            subq.w  #2,A1
            add.l   D7,(A1)
            bcc.b   .L6
            movea.l A1,A0
.L5:
            addq.l  #1,-(A0)
            bcs.b   .L5
.L6:
            dbra    D6,.L4
            dbra    D5,.L2
            tst.w   (A1)
            bne.b   .L7
            lea     (2,A1),A1
            subq.w  #1,D1
.L7:
            rts
a2c:
            move.w  D1,D3
            movea.l (-4,A6),A1
            movea.l (-$C,A6),A3
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A3)
            dbra    D1,.L1
            rts
bXb2b:
            move.w  D2,D1
            move.w  D1,D7
            asl.w   #1,D1
            addq.w  #1,D1
            movea.l (-4,A6),A1
.L1:
            clr.l   -(A1)
            dbra    D7,.L1
            move.w  D2,D5
            subq.w  #1,D5
            bmi.b   doSqrs
            movea.l (-4,A6),A4
            subq.l  #4,A4
            movea.l (-8,A6),A2
            subq.l  #2,A2
            bra.b   .L3
.L2:
            subq.w  #2,A2
            subq.w  #4,A4
.L3:
            movea.l A4,A1
            movea.l A2,A3
            move.w  D5,D6
.L4:
            move.w  -(A3),D7
            mulu.w  (A2),D7
            subq.w  #2,A1
            add.l   D7,(A1)
            bcc.b   .L6
            movea.l A1,A0
.L5:
            addq.l  #1,-(A1)
            bcs.b   .L5
            movea.l A0,A1
.L6:
            dbra    D6,.L4
            dbra    D5,.L2
dblIt:
            movea.l (-4,A6),A1
            move    #0,CCR
            move.w  D1,D7
.L1:
            roxl    -(A1)
            dbra    D7,.L1
doSqrs:
            movea.l (-4,A6),A1
            movea.l (-8,A6),A2
.L9:
            move.w  -(A2),D7
            mulu.w  D7,D7
            add.l   D7,-(A1)
            bcc.b   .L11
            movea.l A1,A0
.L10:
            addq.l  #1,-(A1)
            bcs.b   .L10
            movea.l A0,A1
.L11:
            dbra    D2,.L9
            tst.w   (A1)
            bne.b   .L12
            lea     (2,A1),A1
            subq.w  #1,D1
.L12:
            tst.w   D0
            bne.b   a2b
            rts
a2b:
            move.w  D1,D2
            movea.l (-4,A6),A1
            movea.l (-8,A6),A2
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A2)
            dbra    D1,.L1
            rts
.L2:
            dc.w    $0001,$0005,$0019,$007D,$0271,$0C35,$3D09
.L3:
            dc.w    $0001,$312D,$0005,$F5E1,$001D,$CD65,$0095,$02F9
            dc.w    $02E9,$0EDD,$0E8D,$4A51,$48C2,$7395
.L4:
            dc.w    $0001,$6BCC,$41E9,$0007,$1AFD,$498D,$0023,$86F2
            dc.w    $6FC1,$00B1,$A2BC,$2EC5,$0378,$2DAC,$E9D9,$1158
            dc.w    $E460,$913D,$56BC,$75E2,$D631,0
