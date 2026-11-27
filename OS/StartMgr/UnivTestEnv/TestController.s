            include "Include/ROMHeader.s"

            EXPORT  DoTest

            IMPORT  AllocTempMem,FreeTempMem,FindKeyedNode,FindSubtest

            SECTION "TestController",CODE

FindTest:
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
            jsr     (FreeTempMem.w,PC)
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
            jsr     (FindSubtest.w,PC)
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
            jsr     (AllocTempMem.w,PC)
            move.l  D0,(-8,A6)
            addq.l  #8,SP
            bne.b   .L3
            moveq   #-9,D7
            bra.b   .L10
.L3:
            move.l  ($1C,A4),D6
            move.l  D6,-(SP)
            move.l  A3,-(SP)
            jsr     (AllocTempMem.w,PC)
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

            EVEN
