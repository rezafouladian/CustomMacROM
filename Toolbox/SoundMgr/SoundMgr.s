            include "Include/ROMHeader.s"

            EXPORT  INITGLOBALS,SndAddModifier,SndAppDead,SndControl,SndDisposeChannel,SndDoCommand
            EXPORT  SndDoImmediate,SndNewChannel,SndPlay

            IMPORT  BlockInts,CALCULATESLOD,CallPascal,CancelDriftOfTimer,DisposPtr_2,GestaltCall
            IMPORT  GetHandleSize_3,GetTMRecordPtr,HGetState_2,HLock_3,HoldMemory,HSetState_2
            IMPORT  inAppHeap,InstallXTimer,MemError,MoveHHi_2,NewSysHandle,NewSysPtr
            IMPORT  RecoverHandle_2,RemoveXTimer,SetHandleSize_3,SetNextInterrupt,SLODMULTIPLIERS,SMGlobalLoc
            IMPORT  SndAllOff,StripAddress_3,UnBlockInts,UnholdMemory,WaitBit

            SECTION "SoundMgr",CODE

MYGETRESOURCE:
            link.w  A6,#0
            movem.l D4-D7/A3,-(SP)
            move.w  (8,A6),D5
            move.l  ($A,A6),D6
            subq.l  #2,SP
            _CurResFile
            move.w  (SP)+,D7
            moveq   #0,D0
            move.b  ResLoad,D0
            move.w  D0,D4
            cmpi.w  #5,D5
            bne.b   .L3
            cmpi.l  #'snth',D6
            bne.b   .L3
            move.w  CurApRefNum,-(SP)
            _UseResFile
            moveq   #0,D0
            move.b  D0,-(SP)
            _SetResLoad
            subq.l  #4,SP
            move.l  #'WILD',-(SP)
            moveq   #0,D0
            move.w  D0,-(SP)
            _Get1Resource
            tst.l   (SP)+
            beq.b   .L1
            move.w  SysMap,-(SP)
            _UseResFile
            bra.b   .L2
.L1:
            move.w  D7,-(SP)
            _UseResFile
.L2:
            move.b  D4,-(SP)
            _SetResLoad
.L3:
            subq.l  #4,SP
            move.l  D6,-(SP)
            move.w  D5,-(SP)
            _RGetResource
            movea.l (SP)+,A3
            move.w  D7,-(SP)
            _UseResFile
            move.l  A3,($E,A6)
            movem.l (-$14,A6),D4-D7/A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
            ds.b    6
IsAscMac:
            link.w  A6,#-4
            move.l  D7,-(SP)
            pea     (-4,A6)
            move.l  #'hdwr',-(SP)
            jsr     (GestaltCall.w,PC)
            move.w  D0,D7
            moveq   #8,D0
            and.l   (-4,A6),D0
            move.l  (-8,A6),D7
            unlk    A6
            rts
            ds.b    12
INITGLOBALS:
            link.w  A6,#-4
            movem.l D3/D6-D7/A3-A4,-(SP)
            movea.l ROMBase,A0
            tst.b   (8,A0)
            beq.b   .L1
            moveq   #$34,D0
            move.l  D0,-(SP)
            jsr     (NewSysPtr.w,PC)
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            move.l  D0,D1
            move.l  (SP)+,D0
            movea.l D1,A0
            move.l  D0,(A0)
            move.l  D0,SMGlobals
            addq.l  #4,SP
            bra.b   .L2
.L1:
            moveq   #$34,D0
            move.l  D0,-(SP)
            jsr     (NewSysPtr.w,PC)
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            move.l  D0,D1
            move.l  (SP)+,D0
            movea.l D1,A0
            move.l  D0,(A0)
            addq.l  #4,SP
.L2:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            tst.l   (A0)
            bne.b   .L3
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            moveq   #-1,D0
            move.l  D0,(A0)
            jsr     (MemError.w,PC)
            bra.w   .L9
.L3:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D0
            move.l  D0,(A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            clr.w   (4,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D0
            move.l  D0,($30,A0)
            pea     DispatchTab
            jsr     (NewSysPtr.w,PC)
            movea.l D0,A3
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  A3,($A,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D0
            move.l  D0,($12,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.w  #$64,($16,A0)
            jsr     IsAscMac
            tst.w   D0
            addq.l  #4,SP
            beq.w   .L8
            pea     (-4,A6)
            move.l  #'mach',-(SP)
            jsr     (GestaltCall.w,PC)
            move.w  D0,D6
            subq.l  #4,SP
            move.l  #'slod',-(SP)
            move.w  (-2,A6),-(SP)
            _GetResource
            movea.l (SP)+,A4
            move.l  A4,D0
            addq.l  #8,SP
            bne.b   .L5
            moveq   #$28,D0
            move.l  D0,-(SP)
            jsr     (NewSysHandle.w,PC)
            movea.l D0,A4
            clr.w   D7
            move.l  D7,D0
            add.w   D0,D0
            lea     (SLODMULTIPLIERS.w,PC),A0
            movea.l (A4),A1
            move.w  (0,A0,D0.w),(A1)
            moveq   #1,D7
            addq.l  #4,SP
.L4:
            move.l  D7,D0
            add.w   D0,D0
            lea     (SLODMULTIPLIERS.w,PC),A0
            pea     (0,A0,D0.w)
            jsr     (CALCULATESLOD.w,PC)
            ext.l   D7
            move.l  D7,D1
            asl.l   #1,D1
            add.l   (A4),D1
            movea.l D1,A0
            move.w  D0,(A0)
            addq.l  #4,SP
            addq.w  #1,D7
            cmpi.w  #$11,D7
            blt.b   .L4
.L5:
            move.l  A4,-(SP)
            jsr     (HLock_3.w,PC)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A4),($1A,A0)
            clr.w   D7
            move.w  #$400,D3
            addq.l  #4,SP
.L6:
            ext.l   D7
            move.l  A3,D0
            add.l   D7,D0
            movea.l D0,A0
            move.b  #$80,(A0)
            addq.w  #1,D7
            cmp.w   D7,D3
            bgt.b   .L6
            pea     SysCom
            jsr     (NewSysHandle.w,PC)
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            move.l  D0,D1
            move.l  (SP)+,D0
            movea.l D1,A0
            movea.l (A0),A0
            move.l  D0,(6,A0)
            addq.l  #4,SP
            bne.b   .L7
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            move.l  (A0),-(SP)
            jsr     (DisposPtr_2.w,PC)
            jsr     (MemError.w,PC)
            addq.l  #4,SP
            bra.b   .L9
.L7:
            movea.l ASCBase,A0
            move.b  (ascVersion,A0),D0
            ext.w   D0
            ext.l   D0
            move.l  #$F0,D1
            and.l   D0,D1
            move.l  D1,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            move.l  (SP)+,D1
            movea.l D0,A0
            movea.l (A0),A0
            move.b  D1,($2E,A0)
            movea.l ASCBase,A0
            moveq   #$F,D0
            and.b   (ascVersion,A0),D0
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            move.l  D0,D1
            move.l  (SP)+,D0
            movea.l D1,A0
            movea.l (A0),A0
            move.b  D0,($2F,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D0
            move.b  ($2E,A0),D0
            cmpi.l  #$B0,D0
            bne.b   .L8
            movea.l ASCBase,A0
            move.b  #1,(bmIntControlA,A0)
            movea.l ASCBase,A0
            move.b  #1,(bmIntControlB,A0)
            movea.l ASCBase,A0
            move.b  #1,(ascMode,A0)
.L8:
            moveq   #0,D0
.L9:
            movem.l (-$18,A6),D3/D6-D7/A3-A4
            unlk    A6
            rts
SetDivTable:
            movem.l D3-D7/A3-A4,-(SP)
            movea.l ($20,SP),A4
            move.w  ($26,SP),D5
            cmpi.w  #2,D5
            bge.b   .L1
            moveq   #0,D0
            bra.b   .L7
.L1:
            ext.l   D5
            move.l  D5,D0
            asl.l   #8,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            jsr     (SetHandleSize_3.w,PC)
            move.w  D0,D4
            addq.l  #8,SP
            beq.b   .L2
            move.w  D4,D0
            bra.b   .L7
.L2:
            move.l  A4,D0
            bne.b   .L3
            jsr     (MemError.w,PC)
            bra.b   .L7
.L3:
            move.l  A4,-(SP)
            jsr     (HGetState_2.w,PC)
            move.b  D0,D4
            move.l  A4,-(SP)
            jsr     (HLock_3.w,PC)
            movea.l (A4),A3
            addq.l  #8,SP
            clr.w   D6
            move.w  #$100,D3
.L4:
            clr.w   D7
            bra.b   .L6
.L5:
            move.b  D6,(A3)+
            addq.w  #1,D7
.L6:
            cmp.w   D7,D5
            bgt.b   .L5
            addq.w  #1,D6
            cmp.w   D6,D3
            bgt.b   .L4
            ext.w   D4
            ext.l   D4
            move.l  D4,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            addq.l  #8,SP
.L7:
            movem.l (SP)+,D3-D7/A3-A4
            rts
            ds.b    10
InsertInQueue:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($10,SP),A3
            jsr     (BlockInts.w,PC)
            move.w  D0,D7
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.b   .L1
            ext.l   D7
            move.l  D7,-(SP)
            jsr     (UnBlockInts.w,PC)
            moveq   #1,D0
            addq.l  #4,SP
            bra.b   .L4
.L1:
            move.w  ($20,A3),D0
            ext.l   D0
            moveq   #-1,D1
            cmp.l   D0,D1
            bne.b   .L2
            move.w  ($22,A3),($20,A3)
            andi.w  #$FFEF,($1C,A3)
.L2:
            move.w  ($22,A3),D0
            addq.w  #1,($22,A3)
            ext.l   D0
            asl.l   #3,D0
            lea     ($24,A3,D0.l),A0
            movea.l A4,A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.w  ($22,A3),D0
            cmp.w   ($1E,A3),D0
            bne.b   .L3
            clr.w   ($22,A3)
.L3:
            ext.l   D7
            move.l  D7,-(SP)
            jsr     (UnBlockInts.w,PC)
            moveq   #0,D0
            addq.l  #4,SP
.L4:
            movem.l (SP)+,D7/A3-A4
            rts
            ds.b    8
NextFromQueue:
            movem.l A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($C,SP),A3
            move.w  ($20,A3),D0
            ext.l   D0
            moveq   #-1,D1
            cmp.l   D0,D1
            bne.b   .L1
            moveq   #1,D0
            bra.b   .L4
.L1:
            move.w  ($20,A3),D0
            addq.w  #1,($20,A3)
            ext.l   D0
            asl.l   #3,D0
            lea     ($24,A3,D0.l),A0
            movea.l A4,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  ($20,A3),D0
            cmp.w   ($1E,A3),D0
            bne.b   .L2
            clr.w   ($20,A3)
.L2:
            move.w  ($20,A3),D0
            cmp.w   ($22,A3),D0
            bne.b   .L3
            move.w  #$FFFF,($20,A3)
            ori.w   #$10,($1C,A3)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,A3-A4
            rts
            dc.w    0
ChannelModifier:
            link.w  A6,#0
            movem.l D3/A3-A4,-(SP)
            movea.l (8,A6),A0
            movea.l (4,A0),A4
            bra.b   .L2
.L1:
            movea.l (A4),A4
.L2:
            tst.l   (A4)
            bne.b   .L1
            movea.l ($C,A6),A0
            move.w  (A0),D0
            subq.w  #3,D0
            beq.b   .L3
            subq.w  #1,D0
            beq.b   .L4
            subq.w  #6,D0
            beq.b   .L5
            subq.w  #1,D0
            beq.w   .L6
            subq.w  #1,D0
            beq.w   .L7
            subq.w  #1,D0
            beq.w   .L8
            subq.w  #1,D0
            beq.w   .L9
            subq.w  #8,D0
            beq.w   .L13
            subq.w  #1,D0
            beq.w   .L14
            subq.w  #7,D0
            beq.w   .L15
            subq.w  #1,D0
            beq.w   .L15
            bra.w   .L15
.L3:
            movea.l (8,A6),A0
            ori.w   #2,($1C,A0)
            bra.w   .L15
.L4:
            movea.l (8,A6),A0
            move.w  #$FFFF,($20,A0)
            movea.l (8,A6),A0
            clr.w   ($22,A0)
            move.l  ($3E,A4),-(SP)
            jsr     (CancelDriftOfTimer.w,PC)
            movea.l (8,A6),A0
            ori.w   #$10,($1C,A0)
            addq.l  #4,SP
            bra.w   .L15
.L5:
            movea.l ($C,A6),A0
            move.w  (2,A0),D0
            ext.l   D0
            movea.l (8,A6),A0
            move.l  D0,($10,A0)
            move.l  ($3E,A4),-(SP)
            movea.l (8,A6),A0
            move.l  ($10,A0),D1
            move.l  D1,D0
            mulu.w  #$1F4,D1
            swap    D0
            mulu.w  #$1F4,D0
            swap    D0
            clr.w   D0
            add.l   D0,D1
            move.l  D1,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  (8,A6),-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
            bra.w   .L15
.L6:
            movea.l (8,A6),A0
            ori.w   #4,($1C,A0)
            bra.w   .L15
.L7:
            movea.l (8,A6),A0
            andi.w  #$FFF3,($1C,A0)
            movea.l ($C,A6),A0
            movea.l (4,A0),A4
            moveq   #0,D0
            move.l  D0,($10,A4)
            movea.l (8,A6),A0
            move.l  D0,($10,A0)
            movea.l (8,A6),A0
            move.w  ($20,A0),D1
            ext.l   D1
            moveq   #-1,D2
            cmp.l   D1,D2
            beq.w   .L15
            move.l  ($3E,A4),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  (8,A6),-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
            bra.w   .L15
.L8:
            movea.l (8,A6),A0
            tst.l   (8,A0)
            beq.w   .L15
            move.l  (8,A6),-(SP)
            move.l  ($C,A6),-(SP)
            movea.l (8,A6),A0
            move.l  (8,A0),-(SP)
            jsr     (CallPascal.w,PC)
            bra.w   .L15
.L9:
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            lea     ($14,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l (8,A6),A0
            ori.w   #8,($1C,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            movea.l (A0),A3
            bra.b   .L12
.L10:
            moveq   #8,D0
            and.w   ($1C,A3),D0
            beq.b   .L11
            movea.l ($C,A6),A0
            move.l  ($18,A3),D0
            cmp.l   (4,A0),D0
            bne.b   .L11
            subq.w  #1,($16,A3)
            tst.w   ($16,A3)
            bne.b   .L11
            andi.w  #$FFF7,($1C,A3)
            movea.l (8,A6),A0
            move.w  ($20,A0),D0
            ext.l   D0
            moveq   #-1,D1
            cmp.l   D0,D1
            beq.b   .L11
            move.l  ($3E,A4),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  (8,A6),-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
.L11:
            movea.l (A3),A3
.L12:
            move.l  A3,D0
            bne.b   .L10
            bra.w   .L15
.L13:
            movea.l ($C,A6),A0
            movea.l (4,A0),A4
            movea.l ($C,A6),A0
            move.w  (2,A0),D0
            ext.l   D0
            move.l  D0,($10,A4)
            move.l  D0,($C,A4)
            move.l  ($3A,A4),-(SP)
            move.l  ($C,A4),D1
            move.l  D1,D0
            mulu.w  #$1F4,D1
            swap    D0
            mulu.w  #$1F4,D0
            swap    D0
            clr.w   D0
            add.l   D0,D1
            move.l  D1,-(SP)
            move.l  A4,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
            bra.b   .L15
.L14:
            movea.l ($C,A6),A0
            movea.l (4,A0),A4
            movea.l ($C,A6),A0
            move.w  (2,A0),D0
            ext.l   D0
            move.l  D0,($C,A4)
            move.l  ($3A,A4),-(SP)
            move.l  ($C,A4),D1
            move.l  D1,D0
            mulu.w  #$1F4,D1
            swap    D0
            mulu.w  #$1F4,D0
            swap    D0
            clr.w   D0
            add.l   D0,D1
            move.l  D1,-(SP)
            move.l  A4,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
.L15:
            movem.l (-$C,A6),D3/A3-A4
            unlk    A6
            rts
            ds.b    10
processCommandFrom:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            clr.w   D6
.L1:
            tst.w   (A3)
            beq.b   .L3
            move.l  A4,D0
            beq.b   .L2
            subq.l  #2,SP
            move.l  (8,A6),-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (4,A4),-(SP)
            jsr     (CallPascal.w,PC)
            move.b  (SP)+,D7
            move.l  (A4),-(SP)
            move.l  A3,-(SP)
            move.l  (8,A6),-(SP)
            jsr     processCommandFrom
            lea     ($C,SP),SP
            bra.b   .L3
.L2:
            clr.b   D7
            move.l  A3,-(SP)
            move.l  (8,A6),-(SP)
            jsr     ChannelModifier
            addq.l  #8,SP
.L3:
            move.w  #$15,(A3)
            addq.w  #1,D6
            move.w  D6,(2,A3)
            tst.b   D7
            bne.b   .L1
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
            ds.b    10
processCommand:
            movem.l A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($C,SP),A3
            moveq   #3,D0
            cmp.w   (A4),D0
            bne.b   .L1
            andi.w  #$FFFD,($1C,A3)
.L1:
            move.l  (4,A3),-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     processCommandFrom
            lea     ($C,SP),SP
            movem.l (SP)+,A3-A4
            rts
            dc.w    0
processNextCommand:
            link.w  A6,#-8
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            pea     (-8,A6)
            move.l  A3,-(SP)
            jsr     NextFromQueue
            tst.b   D0
            addq.l  #8,SP
            beq.b   .L1
            moveq   #1,D0
            bra.b   .L2
.L1:
            pea     (-8,A6)
            move.l  A3,-(SP)
            jsr     processCommand
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (-$C,A6),A3
            unlk    A6
            rts
            ds.b    12
sendEmptyCommand:
            link.w  A6,#-8
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            moveq   #$10,D0
            and.w   ($1C,A4),D0
            beq.b   .L3
            move.w  #$F,(-8,A6)
            pea     (-8,A6)
            move.l  A4,-(SP)
            jsr     processCommand
            andi.w  #$FFEF,($1C,A4)
            movea.l (4,A4),A3
            addq.l  #8,SP
            bra.b   .L2
.L1:
            movea.l (A3),A3
.L2:
            tst.l   (A3)
            bne.b   .L1
            move.l  ($3E,A3),-(SP)
            jsr     (CancelDriftOfTimer.w,PC)
            addq.l  #4,SP
.L3:
            movem.l (-$10,A6),A3-A4
            unlk    A6
            rts
            ds.b    4
tickleModifier:
            link.w  A6,#-8
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A3
            move.w  #$14,(-8,A6)
            move.l  A4,-(SP)
            pea     (-8,A6)
            move.l  A3,-(SP)
            jsr     processCommandFrom
            movem.l (-$10,A6),A3-A4
            unlk    A6
            rts
            ds.b    4
findModifier:
            link.w  A6,#-4
            movem.l D3/A3-A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     (StripAddress_3.w,PC)
            move.l  D0,(-4,A6)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            movea.l (A0),A4
            addq.l  #4,SP
            bra.b   .L5
.L1:
            movea.l (4,A4),A3
            bra.b   .L4
.L2:
            move.l  (4,A3),-(SP)
            jsr     (StripAddress_3.w,PC)
            cmp.l   (-4,A6),D0
            addq.l  #4,SP
            bne.b   .L3
            move.l  A3,D0
            bra.b   .L6
.L3:
            movea.l (A3),A3
.L4:
            move.l  A3,D0
            bne.b   .L2
            movea.l (A4),A4
.L5:
            move.l  A4,D0
            bne.b   .L1
            moveq   #0,D0
.L6:
            movem.l (-$10,A6),D3/A3-A4
            unlk    A6
            rts
            ds.b    12
disposChannel:
            link.w  A6,#-$C
            movem.l D3/A3-A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     (StripAddress_3.w,PC)
            movea.l D0,A3
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            lea     (A0),A4
            addq.l  #4,SP
            bra.b   .L3
.L1:
            move.l  (A4),-(SP)
            jsr     (StripAddress_3.w,PC)
            cmpa.l  D0,A3
            addq.l  #4,SP
            bne.b   .L2
            movea.l (8,A6),A0
            move.l  (A0),(A4)
            bra.b   .L4
.L2:
            movea.l (A4),A0
            lea     (A0),A4
.L3:
            tst.l   (A4)
            bne.b   .L1
.L4:
            movea.l (8,A6),A0
            movea.l (4,A0),A3
            bra.w   .L8
.L5:
            move.w  #2,(-8,A6)
            move.l  A3,-(SP)
            pea     (-8,A6)
            move.l  (8,A6),-(SP)
            jsr     processCommandFrom
            move.l  (4,A3),-(SP)
            jsr     findModifier
            tst.l   D0
            lea     ($10,SP),SP
            bne.b   .L6
            move.b  ($14,A3),D0
            btst    #0,D0
            beq.b   .L6
            move.b  ($15,A3),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  (4,A3),-(SP)
            jsr     (RecoverHandle_2.w,PC)
            movea.l D0,A4
            addq.l  #4,SP
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L6:
            move.l  (A3),(-$C,A6)
            move.l  ($3A,A3),-(SP)
            jsr     (RemoveXTimer.w,PC)
            move.l  ($3A,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            tst.l   (A3)
            addq.l  #8,SP
            bne.b   .L7
            move.l  ($3E,A3),-(SP)
            jsr     (RemoveXTimer.w,PC)
            move.l  ($3E,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            addq.l  #8,SP
.L7:
            move.l  A3,-(SP)
            jsr     (DisposPtr_2.w,PC)
            addq.l  #4,SP
            movea.l (-$C,A6),A3
.L8:
            move.l  A3,D0
            bne.w   .L5
            movea.l (8,A6),A0
            move.w  ($1C,A0),D0
            btst    #0,D0
            beq.b   .L9
            move.l  (8,A6),-(SP)
            jsr     (DisposPtr_2.w,PC)
            addq.l  #4,SP
            bra.b   .L10
.L9:
            pea     ($424).w
            move.l  (8,A6),-(SP)
            jsr     MyUnholdMemory
            addq.l  #8,SP
.L10:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            tst.w   (4,A0)
            ble.b   .L11
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            subq.w  #1,(4,A0)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (4,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (6,A0),-(SP)
            jsr     SetDivTable
            addq.l  #8,SP
.L11:
            movem.l (-$18,A6),D3/A3-A4
            unlk    A6
            rts
            ds.b    14
checkChannel:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  A3,D0
            bne.b   .L1
            moveq   #1,D0
            bra.b   .L2
.L1:
            tst.w   ($1E,A3)
            seq     D0
            neg.b   D0
.L2:
            movea.l (SP)+,A3
            rts
            ds.b    6
MyHoldMemory:
            link.w  A6,#-4
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            pea     (-4,A6)
            move.l  #$766D2020,-(SP)
            jsr     (GestaltCall.w,PC)
            tst.l   (-4,A6)
            addq.l  #8,SP
            beq.b   .L1
            subq.l  #2,SP
            move.l  A3,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     (HoldMemory.w,PC)
            move.w  (SP)+,D7
.L1:
            movem.l (-$C,A6),D7/A3
            unlk    A6
            rts
            ds.b    6
MyUnholdMemory:
            link.w  A6,#-4
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            pea     (-4,A6)
            move.l  #$766D2020,-(SP)
            jsr     (GestaltCall.w,PC)
            tst.l   (-4,A6)
            addq.l  #8,SP
            beq.b   .L1
            subq.l  #2,SP
            move.l  A3,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     (UnholdMemory.w,PC)
            move.w  (SP)+,D7
.L1:
            movem.l (-$C,A6),D7/A3
            unlk    A6
            rts
            ds.b    6
pumpResource:
            link.w  A6,#-$C
            movem.l D3/D6-D7/A3-A4,-(SP)
            movea.l ($C,A6),A0
            movea.l (A0),A4
            lea     (4,A4),A3
            move.w  (2,A4),D7
            bra.b   .L3
.L1:
            subq.l  #2,SP
            move.l  (8,A6),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.w  (A3),-(SP)
            move.l  (2,A3),-(SP)
            _SndAddModifier
            move.w  (SP)+,D6
            beq.b   .L2
            move.w  D6,D0
            bra.b   .L7
.L2:
            subq.w  #1,D7
            adda.w  #6,A3
.L3:
            tst.w   D7
            bgt.b   .L1
            move.w  (A3),D7
            movea.l A3,A0
            addq.l  #2,A0
            move.l  A0,(-$C,A6)
            bra.b   .L6
.L4:
            movea.l (-$C,A6),A0
            addq.l  #8,(-$C,A6)
            lea     (-8,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            moveq   #0,D0
            move.w  (-8,A6),D0
            move.l  #$8000,D1
            and.l   D0,D1
            beq.b   .L5
            move.l  A4,D0
            add.l   D0,(-4,A6)
            andi.w  #$7FFF,(-8,A6)
.L5:
            subq.l  #2,SP
            move.l  (8,A6),-(SP)
            pea     (-8,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDoCommand
            addq.l  #2,SP
            subq.w  #1,D7
.L6:
            tst.w   D7
            bgt.b   .L4
            moveq   #0,D0
.L7:
            movem.l (-$20,A6),D3/D6-D7/A3-A4
            unlk    A6
            rts
            ds.b    8
OnHowOften:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            jsr     (GetTMRecordPtr.w,PC)
            movea.l D0,A4
            move.l  ($16,A4),(-4,A6)
            movea.l ($1A,A4),A3
            move.l  A3,-(SP)
            move.l  (-4,A6),-(SP)
            jsr     tickleModifier
            tst.l   ($10,A3)
            addq.l  #8,SP
            ble.b   .L1
            move.l  ($10,A3),($C,A3)
            move.l  A4,-(SP)
            move.l  ($10,A3),D1
            move.l  D1,D0
            mulu.w  #$1F4,D1
            swap    D0
            mulu.w  #$1F4,D0
            swap    D0
            clr.w   D0
            add.l   D0,D1
            move.l  D1,-(SP)
            move.l  A3,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
.L1:
            movem.l (-$C,A6),A3-A4
            unlk    A6
            rts
            ds.b    14
OnWait:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            jsr     (GetTMRecordPtr.w,PC)
            move.l  D0,(-4,A6)
            movea.l (-4,A6),A0
            movea.l ($16,A0),A3
            movea.l (-4,A6),A0
            movea.l ($1A,A0),A4
            move.l  ($10,A3),D7
            moveq   #0,D0
            move.l  D0,($10,A3)
            tst.l   D7
            bne.b   .L4
            movea.l (4,A3),A4
            bra.b   .L2
.L1:
            movea.l (A4),A4
.L2:
            tst.l   (A4)
            bne.b   .L1
            move.l  ($3E,A4),-(SP)
            jsr     (CancelDriftOfTimer.w,PC)
            addq.l  #4,SP
            bra.b   .L4
.L3:
            move.l  A3,-(SP)
            jsr     processNextCommand
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L4
            tst.l   D7
            beq.b   .L5
            move.l  A3,-(SP)
            jsr     sendEmptyCommand
            addq.l  #4,SP
            bra.b   .L5
.L4:
            tst.l   ($10,A3)
            bne.b   .L5
            moveq   #$C,D0
            and.w   ($1C,A3),D0
            beq.b   .L3
.L5:
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    8
SndAppDead:
            movem.l D3/A3-A4,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            moveq   #-1,D0
            cmp.l   (A0),D0
            beq.b   .L4
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            movea.l (A0),A3
            bra.b   .L3
.L1:
            movea.l (A3),A4
            move.l  A3,-(SP)
            jsr     (inAppHeap.w,PC)
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L2
            move.l  A3,-(SP)
            jsr     disposChannel
            addq.l  #4,SP
.L2:
            movea.l A4,A3
.L3:
            move.l  A3,D0
            bne.b   .L1
.L4:
            jsr     (SndAllOff.w,PC)
            movem.l (SP)+,D3/A3-A4
            rts
            ds.b    14
ASYNCHCALLBACK:
            movem.l A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($C,SP),A3
            move.b  (3,A3),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  (4,A3),-(SP)
            jsr     (HSetState_2.w,PC)
            ori.w   #$20,($1C,A4)
            addq.l  #8,SP
            movem.l (SP)+,A3-A4
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
SndDoCommand:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            move.b  (8,A6),D6
            movea.l ($E,A6),A4
            move.l  A4,-(SP)
            jsr     checkChannel
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L1
            move.w  #$FF33,($12,A6)
            bra.b   .L9
.L1:
            movea.l (4,A4),A3
            bra.b   .L3
.L2:
            movea.l (A3),A3
.L3:
            tst.l   (A3)
            bne.b   .L2
.L4:
            move.l  ($A,A6),-(SP)
            move.l  A4,-(SP)
            jsr     InsertInQueue
            move.b  D0,D7
            addq.l  #8,SP
            beq.b   .L5
            tst.b   D6
            beq.b   .L4
.L5:
            jsr     (BlockInts.w,PC)
            move.w  D0,D5
            tst.l   ($10,A4)
            bgt.b   .L6
            moveq   #$C,D0
            and.w   ($1C,A4),D0
            bne.b   .L6
            move.w  ($20,A4),D0
            ext.l   D0
            moveq   #-1,D1
            cmp.l   D0,D1
            beq.b   .L6
            move.l  ($3E,A3),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            jsr     (SetNextInterrupt.w,PC)
            lea     ($10,SP),SP
.L6:
            ext.l   D5
            move.l  D5,-(SP)
            jsr     (UnBlockInts.w,PC)
            tst.b   D7
            addq.l  #4,SP
            beq.b   .L7
            move.l  #$FFFFFF35,D0
            bra.b   .L8
.L7:
            moveq   #0,D0
.L8:
            move.w  D0,($12,A6)
.L9:
            movem.l (-$14,A6),D5-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$A,SP
            jmp     (A0)
            ds.b    12
SndDoImmediate:
            link.w  A6,#-8
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            move.l  A4,-(SP)
            jsr     checkChannel
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L1
            move.w  #$FF33,($10,A6)
            bra.b   .L5
.L1:
            movea.l (8,A6),A0
            lea     (-8,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l (8,A6),A0
            moveq   #$28,D0
            cmp.w   (A0),D0
            bne.b   .L4
            movea.l (4,A4),A3
            bra.b   .L3
.L2:
            movea.l (A3),A3
.L3:
            tst.l   (A3)
            bne.b   .L2
            move.l  ($3E,A3),-(SP)
            jsr     (CancelDriftOfTimer.w,PC)
            addq.l  #4,SP
.L4:
            pea     (-8,A6)
            move.l  A4,-(SP)
            jsr     processCommand
            clr.w   ($10,A6)
            addq.l  #8,SP
.L5:
            movem.l (-$10,A6),A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    6
SndNewChannel:
            link.w  A6,#0
            movem.l D3-D7/A3-A4,-(SP)
            move.w  ($10,A6),D5
            movea.l ($12,A6),A4
            move.l  A4,D0
            bne.b   .L1
            move.w  #$FF33,($16,A6)
            bra.w   .L15
.L1:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            moveq   #-1,D0
            cmp.l   (A0),D0
            bne.b   .L2
            jsr     INITGLOBALS
            move.w  D0,D7
            beq.b   .L2
            move.w  D7,($16,A6)
            bra.w   .L15
.L2:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            movea.l (A0),A3
            bra.b   .L6
.L3:
            cmpa.l  (A4),A3
            bne.b   .L4
            move.w  #$FF2F,($16,A6)
            bra.w   .L15
.L4:
            moveq   #$20,D0
            and.w   ($1C,A3),D0
            beq.b   .L5
            move.l  A3,-(SP)
            jsr     disposChannel
            addq.l  #4,SP
.L5:
            movea.l (A3),A3
.L6:
            move.l  A3,D0
            bne.b   .L3
            clr.w   D6
            movea.l (A4),A3
            move.l  A3,D0
            bne.b   .L8
            pea     ($424).w
            jsr     (NewSysPtr.w,PC)
            move.l  D0,(A4)
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #4,SP
            bne.b   .L7
            jsr     (MemError.w,PC)
            move.w  D0,($16,A6)
            bra.w   .L15
.L7:
            moveq   #1,D6
            clr.w   ($1C,A3)
            ori.w   #1,($1C,A3)
            move.w  #$80,($1E,A3)
            bra.b   .L10
.L8:
            tst.w   ($1E,A3)
            bne.b   .L9
            move.w  #$FF33,($16,A6)
            bra.w   .L15
.L9:
            clr.w   ($1C,A3)
            andi.w  #$FFFE,($1C,A3)
            pea     ($424).w
            move.l  A3,-(SP)
            jsr     MyHoldMemory
            addq.l  #8,SP
.L10:
            andi.w  #$FFE1,($1C,A3)
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.l  (8,A6),(8,A3)
            move.l  D0,($C,A3)
            move.l  D0,($10,A3)
            move.w  #$FFFF,($20,A3)
            clr.w   ($22,A3)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(A3)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            addq.w  #1,(4,A0)
            tst.w   D5
            beq.b   .L12
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.w  D5,-(SP)
            move.l  ($C,A6),-(SP)
            _SndAddModifier
            move.w  (SP)+,D7
            beq.b   .L12
            tst.w   D6
            beq.b   .L11
            moveq   #0,D0
            move.l  D0,(A4)
.L11:
            move.l  A3,-(SP)
            jsr     disposChannel
            move.w  D7,($16,A6)
            addq.l  #4,SP
            bra.b   .L15
.L12:
            jsr     (BlockInts.w,PC)
            move.w  D0,D4
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  A3,(A0)
            ext.l   D4
            move.l  D4,-(SP)
            jsr     (UnBlockInts.w,PC)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #1,D0
            cmp.w   (4,A0),D0
            addq.l  #4,SP
            bge.b   .L14
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (4,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (6,A0),-(SP)
            jsr     SetDivTable
            tst.w   D0
            sne     D7
            andi.w  #1,D7
            addq.l  #8,SP
            beq.b   .L14
            tst.w   D6
            beq.b   .L13
            moveq   #0,D0
            move.l  D0,(A4)
.L13:
            move.l  A3,-(SP)
            jsr     disposChannel
            move.w  D7,($16,A6)
            addq.l  #4,SP
            bra.b   .L15
.L14:
            clr.w   ($16,A6)
.L15:
            movem.l (-$1C,A6),D3-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$E,SP
            jmp     (A0)
            ds.b    14
SndDisposeChannel:
            link.w  A6,#-8
            move.l  A3,-(SP)
            movea.l ($A,A6),A3
            move.l  A3,-(SP)
            jsr     checkChannel
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L1
            move.w  #$FF33,($E,A6)
            bra.b   .L5
.L1:
            moveq   #2,D0
            and.w   ($1C,A3),D0
            bne.b   .L4
            tst.b   (8,A6)
            beq.b   .L2
            move.w  #4,(-8,A6)
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (-8,A6)
            _SndDoImmediate
            move.w  #3,(-8,A6)
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (-8,A6)
            _SndDoImmediate
            addq.l  #4,SP
            bra.b   .L3
.L2:
            move.w  #3,(-8,A6)
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (-8,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDoCommand
            addq.l  #2,SP
.L3:
            moveq   #2,D0
            move.l  D0,-(SP)
            pea     ($1C,A3)
            jsr     (WaitBit.w,PC)
            addq.l  #8,SP
.L4:
            move.l  A3,-(SP)
            jsr     disposChannel
            clr.w   ($E,A6)
            addq.l  #4,SP
.L5:
            movea.l (-$C,A6),A3
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
            ds.b    4
SndPlay:
            link.w  A6,#-$C
            movem.l D4-D7/A3-A4,-(SP)
            move.b  (8,A6),D4
            movea.l ($E,A6),A4
            movea.l ($A,A6),A3
            tst.b   SdVolume
            bne.b   .L1
            move.w  #$FF37,($12,A6)
            bra.w   .L21
.L1:
            move.l  A3,D0
            beq.b   .L2
            tst.l   (A3)
            bne.b   .L3
.L2:
            move.w  #$FF34,($12,A6)
            bra.w   .L21
.L3:
            movea.l (A3),A0
            moveq   #2,D0
            cmp.w   (A0),D0
            blt.b   .L4
            movea.l (A3),A0
            tst.w   (A0)
            bgt.b   .L5
.L4:
            move.w  #$FF32,($12,A6)
            bra.w   .L21
.L5:
            move.l  A3,-(SP)
            jsr     (HGetState_2.w,PC)
            move.b  D0,D6
            move.l  A3,-(SP)
            jsr     (MoveHHi_2.w,PC)
            move.l  A3,-(SP)
            jsr     (HLock_3.w,PC)
            move.l  A4,D0
            seq     D5
            neg.b   D5
            lea     ($C,SP),SP
            beq.b   .L6
            moveq   #0,D0
            move.l  D0,(-$C,A6)
            subq.l  #2,SP
            pea     (-$C,A6)
            moveq   #0,D1
            move.w  D1,-(SP)
            move.l  D0,-(SP)
            pea     ASYNCHCALLBACK
            _SndNewChannel
            move.w  (SP)+,D7
            beq.b   .L8
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.w  D7,($12,A6)
            addq.l  #8,SP
            bra.w   .L21
.L6:
            move.l  A4,-(SP)
            jsr     checkChannel
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L7
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.w  #$FF33,($12,A6)
            addq.l  #8,SP
            bra.w   .L21
.L7:
            move.l  A4,(-$C,A6)
.L8:
            movea.l (A3),A0
            moveq   #1,D0
            cmp.w   (A0),D0
            bne.w   .L14
            movea.l (A3),A0
            tst.w   (2,A0)
            bne.b   .L10
            movea.l (-$C,A6),A0
            tst.l   (4,A0)
            bne.b   .L10
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #1,D1
            move.w  D1,-(SP)
            move.l  D0,-(SP)
            _SndAddModifier
            move.w  (SP)+,D7
            beq.b   .L10
            tst.b   D5
            beq.b   .L9
            move.l  (-$C,A6),-(SP)
            jsr     disposChannel
            addq.l  #4,SP
.L9:
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (4,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (6,A0),-(SP)
            jsr     SetDivTable
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.w  D7,($12,A6)
            lea     ($10,SP),SP
            bra.w   .L21
.L10:
            move.l  A3,-(SP)
            move.l  (-$C,A6),-(SP)
            jsr     pumpResource
            move.w  D0,D7
            addq.l  #8,SP
            beq.b   .L12
            tst.b   D5
            beq.b   .L11
            move.l  (-$C,A6),-(SP)
            jsr     disposChannel
            addq.l  #4,SP
.L11:
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.w  D7,($12,A6)
            addq.l  #8,SP
            bra.w   .L21
.L12:
            tst.b   D4
            beq.b   .L13
            tst.b   D5
            beq.b   .L13
            move.w  #$D,(-8,A6)
            ext.w   D6
            move.w  D6,(-6,A6)
            move.l  A3,(-4,A6)
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            pea     (-8,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDoCommand
            move.w  (SP)+,D7
            bra.w   .L19
.L13:
            tst.b   D5
            beq.w   .L19
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDisposeChannel
            move.w  (SP)+,D7
            bra.w   .L19
.L14:
            movea.l (A3),A0
            moveq   #2,D0
            cmp.w   (A0),D0
            bne.w   .L19
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #5,D1
            move.w  D1,-(SP)
            move.l  D0,-(SP)
            _SndAddModifier
            move.w  (SP)+,D7
            beq.b   .L16
            tst.b   D5
            beq.b   .L15
            move.l  (-$C,A6),-(SP)
            jsr     disposChannel
            addq.l  #4,SP
.L15:
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.w  D7,($12,A6)
            addq.l  #8,SP
            bra.w   .L21
.L16:
            move.w  #$51,(-8,A6)
            clr.w   (-6,A6)
            movea.l (A3),A4
            addq.l  #4,A4
            move.l  A4,D0
            addq.l  #2,D0
            move.w  (A4),D1
            ext.l   D1
            asl.l   #3,D1
            add.l   D0,D1
            move.l  D1,(-4,A6)
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            pea     (-8,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDoCommand
            move.w  (SP)+,D7
            beq.b   .L17
            tst.b   D5
            beq.b   .L19
            move.l  (-$C,A6),-(SP)
            jsr     disposChannel
            addq.l  #4,SP
            bra.b   .L19
.L17:
            tst.b   D4
            beq.b   .L18
            tst.b   D5
            beq.b   .L18
            move.w  #$D,(-8,A6)
            ext.w   D6
            move.w  D6,(-6,A6)
            move.l  A3,(-4,A6)
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            pea     (-8,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDoCommand
            move.w  (SP)+,D7
            bra.b   .L19
.L18:
            tst.b   D5
            beq.b   .L19
            subq.l  #2,SP
            move.l  (-$C,A6),-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            _SndDisposeChannel
            move.w  (SP)+,D7
.L19:
            tst.b   D4
            bne.b   .L20
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            addq.l  #8,SP
.L20:
            move.w  D7,($12,A6)
.L21:
            movem.l (-$24,A6),D4-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$A,SP
            jmp     (A0)
            ds.b    12
SndControl:
            link.w  A6,#-4
            movem.l D4-D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            move.w  ($C,A6),D7
            beq.w   .L9
            move.w  D7,D5
            cmpi.w  #$800,D7
            bge.b   .L3
            jsr     IsAscMac
            tst.w   D0
            beq.b   .L2
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            tst.b   ($2E,A0)
            beq.b   .L1
            cmpi.w  #5,D7
            bne.b   .L2
.L1:
            addi.w  #$800,D5
            bra.b   .L3
.L2:
            addi.w  #$1000,D5
.L3:
            moveq   #0,D0
            move.b  ResLoad,D0
            move.w  D0,D4
            moveq   #1,D0
            move.b  D0,-(SP)
            _SetResLoad
            subq.l  #4,SP
            move.l  #'snth',-(SP)
            move.w  D5,-(SP)
            jsr     MYGETRESOURCE
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L4
            tst.l   (A3)
            bne.b   .L8
.L4:
            subq.l  #4,SP
            move.l  #'snth',-(SP)
            move.w  D7,-(SP)
            jsr     MYGETRESOURCE
            movea.l (SP)+,A3
            move.l  A3,D0
            beq.b   .L5
            tst.l   (A3)
            bne.b   .L8
.L5:
            subq.l  #2,SP
            _ResError
            move.w  (SP)+,D6
            beq.b   .L6
            ext.l   D6
            move.l  D6,D0
            bra.b   .L7
.L6:
            move.l  #$FFFFFF34,D0
.L7:
            move.w  D0,D6
            move.b  D4,-(SP)
            _SetResLoad
            move.w  D6,($E,A6)
            bra.b   .L11
.L8:
            move.b  D4,-(SP)
            _SetResLoad
            move.l  A3,-(SP)
            jsr     (HGetState_2.w,PC)
            move.b  D0,D4
            move.l  A3,-(SP)
            jsr     (HLock_3.w,PC)
            move.l  A3,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     MyHoldMemory
            move.l  (A3),(-4,A6)
            subq.l  #2,SP
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            move.l  D0,-(SP)
            move.l  (-4,A6),-(SP)
            jsr     (CallPascal.w,PC)
            ext.w   D4
            ext.l   D4
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A3,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     MyUnholdMemory
            lea     ($22,SP),SP
            bra.b   .L10
.L9:
            move.l  A4,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     ChannelModifier
            addq.l  #8,SP
.L10:
            clr.w   ($E,A6)
.L11:
            movem.l (-$1C,A6),D4-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
            ds.b    8
SndAddModifier:
            link.w  A6,#-$C
            movem.l D4-D7/A3-A4,-(SP)
            move.l  (8,A6),D4
            move.w  ($C,A6),D7
            move.l  ($12,A6),-(SP)
            jsr     checkChannel
            tst.b   D0
            addq.l  #4,SP
            beq.b   .L1
            move.w  #$FF33,($16,A6)
            bra.w   .L35
.L1:
            tst.l   ($E,A6)
            bne.w   .L17
            tst.w   D7
            bne.b   .L2
            clr.w   ($16,A6)
            bra.w   .L35
.L2:
            tst.b   SoundActive
            beq.b   .L7
            tst.b   SoundActive
            bge.b   .L3
            move.w  #$FF37,($16,A6)
            bra.w   .L35
.L3:
            cmpi.w  #1,D7
            bne.b   .L4
            move.w  #$FF37,($16,A6)
            bra.w   .L35
.L4:
            cmpi.w  #5,D7
            bne.b   .L5
            jsr     IsAscMac
            tst.l   D0
            bne.b   .L5
            move.w  #$FF37,($16,A6)
            bra.w   .L35
.L5:
            cmpi.w  #3,D7
            beq.b   .L6
            cmpi.w  #5,D7
            bne.b   .L7
.L6:
            move.b  SoundActive,D0
            ext.w   D0
            ext.l   D0
            ext.l   D7
            cmp.l   D0,D7
            beq.b   .L7
            move.w  #$FF37,($16,A6)
            bra.w   .L35
.L7:
            move.w  D7,D5
            cmpi.w  #$800,D7
            bge.b   .L10
            jsr     IsAscMac
            tst.l   D0
            beq.b   .L9
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            tst.b   ($2E,A0)
            beq.b   .L8
            cmpi.w  #5,D7
            bne.b   .L9
.L8:
            addi.w  #$800,D5
            bra.b   .L10
.L9:
            addi.w  #$1000,D5
.L10:
            moveq   #0,D0
            move.b  ResLoad,D0
            move.w  D0,D6
            moveq   #1,D0
            move.b  D0,-(SP)
            _SetResLoad
            subq.l  #4,SP
            move.l  #'snth',-(SP)
            move.w  D5,-(SP)
            jsr     MYGETRESOURCE
            movea.l (SP)+,A4
            move.l  A4,D0
            beq.b   .L11
            tst.l   (A4)
            bne.b   .L16
.L11:
            cmpi.w  #$800,D7
            bge.b   .L12
            subq.l  #4,SP
            move.l  #'snth',-(SP)
            move.w  D7,-(SP)
            jsr     MYGETRESOURCE
            movea.l (SP)+,A4
.L12:
            move.l  A4,D0
            beq.b   .L13
            tst.l   (A4)
            bne.b   .L16
.L13:
            subq.l  #2,SP
            _ResError
            move.w  (SP)+,D5
            beq.b   .L14
            ext.l   D5
            move.l  D5,D0
            bra.b   .L15
.L14:
            move.l  #$FFFFFF34,D0
.L15:
            move.w  D0,D5
            move.b  D6,-(SP)
            _SetResLoad
            move.w  D5,($16,A6)
            bra.w   .L35
.L16:
            move.b  D6,-(SP)
            _SetResLoad
.L17:
            tst.l   ($E,A6)
            bne.b   .L18
            move.l  A4,-(SP)
            jsr     (HGetState_2.w,PC)
            move.b  D0,D6
            move.l  A4,-(SP)
            jsr     (MoveHHi_2.w,PC)
            move.l  A4,-(SP)
            jsr     (HLock_3.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyHoldMemory
            lea     ($14,SP),SP
.L18:
            moveq   #$70,D0
            move.l  D0,-(SP)
            jsr     (NewSysPtr.w,PC)
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #4,SP
            bne.b   .L20
            tst.l   ($E,A6)
            bne.b   .L19
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L19:
            jsr     (MemError.w,PC)
            move.w  D0,($16,A6)
            bra.w   .L35
.L20:
            moveq   #0,D0
            move.l  D0,($C,A3)
            move.l  D0,($10,A3)
            move.l  D0,(8,A3)
            clr.b   ($14,A3)
            moveq   #$1E,D1
            move.l  D1,-(SP)
            jsr     (NewSysPtr.w,PC)
            move.l  D0,($3A,A3)
            addq.l  #4,SP
            bne.b   .L22
            tst.l   ($E,A6)
            bne.b   .L21
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L21:
            jsr     (MemError.w,PC)
            move.w  D0,($16,A6)
            bra.w   .L35
.L22:
            movea.l ($3A,A3),A0
            moveq   #0,D0
            move.l  D0,($E,A0)
            lea     OnHowOften,A0
            movea.l ($3A,A3),A1
            move.l  A0,(6,A1)
            movea.l ($3A,A3),A0
            move.l  ($12,A6),($16,A0)
            movea.l ($3A,A3),A0
            move.l  A3,($1A,A0)
            move.l  ($3A,A3),-(SP)
            jsr     (InstallXTimer.w,PC)
            movea.l ($12,A6),A0
            tst.l   (4,A0)
            addq.l  #4,SP
            bne.b   .L25
            moveq   #$1E,D0
            move.l  D0,-(SP)
            jsr     (NewSysPtr.w,PC)
            move.l  D0,($3E,A3)
            addq.l  #4,SP
            bne.b   .L24
            tst.l   ($E,A6)
            bne.b   .L23
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L23:
            move.l  ($3A,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            jsr     (MemError.w,PC)
            move.w  D0,($16,A6)
            addq.l  #4,SP
            bra.w   .L35
.L24:
            movea.l ($3E,A3),A0
            moveq   #0,D0
            move.l  D0,($E,A0)
            lea     OnWait,A0
            movea.l ($3E,A3),A1
            move.l  A0,(6,A1)
            movea.l ($3E,A3),A0
            move.l  ($12,A6),($16,A0)
            move.l  ($3E,A3),-(SP)
            jsr     (InstallXTimer.w,PC)
            addq.l  #4,SP
.L25:
            tst.l   ($E,A6)
            bne.b   .L28
            ori.b   #1,($14,A3)
            move.l  (A4),-(SP)
            jsr     findModifier
            move.l  D0,(-$C,A6)
            addq.l  #4,SP
            beq.b   .L26
            movea.l (-$C,A6),A0
            move.b  ($15,A0),($15,A3)
            bra.b   .L27
.L26:
            move.b  D6,($15,A3)
.L27:
            move.l  (A4),(4,A3)
            bra.b   .L29
.L28:
            move.l  ($E,A6),(4,A3)
.L29:
            cmpi.w  #5,D7
            bne.w   .L32
            jsr     IsAscMac
            tst.l   D0
            beq.w   .L32
            move.w  #$1A,(-8,A6)
            move.l  D4,(-4,A6)
            subq.l  #2,SP
            moveq   #5,D0
            move.w  D0,-(SP)
            pea     (-8,A6)
            _SndControl
            move.w  (SP)+,D5
            jsr     (SMGlobalLoc.w,PC)
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (-6,A6),D0
            cmp.w   ($16,A0),D0
            ble.b   .L31
            tst.l   ($E,A6)
            bne.b   .L30
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L30:
            move.l  ($3A,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            move.l  ($3E,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            move.w  #$FF37,($16,A6)
            addq.l  #8,SP
            bra.w   .L35
.L31:
            move.w  #$1B,(-8,A6)
            move.l  D4,(-4,A6)
            subq.l  #2,SP
            moveq   #5,D0
            move.w  D0,-(SP)
            pea     (-8,A6)
            _SndControl
            move.w  (SP)+,D5
            move.w  (-6,A6),D0
            ext.l   D0
            move.l  D0,($64,A3)
            move.l  D4,($60,A3)
.L32:
            jsr     (BlockInts.w,PC)
            move.w  D0,D5
            move.w  #1,(-8,A6)
            move.l  D4,(-4,A6)
            move.l  A3,-(SP)
            pea     (-8,A6)
            move.l  ($12,A6),-(SP)
            jsr     processCommandFrom
            moveq   #-1,D0
            cmp.l   (-4,A6),D0
            lea     ($C,SP),SP
            bne.b   .L34
            tst.l   ($E,A6)
            bne.b   .L33
            ext.w   D6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  A4,-(SP)
            jsr     (HSetState_2.w,PC)
            move.l  A4,-(SP)
            jsr     (GetHandleSize_3.w,PC)
            addq.l  #4,SP
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            jsr     MyUnholdMemory
            lea     ($10,SP),SP
.L33:
            move.l  ($3A,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            move.l  ($3E,A3),-(SP)
            jsr     (DisposPtr_2.w,PC)
            ext.l   D5
            move.l  D5,-(SP)
            jsr     (UnBlockInts.w,PC)
            move.w  #$FF94,($16,A6)
            lea     ($C,SP),SP
            bra.b   .L35
.L34:
            movea.l ($12,A6),A0
            move.l  (4,A0),(A3)
            movea.l ($12,A6),A0
            move.l  A3,(4,A0)
            ext.l   D5
            move.l  D5,-(SP)
            jsr     (UnBlockInts.w,PC)
            clr.w   ($16,A6)
            addq.l  #4,SP
.L35:
            movem.l (-$24,A6),D4-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$E,SP
            jmp     (A0)
            ds.b    8

            EVEN
