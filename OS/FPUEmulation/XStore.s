.L1:
            dc.l    $80402010,$08040201
sub_4088E71C:
            btst    #1,(-$DC,A6)
            beq.w   .L9
            move.l  (-$F0,A6),D0
            bfextu  D0{6:3},D0
.L1:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            beq.b   .L3
            cmpi.w  #$7FFF,D1
            beq.b   .L3
            tst.l   (4,A0)
            bmi.b   .L3
            bne.b   .L2
            tst.l   (8,A0)
            bne.b   .L2
            clr.w   (A0)
            bra.b   .L3
.L2:
            move.l  D0,-(SP)
            bsr.w   sub_4088FCF8
            move.l  (SP)+,D0
.L3:
            lea     sub_4088E4FE.L1,A1
            move.b  (0,A1,D0.w),D0
            tst.b   (2,A0)
            beq.b   .L4
            bset    #7,(A0)
.L4:
            fmovem.x (A0),D0
            cmpi.b  #$80,D0
            bne.b   .L5
            fmovem.x FP0,(-$B0,A6)
            rts
.L5:
            cmpi.b  #$40,D0
            bne.b   .L6
            fmovem.x FP1,(-$A4,A6)
            rts
.L6:
            cmpi.b  #$20,D0
            bne.b   .L7
            fmovem.x FP2,(-$98,A6)
            rts
.L7:
            cmpi.b  #$10,D0
            bne.b   .L8
            fmovem.x FP3,(-$8C,A6)
            rts
.L8:
            rts
.L9:
            bsr.w   g_opcls
            cmpi.b  #3,D0
            beq.b   .L10
            move.l  (-$E4,A6),D0
            bfextu  D0{6:3},D0
            bra.w   .L1
.L10:
            bsr.w   sub_40890674
            movea.l A0,A1
            movea.l ($C,A6),A0
            tst.l   D0
            beq.w   sub_4088E89C
            cmpi.l  #1,D0
            beq.b   sub_4088E838
sub_4088E7D4:
            moveq   #0,D0
            move.w  (A1),D0
            subi.w  #$3FFF,D0
            cmpi.w  #$4000,D0
            beq.b   .L1
            addi.w  #$3FF,D0
            swap    D0
            lsl.l   #4,D0
            tst.b   (2,A1)
            beq.b   .L3
            bset    #$1F,D0
            bra.b   .L3
.L1:
            move.l  #$7FF00000,D0
            clr.l   (4,A1)
            tst.b   (2,A1)
            beq.b   .L2
            bset    #$1F,D0
.L2:
            move.l  D0,(A1)
            bra.b   .L4
.L3:
            move.l  (4,A1),D1
            bfextu  D1{1:20},D1
            or.l    D1,D0
            move.l  D0,(A1)
            move.l  (4,A1),D1
            moveq   #$15,D0
            lsl.l   D0,D1
            move.l  D1,(4,A1)
            move.l  (8,A1),D1
            bfextu  D1{0:21},D0
            or.l    D0,(4,A1)
.L4:
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            rts
sub_4088E838:
            moveq   #0,D0
            move.w  (A1),D0
            subi.w  #$3FFF,D0
            cmpi.w  #$4000,D0
            beq.b   .L1
            addi.w  #$7F,D0
            swap    D0
            lsl.l   #7,D0
            tst.b   (2,A1)
            beq.b   .L2
            bset    #$1F,D0
            bra.b   .L2
.L1:
            move.l  #$7F800000,D0
            tst.b   (2,A1)
            beq.b   .L3
            bset    #$1F,D0
            bra.b   .L3
.L2:
            move.l  (4,A1),D1
            bfextu  D1{1:23},D1
            or.l    D1,D0
.L3:
            move.l  D0,(-$54,A6)
            moveq   #4,D0
            tst.l   A0
            beq.b   .L4
            lea     (-$54,A6),A1
            move.l  (A1),(A0)
            rts
.L4:
            movea.l (-$78,A6),A0
            sub.l   D1,D1
            move.w  (A0),D1
            andi.w  #7,D1
            ori.b   #$10,D1
            bra.w   sub_40890882
sub_4088E89C:
            tst.b   (2,A1)
            beq.b   .L1
            bset    #7,(A1)
.L1:
            clr.b   (2,A1)
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            rts
            ds.b    14
