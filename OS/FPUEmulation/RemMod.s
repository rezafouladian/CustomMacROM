            clr.l   (-$44,A6)
            bra.b   InstallFPSP+$45CE
            move.l  #$1,(-$44,A6)
            movem.l D2-D7/A2,-(SP)
            suba.l  A2,A2
            bfextu  (A0){1:15},D3
            move.l  (8,A0),D5
            move.l  (4,A0),D4
            bmi.b   .L27
            bne.b   .L26
            move.l  D5,D4
            moveq   #0,D5
            subi.l  #$20,D3
            bfffo   D4{0:0},D6
            lsl.l   D6,D4
            sub.l   D6,D3
            bra.b   .L27
.L26:
            bfffo   D4{0:0},D6
            sub.l   D6,D3
            lsl.l   D6,D4
            bfextu  D5{0:D6},D7
            lsl.l   D6,D5
            or.l    D7,D4
.L27:
            bfextu  (-$C,A0){1:15},D0
            move.l  (-4,A0),D2
            move.l  (-8,A0),D1
            bmi.b   .L29
            bne.b   .L28
            move.l  D2,D1
            moveq   #0,D2
            subi.l  #$20,D0
            bfffo   D1{0:0},D6
            lsl.l   D6,D1
            sub.l   D6,D0
            bra.b   .L29
.L28:
            bfffo   D1{0:0},D6
            sub.l   D6,D0
            lsl.l   D6,D1
            bfextu  D2{0:D6},D7
            lsl.l   D6,D2
            or.l    D7,D1
.L29:
            move.l  D3,(-$3C,A6)
            sub.l   D3,D0
            bge.b   .L30
            add.l   D3,D0
            suba.l  A1,A1
            bra.b   .L35
.L30:
            movea.l D0,A1
            moveq   #0,D3
            andi.l  #$1F,D0
            beq.b   .L31
            bfextu  D1{0:D0},D3
            lsl.l   D0,D1
            bfextu  D2{0:D0},D6
            lsl.l   D0,D2
            or.l    D6,D1
.L31:
            bsr.w   sub_40891984
            move.l  A1,D6
            bfextu  D6{16:11},D6
            beq.b   .L33
            movea.l D6,A1
            moveq   #0,D2
.L32:
            bsr.w   sub_40891984
            subq.l  #1,A1
            move.l  A1,D6
            bne.b   .L32
.L33:
            move.l  D1,D2
            move.l  D3,D1
            move.l  (-$3C,A6),D3
            movea.l D0,A1
            move.l  D3,D0
            tst.l   D1
            bne.b   .L34
            tst.l   D2
            beq.w   .L42
            move.l  D2,D1
            moveq   #0,D2
            subi.l  #$20,D0
            bfffo   D1{0:0},D6
            lsl.l   D6,D1
            sub.l   D6,D0
            bra.b   .L35
.L34:
            bmi.b   .L35
            bfffo   D1{0:0},D6
            sub.l   D6,D0
            lsl.l   D6,D1
            bfextu  D2{0:D6},D7
            lsl.l   D6,D2
            or.l    D7,D1
.L35:
            cmpi.l  #$40,D0
            bge.b   .L36
            addi.l  #$7E,D0
            addi.l  #$7E,D3
            addq.l  #1,A2
.L36:
            move.w  D0,(-$64,A6)
            clr.w   (-$62,A6)
            move.l  D1,(-$60,A6)
            move.l  D2,(-$5C,A6)
            move.w  D3,(-$74,A6)
            clr.w   (-$72,A6)
            move.l  D4,(-$70,A6)
            move.l  D5,(-$6C,A6)
            fmove.x (-$64,A6),FP0
            tst.l   (-$44,A6)
            beq.b   .L39
            subq.l  #1,D3
            cmp.l   D3,D0
            blt.b   .L39
            bgt.b   .L38
            cmp.l   D4,D1
            bne.b   .L37
            cmp.l   D5,D2
            beq.b   .L43
.L37:
            bcs.b   .L39
.L38:
            fsub.x  (-$74,A6),FP0
            addq.l  #1,A1
.L39:
            move.w  (-$C,A0),D6
            bpl.b   .L40
            fneg.x  FP0,FP0
.L40:
            move.w  (A0),D7
            eor.w   D7,D6
            lsr.l   #8,D6
            andi.l  #$80,D6
            move.l  A1,D7
            andi.l  #$7F,D7
            or.l    D7,D6
            swap    D6
            fmove.l FPSR,D7
            andi.l  #$FF00FFFF,D7
            or.l    D6,D7
            fmove.l D7,FPSR
            move.l  A2,D0
            movem.l (SP)+,D2-D7/A2
            fmove.l (-$80,A6),FPCR
            tst.l   D0
            beq.b   .L41
            fmul.s  #"$00800000",FP0
            bra.w   sub_40890C9C
.L41:
            fmove.x FP0,FP0
            rts
.L42:
            fmove.b #0,FP0
            bra.b   .L39
.L43:
            move.l  A1,D6
            andi.b  #1,D6
            beq.b   .L39
            addq.l  #1,A1
            fneg.x  FP0,FP0
            bra.b   .L39
sub_40891984:
            divu.l  D4,D3:D1
            bvs.b   .L4
            move.l  D1,D0
            move.l  D1,D7
            mulu.l  D5,D6:D7
.L1:
            move.l  D2,D1
            sub.l   D7,D1
            subx.l  D6,D3
            bcc.b   .L3
.L2:
            subq.l  #1,D0
            add.l   D5,D1
            addx.l  D4,D3
            bcc.b   .L2
.L3:
            rts
.L4:
            move.l  D5,D6
            moveq   #0,D7
            move.l  D1,D3
            moveq   #0,D0
            bra.b   .L1
