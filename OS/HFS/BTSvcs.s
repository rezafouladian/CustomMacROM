            include "Include/ROMHeader.s"

            EXPORT  vBTClose,vBTDelete,VBTFLUSH,vBTGetRecord,VBTINSERT,VBTOPEN
            EXPORT  vBTSearch,vBTUpdate,BTFlush,BTGetRecord,BTOPEN,BTSEARCH
            EXPORT  BTSvcs,BTDelete,BTINSERT,BTUpdate

            IMPORT  BTAlloc,ExtBTFile,FreeNode,BTMAINT1,SPLITLT,TreeSearch
            IMPORT  BTMaint2,ClrNode,DeleteRec,GetLtSib,GetMaxKey,GetNode
            IMPORT  GetRecA,GetRtSib,InitNode,InsertRec,LocBTCB,LocRec
            IMPORT  LocTPR,RelNode,SearchNode,UpdDRec,UpdIKey,FlushCache
            IMPORT  GetBlock,MarkBlock,RelBlock

            SECTION "BTSvcs",CODE

BTSvcs:
; BTClose
; Closes a BTree file.
BTClose:
            move.l  ($730).w,-(SP)
            rts
vBTClose:
            move.l  (SP)+,-(A6)
            movem.l D1-D4/A0-A4,-(A6)
            move.w  D0,D3
            move.w  D3,D0
            jsr     (LocBTCB.w,PC)
            jsr     BTFlush
            bne.b   .BCExit
            move.w  D3,D0
            moveq   #1,D1
            movea.l (8,A4),A1
            jsr     (FlushCache.w,PC)
            bne.b   .BCExit
            movea.l A4,A0
            _DisposPtr
            movea.l ($34E).w,A4
            clr.l   ($22,A4,D3.w)
            clr.w   D0
.BCExit:
            movem.l (A6)+,D1-D4/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTDelete:
            move.l  ($734).w,-(SP)
            rts
vBTDelete:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/A0-A4,-(A6)
            bsr.w   BTSetUp
            clr.l   ($12,A4)
            suba.l  A2,A2
            suba.l  A3,A3
            jsr     (TreeSearch.w,PC)
            movea.l A1,A3
            bne.w   .BDExit1
            move.w  D1,D5
.BDDelete:
            movea.l A3,A1
            move.w  D5,D1
            jsr     (DeleteRec.w,PC)
            movea.l A3,A0
            jsr     (MarkBlock.w,PC)
            tst.w   D5
            bne.b   .L1
            bset    #6,(A4)
.L1:
            cmpi.b  #$FF,(8,A3)
            bne.b   .BDRemove
            subq.l  #1,($1E,A4)
.BDRemove:
            tst.w   ($A,A3)
            bgt.b   .BDNxtLev
            movea.l A3,A0
            jsr     (GetLtSib.w,PC)
            bne.w   .BDExit1
            tst.l   D1
            beq.b   .L4
            move.l  (A3),(A1)
            moveq   #4,D1
            movea.l A1,A0
            jsr     (RelNode.w,PC)
.L4:
            movea.l A3,A0
            jsr     (GetRtSib.w,PC)
            bne.w   .BDExit1
            tst.l   D1
            beq.b   .BDUpdPtrs
            move.l  (4,A3),(4,A1)
            moveq   #4,D1
            movea.l A1,A0
            jsr     (RelNode.w,PC)
.BDUpdPtrs:
            cmpi.b  #$FF,(8,A3)
            bne.b   .BDFree
            tst.l   (4,A3)
            bne.b   .L6
            move.l  (A3),($22,A4)
.L6:
            tst.l   (A3)
            bne.b   .BDFree
            move.l  (4,A3),($26,A4)
.BDFree:
            movea.l A3,A0
            jsr     (ClrNode.w,PC)
            moveq   #4,D1
            jsr     (RelNode.w,PC)
            suba.l  A3,A3
            move.w  ($10,A4),D0
            jsr     (LocTPR.w,PC)
            move.l  (A0),D1
            move.w  (2,A4),D0
            jsr     (FreeNode.w,PC)
            bset    #4,(A4)
            bclr    #6,(A4)
.BDNxtLev:
            subq.w  #1,($10,A4)
            beq.b   .BDRoot
            btst    #6,(A4)
            bne.b   .L9
            btst    #4,(A4)
            beq.w   .BDExit
.L9:
            move.w  ($10,A4),D0
            jsr     (LocTPR.w,PC)
            move.w  (4,A0),D5
            move.l  (A0),D2
            moveq   #0,D1
            jsr     (GetNode.w,PC)
            bne.w   .BDExit1
            movea.l A0,A2
.BDUpdKey:
            btst    #6,(A4)
            beq.b   .L10
            move.w  D5,D0
            movea.l A2,A1
            jsr     (GetRecA.w,PC)
            move.l  A0,-(SP)
            movea.l A3,A1
            clr.w   D0
            jsr     (GetRecA.w,PC)
            movea.l (SP)+,A1
            jsr     (UpdIKey.w,PC)
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
            tst.w   D5
            beq.b   .L10
            bclr    #6,(A4)
.L10:
            moveq   #0,D1
            movea.l A3,A0
            jsr     (RelNode.w,PC)
            movea.l A2,A3
            move.l  D2,D3
            bclr    #4,(A4)
            beq.b   .L11
            bra.w   .BDDelete
.L11:
            btst    #6,(A4)
            bne.b   .BDNxtLev
            bra.b   .BDExit
.BDRoot:
            move.l  A3,D0
            bne.b   .BDUpdDepth
            clr.w   ($18,A4)
            clr.l   ($1A,A4)
            bra.b   .BDExit
.BDUpdDepth:
            cmpi.w  #1,($A,A3)
            bgt.b   .BDExit
            tst.b   (8,A3)
            bne.b   .BDExit
            subq.w  #1,($18,A4)
            moveq   #0,D1
            movea.l A3,A1
            jsr     (LocRec.w,PC)
            move.l  (A1),($1A,A4)
            movea.l A3,A0
            jsr     (ClrNode.w,PC)
            moveq   #4,D1
            jsr     (RelNode.w,PC)
            suba.l  A3,A3
            move.l  D3,D1
            move.w  (2,A4),D0
            jsr     (FreeNode.w,PC)
            move.l  ($1A,A4),D3
            move.l  D3,D2
            moveq   #0,D1
            jsr     (GetNode.w,PC)
            bne.b   .BDExit1
            movea.l A0,A3
            bra.b   .BDUpdDepth
.BDExit:
            bset    #7,(A4)
            clr.w   D0
.BDExit1:
            move.w  D0,-(A6)
            movea.l A3,A0
            moveq   #0,D1
            jsr     (RelNode.w,PC)
            move.w  (A6)+,D0
            bsr.w   BTCleanUp
            movem.l (A6)+,D1-D5/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTFlush:
            move.l  ($738).w,-(SP)
            rts
VBTFLUSH:
            move.l  (SP)+,-(A6)
            movem.l D1-D4/A0-A4,-(A6)
            move.w  D0,D3
            movea.l ($34E).w,A1
            movea.l ($14,A1,D3.w),A2
            tst.w   ($48,A2)
            beq.b   .L3
            jsr     (LocBTCB.w,PC)
            bclr    #7,(A4)
            beq.b   .L2
            moveq   #0,D1
            moveq   #0,D2
            jsr     (GetNode.w,PC)
            bne.b   .L3
            movea.l A0,A3
            move.w  #$1D,D0
            lea     ($18,A4),A0
            lea     ($E,A3),A1
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
            moveq   #4,D1
            movea.l A3,A0
            jsr     (RelNode.w,PC)
            bne.b   .L3
.L2:
            move.w  D3,D0
            moveq   #0,D1
            movea.l (8,A4),A1
            jsr     (FlushCache.w,PC)
.L3:
            movem.l (A6)+,D1-D4/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTGetRecord:
            move.l  ($73C).w,-(SP)
            rts
vBTGetRecord:
            move.l  (SP)+,-(A6)
            movem.l D3-D5/A2-A4,-(A6)
            bsr.w   BTSetUp
            move.w  D1,D5
            suba.l  A3,A3
            move.w  ($16,A4),D4
            move.l  ($12,A4),D3
            bne.b   .L1
            moveq   #$20,D0
            bra.b   .GRExit1
.L1:
            add.w   D5,D4
.L2:
            bsr.b   GRGetNode
            bne.b   .GRExit1
.L3:
            tst.w   D4
            blt.b   .L5
            move.w  ($A,A3),D1
            cmp.w   D1,D4
            blt.b   .L8
            move.l  (A3),D0
            beq.b   .L4
            move.l  D0,D3
            sub.w   D1,D4
            bra.b   .L2
.L4:
            move.w  D1,D4
            subq.w  #1,D4
            bra.b   .L7
.L5:
            move.l  (4,A3),D0
            beq.b   .L6
            move.l  D0,D3
            bsr.b   GRGetNode
            bne.b   .GRExit1
            add.w   ($A,A3),D4
            bra.b   .L3
.L6:
            moveq   #0,D4
.L7:
            move.l  D3,($12,A4)
            move.w  D4,($16,A4)
            moveq   #$20,D0
            bra.b   .GRExit1
.L8:
            move.w  D4,D1
            movea.l A3,A1
            jsr     (LocRec.w,PC)
            move.l  D3,($12,A4)
            move.w  D4,($16,A4)
            clr.w   D0
.GRExit1:
            movem.l D0-D1/A0-A1,-(A6)
            bsr.b   GRRelNode
            movem.l (A6)+,D0-D1/A0-A1
            move.l  D3,D2
            bsr.w   BTCleanUp
            movem.l (A6)+,D3-D5/A2-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GRGetNode:
            move.l  (SP)+,-(A6)
            bsr.b   GRRelNode
            moveq   #0,D1
            move.l  D3,D2
            jsr     (GetNode.w,PC)
            bne.b   .L1
            movea.l A0,A3
.L1:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GRRelNode:
            move.l  (SP)+,-(A6)
            moveq   #0,D1
            movea.l A3,A0
            jsr     (RelNode.w,PC)
            suba.l  A3,A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTINSERT:
            move.l  ($740).w,-(SP)
            rts
VBTINSERT:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A4,-(A6)
            jsr     (LocBTCB.w,PC)
            move.l  A1,D7
            move.w  D1,D6
            move.l  A0,D5
            moveq   #1,D3
            add.w   ($18,A4),D3
            cmp.l   ($32,A4),D3
            ble.b   .L2
.L1:
            jsr     (ExtBTFile.w,PC)
            bne.w   .L18
            cmp.l   ($32,A4),D3
            bgt.b   .L1
.L2:
            move.w  (2,A4),D0
            bsr.w   BTSetUp
            movem.l D6-D7,-(A6)
            moveq   #0,D4
            suba.l  A2,A2
            suba.l  A3,A3
            clr.l   ($12,A4)
            movea.l ($C,A4),A1
            lea     ($30,A1),A1
            movea.l D5,A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #2,D0
            lsr.l   #1,D0
            lsl.l   #1,D0
            add.w   D0,D6
            _BlockMove
            addq.w  #1,D6
            lsr.w   #1,D6
            lsl.w   #1,D6
            move.l  A1,D7
            jsr     (TreeSearch.w,PC)
            movea.l A1,A3
            bne.b   .L3
            moveq   #$21,D0
            bra.w   .L17
.L3:
            cmpi.w  #$20,D0
            bne.w   .L17
            move.l  D2,D3
            move.w  D1,D5
            tst.w   ($10,A4)
            bgt.b   .L4
            move.w  (2,A4),D0
            jsr     (BTAlloc.w,PC)
            bne.w   .L17
            move.l  D1,D3
            jsr     (InitNode.w,PC)
            bne.w   .L17
            movea.l A0,A3
            move.b  #$FF,(8,A3)
            moveq   #1,D0
            move.b  D0,(9,A3)
            move.w  D0,($18,A4)
            move.l  D3,($1A,A4)
            move.l  D3,($22,A4)
            move.l  D3,($26,A4)
            move.w  #1,($10,A4)
.L4:
            movea.l D7,A0
            move.w  D6,D0
            movea.l A3,A1
            move.w  D5,D1
            jsr     (InsertRec.w,PC)
            bne.b   .L5
            tst.w   D5
            bne.b   .L9
            bset    #6,(A4)
            bra.b   .L9
.L5:
            movea.l A3,A0
            jsr     (GetLtSib.w,PC)
            bne.w   .L17
            tst.l   D1
            beq.b   .L6
            move.l  D1,D2
            movea.l A1,A2
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     (BTMAINT1.w,PC)
            bne.b   .L6
            bra.b   .L8
.L6:
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     (SPLITLT.w,PC)
            beq.b   .L7
            moveq   #$23,D0
            bra.w   .L17
.L7:
            bset    #5,(A4)
.L8:
            bset    #6,(A4)
            move.w  D1,D5
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
.L9:
            movea.l A3,A0
            jsr     (MarkBlock.w,PC)
            cmpi.b  #$FF,(8,A1)
            bne.b   .L11
            movem.l (A6),D0/A0
            jsr     (UpdDRec.w,PC)
            addq.l  #1,($1E,A4)
            move.w  D5,($16,A4)
            move.l  D3,D0
            cmpa.l  A3,A1
            beq.b   .L10
            move.l  D2,D0
.L10:
            move.l  D0,($12,A4)
.L11:
            btst    #6,(A4)
            bne.b   .L12
            btst    #5,(A4)
            beq.w   .L16
.L12:
            subq.w  #1,($10,A4)
            beq.w   .L15
            move.w  ($10,A4),D0
            jsr     (LocTPR.w,PC)
            move.w  (4,A0),D5
            move.l  (A0),D3
            move.l  D2,-(A6)
            moveq   #0,D1
            move.l  D3,D2
            jsr     (GetNode.w,PC)
            bne.w   .L17
            move.l  A0,D4
            move.l  (A6)+,D2
            btst    #6,(A4)
            beq.b   .L13
            move.w  D5,D0
            movea.l D4,A1
            jsr     (GetRecA.w,PC)
            move.l  A0,-(SP)
            movea.l A3,A1
            clr.w   D0
            jsr     (GetRecA.w,PC)
            movea.l (SP)+,A1
            jsr     (UpdIKey.w,PC)
            movea.l D4,A0
            jsr     (MarkBlock.w,PC)
            tst.w   D5
            beq.b   .L13
            bclr    #6,(A4)
.L13:
            moveq   #0,D1
            movea.l A3,A0
            jsr     (RelNode.w,PC)
            movea.l D4,A3
            moveq   #0,D4
            btst    #5,(A4)
            beq.b   .L14
            movea.l A2,A1
            move.l  D2,D0
            jsr     (BTMaint2.w,PC)
.L14:
            moveq   #0,D1
            movea.l A2,A0
            jsr     (RelNode.w,PC)
            suba.l  A2,A2
            btst    #5,(A4)
            beq.w   .L11
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            move.l  A0,D7
            jsr     (GetMaxKey.w,PC)
            addq.w  #4,D0
            move.w  D0,D6
            bclr    #5,(A4)
            bra.w   .L4
.L15:
            btst    #5,(A4)
            beq.b   .L16
            move.w  (2,A4),D0
            jsr     (BTAlloc.w,PC)
            bne.b   .L17
            move.l  D1,D3
            move.l  D3,D1
            jsr     (InitNode.w,PC)
            bne.b   .L17
            move.l  A0,D4
            clr.b   (8,A0)
            moveq   #1,D0
            add.w   ($18,A4),D0
            move.b  D0,(9,A0)
            movea.l A2,A1
            move.l  D2,D0
            jsr     (BTMaint2.w,PC)
            jsr     (GetMaxKey.w,PC)
            addq.w  #4,D0
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            movea.l D4,A1
            clr.w   D1
            jsr     (InsertRec.w,PC)
            move.w  #1,D0
            jsr     (LocTPR.w,PC)
            move.l  (A0),D0
            movea.l A3,A1
            jsr     (BTMaint2.w,PC)
            jsr     (GetMaxKey.w,PC)
            addq.w  #4,D0
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            movea.l D4,A1
            move.w  #1,D1
            jsr     (InsertRec.w,PC)
            movea.l D4,A0
            jsr     (MarkBlock.w,PC)
            addq.w  #1,($18,A4)
            move.l  D3,($1A,A4)
.L16:
            bset    #7,(A4)
            clr.w   D0
.L17:
            move.w  D0,-(A6)
            movea.l A2,A0
            moveq   #0,D1
            jsr     (RelNode.w,PC)
            movea.l A3,A0
            jsr     (RelNode.w,PC)
            movea.l D4,A0
            jsr     (RelNode.w,PC)
            move.w  (A6)+,D0
            move.l  ($12,A4),D2
            clr.l   ($12,A4)
            bsr.w   BTCleanUp
            addq.l  #8,A6
.L18:
            movem.l (A6)+,D1/D3-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTOPEN:
            move.l  ($744).w,-(SP)
            rts
VBTOPEN:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/A0-A4,-(A6)
            move.w  D0,D3
            move.l  A0,D4
            move.l  A1,D5
            moveq   #$36,D0
            _NewPtrSysClear
            bne.w   .L6
            movea.l A0,A4
            movea.l ($34E).w,A3
            move.l  A4,($22,A3,D3.w)
            move.w  D3,(2,A4)
            move.l  D4,(4,A4)
            move.l  D5,(8,A4)
            move.w  D3,D0
            movea.l D5,A1
            moveq   #0,D1
            moveq   #0,D2
            jsr     (GetBlock.w,PC)
            bne.b   .L6
            movea.l A0,A2
            lea     ($E,A2),A0
            move.w  ($12,A0),D0
            beq.b   .L1
            move.w  D0,D1
            andi.w  #$1FF,D1
            bne.b   .L1
            move.l  ($C,A3,D3.w),D2
            divu.w  D0,D2
            swap    D2
            clr.w   D2
            swap    D2
            cmp.l   ($16,A0),D2
            bne.b   .L1
            cmp.l   ($1A,A0),D2
            bcs.b   .L1
            subq.l  #1,D2
            cmpi.b  #8,(A0)
            bhi.b   .L1
            cmp.l   (2,A0),D2
            bcs.b   .L1
            cmp.l   ($A,A0),D2
            bcs.b   .L1
            cmp.l   ($E,A0),D2
            bcc.b   .L2
.L1:
            moveq   #$25,D0
            bra.b   .L4
.L2:
            move.w  #$1D,D0
            lea     ($E,A2),A0
            lea     ($18,A4),A1
.L3:
            move.b  (A0)+,(A1)+
            dbra    D0,.L3
            clr.w   D0
.L4:
            move.w  D0,-(A6)
            movea.l D5,A1
            moveq   #0,D1
            movea.l A2,A0
            jsr     (RelBlock.w,PC)
            beq.b   .L5
            move.w  D0,(A6)
.L5:
            move.w  (A6)+,D0
.L6:
            movem.l (A6)+,D1-D5/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTSEARCH:
            move.l  ($748).w,-(SP)
            rts
vBTSearch:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A2-A4,-(A6)
            bsr.w   BTSetUp
            movea.l A0,A3
            suba.l  A2,A2
            tst.l   D2
            beq.b   .BSTSrch
            moveq   #0,D1
            jsr     (GetNode.w,PC)
            bne.b   .BSExit
            movea.l A0,A2
            cmpi.b  #$FF,(8,A0)
            bne.b   .L1
            tst.w   ($A,A0)
            ble.b   .L1
            movea.l A3,A0
            movea.l A2,A1
            jsr     (SearchNode.w,PC)
            beq.b   .BSTSrch1
.L1:
            movea.l A2,A0
            moveq   #0,D1
            jsr     (RelNode.w,PC)
            bne.b   .BSExit
.BSTSrch:
            movea.l A3,A0
            jsr     (TreeSearch.w,PC)
            movea.l A1,A2
            beq.b   .BSTSrch1
            cmpi.w  #$20,D0
            bne.b   .BSExit1
.BSTSrch1:
            move.w  D1,D5
            move.w  D0,-(A6)
            move.l  D2,($12,A4)
            move.w  D5,($16,A4)
            tst.w   (A6)
            bne.b   .BSExit
            move.w  D5,D0
            movea.l A2,A1
            jsr     (LocRec.w,PC)
.BSExit:
            movem.l D1-D2/A0-A1,-(A6)
            movea.l A2,A0
            moveq   #0,D1
            jsr     (RelNode.w,PC)
            movem.l (A6)+,D1-D2/A0-A1
            move.w  (A6)+,D0
.BSExit1:
            bsr.b   BTCleanUp
            movem.l (A6)+,D3-D7/A2-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTUpdate:
            move.l  ($74C).w,-(SP)
            rts
vBTUpdate:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1/A4,-(A6)
            jsr     (LocBTCB.w,PC)
            moveq   #2,D1
            jsr     (GetNode.w,PC)
            bne.b   .BUExit
            moveq   #4,D1
            jsr     (RelNode.w,PC)
            bne.b   .BUExit
            clr.w   D0
.BUExit:
            movem.l (A6)+,D1/A0-A1/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTCleanUp:
            move.l  D0,-(SP)
            bsr.b   CalBTVars
            adda.l  D0,A6
            clr.l   ($C,A4)
            move.l  (SP)+,D0
            rts
BTSetUp:
            move.l  D0,-(SP)
            jsr     (LocBTCB.w,PC)
            bsr.b   CalBTVars
            suba.l  D0,A6
            move.l  A6,($C,A4)
            bclr    #5,(A4)
            bclr    #4,(A4)
            bclr    #6,(A4)
            move.l  (SP)+,D0
            rts
CalBTVars:
            jsr     (GetMaxKey.w,PC)
            addi.w  #$34,D0
            rts
            ds.b    14

            EVEN
