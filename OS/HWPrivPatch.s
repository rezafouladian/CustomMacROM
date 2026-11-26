            include "Include/ROMHeader.s"

            EXPORT  FlushCRange,FlushCRangeForBM,FLUSHDCACHEPATCH,FLUSHICACHEPATCH,HWPrivPatch,InitMemoryDispatch
            EXPORT  NEWLOCKMEMORY,NEWLOCKMEMORYCONTIGUOUS,NEWUNLOCKMEMORY,SWAPDCACHEPATCH,UNWRITEPROTECTPROC,WRITEPROTECTPROC

            IMPORT  GetPageDescProc,GETREALPROC,SCSIBoots

            SECTION "HWPrivPatch",CODE

HWPrivPatch:
SWAPICACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L2
            movec   CACR,D0
            bfextu  D0{31:1},D1
            bclr    #0,D0
            move.l  A0,D2
            beq.b   .L1
            ori.b   #9,D0
.L1:
            bra.b   .L3
.L2:
            movec   CACR,D0
            bfextu  D0{16:1},D1
            bclr    #$F,D0
            move.l  A0,D2
            beq.b   .L3
            jsr     ([$6F4.w])
            bset    #$F,D0
.L3:
            movea.l D1,A0
            movec   D0,CACR
            moveq   #0,D0
            rts
FLUSHICACHEPATCH:
            jsr     ([$6F4.w])
            moveq   #0,D0
            rts
SWAPDCACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L2
            movec   CACR,D0
            bfextu  D0{23:1},D1
            bclr    #8,D0
            move.l  A0,D2
            beq.b   .L1
            ori.w   #$900,D0
.L1:
            bra.b   .L3
.L2:
            movec   CACR,D0
            bfextu  D0{0:1},D1
            bset    #$1F,D0
            move.l  A0,D2
            bne.b   .L3
            nop
            mc68040
            cpusha  DC
            mc68030
            bclr    #$1F,D0
.L3:
            movea.l D1,A0
            movec   D0,CACR
            moveq   #0,D0
            rts
FLUSHDCACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L1
            movec   CACR,D0
            bset    #$B,D0
            movec   D0,CACR
            bra.b   .L2
.L1:
            nop
            mc68040
            cpusha  DC
            mc68030
.L2:
            moveq   #0,D0
            rts
FlushCRangeForBM:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
FlushCRange:
            cmpi.b  #4,CPUFlag
            blt.w   .Non040
            lea     ($F,A1),A1
            move.l  A1,D1
            andi.w  #$FFF0,D1
            move    SR,D0
            btst    #$D,D0
            bne.b   .CheckCnt
            moveq   #8,D0
            _DebugUtil
.CheckCnt:
            cmpi.l  #$C00,D1
            blt.b   .KillInterrupts
            nop
            mc68040
            cpusha  BC
            mc68030
            bra.b   .L3
.KillInterrupts:
            movem.l D3-D5/A0-A1,-(SP)
            ori     #$700,SR
            moveq   #5,D2
            movec   D2,DFC
            move.w  #$D000,D4
            mc68040
            movec   TC,D2
            mc68030
            lsr.w   #2,D2
            eor.w   D2,D4
            move.w  D4,D5
            not.w   D5
.LetsGetPhysical:
            movea.l A0,A1
            mc68040
            ptestr  (A1)
            movec   MMUSR,D3
            mc68030
            and.w   D4,D3
            move.w  A1,D2
            and.w   D5,D2
            or.w    D2,D3
            movea.l D3,A1
            eor.w   D5,D2
            addq.w  #1,D2
            sub.w   D2,D1
            bpl.b   .FlushIt
            add.w   D1,D2
.FlushIt:
            adda.w  D2,A0
            asr.w   #4,D2
            cmpi.w  #$10,D2
            blt.b   .LineByLine
            nop
            mc68040
            cpushp  BC,(A1)
            mc68030
            bra.b   .NextPage
.LineByLine:
            mc68040
            cpushl  BC,(A1)
            mc68030
            lea     ($10,A1),A1
            dbra    D2,.LineByLine
.NextPage:
            tst.w   D1
            bgt.b   .LetsGetPhysical
            movem.l (SP)+,D3-D5/A0-A1
.L3:
            move    D0,SR
            moveq   #0,D0
            rts
.Non040:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            moveq   #0,D0
            rts
WRITEPROTECTPROC:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l LockMemCT,A2
            moveq   #-$32,D0
            move.l  (4,A2),D2
            subq.l  #1,D2
            move.l  A0,D1
            and.l   D2,D1
            bne.b   .L2
            move.l  A1,D1
            and.l   D2,D1
            bne.b   .L2
            bsr.w   GetPageRange
            bne.b   .L2
            moveq   #3,D0
            _HWPriv
            moveq   #1,D0
            _HWPriv
            bsr.w   MMUFlushATC
            lea     ($1C,A2,D1.w*2),A1
            moveq   #4,D0
.L1:
            ori.w   #$8000,(A1)+
            bsr.w   MMUSetWriteProtect
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D2/A0-A2
            rts
UNWRITEPROTECTPROC:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l LockMemCT,A2
            moveq   #-$32,D0
            move.l  (4,A2),D2
            subq.l  #1,D2
            move.l  A0,D1
            and.l   D2,D1
            bne.b   .L2
            move.l  A1,D1
            and.l   D2,D1
            bne.b   .L2
            bsr.w   GetPageRange
            bne.b   .L2
            lea     ($1C,A2,D1.w*2),A1
            moveq   #0,D0
.L1:
            andi.w  #$7FFF,(A1)+
            bsr.w   MMUSetWriteProtect
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D2/A0-A2
            rts
NEWLOCKMEMORY:
            movem.l D1-D4/A0-A2,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L2
            lea     ($1C,A2,D1.w*2),A1
            moveq   #1,D0
.L1:
            addq.w  #1,(A1)+
            bsr.w   MMUSetCacheInhibit
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #3,D0
            _HWPriv
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D4/A0-A2
            rts
NEWUNLOCKMEMORY:
            movem.l D1-D4/A0-A2,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L5
            lea     ($1C,A2,D1.w*2),A1
            move.l  D2,D3
            move.w  #$FD91,D0
.L1:
            tst.w   (A1)+
            beq.b   .L5
            subq.l  #1,D3
            bhi.b   .L1
            lea     ($1C,A2,D1.w*2),A1
            move.l  D2,D3
            moveq   #0,D0
            moveq   #0,D4
.L2:
            subq.w  #1,(A1)+
            bne.b   .L3
            bsr.w   MMUSetCacheInhibit
            moveq   #1,D4
.L3:
            addq.l  #1,D1
            subq.l  #1,D3
            bhi.b   .L2
            tst.l   D4
            beq.b   .L4
            bsr.w   MMUFlushATC
.L4:
            moveq   #0,D0
.L5:
            movem.l (SP)+,D1-D4/A0-A2
            rts
NEWLOCKMEMORYCONTIGUOUS:
            movem.l D1-D4/A0-A3,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L2
            movea.l A0,A3
            movem.l D1/A1-A2,-(SP)
            bsr.w   GETREALPROC
            movem.l (SP)+,D1/A1-A2
            exg     A0,A3
            adda.l  A1,A0
            subq.l  #1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GETREALPROC
            movem.l (SP)+,D1/A1-A2
            suba.l  A3,A0
            addq.l  #1,A0
            cmpa.l  A1,A0
            bne.b   .L3
            lea     ($1C,A2,D1.w*2),A1
            moveq   #1,D0
.L1:
            addq.w  #1,(A1)+
            bsr.w   MMUSetCacheInhibit
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #3,D0
            _HWPriv
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D4/A0-A3
            rts
.L3:
            move.w  #$FD92,D0
            bra.b   .L2
GetPageRange:
            movem.l A1-A2,-(SP)
            move.l  A0,D0
            tst.b   MMU32bit
            bne.b   .noStrip
            _StripAddress
.noStrip:
            movea.l D0,A0
            cmpa.w  #0,A1
            beq.b   .error
            move.l  D0,D1
            move.l  D0,D2
            add.l   A1,D2
            subq.l  #1,D2
            cmp.l   RealMemTop,D2
            bcc.b   .error
            move.l  (8,A2),D0
            lsr.l   D0,D1
            lsr.l   D0,D2
            sub.l   D1,D2
            addq.l  #1,D2
            moveq   #0,D0
.exit:
            movem.l (SP)+,A1-A2
            rts
.error:
            moveq   #paramErr,D0
            bra.b   .exit
MMUSetWriteProtect:
            cmpi.b  #3,MMUType
            bcs.w   .L2
            movem.l D0-D4/A0-A1,-(SP)
            move.l  D0,D4
            cmp.l   ($C,A2),D1
            scs     D3
            move.l  (8,A2),D0
            asl.l   D0,D1
            moveq   #0,D0
            _SwapMMUMode
            move.l  D0,D2
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            movea.l A0,A1
            moveq   #1,D0
            _SwapMMUMode
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            bclr    #2,(3,A0)
            or.l    D4,(A0)
            tst.b   D3
            beq.b   .L1
            bclr    #2,(3,A1)
            or.l    D4,(A1)
.L1:
            move.l  D2,D0
            _SwapMMUMode
            movem.l (SP)+,D0-D4/A0-A1
.L2:
            rts
MMUSetCacheInhibit:
            cmpi.b  #3,MMUType
            bcs.w   .noPages
            movem.l D0-D4/A0-A1,-(SP)
            move.l  D0,D4
            cmp.l   ($C,A2),D1
            scs     D3
            move.l  (8,A2),D0
            asl.l   D0,D1
            moveq   #0,D0
            _SwapMMUMode
            move.l  D0,D2
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            movea.l A0,A1
            moveq   #1,D0
            _SwapMMUMode
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            bsr.b   MMUSetCacheMode
            tst.b   D3
            beq.b   .exit
            movea.l A1,A0
            bsr.b   MMUSetCacheMode
.exit:
            move.l  D2,D0
            _SwapMMUMode
            movem.l (SP)+,D0-D4/A0-A1
.noPages:
            rts
MMUSetCacheMode:
            movem.l D0-D1,-(SP)
            tst.b   D4
            beq.b   .L1
            move.l  (A0),D1
            bset    #6,D1
            bclr    #5,D1
            move.l  D1,(A0)
            bra.b   .L2
.L1:
            moveq   #0,D1
            bfextu  CacheFlags{24:1},D1
            lsl.l   #5,D1
            or.l    (A0),D1
            bclr    #6,D1
            move.l  D1,(A0)
.L2:
            movem.l (SP)+,D0-D1
            rts
MMUFlushATC:
            cmpi.b  #3,MMUType
            bcs.b   .exit
            cmpi.b  #5,MMUType
            beq.b   .handle040
            pflusha
.exit:
            rts
.handle040:
            mc68040
            pflusha
            mc68030
            rts
; InitMemoryDispatch
; Allocate and initialize the MemoryDispatch globals
InitMemoryDispatch:
            link.w  A6,#-4
            movem.l D0-D4/A0-A3,-(SP)
            clr.l   LockMemCT
            move.b  CPUFlag,D1
            moveq   #0,D2
            move.l  PhysMemTop,D3
            cmpi.b  #cpu68040,D1
            bne.b   .not040
            mc68040
            moveq   #12,D1
            movec   TC,D0
            btst    #14,D0
            beq.b   .gotPageSize
            addq.l  #1,D1
            bra.b   .gotPageSize
            mc68030
.not040:
            cmpi.b  #cpu68020,D1
            blt.b   .noPages
            cmpi.b  #3,MMUType
            blt.b   .noPages
            pmove.l TC,(-4,A6)
            bfextu  (-4,A6){8:4},D1
.gotPageSize:
            bset    D1,D2
            lsr.l   D1,D3
            move.l  D3,D4
            move.l  D3,D0
            asl.l   #1,D0
            addi.w  #$1C,D0
            move.l  D0,D3
            _NewPtrSysClear
            bne.b   .noPages
            move.l  A0,LockMemCT
            move.l  D3,(A0)
            move.l  D2,(4,A0)
            move.l  D1,(8,A0)
            move.l  D4,($10,A0)
            move.l  D4,($18,A0)
            move.l  #$800000,D3
            cmp.l   PhysMemTop,D3
            bcs.b   .use8meg
            move.l  PhysMemTop,D3
.use8meg:
            lsr.l   D1,D3
            move.l  D3,($C,A0)
.noPages:
            movem.l (SP)+,D0-D4/A0-A3
            unlk    A6
            rts
WAITFORSCSIDEVS:
            movem.l D2-D4,-(SP)
            move.l  A0,D1
            move.l  D1,D2
            swap    D2
            or.b    D1,D2
            subq.w  #2,SP
            movea.l SP,A0
            _GetOSDefault
            suba.l  A0,A0
            _InternalWait
            bne.b   .L1
            moveq   #$14,D0
.L1:
            mulu.w  #$3C,D0
            move.l  D0,D4
            move.w  (SP)+,D3
            swap    D3
.L2:
            move.l  D2,D0
            bsr.l   SCSIBoots
            move.b  SCSIDrvrs,D0
            and.b   D1,D0
            cmp.b   D1,D0
            beq.b   .L5
            move.l  Ticks,D0
            cmp.l   D4,D0
            bhi.w   .L4
            addi.l  #$F,D0
.L3:
            cmp.l   Ticks,D0
            bhi.b   .L3
            cmp.l   D4,D0
            bcs.b   .L2
.L4:
            movea.w #$FFFF,A0
            bra.b   .L6
.L5:
            suba.l  A0,A0
.L6:
            movem.l (SP)+,D2-D4
            rts
            ds.b    804

            EVEN
