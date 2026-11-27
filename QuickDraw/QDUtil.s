BitNot:
            movea.l (SP)+,A0
            not.l   (SP)
            move.l  (SP)+,(SP)
            jmp     (A0)
            ds.b    8
BitAnd:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            and.l   (SP)+,D0
            bra.b   BitShift.L2
BitXOr:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  (SP)+,D1
            eor.l   D1,D0
            bra.b   BitShift.L2
BitOr:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            or.l    (SP)+,D0
            bra.b   BitShift.L2
BitShift:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            bpl.b   .L1
            neg.w   D1
            move.l  (SP)+,D0
            lsr.l   D1,D0
            bra.b   .L2
.L1:
            move.l  (SP)+,D0
            lsl.l   D1,D0
.L2:
            move.l  D0,(SP)
            jmp     (A0)
BitTst:
            bsr.b   SHARE
            movea.l (SP)+,A1
            btst    D0,(0,A1,D1.l)
            sne     (SP)
            neg.b   (SP)
            jmp     (A0)
BitSet:
            bsr.b   SHARE
            movea.l (SP)+,A1
            bset    D0,(0,A1,D1.l)
            jmp     (A0)
BitClr:
            bsr.b   SHARE
            movea.l (SP)+,A1
            bclr    D0,(0,A1,D1.l)
            jmp     (A0)
SHARE:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            move.w  D1,D0
            asr.l   #3,D1
            not.w   D0
            jmp     (A1)
Random:
            movea.l (A5),A0
            move.w  #$41A7,D0
            move.w  D0,D2
            mulu.w  (-$7C,A0),D0
            move.l  D0,D1
            clr.w   D1
            swap    D1
            mulu.w  (-$7E,A0),D2
            add.l   D1,D2
            move.l  D2,D1
            add.l   D1,D1
            clr.w   D1
            swap    D1
            andi.l  #$FFFF,D0
            subi.l  #$7FFFFFFF,D0
            andi.l  #$7FFF,D2
            swap    D2
            add.l   D1,D2
            add.l   D2,D0
            bpl.b   .L1
            addi.l  #$7FFFFFFF,D0
.L1:
            move.l  D0,(-$7E,A0)
            cmpi.w  #$8000,D0
            bne.b   .L2
            clr.w   D0
.L2:
            move.w  D0,(4,SP)
            rts
            ds.b    14
ForeColor:
            moveq   #$50,D0
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   PortLong
            move.w  D0,-(SP)
            move.l  (6,SP),D0
            movea.l (2,A0),A0
            movea.l (A0),A0
            lsr.l   #1,D0
            bcs.b   .L2
            ori.w   #$E0,D0
.L2:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            pea     (2,A0,D0.w*8)
            cmpi.w  #$50,(4,SP)
            bne.b   .L3
            jsr     ([$1650.w])
            bra.b   .L4
.L3:
            jsr     ([$1654.w])
.L4:
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            addq.w  #4,SP
            jmp     (A1)
BackColor:
            moveq   #$54,D0
            bra.b   ForeColor.L1
PortLong:
            movea.l (SP)+,A1
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (SP)+,(0,A0,D0.w)
            jmp     (A1)
ColorBit:
            moveq   #$58,D0
PortWord:
            movea.l (SP)+,A1
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (SP)+,(0,A0,D0.w)
            jmp     (A1)
            ds.b    6
GetMaskTab:
            lea     MaskTab,A0
            rts
LeftMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab.L1(PC,D0.w),D0
            rts
RightMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab(PC,D0.w),D0
            rts
BitMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab.L2(PC,D0.w),D0
            rts
MaskTab:
            dc.w    0,$8000,$C000,$E000,$F000,$F800,$FC00,$FE00
            dc.w    $FF00,$FF80,$FFC0,$FFE0,$FFF0,$FFF8,$FFFC,$FFFE
.L1:
            dc.w    $FFFF,$7FFF,$3FFF,$1FFF,$0FFF,$07FF,$03FF,$01FF
            dc.w    $00FF,$007F,$003F,$001F,$000F,$0007,$0003,$0001
.L2:
            dc.w    $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
            dc.w    $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001
            ds.b    6
arithMode:
            dc.w    $0003,$0201,$0103,$0201
            ds.b    8
ColorMap:
            movem.l D3-D7/A2-A3,-(SP)
            moveq   #-1,D4
            moveq   #0,D5
            movea.l (A5),A2
            movea.l (A2),A2
            move.w  ($58,A2),D2
            move.w  (-$98,A6),D3
            move.l  ($50,A2),D6
            move.l  ($54,A2),D7
            clr.w   (-$104,A6)
            move.w  D3,D1
            andi.w  #$FFF7,D3
            eor.w   D3,D1
            cmpi.w  #2,D3
            bne.b   .L1
            bset    #7,HiliteMode
            bne.b   .L1
            move.w  #$32,D3
.L1:
            btst    #5,D3
            beq.b   .L2
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L2
            andi.w  #7,D3
            move.b  arithMode(PC,D3.w),D3
.L2:
            or.w    D1,D3
            move.w  D3,(-$98,A6)
            move.w  D3,D0
            bclr    #3,D0
            cmpi.w  #$32,D0
            beq.w   .L17
            cmpi.w  #2,D0
            beq.w   .L17
            cmpi.w  #6,D0
            beq.w   .L17
            tst.b   D1
            bne.b   .L3
            tst.b   (-$101,A6)
            bne.w   .L17
            bra.b   .L4
.L3:
            tst.b   (-$A6,A6)
            beq.b   .L4
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.w   .L17
.L4:
            tst.w   (6,A2)
            bpl.b   .L6
            lea     ($24,A2),A0
            move.l  (A0)+,D0
            or.w    (A0)+,D0
            tst.l   D0
            sne     (-$103,A6)
            move.w  (A0)+,D1
            and.w   (A0)+,D1
            and.w   (A0)+,D1
            lsr.w   #8,D1
            addq.b  #1,D1
            sne     (-$104,A6)
            cmpi.w  #2,(-$D4,A6)
            bgt.b   .L7
            cmp.l   D6,D7
            bne.b   .L7
            lea     ($24,A2),A0
            lea     ($2A,A2),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L5
            cmpm.w  (A0)+,(A1)+
            beq.b   .L7
.L5:
            tst.w   D2
            bne.b   .L7
            lea     ($24,A2),A0
            subq.w  #6,SP
            movea.l SP,A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            move.l  SP,-(SP)
            jsr     ([$16D4.w])
            subq.w  #4,SP
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D6
            addq.w  #6,SP
            bra.b   .L7
.L6:
            tst.w   D2
            bmi.w   .L17
            bne.b   .L9
            cmpi.w  #1,(-$D4,A6)
            beq.b   .L9
            cmpi.w  #$21,D6
            sne     (-$103,A6)
            cmpi.w  #$1E,D7
            sne     (-$104,A6)
            move.l  D7,D0
            bsr.w   mapToColor
            move.l  D0,D7
            move.l  D6,D0
            bsr.w   mapToColor
            move.l  D0,D6
.L7:
            move.w  (-$D4,A6),D0
            move.l  D6,D4
            move.l  D7,D5
            moveq   #$20,D1
.L8:
            sub.w   D0,D1
            ble.b   .L17
            lsl.l   D0,D4
            lsl.l   D0,D5
            or.l    D6,D4
            or.l    D7,D5
            bra.b   .L8
.L9:
            moveq   #3,D0
            and.w   D3,D0
            beq.b   .L12
            cmpi.w  #2,D0
            beq.b   .L17
            bgt.b   .L11
            move.l  D6,D1
.L10:
            btst    D2,D1
            bne.b   .L17
            eori.w  #2,D3
            bra.b   .L16
.L11:
            move.l  D7,D1
            not.l   D1
            bra.b   .L10
.L12:
            move.l  D6,D0
            move.l  D7,D1
            btst    D2,D0
            beq.b   .L14
            btst    D2,D1
            beq.b   .L17
            moveq   #8,D3
.L13:
            movea.l (A5),A0
            lea     (-$10,A0),A0
            move.l  A0,(-$9C,A6)
            sf      (-$A6,A6)
            bra.b   .L16
.L14:
            btst    D2,D1
            bne.b   .L15
            moveq   #$C,D3
            bra.b   .L13
.L15:
            eori.w  #4,D3
.L16:
            move.w  D3,(-$98,A6)
.L17:
            move.l  D4,(-$A0,A6)
            move.l  D5,(-$A4,A6)
            btst    #5,D3
            beq.w   .L27
            move.w  (-$D4,A6),D7
            move.l  ($54,A2),D5
            tst.w   (6,A2)
            bmi.b   .L20
            move.l  D5,D0
            bsr.w   mapToColor
            move.l  D0,D5
            lea     ($DA0).w,A2
            moveq   #7,D0
            and.w   D3,D0
            subq.w  #1,D0
            beq.b   .L18
            bmi.b   .L19
            lea     mapToColor.L2,A0
            bra.b   .L21
.L18:
            lea     mapToColor.L3,A0
            bra.b   .L21
.L19:
            lea     mapToColor.L4,A0
            bra.b   .L21
.L20:
            movea.l ([8.w,A2]),A0
            lea     (6,A0),A2
.L21:
            moveq   #2,D1
            lea     (-$F4,A6),A1
            lea     (-$FA,A6),A3
.L22:
            move.w  (A0)+,D0
            bne.b   .L23
            moveq   #1,D0
.L23:
            move.w  D0,-(A1)
            neg.w   D0
            move.w  D0,-(A3)
            dbra    D1,.L22
            subq.w  #6,SP
            subq.w  #4,SP
            move.l  A2,-(SP)
            jsr     ([$16CC.w])
            cmp.l   (SP),D5
            bne.b   .L24
            lea     (4,SP),A1
            movea.l A2,A0
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            pea     (4,SP)
            jsr     ([$16D4.w])
            pea     (4,SP)
            jsr     ([$16CC.w])
.L24:
            movea.l ([TheGDevice.w]),A0
            movea.l ([$16.w,A0]),A1
            movea.l ([6.w,A0]),A0
            move.w  (4,A0),D0
            move.w  D0,(-$10E,A6)
            moveq   #$10,D1
            sub.w   D0,D1
            move.w  D1,(-$110,A6)
            move.l  A0,D0
            jsr     ([$644.w])
            move.l  D0,(-$10C,A6)
            movea.l ([$2A.w,A1]),A1
            lea     ($A,A1),A1
            move.l  A1,D0
            jsr     ([$644.w])
            move.l  D0,(-$108,A6)
            move.l  D5,D2
            move.l  (SP),D4
            moveq   #$20,D1
.L25:
            sub.w   D7,D1
            ble.b   .L26
            lsl.l   D7,D2
            or.l    D5,D2
            lsl.l   D7,D4
            or.l    (SP),D4
            bra.b   .L25
.L26:
            move.l  D2,(-$114,A6)
            move.l  D4,(-$118,A6)
            lea     ($A,SP),SP
            cmpi.w  #$24,(-$98,A6)
            bne.b   .L27
            clr.w   (-$104,A6)
.L27:
            movem.l (SP)+,D3-D7/A2-A3
            rts
mapToColor:
            lsr.w   #1,D0
            bcs.b   .L1
            ori.w   #$E0,D0
.L1:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            move.l  (4,A0,D0.w*8),-(SP)
            move.w  (2,A0,D0.w*8),-(SP)
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            addq.w  #6,SP
            rts
.L2:
            ds.b    6
.L3:
            dc.w    $FFFF,$FFFF,$FFFF
.L4:
            dc.w    $7FFF,$7FFF,$7FFF
GetCPixel:
            move.l  (8,SP),-(SP)
            moveq   #1,D2
            bsr.b   sub_4082EF7E
            rtd     #8
GetPixel:
            moveq   #0,D2
sub_4082EF7E:
            link.w  A6,#0
            movem.l D4-D5/A2-A3,-(SP)
            move.l  TheGDevice,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            jsr     ([$1A5C.w])
            move.w  (8,A6),D4
            sub.w   (6,A0),D4
            move.w  ($A,A6),D5
            sub.w   (8,A0),D5
            movea.l MainDevice,A2
            movea.l (A2),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            move.l  (A0),D1
            cmp.l   (A2),D1
            seq     -(SP)
            movea.l A0,A3
            bne.b   .L4
            move.w  D5,-(SP)
            move.w  D4,-(SP)
            move.w  D5,-(SP)
            move.w  D4,-(SP)
            movea.l ($808).w,A1
            jsr     (A1)
            movea.l DeviceList,A3
.L1:
            movea.l (A3),A2
            tst.w   ($14,A2)
            bpl.b   .L2
            lea     ($22,A2),A1
            cmp.w   (A1)+,D4
            ble.b   .L2
            cmp.w   (A1)+,D5
            ble.b   .L2
            cmp.w   (A1)+,D4
            bge.b   .L2
            cmp.w   (A1)+,D5
            blt.b   .L3
.L2:
            move.l  ($1E,A2),D0
            movea.l D0,A3
            bne.b   .L1
            bra.b   .L10
.L3:
            move.l  A3,TheGDevice
            lea     ($22,A2),A1
            sub.w   (A1)+,D4
            sub.w   (A1)+,D5
            movea.l ($16,A2),A3
            move.l  (A3),D0
            jsr     ([$644.w])
            movea.l D0,A3
            moveq   #1,D0
            move.w  D2,-(SP)
            jsr     ([$574.w])
            move.w  (SP)+,D2
.L4:
            move.w  (4,A3),D1
            andi.w  #$7FFF,D1
            mulu.w  D4,D1
            movea.l (A3),A1
            adda.l  D1,A1
            moveq   #1,D1
            tst.w   (4,A3)
            bpl.b   .L5
            move.w  ($20,A3),D1
.L5:
            mulu.w  D1,D5
            bfextu  (A1){D5:D1},D4
            tst.b   (SP)
            beq.b   .L6
            move.l  D2,D5
            jsr     ([$574.w])
            move.l  D5,D2
.L6:
            tst.w   D2
            beq.b   .L7
            move.l  D4,-(SP)
            move.l  ($10,A6),-(SP)
            jsr     ([$16D0.w])
            bra.b   .L10
.L7:
            cmpi.w  #$10,($1E,A3)
            bne.b   .L8
            tst.l   D4
            seq     D4
            bra.b   .L9
.L8:
            tst.w   D4
            sne     D4
.L9:
            neg.w   D4
            move.b  D4,($C,A6)
.L10:
            tst.b   (SP)+
            beq.b   .L11
            jsr     ([$F4C.w])
.L11:
            move.l  (SP)+,TheGDevice
            movem.l (SP)+,D4-D5/A2-A3
            unlk    A6
            rtd     #4
            ds.b    8
Translate24To32:
            and.l   Lo3Bytes,D0
            bclr    #$17,D0
            bne.b   .L1
            rts
.L1:
            move.w  D1,-(SP)
            move.w  #$C,D1
            rol.l   D1,D0
            move.b  D0,D1
            beq.b   .L2
            lsr.l   #4,D0
            move.b  ($4082F0C2.w,PC,D1.w),D0
            move.w  (SP)+,D1
            ror.l   #8,D0
            rts
.L2:
            ori.w   #$408,D0
            ror.l   #4,D0
            ror.l   #8,D0
            move.w  (SP)+,D1
            rts
            dc.w    $40F9,$FAFB,$FCFD,$FE50
            ds.b    6
StuffHex:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            move.l  (SP),(8,SP)
            addq.w  #8,SP
            move.b  (A0)+,D2
            andi.w  #$FE,D2
            beq.b   .L2
.L1:
            bsr.b   NEXTHEX
            move.b  D0,D1
            bsr.b   NEXTHEX
            lsl.b   #4,D1
            add.b   D0,D1
            move.b  D1,(A1)+
            subq.w  #2,D2
            bne.b   .L1
.L2:
            rts
NEXTHEX:
            move.b  (A0)+,D0
            cmpi.b  #$39,D0
            ble.b   .L1
            addi.b  #9,D0
.L1:
            andi.b  #$F,D0
            rts
            ds.b    6
XorSlab:
            ext.l   D4
            ext.l   D3
            lsl.l   D0,D4
            lsl.l   D0,D3
            move.l  D4,D0
            sub.l   D3,D0
            ble.b   .L1
            cmpi.l  #$20,D0
            bgt.b   .L2
            bfchg   (A0){D3:D0}
.L1:
            rts
.L2:
            moveq   #$1F,D1
            move.w  D3,D0
            and.w   D1,D0
            moveq   #-1,D5
            lsr.l   D0,D5
            move.w  D4,D0
            and.w   D1,D0
            moveq   #-1,D6
            lsr.l   D0,D6
            not.l   D6
            asr.l   #5,D3
            asr.l   #5,D4
            sub.w   D3,D4
            subq.w  #1,D4
            lsl.w   #2,D3
            adda.w  D3,A0
            eor.l   D5,(A0)+
            bra.b   .L4
.L3:
            not.l   (A0)+
.L4:
            dbra    D4,.L3
            eor.l   D6,(A0)
            rts
            ds.b    6
DrawSlab:
            cmp.w   (2,A3),D1
            bge.b   .L1
            move.w  (2,A3),D1
.L1:
            cmp.w   (6,A3),D2
            ble.b   .L2
            move.w  (6,A3),D2
.L2:
            cmp.w   D2,D1
            bge.b   .L3
            ext.l   D1
            ext.l   D2
            lsl.l   D0,D1
            move.l  D1,(-$11C,A6)
            lsl.l   D0,D2
            moveq   #$1F,D0
            and.w   D0,D1
            moveq   #-1,D3
            lsr.l   D1,D3
            and.w   D2,D0
            moveq   #-1,D1
            lsr.l   D0,D1
            not.l   D1
            move.l  (-$11C,A6),D0
            asr.l   #5,D2
            asr.l   #5,D0
            sub.w   D0,D2
            add.w   D0,D0
            add.w   D0,D0
            adda.w  D0,A1
            adda.w  D0,A2
            tst.w   D2
            jmp     (A4)
.L3:
            rts
            ds.b    4
.L4:
            and.l   D1,D3
.L5:
            move.l  D6,D0
            and.l   (A2)+,D3
            and.l   D3,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D0,D3
            move.l  D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK8:
            bgt.b   DrawSlab.L5
            beq.b   DrawSlab.L4
            rts
            ds.b    6
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D4,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK9:
            bgt.b   SLMASK8.L2
            beq.b   SLMASK8.L1
            rts
            ds.b    4
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            eor.l   D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK10:
            bgt.b   SLMASK9.L2
            beq.b   SLMASK9.L1
            rts
            ds.b    14
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D5,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK11:
            bgt.b   SLMASK10.L2
            beq.b   SLMASK10.L1
            rts
            ds.b    4
SLXMASK8:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            move.l  (0,A3,D6.w),D0
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            and.l   D3,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D0,D3
            move.l  D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            ds.b    4
SLXMASK9:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D4,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            dc.w    0
SLXMASK10:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            eor.l   D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            ds.b    12
SLXMASK11:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D5,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            dc.w    0
SLADDOVER:
            movem.l D7/A4-A5,-(SP)
            bsr.b   arithSetup
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    10
arithSetup:
            moveq   #0,D4
            move.w  (-$10E,A6),D5
            moveq   #0,D6
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            movea.l A0,A3
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L1
            move.l  (-$11C,A6),D6
            andi.l  #$FFFFFFE0,D6
            movea.w (-$90,A6),A0
            add.l   A0,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
.L1:
            sub.l   D7,D6
            movea.l (-$108,A6),A0
            rts
            ds.b    8
SLADDPIN:
            movem.l D7/A4-A5,-(SP)
            bsr.b   arithSetup
            tst.w   D2
            bra.b   .L10
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L9
            bfextu  (A2){D4:D7},D0
            beq.b   .L9
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L3
            cmp.w   (-$F6,A6),D0
            bls.b   .L4
.L3:
            move.w  (-$F6,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L5
            cmp.w   (-$F8,A6),D0
            bls.b   .L6
.L5:
            move.w  (-$F8,A6),D0
.L6:
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L7
            cmp.w   (-$FA,A6),D0
            bls.b   .L8
.L7:
            move.w  (-$FA,A6),D0
.L8:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L9:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L10:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    6
SLSUBOVER:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLSUBPIN:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L10
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L9
            bfextu  (A2){D4:D7},D0
            beq.b   .L9
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L3
            cmp.w   (-$F6,A6),D0
            bcc.b   .L4
.L3:
            move.w  (-$F6,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L5
            cmp.w   (-$F8,A6),D0
            bcc.b   .L6
.L5:
            move.w  (-$F8,A6),D0
.L6:
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L7
            cmp.w   (-$FA,A6),D0
            bcc.b   .L8
.L7:
            move.w  (-$FA,A6),D0
.L8:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L9:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L10:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    4
SLMAX:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L7
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L6
            bfextu  (A2){D4:D7},D0
            beq.b   .L6
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L3
            move.w  (A5),D0
.L3:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L4
            move.w  (A5),D0
.L4:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L5
            move.w  (A5),D0
.L5:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L6:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L7:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLMIN:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L7
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L6
            bfextu  (A2){D4:D7},D0
            beq.b   .L6
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L3
            move.w  (A5),D0
.L3:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L4
            move.w  (A5),D0
.L4:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L5
            move.w  (A5),D0
.L5:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L6:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L7:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLAVG:
            movem.l D7/A4-A5,-(SP)
            move.l  D1,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.w   .L4
.L1:
            and.l   (SP)+,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            mulu.w  (-$F6,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$FC,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            asl.w   D5,D0
            asl.w   D5,D0
            move.w  D0,-(SP)
            move.w  (A4)+,D0
            mulu.w  (-$F8,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$FE,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            asl.w   D5,D0
            or.w    D0,(SP)
            move.w  (A4)+,D0
            mulu.w  (-$FA,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$100,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            or.w    (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.w   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.w   .L2
            beq.w   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    4
SLHILITE:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            bfextu  (-$114,A6){0:D7},D5
            bfextu  (-$118,A6){0:D7},D0
            movea.l D0,A0
            tst.w   D2
            bra.b   .L5
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L4
            bfextu  (A2){D4:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            beq.b   .L4
            bfextu  (A1){D4:D7},D0
            cmp.l   D5,D0
            bne.b   .L3
            move.l  A0,D0
            bfins   D0,(A1){D4:D7}
            bra.b   .L4
.L3:
            cmp.l   A0,D0
            bne.b   .L4
            bfins   D5,(A1){D4:D7}
.L4:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L5:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    12
SLTRANSPARENT:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            bfextu  (-$114,A6){0:D7},D5
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            cmp.l   D5,D0
            beq.b   .L3
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    6
            move.l  D7,-(SP)
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            movea.l #$808080,A0
.L42:
            tst.l   (A2)+
            beq.b   .L41
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
.L41:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L42
            move.l  (SP)+,D7
            rts
            dc.w    0
.L40:
            subq.w  #1,D2
            move.w  (-$8C,A6),D4
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D4,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            rts
            ds.b    8
            movea.l D7,A0
            bsr.b   .L40
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L11:
            tst.l   (A2)+
            beq.b   .L5
            move.l  (0,A3,D6.w),D7
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A1),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L6
            cmp.w   D3,D0
            bls.b   .L7
.L6:
            move.w  D3,D0
.L7:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L8
            cmp.b   D3,D0
            bls.b   .L9
.L8:
            move.b  D3,D0
.L9:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L10
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L10:
            move.l  D0,(A1)
.L5:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L11
            move.l  A0,D7
            rts
            ds.b    14
            movea.l D7,A0
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L13:
            tst.l   (A2)+
            beq.b   .L12
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
.L12:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L13
            move.l  A0,D7
            rts
            ds.b    12
            movea.l D7,A0
            bsr.w   .L40
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L20:
            tst.l   (A2)+
            beq.b   .L14
            move.l  (0,A3,D6.w),D5
            and.l   D1,D5
            move.l  (A1),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L15
            cmp.w   D3,D0
            bcc.b   .L16
.L15:
            move.w  D3,D0
.L16:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L17
            cmp.b   D3,D0
            bcc.b   .L18
.L17:
            move.b  D3,D0
.L18:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L19
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L19:
            move.l  D0,(A1)
.L14:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L20
            move.l  A0,D7
            rts
            ds.b    12
            bsr.w   .L40
.L25:
            tst.l   (A2)+
            beq.b   .L21
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bhi.b   .L22
            move.w  D1,D0
            move.b  D5,D0
.L22:
            cmp.b   D1,D5
            bhi.b   .L23
            move.b  D1,D0
.L23:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bhi.b   .L24
            move.b  D1,D0
.L24:
            swap    D0
            move.l  D0,(A1)
.L21:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L25
            rts
            ds.b    8
            bsr.w   .L40
.L30:
            tst.l   (A2)+
            beq.b   .L26
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bls.b   .L27
            move.w  D1,D0
            move.b  D5,D0
.L27:
            cmp.b   D1,D5
            bls.b   .L28
            move.b  D1,D0
.L28:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bls.b   .L29
            move.b  D1,D0
.L29:
            swap    D0
            move.l  D0,(A1)
.L26:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L30
            rts
            ds.b    8
            lea     .L31,A4
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L31
            cmp.w   (A0),D3
            bne.b   .L31
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L31
            lea     .L32,A4
            bra.w   .L32
            ds.b    10
.L31:
            move.l  D7,-(SP)
            bsr.w   .L40
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L43:
            tst.l   (A2)+
            beq.b   .L44
            move.l  (0,A3,D6.w),D7
            move.l  (A1),D5
            cmp.l   D3,D7
            bne.b   .L33
            cmp.l   A0,D5
            beq.b   .L45
.L33:
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
.L45:
            move.l  D4,(A1)
.L44:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L43
            move.l  (SP)+,D7
            rts
            ds.b    6
.L32:
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            movea.l #$10101,A0
.L35:
            tst.l   (A2)+
            beq.b   .L34
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
.L34:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L35
            rts
            ds.b    6
            bsr.w   .L40
            move.l  (-$114,A6),D5
.L37:
            tst.l   (A2)+
            beq.b   .L36
            move.l  (0,A3,D6.w),D1
            cmp.l   D1,D5
            beq.b   .L36
            move.l  D1,(A1)
.L36:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L37
            rts
            ds.b    14
            move.l  D7,-(SP)
            bsr.b   arithSetup16
            move.w  #$3DEF,D0
            movea.w #$4210,A0
.L39:
            tst.w   (A2)+
            beq.b   .L38
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
.L38:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L39
            move.l  (SP)+,D7
            rts
            ds.b    8
arithSetup16:
            asl.w   #1,D2
            beq.b   sub_4082FB94
            subq.w  #1,D2
            neg.w   D1
            add.w   D1,D2
            swap    D1
            neg.w   D1
            add.w   D1,D2
            tst.l   D3
            bmi.b   .L2
            subq.w  #1,D2
.L1:
            addq.w  #2,A2
            addq.w  #2,A3
            addq.w  #2,A1
            addq.w  #2,D0
.L2:
            move.w  (-$8C,A6),D4
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D4,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            rts
sub_4082FB94:
            and.l   D1,D3
            bpl.b   arithSetup16.L1
            neg.w   D3
            add.w   D3,D2
            bra.b   arithSetup16.L2
            dc.w    0
            move.l  D7,-(SP)
            bsr.b   arithSetup16
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L12:
            tst.w   (A2)+
            beq.b   .L8
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
            bls.b   .L9
            move.l  D3,D0
.L9:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L10
            move.w  D3,D0
.L10:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L11
            move.b  D3,D0
.L11:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L8:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L12
            move.l  (SP)+,D7
            rts
            ds.b    8
            move.l  D7,-(SP)
            bsr.w   arithSetup16
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L14:
            tst.w   (A2)+
            beq.b   .L13
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
.L13:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L14
            move.l  (SP)+,D7
            rts
            move.l  D7,-(SP)
            bsr.w   arithSetup16
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
.L1:
            tst.w   (A2)+
            beq.b   .L5
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
            add.l   D1,D5
            sub.l   D7,D5
            move.l  D5,D0
            cmp.l   D3,D0
            bcc.b   .L2
            move.l  D3,D0
.L2:
            move.w  D5,D0
            cmp.w   D3,D0
            bcc.b   .L3
            move.w  D3,D0
.L3:
            move.b  D5,D0
            cmp.b   D3,D0
            bcc.b   .L4
            move.b  D3,D0
.L4:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L5:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L1
            move.l  (SP)+,D7
            rts
            ds.b    12
            move.l  D7,-(SP)
            bsr.w   arithSetup16
.L19:
            tst.w   (A2)+
            beq.b   .L15
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
            bcc.b   .L16
            move.l  D5,D0
.L16:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L17
            move.w  D5,D0
.L17:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L18
            move.b  D5,D0
.L18:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L15:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L19
            move.l  (SP)+,D7
            rts
            ds.b    14
            move.l  D7,-(SP)
            bsr.w   arithSetup16
.L32:
            tst.w   (A2)+
            beq.b   .L28
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
            bls.b   .L29
            move.l  D5,D0
.L29:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L30
            move.w  D5,D0
.L30:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L31
            move.b  D5,D0
.L31:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L28:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L32
            move.l  (SP)+,D7
            rts
            ds.b    14
            lea     .L20,A4
            lea     (-$FA,A6),A0
            move.w  (A0)+,D5
            cmp.w   (A0)+,D5
            bne.b   .L20
            cmp.w   (A0),D5
            bne.b   .L20
            addq.w  #1,D5
            andi.w  #$FFFE,D5
            cmpi.w  #$8000,D5
            bne.b   .L20
            lea     .L21,A4
            bra.w   .L21
            ds.b    10
.L20:
            move.l  D7,-(SP)
            bsr.w   arithSetup16
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L25:
            tst.w   (A2)+
            beq.w   .L22
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            moveq   #0,D5
            move.w  (A1),D5
            cmp.w   D3,D7
            bne.b   .L23
            cmp.w   A0,D5
            beq.b   .L24
.L23:
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
.L24:
            move.w  D4,(A1)
.L22:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L25
            move.l  (SP)+,D7
            rts
.L21:
            bsr.w   arithSetup16
            move.w  #$3DEF,D0
            movea.w #$421,A0
.L6:
            tst.w   (A2)+
            beq.b   .L7
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
.L7:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L6
            rts
            ds.b    10
            bsr.w   arithSetup16
            move.l  (-$114,A6),D5
.L27:
            tst.w   (A2)+
            beq.b   .L26
            move.w  (0,A3,D6.w),D1
            cmp.w   D1,D5
            beq.b   .L26
            move.w  D1,(A1)
.L26:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L27
            rts
            ds.b    14
SLABMODE:
            andi.w  #$37,D2
            bclr    #5,D2
            beq.b   .L2
            bclr    #4,D2
            beq.b   .L1
            moveq   #8,D2
.L1:
            cmpi.w  #$10,(-$D4,A6)
            bge.b   .L4
            addq.w  #8,D2
            move.w  #$1F,(-$8C,A6)
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L3
            movem.l D2-D3,-(SP)
            move.w  (-$D4,A6),D3
            subq.w  #1,D3
            not.w   D3
            move.w  (-$8E,A6),D2
            asl.w   #3,D2
            subq.w  #1,D2
            and.w   D3,D2
            move.w  D2,(-$8C,A6)
            move.w  (-$90,A6),D2
            asl.w   #3,D2
            move.w  D2,(-$90,A6)
            movem.l (SP)+,D2-D3
            bra.b   .L3
.L2:
            andi.w  #3,D2
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L3
            addq.w  #4,D2
.L3:
            lea     ($1C00).w,A4
            movea.l (0,A4,D2.w*4),A4
            rts
.L4:
            beq.b   .L5
            movea.l ($1CF8).w,A4
            adda.l  (0,A4,D2.w*4),A4
            rts
.L5:
            movea.l ($1CF4).w,A4
            adda.l  (0,A4,D2.w*4),A4
            move.w  (-$8C,A6),D2
            bset    #1,D2
            move.w  D2,(-$8C,A6)
            rts
            dc.w    0
SLARITH16TAB:
            dc.w    $FFFF,$FE20,$FFFF,$FC30,$FFFF,$FBB0,$FFFF,$FCE0
            dc.w    $FFFF,$FF40,$FFFF,$FD60,$FFFF,$FCA0,$FFFF,$FDC0
            dc.w    $FFFF,$F7B0
SLARITH32TAB:
            dc.w    $FFFF,$FA5C,$FFFF,$F8AC,$FFFF,$F84C,$FFFF,$F96C
            dc.w    $FFFF,$FB5C,$FFFF,$F9DC,$FFFF,$F91C,$FFFF,$FA1C
            dc.w    $FFFF,$F78C
            ds.b    8
            beq.b   .L1
            move.l  D3,D0
            not.l   D0
            and.l   (A1),D0
            and.l   D4,D3
            or.l    D3,D0
            move.l  D0,(A1)+
            subq.w  #2,D2
            blt.b   .L2
.L3:
            move.l  D4,(A1)+
            dbra    D2,.L3
            bra.b   .L2
.L1:
            and.l   D3,D1
.L2:
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A1),D1
            or.l    D1,D0
            move.l  D0,(A1)+
            rts
            ds.b    6
            beq.b   .L4
            eor.l   D3,(A1)+
            subq.w  #2,D2
            blt.b   .L5
.L6:
            not.l   (A1)+
            dbra    D2,.L6
            bra.b   .L5
.L4:
            and.l   D3,D1
.L5:
            eor.l   D1,(A1)+
            rts
            ds.b    10
            beq.b   .L7
            move.l  D3,D0
            not.l   D0
            and.l   (A1),D0
            and.l   D5,D3
            or.l    D3,D0
            move.l  D0,(A1)+
            subq.w  #2,D2
            blt.b   .L8
.L9:
            move.l  D5,(A1)+
            dbra    D2,.L9
            bra.b   .L8
.L7:
            and.l   D3,D1
.L8:
            move.l  D1,D0
            and.l   D5,D0
            not.l   D1
            and.l   (A1),D1
            or.l    D1,D0
            move.l  D0,(A1)+
            rts
            ds.b    6
FASTSLABMODE:
            andi.w  #3,D2
            lea     .L1,A4
            move.b  (0,A4,D2.w),D2
            suba.w  D2,A4
            rts
.L1:
            dc.b    $90,$60,$40
            ds.b    13
CopyHandle:
            move.l  (8,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (4,SP),D0
            beq.b   .L1
            movea.l D0,A1
            _HGetState
            move.b  D0,-(SP)
            _HNoPurge
            _GetHandleSize
            move.l  D0,D1
            exg     A0,A1
            jsr     RSetHSize
            exg     A0,A1
            move.b  (SP)+,D0
            _HSetState
            movea.l (A0),A0
            movea.l (A1),A1
            move.l  D1,D0
            _BlockMove
.L1:
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    12
