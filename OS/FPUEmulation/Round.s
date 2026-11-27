round:
            bsr.b   sub_4088FB88
            tst.l   D0
            bne.b   .L1
            swap    D1
            bra.w   sub_4088FB88.L12
.L1:
            ori.l   #$208,(-$7C,A6)
            lea     .L2,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
.L2:
.a_293C:
            dc.w    InstallFPSP+$2976-.a_293C
            dc.w    InstallFPSP+$2970-.a_293C
            dc.w    InstallFPSP+$295A-.a_293C
            dc.w    .a_2944-.a_293C
.a_2944:
            swap    D1
            tst.b   ($2,A0)
            bmi.w   sub_4088FB88.L12
            moveq   #-1,D0
            lea     (sub_4088FB88.L6.w,PC),A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
            swap    D1
            tst.b   (2,A0)
            bpl.w   sub_4088FB88.L12
            moveq   #-1,D0
            lea     sub_4088FB88.L6,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
            swap    D1
            bra.w   sub_4088FB88.L12
            swap    D1
            asl.l   #1,D0
            bcc.w   sub_4088FB88.L12
            lea     sub_4088FB88.L6,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
sub_4088FB88:
            swap    D1
            cmpi.w  #0,D1
            bne.b   .L1
            bra.b   .L5
.L1:
            movem.l D2-D3,-(SP)
            cmpi.w  #1,D1
            bne.b   .L2
            bfextu  (4,A0){24:2},D3
            moveq   #$1E,D2
            lsl.l   D2,D3
            move.l  (4,A0),D2
            andi.l  #$3F,D2
            bne.b   .L3
            tst.l   (8,A0)
            bne.b   .L3
            tst.l   D0
            bne.b   .L3
            bra.b   .L4
.L2:
            bfextu  (8,A0){21:2},D3
            moveq   #$1E,D2
            lsl.l   D2,D3
            move.l  (8,A0),D2
            andi.l  #$1FF,D2
            bne.b   .L3
            tst.l   D0
            bne.b   .L3
            bra.b   .L4
.L3:
            bset    #$1D,D3
.L4:
            move.l  D3,D0
            movem.l (SP)+,D2-D3
.L5:
            swap    D1
            rts
.L6:
.a_29E8:
            dc.w    InstallFPSP+$2A1C-.a_29E8
            dc.w    .a_29F0-.a_29E8
            dc.w    InstallFPSP+$2A46-.a_29E8
            dc.w    InstallFPSP+$2A46-.a_29E8
.a_29F0:
            addi.l  #$100,($4,A0)
            bcc.b   .a_2A04
            roxr.w  ($4,A0)
            roxr.w  ($6,A0)
            addq.w  #$1,(A0)
.a_2A04:
            tst.l   D0
            bne.b   .a_2A0E
            andi.w  #$FE00,($6,A0)
.a_2A0E:
            andi.l  #$FFFFFF00,($4,A0)
            clr.l   ($8,A0)
            rts
            addq.l  #1,(8,A0)
            bcc.b   .L7
            addq.l  #1,(4,A0)
            bcc.b   .L7
            roxr    (4,A0)
            roxr    (6,A0)
            roxr    (8,A0)
            roxr    ($A,A0)
            addq.w  #1,(A0)
.L7:
            tst.l   D0
            bne.b   .L8
            andi.b  #$FE,($B,A0)
.L8:
            rts
            addi.l  #$800,(8,A0)
            bcc.b   .L9
            addq.l  #1,(4,A0)
            bcc.b   .L9
            roxr    (4,A0)
            roxr    (6,A0)
            roxr    (8,A0)
            roxr    ($A,A0)
            addq.w  #1,(A0)
.L9:
            tst.l   D0
            bne.b   .L10
            andi.w  #$F000,($A,A0)
.L10:
            andi.l  #$FFFFF800,(8,A0)
            rts
.L11:
            dc.l    $0012FF92,$FFF6FFF6
.L12:
            lea     .L11,A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
            rts
sub_4088FC90:
            move.w  (A0),D0
            cmpi.w  #$40,D0
            bmi.b   .L1
            bsr.b   sub_4088FCF8
            rts
.L1:
            movem.l D2-D3/D5-D6,-(SP)
            move.l  (4,A0),D1
            move.l  (8,A0),D2
            bfffo   D1{0:0},D3
            beq.b   .L3
            cmp.w   D3,D0
            bmi.b   .L2
            bsr.b   sub_4088FCF8
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L2:
            move.l  D2,D6
            lsl.l   D0,D2
            lsl.l   D0,D1
            moveq   #$20,D5
            sub.l   D0,D5
            lsr.l   D5,D6
            or.l    D6,D1
            moveq   #0,D0
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            move.l  D2,(8,A0)
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L3:
            bfffo   D2{0:0},D3
            beq.b   .L4
            addi.w  #$20,D3
            cmp.w   D3,D0
            bmi.b   .L2
            bsr.b   sub_4088FCF8
            movem.l (SP)+,D2-D3/D5-D6
            rts
.L4:
            clr.w   (A0)
            movem.l (SP)+,D2-D3/D5-D6
            rts
sub_4088FCF8:
            move.l  D7,-(SP)
            bfffo   (4,A0){0:0},D7
            beq.b   .L1
            move.l  D6,-(SP)
            sub.w   D7,(A0)
            move.l  (4,A0),D0
            move.l  (8,A0),D1
            lsl.l   D7,D0
            move.l  D1,D6
            lsl.l   D7,D6
            move.l  D6,(8,A0)
            moveq   #$20,D6
            sub.l   D7,D6
            lsr.l   D6,D1
            or.l    D1,D0
            move.l  D0,(4,A0)
            movem.l (SP)+,D6-D7
            rts
.L1:
            move.w  (A0),D0
            move.l  (8,A0),D1
            subi.w  #$20,D0
            bfffo   D1{0:0},D7
            sub.w   D7,D0
            lsl.l   D7,D1
            move.w  D0,(A0)
            move.l  D1,(4,A0)
            clr.l   (8,A0)
            move.l  (SP)+,D7
            rts
sub_4088FD4A:
            btst    #6,(A0)
            beq.b   .L1
            bset    #7,(A0)
.L1:
            cmpi.b  #0,D0
            bne.b   .L2
            moveq   #0,D1
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L2:
            cmpi.l  #1,D0
            beq.b   .L3
            move.w  #$3C01,D1
            move.l  D1,D0
            sub.w   (A0),D0
            cmpi.w  #$43,D0
            bpl.b   .L4
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L3:
            move.w  #$3F81,D1
            move.l  D1,D0
            sub.w   (A0),D0
            cmpi.w  #$43,D0
            bpl.b   .L4
            moveq   #0,D0
            bsr.b   sub_4088FDD0
            tst.b   D1
            beq.b   .L8
            bra.b   .L7
.L4:
            tst.l   (4,A0)
            bne.b   .L5
            tst.l   (8,A0)
            bne.b   .L5
            bra.b   .L6
.L5:
            ori.l   #$208,(-$7C,A6)
            move.l  #$20000000,D0
.L6:
            move.w  D1,(A0)
            clr.l   (4,A0)
            clr.l   (8,A0)
            rts
.L7:
            ori.l   #$208,(-$7C,A6)
.L8:
            rts
sub_4088FDD0:
            move.l  (8,A0),(-8,A6)
            moveq   #0,D0
            btst    #1,(-$DC,A6)
            beq.b   .L1
            move.l  (-$E8,A6),D0
            lsl.l   #6,D0
            andi.l  #$E0000000,D0
.L1:
            move.l  D0,(-4,A6)
            move.l  D1,D0
            sub.w   (A0),D1
            beq.b   .L2
            cmpi.w  #$20,D1
            blt.b   .L3
            cmpi.w  #$40,D1
            blt.b   .L5
            bra.w   .L8
.L2:
            clr.b   D1
            move.l  (-4,A6),D0
            rts
.L3:
            move.l  D2,-(SP)
            move.w  D0,(A0)
            moveq   #$20,D0
            sub.w   D1,D0
            bfextu  (4,A0){D0:0},D2
            move.l  D2,(8,A0)
            bfextu  (4,A0){0:D0},D2
            move.l  D2,(4,A0)
            bfextu  (-4,A6){D0:D1},D2
            bfextu  (-8,A6){D0:0},D0
            tst.l   D2
            sne     D0
            clr.b   D1
            bftst   D0{2:30}
            beq.b   .L4
            bset    #$1D,D0
            st      D1
.L4:
            andi.l  #$E0000000,D0
            move.l  (SP)+,D2
            rts
.L5:
            move.l  D2,-(SP)
            move.w  D0,(A0)
            subi.w  #$20,D1
            moveq   #$20,D0
            sub.w   D1,D0
            bfextu  (4,A0){0:D0},D2
            bfextu  (4,A0){D0:0},D1
            bftst   D1{2:30}
            bne.b   .L6
            bftst   (-8,A6){D0:0}
            bne.b   .L6
            tst.l   (-4,A6)
            bne.b   .L6
            move.l  D1,D0
            clr.b   D1
            bra.b   .L7
.L6:
            move.l  D1,D0
            bset    #$1D,D0
            st      D1
.L7:
            clr.l   (4,A0)
            move.l  D2,(8,A0)
            andi.l  #$E0000000,D0
            move.l  (SP)+,D2
            rts
.L8:
            move.w  D0,(A0)
            tst.w   (2,A0)
            bge.b   .L9
            ori.l   #$80000000,(A0)
.L9:
            cmpi.w  #$40,D1
            beq.b   .L10
            cmpi.w  #$41,D1
            beq.b   .L11
            clr.l   (4,A0)
            clr.l   (8,A0)
            move.l  #$20000000,D0
            st      D1
            rts
.L10:
            move.l  (4,A0),D0
            bfextu  D0{2:30},D1
            andi.l  #$C0000000,D0
            bra.b   .L12
.L11:
            move.l  (4,A0),D0
            bfextu  D0{1:31},D1
            andi.l  #$80000000,D0
            lsr.l   #1,D0
.L12:
            tst.l   D1
            bne.b   .L13
            tst.l   (8,A0)
            bne.b   .L13
            tst.b   (-4,A6)
            bne.b   .L13
            clr.b   D1
            bra.b   .L14
.L13:
            bset    #$1D,D0
            st      D1
.L14:
            clr.l   (4,A0)
            clr.l   (8,A0)
            rts
            dc.w    0
