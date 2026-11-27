.L33:
            move.b  ($1C,A0),(1,A5)
            bra.b   .L36
.L34:
            tst.b   ($348).w
            beq.b   .L35
            bset    #0,(A5)
            bne.b   .L37
            bra.b   .L36
.L35:
            bclr    #0,(A5)
            beq.b   .L37
.L36:
            movea.l A1,A0
            jsr     (MarkBlock.w,PC)
            bsr.w   sub_40810C48
.L37:
            moveq   #0,D0
            bra.w   CmdDone
.L38:
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,(2,A5)
            movem.l ($48,A0),D1-D2
            movem.l D1-D2,($2A,A5)
            bra.b   .L36
.L39:
            movea.l (SP)+,A3
            tst.b   D2
            bne.b   .L40
            moveq   #-$25,D0
            bra.b   .L48
.L40:
            move.w  ($14,A2),D7
            beq.b   .L42
            bsr.w   sub_40811A30
.L41:
            beq.b   .L43
            cmpi.w  #$FFDF,D0
            bne.b   .L48
.L42:
            moveq   #-$2B,D0
            bra.b   .L48
.L43:
            moveq   #0,D0
            movea.l A4,A1
.L44:
            move.w  D0,D4
            tst.b   (0,A5,D4.w)
            beq.b   .L46
            move.b  (1,A5,D4.w),D6
            cmp.b   ($1A,A0),D6
            bne.b   .L45
            move.l  A0,-(SP)
            lea     ($32,A5,D4.w),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.w  D2,D0
            _CmpString
            movea.l (SP)+,A0
            beq.b   .L47
.L45:
            subq.w  #1,D7
            beq.b   .L42
            move.w  D4,D0
            bsr.w   sub_40810C92
            bcs.b   .L44
.L46:
            bsr.w   sub_40811A40
            bra.b   .L41
.L47:
            movea.l A5,A1
            lea     (0,A5,D4.w),A5
.L48:
            jmp     (A3)
.L49:
            cmp.w   ($14,A2),D1
            bhi.b   .L54
            move.w  ($18,A2),D5
            move.w  ($16,A2),D3
            add.w   D3,D5
            move.w  ($5A,A2),D7
            beq.b   .L50
            cmp.w   D7,D1
            bcs.b   .L50
            move.w  ($5C,A2),D3
            bra.b   .L51
.L50:
            moveq   #1,D7
.L51:
            cmp.w   D5,D3
            bcc.b   .L54
            move.w  D3,($5C,A2)
            move.w  D7,($5A,A2)
            bsr.w   sub_40811A50
            bne.b   .L54
            moveq   #0,D0
.L52:
            moveq   #0,D6
            tst.b   (0,A5,D0.w)
            beq.b   .L53
            cmp.w   D7,D1
            beq.b   .L55
            addq.w  #1,D7
            bsr.w   sub_40810C92
            bcs.b   .L52
.L53:
            addq.w  #1,D3
            bra.b   .L51
.L54:
            moveq   #-$2B,D0
            bra.w   CmdDone
.L55:
            lea     (0,A5,D0.w),A5
            lea     ($32,A5),A3
            move.l  ($12,A0),D0
            beq.b   .L57
            movea.l D0,A4
            move.b  (A3),D0
.L56:
            move.b  (A3)+,(A4)+
            subq.b  #1,D0
            bcc.b   .L56
.L57:
            lea     ($1E,A0),A4
            moveq   #$18,D0
            lea     (A5),A3
.L58:
            move.w  (A3)+,(A4)+
            dbra    D0,.L58
            bclr    #4,($1E,A0)
            btst    #0,($376).w
            beq.b   .L60
            move.l  #2,($64,A0)
            clr.l   ($50,A0)
            move.l  A0,-(SP)
            lea     ($54,A0),A0
            moveq   #3,D0
.L59:
            clr.l   (A0)+
            dbra    D0,.L59
            movea.l (SP)+,A0
.L60:
            bra.w   .L23
