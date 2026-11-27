Lg2Phys:
            move.l  ($6FC).w,-(SP)
            rts
VLG2PHYS:
            bsr.w   sub_408117E6
            bne.b   .L1
            jmp     (MapFBlock.w,PC)
.L1:
            movem.l D1-D2/D4-D5/D7,-(SP)
            move.l  ($1C,A2),D7
            move.w  (6,A1,D1.w),D3
            add.l   D5,D4
            subq.l  #1,D4
            moveq   #9,D1
            moveq   #0,D6
            lsr.l   D1,D4
            lsr.l   D1,D7
            move.l  D5,D2
            lsr.l   D1,D2
            bra.b   .L3
.L2:
            bsr.b   GtNxBlk
            move.w  D5,D3
            sub.w   D7,D4
            sub.w   D7,D2
.L3:
            cmp.w   D7,D2
            bcc.b   .L2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  D7,D0
            add.w   D2,D0
            add.w   ($24,A2),D0
            move.l  D0,-(SP)
.L4:
            move.w  D7,D0
            sub.w   D2,D0
            add.w   D0,D6
            sub.w   D0,D4
            bmi.b   .L5
            bsr.b   GtNxBlk
            moveq   #0,D2
            addq.w  #1,D3
            cmp.w   D3,D5
            beq.b   .L4
.L5:
            move.l  (SP)+,D3
            move.w  D3,D0
            add.w   D6,D0
            move.w  ($24,A2),D4
            mulu.w  ($1A,A2),D7
            add.w   D4,D7
            cmp.w   D7,D0
            bhi.b   .L7
            cmp.w   D4,D3
            bcs.b   .L7
            asl.l   D1,D6
            movem.l (SP)+,D1-D2/D4-D5/D7
            cmp.l   D4,D6
            bls.b   .L6
            move.l  D4,D6
.L6:
            moveq   #0,D0
            rts
.L7:
            movem.l (SP)+,D1-D2/D4-D5/D7
            move.w  #$10,D0
            rts
GtNxBlk:
            movem.l D0/A2,-(SP)
            movea.l ($50,A2),A2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  #$C,D0
            ror.l   #4,D0
            asl.w   #1,D0
            move.l  (0,A2,D0.w),D5
            clr.w   D0
            rol.l   #4,D0
            addi.w  #$C,D0
            rol.l   D0,D5
            andi.w  #$FFF,D5
            movem.l (SP)+,D0/A2
            rts
.L1:
            move.l  D4,D0
.L2:
            movem.l D1-D5/D7/A0-A3,-(SP)
            move.l  ($1C,A2),D7
            move.l  D7,D6
            mulu.w  ($2A,A2),D6
            cmp.l   D6,D4
            bls.b   .L3
            move.l  D6,D4
.L3:
            cmp.l   D0,D4
            bcc.b   .L5
            moveq   #-$22,D0
.L4:
            movem.l (SP)+,D1-D5/D7/A0-A3
            rts
.L5:
            move.l  ($C,A1,D1.w),D2
            moveq   #0,D6
            move.w  (6,A1,D1.w),D3
            bne.b   .L7
            bsr.b   GetFreeBk
            move.w  D5,(6,A1,D1.w)
            move.w  D5,D3
            moveq   #1,D5
            bsr.w   SubMrk
            bra.b   .L10
.L6:
            move.w  D5,D3
.L7:
            bsr.b   GtNxBlk
            cmpi.w  #1,D5
            bne.b   .L6
.L8:
            cmp.w   ($1A,A2),D3
            bhi.b   .L11
            addq.w  #1,D3
            bsr.b   GtNxBlk
            subq.w  #1,D3
            tst.w   D5
            bne.b   .L11
            move.w  D3,D5
            addq.w  #1,D5
.L9:
            bsr.w   SubMrk
            move.w  D5,D3
            moveq   #1,D5
            bsr.b   SubMrk
.L10:
            add.l   D7,D6
            add.l   D7,D2
            subq.w  #1,($2A,A2)
            cmp.l   D6,D4
            bhi.b   .L8
            move.l  D2,($C,A1,D1.w)
            bsr.w   MarkVCB
            moveq   #0,D0
            bra.b   .L4
.L11:
            bsr.b   GetFreeBk
            bra.b   .L9
GetFreeBk:
            movem.l D0-D4/D6/A1/A3,-(SP)
            sub.l   D6,D4
            cmp.l   ($20,A2),D4
            bcc.b   .L1
            move.l  ($20,A2),D4
.L1:
            movea.l ($50,A2),A1
            movea.w ($1A,A2),A3
            addq.w  #1,A3
            moveq   #0,D5
            moveq   #2,D0
            moveq   #2,D2
            moveq   #0,D3
            moveq   #0,D6
            clr.w   -(SP)
.L2:
            move.b  (A1)+,D1
            lsl.w   #8,D1
            bchg    #0,D5
            bne.b   .L3
            move.b  (A1),D1
            lsr.w   #4,D1
            bra.b   .L4
.L3:
            move.b  (A1)+,D1
            andi.w  #$FFF,D1
.L4:
            bne.b   .L6
            add.l   D7,D3
            cmp.l   D6,D3
            bls.b   .L5
            move.l  D3,D6
            move.w  D2,(SP)
            cmp.l   D4,D3
            bcc.b   .L8
.L5:
            addq.w  #1,D0
            bra.b   .L7
.L6:
            addq.w  #1,D0
            move.w  D0,D2
            moveq   #0,D3
.L7:
            cmp.w   A3,D0
            bls.b   .L2
.L8:
            move.w  (SP)+,D5
            movem.l (SP)+,D0-D4/D6/A1/A3
            rts
SubMrk:
            movem.l D0/D6/A2,-(SP)
            movea.l ($50,A2),A2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  #$C,D0
            ror.l   #4,D0
            asl.w   #1,D0
            move.l  (0,A2,D0.w),D6
            swap    D0
            lsr.w   #8,D0
            lsr.w   #4,D0
            addi.w  #$C,D0
            rol.l   D0,D6
            andi.w  #$F000,D6
            or.w    D5,D6
            ror.l   D0,D6
            swap    D0
            move.l  D6,(0,A2,D0.w)
            movem.l (SP)+,D0/D6/A2
            rts
DAlBlks:
            tst.w   D3
            beq.b   .L2
.L1:
            bsr.w   GtNxBlk
            move.w  D5,-(SP)
            clr.w   D5
            bsr.b   SubMrk
            addq.w  #1,($2A,A2)
            move.w  (SP)+,D3
            cmpi.w  #1,D3
            bne.b   .L1
            bsr.w   MarkVCB
.L2:
            rts
            ds.b    12
