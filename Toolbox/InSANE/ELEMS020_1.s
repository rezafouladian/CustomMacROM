            include "Include/ROMHeader.s"

            EXPORT  DIVM0STUFF,DIVP0STUFF,ELCLASSX,ERRORNAN,M0STUFF,M1STUFF
            EXPORT  MINFSTUFF,P0STUFF,P1STUFF,PINFSTUFF,RESULTDELIVERED,RsrcEntryPACK_5_2
            EXPORT  ELEMS020,CLASSIFY,A0TOA1,POLYEVAL,CLEARUFLOW,CLEAROFLOW
            EXPORT  CLEARINVALID,CLEARINEXACT,FORCEOFLOW,FORCEUFLOW,FORCEDIVZER,FORCEINEXACT
            EXPORT  TESTDIVZER,TESTUFLOW,TESTOFLOW,TESTINVALID,TESTINEXACT,SCALBXX
            EXPORT  ELI2X

            IMPORT  ANNUITYTOP,ATANTOP,BaseOfROM,COMPOUNDTOP,COSTOP,EXP1TOP
            IMPORT  EXPTOP,FPK0,FPK1,FPK2,FPKINF,FPKLOGE2
            IMPORT  FPKM0,FPKM1,FPKMAXINT,FPKMINF,FPKSQRT2_PACK_5_2,FPKSQRTHALF_PACK_5_2
            IMPORT  LOG21P_PACK_5_2,LOG21Q_PACK_5_2,RANDTOP,RsrcEntryPACK_4_2,SINTOP,TANTOP
            IMPORT  XPWRITOP,XPWRYTOP

            SECTION "ELEMS020_1",CODE

RsrcEntryPACK_5_2:
            dc.b    $08,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 5 (4660 bytes) - Combo mask
            dc.l    RsrcEntryPACK_4_2-BaseOfROM     ; Next entry
            dc.l    ELEMS020-BaseOfROM          ; Data
            dc.b    'PACK'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'ter, Inc. 19'
            dc.l    $C0A00000,$00001240,$000001F4   ; Block header
ELEMS020:
            link.w  A6,#-$44
            movem.l D0-D7/A0-A4,-(SP)
            moveq   #0,D3
            movea.l ($15AC).w,A3
            lea     (4,A6),A2
            lea     (8,A6),A0
            move.w  (A0)+,D3
            bpl.w   CLASSIFY.DSTONLY
            movea.l (A0)+,A4
            move.l  (A0),D4
            btst    #$E,D3
            bne.b   .HAVESRC2
            tst.b   D3
            bpl.b   .L1
            move.w  (A4),(2,A4)
            addq.l  #2,A4
.L1:
            move.l  (A2),(A0)
            move.w  #$A,(A2)
            move.l  A4,D5
            moveq   #$F,D2
            moveq   #$3E,D0
            and.w   D3,D0
            cmpi.b  #$10,D0
            beq.b   CLASSIFY.CLASSDSTORSRC2
            tst.b   D3
            bpl.b   .CLCOM2
.CLCOM1:
            movea.l D4,A0
            lea     (-$38,A6),A1
            move.l  A1,D4
            move.w  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (8,A0),(A1)
.CLCOM2:
            movea.l D4,A0
            bsr.b   CLASSIFY
            move.w  D0,D2
            bra.b   CLASSIFY.CLASSDSTORSRC2
.HAVESRC2:
            addq.l  #4,A0
            move.l  (A0),D5
            move.l  (A2),(A0)
            move.w  #$E,(A2)
            tst.b   D3
            bpl.b   .CLCOM2
            addq.w  #2,A4
            movea.l D5,A0
            lea     (-$42,A6),A1
            move.l  A1,D5
            move.w  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (8,A0),(A1)
            bra.b   .CLCOM1
CLASSIFY:
            pea     (A0)
            pea     (-4,A6)
            bsr.w   ELCLASSX
            move.w  (-4,A6),D0
            bpl.b   .L1
            neg.w   D0
            ori.w   #$8000,D0
.L1:
            rts
.DSTONLY:
            moveq   #$F,D2
            movea.l (A0),A4
            tst.b   D3
            bpl.b   .L3
            move.w  (A4),(2,A4)
            addq.l  #2,A4
.L3:
            move.l  (A2),(A0)
            move.w  #6,(A2)
            move.l  A4,D5
.CLASSDSTORSRC2:
            movea.l D5,A0
            bsr.b   CLASSIFY
            move.w  D0,D1
            move.w  FPState,(-2,A6)
            clr.w   FPState
            subq.b  #3,D2
            bge.b   .NOT2NANS
            movea.l D5,A0
            movea.l A4,A1
            bsr.b   A0TOA1
            move.l  D4,-(SP)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            bra.b   .NANEXIT
.NOT2NANS:
            subq.b  #3,D1
            bge.b   LIFTOFF
            move.l  D5,-(SP)
            pea     (A4)
            move.w  #$E,-(SP)
            jsr     (A3)
.NANEXIT:
            bra.w   RESULTDELIVERED
LIFTOFF:
            move.w  D3,D0
            andi.w  #$3E,D0
            move.w  ELEMSTAB(PC,D0.w),D0
            jmp     LIFTOFF(PC,D0.w)
ELEMSTAB:
            dc.w    LOGTOP-LIFTOFF
            dc.w    LOGTOP-LIFTOFF
            dc.w    LOGTOP-LIFTOFF
            dc.w    LOGTOP-LIFTOFF
            dc.w    EXPTOP-LIFTOFF
            dc.w    EXPTOP-LIFTOFF
            dc.w    EXP1TOP-LIFTOFF
            dc.w    EXP1TOP-LIFTOFF
            dc.w    XPWRITOP-LIFTOFF
            dc.w    XPWRYTOP-LIFTOFF
            dc.w    COMPOUNDTOP-LIFTOFF
            dc.w    ANNUITYTOP-LIFTOFF
            dc.w    SINTOP-LIFTOFF
            dc.w    COSTOP-LIFTOFF
            dc.w    TANTOP-LIFTOFF
            dc.w    ATANTOP-LIFTOFF
            dc.w    RANDTOP-LIFTOFF
A0TOA1:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0),(A1)
            subq.l  #8,A1
            rts
POLYEVAL:
            move.w  (A1)+,D0
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.w  (8,A1),(8,A0)
.POLYLOOP:
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            addq.l  #8,A1
            addq.l  #2,A1
            pea     (A1)
            pea     (A0)
            clr.w   -(SP)
            jsr     (A3)
            subq.w  #1,D0
            bgt.b   .POLYLOOP
            addq.l  #8,A1
            addq.l  #2,A1
            rts
CLEARUFLOW:
            moveq   #1,D0
            bra.b   CLEARX
CLEAROFLOW:
            moveq   #2,D0
            bra.b   CLEARX
CLEARINVALID:
            moveq   #0,D0
            bra.b   CLEARX
CLEARINEXACT:
            moveq   #4,D0
CLEARX:
            bclr    D0,FPState
            rts
FORCEOFLOW:
            moveq   #2,D0
            bra.b   FORCEX
FORCEUFLOW:
            moveq   #1,D0
            bra.b   FORCEX
FORCEDIVZER:
            moveq   #3,D0
            bra.b   FORCEX
FORCEINVALID:
            moveq   #0,D0
            bra.b   FORCEX
FORCEINEXACT:
            moveq   #4,D0
FORCEX:
            bset    D0,FPState
            rts
TESTDIVZER:
            moveq   #3,D0
            bra.b   TESTX
TESTUFLOW:
            moveq   #1,D0
            bra.b   TESTX
TESTOFLOW:
            moveq   #2,D0
            bra.b   TESTX
TESTINVALID:
            moveq   #0,D0
            bra.b   TESTX
TESTINEXACT:
            moveq   #4,D0
TESTX:
            btst    D0,FPState
            rts
SCALBXX:
            move.w  #$7FFF,(-6,A6)
            lea     (-$1A,A6),A2
            move.l  (6,A1),-(A2)
            move.l  (2,A1),-(A2)
            move.w  (A1),-(A2)
            bclr    #7,(A2)
            bsr.b   VSMAXINT
            bge.b   .At1
            pea     (FPKMAXINT.w,PC)
            pea     (A2)
            move.w  #2,-(SP)
            jsr     (A3)
            tst.b   (A1)
            bpl.b   .L1
            neg.w   (-6,A6)
.L1:
            bsr.b   SCALEINT
            bsr.b   VSMAXINT
            bge.b   .At1
            pea     (FPKMAXINT.w,PC)
            bra.b   .At3
.At1:
            pea     (A2)
.At3:
            pea     (-6,A6)
            move.w  #$2010,-(SP)
            jsr     (A3)
            tst.b   (A1)
            bpl.b   SCALEINT
            neg.w   (-6,A6)
SCALEINT:
            pea     (-6,A6)
            pea     (A0)
            move.w  #$18,-(SP)
            jsr     (A3)
            rts
VSMAXINT:
            pea     (-$24,A6)
            pea     (FPKMAXINT.w,PC)
            move.w  #8,-(SP)
            jsr     (A3)
            rts
ELLOGBX:
            movem.l D0-D2/A0,-(SP)
            moveq   #0,D1
            movea.l ($14,SP),A0
            move.w  (A0),D1
            bclr    #$F,D1
            move.l  (2,A0),D0
            bmi.b   .L2
            bfffo   D0{0:0},D2
            bne.b   .L1
            sub.w   D2,D1
            move.l  (6,A0),D0
            bfffo   D0{0:0},D2
.L1:
            sub.w   D2,D1
.L2:
            move.w  #$401E,D0
            subi.w  #$3FFF,D1
            bgt.b   .L4
            blt.b   .L3
            move.l  D1,D0
            bra.b   .L5
.L3:
            bset    #$F,D0
            neg.w   D1
.L4:
            bfffo   D1{0:0},D2
            lsl.l   D2,D1
            sub.w   D2,D0
.L5:
            move.w  D0,(A0)+
            move.l  D1,(A0)+
            clr.l   (A0)
            movem.l (SP)+,D0-D2/A0
            rtd     #4
ELCLASSX:
            movem.l D0-D1/A0,-(SP)
            movea.l ($14,SP),A0
            move.w  (A0)+,D0
            add.l   D0,D0
            lsr.w   #1,D0
            cmpi.w  #$7FFF,D0
            beq.b   .L4
            move.l  (A0)+,D1
            bpl.b   .L7
.L1:
            moveq   #5,D1
.L2:
            btst    #$10,D0
            beq.b   .L3
            neg.w   D1
.L3:
            movea.l ($10,SP),A0
            move.w  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #8
.L4:
            move.l  (A0)+,D1
            add.l   D1,D1
            lsr.l   #1,D1
            beq.b   .L6
            btst    #$1E,D1
            beq.b   .L5
            moveq   #2,D1
            bra.b   .L2
.L5:
            moveq   #1,D1
            bra.b   .L2
.L6:
            move.l  (A0),D1
            bne.b   .L5
            moveq   #3,D1
            bra.b   .L2
.L7:
            beq.b   .L10
.L8:
            subq.w  #1,D0
            add.l   D1,D1
            bpl.b   .L8
.L9:
            tst.w   D0
            bpl.b   .L1
            moveq   #6,D1
            bra.b   .L2
.L10:
            subi.w  #$20,D0
            move.l  (A0),D1
            beq.b   .L11
            bpl.b   .L8
            bra.b   .L9
.L11:
            moveq   #4,D1
            bra.b   .L2
ELI2X:
            movem.l D0-D1/A0,-(SP)
            movea.l ($14,SP),A0
            move.w  #$400E,D0
            swap    D0
            move.w  (A0),D0
            beq.b   .L3
            bpl.b   .L1
            bset    #$1F,D0
            neg.w   D0
            bmi.b   .L2
.L1:
            swap    D0
            bfffo   D0{0:16},D1
            sub.w   D1,D0
            swap    D0
            lsl.w   D1,D0
.L2:
            movea.l ($10,SP),A0
            move.l  D0,(A0)+
            clr.l   (A0)+
            clr.w   (A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #8
.L3:
            moveq   #0,D0
            bra.b   .L2
ELPROCEXIT:
            movem.l D0/D6/A0,-(SP)
            movea.l ($10,SP),A0
            move.w  #$19,D6
            swap    D6
            move.w  #$1F00,D6
            and.w   FPState,D6
            move.w  (A0),D0
            or.w    D6,D0
            move.w  D0,FPState
            lsr.w   #8,D6
            and.w   D6,D0
            bne.b   .FASTHALT
.FASTEX:
            move    D0,CCR
            movem.l (SP)+,D0/D6/A0
            rtd     #4
.FASTHALT:
            lea     ($10,SP),A0
            clr.w   -(SP)
            move.w  D0,-(SP)
            pea     (SP)
            move.l  (8,A0),-(SP)
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            swap    D6
            move.w  D6,-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
            move.l  (SP)+,D0
            bra.b   .FASTEX
LOGTOP:
            subq.b  #1,D1
            bpl.b   .LOGFINITE
            tst.w   D1
            bpl.w   PINFSTUFF
.LOGERROR:
            moveq   #$24,D0
            bra.w   ERRORNAN
.LOGFINITE:
            btst    #2,D3
            bne.b   .LOG1PLUSX
            tst.b   D1
            beq.b   .LOG0
            tst.w   D1
            bmi.b   .LOGERROR
            bra.b   .LOG2R
.LOG1PLUSX:
            tst.b   D1
            beq.w   RESULTDELIVERED
            pea     (A4)
            pea     (FPKM1.w,PC)
            move.w  #8,-(SP)
            jsr     (A3)
            bhi.b   .LOGERROR
            bcs.b   .LOG12R
.LOG0:
            bra.w   DIVM0STUFF
.LOG12R:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (FPK1.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            pea     (FPKSQRTHALF_PACK_5_2.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            ble.b   .LOG2R
            pea     (A4)
            pea     (FPKSQRT2_PACK_5_2.w,PC)
            move.w  #8,-(SP)
            jsr     (A3)
            bls.b   .LOG2R
            movea.l A1,A0
            movea.l A4,A1
            bsr.w   A0TOA1
            bsr.w   LOGAPPROX
            bra.b   .LOGFINI
.LOG2R:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   A0TOA1
            pea     (A1)
            bsr.w   ELLOGBX
            bchg    #7,(A1)
            pea     (A1)
            pea     (-6,A6)
            move.w  #$2010,-(SP)
            jsr     (A3)
            pea     (-6,A6)
            pea     (A4)
            move.w  #$18,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (FPKSQRT2_PACK_5_2.w,PC)
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            ble.b   .At11
            pea     (FPK1.w,PC)
            pea     (-$10,A6)
            clr.w   -(SP)
            jsr     (A3)
            subq.w  #1,(A4)
.At11:
            pea     (FPK1.w,PC)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            bsr.b   LOGAPPROX
            pea     (-$10,A6)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.LOGFINI:
            btst    #1,D3
            bne.b   .L12
            pea     (FPKLOGE2.w,PC)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            move.l  (2,A4),D0
            or.l    (6,A4),D0
            beq.b   .L12
            bsr.w   FORCEINEXACT
.L12:
            bra.w   RESULTDELIVERED
LOGAPPROX:
            pea     (A4)
            pea     (-6,A6)
            bsr.w   ELCLASSX
            move.w  (-6,A6),D0
            bpl.b   .L1
            neg.w   D0
.L1:
            subq.w  #4,D0
            bne.b   .L2
            rts
.L2:
            subq.w  #1,D0
            beq.b   .LANORMAL
            pea     (FPKLOGE2.w,PC)
            bsr.w   FORCEUFLOW
            bra.b   .L4
.LANORMAL:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   A0TOA1
            pea     (FPK2.w,PC)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            pea     (A4)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            movea.l A1,A0
            pea     (A1)
            pea     (A1)
            lea     (-$24,A6),A1
            bsr.w   A0TOA1
            move.w  #4,-(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (LOG21P_PACK_5_2.w,PC),A1
            lea     (-$1A,A6),A2
            bsr.w   POLYEVAL
            pea     (-$24,A6)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$24,A6),A0
            lea     (LOG21Q_PACK_5_2.w,PC),A1
            lea     (-$1A,A6),A2
            bsr.w   POLYEVAL
            bsr.w   CLEARUFLOW
            pea     (-$24,A6)
.L4:
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   FORCEINEXACT
            rts
P0STUFF:
            lea     (FPK0.w,PC),A0
            bra.b   STUFFVAL
M0STUFF:
            lea     (FPKM0.w,PC),A0
            bra.b   STUFFVAL
P1STUFF:
            lea     (FPK1.w,PC),A0
            bra.b   STUFFVAL
M1STUFF:
            lea     (FPKM1.w,PC),A0
            bra.b   STUFFVAL
DIVP0STUFF:
            bsr.w   FORCEDIVZER
PINFSTUFF:
            lea     (FPKINF.w,PC),A0
            bra.b   STUFFVAL
DIVM0STUFF:
            bsr.w   FORCEDIVZER
MINFSTUFF:
            lea     (FPKMINF.w,PC),A0
STUFFVAL:
            movea.l A4,A1
            bsr.w   A0TOA1
            bra.b   RESULTDELIVERED
ERRORNAN:
            ori.l   #$7FFF4000,D0
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.w   (A4)
            subq.l  #8,A4
            bsr.w   FORCEINVALID
RESULTDELIVERED:
            tst.b   D3
            bpl.b   .L16
            move.w  (A4),(-2,A4)
.L16:
            pea     (-2,A6)
            bsr.w   ELPROCEXIT
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            adda.w  (SP),SP
            rts

            EVEN
