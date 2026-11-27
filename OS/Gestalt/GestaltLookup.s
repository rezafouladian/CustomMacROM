            include "Include/ROMHeader.s"

            EXPORT  findLong,newGestalt

            IMPORT  SetHandleSize_2

            SECTION "GestaltLookup",CODE

newGestalt:
            link.w  A6,#-4
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($14,A6),A4
            move.l  (8,A6),D5
            move.l  ($10,A6),D6
            btst    #0,D6
            beq.b   .L1
            moveq   #-$32,D0
            bra.w   .L11
.L1:
            movea.l SysZone,A0
            cmp.l   (A0),D6
            bls.b   .L2
            cmp.l   ROMBase,D6
            bcc.b   .L2
            move.w  #$EA4F,D0
            bra.w   .L11
.L2:
            moveq   #1,D4
            pea     (-4,A6)
            move.l  ($C,A6),-(SP)
            jsr     findLong
            tst.l   D0
            addq.l  #8,SP
            bne.b   .L5
            tst.l   D5
            beq.b   .L3
            move.w  #$EA51,D0
            bra.w   .L11
.L3:
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (4,A0),D0
            addq.l  #1,D0
            asl.l   #3,D0
            move.l  D0,-(SP)
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (A0),-(SP)
            jsr     (SetHandleSize_2.w,PC)
            tst.w   MemErr
            addq.l  #8,SP
            beq.b   .L4
            moveq   #-$6C,D0
            bra.w   .L11
.L4:
            moveq   #0,D4
            bra.b   .L6
.L5:
            tst.l   D5
            bne.b   .L6
            move.w  #$EA50,D0
            bra.b   .L11
.L6:
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            movea.l (A0),A3
            tst.l   D4
            bne.b   .L9
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (4,A0),D7
            bra.b   .L8
.L7:
            move.l  D7,D0
            asl.l   #3,D0
            move.l  D7,D1
            asl.l   #3,D1
            move.l  (-8,A3,D0.l),(0,A3,D1.l)
            move.l  D7,D0
            asl.l   #3,D0
            move.l  D7,D1
            asl.l   #3,D1
            move.l  (-4,A3,D0.l),(4,A3,D1.l)
            subq.l  #1,D7
.L8:
            cmp.l   (-4,A6),D7
            bgt.b   .L7
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            addq.l  #1,(4,A0)
            move.l  (-4,A6),D0
            asl.l   #3,D0
            move.l  ($C,A6),(0,A3,D0.l)
.L9:
            tst.l   D5
            beq.b   .L10
            move.l  (-4,A6),D0
            asl.l   #3,D0
            move.l  (4,A3,D0.l),(A4)
.L10:
            move.l  (-4,A6),D0
            asl.l   #3,D0
            move.l  D6,(4,A3,D0.l)
            moveq   #0,D0
.L11:
            movem.l (-$1C,A6),D4-D7/A3-A4
            unlk    A6
            rts
removeLong:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            pea     (-4,A6)
            move.l  (8,A6),-(SP)
            jsr     findLong
            tst.l   D0
            addq.l  #8,SP
            bne.b   .L1
            move.l  #$FFFFEA51,D0
            bra.b   .L4
.L1:
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            movea.l (A0),A3
            move.l  (-4,A6),D0
            asl.l   #3,D0
            move.l  (4,A3,D0.l),(A4)
            move.l  (-4,A6),D7
            bra.b   .L3
.L2:
            move.l  D7,D0
            asl.l   #3,D0
            move.l  D7,D1
            asl.l   #3,D1
            move.l  (8,A3,D0.l),(0,A3,D1.l)
            move.l  D7,D0
            asl.l   #3,D0
            move.l  D7,D1
            asl.l   #3,D1
            move.l  ($C,A3,D0.l),(4,A3,D1.l)
            addq.l  #1,D7
.L3:
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (4,A0),D0
            subq.l  #1,D0
            cmp.l   D7,D0
            bgt.b   .L2
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            subq.l  #1,(4,A0)
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (4,A0),D0
            asl.l   #3,D0
            move.l  D0,-(SP)
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (A0),-(SP)
            jsr     (SetHandleSize_2.w,PC)
            moveq   #0,D0
            addq.l  #8,SP
.L4:
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    6
findLong:
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($20,SP),A4
            move.l  ($1C,SP),D4
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            movea.l (A0),A3
            moveq   #0,D6
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            move.l  (4,A0),D5
            subq.l  #1,D5
.L1:
            move.l  D5,D0
            sub.l   D6,D0
            moveq   #1,D1
            cmp.l   D0,D1
            slt     D7
            andi.w  #1,D7
            ext.l   D7
            add.l   D6,D7
            move.l  D7,D0
            asl.l   #3,D0
            cmp.l   (0,A3,D0.l),D4
            bcc.b   .L2
            move.l  D7,D5
            bra.b   .L4
.L2:
            move.l  D7,D0
            asl.l   #3,D0
            cmp.l   (0,A3,D0.l),D4
            bls.b   .L3
            move.l  D7,D6
            addq.l  #1,D6
            bra.b   .L4
.L3:
            move.l  D7,(A4)
            moveq   #1,D0
            bra.b   .L5
.L4:
            cmp.l   D5,D6
            bne.b   .L1
            move.l  D6,(A4)
            moveq   #0,D0
.L5:
            movem.l (SP)+,D4-D7/A3-A4
            rts
            ds.b    4

            EVEN
