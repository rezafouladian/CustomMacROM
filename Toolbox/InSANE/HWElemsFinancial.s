RCompound:
            bsr.w   FinInit
            fbne.w  CpdRateBig
            btst    #$1A,D0
            bne.w   P1STUFFFIN
            btst    #$1B,D0
            bne.w   DIVP0STUFFFIN
            bra.w   P0STUFFFIN
CpdRateBig:
            btst    #$1A,D0
            bne.w   P1STUFFFIN
            btst    #$19,D0
            beq.b   CpdCompute
            btst    #$1A,D1
            bne.w   ERRFINAN
            eor.l   D1,D0
            btst    #$1B,D0
            beq.w   PINFSTUFFFIN
            bra.w   P0STUFFFIN
CpdCompute:
            movem.l A1/A4,-(SP)
            btst    #$19,D1
            beq.b   .L13
            suba.l  A0,A0
            bra.b   .L14
.L13:
            fgetexp.x FP0,FP3
            fmove.w #$FFC0,FP1
            fcmp.x  FP1,FP3
            fbolt.w .L14
            lea     (RLog21x.w,PC),A1
            bsr.w   CallElems
            fmove.l FPSR,D0
            movea.l D1,A0
            fmul.x  FP2,FP0
            lea     (RExp2x.w,PC),A1
            bsr.w   CallElems
            bra.b   .L15
.L14:
            fmul.x  FP2,FP0
            lea     (RExpx.w,PC),A1
            bsr.w   CallElems
.L15:
            move.l  A0,D1
            btst    #3,D1
            beq.b   .L16
            move.l  #$80000,D0
            bra.b   .L17
.L16:
            moveq   #0,D0
.L17:
            movem.l (SP)+,A1/A4
            bra.w   FinExit
RAnnuity:
            bsr.w   FinInit
            fbne.w  AnnOK
            btst    #$1A,D0
            bne.w   P0STUFFFIN
            btst    #$1B,D0
            bne.w   M1STUFFFIN
            bra.w   DIVP0STUFFFIN
AnnOK:
            btst    #$1A,D0
            bne.w   P0STUFFFIN
            btst    #$19,D1
            bne.b   AnnInfRate
            btst    #$1A,D1
            beq.b   AnnRateOK
AnnReturnN:
            fmove.x FP2,FP0
            bra.w   FinExit
AnnInfRate:
            btst    #$1B,D0
            beq.w   P0STUFFFIN
            fcmp.x  FP1,FP2
            fbeq.w  M1STUFFFIN
            fbogt.w M0STUFFFIN
            bra.w   MINFSTUFFFIN
AnnRateOK:
            fmove.x FP0,FP3
            btst    #$19,D0
            beq.b   AnnCompute
            eor.l   D1,D0
            btst    #$1B,D0
            bne.b   AnnReturnN
            fmovecr.x #$32,FP0
            fdiv.x  FP3,FP0
            bra.w   FinExit
AnnCompute:
            movem.l A1/A4,-(SP)
            fgetexp.x FP3,FP0
            fmove.w #$FFC0,FP1
            fcmp.x  FP0,FP1
            fbogt.w AnnBasee
            lea     (RLog21x.w,PC),A1
            fmove.x FP3,FP0
            bsr.w   CallElems
            fmul.x  FP2,FP0
            fneg.x  FP0,FP0
            fcmp.w  #$100,FP0
            fbolt.w AnnResult
            fmove.s #"$7F7FFFFF",FP1
            fcmp.x  FP1,FP3
            fbogt.w AnnSpecial
            bra.b   AnnResult
AnnBasee:
            fmove.x FP3,FP1
            fmul.x  FP2,FP3
            fneg.x  FP3,FP0
            fmove.x FP1,FP3
            lea     (RExp1x.w,PC),A1
            bsr.w   CallElems
            bra.b   AnnResult2
AnnResult:
            lea     (RExp21x.w,PC),A1
            bsr.w   CallElems
AnnResult2:
            fneg.x  FP0,FP0
            fdiv.x  FP3,FP0
AnnClear:
            moveq   #$60,D0
            fmove.l FPSR,D1
            btst    #$B,D1
            beq.b   .L28
            btst    #9,D1
            beq.b   .L28
            ori.l   #$280000,D0
            bra.b   .L30
.L28:
            btst    #$19,D1
            bne.b   .L29
            btst    #$1A,D1
            beq.b   .L30
            ori.l   #$200000,D0
            bra.b   .L30
.L29:
            ori.l   #$400000,D0
.L30:
            movem.l (SP)+,A1/A4
            bra.w   FinExit
AnnSpecial:
            lea     (RLog2x.w,PC),A1
            fmove.x FP3,FP0
            bsr.w   CallElems
            fadd.w  #1,FP2
            fmul.x  FP2,FP0
            fneg.x  FP0,FP0
            lea     (RExp2x.w,PC),A1
            bsr.w   CallElems
            fneg.x  FP0,FP0
            fmove.l FPSR,D1
            bset    #3,D1
            fmove.l D1,FPSR
            bra.b   AnnClear
FinInit:
            movea.l ($3E,SP),A0
            tst.b   ($39,SP)
            bpl.b   .L1
            fmove.x (A0),FP2
            fmove.l FPSR,D0
            movea.l ($42,SP),A0
            fmove.x (A0),FP0
            fmove.l FPSR,D1
            bra.b   .L2
.L1:
            addq.l  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.l  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP2
            fmove.l FPSR,D0
            movea.l ($42,SP),A0
            addq.l  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.l  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP0
            fmove.l FPSR,D1
.L2:
            btst    #$18,D0
            beq.b   .L3
            fmove.x FP2,FP0
            btst    #$E,D0
            beq.b   .L6
            move.l  #$800000,D0
            bra.b   .L6
.L3:
            fmove.w #$FFFF,FP1
            fcmp.x  FP1,FP0
            fbolt.w .L4
            fbun.w  .L5
            rts
.L4:
            addq.l  #4,SP
            bra.b   ERRFINAN
.L5:
            btst    #$E,D1
            beq.b   .L6
            move.l  #$800000,D0
.L6:
            addq.l  #4,SP
            bra.b   FinExit
ERRFINAN:
            moveq   #$26,D1
            lsl.l   #8,D1
            ori.l   #$7FC00000,D1
            move.l  #$800000,D0
            bra.b   MINFSTUFFFIN.L15
P1STUFFFIN:
            move.l  #$3F800000,D1
            bra.b   MINFSTUFFFIN.L15
P0STUFFFIN:
            moveq   #0,D1
            bra.b   MINFSTUFFFIN.L15
M1STUFFFIN:
            move.l  #$BF800000,D1
            bra.b   MINFSTUFFFIN.L15
M0STUFFFIN:
            move.l  #$80000000,D1
            bra.b   MINFSTUFFFIN.L15
DIVP0STUFFFIN:
            ori.l   #$100000,D0
PINFSTUFFFIN:
            move.l  #$7F800000,D1
            bra.b   MINFSTUFFFIN.L15
MINFSTUFFFIN:
            move.l  #$FF800000,D1
.L15:
            fmove.s D1,FP0
FinExit:
            move.l  ($30,SP),($3A,SP)
            lea     .L17,A0
            move.l  A0,($30,SP)
            jmp     (A4)
.L17:
            rtd     #4
CallElems:
            fmovem.x FP1-FP3,-(SP)
            movem.l A0/A4,-(SP)
            ftst.x  FP0
            lea     ReturnToHere,A4
            fmove.x FP0,-(SP)
            lea     (SP),A0
            jmp     (A1)
ReturnToHere:
            adda.w  #12,SP
            movem.l (SP)+,A0/A4
            fmovem.x (SP)+,FP1-FP3
            moveq   #-1,D1
            eor.b   D1,D0
            fmove.l FPSR,D1
            and.b   D0,D1
            swap    D0
            or.b    D0,D1
            fmove.l D1,FPSR
            rts
RXpwri:
            movem.l D2-D4/A1,-(SP)
            movea.l ($4A,SP),A1
            move.w  (A1),D2
            moveq   #0,D4
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            move.l  D0,D1
            lsl.l   #5,D0
            beq.b   FinPwrI
            btst    #$1D,D0
            bne.w   PwrAllDone
            tst.w   D2
            beq.w   P1STUFFXPWR
            btst    #0,D2
            bne.b   .L3
            tst.w   D2
            bmi.b   .L2
            fabs.x  FP0,FP0
            bra.w   PwrAllDone
.L2:
            tst.l   D0
            bmi.w   DIVP0STUFFXPWR
            bra.w   P0STUFFXPWR
.L3:
            tst.w   D2
            bpl.w   PwrAllDone
            tst.l   D0
            bmi.b   .L4
            lsl.l   #5,D1
            bcc.w   P0STUFFXPWR
            bra.w   M0STUFFXPWR
.L4:
            lsl.l   #5,D1
            bcc.w   DIVP0STUFFXPWR
            bra.w   DIVM0STUFFXPWR
FinPwrI:
            move.w  D2,D0
            bpl.b   .L1
            neg.w   D0
.L1:
            cmpi.w  #$FF,D0
            bhi.b   XPWRBIG
            bsr.b   XPWRK
            moveq   #0,D0
            bra.w   PwrAllDone
XPWRBIG:
            fabs.x  FP0,FP0
            fmove.w D2,FP3
            bsr.w   XPWRY
            moveq   #0,D0
            tst.l   (A0)
            bpl.w   PwrAllDone
            btst    #0,D2
            beq.w   PwrAllDone
            fneg.x  FP0,FP0
            bra.w   PwrAllDone
XPWRK:
            fmove.x FP0,FP1
            bsr.b   XPWRKLOOP
            tst.w   D2
            bmi.b   XPWRKDIV
XPWRKSTORE:
            fmove.x FP2,FP0
            rts
XPWRKDIV:
            move.w  D2,D0
            bpl.b   .L1
            neg.w   D0
.L1:
            fmove.l FPSR,D1
            andi.l  #$60,D1
            bne.b   XPWRKCLEAR
            fmovecr.x #$32,FP0
            fdiv.x  FP2,FP0
            rts
XPWRKCLEAR:
            fmove.l FPSR,D1
            moveq   #$60,D0
            eori.l  #$FFFFFFFF,D0
            and.l   D0,D1
            fmove.l D1,FPSR
            fmovecr.x #$32,FP0
            fdiv.x  FP1,FP0
            bsr.b   XPWRKLOOP
            bra.b   XPWRKSTORE
XPWRKLOOP:
            fmovecr.x #$32,FP2
            bra.b   XKLPENTRY
XKLPTOP:
            fmul.x  FP0,FP0
XKLPENTRY:
            lsr.w   #1,D0
            bcc.b   XKLPSKIP
            fmul.x  FP0,FP2
XKLPSKIP:
            bne.b   XKLPTOP
            rts
ClearInexact:
            fmove.l FPSR,D1
            moveq   #8,D0
            eori.l  #$FFFFFFFF,D0
            and.l   D0,D1
            fmove.l D1,FPSR
            rts
ForceDivByZero:
            fmove.l FPSR,D0
            ori.l   #$100000,D0
            fmove.l D0,FPSR
            rts
P1STUFFXPWR:
            move.l  #$3F800000,D1
            bra.b   StuffOutXpwr
P0STUFFXPWR:
            moveq   #0,D1
            bra.b   StuffOutXpwr
M0STUFFXPWR:
            move.l  #$80000000,D1
            bra.b   StuffOutXpwr
DIVP0STUFFXPWR:
            bsr.b   ForceDivByZero
            move.l  #$7F800000,D1
            bra.b   StuffOutXpwr2
DIVM0STUFFXPWR:
            bsr.b   ForceDivByZero
            move.l  #$FF800000,D1
            bra.b   StuffOutXpwr2
StuffOutXpwr:
            moveq   #0,D0
StuffOutXpwr2:
            fmove.s D1,FP0
PwrAllDone:
            tst.b   D4
            beq.b   .L9
            fneg.x  FP0,FP0
.L9:
            movem.l (SP)+,D2-D4/A1
            move.l  ($30,SP),($3A,SP)
            lea     PwrFinal,A0
            move.l  A0,($30,SP)
            jmp     (A4)
PwrFinal:
            rts
XPWRY:
            lea     (RLog2x.w,PC),A1
            bsr.w   CallElems
            fmul.x  FP3,FP0
            lea     (RExp2x.w,PC),A1
            bsr.w   CallElems
            rts
RXpwry:
            fmove.l FPSR,D0
            movem.l D2-D4/A1,-(SP)
            movea.l ($4A,SP),A1
            move.b  ($45,SP),D1
            bpl.b   .L2
            fmove.x (A1),FP3
            bra.b   .L3
.L2:
            addq.l  #6,A1
            move.l  (A1),-(SP)
            move.l  -(A1),-(SP)
            subq.l  #2,A1
            move.l  (A1),-(SP)
            fmove.x (SP)+,FP3
.L3:
            moveq   #0,D4
            fmove.l FPSR,D1
            move.l  #$F000000,D2
            move.l  D1,D3
            and.l   D2,D3
            lsl.l   #5,D3
            and.l   D2,D0
            lsl.l   #5,D0
            bne.b   XpwrWierd
            bcs.b   XpwrWierd
            tst.l   D3
            bne.b   XpwrWierd
XPWRYOK:
            fmove.w FP3,D2
            fmove.l FPSR,D1
            bclr    #7,D1
            sne     D2
            fmove.l D1,FPSR
            btst    #3,D1
            sne     D0
            or.b    D2,D0
            bne.b   XPWRYHARD
            fmove.w FP3,D2
            move.w  D2,D0
            bpl.b   .L5
            neg.w   D0
.L5:
            cmpi.w  #$FF,D0
            ble.b   .L6
            bra.b   XPWRYHARD
.L6:
            bsr.w   XPWRK
            bra.b   ByPassXPWRY
XPWRYHARD:
            bclr    #3,D1
            fmove.l D1,FPSR
            bsr.w   XPWRY
ByPassXPWRY:
            moveq   #0,D0
            btst    #$1F,D3
            bne.b   .L9
            btst    #$1E,D3
            beq.b   .L10
.L9:
            move.b  #8,D0
.L10:
            bra.w   PwrAllDone
XpwrWierd:
            bpl.b   .L16
            bcc.b   .L16
            btst    #$1D,D3
            bne.b   .L16
            lsl.l   #5,D1
            bne.b   .L15
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   XPWRYERR
            bcs.b   .L13
            fscale.w #$FFFF,FP3
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L12
            fabs.x  FP0,FP0
.L12:
            moveq   #8,D0
            bra.w   PwrAllDone
.L13:
            bsr.w   ForceDivByZero
            fscale.w #$FFFF,FP3
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L14
            bra.w   DIVP0STUFFXPWR
.L14:
            bra.w   DIVM0STUFFXPWR
.L15:
            bra.b   XPWRYERR
.L16:
            btst    #$1D,D0
            beq.b   .L17
            bra.w   PwrAllDone
.L17:
            btst    #$1D,D3
            beq.b   .L18
            fmove.x FP3,FP0
            bra.w   PwrAllDone
.L18:
            ftst.x  FP0
            fblt.w  NEGPWRY
            bsr.b   XPWRYCOM
            bra.w   PwrAllDone
XPWRY9ERR:
            addq.l  #4,SP
XPWRYERR:
            bsr.w   ClearInexact
            moveq   #$25,D1
            lsl.l   #8,D1
            ori.l   #$7FC00000,D1
            move.l  #$800000,D0
            bra.w   StuffOutXpwr2
NEGPWRY:
            btst    #30,D3
            bne.b   XPWRYERR
            btst    #$1E,D0
            beq.b   .L22
            btst    #$1F,D3
            bne.b   XPWRYERR
.L22:
            fint.x  FP3,FP2
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   XPWRYERR
            fscale.w #$FFFF,FP2
            fint.x  FP2,FP2
            fmove.l FPSR,D2
            btst    #3,D2
            sne     D4
            bsr.w   ClearInexact
            fabs.x  FP0,FP0
            bsr.b   XPWRYCOM
            tst.b   D4
            beq.w   PwrAllDone
            fneg.x  FP0,FP0
            bra.w   PwrAllDone
XPWRYCOM:
            fbne.w  .L4
            btst    #$1E,D3
            bne.b   .L1
            tst.l   D3
            bne.b   XPWRY9ERR
            ftst.x  FP3
            fblt.w  .L2
.L1:
            lsl.l   #5,D1
            bcs.b   .L2
            moveq   #0,D1
            moveq   #0,D0
            bra.b   .L3
.L2:
            bsr.w   ForceDivByZero
            move.l  #$7F800000,D1
.L3:
            fmove.s D1,FP0
            rts
.L4:
            btst    #$1E,D0
            beq.b   .L8
            tst.l   D3
            bmi.b   .L5
            bra.b   .L7
.L5:
            tst.l   D0
            bpl.b   .L6
            fmovecr.x #$32,FP0
            moveq   #0,D0
            addq.l  #4,SP
            bra.w   PwrAllDone
.L6:
            bra.w   XPWRY9ERR
.L7:
            addq.l  #4,SP
            bra.w   XPWRYOK
.L8:
            btst    #$1E,D3
            beq.b   .L9
            fmovecr.x #$32,FP1
            fcmp.x  FP0,FP1
            fbne.w  .L9
            bra.w   XPWRY9ERR
.L9:
            addq.l  #4,SP
            bra.w   XPWRYOK
