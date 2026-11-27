            include "Include/ROMHeader.s"

            EXPORT  GetBlock,vCacheRdIP,vCacheWrIP,vFlushCache,vGetBlock,vMarkBlock
            EXPORT  vRelBlock,vTrashBlocks,vTrashVBlks,CacheRdIP,CacheWrIP,FlushCache
            EXPORT  InitCache,MarkA5Block,MarkBlock,RelBlock,TrashBlocks,TrashFBlocks
            EXPORT  TrashVBlks

            IMPORT  Lg2Phys,TFSVCBTst,CacheIO,RDBLOCKS,WRBLOCKS,WRITEBLOCK
            IMPORT  WriteOwnBuf

            SECTION "Cache",CODE

Cache:
            moveq   #0,D0
            beq.b   .L1
            movea.l D0,A4
            suba.w  #$1C,A4
.L1:
            rts
FlushOwnBuf:
            bsr.b   Cache
            beq.b   .L1
            btst    #5,($1A,A4)
            bne.b   .L1
            bclr    #7,($1A,A4)
            beq.b   .L1
            move.l  (SP)+,-(A6)
            jsr     (WriteOwnBuf.w,PC)
            move.l  (A6)+,-(SP)
.L1:
            rts
FlushCache:
            move.l  ($700).w,-(SP)
            rts
vFlushCache:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0-A4,-(A6)
            cmpa.l  ($380).w,A1
            bne.b   .L4
            tst.b   ($377).w
            bne.b   .L4
            moveq   #0,D5
            movea.l A1,A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L2
            btst    #6,($1A,A4)
            bne.b   .L1
            btst    #7,($1A,A4)
            bne.b   .L1
.L2:
            addq.w  #1,D5
            bra.b   .L1
.L3:
            move.w  (8,A3),D6
            lsr.w   #2,D6
            cmp.w   D6,D5
            bhi.w   .L13
.L4:
            move.b  D1,D5
            movea.l A1,A3
            move.w  D0,D1
            ble.b   .L5
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            bsr.b   FlushOwnBuf
            move.l  (0,A1,D1.w),D3
            btst    #1,(4,A1,D1.w)
            sne     D6
.L5:
            moveq   #0,D4
.L6:
            moveq   #0,D2
            movea.l A3,A4
.L7:
            movea.l (A4),A4
            cmpa.l  A3,A4
            bne.b   .L8
            tst.l   D2
            beq.b   .L13
            movea.l A1,A4
            move.l  ($12,A4),D4
            bra.b   .L11
.L8:
            btst    #5,($1A,A4)
            bne.b   .L7
            cmpa.l  (8,A4),A2
            bne.b   .L7
            tst.w   D1
            blt.b   .L9
            cmp.l   ($C,A4),D3
            bne.b   .L7
            cmp.b   ($1B,A4),D6
            bne.b   .L7
.L9:
            tst.l   D2
            beq.b   .L10
            cmp.l   ($12,A4),D2
            blt.b   .L7
.L10:
            cmp.l   ($12,A4),D4
            bge.b   .L7
            move.l  ($12,A4),D2
            movea.l A4,A1
            bra.b   .L7
.L11:
            btst    #7,($1A,A4)
            beq.b   .L12
            jsr     (WRITEBLOCK.w,PC)
            bclr    #7,($1A,A4)
.L12:
            btst    #0,D5
            beq.b   .L6
            btst    #6,($1A,A4)
            bne.b   .L6
            bsr.w   MarkEmpty
            bra.b   .L6
.L13:
            clr.w   D0
            movem.l (A6)+,D1-D6/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetBlock:
            move.l  ($704).w,-(SP)
            rts
vGetBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A1-A5,-(A6)
            move.b  D1,D3
            movea.l A1,A3
            move.w  D0,D1
            blt.w   .L4
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            move.l  (0,A1,D1.w),D7
            btst    #1,(4,A1,D1.w)
            sne     D4
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            cmp.l   ($C,A4),D7
            bne.b   .L1
            cmp.b   ($1B,A4),D4
            bne.b   .L1
            cmp.l   ($16,A4),D2
            beq.w   .L17
            bra.b   .L1
.L2:
            bsr.w   Cache
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L3
            cmp.l   ($16,A4),D2
            beq.w   .L20
.L3:
            movem.l D3-D4,-(A6)
            moveq   #0,D4
            move.w  ($A,A3),D4
            move.l  D2,D5
            lsl.l   #8,D5
            add.l   D5,D5
            jsr     (Lg2Phys.w,PC)
            move.l  D2,D6
            move.l  D3,D2
            movem.l (A6)+,D3-D4
            tst.w   D0
            bne.w   .L21
            moveq   #0,D0
            beq.b   .L5
            bsr.w   FlushOwnBuf
            move.l  D2,($12,A4)
            move.l  D6,($16,A4)
            clr.b   ($1A,A4)
            jsr     (CacheIO.w,PC)
            beq.w   .L20
            bsr.w   MarkEmpty
            bra.w   .L21
.L4:
            moveq   #0,D1
            moveq   #0,D7
            moveq   #-1,D6
            moveq   #0,D4
.L5:
            suba.l  A0,A0
            suba.l  A1,A1
            suba.l  A5,A5
            movea.l A3,A4
.L6:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L10
            btst    #5,($1A,A4)
            beq.b   .L7
            movea.l A4,A0
            bra.b   .L6
.L7:
            tst.w   D1
            bne.b   .L8
            cmpa.l  (8,A4),A2
            bne.b   .L8
            cmp.l   ($12,A4),D2
            beq.w   .L17
.L8:
            btst    #6,($1A,A4)
            bne.b   .L6
            btst    #7,($1A,A4)
            beq.b   .L9
            movea.l A4,A5
            bra.b   .L6
.L9:
            movea.l A4,A1
            bra.b   .L6
.L10:
            btst    #1,D3
            beq.b   .L11
            moveq   #3,D0
            bra.w   .L21
.L11:
            movea.l A0,A4
            move.l  A4,D0
            bne.b   .L14
            movea.l A1,A4
            move.l  A4,D0
            bne.b   .L14
            movea.l A5,A4
            move.l  A4,D0
            bne.b   .L12
            moveq   #1,D0
            bra.w   .L21
.L12:
            movem.l D0-D2/A1-A2,-(A6)
            move.b  ($377).w,D2
            st      ($377).w
            moveq   #0,D1
            movea.l A3,A1
            movea.l (8,A4),A2
            move.w  ($10,A4),D0
            bgt.b   .L13
            move.w  ($4E,A2),D0
.L13:
            jsr     FlushCache
            move.b  D2,($377).w
            movem.l (A6)+,D0-D2/A1-A2
            cmpa.l  ($380).w,A3
            bne.b   .L14
            st      ($377).w
.L14:
            bset    #6,($1A,A4)
            bclr    #5,($1A,A4)
            bclr    #7,($1A,A4)
            move.l  A2,(8,A4)
            move.l  D2,($12,A4)
            move.w  D1,($10,A4)
            move.l  D7,($C,A4)
            move.b  D4,($1B,A4)
            move.l  D6,($16,A4)
            btst    #2,D3
            bne.b   .L19
.L15:
            clr.l   BufTgDate
            jsr     (CacheIO.w,PC)
            bne.b   .L16
            jsr     (TFSVCBTst.w,PC)
            bne.b   .L19
            move.l  BufTgDate,D0
            cmp.l   ($64,A2),D0
            bls.b   .L19
            move.l  D0,($64,A2)
            bra.b   .L19
.L16:
            clr.b   ($1A,A4)
            bsr.w   MarkEmpty
            bra.b   .L21
.L17:
            bset    #6,($1A,A4)
            beq.b   .L18
            moveq   #2,D0
            bra.b   .L21
.L18:
            btst    #0,D3
            bne.b   .L15
.L19:
            jsr     sub_408145F6
            movea.l A3,A0
            jsr     sub_4081460C
            btst    #3,D3
            beq.b   .L20
            bclr    #6,($1A,A4)
.L20:
            lea     ($1C,A4),A0
            moveq   #0,D0
.L21:
            movem.l (A6)+,D1-D7/A1-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
InitCache:
            move.l  (SP)+,-(A6)
            movem.l D1-D3/A0/A4,-(A6)
            move.w  D0,D2
            move.w  D1,D3
            addi.w  #$1C,D1
            moveq   #0,D0
            move.w  D2,D0
            mulu.w  D1,D0
            addi.l  #$C,D0
            _NewPtrSysClear
            bne.b   .L2
            movea.l A0,A1
            move.l  A1,(A1)
            move.l  A1,(4,A1)
            move.w  D2,(8,A1)
            move.w  D3,($A,A1)
            lea     ($C,A1),A4
            subq.w  #1,D2
.L1:
            movea.l A1,A0
            jsr     sub_4081460C
            bsr.b   MarkEmpty
            adda.l  D1,A4
            dbra    D2,.L1
            clr.w   D0
.L2:
            movem.l (A6)+,D1-D3/A0/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
MarkEmpty:
            bset    #5,($1A,A4)
            clr.l   ($12,A4)
            rts
MarkBlock:
            move.l  ($708).w,-(SP)
            rts
vMarkBlock:
            bset    #7,(-2,A0)
            rts
MarkA5Block:
            exg     A0,A5
            bsr.b   MarkBlock
            exg     A0,A5
            rts
RelBlock:
            move.l  ($70C).w,-(SP)
            rts
vRelBlock:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1/A3-A4,-(A6)
            lea     (-$1C,A0),A4
            bclr    #6,($1A,A4)
            btst    #1,D1
            beq.b   .L1
            bsr.b   MarkEmpty
            bclr    #7,($1A,A4)
            bra.b   .L3
.L1:
            btst    #2,D1
            beq.b   .L2
            bset    #7,($1A,A4)
.L2:
            btst    #0,D1
            beq.b   .L3
            movea.l A1,A3
            jsr     (WRITEBLOCK.w,PC)
            bclr    #7,($1A,A4)
            bra.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (A6)+,D1/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TrashVBlks:
            move.l  ($714).w,-(SP)
            rts
vTrashVBlks:
            movem.l A3-A4,-(SP)
            movea.l A1,A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            bsr.w   MarkEmpty
            bra.b   .L1
.L2:
            movem.l (SP)+,A3-A4
            rts
TrashFBlocks:
            movem.l D0-D6/A0-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            bra.b   TrashBlocks.L2
TrashBlocks:
            movem.l D0-D6/A0-A4,-(SP)
            moveq   #9,D3
            move.l  D1,D4
            lsr.l   D3,D4
            moveq   #-1,D5
            cmp.l   D2,D5
            beq.b   .L1
            move.l  D2,D5
            add.l   D1,D5
            subq.l  #1,D5
.L1:
            lsr.l   D3,D5
            move.w  D0,D1
            ble.b   vTrashBlocks.L3
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            move.l  (0,A1,D1.w),D3
            btst    #1,(4,A1,D1.w)
            sne     D6
            bsr.w   Cache
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L2
            move.l  ($16,A4),D0
            cmp.l   D4,D0
            blt.b   .L2
            cmp.l   D5,D0
            bgt.b   .L2
            bsr.w   MarkEmpty
.L2:
            move.l  ($710).w,-(SP)
            rts
vTrashBlocks:
            movea.l ($54,A2),A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            cmp.l   ($C,A4),D3
            bne.b   .L1
            tst.w   D1
            beq.b   .L2
            cmp.b   ($1B,A4),D6
            bne.b   .L1
            move.l  ($16,A4),D0
            cmp.l   D4,D0
            blt.b   .L1
            cmp.l   D5,D0
            bgt.b   .L1
.L2:
            bsr.w   MarkEmpty
            bra.b   .L1
.L3:
            movem.l (SP)+,D0-D6/A0-A4
            rts
CacheRdIP:
            move.l  ($71C).w,-(SP)
            rts
vCacheRdIP:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            movem.l D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            movea.l ($54,A2),A1
            bsr.w   FlushCache
            movem.l (A6)+,D1/A1
            bne.b   .L1
            jsr     (Lg2Phys.w,PC)
            bne.b   .L1
            jsr     (RDBLOCKS.w,PC)
.L1:
            bra.b   vCacheWrIP.L1
CacheWrIP:
            move.l  ($718).w,-(SP)
            rts
vCacheWrIP:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            jsr     (Lg2Phys.w,PC)
            bne.b   .L1
            movem.l D1-D2,-(A6)
            move.w  D1,D0
            move.l  D5,D1
            move.l  D6,D2
            bsr.w   TrashBlocks
            movem.l (A6)+,D1-D2
            jsr     (WRBLOCKS.w,PC)
.L1:
            move.l  (A6)+,D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
sub_408145F6:
            movem.l A0-A1,-(SP)
            movea.l (4,A4),A0
            movea.l (A4),A1
            move.l  A1,(A0)
            move.l  A0,(4,A1)
            movem.l (SP)+,A0-A1
            rts
sub_4081460C:
            move.l  A1,-(SP)
            movea.l (A0),A1
            move.l  A1,(A4)
            move.l  A4,(4,A1)
            move.l  A4,(A0)
            move.l  A0,(4,A4)
            movea.l (SP)+,A1
            rts

            EVEN
