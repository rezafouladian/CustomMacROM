SCALEBLT:
            move.l  SP,(-$258,A6)
            move.l  D0,(-$208,A6)
            move.l  D1,(-$20C,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$640,D0
            move.l  D0,(-$84,A6)
            bpl.b   .L1
            jsr     ([$1C5C.w])
.L1:
            move.w  (-$14A,A6),D0
            beq.w   .L10
            cmpi.w  #$10,D0
            bne.w   .L26
            clr.l   (-$2A4,A6)
            move.w  D4,D5
            lsl.w   #3,D5
            cmpi.w  #4,D3
            beq.b   .L2
            bset    #2,D5
.L2:
            movea.l ([TheGDevice.w]),A2
            cmpi.w  #$10,(-$D6,A6)
            beq.w   .L9
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            movea.l ([6.w,A2]),A0
            cmp.l   (A0),D1
            beq.b   .L4
            move.l  ($2A,A1),-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            beq.b   .L3
            addq.w  #4,SP
            bra.w   .L26
.L3:
            movea.l ([TheGDevice.w]),A2
            movea.l ([6.w,A2]),A0
.L4:
            addq.w  #6,A0
            move.l  A0,(-$28C,A6)
            subq.w  #6,A0
            move.w  (4,A0),(-$29E,A6)
            movea.l ([$16.w,A2]),A1
            move.l  ([$2A.w,A1]),(-$29C,A6)
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            tst.w   (2,A1)
            bpl.b   .L5
            addq.w  #6,A1
            move.l  A1,(-$290,A6)
            addq.w  #2,D5
            moveq   #$28,D0
            cmp.l   (A0),D0
            beq.b   .L9
.L5:
            tst.b   (-$A5,A6)
            beq.b   .L9
            addq.w  #1,D5
            moveq   #0,D0
            move.w  (-$206,A6),D0
            lsl.l   D4,D0
            addi.l  #$80,D0
            lsr.l   D4,D0
            btst    #1,D5
            bne.b   .L6
            move.w  D0,D1
            add.w   D0,D0
            add.w   D1,D0
.L6:
            lsr.w   #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L7
            jsr     ([$1C5C.w])
.L7:
            clr.l   -(SP)
.L8:
            clr.l   -(SP)
            dbra    D0,.L8
            move.l  SP,(-$2A4,A6)
            clr.b   (-$2A9,A6)
.L9:
            move.w  D5,D0
            lsr.w   #3,D0
            lea     ($1CC8.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #7,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
            bra.w   .L17
.L10:
            move.w  D4,D5
            lsl.w   #2,D5
            or.w    D3,D5
            move.w  (-$148,A6),D1
            moveq   #1,D0
            lsl.w   D1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L11
            jsr     ([$1C5C.w])
.L11:
            moveq   #0,D7
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L12
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L12
            moveq   #1,D7
            pea     ONEBITPROC
            jsr     ([$16E8.w])
.L12:
            movea.l (-$1D0,A6),A5
            move.l  A4,-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.w  (-$148,A6),D1
            cmp.w   (-$D4,A6),D1
            bne.b   .L15
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.w  D1,A0
.L13:
            cmp.l   -(A0),D0
            dbne    D0,.L13
            bne.b   .L15
            tst.w   D7
            beq.b   .L14
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L14:
            lea     (-$F4,A6),A5
            move.l  (-$1C8,A6),D7
            moveq   #0,D0
            bra.w   .L27
.L15:
            move.l  SP,(-$23C,A6)
            lea     (-$F4,A6),A5
            tst.w   D7
            beq.b   .L16
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L16:
            move.w  D5,D0
            lsr.w   #2,D0
            lea     ($1CB0.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #3,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
.L17:
            moveq   #$A,D0
            movea.l ($A,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.w   .L18
            move.l  ($A,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.b   .L18
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($A,A6)
.L18:
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L19
            move.l  ($E,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.w   .L19
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($E,A6)
.L19:
            movea.l ($12,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L20
            move.l  ($12,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.b   .L20
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($12,A6)
.L20:
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            asr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            moveq   #0,D0
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.l  D0,D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.l   #5,D0
            addq.l  #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L21
            jsr     ([$1C5C.w])
.L21:
            clr.l   -(SP)
            clr.l   -(SP)
.L22:
            clr.l   -(SP)
            dbra    D0,.L22
            move.l  SP,(-8,A6)
            moveq   #-1,D0
            move.l  D0,(-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            tst.l   (-$2A4,A6)
            beq.b   .L23
            jsr     ([$1C50.w])
            move.l  A0,(-$2C0,A6)
.L23:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$1C2,A6),D3
            movea.l ($24,A6),A2
            movea.l ($1C,A6),A3
            move.l  (-$1BC,A6),D2
            move.w  (-$72,A6),D1
            sub.w   (2,A3),D1
            add.w   (2,A2),D1
            sub.w   (-$160,A6),D1
            ext.l   D1
            lsl.l   D3,D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$230,A6)
            move.w  (-$74,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            sub.w   (-$162,A6),D0
            muls.w  D2,D0
            add.l   (-$168,A6),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1F8,A6)
            move.w  (-$76,A6),D4
            move.l  (-$7C,A6),D2
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            moveq   #$1F,D6
            and.l   D1,D6
            neg.l   D6
            move.l  D6,(-$234,A6)
            move.w  (-$74,A6),D0
            move.w  D0,(-4,A6)
            sub.w   (6,A5),D0
            muls.w  D2,D0
            add.l   (A5),D0
            asr.l   #5,D1
            lsl.l   #2,D1
            add.l   D1,D0
            move.l  D0,(-$200,A6)
            movea.l (-$200,A6),A5
            movea.l (-$1F8,A6),A4
            move.w  #4,(-$78,A6)
            move.w  (-$148,A6),D4
            move.w  (-$D4,A6),D5
.L24:
            move.w  (-$70,A6),D2
            sub.w   (-4,A6),D2
            ble.b   .L26
            move.w  D2,D3
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            cmp.w   D3,D1
            ble.b   .L25
            move.w  D3,D1
.L25:
            jsr     ([-$18.w,A6])
            movea.l (-$2BC,A6),A3
            movea.l (-$228,A6),A2
            jmp     (A2)
.L26:
            moveq   #1,D0
.L27:
            movea.l (-$258,A6),SP
            rts
            move.w  (-$1C2,A6),D7
            movea.l (-$23C,A6),A3
            lea     .L29,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L29
.L28:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            subq.w  #1,D1
            ble.b   .L24
.L29:
            move.l  (-$230,A6),D6
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L30:
            move.l  (A1)+,D3
            bmi.b   .L28
            adda.w  D3,A2
            lsr.w   #2,D3
            lsl.w   D7,D3
            add.w   D3,D6
            move.w  D6,D3
            lsr.w   #5,D3
            lea     (0,A0,D3.w*4),A0
            swap    D3
.L31:
            move.l  (A0)+,D5
.L32:
            bfextu  D5{D6:D4},D0
            move.l  (0,A3,D0.w*4),(A2)+
            add.w   D4,D6
            andi.w  #$1F,D6
            dbeq    D3,.L32
            dbne    D3,.L31
            beq.b   .L30
            subq.w  #4,A0
            bra.b   .L30
            move.w  (-$29E,A6),D6
            moveq   #8,D7
            sub.w   D6,D7
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            movea.l (-$28C,A6),A3
            lea     .L34,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L34
.L33:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            swap    D1
            subq.w  #1,D1
            ble.w   .L24
.L34:
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            swap    D1
.L35:
            move.w  #3,D1
            move.l  (A1)+,D3
            bmi.b   .L33
            adda.w  D3,A2
            lea     (0,A0,D3.w*4),A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L40
            move.l  (A0)+,D5
            bra.b   .L38
.L36:
            move.w  #3,D1
.L37:
            move.l  (A0)+,D5
            cmp.l   D5,D4
            beq.b   .L39
.L38:
            moveq   #0,D2
            move.w  D5,D4
            swap    D5
            move.b  D5,D2
            lsl.l   D6,D2
            lsr.l   #8,D4
            move.b  D4,D2
            lsl.l   D6,D2
            swap    D5
            move.b  D5,D2
            lsr.l   D7,D2
            move.l  D5,D4
            move.b  (0,A3,D2.w),D2
.L39:
            lsl.l   #8,D0
            move.b  D2,D0
            dbra    D1,.L37
            move.l  (A1)+,D5
            and.l   D5,D0
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D0
            move.l  D0,(A2)+
            dbra    D3,.L36
            bra.b   .L35
.L40:
            move.l  (A0)+,D5
            bra.b   .L43
.L41:
            move.w  #3,D1
.L42:
            move.l  (A0)+,D5
            cmp.l   D5,D4
            beq.b   .L44
.L43:
            moveq   #0,D2
            move.w  D5,D4
            swap    D5
            move.b  D5,D2
            lsl.l   D6,D2
            lsr.l   #8,D4
            move.b  D4,D2
            lsl.l   D6,D2
            swap    D5
            move.b  D5,D2
            lsr.l   D7,D2
            move.l  D5,D4
            move.b  (0,A3,D2.w),D2
.L44:
            lsl.l   #8,D0
            move.b  D2,D0
            dbra    D1,.L42
            move.l  D0,(A2)+
            dbra    D3,.L41
            bra.w   .L35
            moveq   #0,D4
            move.l  D4,D6
            move.l  D4,D7
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            movea.l (-$290,A6),A3
            lea     .L46,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L46
.L45:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            swap    D1
            subq.w  #1,D1
            ble.w   .L24
.L46:
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            swap    D1
.L47:
            move.w  #3,D1
            move.l  (A1)+,D3
            bmi.b   .L45
            adda.w  D3,A2
            lsl.w   #2,D3
            adda.w  D3,A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L52
            move.l  (A0)+,D5
            bra.b   .L50
.L48:
            move.w  #3,D1
.L49:
            move.l  (A0)+,D5
            cmp.l   D5,D2
            beq.b   .L51
.L50:
            move.l  D5,D2
            move.b  D5,D6
            lsr.l   #8,D5
            move.b  D5,D4
            lsr.w   #8,D5
            move.b  D5,D7
            add.w   D4,D5
            add.w   D6,D5
            add.w   D6,D5
            lsr.w   #2,D5
            add.w   D7,D5
            add.w   D4,D5
            add.w   D4,D5
            lsr.w   #2,D5
            move.b  (0,A3,D5.w),D7
.L51:
            lsl.l   #8,D0
            move.b  D7,D0
            dbra    D1,.L49
            move.l  (A1)+,D5
            and.l   D5,D0
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D0
            move.l  D0,(A2)+
            dbra    D3,.L48
            bra.b   .L47
.L52:
            move.l  (A0)+,D5
            bra.b   .L55
.L53:
            move.w  #3,D1
.L54:
            move.l  (A0)+,D5
            cmp.l   D5,D2
            beq.b   .L56
.L55:
            move.l  D5,D2
            move.b  D5,D6
            lsr.l   #8,D5
            move.b  D5,D4
            lsr.w   #8,D5
            move.b  D5,D7
            add.w   D4,D5
            add.w   D6,D5
            add.w   D6,D5
            lsr.w   #2,D5
            add.w   D7,D5
            add.w   D4,D5
            add.w   D4,D5
            lsr.w   #2,D5
            move.b  (0,A3,D5.w),D7
.L56:
            lsl.l   #8,D0
            move.b  D7,D0
            dbra    D1,.L54
            move.l  D0,(A2)+
            dbra    D3,.L53
            bra.w   .L47
.L57:
            move.w  (-$70,A6),D2
            sub.w   (-4,A6),D2
            ble.w   .L26
            move.w  D2,D3
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            cmp.w   D3,D1
            ble.b   .L58
            move.w  D3,D1
.L58:
            move.l  (-$C,A6),D3
            move.w  #$FFFC,(-$78,A6)
            move.l  (-$2C0,A6),(-$C,A6)
            jsr     ([-$18.w,A6])
            move.l  D3,(-$C,A6)
            move.w  #4,(-$78,A6)
            jsr     ([-$18.w,A6])
            movea.l (-$2BC,A6),A3
            movea.l (-$228,A6),A2
            jmp     (A2)
            subq.w  #4,SP
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            move.l  A4,(-$1F8,A6)
            movea.l (-$28C,A6),A3
            movea.l (-$29C,A6),A5
            moveq   #0,D4
            lea     sub_4083A430.L1,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L57
sub_4083A430:
            move.l  (-$7C,A6),D2
            add.l   D2,(-$200,A6)
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            addq.w  #1,(-4,A6)
            subq.w  #1,(SP)
            move.w  (SP),D1
            ble.w   SCALEBLT.L57
.L1:
            movea.l (-$1F8,A6),A0
            movea.l (-$200,A6),A2
            movea.l (-$C,A6),A1
            move.w  D1,(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D6
            move.l  D5,D7
            move.w  (-$29E,A6),D7
            swap    D7
            not.b   (-$2A9,A6)
            bne.b   .L2
            movea.l (-$2C0,A6),A1
.L2:
            move.l  (A1)+,D3
            bmi.b   sub_4083A430
            adda.w  D3,A2
            add.w   D3,D3
            adda.w  D3,A4
            add.w   D3,D3
            adda.w  D3,A0
            adda.w  D3,A4
            swap    D3
            lsl.l   #2,D3
            lsr.w   #2,D3
            tst.b   (-$2A9,A6)
            bne.b   .L5
.L3:
            bsr.b   DitherCore8
            suba.w  #$30,A4
            suba.w  #$20,A0
            btst    #$10,D3
            beq.b   .L4
            move.l  (A1)+,D0
            and.l   D0,D2
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D2
.L4:
            move.l  D2,(A2)
            subq.w  #4,A2
            dbra    D3,.L3
            bra.b   .L2
.L5:
            bsr.b   DitherCore8
            btst    #$10,D3
            beq.b   .L6
            move.l  (A1)+,D0
            and.l   D0,D2
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D2
.L6:
            move.l  D2,(A2)+
            dbra    D3,.L5
            bra.b   .L2
DitherCore8:
            moveq   #3,D1
.L1:
            swap    D1
            move.l  (A0)+,D0
            move.b  D0,D4
            add.w   (4,A4),D7
            add.w   D4,D7
            spl     D4
            cmp.w   D4,D7
            sgt     D1
            and.w   D4,D7
            or.w    D1,D7
            lsr.w   #8,D0
            add.w   (2,A4),D6
            add.w   D0,D6
            spl     D4
            cmp.w   D4,D6
            sgt     D1
            and.w   D4,D6
            or.w    D1,D6
            swap    D0
            move.b  D0,D4
            add.w   (A4),D5
            add.w   D4,D5
            spl     D4
            cmp.w   D4,D5
            sgt     D1
            and.w   D4,D5
            or.w    D1,D5
            move.l  D7,D0
            swap    D0
            move.b  D5,D4
            lsl.l   D0,D4
            move.b  D6,D4
            lsl.l   D0,D4
            move.b  D7,D4
            neg.w   D0
            addq.w  #8,D0
            lsr.l   D0,D4
            move.b  (0,A3,D4.l),D1
            lsl.l   #8,D2
            move.b  D1,D2
            move.l  ($A,A5,D1.w*8),D0
            moveq   #0,D4
            lsr.l   #8,D0
            move.b  D0,D4
            sub.w   D4,D6
            swap    D0
            sub.w   D0,D5
            move.b  ($E,A5,D1.w*8),D4
            sub.w   D4,D7
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            swap    D1
            dbra    D1,.L1
            rts
            dc.w    $6000,$FC40
SCDIRTAB1:
            dc.w    $FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC
            dc.w    $FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC
SCDIRTAB2:
            dc.w    $FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC
            dc.w    $FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC
SCDIRTAB4:
            dc.w    $FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC
            dc.w    $FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC
SCDIRTAB8:
            dc.w    $FFFF,$FF9C,$FFFF,$FF9C,$FFFF,$FF9C,$FFFF,$FF9C
            dc.w    $FFFF,$FC50,$FFFF,$FE56,$FFFF,$FD2A,$FFFF,$FD2A
SCDIRTAB16:
            dc.w    $FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C
            dc.w    $FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C
SCDIRTAB32:
            dc.w    $FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C
            dc.w    $FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C
SCINDTAB1:
            dc.w    $FFFF,$FF3C,$FFFF,$FF3C,$FFFF,$FF3C,$FFFF,$FF3C
SCINDTAB2:
            dc.w    $FFFF,$FF2C,$FFFF,$FF2C,$FFFF,$FF2C,$FFFF,$FF2C
SCINDTAB4:
            dc.w    $FFFF,$FF1C,$FFFF,$FF1C,$FFFF,$FF1C,$FFFF,$FF1C
SCINDTAB8:
            dc.w    $FFFF,$FF0C,$FFFF,$FF0C,$FFFF,$FF0C,$FFFF,$FF0C
SCINDTAB16:
            dc.w    $FFFF,$FEFC,$FFFF,$FEFC,$FFFF,$FEFC,$FFFF,$FEFC
SCINDTAB32:
            dc.w    $FFFF,$FB36,$FFFF,$FB36,$FFFF,$FB36,$FFFF,$FB36
            ds.b    12
