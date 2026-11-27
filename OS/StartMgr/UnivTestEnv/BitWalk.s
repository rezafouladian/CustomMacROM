            include "Include/ROMHeader.s"

            EXPORT  BitWalk16,BitWalk32,BitWalk8

            SECTION "BitWalk",CODE

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

            EVEN
