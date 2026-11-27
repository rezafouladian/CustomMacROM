.L4:
            moveq   #0,D6
            move.w  (6,A1,D1.w),D3
            move.l  ($1C,A2),D2
            move.l  D7,D4
            bne.b   .L6
            clr.w   (6,A1,D1.w)
            bra.b   .L7
.L5:
            move.w  D5,D3
.L6:
            add.l   D2,D6
            bsr.w   GtNxBlk
            sub.l   D2,D4
            bhi.b   .L5
            cmp.l   ($C,A1,D1.w),D6
            bcc.w   SetEOF.L1
            move.w  D5,-(SP)
            moveq   #1,D5
            bsr.w   SubMrk
            move.w  (SP)+,D3
.L7:
            bsr.w   DAlBlks
            move.l  D6,($C,A1,D1.w)
            move.l  D6,D4
            bra.w   SetEOF.L6
