            include "Include/ROMHeader.s"

            EXPORT  Button,EventAvail,GetKeys,GetMouse,GetNextEvent,StillDown
            EXPORT  TickCount,WaitMouseUp,WaitNextEvent

            IMPORT  A

            SECTION "ToolboxEventMgr",CODE

GetKeys:
MISCMGR:
            movea.l (4,SP),A1
            lea     KeyMap,A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l (4,SP),A1
            moveq   #3,D1
            bsr.b   GetJournal
            move.l  (SP)+,(SP)
            rts
Button:
            lea     (4,SP),A1
            clr.w   (A1)
            tst.b   MBState
            bmi.b   .L1
            addq.b  #1,(A1)
.L1:
            moveq   #2,D1
            bra.b   GetJournal
TickCount:
            lea     (4,SP),A1
            move.l  Ticks,(A1)
            moveq   #0,D1
GetJournal:
            move.w  JournalFlag,D0
            beq.b   .L4
            bpl.b   .L1
            moveq   #$10,D0
            bra.b   .L2
.L1:
            moveq   #$11,D0
.L2:
            suba.w  #$28,SP
            lea     ($18,SP),A0
            move.w  JournalRef,(A0)+
            move.w  D0,(A0)+
            move.l  A1,(A0)+
            move.w  D1,(A0)+
            move.w  D3,(A0)+
            movea.l SP,A0
            _Control immed
            lea     ($28,SP),SP
            bne.b   .L3
            rts
.L3:
            clr.w   JournalFlag
            st      CrsrCouple
.L4:
            rts
GetMouse:
            movea.l (4,SP),A1
            move.l  Mouse,(A1)
            moveq   #1,D1
            bsr.b   GetJournal
            move.l  (4,SP),-(SP)
            _GlobalToLocal
            move.l  (SP)+,(SP)
            rts
StillDown:
            link.w  A6,#-$14
            clr.w   (8,A6)
            subq.w  #2,SP
            _Button
            tst.w   (SP)+
            beq.b   .L1
            subq.w  #2,SP
            move.w  #7,-(SP)
            pea     (-$14,A6)
            _EventAvail
            tst.w   (SP)+
            bne.b   .L1
            addq.b  #1,(8,A6)
.L1:
            unlk    A6
            rts
WaitMouseUp:
            link.w  A6,#-$14
            clr.w   -(SP)
            _StillDown
            move.w  (SP)+,(8,A6)
            bne.b   .L1
            subq.w  #2,SP
            move.w  #4,-(SP)
            pea     (-$14,A6)
            _GetNextEvent
.L1:
            unlk    A6
            rts
EventAvail:
            moveq   #-1,D0
            bra.b   GNECommon
GetNextEvent:
            movem.l (SP)+,D0-D2
            subq.w  #2,SP
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            movem.l D1-D2,-(SP)
            moveq   #0,D0
            bsr.b   GNECommon
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            move.w  D0,(4,SP)
            move.l  GNEFilter,-(SP)
            bne.b   .L1
            addq.w  #4,SP
.L1:
            rts
GNECommon:
            link.w  A6,#0
            movem.l D3/A3,-(SP)
            move.l  D0,D3
            bne.b   .L1
            bset    #7,DSWndUpdate
            bne.b   .L1
            tst.b   GrafEnd
            bne.b   .L1
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            move.l  WMgrPort,-(SP)
            _SetPort
            subq.w  #4,SP
            _FrontWindow
            subq.w  #4,SP
            _NewRgn
            movea.l (SP),A3
            pea     DSAlertRect
            _RectRgn
            move.l  A3,-(SP)
            _PaintBehind
            move.l  A3,-(SP)
            _DisposRgn
            _SetPort
.L1:
            clr.w   ($E,A6)
            movea.l (8,A6),A3
            move.w  ($C,A6),D0
            movea.l A3,A0
            bsr.w   sub_40815C10
            beq.b   .L2
            addq.b  #1,($E,A6)
            bra.b   .L6
.L2:
            move.w  ($C,A6),D0
            movea.l A3,A0
            tst.w   D3
            bpl.b   .L3
            _OSEventAvail
            bra.b   .L4
.L3:
            _GetOSEvent
.L4:
            movea.l A3,A1
            moveq   #4,D1
            bsr.w   GetJournal
            tst.w   (A3)
            beq.b   .L5
            addq.b  #1,($E,A6)
            bra.b   .L6
.L5:
            move.w  ($C,A6),D0
            btst    #6,D0
            beq.b   .L6
            clr.w   -(SP)
            move.l  A3,-(SP)
            _CheckUpDate
            move.w  (SP)+,($E,A6)
.L6:
            tst.w   D3
            bmi.w   .L12
            tst.w   ($E,A6)
            beq.b   .L12
            moveq   #$B,D1
            and.b   ($E,A3),D1
            subq.b  #3,D1
            bne.b   .L10
            move.b  (4,A3),D0
            cmpi.b  #$3F,D0
            bhi.b   .L10
            move.b  (5,A3),D1
            subi.b  #$30,D1
            cmpi.b  #$A,D1
            bcc.b   .L10
            move.w  (A3),D0
            subq.w  #4,D0
            beq.b   .L9
            addq.w  #1,D0
            bne.b   .L10
            subq.w  #4,SP
            move.l  #'FKEY',-(SP)
            move.w  D1,-(SP)
            _GetResource
            move.l  (SP)+,D0
            bne.b   .L8
            cmpi.w  #2,D1
            bgt.b   .L9
            tst.w   D1
            bmi.b   .L9
            bne.b   .L7
            moveq   #3,D1
.L7:
            moveq   #1,D2
            movea.l ($7DC).w,A0
            jsr     (A0)
            bra.b   .L9
.L8:
            movea.l D0,A0
            move.l  (A0),D0
            beq.b   .L9
            _HLock
            move.l  A0,-(SP)
            movea.l (A0),A0
            jsr     (A0)
            movea.l (SP)+,A0
            _HUnlock
.L9:
            clr.w   (A3)
            bra.b   .L11
.L10:
            tst.b   SEvtEnb
            beq.b   .L12
            subq.w  #2,SP
            move.l  A3,-(SP)
            _SystemEvent
            tst.w   (SP)+
            beq.b   .L12
.L11:
            clr.w   ($E,A6)
.L12:
            btst    #7,SCSIPoll
            bne.b   .L13
            cmpi.l  #$4B0,Ticks
            bcs.b   .L13
            bset    #7,SCSIPoll
            bsr.w   sub_40815C7A
.L13:
            tst.w   (A3)
            bne.b   .L14
            pea     Scratch8
            _GetMouse
.L14:
            movem.l (SP)+,D3/A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
sub_40815C10:
            btst    #8,D0
            beq.b   .L4
            move.l  CurDeactive,D1
            bgt.b   .L6
            move.l  CurActivate,D1
            ble.b   .L4
            moveq   #1,D2
.L1:
            moveq   #0,D0
            _OSEventAvail
            move.w  #8,(A0)+
            move.l  D1,(A0)
            move.l  CurDeactive,D0
            beq.b   .L2
            move.w  CurDeKind,D0
            move.l  CurActivate,D1
            beq.b   .L2
            movea.l D1,A0
            move.w  ($6C,A0),D1
            eor.w   D0,D1
            bpl.b   .L2
            addq.w  #2,D2
.L2:
            move.w  ($E,A3),D0
            andi.w  #$FFFC,D0
            or.w    D2,D0
            move.w  D0,($E,A3)
            tst.w   D3
            bne.b   .L3
            lsr.w   #1,D0
            bcc.b   .L5
            bset    #7,CurActivate
.L3:
            moveq   #-1,D1
            rts
.L4:
            moveq   #0,D1
            rts
.L5:
            bset    #7,CurDeactive
            bra.b   .L3
.L6:
            clr.w   D2
            bra.b   .L1
sub_40815C7A:
            clr.l   -(SP)
            clr.l   -(SP)
            move.w  #1,-(SP)
            _SCSIDispatch
            tst.w   (SP)
            bne.b   .L2
            move.b  SCSIPoll,D0
            andi.b  #7,D0
            move.w  D0,-(SP)
            move.w  #2,-(SP)
            _SCSIDispatch
            tst.w   (SP)
            beq.b   .L1
            movea.w #4,A0
            _InternalWait
            bra.b   .L2
.L1:
            pea     (2,SP)
            move.w  #6,-(SP)
            move.w  #3,-(SP)
            _SCSIDispatch
            pea     (2,SP)
            pea     (8,SP)
            moveq   #$3C,D0
            move.l  D0,-(SP)
            move.w  #4,-(SP)
            _SCSIDispatch
            movea.w #5,A0
            _InternalWait
.L2:
            addq.l  #8,SP
            rts
            dc.w    0
WaitNextEvent:
            link.w  A6,#0
            movem.l D3-D4/A2,-(SP)
            moveq   #-1,D4
            move.l  Ticks,D3
            add.l   ($C,A6),D3
            bcc.b   .L1
            moveq   #-1,D3
.L1:
            movea.l ($10,A6),A2
.L2:
            _SystemTask
            subq.w  #2,SP
            move.w  ($14,A6),-(SP)
            move.l  A2,-(SP)
            _GetNextEvent
            move.b  (SP)+,($16,A6)
            bne.b   .L3
            cmp.l   (6,A2),D3
            bls.b   .L3
            move.l  (8,A6),D0
            beq.b   .L2
            cmp.l   ($A,A2),D4
            beq.b   .L2
            move.l  ($A,A2),D4
            subq.w  #2,SP
            move.l  ($A,A2),-(SP)
            move.l  D0,-(SP)
            _PtInRgn
            tst.b   (SP)+
            bne.b   .L2
            move.w  ($14,A6),D0
            btst    #$F,D0
            beq.b   .L3
            move.w  #$F,(A2)
            move.l  #$FA000000,(2,A2)
            st      ($16,A6)
.L3:
            movem.l (SP)+,D3-D4/A2
            unlk    A6
            movea.l (SP),A0
            lea     ($12,SP),SP
            jmp     (A0)
            ds.b    8

            EVEN
