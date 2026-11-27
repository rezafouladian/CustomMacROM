.L25:
            dc.b    $FF,$3F,$CF,$F3,$FC,$FF,$D5,$AA,$96
            ds.b    5
            dc.w    $DEAA,$FFFF,$3FCF,$F3FC,$FFD5,$AAAD,0
.L26:
            suba.w  #$200,SP
            bsr.w   sub_408707EE
            move.w  ($1C,A0),D4
            beq.b   .L28
            moveq   #2,D3
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L27
            moveq   #3,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L27
            moveq   #1,D3
.L27:
            moveq   #-$32,D0
            cmp.w   D3,D4
            bhi.w   .L37
            cmpi.w  #3,D4
            seq     D0
            or.b    ($18,A1,D1.w),D0
            smi     ($17,A1,D1.w)
.L28:
            tst.b   ($138,A1)
            bpl.b   .L29
            bsr.w   SetChipMode
            bne.w   .L37
.L29:
            bsr.w   sub_4086D716
            tst.b   ($17,A1,D1.w)
            smi     ($32,A1)
            bmi.b   .L30
            tst.b   (5,A1,D1.w)
            smi     ($32,A1)
            bpl.b   .L30
            subq.w  #1,D4
            bne.b   .L30
            clr.b   ($32,A1)
.L30:
            tst.b   ($32,A1)
            sne     ($12,A1,D1.w)
            move.w  #8,($22,A1)
            bsr.w   sub_4086EA80
            moveq   #6,D0
            bsr.w   AdrAndSense
            bmi.b   .L31
            moveq   #-$2C,D0
            bra.b   .L37
.L31:
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            lea     .L25,A1
            moveq   #$B,D0
.L32:
            moveq   #$1A,D1
            movea.l A1,A2
.L33:
            move.b  (A2)+,(A0)+
            dbra    D1,.L33
            dbra    D0,.L32
            bsr.w   GetDrv1
            clr.w   ($16,A1)
.L34:
            bsr.b   sub_4086E768
            bne.b   .L37
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bpl.b   .L35
            bsr.w   mFmtTrack
            bra.b   .L36
.L35:
            bsr.w   FormatTrack
.L36:
            bne.b   .L37
            bsr.w   GetDrv1
            bclr    #3,($16,A1)
            addq.w  #1,($16,A1)
            cmpi.w  #$50,($16,A1)
            blt.b   .L34
            moveq   #0,D0
.L37:
            lea     ($200,SP),SP
            bra.w   DskRWOff
sub_4086E768:
            move.b  ($30,A1),($31,A1)
            move.w  ($16,A1),D6
            bsr.w   sub_4086EA66
            bsr.w   GetDrv1
            move.w  (0,A1,D1.w),D6
            bmi.b   .L1
            moveq   #0,D0
.L1:
            rts
FormatTrack:
            bsr.w   GetDrv1
            move.w  ($16,A1),D6
            move.w  D6,D1
            bclr    #$B,D1
            lsr.w   #4,D1
            moveq   #$C,D0
            sub.w   D1,D0
            move.w  D0,($20,A1)
            bsr.w   FillInMarks
.L1:
            bsr.b   sub_4086E81C
            beq.b   .L2
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            bra.w   .L6
.L2:
            bsr.w   sub_4086E174
            bmi.b   .L3
            tst.b   D2
            beq.b   .L3
            moveq   #-$52,D0
.L3:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            lea     ($22,A1),A0
            move.w  DskErr,D0
            bmi.b   .L8
            move.l  #$5E0,D2
            sub.w   D0,D2
            divu.w  #5,D2
            move.w  #$FFAD,DskErr
            sub.w   (A0),D2
            bmi.b   .L7
            ext.l   D2
            divu.w  ($20,A1),D2
            beq.b   .L4
            subq.w  #1,D2
            beq.b   .L4
            addq.w  #1,(A0)
.L4:
            bsr.w   GetDrv1
            bset    #3,($16,A1)
            bne.b   .L5
            tst.b   ($32,A1)
            bne.b   FormatTrack
.L5:
            clr.w   DskErr
.L6:
            move.w  DskErr,D0
            rts
.L7:
            addq.w  #1,D2
            beq.b   .L4
.L8:
            subq.w  #1,(A0)
            cmpi.w  #4,(A0)
            blt.b   .L6
            bra.b   .L1
sub_4086E81C:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            movea.l SonyVars,A1
            tst.b   ($32,A1)
            beq.b   .L1
            btst    #$B,D6
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l IWM,A4
            lea     ($1A00,A4),A3
            movea.l ($1C,A1),A0
            move.w  ($20,A1),D0
            move.w  ($22,A1),D1
            subq.w  #2,D1
            lea     Nibl.L25,A1
            move.w  #$C7,D3
            tst.b   (A3)
            move.b  D3,($1E00,A4)
            lea     ($1800,A4),A4
.L2:
            movea.l A1,A2
            moveq   #2,D2
.L3:
            move.b  (A2)+,D4
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D4,(A3)
            move.b  (A2)+,D4
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            tst.b   (A4)
            bpl.b   .L5
            move.b  D4,(A3)
            dbra    D2,.L3
            dbra    D3,.L2
.L6:
            move.w  D1,D3
.L7:
            movea.l A1,A2
            moveq   #5,D2
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (A2)+,(A3)
            tst.b   (A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            dbra    D2,.L8
            dbra    D3,.L7
            moveq   #$1A,D2
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  (A0)+,(A3)
            tst.b   (A5)
            bmi.b   .L11
            move.b  (A6),-(SP)
.L11:
            dbra    D2,.L10
            move.w  #$2BE,D2
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  #$96,(A3)
            tst.b   (A5)
            bmi.b   .L13
            move.b  (A6),-(SP)
.L13:
            dbra    D2,.L12
            moveq   #3,D2
            addq.w  #8,A2
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (A2)+,(A3)
            dbra    D2,.L14
            subq.w  #1,D0
            bgt.b   .L6
            move.b  (A4),D0
            moveq   #0,D2
            btst    #6,D0
            bne.b   .L15
            moveq   #-$4A,D0
            bra.b   .L16
.L15:
            moveq   #0,D0
.L16:
            tst.b   ($200,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
FillInMarks:
            movem.l D0-D7/A0-A1,-(SP)
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            moveq   #2,D3
            tst.b   ($32,A1)
            beq.b   .L1
            moveq   #$22,D3
.L1:
            movea.l ($25A).w,A1
            move.b  (0,A1,D3.w),D7
            move.b  D3,D5
            moveq   #$3F,D3
            and.b   D6,D3
            move.b  (0,A1,D3.w),D2
            eor.b   D3,D5
            lsr.w   #6,D6
            eor.b   D6,D5
            move.b  (0,A1,D6.w),D6
            move.w  D0,D1
            subq.w  #1,D1
            lsr.w   #1,D1
            addq.w  #1,D1
            swap    D1
            clr.w   D1
.L2:
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
            lea     ($C,A0),A0
            move.b  D3,(A0)+
            addq.w  #1,D1
            swap    D1
            subq.w  #1,D0
            bne.b   .L2
            movem.l (SP)+,D0-D7/A0-A1
            rts
CtlVerify:
            suba.w  #$200,SP
            bsr.w   sub_408707EE
            tst.b   ($138,A1)
            bpl.b   .L1
            bsr.w   SetChipMode
            bne.w   Nibl.L37
.L1:
            bsr.w   sub_4086EA80
            moveq   #4,D2
            move.w  #$7F,D4
            moveq   #$4F,D6
.L2:
            lsl.w   #1,D4
            addq.w  #1,D4
            moveq   #$F,D3
.L3:
            movem.l D2-D6,-(SP)
            bsr.w   sub_4086EA66
            movem.l (SP)+,D2-D6
            bsr.w   GetDrv1
            move.w  (0,A1,D1.w),D0
            bmi.b   .L6
            tst.b   ($17,A1,D1.w)
            bpl.b   .L4
            bsr.w   sub_4086F306
            bra.b   .L5
.L4:
            bsr.b   VerTrack
.L5:
            bne.b   .L6
            subq.w  #1,D6
            dbra    D3,.L3
            dbra    D2,.L2
.L6:
            bra.w   Nibl.L37
VerTrack:
            movem.l D2-D6,-(SP)
            ori     #$700,SR
            lea     ($22,A1),A0
            move.w  D4,(A0)
            moveq   #$C,D3
            sub.w   D2,D3
            lsl.w   #2,D3
            move.w  D3,(2,A0)
            move.l  (A0)+,(A0)+
            bclr    #3,($16,A1)
.L1:
            move.l  D1,D6
            bsr.w   RdAddrSetup
            bpl.b   .L2
            bsr.b   toEmptyPD
            andi    #$F8FF,SR
            bra.b   .L7
.L2:
            lea     ($20,A1),A0
            move.w  D2,(A0)+
            move.w  (A0)+,D0
            bclr    D2,D0
            bne.b   .L3
            bsr.b   toEmptyPD
            andi    #$F8FF,SR
            lea     ($24,A1),A0
            bra.b   .L4
.L3:
            cmpi.b  #$1F,D3
            sgt     ($12,A1,D6.w)
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   RdData
            bsr.b   toEmptyPD
            tst.w   D0
            bne.b   .L7
            lea     ($20,A1),A0
            move.w  (A0)+,D2
            move.w  (A0),D0
            bclr    D2,D0
            move.w  D0,(A0)+
            beq.b   .L5
.L4:
            subq.w  #1,(A0)
            bne.b   .L1
            moveq   #-$54,D0
            bra.b   .L7
.L5:
            bsr.w   GetDrv1
            tst.b   ($12,A1,D1.w)
            beq.b   .L6
            bset    #3,($16,A1)
            bne.b   .L6
            addq.w  #2,A0
            move.l  (A0),-(A0)
            bra.b   .L1
.L6:
            moveq   #0,D0
.L7:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D6
            tst.w   D0
            rts
toEmptyPD:
            move.w  D0,DskErr
            bra.w   EmptyPD
sub_4086EA66:
            lea     sub_4086D4AE,A0
.L1:
            clr.b   DskErr
            bsr.b   sub_4086EA78
.L2:
            tst.b   DskErr
            beq.b   .L2
            rts
sub_4086EA78:
            jsr     (A0)
            st      DskErr
            rts
sub_4086EA80:
            lea     PowerUp,A0
            bra.b   sub_4086EA66.L1
