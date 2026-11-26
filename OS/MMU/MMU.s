            include "Include/ROMHeader.s"

            EXPORT  InitMMUGlobals,InitMMUTrap,MMUCleanupFor8Mb

            SECTION "MMU",CODE

MMUSTUFF:
; InitMMUTrap
InitMMUTrap:
            movea.l JSwapMMU,A0
            move.w  #$A05D,D0
            _SetOSTrapAddress
            rts
InitMMUGlobals:
            movea.l BootGlobPtr,A1
            clr.b   MMUFlags
            move.b  #true32b,MMU32bit
            lea     (-$42,A1),A0
            move.l  A0,MMU32Info
            lea     (-$2E,A1),A0
            move.l  A0,MMU24Info
            moveq   #0,D0
            move.b  (-$1A,A1),D0
            move.b  D0,MMUType
            btst    #0,(-$19,A1)
            beq.b   .findSwap
            lea     Swap32Only,A0
            bra.b   .gotSwap
.findSwap:
            move.w  .swaps(PC,D0.w*2),D0
            lea     .swaps(PC,D0.w),A0
.gotSwap:
            move.l  A0,JSwapMMU
.NoSwap:
            rts
.swaps:
            dc.w    .NoSwap-.swaps
            dc.w    SwapHMMU-.swaps
            dc.w    .NoSwap-.swaps
            dc.w    Swap851-.swaps
            dc.w    Swap030-.swaps
            dc.w    Swap040-.swaps
            dc.w    .NoSwap-.swaps
            dc.w    .NoSwap-.swaps
MMUCleanupFor8Mb:
            movea.l BufPtr,A0
            suba.w  #$28,A0
            move.l  A0,BufPtr
            lea     MMU32Info,A1
            bsr.b   .doCopy
            lea     MMU24Info,A1
.doCopy:
            movea.l (A1),A2
            move.l  A0,(A1)
            moveq   #$13,D0
.copy:
            move.b  (A2)+,(A0)+
            dbra    D0,.copy
            rts
Swap32Only:
            moveq   #1,D0
            rts
Swap851:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            move    SR,-(SP)
            ori     #$700,SR
            movea.l MMU24Info,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            move    SR,-(SP)
            ori     #$700,SR
            movea.l MMU32Info,A0
.swap:
            pmove.l (theCRP,A0),TC
            pmove.d (theCRP,A0),CRP
            pmove.l (theTC,A0),TC
            pflusha
            move.b  D1,MMU32bit
            movec   CACR,D1
            ori.w   #8,D1
            movec   D1,CACR
            move    (SP)+,SR
.endif:
            rts
Swap030:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            movea.l MMUTbl,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            movea.l MMUTblSize,A0
.swap:
            move    SR,-(SP)
            ori     #$700,SR
            ploadr  #5,(8,A0)
            pmove.l ($C,A0),TT0
            pmove.l ($10,A0),TT1
            pmovefd.d (A0),CRP
            pmove.l (8,A0),TC
            move.b  D1,MMU32bit
            movec   CACR,D1
            ori.w   #$808,D1
            movec   D1,CACR
            pflusha
            move    (SP)+,SR
.endif:
            rts
Swap040:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            movea.l MMUTbl,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            movea.l MMUTblSize,A0
.swap:
            move    SR,-(SP)
            ori     #$700,SR
            move.b  D1,MMU32bit
            move.l  ($C,A0),D1
            mc68040
            movec   D1,ITT0
            movec   D1,DTT0
            mc68030
            move.l  ($10,A0),D1
            mc68040
            movec   D1,ITT1
            movec   D1,DTT1
            mc68030
            move.l  (8,A0),D1
            movea.l (4,A0),A0
            mc68040
            movec   A0,SRP
            movec   D1,TC
            pflusha
            mc68030
            move    (SP)+,SR
.endif:
            rts
SwapHMMU:
            move.b  D0,D1
            bne.b   .L1
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA2,A0
            bclr    #3,(A0)
            bra.b   .common
.L1:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA2,A0
            bset    #3,(A0)
.common:
            move.b  D1,MMU32bit
            movec   CACR,D1
            bset    #3,D1
            movec   D1,CACR
            movea.l ASCBase,A0
            lea     (ascFifoInt,A0),A0
            move.b  (A0),D1
            beq.b   .L2
            or.b    D1,(A0)
.L2:
            move    (SP)+,SR
.L3:
            rts
            ds.b    38

            EVEN
