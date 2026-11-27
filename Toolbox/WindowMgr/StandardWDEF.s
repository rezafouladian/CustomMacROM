            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryWDEF_0

            IMPORT  BaseOfROM,RsrcEntryapad_2

            SECTION "StandardWDEF",CODE

RsrcEntryWDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'WDEF' 0 (2116 bytes) - Combo mask
            dc.l    RsrcEntryapad_2-BaseOfROM       ; Next entry
            dc.l    RsrcWDEF_0-BaseOfROM            ; Data
            dc.b    'WDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000850,$00000114   ; Block header
RsrcWDEF_0:
            bra.b   .L1
            dc.w    0,$5744,$4546,0,$000B
.L1:
            link.w  A6,#-$22
            movem.l D3-D7/A1-A4,-(SP)
            cmpi.w  #6,($C,A6)
            bgt.w   .L7
            cmpi.w  #0,($C,A6)
            bmi.w   .L7
            movea.l (A5),A0
            move.l  (A0),-(SP)
            cmpi.w  #$3FFF,ROM85
            sls     (-$22,A6)
            bhi.b   .L2
            bsr.w   sub_408769FA
            bra.b   .L3
.L2:
            move.l  WMgrPort,-(SP)
            _SetPort
.L3:
            lea     (-8,A6),A3
            move.l  A3,-(SP)
            _GetFontInfo
            move.w  (A3)+,D7
            add.w   (A3)+,D7
            addq.w  #4,D7
            bset    #0,D7
            moveq   #$13,D1
            cmp.w   D1,D7
            bge.b   .L4
            sub.w   D7,D1
            lsr.w   #1,D1
            add.w   D1,(-8,A6)
            moveq   #$13,D7
.L4:
            move.w  D7,(A3)+
            move.w  D7,D0
            subi.w  #$D,D0
            lsr.w   #1,D0
            move.w  D0,(A3)
            clr.l   -(SP)
            _NewRgn
            move.l  (SP)+,(-$C,A6)
            tst.b   (-$22,A6)
            beq.b   .L5
            pea     (-$1A,A6)
            _GetForeColor
            pea     (-$20,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$10,A6)
            _HLock
            move.l  (A0),(-$14,A6)
.L5:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D5
            move.w  D5,D6
            andi.w  #3,D5
            clr.l   (A0)
            add.w   D0,D0
            lea     .L8,A0
            adda.w  .L8(PC,D0.w),A0
            jsr     (A0)
            move.l  (-$C,A6),-(SP)
            _DisposRgn
            tst.b   (-$22,A6)
            beq.b   .L6
            movea.l (-$10,A6),A0
            _HUnlock
            pea     (-$20,A6)
            _RGBBackColor
            pea     (-$1A,A6)
            _RGBForeColor
.L6:
            _SetPort
.L7:
            movem.l (SP)+,D3-D7/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            dc.w    $0134,$0464,$053A,$0046,$00F2,$05D2,$0684
sub_408769FA:
            move.l  ($D2C).w,-(SP)
            _SetPort
            movea.l WMgrPort,A0
            movea.l ($D2C).w,A1
            pea     ($20,A0)
            pea     ($3A,A0)
            lea     ($30,A0),A0
            lea     ($30,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            addq.w  #8,A0
            addq.w  #8,A1
            move.w  #$14,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            _PenPat
            _BackPat
            rts
            btst    #3,D6
            beq.b   sub_40876A6E.L1
            clr.b   ($71,A3)
            tst.w   ROM85
            bmi.b   sub_40876A6E.L1
            moveq   #$10,D0
            _NewHandleClear
            bne.b   sub_40876A6E.L1
            addq.b  #1,($71,A3)
            move.l  A0,($82,A3)
            movea.l (A0),A4
            addq.w  #8,A4
            movea.l (A5),A1
            move.l  (-$74,A1),(A4)+
            move.l  (-$70,A1),(A4)+
            moveq   #3,D0
            sub.w   D0,-(A4)
            sub.w   D0,-(A4)
            add.w   D0,-(A4)
            add.w   D0,-(A4)
            add.w   D7,(A4)
            add.w   D7,(A4)
            movea.l (A0),A4
sub_40876A6E:
            move.l  A4,-(SP)
            move.l  ($10,A3),(A4)
            move.l  ($14,A3),(4,A4)
            movea.l A3,A0
            bsr.w   sub_40876B12
            move.l  (6,A0),-(SP)
            neg.w   (SP)
            neg.w   (2,SP)
            _OffsetRect
.L1:
            rts
sub_40876A8E:
            subq.w  #8,SP
            movea.l SP,A4
            bsr.b   sub_40876A6E
            movea.l ($82,A3),A0
            movea.l (A0),A2
            addq.w  #8,A2
            bsr.b   sub_40876AB2
            bne.b   .L1
            bsr.b   sub_40876AB2
            beq.b   .L2
.L1:
            movea.l ($82,A3),A0
            movea.l (A0),A4
            bsr.b   sub_40876A6E
            moveq   #1,D0
.L2:
            addq.w  #8,SP
            rts
sub_40876AB2:
            move.l  (A2),-(SP)
            move.l  (A2)+,-(SP)
            move.l  SP,-(SP)
            move.l  #$FFF9FFF9,-(SP)
            _InsetRect
            clr.w   -(SP)
            move.l  (A4)+,-(SP)
            pea     (6,SP)
            _PtInRect
            subq.b  #1,(SP)
            move.b  (SP)+,D0
            addq.w  #8,SP
            rts
sub_40876AD2:
            btst    #3,D6
            beq.b   .L1
            tst.b   ($71,A3)
.L1:
            rts
            bsr.b   sub_40876AD2
            beq.b   .L2
            movea.l ($82,A3),A0
            _DisposHandle
.L2:
            rts
sub_40876AEA:
            move.l  D1,-(SP)
            movea.l (-$14,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
sub_40876B12:
            addq.w  #2,A0
            tst.w   (4,A0)
            bpl.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
            tst.b   ($6E,A3)
            beq.w   .L12
            cmpi.w  #4,D3
            bge.w   sub_40876CA6.L1
            _PenNormal
            tst.w   D5
            bne.w   sub_40876CEC.L3
            bsr.w   sub_40876CA6
            tst.b   (-$22,A6)
            beq.b   .L2
            move.w  #1,D0
            bsr.b   sub_40876AEA
            _RGBForeColor
            move.w  #4,D0
            bsr.b   sub_40876AEA
            _RGBBackColor
.L2:
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            _FrameRect
            move.l  OneOne,-(SP)
            _InsetRect
            _EraseRect
            bsr.w   sub_40876D26
            tst.b   ($6F,A3)
            beq.w   .L6
            tst.b   (-$22,A6)
            beq.b   .L3
            move.w  #4,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #3,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
.L3:
            pea     Scratch8
            move.w  #1,-(SP)
            move.w  (-2,A6),-(SP)
            _InsetRect
            move.w  ($A00).w,-(SP)
            move.w  D3,($A00).w
            move.l  Scratch8,D0
            andi.l  #$70007,D0
            movea.l (A5),A4
            move.l  D0,(-$A8,A4)
            pea     Scratch8
            pea     .L13
            _FillRect
            bsr.w   sub_40876AD2
            beq.b   .L4
            move.w  (SP),D0
            subi.w  #$1A,D0
            cmp.w   D4,D0
            bge.b   .L4
            move.w  D0,D4
.L4:
            move.w  (SP)+,($A00).w
            move.w  D4,($9FC).w
            pea     Scratch8
            pea     .L13
            _FillRect
            clr.l   (-$A8,A4)
            tst.b   ($70,A3)
            beq.b   .L5
            bsr.w   sub_40876CA6
            lea     sub_40876D26.L8,A1
            moveq   #0,D0
            bsr.w   sub_40876CEC
.L5:
            bsr.w   sub_40876AD2
            beq.b   .L6
            bsr.w   sub_40876CA6
            lea     sub_40876D26.L6,A1
            moveq   #0,D0
            bsr.w   sub_40876CD6
.L6:
            move.l  OneOne,D4
.L7:
            tst.b   (-$22,A6)
            beq.b   .L8
            moveq   #1,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
            moveq   #0,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
.L8:
            movea.l ($72,A3),A0
            movea.l (A0),A0
            lea     (2,A0),A4
            sub.w   D4,(4,A4)
            sub.w   D4,(6,A4)
            move.l  A4,-(SP)
            _FrameRect
            cmpi.w  #3,D5
            beq.b   .L9
            tst.w   D5
            bne.b   .L10
.L9:
            bsr.w   sub_40877018
.L10:
            cmpi.w  #1,D5
            bne.b   .L11
            move.l  (A4),Scratch8
            move.l  (4,A4),($9FE).w
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            move.l  #$70007,-(SP)
            _PenSize
            movea.l (A5),A0
            pea     (-8,A0)
            _PenPat
            _FrameRect
            movea.l (A5),A0
            pea     (-$10,A0)
            _PenPat
            move.l  #$20002,-(SP)
            move.l  (SP),-(SP)
            _PenSize
            _InsetRect
            pea     Scratch8
            _FrameRect
            _PenNormal
.L11:
            add.w   D4,(4,A4)
            add.w   D4,(6,A4)
.L12:
            rts
.L13:
            dc.w    $FF00,$FF00,$FF00,$FF00
sub_40876CA6:
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  (A0),D0
            add.w   D7,D0
            move.w  D0,(4,A0)
            subq.w  #1,(6,A0)
            rts
.L1:
            beq.b   sub_40876CD6.L1
            bsr.w   sub_40876AD2
            beq.b   sub_40876CEC.L2
            bsr.b   sub_40876CA6
            lea     sub_40876D26.L7,A1
            moveq   #2,D0
sub_40876CD6:
            lea     Scratch8,A0
            move.w  (6,A0),(2,A0)
            moveq   #-$16,D1
            bra.b   sub_40876CEC.L1
.L1:
            bsr.b   sub_40876CA6
            lea     sub_40876D26.L9,A1
            moveq   #2,D0
sub_40876CEC:
            lea     Scratch8,A0
            moveq   #7,D1
.L1:
            add.w   D1,(2,A0)
            move.w  (-2,A6),D1
            add.w   D1,(A0)
            subq.w  #1,(A0)
            move.l  (A0)+,(A0)
            moveq   #$10,D1
            add.w   D1,(A0)+
            add.w   D1,(A0)
            move.l  #$100010,D1
            bsr.w   sub_40877044
.L2:
            rts
.L3:
            move.l  #$20002,D4
            cmpi.w  #3,D5
            beq.w   sub_40876B12.L7
            moveq   #0,D4
            bra.w   sub_40876B12.L7
sub_40876D26:
            move.w  ($A00).w,D4
            move.w  D4,D3
            sub.w   ($9FC).w,D3
            sub.w   ($8A,A3),D3
            asr.w   #1,D3
            moveq   #2,D0
            tst.b   ($70,A3)
            beq.b   .L1
            moveq   #$20,D0
.L1:
            cmp.w   D0,D3
            bge.b   .L2
            move.w  D0,D3
.L2:
            add.w   ($9FC).w,D3
            move.w  D4,-(SP)
            bsr.w   sub_40876AD2
            beq.b   .L3
            subi.w  #$20,D4
.L3:
            move.l  (-$C,A6),-(SP)
            move.l  (SP),-(SP)
            _GetClip
            move.w  D4,($A00).w
            pea     Scratch8
            _ClipRect
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($1C,A0),-(SP)
            move.l  (SP),-(SP)
            _SectRgn
            move.w  (SP)+,($A00).w
            move.w  D3,-(SP)
            move.w  Scratch8,D0
            add.w   (-8,A6),D0
            addq.w  #1,D0
            move.w  D0,-(SP)
            _MoveTo
            tst.b   (-$22,A6)
            beq.b   .L4
            move.w  #4,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #2,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
            move.w  #1,-(SP)
            _TextMode
.L4:
            movea.l ($86,A3),A0
            _HLock
            move.l  (A0),-(SP)
            _DrawString
            movea.l ($86,A3),A0
            _HUnlock
            move.l  (-$C,A6),-(SP)
            _SetClip
            move.w  D3,D0
            subq.w  #6,D3
            add.w   ($8A,A3),D0
            cmp.w   D4,D0
            bge.b   .L5
            move.w  D0,D4
.L5:
            addq.w  #6,D4
            rts
.L6:
            ds.b    4
            dc.w    $BFFB,$2088,$A08B,$2088,$A08B,$2088,$BF8B,$2008
            dc.w    $A00B,$2008,$BFFB
            ds.b    6
.L7:
            ds.b    6
            dc.w    $0180,$09A0,$05C0,$0080,$1CF0,$1F80,$0540,$0920
            dc.b    $01
            ds.b    9
.L8:
            ds.b    4
            dc.w    $BFFB,$2008,$A00B,$2008,$A00B,$2008,$A00B,$2008
            dc.w    $A00B,$2008,$BFFB
            ds.b    6
.L9:
            ds.b    6
            dc.w    $0100,$0920,$0540,0,$1C70,0,$0540,$0920
            dc.b    $01
            ds.b    9
            dc.w    $4267,$2F03,$2F2B,$0076,$A8E8,$4A1F
            dc.b    'g8JEf.'
            dc.w    $0806,$0002,$6E28,$4A2B,$006F,$6722,$206B,$0076
            dc.w    $2050,$2028,$0006,$780E,$9044,$B640,$6D10,$4840
            dc.w    $9044,$4843,$B640,$6D06,$7003,$6000,$0092,$7001
            dc.w    $6000,$008C,$4A45,$6600,$008A,$6100,$FE08,$4267
            dc.w    $2F03,$2F08,$A8AD,$4A1F,$6778,$4A2B,$006F,$676C
            dc.w    $2003,$4840,$204B,$6100,$FC58,$D068,$0006,$906B
            dc.w    $0010,$D06E,$FFFE,$6A54,$0640,$000B,$6B4E,$4A2B
            dc.w    $0070,$6718,$2003,$D068,$0008,$906B,$0012,$0C40
            dc.w    $0012,$6E08,$5140,$6B34,$7004,$6032,$6100,$FBE2
            dc.w    $672A,$3003,$204B,$6100,$FC18,$D068,$0008,$906B
            dc.w    $0016,$0C40,$FFED,$6D14,$0C40,$FFF7,$6E0E,$6100
            dc.w    $FB7C,$6704,$7006,$6006,$7005,$6002,$7002,$2D40
            dc.w    $0014,$4E75
            bsr.w   sub_40876AD2
            beq.b   .L10
            bsr.w   sub_40876A8E
.L10:
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  ($10,A3),(A0)+
            move.l  ($14,A3),(A0)
            movea.l A3,A0
            bsr.w   sub_40876B12
            move.l  (6,A0),-(SP)
            neg.w   (SP)
            neg.w   (2,SP)
            _OffsetRect
            move.l  ($76,A3),-(SP)
            pea     Scratch8
            _RectRgn
            move.l  #$20002,D4
            move.l  ($72,A3),-(SP)
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  MinusOne,-(SP)
            _InsetRect
            tst.w   D5
            bne.b   .L14
            move.w  D7,D0
            subq.w  #1,D0
            sub.w   D0,Scratch8
            lsr.l   #1,D4
.L11:
            _RectRgn
            tst.w   D5
            beq.b   .L12
            cmpi.w  #3,D5
            bne.b   .L13
.L12:
            move.l  (-$C,A6),-(SP)
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  D4,-(SP)
            _OffsetRect
            _RectRgn
            move.l  ($72,A3),-(SP)
            move.l  (-$C,A6),-(SP)
            move.l  ($72,A3),-(SP)
            _UnionRgn
.L13:
            rts
.L14:
            cmpi.w  #1,D5
            bne.b   .L11
            pea     Scratch8
            move.l  #$FFF9FFF9,-(SP)
            _InsetRect
            bra.b   .L11
            move.l  D3,-(SP)
            move.l  MinusOne,-(SP)
            _InsetRect
            movea.l D3,A3
            move.l  (A3),-(SP)
            move.w  D7,D0
            subq.w  #1,D0
            sub.w   D0,(A3)
            move.l  D3,-(SP)
            _FrameRect
            move.w  (2,A3),-(SP)
            move.w  (4,A3),-(SP)
            subi.w  #$10,(SP)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (6,A3),(2,SP)
            _LineTo
            move.l  (SP),(A3)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (6,A3),(2,SP)
            _LineTo
            move.w  (6,A3),-(SP)
            subi.w  #$10,(SP)
            move.w  (A3),-(SP)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (4,A3),(SP)
            _LineTo
            move.l  D3,-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            rts
sub_40877018:
            move.l  D4,-(SP)
            _PenSize
            move.w  (6,A4),D0
            move.w  D0,-(SP)
            move.w  (A4),-(SP)
            move.w  D0,-(SP)
            move.w  (4,A4),D0
            move.w  D0,-(SP)
            move.w  (2,A4),-(SP)
            move.w  D0,-(SP)
            add.w   D4,(2,SP)
            add.w   D4,(8,SP)
            _MoveTo
            _LineTo
            _LineTo
            _PenNormal
            rts
sub_40877044:
            lea     ($A0E).w,A0
            move.l  A1,(A0)+
            move.w  #2,(A0)+
            clr.l   (A0)+
            move.l  D1,(A0)
            pea     ($A0E).w
            movea.l (SP),A0
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
            movea.l (A5),A0
            move.l  (A0),-(SP)
            move.l  A3,-(SP)
            _SetPort
            tst.b   (-$22,A6)
            beq.b   .L1
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetForeColor
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetBackColor
            clr.w   D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #1,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
.L1:
            lea     Scratch8,A4
            move.l  ($14,A3),(4,A4)
            move.l  (4,A4),(A4)
            subi.w  #$F,(A4)
            subi.w  #$F,(2,A4)
            tst.b   ($6F,A3)
            beq.b   .L4
            lea     .L5,A1
            moveq   #0,D0
            move.l  #$100010,D1
            bsr.w   sub_40877044
.L2:
            move.w  (2,A4),-(SP)
            move.w  (SP),-(SP)
            move.w  ($10,A3),-(SP)
            _MoveTo
            move.w  ($14,A3),-(SP)
            _LineTo
            move.w  ($12,A3),-(SP)
            move.w  (A4),-(SP)
            _MoveTo
            move.w  ($16,A3),-(SP)
            move.w  (A4),-(SP)
            _LineTo
            tst.b   (-$22,A6)
            beq.b   .L3
            move.l  SP,-(SP)
            _RGBBackColor
            addq.w  #6,SP
            move.l  SP,-(SP)
            _RGBForeColor
            addq.w  #6,SP
.L3:
            _SetPort
            rts
.L4:
            pea     Scratch8
            _EraseRect
            bra.b   .L2
.L5:
            ds.b    6
            dc.w    $1FE0,$1020,$103E,$1022,$1022,$1022,$1022,$1FE2
            dc.w    $0402,$0402,$0402,$07FE
            ds.b    8

            EVEN
