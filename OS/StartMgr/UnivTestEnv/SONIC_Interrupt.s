            include "Include/ROMHeader.s"

            EXPORT  SONIC_InterruptHandler

            SECTION "SONIC_Interrupt",CODE

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

            EVEN
