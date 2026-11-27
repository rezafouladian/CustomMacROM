sub_4088DBD0:
            cmpi.b  #$40,(4,SP)
            bne.w   .L22
            move.b  (-$11C,A6),D0
            andi.b  #$FE,D0
            beq.w   .L22
            move.w  (-$E4,A6),D0
            andi.w  #$E000,D0
            bne.w   .L11
            bfextu  (-$E4,A6){3:3},D0
            bfextu  (-$F0,A6){6:3},D1
            cmp.b   D0,D1
            beq.b   .L1
            bfextu  (-$E4,A6){6:3},D0
            cmp.b   D0,D1
            beq.b   .L1
            bfextu  (-$F4,A6){6:3},D1
            cmp.b   D0,D1
            beq.b   .L3
            bfextu  (-$E4,A6){3:3},D0
            cmp.b   D0,D1
            beq.b   .L3
            bne.w   .L22
.L1:
            bfextu  (-$E4,A6){3:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$CC,A6)
            move.b  #$12,D0
            bfins   D0,(-$E4,A6){0:6}
            btst    #6,(-$CC,A6)
            beq.b   .L2
            bclr    #4,(-$E8,A6)
            bra.w   .L22
.L2:
            bset    #4,(-$E8,A6)
            bra.w   .L22
.L3:
            move.l  (-$E8,A6),(-$54,A6)
            move.l  (-$E4,A6),(-$50,A6)
            move.l  (-$E0,A6),(-$44,A6)
            andi.l  #$E0000000,(-$44,A6)
            clr.b   (-$11C,A6)
            move.l  (SP)+,D1
            frestore (SP)+
            fsave   -(SP)
            cmpi.w  #$4060,(SP)
            beq.w   .L10
            bfextu  (-$F4,A6){6:3},D0
            cmpi.l  #3,D0
            bgt.b   .L7
            beq.b   .L6
            cmpi.l  #1,D0
            blt.b   .L5
            beq.b   .L4
            fmovem.x FP2,(-$98,A6)
            bra.b   .L7
.L4:
            fmovem.x FP1,(-$A4,A6)
            bra.b   .L7
.L5:
            fmovem.x FP0,(-$B0,A6)
            bra.b   .L7
.L6:
            fmovem.x FP3,(-$8C,A6)
.L7:
            moveq   #$16,D0
            clr.l   (SP)
.L8:
            clr.l   -(SP)
            dbra    D0,.L8
            move.l  #$40600000,-(SP)
            move.l  (-$54,A6),(-$E8,A6)
            move.l  (-$50,A6),(-$E4,A6)
            move.l  (-$44,A6),(-$E0,A6)
            move.b  #6,(-$11C,A6)
            move.l  D1,-(SP)
            bfextu  (-$E4,A6){3:3},D0
            moveq   #7,D1
            sub.l   D0,D1
            moveq   #0,D0
            bset    D1,D0
            fmovem.x D0,(-$CC,A6)
            move.b  #$12,D0
            bfins   D0,(-$E4,A6){0:6}
            btst    #6,(-$CC,A6)
            beq.b   .L9
            bclr    #4,(-$E8,A6)
            bra.w   .L22
.L9:
            bset    #4,(-$E8,A6)
            bra.w   .L22
.L10:
            jmp     InstallFPSP.L1
.L11:
            move.w  (-$E4,A6),D0
            andi.w  #$FC00,D0
            cmpi.w  #$4400,D0
            bne.w   .L22
            bfextu  (-$E4,A6){6:3},D0
            bfextu  (-$F0,A6){6:3},D1
            cmp.b   D0,D1
            beq.w   .L17
            bfextu  (-$F4,A6){6:3},D1
            cmp.b   D0,D1
            bne.w   .L22
            move.l  (-$E8,A6),(-$54,A6)
            move.l  (-$E4,A6),(-$50,A6)
            move.l  (-$E0,A6),(-$44,A6)
            andi.l  #$E0000000,(-$44,A6)
            clr.b   (-$11C,A6)
            move.l  (-$CC,A6),(-$64,A6)
            move.l  (-$C8,A6),(-$60,A6)
            move.l  (-$C4,A6),(-$5C,A6)
            move.l  (SP)+,D1
            frestore (SP)+
            fsave   -(SP)
            cmpi.w  #$4060,(SP)
            beq.w   .L21
            bfextu  (-$F4,A6){6:3},D0
            cmpi.l  #3,D0
            bgt.b   .L15
            beq.b   .L14
            cmpi.l  #1,D0
            blt.b   .L13
            beq.b   .L12
            fmovem.x FP2,(-$98,A6)
            bra.b   .L15
.L12:
            fmovem.x FP1,(-$A4,A6)
            bra.b   .L15
.L13:
            fmovem.x FP0,(-$B0,A6)
            bra.b   .L15
.L14:
            fmovem.x FP3,(-$8C,A6)
.L15:
            moveq   #$16,D0
            clr.l   (SP)
.L16:
            clr.l   -(SP)
            dbra    D0,.L16
            move.l  #$40600000,-(SP)
            move.l  (-$54,A6),(-$E8,A6)
            move.l  (-$50,A6),(-$E4,A6)
            move.l  (-$44,A6),(-$E0,A6)
            move.b  #6,(-$11C,A6)
            move.l  (-$64,A6),(-$CC,A6)
            move.l  (-$60,A6),(-$C8,A6)
            move.l  (-$5C,A6),(-$C4,A6)
            move.l  D1,-(SP)
.L17:
            move.b  #$15,D0
            bfins   D0,(-$E4,A6){0:6}
            cmpi.w  #$407F,(-$CC,A6)
            bne.b   .L18
            move.w  #$43FF,(-$CC,A6)
            bra.b   .L22
.L18:
            cmpi.w  #$C07F,(-$CC,A6)
            bne.b   .L19
            move.w  #$C3FF,(-$CC,A6)
            bra.b   .L22
.L19:
            cmpi.w  #$3F80,(-$CC,A6)
            bne.b   .L20
            move.w  #$3C00,(-$CC,A6)
            bra.b   .L22
.L20:
            cmpi.w  #$BF80,(-$CC,A6)
            bne.b   .L22
            move.w  #$BC00,(-$CC,A6)
            bra.b   .L22
.L21:
            jmp     InstallFPSP.L1
.L22:
            rts
