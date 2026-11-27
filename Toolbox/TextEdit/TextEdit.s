            include "Include/ROMHeader.s"

            EXPORT  TEActivate,TEAutoView,TECalText,TEClick,TECopy,TECut
            EXPORT  TEDeactivate,TEDelete,TEDispatch,TEDispose,TEGetOffset,TEGetText
            EXPORT  TEGlobalInit,TEIdle,TEInit,TEInsert,TEKey,TENew
            EXPORT  TEPaste,TEPinScroll,TEScroll,TESelView,TESetJust,TESetSelect
            EXPORT  TESetText,TESTYLNEW,TEUpdate,TextBox,vChar2Pixel,vPixel2Char
            EXPORT  XFINDLINE,XFINDWORD,XTrimMeasure

            IMPORT  A

            SECTION "TextEdit",CODE

TextEdit:
            dc.w    $2912,$360E,$3A1E,$386A,$3A88,$3A9A,$3B32,$3C40
            dc.w    $3AB0,$3CC0,$3D46,$3B80,$3CFA,$3D14,$33CC
.L1:
            dc.w    $0090,$0AB8,$0094,$0BF8,$0098,$0D26,$009C,$0D76
            dc.w    $00A0,$0E8E,$00A4,$0F62,$00A8,$1026,$00AC,$105C
            dc.w    $00B0,$10D6,$00B4,$10EE,$00B8,$1938,$00BC,$1F6A
            dc.w    $00C0,$12C4,$00C4,$1446,$00C8,$1510,$00CC,$15A4
            dc.w    $00D0,$165E,$00D4,$16CA,$00D8,$2D48,$00DC,$2D9C
            dc.w    $00E0,$2E20,$00E4,$3020,$00E8,$308A,$00EC,$3138
            dc.w    $00F0,$31BE,$00F4,$368A,$00F8,$3958
            ds.b    4
TEGlobalInit:
            movem.l A2-A3,-(SP)
            lea     TextEdit.L1,A0
            movea.l A0,A1
            movea.l ExpandMem,A2
.L1:
            move.l  (A1)+,D0
            beq.b   .L2
            lea     (0,A0,D0.w),A3
            swap    D0
            move.l  A3,(0,A2,D0.w)
            bra.b   .L1
.L2:
            movem.l (SP)+,A2-A3
            rts
TEInit:
            moveq   #0,D0
            move.w  D0,TEScrpLength
            _NewHandle
            move.l  A0,TEScrpHandle
            lea     sub_40822A70,A0
            move.l  A0,TEDoText
            lea     XReCalLines,A0
            move.l  A0,TERecal
            lea     sub_408240B4,A0
            move.l  A0,TEWdBreak
            movea.l IntlSpec,A0
            tst.b   (4,A0)
            beq.b   .L3
            move.w  ($26,A0),D0
            lsl.w   #2,D0
            movea.l ($72,A0,D0.w),A0
            move.b  (6,A0),D0
            ext.w   D0
            move.w  D0,TESysJust
            movea.l ExpandMem,A0
            lea     ($46,A0),A0
            move.b  #$FF,(A0)
            move.w  #1,(6,A0)
            clr.b   WordRedraw
            moveq   #0,D1
.L1:
            clr.l   -(SP)
            move.w  D1,-(SP)
            move.w  #$A,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            or.b    D0,WordRedraw
            bmi.b   .L2
            addq.w  #4,D1
            cmpi.w  #$80,D1
            bls.b   .L1
.L2:
            clr.l   -(SP)
            move.w  #4,-(SP)
            move.l  #$84020008,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            movea.l ExpandMem,A0
            move.b  D0,($2C,A0)
            lea     sub_408240B4,A1
            move.l  A1,D0
            _StripAddress
            movea.l ExpandMem,A0
            move.l  D0,($40,A0)
.L3:
            rts
            dc.w    $A9C9
TEGetText:
            bsr.w   StdEntry_StyledTextEdit
            move.l  ($3E,A3),(A2)
            bra.w   TECalText.L1
TEDispose:
            link.w  A6,#0
            movem.l D2-D7/A2-A4,-(SP)
            movea.l (8,A6),A4
            movea.l (A4),A3
            movea.l ($3E,A3),A0
            _DisposHandle
            movea.l ($42,A3),A0
            _DisposHandle
            tst.w   ($50,A3)
            bpl.b   .L1
            movea.l ($4A,A3),A2
            movea.l (A2),A2
            movea.l (4,A2),A0
            _DisposHandle
            movea.l (8,A2),A0
            _DisposHandle
            bsr.b   DisposRsrved
            movea.l ($4A,A3),A0
            _DisposHandle
.L1:
            movea.l A4,A0
            _DisposHandle
            moveq   #4,D0
            bra.w   TECalText.L5
DisposRsrved:
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            move.l  A0,-(SP)
            movea.l (A0),A0
            movea.l (4,A0),A0
            _DisposHandle
            movea.l (SP)+,A0
            _DisposHandle
            rts
TextBox:
            link.w  A6,#0
            movem.l D2-D7/A2-A4,-(SP)
            tst.w   (8,A6)
            bne.b   .L1
            move.w  TESysJust,(8,A6)
.L1:
            cmpi.w  #$FFFE,(8,A6)
            bne.b   .L2
            clr.w   (8,A6)
.L2:
            movea.l ($12,A6),A0
            move.l  ($E,A6),D0
            blt.b   .L7
            beq.b   .L4
.L3:
            cmpi.b  #$D,(A0)+
            beq.b   .L8
            subq.l  #1,D0
            bne.b   .L3
.L4:
            subq.w  #2,SP
            move.l  ($12,A6),-(SP)
            clr.w   -(SP)
            move.w  ($10,A6),-(SP)
            _TextWidth
            move.w  (SP)+,D3
            movea.l ($A,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            subq.w  #2,D0
            cmp.w   D3,D0
            ble.b   .L8
            move.l  A0,-(SP)
            _EraseRect
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetFontInfo
            move.w  (SP)+,D0
            addq.w  #6,SP
            movea.l ($A,A6),A0
            move.l  (A0),-(SP)
            add.w   D0,(SP)
            addq.w  #1,(2,SP)
            _MoveTo
            tst.w   (8,A6)
            beq.b   .L6
            movea.l ($A,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            sub.w   D3,D0
            subq.w  #1,D0
            tst.w   (8,A6)
            bmi.b   .L5
            asr.w   #1,D0
.L5:
            move.w  D0,-(SP)
            clr.w   -(SP)
            _Move
.L6:
            move.l  ($12,A6),-(SP)
            clr.w   -(SP)
            move.w  ($10,A6),-(SP)
            _DrawText
.L7:
            bra.b   .L10
.L8:
            subq.w  #4,SP
            move.l  ($A,A6),-(SP)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            _EraseRect
            _TENew
            movea.l (SP)+,A4
            movea.l (A4),A0
            move.w  (8,A6),($3A,A0)
            move.l  ($E,A6),D0
            beq.b   .L9
            move.l  ($12,A6),-(SP)
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            _TESetText
            move.l  ($A,A6),-(SP)
            move.l  A4,-(SP)
            _TEUpdate
.L9:
            move.l  A4,-(SP)
            _TEDispose
.L10:
            moveq   #$E,D0
            bra.w   TECalText.L5
TESetText:
            bsr.w   StdEntry_StyledTextEdit
            move.l  (A2)+,D0
            move.w  D0,($20,A3)
            move.w  D0,($22,A3)
            move.w  D0,($3C,A3)
            movea.l ($3E,A3),A0
            move.l  D0,-(SP)
            _HUnlock
            move.l  (SP)+,D0
            movea.l (A2)+,A0
            movea.l ($3E,A3),A1
            _PtrToXHand
            movea.l ($3E,A3),A0
            _HLock
            bsr.b   SetOneStyle
            bsr.w   CalText
.L1:
            bra.w   TEInsert.L1
SetOneStyle:
            tst.w   ($50,A3)
            bpl.b   .L1
            movea.l ($4A,A3),A0
            moveq   #$1C,D0
            bsr.b   MySetHandleSize
            movea.l (A0),A0
            movea.l (4,A0),A0
            moveq   #$12,D0
            bsr.b   MySetHandleSize
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            move.w  ($3C,A3),D0
            addq.w  #1,D0
            bsr.b   GetDefStyle
.L1:
            rts
MySetHandleSize:
            movem.l D0/A0,-(SP)
            movea.l ($3E,A3),A0
            _HUnlock
            movem.l (SP)+,D0/A0
            _SetHandleSize
            bne.b   .L1
            movem.l D0/A0,-(SP)
            movea.l ($3E,A3),A0
            _HLock
            movem.l (SP)+,D0/A0
            rts
.L1:
            move.w  #$19,D0
            _SysError
GetDefStyle:
            move.w  #1,(A0)
            move.w  #1,(2,A0)
            lea     ($14,A0),A1
            clr.l   (A1)+
            move.w  D0,(A1)+
            move.w  #$FFFF,(A1)
            movea.l (4,A0),A0
            movea.l (A0),A0
            move.w  #1,(A0)
            bsr.b   GetSize
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            move.w  D0,(4,A0)
            move.w  D1,(2,A0)
            movea.l ($52,A3),A1
            move.w  ($44,A1),(6,A0)
            move.w  ($46,A1),(8,A0)
            move.l  A0,-(SP)
            move.w  (6,A0),D1
            lea     (9,A0),A0
            bsr.w   SetDirection
            movea.l (SP)+,A0
            move.w  ($4A,A1),($A,A0)
            pea     ($C,A0)
            _GetForeColor
            rts
GetSize:
            move.l  A0,-(SP)
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetFontInfo
            move.w  (SP)+,D0
            move.w  D0,D1
            add.w   (SP)+,D1
            addq.w  #2,SP
            add.w   (SP)+,D1
            movea.l (SP)+,A0
            rts
CalText:
            move.l  ($20,A3),-(SP)
            clr.w   ($20,A3)
            move.w  #$8001,D7
            clr.l   ($60,A3)
            bsr.w   sub_408243B2
            move.l  (SP)+,($20,A3)
            rts
TECalText:
            bsr.w   StdEntry_StyledTextEdit
            bsr.b   CalText
.L1:
            moveq   #4,D0
.L2:
            movea.l (8,A6),A4
            bra.b   .L4
.L3:
            movea.l ($A,A6),A4
.L4:
            movea.l (A4),A3
            move.w  D0,D4
            movea.l ($3E,A3),A0
            move.b  (-$C,A6),D0
            _HSetState
            move.l  (-$A,A6),-(SP)
            move.l  (SP),-(SP)
            _SetClip
            _DisposRgn
            movea.l A4,A0
            move.b  (-2,A6),D0
            _HSetState
            pea     (-$18,A6)
            _RGBForeColor
            movea.l (A4),A3
            movea.l ($52,A3),A0
            move.w  (-$12,A6),($4A,A0)
            move.w  (-$10,A6),($46,A0)
            move.w  (-$E,A6),($44,A0)
            move.l  (-6,A6),-(SP)
            _SetPort
            move.w  D4,D0
.L5:
            movem.l (SP)+,D2-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
TESetSelect:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   ClearRsrved
            bsr.w   HideCaret
            bsr.w   HiLite
            move.w  ($E,A6),($22,A3)
            move.w  ($12,A6),($20,A3)
            bsr.w   CleanUpSel
            tst.w   ($50,A3)
            bpl.b   .L1
            move.w  ($20,A3),D0
            bsr.w   GetCurStyle
            bsr.w   SetStyle
            bsr.w   sub_408250B2
.L1:
            bsr.w   ShowCaret
            bsr.w   HiLite
            bsr.w   SelView
            bra.w   TESetText.L1
TENew:
            link.w  A6,#0
            movem.l D2-D7/A2-A4,-(SP)
            clr.l   ($10,A6)
            moveq   #$68,D0
            _NewHandleClear
            bne.w   MySetHandleSize.L1
            movea.l A0,A4
            _HLock
            movea.l (A4),A3
            moveq   #0,D0
            _NewHandle
            bne.w   MySetHandleSize.L1
            move.l  A0,($3E,A3)
            lea     (A3),A0
            movea.l ($C,A6),A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            movea.l (8,A6),A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            bsr.w   GetSize
            move.w  D0,($1A,A3)
            move.w  D1,($18,A3)
            movea.l (A5),A2
            movea.l (A2),A2
            move.l  A2,($52,A3)
            move.l  ($44,A2),($4A,A3)
            move.l  ($48,A2),($4E,A3)
            move.l  A0,-(SP)
            move.w  ($4A,A3),D1
            lea     ($4D,A3),A0
            bsr.w   SetDirection
            movea.l (SP)+,A0
            move.l  TEWdBreak,($26,A3)
            lea     DefClikProc,A0
            move.l  A0,($2A,A3)
            bsr.b   InstallIntDispatch
            movea.l ($3E,A3),A0
            _HUnlock
            movea.l A4,A0
            _HUnlock
            move.l  A4,($10,A6)
            moveq   #8,D0
            bra.w   TECalText.L5
ClearRsrved:
            tst.w   ($50,A3)
            bpl.b   .L1
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            movea.l (A0),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            clr.w   (A0)
.L1:
            rts
InstallIntDispatch:
            moveq   #$14,D0
            bsr.w   MyNewHandle
            move.l  A0,($42,A3)
            movea.l (A0),A0
            lea     sub_4082285A,A1
            move.l  A1,(A0)
            lea     sub_40822884,A1
            move.l  A1,(4,A0)
            lea     sub_40823896,A1
            move.l  A1,(8,A0)
            lea     sub_40822690,A1
            move.l  A1,($C,A0)
            clr.l   ($10,A0)
            rts
TESTYLNEW:
            link.w  A6,#0
            movem.l D2-D7/A2-A4,-(SP)
            clr.l   ($10,A6)
            moveq   #$68,D0
            _NewHandleClear
            bne.w   MySetHandleSize.L1
            movea.l A0,A4
            _HLock
            movea.l (A4),A3
            moveq   #0,D0
            _NewHandle
            bne.w   MySetHandleSize.L1
            move.l  A0,($3E,A3)
            lea     (A3),A0
            movea.l ($C,A6),A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            movea.l (8,A6),A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.w  #$FFFF,($50,A3)
            moveq   #$1C,D0
            bsr.w   MyNewHandle
            move.l  A0,($4A,A3)
            moveq   #$12,D0
            bsr.w   MyNewHandle
            movea.l ($4A,A3),A2
            movea.l (A2),A2
            move.l  A0,(4,A2)
            moveq   #4,D0
            bsr.w   MyNewHandle
            movea.l A0,A1
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            move.l  A1,(8,A0)
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  A1,($52,A3)
            move.w  ($48,A1),($4E,A3)
            moveq   #1,D0
            bsr.w   GetDefStyle
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A1
            movea.l (A1),A1
            movea.l (4,A0),A0
            movea.l (A0),A0
            move.w  (4,A0),(2,A1)
            move.w  (2,A0),(A1)
            move.w  #$FFFF,($1A,A3)
            move.w  #$FFFF,($18,A3)
            move.l  TEWdBreak,($26,A3)
            lea     DefClikProc,A0
            move.l  A0,($2A,A3)
            bsr.w   InstallIntDispatch
            bsr.b   InitRsrved
            movea.l ($3E,A3),A0
            _HUnlock
            movea.l A4,A0
            _HUnlock
            move.l  A4,($10,A6)
            moveq   #8,D0
            bra.w   TECalText.L5
InitRsrved:
            move.l  A2,-(SP)
            moveq   #8,D0
            bsr.b   MyNewHandle
            movea.l ($4A,A3),A2
            movea.l (A2),A2
            move.l  A0,($10,A2)
            move.l  A0,-(SP)
            moveq   #$16,D0
            bsr.b   MyNewHandle
            movea.l (SP)+,A2
            movea.l (A2),A2
            move.l  A0,(4,A2)
            movea.l (A0),A0
            clr.w   (A0)
            movea.l (SP)+,A2
            rts
MyNewHandle:
            move.l  D0,-(SP)
            movea.l ($3E,A3),A0
            _HUnlock
            movea.l A4,A0
            _HUnlock
            move.l  (SP)+,D0
            _NewHandle
            bne.w   MySetHandleSize.L1
            move.l  A0,-(SP)
            movea.l A4,A0
            _HLock
            movea.l (A4),A3
            movea.l ($3E,A3),A0
            _HLock
            movea.l (SP)+,A0
            rts
TEUpdate:
            bsr.w   StdEntry_StyledTextEdit
            movea.l (A2)+,A0
            bsr.w   Refresh
            bra.w   TEScroll.L1
ClickExpand:
            move.w  D6,D0
            move.w  D6,D1
            tst.l   D5
            bpl.b   .L1
            bsr.w   sub_40823F34
.L1:
            rts
HiLite:
            tst.b   ($24,A3)
            beq.b   ClickExpand.L1
            movem.w ($20,A3),D3-D4
            moveq   #1,D7
            bra.w   DoText
TEClick:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   ClearRsrved
            move.l  ($E,A6),($1C,A3)
            bsr.w   DOFIND
            bsr.w   HideCaret
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   ($2E,A3),D0
            cmp.l   DoubleTime,D0
            sle     D5
            cmp.w   ($32,A3),D6
            seq     D1
            and.b   D1,D5
            ror.l   #8,D5
            move.w  D6,($32,A3)
            tst.w   ($50,A3)
            bpl.b   .L1
            move.w  D6,D0
            bsr.w   GetCurStyle
            bsr.w   SetStyle
            bsr.w   sub_408250B2
.L1:
            tst.b   ($C,A6)
            beq.b   .L4
            movem.w ($20,A3),D0-D1
            cmp.w   D6,D0
            bcc.b   .L2
            movea.w D0,A2
            movea.w D0,A4
            bra.b   .L3
.L2:
            movea.w D1,A2
            movea.w D1,A4
.L3:
            move.w  D6,D5
            bra.b   .L7
.L4:
            bsr.b   HiLite
            moveq   #4,D2
            bsr.w   ClickExpand
            movem.w D0-D1,($20,A3)
            movea.w D0,A2
            movea.w D1,A4
            move.w  D6,D5
            move.b  ($46,A3),($47,A3)
            bsr.w   ShowCaret
            bsr.w   HiLite
.L5:
            move.l  ($2A,A3),D0
            beq.b   .L6
            movea.l D0,A0
            jsr     (A0)
            beq.b   .L11
.L6:
            clr.w   -(SP)
            _WaitMouseUp
            tst.w   (SP)+
            beq.b   .L11
            pea     ($1C,A3)
            _GetMouse
            bsr.b   DOFIND
            cmp.w   D6,D5
            beq.b   .L5
            bsr.w   HideCaret
.L7:
            moveq   #8,D2
            bsr.w   ClickExpand
            lea     ($22,A3),A0
            cmpa.w  D6,A4
            bcs.b   .L8
            move.w  -(A0),D3
            move.w  D0,(A0)+
            move.w  D0,D4
            swap    D3
            swap    D4
            move.w  A4,D3
            move.w  (A0)+,D4
            move.w  A4,-(A0)
            bra.b   .L9
.L8:
            cmpa.w  D6,A2
            bhi.b   .L10
            move.w  (A0)+,D3
            move.w  D1,-(A0)
            move.w  D1,D4
            swap    D3
            swap    D4
            move.w  -(A0),D3
            move.w  A2,D4
            move.w  A2,(A0)+
.L9:
            moveq   #1,D7
            bsr.w   DoText
            swap    D3
            swap    D4
            bsr.w   DoText
.L10:
            move.w  D6,D5
            bra.b   .L5
.L11:
            bsr.w   ShowCaret
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,($2E,A3)
            moveq   #$A,D0
            bra.w   TECalText.L2
DOFIND:
            move.w  ($1C,A3),D0
            bsr.w   PtToLine
            bge.b   .L1
            add.w   D0,D0
            bpl.b   .L2
            moveq   #0,D6
            rts
.L1:
            move.w  ($3C,A3),D6
            rts
.L2:
            movem.w ($60,A3,D0.w),D3-D4
            moveq   #0,D7
            bsr.w   DoText
            move.w  D0,D6
            rts
sub_40822690:
            move.l  ($798).w,-(SP)
            rts
vPixel2Char:
            link.w  A6,#-$E
            move.w  D0,(-4,A6)
            move.l  A0,(-8,A6)
            move.w  D1,(-$A,A6)
            move.w  D2,(-$C,A6)
            subq.l  #2,SP
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            _TextWidth
            moveq   #0,D0
            move.w  (SP)+,D0
            moveq   #0,D2
            move.w  (-4,A6),D1
            cmp.w   (-$A,A6),D0
            bls.b   .L1
            move.w  D0,(-$E,A6)
            clr.w   -(SP)
            move.l  (-8,A6),-(SP)
            move.w  (-4,A6),-(SP)
            move.w  (-$C,A6),-(SP)
            move.w  (-$A,A6),-(SP)
            pea     (-2,A6)
            move.l  #$820E0014,-(SP)
            _ScriptUtil
            move.w  (SP)+,D1
            move.w  (-$E,A6),D0
            bset    #$10,D0
            clr.w   D2
            move.b  (-2,A6),D2
            beq.b   .L1
            addq.w  #1,D1
.L1:
            unlk    A6
            rts
DoSearch:
            bsr.w   Preamble
            move.w  (A2),D3
            move.w  D3,D4
            bsr.w   LINERECT
            move.w  (A2),D7
            sf      ($46,A3)
            move.w  ($1E,A3),D5
            sub.w   ($12,A3),D5
            ble.w   .L10
            move.w  ($12,A3),($16,A3)
            move.w  #$8002,($12,A3)
            move.w  (2,A2),D6
            tst.w   ($50,A3)
            bmi.b   .L1
            st      (-6,A6)
            moveq   #1,D2
            move.w  D3,D1
            move.w  D6,D0
            bra.b   .L7
.L1:
            sf      (-6,A6)
            tst.b   WordRedraw
            bge.b   .L3
            move.w  D3,D0
            move.w  D6,D1
            bsr.w   GetStylesInOrder
            bge.b   .L4
            bra.w   .L9
.L2:
            movea.l (-$C,A6),A0
            move.w  (-8,A6),D0
            lsl.w   #1,D0
            lea     (-$10,A6),A1
            movea.l (A1),A1
            move.w  (0,A1,D0.w),D0
            lsl.w   #2,D0
            lea     (0,A0,D0.w),A0
            addq.w  #1,(-8,A6)
            subq.w  #1,D2
            bge.b   .L4
            bra.b   .L9
.L3:
            st      (-6,A6)
            move.w  D3,D0
            move.w  D6,D1
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
            move.w  D0,D2
.L4:
            movea.l A0,A2
            movea.l ($4A,A3),A0
            _HLock
            movea.l A2,A0
.L5:
            movea.l A0,A2
            bsr.w   SetStyle
            move.w  (A0),D1
            addq.l  #4,A0
            move.w  (A0),D0
            cmp.w   D3,D1
            bcc.b   .L6
            move.w  D3,D1
.L6:
            move.w  D1,D7
            cmp.w   D0,D6
            bcc.b   .L7
            move.w  D6,D0
.L7:
            move.w  D2,-(SP)
            sub.w   D1,D0
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  D1,A0
            move.w  D5,D1
            moveq   #0,D2
            bsr.w   TEHitTestHook
            add.w   D0,($16,A3)
            add.w   D1,D7
            sub.w   D0,D5
            ble.b   .L12
            movea.l A2,A0
            move.w  (SP)+,D2
            bne.b   .L8
            bra.b   .L9
.L8:
            tst.b   (-6,A6)
            beq.w   .L2
            addq.l  #4,A0
            subq.w  #1,D2
            bne.b   .L5
.L9:
            move.w  #$7FFE,($16,A3)
            move.w  D3,D0
            lea     ($60,A3),A2
            bsr.w   GetLine
            bra.b   .L11
.L10:
            st      D2
.L11:
            move.w  (2,A2),D7
            cmp.b   TESysJust,D2
            beq.b   .L13
            move.w  (A2),D7
            st      ($46,A3)
            tst.b   D2
            bne.b   .L17
            bra.b   .L16
.L12:
            addq.l  #2,SP
            tst.w   D2
            beq.b   .L16
            subq.w  #1,D7
            st      ($46,A3)
            cmp.w   (2,A2),D7
            bne.b   .L14
.L13:
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            move.b  (-1,A0,D7.w),D0
            bsr.b   TEEolHook
            beq.b   .L15
.L14:
            tst.w   D5
            ble.b   .L17
            bra.b   .L16
.L15:
            subq.w  #1,D7
            st      ($46,A3)
.L16:
            tst.w   ($50,A3)
            bpl.b   .L17
            movea.l ($4A,A3),A0
            _HUnlock
            bsr.w   FreeFmtOrderArray
.L17:
            move.w  D7,D0
            bra.w   DoDraw.L12
TEEolHook:
            movea.l ($42,A3),A0
            movea.l (A0),A0
            movea.l (A0),A0
            jmp     (A0)
sub_4082285A:
            cmpi.b  #$D,D0
            rts
sub_40822860:
            movea.l ($42,A3),A1
            movea.l (A1),A1
            movea.l (8,A1),A1
            jmp     (A1)
TEHitTestHook:
            movea.l ($42,A3),A1
            movea.l (A1),A1
            movea.l ($C,A1),A1
            jmp     (A1)
TEDrawHook:
            movea.l ($42,A3),A1
            movea.l (A1),A1
            movea.l (4,A1),A1
            jmp     (A1)
sub_40822884:
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            _DrawText
            rts
DoDraw:
            bsr.w   PinDisplay
            bsr.w   Preamble
            bsr.w   LINERECT
.L1:
            bsr.w   PrepLine
            bls.w   .L11
            bsr.w   ChkBounds
            tst.w   TESysJust
            beq.b   .L2
            move.w  #$8002,($12,A3)
.L2:
            move.w  D4,D6
            bsr.w   DoErase
            move.w  (-2,A6),-(SP)
            move.w  ($10,A3),-(SP)
            move.w  ($1A,A3),D0
            tst.w   ($50,A3)
            bmi.b   .L3
            add.w   D0,(SP)
            _MoveTo
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.l  D3,A0
            clr.w   D0
            move.w  D4,D1
            sub.w   D3,D1
            bsr.b   TEDrawHook
            bra.w   .L10
.L3:
            tst.w   D0
            bpl.b   .L4
            bsr.w   PtrToLine
            ext.l   D0
            lsl.l   #2,D0
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            move.w  (2,A0,D0.l),D0
.L4:
            add.w   D0,(SP)
            _MoveTo
            sf      (-6,A6)
            tst.b   WordRedraw
            bge.b   .L6
            move.w  D3,D0
            move.w  D4,D1
            bsr.w   GetStylesInOrder
            bge.b   .L7
            bra.b   .L10
.L5:
            bsr.w   GetNextDisplayStyle
            addq.w  #1,(-8,A6)
            subq.w  #1,D2
            bge.b   .L7
            bra.b   .L10
.L6:
            st      (-6,A6)
            move.w  D3,D0
            move.w  D4,D1
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
            move.w  D0,D2
.L7:
            move.l  A0,-(SP)
            bsr.w   SetStyle
            move.w  (A0),D0
            addq.w  #4,A0
            move.w  D6,D4
            cmp.w   (A0),D6
            bcs.b   .L8
            move.w  (A0),D4
.L8:
            move.w  D2,-(SP)
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            cmp.w   D3,D0
            bcc.b   .L9
            move.w  D3,D0
.L9:
            adda.w  D0,A0
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            move.l  A1,D1
            sub.l   D1,(2,SP)
            move.w  D4,D1
            sub.w   D0,D1
            clr.w   D0
            bsr.w   TEDrawHook
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            move.l  A1,D1
            add.l   D1,(2,SP)
            move.w  (SP)+,D2
            movea.l (SP)+,A0
            tst.b   (-6,A6)
            beq.b   .L5
            addq.l  #4,A0
            subq.w  #1,D2
            bne.b   .L7
.L10:
            bsr.w   PtrToLine
            addq.w  #1,D0
            bsr.w   NextLineRect
            move.w  (A2),D3
            bra.w   .L1
.L11:
            bsr.w   FreeFmtOrderArray
.L12:
            movem.l (SP)+,D2-D7/A2-A4
            unlk    A6
            movea.l (A5),A0
            movea.l (A0),A0
            rts
DoErase:
            movea.l ExpandMem,A0
            movea.l ($90,A0),A0
            jmp     (A0)
xDoErase:
            move.w  ($12,A3),-(SP)
            cmp.w   (A2),D3
            beq.b   .L5
            cmpi.w  #2,($4E,A3)
            beq.b   .L5
            tst.w   ($50,A3)
            bpl.b   .L3
            tst.b   WordRedraw
            bge.b   .L1
            move.w  D3,D0
            move.w  D4,D1
            bsr.w   GetStylesInOrder
            bra.b   .L2
.L1:
            move.w  D3,D0
            move.w  D0,D1
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
.L2:
            bsr.w   SetStyle
.L3:
            subq.l  #2,SP
            movea.l ($3E,A3),A0
            move.l  (A0),-(SP)
            move.w  D3,-(SP)
            move.w  #1,-(SP)
            _TextWidth
            move.w  (SP)+,D0
            tst.w   D0
            beq.b   .L4
            subq.w  #1,D0
.L4:
            add.w   D0,($12,A3)
.L5:
            pea     ($10,A3)
            _EraseRect
            move.w  (SP)+,($12,A3)
            bsr.w   FreeFmtOrderArray
            rts
PrepLine:
            move.w  D5,D4
            cmp.w   (2,A2),D4
            bcs.b   .L1
            move.w  (2,A2),D4
.L1:
            bsr.w   RangeRect
            cmp.w   D3,D5
            rts
Preamble:
            movea.l (SP)+,A0
            movem.l D2-D7/A2-A4,-(SP)
            move.l  A0,-(SP)
            cmp.w   D3,D4
            bcc.b   .L1
            exg     D4,D3
.L1:
            cmp.w   ($3C,A3),D4
            bcs.b   .L2
            move.w  ($3C,A3),D4
.L2:
            lea     ($60,A3),A2
            and.l   sub_408240B4+2,D4
            move.w  D4,D5
            and.l   sub_408240B4+2,D3
            beq.b   .L3
            move.w  D3,D0
            bsr.b   GetLine
.L3:
            rts
GetLine:
            cmp.w   (2,A2),D0
            bls.b   .L1
            addq.w  #2,A2
            bra.b   GetLine
.L1:
            bne.b   .L2
            addq.w  #2,A2
.L2:
            rts
DoText:
            move.l  TEDoText,-(SP)
            rts
sub_40822A70:
            link.w  A6,#-$32
            tst.w   D7
            beq.w   DoSearch
            bgt.w   DOHILITE
            cmpi.w  #$FFFF,D7
            beq.w   DoDraw
DoCaret:
            bsr.b   Preamble
            tst.w   D3
            beq.b   .L3
            cmp.w   (A2),D3
            bne.b   .L3
            move.w  ($3C,A3),D0
            beq.b   .L3
            cmp.w   D0,D3
            bcs.b   .L1
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            move.b  (-1,A0,D3.w),D0
            bsr.w   TEEolHook
            beq.b   .L3
            bra.b   .L2
.L1:
            tst.b   ($47,A3)
            bne.b   .L3
.L2:
            subq.w  #2,A2
.L3:
            bsr.w   LINERECT
            tst.w   ($50,A3)
            bmi.b   .L4
            tst.b   WordRedraw
            bmi.b   .L4
            tst.b   TESysJust
            beq.b   .L5
.L4:
            bsr.b   sub_40822AEC
            move.w  ($12,A3),D0
            move.w  D0,(-2,A6)
            bra.b   .L6
.L5:
            bsr.w   PrepLine
            move.w  (-2,A6),D0
            move.w  D0,($16,A3)
.L6:
            subq.w  #1,D0
            move.w  D0,($12,A3)
            bra.w   DoDraw.L12
sub_40822AEC:
            movea.l ExpandMem,A0
            movea.l ($94,A0),A0
            jmp     (A0)
xCaretDisplay:
            link.w  A6,#-$72
            movea.l ExpandMem,A0
            sf      ($2E,A0)
            sf      ($38,A0)
            sf      (-$2A,A6)
            clr.w   (-$48,A6)
            sf      (-$45,A6)
            clr.w   D5
            bsr.w   GetFormatOrdering
.L1:
            bsr.w   GetNextDisplayStyle
            addq.w  #1,(-8,A6)
.L2:
            cmp.w   (A0),D3
            bhi.b   .L3
            beq.b   .L4
            bra.w   .L10
.L3:
            bsr.w   FixFormatEnd
            cmp.w   D0,D3
            bhi.b   .L10
            blt.b   .L6
            tst.b   (-$48,A6)
            bne.w   .L12
            st      (-$46,A6)
            bra.b   .L5
.L4:
            tst.b   (-$48,A6)
            bne.w   .L12
            sf      (-$46,A6)
.L5:
            st      (-$47,A6)
.L6:
            tst.w   ($50,A3)
            bpl.b   .L7
            bsr.w   SetStyle
.L7:
            tst.b   (-$2A,A6)
            beq.b   .L8
            tst.b   TESysJust
            bne.b   .L8
            moveq   #0,D2
            bsr.w   sub_40822C1A
            add.w   D1,D5
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
            bra.w   .L19
.L8:
            move.w  D2,-(SP)
            bsr.w   sub_40822C6A
            move.w  (SP)+,D2
            tst.b   (-6,A6)
            bne.b   .L17
            tst.b   (-$49,A6)
            bne.b   .L10
            tst.b   (-$45,A6)
            bne.b   .L9
            tst.b   (-$46,A6)
            bne.w   .L1
            bra.b   .L10
.L9:
            tst.b   (-$46,A6)
            beq.w   .L1
.L10:
            move.w  D1,-(SP)
            bsr.w   MeasureWholeRun
            add.w   D0,D5
            move.w  (SP)+,D1
            tst.b   (-$2A,A6)
            bne.b   .L11
            subq.w  #1,D2
            beq.b   .L17
            bra.w   .L1
.L11:
            addq.l  #4,A0
            subq.w  #1,D2
            bne.w   .L2
            bra.b   .L17
.L12:
            tst.b   (-$46,A6)
            bne.b   .L13
            move.b  (-$44,A6),D0
            bra.b   .L14
.L13:
            move.b  (-$43,A6),D0
.L14:
            bne.b   .L15
            tst.b   (-$46,A6)
            beq.b   .L16
            bra.b   .L18
.L15:
            tst.b   (-$46,A6)
            bne.b   .L16
            bra.b   .L18
.L16:
            move.w  D5,-(SP)
            bsr.w   MeasureWholeRun
            add.w   D0,D5
            bra.b   .L18
.L17:
            tst.b   (-$49,A6)
            beq.b   .L19
.L18:
            movea.l ExpandMem,A0
            lea     ($30,A0),A0
            addq.w  #2,A0
            add.w   (-$40,A6),D5
            move.w  D5,(A0)
            subq.w  #1,(A0)+
            addq.w  #2,A0
            move.w  D5,(A0)
.L19:
            bsr.w   FreeFmtOrderArray
            unlk    A6
            rts
sub_40822C1A:
            movea.l ExpandMem,A1
            movea.l ($98,A1),A1
            jmp     (A1)
            move.l  A0,-(SP)
            movea.l ($3E,A3),A1
            movea.l (A1),A1
            adda.w  (A0),A1
            exg     A1,A0
            moveq   #0,D4
            move.w  (A2),D0
            cmp.w   (A1),D0
            bls.b   .L1
            sub.w   (A1),D0
            adda.w  D0,A0
            move.w  D0,D4
            move.w  D3,D1
            sub.w   (A2),D1
            bra.b   .L2
.L1:
            move.w  D3,D1
            sub.w   (A1),D1
.L2:
            move.l  A0,-(SP)
            movea.l A1,A0
            bsr.w   FixFormatEnd
            movea.l (SP)+,A0
            cmp.w   (2,A2),D0
            bls.b   .L3
            move.w  (2,A2),D0
.L3:
            sub.w   (A1),D0
            sub.w   D4,D0
            swap    D2
            bsr.w   sub_40822860
            movea.l (SP)+,A0
            rts
sub_40822C6A:
            movea.l ExpandMem,A1
            movea.l ($9C,A1),A1
            jmp     (A1)
xGetRLPosition:
            movem.l A0,-(SP)
            sf      (-6,A6)
            clr.w   (-$4A,A6)
            st      (-$48,A6)
            moveq   #0,D2
            move.l  A2,-(SP)
            lea     ($10,A3),A1
            lea     (-$42,A6),A2
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            movea.l (SP)+,A2
            tst.b   (-$47,A6)
            beq.w   .L12
            tst.w   ($50,A3)
            bpl.w   .L12
            bsr.w   GetDirection
            tst.b   (-$46,A6)
            beq.b   .L1
            move.b  D1,(-$44,A6)
            cmp.w   (2,A2),D3
            beq.b   .L11
            move.l  A0,-(SP)
            addq.l  #4,A0
            bra.b   .L2
.L1:
            move.b  D1,(-$43,A6)
            cmp.w   (A2),D3
            beq.b   .L11
            move.l  A0,-(SP)
            subq.l  #4,A0
.L2:
            bsr.w   GetDirection
            tst.b   (-$46,A6)
            beq.b   .L3
            move.b  D1,(-$43,A6)
            bra.b   .L4
.L3:
            move.b  D1,(-$44,A6)
.L4:
            movea.l (SP)+,A0
            move.b  (-$43,A6),D0
            cmp.b   (-$44,A6),D0
            bne.b   .L5
            bsr.w   OneCursor
            bra.b   .L13
.L5:
            tst.b   (-$46,A6)
            beq.b   .L6
            move.b  (-$44,A6),D0
.L6:
            move.b  D0,(-$45,A6)
            cmp.b   TESysJust,D0
            bne.b   .L7
            st      (-$4A,A6)
.L7:
            tst.b   D0
            bne.b   .L8
            tst.b   (-$46,A6)
            bne.b   .L9
            bra.b   .L10
.L8:
            tst.b   (-$46,A6)
            bne.b   .L10
.L9:
            bsr.w   MeasureWholeRun
            add.w   D0,D5
.L10:
            bsr.b   SetUp2Rectangles
            bra.b   .L13
.L11:
            bsr.b   OnLineEnd
            bra.b   .L13
.L12:
            bsr.w   sub_40822E56
.L13:
            movem.l (SP)+,A0
            rts
SetUp2Rectangles:
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
            move.w  ($14,A3),D2
            add.w   ($10,A3),D2
            lsr.w   #1,D2
            movea.l ExpandMem,A0
            st      ($2E,A0)
            lea     ($30,A0),A0
            tst.b   (-$4A,A6)
            beq.b   .L1
            move.w  D2,($14,A3)
            move.w  ($14,A3),(A0)+
            addq.w  #2,A0
            move.w  (-$3E,A6),(A0)
            bra.b   .L2
.L1:
            move.w  D2,($10,A3)
            move.w  (-$42,A6),(A0)+
            addq.w  #2,A0
            move.w  ($10,A3),(A0)
            movea.l ExpandMem,A0
            ori.w   #$FF,($2E,A0)
.L2:
            rts
OnLineEnd:
            movea.l ExpandMem,A1
            movea.l ($A0,A1),A1
            jmp     (A1)
            bsr.w   GetDirection
            cmp.b   TESysJust,D1
            bne.b   .L2
            st      (-6,A6)
            tst.b   D1
            bne.b   .L1
            tst.b   (-$46,A6)
            bne.w   .L6
            bra.w   .L7
.L1:
            tst.b   (-$46,A6)
            beq.w   .L6
            tst.b   TESysJust
            beq.w   .L6
            bra.w   .L7
.L2:
            tst.b   D1
            beq.b   .L3
            cmp.w   (2,A2),D3
            beq.b   .L5
            bra.b   .L4
.L3:
            cmp.w   (A2),D3
            beq.b   .L5
.L4:
            move.w  (-$40,A6),($12,A3)
            move.w  (-$40,A6),($16,A3)
            bsr.w   MeasureWholeRun
            add.w   D0,D5
            st      (-6,A6)
            st      (-$49,A6)
            move.w  ($14,A3),D2
            add.w   ($10,A3),D2
            lsr.w   #1,D2
            move.w  D2,($14,A3)
            movea.l ExpandMem,A0
            st      ($2E,A0)
            lea     ($30,A0),A0
            move.w  ($14,A3),(A0)+
            addq.w  #2,A0
            move.w  (-$3E,A6),(A0)
            bra.b   .L7
.L5:
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
            st      (-$49,A6)
            move.w  ($14,A3),D2
            add.w   ($10,A3),D2
            lsr.w   #1,D2
            move.w  D2,($10,A3)
            movea.l ExpandMem,A0
            st      ($2E,A0)
            ori.w   #$FF,($2E,A0)
            lea     ($30,A0),A0
            move.w  (-$42,A6),(A0)+
            addq.w  #2,A0
            move.w  ($10,A3),(A0)
            bra.b   .L7
.L6:
            bsr.w   MeasureWholeRun
            add.w   D0,D5
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
.L7:
            rts
sub_40822E56:
            movea.l ExpandMem,A1
            movea.l ($A4,A1),A1
            jmp     (A1)
            st      (-6,A6)
            move.w  #$FFFF,D2
            swap    D2
            clr.w   D2
            movea.l A0,A1
            move.w  D5,-(SP)
            move.w  D3,D0
            sub.w   (A1),D0
            move.w  (A2),D1
            cmp.w   (A1),D1
            bls.b   .L1
            sub.w   (A1),D1
            sub.w   D1,D0
.L1:
            move.w  D0,D1
            bsr.w   sub_408235BE
            tst.b   TESysJust
            beq.b   .L3
            bsr.w   GetDirection
            cmp.b   TESysJust,D1
            beq.b   .L4
            cmp.w   D5,D6
            beq.b   .L4
            tst.w   D5
            beq.b   .L2
            exg     D5,D6
.L2:
            add.w   (SP),D6
            bra.b   .L5
.L3:
            exg     D5,D6
.L4:
            add.w   (SP),D5
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
            add.w   (SP),D6
            cmp.w   D5,D6
            beq.b   .L6
.L5:
            move.w  ($14,A3),D2
            add.w   ($10,A3),D2
            lsr.w   #1,D2
            move.w  D2,($14,A3)
            movea.l ExpandMem,A0
            st      ($2E,A0)
            andi.w  #$FF00,($2E,A0)
            lea     ($30,A0),A0
            move.w  ($14,A3),(A0)+
            add.w   (-$40,A6),D6
            move.w  D6,(A0)
            subq.w  #1,(A0)+
            move.w  (-$3E,A6),(A0)+
            move.w  D6,(A0)
.L6:
            addq.l  #2,SP
            rts
OneCursor:
            st      (-6,A6)
            bsr.b   GetDirection
            bne.b   .L1
            tst.b   (-$46,A6)
            bne.b   .L2
            bra.b   .L3
.L1:
            tst.b   (-$46,A6)
            beq.b   .L2
            tst.b   TESysJust
            bne.b   .L3
.L2:
            bsr.w   MeasureWholeRun
            add.w   D0,D5
            add.w   D5,($12,A3)
            add.w   D5,($16,A3)
.L3:
            rts
SetDirection:
            movem.l D0/D2/A0-A1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($A8,A0),A0
            jmp     (A0)
            subq.w  #6,SP
            move.w  D1,-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            move.w  #6,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D1
            movem.l (SP)+,D0/D2/A0-A1
            bclr    #7,(A0)
            tst.b   D1
            beq.b   .L1
            bset    #7,(A0)
.L1:
            rts
GetDirection:
            movea.l ExpandMem,A1
            movea.l ($AC,A1),A1
            jmp     (A1)
            movem.l D0/A0,-(SP)
            tst.w   ($50,A3)
            bpl.b   .L1
            move.w  (2,A0),D0
            bsr.w   GetStyle
            clr.w   D1
            move.b  (9,A0),D1
            bra.b   .L2
.L1:
            move.b  ($4D,A3),D1
.L2:
            beq.b   .L3
            st      D1
.L3:
            movem.l (SP)+,D0/A0
            rts
GetFormatOrdering:
            tst.w   ($50,A3)
            bmi.b   .L2
            clr.l   (-$3A,A6)
            clr.l   (-$36,A6)
            move.w  ($3C,A3),(-$36,A6)
            lea     (-$3A,A6),A0
            move.l  A0,(-$C,A6)
            move.w  #1,D2
            move.w  D2,(-$28,A6)
            tst.b   WordRedraw
            blt.b   .L1
            st      (-$2A,A6)
.L1:
            lea     (-$24,A6),A1
            move.l  A1,(-$10,A6)
            clr.w   (-8,A6)
            clr.w   (A1)
            bra.b   .L3
.L2:
            move.w  (A2),D0
            move.w  (2,A2),D1
            bsr.b   sub_40822FE2
.L3:
            rts
GetStylesInOrder:
            movea.l ExpandMem,A0
            movea.l ($B0,A0),A0
            jmp     (A0)
            bsr.b   sub_40822FE2
            bsr.w   GetNextDisplayStyle
            addq.w  #1,(-8,A6)
            subq.w  #1,D2
            rts
sub_40822FE2:
            movea.l ExpandMem,A0
            movea.l ($B4,A0),A0
            jmp     (A0)
xteGetFormatOrder:
            moveq   #0,D2
            bsr.w   GetCurStyle
            move.l  A0,(-$C,A6)
            bsr.w   GetNumStyles
            move.w  D0,D2
            move.w  D2,(-$28,A6)
            bsr.w   sub_40823088
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.w  D0,(A1)+
            addq.w  #1,D0
.L2:
            dbra    D2,.L1
            move.w  (-$28,A6),D2
            clr.w   (-8,A6)
            st      (-$2A,A6)
            tst.b   WordRedraw
            bge.b   .L4
            sf      (-$2A,A6)
            move.l  A0,-(SP)
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            cmpi.w  #1,(A0)
            beq.b   .L3
            movea.l (SP)+,A0
            movem.l D2-D4,-(SP)
            move.l  (-$10,A6),-(SP)
            clr.w   -(SP)
            subq.w  #1,D0
            move.w  D0,-(SP)
            move.b  TESysJust,-(SP)
            pea     sub_40823088.L4
            move.l  A0,(-$32,A6)
            move.l  A3,(-$2E,A6)
            pea     (-$32,A6)
            move.l  #$8012FFFC,-(SP)
            _ScriptUtil
            movem.l (SP)+,D2-D4
            bra.b   .L4
.L3:
            movea.l (SP)+,A0
.L4:
            rts
GetNextDisplayStyle:
            movea.l (-$C,A6),A0
            move.w  (-8,A6),D0
            lsl.w   #1,D0
            movea.l (-$10,A6),A1
            move.w  (0,A1,D0.w),D0
            move.w  D0,(-$26,A6)
            lsl.w   #2,D0
            lea     (0,A0,D0.w),A0
            rts
sub_40823088:
            movem.l D2/A0,-(SP)
            movea.l ExpandMem,A0
            sf      ($38,A0)
            lea     (-$24,A6),A1
            move.l  A1,(-$10,A6)
            cmpi.w  #$A,D2
            bls.b   .L1
            movea.l ExpandMem,A0
            st      ($38,A0)
            lsl.w   #1,D2
            move.l  D2,D0
            _NewHandleClear
            bne.b   .L3
            _HLock
            bne.b   .L2
            movea.l (A0),A1
            move.l  A0,(-$24,A6)
            move.l  (A0),(-$10,A6)
.L1:
            movem.l (SP)+,D2/A0
            rts
.L2:
            move.l  D0,-(SP)
            _DisposHandle
            move.l  (SP)+,D0
.L3:
            _SysError
.L4:
            link.w  A6,#0
            movem.l D0-D1/A1/A3,-(SP)
            movea.l (8,A6),A0
            movea.l (A0)+,A1
            movea.l (A0),A3
            move.w  ($C,A6),D0
            lsl.w   #2,D0
            movea.l A1,A0
            adda.w  D0,A0
            bsr.w   GetDirection
            move.b  D1,($E,A6)
            movem.l (SP)+,D0-D1/A1/A3
            unlk    A6
            movea.l (SP)+,A0
            addq.l  #6,SP
            jmp     (A0)
            rts
FreeFmtOrderArray:
            movea.l ExpandMem,A0
            tst.b   ($38,A0)
            beq.b   .L1
            sf      ($38,A0)
            movea.l (-$24,A6),A0
            _DisposHandle
.L1:
            rts
DOHILITE:
            bsr.w   PinDisplay
            bsr.w   Preamble
            bsr.w   LINERECT
            move.l  A4,-(SP)
            link.w  A6,#-$A
            movea.l A2,A1
            cmp.w   D3,D4
            beq.w   .L5
            bhi.b   .L1
            exg     D3,D4
            move.w  D3,D0
            lea     ($60,A3),A2
            bsr.w   GetLine
            bra.b   .L2
.L1:
            cmp.w   (2,A2),D4
            beq.b   .L2
            move.w  D4,D0
            bsr.w   GetLine
.L2:
            exg     A1,A2
            cmpa.l  A1,A2
            bne.b   .L3
            bsr.b   sub_408231B8
            bra.b   .L5
.L3:
            move.l  A1,(-$A,A6)
            move.l  A2,(-6,A6)
            move.w  D4,(-2,A6)
            move.w  (2,A2),D4
            bsr.b   sub_408231B8
            move.w  (-2,A6),D4
            movea.l (-$A,A6),A2
            move.w  (A2),D3
            movea.l (-6,A6),A1
            unlk    A6
            move.w  ($14,A3),-(SP)
            move.l  A1,-(SP)
            bsr.w   LINERECT
            bsr.b   sub_408231B8
            movea.l (SP)+,A1
            move.w  (2,A1),D2
            cmp.w   (A2),D2
            beq.b   .L4
            move.w  ($10,A3),($14,A3)
            move.w  (SP)+,($10,A3)
            move.w  #$8002,($12,A3)
            move.w  #$7FFE,($16,A3)
            move.l  ($56,A3),D0
            bsr.w   InvertHook_StyledTextEdit
            bra.b   .L6
.L4:
            addq.w  #2,SP
            bra.b   .L6
.L5:
            unlk    A6
.L6:
            movea.l (SP)+,A4
            bra.w   DoDraw.L12
sub_408231B8:
            movea.l ExpandMem,A4
            movea.l ($C0,A4),A4
            jmp     (A4)
xOnSameLine:
            link.w  A6,#-$72
            movem.l D3-D4/D7/A0-A1,-(SP)
            moveq   #0,D5
            moveq   #0,D2
            clr.w   (-$54,A6)
            sf      (-$2A,A6)
            clr.w   (-$5C,A6)
            sf      (-6,A6)
            clr.w   (-$56,A6)
            clr.l   (-$5A,A6)
            clr.l   (-$72,A6)
            move.w  ($12,A3),(-$40,A6)
            move.w  ($16,A3),(-$3C,A6)
            move.w  (-$40,A6),(-$62,A6)
            move.w  (-$3C,A6),(-$64,A6)
            tst.w   ($50,A3)
            bpl.w   .L8
            move.w  D3,D0
            bsr.w   GetCurStyle
            move.l  A0,(-$4E,A6)
            bsr.w   FixFormatEnd
            cmp.w   D0,D4
            bhi.b   .L1
            move.l  A0,(-$52,A6)
            bra.b   .L2
.L1:
            move.w  D4,D0
            bsr.w   GetCurStyle
            move.l  A0,(-$52,A6)
            cmp.w   (A0),D4
            bne.b   .L2
            subq.l  #4,(-$52,A6)
.L2:
            move.w  (A2),D0
            move.w  (2,A2),D1
            bsr.w   sub_40822FE2
.L3:
            bsr.w   GetNextDisplayStyle
            addq.w  #1,(-8,A6)
            subq.w  #1,D2
            cmpa.l  (-$4E,A6),A0
            bne.b   .L4
            move.w  (-$26,A6),(-$58,A6)
            tst.b   (-$56,A6)
            bne.b   .L5
            st      (-$55,A6)
.L4:
            cmpa.l  (-$52,A6),A0
            bne.b   .L3
            move.w  (-$26,A6),(-$5A,A6)
            tst.b   (-$55,A6)
            bne.b   .L5
            st      (-$56,A6)
            bra.b   .L3
.L5:
            move.w  (-$28,A6),D2
            clr.w   (-8,A6)
            move.w  (-$58,A6),D0
            cmp.w   (-$5A,A6),D0
            bne.b   .L6
            st      (-$5B,A6)
.L6:
            bsr.w   GetNextDisplayStyle
            bsr.w   sub_4082333A
            tst.b   (-6,A6)
            bne.b   .L9
            addq.w  #1,(-8,A6)
            tst.b   (-$2A,A6)
            bne.b   .L7
            subq.w  #1,D2
            beq.b   .L9
            bra.b   .L6
.L7:
            addq.l  #4,A0
            subq.w  #1,D2
            bne.b   .L6
            bra.b   .L9
.L8:
            clr.l   (-$3A,A6)
            clr.w   (-$36,A6)
            move.w  ($3C,A3),(-$36,A6)
            lea     (-$3A,A6),A0
            bsr.w   sub_408234D8
.L9:
            tst.b   (-$5C,A6)
            beq.b   .L10
            bsr.w   sub_40823466
            sf      (-$5C,A6)
.L10:
            tst.b   (-$71,A6)
            beq.b   .L11
            move.w  (-$40,A6),($16,A3)
            move.w  #$8002,($12,A3)
            move.l  A0,-(SP)
            move.l  ($56,A3),D0
            bsr.w   InvertHook_StyledTextEdit
            sf      (-$71,A6)
            movea.l (SP)+,A0
.L11:
            tst.b   (-$72,A6)
            beq.b   .L14
            tst.w   ($50,A3)
            bmi.b   .L12
            bsr.w   MeasureWholeRun
            move.w  D0,($12,A3)
            bra.b   .L13
.L12:
            move.w  (-$64,A6),($12,A3)
.L13:
            move.w  (-$40,A6),D0
            add.w   D0,($12,A3)
            move.w  #$7FFE,($16,A3)
            move.l  ($56,A3),D0
            bsr.w   InvertHook_StyledTextEdit
            sf      (-$72,A6)
.L14:
            bsr.w   FreeFmtOrderArray
            movem.l (SP)+,D3-D4/D7/A0-A1
            unlk    A6
            rts
sub_4082333A:
            movea.l ExpandMem,A1
            movea.l ($C4,A1),A1
            jmp     (A1)
            move.w  (-$26,A6),D0
            cmp.w   (-$58,A6),D0
            beq.b   .L1
            tst.b   (-$5B,A6)
            bne.w   .L10
            cmp.w   (-$5A,A6),D0
            beq.b   .L2
            blt.b   .L6
            bra.w   .L10
.L1:
            move.w  D3,(-$5E,A6)
            move.w  D4,(-$60,A6)
            tst.b   (-$5B,A6)
            bne.b   .L3
            bsr.w   FixFormatEnd
            move.w  D0,D4
            bra.b   .L5
.L2:
            move.w  D3,(-$5E,A6)
            move.w  D4,(-$60,A6)
            move.w  (A0),D3
.L3:
            tst.b   (-$2A,A6)
            bne.b   .L4
            bra.b   .L5
.L4:
            st      (-6,A6)
.L5:
            tst.b   (-$5C,A6)
            beq.b   .L9
            bsr.w   sub_40823466
            bra.b   .L9
.L6:
            cmp.w   (-$58,A6),D0
            bhi.b   .L7
            bsr.b   MeasureWholeRun
            add.w   D0,(-$54,A6)
            tst.b   (-$5C,A6)
            beq.b   .L11
            bsr.w   sub_40823466
            move.w  (-$54,A6),D0
            add.w   D0,(-$62,A6)
            bra.b   .L11
.L7:
            move.w  (A0),D0
            move.w  (4,A0),D1
            bsr.w   sub_40823498
            tst.b   (-$5C,A6)
            bne.b   .L8
            st      (-$5C,A6)
            move.w  (-$54,A6),(-$62,A6)
            move.w  (-$54,A6),(-$64,A6)
.L8:
            bsr.b   MeasureWholeRun
            add.w   D0,(-$54,A6)
            add.w   D0,(-$64,A6)
            bra.b   .L11
.L9:
            bsr.w   sub_408234D8
            move.w  (-$5E,A6),D3
            move.w  (-$60,A6),D4
.L10:
            bsr.b   MeasureWholeRun
            add.w   D0,(-$54,A6)
            move.w  (-$54,A6),(-$64,A6)
.L11:
            move.w  (-$54,A6),D5
            rts
MeasureWholeRun:
            movea.l ExpandMem,A1
            movea.l ($C8,A1),A1
            jmp     (A1)
            movem.l D2/A0/A4,-(SP)
            movea.l A0,A1
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  (A1),A0
            movea.l A0,A4
            movea.l A1,A0
            moveq   #0,D1
            move.w  (A2),D0
            cmp.w   (A0),D0
            bls.b   .L1
            sub.w   (A0),D0
            adda.w  D0,A4
            move.w  D0,D1
.L1:
            bsr.w   FixFormatEnd
            cmp.w   (2,A2),D0
            bls.b   .L2
            move.w  (2,A2),D0
.L2:
            sub.w   (A0),D0
            sub.w   D1,D0
            tst.w   ($50,A3)
            bpl.b   .L3
            movem.l D0-D1,-(SP)
            bsr.w   SetStyle
            movem.l (SP)+,D0-D1
.L3:
            subq.l  #2,SP
            move.l  A4,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            _TextWidth
            moveq   #0,D0
            move.w  (SP)+,D0
            movem.l (SP)+,D2/A0/A4
            rts
sub_40823466:
            movem.l D0/A0,-(SP)
            move.w  (-$40,A6),($12,A3)
            move.w  (-$62,A6),D0
            add.w   D0,($12,A3)
            move.w  (-$3C,A6),($16,A3)
            move.w  (-$64,A6),D0
            add.w   D0,($16,A3)
            move.l  ($56,A3),D0
            bsr.w   InvertHook_StyledTextEdit
            sf      (-$5C,A6)
            movem.l (SP)+,D0/A0
            rts
sub_40823498:
            movea.l ExpandMem,A1
            movea.l ($CC,A1),A1
            jmp     (A1)
            cmp.w   (A2),D0
            bhi.b   .L2
            cmp.w   (A2),D1
            bcs.b   .L2
            tst.b   TESysJust
            bne.b   .L1
            st      (-$71,A6)
            bra.b   .L2
.L1:
            st      (-$72,A6)
.L2:
            cmp.w   (2,A2),D0
            bhi.b   .L4
            cmp.w   (2,A2),D1
            bcs.b   .L4
            tst.b   TESysJust
            bne.b   .L3
            st      (-$72,A6)
            bra.b   .L4
.L3:
            st      (-$71,A6)
.L4:
            rts
sub_408234D8:
            tst.w   ($50,A3)
            bpl.b   .L1
            bsr.w   SetStyle
.L1:
            move.l  A4,-(SP)
            lea     (-$70,A6),A4
            movem.l D2-D4/A0-A1,-(SP)
            movea.l A0,A1
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  (A1),A0
            moveq   #0,D1
            move.w  (A2),D0
            cmp.w   (A1),D0
            bls.b   .L2
            sub.w   (A1),D0
            adda.w  D0,A0
            move.w  D0,D1
.L2:
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            movea.l A1,A0
            bsr.w   FixFormatEnd
            movea.l (SP)+,A0
            cmp.w   (2,A2),D0
            bls.b   .L3
            move.w  (2,A2),D0
.L3:
            sub.w   (A1),D0
            sub.w   D1,D0
            move.w  D0,-(SP)
            sub.w   (A1),D3
            sub.w   D1,D3
            move.w  D3,-(SP)
            sub.w   (A1),D4
            sub.w   D1,D4
            move.w  D4,-(SP)
            move.l  A4,-(SP)
            move.l  #$800E001C,-(SP)
            _ScriptUtil
            movem.l (SP)+,D2-D4/A0-A1
            moveq   #2,D7
.L4:
            move.w  (A4)+,D0
            move.w  (A4)+,D1
            cmp.w   D0,D1
            beq.b   .L5
            move.l  A4,-(SP)
            bsr.b   sub_40823552
            movea.l (SP)+,A4
.L5:
            dbra    D7,.L4
            movea.l (SP)+,A4
            rts
sub_40823552:
            movea.l ExpandMem,A4
            movea.l ($D0,A4),A4
            jmp     (A4)
            move.w  D2,-(SP)
            movem.l D0-D1/A0-A1,-(SP)
            move.w  D5,-(SP)
            move.w  #1,D2
            swap    D2
            move.w  #1,D2
            bsr.b   sub_408235BE
            cmp.w   D5,D6
            bcs.b   .L1
            add.w   (-$3C,A6),D5
            add.w   (SP),D5
            add.w   (-$3C,A6),D6
            add.w   (SP),D6
            bra.b   .L2
.L1:
            add.w   (-$40,A6),D5
            add.w   (SP),D5
            add.w   (-$40,A6),D6
            add.w   (SP),D6
            exg     D5,D6
.L2:
            move.w  D5,($12,A3)
            move.w  D6,($16,A3)
            move.l  ($56,A3),D0
            bsr.w   InvertHook_StyledTextEdit
            move.w  (SP)+,D5
            movem.l (SP)+,D0-D1/A0-A1
            move.w  (A2),D2
            cmp.w   (A0),D2
            bls.b   .L3
            add.w   D2,D0
            add.w   D2,D1
            bra.b   .L4
.L3:
            add.w   (A0),D0
            add.w   (A0),D1
.L4:
            bsr.w   sub_40823498
            move.w  (SP)+,D2
            rts
sub_408235BE:
            movea.l ExpandMem,A1
            movea.l ($D4,A1),A1
            jmp     (A1)
            movem.l D0-D4/A0-A2/A4,-(SP)
            movea.l ExpandMem,A4
            move.l  D2,($3A,A4)
            movea.l A0,A1
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  (A1),A0
            move.w  D1,-(SP)
            move.w  D0,D1
            moveq   #0,D4
            move.w  (A2),D0
            cmp.w   (A1),D0
            bls.b   .L1
            sub.w   (A1),D0
            adda.w  D0,A0
            move.w  D0,D4
.L1:
            move.l  A0,-(SP)
            movea.l A1,A0
            bsr.w   FixFormatEnd
            movea.l (SP)+,A0
            cmp.w   (2,A2),D0
            bls.b   .L2
            move.w  (2,A2),D0
.L2:
            sub.w   (A1),D0
            sub.w   D4,D0
            moveq   #0,D2
            movea.l ExpandMem,A4
            lea     ($3A,A4),A4
            move.w  (A4)+,D2
            swap    D2
            movem.l D0/A0-A1/A4,-(SP)
            bsr.w   sub_40822860
            move.w  D1,D5
            movem.l (SP)+,D0/A0-A1/A4
            move.w  (SP)+,D1
            moveq   #0,D2
            move.w  (A4),D2
            swap    D2
            bsr.w   sub_40822860
            move.w  D1,D6
            movem.l (SP)+,D0-D4/A0-A2/A4
            rts
ChkBounds:
            move.w  (A2),D0
            move.w  (2,A2),D1
            tst.w   ($50,A3)
            bpl.b   .L5
            tst.w   TESysJust
            beq.b   .L5
            tst.b   WordRedraw
            bge.b   .L1
            bsr.w   GetStylesInOrder
            beq.b   .L2
            subq.w  #1,D2
            move.w  D2,(-8,A6)
            move.l  A0,-(SP)
            bsr.w   GetNextDisplayStyle
            move.w  (A0),D1
            movea.l (SP)+,A0
            bra.b   .L4
.L1:
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
            subq.w  #1,D0
            bne.b   .L3
.L2:
            move.w  (A2),D0
            move.w  (2,A2),D1
            bra.b   .L5
.L3:
            subq.w  #1,D0
            lsl.w   #2,D0
            neg.w   D0
            move.w  (0,A0,D0.w),D1
.L4:
            move.w  (A2),D0
            cmp.w   (A0),D0
            bcc.b   .L5
            move.w  (A0),D0
.L5:
            cmp.w   D0,D3
            bne.b   .L6
            move.w  #$8002,($12,A3)
.L6:
            cmp.w   D1,D4
            bne.b   .L7
            move.w  #$7FFE,($16,A3)
.L7:
            bsr.w   FreeFmtOrderArray
            rts
NextLineRect:
            move.w  ($14,A3),($10,A3)
            bsr.w   GetHite
            add.w   D1,($14,A3)
            add.w   D0,D0
            lea     ($60,A3,D0.w),A2
            move.w  (2,A3),($12,A3)
            bsr.b   DoJust
            rts
PtrToLine:
            lea     ($60,A3),A0
            move.l  A2,D0
            sub.l   A0,D0
            asr.l   #1,D0
            rts
LINERECT:
            bsr.b   PtrToLine
            move.w  D0,D1
            moveq   #0,D0
            bsr.b   GetLineHites
            lea     (8,A3),A0
            lea     ($18,A3),A1
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            add.w   D0,(A1)
            move.w  (A1),(4,A1)
            move.w  D1,D0
            bsr.w   GetHite
            add.w   D1,(4,A1)
DoJust:
            move.w  ($3A,A3),-(SP)
            bne.b   .L1
            move.w  TESysJust,(SP)
            beq.b   .L3
.L1:
            cmpi.w  #$FFFE,(SP)
            beq.b   .L3
            bsr.w   LineWidth
            move.w  (6,A3),D1
            sub.w   (2,A3),D1
            sub.w   D0,D1
            subq.w  #1,D1
            tst.w   (SP)
            bmi.b   .L2
            asr.w   #1,D1
.L2:
            add.w   D1,($12,A3)
.L3:
            addq.w  #1,($12,A3)
            move.w  ($12,A3),($16,A3)
            move.w  ($12,A3),(-4,A6)
            addq.l  #2,SP
            rts
GetLineHites:
            movem.l D1-D2,-(SP)
            sub.w   D0,D1
            beq.b   .L1
            move.w  ($18,A3),D2
            bpl.b   .L1
            tst.w   ($50,A3)
            bmi.b   .L2
.L1:
            mulu.w  D1,D2
            bra.b   .L4
.L2:
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            lsl.w   #2,D0
            adda.w  D0,A0
            moveq   #0,D2
.L3:
            move.w  (A0),D0
            andi.w  #$7FFF,D0
            add.w   D0,D2
            addq.w  #4,A0
            subq.w  #1,D1
            bne.b   .L3
.L4:
            move.l  D2,D0
            movem.l (SP)+,D1-D2
            rts
GetHite:
            move.w  ($18,A3),D1
            bpl.b   .L1
            tst.w   ($50,A3)
            bpl.b   .L1
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            move.w  D0,D1
            lsl.w   #2,D1
            move.w  (0,A0,D1.w),D1
            andi.w  #$7FFF,D1
.L1:
            rts
LineWidth:
            move.w  (A2),D6
            move.w  (2,A2),D7
            movea.l ExpandMem,A0
            st      ($3E,A0)
            move.l  ($7F4).w,-(SP)
            rts
XTrimMeasure:
            tst.b   WordRedraw
            bmi.b   MeasureIt
            cmp.w   ($3C,A3),D6
            beq.b   MeasureIt.L4
            cmp.w   D6,D7
            bls.b   MeasureIt.L4
            movea.l ($3E,A3),A0
            movea.l (A0),A0
.L1:
            subq.w  #1,D7
            cmp.w   D6,D7
            beq.b   .L2
            cmpi.b  #$20,(0,A0,D7.w)
            bls.b   .L1
.L2:
            addq.w  #1,D7
MeasureIt:
            cmp.w   D6,D7
            bls.b   .L4
            movem.l D2/D4/D6,-(SP)
            and.l   sub_408240B4+2,D6
            tst.w   ($50,A3)
            bmi.b   .L1
            move.w  D7,D0
            bsr.b   GetWidth
            move.w  D1,D0
            bra.b   .L3
.L1:
            moveq   #0,D4
            move.w  D6,D0
            bsr.w   GetCurStyle
            move.w  D7,D1
            bsr.w   GetNumStyles
            move.w  D0,D2
.L2:
            bsr.w   SetStyle
            bsr.w   FixFormatEnd
            addq.w  #4,A0
            move.w  D2,-(SP)
            bsr.b   GetWidth
            add.w   D1,D4
            move.w  (SP)+,D2
            move.w  (A0),D6
            subq.w  #1,D2
            bne.b   .L2
            move.w  D4,D0
.L3:
            movem.l (SP)+,D2/D4/D6
            movea.l ExpandMem,A1
            sf      ($3E,A1)
            rts
.L4:
            moveq   #0,D0
            rts
GetWidth:
            movea.l ExpandMem,A1
            movea.l ($B8,A1),A1
            jmp     (A1)
XGETWIDTH:
            tst.w   ($50,A3)
            bpl.b   .L1
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            suba.l  A1,A0
.L1:
            move.l  A0,-(SP)
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  D6,A0
            move.w  D7,D1
            cmp.w   (2,A2),D0
            bls.b   .L2
            move.w  (2,A2),D0
.L2:
            sub.w   D6,D0
            sub.w   D6,D1
            blt.b   .L3
            cmp.w   D0,D1
            bcc.b   .L3
            movea.l ExpandMem,A1
            tst.b   ($3E,A1)
            beq.b   .L4
.L3:
            clr.w   -(SP)
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            _TextWidth
            move.w  (SP)+,D1
            bra.b   .L5
.L4:
            moveq   #1,D2
            swap    D2
            bsr.w   sub_40822860
.L5:
            movea.l (SP)+,A0
            tst.w   ($50,A3)
            bpl.b   .L6
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            adda.l  A1,A0
.L6:
            rts
sub_40823896:
            move.l  ($79C).w,-(SP)
            rts
vChar2Pixel:
            move.l  D3,-(SP)
            tst.b   TESysJust
            beq.w   .L8
            movem.l D0/D2/A0-A1,-(SP)
            move.w  D1,-(SP)
            tst.b   ($50,A3)
            bpl.b   .L1
            movea.l ($3E,A3),A1
            movea.l (A1),A1
            suba.l  A1,A0
            move.w  A0,D0
            add.w   (SP),D0
            move.w  D0,D3
            bsr.w   GetCurStyle
            bsr.w   GetDirection
            bra.b   .L2
.L1:
            move.w  D1,D3
            add.w   (A2),D3
            subq.w  #6,SP
            move.l  #$82000000,-(SP)
            _ScriptUtil
            move.w  #6,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D1
.L2:
            cmp.b   TESysJust,D1
            beq.b   .L7
            move.w  (SP)+,D1
            movem.l (SP)+,D0/D2/A0-A1
            cmp.w   (A2),D3
            beq.b   .L3
            cmp.w   (2,A2),D3
            bne.b   .L8
.L3:
            swap    D2
            cmpi.w  #0,D2
            bne.b   .L4
            cmp.w   (A2),D3
            beq.b   .L5
            bra.b   .L6
.L4:
            cmp.w   (A2),D3
            beq.b   .L6
.L5:
            subq.l  #2,SP
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            _TextWidth
            moveq   #0,D1
            move.w  (SP)+,D1
            bra.b   .L9
.L6:
            moveq   #0,D1
            bra.b   .L9
.L7:
            move.w  (SP)+,D1
            movem.l (SP)+,D0/D2/A0-A1
.L8:
            clr.w   -(SP)
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            move.w  D2,-(SP)
            move.w  D1,-(SP)
            swap    D2
            move.w  D2,-(SP)
            move.l  #$820C0016,-(SP)
            _ScriptUtil
            move.w  (SP)+,D1
.L9:
            move.l  (SP)+,D3
            rts
RangeRect:
            cmp.w   (A2),D3
            bhi.b   .L1
            cmp.w   (2,A2),D4
            bcs.b   .L1
            move.w  (A2),D6
            move.w  D4,D7
            bsr.w   MeasureIt
            add.w   D0,($16,A3)
            bra.b   .L2
.L1:
            move.w  D3,D7
            bsr.b   DoMeasure
            add.w   D0,($12,A3)
            move.w  D4,D7
            bsr.b   DoMeasure
            add.w   D0,($16,A3)
.L2:
            lea     ($10,A3),A1
            move.w  (2,A1),(-2,A6)
            move.w  (2,A1),Scratch8
            move.l  (4,A1),-(SP)
            tst.w   ($50,A3)
            bmi.b   .L3
            move.w  ($18,A3),D0
            sub.w   ($1A,A3),D0
            sub.w   D0,(SP)
.L3:
            _MoveTo
            rts
DoMeasure:
            movem.l D3/D5-D6,-(SP)
            moveq   #0,D5
            move.w  (A2),D6
            sf      D3
            cmp.w   D6,D7
            bcs.w   .L10
            tst.w   ($50,A3)
            bpl.w   .L9
            tst.b   WordRedraw
            bpl.w   .L9
            sf      (-6,A6)
            move.w  (A2),D0
            move.w  (2,A2),D1
            tst.b   WordRedraw
            bge.b   .L2
            bsr.w   GetStylesInOrder
            bge.b   .L3
            bra.w   .L10
.L1:
            bsr.w   GetNextDisplayStyle
            addq.w  #1,(-8,A6)
            subq.w  #1,D2
            bge.b   .L3
            bra.b   .L10
.L2:
            st      (-6,A6)
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
.L3:
            move.w  (A0),D6
            bsr.w   FixFormatEnd
            cmp.w   (A2),D6
            bhi.b   .L4
            move.w  (A2),D6
.L4:
            cmp.w   (2,A2),D0
            bls.b   .L5
            move.w  (2,A2),D0
.L5:
            tst.b   D3
            bne.b   .L9
            cmp.w   D6,D7
            bcs.b   .L7
            beq.b   .L6
            cmp.w   D0,D7
            bhi.b   .L7
            bne.b   .L9
.L6:
            bsr.w   GetDirection
            cmp.b   TESysJust,D1
            beq.b   .L9
            st      D3
            bra.b   .L8
.L7:
            move.w  D0,-(SP)
            bsr.w   SetStyle
            move.w  (SP)+,D0
.L8:
            movea.l ExpandMem,A1
            st      ($3E,A1)
            move.w  D2,-(SP)
            bsr.w   GetWidth
            add.w   D1,D5
            move.w  (SP)+,D2
            tst.b   (-6,A6)
            beq.b   .L1
            subq.l  #4,A0
            bra.b   .L3
.L9:
            movea.l ExpandMem,A1
            sf      ($3E,A1)
            bsr.w   MeasureIt
            add.w   D0,D5
.L10:
            move.w  D5,D0
            bsr.w   FreeFmtOrderArray
            movem.l (SP)+,D3/D5-D6
            rts
PinDisplay:
            lea     (8,A3),A0
PinA0Rect:
            move.w  (A0),D0
            bsr.b   PtToLine
            bge.b   .L5
            add.w   D0,D0
            blt.b   .L2
            cmp.w   ($60,A3,D0.w),D3
            bcc.b   .L1
            move.w  ($60,A3,D0.w),D3
.L1:
            cmp.w   ($60,A3,D0.w),D4
            bcc.b   .L2
            move.w  ($60,A3,D0.w),D4
.L2:
            move.w  (4,A0),D0
            subq.w  #1,D0
            bsr.b   PtToLine
            addq.w  #1,D0
            cmp.w   ($5E,A3),D0
            bhi.b   .L4
            add.w   D0,D0
            cmp.w   ($60,A3,D0.w),D3
            bcs.b   .L3
            move.w  ($60,A3,D0.w),D3
.L3:
            cmp.w   ($60,A3,D0.w),D4
            bcs.b   .L4
            move.w  ($60,A3,D0.w),D4
.L4:
            rts
.L5:
            move.w  D3,D4
            rts
PtToLine:
            movem.l D2/D6-D7/A0,-(SP)
            sub.w   (A3),D0
            ext.l   D0
            move.w  ($5E,A3),D7
            beq.b   .L5
            move.w  ($18,A3),D1
            tst.w   ($50,A3)
            bpl.b   .L1
            tst.w   D1
            bmi.b   .L2
.L1:
            divs.w  D1,D0
            bra.b   .L5
.L2:
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            moveq   #0,D1
            move.w  D7,D2
.L3:
            move.w  (A0),D6
            andi.w  #$7FFF,D6
            add.w   D6,D1
            addq.w  #4,A0
            cmp.w   D1,D0
            blt.b   .L4
            subq.w  #1,D2
            bne.b   .L3
.L4:
            move.w  D7,D0
            sub.w   D2,D0
.L5:
            cmp.w   D7,D0
            movem.l (SP)+,D2/D6-D7/A0
            rts
InvertHook_StyledTextEdit:
            pea     ($10,A3)
            bne.b   .L1
            lea     HiliteMode,A0
            bclr    #7,(A0)
            bra.b   .L2
.L1:
            movea.l D0,A0
            jmp     (A0)
.L2:
            _InverRect
            rts
sub_40823B0E:
            pea     ($10,A3)
            tst.l   D0
            beq.b   InvertHook_StyledTextEdit.L2
            movea.l D0,A0
            jmp     (A0)
StdEntry_StyledTextEdit:
            moveq   #0,D0
StdEntry2:
            movea.l (SP)+,A0
            link.w  A6,#-$18
            movem.l D2-D7/A2-A4,-(SP)
            move.l  A0,-(SP)
            tst.w   D0
            beq.b   .L1
            move.w  (8,A6),D0
            lea     TextEdit,A0
            add.w   D0,D0
            move.w  (0,A0,D0.w),D0
            lea     (0,A0,D0.w),A0
            move.l  A0,D3
            movea.l ($A,A6),A4
            bra.b   .L2
.L1:
            moveq   #0,D3
            movea.l (8,A6),A4
.L2:
            movea.l A4,A0
            _HGetState
            move.b  D0,(-2,A6)
            pea     (-6,A6)
            _GetPort
            movea.l A4,A0
            _HLock
            movea.l (A4),A3
            movea.l ($52,A3),A2
            move.l  A2,-(SP)
            _SetPort
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),(-$A,A6)
            move.l  (SP),-(SP)
            _GetClip
            pea     (8,A3)
            _ClipRect
            move.l  ($1C,A2),-(SP)
            move.l  (SP),-(SP)
            _SectRgn
            movea.l ($52,A3),A0
            tst.w   ($50,A3)
            bmi.b   .L3
            move.l  ($4A,A3),($44,A0)
            move.l  ($4E,A3),($48,A0)
.L3:
            move.w  ($44,A0),(-$E,A6)
            bclr    #7,($47,A0)
            move.w  ($46,A0),(-$10,A6)
            move.w  ($4A,A0),(-$12,A6)
            pea     (-$18,A6)
            move.w  ($4E,A3),($48,A0)
            _GetForeColor
            movea.l ($3E,A3),A0
            _HGetState
            move.b  D0,(-$C,A6)
            _HLock
            _GetHandleSize
            move.w  D0,($3C,A3)
CleanUpSel:
            move.w  ($3C,A3),D0
            move.w  ($22,A3),D1
            sub.w   D0,D1
            bls.b   .L1
            move.w  D0,($22,A3)
.L1:
            move.w  ($20,A3),D1
            sub.w   ($22,A3),D1
            bls.b   .L2
            sub.w   D1,($20,A3)
.L2:
            bsr.b   SelSort
            tst.l   D3
            beq.b   .L3
            movea.l D3,A0
            lea     ($E,A6),A2
            bra.b   .L4
.L3:
            lea     ($C,A6),A2
.L4:
            rts
TEDispatch:
            moveq   #1,D0
            bsr.w   StdEntry2
            jmp     (A0)
SelSort:
            lea     ($20,A3),A2
            move.l  (A2),D0
            cmp.w   (A2),D0
            bcc.b   .L1
            swap    D0
            move.l  D0,(A2)
.L1:
            rts
TECopy:
            bsr.w   StdEntry_StyledTextEdit
            bsr.b   SelSort
            sub.w   (A2),D0
            move.w  D0,TEScrpLength
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            moveq   #0,D0
            move.w  (A2),D0
            adda.l  D0,A0
            movea.l TEScrpHandle,A1
            move.w  TEScrpLength,D0
            _PtrToXHand
            tst.w   ($50,A3)
            bpl.b   .L1
            subq.w  #4,SP
            _ZeroScrap
            addq.l  #4,SP
            bsr.b   SelSort
            bsr.b   CopyStyle
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            moveq   #0,D0
            lea     ($20,A3),A2
            move.w  (A2),D0
            adda.w  D0,A0
            subq.w  #4,SP
            move.w  TEScrpLength,D0
            move.l  D0,-(SP)
            move.l  #'TEXT',-(SP)
            move.l  A0,-(SP)
            _PutScrap
            addq.l  #4,SP
.L1:
            bra.w   TECalText.L1
CopyStyle:
            movem.l D0/D2-D5/A2/A5,-(SP)
            move.w  D0,D1
            swap    D0
            cmp.w   D0,D1
            beq.b   .L1
            bsr.b   CopyGuts
            movea.l A4,A0
            _HLock
            subq.l  #4,SP
            move.l  D4,-(SP)
            move.l  #'styl',-(SP)
            move.l  (A4),-(SP)
            _PutScrap
            addq.l  #4,SP
            movea.l A4,A0
            _DisposHandle
.L1:
            movem.l (SP)+,D0/D2-D5/A2/A5
            rts
CopyGuts:
            move.w  D0,D5
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
            move.w  D0,D2
            mulu.w  #$14,D0
            addq.l  #2,D0
            move.l  D0,D4
            bsr.w   MyNewHandle
            movea.l A0,A4
            movea.l (A0),A0
            move.w  D2,(A0)
            lea     (2,A0),A1
            move.w  D5,D0
            bsr.w   GetCurStyle
            movea.l A0,A2
.L1:
            addq.l  #4,A1
            move.w  (2,A2),D0
            bsr.w   GetStyle
            addq.l  #2,A0
            moveq   #$10,D0
            _BlockMove
            moveq   #0,D0
            move.w  (A2),D0
            sub.w   D5,D0
            bcc.b   .L2
            moveq   #0,D0
.L2:
            move.l  D0,-(A1)
            adda.w  #$14,A1
            addq.l  #4,A2
            subq.w  #1,D2
            bne.b   .L1
            rts
TECut:
            bsr.w   StdEntry_StyledTextEdit
            move.l  A4,-(SP)
            _TECopy
            move.l  A4,-(SP)
            _TEDelete
            bra.w   TECopy.L1
TEDelete:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   HideCaret
            bsr.b   DelGuts
            bsr.w   RecalDraw
            bsr.w   ShowCaret
            bsr.w   SelView
            bra.w   TECopy.L1
DelGuts:
            bsr.w   SelSort
            move.w  D0,D7
            sub.w   (A2),D7
            beq.b   .L4
            tst.w   ($50,A3)
            bpl.b   .L3
            movem.l D0/D7/A2,-(SP)
            move.w  ($20,A3),D0
            bsr.w   GetCurStyle
            move.w  ($20,A3),D0
            cmp.w   (A0),D0
            beq.b   .L1
            bsr.w   ClearRsrved
            bra.b   .L2
.L1:
            move.w  (2,A0),D0
            bsr.w   GetStyle
            move.w  #$F,-(SP)
            pea     (6,A0)
            clr.b   -(SP)
            movea.l SP,A2
            bsr.w   AltSetRsrved
            addq.w  #8,SP
.L2:
            movem.l (SP)+,D0/D7/A2
.L3:
            move.w  D0,D1
            swap    D0
            bsr.b   DeleteStyle
            bsr.w   MungeSetup
            move.w  D7,-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            _Munger
            addq.l  #4,SP
            movea.l ($3E,A3),A0
            _HLock
            sub.w   D7,($3C,A3)
            move.w  (A2)+,(A2)
            bsr.w   sub_4082584C
.L4:
            rts
DeleteStyle:
            movem.l D0/D2-D6/A2,-(SP)
            tst.w   ($50,A3)
            bpl.b   .L3
            move.w  D0,D5
            sub.w   D1,D5
            beq.b   .L3
            move.w  D0,D3
            subq.w  #1,D0
            bsr.w   GetCurStyle
            movea.l A0,A2
            move.w  D0,D6
            addq.w  #1,D1
            bsr.w   GetNumStyles
            subq.w  #1,D0
            move.w  D0,D2
            add.w   D6,D0
            move.w  D0,D6
            moveq   #0,D4
            move.w  D2,D4
            lsl.l   #2,D4
            adda.l  D4,A0
            tst.w   D2
            bne.b   .L1
            bsr.w   RecalStStarts
            bra.b   .L3
.L1:
            move.w  D3,(A0)
            bsr.w   RecalStStarts
            cmp.w   (A2),D3
            beq.b   .L2
            addq.l  #4,A2
            subq.w  #4,D4
            subq.w  #1,D2
            beq.b   .L3
.L2:
            movea.l A2,A0
            move.w  D2,D0
            bsr.b   sub_40823DFE
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            moveq   #0,D0
            move.w  (A0),D0
            addq.w  #1,D0
            sub.w   D6,D0
            lsl.l   #2,D0
            sub.w   D2,(A0)
            movea.l A2,A1
            movea.l A2,A0
            adda.l  D4,A0
            _BlockMove
.L3:
            movem.l (SP)+,D0/D2-D6/A2
            rts
sub_40823DFE:
            movea.l A0,A1
            move.w  D0,D1
.L1:
            move.w  (2,A1),D0
            bsr.w   GetStyle
            tst.w   (A0)
            beq.b   .L2
            subq.w  #1,(A0)
.L2:
            addq.l  #4,A1
            subq.w  #1,D1
            bne.b   .L1
            rts
RecalDraw:
            moveq   #0,D0
            move.w  ($5E,A3),D1
            bsr.w   GetLineHites
            move.w  D0,-(SP)
            bsr.w   sub_408243B2
            move.w  D2,D3
            moveq   #0,D0
            move.w  ($5E,A3),D1
            bsr.w   GetLineHites
            move.w  (SP)+,D1
            cmp.w   D0,D1
            bcs.b   .L1
            lea     ($10,A3),A0
            add.w   (A3),D1
            move.w  D1,(4,A0)
            add.w   (A3),D0
            move.w  D0,(A0)
            move.w  #$8002,(2,A0)
            move.w  #$7FF0,(6,A0)
            move.l  A0,-(SP)
            _EraseRect
.L1:
            moveq   #-1,D7
            bra.w   DoText
sub_40823E5E:
            movea.l ExpandMem,A0
            movea.l ($BC,A0),A0
            jmp     (A0)
            link.w  A6,#-6
            movem.l D2-D7/A2/A4-A5,-(SP)
            bsr.w   GetCurStyle
            movea.l A0,A2
            move.w  D0,D4
            movea.l ($4A,A3),A5
            movea.l (A5),A5
            movea.l (4,A5),A4
            movea.l (A4),A4
            moveq   #0,D5
            moveq   #0,D6
            move.w  (2,A2),D6
            add.w   D6,D6
            move.w  D6,D1
            lsl.w   #3,D6
            add.w   D1,D6
            clr.w   -(SP)
            move.w  (6,A4,D6.l),-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            move.w  (SP)+,D7
            movem.l D4/A2,-(SP)
.L1:
            add.w   (4,A2),D5
            sub.w   (A2),D5
            move.l  A2,(-4,A6)
            move.w  D4,(-6,A6)
            addq.w  #1,D4
            cmp.w   (A5),D4
            bne.b   .L2
            subq.w  #1,D5
.L2:
            subq.w  #1,D4
            beq.b   .L3
            subq.l  #4,A2
            subq.w  #1,D4
            moveq   #0,D6
            move.w  (2,A2),D6
            add.w   D6,D6
            move.w  D6,D1
            lsl.w   #3,D6
            add.w   D1,D6
            clr.w   -(SP)
            move.w  (6,A4,D6.l),-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D7
            beq.b   .L1
.L3:
            movem.l (SP)+,D4/A2
            addq.w  #1,D4
.L4:
            addq.l  #4,A2
            moveq   #0,D6
            move.w  (2,A2),D6
            add.w   D6,D6
            move.w  D6,D1
            lsl.w   #3,D6
            add.w   D1,D6
            cmp.w   (A5),D4
            beq.b   .L5
            clr.w   -(SP)
            move.w  (6,A4,D6.l),-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D7
            bne.b   .L5
            add.w   (4,A2),D5
            sub.w   (A2),D5
            addq.w  #1,D4
            cmp.w   (A5),D4
            bne.b   .L4
            subq.w  #1,D5
.L5:
            movea.l (-4,A6),A0
            movea.w (-6,A6),A1
            move.w  D5,D0
            move.w  D7,D1
            movem.l (SP)+,D2-D7/A2/A4-A5
            unlk    A6
            rts
sub_40823F34:
            move.l  ($7F8).w,-(SP)
            rts
XFINDWORD:
            move.l  D0,-(SP)
            move.l  ($26,A3),D0
            _StripAddress
            movea.l ExpandMem,A0
            cmp.l   ($40,A0),D0
            beq.b   .L1
            move.l  (SP)+,D0
            bra.w   .L10
.L1:
            move.l  (SP)+,D0
            cmpi.w  #$D,D2
            beq.w   .L9
            link.w  A6,#-$24
            movem.l D3-D5/A0-A2,-(SP)
            moveq   #0,D1
            cmpi.w  #$C,D2
            bne.b   .L2
            not.l   D1
.L2:
            move.w  D1,(-$1A,A6)
            cmpi.w  #$C,D2
            bcc.b   .L3
            move.b  ($47,A3),D1
            ext.w   D1
            move.w  D1,(-$1A,A6)
.L3:
            moveq   #0,D1
            cmpi.w  #$C,D2
            bcs.b   .L4
            not.l   D1
.L4:
            move.l  D1,(-$10,A6)
            swap    D2
            move.w  D0,D2
            move.l  D2,(-$18,A6)
            move.w  D0,D5
            tst.w   ($50,A3)
            bpl.b   .L6
            bsr.w   sub_40823E5E
            move.w  D5,D3
            sub.w   (A0),D3
            bne.b   .L5
            tst.w   D5
            beq.b   .L5
            tst.w   (-$1A,A6)
            bne.b   .L5
            move.w  D5,D0
            subq.w  #1,D0
            bsr.w   sub_40823E5E
            move.w  D5,D3
            sub.w   (A0),D3
.L5:
            move.w  D3,(-$1C,A6)
            move.w  D0,(-$1E,A6)
            movea.l ($3E,A3),A2
            movea.l (A2),A2
            adda.w  (A0),A2
            move.l  A2,(-$14,A6)
            move.w  A1,(-$22,A6)
            move.w  (A0),(-$24,A6)
            move.w  (2,A0),D0
            bsr.w   GetStyle
            move.w  (6,A0),(-$20,A6)
            bra.b   .L7
.L6:
            clr.w   (-$24,A6)
            move.w  D5,(-$1C,A6)
            move.w  ($3C,A3),(-$1E,A6)
            movea.l ($3E,A3),A2
            move.l  (A2),(-$14,A6)
            movea.l ($52,A3),A0
            move.w  ($44,A0),(-$20,A6)
.L7:
            movea.l ($52,A3),A0
            move.l  (-$14,A6),-(SP)
            move.w  (-$1E,A6),-(SP)
            move.w  (-$1C,A6),-(SP)
            move.w  (-$20,A6),($44,A0)
            move.w  (-$1A,A6),-(SP)
            move.l  (-$10,A6),-(SP)
            pea     (-$C,A6)
            move.l  #$8012001A,-(SP)
            _ScriptUtil
            movea.l ($52,A3),A0
            move.w  (-$20,A6),($44,A0)
            move.l  (-$C,A6),D0
            move.l  D0,D1
            swap    D1
            cmp.w   D0,D1
            bcc.b   .L8
            exg     D0,D1
.L8:
            add.w   (-$24,A6),D0
            add.w   (-$24,A6),D1
            move.l  (-$18,A6),D2
            movem.l (SP)+,D3-D5/A0-A2
            unlk    A6
            rts
.L9:
            andi.b  #$FE,D2
.L10:
            swap    D2
            move.w  D0,D2
            move.w  D0,D1
            beq.b   .L11
            bsr.b   LeftScan
.L11:
            bclr    #$11,D2
.L12:
            cmp.w   ($3C,A3),D1
            bcc.b   .L13
            movea.w D1,A1
            bsr.b   CallBreak
            bne.b   .L13
            addq.w  #1,D1
            bra.b   .L12
.L13:
            rts
LeftScan:
            bset    #$11,D2
.L1:
            subq.w  #1,D0
            movea.w D0,A1
            bsr.b   CallBreak
            bne.b   .L2
            tst.w   D0
            beq.b   .L3
            bra.b   .L1
.L2:
            addq.w  #1,D0
.L3:
            rts
CallBreak:
            movem.l D0/A0-A1,-(SP)
            move.w  A1,D0
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            movea.l ($26,A3),A1
            jsr     (A1)
            movem.l (SP)+,D0/A0-A1
            rts
sub_408240B4:
            andi.l  #$FFFF,D0
            cmpi.b  #$20,(0,A0,D0.l)
            sls     D0
            tst.b   D0
            rts
StylMeasure:
            movem.l D2-D3/D5/A2,-(SP)
            tst.w   ($50,A3)
            bmi.b   .L1
            move.w  D7,D0
            move.w  D6,D1
            bsr.b   SetUp_StyledTextEdit
            add.w   D6,D1
            bra.b   .L5
.L1:
            move.w  D6,D5
            move.w  D6,D3
            move.w  D3,D0
            bsr.w   GetCurStyle
            movea.l A0,A2
            move.w  D7,D1
            bsr.w   GetNumStyles
            move.w  D0,D2
.L2:
            movea.l A2,A0
            bsr.w   SetStyle
            addq.l  #4,A2
            movea.l A2,A0
            move.w  (A0),D0
            cmp.w   D0,D7
            bcc.b   .L3
            move.w  D7,D0
.L3:
            move.w  D3,D1
            move.w  D0,D3
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            suba.l  A0,A2
            bsr.b   SetUp_StyledTextEdit
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            adda.l  A0,A2
            add.w   D1,D5
            tst.w   D0
            bne.b   .L4
            subq.w  #1,D2
            bne.b   .L2
.L4:
            move.w  D5,D1
.L5:
            movem.l (SP)+,D2-D3/D5/A2
            rts
SetUp_StyledTextEdit:
            move.w  D2,-(SP)
            sub.w   D1,D0
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            adda.w  D1,A0
            move.w  D4,D1
            moveq   #0,D2
            bsr.w   TEHitTestHook
            sub.w   D0,D4
            swap    D0
            move.w  (SP)+,D2
            rts
sub_40824144:
            move.l  ($7FC).w,-(SP)
            rts
XFINDLINE:
            movea.l ExpandMem,A0
            cmpi.b  #1,($2C,A0)
            beq.w   .L17
            movem.l D1-D7/A0-A2,-(SP)
            link.w  A6,#-$2C
            moveq   #0,D7
            move.w  D6,(-$28,A6)
            move.w  D6,(-$2A,A6)
            clr.w   (-$26,A6)
            moveq   #0,D0
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            subq.w  #1,D0
            swap    D0
            move.l  D0,(-8,A6)
            moveq   #0,D1
            move.w  ($3C,A3),D1
            sub.w   D6,D1
            move.l  D1,(-4,A6)
            movea.l ($3E,A3),A2
            movea.l (A2),A2
            adda.w  D6,A2
            addq.w  #1,D1
            tst.b   ($48,A3)
            bge.b   .L4
            bra.b   .L2
.L1:
            move.b  (A2)+,D0
            bsr.w   TEEolHook
.L2:
            dbeq    D1,.L1
            beq.b   .L3
            move.w  ($3C,A3),D0
            bra.w   .L16
.L3:
            move.w  ($3C,A3),D0
            sub.l   D1,D0
            addq.w  #1,D0
            bra.w   .L16
.L4:
            subq.w  #1,D1
            move.l  A2,(-$20,A6)
            move.l  A2,(-$24,A6)
            tst.w   ($50,A3)
            bpl.w   .L11
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            cmpi.w  #1,(A1)
            beq.b   .L5
            moveq   #1,D7
.L5:
            moveq   #0,D0
            move.w  D6,D0
            bsr.w   GetCurStyle
            addq.w  #1,D0
            move.w  D0,(-$2C,A6)
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            cmp.w   (A1),D0
            bcs.b   .L6
            moveq   #0,D7
.L6:
            lea     (4,A0),A1
            move.l  A0,(-$18,A6)
            move.l  A1,(-$1C,A6)
            bsr.w   SetStyle
            move.w  D6,D0
            bsr.w   sub_40823E5E
            clr.l   (-$C,A6)
            move.w  (A0),D1
            cmp.w   (-$28,A6),D1
            bcs.b   .L7
            beq.b   .L8
            sub.w   (-$28,A6),D1
            movea.l (-$24,A6),A0
            adda.w  D1,A0
            move.l  A0,(-$20,A6)
            move.w  D1,(-$26,A6)
            bra.b   .L9
.L7:
            move.w  (-$28,A6),D2
            sub.w   D1,D2
            sub.w   D2,D0
.L8:
            move.l  #1,(-$C,A6)
.L9:
            move.w  D0,-(SP)
            moveq   #0,D0
            move.w  (SP)+,D0
            move.l  D0,(-4,A6)
            moveq   #0,D1
            movea.l (-$18,A6),A0
            move.w  (A0),D1
            cmp.w   (-$28,A6),D1
            bcc.b   .L10
            move.w  D6,D1
.L10:
            move.l  D1,(-$10,A6)
            move.w  (-$28,A6),D0
            add.w   (-$26,A6),D0
            sub.l   D0,(-$10,A6)
            move.w  (4,A0),D1
            sub.l   D0,D1
            move.l  D1,(-$14,A6)
            tst.w   D7
            bne.b   .L12
            subq.l  #1,(-$14,A6)
            bra.b   .L12
.L11:
            clr.w   (-$18,A6)
            clr.l   (-$10,A6)
            move.l  (-4,A6),(-$14,A6)
.L12:
            clr.w   -(SP)
            move.l  (-$20,A6),-(SP)
            move.l  (-4,A6),-(SP)
            move.l  (-$10,A6),-(SP)
            move.l  (-$14,A6),-(SP)
            clr.l   -(SP)
            pea     (-8,A6)
            pea     (-$C,A6)
            move.l  #$821CFFFE,-(SP)
            _ScriptUtil
            clr.w   D1
            move.b  (SP)+,D1
            cmpi.w  #2,D1
            beq.b   .L13
            bra.b   .L15
.L13:
            tst.w   D7
            beq.b   .L15
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            move.w  (-$2C,A6),D0
            addq.w  #1,D0
            move.w  D0,(-$2C,A6)
            cmp.w   (A1),D0
            bne.b   .L14
            moveq   #0,D7
            movea.l (-$1C,A6),A0
            move.w  (4,A0),D6
            sub.w   (A0),D6
            subq.w  #1,D6
            beq.b   .L15
.L14:
            moveq   #0,D0
            move.w  (-$A,A6),D1
            sub.l   (-$10,A6),D1
            add.w   D1,(-$2A,A6)
            movea.l (-$1C,A6),A0
            lea     (4,A0),A1
            move.w  (A0),D6
            bra.w   .L6
.L15:
            moveq   #0,D0
            move.w  (-$A,A6),D0
            sub.l   (-$10,A6),D0
            add.w   (-$2A,A6),D0
.L16:
            unlk    A6
            movem.l (SP)+,D1-D7/A0-A2
            rts
.L17:
            movem.l D1-D7/A0-A2,-(SP)
            move.w  (6,A3),D4
            sub.w   (2,A3),D4
            subq.w  #1,D4
            suba.l  A2,A2
            move.w  D6,D7
            moveq   #0,D3
            moveq   #0,D5
.L18:
            move.w  D7,D0
            moveq   #$D,D2
            bsr.w   sub_40823F34
            move.w  D1,D7
            tst.b   ($48,A3)
            bne.b   .L19
            bsr.w   StylMeasure
            tst.w   D0
            bne.b   .L21
.L19:
            move.w  D7,D5
            addq.w  #1,A2
            cmp.w   ($3C,A3),D7
            beq.b   .L25
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            and.l   sub_408240B4+2,D7
            move.b  (0,A0,D7.l),D0
            movem.l D1,-(SP)
            bsr.w   TEEolHook
            movem.l (SP)+,D1
            bne.b   .L20
            addq.w  #1,D5
            bra.b   .L25
.L20:
            move.w  D7,D6
            addq.w  #1,D7
            bra.b   .L18
.L21:
            move.w  A2,D0
            beq.b   .L24
            movea.l ($3E,A3),A0
            movea.l (A0),A0
.L22:
            addq.w  #1,D5
            cmp.w   ($3C,A3),D5
            bcc.b   .L25
            move.b  (0,A0,D5.w),D0
            movem.l D1/A0,-(SP)
            bsr.w   TEEolHook
            movem.l (SP)+,D1/A0
            bne.b   .L23
            addq.w  #1,D5
            bra.b   .L25
.L23:
            cmpi.b  #$20,(0,A0,D5.w)
            beq.b   .L22
            bra.b   .L25
.L24:
            subq.w  #1,D1
            move.w  D1,D5
.L25:
            move.w  D5,D0
            movem.l (SP)+,D1-D7/A0-A2
            rts
sub_408243B2:
            move.l  TERecal,-(SP)
            rts
XReCalLines:
            link.w  A6,#-$E
            movem.l D3/D5-D6/A2,-(SP)
            move.w  ($5E,A3),(-$E,A6)
            clr.w   ($5E,A3)
            clr.w   (-4,A6)
            move.w  ($3C,A3),(-2,A6)
            tst.w   ($3C,A3)
            beq.b   .L7
            lea     ($60,A3),A2
            moveq   #$10,D2
            move.w  ($20,A3),D0
            bsr.w   sub_40823F34
            move.w  D0,D3
.L1:
            move.w  (A2)+,D6
            move.w  D6,(-4,A6)
            cmp.w   (A2),D3
            bcs.b   .L2
            beq.b   .L5
            addq.w  #1,($5E,A3)
            bra.b   .L1
.L2:
            bsr.w   sub_40824144
            cmp.w   D0,D3
            bcc.b   .L4
.L3:
            tst.b   WordRedraw
            bgt.b   .L4
            blt.b   .L6
            move.w  ($20,A3),D3
.L4:
            tst.w   ($3A,A3)
            bne.b   .L6
            tst.w   TESysJust
            bne.b   .L6
            tst.b   WordRedraw
            bne.b   .L6
            move.w  D3,(-4,A6)
            beq.b   .L6
            subq.w  #1,(-4,A6)
            bra.b   .L6
.L5:
            bsr.w   sub_40824144
            cmp.w   D0,D3
            bne.b   .L4
            move.w  D3,(-4,A6)
            bra.b   .L3
.L6:
            move.w  D0,D3
            bsr.b   InsertRecal
            bra.b   .L8
.L7:
            clr.l   ($60,A3)
.L8:
            bsr.w   SetLineHite
            move.w  (-2,A6),D4
            move.w  (-4,A6),D2
            movea.l A4,A0
            _GetHandleSize
            tst.l   D0
            bpl.b   .L9
            _SysError
.L9:
            subi.l  #$68,D0
            lsr.l   #1,D0
            andi.l  #$7FFF,D0
            sub.w   ($5E,A3),D0
            beq.b   .L10
            bmi.b   .L10
            cmpi.w  #8,D0
            bcs.b   .L10
            moveq   #0,D0
            move.w  ($5E,A3),D0
            lsl.l   #1,D0
            addi.l  #$68,D0
            movea.l A4,A0
            bsr.w   MySetHandleSize
.L10:
            movem.l (SP)+,D3/D5-D6/A2
            unlk    A6
            rts
InsertRecal:
            movem.l D2/D4,-(SP)
            moveq   #0,D5
            move.w  ($22,A3),D4
            tst.w   D7
            bpl.b   .L1
            sub.w   D7,D4
.L1:
            suba.l  A3,A2
            move.l  #$100,D0
            move.l  D0,D2
            bsr.w   MyNewHandle
            _HLock
            movea.l (A0),A1
            move.l  A0,(-8,A6)
            adda.l  A3,A2
            move.l  A2,(-$C,A6)
.L2:
            cmp.w   D6,D3
            bne.b   .L3
            addq.w  #1,D3
.L3:
            cmp.w   D4,D3
            bls.b   .L6
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            move.b  (-1,A0,D3.w),D0
            bsr.w   TEEolHook
            bne.b   .L5
            movea.l A2,A0
            move.w  D3,D0
            add.w   D7,D0
.L4:
            cmp.w   (A0)+,D0
            bhi.b   .L4
            subq.w  #2,A0
            move.l  A0,(-$C,A6)
            bra.b   .L9
.L5:
            moveq   #0,D0
            move.w  (-$E,A6),D0
            add.w   D0,D0
            cmp.l   D0,D5
            bcc.b   .L6
            move.w  (0,A2,D5.l),D0
            sub.w   D3,D0
            cmp.w   D0,D7
            bne.b   .L6
            add.l   D5,(-$C,A6)
            bra.b   .L9
.L6:
            cmp.l   D5,D2
            bgt.b   .L7
            movea.l (-8,A6),A0
            _HUnlock
            addi.l  #$100,D2
            move.l  D2,D0
            suba.l  (A0),A1
            bsr.w   MySetHandleSize
            _HLock
            adda.l  (A0),A1
.L7:
            move.w  D3,(A1)+
            move.w  D3,D6
            addq.w  #1,($5E,A3)
            addq.l  #2,D5
            cmp.w   ($3C,A3),D6
            bcs.b   .L8
            move.w  (-$E,A6),D0
            addq.w  #1,D0
            add.w   D0,D0
            lea     ($60,A3,D0.w),A0
            move.l  A0,(-$C,A6)
            bra.b   .L10
.L8:
            bsr.w   sub_40824144
            move.w  D0,D3
            bra.w   .L2
.L9:
            move.w  D3,(-2,A6)
            move.l  (-$C,A6),D0
            sub.l   A2,D0
            sub.l   D5,D0
            beq.b   .L10
            move.w  ($3C,A3),D3
.L10:
            move.w  D3,(-2,A6)
            movea.l A4,A0
            _HUnlock
            subq.l  #4,SP
            move.l  A4,-(SP)
            move.l  A2,D0
            sub.l   A3,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
            move.l  (-$C,A6),D0
            sub.l   A2,D0
            move.l  D0,-(SP)
            movea.l (-8,A6),A0
            move.l  (A0),-(SP)
            move.l  D5,-(SP)
            suba.l  A3,A2
            _Munger
            addq.l  #4,SP
            movea.l A4,A0
            _HLock
            movea.l (A4),A3
            adda.l  A3,A2
            adda.l  D5,A2
            movea.l (-8,A6),A0
            _DisposHandle
            cmp.w   ($3C,A3),D6
            bcc.b   .L12
.L11:
            addq.w  #1,($5E,A3)
            sub.w   D7,(A2)
            move.w  (A2)+,D6
            cmp.w   ($3C,A3),D6
            bcs.b   .L11
.L12:
            movem.l (SP)+,D2/D4
            rts
SetLineHite:
            movem.l D2-D5/A2/A4,-(SP)
            tst.w   ($50,A3)
            bpl.w   .L8
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            _GetHandleSize
            move.w  D0,D3
            asr.w   #2,D3
            moveq   #0,D0
            move.w  ($5E,A3),D0
            addq.l  #1,D0
            lsl.l   #2,D0
            bsr.w   MySetHandleSize
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            movea.l (8,A1),A4
            movea.l (A4),A4
            tst.w   ($3C,A3)
            bne.b   .L1
            move.w  ($16,A1),D0
            bsr.w   GetStyle
            move.w  (2,A0),(A4)+
            move.w  (4,A0),(A4)
            bra.w   .L8
.L1:
            movea.l (4,A1),A0
            movea.l (A0),A0
            lea     ($14,A1),A1
            lea     ($60,A3),A2
            moveq   #0,D1
            moveq   #0,D2
            moveq   #-1,D4
            move.w  (A4),D5
.L2:
            move.w  (2,A1),D0
            mulu.w  #$12,D0
            cmp.w   (2,A0,D0.l),D1
            bge.b   .L4
            move.w  (2,A0,D0.l),D1
            cmp.w   D2,D3
            ble.b   .L3
            tst.w   (A4)
            bmi.b   .L4
.L3:
            move.w  D1,(A4)
            move.w  (4,A0,D0.l),(2,A4)
.L4:
            move.w  (2,A2),D0
            cmp.w   (4,A1),D0
            bcs.b   .L6
            beq.b   .L5
            addq.l  #4,A1
            bra.b   .L2
.L5:
            addq.l  #4,A1
.L6:
            addq.l  #2,A2
            tst.l   D4
            bpl.b   .L7
            cmp.w   (A4),D5
            beq.b   .L7
            moveq   #0,D4
            move.w  D2,D4
.L7:
            addq.l  #4,A4
            move.w  (A4),D5
            moveq   #0,D1
            addq.w  #1,D2
            cmp.w   ($5E,A3),D2
            bcs.b   .L2
            move.l  (-4,A4),(A4)
            tst.l   D4
            bmi.b   .L8
            move.w  ($3C,A3),(-2,A6)
            add.w   D4,D4
            move.w  ($60,A3,D4.w),D0
            cmp.w   (-4,A6),D0
            bcc.b   .L8
            move.w  D0,(-4,A6)
.L8:
            movem.l (SP)+,D2-D5/A2/A4
            rts
ShowCaret:
            tst.b   ($24,A3)
            beq.w   DrawIt.L4
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.w   DrawIt.L4
            st      ($39,A3)
sub_408246A8:
            tst.b   ($38,A3)
            bne.b   DrawIt.L4
            st      ($38,A3)
.L1:
            bra.b   DrawIt
HideCaret:
            tst.b   ($24,A3)
            beq.b   DrawIt.L4
            sf      ($39,A3)
            tst.b   ($38,A3)
            beq.b   DrawIt.L4
            sf      ($38,A3)
DrawIt:
            movem.l D0-D7,-(SP)
            move.w  ($20,A3),D3
            move.w  D3,D4
            moveq   #-2,D7
            bsr.w   DoText
.L1:
            move.l  ($5A,A3),D0
            bsr.w   sub_40823B0E
            tst.w   ($50,A3)
            bmi.b   .L2
            tst.b   WordRedraw
            bmi.b   .L2
            tst.b   TESysJust
            beq.b   .L3
.L2:
            movea.l ExpandMem,A0
            tst.b   ($2E,A0)
            beq.b   .L3
            movea.l ExpandMem,A0
            lea     ($30,A0),A0
            move.l  (A0)+,($10,A3)
            move.l  (A0),($14,A3)
            movea.l ExpandMem,A0
            sf      ($2E,A0)
            sf      (A0)
            bra.b   .L1
.L3:
            movem.l (SP)+,D0-D7
.L4:
            rts
TEActivate:
            bsr.w   StdEntry_StyledTextEdit
            tst.b   ($24,A3)
            bne.b   .L2
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.b   .L1
            st      ($39,A3)
.L1:
            st      ($24,A3)
            bsr.w   HiLite
.L2:
            bra.b   TEIdle.L2
TEDeactivate:
            bsr.w   StdEntry_StyledTextEdit
            tst.b   ($24,A3)
            beq.b   TEIdle.L2
            bsr.w   HideCaret
            bsr.w   HiLite
            sf      ($24,A3)
            bra.b   TEIdle.L2
TEIdle:
            bsr.w   StdEntry_StyledTextEdit
            movea.l ($42,A3),A0
            movea.l (A0),A0
            move.l  ($10,A0),D0
            btst    #1,D0
            beq.b   .L1
            bsr.w   sub_40824C90
.L1:
            tst.b   ($39,A3)
            beq.b   .L2
            subq.w  #4,SP
            _TickCount
            movea.l (SP)+,A0
            cmpa.l  ($34,A3),A0
            bcs.b   .L2
            adda.l  CaretTime,A0
            move.l  A0,($34,A3)
            bsr.w   DrawIt
            not.b   ($38,A3)
.L2:
            bra.w   TECalText.L1
TEPaste:
            bsr.w   StdEntry_StyledTextEdit
            moveq   #0,D7
            bsr.b   DoPaste
            bra.b   TEIdle.L2
DoPaste:
            tst.w   ($50,A3)
            bpl.b   .L2
            moveq   #0,D0
            bsr.w   MyNewHandle
            move.l  A0,D6
            move.l  A0,-(SP)
            subq.l  #4,SP
            movea.l SP,A1
            subq.l  #4,SP
            move.l  A0,-(SP)
            move.l  #'TEXT',-(SP)
            move.l  A1,-(SP)
            _GetScrap
            move.l  (SP)+,D0
            addq.l  #4,SP
            tst.l   D0
            ble.b   .L1
            move.l  D0,D5
            movea.l D6,A0
            _HLock
            move.l  (A0),D6
            bsr.b   PasteGuts
.L1:
            movea.l (SP)+,A0
            _DisposHandle
            bra.b   .L3
.L2:
            movea.l TEScrpHandle,A0
            _HLock
            move.l  (A0),D6
            moveq   #0,D5
            move.w  TEScrpLength,D5
            bsr.b   PasteGuts
            movea.l TEScrpHandle,A0
            _HUnlock
.L3:
            rts
            moveq   #1,D7
            bsr.b   DoPaste
            moveq   #6,D0
            bra.w   TECalText.L3
PstRsrved:
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            movea.l (A0),A0
            movea.l (4,A0),A1
            move.l  A1,-(SP)
            movea.l (A1),A0
            tst.w   (A0)
            beq.b   .L1
            movem.l D3/A4,-(SP)
            movea.l A1,A4
            movea.l A1,A0
            _HLock
            moveq   #0,D3
            move.w  ($20,A3),D3
            bsr.w   PstStylGuts
            movem.l (SP)+,D3/A4
            bra.b   .L2
.L1:
            bsr.w   ExtendStyle
.L2:
            movea.l (SP)+,A0
            _HUnlock
            rts
PasteGuts:
            move.w  D7,-(SP)
            bsr.w   HideCaret
            bsr.w   HiLite
            tst.w   ($50,A3)
            bpl.b   .L2
            tst.w   (SP)
            beq.b   .L1
            bsr.b   PasteStyle
            bra.b   .L2
.L1:
            bsr.b   PstRsrved
.L2:
            bsr.w   SelSort
            move.w  D0,D7
            sub.w   (A2),D7
            bsr.w   MungeSetup
            move.w  D7,-(SP)
            clr.w   -(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            _Munger
            addq.l  #4,SP
            movea.l ($3E,A3),A0
            _HLock
            sub.w   D7,($3C,A3)
            add.w   D5,($3C,A3)
            sub.w   D5,D7
            bsr.w   RecalDraw
            bsr.w   sub_4082584C
            lea     ($20,A3),A0
            add.w   D5,(A0)
            move.w  (A0)+,(A0)
            bsr.w   ShowCaret
            bsr.w   SelView
            addq.l  #2,SP
            rts
PasteStyle:
            tst.w   ($50,A3)
            bpl.b   .L3
            movem.l D2-D6/A2/A4,-(SP)
            bsr.w   SelSort
            move.w  D0,D4
            swap    D0
            moveq   #0,D3
            move.w  D0,D3
            moveq   #0,D0
            bsr.w   MyNewHandle
            movea.l A0,A4
            move.l  A0,-(SP)
            subq.l  #4,SP
            movea.l SP,A1
            subq.l  #4,SP
            move.l  A0,-(SP)
            move.l  #'styl',-(SP)
            move.l  A1,-(SP)
            _GetScrap
            move.l  (SP)+,D0
            addq.l  #4,SP
            tst.l   D0
            bpl.b   .L1
            bsr.w   PstRsrved
            bra.b   .L2
.L1:
            movea.l A4,A0
            _HLock
            move.w  D3,D0
            move.w  D4,D1
            bsr.w   DeleteStyle
            bsr.b   PstStylGuts
.L2:
            movea.l (SP)+,A0
            _DisposHandle
            movem.l (SP)+,D2-D6/A2/A4
.L3:
            rts
PstStylGuts:
            move.w  D3,D0
            subq.w  #1,D0
            bsr.w   GetCurStyle
            move.w  D0,D4
            movea.l (A4),A4
            move.w  (A4),D2
            lea     (2,A4),A4
            move.w  D3,D0
            bne.b   .L1
            tst.w   D2
            beq.b   .L2
            subq.w  #1,D4
            bra.b   .L2
.L1:
            bsr.w   sub_408249B6
            addq.l  #4,A0
.L2:
            add.w   D2,D4
            bsr.b   MakeRoom
            movea.l A0,A2
            movea.l ($4A,A3),A0
            _HLock
.L3:
            move.l  (A4),D1
            add.l   D3,D1
            cmpi.l  #$FFFF,D1
            bhi.b   .L5
            move.w  D1,-(SP)
            movea.l A4,A0
            addq.l  #2,A0
            bsr.w   FindStyle
            tst.l   D0
            bne.b   .L4
            movea.l A4,A0
            addq.l  #2,A0
            bsr.w   AddStyle
            move.w  #1,(A1)
.L4:
            move.w  (SP)+,D1
            move.w  D1,(A2)+
            move.w  D0,(A2)+
.L5:
            adda.w  #$14,A4
            subq.w  #1,D2
            bne.b   .L3
            subq.w  #4,A2
            movea.l ($4A,A3),A0
            _HUnlock
            movea.l A2,A0
            move.w  D4,D0
            bsr.w   RecalStStarts
            bsr.w   ConcatStyles
            bsr.w   ClearRsrved
            rts
MakeRoom:
            movem.l D2-D3/A2,-(SP)
            movea.l A0,A2
            movea.l ($4A,A3),A0
            _HUnlock
            movea.l (A0),A1
            moveq   #1,D0
            add.w   (A1),D0
            add.w   D2,(A1)
            lsl.l   #2,D0
            move.l  D0,D3
            addi.l  #$14,D0
            lea     ($14,A1),A1
            suba.l  A1,A2
            sub.l   A2,D3
            ext.l   D2
            lsl.l   #2,D2
            add.l   D2,D0
            bsr.w   MySetHandleSize
            movea.l (A0),A1
            lea     ($14,A1),A1
            adda.l  A2,A1
            _HLock
            movea.l A1,A0
            adda.l  D2,A1
            move.l  D3,D0
            _StripAddress
            _BlockMove
            movem.l (SP)+,D2-D3/A2
            rts
sub_408249B6:
            move.l  D2,-(SP)
            movea.l A0,A1
            addq.l  #4,A0
            move.w  D0,D2
            move.w  (A0),D0
            cmp.w   ($3C,A3),D0
            bls.b   .L1
            subq.w  #1,D0
.L1:
            exg     D0,D2
            cmp.w   D0,D2
            beq.b   .L2
            move.w  D0,-(SP)
            moveq   #1,D2
            bsr.b   MakeRoom
            movea.l A0,A1
            subq.w  #4,A1
            move.w  (SP)+,(A0)
            move.w  (2,A1),D0
            move.w  D0,(2,A0)
            bsr.w   GetStyle
            addq.w  #1,(A0)
.L2:
            move.l  (SP)+,D2
            movea.l A1,A0
            rts
FindStyle:
            move.l  D2,-(SP)
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            move.w  (2,A1),D2
            movea.l (4,A1),A1
            movea.l (A1),A1
            lea     (6,A0),A0
            move.w  D2,D1
.L1:
            tst.w   (A1)
            beq.b   .L2
            bsr.b   CompareStyles
            beq.b   .L3
.L2:
            adda.w  #$12,A1
            subq.w  #1,D1
            bne.b   .L1
            moveq   #0,D0
            bra.b   .L4
.L3:
            moveq   #1,D0
            swap    D0
            sub.w   D1,D2
            move.w  D2,D0
            addq.w  #1,(A1)
            movea.l A1,A0
.L4:
            move.l  (SP)+,D2
            rts
CompareStyles:
            movem.l A0-A1,-(SP)
            lea     (6,A1),A1
            moveq   #$C,D0
.L1:
            cmpm.b  (A0)+,(A1)+
            bne.b   .L2
            subq.w  #1,D0
            bne.b   .L1
.L2:
            movem.l (SP)+,A0-A1
            rts
AddStyle:
            movem.l D2-D3/A2,-(SP)
            movea.l ($4A,A3),A1
            movea.l (A1),A2
            move.w  (2,A2),D0
            move.w  D0,D3
            movea.l (4,A2),A1
            movea.l (A1),A1
.L1:
            tst.w   (A1)
            beq.b   .L2
            adda.w  #$12,A1
            subq.w  #1,D0
            bne.b   .L1
            move.l  A0,-(SP)
            addq.w  #1,(2,A2)
            movea.l (4,A2),A0
            _GetHandleSize
            move.l  D0,D2
            addi.l  #$12,D0
            movea.l A0,A2
            bsr.w   MySetHandleSize
            movea.l (SP)+,A0
            movea.l (A2),A1
            adda.l  D2,A1
            moveq   #0,D0
.L2:
            sub.w   D0,D3
            moveq   #$12,D0
            _BlockMove
            move.w  D3,D0
            movem.l (SP)+,D2-D3/A2
            rts
MungeSetup:
            movea.l (SP)+,A1
            movea.l ($3E,A3),A0
            _HUnlock
            subq.l  #4,SP
            move.l  A0,-(SP)
            move.w  ($20,A3),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jmp     (A1)
InsRsrved:
            tst.w   D5
            beq.b   .L2
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            movea.l (A0),A0
            movea.l (4,A0),A1
            movea.l (A1),A0
            tst.w   (A0)
            beq.b   .L1
            movem.l D3/A4,-(SP)
            movea.l A1,A4
            moveq   #0,D3
            move.w  ($20,A3),D3
            bsr.w   PstStylGuts
            movem.l (SP)+,D3/A4
            bsr.w   ClearRsrved
            bsr.w   sub_4082584C
            bra.b   .L2
.L1:
            move.w  ($20,A3),D0
            subq.w  #1,D0
            bsr.w   GetCurStyle
            bsr.w   RecalStStarts
.L2:
            rts
InsGuts:
            bsr.b   MungeSetup
            clr.l   -(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            _Munger
            addq.l  #4,SP
            movea.l ($3E,A3),A0
            _HLock
            add.w   D5,($3C,A3)
            sub.w   D5,D7
            tst.w   ($50,A3)
            bpl.b   .L1
            bsr.b   InsRsrved
.L1:
            rts
TEInsert:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   HideCaret
            bsr.w   HiLite
            moveq   #0,D7
            movem.l (A2)+,D5-D6
            bsr.b   InsGuts
            bsr.w   RecalDraw
            add.w   D5,($20,A3)
            add.w   D5,($22,A3)
            bsr.w   ShowCaret
            bsr.w   HiLite
.L1:
            moveq   #$C,D0
            bra.w   TECalText.L2
TEKey:
            bsr.w   StdEntry_StyledTextEdit
            st      ($47,A3)
            _ObscureCursor
            move.w  (A2),D1
            cmpi.b  #8,D1
            beq.w   .L12
            moveq   #1,D2
            moveq   #$1F,D0
            sub.b   D1,D0
            blt.b   .L1
            beq.b   .L3
            subq.b  #1,D0
            beq.b   .L2
            subq.b  #1,D0
            beq.b   .L4
            subq.b  #1,D0
            beq.b   .L5
.L1:
            movea.l ($42,A3),A0
            movea.l (A0),A0
            move.l  ($10,A0),D0
            btst    #1,D0
            beq.b   .L10
            bsr.w   sub_40824C3C
            bra.w   .L14
.L2:
            moveq   #-1,D2
.L3:
            move.w  D2,-(SP)
            move.w  ($20,A3),D3
            move.w  D3,D4
            moveq   #-2,D7
            bsr.w   DoText
            move.w  (SP)+,D2
            bsr.w   FindLineHite
            muls.w  D1,D2
            move.l  ($10,A3),($1C,A3)
            add.w   D2,($1C,A3)
            bsr.w   DOFIND
            st      ($47,A3)
            bra.b   .L9
.L4:
            move.w  ($22,A3),D6
            moveq   #1,D3
            bra.b   .L6
.L5:
            move.w  ($20,A3),D6
            beq.b   .L6
            moveq   #-1,D3
.L6:
            tst.b   WordRedraw
            blt.b   .L7
            tst.b   TESysJust
            beq.b   .L8
.L7:
            bsr.w   sub_40824D14
            bra.b   .L9
.L8:
            bsr.w   DoubleByte
.L9:
            ext.l   D6
            move.l  D6,-(SP)
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            _TESetSelect
            bsr.w   sub_408246A8
            bra.b   .L14
.L10:
            move.l  A2,D6
            addq.w  #1,D6
            moveq   #1,D5
            bsr.w   sub_40824F7E
            bcs.b   .L14
            tst.w   ($50,A3)
            bpl.b   .L11
            move.w  ($20,A3),D0
            subq.w  #1,D0
            bsr.w   sub_4082502C
.L11:
            moveq   #0,D7
            bsr.w   PasteGuts
            movea.l ExpandMem,A0
            clr.w   ($52,A0)
            bra.b   .L14
.L12:
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.b   .L13
            tst.w   D0
            beq.b   .L14
            bsr.w   HideCaret
            move.w  ($20,A3),D6
            moveq   #-1,D3
            bsr.w   DoubleByte
            move.w  D6,($20,A3)
.L13:
            move.l  A4,-(SP)
            _TEDelete
.L14:
            moveq   #6,D0
            bra.w   TECalText.L2
sub_40824C3C:
            movea.l ExpandMem,A0
            movea.l ($D8,A0),A0
            jmp     (A0)
xTEBufferText:
            movea.l ExpandMem,A1
            tst.l   ($52,A1)
            bne.b   .L1
            move.w  #$32,D0
            bsr.b   GetHandle
            movea.l ExpandMem,A1
            move.l  A0,($4E,A1)
            move.l  (A0),($52,A1)
.L1:
            movea.l ($52,A1),A0
            move.w  ($56,A1),D0
            cmpi.w  #$32,D0
            bne.b   .L2
            bsr.b   sub_40824C90
.L2:
            move.b  (1,A2),(0,A0,D0.l)
            addq.w  #1,($56,A1)
            rts
GetHandle:
            _NewHandleClear
            bne.b   .L2
            _HLock
            bne.b   .L1
            rts
.L1:
            move.l  D0,-(SP)
            _DisposHandle
            move.l  (SP)+,D0
.L2:
            _SysError
sub_40824C90:
            movea.l ExpandMem,A0
            movea.l ($DC,A0),A0
            jmp     (A0)
xDumpBuffer:
            movem.l D0-D7/A1-A4,-(SP)
            moveq   #0,D3
            movea.l ExpandMem,A2
            lea     ($56,A2),A2
            move.w  (A2),D2
            tst.b   D2
            beq.b   .L4
            subq.w  #1,D2
            movea.l ExpandMem,A1
            lea     ($52,A1),A1
            move.l  A1,-(SP)
            clr.w   -(SP)
            move.l  (A1),-(SP)
            move.w  D2,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            move.w  (SP)+,D7
            movea.l (SP)+,A1
            tst.w   D7
            bge.b   .L1
            move.w  (0,A1,D2.l),D3
            subq.w  #1,(A2)
.L1:
            move.l  (A1),D6
            move.w  (A2),D5
            movem.l D3/A1-A2,-(SP)
            tst.w   ($50,A3)
            bpl.b   .L2
            move.w  ($20,A3),D0
            bsr.w   sub_4082502C
.L2:
            moveq   #0,D7
            bsr.w   PasteGuts
            movem.l (SP)+,D3/A1-A2
            tst.b   D3
            beq.b   .L3
            move.w  D3,(A1)
            move.w  #1,(A2)
            bra.b   .L4
.L3:
            movea.l ExpandMem,A0
            lea     ($4E,A0),A0
            _DisposHandle
            clr.w   (A2)
.L4:
            movem.l (SP)+,D0-D7/A1-A4
            rts
sub_40824D14:
            movea.l ExpandMem,A1
            movea.l ($E0,A1),A1
            jmp     (A1)
xCursorMovement:
            link.w  A6,#-$36
            movem.l D2-D5/D7/A2,-(SP)
            sf      (-$33,A6)
            cmpi.w  #$1C,D1
            beq.b   .L1
            move.b  #$FF,D0
            move.w  #1,D7
            move.b  #1,D2
            moveq   #0,D1
            bra.b   .L2
.L1:
            moveq   #0,D0
            move.w  #$FFFF,D7
            moveq   #0,D2
            move.b  #1,D1
.L2:
            cmp.b   TESysJust,D0
            beq.b   .L3
            move.w  #$FFFF,D5
            move.b  #1,D3
            moveq   #0,D4
            bra.b   .L4
.L3:
            move.w  #1,D5
            moveq   #0,D3
            move.b  #1,D4
.L4:
            move.w  D6,D0
            lea     ($60,A3),A2
            movea.l A2,A0
            bsr.w   GetLine
            move.w  ($5E,A3),D0
            lsl.w   #1,D0
            adda.w  D0,A0
            cmpa.l  A0,A2
            bne.b   .L5
            tst.b   D5
            blt.w   .L27
.L5:
            cmp.w   (A2),D6
            bne.b   .L6
            cmpi.w  #0,D6
            beq.b   .L6
            tst.b   D5
            blt.b   .L6
            subq.w  #2,A2
.L6:
            movem.w D1-D2,-(SP)
            bsr.w   GetFormatOrdering
            movem.w (SP)+,D1-D2
            move.b  D3,D0
            bsr.w   TestLineEnds
            bne.w   .L27
            move.b  D4,D0
            bsr.w   TestLineEnds
            beq.b   .L7
            bsr.w   SetRun
            bsr.w   sub_40824F14
            bne.w   .L25
            bra.w   .L20
.L7:
            bsr.w   sub_40824F62
            cmp.w   (A0),D6
            beq.b   .L8
            bsr.w   FixFormatEnd
            cmp.w   D0,D6
            bcs.b   .L15
            st      (-$33,A6)
.L8:
            movem.l D1-D2,-(SP)
            bsr.w   GetDirection
            move.b  D1,D0
            movem.l (SP)+,D1-D2
            cmp.b   TESysJust,D0
            beq.w   .L17
            move.b  D0,(-$36,A6)
            tst.b   (-$33,A6)
            bne.b   .L9
            subq.l  #4,A0
            bra.b   .L10
.L9:
            addq.l  #4,A0
.L10:
            movem.l D1-D2,-(SP)
            bsr.w   GetDirection
            move.b  D1,D0
            movem.l (SP)+,D1-D2
            cmp.b   (-$36,A6),D0
            bne.b   .L14
            tst.b   (-$33,A6)
            bne.b   .L11
            addq.l  #4,A0
            bra.b   .L12
.L11:
            subq.l  #4,A0
.L12:
            move.w  D1,-(SP)
            move.b  D4,D1
            move.w  D6,D0
            bsr.w   sub_40824F40
            move.w  (SP)+,D1
            exg     D6,D0
            cmp.w   D0,D6
            beq.b   .L13
            bsr.w   sub_40824F62
.L13:
            add.w   D7,D1
            bra.b   .L16
.L14:
            bsr.w   sub_40824F62
            bra.b   .L17
.L15:
            bsr.w   sub_40824F14
            bne.b   .L17
            move.w  D1,-(SP)
            move.b  D4,D1
            move.w  D6,D0
            bsr.w   sub_40824F40
            move.w  (SP)+,D1
            exg     D6,D0
            sub.w   D5,D0
            cmp.w   D0,D6
            bne.w   .L26
            move.w  D1,D0
            move.b  D2,D1
            bsr.w   SetRun
            cmp.w   D0,D1
            beq.b   .L23
            add.w   D7,D0
            move.w  D0,D1
.L16:
            bsr.w   sub_40824F14
            beq.b   .L26
            move.b  D4,D1
            bsr.w   sub_40824F40
            bra.b   .L27
.L17:
            tst.b   D3
            bne.b   .L18
            cmp.w   (A0),D6
            bne.b   .L25
            bra.b   .L19
.L18:
            bsr.w   FixFormatEnd
            cmp.w   D0,D6
            bne.b   .L25
.L19:
            move.w  D1,D0
            move.b  D2,D1
            bsr.b   SetRun
            cmp.w   D0,D1
            beq.b   .L27
            add.w   D7,D0
            move.w  D0,D1
            bsr.b   sub_40824F14
            bne.b   .L25
.L20:
            bsr.w   FixFormatEnd
            sub.w   (A0),D0
            cmpi.w  #1,D0
            bhi.b   .L22
            move.w  D1,D0
            move.b  D2,D1
            bsr.b   SetRun
            cmp.w   D0,D1
            beq.b   .L21
            add.w   D7,D0
            move.w  D0,D1
            bsr.b   sub_40824F14
            beq.b   .L22
.L21:
            move.b  D3,D1
            bsr.w   sub_40824F40
            bra.b   .L27
.L22:
            move.b  D3,D1
            bsr.b   sub_40824F40
            bra.b   .L26
.L23:
            move.b  D3,D1
            tst.b   D1
            bne.b   .L24
            move.w  (A2),D6
            bra.b   .L27
.L24:
            move.w  (2,A2),D6
            bra.b   .L27
.L25:
            sub.w   D5,D6
            bra.b   .L27
.L26:
            add.w   D5,D6
.L27:
            movem.l (SP)+,D2-D5/D7/A2
            unlk    A6
            rts
TestLineEnds:
            cmpi.b  #0,D0
            bne.b   .L1
            clr.b   D0
            cmp.w   (A2),D6
            bne.b   .L2
            st      D0
            bra.b   .L2
.L1:
            clr.b   D0
            cmp.w   (2,A2),D6
            bne.b   .L2
            st      D0
.L2:
            tst.b   D0
            rts
SetRun:
            tst.b   D1
            bne.b   .L1
            moveq   #0,D1
            bra.b   .L2
.L1:
            move.w  (-$28,A6),D1
            subq.w  #1,D1
.L2:
            rts
sub_40824F14:
            movea.l ExpandMem,A1
            movea.l ($E4,A1),A1
            jmp     (A1)
            movem.w D1-D2,-(SP)
            move.w  D1,(-8,A6)
            bsr.w   GetNextDisplayStyle
            clr.w   D0
            bsr.w   GetDirection
            cmp.b   TESysJust,D1
            bne.b   .L1
            st      D0
.L1:
            movem.w (SP)+,D1-D2
            tst.b   D0
            rts
sub_40824F40:
            move.w  D0,-(SP)
            tst.b   D1
            bne.b   .L1
            move.w  (A0),D6
            bra.b   .L2
.L1:
            bsr.b   FixFormatEnd
            move.w  D0,D6
.L2:
            move.w  (SP)+,D0
            rts
FixFormatEnd:
            move.w  (4,A0),D0
            cmp.w   ($3C,A3),D0
            bls.b   .L1
            move.w  ($3C,A3),D0
.L1:
            rts
sub_40824F62:
            bsr.w   GetNextDisplayStyle
            move.w  (-8,A6),D1
            addq.w  #1,(-8,A6)
            cmp.w   (A0),D6
            bhi.b   .L1
            beq.b   .L2
            bra.b   sub_40824F62
.L1:
            bsr.b   FixFormatEnd
            cmp.w   D0,D6
            bhi.b   sub_40824F62
.L2:
            rts
sub_40824F7E:
            movea.l ExpandMem,A0
            movea.l ($E8,A0),A0
            jmp     (A0)
            movea.l ExpandMem,A0
            lea     ($52,A0),A0
            tst.w   (A0)
            beq.b   .L1
            move.b  (1,A2),(1,A0)
            move.l  A0,D6
            addq.w  #1,D5
            bra.b   .L4
.L1:
            move.b  (1,A2),(A0)
            tst.w   ($50,A3)
            bpl.b   .L3
            move.w  ($20,A3),D0
            beq.b   .L2
            cmp.w   ($3C,A3),D0
            bne.b   .L2
            subq.w  #1,D0
.L2:
            bsr.w   GetCurStyle
            bsr.w   SetStyle
.L3:
            clr.w   -(SP)
            move.l  D6,-(SP)
            clr.w   -(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
.L4:
            rts
DoubleByte:
            add.w   D3,D6
            tst.w   ($50,A3)
            bpl.b   .L1
            move.w  D6,D0
            bsr.w   GetCurStyle
            bsr.w   SetStyle
.L1:
            clr.w   -(SP)
            movea.l ($3E,A3),A0
            move.l  (A0),-(SP)
            move.w  D6,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            ble.b   .L2
            add.w   D3,D6
.L2:
            rts
ExtendStyle:
            move.w  D5,-(SP)
            tst.w   ($50,A3)
            bpl.b   .L2
            bsr.w   SelSort
            move.w  D0,D1
            swap    D0
            cmp.w   D0,D1
            beq.b   .L1
            subq.w  #1,D5
            addq.w  #1,D0
            bsr.w   DeleteStyle
.L1:
            tst.w   D5
            beq.b   .L2
            subq.w  #1,D0
            bsr.w   GetCurStyle
            bsr.w   RecalStStarts
.L2:
            move.w  (SP)+,D5
            rts
sub_4082502C:
            movea.l ExpandMem,A0
            movea.l ($EC,A0),A0
            jmp     (A0)
xSetFont2Keyboard:
            bsr.w   GetCurStyle
            movea.l ExpandMem,A1
            cmpi.b  #1,($2C,A1)
            beq.b   .L2
            move.l  A0,-(SP)
            clr.l   -(SP)
            move.w  #$16,-(SP)
            move.l  #$84020008,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.w  D0,-(SP)
            bsr.w   SetStyle
            subq.w  #2,SP
            move.l  #$82000000,-(SP)
            _ScriptUtil
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            cmp.w   D0,D1
            beq.b   .L2
            clr.l   -(SP)
            move.w  D0,-(SP)
            move.w  #$C,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            bsr.w   AnyNullStyle
            beq.b   .L1
            lea     (2,A0),A0
            move.w  (8,A0),D0
.L1:
            movea.l ExpandMem,A0
            move.w  D0,($44,A0)
            movea.l A0,A2
            lea     ($46,A2),A2
            lea     ($44,A0),A0
            move.l  A0,(2,A2)
            move.w  ($20,A3),D0
            bsr.w   AltSetRsrved
.L2:
            rts
sub_408250B2:
            movea.l ExpandMem,A1
            movea.l ($F0,A1),A1
            jmp     (A1)
xSetKeyboard2Font:
            move.l  A0,-(SP)
            movea.l ExpandMem,A1
            cmpi.b  #1,($2C,A1)
            beq.b   .L1
            subq.w  #2,SP
            move.l  #$82000000,-(SP)
            _ScriptUtil
            move.l  #$80020004,-(SP)
            _ScriptUtil
.L1:
            movea.l (SP)+,A0
            rts
FindLineHite:
            move.l  A2,-(SP)
            lea     ($60,A3),A2
            move.w  D3,D0
            bsr.w   GetLine
            bsr.w   PtrToLine
            bsr.w   GetHite
            movea.l (SP)+,A2
            rts
TESetJust:
            bsr.w   StdEntry_StyledTextEdit
            move.w  (A2),($3A,A3)
            bra.w   TEKey.L14
Refresh:
            moveq   #0,D3
            moveq   #-1,D4
            bsr.w   PinA0Rect
            moveq   #-1,D7
            bsr.w   DoText
            bsr.w   HiLite
            tst.b   ($38,A3)
            beq.b   Scroll.L1
            bra.w   sub_408246A8.L1
TEScroll:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   HideCaret
            move.l  (A2)+,D3
            bsr.b   Scroll
.L1:
            moveq   #8,D0
            bra.w   TECalText.L2
Scroll:
            tst.l   D3
            beq.b   ActCaret
            pea     (A3)
            move.l  D3,-(SP)
            _OffsetRect
            subq.w  #4,SP
            _NewRgn
            movea.l (SP)+,A2
            pea     (8,A3)
            move.l  D3,-(SP)
            move.l  A2,-(SP)
            _ScrollRect
            bsr.b   ActCaret
            move.l  A2,-(SP)
            _SetClip
            movea.l (A2),A0
            lea     (2,A0),A0
            bsr.b   Refresh
            move.l  A2,-(SP)
            _DisposRgn
.L1:
            rts
ActCaret:
            tst.b   ($24,A3)
            beq.b   .L1
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.b   .L1
            st      ($39,A3)
.L1:
            rts
TEPinScroll:
            bsr.w   StdEntry_StyledTextEdit
            bsr.w   HideCaret
            move.w  (A2),D0
            bpl.b   .L2
            move.w  ($5E,A3),D1
            move.w  ($3C,A3),D0
            tst.w   D0
            beq.b   .L1
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            cmpi.b  #$D,(-1,A0,D0.w)
            bne.b   .L1
            addq.w  #1,D1
.L1:
            moveq   #0,D0
            bsr.w   GetLineHites
            move.w  D0,D1
            move.w  (A2),D0
            add.w   (A3),D1
            sub.w   ($C,A3),D1
            ble.b   .L3
            add.w   D1,D0
            bpl.b   .L4
            bra.b   .L3
.L2:
            move.w  (A3),D1
            sub.w   (8,A3),D1
            bpl.b   .L3
            add.w   D1,D0
            bmi.b   .L4
.L3:
            sub.w   D0,(A2)
.L4:
            move.w  (2,A2),D0
            bpl.b   .L5
            move.w  (6,A3),D1
            sub.w   ($E,A3),D1
            ble.b   .L6
            add.w   D1,D0
            bpl.b   .L7
            sub.w   D0,(2,A2)
            bra.b   .L7
.L5:
            move.w  (2,A3),D1
            sub.w   ($A,A3),D1
            bpl.b   .L6
            add.w   D1,D0
            bmi.b   .L7
.L6:
            sub.w   D0,(2,A2)
.L7:
            move.l  (A2)+,D3
            bsr.w   Scroll
            bsr.w   ActCaret
            bra.w   TEScroll.L1
TESelView:
            bsr.w   StdEntry_StyledTextEdit
            bsr.b   SelView
            bra.w   TECalText.L1
SelView:
            movea.l ($42,A3),A0
            movea.l (A0),A0
            move.l  ($10,A0),D0
            btst    #0,D0
            beq.b   .L3
            bsr.w   SelSort
            move.w  ($20,A3),D3
            move.w  D3,D4
            moveq   #-2,D7
            bsr.w   DoText
            movea.l ExpandMem,A0
            cmpi.w  #$FFFF,($2E,A0)
            bne.b   .L1
            lea     ($30,A0),A0
            move.l  (A0),D7
            bra.b   .L2
.L1:
            move.l  ($10,A3),D7
.L2:
            lea     OneOne,A2
            lea     ($10,A3),A0
            move.l  -(A0),-(A2)
            move.l  -(A0),-(A2)
            move.w  ($20,A3),D3
            bsr.w   FindLineHite
            sub.w   D1,(4,A2)
            subq.w  #1,(6,A2)
            subq.w  #2,SP
            move.l  D7,-(SP)
            move.l  A2,-(SP)
            _PtInRect
            tst.b   (SP)+
            bne.b   .L3
            move.l  (A2)+,-(SP)
            move.l  (A2),-(SP)
            move.l  -(A2),-(SP)
            pea     (4,SP)
            _SubPt
            pea     (4,SP)
            _AddPt
            move.l  D7,-(SP)
            pea     (4,SP)
            _SubPt
            move.l  A4,-(SP)
            _TEPinScroll
.L3:
            rts
TEAutoView:
            bsr.w   StdEntry_StyledTextEdit
            movea.l ($42,A3),A0
            movea.l (A0),A0
            move.l  ($10,A0),D0
            tst.b   (A2)+
            beq.b   .L1
            bset    #0,D0
            bra.b   .L2
.L1:
            bclr    #0,D0
.L2:
            move.l  D0,($10,A0)
            bra.w   TEKey.L14
iTEFeatureFlag:
            moveq   #0,D0
            moveq   #0,D1
            move.w  (A2)+,D0
            move.w  (A2)+,D1
            movea.l ($42,A3),A0
            movea.l (A0),A0
            btst    D1,($10,A0)
            sne     (A2)
            tst.w   D0
            blt.b   .L2
            beq.b   .L1
            bset    D1,($10,A0)
            bra.b   .L2
.L1:
            bclr    D1,($10,A0)
.L2:
            moveq   #$A,D0
            bra.w   TECalText.L3
DefClikProc:
            movem.l D0-D7/A0-A4,-(SP)
            movea.l ($42,A3),A0
            movea.l (A0),A0
            move.l  ($10,A0),D0
            btst    #0,D0
            beq.b   .L3
            lea     ($10,A3),A0
            lea     OneOne,A2
            move.l  -(A0),-(A2)
            move.l  -(A0),-(A2)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.w  (SP)+,D6
            move.w  (SP)+,D7
            moveq   #0,D4
            move.w  ($18,A3),D1
            bpl.b   .L2
            move.w  D6,D0
            cmp.w   (4,A3),D0
            ble.b   .L1
            move.w  (4,A3),D0
.L1:
            bsr.w   PtToLine
            bge.b   .L3
            bsr.w   GetHite
.L2:
            cmp.w   (A2)+,D6
            blt.b   .L5
            cmp.w   (A2)+,D7
            blt.b   .L7
            cmp.w   (A2)+,D6
            bgt.b   .L4
            cmp.w   (A2)+,D7
            bgt.b   .L6
.L3:
            moveq   #1,D0
            movem.l (SP)+,D0-D7/A0-A4
            rts
.L4:
            neg.w   D1
.L5:
            bra.b   .L8
.L6:
            neg.w   D1
.L7:
            exg     D4,D1
.L8:
            move.w  D4,-(SP)
            move.w  D1,-(SP)
            move.l  (8,A6),-(SP)
            _TEPinScroll
            bra.b   .L3
GetCurStyle:
            movem.l D1-D4,-(SP)
            addq.w  #1,D0
            move.w  D0,D2
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            move.w  (A0),D1
            lea     ($14,A0),A0
            moveq   #0,D0
.L1:
            cmp.w   D0,D1
            beq.b   .L4
            move.w  D1,D3
            add.w   D0,D3
            lsr.w   #1,D3
            moveq   #0,D4
            move.w  D3,D4
            lsl.l   #2,D4
            cmp.w   (0,A0,D4.w),D2
            beq.b   .L3
            bls.b   .L2
            move.w  D3,D0
            addq.w  #1,D0
            bra.b   .L1
.L2:
            move.w  D3,D1
            bra.b   .L1
.L3:
            move.w  D3,D0
.L4:
            tst.w   D0
            beq.b   .L5
            subq.w  #1,D0
.L5:
            moveq   #0,D1
            move.w  D0,D1
            lsl.l   #2,D1
            adda.l  D1,A0
            movem.l (SP)+,D1-D4
            rts
GetNumStyles:
            move.l  A0,-(SP)
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            moveq   #0,D0
            move.w  (A1),D0
            lea     ($14,A1),A1
            lsl.l   #2,D0
            adda.l  D0,A1
            moveq   #0,D0
.L1:
            addq.l  #4,A0
            addq.w  #1,D0
            cmpa.l  A0,A1
            beq.b   .L2
            cmp.w   (A0),D1
            bhi.b   .L1
.L2:
            movea.l (SP)+,A0
            rts
GetStyle:
            mulu.w  #$12,D0
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            adda.l  D0,A0
            rts
RecalStStarts:
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            move.w  (A1),D1
            sub.w   D0,D1
            bls.b   .L2
.L1:
            addq.l  #4,A0
            add.w   D5,(A0)
            subq.w  #1,D1
            bne.b   .L1
.L2:
            rts
sub_408253E8:
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.w   AltSetRsrved.L12
AltSetRsrved:
            movea.l ($4A,A3),A1
            movea.l (A1),A1
            movea.l ($10,A1),A1
            movea.l (A1),A1
            movea.l (4,A1),A1
            move.l  A1,-(SP)
            movea.l (A1),A1
            tst.w   (A1)
            beq.b   .L1
            lea     (2,A1),A1
            bra.b   .L2
.L1:
            subq.w  #1,D0
            bsr.w   GetCurStyle
            move.w  (2,A0),D0
            bsr.b   GetStyle
            move.w  #1,(A1)
            lea     (2,A1),A1
            clr.l   (A1)
            lea     (6,A0),A0
            move.l  (A0)+,(8,A1)
            move.l  (A0)+,($C,A1)
            move.l  (A0)+,($10,A1)
.L2:
            move.w  (6,A2),D2
            movea.l (2,A2),A0
            btst    #0,D2
            beq.b   .L3
            move.w  (A0),(8,A1)
            move.l  A0,-(SP)
            move.w  (A0),D1
            lea     ($B,A1),A0
            bsr.w   SetDirection
            movea.l (SP)+,A0
.L3:
            btst    #1,D2
            beq.b   .L6
            move.b  (2,A0),D0
            btst    #5,D2
            beq.b   .L4
            eor.b   D0,($A,A1)
            bra.b   .L6
.L4:
            tst.b   D0
            bne.b   .L5
            clr.b   ($A,A1)
.L5:
            or.b    D0,($A,A1)
.L6:
            btst    #2,D2
            beq.b   .L7
            btst    #4,D2
            bne.b   .L7
            move.w  (4,A0),($C,A1)
.L7:
            btst    #3,D2
            beq.b   .L8
            move.l  (6,A0),($E,A1)
            move.w  ($A,A0),($12,A1)
.L8:
            btst    #4,D2
            beq.b   .L11
            move.w  ($C,A1),D0
            bne.b   .L9
            move.b  FMDefaultSize,D0
.L9:
            add.w   (4,A0),D0
            bgt.b   .L10
            move.w  #1,D0
.L10:
            move.w  D0,($C,A1)
.L11:
            movea.l ($52,A3),A0
            move.w  (8,A1),($44,A0)
            move.w  ($A,A1),($46,A0)
            bclr    #7,($47,A0)
            move.w  ($C,A1),($4A,A0)
            bsr.w   GetSize
            movea.l (SP)+,A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.w  D0,(6,A0)
            move.w  D1,(4,A0)
.L12:
            rts
iTESetStyle:
            tst.w   ($50,A3)
            bpl.b   .L3
            bsr.w   sub_408253E8
            cmpi.w  #1,(6,A2)
            bne.b   .L1
            bsr.w   sub_408250B2
.L1:
            move.w  (A2)+,D0
            andi.w  #$FF00,D0
            bne.b   .L2
            bsr.b   SetGuts_TextEdit
            bra.b   .L3
.L2:
            move.l  A2,-(SP)
            bsr.w   HideCaret
            bsr.w   HiLite
            movea.l (SP)+,A2
            bsr.b   SetGuts_TextEdit
            moveq   #0,D7
            bsr.w   RecalDraw
            bsr.w   ShowCaret
            bsr.w   HiLite
            bsr.w   SelView
.L3:
            moveq   #$E,D0
            bra.w   TECalText.L3
SetGuts_TextEdit:
            movem.l D2-D7/A2/A4/A6,-(SP)
            movea.l (A2)+,A4
            move.w  (A2)+,D7
            suba.l  A6,A6
            andi.w  #$3F,D7
            move.w  D7,D0
            andi.w  #$22,D0
            cmpi.w  #$22,D0
            bne.b   .L1
            subq.w  #1,A6
            move.w  #2,-(SP)
            suba.w  #$E,SP
            pea     ($E,SP)
            pea     (6,SP)
            movea.l SP,A2
            bsr.w   sub_40825C4C
            lea     ($A,SP),SP
            move.b  (2,SP),D5
            swap    D5
            lea     ($E,SP),SP
.L1:
            bsr.b   StyleGuts
            movem.l (SP)+,D2-D7/A2/A4/A6
            rts
StyleGuts:
            movea.l ExpandMem,A0
            movea.l ($F4,A0),A0
            jmp     (A0)
            tst.w   D7
            beq.w   .L16
            bsr.w   SelSort
            move.w  D0,D1
            move.w  D0,D4
            swap    D0
            move.w  D0,D3
            sub.w   D3,D1
            beq.w   .L16
            suba.w  #$12,SP
            movea.l SP,A2
            bsr.w   GetCurStyle
            move.w  D4,D1
            bsr.w   GetNumStyles
            move.w  D0,D2
            swap    D3
            move.w  D4,D3
            move.b  (2,A4),D4
            swap    D4
            move.w  (A4),D4
            move.w  (4,A4),D5
            move.l  (6,A4),D6
            swap    D7
            move.w  ($A,A4),D7
            swap    D7
            movea.l A2,A4
            movea.l A0,A2
            movea.l ($4A,A3),A0
            _HLock
.L1:
            move.w  (2,A2),D0
            bsr.w   GetStyle
            bsr.w   CheckMatch
            tst.w   D0
            beq.w   .L15
            moveq   #$12,D0
            movea.l A4,A1
            _BlockMove
            movea.l A2,A0
            move.l  D3,D0
            swap    D0
            cmp.w   (A2),D0
            bls.b   .L2
            bsr.w   sub_408249B6
            addq.w  #4,A0
            movea.l A0,A2
.L2:
            cmpi.w  #1,D2
            bne.b   .L3
            addq.w  #4,A0
            cmp.w   (A0),D3
            beq.b   .L3
            move.w  D3,D0
            movea.l A2,A0
            bsr.w   sub_408249B6
            movea.l A0,A2
.L3:
            moveq   #1,D0
            movea.l A2,A0
            bsr.w   sub_40823DFE
            btst    #0,D7
            beq.b   .L4
            move.w  D4,(6,A4)
            move.l  A0,-(SP)
            move.w  D4,D1
            lea     (9,A4),A0
            bsr.w   SetDirection
            movea.l (SP)+,A0
.L4:
            btst    #1,D7
            beq.b   .L8
            move.l  D4,D0
            swap    D0
            move.l  A6,D1
            beq.b   .L6
            addq.l  #1,D1
            beq.b   .L5
            move.b  D0,(8,A4)
            bra.b   .L8
.L5:
            move.l  D5,D1
            swap    D1
            and.b   D0,D1
            eor.b   D1,D0
            or.b    D0,(8,A4)
            eor.b   D1,(8,A4)
            bra.b   .L8
.L6:
            tst.b   D0
            bne.b   .L7
            clr.b   (8,A4)
.L7:
            or.b    D0,(8,A4)
.L8:
            btst    #2,D7
            beq.b   .L9
            btst    #4,D7
            bne.b   .L9
            move.w  D5,($A,A4)
.L9:
            btst    #3,D7
            beq.b   .L10
            move.l  D6,($C,A4)
            swap    D7
            move.w  D7,($10,A4)
            swap    D7
.L10:
            btst    #4,D7
            beq.b   .L13
            move.w  ($A,A4),D0
            bne.b   .L11
            move.b  FMDefaultSize,D0
            move.w  D0,($A,A4)
.L11:
            add.w   D5,D0
            bgt.b   .L12
            move.w  #1,D0
.L12:
            move.w  D0,($A,A4)
.L13:
            movea.l A4,A0
            bsr.w   FindStyle
            tst.l   D0
            bne.b   .L14
            movea.l A4,A0
            bsr.b   SetHiteAscent
            move.w  #1,(A0)
            bsr.w   AddStyle
.L14:
            move.w  D0,(2,A2)
.L15:
            addq.w  #4,A2
            subq.w  #1,D2
            bne.w   .L1
            movea.l ($4A,A3),A0
            _HUnlock
            bsr.w   ConcatStyles
            adda.w  #$12,SP
.L16:
            rts
SetHiteAscent:
            move.l  D2,-(SP)
            movea.l ($52,A3),A1
            move.w  (6,A0),($44,A1)
            move.w  (8,A0),($46,A1)
            bclr    #7,($47,A1)
            move.w  ($A,A0),($4A,A1)
            bsr.w   GetSize
            move.w  D0,(4,A0)
            move.w  D1,(2,A0)
            move.l  (SP)+,D2
            rts
AnyNullStyle:
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            movea.l (A0),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            rts
sub_40825726:
            cmp.w   ($20,A3),D0
            bne.b   GetOneStyle
            cmp.w   ($22,A3),D0
            bne.b   GetOneStyle
            bsr.b   AnyNullStyle
            beq.b   GetOneStyle
            lea     (4,A0),A0
            rts
GetOneStyle:
            bsr.w   GetCurStyle
            move.w  (2,A0),D0
            bsr.w   GetStyle
            rts
            tst.w   ($50,A3)
            bpl.b   .L1
            move.l  (A2)+,-(SP)
            move.l  (A2)+,-(SP)
            move.l  (A2)+,-(SP)
            move.w  (A2),D0
            bsr.b   GetOneStyle
            movea.l (SP)+,A1
            move.w  (6,A0),(A1)+
            move.w  (8,A0),(A1)+
            clr.b   (-1,A1)
            move.w  ($A,A0),(A1)+
            movea.l A0,A2
            lea     ($C,A0),A0
            move.w  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            move.w  (A0),(A1)
            movea.l (SP)+,A1
            move.w  (2,A2),(A1)
            movea.l (SP)+,A1
            move.w  (4,A2),(A1)
            bra.b   .L2
.L1:
            bsr.w   GetSize
            movea.l (A2)+,A0
            move.w  D0,(A0)
            movea.l (A2)+,A0
            move.w  D1,(A0)
            movea.l (A2),A0
            movea.l ($52,A3),A1
            move.w  ($44,A1),(A0)+
            move.w  ($46,A1),(A0)+
            move.w  ($4A,A1),(A0)+
            pea     (A0)
            _GetForeColor
.L2:
            moveq   #$14,D0
            bra.w   TECalText.L3
SetStyle:
            move.l  A0,-(SP)
            move.w  (2,A0),D0
            bsr.w   GetStyle
            movea.l ($52,A3),A1
            move.w  (6,A0),($44,A1)
            move.w  (8,A0),($46,A1)
            bclr    #7,($47,A1)
            move.w  ($A,A0),($4A,A1)
            movea.l ($4A,A3),A1
            move.l  (A1),D0
            sub.l   D0,(SP)
            move.w  D2,-(SP)
            pea     ($C,A0)
            _RGBForeColor
            move.w  (SP)+,D2
            movea.l ($4A,A3),A1
            move.l  (A1),D0
            add.l   D0,(SP)
            movea.l (SP)+,A0
            rts
ConcatStyles:
            movem.l D2-D3/A2,-(SP)
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (4,A0),A2
            movea.l (A2),A2
            move.w  (A0),D0
            addq.w  #1,D0
            lea     ($14,A0),A0
            movea.l A0,A1
            moveq   #0,D2
            move.w  (2,A0),D1
.L1:
            subq.w  #1,D0
            beq.b   .L3
            addq.w  #1,D2
            addq.l  #4,A1
            cmp.w   (2,A1),D1
            beq.b   .L1
            subq.w  #1,D2
            beq.b   .L2
            mulu.w  #$12,D1
            sub.w   D2,(0,A2,D1.l)
            moveq   #0,D2
.L2:
            addq.l  #4,A0
            move.l  (A1),(A0)
            move.w  (2,A0),D1
            bra.b   .L1
.L3:
            suba.l  A0,A1
            move.l  A1,D0
            movea.l ($4A,A3),A0
            movea.l (A0),A1
            asr.l   #2,D0
            sub.w   D0,(A1)
            movem.l (SP)+,D2-D3/A2
            rts
sub_4082584C:
            movea.l ExpandMem,A0
            movea.l ($F8,A0),A0
            jmp     (A0)
            tst.w   ($50,A3)
            bpl.b   .L2
            move.l  A2,-(SP)
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            movea.l (4,A0),A2
            movea.l (A2),A2
            move.w  (A0),D0
            beq.b   .L1
            subq.w  #1,D0
            beq.b   .L1
            lsl.w   #2,D0
            lea     ($14,A0,D0.w),A0
            move.w  ($3C,A3),D0
            cmp.w   (A0),D0
            bgt.b   .L1
            moveq   #0,D1
            move.w  (2,A0),D1
            mulu.w  #$12,D1
            subq.w  #1,(0,A2,D1.l)
            addq.w  #1,D0
            move.w  D0,(A0)
            move.w  #$FFFF,(2,A0)
            movea.l ($4A,A3),A0
            movea.l (A0),A0
            subq.w  #1,(A0)
.L1:
            movea.l (SP)+,A2
.L2:
            rts
CheckMatch:
            moveq   #1,D0
            cmpa.w  #0,A6
            beq.b   .L5
            cmpa.w  #$FFFF,A6
            beq.b   .L5
            btst    #0,D7
            beq.b   .L1
            move.w  (A6),D1
            cmp.w   (6,A0),D1
            bne.b   .L4
.L1:
            btst    #1,D7
            beq.b   .L2
            move.b  (2,A6),D1
            cmp.b   (8,A0),D1
            bne.b   .L4
.L2:
            btst    #2,D7
            beq.b   .L3
            move.w  (4,A6),D1
            cmp.w   ($A,A0),D1
            bne.b   .L4
.L3:
            btst    #3,D7
            beq.b   .L5
            move.l  (6,A6),D1
            cmp.l   ($C,A0),D1
            bne.b   .L4
            move.w  ($A,A6),D1
            cmp.w   ($10,A0),D1
            beq.b   .L5
.L4:
            moveq   #0,D0
.L5:
            rts
            tst.w   ($50,A3)
            bpl.b   .L7
            move.w  (A2)+,D0
            andi.w  #$FF00,D0
            bne.b   .L6
            bsr.b   ReplaceGuts
            bra.b   .L7
.L6:
            move.l  A2,-(SP)
            bsr.w   HideCaret
            bsr.w   HiLite
            movea.l (SP)+,A2
            bsr.b   ReplaceGuts
            moveq   #0,D7
            bsr.w   RecalDraw
            bsr.w   ShowCaret
            bsr.w   HiLite
            bsr.w   SelView
.L7:
            moveq   #$12,D0
            bra.w   TECalText.L3
ReplaceGuts:
            movem.l D2-D7/A2/A4/A6,-(SP)
            movea.l (A2)+,A4
            movea.l (A2)+,A6
            move.w  (A2)+,D7
            andi.w  #$1F,D7
            bsr.w   StyleGuts
            movem.l (SP)+,D2-D7/A2/A4/A6
            rts
TEGetOffset:
            bsr.w   StdEntry_StyledTextEdit
            move.l  ($1C,A3),-(SP)
            move.l  (A2)+,($1C,A3)
            bsr.w   DOFIND
            move.w  D6,(A2)
            move.l  (SP)+,($1C,A3)
            bra.w   TEScroll.L1
            clr.l   (A2)
            tst.w   ($50,A3)
            bpl.b   .L1
            move.l  ($4A,A3),(A2)
.L1:
            moveq   #6,D0
            bra.w   TECalText.L3
            tst.w   ($50,A3)
            bpl.b   .L2
            movea.l ($4A,A3),A0
            _DisposHandle
            move.l  (A2),($4A,A3)
.L2:
            moveq   #$A,D0
            bra.w   TECalText.L3
            move.w  (A2)+,D0
            move.l  A2,-(SP)
            move.w  D0,-(SP)
            cmp.w   ($3C,A3),D0
            bcs.b   .L3
            move.w  ($3C,A3),D0
            move.w  D0,(SP)
            subq.w  #1,D0
.L3:
            lea     ($60,A3),A2
            bsr.w   GetLine
            move.w  (-4,A6),-(SP)
            bsr.w   LINERECT
            move.w  (SP)+,(-4,A6)
            move.w  (A2),D6
            move.w  (SP)+,D7
            cmp.w   ($3C,A3),D7
            bne.b   .L5
            movea.l ($3E,A3),A0
            movea.l (A0),A0
            cmpi.b  #$D,(-1,A0,D7.w)
            bne.b   .L5
            move.w  ($12,A3),D0
            move.w  ($3A,A3),D1
            bne.b   .L4
            move.w  TESysJust,D1
            beq.b   .L6
            cmpi.w  #$FFFE,D1
            beq.b   .L6
.L4:
            move.w  (6,A3),D0
            subq.w  #1,D0
            tst.w   D1
            bmi.b   .L6
            sub.w   (2,A3),D0
            asr.w   #1,D0
            add.w   (2,A3),D0
            bra.b   .L6
.L5:
            bsr.w   MeasureIt
            add.w   ($12,A3),D0
.L6:
            movea.l (SP)+,A2
            move.w  ($14,A3),(A2)+
            move.w  D0,(A2)
            moveq   #8,D0
            bra.w   TECalText.L3
            clr.l   (A2)
            tst.w   ($50,A3)
            bpl.b   sub_40825A4C.L1
            move.w  ($20,A3),D0
            move.w  ($22,A3),D1
            cmp.w   D0,D1
            bne.b   .L7
            moveq   #$16,D0
            bsr.w   MyNewHandle
            move.l  A0,(A2)
            movea.l (A0),A1
            move.w  #1,(A1)+
            clr.l   (A1)+
            move.w  ($20,A3),D0
            bsr.w   sub_40825726
            lea     (2,A0),A0
            moveq   #$10,D0
            _BlockMove
            bra.b   sub_40825A4C.L1
.L7:
            bcc.b   sub_40825A4C
            exg     D0,D1
sub_40825A4C:
            movem.l D2-D5/A2/A5,-(SP)
            bsr.w   CopyGuts
            movem.l (SP)+,D2-D5/A2/A5
            move.l  A4,(A2)
.L1:
            moveq   #6,D0
            bra.w   TECalText.L3
            tst.w   ($50,A3)
            bpl.w   .L12
            move.w  (A2)+,D5
            andi.w  #$FF00,D5
            sne     D5
            beq.b   .L2
            bsr.w   HideCaret
            bsr.w   HiLite
.L2:
            movea.l (A2)+,A1
            move.l  A1,-(SP)
            movea.l A1,A0
            _HGetState
            move.b  D0,-(SP)
            movea.l A1,A0
            _HLock
            movea.l (A1),A1
            move.l  (A2)+,D7
            move.l  (A2),D6
            cmp.l   D6,D7
            bcc.b   .L3
            exg     D6,D7
.L3:
            moveq   #0,D0
            move.w  ($3C,A3),D0
            cmp.l   D0,D6
            bls.b   .L4
            move.l  D0,D6
.L4:
            cmp.l   D0,D7
            bls.b   .L5
            move.l  D0,D7
.L5:
            move.l  D6,D3
            move.l  ($20,A3),-(SP)
            move.w  (A1)+,D4
            bra.b   .L10
.L6:
            cmp.l   D3,D7
            bls.b   .L11
            move.w  D3,($20,A3)
            tst.w   D4
            bne.b   .L7
            move.l  D7,D0
            bra.b   .L8
.L7:
            move.l  D6,D0
            add.l   ($14,A1),D0
            cmp.l   D7,D0
            bls.b   .L9
.L8:
            move.l  D7,D0
.L9:
            move.w  D0,($22,A3)
            move.l  D0,D3
            movem.l D3-D7/A1/A4/A6,-(SP)
            move.w  ($20,A3),D0
            bsr.w   GetOneStyle
            lea     (6,A0),A6
            lea     (8,A1),A4
            move.w  #$F,D7
            bsr.w   StyleGuts
            movem.l (SP)+,D3-D7/A1/A4/A6
            lea     ($14,A1),A1
.L10:
            dbra    D4,.L6
.L11:
            move.l  (SP)+,($20,A3)
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            _HSetState
            tst.b   D5
            beq.b   .L12
            moveq   #0,D7
            bsr.w   RecalDraw
            bsr.w   ShowCaret
            bsr.w   HiLite
            bsr.w   SelView
.L12:
            moveq   #$14,D0
            bra.w   TECalText.L3
            bsr.w   HideCaret
            bsr.w   HiLite
            move.l  (A2)+,D0
            moveq   #0,D7
            movem.l (A2)+,D5-D6
            tst.l   D5
            beq.b   .L15
            tst.l   D0
            beq.b   .L13
            movea.l D0,A2
            tst.w   ($50,A3)
            bpl.b   .L13
            bsr.w   MungeSetup
            clr.l   -(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            _Munger
            addq.l  #4,SP
            add.w   D5,($3C,A3)
            movea.l ($3E,A3),A0
            _HLock
            movea.l A2,A0
            _HGetState
            move.b  D0,-(SP)
            _HLock
            movem.l D2-D6/A2/A4,-(SP)
            movea.l A2,A4
            moveq   #0,D3
            move.w  ($20,A3),D3
            bsr.w   PstStylGuts
            movem.l (SP)+,D2-D6/A2/A4
            move.b  (SP)+,D0
            movea.l A2,A0
            _HSetState
            bsr.w   sub_4082584C
            sub.w   D5,D7
            bra.b   .L14
.L13:
            bsr.w   InsGuts
.L14:
            bsr.w   RecalDraw
            add.w   D5,($20,A3)
            add.w   D5,($22,A3)
.L15:
            bsr.w   ShowCaret
            bsr.w   HiLite
            moveq   #$12,D0
            bra.w   TECalText.L3
            movem.l (A2)+,D0-D1
            cmp.l   D0,D1
            bcc.b   .L16
            exg     D0,D1
.L16:
            tst.l   D0
            bne.b   .L17
            moveq   #1,D0
.L17:
            subq.l  #1,D0
            tst.l   D1
            bne.b   .L18
            moveq   #1,D1
.L18:
            moveq   #0,D2
            move.w  ($5E,A3),D2
            bne.b   .L19
            moveq   #1,D2
.L19:
            cmp.l   D2,D0
            bls.b   .L20
            move.l  D2,D0
.L20:
            cmp.l   D2,D1
            bls.b   .L21
            move.l  D2,D1
.L21:
            bsr.w   GetLineHites
            move.l  D0,(A2)
            moveq   #$E,D0
            bra.w   TECalText.L3
            movea.l (A2)+,A1
            move.w  (A2),D0
            lsl.w   #2,D0
            movea.l ($42,A3),A0
            movea.l (A0),A0
            adda.w  D0,A0
            move.l  (A0),D0
            move.l  (A1),(A0)
            move.l  D0,(A1)
            moveq   #$C,D0
            bra.w   TECalText.L3
            move.l  (A2)+,D1
            move.l  (A2)+,D0
            cmp.l   D0,D1
            bhi.b   .L22
            beq.b   .L23
            exg     D0,D1
.L22:
            tst.w   ($50,A3)
            bmi.b   .L24
.L23:
            moveq   #1,D0
            bra.b   .L26
.L24:
            moveq   #0,D2
            move.w  ($22,A3),D2
            cmp.l   D2,D1
            bls.b   .L25
            move.l  D2,D1
.L25:
            bsr.w   GetCurStyle
            bsr.w   GetNumStyles
.L26:
            move.l  D0,(A2)
            moveq   #$E,D0
            bra.w   TECalText.L3
            tst.w   ($50,A3)
            bmi.b   .L27
            movea.l (A2),A0
            movea.l ($52,A3),A1
            move.l  ($44,A1),(A0)+
            move.w  ($4A,A1),(A0)+
            pea     (A0)
            _GetForeColor
            st      (8,A2)
            bra.b   .L28
.L27:
            bsr.b   sub_40825C4C
.L28:
            moveq   #$E,D0
            bra.w   TECalText.L3
sub_40825C4C:
            movem.l D3-D7/A4,-(SP)
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            seq     D5
            bne.b   .L1
            bsr.w   AnyNullStyle
            bne.b   .L1
            tst.w   D0
            beq.b   .L1
            subq.w  #1,D0
.L1:
            bsr.w   sub_40825726
            movea.l (A2),A1
            move.l  (6,A0),(A1)
            move.l  ($A,A0),(4,A1)
            move.l  ($E,A0),(8,A1)
            move.b  (8,A0),D7
            move.b  D7,D6
            movea.l (4,A2),A0
            move.w  (A0),D0
            andi.w  #$F,D0
            move.w  D0,D4
            move.w  D0,D3
            tst.b   D5
            bne.w   .L11
            move.w  ($20,A3),D0
            bsr.w   GetCurStyle
            movea.l A0,A4
.L2:
            addq.w  #4,A4
            tst.w   D4
            beq.b   .L8
            move.w  (A4),D0
            bmi.b   .L8
            cmp.w   ($22,A3),D0
            bcc.b   .L8
            move.w  (2,A4),D0
            bsr.w   GetStyle
            btst    #0,D4
            beq.b   .L3
            move.w  (A1),D0
            cmp.w   (6,A0),D0
            beq.b   .L3
            bclr    #0,D4
.L3:
            btst    #2,D4
            beq.b   .L4
            move.w  (4,A1),D0
            cmp.w   ($A,A0),D0
            beq.b   .L4
            bclr    #2,D4
.L4:
            btst    #3,D4
            beq.b   .L6
            move.l  (6,A1),D0
            cmp.l   ($C,A0),D0
            bne.b   .L5
            move.w  ($A,A1),D0
            cmp.w   ($10,A0),D0
            beq.b   .L6
.L5:
            bclr    #3,D4
.L6:
            btst    #1,D4
            beq.b   .L2
            tst.b   D7
            bne.b   .L7
            or.b    (8,A0),D6
            bra.b   .L2
.L7:
            and.b   (8,A0),D6
            bra.b   .L2
.L8:
            btst    #1,D4
            beq.b   .L12
            tst.b   D7
            bne.b   .L10
            tst.b   D6
            beq.b   .L11
.L9:
            bclr    #1,D4
            bra.b   .L12
.L10:
            tst.b   D6
            beq.b   .L9
.L11:
            move.b  D6,(2,A1)
.L12:
            movea.l (4,A2),A0
            move.w  D4,(A0)
            cmp.w   D4,D3
            seq     D0
            neg.b   D0
            move.b  D0,(8,A2)
            movem.l (SP)+,D3-D7/A4
            rts
            ds.b    10

            EVEN
