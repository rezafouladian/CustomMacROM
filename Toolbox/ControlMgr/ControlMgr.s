            include "Include/ROMHeader.s"

            EXPORT  DisposeControl,DragControl,DrawControls,DrawOneControl,FindControl,GetCRefCon
            EXPORT  GetCTitle,GetCtlAction,GetCtlMax,GetCtlMin,GetCtlValue,GetCVariant
            EXPORT  HideControl,HiliteControl,KillControls,MoveControl,NewControl,SetCRefCon
            EXPORT  SetCTitle,SetCtlAction,SetCtlMax,SetCtlMin,SetCtlValue,ShowControl
            EXPORT  SizeControl,TestControl,TrackControl,UpdtControls

            IMPORT  GetNewRgn,A

            SECTION "ControlMgr",CODE

NewControl:
CMGR:
            link.w  A6,#0
            movem.l D1/A2-A4,-(SP)
            lea     ($22,A6),A4
            moveq   #$29,D0
            moveq   #0,D1
            movea.l ($16,A6),A0
            move.b  (A0),D1
            add.l   D1,D0
            _NewHandle
            movea.l A0,A3
            move.l  A0,(A4)
            movea.l (A3),A2
            tst.b   MMU32bit
            beq.b   .L1
            sf      ($10,A2)
            move.l  A3,-(SP)
            move.l  #$FFFFFFFF,-(SP)
            _SetCtlColor
.L1:
            movea.l -(A4),A1
            move.l  A1,(4,A2)
            move.l  ($8C,A1),(A2)
            move.l  A3,($8C,A1)
            lea     (8,A2),A1
            movea.l -(A4),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            clr.b   ($10,A2)
            move.l  A3,-(SP)
            move.l  -(A4),-(SP)
            _SetCTitle
            movea.l (A3),A2
            lea     ($10,A2),A0
            subq.w  #2,A4
            tst.b   (A4)
            sne     (A0)+
            clr.b   (A0)+
            move.w  -(A4),(A0)+
            move.w  -(A4),(A0)+
            move.w  -(A4),(A0)+
            move.w  -(A4),D0
            lsr.w   #4,D0
.L2:
            subq.w  #4,SP
            move.l  #'CDEF',-(SP)
            move.w  D0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            moveq   #0,D0
            movea.l (A3),A0
            lea     ($18,A0),A0
            move.l  (SP)+,(A0)
            beq.b   .L2
            move.w  (A4),D0
            andi.w  #$F,D0
            tst.b   MMU32bit
            beq.b   .L3
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            subq.w  #6,SP
            move.l  A3,-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (SP)+,D0
            move.b  D0,($E,A0)
            movea.l (SP)+,A0
            bra.b   .L4
.L3:
            move.b  D0,(A0)
.L4:
            addq.w  #4,A0
            clr.l   (A0)+
            clr.l   (A0)+
            move.l  -(A4),(A0)+
            moveq   #3,D0
            bsr.b   CallControl
            tst.b   ($14,A6)
            beq.b   .L5
            moveq   #0,D1
            bsr.b   sub_40815E2C
.L5:
            movem.l (SP)+,D1/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($1A,SP),SP
            jmp     (A0)
sub_40815E2C:
            moveq   #0,D0
            movea.l (A3),A0
            tst.b   ($10,A0)
            beq.b   CallControl.L3
CallControl:
            bsr.w   OwnerPort
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            move.l  D1,-(SP)
            subq.w  #2,SP
            move.l  A3,-(SP)
            _GetCVariant
            move.w  (SP)+,($A,SP)
            movea.l (A3),A0
            move.l  ($18,A0),D0
            _StripAddress
            movea.l D0,A0
            tst.l   (A0)
            bne.b   .L1
            move.l  A0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _LoadResource
            tst.l   (A0)
            bne.b   .L1
            move.w  #$58,D0
            _SysError
.L1:
            _HLock
            movea.l (A0),A0
            jsr     (A0)
            movea.l (A3),A0
            movea.l ($18,A0),A0
            _HUnlock
            move.l  (SP)+,D0
.L2:
            _SetPort
.L3:
            rts
GetCVariant:
            movea.l (4,SP),A0
            tst.b   MMU32bit
            beq.b   .L1
            subq.w  #6,SP
            move.l  A0,-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            clr.w   D0
            move.b  ($E,A0),D0
            bra.b   .L2
.L1:
            movea.l (A0),A0
            move.b  ($18,A0),D0
            andi.w  #$F,D0
.L2:
            move.w  D0,(8,SP)
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
EraseControl:
            bsr.w   OwnerPort
            movem.l A1-A4,-(SP)
            _NewRgn
            movea.l (SP),A4
            tst.b   MMU32bit
            beq.b   .L1
            moveq   #$A,D0
            move.l  A4,D1
            bsr.w   CallControl
            bra.b   .L2
.L1:
            moveq   #2,D0
            move.l  A4,D1
            bclr    #$1F,D1
            bsr.w   CallControl
.L2:
            _EraseRgn
            move.l  A4,-(SP)
            _InvalRgn
            move.l  A4,-(SP)
            _DisposRgn
            movea.l (A3),A0
            clr.b   ($10,A0)
            movem.l (SP)+,A2-A4
            bra.b   CallControl.L2
DisposeControl:
            movem.l A2-A3,-(SP)
            movea.l ($C,SP),A3
            bsr.b   EraseControl
            move.l  A3,-(SP)
            clr.l   -(SP)
            clr.b   -(SP)
            clr.l   -(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (8,A0),-(SP)
            tst.b   MMU32bit
            beq.b   .L4
            lea     AuxCtlHead,A1
.L1:
            movea.l (A1),A2
            movea.l (A2),A0
            cmpa.l  (4,A0),A3
            beq.b   .L2
            lea     (A0),A1
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            movea.l A2,A1
            movea.l (A1),A1
            move.l  (8,A1),D0
            cmp.l   (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            _HGetState
            btst    #5,D0
            bne.b   .L3
            _DisposHandle
.L3:
            movea.l A2,A0
            _DisposHandle
            addq.w  #4,SP
            bra.b   .L5
.L4:
            _SetCtlColor
.L5:
            movea.l A3,A0
            movea.l (A3),A1
            movea.l (4,A1),A1
            lea     ($8C,A1),A1
            bsr.w   DeleteList
            moveq   #4,D0
            bsr.w   CallControl
            movea.l A3,A0
            _DisposHandle
            movem.l (SP)+,A2-A3
            move.l  (SP)+,(SP)
            rts
KillControls:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
.L1:
            move.l  ($8C,A3),D0
            beq.b   ShowControl.L2
            move.l  D0,-(SP)
            _DisposControl
            bra.b   .L1
DrawOneControl:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            movea.l (A3),A0
            tst.b   ($10,A0)
            beq.b   ShowControl.L2
            bra.b   ShowControl.L1
ShowControl:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            movea.l (A3),A0
            tst.b   ($10,A0)
            bne.b   .L2
            st      ($10,A0)
.L1:
            moveq   #0,D1
            bsr.w   sub_40815E2C
.L2:
            movea.l (SP)+,A3
            move.l  (SP)+,(SP)
            rts
HideControl:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            movea.l (A3),A0
            tst.b   ($10,A0)
            beq.b   ShowControl.L2
            bsr.w   EraseControl
            bra.b   ShowControl.L2
MoveControl:
            movem.l D3/A3,-(SP)
            movea.l ($10,SP),A3
            movea.l (A3),A0
            move.b  ($10,A0),D3
            move.l  A3,-(SP)
            _HideControl
            movea.l (A3),A0
            addq.w  #8,A0
            move.w  ($C,SP),D0
            sub.w   (A0),D0
            move.w  ($E,SP),D1
            sub.w   (2,A0),D1
            move.l  A0,-(SP)
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            _OffsetRect
.L1:
            tst.b   D3
            beq.b   .L2
            move.l  A3,-(SP)
            _ShowControl
.L2:
            movem.l (SP)+,D3/A3
.L3:
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
GetCRefCon:
            moveq   #$24,D1
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.l  (0,A1,D1.w),(SP)
            jmp     (A0)
SetCRefCon:
            moveq   #$24,D1
.L1:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.l  D0,(0,A1,D1.w)
            jmp     (A0)
GetCtlAction:
            moveq   #$20,D1
            bra.b   GetCRefCon.L1
SetCtlAction:
            moveq   #$20,D1
            bra.b   SetCRefCon.L1
SizeControl:
            movem.l D3/A3,-(SP)
            movea.l ($10,SP),A3
            movea.l (A3),A0
            move.b  ($10,A0),D3
            move.l  A3,-(SP)
            _HideControl
            move.w  ($C,SP),D0
            move.w  ($E,SP),D1
            movea.l (A3),A0
            addq.w  #8,A0
            add.w   (A0)+,D0
            add.w   (A0)+,D1
            move.w  D0,(A0)+
            move.w  D1,(A0)+
            bra.b   MoveControl.L1
HiliteControl:
            move.l  A3,-(SP)
            movea.l ($A,SP),A3
            movea.l (A3),A0
            moveq   #0,D1
            moveq   #0,D0
            move.b  (9,SP),D1
            move.b  ($11,A0),D0
            cmp.b   D0,D1
            beq.b   .L2
            move.b  D1,($11,A0)
            bne.b   .L1
            move.w  D0,D1
.L1:
            bsr.w   sub_40815E2C
.L2:
            movea.l (SP)+,A3
.L3:
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
GetCTitle:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            movea.l (A0),A0
            lea     ($28,A0),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            _BlockMove
            rts
SetCTitle:
            movem.l D3/A3-A4,-(SP)
            movea.l ($14,SP),A3
            movea.l (A3),A0
            move.b  ($10,A0),D3
            move.l  A3,-(SP)
            _HideControl
            movea.l ($10,SP),A4
            moveq   #0,D0
            move.b  (A4),D0
            move.l  D0,-(SP)
            addi.w  #$29,D0
            movea.l A3,A0
            _SetHandleSize
            move.l  (SP)+,D0
            movea.l A4,A0
            movea.l (A3),A1
            lea     ($28,A1),A1
            addq.w  #1,D0
            _BlockMove
            tst.b   D3
            beq.b   .L1
            move.l  A3,-(SP)
            _ShowControl
.L1:
            movem.l (SP)+,D3/A3-A4
            bra.w   MoveControl.L3
GetCtlValue:
            moveq   #$12,D0
.L1:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.w  (0,A0,D0.w),(SP)
            jmp     (A1)
GetCtlMin:
            moveq   #$14,D0
            bra.b   GetCtlValue.L1
GetCtlMax:
            moveq   #$16,D0
            bra.b   GetCtlValue.L1
SetCtlValue:
            moveq   #$12,D0
.L1:
            move.l  A3,-(SP)
            movea.l ($A,SP),A3
            move.w  (8,SP),D1
            movea.l (A3),A0
            cmp.w   (0,A0,D0.w),D1
            beq.b   .L4
            move.w  D1,(0,A0,D0.w)
            move.w  ($12,A0),D1
            cmp.w   ($14,A0),D1
            bge.b   .L2
            move.w  ($14,A0),D1
.L2:
            cmp.w   ($16,A0),D1
            ble.b   .L3
            move.w  ($16,A0),D1
.L3:
            move.w  D1,($12,A0)
            move.w  #$81,D1
            bsr.w   sub_40815E2C
.L4:
            movea.l (SP)+,A3
            bra.w   HiliteControl.L3
SetCtlMin:
            moveq   #$14,D0
            bra.b   SetCtlValue.L1
SetCtlMax:
            moveq   #$16,D0
            bra.b   SetCtlValue.L1
TestControl:
            move.l  A3,-(SP)
            movea.l ($C,SP),A3
            movea.l (A3),A0
            clr.w   ($10,SP)
            move.b  ($10,A0),D1
            beq.b   .L1
            cmpi.b  #$FF,($11,A0)
            beq.b   .L1
            move.l  (8,SP),D1
            moveq   #1,D0
            bsr.w   CallControl
            move.w  D0,($10,SP)
.L1:
            movea.l (SP)+,A3
            bra.w   MoveControl.L3
DragControl:
            clr.w   DragFlag
DragCon1:
            link.w  A6,#0
            movem.l D3-D4/A3-A4,-(SP)
            movem.l ($E,A6),D3-D4/A3
            bsr.w   OwnerPort
            move.w  DragFlag,D1
            moveq   #7,D0
            bsr.w   CallControl
            tst.w   D0
            bne.b   .L5
            jsr     (GetNewRgn.w,PC)
            tst.b   MMU32bit
            beq.b   .L2
            moveq   #$A,D0
            tst.w   DragFlag
            beq.b   .L1
            moveq   #$B,D0
.L1:
            move.l  (SP),D1
            bsr.w   CallControl
            bra.b   .L3
.L2:
            tst.w   DragFlag
            sne     (SP)
            move.l  (SP),D1
            moveq   #2,D0
            bsr.w   CallControl
            clr.b   (SP)
.L3:
            movea.l (SP)+,A4
            movem.l D3-D4/A4-A5,-(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            move.l  CurDragAction,-(SP)
            tst.w   DragFlag
            bne.b   .L4
            clr.l   (SP)
.L4:
            _DragTheRgn
            move.l  A4,-(SP)
            _DisposRgn
            move.l  (SP)+,D3
            beq.b   .L7
            cmpi.w  #$8000,D3
            bne.b   .L6
.L5:
            moveq   #0,D3
            bra.b   .L7
.L6:
            tst.w   DragFlag
            bne.b   .L7
            movea.l (A3),A0
            move.l  (8,A0),D0
            add.w   D3,D0
            swap    D0
            swap    D3
            add.w   D3,D0
            swap    D0
            move.l  A3,-(SP)
            move.l  D0,-(SP)
            _MoveControl
.L7:
            _SetPort
            move.l  D3,D1
            movem.l (SP)+,D3-D4/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($12,SP),SP
            jmp     (A0)
OwnerPort:
            move.l  (SP)+,D2
            subq.w  #4,SP
            move.l  D2,-(SP)
            movem.l D0-D1,-(SP)
            pea     ($C,SP)
            _GetPort
            movea.l (A3),A0
            move.l  (4,A0),-(SP)
            _SetPort
            movem.l (SP)+,D0-D1
            rts
TrackControl:
            link.w  A6,#-$1C
            movem.l D3/A3,-(SP)
            movea.l ($10,A6),A3
            move.l  ($C,A6),(-8,A6)
            bsr.b   OwnerPort
            moveq   #0,D3
.L1:
            move.l  A3,-(SP)
            clr.w   -(SP)
            move.l  A3,-(SP)
            move.l  (-8,A6),-(SP)
            _TestControl
            tst.w   D3
            bne.b   .L2
            move.w  (SP),D3
            tst.b   D3
            bpl.b   .L3
            bra.b   .L7
.L2:
            cmp.w   (SP),D3
            beq.b   .L3
            clr.w   (SP)
.L3:
            move.w  (SP),($14,A6)
            _HiliteControl
            move.l  (8,A6),D0
            beq.b   .L5
            btst    #0,D0
            beq.b   .L4
            movea.l (A3),A0
            move.l  ($20,A0),D0
            beq.b   .L5
            btst    #0,D0
            beq.b   .L4
            moveq   #8,D0
            move.w  ($14,A6),D1
            bsr.w   CallControl
            bra.b   .L5
.L4:
            move.l  A3,-(SP)
            move.w  ($14,A6),-(SP)
            movea.l D0,A0
            jsr     (A0)
.L5:
            pea     (-8,A6)
            _GetMouse
            clr.w   -(SP)
            _WaitMouseUp
            tst.b   (SP)+
            bne.b   .L1
            move.l  A3,-(SP)
            clr.w   -(SP)
            _HiliteControl
.L6:
            _SetPort
            movem.l (SP)+,D3/A3
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L7:
            move.w  (SP)+,($14,A6)
            addq.w  #4,SP
            lea     (-$1C,A6),A0
            move.l  ($C,A6),(A0)
            move.l  A0,D1
            moveq   #6,D0
            bsr.w   CallControl
            st      DragFlag
            move.l  (8,A6),D0
            btst    #0,D0
            beq.b   .L8
            movea.l (A3),A0
            move.l  ($20,A0),D0
            btst    #0,D0
            beq.b   .L8
            moveq   #0,D0
.L8:
            move.l  D0,CurDragAction
            move.l  A3,-(SP)
            move.l  ($C,A6),-(SP)
            lea     (-$1C,A6),A0
            move.l  A0,-(SP)
            pea     (8,A0)
            move.w  ($10,A0),-(SP)
            bsr.w   DragCon1
            tst.l   D1
            beq.b   .L9
            moveq   #5,D0
            bsr.w   CallControl
            bra.b   .L6
.L9:
            clr.w   ($14,A6)
            bra.b   .L6
UpdtControls:
            link.w  A6,#-$18
            movem.l D7/A3,-(SP)
            movea.l ($C,A6),A3
            moveq   #8,D7
            bra.b   DrawControls.L1
DrawControls:
            link.w  A6,#-$18
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            moveq   #4,D7
.L1:
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            move.l  A3,-(SP)
            _SetPort
            pea     (-$18,A6)
            move.l  (SP),-(SP)
            _GetPenState
            _PenNormal
            move.l  ($8C,A3),D0
            beq.b   .L5
.L2:
            movea.l D0,A3
            cmpi.w  #8,D7
            bne.b   .L3
            subq.w  #2,SP
            movea.l (A3),A0
            pea     (8,A0)
            move.l  (8,A6),-(SP)
            _RectInRgn
            tst.b   (SP)+
            beq.b   .L4
.L3:
            moveq   #0,D1
            bsr.w   sub_40815E2C
.L4:
            movea.l (A3),A0
            move.l  (A0),D0
            bne.b   .L2
.L5:
            _SetPenState
            _SetPort
            move.l  D7,D0
            movem.l (SP)+,D7/A3
            unlk    A6
            movea.l (SP)+,A0
            adda.l  D0,SP
            jmp     (A0)
DeleteList:
            movem.l D1/A2-A3,-(SP)
            moveq   #-1,D0
            tst.l   (A1)
            beq.b   .L3
            movea.l (A1),A2
            movea.l A1,A3
            bra.b   .L2
.L1:
            movea.l (A2),A3
            movea.l (A3),A2
            move.l  A2,D1
            beq.b   .L3
.L2:
            cmpa.l  A0,A2
            bne.b   .L1
            movea.l (A2),A2
            move.l  (A2),(A3)
            moveq   #0,D0
.L3:
            movem.l (SP)+,D1/A2-A3
            rts
FindControl:
            link.w  A6,#-4
            movem.l D2-D3/A3,-(SP)
            lea     (8,A6),A0
            movea.l (A0)+,A1
            clr.l   (A1)
            movea.l (A0)+,A3
            move.l  (A0)+,D3
            clr.w   (A0)
            move.l  SP,-(SP)
            _GetPort
            move.l  A3,-(SP)
            _SetPort
            tst.b   ($6E,A3)
            beq.w   TrackControl.L6
            clr.w   -(SP)
            move.l  D3,-(SP)
            pea     ($10,A3)
            _PtInRect
            tst.b   (SP)+
            beq.w   TrackControl.L6
            move.l  ($8C,A3),D0
            beq.w   TrackControl.L6
            movea.l D0,A3
.L1:
            movea.l (A3),A0
            cmpi.b  #$FF,($11,A0)
            beq.b   .L2
            clr.w   -(SP)
            move.l  A3,-(SP)
            move.l  D3,-(SP)
            _TestControl
            move.w  (SP)+,D0
            bne.b   .L3
.L2:
            movea.l (A3),A0
            movea.l (A0),A3
            move.l  A3,D0
            bne.b   .L1
            bra.w   TrackControl.L6
.L3:
            movea.l (8,A6),A0
            move.l  A3,(A0)
            move.w  D0,($14,A6)
            bra.b   .L2
CMGREND:
            ds.b    6

            EVEN
