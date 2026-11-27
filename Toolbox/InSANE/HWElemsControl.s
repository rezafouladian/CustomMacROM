            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5

            IMPORT  BaseOfROM,RsrcEntryPACK_4

            SECTION "InSANE_HWElems",CODE

; HWElemsControl.a: PACK 5 SANE elementary functions (FPU)

RsrcEntryPACK_5:
            dc.b    $70,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 5 (5028 bytes) - Combo mask
            dc.l    RsrcEntryPACK_4-BaseOfROM       ; Next entry
            dc.l    RsrcPACK_5-BaseOfROM            ; Data
            dc.b    'PACK'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'omputer, Inc'
            dc.l    $C0A00000,$000013B0,$000001E4   ; Block header
RsrcPACK_5:
            bra.b   .L1
            dc.w    0,$5041,$434B,$0005,$0008
.L1:
            movem.l D0-D1/A0/A4,-(SP)
            fmovem.x FP2-FP3,-(SP)
            fmove.l FPSR,-(SP)
            fmove.l FPCR,-(SP)
            moveq   #0,D1
            fmove.l D1,FPCR
            fmove.l D1,FPSR
            movea.l ($36,SP),A0
            move.w  ($34,SP),D0
            btst    #$E,D0
            beq.b   .L3
            btst    #7,D0
            beq.b   .L2
            lea     Out96,A4
            bra.b   .L5
.L2:
            lea     Out80,A4
            bra.b   .L5
.L3:
            btst    #7,D0
            beq.b   .L4
            move.w  (4,A0),(2,A0)
            lea     Out96,A4
            fmove.x (A0),FP0
            bra.b   .L5
.L4:
            lea     Out80,A4
            addq.l  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.l  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP0
.L5:
            move.w  #$3E,D1
            and.b   D0,D1
            move.w  .L6(PC,D1.w),D1
            jmp     .L5(PC,D1.w)
.L6:
            dc.w    RLnx-.L5
            dc.w    RLog2x-.L5
            dc.w    RLn1x-.L5
            dc.w    RLog21x-.L5
            dc.w    RExpx-.L5
            dc.w    RExp2x-.L5
            dc.w    RExp1x-.L5
            dc.w    RExp21x-.L5
            dc.w    RXpwri-.L5
            dc.w    RXpwry-.L5
            dc.w    RCompound-.L5
            dc.w    RAnnuity-.L5
            dc.w    RSin-.L5
            dc.w    RCos-.L5
            dc.w    RTan-.L5
            dc.w    RAtan-.L5
            dc.w    RRandom-.L5
Out80:
            movea.l ($36,SP),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bra.b   Exit
Out96:
            movea.l ($36,SP),A0
            fmove.x FP0,(A0)
Exit:
            moveq   #-1,D1
            eor.b   D1,D0
            fmove.l FPSR,D1
            and.b   D0,D1
            swap    D0
            or.b    D1,D0
            or.b    D0,(7,SP)
            move.b  (2,SP),D1
            fmovem.l (SP)+,FPCR/FPSR
            bclr    #5,D1
            bftst   D1{24:2}
            beq.b   .L2
            bset    #5,D1
.L2:
            andi.w  #$3E,D1
            beq.b   .L3
            lsl.b   #2,D1
            and.w   D1,D0
            beq.b   .L3
            lsr.b   #3,D0
            clr.l   -(SP)
            clr.w   -(SP)
            move.b  STICKYMAP2(PC,D0.w),D0
            move.w  D0,-(SP)
            move.l  SP,-(SP)
            move.l  ($42,SP),-(SP)
            move.l  ($42,SP),-(SP)
            move.l  ($42,SP),-(SP)
            move.w  ($44,SP),-(SP)
            bset    #7,(SP)
            movea.w #$A4C,A0
            movea.l (A0),A0
            jsr     (A0)
            addq.w  #8,SP
.L3:
            fmovem.x (SP)+,FP2-FP3
            movem.l (SP)+,D0-D1/A0/A4
            rtd     #6
STICKYMAP2:
            dc.w    $0010,$0818,$0212,$0A1A,$0414,$0C1C,$0616,$0E1E
            dc.w    $0111,$0919,$0313,$0B1B,$0515,$0D1D,$0717,$0F1F
RRandom:
            fmul.w  #$41A7,FP0
            moveq   #0,D0
            fmove.l #$7FFFFFFF,FP1
            frem.x  FP1,FP0
            fbge.w  .L6
            fadd.x  FP1,FP0
.L6:
            jmp     (A4)

            include "Toolbox/InSANE/HWElemsExp.s"
            include "Toolbox/InSANE/HWElemsFinancial.s"
            include "Toolbox/InSANE/HWElemsCommon.s"
            include "Toolbox/InSANE/HWElemsLogs.s"
            include "Toolbox/InSANE/HWElemsTg.s"
            include "Toolbox/InSANE/HWElemsArcTg.s"
            include "Toolbox/InSANE/HWElemsSinCos.s"
            include "Toolbox/InSANE/HWElemsCoeffs.s"

            EVEN
