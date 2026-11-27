            include "Include/ROMHeader.s"

            EXPORT  GetCursor,GetIcon,GetMenu,GetNewControl,GetNewCWindow,GetNewMBar
            EXPORT  GetNewWindow,GetPattern,GetPicture,GetString

            IMPORT  A

            SECTION "GetMgr",CODE

GetPattern:
GMGR:
            move.l  #'PAT ',D0
.L1:
            subq.w  #4,SP
            move.l  D0,-(SP)
            move.w  ($C,SP),-(SP)
            _GetResource
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            addq.w  #2,SP
            move.l  D0,(SP)
            jmp     (A0)
GetCursor:
            move.l  #'CURS',D0
            move.w  #$FFFF,ROMMapInsert
            bra.b   GMGR.L1
GetString:
            move.l  #'STR ',D0
            bra.b   GMGR.L1
GetIcon:
            move.l  #'ICON',D0
            bra.b   GMGR.L1
GetPicture:
            move.l  #'PICT',D0
            bra.b   GMGR.L1
GetNewCWindow:
            link.w  A6,#-4
            move.w  #$FFFF,(-4,A6)
            bra.b   GetNewWindow.L1
GetNewWindow:
            link.w  A6,#-4
            clr.w   (-4,A6)
.L1:
            move.l  A3,-(SP)
            clr.l   ($12,A6)
            subq.w  #4,SP
            move.l  #'WIND',-(SP)
            move.w  ($10,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.w   .L6
            movea.l (A3),A0
            subq.w  #4,SP
            move.l  ($C,A6),-(SP)
            move.l  A0,-(SP)
            pea     ($12,A0)
            move.b  ($A,A0),(-1,A6)
            clr.w   -(SP)
            move.w  (8,A0),-(SP)
            move.l  (8,A6),-(SP)
            move.w  ($C,A0),-(SP)
            move.l  ($E,A0),-(SP)
            movea.l A3,A0
            _HLock
            tst.w   (-4,A6)
            beq.b   .L2
            _NewCWindow
            bra.b   .L3
.L2:
            _NewWindow
.L3:
            move.l  (SP)+,($12,A6)
            movea.l A3,A0
            _HUnlock
            _HPurge
            subq.w  #4,SP
            move.l  #'wctb',-(SP)
            move.w  ($10,A6),-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L4
            move.l  ($12,A6),-(SP)
            move.l  D0,-(SP)
            _SetWinColor
.L4:
            tst.b   (-1,A6)
            beq.b   .L6
            move.l  ($12,A6),-(SP)
            cmpi.l  #$FFFFFFFF,(8,A6)
            beq.b   .L5
            move.b  #1,-(SP)
            _ShowHide
            bra.b   .L6
.L5:
            _ShowWindow
.L6:
            movea.l (SP)+,A3
            unlk    A6
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
GetNewControl:
            link.w  A6,#-2
            move.l  A3,-(SP)
            clr.l   ($E,A6)
            subq.w  #4,SP
            move.l  #'CNTL',-(SP)
            move.w  ($C,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L2
            movea.l (A3),A0
            subq.w  #4,SP
            move.l  (8,A6),-(SP)
            move.l  A0,-(SP)
            pea     ($16,A0)
            lea     (8,A0),A1
            move.b  (2,A1),(-2,A6)
            clr.b   -(SP)
            move.w  (A1),-(SP)
            addq.w  #4,A1
            move.l  (A1)+,-(SP)
            move.w  (A1)+,-(SP)
            move.l  (A1)+,-(SP)
            movea.l A3,A0
            _HLock
            _NewControl
            move.l  (SP)+,($E,A6)
            movea.l A3,A0
            _HUnlock
            _HPurge
            subq.w  #4,SP
            move.l  #'cctb',-(SP)
            move.w  ($C,A6),-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L1
            move.l  ($E,A6),-(SP)
            move.l  D0,-(SP)
            _SetCtlColor
.L1:
            tst.b   (-2,A6)
            beq.b   .L2
            move.l  ($E,A6),-(SP)
            _ShowControl
.L2:
            movea.l (SP)+,A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
GetMenu:
            link.w  A6,#0
            move.l  A3,-(SP)
            move.w  ResLoad,-(SP)
            moveq   #0,D0
            bsr.w   DoTheGet
            beq.w   .L3
            move.l  (A3),D0
            beq.b   .L1
            clr.l   -(SP)
            movea.l (A3),A0
            move.l  (6,A0),-(SP)
            clr.l   -(SP)
            pea     (8,SP)
            clr.l   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResInfo
            move.l  (SP)+,D0
            cmpi.l  #'MDEF',D0
            beq.b   .L3
            bra.b   .L2
.L1:
            moveq   #1,D0
            bsr.b   DoTheGet
            beq.b   .L3
.L2:
            subq.w  #4,SP
            move.l  #'MDEF',-(SP)
            movea.l (A3),A0
            move.w  (6,A0),-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (A3),A0
            move.l  (SP)+,(6,A0)
            move.l  A3,-(SP)
            _CalcMenuSize
            move.b  #1,-(SP)
            _SetResLoad
            subq.w  #4,SP
            move.l  #'mctb',-(SP)
            move.w  (8,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L3
            movea.l A3,A0
            _HGetState
            move.b  D0,-(SP)
            _HLock
            movea.l (A3),A0
            move.w  (A0),-(SP)
            addq.w  #2,A0
            move.l  A0,-(SP)
            _SetMCEntries
            movea.l A3,A0
            move.b  (SP)+,D0
            _HSetState
.L3:
            _SetResLoad
            movea.l (SP)+,A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
DoTheGet:
            move.b  D0,-(SP)
            _SetResLoad
            subq.w  #4,SP
            move.l  #'MENU',-(SP)
            move.w  (8,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,($A,A6)
            rts
GetNewMBar:
            link.w  A6,#0
            movem.l D3/A3,-(SP)
            clr.l   ($A,A6)
            subq.w  #4,SP
            _GetMenuBar
            _ClearMenuBar
            subq.w  #4,SP
            move.l  #'MBAR',-(SP)
            move.w  (8,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L2
            moveq   #0,D3
.L1:
            subq.w  #4,SP
            movea.l (A3),A0
            move.w  D3,D0
            add.w   D0,D0
            move.w  (2,A0,D0.w),-(SP)
            _GetRMenu
            clr.w   -(SP)
            _InsertMenu
            movea.l (A3),A0
            addq.w  #1,D3
            cmp.w   (A0),D3
            blt.b   .L1
            subq.w  #4,SP
            _GetMenuBar
            move.l  (SP)+,($A,A6)
.L2:
            move.l  (SP),-(SP)
            _SetMenuBar
            movea.l (SP)+,A0
            _DisposHandle
            movem.l (SP)+,D3/A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
GETMGREND:
            dc.w    0

            EVEN
