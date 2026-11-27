            include "Include/ROMHeader.s"

            EXPORT  Fix2Frac,Fix2Long,Fix2X,FixATan2,FixDiv,FixMul
            EXPORT  FixRatio,FixRound,Frac2Fix,Frac2X,FracCos,FracDiv
            EXPORT  FracMul,FracSin,FracSqrt,HandAndHand,HandToHand,HiWord
            EXPORT  Long2Fix,LongMul,LoWord,MethodDispatch,Munger,PtrAndHand
            EXPORT  PtrToHand,PtrToXHand,X2Fix,X2Frac,XMunger

            SECTION "Munger",CODE

Munger:
BYTES:
            link.w  A6,#-8
            movem.l D2-D7/A2-A4,-(SP)
            movea.l ($1C,A6),A2
            movea.l A2,A0
            _GetHandleSize
            move.l  D0,D5
            move.l  D0,(-8,A6)
            clr.l   (-4,A6)
            bsr.b   MungeGuts
            move.l  D2,($20,A6)
            moveq   #$18,D1
.L1:
            movem.l (SP)+,D2-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D1,SP
            jmp     (A0)
XMunger:
            link.w  A6,#-8
            movem.l D2-D7/A2-A4,-(SP)
            movea.l ($1C,A6),A2
            movea.l A2,A0
            _GetHandleSize
            move.l  D0,(-8,A6)
            move.l  ($24,A6),D5
            move.l  ($20,A6),(-4,A6)
            bsr.b   MungeGuts
            move.l  D2,($28,A6)
            moveq   #$20,D1
            bra.b   BYTES.L1
MungeGuts:
            move.l  ($18,A6),D2
            movea.l ($14,A6),A3
            movea.l ($C,A6),A4
            move.l  ($10,A6),D3
            beq.w   shs_Munger.L6
            bpl.b   .L2
.L1:
            move.l  D5,D3
            sub.l   D2,D3
.L2:
            move.l  D5,D0
            sub.l   D3,D0
            blt.b   .L6
            sub.l   D2,D0
            blt.b   .L1
            move.l  A3,D0
            beq.b   shs_Munger.L4
            move.l  (A2),D6
            move.l  D5,D7
            sub.l   D3,D7
            add.l   D6,D7
            add.l   D2,D6
.L3:
            move.l  D3,D1
            subq.l  #1,D1
            movea.l D6,A0
            movea.l A3,A1
.L4:
            cmp.l   D6,D7
            bcs.b   .L6
            cmpm.b  (A0)+,(A1)+
            bne.b   .L5
            dbra    D1,.L4
            move.l  D6,D2
            sub.l   (A2),D2
            bra.b   shs_Munger.L3
.L5:
            addq.l  #1,D6
            bra.b   .L3
.L6:
            moveq   #-1,D2
            bra.b   shs_Munger.L5
bm:
            cmpa.l  A0,A1
            beq.b   .L2
            subq.l  #1,D0
            ble.b   .L1
            addq.l  #1,D0
            _BlockMove
            rts
.L1:
            blt.b   .L2
            move.b  (A0),(A1)
.L2:
            moveq   #0,D0
            rts
shs_Munger:
            move.l  D0,-(SP)
            sub.l   (-8,A6),D0
            beq.b   .L1
            bgt.b   .L2
            neg.l   D0
            cmp.l   (-4,A6),D0
            bgt.b   .L2
.L1:
            addq.w  #4,SP
            bra.b   bm.L2
.L2:
            move.l  (SP)+,D0
            add.l   (-4,A6),D0
            _SetHandleSize
            rts
.L3:
            move.l  A4,D0
            beq.b   .L5
.L4:
            move.l  (8,A6),D4
            bne.b   .L9
            move.l  D5,D0
            sub.l   D3,D0
            move.l  D0,D5
            sub.l   D2,D0
            movea.l (A2),A1
            adda.l  D2,A1
            movea.l A1,A0
            adda.l  D3,A0
            bsr.b   bm
            movea.l A2,A0
            move.l  D5,D0
            bsr.b   shs_Munger
.L5:
            bra.b   .L8
.L6:
            move.l  (8,A6),D4
            beq.b   .L8
            move.l  D5,D0
            add.l   D4,D0
            movea.l A2,A0
            bsr.b   shs_Munger
            bne.b   .L8
            movea.l (A2),A1
            adda.l  D2,A1
            movea.l A1,A0
            adda.l  D4,A1
            move.l  D5,D0
            sub.l   D2,D0
            bsr.b   bm
.L7:
            movea.l (A2),A1
            adda.l  D2,A1
            movea.l A4,A0
            move.l  D4,D0
            bsr.w   bm
            add.l   D4,D2
.L8:
            rts
.L9:
            move.l  D4,D1
            sub.l   D3,D1
            beq.b   .L7
            bgt.b   .L10
            bsr.b   MoveTail
.L10:
            movea.l A2,A0
            move.l  D5,D0
            add.l   D1,D0
            bsr.w   shs_Munger
            bne.b   .L8
            tst.l   D1
            bmi.b   .L7
            bsr.b   MoveTail
            bra.b   .L7
MoveTail:
            movea.l (A2),A1
            adda.l  D2,A1
            movea.l A1,A0
            adda.l  D3,A0
            adda.l  D4,A1
            move.l  D5,D0
            sub.l   D3,D0
            sub.l   D2,D0
            bra.w   bm
HandToHand:
            _HGetState
            move.b  D0,-(SP)
            move.l  A0,-(SP)
            _HNoPurge
            movea.l A0,A1
            _GetHandleSize
            tst.l   D0
            bmi.b   .L1
            move.l  D0,D1
            _NewHandle
            movea.l (A1),A1
            bsr.b   sub_4081C24A
.L1:
            move.l  D0,D1
            movea.l A0,A1
            movea.l (SP)+,A0
            move.b  (SP)+,D0
            _HSetState
            move.l  D1,D0
            movea.l A1,A0
            rts
PtrToXHand:
            exg     A0,A1
            move.l  D0,D1
            _SetHandleSize
            bra.b   sub_4081C24A
PtrToHand:
            movea.l A0,A1
            move.l  D0,D1
            _NewHandle
sub_4081C24A:
            bne.b   clone2Common.L1
            moveq   #0,D2
clone2Common:
            move.l  A0,-(SP)
            movea.l (A0),A0
            adda.l  D2,A0
            exg     A0,A1
            move.l  D1,D0
            _BlockMove
            movea.l (SP)+,A0
.L1:
            rts
HandAndHand:
            _HGetState
            move.b  D0,-(SP)
            move.l  A0,-(SP)
            _HNoPurge
            _GetHandleSize
            tst.l   D0
            bmi.b   HandToHand.L1
            move.l  D0,D1
            exg     A1,A0
            _GetHandleSize
            move.l  D0,D2
            bmi.b   HandToHand.L1
            add.l   D1,D0
            _SetHandleSize
            bne.b   HandToHand.L1
            movea.l (A1),A1
            bsr.b   clone2Common
            bra.b   HandToHand.L1
PtrAndHand:
            move.l  D0,D1
            exg     A1,A0
            _GetHandleSize
            move.l  D0,D2
            add.l   D1,D0
            _SetHandleSize
            bne.b   clone2Common.L1
            bra.b   clone2Common
MethodDispatch:
            movea.l (SP)+,A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            move.w  (A1),D0
            move.w  (A0)+,D1
            cmp.w   (A0),D0
            bne.b   .L3
.L1:
            move.w  (2,A0),D0
            bclr    #0,D0
            bne.b   .L2
            jmp     (0,A5,D0.w)
.L2:
            jmp     (2,A0,D0.w)
.L3:
            move.w  D0,(A0)
            move.l  A0,D2
.L4:
            addq.l  #4,A0
            cmp.w   (A0),D0
            dbcc    D1,.L4
            beq.b   .L8
            movea.l MASuperTab,A1
            movea.l (A1),A1
            bra.b   .L7
.L5:
            addq.l  #4,A0
.L6:
            cmp.w   (A0),D0
            dbcc    D1,.L5
            beq.b   .L8
.L7:
            move.w  (0,A1,D0.w),D0
            bne.b   .L6
            movea.l D2,A1
            clr.l   (A1)
            movea.l MAErrProc,A1
            jmp     (A1)
.L8:
            movea.l D2,A1
            move.w  (2,A0),(2,A1)
            bra.b   .L1
LongMul:
            movem.l D0-D1,-(SP)
            move.l  ($10,SP),D1
            muls.l  ($14,SP),D0:D1
            movea.l ($C,SP),A0
            move.l  D0,(A0)+
            move.l  D1,(A0)+
            movem.l (SP)+,D0-D1
            rtd     #$C
FracMul:
            lea     ($3).w,A0
            bra.b   FixMul.L1
FixMul:
            cmpi.l  #$10000,(4,SP)
            beq.b   .L6
            cmpi.l  #$10000,(8,SP)
            beq.b   .L7
            lea     ($11).w,A0
.L1:
            movem.l D0-D2/A1,-(SP)
            move.l  ($14,SP),D1
            smi     D2
            tst.l   ($18,SP)
            smi     D0
            eor.b   D0,D2
            extb.l  D2
            muls.l  ($18,SP),D0:D1
            move.l  D1,-(SP)
            move.l  D0,-(SP)
            move.l  A0,D0
            bfexts  (SP){0:D0},D1
            cmp.w   D1,D2
            beq.b   .L2
            move.l  (SP)+,D1
            or.l    (SP)+,D1
            beq.b   .L5
            moveq   #-1,D1
            lsr.l   #1,D1
            eor.l   D2,D1
            bra.b   .L5
.L2:
            subq.w  #1,D0
            bfexts  (SP){D0:0},D1
            addi.w  #$20,D0
            bfextu  (SP){D0:1},D2
            beq.b   .L4
            tst.l   D1
            bpl.b   .L3
            addq.w  #1,D0
            moveq   #$40,D2
            sub.w   D0,D2
            bfextu  (SP){D0:D2},D0
            beq.b   .L4
.L3:
            addq.l  #1,D1
.L4:
            addq.w  #8,SP
.L5:
            move.l  D1,($1C,SP)
            movem.l (SP)+,D0-D2/A1
            rtd     #8
.L6:
            move.l  (8,SP),($C,SP)
            rtd     #8
.L7:
            move.l  (4,SP),($C,SP)
            rtd     #8
.L8:
            tst.l   D0
            bmi.b   fixArg1.L3
            tst.b   D6
            beq.b   .L9
            neg.l   D0
.L9:
            move.w  #8,(8,A6)
            move.l  D0,($10,A6)
            bra.b   .L11
.L10:
            move.w  #4,(8,A6)
            move.l  D0,($C,A6)
.L11:
            movem.l (SP)+,D0-D6/A1
            unlk    A6
            movea.l (SP)+,A0
            adda.w  (SP),SP
            jmp     (A0)
sub_4081C3D0:
            movea.l (SP)+,A0
            link.w  A6,#0
            movem.l D0-D6/A1,-(SP)
            jmp     (A0)
fixArg1:
            movem.l (8,A6),D1-D2
            tst.l   D1
            smi     D6
            bpl.b   .L1
            neg.l   D1
.L1:
            tst.l   D2
            bpl.b   .L2
            neg.l   D2
            not.b   D6
.L2:
            rts
.L3:
            moveq   #1,D0
            ror.l   #1,D0
            tst.b   D6
            bne.b   FixMul.L9
            subq.l  #1,D0
            bra.b   FixMul.L9
FracDiv:
            bsr.b   sub_4081C3D0
            moveq   #$1F,D3
            bra.b   FixDiv.L1
FixDiv:
            bsr.b   sub_4081C3D0
            moveq   #$11,D3
.L1:
            bsr.b   fixArg1
            moveq   #0,D0
            tst.l   D1
            bne.b   .L3
            bra.b   fixArg1.L3
.L2:
            addq.w  #1,D3
            add.l   D1,D1
.L3:
            bpl.b   .L2
            tst.l   D2
            beq.b   FixMul.L9
            bra.b   .L5
.L4:
            subq.w  #1,D3
            add.l   D2,D2
.L5:
            bpl.b   .L4
            tst.w   D3
            ble.b   FixMul.L9
            cmpi.w  #$20,D3
            blt.b   .L7
            bgt.b   fixArg1.L3
            cmp.l   D1,D2
            bcs.b   .L9
            bra.b   fixArg1.L3
.L6:
            add.l   D0,D0
            add.l   D2,D2
            bcs.b   .L8
.L7:
            cmp.l   D1,D2
            bcs.b   .L9
.L8:
            sub.l   D1,D2
            addq.w  #1,D0
.L9:
            dbra    D3,.L6
            lsr.l   #1,D0
            bcc.w   FixMul.L8
            addq.l  #1,D0
            bra.w   FixMul.L8
FracSqrt:
            bsr.w   sub_4081C3D0
            move.l  (8,A6),D3
            moveq   #0,D0
            moveq   #1,D1
            ror.l   #2,D1
            moveq   #0,D2
            moveq   #$1F,D4
.L1:
            sub.l   D1,D3
            subx.l  D0,D2
            bcc.b   .L2
            add.l   D1,D3
            addx.l  D0,D2
.L2:
            eori.b  #$10,CCR
            addx.l  D0,D0
            add.l   D3,D3
            addx.l  D2,D2
            add.l   D3,D3
            addx.l  D2,D2
            dbra    D4,.L1
            lsr.l   #1,D0
            bcc.w   FixMul.L10
            addq.l  #1,D0
            bra.w   FixMul.L10
FixRatio:
            move.w  (4,SP),D0
            beq.b   .L1
            moveq   #0,D1
            move.w  (6,SP),D1
            cmp.w   D0,D1
            beq.b   .L3
            ext.l   D0
            swap    D1
            divs.l  D0,D1
            move.l  D1,(8,SP)
            rtd     #4
.L1:
            moveq   #-1,D1
            lsr.l   #1,D1
            tst.w   (6,SP)
            bpl.b   .L2
            neg.l   D1
.L2:
            move.l  D1,(8,SP)
            rtd     #4
.L3:
            moveq   #1,D1
            swap    D1
            move.l  D1,(8,SP)
            rtd     #4
            tst.b   D6
            beq.b   .L4
            neg.l   D0
.L4:
            bra.w   FixMul.L10
            moveq   #1,D0
            swap    D0
            bra.w   FixMul.L10
LoWord:
            move.w  (6,SP),(8,SP)
            bra.b   HiWord.L1
HiWord:
            move.w  (4,SP),(8,SP)
.L1:
            move.l  (SP)+,(SP)
            rts
FixRound:
            movea.l (SP)+,A0
            moveq   #1,D1
            ror.w   #1,D1
            move.l  (SP)+,D0
            bpl.b   .L1
            not.w   D1
.L1:
            add.l   D1,D0
            bvc.b   .L2
            moveq   #-2,D0
            ror.l   #1,D0
.L2:
            swap    D0
            move.w  D0,(SP)
            jmp     (A0)
FracCos:
            bsr.w   sub_4081C3D0
            moveq   #2,D6
            bra.b   FracSin.L1
FracSin:
            bsr.w   sub_4081C3D0
            moveq   #0,D6
.L1:
            move.l  (8,A6),D3
            bpl.b   .L3
            tst.l   D6
            bne.b   .L2
            addq.w  #4,D6
.L2:
            neg.l   D3
.L3:
            move.l  #$C910,D5
            divu.w  D5,D3
            add.l   D3,D6
            clr.w   D3
            swap    D3
            btst    #0,D6
            beq.b   .L4
            sub.w   D5,D3
            neg.w   D3
.L4:
            swap    D3
            lsr.l   #3,D3
            move.l  A2,-(SP)
            suba.w  #$10,SP
            move.l  D3,-(SP)
            move.l  D3,-(SP)
            bsr.w   FracMul
            move.l  (SP)+,D5
            move.b  #$66,-(SP)
            btst    D6,(SP)+
            bne.b   .L5
            lea     .L10,A2
            moveq   #4,D4
            bra.b   .L6
.L5:
            lea     .L11,A2
            moveq   #8,D4
.L6:
            move.l  (4,A2,D4.w),-(SP)
.L7:
            move.l  D5,-(SP)
            bsr.w   FracMul
            move.l  (0,A2,D4.w),D0
            add.l   D0,(SP)
            subq.w  #4,D4
            bpl.b   .L7
            move.b  #$66,-(SP)
            btst    D6,(SP)+
            bne.b   .L8
            move.l  D3,-(SP)
            jsr     FracMul
.L8:
            move.l  (SP)+,D0
            movea.l (SP)+,A2
            move.b  #$F0,-(SP)
            btst    D6,(SP)+
            beq.b   .L9
            neg.l   D0
.L9:
            bra.w   FixMul.L10
.L10:
            dc.w    $7FFF,$D609,$AAB3,$314D,$10A2,$08E5
.L11:
            dc.w    $4000,0,$8000,$11A7,$2AA7,$F29A,$FA6E,$2A42
FixATan2:
            bsr.w   sub_4081C3D0
            moveq   #0,D6
            move.l  ($C,A6),D3
            bpl.b   .L1
            addq.w  #2,D6
            neg.l   D3
            bpl.b   .L1
            subq.w  #1,D3
.L1:
            move.l  (8,A6),D0
            bpl.b   .L2
            addq.w  #1,D6
            neg.l   D0
            bpl.b   .L2
            subq.w  #1,D0
.L2:
            move.l  A2,-(SP)
            suba.w  #$20,SP
            cmp.l   D3,D0
            ble.b   .L5
            addq.w  #4,D6
            move.l  D3,-(SP)
            beq.b   .L3
            move.l  D0,-(SP)
            bra.b   .L6
.L3:
            move.l  D3,D0
.L4:
            adda.w  #$24,SP
            bra.b   .L8
.L5:
            move.l  D0,-(SP)
            beq.b   .L4
            move.l  D3,-(SP)
.L6:
            bsr.w   FracDiv
            move.l  (SP),D3
            move.l  (SP),-(SP)
            bsr.w   FracMul
            move.l  (SP)+,D5
            lea     .L12,A2
            move.l  ($14,A2),-(SP)
            moveq   #$10,D4
.L7:
            move.l  D5,-(SP)
            bsr.w   FracMul
            move.l  (0,A2,D4.w),D0
            add.l   D0,(SP)
            subq.w  #4,D4
            bpl.b   .L7
            move.l  D3,-(SP)
            jsr     FracMul
            move.l  (SP)+,D0
            moveq   #$E,D2
            lsr.l   D2,D0
            bcc.b   .L8
            addq.l  #1,D0
.L8:
            movea.l (SP)+,A2
            move.l  #$19220,D5
            btst    #2,D6
            beq.b   .L9
            sub.l   D5,D0
            neg.l   D0
.L9:
            btst    #1,D6
            beq.b   .L10
            lsl.l   #1,D5
            sub.l   D5,D0
            neg.l   D0
.L10:
            btst    #0,D6
            beq.b   .L11
            neg.l   D0
.L11:
            bra.w   FixMul.L9
.L12:
            dc.w    $3FFF,$A073,$EAB6,$4EBE,$0C62,$F72C,$F88C,$77F2
            dc.w    $035E,$92FE,$FF3F,$FE62
Fix2X:
            move.w  #$400E,D1
            bra.b   Frac2X.L1
Frac2X:
            move.w  #$4000,D1
.L1:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            bne.b   .L2
            moveq   #0,D1
            bra.b   .L4
.L2:
            bpl.b   .L3
            addi.w  #$8000,D1
            neg.l   D0
            bmi.b   .L4
.L3:
            subq.w  #1,D1
            lsl.l   #1,D0
            bpl.b   .L3
.L4:
            movea.l (SP),A1
            move.w  D1,(A1)
            move.l  D0,(2,A1)
            clr.l   (6,A1)
            jmp     (A0)
X2Fix:
            move.w  #$400E,D1
            bra.b   X2Frac.L1
X2Frac:
            move.w  #$4000,D1
.L1:
            movem.l (SP)+,A0-A1
            move.w  (A1),D0
            bclr    #$F,D0
            sub.w   D0,D1
            blt.b   .L10
            move.l  (2,A1),D0
            tst.w   D1
            bne.b   .L2
            tst.w   (6,A1)
            bra.b   .L3
.L2:
            cmpi.w  #$20,D1
            blt.b   .L4
            bne.b   .L8
            moveq   #0,D0
            tst.w   (2,A1)
.L3:
            bmi.b   .L5
            bra.b   .L6
.L4:
            lsr.l   D1,D0
            bcc.b   .L6
.L5:
            addq.l  #1,D0
            bcs.b   .L10
.L6:
            tst.w   (A1)
            bmi.b   .L9
            tst.l   D0
            bmi.b   .L10
.L7:
            move.l  D0,(SP)
            jmp     (A0)
.L8:
            moveq   #0,D0
.L9:
            neg.l   D0
            ble.b   .L7
.L10:
            tst.w   (A1)
.L11:
            bpl.b   .L12
            moveq   #1,D0
            bra.b   .L13
.L12:
            moveq   #0,D0
            subq.l  #2,D0
.L13:
            ror.l   #1,D0
            bra.b   .L7
Fix2Long:
            moveq   #$10,D1
            bra.b   Frac2Fix.L1
Frac2Fix:
            moveq   #$E,D1
.L1:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            bpl.b   .L3
            neg.l   D0
            lsr.l   D1,D0
            bcc.b   .L2
            addq.l  #1,D0
.L2:
            neg.l   D0
            bra.b   X2Frac.L7
.L3:
            lsr.l   D1,D0
            bcc.b   X2Frac.L7
            addq.l  #1,D0
            bra.b   X2Frac.L7
Long2Fix:
            moveq   #$10,D1
            bra.b   Fix2Frac.L1
Fix2Frac:
            moveq   #$E,D1
.L1:
            movea.l (SP)+,A0
            move.l  (SP)+,(SP)
            move.l  (SP),D0
            asl.l   D1,D0
            bvc.b   X2Frac.L7
            move.l  (SP),D1
            bra.b   X2Frac.L11
            ds.b    14

            EVEN
