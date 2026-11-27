Check4SWIM:
            movea.l SonyVars,A1
            move    SR,-(SP)
            ori     #$700,SR
            movea.l IWM,A0
            tst.b   ($1400,A0)
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            moveq   #-9,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            st      ($138,A1)
            move.b  #$F8,($C00,A0)
.L1:
            tst.b   ($1C00,A0)
            tst.b   ($1800,A0)
            tst.b   ($1200,A0)
            move    (SP)+,SR
            rts
SetChipMode:
            bsr.w   GetDrv1
            tst.b   ($138,A1)
            bpl.w   SetIWMMode
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #1,D2
.L1:
            movea.l IWM,A0
            move.b  #$38,($C00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            moveq   #-9,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            tst.b   ($17,A1,D1.w)
            bmi.b   .L3
            move.b  #$F8,($C00,A0)
            tst.b   ($1C00,A0)
.L2:
            clr.b   ($139,A1)
            move.l  D2,-(SP)
            bsr.w   SetIWMMode
            move.l  (SP)+,D2
            tst.w   D0
            bne.b   .L7
            tst.b   ($17,A1,D1.w)
            bpl.b   .L7
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            dbra    D2,.L1
            bra.b   .L5
.L3:
            move.b  #$38,($C00,A0)
            move.b  #$C0,($400,A0)
            moveq   #$20,D0
            move.b  D0,($A00,A0)
            cmp.b   ($1A00,A0),D0
            bne.b   .L4
            bsr.b   NotSWIM2
            beq.b   .L6
.L4:
            move.b  #$F8,($C00,A0)
.L5:
            tst.b   ($1C00,A0)
            moveq   #-$4D,D0
.L6:
            seq     ($139,A1)
.L7:
            move    (SP)+,SR
            tst.w   D0
            rts
NotSWIM2:
            move.w  (0,A1,D1.w),D0
            movea.l VIA,A1
            lea     ($1E00,A1),A1
            lea     .L6,A2
.L1:
            addq.w  #2,A2
            cmp.w   (A2)+,D0
            bge.b   .L1
            move.w  (A2),D0
            lea     mParamZones(PC,D0.w),A2
            moveq   #4,D2
.L2:
            move.b  #$38,($C00,A0)
            swap    D2
            moveq   #$F,D0
.L3:
            move.b  (A1),(A1)
            move.b  ($1600,A0),D2
            cmp.b   (0,A2,D0.w),D2
            dbne    D0,.L3
            bne.b   .L4
            movea.l SonyVars,A1
            moveq   #0,D0
            rts
.L4:
            move.b  #$38,($C00,A0)
            moveq   #$F,D0
.L5:
            move.b  (A1),(A1)
            move.b  (0,A2,D0.w),($600,A0)
            dbra    D0,.L5
            swap    D2
            dbra    D2,.L2
            movea.l SonyVars,A1
            moveq   #-$4D,D0
.L6:
            rts
mParamZones:
            dc.w    80,mParams-mParamZones
            dc.w    80,mParams+16-mParamZones
            dc.w    80,mParams-mParamZones
            dc.w    80,mParams-mParamZones
mParams:
            dc.b    $3B,$57,$1B,$97,$19,$19,$2F,$2F,$1B,$1B,$18,$18,$2E,$2E,$41,$18
gParams:
            dc.b    $3B,$57,$1B,$97,$19,$19,$2F,$2F,$1B,$1B,$18,$18,$2E,$2E,$41,$18
; Alternate parameter sets which may be used in the future or removed entirely.
            dc.b    'SO...WHAT ARE YOU STARING AT?   '
ChkDiskType:
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L11
            moveq   #$F,D0
            bsr.w   AdrAndSense
            spl     ($18,A1,D1.w)
            bsr.b   GetASector
            tst.w   D0
            bmi.b   .L9
            move.b  ($18,A1,D1.w),($17,A1,D1.w)
            bpl.b   .L11
            addq.b  #1,(3,A1,D1.w)
            move.w  #$FE70,D0
            bra.w   DskRWOff
.L9:
            st      ($17,A1,D1.w)
            bsr.w   Recal
            bne.b   .L10
            tst.b   ($18,A1,D1.w)
            bmi.b   .L11
            bsr.b   GetASector
            subi.b  #$22,D3
            or.w    D3,D0
            beq.b   .L11
.L10:
            move.b  ($18,A1,D1.w),($17,A1,D1.w)
.L11:
            bra.w   jtDiskPrime.L5
GetASector:
            moveq   #5,D1
.L1:
            move.w  D1,-(SP)
            move    SR,-(SP)
            clr.w   ($16,A1)
            bsr.w   RdAddrSetup
            bsr.w   EmptyPD
            move    (SP)+,SR
            move.w  (SP)+,D1
            tst.w   D0
            dbpl    D1,.L1
            bra.w   GetDrv1
mAdrDisk:
            move.b  #$F3,($800,A0)
            btst    #1,D0
            beq.b   .L3
            bset    #5,($1E00,A2)
            bra.b   .L4
.L3:
            bclr    #5,($1E00,A2)
.L4:
            move.b  .L5(PC,D0.w),($800,A0)
            rts
.L5:
            dc.w    $F0F4,$F0F4,$F1F5,$F1F5,$F2F6,$F2F6,$F3F7,$F3F7
            dc.w    $5357,$4321
mSense:
            btst    #3,($1E00,A0)
            sne     D0
            tst.b   D0
            rts
mPulse:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  D0,-(SP)
            moveq   #-8,D0
            or.b    ($1800,A0),D0
            move.b  D0,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            subq.b  #8,D0
            move.b  D0,($800,A0)
            move.l  (SP)+,D0
            move    (SP)+,SR
            rts
.L8:
            cmpi.w  #$4A,D1
            bne.b   .L9
            move.b  #4,($C00,A0)
            move.b  #$82,($E00,A0)
            rts
.L9:
            move.b  #$F7,($800,A0)
            bclr    #5,($1E00,A2)
            tst.b   ($FC,A1)
            beq.b   .L10
            move.b  #2,($C00,A0)
            move.b  #$84,($E00,A0)
            rts
.L10:
            cmpi.w  #$8C,D1
            bne.b   .L14
            move.b  #2,($C00,A0)
            move.b  #$84,($E00,A0)
            moveq   #2,D0
.L11:
            move    SR,-(SP)
            ori     #$700,SR
            bra.b   .L13
.L12:
            move.b  #$FF,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F7,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F5,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F7,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
.L13:
            btst    #3,($1E00,A0)
            dbeq    D0,.L12
            move    (SP)+,SR
            rts
.L14:
            move.b  #4,($E00,A0)
            move.b  #$80,($C00,A0)
            move.w  ($12,A1),D0
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$80,($E00,A0)
            subq.w  #3,D0
            bra.b   .L11
.L15:
            moveq   #$5A,D2
            lsl.w   #4,D2
            moveq   #9,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L16
            add.w   D2,D2
            moveq   #$12,D3
.L16:
            cmp.l   D2,D0
            bge.w   GetTrack.L13
            divu.w  D3,D0
            lsr.w   #1,D0
            scs     D6
            move.w  D0,D5
            swap    D0
            moveq   #-1,D2
            addq.w  #1,D3
            bra.w   GetTrack.L18
.L17:
            dc.w    $A1A1,$A1FE
.L18:
            lea     .L17,A2
            move.l  ($680).w,-(SP)
            rts
jtMRdAddr:
            move.l  (SP)+,DskRtnAdr
            lea     BufTgFNum,A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            movea.l IWM,A4
            lea     ($1E00,A4),A3
            lea     ($1200,A4),A4
            moveq   #-$43,D0
            move.w  #$4E20,D2
.L19:
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            movea.l A2,A0
            moveq   #3,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A3)
            dbmi    D2,.L20
            bpl.w   jtMRdData.L14
            move.b  (A4),D5
            cmp.b   (A0)+,D5
            dbne    D1,.L20
            bne.b   .L19
            moveq   #$1E,D0
.L22:
            tst.b   (A3)
            dbmi    D0,.L22
            bpl.b   .L28
            moveq   #0,D1
            move.b  (A4),D1
            lea     BufTgFNum,A0
            move.b  D1,(A0)+
            moveq   #$1E,D0
.L23:
            tst.b   (A3)
            dbmi    D0,.L23
            bpl.b   .L28
            move.b  (A4),(A0)+
            beq.b   .L24
            bset    #$B,D1
.L24:
            moveq   #$1E,D0
            moveq   #0,D2
.L25:
            tst.b   (A3)
            dbmi    D0,.L25
            bpl.b   .L28
            move.b  (A4),D2
            move.b  D2,(A0)+
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            moveq   #$1E,D0
            moveq   #$20,D3
.L27:
            tst.b   (A3)
            dbmi    D0,.L27
            bpl.b   .L28
            or.b    (A4),D3
            move.b  D3,(A0)+
            moveq   #-$45,D0
            bra.w   jtMRdData.L11
.L28:
            bra.w   jtMRdData.L15
mAdrDisk9:
            dc.w    $A1A1,$A1FB
sub_4086EEDC:
            lea     mAdrDisk9,A1
            move.l  ($684).w,-(SP)
            rts
jtMRdData:
            move.l  (SP)+,DskRtnAdr
            move.w  #$1FF,D4
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            moveq   #-$47,D0
            moveq   #3,D1
            moveq   #-1,D2
.L1:
            tst.b   (A5)
            bmi.b   .L2
            move.b  (A6),-(SP)
.L2:
            tst.b   (A3)
            dbmi    D2,.L1
            bpl.b   .L6
            moveq   #$1E,D2
            move.b  (A4),D5
            cmp.b   (A1)+,D5
            dbne    D1,.L1
            bne.b   .L14
            tst.b   DskVerify
            bne.b   .L7
.L3:
            tst.b   (A3)
            bmi.b   .L5
            moveq   #$1E,D1
            tst.b   (A5)
            bmi.b   .L4
            move.b  (A6),-(SP)
.L4:
            tst.b   (A3)
            dbmi    D1,.L4
            bpl.b   .L6
.L5:
            move.b  (A4),(A0)+
            dbra    D4,.L3
            bra.b   .L10
.L6:
            bra.b   .L15
.L7:
            tst.b   (A3)
            bmi.b   .L9
            moveq   #$1E,D1
            tst.b   (A5)
            bmi.b   .L8
            move.b  (A6),-(SP)
.L8:
            tst.b   (A3)
            dbmi    D1,.L8
            bpl.b   .L6
.L9:
            move.b  (A4),D2
            cmp.b   (A0)+,D2
            dbne    D4,.L7
            bne.b   .L16
.L10:
            moveq   #-$48,D0
            lea     BufTgDate,A0
.L11:
            moveq   #$1E,D4
.L12:
            tst.b   (A3)
            dbmi    D4,.L12
            bpl.b   .L15
            move.b  (A4),(A0)+
            moveq   #$1E,D4
.L13:
            move.b  (A3),D5
            dbmi    D4,.L13
            bpl.b   .L15
            move.b  (A4),(A0)+
            move.b  ($200,A4),(A0)+
            move.b  D5,(A0)
            andi.b  #$22,D5
            bne.b   .L14
            moveq   #0,D0
.L14:
            move.b  #$18,(-$600,A4)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
.L15:
            moveq   #-$42,D0
            bra.b   .L14
.L16:
            moveq   #-$44,D0
            bra.b   .L14
.L17:
            lea     mAdrDisk9,A2
            move.l  ($688).w,-(SP)
            rts
jtMWrData:
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     (A4),A3
            lea     ($1E00,A4),A4
            move.b  #$F5,($800,A3)
            tst.b   ($1400,A3)
            move.b  #$18,($C00,A3)
            move.b  #$10,($E00,A3)
            move.b  #1,($E00,A3)
            move.b  #1,($C00,A3)
            tst.b   ($1400,A3)
            move.w  #$4978,D0
            mulu.w  TimeVIADB,D0
            swap    D0
.L18:
            btst    #7,(A5)
            dbeq    D0,.L18
            bne.b   .L19
            move.b  (A6),-(SP)
            subq.w  #2,D0
            bpl.b   .L18
.L19:
            moveq   #9,D0
            moveq   #0,D1
            move.b  D1,(A3)
            move.b  D1,(A3)
            move.b  #8,($E00,A3)
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
            move.b  (A2)+,($200,A3)
            dbra    D0,.L22
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  (A2),(A3)
            move.w  #$1FF,D0
.L25:
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            tst.b   (A4)
            bpl.b   .L26
            move.b  (A0)+,(A3)
            dbra    D0,.L25
.L27:
            tst.b   (A4)
            bpl.b   .L27
            move.b  D0,($400,A3)
            moveq   #3,D0
.L28:
            tst.b   (A5)
            bmi.b   .L29
            move.b  (A6),-(SP)
.L29:
            move.b  (A4),D2
            bpl.b   .L29
            move.b  #$4E,(A3)
            dbra    D0,.L28
            moveq   #0,D0
            btst    #5,D2
            beq.b   .L30
            moveq   #-$4A,D0
.L30:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
mFmtTrack:
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
            bsr.b   sub_4086F0DC
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            move.w  DskErr,D0
            bne.b   .L4
            bsr.w   GetDrv1
            bset    #3,($16,A1)
            beq.b   mFmtTrack
            moveq   #0,D0
.L4:
            rts
sub_4086F0DC:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            tst.w   D5
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
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
            move.b  #$F6,(A3)
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
            moveq   #-$4A,D0
.L46:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
sub_4086F306:
            movem.l D2-D7,-(SP)
            ori     #$700,SR
            move.w  D6,($16,A1)
.L1:
            moveq   #$24,D7
            move.l  #$3FE,D6
            tst.b   ($18,A1,D1.w)
            bpl.b   .L2
            moveq   #$48,D7
            move.l  #$7FFFE,D6
.L2:
            bsr.w   RdAddrSetup
            bne.b   .L3
            btst    D2,D6
            beq.b   .L3
            cmp.w   ($16,A1),D1
            bne.b   .L3
            move.w  D2,D3
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   sub_4086EEDC
            bne.b   .L3
            bclr    D3,D6
.L3:
            bsr.w   toEmptyPD
            tst.l   D6
            dbeq    D7,.L2
            beq.b   .L4
            moveq   #-$54,D0
            bra.b   .L5
.L4:
            bset    #3,($16,A1)
            beq.b   .L1
.L5:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D7
            tst.w   D0
            rts
