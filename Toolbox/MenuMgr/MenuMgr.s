            include "Include/ROMHeader.s"

            EXPORT  AddResMenu,AppendMenu,CalcMenuSize,CheckItem,ClearMenuBar,CountMItems
            EXPORT  DeleteMenu,DelMCEntries,DelMenuItem,DisableItem,DispMCInfo,DisposeMenu
            EXPORT  DrawMenuBar,EnableItem,FlashMenuBar,GetItem,GETITEMCMD,GetItemIcon
            EXPORT  GetItemMark,GetItemStyle,GetMCEntry,GetMCInfo,GetMenuBar,GetMHandle
            EXPORT  HiliteMenu,InitMenus,InitProcMenu,InsertMenu,InsMenuItem,InsrtResMenu
            EXPORT  MenuChoice,MenuKey,MenuSelect,NewMenu,PlotIcon,PopUpMenuSelect
            EXPORT  SetItem,SETITEMCMD,SetItemIcon,SetItemMark,SetItemStyle,SetMCEntries
            EXPORT  SetMCInfo,SetMenuBar,SetMenuFlash,CalcMBHeight,CallMBarProc,DrawMBar

            IMPORT  SMGRCALCRECT,SwapIcon,A

            SECTION "MenuMgr",CODE

InitProcMenu:
MMGR:
            subq.w  #4,SP
            move.l  #'MBDF',-(SP)
            move.w  ($C,SP),-(SP)
            _GetResource
            move.l  (SP)+,($B58).w
            beq.b   .L2
            bsr.b   sub_40816D58
            movea.l MenuList,A1
            movea.l (A1),A1
            movea.l (SP)+,A0
            move.w  (SP)+,(4,A1)
.L1:
            jmp     (A0)
.L2:
            movea.l (SP)+,A0
            addq.w  #2,SP
            move.l  A0,-(SP)
            bsr.b   InitMenus
            movea.l (SP)+,A0
            bra.b   .L1
InitMenus:
            moveq   #0,D1
            move.w  #$FFFF,ROMMapInsert
sub_40816D58:
            subq.w  #4,SP
            move.l  #'MBDF',-(SP)
            move.w  D1,-(SP)
            _GetResource
            move.l  (SP)+,($B58).w
            bne.b   .L1
            tst.w   D1
            bne.b   InitMenus
            move.w  #$55,D0
            _SysError
.L1:
            tst.l   MenuList
            bgt.b   .L2
            move.l  #$FFFFFFFF,($B68).w
            bsr.b   sub_40816DC6
            move.l  A0,MenuList
            movea.l (A0),A0
            move.w  D1,(4,A0)
            clr.w   TheMenu
            move.l  A1,($D50).w
            bsr.b   sub_40816E12
            moveq   #$C,D0
            and.b   SPMisc2,D0
            lsr.w   #2,D0
            move.w  D0,MenuFlash
            clr.w   MBarEnable
            clr.l   MrMacHook
            clr.l   MenuHook
            moveq   #3,D0
            moveq   #0,D1
            bsr.w   CallMBarProc
            bsr.w   sub_40816E42
            _ClearMenuBar
            _DrawMenuBar
.L2:
            jsr     (SMGRCALCRECT.w,PC)
            rts
sub_40816DC6:
            moveq   #$1E,D0
            _NewHandle
            movea.l (A0),A1
            move.w  #$FF9D,(A1)
            move.l  A0,-(SP)
            moveq   #$C,D0
            _NewHandleClear
            movea.l (A0),A1
            move.w  #$A,(2,A1)
            movea.l (SP)+,A1
            rts
CalcMBHeight:
            moveq   #6,D0
            bsr.w   CallMBarProc
            rts
            move.l  D4,-(SP)
            jsr     sub_40816E02
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetFontInfo
            jsr     sub_40816E0C
            move.l  (SP)+,D0
            addq.w  #4,SP
            move.l  (SP)+,D4
            rts
sub_40816E02:
            movea.l (A5),A0
            move.l  (A0),D4
            move.l  WMgrPort,(A0)
            rts
sub_40816E0C:
            move.l  D4,-(SP)
            _SetPort
            rts
sub_40816E12:
            move.b  #1,-(SP)
            _SetResLoad
            subq.w  #4,SP
            move.l  #'mctb',-(SP)
            clr.w   -(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.b   .L1
            _HGetState
            move.b  D0,-(SP)
            move.l  A0,-(SP)
            _HLock
            movea.l (A0),A0
            move.w  (A0)+,-(SP)
            move.l  A0,-(SP)
            _SetMCEntries
            movea.l (SP)+,A0
            move.b  (SP)+,D0
            _HSetState
.L1:
            rts
sub_40816E42:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.b   ($E,A0)
            clr.b   ($F,A0)
            tst.w   ROM85
            bmi.b   .L1
            btst    #5,HWCfgFlags
            beq.b   .L1
            lea     ($E,A0),A0
            moveq   #1,D0
            swap    D0
            move.w  #$7E,D0
            _ReadXPRam
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            lea     ($F,A0),A0
            moveq   #1,D0
            swap    D0
            move.w  #$7F,D0
            _ReadXPRam
.L1:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            tst.b   ($E,A0)
            bne.b   .L2
            addq.b  #8,($E,A0)
            nop
.L2:
            tst.b   ($F,A0)
            bne.b   .L3
            addi.b  #$3C,($F,A0)
.L3:
            rts
ClearMenuBar:
            bsr.w   sub_40817162
            movea.l MenuList,A0
            _DisposHandle
            movea.l ($D50).w,A0
            _DisposHandle
            bsr.w   sub_40816DC6
            move.l  A0,MenuList
            move.l  A1,($D50).w
            bsr.w   sub_40816E12
            clr.w   TheMenu
            rts
InsertMenu:
            movem.l D3/A3-A4,-(SP)
            cmpi.w  #$FFFF,($10,SP)
            beq.b   .L1
            bsr.w   sub_40817162
            movea.l A0,A3
            movea.l ($12,SP),A0
            movea.l (A0),A0
            move.w  (A0),D1
            bsr.w   GETINDEX
            bne.b   .L4
            move.w  ($10,SP),D1
            bsr.w   GETINDEX
            bne.b   .L2
            move.w  (A3),D0
            addq.w  #6,D0
            bra.b   .L2
.L1:
            bsr.w   sub_4081717E
            movea.l A0,A3
            movea.l ($12,SP),A0
            movea.l (A0),A0
            moveq   #0,D1
            move.w  (A0),D1
            bsr.b   sub_40816F68
            bne.b   .L4
            addq.w  #6,(A3)
            move.l  MinusOne,D1
            bsr.b   sub_40816F68
            addq.w  #6,D0
.L2:
            moveq   #0,D3
            move.w  D0,D3
            clr.l   Scratch8
            clr.l   ($9FE).w
            lea     Scratch8,A0
            move.l  ($12,SP),(A0)
            cmpi.w  #$FFFF,($10,SP)
            beq.b   .L3
            bsr.w   GetA1List
            addq.w  #6,(A1)
.L3:
            subq.w  #4,SP
            move.l  MenuList,-(SP)
            move.l  D3,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            move.l  #6,-(SP)
            _Munger
            addq.w  #4,SP
            cmpi.w  #$FFFF,($10,SP)
            beq.b   .L4
            moveq   #2,D0
            moveq   #0,D1
            bsr.w   CallMBarProc
.L4:
            movem.l (SP)+,D3/A3-A4
.L5:
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
sub_40816F68:
            move.l  D3,-(SP)
            tst.l   D1
            beq.b   .L2
            bsr.w   GetA1List
            move.w  (A1),D2
            addq.w  #6,D2
            cmpi.l  #$FFFFFFFF,D1
            beq.b   .L3
            move.w  (0,A1,D2.w),D3
            beq.b   .L2
            add.w   D2,D3
            exg     D2,D3
.L1:
            movea.l (0,A1,D2.w),A0
            movea.l (A0),A0
            cmp.w   (A0),D1
            beq.b   .L3
            subq.w  #6,D2
            cmp.w   D2,D3
            bne.b   .L1
.L2:
            moveq   #0,D2
.L3:
            move.l  (SP)+,D3
            move.w  D2,D0
            rts
GETINDEX:
            tst.w   D1
            beq.b   .L2
            bsr.w   GetA1List
            move.w  (A1),D2
            beq.b   .L2
.L1:
            move.l  (0,A1,D2.w),D0
            movea.l D0,A0
            movea.l (A0),A0
            cmp.w   (A0),D1
            beq.b   .L3
            subq.w  #6,D2
            bne.b   .L1
.L2:
            moveq   #0,D2
.L3:
            move.w  D2,D0
            rts
DeleteMenu:
            move.w  TheMenu,D0
            cmp.w   (4,SP),D0
            bne.b   .L1
            clr.w   -(SP)
            _HiliteMenu
.L1:
            move.w  (4,SP),-(SP)
            move.w  #$FF9E,-(SP)
            _DelMCEntries
            moveq   #0,D1
            move.w  (4,SP),D1
            bsr.b   sub_40816F68
            bne.b   .L3
            bsr.b   GETINDEX
            beq.b   .L5
            bsr.w   GetA1List
            cmp.w   (A1),D0
            bne.b   .L2
            move.w  (4,A1,D0.w),(2,A1)
.L2:
            subq.w  #6,(A1)
            bra.b   .L4
.L3:
            bsr.w   sub_40817186
            subq.w  #6,(A1)
.L4:
            moveq   #0,D1
            move.w  D0,D1
            movea.l MenuList,A0
            movea.l (A0),A0
            adda.l  D1,A0
            subq.w  #4,SP
            move.l  MenuList,-(SP)
            move.l  D1,-(SP)
            move.l  A0,-(SP)
            moveq   #6,D0
            move.l  D0,-(SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
            _Munger
            addq.w  #4,SP
            moveq   #2,D0
            moveq   #0,D1
            bsr.w   CallMBarProc
.L5:
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
DelMCEntries:
            movem.l D2-D4,-(SP)
            move.w  ($10,SP),D3
            move.w  ($12,SP),D4
            moveq   #0,D2
.L1:
            move.w  D3,D0
            move.w  D4,D1
            movea.l ($D50).w,A0
            movea.l (A0),A0
            bsr.b   FindCEntry
            beq.b   .L2
            subq.w  #4,SP
            move.l  ($D50).w,-(SP)
            move.l  D2,-(SP)
            pea     (0,A0,D2.w)
            move.l  #$1E,-(SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
            _Munger
            addq.w  #4,SP
            cmpi.w  #$FF9E,D3
            beq.b   .L1
.L2:
            bsr.w   sub_40817A44
            movem.l (SP)+,D2-D4
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
FindCEntry:
            cmpi.w  #$FF9D,(0,A0,D2.w)
            beq.b   .L3
            cmpi.w  #$FF9F,D1
            beq.b   .L1
            cmp.w   (0,A0,D2.w),D1
            bne.b   .L2
.L1:
            cmpi.w  #$FF9E,D0
            beq.b   .L3
            cmp.w   (2,A0,D2.w),D0
            beq.b   .L3
.L2:
            addi.w  #$1E,D2
            bra.b   FindCEntry
.L3:
            cmpi.w  #$FF9D,(0,A0,D2.w)
            rts
DrawMBar:
            moveq   #0,D0
            moveq   #-1,D1
            bsr.w   CallMBarProc
            rts
DrawMenuBar:
            move.w  TheMenu,-(SP)
            clr.w   -(SP)
            _HiliteMenu
            bset    #7,AlarmSt
            moveq   #0,D0
            moveq   #0,D1
            bsr.w   CallMBarProc
            _HiliteMenu
            jsr     (SwapIcon.w,PC)
            rts
HiliteMenu:
            cmpi.w  #3,MBarHeight
            bgt.b   .L1
            bra.b   .L4
.L1:
            move.w  TheMenu,D1
            beq.b   .L2
            cmp.w   (4,SP),D1
            beq.b   .L3
            bsr.w   GETINDEX
            beq.b   .L2
            moveq   #0,D1
            move.w  D0,D1
            moveq   #5,D0
            bsr.w   CallMBarProc
.L2:
            move.w  (4,SP),D1
            bsr.w   GETINDEX
            beq.b   .L4
            swap    D0
            move.w  #1,D0
            swap    D0
            move.l  D0,D1
            moveq   #5,D0
            bsr.w   CallMBarProc
.L3:
            movea.l (SP)+,A0
            move.w  (SP)+,TheMenu
            jmp     (A0)
.L4:
            movea.l (SP)+,A0
            addq.l  #2,SP
            clr.w   TheMenu
            jmp     (A0)
EnableItem:
            bsr.b   ENABLEFETCH
            cmpi.w  #$1F,D0
            bhi.b   .L2
            bset    D0,D1
.L1:
            move.l  D1,($A,A0)
.L2:
            bra.w   InsertMenu.L5
ENABLEFETCH:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            move.w  (8,SP),D0
            move.l  ($A,A0),D1
            rts
DisableItem:
            bsr.b   ENABLEFETCH
            cmpi.w  #$1F,D0
            bhi.b   EnableItem.L2
            bclr    D0,D1
            bra.b   EnableItem.L1
GETMENUPTR:
            bsr.b   sub_40817162
            movea.l (0,A0,D5.w),A1
            tst.l   (A1)
            beq.b   GetA1List.L1
            movea.l (A1),A0
            rts
sub_40817162:
            movea.l MenuList,A0
            tst.l   (A0)
            beq.b   GetA1List.L1
            movea.l (A0),A0
            rts
GetA1List:
            movea.l MenuList,A1
            tst.l   (A1)
            beq.b   .L1
            movea.l (A1),A1
            rts
.L1:
            moveq   #$54,D0
            _SysError
sub_4081717E:
            bsr.b   sub_40817162
            adda.w  (A0),A0
            addq.w  #6,A0
            rts
sub_40817186:
            bsr.b   GetA1List
            adda.w  (A1),A1
            addq.w  #6,A1
            rts
MenuSelect:
            link.w  A6,#-$28
            movem.l D2-D7/A2-A4,-(SP)
            clr.w   -(SP)
            _HiliteMenu
            clr.l   ($C,A6)
            clr.l   MenuDisable
            pea     (-$C,A6)
            _GetPort
            movea.l ($D2C).w,A2
            move.l  A2,-(SP)
            _SetPort
            clr.w   D5
            clr.w   D4
            clr.w   (-$E,A6)
            bsr.w   sub_40817412
            clr.l   (-$1C,A6)
            clr.w   (-$1E,A6)
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.b  ($E,A0),(-$17,A6)
            move.b  ($F,A0),(-$18,A6)
            move.l  (8,A6),D3
            moveq   #$14,D0
            _NewHandle
            movea.l A0,A4
.L1:
            moveq   #1,D0
            move.l  D3,D1
            bsr.w   CallMBarProc
            tst.l   D0
            bmi.b   .L4
            beq.b   .L2
            move.w  D0,D5
            bsr.w   GETMENUPTR
            move.w  (A0),($C,A6)
            bra.b   .L3
.L2:
            clr.w   D5
            clr.w   ($C,A6)
.L3:
            cmp.w   D5,D4
            beq.b   .L4
            bsr.w   sub_40817452
            bmi.w   .L12
.L4:
            tst.w   D5
            beq.b   .L5
            bsr.w   sub_40817432
            bsr.w   sub_408174C4
            bsr.w   sub_408174EC
.L5:
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            beq.b   .L7
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP)+,D3
            move.l  MenuHook,D0
            beq.b   .L6
            movea.l D0,A0
            jsr     (A0)
.L6:
            bra.b   .L1
.L7:
            tst.w   D5
            beq.b   .L10
            bsr.w   GETMENUPTR
            move.w  ($E,A6),D0
            bsr.w   sub_40817928
            beq.b   .L8
            cmpi.b  #$1B,(1,A1)
            bne.b   .L8
            clr.w   ($E,A6)
            bra.b   .L9
.L8:
            bsr.w   FLASHFEEDBACK
.L9:
            bsr.w   sub_408176BA
.L10:
            tst.w   ($E,A6)
            bne.b   .L11
            clr.w   ($C,A6)
            move.w  (-$1E,A6),D0
            beq.b   .L11
            move.w  D5,D0
            bsr.w   sub_408178CA
            clr.w   (-$1E,A6)
.L11:
            move.w  (-$1E,A6),TheMenu
            tst.w   TheMenu
            bmi.b   .L14
            tst.w   MBarEnable
            bmi.b   .L14
.L12:
            movea.l A4,A0
            _DisposHandle
            move.l  (-$C,A6),-(SP)
            _SetPort
.L13:
            movem.l (SP)+,D2-D7/A2-A4
            unlk    A6
            move.l  (SP)+,(SP)
            moveq   #0,D1
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.w   (A0)
            rts
.L14:
            tst.w   MBarEnable
            bmi.b   .L15
            move.w  TheMenu,MBarEnable
            move.l  ($C,A6),-(SP)
            _SystemMenu
            clr.l   ($C,A6)
            clr.w   MBarEnable
            bra.b   .L16
.L15:
            move.l  ($C,A6),-(SP)
            _SystemMenu
            clr.l   ($C,A6)
.L16:
            bra.b   .L12
PopUpMenuSelect:
            move.w  (4,SP),D0
            move.l  (6,SP),D1
            move.l  (SP),(6,SP)
            addq.w  #6,SP
            link.w  A6,#-$2E
            movem.l D2-D7/A2-A4,-(SP)
            move.w  D0,(-$2A,A6)
            move.l  D1,(-$2E,A6)
            clr.l   ($C,A6)
            clr.l   MenuDisable
            subq.w  #2,SP
            _WaitMouseUp
            tst.b   (SP)+
            beq.w   .L10
            pea     (-$C,A6)
            _GetPort
            movea.l ($D2C).w,A2
            move.l  A2,-(SP)
            _SetPort
            clr.w   D5
            clr.w   D4
            clr.w   (-$E,A6)
            bsr.w   sub_40817412
            clr.l   (-$1C,A6)
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.b  ($E,A0),(-$17,A6)
            move.b  ($F,A0),(-$18,A6)
            moveq   #$14,D0
            _NewHandle
            movea.l A0,A4
            movea.l (8,A6),A0
            movea.l (A0),A0
            move.w  (A0),D1
            bsr.w   sub_40816F68
            move.w  D0,D4
            beq.w   .L10
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            move.l  ($22,A1),($10,A2)
            move.l  ($26,A1),($14,A2)
            bsr.w   DirtyHMenus
            move.l  (8,A6),-(SP)
            _CalcMenuSize
            move.w  D4,D5
            bsr.w   sub_408176C6
            move.w  MBarHeight,-(SP)
            clr.w   MBarHeight
.L1:
            moveq   #1,D0
            move.l  D3,D1
            bsr.w   CallMBarProc
            tst.l   D0
            bmi.b   .L2
            move.w  D0,D5
            bsr.w   GETMENUPTR
            move.w  (A0),($C,A6)
            cmp.w   D5,D4
            beq.b   .L2
            bsr.w   sub_40817452
            bmi.b   .L9
.L2:
            tst.w   D5
            beq.b   .L3
            bsr.w   sub_40817432
            bsr.w   sub_408174C4
            bsr.w   sub_408174EC
.L3:
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            beq.b   .L5
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP)+,D3
            move.l  MenuHook,D0
            beq.b   .L4
            movea.l D0,A0
            jsr     (A0)
.L4:
            bra.b   .L1
.L5:
            tst.w   D5
            beq.b   .L8
            bsr.w   GETMENUPTR
            move.w  ($E,A6),D0
            bsr.w   sub_40817928
            beq.b   .L6
            cmpi.b  #$1B,(1,A1)
            bne.b   .L6
            clr.w   ($E,A6)
            bra.b   .L7
.L6:
            bsr.w   FLASHFEEDBACK
.L7:
            bsr.w   sub_408176BA
.L8:
            tst.w   ($E,A6)
            bne.b   .L9
            clr.w   ($C,A6)
.L9:
            move.w  (SP)+,MBarHeight
            movea.l WMgrPort,A0
            move.l  ($10,A0),($10,A2)
            move.l  ($14,A0),($14,A2)
            bsr.w   DirtyHMenus
            bra.w   MenuSelect.L12
.L10:
            bra.w   MenuSelect.L13
sub_40817412:
            subq.w  #4,SP
            _TickCount
            move.l  (SP),(-$12,A6)
            moveq   #0,D0
            move.b  (-$17,A6),D0
            add.l   D0,(-$12,A6)
            move.l  (SP)+,(-$16,A6)
            move.b  (-$18,A6),D0
            add.l   D0,(-$16,A6)
            rts
sub_40817432:
            moveq   #9,D0
            moveq   #0,D1
            move.w  D5,D1
            bsr.w   CallMBarProc
            movea.l D0,A0
            move.l  (A0),(-8,A6)
            move.l  (4,A0),(-4,A6)
            moveq   #$B,D0
            move.w  D5,D1
            bsr.w   CallMBarProc
            rts
sub_40817452:
            clr.w   ($E,A6)
            tst.w   D4
            beq.b   .L2
            bsr.w   sub_40817162
            cmp.w   (A0),D5
            bgt.b   .L4
            tst.w   D5
            beq.b   .L1
            bsr.b   sub_40817432
.L1:
            bsr.w   sub_40817688
            bsr.b   sub_40817412
            cmpi.w  #4,(-$E,A6)
            beq.b   .L4
            move.w  D4,D0
            bsr.w   sub_408178CA
.L2:
            move.w  ($C,A6),(-$1E,A6)
            tst.w   D5
            beq.b   .L4
            move.w  D5,D0
            bsr.w   sub_408178CE
            move.l  MrMacHook,D0
            beq.b   .L3
            moveq   #9,D0
            moveq   #0,D1
            move.w  D5,D1
            bsr.w   CallMBarProc
            movea.l D0,A0
            move.l  (A0),(-8,A6)
            move.l  (4,A0),(-4,A6)
            movea.l MrMacHook,A0
            pea     (-8,A6)
            jsr     (A0)
            tst.w   D0
            beq.b   .L3
            move.w  #$FFFF,D5
            bra.b   .L4
.L3:
            bsr.w   sub_40817710
.L4:
            move.w  D5,D4
            rts
sub_408174C4:
            pea     (-8,A6)
            _ClipRect
            bsr.w   GETMENUPTR
            move.w  #1,-(SP)
            move.l  A1,-(SP)
            pea     (-8,A6)
            move.l  D3,-(SP)
            pea     ($E,A6)
            bsr.w   sub_40817788
            moveq   #$A,D0
            move.w  D5,D1
            bsr.w   CallMBarProc
            rts
sub_408174EC:
            bsr.w   GETMENUPTR
            move.w  ($E,A6),D0
            beq.b   .L1
            bsr.w   sub_40817928
            cmpi.b  #$1B,(1,A1)
            bne.b   .L1
            move.w  ($C,A6),D0
            cmp.w   (-$1A,A6),D0
            bne.b   .L1
            move.w  ($E,A6),D0
            cmp.w   (-$1C,A6),D0
            bne.b   .L1
            move.l  A1,-(SP)
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            cmp.l   (-$12,A6),D0
            blt.b   .L2
            moveq   #0,D1
            move.b  (2,A1),D1
            bsr.w   sub_40816F68
            beq.b   .L1
            move.w  D0,D5
            bsr.w   sub_40817710
            move.w  D5,(-$20,A6)
            move.w  D4,D5
            bsr.w   sub_40817432
            bsr.b   sub_4081755C
            bra.b   .L2
.L1:
            bsr.w   sub_40817688
            bsr.w   sub_40817412
.L2:
            move.w  ($E,A6),(-$1C,A6)
            move.w  ($C,A6),(-$1A,A6)
            rts
sub_4081755C:
            movem.l D4,-(SP)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP)+,D3
.L1:
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            beq.w   sub_40817634.L3
            moveq   #1,D0
            move.l  D3,D1
            bsr.w   CallMBarProc
            cmp.w   (-$20,A6),D0
            beq.w   sub_40817634.L3
            subq.w  #2,SP
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP),D3
            move.l  MenuHook,D0
            beq.b   .L2
            movea.l D0,A0
            jsr     (A0)
.L2:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            pea     (6,A0)
            _PtInRect
            move.b  (SP)+,D0
            bne.b   .L1
            moveq   #9,D0
            moveq   #0,D1
            move.w  (-$20,A6),D1
            bsr.w   CallMBarProc
            movea.l D0,A0
            move.l  (A0),D4
            move.w  (4,A0),D5
            swap    D5
            move.w  (2,A0),D5
            cmp.w   D3,D4
            bgt.b   .L3
            move.w  (6,A0),D4
            move.w  (6,A0),D5
.L3:
            bsr.w   sub_40817412
.L4:
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            beq.w   sub_40817634.L3
            subq.w  #2,SP
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP),D6
            move.l  MenuHook,D0
            beq.b   .L5
            movea.l D0,A0
            jsr     (A0)
.L5:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            pea     (6,A0)
            _PtInRect
            move.b  (SP)+,D0
            bne.w   .L1
            moveq   #1,D0
            move.l  D6,D1
            bsr.w   CallMBarProc
            cmp.w   (-$20,A6),D0
            beq.b   sub_40817634.L3
            cmp.w   D3,D4
            blt.b   sub_40817634.L1
            cmp.w   D3,D6
            blt.b   sub_40817634.L3
            move.l  D6,D1
            move.l  D3,D0
            bsr.b   sub_40817634
            move.w  D0,D7
            move.l  D4,D1
            move.l  D3,D0
            bsr.b   sub_40817634
            cmp.w   D0,D7
            blt.b   sub_40817634.L3
            move.l  D5,D1
            move.l  D3,D0
            bsr.b   sub_40817634
            cmp.w   D0,D7
            bgt.b   sub_40817634.L3
            bra.b   sub_40817634.L2
sub_40817634:
            lea     (-$A,SP),SP
            move.l  D1,-(SP)
            move.l  D0,-(SP)
            _DeltaPoint
            _FixRatio
            _AngleFromSlope
            move.w  (SP)+,D0
            rts
.L1:
            cmp.w   D3,D6
            bgt.b   .L3
            move.l  D3,D1
            move.l  D6,D0
            bsr.b   sub_40817634
            move.w  D0,D7
            move.l  D3,D1
            move.l  D4,D0
            bsr.b   sub_40817634
            cmp.w   D0,D7
            bgt.b   .L3
            move.l  D3,D1
            move.l  D5,D0
            bsr.b   sub_40817634
            cmp.w   D0,D7
            blt.b   .L3
.L2:
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,D0
            cmp.l   (-$16,A6),D0
            bge.b   .L3
            bra.w   sub_4081755C.L4
.L3:
            movem.l (SP)+,D4
            move.w  D4,D5
            rts
sub_4081767E:
            subq.w  #4,(-$E,A6)
            moveq   #8,D0
            bra.w   CallMBarProc
sub_40817688:
            movea.l (A4),A0
            move.w  (-$E,A6),D0
            beq.b   .L3
            cmp.w   (-4,A0,D0.w),D5
            beq.b   .L3
.L1:
            movea.l (A4),A0
            move.w  (-$E,A6),D0
            beq.b   .L3
            cmp.w   (-4,A0,D0.w),D5
            beq.b   .L2
            move.w  (-2,A0,D0.w),($E,A6)
            bsr.b   sub_4081767E
            bra.b   .L1
.L2:
            tst.w   (-$E,A6)
            beq.b   .L3
            bsr.w   sub_408174C4
.L3:
            rts
sub_408176BA:
            tst.w   (-$E,A6)
            beq.b   .L1
            bsr.b   sub_4081767E
            bra.b   sub_408176BA
.L1:
            rts
sub_408176C6:
            addq.w  #4,(-$E,A6)
            move.w  (-$E,A6),D0
            movea.l (A4),A0
            move.w  D5,(-4,A0,D0.w)
            move.w  ($E,A6),(-2,A0,D0.w)
            move.w  #3,-(SP)
            bsr.w   GETMENUPTR
            move.l  A1,-(SP)
            pea     (-8,A6)
            move.l  (-$2E,A6),-(SP)
            pea     (-$2A,A6)
            bsr.w   sub_40817788
            moveq   #7,D0
            swap    D0
            move.w  D5,D0
            swap    D0
            lea     (-8,A6),A0
            move.l  A0,D1
            bsr.w   CallMBarProc
            move.w  (-$2A,A6),($A0A).w
            bsr.b   sub_40817768
            rts
sub_40817710:
            cmpi.w  #$14,(-$E,A6)
            beq.b   .L2
            addq.w  #4,(-$E,A6)
            move.w  (-$E,A6),D0
            movea.l (A4),A0
            move.w  D5,(-4,A0,D0.w)
            move.w  ($E,A6),(-2,A0,D0.w)
            moveq   #0,D1
            cmpi.w  #4,(-$E,A6)
            beq.b   .L1
            move.l  D3,D1
.L1:
            moveq   #9,D0
            move.w  D5,D1
            bsr.w   CallMBarProc
            movea.l D0,A0
            move.l  (A0),(-8,A6)
            move.l  (4,A0),(-4,A6)
            moveq   #7,D0
            swap    D0
            move.w  D5,D0
            swap    D0
            lea     (-8,A6),A0
            move.l  A0,D1
            bsr.w   CallMBarProc
            move.w  (-8,A6),($A0A).w
            bsr.b   sub_40817768
.L2:
            rts
sub_40817768:
            pea     (-8,A6)
            _ClipRect
            clr.w   -(SP)
            bsr.w   GETMENUPTR
            move.l  A1,-(SP)
            pea     (-8,A6)
            subq.w  #8,SP
            bsr.b   sub_40817788
            moveq   #$A,D0
            move.w  D5,D1
            bsr.w   CallMBarProc
            rts
sub_40817788:
            move.l  (6,A0),D1
            beq.b   .L1
            link.w  A6,#0
            move.l  A3,-(SP)
            lea     (-$12,SP),SP
            lea     (8,A6),A0
            movea.l SP,A1
            moveq   #$12,D0
            _BlockMove
            movea.l D1,A0
            movea.l A0,A3
            move.l  A0,-(SP)
            _LoadResource
            _HLock
            movea.l (A0),A0
            jsr     (A0)
            movea.l A3,A0
            _HUnlock
            movea.l (SP)+,A3
            unlk    A6
.L1:
            movea.l (SP)+,A0
            lea     ($12,SP),SP
            jmp     (A0)
FLASHFEEDBACK:
            move.w  D4,-(SP)
            move.w  MenuFlash,D4
            beq.b   .L2
            move.w  ($E,A6),ToolScratch
            beq.b   .L2
            pea     (-8,A6)
            _ClipRect
.L1:
            moveq   #0,D1
            bsr.b   CALLCHOOSE
            move.l  D3,D1
            bsr.b   CALLCHOOSE
            subq.w  #1,D4
            bne.b   .L1
            bsr.b   FullClip
.L2:
            move.w  (SP)+,D4
            rts
FullClip:
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            _SetClip
            rts
CALLCHOOSE:
            move.w  #1,-(SP)
            bsr.w   GETMENUPTR
            move.l  A1,-(SP)
            pea     (-8,A6)
            move.l  D1,-(SP)
            pea     ToolScratch
            bsr.b   sub_40817788
            movea.w #3,A0
            _Delay
            rts
MenuChoice:
            move.l  MenuDisable,(4,SP)
            rts
GetMenuBar:
            movea.l MenuList,A0
            move.l  A0,(4,SP)
            beq.b   .L1
            _HandToHand
            move.l  A0,(4,SP)
            movea.l (A0),A0
            move.w  (A0),D0
            clr.l   (8,A0,D0.w)
.L1:
            rts
GetMCInfo:
            movea.l ($D50).w,A0
            _HandToHand
            beq.b   .L1
            suba.l  A0,A0
.L1:
            move.l  A0,(4,SP)
            rts
SetMenuBar:
            clr.w   -(SP)
            _HiliteMenu
            movea.l MenuList,A0
            _DisposHandle
            movea.l (4,SP),A0
            move.l  (SP)+,(SP)
            _HandToHand
            move.l  A0,MenuList
            rts
SetMCInfo:
            movea.l (4,SP),A0
            move.l  (SP)+,(SP)
            _HandToHand
            bne.b   .L1
            movea.l ($D50).w,A1
            move.l  A0,($D50).w
            movea.l A1,A0
            _DisposHandle
            bsr.w   sub_40817A44
.L1:
            rts
DisposeMenu:
            movea.l (4,SP),A0
            _HGetState
            btst    #5,D0
            beq.b   .L1
            move.l  A0,-(SP)
            _ReleaseResource
            bra.b   .L2
.L1:
            _DisposHandle
.L2:
            move.l  (SP)+,(SP)
            rts
DispMCInfo:
            movea.l (4,SP),A0
            _DisposHandle
            move.l  (SP)+,(SP)
            rts
FlashMenuBar:
            tst.w   (4,SP)
            beq.b   .L2
            move.w  TheMenu,D0
            beq.b   .L1
            cmp.w   (4,SP),D0
            bne.b   .L1
            move.w  (4,SP),D1
            bsr.w   GETINDEX
            beq.b   .L3
            bsr.b   sub_408178CA
            clr.w   TheMenu
            bra.w   DeleteMenu.L5
.L1:
            bra.w   HiliteMenu
.L2:
            moveq   #0,D0
            bsr.b   sub_408178CE
.L3:
            bra.w   DeleteMenu.L5
sub_408178CA:
            moveq   #0,D1
            bra.b   sub_408178CE.L1
sub_408178CE:
            moveq   #1,D1
.L1:
            swap    D1
            move.w  D0,D1
            moveq   #5,D0
CallMBarProc:
            movem.l D4,-(SP)
            clr.l   -(SP)
            movea.l MenuList,A0
            movea.l (A0),A0
            move.w  (4,A0),-(SP)
            andi.w  #7,(SP)
            move.w  D0,-(SP)
            swap    D0
            move.w  D0,-(SP)
            move.l  D1,-(SP)
            subq.w  #4,SP
            move.l  #'MBDF',-(SP)
            move.w  (4,A0),-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,($B58).w
            movea.l ($B58).w,A0
            _HGetState
            move.l  D0,D4
            _HLock
            movea.l (A0),A0
            jsr     (A0)
            movea.l ($B58).w,A0
            move.l  D4,D0
            _HSetState
            move.l  (SP)+,D0
            movem.l (SP)+,D4
            rts
sub_40817928:
            tst.w   D0
            ble.b   .L2
            moveq   #0,D1
            lea     ($E,A0),A1
            move.b  (A1)+,D1
            adda.w  D1,A1
.L1:
            subq.w  #1,D0
            beq.b   .L3
            move.b  (A1),D1
            beq.b   .L2
            addq.w  #5,D1
            adda.w  D1,A1
            bra.b   .L1
.L2:
            move.l  A1,D1
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
.L4:
            movea.l (8,SP),A0
            movea.l (A0),A0
            move.w  (6,SP),D0
            bsr.b   sub_40817928
            beq.b   .L5
            move.b  (5,SP),(0,A1,D2.w)
            subq.w  #2,D2
            beq.b   .L5
            move.l  (8,SP),-(SP)
            bsr.w   sub_40817D22
.L5:
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
.L6:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            move.w  (8,SP),D0
            bsr.b   sub_40817928
            movea.l (4,SP),A0
            clr.b   (A0)
            move.l  A1,D0
            beq.b   .L7
            move.b  (0,A1,D2.w),(1,A0)
.L7:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
GetItemIcon:
            moveq   #0,D2
            bra.b   sub_40817928.L6
SetItemIcon:
            moveq   #0,D2
            bra.b   sub_40817928.L4
GETITEMCMD:
            moveq   #1,D2
            bra.b   sub_40817928.L6
SETITEMCMD:
            moveq   #1,D2
            bra.b   sub_40817928.L4
GetItemStyle:
            moveq   #3,D2
            bra.b   sub_40817928.L6
SetItemStyle:
            moveq   #3,D2
            bra.b   sub_40817928.L4
GetItemMark:
            moveq   #2,D2
            bra.b   sub_40817928.L6
SetItemMark:
            moveq   #2,D2
            bra.b   sub_40817928.L4
CheckItem:
            tst.b   (4,SP)
            beq.b   .L1
            move.w  #$12,(4,SP)
            bra.b   SetItemMark
.L1:
            clr.w   (4,SP)
            bra.b   SetItemMark
sub_408179D8:
            move.b  D0,-(SP)
            movea.l SP,A0
            moveq   #1,D0
            _UpperString immed
            move.b  (SP)+,D0
            rts
SetMCEntries:
            movem.l D2-D3,-(SP)
            move.w  ($10,SP),D3
            subq.w  #1,D3
            mulu.w  #$1E,D3
.L1:
            movea.l ($C,SP),A1
            movea.l ($D50).w,A0
            movea.l (A0),A0
            move.w  (0,A1,D3.w),D1
            move.w  (2,A1,D3.w),D0
            moveq   #0,D2
            bsr.w   FindCEntry
            beq.b   .L2
            adda.l  D3,A1
            adda.l  D2,A0
            exg     A0,A1
            moveq   #$1E,D0
            _BlockMove
            bra.b   .L3
.L2:
            subq.w  #4,SP
            move.l  ($D50).w,-(SP)
            move.l  D2,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (0,A1,D3.w)
            move.l  #$1E,-(SP)
            _Munger
            addq.w  #4,SP
.L3:
            subi.w  #$1E,D3
            bge.b   .L1
            bsr.b   sub_40817A44
            movem.l (SP)+,D2-D3
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
sub_40817A44:
            link.w  A6,#-$E
            move.l  D2,-(SP)
            bsr.w   sub_40817B2A
            movea.l ($D50).w,A0
            movea.l (A0),A0
            clr.w   D0
            clr.w   D1
            clr.w   D2
            bsr.w   FindCEntry
            bne.b   .L1
            moveq   #-1,D0
            move.l  D0,(-6,A6)
            move.w  D0,(-2,A6)
            bra.b   .L2
.L1:
            move.l  ($16,A0,D2.w),(-6,A6)
            move.w  ($1A,A0,D2.w),(-2,A6)
.L2:
            addq.w  #1,($1C,A0,D2.w)
            clr.w   (-$E,A6)
.L3:
            clr.w   D0
            move.w  #$FF9F,D1
            move.w  (-$E,A6),D2
            bsr.w   FindCEntry
            beq.b   .L6
            move.w  D2,(-$E,A6)
            addi.w  #$1E,(-$E,A6)
            addq.w  #1,($1C,A0,D2.w)
            tst.w   (0,A0,D2.w)
            beq.b   .L3
            move.l  (-6,A6),($A,A0,D2.w)
            move.w  (-2,A6),($E,A0,D2.w)
            move.l  ($16,A0,D2.w),(-$C,A6)
            move.w  ($1A,A0,D2.w),(-8,A6)
            move.w  (0,A0,D2.w),D1
            move.w  #$FF9E,D0
            clr.w   D2
.L4:
            bsr.w   FindCEntry
            beq.b   .L3
            addq.w  #1,($1C,A0,D2.w)
            tst.w   (2,A0,D2.w)
            beq.b   .L5
            move.l  (-$C,A6),($16,A0,D2.w)
            move.w  (-8,A6),($1A,A0,D2.w)
.L5:
            addi.w  #$1E,D2
            bra.b   .L4
.L6:
            clr.w   D0
            clr.w   D1
            clr.w   D2
            bsr.w   FindCEntry
            bne.b   .L7
            moveq   #-1,D0
            move.l  D0,(-$C,A6)
            move.w  D0,(-8,A6)
            bra.b   .L8
.L7:
            move.l  ($A,A0,D2.w),(-$C,A6)
            move.w  ($E,A0,D2.w),(-8,A6)
.L8:
            clr.w   D2
.L9:
            bsr.b   sub_40817B46
            beq.b   .L10
            move.l  (-$C,A6),($16,A0,D2.w)
            move.w  (-8,A6),($1A,A0,D2.w)
            addi.w  #$1E,D2
            bra.b   .L9
.L10:
            move.l  (SP)+,D2
            unlk    A6
            rts
sub_40817B2A:
            movea.l ($D50).w,A0
            movea.l (A0),A0
            clr.w   D2
.L1:
            cmpi.w  #$FF9D,(0,A0,D2.w)
            beq.b   .L2
            clr.w   ($1C,A0,D2.w)
            addi.w  #$1E,D2
            bra.b   .L1
.L2:
            rts
sub_40817B46:
            cmpi.w  #$FF9D,(0,A0,D2.w)
            beq.b   .L2
            tst.w   ($1C,A0,D2.w)
            beq.b   .L1
            addi.w  #$1E,D2
            bra.b   sub_40817B46
.L1:
            moveq   #1,D0
.L2:
            rts
GetMCEntry:
            move.l  D2,-(SP)
            movea.l ($D50).w,A0
            movea.l (A0),A0
            move.w  (8,SP),D0
            move.w  ($A,SP),D1
            clr.w   D2
            bsr.w   FindCEntry
            beq.b   .L1
            lea     (0,A0,D2.w),A0
            move.l  A0,($C,SP)
            bra.b   .L2
.L1:
            clr.l   ($C,SP)
.L2:
            move.l  (SP)+,D2
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
MenuKey:
            link.w  A6,#-$C
            movem.l D3-D6/A3,-(SP)
            move.b  (9,A6),D0
            bsr.w   sub_408179D8
            move.b  D0,D4
            bsr.w   sub_40817162
            move.w  (A0),D5
            clr.w   D6
.L1:
            bsr.w   GETMENUPTR
            movea.l A0,A3
            btst    #0,($D,A3)
            beq.b   .L5
            moveq   #1,D3
.L2:
            move.l  ($A,A3),D0
            btst    D3,D0
            beq.b   .L4
            movea.l A3,A0
            move.w  D3,D0
            bsr.w   sub_40817928
            beq.b   .L5
            move.b  (1,A1),D0
            bsr.w   sub_408179D8
            cmpi.b  #$1B,D0
            blt.b   .L3
            cmpi.b  #$1F,D0
            bhi.b   .L3
            bra.b   .L4
.L3:
            cmp.b   D0,D4
            beq.b   .L8
.L4:
            addq.w  #1,D3
            bra.b   .L2
.L5:
            subq.w  #6,D5
            cmp.w   D6,D5
            bgt.b   .L1
            tst.w   D6
            bne.b   .L6
            bsr.w   sub_4081717E
            move.w  (A0),D5
            beq.b   .L6
            move.l  MinusOne,D1
            bsr.w   sub_40816F68
            add.w   D0,D5
            move.w  D0,D6
            bra.b   .L1
.L6:
            clr.l   ($A,A6)
.L7:
            movem.l (SP)+,D3-D6/A3
            unlk    A6
            bra.w   DeleteMenu.L5
.L8:
            bsr.w   GETMENUPTR
            move.w  (A0),($A,A6)
            move.w  D3,($C,A6)
            move.w  ($A,A6),(-8,A6)
            tst.w   D6
            beq.b   .L9
            clr.w   (-$A,A6)
            moveq   #8,D4
            bsr.b   sub_40817C6C
.L9:
            move.w  (-8,A6),-(SP)
            _HiliteMenu
            tst.w   MBarEnable
            bmi.b   .L10
            tst.w   TheMenu
            bpl.b   .L7
.L10:
            tst.w   MBarEnable
            bmi.b   .L11
            move.w  TheMenu,MBarEnable
            move.l  ($A,A6),-(SP)
            _SystemMenu
            clr.l   ($A,A6)
            clr.w   MBarEnable
            bra.b   .L7
.L11:
            move.l  ($A,A6),-(SP)
            _SystemMenu
            clr.l   ($A,A6)
            bra.b   .L7
sub_40817C6C:
            subq.w  #1,D4
            beq.b   .L5
            bsr.w   sub_4081717E
            move.w  (A0),D5
            move.l  MinusOne,D1
            bsr.w   sub_40816F68
            add.w   D0,D5
            move.w  D0,D6
.L1:
            bsr.w   GETMENUPTR
            movea.l A0,A3
            moveq   #1,D3
.L2:
            movea.l A3,A0
            move.l  D3,D0
            bsr.w   sub_40817928
            beq.b   .L4
            cmpi.b  #$1B,(1,A1)
            bne.b   .L3
            moveq   #0,D1
            move.b  (2,A1),D1
            cmp.w   (-8,A6),D1
            bne.b   .L3
            move.w  (A3),(-8,A6)
            tst.w   (-$A,A6)
            beq.b   sub_40817C6C
            bra.b   .L7
.L3:
            addq.w  #1,D3
            bra.b   .L2
.L4:
            subq.w  #6,D5
            cmp.w   D6,D5
            bgt.b   .L1
            tst.w   (-$A,A6)
            beq.b   .L6
            bra.b   .L7
.L5:
            move.w  #$56,D0
            _SysError
.L6:
            addq.w  #1,(-$A,A6)
            bsr.w   sub_40817162
            move.w  (A0),D5
            clr.w   D6
            bra.b   .L1
.L7:
            rts
GetItem:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            move.w  (8,SP),D0
            bsr.w   sub_40817928
            movea.l (4,SP),A1
            beq.b   .L2
            moveq   #0,D0
            move.b  (A0),D0
            addq.w  #1,D0
            _BlockMove
.L1:
            bra.w   sub_40817928.L7
.L2:
            clr.b   (A1)
            bra.b   .L1
DirtyHMenus:
            bsr.w   sub_4081717E
            move.w  (A0),D5
            move.l  MinusOne,D1
            bsr.w   sub_40816F68
            add.w   D0,D5
            move.w  D0,D6
.L1:
            bsr.w   GETMENUPTR
            move.l  A1,-(SP)
            bsr.b   sub_40817D22
            subq.w  #6,D5
            cmp.w   D6,D5
            bgt.b   .L1
            rts
sub_40817D22:
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  #$FFFFFFFF,(2,A0)
            bra.b   CalcMenuSize.L1
CalcMenuSize:
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l ($D2C).w,A1
            move.l  A1,-(SP)
            _SetPort
            move.w  #2,-(SP)
            movea.l ($A,SP),A0
            move.l  A0,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            movea.l (A0),A0
            bsr.w   sub_40817788
            _SetPort
.L1:
            move.l  (SP)+,(SP)
            rts
            movea.l (A3),A0
            move.l  ($A,A0),D0
            btst    D4,D0
            beq.b   .L2
            btst    #0,D0
.L2:
            rts
NewMenu:
            moveq   #0,D1
            moveq   #$10,D0
            movea.l (4,SP),A0
            move.b  (A0),D1
            add.w   D1,D0
            _NewHandle
            move.l  A0,($A,SP)
            movea.l (A0),A1
            move.w  D1,-(SP)
            move.w  ($A,SP),(A1)+
            clr.l   (A1)+
            moveq   #0,D0
            subq.w  #4,SP
            move.l  #'MDEF',-(SP)
            move.w  D0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (SP)+,A0
            movea.l ($C,SP),A1
            movea.l (A1),A1
            addq.w  #6,A1
            move.l  A0,(A1)+
            move.l  MinusOne,(A1)+
            move.w  (SP)+,D1
            movea.l (4,SP),A0
.L1:
            move.b  (A0)+,(A1)+
            dbra    D1,.L1
            clr.b   (A1)+
            bra.w   InsertMenu.L5
AppendMenu:
            movea.l (SP)+,A0
            move.w  #$3E7,-(SP)
            move.l  A0,-(SP)
InsMenuItem:
            link.w  A6,#-$11C
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($A,A6),A4
            movea.l ($E,A6),A3
            move.w  (8,A6),D6
            addq.w  #1,D6
            bsr.b   sub_40817DE8
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            bra.w   sub_40817928.L7
sub_40817DE8:
            bsr.b   sub_40817E16
            moveq   #0,D3
            bra.b   .L2
.L1:
            subq.l  #2,SP
            move.l  A4,-(SP)
            move.w  D3,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            move.w  (SP)+,D2
            move.b  (0,A4,D3.w),D0
            bsr.b   APPENDCHAR
.L2:
            addq.l  #1,D3
            cmp.b   (A4),D3
            bls.b   .L1
            bsr.w   sub_40817EC4
            move.l  A3,-(SP)
            bsr.w   sub_40817D22
            rts
sub_40817E16:
            lea     (-$118,A6),A0
            clr.l   (A0)+
            clr.l   (A0)
            rts
.L1:
            dc.w    $5E2F,$213C,$0D3B,$281B
.L2:
            dc.w    $4249,$554F,$5300
APPENDCHAR:
            moveq   #0,D1
            move.b  (-$114,A6),D1
            beq.b   .L6
            cmpi.b  #1,D1
            bne.b   .L1
            subi.w  #$30,D0
.L1:
            cmpi.b  #4,D1
            bne.b   .L4
            moveq   #4,D2
.L2:
            cmp.b   sub_40817E16.L2(PC,D2.w),D0
            beq.b   .L3
            dbra    D2,.L2
            rts
.L3:
            lea     (-$119,A6),A0
            move.b  (0,A0,D1.w),D0
            bset    D2,D0
.L4:
            lea     (-$119,A6),A0
            cmpi.w  #8,D1
            bne.b   .L5
            move.w  #2,D1
            move.b  #$1B,(0,A0,D1.w)
            move.w  #3,D1
.L5:
            move.b  D0,(0,A0,D1.w)
            clr.b   (-$114,A6)
            rts
.L6:
            tst.w   D2
            bne.b   .L8
            lea     sub_40817E16.L1,A0
            moveq   #7,D1
.L7:
            cmp.b   (0,A0,D1.w),D0
            beq.b   .L9
            dbra    D1,.L7
.L8:
            move.w  (-$112,A6),D1
            lea     (-$110,A6),A0
            move.b  D0,(0,A0,D1.w)
            addq.w  #1,(-$112,A6)
            rts
.L9:
            cmpi.w  #3,D1
            ble.b   .L10
            cmpi.w  #7,D1
            bne.b   .L11
.L10:
            addq.w  #1,D1
            move.b  D1,(-$114,A6)
            rts
.L11:
            subq.w  #6,D1
            bne.b   sub_40817EC4
            st      (-$113,A6)
            rts
sub_40817EC4:
            move.w  (-$112,A6),D0
            beq.b   .L1
            bsr.b   InsertTheItem
            bsr.w   sub_40817E16
.L1:
            rts
GetGoodIndex:
            move.w  D6,D5
            subq.w  #2,SP
            move.l  A3,-(SP)
            _CountMItems
            move.w  (SP)+,D0
            addq.w  #1,D0
            cmp.w   D0,D5
            ble.b   .L1
            move.w  D0,D5
.L1:
            rts
InsertTheItem:
            bsr.b   GetGoodIndex
            move.w  D5,D0
            movea.l (A3),A0
            bsr.w   sub_40817928
            beq.b   .L1
            move.l  A0,D1
            movea.l (A3),A0
            bsr.b   InsertEnableBit
.L1:
            lea     (-$110,A6),A0
            movea.l A0,A2
            move.w  (-$112,A6),D2
            adda.w  D2,A0
            lea     (-$118,A6),A1
            moveq   #3,D0
.L2:
            move.b  (A1)+,(A0)+
            dbra    D0,.L2
            subq.w  #1,A2
            addq.w  #5,D2
            ext.l   D2
            movea.l D1,A1
            suba.l  (A3),A1
            subq.w  #4,SP
            move.l  A3,-(SP)
            move.l  A1,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            _Munger
            addq.w  #4,SP
            tst.b   (-$113,A6)
            beq.b   .L3
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            bsr.w   DisableItem
.L3:
            rts
InsertEnableBit:
            cmpi.w  #$1F,D5
            bhi.b   .L1
            move.l  ($A,A0),D2
            ror.l   D5,D2
            move.w  D5,D0
            subi.w  #$20,D0
            neg.w   D0
            roxr.l  D0,D2
            move.l  D2,($A,A0)
.L1:
            rts
GetMHandle:
            clr.l   (6,SP)
            moveq   #0,D1
            move.w  (4,SP),D1
            bsr.w   sub_40816F68
            bne.b   .L1
            bsr.w   GETINDEX
            beq.b   .L2
.L1:
            move.w  D5,-(SP)
            move.w  D0,D5
            bsr.w   GETMENUPTR
            move.w  (SP)+,D5
            move.l  A1,(6,SP)
.L2:
            bra.w   DeleteMenu.L5
DelMenuItem:
            move.l  (SP),-(SP)
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($1E,SP),A3
            movea.l (A3),A0
            move.w  (A0),-(SP)
            move.w  ($1E,SP),-(SP)
            _DelMCEntries
            movea.l ($1E,SP),A3
            movea.l (A3),A0
            move.w  ($1C,SP),D0
            cmpi.w  #$1F,D0
            bhi.b   .L1
            move.l  ($A,A0),D1
            move.w  D0,D2
            subi.w  #$20,D2
            neg.w   D2
            roxl.l  D2,D1
            rol.l   D0,D1
            move.l  D1,($A,A0)
.L1:
            bsr.w   sub_40817928
            beq.b   SetItem.L2
            moveq   #5,D4
            moveq   #0,D2
            movea.l D2,A2
            bra.b   SetItem.L1
SetItem:
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($1E,SP),A3
            move.w  ($1C,SP),D3
            movea.l ($18,SP),A2
            move.w  D3,D0
            movea.l (A3),A0
            bsr.w   sub_40817928
            beq.b   .L2
            moveq   #1,D4
            moveq   #1,D2
            add.b   (A2),D2
.L1:
            movea.l A0,A4
            suba.l  (A3),A4
            add.b   (A0),D4
            subq.w  #4,SP
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            clr.l   -(SP)
            move.l  D4,-(SP)
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            _Munger
            addq.w  #4,SP
            move.l  A3,-(SP)
            bsr.w   sub_40817D22
.L2:
            movem.l (SP)+,D3-D4/A2-A4
            bra.w   sub_40817928.L7
SetMenuFlash:
            move.w  (4,SP),MenuFlash
            bra.w   DeleteMenu.L5
AddResMenu:
            movea.l (SP)+,A0
            move.w  #$3E7,-(SP)
            move.l  A0,-(SP)
InsrtResMenu:
            cmpi.l  #'FONT',(6,SP)
            bne.b   .L1
            move.b  #$44,(9,SP)
.L1:
            clr.w   D0
            cmpi.l  #'FONT',(6,SP)
            beq.b   .L2
            cmpi.l  #'FOND',(6,SP)
            bne.b   .L3
.L2:
            moveq   #1,D0
.L3:
            link.w  A6,#-$11C
            movem.l D3-D7/A2-A4,-(SP)
            move.w  D0,(-$11C,A6)
            move.w  ResLoad,-(SP)
            clr.w   ResLoad
            bsr.w   sub_40817E16
            movea.l ($E,A6),A3
            move.w  (8,A6),D6
            addq.w  #1,D6
            bsr.w   GetGoodIndex
            move.w  D5,D7
.L4:
            subq.w  #2,SP
            move.l  ($A,A6),-(SP)
            _CountResources
            move.w  (SP)+,D4
            beq.w   .L10
            moveq   #1,D3
.L5:
            subq.w  #4,SP
            move.l  ($A,A6),-(SP)
            move.w  D3,-(SP)
            _GetIndResource
            lea     (-$111,A6),A4
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  A4,-(SP)
            _GetResInfo
            tst.b   (A4)
            beq.w   .L9
            cmpi.b  #$2E,(1,A4)
            beq.w   .L9
            cmpi.b  #$25,(1,A4)
            beq.w   .L9
            move.w  D5,D6
            cmp.w   D7,D6
            beq.b   .L7
            movea.l (A3),A0
            move.w  D6,D0
            bsr.w   sub_40817928
            movea.l A0,A2
.L6:
            tst.b   (A2)
            beq.b   .L7
            subq.w  #2,SP
            movea.l A2,A0
            moveq   #0,D0
            move.b  (A0)+,D0
            move.l  A0,-(SP)
            movea.l A4,A0
            moveq   #0,D1
            move.b  (A0)+,D1
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            movea.l A3,A0
            _HLock
            move.w  MinusOne,ResLoad
            move.w  #$A,-(SP)
            _Pack6
            clr.w   ResLoad
            movea.l A3,A0
            _HUnlock
            move.w  (SP)+,D0
            bgt.b   .L7
            beq.b   .L9
            cmp.w   D7,D6
            beq.b   .L7
            moveq   #0,D0
            move.b  (A2),D0
            addq.w  #5,D0
            adda.l  D0,A2
            addq.w  #1,D6
            bra.b   .L6
.L7:
            tst.w   (-$11C,A6)
            beq.b   .L8
            move.w  #$9F,D0
            _GetTrapAddress
            move.l  A0,D1
            move.w  #$B5,D0
            _GetTrapAddress
            cmp.l   A0,D1
            beq.b   .L8
            move.l  A4,-(SP)
            pea     (-$11A,A6)
            _GetFNum
            clr.w   -(SP)
            move.w  (-$11A,A6),-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            move.w  (SP)+,D0
            beq.b   .L8
            move.b  #$1C,(-$117,A6)
            move.b  D0,(-$118,A6)
.L8:
            move.w  D5,-(SP)
            bsr.w   sub_40817EC4
            move.w  (SP)+,D5
            addq.w  #1,D7
.L9:
            addq.w  #1,D3
            cmp.w   D4,D3
            ble.w   .L5
.L10:
            cmpi.l  #'FOND',($A,A6)
            bne.b   .L11
            move.b  #$54,($D,A6)
            bra.w   .L4
.L11:
            move.l  A3,-(SP)
            _CalcMenuSize
            movea.l A3,A0
            _HUnlock
            _SetResLoad
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            bra.w   sub_40817928.L7
CountMItems:
            moveq   #0,D2
.L1:
            addq.w  #1,D2
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.w  D2,D0
            bsr.w   sub_40817928
            bne.b   .L1
            subq.w  #1,D2
            move.w  D2,(8,SP)
            move.l  (SP)+,(SP)
            rts
PlotIcon:
            lea     ($A0E).w,A1
            move.l  (4,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(A1)+
            move.w  #4,(A1)+
            clr.l   (A1)+
            move.l  #$200020,(A1)
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
            bra.w   sub_40817928.L5
MMGREND:
            ds.b    12

            EVEN
