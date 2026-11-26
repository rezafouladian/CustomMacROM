            include "Include/ROMHeader.s"

            EXPORT  ALLOCSLOTOVERPATCH1,ALLOCSLOTOVERPATCH2,INITJMPTBLPATCH,INITSLOTINTSPATCH,SLOTGETDRIVERPATCH,SLOTMGRPATCH
            EXPORT  SLOTPRIMARYINITPATCH,STATLOADPATCH

            IMPORT  CacheFlush,ENDGETSLOTDRVR,GOTSLOTHANDLER,INTHANDLERNOVIA2,ORIGGETSLOTDRVR,SlotIntCommon

            SECTION "SlotMgrPatch",CODE

; SlotMgrPatch.a: Slot Manager ROM overpatches (1K-aligned overpatch slot at $8BC00).
; Later rolled into SlotMgr.a, SlotMgrInit.a and SlotInterrupts.a.

SLOTMGRPATCH:
SLOTEXECPATCH:
            movem.l D0-D7/A0-A6,-(SP)
            bsr.l   CacheFlush
            movea.l ($14,A0),A0
            jsr     (A2)
            movem.l (SP)+,D0-D7/A0-A6
            moveq   #0,D0
            rts
STATLOADPATCH:
            move.l  A3,(A0)
            bsr.l   CacheFlush
            rts
INITSLOTINTSPATCH:
            btst    #3,($DD2).w                     ; TestFor VIA2Exists
            beq.l   INTHANDLERNOVIA2
            btst    #5,($DD1).w                     ; TestFor OrwellExists
            beq.l   GOTSLOTHANDLER
            lea     EclipseVia2SlotInt,A0
            bra.l   GOTSLOTHANDLER
EclipseVia2SlotInt:
            move.b  #2,($1A00,A1)
            moveq   #-$80,D0
            or.b    ($1E00,A1),D0
            not.l   D0
            bne.l   SlotIntCommon
            rts
INITJMPTBLPATCH:
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            lea     p040BusException,A0
            move.l  A0,([SDMJmpTblPtr.w],$E4.w)
.L1:
            movem.l (SP)+,A0-A2
            moveq   #0,D0
            rts
p040BusException:
            move.l  D0,-(SP)
            move.w  ($10,SP),D0
            andi.w  #$518,D0
            cmpi.w  #$100,D0
            bne.b   .L1
            move.b  ($A,SP),D0
            lsr.b   #4,D0
            cmpi.b  #7,D0
            bne.b   .L1
            move.b  ($18,SP),D0
            cmpi.b  #$90,D0
            bcs.b   .L1
            cmpi.b  #$FF,D0
            beq.b   .L1
            cmpi.b  #$F0,D0
            beq.b   .L1
            move.l  A2,(6,SP)
            move.l  (SP)+,D0
            rte
.L1:
            move.l  (SP)+,D0
            move.l  ([SInfoPtr.w],-8.w),-(SP)
            rts
DevTbl:                                     ; Category,CType,DrvrSW,DrvrHW,drvrVers
            dc.w    $0003,$0001,$0001,$0001,$0006,$0003,$0001,$0001
            dc.w    $0019,$0110
            ds.b    4
LoadTbl:
            dc.b    $00,$00,$BE,$AC,$00,$00,$C7,$FA,$04
            ds.b    5
            dc.b    $9C,$8C,$00,$00,$B6,$AC,$04
            dc.b    $00
            dc.w    0
JsrTbl:
            dc.w    0,$C7F4,0,$B6A4
GetDevIndex:
            movem.l D3-D4/A3-A4,-(SP)
            link.w  A6,#-$38
            movea.l A0,A3
            movea.l SP,A0
            lea     DevTbl,A4
            moveq   #0,D3
.L1:
            move.b  ($31,A3),($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
            clr.b   ($30,A0)
            move.w  (A4),($28,A0)
            move.w  (2,A4),($2A,A0)
            move.w  (4,A4),($2C,A0)
            move.w  (6,A4),($2E,A0)
            bset    #1,($1B,A0)
            _sGetTypesRsrc
            bne.b   .L2
            movem.l D1-D2/A1,-(SP)
            bsr.l   sub_4088BE80
            tst.w   D0
            movem.l (SP)+,D1-D2/A1
            bne.b   .L3
            movea.l (A0),A3
            movea.l (A3),A0
            lea     ($12,A0),A0
            clr.w   D0
            move.b  (A0),D0
            addq.w  #2,D0
            bclr    #0,D0
            move.w  (0,A0,D0.w),D4
            movea.l A3,A0
            _DisposHandle
            cmp.w   (8,A4),D4
            bge.b   .L3
            move.l  D3,D0
            bra.b   .L4
.L2:
            lea     ($A,A4),A4
            addq.w  #1,D3
            tst.w   (A4)
            bne.b   .L1
.L3:
            moveq   #-1,D0
.L4:
            unlk    A6
            movem.l (SP)+,D3-D4/A3-A4
            rts
PatchPrimaryInit:
            movem.l D1/D3/A0-A3,-(SP)
            movea.l A0,A3
            bsr.w   GetDevIndex
            move.l  D0,D3
            bmi.b   .L1
            lea     JsrTbl,A1
            lsl.l   #2,D3
            movea.l A1,A0
            adda.l  D3,A0
            adda.l  (A0),A1
            movea.l A3,A0
            move.b  ($31,A0),(A2)
            move.b  ($36,A0),(4,A2)
            movea.l A2,A0
            jsr     (A1)
            move.l  D3,D0
.L1:
            movem.l (SP)+,D1/D3/A0-A3
            rts
SLOTPRIMARYINITPATCH:
            movea.l (SP)+,A2
            bsr.b   PatchPrimaryInit
            tst.b   D0
            bpl.b   .L1
            move.l  A3,(4,A0)
            move.b  ($31,A0),(A2)
            move.b  ($36,A0),(4,A2)
            _sExec
.L1:
            move.b  #3,(8,A1)
            move.w  (2,A2),(6,A1)
            bpl.b   .L2
            move.w  #$FEC4,(4,A1)
.L2:
            rts
GetDriverPatch:
            movem.l D3-D4/A0/A3-A5,-(SP)
            link.w  A6,#-$38
            movea.l A0,A3
            bsr.w   GetDevIndex
            move.l  D0,D3
            bmi.b   .L2
            lea     LoadTbl,A1
            mulu.w  #$C,D3
            movea.l A1,A0
            move.b  (8,A0,D3.w),D0
            move.b  (9,A0,D3.w),D1
            moveq   #0,D4
            move.b  D0,D4
            swap    D4
            move.b  D1,D4
            movea.l SP,A0
            move.b  ($31,A3),($31,A0)
            move.b  ($32,A3),($32,A0)
            move.b  D4,($33,A0)
            _sRsrcInfo
            bne.b   .L1
            swap    D4
            move.b  D4,($32,A0)
            _sFindStruct
            bne.b   .L1
            movea.l A1,A4
            adda.l  (0,A1,D3.w),A4
            movea.l A1,A0
            adda.l  (4,A1,D3.w),A0
            move.l  (A0),D3
            move.l  D3,D0
            _ResrvMem sys
            bne.b   .L1
            move.l  D3,D0
            _NewHandle sys
            bne.b   .L1
            movea.l A0,A5
            _HNoPurge
            movea.l A4,A0
            movea.l (A5),A1
            move.l  D3,D0
            _BlockMove
            movea.l A3,A0
            move.l  A5,(A0)
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.l  #$FFFFFEA7,D0
.L2:
            unlk    A6
            movem.l (SP)+,D3-D4/A0/A3-A5
            rts
SLOTGETDRIVERPATCH:
            bsr.w   GetDriverPatch
            tst.b   D0
            bmi.b   sub_4088BE80
            bra.l   ENDGETSLOTDRVR
sub_4088BE80:
            movem.l A2-A3,-(SP)
            movea.l A0,A1
            bra.l   ORIGGETSLOTDRVR
ALLOCSLOTOVERPATCH1:
            btst    #3,(0,A3,D1.w)
            bne.b   .L1
            move.w  #$FFFD,(4,SP)
            btst    #5,(0,A3,D1.w)
.L1:
            rts
ALLOCSLOTOVERPATCH2:
            move.w  #$FEC2,(4,A0)
            lea     ($18,A0),A0
            move.w  #$FECF,(4,A0)
            rts
            ds.b    1356

            EVEN
