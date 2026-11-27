            include "Include/ROMHeader.s"

            EXPORT  Alert,CautionAlert,CloseDialog,CouldAlert,CouldDialog,DialogSelect
            EXPORT  DisposDialog,DrawDialog,ErrorSound,FindDItem,FreeAlert,FreeDialog
            EXPORT  GetDItem,GetIText,GetNewDialog,HideDItem,InitDialogs,IsDialogEvent
            EXPORT  ModalDialog,NewCDialog,NewDialog,NoteAlert,ParamText,SelIText
            EXPORT  SetDItem,SetIText,ShowDItem,StopAlert,UpdtDialog

            IMPORT  A

            SECTION "DialogMgr",CODE

DMGR:
            dc.w    $000A,$0014,$002A,$0034
.L1:
            dc.w    0
InitDialogs:
            bsr.w   sub_40819D76
            move.l  (8,A6),ResumeProc
            clr.w   ACount
            st      ANumber
            lea     DABeeper,A0
            lea     sub_408198F8,A1
            move.l  A1,(A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.w   DlgFont
            moveq   #4,D0
            bra.w   sub_40819D76.L1
sub_408198F8:
            movea.l (SP)+,A1
            move.w  (SP)+,D2
.L1:
            beq.b   .L2
            move.w  #3,-(SP)
            _SysBeep
            movea.w #6,A0
            _Delay
            subq.w  #1,D2
            bra.b   .L1
.L2:
            jmp     (A1)
sub_40819910:
            bsr.w   sub_40819D76
            movea.l ($10,A6),A4
            bsr.w   BeginInWind
            clr.w   ($14,A6)
            movea.l ($C,A6),A0
            cmpi.w  #3,(A0)
            bne.b   .L3
            cmpi.b  #3,(5,A0)
            beq.b   .L1
            cmpi.b  #$D,(5,A0)
            bne.b   .L3
.L1:
            move.w  ($A8,A4),D3
            movea.l (8,A6),A1
            move.w  D3,(A1)
            subq.w  #1,D3
            bsr.w   GetDLItem
            bsr.w   sub_4081A29C
            andi.w  #7,D0
            cmpi.w  #4,D0
            bne.b   .L2
            move.b  ($C,A2),D0
            bmi.b   .L3
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.l  A0,-(SP)
            move.w  #$A,-(SP)
            _HiliteControl
            movea.w #8,A0
            _Delay
            _HiliteControl
.L2:
            addq.b  #1,($14,A6)
.L3:
            bsr.w   EndInWind
            moveq   #$C,D0
            bra.w   sub_40819D76.L1
StopAlert:
            moveq   #0,D0
            bra.b   Alert.L1
NoteAlert:
            moveq   #1,D0
            bra.b   Alert.L1
CautionAlert:
            moveq   #2,D0
            bra.b   Alert.L1
Alert:
            moveq   #-1,D0
.L1:
            bsr.w   sub_40819D76
            move.w  #$FFFF,($E,A6)
            move.w  D0,D3
            move.w  ($C,A6),D0
            bsr.w   sub_40819F38
            beq.w   .L11
            move.w  ACount,D0
            move.w  ($C,A6),D1
            cmp.w   ANumber,D1
            beq.b   .L2
            move.w  D1,ANumber
            moveq   #0,D0
.L2:
            move.w  D0,ACount
            move.w  ($A,A1),D4
.L3:
            subq.w  #1,D0
            blt.b   .L4
            lsr.w   #4,D4
            bra.b   .L3
.L4:
            andi.w  #$F,D4
            move.l  D4,D0
            andi.w  #3,D0
            bsr.w   sub_40819AE2
            btst    #2,D4
            beq.w   .L9
            move.l  #$1FF,D0
            _FlushEvents
            move.w  (8,A1),D0
            bsr.w   sub_40819AB2
            beq.w   .L9
            movea.l (A2),A1
            subq.w  #4,SP
            clr.l   -(SP)
            pea     (A1)
            pea     DMGR.L1
            tst.l   (-$54,A6)
            seq     D0
            move.b  D0,-(SP)
            move.w  #1,-(SP)
            move.l  MinusOne,-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            tst.l   (-$54,A6)
            beq.b   .L5
            st      (-$56,A6)
            bsr.w   setUpCDialog
            bra.b   .L6
.L5:
            _NewDialog
.L6:
            movea.l (SP),A4
            pea     (-$2C,A6)
            _GetPort
            _SetPort
            tst.w   D3
            bmi.b   .L8
            subq.w  #4,SP
            move.w  D3,-(SP)
            _GetCIcon
            move.l  (SP)+,D0
            beq.b   .L7
            pea     DMGR
            move.l  D0,-(SP)
            _PlotCIcon
            bra.b   .L8
.L7:
            subq.w  #4,SP
            move.w  D3,-(SP)
            _GetIcon
            move.l  (SP)+,D0
            beq.b   .L8
            pea     DMGR
            move.l  D0,-(SP)
            _PlotIcon
.L8:
            asr.w   #3,D4
            addq.w  #1,D4
            move.w  D4,($A8,A4)
            move.l  A4,-(SP)
            move.w  D4,-(SP)
            pea     (-$3C,A6)
            move.l  (SP),-(SP)
            pea     (-$28,A6)
            _GetDItem
            lea     (-$28,A6),A0
            moveq   #3,D0
            moveq   #$10,D1
            moveq   #4,D2
            bsr.w   sub_4081A98E
            move.l  (8,A6),-(SP)
            pea     ($E,A6)
            _ModalDialog
            move.l  (-$2C,A6),-(SP)
            _SetPort
            move.l  A4,-(SP)
            _DisposDialog
.L9:
            movea.l A2,A0
            _HUnlock
            move.w  ACount,D1
            addq.w  #1,D1
            cmpi.w  #4,D1
            blt.b   .L10
            moveq   #3,D1
.L10:
            move.w  D1,ACount
.L11:
            moveq   #6,D0
            bra.w   sub_40819D76.L1
sub_40819AB2:
            subq.w  #4,SP
            move.l  #'DITL',-(SP)
            move.w  D0,-(SP)
            bsr.w   getIctb
            move.l  (-$50,A6),D0
            beq.b   .L1
            movea.l D0,A0
            _HandToHand
            move.l  A0,(-$50,A6)
.L1:
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.b   .L2
            _HandToHand
            move.l  A0,D0
.L2:
            rts
sub_40819AE2:
            movem.l D0-D2/A0-A2,-(SP)
            move.l  DABeeper,D1
            beq.b   .L1
            move.w  D0,-(SP)
            movea.l D1,A0
            jsr     (A0)
.L1:
            movem.l (SP)+,D0-D2/A0-A2
            rts
GetNewDialog:
            bsr.w   sub_40819D76
            clr.l   ($12,A6)
            move.w  ($10,A6),D0
            bsr.w   sub_40819F48
            beq.b   .L4
            subq.w  #4,SP
            move.l  ($C,A6),-(SP)
            move.l  A1,-(SP)
            pea     ($14,A1)
            addq.l  #8,A1
            move.l  (A1)+,-(SP)
            tst.l   (-$54,A6)
            beq.b   .L1
            move.b  (2,SP),(-$56,A6)
            clr.w   (2,SP)
.L1:
            move.l  (8,A6),-(SP)
            move.w  (A1)+,-(SP)
            move.l  (A1)+,-(SP)
            move.w  (A1)+,D0
            bsr.w   sub_40819AB2
            beq.b   .L4
            move.l  A0,-(SP)
            tst.l   (-$54,A6)
            beq.b   .L2
            bsr.b   setUpCDialog
            bra.b   .L3
.L2:
            _NewDialog
.L3:
            movea.l A2,A0
            _HUnlock
            move.l  (SP)+,($12,A6)
.L4:
            moveq   #$A,D0
            bra.w   sub_40819D76.L1
setUpCDialog:
            movea.l (-$54,A6),A0
            movea.l (A0),A1
            cmpi.w  #$FFFF,(6,A1)
            beq.b   .L1
            _HandToHand
            move.l  A0,(-$54,A6)
.L1:
            move.l  (SP)+,(-$5A,A6)
            move.l  A6,D1
            bsr.b   sub_40819B96
            tst.b   (-$56,A6)
            beq.b   .L3
            move.l  (SP),-(SP)
            moveq   #-1,D0
            cmp.l   (8,A6),D0
            beq.b   .L2
            st      -(SP)
            _ShowHide
            bra.b   .L3
.L2:
            _ShowWindow
.L3:
            movea.l (-$5A,A6),A0
            jmp     (A0)
NewCDialog:
            moveq   #-1,D1
            bra.b   sub_40819B96
NewDialog:
            moveq   #0,D1
sub_40819B96:
            bsr.w   sub_40819D76
            move.l  D1,D5
            tst.l   ($22,A6)
            bne.b   .L1
            move.l  #$AA,D0
            _NewPtr
            move.l  A0,($22,A6)
.L1:
            lea     ($C,A6),A0
            moveq   #$1E,D0
            suba.l  D0,SP
            movea.l SP,A1
            _BlockMove
            tst.l   D5
            beq.b   .L2
            _NewCWindow
            tst.l   D5
            bmi.b   .L3
            move.l  A6,-(SP)
            movea.l D5,A6
            movea.l (4,SP),A0
            subq.w  #6,SP
            move.l  A0,-(SP)
            pea     (6,SP)
            move.l  A0,-(SP)
            move.l  (-$54,A6),-(SP)
            _SetWinColor
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (-$50,A6),($C,A0)
            movea.l (SP)+,A6
            bra.b   .L3
.L2:
            _NewWindow
.L3:
            movea.l (SP)+,A4
            move.l  A4,($26,A6)
            movea.l (8,A6),A3
            move.w  #2,($6C,A4)
            move.l  A3,($9C,A4)
            move.w  MinusOne,($A4,A4)
            move.w  DlgFont,($44,A4)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            move.l  A4,-(SP)
            _SetPort
            move.w  #1,($A8,A4)
            subq.w  #4,SP
            pea     ($10,A4)
            move.l  (SP),-(SP)
            _TENew
            move.l  (SP),($A0,A4)
            movea.l (SP)+,A1
            movea.l (A1),A2
            movea.l ($3E,A2),A0
            _DisposHandle
            _SetPort
            bsr.w   BeginInWind
            moveq   #0,D4
            bsr.w   sub_4081A28A
            bsr.w   EndInWind
            moveq   #$1E,D0
            bra.w   sub_40819D76.L1
ClaimEvent:
            move.w  (A2),D3
            subq.w  #6,D3
            beq.b   .L1
            subq.w  #2,D3
            beq.b   .L1
            subq.w  #4,SP
            _FrontWindow
            movea.l (SP)+,A4
            rts
.L1:
            movea.l (2,A2),A4
            rts
IsDialogEvent:
            bsr.w   sub_40819D76
            clr.w   ($C,A6)
            movea.l (8,A6),A2
            bsr.b   ClaimEvent
            cmpi.w  #2,($6C,A4)
            bne.b   .L2
            move.w  (A2),D3
            subq.w  #1,D3
            bne.b   .L1
            subq.w  #2,SP
            move.l  ($A,A2),-(SP)
            pea     (-$14,A6)
            _FindWindow
            subq.w  #3,(SP)+
            bne.b   .L2
            cmpa.l  (-$14,A6),A4
            bne.b   .L2
.L1:
            addq.b  #1,($C,A6)
.L2:
            moveq   #4,D0
            bra.w   sub_40819D76.L1
DialogSelect:
            bsr.w   sub_40819D76
            clr.w   ($14,A6)
            movea.l ($C,A6),A3
            clr.l   (A3)
            movea.l ($10,A6),A2
            bsr.b   ClaimEvent
            move.l  A4,(A3)
            bsr.w   BeginInWind
            movea.l ($10,A6),A0
            lea     (-$4C,A6),A1
            moveq   #$10,D0
            _BlockMove
            bsr.w   sub_4081A5F6
            tst.w   D3
            bmi.b   .L1
            addq.b  #1,($14,A6)
.L1:
            movea.l (8,A6),A0
            move.w  D3,(A0)
            bsr.w   EndInWind
            moveq   #$C,D0
            bra.w   sub_40819D76.L1
ModalDialog:
            bsr.w   sub_40819D76
.L1:
            _SystemTask
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            subq.w  #4,SP
            _FrontWindow
            move.l  (SP),-(SP)
            _SetPort
            movea.l (SP)+,A0
            tst.w   ($A4,A0)
            bmi.b   .L2
            move.w  ($A4,A0),D0
            bsr.w   sub_4081A7F2
            move.l  ($A0,A0),-(SP)
            _TEIdle
            bsr.w   sub_4081A91C
.L2:
            _SetPort
            subq.w  #6,SP
            move.w  #$17F,-(SP)
            pea     (-$4C,A6)
            _GetNextEvent
            move.l  ($C,A6),D3
            bne.b   .L3
            lea     sub_40819910,A0
            move.l  A0,D3
.L3:
            _FrontWindow
            pea     (-$4C,A6)
            move.l  (8,A6),-(SP)
            movea.l D3,A0
            jsr     (A0)
            tst.b   (SP)+
            bne.b   .L4
            subq.w  #2,SP
            pea     (-$4C,A6)
            _IsDialogEvent
            tst.w   (SP)+
            beq.b   .L5
            subq.w  #2,SP
            pea     (-$4C,A6)
            pea     (-$1C,A6)
            move.l  (8,A6),-(SP)
            _DialogSelect
            tst.w   (SP)+
            ble.b   .L1
.L4:
            moveq   #8,D0
            bra.b   sub_40819D76.L1
.L5:
            move.w  (-$4C,A6),D0
            subq.w  #1,D0
            bne.w   .L1
            moveq   #1,D0
            bsr.w   sub_40819AE2
            bra.w   .L1
sub_40819D76:
            movea.l (SP)+,A0
            link.w  A6,#-$76
            movem.l D3-D7/A2-A4,-(SP)
            jmp     (A0)
.L1:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.l  D0,SP
            jmp     (A0)
DrawDialog:
            bsr.b   sub_40819D76
            movea.l (8,A6),A4
            bsr.b   BeginInWind
            move.l  A4,-(SP)
            _DrawControls
            moveq   #1,D4
            bsr.w   sub_4081A28A
            bsr.w   EndInWind
            bra.b   CloseDialog.L1
UpdtDialog:
            bsr.b   sub_40819D76
            movea.l ($C,A6),A4
            bsr.b   BeginInWind
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            _UpdtControl
            moveq   #3,D4
            bsr.w   sub_4081A28A
            bsr.b   EndInWind
            bra.w   SetIText.L6
EndInWind:
            move.l  (-$2C,A6),-(SP)
            _SetPort
            movea.l A3,A0
            _HUnlock
            rts
CloseDialog:
            bsr.b   sub_40819D76
            movea.l (8,A6),A4
            bsr.b   BeginInWind
            move.l  ($1C,A4),-(SP)
            _SetEmptyRgn
            moveq   #2,D4
            bsr.w   sub_4081A28A
            bsr.b   EndInWind
            movea.l ($A0,A4),A0
            move.l  A0,-(SP)
            moveq   #0,D0
            _NewHandle
            move.l  A0,D0
            movea.l (SP),A0
            movea.l (A0),A0
            move.l  D0,($3E,A0)
            _TEDispose
            move.l  A4,-(SP)
            _CloseWindow
.L1:
            moveq   #4,D0
            bra.b   sub_40819D76.L1
sub_40819E02:
            movea.l ($9C,A4),A3
            tst.l   (A3)
            bne.b   .L1
            move.l  A3,-(SP)
            _LoadResource
.L1:
            movea.l A3,A0
            _HLock
            rts
BeginInWind:
            pea     (-$2C,A6)
            _GetPort
            move.l  A4,-(SP)
            _SetPort
            bsr.b   sub_40819E02
            bsr.b   sub_40819E2C
            beq.b   .L1
            bsr.w   sub_4081A788
.L1:
            moveq   #$1A,D1
            rts
sub_40819E2C:
            move.w  ($A4,A4),D3
            bmi.b   .L1
            bsr.w   GetDLItem
            bra.b   .L3
.L1:
            moveq   #-1,D3
.L2:
            bsr.w   sub_4081A9C0
            beq.b   .L4
            btst    #4,($C,A2)
            beq.b   .L2
            bsr.w   sub_4081A960
            beq.b   .L2
.L3:
            moveq   #-2,D2
.L4:
            rts
DisposDialog:
            subq.w  #6,SP
            move.l  ($A,SP),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
            beq.b   .L1
            movea.l D0,A0
            _DisposHandle
.L1:
            movea.l (4,SP),A0
            move.l  ($9C,A0),-(SP)
            move.l  A0,-(SP)
            _CloseDialog
            movea.l (SP)+,A0
            _DisposHandle
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     (A1)
sub_40819E86:
            movea.l (A2),A0
            move.w  ($12,A0),D0
            bra.b   sub_40819E8E.L1
sub_40819E8E:
            movea.l (A2),A0
            move.w  (8,A0),D0
.L1:
            subq.w  #4,SP
            move.l  #'DITL',-(SP)
            move.w  D0,-(SP)
            bsr.b   getIctb
.L2:
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (SP)+,A2
            move.l  A2,D0
            rts
getIctb:
            subq.w  #4,SP
            move.l  #'ictb',-(SP)
            move.w  D0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,(-$50,A6)
            rts
CouldDialog:
            bsr.w   sub_40819D76
            lea     sub_40819F48,A2
            lea     sub_40819E86,A4
            bra.b   CouldAlert.L1
CouldAlert:
            bsr.w   sub_40819D76
            lea     sub_40819F38,A2
            lea     sub_40819E8E,A4
.L1:
            move.w  (8,A6),D0
            jsr     (A2)
            beq.w   FreeAlert.L4
            move.l  (-$54,A6),D0
            beq.b   .L2
            movea.l D0,A0
            _HNoPurge
.L2:
            movea.l A2,A0
            _HUnlock
            _HNoPurge
            jsr     (A4)
            beq.w   FreeAlert.L4
            move.l  (-$50,A6),D0
            beq.b   .L3
            movea.l D0,A0
            _HNoPurge
.L3:
            movea.l A2,A0
            _HNoPurge
            movea.l A2,A3
            moveq   #-2,D4
            bsr.w   sub_40819FD2
            movea.l A2,A0
            _HNoPurge
            bra.w   FreeAlert.L4
doColorStuff:
            move.w  D0,-(SP)
            subq.w  #4,SP
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP),(-$54,A6)
            addq.w  #4,SP
            move.w  (SP)+,D0
            rts
sub_40819F38:
            movea.l #'actb',A0
            bsr.b   doColorStuff
            movea.l #'ALRT',A0
            bra.b   sub_40819F48.L1
sub_40819F48:
            movea.l #'dctb',A0
            bsr.b   doColorStuff
            movea.l #'DLOG',A0
.L1:
            subq.w  #4,SP
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP),D0
            movea.l D0,A2
            beq.b   .L2
            movea.l D0,A0
            _HLock
            movea.l (A2),A1
.L2:
            tst.l   (SP)+
            rts
sub_40819F74:
            move.l  A2,-(SP)
            movea.l D0,A2
            bsr.w   sub_4081A32E
            movea.l (SP)+,A2
            rts
FreeDialog:
            bsr.w   sub_40819D76
            lea     sub_40819F48,A2
            lea     sub_40819E86,A4
            bra.b   FreeAlert.L1
FreeAlert:
            bsr.w   sub_40819D76
            lea     sub_40819F38,A2
            lea     sub_40819E8E,A4
.L1:
            move.w  (8,A6),D0
            jsr     (A2)
            beq.b   .L4
            move.l  (-$54,A6),D0
            beq.b   .L2
            bsr.b   sub_40819F74
.L2:
            movea.l A2,A0
            _HUnlock
            bsr.w   sub_4081A32E
            jsr     (A4)
            beq.b   .L4
            move.l  (-$50,A6),D0
            beq.b   .L3
            bsr.b   sub_40819F74
.L3:
            bsr.w   sub_4081A32E
            movea.l A2,A3
            moveq   #-1,D4
            bsr.b   sub_40819FD2
            bsr.w   sub_4081A32E
.L4:
            moveq   #2,D0
            bra.w   sub_40819D76.L1
sub_40819FD2:
            movea.l A3,A0
            _HLock
            bsr.w   sub_4081A28A
            movea.l A3,A0
            _HUnlock
            subq.w  #4,SP
            move.l  #'WDEF',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            bra.w   sub_40819E8E.L2
ParamText:
            lea     TEScrpLength,A1
            moveq   #3,D2
.L1:
            move.l  (4,SP),D1
            movea.l -(A1),A0
            beq.b   .L3
            move.l  A0,D0
            beq.b   .L2
            _DisposHandle
.L2:
            movea.l D1,A0
            bsr.w   sub_4081A9B0
            move.l  A0,(A1)
.L3:
            move.l  (SP)+,(SP)
            dbra    D2,.L1
            rts
ErrorSound:
            movea.l (SP)+,A0
            move.l  (SP)+,DABeeper
            jmp     (A0)
GetDItem:
            bsr.w   sub_40819D76
            movea.l ($16,A6),A4
            bsr.w   BeginInWind
            move.w  ($14,A6),D3
            subq.w  #1,D3
            bsr.w   GetDLItem
            beq.b   .L2
            move.l  (8,A6),D0
            beq.b   .L1
            lea     (4,A2),A0
            movea.l D0,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
.L1:
            movea.l ($10,A6),A0
            moveq   #0,D0
            move.b  ($C,A2),D0
            move.w  D0,(A0)
            move.l  (A2),D5
            movea.l ($C,A6),A0
            move.l  D5,(A0)
.L2:
            bsr.w   EndInWind
            moveq   #$12,D0
            bra.w   sub_40819D76.L1
SetDItem:
            bsr.w   sub_40819D76
            movea.l ($14,A6),A4
            bsr.w   BeginInWind
            move.w  ($12,A6),D3
            subq.w  #1,D3
            bsr.w   GetDLItem
            beq.b   .L1
            movea.l (8,A6),A0
            lea     (4,A2),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  ($C,A6),(A2)
            move.b  ($11,A6),($C,A2)
.L1:
            bsr.w   EndInWind
            moveq   #$10,D0
            bra.w   sub_40819D76.L1
GetIText:
            moveq   #0,D1
            subq.b  #1,D1
            bsr.w   sub_40819D76
            movea.l (8,A6),A1
            movea.l ($C,A6),A0
            _GetHandleSize
            cmp.l   D1,D0
            ble.b   .L1
            move.l  D1,D0
.L1:
            move.b  D0,(A1)+
            movea.l (A0),A0
            _BlockMove
            bra.b   SetIText.L6
SetIText:
            bsr.w   sub_40819D76
            movea.l (8,A6),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            movea.l ($C,A6),A1
            _PtrToXHand
            movea.l WindowList,A4
.L1:
            cmpi.w  #2,($6C,A4)
            bne.b   .L5
            bsr.w   BeginInWind
            move.l  ($C,A6),D6
            moveq   #-1,D3
.L2:
            bsr.w   sub_4081A9C0
            beq.b   .L4
            cmp.l   (A2),D6
            bne.b   .L2
            cmp.w   ($A4,A4),D3
            bne.b   .L3
            bsr.w   SetUpText
            move.l  ($A0,A4),-(SP)
            _TECalText
            bsr.w   sub_4081A91C
.L3:
            tst.b   ($6E,A4)
            beq.b   .L4
            pea     (-$28,A6)
            move.l  (SP),-(SP)
            _EraseRect
            bsr.w   sub_4081A42C
            _ValidRect
.L4:
            bsr.w   EndInWind
.L5:
            movea.l ($90,A4),A4
            move.l  A4,D0
            bne.b   .L1
.L6:
            moveq   #8,D0
            bra.w   sub_40819D76.L1
SelIText:
            bsr.w   sub_40819D76
            movea.l ($E,A6),A4
            bsr.w   BeginInWind
            move.w  ($C,A6),D3
            subq.w  #1,D3
            bsr.w   GetDLItem
            move.l  (8,A6),D2
            swap    D2
            bsr.w   ChangeField
            bsr.w   EndInWind
            moveq   #$A,D0
            bra.w   sub_40819D76.L1
GetRect_DialogMgr:
            moveq   #-3,D7
            move.b  ($C,A2),D1
            btst    #4,D1
            bne.b   .L1
            moveq   #-4,D7
            move.w  ($A8,A4),D0
            subq.w  #1,D0
            cmp.w   D0,D3
            beq.b   .L1
            moveq   #0,D7
.L1:
            movea.l (SP)+,A0
            move.l  (8,A2),-(SP)
            move.l  (4,A2),-(SP)
            move.l  A0,-(SP)
            pea     (4,SP)
            move.w  D7,-(SP)
            move.w  D7,-(SP)
            _InsetRect
            rts
HideDItem:
            bsr.w   sub_40819D76
            movea.l ($A,A6),A4
            bsr.w   BeginInWind
            move.w  (8,A6),D3
            subq.w  #1,D3
            bsr.w   GetDLItem
            beq.b   .L1
            move.w  (6,A2),D0
            cmpi.w  #$2000,D0
            blt.b   .L2
.L1:
            bsr.w   EndInWind
            moveq   #6,D0
            bra.w   sub_40819D76.L1
.L2:
            bsr.b   GetRect_DialogMgr
            cmp.w   ($A4,A4),D3
            bne.b   .L3
            moveq   #-1,D3
            bsr.w   ChangeField
.L3:
            move.l  SP,-(SP)
            _EraseRect
            addi.w  #$4000,(6,A2)
            addi.w  #$4000,($A,A2)
            bsr.b   ShowHideCmn
            beq.b   .L4
            move.l  (A2),-(SP)
            move.l  (4,A2),-(SP)
            _MoveControl
.L4:
            move.l  SP,-(SP)
            _InvalRect
            addq.w  #8,SP
.L5:
            bra.b   .L1
ShowDItem:
            bsr.w   sub_40819D76
            movea.l ($A,A6),A4
            bsr.w   BeginInWind
            move.w  (8,A6),D3
            subq.w  #1,D3
            bsr.w   GetDLItem
            beq.b   HideDItem.L5
            move.w  (6,A2),D0
            cmpi.w  #$2000,D0
            blt.b   HideDItem.L5
            subi.w  #$4000,(6,A2)
            subi.w  #$4000,($A,A2)
            bsr.w   GetRect_DialogMgr
            bsr.b   ShowHideCmn
            beq.b   .L1
            movea.l (A2),A0
            movea.l (A0),A1
            move.b  ($10,A1),-(SP)
            clr.b   ($10,A1)
            move.l  A0,-(SP)
            move.l  (4,A2),-(SP)
            _MoveControl
            movea.l (A2),A0
            movea.l (A0),A1
            move.b  (SP)+,($10,A1)
.L1:
            bra.b   HideDItem.L4
ShowHideCmn:
            tst.w   ($A4,A4)
            bpl.b   .L2
            move.l  A2,-(SP)
            bsr.w   sub_40819E2C
            beq.b   .L1
            moveq   #0,D2
            bsr.w   ChangeField
.L1:
            movea.l (SP)+,A2
.L2:
            move.b  ($C,A2),D1
            btst    #2,D1
            rts
FindDItem:
            bsr.w   sub_40819D76
            movea.l ($C,A6),A4
            bsr.w   sub_40819E02
            moveq   #-1,D3
            move.w  D3,($10,A6)
.L1:
            bsr.w   sub_4081A9C0
            beq.b   .L2
            subq.w  #2,SP
            move.l  (8,A6),-(SP)
            pea     (-$28,A6)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L1
            move.w  D3,($10,A6)
.L2:
            movea.l A3,A0
            _HUnlock
            bra.w   SetIText.L6
sub_4081A28A:
            movem.l D0-D7/A0-A4,-(SP)
            moveq   #-1,D3
.L1:
            bsr.w   sub_4081A9C0
            bne.b   sub_4081A29C.L1
            movem.l (SP)+,D0-D7/A0-A4
            rts
sub_4081A29C:
            movea.l (A2),A0
            move.b  ($C,A2),D0
            rts
.L1:
            bsr.b   sub_4081A29C
            pea     sub_4081A28A.L1
            cmpi.w  #2,D4
            bgt.w   sub_4081A32E.L12
            beq.w   sub_4081A42C.L21
            tst.w   D4
            beq.w   sub_4081A32E.L2
            bgt.w   sub_4081A42C
            btst    #2,D0
            bne.b   .L3
            roxr.w  #7,D0
            bmi.b   sub_4081A2E4.L2
            bcs.b   sub_4081A2E4.L3
.L2:
            rts
.L3:
            andi.w  #3,D0
            cmpi.w  #3,D0
            bne.b   sub_4081A2E4.L1
            pea     sub_4081A2E4
            move.l  #'CNTL',D1
            bra.b   sub_4081A2E4.L4
sub_4081A2E4:
            move.l  A2,D0
            beq.b   sub_4081A29C.L2
            movea.l (A2),A1
            move.w  ($10,A1),D0
.L1:
            move.l  #'CDEF',D1
            bra.b   .L5
.L2:
            movea.w ($E,A2),A2
            subq.w  #4,SP
            move.w  A2,-(SP)
            _GetCIcon
            tst.l   (SP)
            bne.b   .L6
            move.w  A2,-(SP)
            _GetIcon
            bra.b   .L6
.L3:
            subq.w  #4,SP
            move.w  ($E,A2),-(SP)
            _GetPicture
            bra.b   .L6
.L4:
            move.w  ($E,A2),D0
.L5:
            subq.w  #4,SP
            move.l  D1,-(SP)
            move.w  D0,-(SP)
            _GetResource
.L6:
            movea.l (SP)+,A2
            cmpi.w  #$FFFF,D4
            beq.b   sub_4081A32E
            movea.l A2,A0
            _HNoPurge
            rts
sub_4081A32E:
            subq.w  #2,SP
            move.l  A2,-(SP)
            _GetResAttrs
            move.w  (SP)+,D0
            btst    #5,D0
            beq.b   .L1
            movea.l A2,A0
            _HPurge
.L1:
            rts
.L2:
            move.l  A0,D1
            beq.b   .L3
            rts
.L3:
            btst    #2,D0
            bne.b   .L7
            roxr.w  #5,D0
            bcs.b   .L4
            bmi.b   .L4
            roxr.w  #2,D0
            bmi.b   .L5
            bcs.b   .L6
            rts
.L4:
            lea     ($D,A2),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            _PtrToHand
            move.l  A0,-(SP)
            bra.w   .L11
.L5:
            subq.w  #4,SP
            move.w  ($E,A2),-(SP)
            _GetCIcon
            tst.l   (SP)
            bne.w   .L11
            move.w  ($E,A2),-(SP)
            _GetIcon
            bra.w   .L11
.L6:
            subq.w  #4,SP
            move.w  ($E,A2),-(SP)
            _GetPicture
            bra.b   .L11
.L7:
            andi.w  #3,D0
            cmpi.w  #3,D0
            bne.b   .L8
            subq.w  #4,SP
            move.w  ($E,A2),-(SP)
            move.l  A4,-(SP)
            _GetNewControl
            move.l  (SP),-(SP)
            move.l  (4,A2),-(SP)
            _MoveControl
            bra.b   .L9
.L8:
            subq.w  #4,SP
            move.l  A4,-(SP)
            pea     (-$28,A6)
            pea     ($D,A2)
            st      -(SP)
            clr.l   -(SP)
            move.w  #1,-(SP)
            move.w  D0,-(SP)
            clr.l   -(SP)
            _NewControl
.L9:
            subq.w  #6,SP
            move.l  A4,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            move.l  (SP)+,D0
            beq.b   .L10
            movea.l D0,A0
            movea.l (A0),A0
            move.l  ($C,A0),D1
            beq.b   .L10
            movea.l D1,A0
            movea.l (A0),A0
            moveq   #0,D0
            lea     (0,A0,D3.w*4),A1
            move.w  (A1)+,D0
            ble.b   .L10
            adda.w  (A1),A0
            _PtrToHand
            tst.w   D0
            bne.b   .L10
            move.l  (SP),-(SP)
            move.l  A0,-(SP)
            _SetCtlColor
.L10:
            pea     (-$28,A6)
            _ValidRect
.L11:
            move.l  (SP)+,(A2)
            rts
.L12:
            move.l  (8,A2),-(SP)
            move.l  (4,A2),-(SP)
            move.l  SP,-(SP)
            move.l  #$FFFCFFFC,-(SP)
            _InsetRect
            subq.w  #2,SP
            pea     (2,SP)
            move.l  (8,A6),-(SP)
            _RectInRgn
            tst.b   (SP)+
            addq.w  #8,SP
            bne.b   sub_4081A42C.L1
            rts
sub_4081A42C:
            bsr.w   sub_4081A29C
            andi.b  #$7F,D0
            beq.b   .L2
            bsr.w   sub_4081A964
            beq.b   .L3
.L1:
            bsr.w   sub_4081A29C
            btst    #2,D0
            bne.b   .L8
            roxr.w  #5,D0
            bcs.b   .L9
            bmi.b   .L9
            roxr.w  #2,D0
            bmi.b   .L4
            bcs.b   .L7
.L2:
            move.l  A4,-(SP)
            _SetPort
            bsr.w   sub_4081A8EA
            move.l  (A2),D0
            beq.b   .L3
            move.l  A4,-(SP)
            move.w  D3,-(SP)
            addq.w  #1,(SP)
            movea.l D0,A0
            jsr     (A0)
            subq.w  #6,SP
            move.l  A4,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .L3
            move.l  A4,-(SP)
            _SetPort
            bsr.w   sub_4081A93A
.L3:
            rts
.L4:
            pea     (-$28,A6)
            move.l  (A2),-(SP)
            move.l  (SP),-(SP)
            _LoadResource
            movea.l (SP),A0
            _GetHandleSize
            tst.l   D0
            ble.b   .L5
            ror.l   #7,D0
            subq.w  #1,D0
            beq.b   .L6
            _PlotCIcon
            rts
.L5:
            addq.w  #8,SP
            rts
.L6:
            _PlotIcon
            rts
.L7:
            move.l  (A2),-(SP)
            move.l  (SP),-(SP)
            _LoadResource
            pea     (-$28,A6)
            _DrawPicture
.L8:
            rts
.L9:
            smi     D6
            cmp.w   ($A4,A4),D3
            bne.b   .L12
            bsr.w   SetUpText
            pea     (-$28,A6)
            move.l  (SP),-(SP)
            _EraseRect
            move.l  ($A0,A4),-(SP)
            _TEUpdate
            bsr.w   sub_4081A91C
.L10:
            tst.b   D6
            bne.b   .L11
            lea     (-$28,A6),A0
            moveq   #1,D0
            moveq   #1,D1
            moveq   #3,D2
            bsr.w   sub_4081A98E
.L11:
            rts
.L12:
            bsr.w   sub_4081A7FC
            movem.l D2-D6/A2-A4,-(SP)
            movea.l (A2),A0
            _HandToHand
            movea.l A0,A2
            tst.b   D6
            beq.b   .L17
            moveq   #0,D3
.L13:
            movea.l A2,A0
            _GetHandleSize
            movea.l (A0),A4
            adda.l  D3,A4
            move.l  D0,D5
            sub.l   D3,D5
            bra.b   .L16
.L14:
            cmpi.b  #$5E,(A4)+
            beq.b   .L18
.L15:
            addq.w  #1,D3
.L16:
            dbra    D5,.L14
.L17:
            movea.l A2,A0
            _HLock
            move.l  (A2),-(SP)
            movea.l A2,A0
            _GetHandleSize
            move.l  D0,-(SP)
            pea     (-$28,A6)
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($A0,A0),A0
            movea.l (A0),A0
            move.w  ($3A,A0),-(SP)
            _TETextBox
            bsr.w   sub_4081A93A
            movea.l A2,A0
            _DisposHandle
            movem.l (SP)+,D2-D6/A2-A4
            bra.b   .L10
.L18:
            lea     DABeeper,A3
            move.b  #$2F,D6
.L19:
            addq.l  #4,A3
            addq.w  #1,D6
            cmpi.b  #$34,D6
            beq.b   .L15
            cmp.b   (A4),D6
            bne.b   .L19
            moveq   #0,D0
            move.l  (A3),D4
            beq.b   .L20
            movea.l D4,A0
            _HLock
            movea.l (A0),A0
            move.b  (A0)+,D0
.L20:
            subq.w  #4,SP
            move.l  A2,-(SP)
            move.l  D3,-(SP)
            clr.l   -(SP)
            move.l  #2,-(SP)
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            _Munger
            move.l  (SP)+,D0
            tst.l   D4
            beq.w   .L13
            movea.l D4,A0
            _HUnlock
            bra.w   .L13
.L21:
            ror.w   #3,D0
            bcs.w   .L8
            roxr.w  #2,D0
            bcs.b   .L23
            bmi.b   .L23
            roxr.w  #2,D0
            bpl.b   .L22
            _GetHandleSize
            tst.l   D0
            ble.b   .L22
            ror.l   #7,D0
            subq.w  #1,D0
            beq.b   .L22
            move.l  A0,-(SP)
            _DisposCIcon
.L22:
            clr.l   (A2)
            rts
.L23:
            _DisposHandle
            bra.b   .L22
            move.l  A0,-(SP)
            _DisposControl
            bra.b   .L22
.L24:
            movea.l (-$4A,A6),A0
            tst.w   ($A4,A0)
            bmi.b   sub_4081A5F6.L1
            move.l  ($A0,A0),-(SP)
            move.w  ($A4,A0),-(SP)
            move.l  A0,-(SP)
            _SetPort
            move.w  (SP)+,D0
            bsr.w   sub_4081A7F2
            btst    #0,(-$3D,A6)
            beq.b   .L25
            _TEActivate
            bra.b   .L26
.L25:
            _TEDeactivate
.L26:
            bsr.w   sub_4081A91C
            move.l  A4,-(SP)
            _SetPort
            bra.b   sub_4081A5F6.L1
sub_4081A5F6:
            move.w  (-$4C,A6),D0
            subq.w  #1,D0
            beq.w   .L7
            subq.w  #2,D0
            beq.b   .L3
            subq.w  #2,D0
            beq.b   .L3
            subq.w  #1,D0
            beq.b   .L2
            subq.w  #2,D0
            beq.b   sub_4081A42C.L24
            tst.w   ($A4,A4)
            bmi.b   .L1
            move.w  ($A4,A4),D0
            bsr.w   sub_4081A7F2
            move.l  ($A0,A4),-(SP)
            _TEIdle
            bsr.w   sub_4081A91C
.L1:
            moveq   #-1,D3
            rts
.L2:
            move.l  A4,-(SP)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            _BeginUpDate
            _DrawDialog
            _EndUpDate
            bra.b   .L1
.L3:
            move.b  (-$47,A6),D1
            cmpi.b  #9,D1
            beq.b   .L4
            move.w  ($A4,A4),D3
            bmi.b   .L1
            bsr.w   SetUpText
            move.w  D1,-(SP)
            move.l  ($A0,A4),-(SP)
            _TEKey
            bsr.w   sub_4081A91C
            bra.w   .L11
.L4:
            clr.w   D5
            move.w  ($A4,A4),D3
            bsr.w   GetDLItem
.L5:
            bsr.w   sub_4081A9C0
            beq.b   .L6
            cmp.w   ($A4,A4),D3
            beq.b   .L1
            btst    #4,($C,A2)
            beq.b   .L5
            bsr.w   sub_4081A960
            beq.b   .L5
            move.l  #$7FFF,D2
            bsr.w   ChangeField
            bra.w   .L11
.L6:
            tst.w   D5
            bmi.b   .L1
            moveq   #-1,D5
            moveq   #-1,D3
            tst.w   ($A4,A4)
            bpl.b   .L5
            bra.b   .L1
.L7:
            move.l  (-$42,A6),(-$1C,A6)
            pea     (-$1C,A6)
            _GlobalToLocal
            moveq   #-1,D3
.L8:
            bsr.w   sub_4081A9C0
            beq.w   .L1
            subq.w  #2,SP
            move.l  (-$1C,A6),-(SP)
            pea     (-$28,A6)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L8
            btst    #2,($C,A2)
            beq.b   .L9
            subq.w  #2,SP
            move.l  (-$1C,A6),-(SP)
            move.l  A4,-(SP)
            pea     (-$18,A6)
            _FindControl
            move.w  (SP)+,D0
            beq.w   .L1
            subq.w  #2,SP
            move.l  (-$18,A6),-(SP)
            move.l  (-$1C,A6),-(SP)
            move.l  MinusOne,-(SP)
            _TrackControl
            tst.w   (SP)+
            beq.w   .L1
            bra.b   .L11
.L9:
            btst    #4,($C,A2)
            beq.b   .L11
            cmp.w   ($A4,A4),D3
            beq.b   .L10
            moveq   #0,D2
            bsr.b   ChangeField
.L10:
            tst.w   ($A4,A4)
            bmi.b   .L11
            move.w  ($A4,A4),D0
            bsr.w   sub_4081A7F2
            move.l  (-$1C,A6),-(SP)
            btst    #1,(-$3E,A6)
            sne     -(SP)
            move.l  ($A0,A4),-(SP)
            _TEClick
            bsr.w   sub_4081A91C
.L11:
            btst    #7,($C,A2)
            bne.w   .L1
            addq.w  #1,D3
            rts
ChangeField:
            tst.w   ($A4,A4)
            bmi.b   .L1
            move.w  ($A4,A4),D0
            bsr.w   sub_4081A7F2
            movea.l ($A0,A4),A0
            movea.l (A0),A0
            move.l  (8,A0),-(SP)
            move.l  (A0),-(SP)
            pea     (4,SP)
            _SubPt
            move.l  ($A0,A4),-(SP)
            _TEScroll
            move.l  ($A0,A4),-(SP)
            _TEDeactivate
            bsr.w   sub_4081A91C
.L1:
            bsr.b   sub_4081A78E
            tst.w   ($A4,A4)
            bmi.b   .L2
            move.w  ($A4,A4),D0
            bsr.b   sub_4081A7F2
            move.l  ($A0,A4),-(SP)
            _TEActivate
            bsr.w   sub_4081A91C
.L2:
            rts
sub_4081A788:
            cmp.w   ($A4,A4),D3
            beq.b   ChangeField.L2
sub_4081A78E:
            move.l  (A2),D0
            ble.b   ChangeField.L2
            move.w  D3,($A4,A4)
            bmi.b   ChangeField.L2
            movea.l ($A0,A4),A0
            movea.l (A0),A1
            move.l  D0,($3E,A1)
            moveq   #-2,D0
            cmp.l   D0,D2
            beq.b   .L1
            move.l  D2,($20,A1)
.L1:
            lea     (A1),A0
            move.l  (-$28,A6),(A0)+
            move.l  (-$24,A6),(A0)+
            move.l  (-$28,A6),(A0)+
            move.l  (-$24,A6),(A0)+
            st      ($32,A1)
            lea     (A1),A0
            moveq   #2,D0
            add.w   (A0)+,D0
            add.w   ($18,A1),D0
            move.w  (A0)+,D1
            cmp.w   (A0)+,D0
            blt.b   .L2
            tst.w   TESysJust
            bmi.b   .L2
            sub.w   (A0),D1
            sub.w   D1,(A0)
.L2:
            bsr.b   SetUpText
            st      -(SP)
            move.l  ($A0,A4),-(SP)
            _TEAutoView
            move.l  ($A0,A4),-(SP)
            _TECalText
            bsr.w   sub_4081A91C
            rts
sub_4081A7F2:
            move.l  D3,-(SP)
            move.w  D0,D3
            bsr.b   SetUpText
            move.l  (SP)+,D3
            rts
sub_4081A7FC:
            movem.l D0-D5/A0-A2/A4,-(SP)
            sf      D5
            bra.b   SetUpText.L1
SetUpText:
            movem.l D0-D5/A0-A2/A4,-(SP)
            st      D5
.L1:
            bsr.w   sub_4081A8EA
            movea.l (A5),A0
            movea.l (A0),A4
            subq.w  #6,SP
            move.l  A4,-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            move.l  (SP)+,D0
            beq.w   .L11
            movea.l D0,A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
            beq.w   .L11
            movea.l D0,A2
            movea.l (A2),A0
            moveq   #0,D0
            lea     (0,A0,D3.w*4),A1
            move.w  (A1),D4
            adda.w  (2,A1),A0
            move.l  A0,-(SP)
            bclr    #$F,(A1)
            beq.b   .L2
            movea.w (A0),A1
            adda.l  (A2),A1
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l A2,A0
            _HLock
            _GetFNum
            movea.l A2,A0
            _HUnlock
            movea.l (SP),A0
.L2:
            movea.l ($A0,A4),A2
            movea.l (A2),A2
            move.w  D4,D3
            asr.w   #1,D3
            bcc.b   .L3
            move.w  (A0),($44,A4)
            tst.b   D5
            beq.b   .L3
            move.w  (A0),($4A,A2)
.L3:
            asr.w   #1,D3
            bcc.b   .L4
            move.w  (2,A0),($46,A4)
            tst.b   D5
            beq.b   .L4
            move.w  (2,A0),($4C,A2)
.L4:
            tst.w   ($4A,A4)
            bne.b   .L5
            move.b  FMDefaultSize,($4B,A4)
.L5:
            btst    #4,D4
            bne.b   .L6
            asr.w   #1,D3
            bcc.b   .L7
            clr.w   ($4A,A4)
.L6:
            move.w  (4,A0),D0
            add.w   D0,($4A,A4)
            tst.b   D5
            beq.b   .L7
            move.w  ($4A,A4),($50,A2)
.L7:
            btst    #$E,D4
            beq.b   .L8
            move.w  ($12,A0),($48,A4)
            tst.b   D5
            beq.b   .L8
            move.w  ($12,A0),($4E,A2)
.L8:
            asr.w   #1,D3
            bcc.b   .L9
            pea     (6,A0)
            _RGBForeColor
.L9:
            btst    #$D,D4
            beq.b   .L10
            movea.l (SP),A0
            pea     ($C,A0)
            _RGBBackColor
.L10:
            addq.w  #4,SP
.L11:
            movem.l (SP)+,D0-D5/A0-A2/A4
            rts
sub_4081A8EA:
            pea     (-$60,A6)
            _GetForeColor
            pea     (-$66,A6)
            _GetBackColor
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($A0,A0),D1
            lea     ($44,A0),A0
            lea     (-$76,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l D1,A0
            movea.l (A0),A0
            lea     ($4A,A0),A0
            lea     (-$6E,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            rts
sub_4081A91C:
            movem.l D0-D2/A0-A1,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($A0,A0),A0
            movea.l (A0),A0
            lea     ($4A,A0),A0
            lea     (-$6E,A6),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            subq.w  #8,A1
            bra.b   sub_4081A93A.L1
sub_4081A93A:
            movem.l D0-D2/A0-A1,-(SP)
            lea     (-$76,A6),A1
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            lea     ($44,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            pea     (-$66,A6)
            _RGBBackColor
            pea     (-$60,A6)
            _RGBForeColor
            movem.l (SP)+,D0-D2/A0-A1
            rts
sub_4081A960:
            moveq   #0,D0
            bra.b   sub_4081A964.L1
sub_4081A964:
            move.l  #$FFFCFFFC,D0
.L1:
            move.l  (8,A2),-(SP)
            move.l  (4,A2),-(SP)
            move.l  SP,-(SP)
            move.l  D0,-(SP)
            _InsetRect
            clr.w   -(SP)
            pea     (2,SP)
            pea     ($10,A4)
            pea     ($A,SP)
            _SectRect
            move.b  (SP)+,D0
            addq.w  #8,SP
            rts
sub_4081A98E:
            move.l  A0,-(SP)
            move.w  D2,-(SP)
            move.w  D2,-(SP)
            move.l  A0,-(SP)
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            move.l  A0,-(SP)
            neg.w   D2
            move.w  D2,-(SP)
            move.w  D2,-(SP)
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            _PenSize
            _InsetRect
            _FrameRoundRect
            _InsetRect
            rts
sub_4081A9B0:
            movem.l D0-D2/A1-A2,-(SP)
            move.l  A0,-(SP)
            _NewString
            movea.l (SP)+,A0
            movem.l (SP)+,D1-D2/A1-A2
            rts
sub_4081A9C0:
            addq.w  #1,D3
            beq.b   GetDLItem
            move.l  D2,-(SP)
            moveq   #1,D0
            bra.b   GetDLItem.L1
GetDLItem:
            move.l  D2,-(SP)
            moveq   #0,D7
            move.w  D3,D0
            blt.b   .L2
.L1:
            moveq   #0,D2
            move.l  A3,D1
            beq.b   .L2
            movea.l (A3),A2
            move.w  (A2)+,D1
            cmp.w   D3,D1
            bge.b   .L4
.L2:
            suba.l  A2,A2
            bra.b   .L5
.L3:
            move.b  ($D,A2,D7.w),D2
            add.w   D2,D7
            addi.w  #$F,D7
            andi.w  #$FFFE,D7
.L4:
            dbra    D0,.L3
            adda.w  D7,A2
            bsr.b   sub_4081AA00
.L5:
            move.l  (SP)+,D2
            move.l  A2,D0
            rts
sub_4081AA00:
            lea     (4,A2),A0
            lea     (-$28,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            rts
DMGREND:
            dc.w    0

            EVEN
