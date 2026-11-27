            dc.w    $3FFF,$400C
.a_47B2:
            fmove.l #$0,FPCR
            moveq   #$0,D1
            move.w  (-$D8,A6),D1
            smi.b   (-$54,A6)
            andi.l  #$7FFF,D1
            move.w  (-$CC,A6),D0
            andi.w  #$7FFF,D0
            cmp2.w  (InstallFPSP+$47AE.w,PC),D0
            bcc.b   InstallFPSP+$4804
            cmpi.w  #$400C,D0
            bge.w   InstallFPSP+$4A32
            move.b  (-$E0,A6),D0
            andi.b  #$E0,D0
            tst.b   D0
            beq.b   .a_47F6
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.a_47F6:
            fmove.l (-$80,A6),FPCR
            fmove.x  (-$D8,A6),FP0
            rts
            fmove.x (-$CC,A6),FP0
            fmove.l #$10,FPCR
            fmove.l FP0,D0
            fmove.l #0,FPSR
            tst.w   (-$CC,A6)
            blt.w   .L11
            tst.w   D1
            beq.w   .L24
            add.l   D0,D1
            beq.b   .L8
            cmpi.l  #$7FFF,D1
            bge.b   .L6
            tst.b   (-$54,A6)
            beq.b   .L5
            ori.w   #$8000,D1
.L5:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L6:
            tst.b   (-$54,A6)
            beq.b   .L7
            ori.w   #$8000,D1
.L7:
            move.w  (-$D8,A6),(-$CC,A6)
            move.l  (-$D4,A6),(-$C8,A6)
            move.l  (-$D0,A6),(-$C4,A6)
            bra.w   t_ovfl2
.L8:
            tst.b   (-$54,A6)
            beq.b   .L9
            ori.w   #$8000,D1
.L9:
            tst.l   (-$D4,A6)
            blt.b   .L10
            move.w  D1,(-$D8,A6)
            ori.l   #$800,(-$7C,A6)
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.L10:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L11:
            add.l   D0,D1
            beq.b   .L8
            blt.b   .L13
            tst.b   (-$54,A6)
            beq.b   .L12
            ori.w   #$8000,D1
.L12:
            move.w  D1,(-$D8,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L13:
            move.w  D1,D0
            movem.l D2-D3,-(SP)
            move.l  (-$D4,A6),D1
            move.l  (-$D0,A6),D2
            moveq   #0,D3
            cmpi.w  #$FFE0,D0
            bgt.b   .L14
            move.l  D2,D3
            move.l  D1,D2
            moveq   #0,D1
            addi.w  #$20,D0
            beq.b   .L16
            cmpi.w  #$FFE0,D0
            bge.b   .L14
            moveq   #0,D2
            moveq   #1,D3
            bra.b   .L16
.L14:
            lsr.l   #1,D1
            roxr.l  #1,D2
            roxr.l  #1,D3
            bcc.b   .L15
            ori.b   #1,D3
.L15:
            addq.w  #1,D0
            bne.b   .L14
.L16:
            clr.w   (-$D8,A6)
            tst.b   (-$54,A6)
            beq.b   .L17
            ori.w   #$8000,(-$D8,A6)
.L17:
            ori.l   #$800,(-$7C,A6)
            tst.l   D3
            beq.b   .L21
            ori.l   #$A28,(-$7C,A6)
            bfextu  (-$7D,A6){2:2},D0
            beq.b   .L19
            btst    #1,D0
            beq.b   .L21
            btst    #0,D0
            bne.b   .L18
            tst.b   (-$54,A6)
            bne.b   .L20
            bra.b   .L21
.L18:
            tst.b   (-$54,A6)
            beq.b   .L20
            bra.b   .L21
.L19:
            tst.l   D3
            bpl.b   .L21
            bftst   D3{1:31}
            bne.b   .L20
            btst    #0,D2
            beq.b   .L21
.L20:
            moveq   #0,D0
            addq.l  #1,D2
            addx.l  D0,D1
.L21:
            move.l  D1,(-$D4,A6)
            move.l  D2,(-$D0,A6)
            move.l  D2,D0
            movem.l (SP)+,D2-D3
            or.l    D1,D0
            bne.b   .L22
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            rts
.L22:
            ori.l   #$800,(-$7C,A6)
            tst.b   (-$54,A6)
            beq.b   .L23
            ori.l   #$8000000,(-$7C,A6)
.L23:
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.L24:
            movem.l D2-D3,-(SP)
            move.w  (-$D8,A6),D1
            move.l  (-$D4,A6),D2
            move.l  (-$D0,A6),D3
.L25:
            tst.l   D2
            blt.b   .L26
            tst.l   D0
            beq.b   .L28
            subq.l  #1,D0
            lsl.l   #1,D3
            roxl.l  #1,D2
            bra.b   .L25
.L26:
            add.w   D0,D1
            tst.b   (-$54,A6)
            beq.b   .L27
            ori.l   #$8000,D1
.L27:
            movem.w D1,(-$D8,A6)
            movem.l D2,(-$D4,A6)
            movem.l D3,(-$D0,A6)
            fmove.l (-$80,A6),FPCR
            fmove.x (-$D8,A6),FP0
            movem.l (SP)+,D2-D3
            rts
.L28:
            tst.b   (-$54,A6)
            beq.b   .L29
            ori.l   #$8000000,(-$7C,A6)
            ori.l   #$8000,D1
.L29:
            movem.w D1,(-$D8,A6)
            movem.l D2,(-$D4,A6)
            movem.l D3,(-$D0,A6)
            ori.l   #$800,(-$7C,A6)
            movem.l (SP)+,D2-D3
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
            tst.b   (-$54,A6)
            beq.b   .L30
            ori.l   #$8000,D1
.L30:
            move.l  (-$D4,A6),(-$C8,A6)
            move.l  (-$D0,A6),(-$C4,A6)
            tst.w   (-$CC,A6)
            blt.b   .L31
            move.w  D1,(-$CC,A6)
            bra.w   t_ovfl2
.L31:
            move.w  D1,(-$CC,A6)
            lea     (-$CC,A6),A0
            bra.w   sub_408909D4
