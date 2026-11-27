            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryWDEF_1

            IMPORT  BaseOfROM,RsrcEntryWDEF_0

            SECTION "RoundedWDEF",CODE

RsrcEntryWDEF_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'WDEF' 1 (1284 bytes) - Combo mask
            dc.l    RsrcEntryWDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcWDEF_1-BaseOfROM            ; Data
            dc.b    'WDEF'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000510,$0000010C   ; Block header
RsrcWDEF_1:
            bra.b   .L1
            dc.w    0,$5744,$4546,$0001,$000A
.L1:
            link.w  A6,#-$1E
            movem.l D3-D5/A3-A4,-(SP)
            cmpi.w  #2,($C,A6)
            bgt.w   .L7
            cmpi.w  #0,($C,A6)
            bmi.w   .L7
            movea.l (A5),A0
            move.l  (A0),-(SP)
            cmpi.w  #$3FFF,ROM85
            sls     (-$1E,A6)
            bhi.b   .L2
            bsr.w   UpdateCPort
            pea     (-$1C,A6)
            _GetForeColor
            pea     (-$16,A6)
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
            move.l  (A0),(-$C,A6)
            bra.b   .L3
.L2:
            move.l  WMgrPort,-(SP)
            _SetPort
.L3:
            lea     (-8,A6),A3
            move.l  A3,-(SP)
            _GetFontInfo
            move.w  (A3)+,D0
            add.w   (A3)+,D0
            addq.w  #4,D0
            bset    #0,D0
            moveq   #$13,D1
            cmp.w   D1,D0
            bge.b   .L4
            sub.w   D0,D1
            lsr.w   #1,D1
            add.w   D1,(-8,A6)
            moveq   #$13,D0
.L4:
            move.w  D0,(A3)+
            subi.w  #$D,D0
            lsr.w   #1,D0
            move.w  D0,(A3)
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D5
            lsr.w   #1,D5
            asl.w   #2,D5
            clr.l   (A0)
            cmpi.w  #3,D0
            bge.b   .L5
            asl.w   #2,D0
            jsr     .L8(PC,D0.w)
.L5:
            tst.b   (-$1E,A6)
            beq.b   .L6
            pea     (-$1C,A6)
            _RGBForeColor
            pea     (-$16,A6)
            _RGBBackColor
            movea.l (-$10,A6),A0
            _HUnlock
.L6:
            _SetPort
.L7:
            movem.l (SP)+,D3-D5/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            bra.w   sub_408772B2.L13
            bra.w   sub_408774A6.L10
            bra.w   sub_408774A6.L11
.L9:
            rts
UpdateCPort:
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
sub_4087728A:
            move.l  D1,-(SP)
            movea.l (-$C,A6),A0
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
sub_408772B2:
            addq.w  #2,A0
            tst.w   (4,A0)
            bpl.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
.L13:
            tst.b   ($6E,A3)
            beq.b   RsrcWDEF_1.L9
            cmpi.w  #4,D3
            beq.w   BuildTBarRect_WDEF_1.L1
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            move.w  (-4,A0),D0
            add.w   (-4,A6),D0
            move.w  D0,(A0)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A4
            pea     Scratch8
            bsr.w   sub_40877480
            move.l  D0,-(SP)
            st      -(SP)
            clr.w   -(SP)
            bsr.w   sub_408774A6
            tst.b   (-$1E,A6)
            beq.b   .L2
            move.w  #1,D0
            bsr.w   sub_4087728A
            _RGBForeColor
            _PenNormal
.L2:
            move.l  A4,-(SP)
            _FrameRgn
            tst.b   (-$1E,A6)
            beq.b   .L5
            tst.b   ($6F,A3)
            bne.b   .L3
            moveq   #4,D0
            bsr.w   sub_4087728A
            _RGBForeColor
            moveq   #1,D0
            bsr.w   sub_4087728A
            bra.b   .L4
.L3:
            moveq   #4,D0
            bsr.w   sub_4087728A
.L4:
            _RGBBackColor
.L5:
            move.l  A4,-(SP)
            move.l  OneOne,-(SP)
            _InsetRgn
            move.l  A4,-(SP)
            tst.b   (-$1E,A6)
            beq.b   .L6
            _PaintRgn
            bra.b   .L7
.L6:
            _EraseRgn
.L7:
            bsr.w   DoTitleString
            tst.b   ($6F,A3)
            beq.b   .L11
            tst.b   ($70,A3)
            beq.b   .L10
            tst.b   (-$1E,A6)
            beq.b   .L8
            moveq   #4,D1
            bra.b   .L9
.L8:
            moveq   #0,D1
.L9:
            lea     sub_40877600.L1,A1
            bsr.b   PlotGoAway
.L10:
            tst.b   (-$1E,A6)
            bne.b   .L11
            subq.w  #1,($9FE).w
            pea     Scratch8
            _InverRect
.L11:
            move.l  A4,-(SP)
            _DisposRgn
            tst.b   (-$1E,A6)
            beq.b   .L12
            moveq   #1,D0
            bsr.w   sub_4087728A
            _RGBForeColor
.L12:
            move.l  ($72,A3),-(SP)
            _FrameRgn
            rts
BuildTBarRect_WDEF_1:
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  (A0),D0
            add.w   (-4,A6),D0
            move.w  D0,(4,A0)
            subq.w  #1,(6,A0)
            rts
.L1:
            bsr.b   BuildTBarRect_WDEF_1
            lea     sub_40877600.L1,A1
            lea     ($20,A1),A1
            moveq   #2,D1
PlotGoAway:
            lea     Scratch8,A0
            move.w  (-2,A6),D0
            add.w   D0,(A0)
            subq.w  #1,(A0)
            addq.w  #8,(2,A0)
            move.l  (A0)+,(A0)
            moveq   #$10,D0
            add.w   D0,(A0)+
            add.w   D0,(A0)
            move.w  D1,D0
            move.l  #$100010,D1
            bsr.b   PlotSymbol
            bsr.b   BuildTBarRect_WDEF_1
            rts
PlotSymbol:
            lea     ($A0E).w,A0
            move.l  A1,(A0)
            move.w  #2,(4,A0)
            move.l  #$100010,($A,A0)
            move.l  A0,-(SP)
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
DoTitleString:
            bsr.w   BuildTBarRect_WDEF_1
            move.w  ($A00).w,D3
            sub.w   ($9FC).w,D3
            sub.w   ($8A,A3),D3
            asr.w   #1,D3
            tst.b   ($70,A3)
            beq.b   .L2
            tst.w   D3
            bmi.b   .L1
            cmpi.w  #$1C,D3
            bgt.b   .L2
.L1:
            moveq   #$1C,D3
.L2:
            add.w   ($9FC).w,D3
            move.w  D3,-(SP)
            move.w  Scratch8,D0
            add.w   (-8,A6),D0
            addq.w  #2,D0
            move.w  D0,-(SP)
            _MoveTo
            tst.b   (-$1E,A6)
            beq.b   .L3
            move.w  ($48,A3),-(SP)
            move.w  #4,-(SP)
            _TextMode
.L3:
            movea.l ($86,A3),A0
            _HLock
            move.l  (A0),-(SP)
            _DrawString
            movea.l ($86,A3),A0
            _HUnlock
            tst.b   (-$1E,A6)
            beq.b   .L4
            _TextMode
.L4:
            rts
sub_40877480:
            move.l  .L1(PC,D5.w),D0
            rts
.L1:
            dc.w    $0010,$0010,$0004,$0004,$0006,$0006,$0008,$0008
            dc.w    $000A,$000A,$000C,$000C,$0014,$0014,$0018,$0018
sub_408774A6:
            link.w  A6,#0
            move.l  A3,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            tst.l   ($C,A6)
            bne.b   .L2
.L1:
            move.l  ($14,A6),-(SP)
            move.l  ($10,A6),-(SP)
            _RectRgn
            bra.b   .L5
.L2:
            _HidePen
            _OpenRgn
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            _FrameRoundRect
            move.l  ($14,A6),-(SP)
            _CloseRgn
            _ShowPen
            movea.l ($10,A6),A0
            tst.w   (8,A6)
            bne.b   .L3
            move.w  (4,A0),D1
            move.w  D1,D0
            subq.w  #8,D0
            bra.b   .L4
.L3:
            tst.w   ($A,A6)
            bne.b   .L5
            move.w  (A0),D0
            move.w  D0,D1
            addq.w  #8,D1
.L4:
            lea     ToolScratch,A1
            move.w  D0,(A1)+
            move.w  (2,A0),(A1)+
            move.w  D1,(A1)+
            move.w  (6,A0),(A1)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A3
            pea     ToolScratch
            _RectRgn
            move.l  ($14,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($14,A6),-(SP)
            _UnionRgn
            move.l  A3,-(SP)
            _DisposRgn
.L5:
            movea.l (SP)+,A3
            unlk    A6
            movea.l (SP)+,A0
            lea     ($10,SP),SP
            jmp     (A0)
.L10:
            moveq   #$10,D4
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  ($76,A3),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L6
            moveq   #1,D0
            bra.b   .L8
.L6:
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  ($72,A3),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L9
            clr.w   -(SP)
            move.l  D3,-(SP)
            movea.l ($76,A3),A4
            movea.l (A4),A4
            addq.w  #2,A4
            move.w  (-4,A6),D0
            sub.w   D0,(A4)
            move.l  A4,-(SP)
            _PtInRect
            move.w  (-4,A6),D0
            add.w   D0,(A4)
            tst.b   (SP)+
            beq.b   .L9
            tst.b   ($70,A3)
            beq.b   .L7
            tst.b   ($6F,A3)
            beq.b   .L7
            move.w  D3,D0
            movea.l A3,A0
            bsr.w   sub_408772B2
            add.w   (8,A0),D0
            sub.w   ($12,A3),D0
            cmpi.w  #$12,D0
            bgt.b   .L7
            subq.w  #8,D0
            bmi.b   .L7
            move.l  D3,D0
            swap    D0
            add.w   (6,A0),D0
            sub.w   ($10,A3),D0
            add.w   (-2,A6),D0
            bpl.b   .L7
            addi.w  #$B,D0
            bmi.b   .L7
            moveq   #4,D0
            bra.b   .L8
.L7:
            moveq   #2,D0
.L8:
            move.l  D0,($14,A6)
.L9:
            rts
.L11:
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  ($10,A3),(A0)+
            move.l  ($14,A3),(A0)
            movea.l A3,A0
            bsr.w   sub_408772B2
            move.l  (6,A0),-(SP)
            neg.w   (2,SP)
            neg.w   (SP)
            _OffsetRect
            movea.l ($76,A3),A0
            clr.w   D1
            bsr.b   sub_40877600
            pea     Scratch8
            move.l  MinusOne,-(SP)
            _InsetRect
            move.w  (-4,A6),D0
            subq.w  #1,D0
            sub.w   D0,Scratch8
            moveq   #1,D1
            movea.l ($72,A3),A0
sub_40877600:
            move.l  A0,-(SP)
            pea     Scratch8
            bsr.w   sub_40877480
            move.l  D0,-(SP)
            move.w  D1,-(SP)
            st      -(SP)
            bsr.w   sub_408774A6
            rts
.L1:
            ds.b    4
            dc.w    $7FF0,$4010,$4010,$4010,$4010,$4010,$4010,$4010
            dc.w    $4010,$4010,$7FF0
            ds.b    10
            dc.w    $7FF0,$4210,$5250,$4A90,$4010,$5DD0,$4010,$4A90
            dc.w    $5250,$4210,$7FF0
            ds.b    16

            EVEN
