            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5_2

            IMPORT  BaseOfROM,RsrcEntryDRVR_51

            SECTION "Part14",CODE

RsrcEntryPACK_4_2:
            dc.b    $08,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 4 (8308 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_51-BaseOfROM      ; Next entry
            dc.l    RsrcPACK_4_2-BaseOfROM          ; Data
            dc.b    'PACK'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'le Computer,'
            dc.l    $C0A00000,$00002080,$000001FC   ; Block header
RsrcPACK_4_2:
            subq.l  #4,SP
            movem.l D0/A0,-(SP)
.L1:
            moveq   #0,D0
            move.w  ($10,SP),D0
            bftst   D0{18:3}
            beq.b   .L2
            btst    #0,D0
            beq.b   .L4
.L2:
            andi.w  #$1F,D0
            add.w   D0,D0
            move.w  .L5(PC,D0.w),D0
            lea     .L1(PC,D0.w),A0
.L3:
            move.l  A0,(8,SP)
            movem.l (SP)+,D0/A0
            rts
.L4:
            andi.w  #$1E,D0
            move.w  .L6(PC,D0.w),D0
            lea     .L1(PC,D0.w),A0
            bra.b   .L3
.L5:
            dc.w    $060E,$116E,$062E,$117E,$0880,$118E,$0916,$119E
            dc.w    $0AF2,$161C,$0AF2,$144E,$09DC,$11AE,$0B70,$11BE
            dc.w    $0B70,$11CE,$0BCC,$1288,$0CCE,$121C,$0D4E,$11EC
            dc.w    $1024,$1238,$0FB8,$1200,$105C
.L6:
            dc.w    $061E,$063E,$0890,$0926,$0B02,$0B02,$09EC,$0BA0
            dc.w    $0DFE,$0BCC,$0CCE,$0D4E,$1024,$0FB8,$10DC
.L7:
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            movea.l A4,A3
            move.l  D4,D3
            movea.l D5,A2
            lsr.b   #1,D6
            move.l  D0,D1
            clr.w   D1
            add.l   D0,D0
            add.l   D1,D0
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
.L8:
            asl.b   #1,D6
            bvc.b   .L9
            bset    #6,D6
.L9:
            roxr.b  #1,D6
            moveq   #0,D7
            tst.w   D0
            bne.b   UNPACKXB.L2
            swap    D0
            jmp     (A0)
UNPACKXB:
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            movea.l A4,A3
            move.l  D4,D3
            movea.l D5,A2
            lsr.b   #1,D6
            move.l  D0,D1
            clr.w   D1
            add.l   D0,D0
            add.l   D1,D0
            move.l  D6,D1
            clr.w   D1
            rol.l   #6,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            movea.l ($E,A6),A1
            bsr.w   UNPBOP
            bra.b   RsrcPACK_4_2.L8
.L1:
            bset    #8,D6
            swap    D0
            bset    #$1E,D0
            move.l  D0,D4
            moveq   #0,D5
            movea.w #$7FFF,A4
            bra.w   PACKX
.L2:
            lea     FINI2OPS,A0
            subq.w  #2,D0
            beq.b   .L4
            subq.w  #2,D0
            beq.b   .L3
            move.l  D3,D7
            move.l  #$FF0000,D1
            and.l   D1,D7
            and.l   D4,D1
            cmp.l   D7,D1
            bgt.b   .L4
.L3:
            add.b   D6,D6
            movea.l A3,A4
            move.l  D3,D4
            move.l  A2,D5
.L4:
            bfextu  D6{11:5},D1
            subq.w  #8,D1
            beq.b   .L5
            subq.w  #2,D1
            bne.b   .L6
            bset    #8,D6
.L5:
            moveq   #2,D7
            bra.w   FINICMPS
.L6:
            bsr.b   sub_408E8052
            bra.w   PACKX
sub_408E8052:
            move.l  D4,D1
            bclr    #$1E,D1
            or.l    D5,D1
            bne.b   .L1
            moveq   #$15,D4
            swap    D4
            bset    #$1E,D4
.L1:
            rts
UNPXOP:
            move.w  (A1)+,D1
            bpl.b   .L1
            bset    #7,D6
            bclr    #$F,D1
.L1:
            btst    #$15,D6
            beq.b   .L2
            addq.w  #2,A1
.L2:
            move.l  (A1)+,D4
            move.l  (A1),D5
            cmpi.w  #$7FFF,D1
            beq.b   UNP0.L7
            tst.l   D4
            bpl.b   UNPNRM.L4
UNPNRM:
            ext.l   D1
            movea.l D1,A4
            rts
.L4:
            tst.l   D4
            bne.b   UNP0.L6
            tst.l   D5
            bne.b   UNP0.L6
UNP0:
            suba.l  A4,A4
            addi.l  #$20000,D0
            rts
.L6:
            subq.w  #1,D1
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L6
            bra.b   UNPNRM
.L7:
            movea.w #$7FFF,A4
            bclr    #$1F,D4
            tst.l   D4
            bne.b   .L8
            tst.l   D5
            bne.b   .L8
            addi.l  #$40000,D0
            rts
.L8:
            bset    #$1E,D4
            bne.b   .L9
            bset    #8,D6
.L9:
            addq.w  #2,D0
            rts
UNPBOP:
            move.w  .L1(PC,D1.w),D1
            jmp     UNPBOP(PC,D1.w)
.L1:
            dc.w    UNPDBL-UNPBOP
            dc.w    UNPSGL-UNPBOP
            dc.w    UNPXOP-UNPBOP
            dc.w    UNPI16-UNPBOP
            dc.w    UNPI32-UNPBOP
            dc.w    UNPC64-UNPBOP
UNPI16:
            moveq   #0,D4
            move.w  #$400E,D1
            move.l  D4,D5
            move.w  (A1),D4
            swap    D4
            bra.b   UNPIGEN
UNPI32:
            move.w  #$401E,D1
            moveq   #0,D5
            move.l  (A1),D4
UNPIGEN:
            beq.b   UNP0
            bpl.b   UNPIUNR
            bset    #7,D6
            neg.l   D4
            bmi.b   UNPNRM
UNPIUNR:
            bfffo   D4{0:0},D2
            sub.w   D2,D1
            lsl.l   D2,D4
            bra.w   UNPNRM
UNPC64:
            move.w  #$403E,D1
            move.l  (A1)+,D4
            move.l  (A1),D5
            bne.b   .L7
            tst.l   D4
            beq.w   UNP0
            bpl.b   UNPIUNR
            bset    #7,D6
            neg.l   D4
            bpl.b   UNPIUNR
            movea.w #$7FFF,A4
            bclr    #7,D6
            moveq   #$14,D4
            swap    D4
            bset    #$1E,D4
            addq.w  #2,D0
            rts
.L7:
            tst.l   D4
            bpl.b   .L8
            bset    #7,D6
            neg.l   D5
            negx.l  D4
            tst.l   D4
.L8:
            bne.w   UNP0.L6
            subi.w  #$20,D1
            exg     D4,D5
            tst.l   D4
            bpl.b   UNPIUNR
            bra.w   UNPNRM
UNPSGL:
            moveq   #0,D5
            move.l  (A1),D4
            bpl.b   .L10
            bset    #7,D6
.L10:
            bfextu  D4{1:8},D1
            beq.b   .L11
            lsl.l   #8,D4
            cmpi.b  #$FF,D1
            beq.w   UNP0.L7
            addi.w  #$3F80,D1
            bset    #$1F,D4
            bra.w   UNPNRM
.L11:
            lsl.l   #8,D4
            beq.w   UNP0
            move.w  #$3F81,D1
            bra.w   UNPIUNR
UNPDBL:
            move.l  (A1),D4
            bpl.b   .L13
            bset    #7,D6
.L13:
            move.l  (4,A1),D5
            bfextu  D4{1:11},D1
            bfextu  D5{0:11},D2
            lsl.l   #8,D4
            lsl.l   #8,D5
            lsl.l   #3,D4
            lsl.l   #3,D5
            or.w    D2,D4
            bclr    #$1F,D4
            tst.l   D1
            bne.b   .L14
            move.w  #$3C01,D1
            bra.w   UNPNRM.L4
.L14:
            cmpi.w  #$7FF,D1
            beq.w   UNP0.L7
            bset    #$1F,D4
            addi.w  #$3C00,D1
            bra.w   UNPNRM
RTSHIFT:
            cmpi.w  #$42,D0
            bls.b   .L1
            move.w  #$42,D0
.L1:
            cmpi.w  #$20,D0
            blt.b   .L2
            tst.l   D7
            sne     D3
            move.l  D5,D7
            move.l  D4,D5
            or.b    D3,D7
            moveq   #0,D4
            subi.w  #$20,D0
            bne.b   .L1
            rts
.L2:
            bfins   D7,D3{0:D0}
            sne     D3
            lsr.l   D0,D7
            bfins   D5,D7{0:D0}
            lsr.l   D0,D5
            bfins   D4,D5{0:D0}
            lsr.l   D0,D4
            or.b    D3,D7
            rts
ZNORMCOERCEX:
            moveq   #0,D7
            tst.l   D4
            bne.b   NORMX
            tst.l   D5
            bne.b   NORMX
            suba.l  A4,A4
            bra.w   PACKX
NORMX:
            tst.l   D4
            bmi.w   COERCEX
.L1:
            subq.l  #1,A4
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L1
            bra.w   COERCEX
NORMCOERCE:
            tst.l   D4
            bmi.b   COERCE
.L1:
            subq.l  #1,A4
            add.l   D7,D7
            addx.l  D5,D5
            addx.l  D4,D4
            bpl.b   .L1
COERCE:
            move.w  FPState,D1
            bftst   D1{25:2}
            beq.w   COERCEX
            bpl.w   COERCED
COERCES:
            bsr.b   SCOERCE
            bra.w   COERCESDONE
SCOERCE:
            move.l  #$3F81,D0
            sub.l   A4,D0
            ble.b   .L1
            bset    #9,D6
            movea.w #$3F81,A4
            bsr.w   RTSHIFT
.L1:
            tst.l   D5
            sne     D0
            or.b    D0,D7
            add.b   D4,D4
            roxr.l  #1,D7
            or.b    D4,D7
            moveq   #0,D5
            clr.b   D4
            tst.l   D7
            bne.b   .L2
            bclr    #9,D6
            bra.b   RNDOVERS
.L2:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L3
            tst.b   D6
            bpl.b   RNDUPS
            bra.b   RNDOVERS
.L3:
            btst    #$D,D1
            bne.b   RNDOVERS
            tst.b   D6
            bpl.b   RNDOVERS
            bra.b   RNDUPS
.L4:
            add.l   D7,D7
            bcc.b   RNDOVERS
            bne.b   RNDUPS
            btst    #8,D4
            beq.b   RNDOVERS
RNDUPS:
            addi.l  #$100,D4
            bcc.b   RNDOVERS
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERS:
            movea.w #$407E,A3
            cmpa.l  A4,A3
            blt.b   .L1
            rts
.L1:
            bset    #$A,D6
            bset    #$C,D6
            movea.w #$7FFF,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            bne.b   .L2
            rts
.L2:
            cmpi.b  #$60,D1
            beq.b   HUGES
            tst.b   D6
            bmi.b   .L3
            cmpi.b  #$20,D1
            bne.b   HUGES
            rts
.L3:
            cmpi.b  #$40,D1
            bne.b   HUGES
            rts
HUGES:
            moveq   #-1,D4
            movea.l A3,A4
            clr.b   D4
            rts
COERCED:
            bsr.b   DCOERCE
COERCESDONE:
            btst    #9,D6
            beq.w   PACKX
            move.w  A4,D3
            beq.w   PACKX
            tst.l   D4
            bne.b   .L3
            tst.l   D5
            bne.b   .L2
            suba.l  A4,A4
            bra.w   PACKX
.L2:
            subq.w  #1,A4
            add.l   D5,D5
            addx.l  D4,D4
.L3:
            bpl.b   .L2
            bra.w   PACKX
DCOERCE:
            move.l  #$3C01,D0
            sub.l   A4,D0
            ble.b   .L1
            bset    #9,D6
            movea.w #$3C01,A4
            bsr.w   RTSHIFT
.L1:
            move.l  #$7FF,D0
            and.w   D5,D0
            andi.w  #$F800,D5
            lsl.w   #5,D0
            swap    D0
            tst.l   D7
            sne     D0
            move.l  D0,D7
            tst.l   D7
            bne.b   .L2
            bclr    #9,D6
            bra.b   RNDOVERD
.L2:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L3
            tst.b   D6
            bpl.b   RNDUPD
            bra.b   RNDOVERD
.L3:
            btst    #$D,D1
            bne.b   RNDOVERD
            tst.b   D6
            bpl.b   RNDOVERD
            bra.b   RNDUPD
.L4:
            add.l   D7,D7
            bcc.b   RNDOVERD
            bne.b   RNDUPD
            btst    #$B,D5
            beq.b   RNDOVERD
RNDUPD:
            moveq   #0,D0
            move.l  #$800,D2
            add.l   D2,D5
            addx.l  D0,D4
            bcc.b   RNDOVERD
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERD:
            movea.w #$43FE,A3
            cmpa.l  A4,A3
            blt.b   .L7
            rts
.L7:
            bset    #$A,D6
            bset    #$C,D6
            movea.w #$7FFF,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            bne.b   .L8
            rts
.L8:
            cmpi.b  #$60,D1
            beq.b   HUGED
            tst.b   D6
            bmi.b   .L9
            cmpi.b  #$20,D1
            bne.b   HUGED
            rts
.L9:
            cmpi.b  #$40,D1
            bne.b   HUGED
            rts
HUGED:
            moveq   #-1,D4
            movea.l A3,A4
            move.l  #$FFFFF800,D5
            rts
COERCEX:
            move.l  A4,D0
            bpl.b   ROUNDX
            neg.l   D0
            bset    #9,D6
            suba.l  A4,A4
            bsr.w   RTSHIFT
ROUNDX:
            tst.l   D7
            bne.b   .L1
            bclr    #9,D6
            bra.b   RNDOVERX
.L1:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L15
            bmi.b   .L2
            tst.b   D6
            bpl.b   RNDUPX
            bra.b   RNDOVERX
.L2:
            btst    #13,D1
            bne.b   RNDOVERX
            tst.b   D6
            bpl.b   RNDOVERX
            bra.b   RNDUPX
.L15:
            add.l   D7,D7
            bcc.b   RNDOVERX
            bne.b   RNDUPX
            btst    #0,D5
            beq.b   RNDOVERX
RNDUPX:
            moveq   #0,D0
            addq.l  #1,D5
            addx.l  D0,D4
            bcc.b   RNDOVERX
            roxr.l  #1,D4
            addq.l  #1,A4
RNDOVERX:
            movea.w #$7FFF,A3
            cmpa.l  A3,A4
            blt.b   PACKX
            bset    #$A,D6
            bset    #$C,D6
            movea.w A3,A4
            sub.l   D4,D4
            sub.l   D5,D5
            lsr.w   #8,D1
            andi.b  #$60,D1
            beq.b   PACKX
            cmpi.b  #$60,D1
            beq.b   HUGEOUT
            tst.b   D6
            bmi.b   .L18
            cmpi.b  #$20,D1
            beq.b   PACKX
            bra.b   HUGEOUT
.L18:
            cmpi.b  #$40,D1
            beq.b   PACKX
HUGEOUT:
            subq.w  #1,A4
            not.l   D4
            not.l   D5
PACKX:
            move.w  A4,D3
            movea.l ($A,A6),A3
            tst.b   D6
            bpl.b   .L21
            bset    #$F,D3
.L21:
            move.w  D3,(A3)+
            btst    #$15,D6
            beq.b   .L22
            addq.w  #2,A3
.L22:
            move.l  D4,(A3)+
            move.l  D5,(A3)
            jmp     (A0)
FINI2OPS:
            clr.w   D7
FINICMPS:
            movea.w #$A4A,A1
            move.w  (A1),D0
            clr.b   D6
            or.w    D6,D0
            move.w  D0,(A1)+
            lsr.w   #8,D6
            and.w   D6,D0
            bne.b   HALT2OP
FINISH2:
            move    D7,CCR
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            rtd     #$A
HALT2OP:
            lea     FINISH2,A4
HALTCOMMON:
            move.w  D7,-(SP)
            move.w  D0,-(SP)
            pea     (SP)
            movem.l (6,A6),D0-D3
            movem.l D0-D3,-(SP)
            addq.w  #2,SP
            movea.l (A1),A1
            jsr     (A1)
            move.l  (SP)+,D7
            jmp     (A4)
FINI1OP:
            movea.w #$A4A,A1
            clr.w   D7
            move.w  (A1),D0
            clr.b   D6
            or.w    D6,D0
            move.w  D0,(A1)+
            ror.w   #8,D6
            and.w   D6,D0
            bne.b   HALT1OP
FINISH1:
            move    D7,CCR
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            rtd     #6
HALT1OP:
            lea     FINISH1,A4
            bra.b   HALTCOMMON
RDSTSGN:
            add.b   D6,D6
RDST:
            move.l  A2,D5
            move.l  D3,D4
            movea.l A3,A4
            bra.w   PACKX
;
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     ADDTOP,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     ADDTOP,A0
            bra.w   UNPACKXB
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     SUBTOP,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     SUBTOP,A0
            bra.w   UNPACKXB
SUBTOP:
            eori.b  #$A0,D6
ADDTOP:
            lea     FINI2OPS,A0
            move.w  .L2(PC,D0.w),D0
            jmp     ADDTOP(PC,D0.w)
.L2:
            dc.w    ADDNUM-ADDTOP
            dc.w    ADDEM.L30-ADDTOP
            dc.w    PACKX-ADDTOP
            dc.w    ADDEM.L31-ADDTOP
            dc.w    ADDEM.L27-ADDTOP
            dc.w    PACKX-ADDTOP
            dc.w    RDSTSGN-ADDTOP
            dc.w    RDSTSGN-ADDTOP
            dc.w    ADDEM.L32-ADDTOP
ADDNUM:
            exg     D4,D3
            exg     D5,A2
            move.w  A4,D0
            sub.w   A3,D0
            beq.w   ADDEM
            bgt.b   .L4
            exg     D5,A2
            exg     D4,D3
            movea.l A3,A4
            add.b   D6,D6
            neg.w   D0
            asr.b   #1,D6
.L4:
            move.l  D0,D2
            cmpi.w  #$42,D0
            bhi.w   ADDSHLOTS
            add.w   D2,D2
            move.w  ADDSHCASE(PC,D2.w),D2
            jmp     ADDNUM(PC,D2.w)
ADDSHCASE:
            dc.w    ADDEM-ADDNUM
            dc.w    ADDSH1-ADDNUM
            dc.w    ADDSH2-ADDNUM
            dc.w    ADDSH3-ADDNUM
            dc.w    ADDSH4-ADDNUM
            dc.w    ADDSH5-ADDNUM
            dc.w    ADDSH6-ADDNUM
            dc.w    ADDSH7-ADDNUM
            dc.w    ADDSH8-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH16-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH32-ADDNUM
            dc.w    ADDSH33-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH64-ADDNUM
            dc.w    ADDSH65-ADDNUM
            dc.w    ADDSH66-ADDNUM
ADDSHLOTS:
            moveq   #0,D4
            moveq   #0,D5
            not.b   D7
            bra.w   ADDEM
ADDSH66:
            or.w    D4,D5
            tst.l   D5
            sne     D7
            lsr.l   #2,D4
            bra.b   BIGSTICK
ADDSH65:
            or.w    D4,D5
            tst.l   D5
            sne     D7
            lsr.l   #1,D4
            bra.b   BIGSTICK
ADDSH64:
            tst.l   D5
            sne     D7
BIGSTICK:
            or.l    D4,D7
            moveq   #0,D4
            moveq   #0,D5
            bra.w   ADDEM
ADDSH33TO63:
            move.l  D5,D7
            subi.w  #$20,D0
            move.l  D4,D5
            ror.l   D0,D7
            lsr.l   D0,D5
            bftst   D7{0:D0}
            beq.b   .L12
            ori.w   #$FF,D7
.L12:
            bfins   D4,D7{0:D0}
            moveq   #0,D4
            bra.w   ADDEM
ADDSH33:
            move.l  D5,D7
            move.l  D4,D5
            moveq   #0,D4
            lsr.l   #1,D5
            roxr.l  #1,D7
            scs     D7
            bra.w   ADDEM
ADDSH32:
            move.l  D5,D7
            move.l  D4,D5
            moveq   #0,D4
            bra.w   ADDEM
ADDSH2TO31:
            bfins   D5,D7{0:D0}
            lsr.l   D0,D5
            bfins   D4,D5{0:D0}
            lsr.l   D0,D4
            bra.b   ADDEM
ADDSH16:
            move.w  D5,D7
            move.w  D4,D5
            clr.w   D4
            swap    D5
            swap    D4
            swap    D7
            bra.b   ADDEM
ADDSH8:
            bfins   D5,D7{0:8}
            move.b  D4,D5
            lsr.l   #8,D4
            ror.l   #8,D5
            bra.b   ADDEM
ADDSH7:
            bfins   D5,D7{0:7}
            lsr.l   #7,D5
            bfins   D4,D5{0:7}
            lsr.l   #7,D4
            bra.b   ADDEM
ADDSH6:
            bfins   D5,D7{0:6}
            lsr.l   #6,D5
            bfins   D4,D5{0:6}
            lsr.l   #6,D4
            bra.b   ADDEM
ADDSH5:
            bfins   D5,D7{0:5}
            lsr.l   #5,D5
            bfins   D4,D5{0:5}
            lsr.l   #5,D4
            bra.b   ADDEM
ADDSH4:
            bfins   D5,D7{0:4}
            lsr.l   #4,D5
            bfins   D4,D5{0:4}
            lsr.l   #4,D4
            bra.b   ADDEM
ADDSH3:
            bfins   D5,D7{0:3}
            lsr.l   #3,D5
            bfins   D4,D5{0:3}
            lsr.l   #3,D4
            bra.b   ADDEM
ADDSH2:
            bfins   D5,D7{0:2}
            lsr.l   #2,D5
            bfins   D4,D5{0:2}
            lsr.l   #2,D4
            bra.b   ADDEM
ADDSH1:
            lsr.l   #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
ADDEM:
            btst    #5,D6
            bne.b   .L26
            add.l   A2,D5
            addx.l  D3,D4
            bcc.w   COERCE
            roxr.l  #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
            scs     D1
            or.b    D1,D7
            addq.l  #1,A4
            bra.w   COERCE
.L26:
            not.b   D6
            sub.l   A2,D5
            subx.l  D3,D4
            beq.b   .L28
            bcc.w   NORMCOERCE
            neg.l   D7
            negx.l  D5
            negx.l  D4
            not.b   D6
            bra.w   NORMCOERCE
.L27:
            btst    #5,D6
            beq.w   PACKX
.L28:
            suba.l  A4,A4
            movea.w #$A4A,A1
            clr.b   D6
            btst    #6,(A1)
            beq.b   .L29
            btst    #5,(A1)
            bne.b   .L29
            not.b   D6
.L29:
            bra.w   PACKX
.L30:
            move.l  A2,D5
            move.l  D3,D4
            movea.l A3,A4
            add.b   D6,D6
.L31:
            bra.w   COERCE
.L32:
            btst    #5,D6
            bne.b   .L33
            bra.w   PACKX
.L33:
            moveq   #2,D0
            bra.w   UNPACKXB.L1
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8796,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8796,A0
            bra.w   UNPACKXB
sub_408E8796:
            lea     FINI2OPS,A0
            lsl.b   #2,D6
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E8796(PC,D0.w)
.L1:
            dc.w    .L2-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    RDST-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    .L5-sub_408E8796
            dc.w    RDST-sub_408E8796
            dc.w    .L5-sub_408E8796
            dc.w    PACKX-sub_408E8796
.L2:
            adda.l  A3,A4
            suba.w  #$3FFE,A4
            move.l  D3,D2
            move.l  A2,D3
            movea.l D6,A1
            movea.l D4,A2
            movea.l D5,A3
            moveq   #0,D7
            moveq   #0,D6
            move.l  A2,D5
            mulu.l  D2,D4:D5
            move.l  A3,D7
            beq.b   .L3
            mulu.l  D2,D0:D7
            add.l   D0,D5
            addx.l  D6,D4
.L3:
            move.l  D3,D0
            beq.b   .L4
            move.l  A2,D1
            mulu.l  D0,D0:D1
            add.l   D1,D7
            addx.l  D0,D5
            addx.l  D6,D4
            move.l  A3,D1
            beq.b   .L4
            mulu.l  D3,D0:D1
            add.l   D0,D7
            addx.l  D6,D5
            addx.l  D6,D4
            tst.l   D1
            sne     D1
            or.b    D1,D7
.L4:
            move.l  A1,D6
            bra.w   NORMCOERCE
.L5:
            moveq   #8,D0
            bra.w   UNPACKXB.L1
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E882C,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E882C,A0
            bra.w   UNPACKXB
sub_408E882C:
            lea     FINI2OPS,A0
            lsl.b   #2,D6
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E882C(PC,D0.w)
.L1:
            dc.w    .L5-sub_408E882C
            dc.w    .L2-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    .L4-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    RDST-sub_408E882C
            dc.w    RDST-sub_408E882C
            dc.w    .L4-sub_408E882C
.L2:
            bset    #$B,D6
            movea.w #$7FFF,A4
            moveq   #0,D4
            moveq   #0,D5
            bra.w   PACKX
.L3:
            suba.l  A4,A4
            move.l  A4,D4
            move.l  D4,D5
            bra.w   PACKX
.L4:
            moveq   #4,D0
            bra.w   UNPACKXB.L1
.L5:
            exg     A3,A4
            suba.l  A3,A4
            lea     ($3FFF,A4),A4
            movea.l D6,A3
            move.l  D3,D2
            move.l  A2,D3
            moveq   #0,D1
            move.l  D2,D6
            sub.l   D5,D3
            subx.l  D4,D2
            bcc.b   .L6
            subq.l  #1,A4
            add.l   A2,D3
            addx.l  D6,D2
.L6:
            bsr.b   DIV32
            movea.l D0,A2
            bsr.b   DIV32
            move.l  D0,D5
            move.l  A2,D4
            move.l  A3,D6
            moveq   #1,D7
            lsr.l   #1,D7
            roxr.l  #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
            or.l    D2,D3
            sne     D7
            bra.w   COERCE
DIV32:
            divu.l  D4,D2:D3
            bvs.b   sub_408E88C8
            move.l  D3,D0
            move.l  D3,D7
            mulu.l  D5,D6:D7
.L1:
            move.l  D1,D3
            sub.l   D7,D3
            subx.l  D6,D2
            bcc.b   .L3
.L2:
            subq.l  #1,D0
            add.l   D5,D3
            addx.l  D4,D2
            bcc.b   .L2
.L3:
            rts
sub_408E88C8:
            move.l  D5,D6
            moveq   #0,D7
            move.l  D3,D2
            moveq   #0,D0
            bra.b   DIV32.L1
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     REMTOP,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     REMTOP,A0
            bra.w   UNPACKXB
REMTOP:
            lea     FINI2OPS,A0
            clr.w   (2,SP)
            add.b   D6,D6
            move.w  REMCASE(PC,D0.w),D0
            jmp     REMTOP(PC,D0.w)
REMCASE:
            dc.w    REMNUM-REMTOP
            dc.w    INVALIDOP-REMTOP
            dc.w    REMDST-REMTOP
            dc.w    RDST-REMTOP
            dc.w    INVALIDOP-REMTOP
            dc.w    RDST-REMTOP
            dc.w    INVALIDOP-REMTOP
            dc.w    INVALIDOP-REMTOP
            dc.w    INVALIDOP-REMTOP
INVALIDOP:
            moveq   #9,D0
            bra.w   UNPACKXB.L1
REMNUM:
            move.l  A3,D0
            addq.l  #1,D0
            sub.l   A4,D0
            bpl.b   REMDIV
REMDST:
            move.l  D3,D4
            move.l  A2,D5
            movea.l A3,A4
            bra.b   REMFIN
REMDIV:
            subq.l  #1,A4
            cmpi.l  #9,D0
            bgt.b   REMSHIFT
            move.l  D3,D1
            move.l  A2,D2
            move.l  D4,D3
            movea.l D5,A2
            addq.l  #1,D0
            bsr.b   RESTORE
REMPOSTRESTORING:
            btst    #0,D5
            beq.b   REMQUO
            tst.l   D1
            bne.b   .L7
            tst.l   D2
            bne.b   .L7
            btst    #1,D5
            beq.b   .L8
.L7:
            bchg    #7,D6
            addq.w  #2,D5
.L8:
            exg     D2,A2
            exg     D1,D3
            sub.l   A2,D2
            subx.l  D3,D1
REMQUO:
            lsr.b   #1,D5
            btst    #6,D6
            beq.b   .L10
            neg.b   D5
.L10:
            ext.w   D5
            move.w  D5,(2,SP)
            move.l  D1,D4
            move.l  D2,D5
REMFIN:
            bra.w   ZNORMCOERCEX
RESTORE:
            moveq   #0,D4
            move.l  D4,D5
            bra.b   .L2
.L1:
            add.l   D5,D5
            addx.l  D4,D4
            add.l   D2,D2
            addx.l  D1,D1
            bcs.b   .L4
.L2:
            cmp.l   D3,D1
            bne.b   .L3
            cmp.l   A2,D2
.L3:
            bcs.b   .L5
.L4:
            addq.b  #1,D5
            sub.l   A2,D2
            subx.l  D3,D1
.L5:
            subq.w  #1,D0
            bne.b   .L1
            rts
REMSHIFT:
            movea.l D6,A3
            move.l  A2,D1
            moveq   #0,D2
            movea.l D0,A2
            andi.l  #$1F,D0
            beq.b   .L1
            bfextu  D3{0:D0},D2
            lsl.l   D0,D3
            bfextu  D1{0:D0},D6
            lsl.l   D0,D1
            or.l    D6,D3
.L1:
            bsr.w   DIV32
            move.l  A2,D6
            bfextu  D6{16:11},D6
            beq.b   REMDIVDONE
            movea.l D6,A1
            moveq   #0,D1
REMLP32:
            bsr.w   DIV32
            subq.l  #1,A1
            move.l  A1,D6
            bne.b   REMLP32
REMDIVDONE:
            move.l  D2,D1
            move.l  D3,D2
            move.l  D4,D3
            movea.l D5,A2
            move.l  D0,D5
            move.l  A3,D6
            bra.w   REMPOSTRESTORING
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8A08,A0
            bra.w   RsrcPACK_4_2.L7
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8A08,A0
            bra.w   UNPACKXB
sub_408E8A08:
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E8A08(PC,D0.w)
.L1:
            dc.w    .L7-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L6-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L5-sub_408E8A08
.L2:
            add.b   D6,D6
            not.b   D6
.L3:
            moveq   #0,D7
            tst.b   D6
            bmi.b   .L4
            moveq   #$19,D7
.L4:
            bra.w   FINICMPS
.L5:
            btst    #5,D6
            bne.b   .L3
.L6:
            moveq   #4,D7
            bra.w   FINICMPS
.L7:
            btst    #5,D6
            bne.b   .L3
            cmpa.l  A4,A3
            bgt.b   .L8
            blt.b   .L9
            cmp.l   D4,D3
            bhi.b   .L8
            bcs.b   .L9
            cmpa.l  D5,A2
            beq.b   .L6
            bcs.b   .L9
.L8:
            not.b   D6
.L9:
            moveq   #$19,D7
            tst.b   D6
            bpl.w   FINICMPS
            moveq   #0,D7
            bra.w   FINICMPS
sub_408E8A66:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI2OPS,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
.L1:
            moveq   #0,D7
            tst.w   D0
            bne.w   UNPACKXB.L6
            tst.l   D0
            beq.w   COERCE
            bra.w   PACKX
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI2OPS,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            move.l  D6,D1
            clr.w   D1
            rol.l   #6,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            movea.l ($E,A6),A1
            bsr.w   UNPBOP
            bra.b   .L1
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI1OP,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L3
            tst.w   D0
            bne.w   UNPACKXB.L6
            btst    #$11,D0
            bne.w   PACKX
            tst.b   D6
            bpl.w   PACKX
.L2:
            moveq   #1,D0
            bra.w   UNPACKXB.L1
.L3:
            tst.b   D6
            bmi.b   .L2
            move.w  A4,D0
            asr.w   #1,D0
            move    SR,D7
            bcc.b   .L4
            addq.w  #1,D0
.L4:
            addi.w  #$1FFF,D0
            movea.w D0,A4
            movea.l D6,A3
            move.l  D5,D3
            move.l  D4,D2
            add.l   D3,D3
            addx.l  D2,D2
            moveq   #1,D1
            move    D7,CCR
            bcs.b   .L5
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
.L5:
            subq.w  #1,D1
            moveq   #1,D0
            moveq   #0,D4
            move.l  D4,D5
            move.l  #$40000000,D6
            bra.b   .L7
.L6:
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
.L7:
            or.l    D6,D4
            sub.l   D4,D2
            subx.w  D0,D1
            bcc.b   .L8
            add.l   D4,D2
            addx.w  D0,D1
            eor.l   D6,D4
            bra.b   .L9
.L8:
            add.l   D6,D4
.L9:
            lsr.l   #1,D6
            bcc.b   .L6
            move.l  #$80000000,D6
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
            sub.l   D6,D3
            subx.l  D4,D2
            subx.w  D0,D1
            bcc.b   .L10
            add.l   D6,D3
            addx.l  D4,D2
            addx.w  D0,D1
            bra.b   .L11
.L10:
            addq.w  #1,D4
.L11:
            move.l  D3,D7
            or.w    D1,D7
            or.l    D2,D7
            bne.b   .L12
            lsr.w   #1,D0
            roxr.l  #1,D4
            roxr.l  #1,D5
            bra.b   .L17
.L12:
            ror.l   #1,D6
.L13:
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
            or.l    D6,D5
            sub.l   D5,D3
            subx.l  D4,D2
            subx.w  D0,D1
            bcc.b   .L14
            add.l   D5,D3
            addx.l  D4,D2
            addx.w  D0,D1
            eor.l   D6,D5
            bra.b   .L15
.L14:
            add.l   D6,D5
.L15:
            lsr.l   #1,D6
            bcc.b   .L13
            moveq   #0,D7
            addq.w  #1,D5
            lsr.w   #1,D0
            roxr.l  #1,D4
            roxr.l  #1,D5
            subx.l  D5,D3
            subx.l  D4,D2
            subx.w  D7,D1
            bcs.b   .L16
            bset    #$1F,D7
.L16:
            addi.w  #$FF,D7
.L17:
            move.l  A3,D6
            bra.w   COERCE
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI1OP,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L18
            tst.w   D0
            bne.w   UNPACKXB.L6
            bra.w   PACKX
.L18:
            bsr.w   sub_408E8C86
            bgt.b   .L20
.L19:
            bftst   D1{25:2}
            beq.w   COERCEX
            bpl.w   COERCED
            bra.w   COERCES
.L20:
            bsr.w   RNDINT
            tst.l   D4
            bmi.w   PACKX
.L21:
            bfffo   D4{0:0},D0
            beq.b   .L22
            suba.w  D0,A4
            lsl.l   D0,D4
            bfextu  D5{0:D0},D2
            lsl.l   D0,D5
            or.l    D2,D4
            bra.w   PACKX
.L22:
            suba.w  #$20,A4
            exg     D4,D5
            bfffo   D4{0:0},D0
            beq.b   .L23
            bmi.w   PACKX
            suba.w  D0,A4
            lsl.l   D0,D4
            bra.w   PACKX
.L23:
            suba.l  A4,A4
            bra.w   PACKX
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI1OP,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L24
            tst.w   D0
            bne.w   UNPACKXB.L6
            bra.w   PACKX
.L24:
            bsr.b   sub_408E8C86
            bgt.b   .L25
            ori.w   #$6000,D1
            bra.w   .L19
.L25:
            tst.l   D7
            beq.b   .L21
            bset    #$C,D6
            bra.b   .L21
sub_408E8C86:
            move.w  FPState,D1
            bftst   D1{25:2}
            beq.b   sub_408E8C9A
            bmi.b   .L1
            moveq   #$34,D0
            bra.b   sub_408E8C9A.L1
.L1:
            moveq   #$17,D0
            bra.b   sub_408E8C9A.L1
sub_408E8C9A:
            moveq   #$3F,D0
.L1:
            moveq   #0,D7
            addi.w  #$3FFF,D0
            move.w  D0,D2
            sub.l   A4,D0
            bgt.b   .L2
            rts
.L2:
            movea.w D2,A4
            bsr.w   RTSHIFT
            move    #0,CCR
            rts
RNDINT:
            tst.l   D7
            bne.b   .L1
            rts
.L1:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L2
            tst.b   D6
            bpl.b   .L6
            rts
.L2:
            btst    #$D,D1
            beq.b   .L3
            rts
.L3:
            tst.b   D6
            bmi.b   .L6
            rts
.L4:
            add.l   D7,D7
            bcs.b   .L5
            rts
.L5:
            bne.b   .L6
            btst    #0,D5
            bne.b   .L6
            rts
.L6:
            moveq   #0,D0
            addq.l  #1,D5
            addx.l  D0,D4
            rts
sub_408E8CF4:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI2OPS,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
            moveq   #$1A,D7
            move.l  D6,D1
            lsr.l   D7,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            moveq   #0,D7
            move.w  .L1(PC,D1.w),D1
            jmp     sub_408E8CF4(PC,D1.w)
.L1:
            dc.w    .L2-sub_408E8CF4
            dc.w    .L9-sub_408E8CF4
            dc.w    sub_408E8A66-sub_408E8CF4
            dc.w    .L25-sub_408E8CF4
            dc.w    .L20-sub_408E8CF4
            dc.w    .L15-sub_408E8CF4
.L2:
            movea.l ($A,A6),A2
            tst.l   D0
            beq.b   .L3
            tst.w   D0
            beq.b   .L5
            andi.w  #$F800,D5
            bsr.w   sub_408E8052
            bra.b   .L5
.L3:
            move.w  FPState,D1
            btst    #6,D1
            beq.b   .L4
            bsr.w   SCOERCE
            bra.b   .L5
.L4:
            bsr.w   DCOERCE
.L5:
            move.w  A4,D3
            cmpi.w  #$7FFF,D3
            bne.b   .L6
            move.w  #$4400,D3
            bra.b   .L7
.L6:
            tst.w   D3
            bne.b   .L7
            move.w  #$3C01,D3
.L7:
            subi.w  #$3C00,D3
            tst.l   D4
            bmi.b   .L8
            subq.w  #1,D3
.L8:
            lsr.l   #8,D5
            lsr.l   #3,D5
            bfins   D4,D5{0:11}
            lsr.l   #8,D4
            lsr.l   #2,D4
            bfins   D3,D4{0:11}
            add.b   D6,D6
            roxr.l  #1,D4
            move.l  D4,(A2)+
            move.l  D5,(A2)
            jmp     (A0)
.L9:
            movea.l ($A,A6),A2
            tst.l   D0
            beq.b   .L10
            tst.w   D0
            beq.b   .L11
            moveq   #0,D5
            clr.b   D4
            bsr.w   sub_408E8052
            bra.b   .L11
.L10:
            move.w  FPState,D1
            bsr.w   SCOERCE
.L11:
            move.w  A4,D3
            cmpi.w  #$7FFF,D3
            bne.b   .L12
            move.w  #$4080,D3
            bra.b   .L13
.L12:
            tst.w   D3
            bne.b   .L13
            move.w  #$3F81,D3
.L13:
            subi.w  #$3F80,D3
            add.l   D4,D4
            bcs.b   .L14
            subq.w  #1,D3
.L14:
            or.w    D3,D4
            ror.l   #8,D4
            add.b   D6,D6
            roxr.l  #1,D4
            move.l  D4,(A2)
            jmp     (A0)
.L15:
            tst.l   D0
            beq.b   .L18
            btst    #$11,D0
            bne.b   .L19
            tst.b   D0
            bne.b   .L17
.L16:
            bset    #8,D6
            bclr    #$C,D6
.L17:
            moveq   #1,D4
            moveq   #0,D5
            ror.l   #1,D4
            bra.b   .L19
.L18:
            bsr.w   sub_408E8C9A
            ble.b   .L16
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bmi.b   .L16
            tst.b   D6
            bpl.b   .L19
            neg.l   D5
            negx.l  D4
.L19:
            movea.l ($A,A6),A2
            move.l  D4,(A2)+
            move.l  D5,(A2)
            jmp     (A0)
.L20:
            tst.l   D0
            beq.b   .L22
            btst    #$11,D0
            bne.b   .L24
.L21:
            moveq   #1,D5
            bset    #8,D6
            ror.l   #1,D5
            bclr    #$C,D6
            bra.b   .L24
.L22:
            bsr.w   sub_408E8C9A
            ble.b   .L21
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bne.b   .L21
            tst.l   D5
            bpl.b   .L23
            neg.l   D5
            bpl.b   .L21
            tst.b   D6
            bpl.b   .L21
.L23:
            tst.b   D6
            bpl.b   .L24
            neg.l   D5
.L24:
            movea.l ($A,A6),A2
            move.l  D5,(A2)
            jmp     (A0)
.L25:
            tst.l   D0
            beq.b   .L27
            btst    #$11,D0
            bne.b   .L29
.L26:
            move.w  #$8000,D5
            bset    #8,D6
            bclr    #$C,D6
            bra.b   .L29
.L27:
            bsr.w   sub_408E8C9A
            ble.b   .L26
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bne.b   .L26
            cmpi.l  #$8000,D5
            bcs.b   .L28
            bhi.b   .L26
            tst.b   D6
            bpl.b   .L26
.L28:
            tst.b   D6
            bpl.b   .L29
            neg.w   D5
.L29:
            movea.l ($A,A6),A2
            move.w  D5,(A2)
            jmp     (A0)
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI1OP,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            clr.b   D6
            tst.l   D0
            beq.b   .L30
            tst.w   D0
            bne.w   UNPACKXB.L6
            btst    #$11,D0
            beq.w   PACKX
            ori.w   #$880,D6
            movea.w #$7FFF,A4
            moveq   #0,D4
            move.l  D4,D5
            bra.w   PACKX
.L30:
            moveq   #0,D5
            suba.w  #$3FFF,A4
            move.l  A4,D4
            bgt.b   .L32
            blt.b   .L31
            suba.l  A4,A4
            move.l  D5,D4
            bra.w   PACKX
.L31:
            ori.b   #$80,D6
            neg.l   D4
.L32:
            movea.w #$401E,A4
            bfffo   D4{0:0},D0
            lsl.l   D0,D4
            suba.w  D0,A4
            bra.w   PACKX
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     FINI2OPS,A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L33
            tst.w   D0
            bne.w   UNPACKXB.L6
            bra.w   PACKX
.L33:
            movea.l ($E,A6),A2
            adda.w  (A2),A4
            moveq   #0,D7
            bra.w   COERCE
            movem.l D0-D1/A0,-(SP)
            movea.l ($16,SP),A0
            move.w  (A0)+,D0
            btst    #5,($11,SP)
            beq.b   .L34
            addq.w  #2,A0
.L34:
            add.l   D0,D0
            lsr.w   #1,D0
            bset    #$1F,D0
            bclr    #$F,D0
            cmpi.w  #$7FFF,D0
            beq.b   .L38
            move.l  (A0)+,D1
            bpl.b   .L41
.L35:
            moveq   #5,D1
.L36:
            btst    #$10,D0
            beq.b   .L37
            neg.w   D1
.L37:
            movea.l ($12,SP),A0
            move.w  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #$A
.L38:
            move.l  (A0)+,D1
            add.l   D1,D1
            lsr.l   #1,D1
            beq.b   .L40
            btst    #$1E,D1
            beq.b   .L39
            moveq   #2,D1
            bra.b   .L36
.L39:
            moveq   #1,D1
            bra.b   .L36
.L40:
            move.l  (A0),D1
            bne.b   .L39
            moveq   #3,D1
            bra.b   .L36
.L41:
            beq.b   .L44
.L42:
            subq.w  #1,D0
            add.l   D1,D1
            bpl.b   .L42
.L43:
            tst.w   D0
            bpl.b   .L35
            moveq   #6,D1
            bra.b   .L36
.L44:
            subi.w  #$20,D0
            move.l  (A0),D1
            beq.b   .L45
            bpl.b   .L42
            bra.b   .L43
.L45:
            moveq   #4,D1
            bra.b   .L36
            movem.l D0-D1/A0,-(SP)
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            btst    #$B,D0
            bne.b   .L46
            btst    #$D,D0
            bne.b   .L55
            move.l  (A0),D0
            add.l   D0,D0
            beq.b   .L48
            bfextu  D0{0:8},D1
            beq.b   .L49
            cmpi.b  #$FF,D1
            bne.b   .L50
            bftst   D0{8:23}
            beq.b   .L53
            btst    #$17,D0
            bne.b   .L47
            bra.b   .L54
.L46:
            move.l  (A0)+,D0
            or.w    (A0)+,D0
            or.w    (A0),D0
            add.l   D0,D0
            beq.b   .L48
            bfextu  D0{0:11},D1
            beq.b   .L49
            cmpi.w  #$7FF,D1
            bne.b   .L50
            bftst   D0{11:20}
            beq.b   .L53
            btst    #$14,D0
            beq.b   .L54
.L47:
            moveq   #2,D0
            bra.b   .L51
.L48:
            moveq   #4,D0
            bra.b   .L51
.L49:
            moveq   #6,D0
            bra.b   .L51
.L50:
            moveq   #5,D0
.L51:
            movea.l ($12,SP),A0
            roxr.w  #1,D1
            bpl.b   .L52
            neg.w   D0
.L52:
            move.w  D0,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #$A
.L53:
            moveq   #3,D0
            bra.b   .L51
.L54:
            moveq   #1,D0
            bra.b   .L51
.L55:
            move.l  (A0)+,D0
            add.l   D0,D0
            or.l    (A0),D0
            bne.b   .L50
            addx.w  D0,D0
            beq.b   .L48
            bra.b   .L47
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  (A0),FPState
            movea.l (SP)+,A0
            rtd     #6
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  FPState,(A0)
            movea.l (SP)+,A0
            rtd     #6
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.l  (A0),($A4C).w
            movea.l (SP)+,A0
            rtd     #6
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.l  ($A4C).w,(A0)
            movea.l (SP)+,A0
            rtd     #6
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            bchg    #7,(A0)
            movea.l (SP)+,A0
            rtd     #6
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            bclr    #7,(A0)
            movea.l (SP)+,A0
            rtd     #6
            movem.l A0,-(SP)
            movea.l ($E,SP),A0
            bclr    #7,(A0)
            tst.b   ([$A.w,SP])
            bpl.b   .L56
            bset    #7,(A0)
.L56:
            movea.l (SP)+,A0
            rtd     #$A
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  FPState,(A0)
            clr.w   FPState
            movea.l (SP)+,A0
            rtd     #6
            movem.l D0/A0,-(SP)
            movea.l ($E,SP),A0
            move.w  (A0),D0
            btst    D0,FPState
            sne     D0
            neg.b   D0
            move.b  D0,(A0)
            movem.l (SP)+,D0/A0
            rtd     #6
            movem.l D0/D6/A0,-(SP)
            move.w  #$15,D6
            swap    D6
            clr.w   D6
            movea.l ($12,SP),A0
            move.w  (A0),D0
            addq.w  #8,D0
            bset    D0,D6
            move.w  FPState,D0
            bra.b   .L57
            movem.l D0/D6/A0,-(SP)
            movea.l ($12,SP),A0
            move.w  #$19,D6
            swap    D6
            move.w  #$1F00,D6
            and.w   FPState,D6
            move.w  (A0),D0
.L57:
            or.w    D6,D0
            move.w  D0,FPState
            lsr.w   #8,D6
            and.w   D6,D0
            bne.b   .L59
.L58:
            move    D0,CCR
            movem.l (SP)+,D0/D6/A0
            rtd     #6
.L59:
            lea     ($12,SP),A0
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
            bra.b   .L58
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            move.w  (8,A6),D6
            movem.l ($A,A6),A1-A2
            suba.w  #$16,SP
            movea.l SP,A4
            move.w  FPState,D3
            clr.w   FPState
            moveq   #0,D2
            move.w  D6,D5
            andi.w  #$3800,D5
            bne.b   .L60
            move.b  #$20,D2
            and.b   D6,D2
            beq.b   .L60
            move.w  (A2),(2,A2)
            addq.l  #2,A2
.L60:
            swap    D6
            clr.w   D6
            pea     (A2)
            pea     ($C,A4)
            moveq   #$E,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   RsrcPACK_4_2
            tst.w   D5
            bne.b   .L61
            move.l  ($C,A4),(A2)
            move.l  ($10,A4),(4,A2)
            move.w  ($14,A4),(8,A2)
.L61:
            bfextu  ($C,A4){1:15},D1
            or.l    ($E,A4),D1
            or.l    ($12,A4),D1
            sne     D4
            pea     (A1)
            pea     (A4)
            or.b    D2,D0
            move.w  D0,-(SP)
            bsr.w   RsrcPACK_4_2
            tst.b   D2
            beq.b   .L62
            move.l  (4,A4),(2,A4)
            move.l  (8,A4),(6,A4)
.L62:
            pea     (A4)
            pea     ($C,A4)
            move.w  #8,-(SP)
            bsr.w   RsrcPACK_4_2
            bvc.b   .L63
            pea     (A4)
            pea     ($C,A4)
            move.w  #4,-(SP)
            bsr.w   RsrcPACK_4_2
            pea     ($C,A4)
            pea     (A2)
            moveq   #$10,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   RsrcPACK_4_2
            bra.w   .L73
.L63:
            beq.w   .L73
            bcc.b   .L64
            btst    #7,(A2)
            beq.b   .L65
            bra.w   .L75
.L64:
            btst    #7,(A2)
            beq.w   .L75
.L65:
            btst    #$C,D5
            beq.b   .L66
            addq.l  #1,(A2)
            bra.b   .L70
.L66:
            btst    #$B,D5
            beq.b   .L68
            addq.l  #1,(4,A2)
            bcc.b   .L67
            addq.l  #1,(A2)
.L67:
            bra.b   .L70
.L68:
            addq.l  #1,(6,A2)
            bcc.b   .L70
            addq.l  #1,(2,A2)
            bcc.b   .L70
            roxr    (2,A2)
            addq.w  #1,(A2)
            cmpi.w  #$7FFF,(A2)
            beq.b   .L69
            cmpi.w  #$FFFF,(A2)
            bne.b   .L70
.L69:
            bclr    #7,(2,A2)
.L70:
            pea     (A2)
            pea     ($A,A4)
            moveq   #$1C,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   RsrcPACK_4_2
            move.w  ($A,A4),D1
            bpl.b   .L71
            neg.w   D1
.L71:
            cmpi.w  #3,D1
            bne.b   .L72
            ori.w   #$1400,D6
            bra.b   .L73
.L72:
            cmpi.w  #5,D1
            beq.b   .L73
            ori.w   #$1200,D6
.L73:
            lea     ($16,SP),SP
            tst.b   D2
            beq.b   .L74
            move.w  (A2),(-2,A2)
.L74:
            move.w  FPState,D7
            move.w  D3,FPState
            or.w    D7,D6
            bra.w   FINI2OPS
.L75:
            btst    #$C,D5
            beq.b   .L77
            tst.b   D4
            bne.b   .L76
            bchg    #7,(A2)
            addq.l  #1,(A2)
            bra.b   .L70
.L76:
            subq.l  #1,(A2)
            bra.b   .L70
.L77:
            btst    #$B,D5
            beq.b   .L80
            tst.b   D4
            bne.b   .L78
            bchg    #7,(A2)
            addq.w  #1,(6,A2)
            bra.b   .L70
.L78:
            subq.l  #1,(4,A2)
            bcc.b   .L79
            subq.l  #1,(A2)
.L79:
            bra.b   .L70
.L80:
            tst.b   D4
            bne.b   .L81
            bchg    #7,(A2)
            addq.w  #1,(8,A2)
            bra.w   .L70
.L81:
            subq.l  #1,(6,A2)
            bcc.b   .L84
            subq.l  #1,(2,A2)
            bmi.b   .L82
            tst.w   (A2)
            beq.b   .L84
            cmpi.w  #$8000,(A2)
            beq.b   .L84
            addi.w  #$8000,(2,A2)
            bra.b   .L83
.L82:
            bcc.b   .L84
.L83:
            subq.w  #1,(A2)
.L84:
            bra.w   .L70
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  ($3C,A6),D7
            andi.w  #$3820,D7
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            andi.w  #$6000,D3
            move.w  D3,FPState
            movea.l ($42,A6),A3
            lea     (-$10,A6),A0
            move.l  A0,($42,A6)
            move.l  A3,-(SP)
            move.l  A0,-(SP)
            move.w  D7,-(SP)
            addi.w  #$E,(SP)
            bsr.w   RsrcPACK_4_2
            tst.b   D7
            beq.b   .L85
            move.l  (-$C,A6),(-$E,A6)
            move.l  (-8,A6),(-$A,A6)
.L85:
            movea.l ($46,A6),A1
            move.l  (A1),D2
            movea.l ($3E,A6),A1
            move.w  (A0)+,D0
            clr.w   (A1)
            bclr    #$F,D0
            beq.b   .L86
            move.b  #1,(A1)
.L86:
            move.l  (A0)+,D4
            move.l  (A0),D5
            move.b  #1,(4,A1)
            cmpi.w  #$7FFF,D0
            bne.b   .L88
            move.l  D4,D0
            andi.l  #$7FFFFFFF,D0
            bne.b   .L89
            tst.l   D5
            bne.b   .L89
            moveq   #$49,D0
.L87:
            move.b  D0,(5,A1)
            bra.w   sub_408E93FE.L13
.L88:
            tst.l   D4
            bne.b   sub_408E93FE.L3
            tst.l   D5
            bne.b   sub_408E93FE.L3
            moveq   #$30,D0
            bra.b   .L87
.L89:
            bset    #$1E,D4
            bne.b   .L90
            bset    #0,FPState
.L90:
            addq.l  #4,A1
            move.b  #$11,(A1)+
            move.b  #$4E,(A1)+
            bsr.b   sub_408E93FE
            move.l  D5,D4
            bsr.b   sub_408E93FE
            suba.w  #$16,A1
            bra.w   sub_408E93FE.L13
sub_408E93FE:
            moveq   #8,D0
.L1:
            rol.l   #4,D4
            moveq   #$F,D1
            and.b   D4,D1
            ori.b   #$30,D1
            cmpi.b  #$39,D1
            ble.b   .L2
            addq.b  #7,D1
.L2:
            move.b  D1,(A1)+
            subq.w  #1,D0
            bne.b   .L1
            rts
.L3:
            tst.l   D4
            bmi.b   .L5
.L4:
            subq.w  #1,D0
            add.l   D5,D5
            addx.l  D4,D4
            bpl.b   .L4
.L5:
            move.l  D4,D1
            move.w  D0,D1
            subi.w  #$3FFF,D1
            swap    D1
            add.w   D1,D1
            move.l  #$4D104D42,D0
            tst.l   D1
            bpl.b   .L6
            addq.w  #1,D0
.L6:
            move.l  D0,D4
            swap    D4
            mulu.w  D1,D4
            clr.w   D4
            swap    D4
            swap    D1
            move.w  D1,D5
            muls.w  D0,D5
            swap    D5
            ext.l   D5
            add.l   D5,D4
            swap    D0
            muls.w  D1,D0
            add.l   D0,D4
            swap    D4
            move.w  D2,D1
            bmi.b   .L7
            cmpi.w  #$2000,D1
            blt.b   .L8
            move.w  #$2000,D1
            bra.b   .L8
.L7:
            cmpi.w  #$E000,D1
            bgt.b   .L8
            move.w  #$E000,D1
.L8:
            swap    D2
            lsr.w   #8,D2
            tst.b   D2
            bne.b   .L9
            tst.w   D1
            bgt.b   .L9
            moveq   #1,D1
.L9:
            addq.w  #1,D4
            move.w  D1,D5
            tst.b   D2
            beq.b   .L10
            add.w   D4,D5
.L10:
            cmpi.w  #$13,D5
            ble.b   .L11
            move.w  #$13,D5
.L11:
            move.w  D5,(2,A1)
            sub.w   D4,(2,A1)
            tst.w   D5
            bgt.b   .L12
            moveq   #1,D5
.L12:
            move.l  ($42,A6),-(SP)
            move.l  A1,-(SP)
            move.b  D5,(4,A1)
            jsr     sub_408E9936
            cmp.b   (4,A1),D5
            bcs.b   .L9
            neg.w   (2,A1)
.L13:
            move.w  FPState,D0
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            move.w  (-2,A6),FPState
            lsr.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L14
            move.l  (4,A6),(-8,A6)
            swap    D0
            clr.w   D0
            move.l  D0,(-$C,A6)
            pea     (-$C,A6)
            move.l  ($46,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($3E,A6),-(SP)
            move.w  ($3C,A6),-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
.L14:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($E,SP)
            lea     ($E,SP),SP
            move    #0,CCR
            rts
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  ($3C,A6),D7
            andi.w  #$3800,D7
            beq.b   .L18
            cmpi.w  #$1000,D7
            blt.b   .L16
            beq.b   .L15
            move.w  #$6000,D0
            bra.b   .L17
.L15:
            move.w  #$6040,D0
            bra.b   .L17
.L16:
            move.w  #$6060,D0
.L17:
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            and.w   D0,D3
            ori.w   #$80,D3
            bra.b   .L19
.L18:
            move.w  #$6060,D0
            move.w  FPState,D3
            move.w  D3,(-2,A6)
            and.w   D0,D3
.L19:
            move.w  D3,FPState
            movea.l ($3E,A6),A3
            cmpi.w  #0,D7
            beq.b   .L20
            lea     (-$10,A6),A0
            move.l  A0,($3E,A6)
.L20:
            movea.l ($42,A6),A2
            lea     (4,A2),A4
            moveq   #0,D4
            move.l  D4,D5
            move.b  (A4)+,D6
            beq.b   sub_408E95AE.L6
            move.b  (A4),D0
            cmpi.b  #$49,D0
            beq.b   sub_408E95AE.L4
            cmpi.b  #$4E,D0
            bne.b   sub_408E95AE.L5
            move.b  (-1,A4),D2
            addq.l  #1,A4
            subq.b  #1,D2
            moveq   #8,D0
            cmpi.b  #4,D2
            bge.b   .L21
            subq.b  #4,D0
            add.b   D2,D0
.L21:
            bsr.b   sub_408E95AE
            move.l  D5,D4
            moveq   #0,D5
            moveq   #8,D0
            bsr.b   sub_408E95AE
            bra.b   sub_408E95AE.L3
sub_408E95AE:
            rol.l   #4,D5
            subq.b  #1,D2
            bmi.b   .L2
            move.b  (A4)+,D1
            cmpi.b  #$39,D1
            ble.b   .L1
            addi.b  #9,D1
.L1:
            andi.b  #$F,D1
            or.b    D1,D5
.L2:
            subq.w  #1,D0
            bne.b   sub_408E95AE
            rts
.L3:
            bset    #$1E,D4
            move.l  D4,D0
            swap    D0
            andi.b  #$FF,D0
            bne.b   .L4
            ori.w   #$15,D0
            swap    D0
            move.l  D0,D4
.L4:
            move.w  #$7FFF,D0
            bra.b   .L7
.L5:
            cmpi.b  #$30,D0
            bne.b   .L10
.L6:
            moveq   #0,D0
.L7:
            tst.b   (A2)
            beq.b   .L8
            bset    #$F,D0
.L8:
            movea.l ($3E,A6),A0
            move.w  D0,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.b   .L11
.L9:
            move.w  (2,A2),-(SP)
            moveq   #0,D0
            move.b  D6,D0
            subi.w  #$13,D0
            sub.w   D0,(2,A2)
            move.l  ($3E,A6),-(SP)
            move.l  ($42,A6),-(SP)
            jsr     sub_408E96D4
            move.w  (SP)+,(2,A2)
            bra.b   .L11
.L10:
            cmpi.b  #$13,D6
            bhi.b   .L9
            move.l  ($3E,A6),-(SP)
            move.l  ($42,A6),-(SP)
            jsr     sub_408E96D4
.L11:
            cmpi.w  #0,D7
            bgt.b   .L12
            btst    #5,($3D,A6)
            beq.b   .L14
            move.l  (6,A3),(8,A3)
            move.l  (2,A3),(4,A3)
            bra.b   .L14
.L12:
            pea     (-$10,A6)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #$10,(SP)
            bsr.w   RsrcPACK_4_2
            move.w  FPState,D0
            btst    #8,D0
            beq.b   .L13
            andi.w  #$E1FF,D0
            bra.b   .L15
.L13:
            cmpi.w  #$1000,D7
            ble.b   .L15
            bclr    #9,D0
            bra.b   .L15
.L14:
            move.w  FPState,D0
.L15:
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            move.w  (-2,A6),FPState
            lsr.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L16
            move.l  (4,A6),(-8,A6)
            swap    D0
            clr.w   D0
            move.l  D0,(-$C,A6)
            pea     (-$C,A6)
            move.l  ($46,A6),-(SP)
            move.l  ($42,A6),-(SP)
            move.l  A3,-(SP)
            move.w  ($3C,A6),-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
.L16:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($A,SP)
            lea     ($A,SP),SP
            move    #0,CCR
            rts
sub_408E96D4:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            blt.w   StuffIt_PACK_4_2.L9
            bsr.w   SizeExt
            bsr.w   a2b
            bsr.w   StoD_PACK_4_2
            move.l  (-$10,A6),(-$C,A6)
            bsr.w   cXb2a
            movea.l A1,A3
            move.w  #$4F,D6
            move.w  D1,D2
            movea.l A3,A2
.L1:
            subi.w  #$10,D6
            move.w  (A2)+,D0
            bne.b   .L3
            dbra    D2,.L1
.L2:
            addq.w  #1,D6
            lsl.w   #1,D0
.L3:
            bpl.b   .L2
            moveq   #-1,D5
            bsr.w   Roundit_FP020BD
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            add.w   (A0),D7
            addi.w  #$400E,D7
            bsr.b   StuffIt_PACK_4_2
            tst.l   D4
            bmi.b   .L5
.L4:
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L4
.L5:
            movea.l ($3C,A6),A0
            cmpi.w  #$7FFF,D7
            bcc.b   .L7
            asl.w   #1,D7
.L6:
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.w   sub_408E9936.L4
.L7:
            ori.w   #$1400,FPState
            move.w  FPState,D2
            btst    #$E,D2
            bne.b   .L8
            btst    #$D,D2
            beq.b   .L10
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L10
            bra.b   .L9
.L8:
            btst    #$D,D2
            bne.b   .L9
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L10
.L9:
            move.w  #$FFFC,D7
            moveq   #-1,D4
            moveq   #-1,D5
            bra.b   .L6
.L10:
            move.w  #$FFFE,D7
            moveq   #0,D4
            moveq   #0,D5
            bra.b   .L6
StuffIt_PACK_4_2:
            moveq   #0,D4
            moveq   #0,D5
            moveq   #0,D6
            tst.w   D1
            bgt.b   .L1
            move.w  (A3)+,D4
            swap    D4
            rts
.L1:
            move.l  (A3)+,D4
            subq.w  #2,D1
            bgt.b   .L2
            blt.w   .L14
            move.w  (A3)+,D5
            swap    D5
            rts
.L2:
            move.l  (A3)+,D5
            subq.w  #2,D1
            bgt.b   .L3
            blt.w   .L14
            move.w  (A3)+,D6
            swap    D6
            rts
.L3:
            move.l  (A3)+,D6
            rts
.L4:
            move.w  D1,D4
            cmp.w   D3,D1
            bge.b   .L5
            move.w  D3,D4
.L5:
            tst.w   D4
            beq.b   .L10
            lea     (2,A1),A2
            lea     (2,A3),A4
            moveq   #0,D2
.L6:
            addq.w  #1,D2
            cmp.w   D2,D1
            bge.b   .L7
            clr.w   (A2)
.L7:
            cmp.w   D2,D3
            bge.b   .L8
            clr.w   (A4)
.L8:
            cmpm.w  (A4)+,(A2)+
            bne.b   .L10
            cmp.w   D2,D4
            bgt.b   .L6
            bra.b   .L10
.L9:
            bsr.w   SizeExtN
            bsr.w   StoD_PACK_4_2
            bsr.w   Nrmlz10_PACK_4_2
            movea.l A4,A3
            moveq   #4,D6
            cmp.w   (A3),D0
            beq.b   .L4
.L10:
            bhi.b   .L11
            addq.w  #1,D3
            clr.w   -(A3)
            moveq   #5,D6
.L11:
            move.w  D3,D2
            asl.w   #4,D2
            sub.w   D7,D2
            addi.w  #$3FFE,D2
            move.w  D2,-(SP)
            bsr.w   BgnDiv_PACK_4_2
            moveq   #0,D6
            move.w  (A3),D0
            bra.b   .L13
.L12:
            addq.w  #1,D6
            lsl.w   #1,D0
.L13:
            bpl.b   .L12
            move.w  (SP)+,D7
            movea.l D7,A1
            sub.w   D6,D7
            bmi.b   NeedWrd_FP020BD.L2
            addi.w  #$3F,D6
            moveq   #-1,D5
            bsr.w   Roundit_FP020BD
            move.l  A1,D7
            bsr.w   StuffIt_PACK_4_2
.L14:
            tst.l   D4
            bmi.b   .L16
.L15:
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L15
.L16:
            movea.l ($3C,A6),A0
            asl.w   #1,D7
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            bra.w   sub_408E9936.L4
NeedWrd_FP020BD:
            tst.w   D0
            bge.b   .L1
            clr.w   -(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            subi.w  #$10,D7
            addi.w  #$10,D0
.L1:
            rts
.L2:
            move.l  A1,D0
            cmpi.w  #$FFBE,D0
            bpl.b   .L3
            move.w  #$FFBE,D7
            move.w  D7,D0
            sub.w   D6,D7
.L3:
            add.w   D7,D6
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            bsr.b   NeedWrd_FP020BD
            addi.w  #$3F,D6
            move.w  D0,-(SP)
            moveq   #-1,D5
            movea.l A3,A1
            bsr.w   Roundit_FP020BD
            movea.l A1,A3
            move.w  (SP)+,D7
            bsr.w   StuffIt_PACK_4_2
            tst.l   D4
            bmi.b   .L5
.L4:
            tst.w   D7
            ble.b   .L5
            subq.w  #1,D7
            asl.l   #1,D6
            roxl.l  #1,D5
            roxl.l  #1,D4
            bpl.b   .L4
.L5:
            movea.l ($3C,A6),A0
            asl.w   #1,D7
            asl     (A0)
            roxr.w  #1,D7
            move.w  D7,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)
            tst.l   D4
            bmi.b   .L6
            ori.w   #$1200,FPState
.L6:
            bra.w   sub_408E9936.L4
StoD_PACK_4_2:
            moveq   #0,D3
            movea.l (-$10,A6),A3
            subq.l  #2,A3
            clr.w   (A3)+
            movea.l ($38,A6),A0
            movea.l ($3C,A6),A4
            tst.b   (A0)
            beq.b   .L1
            bset    #7,(A4)
            bra.b   .L2
.L1:
            bclr    #7,(A4)
.L2:
            addq.l  #4,A0
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L5
.L3:
            moveq   #$F,D7
            and.b   (A0)+,D7
            movea.l A3,A4
            move.w  D3,D4
.L4:
            move.w  -(A4),D6
            mulu.w  #$A,D6
            add.l   D6,D7
            move.w  D7,(A4)
            clr.w   D7
            swap    D7
            dbra    D4,.L4
            beq.b   .L5
            move.w  D7,-(A4)
            addq.w  #1,D3
.L5:
            dbra    D0,.L3
            rts
sub_408E9936:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            ble.b   .L1
            bsr.w   SizeExt
            bsr.w   XbyA_PACK_4_2
            bra.b   .L2
.L1:
            bsr.w   SizeExtN
            bsr.w   sub_408E9BC2
            bsr.w   DivX_PACK_4_2
            moveq   #0,D5
            bsr.w   Roundit_FP020BD
.L2:
            bsr.b   sub_408E9990
.L3:
            unlk    A6
            movem.l (SP)+,D0-D7/A1-A4
            movea.l (SP)+,A0
            lea     (8,SP),SP
            jmp     (A0)
.L4:
            move.w  FPState,D4
            andi.w  #$60,D4
            beq.b   .L3
            pea     Tbl1
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   RsrcPACK_4_2
            bra.b   .L3
sub_408E9990:
            movea.l (-$C,A6),A1
            clr.l   (A1)
            moveq   #0,D3
            tst.w   D6
            movea.l A1,A2
            bmi.b   .L3
            addq.w  #1,D1
            moveq   #$F,D5
            cmp.w   D5,D6
            bge.b   .L1
            move.w  D6,D5
.L1:
            subq.w  #1,D1
            blt.b   .L2
            move.w  (A3)+,D2
.L2:
            movea.l A1,A2
            add.w   D2,D2
            move.l  D3,D7
            lea     (4,A2),A2
            move.l  -(A2),D0
            dc.w    $C100,$E098,$C100,$E098,$C100,$E098,$C100,$E098
            dc.w    $2480,$51CF,$FFEA,$7000,$C100,$6704,$5283,$2500
            dc.w    $51CD,$FFD2,$0446,$0010,$6CBC,$206E,$0038,$5848
            dc.w    $43E8,$0001,$7A00,$1A10,$6122,$6120,$611E,$611C
            dc.w    $51CB,$FFF6,$3009,$9048,$5300,$6704,$1080,$4E75
.L3:
            movea.l ($38,A6),A0
            addq.w  #4,A0
            move.w  #$130,(A0)
            rts
            moveq   #0,D1
            move.b  (A2)+,D1
            ror.w   #4,D1
            bsr.b   BD1DIGOUT_PACK_4_2
            rol.w   #4,D1
BD1DIGOUT_PACK_4_2:
            tst.w   D6
            bpl.b   .L1
            tst.b   D1
            beq.b   .L3
            moveq   #0,D6
.L1:
            subq.l  #1,D5
            bmi.b   .L2
            ori.b   #$30,D1
            move.b  D1,(A1)
.L2:
            addq.l  #1,A1
            sub.b   D1,D1
.L3:
            rts
XbyA_PACK_4_2:
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D6
            movea.l ($3C,A6),A0
            move.w  (A0)+,D7
            bclr    #$F,D7
            subi.w  #$403F,D7
            add.w   D6,D7
            move.w  (A0)+,D3
            move.w  (A0)+,D4
            move.w  (A0)+,D5
            move.w  (A0)+,D6
            movea.l (-4,A6),A3
            adda.w  #$10,A3
            movea.l (-4,A6),A1
            subq.l  #2,A1
            movea.l (-$C,A6),A4
            subq.l  #2,A4
            move.w  (A1),D0
            move.w  D0,D2
            mulu.w  D6,D2
            move.l  D2,(A3)
            move.w  D0,D2
            mulu.w  D4,D2
            move.l  D2,-(A3)
            clr.w   -(A3)
            lea     (4,A3),A3
            move.w  D0,D2
            mulu.w  D5,D2
            add.l   D2,(A3)
            mulu.w  D3,D0
            move.l  D0,(A4)+
            addx.l  -(A4),-(A3)
            movea.l D1,A2
            subq.w  #1,D1
            bmi.b   .L4
.L1:
            lea     (4,A3),A3
            move.w  -(A1),D0
            move.w  D0,D2
            mulu.w  D6,D2
            add.l   D2,(A3)
            move.w  D0,D2
            mulu.w  D4,D2
            move.l  D2,(A4)+
            addx.l  -(A4),-(A3)
            bcc.b   .L2
            move.w  #1,-(A3)
            bra.b   .L3
.L2:
            clr.w   -(A3)
.L3:
            lea     (4,A3),A3
            move.w  D0,D2
            mulu.w  D5,D2
            add.l   D2,(A3)
            mulu.w  D3,D0
            move.l  D0,(A4)+
            addx.l  -(A4),-(A3)
            dbra    D1,.L1
.L4:
            move.l  A2,D1
            addq.w  #4,D1
            move.w  D1,D6
            addq.w  #1,D6
            asl.w   #4,D6
            add.w   D7,D6
            moveq   #0,D5
Roundit_FP020BD:
            tst.w   D6
            bge.b   .L2
            cmpi.w  #$FFBE,D6
            bpl.b   .L1
            move.w  #$FFBE,D6
.L1:
            clr.w   -(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            blt.b   .L1
.L2:
            bsr.w   RndStk_PACK_4_2
            tst.w   D5
            beq.b   .L8
            move.w  D6,D2
            lsr.w   #4,D2
            lsl.w   #1,D2
            lea     (0,A3,D2.w),A2
            move.w  (A2),D4
            move.w  D6,D3
            andi.w  #$F,D3
            move.w  #$8000,D0
            ror.w   D3,D0
            and.w   D0,D4
            beq.b   .L3
            addq.w  #1,D5
.L3:
            bset    #4,FPState
            move.w  FPState,D2
            move.w  D2,D4
            andi.w  #$E0,D4
            beq.b   .L4
            or.w    D0,(A2)
            bra.b   .L8
.L4:
            btst    #$E,D2
            bne.b   .L10
            btst    #$D,D2
            bne.b   .L11
            cmpi.w  #5,D5
            blt.b   .L8
.L5:
            add.w   D0,(A2)
            bcc.b   .L8
.L6:
            cmpa.l  A2,A3
            beq.b   .L7
            addq.w  #1,-(A2)
            bcs.b   .L6
            bra.b   .L8
.L7:
            move.w  #1,-(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            lea     ($10,A1),A1
.L8:
            tst.w   (A3)
            bne.b   .L9
            lea     (2,A3),A3
            subq.w  #1,D1
            subi.w  #$10,D6
.L9:
            rts
.L10:
            btst    #$D,D2
            bne.b   .L8
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L5
            bra.b   .L8
.L11:
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L5
            bra.b   .L8
RndStk_PACK_4_2:
            clr.w   D5
            move.w  D6,D3
            addq.w  #1,D3
            move.l  D3,D4
            lsr.w   #4,D4
            cmp.w   D1,D4
            ble.b   .L1
            rts
.L1:
            andi.w  #$F,D3
            move.w  #$8000,D0
            ror.w   D3,D0
            move.w  D4,D2
            lsl.w   #1,D2
            lea     (0,A3,D2.w),A2
            and.w   (A2),D0
            beq.b   .L2
            moveq   #4,D5
.L2:
            move.w  #$7FFF,D0
            lsr.w   D3,D0
            and.w   (A2)+,D0
            beq.b   .L5
.L3:
            addq.w  #2,D5
            rts
.L4:
            tst.w   (A2)+
            bne.b   .L3
.L5:
            addq.w  #1,D4
            cmp.w   D1,D4
            ble.b   .L4
            rts
sub_408E9BC2:
            movea.l ($3C,A6),A0
            move.w  (A0)+,D6
            bclr    #$F,D6
            subi.w  #$400C,D6
            movea.l (-$10,A6),A3
            suba.w  #$34,A3
            move.l  (A0)+,(A3)
            move.l  (A0)+,(4,A3)
            moveq   #3,D3
Nrmlz10_PACK_4_2:
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            sub.w   (A0),D7
            move.w  D1,D5
            asl.w   #1,D5
            move.w  (A1),D0
            bmi.b   .L3
.L1:
            subq.w  #1,D7
            move.w  D1,D4
            lea     (2,A1,D5.w),A0
            move    #0,CCR
.L2:
            roxl    -(A0)
            dbra    D4,.L2
            bpl.b   .L1
            move.w  (A1),D0
.L3:
            rts
DivX_PACK_4_2:
            sub.w   D7,D6
            ble.w   BgnDiv_PACK_4_2.L6
            move.w  D6,D4
            asr.w   #4,D6
            andi.w  #$F,D4
            beq.b   .L2
            addq.w  #1,D3
            clr.w   -(A3)
            subq.w  #1,D4
.L1:
            asl     (8,A3)
            roxl    (6,A3)
            roxl    (4,A3)
            roxl    (2,A3)
            roxl    (A3)
            dbra    D4,.L1
            bra.b   BgnDiv_PACK_4_2
.L2:
            cmp.w   (A3),D0
            bhi.b   .L3
            addq.w  #1,D3
            clr.w   -(A3)
            bra.b   BgnDiv_PACK_4_2
.L3:
            subq.w  #1,D6
BgnDiv_PACK_4_2:
            bsr.b   PadIt
            movea.l A3,A0
.L1:
            move.l  (A0),D2
            divu.w  D0,D2
            bvs.w   divOver
            swap    D2
            move.l  D2,(A0)
            swap    D2
            lea     (2,A0),A0
            cmpi.w  #2,D5
            blt.b   .L4
            beq.b   .L2
            move.w  D5,D7
            bclr    #1,D7
            bsr.b   MandS
            moveq   #0,D4
            move.w  -(A4),D1
            subx.w  D4,D1
            move.w  D1,(A4)
            negx.w  D7
            tst.w   D7
            bne.b   .L2
            bsr.b   DecrIt
.L2:
            move.w  D5,D7
            btst    #1,D7
            bne.b   .L3
            subq.w  #2,D7
.L3:
            bsr.b   MandS
            negx.w  D7
            tst.w   D7
            bne.b   .L4
            bsr.b   DecrIt
.L4:
            dbra    D6,.L1
.L5:
            suba.l  A3,A0
            move.w  A0,D6
            move.w  D3,D1
            asl.w   #3,D6
            subq.w  #3,D6
            rts
.L6:
            movea.l A3,A0
            clr.w   -(A3)
            bra.b   .L5
PadIt:
            move.w  D1,D7
            add.w   D6,D7
            addq.w  #1,D7
            sub.w   D3,D7
            ble.b   .L2
            move.w  D3,D2
            asl.w   #1,D2
            lea     (2,A3,D2.w),A2
            add.w   D7,D3
            asr.w   #1,D7
.L1:
            clr.l   (A2)+
            dbra    D7,.L1
.L2:
            rts
MandS:
            lea     (2,A1,D7.w),A2
            lea     (2,A0,D7.w),A4
            subq.w  #2,D7
            asr.w   #2,D7
            move    #0,CCR
.L1:
            move.l  -(A2),D4
            mulu.w  D2,D4
            move.l  -(A4),D1
            subx.l  D4,D1
            move.l  D1,(A4)
            dbra    D7,.L1
            rts
DecrIt:
            subq.w  #1,(-2,A0)
            move.l  D5,D1
            lea     (2,A1,D1.w),A2
            lea     (2,A0,D1.w),A4
            asr.w   #1,D1
            move    #0,CCR
.L1:
            addx.w  -(A2),-(A4)
            dbra    D1,.L1
            bcc.b   DecrIt
            rts
divOver:
            clr.w   (A0)+
            move.w  D5,D7
            beq.b   DecrIt
            lea     (2,A1,D7.w),A2
            lea     (0,A0,D7.w),A4
            asr.w   #1,D7
            subq.w  #1,D7
            move    #0,CCR
.L1:
            subx.w  -(A2),-(A4)
            dbra    D7,.L1
            bsr.b   DecrIt
            bra.w   BgnDiv_PACK_4_2.L4
SizeExtN:
            neg.w   D0
            cmpi.w  #5208,D0
            bcs.b   allct
            move.w  #$1457,D0
            move.w  D0,D1
            neg.w   D1
            move.w  D1,(A0)
            bra.b   allct
SizeExt:
            cmpi.w  #$1390,D0
            bcs.b   allct
            move.w  #$138F,D0
            move.w  D0,(A0)
allct:
            moveq   #0,D4
            move.w  D0,D4
            addi.w  #$20F,D4
            andi.b  #$F8,D4
            cmpi.w  #$C40,D4
            bcs.b   .L1
            move.w  #$C40,D4
.L1:
            move.w  D4,D5
            asr.w   #2,D5
            move.l  D0,D1
            _StackSpace
            cmp.l   D4,D0
            bpl.b   .L2
            moveq   #$1C,D0
            _SysError
.L2:
            move.l  D1,D0
            movea.l (SP)+,A1
            suba.w  D4,SP
            move.l  A1,-(SP)
            lea     (-$28,A6),A1
            move.l  A1,(-4,A6)
            suba.w  D4,A1
            move.l  A1,(-$10,A6)
            adda.w  D5,A1
            move.l  A1,(-$C,A6)
            adda.w  D5,A1
            move.l  A1,(-8,A6)
            movea.l (-4,A6),A1
            moveq   #0,D2
            move.w  D0,D2
            divu.w  #$15,D2
            move.w  D2,D0
            swap    D2
            cmpi.w  #7,D2
            blt.b   Frst7
            cmpi.w  #$E,D2
            bge.b   Third7
            moveq   #1,D1
            lea     Tbl2,A2
            subq.w  #7,D2
            asl.w   #2,D2
            move.l  (0,A2,D2.w),-(A1)
            bra.b   GotTen2
Third7:
            moveq   #2,D1
            lea     Tbl3,A2
            subi.w  #$E,D2
            mulu.w  #6,D2
            move.l  (2,A2,D2.w),-(A1)
            bra.b   GotTen
Frst7:
            moveq   #0,D1
            lea     Tbl1,A2
            asl.w   #1,D2
GotTen:
            move.w  (0,A2,D2.w),-(A1)
GotTen2:
            tst.w   D0
            bne.b   MakeTen
            rts
MakeTen:
            bsr.b   a2c
            moveq   #3,D2
            movea.l (-8,A6),A2
            subq.l  #4,A2
            move.l  #$4D6E2EF5,(A2)
            move.l  #$1B1AE,-(A2)
            bra.b   BigLoop
DoItAgn:
            bsr.b   a2c
notOdd:
            bsr.b   bXb2b
BigLoop:
            asr.w   #1,D0
            bcc.b   notOdd
            bsr.b   cXb2a
            tst.w   D0
            bgt.b   DoItAgn
            rts
cXb2a:
            move.w  D2,D1
            add.w   D3,D1
            addq.w  #1,D1
            move.w  D3,D7
            addq.w  #1,D7
            lsr.w   #1,D7
            movea.l (-4,A6),A1
.L1:
            clr.l   -(A1)
            dbra    D7,.L1
            movea.l (-4,A6),A4
            subq.l  #2,A4
            movea.l (-8,A6),A2
            subq.l  #2,A2
            move.w  D2,D5
            bra.b   .L3
.L2:
            clr.w   -(A1)
            subq.l  #2,A2
            subq.l  #2,A4
.L3:
            movea.l A4,A1
            movea.l (-$C,A6),A3
            move.w  D3,D6
.L4:
            move.w  -(A3),D7
            mulu.w  (A2),D7
            subq.w  #2,A1
            add.l   D7,(A1)
            bcc.b   .L6
            movea.l A1,A0
.L5:
            addq.l  #1,-(A0)
            bcs.b   .L5
.L6:
            dbra    D6,.L4
            dbra    D5,.L2
            tst.w   (A1)
            bne.b   .L7
            lea     (2,A1),A1
            subq.w  #1,D1
.L7:
            rts
a2c:
            move.w  D1,D3
            movea.l (-4,A6),A1
            movea.l (-$C,A6),A3
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A3)
            dbra    D1,.L1
            rts
bXb2b:
            move.w  D2,D1
            move.w  D1,D7
            asl.w   #1,D1
            addq.w  #1,D1
            movea.l (-4,A6),A1
.L1:
            clr.l   -(A1)
            dbra    D7,.L1
            move.w  D2,D5
            subq.w  #1,D5
            bmi.b   doSqrs
            movea.l (-4,A6),A4
            subq.l  #4,A4
            movea.l (-8,A6),A2
            subq.l  #2,A2
            bra.b   .L3
.L2:
            subq.w  #2,A2
            subq.w  #4,A4
.L3:
            movea.l A4,A1
            movea.l A2,A3
            move.w  D5,D6
.L4:
            move.w  -(A3),D7
            mulu.w  (A2),D7
            subq.w  #2,A1
            add.l   D7,(A1)
            bcc.b   .L6
            movea.l A1,A0
.L5:
            addq.l  #1,-(A1)
            bcs.b   .L5
            movea.l A0,A1
.L6:
            dbra    D6,.L4
            dbra    D5,.L2
            movea.l (-4,A6),A1
            move    #0,CCR
            move.w  D1,D7
.L7:
            roxl    -(A1)
            dbra    D7,.L7
doSqrs:
            movea.l (-4,A6),A1
            movea.l (-8,A6),A2
.L9:
            move.w  -(A2),D7
            mulu.w  D7,D7
            add.l   D7,-(A1)
            bcc.b   .L11
            movea.l A1,A0
.L10:
            addq.l  #1,-(A1)
            bcs.b   .L10
            movea.l A0,A1
.L11:
            dbra    D2,.L9
            tst.w   (A1)
            bne.b   .L12
            lea     (2,A1),A1
            subq.w  #1,D1
.L12:
            tst.w   D0
            bne.b   a2b
            rts
a2b:
            move.w  D1,D2
            movea.l (-4,A6),A1
            movea.l (-8,A6),A2
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A2)
            dbra    D1,.L1
            rts
Tbl1:
            dc.w    $0001,$0005,$0019,$007D,$0271,$0C35,$3D09
Tbl2:
            dc.w    $0001,$312D,$0005,$F5E1,$001D,$CD65,$0095,$02F9
            dc.w    $02E9,$0EDD,$0E8D,$4A51,$48C2,$7395
Tbl3:
            dc.w    $0001,$6BCC,$41E9,$0007,$1AFD,$498D,$0023,$86F2
            dc.w    $6FC1,$00B1,$A2BC,$2EC5,$0378,$2DAC,$E9D9,$1158
            dc.w    $E460,$913D,$56BC,$75E2,$D631
RsrcEntryPACK_5_2:
            dc.b    $08,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 5 (4660 bytes) - Combo mask
            dc.l    RsrcEntryPACK_4_2-BaseOfROM     ; Next entry
            dc.l    RsrcPACK_5_2-BaseOfROM          ; Data
            dc.b    'PACK'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'ter, Inc. 19'
            dc.l    $C0A00000,$00001240,$000001F4   ; Block header
RsrcPACK_5_2:
            link.w  A6,#-$44
            movem.l D0-D7/A0-A4,-(SP)
            moveq   #0,D3
            movea.l ($15AC).w,A3
            lea     (4,A6),A2
            lea     (8,A6),A0
            move.w  (A0)+,D3
            bpl.w   sub_408EA016.L2
            movea.l (A0)+,A4
            move.l  (A0),D4
            btst    #$E,D3
            bne.b   .L4
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
            beq.b   sub_408EA016.L4
            tst.b   D3
            bpl.b   .L3
.L2:
            movea.l D4,A0
            lea     (-$38,A6),A1
            move.l  A1,D4
            move.w  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (8,A0),(A1)
.L3:
            movea.l D4,A0
            bsr.b   sub_408EA016
            move.w  D0,D2
            bra.b   sub_408EA016.L4
.L4:
            addq.l  #4,A0
            move.l  (A0),D5
            move.l  (A2),(A0)
            move.w  #$E,(A2)
            tst.b   D3
            bpl.b   .L3
            addq.w  #2,A4
            movea.l D5,A0
            lea     (-$42,A6),A1
            move.l  A1,D5
            move.w  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (8,A0),(A1)
            bra.b   .L2
sub_408EA016:
            pea     (A0)
            pea     (-4,A6)
            bsr.w   ELCLASSX
            move.w  (-4,A6),D0
            bpl.b   .L1
            neg.w   D0
            ori.w   #$8000,D0
.L1:
            rts
.L2:
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
.L4:
            movea.l D5,A0
            bsr.b   sub_408EA016
            move.w  D0,D1
            move.w  FPState,(-2,A6)
            clr.w   FPState
            subq.b  #3,D2
            bge.b   .L5
            movea.l D5,A0
            movea.l A4,A1
            bsr.b   sub_408EA0AA
            move.l  D4,-(SP)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            bra.b   .L6
.L5:
            subq.b  #3,D1
            bge.b   .L7
            move.l  D5,-(SP)
            pea     (A4)
            move.w  #$E,-(SP)
            jsr     (A3)
.L6:
            bra.w   sub_408EA3E6.L15
.L7:
            move.w  D3,D0
            andi.w  #$3E,D0
            move.w  .L8(PC,D0.w),D0
            jmp     .L7(PC,D0.w)
.L8:
            dc.w    sub_408EA296.L3-.L7
            dc.w    sub_408EA296.L3-.L7
            dc.w    sub_408EA296.L3-.L7
            dc.w    sub_408EA296.L3-.L7
            dc.w    sub_408EA3E6.L17-.L7
            dc.w    sub_408EA3E6.L17-.L7
            dc.w    sub_408EA560.L1-.L7
            dc.w    sub_408EA560.L1-.L7
            dc.w    sub_408EA62A.L2-.L7
            dc.w    sub_408EA792.L1-.L7
            dc.w    sub_408EA828.L8-.L7
            dc.w    sub_408EA828.L17-.L7
            dc.w    sub_408EA828.L33-.L7
            dc.w    sub_408EA828.L40-.L7
            dc.w    sub_408EAB6A.L2-.L7
            dc.w    sub_408EAC48.L3-.L7
            dc.w    sub_408EAD12.L5-.L7
sub_408EA0AA:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0),(A1)
            subq.l  #8,A1
            rts
sub_408EA0B4:
            move.w  (A1)+,D0
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.w  (8,A1),(8,A0)
.L1:
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
            bgt.b   .L1
            addq.l  #8,A1
            addq.l  #2,A1
            rts
sub_408EA0E4:
            moveq   #1,D0
            bra.b   sub_408EA0F0.L1
sub_408EA0E8:
            moveq   #2,D0
            bra.b   sub_408EA0F0.L1
sub_408EA0EC:
            moveq   #0,D0
            bra.b   sub_408EA0F0.L1
sub_408EA0F0:
            moveq   #4,D0
.L1:
            bclr    D0,FPState
            rts
sub_408EA0F8:
            moveq   #2,D0
            bra.b   sub_408EA108.L1
sub_408EA0FC:
            moveq   #1,D0
            bra.b   sub_408EA108.L1
sub_408EA100:
            moveq   #3,D0
            bra.b   sub_408EA108.L1
sub_408EA104:
            moveq   #0,D0
            bra.b   sub_408EA108.L1
sub_408EA108:
            moveq   #4,D0
.L1:
            bset    D0,FPState
            rts
sub_408EA110:
            moveq   #3,D0
            bra.b   sub_408EA120.L1
sub_408EA114:
            moveq   #1,D0
            bra.b   sub_408EA120.L1
sub_408EA118:
            moveq   #2,D0
            bra.b   sub_408EA120.L1
sub_408EA11C:
            moveq   #0,D0
            bra.b   sub_408EA120.L1
sub_408EA120:
            moveq   #4,D0
.L1:
            btst    D0,FPState
            rts
sub_408EA128:
            move.w  #$7FFF,(-6,A6)
            lea     (-$1A,A6),A2
            move.l  (6,A1),-(A2)
            move.l  (2,A1),-(A2)
            move.w  (A1),-(A2)
            bclr    #7,(A2)
            bsr.b   sub_408EA186
            bge.b   .L2
            pea     sub_408EAD12.L18
            pea     (A2)
            move.w  #2,-(SP)
            jsr     (A3)
            tst.b   (A1)
            bpl.b   .L1
            neg.w   (-6,A6)
.L1:
            bsr.b   sub_408EA178
            bsr.b   sub_408EA186
            bge.b   .L2
            pea     sub_408EAD12.L18
            bra.b   .L3
.L2:
            pea     (A2)
.L3:
            pea     (-6,A6)
            move.w  #$2010,-(SP)
            jsr     (A3)
            tst.b   (A1)
            bpl.b   sub_408EA178
            neg.w   (-6,A6)
sub_408EA178:
            pea     (-6,A6)
            pea     (A0)
            move.w  #$18,-(SP)
            jsr     (A3)
            rts
sub_408EA186:
            pea     (-$24,A6)
            pea     sub_408EAD12.L18
            move.w  #8,-(SP)
            jsr     (A3)
            rts
sub_408EA196:
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
sub_408EA258:
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
sub_408EA296:
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
            bne.b   .L2
.L1:
            move    D0,CCR
            movem.l (SP)+,D0/D6/A0
            rtd     #4
.L2:
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
            bra.b   .L1
.L3:
            subq.b  #1,D1
            bpl.b   .L5
            tst.w   D1
            bpl.w   sub_408EA3E6.L10
.L4:
            moveq   #$24,D0
            bra.w   sub_408EA3E6.L14
.L5:
            btst    #2,D3
            bne.b   .L6
            tst.b   D1
            beq.b   .L7
            tst.w   D1
            bmi.b   .L4
            bra.b   .L9
.L6:
            tst.b   D1
            beq.w   sub_408EA3E6.L15
            pea     (A4)
            pea     sub_408EAD12.L14
            move.w  #8,-(SP)
            jsr     (A3)
            bhi.b   .L4
            bcs.b   .L8
.L7:
            bra.w   sub_408EA3E6.L11
.L8:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L13
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            pea     sub_408EAD12.L30
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            ble.b   .L9
            pea     (A4)
            pea     sub_408EAD12.L29
            move.w  #8,-(SP)
            jsr     (A3)
            bls.b   .L9
            movea.l A1,A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            bsr.w   sub_408EA3E6
            bra.b   .L11
.L9:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            bsr.w   sub_408EA196
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
            pea     sub_408EAD12.L29
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            ble.b   .L10
            pea     sub_408EAD12.L13
            pea     (-$10,A6)
            clr.w   -(SP)
            jsr     (A3)
            subq.w  #1,(A4)
.L10:
            pea     sub_408EAD12.L13
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            bsr.b   sub_408EA3E6
            pea     (-$10,A6)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.L11:
            btst    #1,D3
            bne.b   .L12
            pea     sub_408EAD12.L31
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            move.l  (2,A4),D0
            or.l    (6,A4),D0
            beq.b   .L12
            bsr.w   sub_408EA108
.L12:
            bra.w   sub_408EA3E6.L15
sub_408EA3E6:
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
            beq.b   .L3
            pea     sub_408EAD12.L31
            bsr.w   sub_408EA0FC
            bra.b   .L4
.L3:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L17
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
            bsr.w   sub_408EA0AA
            move.w  #4,-(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     sub_408EAD12.L9,A1
            lea     (-$1A,A6),A2
            bsr.w   sub_408EA0B4
            pea     (-$24,A6)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$24,A6),A0
            lea     sub_408EAD12.L10,A1
            lea     (-$1A,A6),A2
            bsr.w   sub_408EA0B4
            bsr.w   sub_408EA0E4
            pea     (-$24,A6)
.L4:
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA108
            rts
.L5:
            lea     sub_408EAD12.L15,A0
            bra.b   .L13
.L6:
            lea     sub_408EAD12.L16,A0
            bra.b   .L13
.L7:
            lea     sub_408EAD12.L13,A0
            bra.b   .L13
.L8:
            lea     sub_408EAD12.L14,A0
            bra.b   .L13
.L9:
            bsr.w   sub_408EA100
.L10:
            lea     sub_408EAD12.L19,A0
            bra.b   .L13
.L11:
            bsr.w   sub_408EA100
.L12:
            lea     sub_408EAD12.L20,A0
.L13:
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            bra.b   .L15
.L14:
            ori.l   #$7FFF4000,D0
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.w   (A4)
            subq.l  #8,A4
            bsr.w   sub_408EA104
.L15:
            tst.b   D3
            bpl.b   .L16
            move.w  (A4),(-2,A4)
.L16:
            pea     (-2,A6)
            bsr.w   sub_408EA296
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            adda.w  (SP),SP
            rts
.L17:
            subq.b  #1,D1
            beq.b   .L7
            bgt.b   .L18
            tst.w   D1
            bmi.b   .L5
            bra.b   .L15
.L18:
            btst    #1,D3
            beq.b   .L19
            bsr.b   sub_408EA53E
            bra.b   .L20
.L19:
            bsr.b   sub_408EA560
            bsr.w   sub_408EA118
            beq.b   .L20
            bsr.w   sub_408EA108
            tst.w   D1
            bpl.b   .L10
            bsr.w   sub_408EA0E8
            bsr.w   sub_408EA0FC
            bra.w   .L5
.L20:
            bsr.w   sub_408EA62A
            pea     sub_408EAD12.L13
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA128
            tst.w   (2,A4)
            bmi.b   .L15
            bfextu  (A4){1:15},D0
            bne.b   .L15
            bsr.w   sub_408EA120
            beq.b   .L15
            bsr.w   sub_408EA0FC
            bra.b   .L15
sub_408EA53E:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA0F0
            pea     (A1)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            rts
sub_408EA560:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L31
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            pea     (A4)
            pea     (A1)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bra.w   sub_408EA0F0
.L1:
            subq.b  #1,D1
            bgt.b   .L3
            beq.b   .L2
            tst.w   D1
            bmi.w   sub_408EA3E6.L8
.L2:
            bra.w   sub_408EA3E6.L15
.L3:
            subq.b  #1,D1
            btst    #1,D3
            beq.b   .L6
            tst.b   D1
            beq.b   .L5
            pea     sub_408EAD12.L31
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.L4:
            bsr.w   sub_408EA0FC
            bsr.w   sub_408EA108
            bra.b   .L8
.L5:
            bsr.w   sub_408EA53E
            bra.b   .L7
.L6:
            tst.b   D1
            bne.b   .L4
            bsr.b   sub_408EA560
            bsr.w   sub_408EA118
            beq.b   .L7
            bsr.w   sub_408EA108
            tst.w   D1
            bpl.w   sub_408EA3E6.L10
            bsr.w   sub_408EA0E8
            bra.w   sub_408EA3E6.L8
.L7:
            bsr.b   sub_408EA62A
            move.l  (-$E,A6),D0
            or.l    (-$A,A6),D0
            beq.b   .L8
            pea     sub_408EAD12.L13
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA128
            pea     sub_408EAD12.L13
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA0E4
.L8:
            bra.w   sub_408EA3E6.L15
sub_408EA62A:
            move.l  (2,A4),D0
            or.l    (6,A4),D0
            bne.b   .L1
            rts
.L1:
            lea     (-$24,A6),A1
            movea.l A4,A0
            bsr.w   sub_408EA0AA
            pea     (A1)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$1A,A6),A0
            lea     sub_408EAD12.L11,A1
            lea     (-$24,A6),A2
            bsr.w   sub_408EA0B4
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            lea     (-$1A,A6),A0
            lea     sub_408EAD12.L12,A1
            lea     (-$24,A6),A2
            bsr.w   sub_408EA0B4
            pea     (A4)
            pea     (-$1A,A6)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     sub_408EAD12.L17
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA108
            bra.w   sub_408EA0E4
.L2:
            movea.l D4,A0
            move.w  (A0),D2
            beq.w   sub_408EA3E6.L7
            subq.b  #1,D1
            bgt.b   .L5
            asr.w   #1,D2
            bcs.b   .L3
            bclr    #7,(A4)
.L3:
            addx.w  D2,D2
            bpl.w   sub_408EA3E6.L15
            tst.b   D1
            bpl.b   .L4
            tst.b   (A4)
            bpl.w   sub_408EA3E6.L5
            bra.w   sub_408EA3E6.L6
.L4:
            tst.b   (A4)
            bpl.w   sub_408EA3E6.L9
            bra.w   sub_408EA3E6.L11
.L5:
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            bhi.b   .L7
            bsr.b   sub_408EA70C
            bra.w   sub_408EA3E6.L15
.L7:
            move.w  (A4),-(SP)
            bclr    #7,(A4)
            move.l  D4,-(SP)
            pea     (-$10,A6)
            move.l  (SP),D4
            bsr.w   sub_408EA258
            bsr.w   sub_408EA792
            move.w  (SP)+,D0
            bpl.b   .L8
            asr.w   #1,D2
            bcc.b   .L8
            bset    #7,(A4)
.L8:
            bra.w   sub_408EA3E6.L15
sub_408EA70C:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   sub_408EA0AA
            bsr.b   sub_408EA766
            tst.w   D2
            bmi.b   .L2
.L1:
            movea.l A1,A0
            movea.l A4,A1
            bra.w   sub_408EA0AA
.L2:
            lea     sub_408EAD12.L13,A0
            lea     (A4),A1
            bsr.w   sub_408EA0AA
            bsr.w   sub_408EA114
            bne.b   .L3
            bsr.w   sub_408EA118
            bne.b   .L3
            pea     (-$10,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            rts
.L3:
            bsr.w   sub_408EA0E8
            bsr.w   sub_408EA0E4
            pea     (-$1A,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            move.w  D2,D0
            bpl.b   .L4
            neg.w   D0
.L4:
            bsr.b   sub_408EA766
            bra.b   .L1
sub_408EA766:
            lea     sub_408EAD12.L13,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            bra.b   .L2
.L1:
            pea     (A4)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
.L2:
            lsr.w   #1,D0
            bcc.b   .L3
            pea     (A4)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
.L3:
            tst.w   D0
            bne.b   .L1
            rts
sub_408EA792:
            movea.l A4,A0
            lea     (-$1A,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bsr.w   RsrcPACK_5_2
            movea.l A1,A0
            movea.l A4,A1
            bra.w   sub_408EA0AA
.L1:
            tst.w   D1
            bmi.b   .L4
            bsr.b   sub_408EA828
            bra.w   sub_408EA3E6.L15
.L2:
            addq.l  #4,SP
.L3:
            bsr.w   sub_408EA0F0
            moveq   #$25,D0
            bra.w   sub_408EA3E6.L14
.L4:
            tst.b   D2
            beq.b   .L3
            movea.l D4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA120
            bne.b   .L3
            pea     sub_408EAD12.L17
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$14,-(SP)
            jsr     (A3)
            move.w  FPState,(-6,A6)
            bsr.w   sub_408EA0F0
            bclr    #7,(A4)
            bsr.b   sub_408EA828
            btst    #4,(-6,A6)
            beq.b   .L5
            bchg    #7,(A4)
.L5:
            bra.w   sub_408EA3E6.L15
sub_408EA828:
            subq.b  #1,D1
            bne.b   .L3
            subq.b  #1,D2
            beq.b   sub_408EA792.L2
            tst.w   D2
            bpl.b   .L1
            bsr.w   sub_408EA100
            lea     sub_408EAD12.L19,A0
            bra.b   .L2
.L1:
            lea     sub_408EAD12.L15,A0
.L2:
            movea.l A4,A1
            bra.w   sub_408EA0AA
.L3:
            bpl.b   .L4
            subq.b  #1,D2
            bne.b   .L5
            bra.w   sub_408EA792.L2
.L4:
            subq.b  #1,D2
            bpl.b   .L5
            pea     sub_408EAD12.L13
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.w   sub_408EA792.L2
.L5:
            move.w  D2,D6
            move.l  D4,-(SP)
            pea     (-4,A6)
            move.w  #$2010,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA11C
            sne     D7
            bsr.w   sub_408EA0EC
            bsr.w   sub_408EA120
            sne     D1
            or.b    D1,D7
            bne.b   .L7
            move.w  (-4,A6),D2
            move.w  D2,D0
            bpl.b   .L6
            neg.w   D0
.L6:
            cmpi.w  #$FF,D0
            ble.w   sub_408EA70C
.L7:
            bsr.w   sub_408EA0F0
            bsr.w   sub_408EA792
            tst.b   D6
            bmi.w   sub_408EA0F0
            rts
.L8:
            pea     sub_408EAD12.L14
            move.l  D5,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            blt.w   .L16
            bgt.b   .L12
            subq.b  #1,D2
            bne.b   .L10
.L9:
            bra.w   sub_408EA3E6.L7
.L10:
            movea.l D4,A0
            tst.b   (A0)
            bmi.w   sub_408EA3E6.L9
.L11:
            bra.w   sub_408EA3E6.L5
.L12:
            subq.b  #1,D2
            beq.b   .L9
            bgt.b   .L13
            subq.b  #1,D1
            beq.b   .L16
            eor.w   D2,D1
            bmi.b   .L11
            bra.w   sub_408EA3E6.L10
.L13:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   sub_408EA0AA
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .L14
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #$A,-(SP)
            bra.b   .L15
.L14:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            move.w  #8,-(SP)
.L15:
            bsr.w   sub_408EA0E4
            bsr.w   RsrcPACK_5_2
            movea.l A1,A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            bra.w   sub_408EA3E6.L15
.L16:
            moveq   #$26,D0
            bra.w   sub_408EA3E6.L14
.L17:
            pea     sub_408EAD12.L14
            move.l  D5,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            blt.b   .L16
            bne.b   .L19
            subq.b  #1,D2
            beq.b   .L20
            tst.w   D2
            bpl.w   sub_408EA3E6.L9
.L18:
            bra.w   sub_408EA3E6.L8
.L19:
            subq.b  #1,D2
            bne.b   .L21
.L20:
            bra.w   sub_408EA3E6.L5
.L21:
            subq.b  #1,D1
            bgt.b   .L24
            blt.b   .L23
.L22:
            movea.l A4,A1
            movea.l D4,A0
            bsr.w   sub_408EA0AA
            bra.w   sub_408EA3E6.L15
.L23:
            tst.w   D2
            bpl.b   .L20
            pea     sub_408EAD12.L14
            move.l  D4,-(SP)
            move.w  #8,-(SP)
            jsr     (A3)
            beq.b   .L18
            bgt.w   sub_408EA3E6.L6
            bra.w   sub_408EA3E6.L12
.L24:
            tst.b   D2
            bpl.b   .L25
            eor.w   D2,D1
            bmi.b   .L22
            movea.l D5,A0
            lea     (-$1A,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            movea.l A4,A1
            lea     sub_408EAD12.L13,A0
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            bra.w   sub_408EA3E6.L15
.L25:
            lea     (-$1A,A6),A1
            movea.l D5,A0
            bsr.w   sub_408EA0AA
            move.w  (A1),D0
            bclr    #$F,D0
            cmpi.w  #$3F7F,D0
            blt.b   .L27
            pea     (A1)
            move.w  #6,-(SP)
            bsr.w   RsrcPACK_5_2
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            cmpi.w  #$4007,(A1)
            blt.b   .L26
            movea.l D5,A0
            cmpi.w  #$407F,(A0)
            bge.b   .L32
.L26:
            pea     (A1)
            move.w  #$E,-(SP)
            bra.b   .L28
.L27:
            move.l  D4,-(SP)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (A1)
            move.w  #$C,-(SP)
.L28:
            bsr.w   RsrcPACK_5_2
            bchg    #7,(A1)
            move.l  D5,-(SP)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
.L29:
            bsr.w   sub_408EA0E4
            bsr.w   sub_408EA0E8
            movea.l A1,A0
            bsr.w   sub_408EA016
            subq.b  #3,D0
            bne.b   .L30
            bsr.w   sub_408EA0F8
            bra.b   .L31
.L30:
            subq.b  #2,D0
            beq.b   .L31
            bsr.w   sub_408EA0FC
.L31:
            lea     (-$1A,A6),A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            bra.w   sub_408EA3E6.L15
.L32:
            movea.l D5,A0
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #2,-(SP)
            bsr.w   RsrcPACK_5_2
            lea     (-$24,A6),A1
            movea.l D4,A0
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L13
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     (A1)
            lea     (-$1A,A6),A1
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            bchg    #7,(A1)
            pea     (A1)
            move.w  #$A,-(SP)
            bsr.w   RsrcPACK_5_2
            bchg    #7,(A1)
            bra.b   .L29
.L33:
            moveq   #$21,D0
            moveq   #0,D2
            subq.b  #1,D1
            beq.w   sub_408EA3E6.L15
.L34:
            bmi.w   sub_408EA3E6.L14
            bsr.b   sub_408EAAF4
            btst    #0,D2
            bne.b   .L35
            bsr.b   sub_408EAB04
            bra.b   .L36
.L35:
            bsr.w   sub_408EAB6A
.L36:
            andi.w  #3,D2
            subq.w  #2,D2
            bmi.b   .L37
            bchg    #7,(A4)
.L37:
            bsr.w   sub_408EA0E4
            bsr.w   sub_408EA108
            pea     (A4)
            pea     (-4,A6)
            bsr.w   ELCLASSX
            move.w  (-4,A6),D0
            bpl.b   .L38
            neg.w   D0
.L38:
            subq.w  #6,D0
            bne.b   .L39
            bsr.w   sub_408EA0FC
.L39:
            bra.w   sub_408EA3E6.L15
.L40:
            moveq   #$21,D0
            moveq   #1,D2
            subq.b  #1,D1
            bne.b   .L34
            bra.w   sub_408EA3E6.L7
sub_408EAAF4:
            pea     sub_408EAD12.L26
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            add.w   D0,D2
            rts
sub_408EAB04:
            lea     sub_408EAD12.L35,A2
            bsr.b   sub_408EAB38
            pea     (A4)
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A0)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            rts
sub_408EAB2A:
            bsr.b   sub_408EAB38
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            rts
sub_408EAB38:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            exg     A1,A2
            lea     (-$24,A6),A0
            bsr.w   sub_408EA0B4
            pea     (A0)
            lea     (-$1A,A6),A0
            bsr.w   sub_408EA0B4
            pea     (A0)
            move.w  #6,-(SP)
            jsr     (A3)
            rts
sub_408EAB6A:
            lea     sub_408EAD12.L36,A2
            bsr.b   sub_408EAB2A
            pea     (A2)
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     sub_408EAD12.L22
            pea     (A2)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L1
            pea     sub_408EAD12.L23
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A0)
            move.w  #2,-(SP)
            jsr     (A3)
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L13
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
.L1:
            bclr    #7,(A4)
            pea     sub_408EAD12.L23
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A0)
            movea.l A4,A0
            movea.l A2,A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L23
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            bchg    #7,(A4)
            pea     sub_408EAD12.L25
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
.L2:
            moveq   #$21,D0
            moveq   #0,D2
            subq.b  #1,D1
            bmi.w   sub_408EA3E6.L14
            beq.w   sub_408EA3E6.L15
            bsr.w   sub_408EAAF4
            bsr.b   sub_408EAC48
            ror.w   #1,D2
            bcc.b   .L3
            bchg    #7,(A4)
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            lea     sub_408EAD12.L13,A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            bsr.w   sub_408EA110
            beq.b   .L3
            bchg    #7,(A4)
.L3:
            bra.w   sub_408EA828.L37
sub_408EAC48:
            lea     sub_408EAD12.L37,A2
            bsr.w   sub_408EAB2A
            movea.l A4,A0
            lea     (-$2E,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A2)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            lea     (-$1A,A6),A0
            pea     (A0)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     sub_408EAD12.L22
            pea     (A2)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L1
            pea     sub_408EAD12.L21
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A1)
            pea     (A0)
            clr.w   -(SP)
            jsr     (A3)
            bra.b   .L2
.L1:
            pea     (A0)
            movea.l A4,A0
            lea     (-$24,A6),A1
            bsr.w   sub_408EA0AA
            pea     sub_408EAD12.L24
            pea     (A1)
            move.w  #2,-(SP)
            jsr     (A3)
            pea     sub_408EAD12.L21
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     sub_408EAD12.L22
            pea     (A2)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A2)
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            movea.l A1,A0
.L2:
            pea     (A0)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
.L3:
            subq.b  #1,D1
            bge.b   .L4
            lea     sub_408EAD12.L26,A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            clr.b   D1
            or.w    D1,(A4)
            bra.b   .L5
.L4:
            bne.b   .L6
.L5:
            bra.w   sub_408EA3E6.L15
.L6:
            bclr    #7,(A4)
            bsr.b   sub_408EAD12
            clr.b   D1
            or.w    D1,(A4)
            bra.w   sub_408EA828.L37
sub_408EAD12:
            moveq   #0,D2
            pea     .L13
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            bls.b   .L1
            moveq   #-1,D2
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            lea     .L13,A0
            movea.l A4,A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
.L1:
            move.l  (A4)+,-(SP)
            move.l  (A4)+,-(SP)
            move.w  (A4),-(SP)
            subq.l  #8,A4
            pea     .L34
            pea     (A4)
            move.w  #8,-(SP)
            jsr     (A3)
            bgt.b   .L2
            lea     .L38,A2
            bsr.w   sub_408EAB38
            pea     (A0)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            bra.w   .L3
.L2:
            movea.l A4,A0
            lea     (-$10,A6),A1
            bsr.w   sub_408EA0AA
            pea     .L32
            pea     (A1)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     (A1)
            lea     .L13,A0
            lea     (-$24,A6),A1
            bsr.w   sub_408EA0AA
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     .L13
            pea     (A1)
            clr.w   -(SP)
            jsr     (A3)
            pea     .L13
            pea     (-$10,A6)
            clr.w   -(SP)
            jsr     (A3)
            pea     .L32
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            movea.l A4,A0
            lea     (-$2E,A6),A1
            bsr.w   sub_408EA0AA
            pea     (-$10,A6)
            pea     (A4)
            move.w  #6,-(SP)
            jsr     (A3)
            pea     (-$24,A6)
            pea     (A1)
            move.w  #6,-(SP)
            jsr     (A3)
            lea     .L38,A2
            bsr.w   sub_408EAB38
            pea     (A0)
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     .L33
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            pea     (-$2E,A6)
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.L3:
            lea     (-8,A6),A1
            move.w  (SP)+,(A1)
            move.l  (SP)+,-(A1)
            move.l  (SP)+,-(A1)
            pea     (A1)
            pea     (A4)
            move.w  #2,-(SP)
            jsr     (A3)
            tst.w   D2
            bne.b   .L4
            bchg    #7,(A4)
            rts
.L4:
            pea     .L26
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
            rts
.L5:
            move.w  (A4),D1
            bmi.b   .L7
            move.l  (2,A4),D2
            bpl.b   .L7
            move.l  (6,A4),D0
            bne.b   .L7
            move.l  #$401E,D0
            sub.w   D1,D0
            ble.b   .L7
            cmpi.w  #$1F,D0
            bgt.b   .L7
            bfins   D2,D1{0:D0}
            bne.b   .L7
            lsr.l   D0,D2
            mulu.l  #$41A7,D1:D2
            divu.l  #$7FFFFFFF,D1:D2
            bfffo   D1{0:0},D2
            move.w  #$401E,D0
            lsl.l   D2,D1
            sub.w   D2,D0
            tst.b   D3
            bpl.b   .L6
            move.w  D0,(-2,A4)
.L6:
            move.w  D0,(A4)+
            move.l  D1,(A4)+
            clr.l   (A4)
            move.w  (-2,A6),FPState
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            adda.w  (SP),SP
            rts
.L7:
            pea     .L27
            pea     (A4)
            move.w  #4,-(SP)
            jsr     (A3)
            pea     .L28
            pea     (A4)
            move.w  #$C,-(SP)
            jsr     (A3)
            tst.b   (A4)
            bpl.b   .L8
            pea     .L28
            pea     (A4)
            clr.w   -(SP)
            jsr     (A3)
.L8:
            bra.w   sub_408EA3E6.L15
.L9:
            dc.w    $0005,$3FF6,$B946,$46AF,$F6CE,$3BFF,$3FF9,$94F4
            dc.w    $3221,$4D61,$FBEB,$3FFB,$DC97,$8903,$D944,$7893
            dc.w    $3FFF,$9F9E,$3946,$57CA,$1D05,$C001,$CD6B,$C53A
            dc.w    $46EC,$DC9A,$4001,$B483,$97E7,$BAE6,$FCE0
.L10:
            dc.b    $00,$02,$3F,$FF,$80
            ds.b    7
            dc.w    $C000,$B818,$35C3,$CE0A,$5E1D,$3FFF,$FA3E,$DF0E
            dc.w    $DDF4,$1A96
.L11:
            dc.w    $0003,$BFEE,$FF88,$90C8,$1B20,$9B79,$3FF9,$DA5C
            dc.w    $84EF,$B813,$272F,$4003,$97D3,$BAEA,$F80F,$FD45
            dc.w    $4009,$AB86,$71A1,$95BE,$FF0C
.L12:
            dc.b    $00,$02,$3F,$FF,$80
            ds.b    7
            dc.w    $4006,$D548,$7002,$984B,$5AB4,$400A,$F775,$612E
            dc.w    $96B7,$0780
.L13:
            dc.b    $3F,$FF,$80
            ds.b    7
.L14:
            dc.b    $BF,$FF,$80
            ds.b    7
.L15:
            ds.b    10
.L16:
            dc.b    $80
            ds.b    9
.L17:
            dc.b    $40,$00,$80
            ds.b    7
.L18:
            dc.w    $400D,$FFFE
            ds.b    6
.L19:
            dc.w    $7FFF
            ds.b    8
.L20:
            dc.w    $FFFF
            ds.b    8
.L21:
            dc.b    $40,$00,$C0
            ds.b    7
.L22:
            dc.b    $3F,$FD,$80
            ds.b    7
.L23:
            dc.b    $3F,$FE,$80
            ds.b    7
.L24:
            dc.b    $3F,$FE,$C0
            ds.b    7
.L25:
            dc.b    $3F,$FE,$E0
            ds.b    7
.L26:
            dc.w    $3FFF,$C90F,$DAA2,$2168,$C235,$3FFE,$C90F,$DAA2
            dc.w    $2168,$C235
.L27:
            dc.w    $400D,$834E
            ds.b    6
.L28:
            dc.w    $401D,$FFFF,$FFFE
            ds.b    4
.L29:
            dc.w    $3FFF,$B504,$F333,$F9DE,$6484
.L30:
            dc.w    $3FFE,$B504,$F333,$F9DE,$6484,$4000,$ADF8,$5458
            dc.w    $A2BB,$4A9B
.L31:
            dc.w    $3FFE,$B172,$17F7,$D1CF,$79AC
.L32:
            dc.w    $3FFE,$93CD,$3A2C,$8198,$E26A
.L33:
            dc.w    $3FFA,$DC2A,$86B1,$5FDB,$6462
.L34:
            dc.w    $3FFD,$8930,$A2F4,$F66A,$B18A
.L35:
            dc.b    $00,$03,$3F,$FF,$80
            ds.b    7
            dc.w    $4007,$88D8,$B844,$A6A8,$5A30,$400E,$8A15,$8A49
            dc.w    $0979,$2320,$4013,$FAA9,$FE26,$FE63,$F22B,$0003
            dc.w    $BFFE,$C250,$86AE,$43F5,$CBF5,$4006,$9E76,$EC66
            dc.w    $BEE7,$6BA2,$C00C,$AF51,$A1D6,$C4C4,$AA01,$4011
            dc.w    $A71B,$FEC4,$A997,$F6CE
.L36:
            dc.b    $00,$03,$3F,$FF,$80
            ds.b    7
            dc.w    $4007,$A6D9,$6A95,$FBDF,$9685,$400E,$C7A7,$EA65
            dc.w    $E85D,$156B,$4014,$D26E,$871C,$7B17,$52B2,$0003
            dc.w    $BFFB,$D57E,$18D7,$A6F6,$D758,$4003,$E364,$937E
            dc.w    $32B3,$D072,$C00A,$A62D,$4056,$586B,$C045,$4010
            dc.w    $8C49,$AF68,$520F,$8C7A
.L37:
            dc.b    $00,$03,$BF,$FF,$80
            ds.b    7
            dc.w    $4005,$B513,$0324,$83C0,$0955,$C009,$D1FF,$B242
            dc.w    $5762,$E0CF,$400A,$E190,$9309,$9376,$66AB,$0003
            dc.w    $BFE9,$B1FC,$3363,$D79B,$2838,$3FFD,$AA9D,$71D8
            dc.w    $3EC7,$4CD1,$C003,$E9CD,$8E24,$B965,$7DBB,$4007
            dc.w    $F09A,$3670,$9D4B,$1836
.L38:
            dc.w    $0004,$3FFF,$98D3,$1EAE,$2AFA,$5DAD,$4003,$8F79
            dc.w    $4CD8,$B3CD,$EFD9,$4005,$8E37,$ED85,$70B8,$B368
            dc.w    $4005,$CDA4,$BEA1,$AC59,$F3B8,$4004,$C405,$9C55
            dc.b    $4C,$F0,$C6,$56,$00,$04,$3F,$FF,$80
            ds.b    7
            dc.w    $4002,$A23B,$6C13,$1F92,$0E30,$4003,$C3C8,$593D
            dc.w    $FA3A,$486F,$4003,$82AE,$6838,$DDF5,$D945
            ds.b    20

            EVEN
