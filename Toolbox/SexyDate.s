            include "Include/ROMHeader.s"

            EXPORT  Date2Secs,SexyDate

            SECTION "SexyDate",CODE

SexyDate:
Secs2Date:
            movem.l D0-D4/A0,-(SP)
            moveq   #0,D1
            lsr.l   #1,D0
            roxr.l  #1,D1
            divu.w  #$A8C0,D0
            swap    D0
            move.w  D0,D1
            rol.l   #1,D1
            clr.w   D0
            swap    D0
            move.l  D0,D2
            asl.l   #2,D2
            divu.w  #$5B5,D2
            addi.w  #$770,D2
            move.w  D2,(A0)+
            moveq   #$3B,D3
            andi.w  #3,D2
            bne.b   .L1
            addq.w  #1,D3
.L1:
            clr.w   D2
            swap    D2
            lsr.w   #2,D2
            moveq   #1,D4
            cmp.w   D3,D2
            blt.b   .L2
            addq.w  #2,D4
            sub.w   D3,D2
.L2:
            lsl.l   #7,D2
            moveq   #$47,D3
            add.l   D3,D2
            divu.w  #$F4F,D2
            add.w   D4,D2
            swap    D2
            lsr.w   #7,D2
            addq.w  #1,D2
            move.l  D2,(A0)+
            divu.w  #$E10,D1
            move.w  D1,(A0)+
            clr.w   D1
            swap    D1
            divu.w  #$3C,D1
            swap    D1
            move.l  D1,(A0)+
            addq.w  #5,D0
            divu.w  #7,D0
            swap    D0
            addq.w  #1,D0
            move.w  D0,(A0)
            movem.l (SP)+,D0-D4/A0
            rts
Date2Secs:
            movem.l D1-D4,-(SP)
            moveq   #0,D0
            addq.l  #8,A0
            move.l  (A0),D1
            move.w  D1,D0
            swap    D1
            move.w  -(A0),D2
            moveq   #$3C,D3
            mulu.w  D3,D2
            add.w   D1,D2
            mulu.w  D3,D2
            add.l   D2,D0
            move.w  -(A0),D1
            subq.w  #1,D1
            move.w  -(A0),D2
            move.w  -(A0),D3
            move.w  D3,D4
            subi.w  #$770,D3
            mulu.w  #$5B5,D3
            addq.l  #3,D3
            lsr.l   #2,D3
            add.w   D3,D1
            subq.w  #1,D2
            cmpi.w  #1,D2
            ble.b   .L2
            subq.w  #2,D2
            moveq   #$3B,D3
            andi.w  #3,D4
            bne.b   .L1
            addq.w  #1,D3
.L1:
            add.w   D3,D1
.L2:
            mulu.w  #$F4D,D2
            addi.w  #$34,D2
            lsr.w   #7,D2
            add.w   D2,D1
            mulu.w  #$A8C0,D1
            add.l   D1,D1
            add.l   D1,D0
            movem.l (SP)+,D1-D4
            rts
            ds.b    6

            EVEN
