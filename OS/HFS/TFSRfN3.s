sub_40811EF2:
            bsr.w   sub_408117E6
            bne.w   GtNxBlk.L1
            moveq   #1,D0
.L1:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            move.w  D0,D3
            jsr     (ExtendFile.w,PC)
            move.l  (A6)+,D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
