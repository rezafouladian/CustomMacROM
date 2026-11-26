            include "Include/ROMHeader.s"

            EXPORT  ENDGETSLOTDRVR,ORIGGETSLOTDRVR,SlotManager,StartSDeclMgr

            IMPORT  ALLOCSLOTOVERPATCH1,ALLOCSLOTOVERPATCH2,INITJMPTBLPATCH,Overpatch,SLOTBUSEXCPTNPTCH,SLOTGETDRIVERPATCH
            IMPORT  SLOTMGRPATCH,SLOTPRIMARYINITPATCH,STATLOADPATCH

            SECTION "SlotMgr",CODE

READSLOTBYTE:
            move.l  (4,A0),-(SP)
            clr.b   (3,A0)
            _sOffsetData
            bne.b   .L1
            move.b  ($F,A0),(3,A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    4
READSLOTWORD:
            move.l  (4,A0),-(SP)
            clr.w   (2,A0)
            _sOffsetData
            bne.b   .L1
            move.w  ($E,A0),(2,A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    4
READSLOTLONG:
            move.l  (4,A0),-(SP)
            clr.l   (A0)
            bclr    #1,($36,A0)
            _sReadPBSize
            bne.b   .L1
            move.l  (8,A0),(A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            dc.w    0
GETCSTRING:
            movem.l A2-A3,-(SP)
            move.l  (4,A0),-(SP)
            move.b  ($31,A0),-(SP)
            _sFindStruct
            bne.b   sub_40805950.L1
            movea.l (4,A0),A3
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40805950.L1
            move.l  (A0),D1
            moveq   #0,D0
            moveq   #0,D2
            movea.l A3,A1
            lea     sub_40805950.L1,A2
            pea     sub_4080592C
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_4080592C:
            addq.l  #1,D0
            move.b  (A1),D2
            beq.b   .L2
            move.b  D1,D2
            adda.w  D2,A1
.L1:
            ror.l   #8,D1
            tst.b   D1
            beq.b   .L1
            bra.b   sub_4080592C
.L2:
            move.l  D0,(8,A0)
            pea     sub_40805950
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805950:
            movea.l A0,A2
            _NewPtr
            bne.b   .L1
            move.l  A0,(A2)
            movea.l A2,A0
            move.l  A3,(4,A0)
            _sReadStruct
            beq.b   .L1
            move.l  D0,D1
            movea.l A0,A1
            movea.l (4,A1),A0
            _DisposPtr
            movea.l A1,A0
            move.l  D1,D0
.L1:
            move.b  (SP)+,($31,A0)
            move.l  (SP)+,(4,A0)
            movem.l (SP)+,A2-A3
            rts
GETSLOTBLOCK:
            move.l  (4,A0),-(SP)
            bset    #1,($36,A0)
            _sReadPBSize
            bne.b   .L2
            move.l  (8,A0),D0
            subq.l  #4,D0
            bgt.b   .L1
            move.w  #$FEB0,D0
            bra.b   .L2
.L1:
            move.l  D0,(8,A0)
            movea.l A0,A1
            _NewPtrSys
            bne.b   .L2
            move.l  A0,(A1)
            movea.l A1,A0
            _sReadStruct
            beq.b   .L2
            move.l  D0,D1
            movea.l A0,A1
            movea.l (4,A1),A0
            _DisposPtr
            movea.l A1,A0
            move.l  D1,D0
.L2:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    10
FINDSLOTSTRUCT:
            _sOffsetData
            bne.b   .L1
            _sCalcsPointer
.L1:
            rts
            ds.b    4
READSLOTSTRUCT:
            movem.l D1-D3/A1-A3,-(SP)
            move.b  ($31,A0),-(SP)
            movea.l (4,A0),A3
            move.l  A3,-(SP)
            move.l  (A0),D0
            _StripAddress
            move.l  D0,-(SP)
            movea.l D0,A1
            _sPtrToSlot
            bne.b   sub_40805A26.L4
            _sFindsInfoRecPtr
            bne.b   sub_40805A26.L4
            movea.l (A0),A2
            move.b  (9,A2),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40805A26.L4
            move.l  (A0),D1
            pea     sub_40805A26
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805A26:
            moveq   #0,D3
            move.l  (8,A0),D2
            subq.l  #1,D2
            lea     .L3,A2
            move.w  #$FECC,D0
.L1:
            move.b  (A3),(A1)+
            move.b  D1,D3
            adda.w  D3,A3
.L2:
            ror.l   #8,D1
            tst.b   D1
            beq.b   .L2
            dbra    D2,.L1
            moveq   #0,D0
.L3:
            pea     .L4
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
.L4:
            move.l  (SP)+,(A0)
            move.l  (SP)+,(4,A0)
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1-D3/A1-A3
            tst.w   D0
            rts
            ds.b    8
READSLOTINFO:
            movem.l A2,-(SP)
            movea.l (A0),A2
            move.l  A2,-(SP)
            _sFindsInfoRecPtr
            bne.w   .L2
            movea.l (A0),A1
            moveq   #$F,D2
.L1:
            move.b  (A1)+,(A2)+
            dbra    D2,.L1
            moveq   #0,D0
.L2:
            move.l  (SP)+,(A0)
            movem.l (SP)+,A2
            rts
            ds.b    12
SLOTDISPOSPTR:
            move.l  A0,-(SP)
            movea.l (4,A0),A0
            _DisposPtr
            beq.b   .L1
            move.l  #$FFFFFEC8,D0
.L1:
            movea.l (SP)+,A0
            rts
            ds.b    12
READSLOTDRVRNAME:
            movem.l A2-A3,-(SP)
            move.b  ($32,A0),D2
            movea.l (A0),A3
            move.l  A3,-(SP)
            clr.b   ($33,A0)
            clr.l   ($18,A0)
            _sGetsRsrcPtr
            bne.b   .L2
            move.b  #2,($32,A0)
            _sGetcString
            bne.b   .L2
            movea.l (A0),A2
            move.l  (8,A0),D1
            subq.b  #1,D1
            cmpi.l  #$FE,D1
            bhi.b   .L1
            move.b  ($B,A0),(A3)+
            move.b  #$2E,(A3)+
            movem.l A0-A1,-(SP)
            movea.l A2,A0
            movea.l A3,A1
            move.l  D1,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            bne.b   .L1
            exg     A2,A0
            _DisposPtr
            movea.l A2,A0
            moveq   #0,D0
            bra.b   .L3
.L1:
            exg     A2,A0
            _DisposPtr
            movea.l A2,A0
.L2:
            move.l  #$FFFFFEAA,D0
.L3:
            move.l  (SP)+,(A0)
            move.b  D2,($32,A0)
            movem.l (SP)+,A2-A3
            rts
            ds.b    14
FINDDEVBASE:
            move.l  A1,-(SP)
            move.b  ($32,A0),-(SP)
            move.l  ($18,A0),-(SP)
            clr.l   ($18,A0)
            bset    #1,($1B,A0)
            pea     sub_40805B62
            move.l  ([SDMJmpTblPtr.w],$2C.w),-(SP)
            rts
sub_40805B62:
            bne.b   .L5
            moveq   #0,D2
            move.b  ($31,A0),D2
            move.b  #$A,($32,A0)
            _sReadLong
            bne.b   .L1
            move.l  (A0),D1
            andi.l  #$FFFFFF,D1
            bra.b   .L2
.L1:
            move.b  #$C,($32,A0)
            _sReadLong
            bne.b   .L5
            move.l  (A0),D1
            andi.l  #$FFFFFFF,D1
            ror.l   #4,D2
            or.l    D1,D2
            bra.b   .L4
.L2:
            move.l  #$F0000000,D0
            or.l    D1,D0
            bfins   D2,D0{4:4}
            bfins   D2,D0{8:4}
            move.l  D0,D2
            nop
            nop
            nop
            tst.b   ($31,A0)
            bne.b   .L3
            movea.l UnivInfoPtr,A1
            adda.l  (8,A1),A1
            move.l  (8,A1),D2
            move.l  (4,A1),D1
.L3:
            move.b  #7,($32,A0)
            _sReadWord
            bne.b   .L4
            bsr.l   Overpatch
            nop
.L4:
            move.l  D2,(A0)
            moveq   #0,D0
.L5:
            move.l  (SP)+,($18,A0)
            move.b  (SP)+,($32,A0)
            movem.l (SP)+,A1
            rts
            dc.w    0
CARDCHANGED:
            clr.b   (3,A0)
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A1
            btst    #1,($B,A1)
            sne     (3,A0)
            moveq   #0,D0
.L1:
            rts
            ds.b    6
SLOTEXEC:
            dc.w    $6028
sub_40805C12:
            cmpi.b  #2,(A2)
            beq.b   .L1
            move.l  #$FFFFFEB3,D0
            bra.b   .L3
.L1:
            cmpi.b  #2,(1,A2)
            bls.b   .L2
            move.l  #$FFFFFEB2,D0
            bra.b   .L3
.L2:
            addq.l  #4,A2
            movea.l (A2),A1
            adda.l  A1,A2
            moveq   #0,D0
.L3:
            rts
            movem.l D3-D4/A2-A3,-(SP)
            move.l  (4,A0),-(SP)
            _sGetBlock
            bne.b   .L5
            movea.l (A0),A2
            movea.l A2,A3
            bsr.b   sub_40805C12
            bne.b   .L4
            bsr.l   SLOTMGRPATCH
            bra.b   .L4
            ds.b    8
.L4:
            exg     D0,D2
            exg     A3,A0
            _DisposPtr
            movea.l A3,A0
            exg     D2,D0
.L5:
            move.l  (SP)+,(4,A0)
            movem.l (SP)+,D3-D4/A2-A3
            rts
            ds.b    12
CALCSPOINTER:
            movem.l D3-D6,-(SP)
            movea.l (4,A0),A1
            moveq   #0,D1
            move.w  A1,D1
            andi.b  #3,D1
            btst    D1,($35,A0)
            bne.b   .L1
            move.l  #$FFFFFEA6,D0
            bra.b   .L10
.L1:
            moveq   #0,D2
            moveq   #3,D3
.L2:
            btst    D3,($35,A0)
            beq.b   .L3
            addq.w  #1,D2
.L3:
            dbra    D3,.L2
            tst.b   D2
            bne.b   .L4
            move.l  #$FFFFFEA5,D0
            bra.b   .L10
.L4:
            move.l  ($C,A0),D4
            btst    #$17,D4
            beq.b   .L5
            ori.l   #$FF000000,D4
.L5:
            move.l  D4,D5
            divsl.l D2,D6:D5
            lsl.l   #2,D5
            tst.b   D6
            beq.b   .L9
            bpl.b   .L7
            neg.w   D6
            subq.w  #1,D6
.L6:
            subq.b  #1,D1
            andi.b  #3,D1
            subq.l  #1,D5
            btst    D1,($35,A0)
            beq.b   .L6
            dbra    D6,.L6
            bra.b   .L9
.L7:
            subq.w  #1,D6
.L8:
            addq.b  #1,D1
            andi.b  #3,D1
            addq.l  #1,D5
            btst    D1,($35,A0)
            beq.b   .L8
            dbra    D6,.L8
.L9:
            add.l   D5,(4,A0)
            moveq   #0,D0
.L10:
            movem.l (SP)+,D3-D6
            rts
GETSLOTDRVR:
            bra.w   sub_40805D4A.L5
DynLoadDrvr:
            clr.l   ($18,A0)
            _sGetsRsrcPtr
            bne.b   .L1
            move.b  #5,($32,A0)
            _sExec
            bne.b   .L1
            movea.l ($14,A0),A2
            tst.w   (2,A2)
            bne.b   .L1
            move.l  (8,A2),(A0)
            move.b  (4,A2),($36,A0)
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.l  #$FFFFFEA7,D0
.L2:
            rts
sub_40805D4A:
            _sRsrcInfo
            bne.b   .L3
            move.b  #4,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.b  #2,($32,A0)
            bset    #1,($36,A0)
            _sReadPBSize
            beq.b   .L1
            move.b  #1,($32,A0)
            bset    #1,($36,A0)
            _sReadPBSize
            bne.b   .L3
.L1:
            subq.l  #4,(8,A0)
            move.l  (8,A0),D0
            _ResrvMem sys
            bne.b   .L3
            move.l  (8,A0),D0
            _NewHandle sys
            bne.b   .L3
            movea.l A0,A3
            move.l  (A0),D0
            _StripAddress
            move.l  D0,(A1)
            movea.l A1,A0
            _sReadStruct
            bne.b   .L2
            bsr.l   STATLOADPATCH
            bra.b   .L4
.L2:
            movea.l A3,A0
            _DisposHandle
.L3:
            movea.l A1,A0
            clr.l   (A0)
            move.l  #$FFFFFEA7,D0
.L4:
            rts
.L5:
            bra.l   SLOTGETDRIVERPATCH
ORIGGETSLOTDRVR:
            move.b  ($32,A0),D2
            bsr.w   DynLoadDrvr
            beq.b   .L1
            move.b  D2,($32,A0)
            bsr.w   sub_40805D4A
.L1:
            movea.l A1,A0
            move.b  D2,($32,A0)
            movem.l (SP)+,A2-A3
ENDGETSLOTDRVR:
            rts
StartSDeclMgr:
            suba.w  #$38,SP
            movea.l SP,A0
            jsr     INITJMPTBL
            bne.b   .L2
            bsr.b   INITSLOTMGR
            bsr.w   InitsRsrcTable
            bsr.w   InitPRAMRecs
            clr.b   ($36,A0)
            move.l  WarmStart,D0
            cmpi.l  #'WLSC',D0
            bne.b   .L1
            bset    #2,($36,A0)
.L1:
            bsr.w   PRIMARY_INIT
            moveq   #0,D0
.L2:
            lea     ($38,SP),SP
            rts
            ds.b    8
INITSLOTMGR:
            movem.l D1/A1-A2,-(SP)
            bsr.w   sub_40805E48
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            _sFindsInfoRecPtr
            movea.l (A0),A1
            tst.w   (4,A1)
            bmi.b   .L2
            bsr.w   sub_40805F2A
.L2:
            dbra    D1,.L1
            movem.l (SP)+,D1/A1-A2
            rts
sub_40805E48:
            movem.l D1-D2/A0-A3,-(SP)
            move.l  SP,SInfoPtr
            suba.w  #$14,SP
            movea.l #$FEFFFFFF,A1
            moveq   #$E,D1
            moveq   #0,D2
            movea.l UnivInfoPtr,A3
            adda.l  ($C,A3),A3
            lea     sub_40805E78.L1,A2
            pea     sub_40805E78
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805E78:
            move.w  #$FFFE,-(SP)
            bsr.l   ALLOCSLOTOVERPATCH1
            bne.b   .L2
            move.b  (A1),D0
            addq.w  #1,D2
            move.w  D2,(SP)
            bra.b   .L2
.L1:
            move.w  #$FFFF,(SP)
.L2:
            suba.l  #$1000000,A1
            subq.w  #1,D1
            bne.b   sub_40805E78
            pea     sub_40805EA8
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805EA8:
            move.l  D2,D0
            mulu.w  #$18,D0
            addi.l  #$B0,D0
            _NewPtrSysClear
            lea     ($14,A0),A0
            move.l  A0,SInfoPtr
            movea.l A0,A1
            lea     ($3C,A0),A0
            bsr.l   ALLOCSLOTOVERPATCH2
            lea     ($18,A0),A0
            move.w  #$FED4,(4,A0)
            lea     ($18,A0),A0
            move.l  ([ROMBase.w],$40.w),D0
            subq.l  #1,D0
            add.l   ROMBase,D0
            move.l  D0,($10,A0)
            move.w  #1,($C,A0)
            move.l  A0,(A1)
            move.w  #1,D0
.L1:
            movea.l A0,A2
            move.w  (SP)+,D1
            muls.w  #$18,D1
            adda.l  D1,A2
            move.l  A2,(0,A1,D0.w*4)
            move.w  #$64,($C,A2)
            move.b  D0,($14,A2)
            not.l   ($10,A2)
            bfins   D0,($10,A2){4:4}
            addq.w  #1,D0
            cmpi.w  #$E,D0
            ble.b   .L1
            lea     ($14,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            rts
sub_40805F2A:
            movem.l D1/A2,-(SP)
            suba.w  #$14,SP
            movea.l SP,A2
            move.l  A2,(A0)
            moveq   #3,D1
.L1:
            bsr.b   sub_40805F90
            bne.b   .L4
            _sReadFHeader
            bne.b   .L2
            cmpi.l  #videoMagic,($E,A2)
            bne.b   .L2
            bsr.w   sub_40805FEE
            bne.b   .L2
            bsr.w   sub_40806014
            beq.b   .L3
.L2:
            subq.l  #1,($10,A1)
            dbra    D1,.L1
            move.w  #$FECB,D0
            bra.b   .L4
.L3:
            move.l  ($10,A1),(4,A0)
            move.l  (A2),($C,A0)
            addi.l  #$FFFFFFED,($C,A0)
            _sCalcsPointer
            bne.b   .L4
            move.l  (4,A0),(A1)
.L4:
            lea     ($14,SP),SP
            move.w  D0,(4,A1)
            movem.l (SP)+,D1/A2
            rts
sub_40805F90:
            movem.l D2/A0/A2,-(SP)
            movea.l ($10,A1),A0
            pea     sub_40805FA6
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805FA6:
            lea     .L2,A2
.L1:
            move.b  (A0),D0
            moveq   #$F,D2
            and.b   D0,D2
            beq.b   .L2
            not.b   D0
            asr.w   #4,D0
            cmp.b   D0,D2
            bne.b   .L2
            btst    D1,D0
            bne.b   .L3
.L2:
            subq.w  #1,A0
            dbra    D1,.L1
            move.w  #$FECB,D0
            bra.b   .L4
.L3:
            move.b  D0,(9,A1)
            move.l  A0,($10,A1)
            move.l  A0,D0
            move.b  D0,($A,A1)
            moveq   #0,D0
.L4:
            pea     sub_40805FE8
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805FE8:
            movem.l (SP)+,D2/A0/A2
            rts
sub_40805FEE:
            cmpi.b  #1,($D,A2)
            bne.b   .L1
            cmpi.b  #9,($C,A2)
            bhi.b   .L1
            tst.b   ($12,A2)
            bne.b   .L1
            move.l  (A2),D0
            beq.b   .L1
            rol.l   #8,D0
            ext.w   D0
            beq.b   .L2
.L1:
            move.w  #$FED2,D0
.L2:
            rts
sub_40806014:
            movem.l D1-D4/A2-A4,-(SP)
            movea.l A2,A4
            move.l  (4,A4),D2
            beq.b   sub_40806058.L6
            moveq   #1,D1
            sub.l   D2,D1
            move.l  ($10,A1),(4,A0)
            move.l  D1,($C,A0)
            _sCalcsPointer
            bne.b   sub_40806058.L6
            movea.l (4,A0),A3
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806058.L6
            move.l  (A0),D4
            moveq   #0,D1
            moveq   #0,D3
            pea     sub_40806058
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40806058:
            move.w  #$FED3,D0
            lea     .L5,A2
.L1:
            rol.l   #1,D1
            cmpi.l  #$C,D2
            bhi.b   .L2
            cmpi.l  #8,D2
            bhi.b   .L3
.L2:
            move.b  (A3),D3
            add.l   D3,D1
.L3:
            move.b  D4,D3
            adda.w  D3,A3
.L4:
            ror.l   #8,D4
            tst.b   D4
            beq.b   .L4
            subq.l  #1,D2
            bne.b   .L1
            cmp.l   (8,A4),D1
            bne.b   .L5
            moveq   #0,D0
.L5:
            pea     .L6
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
.L6:
            movem.l (SP)+,D1-D4/A2-A4
            rts
InitsRsrcTable:
            movem.l A1-A2,-(SP)
            pea     sub_408060B2
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
sub_408060B2:
            move.l  A1,SRsrcTblPtr
            clr.b   ($31,A0)
            clr.w   ($24,A0)
            clr.w   ($26,A0)
            clr.b   ($33,A0)
            clr.b   ($34,A0)
.L1:
            _sFindsInfoRecPtr
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L2
            bsr.w   sub_408060EC
.L2:
            addq.b  #1,($31,A0)
            cmpi.b  #$E,($31,A0)
            ble.b   .L1
            movem.l (SP)+,A1-A2
            rts
sub_408060EC:
            movem.l D3-D5/A3,-(SP)
            move.l  (A2),(4,A0)
            move.b  (9,A2),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.w   sub_4080617E.L1
            move.l  (A0),($18,A0)
            move.l  (A2),D4
            moveq   #0,D3
.L1:
            move.l  D4,(4,A0)
            pea     sub_40806122
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806122:
            bne.b   sub_4080617E.L1
            move.l  (4,A0),D5
            move.l  D4,(4,A0)
            move.l  D5,D4
            move.b  (A0),D5
            cmpi.b  #$FF,D5
            beq.b   sub_4080617E.L1
            cmp.b   D3,D5
            bls.b   sub_4080617E.L1
            move.b  D5,D3
            move.b  D3,($32,A0)
            move.l  (A0),D5
            andi.l  #$FFFFFF,D5
            move.l  D5,($C,A0)
            _sCalcsPointer
            bne.b   sub_4080617E.L1
            cmpi.w  #$FFFF,(A1)
            bne.b   .L2
            movea.l A1,A3
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
.L1:
            move.l  A1,(2,A3)
.L2:
            clr.l   ($18,A0)
            pea     sub_4080617E
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
sub_4080617E:
            bne.b   .L1
            addq.w  #1,([SInfoPtr.w],-$12.w)
            move.l  A1,([SInfoPtr.w],-$10.w)
            adda.w  #$18,A1
            bra.w   sub_408060EC.L1
.L1:
            movem.l (SP)+,D3-D5/A3
            rts
            dc.w    0
InitPRAMRecs:
            movem.l D1-D5/A1-A2,-(SP)
            nop
            nop
            nop
            subq.w  #8,SP
            movea.l SP,A1
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            movea.l UnivInfoPtr,A2
            adda.l  ($C,A2),A2
            btst    #3,(0,A2,D1.w)
            bne.b   .L6
            clr.w   (A1)
            move.l  A1,(A0)
            _sReadPRAMrec
            move.w  (A1),D4
            clr.l   (A1)
            clr.l   (4,A1)
            moveq   #0,D5
.L2:
            move.b  D5,($32,A0)
            bsr.w   sub_4080636E
            bne.b   .L5
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L5
            cmpi.b  #2,(8,A2)
            bge.b   .L6
            move.b  ($32,A0),D5
            move.b  #$20,($32,A0)
            _sReadWord
            beq.b   .L3
            move.w  #$FEC5,(4,A2)
            bra.b   .L5
.L3:
            move.w  (2,A0),D2
            cmp.w   D4,D2
            beq.b   .L6
            tst.b   D1
            beq.b   .L2
            move.b  #$21,($32,A0)
            _sReadPBSize
            bne.b   .L4
            subq.l  #4,(8,A0)
            move.l  A1,(A0)
            _sReadStruct
            bne.b   .L4
            bset    #1,($B,A2)
.L4:
            move.w  D2,(A1)
.L5:
            move.l  A1,(4,A0)
            _sInitSlotPRAM
.L6:
            dbra    D1,.L1
            moveq   #0,D0
            addq.w  #8,SP
            movem.l (SP)+,D1-D5/A1-A2
            rts
PRIMARYINITRTN:
            move.l  A2,($14,A0)
            move.b  #$20,(1,A2)
            moveq   #0,D0
            _SwapMMUMode
            move.b  D0,-(SP)
            clr.b   ($31,A0)
            bsr.b   sub_4080627A
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            bsr.b   sub_4080627A
            subq.w  #1,D1
            bne.b   .L1
            move.b  (SP)+,D0
            _SwapMMUMode
            lea     ($18,SP),SP
            movem.l (SP)+,D1/A1-A3
            rts
sub_4080627A:
            clr.b   ($32,A0)
            bsr.w   sub_4080636E
            bne.w   .L1
            movea.l (4,A0),A3
            movea.l (A0),A1
            tst.w   (4,A1)
            bmi.b   .L1
            cmpi.b  #3,(8,A1)
            bcc.b   .L1
            move.b  #$22,($32,A0)
            _sFindStruct
            bne.b   .L1
            move.l  A2,-(SP)
            BigJmp  SLOTPRIMARYINITPATCH,A2
            ds.b    8
.L1:
            rts
SECONDARY_INIT:
            movem.l D1-D2/A1-A3,-(SP)
            suba.w  #$18,SP
            movea.l SP,A2
            move.l  A2,($14,A0)
            move.b  #$20,(1,A2)
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            clr.b   ($32,A0)
            bsr.w   sub_4080636E
            bne.b   .L4
            movea.l (4,A0),A3
            movea.l (A0),A1
            cmpi.b  #4,(8,A1)
            bcc.b   .L4
            move.w  (4,A1),D0
            bpl.b   .L2
            cmpi.w  #$FEC4,D0
            bne.b   .L4
            cmpi.w  #$8080,(6,A1)
            bgt.b   .L4
            clr.w   (4,A1)
            bset    #2,($B,A1)
.L2:
            move.w  D0,D2
            move.b  #$26,($32,A0)
            _sFindStruct
            beq.b   .L3
            move.w  D2,(4,A1)
            bclr    #2,($B,A1)
            beq.b   .L4
            move.w  #$FEC4,(4,A1)
            bra.b   .L4
.L3:
            move.l  A3,(4,A0)
            move.b  D1,(A2)
            move.b  ($36,A0),(4,A2)
            _sExec
            bclr    #2,($B,A1)
            move.b  #4,(8,A1)
            move.w  (2,A2),(6,A1)
            bpl.b   .L4
            move.w  #$FEC4,(4,A1)
.L4:
            dbra    D1,.L1
            cmpi.b  #$E,D1
            bls.w   .L1
            lea     ($18,SP),SP
            movem.l (SP)+,D1-D2/A1-A3
            rts
sub_4080636E:
            move.l  A1,-(SP)
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.l  #$10000,($28,A0)
            clr.l   ($2C,A0)
            clr.b   ($30,A0)
            clr.b   ($33,A0)
            clr.l   ($18,A0)
            ori.b   #3,($1B,A0)
            _sGetTypesRsrc
            beq.b   .L1
            move.w  #$FEC7,D0
.L1:
            move.l  A1,(A0)
            movea.l (SP)+,A1
            tst.w   D0
            rts
            ds.b    10
SLOTPRAM:
READSLOTPRAM:
            moveq   #0,D0
            move.l  (A0),($18,A0)
            bra.b   CommonPRAM
PutSlotPRAM:
            moveq   #1,D0
            move.l  (4,A0),($18,A0)
            bra.b   CommonPRAM
InitSlotPRAM:
            moveq   #2,D0
            move.l  (4,A0),($18,A0)
CommonPRAM:
            movem.l D1/D3/A0-A1,-(SP)
            clr.w   D3
            move.l  D0,D1
            move.b  ($31,A0),D3
            bne.b   .CheckRange
            nop
            nop
            nop
            nop
            movea.l UnivInfoPtr,A1
            adda.l  (8,A1),A1
            move.b  ($C,A1),D3
.CheckRange:
            movea.l ($18,A0),A1
            move.w  #$FEAF,D0
            cmpi.b  #$E,D3
            bhi.b   .Done
            cmpi.b  #9,D3
            bge.b   .InternalPRAM
            tst.w   ([SInfoPtr.w],-$13.w)
            beq.b   .Done
            bra.b   .Done
.InternalPRAM:
            subi.b  #9,D3
            mulu.w  #8,D3
            addi.w  #$46,D3
            move.l  #$80000,D0
            move.w  D3,D0
            movea.l A1,A0
            tst.b   D1
            bne.b   .WritePRAM
            _ReadXPRam
            bra.b   .Done
.WritePRAM:
            subq.l  #2,D1
            beq.b   .DoWrite
            addq.l  #2,A0
            subi.l  #$1FFFE,D0
.DoWrite:
            _WriteXPRam
.Done:
            movem.l (SP)+,D1/D3/A0-A1
            rts
            dc.w    0
FINDSINFORECPTR:
            moveq   #0,D0
            move.b  ($31,A0),D0
            cmpi.b  #$E,D0
            bhi.b   .L1
            move.l  ([SInfoPtr.w],D0.w*4),(A0)
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.w  #$FEAF,D0
.L2:
            rts
            ds.b    4
FINDSRSRCPTR:
            clr.b   ($33,A0)
            clr.l   ($18,A0)
GETSRSRCPTR:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L1
            movea.l (4,A0),A1
            move.l  ($10,A1),(4,A0)
.L1:
            movea.l (SP)+,A1
            rts
            dc.w    0
PTRTOSLOT:
            movem.l D1-D2,-(SP)
            move.w  #$FEB1,D0
            move.l  (4,A0),D1
            beq.b   .L3
            clr.b   D1
            rol.l   #4,D1
            cmpi.b  #$F,D1
            beq.b   .L1
            move.b  ROMBase,D2
            lsr.b   #4,D2
            cmp.b   D2,D1
            bhi.b   .L2
            moveq   #0,D1
            bra.b   .L2
.L1:
            clr.b   D1
            rol.l   #4,D1
.L2:
            move.w  #$FEAF,D0
            cmpi.b  #$E,D1
            bhi.b   .L3
            move.b  D1,($31,A0)
            moveq   #0,D0
.L3:
            tst.w   D0
            movem.l (SP)+,D1-D2
            rts
            ds.b    14
READFHEADER:
            movem.l A1-A2,-(SP)
            movea.l (A0),A2
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   .L1
            move.l  ($10,A1),(4,A0)
            move.l  #$FFFFFFED,($C,A0)
            move.b  (9,A1),($35,A0)
            _sCalcsPointer
            bne.b   .L1
            move.l  A2,(A0)
            move.l  #$14,(8,A0)
            _sReadStruct
.L1:
            movem.l (SP)+,A1-A2
            rts
            ds.b    14
CKCARDSTAT:
            move.l  A2,-(SP)
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L1
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.l  #$FFFFFEAB,D0
.L2:
            movea.l (SP)+,A2
            rts
            dc.w    0
SLOTVERSION:
            move.l  #2,(A0)
            clr.l   (4,A0)
            moveq   #0,D0
            rts
            dc.w    0
NEXTSRSRC:
            clr.l   ($18,A0)
            bset    #2,($1B,A0)
GETSRSRC:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L2
            movea.l (4,A0),A1
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
.L1:
            bra.b   .L3
.L2:
            move.w  #$FEA8,D0
.L3:
            movea.l (SP)+,A1
            tst.w   D0
            rts
NEXTTYPESRSRC:
            clr.l   ($18,A0)
GETTYPESRSRC:
            movem.l D1-D6/A1,-(SP)
            moveq   #0,D0
            move.b  ($30,A0),D0
            lea     sub_408065E6.L2,A1
            lsr.b   #2,D0
            move.l  (0,A1,D0.w*4),D1
            move.b  ($30,A0),D0
            andi.b  #3,D0
            move.l  (0,A1,D0.w*4),D2
            move.l  ($28,A0),D3
            move.l  ($2C,A0),D4
            and.l   D1,D3
            and.l   D2,D4
.L1:
            bset    #2,($1B,A0)
            _sFindSRTRec
            bne.b   sub_408065E6.L1
            movea.l (4,A0),A1
            move.l  (A1),($31,A0)
            move.l  D1,D5
            and.l   (8,A1),D5
            cmp.l   D3,D5
            bne.b   .L1
            move.l  D2,D6
            and.l   ($C,A1),D6
            cmp.l   D4,D6
            bne.b   .L1
            pea     sub_408065E6
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
sub_408065E6:
            moveq   #0,D0
            nop
.L1:
            movem.l (SP)+,D1-D6/A1
            rts
.L2:
            dc.w    $FFFF,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF
            ds.b    4
UPDATESRT:
            moveq   #1,D0
            clr.l   (4,A0)
            clr.l   ($18,A0)
            bra.b   sub_4080660E
INSERTSRT:
            moveq   #0,D0
sub_4080660E:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  D0,D1
            movea.l (4,A0),A2
            move.l  ($18,A0),D2
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            beq.b   .L2
            move.l  A2,(4,A0)
            move.l  D2,($18,A0)
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D0.w),-(SP)
            rts
.L1:
            bra.b   .L5
.L2:
            movea.l (4,A0),A1
            tst.w   D1
            beq.b   .L3
            move.w  #$FEA8,D0
            btst    #0,($17,A1)
            bne.b   .L5
            move.w  ($24,A0),(6,A1)
            move.w  ($26,A0),(4,A1)
            moveq   #0,D0
            bra.b   .L5
.L3:
            move.l  A2,D0
            beq.b   .L5
            move.l  A2,(4,A0)
            move.l  D2,($18,A0)
            pea     .L4
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
.L4:
            nop
.L5:
            movem.l (SP)+,D1-D2/A1-A2
            rts
SEARCHSRT:
            clr.l   ($18,A0)
            btst    #0,($36,A0)
            beq.b   FINDSRTREC
            bset    #2,($1B,A0)
FINDSRTREC:
            movem.l D2-D4/A1-A3,-(SP)
            movea.l SRsrcTblPtr,A1
            move.l  ($31,A0),D2
            clr.b   D2
            movea.l A1,A2
            movea.l A1,A3
            move.l  MinusOne,D3
.L1:
            bsr.w   GetSRTEntry
            bne.b   .L4
            move.l  (A1),D4
            clr.b   D4
            cmp.l   D2,D4
            bgt.b   .L2
            blt.b   .L3
            movea.l A1,A2
            btst    #2,($1B,A0)
            beq.b   .L6
            bra.b   .L3
.L2:
            cmp.l   D3,D4
            bhi.b   .L3
            movea.l A1,A3
            move.l  D4,D3
.L3:
            lea     ($18,A1),A1
            bra.b   .L1
.L4:
            tst.l   D3
            bmi.b   .L5
            moveq   #0,D0
            movea.l A3,A2
            btst    #2,($1B,A0)
            beq.b   .L5
            btst    #1,($1B,A0)
            beq.b   .L6
            move.b  ($31,A0),D1
            cmp.b   (A2),D1
            beq.b   .L6
.L5:
            move.w  #$FEA8,D0
.L6:
            move.l  A2,(4,A0)
            movem.l (SP)+,D2-D4/A1-A3
            tst.w   D0
            rts
DELETESRTREC:
            movem.l A0-A2,-(SP)
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            bne.w   .L5
            movea.l (4,A0),A1
            move.w  #$FF01,(A1)
            movea.l ([SInfoPtr.w],-$10.w),A2
            move.w  #$17,D0
.L1:
            move.b  (A2)+,(A1)+
            dbra    D0,.L1
            movea.l ([SInfoPtr.w],-$10.w),A2
            move.w  #$FF01,(A2)
            subq.w  #1,([SInfoPtr.w],-$12.w)
            move.w  ([SInfoPtr.w],-$12.w),D0
            divu.w  #8,D0
            andi.l  #$FFFF0000,D0
            bne.b   .L4
            move.b  MMU32bit,-(SP)
            clr.b   D0
            _SwapMMUMode
            movea.l A2,A0
            _DisposPtr
            move.b  (SP)+,D0
            _SwapMMUMode
            movea.l SRsrcTblPtr,A1
.L2:
            lea     ($C0,A1),A1
            cmpa.l  (2,A1),A2
            beq.b   .L3
            movea.l (2,A1),A1
            bra.b   .L2
.L3:
            clr.l   (2,A1)
            movea.l A1,A2
.L4:
            suba.w  #$18,A2
            move.l  A2,([SInfoPtr.w],-$10.w)
            moveq   #0,D0
            bra.b   .L6
.L5:
            move.w  #$FEA1,D0
.L6:
            movem.l (SP)+,A0-A2
            rts
SLOTRSRCINFO:
            clr.l   ($18,A0)
GETSRSRCINFO:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L2
            movea.l (4,A0),A1
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
.L1:
            bra.b   .L2
            move.w  #$FEA1,D0
.L2:
            movea.l (SP)+,A1
            rts
SETSRSRCSTATE:
            movem.l D1/A1,-(SP)
            move.l  ($18,A0),D1
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            bne.b   .L1
            movea.l (4,A0),A1
            bclr    #0,($17,A1)
            tst.b   D1
            beq.b   .L1
            bset    #0,($17,A1)
            moveq   #0,D0
.L1:
            move.l  D1,($18,A0)
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
PNEWSRTENTRY:
            movem.l D1/A1-A2,-(SP)
            move.l  (4,A0),D0
            bne.b   .L1
            move.l  ($18,A0),D1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.l  (A1),(4,A0)
            _sFindStruct
            bne.b   sub_4080686A.L1
            move.l  D1,($18,A0)
.L1:
            movea.l ([SInfoPtr.w],-$10.w),A1
.L2:
            cmpi.w  #$FF01,(A1)
            beq.b   sub_40806856.L1
            cmpi.w  #$FFFF,(A1)
            beq.b   .L3
            lea     ($18,A1),A1
            bra.b   .L2
.L3:
            movea.l A1,A2
            pea     sub_40806856
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
sub_40806856:
            bne.b   sub_4080686A.L1
            move.l  A1,(2,A2)
.L1:
            pea     sub_4080686A
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
sub_4080686A:
            bne.b   .L1
            addq.w  #1,([SInfoPtr.w],-$12.w)
            move.l  A1,([SInfoPtr.w],-$10.w)
.L1:
            movem.l (SP)+,D1/A1-A2
            rts
PINITENTRY:
            movem.l D1/A2,-(SP)
            subq.w  #8,SP
            movea.l SP,A2
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            move.b  ($33,A0),(2,A1)
            clr.b   (3,A1)
            move.w  ($26,A0),(4,A1)
            move.w  ($24,A0),(6,A1)
            move.l  (4,A0),($10,A1)
            clr.l   ($14,A1)
            move.l  ($18,A0),D0
            beq.b   .L1
            bset    #0,($17,A1)
.L1:
            move.b  #8,($32,A0)
            _sReadByte
            bne.b   .L2
            move.b  (3,A0),(3,A1)
.L2:
            move.b  #1,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.l  #8,(8,A0)
            move.l  A2,(A0)
            _sReadStruct
            bne.b   .L3
            move.l  (A2),(8,A1)
            move.l  (4,A2),($C,A1)
            moveq   #0,D0
            move.w  ($26,A0),D1
            beq.b   .L4
            bsr.b   sub_40806930
            bne.b   .L3
            _sFindDevBase
            bne.b   .L3
            move.l  (A0),($2A,A2)
            move.b  (1,A1),($29,A2)
            move.b  (2,A1),($32,A2)
            bra.b   .L4
.L3:
            move.w  #$FF01,(A1)
.L4:
            move.l  ($10,A1),(4,A0)
            addq.w  #8,SP
            movem.l (SP)+,D1/A2
            tst.w   D0
            rts
sub_40806930:
            move.w  #$FFCD,D0
            not.w   D1
            bmi.b   .L1
            cmp.w   UnitNtryCnt,D1
            bge.b   .L1
            asl.w   #2,D1
            movea.l UTableBase,A2
            move.l  (0,A2,D1.w),D1
            beq.b   .L1
            movea.l D1,A2
            move.l  (A2),D1
            beq.b   .L2
            movea.l D1,A2
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
.L2:
            moveq   #$E,D0
            _SysError
PALLOCSRTBLK:
            move.l  A0,-(SP)
            move.l  #$C6,D0
            _NewPtrSysClear
            bne.b   .L2
            movea.l A0,A1
            move.w  #7,D0
.L1:
            move.w  #$FF01,(A0)
            lea     ($18,A0),A0
            dbra    D0,.L1
            move.w  #$FFFF,(A0)
            moveq   #0,D0
.L2:
            movea.l (SP)+,A0
            rts
GetSRTEntry:
            movem.l D1-D2/A0,-(SP)
.Loop:
            move.w  (A1),D1
            bmi.b   .ChkEnd
            btst    #0,($1B,A0)
            bne.b   .L5
            btst    #0,($17,A1)
            beq.b   .L5
            bra.b   .EndLoop
.ChkEnd:
            cmpi.w  #$FFFF,D1
            bne.b   .EndLoop
            tst.l   (2,A1)
            beq.b   .NoMore
            movea.l (2,A1),A1
            bra.b   .Loop
.EndLoop:
            lea     ($18,A1),A1
            bra.b   .Loop
.NoMore:
            move.w  #$FEA1,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movem.l (SP)+,D1-D2/A0
            rts
PSRTOSPBLOCK:
            move.b  (A1),($31,A0)
            move.b  (1,A1),($32,A0)
            move.b  (2,A1),($33,A0)
            move.b  (3,A1),($34,A0)
            move.w  (4,A1),($26,A0)
            move.w  (6,A1),($24,A0)
            move.w  (8,A1),($28,A0)
            move.w  ($A,A1),($2A,A0)
            move.w  ($C,A1),($2C,A0)
            move.w  ($E,A1),($2E,A0)
            move.l  ($10,A1),(4,A0)
            clr.l   ($18,A0)
            btst    #0,($17,A1)
            beq.b   .L1
            move.l  #1,($18,A0)
.L1:
            rts
            ds.b    6
CALCSTEP:
            movem.l D1-D3/A1,-(SP)
            move.w  #$FEA6,D0
            clr.w   D1
            clr.w   D2
            move.b  (7,A0),D1
            andi.l  #3,D1
            move.b  ($35,A0),D2
            btst    D1,D2
            beq.b   .L3
            move.l  D2,D3
            asl.w   #2,D3
            btst    #5,($36,A0)
            beq.b   .L1
            lea     .L4,A1
            move.l  (0,A1,D3.w),D2
            mulu.w  #8,D1
            ror.l   D1,D2
            move.l  D2,(A0)
            bra.b   .L2
.L1:
            lea     .L5,A1
            move.l  (0,A1,D3.w),(A0)
            bpl.b   .L2
            lea     .L6,A1
            andi.b  #7,D2
            subq.b  #3,D2
            asl.l   #4,D2
            adda.l  D1,A1
            move.l  (0,A1,D2.w),(A0)
.L2:
            clr.w   D0
.L3:
            movem.l (SP)+,D1-D3/A1
            rts
.L4:
            ds.b    4
            dc.w    $0404,$0404,$0404,$0404,$0301,$0301,$0404,$0404
            dc.w    $0202,$0202,$0301,$0301,$0002,$0101,$0404,$0404
            dc.w    $0103,$0103,$0202,$0202,$0001,$0201,$0301,$0301
            dc.w    $0001,$0102,$0002,$0101,$0101,$0101
.L5:
            ds.b    4
            dc.w    $1010,$1010,$1010,$1010,$0808,$0808,$1010,$1010
            dc.w    $0808,$0808,$0808,$0808,$FFFF,$FFFF,$1010,$1010
            dc.w    $0808,$0808,$0808,$0808,$FFFF,$FFFF,$0808,$0808
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$0404,$0404
.L6:
            dc.w    $0505,$0505,$0606,$0606
            ds.b    4
            dc.w    $0505,$0505
            ds.b    16
            dc.w    $0606,$0606
            ds.b    4
            dc.w    $0505,$0505,$0505,$0505
            ds.b    4
            dc.w    $0505,$0505,$0505,$0505,$0606,$0606,$0505,$0505
            dc.w    $0505,$0505,$0606,$0606
            ds.b    4
OFFSETDATA:
            movem.l D1-D2/A1,-(SP)
            move.b  ($31,A0),-(SP)
            move.w  #$FEB6,D0
            cmpi.b  #$FF,($32,A0)
            beq.w   sub_40806BA6.L1
            _sPtrToSlot
            bne.w   sub_40806BA6.L1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   sub_40806BA6.L1
            move.b  (9,A1),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806BA6.L1
            move.l  (A0),($18,A0)
            moveq   #0,D1
.L1:
            move.b  D1,D2
            movea.l (4,A0),A1
            pea     sub_40806BA6
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806BA6:
            bne.b   .L1
            move.b  (A0),D1
            move.w  #$FEB5,D0
            cmp.b   D2,D1
            bcs.b   .L1
            move.w  #$FEB6,D0
            cmpi.b  #$FF,D1
            beq.b   .L1
            cmp.b   ($32,A0),D1
            bne.b   OFFSETDATA.L1
            move.l  (A0),D0
            andi.l  #$FFFFFF,D0
            move.l  D0,($C,A0)
            move.l  A1,(4,A0)
            moveq   #0,D0
.L1:
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1-D2/A1
            tst.w   D0
            rts
READPBSIZE:
            movem.l D1/A1,-(SP)
            move.b  ($31,A0),-(SP)
            _sFindStruct
            bne.b   sub_40806C24.L1
            _sPtrToSlot
            bne.b   sub_40806C24.L1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   sub_40806C24.L1
            move.b  (9,A1),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806C24.L1
            move.l  (A0),($18,A0)
            pea     sub_40806C24
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806C24:
            bne.b   .L1
            move.l  (A0),(8,A0)
            moveq   #0,D0
            btst    #1,($36,A0)
            beq.b   .L1
            move.b  (A0),D1
            beq.b   .L1
            move.w  #$FEB4,D0
.L1:
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
            ds.b    8
PREAD4BYTES:
            movem.l D1-D4/A1-A2,-(SP)
            move.l  ($18,A0),D2
            movea.l (4,A0),A1
            moveq   #3,D3
            moveq   #0,D4
            pea     sub_40806C6E
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40806C6E:
            lea     .L3,A2
            move.w  #$FECC,D0
.L1:
            asl.l   #8,D1
            move.b  (A1),D1
            move.b  D2,D4
            adda.w  D4,A1
.L2:
            ror.l   #8,D2
            tst.b   D2
            beq.b   .L2
            dbra    D3,.L1
            move.l  D1,(A0)
            move.l  A1,(4,A0)
            moveq   #0,D0
.L3:
            pea     sub_40806C9E
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40806C9E:
            movem.l (SP)+,D1-D4/A1-A2
            rts
            ds.b    12
PBUSEXCEPTION:
            move.l  D0,-(SP)
            move.w  ($E,SP),D0
            andi.w  #$F1C0,D0
            cmpi.w  #$140,D0
            bne.b   .L1
            move.b  ($A,SP),D0
            lsr.b   #4,D0
            cmpi.b  #$B,D0
            bne.b   .L1
            move.b  ($14,SP),D0
            cmpi.b  #$90,D0
            bcs.b   .L1
            cmpi.b  #$FF,D0
            beq.b   .L1
            cmpi.b  #$F0,D0
            beq.b   .L1
            move.l  A0,-(SP)
            BigJmp  SLOTBUSEXCPTNPTCH,A0
.L1:
            move.l  (SP)+,D0
            move.l  ([SInfoPtr.w],-8.w),-(SP)
            rts
; pInstallBus
; Install the slot manager's bus exception vector
pInstallBus:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #1,D0
            _SwapMMUMode
            move.b  D0,([SInfoPtr.w],-4.w)
            move.l  BusErrVct,([SInfoPtr.w],-8.w)
            move.l  ([SDMJmpTblPtr.w],$E4.w),BusErrVct
            move    (SP)+,SR
            rts
pRestoreBus:
            move.l  D0,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            move.b  ([SInfoPtr.w],-4.w),D0
            _SwapMMUMode
            move.l  ([SInfoPtr.w],-8.w),BusErrVct
            move    (SP)+,SR
            move.l  (SP)+,D0
            rts
PRIMARY_INIT:
            movem.l D1/A1-A3,-(SP)
            suba.w  #$18,SP
            movea.l SP,A2
            jmp     PRIMARYINITRTN
            ds.b    12
INITJMPTBL:
            movem.l A0-A2,-(SP)
            cmpi.l  #$FFFFFFFF,SDMJmpTblPtr
            beq.b   .L1
            movea.l SDMJmpTblPtr,A0
            _DisposPtr
.L1:
            move.l  #$F4,D0
            _NewPtrSysClear
            move.l  A0,SDMJmpTblPtr
            moveq   #$3C,D0
            lea     SDMJmpTable,A1
.Loop:
            movea.l A1,A2
            adda.w  (A1)+,A2
            move.l  A2,(A0)+
            dbra    D0,.Loop
            bra.l   INITJMPTBLPATCH
            dc.w    0
SDMJmpTable:
            ; Principal
            dc.w    READSLOTBYTE-*                  ; $00
            dc.w    READSLOTWORD-*                  ; $01
            dc.w    READSLOTLONG-*                  ; $02
            dc.w    GETCSTRING-*                    ; $03
            dc.w    SlotEmpty-*                     ; $04
            dc.w    GETSLOTBLOCK-*                  ; $05
            dc.w    FINDSLOTSTRUCT-*                ; $06
            dc.w    READSLOTSTRUCT-*                ; $07
            dc.w    SLOTVERSION-*                   ; $08
            dc.w    SETSRSRCSTATE-*                 ; $09
            dc.w    INSERTSRT-*                     ; $0A
            dc.w    GETSRSRC-*                      ; $0B
            dc.w    GETTYPESRSRC-*                  ; $0C
            dc.w    SlotEmpty-*                     ; $0D
            dc.w    SlotEmpty-*                     ; $0E
            dc.w    SlotEmpty-*                     ; $0F
            ; Specialized
            dc.w    READSLOTINFO-*                  ; $10
            dc.w    READSLOTPRAM-*                  ; $11
            dc.w    PutSlotPRAM-*                   ; $12
            dc.w    READFHEADER-*                   ; $13
            dc.w    NEXTSRSRC-*                     ; $14
            dc.w    NEXTTYPESRSRC-*                 ; $15
            dc.w    SLOTRSRCINFO-*                  ; $16
            dc.w    SLOTDISPOSPTR-*                 ; $17
            dc.w    CKCARDSTAT-*                    ; $18
            dc.w    READSLOTDRVRNAME-*              ; $19
            dc.w    FINDSRTREC-*                    ; $1A
            dc.w    FINDDEVBASE-*                   ; $1B
            dc.w    FINDDEVBASE-*                   ; $1C
            dc.w    GETSRSRCPTR-*                   ; $1D
            dc.w    SlotEmpty-*                     ; $1E
            dc.w    SlotEmpty-*                     ; $1F
            ; Advanced (SDM private routines)
            dc.w    INITSLOTMGR-*                   ; $20
            dc.w    PRIMARY_INIT-*                  ; $21
            dc.w    CARDCHANGED-*                   ; $22
            dc.w    SLOTEXEC-*                      ; $23
            dc.w    OFFSETDATA-*                    ; $24
            dc.w    InitPRAMRecs-*                  ; $25
            dc.w    READPBSIZE-*                    ; $26
            dc.w    SlotEmpty-*                     ; $27
            dc.w    CALCSTEP-*                      ; $28
            dc.w    InitsRsrcTable-*                ; $29
            dc.w    SEARCHSRT-*                     ; $2A
            dc.w    UPDATESRT-*                     ; $2B
            dc.w    CALCSPOINTER-*                  ; $2C
            dc.w    GETSLOTDRVR-*                   ; $2D
            dc.w    PTRTOSLOT-*                     ; $2E
            dc.w    FINDSINFORECPTR-*               ; $2F
            dc.w    FINDSRSRCPTR-*                  ; $30
            dc.w    DELETESRTREC-*                  ; $31
            dc.w    SECONDARY_INIT-*                ; $32
            dc.w    InitSlotPRAM-*                  ; $33
            ; Private routines, vectored to directly
            dc.w    PNEWSRTENTRY-*                  ; $34
            dc.w    PINITENTRY-*                    ; $35
            dc.w    PSRTOSPBLOCK-*                  ; $36
            dc.w    PREAD4BYTES-*                   ; $37
            dc.w    SlotEmpty-*                     ; $38
            dc.w    PBUSEXCEPTION-*                 ; $39
            dc.w    pInstallBus-*                   ; $3A
            dc.w    pRestoreBus-*                   ; $3B
            dc.w    PALLOCSRTBLK-*                  ; $3C
            dc.b    '2.10'
SlotManager:
            cmpi.w  #$3D,D0
            bhi.b   SlotEmpty
            movea.l ([SDMJmpTblPtr.w],D0.w*4),A1
            jmp     (A1)
SlotEmpty:
            move.w  #-338,D0
            rts
            ds.b    6

            EVEN
