InitRgn:
            move.w  D0,($12,A1)
            move.w  D1,($14,A1)
            move.w  D2,($16,A1)
            move.l  A0,D0
            jsr     ([$644.w])
            movea.l D0,A0
            move.l  A0,(A1)
            move.w  #$8001,($E,A1)
            move.w  (2,A0),($10,A1)
            lea     ($A,A0),A0
            move.l  A0,(4,A1)
            movea.l (SP)+,A0
            sub.w   D2,D1
            subq.w  #1,D1
            lsr.w   #5,D1
            move.w  D1,($C,A1)
.L1:
            clr.l   -(SP)
            dbra    D1,.L1
            move.l  SP,(8,A1)
            jmp     (A0)
            ds.b    12
SeekRgn:
            cmp.w   ($10,A1),D0
            bge.b   SEEKDOWN
            cmp.w   ($E,A1),D0
            blt.b   SEEKUP
            move.w  ($10,A1),D1
            sub.w   D0,D1
            move.w  D0,D2
            sub.w   ($E,A1),D2
            cmp.w   D1,D2
            blt.b   .L1
            move.w  D1,D2
.L1:
            rts
.L2:
            movea.l (8,A1),A0
            move.w  ($C,A1),D1
.L3:
            clr.l   (A0)+
            dbra    D1,.L3
            movea.l (A1),A0
            move.w  (2,A0),($10,A1)
            move.w  #$8001,($E,A1)
            lea     ($A,A0),A0
            move.l  A0,(4,A1)
            cmp.w   ($10,A1),D0
            bge.b   SEEKDOWN
            moveq   #1,D2
            bra.b   SEEKDOWN.L4
SEEKDOWN:
            movem.l D0/D3-D7/A2-A4,-(SP)
            move.w  D0,D2
            movea.l (4,A1),A2
            lea     .L2,A4
            move.w  ($12,A1),D6
            move.w  ($14,A1),D7
.L1:
            move.w  (A2)+,($E,A1)
.L2:
            move.w  (A2)+,D3
            cmpi.w  #$7FFF,D3
            beq.b   .L3
            move.w  (A2)+,D4
            bra.b   SEEKUP.L6
.L3:
            cmp.w   (A2),D2
            bge.b   .L1
            sub.w   (A2),D2
            neg.w   D2
            move.w  (A2),($10,A1)
            move.l  A2,(4,A1)
            movem.l (SP)+,D0/D3-D7/A2-A4
.L4:
            rts
SEEKUP:
            movea.l (A1),A0
            move.w  (2,A0),D1
            cmp.w   D1,D0
            blt.b   SeekRgn.L2
            movem.l D0/D3-D7/A2-A5,-(SP)
            move.w  D0,D2
            lea     ($A,A0),A5
            lea     .L2,A4
            move.w  ($12,A1),D6
            move.w  ($14,A1),D7
.L1:
            movea.l (4,A1),A2
            subq.w  #2,A2
.L2:
            move.w  -(A2),D4
            move.w  -(A2),D3
            cmpi.w  #$7FFF,D3
            beq.b   .L3
            bra.b   .L6
.L3:
            move.l  A2,D0
            addq.l  #2,D0
            move.l  D0,(4,A1)
            move.w  D4,($10,A1)
.L4:
            move.w  -(A2),D4
            cmpa.l  A5,A2
            ble.b   .L5
            move.w  -(A2),D3
            cmpi.w  #$7FFF,D3
            bne.b   .L4
.L5:
            move.w  D4,($E,A1)
            cmp.w   D4,D2
            blt.b   .L1
            sub.w   D4,D2
            addq.w  #1,D2
            movem.l (SP)+,D0/D3-D7/A2-A5
            rts
.L6:
            cmp.w   D6,D4
            ble.b   .L9
            cmp.w   D7,D3
            bge.b   .L9
            cmp.w   D6,D3
            bge.b   .L7
            move.w  D6,D3
.L7:
            cmp.w   D7,D4
            ble.b   .L8
            move.w  D7,D4
.L8:
            sub.w   ($16,A1),D3
            sub.w   ($16,A1),D4
            moveq   #$1F,D0
            move.w  D3,D1
            and.w   D0,D1
            moveq   #-1,D5
            lsr.l   D1,D5
            and.w   D4,D0
            moveq   #-1,D1
            lsr.l   D0,D1
            not.l   D1
            lsr.w   #5,D3
            movea.l (8,A1),A3
            move.w  D3,D0
            lsl.w   #2,D0
            adda.w  D0,A3
            lsr.w   #5,D4
            sub.w   D3,D4
            bgt.b   .L10
            and.l   D5,D1
            eor.l   D1,(A3)
.L9:
            jmp     (A4)
.L10:
            eor.l   D5,(A3)+
            bra.b   .L12
.L11:
            not.l   (A3)+
            not.l   (A3)+
.L12:
            subq.w  #2,D4
            bgt.b   .L11
            blt.b   .L13
            not.l   (A3)+
.L13:
            eor.l   D1,(A3)
            jmp     (A4)
            ds.b    14
