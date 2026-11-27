            include "Include/ROMHeader.s"

            EXPORT  VLOCCREC,CMKEYCMP,CMFLUSH,CMMAINT,LOCCNODE,LOCCREC
            EXPORT  UPDCNAME

            IMPORT  FlushMDB,MarkVCB,BTFlush,BTSEARCH

            SECTION "CMMaint",CODE

CMMAINT:
BUILDKEY:
            movem.l D0/A0-A1,-(SP)
            move.b  #6,(A1)
            clr.b   (1,A1)
            move.l  D0,(2,A1)
            clr.b   (6,A1)
            move.l  A0,D0
            beq.b   .L1
            move.l  A1,-(SP)
            lea     (6,A1),A1
            bsr.w   UPDCNAME
            move.b  (A1),D0
            movea.l (SP)+,A1
            add.b   D0,(A1)
.L1:
            movem.l (SP)+,D0/A0-A1
            rts
CMFLUSH:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  ($A6,A2),D1
            move.w  D1,D0
            jsr     (BTFlush.w,PC)
            bne.b   .L2
            movea.l ($34E).w,A1
            btst    #7,(4,A1,D1.w)
            beq.b   .L1
            jsr     (MarkVCB.w,PC)
            jsr     (FlushMDB.w,PC)
            bne.b   .L2
.L1:
            clr.w   D0
.L2:
            movem.l (A6)+,D1/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMKEYCMP:
            movem.l D1-D2/A0-A3,-(SP)
            movea.l A0,A2
            movea.l A1,A3
            move.l  (2,A2),D0
            cmp.l   (2,A3),D0
            bhi.b   .L3
            bcs.b   .L1
            lea     (6,A2),A0
            lea     (6,A3),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
            _RelString
            beq.b   .L2
            bgt.b   .L3
.L1:
            moveq   #-1,D0
            bra.b   .L4
.L2:
            moveq   #0,D0
            bra.b   .L4
.L3:
            moveq   #1,D0
.L4:
            movem.l (SP)+,D1-D2/A0-A3
            tst.w   D0
            rts
LOCCNODE:
            move.l  (SP)+,-(A6)
            jsr     LOCCREC
            bne.b   .L1
            cmpi.b  #3,(A1)
            bne.b   .L1
            lea     ($E,A1),A0
            move.l  ($A,A1),D0
            bsr.w   LOCCREC
.L1:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
LOCCREC:
            move.l  ($7C8).w,-(SP)
            rts
VLOCCREC:
            move.l  (SP)+,-(A6)
            lea     (A4),A1
            jsr     CMMAINT
            move.l  A0,D0
            bne.b   .L1
            moveq   #0,D2
.L1:
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     (BTSEARCH.w,PC)
            beq.b   .L2
            cmpi.w  #$20,D0
            bne.b   .L2
            moveq   #$30,D0
.L2:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
UPDCNAME:
            movem.l D0-D1/A0-A1,-(SP)
            moveq   #0,D0
            move.b  (A0)+,D0
            moveq   #$1F,D1
            cmp.w   D1,D0
            ble.b   .L1
            move.w  D1,D0
.L1:
            move.b  D0,(A1)+
            _BlockMove
            movem.l (SP)+,D0-D1/A0-A1
            rts
            ds.b    10

            EVEN
