.L2:
            dc.l    $3F81407E,$3F6A0000
.L3:
            dc.l    $3C0143FE,$3BCD0000
res_func:
            clr.b   (-$4A,A6)
            clr.b   (-$49,A6)
            clr.b   (-$46,A6)
            tst.b   (-$48,A6)
            beq.b   .L3
            bfextu  (-$E0,A6){0:3},D0
            bmi.b   .L1
            cmpi.b  #1,D0
            bne.b   .L3
            bfclr   (-$D8,A6){1:15}
            bra.b   .L3
.L1:
            lea     (-$D8,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L2
            bset    #7,(A0)
.L2:
            bfclr   (-$E0,A6){0:4}
            bset    #4,(-$E0,A6)
            ori.b   #$F,(-$4A,A6)
.L3:
            lea     (-$CC,A6),A0
            btst    #5,(-$E4,A6)
            bne.w   .L107
            bfextu  (-$E8,A6){0:3},D0
            bmi.w   .L24
            cmpi.b  #1,D0
            bne.b   .L4
            bfclr   (-$CC,A6){1:15}
.L4:
            tst.b   (-$48,A6)
            bne.w   .L27
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            btst    #0,D0
            bne.w   .L27
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.b  #$3B,D0
            tst.b   D0
            beq.w   .L11
            cmpi.b  #$18,D0
            beq.b   .L9
            cmpi.b  #$1A,D0
            beq.b   .L10
            move.w  (A0),D0
            bclr    #$F,D0
            sne     (2,A0)
            beq.b   .L5
            ori.l   #$8000000,(-$7C,A6)
.L5:
            cmpi.w  #$7FFF,D0
            bne.b   .L7
            tst.l   (4,A0)
            bne.b   .L6
            tst.l   (8,A0)
            bne.b   .L6
            ori.l   #$2000000,(-$7C,A6)
            rts
.L6:
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            rts
.L7:
            tst.l   (4,A0)
            bne.b   .L8
            tst.l   (8,A0)
            bne.b   .L8
            ori.l   #$4000000,(-$7C,A6)
.L8:
            rts
.L9:
            move.b  (-$E8,A6),D0
            btst    #5,D0
            bne.w   .L97
            bclr    #7,(A0)
            bra.b   .L11
.L10:
            move.b  (-$E8,A6),D0
            btst    #5,D0
            bne.w   .L97
            bchg    #7,(A0)
.L11:
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            bne.w   .L97
            btst    #2,(-$E3,A6)
            bne.b   .L12
            btst    #6,(-$E3,A6)
            bne.b   .L14
            bfextu  (-$7D,A6){0:2},D0
            beq.w   .L21
            cmpi.b  #1,D0
            beq.b   .L14
.L12:
            bfextu  (-$7D,A6){2:2},D1
            ori.l   #$20000,D1
            move.l  D1,-(SP)
            bclr    #7,(A0)
            sne     (2,A0)
            moveq   #2,D0
            move.w  (A0),D1
            cmpi.w  #$3C01,D1
            blt.b   .L17
            move.l  (SP)+,D1
            moveq   #0,D0
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L13
            bset    #7,(A0)
.L13:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$43FF,D1
            bge.b   .L16
            bra.w   .L21
.L14:
            bfextu  (-$7D,A6){2:2},D1
            ori.l   #$10000,D1
            move.l  D1,-(SP)
            bclr    #7,(A0)
            sne     (2,A0)
            moveq   #1,D0
            move.w  (A0),D1
            cmpi.w  #$3F81,D1
            blt.b   .L17
            move.l  (SP)+,D1
            moveq   #0,D0
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L15
            bset    #7,(A0)
.L15:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$407F,D1
            blt.b   .L21
.L16:
            bsr.w   sub_40890AB4
            bra.b   .L21
.L17:
            bsr.w   sub_4088FD4A
            move.l  (SP)+,D1
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L18
            bset    #7,(A0)
.L18:
            ori.l   #$800,(-$7C,A6)
            btst    #1,(-$7A,A6)
            beq.b   .L19
            ori.l   #$20,(-$7C,A6)
.L19:
            tst.l   (4,A0)
            bne.b   .L20
            tst.l   (8,A0)
            bne.b   .L20
            andi.w  #$8000,(A0)
            bra.b   .L22
.L20:
            bsr.w   sub_4088FCF8
            bra.b   .L23
.L21:
            tst.l   (4,A0)
            bne.b   .L23
            tst.l   (8,A0)
            bne.b   .L23
.L22:
            ori.l   #$4000000,(-$7C,A6)
.L23:
            tst.w   (A0)
            bpl.w   .L97
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L97
.L24:
            tst.b   (-$48,A6)
            bne.b   .L25
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            btst    #0,D0
            bne.b   .L25
            st      (-$46,A6)
            bra.b   .L29
.L25:
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L26
            bset    #7,(A0)
.L26:
            bfclr   (-$E8,A6){0:4}
            bset    #4,(-$E8,A6)
            ori.b   #$F0,(-$4A,A6)
.L27:
            tst.b   (-$4A,A6)
            bne.w   .L50
.L28:
            move.b  #$FE,(-$11C,A6)
            bclr    #2,(-$DC,A6)
            clr.w   (-$EC,A6)
            st      (-$49,A6)
            rts
.L29:
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.b  #$3B,D0
            tst.b   D0
            beq.b   .L36
            cmpi.b  #$18,D0
            beq.b   .L34
            cmpi.b  #$1A,D0
            beq.b   .L35
            move.w  (A0),D0
            bclr    #$F,D0
            sne     (2,A0)
            beq.b   .L30
            ori.l   #$8000000,(-$7C,A6)
.L30:
            cmpi.w  #$7FFF,D0
            bne.b   .L32
            tst.l   (4,A0)
            bne.b   .L31
            tst.l   (8,A0)
            bne.b   .L31
            ori.l   #$2000000,(-$7C,A6)
            rts
.L31:
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            rts
.L32:
            tst.l   (4,A0)
            bne.b   .L33
            tst.l   (8,A0)
            bne.b   .L33
            ori.l   #$4000000,(-$7C,A6)
.L33:
            rts
.L34:
            bclr    #7,(A0)
            bra.b   .L36
.L35:
            bchg    #7,(A0)
.L36:
            btst    #2,(-$E3,A6)
            bne.b   .L37
            btst    #6,(-$E3,A6)
            bne.b   .L39
            bfextu  (-$7D,A6){0:2},D0
            tst.b   D0
            beq.b   .L41
            cmpi.b  #1,D0
            beq.b   .L39
.L37:
            bfextu  (-$7D,A6){2:2},D1
            tst.w   (A0)
            blt.b   .L38
            cmpi.b  #3,D1
            bne.b   .L42
            bra.b   .L43
.L38:
            cmpi.b  #2,D1
            bne.b   .L45
            bra.w   .L46
.L39:
            bfextu  (-$7D,A6){2:2},D1
            tst.w   (A0)
            blt.b   .L40
            cmpi.b  #3,D1
            bne.b   .L42
            bra.w   .L48
.L40:
            cmpi.b  #2,D1
            bne.b   .L45
            bra.w   .L49
.L41:
            ori.l   #$800,(-$7C,A6)
            tst.w   (A0)
            beq.w   .L97
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L97
.L42:
            clr.l   (A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            ori.l   #$4000A28,(-$7C,A6)
            bra.w   .L97
.L43:
            move.l  #$3BCD0000,(A0)
.L44:
            move.l  #$80000000,(4,A0)
            clr.l   (8,A0)
            ori.l   #$A28,(-$7C,A6)
            bra.w   .L97
.L45:
            move.l  #$80000000,(A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            ori.l   #$C000A28,(-$7C,A6)
            bra.w   .L97
.L46:
            move.l  #$BBCD0000,(A0)
.L47:
            move.l  #$80000000,(4,A0)
            clr.l   (8,A0)
            ori.l   #$8000A28,(-$7C,A6)
            bra.w   .L97
.L48:
            move.l  #$3F6A0000,(A0)
            bra.b   .L44
.L49:
            move.l  #$BF6A0000,(A0)
            bra.b   .L47
.L50:
            tst.b   (-$48,A6)
            beq.w   .L28
            move.w  (-$E4,A6),D0
            andi.w  #$3B,D0
            cmpi.w  #$22,D0
            beq.w   .L56
            cmpi.w  #$28,D0
            beq.w   .L65
            cmpi.w  #$23,D0
            beq.w   .L78
            cmpi.w  #$38,D0
            beq.w   .L75
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L51
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$7FFF,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.w   .L80
.L51:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
            clr.b   (-$10A,A6)
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.b   .L52
            st      (-$10A,A6)
.L52:
            bclr    #2,(-$DC,A6)
            ori.l   #$1048,(-$7C,A6)
            clr.w   (-$EC,A6)
            lea     (-$10C,A6),A0
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L54
            btst    #2,D0
            bne.b   .L53
            moveq   #1,D0
            bra.b   .L55
.L53:
            moveq   #2,D0
            bra.b   .L55
.L54:
            bfextu  (-$7D,A6){0:2},D0
.L55:
            bsr.w   sub_408904E2
            bfclr   (-$10A,A6){0:8}
            beq.w   .L92
            bset    #7,(-$10C,A6)
            bra.w   .L92
.L56:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L57
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.b   .L58
.L57:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
.L58:
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.w   .L60
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L59
            move.w  (-$D8,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$D8,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$CC,A6),FP0
            fadd.x  (-$D8,A6),FP0
            lea     (-$10C,A6),A0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L59:
            move.w  (-$CC,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$CC,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$CC,A6),FP0
            fadd.x  (-$D8,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L60:
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L62
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            bsr.w   round
            bfclr   (-$CA,A6){0:8}
            beq.b   .L61
            bset    #7,(-$CC,A6)
.L61:
            lea     (-$10C,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            tst.w   (-$CC,A6)
            bgt.b   .L64
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L64
.L62:
            lea     (-$D8,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$D8,A6)
            sne     (-$D6,A6)
            bsr.w   round
            bfclr   (-$D6,A6){0:8}
            beq.b   .L63
            bset    #7,(-$D8,A6)
.L63:
            lea     (-$10C,A6),A0
            move.l  (-$D8,A6),(A0)
            move.l  (-$D4,A6),(4,A0)
            move.l  (-$D0,A6),(8,A0)
            tst.w   (-$D8,A6)
            bgt.b   .L64
            ori.l   #$8000000,(-$7C,A6)
.L64:
            move.w  (-$10C,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$7FFF,D0
            bne.w   .L87
            ori.l   #$2001048,(-$7C,A6)
            clr.l   (4,A0)
            bra.w   .L87
.L65:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L66
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            bra.b   .L67
.L66:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
.L67:
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            bne.w   .L69
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L68
            move.w  (-$D8,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$D8,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$D8,A6),FP0
            fsub.x  (-$CC,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L68:
            move.w  (-$CC,A6),D0
            andi.w  #$8000,D0
            ori.w   #$3FFF,D0
            move.w  D0,(-$CC,A6)
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            fmove.l D0,FPCR
            fmove.x (-$D8,A6),FP0
            fsub.x  (-$CC,A6),FP0
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            lea     (-$10C,A6),A0
            fmove.x FP0,(-$10C,A6)
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            moveq   #0,D0
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   round
            bfclr   (-$10A,A6){0:8}
            beq.w   .L87
            bset    #7,(-$10C,A6)
            bra.w   .L87
.L69:
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L72
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            eori.w  #$8000,(-$CC,A6)
            tst.w   (-$CC,A6)
            bgt.b   .L70
            ori.l   #$8000000,(-$7C,A6)
.L70:
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            bsr.w   round
            bfclr   (-$CA,A6){0:8}
            beq.b   .L71
            bset    #7,(-$CC,A6)
.L71:
            lea     (-$10C,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bra.b   .L74
.L72:
            lea     (-$D8,A6),A0
            move.l  (-$80,A6),D0
            andi.l  #$30,D0
            lsr.l   #4,D0
            move.l  (-$80,A6),D1
            andi.l  #$C0,D1
            lsr.l   #6,D1
            swap    D1
            or.l    D0,D1
            move.l  #$20000000,D0
            bclr    #7,(-$D8,A6)
            sne     (-$D6,A6)
            bsr.w   round
            bfclr   (-$D6,A6){0:8}
            beq.b   .L73
            bset    #7,(-$D8,A6)
.L73:
            lea     (-$10C,A6),A0
            move.l  (-$D8,A6),(A0)
            move.l  (-$D4,A6),(4,A0)
            move.l  (-$D0,A6),(8,A0)
            tst.w   (-$D8,A6)
            bgt.b   .L74
            ori.l   #$8000000,(-$7C,A6)
.L74:
            move.w  (-$10C,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$7FFF,D0
            bne.w   .L87
            ori.l   #$2001048,(-$7C,A6)
            clr.l   (4,A0)
            bra.w   .L87
.L75:
            cmpi.b  #$FF,(-$4A,A6)
            beq.w   .L28
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L76
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E8,A6)
            bne.w   .L28
            tst.w   (-$CC,A6)
            bge.b   .L77
            rts
.L76:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            sub.l   D1,D0
            cmpi.l  #$8000,D0
            blt.w   .L28
            btst    #6,(-$E0,A6)
            bne.w   .L28
            tst.w   (-$D8,A6)
            blt.b   .L77
            rts
.L77:
            ori.l   #$8000000,(-$7C,A6)
            rts
.L78:
            cmpi.b  #$FF,(-$4A,A6)
            beq.b   .L80
            cmpi.b  #$F,(-$4A,A6)
            bne.b   .L79
            bfextu  (-$CC,A6){1:15},D0
            bfexts  (-$D8,A6){1:15},D1
            add.l   D1,D0
            bgt.w   .L28
            btst    #5,(-$E8,A6)
            bne.w   .L28
            bra.b   .L80
.L79:
            bfextu  (-$D8,A6){1:15},D0
            bfexts  (-$CC,A6){1:15},D1
            add.l   D1,D0
            bgt.w   .L28
            btst    #5,(-$E0,A6)
            bne.w   .L28
.L80:
            bclr    #2,(-$DC,A6)
            ori.l   #$A28,(-$7C,A6)
            clr.w   (-$EC,A6)
            clr.b   (-$10A,A6)
            move.w  (-$CC,A6),D0
            move.w  (-$D8,A6),D1
            eor.w   D1,D0
            andi.w  #$8000,D0
            beq.b   .L81
            st      (-$10A,A6)
.L81:
            lea     (-$10C,A6),A0
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L83
            btst    #2,D0
            bne.b   .L82
            moveq   #1,D0
            bra.b   .L84
.L82:
            moveq   #2,D0
            bra.b   .L84
.L83:
            bfextu  (-$7D,A6){0:2},D0
.L84:
            bsr.w   sub_40890720
            tst.w   (A0)
            beq.b   .L86
            tst.l   (4,A0)
            bne.b   .L85
            tst.l   (8,A0)
            bne.b   .L85
            clr.w   (A0)
            bra.b   .L86
.L85:
            bsr.w   sub_4088FCF8
.L86:
            bfclr   (-$10A,A6){0:8}
            beq.b   .L92
            bset    #7,(-$10C,A6)
            bra.b   .L92
.L87:
            move.w  (-$E4,A6),D0
            btst    #6,D0
            beq.b   .L89
            btst    #2,D0
            bne.b   .L88
            moveq   #1,D0
            bra.b   .L90
.L88:
            moveq   #2,D0
            bra.b   .L90
.L89:
            bfextu  (-$7D,A6){0:2},D0
            tst.b   D0
            beq.b   .L92
.L90:
            bclr    #7,(-$10C,A6)
            sne     (-$10A,A6)
            bsr.w   sub_408904E2
            bfclr   (-$10A,A6){0:8}
            beq.b   .L91
            bset    #7,(-$10C,A6)
.L91:
            ori.l   #$1248,(-$7C,A6)
.L92:
            bfextu  (-$E4,A6){6:3},D0
            cmpi.b  #3,D0
            ble.b   .L93
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x (-$10C,A6),D0
            rts
.L93:
            cmpi.b  #0,D0
            beq.b   .L96
            cmpi.b  #1,D0
            beq.b   .L95
            cmpi.b  #2,D0
            beq.b   .L94
            move.l  (-$10C,A6),(-$8C,A6)
            move.l  (-$108,A6),(-$88,A6)
            move.l  (-$104,A6),(-$84,A6)
            rts
.L94:
            move.l  (-$10C,A6),(-$98,A6)
            move.l  (-$108,A6),(-$94,A6)
            move.l  (-$104,A6),(-$90,A6)
            rts
.L95:
            move.l  (-$10C,A6),(-$A4,A6)
            move.l  (-$108,A6),(-$A0,A6)
            move.l  (-$104,A6),(-$9C,A6)
            rts
.L96:
            move.l  (-$10C,A6),(-$B0,A6)
            move.l  (-$108,A6),(-$AC,A6)
            move.l  (-$104,A6),(-$A8,A6)
            rts
.L97:
            btst    #6,(-$7A,A6)
            beq.b   .L99
            btst    #6,(-$7E,A6)
            beq.b   .L99
            move.l  (-$CC,A6),(-$D8,A6)
            tst.b   (-$CC,A6)
            blt.b   .L98
            rts
.L98:
            ori.l   #3,(-$7C,A6)
            rts
.L99:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$40,D0
            bne.b   .L100
            ori.l   #$2000000,(-$7C,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L102
.L100:
            cmpi.b  #$60,D0
            bne.b   .L101
            ori.l   #$1000000,(-$7C,A6)
            move.l  (-$CC,A6),(-$D8,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L102
.L101:
            cmpi.b  #$20,D0
            bne.b   .L102
            ori.l   #$4000000,(-$7C,A6)
            tst.w   (A0)
            bge.b   .L102
            ori.l   #$8000000,(-$7C,A6)
.L102:
            bfextu  (-$E4,A6){6:3},D0
            cmpi.b  #3,D0
            ble.b   .L103
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x (-$CC,A6),D0
            rts
.L103:
            cmpi.b  #0,D0
            beq.b   .L106
            cmpi.b  #1,D0
            beq.b   .L105
            cmpi.b  #2,D0
            beq.b   .L104
            move.l  (-$CC,A6),(-$8C,A6)
            move.l  (-$C8,A6),(-$88,A6)
            move.l  (-$C4,A6),(-$84,A6)
            rts
.L104:
            move.l  (-$CC,A6),(-$98,A6)
            move.l  (-$C8,A6),(-$94,A6)
            move.l  (-$C4,A6),(-$90,A6)
            rts
.L105:
            move.l  (-$CC,A6),(-$A4,A6)
            move.l  (-$C8,A6),(-$A0,A6)
            move.l  (-$C4,A6),(-$9C,A6)
            rts
.L106:
            move.l  (-$CC,A6),(-$B0,A6)
            move.l  (-$C8,A6),(-$AC,A6)
            move.l  (-$C4,A6),(-$A8,A6)
            rts
.L107:
            st      (-$46,A6)
            move.w  (-$E4,A6),D0
            andi.w  #$C00,D0
            cmpi.w  #$C00,D0
            beq.w   set_xop.L4
            bra.b   .L109
.L108:
            dc.l    $007A02B0,$02960020,$010C02DE,$018A0020
.L109:
            bfextu  (-$E4,A6){3:3},D1
            lea     .L108,A0
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
mvout_end:
            btst    #1,(-$7A,A6)
            beq.b   .L1
            btst    #3,(-$7A,A6)
            beq.b   .L1
            bset    #5,(-$79,A6)
.L1:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            fmove.l #0,FPSR
            bfclr   (-$CA,A6){0:8}
            beq.b   .L2
            bset    #7,(-$CC,A6)
.L2:
            rts
sub_4088F5EC:
            clr.w   (-$EC,A6)
            bclr    #2,(-$DC,A6)
            fmove.l #0,FPSR
            bfclr   (-$CA,A6){0:8}
            beq.b   .L1
            bset    #7,(-$CC,A6)
.L1:
            rts
            moveq   #4,D0
            btst    #7,(-$E8,A6)
            bne.w   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.d  #"$41DFFFFFFFC00000",FP0
            fbge.w  .L2
            fcmp.d  #"$C1E0000000000000",FP0
            fble.w  .L3
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.l FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.w   .L12
.L2:
            move.l  #$7FFFFFFF,(-$54,A6)
            fbeq.w  .L12
            fcmp.d  #"$41DFFFFFFFE00000",FP0
            fbge.w  .L11
            bra.w   .L10
.L3:
            move.l  #$80000000,(-$54,A6)
            fbeq.w  .L12
            fcmp.d  #"$C1E0000000100000",FP0
            fblt.w  .L11
            bra.w   .L10
            moveq   #2,D0
            btst    #7,(-$E8,A6)
            bne.w   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.s  #"$46FFFE00",FP0
            fbge.w  .L4
            fcmp.s  #"$C7000000",FP0
            fble.w  .L5
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.w FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.w   .L12
.L4:
            move.w  #$7FFF,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$46FFFF00",FP0
            fbge.w  .L11
            bra.w   .L10
.L5:
            move.w  #$8000,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$C7000080",FP0
            fblt.w  .L11
            bra.w   .L10
            moveq   #1,D0
            btst    #7,(-$E8,A6)
            bne.b   .L8
            fmovem.x (-$CC,A6),FP0
            fcmp.s  #"$42FE0000",FP0
            fbge.w  .L6
            fcmp.s  #"$C3000000",FP0
            fble.w  .L7
            move.l  (-$80,A6),D1
            andi.l  #$30,D1
            fmove.l D1,FPCR
            fmove.b FP0,(-$54,A6)
            fmove.l FPSR,D1
            or.l    D1,(-$7C,A6)
            bra.b   .L12
.L6:
            move.b  #$7F,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$42FF0000",FP0
            fbge.w  .L11
            bra.b   .L10
.L7:
            move.b  #$80,(-$54,A6)
            fbeq.w  .L12
            fcmp.s  #"$C3008000",FP0
            fblt.w  .L11
            bra.b   .L10
.L8:
            clr.l   (-$54,A6)
            bfextu  (-$7D,A6){2:2},D1
            cmpi.b  #2,D1
            bmi.b   .L10
            bne.b   .L9
            tst.w   (-$CC,A6)
            bpl.b   .L10
            move.l  #$FFFFFFFF,(-$54,A6)
            bra.b   .L10
.L9:
            tst.w   (-$CC,A6)
            bmi.b   .L10
            lea     (-$54,A6),A1
            adda.l  D0,A1
            subq.l  #1,A1
            bset    #0,(A1)
.L10:
            ori.l   #$208,(-$7C,A6)
            bra.b   .L12
.L11:
            fmovem.x FP0,(-$D8,A6)
            ori.l   #$2080,(-$7C,A6)
.L12:
            movea.l ($C,A6),A1
            tst.l   A1
            beq.b   .L13
            lea     (-$54,A6),A0
            bsr.w   sub_4088D248
            bra.w   sub_4088F5EC
.L13:
            move.l  D0,D1
            movea.l (-$78,A6),A0
            sub.l   D0,D0
            move.w  (A0),D0
            andi.w  #7,D0
            cmpi.l  #4,D1
            beq.b   .L14
            cmpi.l  #2,D1
            bne.b   .L15
            ori.l   #8,D0
            bra.b   .L15
.L14:
            ori.l   #$10,D0
.L15:
            move.l  D0,D1
            bsr.w   sub_40890882
            bra.w   sub_4088F5EC
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L19
            moveq   #0,D0
            bra.b   .L16
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L22
            move.w  (A0),D0
            lea     sub_4088E89C.L2,A1
            cmp.w   (A1),D0
            blt.w   .L20
            cmp.w   (2,A1),D0
            bgt.w   .L24
            moveq   #1,D0
            bra.b   .L16
            lea     (-$CC,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            btst    #7,(-$E8,A6)
            bne.w   .L23
            move.w  (A0),D0
            lea     sub_4088E89C.L3,A1
            cmp.w   (A1),D0
            blt.w   .L21
            cmp.w   (2,A1),D0
            bgt.w   .L25
            moveq   #2,D0
.L16:
            bfextu  (-$7D,A6){2:2},D1
            swap    D0
            add.l   D0,D1
            moveq   #0,D0
            bsr.w   round
            movea.l A0,A1
            movea.l ($C,A6),A0
            bfextu  (-$E4,A6){3:3},D1
            cmpi.b  #2,D1
            bgt.b   .L18
            bne.b   .L17
            bsr.w   sub_4088E89C
            bra.w   mvout_end
.L17:
            bsr.w   sub_4088E838
            bra.w   mvout_end
.L18:
            bsr.w   sub_4088E7D4
            bra.w   mvout_end
.L19:
            bsr.w   set_xop
            bset    #4,(-$DF,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E89C
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L20:
            bset    #4,(-$E8,A6)
            cmp.w   (4,A1),D0
            ble.b   .L22
            moveq   #1,D0
            move.l  #$3F81,D1
            bsr.w   sub_4088FA04
            bsr.w   sub_4088E838
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L21:
            bset    #4,(-$E8,A6)
            cmp.w   (4,A1),D0
            ble.b   .L23
            move.l  #$3C01,D1
            moveq   #2,D0
            bsr.w   sub_4088FA04
            bsr.w   sub_4088E7D4
            bset    #3,(-$7A,A6)
            bra.w   mvout_end
.L22:
            move.l  (-$7C,A6),-(SP)
            moveq   #1,D0
            bsr.w   sub_40890720
            move.l  (SP)+,(-$7C,A6)
            moveq   #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E838
            ori.l   #$A28,(-$7C,A6)
            bra.w   mvout_end
.L23:
            move.l  (-$7C,A6),-(SP)
            moveq   #2,D0
            bsr.w   sub_40890720
            move.l  (SP)+,(-$7C,A6)
            moveq   #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E7D4
            ori.l   #$A28,(-$7C,A6)
            bra.w   mvout_end
.L24:
            move.l  (-$7C,A6),-(SP)
            moveq   #1,D0
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bsr.w   sub_408904E2
            move.l  (SP)+,(-$7C,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E838
            ori.l   #$1248,(-$7C,A6)
            bra.w   mvout_end
.L25:
            move.l  (-$7C,A6),-(SP)
            moveq   #2,D0
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            bsr.w   sub_408904E2
            move.l  (SP)+,(-$7C,A6)
            movea.l A0,A1
            movea.l ($C,A6),A0
            bsr.w   sub_4088E7D4
            ori.l   #$1248,(-$7C,A6)
            bra.w   mvout_end
sub_4088FA04:
            move.l  D0,-(SP)
            moveq   #0,D0
            bsr.w   sub_4088FDD0
            bfextu  (-$7D,A6){2:2},D1
            swap    D1
            move.w  (2,SP),D1
            swap    D1
            bsr.w   round
            move.w  #1,D0
            sub.w   D0,(A0)
            movea.l A0,A1
            movea.l ($C,A6),A0
            addq.w  #4,SP
            rts
set_xop:
            move.l  (A0),(-$10C,A6)
            move.l  (4,A0),(-$108,A6)
            move.l  (8,A0),(-$104,A6)
            bfclr   (-$10A,A6){0:8}
            beq.b   .L1
            bset    #7,(-$10C,A6)
.L1:
            bfclr   (-$E8,A6){5:4}
            rts
.L2:
            dc.w    $0042,$0078,$008A,$009C,$0042
.L3:
            dc.l    $009C00A2,$00A800AC,$00B000B4,$00B800BC
.L4:
            lea     .L2,A0
            move.w  (-$E8,A6),D0
            bfextu  D0{16:3},D0
            adda.w  (0,A0,D0.w*2),A0
            jmp     (A0)
sub_4088FA80:
            movea.l ($C,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            clr.b   (-$11C,A6)
            bfclr   (-$E0,A6){0:3}
            rts
            move.w  (-$E4,A6),D0
            btst    #$C,D0
            bne.b   .L1
            movea.l (-$78,A6),A0
            move.l  (A0),D0
            bra.b   .L2
.L1:
            bfextu  D0{25:3},D0
            lea     set_xop.L3,A0
            adda.w  (0,A0,D0.w*2),A0
            jmp     (A0)
.L2:
            andi.w  #$7F,D0
            bfexts  D0{25:7},D0
            lea     (-$CC,A6),A0
            bsr.w   sub_4088FF40
            lea     (-$74,A6),A0
            bra.b   sub_4088FA80
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            bra.b   sub_4088FA80
            fmove.l #0,FPSR
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            bra.b   sub_4088FA80
            lea     (-$CC,A6),A0
            clr.w   (2,A0)
            bra.b   sub_4088FA80
            move.l  (-$C0,A6),D0
            bra.b   .L2
            move.l  (-$BC,A6),D0
            bra.b   .L2
            move.l  D2,D0
            bra.b   .L2
            move.l  D3,D0
            bra.b   .L2
            move.l  D4,D0
            bra.b   .L2
            move.l  D5,D0
            bra.b   .L2
            move.l  D6,D0
            bra.b   .L2
            move.l  D7,D0
            bra.b   .L2
