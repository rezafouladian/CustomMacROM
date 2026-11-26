            include "Include/ROMHeader.s"

            EXPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            EXPORT  ALIGN24TRAILER,ALIGN32TRAILER,DerefHandlePatch,DSHOOKPATCH,FILEMGRPATCH,FlushCRange
            EXPORT  FlushCRangeForBM,FLUSHDCACHEPATCH,FLUSHICACHEPATCH,getAddrModePatch,getFPUTypePatch,getPageSizePatch
            EXPORT  GETREALPROC,HWPrivPatch,INIT24ZONEALIGN,INIT32ZONEALIGN,InitMemoryDispatch,NEWLOCKMEMORY
            EXPORT  NEWLOCKMEMORYCONTIGUOUS,NEWUNLOCKMEMORY,OSEVENTAVAILPATCH,OSEVENTMGRPATCH,SETAPPLBASEPATCH,SWAPDCACHEPATCH
            EXPORT  UNWRITEPROTECTPROC,V24CMGUTSPATCH,v24HlockPatch,V24MAXAPPLPATCH,V24MAXMEMPATCH,V24PURGESPACEPATCH
            EXPORT  V32CMGUTSPATCH,v32HlockPatch,V32MAXAPPLPATCH,V32MAXMEMPATCH,V32PURGESPACEPATCH,WRITEPROTECTPROC
            EXPORT  ZoneCheckPatch

            IMPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,DHBusErrHandler,HeapGuts
            IMPORT  SCSIBoots

            SECTION "Part8",CODE

FILEMGRPATCH:
CMDDONEPATCH:
            movea.l ($362).w,A0
            cmpi.b  #2,(7,A0)
            bne.b   .L1
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
.L1:
            clr.b   ($377).w
            ext.l   D0
            rts
DSHOOKPATCH:
            move.w  (6,A0),D0
            bgt.b   .L1
            jmp     .L2
.L1:
            ori.b   #$A0,($B00).w
            move.b  #$60,($B01).w
            andi.w  #$FF,D0
.L2:
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
            jmp     ($B00).w
            ds.b    1978
GestaltPatch:
getPageSizePatch:
            moveq   #0,D0
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            mc68040
            movec   TC,D1
            mc68030
            btst    #$E,D1
            bne.b   .L2
            bset    #$C,D0
            bra.b   .L3
.L2:
            bset    #$D,D0
            bra.b   .L3
.L1:
            cmpi.b  #2,CPUFlag
            blt.w   .L4
            cmpi.b  #3,MMUType
            blt.b   .L5
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            lea     ($12,A0),A0
            pmove.l TC,(A0)
            bfextu  (A0){8:4},D1
            bset    D1,D0
            bra.b   .L3
.L5:
            move.l  #$8000,D0
.L3:
            bra.w   getAddrModePatch.L1
.L4:
            bra.w   getAddrModePatch.L3
getFPUTypePatch:
            btst    #4,HWCfgFlags
            beq.b   .L4
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #3,D0
            bra.b   .L5
.L1:
            movea.l SP,A0
            fnop
            fsave   -(SP)
            move.w  (SP),D0
            movea.l A0,SP
            cmpi.w  #$1F18,D0
            beq.b   .L2
            cmpi.w  #$3F18,D0
            beq.b   .L2
            cmpi.w  #$3F38,D0
            beq.b   .L3
            cmpi.w  #$1F38,D0
            beq.b   .L3
            moveq   #0,D0
            bra.b   .L5
.L2:
            moveq   #1,D0
            bra.b   .L5
.L3:
            moveq   #2,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            bra.b   getAddrModePatch.L1
getAddrModePatch:
            moveq   #0,D0
            move.b  ($B73).w,D0
            not.b   D0
            andi.l  #3,D0
            bset    #2,D0
            bra.w   .L1
.L3:
            move.w  #$EA52,($C,SP)
            bra.b   .L2
.L1:
            movea.l (4,SP),A0
            move.l  D0,(A0)
            clr.w   ($C,SP)
.L2:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
            ds.b    1842
GETREALPROC:
            move.w  #6,-(SP)
            bra.b   GetPageDescProc.L1
GetPageDescProc:
            move.w  #7,-(SP)
.L1:
            movem.l D1-D4,-(SP)
            link.w  A6,#-$1A
            cmpi.b  #3,MMUType
            bge.b   .L2
            move.w  #$FD8E,D0
            bra.b   .L8
.L2:
            move.l  A0,D2
            jsr     GETMMUINFO
            move.b  MMU32bit,-(SP)
            bne.b   .L3
            moveq   #1,D0
            _SwapMMUMode
            and.l   Lo3Bytes,D2
            bra.b   .L4
.L3:
            jsr     CHECKTTREGS
            bne.b   .L4
            movea.l D2,A0
            suba.l  A2,A2
            moveq   #0,D3
            bra.b   .L6
.L4:
            cmpi.b  #5,MMUType
            beq.b   .L5
            jsr     translate030
            bra.b   .L6
.L5:
            jsr     translate040
.L6:
            move.b  (SP)+,D0
            bne.b   .L7
            _SwapMMUMode
.L7:
            move.w  D3,D0
.L8:
            unlk    A6
            movem.l (SP)+,D1-D4
            cmpi.w  #7,(SP)+
            bne.b   .L9
            movea.l A2,A0
.L9:
            rts
GETMMUINFO:
            cmpi.b  #5,MMUType
            beq.b   .L1
            pmove.d CRP,(-$10,A6)
            pmove.l TC,(-8,A6)
            move.l  (-8,A6),D4
            moveq   #$C,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$15,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$19,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$18,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$17,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$16,A6)
            bra.b   .L2
.L1:
            mc68040
            movec   SRP,D0
            mc68030
            move.l  D0,(-$C,A6)
            clr.l   (-$10,A6)
            move.b  #7,(-$19,A6)
            move.b  #7,(-$18,A6)
            move.b  #5,(-$17,A6)
            mc68040
            movec   TC,D0
            mc68030
            move.w  D0,(-8,A6)
            btst    #$E,D0
            bne.b   .L5
            move.b  #6,(-$17,A6)
.L5:
            clr.b   (-$16,A6)
            clr.b   (-$15,A6)
.L2:
            clr.l   (-$14,A6)
            cmpi.l  #$FFFFFFFF,ExpandMem
            beq.b   .L3
            move.l  #'addr',D0
            _Gestalt
            tst.w   D0
            bne.b   .L4
            move.l  A0,D0
            btst    #2,D0
            beq.b   .L4
            move.l  #$766D2020,D0
            _Gestalt
            tst.w   D0
            bne.b   .L3
            move.l  A0,D0
            btst    #0,D0
            bne.b   .L4
.L3:
            move.l  Phys2Log,(-$14,A6)
.L4:
            rts
CHECKTTREGS:
            cmpi.b  #5,MMUType
            beq.b   .L1
            subq.w  #4,SP
            pmove.l TT0,(SP)
            move.l  (SP),D0
            pmove.l TT1,(SP)
            move.l  (SP),D1
            addq.w  #4,SP
            bra.b   .L2
.L1:
            mc68040
            movec   DTT0,D0
            movec   DTT1,D1
            mc68030
.L2:
            btst    #$F,D0
            beq.b   .L3
            move.l  D2,D3
            eor.l   D0,D3
            rol.l   #8,D3
            swap    D0
            not.b   D0
            and.b   D0,D3
            beq.b   .L5
.L3:
            btst    #$F,D1
            beq.b   .L4
            move.l  D2,D3
            eor.l   D1,D3
            rol.l   #8,D3
            swap    D1
            not.b   D1
            and.b   D1,D3
            bra.b   .L5
.L4:
            andi    #$FFFB,SR
.L5:
            rts
translate030:
            movem.l D4-D7,-(SP)
            move.l  (-$C,A6),D1
            move.l  (-$10,A6),D7
            move.b  D7,D3
            andi.b  #3,D3
            move.l  (-8,A6),D0
            btst    #$19,D0
            bne.w   .paramErr
            btst    #$18,D0
            bne.w   .paramErr
            btst    #$1F,D0
            bne.b   .L1
            movea.l D2,A1
            moveq   #0,D1
            moveq   #0,D3
            bra.b   .xlatDone
.L1:
            moveq   #0,D4
            move.b  (-$15,A6),D4
            lea     (-$19,A6),A1
            moveq   #0,D5
            move.b  (A1)+,D5
.xlatLoop:
            cmpi.b  #1,D3
            beq.b   .getPage
            bfextu  D2{D4:D5},D6
            tst.l   D7
            beq.b   .noLimit
            jsr     checkLimit
            bcs.b   .paramErr
.noLimit:
            andi.l  #$FFFFFFF0,D1
            cmpi.b  #2,D3
            bne.b   .not4byte
            add.l   (-$14,A6),D1
            movea.l D1,A2
            lsl.w   #2,D6
            adda.l  D6,A2
            move.l  (A2),D1
            moveq   #0,D7
            move.b  D1,D3
            bra.b   .doNext
.not4byte:
            cmpi.b  #3,D3
            bne.b   .paramErr
            add.l   (-$14,A6),D1
            movea.l D1,A2
            lsl.w   #3,D6
            adda.l  D6,A2
            move.l  (4,A2),D1
            move.l  (A2),D7
            move.b  D7,D3
.doNext:
            add.l   D5,D4
            move.b  (A1)+,D5
            andi.b  #3,D3
            bra.b   .xlatLoop
.getPage:
            moveq   #$20,D5
            sub.l   D4,D5
            bfextu  D1{0:D4},D0
            bfextu  D2{D4:D5},D6
            lsl.l   D5,D0
            add.l   D6,D0
            movea.l D0,A0
            adda.l  (-$14,A6),A2
            moveq   #0,D3
.xlatDone:
            movem.l (SP)+,D4-D7
            rts
.paramErr:
            move.w  #$FFCE,D3
            bra.b   .xlatDone
translate040:
            movem.l D4-D7,-(SP)
            move.l  (-$C,A6),D1
            move.w  (-8,A6),D0
            btst    #$F,D0
            bne.b   .startTranslate
            movea.l D2,A1
            moveq   #0,D1
            moveq   #0,D3
            bra.b   .L5
.startTranslate:
            moveq   #0,D4
            clr.w   D3
            moveq   #0,D5
            lea     (-$19,A6),A1
.L2:
            move.b  (A1)+,D5
            moveq   #$1E,D0
            sub.l   D5,D0
            bfextu  D1{0:D0},D1
            lsl.l   D5,D1
            lsl.l   #2,D1
            bfextu  D2{D4:D5},D6
            lsl.w   #2,D6
            add.l   D6,D1
            add.l   (-$14,A6),D1
            movea.l D1,A2
            move.l  (A2),D1
            cmpi.w  #2,D3
            beq.b   .L3
            btst    #1,D1
            beq.b   .L6
            add.l   D5,D4
            addq.w  #1,D3
            bra.b   .L2
.L3:
            move.b  D1,D0
            andi.b  #3,D0
            cmpi.b  #1,D0
            beq.b   .L4
            cmpi.b  #2,D0
            bne.b   .L6
            andi.l  #$FFFFFFFC,D1
            add.l   (-$14,A6),D1
            movea.l D1,A2
            move.l  (A2),D1
.L4:
            add.l   D5,D4
            moveq   #$20,D5
            sub.l   D4,D5
            bfextu  D1{0:D4},D0
            bfextu  D2{D4:D5},D6
            lsl.l   D5,D0
            add.l   D6,D0
            movea.l D0,A0
            moveq   #0,D3
.L5:
            movem.l (SP)+,D4-D7
            rts
.L6:
            move.w  #$FFCE,D3
            bra.b   .L5
checkLimit:
            swap    D7
            btst    #$F,D7
            bne.b   .L1
            cmp.w   D6,D7
            bra.b   .L2
.L1:
            andi.w  #$7FFF,D7
            cmp.w   D7,D6
.L2:
            rts
            ds.b    10
EDISKPROTECT:
            movem.l D2-D4/A2,-(SP)
            link.w  A6,#-$1A
            move.l  A0,D2
            movea.w A1,A2
            move    SR,D0
            btst    #$D,D0
            bne.b   .L1
            moveq   #8,D0
            _DebugUtil
.L1:
            move.w  D0,-(SP)
            move.b  MMU32bit,-(SP)
            bne.b   .L2
            moveq   #1,D0
            _SwapMMUMode
            bra.b   .L3
.L2:
            jsr     CHECKTTREGS
            bne.b   .L3
            movea.l D2,A0
            moveq   #-$32,D3
            bra.b   cleanup
.L3:
            jsr     GETMMUINFO
            moveq   #0,D0
            moveq   #0,D1
            move.b  (-$15,A6),D0
            move.b  (-$19,A6),D1
            bfextu  D2{D0:D1},D0
            lsl.l   #2,D0
            btst    #0,(-$D,A6)
            beq.b   .L4
            lsl.l   #1,D0
.L4:
            add.l   (-$C,A6),D0
            add.l   (-$14,A6),D0
            movea.l D0,A0
            bset    #2,(3,A0)
            tst.w   A2
            bne.b   .L5
            bclr    #2,(3,A0)
.L5:
            cmpi.b  #4,CPUFlag
            bne.b   .L6
            mc68040
            pflusha
            mc68030
            bra.b   cleanup
.L6:
            pflusha
cleanup:
            move.b  (SP)+,D0
            bne.b   skipMMUSwap
            _SwapMMUMode
skipMMUSwap:
            move.w  (SP)+,D0
            move    D0,SR
            move.w  D3,D0
            unlk    A6
            movem.l (SP)+,D2-D4/A2
            rts
            ds.b    128
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
MEMORYMGRPATCH:
v24HlockPatch:
            beq.w   HFail
            bset    #7,(A1)
            bra.w   v32HlockPatch.L1
v32HlockPatch:
            beq.w   HFail
            bset    #7,(-$B,A0)
.L1:
            cmpi.b  #cpu68040,CPUFlag
            bne.b   HGood
            jsr     ([$6F4.w])
HGood:
            moveq   #0,D0
            bra.b   HFail.L4
HFail:
            moveq   #-$6D,D0
.L4:
            move.l  vMMEpilogue,-(SP)
            rts
ZoneCheckPatch:
            movea.l BusErrVct,A2
            BigLea  HeapGuts,A3
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            lea     sub_4088787A,A3
.L1:
            move.l  A3,BusErrVct
            rts
DerefHandlePatch:
            movea.l BusErrVct,A2
            BigLea  DHBusErrHandler,A3
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            lea     sub_40887870,A3
.L1:
            move.l  A3,BusErrVct
            rts
sub_40887870:
            moveq   #-1,D0
            movea.l D0,A0
            addq.l  #2,(2,SP)
            rte
sub_4088787A:
            sub.l   D0,D0
            addq.l  #4,(2,SP)
            rte
A24MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A32MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A24ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addi.l  #$17,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addq.l  #8,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$C,D0
            bcc.b   .L2
            moveq   #$C,D0
.L2:
            rts
A32ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$1B,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addi.l  #$C,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
.L2:
            rts
A24SETSIZEPATCH:
            move.l  D0,D1
            lea     ($3C,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addq.l  #8,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A24ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
A32SETSIZEPATCH:
            move.l  D0,D1
            lea     ($40,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$C,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A32ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
SETAPPLBASEPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$F,D0
            andi.w  #$FFF0,D0
            rts
.L1:
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            rts
INIT24ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addq.l  #8,D0
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(A0)
            add.l   D0,(A0)
            sub.l   D0,(A1)
            move.l  (A1),(0,A1,D0.w)
            adda.l  D0,A1
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            adda.l  D0,A1
            addq.b  #2,(A0)
            addq.l  #2,(A0)
            subq.l  #2,(A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
INIT32ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addi.l  #$C,D0
            move.l  (4,A0),D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(3,A0)
            add.l   D0,(4,A0)
            sub.l   D0,(4,A1)
            move.l  (4,A1),(4,A1,D0.w)
            adda.l  D0,A1
            clr.l   (A1)
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (4,A0),D0
            adda.l  D0,A1
            addq.b  #2,(3,A0)
            addq.l  #2,(4,A0)
            subq.l  #2,(4,A1)
            move.l  (4,A1),(6,A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
ALIGN24TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
ALIGN32TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
V24CMGUTSPATCH:
            bsr.l   a24CompactHp
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32CMGUTSPATCH:
            bsr.l   A32COMPACTHP
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A24BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A32BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V32PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V24MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D0
            subq.l  #8,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
V32MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D0
            subi.l  #$C,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
            ds.b    1032
OSEVENTMGRPATCH:
POSTEVENTPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.w  SysEvtMask,D2
            move.w  A0,D1
            rts
OSEVENTAVAILPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.l  (A1)+,(A0)+
            subq.w  #1,D0
            bne.b   .L1
            rts
            ds.b    976

            EVEN
