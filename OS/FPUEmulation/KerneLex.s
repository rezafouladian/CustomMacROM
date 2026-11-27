.L1:
            dc.l    $FFFF0000,$00000000,$00000000
.L2:
            dc.l    $7FFF0000,$00000000,$00000000
.L3:
            dc.l    $7FFF0000,$FFFFFFFF,$FFFFFFFF  ; added <4/9/91, JPO>			<T3>
.L4:
            bset    #3,(-$7C,A6)
            fmove.l #0,FPSR
            btst    #2,(-$7E,A6)
            bne.b   sub_4089099A.L1
            bra.b   .L6
.L5:
            fmove.l #0,FPSR
            btst    #2,(-$7E,A6)
            bne.b   sub_4089099A
            btst    #7,(-$CC,A6)
            beq.b   .L7
.L6:
            fmovem.x .L1(PC),FP0
            bset    #3,(-$7C,A6)
            bra.b   .L8
.L7:
            fmovem.x .L2(PC),FP0
.L8:
            ori.l   #$2000410,(-$7C,A6)
            rts
sub_4089099A:
            btst    #7,(-$CC,A6)
            beq.b   .L1
            bset    #3,(-$7C,A6)
.L1:
            ori.l   #$2000410,(-$7C,A6)
            st      (-$4C,A6)
            rts
sub_408909B6:
            ori.l   #$1002080,(-$7C,A6)
            btst    #5,(-$7E,A6)
            bne.b   .L1
            fmovem.x sub_40890882.L3(PC),FP0
            rts
.L1:
            st      (-$4C,A6)
            rts
sub_408909D4:
            clr.l   (-$74,A6)
            clr.l   (-$70,A6)
            clr.l   (-$6C,A6)
            tst.b   (A0)
            bpl.b   .L1
            bset    #7,(-$74,A6)
.L1:
            lea     (-$74,A6),A0
            ori.l   #$A28,(-$7C,A6)
            btst    #3,(-$7E,A6)
            beq.b   .L2
            bfclr   (-$E8,A6){5:3}
            bset    #4,(-$DF,A6)
            bset    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
.L2:
            bfextu  (-$7D,A6){0:2},D0
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_40890720
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
            bset    #7,(-$74,A6)
.L3:
            move.w  (A0),D1
            andi.w  #$7FFF,D1
            beq.b   .L5
            tst.l   (4,A0)
            bmi.b   .L5
            bne.b   .L4
            tst.l   (8,A0)
            bne.b   .L4
            bfclr   (A0){1:15}
            bra.b   .L5
.L4:
            bsr.w   sub_4088FCF8
.L5:
            fmovem.x (A0),FP0
            rts
t_ovfl2:
            ori.l   #$1048,(-$7C,A6)
            move.l  (-$CC,A6),(-$74,A6)
            move.l  (-$C8,A6),(-$70,A6)
            move.l  (-$C4,A6),(-$6C,A6)
            move.b  (-$7D,A6),D0
            andi.b  #$C0,D0
            beq.b   sub_40890AB4.L1
            cmpi.b  #$40,D0
            bne.b   .L1
            tst.b   (-$C4,A6)
            bne.b   .L2
            move.l  (-$C8,A6),D0
            andi.l  #$FF,D0
            bne.b   .L2
            bra.b   sub_40890AB4.L1
.L1:
            move.l  (-$C4,A6),D0
            andi.l  #$7FF,D0
            beq.b   sub_40890AB4.L1
.L2:
            ori.l   #$200,(-$7C,A6)
            bra.b   sub_40890AB4.L1
sub_40890AB4:
            ori.l   #$1248,(-$7C,A6)
.L1:
            btst    #4,(-$7E,A6)
            beq.b   .L2
            clr.l   (-$74,A6)
            clr.l   (-$70,A6)
            clr.l   (-$6C,A6)
            bfclr   (-$E8,A6){5:3}
            bclr    #4,(-$DF,A6)
            bset    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
.L2:
            bsr.w   ovf_r_k
            bfclr   (-$CA,A6){0:8}
            beq.b   .L3
            bset    #7,(-$CC,A6)
            bset    #7,(-$74,A6)
.L3:
            fmovem.x (-$CC,A6),FP0
            rts
.L4:
            ori.l   #$208,(-$7C,A6)
            rts
sub_40890B12:
            ori.l   #$208,(-$7C,A6)
            btst    #3,(-$7A,A6)
            beq.b   .L1
            bset    #5,(-$79,A6)
.L1:
            rts
            btst    #7,(-$D8,A6)
            beq.b   .L2
            bset    #3,(-$7C,A6)
.L2:
            btst    #6,(-$D4,A6)
            beq.b   .L4
            fmove.l D1,FPCR
            fmove.x (-$D8,A6),FP0
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            bne.b   .L3
            btst    #6,(-$C8,A6)
            bne.b   .L3
            ori.l   #$1004080,(-$7C,A6)
.L3:
            rts
.L4:
            btst    #6,(-$7E,A6)
            beq.b   .L5
            ori.b   #$60,(-$E0,A6)
            st      (-$4C,A6)
            ori.l   #$1004080,(-$7C,A6)
            rts
.L5:
            bset    #6,(-$D4,A6)
            fmove.l D1,FPCR
            fmove.x (-$D8,A6),FP0
            ori.l   #$1004080,(-$7C,A6)
            rts
            btst    #7,(-$CC,A6)
            beq.b   .L6
            bset    #3,(-$7C,A6)
.L6:
            btst    #6,(-$C8,A6)
            beq.b   .L7
            fmove.l D1,FPCR
            fmove.x (-$CC,A6),FP0
            rts
.L7:
            btst    #6,(-$7E,A6)
            beq.b   .L8
            ori.b   #$60,(-$E8,A6)
            st      (-$4C,A6)
            ori.l   #$1004080,(-$7C,A6)
            rts
.L8:
            bset    #6,(-$C8,A6)
            fmove.l D1,FPCR
            fmove.x (-$CC,A6),FP0
            ori.l   #$1004080,(-$7C,A6)
            rts
.L16:
            ori.l   #$A28,(-$7C,A6)
            bra.b   .L10
.L9:
            ori.l   #$800,(-$7C,A6)
.L10:
            btst    #3,(-$7E,A6)
            beq.b   .L13
            move.l  A0,-(SP)
            move.l  (A0),(-$74,A6)
            move.l  (4,A0),(-$70,A6)
            move.l  (8,A0),(-$6C,A6)
            lea     (-$74,A6),A0
            bclr    #7,(A0)
            sne     (2,A0)
            tst.w   (A0)
            beq.b   .L11
            bsr.w   sub_4088FCF8
.L11:
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L12
            bset    #7,(A0)
.L12:
            bfclr   (-$E8,A6){5:3}
            bset    #4,(-$DF,A6)
            bclr    #7,(-$E7,A6)
            bclr    #2,(-$DC,A6)
            movea.l (SP)+,A0
.L13:
            bfextu  (-$7D,A6){0:2},D0
            bne.b   .L14
            btst    #7,(A0)
            beq.b   .L15
            bset    #3,(-$7C,A6)
            bra.b   .L15
.L14:
            ori.l   #$A28,(-$7C,A6)
            bclr    #7,(A0)
            sne     (2,A0)
            bsr.w   sub_40890720
            bfclr   (2,A0){0:8}
            beq.b   .L15
            bset    #7,(A0)
.L15:
            bra.w   sub_408909D4.L3
sub_40890C9C:
            link.w  A2,#-$C0
            fsave   -(SP)
            tst.b   (1,SP)
            beq.b   .L5
            btst    #2,(-$DC,A2)
            beq.b   .L4
            btst    #7,(-$E0,A2)
            beq.b   .L2
            lea     (-$D8,A2),A0
            btst    #7,(A0)
            sne     (2,A0)
            bclr    #7,(-$E0,A2)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L1
            bset    #7,(A0)
.L1:
            btst    #7,(-$E8,A2)
            beq.b   .L4
.L2:
            lea     (-$CC,A2),A0
            btst    #7,(A0)
            sne     (2,A0)
            bclr    #7,(-$E8,A2)
            bsr.w   sub_4088FCF8
            bclr    #7,(A0)
            bfclr   (2,A0){0:8}
            beq.b   .L3
            bset    #7,(A0)
.L3:
            move.b  #$FE,(-$11C,A2)
            clr.w   (-$EC,A2)
            bclr    #2,(-$DC,A2)
.L4:
            frestore (SP)+
            unlk    A2
            rts
.L5:
            addq.l  #4,SP
            unlk    A2
            rts
            ds.b    8
