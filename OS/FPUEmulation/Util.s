.L4:
            dc.l    $7FFF0000,$00000000,$00000000,$00000000
.L5:
            dc.l    $7FFE0000,$FFFFFFFF,$FFFFFFFF,$00000000
.L8:
            dc.l    $407E0000,$FFFFFF00,$00000000,$00000000
.L6:
            dc.l    $43FE0000,$FFFFFFFF,$FFFFF800,$00000000
.L7:
            dc.l    $00C600D4,$00DC00FA,$016A0176,$017C0196
            dc.l    $011C012A,$0132014C,$01D001D0,$01D001D0
ovf_r_k:
            lea     (-$CC,A6),A0
            bclr    #7,(-$CC,A6)
            sne     (-$CA,A6)
            tst.b   (-$47,A6)
            beq.b   .L1
            btst    #6,(-$E3,A6)
            beq.b   .L1
            moveq   #1,D0
            btst    #2,(-$E3,A6)
            beq.b   sub_408904E2
            addq.l  #1,D0
            bra.b   sub_408904E2
.L1:
            bfextu  (-$7D,A6){0:2},D0
            bra.b   sub_408904E2
ovf_r_x2:
            btst    #1,(-$DC,A6)
            beq.b   .L4
            move.w  (-$F0,A6),D0
            andi.w  #$7F,D0
            btst    #6,D0
            beq.b   .L2
            btst    #5,D0
            beq.b   .L1
            moveq   #2,D0
            bra.b   sub_408904E2
.L1:
            moveq   #1,D0
            bra.b   sub_408904E2
.L2:
            cmpi.w  #$30,D0
            beq.b   .L3
            cmpi.w  #$33,D0
            bne.b   .L6
.L3:
            moveq   #0,D0
            bra.b   sub_408904E2
.L4:
            move.w  (-$E4,A6),D0
            andi.l  #$44,D0
            btst    #6,D0
            beq.b   .L6
            addq.l  #1,D0
            btst    #2,D0
            beq.b   .L5
            addq.l  #1,D0
.L5:
            andi.b  #3,D0
            bra.b   sub_408904E2
.L6:
            bfextu  (-$7D,A6){0:2},D0
            bra.b   sub_408904E2
sub_408904DE:
            bsr.w   sub_40890674
sub_408904E2:
            lsl.l   #2,D0
            bfextu  (-$7D,A6){2:2},D1
            or.l    D1,D0
            lea     sub_40890392.L7,A1
            adda.w  (0,A1,D0.w*2),A1
            jmp     (A1)
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890392.L5,A1
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L1
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.w   .L6
.L1:
            lea     sub_40890392.L5,A1
            bra.w   .L6
            tst.b   (2,A0)
            beq.b   .L2
            lea     sub_40890392.L5,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L2:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L6
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890392.L6,A1
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L3
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.b   .L6
.L3:
            lea     sub_40890392.L6,A1
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L4
            lea     sub_40890392.L6,A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L4:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L6
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L5
            lea     sub_40890392.L8(PC),A1
            bra.b   .L5
            tst.b   (2,A0)
            beq.b   .L7
            lea     sub_40890392.L4,A1
            ori.l   #$A000000,(-$7C,A6)
            bra.b   .L6
.L7:
            lea     sub_40890392.L8(PC),A1
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L8
            lea     sub_40890392.L8(PC),A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L8:
            lea     sub_40890392.L4,A1
            bset    #1,(-$7C,A6)
            bra.b   .L6
.L5:
            tst.b   (2,A0)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            move.w  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  (8,A1),(8,A0)
            rts
            rts
sub_40890602:
            bsr.b   g_opcls
            cmpi.w  #3,D0
            bne.b   .L1
            bsr.b   sub_40890674
            rts
.L1:
            btst    #1,(-$DC,A6)
            beq.b   .L3
            move.l  (-$F0,A6),D0
            bfextu  D0{9:2},D0
            btst    #1,D0
            beq.b   .L5
            cmpi.l  #2,D0
            beq.b   .L2
            moveq   #2,D0
            rts
.L2:
            moveq   #1,D0
            rts
.L3:
            move.w  (-$E4,A6),D0
            andi.l  #$44,D0
            btst    #6,D0
            beq.b   .L5
            addq.l  #1,D0
            btst    #2,D0
            beq.b   .L4
            addq.l  #1,D0
.L4:
            andi.b  #3,D0
            rts
.L5:
            move.l  (-$80,A6),D0
            bfextu  D0{24:2},D0
            rts
g_opcls:
            btst    #1,(-$DC,A6)
            beq.b   .L1
            moveq   #0,D0
            rts
.L1:
            move.l  (-$E4,A6),D0
            bfextu  D0{0:3},D0
            rts
sub_40890674:
            btst    #1,(-$DC,A6)
            beq.b   .L1
            moveq   #0,D0
            rts
.L1:
            move.l  (-$E4,A6),D0
            bfextu  D0{3:3},D0
            cmpi.b  #1,D0
            bne.b   .L2
            moveq   #1,D0
            rts
.L2:
            cmpi.b  #5,D0
            bne.b   .L3
            moveq   #2,D0
            rts
.L3:
            moveq   #0,D0
            rts
.L4:
            dc.l    $00000000,$00000000,$00000000,$00000000
.L9:
            dc.l    $3F810000,$00000000,$00000000,$00000000
.L5:
            dc.l    $3C010000,$00000000,$00000000,$00000000
.L6:
            dc.l    $00000000,$00000000,$00000001,$00000000
.L10:
            dc.l    $3F810000,$00000100,$00000000,$00000000
.L7:
            dc.l    $3C010000,$00000000,$00000800,$00000000
.L8:
            dc.l    $00340042,$00500072,$00E600F2,$00FE011C
            dc.l    $0090009E,$00AC00CC,$0090009E,$00AC00CC
sub_40890720:
            lsl.l   #2,D0
            bfextu  (-$7D,A6){2:2},D1
            or.l    D1,D0
            lea     sub_40890674.L8,A1
            adda.w  (0,A1,D0.w*2),A1
            jmp     (A1)
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L1
            lea     sub_40890674.L6,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L1:
            lea     sub_40890674.L4,A1
            bset    #2,(-$7C,A6)
            bra.w   .L6
            tst.b   (2,A0)
            beq.b   .L2
            lea     sub_40890674.L4,A1
            ori.l   #$C000000,(-$7C,A6)
            bra.w   .L6
.L2:
            lea     sub_40890674.L6,A1
            bra.w   .L6
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.w   .L5
            tst.b   (2,A0)
            beq.b   .L3
            lea     sub_40890674.L7,A1
            bset    #3,(-$7C,A6)
            bra.w   .L6
.L3:
            lea     sub_40890674.L5,A1
            bset    #2,(-$7C,A6)
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L4
            lea     sub_40890674.L5,A1
            ori.l   #$C000000,(-$7C,A6)
            bra.b   .L6
.L4:
            lea     sub_40890674.L7,A1
            bra.b   .L6
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L5
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L5
            tst.b   (2,A0)
            beq.b   .L8
            lea     sub_40890674.L10(PC),A1
            bset    #3,(-$7C,A6)
            bra.b   .L6
.L8:
            lea     sub_40890674.L9(PC),A1
            bset    #2,(-$7C,A6)
            bra.b   .L6
            tst.b   (2,A0)
            beq.b   .L9
            lea     sub_40890674.L9(PC),A1
            ori.l   #$C000000,(-$7C,A6)
            bra.b   .L6
.L9:
            lea     sub_40890674.L10(PC),A1
            bra.b   .L6
.L5:
            tst.b   (2,A0)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            move.w  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  (8,A1),(8,A0)
            rts
.L7:
            dc.l    $003A0042,$004A0050,$0056005C,$00620068
            dc.l    $006E0076,$007E0084,$008A0090,$0096009C
            dc.l    $00A200AA,$00B200B8,$00BE00C4,$00CA00D0
sub_40890882:
            lea     sub_40890720.L7,A0
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
            move.b  (-$54,A6),(-$BD,A6)
            rts
            move.b  (-$54,A6),(-$B9,A6)
            rts
            move.b  (-$54,A6),D2
            rts
            move.b  (-$54,A6),D3
            rts
            move.b  (-$54,A6),D4
            rts
            move.b  (-$54,A6),D5
            rts
            move.b  (-$54,A6),D6
            rts
            move.b  (-$54,A6),D7
            rts
            move.w  (-$54,A6),(-$BE,A6)
            rts
            move.w  (-$54,A6),(-$BA,A6)
            rts
            move.w  (-$54,A6),D2
            rts
            move.w  (-$54,A6),D3
            rts
            move.w  (-$54,A6),D4
            rts
            move.w  (-$54,A6),D5
            rts
            move.w  (-$54,A6),D6
            rts
            move.w  (-$54,A6),D7
            rts
            move.l  (-$54,A6),(-$C0,A6)
            rts
            move.l  (-$54,A6),(-$BC,A6)
            rts
            move.l  (-$54,A6),D2
            rts
            move.l  (-$54,A6),D3
            rts
            move.l  (-$54,A6),D4
            rts
            move.l  (-$54,A6),D5
            rts
            move.l  (-$54,A6),D6
            rts
            move.l  (-$54,A6),D7
            rts
