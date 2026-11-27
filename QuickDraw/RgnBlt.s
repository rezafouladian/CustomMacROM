RgnBlt:
            move.l  SP,(-$258,A6)
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            lsr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.w  D0,D1
            ext.l   D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D4,D0
            subq.w  #1,D0
.L1:
            clr.l   -(SP)
            dbra    D0,.L1
            move.l  SP,(-8,A6)
            moveq   #-1,D0
            cmpi.w  #4,D4
            bge.b   .L2
            cmpi.w  #$20,(-$98,A6)
            blt.b   .L2
            cmpi.w  #$2F,(-$98,A6)
            bgt.b   .L2
            moveq   #0,D0
.L2:
            move.l  D0,(-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            move.w  (-$76,A6),D4
            movea.l ($1C,A6),A3
            move.w  (-$74,A6),(-$246,A6)
            move.w  (-$70,A6),(-$248,A6)
            move.l  #$40001,(-$24C,A6)
            move.l  (-8,A6),(-$250,A6)
            move.w  (-$98,A6),D2
            move.w  D2,D1
            cmpi.w  #$20,D2
            bcs.w   .L10
            cmpi.w  #$40,D2
            bcc.w   .L37
            cmpi.w  #$30,D2
            blt.b   .L4
            cmpi.w  #$32,D2
            beq.b   .L4
            cmpi.w  #$3A,D2
            bne.w   .L37
            tst.w   (-$8E,A6)
            bne.b   .L4
            movea.l (-$88,A6),A0
            moveq   #-1,D0
            moveq   #$F,D3
.L3:
            cmp.l   (A0)+,D0
            dbne    D3,.L3
            bne.b   .L4
            movea.l ($1C88).w,A0
            adda.l  (-4,A0,D4.w*4),A0
            move.l  A0,(-$218,A6)
            move.w  #$10,(-$98,A6)
            move.w  (-$D4,A6),D7
            bfextu  (-$118,A6){0:D7},D3
            bfextu  (-$114,A6){0:D7},D6
            clr.w   (-$8E,A6)
            bra.w   .L18
.L4:
            andi.w  #$37,D2
            bclr    #4,D2
            bne.b   .L8
            cmpi.w  #4,D4
            blt.b   .L9
            movea.l ($1C84).w,A0
            bne.b   .L5
            movea.l ($1C80).w,A0
.L5:
            subi.w  #$20,D2
            beq.b   .L7
.L6:
            adda.l  (0,A0,D2.w*4),A0
            move.l  A0,(-$218,A6)
            bra.b   .L13
.L7:
            lea     (-$FA,A6),A1
            move.w  (A1)+,D0
            cmp.w   (A1)+,D0
            bne.b   .L6
            cmp.w   (A1),D0
            bne.b   .L6
            addq.w  #1,D0
            andi.w  #$FFFE,D0
            cmpi.w  #$8000,D0
            bne.b   .L6
            addq.w  #8,D2
            bra.b   .L6
.L8:
            addq.w  #8,D2
.L9:
            add.w   D2,D2
            subi.w  #$28,D2
            bra.b   .L12
.L10:
            andi.w  #$B,D2
            moveq   #3,D0
            and.w   D2,D0
            add.w   D0,D2
            cmpi.w  #8,D2
            bge.b   .L11
            cmpi.w  #4,D2
            beq.b   .L12
            tst.w   (-$104,A6)
            beq.b   .L12
            addi.w  #$28,D2
.L11:
            tst.w   (-$8E,A6)
            beq.b   .L12
            addq.w  #8,D2
.L12:
            lea     ($1B68).w,A0
            move.l  (0,A0,D2.w*2),(-$218,A6)
            move.l  (-$1C8,A6),D7
.L13:
            btst    #3,D1
            beq.b   .L15
            move.l  (-$88,A6),(-$1F8,A6)
            move.w  (-$8E,A6),D1
            beq.b   .L14
            moveq   #0,D6
            move.w  (-$8A,A6),D6
            addq.w  #1,D6
            divu.w  (-$8E,A6),D6
            subq.w  #1,D6
            and.w   (-$74,A6),D6
            mulu.w  D1,D6
            swap    D6
            move.w  (-$8C,A6),D7
            bra.w   .L18
.L14:
            moveq   #$F,D7
            and.w   (-$74,A6),D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            bra.w   .L18
.L15:
            movea.l ($24,A6),A2
            lea     (-$168,A6),A4
            move.l  (A4),D0
            cmp.l   (A5),D0
            bne.b   .L17
            move.w  (A3),D0
            sub.w   (6,A5),D0
            move.w  (A2),D1
            sub.w   (6,A4),D1
            sub.w   D1,D0
            blt.b   .L17
            bgt.b   .L16
            move.w  (2,A3),D0
            sub.w   (8,A5),D0
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            cmp.w   D1,D0
            ble.b   .L17
            move.w  (6,A2),D1
            sub.w   (8,A4),D1
            cmp.w   D1,D0
            bge.b   .L17
            neg.w   (-$24C,A6)
            bra.b   .L17
.L16:
            neg.w   (-$24A,A6)
            neg.l   (-$1BC,A6)
            neg.l   (-$7C,A6)
            move.w  (-$70,A6),(-$246,A6)
            subq.w  #1,(-$246,A6)
            move.w  (-$74,A6),(-$248,A6)
            subq.w  #1,(-$248,A6)
.L17:
            move.w  (2,A3),D6
            sub.w   (8,A5),D6
            ext.l   D6
            lsl.l   D4,D6
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            ext.l   D1
            lsl.l   D4,D1
            sub.l   D1,D6
            moveq   #$1F,D0
            and.l   D0,D6
            neg.l   D6
            move.w  (-$246,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            sub.w   (6,A4),D0
            move.w  (4,A4),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            movea.l (A4),A0
            adda.l  D0,A0
            move.w  (-$72,A6),D0
            sub.w   (2,A3),D0
            add.w   (2,A2),D0
            sub.w   (8,A4),D0
            ext.l   D0
            lsl.l   D4,D0
            sub.l   D6,D0
            asr.l   #5,D0
            lsl.l   #2,D0
            adda.l  D0,A0
            move.l  A0,(-$1F8,A6)
.L18:
            move.w  (-$246,A6),D0
            sub.w   (6,A5),D0
            move.w  (4,A5),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            movea.l (A5),A0
            adda.l  D0,A0
            move.w  (-$72,A6),D0
            sub.w   (8,A5),D0
            ext.l   D0
            lsl.l   D4,D0
            lsr.l   #5,D0
            lsl.l   #2,D0
            move.w  D0,D1
            add.l   A0,D0
            move.l  D0,(-$200,A6)
            tst.w   (-$8E,A6)
            beq.b   .L19
            and.w   D7,D1
            move.w  D1,(-$90,A6)
            move.w  D1,D6
            swap    D6
.L19:
            move.w  (-$98,A6),D2
            move.l  (-$118,A6),D4
            cmpi.w  #$10,D2
            beq.b   .L21
            tst.l   (-$C,A6)
            bne.b   .L20
            tst.w   (-$24C,A6)
            bpl.b   .L20
            move.w  (-$10,A6),D0
            ext.l   D0
            lsl.l   #2,D0
            add.l   D0,(-$200,A6)
            add.l   D0,(-$250,A6)
            add.l   D0,(-$1F8,A6)
.L20:
            move.w  (-$24C,A6),D3
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
.L21:
            move.w  (-$246,A6),(-4,A6)
            btst    #5,D2
            beq.w   .L29
            move.l  (-$114,A6),D5
            moveq   #0,D1
            move.w  (-$D4,A6),D1
            btst    #3,D2
            beq.b   .L23
            tst.w   (-$8E,A6)
            beq.b   .L22
            move.b  #1,(-$270,A6)
            move.w  D6,(-$27E,A6)
            movea.l (-$1F8,A6),A0
            adda.w  D6,A0
            move.l  A0,(-$1F8,A6)
            clr.w   D6
            swap    D6
            asl.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  D1,D3
            subq.w  #1,D3
            not.w   D3
            move.w  (-$8E,A6),D0
            asl.w   #3,D0
            subq.w  #1,D0
            and.w   D3,D0
            move.w  D0,(-$8C,A6)
            bra.b   .L24
.L22:
            clr.b   (-$270,A6)
            lea     ([-$88.w,A6],D7.w*4),A3
            move.l  A3,(-$1F8,A6)
            move.w  D7,(-$27E,A6)
            moveq   #0,D6
            move.l  D6,(-$27C,A6)
            move.w  #$1F,(-$8C,A6)
            bra.b   .L24
.L23:
            st      (-$270,A6)
            move.l  D6,(-$27C,A6)
            move.w  #$FFFF,(-$8C,A6)
.L24:
            cmpi.w  #$10,D1
            blt.b   .L25
            asr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$8C,A6),D0
            asr.w   #3,D0
            move.w  D0,(-$8C,A6)
.L25:
            move.w  D1,D7
            andi.w  #$37,D2
            cmpi.w  #$24,D2
            beq.b   .L26
            move.w  (-$10E,A6),D5
.L26:
            cmpi.w  #$32,D2
            bne.b   .L27
            bfextu  (-$118,A6){0:D7},D5
.L27:
            moveq   #5,D4
            sub.w   (-$76,A6),D4
            moveq   #1,D0
            lsl.w   D4,D0
            move.w  D0,(-$286,A6)
            move.w  D0,D2
            moveq   #0,D4
            move.l  D7,D3
            moveq   #$20,D1
            tst.w   (-$24C,A6)
            bpl.b   .L28
            neg.l   D3
            neg.w   D1
            moveq   #$20,D4
            sub.w   D0,D4
            add.l   D4,D6
.L28:
            move.w  D4,(-$284,A6)
            move.w  D1,(-$288,A6)
            move.w  (-$10,A6),D0
            addq.w  #1,D0
            mulu.w  D2,D0
            subq.w  #1,D0
            move.w  D0,(-$10,A6)
.L29:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            tst.l   (-$C,A6)
            bne.b   .L31
.L30:
            jsr     ([-$1C.w,A6])
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A5
            movea.l (-$250,A6),A4
            move.w  (-$10,A6),D2
            movea.l (-$218,A6),A2
            jmp     (A2)
.L31:
            movea.l (-$200,A6),A5
            movea.l (-$C,A6),A4
            move.w  (-$24C,A6),(-$78,A6)
            btst    #5,(-$97,A6)
            beq.b   .L32
            movea.w (-$24C,A6),A4
            move.w  (-$8C,A6),D4
.L32:
            tst.w   (-$7C,A6)
            bpl.b   .L34
            addq.w  #1,(-4,A6)
            jsr     ([-$1C.w,A6])
            subq.w  #1,(-4,A6)
            bra.b   .L34
.L33:
            move.w  D0,(-4,A6)
            move.l  A3,(-$1F8,A6)
.L34:
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            jsr     ([-$18.w,A6])
            move.w  (-4,A6),D0
            move.l  (-$7C,A6),D2
            movea.l (-$1F8,A6),A3
            movea.l (-$218,A6),A2
            jmp     (A2)
.L35:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            bra.b   .L36
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            bra.b   .L36
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  ([-$88.w,A6],D7.w*4),D6
.L36:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.w  (-4,A6),D0
            add.w   (-$24A,A6),D0
            move.w  D0,(-4,A6)
            cmp.w   (-$248,A6),D0
            bne.w   .L30
.L37:
            movea.l (-$258,A6),SP
            rts
.L38:
            move.w  (-$284,A6),D4
            move.l  (-$27C,A6),D6
            tst.b   (-$270,A6)
            beq.b   .L39
            bmi.b   .L35
            moveq   #0,D0
            move.w  (-$27E,A6),D0
            suba.l  D0,A3
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            adda.l  D0,A3
            move.w  D0,(-$27E,A6)
            bra.b   .L40
.L39:
            move.w  (-$27E,A6),D0
            addq.w  #1,D0
            andi.w  #$F,D0
            lea     ([-$88.w,A6],D0.w*4),A3
            move.w  D0,(-$27E,A6)
.L40:
            move.l  A3,(-$1F8,A6)
            bra.b   .L36
            dc.w    0
.L41:
            move.l  A2,D1
.L42:
            move.l  (-$27C,A6),D6
            tst.b   (-$270,A6)
            beq.b   .L43
            bmi.b   .L44
            moveq   #0,D0
            move.w  (-$27E,A6),D0
            suba.l  D0,A3
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            adda.l  D0,A3
            move.w  D0,(-$27E,A6)
            bra.b   .L45
.L43:
            move.w  (-$27E,A6),D0
            addq.w  #1,D0
            andi.w  #$F,D0
            lea     ([-$88.w,A6],D0.w*4),A3
            move.w  D0,(-$27E,A6)
            bra.b   .L45
.L44:
            adda.l  (-$1BC,A6),A3
.L45:
            movea.l (-$200,A6),A5
            adda.l  (-$7C,A6),A5
            move.l  A5,(-$200,A6)
            move.w  (-4,A6),D0
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   .L37
            subq.w  #1,D1
            ble.w   .L33
            move.w  D0,(-4,A6)
            movea.l (-$218,A6),A2
            jmp     (A2)
RARITH16TAB:
            dc.w    0,$1134,0,$0944,0,$07E4,0,$0C14
            dc.w    0,$1484,0,$0D84,0,$0AA4,0,$0EC4
            dc.w    0,$1014
RARITH32TAB:
            dc.w    0,$1076,0,$08A0,0,$0770,0,$0B70
            dc.w    0,$1430,0,$0D10,0,$0A30,0,$0E50
            dc.w    0,$0FA0
RHILITETAB:
            dc.w    0,$11EC,0,$11EC,0,$11EC,0,$11EC
            dc.w    0,$12CC
            ds.b    8
rMASK0:
            tst.l   D7
            bne.b   .L3
            tst.w   D3
            bmi.b   .L3
            neg.l   D6
            move.w  D6,D4
            andi.w  #7,D4
            bne.b   .L2
            asr.w   #3,D6
            suba.w  D6,A3
            lea     nxtScan0.L6,A2
.L1:
            move.l  A2,(-$218,A6)
            jmp     (A2)
.L2:
            moveq   #$20,D3
            sub.w   D6,D3
            lea     nxtScan0.L5,A2
            bra.b   .L1
.L3:
            lea     nxtScan0.L1,A2
            bra.b   .L1
nxtScan0:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L2:
            move.l  (A1)+,D2
            bmi.b   nxtScan0
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L4
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            move.l  (A1)+,D5
            and.l   D5,D4
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D4
            move.l  D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L2
.L4:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            move.l  D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L4
            bra.b   .L2
            dc.w    0
.L8:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L5:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L11:
            move.l  (A1)+,D2
            bmi.b   .L8
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L9
            move.l  (-4,A0),D5
.L10:
            move.l  (A0)+,D4
            lsl.l   D3,D5
            move.l  D4,D7
            lsr.l   D6,D7
            or.l    D5,D7
            move.l  (A1)+,D5
            and.l   D5,D7
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D7
            move.l  D7,(A2)+
            move.l  D4,D5
            dbra    D2,.L10
            bra.b   .L11
.L9:
            move.l  (-4,A0),D5
.L12:
            move.l  (A0)+,D4
            lsl.l   D3,D5
            move.l  D4,D7
            lsr.l   D6,D7
            or.l    D5,D7
            move.l  D7,(A2)+
            move.l  D4,D5
            dbra    D2,.L12
            bra.b   .L11
            ds.b    6
.L13:
            adda.l  D2,A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L6:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L16:
            move.l  (A1)+,D3
            bmi.b   .L13
            adda.w  D3,A2
            adda.w  D3,A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L14
.L15:
            move.l  (A0)+,D4
            move.l  (A1)+,D5
            and.l   D5,D4
            not.l   D5
            and.l   (A2),D5
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L15
            bra.b   .L16
.L14:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     (.L17.w,PC,D4.w*2)
.L18:
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
.L17:
            move.l  (A0)+,(A2)+
            dbra    D3,.L18
            bra.b   .L16
            ds.b    10
.L7:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   nxtScan0.L7
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK2:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rMASK1.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            eor.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            eor.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK3:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rMASK2.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            not.l   D4
            and.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            not.l   D4
            and.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    6
rcMask0:
            swap    D0
            move.w  D1,D0
            movea.w (-$24C,A6),A4
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            swap    D0
            subq.w  #1,D0
            bgt.b   .L2
            swap    D0
            bra.w   RgnBlt.L33
.L2:
            swap    D0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            movea.l A3,A0
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L5
.L4:
            bfextu  (A0){D6:0},D3
            adda.w  A4,A0
            eor.l   D7,D3
            move.l  D3,D1
            not.l   D3
            and.l   D5,D3
            and.l   D4,D1
            or.l    D1,D3
            move.l  (A1)+,D1
            and.l   D1,D3
            not.l   D1
            and.l   (A2),D1
            or.l    D1,D3
            move.l  D3,(A2)
            adda.w  A4,A2
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bfextu  (A0){D6:0},D3
            adda.w  A4,A0
            eor.l   D7,D3
            move.l  D3,D1
            not.l   D3
            and.l   D5,D3
            and.l   D4,D1
            or.l    D1,D3
            move.l  D3,(A2)
            adda.w  A4,A2
            dbra    D2,.L5
            bra.b   .L3
            ds.b    10
.L6:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rcMask1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rcMask0.L6
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D5
            adda.w  D3,A0
            eor.l   D7,D5
            and.l   (A1)+,D5
            not.l   D5
            and.l   D5,(A2)
            not.l   D5
            and.l   D4,D5
            or.l    D5,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D5
            adda.w  D3,A0
            eor.l   D7,D5
            not.l   D5
            and.l   D5,(A2)
            not.l   D5
            and.l   D4,D5
            or.l    D5,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rcMask3:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rcMask1.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            not.l   D4
            and.l   D4,(A2)
            not.l   D4
            and.l   D5,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            not.l   D4
            and.l   D4,(A2)
            not.l   D4
            and.l   D5,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK8:
            movea.l A5,A2
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rcMask3.L4
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            move.l  (A1)+,D4
            and.l   D4,D5
            not.l   D4
            and.l   (A2),D4
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     ($4082B13E.w,PC,D4.w*2)
sub_4082B120:
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            dbra    D3,sub_4082B120
            bra.b   rMASK8.L1
            ds.b    10
.L1:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  (-$7C,A6),A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK9:
            movea.l A5,A2
            movea.l A4,A1
            move.l  (-$A0,A6),D2
.L1:
            move.l  (A1)+,D3
            bmi.b   sub_4082B120.L1
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            and.l   (A1)+,D5
            move.l  D5,D4
            not.l   D4
            and.l   (A2),D4
            and.l   D2,D5
            or.l    D5,D4
            move.l  D4,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  D6,D5
            not.l   D5
            and.l   D2,D6
.L4:
            move.l  D5,D4
            and.l   (A2),D4
            or.l    D6,D4
            move.l  D4,(A2)+
            dbra    D3,.L4
            move.l  D5,D6
            not.l   D6
            bra.b   .L1
            ds.b    14
.L5:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK10:
            movea.l A5,A2
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rMASK9.L5
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            and.l   (A1)+,D5
            eor.l   D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     ($4082B226.w,PC,D4.w*2)
sub_4082B208:
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            dbra    D3,sub_4082B208
            bra.b   rMASK10.L1
rMASK11:
            move.l  (-$A4,A6),(-$A0,A6)
            lea     rMASK9,A2
            move.l  A2,(-$218,A6)
            jmp     (A2)
            dc.w    0
.L1:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK8:
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rMASK11.L1
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            move.l  (A1)+,D4
            and.l   D4,D5
            not.l   D4
            and.l   (A2),D4
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),(A2)+
            addq.w  #4,D6
            and.w   D7,D6
            dbra    D3,.L3
            bra.b   .L1
            ds.b    12
.L4:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  (-$7C,A6),A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK9:
            move.l  (-$A0,A6),D2
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rXMASK8.L4
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A1)+,D5
            move.l  D5,D4
            not.l   D4
            and.l   (A2),D4
            and.l   D2,D5
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),D5
            move.l  D5,D4
            not.l   D4
            and.l   D2,D5
            and.l   (A2),D4
            addq.w  #4,D6
            and.w   D7,D6
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L3
            bra.b   .L1
            ds.b    8
.L4:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK10:
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rXMASK9.L4
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            and.l   (A1)+,D5
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D5,(A2)+
            dbra    D3,.L3
            bra.b   .L1
            dc.w    0
rXMASK11:
            move.l  (-$A4,A6),(-$A0,A6)
            lea     rXMASK9,A2
            move.l  A2,(-$218,A6)
            jmp     (A2)
rAddOver:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.l  #$7F7F7F,D0
            movea.l #$808080,A2
.L7:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L6:
            move.l  (0,A0,D6.w),D7
            move.l  A2,D4
            and.l   D7,D4
            and.l   D0,D7
            move.l  (A5),D5
            move.l  A2,D3
            and.l   D5,D3
            and.l   D0,D5
            add.l   D7,D5
            eor.l   D4,D3
            eor.l   D3,D5
            move.l  D5,(A5)
            adda.w  A4,A5
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L6
            bra.b   .L7
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$4210,A2
.L3:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B4A8
.L4:
            tst.l   (A1)+
            bmi.b   .L5
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bsr.b   sub_4082B48C
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
sub_4082B48C:
            move.w  (0,A0,D6.w),D7
            move.w  A2,D4
            and.w   D7,D4
            and.w   D0,D7
            move.w  (A5),D5
            move.w  A2,D3
            and.w   D5,D3
            and.w   D0,D5
            add.w   D7,D5
            eor.w   D4,D3
            eor.w   D3,D5
            move.w  D5,(A5)
            rts
sub_4082B4A8:
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082B4A8
            bra.b   rAddOver.L3
            dc.w    0
rAddPin:
            movea.l (-$108,A6),A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            moveq   #2,D1
.L2:
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            bcs.b   .L3
            cmp.w   (-$FA.w,A6,D1.w*2),D0
            bls.b   .L4
.L3:
            move.w  (-$FA.w,A6,D1.w*2),D0
.L4:
            asl.l   D5,D0
            dbra    D1,.L2
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    12
            lea     .L9,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L9:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  Lo3Bytes,D1
.L17:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L16:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A5),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L11
            cmp.w   D3,D0
            bls.b   .L12
.L11:
            move.w  D3,D0
.L12:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L13
            cmp.b   D3,D0
            bls.b   .L14
.L13:
            move.b  D3,D0
.L14:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L15
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L15:
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L16
            bra.b   .L17
            ds.b    10
            lea     .L10,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L10:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$4210,A2
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B644
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082B606
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082B606:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L1
            move.l  D3,D0
.L1:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L2
            move.w  D3,D0
.L2:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L3
            move.b  D3,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082B644:
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082B644
            bra.w   rAddPin.L6
            ds.b    6
rSubOver:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L7:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L6:
            move.l  (0,A0,D6.w),D7
            move.l  D1,D3
            and.l   D7,D3
            eor.l   D1,D3
            and.l   D0,D7
            move.l  (A5),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A5)
            adda.w  A4,A5
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L6
            bra.b   .L7
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L3:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B76E
.L4:
            tst.l   (A1)+
            bmi.b   .L5
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bsr.b   sub_4082B74E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
sub_4082B74E:
            move.w  D1,D3
            move.w  (0,A0,D6.w),D7
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.w  (A5),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A5)
            rts
sub_4082B76E:
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082B76E
            bra.b   rSubOver.L3
            ds.b    12
rSubPin:
            movea.l (-$108,A6),A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            moveq   #2,D1
.L2:
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            bcs.b   .L3
            cmp.w   (-$FA.w,A6,D1.w*2),D0
            bcc.b   .L4
.L3:
            move.w  (-$FA.w,A6,D1.w*2),D0
.L4:
            asl.l   D5,D0
            dbra    D1,.L2
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    12
            lea     .L9,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L9:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  Lo3Bytes,D1
.L17:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L16:
            move.l  (0,A0,D6.w),D5
            add.w   A4,D6
            and.w   D4,D6
            and.l   D1,D5
            move.l  (A5),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L11
            cmp.w   D3,D0
            bcc.b   .L12
.L11:
            move.w  D3,D0
.L12:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L13
            cmp.b   D3,D0
            bcc.b   .L14
.L13:
            move.b  D3,D0
.L14:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L15
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L15:
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L16
            bra.b   .L17
            ds.b    10
            lea     .L10,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            addi.l  #$808080,D3
.L10:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  #$808080,D1
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B91A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082B8DA
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082B8DA:
            moveq   #0,D5
            move.w  (0,A0,D6.w),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A5),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L1
            move.l  D3,D0
.L1:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L2
            move.w  D3,D0
.L2:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L3
            move.b  D3,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082B91A:
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082B91A
            bra.w   rSubPin.L6
rMax:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L3
            move.w  (A1),D0
.L3:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L4
            move.w  (A1),D0
.L4:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L13:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L12:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  (A5),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bhi.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bhi.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bhi.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L12
            bra.b   .L13
            ds.b    12
            dc.w    $204B,$226E,$FFF4
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BA5A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BA1E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BA1E:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L1
            move.l  D5,D0
.L1:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L2
            move.w  D5,D0
.L2:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L3
            move.b  D5,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082BA5A:
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BA5A
            bra.w   rMax.L6
rMin:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L3
            move.w  (A1),D0
.L3:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L4
            move.w  (A1),D0
.L4:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L13:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L12:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  (A5),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bls.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bls.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bls.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L12
            bra.b   .L13
            ds.b    12
            dc.w    $204B,$226E,$FFF4
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BB9A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BB5E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BB5E:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L1
            move.l  D5,D0
.L1:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L2
            move.w  D5,D0
.L2:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L3
            move.b  D5,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082BB9A:
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BB9A
            bra.w   rMin.L6
rAvg:
            movea.l D3,A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     ([-$108.w,A6],D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     ([-$108.w,A6],D0.w*8),A1
            moveq   #2,D0
            move.w  (-$10E,A6),D3
            add.w   D3,D3
            clr.w   -(SP)
.L2:
            move.w  (A2)+,D1
            mulu.w  (-$FA.w,A6,D0.w*2),D1
            move.w  (A1)+,D5
            mulu.w  (-$100.w,A6,D0.w*2),D5
            add.l   D5,D1
            swap    D1
            move.w  (-$110,A6),D5
            lsr.w   D5,D1
            lsl.w   D3,D1
            or.w    D1,(SP)
            sub.w   (-$10E,A6),D3
            dbra    D0,.L2
            move.w  (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L3:
            add.l   A0,D6
            add.l   A0,D4
            dbra    D2,.L1
            move.l  A0,D3
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.l  #$7F7F7F,D0
            movea.l #$10101,A2
.L8:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L7:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  A2,D3
            and.l   D7,D3
            lsr.l   #1,D7
            and.l   D0,D7
            move.l  (A5),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D7
            add.l   D3,D7
            move.l  D7,(A5)
            adda.w  A4,A5
            dbra    D2,.L7
            bra.b   .L8
            ds.b    10
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$421,A2
.L4:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BCD2
.L5:
            tst.l   (A1)+
            bmi.b   .L6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L5
            bra.b   .L4
.L6:
            bsr.b   sub_4082BCB6
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L5
            bra.b   .L4
sub_4082BCB6:
            move.l  A2,D3
            move.w  (0,A0,D6.w),D7
            and.w   D7,D3
            lsr.w   #1,D7
            and.w   D0,D7
            move.w  (A5),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D7
            add.w   D3,D7
            move.w  D7,(A5)
            rts
sub_4082BCD2:
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BCD2
            bra.b   rAvg.L4
            ds.b    10
.L1:
            move.w  (SP)+,D1
            bra.w   RgnBlt.L42
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  D1,-(SP)
            lea     (-$FA,A6),A2
            move.l  (A2)+,D1
            move.w  (A2),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A2
.L2:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L3:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            move.l  (A5),D5
            cmp.l   D3,D7
            bne.b   .L4
            cmp.l   A2,D5
            beq.b   .L5
.L4:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A2
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A2
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A2,D4
            swap    D5
            movea.l D5,A2
            swap    D7
            move.l  D7,D3
.L5:
            move.l  D4,(A5)
            adda.w  A4,A5
            dbra    D2,.L3
            bra.b   .L2
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  D1,-(SP)
            lea     (-$FA,A6),A2
            move.l  (A2)+,D1
            move.w  (A2),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A2
.L6:
            move.l  (A1)+,D2
            bmi.w   .L1
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.w   sub_4082BE6E
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BDE6
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BDE6:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            moveq   #0,D5
            move.w  (A5),D5
            cmp.w   D3,D7
            bne.b   .L1
            cmp.w   A2,D5
            beq.b   .L2
.L1:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A2
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A2
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A2,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A2
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L2:
            move.w  D4,(A5)
            rts
sub_4082BE6E:
            bsr.w   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.w   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082BE6E
            bra.w   sub_4082BCD2.L6
            ds.b    6
rHilite:
            lea     .L2,A0
            move.l  A0,(-$218,A6)
            movea.l (-$118,A6),A3
            move.l  (-$114,A6),D5
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,A0
            move.w  A0,D1
            ble.w   RgnBlt.L33
.L2:
            movea.w D1,A0
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            swap    D2
            bclr    #$E,D2
            beq.b   .L11
.L4:
            move.l  (A2),D4
            cmp.l   D4,D5
            bne.b   .L6
.L5:
            move.l  (A1)+,D0
            move.l  A3,D1
            and.l   D0,D1
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D1
            move.l  D1,(A2)+
            dbra    D2,.L4
            bra.b   .L3
.L6:
            cmp.l   A3,D4
            bne.b   .L7
            exg     D5,A3
            bra.b   .L5
.L7:
            moveq   #$20,D1
            sub.w   D7,D1
            movea.l D5,A4
            move.l  (A1)+,D5
.L8:
            bfextu  D5{D1:D7},D0
            beq.b   .L10
            bfextu  D4{D1:D7},D0
            cmp.l   D6,D0
            bne.b   .L9
            bfins   D3,D4{D1:D7}
            bra.b   .L10
.L9:
            cmp.l   D3,D0
            bne.b   .L10
            bfins   D6,D4{D1:D7}
.L10:
            sub.w   D7,D1
            bpl.b   .L8
            move.l  D4,(A2)+
            move.l  A4,D5
            dbra    D2,.L4
            bra.b   .L3
.L11:
            move.l  (A2),D4
            cmp.l   D4,D5
            bne.b   .L13
.L12:
            move.l  A3,(A2)+
            dbra    D2,.L11
            bra.b   .L3
.L13:
            cmp.l   A3,D4
            bne.b   .L14
            exg     D5,A3
            bra.b   .L12
.L14:
            moveq   #$20,D1
            sub.w   D7,D1
.L15:
            bfextu  D4{D1:D7},D0
            cmp.l   D6,D0
            bne.b   .L16
            bfins   D3,D4{D1:D7}
            bra.b   .L17
.L16:
            cmp.l   D3,D0
            bne.b   .L17
            bfins   D6,D4{D1:D7}
.L17:
            sub.w   D7,D1
            bpl.b   .L15
            move.l  D4,(A2)+
            dbra    D2,.L11
            bra.w   .L3
            ds.b    8
            lea     .L18,A0
            move.l  A0,(-$218,A6)
            moveq   #-1,D3
            lsr.l   #8,D3
            movea.l (-$118,A6),A3
            move.l  (-$114,A6),D5
            bra.b   .L18
.L19:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L18:
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L22:
            move.l  (A1)+,D2
            bmi.b   .L19
            adda.w  D2,A2
            swap    D2
.L21:
            move.l  D3,D4
            and.l   (A2),D4
            cmp.l   D4,D5
            bne.b   .L20
.L24:
            move.l  A3,(A2)+
            dbra    D2,.L21
            bra.b   .L22
.L20:
            cmp.l   A3,D4
            bne.b   .L23
            exg     D5,A3
            bra.b   .L24
.L23:
            addq.l  #4,A2
            dbra    D2,.L21
            bra.b   .L22
rslowHilite:
            bra.w   RgnBlt.L37
            movea.w D1,A0
            bfextu  (-$114,A6){0:D7},D1
            movea.l D3,A0
            move.w  (-$8C,A6),D3
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,A0
            move.w  A0,D1
            ble.w   RgnBlt.L33
.L2:
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            swap    D2
            bclr    #$E,D2
            beq.b   .L5
.L4:
            move.l  (A2),D4
            move.l  (A1)+,D0
            move.l  A3,D1
            and.l   D0,D1
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D1
            move.l  D1,(A2)+
            dbra    D2,.L4
            bra.b   .L3
.L5:
            and.w   D3,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            beq.b   .L7
            bfextu  (A5){D4:D7},D0
            cmp.w   D5,D0
            bne.b   .L6
            bfins   D1,(A5){D4:D7}
            bra.b   .L7
.L6:
            cmp.w   D1,D0
            bne.b   .L7
            bfins   D5,(A5){D4:D7}
.L7:
            add.l   A0,D6
            add.l   A0,D4
            dbra    D2,.L5
            bra.b   .L3
            ds.b    6
rTransparent:
            move.w  (-$8C,A6),D1
            movea.w (-$286,A6),A0
            movea.w (-$288,A6),A2
            bfextu  D5{0:D7},D0
            movea.l D0,A1
.L1:
            and.w   D1,D6
            bfextu  (A3){D6:0},D0
            cmp.l   D0,D5
            beq.b   .L3
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            cmpa.l  D0,A1
            beq.b   .L2
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
.L3:
            add.l   A2,D6
            add.l   A2,D4
            sub.w   A0,D2
            bge.b   .L1
            bra.w   RgnBlt.L38
            ds.b    10
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L5:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            cmp.l   D7,D5
            beq.b   .L4
            move.l  D7,(A5)
.L4:
            adda.w  A4,A5
            dbra    D2,.L5
            bra.b   .L6
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L11:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   .L7
.L10:
            tst.l   (A1)+
            bmi.b   .L8
            move.w  (2,A0,D6.w),D7
            cmp.w   D7,D5
            beq.b   .L9
            move.w  D7,(2,A5)
.L9:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L10
            bra.b   .L11
.L8:
            move.w  (0,A0,D6.w),D7
            cmp.w   D7,D5
            beq.b   .L12
            move.w  D7,(A5)
.L12:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L10
            bra.b   .L11
.L7:
            move.l  (0,A0,D6.w),D7
            cmp.l   D7,D5
            beq.b   .L13
            cmp.w   D7,D5
            beq.b   .L14
            move.w  D7,(2,A5)
.L14:
            swap    D7
            cmp.w   D7,D5
            beq.b   .L13
            move.w  D7,(A5)
.L13:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L11
