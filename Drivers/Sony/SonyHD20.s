.L50:
            andi    #$F8FF,SR
            move.w  ($112,A1),D0
            cmp.w   ($12,A1),D0
            beq.b   .L51
            moveq   #$A,D0
            bsr.w   WakeUp_SonyRWT
.L51:
            movea.l IWM,A0
            tst.b   (A0)
            tst.b   ($800,A0)
            cmpi.b  #2,(3,A1,D1.w)
            bge.b   sub_4086FC5C.L1
            lea     sub_4086FC5C,A0
            move.l  A0,($1BE,A1)
            bra.w   HD20CtlIcon.L2
sub_4086FC5C:
            bne.w   .L15
            bsr.w   GetDrive
            move.b  #8,(3,A1,D1.w)
            move.l  ($1C8,A1),($16,A1,D1.w)
            move.l  ($1CC,A1),D0
            swap    D0
            move.l  D0,($12,A1,D1.w)
            clr.b   ($14,A1,D1.w)
            lsr.w   #8,D0
            move.b  D0,($1A,A1,D1.w)
            btst    #3,D0
            sne     (2,A1,D1.w)
            btst    #4,D0
            beq.b   .L1
            move.b  #2,(3,A1,D1.w)
.L1:
            movea.l (A1),A2
            move.l  ($10,A2),D5
            moveq   #9,D1
            lsr.l   D1,D5
            movea.l (8,A2),A0
            movea.l ($F4,A1),A5
            movea.l ($20,A0),A4
            move.l  ($24,A0),D3
            moveq   #-$32,D0
            andi.w  #$1FF,D3
            bne.w   .L15
            move.l  ($24,A0),D3
            tst.b   DskVerify
            beq.b   .L2
            bsr.w   CheckRead
            bne.b   .L2
            move.l  D3,($28,A0)
            add.l   D3,($10,A2)
            moveq   #0,D0
            bra.w   .L15
.L2:
            bsr.w   sub_40870722
            nop
            nop
.L3:
            moveq   #9,D1
            lsr.l   D1,D3
            moveq   #0,D0
            subq.b  #1,D0
            cmp.l   D0,D3
            blt.b   .L4
            move.l  D0,D3
.L4:
            move.w  D3,D2
            swap    D3
            move.w  D2,D3
            move.b  #3,($2D,A1)
            clr.b   ($1E5,A1)
.L5:
            bsr.w   sub_4086FDEE
            bsr.w   sub_4086FE1A
            bne.b   .L8
.L6:
            bsr.w   sub_4086FDAA
            bpl.b   .L7
            move.b  #2,($1E4,A1)
            clr.l   ($1E0,A1)
            move.b  #$40,($1E0,A1)
            bra.b   .L8
.L7:
            bsr.w   sub_4086FEC4
            beq.b   .L6
            add.l   D4,D5
            tst.w   D0
            beq.b   .L13
.L8:
            subq.b  #1,($2D,A1)
            blt.b   .L11
            beq.b   .L9
            cmpi.b  #2,($1E4,A1)
            bne.b   .L10
            btst    #$1E,($1E0,A1)
            bne.b   .L10
            tst.b   ($1E5,A1)
            beq.b   .L9
            clr.b   ($2D,A1)
.L9:
            bsr.w   sub_408703E6
            bne.b   .L11
            st      ($1E5,A1)
.L10:
            bra.b   .L5
.L11:
            moveq   #-$13,D0
            cmpi.b  #2,($33,A1)
            beq.b   .L12
            moveq   #-$14,D0
.L12:
            bra.b   .L15
.L13:
            moveq   #9,D1
            clr.w   D3
            swap    D3
            cmpi.b  #2,($33,A1)
            beq.b   .L14
            add.l   D3,BufTgFFlg
.L14:
            lsl.l   D1,D3
            movea.l (A1),A3
            add.l   D3,($10,A3)
            movea.l (8,A3),A0
            add.l   D3,($28,A0)
            move.l  ($24,A0),D3
            sub.l   ($28,A0),D3
            bgt.w   .L3
            moveq   #0,D0
.L15:
            movea.l IWM,A0
            bsr.w   sub_40870730
            andi    #$F8FF,SR
            bra.w   DiskRTS.L9
sub_4086FDAA:
            movea.l (SP)+,A3
.L1:
            moveq   #$64,D0
            movea.l VIA,A2
            lea     (vBufA,A2),A2
.L2:
            move.b  (A2),(A2)
            tst.b   ($1A00,A0)
            tst.b   ($1C00,A0)
            dbpl    D0,.L2
            bpl.b   .L3
            subq.w  #1,($1E8,A1)
            bmi.b   .L3
            move.w  ($1E6,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L1
.L3:
            jmp     (A3)
sub_4086FDD8:
            move.l  A2,-(SP)
            movea.l VIA,A2
            lea     ($1E00,A2),A2
            moveq   #$10,D0
.L1:
            move.b  (A2),(A2)
            dbra    D0,.L1
            movea.l (SP)+,A2
            rts
sub_4086FDEE:
            move.l  D5,D0
            lsl.l   #8,D0
            move.l  D0,($1C4,A1)
            move.b  D3,($1C3,A1)
            move.w  #$A,($1E6,A1)
            move.w  #$2710,($1E8,A1)
            move.l  #$200,D6
            moveq   #0,D7
            andi.b  #$3F,($1C2,A1)
            bne.b   .L1
            exg     D6,D7
.L1:
            rts
sub_4086FE1A:
            move.l  jSendCmd,-(SP)
            rts
jtSendCmd:
            movea.l IWM,A0
            lea     ($1800,A0),A3
            move.l  D6,($1DC,A1)
            add.l   D7,($1DC,A1)
            move.b  ($1C2,A1),D1
            cmpi.b  #3,D1
            bge.b   .L2
            tst.b   D1
            bne.b   .L1
            addi.w  #$14,D7
            bra.b   .L2
.L1:
            addi.w  #$14,D6
            move.l  A5,D0
            bne.b   .L2
            lea     ($1C8,A1),A1
            move.l  BufTgFNum,(A1)+
            move.l  BufTgFFlg,(A1)+
            move.l  BufTgDate,(A1)+
            move.l  ($38A).w,(A1)+
            move.l  ($38E).w,(A1)+
            movea.l SonyVars,A1
.L2:
            addq.w  #6,D6
            divu.w  #7,D6
            andi.w  #$7F,D6
            addq.w  #6,D7
            divu.w  #7,D7
            andi.w  #$7F,D7
            moveq   #0,D4
            bra.b   .L4
.L3:
            tst.b   D1
            beq.b   .L6
            ori.b   #$40,($1C2,A1)
            move.b  D3,($1C3,A1)
            addq.l  #1,($1CC,A1)
            move.w  #7,($1E6,A1)
            move.w  #$2710,($1E8,A1)
.L4:
            cmpi.b  #3,D1
            bge.b   .L5
            tst.b   D1
            beq.b   .L5
            move.l  A5,D0
            beq.b   .L5
            lea     ($1C8,A1),A1
            move.l  (A5)+,(A1)+
            move.l  (A5)+,(A1)+
            move.l  (A5)+,(A1)+
            movea.l SonyVars,A1
.L5:
            bsr.w   sub_408701B4
            bne.w   sub_4086FEC4.L5
.L6:
            rts
sub_4086FEC4:
            movea.l IWM,A0
            lea     ($1800,A0),A3
            move.b  ($1C2,A1),D1
            andi.b  #$3F,D1
            bsr.w   sub_4086FF7A
            bne.w   .L5
            move.l  ($1C2,A1),D0
            move.b  #$30,D0
            subi.b  #$80,($1C2,A1)
            cmp.b   ($1C2,A1),D1
            bne.b   .L5
            cmpi.b  #3,D1
            bge.b   .L3
            move.b  #$31,D0
            cmp.b   ($1C3,A1),D3
            beq.b   .L1
            swap    D0
            move.b  D3,D0
            swap    D0
            ror.l   #8,D0
            move.b  ($1C3,A1),D0
            rol.l   #8,D0
            bra.b   .L5
.L1:
            tst.b   D1
            bne.b   .L3
            move.l  A5,D0
            beq.b   .L2
            lea     ($1C8,A1),A1
            move.l  (A1)+,(A5)+
            move.l  (A1)+,(A5)+
            move.l  (A1)+,(A5)+
            movea.l SonyVars,A1
.L2:
            lea     ($1C8,A1),A1
            move.l  (A1)+,BufTgFNum
            move.l  (A1)+,BufTgFFlg
            move.l  (A1)+,BufTgDate
            move.l  (A1)+,($38A).w
            move.l  (A1)+,($38E).w
            movea.l SonyVars,A1
.L3:
            moveq   #1,D2
            move.l  ($1C4,A1),D0
            btst    #$18,D0
            bne.b   .L6
            cmpi.b  #$A,($1C4,A1)
            beq.b   .L6
            adda.l  ($1DC,A1),A4
            addq.l  #1,D4
            subq.b  #1,D3
            bne.w   jtSendCmd.L3
            moveq   #0,D0
.L4:
            andi    #$FFFB,SR
            rts
.L5:
            moveq   #2,D2
            ror.l   #8,D0
.L6:
            move.l  D0,($1E0,A1)
            move.b  D2,($1E4,A1)
            moveq   #1,D0
            bra.b   .L4
sub_4086FF7A:
            move    SR,-(SP)
            movem.l D1-D7/A1-A2/A4-A6,-(SP)
            movem.l SCCRd,A5-A6
            bsr.w   sub_40870738
            lea     ($1C2,A1),A1
            moveq   #0,D5
            tst.b   ($1A00,A0)
            moveq   #$20,D0
            tst.b   ($1C00,A0)
            bmi.w   .L35
            movea.l VIA,A2
            lea     ($1E00,A2),A2
            ori     #$700,SR
            tst.b   ($200,A0)
            tst.b   ($400,A0)
            tst.b   (A3)
            moveq   #$21,D0
            moveq   #8,D6
            swap    D6
.L1:
            subq.l  #1,D6
            beq.w   .L35
            cmpi.b  #$AA,(A3)
            bne.b   .L1
            move.w  #$40,D6
.L2:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L2
            bpl.b   .L11
            cmpi.b  #$BF,D1
            bne.b   .L3
            moveq   #6,D7
            swap    D7
.L3:
            swap    D1
.L4:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L4
            bpl.b   .L11
            swap    D1
.L5:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L5
            bpl.b   .L11
            swap    D2
.L6:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L6
            bpl.b   .L11
            swap    D2
.L7:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L7
            bpl.b   .L11
            swap    D3
.L8:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L8
            bpl.b   .L11
            swap    D3
.L9:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L9
            bpl.b   .L11
            swap    D4
.L10:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L10
            bpl.b   .L11
            dbra    D7,.L12
            bra.w   .L28
.L11:
            moveq   #$22,D0
            bra.w   .L35
.L12:
            moveq   #3,D6
            swap    D6
            move.w  #$40,D6
.L13:
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            move.b  D1,(A1)+
.L14:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L14
            bpl.b   .L11
            swap    D1
            move.b  #3,(A6)
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            move.b  D1,(A1)+
.L15:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L15
            bpl.b   .L11
            swap    D1
            tst.w   D7
            beq.b   .L16
            tst.b   (A5)
.L16:
            sne     D0
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            move.b  D2,(A1)+
.L17:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L17
            bpl.b   .L11
            swap    D2
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            move.b  D2,(A1)+
.L18:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L18
            bpl.b   .L11
            swap    D2
            tst.b   D0
            beq.b   .L19
            tst.b   (A0)
.L19:
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            move.b  D3,(A1)+
.L20:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L20
.L21:
            bpl.w   .L11
            swap    D3
            swap    D6
            dbra    D6,.L22
            movea.l A4,A1
.L22:
            swap    D6
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            move.b  D3,(A1)+
.L23:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L23
            bpl.b   .L21
            swap    D3
            lsr.b   #1,D4
            swap    D4
            addx.b  D4,D4
            add.b   D4,D5
            move.b  D4,(A1)+
.L24:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L24
            bpl.b   .L21
            swap    D4
            move.w  #$40,D6
.L25:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L25
            bpl.b   .L21
            tst.b   D0
            dbne    D7,.L13
            beq.b   .L28
            tst.b   (A5)
            andi    #$F8FF,SR
            subq.w  #1,D7
            bsr.w   sub_4086FDD8
            ori     #$700,SR
            tst.b   ($200,A0)
            tst.b   (A3)
            clr.w   D0
.L26:
            subq.w  #1,D0
            beq.b   .L27
            cmpi.b  #$AA,(A3)
            bne.b   .L26
            bra.w   .L13
.L27:
            moveq   #$24,D0
            bra.b   .L35
.L28:
            swap    D7
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            subq.w  #1,D7
            bmi.b   .L29
            move.b  D1,(A1)+
.L29:
            swap    D1
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            subq.w  #1,D7
            bmi.b   .L30
            move.b  D1,(A1)+
.L30:
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            subq.w  #1,D7
            bmi.b   .L31
            move.b  D2,(A1)+
.L31:
            swap    D2
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            subq.w  #1,D7
            bmi.b   .L32
            move.b  D2,(A1)+
.L32:
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            subq.w  #1,D7
            bmi.b   .L33
            move.b  D3,(A1)+
.L33:
            swap    D3
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            subq.w  #1,D7
            bmi.b   .L34
            move.b  D3,(A1)+
.L34:
            lsr.b   #1,D4
            swap    D4
            addx.b  D4,D4
            add.b   D4,D5
            tst.b   ($600,A0)
            tst.b   ($1A00,A0)
            moveq   #$25,D0
            tst.b   ($1C00,A0)
            bpl.b   .L35
            move.b  D5,D0
            beq.b   .L35
            moveq   #$26,D0
.L35:
            tst.b   (A5)
            tst.b   ($600,A0)
            tst.b   (A0)
            movem.l (SP)+,D1-D7/A1-A2/A4-A6
            move    (SP)+,SR
            tst.w   D0
            rts
sub_408701B4:
            move    SR,-(SP)
            movem.l D1-D7/A1/A4-A6,-(SP)
            movem.l SCCRd,A5-A6
            bsr.w   sub_40870738
            lea     ($1C2,A1),A1
            move.b  D1,D4
            swap    D4
            swap    D6
            move.w  D7,D6
            swap    D6
            moveq   #-$80,D0
            moveq   #0,D5
            st      D4
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            swap    D4
            tst.b   ($1A00,A0)
            moveq   #$10,D0
            tst.b   ($1C00,A0)
            bpl.w   .L29
            tst.b   ($200,A0)
            moveq   #$11,D0
            moveq   #$50,D7
            swap    D7
.L1:
            subq.l  #1,D7
            beq.w   .L29
            tst.b   ($1C00,A0)
            bmi.b   .L1
            tst.b   ($400,A0)
            lea     ($1A00,A0),A0
            ori     #$700,SR
            moveq   #2,D7
            cmpi.b  #4,D4
            blt.b   .L2
            moveq   #-1,D7
            movea.l A4,A1
.L2:
            bsr.w   sub_4086FDD8
            move.l  D6,D0
            addi.l  #$810081,D0
            move.b  #$AA,($400,A0)
.L3:
            tst.b   (A3)
            bpl.b   .L3
            move.b  D0,(A0)
            swap    D0
.L4:
            tst.b   (A3)
            bpl.b   .L4
            move.b  D0,(A0)
            moveq   #-$80,D0
            bra.w   .L14
.L5:
            move.b  (A1)+,D4
            add.b   D4,D5
            roxr.b  #1,D4
            or.b    D0,D4
            swap    D4
            roxr.b  #2,D4
.L6:
            tst.b   (A3)
            bpl.b   .L6
            move.b  D4,(A0)
            st      D4
            move.b  #3,(A6)
.L7:
            tst.b   (A3)
            bpl.b   .L7
            move.b  D1,(A0)
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            tst.b   (A5)
            beq.b   .L8
            bset    #$1F,D6
.L8:
            tst.b   (A3)
            bpl.b   .L8
            move.b  D1,(A0)
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            tst.w   D6
            bne.b   .L9
            bclr    #$1F,D6
.L9:
            tst.b   (A3)
            bpl.b   .L9
            move.b  D2,(A0)
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            btst    #$1F,D6
            beq.b   .L10
            tst.b   (-$1A00,A0)
.L10:
            tst.b   (A3)
            bpl.b   .L10
            move.b  D2,(A0)
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
.L11:
            tst.b   (A3)
            bpl.b   .L11
            move.b  D3,(A0)
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            dbra    D7,.L12
            movea.l A4,A1
.L12:
            tst.b   (A3)
            bpl.b   .L12
            move.b  D3,(A0)
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            swap    D4
.L13:
            tst.b   (A3)
            bpl.b   .L13
            move.b  D4,(A0)
            bclr    #$1F,D6
            bne.b   .L15
.L14:
            dbra    D6,.L5
            bra.b   .L17
.L15:
            clr.b   D0
.L16:
            tst.b   (A3)
            bpl.b   .L16
            move.b  D0,(A0)
            andi    #$F8FF,SR
            bsr.w   sub_4086FDD8
            subq.w  #1,D6
            tst.b   ($200,A0)
            tst.b   (-$200,A0)
            tst.b   (A0)
            tst.b   (-$1800,A0)
            bsr.w   sub_4086FDD8
            moveq   #-$80,D0
            ori     #$700,SR
            move.b  #$AA,($400,A0)
            bra.w   .L5
.L17:
            neg.b   D5
            roxr.b  #1,D5
            or.b    D0,D5
            swap    D4
            roxr.b  #2,D4
.L18:
            tst.b   (A3)
            bpl.b   .L18
            move.b  D4,(A0)
.L19:
            tst.b   (A3)
            bpl.b   .L19
            move.b  D1,(A0)
            swap    D1
.L20:
            tst.b   (A3)
            bpl.b   .L20
            move.b  D1,(A0)
.L21:
            tst.b   (A3)
            bpl.b   .L21
            move.b  D2,(A0)
            swap    D2
.L22:
            tst.b   (A3)
            bpl.b   .L22
            move.b  D2,(A0)
.L23:
            tst.b   (A3)
            bpl.b   .L23
            move.b  D3,(A0)
            swap    D3
.L24:
            tst.b   (A3)
            bpl.b   .L24
            move.b  D3,(A0)
.L25:
            tst.b   (A3)
            bpl.b   .L25
            move.b  D5,(A0)
.L26:
            tst.b   (A3)
            bpl.b   .L26
            moveq   #0,D0
            move.b  D0,(A0)
.L27:
            tst.b   (A3)
            bpl.b   .L27
            move.b  D0,(A0)
            movea.l IWM,A0
            tst.b   ($600,A0)
            moveq   #$13,D0
            moveq   #-1,D7
.L28:
            subq.w  #1,D7
            beq.b   .L29
            tst.b   ($1C00,A0)
            bpl.b   .L28
            moveq   #0,D0
.L29:
            tst.b   ($600,A0)
            tst.b   (A0)
            movem.l (SP)+,D1-D7/A1/A4-A6
            move    (SP)+,SR
            tst.w   D0
            rts
sub_408703E6:
            move.l  jDCDReset,-(SP)
            rts
jtDCDReset:
            movea.l (SP)+,A3
            bsr.w   SetChipMode
            bsr.w   sub_4086D716
            tst.b   ($A00,A0)
            tst.b   ($400,A0)
            tst.b   (A0)
            move.w  #$3E8,D0
            bsr.w   WakeUp_SonyRWT
            tst.b   ($600,A0)
            tst.b   ($800,A0)
            move.w  #$4E20,D0
            bsr.w   WakeUp_SonyRWT
            move.w  #$64,($1E6,A1)
            move.w  #$640,($1E8,A1)
.L1:
            bsr.w   Sense
            bmi.b   .L2
            subq.w  #1,($1E8,A1)
            bmi.b   .L3
            move.w  ($1E6,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L1
.L2:
            moveq   #0,D0
            jmp     (A3)
.L3:
            tst.b   ($1800,A0)
            moveq   #-1,D0
            jmp     (A3)
sub_40870446:
            bne.b   .L1
            lea     ($216,A1),A2
            movea.l (A1),A0
            movea.l (8,A0),A0
            move.l  A2,($1C,A0)
.L1:
            bra.w   sub_4086FC5C.L15
HD20CtlIcon:
            bne.w   DiskRTS.L9
            btst    #2,($1A,A1,D1.w)
            beq.w   DiskRTS.L8
            lea     sub_40870446,A0
            move.l  A0,($1BE,A1)
.L2:
            moveq   #3,D3
            bra.b   sub_40870474.L2
sub_40870474:
            moveq   #$1A,D3
            bra.b   .L2
.L1:
            moveq   #$19,D3
.L2:
            bsr.w   sub_40870754
            tst.b   (A0)
            tst.b   ($800,A0)
            clr.b   ($1E5,A1)
            move.b  D3,($1C2,A1)
.L3:
            movea.l SonyVars,A1
            andi.b  #$3F,($1C2,A1)
            suba.l  A4,A4
            suba.l  A5,A5
            moveq   #1,D3
            moveq   #0,D6
            moveq   #0,D7
            move.w  #$64,($1E6,A1)
            move.w  #$4650,($1E8,A1)
            cmpi.b  #3,($1C2,A1)
            bne.b   .L4
            move.l  #$14C,D7
            move.w  #$A,($1E6,A1)
            move.w  #$2710,($1E8,A1)
            lea     ($1EA,A1),A4
.L4:
            bsr.w   sub_4086FE1A
            beq.b   .L7
.L5:
            cmpi.b  #2,($1E0,A1)
            beq.b   .L6
            btst    #$1E,($1E0,A1)
            beq.b   .L6
            bset    #1,($1E5,A1)
            bne.b   .L3
.L6:
            bset    #0,($1E5,A1)
            bne.b   .L8
            bsr.w   sub_408703E6
            bne.b   .L8
            bra.b   .L3
.L7:
            bsr.w   sub_4086FDAA
            bmi.b   .L5
            bsr.w   sub_4086FEC4
            tst.w   D0
            bne.b   .L5
            moveq   #0,D0
            bra.b   .L9
.L8:
            moveq   #-$11,D0
.L9:
            andi.b  #$3F,($1C2,A1)
            cmpi.b  #3,($1C2,A1)
            bne.w   sub_4086FC5C.L15
            movea.l ($1BE,A1),A0
            tst.w   D0
            jmp     (A0)
