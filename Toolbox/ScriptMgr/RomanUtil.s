            include "Include/ROMHeader.s"

            EXPORT  RomanDispTable

            IMPORT  BitBucket,STDEXIT,STDUNLINK,A

            SECTION "RomanUtil",CODE

RomanPrint:
            rts
RomanName:
            bchg    D2,(A2)
            ble.b   CharType.L1+3
            bsr.b   sub_4081D996
RomanScript:
            move.l  (4,SP),D0
            movea.l IntlSpec,A0
            movea.l ($72,A0),A0
            cmp.w   ($46,A0),D0
            bhi.w   BitBucket
            sub.w   ($44,A0),D0
            add.w   D0,D0
            movea.l ($40,A0),A0
            movea.l (0,A0,D0.w),A0
            jmp     (A0)
RomanDispTable:
            dc.w    $001E,$001E,$0022,$002E,$0092,$0142,$0184,$0258
            dc.w    $03A0,$03D2,$03FC,$0428,$04A6,$0498,$04F4
SetScript:
GetScript:
            bra.w   BitBucket
CharByte:
            clr.w   ($E,SP)
            move.w  #$A,D0
            bra.w   STDEXIT
CharType:
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.w  #6,-(SP)
            _Pack6
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            tst.l   (SP)+
            move.w  (SP)+,D1
            movea.l (SP)+,A1
.L1:
            movem.l A2-A3,-(SP)
            tst.l   D0
sub_4081D996:
            beq.b   .L2
            movea.l D0,A2
            moveq   #0,D0
            movea.l (A2),A2
            btst    #0,(9,A2)
            beq.b   .L2
            movea.l A2,A3
            move.w  ($E,A2),D0
            adda.l  D0,A2
            move.w  ($C,A3),D0
            adda.l  D0,A3
            moveq   #0,D0
            move.b  (0,A1,D1.w),D0
            move.b  (0,A2,D0.w),D0
            move.b  (0,A3,D0.w),D0
            move.b  D0,D1
            bpl.b   .L1
            bset    #$E,D0
.L1:
            andi.b  #$F,D0
            andi.b  #$70,D1
            lsl.w   #4,D1
            or.w    D1,D0
.L2:
            movem.l (SP)+,A2-A3
            move.w  D0,(SP)
            jmp     (A0)
Pixel2Char:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l ($16,A6),A3
            subq.l  #4,SP
            move.l  A3,-(SP)
            move.w  ($14,A6),-(SP)
            move.w  ($12,A6),-(SP)
            bsr.w   FixSpExtra
            clr.b   (A2)
            moveq   #0,D4
            move.w  ($10,A6),D3
            ble.b   .L5
            addq.b  #1,(A2)
            move.w  ($14,A6),D4
            clr.w   -(SP)
            move.l  A3,-(SP)
            clr.w   -(SP)
            move.w  D4,-(SP)
            _TextWidth
            cmp.w   (SP)+,D3
            bhi.b   .L5
            move.l  D4,D7
            add.l   D7,D7
            addq.l  #2,D7
            move.l  SP,D0
            sub.l   ApplLimit,D0
            sub.l   D7,D0
            cmpi.l  #$400,D0
            blt.b   .L2
            suba.l  D7,SP
            movea.l SP,A4
            move.w  D4,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            _MeasureText
            move.w  D4,D0
.L1:
            cmp.w   (A4)+,D3
            dbls    D0,.L1
            sub.w   D0,D4
            move.w  (-2,A4),D5
            move.w  (-4,A4),D6
            adda.l  D7,SP
            bra.b   .L4
.L2:
            moveq   #0,D4
            move.l  D4,D5
.L3:
            clr.w   -(SP)
            move.l  A3,-(SP)
            clr.w   -(SP)
            addq.w  #1,D4
            move.w  D4,-(SP)
            _TextWidth
            move.w  D5,D6
            move.w  (SP)+,D5
            cmp.w   D5,D3
            bhi.b   .L3
.L4:
            clr.b   (A2)
            add.w   D3,D3
            add.w   D5,D6
            cmp.w   D6,D3
            bhi.b   .L5
            move.b  #1,(A2)
            subq.w  #1,D4
.L5:
            _SpaceExtra
            move.w  D4,($1A,A6)
            movem.l (SP)+,D3-D7/A2-A4
            move.w  #$12,D0
            bra.w   STDUNLINK
Char2Pixel:
            link.w  A6,#0
            subq.l  #4,SP
            move.l  ($14,A6),-(SP)
            move.w  ($12,A6),-(SP)
            move.w  ($10,A6),-(SP)
            bsr.w   FixSpExtra
            move.w  ($E,A6),D0
            bpl.b   .L1
            clr.w   D0
.L1:
            cmp.w   ($12,A6),D0
            ble.b   .L2
            move.w  ($12,A6),D0
.L2:
            subq.l  #2,SP
            move.l  ($14,A6),-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            _TextWidth
            move.w  (SP)+,($18,A6)
            _SpaceExtra
            move.w  #$10,D0
            bra.w   STDUNLINK
Translit:
            link.w  A6,#0
            movem.l D3/A2-A4,-(SP)
            moveq   #-1,D0
            move.l  ($C,A6),D1
            andi.w  #3,D1
            beq.w   .L4
            move.w  ($10,A6),D1
            move.w  D1,D2
            subq.b  #1,D1
            bgt.w   .L4
            addq.b  #3,D1
            nop
            blt.w   .L4
            move.w  #$C000,D3
            and.w   D3,D2
            cmp.w   D3,D2
            beq.w   .L4
            movea.l ($16,A6),A1
            movea.l ($12,A6),A2
            movea.l A1,A0
            _GetHandleSize
            tst.l   D0
            blt.b   .L4
            move.l  D0,D1
            movea.l A2,A0
            _SetHandleSize
            tst.w   D0
            blt.b   .L4
            movea.l (A1),A1
            movea.l (A2),A2
            movem.l D1-D2/A1,-(SP)
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.w  #6,-(SP)
            _Pack6
            movea.l (SP)+,A4
            movem.l (SP)+,D1-D2/A1
            moveq   #-1,D0
            move.l  A4,D3
            beq.w   .L4
            movea.l (A4),A4
            btst    #0,(9,A4)
            beq.b   .L4
            moveq   #0,D3
            movea.l A4,A0
            moveq   #0,D0
            move.w  ($E,A4),D0
            adda.l  D0,A0
            movea.l A4,A3
            move.w  ($10,A4),D0
            adda.l  D0,A3
            moveq   #0,D0
            cmpi.w  #$8000,D2
            beq.b   .L2
            movea.l A4,A3
            move.w  ($12,A4),D0
            adda.l  D0,A3
            moveq   #0,D0
            cmpi.w  #$4000,D2
            beq.b   .L2
            movea.l A1,A0
            movea.l A2,A1
            move.l  D1,D0
            _BlockMove
            bra.b   .L3
.L1:
            move.b  (A1)+,D0
            move.b  (0,A0,D0.w),D3
            add.b   (0,A3,D3.w),D0
            move.b  D0,(A2)+
.L2:
            dbra    D1,.L1
.L3:
            moveq   #0,D0
.L4:
            move.w  D0,($1A,A6)
            movem.l (SP)+,D3/A2-A4
            move.w  #$12,D0
            bra.w   STDUNLINK
FindWord:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l ($1A,A6),A3
            move.w  ($16,A6),D4
            move.w  ($18,A6),D7
            tst.b   ($14,A6)
            bne.b   .L1
            subq.w  #1,D4
.L1:
            moveq   #0,D3
            move.l  D3,D5
            tst.w   D4
            blt.b   .L5
            move.l  D7,D3
            move.l  D7,D5
            cmp.w   D7,D4
            bge.b   .L5
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.w  #6,-(SP)
            _Pack6
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.b   .L5
            movea.l (A0),A0
            btst    #0,(9,A0)
            beq.b   .L5
            movea.l A0,A1
            moveq   #0,D0
            move.w  ($16,A0),D0
            adda.l  D0,A1
            move.l  ($10,A6),D0
            beq.b   .L2
            movea.l A0,A1
            moveq   #0,D0
            move.w  ($18,A0),D0
            adda.l  D0,A1
            move.l  ($10,A6),D0
            cmp.l   MinusOne,D0
            beq.b   .L2
            movea.l D0,A1
.L2:
            lea     ($100,A1),A4
            move.w  D4,D3
            move.w  D4,D5
            subq.w  #2,D5
            moveq   #0,D6
            bsr.b   sub_4081DC56
            bsr.b   sub_4081DC56
            bsr.b   sub_4081DC56
            bsr.b   sub_4081DC90
            bne.b   .L5
            move.w  D6,-(SP)
.L3:
            bsr.b   sub_4081DC56
            bsr.b   TupleRight
            beq.b   .L3
            move.w  (SP)+,D6
            subq.w  #1,D3
.L4:
            bsr.b   sub_4081DC72
            bsr.b   sub_4081DCB0
            beq.b   .L4
            subq.w  #1,D5
            addq.w  #2,D3
.L5:
            move.w  D3,(A2)+
            move.w  D5,(A2)+
            clr.l   (A2)+
            clr.l   (A2)
            movem.l (SP)+,D3-D7/A2-A4
            move.w  #$16,D0
            bra.w   STDUNLINK
sub_4081DC56:
            moveq   #0,D0
            addq.w  #1,D5
            blt.b   .L1
            cmp.w   D7,D5
            bge.b   .L1
            move.b  (0,A3,D5.w),D0
            move.b  (0,A1,D0.w),D0
.L1:
            lsl.w   #5,D6
            andi.w  #$7FFF,D6
            or.b    D0,D6
            rts
sub_4081DC72:
            moveq   #0,D0
            subq.w  #1,D3
            blt.b   .L1
            cmp.w   D7,D3
            bge.b   .L1
            move.b  (0,A3,D3.w),D0
            move.b  (0,A1,D0.w),D0
.L1:
            andi.w  #$FFE0,D6
            add.w   D6,D6
            or.w    D0,D6
            ror.w   #6,D6
            rts
sub_4081DC90:
            bsr.b   TupleRight
            beq.b   sub_4081DCB0.L4
            move.w  D6,D1
            bra.b   sub_4081DCB0.L1
TupleRight:
            move.w  D6,D1
            bsr.b   sub_4081DCE0
            beq.b   sub_4081DCB0.L4
            andi.w  #$FFE0,D1
            bsr.b   sub_4081DCE0
            beq.b   sub_4081DCB0.L4
            andi.w  #$7C00,D1
            cmpi.w  #$400,D1
            bra.b   sub_4081DCB0.L2
sub_4081DCB0:
            move.w  D6,D1
            bsr.b   sub_4081DCE0
            beq.b   .L4
.L1:
            andi.w  #$3FF,D1
            bsr.b   sub_4081DCE0
            beq.b   .L4
            andi.w  #$1F,D1
            cmpi.w  #1,D1
.L2:
            bne.b   .L3
            move.w  D6,D1
            andi.w  #$3E0,D1
            seq     D1
            tst.b   D1
            rts
.L3:
            move.w  D6,D1
            andi.w  #$3E0,D1
            cmpi.w  #$20,D1
.L4:
            rts
sub_4081DCE0:
            movea.l A4,A0
            move.w  (A0)+,D0
.L1:
            cmp.w   (A0)+,D1
            dbeq    D0,.L1
            rts
HiliteText:
            link.w  A6,#0
            movea.l ($C,A6),A0
            move.w  ($14,A6),D1
            move.w  ($12,A6),D0
            bsr.b   Normalize
            move.w  ($10,A6),D0
            bsr.b   Normalize
            clr.l   (A0)+
            clr.l   (A0)+
            move.w  #$12,D0
            bra.w   STDUNLINK
Normalize:
            bge.b   .L1
            moveq   #0,D0
.L1:
            cmp.w   D1,D0
            ble.b   .L2
            move.w  D1,D0
.L2:
            move.w  D0,(A0)+
            rts
DrawJust:
            link.w  A6,#0
            subq.l  #4,SP
            move.l  ($10,A6),-(SP)
            move.w  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            bsr.b   FixSpExtra
            move.l  ($10,A6),-(SP)
            clr.w   -(SP)
            move.w  ($E,A6),-(SP)
            _DrawText
            _SpaceExtra
            move.w  #$C,D0
            bra.w   STDUNLINK
MeasureJust:
            link.w  A6,#0
            subq.l  #4,SP
            move.l  ($14,A6),-(SP)
            move.w  ($12,A6),-(SP)
            move.w  ($10,A6),-(SP)
            bsr.b   FixSpExtra
            move.w  ($12,A6),-(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($C,A6),-(SP)
            _MeasureText
            _SpaceExtra
            move.w  #$10,D0
            bra.w   STDUNLINK
ParseTable:
            link.w  A6,#0
            move.w  #$100,($10,A6)
            movea.l ($C,A6),A0
            move.w  #$FF,D0
.L1:
            clr.b   (A0)+
            dbra    D0,.L1
            move.w  #$A,D0
            bra.w   STDUNLINK
FixSpExtra:
            link.w  A6,#0
            movea.l ($C,A6),A0
            move.w  ($A,A6),D0
            moveq   #0,D1
            move.w  (8,A6),D2
            bne.b   .L2
            move.l  D1,-(SP)
            bra.b   .L5
.L1:
            cmpi.b  #$20,(A0)+
            dbeq    D0,.L1
            bne.b   .L3
            addq.l  #1,D1
.L2:
            dbra    D0,.L1
.L3:
            clr.l   -(SP)
            tst.w   D1
            beq.b   .L4
            move.w  D2,-(SP)
            move.w  D1,-(SP)
            _FixRatio
.L4:
            addq.l  #1,(SP)
.L5:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($4C,A0),D0
            move.l  D0,($10,A6)
            add.l   (SP)+,D0
            move.l  D0,($4C,A0)
            move.w  #8,D0
            bra.w   STDUNLINK
            movea.l (SP)+,A1
            tst.l   (SP)+
            movea.l (SP)+,A0
            move.l  (SP)+,(A0)
            tst.l   (SP)+
            clr.w   (SP)
            jmp     (A1)
            movea.l (SP)+,A1
            tst.l   (SP)+
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.l  A1,-(SP)
            moveq   #0,D2
            bra.b   .L7
.L6:
            move.b  (A0)+,D1
            cmpi.b  #$20,D1
            bne.b   .L7
            addq.l  #8,D2
.L7:
            subq.l  #1,D0
            bge.b   .L6
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($4A,A0),D0
            bne.b   .L8
            move.w  SysFontSize,D0
            bne.b   .L8
            move.w  #$C,D0
.L8:
            move.l  D2,D1
            swap    D1
            mulu.w  D0,D1
            swap    D1
            clr.w   D1
            mulu.w  D0,D2
            add.w   D2,D1
            lsl.l   #8,D1
            move.l  D1,(4,SP)
            rts
            ds.b    8
XVisibleLength:
            link.w  A6,#0
            movea.l ($10,A6),A0
            move.l  A0,D2
            move.l  ($C,A6),D0
            ble.b   .L4
            adda.l  D0,A0
.L1:
            move.b  -(A0),D1
            beq.b   .L2
            cmpi.b  #$20,D1
            bhi.b   .L3
            beq.b   .L2
            cmpi.b  #$D,D1
            beq.b   .L2
            cmpi.b  #9,D1
            bne.b   .L3
.L2:
            cmp.w   A0,D2
            bne.b   .L1
            moveq   #0,D2
            bra.b   .L5
.L3:
            addq.l  #1,A0
.L4:
            sub.l   A0,D2
            neg.l   D2
.L5:
            move.l  D2,($14,A6)
            move.w  #$C,D0
            bra.w   STDUNLINK
            ds.b    12
PrintAction:
            movem.l D0-D7/A0-A6,-(SP)
            movea.l IntlSpec,A4
            lea     ($72,A4),A4
            move.w  #$41,D4
            bra.b   .L2
.L1:
            move.l  (A4)+,D3
            beq.b   .L2
            movea.l D3,A3
            tst.b   (4,A3)
            beq.b   .L2
            move.l  ($20,A3),D3
            beq.b   .L2
            movea.l D3,A3
            movem.l D0-D4/A4,-(SP)
            jsr     (A3)
            movem.l (SP)+,D0-D4/A4
.L2:
            dbra    D4,.L1
            movem.l (SP)+,D0-D7/A0-A6
            rts

            EVEN
