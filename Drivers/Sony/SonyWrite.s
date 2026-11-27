.L35:
            dc.w    $FF3F,$CFF3,$FCFF,$D5AA
WrData:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   jtMRdData.L17
            lea     jtRdData.L35,A2
            move.l  ($232).w,-(SP)
            rts
jtWrData:
            move.l  (SP)+,DskRtnAdr
            lea     ($2FB).w,A1
            move.l  #$2010009,D4
            moveq   #0,D2
            moveq   #0,D3
            movea.l IWM,A3
            tst.b   ($1A00,A3)
            moveq   #6,D0
            moveq   #0,D5
            move.b  (A2)+,($1E00,A3)
            lea     ($1A00,A3),A3
            moveq   #0,D6
            moveq   #0,D7
.L1:
            move.b  (A2)+,D1
.L2:
            tst.b   (A4)
            bpl.b   .L2
            move.b  D1,(A3)
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            subq.w  #1,D0
            bne.b   .L1
            move.b  (A2)+,D1
            lea     Nibl,A2
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D1,(A3)
            moveq   #$B,D1
            move.b  (A1)+,D2
            bra.b   .L10
.L5:
            movea.l A0,A1
.L6:
            addx.b  D2,D7
            eor.b   D6,D2
            move.b  D2,D3
            lsr.w   #6,D3
.L7:
            tst.b   (A4)
            bpl.b   .L7
            move.b  (0,A2,D3.w),(A3)
            subq.w  #3,D4
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            andi.b  #$3F,D0
.L8:
            tst.b   (A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (0,A2,D0.w),(A3)
.L10:
            move.b  (A1)+,D0
            addx.b  D0,D5
            eor.b   D7,D0
            move.b  D0,D3
            rol.w   #2,D3
            andi.b  #$3F,D1
.L11:
            tst.b   (A4)
            bpl.b   .L11
            move.b  (0,A2,D1.w),(A3)
            move.b  (A1)+,D1
            addx.b  D1,D6
            eor.b   D5,D1
            move.b  D1,D3
            rol.w   #2,D3
            andi.b  #$3F,D2
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  (0,A2,D2.w),(A3)
            move.b  (A1)+,D2
            tst.w   D4
            bne.b   .L6
            swap    D4
            bne.b   .L5
            clr.b   D3
            lsr.w   #6,D3
.L13:
            tst.b   (A4)
            bpl.b   .L13
            move.b  (0,A2,D3.w),(A3)
            move.b  D5,D3
            rol.w   #2,D3
            move.b  D6,D3
            rol.w   #2,D3
            andi.b  #$3F,D0
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (0,A2,D0.w),(A3)
            andi.b  #$3F,D1
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  (0,A2,D1.w),(A3)
            move.b  D7,D3
            lsr.w   #6,D3
.L16:
            tst.b   (A4)
            bpl.b   .L16
            move.b  (0,A2,D3.w),(A3)
            andi.b  #$3F,D5
.L17:
            tst.b   (A4)
            bpl.b   .L17
            move.b  (0,A2,D5.w),(A3)
            andi.b  #$3F,D6
            tst.b   (A5)
            bmi.b   .L18
            move.b  (A6),-(SP)
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  (0,A2,D6.w),(A3)
            andi.b  #$3F,D7
.L19:
            tst.b   (A4)
            bpl.b   .L19
            move.b  (0,A2,D7.w),(A3)
            lea     .L23,A2
            moveq   #3,D2
.L20:
            move.b  (A4),D1
            bpl.b   .L20
            move.b  (A2)+,(A3)
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            dbra    D2,.L20
            moveq   #0,D0
            btst    #6,D1
            bne.b   .L22
            moveq   #-$4A,D0
.L22:
            tst.b   ($200,A3)
            bra.w   sub_4086D7F2
.L23:
            dc.w    $DEAA,$FFFF
Nibl:
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
