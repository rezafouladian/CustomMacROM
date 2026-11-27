            include "Include/ROMHeader.s"

            EXPORT  FindFirstNode,FindKeyedNode,FindNextNode,InitList,InitNode_2,InsertNode

            SECTION "UTEList",CODE

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

            EVEN
