            include "Include/ROMHeader.s"

            EXPORT  vGetNode,vRelNode,BTMaint2,ClrNode,DeleteRec,GetLtSib
            EXPORT  GetMaxKey,GetNode,GetRecA,GetRtSib,InitNode,InsertRec
            EXPORT  LocBTCB,LocRec,LocTPR,RelNode,SearchNode,UpdDRec
            EXPORT  UpdIKey,GetNodeSiz

            IMPORT  GetBlock,RelBlock

            SECTION "BTMaint2",CODE

BTMaint2:
BuildIRec:
            move.l  D2,-(SP)
            move.l  D0,D2
            clr.w   D0
            bsr.w   GetRecA
            movea.l ($C,A4),A1
            lea     ($30,A1),A1
            jsr     UpdIKey
            bsr.w   GetMaxKey
            move.l  D2,(0,A1,D0.w)
            move.l  (SP)+,D2
            rts
ChkNode:
            movem.l D1-D2/A0-A2,-(SP)
            move.w  (2,A4),D1
            movea.l ($34E).w,A2
            move.l  ($C,A2,D1.w),D0
            divu.w  ($2A,A4),D0
            moveq   #0,D1
            move.w  D0,D1
            cmp.l   (A1),D1
            bls.b   .L2
            cmp.l   (4,A1),D1
            bls.b   .L2
            move.b  (8,A1),D0
            addq.b  #1,D0
            cmpi.b  #3,D0
            bhi.b   .L2
            move.b  (9,A1),D0
            cmp.b   ($19,A4),D0
            bhi.b   .L2
            moveq   #0,D1
            move.w  ($2A,A4),D1
            moveq   #-$E,D0
            add.l   D1,D0
            divu.w  #6,D0
            cmp.w   ($A,A1),D0
            bcs.b   .L2
            move.w  ($A,A1),D1
            move.w  D1,D0
            bsr.w   GetOffset
            moveq   #2,D2
            add.l   A0,D2
            sub.l   A1,D2
.L1:
            move.w  (A0)+,D0
            btst    #0,D0
            bne.b   .L2
            cmpi.w  #$E,D0
            bcs.b   .L2
            cmp.w   D2,D0
            bcc.b   .L2
            move.w  D0,D2
            dbra    D1,.L1
            bra.b   .L3
.L2:
            moveq   #$24,D0
            bra.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (SP)+,D1-D2/A0-A2
            tst.w   D0
            rts
ClrNode:
            movem.l D0-D1/A0,-(SP)
            moveq   #3,D1
            add.w   ($2A,A4),D1
            lsr.w   #2,D1
            subq.w  #1,D1
            moveq   #0,D0
.L1:
            move.l  D0,(A0)+
            dbra    D1,.L1
            movem.l (SP)+,D0-D1/A0
            rts
DeleteRec:
            movem.l D2-D6/A2-A5,-(SP)
            move.w  D1,D5
            move.w  D1,D0
            jsr     GetOffset
            move.l  A0,D6
            move.w  D0,D4
            lea     (-2,A0),A3
            move.w  (A3),D3
            move.w  ($A,A1),D0
            jsr     GetOffset
            movea.l A0,A2
            move.w  D0,D2
            movea.l A1,A5
            lea     (0,A5,D3.w),A0
            lea     (0,A5,D4.w),A1
            move.w  D2,D0
            sub.w   D3,D0
            jsr     MovRecLt
            subq.w  #1,($A,A5)
            movea.l A3,A0
            movea.l D6,A1
            move.w  ($A,A5),D0
            sub.w   D5,D0
            move.w  D4,D1
            sub.w   D3,D1
            jsr     MovOffRt
            movem.l (SP)+,D2-D6/A2-A5
            rts
GetLtSib:
            move.l  (SP)+,-(A6)
            movem.l D2-D3,-(A6)
            clr.b   D3
            bra.b   GetRtSib.L1
GetRtSib:
            move.l  (SP)+,-(A6)
            movem.l D2-D3,-(A6)
            moveq   #1,D3
.L1:
            tst.b   D3
            bne.b   .L2
            move.l  (4,A0),D2
            bra.b   .L3
.L2:
            move.l  (A0),D2
.L3:
            bne.b   .L4
            moveq   #0,D1
            bra.b   .L5
.L4:
            moveq   #0,D1
            bsr.b   GetNode
            bne.b   .L6
            move.l  D2,D1
            movea.l A0,A1
.L5:
            clr.w   D0
.L6:
            movem.l (A6)+,D2-D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetMaxKey:
            moveq   #2,D0
            add.w   ($2C,A4),D0
            lsr.w   #1,D0
            lsl.w   #1,D0
            rts
GetNode:
            move.l  ($750).w,-(SP)
            rts
vGetNode:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  (2,A4),D0
            movea.l (8,A4),A1
            jsr     (GetBlock.w,PC)
            bne.b   .L1
            movea.l A0,A1
            bsr.w   ChkNode
            beq.b   .L1
            move.w  D0,-(A6)
            moveq   #2,D1
            movea.l (8,A4),A1
            jsr     (RelBlock.w,PC)
            move.w  (A6)+,D0
.L1:
            movem.l (A6)+,D1/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetNodeSiz:
            move.l  D1,-(SP)
            move.w  ($A,A1),D1
            move.w  D1,D0
            jsr     GetOffset
            subi.w  #$E,D0
            lsl.w   #1,D1
            add.w   D1,D0
            move.l  (SP)+,D1
            rts
GetOffset:
            bsr.b   GetOffA
            move.w  (A0),D0
            rts
GetOffA:
            suba.l  A0,A0
            movea.w ($2A,A4),A0
            adda.l  A1,A0
            lsl.w   #1,D0
            neg.w   D0
            lea     (-2,A0,D0.w),A0
            rts
GetRecA:
            movem.l D1-D2,-(SP)
            move.w  D0,D1
            bsr.b   GetOffset
            move.w  D0,D2
            move.w  D1,D0
            addq.w  #1,D0
            bsr.b   GetOffset
            sub.w   D2,D0
            lea     (0,A1,D2.w),A0
            movem.l (SP)+,D1-D2
            rts
InitNode:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            move.l  D1,D2
            move.w  (2,A4),D0
            moveq   #4,D1
            movea.l (8,A4),A1
            jsr     (GetBlock.w,PC)
            bne.b   .L1
            bsr.w   ClrNode
            move.w  ($2A,A4),D2
            move.w  #$E,(-2,A0,D2.w)
            clr.w   D0
.L1:
            movem.l (A6)+,D1-D2/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
InsertRec:
            movem.l D1-D7/A1-A5,-(SP)
            move.w  D0,D7
            move.w  D1,D6
            move.l  A0,D5
            move.w  D1,D0
            jsr     GetOffset
            move.w  D0,D4
            move.w  ($A,A1),D0
            jsr     GetOffset
            movea.l A0,A3
            move.w  D0,D3
            move.l  A3,D1
            moveq   #0,D0
            move.w  D3,D0
            add.l   A1,D0
            sub.l   D0,D1
            moveq   #2,D0
            add.w   D7,D0
            cmp.w   D0,D1
            bge.b   .L1
            moveq   #-1,D0
            bra.b   .L2
.L1:
            movea.l A1,A5
            lea     (0,A5,D4.w),A0
            lea     (0,A0,D7.w),A1
            move.w  D3,D0
            sub.w   D4,D0
            jsr     MovRecRt
            movea.l A3,A0
            lea     (-2,A0),A1
            move.w  ($A,A5),D0
            sub.w   D6,D0
            move.w  D7,D1
            jsr     MovOffLt
            movea.l D5,A0
            lea     (0,A5,D4.w),A1
            move.w  D7,D0
            jsr     MovRecLt
            addq.w  #1,($A,A5)
            clr.w   D0
.L2:
            movem.l (SP)+,D1-D7/A1-A5
            tst.w   D0
            rts
LocBTCB:
            movea.l ($34E).w,A4
            movea.l ($22,A4,D0.w),A4
            rts
LocRec:
            movem.l D0/D2-D3,-(SP)
            move.w  D1,D3
            move.w  D3,D0
            jsr     GetRecA
            move.l  A0,D2
            move.w  D3,D0
            addq.w  #1,D0
            jsr     GetRecA
            move.l  A0,D1
            movea.l D2,A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #2,D0
            lsr.l   #1,D0
            lsl.l   #1,D0
            sub.l   D2,D1
            sub.l   D0,D1
            movea.l A0,A1
            adda.l  D0,A1
            movem.l (SP)+,D0/D2-D3
            rts
LocTPR:
            subq.w  #1,D0
            mulu.w  #6,D0
            movea.l ($C,A4),A0
            lea     (0,A0,D0.l),A0
            rts
MovOffLt:
            movem.l D0-D2/A0-A1,-(SP)
.L1:
            move.w  (A0)+,D2
            add.w   D1,D2
            move.w  D2,(A1)+
            dbra    D0,.L1
            bra.b   MovOffRt.L2
MovOffRt:
            movem.l D0-D2/A0-A1,-(SP)
            cmpm.w  (A0)+,(A1)+
.L1:
            move.w  -(A0),D2
            add.w   D1,D2
            move.w  D2,-(A1)
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D2/A0-A1
            rts
MovRecLt:
            movem.l D0-D1/A0-A1,-(SP)
            tst.w   D0
            ble.b   .L2
            subq.w  #1,D0
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
MovRecRt:
            movem.l D0-D1/A0-A1,-(SP)
            tst.w   D0
            ble.b   .L2
            adda.w  D0,A0
            adda.w  D0,A1
            subq.w  #1,D0
.L1:
            move.b  -(A0),-(A1)
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
RelNode:
            move.l  ($754).w,-(SP)
            rts
vRelNode:
            move.l  (SP)+,-(A6)
            move.l  A1,-(A6)
            move.l  A0,D0
            beq.b   .L1
            jsr     (RelBlock.w,PC)
.L1:
            movea.l (A6)+,A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
SearchNode:
            movem.l D2-D5/A1-A3,-(SP)
            movea.l A0,A3
            movea.l A1,A2
            move.l  (4,A4),D5
            clr.w   D2
            move.w  ($A,A2),D3
            subq.w  #1,D3
            cmp.w   D3,D2
            bgt.b   .L4
.L1:
            move.w  D2,D4
            add.w   D3,D4
            lsr.w   #1,D4
            move.w  D4,D0
            movea.l A2,A1
            jsr     GetRecA
            movea.l A0,A1
            movea.l A3,A0
            move.l  A4,-(SP)
            movea.l D5,A4
            jsr     (A4)
            movea.l (SP)+,A4
            tst.w   D0
            beq.b   .L2
            bgt.b   .L3
            move.w  D4,D3
            subq.w  #1,D3
            cmp.w   D3,D2
            ble.b   .L1
            bra.b   .L4
.L2:
            clr.w   D0
            bra.b   .L5
.L3:
            move.w  D4,D2
            addq.w  #1,D2
            cmp.w   D3,D2
            ble.b   .L1
.L4:
            move.w  D2,D4
            moveq   #$20,D0
.L5:
            move.w  D4,D1
            movem.l (SP)+,D2-D5/A1-A3
            tst.w   D0
            rts
UpdDRec:
            movem.l D0-D1/A0-A2,-(SP)
            movea.l A0,A2
            jsr     LocRec
            move.l  A2,D1
            beq.b   .L2
            movea.l D1,A0
            ext.l   D0
            _BlockMove
            bra.b   .L3
.L1:
            clr.b   (A1)+
.L2:
            dbra    D0,.L1
.L3:
            movem.l (SP)+,D0-D1/A0-A2
            rts
UpdIKey:
            movem.l D0-D1/A0-A2,-(SP)
            movea.l A0,A2
            move.w  ($2C,A4),D1
            move.b  D1,(A1)+
            movea.l A2,A0
            move.b  (A0)+,D0
            ext.w   D0
            sub.w   D0,D1
            bge.b   .L2
            add.w   D1,D0
            bra.b   .L2
.L1:
            move.b  (A0)+,(A1)+
.L2:
            dbra    D0,.L1
            tst.w   D1
            ble.b   .L5
            bra.b   .L4
.L3:
            clr.b   (A1)+
.L4:
            dbra    D1,.L3
.L5:
            movem.l (SP)+,D0-D1/A0-A2
            rts
            dc.w    0

            EVEN
