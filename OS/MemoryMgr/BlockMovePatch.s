            include "Include/ROMHeader.s"

            EXPORT  BLOCKMOVEPATCH

            IMPORT  BMEXIT16,BMMOVELONGS,BMOVERLAP,BMVERYSHORT,FlushCRangeForBM

            SECTION "BlockMovePatch",CODE

BLOCKMOVEPATCH:
BlockMove68040:
            moveq   #-12,D1
            add.l   D0,D1
            bgt.b   .L1
            bra.l   BMVERYSHORT
.L1:
            move.l  D0,-(SP)
            move.l  A1,-(SP)
            BigLea  FlushCRangeForBM,A1
            move.l  A1,-(SP)
            movea.l (4,SP),A1
            bra.b   .checkAlignment
            move.l  ($6F4).w,-(SP)
.checkAlignment:
            move.l  A1,D1
            moveq   #-4,D2
            or.l    D1,D2
            sub.l   A0,D1
            and.l   Lo3Bytes,D1
            cmp.l   D0,D1
            bcs.b   .L4
            cmpi.l  #$2F,D0
            bcs.b   .L3
            andi.b  #$F,D1
            beq.b   .UseMove16
.L3:
            bra.l   BMMOVELONGS
.L4:
            bra.l   BMOVERLAP
.UseMove16:
            move.l  A1,D1
            neg.l   D1
            moveq   #15,D2
            and.l   D1,D2
            beq.b   .Aligned16
            sub.l   D2,D0
            lsr.l   #1,D2
            bcc.b   .Aligned2
            move.b  (A0)+,(A1)+
.Aligned2:
            lsr.l   #1,D2
            bcc.b   .Aligned4
            move.w  (A0)+,(A1)+
.Aligned4:
            lsr.l   #1,D2
            bcc.b   .Aligned8
            move.l  (A0)+,(A1)+
            tst.l   D2
.Aligned8:
            beq.b   .Aligned16
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
.Aligned16:
            moveq   #$20,D2
            sub.l   D2,D0
            bclr    #4,D0
            nop
            beq.b   Loop16
            mc68040
            move16  (A0)+,(A1)+                     ; odd 16-byte line first
            bra.b   Loop16
            ds.b    8                               ; align Loop16 to a 16-byte boundary
Loop16:
            move16  (A0)+,(A1)+
            sub.l   D2,D0
            move16  (A0)+,(A1)+
            bge.b   Loop16
            mc68030
            bra.l   BMEXIT16
            ds.b    1886

            EVEN
