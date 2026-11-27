            include "Include/ROMHeader.s"

            EXPORT  vTreeSearch,BTMAINT1,SPLITLT,TreeSearch

            IMPORT  BTAlloc,DeleteRec,GetNode,GetNodeSiz,GetRecA,InitNode
            IMPORT  InsertRec,LocRec,LocTPR,RelNode,SearchNode

            SECTION "BTMaint1",CODE

BTMAINT1:
ROTATELT:
            movem.l D2-D7/A2-A5,-(SP)
            movea.l A0,A5
            move.w  D0,D5
            movea.l A2,A1
            jsr     (GetNodeSiz.w,PC)
            move.w  D0,D2
            movea.l A3,A1
            jsr     (GetNodeSiz.w,PC)
            add.w   D2,D0
            add.w   D5,D0
            addq.w  #2,D0
            lsr.w   #1,D0
            move.w  D0,D6
            move.w  ($A,A2),D3
            move.w  D1,D4
            add.w   D3,D4
            moveq   #-1,D7
.L1:
            cmp.w   D3,D4
            bne.b   .L2
            add.w   D5,D2
            bra.b   .L4
.L2:
            move.w  D3,D0
            sub.w   ($A,A2),D0
            cmp.w   D4,D3
            ble.b   .L3
            subq.w  #1,D0
.L3:
            jsr     (GetRecA.w,PC)
            add.w   D0,D2
.L4:
            addq.w  #2,D2
            move.w  ($2A,A4),D1
            subi.w  #$10,D1
            cmp.w   D1,D2
            ble.b   .L5
            swap    D7
            tst.w   D7
            bge.b   .L9
            moveq   #-1,D0
            bra.w   .L16
.L5:
            move.w  D6,D0
            lsl.w   #1,D0
            sub.w   D2,D0
            cmp.w   D1,D0
            bgt.b   .L6
            move.w  D3,D7
.L6:
            cmp.w   D6,D2
            blt.b   .L8
            beq.b   .L7
            swap    D7
.L7:
            tst.w   D7
            bge.b   .L9
            swap    D7
            tst.w   D7
            bge.b   .L9
.L8:
            swap    D7
            move.w  #$FFFF,D7
            addq.w  #1,D3
            move.w  ($A,A2),D1
            add.w   ($A,A3),D1
            cmp.w   D1,D3
            ble.b   .L1
            moveq   #-1,D0
            bra.b   .L16
.L9:
            move.w  ($A,A2),D3
.L10:
            cmp.w   D3,D4
            bne.b   .L11
            movea.l A2,A1
            movea.l A5,A0
            move.w  D5,D0
            move.w  ($A,A1),D1
            jsr     (InsertRec.w,PC)
            bne.b   .L14
            movea.l A1,A5
            move.w  D1,D5
            bra.b   .L12
.L11:
            movea.l A2,A0
            movea.l A3,A1
            bsr.w   RotRecLt
            bne.b   .L14
.L12:
            cmp.w   D7,D3
            beq.b   .L13
            addq.w  #1,D3
            bra.b   .L10
.L13:
            cmp.w   D7,D4
            ble.b   .L15
            movea.l A3,A1
            movea.l A5,A0
            move.w  D5,D0
            move.w  D4,D1
            sub.w   D7,D1
            subq.w  #1,D1
            jsr     (InsertRec.w,PC)
            bne.b   .L14
            clr.w   D0
            bra.b   .L16
.L14:
            moveq   #$40,D0
            _SysError
.L15:
            clr.w   D0
            movea.l A5,A1
            move.w  D5,D1
.L16:
            movem.l (SP)+,D2-D7/A2-A5
            tst.w   D0
            rts
SPLITLT:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A3,-(A6)
            move.l  A0,D7
            move.w  D0,D6
            move.w  D1,D5
            move.w  ($10,A4),D0
            jsr     (LocTPR.w,PC)
            move.l  (A0),D4
            move.w  (2,A4),D0
            jsr     (BTAlloc.w,PC)
            bne.b   .L4
            move.l  D1,D3
            move.l  A2,D0
            beq.b   .L1
            move.l  D3,(A2)
            moveq   #4,D1
            movea.l A2,A0
            jsr     (RelNode.w,PC)
            bne.b   .L4
.L1:
            move.l  D3,D1
            jsr     (InitNode.w,PC)
            bne.b   .L4
            movea.l A0,A2
            move.b  (8,A3),(8,A2)
            move.l  (4,A3),(4,A2)
            move.l  D4,(A2)
            move.l  D3,(4,A3)
            moveq   #1,D0
            add.w   ($18,A4),D0
            sub.w   ($10,A4),D0
            move.b  D0,(9,A2)
            cmpi.b  #$FF,(8,A2)
            bne.b   .L2
            tst.l   (4,A2)
            bne.b   .L2
            move.l  D3,($22,A4)
.L2:
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     BTMAINT1
            beq.b   .L3
            bra.b   .L4
.L3:
            clr.w   D0
            move.l  D3,D2
.L4:
            movem.l (A6)+,D3-D7/A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TreeSearch:
            move.l  ($7CC).w,-(SP)
            rts
vTreeSearch:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A2-A3,-(A6)
            move.l  A0,D7
            tst.w   ($18,A4)
            bgt.b   .L1
            moveq   #$20,D0
            suba.l  A1,A1
            moveq   #0,D1
            moveq   #0,D2
            clr.w   ($10,A4)
            bra.b   .L5
.L1:
            moveq   #1,D6
            move.l  ($1A,A4),D3
.L2:
            moveq   #0,D1
            move.l  D3,D2
            jsr     (GetNode.w,PC)
            bne.b   .L5
            movea.l A0,A1
            movea.l D7,A0
            jsr     (SearchNode.w,PC)
            move.w  D0,D5
            move.w  D1,D4
            move.w  D6,D0
            jsr     (LocTPR.w,PC)
            movea.l A0,A3
            move.l  D3,(A3)
            move.w  D4,D2
            tst.w   D5
            beq.b   .L3
            subq.w  #1,D2
            bge.b   .L3
            move.w  D4,D2
.L3:
            move.w  D2,(4,A3)
            cmp.w   ($18,A4),D6
            beq.b   .L4
            move.w  D2,D1
            move.l  A1,-(SP)
            jsr     (LocRec.w,PC)
            move.l  (A1),D3
            movea.l (SP)+,A1
            moveq   #0,D1
            movea.l A1,A0
            jsr     (RelNode.w,PC)
            addq.w  #1,D6
            bra.b   .L2
.L4:
            move.w  D6,($10,A4)
            move.w  D4,D1
            move.w  D5,D0
            move.l  D3,D2
.L5:
            movem.l (A6)+,D3-D7/A2-A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
RotRecLt:
            movem.l A2-A3,-(SP)
            movea.l A0,A2
            movea.l A1,A3
            moveq   #0,D0
            jsr     (GetRecA.w,PC)
            lea     ($E,A1),A0
            movea.l A2,A1
            move.w  ($A,A1),D1
            jsr     (InsertRec.w,PC)
            movea.l A3,A1
            beq.b   .L1
            moveq   #-1,D0
            bra.b   .L2
.L1:
            clr.w   D1
            jsr     (DeleteRec.w,PC)
            clr.w   D0
.L2:
            tst.w   D0
            movem.l (SP)+,A2-A3
            rts
            ds.b    8

            EVEN
