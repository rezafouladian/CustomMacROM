            include "Include/ROMHeader.s"

            EXPORT  BlockInts,CALCULATESLOD,CallPascal,CancelDriftOfTimer,DisposPtr_2,GestaltCall
            EXPORT  GetHandleSize_3,GetTMRecordPtr,HGetState_2,HLock_3,HoldMemory,HSetState_2
            EXPORT  inAppHeap,InstallSoundIntHandler,InstallXTimer,MemError,MoveHHi_2,NewSysHandle
            EXPORT  NewSysPtr,RecoverHandle_2,RemoveXTimer,SetHandleSize_3,SetNextInterrupt,SLODMULTIPLIERS
            EXPORT  SMGlobalLoc,SndAllOff,StripAddress_3,UnBlockInts,UnholdMemory,WaitBit

            SECTION "SoundMgrGlue",CODE

CallPascal:
CALLCALLBACKROUTINE:
CALLMODIFIERROUTINE:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            jmp     (A1)
            ds.b    8
InstallXTimer:
TimerCode:
            movea.l (4,SP),A0
            _InsXTime
            rts
GetTMRecordPtr:
            move.l  A1,D0
            rts
CancelDriftOfTimer:
            movea.l (4,SP),A0
            _RmvTime
            clr.l   ($E,A0)
            _InsXTime
            rts
SetNextInterrupt:
            movea.l ($10,SP),A0
            tst.l   (8,SP)
            bne.b   .L2
            move.w  (4,A0),D0
            btst    #$F,D0
            bne.b   .L1
            move.l  ($C,SP),D0
            neg.l   D0
            _PrimeTime
.L1:
            rts
.L2:
            move.w  (4,A0),D0
            btst    #$F,D0
            beq.b   .L3
            _RmvTime
            clr.l   ($E,A0)
            _InsXTime
.L3:
            move.l  ($C,SP),D0
            neg.l   D0
            _PrimeTime
            rts
RemoveXTimer:
            movea.l (4,SP),A0
            _RmvTime
            rts
            ds.b    4
NewPtr_2:
            move.l  (4,SP),D0
            _NewPtrClear
            move.l  A0,D0
            rts
            ds.b    6
NewSysPtr:
            move.l  (4,SP),D0
            _NewPtrSysClear
            move.l  A0,D0
            rts
            ds.b    6
NewSysHandle:
            move.l  (4,SP),D0
            _NewHandleClear async
            move.l  A0,D0
            rts
            ds.b    6
DisposPtr_2:
            movea.l (4,SP),A0
            _DisposPtr
            rts
            ds.b    8
HLock_3:
            movea.l (4,SP),A0
            _HLock
            rts
            ds.b    8
HUnlock_3:
            movea.l (4,SP),A0
            _HUnlock
            rts
            ds.b    8
MoveHHi_2:
            movea.l (4,SP),A0
            _MoveHHi
            rts
            ds.b    8
HGetState_2:
            movea.l (4,SP),A0
            _HGetState
            rts
            ds.b    8
HSetState_2:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            _HSetState
            rts
            ds.b    4
GetHandleSize_3:
            movea.l (4,SP),A0
            _GetHandleSize
            rts
            ds.b    8
BlockMove_3:
            movea.l ($C,SP),A0
            movea.l (8,SP),A1
            move.l  (4,SP),D0
            _BlockMove
            rts
SetHandleSize_3:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            _SetHandleSize
            rts
            ds.b    4
MemError:
            moveq   #0,D0
            move.w  MemErr,D0
            rts
            ds.b    8
StripAddress_3:
            move.l  (4,SP),D0
            _StripAddress
            rts
            ds.b    8
RecoverHandle_2:
            movea.l (4,SP),A0
            _RecoverHandle
            move.l  A0,D0
            rts
SLODMULTIPLIERS:
            dc.w    $000A,$0011,$0017,$0007,$0009,$000B,$0010,$0021
            dc.w    $002E,$0022,$0031,$000E,$0018,$0021,$002C,$0010
            dc.w    $000D
            ds.b    4
CALCULATESLOD:
            movea.l (4,SP),A0
            moveq   #0,D0
            move.w  (A0),D0
            mulu.w  #$A60,D0
            divu.w  TimeDBRA,D0
            rts
            ds.b    14
WaitBit:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
.L1:
            move.w  (A0),D1
            and.w   D0,D1
            beq.b   .L1
            rts
inAppHeap:
            move.l  (4,SP),D0
            _StripAddress
            move.l  D0,-(SP)
            move.l  ApplZone,D0
            _StripAddress
            cmp.l   (SP),D0
            bhi.b   .L1
            movea.l ApplZone,A0
            move.l  (A0),D0
            _StripAddress
            cmp.l   (SP),D0
            bcs.b   .L1
            moveq   #1,D0
            addq.w  #4,SP
            rts
.L1:
            moveq   #0,D0
            addq.w  #4,SP
            rts
            ds.b    6
SndAllOff:
            movea.l VIA,A0
            bset    #7,(vBufB,A0)
            rts
            ds.b    6
BlockInts:
            move    SR,D0
            ori     #$700,SR
            andi    #$FAFF,SR
            rts
            ds.b    4
UnBlockInts:
            move    (6,SP),SR
            rts
            ds.b    10
GestaltCall:
            move.w  #$A1AD,D0
            _GetOSTrapAddress
            move.l  A0,D2
            move.w  #$A89F,D0
            _GetToolBoxTrapAddress
            cmp.l   A0,D2
            bne.b   .L2
            _Debugger
            cmpi.w  #$7FFF,ROM85
            bne.b   .L1
            moveq   #0,D0
.L1:
            rts
.L2:
            move.l  (4,SP),D0
            _Gestalt
            movea.l (8,SP),A1
            move.l  A0,(A1)
            rts
            dc.w    0
InstallSoundIntHandler:
SoundIntHandler:
SOUNDINTERRUPTS:
            rts
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            dc.b    16,'  Life Is Good  '
            ds.b    7
SMGlobalLoc:
            movea.l ExpandMem,A0
            lea     ($110,A0),A0
            move.l  A0,D0
            rts
            ds.b    4
IsVMPresent:
            move.l  #$766D2020,D0
            _Gestalt
            tst.w   D0
            beq.b   .L1
            suba.l  A0,A0
.L1:
            move.l  A0,D0
            rts
            ds.b    14
NewVMPtr:
            move.l  (4,SP),D0
            _NewPtrClear
            tst.w   D0
            bne.b   .L2
            move.l  A0,-(SP)
            jsr     IsVMPresent
            tst.w   D0
            beq.b   .L1
            movea.l (SP),A0
            movea.l (8,SP),A1
            moveq   #0,D0
            _MemoryDispatch
.L1:
            move.l  (SP)+,D0
.L2:
            rts
            ds.b    14
DisposVMPtr:
            movea.l (4,SP),A0
            _GetPtrSize
            move.l  D0,-(SP)
            movea.l (8,SP),A0
            _DisposPtr
            jsr     IsVMPresent
            tst.w   D0
            beq.b   .L1
            movea.l (8,SP),A0
            movea.l (SP),A1
            moveq   #1,D0
            _MemoryDispatch
.L1:
            move.l  (SP)+,D0
            rts
            ds.b    12
RangeCommon:
            move.l  (SP)+,D1
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _MemoryDispatch
            move.w  D0,(SP)
            movea.l D1,A1
            jmp     (A1)
            dc.w    0
DebuggerRangeCommon:
            move.l  (SP)+,D1
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DebugUtil
            move.w  D0,(SP)
            movea.l D1,A1
            jmp     (A1)
            dc.w    0
HoldMemory:
            moveq   #0,D0
            bra.b   RangeCommon
            ds.b    12
UnholdMemory:
            moveq   #1,D0
            bra.b   RangeCommon
            ds.b    12
LockMemory:
            moveq   #2,D0
            bra.b   RangeCommon
            ds.b    12
LOCKMEMORYCONTIGUOUS:
            moveq   #4,D0
            bra.b   RangeCommon
            ds.b    12
UnlockMemory:
            moveq   #3,D0
            bra.b   RangeCommon
            ds.b    12
GETPHYSICAL:
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l D2,A1
            movea.l (A1),A1
            movea.l (SP)+,A0
            moveq   #5,D0
            _MemoryDispatchA0Result
            move.w  D0,(SP)
            movea.l D2,A1
            move.l  A0,(A1)
            movea.l D1,A1
            jmp     (A1)
            ds.b    8
DEFERUSERFN:
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            _DeferUserFn
            move.w  D0,(SP)
            movea.l D1,A1
            jmp     (A1)
            dc.w    0
GETPAGESTATE:
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            moveq   #4,D0
            _DebugUtil
            move.w  D0,(SP)
            movea.l D1,A1
            jmp     (A1)
            dc.w    0
PAGEFAULTFATAL:
            moveq   #5,D0
            _DebugUtil
            move.b  D0,(4,SP)
            rts
            ds.b    6
DebuggerLockMemory:
            moveq   #6,D0
            bra.w   DebuggerRangeCommon
            ds.b    10
DebuggerUnlockMemory:
            moveq   #7,D0
            bra.w   DebuggerRangeCommon
            ds.b    10
EnterSupervisorMode:
            moveq   #8,D0
            _DebugUtil
            move.w  D0,(4,SP)
            rts
            ds.b    6

            EVEN
