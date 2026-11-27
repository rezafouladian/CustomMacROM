StdText:
            link.w  A6,#-4
            movem.l D5-D7/A3-A4,-(SP)
.L1:
            move.w  ($14,A6),D6
            ble.w   .L22
            cmpi.w  #$FF,D6
            ble.b   .L2
            move.w  #$FF,D6
.L2:
            jsr     ([$1A3C.w])
            sle     -(SP)
            ble.w   .L20
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  ($44,A3),D7
            cmp.w   ($18,A4),D7
            beq.b   .L3
            moveq   #3,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($18,A4)
.L3:
            move.b  ($46,A3),D7
            cmp.b   ($1A,A4),D7
            beq.b   .L4
            moveq   #4,D0
            bsr.l   DPutPicOp
            move.b  D7,D0
            bsr.l   DPutPicByte
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.b  D7,($1A,A4)
.L4:
            move.w  ($48,A3),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L7
            cmpi.w  #1,($62,A4)
            bne.b   .L5
            btst    #5,D7
            beq.b   .L5
            andi.w  #7,D7
            move.b  .L6(PC,D7.w),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L7
.L5:
            moveq   #5,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($1C,A4)
            bra.b   .L7
.L6:
            dc.w    $0003,$0201,$0103,$0201
.L7:
            move.w  ($4A,A3),D7
            cmp.w   ($1E,A4),D7
            beq.b   .L8
            moveq   #$D,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($1E,A4)
.L8:
            move.l  ($4C,A3),D7
            cmp.l   ($20,A4),D7
            beq.b   .L9
            moveq   #6,D0
            bsr.l   DPutPicOp
            move.l  D7,-(SP)
            bsr.l   PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($20,A4)
.L9:
            move.l  ($C,A6),D7
            move.l  (8,A6),D5
            cmp.l   ($24,A4),D7
            bne.b   .L10
            cmp.l   ($28,A4),D5
            beq.b   .L11
.L10:
            moveq   #$10,D0
            bsr.l   DPutPicOp
            move.l  D7,-(SP)
            bsr.l   PutPicLong
            move.l  D5,-(SP)
            bsr.l   PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($24,A4)
            move.l  D5,($28,A4)
.L11:
            cmpi.w  #1,($62,A4)
            beq.b   .L13
            move.w  ($E,A3),D7
            cmpi.w  #$8000,D7
            beq.b   .L12
            moveq   #$15,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
.L12:
            move.w  ($C,A3),D7
            cmp.w   ($70,A4),D7
            beq.b   .L13
            moveq   #$16,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($70,A4)
.L13:
            move.l  ($30,A3),D5
            sub.w   ($2E,A4),D5
            swap    D5
            sub.w   ($2C,A4),D5
            swap    D5
            move.l  D5,D0
            andi.l  #$FF00FF00,D0
            beq.b   .L14
            moveq   #$28,D0
            bsr.l   DPutPicOp
            move.l  ($30,A3),-(SP)
            bsr.l   PutPicLong
            bra.b   .L19
.L14:
            move.l  D5,D0
            andi.l  #$FF0000,D0
            bne.b   .L15
            moveq   #$29,D0
            bsr.l   DPutPicOp
            bra.b   .L18
.L15:
            tst.b   D5
            bne.b   .L16
            moveq   #$2A,D0
            bsr.l   DPutPicOp
            bra.b   .L17
.L16:
            moveq   #$2B,D0
            bsr.l   DPutPicOp
            move.b  D5,D0
            bsr.l   DPutPicByte
.L17:
            swap    D5
.L18:
            move.b  D5,D0
            bsr.l   DPutPicByte
.L19:
            move.b  D6,D0
            bsr.l   DPutPicByte
            move.l  ($10,A6),-(SP)
            move.w  D6,-(SP)
            bsr.l   PutPicData
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  ($30,A3),($2C,A4)
.L20:
            pea     StdDraw_Text
            pea     GetRect_Text
            jsr     ([$1AA0.w])
            tst.b   (SP)+
            bne.b   .L21
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  ($E,A3),($72,A4)
.L21:
            sub.w   D6,($14,A6)
            ble.b   .L22
            movea.l ($10,A6),A0
            adda.w  D6,A0
            move.l  A0,($10,A6)
            bra.w   .L1
.L22:
            bset    #7,HiliteMode
            movem.l (SP)+,D5-D7/A3-A4
            unlk    A6
            rtd     #$E
GetRect_Text:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            move.l  TheGDevice,-(SP)
            move.l  LastTxGDevice,TheGDevice
            move.l  ($30,A3),D0
            move.l  D0,(A1)
            move.l  D0,(4,A1)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            subq.w  #8,SP
            movea.l SP,A0
            move.l  A1,-(SP)
            clr.w   -(SP)
            move.w  D6,-(SP)
            move.l  ($10,A6),-(SP)
            pea     ($C,A0)
            pea     (8,A0)
            move.l  A0,-(SP)
            jsr     ([$11B4.w])
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D0,(6,A1)
            move.w  (SP)+,D0
            sub.w   D0,(A1)
            move.w  (SP)+,D0
            add.w   D0,(4,A1)
            lea     ($C,SP),SP
            move.l  (SP)+,TheGDevice
            rts
StdDraw_Text:
            move.w  D6,-(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     DrText
            rts
            ds.b    8
CallText:
            movea.l (SP)+,A0
            move.l  #$10001,-(SP)
            move.l  (SP),-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l JStdTEXT,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
.L1:
            jmp     (A0)
TextFace:
            movea.l (A5),A0
            movea.l (A0),A0
            move.b  (5,SP),($46,A0)
            bra.b   CharWidth.L1
DrawChar:
            move.w  #1,-(SP)
            pea     (7,SP)
            jsr     CallText
            bra.b   CharWidth.L1
CharWidth:
            clr.w   -(SP)
            move.l  SP,-(SP)
            move.l  #$10007,-(SP)
            jsr     ([$1018.w])
            move.w  (SP)+,(6,SP)
.L1:
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
            ds.b    12
TextFont:
            moveq   #$44,D0
            bra.b   TextSize.L2
TextMode:
            moveq   #$48,D0
            bra.b   TextSize.L2
TextSize:
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L1
            clr.w   ($C,A0)
.L1:
            moveq   #$4A,D0
.L2:
            jmp     PortWord
            ds.b    4
SpaceExtra:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),($4C,A0)
            bra.b   DrawText2.L1
DrawString:
            movea.l (4,SP),A0
            clr.w   D0
            move.b  (A0)+,D0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jsr     CallText
            bra.b   DrawText2.L1
DrawText2:
            movea.l (8,SP),A0
            adda.w  (6,SP),A0
            move.w  (4,SP),-(SP)
            move.l  A0,-(SP)
            jsr     CallText
            move.l  (SP)+,(SP)
.L1:
            move.l  (SP)+,(SP)
            rts
            ds.b    10
StringWidth:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            clr.w   D0
            move.b  (A0)+,D0
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            move.l  A1,-(SP)
TextWidth:
            link.w  A6,#-$10
            clr.w   ($10,A6)
            clr.w   -(SP)
            move.w  (8,A6),-(SP)
            ble.b   .L3
            movea.l ($C,A6),A0
            adda.w  ($A,A6),A0
            move.l  A0,-(SP)
            move.l  #$10001,D0
            move.l  D0,(-$C,A6)
            move.l  D0,(-$10,A6)
            pea     (-$C,A6)
            pea     (-$10,A6)
            pea     (-8,A6)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($28,A0),A0
.L1:
            jsr     (A0)
            move.w  (SP)+,D1
            move.w  (-$A,A6),D0
            move.w  (-$E,A6),D2
            cmp.w   D2,D0
            beq.b   .L2
            mulu.w  D0,D1
            divu.w  D2,D1
.L2:
            move.w  D1,($10,A6)
.L3:
            unlk    A6
            rtd     #8
            ds.b    10
StdTxMeas:
            link.w  A6,#-$14
            move.l  A4,-(SP)
            movea.l (A5),A4
            clr.l   (-$14,A6)
            movea.l (A4),A0
            lea     (-$10,A6),A1
            move.w  ($44,A0),(A1)+
            move.w  ($4A,A0),(A1)+
            move.b  ($46,A0),(A1)+
            st      (A1)+
            move.w  (A0),(A1)+
            movea.l ($10,A6),A0
            move.l  (A0),(A1)+
            movea.l ($C,A6),A0
            move.l  (A0),(A1)+
            clr.l   -(SP)
            pea     (-$10,A6)
            movea.l JSwapFont,A0
            jsr     (A0)
            movea.l (SP)+,A1
            move.l  A1,(-$B0,A4)
            movea.l (A4),A0
            tst.w   (6,A0)
            bpl.b   .L1
            move.w  ($C,A0),D0
            beq.b   .L1
            bsr.w   CalcCharExtra
            move.l  D0,(-$14,A6)
.L1:
            movea.l (8,A6),A0
            clr.l   (A0)
            clr.l   (4,A0)
            move.b  ($D,A1),(1,A0)
            move.b  ($E,A1),(3,A0)
            move.b  ($F,A1),(5,A0)
            move.b  ($10,A1),D0
            ext.w   D0
            move.w  D0,(6,A0)
            movea.l ($10,A6),A0
            move.l  ($12,A1),(A0)
            movea.l ($C,A6),A0
            move.l  ($16,A1),(A0)
            movea.l ($14,A6),A0
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            moveq   #0,D1
            move.w  ($18,A6),D2
            bra.b   .L3
.L2:
            clr.w   D0
            move.b  (A0)+,D0
            lsl.w   #2,D0
            add.l   (0,A1,D0.w),D1
            cmpi.w  #$80,D0
            beq.b   .L3
            add.l   (-$14,A6),D1
.L3:
            dbra    D2,.L2
            move.l  D1,(-$AC,A4)
            swap    D1
            move.w  D1,($1A,A6)
            movea.l (SP)+,A4
            unlk    A6
            rtd     #$12
            ds.b    8
MeasureText:
            link.w  A6,#-$14
            movem.l D3-D6/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l (8,A6),A3
            move.w  ($10,A6),D3
            moveq   #0,D4
            movea.l (A5),A4
            movea.l (A4),A0
            clr.l   (-$14,A6)
            move.l  ($68,A0),D0
            beq.b   .L3
            movea.l D0,A1
            move.l  ($28,A1),D0
            cmp.l   ($11B4).w,D0
            beq.b   .L3
            moveq   #0,D6
            moveq   #0,D5
            subq.w  #2,SP
.L1:
            move.l  A2,-(SP)
            clr.w   -(SP)
            move.w  D4,-(SP)
            jsr     ([$1018.w])
            move.w  (SP),D0
            cmp.w   D6,D0
            bge.b   .L2
            add.w   D6,D5
.L2:
            add.w   D5,D0
            move.w  D0,(A3)+
            move.w  (SP),D6
            addq.w  #1,D4
            cmp.w   D3,D4
            ble.b   .L1
            addq.w  #2,SP
            bra.w   .L8
.L3:
            lea     (-$10,A6),A1
            move.w  ($44,A0),(A1)+
            move.w  ($4A,A0),(A1)+
            move.b  ($46,A0),(A1)+
            st      (A1)+
            move.w  (A0),(A1)+
            move.l  #$10001,(A1)+
            move.l  #$10001,(A1)+
            clr.l   -(SP)
            pea     (-$10,A6)
            jsr     ([$1204.w])
            movea.l (SP)+,A0
            move.w  ($14,A0),D3
            move.w  ($18,A0),D4
            movea.l (A4),A0
            tst.w   (6,A0)
            bpl.b   .L4
            move.w  ($C,A0),D0
            beq.b   .L4
            bsr.w   CalcCharExtra
            move.l  D0,(-$14,A6)
.L4:
            movea.l ($C,A6),A0
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            movea.l (8,A6),A2
            moveq   #0,D1
            move.w  ($10,A6),D2
.L5:
            swap    D1
            move.w  D1,(A2)+
            swap    D1
            clr.w   D0
            move.b  (A0)+,D0
            lsl.w   #2,D0
            add.l   (0,A1,D0.w),D1
            cmpi.w  #$80,D0
            beq.b   .L6
            add.l   (-$14,A6),D1
.L6:
            dbra    D2,.L5
            cmp.w   D3,D4
            beq.b   .L8
            movea.l (8,A6),A2
            move.w  ($10,A6),D2
.L7:
            move.w  (A2),D0
            mulu.w  D3,D0
            divu.w  D4,D0
            move.w  D0,(A2)+
            dbra    D2,.L7
.L8:
            movem.l (SP)+,D3-D6/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    4
GetFontInfo:
            link.w  A6,#-8
            move.l  #$10001,(-4,A6)
            move.l  #$10001,(-8,A6)
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  (8,A6),-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($28,A0),A0
.L1:
            jsr     (A0)
            tst.w   (SP)+
            movea.l (A5),A0
            movea.l (-$B0,A0),A0
            movea.l (8,A6),A1
            move.b  ($C,A0),D0
            ext.w   D0
            add.w   D0,(4,A1)
            clr.w   D0
            move.b  ($B,A0),D0
            beq.b   .L2
            addq.w  #1,(A1)
            add.w   D0,(2,A1)
.L2:
            move.l  (-4,A6),D0
            cmp.l   (-8,A6),D0
            beq.b   .L3
            bsr.b   SCALE
            bsr.b   SCALE
            move.w  (A1),D0
            mulu.w  (-2,A6),D0
            move.w  (-6,A6),D1
            lsr.w   #1,D1
            ext.l   D1
            add.l   D1,D0
            divu.w  (-6,A6),D0
            move.w  D0,(A1)+
            bsr.b   SCALE
.L3:
            unlk    A6
            rtd     #4
SCALE:
            move.w  (A1),D0
            mulu.w  (-4,A6),D0
            move.w  (-8,A6),D1
            lsr.w   #1,D1
            ext.l   D1
            add.l   D1,D0
            divu.w  (-8,A6),D0
            move.w  D0,(A1)+
            rts
            ds.b    14
CalcCharExtra:
            movem.l D1-D2/A0-A1,-(SP)
            subq.w  #8,SP
            ext.l   D0
            asl.l   #4,D0
            move.l  D0,-(SP)
            movea.l WidthPtr,A0
            moveq   #0,D0
            move.w  ($40E,A0),D0
            swap    D0
            move.l  D0,-(SP)
            jsr     ([$FA0.w])
            subq.w  #8,SP
            move.w  ($992).w,-(SP)
            move.w  ($996).w,-(SP)
            jsr     ([$FA4.w])
            subq.w  #4,SP
            move.w  ($9B0).w,-(SP)
            move.w  ($9AC).w,-(SP)
            jsr     ([$FA4.w])
            jsr     ([$FA0.w])
            jsr     ([$FA0.w])
            movem.l (SP)+,D0-D2/A0-A1
            rts
            ds.b    14
CharExtra:
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L3
            subq.w  #4,SP
            move.l  (8,SP),-(SP)
            move.w  ($4A,A0),D0
            bne.b   .L2
            tst.w   ($44,A0)
            bne.b   .L1
            move.w  SysFontSize,D0
            bne.b   .L2
.L1:
            move.b  FMDefaultSize,D0
            bne.b   .L2
            moveq   #$C,D0
.L2:
            swap    D0
            clr.w   D0
            move.l  D0,-(SP)
            dc.w    $A84D                           ; A-trap $A84D
            move.l  (SP)+,D0
            asr.l   #4,D0
            movea.l ([A5]),A0
            move.w  D0,($C,A0)
.L3:
            rtd     #4
            ds.b    14
