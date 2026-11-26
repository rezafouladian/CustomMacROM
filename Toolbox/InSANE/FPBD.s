            include "Include/ROMHeader.s"

            EXPORT  QB2D,QD2B

            IMPORT  FP020

            SECTION "FPBD",CODE

QB2D:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  ($3C,A6),D7
            andi.w  #$3820,D7
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            andi.w  #$6000,D3
            move.w  D3,FPState
            movea.l ($42,A6),A3
            lea     (-$10,A6),A0
            move.l  A0,($42,A6)
            move.l  A3,-(SP)
            move.l  A0,-(SP)
            move.w  D7,-(SP)
            addi.w  #$E,(SP)
            bsr.w   FP020
            tst.b   D7
            beq.b   .L85
            move.l  (-$C,A6),(-$E,A6)
            move.l  (-8,A6),(-$A,A6)
.L85:
            movea.l ($46,A6),A1
            move.l  (A1),D2
            movea.l ($3E,A6),A1
            move.w  (A0)+,D0
            clr.w   (A1)
            bclr    #$F,D0
            beq.b   .L86
            move.b  #1,(A1)
.L86:
            move.l  (A0)+,D4
            move.l  (A0),D5
            move.b  #1,(4,A1)
            cmpi.w  #$7FFF,D0
            bne.b   .L88
            move.l  D4,D0
            andi.l  #$7FFFFFFF,D0
            bne.b   .L89
            tst.l   D5
            bne.b   .L89
            moveq   #$49,D0
.L87:
            move.b  D0,(5,A1)
            bra.w   sub_408E93FE.L13
.L88:
            tst.l   D4
            bne.b   sub_408E93FE.L3
            tst.l   D5
            bne.b   sub_408E93FE.L3
            moveq   #$30,D0
            bra.b   .L87
.L89:
            bset    #$1E,D4
            bne.b   .L90
            bset    #0,FPState
.L90:
            addq.l  #4,A1
            move.b  #$11,(A1)+
            move.b  #$4E,(A1)+
            bsr.b   sub_408E93FE
            move.l  D5,D4
            bsr.b   sub_408E93FE
            suba.w  #$16,A1
            bra.w   sub_408E93FE.L13
sub_408E93FE:
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
.L3:
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
            lsr.w   #8,D2
            tst.b   D2
            bne.b   .L9
            tst.w   D1
            bgt.b   .L9
            moveq   #1,D1
.L9:
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
            move.l  ($42,A6),-(SP)
            move.l  A1,-(SP)
            move.b  D5,(4,A1)
            jsr     sub_408E9936
            cmp.b   (4,A1),D5
            bcs.b   .L9
            neg.w   (2,A1)
.L13:
            move.w  FPState,D0
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            move.w  (-2,A6),FPState
            lsr.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L14
            move.l  (4,A6),(-8,A6)
            swap    D0
            clr.w   D0
            move.l  D0,(-$C,A6)
            pea     (-$C,A6)
            move.l  ($46,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($3E,A6),-(SP)
            move.w  ($3C,A6),-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
.L14:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($E,SP)
            lea     ($E,SP),SP
            move    #0,CCR
            rts
QD2B:
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  ($3C,A6),D7
            andi.w  #$3800,D7
            beq.b   .L18
            cmpi.w  #$1000,D7
            blt.b   .L16
            beq.b   .L15
            move.w  #$6000,D0
            bra.b   .L17
.L15:
            move.w  #$6040,D0
            bra.b   .L17
.L16:
            move.w  #$6060,D0
.L17:
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            and.w   D0,D3
            ori.w   #$80,D3
            bra.b   .L19
.L18:
            move.w  #$6060,D0
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            and.w   D0,D3
.L19:
            move.w  D3,FPState
            movea.l ($3E,A6),A3
            cmpi.w  #0,D7
            beq.b   .L20
            lea     (-$10,A6),A0
            move.l  A0,($3E,A6)
.L20:
            movea.l ($42,A6),A2
            lea     (4,A2),A4
            moveq   #0,D4
            move.l  D4,D5
            move.b  (A4)+,D6
            beq.b   sub_408E95AE.L6
            move.b  (A4),D0
            cmpi.b  #$49,D0
            beq.b   sub_408E95AE.L4
            cmpi.b  #$4E,D0
            bne.b   sub_408E95AE.L5
            move.b  (-1,A4),D2
            addq.l  #1,A4
            subq.b  #1,D2
            moveq   #8,D0
            cmpi.b  #4,D2
            bge.b   .L21
            subq.b  #4,D0
            add.b   D2,D0
.L21:
            bsr.b   sub_408E95AE
            move.l  D5,D4
            moveq   #0,D5
            moveq   #8,D0
            bsr.b   sub_408E95AE
            bra.b   sub_408E95AE.L3
sub_408E95AE:
            rol.l   #4,D5
            subq.b  #1,D2
            bmi.b   .L2
            move.b  (A4)+,D1
            cmpi.b  #$39,D1
            ble.b   .L1
            addi.b  #9,D1
.L1:
            andi.b  #$F,D1
            or.b    D1,D5
.L2:
            subq.w  #1,D0
            bne.b   sub_408E95AE
            rts
.L3:
            bset    #$1E,D4
            move.l  D4,D0
            swap    D0
            andi.b  #$FF,D0
            bne.b   .L4
            ori.w   #$15,D0
            swap    D0
            move.l  D0,D4
.L4:
            move.w  #$7FFF,D0
            bra.b   .L7
.L5:
            cmpi.b  #$30,D0
            bne.b   .L10
.L6:
            moveq   #0,D0
.L7:
            tst.b   (A2)
            beq.b   .L8
            bset    #$F,D0
.L8:
            movea.l ($3E,A6),A0
            move.w  D0,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.b   .L11
.L9:
            move.w  (2,A2),-(SP)
            moveq   #0,D0
            move.b  D6,D0
            subi.w  #$13,D0
            sub.w   D0,(2,A2)
            move.l  ($3E,A6),-(SP)
            move.l  ($42,A6),-(SP)
            jsr     sub_408E96D4
            move.w  (SP)+,(2,A2)
            bra.b   .L11
.L10:
            cmpi.b  #$13,D6
            bhi.b   .L9
            move.l  ($3E,A6),-(SP)
            move.l  ($42,A6),-(SP)
            jsr     sub_408E96D4
.L11:
            cmpi.w  #0,D7
            bgt.b   .L12
            btst    #5,($3D,A6)
            beq.b   .L14
            move.l  (6,A3),(8,A3)
            move.l  (2,A3),(4,A3)
            bra.b   .L14
.L12:
            pea     (-$10,A6)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #$10,(SP)
            bsr.w   FP020
            move.w  FPState,D0
            btst    #8,D0
            beq.b   .L13
            andi.w  #$E1FF,D0
            bra.b   .L15
.L13:
            cmpi.w  #$1000,D7
            ble.b   .L15
            bclr    #9,D0
            bra.b   .L15
.L14:
            move.w  FPState,D0
.L15:
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            move.w  (-2,A6),FPState
            lsr.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L16
            move.l  (4,A6),(-8,A6)
            swap    D0
            clr.w   D0
            move.l  D0,(-$C,A6)
            pea     (-$C,A6)
            move.l  ($46,A6),-(SP)
            move.l  ($42,A6),-(SP)
            move.l  A3,-(SP)
            move.w  ($3C,A6),-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
.L16:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($A,SP)
            lea     ($A,SP),SP
            move    #0,CCR
            rts
sub_408E96D4:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            blt.w   StuffIt.L9
            bsr.w   SizeExt
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
            bsr.w   Roundit_FP020BD
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            add.w   (A0),D7
            addi.w  #$400E,D7
            bsr.b   StuffIt
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
            bra.w   sub_408E9936.L4
.L7:
            ori.w   #$1400,FPState
            move.w  FPState,D2
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
            blt.w   .L14
            move.w  (A3)+,D5
            swap    D5
            rts
.L2:
            move.l  (A3)+,D5
            subq.w  #2,D1
            bgt.b   .L3
            blt.w   .L14
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
            beq.b   .L10
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
            bne.b   .L10
            cmp.w   D2,D4
            bgt.b   .L6
            bra.b   .L10
.L9:
            bsr.w   SizeExtN
            bsr.w   StoD
            bsr.w   Nrmlz10
            movea.l A4,A3
            moveq   #4,D6
            cmp.w   (A3),D0
            beq.b   .L4
.L10:
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
            bmi.b   NeedWrd_FP020BD.L2
            addi.w  #$3F,D6
            moveq   #-1,D5
            bsr.w   Roundit_FP020BD
            move.l  A1,D7
            bsr.w   StuffIt
.L14:
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
            bra.w   sub_408E9936.L4
NeedWrd_FP020BD:
            tst.w   D0
            bge.b   .L1
            clr.w   -(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            subi.w  #$10,D7
            addi.w  #$10,D0
.L1:
            rts
.L2:
            move.l  A1,D0
            cmpi.w  #$FFBE,D0
            bpl.b   .L3
            move.w  #$FFBE,D7
            move.w  D7,D0
            sub.w   D6,D7
.L3:
            add.w   D7,D6
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            addi.w  #$3F,D6
            move.w  D0,-(SP)
            moveq   #-1,D5
            movea.l A3,A1
            bsr.w   Roundit_FP020BD
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
            ori.w   #$1200,FPState
.L6:
            bra.w   sub_408E9936.L4
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
sub_408E9936:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            ble.b   .L1
            bsr.w   SizeExt
            bsr.w   XbyA
            bra.b   .L2
.L1:
            bsr.w   SizeExtN
            bsr.w   sub_408E9BC2
            bsr.w   DivX
            moveq   #0,D5
            bsr.w   Roundit_FP020BD
.L2:
            bsr.b   MakeStr
.L3:
            unlk    A6
            movem.l (SP)+,D0-D7/A1-A4
            movea.l (SP)+,A0
            lea     (8,SP),SP
            jmp     (A0)
.L4:
            move.w  FPState,D4
            andi.w  #$60,D4
            beq.b   .L3
            pea     Tbl1
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   FP020
            bra.b   .L3
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
Roundit_FP020BD:
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
            beq.b   .L8
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
            bset    #4,FPState
            move.w  FPState,D2
            move.w  D2,D4
            andi.w  #$E0,D4
            beq.b   .L4
            or.w    D0,(A2)
            bra.b   .L8
.L4:
            btst    #$E,D2
            bne.b   .L10
            btst    #$D,D2
            bne.b   .L11
            cmpi.w  #5,D5
            blt.b   .L8
.L5:
            add.w   D0,(A2)
            bcc.b   .L8
.L6:
            cmpa.l  A2,A3
            beq.b   .L7
            addq.w  #1,-(A2)
            bcs.b   .L6
            bra.b   .L8
.L7:
            move.w  #1,-(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            lea     ($10,A1),A1
.L8:
            tst.w   (A3)
            bne.b   .L9
            lea     (2,A3),A3
            subq.w  #1,D1
            subi.w  #$10,D6
.L9:
            rts
.L10:
            btst    #$D,D2
            bne.b   .L8
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L5
            bra.b   .L8
.L11:
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L5
            bra.b   .L8
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
sub_408E9BC2:
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
            bvs.w   divOver
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
divOver:
            clr.w   (A0)+
            move.w  D5,D7
            beq.b   DecrIt
            lea     (2,A1,D7.w),A2
            lea     (0,A0,D7.w),A4
            asr.w   #1,D7
            subq.w  #1,D7
            move    #0,CCR
.L1:
            subx.w  -(A2),-(A4)
            dbra    D7,.L1
            bsr.b   DecrIt
            bra.w   BgnDiv.L4
SizeExtN:
            neg.w   D0
            cmpi.w  #5208,D0
            bcs.b   allct
            move.w  #$1457,D0
            move.w  D0,D1
            neg.w   D1
            move.w  D1,(A0)
            bra.b   allct
SizeExt:
            cmpi.w  #$1390,D0
            bcs.b   allct
            move.w  #$138F,D0
            move.w  D0,(A0)
allct:
            moveq   #0,D4
            move.w  D0,D4
            addi.w  #$20F,D4
            andi.b  #$F8,D4
            cmpi.w  #$C40,D4
            bcs.b   .L1
            move.w  #$C40,D4
.L1:
            move.w  D4,D5
            asr.w   #2,D5
            move.l  D0,D1
            _StackSpace
            cmp.l   D4,D0
            bpl.b   .L2
            moveq   #$1C,D0
            _SysError
.L2:
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
            lea     Tbl2,A2
            subq.w  #7,D2
            asl.w   #2,D2
            move.l  (0,A2,D2.w),-(A1)
            bra.b   GotTen2
Third7:
            moveq   #2,D1
            lea     Tbl3,A2
            subi.w  #$E,D2
            mulu.w  #6,D2
            move.l  (2,A2,D2.w),-(A1)
            bra.b   GotTen
Frst7:
            moveq   #0,D1
            lea     Tbl1,A2
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
            movea.l (-4,A6),A1
            move    #0,CCR
            move.w  D1,D7
.L7:
            roxl    -(A1)
            dbra    D7,.L7
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
Tbl1:
            dc.w    $0001,$0005,$0019,$007D,$0271,$0C35,$3D09
Tbl2:
            dc.w    $0001,$312D,$0005,$F5E1,$001D,$CD65,$0095,$02F9
            dc.w    $02E9,$0EDD,$0E8D,$4A51,$48C2,$7395
Tbl3:
            dc.w    $0001,$6BCC,$41E9,$0007,$1AFD,$498D,$0023,$86F2
            dc.w    $6FC1,$00B1,$A2BC,$2EC5,$0378,$2DAC,$E9D9,$1158
            dc.w    $E460,$913D,$56BC,$75E2,$D631

            EVEN
