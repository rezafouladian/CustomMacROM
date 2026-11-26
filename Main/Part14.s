            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5

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
RsrcEntryPACK_4:
            dc.b    $70,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 4 (14916 bytes) - Combo mask
            dc.l    RsrcEntryPACK_5_2-BaseOfROM     ; Next entry
            dc.l    RsrcPACK_4-BaseOfROM            ; Data
            dc.b    'PACK'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'SRCSMBPKEBAL'
            dc.l    $C0A00000,$00003A50,$000001EC   ; Block header
RsrcPACK_4:
            bra.b   .L1
            dc.w    0,$5041,$434B,$0004,$0008
.L1:
            subq.w  #2,SP
            movem.l D0/A0-A1,-(SP)
            lea     sub_408EC1E4,A0
            move.l  A0,($B6E).w
            move.w  ($12,SP),D0
            bne.b   .L3
            movea.l ($E,SP),A1
            subq.l  #2,A1
            cmpi.w  #$A9EB,(A1)
            bne.b   .L6
            subq.l  #2,A1
            cmpi.w  #$4267,(A1)
            beq.b   .L2
            subq.l  #2,A1
            bra.b   .L4
.L2:
            move.w  #$4EB8,(A1)+
            move.w  #$B6C,(A1)
            bsr.b   sub_408EB2A2
            move.w  #$4EF9,($B6C).w
            movea.w #$B6C,A1
            bra.b   .L5
.L3:
            rol.w   #8,D0
            lsl.b   #2,D0
            bfexts  D0{18:10},D0
            move.w  ($408EB50C.w,PC,D0.w),D0
            lea     .L1(PC,D0.w),A0
            movea.l ($E,SP),A1
            subq.l  #2,A1
            cmpi.w  #$A9EB,(A1)
            bne.b   .L6
            subq.l  #4,A1
.L4:
            cmpi.w  #$3F3C,(A1)
            bne.b   .L6
            move.w  #$4EB9,(A1)+
            move.l  A0,(A1)
.L5:
            bsr.b   sub_408EB2A2
.L6:
            move.l  ($E,SP),($10,SP)
            move.l  A0,($C,SP)
            lea     sub_408EDCE6,A0
            cmpi.b  #4,CPUFlag
            blt.b   .L7
            lea     sub_408EDA00,A0
            move.l  A0,($1FD4).w
            bra.b   .L8
.L7:
            move.l  A0,OPERRVector
.L8:
            fmove.l FPCR,D0
            bset    #$D,D0
            fmove.l D0,FPCR
            movem.l (SP)+,D0/A0-A1
            rts
sub_408EB2A2:
            cmpi.b  #cpu68040,CPUFlag
            blt.b   .L2
            movem.l D0-D4/A1-A2,-(SP)
            move    SR,D0
            btst    #$D,D0
            bne.b   .L1
            moveq   #8,D0
            _DebugUtil
.L1:
            moveq   #5,D1
            movec   D1,DFC
            moveq   #1,D4
            subq.l  #2,A1
            movea.l A1,A2
            ori     #$700,SR
            move.w  #$D000,D3
            mc68040
            movec   TC,D2
            mc68030
            lsr.w   #2,D2
            eor.w   D2,D3
.L3:
            mc68040
            ptestr  (A1)
            movec   MMUSR,D1
            mc68030
            and.w   D3,D1
            move.w  A1,D2
            not.w   D3
            and.w   D3,D2
            or.w    D2,D1
            movea.l D1,A1
            mc68040
            cpushl  BC,(A1)
            mc68030
            not.w   D3
            movea.l A2,A1
            lea     ($10,A1),A1
            dbra    D4,.L3
            move    D0,SR
            movem.l (SP)+,D0-D4/A1-A2
            rts
.L2:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            rts
            dc.w    $054A,$059E,$0574,$0510,$05C8,$05F2,$061C,$0510
            dc.w    $2114,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0646,$069A,$0670,$0510,$06C4,$06EE,$0718,$0510
            dc.w    $2092,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0742,$0796,$076C,$0510,$07C0,$07EA,$0814,$0510
            dc.w    $218A,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $083E,$0892,$0868,$0510,$08BC,$08E6,$0910,$0510
            dc.w    $21EE,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0ABA,$0B2A,$0AF2,$0510,$0B62,$0B9A,$0BD2,$0510
            dc.w    $2F56,$2F30,$2F1E,$0510,$2EFA,$2EE8,$2F0C,$0510
            dc.w    $093A,$09BA,$097A,$0510,$09FA,$0A3A,$0A7A,$0510
            dc.w    $2CEE,$2CE0,$2CD2,$0510,$2CB6,$2CA8,$2CC4,$0510
            dc.w    $0C0A,$0C66,$0C38,$0510,$0C94,$0CC2,$0CF0,$0510
            dc.w    $21FA,$21FA,$21FA,$0510,$0510,$0510,$0510,$0510
            dc.w    $0D1E,$0D6A,$0D44,$0510,$0D90,$0DB6,$0DDC,$0510
            dc.w    $2206,$2206,$2206,$0510,$0510,$0510,$0510,$0510
            dc.w    $0D1E,$0E2C,$0E02,$0510,$0E56,$0EAE,$0F06,$0510
            dc.b    '&d&d&d'
            dc.w    $0510,$0510,$0510,$0510,$0510,$0F2C,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$227A,$23E4,$24AC
            dc.w    $0510,$0510,$0510,$0510,$0510,$0F4E,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$2584,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0F70,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$2212,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0F92,$0510,$0510
            dc.w    $0510,$0F92,$0510,$0510,$0510,$2554,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0FAE,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$222C,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0FC8,$2012,$1FC2
            dc.w    $0510,$0510,$0510,$2066,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0FE8,$106A,$102E
            dc.w    $0510,$10A6,$10E2,$111E,$0510,$2114,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$115A,$11DC,$11A0
            dc.w    $0510,$1218,$1254,$1290,$0510,$2092,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$12CC,$134E,$1312
            dc.w    $0510,$138A,$13C6,$1402,$0510,$218A,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$143E,$14C0,$1484
            dc.w    $0510,$14FC,$1538,$1574,$0510,$21EE,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$1796,$1822,$17E0
            dc.w    $0510,$1864,$18A6,$18E8,$0510,$2F66,$2F30,$2F1E
            dc.w    $0510,$2EFA,$2EE8,$2F0C,$0510,$15B0,$164E,$1604
            dc.w    $0510,$1698,$16E2,$172C,$0510,$2CFA,$2CE0,$2CD2
            dc.w    $0510,$2CB6,$2CA8,$2CC4,$0510,$192A,$19B4,$1974
            dc.w    $0510,$19F4,$1A34,$1A74,$0510,$21FA,$21FA,$21FA
            dc.w    $0510,$0510,$0510,$0510,$0510,$1AC6,$1B2C,$1AFE
            dc.w    $0510,$1B5A,$1B88,$1BB6,$0510,$2206,$2206,$2206
            dc.w    $0510,$0510,$0510,$0510,$0510,$1AC6,$1C18,$1BE4
            dc.w    $0510,$1C4C,$1CAE,$1D10,$0510
            dc.b    '&d&d&d'
            dc.w    $0510,$0510,$0510,$0510,$0510,$1DBE,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$22A4,$23E4,$24AC
            dc.w    $0510,$0510,$0510,$0510,$0510,$1DF2,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$2584,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$1E26,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$2212,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$1E5A,$0510,$0510
            dc.w    $0510,$1E5A,$0510,$0510,$0510,$2554,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$1EDA,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$222C,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$1F36,$2012,$1FC2
            dc.w    $0510,$0510,$0510,$2066,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$0510,$0510,$0510
            dc.w    $0510,$0510,$0510,$0510,$0510,$7051,$A9C9
sub_408EB710:
            movea.l ($C,A6),A0
            addq.w  #4,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            move.l  #$403E403E,-(SP)
            fmove.x (SP)+,FP1
            tst.b   (A0)
            bpl.b   .L1
            fsub.s  #"$5F800000",FP1
            fcmp.s  #"$DF000000",FP1
            fbne.w  .L1
            fmove.s #"$7FC01400",FP1
.L1:
            rts
            link.w  A6,#-$5E
            move.l  #$100020,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.x  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101020,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.s  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100820,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.d  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102020,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.w  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102820,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.l  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103020,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fadd.x  FP1,FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100022,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.x  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101022,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.s  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100822,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.d  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102022,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.w  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102822,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.l  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103022,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fsub.x  FP1,FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100024,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.x  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101024,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.s  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100824,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.d  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102024,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.w  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102824,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.l  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103024,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fmul.x  FP1,FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100026,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.x  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101026,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.s  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100826,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.d  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102026,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.w  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102826,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.l  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103026,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fdiv.x  FP1,FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10002A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.x  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10102A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.s  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10082A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.d  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10202A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.w  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10282A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.l  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10302A,(-4,A6)
            movem.l D0/A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.x  FP1,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            fbsf.w  sub_408EC1E4.L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100028,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.x  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101028,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.s  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100828,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.d  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102028,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.w  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102828,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.l  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103028,(-4,A6)
            movem.l D0/A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            fcmp.x  FP1,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (sub_408EC1E4.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10002C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.x  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10102C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.s  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10082C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.d  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10202C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.w  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10282C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.l  ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10302C,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            frem.x  FP1,FP0
            fmove.x FP0,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10002E,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmove.x ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10102E,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmove.s ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10082E,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmove.d ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10202E,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmove.w ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10282E,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fmove.l ([$C.w,A6]),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10302E,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            fmove.x FP1,FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101030,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            fmovem.x (A0),FP0
            movea.l (8,A6),A0
            fmove.s FP0,(A0)
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100830,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            fmovem.x (A0),FP0
            movea.l (8,A6),A0
            fmove.d FP0,(A0)
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102030,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            fmovem.x (A0),FP0
            fmovem.l FPCR/FPSR,-(SP)
            move.l  (SP),-(SP)
            clr.b   (2,SP)
            fmove.l (SP)+,FPCR
            movea.l (8,A6),A0
            fmove.w FP0,(A0)
            fmove.l FPSR,-(SP)
            btst    #5,(2,SP)
            addq.w  #4,SP
            fmovem.l (SP)+,FPCR/FPSR
            beq.b   .L2
            fmove.s #"$7FBFFFFF",FP1
            bra.b   .L3
.L2:
            fmove.w FP0,(A0)
.L3:
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102830,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            fmovem.x (A0),FP0
            fmovem.l FPCR/FPSR,-(SP)
            move.l  (SP),-(SP)
            clr.b   (2,SP)
            fmove.l (SP)+,FPCR
            movea.l (8,A6),A0
            fmove.l FP0,(A0)
            fmove.l FPSR,-(SP)
            btst    #5,(2,SP)
            addq.w  #4,SP
            fmovem.l (SP)+,FPCR/FPSR
            beq.b   .L4
            fmove.s #"$7FBFFFFF",FP1
            bra.b   .L5
.L4:
            fmove.l FP0,(A0)
.L5:
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103030,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            fmovem.x (A0),FP0
            fmovem.x FP0,-(SP)
            bra.w   sub_408ECCB0.L6
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5A
            move.l  #$C0032,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fsqrt.x (A0),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5A
            move.l  #$C0034,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fint.x  (A0),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5A
            move.l  #$C0036,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fintrz.x (A0),FP0
            fmove.x FP0,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5E
            move.l  #$102038,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            fmovem.x (A0),FP0
            bra.w   sub_408ECCB0.L11
            link.w  A6,#-$5A
            move.l  #$C003A,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            fabs.x  (A0),FP0
            bra.w   sub_408ECCB0.L16
            fmovem.x ([8.w,SP]),FP0
            fmovem.x FP0,-(SP)
            move.w  (SP)+,(SP)
            pea     (SP)
            move.l  ($12,SP),-(SP)
            bsr.w   QCLASSX
            lea     ($A,SP),SP
            rtd     #8
sub_408EC1E4:
            link.w  A6,#-$5E
            move.l  #$100000,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fadd.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101000,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fadd.s  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100800,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fadd.d  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102000,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fadd.w  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102800,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fadd.l  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103000,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fadd.x  FP1,FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100002,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fsub.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101002,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fsub.s  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100802,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fsub.d  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102002,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fsub.w  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102802,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fsub.l  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103002,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fsub.x  FP1,FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100004,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fmul.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101004,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fmul.s  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100804,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fmul.d  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102004,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fmul.w  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102804,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fmul.l  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103004,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fmul.x  FP1,FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100006,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fdiv.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101006,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fdiv.s  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100806,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fdiv.d  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102006,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fdiv.w  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102806,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fdiv.l  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103006,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            fdiv.x  FP1,FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10000A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.x  (SP)+,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10100A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.s  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10080A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.d  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10200A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.w  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10280A,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.l  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10300A,(-4,A6)
            movem.l D0/A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.x  FP1,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            fbsf.w  .L1
            fnop
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
.L1:
            dc.w    0,$0002,0,$0002,$0004,$0002,$0002,$0002
            dc.w    $0019,$0002,$0019,$0002,$0004,$0002,$0002,$0002
            link.w  A6,#-$5E
            move.l  #$100008,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.x  (SP)+,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    .L1(PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101008,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.s  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100808,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.d  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102008,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.w  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102808,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.l  ([$C.w,A6]),FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103008,(-4,A6)
            movem.l D0/A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fcmp.x  FP1,FP0
            fmove.l FPSR,D0
            bfextu  D0{4:4},D0
            move    (.L1.w,PC,D0.w*2),CCR
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10000C,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            frem.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10100C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            frem.s  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10080C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            frem.d  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10200C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            frem.w  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10280C,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            frem.l  ([$C.w,A6]),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10300C,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
            frem.x  FP1,FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            bsr.w   sub_408ECCB0
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
sub_408ECCB0:
            fmove.l FPSR,D0
            swap    D0
            bclr    #7,D0
            beq.b   .L1
            neg.b   D0
.L1:
            ext.w   D0
            rts
            link.w  A6,#-$5E
            move.l  #$10000E,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP),FP0
            movea.l (8,A6),A0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10100E,(-4,A6)
            move.l  A0,-(SP)
            fmove.s ([$C.w,A6]),FP0
            movea.l (8,A6),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10080E,(-4,A6)
            move.l  A0,-(SP)
            fmove.d ([$C.w,A6]),FP0
            movea.l (8,A6),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10200E,(-4,A6)
            move.l  A0,-(SP)
            fmove.w ([$C.w,A6]),FP0
            movea.l (8,A6),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10280E,(-4,A6)
            move.l  A0,-(SP)
            fmove.l ([$C.w,A6]),FP0
            movea.l (8,A6),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$10300E,(-4,A6)
            move.l  A0,-(SP)
            bsr.w   sub_408EB710
            fmove.x FP1,FP0
            movea.l (8,A6),A0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101010,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            movea.l (8,A6),A0
            fmove.s FP0,(A0)
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100810,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            movea.l (8,A6),A0
            fmove.d FP0,(A0)
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102010,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fmovem.l FPCR/FPSR,-(SP)
            move.l  (SP),-(SP)
            clr.b   (2,SP)
            fmove.l (SP)+,FPCR
            movea.l (8,A6),A0
            fmove.w FP0,(A0)
            fmove.l FPSR,-(SP)
            btst    #5,(2,SP)
            addq.w  #4,SP
            fmovem.l (SP)+,FPCR/FPSR
            beq.b   .L2
            fmove.s #"$7FBFFFFF",FP1
            bra.b   .L3
.L2:
            fmove.w FP0,(A0)
.L3:
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$102810,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP)+,FP0
            fmovem.l FPCR/FPSR,-(SP)
            move.l  (SP),-(SP)
            clr.b   (2,SP)
            fmove.l (SP)+,FPCR
            movea.l (8,A6),A0
            fmove.l FP0,(A0)
            fmove.l FPSR,-(SP)
            btst    #5,(2,SP)
            addq.w  #4,SP
            fmovem.l (SP)+,FPCR/FPSR
            beq.b   .L4
            fmove.s #"$7FBFFFFF",FP1
            bra.b   .L5
.L4:
            fmove.l FP0,(A0)
.L5:
            fnop
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$103010,(-4,A6)
            move.l  A0,-(SP)
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
.L6:
            ftst.x  FP0
            fbor.w  .L7
            fmovecr.x #$32,FP0
            bra.b   .L10
.L7:
            fmovem.l FPCR/FPSR,-(SP)
            move.l  (SP),-(SP)
            clr.b   (2,SP)
            fmove.l (SP)+,FPCR
            fint.x  FP0,FP0
            fgetexp.x FP0,FP1
            fsub.w  #$3F,FP1
            fbolt.w .L8
            fmovem.l (SP)+,FPCR/FPSR
            fmovecr.x #$32,FP0
            fmove.s #"$7FBFFFFF",FP1
            fnop
            bra.b   .L10
.L8:
            fmovem.l (SP)+,FPCR/FPSR
            fint.x  (SP),FP0
            fbuge.w .L9
            fadd.s  #"$5F800000",FP0
            bra.b   .L10
.L9:
            fmove.x FP0,(SP)
            clr.w   (SP)
            fmove.x (SP),FP0
            fmove.l FPCR,-(SP)
            fmove.l #0,FPCR
            fscale.x FP1,FP0
            fmove.l (SP)+,FPCR
.L10:
            fmovem.x FP0,(SP)
            addq.w  #4,SP
            movea.l (8,A6),A0
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5A
            move.l  #$C0012,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fsqrt.x (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5A
            move.l  #$C0014,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fint.x  (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5A
            move.l  #$C0016,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fintrz.x (SP),FP0
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
            link.w  A6,#-$5E
            move.l  #$102018,(-4,A6)
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmovem.x (SP),FP0
.L11:
            move.w  ([$C.w,A6]),D0
            bpl.b   .L12
            cmpi.w  #$C000,D0
            bgt.b   .L13
            addi.w  #$4000,D0
            fscale.w #$E000,FP0
            fscale.w #$E000,FP0
            bra.b   .L13
.L12:
            cmpi.w  #$4000,D0
            blt.b   .L13
            subi.w  #$4000,D0
            fscale.w #$2000,FP0
            fscale.w #$2000,FP0
.L13:
            fscale.w D0,FP0
            btst    #5,(-1,A6)
            beq.b   .L14
            fmove.x FP0,(A0)
            bra.b   .L15
.L14:
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
.L15:
            movem.l (SP)+,D0/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5A
            move.l  #$C001A,(-4,A6)
            move.l  A0,-(SP)
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fabs.x  (SP),FP0
.L16:
            fbeq.w  .L17
            fcmp.s  #"$7F800000",FP0
            fbne.w  .L18
.L17:
            flog2.x FP0,FP0
            bra.b   .L19
.L18:
            fgetexp.x FP0,FP0
.L19:
            btst    #5,(-1,A6)
            beq.b   .L20
            fmove.x FP0,(A0)
            bra.b   .L21
.L20:
            fmove.x FP0,(SP)
            move.w  (SP)+,(A0)+
            addq.l  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
.L21:
            movea.l (SP)+,A0
            unlk    A6
            rtd     #4
QCLASSX:
            movem.l D0/A0,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0)+,D0
            swap    D0
            bpl.b   .L4
            lsl.w   #1,D0
            ror.w   #1,D0
            beq.b   .L1
            cmpi.w  #$7FFF,D0
            beq.b   .L11
.L1:
            moveq   #5,D0
.L2:
            movea.l ($C,SP),A0
            move.w  D0,(A0)
            roxr.w  #1,D0
            bpl.b   .L3
            neg.w   (A0)
.L3:
            movem.l (SP)+,D0/A0
            rtd     #8
.L4:
            lsl.w   #1,D0
            ror.w   #1,D0
            beq.b   .L5
            cmpi.w  #$7FFF,D0
            beq.b   .L11
            bra.b   .L8
.L5:
            move.w  (A0)+,D0
            or.l    (A0),D0
            bne.b   .L7
.L6:
            moveq   #4,D0
            bra.b   .L2
.L7:
            moveq   #6,D0
            bra.b   .L2
.L8:
            move.l  A1,-(SP)
            movea.w D0,A1
            subq.w  #2,A0
            bfffo   (A0){0:0},D0
            bne.b   .L9
            suba.w  D0,A1
            bfffo   (4,A0){0:0},D0
            beq.b   .L10
.L9:
            suba.w  D0,A1
            tst.w   A1
            movea.l (SP)+,A1
            bpl.b   .L1
            bmi.b   .L7
.L10:
            movea.l (SP)+,A1
            bra.b   .L6
.L11:
            btst    #$1E,D0
            beq.b   .L12
            moveq   #2,D0
            bra.b   .L2
.L12:
            bclr    #$1F,D0
            move.w  (A0)+,D0
            or.l    (A0),D0
            bne.b   .L13
            moveq   #3,D0
            bra.b   .L2
.L13:
            moveq   #1,D0
            bra.b   .L2
            movem.l D0/A0,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0),D0
            add.l   D0,D0
            beq.b   .L16
            bfchg   D0{0:8}
            beq.b   .L17
            bftst   D0{0:8}
            beq.b   .L18
            moveq   #5,D0
.L14:
            movea.l ($C,SP),A0
            move.w  D0,(A0)
            roxr.w  #1,D0
            bpl.b   .L15
            neg.w   (A0)
.L15:
            movem.l (SP)+,D0/A0
            rtd     #8
.L16:
            moveq   #4,D0
            bra.b   .L14
.L17:
            moveq   #6,D0
            bra.b   .L14
.L18:
            bftst   D0{8:23}
            bne.b   .L19
            moveq   #3,D0
            bra.b   .L14
.L19:
            btst    #$17,D0
            beq.b   .L20
            moveq   #2,D0
            bra.b   .L14
.L20:
            moveq   #1,D0
            bra.b   .L14
            movem.l D0/A0,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0)+,D0
            or.w    (A0)+,D0
            or.w    (A0),D0
            add.l   D0,D0
            beq.b   .L23
            bfchg   D0{0:11}
            beq.b   .L24
            bftst   D0{0:11}
            beq.b   .L25
            moveq   #5,D0
.L21:
            movea.l ($C,SP),A0
            move.w  D0,(A0)
            roxr.w  #1,D0
            bpl.b   .L22
            neg.w   (A0)
.L22:
            movem.l (SP)+,D0/A0
            rtd     #8
.L23:
            moveq   #4,D0
            bra.b   .L21
.L24:
            moveq   #6,D0
            bra.b   .L21
.L25:
            bftst   D0{11:20}
            bne.b   .L26
            moveq   #3,D0
            bra.b   .L21
.L26:
            btst    #$14,D0
            beq.b   .L27
            moveq   #2,D0
            bra.b   .L21
.L27:
            moveq   #1,D0
            bra.b   .L21
            movem.l D0/A0,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0)+,D0
            add.l   D0,D0
            or.l    (A0),D0
            sne     D0
            roxl.b  #1,D0
            movea.l ($C,SP),A0
            ext.w   D0
            move.w  .L28(PC,D0.w*2),(A0)
            movem.l (SP)+,D0/A0
            rtd     #8
            dc.w    $0005,$FFFB
.L28:
            dc.w    $0004,$0002
sub_408ED28E:
            movem.l D0-D2/A0,-(SP)
            fmove.l FPSR,D0
            movea.l ($14,SP),A0
            moveq   #0,D2
            fmove.l FPCR,D1
            bfextu  D0{24:5},D0
            move.b  .L2(PC,D0.w),D0
            bfins   D0,D2{19:5}
            bclr    #$D,D1
            bftst   D1{16:2}
            beq.b   .L1
            bset    #$D,D1
.L1:
            bfextu  D1{18:5},D0
            move.b  .L2(PC,D0.w),D0
            bfins   D0,D2{27:5}
            bfextu  D1{24:2},D0
            move.b  .L3(PC,D0.w),D0
            bfins   D0,D2{25:2}
            bfextu  D1{26:2},D0
            move.b  .L4(PC,D0.w),D0
            bfins   D0,D2{17:2}
            move.w  D2,(A0)
            movem.l (SP)+,D0-D2/A0
            rtd     #4
.L2:
            dc.w    $0010,$0818,$0212,$0A1A,$0414,$0C1C,$0616,$0E1E
            dc.w    $0111,$0919,$0313,$0B1B,$0515,$0D1D,$0717,$0F1F
.L3:
            dc.w    $0002,$0103
.L4:
            dc.w    $0003,$0201
sub_408ED310:
            movem.l D0-D2/A0,-(SP)
            movea.l ($14,SP),A0
            move.w  (A0),D2
            fmove.l FPSR,D1
            bfextu  D2{19:5},D0
            move.b  .L1(PC,D0.w),D0
            bfins   D0,D1{24:5}
            fmove.l D1,FPSR
            fmove.l FPCR,D1
            bfextu  D2{27:5},D0
            move.b  .L1(PC,D0.w),D0
            bset    #4,D0
            bfins   D0,D1{16:7}
            bfextu  D2{25:2},D0
            move.b  sub_408ED28E.L3(PC,D0.w),D0
            bfins   D0,D1{24:2}
            bfextu  D2{17:2},D0
            move.b  sub_408ED28E.L4(PC,D0.w),D0
            bfins   D0,D1{26:2}
            fmove.l D1,FPCR
            movem.l (SP)+,D0-D2/A0
            rtd     #4
.L1:
            dc.w    $0070,$0474,$0878,$0C7C,$0272,$0676,$0A7A,$0E7E
            dc.w    $0171,$0575,$0979,$0D7D,$0373,$0777,$0B7B,$0F7F
            movem.l D0/A0-A1,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0),($A4C).w
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            pea     STDHANDLER040
            pea     sub_408EDA10.L5
            pea     sub_408EDA00
            pea     sub_408EDA10.L5
            pea     DZHANDLER040
            pea     sub_408EDA10.L5
            pea     sub_408EDA10.L5
            bra.b   .L3
.L2:
            pea     sub_408EDC6E
            pea     sub_408EDCF0.L4
            pea     sub_408EDCE6
            pea     sub_408EDCF0.L4
            pea     DZHANDLER
            pea     sub_408EDCF0.L4
            pea     sub_408EDCF0.L4
.L3:
            movea.l SP,A0
            move.w  #2,D0
            bsr.w   sub_408EDCF0.L8
            lea     ($1C,SP),SP
            movem.l (SP)+,D0/A0-A1
            rtd     #4
sub_408ED3EA:
            move.l  ($A4C).w,([4.w,SP])
            rtd     #4
            bchg    #7,([4.w,SP])
            rtd     #4
            bclr    #7,([4.w,SP])
            rtd     #4
sub_408ED40E:
            move.l  (4,SP),-(SP)
            bsr.w   sub_408ED28E
            fmovem.l .L1(PC),FPCR/FPSR
            rtd     #4
.L1:
            dc.b    $00,$00,$20
            ds.b    5
            movem.l D0-D1/A0,-(SP)
            moveq   #0,D0
            movea.l ($10,SP),A0
            fmove.l FPSR,D1
            move.w  (A0),D0
            move.w  .L2(PC,D0.w*2),D0
            bfextu  D1{D0:1},D1
            move.b  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #4
.L2:
            dc.w    $0018,$001A,$0019,$001B,$001C
preFMOVE:
            fmove.l FPCR,D2
            move.l  #$8C0,D3
            and.l   D2,D3
            beq.b   .L1
            eor.l   D3,D2
            fmove.l D2,FPCR
.L1:
            rts
sub_408ED46A:
            tst.l   D3
            beq.b   .L1
            eor.l   D3,D2
            fmove.l D2,FPCR
.L1:
            rts
            link.w  A6,#-$5E
            move.l  #$100033,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.b   preFMOVE
            movea.l (8,A6),A0
            fmove.x (A0),FP1
            movea.l ($C,A6),A0
            fmove.x (A0),FP0
            fmove.x FP0,(A0)
            move.w  (A0)+,(A0)
            bra.b   .L2
            link.w  A6,#-$5E
            move.l  #$100013,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.b   preFMOVE
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP1
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
.L2:
            fcmp.x  FP0,FP1
            fbogl.w .L4
            fbeq.w  .L3
            fcmp.x  FP0,FP0
            fbun.w  .L3
            fmove.x FP1,FP0
.L3:
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
            bsr.w   sub_408ED46A
            bra.w   .L14
.L4:
            fsolt   D1
            ftst.x  FP0
            fbne.w  .L6
            fmove.x #"$000000000000000000000001",FP0
            ftst.x  FP1
            fbogt.w .L5
            fneg.x  FP0,FP0
.L5:
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
            bra.b   .L11
.L6:
            fsolt   D0
            eor.b   D1,D0
            bpl.b   .L8
            bftst   (A0){1:15}
            beq.b   .L7
            bclr    #7,(2,A0)
.L7:
            subq.l  #1,(6,A0)
            bcc.b   .L10
            subq.l  #1,(2,A0)
            bcc.b   .L10
            subq.w  #1,(A0)
            bra.b   .L10
.L8:
            bftst   (A0){1:15}
            beq.b   .L9
            bset    #7,(2,A0)
.L9:
            addq.l  #1,(6,A0)
            bcc.b   .L10
            addq.l  #1,(2,A0)
            bcc.b   .L10
            addq.w  #1,(A0)
.L10:
            move.l  (A0),D0
            bfchg   D0{1:15}
            bne.b   .L12
.L11:
            bsr.w   sub_408ED46A
            btst    #7,(2,A0)
            bne.b   .L14
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L14
.L12:
            bsr.w   sub_408ED46A
            bfchg   D0{1:15}
            beq.b   .L13
            bset    #7,(2,A0)
            bra.b   .L14
.L13:
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L14:
            btst    #5,(-1,A6)
            beq.b   .L15
            move.w  (A0),-(A0)
.L15:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$100813,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.w   preFMOVE
            movea.l (8,A6),A0
            fmove.d (A0),FP1
            movea.l ($C,A6),A0
            fmove.d (A0),FP0
            fcmp.x  FP0,FP1
            fbogl.w .L17
            fbeq.w  .L16
            fcmp.x  FP0,FP0
            fbun.w  .L16
            fmove.x FP1,FP0
.L16:
            fmove.d FP0,(A0)
            bsr.w   sub_408ED46A
            bra.b   .L24
.L17:
            fsolt   D1
            ftst.x  FP0
            fbne.w  .L19
            fmove.d #"$0000000000000001",FP0
            ftst.x  FP1
            fbogt.w .L18
            fneg.x  FP0,FP0
.L18:
            fmove.d FP0,(A0)
            bra.b   .L22
.L19:
            fsolt   D0
            eor.b   D1,D0
            bpl.b   .L20
            subq.l  #1,(4,A0)
            bcc.b   .L21
            subq.l  #1,(A0)
            bra.b   .L21
.L20:
            addq.l  #1,(4,A0)
            bcc.b   .L21
            addq.l  #1,(A0)
.L21:
            move.l  (A0),D0
            bfchg   D0{1:11}
            bne.b   .L23
.L22:
            bsr.w   sub_408ED46A
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L24
.L23:
            bsr.w   sub_408ED46A
            bfchg   D0{1:11}
            bne.b   .L24
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L24:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5E
            move.l  #$101013,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            movea.l (8,A6),A0
            move.l  (A0),D1
            movea.l ($C,A6),A0
            move.l  (A0),D0
            bsr.w   preFMOVE
            fmove.s D1,FP1
            fmove.s D0,FP0
            fcmp.x  FP0,FP1
            fbogl.w .L26
            fbeq.w  .L25
            fcmp.x  FP0,FP0
            fbun.w  .L25
            fmove.x FP1,FP0
.L25:
            fmove.s FP0,(A0)
            bsr.w   sub_408ED46A
            bra.b   .L30
.L26:
            bsr.w   sub_408ED46A
            bftst   D0{1:31}
            bne.b   .L27
            moveq   #2,D0
            add.l   D1,D1
            roxr.l  #1,D0
            move.l  D0,(A0)
            bra.b   .L28
.L27:
            btst    #$1F,D0
            sne     D0
            fsolt   D1
            eor.b   D1,D0
            extb.l  D0
            add.l   D0,D0
            addq.l  #1,D0
            add.l   D0,(A0)
            move.l  (A0),D0
            bfchg   D0{1:8}
            bne.b   .L29
.L28:
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L30
.L29:
            bfchg   D0{1:8}
            bne.b   .L30
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L30:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
            link.w  A6,#-$5A
            move.l  #$C0019,(-4,A6)
            movem.l D0-D1/A0,-(SP)
            fmove.l FPSR,D1
            bfexts  D1{24:5},D0
            bfins   D0,D1{16:7}
            move.l  (8,A6),-(SP)
            bsr.w   sub_408ED310
            bra.b   sub_408ED780.L1
.L31:
            dc.w    $E080,$0820,$1040,$0410,$0208
sub_408ED780:
            link.w  A6,#-$5A
            move.l  #$C0015,(-4,A6)
            movem.l D0-D1/A0,-(SP)
            movea.l (8,A6),A0
            moveq   #0,D1
            move.w  (A0),D1
            move.w  sub_408ED46A.L31(PC,D1.w*2),D1
.L1:
            fmove.l FPCR,D0
            and.w   D1,D0
            andi.w  #$DF00,D0
            beq.w   .L9
            cmpi.b  #4,CPUFlag
            blt.w   .L8
            movea.l D0,A0
            fmove.l FPSR,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            move.l  A0,D0
            btst    #$F,D0
            beq.b   .L2
            fmove.s #"$7FFFFFFF",FP1
            fbgt.w  .L7
            fnop
            bra.b   .L10
.L2:
            btst    #$E,D0
            beq.b   .L3
            fcmp.s  #"$7FBFFFFF",FP1
            bra.b   .L7
.L3:
            btst    #$C,D0
            beq.b   .L4
            fmove.s #"$7F000000",FP1
            dc.w    $F200,$04E3,$6036
.L4:
            btst    #$B,D0
            beq.b   .L5
            fmove.s #"$1F000000",FP1
            dc.w    $F200,$04E3,$6022
.L5:
            btst    #$A,D0
            beq.b   .L6
            fmove.b #1,FP1
            fdiv.b  #0,FP1
            bra.b   .L7
.L6:
            fmove.b #1,FP1
            fadd.s  #"$01000000",FP1
.L7:
            fnop
            bra.b   .L10
.L8:
            movea.l D1,A0
            moveq   #0,D0
            bsr.w   sub_408EDCF0.L8
            fnop
            bra.b   .L10
.L9:
            fmove.l FPSR,D0
            and.w   ($FF).w,D0
            or.w    D1,D0
            fmove.l D0,FPSR
.L10:
            movem.l (SP)+,D0-D1/A0
            unlk    A6
            rtd     #4
            move.l  A0,-(SP)
            movea.l ($C,SP),A0
            bclr    #7,(A0)
            tst.w   ([8.w,SP])
            bpl.b   .L11
            bset    #7,(A0)
.L11:
            movea.l (SP)+,A0
            rtd     #8
WRITEFPU:
            movea.l (SP)+,A0
            jmp     CASEFP0(PC,D0.w*8)
CASEFP0:
            fmovem.x (SP)+,FP0
            bra.w   .L1
            fmovem.x (SP)+,FP1
            bra.w   .L1
            fmovem.x (SP)+,FP2
            bra.w   .L1
            fmovem.x (SP)+,FP3
            bra.w   .L1
            fmovem.x (SP)+,FP4
            bra.w   .L1
            fmovem.x (SP)+,FP5
            bra.w   .L1
            fmovem.x (SP)+,FP6
            bra.w   .L1
            dc.w    $F21F,$D001
.L1:
            jmp     (A0)
NAN2FPU:
            clr.l   -(SP)
            move.l  #$40000000,-(SP)
            move.b  D1,(1,SP)
            move.l  #$7FFF0000,-(SP)
            bsr.b   WRITEFPU
            rts
DZHANDLER040:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   .L2
.L1:
            frestore (SP)+
            rte
.L2:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            moveq   #$7F,D1
            bftst   D2{7:3}
            bne.w   sub_408EDA10.L6
            and.w   D2,D1
            bclr    #6,D1
            beq.b   .L3
            bclr    #2,D1
.L3:
            bfextu  D2{22:3},D0
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  #$7FFF0000,-(SP)
            cmpi.b  #$20,D1
            beq.b   .L4
            cmpi.b  #$24,D1
            beq.b   .L4
            cmpi.b  #6,D1
            beq.b   .L6
            cmpi.b  #$14,D1
            beq.b   .L6
            cmpi.b  #$15,D1
            beq.b   .L6
            cmpi.b  #$16,D1
            beq.b   .L6
            cmpi.b  #$D,D1
            beq.b   .L7
            lea     ($C,SP),SP
            bra.w   sub_408EDA10.L6
.L4:
            move.l  (-$18,A1),D1
            move.l  (-$C,A1),D2
            eor.l   D1,D2
            bpl.b   .L5
            bset    #7,(SP)
.L5:
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
.L6:
            bset    #7,(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
.L7:
            btst    #7,(-$C,A1)
            beq.b   .L8
            bset    #7,(SP)
.L8:
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
STDHANDLER040:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   sub_408ED99E
.L1:
            frestore (SP)+
            rte
sub_408ED99E:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   sub_408EDA10.L6
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   sub_408EDA10.L6
.L1:
            bfextu  D2{22:3},D0
            lea     (-$C,A1),A0
            bfextu  (-$28,A1){0:3},D1
            cmpi.b  #3,D1
            beq.b   .L2
            lea     (-$C,A0),A0
.L2:
            move.l  (8,A0),D1
            move.l  D1,-(SP)
            move.l  (4,A0),D1
            bset    #$1E,D1
            move.l  D1,-(SP)
            move.l  (A0),-(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
sub_408EDA00:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   sub_408EDA10
.L1:
            frestore (SP)+
            rte
sub_408EDA10:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   .L6
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   .L6
.L1:
            bfextu  D2{25:7},D1
            bpl.b   .L2
            bclr    #6,D1
            bclr    #2,D1
            cmpi.b  #1,D1
            bne.b   .L2
            moveq   #4,D1
.L2:
            move.b  .L4(PC,D1.w),D1
            beq.b   .L3
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bra.b   .L6
.L3:
            move.b  #$21,D1
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bfextu  D2{29:3},D0
            bsr.w   NAN2FPU
            bra.b   .L6
.L4:
            dc.w    $FFFF,$FFFF,$01FF,$24FF,$FFFF,$FFFF,$2224,$2121
            dc.w    $FFFF,$FFFF,$2424,$24FF,$FFFF,$FFFF,$2221,$FFFF
            dc.w    $0409,$0208,$0409,$FF08,$02FF,$FFFF,$FFFF,$FFFF
            ds.b    8
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$F018,$2A4A
.L5:
            dc.w    $F327,$4A17,$6706,$4A2F,$0001,$6604,$F35F,$4E73
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
.L6:
            movem.l (SP),D1-D2
            bclr    #1,(-$1C,A1)
            bne.b   .L7
            bclr    #2,(-$1C,A1)
.L7:
            movea.l (8,SP),A0
            suba.l  ($B6E).w,A0
            dc.w    $02FA,$8000,$FFBA,$6500,$033C,$9CFC,$0018,$F226
            dc.w    $BC00,$9CFC,$000C,$2001,$ECC0,$0408,$F200,$9000
            dc.w    $2001,$ECC0,$0403,$E8C1,$0402,$6704,$EEC0,$0403
            dc.w    $C042,$E8C0,$0402,$6704,$08C0,$000D,$E9C0,$0485
            dc.w    $103B,$0120,$F7A8,$41EE,$0030,$514E,$3C80,$2D0E
            dc.w    $2D28,$0010,$2D28,$000C,$2D28,$0008,$3D28,$FFFE
            dc.w    $3028,$FFFC,$E448,$5940,$6706,$6B08,$2D28,$0010
            dc.w    $2D28,$000C,$2D28,$0008,$43FA,$02D6,$2D09,$2D10
            dc.w    $2D28,$FFFC,$584E,$6000,$02BC
sub_408EDB88:
            movea.l (SP)+,A0
            jmp     .L1(PC,D0.w*8)
.L1:
            fmovem.x FP0,-(SP)
            bra.w   .L2
            fmovem.x FP1,-(SP)
            bra.w   .L2
            fmovem.x FP2,-(SP)
            bra.w   .L2
            fmovem.x FP3,-(SP)
            bra.w   .L2
            fmovem.x FP4,-(SP)
            bra.w   .L2
            fmovem.x FP5,-(SP)
            bra.w   .L2
            fmovem.x FP6,-(SP)
            bra.w   .L2
            dc.w    $F227,$E080
.L2:
            jmp     (A0)
DZHANDLER:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   .L1
            frestore (SP)+
            rte
.L1:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            moveq   #$3F,D1
            bftst   D2{7:3}
            bne.w   sub_408EDCF0.L5
            and.w   D2,D1
            bfextu  D2{22:3},D0
            clr.w   D2
            move.b  ($21,SP),D2
            move.l  ($10,SP,D2.w),D2
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  #$7FFF0000,-(SP)
            cmpi.b  #$20,D1
            beq.b   .L2
            cmpi.b  #$24,D1
            beq.b   .L2
            cmpi.b  #6,D1
            beq.b   .L4
            cmpi.b  #$14,D1
            beq.b   .L4
            cmpi.b  #$15,D1
            beq.b   .L4
            cmpi.b  #$16,D1
            beq.b   .L4
            cmpi.b  #$D,D1
            beq.b   .L5
            lea     ($C,SP),SP
            bra.w   sub_408EDCF0.L5
.L2:
            bsr.w   sub_408EDB88
            move.l  (SP)+,D1
            addq.w  #8,SP
            eor.l   D1,D2
            bpl.b   .L3
            bset    #7,(SP)
.L3:
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L4:
            bset    #7,(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L5:
            tst.l   D2
            bpl.b   .L6
            bset    #7,(SP)
.L6:
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
sub_408EDC6E:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   sub_408EDC78
            frestore (SP)+
            rte
sub_408EDC78:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   sub_408EDCF0.L5
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   sub_408EDCF0.L5
.L1:
            bfextu  D2{22:3},D0
            bsr.w   sub_408EDB88
            lea     (SP),A1
            move.l  (A1)+,D1
            not.l   D1
            bftst   D1{1:15}
            bne.b   .L2
            move.l  (A1)+,D1
            bclr    #$1F,D1
            or.l    (A1),D1
            beq.b   .L2
            bset    #6,-(A1)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L2:
            lea     ($C,SP),SP
            clr.w   D1
            move.b  ($21,SP),D1
            lea     ($18,SP,D1.w),A1
            move.l  (A1),-(SP)
            move.l  -(A1),-(SP)
            bset    #6,(SP)
            move.l  -(A1),-(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
sub_408EDCE6:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   sub_408EDCF0
            frestore (SP)+
            rte
sub_408EDCF0:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   .L5
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   .L5
.L1:
            move.w  D2,D1
            andi.w  #$3F,D1
            move.b  .L3(PC,D1.w),D1
            beq.b   .L2
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bra.b   .L5
.L2:
            move.b  #$21,D1
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bfextu  D2{29:3},D0
            bsr.w   NAN2FPU
            bra.b   .L5
.L3:
            dc.w    $FFFF,$FFFF,$01FF,$24FF,$FFFF,$FFFF,$2224,$2121
            dc.w    $FFFF,$FFFF,$2424,$24FF,$FFFF,$FFFF,$2221,$FFFF
            dc.w    $0409,$0208,$0409,$FF08,$02FF,$FFFF,$FFFF,$FFFF
            ds.b    8
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,0,$0080
.L4:
            dc.w    $F327,$4A17,$6604,$F35F,$4E73
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
.L5:
            movem.l (SP),D1-D2
            clr.w   D0
            move.b  ($21,SP),D0
            bset    #3,($20,SP,D0.w)
            movea.l (8,SP),A0
            suba.l  ($B6E).w,A0
            dc.w    $02FA,$8000,$FD0A,$6410,$206F,$0008,$91F8,$065C
            dc.w    $02FA,$8000,$FFBE,$657C,$9CFC,$0018,$F226,$BC00
            dc.w    $9CFC,$000C,$2001,$ECC0,$0408,$F200,$9000,$2001
            dc.w    $ECC0,$0403,$E8C1,$0402,$6704,$EEC0,$0403,$C042
            dc.w    $E8C0,$0402,$6704,$08C0,$000D,$E9C0,$0485,$103B
            dc.w    $0120,$F4EA,$41EE,$0030,$514E,$3C80,$2D0E,$2D28
            dc.w    $0010,$2D28,$000C,$2D28,$0008,$3D28,$FFFE,$3028
            dc.w    $FFFC,$E448,$5940,$6706,$6B08,$2D28,$0010,$2D28
            dc.w    $000C,$2D28,$0008,$43FA,$0018,$2D09,$2D10,$2D28
            dc.w    $FFFC,$584E,$4FEF,$000C,$4CDF,$0307,$F35F,$4E73
            fmovem.x FP3,($1A,SP)
            movem.l D0-D2/A0-A1,($32,SP)
            lea     ($14,SP),A0
            move    CCR,(A0)+
            move.l  D0,(A0)
            tst.w   (-4,A0)
            beq.b   .L6
            movea.l ($A4C).w,A0
            jsr     (A0)
            bra.b   .L7
.L6:
            lea     ($12,SP),SP
.L7:
            lea     ($34,SP),A6
            move.w  (A6),D1
            move.l  (8,A6),(0,A6,D1.w)
            addq.w  #2,SP
            move.l  (2,SP),($1E,SP)
            move    (SP),CCR
            addq.w  #6,SP
            fmovem.x (SP)+,FP3
            fmovem.l (SP)+,FPCR/FPSR/FPIAR
            movem.l (SP)+,D0-D2/A0-A1
            movea.l (4,A6),A6
            adda.w  (SP),SP
            rts
.L8:
            dc.w    $A097
            rts
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2800,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2000,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$3000,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$1000,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$800,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            moveq   #$20,D7
            bra.b   .L9
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            clr.w   D7
.L9:
            pea     (-2,A6)
            bsr.w   sub_408ED40E
            bclr    #7,($A4B).w
            move.w  (-2,A6),D3
            andi.w  #$6000,D3
            beq.b   .L10
            move.w  D3,(-4,A6)
            pea     (-4,A6)
            bsr.w   sub_408ED310
.L10:
            movea.l ($40,A6),A3
            lea     (-$10,A6),A0
            move.l  A0,($40,A6)
            move.l  A3,-(SP)
            move.l  A0,-(SP)
            move.w  D7,-(SP)
            addi.w  #$E,(SP)
            bsr.w   RsrcPACK_4
            tst.b   D7
            beq.b   .L11
            move.l  (-$C,A6),(-$E,A6)
            move.l  (-8,A6),(-$A,A6)
.L11:
            movea.l ($44,A6),A1
            move.l  (A1),D2
            movea.l ($3C,A6),A1
            move.w  (A0)+,D0
            clr.w   (A1)
            bclr    #$F,D0
            beq.b   .L12
            move.b  #1,(A1)
.L12:
            move.l  (A0)+,D4
            move.l  (A0),D5
            move.b  #1,(4,A1)
            cmpi.w  #$7FFF,D0
            bne.b   .L14
            move.l  D4,D0
            andi.l  #$7FFFFFFF,D0
            bne.b   .L15
            tst.l   D5
            bne.b   .L15
            moveq   #$49,D0
.L13:
            move.b  D0,(5,A1)
            bra.w   sub_408EDFC4.L13
.L14:
            tst.l   D4
            bne.b   sub_408EDFC4.L3
            tst.l   D5
            bne.b   sub_408EDFC4.L3
            moveq   #$30,D0
            bra.b   .L13
.L15:
            bset    #$1E,D4
            bne.b   .L16
            clr.w   -(SP)
            pea     (SP)
            bsr.w   sub_408ED780
            lea     (2,SP),SP
.L16:
            addq.l  #4,A1
            move.b  #$11,(A1)+
            move.b  #$4E,(A1)+
            bsr.b   sub_408EDFC4
            move.l  D5,D4
            bsr.b   sub_408EDFC4
            suba.w  #$16,A1
            bra.w   sub_408EDFC4.L13
sub_408EDFC4:
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
            ror.w   #8,D2
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
            move.l  ($40,A6),-(SP)
            move.l  A1,-(SP)
            move.b  D5,(4,A1)
            jsr     sub_408EE5AA
            cmp.b   (4,A1),D5
            bcs.b   .L9
            neg.w   (2,A1)
.L13:
            pea     (-4,A6)
            bsr.w   sub_408ED28E
            move.w  (-4,A6),D0
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            pea     (-2,A6)
            bsr.w   sub_408ED310
            ror.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L14
            move.l  (4,A6),(-6,A6)
            move.w  D0,(-$A,A6)
            pea     (-$A,A6)
            move.l  ($44,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($3C,A6),-(SP)
            move.w  D7,-(SP)
            addi.w  #$B,(SP)
            pea     (-4,A6)
            bsr.w   sub_408ED3EA
            movea.l (-4,A6),A0
            jsr     (A0)
.L14:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),($C,SP)
            lea     ($C,SP),SP
            rts
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2800,D7
            move.w  #$6000,D0
            bra.b   .L15
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$2000,D7
            move.w  #$6000,D0
            bra.b   .L15
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$3000,D7
            move.w  #$6000,D0
            bra.b   .L15
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$1000,D7
            move.w  #$6040,D0
            bra.b   .L15
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            move.w  #$800,D7
            move.w  #$6060,D0
.L15:
            pea     (-2,A6)
            bsr.w   sub_408ED40E
            move.w  (-2,A6),D3
            and.w   D0,D3
            ori.w   #$80,FPState
            bra.b   .L17
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            moveq   #$20,D7
            move.w  #$6060,D0
            bra.b   .L16
            movem.l D0-D7/A0-A4,-(SP)
            link.w  A6,#-$10
            clr.w   D7
            move.w  #$6060,D0
.L16:
            pea     (-2,A6)
            bsr.w   sub_408ED40E
            bclr    #7,($A4B).w
            move.w  (-2,A6),D3
            and.w   D0,D3
            beq.b   .L18
.L17:
            move.w  D3,(-4,A6)
            pea     (-4,A6)
            bsr.w   sub_408ED310
.L18:
            movea.l ($3C,A6),A3
            cmpi.w  #$20,D7
            ble.b   .L19
            lea     (-$10,A6),A0
            move.l  A0,($3C,A6)
.L19:
            movea.l ($40,A6),A2
            lea     (4,A2),A4
            moveq   #0,D4
            move.l  D4,D5
            move.b  (A4)+,D6
            beq.b   sub_408EE1E2.L6
            move.b  (A4),D0
            cmpi.b  #$49,D0
            beq.b   sub_408EE1E2.L4
            cmpi.b  #$4E,D0
            bne.b   sub_408EE1E2.L5
            move.b  (-1,A4),D2
            addq.l  #1,A4
            subq.b  #1,D2
            moveq   #8,D0
            cmpi.b  #4,D2
            bge.b   .L20
            subq.b  #4,D0
            add.b   D2,D0
.L20:
            bsr.b   sub_408EE1E2
            move.l  D5,D4
            moveq   #0,D5
            moveq   #8,D0
            bsr.b   sub_408EE1E2
            bra.b   sub_408EE1E2.L3
sub_408EE1E2:
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
            bne.b   sub_408EE1E2
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
            movea.l ($3C,A6),A0
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
            move.l  ($3C,A6),-(SP)
            move.l  ($40,A6),-(SP)
            jsr     sub_408EE314
            move.w  (SP)+,(2,A2)
            bra.b   .L11
.L10:
            cmpi.b  #$13,D6
            bhi.b   .L9
            move.l  ($3C,A6),-(SP)
            move.l  ($40,A6),-(SP)
            jsr     sub_408EE314
.L11:
            cmpi.w  #$20,D7
            blt.b   .L14
            bgt.b   .L12
            move.l  (6,A3),(8,A3)
            move.l  (2,A3),(4,A3)
            bra.b   .L14
.L12:
            pea     (-$10,A6)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #$10,(SP)
            bsr.w   RsrcPACK_4
            pea     (-4,A6)
            bsr.w   sub_408ED28E
            move.w  (-4,A6),D0
            btst    #8,D0
            beq.b   .L13
            andi.w  #$E1FF,D0
            bra.b   .L15
.L13:
            cmpi.w  #$1000,D7
            ble.b   .L15
            andi.w  #$FDFF,D0
            bra.b   .L15
.L14:
            pea     (-4,A6)
            bsr.w   sub_408ED28E
            move.w  (-4,A6),D0
.L15:
            andi.w  #$1F00,D0
            or.w    D0,(-2,A6)
            pea     (-2,A6)
            bsr.w   sub_408ED310
            ror.w   #8,D0
            and.w   (-2,A6),D0
            beq.b   .L16
            move.l  (4,A6),(-6,A6)
            move.w  D0,(-$A,A6)
            pea     (-$A,A6)
            subq.w  #4,SP
            move.l  ($40,A6),-(SP)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            addi.w  #9,(SP)
            pea     (-4,A6)
            bsr.w   sub_408ED3EA
            movea.l (-4,A6),A0
            jsr     (A0)
.L16:
            unlk    A6
            movem.l (SP)+,D0-D7/A0-A4
            move.l  (SP),(8,SP)
            lea     (8,SP),SP
            rts
sub_408EE314:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            blt.w   StuffIt_PACK_4.L9
            bsr.w   sub_408EEA06
            bsr.w   sub_408EEBC6
            bsr.w   StoD_PACK_4
            move.l  (-$10,A6),(-$C,A6)
            bsr.w   cXb2a_PACK_4
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
            bsr.w   Roundit_FPHWB2DC
            move.w  D1,D7
            asl.w   #4,D7
            movea.l ($38,A6),A0
            addq.w  #2,A0
            add.w   (A0),D7
            addi.w  #$400E,D7
            bsr.w   StuffIt_PACK_4
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
            bra.w   sub_408EE5AA.L4
.L7:
            move.w  #2,-(SP)
            pea     (SP)
            bsr.w   sub_408ED780
            move.w  #4,(SP)
            pea     (SP)
            bsr.w   sub_408ED780
            lea     (2,SP),SP
            pea     (-$14,A6)
            bsr.w   sub_408ED28E
            lea     (-$14,A6),A4
            move.w  (A4),D2
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
StuffIt_PACK_4:
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
            bsr.w   sub_408EE9F2
            bsr.w   StoD_PACK_4
            bsr.w   Nrmlz10_PACK_4
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
            bsr.w   BgnDiv_PACK_4
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
            bmi.b   sub_408EE4CE.L2
            addi.w  #$3F,D6
            moveq   #-1,D5
            bsr.w   Roundit_FPHWB2DC
            move.l  A1,D7
            bsr.w   StuffIt_PACK_4
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
            bra.w   sub_408EE5AA.L4
sub_408EE4CE:
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
            bsr.b   sub_408EE4CE
            bsr.b   sub_408EE4CE
            bsr.b   sub_408EE4CE
            bsr.b   sub_408EE4CE
            bsr.b   sub_408EE4CE
            addi.w  #$3F,D6
            move.w  D0,-(SP)
            moveq   #-1,D5
            movea.l A3,A1
            bsr.w   Roundit_FPHWB2DC
            movea.l A1,A3
            move.w  (SP)+,D7
            bsr.w   StuffIt_PACK_4
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
            move.w  #1,-(SP)
            pea     (SP)
            move.w  #$15,-(SP)
            _FP68K
            move.w  #4,(SP)
            pea     (SP)
            move.w  #$15,-(SP)
            _FP68K
            lea     (2,SP),SP
.L6:
            bra.w   sub_408EE5AA.L4
StoD_PACK_4:
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
sub_408EE5AA:
            movem.l D0-D7/A1-A4,-(SP)
            link.w  A6,#-$A0
            movea.l ($38,A6),A0
            addq.w  #2,A0
            move.w  (A0),D0
            ble.b   .L1
            bsr.w   sub_408EEA06
            bsr.w   XbyA_PACK_4
            bra.b   .L2
.L1:
            bsr.w   sub_408EE9F2
            bsr.w   sub_408EE890
            bsr.w   DivX_PACK_4
            moveq   #0,D5
            bsr.w   Roundit_FPHWB2DC
.L2:
            bsr.w   sub_408EE63C
.L3:
            unlk    A6
            movem.l (SP)+,D0-D7/A1-A4
            movea.l (SP)+,A0
            lea     (8,SP),SP
            jmp     (A0)
.L4:
            pea     (-$14,A6)
            bsr.w   sub_408ED28E
            lea     (-$14,A6),A0
            move.w  (A0),D4
            andi.w  #$60,D4
            beq.b   .L3
            pea     sub_408EEBC6.L2
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   RsrcPACK_4
            pea     (-$14,A6)
            bsr.w   sub_408ED28E
            lea     (-$14,A6),A0
            move.w  (A0),D4
            andi.w  #$FF9F,D4
            move.w  D4,(A0)
            pea     (-$14,A6)
            bsr.w   sub_408ED310
            pea     sub_408EEBC6.L2
            move.l  ($3C,A6),-(SP)
            move.w  #$2004,-(SP)
            bsr.w   RsrcPACK_4
            bra.b   .L3
sub_408EE63C:
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
            bsr.b   BD1DIGOUT_PACK_4
            rol.w   #4,D1
BD1DIGOUT_PACK_4:
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
XbyA_PACK_4:
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
Roundit_FPHWB2DC:
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
            bsr.w   RndStk_PACK_4
            tst.w   D5
            beq.w   .L9
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
            move.w  #4,-(SP)
            pea     (SP)
            bsr.w   sub_408ED780
            lea     (2,SP),SP
            pea     (-$14,A6)
            bsr.w   sub_408ED28E
            lea     (-$14,A6),A0
            move.w  (A0),D2
            bclr    #7,D2
            tst.b   ($A4B).w
            bpl.b   .L4
            bset    #7,D2
.L4:
            move.w  D2,D4
            andi.w  #$E0,D4
            beq.b   .L5
            or.w    D0,(A2)
            bra.b   .L9
.L5:
            btst    #$E,D2
            bne.b   .L11
            btst    #$D,D2
            bne.b   .L12
            cmpi.w  #5,D5
            blt.b   .L9
.L6:
            add.w   D0,(A2)
            bcc.b   .L9
.L7:
            cmpa.l  A2,A3
            beq.b   .L8
            addq.w  #1,-(A2)
            bcs.b   .L7
            bra.b   .L9
.L8:
            move.w  #1,-(A3)
            addq.w  #1,D1
            addi.w  #$10,D6
            lea     ($10,A1),A1
.L9:
            tst.w   (A3)
            bne.b   .L10
            lea     (2,A3),A3
            subq.w  #1,D1
            subi.w  #$10,D6
.L10:
            rts
.L11:
            btst    #$D,D2
            bne.b   .L9
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bmi.b   .L6
            bra.b   .L9
.L12:
            movea.l ($3C,A6),A4
            move.w  (A4),D2
            bpl.b   .L6
            bra.b   .L9
RndStk_PACK_4:
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
sub_408EE890:
            movea.l ($3C,A6),A0
            move.w  (A0)+,D6
            bclr    #$F,D6
            subi.w  #$400C,D6
            movea.l (-$10,A6),A3
            suba.w  #$34,A3
            move.l  (A0)+,(A3)
            move.l  (A0)+,(4,A3)
            moveq   #3,D3
Nrmlz10_PACK_4:
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
DivX_PACK_4:
            sub.w   D7,D6
            ble.w   BgnDiv_PACK_4.L6
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
            bra.b   BgnDiv_PACK_4
.L2:
            cmp.w   (A3),D0
            bhi.b   .L3
            addq.w  #1,D3
            clr.w   -(A3)
            bra.b   BgnDiv_PACK_4
.L3:
            subq.w  #1,D6
BgnDiv_PACK_4:
            bsr.b   PadIt_PACK_4
            movea.l A3,A0
.L1:
            move.l  (A0),D2
            divu.w  D0,D2
            bvs.w   DecrIt_PACK_4.L2
            swap    D2
            move.l  D2,(A0)
            swap    D2
            lea     (2,A0),A0
            cmpi.w  #2,D5
            blt.b   .L4
            beq.b   .L2
            move.w  D5,D7
            bclr    #1,D7
            bsr.b   MandS_PACK_4
            moveq   #0,D4
            move.w  -(A4),D1
            subx.w  D4,D1
            move.w  D1,(A4)
            negx.w  D7
            tst.w   D7
            bne.b   .L2
            bsr.b   DecrIt_PACK_4
.L2:
            move.w  D5,D7
            btst    #1,D7
            bne.b   .L3
            subq.w  #2,D7
.L3:
            bsr.b   MandS_PACK_4
            negx.w  D7
            tst.w   D7
            bne.b   .L4
            bsr.b   DecrIt_PACK_4
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
PadIt_PACK_4:
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
MandS_PACK_4:
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
DecrIt_PACK_4:
            subq.w  #1,(-2,A0)
            move.l  D5,D1
            lea     (2,A1,D1.w),A2
            lea     (2,A0,D1.w),A4
            asr.w   #1,D1
            move    #0,CCR
.L1:
            addx.w  -(A2),-(A4)
            dbra    D1,.L1
            bcc.b   DecrIt_PACK_4
            rts
.L2:
            clr.w   (A0)+
            move.w  D5,D7
            beq.b   DecrIt_PACK_4
            lea     (2,A1,D7.w),A2
            lea     (0,A0,D7.w),A4
            asr.w   #1,D7
            subq.w  #1,D7
            move    #0,CCR
.L3:
            subx.w  -(A2),-(A4)
            dbra    D7,.L3
            bsr.b   DecrIt_PACK_4
            bra.w   BgnDiv_PACK_4.L4
sub_408EE9F2:
            neg.w   D0
            cmpi.w  #$1458,D0
            bcs.b   sub_408EEA06.L1
            move.w  #$1457,D0
            move.w  D0,D1
            neg.w   D1
            move.w  D1,(A0)
            bra.b   sub_408EEA06.L1
sub_408EEA06:
            cmpi.w  #$1390,D0
            bcs.b   .L1
            move.w  #$138F,D0
            move.w  D0,(A0)
.L1:
            moveq   #0,D4
            move.w  D0,D4
            addi.w  #$20F,D4
            andi.b  #$F8,D4
            cmpi.w  #$C40,D4
            bcs.b   .L2
            move.w  #$C40,D4
.L2:
            move.w  D4,D5
            asr.w   #2,D5
            move.l  D0,D1
            _StackSpace
            cmp.l   D4,D0
            bpl.b   .L3
            moveq   #$1C,D0
            _SysError
.L3:
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
            blt.b   .L5
            cmpi.w  #$E,D2
            bge.b   .L4
            moveq   #1,D1
            lea     sub_408EEBC6.L3,A2
            subq.w  #7,D2
            asl.w   #2,D2
            move.l  (0,A2,D2.w),-(A1)
            bra.b   .L7
.L4:
            moveq   #2,D1
            lea     sub_408EEBC6.L4,A2
            subi.w  #$E,D2
            mulu.w  #6,D2
            move.l  (2,A2,D2.w),-(A1)
            bra.b   .L6
.L5:
            moveq   #0,D1
            lea     sub_408EEBC6.L2,A2
            asl.w   #1,D2
.L6:
            move.w  (0,A2,D2.w),-(A1)
.L7:
            tst.w   D0
            bne.b   .L8
            rts
.L8:
            bsr.b   sub_408EEB2C
            moveq   #3,D2
            movea.l (-8,A6),A2
            subq.l  #4,A2
            move.l  #$4D6E2EF5,(A2)
            move.l  #$1B1AE,-(A2)
            bra.b   .L11
.L9:
            bsr.b   sub_408EEB2C
.L10:
            bsr.b   sub_408EEB40
.L11:
            asr.w   #1,D0
            bcc.b   .L10
            bsr.b   cXb2a_PACK_4
            tst.w   D0
            bgt.b   .L9
            rts
cXb2a_PACK_4:
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
sub_408EEB2C:
            move.w  D1,D3
            movea.l (-4,A6),A1
            movea.l (-$C,A6),A3
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A3)
            dbra    D1,.L1
            rts
sub_408EEB40:
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
            bmi.b   .L8
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
.L8:
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
            bne.b   sub_408EEBC6
            rts
sub_408EEBC6:
            move.w  D1,D2
            movea.l (-4,A6),A1
            movea.l (-8,A6),A2
            lsr.w   #1,D1
.L1:
            move.l  -(A1),-(A2)
            dbra    D1,.L1
            rts
.L2:
            dc.w    $0001,$0005,$0019,$007D,$0271,$0C35,$3D09
.L3:
            dc.w    $0001,$312D,$0005,$F5E1,$001D,$CD65,$0095,$02F9
            dc.w    $02E9,$0EDD,$0E8D,$4A51,$48C2,$7395
.L4:
            dc.w    $0001,$6BCC,$41E9,$0007,$1AFD,$498D,$0023,$86F2
            dc.w    $6FC1,$00B1,$A2BC,$2EC5,$0378,$2DAC,$E9D9,$1158
            dc.w    $E460,$913D,$56BC,$75E2,$D631,0
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
