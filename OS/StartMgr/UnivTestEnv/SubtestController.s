            include "Include/ROMHeader.s"

            EXPORT  DoSubtest,FindSubtest

            IMPORT  FindKeyedNode

            SECTION "SubtestController",CODE

FindSubtest:
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

            EVEN
