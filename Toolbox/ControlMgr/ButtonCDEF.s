            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryCDEF_0

            IMPORT  BaseOfROM,RsrcEntryCDEF_1

            SECTION "ButtonCDEF",CODE

RsrcEntryCDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CDEF' 0 (1268 bytes) - Combo mask
            dc.l    RsrcEntryCDEF_1-BaseOfROM       ; Next entry
            dc.l    RsrcCDEF_0-BaseOfROM            ; Data
            dc.b    'CDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000500,$000000EC   ; Block header
RsrcCDEF_0:
            bra.b   .L1
            dc.w    0,$4344,$4546,0,$000A
.L1:
            link.w  A6,#-$38
            movem.l D3-D7/A1-A4,-(SP)
            cmpi.w  #2,($C,A6)
            bls.b   .L2
            cmpi.w  #$A,($C,A6)
            beq.b   .L2
            cmpi.w  #$B,($C,A6)
            bne.w   .L8
.L2:
            pea     (-$14,A6)
            _GetPenState
            _PenNormal
            cmpi.w  #$3FFF,ROM85
            sls     (-$16,A6)
            bhi.b   .L5
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($48,A0),-(SP)
            move.w  #1,-(SP)
            _TextMode
            pea     (-$32,A6)
            _GetForeColor
            pea     (-$38,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.b   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$22,A6)
            _HLock
            move.l  (A0),(-$26,A6)
            clr.l   -(SP)
            clr.b   -(SP)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.l  (4,A0),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            mulu.w  #8,D0
.L3:
            tst.w   (8,A0,D0.w)
            beq.b   .L4
            subq.w  #8,D0
            bge.b   .L3
            moveq   #0,D0
.L4:
            move.l  ($A,A0,D0.w),(-$2C,A6)
            move.w  ($E,A0,D0.w),(-$28,A6)
.L5:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D6
            move.w  D6,D7
            andi.w  #7,D6
            clr.l   (A0)
            movea.l (A3),A0
            cmpi.w  #2,D0
            bls.w   .L6
            subq.w  #7,D0
.L6:
            add.w   D0,D0
            lea     .L9,A1
            adda.w  (0,A1,D0.w),A1
            jsr     (A1)
            tst.b   (-$16,A6)
            beq.b   .L7
            movea.l (-$22,A6),A0
            _HUnlock
            pea     (-$32,A6)
            _RGBForeColor
            pea     (-$38,A6)
            _RGBBackColor
            _TextMode
.L7:
            pea     (-$14,A6)
            _SetPenState
.L8:
            movem.l (SP)+,D3-D7/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L9:
            dc.w    $0034,$028C,$02C4,$02BE,$02BE
.L10:
            rts
sub_408799E4:
            move.l  D1,-(SP)
            movea.l (-$26,A6),A0
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
            tst.b   ($10,A0)
            beq.b   RsrcCDEF_0.L10
            bsr.w   sub_40879C4A
            tst.b   (-$16,A6)
            beq.b   .L7
            tst.b   D6
            beq.b   .L3
            pea     (-$2C,A6)
            bra.b   .L6
.L3:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            subq.b  #1,D0
            cmpi.b  #$FD,D0
            bcc.b   .L4
            moveq   #2,D0
            bra.b   .L5
.L4:
            moveq   #1,D0
.L5:
            bsr.b   sub_408799E4
.L6:
            _RGBBackColor
            movea.l (A3),A0
.L7:
            lea     (8,A0),A4
            tst.b   D6
            beq.b   .L8
            tst.b   D3
            bne.b   .L9
.L8:
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _EraseRoundRect
.L9:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($44,A0),-(SP)
            move.w  ($4A,A0),-(SP)
            subq.w  #8,D7
            bge.b   .L11
            clr.l   ($44,A0)
            move.w  #$C,D0
            tst.w   ROM85
            bmi.b   .L10
            move.w  SysFontSize,D0
            bne.b   .L10
            move.b  FMDefaultSize,D0
.L10:
            move.w  D0,($4A,A0)
.L11:
            move.l  ($1C,A0),-(SP)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A2
            _GetClip
            movea.l (A3),A0
            pea     (8,A0)
            _ClipRect
            move.l  A2,-(SP)
            move.l  (4,SP),-(SP)
            _SectRgn
            movem.l D4/A2-A3,-(SP)
            movea.l (A3),A0
            lea     ($28,A0),A2
            lea     (8,A0),A4
            moveq   #0,D7
            move.b  (A2),D7
            beq.w   .L20
            moveq   #0,D4
.L12:
            addq.w  #1,D4
            bsr.w   Pt2Next
            tst.b   D7
            bpl.b   .L12
            move.b  (A2),D7
            subq.w  #8,SP
            movea.l SP,A3
            move.l  A3,-(SP)
            _GetFontInfo
            bsr.w   sub_40879BF4
            mulu.w  D4,D0
            move.w  (4,A4),D1
            move.w  D1,D5
            sub.w   (A4),D1
            sub.w   D0,D1
            asr.w   #1,D1
            sub.w   D1,D5
            sub.w   (6,A3),D5
            sub.w   (2,A3),D5
.L13:
            bsr.w   Pt2Next
            clr.w   -(SP)
            move.l  A2,-(SP)
            move.w  D7,D0
            addq.b  #2,D0
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            _TextWidth
            move.w  (SP)+,D0
            tst.b   D6
            beq.b   .L15
            tst.w   ROM85
            bmi.b   .L14
            tst.w   TESysJust
            beq.b   .L14
            move.w  (6,A4),D1
            sub.w   (2,A4),D1
            sub.w   D0,D1
            subi.w  #$12,D1
            add.w   (2,A4),D1
            bra.b   .L16
.L14:
            move.w  (2,A4),D1
            addi.w  #$12,D1
            bra.b   .L16
.L15:
            move.w  (6,A4),D1
            sub.w   (2,A4),D1
            sub.w   D0,D1
            asr.w   #1,D1
            add.w   (2,A4),D1
.L16:
            move.w  D1,-(SP)
            move.w  D5,-(SP)
            _MoveTo
            tst.b   (-$16,A6)
            beq.b   .L19
            tst.b   D6
            bne.b   .L17
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.b  ($11,A0),D0
            subq.w  #1,D0
            cmpi.b  #$FD,D0
            bcc.b   .L17
            move.w  #1,D0
            bra.b   .L18
.L17:
            move.w  #2,D0
.L18:
            bsr.w   sub_408799E4
            _RGBForeColor
.L19:
            move.l  A2,-(SP)
            move.w  D7,D0
            addq.b  #2,D0
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            _DrawText
            bsr.w   sub_40879BF4
            sub.w   D0,D5
            tst.b   D7
            bpl.w   .L13
            addq.w  #8,SP
.L20:
            movem.l (SP)+,D4/A2-A3
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (SP)+,($4A,A0)
            move.l  (SP)+,($44,A0)
            tst.b   (-$16,A6)
            beq.b   .L21
            moveq   #0,D0
            bsr.w   sub_408799E4
            _RGBForeColor
.L21:
            tst.b   D6
            bne.w   sub_40879C4A.L6
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _FrameRoundRect
            tst.b   (-$16,A6)
            beq.b   .L22
            movea.l (A3),A0
            cmpi.b  #$FE,($11,A0)
            bcc.b   sub_40879BF4.L1
            bra.b   .L23
.L22:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            beq.b   .L23
            cmpi.b  #$FE,D0
            bcc.b   sub_40879BF4.L1
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _InverRoundRect
.L23:
            _PenNormal
            move.l  A2,-(SP)
            _SetClip
            move.l  A2,-(SP)
            _DisposRgn
            rts
Pt2Next:
            moveq   #0,D3
            tst.b   D7
            beq.b   .L2
.L1:
            cmpi.b  #$D,(0,A2,D7.w)
            beq.b   .L2
            addq.w  #1,D3
            subq.b  #1,D7
            bne.b   .L1
.L2:
            subq.b  #1,D7
            rts
sub_40879BF4:
            moveq   #0,D0
            add.w   (A3),D0
            add.w   (2,A3),D0
            add.w   (6,A3),D0
            rts
.L1:
            bsr.b   DisableText
            bra.b   sub_408799E4.L23
DisableText:
            tst.b   (-$16,A6)
            beq.b   .L1
            tst.b   D6
            bne.b   .L1
            moveq   #2,D0
            bsr.w   sub_408799E4
            _RGBForeColor
            moveq   #1,D0
            bsr.w   sub_408799E4
            _RGBBackColor
.L1:
            move.l  A4,-(SP)
            move.l  #$10003,-(SP)
            _InsetRect
            move.l  A4,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            _PaintRect
            _PenNormal
            move.l  A4,-(SP)
            move.l  #$FFFFFFFD,-(SP)
            _InsetRect
            rts
sub_40879C4A:
            tst.b   D6
            bne.b   .L1
            move.w  ($C,A0),D4
            sub.w   (8,A0),D4
            lsr.w   #1,D4
            move.w  D4,D0
            swap    D4
            move.w  D0,D4
            rts
.L1:
            moveq   #0,D4
            rts
            move.b  ($11,A0),D4
            addq.b  #1,D4
            beq.b   .L2
            clr.w   -(SP)
            move.l  D3,-(SP)
            pea     (8,A0)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L2
            addq.b  #1,D4
            beq.b   .L3
            move.w  #$A,($16,A6)
            tst.b   D6
            beq.b   .L2
            addq.w  #1,($16,A6)
.L2:
            rts
.L3:
            move.w  #$FE,($16,A6)
            rts
            move.b  #1,($17,A6)
            tst.b   D6
            bne.b   .L5
            bsr.b   sub_40879C4A
            _HidePen
            _OpenRgn
            movea.l A3,A0
            _HLock
            movea.l (A3),A0
            pea     (8,A0)
            move.l  D4,-(SP)
            _FrameRoundRect
            move.l  D3,-(SP)
            _CloseRgn
            _ShowPen
            movea.l A3,A0
            _HUnlock
.L4:
            movea.l (A5),A0
            lea     (-$18,A0),A0
            move.l  (A0)+,DragPattern
            move.l  (A0),($A38).w
            rts
.L5:
            move.l  D3,-(SP)
            pea     (8,A0)
            _RectRgn
            bra.b   .L4
.L6:
            tst.b   (-$16,A6)
            beq.b   .L7
            pea     (-$2C,A6)
            _RGBBackColor
.L7:
            subq.w  #8,SP
            move.w  (4,A4),D0
            move.w  D0,D1
            sub.w   (A4),D0
            subi.w  #$C,D0
            asr.w   #1,D0
            sub.w   D0,D1
            move.w  D1,(4,SP)
            subi.w  #$C,D1
            move.w  D1,(SP)
            tst.w   ROM85
            bmi.b   .L8
            tst.w   TESysJust
            beq.b   .L8
            move.w  (6,A4),D1
            subq.w  #2,D1
            move.w  D1,(6,SP)
            subi.w  #$C,D1
            move.w  D1,(2,SP)
            bra.b   .L9
.L8:
            move.w  (2,A4),D1
            addq.w  #2,D1
            move.w  D1,(2,SP)
            addi.w  #$C,D1
            move.w  D1,(6,SP)
.L9:
            move.l  SP,-(SP)
            _EraseRect
            movea.l (A3),A0
            move.w  ($12,A0),D5
            move.b  ($11,A0),D0
            beq.b   .L11
            cmpi.b  #$FE,D0
            bcs.b   .L10
            bsr.w   DisableText
            bra.b   .L11
.L10:
            move.l  #$20002,-(SP)
            _PenSize
.L11:
            move.l  SP,-(SP)
            cmpi.b  #2,D6
            beq.b   .L12
            _FrameRect
            bra.b   .L13
.L12:
            _FrameOval
.L13:
            _PenNormal
            lsr.w   #1,D5
            bcc.b   .L15
            cmpi.w  #2,D6
            beq.b   .L14
            move.l  SP,-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            move.l  (SP),-(SP)
            _MoveTo
            move.l  (4,SP),-(SP)
            _LineTo
            move.w  (6,SP),-(SP)
            move.w  (2,SP),-(SP)
            subq.w  #1,(SP)
            _MoveTo
            move.w  (2,SP),-(SP)
            subq.w  #1,(SP)
            move.w  (6,SP),-(SP)
            _LineTo
            bra.b   .L15
.L14:
            move.l  SP,-(SP)
            move.l  #$30003,-(SP)
            _InsetRect
            move.l  SP,-(SP)
            _PaintOval
.L15:
            addq.w  #8,SP
            bra.w   sub_408799E4.L23

            EVEN
