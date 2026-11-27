            include "Include/ROMHeader.s"

            EXPORT  AllocPermMem,AllocTempMem,FreeTempMem,InitHeap

            SECTION "UTEHeap",CODE

InitHeap:
            movem.l A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($C,SP),A3
            move.l  A4,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,($24,A3)
            move.l  D1,($30,A3)
            move.l  ($14,SP),D0
            add.l   A4,D0
            moveq   #-4,D1
            and.l   D0,D1
            move.l  D1,($28,A3)
            move.l  D1,($34,A3)
            move.l  ($24,A3),D0
            movem.l (SP)+,A3-A4
            rts
            ds.b    6
AllocPermMem:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            move.l  ($C,A6),D7
            movea.l (8,A6),A3
            move.l  D7,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,D7
            move.l  D7,D0
            add.l   ($30,A3),D0
            move.l  D0,(-4,A6)
            cmp.l   ($34,A3),D0
            bls.b   .L1
            moveq   #0,D0
            movea.l D0,A4
            bra.b   .L2
.L1:
            movea.l ($30,A3),A4
            move.l  (-4,A6),($30,A3)
.L2:
            move.l  A4,D0
            movem.l (-$10,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    8
AllocTempMem:
            link.w  A6,#-4
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($C,A6),D6
            movea.l (8,A6),A4
            move.l  D6,D0
            neg.l   D0
            moveq   #-4,D1
            and.l   D0,D1
            neg.l   D1
            move.l  D1,D6
            movea.l ($34,A4),A3
            suba.l  D6,A3
            cmpa.l  ($30,A4),A3
            bcc.b   .L1
            moveq   #0,D0
            move.l  D0,(-4,A6)
            bra.b   .L4
.L1:
            move.l  A3,($34,A4)
            move.l  ($34,A4),(-4,A6)
            movea.l (-4,A6),A3
            move.l  D6,D7
            asr.l   #2,D7
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.l  D0,(A3)+
            subq.l  #1,D7
.L3:
            tst.l   D7
            bgt.b   .L2
.L4:
            move.l  (-4,A6),D0
            movem.l (-$14,A6),D6-D7/A3-A4
            unlk    A6
            rts
            ds.b    4
FreeTempMem:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  ($28,A3),($34,A3)
            movea.l (SP)+,A3
            rts

            EVEN
