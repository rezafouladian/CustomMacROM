BITBLT:
            lea     (-$268,A6),A0
            move.w  (-$74,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            move.w  D0,(A0)
            move.w  (-$72,A6),D0
            sub.w   (2,A3),D0
            add.w   (2,A2),D0
            move.w  D0,(2,A0)
            movea.l A0,A2
            lea     (-$74,A6),A3
            move.w  (4,A3),D0
            sub.w   (A3),D0
            ble.w   .L32
            move.w  D0,(-$260,A6)
            move.w  #4,D3
            move.w  (A2),D0
            sub.w   (6,A4),D0
            move.w  D0,(-$25A,A6)
            move.w  (A3),D0
            sub.w   (6,A5),D0
            move.w  D0,(-$25C,A6)
            move.w  (-$98,A6),D2
            btst    #3,D2
            beq.b   .L2
            move.w  (-$8E,A6),D1
            bne.b   .L1
            moveq   #$F,D7
            and.w   (A3),D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            bra.w   .L5
.L1:
            moveq   #0,D6
            move.w  (-$8A,A6),D6
            addq.w  #1,D6
            divu.w  (-$8E,A6),D6
            subq.w  #1,D6
            and.w   (A3),D6
            mulu.w  D1,D6
            move.w  (-$8C,A6),D7
            bra.w   .L5
.L2:
            move.l  (A4),D0
            cmp.l   (A5),D0
            bne.b   .L4
            move.w  (-$25A,A6),D0
            cmp.w   (-$25C,A6),D0
            bgt.b   .L4
            blt.b   .L3
            move.w  (2,A2),D0
            sub.w   (8,A4),D0
            move.w  (2,A3),D1
            sub.w   (8,A5),D1
            cmp.w   D1,D0
            bge.b   .L4
            move.w  (-$6E,A6),D2
            sub.w   (-$72,A6),D2
            add.w   D0,D2
            cmp.w   D1,D2
            ble.b   .L4
            neg.w   D3
            bra.b   .L4
.L3:
            move.w  (-$260,A6),D0
            subq.w  #1,D0
            add.w   D0,(-$25A,A6)
            add.w   D0,(-$25C,A6)
            neg.l   (-$1BC,A6)
            neg.l   (-$7C,A6)
.L4:
            move.w  (2,A3),D6
            sub.w   (8,A5),D6
            ext.l   D6
            lsl.l   D4,D6
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            ext.l   D1
            move.w  (-$1C2,A6),D0
            lsl.l   D0,D1
            sub.l   D1,D6
            moveq   #$1F,D0
            and.l   D0,D6
            neg.l   D6
            move.w  (4,A4),D0
            andi.w  #$7FFF,D0
            muls.w  (-$25A,A6),D0
            movea.l (A4),A4
            adda.l  D0,A4
            sub.l   D6,D1
            asr.l   #5,D1
            add.l   D1,D1
            add.l   D1,D1
            adda.l  D1,A4
.L5:
            move.w  (2,A3),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            move.w  (4,A5),D0
            andi.w  #$7FFF,D0
            muls.w  (-$25C,A6),D0
            movea.l (A5),A5
            adda.l  D0,A5
            move.l  D1,D0
            asr.l   #5,D1
            lsl.l   #2,D1
            adda.l  D1,A5
            tst.w   (-$8E,A6)
            beq.b   .L6
            movea.l (-$88,A6),A4
            adda.w  D6,A4
            swap    D6
            move.w  D1,D6
            and.w   D7,D6
            move.w  D6,(-$90,A6)
.L6:
            move.l  D4,D5
            moveq   #$1F,D2
            and.l   D2,D0
            moveq   #-1,D4
            lsr.l   D0,D4
            move.w  (6,A3),D1
            sub.w   (2,A3),D1
            ble.w   .L32
            move.w  D1,(-$280,A6)
            ext.l   D1
            lsl.l   D5,D1
            add.l   D0,D1
            moveq   #-1,D5
            and.l   D1,D2
            beq.b   .L7
            lsr.l   D2,D5
            not.l   D5
.L7:
            subq.l  #1,D1
            asr.l   #5,D1
            move.w  D1,(-$26E,A6)
            move.l  D1,D2
            add.l   D1,D1
            add.l   D1,D1
            move.l  D1,D0
            addq.l  #4,D0
            movea.w D3,A0
            tst.w   D3
            bpl.b   .L8
            neg.l   D0
            adda.l  D1,A5
            adda.l  D1,A4
            exg     D4,D5
.L8:
            move.w  (-$1BA,A6),(-$25E,A6)
            sub.w   D0,(-$25E,A6)
            movea.w (-$7A,A6),A3
            suba.w  D0,A3
            move.w  (-$98,A6),D0
            bne.b   .L10
            tst.w   (-$104,A6)
            bne.b   .L10
            move.w  D6,D1
            andi.w  #7,D1
            bne.b   .L10
            tst.w   D2
            ble.b   .L10
            move.w  D6,D1
            asr.w   #3,D1
            adda.w  D1,A4
            movea.l ($1B60).w,A1
            tst.w   D3
            bpl.b   .L9
            movea.l ($1B64).w,A1
.L9:
            jmp     (A1)
.L10:
            cmpi.w  #$20,D0
            bcs.w   .L24
            move.l  (-$114,A6),(-$A4,A6)
            cmpi.w  #$40,D0
            bcc.w   .L32
            cmpi.w  #$30,D0
            blt.b   .L12
            cmpi.w  #$32,D0
            beq.b   .L12
            cmpi.w  #$3A,D0
            bne.w   .L32
            tst.w   (-$8E,A6)
            bne.b   .L12
            moveq   #-1,D2
            moveq   #$F,D3
            movea.l (-$88,A6),A1
.L11:
            cmp.l   (A1)+,D2
            dbne    D3,.L11
            beq.w   .L19
.L12:
            btst    #3,D0
            beq.b   .L14
            move.w  (-$8E,A6),D2
            beq.b   .L13
            move.b  #1,(-$270,A6)
            swap    D6
            move.w  D6,(-$27E,A6)
            clr.w   D6
            swap    D6
            asl.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$D4,A6),D3
            subq.w  #1,D3
            not.w   D3
            asl.w   #3,D2
            subq.w  #1,D2
            and.w   D3,D2
            move.w  D2,(-$8C,A6)
            bra.b   .L15
.L13:
            clr.b   (-$270,A6)
            lea     ([-$88.w,A6],D7.w*4),A4
            move.w  D7,(-$27E,A6)
            moveq   #0,D6
            move.l  D6,(-$27C,A6)
            move.w  #$1F,(-$8C,A6)
            bra.b   .L15
.L14:
            st      (-$270,A6)
            move.w  #$FFFF,(-$8C,A6)
.L15:
            andi.w  #$37,D0
            moveq   #$20,D2
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            divu.w  D7,D2
            move.w  D2,(-$278,A6)
            move.w  D2,(-$286,A6)
            moveq   #0,D3
            move.l  D7,-(SP)
            moveq   #$20,D1
            move.w  A0,(-$24C,A6)
            cmpa.w  #0,A0
            bpl.b   .L16
            neg.l   (SP)
            neg.l   D1
            moveq   #$20,D3
            sub.w   D2,D3
            add.l   D3,D6
.L16:
            movea.l D1,A2
            move.l  D5,(-$274,A6)
            movea.l (-$10C,A6),A0
            move.w  (-$10E,A6),D5
            clr.b   (-$26F,A6)
            move.w  (-$26E,A6),D1
            subq.w  #1,D1
            move.w  D1,(-$26E,A6)
            bmi.b   .L17
            mulu.w  (-$278,A6),D1
            subq.w  #1,D1
            move.w  D1,(-$276,A6)
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L17:
            subq.w  #1,(-$278,A6)
            move.l  D3,(-$284,A6)
            cmpi.w  #$30,D0
            bgt.b   .L18
            cmpi.w  #$10,D7
            bge.b   .L20
            add.w   D0,D0
            move.w  D0,D1
            bfextu  (-$114,A6){0:D7},D0
            movea.l D0,A3
            move.l  D3,D0
            bra.w   .L27
.L18:
            move.l  D3,D0
            moveq   #$3C,D1
            bfextu  (-$118,A6){0:D7},D5
            bra.w   .L27
.L19:
            move.w  (-$D4,A6),D7
            move.l  D5,(-$274,A6)
            movea.l (-$118,A6),A0
            bfextu  (-$118,A6){0:D7},D5
            lea     PrivlgVector,A2
            suba.w  D7,A2
            bfextu  (-$114,A6){0:D7},D0
            move.w  (-$76,A6),D1
            movea.l ($1CE8).w,A1
            adda.l  (-4,A1,D1.w*4),A1
            bra.w   .L28
.L20:
            andi.w  #7,D0
            beq.b   .L23
.L21:
            cmpi.w  #$10,D7
            beq.b   .L22
            movea.l ($1CE4).w,A1
            adda.l  (0,A1,D0.w*4),A1
            jmp     ([$1CF0.w])
.L22:
            movea.l ($1CE0).w,A1
            adda.l  (0,A1,D0.w*4),A1
            move.l  D4,D1
            jmp     ([$1CEC.w])
.L23:
            lea     (-$FA,A6),A1
            move.w  (A1)+,D1
            cmp.w   (A1)+,D1
            bne.b   .L21
            cmp.w   (A1),D1
            bne.b   .L21
            addq.w  #1,D1
            andi.w  #$FFFE,D1
            cmpi.w  #$8000,D1
            bne.b   .L21
            addq.w  #8,D0
            bra.b   .L21
.L24:
            andi.w  #$B,D0
            move.w  D0,D1
            andi.w  #3,D0
            add.w   D0,D1
            cmpi.w  #8,D1
            bge.b   .L25
            cmpi.w  #4,D1
            beq.b   .L26
            tst.w   (-$104,A6)
            beq.b   .L26
            addi.w  #$18,D1
.L25:
            tst.w   (-$8E,A6)
            beq.b   .L26
            addq.w  #8,D1
.L26:
            tst.w   D2
            bne.b   .L27
            addi.w  #$20,D1
.L27:
            lea     ($1AC0).w,A1
            movea.l (0,A1,D1.w*2),A1
.L28:
            move.l  D4,(-$26C,A6)
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
.L29:
            move.l  (-$26C,A6),D1
            move.w  (-$26E,A6),D2
            jmp     (A1)
.L30:
            adda.w  (-$25E,A6),A4
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
            bra.b   .L32
.L31:
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            swap    D6
            move.w  (-$90,A6),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
.L32:
            rts
.L33:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
            rts
.L39:
            tst.b   (-$270,A6)
            beq.b   .L36
            bpl.b   .L35
            adda.w  (-$25E,A6),A4
            move.l  (-$27C,A6),D6
            bra.b   .L38
.L34:
            tst.b   (-$270,A6)
            beq.b   .L36
            bpl.b   .L35
            adda.w  (-$25E,A6),A4
            bra.b   .L38
.L35:
            moveq   #0,D0
            move.w  (-$27E,A6),D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            move.w  D6,(-$27E,A6)
            bra.b   .L37
.L36:
            move.w  (-$27E,A6),D1
            addq.w  #1,D1
            andi.w  #$F,D1
            move.w  D1,(-$27E,A6)
            lea     ([-$88.w,A6],D1.w*4),A4
.L37:
            move.l  (-$27C,A6),D6
.L38:
            clr.b   (-$26F,A6)
            move.l  (-$284,A6),D0
            adda.w  (-$7A,A6),A5
            subq.w  #1,(-$260,A6)
            bne.w   .L29
            addq.w  #4,SP
            rts
bArith16Tab:
            dc.w    0,$0FA0,0,$0880,0,$0730,0,$0B10
            dc.w    0,$1250,0,$0C60,0,$09C0,0,$0D90
            dc.w    0,$0ED0
bArith32Tab:
            dc.w    0,$0EEC,0,$07EC,0,$06BC,0,$0A7C
            dc.w    0,$11FC,0,$0BFC,0,$094C,0,$0D2C
            dc.w    0,$0E6C
bHiliteTab:
            dc.w    0,$1018,0,$1018,0,$1018,0,$1018
            dc.w    0,$10A8
            ds.b    4
bLeft0:
            move.l  D4,D1
            move.w  (-$26E,A6),D2
            move.l  (A4),D0
            adda.w  A0,A4
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            subq.w  #1,D2
            beq.b   .L3
            suba.w  A0,A4
            suba.w  A0,A5
            bra.b   .L2
.L1:
            move.l  -(A4),-(A5)
.L2:
            move.l  -(A4),-(A5)
            subq.w  #2,D2
            bgt.b   .L1
            beq.b   .L2
            adda.w  A0,A4
            adda.w  A0,A5
.L3:
            move.l  D5,D1
            move.l  (A4),D0
            adda.w  A0,A4
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            adda.w  (-$25E,A6),A4
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   bLeft0
            bra.w   BITBLT.L32
bSetup0:
            move.w  D2,D6
            move.l  D4,D2
            not.l   D2
            bne.b   .L1
            addq.w  #1,D6
.L1:
            move.l  D5,D3
            not.l   D3
            bne.b   .L2
            addq.w  #1,D6
.L2:
            move.w  (-$260,A6),D7
            subq.w  #1,D7
            movea.w (-$25E,A6),A2
            lea     sub_4082CDD2.L1,A0
            subq.w  #1,D6
            beq.b   .L3
            moveq   #$F,D0
            and.w   D6,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D6
.L3:
            move.l  D2,D1
            beq.b   .L4
            move.l  (A4)+,D0
            and.l   D4,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L4:
            move.w  D6,D0
            jmp     (A0)
sub_4082CDD2:
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            dbra    D0,sub_4082CDD2
.L1:
            move.l  D3,D1
            beq.b   .L2
            move.l  (A4)+,D0
            and.l   D5,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L2:
            adda.w  A2,A4
            adda.w  A3,A5
            dbra    D7,bSetup0.L3
            bra.w   BITBLT.L32
bEND0:
            and.l   D5,D1
bMAIN0:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN0
            beq.b   bEND0
            bra.w   BITBLT.L30
            ds.b    14
bEND1:
            and.l   D5,D1
bMAIN1:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN1
            beq.b   bEND1
            bra.w   BITBLT.L30
            ds.b    4
bEND2:
            and.l   D5,D1
bMAIN2:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            eor.l   D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN2
            beq.b   bEND2
            bra.w   BITBLT.L30
            ds.b    4
bEND3:
            and.l   D5,D1
bMAIN3:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN3
            beq.b   bEND3
            bra.w   BITBLT.L30
            dc.w    0
bcEnd0:
            and.l   D5,D1
bcMain0:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            move.l  D0,-(SP)
            not.l   D0
            and.l   D4,D0
            and.l   D3,(SP)
            or.l    (SP)+,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain0
            beq.b   bcEnd0
            bra.w   BITBLT.L30
            ds.b    4
bcEnd1:
            and.l   D5,D1
bcMain1:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            not.l   D0
            and.l   D3,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain1
            beq.b   bcEnd1
            bra.w   BITBLT.L30
            ds.b    12
bcEnd3:
            and.l   D5,D1
bcMain3:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            not.l   D0
            and.l   D4,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain3
            beq.b   bcEnd3
            bra.w   BITBLT.L30
            ds.b    12
bLONG8:
            move.w  (-$260,A6),D3
            movea.l (-$88,A6),A4
            lea     (0,A4,D7.w*4),A2
            addq.w  #4,A3
            subq.w  #1,D3
            and.l   D5,D1
            move.l  D1,D5
            movea.l A4,A1
            move.l  (A1)+,D0
            moveq   #$E,D2
.L1:
            cmp.l   (A1)+,D0
            dbne    D2,.L1
            beq.b   .L5
            not.l   D5
            beq.b   .L3
.L2:
            and.l   D1,D6
            move.l  (A5),D0
            and.l   D5,D0
            or.l    D6,D0
            move.l  D0,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A4,D7.w*4),D6
            dbra    D3,.L2
            bra.w   BITBLT.L32
.L3:
            move.l  (A2)+,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            bne.b   .L4
            movea.l A4,A2
.L4:
            dbra    D3,.L3
            bra.w   BITBLT.L32
            ds.b    6
.L5:
            not.l   D5
            beq.b   .L7
            and.l   D1,D0
.L6:
            move.l  (A5),D2
            and.l   D5,D2
            or.l    D0,D2
            move.l  D2,(A5)
            adda.w  A3,A5
            dbra    D3,.L6
            bra.w   BITBLT.L32
.L7:
            move.l  D0,(A5)
            adda.w  A3,A5
            dbra    D3,.L7
            bra.w   BITBLT.L32
            ds.b    12
bSETUP8:
            move.w  D2,D3
            move.l  D1,D4
            not.l   D1
            movea.l D1,A1
            bne.b   .L1
            addq.w  #1,D3
.L1:
            move.l  D5,D0
            not.l   D0
            movea.l D0,A2
            bne.b   .L2
            addq.w  #1,D3
.L2:
            movea.l (-$88,A6),A4
            lea     (4,A4,D7.w*4),A4
            move.w  D7,D0
            moveq   #1,D7
            lsl.w   D0,D7
            move.w  (-$260,A6),D2
            subq.w  #1,D2
            lea     sub_4082D01A.L1,A0
            subq.w  #1,D3
            beq.b   sub_4082D000.L2
            moveq   #$F,D0
            and.w   D3,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D3
            bra.b   sub_4082D000.L2
sub_4082D000:
            moveq   #1,D7
            suba.w  #$40,A4
.L1:
            move.l  (A4)+,D6
.L2:
            move.l  A1,D1
            beq.b   .L3
            move.l  D6,D0
            and.l   D4,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L3:
            move.w  D3,D0
            jmp     (A0)
sub_4082D01A:
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            dbra    D0,sub_4082D01A
.L1:
            move.l  A2,D0
            beq.b   .L2
            and.l   (A5),D0
            and.l   D5,D6
            or.l    D6,D0
            move.l  D0,(A5)+
.L2:
            adda.w  A3,A5
            add.w   D7,D7
            dbeq    D2,sub_4082D000.L1
            dbne    D2,sub_4082D000
            bra.w   BITBLT.L32
            ds.b    6
bEND9:
            and.l   D5,D1
bMAIN9:
            and.l   D6,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN9
            beq.b   bEND9
            bra.w   BITBLT.L33
            ds.b    4
bEND10:
            move.w  (-$260,A6),D3
            movea.l (-$88,A6),A4
            lea     (0,A4,D7.w*4),A2
            addq.w  #4,A3
            subq.w  #1,D3
            and.l   D5,D1
.L1:
            move.l  (A2)+,D6
            and.l   D1,D6
            eor.l   D6,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            bne.b   .L2
            movea.l A4,A2
.L2:
            dbra    D3,.L1
            bra.w   BITBLT.L32
            ds.b    4
bSETUP10:
            move.w  D2,D3
            move.l  D1,D4
            movea.l (-$88,A6),A2
            lea     (4,A2,D7.w*4),A4
            move.w  D7,D0
            moveq   #1,D7
            lsl.w   D0,D7
            move.w  (-$260,A6),D2
            subq.w  #1,D2
            lea     sub_4082D0EE.L1,A0
            subq.w  #1,D3
            beq.b   sub_4082D0DE.L2
            moveq   #$F,D0
            and.w   D3,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D3
            bra.b   sub_4082D0DE.L2
sub_4082D0DE:
            moveq   #1,D7
            movea.l A2,A4
.L1:
            move.l  (A4)+,D6
.L2:
            move.l  D6,D0
            and.l   D4,D0
            eor.l   D0,(A5)+
            move.w  D3,D0
            jmp     (A0)
sub_4082D0EE:
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            dbra    D0,sub_4082D0EE
.L1:
            and.l   D5,D6
            eor.l   D6,(A5)+
            adda.w  A3,A5
            add.w   D7,D7
            dbeq    D2,sub_4082D0DE.L1
            dbne    D2,sub_4082D0DE
            bra.w   BITBLT.L32
            ds.b    10
bEND11:
            and.l   D5,D1
bMAIN11:
            and.l   D6,D1
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN11
            beq.b   bEND11
            bra.w   BITBLT.L33
            ds.b    4
bXLONG8:
            movea.w (-$8E,A6),A0
            move.w  (-$8A,A6),D2
            move.w  (-$260,A6),D3
            subq.w  #1,D3
            addq.w  #4,A3
            and.l   D5,D1
            move.l  D1,D5
            adda.w  D6,A4
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            not.l   D5
            beq.b   .L2
.L1:
            move.l  (0,A4,D6.w),D7
            and.l   D1,D7
            move.l  (A5),D0
            and.l   D5,D0
            or.l    D7,D0
            move.l  D0,(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L1
            bra.w   BITBLT.L32
.L2:
            move.l  (0,A4,D6.w),(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L2
            bra.w   BITBLT.L32
            dc.w    0
.L3:
            subq.w  #1,D2
.L4:
            move.l  (0,A4,D6.w),(A5)+
            addq.w  #4,D6
            and.w   D7,D6
            dbra    D2,.L4
.L5:
            and.l   D5,D1
bXMAIN8:
            move.l  D1,D0
            and.l   (0,A4,D6.w),D0
            addq.w  #4,D6
            and.w   D7,D6
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXLONG8.L3
            beq.b   bXLONG8.L5
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            swap    D6
            move.w  (-$90,A6),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            beq.w   BITBLT.L32
            move.l  (-$26C,A6),D1
            move.w  (-$26E,A6),D2
            bra.b   bXMAIN8
            ds.b    12
bXEND9:
            and.l   D5,D1
bXMAIN9:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN9
            beq.b   bXEND9
            bra.w   BITBLT.L31
            ds.b    14
bXEND10:
            movea.w (-$8E,A6),A0
            move.w  (-$8A,A6),D2
            move.w  (-$260,A6),D3
            subq.w  #1,D3
            addq.w  #4,A3
            and.l   D5,D1
            adda.w  D6,A4
            clr.w   D6
            swap    D6
            suba.l  D6,A4
.L1:
            move.l  (0,A4,D6.w),D0
            and.l   D1,D0
            eor.l   D0,(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L1
            bra.w   BITBLT.L32
.L2:
            and.l   D5,D1
bXMAIN10:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D1,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN10
            beq.b   bXEND10.L2
            bra.w   BITBLT.L31
            ds.b    8
bXEND11:
            and.l   D5,D1
bXMAIN11:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN11
            beq.b   bXEND11
            bra.w   BITBLT.L31
            ds.b    14
BARITH32SETUP:
            move.w  (-$280,A6),D2
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
            moveq   #0,D4
            move.w  (-$8C,A6),D4
            lsr.l   #3,D4
            move.w  D4,(-$8C,A6)
            tst.b   (-$270,A6)
            bpl.b   .L1
            moveq   #0,D6
.L1:
            lsr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$1BA,A6),(-$25E,A6)
            movea.w (-$24C,A6),A3
            move.w  A3,D7
            bpl.b   .L2
            addq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L2:
            jmp     (A1)
            ds.b    6
BARITH16SETUP:
            move.w  (-$280,A6),D2
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
            asr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$1BA,A6),(-$25E,A6)
            move.w  (-$24C,A6),D7
            asr.w   #1,D7
            movea.w D7,A3
            bpl.b   .L1
            addq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L1:
            tst.l   D1
            bmi.b   .L2
            addq.w  #2,A5
            addq.l  #2,D6
            move.l  D6,(-$27C,A6)
.L2:
            moveq   #0,D4
            move.w  (-$8C,A6),D4
            lsr.l   #3,D4
            bset    #1,D4
            move.w  D4,(-$8C,A6)
            jmp     (A1)
            ds.b    12
bAddOver:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L5
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L5:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bAddOver,A1
            bra.w   BITBLT.L34
            ds.b    10
.L8:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            movea.l #$808080,A1
.L7:
            move.l  A1,D3
            move.l  (A0),D7
            and.l   D7,D3
            adda.w  A3,A0
            and.l   D0,D7
            move.l  (A2),D5
            move.l  A1,D1
            and.l   D5,D1
            and.l   D0,D5
            add.l   D5,D7
            eor.l   D3,D1
            eor.l   D1,D7
            move.l  D7,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L6
            movea.l A4,A0
.L6:
            dbra    D2,.L7
            lea     .L8,A1
            bra.w   BITBLT.L39
            ds.b    14
.L11:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            movea.w #$4210,A1
.L10:
            move.w  A1,D3
            move.w  (A0),D7
            and.w   D7,D3
            adda.w  A3,A0
            and.w   D0,D7
            move.w  (A2),D5
            move.w  A1,D1
            and.w   D5,D1
            and.w   D0,D5
            add.w   D5,D7
            eor.w   D3,D1
            eor.w   D1,D7
            move.w  D7,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L9
            movea.l A4,A0
.L9:
            dbra    D2,.L10
            lea     .L11,A1
            bra.w   BITBLT.L39
            dc.w    0
bAddPin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L10
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L4
            cmp.w   (-$F6,A6),D3
            bls.b   .L5
.L4:
            move.w  (-$F6,A6),D3
.L5:
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L6
            cmp.w   (-$F8,A6),D3
            bls.b   .L7
.L6:
            move.w  (-$F8,A6),D3
.L7:
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L8
            cmp.w   (-$FA,A6),D3
            bls.b   .L9
.L8:
            move.w  (-$FA,A6),D3
.L9:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L10:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L11
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L11:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            lea     bAddPin,A1
            bra.w   BITBLT.L34
            ds.b    4
            lea     .L12,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L12:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D1
.L19:
            move.l  (A0),D7
            and.l   D1,D7
            move.l  D7,D0
            adda.w  A3,A0
            move.l  (A2),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L13
            cmp.w   D3,D0
            bls.b   .L14
.L13:
            move.w  D3,D0
.L14:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L15
            cmp.b   D3,D0
            bls.b   .L16
.L15:
            move.b  D3,D0
.L16:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L17
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L17:
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            bra.w   BITBLT.L39
            ds.b    8
            lea     .L20,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L20:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L25:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L21
            move.l  D3,D0
.L21:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L22
            move.w  D3,D0
.L22:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L23
            move.b  D3,D0
.L23:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L24
            movea.l A4,A0
.L24:
            dbra    D2,.L25
            bra.w   BITBLT.L39
            dc.w    0
bSubOver:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L5
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L5:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bSubOver,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L7:
            move.l  D1,D3
            move.l  (A0),D7
            and.l   D7,D3
            eor.l   D1,D3
            adda.w  A3,A0
            and.l   D0,D7
            move.l  (A2),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            bne.b   .L6
            movea.l A4,A0
.L6:
            dbra    D2,.L7
            bra.w   BITBLT.L39
            ds.b    12
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L9:
            move.w  D1,D3
            move.w  (A0),D7
            adda.w  A3,A0
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.l  (A2),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            bne.b   .L8
            movea.l A4,A0
.L8:
            dbra    D2,.L9
            bra.w   BITBLT.L39
bSubPin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L10
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L4
            cmp.w   (-$F6,A6),D3
            bcc.b   .L5
.L4:
            move.w  (-$F6,A6),D3
.L5:
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L6
            cmp.w   (-$F8,A6),D3
            bcc.b   .L7
.L6:
            move.w  (-$F8,A6),D3
.L7:
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L8
            cmp.w   (-$FA,A6),D3
            bcc.b   .L9
.L8:
            move.w  (-$FA,A6),D3
.L9:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L10:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L11
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L11:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            lea     bSubPin,A1
            bra.w   BITBLT.L34
            ds.b    4
            lea     .L12,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L12:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D1
.L19:
            move.l  (A0),D5
            and.l   D1,D5
            adda.w  A3,A0
            move.l  (A2),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L13
            cmp.w   D3,D0
            bcc.b   .L14
.L13:
            move.w  D3,D0
.L14:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L15
            cmp.b   D3,D0
            bcc.b   .L16
.L15:
            move.b  D3,D0
.L16:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L17
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L17:
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            bra.w   BITBLT.L39
            ds.b    8
            lea     .L20,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            addi.l  #$808080,D3
.L20:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$808080,D1
.L25:
            moveq   #0,D5
            move.w  (A0),D5
            adda.w  A3,A0
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A2),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L21
            move.l  D3,D0
.L21:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L22
            move.w  D3,D0
.L22:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L23
            move.b  D3,D0
.L23:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L24
            movea.l A4,A0
.L24:
            dbra    D2,.L25
            bra.w   BITBLT.L39
            ds.b    4
bMax:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L7
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L4
            move.w  (A3),D3
.L4:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L5
            move.w  (A3),D3
.L5:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L6
            move.w  (A3),D3
.L6:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L7:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bMax,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L13:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bhi.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bhi.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bhi.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L12
            movea.l A4,A0
.L12:
            dbra    D2,.L13
            bra.w   BITBLT.L39
            ds.b    4
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L18:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L14
            move.l  D5,D0
.L14:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L15
            move.w  D5,D0
.L15:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L16
            move.b  D5,D0
.L16:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L17
            movea.l A4,A0
.L17:
            dbra    D2,.L18
            bra.w   BITBLT.L39
            ds.b    14
bMin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L7
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L4
            move.w  (A3),D3
.L4:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L5
            move.w  (A3),D3
.L5:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L6
            move.w  (A3),D3
.L6:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L7:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bMin,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L13:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bls.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bls.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bls.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L12
            movea.l A4,A0
.L12:
            dbra    D2,.L13
            bra.w   BITBLT.L39
            ds.b    4
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L18:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L14
            move.l  D5,D0
.L14:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L15
            move.w  D5,D0
.L15:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L16
            move.b  D5,D0
.L16:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L17
            movea.l A4,A0
.L17:
            dbra    D2,.L18
            bra.w   BITBLT.L39
            ds.b    14
bAvg:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L5
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  D0,-(SP)
            moveq   #2,D0
            move.w  (-$10E,A6),D4
            add.w   D4,D4
            clr.w   -(SP)
.L4:
            move.w  (A2)+,D3
            mulu.w  (-$FA.w,A6,D0.w*2),D3
            move.w  (A3)+,D5
            mulu.w  (-$100.w,A6,D0.w*2),D5
            add.l   D5,D3
            swap    D3
            move.w  (-$110,A6),D5
            lsr.w   D5,D3
            lsl.w   D4,D3
            or.w    D3,(SP)
            sub.w   (-$10E,A6),D4
            dbra    D0,.L4
            move.w  (SP)+,D3
            move.w  (SP)+,D0
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L5:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L6
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L6:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            movea.l ($1B40).w,A1
            bra.w   BITBLT.L34
            ds.b    6
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            move.l  #$10101,D1
.L8:
            move.l  D1,D3
            move.l  (A0),D7
            and.l   D7,D3
            adda.w  A3,A0
            lsr.l   #1,D7
            and.l   D0,D7
            move.l  (A2),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D7
            add.l   D3,D7
            move.l  D7,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L7
            movea.l A4,A0
.L7:
            dbra    D2,.L8
            bra.w   BITBLT.L39
            dc.w    0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            move.w  #$421,D1
.L10:
            move.l  D1,D3
            move.w  (A0),D7
            and.w   D7,D3
            adda.w  A3,A0
            lsr.w   #1,D7
            and.w   D0,D7
            move.w  (A2),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D7
            add.w   D3,D7
            move.w  D7,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L9
            movea.l A4,A0
.L9:
            dbra    D2,.L10
            bra.w   BITBLT.L39
            ds.b    6
.L15:
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A1
.L14:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            cmp.l   D3,D7
            bne.b   .L11
            cmp.l   A1,D5
            beq.b   .L12
.L11:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A1
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A1
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A1,D4
            swap    D5
            movea.l D5,A1
            swap    D7
            move.l  D7,D3
.L12:
            move.l  D4,(A2)
            adda.w  A3,A2
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            bne.b   .L13
            movea.l A4,A0
.L13:
            dbra    D2,.L14
            lea     .L15,A1
            bra.w   BITBLT.L39
            dc.w    0
.L20:
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A1
.L19:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            moveq   #0,D5
            move.w  (A2),D5
            cmp.w   D3,D7
            bne.b   .L16
            cmp.w   A1,D5
            beq.b   .L17
.L16:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A1
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A1
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A1,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A1
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L17:
            move.w  D4,(A2)
            adda.w  A3,A2
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            lea     .L20,A1
            bra.w   BITBLT.L39
            ds.b    14
bHilite:
            subq.w  #1,D2
            bmi.b   .L5
            bsr.b   hiliteMask
            subq.w  #1,D2
            bmi.b   .L4
.L1:
            cmp.l   (A5),D4
            bne.b   .L6
.L2:
            move.l  A0,(A5)+
.L3:
            dbra    D2,.L1
.L4:
            moveq   #-1,D1
.L5:
            and.l   (-$274,A6),D1
            bsr.b   hiliteMask
            bra.w   BITBLT.L30
.L6:
            cmpa.l  (A5),A0
            beq.b   .L10
            move.l  A2,D6
.L7:
            bfextu  (A5){D6:D7},D3
            cmp.l   D3,D0
            bne.b   .L8
            bfins   D5,(A5){D6:D7}
            bra.b   .L9
.L8:
            cmp.l   D5,D3
            bne.b   .L9
            bfins   D0,(A5){D6:D7}
.L9:
            sub.w   D7,D6
            bpl.b   .L7
            addq.w  #4,A5
            bra.b   .L3
.L10:
            bfextu  D4{0:D7},D5
            exg     D4,A0
            bfextu  D4{0:D7},D0
            bra.b   .L2
hiliteMask:
            move.l  D4,D3
            and.l   D1,D3
            move.l  (A5),D6
            and.l   D1,D6
            cmp.l   D3,D6
            bne.b   .L1
            move.l  A0,D3
            and.l   D1,D3
            not.l   D1
            and.l   (A5),D1
            or.l    D3,D1
            move.l  D1,(A5)+
            rts
.L1:
            move.l  A2,D6
.L2:
            bfextu  D1{D6:D7},D3
            beq.b   .L4
            bfextu  (A5){D6:D7},D3
            cmp.l   D3,D0
            bne.b   .L3
            bfins   D5,(A5){D6:D7}
            bra.b   .L4
.L3:
            cmp.l   D5,D3
            bne.b   .L4
            bfins   D0,(A5){D6:D7}
.L4:
            sub.w   D7,D6
            bpl.b   .L2
            addq.w  #4,A5
            rts
            moveq   #-1,D0
            lsr.l   #8,D0
            move.w  D2,D3
.L5:
            move.w  D3,D2
.L6:
            move.l  D0,D1
            and.l   (A5),D1
            cmp.l   D1,D4
            bne.b   .L8
.L7:
            move.l  A0,(A5)+
            dbra    D2,.L6
            bra.b   .L10
.L8:
            cmpa.l  D1,A0
            bne.b   .L9
            exg     D4,A0
            bra.b   .L7
.L9:
            addq.w  #4,A5
            dbra    D2,.L6
.L10:
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L5
            bra.w   BITBLT.L32
            ds.b    14
bSloHilite:
            bfextu  D4{0:D7},D4
            cmpi.w  #$20,D7
            beq.b   .L3
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L5
            bfextu  (A4){D6:D7},D3
            cmp.l   D3,D4
            beq.b   .L5
            bfextu  (A5){D0:D7},D3
            cmp.l   D3,D4
            bne.b   .L4
            bfins   D5,(A5){D0:D7}
            bra.b   .L5
.L4:
            cmp.l   D5,D3
            bne.b   .L5
            bfins   D4,(A5){D0:D7}
.L5:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L6
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L6:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            bra.w   BITBLT.L34
            ds.b    6
bTransparent:
            cmpi.w  #$20,D7
            beq.b   .L3
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D6:0},D3
            cmp.l   D3,D4
            beq.b   .L5
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            cmpa.l  D3,A3
            beq.b   .L4
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            bra.b   .L6
.L5:
            add.l   A2,D6
            add.l   A2,D0
            sub.w   (-$286,A6),D2
            bge.b   .L3
.L6:
            addq.w  #1,D2
            beq.b   .L7
            sub.l   (SP),D6
            sub.l   (SP),D0
            bra.b   .L6
.L7:
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            bra.w   BITBLT.L34
            ds.b    14
            move.l  (-$A4,A6),D3
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D0
.L11:
            move.l  (A0),D7
            adda.w  A3,A0
            and.l   D0,D7
            cmp.l   D3,D7
            beq.b   .L9
            move.l  D7,(A2)
.L9:
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L10
            movea.l A4,A0
.L10:
            dbra    D2,.L11
            bra.w   BITBLT.L39
            ds.b    4
            move.l  (-$A4,A6),D3
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #-1,D0
            lsr.w   #1,D0
.L14:
            move.w  (A0),D7
            adda.w  A3,A0
            and.w   D0,D7
            cmp.w   D3,D7
            beq.b   .L12
            move.w  D7,(A2)
.L12:
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L13
            movea.l A4,A0
.L13:
            dbra    D2,.L14
            bra.w   BITBLT.L39
            dc.b    '(c) Apple Computer Inc., 1983-1989'
            dc.w    0
