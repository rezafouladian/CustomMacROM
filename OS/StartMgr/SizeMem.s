            include "Include/ROMHeader.s"

            EXPORT  SizeMemory

            IMPORT  GetHardwareInfo

            SECTION "SizeMem",CODE

SizeMemory:
            move.l  A6,D3
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l D3,A2
            moveq   #0,D3
            move.b  D2,D3
            add.w   D3,D3
            move.w  .splitTbl(PC,D3.w),D3
            jmp     .splitTbl(PC,D3.w)
.splitTbl:
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    .GlueSplit-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    .FMCSplit-.splitTbl
            dc.w    .VisaSplit-.splitTbl
            dc.w    .OrwellSplit-.splitTbl
            dc.w    .JAWSSplit-.splitTbl
            dc.w    .MSCSplit-.splitTbl
.GlueSplit:
            movea.l ($2C,A0),A5
            ori.b   #$C0,($1E00,A5)
            bra.w   SizeBanks
.FMCSplit:
            movea.l ($4C,A0),A5
            move.w  #$F3EF,D2
            moveq   #$F,D3
.L4:
            move.b  D2,(A5)
            lsr.w   #1,D2
            dbra    D3,.L4
            move.b  D2,($10,A5)
            bra.w   SizeBanks
.OrwellSplit:
            movea.l ($54,A0),A5
            lea     (A5),A0
            move.l  #$30810,D3
            moveq   #$11,D2
.L6:
            move.l  D3,(A0)+
            lsr.l   #1,D3
            dbra    D2,.L6
            move.l  D2,($A0,A5)
            bra.w   SizeBanks
.VisaSplit:
            movea.l ($34,A0),A5
            ori.b   #$E0,(1,A5)
            bra.w   SizeBanks
.JAWSSplit:
            moveq   #0,D0
            movea.l ($58,A0),A5
            adda.l  #$10000,A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            bra.w   SizeBanks
.MSCSplit:
            movea.l ($6C,A0),A5
            ori.b   #$E0,(1,A5)
SizeBanks:
            movea.l A1,A5
            adda.l  (4,A5),A5
            movea.l A5,SP
            addq.l  #4,SP
            moveq   #0,D0
            moveq   #0,D5
            moveq   #0,D6
            move.l  #'Tina',D1
.SizeBank:
            ror.l   #4,D5
            ror.l   #4,D6
            movea.l (SP)+,A0
            move.l  A0,D2
            addq.l  #1,D2
            beq.b   .L13
            movea.l (SP)+,A1
            BSR6    CheckByteLanes
            moveq   #$F,D3
            and.b   D6,D3
            beq.b   .size
            cmpi.b  #$F,D3
            bne.b   .SizeBank
            eor.b   D3,D6
            bra.b   .SizeBank
.size:
            BSR6    SizeBank
            bra.b   .SizeBank
.L13:
            suba.l  A5,SP
            subq.l  #8,SP
            move.l  SP,D2
            lsr.w   #1,D2
            rol.l   D2,D5
            rol.l   D2,D6
            tst.l   D6
            beq.b   Concat
            jmp     (A2)
SizeBank:
            move.l  A0,D4
            subq.l  #4,A1
.L15:
            move.l  (A1),D2
            move.l  D1,(A1)
            cmp.l   (A1),D1
            beq.b   .L16
            suba.l  (A5),A1
            cmpa.l  A0,A1
            bgt.b   .L15
            bra.b   .L20
.L16:
            subq.l  #4,A0
.L17:
            adda.l  (A5),A0
            cmp.l   (A0),D1
            bne.b   .L17
            move.l  D2,(A0)+
            suba.l  D4,A0
            moveq   #0,D3
            move.l  A0,D2
            beq.b   .L19
            move.l  (A5),D2
.L18:
            addq.w  #1,D3
            cmpa.l  D2,A0
            beq.b   .L19
            add.l   D2,D2
            bra.b   .L18
.L19:
            or.b    D3,D5
            add.l   A0,D0
.L20:
            RTS6
CheckByteLanes:
            move.l  (A0),D3
            move.l  (4,A0),D4
            move.l  D1,(A0)
            moveq   #4-1,D2
.next:
            move.l  #$FFFFFFFF,(4,A0)
            cmp.b   (0,A0,D2.w),D1
            bne.b   .bad
            not.b   D1
            not.b   (0,A0,D2.w)
            cmp.b   (0,A0,D2.w),D1
            beq.b   .shift
.bad:
            bset    D2,D6
.shift:
            ror.l   #8,D1
            dbra    D2,.next
            move.l  D3,(A0)
            move.l  D4,(4,A0)
            RTS6
Concat:
            move.l  D0,D3
            moveq   #0,D2
            movea.w #$2600,SP
            move.l  A2,D4
            BigBSR6 GetHardwareInfo,A0
            movea.l D4,A2
            adda.l  (4,A1),A1
            add.b   D2,D2
            ext.w   D2
            move.w  .mergTbl(PC,D2.w),D1
            move.l  (A1)+,D2
            jmp     .mergTbl(PC,D1.w)
.mergTbl:
            dc.w    noMerge-.mergTbl
            dc.w    noMerge-.mergTbl
            dc.w    noMerge-.mergTbl
            dc.w    noMerge-.mergTbl
            dc.w    GlueMerge-.mergTbl
            dc.w    MDUMerge-.mergTbl
            dc.w    FMCMerge-.mergTbl
            dc.w    VISAMerge-.mergTbl
            dc.w    OrwellMerge-.mergTbl
            dc.w    JAWSMerge-.mergTbl
            dc.w    MSCMerge-.mergTbl
noMerge:
            moveq   #$14,D1
            bra.w   writeChunkTable
GlueMerge:
            moveq   #$F,D1
            and.b   D5,D1
            bne.b   .sizeBits
            addq.w  #8,A1
            lsr.l   #4,D5
.sizeBits:
            move.b  .VIASizeTable(PC,D1.w),D0
            movea.l ($2C,A0),A5
            and.b   D0,($1E00,A5)
            moveq   #$1C,D1
            bra.w   writeChunkTable
.VIASizeTable:
            dc.b    $FF,$3F,$FF,$7F,$FF,$BF,$FF,$FF
MDUMerge:
            suba.l  A5,A5
            lea     ($10,A1),A1
.bankLoop:
            tst.b   D5
            beq.w   MergeDone
            subq.w  #8,A1
            lsl.l   #4,D5
            move.w  D5,D1
            lsr.w   #8,D1
            andi.b  #$F,D1
            beq.b   .bankLoop
            BSR6    expandSize
            move.l  A5,D1
            bne.b   .writeChunk
            movea.l (A1),A5
            adda.l  D0,A5
            clr.l   -(A5)
            clr.l   -(A5)
            move.l  #$FFFFFFFF,-(A5)
.writeChunk:
            move.l  D0,-(A5)
            move.l  (A1),-(A5)
            bra.b   .bankLoop
FMCMerge:
            move.w  #$F3EF,D1
            btst    #$14,D0
            beq.b   .cont
            move.w  #$F3FF,D1
.cont:
            move.w  D1,D0
            moveq   #$F,D1
            and.b   D5,D1
            bne.b   .sizeBits
            addq.w  #8,A1
            lsr.l   #4,D5
.sizeBits:
            and.b   .FMCSizeTable(PC,D1.w),D0
            movea.l ($4C,A0),A5
            moveq   #$F,D1
.FMCload:
            move.b  D0,(A5)
            lsr.w   #1,D0
            dbra    D1,.FMCload
            st      ($10,A5)
.writeTable:
            moveq   #$1C,D1
            bra.w   writeChunkTable
.FMCSizeTable:
            dc.b    $FF,$FF,$FF,$3F,$7F,$BF,$FF,$FF
OrwellMerge:
            move.w  D5,D1
            swap    D5
            move.w  D1,D5
            move.l  A1,D6
            suba.l  A3,A3
            moveq   #0,D3
            bra.b   .bankMapped
.mergeLoop:
            move.l  D3,D1
            subq.l  #1,D1
            mulu.l  #6,D1
            movea.l ($54,A0),A5
            lea     (0,A5,D1.w*4),A5
            move.l  A3,D1
            moveq   #$16,D4
            lsr.l   D4,D1
            move.w  #5,D4
.loadCfgReg:
            move.l  D1,(A5)+
            lsr.l   #1,D1
            dbra    D4,.loadCfgReg
            movea.l ($54,A0),A5
            lea     ($A0,A5),A5
            move.b  #$FF,(A5)
.bankMapped:
            moveq   #$F,D1
            and.b   D5,D1
            lsr.l   #4,D5
            BSR6    expandSize
            adda.l  D0,A3
.contLoop:
            tst.l   (8,A1)
            bmi.b   .mergeDone
            addq.l  #8,A1
            addq.l  #1,D3
            bra.b   .mergeLoop
.mergeDone:
            moveq   #$2C,D1
            move.l  A3,D3
            movea.l D6,A1
            bra.w   writeChunkTable
VISAMerge:
            move.b  D5,D1
            lsr.b   #4,D1
            BSR6    expandSize
            move.l  D0,D1
            moveq   #-$21,D0
            cmpi.l  #$100000,D1
            beq.b   .sizeBits
            moveq   #-1,D0
.sizeBits:
            moveq   #$F,D1
            and.b   D5,D1
            and.b   .VISASizeTable(PC,D1.w),D0
            movea.l ($34,A0),A5
            and.b   D0,(1,A5)
            moveq   #$1C,D1
            bra.w   writeChunkTable
.VISASizeTable:
            dc.b    $3F,$FF,$7F,$BF,$FF
            dc.b    $00
JAWSMerge:
            moveq   #0,D4
            moveq   #3,D1
            cmp.l   D1,D5
            bne.b   .checkSpec2
            moveq   #0,D4
            bra.b   .getTable
.checkSpec2:
            swap    D1
            cmp.l   D1,D5
            bne.b   .notSpec
            moveq   #$20,D4
            bra.b   .getTable
.notSpec:
            BSR6    .calcSize
            BSR6    .calcSize
            moveq   #$D,D0
            lsl.w   D0,D4
            lsr.l   D0,D4
.getTable:
            move.b  .JAWSSizeTable(PC,D4.w),D0
            movea.l ($58,A0),A5
            adda.l  #$10000,A5
            move.b  D0,(A5)
            lsr.b   #2,D0
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            lsr.b   #2,D0
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            moveq   #$4C,D1
            bra.w   writeChunkTable
.calcSize:
            movea.l A6,A5
            moveq   #3,D1
.nextNib:
            swap    D1
            move.w  #$F,D1
            rol.l   #4,D5
            and.b   D5,D1
            BSR6    expandSize
            add.l   D0,D4
            swap    D1
            dbra    D1,.nextNib
            swap    D4
            lsr.w   #4,D4
            cmpi.b  #8,D4
            bne.b   .done
            subq.b  #1,D4
.done:
            jmp     (A5)
.JAWSSizeTable:
            dc.b    $00,$01,$01,$02,$00,$00,$00,$00
            dc.b    $1F,$13,$03,$0A,$09,$00,$06,$08
            dc.b    $1F,$07,$03,$12,$09,$00,$06,$08
            dc.b    $1D,$04,$04,$19,$11,$00,$0E,$18
            dc.b    $17,$09,$05,$0F,$1B,$00,$16,$00
            dc.b    $00,$00,$00,$00,$00,$00,$00,$00
            dc.b    $17,$0B,$0B,$0C,$14,$00,$1A,$00
            dc.b    $17,$0D,$0D,$15,$17,$00,$17,$00
MSCMerge:
            move.l  D5,D1
            andi.l  #$F0000,D1
            bne.b   .done
            moveq   #$15,D0
            lsr.l   D0,D3
            subq.w  #1,D3
            lsl.b   #5,D3
            ori.b   #$1F,D3
            movea.l ($6C,A0),A5
            and.b   D3,(1,A5)
.done:
            moveq   #$34,D1
            bra.w   writeChunkTable
expandSize:
            moveq   #0,D0
            tst.w   D1
            beq.b   .exit
            move.l  D2,D0
            subq.w  #1,D1
            lsl.l   D1,D0
.exit:
            RTS6
writeChunkTable:
            movea.l (A1),A5
            movea.l A5,A0
            adda.l  D3,A5
            suba.l  D1,A5
            movea.l A5,SP
.loop:
            moveq   #$F,D1
            and.b   D5,D1
            beq.b   .next
            BSR6    expandSize
            move.l  A0,(SP)+
            move.l  D0,(SP)+
            adda.l  D0,A0
.next:
            lsr.l   #4,D5
            bne.b   .loop
            subq.l  #1,D5
            move.l  D5,(SP)+
.fill:
            clr.l   (SP)+
            move.w  SP,D0
            bne.b   .fill
MergeDone:
            movea.l (A1),SP
            adda.l  #$8000,SP
            move.l  A5,-(SP)
            moveq   #0,D6
            jmp     (A2)
            ds.b    14

            EVEN
