            include "Include/ROMHeader.s"

            EXPORT  SetHandleSize_2,BlockMove_2,Delay_2,Dequeue_2,DisposHandle,DisposPtr
            EXPORT  Enqueue_2,GetHandleSize_2,HGetState,HLock_2,HSetState,NGETTRAPADDRESS
            EXPORT  NMInstall,NMRemove,NewSCPtr,NewSHandle,StripAddress_2,equalstring

            IMPORT  A

            SECTION "NotificationMgr_Libraries",CODE

NMInstall:
            movea.l (4,SP),A0
            _NMInstall
            rts
            ds.b    8
NMRemove:
            movea.l (4,SP),A0
            _NMRemove
            rts
            ds.b    8
NewSPtr:
            move.l  (4,SP),D0
            _NewPtrSys
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
NewCPtr:
            move.l  (4,SP),D0
            _NewPtrClear
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
NewSCPtr:
            move.l  (4,SP),D0
            _NewPtrSysClear
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
NewSHandle:
            move.l  (4,SP),D0
            _NewHandle sys
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
NewCHandle:
            move.l  (4,SP),D0
            _NewHandleClear
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
NewSCHandle:
            move.l  (4,SP),D0
            _NewHandleClear async
            move.w  D0,MemErr
            move.l  A0,D0
            rts
            dc.w    0
equalstring:
            link.w  A6,#0
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
            tst.b   (8,A6)
            beq.b   .L2
            tst.b   ($A,A6)
            beq.b   .L1
            _CmpString case
            bra.b   .L4
.L1:
            _CmpString
            bra.b   .L4
.L2:
            tst.b   ($A,A6)
            beq.b   .L3
            _CmpString case,marks
            bra.b   .L4
.L3:
            _CmpString marks
.L4:
            eori.b  #1,D0
            move.b  D0,($14,A6)
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
            ds.b    10
NGETTRAPADDRESS:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            move.w  (SP)+,D0
            move.l  A1,-(SP)
            tst.b   D1
            beq.b   .L1
            _GetToolBoxTrapAddress
            bra.b   .L2
.L1:
            _GetOSTrapAddress
.L2:
            move.l  A0,(4,SP)
            rts
            ds.b    8
DisposPtr:
            movea.l (4,SP),A0
            _DisposPtr
            move.w  D0,MemErr
            rts
            ds.b    4
DisposHandle:
            movea.l (4,SP),A0
            _DisposHandle
            move.w  D0,MemErr
            rts
            ds.b    4
HLock_2:
            movea.l (4,SP),A0
            _HLock
            move.w  D0,MemErr
            rts
            ds.b    4
HUnlock_2:
            movea.l (4,SP),A0
            _HUnlock
            move.w  D0,MemErr
            rts
            ds.b    4
SetHandleSize_2:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            _SetHandleSize
            move.w  D0,MemErr
            rts
GetHandleSize_2:
            movea.l (4,SP),A0
            _GetHandleSize
            rts
            ds.b    8
BlockMove_2:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            move.l  ($C,SP),D0
            _BlockMove
            move.w  D0,MemErr
            rts
            ds.b    12
HGetState:
            movea.l (4,SP),A0
            _HGetState
            rts
            ds.b    8
HSetState:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            _HSetState
            move.w  D0,MemErr
            rts
StripAddress_2:
            move.l  (4,SP),D0
            _StripAddress
            rts
            ds.b    8
Enqueue_2:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            _Enqueue
            rts
            ds.b    4
Dequeue_2:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            _Dequeue
            rts
            ds.b    4
Delay_2:
            movea.l (4,SP),A0
            _Delay
            move.l  D0,(8,SP)
            rts
            ds.b    4

            EVEN
