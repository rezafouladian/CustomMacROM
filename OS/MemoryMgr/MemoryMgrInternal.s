            include "Include/ROMHeader.s"

            EXPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,DHBusErrHandler,HeapGuts
            EXPORT  A24ACTUALS,A24HMAKEMOREMASTERS,A24MAKEPTRSPC,A24MAXLIMIT,A24NEXTMASTER,A24SETSIZE
            EXPORT  A24TOTEPURGEABLES,A24ZONEADJUSTEND,A32ACTUALS,A32ALLOCBK,A32GETSIZE,A32HMAKEMOREMASTERS
            EXPORT  A32MAKEPTRSPC,A32MAXLIMIT,A32NEXTMASTER,A32SETSIZE,A32TOTEPURGEABLES,A32ZONEADJUSTEND
            EXPORT  ClearGZStuff,MMEpilogue,MMHPrologue,MMMMPrologue,MMNoErrEpilogue,MMNoPrologue
            EXPORT  MMPPrologue,MMPrologue,MMRHPrologue,ReleaseMP,StdGZ,a24AllocBk
            EXPORT  a24EH,a24FreeBk,a24GetSize,a24MakeBkF,a24PurgeHeap,a32EH
            EXPORT  a32FreeBk,a32MakeBkF,a32PurgeHeap

            IMPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            IMPORT  DerefHandlePatch,V24PURGESPACEPATCH,V32PURGESPACEPATCH,ZoneCheckPatch

            SECTION "MemoryMgrInternal",CODE

HeapGuts:
ZCBUSERRHANDLER:
            andi.w  #$FEFF,($A,SP)
            clr.l   ($2C,SP)
            rte
DHBusErrHandler:
            andi.w  #$FEFF,($A,SP)
            moveq   #-1,D0
            move.l  D0,($2C,SP)
            rte
sub_4080DB6A:
            bsr.l   DerefHandlePatch
            nop
            nop
            nop
            btst    #0,MMFlags
            bne.b   .L1
            move.l  A0,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            movea.l D0,A1
            beq.b   .L3
            bra.b   .L2
.L1:
            move.l  A0,D0
            movea.l D0,A1
            beq.b   .L3
.L2:
            movea.l (A1),A0
.L3:
            move.l  A2,BusErrVct
            move.l  A0,D0
            rts
sub_4080DB9C:
            btst    #0,MMFlags
            bne.b   .L5
            move.l  A0,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            subq.l  #8,A0
            tst.b   (A0)
            beq.b   .L4
            bmi.b   .L1
            btst    #6,(A0)
            beq.b   .L4
            movea.l (4,A0),A6
            bra.b   .L2
.L1:
            movea.l A1,A6
            suba.l  (4,A0),A6
.L2:
            bsr.b   sub_4080DBF8
.L3:
            addq.l  #8,A0
            rts
.L4:
            moveq   #-$6F,D0
            bra.b   .L3
.L5:
            suba.w  #$C,A0
            tst.b   (A0)
            beq.b   .L9
            bmi.b   .L6
            btst    #6,(A0)
            beq.b   .L9
            movea.l (8,A0),A6
            bra.b   .L7
.L6:
            movea.l A1,A6
            suba.l  (8,A0),A6
.L7:
            bsr.b   sub_4080DBF8
.L8:
            adda.w  #$C,A0
            rts
.L9:
            moveq   #-$6F,D0
            bra.b   .L8
sub_4080DBF8:
            bsr.l   ZoneCheckPatch
            nop
            nop
            nop
            btst    #0,MMFlags
            beq.b   .L1
            move.l  ($3C,A6),D0
            bra.b   .L2
.L1:
            move.l  A6,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A6
            move.l  ($38,A6),D0
            and.l   Lo3Bytes,D0
.L2:
            move.l  A2,BusErrVct
            sub.l   A6,D0
            beq.b   .L3
            moveq   #-$71,D0
.L3:
            rts
MMPPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            suba.l  A1,A1
            bsr.w   sub_4080DB9C
            bmi.b   .L3
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L2
            move.l  #$1E00,D3
.L2:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L3:
            tst.w   (SP)+
            bne.w   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMHPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            bsr.w   sub_4080DB6A
            beq.b   .L4
            cmp.l   MinusOne,D0
            beq.b   .L7
            bsr.w   sub_4080DB9C
.L2:
            bmi.b   .L7
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L3
            move.l  #$1E00,D3
.L3:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            move.l  A0,D7
            rts
.L4:
            move.l  A1,D0
            beq.b   .L6
            cmpa.l  ApplZone,A6
            beq.b   .L5
            cmpa.l  SysZone,A6
            bne.b   .L6
            movea.l ApplZone,A6
.L5:
            cmp.l   A6,D0
            bhi.b   .L6
            movea.l SysZone,A6
.L6:
            bsr.w   sub_4080DBF8
            bra.b   .L2
.L7:
            tst.w   (SP)+
            bne.b   .L8
            movea.l A1,A0
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
.L8:
            bra.w   MMEpilogue.L1
MMNoPrologue:
            move.l  A0,-(SP)
            movea.l (4,SP),A0
            btst    #0,MMFlags
            bne.b   .L1
            adda.w  #$1E00,A0
            bra.b   .L2
.L1:
            adda.w  #$1F00,A0
.L2:
            move.l  (A0),(4,SP)
            movea.l (SP)+,A0
            rts
MMMMPrologue:
            movea.l (SP)+,A1
            move.l  A6,-(SP)
            movea.l TheZone,A6
            move.l  ($20,A6),D0
            bne.b   .L1
            move.l  #$1E00,D0
.L1:
            adda.l  D0,A1
            move.l  (A1),-(SP)
            rts
MMPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            btst    #$A,D1
            beq.b   .L2
            movea.l SysZone,A6
.L2:
            bsr.w   sub_4080DBF8
            bmi.b   .L4
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L3
            move.l  #$1E00,D3
.L3:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L4:
            tst.w   (SP)+
            bne.b   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMRHPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            btst    #$A,D1
            bne.b   .L2
            cmpa.l  SysZone,A6
            beq.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L5
.L2:
            movea.l SysZone,A6
.L3:
            move.l  A0,D0
            btst    #0,MMFlags
            bne.b   .L4
            and.l   Lo3Bytes,D0
.L4:
            cmp.l   ApplZone,D0
            bls.b   .L5
            movea.l ApplZone,A6
.L5:
            bsr.w   sub_4080DBF8
            bmi.b   .L7
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L6
            move.l  #$1E00,D3
.L6:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L7:
            tst.w   (SP)+
            bne.w   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMEpilogue:
            clr.w   MemErr
            tst.l   D0
            bge.b   MMNoErrEpilogue
.L1:
            move.w  D0,MemErr
MMNoErrEpilogue:
            move.b  (SP)+,MMFlags
            movem.l (SP)+,D3-D7/A2-A6
            rts
a24MakeBkF:
            move.l  D0,(A0)
            clr.b   (A0)
            rts
a32MakeBkF:
            move.l  D0,(4,A0)
            clr.l   (A0)
            rts
sub_4080DDFC:
            movem.l D0/A1,-(SP)
            movea.l A0,A1
            adda.l  D0,A1
.L1:
            tst.b   (A1)
            bne.b   .L2
            cmpa.l  (A6),A1
            bcc.b   .L2
            add.l   (A1),D0
            adda.l  (A1),A1
            bra.b   .L1
.L2:
            move.l  D0,(A0)
            clr.b   (A0)
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/A1
            rts
sub_4080DE20:
            movem.l D0/A1,-(SP)
            movea.l A0,A1
            adda.l  D0,A1
.L1:
            tst.b   (A1)
            bne.b   .L2
            cmpa.l  (A6),A1
            bcc.b   .L2
            add.l   (4,A1),D0
            adda.l  (4,A1),A1
            bra.b   .L1
.L2:
            move.l  D0,(4,A0)
            clr.l   (A0)
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/A1
            rts
a24EH:
            btst    #7,(A1)
            bne.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            subq.l  #8,A0
            bsr.b   a24PurgeBlock
            addq.l  #8,A0
.L1:
            moveq   #0,D0
.L2:
            rts
.L3:
            moveq   #-$70,D0
            bra.b   .L2
.L4:
            clr.l   (A1)
            bra.b   .L1
a32EH:
            move.l  A2,-(SP)
            movea.l (A1),A2
            btst    #7,(-$B,A2)
            bne.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            suba.w  #$C,A0
            bsr.b   a32PurgeBlock
            adda.w  #$C,A0
.L1:
            moveq   #0,D0
.L2:
            movea.l (SP)+,A2
            rts
.L3:
            moveq   #-$70,D0
            bra.b   .L2
.L4:
            clr.l   (A1)
            bra.b   .L1
CallPurgeProc:
            tst.l   ($28,A6)
            beq.b   .L1
            movem.l D0-D2/A0-A1,-(SP)
            move.l  A1,-(SP)
            movea.l ($28,A6),A1
            jsr     (A1)
            movem.l (SP)+,D0-D2/A0-A1
.L1:
            rts
a24PurgeBlock:
            move.l  D0,-(SP)
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            bsr.b   CallPurgeProc
            clr.l   (A1)
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
            move.l  (SP)+,D0
            rts
a32PurgeBlock:
            move.l  D0,-(SP)
            move.l  (4,A0),D0
            bsr.b   CallPurgeProc
            clr.l   (A1)
            bsr.w   a32MakeBkF
            bsr.w   AdjustFree
            move.l  (SP)+,D0
            rts
a24PurgeHeap:
            movem.l D2/A1-A4,-(SP)
.L1:
            movea.l (A6),A3
            lea     ($34,A6),A0
            btst    #6,($16,A6)
            bne.b   .L7
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (A2),D1
            and.l   Lo3Bytes,D1
            movea.l A2,A4
            adda.l  D1,A2
            tst.b   (A4)
            beq.b   .L3
            bpl.b   .L4
            movea.l (4,A4),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L4
            btst    #6,(A1)
            beq.b   .L6
            cmpa.l  (4,A6),A4
            bcs.b   .L5
.L3:
            add.l   D1,D2
            cmp.l   D0,D2
            bcs.b   .L6
            bra.b   .L8
.L4:
            moveq   #0,D2
.L5:
            movea.l A2,A0
.L6:
            cmpa.l  A3,A2
            bcs.b   .L2
            lea     ($34,A6),A0
            cmpa.l  (4,A6),A0
            beq.b   .L7
            move.l  A0,(4,A6)
            bra.b   .L1
.L7:
            movea.l A3,A2
.L8:
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            tst.b   (A0)
            bpl.b   .L9
            movea.l (4,A0),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L9
            btst    #6,(A1)
            beq.b   .L9
            bsr.w   a24PurgeBlock
            cmp.l   D0,D1
            bcc.b   .L10
.L9:
            adda.l  D1,A0
            move.l  A0,(4,A6)
            cmpa.l  A2,A0
            bcs.b   .L8
.L10:
            bsr.w   a24CompactHp
            movem.l (SP)+,D2/A1-A4
            rts
a32PurgeHeap:
            movem.l D2/A1-A4,-(SP)
.L1:
            movea.l (A6),A3
            lea     ($34,A6),A0
            btst    #6,($16,A6)
            bne.b   .L7
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (4,A2),D1
            movea.l A2,A4
            adda.l  D1,A2
            tst.b   (A4)
            beq.b   .L3
            bpl.b   .L4
            tst.b   (1,A4)
            bmi.b   .L4
            btst    #6,(1,A4)
            beq.b   .L6
            cmpa.l  (4,A6),A4
            bcs.b   .L5
.L3:
            add.l   D1,D2
            cmp.l   D0,D2
            bcs.b   .L6
            bra.b   .L8
.L4:
            moveq   #0,D2
.L5:
            movea.l A2,A0
.L6:
            cmpa.l  A3,A2
            bcs.b   .L2
            lea     ($34,A6),A0
            cmpa.l  (4,A6),A0
            beq.b   .L7
            move.l  A0,(4,A6)
            bra.b   .L1
.L7:
            movea.l A3,A2
.L8:
            move.l  (4,A0),D1
            tst.b   (A0)
            bpl.b   .L9
            movea.l (8,A0),A1
            adda.l  A6,A1
            tst.b   (1,A0)
            bmi.b   .L9
            btst    #6,(1,A0)
            beq.b   .L9
            bsr.w   a32PurgeBlock
            cmp.l   D0,D1
            bcc.b   .L10
.L9:
            adda.l  D1,A0
            move.l  A0,(4,A6)
            cmpa.l  A2,A0
            bcs.b   .L8
.L10:
            bsr.w   A32COMPACTHP
            movem.l (SP)+,D2/A1-A4
            rts
A24TOTEPURGEABLES:
            moveq   #0,D0
            move.l  D0,D1
            movea.l D0,A0
            lea     ($34,A6),A1
.L1:
            cmpa.l  (A6),A1
            bcc.b   .L5
            move.l  (A1),D2
            and.l   Lo3Bytes,D2
            tst.b   (A1)
            beq.b   .L2
            bpl.b   .L4
            movea.l (4,A1),A2
            adda.l  A6,A2
            tst.b   (A2)
            bmi.b   .L4
            btst    #6,(A2)
            beq.b   .L3
.L2:
            add.l   D2,D1
.L3:
            adda.l  D2,A1
            bra.b   .L1
.L4:
            pea     .L3
.L5:
            bsr.l   V24PURGESPACEPATCH
            nop
            moveq   #0,D1
            rts
A32TOTEPURGEABLES:
            moveq   #0,D0
            move.l  D0,D1
            movea.l D0,A0
            lea     ($34,A6),A1
.L1:
            cmpa.l  (A6),A1
            bcc.b   .L5
            move.l  (4,A1),D2
            tst.b   (A1)
            beq.b   .L2
            bpl.b   .L4
            tst.b   (1,A1)
            bmi.b   .L4
            btst    #6,(1,A1)
            beq.b   .L3
.L2:
            add.l   D2,D1
.L3:
            adda.l  D2,A1
            bra.b   .L1
.L4:
            pea     .L3
.L5:
            bsr.l   V32PURGESPACEPATCH
            nop
            moveq   #0,D1
            rts
CallGZProc:
            move.l  ($2C,A6),D2
            beq.b   .L1
            movem.l D0-D1/D3-D7/A0-A6,-(SP)
            movea.l ($2C,A6),A1
            clr.l   -(SP)
            move.l  D0,-(SP)
            jsr     (A1)
            move.l  (SP)+,D2
            movem.l (SP)+,D0-D1/D3-D7/A0-A6
.L1:
            rts
A24BKCOMPACTS:
            movem.l D0/D2,-(SP)
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L1
            tst.l   D2
            beq.b   .L1
            bsr.w   a24GrowZone
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
.L1:
            bsr.w   a24PurgeHeap
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            beq.b   .L3
.L2:
            bsr.b   CallGZProc
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            bne.b   .L2
            suba.l  A0,A0
.L3:
            move.l  A0,D2
            movem.l (SP)+,D0/D2
            rts
A32BKCOMPACTS:
            movem.l D0/D2,-(SP)
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L1
            tst.l   D2
            beq.b   .L1
            bsr.w   a32GrowZone
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
.L1:
            bsr.w   a32PurgeHeap
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            beq.b   .L3
.L2:
            bsr.w   CallGZProc
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            bne.b   .L2
            suba.l  A0,A0
.L3:
            move.l  A0,D2
            movem.l (SP)+,D0/D2
            rts
sub_4080E128:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  Lo3Bytes,D2
            lea     ($30,A6),A2
            btst    #5,($16,A6)
            beq.b   .L1
            clr.l   (A2)
.L1:
            move.l  (A2),D1
            movea.l D1,A1
            bne.b   .L2
            lea     ($34,A6),A1
.L2:
            cmpa.l  (A6),A1
            bcc.b   .L6
            move.l  (A1),D1
            tst.b   (A1)
            beq.b   .L4
.L3:
            and.l   D2,D1
            adda.l  D1,A1
            bra.b   .L2
.L4:
            movea.l A1,A0
            adda.l  D1,A0
            tst.b   (A0)
            bne.b   .L5
            cmpa.l  (A6),A0
            bcc.b   .L5
            add.l   (A0),D1
            move.l  D1,(A1)
            bra.b   .L4
.L5:
            cmp.l   D0,D1
            bcs.b   .L3
            movea.l A1,A0
            bra.b   .L8
.L6:
            tst.l   (A2)
            beq.b   .L7
            clr.l   (A2)
            bra.b   .L1
.L7:
            suba.l  A0,A0
.L8:
            move.l  A0,(A2)
            movem.l (SP)+,D1-D2/A1-A2
            rts
a32BFindS:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  Lo3Bytes,D2
            lea     ($30,A6),A2
            btst    #5,($16,A6)
            beq.b   .L1
            clr.l   (A2)
.L1:
            move.l  (A2),D1
            movea.l D1,A1
            bne.b   .L2
            lea     ($34,A6),A1
.L2:
            cmpa.l  (A6),A1
            bcc.b   .L6
            move.l  (4,A1),D1
            tst.b   (A1)
            beq.b   .L4
.L3:
            adda.l  D1,A1
            bra.b   .L2
.L4:
            movea.l A1,A0
            adda.l  D1,A0
            tst.b   (A0)
            bne.b   .L5
            cmpa.l  (A6),A0
            bcc.b   .L5
            add.l   (4,A0),D1
            move.l  D1,(4,A1)
            clr.l   (A1)
            bra.b   .L4
.L5:
            cmp.l   D0,D1
            bcs.b   .L3
            movea.l A1,A0
            bra.b   .L8
.L6:
            tst.l   (A2)
            beq.b   .L7
            clr.l   (A2)
            bra.b   .L1
.L7:
            suba.l  A0,A0
.L8:
            move.l  A0,(A2)
            movem.l (SP)+,D1-D2/A1-A2
            rts
a24AllocBk:
            movem.l D0-D5,-(SP)
            move.l  D0,D4
            bsr.w   A24ACTUALS
            bsr.w   sub_4080E128
            bne.b   .L1
            moveq   #-1,D2
            bsr.w   A24BKCOMPACTS
            bne.b   .L1
            suba.l  A0,A0
            bra.b   .L4
.L1:
            move.l  D0,D2
            move.l  (A0),D0
            move.l  A1,D5
            beq.b   .L2
            sub.l   A6,D5
            moveq   #2,D1
            moveq   #-1,D3
            bra.b   .L3
.L2:
            move.l  A6,D5
            moveq   #1,D1
            moveq   #0,D3
.L3:
            bsr.w   a24MakeBK
            move.l  D5,(4,A0)
            move.l  D4,D0
            bsr.b   a24SetLogSize
            addq.l  #8,A0
            move.l  A1,D5
            beq.b   .L4
            move.l  A0,(A1)
.L4:
            move.l  A0,D0
            movem.l (SP)+,D0-D5
            rts
A32ALLOCBK:
            movem.l D0-D5,-(SP)
            move.l  D0,D4
            bsr.w   A32ACTUALS
            bsr.w   a32BFindS
            bne.b   .L1
            moveq   #-1,D2
            bsr.w   A32BKCOMPACTS
            bne.b   .L1
            suba.l  A0,A0
            bra.b   .L4
.L1:
            move.l  D0,D2
            move.l  (4,A0),D0
            move.l  A1,D5
            beq.b   .L2
            sub.l   A6,D5
            moveq   #2,D1
            moveq   #-1,D3
            bra.b   .L3
.L2:
            move.l  A6,D5
            moveq   #1,D1
            moveq   #0,D3
.L3:
            bsr.w   a32MakeBK
            move.l  D5,(8,A0)
            move.l  D4,D0
            bsr.b   a32SetLogSize
            adda.w  #$C,A0
            move.l  A1,D5
            beq.b   .L4
            move.l  A0,(A1)
.L4:
            move.l  A0,D0
            movem.l (SP)+,D0-D5
            rts
a24SetLogSize:
            move.l  D1,-(SP)
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            subq.l  #8,D1
            sub.l   D0,D1
            andi.b  #$F,D1
            andi.b  #$C0,(A0)
            or.b    D1,(A0)
            move.l  (SP)+,D1
            rts
a32SetLogSize:
            move.l  D1,-(SP)
            move.l  (4,A0),D1
            subi.l  #$C,D1
            sub.l   D0,D1
            move.b  D1,(3,A0)
            move.l  (SP)+,D1
            rts
a24MakeBK:
            movem.l D0-D2/D4/A1,-(SP)
            move.l  D0,D4
            sub.l   D2,D0
            movea.l A0,A1
            cmpi.l  #$C,D0
            bcs.b   .L3
            tst.w   D3
            beq.b   .L1
            tst.b   ($16,A6)
            bpl.b   .L1
            adda.l  D0,A1
            bra.b   .L2
.L1:
            adda.l  D2,A0
.L2:
            bsr.w   a24MakeBkF
            bra.b   .L4
.L3:
            move.l  D4,D2
.L4:
            move.l  D2,D0
            bsr.w   SubtractFree
            movea.l A1,A0
            ror.l   #2,D1
            add.l   D2,D1
            move.l  D1,(A0)
            movem.l (SP)+,D0-D2/D4/A1
            rts
a32MakeBK:
            movem.l D0-D2/D4/A1,-(SP)
            move.l  D0,D4
            sub.l   D2,D0
            movea.l A0,A1
            cmpi.l  #$10,D0
            bcs.b   .L3
            tst.w   D3
            beq.b   .L1
            tst.b   ($16,A6)
            bpl.b   .L1
            adda.l  D0,A1
            bra.b   .L2
.L1:
            adda.l  D2,A0
.L2:
            bsr.w   a32MakeBkF
            bra.b   .L4
.L3:
            move.l  D4,D2
.L4:
            move.l  D2,D0
            bsr.w   SubtractFree
            movea.l A1,A0
            ror.l   #2,D1
            move.l  D2,(4,A0)
            move.l  D1,(A0)
            movem.l (SP)+,D0-D2/D4/A1
            rts
HBlockMove:
            movem.l D0-D2/A0-A2,-(SP)
            movea.l ($4B8).w,A2
            jsr     (A2)
            movem.l (SP)+,D0-D2/A0-A2
            rts
a24CompactHp:
            movem.l D0/D2-D5/A1-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            lea     ($34,A6),A0
            bra.b   .L2
.L1:
            move.l  (A0),D4
            and.l   Lo3Bytes,D4
            adda.l  D4,A0
            cmpa.l  (A6),A0
            bcc.b   .L3
.L2:
            tst.b   (A0)
            bne.b   .L1
.L3:
            btst    #4,($16,A6)
            seq     D5
            movea.l A0,A2
.L4:
            movea.l A0,A1
            moveq   #0,D2
.L5:
            cmpa.l  (A6),A0
            bcc.b   .L9
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            tst.b   (A0)
            beq.b   .L6
            bpl.b   .L8
            movea.l (4,A0),A3
            adda.l  A6,A3
            tst.b   (A3)
            bmi.b   .L8
            tst.b   D5
            bne.b   .L7
            lea     (8,A1),A4
            move.b  (A3),D4
            move.l  A4,(A3)
            move.b  D4,(A3)
            bsr.b   HBlockMove
            adda.l  D0,A1
            bra.b   .L7
.L6:
            add.l   D0,D2
            movea.l A1,A3
            cmp.l   D3,D2
            bcs.b   .L7
            tst.b   D5
            beq.b   .L10
            clr.b   D5
            movea.l A2,A0
            bra.b   .L4
.L7:
            adda.l  D0,A0
            bra.b   .L5
.L8:
            bsr.w   a24MakeFree
            bra.b   .L1
.L9:
            suba.l  A3,A3
.L10:
            bsr.w   a24MakeFree
            movea.l A3,A0
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/D2-D5/A1-A4
            rts
A32COMPACTHP:
            movem.l D0/D2-D5/A1-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            lea     ($34,A6),A0
            bra.b   .L2
.L1:
            move.l  (4,A0),D4
            adda.l  D4,A0
            cmpa.l  (A6),A0
            bcc.b   .L3
.L2:
            tst.b   (A0)
            bne.b   .L1
.L3:
            btst    #4,($16,A6)
            seq     D5
            movea.l A0,A2
.L4:
            movea.l A0,A1
            moveq   #0,D2
.L5:
            cmpa.l  (A6),A0
            bcc.b   .L9
            move.l  (4,A0),D0
            tst.b   (A0)
            beq.b   .L6
            bpl.b   .L8
            movea.l (8,A0),A3
            adda.l  A6,A3
            tst.b   (1,A0)
            bmi.b   .L8
            tst.b   D5
            bne.b   .L7
            lea     ($C,A1),A4
            move.l  A4,(A3)
            bsr.w   HBlockMove
            adda.l  D0,A1
            bra.b   .L7
.L6:
            add.l   D0,D2
            movea.l A1,A3
            cmp.l   D3,D2
            bcs.b   .L7
            tst.b   D5
            beq.b   .L10
            clr.b   D5
            movea.l A2,A0
            bra.b   .L4
.L7:
            adda.l  D0,A0
            bra.b   .L5
.L8:
            bsr.w   a32MakeFree
            bra.b   .L1
.L9:
            suba.l  A3,A3
.L10:
            bsr.b   a32MakeFree
            movea.l A3,A0
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/D2-D5/A1-A4
            rts
a24MakeFree:
            tst.l   D2
            beq.b   .L2
            tst.b   D5
            bne.b   .L1
            move.l  D2,(A1)
.L1:
            cmp.l   D2,D1
            bcc.b   .L2
            move.l  D2,D1
.L2:
            rts
a32MakeFree:
            tst.l   D2
            beq.b   .L2
            tst.b   D5
            bne.b   .L1
            clr.l   (A1)
            move.l  D2,(4,A1)
.L1:
            cmp.l   D2,D1
            bcc.b   .L2
            move.l  D2,D1
.L2:
            rts
ToMaxLimit:
            move.l  BufPtr,D2
            sub.l   DefltStack,D2
A24MAXLIMIT:
            bra.l   A24MAXLIMITPATCH
            ds.b    20
A32MAXLIMIT:
            bra.l   A32MAXLIMITPATCH
            ds.b    16
A24ZONEADJUSTEND:
            movem.l D0/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A6),A0
            move.l  A3,D0
            sub.l   A0,D0
            move.l  #$C,(A3)
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
            move.l  A3,(A6)
            movem.l (SP)+,D0/A0/A2-A3
            rts
A32ZONEADJUSTEND:
            movem.l D0/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A6),A0
            move.l  A3,D0
            sub.l   A0,D0
            clr.l   (A3)
            move.l  #$10,(4,A3)
            bsr.w   a32MakeBkF
            bsr.w   AdjustFree
            move.l  A3,(A6)
            movem.l (SP)+,D0/A0/A2-A3
            rts
a24GrowZone:
            movem.l D0-D3/A0-A2,-(SP)
            addi.l  #$400,D0
            andi.w  #$FC00,D0
            move.l  D0,D3
            move.l  ApplLimit,D2
            bsr.w   A24MAXLIMIT
            move.l  HeapEnd,D2
            cmp.l   D2,D1
            bls.b   .L3
            add.l   D0,D2
            bcs.b   .L3
            cmp.l   D2,D1
            bcs.b   .L1
            move.l  D2,D1
            moveq   #0,D3
            bra.b   .L2
.L1:
            move.l  D1,D0
            sub.l   HeapEnd,D0
            cmpi.l  #$C,D0
            bcs.b   .L3
.L2:
            move.l  D1,HeapEnd
            movea.l D1,A0
            bsr.w   A24ZONEADJUSTEND
.L3:
            movem.l (SP)+,D0-D3/A0-A2
            rts
a32GrowZone:
            movem.l D0-D3/A0-A2,-(SP)
            addi.l  #$400,D0
            andi.w  #$FC00,D0
            move.l  D0,D3
            move.l  ApplLimit,D2
            bsr.w   A32MAXLIMIT
            move.l  HeapEnd,D2
            cmp.l   D2,D1
            bls.b   .L3
            add.l   D0,D2
            bcs.b   .L3
            cmp.l   D2,D1
            bcs.b   .L1
            move.l  D2,D1
            moveq   #0,D3
            bra.b   .L2
.L1:
            move.l  D1,D0
            sub.l   HeapEnd,D0
            cmpi.l  #$10,D0
            bcs.b   .L3
.L2:
            move.l  D1,HeapEnd
            movea.l D1,A0
            bsr.w   A32ZONEADJUSTEND
.L3:
            movem.l (SP)+,D0-D3/A0-A2
            rts
A24ACTUALS:
            bra.l   A24ACTUALSPATCH
            ds.b    14
A32ACTUALS:
            bra.l   A32ACTUALSPATCH
            ds.b    18
a24GetSize:
            move.l  D1,-(SP)
            subq.l  #8,A0
            moveq   #$F,D1
            and.b   (A0),D1
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            subq.l  #8,D0
            sub.l   D1,D0
            addq.l  #8,A0
            move.l  (SP)+,D1
            rts
A32GETSIZE:
            move.l  D1,-(SP)
            suba.w  #$C,A0
            moveq   #0,D1
            move.b  (3,A0),D1
            move.l  (4,A0),D0
            subi.l  #$C,D0
            sub.l   D1,D0
            adda.w  #$C,A0
            move.l  (SP)+,D1
            rts
ClearGZStuff:
            clr.l   GZRootHnd
            clr.l   GZRootPtr
            rts
A24SETSIZE:
            movem.l D1-D6/A0-A3,-(SP)
            move.b  (A1),-(SP)
            bsr.l   A24SETSIZEPATCH
            bsr.b   a24GetSize
            cmp.l   D0,D1
            beq.w   .L18
            movea.l A0,A2
            subq.l  #8,A2
            move.l  (A2),D2
            and.l   Lo3Bytes,D2
            move.l  D2,D4
            cmp.l   D2,D3
            beq.w   .L17
            bcs.w   .L16
            move.l  D3,D5
            sub.l   D2,D5
            move.l  A1,GZRootHnd
            move.l  A0,GZRootPtr
            movea.l A2,A3
            adda.l  D4,A3
            moveq   #0,D6
.L1:
            cmpa.l  (A6),A3
            bcc.b   .L2
            tst.b   (A3)
            bne.b   .L2
            add.l   (A3),D6
            adda.l  (A3),A3
            bra.b   .L1
.L2:
            sub.l   D6,D5
            bls.w   .L12
            move.l  A1,D0
            beq.w   .L12
            tst.b   (SP)
            bmi.w   .L12
            lea     ($34,A6),A3
.L3:
            cmpa.l  A2,A3
            bcc.b   .L7
            move.l  (A3),D0
            tst.b   (A3)
            beq.b   .L4
            and.l   Lo3Bytes,D0
            adda.l  D0,A3
            moveq   #0,D0
            bra.b   .L3
.L4:
            movea.l A3,A0
            moveq   #0,D0
.L5:
            cmpa.l  ($30,A6),A3
            bne.b   .L6
            move.l  A0,($30,A6)
.L6:
            add.l   (A3),D0
            adda.l  (A3),A3
            tst.b   (A3)
            beq.b   .L5
            move.l  D0,(A0)
            bra.b   .L3
.L7:
            move.l  D5,D6
            lsr.l   #2,D6
            cmp.l   D6,D0
            bls.b   .L11
            moveq   #$C,D6
            cmp.l   D5,D6
            bls.b   .L8
            move.l  D6,D5
.L8:
            moveq   #$18,D6
            add.l   D5,D6
            cmp.l   D6,D0
            bcs.b   .L9
            sub.l   D5,D0
            move.l  D0,(A0)
            adda.l  D0,A0
            move.l  D5,D0
.L9:
            move.l  A0,(A1)
            addq.l  #8,(A1)
            move.b  (SP),(A1)
            movem.l D0/A1,-(SP)
            cmpa.l  ($30,A6),A2
            bne.b   .L10
            move.l  A0,($30,A6)
.L10:
            exg     A0,A2
            movea.l A2,A1
            move.l  D4,D0
            bsr.w   HBlockMove
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (SP)+,(A0)
            movea.l (SP)+,A1
            lea     (8,A2),A0
            move.l  A0,GZRootPtr
            bra.b   .L12
.L11:
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            cmp.l   D0,D3
            bcc.b   .L12
            tst.b   (A0)
            bne.b   .L13
.L12:
            movea.l A2,A0
            move.l  D3,D0
            sub.l   D2,D0
            adda.l  D2,A2
            bset    #7,(A1)
            bsr.w   a24MakeSpace
            bclr    #7,(A1)
            move.l  A2,D4
            bne.b   .L15
.L13:
            move.l  A1,D4
            beq.b   .L14
            tst.b   (SP)
            bmi.b   .L14
            move.l  D1,D0
            bclr    #6,(A1)
            bsr.w   a24RelocRel
            move.b  (SP),(A1)
            bsr.w   ClearGZStuff
            bra.b   .L19
.L14:
            bsr.w   ClearGZStuff
            moveq   #-$6C,D0
            bra.b   .L19
.L15:
            bsr.w   ClearGZStuff
            move.l  (A2),D0
            move.l  D0,D4
            add.l   D2,D4
            movea.l A0,A2
            move.b  (A2),D5
            move.l  D4,(A2)
            move.b  D5,(A2)
            bsr.w   SubtractFree
.L16:
            sub.l   D3,D4
            cmpi.l  #$C,D4
            bcs.b   .L17
            btst    #0,($16,A6)
            bne.b   .L20
            movea.l A2,A0
            adda.l  D3,A0
            move.b  (A2),D5
            move.l  D3,(A2)
            move.b  D5,(A2)
            move.l  D4,D0
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
.L17:
            movea.l A2,A0
            move.l  D1,D0
            bsr.w   a24SetLogSize
.L18:
            moveq   #0,D0
.L19:
            move.b  (SP)+,(A1)
            movem.l (SP)+,D1-D6/A0-A3
            rts
.L20:
            moveq   #-$63,D0
            bra.b   .L19
A32SETSIZE:
            movem.l D1-D6/A0-A3,-(SP)
            movea.l A0,A2
            move.b  (-$B,A2),-(SP)
            bsr.l   A32SETSIZEPATCH
            nop
            bsr.w   A32GETSIZE
            cmp.l   D0,D1
            beq.w   .L18
            movea.l A0,A2
            suba.w  #$C,A2
            move.l  (4,A2),D2
            move.l  D2,D4
            cmp.l   D2,D3
            beq.w   .L17
            bcs.w   .L16
            move.l  D3,D5
            sub.l   D2,D5
            move.l  A1,GZRootHnd
            move.l  A0,GZRootPtr
            movea.l A2,A3
            adda.l  D4,A3
            moveq   #0,D6
.L1:
            cmpa.l  (A6),A3
            bcc.b   .L2
            tst.b   (A3)
            bne.b   .L2
            add.l   (4,A3),D6
            adda.l  (4,A3),A3
            bra.b   .L1
.L2:
            sub.l   D6,D5
            bls.w   .L12
            move.l  A1,D0
            beq.w   .L12
            tst.b   (SP)
            bmi.w   .L12
            lea     ($34,A6),A3
.L3:
            cmpa.l  A2,A3
            bcc.b   .L7
            tst.b   (A3)
            beq.b   .L4
            move.l  (4,A3),D0
            adda.l  D0,A3
            moveq   #0,D0
            bra.b   .L3
.L4:
            movea.l A3,A0
            moveq   #0,D0
.L5:
            cmpa.l  ($30,A6),A3
            bne.b   .L6
            move.l  A0,($30,A6)
.L6:
            add.l   (4,A3),D0
            adda.l  (4,A3),A3
            tst.b   (A3)
            beq.b   .L5
            clr.l   (A0)
            move.l  D0,(4,A0)
            bra.b   .L3
.L7:
            move.l  D5,D6
            lsr.l   #2,D6
            cmp.l   D6,D0
            bls.b   .L11
            moveq   #$10,D6
            cmp.l   D5,D6
            bls.b   .L8
            move.l  D6,D5
.L8:
            moveq   #$20,D6
            add.l   D5,D6
            cmp.l   D6,D0
            bcs.b   .L9
            sub.l   D5,D0
            clr.l   (A0)
            move.l  D0,(4,A0)
            adda.l  D0,A0
            move.l  D5,D0
.L9:
            move.l  A0,(A1)
            addi.l  #$C,(A1)
            move.b  (SP),(1,A0)
            movem.l D0/A1,-(SP)
            cmpa.l  ($30,A6),A2
            bne.b   .L10
            move.l  A0,($30,A6)
.L10:
            exg     A0,A2
            movea.l A2,A1
            move.l  D4,D0
            bsr.w   HBlockMove
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (SP)+,(4,A0)
            clr.l   (A0)
            movea.l (SP)+,A1
            lea     ($C,A2),A0
            move.l  A0,GZRootPtr
            bra.b   .L12
.L11:
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (4,A0),D0
            cmp.l   D0,D3
            bcc.b   .L12
            tst.b   (A0)
            bne.b   .L13
.L12:
            movea.l A2,A0
            move.l  D3,D0
            sub.l   D2,D0
            adda.l  D2,A2
            movea.l (A1),A3
            bset    #7,(-$B,A3)
            bsr.w   a32MakeSpace
            bclr    #7,(-$B,A3)
            move.l  A2,D4
            bne.b   .L15
.L13:
            move.l  A1,D4
            beq.b   .L14
            tst.b   (SP)
            bmi.b   .L14
            move.l  D1,D0
            movea.l (A1),A3
            bclr    #6,(-$B,A3)
            bsr.w   a32RelocRel
            move.b  (SP),(-$B,A3)
            bsr.w   ClearGZStuff
            bra.b   .L19
.L14:
            bsr.w   ClearGZStuff
            moveq   #-$6C,D0
            bra.b   .L19
.L15:
            bsr.w   ClearGZStuff
            move.l  (4,A2),D0
            move.l  D0,D4
            add.l   D2,D4
            movea.l A0,A2
            move.l  D4,(4,A2)
            bsr.b   SubtractFree
.L16:
            sub.l   D3,D4
            cmpi.l  #$10,D4
            bcs.b   .L17
            btst    #0,($16,A6)
            bne.b   .L20
            movea.l A2,A0
            adda.l  D3,A0
            move.l  D3,(4,A2)
            move.l  D4,D0
            bsr.w   a32MakeBkF
            bsr.b   AdjustFree
.L17:
            movea.l A2,A0
            move.l  D1,D0
            bsr.w   a32SetLogSize
.L18:
            moveq   #0,D0
.L19:
            movea.l (A1),A3
            move.b  (SP)+,(-$B,A3)
            movem.l (SP)+,D1-D6/A0-A3
            rts
.L20:
            moveq   #-$63,D0
            bra.b   .L19
AdjustFree:
            add.l   D0,($C,A6)
            bcs.b   .L1
            rts
.L1:
            moveq   #$21,D0
            _SysError
            rts
SubtractFree:
            sub.l   D0,($C,A6)
            bcs.b   SubFail
            rts
SubFail:
            moveq   #$21,D0
            _SysError
A24NEXTMASTER:
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A1
            move.l  A1,D0
            bne.b   .L1
            bsr.b   A24HMAKEMOREMASTERS
            beq.b   .L2
.L1:
            move.l  (A1),(8,A6)
            move.l  A1,D0
.L2:
            movem.l (SP)+,D0/A0
            rts
A32NEXTMASTER:
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A1
            move.l  A1,D0
            bne.b   .L1
            bsr.b   A32HMAKEMOREMASTERS
            beq.b   .L2
.L1:
            move.l  (A1),(8,A6)
            move.l  A1,D0
.L2:
            movem.l (SP)+,D0/A0
            rts
A24HMAKEMOREMASTERS:
            movem.l D0-D1/A0,-(SP)
            move.w  ($14,A6),D0
            ext.l   D0
            bgt.b   .L1
            moveq   #$20,D0
.L1:
            move.l  D0,D1
            asl.l   #2,D0
            bsr.b   A24MAKEPTRSPC
            suba.l  A1,A1
            bsr.w   a24AllocBk
            beq.b   .L3
            movea.l A0,A1
.L2:
            bsr.b   ReleaseMP
            addq.l  #4,A1
            subq.w  #1,D1
            bne.b   .L2
            subq.l  #4,A1
.L3:
            move.l  A1,D0
            movem.l (SP)+,D0-D1/A0
            rts
A32HMAKEMOREMASTERS:
            movem.l D0-D1/A0,-(SP)
            move.w  ($14,A6),D0
            ext.l   D0
            bgt.b   .L1
            moveq   #$20,D0
.L1:
            move.l  D0,D1
            asl.l   #2,D0
            bsr.w   A32MAKEPTRSPC
            suba.l  A1,A1
            bsr.w   A32ALLOCBK
            beq.b   .L3
            movea.l A0,A1
.L2:
            bsr.b   ReleaseMP
            addq.l  #4,A1
            subq.w  #1,D1
            bne.b   .L2
            subq.l  #4,A1
.L3:
            move.l  A1,D0
            movem.l (SP)+,D0-D1/A0
            rts
ReleaseMP:
            move.l  (8,A6),(A1)
            move.l  A1,(8,A6)
            rts
A24MAKEPTRSPC:
            movem.l D0-D4/A0-A1/A3-A4,-(SP)
            bsr.w   A24ACTUALS
            movea.l A6,A4
            cmpa.l  ApplZone,A6
            seq     D3
.L1:
            lea     ($34,A4),A0
            movea.l (A6),A3
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L9
            movea.l (4,A0),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L9
.L3:
            add.l   D1,D2
            adda.l  D1,A0
            cmp.l   D0,D2
            bcs.b   .L11
            bsr.w   a24MakeSpace
            move.l  A2,D2
            bne.b   .L8
            lea     ($34,A4),A2
.L4:
            move.l  (A2),D1
            and.l   Lo3Bytes,D1
            adda.l  D1,A2
            tst.b   (A2)
            bpl.b   .L5
            movea.l (4,A2),A1
            adda.l  A6,A1
            tst.b   (A1)
            bpl.b   .L6
.L5:
            cmpa.l  A0,A2
            bhi.b   .L7
.L6:
            cmpa.l  A3,A2
            bcs.b   .L4
.L7:
            movea.l A2,A0
            suba.l  A2,A2
.L8:
            move.l  A2,D2
            bne.b   .L13
            bra.b   .L10
.L9:
            adda.l  D1,A0
.L10:
            movea.l A0,A2
            moveq   #0,D2
.L11:
            cmpa.l  A3,A0
            bcs.b   .L2
            addq.b  #1,D3
            bne.b   .L12
            bsr.w   a24GrowZone
            bra.b   .L1
.L12:
            suba.l  A2,A2
.L13:
            movem.l (SP)+,D0-D4/A0-A1/A3-A4
            rts
A32MAKEPTRSPC:
            movem.l D0-D4/A0-A1/A3-A4,-(SP)
            bsr.w   A32ACTUALS
            movea.l A6,A4
            cmpa.l  ApplZone,A6
            seq     D3
.L1:
            lea     ($34,A4),A0
            movea.l (A6),A3
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (4,A0),D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L9
            tst.b   (1,A0)
            bmi.b   .L9
.L3:
            add.l   D1,D2
            adda.l  D1,A0
            cmp.l   D0,D2
            bcs.b   .L11
            bsr.w   a32MakeSpace
            move.l  A2,D2
            bne.b   .L8
            lea     ($34,A4),A2
.L4:
            move.l  (4,A2),D1
            adda.l  D1,A2
            tst.b   (A2)
            bpl.b   .L5
            tst.b   (1,A2)
            bpl.b   .L6
.L5:
            cmpa.l  A0,A2
            bhi.b   .L7
.L6:
            cmpa.l  A3,A2
            bcs.b   .L4
.L7:
            movea.l A2,A0
            suba.l  A2,A2
.L8:
            move.l  A2,D2
            bne.b   .L13
            bra.b   .L10
.L9:
            adda.l  D1,A0
.L10:
            movea.l A0,A2
            moveq   #0,D2
.L11:
            cmpa.l  A3,A0
            bcs.b   .L2
            addq.b  #1,D3
            bne.b   .L12
            bsr.w   a32GrowZone
            bra.b   .L1
.L12:
            suba.l  A2,A2
.L13:
            movem.l (SP)+,D0-D4/A0-A1/A3-A4
            rts
a24MakeSpace:
            movem.l D0-D3/A0-A1/A3,-(SP)
            move.l  D0,D1
            movea.l A2,A3
            moveq   #0,D3
MSpLoop:
            cmp.l   D1,D3
            bcc.b   MSpDone
            cmpa.l  (A6),A3
            bcc.b   MSpDone
            tst.b   (A3)
            beq.b   MSpFree
            bpl.b   MSpDone
            movea.l (4,A3),A1
            adda.l  A6,A1
            move.b  (A1),D2
            bmi.b   MSpDone
            bsr.w   a24SafeReloc
            beq.b   MSpFree
            btst    #6,D2
            beq.b   MSpDone
            movea.l (A1),A0
            subq.l  #8,A0
            bsr.w   a24PurgeBlock
MSpFree:
            movea.l A3,A0
            move.l  (A0),D0
            cmpa.l  ($30,A6),A0
            bne.b   MSpNext
            clr.l   ($30,A6)
MSpNext:
            add.l   D0,D3
            adda.l  D0,A3
            bra.b   MSpLoop
MSpDone:
            and.l   Lo3Bytes,D3
            beq.b   .L1
            move.l  D3,(A2)
.L1:
            cmp.l   D1,D3
            bcc.b   .L2
            suba.l  A2,A2
.L2:
            clr.l   ($30,A6)
            movem.l (SP)+,D0-D3/A0-A1/A3
            rts
a32MakeSpace:
            movem.l D0-D3/A0-A1/A3,-(SP)
            move.l  D0,D1
            movea.l A2,A3
            moveq   #0,D3
MSpLoop_2:
            cmp.l   D1,D3
            bcc.b   MSpDone_2
            cmpa.l  (A6),A3
            bcc.b   MSpDone_2
            tst.b   (A3)
            beq.b   MSpFree_2
            bpl.b   MSpDone_2
            movea.l (8,A3),A1
            adda.l  A6,A1
            move.b  (1,A3),D2
            bmi.b   MSpDone_2
            bsr.b   a32SafeReloc
            beq.b   MSpFree_2
            btst    #6,D2
            beq.b   MSpDone_2
            movea.l (A1),A0
            suba.w  #$C,A0
            bsr.w   a32PurgeBlock
MSpFree_2:
            movea.l A3,A0
            move.l  (4,A0),D0
            cmpa.l  ($30,A6),A0
            bne.b   MSpNext_2
            clr.l   ($30,A6)
MSpNext_2:
            add.l   D0,D3
            adda.l  D0,A3
            bra.b   MSpLoop_2
MSpDone_2:
            tst.l   D3
            beq.b   .L1
            clr.l   (A2)
            move.l  D3,(4,A2)
.L1:
            cmp.l   D1,D3
            bcc.b   .L2
            suba.l  A2,A2
.L2:
            clr.l   ($30,A6)
            movem.l (SP)+,D0-D3/A0-A1/A3
            rts
a24SafeReloc:
            move.l  A0,-(SP)
            move.l  D3,D0
            beq.b   .L1
            move.l  D3,(A2)
            ori.l   #$40000000,(A2)
            move.l  A6,(4,A2)
            bsr.w   SubtractFree
.L1:
            movea.l (A1),A0
            bsr.w   a24GetSize
            bsr.b   a24RelocRel
            movea.l D0,A0
            move.l  D3,D0
            beq.b   .L2
            move.l  D3,(A2)
            bsr.w   AdjustFree
.L2:
            move.l  A0,D0
            movea.l (SP)+,A0
            rts
a32SafeReloc:
            move.l  A0,-(SP)
            move.l  D3,D0
            beq.b   .L1
            move.l  D3,(4,A2)
            move.l  #$40000000,(A2)
            move.l  A6,(8,A2)
            bsr.w   SubtractFree
.L1:
            movea.l (A1),A0
            bsr.w   A32GETSIZE
            bsr.b   a32RelocRel
            movea.l D0,A0
            move.l  D3,D0
            beq.b   .L2
            clr.l   (A2)
            move.l  D3,(4,A2)
            bsr.w   AdjustFree
.L2:
            move.l  A0,D0
            movea.l (SP)+,A0
            rts
a24RelocRel:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l A1,A2
            move.l  A1,GZMoveHnd
            move.b  (A2),D1
            suba.l  A1,A1
            bsr.w   a24AllocBk
            beq.b   RRFail
            tst.l   (A2)
            beq.b   RRFree
            movea.l A0,A1
            movea.l (A2),A0
            bsr.w   a24GetSize
            bsr.w   HBlockMove
            subq.l  #8,A0
            subq.l  #8,A1
            moveq   #-$10,D0
            and.b   (A0),D0
            eor.b   D0,(A0)
            moveq   #-$10,D2
            and.b   (A1),D2
            eor.b   D2,(A1)
            or.b    D0,(A1)
            or.b    D2,(A0)
            addq.l  #4,A0
            addq.l  #4,A1
            move.l  (A0),(A1)+
            move.l  A1,(A2)
            move.b  D1,(A2)
            move.l  A6,(A0)+
RRFree:
            bsr.b   a24FreeBk
            moveq   #0,D0
RRExit:
            clr.l   GZMoveHnd
            movem.l (SP)+,D1-D2/A0-A2
            rts
RRFail:
            move.b  D1,(A2)
            moveq   #-$6C,D0
            bra.b   RRExit
a32RelocRel:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l A1,A2
            move.l  A1,GZMoveHnd
            suba.l  A1,A1
            bsr.w   A32ALLOCBK
            beq.b   RRFail_2
            tst.l   (A2)
            beq.b   RRFree_2
            movea.l A0,A1
            movea.l (A2),A0
            bsr.w   A32GETSIZE
            bsr.w   HBlockMove
            suba.w  #$C,A0
            suba.w  #$C,A1
            move.b  (A0),D0
            move.b  (A1),D2
            move.b  D0,(A1)
            move.b  D2,(A0)
            move.b  (1,A0),(1,A1)
            addq.l  #8,A0
            addq.l  #8,A1
            move.l  (A0),(A1)+
            move.l  A1,(A2)
            move.l  A6,(A0)+
RRFree_2:
            bsr.w   a32FreeBk
            moveq   #0,D0
RRExit_2:
            clr.l   GZMoveHnd
            movem.l (SP)+,D1-D2/A0-A2
            rts
RRFail_2:
            moveq   #-$6C,D0
            bra.b   RRExit_2
a24FreeBk:
            movem.l D0-D1/A0-A1,-(SP)
            subq.l  #8,A0
            move.l  (A0),D0
            move.l  D0,D1
            and.l   Lo3Bytes,D0
            eor.l   D0,D1
            beq.b   .L2
            bpl.b   .L1
            movea.l (4,A0),A1
            adda.l  A6,A1
            bsr.w   ReleaseMP
.L1:
            bsr.w   sub_4080DDFC
            bsr.w   AdjustFree
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
a32FreeBk:
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$C,A0
            move.l  (4,A0),D0
            tst.b   (A0)
            beq.b   .L2
            bpl.b   .L1
            movea.l (8,A0),A1
            adda.l  A6,A1
            bsr.w   ReleaseMP
.L1:
            bsr.w   sub_4080DE20
            bsr.w   AdjustFree
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
StdGZ:
            movea.l (SP)+,A1
            lea     GZRootHnd,A2
            movem.l (A2),D3-D5
            tst.l   D5
            beq.b   .L1
            cmp.l   D3,D5
            bne.b   .L2
.L1:
            btst    #3,($16,A6)
            bne.b   .L4
            move.l  (SP),D0
            clr.l   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            move.l  TheZone,-(SP)
            move.l  A6,TheZone
            _ResrvMem
            move.l  (SP)+,TheZone
            movem.l D3-D5,-(A2)
            tst.l   D0
            bmi.b   .L4
            move.l  (SP)+,(SP)
            jmp     (A1)
.L2:
            btst    #2,($16,A6)
            bne.b   .L4
.L3:
            addq.w  #4,SP
            jmp     (A1)
.L4:
            move.l  ($10,A6),D2
            beq.b   .L3
            move.l  A1,-(SP)
            move.l  D2,-(SP)
            rts
MEMMGREND:
            ds.b    10

            EVEN
