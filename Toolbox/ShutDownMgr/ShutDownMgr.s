            include "Include/ROMHeader.s"

            EXPORT  CallRoutines,ShutDownDisp

            IMPORT  SHUTRESTARTANNEX

            SECTION "ShutDownMgr",CODE

ShutDown:
            bra.w   .L1
            dc.w    $494E,$4954,$0004,$10A3
.L1:
            bra.b   ShutDownDisp.L1
ShutDownDisp:
            move.l  (SP)+,D2
            move.w  (SP)+,D0
            move.l  D2,-(SP)
            subq.w  #1,D0
            bmi.b   .L1
            beq.w   sub_4080EDB2.L7
            subq.w  #2,D0
            bmi.b   sub_4080EDB2.L6
            beq.b   sub_4080EDB2
            bpl.b   sub_4080EDB2.L1
.L1:
            moveq   #$A,D0
            _NewPtrSysClear
            move.l  A0,($BBC).w
            pea     sub_4080EEC6
            move.w  #4,-(SP)
            bsr.b   sub_4080EDB2
            pea     DoUnmount
            move.w  #3,-(SP)
            bsr.b   sub_4080EDB2
            rts
sub_4080EDB2:
            move.l  (SP)+,D2
            move.w  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D2,-(SP)
            movea.l A0,A1
            moveq   #$A,D0
            _NewPtrSys
            move.w  D1,(4,A0)
            move.l  A1,(6,A0)
            movea.l ($BBC).w,A1
            _Enqueue
            rts
.L1:
            move.l  (SP)+,D2
            movea.l (SP)+,A0
            move.l  D2,-(SP)
            move.l  A2,-(SP)
            movea.l ($BBC).w,A1
            addq.w  #2,A1
            movea.l (A1)+,A2
            move.l  (A1),D0
            beq.b   .L3
.L2:
            cmpa.l  (6,A2),A0
            beq.b   .L4
            movea.l (A2),A1
            cmp.l   A2,D0
            movea.l A1,A2
            bne.b   .L2
.L3:
            moveq   #-1,D0
            bra.b   .L5
.L4:
            movea.l ($BBC).w,A1
            movea.l A2,A0
            _Dequeue
            movea.l A2,A0
            _DisposPtr
.L5:
            movea.l (SP)+,A2
            rts
.L6:
            moveq   #1,D0
            BigJsr  SHUTRESTARTANNEX,A0
            cmpi.b  #3,(8,A0)
            lea     ($A,A0),A0
            nop
            jmp     (A0)
.L7:
            moveq   #0,D0
            bsr.b   CallRoutines
            _HideCursor
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetWMgrPort
            _SetPort
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            movea.l ROMBase,A1
            cmpi.b  #3,(8,A1)
            bne.b   .L8
            pea     (-8,A0)
            bra.b   .L9
.L8:
            pea     (-$10,A0)
.L9:
            move.l  (-$82,A0),-(SP)
            _SetClip
            _FillRgn
            movea.l ROMBase,A1
            cmpi.b  #3,(8,A1)
            beq.b   .L10
            btst    #6,ROM85
            bne.b   .L11
.L10:
            _PowerOff
.L11:
            clr.l   ResumeProc
            moveq   #$2A,D0
            _SysError
CallRoutines:
            movem.l D0-D5/A1-A3,-(SP)
            move.w  D0,D4
            tst.l   ($282).w
            ble.b   .L1
            movem.l (SP)+,D0-D5/A1-A3
            _ExitToShell
.L1:
            moveq   #3,D5
            bsr.b   CallCleanUp
            moveq   #2,D5
            bsr.b   CallCleanUp
            move.w  D4,D5
            bsr.b   CallCleanUp
            movem.l (SP)+,D0-D5/A1-A3
            rts
CallCleanUp:
            movea.l ($BBC).w,A1
            lea     (2,A1),A3
            movea.l (A3)+,A2
            move.l  (A3),D3
            beq.b   .L3
.L1:
            movea.l (A2),A3
            move.w  (4,A2),D0
            btst    D5,D0
            beq.b   .L2
            movea.l (6,A2),A0
            move.w  D5,D0
            jsr     (A0)
            move.l  (6,A2),-(SP)
            move.w  #4,-(SP)
            _ShutDown
.L2:
            cmp.l   A2,D3
            movea.l A3,A2
            bne.b   .L1
.L3:
            rts
sub_4080EEC6:
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$32,SP
            move.w  #$FFFF,($1A,SP)
            movea.l UTableBase,A1
            move.w  UnitNtryCnt,D1
.L1:
            move.l  (A1)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            btst    #4,(4,A0)
            beq.b   .L2
            move.w  ($18,A0),($18,SP)
            movea.l SP,A0
            _Control
.L2:
            subq.w  #1,D1
            bne.b   .L1
            lea     ($32,SP),SP
            movem.l (SP)+,D0-D1/A0-A1
            rts
DoUnmount:
            suba.w  #$32,SP
            movea.l SP,A0
            clr.l   ($12,A0)
            clr.w   ($18,A0)
            movea.l ($358).w,A1
            move.l  ($35C).w,D2
            beq.b   .L1
            bsr.b   ZapVCBQueue
.L1:
            lea     ($32,SP),SP
            rts
ZapVCBQueue:
            move.w  D1,-(SP)
            move.w  ($4E,A1),D1
            move.l  (A1),-(SP)
            cmpa.l  D2,A1
            movea.l (SP)+,A1
            beq.b   FlushTime
            bsr.b   ZapVCBQueue
FlushTime:
            move.w  D1,($16,A0)
            _Eject
            _HUnmountVol
            move.w  (SP)+,D1
            rts

            EVEN
