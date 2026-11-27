DrawArc:
            link.w  A6,#-$1C4
            movem.l D0-D7/A1-A4,-(SP)
            move.l  SP,(-$124,A6)
            clr.l   (-$20,A6)
            movea.l (A5),A0
            movea.l (A0),A4
            tst.w   ($42,A4)
            blt.w   ONESLAB.L9
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
            move.l  D1,(-$1C4,A6)
            move.b  D2,(-$166,A6)
            lea     ShftTbl,A0
            move.w  (-$D4,A6),D0
            moveq   #0,D1
            move.b  (0,A0,D0.w),D1
            move.w  D1,(-$76,A6)
            move.l  ($C,A6),(-$9C,A6)
            move.w  ($10,A6),D0
            bset    #3,D0
            moveq   #$10,D1
            btst    #5,D0
            beq.b   .L1
            cmpi.w  #$3A,D0
            beq.b   .L2
            moveq   #$30,D1
.L1:
            cmp.w   D1,D0
            bgt.w   ONESLAB.L9
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
            move.l  ($18,A6),-(SP)
            pea     (-$EE,A6)
            pea     (2,A2)
            pea     (2,A3)
            move.w  #4,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   ONESLAB.L9
            clr.b   (-$136,A6)
            cmpi.w  #$A,(A2)
            bne.b   .L7
            cmpi.w  #$A,(A3)
            beq.b   .L3
            move.l  ($18,A4),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   ONESLAB.L9
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
            st      (-$136,A6)
            moveq   #7,D0
            and.w   (-$98,A6),D0
            move.b  .L6(PC,D0.w),D0
            bmi.w   ONESLAB.L9
            move.w  D0,(-$98,A6)
            bra.b   .L7
.L6:
            dc.w    0,$0102,$02FF,$FFFF
.L7:
            clr.b   (-$19A,A6)
            move.w  (8,A6),D0
            beq.w   ONESLAB.L9
            bpl.b   .L8
            add.w   D0,($A,A6)
            neg.w   D0
            move.w  D0,(8,A6)
.L8:
            cmpi.w  #$168,D0
            slt     (-$199,A6)
            bge.w   .L16
            move.w  ($A,A6),D0
            ext.l   D0
            divs.w  #$168,D0
            swap    D0
            tst.w   D0
            bpl.b   .L9
            addi.w  #$168,D0
.L9:
            move.w  D0,($A,A6)
            add.w   (8,A6),D0
            cmpi.w  #$168,D0
            blt.b   .L10
            subi.w  #$168,D0
.L10:
            move.w  D0,(-$19C,A6)
            movea.l ($18,A6),A0
            move.w  (A0),D0
            add.w   (4,A0),D0
            asr.w   #1,D0
            move.w  D0,(-$19E,A6)
            move.w  (2,A0),D0
            add.w   (6,A0),D0
            asr.w   #1,D0
            move.w  D0,(-$1A0,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-$1A2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-$1A4,A6)
            clr.l   -(SP)
            move.w  (-$1A2,A6),-(SP)
            move.w  (-$1A4,A6),-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D7
            clr.l   -(SP)
            move.w  ($A,A6),-(SP)
            jsr     ([$10F0.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,(-$1A8,A6)
            clr.l   -(SP)
            move.w  (-$19C,A6),-(SP)
            jsr     ([$10F0.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,(-$1AC,A6)
            move.w  (-$1A0,A6),D6
            swap    D6
            clr.w   D6
            move.w  (-$1A4,A6),D7
            lsr.w   #1,D7
            move.w  (-$1A6,A6),D0
            mulu.w  D7,D0
            move.l  D0,(-$1B0,A6)
            move.w  (-$1A8,A6),D0
            muls.w  D7,D0
            add.w   D0,(-$1B0,A6)
            move.l  D6,D0
            sub.l   (-$1B0,A6),D0
            move.l  D0,(-$1B0,A6)
            move.w  (-$1AA,A6),D0
            mulu.w  D7,D0
            move.l  D0,(-$1B4,A6)
            move.w  (-$1AC,A6),D0
            muls.w  D7,D0
            add.w   D0,(-$1B4,A6)
            sub.l   (-$1B4,A6),D6
            move.l  D6,(-$1B4,A6)
            move.w  ($A,A6),D0
            cmpi.w  #$B4,D0
            bge.b   .L11
            subi.w  #$5A,D0
            bra.b   .L12
.L11:
            subi.w  #$10E,D0
            neg.w   D0
.L12:
            move.w  D0,(-$1B6,A6)
            move.w  (-$19C,A6),D0
            cmpi.w  #$B4,D0
            bge.b   .L13
            subi.w  #$5A,D0
            bra.b   .L14
.L13:
            subi.w  #$10E,D0
            neg.w   D0
.L14:
            move.w  D0,(-$1B8,A6)
            move.w  (8,A6),D0
            cmpi.w  #$B4,D0
            bgt.b   .L16
            blt.b   .L15
            cmpi.w  #$5A,($A,A6)
            seq     (-$19A,A6)
            bra.b   .L16
.L15:
            move.w  (-$1B6,A6),D0
            or.w    (-$1B8,A6),D0
            spl     (-$19A,A6)
.L16:
            movea.l ($18,A6),A0
            lea     (-$194,A6),A1
            move.w  ($12,A6),D1
            move.w  ($14,A6),D2
            jsr     InitOval
            move.w  ($12,A6),D0
            asr.w   #1,D0
            add.w   (-$194,A6),D0
            move.w  D0,(-$196,A6)
            movea.l ($18,A6),A0
            add.w   (4,A0),D0
            sub.w   (A0),D0
            sub.w   ($12,A6),D0
            move.w  D0,(-$198,A6)
            move.w  #$7FFF,(-$164,A6)
            tst.b   ($16,A6)
            beq.b   .L17
            movea.l ($18,A6),A0
            movem.w (A0),D0-D3
            move.l  ($34,A4),D4
            add.w   D4,D1
            sub.w   D4,D3
            cmp.w   D3,D1
            bge.b   .L17
            swap    D4
            add.w   D4,D0
            sub.w   D4,D2
            cmp.w   D2,D0
            bge.b   .L17
            movem.w D0-D3,(-$134,A6)
            lea     (-$134,A6),A0
            lea     (-$164,A6),A1
            move.w  ($12,A6),D1
            sub.w   D4,D1
            sub.w   D4,D1
            move.w  ($14,A6),D2
            swap    D4
            sub.w   D4,D2
            sub.w   D4,D2
            jsr     InitOval
.L17:
            tst.b   (-$166,A6)
            beq.b   .L18
            pea     (-$74,A6)
            move.l  (-$1C4,A6),-(SP)
            jsr     ([$F54.w])
.L18:
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
            tst.b   (-$136,A6)
            bne.w   .L20
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
.L19:
            clr.l   -(SP)
            dbra    D0,.L19
            move.l  SP,(-8,A6)
            lea     ONESLAB.L8,A0
            move.l  A0,(-$80,A6)
            move.l  Lo3Bytes,(-$84,A6)
            clr.l   (-$7C,A6)
            clr.l   (-$C,A6)
            move.l  ($18,A4),-(SP)
            move.l  ($1C,A4),-(SP)
            move.l  #1,-(SP)
            jsr     ([$1A34.w])
.L20:
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
            move.l  D1,(-$12C,A6)
            move.w  (-$E,A6),D1
            sub.w   D1,(-$72,A6)
            sub.w   D1,(-$6E,A6)
            sub.w   D1,(-$172,A6)
            sub.w   D1,(-$16E,A6)
            sub.w   D1,(-$142,A6)
            sub.w   D1,(-$13E,A6)
            sub.w   D1,(-$1B0,A6)
            sub.w   D1,(-$1B4,A6)
            move.w  (-$98,A6),D2
            tst.b   (-$136,A6)
            beq.b   .L21
            jsr     ([$1A30.w])
            move.l  A4,(-$128,A6)
            bra.b   .L25
.L21:
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L22
            bclr    #2,D2
            beq.b   .L22
            not.l   D7
.L22:
            jsr     ([$1A54.w])
            move.w  (-$8E,A6),D1
            bne.b   .L23
            moveq   #$F,D0
            moveq   #4,D1
            move.w  D1,(-$8E,A6)
            move.w  #3,(-$8C,A6)
            move.w  #$3F,(-$8A,A6)
            bra.b   .L24
.L23:
            moveq   #0,D0
            move.w  (-$8A,A6),D0
            addq.w  #1,D0
            divu.w  (-$8E,A6),D0
            subq.w  #1,D0
.L24:
            and.w   (-$74,A6),D0
            mulu.w  D1,D0
            move.l  D0,(-$96,A6)
            move.w  (-$98,A6),D2
            jsr     ([$1A94.w])
            move.l  A4,(-$128,A6)
.L25:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$194,A6),D7
            move.w  D7,(-4,A6)
.L26:
            cmp.w   (-$196,A6),D7
            blt.b   .L27
            cmp.w   (-$198,A6),D7
            blt.b   .L28
.L27:
            move.w  D7,-(SP)
            move.w  D7,D0
            lea     (-$194,A6),A3
            jsr     BumpOval
            move.w  (SP),D0
            lea     (-$164,A6),A3
            jsr     BumpOval
            move.w  (SP)+,D7
.L28:
            cmp.w   (-$19E,A6),D7
            bne.b   .L31
            tst.b   (-$199,A6)
            beq.b   .L31
            neg.w   (-$1B6,A6)
            neg.w   (-$1B8,A6)
            clr.b   (-$19A,A6)
            move.w  (8,A6),D0
            cmpi.w  #$B4,D0
            bgt.b   .L30
            blt.b   .L29
            cmpi.w  #$10E,($A,A6)
            bne.b   .L30
            bra.w   ONESLAB.L7
.L29:
            move.w  (-$1B6,A6),D0
            or.w    (-$1B8,A6),D0
            bpl.w   ONESLAB.L7
.L30:
            move.w  (-$1B6,A6),D0
            move.w  (-$1B8,A6),(-$1B6,A6)
            move.w  D0,(-$1B8,A6)
            move.l  (-$1B0,A6),D0
            move.l  (-$1B4,A6),(-$1B0,A6)
            move.l  D0,(-$1B4,A6)
            move.l  (-$1A8,A6),D0
            move.l  (-$1AC,A6),(-$1A8,A6)
            move.l  D0,(-$1AC,A6)
.L31:
            cmp.w   (-$74,A6),D7
            blt.w   ONESLAB.L6
            tst.b   (-$19A,A6)
            bne.w   ONESLAB.L5
            tst.b   (-$136,A6)
            bne.b   .L32
            jsr     ([-$1C.w,A6])
.L32:
            tst.b   (-$199,A6)
            bne.b   .L33
            cmp.w   (-$164,A6),D7
            blt.w   ONESLAB.L3
            cmp.w   (-$162,A6),D7
            bge.w   ONESLAB.L3
            bra.w   ONESLAB.L2
.L33:
            move.w  (-$172,A6),D1
            tst.w   (-$1B6,A6)
            bpl.b   .L34
            cmp.w   (-$1B0,A6),D1
            bge.b   .L34
            move.w  (-$1B0,A6),D1
.L34:
            move.w  D1,(-$1BA,A6)
            move.w  (-$16E,A6),D2
            tst.w   (-$1B8,A6)
            bpl.b   .L35
            cmp.w   (-$1B4,A6),D2
            ble.b   .L35
            move.w  (-$1B4,A6),D2
.L35:
            move.w  D2,(-$1BC,A6)
            cmp.w   (-$164,A6),D7
            blt.w   ONESLAB.L1
            cmp.w   (-$162,A6),D7
            bge.w   ONESLAB.L1
            move.w  (-$142,A6),D0
            tst.w   (-$1B8,A6)
            bpl.b   .L36
            cmp.w   (-$1B4,A6),D0
            ble.b   .L36
            move.w  (-$1B4,A6),D0
.L36:
            move.w  D0,(-$1BE,A6)
            move.w  (-$13E,A6),D0
            tst.w   (-$1B6,A6)
            bpl.b   .L37
            cmp.w   (-$1B0,A6),D0
            bge.b   .L37
            move.w  (-$1B0,A6),D0
.L37:
            move.w  D0,(-$1C0,A6)
            cmp.w   D2,D1
            bge.b   .L38
            move.w  (-$1BE,A6),D2
            bsr.b   ONESLAB
            move.w  (-$1C0,A6),D1
            move.w  (-$1BC,A6),D2
            bra.w   ONESLAB.L4
.L38:
            move.w  (-$1B6,A6),D0
            and.w   (-$1B8,A6),D0
            bpl.w   ONESLAB.L5
            cmpi.w  #$B4,(8,A6)
            ble.w   ONESLAB.L5
            cmp.w   (-$1BE,A6),D2
            bne.b   .L39
            move.w  (-$142,A6),D2
            bra.b   .L40
.L39:
            move.w  (-$1BA,A6),D0
            cmp.w   (-$1C0,A6),D0
            bne.b   .L41
            move.w  (-$13E,A6),D1
            move.w  (-$1BC,A6),D2
.L40:
            bsr.b   ONESLAB
.L41:
            move.w  (-$172,A6),D1
            move.w  (-$1BE,A6),D2
            bsr.b   ONESLAB
            move.w  (-$1C0,A6),D1
            move.w  (-$16E,A6),D2
            bra.b   ONESLAB.L4
ONESLAB:
            move.l  (-$96,A6),D6
            lea     ([-$88.w,A6],D6.l),A0
            move.l  (A0),D6
            movea.l (-$12C,A6),A1
            movea.l (-8,A6),A2
            lea     (-$74,A6),A3
            move.w  (-$76,A6),D0
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            jsr     ([$1A2C.w])
            rts
.L1:
            cmp.w   D2,D1
            blt.b   .L4
            move.w  (-$1B6,A6),D0
            and.w   (-$1B8,A6),D0
            bpl.b   .L5
            cmpi.w  #$B4,(8,A6)
            ble.b   .L5
            move.w  (-$172,A6),D1
            bsr.b   ONESLAB
            move.w  (-$1BA,A6),D1
            move.w  (-$16E,A6),D2
            bra.b   .L4
.L2:
            move.w  (-$172,A6),D1
            move.w  (-$142,A6),D2
            bsr.b   ONESLAB
            move.w  (-$13E,A6),D1
            move.w  (-$16E,A6),D2
            bsr.b   ONESLAB
            bra.b   .L5
.L3:
            move.w  (-$172,A6),D1
            move.w  (-$16E,A6),D2
.L4:
            bsr.b   ONESLAB
.L5:
            move.l  (-$96,A6),D0
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            move.l  D0,(-$96,A6)
            move.l  (-$7C,A6),D0
            add.l   D0,(-$12C,A6)
.L6:
            move.l  (-$1A8,A6),D0
            add.l   D0,(-$1B0,A6)
            move.l  (-$1AC,A6),D0
            add.l   D0,(-$1B4,A6)
            addq.w  #1,D7
            move.w  D7,(-4,A6)
            cmp.w   (-$70,A6),D7
            blt.w   DrawArc.L26
.L7:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L8:
            tst.b   (-$166,A6)
            beq.b   .L9
            jsr     ([$F4C.w])
.L9:
            bset    #7,HiliteMode
            movea.l (-$124,A6),SP
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            rtd     #$14
            ds.b    6
InitOval:
            move.w  (A0),(A1)
            move.w  (4,A0),(2,A1)
            tst.w   D2
            bpl.b   .L1
            clr.w   D2
.L1:
            tst.w   D1
            bpl.b   .L2
            clr.w   D1
.L2:
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            cmp.w   D0,D2
            ble.b   .L3
            move.w  D0,D2
.L3:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            cmp.w   D0,D1
            ble.b   .L4
            move.w  D0,D1
.L4:
            move.w  (6,A0),($26,A1)
            clr.w   ($28,A1)
            move.w  (2,A0),($22,A1)
            clr.w   ($24,A1)
            move.w  D2,D0
            swap    D0
            clr.w   D0
            lsr.l   #1,D0
            add.l   D0,($22,A1)
            sub.l   D0,($26,A1)
            move.l  #$8000,D0
            move.l  D0,($2A,A1)
            add.l   D0,($26,A1)
            moveq   #1,D0
            sub.w   D1,D0
            move.w  D0,(4,A1)
            move.w  D1,D0
            ext.l   D0
            add.l   D0,D0
            subq.l  #1,D0
            move.l  D0,(6,A1)
            clr.l   ($A,A1)
            clr.l   ($E,A1)
            clr.l   -(SP)
            move.w  D1,-(SP)
            move.w  D2,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP),-(SP)
            pea     ($12,A1)
            jsr     ([$F9C.w])
            move.l  ($16,A1),D0
            add.l   D0,D0
            move.l  D0,($1E,A1)
            move.l  ($12,A1),D0
            addx.l  D0,D0
            move.l  D0,($1A,A1)
            rts
            ds.b    6
BumpOval:
            cmp.w   (A3)+,D0
            blt.b   .L5
            cmp.w   (A3)+,D0
            bge.b   .L5
            move.w  (A3),D0
            addq.w  #2,(A3)+
            movem.l (A3),D1-D7/A0-A2
            bra.b   .L2
.L1:
            adda.l  A2,A1
            suba.l  A2,A0
            add.l   D5,D3
            addx.l  D4,D2
            add.l   D7,D5
            addx.l  D6,D4
.L2:
            cmp.l   D1,D2
            blt.b   .L1
            bra.b   .L4
.L3:
            suba.l  A2,A1
            adda.l  A2,A0
            sub.l   D7,D5
            subx.l  D6,D4
            sub.l   D5,D3
            subx.l  D4,D2
.L4:
            cmp.l   D1,D2
            bgt.b   .L3
            addq.w  #1,D0
            ext.l   D0
            asl.l   #2,D0
            sub.l   D0,D1
            movem.l D1-D7/A0-A2,(A3)
.L5:
            rts
            ds.b    14
