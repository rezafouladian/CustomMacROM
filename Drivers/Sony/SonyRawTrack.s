CtlRawTrackDump:
            tst.w   D0
            bne.w   DiskRTS.L9
            lea     (-$200,SP),SP
            move.l  SP,($1C,A1)
            lea     ($1C,A0),A0
            move.l  A0,($22,A1)
            clr.l   ($C,A0)
            move.l  (A0)+,D0
            or.l    (A0)+,D0
            beq.b   .L11
            addq.w  #8,A0
            moveq   #-$32,D0
            move.w  (A0)+,D7
            cmpi.w  #3,D7
            bhi.b   .L11
            bne.b   .L10
            tst.b   ($17,A1,D1.w)
            bmi.b   .L10
            clr.w   (-2,A0)
.L10:
            move.w  (A0)+,D2
            cmpi.w  #$50,D2
            bcc.b   .L11
            rol.w   #8,D2
            move.b  (A0)+,D2
            cmpi.b  #2,D2
.L11:
            bcc.w   .L19
            asl.b   #3,D2
            rol.w   #8,D2
            move.w  D2,($16,A1)
            moveq   #0,D2
            move.b  (A0)+,D2
            move.w  D2,($FE,A1)
            bsr.w   sub_408708E4
            tst.b   ($138,A1)
            bpl.b   .L12
            bsr.w   SetChipMode
            bne.w   .L19
.L12:
            bsr.w   sub_4086D716
            bsr.w   sub_4086EA80
            bsr.w   sub_4086E768
            bne.b   .L19
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l ($22,A1),A0
            move.w  ($10,A0),D7
            cmpi.w  #3,D7
            bne.b   .L13
            bsr.b   sub_40870614
            beq.b   .L17
            bra.b   .L18
.L13:
            tst.w   D7
            beq.b   .L17
            move.w  #$FF,D6
.L14:
            bsr.w   RdAddrSetup
            bmi.b   .L15
            cmp.w   ($16,A1),D1
            bne.b   .L15
            cmp.w   ($FE,A1),D2
            beq.b   .L16
.L15:
            bsr.w   toEmptyPD
            dbra    D6,.L14
            moveq   #-$51,D0
            bra.b   .L19
.L16:
            subq.w  #1,D7
            beq.b   .L17
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   RdData
            bmi.b   .L19
.L17:
            bsr.b   sub_4087065E
            bne.b   .L18
            movea.l SonyVars,A1
            movea.l ($22,A1),A1
            move.l  (8,A1),($C,A1)
.L18:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
.L19:
            lea     ($200,SP),SP
            bra.w   DskRWOff
sub_40870614:
            move.l  (SP)+,DskRtnAdr
            moveq   #$E,D0
            bsr.w   AdrDisk
            moveq   #$6E,D2
            tst.b   ($18,A1,D1.w)
            bmi.b   .L1
            add.w   D2,D2
.L1:
            mulu.w  TimeDBRA,D2
            movea.l IWM,A4
            lea     ($1E00,A4),A4
            moveq   #0,D0
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            btst    #3,(A4)
            beq.b   .L4
            subq.l  #1,D2
            bgt.b   .L2
            bra.b   .L6
.L4:
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            btst    #3,(A4)
            bne.b   .L7
            subq.l  #1,D2
            bgt.b   .L4
.L6:
            moveq   #-$53,D0
.L7:
            bra.w   sub_4086D7F2
sub_4087065E:
            bsr.w   GetDrv1
            moveq   #1,D0
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            movea.l ($22,A1),A4
            movea.l (A4)+,A2
            movea.l (A4)+,A0
            move.l  (A4)+,D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L10
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     ($1E00,A4),A3
            lea     ($1200,A4),A4
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            moveq   #-1,D2
            bra.b   .L4
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            move.b  (A3),D3
            dbmi    D2,.L2
            bpl.b   .L9
            moveq   #$1E,D2
            move.b  (A4),(A0)+
            lsr.b   #1,D3
            addx.b  D1,D1
            bcc.b   .L5
            move.b  D1,(A2)+
.L4:
            moveq   #1,D1
.L5:
            subq.l  #1,D0
            bge.b   .L2
            cmpi.b  #1,D1
            beq.b   .L7
.L6:
            add.b   D1,D1
            bcc.b   .L6
            move.b  D1,(A2)+
.L7:
            moveq   #0,D0
.L8:
            move.b  #$18,(-$600,A4)
            bra.w   sub_4086D7F2
.L9:
            moveq   #-$42,D0
            bra.b   .L8
.L10:
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     ($1800,A4),A4
            moveq   #-1,D2
            bra.b   .L13
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D1
            dbmi    D2,.L11
            bpl.b   .L15
            move.b  D1,(A0)+
            moveq   #$1E,D2
.L13:
            subq.l  #1,D0
            bge.b   .L11
            moveq   #0,D0
.L14:
            bra.w   sub_4086D7F2
.L15:
            moveq   #-$42,D0
            bra.b   .L14
