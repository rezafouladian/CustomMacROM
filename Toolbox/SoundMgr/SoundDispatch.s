            include "Include/ROMHeader.s"

            EXPORT  DispAddTool,InitSndDispatch

            SECTION "SoundDispatch",CODE

InitSndDispatch:
            movea.l ExpandMem,A1
            movea.l ($110,A1),A1
            moveq   #$34,D0
            _NewPtrSys
            move.l  A0,($2A,A1)
            movea.l A0,A1
            ; Tool table: one entry per tool ID (low word of the _SoundDispatch selector).
            ; $0000 = dispatcher itself, $0008 = Sound Manager, $0010 = MACE
            lea     DispFuncDisp,A0
            move.l  A0,(A1)+
            move.w  #7,D1
            lea     UnimplFunction,A0
.L1:
            move.l  A0,(A1)+
            dbra    D1,.L1
            lea     DispVersion,A0
            move.l  A0,(A1)
            lea     DispAddTool,A0
            move.l  A0,(4,A1)
            lea     DispRemTool,A0
            move.l  A0,(8,A1)
            lea     DispToolAddr,A0
            move.l  A0,($C,A1)
            lea     SoundDispatcher,A0
            moveq   #0,D0
            _SetToolBoxTrapAddress
            rts
SoundDispatcher:
            movea.l ExpandMem,A0
            movea.l ($110,A0),A0
            movea.l ($2A,A0),A0
            movea.l (0,A0,D0.w),A0
            swap    D0
            jmp     (A0)
DispFuncDisp:
            cmpi.w  #$10,D0
            bcc.b   UnimplFunction
            movea.l ExpandMem,A0
            movea.l ($110,A0),A0
            movea.l ($2A,A0),A0
            movea.l ($24,A0,D0.w),A0
            jmp     (A0)
            ds.b    22
UnimplFunction:
            tst.w   D0
            bne.b   .L1
            clr.l   (4,SP)
            rts
.L1:
            rts
            ds.b    4
DispVersion:
            move.w  (4,SP),D0
            beq.b   .L2
            cmpi.w  #$24,D0
            bcc.b   .L1
            movea.l (SP),A0
            addq.l  #6,SP
            move.l  A0,-(SP)
            andi.l  #$FFFF,D0
            jmp     SoundDispatcher
.L1:
            clr.l   (6,SP)
            bra.b   .L3
.L2:
            move.l  #$1002001,(6,SP)
.L3:
            movea.l (SP),A0
            addq.l  #6,SP
            jmp     (A0)
            rts
            ds.b    14
DispAddTool:
            move.w  (8,SP),D0
            cmpi.w  #$24,D0
            bge.b   .L1
            movea.l ExpandMem,A1
            movea.l ($110,A1),A1
            movea.l ($2A,A1),A1
            movea.l (4,SP),A0
            move.l  A0,(0,A1,D0.w)
            clr.w   ($A,SP)
            bra.b   .L2
.L1:
            move.w  #$FFFF,($A,SP)
.L2:
            movea.l (SP),A0
            adda.w  #$A,SP
            jmp     (A0)
            ds.b    14
DispRemTool:
            move.w  (4,SP),D0
            cmpi.w  #$24,D0
            bcc.b   .L1
            movea.l ExpandMem,A1
            movea.l ($110,A1),A1
            movea.l ($2A,A1),A1
            lea     UnimplFunction,A0
            move.l  A0,(0,A1,D0.w)
            clr.w   (6,SP)
            bra.b   .L2
.L1:
            move.w  #$FFFF,(6,SP)
.L2:
            movea.l (SP),A0
            addq.l  #6,SP
            jmp     (A0)
DispToolAddr:
            move.w  (4,SP),D0
            cmpi.w  #$24,D0
            bcc.b   .L1
            movea.l ExpandMem,A1
            movea.l ($110,A1),A1
            movea.l ($2A,A1),A1
            move.l  (0,A1,D0.w),D0
            lea     UnimplFunction,A0
            cmp.l   A0,D0
            bne.b   .L2
.L1:
            moveq   #0,D0
.L2:
            move.l  D0,(6,SP)
            movea.l (SP),A0
            addq.l  #6,SP
            jmp     (A0)
            dc.w    0

            EVEN
