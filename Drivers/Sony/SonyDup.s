DupVersion:
            move.w  #$410,(A0)
            moveq   #0,D0
            bra.w   DiskRTS.L9
GetFmtByte:
            move.b  ($14C,A1),(A0)
            moveq   #0,D0
            bra.w   DiskRTS.L9
CtlFmtCopy:
            bne.w   DiskRTS.L9
            suba.w  #$200,SP
            bsr.w   sub_40870774
            lea     ($1E,A0),A0
            move.l  A0,($148,A1)
            move.w  -(A0),D4
            beq.b   .L7
            moveq   #2,D3
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L6
            moveq   #3,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L6
            moveq   #1,D3
.L6:
            moveq   #-$32,D0
            cmp.w   D3,D4
            bhi.w   .L16
            cmpi.w  #3,D4
            seq     D0
            or.b    ($18,A1,D1.w),D0
            smi     ($17,A1,D1.w)
.L7:
            tst.b   ($138,A1)
            bpl.b   .L8
            bsr.w   SetChipMode
            bne.w   .L16
.L8:
            bsr.w   sub_4086D716
            tst.b   ($17,A1,D1.w)
            smi     ($32,A1)
            bmi.b   .L9
            tst.b   (5,A1,D1.w)
            smi     ($32,A1)
            bpl.b   .L9
            subq.w  #1,D4
            bne.b   .L9
            clr.b   ($32,A1)
.L9:
            tst.b   ($32,A1)
            sne     ($12,A1,D1.w)
            move.w  #8,($22,A1)
            bsr.w   sub_4086EA80
            moveq   #6,D0
            bsr.w   AdrAndSense
            bmi.b   .L10
            moveq   #-$2C,D0
            bra.b   .L16
.L10:
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            moveq   #$B,D0
.L11:
            moveq   #$23,D1
            lea     Nibl.L25,A1
.L12:
            move.b  (A1)+,(A0)+
            dbra    D1,.L12
            dbra    D0,.L11
            bsr.w   GetDrv1
            clr.w   ($16,A1)
.L13:
            bsr.w   sub_4086E768
            bne.b   .L16
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bpl.b   .L14
            bsr.w   mFmtCopyTrk
            bra.b   .L15
.L14:
            bsr.w   gFmtCopyTrk
.L15:
            bne.b   .L16
            bsr.w   GetDrv1
            bclr    #3,($16,A1)
            addq.w  #1,($16,A1)
            cmpi.w  #$50,($16,A1)
            blt.b   .L13
            moveq   #0,D0
.L16:
            lea     ($200,SP),SP
            bra.w   DskRWOff
gFmtCopyTrk:
            bsr.w   GetDrv1
            move.w  ($16,A1),D6
            bsr.w   FillMarks
.L1:
            bsr.w   gDoFmtCopy
            beq.b   .L2
            andi    #$F8FF,SR
            bra.w   .L7
.L2:
            bsr.w   GetDrv1
            bsr.w   RdAddrSetup
            bmi.b   .L3
            tst.b   D2
            beq.b   .L3
            moveq   #-$52,D0
.L3:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            lea     ($22,A1),A0
            move.w  DskErr,D0
            bmi.b   sub_4086F50C.L1
            move.l  #$5E0,D2
            sub.w   D0,D2
            divu.w  #5,D2
            moveq   #-$53,D0
            sub.w   (A0),D2
            bmi.b   sub_4086F50C
            ext.l   D2
            divu.w  ($20,A1),D2
            beq.b   .L4
            subq.w  #1,D2
            beq.b   .L4
            addq.w  #1,(A0)
.L4:
            bsr.w   GetDrv1
            movea.l ($148,A1),A0
            tst.b   (9,A0)
            beq.b   .L5
            bsr.b   gVerCopy
            bne.b   .L7
            movea.l ($148,A1),A0
.L5:
            moveq   #0,D1
            move.w  ($20,A1),D1
            lsl.l   #2,D1
            move.l  D1,D2
            add.l   D1,D1
            add.l   D1,D2
            lsl.l   #6,D1
            add.l   D1,(A0)+
            add.l   D2,(A0)+
            bset    #3,($16,A1)
            bne.b   .L6
            tst.b   ($32,A1)
            bne.w   gFmtCopyTrk
.L6:
            moveq   #0,D0
.L7:
            tst.w   D0
            rts
sub_4086F50C:
            addq.w  #1,D2
            beq.b   gFmtCopyTrk.L4
.L1:
            subq.w  #1,(A0)
            cmpi.w  #4,(A0)
            blt.b   gFmtCopyTrk.L7
            bra.w   gFmtCopyTrk.L1
gVerCopy:
            ori     #$700,SR
            lea     ($26,A1),A0
            moveq   #0,D0
            move.b  ($17,A1),D0
            lsr.w   #4,D0
            move.w  #$FFF,D2
            lsr.w   D0,D2
            move.w  D2,(A0)+
            moveq   #$C,D2
            sub.w   D0,D2
            lsl.w   #2,D2
            move.w  D2,(A0)
.L1:
            bsr.w   RdAddrSetup
            bmi.b   .L2
            move.w  D2,($24,A1)
            cmp.w   ($16,A1),D1
            bne.b   .L2
            movea.l ($148,A1),A0
            movea.l (A0),A0
            moveq   #9,D0
            lsl.w   D0,D2
            adda.w  D2,A0
            st      DskVerify
            bsr.w   RdData
            bmi.b   .L2
            bsr.w   GetDrv1
            lea     ($24,A1),A0
            move.w  (A0)+,D2
            move.w  (A0),D3
            bclr    D2,D3
            move.w  D3,(A0)
.L2:
            bsr.w   toEmptyPD
            lea     ($26,A1),A0
            tst.w   (A0)+
            beq.b   .L3
            subq.w  #1,(A0)
            bne.b   .L1
            moveq   #-$54,D0
            bra.b   .L4
.L3:
            moveq   #0,D0
.L4:
            andi    #$F8FF,SR
            tst.w   D0
            rts
gDoFmtCopy:
            ori     #$700,SR
            moveq   #1,D0
            movea.l SonyVars,A1
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            movea.l IWM,A4
            lea     ($1A00,A4),A3
            lea     ($1800,A4),A4
            movea.l ($1C,A1),A5
            lea     mDoFormat.L49,A2
            move.w  ($20,A1),-(SP)
            move.w  ($22,A1),D1
            subq.w  #2,D1
            move.w  D1,DskErr
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            move.w  #$C7,D6
            tst.b   (A3)
            move.b  D6,($400,A3)
.L2:
            lea     Nibl.L25,A6
            moveq   #2,D7
.L3:
            move.b  (A6)+,D4
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D4,(A3)
            move.b  (A6)+,D4
.L5:
            tst.b   (A4)
            bpl.b   .L5
            move.b  D4,(A3)
            dbra    D7,.L3
            dbra    D6,.L2
.L6:
            move.w  DskErr,D6
.L7:
            lea     Nibl.L25,A6
            moveq   #5,D7
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (A6)+,(A3)
            dbra    D7,.L8
            dbra    D6,.L7
            moveq   #$16,D7
.L9:
            tst.b   (A4)
            bpl.b   .L9
            move.b  (A5)+,(A3)
            dbra    D7,.L9
            move.b  (A5)+,D0
            move.b  (A5)+,D3
            move.b  (A5)+,D1
            move.b  (A5)+,D2
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  D0,(A3)
            addq.w  #1,A5
            movea.l (A5)+,A1
            movea.l (A5)+,A0
            move.l  #$2010009,D4
.L11:
            tst.b   (A4)
            bpl.b   .L11
            move.b  D3,(A3)
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
            bra.b   .L16
.L12:
            movea.l A0,A1
.L13:
            addx.b  D2,D7
            eor.b   D6,D2
            move.b  D2,D3
            lsr.w   #6,D3
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (0,A2,D3.w),(A3)
            subq.w  #3,D4
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  (0,A2,D0.w),(A3)
.L16:
            move.b  (A1)+,D0
            addx.b  D0,D5
            eor.b   D7,D0
            move.b  D0,D3
            rol.w   #2,D3
.L17:
            tst.b   (A4)
            bpl.b   .L17
            move.b  (0,A2,D1.w),(A3)
            move.b  (A1)+,D1
            addx.b  D1,D6
            eor.b   D5,D1
            move.b  D1,D3
            rol.w   #2,D3
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  (0,A2,D2.w),(A3)
            move.b  (A1)+,D2
            tst.w   D4
            bne.b   .L13
            swap    D4
            bne.b   .L12
            clr.b   D3
            lsr.w   #6,D3
.L19:
            tst.b   (A4)
            bpl.b   .L19
            move.b  (0,A2,D3.w),(A3)
            move.b  D5,D3
            rol.w   #2,D3
            move.b  D6,D3
            rol.w   #2,D3
.L20:
            tst.b   (A4)
            bpl.b   .L20
            move.b  (0,A2,D0.w),(A3)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  (0,A2,D1.w),(A3)
            move.b  D7,D3
            lsr.w   #6,D3
.L22:
            tst.b   (A4)
            bpl.b   .L22
            move.b  (0,A2,D3.w),(A3)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  (0,A2,D5.w),(A3)
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  (0,A2,D6.w),(A3)
.L25:
            tst.b   (A4)
            bpl.b   .L25
            move.b  (0,A2,D7.w),(A3)
            moveq   #3,D7
            addq.w  #8,A6
.L26:
            move.b  (A4),D1
            bpl.b   .L26
            move.b  (A6)+,(A3)
            dbra    D7,.L26
            subq.w  #1,(SP)
            bgt.w   .L6
            addq.w  #2,SP
            moveq   #0,D0
            btst    #6,D1
            bne.b   .L27
            moveq   #-$4A,D0
.L27:
            tst.b   ($400,A4)
            tst.b   (A4)
            move.w  D0,DskErr
            rts
FillMarks:
            movem.l D0-D7/A0-A4,-(SP)
            movea.l ($1C,A1),A0
            movea.l ($148,A1),A2
            movea.l (A2)+,A4
            movea.l (A2)+,A3
            moveq   #0,D3
            move.b  (A2),D3
            moveq   #$C,D0
            moveq   #$7F,D2
            and.w   D6,D2
            lsr.w   #4,D2
            sub.w   D2,D0
            move.w  D0,($20,A1)
            lea     mDoFormat.L49,A1
            lea     mDoFormat.L48,A2
            move.b  (0,A1,D3.w),D7
            move.b  D3,D5
            andi.b  #$F,D3
            subq.b  #2,D3
            beq.b   .L1
            lea     mDoFormat.L47,A2
.L1:
            mulu.w  #$C,D2
            adda.w  D2,A2
            moveq   #$3F,D3
            and.b   D6,D3
            move.b  (0,A1,D3.w),D2
            eor.b   D3,D5
            lsr.w   #6,D6
            eor.b   D6,D5
            move.b  (0,A1,D6.w),D6
.L2:
            swap    D0
            moveq   #0,D1
            move.b  (0,A2,D0.w),D1
            move.b  (0,A1,D1.w),D3
            moveq   #0,D4
            move.b  D5,D4
            eor.b   D1,D4
            lea     (9,A0),A0
            move.b  D2,(A0)+
            move.b  D3,(A0)+
            move.b  D6,(A0)+
            move.b  D7,(A0)+
            move.b  (0,A1,D4.w),(A0)+
            lea     ($B,A0),A0
            move.b  #$B,(A0)+
            move.b  D1,(A0)+
            clr.b   (A0)+
            move.l  D1,D4
            add.w   D4,D4
            add.w   D1,D4
            lsl.w   #2,D4
            add.l   A3,D4
            move.l  D4,(A0)+
            moveq   #9,D4
            lsl.w   D4,D1
            add.l   A4,D1
            move.l  D1,(A0)+
            addq.w  #1,D0
            move.w  D0,D1
            swap    D0
            cmp.w   D0,D1
            blt.b   .L2
            movem.l (SP)+,D0-D7/A0-A4
            rts
mFmtCopyTrk:
            bsr.w   GetDrv1
            move.w  ($16,A1),D4
            moveq   #0,D5
            bclr    #$B,D4
            beq.b   .L2
            moveq   #1,D5
            moveq   #0,D2
            move.w  TimeDBRA,D2
            move.l  D2,D0
            add.l   D2,D0
            add.l   D2,D0
            lsr.l   #2,D0
.L1:
            dbra    D0,.L1
.L2:
            moveq   #8,D2
            move.b  ($18,A1,D1.w),D0
            bpl.b   .L3
            moveq   #$11,D2
            bset    #$1F,D2
.L3:
            bsr.w   mDoFormat
            movea.l ($148,A1),A1
            movea.l (A1),A2
            move.l  A0,(A1)
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            move.w  DskErr,D0
            bne.b   .L5
            movea.l ($148,A1),A0
            tst.b   (9,A0)
            beq.b   .L4
            bsr.b   mVerCopy
            bne.b   .L5
            bsr.w   GetDrv1
.L4:
            bset    #3,($16,A1)
            beq.b   mFmtCopyTrk
            moveq   #0,D0
.L5:
            rts
mVerCopy:
            movem.l D2-D7,-(SP)
            ori     #$700,SR
            moveq   #$12,D7
            move.l  #$3FE,D6
            bsr.w   GetDrv1
            tst.b   ($18,A1,D1.w)
            bpl.b   .L1
            moveq   #$24,D7
            move.l  #$7FFFE,D6
.L1:
            bsr.w   RdAddrSetup
            bne.b   .L2
            btst    D2,D6
            beq.b   .L2
            cmp.w   ($16,A1),D1
            bne.b   .L2
            move.w  D2,D3
            subq.w  #1,D2
            moveq   #9,D0
            lsl.l   D0,D2
            add.l   ($1C,A1),D2
            movea.l D2,A0
            st      DskVerify
            bsr.w   sub_4086EEDC
            bne.b   .L2
            bclr    D3,D6
.L2:
            bsr.w   toEmptyPD
            tst.l   D6
            dbeq    D7,.L1
            beq.b   .L3
            moveq   #-$54,D0
.L3:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D7
            tst.w   D0
            rts
mDoFormat:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            tst.w   D5
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l ($148,A1),A0
            movea.l (A0),A0
            move.l  A0,($1C,A1)
            movea.l IWM,A4
            lea     (A4),A3
            lea     ($1E00,A4),A4
            tst.b   ($1400,A3)
            move.b  #$18,($C00,A3)
            move.b  #$10,($E00,A3)
            move.b  #1,($E00,A3)
            move.b  #1,($C00,A3)
            moveq   #$4E,D1
            move.b  D1,(A3)
            move.b  D1,(A3)
            move.b  #8,($E00,A3)
            move.w  #$34BC,D3
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            move.b  (A4),D0
            bpl.b   .L3
            move.b  D1,(A3)
            btst    #3,D0
            beq.b   .L4
            dbra    D3,.L2
            bra.w   .L44
.L4:
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            move.b  (A4),D0
            bpl.b   .L5
            move.b  D1,(A3)
            btst    #3,D0
            bne.b   .L6
            dbra    D3,.L4
            bra.w   .L44
.L6:
            move.b  #$F5,($800,A3)
            moveq   #$4E,D0
.L7:
            tst.b   (A5)
            bmi.b   .L8
            move.b  (A6),-(SP)
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  D1,(A3)
            dbra    D0,.L7
            moveq   #$B,D0
            moveq   #0,D1
.L9:
            tst.b   (A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  D1,(A3)
            dbra    D0,.L9
            moveq   #2,D0
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  #$C2,($200,A3)
            dbra    D0,.L11
.L13:
            tst.b   (A4)
            bpl.b   .L13
            move.b  #$FC,(A3)
            moveq   #$31,D0
.L14:
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  #$4E,(A3)
            dbra    D0,.L14
            moveq   #1,D6
            bra.b   .L19
.L16:
            moveq   #$4F,D0
            tst.l   D2
            bpl.b   .L17
            moveq   #$64,D0
.L17:
            tst.b   (A5)
            bmi.b   .L18
            move.b  (A6),-(SP)
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  #$4E,(A3)
            dbra    D0,.L17
.L19:
            moveq   #$B,D0
            moveq   #0,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  D1,(A3)
            dbra    D0,.L20
            moveq   #2,D0
.L22:
            tst.b   (A5)
            bmi.b   .L23
            move.b  (A6),-(SP)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  #$A1,($200,A3)
            dbra    D0,.L22
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  #$FE,(A3)
            tst.b   (A5)
            bmi.b   .L25
            move.b  (A6),-(SP)
.L25:
            tst.b   (A4)
            bpl.b   .L25
            move.b  D4,(A3)
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            tst.b   (A4)
            bpl.b   .L26
            move.b  D5,(A3)
            tst.b   (A5)
            bmi.b   .L27
            move.b  (A6),-(SP)
.L27:
            tst.b   (A4)
            bpl.b   .L27
            move.b  D6,(A3)
            tst.b   (A5)
            bmi.b   .L28
            move.b  (A6),-(SP)
.L28:
            tst.b   (A4)
            bpl.b   .L28
            move.b  #2,(A3)
            tst.b   (A5)
            bmi.b   .L29
            move.b  (A6),-(SP)
.L29:
            tst.b   (A4)
            bpl.b   .L29
            move.b  D0,($400,A3)
            moveq   #$15,D0
.L30:
            tst.b   (A5)
            bmi.b   .L31
            move.b  (A6),-(SP)
.L31:
            tst.b   (A4)
            bpl.b   .L31
            move.b  #$4E,(A3)
            dbra    D0,.L30
            moveq   #$B,D0
            moveq   #0,D1
.L32:
            tst.b   (A5)
            bmi.b   .L33
            move.b  (A6),-(SP)
.L33:
            tst.b   (A4)
            bpl.b   .L33
            move.b  D1,(A3)
            dbra    D0,.L32
            moveq   #2,D0
.L34:
            tst.b   (A5)
            bmi.b   .L35
            move.b  (A6),-(SP)
.L35:
            tst.b   (A4)
            bpl.b   .L35
            move.b  #$A1,($200,A3)
            dbra    D0,.L34
.L36:
            tst.b   (A4)
            bpl.b   .L36
            move.b  #$FB,(A3)
            move.w  #$1FF,D0
.L37:
            tst.b   (A5)
            bmi.b   .L38
            move.b  (A6),-(SP)
.L38:
            tst.b   (A4)
            bpl.b   .L38
            move.b  (A0)+,(A3)
            dbra    D0,.L37
.L39:
            tst.b   (A4)
            bpl.b   .L39
            move.b  D0,($400,A3)
            addq.w  #1,D6
            dbra    D2,.L16
            moveq   #4,D0
            moveq   #$4E,D1
            move.w  #$3E8,D3
            tst.w   D5
            bne.b   .L41
            moveq   #4,D3
            bra.b   .L41
.L40:
            move.b  #$F4,($800,A3)
.L41:
            tst.b   (A5)
            bmi.b   .L42
            move.b  (A6),-(SP)
.L42:
            move.b  (A4),D2
            bpl.b   .L42
            move.b  D1,(A3)
            subq.w  #1,D0
            bgt.b   .L43
            beq.b   .L40
            btst    #3,D2
            bne.b   .L45
.L43:
            dbra    D3,.L41
            tst.w   D5
            beq.b   .L45
.L44:
            moveq   #-$53,D0
            bra.b   .L46
.L45:
            moveq   #0,D0
            btst    #5,D2
            beq.b   .L46
            moveq   #wrUnderrun,D0
.L46:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
.L47:
            dc.w    $0003,$0609,$0104,$070A,$0205,$080B,$0003,$0609
            dc.w    $0104,$070A,$0205,$0800,$0005,$0308,$0106,$0409
            dc.b    $02,$07,$00,$00,$00,$07,$05,$03,$01,$08,$06,$04,$02
            ds.b    4
            dc.b    $02,$04,$06,$01,$03,$05,$07
            ds.b    4
.L48:
            dc.w    $0006,$0107,$0208,$0309,$040A,$050B,$0006,$0107
            dc.w    $0208,$0309,$040A,$0500,$0005,$0106,$0207,$0308
            dc.b    $04,$09,$00,$00,$00,$05,$01,$06,$02,$07,$03,$08,$04
            ds.b    4
            dc.b    $04,$01,$05,$02,$06,$03,$07
            ds.b    4
.L49:
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
