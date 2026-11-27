            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryMBDF_0

            IMPORT  BaseOfROM,RsrcEntryMDEF_0

            SECTION "StandardMBDF",CODE

RsrcEntryMBDF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'MBDF' 0 (3524 bytes) - Combo mask
            dc.l    RsrcEntryMDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcMBDF_0-BaseOfROM            ; Data
            dc.b    'MBDF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000DD0,$000000FC   ; Block header
RsrcMBDF_0:
            bra.b   .L1
            dc.w    0,$4D42,$4446,0,$000C
.L1:
            link.w  A6,#-$42
            movem.l D3-D5/A2-A4,-(SP)
            movea.l (A5),A0
            move.l  (A0),-(SP)
            clr.w   (-$3A,A6)
            cmpi.w  #$3FFF,ROM85
            sls     (-$3A,A6)
            movea.l ROMBase,A0
            cmpi.b  #3,(8,A0)
            bne.b   .L2
            tst.b   NTSC
            bne.b   .L2
            bset    #7,(-$39,A6)
.L2:
            tst.b   (-$3A,A6)
            beq.b   .L3
            movea.l ($D2C).w,A2
            bra.b   .L4
.L3:
            movea.l WMgrPort,A2
.L4:
            move.l  A2,-(SP)
            _SetPort
            clr.l   -(SP)
            _TextFont
            _TextFace
            movea.l MenuList,A0
            tst.l   (A0)
            bne.b   .L5
            moveq   #$54,D0
            _SysError
.L5:
            _HLock
            movea.l (A0),A3
            lea     .L7,A0
            move.w  ($E,A6),D0
            cmpi.w  #$D,D0
            bhi.b   .L6
            cmpi.w  #0,D0
            bcs.b   .L6
            add.w   D0,D0
            adda.w  .L7(PC,D0.w),A0
            jsr     (A0)
.L6:
            _SetPort
            movea.l MenuList,A0
            _HUnlock
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$A,SP
            jmp     (A0)
.L7:
            dc.w    $009A,$03BE,$0446,$0026,$0046,$048A,$0048,$05F2
            dc.w    $0A40,$0AFE,$0B3E,$0B68,$0B92,$0BB6
sub_40878586:
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            _SetClip
            rts
            cmpi.l  #$FFFFFFFF,($B5C).w
            bne.b   .L1
            move.l  #$A8,D0
            _NewHandleClear async
            move.l  A0,($B5C).w
.L1:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.w   (A0)
            rts
            rts
            bsr.b   sub_408785C2
            moveq   #3,D1
            add.w   D0,D1
            swap    D0
            add.w   D0,D1
            move.w  D1,MBarHeight
            rts
sub_408785C2:
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetFontInfo
            move.l  (SP)+,D0
            swap    D0
            add.w   (2,SP),D0
            addq.w  #1,D0
            swap    D0
            addq.w  #4,SP
            rts
GetMenuAscent:
            bsr.b   sub_408785C2
            swap    D0
            add.w   ($10,A2),D0
            moveq   #0,D4
            move.w  D0,D4
            rts
sub_408785E6:
            move.l  ($1C,A2),-(SP)
            move.w  ($12,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  ($16,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  MBarHeight,D0
            add.w   D0,(SP)
            _SetRecRgn
            rts
            bsr.b   sub_408785E6
            move.l  (8,A6),D3
            bgt.w   .L9
            tst.b   (-$3A,A6)
            beq.b   .L2
            bsr.w   sub_40878802
            bsr.w   sub_4087890C
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L2
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            pea     (4,A0)
            pea     ($16,A0)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            pea     RGBBlack
            pea     RGBWhite
            _RGBBackColor
            _RGBForeColor
.L2:
            pea     ($10,A2)
            btst    #7,(-$39,A6)
            beq.b   .L3
            _EraseRect
            bra.b   .L4
.L3:
            move.l  #$100010,-(SP)
            _EraseRoundRect
.L4:
            tst.b   (-$3A,A6)
            beq.b   .L5
            pea     RGBBlack
            pea     RGBWhite
            _RGBBackColor
            _RGBForeColor
.L5:
            move.l  ($10,A2),Scratch8
            move.l  ($14,A2),($9FE).w
            lea     Scratch8,A0
            btst    #7,(-$39,A6)
            bne.b   .L6
            move.l  A0,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            move.l  #$30003,-(SP)
            _PenSize
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  #$160016,-(SP)
            _FrameRoundRect
.L6:
            _PenNormal
            move.w  ($16,A2),-(SP)
            move.w  ($12,A2),D0
            swap    D0
            move.w  ($10,A2),D0
            add.w   MBarHeight,D0
            subq.w  #1,D0
            move.w  D0,-(SP)
            swap    D0
            move.l  D0,-(SP)
            _MoveTo
            _LineTo
            bsr.w   sub_408788BC
            cmpi.l  #$FFFFFFFF,(8,A6)
            beq.w   .L12
            tst.w   (A3)
            beq.w   .L11
            clr.w   (-$38,A6)
            moveq   #6,D3
.L7:
            move.w  D3,D0
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.b   sub_40878766
            move.w  TheMenu,D0
            movea.l (0,A3,D3.w),A4
            movea.l (A4),A4
            cmp.w   (A4),D0
            bne.b   .L8
            move.w  D3,(-$38,A6)
.L8:
            movea.l (0,A3,D3.w),A0
            _HUnlock
            addq.w  #6,D3
            cmp.w   (A3),D3
            ble.b   .L7
            move.w  (-$38,A6),D0
            beq.b   .L11
            move.w  (-$38,A6),D0
            move.w  D0,D3
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.w   sub_40878A64
            movea.l (0,A3,D3.w),A0
            _HUnlock
            bra.b   .L11
.L9:
            cmp.w   (A3),D3
            bgt.b   .L11
            move.l  D3,D0
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.b   sub_40878766
            move.w  TheMenu,D0
            cmp.w   (A4),D0
            bne.b   .L10
            bsr.w   sub_40878A64
.L10:
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L11:
            bsr.w   sub_40878586
.L12:
            rts
sub_40878766:
            clr.w   (-$1A,A6)
            cmpi.w  #6,D3
            bne.b   sub_4087877C
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  #$FFFF,($12,A0)
sub_4087877C:
            bsr.w   GetMenuAscent
            move.w  (4,A3,D3.w),-(SP)
            move.w  ($12,A2),D0
            add.w   D0,(SP)
            addq.w  #8,(SP)
            move.w  D4,-(SP)
            _MoveTo
            clr.w   (-$1C,A6)
            bsr.b   sub_40878810
            pea     Scratch8
            _EraseRect
sub_4087879C:
            move.w  #1,-(SP)
            _TextMode
            tst.b   (-$3A,A6)
            beq.b   .L1
            cmpi.w  #$114,($E,A4)
            bne.b   .L1
            bsr.w   sub_4087890C
            cmpi.w  #4,(-$1E,A6)
            blt.b   .L1
            subq.l  #4,SP
            move.w  #$14,-(SP)
            _GetCIcon
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A1
            movea.l (A1),A0
            movem.l (6,A0),D0-D1
            movem.l D0-D1,(-$14,A6)
            move.l  A1,-(SP)
            pea     (-$14,A6)
            move.l  A1,-(SP)
            pea     (-$14,A6)
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPen
            _OffsetRect
            _PlotCIcon
            _DisposCIcon
            bra.b   .L2
.L1:
            pea     ($E,A4)
            _DrawString
.L2:
            bsr.w   sub_408788DE
            bsr.w   sub_408788BC
            rts
sub_40878802:
            pea     (-$2C,A6)
            _GetBackColor
            pea     (-$32,A6)
            _GetForeColor
            rts
sub_40878810:
            tst.b   (-$3A,A6)
            beq.w   .L9
            bsr.b   sub_40878802
            tst.w   (-$1C,A6)
            beq.b   .L1
            lea     (-8,A6),A0
            bra.b   .L2
.L1:
            lea     ($10,A2),A0
.L2:
            bsr.w   sub_40878910
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L6
            subq.w  #4,SP
            move.w  (A4),-(SP)
            clr.w   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L4
            movea.l D0,A0
            tst.w   (-$1C,A6)
            beq.b   .L3
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L7
.L3:
            pea     (4,A0)
            pea     ($A,A0)
            bra.b   .L7
.L4:
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L6
            movea.l D0,A0
            tst.w   (-$1C,A6)
            beq.b   .L5
            pea     ($10,A0)
            pea     ($A,A0)
            bra.b   .L7
.L5:
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L7
.L6:
            pea     RGBBlack
            pea     RGBWhite
.L7:
            tst.w   (-$1A,A6)
            beq.b   .L8
            movea.l (SP),A0
            move.l  (4,SP),(SP)
            move.l  A0,(4,SP)
.L8:
            _RGBBackColor
            _RGBForeColor
            bra.b   .L11
.L9:
            moveq   #$1E,D0
            move.l  D0,-(SP)
            moveq   #$21,D0
            move.l  D0,-(SP)
            tst.w   (-$1A,A6)
            beq.b   .L10
            _BackColor
            _ForeColor
            bra.b   .L11
.L10:
            _ForeColor
            _BackColor
.L11:
            rts
sub_408788BC:
            tst.b   (-$3A,A6)
            beq.b   .L1
            pea     (-$32,A6)
            pea     (-$2C,A6)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            moveq   #$21,D0
            move.l  D0,-(SP)
            moveq   #$1E,D0
            move.l  D0,-(SP)
            _BackColor
            _ForeColor
.L2:
            rts
sub_408788DE:
            btst    #0,($D,A4)
            bne.b   .L1
            suba.w  #$12,SP
            move.l  SP,-(SP)
            _GetPenState
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            pea     Scratch8
            _PaintRect
            move.l  SP,-(SP)
            _SetPenState
            lea     ($12,SP),SP
.L1:
            rts
sub_4087890C:
            lea     ($10,A2),A0
sub_40878910:
            subq.w  #4,SP
            move.l  A0,-(SP)
            _GetMaxDevice
            movea.l (SP)+,A0
            movea.l (A0),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.w  ($20,A1),(-$1E,A6)
            rts
            move.l  (8,A6),D1
            swap    D1
            move.w  ($10,A2),D0
            cmp.w   D0,D1
            blt.b   .L5
            add.w   MBarHeight,D0
            cmp.w   D0,D1
            bge.b   .L5
            swap    D1
            move.w  ($12,A2),D0
            cmp.w   D0,D1
            blt.b   .L5
            move.w  ($16,A2),D0
            cmp.w   D0,D1
            bgt.b   .L5
            sub.w   ($12,A2),D1
            cmp.w   (2,A3),D1
            bgt.b   .L4
            cmpi.w  #$A,D1
            blt.b   .L4
            moveq   #0,D0
            move.w  (A3),D0
.L1:
            cmp.w   (4,A3,D0.w),D1
            bge.b   .L2
            subq.w  #6,D0
            bra.b   .L1
.L2:
            move.l  D0,($12,A6)
.L3:
            rts
.L4:
            clr.l   ($12,A6)
            bra.b   .L3
.L5:
            movea.l ($B5C).w,A0
            movea.l (A0),A3
            move.w  (A3),D3
            beq.b   .L8
.L6:
            clr.w   -(SP)
            move.l  (8,A6),-(SP)
            pea     (0,A3,D3.w)
            _PtInRect
            tst.b   (SP)+
            bne.b   .L7
            subi.w  #$1C,D3
            beq.b   .L8
            bra.b   .L6
.L7:
            clr.l   ($12,A6)
            move.w  ($E,A3,D3.w),($14,A6)
            bra.b   .L3
.L8:
            move.l  MinusOne,($12,A6)
            bra.b   .L3
            tst.w   (A3)
            beq.b   .L12
            move.l  (8,A6),D0
            tst.w   D0
            beq.b   .L9
            cmp.w   (A3),D0
            bgt.b   .L12
            move.w  (4,A3,D0.w),D3
            bra.b   .L10
.L9:
            moveq   #$A,D3
            moveq   #6,D4
            move.w  D3,(4,A3,D4.w)
.L10:
            movea.l (0,A3,D4.w),A0
            movea.l (A0),A0
            clr.w   -(SP)
            pea     ($E,A0)
            _StringWidth
            add.w   (SP)+,D3
            addi.w  #$D,D3
            addq.w  #6,D4
            cmp.w   (A3),D4
            bgt.b   .L11
            move.w  D3,(4,A3,D4.w)
            bra.b   .L10
.L11:
            move.w  D3,(2,A3)
.L12:
            rts
            bsr.w   sub_408785E6
            move.w  ($A,A6),D0
            cmpi.w  #0,D0
            beq.w   sub_40878A64.L1
            cmp.w   (2,A3),D0
            bgt.b   .L15
            bsr.w   sub_40878AFE
            moveq   #0,D3
            move.w  ($A,A6),D3
            cmpi.w  #1,(8,A6)
            bgt.b   .L15
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            cmpi.w  #1,(8,A6)
            beq.b   .L13
            bsr.b   sub_40878A3E
            bra.b   .L14
.L13:
            bsr.b   sub_40878A64
.L14:
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L15:
            bsr.w   sub_40878586
            rts
sub_40878A3E:
            move.w  (A3),D0
            addq.w  #6,D0
            movea.l (2,A3,D0.w),A0
            clr.l   (2,A3,D0.w)
            move.l  A0,D0
            bne.b   .L1
            clr.w   TheMenu
            _DrawMenuBar
            bra.b   .L2
.L1:
            move.l  A0,-(SP)
            bsr.w   sub_40878FCA
            addq.w  #4,SP
.L2:
            clr.l   SavedHandle
            rts
sub_40878A64:
            bsr.w   sub_40878E3E
            move.w  (A3),D0
            addq.w  #6,D0
            move.l  SavedHandle,(2,A3,D0.w)
            clr.l   SavedHandle
            move.w  #1,(-$1A,A6)
            bsr.w   sub_4087877C
            rts
.L1:
            tst.b   (-$3A,A6)
            beq.b   .L4
            bsr.w   sub_40878802
            bsr.w   sub_4087890C
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L4
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L3
.L2:
            pea     RGBBlack
            pea     RGBWhite
.L3:
            _RGBBackColor
            _HiliteColor
            bclr    #7,HiliteMode
.L4:
            subq.w  #4,SP
            _NewRgn
            _OpenRgn
            pea     ($10,A2)
            btst    #7,(-$39,A6)
            beq.b   .L5
            _FrameRect
            bra.b   .L6
.L5:
            move.l  #$100010,-(SP)
            _FrameRoundRect
.L6:
            move.l  (SP),-(SP)
            _CloseRgn
            move.l  (SP),-(SP)
            move.l  ($1C,A2),-(SP)
            move.l  ($1C,A2),-(SP)
            _SectRgn
            _DisposRgn
            pea     ($10,A2)
            _InverRect
            bsr.w   sub_408788BC
            bra.w   sub_40878910.L15
sub_40878AFE:
            tst.w   D0
            beq.b   .L4
            lea     Scratch8,A0
            move.w  ($10,A2),(A0)
            addq.w  #1,(A0)+
            move.w  (4,A3,D0.w),(A0)
            move.w  ($12,A2),D1
            add.w   D1,(A0)
            subq.w  #1,(A0)+
            move.w  ($10,A2),(A0)
            move.w  MBarHeight,D1
            add.w   D1,(A0)
            subq.w  #1,(A0)+
            move.w  ($12,A2),(A0)
            cmp.w   (A3),D0
            beq.b   .L1
            addq.w  #6,D0
            move.w  (4,A3,D0.w),D1
            add.w   D1,(A0)
            bra.b   .L2
.L1:
            move.w  (2,A3),D1
            add.w   D1,(A0)
.L2:
            addq.w  #4,(A0)
.L3:
            rts
.L4:
            lea     Scratch8,A0
            move.w  ($10,A2),(A0)+
            move.w  ($12,A2),(A0)+
            move.w  ($10,A2),(A0)
            move.w  MBarHeight,D1
            add.w   D1,(A0)+
            move.w  ($16,A2),(A0)
            bra.b   .L3
            bsr.w   sub_40878586
            movea.l (8,A6),A0
            lea     (-8,A6),A1
            move.l  (A0),(A1)
            move.l  (4,A0),(4,A1)
            lea     Scratch8,A0
            lea     (-8,A6),A1
            move.l  A0,-(SP)
            move.w  (A1),(A0)
            addq.w  #3,(A0)
            move.w  (2,A1),(2,A0)
            move.l  (4,A1),(4,A0)
            move.l  #$FFFCFFFC,-(SP)
            _InsetRect
            bsr.w   sub_40878E3E
            subq.w  #2,SP
            pea     (-8,A6)
            _EmptyRect
            tst.b   (SP)+
            bne.w   .L7
            tst.b   (-$3A,A6)
            beq.b   .L5
            move.w  ($C,A6),D0
            movea.l (0,A3,D0.w),A1
            movea.l (A1),A4
            move.w  #1,(-$1C,A6)
            clr.w   (-$1A,A6)
            bsr.w   sub_40878810
.L5:
            lea     (-8,A6),A4
            move.l  A4,-(SP)
            _EraseRect
            tst.b   (-$3A,A6)
            beq.b   .L6
            bsr.w   sub_408788BC
.L6:
            _PenNormal
            move.w  (2,A4),-(SP)
            subq.w  #1,(SP)
            move.w  (SP),-(SP)
            move.w  (SP),-(SP)
            move.w  (A4),-(SP)
            _MoveTo
            move.w  (4,A4),-(SP)
            _LineTo
            move.w  (6,A4),-(SP)
            move.w  (4,A4),-(SP)
            _LineTo
            move.w  (6,A4),-(SP)
            move.w  (A4),-(SP)
            subq.w  #1,(SP)
            _LineTo
            move.w  (A4),-(SP)
            subq.w  #1,(SP)
            _LineTo
            move.l  #$20002,-(SP)
            _PenSize
            move.w  (6,A4),D0
            move.w  D0,-(SP)
            move.w  (A4),-(SP)
            addq.w  #2,(SP)
            move.w  D0,-(SP)
            move.w  (4,A4),D0
            move.w  D0,-(SP)
            move.w  (2,A4),-(SP)
            addq.w  #2,(SP)
            move.w  D0,-(SP)
            _MoveTo
            _LineTo
            _LineTo
            _PenNormal
.L7:
            clr.w   (-$24,A6)
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            beq.b   .L8
            move.w  (2,A0,D0.w),D1
            cmp.w   (-6,A6),D1
            blt.b   .L8
            move.w  #1,(-$24,A6)
.L8:
            addi.w  #$1C,(A0)
            move.w  (A0),D0
            move.l  (-8,A6),(0,A0,D0.w)
            move.l  (-4,A6),(4,A0,D0.w)
            move.l  SavedHandle,(8,A0,D0.w)
            move.w  (-$24,A6),($C,A0,D0.w)
            move.w  ($C,A6),D1
            move.w  D1,($E,A0,D0.w)
            move.l  (0,A3,D1.w),($10,A0,D0.w)
            rts
CalcMenuRect:
            move.l  (8,A6),D0
            move.w  (8,A6),(-$26,A6)
            movea.l (0,A3,D0.w),A1
            move.w  (4,A3,D0.w),D3
            add.w   ($12,A2),D3
            movea.l (A1),A0
            tst.l   (2,A0)
            bpl.b   .L1
            move.l  A1,-(SP)
            move.l  A1,-(SP)
            _CalcMenuSize
            movea.l (SP)+,A0
            movea.l (A0),A0
.L1:
            bsr.b   MakeMRect
            rts
MakeMRect:
            move.w  (-$26,A6),D1
            bne.b   MakeHMRect
            clr.w   (-$24,A6)
            move.w  ($10,A2),D1
            add.w   MBarHeight,D1
            move.w  D3,D0
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   StoreRect
            move.w  #1,(-$24,A6)
            move.w  ($16,A2),D3
            subq.w  #8,D3
            sub.w   (2,A0),D3
StoreRect:
            lea     (-8,A6),A1
            move.w  D1,(A1)+
            move.w  D3,(A1)+
            add.w   (4,A0),D1
            move.w  D1,(A1)+
            add.w   (2,A0),D3
            move.w  D3,(A1)
            rts
MakeHMRect:
            movem.l D2-D5/A0-A3,-(SP)
            move.l  D1,D5
            bsr.w   GetSizes
            bsr.w   GetA1SaveData
            move.w  ($14,A1),D2
            movea.l ($10,A1),A3
            movea.l (A3),A3
            moveq   #1,D4
.ItemLoop:
            move.w  D4,D0
            movea.l A3,A0
            bsr.w   GetItemRecord
            bsr.w   GetItemHeight
            add.w   D0,D2
            cmp.w   D5,D2
            bgt.b   .L4
            addq.w  #1,D4
            bra.b   .ItemLoop
.L4:
            sub.w   D0,D2
            move.w  D2,D1
            movem.l (SP)+,D2-D5/A0-A3
            subq.w  #7,D1
            cmp.w   MBarHeight,D1
            bge.b   .L5
            move.w  MBarHeight,D1
.L5:
            addq.w  #7,D1
            move.w  D1,D0
            add.w   (4,A0),D0
            addi.w  #$C,D0
            cmp.w   ($14,A2),D0
            bls.b   .L6
            move.w  ($14,A2),D0
            subi.w  #$C,D0
            sub.w   (4,A0),D0
            move.w  D0,D1
.L6:
            bsr.w   GetA1SaveData
            move.w  ($C,A1),(-$24,A6)
            cmpi.w  #1,(-$24,A6)
            beq.b   .L7
            move.w  (6,A1),D0
            subq.w  #4,D0
            move.w  D0,D3
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   .L8
            move.w  #1,(-$24,A6)
            move.w  (2,A1),D0
            sub.w   (2,A0),D0
            addq.w  #8,D0
            move.w  D0,D3
            subq.w  #8,D0
            cmp.w   ($12,A2),D0
            bge.b   .L8
            move.w  ($12,A2),D0
            addq.w  #8,D0
            move.w  D0,D3
            clr.w   (-$24,A6)
            bra.b   .L8
.L7:
            move.w  (2,A1),D0
            addq.w  #8,D0
            sub.w   (2,A0),D0
            move.w  D0,D3
            subq.w  #8,D0
            cmp.w   ($12,A2),D0
            bgt.b   .L8
            clr.w   (-$24,A6)
            move.w  (6,A1),D0
            subq.w  #4,D0
            move.w  D0,D3
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   .L8
            move.w  ($16,A2),D0
            sub.w   (2,A0),D0
            subq.w  #8,D0
            move.w  D0,D3
            move.w  #1,(-$24,A6)
.L8:
            bra.w   StoreRect
GetItemRecord:
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
            rts
.L3:
            tst.b   (A1)
            beq.b   .L2
            movea.l A1,A0
            move.b  (A1)+,D1
            adda.w  D1,A1
            rts
GetSizes:
            lea     (-$42,A6),A2
            move.l  A2,-(SP)
            _GetFontInfo
            move.w  (A2)+,D0
            add.w   (A2)+,D0
            cmpi.w  #$E,(A2)
            bne.b   .L1
            subq.w  #2,(A2)
.L1:
            addq.w  #2,A2
            add.w   D0,(A2)
            rts
GetItemHeight:
            move.w  (-$3C,A6),D0
            cmpi.b  #$1C,(1,A1)
            beq.b   .L1
            tst.b   (A1)
            beq.b   .L1
            moveq   #$24,D0
.L1:
            rts
sub_40878E3E:
            movem.l D3-D4/A3-A4,-(SP)
            tst.b   (-$3A,A6)
            beq.b   .L1
            lea     Scratch8,A0
            bsr.w   sub_40878910
            movea.l A1,A4
            move.l  TheGDevice,-(SP)
            move.l  A0,TheGDevice
            subq.l  #4,SP
            _NewPixMap
            move.l  (SP)+,D0
            move.l  (SP)+,TheGDevice
            tst.l   D0
            beq.w   .L4
            movea.l A4,A1
            movea.l D0,A0
            _HLock
            move.l  A0,SavedHandle
            movea.l (A0),A4
            movea.l ($2A,A4),A0
            _DisposHandle
            move.l  ($2A,A1),($2A,A4)
            move.w  (-$1E,A6),D3
            bra.b   .L2
.L1:
            moveq   #$E,D0
            _NewHandleClear
            bne.w   .L4
            _HLock
            move.l  A0,SavedHandle
            movea.l (A0),A4
            moveq   #1,D3
.L2:
            move.w  ($A00).w,D1
            sub.w   ($9FC).w,D1
            mulu.w  D1,D3
            addi.w  #$F,D3
            lsr.w   #4,D3
            add.w   D3,D3
            move.w  (4,A4),D1
            andi.w  #$C000,D1
            or.w    D3,D1
            move.w  D1,(4,A4)
            move.w  ($9FE).w,D4
            sub.w   Scratch8,D4
            mulu.w  D4,D3
            addq.l  #4,D3
            move.w  #$8F,D0
            _GetToolBoxTrapAddress
            movea.l A0,A1
            move.w  #$9F,D0
            _GetToolBoxTrapAddress
            cmpa.l  A0,A1
            beq.b   .L5
            subq.l  #8,SP
            pea     (4,SP)
            move.w  #$15,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            addq.l  #4,SP
            cmp.l   D3,D0
            bcs.b   .L5
            subq.l  #6,SP
            move.l  D3,-(SP)
            pea     (8,SP)
            move.w  #$1D,-(SP)
            _OSDispatch
            movea.l (SP)+,A3
            tst.w   (SP)+
            bne.b   .L5
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1E,-(SP)
            _OSDispatch
            addq.l  #2,SP
            movea.l (A3),A0
            st      (A0)
            bra.b   .L6
.L3:
            movea.l SavedHandle,A0
            _DisposHandle
.L4:
            clr.l   SavedHandle
            bra.b   .L8
.L5:
            move.l  D3,D0
            _NewHandle
            bne.b   .L3
            _HLock
            movea.l A0,A3
            movea.l (A3),A0
            sf      (A0)
.L6:
            move.l  Scratch8,(6,A4)
            move.l  ($9FE).w,($A,A4)
            addq.l  #4,A0
            move.l  A0,(A4)
            movea.l A4,A0
            move.l  ($50,A2),-(SP)
            moveq   #-1,D0
            move.l  D0,($50,A2)
            pea     (2,A2)
            move.l  A0,-(SP)
            bsr.b   sub_40878F84
            move.l  (SP)+,($50,A2)
            movea.l SavedHandle,A0
            _HUnlock
            movea.l (A0),A4
            move.l  A3,(A4)
            movea.l (A3),A0
            tst.b   (A0)
            beq.b   .L7
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1F,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L8
.L7:
            movea.l A3,A0
            _HUnlock
.L8:
            movem.l (SP)+,D3-D4/A3-A4
            rts
sub_40878F84:
            move.l  (SP)+,D4
            pea     (6,A0)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            move.l  D4,-(SP)
            rts
sub_40878F96:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            adda.w  (A0),A0
            rts
GetA1SaveData:
            movea.l ($B5C).w,A1
            movea.l (A1),A1
            adda.w  (A1),A1
            rts
            bsr.w   sub_40878586
            bsr.b   sub_40878F96
            movea.l (8,A0),A0
            move.l  A0,D0
            beq.b   sub_40878FCA.L5
            move.l  A0,-(SP)
            bsr.b   sub_40878FCA
            addq.w  #4,SP
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            subi.w  #$1C,(A0)
            rts
sub_40878FCA:
            movem.l A3-A4,-(SP)
            movea.l A0,A4
            _HLock
            movea.l (A4),A0
            movea.l (A0),A3
            movea.l (A3),A1
            tst.b   (A1)
            beq.b   .L1
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1E,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L2
.L1:
            movea.l A3,A0
            _HLock
.L2:
            movea.l (A4),A0
            movea.l (A3),A1
            addq.l  #4,A1
            move.l  A1,(A0)
            move.l  A0,-(SP)
            pea     (2,A2)
            bsr.b   sub_40878F84
            movea.l A4,A0
            _DisposHandle
            movea.l (A3),A0
            tst.b   (A0)
            beq.b   .L3
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$20,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L4
.L3:
            movea.l A3,A0
            _DisposHandle
.L4:
            movem.l (SP)+,A3-A4
            rts
.L5:
            lea     (-8,A6),A1
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            move.l  (0,A0,D0.w),(A1)+
            move.l  (4,A0,D0.w),(A1)+
            addq.w  #2,-(A1)
            addq.w  #2,-(A1)
            subq.w  #1,-(A1)
            subq.w  #1,-(A1)
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),-(SP)
            pea     (-8,A6)
            _RectRgn
            subq.w  #4,SP
            _FrontWindow
            move.l  (4,SP),-(SP)
            _PaintBehind
            _DisposRgn
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            subi.w  #$1C,(A0)
            rts
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L9
.L6:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L7
            subi.w  #$1C,D1
            beq.b   .L9
            bra.b   .L6
.L7:
            lea     (0,A0,D1.w),A1
            move.l  A1,($12,A6)
.L8:
            rts
.L9:
            bsr.w   CalcMenuRect
            lea     Scratch8,A0
            lea     (-8,A6),A1
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  A0,($12,A6)
            bra.b   .L8
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L12
.L10:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L11
            subi.w  #$1C,D1
            beq.b   .L12
            bra.b   .L10
.L11:
            move.w  ($A0A).w,($14,A0,D1.w)
            move.w  ($A0C).w,($16,A0,D1.w)
.L12:
            rts
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L15
.L13:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L14
            subi.w  #$1C,D1
            beq.b   .L15
            bra.b   .L13
.L14:
            move.w  ($14,A0,D1.w),($A0A).w
            move.w  ($16,A0,D1.w),($A0C).w
.L15:
            rts
            move.l  (8,A6),-(SP)
            move.w  ($12,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  ($16,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  MBarHeight,D0
            add.w   D0,(SP)
            _SetRecRgn
            move.l  (8,A6),($12,A6)
            rts
            clr.l   ($12,A6)
            moveq   #6,D3
            cmp.w   (A3),D3
            bgt.w   .L27
            move.w  (A3),D0
            addq.w  #6,D0
            tst.l   (2,A3,D0.w)
            bne.w   .L27
            movea.l (0,A3,D3.w),A0
            movea.l (A0),A4
            cmpi.w  #$114,($E,A4)
            bne.w   .L27
            _HLock
            bsr.w   sub_408785E6
            clr.w   (-$1A,A6)
            clr.w   (-$1C,A6)
            bsr.w   sub_40878810
            move.l  D3,D0
            bsr.w   sub_40878AFE
            moveq   #$10,D1
            move.w  ($A00).w,D0
            sub.w   ($9FC).w,D0
            sub.w   D1,D0
            cmp.w   D1,D0
            bge.b   .L16
            move.w  D0,D1
.L16:
            pea     Scratch8
            asr.w   #1,D1
            move.l  D1,-(SP)
            _InsetRect
            move.w  ($C,A6),D4
            beq.b   .L17
            subq.l  #4,SP
            _NewRgn
            move.l  (SP)+,D5
            pea     Scratch8
            move.w  D4,-(SP)
            clr.w   -(SP)
            move.l  D5,-(SP)
            _ScrollRect
            move.l  D5,-(SP)
            _SetClip
            move.l  D5,-(SP)
            _DisposRgn
            bra.b   .L18
.L17:
            pea     Scratch8
            _EraseRect
.L18:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  ($12,A0),D5
            bgt.b   .L19
            move.w  ($A00).w,D5
            sub.w   ($9FC).w,D5
.L19:
            move.w  ($9FC).w,D1
            tst.l   (8,A6)
            bne.b   .L20
            move.w  (4,A3,D3.w),D1
            add.w   ($12,A2),D1
            addq.w  #8,D1
.L20:
            move.w  D4,D0
            blt.b   .L21
            bgt.b   .L22
            moveq   #0,D5
            bra.b   .L23
.L21:
            add.w   D0,D5
            add.w   D5,D1
            bra.b   .L23
.L22:
            sub.w   D0,D5
            sub.w   D5,D1
.L23:
            movea.l ($1C,A2),A0
            movea.l (A0),A0
            move.w  D1,-(SP)
            bsr.w   GetMenuAscent
            move.w  D4,-(SP)
            _MoveTo
            move.l  (8,A6),D0
            beq.b   .L24
            move.l  #$FFF40000,(-$14,A6)
            move.l  #$40010,(-$10,A6)
            pea     (-$14,A6)
            move.l  D0,-(SP)
            pea     (-$14,A6)
            subq.l  #4,-(SP)
            move.l  SP,-(SP)
            _GetPen
            _OffsetRect
            bsr.b   sub_40879244
            bra.b   .L25
.L24:
            bsr.w   sub_4087879C
.L25:
            moveq   #0,D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  D5,($12,A0)
            bgt.b   .L26
            moveq   #-1,D0
.L26:
            move.l  D0,($12,A6)
            bsr.w   sub_408788BC
            bsr.w   sub_40878586
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L27:
            rts
sub_40879244:
            lea     ($A0E).w,A1
            move.l  (4,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(A1)+
            move.w  #2,(A1)+
            clr.l   (A1)+
            move.l  #$100010,(A1)
            move.l  (8,SP),D1
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
            addq.l  #8,SP
            jmp     (A0)
            ds.b    14

            EVEN
