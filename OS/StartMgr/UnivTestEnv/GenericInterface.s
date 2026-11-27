            include "Include/ROMHeader.s"

            EXPORT  GI_AllocPermMem,GI_ExecuteTest,GI_FindSubtest,GI_InitInterface,GI_InstallSubtest,GI_InstallTest

            IMPORT  FakeExceptionCall,GetInterruptLevel,InstallExceptionVector,SetInterruptLevel,BitWalk16,BitWalk32
            IMPORT  BitWalk8,InstallExceptionHandler,RemoveExceptionHandler,AllocPermMem,AllocTempMem,FreeTempMem
            IMPORT  InitHeap,FindFirstNode,FindKeyedNode,FindNextNode,InitList,InitNode_2
            IMPORT  InsertNode,DoSubtest,DoTest

            SECTION "GenericInterface",CODE

GI_InitInterface:
            link.w  A6,#0
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            moveq   #0,D7
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            move.l  A3,-(SP)
            jsr     (InitHeap.w,PC)
            pea     ($494).w
            move.l  A3,-(SP)
            jsr     (AllocPermMem.w,PC)
            tst.l   D0
            lea     ($14,SP),SP
            bne.b   .L1
            moveq   #-6,D7
            bra.b   .L2
.L1:
            move.l  #$1504005,(A3)
            pea     ($38,A3)
            jsr     (InitList.w,PC)
            pea     ($48,A3)
            jsr     (InitList.w,PC)
            lea     (DoSubtest.w,PC),A0
            move.l  A0,($58,A3)
            lea     (BitWalk8.w,PC),A0
            move.l  A0,($68,A3)
            lea     (BitWalk16.w,PC),A0
            move.l  A0,($6C,A3)
            lea     (BitWalk32.w,PC),A0
            move.l  A0,($70,A3)
            lea     (InstallExceptionHandler.w,PC),A0
            move.l  A0,($74,A3)
            lea     (RemoveExceptionHandler.w,PC),A0
            move.l  A0,($78,A3)
            lea     (FakeExceptionCall.w,PC),A0
            move.l  A0,($7C,A3)
            lea     (SetInterruptLevel.w,PC),A0
            move.l  A0,($80,A3)
            lea     (GetInterruptLevel.w,PC),A0
            move.l  A0,($84,A3)
            lea     (InstallExceptionVector.w,PC),A0
            move.l  A0,($88,A3)
            lea     (AllocPermMem.w,PC),A0
            move.l  A0,($8C,A3)
            lea     (AllocTempMem.w,PC),A0
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
            jsr     (AllocPermMem.w,PC)
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
            jsr     (InitNode_2.w,PC)
            move.l  ($10,A6),($10,A3)
            move.l  ($14,A6),($14,A3)
            move.l  ($18,A6),($18,A3)
            move.l  A3,-(SP)
            pea     ($38,A4)
            jsr     (InsertNode.w,PC)
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
            jsr     (AllocPermMem.w,PC)
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
            jsr     (InitNode_2.w,PC)
            move.l  ($10,A6),($10,A3)
            move.l  ($14,A6),($14,A3)
            move.l  ($18,A6),($20,A3)
            move.l  ($1C,A6),($18,A3)
            move.l  ($20,A6),($1C,A3)
            move.l  A3,-(SP)
            pea     ($48,A4)
            jsr     (InsertNode.w,PC)
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
            jsr     (FindKeyedNode.w,PC)
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
GI_FindFirstTest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($38,A3)
            jsr     (FindFirstNode.w,PC)
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_FindNextTest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($38,A3)
            jsr     (FindNextNode.w,PC)
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
            jsr     (FindKeyedNode.w,PC)
            movea.l (-4,A6),A3
            unlk    A6
            rts
            dc.w    0
GI_FindFirstSubtest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($48,A3)
            jsr     (FindFirstNode.w,PC)
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
            ds.b    12
GI_FindNextSubtest:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($48,A3)
            jsr     (FindNextNode.w,PC)
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
            jsr     (DoTest.w,PC)
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
            jsr     (AllocPermMem.w,PC)
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
            jsr     (AllocTempMem.w,PC)
            movea.l (-4,A6),A3
            unlk    A6
            rts
            ds.b    4
GI_FreeTempMem:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  A3,-(SP)
            jsr     (FreeTempMem.w,PC)
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

            EVEN
