            include "Include/ROMHeader.s"

            SECTION "SONIC_BitMarch",CODE

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

            EVEN
