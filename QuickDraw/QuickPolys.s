XDrawPoly:
SortVectors:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($A,A6),A3
            move.w  A3,D3
            andi.w  #7,D3
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.b   .L10
            lsl.l   #3,D0
            movea.l A3,A4
            adda.l  D0,A4
            subq.l  #8,A4
            move.l  SP,D4
            movem.l A3-A4,-(SP)
.L1:
            movem.l (SP)+,A3-A4
.L2:
            movea.l A3,A1
            movea.l A4,A2
            move.l  A3,D0
            add.l   A4,D0
            roxr.l  #1,D0
            andi.w  #$FFF8,D0
            or.w    D3,D0
            movea.l D0,A0
            move.w  (2,A0),D1
            move.w  (A0),D2
            bra.b   .L4
.L3:
            addq.l  #8,A1
.L4:
            cmp.w   (A1),D2
            bgt.b   .L3
            blt.b   .L6
            cmp.w   (2,A1),D1
            bgt.b   .L3
            bra.b   .L6
.L5:
            subq.l  #8,A2
.L6:
            cmp.w   (A2),D2
            blt.b   .L5
            bgt.b   .L7
            cmp.w   (2,A2),D1
            blt.b   .L5
.L7:
            cmpa.l  A2,A1
            bgt.b   .L8
            move.l  (A1),D0
            move.l  (A2),(A1)
            move.l  D0,(A2)
            move.l  (4,A1),D0
            move.l  (4,A2),(4,A1)
            move.l  D0,(4,A2)
            addq.l  #8,A1
            subq.l  #8,A2
.L8:
            cmpa.l  A2,A1
            bls.b   .L4
            cmpa.l  A4,A1
            bcc.b   .L9
            movem.l A1/A4,-(SP)
.L9:
            movea.l A2,A4
            cmpa.l  A4,A3
            bcs.b   .L2
            cmpa.l  D4,SP
            bne.b   .L1
.L10:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #6
PaintVector:
            link.w  A6,#-$144
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$144,A6)
            clr.l   (-$20,A6)
            movea.l (A5),A0
            movea.l (A0),A4
            tst.w   ($42,A4)
            blt.w   .L57
            lea     (-$88,A6),A0
            move.l  A0,(A0)
            clr.l   (-$96,A6)
            clr.w   (-$8A,A6)
            move.w  #1,(-$8E,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            lea     (2,A4),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$134,A6)
            move.b  D2,(-$130,A6)
            lea     ShftTbl,A0
            move.w  (-$D4,A6),D0
            moveq   #0,D1
            move.b  (0,A0,D0.w),D1
            move.w  D1,(-$76,A6)
            move.l  (8,A6),(-$9C,A6)
            move.w  ($C,A6),D0
            bset    #3,D0
            moveq   #$10,D1
            btst    #5,D0
            beq.b   .L1
            cmpi.w  #$3A,D0
            beq.b   .L2
            moveq   #$30,D1
.L1:
            cmp.w   D1,D0
            bgt.w   .L57
.L2:
            move.w  D0,(-$98,A6)
            tst.w   (6,A4)
            smi     (-$A6,A6)
            clr.b   (-$101,A6)
            jsr     ([$1A10.w])
            movea.l ($1C,A4),A2
            movea.l (A2),A2
            movea.l ($18,A4),A3
            movea.l (A3),A3
            move.l  ($E,A6),-(SP)
            pea     (-$EE,A6)
            pea     (2,A2)
            pea     (2,A3)
            move.w  #4,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   .L57
            clr.b   (-$12E,A6)
            cmpi.w  #$A,(A2)
            bne.b   .L7
            cmpi.w  #$A,(A3)
            beq.b   .L3
            move.l  ($18,A4),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L57
            bgt.b   .L7
.L3:
            btst    #5,(-$97,A6)
            bne.b   .L7
            movea.l (-$9C,A6),A0
            tst.b   (-$A6,A6)
            beq.b   .L4
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L7
            movea.l (6,A0),A0
            movea.l (A0),A0
.L4:
            move.l  (A0)+,D0
            cmp.l   (A0)+,D0
            bne.b   .L7
            not.l   D0
            beq.b   .L5
            not.l   D0
            bne.b   .L7
            eori.w  #4,(-$98,A6)
.L5:
            st      (-$12E,A6)
            moveq   #7,D0
            and.w   (-$98,A6),D0
            move.b  .L6(PC,D0.w),D0
            bmi.w   .L57
            move.w  D0,(-$98,A6)
            bra.b   .L7
.L6:
            dc.w    0,$0102,$02FF,$FFFF
.L7:
            tst.b   (-$130,A6)
            beq.b   .L8
            pea     (-$74,A6)
            move.l  (-$134,A6),-(SP)
            jsr     ([$F54.w])
.L8:
            move.w  (-$76,A6),D5
            move.w  (-$72,A6),D2
            sub.w   (-$EC,A6),D2
            ext.l   D2
            lsl.l   D5,D2
            andi.l  #$FFFFFFE0,D2
            move.l  D2,D0
            lsr.l   #3,D0
            move.w  D0,(-$90,A6)
            lsr.l   D5,D2
            add.w   (-$EC,A6),D2
            move.w  D2,(-$E,A6)
            tst.b   (-$12E,A6)
            bne.w   .L10
            move.w  (-$6E,A6),D0
            sub.w   D2,D0
            move.w  D0,D1
            ext.l   D1
            lsl.l   D5,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D5,D0
            subq.w  #1,D0
.L9:
            clr.l   -(SP)
            dbra    D0,.L9
            move.l  SP,(-8,A6)
            lea     .L56,A0
            move.l  A0,(-$80,A6)
            move.l  Lo3Bytes,(-$84,A6)
            clr.l   (-$7C,A6)
            clr.l   (-$C,A6)
            move.l  ($18,A4),-(SP)
            move.l  ($1C,A4),-(SP)
            move.l  #1,-(SP)
            jsr     ([$1A34.w])
.L10:
            move.w  (-$74,A6),D1
            sub.w   (-$EE,A6),D1
            move.w  (-$F0,A6),D0
            andi.w  #$7FFF,D0
            ext.l   D0
            move.l  D0,(-$7C,A6)
            muls.w  D0,D1
            add.l   (-$F4,A6),D1
            move.w  (-$E,A6),D2
            sub.w   (-$EC,A6),D2
            move.w  (-$76,A6),D7
            lsl.w   D7,D2
            lsr.w   #3,D2
            ext.l   D2
            add.l   D2,D1
            move.l  D1,(-$124,A6)
            move.w  (-$E,A6),D1
            sub.w   D1,(-$72,A6)
            sub.w   D1,(-$6E,A6)
            move.w  (-$98,A6),D2
            tst.b   (-$12E,A6)
            beq.b   .L11
            jsr     ([$1A30.w])
            move.l  A4,(-$120,A6)
            bra.b   .L15
.L11:
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L12
            bclr    #2,D2
            beq.b   .L12
            not.l   D7
.L12:
            jsr     ([$1A54.w])
            move.w  (-$8E,A6),D1
            bne.b   .L13
            moveq   #$F,D0
            moveq   #4,D1
            move.w  D1,(-$8E,A6)
            move.w  #3,(-$8C,A6)
            move.w  #$3F,(-$8A,A6)
            bra.b   .L14
.L13:
            moveq   #0,D0
            move.w  (-$8A,A6),D0
            addq.w  #1,D0
            divu.w  (-$8E,A6),D0
            subq.w  #1,D0
.L14:
            and.w   (-$74,A6),D0
            mulu.w  D1,D0
            move.l  D0,(-$96,A6)
            move.w  (-$98,A6),D2
            jsr     ([$1A94.w])
            move.l  A4,(-$120,A6)
.L15:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            clr.l   (-$138,A6)
            clr.l   (-$140,A6)
            _StackSpace
            move.l  SP,D1
            sub.l   D0,D1
            addi.l  #$640,D1
            move.l  D1,(-$13C,A6)
            move.l  ($16,A6),D0
            jsr     ([$644.w])
            movea.l D0,A3
            move.w  (A3),D4
            move.w  D4,(-4,A6)
            move.w  ($14,A6),D3
.L16:
            suba.l  A0,A0
            suba.l  A1,A1
            tst.w   D3
            beq.w   .L29
.L17:
            cmp.w   (A3),D4
            bne.w   .L29
            movea.l (-$138,A6),A2
            move.l  A2,D0
            bne.b   .L18
            suba.w  #$14,SP
            movea.l SP,A2
            cmpa.l  (-$13C,A6),A2
            bge.b   .L19
            move.w  #$FF70,QDErr
            bra.w   .L55
.L18:
            move.l  (A2),(-$138,A6)
.L19:
            movem.l A0-A1,-(SP)
            clr.l   -(SP)
            move.l  (4,A3),-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D2
            movem.l (SP)+,A0-A1
            move.w  (2,A3),D1
            sub.w   (-$E,A6),D1
            swap    D1
            move.w  #$8000,D1
            move.l  D2,D0
            asr.l   #1,D0
            add.l   D0,D1
            move.l  #$10000,D0
            tst.l   D2
            bmi.b   .L20
            cmp.l   D0,D2
            bge.b   .L21
            add.l   D2,D1
            bra.b   .L21
.L20:
            cmpi.l  #$FFFF0000,D2
            bge.b   .L21
            add.l   D0,D1
.L21:
            move.l  D1,(8,A2)
            move.l  D2,($C,A2)
            moveq   #1,D1
            move.w  (4,A3),D0
            bpl.b   .L22
            neg.w   D0
            neg.w   D1
.L22:
            add.w   D4,D0
            move.w  D0,($10,A2)
            tst.b   ($12,A6)
            beq.b   .L23
            moveq   #0,D1
.L23:
            move.w  D1,($12,A2)
            move.l  A0,D0
            bne.b   .L24
            movea.l A2,A0
            movea.l A2,A1
            clr.l   (A2)
            clr.l   (4,A2)
            bra.b   .L28
.L24:
            movea.l A1,A4
            move.l  (8,A2),D0
.L25:
            cmp.l   (8,A4),D0
            bge.b   .L26
            movea.l (4,A4),A4
            move.l  A4,D1
            bne.b   .L25
            move.l  A0,(A2)
            move.l  A2,(4,A0)
            clr.l   (4,A2)
            movea.l A2,A0
            bra.b   .L28
.L26:
            cmpa.l  A1,A4
            beq.b   .L27
            move.l  A4,(4,A2)
            move.l  (A4),D0
            move.l  A2,(A4)
            move.l  D0,(A2)
            movea.l D0,A4
            move.l  A2,(4,A4)
            bra.b   .L28
.L27:
            move.l  A2,(A1)
            move.l  A1,(4,A2)
            clr.l   (A2)
            movea.l A2,A1
.L28:
            addq.l  #8,A3
            subq.w  #1,D3
            bgt.w   .L17
.L29:
            suba.l  A1,A1
            movea.l (-$140,A6),A4
.L30:
            move.l  A4,D0
            bne.b   .L32
            move.l  A0,D0
            beq.b   .L39
            move.l  A1,(4,A0)
            bne.b   .L31
            move.l  A0,(-$140,A6)
            bra.b   .L39
.L31:
            move.l  A0,(A1)
            bra.b   .L39
.L32:
            move.l  A0,D0
            bne.b   .L34
            move.l  A1,(4,A4)
            bne.b   .L33
            move.l  A4,(-$140,A6)
            bra.b   .L39
.L33:
            move.l  A4,(A1)
            bra.b   .L39
.L34:
            move.l  (8,A4),D0
            cmp.l   (8,A0),D0
            ble.b   .L35
            movea.l A0,A2
            movea.l (A2),A0
            bra.b   .L36
.L35:
            movea.l A4,A2
            movea.l (A2),A4
.L36:
            move.l  A1,(4,A2)
            bne.b   .L37
            move.l  A2,(-$140,A6)
            bra.b   .L38
.L37:
            move.l  A2,(A1)
.L38:
            clr.l   (A2)
            movea.l A2,A1
            bra.b   .L30
.L39:
            cmp.w   (-$74,A6),D4
            blt.b   .L40
            tst.b   (-$12E,A6)
            bne.b   .L40
            move.w  D4,(-4,A6)
            jsr     ([-$1C.w,A6])
.L40:
            movea.l (-$140,A6),A4
            moveq   #0,D5
.L41:
            movea.l A4,A1
            movea.l (A1),A4
            cmp.w   ($10,A1),D4
            bge.w   .L49
            move.w  ($12,A1),D0
            beq.b   .L44
            tst.w   D5
            bne.b   .L42
            move.w  (8,A1),D6
.L42:
            add.w   D0,D5
            bne.b   .L46
.L43:
            move.w  (8,A1),D0
            cmp.w   D6,D0
            bgt.b   .L45
            bra.b   .L46
.L44:
            eori.w  #1,D5
            beq.b   .L43
            move.w  (8,A1),D6
            bra.b   .L46
.L45:
            cmp.w   (-$74,A6),D4
            blt.b   .L46
            move.w  D6,D1
            move.w  D0,D2
            movem.l D3-D6/A1-A4,-(SP)
            move.l  (-$96,A6),D6
            lea     ([-$88.w,A6],D6.l),A0
            move.l  (A0),D6
            movea.l (-$124,A6),A1
            movea.l (-8,A6),A2
            lea     (-$74,A6),A3
            movea.l (-$120,A6),A4
            move.w  (-$76,A6),D0
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            jsr     ([$1A2C.w])
            move.l  A4,(-$120,A6)
            movem.l (SP)+,D3-D6/A1-A4
.L46:
            move.l  (8,A1),D0
            add.l   ($C,A1),D0
            move.l  D0,(8,A1)
            movea.l (4,A1),A2
            move.l  A2,D1
            beq.b   .L53
            cmp.l   (8,A2),D0
            bge.b   .L53
            move.l  (A1),(A2)
            beq.b   .L47
            movea.l (A1),A0
            move.l  A2,(4,A0)
.L47:
            movea.l (4,A2),A2
            move.l  A2,D1
            bne.b   .L48
            movea.l (-$140,A6),A2
            move.l  A2,(A1)
            clr.l   (4,A1)
            move.l  A1,(4,A2)
            move.l  A1,(-$140,A6)
            bra.b   .L53
.L48:
            cmp.l   (8,A2),D0
            blt.b   .L47
            movea.l (A2),A0
            move.l  A0,(A1)
            move.l  A2,(4,A1)
            move.l  A1,(4,A0)
            move.l  A1,(A2)
            bra.b   .L53
.L49:
            movea.l (4,A1),A0
            move.l  A0,D0
            bne.b   .L50
            move.l  (A1),(-$140,A6)
            bra.b   .L51
.L50:
            move.l  (A1),(A0)
.L51:
            beq.b   .L52
            movea.l (A1),A2
            move.l  A0,(4,A2)
.L52:
            move.l  (-$138,A6),(A1)
            move.l  A1,(-$138,A6)
            movea.l A0,A1
.L53:
            move.l  A4,D0
            bne.w   .L41
            cmp.w   (-$74,A6),D4
            blt.b   .L54
            move.l  (-$96,A6),D0
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            move.l  D0,(-$96,A6)
            move.l  (-$7C,A6),D0
            add.l   D0,(-$124,A6)
.L54:
            addq.w  #1,D4
            move.w  D4,(-4,A6)
            cmp.w   (-$70,A6),D4
            bge.b   .L55
            tst.l   (-$140,A6)
            bne.w   .L16
            tst.w   D3
            bne.w   .L16
.L55:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L56:
            tst.b   (-$130,A6)
            beq.b   .L57
            jsr     ([$F4C.w])
.L57:
            bset    #7,HiliteMode
            movea.l (-$144,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$12
            ds.b    6
