            include "Include/ROMHeader.s"

            EXPORT  DequeueTrap,InitQueue,QStuff

            SECTION "Queue",CODE

QStuff:
Enqueue:
            move    SR,-(SP)
            addq.w  #2,A1
            ori     #$700,SR
            clr.l   (A0)
            tst.l   (A1)+
            bne.b   .L1
            move.l  A0,(A1)
            move.l  A0,-(A1)
            bra.b   .L2
.L1:
            move.l  A2,-(SP)
            movea.l (A1),A2
            move.l  A0,(A2)
            move.l  A0,(A1)
            movea.l (SP)+,A2
            subq.w  #4,A1
.L2:
            subq.w  #2,A1
            move    (SP)+,SR
            rts
DequeueTrap:
            move    SR,-(SP)
            movem.l A2-A3,-(SP)
            ori     #$700,SR
            movea.l (2,A1),A2
            movea.l A2,A3
.L1:
            cmpa.l  A3,A0
            beq.b   .L2
            movea.l A3,A2
            movea.l (A2),A3
            cmpa.l  (6,A1),A2
            bne.b   .L1
            moveq   #-1,D0
            bra.b   .L4
.L2:
            cmpa.l  A2,A3
            bne.b   .L5
            move.l  (A2),(2,A1)
            bne.b   .L3
            clr.l   (6,A1)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,A2-A3
            move    (SP)+,SR
            rts
.L5:
            move.l  (A3),(A2)
            cmpa.l  (6,A1),A3
            bne.b   .L3
            move.l  A2,(6,A1)
            bra.b   .L3
InitQueue:
            clr.w   (A1)+
            clr.l   (A1)+
            clr.l   (A1)
            subq.w  #6,A1
            rts
            ds.b    8

            EVEN
