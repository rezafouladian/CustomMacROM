            include "Include/ROMHeader.s"

            EXPORT  EnableExtCache,HWPRIV,MEMORYDISPATCH

            IMPORT  FLUSHDCACHEPATCH,FLUSHICACHEPATCH,GETREALPROC,HWPrivPatch,NEWLOCKMEMORY,NEWLOCKMEMORYCONTIGUOUS
            IMPORT  NEWUNLOCKMEMORY,SWAPDCACHEPATCH,UNWRITEPROTECTPROC,WRITEPROTECTPROC

            SECTION "HwPriv",CODE

HWPRIVPROC:
            dc.w    HWPRIV.L2-HWPRIVPROC
            dc.w    HWPRIV.L3-HWPRIVPROC
            dc.w    HWPRIV.L4-HWPRIVPROC
            dc.w    HWPRIV.L5-HWPRIVPROC
            dc.w    EnableExtCache-HWPRIVPROC
            dc.w    sub_408054F4-HWPRIVPROC
            dc.w    sub_408054F4.L2-HWPRIVPROC
            dc.w    0,$0034,$0056,$02C4,0
HWPRIV:
            cmpi.w  #$A,D0
            bhi.b   .L1
            move.w  HWPRIVPROC(PC,D0.w*2),D0
            jmp     HWPRIVPROC(PC,D0.w)
.L1:
            move.l  #$FFFFFE0A,D0
            rts
.L2:
            bra.l   HWPrivPatch
            dc.w    $60FF,$0008,$1A8A
            ds.b    18
.L3:
            bra.l   FLUSHICACHEPATCH
            ds.b    4
            dc.w    $60FF,$0008,$1C26
.L4:
            bra.l   SWAPDCACHEPATCH
            ds.b    24
.L5:
            bra.l   FLUSHDCACHEPATCH
            ds.b    10
EnableExtCache:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l UnivInfoPtr,A0
            cmpi.b  #5,($13,A0)
            bne.b   .L2
            movea.l VIA2,A0
            lea     (A0),A0
            moveq   #-9,D0
            and.b   (A0),D0
            btst    #0,D0
            beq.b   .L2
            move.b  D0,(A0)
            bset    #3,D0
.L1:
            move.b  D0,(A0)
            move.b  (A0),(A0)
            move.b  (A0),(A0)
            bclr    #0,D0
            bne.b   .L1
.L2:
            move    (SP)+,SR
            moveq   #0,D0
            rts
sub_408054F4:
            movea.l UnivInfoPtr,A0
            cmpi.b  #5,($13,A0)
            bne.b   .L1
            movea.l VIA2,A0
            lea     (A0),A0
            ori.b   #1,(A0)
.L1:
            moveq   #0,D0
            rts
.L2:
            bsr.b   sub_408054F4
            bsr.b   EnableExtCache
            rts
            ds.b    12
MEMORYDPROC:
            dc.w    MEMORYDISPATCH.L2-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L3-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L4-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L5-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L6-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L7-MEMORYDPROC
            dc.w    sub_408055DE.L11-MEMORYDPROC
            dc.w    sub_408055DE.L12-MEMORYDPROC
            ds.b    8
MEMORYDISPATCH:
            cmpi.w  #7,D0
            bhi.b   .L1
            move.w  MEMORYDPROC(PC,D0.w*2),D0
            jmp     MEMORYDPROC(PC,D0.w)
.L1:
            move.l  #$FFFFFE0A,D0
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            moveq   #0,D0
            rts
.L4:
            bra.l   NEWLOCKMEMORY
.L5:
            bra.l   NEWUNLOCKMEMORY
.L6:
            bra.l   NEWLOCKMEMORYCONTIGUOUS
.L7:
            movem.l D3/A3-A4,-(SP)
            move.l  A0,-(SP)
            movea.l A0,A4
            move.l  A1,D3
            move.l  (A4)+,D2
            movea.l D2,A0
            add.l   (A4),D2
            cmp.l   RealMemTop,D2
            bhi.b   .L10
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.b   .L10
            movea.l A0,A3
            movea.l D2,A0
            subq.l  #1,A0
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.b   .L10
            suba.l  A3,A0
            addq.l  #1,A0
            cmpa.l  (A4),A0
            bne.b   .L11
            tst.l   D3
            beq.b   .L8
            move.l  (A4)+,D0
            add.l   D0,(-8,A4)
            clr.l   (-4,A4)
            move.l  A3,(A4)+
            move.l  D0,(A4)
.L8:
            movea.w #1,A0
            clr.w   D2
.L9:
            move.l  D2,D0
            movea.l (SP)+,A1
            movem.l (SP)+,D3/A3-A4
            rts
.L10:
            suba.l  A0,A0
            move.w  #$FFCE,D2
            bra.b   .L9
.L11:
            movea.l (SP),A4
            movea.l (A4),A0
            addq.l  #8,A4
            move.l  D3,D1
            bsr.w   sub_408055DE
            tst.w   D2
            bmi.b   .L10
            movea.l D1,A0
            bra.b   .L9
sub_408055DE:
            link.w  A6,#-$24
            movem.l D3-D7,-(SP)
            move.l  D1,(-$14,A6)
            move.l  #1,(-$18,A6)
            clr.l   (-$1C,A6)
            move.l  (-8,A4),(-$20,A6)
            move.l  (-4,A4),(-$24,A6)
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.w   .L10
            move.l  A0,(-4,A6)
            move.l  #'pgsz',D0
            _Gestalt
            move.l  A0,(-$C,A6)
            move.l  A0,D2
            subq.w  #1,D2
            move.l  (-4,A6),D3
            neg.l   D3
            and.l   D3,D2
            move.l  D2,(-$10,A6)
            movea.l (-$20,A6),A3
            adda.l  D2,A3
.L1:
            movea.l A3,A0
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.w   .L10
            move.l  (-4,A6),D3
            add.l   (-$10,A6),D3
            cmpa.l  D3,A0
            bne.b   .L3
            move.l  (-$10,A6),D3
.L2:
            add.l   (-$C,A6),D3
            cmp.l   (-4,A4),D3
            bcc.b   .L5
            move.l  D3,(-$10,A6)
            adda.l  (-$C,A6),A3
            bra.b   .L1
.L3:
            tst.l   (-$14,A6)
            beq.b   .L4
            move.l  (-$1C,A6),D3
            move.l  (-4,A6),(0,A4,D3.l*8)
            move.l  (-$10,A6),(4,A4,D3.l*8)
            addq.l  #1,D3
            cmp.l   (-$14,A6),D3
            bcc.b   .L7
            move.l  D3,(-$1C,A6)
.L4:
            addq.l  #1,(-$18,A6)
            move.l  (-$10,A6),D3
            add.l   D3,(-8,A4)
            sub.l   D3,(-4,A4)
            move.l  A0,(-4,A6)
            moveq   #0,D3
            bra.b   .L2
.L5:
            tst.l   (-$14,A6)
            bne.b   .L6
            move.l  (-$18,A6),D1
            move.l  (-$20,A6),(-8,A4)
            move.l  (-$24,A6),(-4,A4)
            bra.b   .L8
.L6:
            move.l  (-$1C,A6),D3
            move.l  (-4,A6),(0,A4,D3.l*8)
            move.l  (-4,A4),(4,A4,D3.l*8)
            move.l  (-4,A4),D2
            add.l   D2,(-8,A4)
            clr.l   (-4,A4)
            addq.l  #1,D3
.L7:
            move.l  D3,D1
.L8:
            moveq   #0,D2
.L9:
            movem.l (SP)+,D3-D7
            unlk    A6
            rts
.L10:
            move.w  #$FFFF,D2
            bra.b   .L9
.L11:
            bra.l   WRITEPROTECTPROC
.L12:
            bra.l   UNWRITEPROTECTPROC
WAITFORSCSIDEVSNUB:
            dc.w    $60FF,$0008,$1D88
            ds.b    406

            EVEN
