            include "Include/ROMHeader.s"

            EXPORT  vAllocNode,vExtBTFile,vFreeNode,VUPDALTMDB,BTAlloc,ExtBTFile
            EXPORT  FreeNode

            IMPORT  FindDrive,ExtendFile,GetNode,GetRecA,InitNode,RelNode
            IMPORT  GetBlock,MarkBlock,RelBlock

            SECTION "BTAlloc",CODE

BTAlloc:
AllocNode:
            move.l  ($758).w,-(SP)
            rts
vAllocNode:
            move.l  (SP)+,-(A6)
            movem.l D2-D4/A2-A3,-(A6)
            moveq   #0,D4
            suba.l  A2,A2
.L1:
            bsr.w   GetMap_BTALLOC
            beq.b   .L2
            cmpi.w  #$20,D0
            bne.b   .L8
            moveq   #$22,D0
            bra.b   .L8
.L2:
            move.w  D1,D2
            lsr.w   #2,D2
            subq.w  #1,D2
            movea.l A1,A0
.L3:
            move.l  (A0)+,D0
            cmpi.l  #$FFFFFFFF,D0
            bne.b   .L4
            dbra    D2,.L3
            ext.l   D1
            lsl.l   #3,D1
            add.l   D1,D4
            bra.b   .L1
.L4:
            move.w  #$1F,D2
.L5:
            btst    D2,D0
            beq.b   .L6
            dbra    D2,.L5
.L6:
            bset    D2,D0
            move.l  D0,D3
            lea     (-4,A0),A0
            movea.l A0,A3
            suba.l  A1,A0
            move.l  A0,D1
            lsl.l   #3,D1
            addi.l  #$1F,D1
            ext.l   D2
            sub.l   D2,D1
            add.l   D4,D1
            move.l  ($2E,A4),D0
            cmp.l   D1,D0
            bgt.b   .L7
            bsr.w   RelMap
            moveq   #$22,D0
            bra.b   .L8
.L7:
            move.l  D3,(A3)
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
            subq.l  #1,($32,A4)
            bset    #7,(A4)
            clr.w   D0
            bsr.w   RelMap
.L8:
            movem.l (A6)+,D2-D4/A2-A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtBTFile:
            move.l  ($760).w,-(SP)
            rts
vExtBTFile:
            move.l  (SP)+,-(A6)
            movem.l D2-D6/A2,-(A6)
            move.w  (2,A4),D1
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            moveq   #0,D3
            move.l  ($1E,A1,D1.w),D4
            jsr     (ExtendFile.w,PC)
            beq.b   .L1
            cmpi.w  #$FFDE,D0
            bne.w   .L7
            tst.l   D6
            beq.w   .L7
.L1:
            move.l  ($2E,A4),D3
            move.l  D3,D4
            move.l  ($C,A1,D1.w),D5
            divu.w  ($2A,A4),D5
            swap    D5
            clr.w   D5
            swap    D5
            move.l  D5,($2E,A4)
            subq.l  #1,D5
            move.l  D5,D6
            suba.l  A2,A2
.L2:
            bsr.w   GetMap_BTALLOC
            bne.w   .L7
            ext.l   D1
            lsl.l   #3,D1
            sub.l   D1,D3
            sub.l   D1,D5
            bge.b   .L3
            subq.l  #1,D4
            bra.b   .L6
.L3:
            tst.l   (A2)
            bne.b   .L2
            move.l  D4,(A2)
            tst.l   D3
            bge.b   .L4
            add.l   D1,D3
            divu.w  #8,D3
            move.w  D3,D0
            clr.w   D3
            swap    D3
            moveq   #7,D1
            sub.l   D3,D1
            bset    D1,(0,A1,D0.w)
            moveq   #-1,D3
.L4:
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
            bsr.w   RelMap
            bne.b   .L7
            move.l  D4,D1
            jsr     (InitNode.w,PC)
            bne.b   .L7
            movea.l A0,A2
            move.b  #2,(8,A2)
            move.w  #1,($A,A2)
            move.w  ($2A,A4),D1
            moveq   #-$12,D0
            add.w   D1,D0
            lsr.w   #2,D0
            lsl.w   #2,D0
            addi.w  #$E,D0
            move.w  D0,(-4,A2,D1.w)
            tst.l   D3
            blt.b   .L5
            move.b  #$80,($E,A2)
.L5:
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
.L6:
            sub.l   D4,D6
            add.l   D6,($32,A4)
            bset    #7,(A4)
            clr.b   D0
            bsr.w   RelMap
            st      ($377).w
            bsr.w   sub_408139E6
.L7:
            movem.l (A6)+,D2-D6/A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FreeNode:
            move.l  ($75C).w,-(SP)
            rts
vFreeNode:
            move.l  (SP)+,-(A6)
            movem.l D2-D3/A2,-(A6)
            move.l  D1,D3
            suba.l  A2,A2
.L1:
            bsr.b   GetMap_BTALLOC
            bne.b   .L2
            ext.l   D1
            lsl.l   #3,D1
            sub.l   D1,D3
            bge.b   .L1
            add.l   D1,D3
            divu.w  #8,D3
            moveq   #0,D0
            move.w  D3,D0
            clr.w   D3
            swap    D3
            moveq   #7,D1
            sub.l   D3,D1
            bclr    D1,(0,A1,D0.w)
            movea.l A2,A0
            jsr     (MarkBlock.w,PC)
            addq.l  #1,($32,A4)
            bset    #7,(A4)
            clr.b   D0
            bsr.b   RelMap
.L2:
            movem.l (A6)+,D2-D3/A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetMap_BTALLOC:
            move.l  (SP)+,-(A6)
            moveq   #0,D2
            move.l  A2,D0
            beq.b   .L1
            move.l  (A2),D2
            bsr.b   RelMap
            bne.b   .L3
            tst.l   D2
            bne.b   .L1
            moveq   #$20,D0
            bra.b   .L3
.L1:
            moveq   #0,D1
            jsr     (GetNode.w,PC)
            bne.b   .L3
            movea.l A0,A2
            moveq   #0,D0
            cmpi.b  #1,(8,A2)
            bne.b   .L2
            moveq   #2,D0
.L2:
            movea.l A2,A1
            jsr     (GetRecA.w,PC)
            move.l  A0,D1
            move.w  ($A,A2),D0
            jsr     (GetRecA.w,PC)
            movea.l D1,A1
            suba.l  A1,A0
            move.w  A0,D1
            clr.w   D0
.L3:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
RelMap:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            moveq   #0,D1
            movea.l A2,A0
            jsr     (RelNode.w,PC)
            suba.l  A2,A2
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
sub_408139E6:
            move.l  ($7B4).w,-(SP)
            rts
VUPDALTMDB:
            move.l  (SP)+,-(A6)
            movem.l D0-D2/A0-A3/A5,-(A6)
            move.w  (2,A4),D1
            movea.l ($34E).w,A5
            lea     (0,A5,D1.w),A5
            movea.l ($14,A5),A2
            move.w  ($48,A2),D2
            jsr     (FindDrive.w,PC)
            bne.w   .L10
            movem.l D0-D1/A0/A2,-(SP)
            suba.w  #$80,SP
            movea.l SP,A2
            moveq   #$18,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            movea.l SP,A0
            moveq   #0,D2
            move.w  ($C,A3),D2
            cmpi.w  #$FFFB,(8,A3)
            bne.b   .L5
            move.w  (6,A3),($16,A0)
            move.w  (8,A3),($18,A0)
            move.w  #6,($1A,A0)
            move.w  #$10,($1C,A0)
            move.l  A2,($1E,A0)
            _Status
            bne.b   .L4
            move.w  ($1C,A0),D0
            beq.b   .L4
            subq.w  #1,D0
.L2:
            btst    #6,(4,A2)
            bne.b   .L3
            addq.w  #8,A2
            dbra    D0,.L2
            bra.b   .L4
.L3:
            move.l  (A2),D2
            bra.b   .L6
.L4:
            move.w  #$320,D2
            tst.b   ($C,A3)
            beq.b   .L5
            add.l   D2,D2
.L5:
            tst.w   (4,A3)
            beq.b   .L6
            move.l  ($C,A3),D2
            swap    D2
.L6:
            lea     ($B2,SP),SP
            movem.l (SP)+,D0-D1/A0/A2
            subq.l  #2,D2
            move.w  ($4E,A2),D0
            moveq   #1,D1
            movea.l (8,A4),A1
            jsr     (GetBlock.w,PC)
            bne.b   .L10
            moveq   #2,D1
            cmpi.w  #$4244,(A0)
            bne.b   .L9
            lea     ($92,A0),A3
            moveq   #4,D0
            cmp.l   (A5),D0
            beq.b   .L7
            moveq   #3,D0
            cmp.l   (A5),D0
            bne.b   .L9
            lea     ($82,A0),A3
.L7:
            move.l  ($C,A5),(A3)+
            moveq   #2,D0
            lea     ($26,A5),A1
.L8:
            move.l  (A1)+,(A3)+
            dbra    D0,.L8
            move.l  TimeLM,(6,A0)
            moveq   #1,D1
.L9:
            jsr     (RelBlock.w,PC)
.L10:
            movem.l (A6)+,D0-D2/A0-A3/A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts

            EVEN
