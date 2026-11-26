            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5

            IMPORT  BaseOfROM,RsrcEntryPACK_4

            SECTION "Part15",CODE

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
            lea     sub_408EED10,A4
            bra.b   .L5
.L2:
            lea     sub_408EECFE,A4
            bra.b   .L5
.L3:
            btst    #7,D0
            beq.b   .L4
            move.w  (4,A0),(2,A0)
            lea     sub_408EED10,A4
            fmove.x (A0),FP0
            bra.b   .L5
.L4:
            lea     sub_408EECFE,A4
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
            dc.w    sub_408EF67C.L16-.L5
            dc.w    sub_408EF67C.L2-.L5
            dc.w    sub_408EF67C.L11-.L5
            dc.w    sub_408EF67C.L4-.L5
            dc.w    sub_408EEEEA.L8-.L5
            dc.w    sub_408EEEEA.L1-.L5
            dc.w    sub_408EED10.L11-.L5
            dc.w    sub_408EED10.L7-.L5
            dc.w    sub_408EF2E2.L1-.L5
            dc.w    sub_408EF470.L1-.L5
            dc.w    sub_408EEEEA.L10-.L5
            dc.w    sub_408EEEEA.L18-.L5
            dc.w    sub_408EF7F4.L26-.L5
            dc.w    sub_408EF7F4.L35-.L5
            dc.w    sub_408EF7F4.L5-.L5
            dc.w    sub_408EF7F4.L12-.L5
            dc.w    sub_408EED10.L5-.L5
sub_408EECFE:
            movea.l ($36,SP),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bra.b   sub_408EED10.L1
sub_408EED10:
            movea.l ($36,SP),A0
            fmove.x FP0,(A0)
.L1:
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
            move.b  .L4(PC,D0.w),D0
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
.L4:
            dc.w    $0010,$0818,$0212,$0A1A,$0414,$0C1C,$0616,$0E1E
            dc.w    $0111,$0919,$0313,$0B1B,$0515,$0D1D,$0717,$0F1F
.L5:
            fmul.w  #$41A7,FP0
            moveq   #0,D0
            fmove.l #$7FFFFFFF,FP1
            frem.x  FP1,FP0
            fbge.w  .L6
            fadd.x  FP1,FP0
.L6:
            jmp     (A4)
.L7:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   .L15
            bfextu  (A0){1:16},D0
            beq.w   .L13
            fint.x  FP0,FP3
            fsne    D1
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            fsub.x  FP3,FP0
.L8:
            bsr.w   sub_408EEEAA
            tst.b   D1
            beq.b   .L10
            moveq   #1,D1
            fadd.l  D1,FP0
            fmove.l #$4000,FP1
            fcmp.x  FP3,FP1
            fbne.w  .L9
            fmove.l #$2000,FP3
            fscale.x FP3,FP0
.L9:
            fscale.x FP3,FP0
            fsub.l  D1,FP0
            moveq   #$20,D0
.L10:
            jmp     (A4)
.L11:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   .L15
            bfextu  (A0){1:16},D0
            beq.b   .L14
            bsr.w   sub_408EEEEA
            btst    #6,D0
            beq.b   .L8
            move.l  #$80000,D0
            move.w  (A0),D1
            bmi.b   .L12
            move.l  #$7F800000,D1
            fmove.s D1,FP0
            bra.b   .L10
.L12:
            move.b  #$40,D0
            fmove.l #$FFFFFFFF,FP0
            jmp     (A4)
.L13:
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
.L14:
            move.l  #$280000,D0
            jmp     (A4)
.L15:
            bmi.b   .L16
            btst    #$1E,D0
            beq.b   .L16
            bcc.b   .L16
            moveq   #-1,D0
            fmove.l D0,FP0
.L16:
            moveq   #0,D0
            jmp     (A4)
.L17:
            bpl.b   .L18
            fmovecr.x #$32,FP0
            bra.b   .L19
.L18:
            btst    #$1E,D0
            beq.b   .L19
            bcc.b   .L19
            fmovecr.x #$F,FP0
.L19:
            moveq   #0,D0
            jmp     (A4)
sub_408EEEAA:
            fbeq.w  .L1
            fmove.x FP0,FP2
            fmul.x  FP2,FP0
            lea     sub_408EFCAA.L3,A0
            bsr.w   sub_408EF67C
            fmul.x  FP1,FP2
            lea     sub_408EFCAA.L4,A0
            bsr.w   sub_408EF67C
            fsub.x  FP2,FP1
            fscale.b #1,FP2
            fdiv.x  FP1,FP2
            fmove.x FP2,FP0
            move.l  #$80000,D0
            ori.l   #$20,D0
.L1:
            rts
sub_408EEEEA:
            fmovecr.x #$30,FP1
            fmove.x FP0,FP3
            frem.x  FP1,FP0
            fsub.x  FP0,FP3
            fdiv.x  FP1,FP3
            fint.x  FP3,FP3
            fsne    D1
            fdiv.x  FP1,FP0
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            rts
.L1:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   sub_408EED10.L17
            fint.x  FP0,FP3
            fmove.l FPSR,D0
            bclr    #3,D0
            fmove.l D0,FPSR
            fsub.x  FP3,FP0
.L2:
            bsr.w   sub_408EEEAA
            moveq   #1,D1
            fadd.l  D1,FP0
            fmove.l #$FFFFC001,FP1
            fsub.x  FP3,FP1
            fbgt.w  .L6
            fbeq.w  .L3
            bra.b   .L4
.L3:
            fmove.l #1,FP1
            fcmp.x  FP1,FP0
            fbge.w  .L4
            ori.l   #$200000,D0
.L4:
            fmove.l #$4000,FP1
            fcmp.x  FP3,FP1
            fbne.w  .L5
            fmove.l #$2000,FP3
            fscale.x FP3,FP0
.L5:
            fscale.x FP3,FP0
            jmp     (A4)
.L6:
            fmove.l #$FFFFC001,FP3
            fscale.x FP3,FP0
            fneg.x  FP1,FP1
            fscale.x FP1,FP0
            btst    #$13,D0
            beq.b   .L7
            ori.l   #$200000,D0
.L7:
            jmp     (A4)
.L8:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   sub_408EED10.L17
            bsr.w   sub_408EEEEA
            btst    #6,D0
            beq.w   .L2
            move.l  #$80000,D0
            move.w  (A0),D1
            bmi.b   .L9
            move.l  #$7F800000,D1
            fmove.s D1,FP0
            jmp     (A4)
.L9:
            move.l  #$280040,D0
            fmovecr.x #$F,FP0
            jmp     (A4)
.L10:
            bsr.w   sub_408EF1E8
            fbne.w  .L11
            btst    #$1A,D0
            bne.w   sub_408EF1E8.L8
            btst    #$1B,D0
            bne.w   sub_408EF1E8.L12
            bra.w   sub_408EF1E8.L9
.L11:
            btst    #$1A,D0
            bne.w   sub_408EF1E8.L8
            btst    #$19,D0
            beq.b   .L12
            btst    #$1A,D1
            bne.w   sub_408EF1E8.L7
            eor.l   D1,D0
            btst    #$1B,D0
            beq.w   sub_408EF1E8.L13
            bra.w   sub_408EF1E8.L9
.L12:
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
            lea     sub_408EF67C.L4,A1
            bsr.w   sub_408EF2CA
            fmove.l FPSR,D0
            movea.l D1,A0
            fmul.x  FP2,FP0
            lea     .L1,A1
            bsr.w   sub_408EF2CA
            bra.b   .L15
.L14:
            fmul.x  FP2,FP0
            lea     .L8,A1
            bsr.w   sub_408EF2CA
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
            bra.w   sub_408EF1E8.L16
.L18:
            bsr.w   sub_408EF1E8
            fbne.w  .L19
            btst    #$1A,D0
            bne.w   sub_408EF1E8.L9
            btst    #$1B,D0
            bne.w   sub_408EF1E8.L10
            bra.w   sub_408EF1E8.L12
.L19:
            btst    #$1A,D0
            bne.w   sub_408EF1E8.L9
            btst    #$19,D1
            bne.b   .L21
            btst    #$1A,D1
            beq.b   .L22
.L20:
            fmove.x FP2,FP0
            bra.w   sub_408EF1E8.L16
.L21:
            btst    #$1B,D0
            beq.w   sub_408EF1E8.L9
            fcmp.x  FP1,FP2
            fbeq.w  sub_408EF1E8.L10
            fbogt.w sub_408EF1E8.L11
            bra.w   sub_408EF1E8.L14
.L22:
            fmove.x FP0,FP3
            btst    #$19,D0
            beq.b   .L23
            eor.l   D1,D0
            btst    #$1B,D0
            bne.b   .L20
            fmovecr.x #$32,FP0
            fdiv.x  FP3,FP0
            bra.w   sub_408EF1E8.L16
.L23:
            movem.l A1/A4,-(SP)
            fgetexp.x FP3,FP0
            fmove.w #$FFC0,FP1
            fcmp.x  FP0,FP1
            fbogt.w .L24
            lea     sub_408EF67C.L4,A1
            fmove.x FP3,FP0
            bsr.w   sub_408EF2CA
            fmul.x  FP2,FP0
            fneg.x  FP0,FP0
            fcmp.w  #$100,FP0
            fbolt.w .L25
            fmove.s #"$7F7FFFFF",FP1
            fcmp.x  FP1,FP3
            fbogt.w .L31
            bra.b   .L25
.L24:
            fmove.x FP3,FP1
            fmul.x  FP2,FP3
            fneg.x  FP3,FP0
            fmove.x FP1,FP3
            lea     sub_408EED10.L11,A1
            bsr.w   sub_408EF2CA
            bra.b   .L26
.L25:
            lea     sub_408EED10.L7,A1
            bsr.w   sub_408EF2CA
.L26:
            fneg.x  FP0,FP0
            fdiv.x  FP3,FP0
.L27:
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
            bra.w   sub_408EF1E8.L16
.L31:
            lea     sub_408EF67C.L2,A1
            fmove.x FP3,FP0
            bsr.w   sub_408EF2CA
            fadd.w  #1,FP2
            fmul.x  FP2,FP0
            fneg.x  FP0,FP0
            lea     .L1,A1
            bsr.w   sub_408EF2CA
            fneg.x  FP0,FP0
            fmove.l FPSR,D1
            bset    #3,D1
            fmove.l D1,FPSR
            bra.b   .L27
sub_408EF1E8:
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
            bra.b   .L7
.L5:
            btst    #$E,D1
            beq.b   .L6
            move.l  #$800000,D0
.L6:
            addq.l  #4,SP
            bra.b   .L16
.L7:
            moveq   #$26,D1
            lsl.l   #8,D1
            ori.l   #$7FC00000,D1
            move.l  #$800000,D0
            bra.b   .L15
.L8:
            move.l  #$3F800000,D1
            bra.b   .L15
.L9:
            moveq   #0,D1
            bra.b   .L15
.L10:
            move.l  #$BF800000,D1
            bra.b   .L15
.L11:
            move.l  #$80000000,D1
            bra.b   .L15
.L12:
            ori.l   #$100000,D0
.L13:
            move.l  #$7F800000,D1
            bra.b   .L15
.L14:
            move.l  #$FF800000,D1
.L15:
            fmove.s D1,FP0
.L16:
            move.l  ($30,SP),($3A,SP)
            lea     .L17,A0
            move.l  A0,($30,SP)
            jmp     (A4)
.L17:
            rtd     #4
sub_408EF2CA:
            fmovem.x FP1-FP3,-(SP)
            movem.l A0/A4,-(SP)
            ftst.x  FP0
            lea     sub_408EF2E2,A4
            fmove.x FP0,-(SP)
            lea     (SP),A0
            jmp     (A1)
sub_408EF2E2:
            adda.w  #$C,SP
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
.L1:
            movem.l D2-D4/A1,-(SP)
            movea.l ($4A,SP),A1
            move.w  (A1),D2
            moveq   #0,D4
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            move.l  D0,D1
            lsl.l   #5,D0
            beq.b   .L5
            btst    #$1D,D0
            bne.w   sub_408EF414.L8
            tst.w   D2
            beq.w   sub_408EF414.L1
            btst    #0,D2
            bne.b   .L3
            tst.w   D2
            bmi.b   .L2
            fabs.x  FP0,FP0
            bra.w   sub_408EF414.L8
.L2:
            tst.l   D0
            bmi.w   sub_408EF414.L4
            bra.w   sub_408EF414.L2
.L3:
            tst.w   D2
            bpl.w   sub_408EF414.L8
            tst.l   D0
            bmi.b   .L4
            lsl.l   #5,D1
            bcc.w   sub_408EF414.L2
            bra.w   sub_408EF414.L3
.L4:
            lsl.l   #5,D1
            bcc.w   sub_408EF414.L4
            bra.w   sub_408EF414.L5
.L5:
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            bhi.b   .L7
            bsr.b   sub_408EF3A0
            moveq   #0,D0
            bra.w   sub_408EF414.L8
.L7:
            fabs.x  FP0,FP0
            fmove.w D2,FP3
            bsr.w   sub_408EF470
            moveq   #0,D0
            tst.l   (A0)
            bpl.w   sub_408EF414.L8
            btst    #0,D2
            beq.w   sub_408EF414.L8
            fneg.x  FP0,FP0
            bra.w   sub_408EF414.L8
sub_408EF3A0:
            fmove.x FP0,FP1
            bsr.b   sub_408EF3EA
            tst.w   D2
            bmi.b   .L2
.L1:
            fmove.x FP2,FP0
            rts
.L2:
            move.w  D2,D0
            bpl.b   .L3
            neg.w   D0
.L3:
            fmove.l FPSR,D1
            andi.l  #$60,D1
            bne.b   .L4
            fmovecr.x #$32,FP0
            fdiv.x  FP2,FP0
            rts
.L4:
            fmove.l FPSR,D1
            moveq   #$60,D0
            eori.l  #$FFFFFFFF,D0
            and.l   D0,D1
            fmove.l D1,FPSR
            fmovecr.x #$32,FP0
            fdiv.x  FP1,FP0
            bsr.b   sub_408EF3EA
            bra.b   .L1
sub_408EF3EA:
            fmovecr.x #$32,FP2
            bra.b   .L2
.L1:
            fmul.x  FP0,FP0
.L2:
            lsr.w   #1,D0
            bcc.b   .L3
            fmul.x  FP0,FP2
.L3:
            bne.b   .L1
            rts
sub_408EF400:
            fmove.l FPSR,D1
            moveq   #8,D0
            eori.l  #$FFFFFFFF,D0
            and.l   D0,D1
            fmove.l D1,FPSR
            rts
sub_408EF414:
            fmove.l FPSR,D0
            ori.l   #$100000,D0
            fmove.l D0,FPSR
            rts
.L1:
            move.l  #$3F800000,D1
            bra.b   .L6
.L2:
            moveq   #0,D1
            bra.b   .L6
.L3:
            move.l  #$80000000,D1
            bra.b   .L6
.L4:
            bsr.b   sub_408EF414
            move.l  #$7F800000,D1
            bra.b   .L7
.L5:
            bsr.b   sub_408EF414
            move.l  #$FF800000,D1
            bra.b   .L7
.L6:
            moveq   #0,D0
.L7:
            fmove.s D1,FP0
.L8:
            tst.b   D4
            beq.b   .L9
            fneg.x  FP0,FP0
.L9:
            movem.l (SP)+,D2-D4/A1
            move.l  ($30,SP),($3A,SP)
            lea     .L10,A0
            move.l  A0,($30,SP)
            jmp     (A4)
.L10:
            rts
sub_408EF470:
            lea     sub_408EF67C.L2,A1
            bsr.w   sub_408EF2CA
            fmul.x  FP3,FP0
            lea     sub_408EEEEA.L1,A1
            bsr.w   sub_408EF2CA
            rts
.L1:
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
            bne.b   .L11
            bcs.b   .L11
            tst.l   D3
            bne.b   .L11
.L4:
            fmove.w FP3,D2
            fmove.l FPSR,D1
            bclr    #7,D1
            sne     D2
            fmove.l D1,FPSR
            btst    #3,D1
            sne     D0
            or.b    D2,D0
            bne.b   .L7
            fmove.w FP3,D2
            move.w  D2,D0
            bpl.b   .L5
            neg.w   D0
.L5:
            cmpi.w  #$FF,D0
            ble.b   .L6
            bra.b   .L7
.L6:
            bsr.w   sub_408EF3A0
            bra.b   .L8
.L7:
            bclr    #3,D1
            fmove.l D1,FPSR
            bsr.w   sub_408EF470
.L8:
            moveq   #0,D0
            btst    #$1F,D3
            bne.b   .L9
            btst    #$1E,D3
            beq.b   .L10
.L9:
            move.b  #8,D0
.L10:
            bra.w   sub_408EF414.L8
.L11:
            bpl.b   .L16
            bcc.b   .L16
            btst    #$1D,D3
            bne.b   .L16
            lsl.l   #5,D1
            bne.b   .L15
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L20
            bcs.b   .L13
            fscale.w #$FFFF,FP3
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L12
            fabs.x  FP0,FP0
.L12:
            moveq   #8,D0
            bra.w   sub_408EF414.L8
.L13:
            bsr.w   sub_408EF414
            fscale.w #$FFFF,FP3
            fint.x  FP3,FP3
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L14
            bra.w   sub_408EF414.L4
.L14:
            bra.w   sub_408EF414.L5
.L15:
            bra.b   .L20
.L16:
            btst    #$1D,D0
            beq.b   .L17
            bra.w   sub_408EF414.L8
.L17:
            btst    #$1D,D3
            beq.b   .L18
            fmove.x FP3,FP0
            bra.w   sub_408EF414.L8
.L18:
            ftst.x  FP0
            fblt.w  .L21
            bsr.b   sub_408EF60A
            bra.w   sub_408EF414.L8
.L19:
            addq.l  #4,SP
.L20:
            bsr.w   sub_408EF400
            moveq   #$25,D1
            lsl.l   #8,D1
            ori.l   #$7FC00000,D1
            move.l  #$800000,D0
            bra.w   sub_408EF414.L7
.L21:
            btst    #$1E,D3
            bne.b   .L20
            btst    #$1E,D0
            beq.b   .L22
            btst    #$1F,D3
            bne.b   .L20
.L22:
            fint.x  FP3,FP2
            fmove.l FPSR,D2
            btst    #3,D2
            bne.b   .L20
            fscale.w #$FFFF,FP2
            fint.x  FP2,FP2
            fmove.l FPSR,D2
            btst    #3,D2
            sne     D4
            bsr.w   sub_408EF400
            fabs.x  FP0,FP0
            bsr.b   sub_408EF60A
            tst.b   D4
            beq.w   sub_408EF414.L8
            fneg.x  FP0,FP0
            bra.w   sub_408EF414.L8
sub_408EF60A:
            fbne.w  .L4
            btst    #$1E,D3
            bne.b   .L1
            tst.l   D3
            bne.b   sub_408EF470.L19
            ftst.x  FP3
            fblt.w  .L2
.L1:
            lsl.l   #5,D1
            bcs.b   .L2
            moveq   #0,D1
            moveq   #0,D0
            bra.b   .L3
.L2:
            bsr.w   sub_408EF414
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
            bra.w   sub_408EF414.L8
.L6:
            bra.w   sub_408EF470.L19
.L7:
            addq.l  #4,SP
            bra.w   sub_408EF470.L4
.L8:
            btst    #$1E,D3
            beq.b   .L9
            fmovecr.x #$32,FP1
            fcmp.x  FP0,FP1
            fbne.w  .L9
            bra.w   sub_408EF470.L19
.L9:
            addq.l  #4,SP
            bra.w   sub_408EF470.L4
sub_408EF67C:
            move.w  (A0)+,D0
            fmove.x (A0)+,FP1
.L1:
            fmul.x  FP0,FP1
            fadd.x  (A0)+,FP1
            dbra    D0,.L1
            rts
.L2:
            fmove.l FPSR,D0
            bsr.w   sub_408EF7C2
            bsr.w   sub_408EF7D4
            fsub.l  #1,FP0
            fsne    D1
            bsr.w   sub_408EF7F4
            tst.b   D1
            beq.b   .L3
            move.l  #$80000,D0
.L3:
            jmp     (A4)
.L4:
            fmove.x FP0,FP1
            fadd.l  #1,FP0
            fmove.l FPSR,D0
            bsr.w   sub_408EF7C2
            fmove.l FPSR,D1
            swap    D1
            fcmp.x  sub_408EFCAA.L5,FP0
            fbgt.w  .L5
            fcmp.x  sub_408EFCAA.L6,FP0
            fblt.w  .L5
            fmove.l #0,FP3
            fmove.x FP1,FP0
            bfextu  (A0){1:16},D0
            beq.b   .L9
            moveq   #1,D1
            bra.b   .L6
.L5:
            bsr.w   sub_408EF7D4
            fsub.l  #1,FP0
            fsne    D1
.L6:
            bsr.w   sub_408EF7F4
            tst.b   D1
            bne.b   .L7
            btst    #$13,D1
            beq.b   .L8
.L7:
            move.l  #$80000,D0
.L8:
            jmp     (A4)
.L9:
            fbeq.w  .L10
            fmovecr.x #$30,FP1
            fdiv.x  FP1,FP0
            move.l  #$200000,D0
.L10:
            jmp     (A4)
.L11:
            fmove.x FP0,FP1
            fadd.l  #1,FP0
            fmove.l FPSR,D0
            bsr.b   sub_408EF7C2
            fcmp.x  sub_408EFCAA.L5,FP0
            fbgt.w  .L12
            fcmp.x  sub_408EFCAA.L6,FP0
            fblt.w  .L12
            fmove.l #0,FP3
            fmove.x FP1,FP0
            bfextu  (A0){1:16},D0
            beq.b   .L14
            bra.b   .L13
.L12:
            bsr.b   sub_408EF7D4
            fsub.l  #1,FP0
.L13:
            bsr.b   sub_408EF7F4
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
            move.l  #$80000,D0
            jmp     (A4)
.L14:
            fbeq.w  .L15
            move.l  #$200000,D0
.L15:
            jmp     (A4)
.L16:
            fmove.l FPSR,D0
            bsr.b   sub_408EF7C2
            bsr.b   sub_408EF7D4
            fsub.l  #1,FP0
            bsr.b   sub_408EF7F4
            fmovecr.x #$30,FP1
            fmul.x  FP1,FP0
            fbeq.w  .L17
            move.l  #$80000,D0
            jmp     (A4)
.L17:
            moveq   #8,D0
            jmp     (A4)
sub_408EF7C2:
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bcs.w   sub_408EF7F4.L3
            bne.b   sub_408EF7F4.L1
            rts
sub_408EF7D4:
            fgetexp.x FP0,FP3
            fgetman.x FP0,FP0
            fcmp.x  sub_408EFCAA.L5,FP0
            fblt.w  .L1
            fadd.w  #1,FP3
            fdiv.w  #2,FP0
.L1:
            rts
sub_408EF7F4:
            fmove.x FP0,FP2
            fadd.l  #2,FP2
            fdiv.x  FP2,FP0
            fmove.x FP0,FP2
            fmul.x  FP2,FP0
            lea     sub_408EFCAA.L1,A0
            bsr.w   sub_408EF67C
            fmul.x  FP1,FP2
            lea     sub_408EFCAA.L2,A0
            bsr.w   sub_408EF67C
            fmove.l FPSR,D0
            bclr    #5,D0
            fmove.l D0,FPSR
            fdiv.x  FP1,FP2
            fmove.x FP2,FP0
            fadd.x  FP3,FP0
            rts
.L1:
            addq.l  #4,SP
            bmi.b   .L2
            jmp     (A4)
.L2:
            fmove.x #"$FFFF00000000000000000000",FP0
            move.l  #$100000,D0
            jmp     (A4)
.L3:
            addq.l  #4,SP
            lsl.l   #1,D0
            bcs.b   .L2
            btst    #$1E,D0
            bne.b   .L4
            fmove.x #"$7FFF00004024000000000000",FP0
            move.l  #$800008,D0
.L4:
            jmp     (A4)
.L5:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.w   .L10
            movem.l A1,-(SP)
            movea.l A0,A1
            fmove.x sub_408EFCAA.L10,FP1
            frem.x  FP1,FP0
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     sub_408EFCAA.L16,A0
            bsr.w   sub_408EF67C
            fmove.x FP1,FP2
            lea     sub_408EFCAA.L15,A0
            bsr.w   sub_408EF67C
            fdiv.x  FP1,FP2
            fmul.x  FP0,FP2
            fmove.x FP0,FP1
            fmul.x  FP3,FP1
            fmul.x  FP1,FP2
            fcmp.s  #"$3E800000",FP0
            fbgt.w  .L6
            fmul.x  FP3,FP0
            fdiv.w  #3,FP0
            fadd.x  FP2,FP0
            fadd.x  FP3,FP0
            bra.b   .L7
.L6:
            fmove.x FP3,FP1
            fadd.x  #"$BFFEBFFEC000000000000000",FP1
            fdiv.w  #3,FP1
            fmul.x  FP0,FP1
            fadd.x  FP2,FP1
            fdiv.w  #4,FP0
            fadd.x  FP1,FP0
            fadd.x  FP3,FP0
.L7:
            fmove.l FPSR,D0
            swap    D0
            lsr.b   #1,D0
            bcc.b   .L8
            fmove.w #$FFFF,FP1
            fdiv.x  FP0,FP1
            fmove.x FP1,FP0
            btst    #$A,D0
            beq.b   .L8
            fneg.x  FP0,FP0
.L8:
            bfextu  (A1){1:16},D0
            movea.l (SP)+,A1
            beq.b   .L9
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L9:
            move.l  #$280000,D0
            jmp     (A4)
.L10:
            bmi.b   .L11
            btst    #$1D,D0
            bne.b   .L11
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
.L11:
            moveq   #0,D0
            jmp     (A4)
.L12:
            movem.l A1-A3,-(SP)
            movea.l A0,A3
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bcs.b   .L13
            suba.l  A1,A1
            bra.b   .L14
.L13:
            movea.w #1,A1
.L14:
            bne.w   .L22
            fabs.x  FP0,FP0
            fcmp.w  #1,FP0
            fble.w  .L15
            movea.w #1,A2
            fmove.w #1,FP3
            fdiv.x  FP0,FP3
            fmove.x FP3,FP0
            bra.b   .L16
.L15:
            suba.l  A2,A2
            fmove.x FP0,FP3
.L16:
            fcmp.x  sub_408EFCAA.L9,FP0
            fbgt.w  .L21
            fmul.x  FP0,FP0
            lea     sub_408EFCAA.L18,A0
            bsr.w   sub_408EF67C
            fmove.x FP1,FP2
            lea     sub_408EFCAA.L17,A0
            bsr.w   sub_408EF67C
            fdiv.x  FP1,FP2
            fmul.x  FP3,FP2
            fsub.x  FP2,FP3
            fmove.x FP3,FP0
.L17:
            move.w  A2,D1
            beq.b   .L18
            fmove.x sub_408EFCAA.L10,FP1
            fsub.x  FP0,FP1
            fmove.x FP1,FP0
.L18:
            move.w  A1,D1
            beq.b   .L19
            fmul.b  #$FF,FP0
.L19:
            bfextu  (A3){1:16},D0
            movem.l (SP)+,A1-A3
            beq.b   .L20
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L20:
            move.l  #$80000,D0
            jmp     (A4)
.L21:
            fmovem.x FP4-FP5,-(SP)
            fmul.x  sub_408EFCAA.L7,FP3
            fmove.w #1,FP2
            fdiv.x  FP3,FP2
            fadd.w  #1,FP2
            fadd.w  #1,FP3
            fmove.x FP0,FP1
            fsub.x  sub_408EFCAA.L7,FP1
            fmove.x FP1,FP4
            fdiv.x  FP3,FP1
            fdiv.x  FP2,FP4
            fmove.x FP1,FP3
            fmul.x  FP1,FP1
            fmove.x FP0,FP2
            fmove.x FP1,FP0
            lea     sub_408EFCAA.L18,A0
            bsr.w   sub_408EF67C
            fmove.x FP1,FP5
            lea     sub_408EFCAA.L17,A0
            bsr.w   sub_408EF67C
            fdiv.x  FP1,FP5
            fmul.x  FP3,FP5
            fadd.x  sub_408EFCAA.L8,FP5
            fadd.x  FP4,FP5
            fsub.x  FP2,FP5
            fmove.x FP5,FP0
            fmul.b  #$FF,FP0
            fmovem.x (SP)+,FP4-FP5
            bra.w   .L17
.L22:
            bmi.b   .L23
            btst    #$1D,D0
            beq.b   .L24
.L23:
            movem.l (SP)+,A1-A3
            moveq   #0,D0
            jmp     (A4)
.L24:
            fmove.x sub_408EFCAA.L10,FP0
            move.w  A1,D1
            beq.b   .L25
            fmul.b  #$FF,FP0
.L25:
            movem.l (SP)+,A1-A3
            moveq   #0,D0
            jmp     (A4)
.L26:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   .L33
            movem.l A1,-(SP)
            movea.l A0,A1
            movem.l D2,-(SP)
            bcc.b   .L27
            moveq   #1,D2
            bra.b   .L28
.L27:
            moveq   #0,D2
.L28:
            fmove.x sub_408EFCAA.L10,FP1
            frem.x  FP1,FP0
            fmove.l FPSR,D0
            swap    D0
            move.b  D0,D1
            lsr.b   #1,D0
            bcc.b   .L29
            bsr.w   sub_408EFC12
            subq.b  #1,D2
            bmi.b   .L30
            fmul.w  #$FFFF,FP0
            bra.b   .L30
.L29:
            bsr.w   sub_408EFCAA
.L30:
            movem.l (SP)+,D2
            andi.b  #3,D1
            subq.b  #2,D1
            bmi.b   .L31
            fmul.w  #$FFFF,FP0
.L31:
            bfextu  (A1){1:16},D0
            movea.l (SP)+,A1
            beq.b   .L32
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L32:
            move.l  #$280000,D0
            jmp     (A4)
.L33:
            bmi.b   .L34
            btst    #$1D,D0
            bne.b   .L34
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
.L34:
            moveq   #0,D0
            jmp     (A4)
.L35:
            fmove.l FPSR,D0
            move.l  #$F000000,D1
            and.l   D1,D0
            lsl.l   #5,D0
            bne.b   .L41
            movem.l D2,-(SP)
            bcc.b   .L36
            moveq   #1,D2
            bra.b   .L37
.L36:
            moveq   #0,D2
.L37:
            fmove.x sub_408EFCAA.L10,FP1
            frem.x  FP1,FP0
            fmove.l FPSR,D0
            swap    D0
            move.b  D0,D1
            lsr.b   #1,D0
            bcs.b   .L38
            bsr.b   sub_408EFC12
            bra.b   .L39
.L38:
            bsr.w   sub_408EFCAA
            subq.b  #1,D2
            bmi.b   .L39
            fmul.w  #$FFFF,FP0
.L39:
            movem.l (SP)+,D2
            andi.b  #3,D1
            subq.b  #1,D1
            bmi.b   .L40
            subq.b  #2,D1
            bpl.b   .L40
            fmul.w  #$FFFF,FP0
.L40:
            move.l  #$80000,D0
            move.b  #$20,D0
            jmp     (A4)
.L41:
            bmi.b   .L43
            btst    #$1D,D0
            bne.b   .L42
            fmove.x #"$7FFF00004021000000000000",FP0
            move.l  #$800000,D0
            jmp     (A4)
.L42:
            moveq   #0,D0
            jmp     (A4)
.L43:
            fmove.w #1,FP0
            moveq   #0,D0
            jmp     (A4)
sub_408EFC12:
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     sub_408EFCAA.L14,A0
            bsr.w   sub_408EF67C
            fmove.x FP1,FP2
            lea     sub_408EFCAA.L13,A0
            bsr.w   sub_408EF67C
            fdiv.x  FP1,FP2
            fmul.x  FP0,FP2
            fmul.x  FP0,FP2
            fcmp.x  #"$3FFD3FFD8000000000000000",FP0
            fblt.w  .L1
            fabs.x  FP3,FP3
            fsub.x  #"$3FFE3FFE8000000000000000",FP3
            fmove.x FP3,FP1
            fdiv.w  #2,FP1
            fmul.x  FP1,FP3
            fsub.x  FP2,FP3
            fadd.x  FP1,FP3
            fmul.w  #$FFFF,FP3
            fadd.x  #"$3FFE3FFEE000000000000000",FP3
            fmove.x FP3,FP0
            rts
.L1:
            fdiv.w  #2,FP0
            fsub.x  FP0,FP2
            fadd.w  #1,FP2
            fmove.x FP2,FP0
            rts
sub_408EFCAA:
            fmove.x FP0,FP3
            fmul.x  FP0,FP0
            lea     .L12,A0
            bsr.w   sub_408EF67C
            fmove.x FP1,FP2
            lea     .L11,A0
            bsr.w   sub_408EF67C
            fdiv.x  FP1,FP2
            fmul.x  FP3,FP0
            fmul.x  FP0,FP2
            fsub.x  FP2,FP3
            fmove.x FP3,FP0
            rts
.L1:
            dc.w    $0004,$3FF6,0,$B946,$46AF,$F6CE,$3BFF,$3FF9
            dc.w    0,$94F4,$3221,$4D61,$FBEB,$3FFB,0,$DC97
            dc.w    $8903,$D944,$7893,$3FFF,0,$9F9E,$3946,$57CA
            dc.w    $1D05,$C001,0,$CD6B,$C53A,$46EC,$DC9A,$4001
            dc.w    0,$B483,$97E7,$BAE6,$FCE0
.L2:
            dc.b    $00,$01,$3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $C000,0,$B818,$35C3,$CE0A,$5E1D,$3FFF,0
            dc.w    $FA3E,$DF0E,$DDF4,$1A96
.L3:
            dc.w    $0002,$BFEE,0,$FF88,$90C8,$1B20,$9B79,$3FF9
            dc.w    0,$DA5C,$84EF,$B813,$272F,$4003,0,$97D3
            dc.w    $BAEA,$F80F,$FD45,$4009,0,$AB86,$71A1,$95BE
            dc.w    $FF0C
.L4:
            dc.b    $00,$01,$3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $4006,0,$D548,$7002,$984B,$5AB4,$400A,0
            dc.w    $F775,$612E,$96B7,$0780,$400D,0,$FFFE
            ds.b    6
            dc.w    $7FFF
            ds.b    10
            dc.w    $FFFF
            ds.b    10
            dc.b    $3F,$FD,$00,$00,$80
            ds.b    7
            dc.b    $3F,$FE,$00,$00,$80
            ds.b    7
            dc.b    $3F,$FE,$00,$00,$C0
            ds.b    7
            dc.b    $3F,$FE,$00,$00,$E0
            ds.b    7
            dc.w    $400D,0,$834E
            ds.b    6
            dc.w    $401D,0,$FFFF,$FFFE
            ds.b    4
.L5:
            dc.w    $3FFF,0,$B504,$F333,$F9DE,$6484
.L6:
            dc.w    $3FFE,0,$B504,$F333,$F9DE,$6484
.L7:
            dc.w    $3FFE,0,$93CD,$3A2C,$8198,$E26A
.L8:
            dc.w    $3FFA,0,$DC2A,$86B1,$5FDB,$6462
.L9:
            dc.w    $3FFD,0,$8930,$A2F4,$F66A,$B18A
.L10:
            dc.w    $3FFF,0,$C90F,$DAA2,$2168,$C235
.L11:
            dc.b    $00,$02,$3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $4007,0,$88D8,$B844,$A6A8,$5A30,$400E,0
            dc.w    $8A15,$8A49,$0979,$2320,$4013,0,$FAA9,$FE26
            dc.w    $FE63,$F22B
.L12:
            dc.w    $0002,$BFFE,0,$C250,$86AE,$43F5,$CBF5,$4006
            dc.w    0,$9E76,$EC66,$BEE7,$6BA2,$C00C,0,$AF51
            dc.w    $A1D6,$C4C4,$AA01,$4011,0,$A71B,$FEC4,$A997
            dc.w    $F6CE
.L13:
            dc.b    $00,$02,$3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $4007,0,$A6D9,$6A95,$FBDF,$9685,$400E,0
            dc.w    $C7A7,$EA65,$E85D,$156B,$4014,0,$D26E,$871C
            dc.w    $7B17,$52B2
.L14:
            dc.w    $0002,$BFFB,0,$D57E,$18D7,$A6F6,$D758,$4003
            dc.w    0,$E364,$937E,$32B3,$D072,$C00A,0,$A62D
            dc.w    $4056,$586B,$C045,$4010,0,$8C49,$AF68,$520F
            dc.w    $8C7A
.L15:
            dc.b    $00,$02,$BF,$FF,$00,$00,$80
            ds.b    7
            dc.w    $4005,0,$B513,$0324,$83C0,$0955,$C009,0
            dc.w    $D1FF,$B242,$5762,$E0CF,$400A,0,$E190,$9309
            dc.w    $9376,$66AB
.L16:
            dc.w    $0002,$BFE9,0,$B1FC,$3363,$D79B,$2838,$3FFD
            dc.w    0,$AA9D,$71D8,$3EC7,$4CD1,$C003,0,$E9CD
            dc.w    $8E24,$B965,$7DBB,$4007,0,$F09A,$3670,$9D4B
            dc.w    $1836
.L17:
            dc.w    $0003,$3FFF,0,$98D3,$1EAE,$2AFA,$5DAD,$4003
            dc.w    0,$8F79,$4CD8,$B3CD,$EFD9,$4005,0,$8E37
            dc.w    $ED85,$70B8,$B368,$4005,0,$CDA4,$BEA1,$AC59
            dc.w    $F3B8,$4004,0,$C405,$9C55,$4CF0,$C656
.L18:
            dc.b    $00,$03,$3F,$FF,$00,$00,$80
            ds.b    7
            dc.w    $4002,0,$A23B,$6C13,$1F92,$0E30,$4003,0
            dc.w    $C3C8,$593D,$FA3A,$486F,$4003,0,$82AE,$6838
            dc.w    $DDF5,$D945
            ds.b    12
            REPT    152
            dc.b    ' Copyright Apple'
            dc.b    ' Computer, Inc. '
            dc.b    '1989-1990][',$11,'Tue,'
            dc.b    ' Jul 18, 1989]<<'
            dc.b    'HJRBGMSHJMAAGCSL'
            dc.b    'RWHBBMGGDCCHDAFD'
            dc.b    'JWGMRSWCRLESRCSM'
            dc.b    'BPKEBALJWKDMLPAT'
            dc.b    'WTOSGSG DEVAJMP>'
            dc.b    '>[(c)'
            ENDR
            dc.b    ' Copyright Apple Computer, Inc. 1989-1990]['
            dc.b    17,'Tue, Jul 18, 1989'
            dc.b    ']<<HJRBGMSHJMAAGCSLRWHBBMGGDCCHDAFDJWGMRSWCRLESRCSMBPKEBALJ'

            EVEN
