            include "Include/ROMHeader.s"

            EXPORT  GI_AllocPermMem,GI_ExecuteTest,GI_FindSubtest,GI_InitInterface,GI_InstallSubtest,GI_InstallTest

            SECTION "Part12",CODE

SetInterruptLevel:
            jsr     GetInterruptLevel
            move.l  (4,SP),D1
            lsl.w   #8,D1
            move    SR,D2
            andi.w  #$F8FF,D2
            or.w    D1,D2
            move    D2,SR
            rts
            ds.b    10
GetInterruptLevel:
            move    SR,D0
            lsr.w   #8,D0
            andi.w  #7,D0
            rts
            ds.b    6
InstallExceptionVector:
            move.l  (8,SP),D0
            jsr     FindVectorEntry
            move.l  (A0),D0
            move.l  (4,SP),(A0)
            rts
ExceptionHandlerStub:
            movem.l D0-D3/A0-A1,-(SP)
            movea.l ($18,SP),A1
            move.w  ($22,SP),D3
            rol.w   #4,D3
            andi.l  #$F,D3
            move.l  (8,A1),-(SP)
            pea     ($20,SP)
            move.l  D3,-(SP)
            move.l  (A1),-(SP)
            movea.l (4,A1),A0
            jsr     (A0)
            lea     ($10,SP),SP
            movem.l (SP)+,D0-D3/A0-A1
            addq.l  #4,SP
            rte
            ds.b    14
FakeExceptionCall:
            move.l  (4,SP),D0
            jsr     FindVectorEntry
            movea.l (A0),A0
            move.l  (4,SP),D1
            asl.w   #2,D1
            move.w  D1,-(SP)
            pea     .L1
            move    SR,-(SP)
            jmp     (A0)
.L1:
            dc.w    $4E75
            ds.b    4
FindVectorEntry:
            movec   VBR,A0
CalcVectorEntry:
            lsl.w   #2,D0
            lea     (0,A0,D0.w),A0
            rts
            ds.b    4
GetCTEGlobals:
            move.l  ($16,A5),D0
            rts
            ds.b    10
BitWalk8:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            clr.b   (5,A3)
            bra.w   .L10
.L1:
            tst.b   (5,A3)
            bne.b   .L2
            moveq   #0,D0
            move.b  (7,A4),D0
            bra.b   .L3
.L2:
            move.b  (7,A4),D0
            not.b   D0
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D0
.L3:
            move.b  D0,(A3)
            clr.b   (4,A3)
            bra.w   .L9
.L4:
            move.b  (4,A4),D0
            not.b   D0
            move.b  (5,A4),D1
            and.b   D0,D1
            move.b  (A3),D0
            and.b   (4,A4),D0
            or.b    D1,D0
            move.b  D0,(1,A3)
            tst.l   ($C,A4)
            beq.b   .L5
            moveq   #0,D0
            move.b  (1,A3),D0
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($C,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L6
.L5:
            movea.l (A4),A0
            move.b  (1,A3),(A0)
.L6:
            tst.l   ($10,A4)
            beq.b   .L7
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($10,A4),A0
            jsr     (A0)
            move.b  D0,(2,A3)
            addq.l  #8,SP
            bra.b   .L8
.L7:
            movea.l (A4),A0
            move.b  (A0),(2,A3)
.L8:
            move.b  (2,A3),D0
            move.b  (1,A3),D1
            eor.b   D0,D1
            and.b   (6,A4),D1
            move.b  D1,(3,A3)
            bne.b   .L12
            moveq   #1,D0
            move.l  D0,-(SP)
            moveq   #0,D1
            move.b  (A3),D1
            move.l  D1,-(SP)
            move.l  (SP),D0
            move.l  (4,SP),D1
            rol.b   D1,D0
            move.b  D0,(A3)
            addq.l  #8,SP
            addq.b  #1,(4,A3)
.L9:
            moveq   #8,D0
            cmp.b   (4,A3),D0
            bhi.w   .L4
            addq.b  #1,(5,A3)
.L10:
            moveq   #1,D0
            cmp.b   (5,A3),D0
            bge.w   .L1
            tst.l   ($C,A4)
            beq.b   .L11
            moveq   #0,D0
            move.b  (8,A4),D0
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($C,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L12
.L11:
            movea.l (A4),A0
            move.b  (8,A4),(A0)
.L12:
            move.b  (3,A3),D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    12
BitWalk16:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            clr.b   (8,A3)
            bra.w   .L10
.L1:
            tst.b   (8,A3)
            bne.b   .L2
            moveq   #0,D0
            move.w  ($A,A4),D0
            bra.b   .L3
.L2:
            move.w  ($A,A4),D0
            not.w   D0
            moveq   #0,D1
            move.w  D0,D1
            move.l  D1,D0
.L3:
            move.w  D0,(A3)
            clr.w   ($A,A3)
            bra.w   .L9
.L4:
            move.w  (4,A4),D0
            not.w   D0
            move.w  (6,A4),D1
            and.w   D0,D1
            move.w  (A3),D0
            and.w   (4,A4),D0
            or.w    D1,D0
            move.w  D0,(2,A3)
            tst.l   ($10,A4)
            beq.b   .L5
            moveq   #0,D0
            move.w  (2,A3),D0
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($10,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L6
.L5:
            movea.l (A4),A0
            move.w  (2,A3),(A0)
.L6:
            tst.l   ($14,A4)
            beq.b   .L7
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($14,A4),A0
            jsr     (A0)
            move.w  D0,(4,A3)
            addq.l  #8,SP
            bra.b   .L8
.L7:
            movea.l (A4),A0
            move.w  (A0),(4,A3)
.L8:
            move.w  (4,A3),D0
            move.w  (2,A3),D1
            eor.w   D0,D1
            and.w   (8,A4),D1
            move.w  D1,(6,A3)
            bne.b   .L12
            moveq   #1,D0
            move.l  D0,-(SP)
            moveq   #0,D1
            move.w  (A3),D1
            move.l  D1,-(SP)
            move.l  (SP),D0
            move.l  (4,SP),D1
            rol.w   D1,D0
            move.w  D0,(A3)
            addq.l  #8,SP
            addq.w  #1,($A,A3)
.L9:
            moveq   #$10,D0
            cmp.w   ($A,A3),D0
            bhi.w   .L4
            addq.b  #1,(8,A3)
.L10:
            moveq   #1,D0
            cmp.b   (8,A3),D0
            bge.w   .L1
            tst.l   ($10,A4)
            beq.b   .L11
            moveq   #0,D0
            move.w  ($C,A4),D0
            move.l  D0,-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($10,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L12
.L11:
            movea.l (A4),A0
            move.w  ($C,A4),(A0)
.L12:
            move.w  (6,A3),D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    12
BitWalk32:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            clr.b   ($10,A3)
            bra.w   .L10
.L1:
            tst.b   ($10,A3)
            bne.b   .L2
            move.l  ($10,A4),D0
            bra.b   .L3
.L2:
            move.l  ($10,A4),D0
            not.l   D0
.L3:
            move.l  D0,(A3)
            moveq   #0,D0
            move.l  D0,($14,A3)
            bra.w   .L9
.L4:
            move.l  (4,A4),D0
            not.l   D0
            move.l  (8,A4),D1
            and.l   D0,D1
            move.l  (A3),D0
            and.l   (4,A4),D0
            or.l    D1,D0
            move.l  D0,(4,A3)
            tst.l   ($18,A4)
            beq.b   .L5
            move.l  (4,A3),-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($18,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L6
.L5:
            movea.l (A4),A0
            move.l  (4,A3),(A0)
.L6:
            tst.l   ($1C,A4)
            beq.b   .L7
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($1C,A4),A0
            jsr     (A0)
            move.l  D0,(8,A3)
            addq.l  #8,SP
            bra.b   .L8
.L7:
            movea.l (A4),A0
            move.l  (A0),(8,A3)
.L8:
            move.l  (8,A3),D0
            move.l  (4,A3),D1
            eor.l   D0,D1
            and.l   ($C,A4),D1
            move.l  D1,($C,A3)
            bne.b   .L12
            moveq   #1,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            move.l  (SP),D0
            move.l  (4,SP),D1
            rol.l   D1,D0
            move.l  D0,(A3)
            addq.l  #8,SP
            addq.l  #1,($14,A3)
.L9:
            moveq   #$20,D0
            cmp.l   ($14,A3),D0
            bhi.w   .L4
            addq.b  #1,($10,A3)
.L10:
            moveq   #1,D0
            cmp.b   ($10,A3),D0
            bge.w   .L1
            tst.l   ($18,A4)
            beq.b   .L11
            move.l  ($14,A4),-(SP)
            move.l  (A4),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($18,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            bra.b   .L12
.L11:
            movea.l (A4),A0
            move.l  ($14,A4),(A0)
.L12:
            move.l  ($C,A3),D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
            ds.b    14
InstallExceptionHandler:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            move.l  ($18,A6),D7
            movea.l ($C,A6),A3
            move.w  #$4EB9,(A3)
            lea     ExceptionHandlerStub,A0
            move.l  A0,(2,A3)
            move.l  A4,(6,A3)
            move.l  ($10,A6),($A,A3)
            move.l  ($14,A6),($E,A3)
            move.w  D7,($1A,A3)
            move.l  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  (0,A0,D0.l),($16,A3)
            move.l  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  A3,(0,A0,D0.l)
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            jsr     InstallExceptionVector
            move.l  D0,($12,A3)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    12
RemoveExceptionHandler:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($14,SP),A3
            move.w  ($1A,A3),D7
            moveq   #0,D0
            move.w  D7,D0
            move.l  D0,-(SP)
            move.l  ($12,A3),-(SP)
            jsr     InstallExceptionVector
            moveq   #0,D0
            move.w  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  ($16,A3),(0,A0,D0.l)
            addq.l  #8,SP
            movem.l (SP)+,D7/A3-A4
            rts
            ds.b    10
GetExceptionInfoPtrTable:
            jsr     GetCTEGlobals
            movea.l D0,A0
            lea     ($94,A0),A0
            move.l  A0,D0
            rts
            dc.w    0
GI_InitInterface:
            link.w  A6,#0
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            moveq   #0,D7
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            move.l  A3,-(SP)
            jsr     InitHeap
            pea     ($494).w
            move.l  A3,-(SP)
            jsr     AllocPermMem
            tst.l   D0
            lea     ($14,SP),SP
            bne.b   .L1
            moveq   #-6,D7
            bra.b   .L2
.L1:
            move.l  #$1504005,(A3)
            pea     ($38,A3)
            jsr     InitList
            pea     ($48,A3)
            jsr     InitList
            lea     DoSubtest,A0
            move.l  A0,($58,A3)
            lea     BitWalk8,A0
            move.l  A0,($68,A3)
            lea     BitWalk16,A0
            move.l  A0,($6C,A3)
            lea     BitWalk32,A0
            move.l  A0,($70,A3)
            lea     InstallExceptionHandler,A0
            move.l  A0,($74,A3)
            lea     RemoveExceptionHandler,A0
            move.l  A0,($78,A3)
            lea     FakeExceptionCall,A0
            move.l  A0,($7C,A3)
            lea     SetInterruptLevel,A0
            move.l  A0,($80,A3)
            lea     GetInterruptLevel,A0
            move.l  A0,($84,A3)
            lea     InstallExceptionVector,A0
            move.l  A0,($88,A3)
            lea     AllocPermMem,A0
            move.l  A0,($8C,A3)
            lea     AllocTempMem,A0
            move.l  A0,($90,A3)
            addq.l  #8,SP
.L2:
            move.l  D7,D0
            movem.l (-8,A6),D7/A3
            unlk    A6
            rts
            ds.b    12
GI_GetVersion:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  A3,D0
            movea.l (SP)+,A3
            rts
            ds.b    4
GI_InstallTest:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            moveq   #0,D7
            moveq   #$1C,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            jsr     AllocPermMem
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #8,SP
            bne.b   .L1
            moveq   #-7,D7
            bra.b   .L2
.L1:
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            jsr     InitNode_2
            move.l  ($10,A6),($10,A3)
            move.l  ($14,A6),($14,A3)
            move.l  ($18,A6),($18,A3)
            move.l  A3,-(SP)
            pea     ($38,A4)
            jsr     InsertNode
            lea     ($14,SP),SP
.L2:
            move.l  D7,D0
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
            dc.w    0
GI_InstallSubtest:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            moveq   #0,D7
            moveq   #$24,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            jsr     AllocPermMem
            movea.l D0,A3
            move.l  A3,D0
            addq.l  #8,SP
            bne.b   .L1
            moveq   #-8,D7
            bra.b   .L2
.L1:
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            jsr     InitNode_2
            move.l  ($10,A6),($10,A3)
            move.l  ($14,A6),($14,A3)
            move.l  ($18,A6),($20,A3)
            move.l  ($1C,A6),($18,A3)
            move.l  ($20,A6),($1C,A3)
            move.l  A3,-(SP)
            pea     ($48,A4)
            jsr     InsertNode
            lea     ($14,SP),SP
.L2:
            move.l  D7,D0
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    6
GI_FindTest:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            pea     ($38,A3)
            jsr     FindKeyedNode
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
GI_FindFirstTest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($38,A3)
            jsr     FindFirstNode
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_FindNextTest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($38,A3)
            jsr     FindNextNode
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_FindSubtest:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            pea     ($48,A3)
            jsr     FindKeyedNode
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
GI_FindFirstSubtest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($48,A3)
            jsr     FindFirstNode
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_FindNextSubtest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($48,A3)
            jsr     FindNextNode
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_ExecuteTest:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($18,A6),-(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            jsr     DoTest
            movea.l (-4,A6),A3
            unlk    A6
            rts
            ds.b    8
GI_AllocPermMem:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            jsr     AllocPermMem
            movea.l (-4,A6),A3
            unlk    A6
            rts
            ds.b    4
GI_AllocTempMem:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            jsr     AllocTempMem
            movea.l (-4,A6),A3
            unlk    A6
            rts
            ds.b    4
GI_FreeTempMem:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  A3,-(SP)
            jsr     FreeTempMem
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    14
GI_GetLastTestID:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  (4,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastSubtestID:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  (8,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastTestModifier:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($C,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastSubtestParams:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($14,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastSubtestParamsSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($10,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastSubtestResults:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($1C,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetLastSubtestResultsSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($18,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetTestAddress:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($10,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetTestSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($14,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetTestName:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($18,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetSubtestAddress:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($10,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetSubtestSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($14,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetSubtestParamsSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($18,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetSubtestResultsSize:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($1C,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GI_GetSubtestName:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($20,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
InitHeap:
            movem.l A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($C,SP),A3
            move.l  A4,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,($24,A3)
            move.l  D1,($30,A3)
            move.l  ($14,SP),D0
            add.l   A4,D0
            moveq   #-4,D1
            and.l   D0,D1
            move.l  D1,($28,A3)
            move.l  D1,($34,A3)
            move.l  ($24,A3),D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    6
AllocPermMem:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            move.l  ($C,A6),D7
            movea.l (8,A6),A3
            move.l  D7,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,D7
            move.l  D7,D0
            add.l   ($30,A3),D0
            move.l  D0,(-4,A6)
            cmp.l   ($34,A3),D0
            bls.b   .L1
            moveq   #0,D0
            movea.l D0,A4
            bra.b   .L2
.L1:
            movea.l ($30,A3),A4
            move.l  (-4,A6),($30,A3)
.L2:
            move.l  A4,D0
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    8
AllocTempMem:
            link.w  A6,#-4
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($C,A6),D6
            movea.l (8,A6),A4
            move.l  D6,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,D6
            movea.l ($34,A4),A3
            suba.l  D6,A3
            cmpa.l  ($30,A4),A3
            bcc.b   .L1
            moveq   #0,D0
            move.l  D0,(-4,A6)
            bra.b   .L4
.L1:
            move.l  A3,($34,A4)
            move.l  ($34,A4),(-4,A6)
            movea.l (-4,A6),A3
            move.l  D6,D7
            asr.l   #2,D7
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.l  D0,(A3)+
            subq.l  #1,D7
.L3:
            tst.l   D7
            bgt.b   .L2
.L4:
            move.l  (-4,A6),D0
            movem.l (-$14,A6),D6-D7/A3-A4
            unlk    A6
            rts
            ds.b    4
FreeTempMem:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($28,A3),($34,A3)
            movea.l (SP)+,A3
            rts
InitNode_2:
            movem.l A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($C,SP),A3
            move.l  ($10,SP),(8,A3)
            move.l  A4,($C,A3)
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            dc.w    0
GetNodeContents:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($C,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
GetNodeKey:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  (8,A3),D0
            movea.l (SP)+,A3
            rts
            dc.w    0
InitList:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            movea.l A3,A0
            addq.l  #4,A0
            move.l  A0,(A3)
            move.l  A3,(8,A3)
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.l  A3,($C,A3)
            move.l  A3,D0
            movea.l (SP)+,A3
            rts
FindNextNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($C,A4),A0
            movea.l (A0),A3
            movea.l A4,A0
            addq.l  #4,A0
            cmpa.l  A0,A3
            beq.b   .L1
            move.l  A3,($C,A4)
            bra.b   .L2
.L1:
            moveq   #0,D0
            movea.l D0,A3
.L2:
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    8
FindPrevNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($C,A4),A0
            movea.l (4,A0),A3
            cmpa.l  A4,A3
            beq.b   .L1
            move.l  A3,($C,A4)
            bra.b   .L2
.L1:
            moveq   #0,D0
            movea.l D0,A3
.L2:
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    10
FindFirstNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A3
            movea.l (A3),A4
            movea.l A3,A0
            addq.l  #4,A0
            cmpa.l  A0,A4
            bne.b   .L1
            move.l  A3,($C,A3)
            moveq   #0,D0
            movea.l D0,A4
            bra.b   .L2
.L1:
            move.l  A4,($C,A3)
.L2:
            move.l  A4,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    8
FindLastNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l (8,A4),A3
            cmpa.l  A4,A3
            beq.b   .L1
            move.l  A3,($C,A4)
            bra.b   .L2
.L1:
            moveq   #0,D0
            movea.l D0,A3
.L2:
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    14
FindKeyedNode:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            move.l  ($C,A6),D7
            movea.l (8,A6),A4
            moveq   #0,D0
            move.l  D0,(-4,A6)
            move.l  A4,-(SP)
            jsr     FindFirstNode
            movea.l D0,A3
            addq.l  #4,SP
            bra.b   .L3
.L1:
            move.l  A3,-(SP)
            jsr     GetNodeKey
            cmp.l   D7,D0
            addq.l  #4,SP
            bne.b   .L2
            move.l  A3,(-4,A6)
            bra.b   .L4
.L2:
            move.l  A4,-(SP)
            jsr     FindNextNode
            movea.l D0,A3
            addq.l  #4,SP
.L3:
            move.l  A3,D0
            bne.b   .L1
.L4:
            move.l  (-4,A6),D0
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
InsertNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.l  A4,(4,A3)
            move.l  (A4),(A3)
            movea.l (4,A3),A0
            move.l  A3,(A0)
            movea.l (A3),A0
            move.l  A3,(4,A0)
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    10
AppendNode:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.l  (8,A4),(4,A3)
            movea.l A4,A0
            addq.l  #4,A0
            move.l  A0,(A3)
            movea.l (4,A3),A0
            move.l  A3,(A0)
            movea.l (A3),A0
            move.l  A3,(4,A0)
            move.l  A3,D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    4
RemoveNode:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            movea.l (4,A3),A0
            move.l  (A3),(A0)
            movea.l (A3),A0
            move.l  (4,A3),(4,A0)
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.l  D0,(A3)
            move.l  A3,D0
            movea.l (SP)+,A3
            rts
            ds.b    14
FindSubtest:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            pea     ($48,A3)
            jsr     FindKeyedNode
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
DoSubtest:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A3
            move.l  (8,A3),-(SP)
            move.l  A3,-(SP)
            jsr     FindSubtest
            move.l  D0,(-4,A6)
            addq.l  #8,SP
            bne.b   .L1
            moveq   #-5,D7
            bra.b   .L7
.L1:
            movea.l (-4,A6),A0
            movea.l ($10,A0),A4
            move.l  ($20,A3),D0
            bcs.b   .L6
            cmpi.l  #1,D0
            bhi.b   .L6
            add.l   D0,D0
            move.w  .L3(PC,D0.l),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L5-(.L2+2)
            dc.w    .L4-(.L2+2)
.L4:
            moveq   #-2,D7
            bra.b   .L7
.L5:
            move.l  ($1C,A3),-(SP)
            move.l  ($14,A3),-(SP)
            move.l  A3,-(SP)
            jsr     (A4)
            move.l  D0,D7
            lea     ($C,SP),SP
            bra.b   .L7
.L6:
            moveq   #-1,D7
.L7:
            move.l  D7,D0
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    4
FindTest:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),-(SP)
            pea     ($38,A3)
            jsr     FindKeyedNode
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
DoTest:
            link.w  A6,#-$C
            movem.l D4-D7/A3-A4,-(SP)
            move.l  ($C,A6),D4
            movea.l (8,A6),A3
            moveq   #0,D0
            move.l  D0,(-$C,A6)
            movea.l D0,A4
            move.l  D0,(-8,A6)
            moveq   #0,D5
            move.l  D0,(-4,A6)
            moveq   #0,D6
            move.l  A3,-(SP)
            jsr     FreeTempMem
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            jsr     FindTest
            move.l  D0,(-$C,A6)
            lea     ($C,SP),SP
            bne.b   .L1
            moveq   #-4,D7
            bra.w   .L10
.L1:
            move.l  D4,(4,A3)
            move.l  ($14,A6),($C,A3)
            move.l  ($18,A6),($20,A3)
            move.l  ($10,A6),-(SP)
            move.l  A3,-(SP)
            jsr     FindSubtest
            movea.l D0,A4
            move.l  A4,D0
            addq.l  #8,SP
            bne.b   .L2
            moveq   #-5,D7
            bra.w   .L10
.L2:
            move.l  ($18,A4),D5
            move.l  D5,-(SP)
            move.l  A3,-(SP)
            jsr     AllocTempMem
            move.l  D0,(-8,A6)
            addq.l  #8,SP
            bne.b   .L3
            moveq   #-9,D7
            bra.b   .L10
.L3:
            move.l  ($1C,A4),D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     AllocTempMem
            move.l  D0,(-4,A6)
            addq.l  #8,SP
            bne.b   .L4
            moveq   #-$A,D7
            bra.b   .L10
.L4:
            move.l  ($10,A6),(8,A3)
            move.l  (-8,A6),($14,A3)
            move.l  D5,($10,A3)
            move.l  (-4,A6),($1C,A3)
            move.l  D6,($18,A3)
            move.l  ($20,A3),D0
            bcs.b   .L9
            cmpi.l  #2,D0
            bhi.b   .L9
            add.l   D0,D0
            move.w  .L6(PC,D0.l),D0
.L5:
            jmp     .L5+2(PC,D0.w)
.L6:
            dc.w    .L7-(.L5+2)
            dc.w    .L7-(.L5+2)
            dc.w    .L8-(.L5+2)
.L7:
            move.l  (8,A3),-(SP)
            move.l  ($C,A3),-(SP)
            move.l  ($14,A3),-(SP)
            move.l  A3,-(SP)
            movea.l (-$C,A6),A0
            movea.l ($10,A0),A0
            jsr     (A0)
            move.l  D0,D7
            lea     ($10,SP),SP
            bra.b   .L10
.L8:
            moveq   #-3,D7
            bra.b   .L10
.L9:
            moveq   #-1,D7
.L10:
            move.l  D7,D0
            movem.l (-$24,A6),D4-D7/A3-A4
            unlk    A6
            rts
            ds.b    12
BitWalk_a_No_By_Law_register:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A4
            move.l  ($1C,SP),D7
            movea.l ($18,SP),A3
            move.l  D7,(4,A3)
            movea.l ($14,SP),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),(8,A3)
            move.w  #$FFFF,($C,A3)
            clr.w   ($E,A3)
            move.w  #$FFFF,($10,A3)
            move.w  #1,($12,A3)
            movea.l ($14,SP),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            movea.l (0,A0,D0.l),A0
            move.w  (A0),($14,A3)
            moveq   #0,D0
            move.l  D0,($18,A3)
            move.l  D0,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  A4,-(SP)
            movea.l ($6C,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            movem.l (SP)+,D7/A3-A4
            rts
BitWalk_a_bit0_equals_0_register:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A4
            move.l  ($1C,SP),D7
            movea.l ($18,SP),A3
            move.l  D7,(4,A3)
            movea.l ($14,SP),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),(8,A3)
            move.w  #$FFFE,($C,A3)
            clr.w   ($E,A3)
            move.w  #$FFFF,($10,A3)
            move.w  #1,($12,A3)
            movea.l ($14,SP),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            movea.l (0,A0,D0.l),A0
            move.w  (A0),($14,A3)
            moveq   #0,D0
            move.l  D0,($18,A3)
            move.l  D0,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  A4,-(SP)
            movea.l ($6C,A4),A0
            jsr     (A0)
            lea     ($C,SP),SP
            movem.l (SP)+,D7/A3-A4
            rts
Read_and_Invert:
            move.l  A3,-(SP)
            movea.l ($C,SP),A3
            move.w  (A3),D0
            not.w   D0
            movea.l (SP)+,A3
            rts
            dc.w    0
BitWalk_data_inverted_register:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            move.l  ($14,A6),D7
            movea.l (8,A6),A4
            movea.l ($10,A6),A3
            move.l  D7,(4,A3)
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),(8,A3)
            move.w  #$FFFF,($C,A3)
            clr.w   ($E,A3)
            move.w  #$FFFF,($10,A3)
            move.w  #1,($12,A3)
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D7,D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),-(SP)
            move.l  A4,-(SP)
            jsr     Read_and_Invert
            move.w  D0,($14,A3)
            moveq   #0,D0
            move.l  D0,($18,A3)
            lea     Read_and_Invert,A0
            move.l  A0,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  A4,-(SP)
            movea.l ($6C,A4),A0
            jsr     (A0)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
            dc.w    0
Read_and_shift_left_once:
            move.l  A3,-(SP)
            movea.l ($C,SP),A3
            move.w  (A3),D0
            lsl.w   #1,D0
            movea.l (SP)+,A3
            rts
            dc.w    0
Read_and_shift_left_twice:
            move.l  A3,-(SP)
            movea.l ($C,SP),A3
            move.w  (A3),D0
            lsl.w   #2,D0
            movea.l (SP)+,A3
            rts
            dc.w    0
BitWalk_data_shifted_register:
            link.w  A6,#-$C
            movem.l D7/A3-A4,-(SP)
            move.l  ($14,A6),D7
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            move.l  (8,A6),(-$C,A6)
            movea.l A3,A0
            addq.l  #8,A0
            move.l  A0,(-8,A6)
            lea     ($20,A3),A0
            move.l  A0,(-4,A6)
            move.l  D7,(4,A3)
            movea.l (A4),A0
            move.l  D7,D0
            asl.l   #2,D0
            move.l  (0,A0,D0.l),(8,A3)
            move.w  #$FFFF,($C,A3)
            clr.w   ($E,A3)
            tst.l   (4,A4)
            beq.b   .L1
            move.l  #$FFFC,D0
            bra.b   .L2
.L1:
            move.l  #$FFFE,D0
.L2:
            move.w  D0,($10,A3)
            move.w  #1,($12,A3)
            movea.l (A4),A0
            move.l  D7,D0
            asl.l   #2,D0
            movea.l (0,A0,D0.l),A0
            move.l  (4,A4),D0
            addq.l  #1,D0
            move.w  (A0),D1
            lsl.w   D0,D1
            move.w  D1,($14,A3)
            moveq   #0,D0
            move.l  D0,($18,A3)
            tst.l   (4,A4)
            beq.b   .L3
            lea     Read_and_shift_left_twice,A0
            move.l  A0,D1
            bra.b   .L4
.L3:
            lea     Read_and_shift_left_once,A0
            move.l  A0,D1
.L4:
            move.l  D1,($1C,A3)
            move.l  (-4,A6),-(SP)
            move.l  (-8,A6),-(SP)
            move.l  (-$C,A6),-(SP)
            movea.l (-$C,A6),A0
            movea.l ($6C,A0),A0
            jsr     (A0)
            movem.l (-$18,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    8
SONIC_BitMarch:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            moveq   #1,D6
            movea.l (A4),A0
            movea.l ($A0,A0),A0
            moveq   #0,D0
            move.w  (A0),D0
            move.l  D0,(A3)
            moveq   #0,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  #$94,(A0)
            movea.l (A4),A0
            movea.l (A0),A0
            cmpi.w  #$94,(A0)
            beq.b   .L1
            moveq   #3,D6
            bra.w   .L41
.L1:
            moveq   #3,D0
            cmp.l   (A3),D0
            bge.b   .L3
            movea.l (A4),A0
            movea.l ($FC,A0),A0
            clr.w   (A0)
            tst.l   (4,A4)
            beq.b   .L2
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$832C,(A0)
            bra.b   .L5
.L2:
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$830C,(A0)
            bra.b   .L5
.L3:
            tst.l   (4,A4)
            beq.b   .L4
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$32C,(A0)
            bra.b   .L5
.L4:
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$30C,(A0)
.L5:
            movea.l (A4),A0
            movea.l ($10,A0),A0
            clr.w   (A0)
            movea.l (A4),A0
            movea.l ($10,A0),A0
            move.w  (A0),($26,A3)
            beq.b   .L6
            moveq   #4,D0
            move.l  D0,(4,A3)
            moveq   #2,D6
            bra.w   .L41
.L6:
            moveq   #2,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            move.l  (8,A0),(8,A3)
            move.w  #$FE00,($C,A3)
            clr.w   ($E,A3)
            move.w  #$FE00,($10,A3)
            move.w  #1,($12,A3)
            movea.l (A4),A0
            movea.l (8,A0),A0
            move.w  (A0),($14,A3)
            moveq   #0,D1
            move.l  D1,($18,A3)
            move.l  D1,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  (8,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($6C,A0),A0
            jsr     (A0)
            tst.w   D0
            lea     ($C,SP),SP
            beq.b   .L7
            moveq   #4,D6
            bra.w   .L41
.L7:
            moveq   #3,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            move.l  ($C,A0),(8,A3)
            move.w  #$F000,($C,A3)
            clr.w   ($E,A3)
            move.w  #$F000,($10,A3)
            move.w  #1,($12,A3)
            movea.l (A4),A0
            movea.l ($C,A0),A0
            move.w  (A0),($14,A3)
            moveq   #0,D1
            move.l  D1,($18,A3)
            move.l  D1,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  (8,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($6C,A0),A0
            jsr     (A0)
            tst.w   D0
            lea     ($C,SP),SP
            beq.b   .L8
            moveq   #4,D6
            bra.w   .L41
.L8:
            moveq   #5,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            move.l  ($14,A0),(8,A3)
            clr.w   ($C,A3)
            move.w  #$7FFF,($E,A3)
            move.w  #$7FFF,($10,A3)
            move.w  #1,($12,A3)
            clr.w   ($14,A3)
            moveq   #0,D1
            move.l  D1,($18,A3)
            move.l  D1,($1C,A3)
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  #$7FFF,(A0)
            movea.l (A4),A0
            movea.l ($14,A0),A0
            tst.w   (A0)
            beq.b   .L9
            moveq   #4,D6
            bra.w   .L41
.L9:
            moveq   #6,D7
.L10:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L11
            moveq   #4,D6
            bra.w   .L41
.L11:
            addq.l  #1,D7
            moveq   #8,D0
            cmp.l   D7,D0
            bgt.b   .L10
            moveq   #8,D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_data_inverted_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L12
            moveq   #4,D6
            bra.w   .L41
.L12:
            moveq   #9,D7
.L13:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L14
            moveq   #4,D6
            bra.w   .L41
.L14:
            addq.l  #1,D7
            moveq   #$C,D0
            cmp.l   D7,D0
            bgt.b   .L13
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  (A0),D5
            tst.l   (4,A4)
            beq.b   .L15
            moveq   #$20,D0
            or.w    D5,D0
            moveq   #0,D1
            move.w  D0,D1
            bra.b   .L16
.L15:
            moveq   #0,D0
            move.w  D5,D0
            move.l  #$FFDF,D1
            and.l   D0,D1
.L16:
            move.w  D1,D5
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  D5,(A0)
            moveq   #$C,D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_data_shifted_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L17
            moveq   #4,D6
            bra.w   .L41
.L17:
            moveq   #$D,D7
.L18:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L19
            moveq   #4,D6
            bra.w   .L41
.L19:
            addq.l  #1,D7
            moveq   #$13,D0
            cmp.l   D7,D0
            bgt.b   .L18
            moveq   #$13,D7
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_bit0_equals_0_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L20
            moveq   #4,D6
            bra.w   .L41
.L20:
            moveq   #$14,D7
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L21
            moveq   #4,D6
            bra.w   .L41
.L21:
            moveq   #$15,D7
.L22:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_bit0_equals_0_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L23
            moveq   #4,D6
            bra.w   .L41
.L23:
            addq.l  #1,D7
            moveq   #$19,D0
            cmp.l   D7,D0
            bgt.b   .L22
            moveq   #$19,D7
.L24:
            moveq   #$1B,D0
            cmp.l   D7,D0
            seq     D0
            andi.w  #1,D0
            ext.l   D0
            beq.b   .L25
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_bit0_equals_0_register
            moveq   #0,D1
            move.w  D0,D1
            lea     ($10,SP),SP
            bra.b   .L26
.L25:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            moveq   #0,D1
            move.w  D0,D1
            lea     ($10,SP),SP
.L26:
            beq.b   .L27
            moveq   #4,D6
            bra.w   .L41
.L27:
            addq.l  #1,D7
            moveq   #$1D,D0
            cmp.l   D7,D0
            bgt.b   .L24
            moveq   #$1D,D7
            bra.b   .L30
.L28:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_bit0_equals_0_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L29
            moveq   #4,D6
            bra.w   .L41
.L29:
            addq.l  #1,D7
.L30:
            moveq   #$15,D0
            cmp.l   D7,D0
            bgt.b   .L28
            moveq   #$1F,D7
.L31:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L32
            moveq   #4,D6
            bra.w   .L41
.L32:
            addq.l  #1,D7
            moveq   #$21,D0
            cmp.l   D7,D0
            bgt.b   .L31
            moveq   #$21,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            move.l  ($84,A0),(8,A3)
            move.w  #$F,($C,A3)
            clr.w   ($E,A3)
            move.w  #$F,($10,A3)
            move.w  #1,($12,A3)
            movea.l (A4),A0
            movea.l ($84,A0),A0
            move.w  (A0),($14,A3)
            moveq   #0,D1
            move.l  D1,($18,A3)
            move.l  D1,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  (8,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($6C,A0),A0
            jsr     (A0)
            tst.w   D0
            lea     ($C,SP),SP
            beq.b   .L33
            moveq   #4,D6
            bra.w   .L41
.L33:
            moveq   #$25,D7
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L34
            moveq   #4,D6
            bra.w   .L41
.L34:
            moveq   #$26,D7
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_bit0_equals_0_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L35
            moveq   #4,D6
            bra.w   .L41
.L35:
            moveq   #$27,D0
            move.l  D0,(4,A3)
            movea.l (A4),A0
            move.l  ($98,A0),(8,A3)
            move.w  #$1F,($C,A3)
            clr.w   ($E,A3)
            move.w  #$1F,($10,A3)
            move.w  #1,($12,A3)
            movea.l (A4),A0
            movea.l ($9C,A0),A0
            move.w  (A0),($14,A3)
            moveq   #0,D1
            move.l  D1,($18,A3)
            move.l  D1,($1C,A3)
            pea     ($20,A3)
            pea     (8,A3)
            move.l  (8,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($6C,A0),A0
            jsr     (A0)
            tst.w   D0
            lea     ($C,SP),SP
            beq.b   .L36
            moveq   #4,D6
            bra.b   .L41
.L36:
            moveq   #$29,D7
.L37:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_a_No_By_Law_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L38
            moveq   #4,D6
            bra.b   .L41
.L38:
            addq.l  #1,D7
            moveq   #$2C,D0
            cmp.l   D7,D0
            bgt.b   .L37
            moveq   #$2C,D7
.L39:
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     BitWalk_data_inverted_register
            tst.w   D0
            lea     ($10,SP),SP
            beq.b   .L40
            moveq   #4,D6
            bra.b   .L41
.L40:
            addq.l  #1,D7
            moveq   #$2F,D0
            cmp.l   D7,D0
            bgt.b   .L39
            clr.b   D6
.L41:
            moveq   #0,D0
            move.b  D6,D0
            movem.l (-$14,A6),D5-D7/A3-A4
            unlk    A6
            rts
            ds.b    4
SONIC_CAMDMA:
            link.w  A6,#-4
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            moveq   #1,D6
            movea.l (A4),A0
            movea.l ($A0,A0),A0
            moveq   #0,D0
            move.w  (A0),D0
            move.l  D0,(A3)
            movea.l (A4),A0
            movea.l ($10,A0),A0
            clr.w   (A0)
            movea.l (A4),A0
            movea.l ($10,A0),A0
            tst.w   (A0)
            beq.b   .L1
            moveq   #2,D6
            bra.w   .L15
.L1:
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  #$94,(A0)
            movea.l (A4),A0
            movea.l (A0),A0
            cmpi.w  #$94,(A0)
            beq.b   .L2
            moveq   #3,D6
            bra.w   .L15
.L2:
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  #$7FFF,(A0)
            movea.l (A4),A0
            movea.l ($14,A0),A0
            moveq   #0,D0
            move.w  (A0),D0
            move.l  #$DFFF,D1
            and.l   D0,D1
            beq.b   .L3
            moveq   #4,D6
            bra.w   .L15
.L3:
            moveq   #3,D0
            cmp.l   (A3),D0
            bge.b   .L5
            movea.l (A4),A0
            movea.l ($FC,A0),A0
            clr.w   (A0)
            tst.l   (4,A4)
            beq.b   .L4
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$832C,(A0)
            bra.b   .L7
.L4:
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$830C,(A0)
            bra.b   .L7
.L5:
            tst.l   (4,A4)
            beq.b   .L6
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$32C,(A0)
            bra.b   .L7
.L6:
            movea.l (A4),A0
            movea.l (4,A0),A0
            move.w  #$30C,(A0)
.L7:
            movea.l ($C,A4),A0
            movea.l (A4),A1
            movea.l ($9C,A1),A1
            move.w  (2,A0),(A1)
            movea.l ($C,A4),A0
            move.w  (2,A0),($12,A3)
            movea.l ($10,A4),A0
            addq.l  #4,A0
            move.l  A0,(-4,A6)
            move.l  (-4,A6),D5
            move.l  #$FFFF0000,D0
            and.l   D5,D0
            moveq   #$10,D1
            lsr.l   D1,D0
            movea.l (A4),A0
            movea.l ($50,A0),A0
            move.w  D0,(A0)
            movea.l (A4),A0
            movea.l ($50,A0),A0
            move.w  (A0),($14,A3)
            movea.l ($10,A4),A0
            addq.l  #4,A0
            move.l  A0,(-4,A6)
            move.l  (-4,A6),D5
            move.l  #$FFFF,D0
            and.l   D5,D0
            movea.l (A4),A0
            movea.l ($98,A0),A0
            move.w  D0,(A0)
            movea.l (A4),A0
            movea.l ($98,A0),A0
            move.w  (A0),($16,A3)
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  (A0),D4
            moveq   #0,D0
            move.w  D4,D0
            move.l  #$FF7F,D1
            and.l   D0,D1
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  D1,(A0)
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  (A0),D4
            move.w  #$200,D0
            or.w    D4,D0
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  D0,(A0)
            move.l  ($18,A4),-(SP)
            pea     ($1000).w
            movea.l (A4),A0
            move.l  ($14,A0),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($14,A4),A0
            jsr     (A0)
            move.b  D0,D6
            lea     ($10,SP),SP
            beq.b   .L8
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  (A0),($10,A3)
            moveq   #5,D6
            bra.w   .L15
.L8:
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  (A0),($10,A3)
            movea.l (A4),A0
            movea.l (A0),A0
            move.w  #$94,(A0)
            movea.l (A4),A0
            movea.l (A0),A0
            cmpi.w  #$94,(A0)
            beq.b   .L9
            moveq   #3,D6
            bra.w   .L15
.L9:
            moveq   #0,D7
            bra.w   .L14
.L10:
            movea.l ($C,A4),A0
            move.l  D7,D0
            asl.l   #2,D0
            asl.l   #2,D0
            movea.l (A4),A1
            movea.l ($84,A1),A1
            move.w  (6,A0,D0.l),(A1)
            movea.l ($C,A4),A0
            move.l  D7,D0
            asl.l   #2,D0
            asl.l   #2,D0
            move.l  (4,A0,D0.l),(8,A3)
            moveq   #0,D0
            move.l  D0,(4,A3)
            movea.l ($C,A4),A0
            move.l  D7,D1
            asl.l   #2,D1
            asl.l   #2,D1
            move.w  ($A,A0,D1.l),($C,A3)
            movea.l (A4),A0
            movea.l ($90,A0),A0
            move.w  (A0),($E,A3)
            move.w  ($C,A3),D1
            cmp.w   ($E,A3),D1
            beq.b   .L11
            moveq   #6,D6
            bra.b   .L15
.L11:
            moveq   #1,D0
            move.l  D0,(4,A3)
            movea.l ($C,A4),A0
            move.l  D7,D1
            asl.l   #2,D1
            asl.l   #2,D1
            move.w  ($E,A0,D1.l),($C,A3)
            movea.l (A4),A0
            movea.l ($8C,A0),A0
            move.w  (A0),($E,A3)
            move.w  ($C,A3),D1
            cmp.w   ($E,A3),D1
            beq.b   .L12
            moveq   #6,D6
            bra.b   .L15
.L12:
            moveq   #2,D0
            move.l  D0,(4,A3)
            movea.l ($C,A4),A0
            move.l  D7,D1
            asl.l   #2,D1
            asl.l   #2,D1
            move.w  ($12,A0,D1.l),($C,A3)
            movea.l (A4),A0
            movea.l ($88,A0),A0
            move.w  (A0),($E,A3)
            move.w  ($C,A3),D1
            cmp.w   ($E,A3),D1
            beq.b   .L13
            moveq   #6,D6
            bra.b   .L15
.L13:
            addq.l  #1,D7
.L14:
            movea.l ($C,A4),A0
            cmp.l   (A0),D7
            blt.w   .L10
            clr.b   D6
.L15:
            moveq   #0,D0
            move.b  D6,D0
            movem.l (-$1C,A6),D4-D7/A3-A4
            unlk    A6
            rts
            ds.b    14
SONIC_Loopback:
            link.w  A6,#-$2E
            movem.l D3-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #1,D5
            tst.l   (8,A3)
            bne.b   .L1
            moveq   #2,D0
            move.l  D0,(8,A3)
            moveq   #$10,D1
            move.l  D1,($C,A3)
.L1:
            movea.l (A3),A0
            movea.l ($A0,A0),A0
            moveq   #0,D0
            move.w  (A0),D0
            move.l  D0,(A4)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  #$94,(A0)
            movea.l (A3),A0
            movea.l (A0),A0
            cmpi.w  #$94,(A0)
            beq.b   .L2
            moveq   #3,D5
            bra.w   .L52
.L2:
            moveq   #3,D0
            cmp.l   (A4),D0
            bge.b   .L4
            movea.l (A3),A0
            movea.l ($FC,A0),A0
            clr.w   (A0)
            tst.l   (4,A3)
            beq.b   .L3
            movea.l (A3),A0
            movea.l (4,A0),A0
            move.w  #$832C,(A0)
            bra.b   .L6
.L3:
            movea.l (A3),A0
            movea.l (4,A0),A0
            move.w  #$830C,(A0)
            bra.b   .L6
.L4:
            tst.l   (4,A3)
            beq.b   .L5
            movea.l (A3),A0
            movea.l (4,A0),A0
            move.w  #$32C,(A0)
            bra.b   .L6
.L5:
            movea.l (A3),A0
            movea.l (4,A0),A0
            move.w  #$30C,(A0)
.L6:
            movea.l (A3),A0
            movea.l ($10,A0),A0
            clr.w   (A0)
            movea.l (A3),A0
            movea.l ($10,A0),A0
            tst.w   (A0)
            beq.b   .L7
            moveq   #2,D5
            bra.w   .L52
.L7:
            movea.l (A3),A0
            movea.l ($14,A0),A0
            move.w  #$7FFF,(A0)
            movea.l (A3),A0
            movea.l ($14,A0),A0
            tst.w   (A0)
            beq.b   .L8
            moveq   #4,D5
            bra.w   .L52
.L8:
            tst.l   ($C,A3)
            beq.b   .L9
            move.l  A3,(-$C,A6)
            move.l  A4,(-8,A6)
            moveq   #7,D0
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            move.l  D0,(-4,A6)
            pea     (-$C,A6)
            pea     (-$28,A6)
            move.l  (8,A6),-(SP)
            movea.l ($24,A3),A0
            jsr     (A0)
            moveq   #2,D0
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            movea.l (A3),A0
            movea.l ($10,A0),A0
            move.w  #$7FFF,(A0)
            movea.l (A3),A0
            movea.l ($C,A0),A0
            andi.w  #$7FFF,(A0)
            movea.l (A3),A0
            movea.l ($C,A0),A0
            ori.w   #$8000,(A0)
            lea     ($14,SP),SP
.L9:
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  (A0),D4
            moveq   #0,D0
            move.w  D4,D0
            move.l  #$FF7F,D1
            and.l   D0,D1
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  D1,(A0)
            movea.l (A3),A0
            movea.l ($4C,A0),A0
            move.w  #$2F8,(A0)
            move.l  ($30,A3),D6
            move.l  #$FFFF0000,D0
            and.l   D6,D0
            moveq   #$10,D1
            lsr.l   D1,D0
            movea.l (A3),A0
            movea.l ($34,A0),A0
            move.w  D0,(A0)
            movea.l (A3),A0
            movea.l ($34,A0),A0
            move.w  (A0),($20,A4)
            move.l  ($30,A3),D6
            move.l  #$FFFF,D0
            and.l   D6,D0
            movea.l (A3),A0
            movea.l ($38,A0),A0
            move.w  D0,(A0)
            movea.l (A3),A0
            movea.l ($38,A0),A0
            move.w  (A0),($22,A4)
            move.l  ($38,A3),D6
            move.l  #$FFFE,D0
            and.l   D6,D0
            movea.l ($2C,A3),A0
            move.l  D0,($14,A0)
            movea.l ($2C,A3),A0
            move.l  #$FFFF,($18,A0)
            movea.l ($2C,A3),A0
            moveq   #0,D0
            move.l  D0,(A0)
            movea.l ($2C,A3),A0
            move.l  D0,(4,A0)
            movea.l ($2C,A3),A0
            move.l  D0,(8,A0)
            movea.l ($2C,A3),A0
            move.l  D0,($C,A0)
            movea.l ($2C,A3),A0
            move.l  D0,($10,A0)
            move.l  ($40,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            moveq   #1,D2
            or.l    D1,D2
            movea.l ($34,A3),A0
            move.l  D2,($14,A0)
            movea.l ($34,A3),A0
            move.l  #$FFFF,($18,A0)
            movea.l ($34,A3),A0
            move.l  D0,(A0)
            movea.l ($34,A3),A0
            move.l  D0,(4,A0)
            movea.l ($34,A3),A0
            move.l  D0,(8,A0)
            movea.l ($34,A3),A0
            move.l  D0,($C,A0)
            movea.l ($34,A3),A0
            move.l  D0,($10,A0)
            move.l  ($30,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            moveq   #1,D2
            or.l    D1,D2
            movea.l ($3C,A3),A0
            move.l  D2,($14,A0)
            movea.l ($3C,A3),A0
            move.l  #$FFFF,($18,A0)
            movea.l ($3C,A3),A0
            move.l  D0,(A0)
            movea.l ($3C,A3),A0
            move.l  D0,(4,A0)
            movea.l ($3C,A3),A0
            move.l  D0,(8,A0)
            movea.l ($3C,A3),A0
            move.l  D0,($C,A0)
            movea.l ($3C,A3),A0
            move.l  D0,($10,A0)
            move.l  ($48,A3),D6
            move.l  #$FFFF0000,D1
            and.l   D6,D1
            moveq   #$10,D2
            lsr.l   D2,D1
            movea.l (A3),A0
            movea.l ($50,A0),A0
            move.w  D1,(A0)
            move.l  ($48,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l (A3),A0
            movea.l ($54,A0),A0
            move.w  D1,(A0)
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l (A3),A0
            movea.l ($5C,A0),A0
            move.w  D1,(A0)
            move.l  ($48,A3),D6
            move.l  D6,D1
            moveq   #$50,D2
            add.l   D2,D1
            move.l  #$FFFF,D3
            and.l   D1,D3
            movea.l (A3),A0
            movea.l ($58,A0),A0
            move.w  D3,(A0)
            movea.l ($48,A3),A0
            lea     ($20,A0),A0
            move.l  A0,D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l (A3),A0
            movea.l ($60,A0),A0
            move.w  D1,(A0)
            move.l  ($58,A3),D6
            move.l  #$FFFF0000,D1
            and.l   D6,D1
            moveq   #$10,D3
            lsr.l   D3,D1
            movea.l ($44,A3),A0
            move.l  D1,(4,A0)
            move.l  ($58,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l ($44,A3),A0
            move.l  D1,(A0)
            movea.l ($44,A3),A0
            move.l  #$320,(8,A0)
            movea.l ($44,A3),A0
            move.l  D0,($C,A0)
            move.l  ($60,A3),D6
            move.l  #$FFFF0000,D1
            and.l   D6,D1
            moveq   #$10,D3
            lsr.l   D3,D1
            movea.l ($44,A3),A0
            move.l  D1,($14,A0)
            move.l  ($60,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l ($44,A3),A0
            move.l  D1,($10,A0)
            movea.l ($44,A3),A0
            move.l  #$320,($18,A0)
            movea.l ($44,A3),A0
            move.l  D0,($1C,A0)
            move.l  ($68,A3),D6
            move.l  #$FFFF0000,D1
            and.l   D6,D1
            moveq   #$10,D3
            lsr.l   D3,D1
            movea.l ($44,A3),A0
            move.l  D1,($24,A0)
            move.l  ($68,A3),D6
            move.l  #$FFFF,D1
            and.l   D6,D1
            movea.l ($44,A3),A0
            move.l  D1,($20,A0)
            movea.l ($44,A3),A0
            move.l  #$320,($28,A0)
            movea.l ($44,A3),A0
            move.l  D0,($2C,A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  (A0),D4
            moveq   #0,D1
            move.w  D4,D1
            move.l  #$FF7F,D3
            and.l   D1,D3
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  D3,(A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  (A0),D4
            move.w  #$100,D1
            or.w    D4,D1
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  D1,(A0)
            movea.l (A3),A0
            movea.l ($3C,A0),A0
            move.w  (A0),($26,A4)
            movea.l (A3),A0
            movea.l ($40,A0),A0
            move.w  (A0),($24,A4)
            movea.l (A3),A0
            movea.l ($44,A0),A0
            move.w  (A0),($2A,A4)
            movea.l (A3),A0
            movea.l ($48,A0),A0
            move.w  (A0),($28,A4)
            moveq   #0,D7
.L10:
            movea.l ($54,A3),A0
            move.b  #$AA,(0,A0,D7.l)
            movea.l ($5C,A3),A0
            move.b  #$CC,(0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$640,D7
            blt.b   .L10
            move.l  ($50,A3),D6
            move.l  #$FFFF0000,D0
            and.l   D6,D0
            moveq   #$10,D1
            lsr.l   D1,D0
            movea.l (A3),A0
            movea.l ($18,A0),A0
            move.w  D0,(A0)
            move.l  ($50,A3),D6
            move.l  #$FFFF,D0
            and.l   D6,D0
            movea.l (A3),A0
            movea.l ($1C,A0),A0
            move.w  D0,(A0)
            movea.l ($4C,A3),A0
            moveq   #0,D0
            move.l  D0,(A0)
            movea.l ($4C,A3),A0
            move.l  D0,(4,A0)
            movea.l ($4C,A3),A0
            move.l  #$5DC,(8,A0)
            movea.l ($4C,A3),A0
            moveq   #1,D1
            move.l  D1,($C,A0)
            move.l  ($70,A3),D6
            move.l  #$FFFF,D2
            and.l   D6,D2
            movea.l ($4C,A3),A0
            move.l  D2,($10,A0)
            move.l  ($70,A3),D6
            move.l  #$FFFF0000,D2
            and.l   D6,D2
            moveq   #$10,D3
            lsr.l   D3,D2
            movea.l ($4C,A3),A0
            move.l  D2,($14,A0)
            movea.l ($4C,A3),A0
            move.l  #$5DC,($18,A0)
            movea.l ($50,A3),A0
            lea     ($20,A0),A0
            move.l  A0,D6
            moveq   #1,D2
            cmp.l   (8,A3),D2
            bne.b   .L11
            or.l    #1,D6
            bra.b   .L12
.L11:
            and.l   #$FFFE,D6
.L12:
            move.l  #$FFFF,D0
            and.l   D6,D0
            moveq   #0,D1
            move.w  D0,D1
            movea.l ($4C,A3),A0
            move.l  D1,($1C,A0)
            movea.l ($4C,A3),A0
            moveq   #0,D0
            move.l  D0,($20,A0)
            movea.l ($4C,A3),A0
            move.l  D0,($24,A0)
            movea.l ($4C,A3),A0
            move.l  #$5DC,($28,A0)
            movea.l ($4C,A3),A0
            moveq   #2,D1
            move.l  D1,($2C,A0)
            move.l  ($78,A3),D6
            move.l  #$FFFF,D2
            and.l   D6,D2
            movea.l ($4C,A3),A0
            move.l  D2,($30,A0)
            move.l  ($78,A3),D6
            move.l  #$FFFF0000,D2
            and.l   D6,D2
            moveq   #$10,D3
            lsr.l   D3,D2
            movea.l ($4C,A3),A0
            move.l  D2,($34,A0)
            movea.l ($4C,A3),A0
            move.l  #$2EE,($38,A0)
            movea.l ($78,A3),A0
            lea     ($320,A0),A0
            move.l  A0,D6
            move.l  #$FFFF,D2
            and.l   D6,D2
            movea.l ($4C,A3),A0
            move.l  D2,($3C,A0)
            movea.l ($78,A3),A0
            lea     ($320,A0),A0
            move.l  A0,D6
            move.l  #$FFFF0000,D2
            and.l   D6,D2
            moveq   #$10,D3
            lsr.l   D3,D2
            movea.l ($4C,A3),A0
            move.l  D2,($40,A0)
            movea.l ($4C,A3),A0
            move.l  #$2EE,($44,A0)
            movea.l ($50,A3),A0
            move.l  A0,D6
            move.l  #$FFFF,D2
            and.l   D6,D2
            moveq   #1,D3
            or.l    D2,D3
            movea.l ($4C,A3),A0
            move.l  D3,($48,A0)
            moveq   #0,D7
.L13:
            movea.l ($6C,A3),A0
            move.b  #$55,(0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$5DC,D7
            blt.b   .L13
            move.l  #$5DC,D7
.L14:
            movea.l ($6C,A3),A0
            clr.b   (0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$640,D7
            blt.b   .L14
            moveq   #0,D7
.L15:
            movea.l ($74,A3),A0
            move.b  #$99,(0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$2EE,D7
            blt.b   .L15
            move.l  #$2EE,D7
.L16:
            movea.l ($74,A3),A0
            clr.b   (0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$320,D7
            blt.b   .L16
            move.l  #$320,D7
.L17:
            movea.l ($74,A3),A0
            move.b  #$33,(0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$60E,D7
            blt.b   .L17
            move.l  #$60E,D7
.L18:
            movea.l ($74,A3),A0
            clr.b   (0,A0,D7.l)
            addq.l  #1,D7
            cmpi.l  #$640,D7
            blt.b   .L18
            movea.l ($14,A3),A0
            movea.l (A3),A1
            movea.l ($9C,A1),A1
            move.w  (2,A0),(A1)
            movea.l ($18,A3),A0
            addq.l  #4,A0
            move.l  A0,D6
            move.l  #$FFFF0000,D0
            and.l   D6,D0
            moveq   #$10,D1
            lsr.l   D1,D0
            movea.l (A3),A0
            movea.l ($50,A0),A0
            move.w  D0,(A0)
            movea.l ($18,A3),A0
            addq.l  #4,A0
            move.l  A0,D6
            move.l  #$FFFF,D0
            and.l   D6,D0
            movea.l (A3),A0
            movea.l ($98,A0),A0
            move.w  D0,(A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  (A0),D4
            moveq   #0,D0
            move.w  D4,D0
            move.l  #$FF7F,D1
            and.l   D0,D1
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  D1,(A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  (A0),D4
            move.w  #$200,D0
            or.w    D4,D0
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  D0,(A0)
            tst.l   ($C,A3)
            beq.b   .L19
            lea     ($10,A4),A0
            move.l  A0,(-$2C,A6)
            move.l  A0,D0
            bra.b   .L20
.L19:
            movea.l (A3),A0
            move.l  ($14,A0),(-$2C,A6)
            move.l  ($14,A0),D0
.L20:
            move.l  ($20,A3),-(SP)
            pea     ($1000).w
            move.l  (-$2C,A6),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($1C,A3),A0
            jsr     (A0)
            move.b  D0,D5
            lea     ($10,SP),SP
            beq.b   .L21
            moveq   #5,D5
            movea.l (A3),A0
            movea.l ($14,A0),A0
            move.w  (A0),($C,A4)
            bra.w   .L52
.L21:
            movea.l (A3),A0
            movea.l ($14,A0),A0
            move.w  (A0),($C,A4)
            tst.l   ($12,A4)
            beq.b   .L22
            moveq   #$10,D5
            bra.w   .L52
.L22:
            move.l  (8,A3),D0
            subq.l  #1,D0
            bmi.b   .L28
            cmpi.l  #2,D0
            bgt.b   .L28
            add.l   D0,D0
            move.w  .L24(PC,D0.l),D0
.L23:
            jmp     .L23+2(PC,D0.w)
.L24:
            dc.w    .L25-(.L23+2)
            dc.w    .L26-(.L23+2)
            dc.w    .L27-(.L23+2)
.L25:
            movea.l (A3),A0
            movea.l (8,A0),A0
            move.w  #$FA00,(A0)
            bra.b   .L29
.L26:
            movea.l (A3),A0
            movea.l (8,A0),A0
            move.w  #$FC00,(A0)
            bra.b   .L29
.L27:
            movea.l (A3),A0
            movea.l (8,A0),A0
            move.w  #$FE00,(A0)
            bra.b   .L29
.L28:
            moveq   #6,D5
            bra.w   .L52
.L29:
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  #8,(A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  #$A,(A0)
            movea.l (A3),A0
            movea.l ($3C,A0),A0
            move.w  (A0),($26,A4)
            movea.l (A3),A0
            movea.l ($40,A0),A0
            move.w  (A0),($24,A4)
            movea.l (A3),A0
            movea.l ($44,A0),A0
            move.w  (A0),($2A,A4)
            movea.l (A3),A0
            movea.l ($48,A0),A0
            move.w  (A0),($28,A4)
            move.w  #1,(6,A4)
            movea.l ($2C,A3),A0
            move.l  A0,(-$2C,A6)
            move.l  ($20,A3),-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            move.l  (-$2C,A6),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($1C,A3),A0
            jsr     (A0)
            move.b  D0,D5
            lea     ($10,SP),SP
            beq.b   .L30
            moveq   #7,D5
            movea.l ($2C,A3),A0
            move.w  (2,A0),($1A,A4)
            movea.l ($4C,A3),A0
            move.w  (2,A0),($16,A4)
            bra.w   .L52
.L30:
            movea.l ($2C,A3),A0
            move.w  (2,A0),($1A,A4)
            movea.l ($4C,A3),A0
            move.w  (2,A0),($16,A4)
            move.w  #$44E,D0
            and.w   ($16,A4),D0
            beq.b   .L31
            moveq   #8,D5
            bra.w   .L52
.L31:
            moveq   #$C,D0
            and.w   ($1A,A4),D0
            beq.b   .L32
            moveq   #9,D5
            bra.w   .L52
.L32:
            moveq   #0,D7
.L33:
            movea.l ($6C,A3),A0
            move.b  (0,A0,D7.l),(4,A4)
            movea.l ($54,A3),A0
            move.b  (0,A0,D7.l),(5,A4)
            move.l  D7,(8,A4)
            move.b  (5,A4),D0
            cmp.b   (4,A4),D0
            bne.b   .L34
            tst.b   (5,A4)
            beq.b   .L34
            tst.b   (4,A4)
            bne.b   .L35
.L34:
            moveq   #$A,D5
            bra.w   .L52
.L35:
            addq.l  #1,D7
            cmpi.l  #$5DC,D7
            blt.b   .L33
            moveq   #1,D0
            cmp.l   (8,A3),D0
            beq.w   .L45
            movea.l (A3),A0
            movea.l ($3C,A0),A0
            move.w  (A0),($26,A4)
            movea.l (A3),A0
            movea.l ($40,A0),A0
            move.w  (A0),($24,A4)
            movea.l (A3),A0
            movea.l ($44,A0),A0
            move.w  (A0),($2A,A4)
            movea.l (A3),A0
            movea.l ($48,A0),A0
            move.w  (A0),($28,A4)
            move.w  #2,(6,A4)
            moveq   #0,D0
            move.l  D0,(8,A4)
            clr.b   (4,A4)
            clr.b   (5,A4)
            movea.l ($34,A3),A0
            move.l  A0,(-$2C,A6)
            move.l  ($20,A3),-(SP)
            moveq   #2,D1
            move.l  D1,-(SP)
            move.l  (-$2C,A6),-(SP)
            move.l  (8,A6),-(SP)
            movea.l ($1C,A3),A0
            jsr     (A0)
            move.b  D0,D5
            lea     ($10,SP),SP
            beq.b   .L36
            moveq   #$B,D5
            movea.l ($34,A3),A0
            move.w  (2,A0),($1C,A4)
            movea.l ($4C,A3),A0
            move.w  ($22,A0),($18,A4)
            bra.w   .L52
.L36:
            movea.l ($34,A3),A0
            move.w  (2,A0),($1C,A4)
            movea.l ($4C,A3),A0
            move.w  ($22,A0),($18,A4)
            move.w  #$44E,D0
            and.w   ($18,A4),D0
            beq.b   .L37
            moveq   #$C,D5
            bra.w   .L52
.L37:
            moveq   #$C,D0
            and.w   ($1C,A4),D0
            beq.b   .L38
            moveq   #$D,D5
            bra.w   .L52
.L38:
            moveq   #0,D7
.L39:
            movea.l ($74,A3),A0
            move.b  (0,A0,D7.l),(4,A4)
            movea.l ($5C,A3),A0
            move.b  (0,A0,D7.l),(5,A4)
            move.l  D7,(8,A4)
            move.b  (5,A4),D0
            cmp.b   (4,A4),D0
            bne.b   .L40
            tst.b   (5,A4)
            beq.b   .L40
            tst.b   (4,A4)
            bne.b   .L41
.L40:
            moveq   #$E,D5
            bra.w   .L52
.L41:
            addq.l  #1,D7
            cmpi.l  #$2EE,D7
            blt.b   .L39
            move.l  #$2EE,D7
.L42:
            movea.l ($74,A3),A0
            move.b  ($32,A0,D7.l),(4,A4)
            movea.l ($5C,A3),A0
            move.b  (0,A0,D7.l),(5,A4)
            move.l  D7,(8,A4)
            move.b  (5,A4),D0
            cmp.b   (4,A4),D0
            bne.b   .L43
            tst.b   (5,A4)
            beq.b   .L43
            tst.b   (4,A4)
            bne.b   .L44
.L43:
            moveq   #$F,D5
            bra.w   .L52
.L44:
            addq.l  #1,D7
            cmpi.l  #$5DC,D7
            blt.b   .L42
            moveq   #1,D0
            cmp.l   (8,A3),D0
            sne     D0
            andi.w  #1,D0
            ext.l   D0
            and.l   ($C,A3),D0
            beq.b   .L45
            movea.l ($4C,A3),A0
            moveq   #0,D0
            move.l  D0,(A0)
            movea.l ($4C,A3),A0
            ori.l   #1,($1C,A0)
            movea.l ($4C,A3),A0
            andi.l  #$FFFE,($48,A0)
            movea.l (A3),A0
            movea.l (A0),A0
            move.w  #$A,(A0)
            movea.l (A3),A0
            movea.l ($3C,A0),A0
            move.w  (A0),($26,A4)
            movea.l (A3),A0
            movea.l ($40,A0),A0
            move.w  (A0),($24,A4)
            movea.l (A3),A0
            movea.l ($44,A0),A0
            move.w  (A0),($2A,A4)
            movea.l (A3),A0
            movea.l ($48,A0),A0
            move.w  (A0),($28,A4)
.L45:
            clr.b   D5
            tst.l   ($C,A3)
            beq.w   .L52
            moveq   #7,D0
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            movea.l (A3),A0
            movea.l ($10,A0),A0
            clr.w   (A0)
            pea     (-$C,A6)
            pea     (-$28,A6)
            move.l  (8,A6),-(SP)
            movea.l ($28,A3),A0
            jsr     (A0)
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            tst.l   ($12,A4)
            lea     ($14,SP),SP
            beq.b   .L46
            moveq   #$10,D5
            bra.b   .L52
.L46:
            move.l  (8,A3),D0
            subq.l  #1,D0
            bmi.b   .L51
            cmpi.l  #2,D0
            bgt.b   .L51
            add.l   D0,D0
            move.w  .L48(PC,D0.l),D0
.L47:
            jmp     .L47+2(PC,D0.w)
.L48:
            dc.w    .L49-(.L47+2)
            dc.w    .L50-(.L47+2)
            dc.w    .L50-(.L47+2)
.L49:
            move.w  ($10,A4),D4
            andi.w  #$1E00,D4
            tst.w   D4
            bne.b   .L52
            moveq   #$11,D5
            bra.b   .L52
.L50:
            move.w  ($10,A4),D4
            andi.w  #$1E60,D4
            tst.w   D4
            bne.b   .L52
            moveq   #$11,D5
            bra.b   .L52
.L51:
            moveq   #6,D5
.L52:
            moveq   #0,D0
            move.w  ($16,A4),D0
            move.l  #$F800,D1
            and.l   D0,D1
            move.w  D1,(-$2E,A6)
            moveq   #0,D0
            move.w  (-$2E,A6),D0
            moveq   #$B,D1
            lsr.l   D1,D0
            move.w  D0,($1E,A4)
            moveq   #0,D0
            move.w  ($18,A4),D0
            move.l  #$F800,D1
            and.l   D0,D1
            move.w  D1,(-$2E,A6)
            moveq   #0,D0
            move.w  (-$2E,A6),D0
            moveq   #$B,D1
            lsr.l   D1,D0
            add.w   D0,($1E,A4)
            tst.b   D5
            beq.b   .L53
            tst.l   ($C,A3)
            beq.b   .L53
            moveq   #7,D0
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            movea.l (A3),A0
            movea.l ($10,A0),A0
            clr.w   (A0)
            pea     (-$C,A6)
            pea     (-$28,A6)
            move.l  (8,A6),-(SP)
            movea.l ($28,A3),A0
            jsr     (A0)
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A0
            movea.l ($80,A0),A0
            jsr     (A0)
            lea     ($14,SP),SP
.L53:
            moveq   #0,D0
            move.b  D5,D0
            movem.l (-$4A,A6),D3-D7/A3-A4
            unlk    A6
            rts
            ds.b    10
SONIC_InterruptHandler:
            link.w  A6,#-4
            movem.l D4-D7/A3-A4,-(SP)
            move.l  ($14,A6),(-4,A6)
            movea.l (-4,A6),A0
            movea.l (A0),A4
            movea.l (-4,A6),A0
            movea.l (4,A0),A3
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  (A0),D6
            moveq   #1,D0
            move.l  D0,($12,A3)
            moveq   #0,D7
.L1:
            moveq   #1,D5
            move.w  D5,D0
            lsl.w   D7,D0
            and.w   D6,D0
            move.w  D0,($E,A3)
            beq.w   .L18
            subq.w  #1,D0
            beq.b   .L2
            subq.w  #1,D0
            beq.b   .L3
            subq.w  #2,D0
            beq.b   .L4
            subq.w  #4,D0
            beq.w   .L5
            subq.w  #8,D0
            beq.w   .L6
            subi.w  #$10,D0
            beq.w   .L7
            subi.w  #$20,D0
            beq.w   .L8
            subi.w  #$40,D0
            beq.w   .L9
            subi.w  #$80,D0
            beq.w   .L10
            subi.w  #$100,D0
            beq.w   .L11
            subi.w  #$200,D0
            beq.w   .L12
            subi.w  #$400,D0
            beq.w   .L13
            subi.w  #$800,D0
            beq.w   .L14
            subi.w  #$1000,D0
            beq.w   .L15
            subi.w  #$2000,D0
            beq.w   .L16
            bra.w   .L17
.L2:
            ori.w   #1,($10,A3)
            moveq   #3,D0
            move.l  D0,($12,A3)
            bra.w   .L19
.L3:
            ori.w   #2,($10,A3)
            bra.w   .L18
.L4:
            ori.w   #4,($10,A3)
            moveq   #6,D0
            move.l  D0,($12,A3)
            bra.w   .L19
.L5:
            ori.w   #8,($10,A3)
            bra.w   .L18
.L6:
            ori.w   #$10,($10,A3)
            bra.w   .L18
.L7:
            movea.l ($48,A4),A0
            lea     ($30,A0),A0
            move.l  A0,D4
            move.l  #$FFFF,D0
            and.l   D4,D0
            movea.l (A4),A0
            movea.l ($60,A0),A0
            move.w  D0,(A0)
            movea.l (A4),A0
            movea.l ($10,A0),A0
            andi.w  #$7FDF,(A0)
            ori.w   #$20,($10,A3)
            bra.b   .L18
.L8:
            movea.l ($34,A4),A0
            andi.l  #$FFFE,($14,A0)
            movea.l (A4),A0
            movea.l ($10,A0),A0
            andi.w  #$7FBF,(A0)
            ori.w   #$40,($10,A3)
            bra.b   .L18
.L9:
            ori.w   #$80,($10,A3)
            bra.b   .L18
.L10:
            ori.w   #$100,($10,A3)
            moveq   #4,D0
            move.l  D0,($12,A3)
            bra.b   .L19
.L11:
            ori.w   #$200,($10,A3)
            bra.b   .L18
.L12:
            ori.w   #$400,($10,A3)
            bra.b   .L18
.L13:
            ori.w   #$800,($10,A3)
            bra.b   .L18
.L14:
            ori.w   #$1000,($10,A3)
            bra.b   .L18
.L15:
            ori.w   #$2000,($10,A3)
            bra.b   .L18
.L16:
            ori.w   #$4000,($10,A3)
            moveq   #5,D0
            move.l  D0,($12,A3)
            bra.b   .L19
.L17:
            moveq   #2,D0
            move.l  D0,($12,A3)
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  D6,(A0)
            move.w  D6,($E,A3)
            bra.b   .L19
.L18:
            addq.l  #1,D7
            moveq   #$F,D0
            cmp.l   D7,D0
            bgt.w   .L1
            moveq   #0,D0
            move.l  D0,($12,A3)
.L19:
            movea.l (A4),A0
            movea.l ($14,A0),A0
            move.w  D6,(A0)
            movem.l (-$1C,A6),D4-D7/A3-A4
            unlk    A6
            rts
            ds.b    14
Timeout:
            movem.l D5-D7/A3,-(SP)
            move.l  ($20,SP),D5
            move.w  ($1E,SP),D6
            movea.l ($18,SP),A3
            moveq   #0,D7
            bra.b   .L2
.L1:
            move.w  D6,D0
            and.w   (A3),D0
            bne.b   .L3
            addq.l  #1,D7
.L2:
            cmp.l   D7,D5
            bgt.b   .L1
            moveq   #6,D0
            bra.b   .L4
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,D5-D7/A3
            rts
            ds.b    4
SONIC_Init_CAMDMA_params:
            link.w  A6,#-4
            movem.l D3/D6-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #1,D6
            move.l  (8,A6),(-4,A6)
            pea     MemTop
            move.l  (-4,A6),-(SP)
            movea.l (-4,A6),A0
            movea.l ($90,A0),A0
            jsr     (A0)
            move.l  D0,($C,A3)
            addq.l  #8,SP
            bne.b   .L1
            moveq   #3,D6
            move.b  D6,D0
            bra.b   .L3
.L1:
            move.l  ($C,A3),($10,A3)
            movea.l ($C,A3),A0
            moveq   #$10,D0
            move.l  D0,(A0)
            moveq   #0,D7
            moveq   #$40,D3
.L2:
            move.l  D7,D0
            asl.l   #2,D0
            movea.l ($C,A3),A0
            move.l  D7,D1
            asl.l   #2,D1
            move.l  (0,A4,D0.l),(4,A0,D1.l)
            addq.l  #1,D7
            cmp.l   D7,D3
            bgt.b   .L2
            movea.l ($C,A3),A0
            move.l  #$FFFF,($104,A0)
            lea     Timeout,A0
            move.l  A0,($14,A3)
            move.l  #$2000,($18,A3)
            clr.b   D6
            move.b  D6,D0
.L3:
            movem.l (-$18,A6),D3/D6-D7/A3-A4
            unlk    A6
            rts
            ds.b    4
SONIC_Init_Loopback_params:
            movem.l D3/D6-D7/A3-A4,-(SP)
            movea.l ($18,SP),A4
            movea.l ($1C,SP),A3
            moveq   #1,D6
            pea     MemTop
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($14,A3)
            addq.l  #8,SP
            bne.b   .L1
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L1:
            move.l  ($14,A3),($18,A3)
            moveq   #$1C,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($2C,A3)
            addq.l  #8,SP
            bne.b   .L2
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L2:
            move.l  ($2C,A3),($30,A3)
            moveq   #$1C,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($34,A3)
            addq.l  #8,SP
            bne.b   .L3
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L3:
            move.l  ($34,A3),($38,A3)
            moveq   #$1C,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($3C,A3)
            addq.l  #8,SP
            bne.b   .L4
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L4:
            move.l  ($3C,A3),($40,A3)
            moveq   #$50,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($44,A3)
            addq.l  #8,SP
            bne.b   .L5
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L5:
            move.l  ($44,A3),($48,A3)
            moveq   #$4C,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($4C,A3)
            addq.l  #8,SP
            bne.b   .L6
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L6:
            move.l  ($4C,A3),($50,A3)
            pea     ($640).w
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($54,A3)
            addq.l  #8,SP
            bne.b   .L7
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L7:
            move.l  ($54,A3),($58,A3)
            pea     ($640).w
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($5C,A3)
            addq.l  #8,SP
            bne.b   .L8
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L8:
            move.l  ($5C,A3),($60,A3)
            pea     ($640).w
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($64,A3)
            addq.l  #8,SP
            bne.b   .L9
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L9:
            move.l  ($64,A3),($68,A3)
            pea     ($640).w
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($6C,A3)
            addq.l  #8,SP
            bne.b   .L10
            moveq   #3,D6
            move.b  D6,D0
            bra.w   .L13
.L10:
            move.l  ($6C,A3),($70,A3)
            pea     ($640).w
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($74,A3)
            addq.l  #8,SP
            bne.b   .L11
            moveq   #3,D6
            move.b  D6,D0
            bra.b   .L13
.L11:
            move.l  ($74,A3),($78,A3)
            moveq   #8,D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l ($90,A4),A0
            jsr     (A0)
            move.l  D0,($7C,A3)
            movea.l ($14,A3),A0
            moveq   #$10,D0
            move.l  D0,(A0)
            moveq   #0,D7
            moveq   #$40,D3
            addq.l  #8,SP
.L12:
            movea.l ($20,SP),A0
            move.l  D7,D0
            asl.l   #2,D0
            movea.l ($14,A3),A1
            move.l  D7,D1
            asl.l   #2,D1
            move.l  (0,A0,D0.l),(4,A1,D1.l)
            addq.l  #1,D7
            cmp.l   D7,D3
            bgt.b   .L12
            movea.l ($14,A3),A0
            move.l  #$FFFF,($104,A0)
            lea     Timeout,A0
            move.l  A0,($1C,A3)
            move.l  #$FFFFF,($20,A3)
            clr.b   D6
            move.b  D6,D0
.L13:
            movem.l (SP)+,D3/D6-D7/A3-A4
            rts
            ds.b    14
SONIC_Install_Interrupt_Handler:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            movea.l ($10,A6),A0
            movea.l (A0),A4
            move.l  (8,A6),(-4,A6)
            movea.l #$50F01C00,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(2,A0)
            move.b  #$7F,(A3)
            movea.l #$50F03C00,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(3,A0)
            move.b  #$7F,(A3)
            movea.l #$50F14F09,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(4,A0)
            ori.b   #1,(A3)
            movea.l #$50F14F29,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(5,A0)
            ori.b   #1,(A3)
            movea.l #$50F00400,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(1,A0)
            ori.b   #$40,(A3)
            movea.l #$50F00000,A3
            movea.l ($7C,A4),A0
            move.b  (A3),(A0)
            andi.b  #$BF,(A3)
            moveq   #$1B,D0
            move.l  D0,-(SP)
            move.l  ($10,A6),-(SP)
            pea     SONIC_InterruptHandler
            move.l  ($C,A6),-(SP)
            move.l  (-4,A6),-(SP)
            movea.l (-4,A6),A0
            movea.l ($74,A0),A0
            jsr     (A0)
            movem.l (-$C,A6),A3-A4
            unlk    A6
            rts
            ds.b    10
SONIC_Remove_Interrupt_Handler:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            movea.l ($10,A6),A0
            movea.l (A0),A4
            move.l  (8,A6),(-4,A6)
            movea.l #$50F00400,A3
            movea.l ($7C,A4),A0
            move.b  (1,A0),(A3)
            movea.l #$50F00000,A3
            movea.l ($7C,A4),A0
            move.b  (A0),D0
            and.b   #$40,D0
            beq.b   .L1
            ori.b   #$40,(A3)
            moveq   #0,D0
            move.b  (A3),D0
            bra.b   .L2
.L1:
            andi.b  #$BF,(A3)
            moveq   #0,D0
            move.b  (A3),D0
.L2:
            movea.l #$50F01C00,A3
            movea.l ($7C,A4),A0
            move.b  (2,A0),(A3)
            movea.l #$50F03C00,A3
            movea.l ($7C,A4),A0
            move.b  (3,A0),(A3)
            movea.l #$50F14F09,A3
            movea.l ($7C,A4),A0
            move.b  (4,A0),(A3)
            movea.l #$50F14F29,A3
            movea.l ($7C,A4),A0
            move.b  (5,A0),(A3)
            move.l  ($C,A6),-(SP)
            move.l  (-4,A6),-(SP)
            movea.l (-4,A6),A0
            movea.l ($78,A0),A0
            jsr     (A0)
            movem.l (-$C,A6),A3-A4
            unlk    A6
            rts
            ds.b    6
SONIC_Test:
            link.w  A6,#-$208
            movem.l D5-D7/A3-A4,-(SP)
            move.l  ($10,A6),D5
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            move.l  #$AAAA,(-4,A6)
            move.l  #$AAAA,(-8,A6)
            move.l  #$AAAA,(-$C,A6)
            moveq   #$F,D0
            move.l  D0,(-$10,A6)
            move.l  #$FFFF,(-$14,A6)
            move.l  #$FFFF,(-$18,A6)
            move.l  #$FFFF,(-$1C,A6)
            moveq   #$E,D1
            move.l  D1,(-$20,A6)
            move.l  #$1111,(-$24,A6)
            move.l  #$1111,(-$28,A6)
            move.l  #$1111,(-$2C,A6)
            moveq   #$D,D0
            move.l  D0,(-$30,A6)
            move.l  #$2222,(-$34,A6)
            moveq   #0,D0
            move.l  D0,(-$38,A6)
            move.l  D0,(-$3C,A6)
            moveq   #$C,D0
            move.l  D0,(-$40,A6)
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.l  #$6000,(-$48,A6)
            move.l  #$9408,(-$4C,A6)
            moveq   #$B,D0
            move.l  D0,(-$50,A6)
            move.l  #$608,(-$54,A6)
            move.l  #$764,(-$58,A6)
            move.l  #$974,(-$5C,A6)
            moveq   #$A,D0
            move.l  D0,(-$60,A6)
            move.l  #$408,(-$64,A6)
            move.l  #$1962,(-$68,A6)
            move.l  #$321,(-$6C,A6)
            moveq   #9,D0
            move.l  D0,(-$70,A6)
            move.l  #$DEBE,(-$74,A6)
            move.l  #$FEEB,(-$78,A6)
            move.l  #$BEEF,(-$7C,A6)
            moveq   #8,D0
            move.l  D0,(-$80,A6)
            move.l  #$DADA,(-$84,A6)
            move.l  #$FACE,(-$88,A6)
            move.l  #$6789,(-$8C,A6)
            moveq   #7,D0
            move.l  D0,(-$90,A6)
            move.l  #$2345,(-$94,A6)
            move.l  #$EF01,(-$98,A6)
            move.l  #$ABCD,(-$9C,A6)
            moveq   #6,D0
            move.l  D0,(-$A0,A6)
            move.l  #$AA55,(-$A4,A6)
            move.l  #$5A5A,(-$A8,A6)
            move.l  #$55AA,(-$AC,A6)
            moveq   #5,D0
            move.l  D0,(-$B0,A6)
            move.l  #$7F00,(-$B4,A6)
            move.l  #$CFBF,(-$B8,A6)
            move.l  #$F7EF,(-$BC,A6)
            moveq   #4,D0
            move.l  D0,(-$C0,A6)
            move.l  #$FCFB,(-$C4,A6)
            move.l  #$FFFE,(-$C8,A6)
            move.l  #$4080,(-$CC,A6)
            moveq   #3,D0
            move.l  D0,(-$D0,A6)
            move.l  #$1020,(-$D4,A6)
            move.l  #$408,(-$D8,A6)
            move.l  #$102,(-$DC,A6)
            moveq   #2,D0
            move.l  D0,(-$E0,A6)
            move.l  #$706,(-$E4,A6)
            move.l  #$908,(-$E8,A6)
            move.l  #$B0A,(-$EC,A6)
            moveq   #1,D0
            move.l  D0,(-$F0,A6)
            move.l  #$100,(-$F4,A6)
            move.l  #$302,(-$F8,A6)
            move.l  #$504,(-$FC,A6)
            moveq   #0,D0
            move.l  D0,(-$100,A6)
            pea     (-$104,A6)
            movec   CACR,D0
            movea.l (SP),A0
            move.l  D0,(A0)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  (SP),D0
            movec   D0,CACR
            mc68040
            cpusha  BC
            mc68030
            lea     (-$100,A6),A0
            move.l  A0,(-$108,A6)
            moveq   #0,D7
            addq.l  #8,SP
.L1:
            move.l  D7,D0
            lsl.l   #2,D0
            add.l   #$50F0A002,D0
            move.l  D7,D1
            asl.l   #2,D1
            lea     (-$208,A6),A0
            move.l  D0,(0,A0,D1.l)
            addq.l  #1,D7
            moveq   #$40,D0
            cmp.l   D7,D0
            bgt.b   .L1
            move.l  ($14,A6),D0
            subi.l  #$9B,D0
            bcs.w   .L7
            cmpi.l  #2,D0
            bhi.w   .L7
            add.l   D0,D0
            move.w  .L3(PC,D0.l),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
            dc.w    .L5-(.L2+2)
            dc.w    .L6-(.L2+2)
.L4:
            lea     (-$208,A6),A0
            move.l  A0,(A3)
            moveq   #1,D0
            move.l  D0,(4,A3)
            move.l  #$100,D1
            and.l   D5,D1
            move.l  D1,(8,A3)
            move.l  A4,-(SP)
            movea.l ($58,A4),A0
            jsr     (A0)
            move.l  D0,D6
            addq.l  #4,SP
            bra.w   .L8
.L5:
            lea     (-$208,A6),A0
            move.l  A0,(A3)
            moveq   #1,D0
            move.l  D0,(4,A3)
            move.l  (-$108,A6),-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     SONIC_Init_CAMDMA_params
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D6
            move.l  #$100,D0
            and.l   D5,D0
            move.l  D0,(8,A3)
            tst.l   D6
            lea     ($C,SP),SP
            bne.b   .L8
            move.l  A4,-(SP)
            movea.l ($58,A4),A0
            jsr     (A0)
            move.l  D0,D6
            addq.l  #4,SP
            bra.b   .L8
.L6:
            lea     (-$208,A6),A0
            move.l  A0,(A3)
            moveq   #1,D0
            move.l  D0,(4,A3)
            move.l  (-$108,A6),-(SP)
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     SONIC_Init_Loopback_params
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D6
            lea     ($C,SP),SP
            bne.b   .L8
            moveq   #3,D0
            and.l   D5,D0
            move.l  D0,(8,A3)
            moveq   #$10,D0
            and.l   D5,D0
            move.l  D0,($C,A3)
            move.l  #$300,D0
            and.l   D5,D0
            move.l  D0,($10,A3)
            lea     SONIC_Install_Interrupt_Handler,A0
            move.l  A0,($24,A3)
            lea     SONIC_Remove_Interrupt_Handler,A0
            move.l  A0,($28,A3)
            move.l  A4,-(SP)
            movea.l ($58,A4),A0
            jsr     (A0)
            move.l  D0,D6
            addq.l  #4,SP
            bne.b   .L8
            bra.b   .L8
.L7:
            moveq   #-$D,D6
.L8:
            move.l  (-$104,A6),-(SP)
            move.l  (SP),D0
            movec   D0,CACR
            move.l  D6,D0
            addq.l  #4,SP
            movem.l (-$21C,A6),D5-D7/A3-A4
            unlk    A6
            rts
            ds.b    8

            EVEN
