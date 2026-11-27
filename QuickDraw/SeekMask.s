XGETSEEK:
            clr.l   (-$84,A6)
sub_4083AF04:
            jmp     ([-$80.w,A6])
ALLOCRUNBUF:
            move.l  (SP)+,D2
            moveq   #0,D1
            move.w  (-$10,A6),D1
            addq.l  #2,D1
            cmpi.w  #5,(-$76,A6)
            beq.b   .L1
            move.l  D1,D0
            add.l   D1,D1
            add.l   D0,D1
.L1:
            lsr.l   #1,D1
            addq.l  #3,D1
            sub.l   D1,(-$84,A6)
            bpl.b   .L2
            bsr.b   sub_4083AF04
.L2:
            lsl.l   #2,D1
            suba.l  D1,SP
            movea.l SP,A0
            addq.w  #4,A0
            jmp     (D2.l)
            ds.b    6
GetSeek:
            move.l  (4,SP),D3
            lea     ($C,SP,D3.w*4),A3
            lea     (-$3C,A6),A1
            clr.w   D4
            tst.l   (-$C,A6)
            beq.b   .L1
            jsr     ([$1C50.w])
            move.l  A0,(-$C,A6)
.L1:
            moveq   #$A,D0
            movea.l -(A3),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L4
            cmpi.w  #2,D3
            beq.b   .L2
            move.l  (A3),-(SP)
            pea     (-$74,A6)
            clr.w   -(SP)
            jsr     ([$1AA4.w])
            blt.b   XGETSEEK
            beq.b   .L4
            movea.l (A3),A0
            movea.l (A0),A0
.L2:
            addq.w  #1,D4
            add.w   D4,D4
            move.w  (-$6E,A6),D1
            move.w  (-$E,A6),D2
            moveq   #0,D0
            move.w  D1,D0
            sub.w   D2,D0
            lsr.w   #5,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L3
            bsr.w   sub_4083AF04
.L3:
            move.w  (-$72,A6),D0
            jsr     ([$1C54.w])
            suba.w  #$18,A1
.L4:
            dbra    D3,.L1
            tst.l   (-$20,A6)
            beq.b   .L6
            addq.w  #1,D4
            move.w  D4,(-2,A6)
            cmpi.w  #1,D4
            bgt.b   .L11
            move.w  (-$6E,A6),D1
            move.w  (-$E,A6),D2
            moveq   #0,D0
            move.w  D1,D0
            sub.w   D2,D0
            lsr.w   #5,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L5
            bsr.w   sub_4083AF04
.L5:
            move.w  (-$72,A6),D0
            jsr     ([$1C54.w])
            moveq   #0,D0
            movea.l (-$34,A6),A0
            bra.b   .L8
.L6:
            move.w  (-$76,A6),D0
            tst.l   (-$C,A6)
            beq.b   .L7
            moveq   #0,D0
.L7:
            move.w  D4,(-2,A6)
            bne.b   .L9
            movea.l (-8,A6),A0
.L8:
            move.w  (-$72,A6),D3
            sub.w   (-$E,A6),D3
            move.w  (-$6E,A6),D4
            sub.w   (-$E,A6),D4
            jsr     ([$1AA8.w])
            bra.b   .L11
.L9:
            tst.w   D0
            bne.b   .L10
            cmpi.w  #2,D4
            bne.b   .L11
            move.l  (-8,A6),(-$34,A6)
            bra.b   .L11
.L10:
            ori.w   #1,(-2,A6)
.L11:
            move.w  (-$76,A6),D0
            movea.l ($1C8C).w,A0
            adda.l  (0,A0,D0.w*4),A0
            move.l  A0,(-$18,A6)
            tst.l   (-$C,A6)
            beq.b   .L12
            moveq   #0,D0
.L12:
            suba.l  A0,A0
            subq.l  #8,A3
            movea.l (A3),A1
            move.w  (-2,A6),D1
            move.w  D0,D2
            or.w    D1,D2
            beq.b   .L13
            movea.l ($1C90).w,A0
            adda.l  (0,A0,D0.w*4),A0
.L13:
            move.l  A0,(-$14,A6)
            movea.l ($1C94).w,A0
            cmpi.w  #7,D1
            ble.b   .L14
            subi.w  #$A,D1
.L14:
            adda.l  (0,A0,D1.w*4),A0
            move.l  A0,(-$1C,A6)
            jmp     (A1)
GSRUNTBL:
            dc.w    0,$03AC,0,$043C,0,$04FC,0,$059C
            dc.w    0,$07DC,0,$091C
GSEXPTBL:
            dc.w    0,$02D4,0,$02E4,0,$0324,0,$0344
            dc.w    0,$0364,0,$0384
gsSeekTbl:
            dc.l    SEEKOK-gsSeekTbl
            dc.l    RECTMASK-gsSeekTbl
            dc.l    A-gsSeekTbl
            dc.l    AX-gsSeekTbl
            dc.w    0,$01EC,0,$01EC,0,$010C,0,$010C
SEEKOK:
            move.w  #$7FFF,D2
            rts
            ds.b    6
RECTMASK:
            movem.l D3-D5/A4-A6,-(SP)
            movea.l (-$34,A6),A1
            move.l  (-$20,A6),D0
            move.w  (-$30,A6),D1
            move.l  (-$24,A6),D5
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     RETRECTM,A5
            movea.l D0,A6
            moveq   #0,D2
RECTMLOOP:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A1)+,D0
            jmp     (A4)
RETRECTM:
            dbra    D1,RECTMLOOP
            movem.l (SP)+,D3-D5/A4-A6
.L1:
            moveq   #1,D2
            rts
            ds.b    6
A:
            lea     (-$3C,A6),A1
            move.w  (-4,A6),D0
            jmp     SeekRgn
AX:
            move.w  (-4,A6),D0
            cmp.w   (-$2C,A6),D0
            bge.b   .L1
            cmp.w   (-$2E,A6),D0
            blt.b   .L2
            tst.l   (-$20,A6)
            beq.b   RETRECTM.L1
.L88:
            movea.l (-$34,A6),A1
            move.w  (-$30,A6),D1
            bra.b   .L87
.L1:
            lea     (-$3C,A6),A1
            jsr     SEEKDOWN
            bra.b   .L88
.L2:
            lea     (-$3C,A6),A1
            jsr     SEEKUP
            bra.b   .L88
.L87:
            move.l  (-$20,A6),D0
            bne.b   .L89
            movem.l D2-D4/A4-A5,-(SP)
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     .L4,A5
            moveq   #0,D2
.L3:
            move.l  (A1)+,D0
            jmp     (A4)
.L4:
            dbra    D1,.L3
            movem.l (SP)+,D2-D4/A4-A5
            rts
.L89:
            movem.l D3-D5/A4-A6,-(SP)
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     .L6,A5
            move.l  (-$24,A6),D5
            movea.l D0,A6
            moveq   #0,D2
.L5:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A1)+,D0
            jmp     (A4)
.L6:
            dbra    D1,.L5
            movem.l (SP)+,D3-D5/A4-A6
            moveq   #1,D2
            rts
            ds.b    12
            move.w  (-4,A6),D0
            lea     (-$3C,A6),A1
            bsr.b   .L90
            move.w  D2,-(SP)
            lea     (-$54,A6),A1
            bsr.b   .L90
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L91
            move.w  D1,D2
.L91:
            movea.l (-$34,A6),A2
            movea.l (-$4C,A6),A1
            move.w  (-$30,A6),D1
            movea.l (-8,A6),A0
            move.l  (-$14,A6),D0
            bne.b   .L92
.L94:
            move.l  (-$20,A6),D0
            bne.b   .L93
            move.l  (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L94
            rts
.L93:
            movem.l D5/A6,-(SP)
            move.l  (-$24,A6),D5
            movea.l D0,A6
.L7:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L7
            movem.l (SP)+,D5/A6
            moveq   #1,D2
            rts
.L90:
            cmp.w   ($10,A1),D0
            bge.w   SEEKDOWN
            cmp.w   ($E,A1),D0
            blt.w   SEEKUP
            move.w  ($10,A1),D2
            sub.w   D0,D2
            tst.l   (-$7C,A6)
            bpl.b   .L8
            move.w  D0,D2
            sub.w   ($E,A1),D2
            addq.w  #1,D2
.L8:
            rts
.L92:
            movem.l D2-D5/A4-A6,-(SP)
            move.l  (-$20,A6),D2
            bne.b   .L11
            movea.l D0,A4
            lea     .L10,A5
            moveq   #0,D2
.L9:
            move.l  (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L10:
            dbra    D1,.L9
            movem.l (SP)+,D2-D5/A4-A6
            rts
.L11:
            movea.l D0,A4
            lea     .L13,A5
            move.l  (-$24,A6),D5
            movea.l D2,A6
            moveq   #0,D2
.L12:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L13:
            dbra    D1,.L12
            movem.l (SP)+,D2-D5/A4-A6
            moveq   #1,D2
            rts
            ds.b    14
            move.w  (-4,A6),D0
            lea     (-$3C,A6),A1
            bsr.w   .L90
            move.w  D2,-(SP)
            lea     (-$54,A6),A1
            bsr.w   .L90
            move.w  D2,-(SP)
            lea     (-$6C,A6),A1
            bsr.w   .L90
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L95
            move.w  D1,D2
.L95:
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L96
            move.w  D1,D2
.L96:
            movea.l (-$34,A6),A3
            movea.l (-$4C,A6),A2
            movea.l (-$64,A6),A1
            movea.l (-8,A6),A0
            move.w  (-$60,A6),D1
            move.l  (-$14,A6),D0
            bne.w   .L97
            move.l  (-$20,A6),D0
            bne.b   .L98
.L99:
            move.l  (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L99
            rts
.L98:
            movem.l D5/A6,-(SP)
            move.l  (-$24,A6),D5
            movea.l D0,A6
.L14:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L14
            movem.l (SP)+,D5/A6
            moveq   #1,D2
            rts
.L97:
            movem.l D2-D5/A4-A6,-(SP)
            move.l  (-$20,A6),D2
            bne.b   .L17
            movea.l D0,A4
            lea     .L16,A5
            moveq   #0,D2
.L15:
            move.l  (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L16:
            dbra    D1,.L15
            movem.l (SP)+,D2-D5/A4-A6
            rts
.L17:
            movea.l D0,A4
            lea     .L19,A5
            move.l  (-$24,A6),D5
            movea.l D2,A6
            moveq   #0,D2
.L18:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L19:
            dbra    D1,.L18
            movem.l (SP)+,D2-D5/A4-A6
            moveq   #1,D2
            rts
            move.l  D0,(A0)+
            RTS5
            ds.b    12
            move.l  A5,-(SP)
            lea     TABLE2,A5
            clr.w   D2
            move.b  D0,D2
            move.w  (0,A5,D2.w*2),D4
            swap    D0
            move.b  D0,D2
            move.w  (0,A5,D2.w*2),D3
            lsr.l   #8,D0
            move.b  D0,D2
            swap    D3
            move.w  (0,A5,D2.w*2),D3
            swap    D3
            swap    D0
            move.b  D0,D2
            swap    D4
            move.w  (0,A5,D2.w*2),D4
            swap    D4
            move.l  D3,(A0)+
            move.l  D4,(A0)+
            movea.l (SP)+,A5
            RTS5
            ds.b    10
            moveq   #3,D3
.L100:
            rol.l   #8,D0
            move.b  D0,D2
            move.l  (TABLE4.w,PC,D2.w*4),(A0)+
            dbra    D3,.L100
            RTS5
            ds.b    14
            moveq   #3,D3
.L101:
            rol.l   #8,D0
            move.b  D0,D2
            lsr.w   #4,D2
            move.l  (.L79.w,PC,D2.w*4),(A0)+
            moveq   #$F,D2
            and.w   D0,D2
            move.l  (.L79.w,PC,D2.w*4),(A0)+
            dbra    D3,.L101
            RTS5
            dc.w    0
            moveq   #$F,D3
.L102:
            add.l   D0,D0
            subx.l  D2,D2
            add.l   D0,D0
            subx.w  D2,D2
            move.l  D2,(A0)+
            dbra    D3,.L102
            RTS5
            ds.b    14
            moveq   #$1F,D3
.L103:
            add.l   D0,D0
            subx.l  D2,D2
            move.l  D2,(A0)+
            dbra    D3,.L103
            RTS5
            dc.w    0
            movea.l (-8,A6),A0
            movem.l D1/D3-D6,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            move.l  (A0)+,D0
            move.w  (-$78,A6),D6
            bpl.b   .L20
            moveq   #0,D0
            move.w  D5,D0
            asl.l   #2,D0
            adda.l  D0,A0
            move.l  D0,D3
            move.l  -(A0),D0
            adda.w  D6,A0
            bra.b   .L21
.L20:
            moveq   #0,D3
.L21:
            tst.l   D0
            beq.b   .L28
.L22:
            cmp.l   D1,D0
            beq.b   .L30
            movea.l A2,A1
            addq.w  #4,A2
            bra.b   .L24
.L23:
            move.l  (A0),D0
            adda.w  D6,A0
            beq.b   .L25
            cmp.l   D1,D0
            beq.b   .L25
            add.l   D4,D3
.L24:
            move.l  D0,(A2)+
            dbra    D5,.L23
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L31
.L25:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L20
.L26:
            move.l  D3,(A2)+
            bra.b   .L20
.L27:
            move.l  (A0),D0
            adda.w  D6,A0
            bne.b   .L22
.L28:
            add.w   D6,D3
            dbra    D5,.L27
            bra.b   .L31
.L29:
            move.l  (A0),D0
            adda.w  D6,A0
            cmp.l   D1,D0
            bne.b   .L26
            add.l   D4,D3
.L30:
            dbra    D5,.L29
            move.l  D3,(A2)+
.L31:
            move.l  D1,(A2)
            movem.l (SP)+,D1/D3-D6
            rts
            ds.b    6
            dc.w    $206E,$FFF8
            movem.l D1-D7/A3-A5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     TABLE2,A4
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            movea.l D4,A5
            moveq   #$F,D4
            moveq   #0,D6
            move.w  (A0)+,D0
            move.w  (-$78,A6),D2
            movea.w D2,A3
            asr.w   #1,D2
            bpl.b   .L32
            addq.w  #2,D5
            andi.w  #$FFFE,D5
            moveq   #0,D0
            move.w  D5,D0
            add.l   D0,D0
            adda.l  D0,A0
            add.l   D0,D0
            move.l  D0,D3
            move.w  -(A0),D0
            subq.w  #2,A0
            bra.b   .L33
.L32:
            moveq   #0,D3
            tst.w   D0
.L33:
            beq.b   .L40
.L34:
            cmp.w   D1,D0
            beq.b   .L42
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L36
.L35:
            move.w  (A0),D0
            adda.w  D2,A0
            beq.b   .L37
            cmp.w   D1,D0
            beq.b   .L37
            add.l   A5,D3
.L36:
            move.b  D0,D6
            move.w  (0,A4,D6.w*2),D7
            swap    D7
            rol.w   #8,D0
            move.b  D0,D6
            move.w  (0,A4,D6.w*2),D7
            swap    D7
            move.l  D7,(A2)+
            dbra    D5,.L35
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L43
.L37:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L32
.L38:
            move.l  D3,(A2)+
            bra.b   .L32
.L39:
            move.w  (A0),D0
            adda.w  D2,A0
            bne.b   .L34
.L40:
            add.w   A3,D3
            dbra    D5,.L39
            bra.b   .L43
.L41:
            move.w  (A0),D0
            adda.w  D2,A0
            cmp.w   D1,D0
            bne.b   .L38
            add.l   A5,D3
.L42:
            dbra    D5,.L41
            move.l  D3,(A2)+
.L43:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D7/A3-A5
            rts
            ds.b    14
            dc.w    $206E,$FFF8
            movem.l D1-D7/A3-A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     TABLE4,A4
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            moveq   #0,D6
            move.b  (A0)+,D0
            move.w  (-$78,A6),D2
            movea.w D2,A3
            asr.w   #2,D2
            bpl.b   .L44
            addq.w  #4,D5
            andi.w  #$FFFC,D5
            moveq   #0,D0
            move.w  D5,D0
            adda.l  D0,A0
            lsl.l   #2,D0
            move.l  D0,D3
            move.b  -(A0),D0
            subq.w  #1,A0
            bra.b   .L45
.L44:
            moveq   #0,D3
            tst.b   D0
.L45:
            beq.b   .L52
.L46:
            cmp.b   D1,D0
            beq.b   .L54
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L48
.L47:
            move.b  (A0),D0
            adda.w  D2,A0
            beq.b   .L49
            cmp.b   D1,D0
            beq.b   .L49
            add.l   D4,D3
.L48:
            move.b  D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L47
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L55
.L49:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L44
.L50:
            move.l  D3,(A2)+
            bra.b   .L44
.L51:
            move.b  (A0),D0
            adda.w  D2,A0
            bne.b   .L46
.L52:
            add.w   A3,D3
            dbra    D5,.L51
            bra.b   .L55
.L53:
            move.b  (A0),D0
            adda.w  D2,A0
            cmp.b   D1,D0
            bne.b   .L50
            add.l   D4,D3
.L54:
            dbra    D5,.L53
            move.l  D3,(A2)+
.L55:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D7/A3-A4
            rts
            dc.w    0,$4A6E,$FF88,$6B00,$009A,$206E,$FFF8
            movem.l D1-D6/A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     .L79,A4
            lsr.w   #1,D5
            moveq   #-1,D1
            moveq   #2,D4
            swap    D4
            moveq   #0,D6
            move.l  #$10000,D2
            move.b  (A0)+,D0
.L56:
            move.l  D2,D3
            tst.b   D0
            beq.b   .L63
.L57:
            cmp.b   D1,D0
            beq.b   .L65
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L59
.L58:
            move.b  (A0)+,D0
            beq.b   .L60
            cmp.b   D1,D0
            beq.b   .L60
            add.l   D4,D3
.L59:
            move.b  D0,D6
            lsr.w   #4,D6
            move.l  (0,A4,D6.w*4),(A2)+
            moveq   #$F,D6
            and.w   D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L58
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L66
.L60:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L56
.L61:
            move.l  D3,(A2)+
            bra.b   .L56
.L62:
            move.b  (A0)+,D0
            bne.b   .L57
.L63:
            addq.w  #8,D3
            dbra    D5,.L62
            bra.b   .L66
.L64:
            move.b  (A0)+,D0
            cmp.b   D1,D0
            bne.b   .L61
            add.l   D4,D3
.L65:
            dbra    D5,.L64
            move.l  D3,(A2)+
.L66:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D6/A4
            rts
            ds.b    14
            dc.w    $206E,$FFF8
            movem.l D1-D6/A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     .L79,A4
            moveq   #-1,D1
            moveq   #2,D4
            swap    D4
            moveq   #0,D6
            move.l  #$10000,D2
            move.l  D2,D3
            addq.w  #8,D5
            andi.w  #$FFF8,D5
            move.w  D5,D3
            asr.w   #1,D3
            adda.w  D3,A0
            lsl.w   #3,D3
            subq.w  #1,D5
            subq.w  #4,D3
            lsr.w   #1,D5
            move.b  -(A0),D0
            bra.b   .L68
.L67:
            move.l  D2,D3
.L68:
            tst.b   D0
            beq.b   .L75
.L69:
            cmp.b   D1,D0
            beq.b   .L77
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L71
.L70:
            move.b  -(A0),D0
            beq.b   .L72
            cmp.b   D1,D0
            beq.b   .L72
            add.l   D4,D3
.L71:
            moveq   #$F,D6
            and.w   D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            move.b  D0,D6
            lsr.w   #4,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L70
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L78
.L72:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L67
.L73:
            move.l  D3,(A2)+
            bra.b   .L67
.L74:
            move.b  -(A0),D0
            bne.b   .L69
.L75:
            subq.w  #8,D3
            dbra    D5,.L74
            bra.b   .L78
.L76:
            move.b  -(A0),D0
            cmp.b   D1,D0
            bne.b   .L73
            add.l   D4,D3
.L77:
            dbra    D5,.L76
            move.l  D3,(A2)+
.L78:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D6/A4
            rts
.L79:
            ds.b    7
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
.L104:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #1,D4
            swap    D4
            moveq   #1,D0
            ror.l   #1,D0
            moveq   #0,D3
.L80:
            add.l   D0,D0
            bcc.b   .L81
            bne.b   .L83
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcs.b   .L83
.L81:
            add.l   D0,D0
            bcc.b   .L82
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump01
.L82:
            addq.w  #4,D3
            dbra    D5,.L80
            bra.b   endRun16
.L83:
            add.l   D0,D0
            bcs.b   .goBlit
.L84:
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump10
.L85:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .L82
.L86:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .goBlit
.chkMask0:
            add.l   D0,D0
            bcc.b   .L85
            add.l   D4,D3
.dump01:
            move.l  #$FFFF,(A2)+
            bra.b   .nextMask
.mask1:
            add.l   D0,D0
            bcc.b   .chkMask0
            bne.b   .chkMask1
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .chkMask0
.chkMask1:
            add.l   D0,D0
            bcs.b   .L86
            add.l   D4,D3
.dump10:
            move.l  #$FFFF0000,(A2)+
.nextMask:
            dbra    D5,.mask1
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   endRun16
.dumpBlitS:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .L81
.dumpBlitM:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .L84
.blit1:
            add.l   D0,D0
            bcc.b   .dumpBlitS
            bne.b   .chkBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .dumpBlitS
.chkBlit:
            add.l   D0,D0
            bcc.b   .dumpBlitM
            add.l   D4,D3
.goBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
endRun16:
            moveq   #-1,D3
            move.l  D3,(A2)
            movem.l (SP)+,D3-D5
            rts
            ds.b    10
RUN16:
            lea     AX.L104(PC),A0
            move.l  A0,(-$18,A6)
            tst.w   (-$78,A6)
            bpl.w   AX.L104
            lea     .L1,A0
            move.l  A0,(-$18,A6)
.L1:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            addi.w  #$10,D5
            andi.w  #$FFF0,D5
            moveq   #1,D4
            swap    D4
            move.w  D5,D3
            ext.l   D3
            asr.w   #2,D3
            adda.w  D3,A0
            lsl.w   #4,D3
            subq.w  #1,D5
            subq.w  #4,D3
            moveq   #1,D0
.skip1:
            lsr.l   #1,D0
            bcc.b   .chkSkip
            bne.b   .BlitOrMask
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcs.b   .BlitOrMask
.chkSkip:
            lsr.l   #1,D0
            bcc.b   .cntSkip
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump01
.cntSkip:
            subq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun16
.BlitOrMask:
            lsr.l   #1,D0
            bcs.b   .goBlit
.first10:
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump10
.dumpMaskS:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .cntSkip
.dumpMaskB:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .goBlit
.chkMask0:
            lsr.l   #1,D0
            bcc.b   .dumpMaskS
            add.l   D4,D3
.dump01:
            move.l  #$FFFF0000,(A2)+
            bra.b   .nextMask
.mask1:
            lsr.l   #1,D0
            bcc.b   .chkMask0
            bne.b   .chkMask1
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .chkMask0
.chkMask1:
            lsr.l   #1,D0
            bcs.b   .dumpMaskB
            add.l   D4,D3
.dump10:
            move.l  #$FFFF,(A2)+
.nextMask:
            dbra    D5,.mask1
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.w   endRun16
.dumpBlitS:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .chkSkip
.dumpBlitM:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .first10
.blit1:
            lsr.l   #1,D0
            bcc.b   .dumpBlitS
            bne.b   .chkBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .dumpBlitS
.chkBlit:
            lsr.l   #1,D0
            bcc.b   .dumpBlitM
            add.l   D4,D3
.goBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
            bra.w   endRun16
            ds.b    4
Forwards32:
            dc.w    $206E,$FFF8
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #1,D4
            swap    D4
            moveq   #1,D0
            ror.l   #1,D0
            moveq   #0,D3
.skip1:
            add.l   D0,D0
            bcc.b   .cntSkip
            bne.b   .cntBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcs.b   .cntBlit
.cntSkip:
            addq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun32
.goSkip:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .cntSkip
.blit1:
            add.l   D0,D0
            bcc.b   .goSkip
            bne.b   .goBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .goSkip
.goBlit:
            add.l   D4,D3
.cntBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
endRun32:
            moveq   #-1,D3
            move.l  D3,(A2)
            movem.l (SP)+,D3-D5
            rts
            ds.b    14
RUN32:
            lea     Forwards32,A0
            move.l  A0,(-$18,A6)
            tst.w   (-$78,A6)
            bpl.b   Forwards32
            lea     .L1,A0
            move.l  A0,(-$18,A6)
.L1:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            addi.w  #$20,D5
            andi.w  #$FFE0,D5
            moveq   #1,D4
            swap    D4
            move.w  D5,D3
            ext.l   D3
            asr.w   #3,D3
            adda.w  D3,A0
            lsl.w   #5,D3
            subq.w  #1,D5
            subq.w  #4,D3
            moveq   #1,D0
.skip1:
            lsr.l   #1,D0
            bcc.b   .cntSkip
            bne.b   .cntBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcs.b   .cntBlit
.cntSkip:
            subq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun32
.goSkip:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .cntSkip
.blit1:
            lsr.l   #1,D0
            bcc.b   .goSkip
            bne.b   .goBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .goSkip
.goBlit:
            add.l   D4,D3
.cntBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
            bra.w   endRun32
            ds.b    12
