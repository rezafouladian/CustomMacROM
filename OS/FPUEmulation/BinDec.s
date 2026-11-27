.L15:
            dc.l    $3FFD0000,$9A209A84,$FBCFF798,$00000000 ; label changed <1/2/91, JPO>
.L16:
            dc.l    $3FFD0000,$9A209A84,$FBCFF799,$00000000
.L17:
            dc.l    $00000000,$03030202,$03020203,$02030302
sub_4088FF40:
            movem.l D2-D7/A2,-(SP)
            fmovem.x FP0-FP2,-(SP)
            fmove.l #$20,FPCR
            move.l  (A0),(-$50,A6)
            move.l  D0,D7
            clr.b   (-$4B,A6)
            move.w  (-$E8,A6),D0
            andi.w  #$E000,D0
            beq.b   .L3
            move.w  (A0),D0
            andi.w  #$7FFF,D0
            move.l  (4,A0),D1
            move.l  (8,A0),D2
.L1:
            subq.w  #1,D0
            lsl.l   #1,D2
            roxl.l  #1,D1
            tst.l   D1
            bge.b   .L1
            tst.w   D0
            bgt.b   .L2
            st      (-$4B,A6)
.L2:
            andi.w  #$7FFF,D0
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            move.l  D2,(8,A0)
.L3:
            move.l  (A0),(-$64,A6)
            move.l  (4,A0),(-$60,A6)
            move.l  (8,A0),(-$5C,A6)
            andi.l  #$7FFFFFFF,(-$64,A6)
            tst.b   (-$4B,A6)
            beq.b   .L4
            move.l  #$FFFFECBB,D6
            bra.b   .L6
.L4:
            move.w  (-$64,A6),D0
            move.w  #$3FFF,(-$64,A6)
            fmove.x (-$64,A6),FP0
            subi.w  #$3FFF,D0
            fadd.w  D0,FP0
            fsub.b  #1,FP0
            fbge.w  .L5
            fmul.x  sub_4088FDD0.L16,FP0
            fmove.l FP0,D6
            bra.b   .L6
.L5:
            fmul.x  sub_4088FDD0.L15,FP0
            fmove.l FP0,D6
.L6:
            fmove.l #0,FPSR
            clr.w   D5
.L7:
            tst.l   D7
            ble.b   .L8
            move.l  D7,D4
            bra.b   .L9
.L8:
            move.l  D6,D4
            sub.l   D7,D4
            addq.l  #1,D4
.L9:
            tst.l   D4
            ble.b   .L10
            cmpi.l  #$11,D4
            ble.b   .L11
            moveq   #$11,D4
            tst.l   D7
            ble.b   .L11
            ori.l   #$2080,(-$7C,A6)
            bra.b   .L11
.L10:
            moveq   #1,D4
.L11:
            tst.l   D7
            bgt.b   .L12
            cmp.l   D6,D7
            blt.b   .L12
            move.l  D7,D6
.L12:
            move.l  D6,D0
            addq.l  #1,D0
            sub.l   D4,D0
            swap    D5
            clr.w   D5
            clr.w   D2
            tst.l   D0
            bge.b   .L14
            addq.w  #1,D5
            cmpi.l  #$FFFFECD4,D0
            bgt.b   .L13
            addi.l  #$18,D0
            moveq   #$18,D2
.L13:
            neg.l   D0
.L14:
            fmove.b #1,FP1
            bfextu  (-$80,A6){26:2},D1
            lsl.w   #1,D1
            add.w   D5,D1
            lsl.w   #1,D1
            tst.l   (-$50,A6)
            bge.b   .L15
            addq.l  #1,D1
.L15:
            lea     sub_4088FDD0.L17,A2
            move.b  (0,A2,D1.w),D3
            lsl.l   #4,D3
            fmove.l D3,FPCR
            lsr.l   #4,D3
            tst.b   D3
            bne.b   .L16
            lea     sub_408934EA.L8,A1
            bra.b   .L18
.L16:
            lsr.b   #1,D3
            bcc.b   .L17
            lea     sub_408934EA.L12,A1
            bra.b   .L18
.L17:
            lea     sub_408934EA.L10,A1
.L18:
            moveq   #0,D3
.L19:
            lsr.l   #1,D0
            bcc.b   .L20
            fmul.x  (0,A1,D3.w),FP1
.L20:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L19
            fmove.l #0,FPSR
            fmove.l #$10,FPCR
            fmove.x (A0),FP0
            fabs.x  FP0,FP0
            tst.w   D5
            bne.b   .L21
            fdiv.x  FP1,FP0
            bra.b   .L25
.L21:
            tst.b   (-$4B,A6)
            beq.b   .L23
            fmovem.x FP1,-(SP)
            move.l  (8,A0),-(SP)
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            moveq   #$12,D3
.L22:
            clr.l   -(SP)
            dbra    D3,.L22
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.b  #$10,($44,SP)
            move.w  #$23,($40,SP)
            move.b  #$FE,(8,SP)
            frestore (SP)+
            fmul.x  ($24,A1),FP0
            fmul.x  ($30,A1),FP0
            bra.b   .L25
.L23:
            tst.w   D2
            beq.b   .L24
            fmul.x  ($24,A1),FP0
            fmul.x  ($30,A1),FP0
.L24:
            fmul.x  FP1,FP0
.L25:
            fmove.l FPSR,D0
            fmove.x FP0,(-$64,A6)
            lea     (-$64,A6),A2
            btst    #9,D0
            beq.b   .L26
            ori.l   #1,(8,A2)
            fmove.x (-$64,A6),FP0
.L26:
            move.l  (-$80,A6),(-$54,A6)
            andi.l  #$30,(-$80,A6)
            movem.l D0-D1/A0-A1,-(SP)
            move.l  (-$54,A6),-(SP)
            move.l  (-$50,A6),-(SP)
            lea     (-$64,A6),A0
            fmove.x FP0,(A0)
            tst.l   (-$50,A6)
            bge.b   .L27
            ori.l   #$80000000,(A0)
.L27:
            move.l  (-$7C,A6),-(SP)
            bsr.w   sub_408915C0
            move.b  (SP),(-$7C,A6)
            addq.l  #4,SP
            move.l  (SP)+,(-$50,A6)
            move.l  (SP)+,(-$54,A6)
            movem.l (SP)+,D0-D1/A0-A1
            move.l  (-$50,A6),(-$64,A6)
            move.l  (-$54,A6),(-$80,A6)
            swap    D5
            tst.w   D5
            bne.w   .L33
            fmove.b #1,FP2
            move.l  D4,D0
            subq.l  #1,D0
            moveq   #0,D3
.L28:
            lsr.l   #1,D0
            bcc.b   .L29
            fmul.x  (0,A1,D3.w),FP2
.L29:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L28
            tst.b   (-$4B,A6)
            beq.b   .L30
            fabs.x  FP0,FP0
            bra.b   .L31
.L30:
            fabs.x  FP0,FP0
            fcmp.x  FP2,FP0
            fbge.w  .L31
            subq.l  #1,D6
            move.w  #1,D5
            fmove.l #$20,FPCR
            fmul.b  #$A,FP2
            bra.w   .L7
.L31:
            fmul.b  #$A,FP2
            fcmp.x  FP2,FP0
            fblt.w  .L36
            fbgt.w  .L32
            fdiv.b  #$A,FP0
            addq.l  #1,D6
            bra.b   .L36
.L32:
            addq.l  #1,D6
            move.w  #1,D5
            fmove.l #$20,FPCR
            bra.w   .L7
.L33:
            fmove.b #1,FP2
            move.l  D4,D0
            moveq   #0,D3
.L34:
            lsr.l   #1,D0
            bcc.b   .L35
            fmul.x  (0,A1,D3.w),FP2
.L35:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .L34
            fabs.x  FP0,FP0
            fcmp.x  FP2,FP0
            fbne.w  .L36
            fdiv.b  #$A,FP0
            addq.l  #1,D6
            addq.l  #1,D4
            fmul.b  #$A,FP2
.L36:
            fmove.l #$10,FPCR
            fdiv.x  FP2,FP0
            lea     (-$74,A6),A0
            fmove.x FP0,(A0)
            move.l  (4,A0),D2
            move.l  (8,A0),D3
            clr.l   (4,A0)
            clr.l   (8,A0)
            move.l  (A0),D0
            swap    D0
            beq.b   .L38
            subi.l  #$3FFD,D0
            tst.l   D0
            bgt.b   .L38
            neg.l   D0
.L37:
            lsr.l   #1,D2
            roxr.l  #1,D3
            dbra    D0,.L37
.L38:
            tst.l   D2
            bne.b   .L39
            tst.l   D3
            beq.b   .L40
.L39:
            moveq   #0,D1
            addi.l  #$80,D3
            addx.l  D1,D2
            andi.l  #$FFFFFF80,D3
.L40:
            move.l  D4,D0
            addq.l  #3,A0
            bsr.w   sub_40890392
            tst.b   (-$4B,A6)
            beq.b   .L43
            ftst.x  FP0
            fbeq.w  .L41
            fmove.l D6,FP0
            fabs.x  FP0,FP0
            bra.b   .L45
.L41:
            tst.l   D7
            blt.b   .L42
            fmove.w #$1345,FP0
            bra.b   .L45
.L42:
            fmove.l D6,FP0
            fabs.x  FP0,FP0
            bra.b   .L45
.L43:
            ftst.x  FP0
            fbne.w  .L44
            fmove.b #1,FP0
            bra.b   .L45
.L44:
            fmove.l D6,FP0
            fabs.x  FP0,FP0
.L45:
            fdiv.x  ($18,A1),FP0
            fmove.x FP0,(-$64,A6)
            move.l  (4,A2),D2
            move.l  (8,A2),D3
            move.w  (A2),D0
            beq.b   .L47
            subi.w  #$3FFD,D0
            neg.w   D0
.L46:
            lsr.l   #1,D2
            roxr.l  #1,D3
            dbra    D0,.L46
.L47:
            moveq   #0,D1
            addi.l  #$80,D3
            addx.l  D1,D2
            andi.l  #$FFFFFF80,D3
            moveq   #4,D0
            lea     (-$54,A6),A0
            bsr.b   sub_40890392
            move.l  (-$54,A6),D0
            moveq   #$C,D1
            lsr.l   D1,D0
            bfins   D0,(-$74,A6){4:12}
            lsr.l   D1,D0
            bfins   D0,(-$74,A6){16:4}
            tst.b   D0
            beq.b   .L48
            ori.l   #$2080,(-$7C,A6)
.L48:
            moveq   #0,D0
            andi.b  #$F,(-$74,A6)
            tst.l   (-$50,A6)
            bge.b   .L49
            moveq   #2,D0
.L49:
            tst.l   D6
            bge.b   .L50
            addq.l  #1,D0
.L50:
            bfins   D0,(-$74,A6){0:2}
            fmove.l #0,FPSR
            fmovem.x (SP)+,FP0-FP2
            movem.l (SP)+,D2-D7/A2
            rts
sub_40890392:
            movem.l D0-D7,-(SP)
            moveq   #1,D7
            subq.l  #1,D0
.L1:
            move.l  D2,D4
            move.l  D3,D5
            bfextu  D2{0:3},D1
            asl.l   #3,D2
            bfextu  D3{0:3},D6
            asl.l   #3,D3
            or.l    D6,D2
            asl.l   #1,D5
            roxl.l  #1,D4
            swap    D6
            addx.w  D6,D1
            add.l   D5,D3
            nop
            addx.l  D4,D2
            nop
            addx.w  D6,D1
            swap    D6
            tst.w   D7
            beq.b   .L2
            swap    D7
            asl.w   #4,D7
            add.w   D1,D7
            move.b  D7,(A0)+
            swap    D7
            clr.w   D7
            dbra    D0,.L1
            bra.b   .L3
.L2:
            swap    D7
            move.w  D1,D7
            swap    D7
            addq.w  #1,D7
            dbra    D0,.L1
            swap    D7
            lsl.w   #4,D7
            move.b  D7,(A0)+
.L3:
            movem.l (SP)+,D0-D7
            rts
            dc.w    0
