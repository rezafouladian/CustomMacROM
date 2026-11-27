StretchBits:
            link.w  A6,#-$2C8
            movem.l D0-D7/A1-A5,-(SP)
            move.l  SP,(-$1CC,A6)
            move.l  A5,(-$1D0,A6)
            move.b  MMU32bit,(-$102,A6)
            clr.l   (-$20,A6)
            clr.l   (-$2B4,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            move.l  TheGDevice,-(SP)
            move.l  SrcDevice,TheGDevice
            movea.l ($30,A6),A1
            lea     (-$168,A6),A2
            jsr     ([$1A08.w])
            move.l  (SP)+,TheGDevice
            movea.l ($28,A6),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$244,A6)
            move.b  D2,(-$240,A6)
            lea     ShftTbl,A0
            move.w  (-$148,A6),D0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            move.w  D3,(-$1C2,A6)
            move.w  (-$D4,A6),D0
            moveq   #0,D4
            move.b  (0,A0,D0.w),D4
            move.w  D4,(-$76,A6)
            move.l  ($2C,A6),D0
            beq.b   .L1
            movea.l D0,A1
            lea     (-$1B8,A6),A2
            jsr     ([$1A08.w])
            clr.w   (-$1C4,A6)
            move.w  (-$198,A6),D0
            cmpi.w  #1,D0
            beq.b   .L1
            clr.l   ($2C,A6)
.L1:
            move.l  ($1C,A6),-(SP)
            pea     (-$EE,A6)
            movea.l ($12,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($A,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #5,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   DONESTRETCH.L3
            move.l  ($16,A6),(-$9C,A6)
            move.w  ($1A,A6),(-$98,A6)
            tst.w   ([$28.w,A6],4.w)
            smi     (-$A6,A6)
            bclr    #6,(-$97,A6)
            sne     (-$A5,A6)
            move.b  (8,A6),(-$101,A6)
            jsr     ([$1A10.w])
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L2
            bclr    #2,D2
            beq.b   .L2
            not.l   D7
.L2:
            move.l  D7,(-$1C8,A6)
            clr.w   (-$8E,A6)
            btst    #3,D2
            beq.b   .L3
            jsr     ([$1A54.w])
.L3:
            tst.b   (-$240,A6)
            beq.b   .L4
            pea     (-$74,A6)
            move.l  (-$244,A6),-(SP)
            jsr     ([$F54.w])
.L4:
            lea     (-$168,A6),A4
            move.w  #$7FFF,D0
            ext.l   D0
            move.w  (4,A4),D1
            and.l   D0,D1
            move.l  D1,(-$1BC,A6)
            lea     (-$1B8,A6),A0
            move.w  (4,A0),D1
            and.l   D0,D1
            move.l  D1,(-$1C0,A6)
            lea     (-$F4,A6),A5
            move.w  (4,A5),D1
            and.l   D0,D1
            move.l  D1,(-$7C,A6)
            movea.l ($24,A6),A2
            move.l  A2,D0
            jsr     ([$644.w])
            move.l  D0,($24,A6)
            movea.l ($1C,A6),A3
            move.l  A3,D0
            jsr     ([$644.w])
            move.l  D0,($1C,A6)
            move.w  (-$98,A6),D0
            ror.w   #4,D0
            bcs.b   BLITCASE.L2
            move.w  (4,A2),D1
            sub.w   (A2),D1
            swap    D1
            move.w  (6,A2),D1
            sub.w   (2,A2),D1
            move.w  D1,D0
            subq.w  #1,D0
            move.w  D0,(-$22C,A6)
            move.w  (4,A3),D0
            sub.w   (A3),D0
            swap    D0
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            jsr     ([$1C60.w])
BLITCASE:
            clr.b   (-$2B5,A6)
            tst.l   ($2C,A6)
            bne.w   .L9
            cmp.l   D0,D1
            bne.w   .L9
            cmp.w   D3,D4
            beq.b   .L1
            cmpi.w  #$10,(-$14A,A6)
            bne.w   .L4
            movea.l ([TheGDevice.w]),A0
            tst.l   ($C,A0)
            bne.w   .L9
            bra.w   .L4
.L1:
            cmpi.w  #$10,(-$D6,A6)
            beq.b   .L2
            movea.l (-$13E,A6),A0
            movea.l (A0),A0
            move.l  (A0),D2
            movea.l (-$CA,A6),A0
            movea.l (A0),A0
            cmp.l   (A0),D2
            beq.b   .L2
            bne.b   .L4
.L2:
            moveq   #$A,D0
            movea.l ($A,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            bne.w   .L8
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L3
            move.l  ($E,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   DONESTRETCH
            bgt.w   .L8
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($E,A6)
.L3:
            movea.l ($12,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L7
            move.l  ($12,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   DONESTRETCH
            beq.b   .L7
            movea.l ($12,A6),A1
            move.l  ($A,A6),($12,A6)
            move.l  A1,($A,A6)
            bra.b   .L8
.L4:
            tst.w   (-$98,A6)
            bne.b   .L9
            tst.w   (-$104,A6)
            bne.b   .L9
            tst.w   D7
            bne.b   .L9
            st      (-$2B5,A6)
            cmpi.w  #5,D4
            bne.b   .L6
            cmpi.w  #3,D3
            bgt.b   .L9
.L5:
            move.l  ($1C5C).w,(-$80,A6)
            jsr     ([$1C58.w])
            tst.w   D0
            beq.w   .L2
            bra.w   DONESTRETCH
.L6:
            cmpi.w  #5,D3
            bne.b   .L9
            cmpi.w  #3,D4
            bne.b   .L9
            bra.b   .L5
.L7:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            movea.l ($24,A6),A2
            movea.l ($1C,A6),A3
            jsr     ([$1A00.w])
            bra.w   DONESTRETCH
.L8:
            move.l  ($1C5C).w,(-$80,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$190,D0
            move.l  D0,(-$84,A6)
            jsr     ([$1A7C.w])
            bra.w   DONESTRETCH
.L9:
            movem.l D3-D4,-(SP)
            move.l  D0,(-$208,A6)
            move.l  D1,(-$20C,A6)
            jsr     ([$1A90.w])
            move.l  A0,(-$21C,A6)
            move.w  D0,(-$222,A6)
            movem.l (SP)+,D3-D4
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$190,D0
            move.l  D0,(-$84,A6)
            bpl.b   .L10
            jsr     ([$1C5C.w])
.L10:
            move.l  (-$208,A6),D0
            move.l  (-$20C,A6),D1
            clr.b   (-$2AA,A6)
            cmp.l   D1,D0
            beq.b   .L14
            blt.b   .L11
            cmp.w   D1,D0
            bge.b   .L14
.L11:
            cmpi.w  #5,D3
            bne.b   .L14
            seq     (-$2AA,A6)
            moveq   #0,D2
            move.w  D1,D2
            add.w   D2,D2
            add.w   D1,D2
            lsr.w   #1,D2
            move.w  D2,(-$2AC,A6)
            sub.l   D2,(-$84,A6)
            bpl.b   .L12
            jsr     ([$1C5C.w])
.L12:
            clr.l   -(SP)
.L13:
            clr.l   -(SP)
            dbra    D2,.L13
            move.l  SP,(-$2B0,A6)
.L14:
            clr.l   (-$228,A6)
            move.w  (-$14A,A6),D0
            beq.w   STSEARCHTAB.L1
            cmpi.w  #$10,D0
            bne.w   DONESTRETCH
            cmp.w   D3,D4
            beq.w   ONEBITPROC.L3
            moveq   #4,D0
            move.l  D0,D5
            cmp.w   D3,D5
            beq.b   .L15
            moveq   #0,D5
.L15:
            cmp.w   D4,D0
            bne.b   .L16
            addq.w  #2,D5
.L16:
            movea.l ([TheGDevice.w]),A2
            cmpi.w  #$10,(-$D6,A6)
            beq.w   .L24
            tst.w   D4
            bne.b   .L17
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L17
            addq.w  #8,D5
            bra.w   .L26
.L17:
            addq.w  #1,D5
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            movea.l ([6.w,A2]),A0
            cmp.l   (A0),D1
            beq.b   .L19
            move.l  ($2A,A1),-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            beq.b   .L18
            addq.w  #4,SP
            bra.w   DONESTRETCH.L1
.L18:
            movea.l ([TheGDevice.w]),A2
            movea.l ([6.w,A2]),A0
.L19:
            addq.w  #6,A0
            move.l  A0,(-$28C,A6)
            subq.w  #6,A0
            move.w  (4,A0),(-$29E,A6)
            movea.l ([$16.w,A2]),A1
            move.l  ([$2A.w,A1]),(-$29C,A6)
            move.l  ($C,A2),D0
            bne.b   .L25
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            tst.w   (2,A1)
            bpl.b   .L20
            addq.w  #6,A1
            move.l  A1,(-$290,A6)
            addq.w  #8,D5
            moveq   #$28,D0
            cmp.l   (A0),D0
            beq.b   .L26
.L20:
            tst.b   (-$A5,A6)
            beq.b   .L26
            addq.w  #2,D5
            moveq   #0,D0
            move.w  (-$206,A6),D0
            lsl.l   D4,D0
            addi.l  #$1F,D0
            lsr.l   D4,D0
            btst    #3,D5
            bne.b   .L21
            move.w  D0,D1
            add.w   D0,D0
            add.w   D1,D0
.L21:
            lsr.w   #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L22
            jsr     ([$1C5C.w])
.L22:
            clr.l   -(SP)
.L23:
            clr.l   -(SP)
            dbra    D0,.L23
            move.l  SP,(-$2A4,A6)
            clr.b   (-$2A9,A6)
            bra.b   .L26
.L24:
            move.l  ($C,A2),D0
            beq.b   .L26
.L25:
            move.l  D0,(-$294,A6)
            bset    #4,D5
.L26:
            move.w  D5,D0
            lsr.w   #3,D0
            lea     ($1CA0.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #7,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
            bra.w   ONEBITPROC.L3
            dc.w    $6000,$0908,0
STCOLORTAB:
            dc.w    $FFFF,$FFFA,0,$2790,0,$2A30,0,$2390
            dc.w    0,$2C50,0,$2B00,$FFFF,$FFFA,0,$24A0
STGRAYTAB:
            dc.w    0,$2830,0,$27D0,$FFFF,$FFDA,0,$2590
            dc.w    0,$28F0,0,$2880,$FFFF,$FFDA,0,$2670
STSEARCHTAB:
            dc.w    $FFFF,$FFBA,0,$2940,0,$2A20,$FFFF,$FFBA
            dc.w    0,$2CB0,0,$2B30,$FFFF,$FFBA,$FFFF,$FFBA
.L1:
            movea.l (-$13E,A6),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$CA,A6),A0
            cmpi.w  #$10,(-$D6,A6)
            beq.b   .L2
            movea.l (A0),A0
            cmp.l   (A0),D0
            bne.b   .L2
            cmp.w   D3,D4
            beq.w   ONEBITPROC.L3
.L2:
            tst.w   D3
            bne.b   .L3
            moveq   #1,D1
            cmp.l   D0,D1
            beq.w   ONEBITPROC.L2
.L3:
            move.w  (-$148,A6),D1
            moveq   #1,D0
            lsl.w   D1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L4
            jsr     ([$1C5C.w])
.L4:
            moveq   #0,D7
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L5
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L5
            moveq   #1,D7
            pea     ONEBITPROC
            jsr     ([$16E8.w])
.L5:
            movea.l (-$1D0,A6),A5
            move.l  A4,-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.w  (-$148,A6),D1
            cmp.w   (-$D4,A6),D1
            bne.b   .L8
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.w  D1,A0
.L6:
            cmp.l   -(A0),D0
            dbne    D0,.L6
            bne.b   .L8
            tst.w   D7
            beq.b   .L7
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L7:
            lea     (-$F4,A6),A5
            tst.l   ($2C,A6)
            bne.w   ONEBITPROC.L3
            move.l  (-$208,A6),D0
            cmp.l   (-$20C,A6),D0
            bne.w   ONEBITPROC.L3
            move.l  (-$1C8,A6),D7
            bra.w   BLITCASE.L2
.L8:
            move.l  SP,(-$23C,A6)
            lea     (-$F4,A6),A5
            tst.w   D7
            beq.b   .L9
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L9:
            movea.l ($1CAC).w,A0
            move.l  A0,(-$228,A6)
            bra.b   ONEBITPROC.L3
            dc.w    0
ONEBITPROC:
            st      ($C,SP)
            movea.l (8,SP),A0
            moveq   #0,D0
            moveq   #0,D1
            move.w  (A0),D0
            movea.l D0,A1
            move.w  (2,A0),D1
            add.l   D0,D1
            move.w  (4,A0),D0
            add.l   D0,D1
            add.l   D0,D1
            lsr.l   #2,D1
            add.l   A1,D1
            move.w  (2,A0),D0
            add.l   D0,D1
            add.l   D0,D1
            lsr.l   #2,D1
            movea.l (4,SP),A1
            clr.l   (A1)
            tst.w   D1
            bmi.b   .L1
            addq.l  #1,(A1)
.L1:
            rtd     #8
.L2:
            movea.l ($1AAC).w,A0
            adda.l  (0,A0,D4.w*4),A0
            move.l  A0,(-$228,A6)
            bra.b   .L5
.L3:
            tst.b   (-$103,A6)
            bne.b   .L4
            move.l  #$FFFFFFFF,(-$A0,A6)
.L4:
            tst.b   (-$104,A6)
            bne.b   .L5
            clr.l   (-$A4,A6)
.L5:
            moveq   #0,D0
            move.w  (-$20A,A6),D0
            lsl.l   D3,D0
            subq.l  #1,D0
            lsr.l   #5,D0
            move.w  D0,(-$1EC,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L6
            jsr     ([$1C5C.w])
.L6:
            clr.l   -(SP)
.L7:
            clr.l   -(SP)
            dbra    D0,.L7
            move.l  SP,(-$1D4,A6)
            move.l  SP,(-$1D8,A6)
            move.l  SP,(-$1DC,A6)
            moveq   #0,D0
            move.w  (-$206,A6),D0
            cmp.w   (-$20A,A6),D0
            beq.b   .L10
            lsl.l   D3,D0
            subq.l  #1,D0
            lsr.l   #5,D0
            move.w  D0,(-$1F2,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L8
            jsr     ([$1C5C.w])
.L8:
            clr.l   -(SP)
.L9:
            clr.l   -(SP)
            dbra    D0,.L9
            move.l  SP,(-$1D8,A6)
            move.l  SP,(-$1DC,A6)
.L10:
            clr.l   (-$210,A6)
            clr.l   (-$214,A6)
            move.l  ($2C,A6),D0
            beq.w   .L15
            movea.l ($20,A6),A0
            move.w  (4,A0),D1
            sub.w   (A0),D1
            swap    D1
            move.w  (6,A0),D1
            sub.w   (2,A0),D1
            move.w  (4,A3),D0
            sub.w   (A3),D0
            swap    D0
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            movem.l D3-D4,-(SP)
            move.l  D0,(-$210,A6)
            move.l  D1,(-$214,A6)
            jsr     ([$1A90.w])
            move.l  A0,(-$220,A6)
            move.w  D0,(-$224,A6)
            movem.l (SP)+,D3-D4
            moveq   #0,D0
            move.w  (-$212,A6),D0
            subq.w  #1,D0
            lsr.w   #5,D0
            move.w  D0,(-$1EE,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L11
            jsr     ([$1C5C.w])
.L11:
            clr.l   -(SP)
.L12:
            clr.l   -(SP)
            dbra    D0,.L12
            move.l  SP,(-$1E8,A6)
            move.l  SP,(-$20,A6)
            moveq   #0,D0
            move.w  (-$20E,A6),D0
            cmp.w   (-$212,A6),D0
            beq.b   .L15
            subq.w  #1,D0
            lsr.w   #5,D0
            move.w  D0,(-$1F0,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L13
            jsr     ([$1C5C.w])
.L13:
            clr.l   -(SP)
.L14:
            clr.l   -(SP)
            dbra    D0,.L14
            move.l  SP,(-$20,A6)
.L15:
            tst.l   (-$228,A6)
            beq.b   .L18
            moveq   #0,D0
            move.w  (-$206,A6),D0
            subq.l  #1,D0
            lsl.l   D4,D0
            lsr.l   #5,D0
            move.w  D0,(-$1F4,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L16
            jsr     ([$1C5C.w])
.L16:
            clr.l   -(SP)
            clr.l   -(SP)
.L17:
            clr.l   -(SP)
            dbra    D0,.L17
            move.l  SP,(-$1DC,A6)
.L18:
            movea.l ($1C,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A5),D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            asr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            moveq   #0,D0
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$10,A6)
            move.w  D0,D1
            ext.l   D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            addq.l  #1,D1
            btst    #5,(-$97,A6)
            bne.b   .L19
            move.w  D1,(-$10,A6)
.L19:
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D4,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L20
            jsr     ([$1C5C.w])
.L20:
            clr.l   -(SP)
            clr.l   -(SP)
.L21:
            clr.l   -(SP)
            dbra    D0,.L21
            move.l  SP,(-8,A6)
            move.l  ($1C5C).w,(-$80,A6)
            clr.l   (-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            move.w  (-$98,A6),D0
            btst    #5,D0
            beq.b   .L26
            cmpi.w  #$40,D0
            bgt.w   DONESTRETCH
            btst    #3,D0
            bne.w   DONESTRETCH
            andi.w  #$17,D0
            bclr    #4,D0
            beq.b   .L22
            subq.w  #2,D0
            bne.w   DONESTRETCH
            addq.w  #8,D0
.L22:
            cmpi.w  #$10,(-$D4,A6)
            bge.b   .L23
            addq.w  #4,D0
            bra.b   .L27
.L23:
            bne.b   .L25
            movea.l ($1C98).w,A0
.L24:
            bclr    #4,D0
            adda.l  (0,A0,D0.w*4),A0
            move.l  A0,(-$218,A6)
            bra.b   .L28
.L25:
            movea.l ($1C9C).w,A0
            bra.b   .L24
.L26:
            move.l  (-$1C8,A6),D7
            bclr    #2,D0
            cmpi.w  #7,D0
            bgt.w   DONESTRETCH
.L27:
            lea     ($1BCC).w,A0
            move.l  (0,A0,D0.w*4),(-$218,A6)
.L28:
            tst.l   ($2C,A6)
            beq.b   .L29
            move.w  (-$1C4,A6),D3
            lea     (-$1B8,A6),A2
            move.l  (-$1C0,A6),D2
            movea.l ($20,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A2),D1
            ext.l   D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$238,A6)
            move.w  (A0),D0
            sub.w   (6,A2),D0
            muls.w  D2,D0
            add.l   (A2),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1FC,A6)
.L29:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$1C2,A6),D3
            lea     (-$168,A6),A2
            move.l  (-$1BC,A6),D2
            move.w  ($A,A2),D1
            sub.w   (6,A2),D1
            move.w  D1,(-$22A,A6)
            movea.l ($24,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A2),D1
            ext.l   D1
            lsl.l   D3,D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$230,A6)
            move.w  (A0),D0
            sub.w   (6,A2),D0
            muls.w  D2,D0
            add.l   (A2),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1F8,A6)
            move.w  (-$76,A6),D4
            move.l  (-$7C,A6),D2
            movea.l ($1C,A6),A0
            move.w  (A0),(-4,A6)
            move.w  (2,A0),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            moveq   #$1F,D6
            and.l   D1,D6
            neg.l   D6
            move.l  D6,(-$234,A6)
            move.l  D6,D0
            asr.l   D4,D0
            move.l  D0,(-$24,A6)
            move.w  (-$74,A6),D0
            sub.w   (6,A5),D0
            muls.w  D2,D0
            add.l   (A5),D0
            asr.l   #5,D1
            lsl.l   #2,D1
            add.l   D1,D0
            move.l  D0,(-$200,A6)
            jsr     ([$1C64.w])
STSCANLOOP:
            tst.b   (-$2B5,A6)
            beq.b   .L2
            cmpi.w  #8,(-$D4,A6)
            bne.b   .L1
            cmpi.w  #8,(-$148,A6)
            beq.w   CB8TO8CLIP
            cmpi.w  #1,(-$148,A6)
            bne.b   .L2
            movea.l ($1AAC).w,A0
            adda.l  ($C,A0),A0
            cmpa.l  (-$228,A6),A0
            bne.b   .L2
            bra.w   ANDY
.L1:
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L2
            cmpi.w  #8,(-$148,A6)
            beq.w   CB8TO1CLIP
.L2:
            move.w  (-$20C,A6),D0
            lsr.w   #1,D0
            neg.w   D0
            move.w  D0,(-$23E,A6)
.L3:
            tst.w   (-$22A,A6)
            ble.w   DONESTRETCH
            tst.b   (-$2AA,A6)
            bne.w   .L13
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D1
            move.l  (-$230,A6),D5
.L4:
            bfextu  (A0){D5:0},D0
            addq.w  #4,A0
            move.l  D0,(A1)+
            dbra    D1,.L4
            tst.l   ($2C,A6)
            beq.b   .L6
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D3
.L5:
            bfextu  (A0){D3:0},D0
            addq.w  #4,A0
            move.l  D0,(A1)+
            dbra    D1,.L5
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L6:
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            bgt.w   .L32
            tst.w   (-$1C2,A6)
            beq.w   .L28
.L7:
            tst.w   (-$22A,A6)
            ble.w   .L32
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D6
            move.w  (-$148,A6),D3
            moveq   #0,D4
.L8:
            bfextu  (A0){D5:0},D0
            move.l  (A1),D1
.L9:
            bfextu  D0{D4:D3},D2
            bfextu  D1{D4:D3},D7
            cmp.l   D7,D2
            ble.b   .L10
            bfins   D2,D1{D4:D3}
.L10:
            add.w   D3,D4
            andi.w  #$1F,D4
            bne.b   .L9
            addq.w  #4,A0
            move.l  D1,(A1)+
            dbra    D6,.L8
            tst.l   ($2C,A6)
            beq.b   .L12
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D2
.L11:
            bfextu  (A0){D2:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L11
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L12:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L7
            move.l  (-$230,A6),D5
            move.l  (-$234,A6),D6
            move.l  (-$1C8,A6),D7
            bra.w   .L32
            ds.b    10
.L13:
            moveq   #0,D1
            tst.l   ($2C,A6)
            beq.b   .L15
            movea.l (-$1E8,A6),A0
            move.w  (-$1EE,A6),D0
.L14:
            move.l  D1,(A0)+
            dbra    D0,.L14
.L15:
            moveq   #0,D4
            move.w  (-$23E,A6),D0
            add.w   (-$208,A6),D0
            bgt.b   .L19
            cmpi.w  #1,(-$22A,A6)
            beq.b   .L19
            move.w  (-$2AC,A6),D0
            movea.l (-$2B0,A6),A0
.L16:
            move.l  D1,(A0)+
            dbra    D0,.L16
.L17:
            tst.w   (-$22A,A6)
            ble.w   .L22
            movea.l (-$1F8,A6),A0
            movea.l (-$2B0,A6),A1
            move.w  (-$1EC,A6),D6
            addq.w  #1,D4
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
.L18:
            move.l  (A0)+,D0
            move.b  D0,D3
            lsr.l   #8,D0
            move.b  D0,D2
            lsr.l   #8,D0
            move.b  D0,D1
            add.w   D1,(A1)+
            add.w   D2,(A1)+
            add.w   D3,(A1)+
            dbra    D6,.L18
.L19:
            tst.l   ($2C,A6)
            beq.b   .L21
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D2
.L20:
            bfextu  (A0){D2:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L20
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L21:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L17
.L22:
            movea.l (-$1D4,A6),A1
            movea.l (-$2B0,A6),A0
            move.w  (-$1EC,A6),D6
            cmpi.w  #2,D4
            blt.b   .L25
            beq.b   .L24
.L23:
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.w  D1,D0
            lsl.l   #8,D0
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.b  D1,D0
            lsl.l   #8,D0
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.b  D1,D0
            move.l  D0,(A1)+
            dbra    D6,.L23
            bra.b   .L27
.L24:
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.w  D1,D0
            lsl.l   #8,D0
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.b  D1,D0
            lsl.l   #8,D0
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.b  D1,D0
            move.l  D0,(A1)+
            dbra    D6,.L24
            bra.b   .L27
.L25:
            move.l  (-$1BC,A6),D0
            movea.l (-$1F8,A6),A0
            suba.l  D0,A0
.L26:
            move.l  (A0)+,(A1)+
            dbra    D6,.L26
.L27:
            move.l  (-$230,A6),D5
            move.l  (-$234,A6),D6
            move.l  (-$1C8,A6),D7
            bra.b   .L32
            dc.w    0
.L28:
            tst.w   (-$22A,A6)
            ble.b   .L32
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D1
.L29:
            bfextu  (A0){D5:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L29
            tst.l   ($2C,A6)
            beq.b   .L31
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D3
.L30:
            bfextu  (A0){D3:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L30
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L31:
            add.l   D2,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L28
.L32:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            bge.b   .L33
            addq.w  #1,(-4,A6)
            move.w  (-$20C,A6),D0
            sub.w   D0,(-$23E,A6)
            bge.b   .L32
            blt.w   .L3
.L33:
            move.w  (-$206,A6),D0
            cmp.w   (-$20A,A6),D0
            beq.b   .L34
            move.w  (-$1F2,A6),D0
            movea.l (-$1D4,A6),A0
            movea.l (-$1D8,A6),A1
            lea     (4,A1,D0.w*4),A2
            move.w  (-$222,A6),D4
            move.w  (-$148,A6),D5
            movea.l (-$21C,A6),A3
            moveq   #0,D0
            jsr     (A3)
.L34:
            move.w  (-$20E,A6),D0
            cmp.w   (-$212,A6),D0
            beq.b   .L35
            move.w  (-$1F0,A6),D0
            movea.l (-$1E8,A6),A0
            movea.l (-$20,A6),A1
            lea     (4,A1,D0.w*4),A2
            move.w  (-$224,A6),D4
            moveq   #1,D5
            movea.l (-$220,A6),A3
            moveq   #0,D0
            jsr     (A3)
.L35:
            move.l  (-$228,A6),D1
            beq.b   .L36
            move.w  (-$148,A6),D3
            move.w  (-$D4,A6),D4
            movea.l (-$1D8,A6),A0
            movea.l (-$1DC,A6),A1
            move.w  (-$1F4,A6),D0
            lea     (4,A1,D0.w*4),A2
            movea.l D1,A3
            movea.l (-$23C,A6),A4
            moveq   #0,D0
            jsr     (A3)
.L36:
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
            btst    #5,(-$97,A6)
            beq.b   .L39
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            moveq   #$20,D5
            divu.w  D7,D5
            tst.w   (-$104,A6)
            beq.b   .L38
            movea.l (-$1DC,A6),A3
            move.w  (-$10,A6),D2
.L37:
            move.l  (A3),D0
            and.l   D3,D0
            not.l   (A3)
            and.l   D4,(A3)
            or.l    D0,(A3)+
            sub.w   D5,D2
            bge.b   .L37
.L38:
            movea.l (-$108,A6),A5
            cmpi.w  #$24,(-$98,A6)
            bne.b   .L39
            bfextu  (-$114,A6){0:D7},D0
            movea.l D0,A5
.L39:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L44
            jsr     ([-$1C.w,A6])
            movea.l (-$1DC,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-8,A6),A2
            move.w  (-$10,A6),D2
            movea.l (-$218,A6),A0
            btst    #5,(-$97,A6)
            beq.b   .L41
            move.l  (-$114,A6),D4
            cmpi.w  #$24,(-$98,A6)
            beq.b   .L40
            move.w  (-$10E,A6),D5
.L40:
            moveq   #0,D3
            move.l  (-$234,A6),D6
            sub.l   D7,D6
.L41:
            cmpa.l  (-$F4,A6),A4
            bcs.b   .L45
.L42:
            jmp     (A0)
.L43:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L44:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.b   DONESTRETCH
            move.w  (-$20C,A6),D0
            sub.w   D0,(-$23E,A6)
            blt.w   .L3
            tst.b   (-$A5,A6)
            bne.w   .L35
            bra.b   .L39
.L45:
            move.l  (-$F4,A6),D1
            btst    #5,(-$97,A6)
            beq.b   .L47
.L46:
            lea     (0,A4,D3.w),A1
            cmp.l   A1,D1
            bls.b   .L42
            subq.w  #1,D2
            bmi.b   .L43
            add.l   D7,D6
            add.l   D7,D3
            bra.b   .L46
.L47:
            lea     (4,A4),A1
            cmp.l   A1,D1
            bls.b   .L42
            subq.w  #1,D2
            bmi.b   .L43
            addq.l  #4,A2
            addq.l  #4,A3
            addq.l  #4,A4
            bra.b   .L47
DONESTRETCH:
            clr.w   QDErr
.L1:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L2:
            movea.l (-$1D0,A6),A5
            tst.b   (-$240,A6)
            beq.b   .L3
            jsr     ([$F4C.w])
.L3:
            bset    #7,HiliteMode
            movea.l (-$1CC,A6),SP
            move.l  (-$2B4,A6),D0
            beq.b   .L4
            movea.l D0,A0
            jsr     ([$1A78.w])
            move.l  SP,StkLowPt
            move.l  (-$2C4,A6),HiHeapMark
.L4:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$2C
            dc.w    0
STNOSTACK:
            tst.l   (-$84,A6)
            bpl.b   DONESTRETCH.L2
            movem.l D0-D3/A0-A2,-(SP)
            tst.l   (-$2B4,A6)
            bne.b   .L1
            moveq   #1,D0
            swap    D0
            jsr     ([$1A70.w])
            move.l  D0,D2
            beq.b   .L1
            move.l  A0,(-$2B4,A6)
            subi.l  #$640,D2
            asr.l   #2,D2
            add.l   D2,(-$84,A6)
            bmi.b   .L1
            clr.l   StkLowPt
            movea.l SP,A2
            move.l  HiHeapMark,(-$2C4,A6)
            movea.l (A0),A0
            exg     D0,A0
            jsr     ([$644.w])
            move.l  D0,HiHeapMark
            adda.l  D0,A0
            move.l  ($1C,SP),-(A0)
            movea.l A0,SP
            movem.l (A2),D0-D3/A0-A2
            rts
.L1:
            move.w  #$FF6B,QDErr
            bra.w   DONESTRETCH.L2
            ds.b    14
stMASK0:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            move.l  (A2)+,D1
            eor.l   D7,D0
            move.l  D0,D5
            and.l   D3,D0
            not.l   D5
            and.l   D4,D5
            or.l    D5,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK0
            bra.w   STSCANLOOP.L43
            ds.b    10
stMASK1:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            move.l  (A2)+,D1
            and.l   D1,D0
            move.l  D0,D1
            and.l   D3,D1
            not.l   D0
            and.l   (A4),D0
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK1
            bra.w   STSCANLOOP.L43
stMASK2:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            and.l   (A2)+,D0
            eor.l   D0,(A4)+
            dbra    D2,stMASK2
            bra.w   STSCANLOOP.L43
            ds.b    12
stMASK3:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            move.l  (A2)+,D1
            and.l   D1,D0
            move.l  D0,D1
            and.l   D4,D1
            not.l   D0
            and.l   (A4),D0
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK3
            bra.w   STSCANLOOP.L43
stAddOver:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L1
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L1:
            add.l   D7,D3
            dbra    D2,stAddOver
            bra.w   STSCANLOOP.L43
            ds.b    14
stAddPin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L1
            cmp.w   (-$F6,A6),D0
            bls.b   .L2
.L1:
            move.w  (-$F6,A6),D0
.L2:
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L3
            cmp.w   (-$F8,A6),D0
            bls.b   .L4
.L3:
            move.w  (-$F8,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L5
            cmp.w   (-$FA,A6),D0
            bls.b   .L6
.L5:
            move.w  (-$FA,A6),D0
.L6:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L7:
            add.l   D7,D3
            dbra    D2,stAddPin
            bra.w   STSCANLOOP.L43
            ds.b    10
stSubOver:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L1
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L1:
            add.l   D7,D3
            dbra    D2,stSubOver
            bra.w   STSCANLOOP.L43
            ds.b    14
stSubPin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L1
            cmp.w   (-$F6,A6),D0
            bcc.b   .L2
.L1:
            move.w  (-$F6,A6),D0
.L2:
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L3
            cmp.w   (-$F8,A6),D0
            bcc.b   .L4
.L3:
            move.w  (-$F8,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L5
            cmp.w   (-$FA,A6),D0
            bcc.b   .L6
.L5:
            move.w  (-$FA,A6),D0
.L6:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L7:
            add.l   D7,D3
            dbra    D2,stSubPin
            bra.w   STSCANLOOP.L43
            ds.b    10
stMax:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L1
            move.w  (A1),D0
.L1:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L3
            move.w  (A1),D0
.L3:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L4:
            add.l   D7,D3
            dbra    D2,stMax
            bra.w   STSCANLOOP.L43
            ds.b    14
stMin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L1
            move.w  (A1),D0
.L1:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L3
            move.w  (A1),D0
.L3:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L4:
            add.l   D7,D3
            dbra    D2,stMin
            bra.w   STSCANLOOP.L43
            ds.b    14
stAvg:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            moveq   #2,D1
            move.w  (-$10E,A6),D5
            add.w   D5,D5
            clr.w   -(SP)
.L1:
            move.w  (A0)+,D0
            mulu.w  (-$FA.w,A6,D1.w*2),D0
            move.w  (A1)+,D4
            mulu.w  (-$100.w,A6,D1.w*2),D4
            add.l   D4,D0
            swap    D0
            move.w  (-$110,A6),D4
            lsr.w   D4,D0
            lsl.w   D5,D0
            or.w    D0,(SP)
            sub.w   (-$10E,A6),D5
            dbra    D1,.L1
            move.w  (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L2:
            add.l   D7,D3
            dbra    D2,stAvg
            bra.w   STSCANLOOP.L43
stTransparent:
            add.l   D7,D6
.L1:
            bfextu  (A3){D6:0},D0
            cmp.l   D0,D4
            beq.b   .L3
            bfextu  (A2){D3:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            cmpa.l  D0,A5
            beq.b   .L2
            bfins   D0,(A4){D3:D7}
.L2:
            add.l   D7,D3
            dbra    D2,stTransparent
            bra.w   STSCANLOOP.L43
.L3:
            addq.w  #4,A3
            addi.w  #$20,D3
            sub.w   D5,D2
            bge.b   .L1
            move.l  (-$A4,A6),D4
            bra.w   STSCANLOOP.L43
            ds.b    8
stHilite:
            bfextu  D4{0:D7},D4
            bfextu  (-$118,A6){0:D7},D5
.L1:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            beq.b   .L3
            bfextu  (A4){D3:D7},D0
            cmp.l   D4,D0
            bne.b   .L2
            bfins   D5,(A4){D3:D7}
            bra.b   .L3
.L2:
            cmp.l   D5,D0
            bne.b   .L3
            bfins   D4,(A4){D3:D7}
.L3:
            add.l   D7,D3
            dbra    D2,.L1
            bra.w   STSCANLOOP.L43
            ds.b    8
            bsr.w   .L62
            move.l  #$7F7F7F,D0
            movea.l #$808080,A0
.L5:
            tst.l   (A2)+
            beq.b   .L4
            move.l  (0,A3,D6.w),D1
            move.l  A0,D7
            and.l   D1,D7
            and.l   D0,D1
            move.l  (A1),D5
            move.l  A0,D3
            and.l   D5,D3
            and.l   D0,D5
            add.l   D1,D5
            eor.l   D7,D3
            eor.l   D3,D5
            move.l  D5,(A1)
.L4:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L5
            bra.w   STSCANLOOP.L43
            ds.b    6
.L62:
            movea.l A4,A1
            moveq   #0,D6
            rts
            ds.b    10
            bsr.b   .L62
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L42:
            tst.l   (A2)+
            beq.b   .L36
            move.l  (0,A3,D6.w),D7
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A1),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L37
            cmp.w   D3,D0
            bls.b   .L38
.L37:
            move.w  D3,D0
.L38:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L39
            cmp.b   D3,D0
            bls.b   .L40
.L39:
            move.b  D3,D0
.L40:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L41
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L41:
            move.l  D0,(A1)
.L36:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L42
            bra.w   STSCANLOOP.L43
            dc.w    0
            bsr.b   .L62
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L44:
            tst.l   (A2)+
            beq.b   .L43
            move.l  (0,A3,D6.w),D7
            move.l  D1,D3
            and.l   D7,D3
            eor.l   D1,D3
            and.l   D0,D7
            move.l  (A1),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A1)
.L43:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L44
            bra.w   STSCANLOOP.L43
            ds.b    4
            bsr.w   .L62
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L12:
            tst.l   (A2)+
            beq.b   .L6
            move.l  (0,A3,D6.w),D5
            and.l   D1,D5
            move.l  (A1),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L7
            cmp.w   D3,D0
            bcc.b   .L8
.L7:
            move.w  D3,D0
.L8:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L9
            cmp.b   D3,D0
            bcc.b   .L10
.L9:
            move.b  D3,D0
.L10:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L11
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L11:
            move.l  D0,(A1)
.L6:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L12
            bra.w   STSCANLOOP.L43
            bsr.w   .L62
.L17:
            tst.l   (A2)+
            beq.b   .L13
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bhi.b   .L14
            move.w  D1,D0
            move.b  D5,D0
.L14:
            cmp.b   D1,D5
            bhi.b   .L15
            move.b  D1,D0
.L15:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bhi.b   .L16
            move.b  D1,D0
.L16:
            swap    D0
            move.l  D0,(A1)
.L13:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L17
            bra.w   STSCANLOOP.L43
            ds.b    8
            bsr.w   .L62
.L22:
            tst.l   (A2)+
            beq.b   .L18
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bls.b   .L19
            move.w  D1,D0
            move.b  D5,D0
.L19:
            cmp.b   D1,D5
            bls.b   .L20
            move.b  D1,D0
.L20:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bls.b   .L21
            move.b  D1,D0
.L21:
            swap    D0
            move.l  D0,(A1)
.L18:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L22
            bra.w   STSCANLOOP.L43
            ds.b    8
            lea     .L23,A0
            move.l  A0,(-$218,A6)
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L23
            cmp.w   (A0),D3
            bne.b   .L23
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L23
            lea     .L24,A0
            move.l  A0,(-$218,A6)
            bra.w   .L24
.L23:
            bsr.w   .L62
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L63:
            tst.l   (A2)+
            beq.b   .L75
            move.l  (0,A3,D6.w),D7
            move.l  (A1),D5
            cmp.l   D3,D7
            bne.b   .L25
            cmp.l   A0,D5
            beq.b   .L76
.L25:
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
            movea.w D4,A0
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
            adda.w  D4,A0
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
            move.w  A0,D4
            swap    D5
            movea.l D5,A0
            swap    D7
            move.l  D7,D3
.L76:
            move.l  D4,(A1)
.L75:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L63
            bra.w   STSCANLOOP.L43
            ds.b    14
.L24:
            bsr.w   .L62
            move.l  #$7F7F7F,D0
            movea.l #$10101,A0
.L27:
            tst.l   (A2)+
            beq.b   .L26
            move.l  (0,A3,D6.w),D1
            move.l  A0,D3
            and.l   D1,D3
            lsr.l   #1,D1
            and.l   D0,D1
            move.l  (A1),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D1
            add.l   D3,D1
            move.l  D1,(A1)
.L26:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L27
            bra.w   STSCANLOOP.L43
            ds.b    6
            bsr.w   .L62
            move.l  (-$114,A6),D5
.L29:
            tst.l   (A2)+
            beq.b   .L28
            move.l  (0,A3,D6.w),D1
            cmp.l   D1,D5
            beq.b   .L28
            move.l  D1,(A1)
.L28:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L29
            bra.w   STSCANLOOP.L43
            ds.b    14
            bsr.b   .L46
            move.w  #$3DEF,D0
            movea.w #$4210,A0
.L31:
            tst.w   (A2)+
            beq.b   .L30
            move.w  (0,A3,D6.w),D1
            move.w  A0,D7
            and.w   D1,D7
            and.w   D0,D1
            move.w  (A1),D5
            move.w  A0,D3
            and.w   D5,D3
            and.w   D0,D5
            add.w   D1,D5
            eor.w   D7,D3
            eor.w   D3,D5
            move.w  D5,(A1)
.L30:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L31
            bra.w   STSCANLOOP.L43
            ds.b    12
.L46:
            movea.l A4,A1
            moveq   #0,D6
            tst.w   (-$234,A6)
            beq.b   .L45
            subq.w  #2,A3
.L45:
            rts
            dc.w    0
            bsr.b   .L46
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L51:
            tst.w   (A2)+
            beq.b   .L47
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L48
            move.l  D3,D0
.L48:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L49
            move.w  D3,D0
.L49:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L50
            move.b  D3,D0
.L50:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L47:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L51
            bra.w   STSCANLOOP.L43
            ds.b    12
            bsr.w   .L46
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L33:
            tst.w   (A2)+
            beq.b   .L32
            move.w  (0,A3,D6.w),D7
            move.w  D1,D3
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.w  (A1),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A1)
.L32:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L33
            bra.w   STSCANLOOP.L43
            ds.b    6
            bsr.w   .L46
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            move.l  #$808080,D1
            add.l   D1,D3
.L56:
            tst.w   (A2)+
            beq.b   .L52
            moveq   #0,D5
            move.w  (0,A3,D6.w),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A1),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L53
            move.l  D3,D0
.L53:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L54
            move.w  D3,D0
.L54:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L55
            move.b  D3,D0
.L55:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L52:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L56
            bra.w   STSCANLOOP.L43
            bsr.w   .L46
.L61:
            tst.w   (A2)+
            beq.b   .L57
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L58
            move.l  D5,D0
.L58:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L59
            move.w  D5,D0
.L59:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L60
            move.b  D5,D0
.L60:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L57:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L61
            bra.w   STSCANLOOP.L43
            dc.w    0
            bsr.w   .L46
.L68:
            tst.w   (A2)+
            beq.b   .L64
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L65
            move.l  D5,D0
.L65:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L66
            move.w  D5,D0
.L66:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L67
            move.b  D5,D0
.L67:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L64:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L68
            bra.w   STSCANLOOP.L43
            dc.w    0
            lea     .L69,A0
            move.l  A0,(-$218,A6)
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L69
            cmp.w   (A0),D3
            bne.b   .L69
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L69
            lea     .L70,A0
            move.l  A0,(-$218,A6)
            bra.w   .L70
.L69:
            bsr.w   .L46
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L74:
            tst.w   (A2)+
            beq.w   .L71
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            moveq   #0,D5
            move.w  (A1),D5
            cmp.w   D3,D7
            bne.b   .L72
            cmp.w   A0,D5
            beq.b   .L73
.L72:
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
            movea.l D4,A0
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
            adda.w  D4,A0
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
            add.w   A0,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A0
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L73:
            move.w  D4,(A1)
.L71:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L74
            bra.w   STSCANLOOP.L43
            ds.b    8
.L70:
            bsr.w   .L46
            move.w  #$3DEF,D0
            movea.w #$421,A0
.L35:
            tst.w   (A2)+
            beq.b   .L34
            move.w  (0,A3,D6.w),D1
            move.w  A0,D3
            and.w   D1,D3
            lsr.w   #1,D1
            and.w   D0,D1
            move.w  (A1),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D1
            add.w   D3,D1
            move.w  D1,(A1)
.L34:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L35
            bra.w   STSCANLOOP.L43
            ds.b    10
            dc.w    $6100,$FD0E,$2A2E,$FEEC,$4A5A,$670A,$3233,$6000
            dc.w    $BA41,$6702,$3281,$5489,$5486,$51CA,$FFEC,$6000
            dc.w    $F4E6,0
STARITH16TAB:
            dc.w    $FFFF,$FEBC,$FFFF,$FCFC,$FFFF,$FCAC,$FFFF,$FDAC
            dc.w    $FFFF,$FFDC,$FFFF,$FE1C,$FFFF,$FD6C,$FFFF,$FE6C
            dc.w    $FFFF,$F96C
STARITH32TAB:
            dc.w    $FFFF,$FB58,$FFFF,$F9D8,$FFFF,$F988,$FFFF,$FA78
            dc.w    $FFFF,$FC58,$FFFF,$FAD8,$FFFF,$FA38,$FFFF,$FB18
            dc.w    $FFFF,$F948
            ds.b    4
SETUPSTRETCH:
            move.w  D3,-(SP)
            lea     DONESTRETCH,A0
            tst.w   D0
            ble.w   .L2
            tst.w   D1
            ble.w   .L2
            lea     PATEXTBL.L1,A0
            cmp.w   D1,D0
            beq.w   .L2
            blt.w   .L3
            move.w  D0,D3
            move.w  D1,D4
            clr.l   -(SP)
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            lea     PIXSTR,A0
            tst.w   (SP)
            bne.b   .L2
            lea     PATEXTBL.L10,A0
            cmpi.w  #$8000,D0
            beq.b   .L2
            lea     TABLE2.L2,A0
            cmpi.w  #$4000,D0
            beq.b   .L2
            lea     TABLE8.L1,A0
            cmpi.w  #$2000,D0
            beq.b   .L2
            lea     TABLE8.L2,A0
            cmpi.w  #$1000,D0
            beq.b   .L2
            lea     sub_40839140,A0
            cmpi.w  #$800,D0
            beq.b   .L2
            lea     PATEXTBL.L9,A0
            cmpi.w  #$AAAA,D0
            beq.b   .L2
            lea     TABLE2.L1,A0
            cmpi.w  #$5555,D0
            beq.b   .L2
            lea     TABLE4.L1,A0
            cmpi.w  #$2AAA,D0
            beq.b   .L2
            ext.l   D3
            divu.w  D4,D3
            move.w  D3,D1
            andi.l  #$FFFF0007,D3
            bne.b   .L1
            move.w  D1,D0
            lea     sub_40839140.L2,A0
            bra.b   .L2
.L1:
            lea     SHRINK.L4,A0
.L2:
            addq.w  #2,SP
            rts
.L3:
            clr.l   -(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            lea     PIXSHRNK,A0
            tst.w   (SP)
            bne.b   .L2
            lea     PATEXTBL.L8,A0
            cmpi.w  #$2000,D0
            beq.b   .L2
            lea     PATEXTBL.L7,A0
            cmpi.w  #$4000,D0
            beq.b   .L2
            lea     PATEXTBL.L6,A0
            cmpi.w  #$8000,D0
            beq.b   .L2
            lea     PATEXTBL.L5,A0
            cmpi.w  #$C000,D0
            beq.b   .L2
            lea     SHRINK,A0
            bra.b   .L2
EXTBL:
            ori.b   #$44,D0
            dc.w    0,$0304,0,$0574,0,$0B14,0,$0B34
            dc.w    0,$0C14,0,$0C34,0,$0C74
PATEXTBL:
            ori.b   #$34,D0
            dc.w    0,$02A4,0,$0568,0,$0A14,0,$0B34
            dc.w    0,$0B94
            ds.b    12
.L1:
            suba.l  A1,A2
            move.l  A2,D0
            lsr.l   #2,D0
            subq.w  #1,D0
.L11:
            move.l  (A0)+,(A1)+
            dbra    D0,.L11
            rts
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L4
.L3:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.b  D0,D1
            move.w  D1,D0
            swap    D1
            move.w  D0,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L4:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L2
            rts
            ds.b    8
.L5:
            moveq   #3,D3
            ror.l   #2,D3
.L13:
            move.l  (A0)+,D0
            moveq   #7,D2
.L12:
            add.l   D0,D0
            addx.l  D1,D1
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #3,D0
            addx.l  D1,D1
            dbra    D2,.L12
            bfins   D1,(A1){0:24}
            addq.w  #3,A1
            cmpa.l  A2,A1
            bcs.b   .L13
            rts
            ds.b    12
.L6:
            move.l  A2,D3
            sub.l   A1,D3
            lsr.w   #2,D3
            subq.w  #1,D3
            move.l  #'UUUU',D2
            move.l  #$FF00FF,D5
.L19:
            move.l  (A0)+,D0
            move.l  D0,D1
            lsr.l   #1,D1
            or.l    D0,D1
            and.l   D2,D1
            move.l  D1,D0
            lsr.l   #7,D0
            or.l    D1,D0
            and.l   D5,D0
            swap    D0
            move.b  .L20(PC,D0.w),D4
            lsl.w   #8,D4
            swap    D0
            move.b  .L20(PC,D0.w),D4
            swap    D4
            move.l  (A0)+,D0
            move.l  D0,D1
            lsr.l   #1,D1
            or.l    D0,D1
            and.l   D2,D1
            move.l  D1,D0
            lsr.l   #7,D0
            or.l    D1,D0
            and.l   D5,D0
            swap    D0
            move.b  .L20(PC,D0.w),D4
            lsl.w   #8,D4
            swap    D0
            move.b  .L20(PC,D0.w),D4
            move.l  D4,(A1)+
            dbra    D3,.L19
            rts
.L20:
            dc.w    $0001
            dc.w    $1011,$0203,$1213,$2021,$3031,$2223,$3233,$0405
            dc.w    $1415,$0607,$1617
            dc.b    '$%45&',$27,'67@APQBCRS`apqbcrsDETUFGVWdetufgvw'
            dc.w    $0809,$1819,$0A0B,$1A1B
            dc.b    '()89*+:;'
            dc.w    $0C0D,$1C1D,$0E0F,$1E1F
            dc.b    ',-<=./>?HIXYJKZ[hixyjkz'
            dc.b    $7B,$4C,$4D,$5C
            dc.b    ']NO^_lm|'
            dc.b    $7D,$6E,$6F,$7E,$7F,$80,$81,$90,$91,$82,$83,$92,$93,$A0,$A1,$B0
            dc.b    $B1,$A2,$A3,$B2,$B3,$84,$85,$94,$95,$86,$87,$96,$97,$A4,$A5,$B4
            dc.b    $B5,$A6,$A7,$B6,$B7,$C0,$C1,$D0,$D1,$C2,$C3,$D2,$D3,$E0,$E1,$F0
            dc.b    $F1,$E2,$E3,$F2,$F3,$C4,$C5,$D4,$D5,$C6,$C7,$D6,$D7,$E4,$E5,$F4
            dc.b    $F5,$E6,$E7,$F6,$F7,$88,$89,$98,$99,$8A,$8B,$9A,$9B,$A8,$A9,$B8
            dc.b    $B9,$AA,$AB,$BA,$BB,$8C,$8D,$9C,$9D,$8E,$8F,$9E,$9F,$AC,$AD,$BC
            dc.b    $BD,$AE,$AF,$BE,$BF,$C8,$C9,$D8,$D9,$CA,$CB,$DA,$DB,$E8,$E9,$F8
            dc.b    $F9,$EA,$EB,$FA,$FB,$CC,$CD,$DC,$DD,$CE,$CF,$DE,$DF,$EC,$ED,$FC
            dc.b    $FD,$EE,$EF,$FE,$FF,$00,$00
.L7:
            move.l  #$F0000000,D3
.L15:
            move.l  (A0)+,D0
            moveq   #7,D2
.L14:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #4,D0
            dbra    D2,.L14
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L15
            rts
            ds.b    4
.L8:
            move.l  #$FF000000,D3
.L18:
            move.l  (A0)+,D0
            moveq   #3,D2
.L16:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #8,D0
            dbra    D2,.L16
            move.l  (A0)+,D0
            moveq   #3,D2
.L17:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #8,D0
            dbra    D2,.L17
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L18
            rts
            ds.b    6
.L9:
            move.b  (A0)+,D0
            move.w  D0,D1
            lsr.b   #4,D1
            move.b  .L25(PC,D1.w),D2
            lsl.l   #6,D2
            andi.w  #$F,D0
            move.b  .L25(PC,D0.w),D2
            lsl.l   #6,D2
            move.b  (A0)+,D0
            move.w  D0,D1
            lsr.b   #4,D1
            move.b  .L25(PC,D1.w),D2
            lsl.l   #6,D2
            andi.w  #$F,D0
            move.b  .L25(PC,D0.w),D2
            lsr.l   #2,D2
            swap    D2
            move.b  D2,(A1)+
            swap    D2
            move.w  D2,D1
            ror.w   #8,D1
            move.b  D1,(A1)+
            move.b  D2,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L9
            rts
.L25:
            dc.w    $000C,$101C,$606C,$707C,$808C,$909C,$E0EC,$F0FC
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L21
.L23:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L22
.L21:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.w  D0,D1
            move.w  TABLE2(PC,D1.w*2),D1
            move.w  D1,D0
            swap    D1
            move.w  D0,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L22:
            move.l  D1,($20,A1)
            move.l  D1,(A1)+
            dbra    D6,.L23
            rts
            ds.b    4
.L10:
            clr.w   D0
            move.l  A2,D3
            sub.l   A1,D3
            lsr.w   #1,D3
            subq.w  #1,D3
.L24:
            move.b  (A0)+,D0
            move.w  TABLE2(PC,D0.w*2),(A1)+
            dbra    D3,.L24
            rts
TABLE2:
            dc.w    0,$0003,$000C,$000F,$0030,$0033,$003C,$003F
            dc.w    $00C0,$00C3,$00CC,$00CF,$00F0,$00F3,$00FC,$00FF
            dc.w    $0300,$0303,$030C,$030F,$0330,$0333,$033C,$033F
            dc.w    $03C0,$03C3,$03CC,$03CF,$03F0,$03F3,$03FC,$03FF
            dc.w    $0C00,$0C03,$0C0C,$0C0F,$0C30,$0C33,$0C3C,$0C3F
            dc.w    $0CC0,$0CC3,$0CCC,$0CCF,$0CF0,$0CF3,$0CFC,$0CFF
            dc.w    $0F00,$0F03,$0F0C,$0F0F,$0F30,$0F33,$0F3C,$0F3F
            dc.w    $0FC0,$0FC3,$0FCC,$0FCF,$0FF0,$0FF3,$0FFC,$0FFF
            dc.w    $3000,$3003,$300C,$300F
            dc.b    '00030<0?0'
            dc.b    $C0,$30,$C3,$30,$CC,$30,$CF,$30,$F0,$30,$F3,$30,$FC,$30,$FF,$33
            dc.b    $00,$33,$03,$33,$0C,$33,$0F
            dc.b    '30333<3?3'
            dc.b    $C0,$33,$C3,$33,$CC,$33,$CF,$33,$F0,$33,$F3,$33,$FC,$33,$FF,$3C
            dc.b    $00,$3C,$03,$3C,$0C,$3C,$0F
            dc.b    '<0<3<<<?<'
            dc.b    $C0,$3C,$C3,$3C,$CC,$3C,$CF,$3C,$F0,$3C,$F3,$3C,$FC,$3C,$FF,$3F
            dc.b    $00,$3F,$03,$3F,$0C,$3F,$0F
            dc.b    '?0?3?<???'
            dc.b    $C0,$3F,$C3,$3F,$CC,$3F,$CF,$3F,$F0,$3F,$F3,$3F,$FC,$3F,$FF,$C0
            dc.b    $00,$C0,$03,$C0,$0C,$C0,$0F,$C0,$30,$C0,$33,$C0,$3C,$C0,$3F,$C0
            dc.b    $C0,$C0,$C3,$C0,$CC,$C0,$CF,$C0,$F0,$C0,$F3,$C0,$FC,$C0,$FF,$C3
            dc.b    $00,$C3,$03,$C3,$0C,$C3,$0F,$C3,$30,$C3,$33,$C3,$3C,$C3,$3F,$C3
            dc.b    $C0,$C3,$C3,$C3,$CC,$C3,$CF,$C3,$F0,$C3,$F3,$C3,$FC,$C3,$FF,$CC
            dc.b    $00,$CC,$03,$CC,$0C,$CC,$0F,$CC,$30,$CC,$33,$CC,$3C,$CC,$3F,$CC
            dc.b    $C0,$CC,$C3,$CC,$CC,$CC,$CF,$CC,$F0,$CC,$F3,$CC,$FC,$CC,$FF,$CF
            dc.b    $00,$CF,$03,$CF,$0C,$CF,$0F,$CF,$30,$CF,$33,$CF,$3C,$CF,$3F,$CF
            dc.b    $C0,$CF,$C3,$CF,$CC,$CF,$CF,$CF,$F0,$CF,$F3,$CF,$FC,$CF,$FF,$F0
            dc.b    $00,$F0,$03,$F0,$0C,$F0,$0F,$F0,$30,$F0,$33,$F0,$3C,$F0,$3F,$F0
            dc.b    $C0,$F0,$C3,$F0,$CC,$F0,$CF,$F0,$F0,$F0,$F3,$F0,$FC,$F0,$FF,$F3
            dc.b    $00,$F3,$03,$F3,$0C,$F3,$0F,$F3,$30,$F3,$33,$F3,$3C,$F3,$3F,$F3
            dc.b    $C0,$F3,$C3,$F3,$CC,$F3,$CF,$F3,$F0,$F3,$F3,$F3,$FC,$F3,$FF,$FC
            dc.b    $00,$FC,$03,$FC,$0C,$FC,$0F,$FC,$30,$FC,$33,$FC,$3C,$FC,$3F,$FC
            dc.b    $C0,$FC,$C3,$FC,$CC,$FC,$CF,$FC,$F0,$FC,$F3,$FC,$FC,$FC,$FF,$FF
            dc.b    $00,$FF,$03,$FF,$0C,$FF,$0F,$FF,$30,$FF,$33,$FF,$3C,$FF,$3F,$FF
            dc.b    $C0,$FF,$C3,$FF,$CC,$FF,$CF,$FF,$F0,$FF,$F3,$FF,$FC,$FF,$FF
            ds.b    10
.L1:
            dc.w    $1018,$3200,$3400,$EA0A,$12FB,$201A,$E409,$0241
            dc.w    $000F,$12FB,$1018,$0240,$0007,$12FB,$0020,$B3CA
            dc.w    $65DE,$4E75,$0003,$1C1F,$E0E3,$FCFF,$0001,$0E0F
            dc.w    $7071,$7E7F,$8081,$8E8F,$F0F1,$FEFF,$0007,$383F
            dc.w    $C0C7,$F8FF
            ds.b    12
.L2:
            suba.l  A1,A2
            move.l  A2,D1
            lsr.l   #2,D1
            subq.w  #1,D1
.L6:
            move.b  (A0)+,D0
            move.l  TABLE4(PC,D0.w*4),(A1)+
            dbra    D1,.L6
            rts
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L4
.L3:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L5
.L4:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.l  TABLE4(PC,D0.w*4),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L5:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L3
            rts
TABLE4:
            ds.b    7
            dc.b    $0F,$00,$00,$00,$F0,$00,$00,$00,$FF,$00,$00,$0F,$00,$00,$00,$0F
            dc.b    $0F,$00,$00,$0F,$F0,$00,$00,$0F,$FF,$00,$00,$F0,$00,$00,$00,$F0
            dc.b    $0F,$00,$00,$F0,$F0,$00,$00,$F0,$FF,$00,$00,$FF,$00,$00,$00,$FF
            dc.b    $0F,$00,$00,$FF,$F0,$00,$00,$FF,$FF,$00,$0F,$00,$00,$00,$0F,$00
            dc.b    $0F,$00,$0F,$00,$F0,$00,$0F,$00,$FF,$00,$0F,$0F,$00,$00,$0F,$0F
            dc.b    $0F,$00,$0F,$0F,$F0,$00,$0F,$0F,$FF,$00,$0F,$F0,$00,$00,$0F,$F0
            dc.b    $0F,$00,$0F,$F0,$F0,$00,$0F,$F0,$FF,$00,$0F,$FF,$00,$00,$0F,$FF
            dc.b    $0F,$00,$0F,$FF,$F0,$00,$0F,$FF,$FF,$00,$F0,$00,$00,$00,$F0,$00
            dc.b    $0F,$00,$F0,$00,$F0,$00,$F0,$00,$FF,$00,$F0,$0F,$00,$00,$F0,$0F
            dc.b    $0F,$00,$F0,$0F,$F0,$00,$F0,$0F,$FF,$00,$F0,$F0,$00,$00,$F0,$F0
            dc.b    $0F,$00,$F0,$F0,$F0,$00,$F0,$F0,$FF,$00,$F0,$FF,$00,$00,$F0,$FF
            dc.b    $0F,$00,$F0,$FF,$F0,$00,$F0,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $0F,$00,$FF,$00,$F0,$00,$FF,$00,$FF,$00,$FF,$0F,$00,$00,$FF,$0F
            dc.b    $0F,$00,$FF,$0F,$F0,$00,$FF,$0F,$FF,$00,$FF,$F0,$00,$00,$FF,$F0
            dc.b    $0F,$00,$FF,$F0,$F0,$00,$FF,$F0,$FF,$00,$FF,$FF,$00,$00,$FF,$FF
            dc.b    $0F,$00,$FF,$FF,$F0,$00,$FF,$FF,$FF,$0F,$00,$00,$00,$0F,$00,$00
            dc.b    $0F,$0F,$00,$00,$F0,$0F,$00,$00,$FF,$0F,$00,$0F,$00,$0F,$00,$0F
            dc.b    $0F,$0F,$00,$0F,$F0,$0F,$00,$0F,$FF,$0F,$00,$F0,$00,$0F,$00,$F0
            dc.b    $0F,$0F,$00,$F0,$F0,$0F,$00,$F0,$FF,$0F,$00,$FF,$00,$0F,$00,$FF
            dc.b    $0F,$0F,$00,$FF,$F0,$0F,$00,$FF,$FF,$0F,$0F,$00,$00,$0F,$0F,$00
            dc.b    $0F,$0F,$0F,$00,$F0,$0F,$0F,$00,$FF,$0F,$0F,$0F,$00,$0F,$0F,$0F
            dc.b    $0F,$0F,$0F,$0F,$F0,$0F,$0F,$0F,$FF,$0F,$0F,$F0,$00,$0F,$0F,$F0
            dc.b    $0F,$0F,$0F,$F0,$F0,$0F,$0F,$F0,$FF,$0F,$0F,$FF,$00,$0F,$0F,$FF
            dc.b    $0F,$0F,$0F,$FF,$F0,$0F,$0F,$FF,$FF,$0F,$F0,$00,$00,$0F,$F0,$00
            dc.b    $0F,$0F,$F0,$00,$F0,$0F,$F0,$00,$FF,$0F,$F0,$0F,$00,$0F,$F0,$0F
            dc.b    $0F,$0F,$F0,$0F,$F0,$0F,$F0,$0F,$FF,$0F,$F0,$F0,$00,$0F,$F0,$F0
            dc.b    $0F,$0F,$F0,$F0,$F0,$0F,$F0,$F0,$FF,$0F,$F0,$FF,$00,$0F,$F0,$FF
            dc.b    $0F,$0F,$F0,$FF,$F0,$0F,$F0,$FF,$FF,$0F,$FF,$00,$00,$0F,$FF,$00
            dc.b    $0F,$0F,$FF,$00,$F0,$0F,$FF,$00,$FF,$0F,$FF,$0F,$00,$0F,$FF,$0F
            dc.b    $0F,$0F,$FF,$0F,$F0,$0F,$FF,$0F,$FF,$0F,$FF,$F0,$00,$0F,$FF,$F0
            dc.b    $0F,$0F,$FF,$F0,$F0,$0F,$FF,$F0,$FF,$0F,$FF,$FF,$00,$0F,$FF,$FF
            dc.b    $0F,$0F,$FF,$FF,$F0,$0F,$FF,$FF,$FF,$F0,$00,$00,$00,$F0,$00,$00
            dc.b    $0F,$F0,$00,$00,$F0,$F0,$00,$00,$FF,$F0,$00,$0F,$00,$F0,$00,$0F
            dc.b    $0F,$F0,$00,$0F,$F0,$F0,$00,$0F,$FF,$F0,$00,$F0,$00,$F0,$00,$F0
            dc.b    $0F,$F0,$00,$F0,$F0,$F0,$00,$F0,$FF,$F0,$00,$FF,$00,$F0,$00,$FF
            dc.b    $0F,$F0,$00,$FF,$F0,$F0,$00,$FF,$FF,$F0,$0F,$00,$00,$F0,$0F,$00
            dc.b    $0F,$F0,$0F,$00,$F0,$F0,$0F,$00,$FF,$F0,$0F,$0F,$00,$F0,$0F,$0F
            dc.b    $0F,$F0,$0F,$0F,$F0,$F0,$0F,$0F,$FF,$F0,$0F,$F0,$00,$F0,$0F,$F0
            dc.b    $0F,$F0,$0F,$F0,$F0,$F0,$0F,$F0,$FF,$F0,$0F,$FF,$00,$F0,$0F,$FF
            dc.b    $0F,$F0,$0F,$FF,$F0,$F0,$0F,$FF,$FF,$F0,$F0,$00,$00,$F0,$F0,$00
            dc.b    $0F,$F0,$F0,$00,$F0,$F0,$F0,$00,$FF,$F0,$F0,$0F,$00,$F0,$F0,$0F
            dc.b    $0F,$F0,$F0,$0F,$F0,$F0,$F0,$0F,$FF,$F0,$F0,$F0,$00,$F0,$F0,$F0
            dc.b    $0F,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$FF,$F0,$F0,$FF,$00,$F0,$F0,$FF
            dc.b    $0F,$F0,$F0,$FF,$F0,$F0,$F0,$FF,$FF,$F0,$FF,$00,$00,$F0,$FF,$00
            dc.b    $0F,$F0,$FF,$00,$F0,$F0,$FF,$00,$FF,$F0,$FF,$0F,$00,$F0,$FF,$0F
            dc.b    $0F,$F0,$FF,$0F,$F0,$F0,$FF,$0F,$FF,$F0,$FF,$F0,$00,$F0,$FF,$F0
            dc.b    $0F,$F0,$FF,$F0,$F0,$F0,$FF,$F0,$FF,$F0,$FF,$FF,$00,$F0,$FF,$FF
            dc.b    $0F,$F0,$FF,$FF,$F0,$F0,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $0F,$FF,$00,$00,$F0,$FF,$00,$00,$FF,$FF,$00,$0F,$00,$FF,$00,$0F
            dc.b    $0F,$FF,$00,$0F,$F0,$FF,$00,$0F,$FF,$FF,$00,$F0,$00,$FF,$00,$F0
            dc.b    $0F,$FF,$00,$F0,$F0,$FF,$00,$F0,$FF,$FF,$00,$FF,$00,$FF,$00,$FF
            dc.b    $0F,$FF,$00,$FF,$F0,$FF,$00,$FF,$FF,$FF,$0F,$00,$00,$FF,$0F,$00
            dc.b    $0F,$FF,$0F,$00,$F0,$FF,$0F,$00,$FF,$FF,$0F,$0F,$00,$FF,$0F,$0F
            dc.b    $0F,$FF,$0F,$0F,$F0,$FF,$0F,$0F,$FF,$FF,$0F,$F0,$00,$FF,$0F,$F0
            dc.b    $0F,$FF,$0F,$F0,$F0,$FF,$0F,$F0,$FF,$FF,$0F,$FF,$00,$FF,$0F,$FF
            dc.b    $0F,$FF,$0F,$FF,$F0,$FF,$0F,$FF,$FF,$FF,$F0,$00,$00,$FF,$F0,$00
            dc.b    $0F,$FF,$F0,$00,$F0,$FF,$F0,$00,$FF,$FF,$F0,$0F,$00,$FF,$F0,$0F
            dc.b    $0F,$FF,$F0,$0F,$F0,$FF,$F0,$0F,$FF,$FF,$F0,$F0,$00,$FF,$F0,$F0
            dc.b    $0F,$FF,$F0,$F0,$F0,$FF,$F0,$F0,$FF,$FF,$F0,$FF,$00,$FF,$F0,$FF
            dc.b    $0F,$FF,$F0,$FF,$F0,$FF,$F0,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $0F,$FF,$FF,$00,$F0,$FF,$FF,$00,$FF,$FF,$FF,$0F,$00,$FF,$FF,$0F
            dc.b    $0F,$FF,$FF,$0F,$F0,$FF,$FF,$0F,$FF,$FF,$FF,$F0,$00,$FF,$FF,$F0
            dc.b    $0F,$FF,$FF,$F0,$F0,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF
            dc.b    $0F,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF
            ds.b    8
.L1:
            dc.w    $1018,$3200,$0241,$00E0,$E809,$32FB,$1020,$3200
            dc.w    $0241,$003C,$E209,$32FB,$1024,$3200,$0241,$0007
            dc.w    $D241,$32FB,$1038,$B3CA,$65D6,$4E75,0,$000F
            dc.w    $03F0,$03FF,$FC00,$FC0F,$FFF0,$FFFF,0,$0003
            dc.w    $00FC,$00FF,$3F00,$3F03,$3FFC,$3FFF,$C000,$C003
            dc.w    $C0FC,$C0FF,$FF00,$FF03,$FFFC,$FFFF,0,$003F
            dc.w    $0FC0,$0FFF,$F000,$F03F,$FFC0,$FFFF
            ds.b    4
            move.w  #8,(A1)+
            move.w  #4,(A1)+
            move.w  #$3F,(A1)+
            movea.l A0,A2
            moveq   #7,D0
.L5:
            move.b  (A2),D1
            ror.b   #4,D1
            cmp.b   (A2)+,D1
            dbne    D0,.L5
            bne.b   .L6
            clr.w   (-6,A1)
            bra.b   .L7
.L6:
            movea.l (A1),A1
.L8:
            moveq   #0,D1
            move.b  (A0)+,D1
            eor.b   D7,D1
            rol.b   D2,D1
            move.w  D1,D5
            andi.w  #$F0,D1
            lsr.w   #2,D1
            move.l  TABLE8(PC,D1.w),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
            move.l  D1,(A1)+
            andi.w  #$F,D5
            move.l  TABLE8(PC,D5.w*4),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
            move.l  D1,(A1)+
            dbra    D6,.L8
            rts
.L7:
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L4
.L3:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            andi.w  #$F0,D0
            lsr.w   #2,D0
            move.l  TABLE8(PC,D0.w),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L4:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L2
            rts
TABLE8:
            ds.b    7
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
            ds.b    12
.L1:
            move.b  (A0)+,D0
            move.w  D0,D1
            andi.w  #$F0,D1
            lsr.w   #2,D1
            move.l  TABLE8(PC,D1.w),(A1)+
            andi.w  #$F,D0
            move.l  TABLE8(PC,D0.w*4),(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            rts
            ds.b    4
.L2:
            moveq   #$F,D2
            move.l  (A0)+,D0
.L6:
            add.l   D0,D0
            subx.l  D1,D1
            add.l   D0,D0
            subx.w  D1,D1
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            dbcc    D2,.L6
            bcs.b   .L2
            rts
            ds.b    8
            move.w  #$10,(A1)+
            move.w  #$C,(A1)+
            move.w  #$7F,(A1)+
            movea.l A0,A2
            moveq   #7,D0
.L8:
            move.b  (A2)+,D1
            move.b  D1,D5
            ror.b   #1,D1
            eor.b   D1,D5
            bne.b   .L7
            dbra    D0,.L8
            bset    #$1F,D6
            clr.w   (-6,A1)
.L7:
            movea.l (A1),A1
.L3:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            moveq   #7,D1
.L4:
            add.b   D0,D0
            bcs.b   FORE16
            move.w  D4,(A1)+
            tst.l   D6
            bpl.b   .L5
            move.w  D4,($1E,A1)
            subq.w  #3,D1
.L5:
            dbra    D1,.L4
            dbra    D6,.L3
            rts
FORE16:
            move.w  D3,(A1)+
            tst.l   D6
            bpl.b   .L1
            move.w  D3,($1E,A1)
            subq.w  #3,D1
.L1:
            dbra    D1,TABLE8.L4
            dbra    D6,TABLE8.L3
            rts
            move.w  #$20,(A1)+
            move.w  #$1C,(A1)+
            move.w  #$FF,(A1)+
            move.l  A1,D5
            movea.l (A1),A1
            movea.l A0,A2
            moveq   #7,D0
.L2:
            move.b  (A2)+,D1
            eor.b   D7,D1
            bne.b   .L3
            move.l  D4,(A1)+
            move.l  D4,($1C,A1)
            bra.b   .L4
.L3:
            addq.b  #1,D1
            bne.b   .L5
            move.l  D3,(A1)+
            move.l  D3,($1C,A1)
.L4:
            dbra    D0,.L2
            movea.l D5,A1
            clr.w   (-6,A1)
            rts
.L5:
            movea.l D5,A1
            movea.l (A1),A1
.L6:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            moveq   #7,D1
.L7:
            add.b   D0,D0
            bcs.b   .L8
            move.l  D4,(A1)+
            dbra    D1,.L7
            dbra    D6,.L6
            rts
.L8:
            move.l  D3,(A1)+
            dbra    D1,.L7
            dbra    D6,.L6
            rts
sub_40839140:
            moveq   #$1F,D2
            move.l  (A0)+,D0
.L1:
            add.l   D0,D0
            subx.l  D1,D1
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            dbcc    D2,.L1
            bcs.b   sub_40839140
            rts
            ds.b    12
            move.w  #$7FFF,D2
            move.l  A2,D3
            sub.l   A1,D3
            ror.l   #6,D3
            bra.b   .L3
.L5:
            moveq   #$1F,D4
            move.l  (A0)+,D0
            not.l   D0
.L4:
            add.l   D0,D0
            subx.w  D1,D1
            and.w   D2,D1
            move.w  D1,(A1)+
            dbra    D4,.L4
.L3:
            dbra    D3,.L5
            clr.w   D3
            rol.l   #5,D3
            move.l  (A0)+,D0
            not.l   D0
            bra.b   .L6
.L7:
            add.l   D0,D0
            subx.w  D1,D1
            and.w   D2,D1
            move.w  D1,(A1)+
.L6:
            dbra    D3,.L7
            rts
            ds.b    6
            move.l  Lo3Bytes,D2
            move.l  A2,D3
            sub.l   A1,D3
            ror.l   #7,D3
            bra.b   .L8
.L10:
            moveq   #$1F,D4
            move.l  (A0)+,D0
            not.l   D0
.L9:
            add.l   D0,D0
            subx.l  D1,D1
            and.l   D2,D1
            move.l  D1,(A1)+
            dbra    D4,.L9
.L8:
            dbra    D3,.L10
            clr.w   D3
            rol.l   #5,D3
            move.l  (A0)+,D0
            not.l   D0
            bra.b   .L11
.L12:
            add.l   D0,D0
            subx.l  D1,D1
            and.l   D2,D1
            move.l  D1,(A1)+
.L11:
            dbra    D3,.L12
            rts
            ds.b    6
.L2:
            lsr.w   #3,D4
            subq.w  #1,D4
            move.w  #$8000,D0
.L15:
            add.w   D0,D0
            bne.b   .L13
            move.w  (A0)+,D0
            addx.w  D0,D0
.L13:
            scs     D1
            move.w  D4,D2
.L14:
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            dbhi    D2,.L14
            bls.b   .L15
            rts
SHRINK:
            clr.w   D1
            move.w  #$8000,D0
            move.w  D0,D2
            move.w  D4,D3
            lsr.w   #1,D3
.L1:
            add.w   D0,D0
            bcc.b   .L3
            bne.b   .L2
            move.w  (A0)+,D0
            addx.w  D0,D0
            bcc.b   .L3
.L2:
            or.w    D2,D1
.L3:
            add.w   D4,D3
            bcc.b   .L1
            ror.w   #1,D2
            bcc.b   .L1
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   .L1
            rts
            ds.b    4
.L4:
            clr.w   D1
            move.w  #$8000,D0
            move.w  D0,D2
            move.w  D4,D3
            lsr.w   #1,D3
.L5:
            add.w   D0,D0
            bcc.b   WHITE1.L1
            bne.b   .L7
            move.w  (A0)+,D0
            addx.w  D0,D0
            bcc.b   WHITE1.L1
            bra.b   .L7
.L6:
            add.w   D4,D3
            bcs.b   .L5
.L7:
            or.w    D2,D1
            ror.w   #1,D2
            bcc.b   .L6
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   .L6
            rts
WHITE1:
            add.w   D4,D3
            bcs.b   SHRINK.L5
.L1:
            ror.w   #1,D2
            bcc.b   WHITE1
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   WHITE1
            rts
AverageH32:
            movem.l D5/A5,-(SP)
            move.w  D4,D2
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,(A1)+
            cmpa.l  A2,A1
            bcc.b   .L6
.L2:
            add.w   D2,D3
            bcs.b   .L1
            move.l  (A0)+,D0
            move.b  D0,D5
            movea.w D5,A5
            lsr.w   #8,D0
            movea.w D0,A4
            swap    D0
            move.b  D0,D5
            movea.w D5,A3
            moveq   #1,D4
.L3:
            move.l  (A0)+,D0
            addq.w  #1,D4
            move.b  D0,D5
            adda.w  D5,A5
            lsr.w   #8,D0
            adda.w  D0,A4
            swap    D0
            move.b  D0,D5
            adda.w  D5,A3
            add.w   D2,D3
            bcc.b   .L3
            cmpi.w  #2,D4
            blt.b   .L5
            beq.b   .L4
            moveq   #0,D1
            move.l  A3,D0
            divu.w  D4,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A4,D0
            divu.w  D4,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A5,D0
            divu.w  D4,D0
            move.b  D0,D1
            bra.b   .L5
.L4:
            move.l  A3,D1
            lsl.w   #7,D1
            move.l  A4,D0
            lsr.w   #1,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A5,D0
            lsr.w   #1,D0
            move.b  D0,D1
.L5:
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L2
.L6:
            movem.l (SP)+,D5/A5
            rts
PIXSHRNK:
            cmpi.w  #$20,D5
            beq.w   AverageH32
            movem.l D6-D7,-(SP)
            movea.w D4,A3
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D2
            moveq   #0,D6
            moveq   #$1F,D7
            ext.l   D5
            move.l  (A0)+,D0
            moveq   #0,D1
.L1:
            suba.l  A4,A4
.L2:
            bfextu  D0{D2:D5},D4
            cmp.l   A4,D4
            bls.b   .L3
            bfins   D4,D1{D6:D5}
            movea.l D4,A4
.L3:
            add.l   D5,D2
            and.w   D7,D2
            bne.b   .L4
            move.l  (A0)+,D0
.L4:
            add.w   A3,D3
            bcc.b   .L2
            add.l   D5,D6
            and.w   D7,D6
            bne.b   .L1
            move.l  D1,(A1)+
            moveq   #0,D1
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7
            rts
            dc.w    0
PIXSTR:
            movem.l D6-D7,-(SP)
            movea.w D4,A3
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D2
            moveq   #0,D6
            moveq   #$1F,D7
            ext.l   D5
.L1:
            move.l  (A0)+,D0
.L2:
            bfextu  D0{D2:D5},D4
.L3:
            bfins   D4,D1{D6:D5}
            add.l   D5,D6
            and.w   D7,D6
            bne.b   .L4
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcc.b   .L5
.L4:
            add.w   A3,D3
            bcc.b   .L3
            add.l   D5,D2
            and.w   D7,D2
            bne.b   .L2
            bra.b   .L1
.L5:
            movem.l (SP)+,D6-D7
            rts
            ds.b    6
SCALEINDEXEDTOINDEXED:
            movem.l D6-D7,-(SP)
            moveq   #0,D1
            moveq   #0,D2
            moveq   #$1F,D7
            bra.b   .L2
.L1:
            add.w   D3,D1
            and.w   D7,D1
            bne.b   .L3
.L2:
            move.l  (A0)+,D5
.L3:
            bfextu  D5{D1:D3},D0
            move.l  (0,A4,D0.w*4),D0
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            and.w   D7,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7
            rts
            ds.b    14
DITHER32TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D2
            move.l  D2,D5
            move.l  D2,D6
            move.l  D2,D7
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D2
.L1:
            sub.w   D4,D2
.L2:
            subq.w  #6,A4
            move.l  -(A0),D0
            bsr.b   sub_40839432
            asr.w   #1,D5
            move.w  D5,(A4)
            asr.w   #1,D6
            move.w  D6,(2,A4)
            asr.w   #1,D7
            move.w  D7,(4,A4)
            sub.w   D4,D2
            bge.b   .L2
            moveq   #$20,D2
            move.l  D1,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.l  (A0)+,D0
            bsr.b   sub_40839432
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L3
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
sub_40839432:
            add.w   (A4),D5
            add.w   (2,A4),D6
            add.w   (4,A4),D7
            moveq   #0,D3
            move.b  D0,D3
            add.w   D3,D7
            lsr.w   #8,D0
            add.w   D0,D6
            swap    D0
            move.b  D0,D3
            add.w   D3,D5
            swap    D4
            move.w  (-$29E,A6),D0
            tst.w   D5
            spl     D3
            cmp.w   D3,D5
            sgt     D4
            and.b   D5,D3
            or.b    D4,D3
            moveq   #0,D5
            move.b  D3,D5
            lsl.l   D0,D3
            tst.w   D6
            spl     D3
            cmpi.w  #$FF,D6
            sgt     D4
            and.b   D6,D3
            or.b    D4,D3
            moveq   #0,D6
            move.b  D3,D6
            lsl.l   D0,D3
            tst.w   D7
            spl     D3
            cmpi.w  #$FF,D7
            sgt     D4
            and.b   D7,D3
            or.b    D4,D3
            neg.w   D0
            addq.w  #8,D0
            moveq   #0,D7
            move.b  D3,D7
            lsr.l   D0,D3
            swap    D4
            moveq   #0,D0
            movea.l (-$28C,A6),A3
            move.b  (0,A3,D3.l),D0
            bfins   D0,D1{D2:D4}
            movea.l (-$29C,A6),A3
            lea     ($A,A3,D0.l*8),A5
            move.l  (A5)+,D0
            moveq   #0,D3
            lsr.l   #8,D0
            move.b  D0,D3
            sub.w   D3,D6
            swap    D0
            move.b  D0,D3
            sub.w   D3,D5
            move.w  (A5)+,D0
            lsr.w   #8,D0
            move.b  D0,D3
            sub.w   D3,D7
            rts
            ds.b    14
DITHER16TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D2
            move.l  D2,D5
            move.l  D2,D6
            move.l  D2,D7
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D2
.L1:
            sub.w   D4,D2
.L2:
            subq.w  #6,A4
            move.w  -(A0),D0
            bsr.b   DitherCore_Stretch
            asr.w   #1,D5
            move.w  D5,(A4)
            asr.w   #1,D6
            move.w  D6,(2,A4)
            asr.w   #1,D7
            move.w  D7,(4,A4)
            sub.w   D4,D2
            bge.b   .L2
            moveq   #$20,D2
            move.l  D1,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.w  (A0)+,D0
            bsr.b   DitherCore_Stretch
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L3
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
DitherCore_Stretch:
            add.w   (A4),D5
            add.w   (2,A4),D6
            add.w   (4,A4),D7
            moveq   #0,D3
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D7
            lsr.l   #5,D0
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D6
            lsr.l   #5,D0
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D5
            swap    D4
            move.w  (-$29E,A6),D0
            tst.w   D5
            spl     D3
            cmp.w   D3,D5
            sgt     D4
            and.b   D5,D3
            or.b    D4,D3
            moveq   #0,D5
            move.b  D3,D5
            lsl.l   D0,D3
            tst.w   D6
            spl     D3
            cmpi.w  #$FF,D6
            sgt     D4
            and.b   D6,D3
            or.b    D4,D3
            moveq   #0,D6
            move.b  D3,D6
            lsl.l   D0,D3
            tst.w   D7
            spl     D3
            cmpi.w  #$FF,D7
            sgt     D4
            and.b   D7,D3
            or.b    D4,D3
            neg.w   D0
            addq.w  #8,D0
            moveq   #0,D7
            move.b  D3,D7
            lsr.l   D0,D3
            swap    D4
            moveq   #0,D0
            movea.l (-$28C,A6),A3
            move.b  (0,A3,D3.l),D0
            bfins   D0,D1{D2:D4}
            movea.l (-$29C,A6),A3
            lea     ($A,A3,D0.l*8),A5
            move.l  (A5)+,D0
            moveq   #0,D3
            lsr.l   #8,D0
            move.b  D0,D3
            sub.w   D3,D6
            swap    D0
            move.b  D0,D3
            sub.w   D3,D5
            move.w  (A5),D0
            lsr.w   #8,D0
            move.b  D0,D3
            sub.w   D3,D7
            rts
            ds.b    6
DITHER32TOGRAY:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$290,A6),A3
            lea     ($100,A3),A5
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D0
            move.l  D5,D1
            move.l  D5,D2
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D5
.L1:
            sub.w   D4,D5
.L2:
            subq.w  #2,A4
            move.l  -(A0),D3
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)
            sub.w   D4,D5
            bge.b   .L2
            moveq   #$20,D5
            move.l  D6,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.l  (A0)+,D3
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L3
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    14
DITHER16TOGRAY:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D3
            movea.l (-$290,A6),A3
            lea     ($100,A3),A5
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D0
            move.l  D5,D1
            move.l  D5,D2
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D5
.L1:
            sub.w   D4,D5
.L2:
            subq.w  #2,A4
            move.w  -(A0),D3
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)
            sub.w   D4,D5
            bge.b   .L2
            moveq   #$20,D5
            move.l  D6,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.w  (A0)+,D3
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L3
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
SCALE32TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D2
            movea.l (-$28C,A6),A3
            move.w  (-$29E,A6),D1
            moveq   #8,D3
            move.w  D3,D7
            sub.w   D1,D7
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmpa.l  D5,A5
            beq.b   .L3
.L2:
            movea.l D5,A5
            moveq   #0,D0
            move.w  D5,D3
            swap    D5
            move.b  D5,D0
            lsl.l   D1,D0
            lsr.l   #8,D3
            move.b  D3,D0
            lsl.l   D1,D0
            swap    D5
            move.b  D5,D0
            lsr.l   D7,D0
            move.b  (0,A3,D0.w),D0
.L3:
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    14
SCALE32TOGRAY:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l (-$290,A6),A3
            move.l  (A0)+,D3
            bra.b   .L2
.L1:
            move.l  (A0)+,D3
            cmpa.l  D3,A5
            beq.b   .L3
.L2:
            movea.l D3,A5
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            move.b  (0,A3,D3.w),D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    14
SCALE32TOBITMAP:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.l  (A0)+,D3
            bra.b   .L2
.L1:
            move.l  (A0)+,D3
            cmpa.l  D3,A5
            beq.b   .L3
.L2:
            movea.l D3,A5
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            tst.b   D3
            spl     D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            dc.w    0
SCALE16TOGRAY:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l (-$290,A6),A3
            move.w  (A0)+,D3
            bra.b   .L2
.L1:
            move.w  (A0)+,D3
            cmpa.w  D3,A5
            beq.b   .L3
.L2:
            movea.w D3,A5
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            move.b  (0,A3,D3.w),D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    8
SCALE16TOBITMAP:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.w  (A0)+,D3
            bra.b   .L2
.L1:
            move.w  (A0)+,D3
            cmpa.w  D3,A5
            beq.b   .L3
.L2:
            movea.w D3,A5
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            tst.b   D3
            spl     D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    12
SEARCH32TOINDEXED:
            movem.l D6-D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            moveq   #0,D7
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.l  (A4)+,D5
            move.b  D5,(4,SP)
            move.b  D5,(5,SP)
            ror.l   #8,D5
            move.b  D5,(2,SP)
            move.b  D5,(3,SP)
            ror.l   #8,D5
            move.b  D5,(SP)
            move.b  D5,(1,SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            movea.l (-$28C,A6),A0
            move.w  (-$29E,A6),D1
            bfextu  D5{8:D1},D0
            lsl.l   D1,D0
            bfextu  D5{16:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{24:D1},D3
            or.l    D3,D0
            move.b  (0,A0,D0.l),D3
.L4:
            bfins   D3,D6{D7:D4}
            add.w   D4,D7
            andi.w  #$1F,D7
            bne.b   .L1
            move.l  D6,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D6-D7/A3-A5
            rts
            dc.w    0
SCALE32TO16:
            move.l  A2,D2
            sub.l   A1,D2
            lsr.l   #2,D2
            subq.w  #1,D2
.L1:
            move.l  (A0)+,D0
            ror.l   #8,D0
            lsr.w   #3,D0
            ror.l   #5,D0
            lsr.w   #3,D0
            ror.l   #6,D0
            move.l  (A0)+,D1
            ror.l   #8,D1
            lsr.w   #3,D1
            ror.l   #5,D1
            lsr.w   #3,D1
            ror.l   #6,D1
            swap    D1
            move.w  D1,D0
            move.l  D0,(A1)+
            dbra    D2,.L1
            rts
            ds.b    4
SEARCH32TO16:
            movem.l D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            bra.b   sub_40839AB0.L3
sub_40839AB0:
            move.l  (A4)+,D5
            move.b  D5,(8,SP)
            ror.l   #8,D5
            move.b  D5,(6,SP)
            ror.l   #8,D5
            move.b  D5,(4,SP)
            move.l  (-$294,A6),(-$298,A6)
.L1:
            move.l  (-$298,A6),D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (6,SP)
            pea     ($10,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L1
            move.l  ($A,SP),D0
            rts
.L2:
            move.l  (-4,A4),D0
            ror.l   #8,D0
            lsr.w   #3,D0
            ror.l   #5,D0
            lsr.w   #3,D0
            ror.l   #6,D0
            swap    D0
            rts
.L3:
            bsr.b   sub_40839AB0
            move.w  D0,D7
            swap    D7
            bsr.b   sub_40839AB0
            move.w  D0,D7
            move.l  D7,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L3
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D7/A3-A5
            rts
            ds.b    12
SCALE16TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D2
            movea.l (-$28C,A6),A3
            move.w  (-$29E,A6),D1
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmpa.l  D5,A5
            beq.b   .L3
.L2:
            movea.l D5,A5
            bfextu  D5{1:D1},D0
            lsl.l   D1,D0
            bfextu  D5{6:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{11:D1},D3
            or.l    D3,D0
            move.b  (0,A3,D0.w),D0
            bfextu  D5{17:D1},D7
            lsl.l   D1,D7
            bfextu  D5{22:D1},D3
            or.l    D3,D7
            lsl.l   D1,D7
            bfextu  D5{27:D1},D3
            or.l    D3,D7
            move.b  (0,A3,D7.w),D7
.L3:
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            bfins   D7,D6{D2:D4}
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    8
SEARCH16TOINDEXED:
            movem.l D6-D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            moveq   #0,D7
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.w  (A4)+,D5
            lsl.l   #3,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(4,SP)
            lsr.l   #5,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(2,SP)
            lsr.l   #5,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            movea.l (-$28C,A6),A0
            move.w  (-$29E,A6),D1
            bfextu  D5{17:D1},D0
            lsl.l   D1,D0
            bfextu  D5{22:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{27:D1},D3
            or.l    D3,D0
            move.b  (0,A0,D0.w),D0
.L4:
            bfins   D0,D6{D7:D4}
            add.w   D4,D7
            andi.w  #$1F,D7
            bne.w   .L1
            move.l  D6,(A3)+
            cmpa.l  A2,A3
            bcs.w   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D6-D7/A3-A5
            rts
            ds.b    8
SCALE16TO32:
            move.l  A2,D4
            sub.l   A1,D4
            lsr.l   #3,D4
            subq.w  #1,D4
            bmi.b   sub_40839CF0
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmp.l   D0,D5
            beq.b   .L3
.L2:
            move.l  D5,D0
            moveq   #0,D3
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.b  D5,D1
            lsl.b   #3,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsr.l   #5,D3
            swap    D5
            moveq   #0,D2
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            lsl.b   #3,D5
            move.b  D5,D2
            lsl.l   #5,D2
            move.b  D5,D2
            lsr.l   #5,D2
.L3:
            move.l  D2,(A1)+
            move.l  D3,(A1)+
            dbra    D4,.L1
            cmpa.l  A1,A2
            bne.b   sub_40839CF0
            rts
sub_40839CF0:
            move.w  (A0)+,D5
            moveq   #0,D2
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            lsl.b   #3,D5
            move.b  D5,D2
            lsl.l   #5,D2
            move.b  D5,D2
            lsr.l   #5,D2
            move.l  D2,(A1)
            rts
            ds.b    6
SEARCH16TO32:
            movem.l D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.w  (A4)+,D5
            move.w  D5,D0
            lsl.l   #3,D0
            move.b  D0,(4,SP)
            clr.b   D0
            lsr.l   #5,D0
            move.b  D0,(2,SP)
            clr.b   D0
            lsr.l   #5,D0
            move.b  D0,(SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            moveq   #0,D3
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.b  D5,D1
            lsl.b   #3,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsr.l   #5,D3
.L4:
            move.l  D3,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D7/A3-A5
            rts
            ds.b    14

            include "QuickDraw/ScaleBlt.s"

ANDY:
CB1TO8CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   ANDY
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #0,D7
            movea.l (-$200,A6),A4
            movea.l (-8,A6),A2
.L3:
            move.l  (-$234,A6),D0
            asr.l   #3,D0
            moveq   #$F,D3
            moveq   #-1,D6
            lea     TABLE8,A1
            movea.l (-$1F8,A6),A3
            move.l  (-$230,A6),D5
            add.l   D0,D5
            bfextu  (A3){D5:16},D4
            addq.l  #4,D5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            move.w  (-$10,A6),D2
            cmpi.w  #4,D2
            ble.w   .L10
            move.w  D2,D0
            andi.w  #3,D0
            bne.b   .L4
            subq.w  #1,D2
.L4:
            lsr.w   #2,D2
            subq.w  #1,D2
            tst.b   D7
            bne.w   .L31
            st      D7
.L5:
            bfextu  (A3){D5:16},D4
            addq.w  #2,A3
            beq.w   .L16
            rol.w   #4,D4
            lea     .L6,A5
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.w   .L14
            move.l  D0,(A4)+
.L6:
            lea     .L7,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L7:
            lea     .L8,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L8:
            lea     .L9,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L9:
            dbra    D2,.L5
.L10:
            bfextu  (A3){D5:16},D4
            lea     .L12,A5
            move.w  (-$10,A6),D2
            beq.w   .L28
            andi.w  #3,D2
            bne.b   .L12
            moveq   #3,D2
.L11:
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L15
            move.l  D0,(A4)+
.L12:
            dbra    D2,.L11
            bra.b   .L28
.L13:
            addq.l  #4,A4
            RTS5
.L14:
            moveq   #0,D7
.L15:
            tst.l   D1
            beq.b   .L13
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            RTS5
.L16:
            move.l  (A2)+,D1
            beq.b   .L20
            cmp.l   D6,D1
            bne.b   .L24
            clr.l   (A4)+
.L17:
            move.l  (A2)+,D1
            beq.b   .L21
            cmp.l   D6,D1
            bne.b   .L25
            clr.l   (A4)+
.L18:
            move.l  (A2)+,D1
            beq.b   .L22
            cmp.l   D6,D1
            bne.b   .L26
            clr.l   (A4)+
.L19:
            move.l  (A2)+,D1
            beq.b   .L23
            cmp.l   D6,D1
            bne.b   .L27
            clr.l   (A4)+
            bra.b   .L9
.L20:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L17
.L21:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L18
.L22:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L19
.L23:
            moveq   #0,D7
            addq.w  #4,A4
            bra.w   .L9
.L24:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L17
.L25:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L18
.L26:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L19
.L27:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.w   .L9
.L28:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L29
            cmp.w   (-$46,A6),D0
            blt.b   .L29
            cmp.w   (-$5C,A6),D0
            bge.b   .L29
            cmp.w   (-$5E,A6),D0
            blt.b   .L29
            cmp.w   (-$2C,A6),D0
            bge.b   .L29
            cmp.w   (-$2E,A6),D0
            bge.b   .L30
.L29:
            moveq   #0,D7
            movea.l (-$1C,A6),A0
            jsr     (A0)
.L30:
            movea.l (-8,A6),A2
            movea.l (-$200,A6),A4
            bra.w   .L3
.L31:
            move.w  D2,D7
.L32:
            bfextu  (A3){D5:16},D4
            addq.w  #2,A3
            beq.b   .L34
            cmp.w   D4,D6
            beq.b   .L35
            swap    D4
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
.L33:
            dbra    D2,.L32
            addq.w  #1,D7
            lsl.w   #4,D7
            adda.w  D7,A2
            bra.w   .L10
.L34:
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            bra.b   .L33
.L35:
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            bra.b   .L33
.L36:
            addq.w  #4,A3
            addq.w  #4,A4
            bra.w   CB8TO8CLIP.L4
CB8TO8CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   CB8TO8CLIP
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #-1,D6
            moveq   #0,D4
            moveq   #0,D3
            movea.l (-$23C,A6),A5
            suba.l  A1,A1
            move.l  (A5),D0
            move.b  D0,D7
            lsl.l   #8,D7
            move.b  D0,D7
            move.w  D7,D0
            swap    D7
            move.w  D0,D7
.L3:
            movea.l (-8,A6),A2
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-$23C,A6),A5
            move.l  (-$234,A6),D0
            asr.l   #3,D0
            move.l  (-$230,A6),D1
            asr.l   #3,D1
            add.l   D1,D0
            adda.l  D0,A3
            move.w  (-$10,A6),D2
            moveq   #0,D5
            move.l  (A2)+,D1
            beq.w   CB1TO8CLIP.L36
            move.l  (A3)+,D0
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L9
.L4:
            tst.w   D4
            bne.w   .L32
            moveq   #-1,D4
            moveq   #0,D3
            move.l  (A2)+,D1
            beq.w   .L12
            cmp.l   D6,D1
            bne.w   .L13
            bra.b   .L6
.L5:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.w   .L13
.L6:
            addq.w  #1,D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L7
            move.l  D7,D0
            bra.b   .L8
.L7:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L8:
            move.l  D0,(A4)+
            dbra    D2,.L5
.L9:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L10
            cmp.w   (-$46,A6),D0
            blt.b   .L10
            cmp.w   (-$5C,A6),D0
            bge.b   .L10
            cmp.w   (-$5E,A6),D0
            blt.b   .L10
            cmp.w   (-$2C,A6),D0
            bge.b   .L10
            cmp.w   (-$2E,A6),D0
            bge.w   .L3
.L10:
            moveq   #0,D4
            move.l  A1,-(SP)
            movea.l (-$1C,A6),A0
            jsr     (A0)
            movea.l (SP)+,A1
            bra.w   .L3
            addq.w  #4,A4
            bra.b   .L9
.L11:
            move.l  (A2)+,D1
            bne.b   .L13
.L12:
            subq.w  #1,D3
            addq.w  #4,A3
            addq.w  #4,A4
            dbra    D2,.L11
            bra.b   .L9
.L13:
            swap    D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L14
            move.l  D7,D0
            bra.b   .L15
.L14:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L15:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L20
            move.l  (A2)+,D1
            beq.b   .L22
            cmp.l   D6,D1
            bne.b   .L23
            bra.b   .L17
.L16:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L23
.L17:
            addq.w  #1,D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L18
            move.l  D7,D0
            bra.b   .L19
.L18:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L19:
            move.l  D0,(A4)+
            dbra    D2,.L16
.L20:
            swap    D3
            bra.w   .L9
.L21:
            move.l  (A2)+,D1
            bne.b   .L23
.L22:
            subq.w  #1,D3
            addq.w  #4,A3
            addq.w  #4,A4
            dbra    D2,.L21
            bra.b   .L20
.L23:
            swap    D3
            tst.l   D1
            beq.b   .L28
            bra.b   .L25
.L24:
            move.l  (A2)+,D1
            beq.b   .L28
.L25:
            cmp.l   D6,D1
            bne.b   .L29
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L26
            move.l  D7,D0
            bra.b   .L27
.L26:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L27:
            move.l  D0,(A4)+
            dbra    D2,.L24
            bra.w   .L9
.L28:
            addq.w  #4,A4
            addq.w  #4,A3
            dbra    D2,.L24
            bra.w   .L9
.L29:
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L30
            move.l  D7,D0
            bra.b   .L31
.L30:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L31:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,.L24
            bra.w   .L9
.L32:
            tst.w   D3
            bpl.b   sub_4083ABA4.L1
            beq.w   sub_4083ABA4.L6
            move.w  D3,D0
            neg.w   D0
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A3
            adda.w  D0,A4
            add.w   D3,D2
            bmi.w   .L9
.L33:
            lea     sub_4083ABA4,A0
            bra.w   sub_4083ABA4.L8
sub_4083ABA4:
            move.l  D3,D0
            bpl.b   .L2
            beq.b   .L7
            swap    D0
            neg.w   D0
            sub.w   D0,D2
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A3
            adda.w  D0,A4
            tst.w   D2
            bmi.w   CB8TO8CLIP.L9
            bra.w   CB8TO8CLIP.L24
.L1:
            move.w  D3,D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            lea     CB8TO8CLIP.L33,A0
            bra.b   .L5
.L2:
            swap    D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            lea     CB8TO8CLIP.L24,A0
            bra.b   .L5
.L3:
            move.l  (A3)+,D1
            cmpa.l  D1,A1
            beq.b   .L4
            movea.l D1,A1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.l  D1,D7
.L4:
            move.l  D7,(A4)+
.L5:
            dbra    D0,.L3
            tst.w   D2
            bmi.w   CB8TO8CLIP.L9
            jmp     (A0)
.L6:
            lea     CB8TO8CLIP.L33,A0
            bra.b   .L8
.L7:
            lea     CB8TO8CLIP.L24,A0
.L8:
            move.l  (A2)+,D1
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L9
            move.l  D7,D0
            bra.b   .L10
.L9:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L10:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.w   CB8TO8CLIP.L9
            jmp     (A0)
.L11:
            lea     ($20,A3),A3
            addq.w  #4,A4
            bra.b   CB8TO1CLIP.L4
CB8TO1CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   CB8TO1CLIP
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #-1,D6
            moveq   #0,D4
            moveq   #0,D3
            suba.l  A1,A1
            subq.l  #1,A1
            moveq   #-1,D7
.L3:
            movea.l (-8,A6),A2
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-$23C,A6),A5
            move.l  (-$234,A6),D0
            move.l  (-$230,A6),D1
            asr.l   #3,D1
            add.l   D1,D0
            adda.l  D0,A3
            move.w  (-$10,A6),D2
            moveq   #0,D5
            move.l  (A2)+,D1
            beq.b   sub_4083ABA4.L11
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L7
.L4:
            tst.w   D4
            bne.w   .L22
            moveq   #-1,D4
            moveq   #0,D3
            move.l  (A2)+,D1
            beq.b   .L10
            cmp.l   D6,D1
            bne.w   .L11
            bra.b   .L6
.L5:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L11
.L6:
            addq.w  #1,D3
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L5
.L7:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L8
            cmp.w   (-$46,A6),D0
            blt.b   .L8
            cmp.w   (-$5C,A6),D0
            bge.b   .L8
            cmp.w   (-$5E,A6),D0
            blt.b   .L8
            cmp.w   (-$2C,A6),D0
            bge.b   .L8
            cmp.w   (-$2E,A6),D0
            bge.w   .L3
.L8:
            moveq   #0,D4
            move.l  A1,-(SP)
            movea.l (-$1C,A6),A0
            jsr     (A0)
            movea.l (SP)+,A1
            bra.w   .L3
            addq.w  #4,A4
            bra.b   .L7
.L9:
            move.l  (A2)+,D1
            bne.b   .L11
.L10:
            subq.w  #1,D3
            lea     ($20,A3),A3
            addq.w  #4,A4
            dbra    D2,.L9
            bra.b   .L7
.L11:
            swap    D3
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L14
            move.l  (A2)+,D1
            beq.b   .L16
            cmp.l   D6,D1
            bne.b   .L17
            bra.b   .L13
.L12:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L17
.L13:
            addq.w  #1,D3
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L12
.L14:
            swap    D3
            bra.w   .L7
.L15:
            move.l  (A2)+,D1
            bne.b   .L17
.L16:
            subq.w  #1,D3
            lea     ($20,A3),A3
            addq.w  #4,A4
            dbra    D2,.L15
            bra.b   .L14
.L17:
            swap    D3
            tst.l   D1
            beq.b   .L20
            bra.b   .L19
.L18:
            move.l  (A2)+,D1
            beq.b   .L20
.L19:
            cmp.l   D6,D1
            bne.b   .L21
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L18
            bra.w   .L7
.L20:
            addq.w  #4,A4
            lea     ($20,A3),A3
            dbra    D2,.L18
            bra.w   .L7
.L21:
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,.L18
            bra.w   .L7
.L22:
            tst.w   D3
            bpl.b   sub_4083AE2C.L1
            beq.b   sub_4083AE2C.L5
            move.w  D3,D0
            neg.w   D0
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A4
            lsl.w   #3,D0
            adda.w  D0,A3
            add.w   D3,D2
            bmi.w   .L7
.L23:
            lea     sub_4083AE2C,A0
            bra.b   sub_4083AE2C.L7
sub_4083AE2C:
            move.l  D3,D0
            bpl.b   .L2
            beq.b   .L6
            swap    D0
            neg.w   D0
            sub.w   D0,D2
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A4
            lsl.w   #3,D0
            adda.w  D0,A3
            tst.w   D2
            bmi.w   CB8TO1CLIP.L7
            bra.b   CB8TO1CLIP.L18
.L1:
            move.w  D3,D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            move.w  D0,D1
            lea     CB8TO1CLIP.L23,A0
            bra.b   .L4
.L2:
            swap    D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            move.w  D0,D1
            lea     CB8TO1CLIP.L18,A0
            bra.b   .L4
.L3:
            bsr.b   Map8to1
            move.l  D0,(A4)+
.L4:
            dbra    D1,.L3
            tst.w   D2
            bmi.w   CB8TO1CLIP.L7
            jmp     (A0)
.L5:
            lea     CB8TO1CLIP.L23,A0
            bra.b   .L7
.L6:
            lea     CB8TO1CLIP.L18,A0
.L7:
            move.l  (A2)+,D1
            bsr.b   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.w   CB8TO1CLIP.L7
            jmp     (A0)
Map8to1:
            move.l  (A5),D0
            beq.b   .L1
            moveq   #$F,D0
.L1:
            moveq   #7,D7
            suba.l  A1,A1
.L2:
            move.l  (A3)+,D6
            cmp.l   A1,D6
            beq.b   .L3
            movea.l D6,A1
            swap    D6
            move.b  D6,D5
            lsr.w   #8,D6
            move.b  (3,A5,D6.w*4),D6
            lsr.w   #1,D6
            addx.l  D0,D0
            move.b  (3,A5,D5.w*4),D5
            lsr.w   #1,D5
            addx.l  D0,D0
            swap    D6
            move.b  D6,D5
            lsr.w   #8,D6
            move.b  (3,A5,D6.w*4),D6
            lsr.w   #1,D6
            addx.l  D0,D0
            move.b  (3,A5,D5.w*4),D5
            lsr.w   #1,D5
            addx.l  D0,D0
            dbra    D7,.L2
            moveq   #-1,D6
            rts
.L3:
            moveq   #$F,D5
            and.b   D0,D5
            lsl.l   #4,D0
            or.b    D5,D0
            dbra    D7,.L2
            moveq   #-1,D6
            rts
            ds.b    12
