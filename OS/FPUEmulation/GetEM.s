            move.w  (A0),D0
            bclr    #$F,D0
            subi.w  #$3FFF,D0
            fmove.w D0,FP0
            rts
            bclr    #7,(A0)
            bsr.w   sub_4088FCF8
            move.w  (A0),D0
            subi.w  #$3FFF,D0
            fmove.w D0,FP0
            rts
sub_40891504:
            move.l  (-$80,A6),D0
            andi.l  #$FFFFFF00,D0
            fmove.l D0,FPCR
            move.w  (A0),D0
            ori.w   #$7FFF,D0
            bclr    #$E,D0
            move.w  D0,(A0)
            fmove.x (A0),FP0
            rts
            move.l  (4,A0),D0
            move.l  (8,A0),D1
            bsr.b   sub_40891538
            move.l  D0,(4,A0)
            move.l  D1,(8,A0)
            bra.b   sub_40891504
sub_40891538:
            tst.l   D0
            bne.b   .L2
            tst.l   D1
            bne.b   .L1
            bra.b   .L3
.L1:
            move.l  D3,-(SP)
            exg     D0,D1
            bfffo   D0{0:0},D3
            lsl.l   D3,D0
            move.l  (SP)+,D3
            bra.b   .L3
.L2:
            movem.l D3/D5-D6,-(SP)
            bfffo   D0{0:0},D3
            lsl.l   D3,D0
            move.l  D1,D6
            lsl.l   D3,D1
            moveq   #$20,D5
            sub.l   D3,D5
            lsr.l   D5,D6
            or.l    D6,D0
            movem.l (SP)+,D3/D5-D6
.L3:
            rts
