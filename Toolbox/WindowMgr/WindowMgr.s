            include "Include/ROMHeader.s"

            EXPORT  BeginUpdate,BringToFront,CalcVis,CALCVISBEHIND,CheckUpdate,ClipAbove
            EXPORT  CloseWindow,DeltaPoint,DisposeWindow,DragGrayRgn,DragTheRgn,DragWindow
            EXPORT  DrawGrowIcon,DrawNew,EndUpdate,FindWindow,FrontWindow,GetAuxCtl
            EXPORT  GetAuxWin,GetCWMgrPort,GetWindowPic,GetWMgrPort,GetWRefCon,GetWTitle
            EXPORT  GetWVariant,GrowWindow,HideWindow,HiliteWindow,InitWindows,INITWINDOWSCRTRETURN
            EXPORT  INITWINDOWSLCDRETURN,INITWINDOWSRGNRETURN,InvalRect,InvalRgn,MoveWindow,NewCWindow
            EXPORT  NewString,NewWindow,PaintBehind,PaintOne,SaveOld,SelectWindow
            EXPORT  SendBehind,SetCtlColor,SetDeskCPat,SetString,SetWinColor,SetWindowPic
            EXPORT  SetWRefCon,SetWTitle,ShowHide,ShowWindow,SizeWindow,TrackBox
            EXPORT  TrackGoAway,ValidRect,ValidRgn,ZoomWindow,GetNewRgn

            IMPORT  INITWINDOWSRGNPATCH,WINDOWMGRPATCH,CalcMBHeight,CallMBarProc,DrawMBar,FIXSMGRWORLD
            IMPORT  A

            SECTION "WindowMgr",CODE

WMGR:
            addq.w  #2,A0
            tst.w   (4,A0)
            bpl.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
SetUpColor_WindowMgr:
            movem.l D1/D3,-(SP)
            move.w  D0,D3
            subq.w  #4,SP
            clr.b   -(SP)
            move.l  A0,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D3
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            movem.l (SP)+,D1/D3
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
NewString:
            bsr.b   sub_4081823C
            _PtrToHand
            move.l  A0,(8,SP)
            move.l  (SP)+,(SP)
            rts
sub_4081823C:
            movea.l (8,SP),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.w  #1,D0
            rts
SetString:
            movea.l (8,SP),A1
            bsr.b   sub_4081823C
            _PtrToXHand
            bra.b   InsertWindow.L3
PrevWindow:
            move.l  D0,-(SP)
            movea.l WindowList,A1
            suba.l  A0,A0
.L1:
            cmpa.l  (SP),A1
            beq.b   .L2
            movea.l A1,A0
            movea.l ($90,A0),A1
            move.l  A1,D0
            bne.b   .L1
.L2:
            move.l  (SP)+,D0
            rts
InsertWindow:
            move.l  (8,SP),D1
            movea.l D1,A1
            clr.l   ($90,A1)
            tst.l   WindowList
            bne.b   .L1
            move.l  D1,WindowList
            bra.b   .L3
.L1:
            move.l  (4,SP),D0
            beq.b   .L2
            movea.l D0,A0
            move.l  ($90,A0),($90,A1)
            move.l  A1,($90,A0)
            bra.b   .L3
.L2:
            moveq   #0,D0
            bsr.b   PrevWindow
            move.l  D1,($90,A0)
.L3:
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
DeleteWindow:
            move.l  (4,SP),D0
            bsr.b   PrevWindow
            move.l  A0,D1
            bne.b   .L1
            lea     ChooserBits,A0
.L1:
            movea.l D0,A1
            move.l  ($90,A1),($90,A0)
            bra.b   CalcVis.L2
CalcVis:
            movem.l D4/A2-A3,-(SP)
            move.l  ($10,SP),D0
            beq.b   .L1
            movea.l D0,A2
            move.l  ($18,A2),D4
            tst.b   ($6E,A2)
            bne.b   .L4
            move.l  D4,-(SP)
            _SetEmptyRgn
.L1:
            movem.l (SP)+,D4/A2-A3
.L2:
            move.l  (SP)+,(SP)
.L3:
            rts
.L4:
            move.l  GrayRgn,-(SP)
            move.l  ($76,A2),-(SP)
            move.l  D4,-(SP)
            _SectRgn
            bsr.b   CVLoop
            move.l  D4,-(SP)
            movea.l A2,A0
            bsr.w   WMGR
            move.l  (6,A0),-(SP)
            _OffsetRgn
            bra.b   .L1
CVLoop:
            movea.l WindowList,A3
.L1:
            cmpa.l  A2,A3
            beq.b   CalcVis.L3
            tst.b   ($6E,A3)
            beq.b   .L2
            move.l  D4,-(SP)
            move.l  ($72,A3),-(SP)
            move.l  D4,-(SP)
            _DiffRgn
.L2:
            movea.l ($90,A3),A3
            bra.b   .L1
CALCVISBEHIND:
            move.l  A2,-(SP)
            move.l  ($C,SP),D0
            beq.b   .L3
            movea.l D0,A2
.L1:
            move.l  A2,-(SP)
            bsr.b   CalcVis
.L2:
            movea.l ($90,A2),A2
            move.l  A2,D0
            beq.b   .L3
            tst.b   ($6E,A2)
            beq.b   .L2
            subq.w  #2,SP
            movea.l ($76,A2),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($E,SP),A0
            movea.l (A0),A0
            pea     (2,A0)
            pea     ToolScratch
            _SectRect
            tst.b   (SP)+
            beq.b   .L2
            bra.b   .L1
.L3:
            movea.l (SP)+,A2
            bra.w   InsertWindow.L3
ClipAbove:
            movem.l D4/A2-A3,-(SP)
            movea.l WMgrPort,A0
            move.l  ($1C,A0),D4
            movea.l ($10,SP),A2
            move.l  D4,-(SP)
            move.l  GrayRgn,-(SP)
            move.l  D4,-(SP)
            _SectRgn
            bsr.b   CVLoop
            movem.l (SP)+,D4/A2-A3
            move.l  (SP)+,(SP)
            rts
PaintOne:
            movem.l D3-D4/A2-A3,-(SP)
            movea.l ($18,SP),A2
            bsr.w   sub_40818424
            move.l  A2,D0
            bne.b   .L2
            move.l  ($14,SP),-(SP)
            _SetClip
            bsr.w   sub_40818444
.L1:
            movem.l (SP)+,D3-D4/A2-A3
            bra.w   InsertWindow.L3
.L2:
            tst.b   ($6E,A2)
            beq.b   .L1
            move.l  ($14,SP),-(SP)
            move.l  ($72,A2),-(SP)
            move.l  D3,-(SP)
            _SectRgn
            bsr.w   TestClip
            move.l  A2,-(SP)
            bsr.b   ClipAbove
            bsr.b   TestClip
            movea.l A2,A3
            bsr.w   CallDWindow
            bsr.w   GetNewRgn
            movea.l (SP)+,A3
            move.l  ($76,A2),-(SP)
            move.l  D3,-(SP)
            move.l  A3,-(SP)
            _SectRgn
            tst.b   PaintWhite
            beq.b   .L4
            btst    #$F,(6,A2)
            beq.b   .L3
            move.l  ($D2C).w,-(SP)
            _SetPort
.L3:
            subq.w  #6,SP
            pea     (SP)
            _GetBackColor
            clr.w   D0
            movea.l A2,A0
            bsr.w   SetUpColor_WindowMgr
            _RGBBackColor
            move.l  A3,-(SP)
            _EraseRgn
            pea     (SP)
            _RGBBackColor
            addq.w  #6,SP
            move.l  WMgrPort,-(SP)
            _SetPort
.L4:
            tst.b   SaveUpdate
            beq.b   .L5
            move.l  ($7A,A2),-(SP)
            move.l  A3,-(SP)
            move.l  ($7A,A2),-(SP)
            _UnionRgn
.L5:
            move.l  A3,-(SP)
            _DisposRgn
            bra.w   .L1
sub_40818424:
            bsr.w   SetWPort
            movea.l WMgrPort,A3
            move.l  ($1C,A3),D3
            rts
TestClip:
            subq.w  #2,SP
            move.l  D3,-(SP)
            _EmptyRgn
            tst.b   (SP)+
            bne.b   .L1
            rts
.L1:
            addq.w  #4,SP
            bra.w   PaintOne.L1
sub_40818444:
            clr.l   -(SP)
            _ClipAbove
            move.l  DeskHook,D0
            beq.b   .L1
            movea.l D0,A0
            moveq   #0,D0
            jmp     (A0)
.L1:
            tst.b   SPMisc2
            bpl.b   .L2
            subq.w  #8,SP
            move.l  TheZone,(4,SP)
            pea     (SP)
            _GetPort
            move.l  ($D2C).w,-(SP)
            _SetPort
            move.l  GrayRgn,-(SP)
            move.l  ($CD8).w,-(SP)
            _FillCRgn
            _SetPort
            move.l  (SP)+,TheZone
            bra.b   .L3
.L2:
            move.l  GrayRgn,-(SP)
            pea     DeskPattern
            _FillRgn
.L3:
            rts
PaintBehind:
            movem.l D3-D4/A2-A3,-(SP)
            bsr.b   sub_40818424
            move.l  ($14,SP),-(SP)
            move.l  D3,-(SP)
            _CopyRgn
            bsr.b   GetNewRgn
            move.l  (SP)+,D4
            movea.l ($18,SP),A2
            move.l  A2,-(SP)
            _ClipAbove
            move.l  D3,-(SP)
            move.l  D4,-(SP)
            _CopyRgn
            bsr.b   sub_40818444
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            move.l  D4,-(SP)
            _DiffRgn
            pea     ($10,A3)
            _ClipRect
            move.l  D4,-(SP)
            _DisposRgn
.L1:
            move.l  A2,D0
            beq.b   .L3
            tst.b   ($6E,A2)
            beq.b   .L2
            move.l  A2,-(SP)
            move.l  ($18,SP),-(SP)
            _PaintOne
.L2:
            movea.l ($90,A2),A2
            bra.b   .L1
.L3:
            st      PaintWhite
            movem.l (SP)+,D3-D4/A2-A3
            bra.w   InsertWindow.L3
GetNewRgn:
            subq.w  #4,SP
            _NewRgn
            movea.l (4,SP),A0
            move.l  (SP)+,(SP)
            jmp     (A0)
SaveOld:
            movem.l D3-D4/A2,-(SP)
            bsr.b   GetNewRgn
            move.l  (SP)+,D3
            bsr.b   GetNewRgn
            move.l  (SP)+,D4
            movea.l ($10,SP),A2
            move.l  ($72,A2),-(SP)
            move.l  D3,-(SP)
            _CopyRgn
            move.l  ($76,A2),-(SP)
            move.l  D4,-(SP)
            _CopyRgn
            movem.l D3-D4,OldStructure
            movem.l (SP)+,D3-D4/A2
            move.l  (SP)+,(SP)
            rts
DrawNew:
            movem.l D3-D4/A2,-(SP)
            movea.l ($12,SP),A2
            movem.l OldStructure,D3-D4
            tst.b   ($6E,A2)
            beq.b   .L1
            move.l  ($72,A2),-(SP)
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            _XOrRgn
            move.l  ($76,A2),-(SP)
            move.l  D4,-(SP)
            move.l  D4,-(SP)
            _XOrRgn
.L1:
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            _UnionRgn
            move.b  ($10,SP),SaveUpdate
            move.l  A2,-(SP)
            move.l  D3,-(SP)
            _PaintOne
            st      SaveUpdate
            move.l  ($90,A2),-(SP)
            move.l  D3,-(SP)
            _PaintBehind
            move.l  A2,-(SP)
            move.l  D3,-(SP)
            _CalcVBehind
            move.l  D3,-(SP)
            _DisposRgn
            move.l  D4,-(SP)
            _DisposRgn
            movem.l (SP)+,D3-D4/A2
.L2:
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
ShowHide:
            movem.l D3-D4/A1/A3,-(SP)
            movea.l ($16,SP),A3
            move.b  ($14,SP),D3
            move.b  ($6E,A3),D0
            eor.b   D3,D0
            lsr.w   #1,D0
            bcc.b   .L1
            bsr.b   SetWPort
            move.l  A3,-(SP)
            _SaveOld
            move.b  D3,($6E,A3)
            bsr.w   CallWCalc
            move.l  A3,-(SP)
            st      -(SP)
            _DrawNew
            bsr.b   RestorePort
            tst.b   ($6E,A3)
            beq.b   .L1
            move.l  A3,-(SP)
            _ActivatePalette
.L1:
            movem.l (SP)+,D3-D4/A1/A3
            bra.b   DrawNew.L2
SetWPort:
            movea.l (A5),A0
            move.l  (A0),D4
            move.l  WMgrPort,(A0)
            rts
RestorePort:
            move.l  D4,-(SP)
            _SetPort
            rts
GetWMgrPort:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.l  WMgrPort,(A0)
            jmp     (A1)
GetCWMgrPort:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.l  ($D2C).w,(A0)
            jmp     (A1)
CheckUpdate:
            link.w  A6,#-8
            move.l  A3,-(SP)
            clr.w   ($C,A6)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            move.l  WindowList,D0
            beq.b   .L3
.L1:
            movea.l D0,A3
            tst.b   ($6E,A3)
            beq.b   .L2
            subq.w  #2,SP
            move.l  ($7A,A3),-(SP)
            _EmptyRgn
            tst.b   (SP)+
            bne.b   .L2
            tst.l   ($94,A3)
            beq.b   .L4
            move.l  A3,-(SP)
            _SetPort
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),(-4,A6)
            _GetClip
            move.l  ($1C,A3),-(SP)
            pea     ($10,A3)
            _RectRgn
            move.l  A3,-(SP)
            _BeginUpDate
            movea.l ($94,A3),A0
            move.l  A0,-(SP)
            movea.l (A0),A0
            pea     (2,A0)
            _DrawPicture
            move.l  A3,-(SP)
            _EndUpDate
            move.l  (-4,A6),-(SP)
            move.l  (SP),-(SP)
            _SetClip
            _DisposRgn
.L2:
            move.l  ($90,A3),D0
            bne.b   .L1
.L3:
            _SetPort
            movea.l (SP)+,A3
            unlk    A6
            move.l  (SP)+,(SP)
            rts
.L4:
            movea.l (8,A6),A0
            move.w  #6,(A0)+
            move.l  A3,(A0)
            addq.b  #1,($C,A6)
            bra.b   .L3
sub_40818664:
            moveq   #$6C,D0
            moveq   #0,D1
sub_40818668:
            _NewPtr
AllocP2:
            movea.l A0,A3
            move.l  A0,-(SP)
            tst.w   D1
            bne.b   .L1
            _OpenPort
            rts
.L1:
            _OpenCPort
            rts
InitWindows:
            movea.l IntlSpec,A0
            tst.b   (4,A0)
            bne.b   .L1
            bsr.w   FIXSMGRWORLD
.L1:
            link.w  A6,#0
            movem.l D3-D7/A3-A4,-(SP)
            moveq   #7,D0
            bset    D0,DSWndUpdate
            bset    D0,AlarmSt
            move.l  MinusOne,SaveUpdate
            subq.w  #4,SP
            move.w  #$10,-(SP)
            _GetPattern
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (A0)+,DeskPattern
            move.l  (A0),($A40).w
            tst.b   SPMisc2
            bpl.b   .L4
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            move.l  ($CD8).w,D0
            beq.b   .L2
            cmp.l   MinusOne,D0
            beq.b   .L2
            move.l  D0,-(SP)
            _DisposPixPat
.L2:
            subq.w  #4,SP
            move.w  #$10,-(SP)
            _GetPixPat
            move.l  (SP)+,($CD8).w
            bne.b   .L3
            bclr    #7,SPMisc2
.L3:
            move.l  (SP)+,TheZone
.L4:
            bsr.w   sub_40818664
            move.l  A3,WMgrPort
            movea.l A3,A4
            move.l  ($18,A4),D6
            move.l  ($1C,A4),D7
            moveq   #$6C,D0
            moveq   #-1,D1
            bsr.w   sub_40818668
            move.l  A3,($D2C).w
            move.l  ($18,A3),($18,A4)
            move.l  ($1C,A3),($1C,A4)
            movea.l A4,A3
            move.l  A3,-(SP)
            _SetPort
            move.l  D7,-(SP)
            _SetEmptyRgn
            movea.l DeviceList,A4
.L5:
            movea.l (A4),A0
            tst.w   ($14,A0)
            bpl.b   .L6
            move.l  D6,-(SP)
            move.l  ($22,A0),-(SP)
            move.l  ($26,A0),-(SP)
            _SetRecRgn
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            move.l  D7,-(SP)
            _UnionRgn
.L6:
            movea.l (A4),A0
            move.l  ($1E,A0),D0
            movea.l D0,A4
            bne.b   .L5
            move.l  D7,-(SP)
            move.l  ($18,A3),-(SP)
            _CopyRgn
            _InitMenus
            jsr     (CalcMBHeight.w,PC)
            jsr     (DrawMBar.w,PC)
            movea.l D7,A0
            movea.l (A0),A0
            lea     (2,A0),A0
            lea     Scratch8,A4
            movea.l A4,A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            bsr.w   GetNewRgn
            move.l  (SP)+,D5
            move.l  D5,GrayRgn
            _HidePen
            _OpenRgn
            bra.l   INITWINDOWSRGNPATCH
            ds.b    4
INITWINDOWSRGNRETURN:
            move.l  D5,-(SP)
            _CloseRgn
            _ShowPen
            move.l  D5,-(SP)
            move.l  ($1C,A3),-(SP)
            move.l  D5,-(SP)
            _DiffRgn
            move.l  D7,-(SP)
            move.l  D5,-(SP)
            move.l  D5,-(SP)
            _SectRgn
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            _SetClip
            bra.l   WINDOWMGRPATCH
            ds.b    4
INITWINDOWSCRTRETURN:
            move.l  #$30003,-(SP)
            _PenSize
            move.l  A4,-(SP)
            move.l  #$160016,-(SP)
            _FrameRoundRect
            _PenNormal
INITWINDOWSLCDRETURN:
            move.l  D5,-(SP)
            tst.b   SPMisc2
            bpl.b   .L1
            move.l  ($D2C).w,-(SP)
            _SetPort
            move.l  ($CD8).w,-(SP)
            _FillCRgn
            move.l  WMgrPort,-(SP)
            _SetPort
            bra.b   .L2
.L1:
            pea     DeskPattern
            _FillRgn
.L2:
            move.l  D5,-(SP)
            _SetClip
            _ShowCursor
            clr.l   WindowList
            moveq   #$1C,D0
            _NewHandleClear
            movea.l A0,A4
            _HLock
            move.l  A4,AuxWinHead
            movea.l (A4),A3
            subq.w  #4,SP
            move.l  #'wctb',-(SP)
            clr.w   -(SP)
            _RGetResource
            move.l  (SP)+,(8,A3)
            movea.l A4,A0
            _HUnlock
            moveq   #$16,D0
            _NewHandleClear
            movea.l A0,A4
            _HLock
            move.l  A4,AuxCtlHead
            movea.l (A4),A3
            subq.w  #4,SP
            move.l  #'cctb',-(SP)
            clr.w   -(SP)
            _RGetResource
            move.l  (SP)+,(8,A3)
            movea.l A4,A0
            _HUnlock
            bsr.w   GetNewRgn
            move.l  (SP)+,SaveVisRgn
            clr.l   GhostWindow
            lea     CurActivate,A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.b   GrafEnd
            move.l  D6,-(SP)
            _DisposRgn
            move.l  D7,-(SP)
            _DisposRgn
            _InitPalettes
            movem.l (SP)+,D3-D7/A3-A4
            unlk    A6
            rts
NewCWindow:
            link.w  A6,#0
            moveq   #-1,D1
            bra.b   NewWindow.L1
.L1:
            _StripAddress
            movea.l D0,A0
            bsr.w   AllocP2
            bra.b   NewWindow.L2
NewWindow:
            link.w  A6,#0
            moveq   #0,D1
.L1:
            movem.l D3-D5/A2-A4,-(SP)
            bsr.w   SetWPort
            move.l  ($1E,A6),D0
            bne.b   NewCWindow.L1
            moveq   #0,D0
            move.w  #$9C,D0
            bsr.w   sub_40818668
.L2:
            move.l  A3,($22,A6)
            move.w  #1,($44,A3)
            tst.b   MMU32bit
            beq.b   .L3
            sf      ($6E,A3)
            move.l  A3,-(SP)
            move.l  #$FFFFFFFF,-(SP)
            _SetWinColor
.L3:
            movea.l ($1A,A6),A2
            move.l  (A2),-(SP)
            _MovePortTo
            subq.w  #4,SP
            move.l  (4,A2),-(SP)
            move.l  (A2),-(SP)
            bsr.w   DeltaPoint
            _PortSize
            move.l  WMgrPort,-(SP)
            _SetPort
            lea     ($6C,A3),A2
            move.w  #8,(A2)+
            tst.b   ($14,A6)
            sne     (A2)+
            clr.b   (A2)+
            tst.b   ($C,A6)
            sne     (A2)+
            clr.b   (A2)+
            moveq   #2,D3
.L4:
            bsr.w   GetNewRgn
            move.l  (SP)+,(A2)+
            dbra    D3,.L4
            move.w  ($12,A6),D3
            lsr.w   #4,D3
.L5:
            subq.w  #4,SP
            move.l  #'WDEF',-(SP)
            move.w  D3,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            moveq   #0,D3
            move.l  (SP)+,(A2)
            beq.b   .L5
            moveq   #$F,D3
            and.w   ($12,A6),D3
            tst.b   MMU32bit
            beq.b   .L6
            subq.w  #6,SP
            move.l  A3,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.b  D3,($10,A0)
            bra.b   .L7
.L6:
            move.b  D3,(A2)
.L7:
            addq.w  #4,A2
            clr.l   (A2)+
            move.l  ($16,A6),D3
            clr.l   -(SP)
            move.l  D3,-(SP)
            _NewString
            move.l  (SP)+,(A2)+
            clr.w   -(SP)
            move.l  D3,-(SP)
            _StringWidth
            move.w  (SP)+,(A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            move.l  (8,A6),(A2)+
            moveq   #3,D0
            bsr.w   sub_40818E0E
            bsr.w   CallWCalc
            move.l  ($E,A6),D5
            btst    #0,D5
            bne.b   .L9
            tst.l   WindowList
            beq.b   .L9
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            bsr.w   InsertWindow
.L8:
            move.l  A3,-(SP)
            move.l  ($72,A3),-(SP)
            _PaintOne
            move.l  A3,-(SP)
            move.l  ($72,A3),-(SP)
            _CalcVBehind
            bsr.w   RestorePort
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($1A,SP),SP
            jmp     (A0)
.L9:
            tst.b   ($6E,A3)
            beq.b   .L11
            subq.w  #4,SP
            _FrontWindow
            move.l  (SP)+,D0
            beq.b   .L10
            bsr.w   MakeDeactive
.L10:
            move.b  #1,($6F,A3)
            move.l  A3,CurActivate
.L11:
            move.l  WindowList,($90,A3)
            move.l  A3,WindowList
            bra.b   .L8
sub_408189BC:
            lea     CurActivate,A0
            move.l  A3,D0
            bsr.b   sub_408189C6
            addq.w  #4,A0
sub_408189C6:
            move.l  (A0),D1
            eor.l   D0,D1
            and.l   Lo3Bytes,D1
            bne.b   .L1
            bset    #7,(A0)
.L1:
            rts
CloseWindow:
            movem.l D3-D4/A2-A3,-(SP)
            movea.l ($14,SP),A3
            bsr.w   SetWPort
            bsr.b   sub_408189BC
            subq.w  #4,SP
            _FrontWindow
            move.l  A3,-(SP)
            _KillControls
            moveq   #4,D0
            bsr.w   sub_40818E0E
            move.l  A3,-(SP)
            clr.w   -(SP)
            _ShowHide
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            btst    #$C,(6,A0)
            beq.b   .L1
            move.l  D0,-(SP)
            _DisposePalette
.L1:
            move.l  A3,-(SP)
            subq.w  #6,SP
            clr.l   -(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (8,A0),-(SP)
            tst.b   MMU32bit
            beq.b   .L5
            lea     AuxWinHead,A1
.L2:
            movea.l (A1),A2
            movea.l (A2),A0
            cmpa.l  (4,A0),A3
            beq.b   .L3
            lea     (A0),A1
            bra.b   .L2
.L3:
            move.l  (A0),(A1)
            movea.l A2,A1
            movea.l (A1),A1
            move.l  (8,A1),D0
            cmp.l   (SP)+,D0
            beq.b   .L4
            movea.l D0,A0
            _HGetState
            btst    #5,D0
            bne.b   .L4
            _DisposHandle
.L4:
            movea.l A2,A0
            _DisposHandle
            addq.w  #4,SP
            bra.b   .L6
.L5:
            _SetWinColor
.L6:
            move.l  A3,-(SP)
            bsr.w   DeleteWindow
            movea.l ($86,A3),A0
            _DisposHandle
            move.l  ($72,A3),-(SP)
            _DisposRgn
            move.l  ($76,A3),-(SP)
            _DisposRgn
            move.l  ($7A,A3),-(SP)
            _DisposRgn
            move.l  A3,-(SP)
            tst.w   (6,A3)
            bpl.b   .L7
            _CloseCPort
            bra.b   .L8
.L7:
            _CloseCPort
.L8:
            move.l  ($94,A3),D0
            beq.b   .L9
            move.l  D0,-(SP)
            _KillPicture
.L9:
            cmpa.l  (SP)+,A3
            bne.b   .L10
            move.w  ($6C,A3),CurDeKind
            subq.w  #4,SP
            _FrontWindow
            bsr.w   sub_40819030
.L10:
            cmpa.l  D4,A3
            beq.b   .L11
            bsr.w   RestorePort
.L11:
            movem.l (SP)+,D3-D4/A2-A3
            move.l  (SP)+,(SP)
            rts
MakeDeactive:
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            clr.w   -(SP)
            _HiliteWindow
            move.l  (SP)+,D0
            tst.l   CurDeactive
            bgt.b   .L1
            movea.l D0,A0
            move.w  ($6C,A0),CurDeKind
            move.l  D0,CurDeactive
.L1:
            rts
DisposeWindow:
            move.l  (4,SP),-(SP)
            _CloseWindow
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     (A1)
ShowWindow:
            movea.l WindowList,A0
.L1:
            tst.b   ($6E,A0)
            bne.b   .L2
            cmpa.l  (4,SP),A0
            beq.b   .L3
            movea.l ($90,A0),A0
            move.l  A0,D0
            bne.b   .L1
.L2:
            movea.l (SP)+,A1
            move.b  #1,-(SP)
            _ShowHide
            jmp     (A1)
.L3:
            move.l  A0,-(SP)
            _SelectWindow
            bra.b   .L2
HideWindow:
            subq.w  #4,SP
            _FrontWindow
            move.l  (8,SP),-(SP)
            clr.w   -(SP)
            _ShowHide
            move.l  (SP)+,D0
            cmp.l   (4,SP),D0
            bne.b   .L1
            bsr.b   MakeDeactive
            subq.w  #4,SP
            _FrontWindow
            move.l  (SP),CurActivate
            beq.b   .L2
            _SelectWindow
.L1:
            move.l  (SP)+,(SP)
            rts
.L2:
            addq.w  #4,SP
            bra.b   .L1
GetWRefCon:
            move.w  #$98,D1
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (0,A1,D1.w),(SP)
            jmp     (A0)
SetWRefCon:
            move.w  #$98,D1
.L1:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,(0,A1,D1.w)
            jmp     (A0)
SetWindowPic:
            move.w  #$94,D1
            bra.b   SetWRefCon.L1
GetWindowPic:
            move.w  #$94,D1
            bra.b   GetWRefCon.L1
GetWTitle:
            movem.l (SP)+,D1/A0-A1
            movea.l ($86,A1),A1
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A1),D0
.L1:
            move.b  (A1)+,(A0)+
            dbra    D0,.L1
            movea.l D1,A0
            jmp     (A0)
SetWTitle:
            movem.l D3-D5/A2-A3,-(SP)
            move.l  ($18,SP),D5
            movea.l ($1C,SP),A3
            bsr.w   SetWPort
            movea.l ($72,A3),A0
            _HandToHand
            move.l  A0,D3
            move.l  ($86,A3),D0
            beq.b   .L2
            move.l  D0,-(SP)
            move.l  D5,-(SP)
            _SetString
            subq.w  #2,SP
            move.l  D5,-(SP)
            _StringWidth
            move.w  (SP)+,($8A,A3)
            bsr.w   CallWCalc
            clr.w   -(SP)
            move.l  ($72,A3),-(SP)
            move.l  D3,-(SP)
            _EqualRgn
            move.w  (SP)+,D0
            beq.b   .L1
            bsr.b   sub_40818BF6
            move.l  A3,-(SP)
            move.l  D3,-(SP)
            _PaintOne
            bra.b   .L2
.L1:
            move.l  ($72,A3),-(SP)
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            _UnionRgn
            bsr.b   sub_40818BF6
            move.l  A3,-(SP)
            move.l  D3,-(SP)
            _PaintBehind
            move.l  A3,-(SP)
            move.l  D3,-(SP)
            _CalcVBehind
.L2:
            move.l  D3,-(SP)
            _DisposRgn
            bsr.w   RestorePort
            movem.l (SP)+,D3-D5/A2-A3
.L3:
            bra.w   InsertWindow.L3
sub_40818BF6:
            move.l  D3,-(SP)
            move.l  ($76,A3),-(SP)
            move.l  D3,-(SP)
            _DiffRgn
            rts
DeltaPoint:
            move.w  (8,SP),D0
            sub.w   (4,SP),D0
            move.w  D0,($C,SP)
            move.w  ($A,SP),D0
            sub.w   (6,SP),D0
            move.w  D0,($E,SP)
            bra.b   SetWTitle.L3
MoveGuts:
            move.l  A4,-(SP)
            subq.w  #4,SP
            move.l  D0,-(SP)
            subq.w  #4,SP
            move.l  ($10,A3),-(SP)
            movea.l A3,A0
            bsr.w   WMGR
            move.l  (6,A0),-(SP)
            bsr.b   DeltaPoint
            bsr.b   DeltaPoint
            move.l  (SP),D3
            _OffsetRgn
            move.l  ($76,A3),-(SP)
            move.l  D3,-(SP)
            _OffsetRgn
            move.l  ($7A,A3),-(SP)
            move.l  D3,-(SP)
            _OffsetRgn
            movea.l A3,A0
            bsr.w   WMGR
            pea     (6,A0)
            move.l  D3,-(SP)
            bsr.w   sub_408190E0
            _OffsetRect
            rts
MoveWindow:
            movem.l D3-D6/A3-A4,-(SP)
            bsr.w   SetWPort
            movea.l ($22,SP),A3
            bsr.w   sub_40818ED8
            bsr.w   GetNewRgn
            move.l  (SP)+,D5
            movea.l ($72,A3),A4
            move.l  A4,-(SP)
            movea.l WMgrPort,A0
            move.l  ($1C,A0),-(SP)
            move.l  D5,-(SP)
            _SectRgn
            movea.l A4,A0
            _HandToHand
            move.l  A0,D6
            move.l  ($1E,SP),D0
            bsr.b   MoveGuts
            bsr.w   SmartMove
            move.l  D5,-(SP)
            move.l  D3,-(SP)
            _OffsetRgn
            tst.b   ($1C,SP)
            beq.b   .L1
            move.l  GrayRgn,-(SP)
            _SetClip
.L1:
            movea.l WMgrPort,A0
            pea     (2,A0)
            move.l  (SP),-(SP)
            movea.l D6,A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l (A4),A0
            pea     (2,A0)
            clr.w   -(SP)
            move.l  D5,-(SP)
            _CopyBits
            move.l  A4,-(SP)
            move.l  D5,-(SP)
            move.l  D5,-(SP)
            _DiffRgn
            move.l  ($90,A3),-(SP)
            move.l  D6,-(SP)
            _PaintBehind
            tst.b   ($1C,SP)
            beq.b   .L2
            move.l  A3,-(SP)
            st      DragFlag
            bsr.w   sub_40819018
.L2:
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            _PaintOne
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            move.l  D6,-(SP)
            _UnionRgn
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            _CalcVBehind
            move.l  D5,-(SP)
            _DisposRgn
            move.l  D6,-(SP)
            _DisposRgn
            move.l  A3,-(SP)
            _ActivatePalette
            bsr.w   RestorePort
            movem.l (SP)+,D3-D6/A3-A4
            bra.w   SizeWindow.L2
SmartMove:
            movem.l D5-D7/A2-A4,-(SP)
            subq.w  #8,SP
            movea.l SP,A2
            subq.w  #8,SP
            _NewRgn
            move.l  (SP)+,D7
            _NewRgn
            move.l  (SP)+,D6
            movea.l DeviceList,A4
.L1:
            movea.l (A4),A0
            tst.w   ($14,A0)
            bpl.w   .L4
            move.l  D7,-(SP)
            pea     ($22,A0)
            _RectRgn
            move.l  D5,-(SP)
            move.l  D7,-(SP)
            move.l  D7,-(SP)
            _SectRgn
            clr.b   -(SP)
            move.l  D7,-(SP)
            _EmptyRgn
            tst.b   (SP)+
            bne.w   .L4
            movea.l DeviceList,A3
.L2:
            movea.l (A3),A0
            tst.w   ($14,A0)
            bpl.b   .L3
            cmpa.l  A3,A4
            beq.b   .L3
            movea.l (A4),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            move.l  (A1),D0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            cmp.l   (A1),D0
            beq.b   .L3
            lea     ($22,A0),A0
            movea.l A2,A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            move.l  A2,-(SP)
            move.l  D3,-(SP)
            bsr.w   sub_408190E0
            _OffsetRect
            move.l  D6,-(SP)
            move.l  A2,-(SP)
            _RectRgn
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            _SectRgn
            clr.b   -(SP)
            move.l  D6,-(SP)
            _EmptyRgn
            tst.b   (SP)+
            bne.b   .L3
            move.l  D5,-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            _DiffRgn
.L3:
            movea.l (A3),A0
            move.l  ($1E,A0),D0
            movea.l D0,A3
            bne.b   .L2
.L4:
            movea.l (A4),A0
            move.l  ($1E,A0),D0
            movea.l D0,A4
            bne.w   .L1
            move.l  D6,-(SP)
            _DisposRgn
            move.l  D7,-(SP)
            _DisposRgn
            addq.w  #8,SP
            movem.l (SP)+,D5-D7/A2-A4
            rts
GetWVariant:
            movea.l (4,SP),A1
            tst.b   MMU32bit
            beq.b   .L1
            subq.w  #6,SP
            move.l  A1,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            clr.w   D0
            move.b  ($10,A0),D0
            bra.b   .L2
.L1:
            clr.w   D0
            move.b  ($7E,A1),D0
            andi.w  #$F,D0
.L2:
            move.w  D0,(8,SP)
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
sub_40818E0E:
            clr.l   -(SP)
            subq.w  #2,SP
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            move.l  D3,-(SP)
            subq.w  #2,SP
            move.l  A3,-(SP)
            _GetWVariant
            move.w  (SP)+,($A,SP)
            movea.l ($7E,A3),A0
            tst.l   (A0)
            bne.b   .L1
            move.l  A0,D0
            _StripAddress
            move.l  D0,-(SP)
            _LoadResource
            tst.l   (A0)
            bne.b   .L1
            move.w  #$57,D0
            _SysError
.L1:
            _HLock
            movea.l (A0),A0
            jsr     (A0)
            movea.l ($7E,A3),A0
            _HUnlock
            move.l  (SP)+,D0
            rts
CallDWindow:
            movem.l D3,-(SP)
            moveq   #0,D3
            moveq   #0,D0
            bsr.b   sub_40818E0E
            move.l  (SP)+,D3
            rts
CallWCalc:
            moveq   #2,D0
            tst.b   ($6E,A3)
            beq.b   .L2
            lea     (8,A3),A1
            move.l  (A1)+,-(SP)
            move.l  (A1)+,-(SP)
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l (2,A3),A0
            movea.l (A0),A0
            move.l  ($A,A0),-(A1)
            move.l  (6,A0),-(A1)
.L1:
            bsr.b   sub_40818E0E
            move.l  (SP)+,($C,A3)
            move.l  (SP)+,(8,A3)
            rts
.L2:
            move.l  ($72,A3),-(SP)
            _SetEmptyRgn
            move.l  ($76,A3),-(SP)
            _SetEmptyRgn
            move.l  ($18,A3),-(SP)
            _SetEmptyRgn
            rts
HiliteWindow:
            movem.l D3-D4/A3-A4,-(SP)
            movea.l ($16,SP),A3
            move.b  ($14,SP),D3
            bsr.w   SetWPort
            move.b  ($6F,A3),D0
            eor.w   D3,D0
            lsr.w   #1,D0
            bcc.b   .L1
            move.b  D3,($6F,A3)
            bsr.b   sub_40818ECC
            bsr.b   CallDWindow
.L1:
            bsr.w   RestorePort
            movem.l (SP)+,D3-D4/A3-A4
            bra.w   DrawNew.L2
sub_40818ECC:
            move.l  ($72,A3),-(SP)
.L1:
            _SetClip
            move.l  A3,-(SP)
            _ClipAbove
            rts
sub_40818ED8:
            move.l  GrayRgn,-(SP)
            bra.b   sub_40818ECC.L1
SizeWindow:
            movem.l D3-D4/A3-A4,-(SP)
            move.l  ($16,SP),D3
            beq.b   .L1
            movea.l ($1A,SP),A3
            move.w  ($16,SP),D4
            lea     ($10,A3),A4
            add.w   (A4)+,D4
            add.w   (A4)+,D3
            move.w  D4,(A4)+
            move.w  D3,(A4)+
            tst.b   ($6E,A3)
            beq.b   .L1
            bsr.w   SetWPort
            move.l  A3,-(SP)
            _SaveOld
            move.b  ($14,SP),D3
            bsr.b   SizeGuts
            move.l  A3,-(SP)
            _ActivatePalette
.L1:
            movem.l (SP)+,D3-D4/A3-A4
.L2:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
SizeGuts:
            bsr.w   CallWCalc
            bsr.b   sub_40818ECC
            bsr.w   CallDWindow
            move.l  A3,-(SP)
            move.b  D3,-(SP)
            _DrawNew
            bsr.w   RestorePort
            rts
ZoomWindow:
            movem.l D3-D6/A2-A4,-(SP)
            bsr.w   SetWPort
            movea.l ($24,SP),A3
            bsr.w   CallWCalc
            move.l  A3,-(SP)
            _SaveOld
            movea.l ($82,A3),A2
            movea.l (A2),A2
            cmpi.w  #7,($22,SP)
            beq.b   .L1
            addq.w  #8,A2
.L1:
            movea.l ($72,A3),A4
            move.l  (A2)+,D0
            bsr.w   MoveGuts
            move.w  (A2)+,D0
            move.w  (A2)+,D1
            subq.w  #8,A2
            sub.w   (A2)+,D0
            sub.w   (A2)+,D1
            lea     ($10,A3),A0
            add.w   (A0)+,D0
            add.w   (A0)+,D1
            move.w  D0,(A0)+
            move.w  D1,(A0)+
            moveq   #1,D3
            bsr.b   SizeGuts
            tst.b   ($20,SP)
            beq.b   .L2
            move.l  A3,-(SP)
            st      DragFlag
            bsr.w   sub_40819018
.L2:
            pea     ($10,A3)
            _InvalRect
            movem.l (SP)+,D3-D6/A2-A4
            bra.w   InsertWindow.L3
TrackGoAway:
            movea.l (SP)+,A0
            move.w  #6,-(SP)
            move.l  A0,-(SP)
TrackBox:
            link.w  A6,#-4
            movem.l D3-D6/A3,-(SP)
            bsr.w   SetWPort
            lea     (8,A6),A0
            move.w  (A0)+,D6
            subq.w  #2,D6
            move.l  (A0)+,(-4,A6)
            movea.l (A0)+,A3
            clr.w   (A0)
            moveq   #0,D5
            bsr.w   sub_40818ECC
.L1:
            moveq   #1,D0
            move.l  (-4,A6),D3
            bsr.w   sub_40818E0E
            cmp.w   D6,D0
            beq.b   .L2
            moveq   #0,D0
.L2:
            cmp.w   D0,D5
            beq.b   .L3
            move.w  D0,D5
            bsr.b   sub_40819008
.L3:
            pea     (-4,A6)
            _GetMouse
            bsr.w   sub_40819450
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            bne.b   .L1
            tst.w   D5
            beq.b   .L4
            addq.b  #1,($12,A6)
            bsr.b   sub_40819008
.L4:
            bsr.w   RestorePort
            movem.l (SP)+,D3-D6/A3
            unlk    A6
            bra.w   SizeWindow.L2
sub_40819008:
            moveq   #0,D0
            moveq   #0,D3
            move.w  D6,D3
            bsr.w   sub_40818E0E
            rts
SelectWindow:
            clr.b   DragFlag
sub_40819018:
            subq.w  #4,SP
            _FrontWindow
            move.l  (8,SP),-(SP)
            bsr.b   BTF1
            move.l  (SP)+,D0
            beq.b   sub_40819030
            cmp.l   (4,SP),D0
            beq.b   sub_40819030.L1
            bsr.w   MakeDeactive
sub_40819030:
            move.l  (4,SP),D0
            move.l  D0,CurActivate
            beq.b   .L2
.L1:
            move.l  D0,-(SP)
            move.l  (SP),-(SP)
            st      -(SP)
            _HiliteWindow
            _ActivatePalette
.L2:
            move.l  (SP)+,(SP)
            rts
BringToFront:
            clr.b   DragFlag
BTF1:
            movem.l D3-D6/A2-A4,-(SP)
            movea.l ($20,SP),A3
            bsr.w   SetWPort
            lea     WindowList,A2
            cmpa.l  (A2),A3
            beq.b   .L5
            bsr.w   GetNewRgn
            move.l  (SP)+,D3
            movea.l (A2),A4
.L1:
            cmpa.l  A3,A4
            beq.b   .L3
            tst.b   ($6E,A4)
            beq.b   .L2
            movea.l A4,A0
            bsr.w   WMGR
            move.l  (6,A0),D6
            move.l  ($18,A4),D5
            move.l  D5,-(SP)
            move.l  D6,-(SP)
            bsr.b   sub_408190E0
            _OffsetRgn
            move.l  D5,-(SP)
            move.l  ($72,A3),-(SP)
            move.l  D5,-(SP)
            _DiffRgn
            move.l  D5,-(SP)
            move.l  D6,-(SP)
            _OffsetRgn
            move.l  ($72,A4),-(SP)
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            _UnionRgn
.L2:
            movea.l ($90,A4),A4
            move.l  A4,D0
            bne.b   .L1
.L3:
            move.l  A3,-(SP)
            bsr.w   DeleteWindow
            move.l  (A2),($90,A3)
            move.l  A3,(A2)
            tst.b   DragFlag
            bne.b   .L4
            move.l  ($72,A3),-(SP)
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            _SectRgn
            move.l  A3,-(SP)
            move.l  D3,-(SP)
            _PaintOne
.L4:
            move.l  A3,-(SP)
            _CalcVis
            move.l  D3,-(SP)
            _DisposRgn
.L5:
            bsr.w   RestorePort
            movem.l (SP)+,D3-D6/A2-A4
            move.l  (SP)+,(SP)
            rts
sub_408190E0:
            neg.w   (4,SP)
            neg.w   (6,SP)
            rts
SendBehind:
            movem.l D3-D4/A3,-(SP)
            movea.l ($14,SP),A3
            bsr.w   SetWPort
            subq.w  #4,SP
            _FrontWindow
            cmpa.l  (SP)+,A3
            bne.b   .L2
            movea.l A3,A0
.L1:
            movea.l ($90,A0),A0
            move.l  A0,D0
            beq.b   .L2
            tst.b   ($6E,A0)
            beq.b   .L1
            move.l  A0,-(SP)
            _SelectWindow
.L2:
            move.l  A3,-(SP)
            bsr.w   DeleteWindow
            move.l  ($72,A3),D3
            move.l  ($90,A3),-(SP)
            move.l  (SP),-(SP)
            move.l  A3,-(SP)
            move.l  ($1C,SP),-(SP)
            bsr.w   InsertWindow
            move.l  D3,-(SP)
            _CalcVBehind
            move.l  D3,-(SP)
            _PaintBehind
            bsr.w   RestorePort
            movem.l (SP)+,D3-D4/A3
            bra.w   InsertWindow.L3
BeginUpdate:
            movem.l D3-D4/A3,-(SP)
            movea.l ($10,SP),A3
            movea.l A3,A0
            bsr.w   WMGR
            move.l  (6,A0),D3
            move.l  ($18,A3),D4
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            bsr.b   sub_408190E0
            _OffsetRgn
            move.l  D4,-(SP)
            move.l  SaveVisRgn,-(SP)
            _CopyRgn
            move.l  D4,-(SP)
            move.l  ($7A,A3),-(SP)
            move.l  D4,-(SP)
            _SectRgn
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            _OffsetRgn
            move.l  ($7A,A3),-(SP)
            _SetEmptyRgn
            movem.l (SP)+,D3-D4/A3
            move.l  (SP)+,(SP)
            rts
EndUpdate:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  SaveVisRgn,-(SP)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            movea.l A3,A0
            bsr.w   WMGR
            move.l  (6,A0),-(SP)
            _OffsetRgn
            move.l  ($18,A3),-(SP)
            _CopyRgn
            _SetEmptyRgn
            movea.l (SP)+,A3
            move.l  (SP)+,(SP)
            rts
FrontWindow:
            clr.l   (4,SP)
            tst.b   GrafEnd
            bne.b   .L4
            movea.l WindowList,A0
.L1:
            move.l  A0,D0
            beq.b   .L3
            cmpa.l  GhostWindow,A0
            beq.b   .L2
            tst.b   ($6E,A0)
            bne.b   .L3
.L2:
            movea.l ($90,A0),A0
            bra.b   .L1
.L3:
            move.l  A0,(4,SP)
.L4:
            rts
DragWindow:
            link.w  A6,#-$24
            movem.l D3-D6/A3-A4,-(SP)
            subq.w  #2,SP
            _WaitMouseUp
            tst.b   (SP)+
            beq.w   .L4
            movea.l (8,A6),A0
            move.w  (A0)+,D0
            move.w  MBarHeight,D1
            addq.w  #4,D1
            cmp.w   D1,D0
            bcc.b   .L1
            move.w  D1,D0
.L1:
            lea     (-$10,A6),A1
            move.w  D0,(A1)+
            move.w  (A0)+,(A1)+
            move.l  (A0),(A1)
            move.l  ($C,A6),D3
            movea.l ($10,A6),A3
            bsr.w   SetWPort
            move.l  GrayRgn,-(SP)
            _SetClip
            pea     (-$24,A6)
            _GetKeys
            move.b  (-$1E,A6),D6
            bpl.b   .L2
            bsr.w   sub_40818ED8
.L2:
            bsr.w   GetNewRgn
            movea.l (SP),A4
            move.l  ($72,A3),-(SP)
            move.l  A4,-(SP)
            _CopyRgn
            move.l  A4,-(SP)
            move.l  D3,-(SP)
            pea     (-$10,A6)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _DragGrayRgn
            move.l  (SP)+,D5
            beq.b   .L5
            cmpi.w  #$8000,D5
            beq.b   .L3
            move.l  A3,-(SP)
            move.l  ($10,A3),D0
            movea.l A3,A0
            bsr.w   WMGR
            sub.w   (8,A0),D0
            add.w   D5,D0
            move.w  D0,-(SP)
            swap    D0
            swap    D5
            sub.w   (6,A0),D0
            add.w   D5,D0
            move.w  D0,-(SP)
            tst.b   D6
            spl     -(SP)
            _MoveWindow
.L3:
            move.l  A4,-(SP)
            _DisposRgn
            bsr.w   RestorePort
.L4:
            movem.l (SP)+,D3-D6/A3-A4
            unlk    A6
            bra.w   GrowWindow.L4
.L5:
            tst.b   D6
            bmi.b   .L3
            move.l  A3,-(SP)
            _SelectWindow
            bra.b   .L3
WMgrGray:
            dc.w    $AA55                           ; A-trap $AA55
            dc.w    $AA55                           ; A-trap $AA55
.L1:
            dc.w    $AA55                           ; A-trap $AA55
            dc.w    $AA55                           ; A-trap $AA55
DragGrayRgn:
            move.l  WMgrGray,DragPattern
            move.l  WMgrGray.L1,($A38).w
DragTheRgn:
            link.w  A6,#-$2C
            movem.l D3-D7/A3,-(SP)
            lea     ($16,A6),A0
            move.l  (A0)+,D3
            movea.l (A0)+,A3
            clr.l   (A0)
            pea     (-$14,A6)
            move.l  (SP),-(SP)
            _GetPenState
            pea     DragPattern
            _PenPat
            move.w  #$E,-(SP)
            _PenMode
            bsr.w   sub_4081947E
            beq.b   .L1
            move.l  A3,-(SP)
            bsr.w   GetNewRgn
            move.l  (SP),D4
            _CopyRgn
            move.l  D4,-(SP)
            move.l  OneOne,-(SP)
            _InsetRgn
            move.l  A3,-(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            _DiffRgn
            move.l  D4,-(SP)
            _DisposRgn
            move.l  A3,-(SP)
            _PaintRgn
.L1:
            moveq   #-1,D5
            bsr.w   GetNewRgn
            move.l  (SP)+,D6
            bsr.w   GetNewRgn
            move.l  (SP)+,D7
            movea.l (A5),A0
            lea     (-$74,A0),A0
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            move.w  MBarHeight,D0
            add.w   D0,(SP)
            addi.w  #$1E,(SP)
            move.l  SP,-(SP)
            move.l  #$60006,-(SP)
            _InsetRect
            move.l  (4,SP),-(SP)
            move.l  (4,SP),-(SP)
            clr.b   -(SP)
            pea     (2,SP)
            move.l  ($12,A6),-(SP)
            pea     ($A,SP)
            _SectRect
            tst.b   (SP)+
            clr.b   -(SP)
            pea     ($A,SP)
            pea     (6,SP)
            _EqualRect
            tst.b   (SP)+
            lea     ($10,SP),SP
            beq.b   .L2
            move.l  GrayRgn,-(SP)
            move.l  D7,-(SP)
            _CopyRgn
            move.l  D7,-(SP)
            move.l  #$40004,-(SP)
            _InsetRgn
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            _CopyRgn
            bra.b   .L3
.L2:
            move.l  D7,-(SP)
            move.l  ($E,A6),-(SP)
            _RectRgn
            move.l  D6,-(SP)
            move.l  ($12,A6),-(SP)
            _RectRgn
.L3:
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP),D4
            move.l  D6,-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.w   sub_40819454.L2
.L4:
            move.l  D4,D1
            swap    D1
            cmp.l   D4,D3
            beq.b   .L9
            move.l  D4,-(SP)
            sub.w   D3,D4
            swap    D3
            sub.w   D3,D1
            move.w  ($C,A6),D0
            beq.b   .L6
            subq.w  #1,D0
            bne.b   .L5
            clr.w   D1
            bra.b   .L6
.L5:
            clr.w   D4
.L6:
            add.w   D1,($1E,A6)
            add.w   D4,($20,A6)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            move.w  D1,-(SP)
            tst.w   D5
            beq.b   .L7
            bsr.w   sub_4081947E
            beq.b   .L7
            move.l  A3,-(SP)
            _PaintRgn
.L7:
            _OffsetRgn
            bsr.w   sub_4081947E
            beq.b   .L8
            move.l  A3,-(SP)
            _PaintRgn
.L8:
            moveq   #-1,D5
            move.l  (SP)+,D3
.L9:
            move.l  (8,A6),D0
            bsr.w   sub_40819454
            bsr.w   sub_40819450
            move.l  Ticks,D0
            addq.l  #2,D0
.L10:
            cmp.l   Ticks,D0
            bhi.b   .L10
            subq.w  #2,SP
            _WaitMouseUp
            tst.b   (SP)+
            bne.b   .L3
            tst.w   D5
            beq.b   .L11
            bsr.w   sub_4081947E
            beq.b   .L11
            move.l  A3,-(SP)
            _PaintRgn
.L11:
            _SetPenState
            movea.l (A3),A0
            cmpi.w  #$A,(A0)
            bne.b   .L12
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            _CopyRgn
            move.l  D6,-(SP)
            move.l  OneOne,-(SP)
            _InsetRgn
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            _DiffRgn
.L12:
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  D7,-(SP)
            _PtInRgn
            tst.b   (SP)+
            bne.b   .L13
            move.l  #$80008000,($1E,A6)
.L13:
            move.l  D7,-(SP)
            _DisposRgn
            move.l  D6,-(SP)
            _DisposRgn
            movem.l (SP)+,D3-D7/A3
            unlk    A6
            movea.l (SP)+,A0
            lea     ($16,SP),SP
            jmp     (A0)
sub_40819450:
            move.l  DragHook,D0
sub_40819454:
            beq.b   .L1
            movea.l D0,A0
            jsr     (A0)
.L1:
            rts
.L2:
            subq.w  #2,SP
            move.l  D4,-(SP)
            move.l  D7,-(SP)
            _PtInRgn
            tst.b   (SP)+
            bne.b   sub_4081947E.L2
            tst.w   D5
            beq.w   DragTheRgn.L9
            moveq   #0,D5
.L3:
            bsr.w   sub_4081947E
            beq.b   .L4
            move.l  A3,-(SP)
            _PaintRgn
.L4:
            bra.w   DragTheRgn.L9
sub_4081947E:
            movea.l (A3),A0
            cmpi.w  #$A,(A0)
            bne.b   .L1
            movea.l A3,A0
            _HLock
            movea.l (A3),A0
            pea     (2,A0)
            _FrameRect
            movea.l A3,A0
            _HUnlock
            moveq   #0,D0
.L1:
            rts
.L2:
            tst.w   D5
            bne.b   .L3
            moveq   #1,D5
            bra.b   sub_40819454.L3
.L3:
            subq.w  #4,SP
            move.l  ($12,A6),-(SP)
            move.l  D4,-(SP)
            _PinRect
            move.l  (SP)+,D4
            bra.w   DragTheRgn.L4
InvalRgn:
            moveq   #0,D0
sub_408194B4:
            movem.l D3-D5/A3,-(SP)
            move.w  D0,D5
            movea.l (A5),A0
            movea.l (A0),A3
            move.l  ($14,SP),D4
            movea.l A3,A0
            bsr.w   WMGR
            move.l  (6,A0),D3
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            bsr.w   sub_408190E0
            _OffsetRgn
            move.l  ($7A,A3),-(SP)
            move.l  D4,-(SP)
            move.l  ($7A,A3),-(SP)
            tst.w   D5
            bne.b   .L1
            _UnionRgn
            bra.b   .L2
.L1:
            _DiffRgn
.L2:
            move.l  D4,-(SP)
            move.l  D3,-(SP)
            _OffsetRgn
.L3:
            movem.l (SP)+,D3-D5/A3
            move.l  (SP)+,(SP)
            rts
InvalRect:
            moveq   #0,D0
.L1:
            movem.l D2-D5/A3,-(SP)
            move.w  D0,D5
            _NewRgn
            move.l  (SP),D4
            move.l  ($18,SP),-(SP)
            _RectRgn
            move.l  D4,-(SP)
            move.w  D5,D0
            bsr.b   sub_408194B4
            move.l  D4,-(SP)
            _DisposRgn
            bra.b   sub_408194B4.L3
ValidRgn:
            moveq   #-1,D0
            bra.b   sub_408194B4
ValidRect:
            moveq   #-1,D0
            bra.b   InvalRect.L1
GrowWindow:
            link.w  A6,#-$5C
            movem.l D3-D7/A3-A4,-(SP)
            bsr.w   SetWPort
            move.l  ($C,A6),D3
            movea.l ($10,A6),A3
            bsr.w   sub_40818ED8
            pea     (-$1C,A6)
            move.l  (SP),-(SP)
            _GetPenState
            _PenNormal
            move.w  #$E,-(SP)
            _PenMode
            pea     WMgrGray
            _PenPat
            lea     (-8,A6),A4
            move.l  ($10,A3),(A4)
            move.l  ($14,A3),(4,A4)
            move.l  A4,-(SP)
            movea.l A3,A0
            bsr.w   WMGR
            move.l  (6,A0),-(SP)
            bsr.w   sub_408190E0
            _OffsetRect
            bsr.b   CallGrow
            bsr.w   sub_40819638
            move.l  D0,D6
            subq.w  #4,SP
            move.l  D3,-(SP)
            move.l  (4,A4),-(SP)
            bsr.w   DeltaPoint
            move.l  (SP)+,D5
.L1:
            move.l  D3,-(SP)
            bsr.b   GetPinMouse
            move.l  (SP),D0
            move.l  D3,-(SP)
            move.l  D0,-(SP)
            bsr.w   DeltaPoint
            move.l  (SP)+,D7
            beq.b   .L2
            bsr.b   CallGrow
            add.w   D7,(6,A4)
            swap    D7
            add.w   D7,(4,A4)
            bsr.b   CallGrow
.L2:
            bsr.w   sub_40819450
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            bne.b   .L1
            bsr.b   CallGrow
            bsr.w   sub_40819638
            cmp.l   D0,D6
            bne.b   .L3
            moveq   #0,D0
.L3:
            move.l  D0,($14,A6)
            _SetPenState
            bsr.w   RestorePort
            movem.l (SP)+,D3-D7/A3-A4
            unlk    A6
.L4:
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
CallGrow:
            move.l  D3,-(SP)
            moveq   #5,D0
            move.l  A4,D3
            bsr.w   sub_40818E0E
            move.l  (SP)+,D3
            rts
GetPinMouse:
            move.l  (4,A4),-(SP)
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  D5,-(SP)
            bsr.w   DeltaPoint
            movea.l (8,A6),A0
            lea     (-$24,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            pea     (-$48,A6)
            _GetKeys
            tst.b   (-$42,A6)
            bpl.b   .L1
            move.l  #$7FFE7FFE,(-$20,A6)
.L1:
            move.l  (SP)+,(4,A4)
            bsr.b   sub_40819638
            move.l  (SP),(4,A4)
            pea     (-$24,A6)
            move.l  D0,-(SP)
            _PinRect
            swap    D5
            move.w  (A4),D3
            add.w   (SP)+,D3
            add.w   D5,D3
            swap    D3
            swap    D5
            move.w  (2,A4),D3
            add.w   (SP)+,D3
            add.w   D5,D3
            rts
sub_40819638:
            subq.w  #4,SP
            move.l  (4,A4),-(SP)
            move.l  (A4),-(SP)
            bsr.w   DeltaPoint
            move.l  (SP)+,D0
            rts
FindWindow:
            movem.l D1/D3/A3,-(SP)
            lea     ($10,SP),A0
            movea.l (A0)+,A1
            clr.l   (A1)
            move.l  (A0)+,D3
            clr.w   (A0)
            moveq   #1,D0
            move.l  D3,D1
            jsr     (CallMBarProc.w,PC)
            tst.l   D0
            bmi.b   .L1
            moveq   #1,D0
            bra.b   .L5
.L1:
            movea.l WindowList,A3
.L2:
            move.l  A3,D0
            beq.b   .L10
            tst.b   ($6E,A3)
            beq.b   .L3
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  ($72,A3),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L3
            moveq   #1,D0
            bsr.w   sub_40818E0E
            tst.w   D0
            bne.b   .L4
.L3:
            movea.l ($90,A3),A3
            bra.b   .L2
.L4:
            movea.l ($10,SP),A0
            move.l  A3,(A0)
            tst.w   ($6C,A3)
            bpl.b   .L6
            moveq   #2,D0
.L5:
            bra.b   .L9
.L6:
            cmpi.w  #2,D0
            blt.b   .L8
            bgt.b   .L7
            moveq   #4,D0
            bra.b   .L9
.L7:
            addq.w  #2,D0
            bra.b   .L9
.L8:
            moveq   #3,D0
.L9:
            move.w  D0,($18,SP)
            movem.l (SP)+,D1/D3/A3
            bra.w   InsertWindow.L3
.L10:
            move.l  DeskHook,D0
            beq.b   .L9
            moveq   #2,D0
            bra.b   .L9
DrawGrowIcon:
            movem.l D4/A3,-(SP)
            movea.l ($C,SP),A3
            bsr.w   SetWPort
            moveq   #6,D0
            bsr.w   sub_40818E0E
            bsr.w   RestorePort
            movem.l (SP)+,D4/A3
            move.l  (SP)+,(SP)
            rts
SetDeskCPat:
            tst.l   (4,SP)
            beq.b   .L3
            move.l  ($CD8).w,D0
            beq.b   .L1
            cmp.l   MinusOne,D0
            beq.b   .L1
            move.l  D0,-(SP)
            _DisposPixPat
.L1:
            move.l  (4,SP),($CD8).w
            bset    #7,SPMisc2
.L2:
            clr.l   -(SP)
            move.l  GrayRgn,-(SP)
            _PaintOne
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
.L3:
            subq.w  #4,SP
            move.w  #$10,-(SP)
            _GetPattern
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (A0)+,DeskPattern
            move.l  (A0),($A40).w
            bclr    #7,SPMisc2
            bra.b   .L2
SetWinColor:
            movem.l A2-A3,-(SP)
            movea.l AuxWinHead,A2
            lea     AuxWinHead,A3
            bsr.b   SetGuts_WindowMgr
            movea.l ($10,SP),A2
            btst    #$F,(6,A2)
            beq.b   .L3
            subq.w  #4,SP
            pea     (SP)
            _GetPort
            move.l  A2,-(SP)
            _SetPort
            movea.l ($10,SP),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmpi.w  #0,(8,A0,D1.w)
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            pea     ($A,A0,D1.w)
            _RGBBackColor
            _SetPort
.L3:
            tst.b   ($6E,A2)
            beq.b   SetCtlColor.L1
            move.l  A2,-(SP)
            move.l  ($72,A2),-(SP)
            _PaintOne
            bra.b   SetCtlColor.L1
SetCtlColor:
            movem.l A2-A3,-(SP)
            movea.l AuxCtlHead,A2
            lea     AuxCtlHead,A3
            bsr.b   SetGuts_WindowMgr
            movea.l ($10,SP),A0
            movea.l (A0),A1
            tst.b   ($10,A1)
            beq.b   .L1
            move.l  A0,-(SP)
            _Draw1Control
.L1:
            movem.l (SP)+,A2-A3
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
SetGuts_WindowMgr:
            link.w  A6,#0
            clr.l   -(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            pea     (6,SP)
            movea.l A2,A1
            bsr.w   GetAuxGuts
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            cmpa.l  ($14,A6),A0
            beq.b   .L4
            cmpi.l  #$FFFFFFFF,($14,A6)
            beq.b   .L2
            move.l  A0,-(SP)
            movea.l ($14,A6),A0
            movea.l (A0),A0
            cmpi.w  #$FFFF,(6,A0)
            movea.l (SP)+,A0
            beq.b   .L2
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  ($18,A6),-(SP)
            pea     (6,SP)
            movea.l A2,A1
            bsr.w   GetAuxGuts
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            beq.b   .L3
            movea.l (A0),A0
            move.l  ($14,A6),(8,A0)
.L1:
            unlk    A6
            rts
.L2:
            move.l  A0,($14,A6)
.L3:
            moveq   #$1C,D0
            _NewHandleClear
            move.l  A0,(A3)
            movea.l (A0),A0
            move.l  A2,(A0)
            move.l  ($14,A6),(8,A0)
            move.l  ($18,A6),D0
            _StripAddress
            move.l  D0,(4,A0)
            bra.b   .L1
.L4:
            movea.l A0,A2
            movea.l A3,A1
.L5:
            move.l  (A1),D1
            movea.l D1,A0
            beq.b   .L9
            movea.l (A0),A0
            move.l  (4,A0),D0
            cmp.l   ($18,A6),D0
            beq.b   .L6
            movea.l A0,A1
            bra.b   .L5
.L6:
            move.l  (A0),-(SP)
            movea.l (8,A0),A0
            _HGetState
            btst    #5,D0
            bne.b   .L7
            _DisposHandle
.L7:
            tst.b   MMU32bit
            beq.b   .L8
            movea.l D1,A0
            movea.l (A0),A0
            move.l  A2,(8,A0)
            addq.w  #4,SP
            bra.b   .L9
.L8:
            movea.l D1,A0
            _DisposHandle
            move.l  (SP)+,(A1)
.L9:
            bra.b   .L1
GetAuxWin:
            movea.l AuxWinHead,A1
            bra.b   GetAuxGuts
GetAuxCtl:
            movea.l AuxCtlHead,A1
GetAuxGuts:
            move.b  #1,($C,SP)
            move.l  (8,SP),D0
            _StripAddress
.L1:
            movea.l (A1),A0
            cmp.l   (4,A0),D0
            beq.b   .L2
            move.l  A1,D2
            move.l  (A0),D1
            movea.l D1,A1
            bne.b   .L1
            tst.l   D0
            beq.b   .L2
            clr.b   ($C,SP)
            movea.l D2,A1
.L2:
            movea.l (4,SP),A0
            move.l  A1,(A0)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
WMGREND:
            ds.b    6

            EVEN
