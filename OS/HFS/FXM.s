            include "Include/ROMHeader.s"

            EXPORT  vDeAllocFile,vExtendFile,vMapFBlock,vTruncateFile,vXFSearch,DeAllocFile
            EXPORT  ExtendFile,FXMKeyCmp,MapFBlock,TruncateFile

            IMPORT  FlushMDB,MarkVCB,BLKDEALLOC,BlkAlloc,CMGetCN,BTDelete
            IMPORT  BTFlush,BTGetRecord,BTINSERT,BTSEARCH,BTUpdate

            SECTION "FXM",CODE

DeAllocFile:
FXM:
            move.l  ($764).w,-(SP)
            rts
vDeAllocFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A1/A3-A4,-(A6)
            bsr.w   FXSetUp
            movea.l A0,A3
            move.l  D0,D7
            clr.b   D6
.L1:
            clr.w   D4
            movea.l A3,A0
            move.l  D7,D0
            moveq   #0,D2
            jsr     (CMGetCN.w,PC)
            bne.w   .L11
            cmpi.b  #2,(A1)
            beq.b   .L2
            moveq   #$30,D0
            bne.w   .L11
.L2:
            move.l  ($14,A1),D5
            lea     (2,A4),A0
            clr.w   (6,A0)
            tst.b   D6
            bne.b   .L3
            lea     ($4A,A1),A1
            bra.b   .L5
.L3:
            lea     ($56,A1),A1
            bra.b   .L5
.L4:
            lea     (2,A4),A0
            move.b  #7,(A0)
            move.b  D6,(1,A0)
            move.l  D5,(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     (BTSEARCH.w,PC)
            beq.b   .L5
            cmpi.w  #$20,D0
            beq.b   .L10
            bra.b   .L11
.L5:
            lea     ($A,A4),A0
            moveq   #2,D0
.L6:
            move.l  (A1)+,(A0)+
            dbra    D0,.L6
            lea     ($A,A4),A1
            clr.w   D1
.L7:
            move.w  (0,A1,D1.w),D2
            move.w  (2,A1,D1.w),D3
            beq.b   .L8
            jsr     (BLKDEALLOC.w,PC)
            bne.b   .L11
            add.w   D3,D4
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L7
.L8:
            lea     (2,A4),A0
            tst.w   (6,A0)
            beq.b   .L9
            move.w  ($A4,A2),D0
            jsr     (BTDelete.w,PC)
            bne.b   .L11
.L9:
            tst.w   D3
            bne.b   .L4
.L10:
            not.b   D6
            bne.w   .L1
            clr.w   D0
            bsr.w   XFFlush
.L11:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtendFile:
            move.l  ($768).w,-(SP)
            rts
vExtendFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/D7/A0-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.l  ($C,A3),-(A6)
            btst    #0,D3
            beq.b   .L1
            move.w  ($2A,A2),D0
            mulu.w  ($1E,A2),D0
            cmp.l   D4,D0
            bcc.b   .L1
            moveq   #-$22,D0
            bra.w   .L15
.L1:
            bset    #6,(A4)
            btst    #1,D3
            beq.b   .L2
            bset    #7,(A4)
.L2:
            move.l  ($1C,A2),D0
            add.l   D0,D4
            subq.l  #1,D4
            divu.w  D0,D4
            mulu.w  D0,D4
            move.l  ($C,A3),D0
            add.l   D4,D0
            subq.l  #1,D0
            bsr.w   sub_4081285E
            bne.b   .L3
            add.l   D4,($C,A3)
            bset    #7,(4,A3)
            bra.w   .L14
.L3:
            cmpi.w  #$10,D0
            bne.w   .L15
            move.l  D2,D7
            move.w  D3,D6
            move.w  D6,D0
            mulu.w  ($1E,A2),D0
            sub.l   ($C,A3),D0
            beq.b   .L4
            add.l   D0,($C,A3)
            bset    #7,(4,A3)
            sub.l   D0,D4
.L4:
            move.w  (0,A1,D1.w),D5
            add.w   (2,A1,D1.w),D5
.L5:
            move.w  D5,D2
            btst    #6,(A4)
            sne     D3
            jsr     (BlkAlloc.w,PC)
            beq.b   .L6
            cmpi.w  #$FFDE,D0
            bne.w   .L15
            bclr    #6,(A4)
            beq.w   .L15
            btst    #7,(A4)
            bne.w   .L15
            bra.b   .L5
.L6:
            cmp.w   D2,D5
            bne.b   .L7
            add.w   D3,(2,A1,D1.w)
            bra.b   .L9
.L7:
            tst.w   (2,A1,D1.w)
            beq.b   .L8
            addq.w  #4,D1
            cmpi.w  #8,D1
            bgt.b   .L10
.L8:
            move.w  D2,(0,A1,D1.w)
            move.w  D3,(2,A1,D1.w)
.L9:
            move.l  D7,D2
            bsr.w   XRUpdate
            bne.w   .L15
            move.l  D2,D7
            bra.b   .L13
.L10:
            move.l  (A3),D5
            cmpi.l  #3,D5
            bne.b   .L11
            moveq   #$11,D0
            bra.b   .L15
.L11:
            lea     (2,A4),A0
            lea     ($A,A4),A1
            move.b  #7,(A0)
            clr.b   (1,A0)
            btst    #1,(4,A3)
            sne     (1,A0)
            move.l  D5,(2,A0)
            move.w  D6,(6,A0)
            move.w  #5,D0
.L12:
            clr.w   (A1)+
            dbra    D0,.L12
            lea     ($A,A4),A1
            clr.w   D1
            move.w  D2,(0,A1,D1.w)
            move.w  D3,(2,A1,D1.w)
            move.l  D1,-(A6)
            move.w  #$C,D1
            move.w  ($A4,A2),D0
            jsr     (BTINSERT.w,PC)
            move.l  (A6)+,D1
            tst.w   D0
            bne.b   .L15
            move.l  D2,D7
.L13:
            add.w   D3,D6
            mulu.w  ($1E,A2),D3
            add.l   D3,($C,A3)
            bset    #7,(4,A3)
            sub.l   D3,D4
            bgt.w   .L4
            add.l   D4,($C,A3)
.L14:
            clr.w   D0
            bsr.w   XFFlush
.L15:
            move.l  ($C,A3),D6
            move.l  (A6)+,D1
            sub.l   D1,D6
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D5/D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FXMKeyCmp:
            movem.l A0-A1,-(SP)
            move.l  (2,A0),D0
            cmp.l   (2,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            move.b  (1,A0),D0
            cmp.b   (1,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            move.w  (6,A0),D0
            cmp.w   (6,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            clr.w   D0
            bra.b   .L3
.L1:
            move.w  #$FFFF,D0
            bra.b   .L3
.L2:
            move.w  #1,D0
.L3:
            movem.l (SP)+,A0-A1
            tst.w   D0
            rts
MapFBlock:
            move.l  ($7D0).w,-(SP)
            rts
vMapFBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/D4-D5/D7/A0-A1/A3-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.l  D5,D0
            bsr.w   sub_4081285E
            bne.b   .L3
            lea     (0,A1,D1.w),A1
            move.w  D3,D1
            sub.w   (2,A1),D1
            move.w  D3,D2
            mulu.w  ($1E,A2),D2
            move.l  ($C,A3),D0
            cmp.l   D0,D2
            ble.b   .L1
            move.l  D0,D2
.L1:
            divu.w  ($1E,A2),D2
            move.l  ($1C,A2),D6
            divu.w  #$200,D6
            moveq   #0,D7
            move.w  ($24,A2),D7
            move.l  D5,D3
            divu.w  ($1E,A2),D3
            swap    D3
            moveq   #0,D0
            move.w  D3,D0
            lsr.l   #8,D0
            lsr.l   #1,D0
            swap    D3
            sub.w   D1,D3
            add.w   (A1),D3
            mulu.w  D6,D3
            add.l   D0,D3
            add.l   D7,D3
            move.w  D2,D6
            mulu.w  ($1E,A2),D6
            sub.l   D5,D6
            cmp.l   D4,D6
            bcs.b   .L2
            move.l  D4,D6
.L2:
            moveq   #0,D0
.L3:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D2/D4-D5/D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TruncateFile:
            move.l  ($76C).w,-(SP)
            rts
vTruncateFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.b  D2,D6
            move.l  D3,D5
            move.l  ($1C,A2),D0
            add.l   D0,D5
            subq.l  #1,D5
            divu.w  D0,D5
            mulu.w  D0,D5
            move.l  D5,D0
            subq.l  #1,D0
            bge.b   .L1
            move.l  D5,($C,A3)
            bset    #7,(4,A3)
            suba.l  A0,A0
            moveq   #0,D7
            lea     ($26,A3),A1
            clr.w   D4
            bra.w   .L7
.L1:
            bsr.w   sub_4081285E
            bne.w   .L14
            move.l  D2,D7
            move.w  D3,D4
            move.l  D5,($C,A3)
            bset    #7,(4,A3)
            btst    #0,D6
            beq.b   .L2
            move.w  (2,A1,D1.w),D3
            bra.w   .L9
.L2:
            move.l  D5,D0
            subq.l  #1,D0
            divu.w  ($1E,A2),D0
            sub.w   D0,D3
            subq.w  #1,D3
            beq.b   .L3
            move.w  (0,A1,D1.w),D2
            add.w   (2,A1,D1.w),D2
            sub.w   D3,D2
            jsr     (BLKDEALLOC.w,PC)
            bne.w   .L14
.L3:
            move.w  D3,D0
            move.w  (2,A1,D1.w),D3
            sub.w   D0,(2,A1,D1.w)
            bne.b   .L9
            clr.w   (0,A1,D1.w)
            bra.b   .L9
.L4:
            lea     (2,A4),A0
            move.b  #7,(A0)
            btst    #1,(4,A3)
            sne     (1,A0)
            move.l  (A3),(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     (BTSEARCH.w,PC)
            beq.b   .L5
            cmpi.w  #$20,D0
            beq.b   .L13
            bra.b   .L14
.L5:
            move.l  D2,D7
            lea     ($A,A4),A0
            moveq   #2,D0
.L6:
            move.l  (A1)+,(A0)+
            dbra    D0,.L6
            lea     (2,A4),A0
            lea     ($A,A4),A1
.L7:
            clr.w   D1
.L8:
            move.w  (0,A1,D1.w),D2
            move.w  (2,A1,D1.w),D3
            beq.b   .L10
            jsr     (BLKDEALLOC.w,PC)
            bne.b   .L14
            clr.l   (0,A1,D1.w)
            add.w   D3,D4
.L9:
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L8
.L10:
            tst.w   (2,A1)
            beq.b   .L11
            move.l  D7,D2
            bsr.w   XRUpdate
            bra.b   .L12
.L11:
            move.l  A0,D0
            beq.b   .L12
            move.w  ($A4,A2),D0
            jsr     (BTDelete.w,PC)
            bne.b   .L14
.L12:
            tst.w   D3
            bne.w   .L4
.L13:
            clr.w   D0
            bsr.b   XFFlush
.L14:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FXSetUp:
            suba.w  #$16,A6
            movea.l A6,A4
            clr.b   (A4)
            rts
XFFlush:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  ($A4,A2),D1
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
sub_4081285E:
            move.l  ($7D4).w,-(SP)
            rts
vXFSearch:
            move.l  (SP)+,-(A6)
            movem.l D4-D6,-(A6)
            move.l  D0,D4
            divu.w  ($1E,A2),D4
            move.l  (A3),D5
            suba.l  A0,A0
            moveq   #0,D2
            lea     ($26,A3),A1
            move.w  D4,D0
            clr.w   D3
            bsr.w   XRSearch
            beq.w   .L6
            cmpi.w  #8,D1
            blt.w   .L7
            tst.w   (2,A1,D1.w)
            beq.w   .L7
            cmpi.l  #3,D5
            beq.w   .L7
            lea     (2,A4),A0
            move.b  #7,(A0)
            btst    #1,(4,A3)
            sne     D6
            move.b  D6,(1,A0)
            move.l  D5,(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     (BTSEARCH.w,PC)
            beq.b   .L3
            cmpi.w  #$20,D0
            bne.b   .L7
            move.w  ($A4,A2),D0
            moveq   #-1,D1
            jsr     (BTGetRecord.w,PC)
            beq.b   .L1
            cmpi.w  #$20,D0
            beq.b   .L2
            bra.b   .L7
.L1:
            cmp.l   (2,A0),D5
            bne.b   .L2
            cmp.b   (1,A0),D6
            beq.b   .L3
.L2:
            suba.l  A0,A0
            moveq   #0,D2
            lea     ($26,A3),A1
            move.w  #8,D1
            moveq   #$10,D0
            bra.b   .L7
.L3:
            move.l  A1,-(SP)
            lea     (2,A4),A1
            moveq   #1,D0
.L4:
            move.l  (A0)+,(A1)+
            dbra    D0,.L4
            movea.l (SP)+,A0
            lea     ($A,A4),A1
            moveq   #2,D0
.L5:
            move.l  (A0)+,(A1)+
            dbra    D0,.L5
            lea     (2,A4),A0
            lea     ($A,A4),A1
            move.w  (6,A0),D3
            move.w  D4,D0
            bsr.b   XRSearch
            bne.b   .L7
.L6:
            clr.w   D0
.L7:
            movem.l (A6)+,D4-D6
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
XRSearch:
            move.l  D2,-(SP)
            move.w  D0,D2
            clr.w   D1
.L1:
            move.w  (2,A1,D1.w),D0
            beq.b   .L2
            add.w   D0,D3
            cmp.w   D2,D3
            bhi.b   .L4
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L1
.L2:
            subq.w  #4,D1
            bge.b   .L3
            clr.w   D1
.L3:
            moveq   #$10,D0
            bra.b   .L5
.L4:
            clr.w   D0
.L5:
            move.l  (SP)+,D2
            tst.w   D0
            rts
XRUpdate:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            move.l  A0,D0
            bne.b   .L1
            bset    #7,(4,A3)
            bra.b   .L3
.L1:
            move.w  ($A4,A2),D0
            jsr     (BTSEARCH.w,PC)
            bne.b   .L4
            lea     ($A,A4),A0
            moveq   #2,D0
.L2:
            move.l  (A0)+,(A1)+
            dbra    D0,.L2
            move.w  ($A4,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            ds.b    14

            EVEN
