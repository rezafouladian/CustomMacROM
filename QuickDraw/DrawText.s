DrText:
            movea.l D0,A0
            move.l  SP,D0
            asr.w   #2,D0
            scs     D0
            bcc.b   .L1
            subq.w  #2,SP
.L1:
            link.w  A6,#-$1B8
            andi.w  #2,D0
            move.w  D0,(-$1A8,A6)
            move.l  A0,D0
            movem.l D0-D7/A1-A4,-(SP)
            move.l  SP,(-4,A6)
            move.l  A5,(-$8C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            move.w  (-$1A8,A6),D0
            move.l  ($C,A6,D0.w),(-$D0,A6)
            move.l  (8,A6,D0.w),(-$D4,A6)
            clr.w   (-$D6,A6)
            move.l  TheGDevice,LastTxGDevice
            lea     (2,A3),A1
            lea     (-$18E,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$A4,A6)
            move.b  D2,(-$1AB,A6)
.L2:
            move.w  (-$1A8,A6),D0
            clr.w   -(SP)
            move.w  ($14,A6,D0.w),D1
            move.w  D1,-(SP)
            ble.w   sub_40828A0E.L46
            move.w  D1,(-$1AA,A6)
            move.l  ($10,A6,D0.w),-(SP)
            pea     ($C,A6,D0.w)
            pea     (8,A6,D0.w)
            pea     (-$CC,A6)
            movea.l ($11B4).w,A0
            jsr     (A0)
            addq.w  #2,SP
            clr.b   (-$1B7,A6)
            move.l  (-$AC,A4),D1
            movea.l (-$B0,A4),A4
            movea.l (2,A4),A2
            movea.l (A2),A2
            move.w  (A2),D0
            btst    #9,D0
            sne     (-$1B5,A6)
            lsr.w   #2,D0
            andi.w  #7,D0
            sne     D2
            move.w  D0,(-$1B0,A6)
            moveq   #1,D3
            lsl.w   D0,D3
            move.w  D3,(-$19A,A6)
            move.w  ($E,A2),(-$194,A6)
            btst    #0,(1,A2)
            sne     (-$192,A6)
            move.w  (8,A2),(-$1A0,A6)
            clr.l   (-$94,A6)
            move.w  ($48,A3),D0
            andi.w  #$FFF7,D0
            tst.b   (-$1B5,A6)
            beq.b   .L3
            cmpi.w  #1,D0
            bne.b   .L3
            moveq   #$40,D0
.L3:
            move.w  D0,(-$1AE,A6)
            btst    #6,D0
            sne     D3
            beq.b   .L4
            lea     (-$132,A6),A0
            move.l  A0,(-$94,A6)
.L4:
            btst    #5,D0
            beq.b   .L5
            cmpi.w  #1,(-$16E,A6)
            bne.b   .L5
            lea     arithMode,A0
            andi.w  #7,D0
            move.b  (0,A0,D0.w),D0
            move.w  D0,(-$1AE,A6)
.L5:
            and.b   D2,D3
            beq.b   .L6
            movea.l WidthPtr,A0
            move.l  ([$400.w,A0]),D0
            sne     D3
            beq.b   .L6
            movea.l D0,A0
            moveq   #0,D0
            move.w  ($18,A0),D0
            add.l   D0,D0
            move.l  D0,(-$60,A6)
            lea     ($1A,A0),A0
            move.l  A0,(-$5C,A6)
            lea     (-$140,A6),A0
            move.l  A0,(-$94,A6)
.L6:
            move.b  D3,(-$190,A6)
            or.b    (-$1B5,A6),D3
            move.b  D3,(-$1B3,A6)
            move.l  ($30,A3),D2
            move.l  D2,(-$74,A6)
            move.w  D2,(-$A,A6)
            swap    D2
            move.w  #$8000,D2
            cmpi.w  #1,(-$1AE,A6)
            seq     (-$1B4,A6)
            bclr    #6,(-$1AD,A6)
            beq.b   .L7
            tst.w   (-$1AE,A6)
            seq     (-$1B4,A6)
.L7:
            clr.l   (-$90,A6)
            tst.w   (6,A3)
            bpl.b   .L10
            move.w  ($C,A3),D0
            beq.b   .L8
            bsr.w   CalcCharExtra
            move.l  D0,(-$90,A6)
.L8:
            move.w  ($E,A3),D2
            move.w  D2,(-$1A2,A6)
            move.l  ($50,A3),D0
            cmp.l   ($54,A3),D0
            beq.b   .L9
            addq.l  #1,D0
            move.w  (-$16E,A6),D3
            lsr.l   D3,D0
.L9:
            sne     D0
            tst.b   (-$1B5,A6)
            beq.b   .L12
            tst.l   ($54,A3)
            bra.b   .L11
.L10:
            btst    #5,($53,A3)
            sne     D0
            tst.b   (-$1B5,A6)
            beq.b   .L12
            btst    #0,($57,A3)
.L11:
            seq     D0
.L12:
            and.b   D0,(-$1B4,A6)
            add.l   D1,D2
            swap    D2
            clr.w   (-$19E,A6)
            tst.b   ($11,A4)
            beq.b   .L14
            moveq   #0,D0
            move.b  (7,A4),D0
            move.w  ($12,A2),D3
            subq.w  #1,D3
            mulu.w  D3,D0
            asr.w   #4,D0
            add.b   (6,A4),D0
            sub.b   ($C,A4),D0
            ext.w   D0
            moveq   #4,D3
            cmp.b   ($B,A4),D3
            ble.b   .L13
            move.b  ($B,A4),D3
            beq.b   .L13
            addq.w  #1,D3
.L13:
            add.w   D3,D0
            move.w  D0,(-$19E,A6)
            add.w   D0,D2
            moveq   #0,D0
            move.b  (7,A4),D0
            mulu.w  ($14,A2),D0
            asr.w   #4,D0
            sub.w   D0,(-$1A0,A6)
.L14:
            move.w  (-$1A0,A6),D0
            add.w   D0,(-$A,A6)
            move.w  D2,(-6,A6)
            move.w  (-$74,A6),D2
            sub.w   ($12,A2),D2
            move.w  D2,(-$C,A6)
            add.w   ($E,A2),D2
            move.w  D2,(-8,A6)
            move.l  (-$C,A6),(-$14,A6)
            move.l  (-8,A6),(-$10,A6)
            move.w  (-$1A8,A6),D3
            move.l  ($C,A6,D3.w),D0
            cmp.l   (8,A6,D3.w),D0
            sne     (-$191,A6)
            beq.b   .L15
            swap    D0
            clr.w   D0
            mulu.l  D0,D0:D1
            moveq   #0,D2
            move.w  ($A,A6,D3.w),D2
            swap    D2
            divu.l  D2,D0:D1
            move.l  (-$74,A6),D0
            move.l  D0,(-$70,A6)
            add.w   ($E,A6,D3.w),D0
            move.w  D0,(-$6A,A6)
            swap    D0
            add.w   ($C,A6,D3.w),D0
            move.w  D0,(-$6C,A6)
            move.l  (-$74,A6),D0
            move.l  D0,(-$68,A6)
            add.w   ($A,A6,D3.w),D0
            move.w  D0,(-$62,A6)
            swap    D0
            add.w   (8,A6,D3.w),D0
            move.w  D0,(-$64,A6)
            pea     (-$14,A6)
            pea     (-$68,A6)
            pea     (-$70,A6)
            jsr     ([$11E8.w])
.L15:
            andi.b  #$F,CCR
            tst.w   (6,A3)
            bpl.b   .L16
            add.w   D1,($E,A3)
.L16:
            swap    D1
            move.w  ($32,A3),D0
            addx.w  D1,D0
            move.w  D0,($32,A3)
            tst.w   ($42,A3)
            blt.w   sub_40828A0E.L46
            move.w  (-$E,A6),-(SP)
            move.w  #$7D00,(-$E,A6)
            pea     (-$14,A6)
            pea     (-$188,A6)
            movea.l ($1C,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($18,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #4,-(SP)
            pea     (-$2C,A6)
            jsr     ([$1A84.w])
            beq.w   sub_40828A0E.L46
            move.w  (SP)+,(-$E,A6)
            lea     ($1A,A2),A0
            move.l  A0,(-$50,A6)
            moveq   #0,D1
            move.w  ($18,A2),D1
            move.w  (-$1B0,A6),D0
            lsl.l   D0,D1
            add.l   D1,D1
            move.l  D1,(-$54,A6)
            move.w  ($E,A2),(-$40,A6)
            tst.b   (7,A4)
            bne.w   .L21
            tst.b   (6,A4)
            bne.w   .L21
            tst.b   (-$1B4,A6)
            beq.w   .L21
            tst.w   ($A,A4)
            bne.w   .L21
            tst.b   (-$191,A6)
            bne.w   .L21
            movea.l ([$1C.w,A3]),A0
            moveq   #$A,D0
            cmp.w   (A0),D0
            bne.w   .L21
            moveq   #1,D0
            move.w  (-$1B0,A6),D1
            lsl.w   D1,D0
            cmp.w   (-$16E,A6),D0
            bne.w   .L21
            cmpi.w  #$10,(-$170,A6)
            bne.b   .L17
            seq     (-$1B3,A6)
            clr.w   (-$1AE,A6)
            bra.w   .L21
.L17:
            movea.l ($18,A3),A1
            movea.l (A1),A0
            cmpi.w  #$A,(A0)
            beq.b   .L18
            move.l  A1,-(SP)
            pea     (-$2C,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   sub_40828A0E.L46
            bgt.w   .L21
.L18:
            st      (-$18F,A6)
            clr.b   (-$190,A6)
            clr.l   (-$98,A6)
            move.w  (-$2C,A6),D0
            move.w  (-$28,A6),D1
            sub.w   (-$C,A6),D0
            bne.b   .L19
            cmp.w   (-8,A6),D1
            beq.b   .L20
.L19:
            clr.b   (-$192,A6)
            move.b  D0,(-$194,A6)
            sub.w   (-$2C,A6),D1
            move.b  D1,(-$193,A6)
.L20:
            move.w  (-$C,A6),D0
            sub.w   (-$188,A6),D0
            move.w  (-$18A,A6),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            add.l   (-$18E,A6),D0
            move.l  D0,(-$4C,A6)
            move.w  D1,(-$34,A6)
            move.w  (-$186,A6),(-$3E,A6)
            tst.b   (-$1AB,A6)
            beq.w   .L38
            pea     (-$2C,A6)
            move.l  (-$A4,A6),-(SP)
            jsr     ([$F54.w])
            move.l  (-$50,A6),D0
            jsr     ([$644.w])
            move.l  D0,(-$50,A6)
            move.l  A2,D0
            jsr     ([$644.w])
            movea.l D0,A2
            move.w  (-$1A8,A6),D1
            move.l  ($10,A6,D1.w),D0
            jsr     ([$644.w])
            move.l  D0,($10,A6,D1.w)
            moveq   #1,D0
            move.l  A2,-(SP)
            jsr     ([$574.w])
            movea.l (SP)+,A2
            move.b  D0,(-$1AC,A6)
            move.b  #1,(-$1B7,A6)
            bra.w   .L38
.L21:
            sf      (-$18F,A6)
            sf      (-$1AB,A6)
            move.w  (-$A,A6),D0
            sub.w   (-$186,A6),D0
            andi.w  #$FFE0,D0
            add.w   (-$186,A6),D0
            move.w  D0,(-$3E,A6)
            moveq   #0,D1
            move.w  (-6,A6),D1
            sub.w   D0,D1
            move.w  D1,D2
            move.w  (-$1B0,A6),D4
            lsl.l   D4,D1
            lsr.l   #5,D1
            addq.w  #2,D1
            move.w  (-$40,A6),D3
            mulu.w  D1,D3
            cmpi.l  #$1C00,D3
            bgt.b   .L24
            move.w  D3,(-$32,A6)
            add.w   D1,D3
            lsl.w   #2,D1
            move.w  D1,(-$34,A6)
            move.w  (-$E,A6),D5
            sub.w   (-$12,A6),D5
            lsr.w   #5,D5
            addq.w  #2,D5
            move.w  D5,D0
            add.w   D0,D3
            add.w   D0,D3
            lsl.w   D4,D0
            add.w   D0,D3
            mulu.w  (-$16E,A6),D5
            add.w   D5,D3
            add.w   D5,D3
            tst.b   (-$190,A6)
            beq.b   .L22
            lsr.w   #5,D2
            addq.w  #2,D2
            add.w   D2,D1
            move.w  (-$40,A6),D0
            mulu.w  D2,D0
            move.w  D0,(-$AE,A6)
            lsl.w   #2,D2
            move.w  D2,(-$B0,A6)
            add.w   D0,D3
            add.w   D2,D3
            move.w  (-$E,A6),D0
            sub.w   (-$12,A6),D0
            lsr.w   #5,D0
            add.w   D0,D3
.L22:
            tst.b   ($B,A4)
            beq.b   .L23
            add.w   (-$32,A6),D3
            add.w   D1,D3
.L23:
            lsl.l   #2,D3
            addi.l  #$800,D3
            movea.l ($594).w,A0
            jsr     (A0)
            cmp.l   D0,D3
            ble.b   .L31
.L24:
            move.w  (-$1A8,A6),D6
            move.w  ($14,A6,D6.w),D0
            move.w  D0,D7
            lsr.w   #1,D7
            bne.b   .L25
            subq.w  #1,(-$D6,A6)
            bra.w   sub_40828A0E.L46
.L25:
            tst.w   (-$D6,A6)
            bne.b   .L26
            move.b  HiliteMode,(-$1B6,A6)
            move.w  D0,(-$D6,A6)
.L26:
            move.l  (-$74,A6),($30,A3)
            tst.w   (6,A3)
            bpl.b   .L27
            move.w  (-$1A2,A6),($E,A3)
.L27:
            move.w  D7,($14,A6,D6.w)
.L28:
            movea.l (A5),A4
            move.l  (-$D0,A6),($C,A6,D6.w)
            move.l  (-$D4,A6),(8,A6,D6.w)
            move.b  (-$1B6,A6),HiliteMode
            jmp     .L2
.L29:
            moveq   #0,D7
            move.w  (-$1A8,A6),D6
            move.w  ($14,A6,D6.w),D7
            move.w  (-$D6,A6),D0
            cmp.w   D0,D7
            ble.b   .L30
            move.w  D0,($14,A6,D6.w)
.L30:
            add.l   D7,($10,A6,D6.w)
            bra.b   .L28
.L31:
            moveq   #0,D0
            tst.w   (-$1B0,A6)
            beq.b   .L34
            cmpi.w  #2,(-$1AE,A6)
            beq.b   .L34
            tst.b   (-$1B5,A6)
            bne.b   .L32
            cmpi.w  #$32,(-$1AE,A6)
            beq.b   .L34
            btst    #5,(-$1AD,A6)
            beq.b   .L34
.L32:
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1668.w])
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$16CC.w])
            moveq   #0,D0
            moveq   #$20,D1
            move.w  (-$19A,A6),D2
.L33:
            asl.l   D2,D0
            or.l    (SP),D0
            sub.w   D2,D1
            bgt.b   .L33
            lea     ($A,SP),SP
.L34:
            move.l  D0,(-$98,A6)
            move.w  (-$32,A6),D3
            subq.w  #1,D3
            move.l  D0,-(SP)
            move.l  SP,(-$30,A6)
.L35:
            move.l  D0,-(SP)
            dbra    D3,.L35
            move.l  SP,(-$4C,A6)
            move.l  D0,-(SP)
            tst.b   (-$190,A6)
            beq.b   .L37
            move.w  (-$AE,A6),D3
            subq.w  #1,D3
            clr.l   -(SP)
.L36:
            clr.l   -(SP)
            dbra    D3,.L36
            move.l  SP,(-$58,A6)
.L37:
            clr.l   -(SP)
.L38:
            lea     ($1A,A2),A0
            moveq   #0,D0
            move.w  ($E,A2),D0
            mulu.l  (-$54,A6),D0
            adda.l  D0,A0
            move.l  A0,(-$88,A6)
            move.w  ($A,A2),D0
            swap    D0
            bpl.b   .L39
            moveq   #0,D0
.L39:
            move.w  ($10,A2),D0
            lea     ($10,A2,D0.l*2),A1
            move.l  A1,(-$84,A6)
            move.w  (4,A2),D0
            move.w  (2,A2),D1
            move.w  D1,(-$198,A6)
            sub.w   D1,D0
            move.w  D0,(-$196,A6)
            addq.w  #3,D0
            btst    #1,(1,A2)
            beq.b   .L40
            add.w   D0,D0
.L40:
            lea     (0,A1,D0.w*2),A0
            move.l  A0,(-$80,A6)
            movea.l WidthTabHandle,A0
            movea.l (A0),A0
            move.l  ($80,A0),(-$78,A6)
            move.w  (-$3E,A6),D1
            move.w  (-$72,A6),D0
            add.w   (-$1A0,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$7C,A6)
            tst.w   (6,A3)
            bpl.b   .L41
            move.w  (-$1A2,A6),(-$7A,A6)
            bra.b   .L42
.L41:
            move.w  #$8000,(-$7A,A6)
.L42:
            sub.w   D1,(-$2A,A6)
            sub.w   D1,(-$26,A6)
            move.w  (-$1A8,A6),D0
            movea.l ($10,A6,D0.w),A1
            bra.b   .L46
.L43:
            move.w  (-$196,A6),D0
            addq.w  #1,D0
            movea.l (-$84,A6),A0
            move.w  (0,A0,D0.w*2),D3
            cmpi.w  #$FFFF,D3
            bne.w   .L47
            bra.b   .L46
.L44:
            move.l  (-$78,A6),D1
            add.l   D1,(-$7C,A6)
.L45:
            subq.w  #1,(-$D6,A6)
            subq.w  #1,(-$1AA,A6)
            ble.w   sub_40828A0E.L19
.L46:
            clr.w   D0
            move.b  (A1)+,D0
            cmpi.b  #$20,D0
            beq.b   .L44
            movea.l WidthTabHandle,A0
            movea.l (A0),A0
            move.w  D0,D4
            move.l  (0,A0,D4.w*4),D4
            add.l   (-$90,A6),D4
            ble.b   .L45
            sub.w   (-$198,A6),D0
            cmp.w   (-$196,A6),D0
            bhi.b   .L43
            movea.l (-$84,A6),A0
            move.w  (0,A0,D0.w*2),D3
            cmpi.w  #$FFFF,D3
            beq.b   .L43
.L47:
            lsr.w   #8,D3
            add.w   (-$7C,A6),D3
            add.l   D4,(-$7C,A6)
            movea.l (-$88,A6),A0
            moveq   #0,D1
            move.w  (0,A0,D0.w*2),D1
            move.w  (2,A0,D0.w*2),D2
            sub.w   D1,D2
            ble.b   .L45
            move.w  D2,(-$1A6,A6)
            add.w   D3,D2
            tst.b   (-$192,A6)
            beq.b   .L48
            movea.l (-$80,A6),A0
            move.w  (0,A0,D0.w*2),(-$194,A6)
.L48:
            tst.b   (-$18F,A6)
            beq.b   .L52
            cmp.w   (-$2A,A6),D3
            bge.b   .L49
            cmp.w   (-$2A,A6),D2
            ble.w   .L45
            move.w  (-$2A,A6),D0
            sub.w   D3,D0
            add.w   D0,D1
            add.w   D0,D3
            cmp.w   (-$26,A6),D2
            ble.b   .L51
            bra.b   .L50
.L49:
            cmp.w   (-$26,A6),D2
            ble.b   .L52
            cmp.w   (-$26,A6),D3
            bge.w   sub_40828A0E.L19
.L50:
            move.w  (-$26,A6),D2
.L51:
            move.w  D2,D0
            sub.w   D3,D0
            move.w  D0,(-$1A6,A6)
.L52:
            movem.w D1-D3,(-$B6,A6)
            move.b  (-$1B3,A6),(-$1B1,A6)
            st      (-$1B2,A6)
            move.w  (-$1B0,A6),D0
            lsl.w   D0,D1
            lsl.w   D0,D2
            lsl.w   D0,D3
            movea.w (-$34,A6),A3
            movem.l (-$54,A6),A2/A4-A5
.L53:
            move.w  #$FF,D7
            add.b   (-$193,A6),D7
            bmi.w   .L45
            moveq   #0,D0
            move.b  (-$194,A6),D0
            move.l  A2,D4
            dc.w    $4C00,$4004,$D9C4,$380B,$C8C0,$DBC4,$701F,$2A01
            dc.w    $3C03,$EA46,$3806,$E54E,$DAC6,$3C02,$EA46,$9C44
            dc.w    $6700,$015E,$4443,$C640,$6602,$7620,$3806,$E54C
            dc.w    $94C4,$96C4,$5346,$D243,$7820,$9284,$4A2E,$FE4F
            dc.w    $663E,$C440,$7801,$E29C,$E4A4,$E384,$3406,$3046
            dc.w    $2C05,$DC43,$7020,$9C80,$E9D4,$0963,$6004,$E9D4
            dc.w    $0980,$819D,$584C,$51CA,$FFF6,$E9D4,$0840,$C084
            dc.w    $8195,$D9CA,$DBCB,$3408,$51CF,$FFDE,$6000,$01B8
            dc.w    $3802,$C840,$3D46,$FE5C,$3406,$2C2E,$FF68,$E9C6
            dc.w    $0023,$2D40,$FF64,$E9C6,$0024,$2D40,$FF60,$302E
            dc.w    $FE66,$E9C6,$0020,$3D40,$FE64,$7C20,$9C43,$2045
            dc.w    $D0C3,$90FC,$0020
.L54:
            bfextu  (A5){D6:D3},D0
            cmp.l   (-$9C,A6),D0
            bne.b   sub_40828A0E
            bfextu  (A4){D5:D3},D0
            bfins   D0,(A5){D6:D3}
.L55:
            exg     D5,A0
.L56:
            addq.w  #4,A5
            bra.b   .L58
.L57:
            move.l  (-$98,A6),D0
            cmp.l   (A5),D0
            bne.b   sub_40828A0E.L3
            bfextu  (A4){D5:0},D0
            move.l  D0,(A5)+
.L58:
            addq.w  #4,A4
            dbra    D2,.L57
            exg     D5,A0
            tst.w   D4
            beq.b   .L59
            bfextu  (A5){0:D4},D0
            cmp.l   (-$A0,A6),D0
            bne.b   sub_40828A0E.L6
            bfextu  (A4){D1:D4},D0
            bfins   D0,(A5){0:D4}
.L59:
            adda.l  A2,A4
            adda.l  A3,A5
            move.w  (-$1A4,A6),D2
            dbra    D7,.L54
            bra.w   sub_40828A0E.L17
sub_40828A0E:
            movem.l D1/D3-D6,-(SP)
            movem.w (-$19C,A6),D0-D1
.L1:
            bfextu  (A4){D5:D1},D4
            cmp.w   D4,D0
            beq.b   .L2
            bfins   D4,(A5){D6:D1}
.L2:
            add.l   D1,D5
            add.w   D1,D6
            sub.w   D1,D3
            bgt.b   .L1
            movem.l (SP)+,D1/D3-D6
            bra.b   DrText.L55
.L3:
            moveq   #$20,D0
            movem.l D1/D3-D6,-(SP)
            moveq   #0,D6
            movem.w (-$19C,A6),D1/D3
.L4:
            bfextu  (A4){D5:D3},D4
            cmp.w   D4,D1
            beq.b   .L5
            bfins   D4,(A5){D6:D3}
.L5:
            add.l   D3,D5
            add.w   D3,D6
            sub.w   D3,D0
            bgt.b   .L4
            movem.l (SP)+,D1/D3-D6
            bra.w   DrText.L56
.L6:
            movem.l D1/D3-D6,-(SP)
            moveq   #0,D6
            movem.w (-$19C,A6),D3/D5
.L7:
            bfextu  (A4){D1:D5},D0
            cmp.w   D0,D3
            beq.b   .L8
            bfins   D0,(A5){D6:D5}
.L8:
            add.l   D5,D1
            add.w   D5,D6
            sub.w   D5,D4
            bgt.b   .L7
            movem.l (SP)+,D1/D3-D6
            bra.w   DrText.L59
            move.w  (-$1A6,A6),D3
            tst.b   (-$1B2,A6)
            beq.b   .L9
            move.w  (-$1B0,A6),D4
            lsl.w   D4,D3
.L9:
            tst.b   (-$1B1,A6)
            bne.b   .L11
            move.w  D2,D1
            neg.w   D1
            and.w   D0,D1
            add.w   D1,D3
            and.w   D0,D2
            moveq   #1,D4
            ror.l   #1,D4
            asr.l   D2,D4
            asl.l   #1,D4
.L10:
            bfextu  (A4){D5:D3},D0
            and.l   D4,D0
            or.l    D0,(A5)
            adda.l  A2,A4
            adda.l  A3,A5
            dbra    D7,.L10
            bra.b   .L18
.L11:
            move.w  D2,D6
            and.l   D0,D6
            sub.w   D3,D6
            bfextu  (-$98,A6){0:D3},D2
            movem.l D5-D6,(-$AC,A6)
            move.w  D5,D0
            add.w   D3,D0
            move.w  D0,(-$1A4,A6)
            move.w  (-$19A,A6),D4
            bfextu  D2{0:D4},D1
.L12:
            bfextu  (A5){D6:D3},D0
            cmp.l   D2,D0
            beq.b   .L15
.L13:
            bfextu  (A4){D5:D4},D0
            cmp.w   D0,D1
            beq.b   .L14
            bfins   D0,(A5){D6:D4}
.L14:
            add.w   D4,D6
            add.w   D4,D5
            cmp.w   (-$1A4,A6),D5
            blt.b   .L13
            movem.l (-$AC,A6),D5-D6
            bra.b   .L16
.L15:
            bfextu  (A4){D5:D3},D0
            bfins   D0,(A5){D6:D3}
.L16:
            adda.l  A2,A4
            adda.l  A3,A5
            dbra    D7,.L12
.L17:
            tst.w   (-$1B0,A6)
            beq.b   .L18
            tst.b   (-$190,A6)
            beq.b   .L18
            sf      (-$1B1,A6)
            sf      (-$1B2,A6)
            movem.w (-$B6,A6),D1-D3/A3
            movem.l (-$60,A6),A2/A4-A5
            bra.w   DrText.L53
.L18:
            subq.w  #1,(-$D6,A6)
            subq.w  #1,(-$1AA,A6)
            bgt.w   DrText.L46
.L19:
            movea.l (-$8C,A6),A5
            tst.b   (-$18F,A6)
            beq.b   .L21
            tst.b   (-$1AB,A6)
            beq.b   .L20
            move.b  (-$1AC,A6),D0
            jsr     ([$574.w])
            jsr     ([$F4C.w])
.L20:
            bra.w   .L46
.L21:
            movea.l (A5),A0
            movea.l (A0),A3
            movea.l (-$B0,A0),A4
            movea.l (2,A4),A2
            movea.l (A2),A2
            move.w  (-$7C,A6),D7
            sub.w   (8,A2),D7
            clr.w   D2
            move.b  (6,A4),D2
            bra.b   .L24
.L22:
            movea.l (-$4C,A6),A0
            move.w  (-$32,A6),D1
            sub.w   D0,D0
.L23:
            move.l  (A0),D0
            roxr.l  #1,D0
            or.l    D0,(A0)+
            dbra    D1,.L23
.L24:
            dbra    D2,.L22
            moveq   #0,D2
            move.b  (7,A4),D2
            beq.b   .L28
            movea.l (-$30,A6),A1
            move.w  (-$34,A6),D3
            suba.w  D3,A1
            lsr.w   #2,D3
            subq.w  #1,D3
            move.w  (-$40,A6),D6
            moveq   #0,D4
            bra.b   .L27
.L25:
            add.l   D2,D4
            move.l  D4,D5
            lsr.l   #4,D5
            neg.l   D5
            movea.l A1,A0
            subq.w  #4,A0
            move.w  D3,D1
.L26:
            bfextu  (A0){D5:0},D0
            subq.w  #4,A0
            move.l  D0,-(A1)
            dbra    D1,.L26
.L27:
            dbra    D6,.L25
.L28:
            tst.b   ($A,A4)
            beq.b   .L32
            movea.l (-$4C,A6),A0
            move.w  (-$34,A6),D1
            move.w  ($12,A2),D0
            move.w  ($14,A2),D2
            mulu.w  D1,D0
            adda.l  D0,A0
            movea.l A0,A1
            movea.l A0,A2
            adda.w  D1,A1
            cmpi.w  #2,D2
            blt.b   .L32
            beq.b   .L29
            adda.w  D1,A2
            adda.w  D1,A2
.L29:
            suba.w  D1,SP
            move.l  A3,-(SP)
            lea     (4,SP),A3
            lsr.w   #2,D1
            subq.w  #1,D1
            move.w  D1,D2
            sub.w   D0,D0
.L30:
            move.l  (A0)+,D0
            or.l    (A1)+,D0
            or.l    (A2)+,D0
            move.l  D0,(A3)
            roxr.l  #1,D0
            or.l    D0,(A3)+
            dbra    D1,.L30
            movea.l A1,A0
            sub.w   D0,D0
.L31:
            move.l  -(A3),D0
            roxl.l  #1,D0
            or.l    (A3),D0
            not.l   D0
            or.l    D0,-(A1)
            dbra    D2,.L31
            movea.l (SP)+,A3
.L32:
            move.w  #$A,(-$C0,A6)
            move.l  (-$188,A6),(-$BE,A6)
            move.l  (-$184,A6),(-$BA,A6)
            lea     (-$C0,A6),A0
            move.l  A0,(-$C4,A6)
            lea     (-$E4,A6),A0
            movea.l A0,A1
            move.l  (-$4C,A6),(A0)+
            move.w  (-$34,A6),(A0)+
            move.w  (-$C,A6),(A0)+
            move.w  (-$3E,A6),(A0)+
            move.l  (-8,A6),(A0)+
            lea     (-$132,A6),A2
            jsr     ([$1A08.w])
            tst.b   (-$190,A6)
            beq.b   .L33
            lea     (-$140,A6),A0
            move.l  (-$58,A6),(A0)+
            move.w  (-$B0,A6),(A0)+
            move.w  (-$C,A6),(A0)+
            move.w  (-$3E,A6),(A0)+
            move.l  (-8,A6),(A0)+
.L33:
            tst.w   (-$1B0,A6)
            beq.b   .L34
            move.w  (-$19A,A6),(-$112,A6)
            move.l  (-$164,A6),(-$108,A6)
.L34:
            clr.w   D3
            move.b  ($B,A4),D3
            beq.w   .L45
            move.w  (-$34,A6),D0
            subq.w  #1,D0
            clr.l   -(SP)
            move.l  SP,(-$3C,A6)
.L35:
            clr.l   -(SP)
            dbra    D0,.L35
            move.w  (-$32,A6),D0
            subq.w  #1,D0
            movea.l (-$30,A6),A0
.L36:
            move.l  -(A0),-(SP)
            dbra    D0,.L36
            move.l  SP,(-$38,A6)
            clr.l   -(SP)
            andi.w  #3,D3
            move.w  D3,D2
.L37:
            movea.l (-$38,A6),A0
            move.w  (-$32,A6),D1
            sub.w   D0,D0
.L38:
            move.l  (A0),D0
            roxr.l  #1,D0
            or.l    D0,(A0)+
            dbra    D1,.L38
            dbra    D2,.L37
            movea.l (-$38,A6),A2
.L39:
            movea.l (-$3C,A6),A1
            movea.l A1,A0
            move.w  (-$E0,A6),D2
            suba.w  D2,A0
.L40:
            move.l  -(A0),D0
            or.l    D0,-(A1)
            cmpa.l  A2,A0
            bgt.b   .L40
            dbra    D3,.L39
            move.w  (-$32,A6),D1
            movea.l (-$4C,A6),A0
            movea.l A2,A1
            adda.w  D2,A1
            sub.w   D0,D0
.L41:
            move.l  (A0)+,D0
            roxr.l  #1,D0
            eor.l   D0,(A1)+
            dbra    D1,.L41
            move.l  A2,(-$E4,A6)
            addq.w  #4,(-$DA,A6)
            move.l  (-$C,A6),(-$1C,A6)
            move.l  (-8,A6),(-$18,A6)
            addq.w  #4,(-$18,A6)
            move.l  (-$1C,A6),(-$24,A6)
            move.l  (-$18,A6),(-$20,A6)
            lea     (-$24,A6),A0
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            tst.b   (-$191,A6)
            beq.b   .L42
            pea     (-$24,A6)
            pea     (-$68,A6)
            pea     (-$70,A6)
            jsr     ([$11E8.w])
.L42:
            pea     (-$E4,A6)
            move.l  (-$94,A6),-(SP)
            beq.b   .L43
            move.l  (4,SP),(SP)
.L43:
            pea     (2,A3)
            pea     (-$1C,A6)
            pea     (-$1C,A6)
            pea     (-$24,A6)
            move.w  (-$1AE,A6),-(SP)
            clr.l   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($18,A3),-(SP)
            pea     (-$C4,A6)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            tst.w   (6,A3)
            bmi.b   .L46
            move.w  (-$1AE,A6),D0
            cmpi.w  #1,D0
            beq.b   .L44
            cmpi.w  #3,D0
            bne.b   .L46
.L44:
            move.l  (-$4C,A6),(-$E4,A6)
            subq.w  #4,(-$DA,A6)
            clr.l   (-$94,A6)
            eori.w  #2,D0
            move.w  D0,(-$1AE,A6)
.L45:
            pea     (-$132,A6)
            move.l  (-$94,A6),-(SP)
            pea     (2,A3)
            pea     (-$C,A6)
            pea     (-$C,A6)
            pea     (-$14,A6)
            move.w  (-$1AE,A6),-(SP)
            clr.l   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($18,A3),-(SP)
            pea     (-$C4,A6)
            move.b  (-$1B5,A6),-(SP)
            jsr     ([$1A9C.w])
.L46:
            movea.l (-4,A6),SP
            move.w  (-$D6,A6),D0
            sub.w   (-$1AA,A6),D0
            move.w  D0,(-$D6,A6)
            bgt.w   DrText.L29
            bset    #7,HiliteMode
            tst.w   (-$1A8,A6)
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            beq.b   .L47
            addq.w  #2,SP
.L47:
            rtd     #$E
            ds.b    6
