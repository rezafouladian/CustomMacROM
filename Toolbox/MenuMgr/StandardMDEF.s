            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryMDEF_0

            IMPORT  BaseOfROM,RsrcEntryWDEF_1

            SECTION "StandardMDEF",CODE

RsrcEntryMDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'MDEF' 0 (3604 bytes) - Combo mask
            dc.l    RsrcEntryWDEF_1-BaseOfROM       ; Next entry
            dc.l    RsrcMDEF_0-BaseOfROM            ; Data
            dc.b    'MDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000E20,$00000104   ; Block header
RsrcMDEF_0:
            bra.b   .L1
            dc.w    0,$4D44,$4546,0,$000C
.L1:
            link.w  A6,#-$44
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($14,A6),A3
            movea.l A3,A0
            _HLock
            clr.w   (-$1C,A6)
            clr.w   (-$1E,A6)
            clr.w   (-$3C,A6)
            cmpi.w  #$3FFF,ROM85
            sls     (-$3C,A6)
            lea     .L3,A0
            move.w  ($18,A6),D0
            cmpi.w  #3,D0
            bhi.b   .L2
            cmpi.w  #0,D0
            bcs.b   .L2
            add.w   D0,D0
            adda.w  .L3(PC,D0.w),A0
            jsr     (A0)
.L2:
            movea.l A3,A0
            _HUnlock
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($12,SP),SP
            jmp     (A0)
.L3:
            dc.w    $04D6,$0008,$09DA,$0AD2,$6100,$029E,$286E,$0008
            dc.w    $3614,$4254,$246E,$0010,$2D52,$FFCC,$2D6A,$0004
            dc.w    $FFD0,$42AE,$FFC8,$302E,$FFFE,$E240,$3D40,$FFC6
            dc.w    $426E,$FFE0,$3003,$2053,$6100,$0960,$0C29,$001B
            dc.w    $0001,$6606,$3D7C,$0001,$FFE0,$3838,$0A0A,$2A2E
            dc.w    $000C,$6700,$0192,$3038,$0A0C,$B06A,$0004,$6F08
            dc.w    $302E,$FFFE,$916A,$0004,$3038,$0A0A,$B052,$6C06
            dc.w    $302E,$FFFE,$D152,$4267,$2F05,$2F0A,$A8AD,$4A1F
            dc.w    $6600,$010A,$BA6A,$0002,$6D00,$015C,$BA6A,$0006
            dc.w    $6E00,$0154,$3E2E,$FFFE,$4845,$BA52,$6C00,$00AA
            dc.w    $D847,$B852,$6E00,$0140,$3012,$9045,$B06E,$FFC6
            dc.w    $6E08,$2D7C,0,$000A,$FFC8,$3038,$0A0C,$B06A
            dc.w    $0004,$6E18,$D06E,$FFFE,$B06A,$0004,$6F0E,$204A
            dc.w    $6100,$048E,$302E,$FFFE,$916A,$0004,$3003,$6100
            dc.w    $0298,$2078,$0B5C,$2050,$4A68,$0010,$6608,$317C
            dc.w    $0001,$0010,$604A,$31C4,$0A0A,$42A7,$A8D8,$2C17
            dc.w    $42A7,$A8D8,$6100,$0B0E,$3D7C,$000A,$FFE6,$6100
            dc.w    $0B5A,$6100,$0104,$2F0A,$4267,$3F07,$2F06,$A8EF
            dc.w    $6100,$013A,$6100,$0B22,$2F17,$A87A,$2F06,$A879
            dc.w    $6100,$034E,$DF78,$0A0C,$2F17,$A879,$A8D9,$A8D9
            dc.w    $4278,$0B56,$6000,$00C6,$302A,$0004,$BA40,$6D00
            dc.w    $0096,$B078,$0A0C,$6C00,$008E,$4447,$D847,$3005
            dc.w    $906A,$0004,$B06E,$FFC6,$6E08,$2D7C,0,$000A
            dc.w    $FFC8,$3038,$0A0A,$B052,$6600,$FF62,$204A,$6100
            dc.w    $040A,$302E,$FFFE,$D152,$6000,$FF52,$B852,$6F06
            dc.w    $B86E,$000C,$6E50,$3404,$7801,$2053,$3004,$6100
            dc.w    $07FA,$6742,$6100,$019E,$D440,$B46E,$000C,$6E04
            dc.w    $5244,$60E6,$41F8,$09FA,$226E,$0010,$2099,$2151
            dc.w    $0004,$3142,$0004,$9440,$3082,$2078,$0B5C,$2050
            dc.w    $2178,$09FA,$0006,$2178,$09FE,$000A,$6100,$0178
            dc.w    $6706,$3884,$6002,$4244,$B654,$6714,$3003,$6100
            dc.w    $0188,$3014,$466E,$FFE4,$6100,$017E,$426E,$FFE4
            dc.w    $2053,$4844,$3810,$4844,$21C4,$0B54,$24AE,$FFCC
            dc.w    $256E,$FFD0,$0004,$4E75
            tst.l   (-$38,A6)
            beq.b   .L8
            move.l  D3,-(SP)
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,D3
            add.l   (-$38,A6),D3
.L4:
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP)+,D5
            swap    D5
            tst.w   D7
            bge.b   .L5
            move.w  D5,D0
            sub.w   (4,A2),D0
            cmp.w   (-$3A,A6),D0
            bgt.b   .L7
            bra.b   .L6
.L5:
            move.w  (A2),D0
            sub.w   D5,D0
            cmp.w   (-$3A,A6),D0
            bgt.b   .L7
.L6:
            subq.w  #4,SP
            _TickCount
            cmp.l   (SP)+,D3
            bgt.b   .L4
.L7:
            move.l  (SP)+,D3
.L8:
            rts
            tst.w   D7
            bge.b   .L10
            move.w  D7,D0
            neg.w   D0
            add.w   (-2,A6),D0
            add.w   (4,A2),D0
            cmp.w   ($A0C).w,D0
            blt.b   .L9
            movea.l D6,A0
            movea.l (A0),A0
            move.w  (-2,A6),D0
            add.w   D0,(6,A0)
            add.w   D0,(4,A2)
            move.l  D6,-(SP)
            _EraseRgn
.L9:
            rts
.L10:
            move.w  (A2),D0
            sub.w   (-2,A6),D0
            cmp.w   ($A0A).w,D0
            bgt.b   .L11
            movea.l D6,A0
            movea.l (A0),A0
            move.w  (-2,A6),D0
            sub.w   D0,(2,A0)
            sub.w   D0,(A2)
            move.l  D6,-(SP)
            _EraseRgn
.L11:
            rts
sub_40877998:
            lea     (-8,A6),A2
            move.l  A2,-(SP)
            _GetFontInfo
            move.w  (A2)+,D0
            add.w   (A2)+,D0
            tst.w   ROM85
            bmi.b   .L1
            tst.w   SysFontFam
            bne.b   .L2
.L1:
            tst.w   CurFMInput
            bne.b   .L2
            subq.w  #2,(A2)
.L2:
            addq.w  #2,A2
            add.w   D0,(A2)
            subq.l  #2,SP
            move.w  #$20,-(SP)
            _CharWidth
            move.w  (SP)+,(-$A,A6)
            rts
sub_408779CA:
            cmpi.b  #$1C,(1,A1)
            beq.b   .L1
            tst.b   (A1)
            bne.b   .L2
.L1:
            moveq   #0,D1
            rts
.L2:
            tst.b   (-$3C,A6)
            beq.b   .L3
            subq.l  #4,SP
            move.l  #'cicn',-(SP)
            move.w  #$100,D0
            move.b  (A1),D0
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D1
            beq.b   .L3
            move.l  D1,-(SP)
            _LoadResource
            movea.l D1,A0
            movea.l (A0),A0
            move.l  ($A,A0),D1
            sub.l   (6,A0),D1
            bra.b   .L4
.L3:
            move.l  #$200020,D1
.L4:
            cmpi.b  #$1D,(1,A1)
            beq.b   .L5
            cmpi.b  #$1E,(1,A1)
            bne.b   .L6
.L5:
            lsr.l   #1,D1
            bclr    #$F,D1
.L6:
            rts
sub_40877A26:
            movem.l A1,-(SP)
            movea.l A4,A1
            bsr.b   sub_40877A34
            movem.l (SP)+,A1
            rts
sub_40877A34:
            bsr.b   sub_408779CA
            swap    D1
            move.w  (-2,A6),D0
            addq.w  #4,D1
            cmp.w   D0,D1
            blt.b   .L1
            move.w  D1,D0
.L1:
            rts
sub_40877A46:
            movea.l (A3),A0
            move.l  ($A,A0),D0
            cmpi.w  #$1F,D4
            bgt.b   .L1
            btst    D4,D0
            beq.b   .L2
.L1:
            btst    #0,D0
            beq.b   .L2
            move.w  D4,D0
            bsr.w   sub_4087808A
            bsr.w   sub_40877D2A
.L2:
            rts
sub_40877A68:
            movem.l D3-D4,-(SP)
            move.w  D0,D3
            beq.w   .L5
            move.w  ($A0A).w,D2
            moveq   #1,D4
.L1:
            move.w  D4,D0
            movea.l (A3),A0
            bsr.w   sub_4087808A
            beq.w   .L5
            bsr.b   sub_40877A34
            cmp.b   D3,D4
            beq.b   .L2
            add.w   D0,D2
            addq.w  #1,D4
            bra.b   .L1
.L2:
            move.b  (1,A0),D1
            lea     Scratch8,A0
            movea.l ($10,A6),A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  D2,(A0)
            add.w   D0,D2
            move.w  D2,(4,A0)
            movem.l D3-D7/A2-A4,-(SP)
            move.w  #1,-(SP)
            _TextMode
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),-(SP)
            _GetClip
            subq.w  #2,SP
            move.l  ($10,A6),-(SP)
            pea     Scratch8
            pea     (-$2C,A6)
            _SectRect
            addq.w  #2,SP
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            subq.w  #2,SP
            pea     ($10,A0)
            pea     (-$2C,A6)
            pea     (-$2C,A6)
            _SectRect
            addq.w  #2,SP
            pea     (-$2C,A6)
            _ClipRect
            tst.w   (-$1E,A6)
            bne.b   .L3
            tst.w   (-$3C,A6)
            bne.b   .L3
            tst.w   (-$20,A6)
            bne.b   .L3
            pea     Scratch8
            _InverRect
            bra.b   .L4
.L3:
            bsr.w   sub_40878304
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            pea     Scratch8
            _EraseRect
            bsr.w   sub_40878338
            lea     Scratch8,A0
            move.w  (A0),D3
            add.w   (-8,A6),D3
            bsr.w   sub_40877D3C
.L4:
            move.l  (SP),-(SP)
            _SetClip
            _DisposRgn
            movem.l (SP)+,D3-D7/A2-A4
.L5:
            movem.l (SP)+,D3-D4
            rts
sub_40877B3E:
            move.l  A0,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            _PaintRect
            _PenNormal
            rts
sub_40877B5E:
            move.w  D5,D2
            add.w   D0,D5
            tst.b   ($BAD).w
            bpl.b   .L1
            sub.w   D0,D6
            sub.w   D0,D5
            move.w  D6,D2
.L1:
            rts
            move.w  D4,D2
            moveq   #1,D4
            tst.w   D7
            bge.b   .L2
            move.w  (4,A2),D3
            subq.w  #1,D3
            bra.b   .L3
.L2:
            move.w  (A2),D3
            addq.w  #1,D3
.L3:
            movea.l (A3),A0
            move.w  D4,D0
            bsr.w   sub_4087808A
            beq.b   .L4
            bsr.w   sub_40877A34
            add.w   D0,D2
            cmp.w   D3,D2
            bgt.b   .L5
            addq.w  #1,D4
            bra.b   .L3
.L4:
            subq.w  #1,D4
.L5:
            move.w  D4,D0
            move.w  #1,(-$1E,A6)
            bsr.w   sub_40877A68
            tst.w   D7
            bge.b   .L6
            subq.w  #1,D4
            move.w  D4,D0
            bsr.w   sub_40877A68
            bra.b   .L7
.L6:
            addq.w  #1,D4
            move.w  D4,D0
            bsr.w   sub_40877A68
.L7:
            clr.w   (-$1E,A6)
            rts
            bsr.w   sub_40877998
            movea.l ($10,A6),A0
            clr.w   ($A0C).w
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.w   ($10,A0)
            bsr.b   sub_40877BE2
            bsr.b   sub_40877C30
            rts
sub_40877BE2:
            movem.l D3-D7/A2-A4,-(SP)
            moveq   #1,D4
            move.w  ($A0A).w,D3
            add.w   (-8,A6),D3
            clr.l   -(SP)
            _TextFace
            _TextFont
            move.w  #1,-(SP)
            _TextMode
.L1:
            movea.l ($10,A6),A0
            bsr.w   sub_40877D3C
            beq.b   .L3
            cmpi.b  #$1C,(1,A4)
            beq.b   .L2
            tst.b   (A4)
            beq.b   .L2
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D7
            add.w   D7,D3
.L2:
            add.w   (-2,A6),D3
            addq.w  #1,D4
            bra.b   .L1
.L3:
            sub.w   (-8,A6),D3
            move.w  D3,($A0C).w
            movem.l (SP)+,D3-D7/A2-A4
            rts
sub_40877C30:
            movea.l ($10,A6),A0
            move.w  ($A0C).w,D0
            cmp.w   (4,A0),D0
            ble.b   .L1
            bsr.b   sub_40877C50
.L1:
            movea.l ($10,A6),A0
            move.w  ($A0A).w,D0
            cmp.w   (A0),D0
            bge.b   .L2
            bsr.b   sub_40877C7A
.L2:
            rts
sub_40877C50:
            movem.l D4/A3-A4,-(SP)
            move.w  (4,A0),(-$28,A6)
            move.w  (4,A0),(-$2C,A6)
            move.w  (-2,A6),D0
            sub.w   D0,(-$2C,A6)
            move.w  (2,A0),(-$2A,A6)
            move.w  (6,A0),(-$26,A6)
            lea     sub_40878400.L3,A4
            bra.b   sub_40877C7A.L1
sub_40877C7A:
            movem.l D4/A3-A4,-(SP)
            move.w  (A0),(-$2C,A6)
            move.w  (A0),(-$28,A6)
            move.w  (-2,A6),D0
            add.w   D0,(-$28,A6)
            move.w  (2,A0),(-$2A,A6)
            move.w  (6,A0),(-$26,A6)
            lea     sub_40878400.L4,A4
.L1:
            bsr.w   sub_40878304
            move.w  #$FFFF,D4
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            pea     (-$2C,A6)
            _EraseRect
            moveq   #$E,D0
            _NewHandle
            _HLock
            movea.l (A0),A3
            move.w  #2,(4,A3)
            clr.l   (6,A3)
            move.l  #$100010,($A,A3)
            move.l  A4,(A3)
            move.w  (-4,A6),D0
            add.w   (-$2A,A6),D0
            move.w  D0,(-$2A,A6)
            move.w  D0,(-$26,A6)
            moveq   #$10,D0
            cmp.w   (-2,A6),D0
            bge.b   .L2
            move.w  (-2,A6),D0
.L2:
            add.w   D0,(-$26,A6)
            move.w  (-$2C,A6),(-$28,A6)
            add.w   D0,(-$28,A6)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.l  A3,-(SP)
            pea     (2,A0)
            pea     (6,A3)
            pea     (-$2C,A6)
            move.w  #1,-(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l A3,A0
            _RecoverHandle
            _DisposHandle
            movem.l (SP)+,D4/A3-A4
            bsr.w   sub_40878338
            rts
sub_40877D2A:
            cmpi.b  #$2D,(1,A0)
            bne.b   .L1
            tst.b   (A1)
            bne.b   .L1
            tst.b   (1,A1)
.L1:
            rts
sub_40877D3C:
            move.w  (2,A0),D5
            move.w  (6,A0),D6
            move.w  D4,D0
            movea.l (A3),A0
            bsr.w   sub_4087808A
            beq.w   .L21
            movea.l A0,A2
            movea.l A1,A4
            bsr.w   sub_40878304
            movea.l A2,A0
            movea.l A4,A1
            bsr.b   sub_40877D2A
            bne.b   .L1
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  D3,-(SP)
            move.w  D5,-(SP)
            move.w  (-2,A6),D0
            lsr.w   #1,D0
            sub.w   (-8,A6),D0
            add.w   D0,D3
            move.w  D3,-(SP)
            _MoveTo
            move.w  D6,-(SP)
            move.w  D3,-(SP)
            _LineTo
            move.w  (SP)+,D3
            _PenNormal
            bra.w   .L20
.L1:
            addq.w  #2,D5
            cmpi.b  #$1C,(1,A4)
            beq.b   .L2
            move.b  (A4),D0
            beq.b   .L2
            bsr.w   sub_40877A26
            sub.w   (-2,A6),D0
            move.w  D0,D7
            lsr.w   #1,D0
            add.w   D0,D3
.L2:
            move.w  (-4,A6),D0
            bsr.w   sub_40877B5E
            cmpi.b  #$1B,(1,A4)
            beq.b   .L3
            tst.b   (2,A4)
            beq.b   .L3
            move.w  D2,-(SP)
            move.w  D3,-(SP)
            _MoveTo
            move.w  #4,(-$1A,A6)
            bsr.w   sub_4087835A
            clr.w   D0
            move.b  (2,A4),D0
            move.w  D0,-(SP)
            _DrawChar
.L3:
            movea.l A4,A1
            bsr.w   sub_408779CA
            tst.l   D1
            beq.w   .L12
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            move.w  D3,D1
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D1
            sub.w   (-8,A6),D1
            addq.w  #2,D1
            move.l  (SP)+,D0
            move.w  D1,(A0)+
            move.w  D5,D2
            tst.b   ($BAD).w
            bpl.b   .L4
            move.w  D6,D2
            sub.w   D0,D2
.L4:
            move.w  D2,(A0)+
            move.l  (-4,A0),(A0)
            add.l   D0,(A0)
            add.w   (-$A,A6),D0
            bsr.w   sub_40877B5E
            tst.b   (-$3C,A6)
            beq.b   .L8
            subq.w  #4,SP
            move.w  #$100,D0
            move.b  (A4),D0
            move.w  D0,-(SP)
            _GetCIcon
            move.l  (SP)+,(-$24,A6)
            beq.b   .L8
            cmpi.w  #4,(-$18,A6)
            blt.b   .L5
            pea     RGBBlack
            _RGBForeColor
            pea     RGBWhite
            _RGBBackColor
            bra.b   .L7
.L5:
            pea     RGBBlack
            pea     RGBWhite
            tst.w   (-$1C,A6)
            bne.b   .L6
            _RGBBackColor
            _RGBForeColor
            bra.b   .L7
.L6:
            _RGBForeColor
            _RGBBackColor
.L7:
            move.l  (-$24,A6),-(SP)
            _PlotCIcon
            move.l  (-$24,A6),-(SP)
            _DisposCIcon
            bra.b   .L12
.L8:
            cmpi.b  #$1E,(1,A4)
            bne.b   .L9
            clr.l   -(SP)
            move.l  #'SICN',-(SP)
            bra.b   .L10
.L9:
            clr.l   -(SP)
            move.l  #'ICON',-(SP)
.L10:
            move.w  #$100,D0
            move.b  (A4),D0
            move.w  D0,-(SP)
            _GetResource
            move.l  #$100010,D0
            moveq   #2,D1
            cmpi.b  #$1E,(1,A4)
            beq.b   .L11
            add.l   D0,D0
            add.l   D1,D1
.L11:
            move.l  D0,-(SP)
            move.w  D1,-(SP)
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            bsr.w   sub_40878400
.L12:
            tst.b   (1,A4)
            beq.b   .L16
            cmpi.b  #$1C,(1,A4)
            beq.b   .L16
            cmpi.b  #$1D,(1,A4)
            beq.b   .L16
            cmpi.b  #$1E,(1,A4)
            beq.b   .L16
            move.w  #$10,(-$1A,A6)
            bsr.w   sub_4087835A
            move.w  (-4,A6),D0
            add.w   D0,D0
            sub.w   D0,D6
            move.w  D6,-(SP)
            tst.b   ($BAD).w
            bpl.b   .L13
            addq.w  #2,D5
            move.w  D5,(SP)
            add.w   D0,D5
            add.w   D0,D6
.L13:
            move.w  D3,-(SP)
            _MoveTo
            cmpi.b  #$1B,(1,A4)
            bne.b   .L14
            bsr.w   sub_4087800E
            bra.b   .L16
.L14:
            move.b  ($BAD).w,D1
            ext.w   D1
            bne.b   .L15
            move.w  #$11,-(SP)
            _DrawChar
            clr.w   D0
            move.b  (1,A4),D0
            move.w  D0,-(SP)
            _DrawChar
            bra.b   .L16
.L15:
            clr.w   D0
            move.b  (1,A4),D0
            move.w  D0,-(SP)
            _DrawChar
            move.w  #$11,-(SP)
            _DrawChar
.L16:
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            clr.w   D0
            move.b  (3,A4),D0
            move.w  D0,-(SP)
            _TextFace
            cmpi.b  #$1C,(1,A4)
            bne.b   .L17
            move.b  (A4),D0
            bsr.w   sub_40877FF0
.L17:
            move.b  ($BAD).w,D1
            ext.w   D1
            bne.b   .L18
            move.w  D5,-(SP)
            move.w  D3,-(SP)
            _MoveTo
            move.l  A2,-(SP)
            _DrawString
            bra.b   .L19
.L18:
            lea     Scratch8,A0
            subq.w  #1,D5
            move.w  D3,(A0)
            move.w  (-8,A6),D0
            sub.w   D0,(A0)+
            move.w  D5,(A0)+
            move.w  D3,(A0)
            move.w  (-6,A6),D0
            add.w   D0,(A0)+
            move.w  D6,(A0)
            moveq   #0,D0
            move.b  (A2)+,D0
            move.l  A2,-(SP)
            move.l  D0,-(SP)
            pea     Scratch8
            move.w  D1,-(SP)
            _TETextBox
.L19:
            clr.l   -(SP)
            _TextFace
            _TextFont
            bsr.w   sub_40877A46
            bne.b   .L20
            bsr.b   sub_40877FB2
.L20:
            bsr.w   sub_40878338
            moveq   #1,D0
.L21:
            rts
sub_40877FB2:
            movem.l D3/D7,-(SP)
            tst.b   (A4)
            beq.b   .L1
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D7
            add.w   D7,D3
.L1:
            add.w   (-2,A6),D3
            lea     Scratch8,A0
            movea.l ($10,A6),A1
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            sub.w   (-8,A6),D3
            move.w  D3,(4,A0)
            bsr.w   sub_40877A26
            sub.w   D0,D3
            move.w  D3,(A0)
            bsr.w   sub_40877B3E
            movem.l (SP)+,D3/D7
            rts
sub_40877FF0:
            clr.l   -(SP)
            andi.w  #$FF,D0
            move.w  D0,-(SP)
            move.w  #$C,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            blt.b   .L1
            move.w  D0,-(SP)
            _TextFont
.L1:
            rts
sub_4087800E:
            movem.l D4/A3,-(SP)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPen
            move.l  (SP)+,D4
            swap    D4
            sub.w   (-8,A6),D4
            swap    D4
            move.l  D4,(-$2C,A6)
            move.l  D4,(-$28,A6)
            move.w  (-2,A6),D4
            cmpi.w  #$10,D4
            ble.b   .L1
            move.w  #$10,D4
.L1:
            add.w   D4,(-$28,A6)
            add.w   D4,(-$26,A6)
            moveq   #$E,D0
            _NewHandle
            _HLock
            movea.l (A0),A3
            move.w  #2,(4,A3)
            clr.l   (6,A3)
            move.l  #$100010,($A,A3)
            lea     sub_40878400.L2,A1
            move.l  A1,(A3)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.l  A3,-(SP)
            pea     (2,A0)
            pea     (6,A3)
            pea     (-$2C,A6)
            move.w  #1,-(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l A3,A0
            _RecoverHandle
            _DisposHandle
            movem.l (SP)+,D4/A3
            rts
sub_4087808A:
            tst.w   D0
            ble.b   .L2
            moveq   #0,D1
            lea     ($E,A0),A1
            move.b  (A1)+,D1
            adda.w  D1,A1
.L1:
            subq.w  #1,D0
            beq.b   .L3
            move.b  (A1)+,D1
            beq.b   .L2
            addq.w  #4,D1
            adda.w  D1,A1
            bra.b   .L1
.L2:
            suba.l  A0,A0
            movea.l A0,A1
            move.l  A0,D0
            clr.l   (-$40,A6)
            clr.l   (-$44,A6)
            rts
.L3:
            tst.b   (A1)
            beq.b   .L2
            movea.l A1,A0
            move.b  (A1)+,D1
            adda.w  D1,A1
            move.l  A0,(-$40,A6)
            move.l  A1,(-$44,A6)
            rts
            clr.w   -(SP)
            _TextFont
            bsr.w   sub_40877998
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.w  ($14,A0),D5
            sub.w   ($10,A0),D5
            tst.w   ROM85
            bmi.b   .L4
            sub.w   MBarHeight,D5
            bne.b   .L5
.L4:
            subi.w  #$14,D5
.L5:
            subi.w  #$10,D5
            moveq   #0,D6
            moveq   #1,D0
            movea.l (A3),A0
            bsr.b   sub_4087808A
            beq.w   .L13
            movea.l A0,A4
.L6:
            moveq   #0,D7
            movea.l (A3),A0
            moveq   #0,D0
            move.b  (A4),D0
            beq.w   .L12
            lea     (1,A4,D0.w),A1
            bsr.w   sub_40877A34
            swap    D1
            move.w  D1,D7
            add.w   (-$A,A6),D7
            swap    D6
            add.w   D0,D6
            cmp.w   D5,D6
            blt.b   .L7
            sub.w   D0,D6
.L7:
            swap    D6
            move.w  (-4,A6),D1
            add.w   D1,D7
            cmpi.b  #$1C,(1,A1)
            beq.b   .L8
            cmpi.b  #$1D,(1,A1)
            beq.b   .L8
            cmpi.b  #$1E,(1,A1)
            beq.b   .L8
            tst.b   (1,A1)
            beq.b   .L8
            add.w   D1,D7
            add.w   D1,D7
            addq.w  #8,D7
.L8:
            moveq   #0,D1
            move.b  (3,A1),D1
            move.w  D1,-(SP)
            _TextFace
            cmpi.b  #$1C,(1,A1)
            bne.b   .L9
            move.b  (A1),D0
            bsr.w   sub_40877FF0
            clr.w   -(SP)
            move.l  A4,-(SP)
            _StringWidth
            clr.w   -(SP)
            _TextFont
            bra.b   .L10
.L9:
            clr.w   -(SP)
            move.l  A4,-(SP)
            _StringWidth
.L10:
            add.w   (SP)+,D7
            cmp.w   D7,D6
            bge.b   .L11
            move.w  D7,D6
.L11:
            moveq   #0,D0
            move.b  (A4),D0
            lea     (5,A4,D0.w),A4
            bra.w   .L6
.L12:
            addq.w  #4,D6
.L13:
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.w  ($16,A0),D0
            sub.w   ($12,A0),D0
            subi.w  #$10,D0
            cmp.w   D0,D6
            ble.b   .L14
            move.w  D0,D6
.L14:
            movea.l (A3),A0
            move.w  D6,(2,A0)
            swap    D6
            move.w  D6,(4,A0)
            clr.w   -(SP)
            _TextFace
            rts
            bsr.w   sub_40877998
            movea.l (8,A6),A4
            move.w  (A4),D3
            clr.w   D2
            clr.w   D6
            moveq   #1,D4
.L15:
            cmp.w   D3,D4
            bgt.b   .L16
            move.w  D6,D2
.L16:
            movea.l (A3),A0
            move.w  D4,D0
            bsr.w   sub_4087808A
            beq.b   .L17
            bsr.w   sub_40877A34
            add.w   D0,D6
            addq.w  #1,D4
            bra.b   .L15
.L17:
            tst.w   D2
            bne.b   .L18
            moveq   #1,D4
.L18:
            movea.l (A3),A0
            tst.l   (2,A0)
            bpl.b   .L19
            move.l  D2,-(SP)
            move.l  A3,-(SP)
            _CalcMenuSize
            move.l  (SP)+,D2
.L19:
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A1
            movea.l ($10,A6),A0
            movea.l (A3),A2
            move.w  ($E,A6),D5
            move.w  D5,D4
            sub.w   D2,D4
            cmpi.w  #0,D3
            bne.b   .L20
            move.w  ($14,A1),D0
            sub.w   D5,D0
            subq.w  #8,D0
            cmp.w   D6,D0
            blt.b   .L25
            bra.b   .L21
.L20:
            move.w  ($14,A1),D0
            sub.w   ($10,A1),D0
            subq.w  #8,D0
            cmp.w   D6,D0
            blt.b   .L25
.L21:
            move.w  D4,(A0)
            move.w  D4,(A4)
            move.w  D4,(4,A0)
            add.w   D6,(4,A0)
            move.w  ($10,A1),D0
            add.w   MBarHeight,D0
            addq.w  #2,D0
            cmp.w   D0,D4
            bge.b   .L23
            move.w  D4,D1
.L22:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            blt.b   .L22
            move.w  D1,(A0)
            add.w   D6,D1
            move.w  D1,(4,A0)
            bra.b   .L31
.L23:
            move.w  D4,D0
            add.w   D6,D0
            move.w  ($14,A1),D1
            subq.w  #5,D1
            cmp.w   D1,D0
            ble.b   .L31
.L24:
            sub.w   (-2,A6),D0
            cmp.w   D1,D0
            bgt.b   .L24
            move.w  D0,(4,A0)
            sub.w   D6,D0
            move.w  D0,(A0)
            bra.b   .L31
.L25:
            move.w  D4,(A4)
            move.w  D4,D1
            move.w  D1,(A0)
            cmpi.w  #0,D3
            beq.b   .L29
            move.w  ($10,A1),D0
            addq.w  #2,D0
            cmp.w   D0,D4
            ble.b   .L27
            move.w  D4,D1
.L26:
            sub.w   (-2,A6),D1
            cmp.w   D0,D1
            bge.b   .L26
            add.w   (-2,A6),D1
            move.w  D1,(A0)
            bra.b   .L29
.L27:
            move.w  D4,D1
.L28:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            blt.b   .L28
            move.w  D1,(A0)
.L29:
            move.w  ($14,A1),D0
            subq.w  #5,D0
.L30:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            ble.b   .L30
            sub.w   (-2,A6),D1
            move.w  D1,(4,A0)
.L31:
            move.w  ($C,A6),D0
            move.w  ($12,A1),D2
            addq.w  #4,D2
            cmp.w   D2,D0
            bge.b   .L32
            move.w  D2,D0
.L32:
            move.w  D0,D1
            add.w   (2,A2),D1
            move.w  ($16,A1),D2
            subq.w  #4,D2
            cmp.w   D2,D1
            ble.b   .L33
            move.w  D2,D1
            move.w  D1,D0
            sub.w   (2,A2),D0
.L33:
            move.w  D0,(2,A0)
            move.w  D1,(6,A0)
            rts
sub_40878304:
            tst.b   (-$3C,A6)
            beq.b   .L1
            pea     (-$10,A6)
            pea     (-$16,A6)
            _GetBackColor
            _GetForeColor
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            subq.w  #4,SP
            pea     ($10,A0)
            _GetMaxDevice
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            move.w  ($20,A1),(-$18,A6)
.L1:
            rts
sub_40878338:
            tst.b   (-$3C,A6)
            beq.b   .L1
            pea     (-$10,A6)
            pea     (-$16,A6)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            moveq   #$21,D0
            move.l  D0,-(SP)
            _ForeColor
            moveq   #$1E,D0
            move.l  D0,-(SP)
            _BackColor
.L2:
            rts
sub_4087835A:
            tst.b   (-$3C,A6)
            beq.w   .L7
            cmpi.w  #2,(-$18,A6)
            blt.b   .L4
            tst.w   (-$1C,A6)
            beq.b   .L1
            move.w  #$A,(-$1A,A6)
.L1:
            subq.w  #4,SP
            movea.l (A3),A0
            move.w  (A0),-(SP)
            move.w  D4,-(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L2
            movea.l D1,A0
            move.w  (-$1A,A6),D0
            pea     (0,A0,D0.w)
            pea     ($16,A0)
            bra.b   .L5
.L2:
            subq.w  #4,SP
            movea.l (A3),A0
            move.w  (A0),-(SP)
            clr.w   -(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L3
            movea.l D1,A0
            move.w  #$10,D0
            pea     (0,A0,D0.w)
            pea     ($16,A0)
            bra.b   .L5
.L3:
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L4
            movea.l D1,A0
            move.w  #$10,D0
            pea     (0,A0,D0.w)
            pea     ($A,A0)
            bra.b   .L5
.L4:
            pea     RGBBlack
            pea     RGBWhite
.L5:
            tst.w   (-$1C,A6)
            beq.b   .L6
            _RGBForeColor
            _RGBBackColor
            bra.b   .L9
.L6:
            _RGBBackColor
            _RGBForeColor
            bra.b   .L9
.L7:
            moveq   #$21,D0
            move.l  D0,-(SP)
            moveq   #$1E,D0
            move.l  D0,-(SP)
            tst.w   (-$1C,A6)
            beq.b   .L8
            _ForeColor
            _BackColor
            bra.b   .L9
.L8:
            _BackColor
            _ForeColor
.L9:
            rts
sub_40878400:
            lea     ($A0E).w,A1
            move.l  ($A,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(A1)+
            move.w  (4,SP),(A1)+
            clr.l   (A1)+
            move.l  (6,SP),(A1)
            move.l  ($E,SP),D1
            lea     ($A0E).w,A1
            move.l  A1,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (2,A0)
            pea     (6,A1)
            move.l  D1,-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
.L1:
            movea.l (SP)+,A0
            lea     ($E,SP),SP
            jmp     (A0)
.L2:
            ds.b    5
            dc.b    $20,$00,$30,$00,$38,$00,$3C,$00,$3E,$00,$3F,$00,$3E,$00,$3C,$00
            dc.b    $38,$00,$30,$00,$20
            ds.b    6
.L3:
            ds.b    10
            dc.b    $7F,$F0,$3F,$E0,$1F,$C0,$0F,$80,$07,$00,$02
            ds.b    11
.L4:
            ds.b    10
            dc.w    $0200,$0700,$0F80,$1FC0,$3FE0,$7FF0
            ds.b    12

            EVEN
