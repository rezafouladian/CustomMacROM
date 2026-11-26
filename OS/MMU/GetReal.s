            include "Include/ROMHeader.s"

            EXPORT  GetPageDescProc,GETREALPROC

            SECTION "GetReal",CODE


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

            EVEN
