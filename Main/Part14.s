            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5_2

            IMPORT  BaseOfROM,RsrcEntryPACK_4_2

            SECTION "Part14",CODE

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
