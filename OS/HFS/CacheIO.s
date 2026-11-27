            include "Include/ROMHeader.s"

            EXPORT  VBASICIO,VRDBLOCKS,VSETUPTAGS,VWRBLOCKS,CacheIO,RDBLOCKS
            EXPORT  WRBLOCKS,WRITEBLOCK,WriteOwnBuf

            IMPORT  TFSVCBTst

            SECTION "CacheIO",CODE

CacheIO:
ReadOwnBuf:
ReadBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            moveq   #0,D1
            bra.b   WRITEBLOCK.L3
WriteOwnBuf:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            bra.b   WRITEBLOCK.L1
WRITEBLOCK:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            movea.l (8,A4),A2
            move.l  ($12,A4),D0
            move.w  ($10,A4),D1
            beq.b   .L2
.L1:
            movea.l ($34E).w,A1
            move.l  ($16,A4),D0
.L2:
            bsr.w   sub_40814760
            moveq   #1,D1
.L3:
            lea     ($3A4).w,A0
            move.w  ($48,A2),($16,A0)
            move.w  ($4A,A2),($18,A0)
            lea     ($1C,A4),A1
            move.l  A1,($20,A0)
            move.w  #1,($2C,A0)
            move.l  #$200,($24,A0)
            move.l  ($12,A4),D0
            lsl.l   #8,D0
            add.l   D0,D0
            move.l  D0,($2E,A0)
.L4:
            move.l  ($720).w,-(SP)
            rts
VBASICIO:
            move.l  A6,($36E).w
            tst.b   ($342).w
            bne.b   .L2
            tst.b   D1
            bne.b   .L1
            _Read
            bra.b   sub_408146CC.L2
.L1:
            _Write
            bra.b   sub_408146CC.L2
.L2:
            lea     sub_408146CC,A1
            move.l  A1,($C,A0)
            bclr    #7,($376).w
            tst.b   D1
            bne.b   .L3
            _Read async
            bra.b   .L4
.L3:
            _Write async
.L4:
            beq.b   .L5
            tst.w   ($10,A0)
            ble.b   sub_408146CC.L1
.L5:
            bset    #7,($376).w
            bne.b   sub_408146CC.L2
.L6:
            rts
sub_408146CC:
            bset    #7,($376).w
            beq.b   VBASICIO.L6
.L1:
            movem.l D4-D7/A4-A6,-(SP)
            pea     sub_408146FA
.L2:
            movea.l ($36E).w,A6
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            beq.b   .L3
            cmpi.w  #$FFBF,D0
            beq.b   .L3
            move.w  D0,($3DE).w
            moveq   #-$24,D0
.L3:
            tst.w   D0
            rts
sub_408146FA:
            movem.l (SP)+,D4-D7/A4-A6
            rts
RDBLOCKS:
            move.l  ($724).w,-(SP)
            rts
VRDBLOCKS:
            moveq   #0,D0
.L1:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            movea.l ($20,A0),A5
            adda.l  ($28,A0),A5
            move.w  D0,D1
            moveq   #$40,D0
            and.b   ($2D,A0),D0
            lea     ($3A4).w,A0
            move.w  ($4A,A2),($18,A0)
            move.w  ($48,A2),($16,A0)
            move.l  A5,($20,A0)
            move.l  D6,($24,A0)
            move.w  #1,($2C,A0)
            or.b    D0,($2D,A0)
            move.l  D3,D0
            lsl.l   #8,D0
            add.l   D0,D0
            move.l  D0,($2E,A0)
            bra.w   WRITEBLOCK.L4
WRBLOCKS:
            move.l  ($728).w,-(SP)
            rts
VWRBLOCKS:
            move.l  D5,D0
            lsr.l   #8,D0
            lsr.l   #1,D0
            bsr.b   sub_40814760
            moveq   #1,D0
            bra.b   VRDBLOCKS.L1
sub_40814760:
            move.l  ($72C).w,-(SP)
            rts
VSETUPTAGS:
            tst.w   D1
            beq.b   .L2
            move.l  (0,A1,D1.w),BufTgFNum
            move.l  D0,BufTgFFlg
            move.b  (4,A1,D1.w),BufTgFFlg
            move.l  ($32,A1,D1.w),($38A).w
            move.l  ($3A,A1,D1.w),($38E).w
.L1:
            jsr     (TFSVCBTst.w,PC)
            bne.b   .L3
            move.l  ($64,A2),BufTgDate
            addq.l  #1,($64,A2)
            rts
.L2:
            move.l  D0,BufTgFFlg
            moveq   #1,D0
            move.l  D0,BufTgFNum
            clr.l   ($38A).w
            clr.l   ($38E).w
            bra.b   .L1
.L3:
            move.l  TimeLM,BufTgDate
            rts
            ds.b    12

            EVEN
