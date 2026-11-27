get_op:
            clr.b   (-$48,A6)
            tst.b   (-$47,A6)
            beq.b   .L2
            btst    #5,(-$E4,A6)
            bne.w   .L13
            btst    #6,(-$E4,A6)
            beq.b   .L1
            bfextu  (-$E4,A6){3:3},D0
            cmpi.b  #3,D0
            beq.w   .L12
.L1:
            bsr.w   chk_dy_mo
            tst.b   (-$48,A6)
            beq.b   .L6
            btst    #7,(-$E0,A6)
            beq.b   .L6
            bra.b   .L5
.L2:
            bfextu  (-$E4,A6){0:6},D0
            cmpi.l  #$17,D0
            bne.b   .L3
            rts
.L3:
            btst    #2,(-$DC,A6)
            bne.w   .L12
            move.b  (-$E8,A6),D0
            or.b    (-$E0,A6),D0
            bmi.b   .L4
            rts
.L4:
            btst    #7,(-$E0,A6)
            beq.b   .L6
            bsr.w   chk_dy_mo
            tst.b   (-$48,A6)
            beq.b   .L6
.L5:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            beq.b   .L6
            lea     (-$D8,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E0,A6)
.L6:
            btst    #7,(-$E8,A6)
            beq.w   .L14
            btst    #5,(-$E8,A6)
            bne.b   .L8
.L7:
            move.w  (-$CC,A6),D0
            andi.w  #$7FFF,D0
            beq.w   .L14
            lea     (-$CC,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E8,A6)
            rts
.L8:
            btst    #4,(-$E4,A6)
            bne.b   .L9
            move.w  #$3F81,D1
            bra.b   .L10
.L9:
            move.w  #$3C01,D1
.L10:
            btst    #7,(-$CC,A6)
            beq.b   .L11
            bset    #$F,D1
.L11:
            move.w  D1,(-$CC,A6)
            move.w  (-$E4,A6),D1
            andi.w  #$E3FF,D1
            ori.w   #$800,D1
            move.w  D1,(-$E4,A6)
            lea     (-$CC,A6),A0
            bsr.w   sub_4088E2D0
            move.b  (-$54,A6),(-$E8,A6)
            rts
.L12:
            move.l  (-$D0,A6),(-$CC,A6)
            bsr.b   chk_dy_mo
            bsr.w   sub_4088E308
            tst.b   (-$48,A6)
            beq.b   .L14
            bfextu  (-$E4,A6){6:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$D8,A6)
            btst    #7,(-$E0,A6)
            bne.w   .L5
            move.b  (-$E0,A6),D0
            andi.b  #$F0,D0
            tst.b   D0
            bne.b   .L14
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFF,D0
            bge.b   .L14
            ori.b   #$10,(-$E0,A6)
            bra.b   .L14
.L13:
            clr.b   (-$48,A6)
            bfextu  (-$E4,A6){4:2},D0
            cmpi.b  #3,D0
            bne.w   .L7
.L14:
            rts
chk_dy_mo:
            move.w  (-$E4,A6),D0
            btst    #5,D0
            beq.b   .L2
            btst    #4,D0
            beq.b   .L1
            andi.w  #$7F,D0
            cmpi.w  #$38,D0
            bne.b   .L2
.L1:
            st      (-$48,A6)
            rts
.L2:
            clr.b   (-$48,A6)
            rts
sub_4088E2D0:
            clr.l   (-$54,A6)
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_4088FC90
            btst    #7,(4,A0)
            bne.b   .L1
            ori.b   #$80,(-$54,A6)
.L1:
            cmpi.w  #$3FFF,(A0)
            bgt.b   .L2
            bset    #4,(-$54,A6)
.L2:
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
.L3:
            rts
sub_4088E308:
            move.w  (-$E4,A6),D0
            andi.w  #$3B,D0
            beq.w   .L5
            move.w  (-$CC,A6),D0
            bfextu  D0{20:12},D1
            cmpi.w  #$FFF,D1
            bne.b   .L2
            bfextu  D0{17:3},D1
            cmpi.w  #7,D1
            bne.b   .L2
            tst.l   (-$C8,A6)
            bne.b   .L1
            tst.l   (-$C4,A6)
            bne.b   .L1
            bra.w   .L11
.L1:
            btst    #6,(-$C8,A6)
            bne.w   .L11
            ori.l   #$1004080,(-$7C,A6)
            bra.w   .L11
.L2:
            move.w  (-$CA,A6),D0
            andi.w  #$F,D0
            tst.w   D0
            bne.b   .L4
            tst.l   (-$C8,A6)
            bne.b   .L4
            tst.l   (-$C4,A6)
            bne.b   .L4
            tst.l   (-$CC,A6)
            bge.b   .L3
            move.l  #$80000000,(-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.w   .L11
.L3:
            clr.l   (-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.w   .L11
.L4:
            fmovem.x FP0,-(SP)
            bsr.w   sub_4088E4FE
            fmove.x FP0,(-$CC,A6)
            fmovem.x (SP)+,FP0
            fmove.l #0,FPSR
            bra.w   .L11
.L5:
            move.w  (-$CC,A6),D0
            bfextu  D0{20:12},D1
            cmpi.w  #$FFF,D1
            bne.b   .L8
            bfextu  D0{17:3},D1
            cmpi.w  #7,D1
            bne.b   .L8
            tst.l   (-$C8,A6)
            bne.b   .L6
            tst.l   (-$C4,A6)
            bne.b   .L6
            ori.l   #$2000000,(-$7C,A6)
            tst.l   (-$CC,A6)
            bge.w   .L11
            ori.l   #$8000000,(-$7C,A6)
            bra.w   .L11
.L6:
            ori.l   #$1000000,(-$7C,A6)
            move.b  #$60,(-$E8,A6)
            btst    #6,(-$C8,A6)
            bne.b   .L7
            ori.l   #$1004080,(-$7C,A6)
            btst    #6,(-$7E,A6)
            bne.b   .L7
            bset    #6,(-$C8,A6)
.L7:
            tst.l   (-$CC,A6)
            bge.b   .L11
            ori.l   #$8000000,(-$7C,A6)
            bra.b   .L11
.L8:
            move.w  (-$CA,A6),D0
            andi.w  #$F,D0
            tst.w   D0
            bne.b   .L10
            tst.l   (-$C8,A6)
            bne.b   .L10
            tst.l   (-$C4,A6)
            bne.b   .L10
            tst.l   (-$CC,A6)
            bge.b   .L9
            ori.l   #$C000000,(-$7C,A6)
            move.l  #$80000000,(-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.b   .L11
.L9:
            ori.l   #$4000000,(-$7C,A6)
            clr.l   (-$CC,A6)
            clr.l   (-$C8,A6)
            clr.l   (-$C4,A6)
            bra.b   .L11
.L10:
            fmovem.x FP0,-(SP)
            bsr.w   sub_4088E4FE
            fmove.x FP0,(-$CC,A6)
            fmovem.x (SP)+,FP0
.L11:
            move.w  (-$E4,A6),D0
            andi.w  #$FBFF,D0
            move.w  D0,(-$E4,A6)
            move.w  (-$CC,A6),D1
            andi.w  #$7FFF,D1
            cmpi.w  #$7FFF,D1
            bne.b   .L13
            move.l  (-$C8,A6),D1
            bne.b   .L12
            move.l  (-$C4,A6),D1
            bne.b   .L12
            move.b  #$40,(-$E8,A6)
            moveq   #$40,D0
            rts
.L12:
            move.b  #$60,(-$E8,A6)
            moveq   #$60,D0
            rts
.L13:
            tst.w   D1
            bne.b   .L14
            move.b  #$30,(-$E8,A6)
            moveq   #$20,D0
            rts
.L14:
            cmpi.w  #$3FFF,D1
            ble.b   .L15
            clr.b   (-$E8,A6)
            bra.b   .L16
.L15:
            move.b  #$10,(-$E8,A6)
.L16:
            moveq   #0,D0
            rts
            rts
