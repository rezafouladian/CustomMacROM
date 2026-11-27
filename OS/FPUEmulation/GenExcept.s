.L23:
            dc.w    $0102,$0106,$0106,$017E,$017E,$0106,$010E,$010E
            dc.w    $0146
gen_except:
            cmpi.b  #0,(1,SP)
            beq.w   sub_4088DECC.L5
            cmpi.b  #$28,(1,SP)
            beq.b   sub_4088DECC.L2
            cmpi.b  #$30,(1,SP)
            beq.b   sub_4088DECC.L2
            cmpi.b  #$60,(1,SP)
            bne.w   InstallFPSP.L1
            lea     ($124,SP),A1
            move.l  (-$CC,A6),(-$CC,A1)
            move.l  (-$C8,A6),(-$C8,A1)
            move.l  (-$C4,A6),(-$C4,A1)
            move.l  (-$E4,A6),(-$E4,A1)
            bsr.b   sub_4088DECC
            move.l  D0,(-$F0,A1)
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            move.l  (-$7C,A6),(-$100,A1)
            ori.l   #$1800000,(-$DC,A1)
            bra.w   sub_4088DECC.L7
sub_4088DECC:
            move.l  (-$E4,A6),D0
            andi.l  #$3FF0000,D0
            bfextu  D0{10:4},D1
            lsr.b   #1,D1
            bcc.b   .L1
            bset    #3,D1
.L1:
            bfins   D1,D0{10:4}
            rts
.L2:
            cmpi.b  #$28,(1,SP)
            bne.b   .L3
            lea     ($EC,SP),A1
            bra.b   .L4
.L3:
            cmpi.b  #$30,(1,SP)
            bne.w   InstallFPSP.L1
            lea     ($F4,SP),A1
.L4:
            move.l  (-$E4,A6),(-$E4,A1)
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            bra.w   .L7
.L5:
            addq.l  #4,SP
            fmove.l FPSR,D0
            or.l    D0,(-$7C,A6)
            cmpi.b  #$60,(1,SP)
            bne.b   .L6
            clr.w   (-$EC,A6)
            btst    #5,(-$E4,A6)
            bne.b   .L6
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
.L6:
            move.b  (-$7E,A6),D0
            and.b   (-$7A,A6),D0
            bfffo   D0{24:8},D1
            lea     sub_4088DBD0.L23,A0
            subi.b  #$18,D1
            adda.w  (0,A0,D1.w*2),A0
            jmp     (A0)
            bra.w   .L7
            bset    #2,(-$DC,A6)
            bra.b   .L15
            tst.b   (-$47,A6)
            bne.b   .L16
            bset    #1,(-$DC,A6)
            bclr    #2,(-$DC,A6)
            bra.b   .L15
.L16:
            tst.b   (-$49,A6)
            bne.b   .L17
            bset    #1,(-$DC,A6)
.L17:
            bclr    #2,(-$DC,A6)
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A6)
.L15:
            bclr    #5,(-$DB,A6)
            bra.w   .L7
            btst    #1,(-$7E,A6)
            beq.b   .L18
            btst    #4,(-$7A,A6)
            beq.b   .L18
            bra.b   .L19
.L18:
            tst.b   (-$47,A6)
            beq.b   .L20
            tst.b   (-$49,A6)
            bne.w   .L7
.L20:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            unlk    A6
            bra.w   .L21
.L19:
            tst.b   (-$47,A6)
            beq.b   .L22
            tst.b   (-$46,A6)
            beq.b   .L16
            clr.b   (-$11C,A6)
            bset    #2,(-$DC,A6)
            move.w  (-$CC,A6),(-$D8,A6)
            move.l  (-$C8,A6),(-$D4,A6)
            move.l  (-$C4,A6),(-$D0,A6)
            bset    #4,(-$E0,A6)
            bclr    #5,(-$DB,A6)
            bra.b   .L7
.L22:
            move.b  (SP),(-$45,A6)
            cmpi.b  #$60,(1,SP)
            beq.b   .L23
            cmpi.b  #$40,(SP)
            bne.b   .L24
            moveq   #$D,D0
            bra.b   .L25
.L24:
            cmpi.b  #$41,(SP)
            bne.w   InstallFPSP.L1
            moveq   #$B,D0
            clr.w   (-$EC,A6)
.L25:
            clr.l   (SP)
.L26:
            clr.l   -(SP)
            dbra    D0,.L26
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
.L23:
            move.l  (-$74,A6),(-$10C,A6)
            move.l  (-$70,A6),(-$108,A6)
            move.l  (-$6C,A6),(-$104,A6)
            bset    #1,(-$DC,A6)
            bclr    #2,(-$DC,A6)
            bclr    #5,(-$DB,A6)
            move.l  (-$7C,A6),(-$100,A6)
            ori.l   #$1800000,(-$DC,A6)
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A6)
.L7:
            cmpi.b  #$28,(1,SP)
            bne.b   .L8
            moveq   #$D,D0
            bra.b   .L9
.L8:
            cmpi.b  #$30,(1,SP)
            bne.b   .L12
            moveq   #$B,D0
            clr.w   (-$EC,A6)
.L9:
            move.b  (SP),(-$45,A6)
            clr.l   (SP)
.L10:
            clr.l   -(SP)
            dbra    D0,.L10
            lea     ($124,SP),A1
            move.b  (-$45,A6),(SP)
            move.b  #$60,(1,SP)
            move.l  (-$74,A6),(-$10C,A1)
            move.l  (-$70,A6),(-$108,A1)
            move.l  (-$6C,A6),(-$104,A1)
            btst    #2,(-$DC,A1)
            bne.b   .L11
            bsr.w   sub_4088DECC
            move.l  D0,(-$F0,A1)
            bra.b   .L12
.L11:
            bfextu  (-$7C,A6){17:4},D0
            bfins   D0,(-$EB,A1){4:4}
            move.l  (-$7C,A6),(-$100,A1)
            ori.l   #$1800000,(-$DC,A1)
.L12:
            movem.l (-$C0,A6),D0-D1/A0-A1
            fmovem.x (-$B0,A6),FP0-FP3
            fmovem.l (-$80,A6),FPCR/FPSR/FPIAR
            frestore (SP)+
            unlk    A6
.L21:
            btst    #7,(SP)
            bne.b   .L13
            btst    #6,(SP)
            bne.b   .L13
            rte
.L13:
            bftst   (6,SP){0:4}
            bne.b   .L14
            subq.w  #4,SP
            move.l  (4,SP),(SP)
            move.l  (8,SP),(4,SP)
            suba.w  #$64,SP
            fsave   (SP)
            fmove.l FPIAR,($6C,SP)
            frestore (SP)
            lea     ($64,SP),SP
.L14:
            move.w  #$2024,(6,SP)
            move.l  TraceVector,-(SP)
            rts
