.L5:
            dc.b    $D5,$AA,$96,$DE,$AA,$FF         ; address marks
SetUpPoll:
            move.l  ($23A).w,-(SP)
            rts
jtSetUpPoll:
            movea.l SCCRd,A6
            addq.l  #6,A6
            movea.l VIA,A5
            lea     ($1E00,A5),A5
            ori     #$700,SR
            move.l  SP,PollStack
            add.l   D0,PollStack
            rts
RdAddrSetup:
            moveq   #8,D0
            bsr.b   SetUpPoll
            moveq   #1,D0
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
sub_4086E174:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   mPulse.L18
            lea     sub_4086E0AA.L5,A2
            move.l  ($22A).w,-(SP)
            rts
jtRdAddr:
            moveq   #3,D3
            move.w  #$23F,D2
            moveq   #0,D5
            movea.l IWM,A4
            lea     ($1800,A4),A4
            move.l  (SP)+,DskRtnAdr
.L1:
            move.b  (A5),(A5)
            bmi.b   .L2
            move.b  (A6),-(SP)
.L2:
            move.b  (A4),D5
            dbra    D2,.L3
            moveq   #-$42,D0
            bra.w   .L16
.L3:
            bpl.b   .L1
            subq.w  #1,D3
            bne.b   .L1
            move.w  #$5DC,D0
            tst.b   ($13,A1,D1.w)
            beq.b   .L4
            move.w  #$5BC,D0
.L4:
            lea     jtRdData.DNib-$96,A3
.L5:
            movea.l A2,A0
            moveq   #3,D1
.L6:
            move.b  (A4),D5
            bpl.b   .L6
            move.b  (A5),(A5)
            bmi.b   .L7
            move.b  (A6),-(SP)
.L7:
            dbra    D0,.L8
            moveq   #-$43,D0
            bra.b   .L16
.L8:
            cmp.b   (A0)+,D5
            bne.b   .L5
            subq.w  #1,D1
            bne.b   .L6
            move.b  (A5),(A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            move.b  (A4),D5
            bpl.b   .L9
            move.b  (0,A3,D5.w),D1
            move.b  D1,D4
            ror.w   #6,D1
            move.b  (A5),(A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            move.b  (A4),D5
            bpl.b   .L10
            moveq   #0,D2
            move.b  (0,A3,D5.w),D2
            eor.b   D2,D4
            move.b  (A5),(A5)
            bmi.b   .L11
            move.b  (A6),-(SP)
.L11:
            move.b  (A4),D5
            bpl.b   .L11
            move.b  (0,A3,D5.w),D1
            eor.b   D1,D4
            rol.w   #6,D1
            move.b  (A5),(A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D5
            bpl.b   .L12
            move.b  (0,A3,D5.w),D3
            eor.b   D3,D4
            move.b  (A5),(A5)
            bmi.b   .L13
            move.b  (A6),-(SP)
.L13:
            move.b  (A4),D5
            bpl.b   .L13
            move.b  (0,A3,D5.w),D5
            eor.b   D5,D4
            bne.b   .L17
            moveq   #1,D4
.L14:
            move.b  (A5),(A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            move.b  (A4),D5
            bpl.b   .L15
            cmp.b   (A0)+,D5
            bne.b   .L18
            dbra    D4,.L14
.L16:
            bra.w   sub_4086D7F2
.L17:
            moveq   #-$45,D0
            bra.b   .L16
.L18:
            moveq   #-$46,D0
            bra.b   .L16
DtaMks:
            dc.b    $D5,$AA,$AD,$DE,$AA,$FF         ; data marks
RdData:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   sub_4086EEDC
            lea     DtaMks,A1
            move.l  ($22E).w,-(SP)
            rts
jtRdData:
            move.l  (SP)+,DskRtnAdr
            moveq   #$30,D2
            moveq   #0,D3
            moveq   #-$40,D0
            move.l  #$1FE000A,D4
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
.L1:
            movea.l A1,A2
            moveq   #3,D1
.L2:
            move.b  (A4),D3
            bpl.b   .L2
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            dbra    D2,.L4
            moveq   #-$47,D0
            bra.b   jtRdAddr.L16
.L4:
            cmp.b   (A2)+,D3
            bne.b   .L1
            subq.w  #1,D1
            bne.b   .L2
.L5:
            move.b  (A4),D3
            bpl.b   .L5
            lea     ($2FB).w,A1
            move.b  (0,A3,D3.w),(A1)+
.L6:
            tst.b   (A5)
            bmi.b   .L7
            move.b  (A6),-(SP)
.L7:
            move.b  (A4),D3
            bpl.b   .L6
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L8:
            move.b  (A4),D3
            bpl.b   .L8
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            move.b  D2,(A1)+
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L9:
            move.b  (A4),D3
            bpl.b   .L9
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            move.b  D2,(A1)+
            addx.b  D2,D6
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            move.b  (A4),D3
            bpl.b   .L10
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            move.b  D1,(A1)+
            addx.b  D1,D7
            subq.w  #3,D4
            bpl.b   .L6
            swap    D4
            tst.b   DskVerify
            beq.b   .L12
            bra.b   .L17
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D3
            bpl.b   .L11
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L13:
            move.b  (A4),D3
            bpl.b   .L13
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            move.b  D2,(A0)+
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L14:
            move.b  (A4),D3
            bpl.b   .L14
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            move.b  D2,(A0)+
            addx.b  D2,D6
            tst.w   D4
            beq.b   .L23
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            move.b  (A4),D3
            bpl.b   .L15
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            move.b  D1,(A0)+
            addx.b  D1,D7
            subq.w  #3,D4
            bra.b   .L11
.L16:
            tst.b   (A5)
            bmi.b   .L17
            move.b  (A6),-(SP)
.L17:
            move.b  (A4),D3
            bpl.b   .L16
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L18:
            move.b  (A4),D3
            bpl.b   .L18
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            cmp.b   (A0)+,D2
            bne.b   .L22
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L19:
            move.b  (A4),D3
            bpl.b   .L19
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            cmp.b   (A0)+,D2
            bne.b   .L29
            addx.b  D2,D6
            tst.w   D4
            beq.b   .L23
            rol.b   #2,D1
            and.b   D0,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            move.b  (A4),D3
            bpl.b   .L21
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            cmp.b   (A0)+,D1
.L22:
            bne.b   .L29
            addx.b  D1,D7
            subq.w  #3,D4
            bra.b   .L16
.L23:
            tst.b   (A5)
            bmi.b   .L24
            move.b  (A6),-(SP)
.L24:
            move.b  (A4),D3
            bpl.b   .L24
            move.b  (0,A3,D3.w),D1
            bmi.b   .L28
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L25:
            move.b  (A4),D3
            bpl.b   .L25
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D2
            cmp.b   D2,D5
            bne.b   .L28
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L26:
            move.b  (A4),D3
            bpl.b   .L26
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D2
            cmp.b   D2,D6
            bne.b   .L28
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L27
            move.b  (A6),-(SP)
.L27:
            move.b  (A4),D3
            bpl.b   .L27
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D1
            cmp.b   D1,D7
            beq.b   .L30
.L28:
            moveq   #-$48,D0
            bra.b   .L33
.L29:
            moveq   #-$44,D0
            bra.b   .L33
.L30:
            moveq   #1,D4
.L31:
            move.b  (A4),D3
            bpl.b   .L31
            tst.b   (A5)
            bmi.b   .L32
            move.b  (A6),-(SP)
.L32:
            cmp.b   (A2)+,D3
            bne.b   .L34
            dbra    D4,.L31
            moveq   #0,D0
.L33:
            bra.w   sub_4086D7F2
.L34:
            moveq   #-$49,D0
            bra.b   .L33
; Denibblizing table (nibbles $96 thru $FF converted to $00 thru $3F)
.DNib:
            dc.b    $00,$01,$FF,$FF,$02,$03         ; $96,$97,   ,   ,$9A,$9B
            dc.b    $FF,$04,$05,$06,$FF,$FF         ; ,$9D,$9E,$9F,   ,
            dc.b    $FF,$FF,$FF,$FF,$07,$08         ; ,   ,   ,   ,$A6,$A7
            dc.b    $FF,$FF,$FF,$09,$0A,$0B         ; ,   ,   ,$AB,$AC,$AD
            dc.b    $0C,$0D,$FF,$FF,$0E,$0F         ; $AE,$AF,   ,   ,$B2,$B3
            dc.b    $10,$11,$12,$13,$FF,$14         ; $B4,$B5,$B6,$B7,   ,$B9
            dc.b    $15,$16,$17,$18,$19,$1A         ; $BA,$BB,$BC,$BD,$BE,$BF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF         ; ,   ,   ,   ,   ,
            dc.b    $FF,$FF,$FF,$FF,$FF,$1B         ; ,   ,   ,   ,   ,$CB
            dc.b    $FF,$1C,$1D,$1E,$FF,$FF         ; ,$CD,$CE,$CF,
            dc.b    $FF,$1F,$FF,$FF,$20,$21         ; ,$D3,   ,   ,$D6,$D7
            dc.b    $FF,$22,$23,$24,$25,$26         ; ,$D9,$DA,$DB,$DC,$DD
            dc.b    $27,$28,$FF,$FF,$FF,$FF         ; $DE,$DF,
            dc.b    $FF,$29,$2A,$2B,$FF,$2C         ; ,$E5,$E6,$E7,   ,$E9
            dc.b    $2D,$2E,$2F,$30,$31,$32         ; $EA,$EB,$EC,$ED,$EE,$EF
            dc.b    $FF,$FF,$33,$34,$35,$36         ; ,   ,$F2,$F3,$F4,$F5
            dc.b    $37,$38,$FF,$39,$3A,$3B         ; $F6,$F7,   ,$F9,$FA,$FB
            dc.b    $3C,$3D,$3E,$3F                 ; $FC,$FD,$FE,$FF
