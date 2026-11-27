operr:
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            fmovem.x FP0-FP3,(-$B0,A6)
            fmovem.l FPCR/FPSR/FPIAR,(-$80,A6)
            btst    #4,(-$DB,A6)
            beq.b   .L1
            move.l  (-$E4,A6),D0
            bfextu  D0{3:3},D0
            cmpi.b  #0,D0
            beq.b   .L2
            cmpi.b  #4,D0
            beq.w   .L7
            cmpi.b  #6,D0
            beq.w   .L9
.L1:
            bset    #5,(-$7A,A6)
            bset    #7,(-$79,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FD4).w,-(SP)
            rts
.L2:
            moveq   #4,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.w   .L11
            cmpi.l  #$80000000,(-$D0,A6)
            bne.b   .L3
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L3
            move.l  #$80000000,D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L3:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L5
.L4:
            move.l  (-$D0,A6),D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L5:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$4000,D0
            bcc.w   .L12
            move.l  (-$D0,A6),D0
            andi.l  #$7FFF0000,D0
            cmpi.l  #$7FFF0000,D0
            beq.b   .L4
            tst.l   (-$D0,A6)
            bpl.b   .L6
            cmpi.l  #$FFFFFFFF,(-$D4,A6)
            beq.b   .L4
            bra.w   .L12
.L6:
            tst.l   (-$D4,A6)
            beq.b   .L4
            bra.w   .L12
.L7:
            moveq   #2,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.w   .L11
            cmpi.l  #$FFFF8000,(-$D0,A6)
            bne.b   .L8
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L8
            move.l  #$80000000,D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L8:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L12
            move.l  (-$D0,A6),D0
            swap    D0
            bsr.w   operr_store
            bra.w   check_upper.L4
.L9:
            moveq   #1,D1
            move.b  (-$E8,A6),D0
            andi.b  #$E0,D0
            cmpi.b  #$60,D0
            beq.b   .L11
            cmpi.l  #$FFFFFF80,(-$D0,A6)
            bne.b   .L10
            bsr.w   check_upper
            tst.l   D0
            bne.b   .L10
            move.l  #$80000000,D0
            bsr.b   operr_store
            bra.w   check_upper.L4
.L10:
            move.w  (-$D8,A6),D0
            andi.w  #$7FFF,D0
            cmpi.w  #$3FFE,D0
            bne.b   .L12
            move.l  (-$D0,A6),D0
            asl.l   #8,D0
            swap    D0
            bsr.b   operr_store
            bra.w   check_upper.L4
.L11:
            ori.l   #$2080,(-$7C,A6)
            move.l  (-$C8,A6),D0
            bsr.b   operr_store
            bra.w   check_upper.L3
.L12:
            ori.l   #$2080,(-$7C,A6)
            bclr    #1,(-$7A,A6)
            bclr    #3,(-$79,A6)
            fmove.l #0,FPSR
            tst.w   (-$D8,A6)
            blt.b   .L13
            move.l  #$7FFFFFFF,D0
            bsr.b   operr_store
            bra.b   check_upper.L3
.L13:
            move.l  #$80000000,D0
            bsr.b   operr_store
            bra.b   check_upper.L3
operr_store:
            move.l  D0,(-$54,A6)
            movea.l (-$78,A6),A0
            sub.l   D0,D0
            move.w  (A0),D0
            bftst   D0{26:3}
            bne.b   .L3
            andi.l  #7,D0
            cmpi.l  #4,D1
            beq.b   .L1
            cmpi.l  #2,D1
            bne.b   .L2
            ori.l   #8,D0
            bra.b   .L2
.L1:
            ori.l   #$10,D0
.L2:
            move.l  D0,D1
            bra.w   sub_40890882
.L3:
            lea     (-$54,A6),A0
            movea.l ($C,A6),A1
            move.l  D1,D0
            bsr.w   sub_4088D248
            rts
check_upper:
            cmpi.l  #$FFFFFFFF,(-$D4,A6)
            bne.b   .L1
            cmpi.w  #$C000,(-$D8,A6)
            beq.b   .L2
            cmpi.w  #$BFFF,(-$D8,A6)
            beq.b   .L2
.L1:
            moveq   #1,D0
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            btst    #5,(-$7E,A6)
            beq.b   .L4
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($1FD4).w,-(SP)
            rts
.L4:
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            andi.b  #3,D0
            beq.b   .L5
            move.b  #$C4,($B,A6)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
            move.l  ($C4).w,-(SP)
            rts
.L5:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            unlk    A6
            rte
