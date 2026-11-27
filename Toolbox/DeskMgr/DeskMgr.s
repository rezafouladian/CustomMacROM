            include "Include/ROMHeader.s"

            EXPORT  CloseDeskAcc,DeskMgr,OpenDeskAcc,SystemClick,SystemEdit,SystemMenu
            EXPORT  SystemTask

            IMPORT  NMTask,A

            SECTION "DeskMgr",CODE

DeskMgr:
SystemEvent:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            clr.w   ($C,SP)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            move.w  (A3),D0
            cmpi.w  #$C,D0
            bcc.b   sub_4081C774.L2
            add.w   D0,D0
            lea     sub_4081C774,A0
            adda.w  (0,A0,D0.w),A0
            jmp     (A0)
sub_4081C774:
            ori.b   #$1C,(A4)+
            ori.b   #$24,-(A4)
            ori.b   #$24,-(A4)
            ori     #$88,SR
            ori     #$1C,SR
            ori.b   #$24,-(A4)
.L1:
            addq.b  #1,($10,SP)
.L2:
            _SetPort
            movea.l (SP)+,A3
            move.l  (SP)+,(SP)
            rts
            subq.w  #4,SP
            _FrontWindow
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            bsr.b   SearchWindow
            bne.b   .L2
            move.w  (A3),D0
            move.w  ($24,A1),D1
            btst    D0,D1
            beq.b   .L2
            bsr.b   sub_4081C7D0
            bra.b   .L1
SearchWindow:
            move.w  ($6C,A0),D0
            bpl.b   .L1
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A0
            movea.l (0,A0,D0.w),A0
            movea.l (A0),A1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
sub_4081C7D0:
            moveq   #$40,D0
SendDCommon:
            link.w  A6,#-$20
            lea     (-8,A6),A0
            move.w  ($18,A1),(A0)+
            move.w  D0,(A0)+
            move.l  A3,(A0)
            lea     (-$20,A6),A0
            _Control immed
            unlk    A6
            rts
sub_4081C7EC:
            moveq   #$41,D0
            bra.b   SendDCommon
            movea.l (2,A3),A0
            bsr.b   SearchWindow
            bne.b   sub_4081C774.L2
            bsr.b   sub_4081C7D0
            bra.b   sub_4081C774.L1
            tst.w   (2,A3)
            beq.b   .L1
            movea.l ($7DC).w,A0
            move.w  (4,A3),D1
            moveq   #1,D2
            jsr     (A0)
            bra.w   sub_4081C774.L1
.L1:
            suba.w  #$18,SP
            movea.l SP,A0
            move.w  (4,A3),($16,A0)
            _MountVol
            lea     ($18,SP),SP
            move.w  D0,(2,A3)
            bra.w   sub_4081C774.L2
SystemClick:
            movem.l D0/D3-D4/A3-A4,-(SP)
            move.l  SP,-(SP)
            _GetPort
            movea.l ($18,SP),A4
            movea.l ($7E,A4),A3
            move.l  ($1C,SP),D4
            move.l  A4,D0
            beq.w   .L2
            movea.l A4,A0
            bsr.w   SearchWindow
            bne.b   .L1
            move.l  A1,D3
            moveq   #0,D0
            move.b  ($7E,A4),D0
            clr.l   -(SP)
            move.w  D0,-(SP)
            move.l  A4,-(SP)
            move.w  #1,-(SP)
            movea.l D4,A0
            move.l  ($A,A0),-(SP)
            move.l  A3,-(SP)
            _LoadResource
            movea.l A3,A0
            _HLock
            movea.l (A3),A0
            jsr     (A0)
            movea.l A3,A0
            _HUnlock
            move.l  (SP)+,D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L4
            subq.w  #2,D0
            beq.b   .L5
            clr.l   -(SP)
            _FrontWindow
            move.l  (SP)+,D0
            cmp.l   A4,D0
            bne.b   .L3
            movea.l D4,A3
            movea.l D3,A1
            bsr.w   sub_4081C7D0
.L1:
            _SetPort
            movem.l (SP)+,D3-D4/A3-A4
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
.L2:
            tst.l   DeskHook
            beq.b   .L1
            move.l  WMgrPort,-(SP)
            _SetPort
            move.l  GrayRgn,-(SP)
            _SetClip
            clr.l   -(SP)
            _ClipAbove
            movea.l D4,A0
            movea.l DeskHook,A1
            moveq   #-1,D0
            jsr     (A1)
            bra.b   .L1
.L3:
            move.l  A4,-(SP)
            _SelectWindow
            bra.b   .L1
.L4:
            move.l  A4,-(SP)
            movea.l D4,A0
            move.l  ($A,A0),-(SP)
            movea.l (A5),A0
            pea     (-$74,A0)
            _DragWindow
            bra.b   .L1
.L5:
            clr.w   -(SP)
            move.l  A4,-(SP)
            movea.l D4,A0
            move.l  ($A,A0),-(SP)
            _TrackGoAway
            tst.b   (SP)+
            beq.b   .L1
            movea.l D3,A1
            move.l  ($A88).w,D0
            bne.b   .L6
            move.w  ($18,A1),-(SP)
            _CloseDeskAcc
            bra.b   .L1
.L6:
            movea.l D0,A0
            jsr     (A0)
            bra.b   .L1
SystemTask:
            jsr     (NMTask.w,PC)
            movem.l D3/A3,-(SP)
            bset    #7,TaskLock
            bne.w   .L5
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            clr.l   -(SP)
            _FrontWindow
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            bsr.w   SearchWindow
            bne.b   .L1
            btst    #7,(5,A1)
            bne.b   .L1
            moveq   #$42,D0
            bsr.w   SendDCommon
.L1:
            movea.l UTableBase,A3
            move.w  UnitNtryCnt,D3
.L2:
            move.l  (A3)+,D0
            beq.b   .L4
            movea.l D0,A0
            movea.l (A0),A1
            move.w  (4,A1),D0
            andi.w  #$20A0,D0
            cmpi.w  #$2020,D0
            bne.b   .L4
            moveq   #0,D0
            move.w  ($22,A1),D0
            beq.b   .L3
            add.l   ($1A,A1),D0
            cmp.l   Ticks,D0
            bgt.b   .L4
            move.l  Ticks,($1A,A1)
.L3:
            bsr.w   sub_4081C7EC
.L4:
            subq.w  #1,D3
            bgt.b   .L2
            _SetPort
            clr.b   TaskLock
.L5:
            movem.l (SP)+,D3/A3
            rts
SystemMenu:
            movem.l A2-A3,-(SP)
            move.l  ($C,SP),D1
            swap    D1
            move.w  MBarEnable,D0
            beq.b   .L1
            move.w  D0,D1
.L1:
            movea.l UTableBase,A2
            move.w  UnitNtryCnt,D2
.L2:
            move.l  (A2)+,D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A1
            btst    #5,(5,A1)
            beq.b   .L3
            cmp.w   ($26,A1),D1
            bne.b   .L3
            movea.l ($C,SP),A3
            moveq   #$43,D0
            bsr.w   SendDCommon
            bra.b   .L4
.L3:
            subq.w  #1,D2
            bgt.b   .L2
.L4:
            movem.l (SP)+,A2-A3
            move.l  (SP)+,(SP)
            rts
SystemEdit:
            clr.w   (6,SP)
            subq.w  #8,SP
            pea     (4,SP)
            _GetPort
            _FrontWindow
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            bsr.w   SearchWindow
            bne.b   .L1
            move.w  (8,SP),D0
            addi.w  #$44,D0
            bsr.w   SendDCommon
            addq.b  #1,($A,SP)
.L1:
            _SetPort
            bra.b   CloseDeskAcc.L1
OpenDeskAcc:
            clr.w   (8,SP)
            suba.w  #$20,SP
            move.l  ($24,SP),($12,SP)
            clr.w   ($16,SP)
            move.w  #$40,($1A,SP)
            clr.l   ($1C,SP)
            movea.l SP,A0
            _Open
            bne.b   .L1
            move.w  ($18,SP),D0
            move.w  D0,($28,SP)
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w),A1
            movea.l (A1),A1
            move.l  ($1E,A1),D0
            beq.b   .L1
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            _SelectWindow
            _ShowWindow
.L1:
            lea     ($20,SP),SP
            move.l  (SP)+,(SP)
            rts
CloseDeskAcc:
            move.w  (4,SP),D0
            suba.w  #$1E,SP
            move.w  D0,($18,SP)
            movea.l SP,A0
            _Close
            lea     ($1E,SP),SP
.L1:
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
            dc.w    0

            EVEN
