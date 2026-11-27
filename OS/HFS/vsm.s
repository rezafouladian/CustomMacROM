            include "Include/ROMHeader.s"

            EXPORT  vBlkAlloc,VBLKDEALLOC,vReadBM,BLKCHK,UpdateFree,BLKDEALLOC
            EXPORT  BlkAlloc

            IMPORT  DivUp,MarkVCB,RoundAlloc,GetBlock,MarkBlock

            SECTION "vsm",CODE

BlkAlloc:
VSM:
            move.l  ($77C).w,-(SP)
            rts
vBlkAlloc:
            move.l  (SP)+,-(A6)
            movem.l D1/D4-D7/A0-A1,-(A6)
            tst.w   ($2A,A2)
            beq.w   .L17
            andi.w  #1,D3
            tst.w   D2
            bne.b   .L1
            move.w  ($18,A2),D2
            bset    #7,D3
.L1:
            swap    D3
            move.w  D2,D3
            swap    D3
            bclr    #$F,D3
.L2:
            bsr.w   ReadBM
            tst.w   D1
            bmi.w   .L16
            movea.w ($1A,A2),A1
.L3:
            cmp.w   A1,D2
            bcs.b   .L4
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            clr.w   D2
            bsr.w   ReadBM
            bset    #$F,D3
            bne.w   .L17
.L4:
            tst.w   D1
            bmi.w   .L16
            tst.l   D0
            bpl.b   .L5
            bsr.w   FrBitScan
            bra.b   .L3
.L5:
            suba.w  D2,A1
            btst    #0,D3
            beq.b   .L11
            move.l  D4,-(A6)
            movem.l D0-D1,-(A6)
            move.l  D4,D0
            move.w  ($1E,A2),D1
            jsr     (DivUp.w,PC)
            move.l  D0,D4
            movem.l (A6)+,D0-D1
            clr.w   D7
.L6:
            cmp.w   D7,D4
            bls.b   .L10
            cmp.w   A1,D7
            beq.b   .L7
            tst.l   D0
            bmi.b   .L7
            addq.w  #1,D7
            bsr.w   NextBit
            tst.w   D1
            bmi.w   .L16
            bra.b   .L6
.L7:
            move.l  (A6)+,D4
            add.w   D7,D2
            cmp.w   A1,D7
            bcs.b   .L8
            btst    #$F,D3
            bne.b   .L9
            bset    #$F,D3
            clr.w   D2
.L8:
            btst    #$F,D3
            beq.w   .L2
            swap    D3
            cmp.w   D2,D3
            bls.b   .L9
            swap    D3
            bra.w   .L2
.L9:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            bra.w   .L17
.L10:
            move.l  (A6)+,D4
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            bsr.w   ReadBM
            tst.w   D1
            bmi.w   .L16
.L11:
            movem.l D0-D1,-(A6)
            move.l  D4,D0
            move.l  ($1E,A3),D1
            jsr     (RoundAlloc.w,PC)
            move.l  D0,D4
            movem.l (A6)+,D0-D1
            moveq   #0,D7
.L12:
            tst.w   D4
            beq.b   .L13
            cmp.w   A1,D7
            bcc.b   .L13
            tst.l   D0
            bmi.b   .L13
            tst.w   ($2A,A2)
            beq.b   .L13
            subq.w  #1,($2A,A2)
            jsr     (MarkVCB.w,PC)
            bset    #$1F,D0
            addq.w  #1,D7
            subq.w  #1,D4
            jsr     (MarkBlock.w,PC)
            bsr.w   NextBit
            tst.w   D1
            bge.b   .L12
            bra.b   .L16
.L13:
            btst    #7,D3
            beq.b   .L15
            move.w  D2,D4
            cmp.w   ($1A,A2),D4
            bcs.b   .L14
            clr.w   D4
.L14:
            move.w  D4,($18,A2)
.L15:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            jsr     (MarkBlock.w,PC)
            move.l  D7,D3
            moveq   #0,D0
.L16:
            movem.l (A6)+,D1/D4-D7/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
.L17:
            moveq   #0,D3
            moveq   #-$22,D0
            bra.b   .L16
BLKDEALLOC:
            move.l  ($780).w,-(SP)
            rts
VBLKDEALLOC:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0,-(A6)
            moveq   #0,D0
            tst.w   D3
            beq.b   .L3
            bsr.w   ReadBM
.L1:
            tst.w   D1
            bmi.b   .L3
            bclr    #$1F,D0
            jsr     (MarkBlock.w,PC)
            addq.w  #1,($2A,A2)
            jsr     (MarkVCB.w,PC)
            subq.w  #1,D3
            beq.b   .L2
            bsr.w   NextBit
            bra.b   .L1
.L2:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            moveq   #0,D0
.L3:
            movem.l (A6)+,D1-D6/A0
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BLKCHK:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A1,-(A6)
            movea.l A0,A1
            moveq   #0,D3
            moveq   #0,D7
.L1:
            move.w  (0,A1,D7.w),D2
            moveq   #0,D4
            move.w  (2,A1,D7.w),D4
            beq.b   .L6
            bsr.b   ReadBM
            bra.b   .L4
.L2:
            bset    #$1F,D0
            bne.b   .L3
            moveq   #-1,D3
            jsr     (MarkBlock.w,PC)
.L3:
            addq.w  #1,D2
            rol.l   #1,D0
            subq.w  #1,D1
            bgt.b   .L4
            tst.w   D4
            beq.b   .L5
            bsr.w   NextWord
.L4:
            tst.w   D1
            bmi.b   .L7
            dbra    D4,.L2
            rol.l   D1,D0
.L5:
            move.l  D0,(0,A0,D6.w)
            addq.w  #4,D7
            cmpi.w  #$C,D7
            bcs.b   .L1
.L6:
            move.l  D3,D0
.L7:
            movem.l (A6)+,D1-D7/A1
            move.l  (A6)+,-(SP)
            tst.l   D0
            rts
UpdateFree:
            move.l  (SP)+,-(A6)
            movem.l D0-D6/A0-A1,-(A6)
            moveq   #0,D4
            moveq   #0,D2
            bsr.b   ReadBM
            move.w  ($1A,A2),D2
.L1:
            tst.w   D1
            bmi.b   .L4
            tst.l   D0
            bmi.b   .L2
            addq.w  #1,D4
.L2:
            subq.w  #1,D2
            beq.b   .L3
            bsr.b   NextBit
            bra.b   .L1
.L3:
            move.w  D4,($2A,A2)
.L4:
            movem.l (A6)+,D0-D6/A0-A1
            move.l  (A6)+,-(SP)
            rts
ReadBM:
            move.l  ($7D8).w,-(SP)
            rts
vReadBM:
            move.l  (SP)+,-(A6)
            move.w  D2,D5
            lsr.w   #8,D5
            lsr.w   #4,D5
            move.w  D2,D6
            andi.w  #$FE0,D6
            lsr.w   #3,D6
            move.w  D2,D1
            andi.w  #$1F,D1
            bsr.b   GetBMBlk
            beq.b   .L1
            moveq   #-1,D1
            bra.b   .L2
.L1:
            move.l  (0,A0,D6.w),D0
            rol.l   D1,D0
            neg.w   D1
            addi.w  #$20,D1
.L2:
            move.l  (A6)+,-(SP)
            rts
NextBit:
            move.l  (SP)+,-(A6)
            rol.l   #1,D0
            subq.w  #1,D1
            bne.b   .L1
            bsr.b   NextWord
.L1:
            move.l  (A6)+,-(SP)
            rts
FrBitScan:
            move.l  (SP)+,-(A6)
            addq.w  #1,D2
            bsr.b   NextBit
.L1:
            cmp.l   MinusOne,D0
            bne.b   NextBit.L1
            add.w   D1,D2
            cmp.w   A1,D2
            bcc.b   .L2
            bsr.b   NextWord
            bra.b   .L1
.L2:
            sub.w   D1,D2
            bra.b   NextBit.L1
NextWord:
            move.l  (SP)+,-(A6)
            move.l  D0,(0,A0,D6.w)
            addq.w  #4,D6
            cmpi.w  #$200,D6
            bcs.b   .L2
            addq.w  #1,D5
            bsr.b   GetBMBlk
            beq.b   .L1
            moveq   #-1,D1
            bra.b   .L3
.L1:
            clr.w   D6
.L2:
            move.l  (0,A0,D6.w),D0
            moveq   #$20,D1
.L3:
            move.l  (A6)+,-(SP)
            rts
GetBMBlk:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1-A2,-(A6)
            move.w  ($4E,A2),D0
            moveq   #0,D2
            move.w  ($16,A2),D2
            add.w   D5,D2
            movea.l ($50,A2),A1
            moveq   #8,D1
            jsr     (GetBlock.w,PC)
            movem.l (A6)+,D1-D2/A1-A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            dc.w    0

            EVEN
