fline:
            cmpi.w  #$202C,(6,SP)
            beq.w   unsupp.L3
            subq.l  #4,SP
            link.w  A6,#-$C0
            fsave   -(SP)
            movem.l D0-D1/A0-A1,(-$C0,A6)
            movea.l ($A,A6),A0
            move.l  (A0),D0
            bfextu  D0{4:3},D1
            cmpi.b  #1,D1
            bne.b   .L3
            bfextu  D0{16:6},D1
            cmpi.b  #$17,D1
            bne.b   .L3
            cmpi.b  #$40,(SP)
            bne.b   .L1
            suba.w  #$28,SP
            move.b  #$40,(SP)
            move.b  #$28,(1,SP)
            clr.w   (2,SP)
            bra.b   .L2
.L1:
            cmpi.b  #$41,(SP)
            bne.w   InstallFPSP.L1
            suba.w  #$30,SP
            move.b  #$41,(SP)
            move.b  #$30,(1,SP)
            clr.w   (2,SP)
.L2:
            move.w  (8,A6),(4,A6)
            move.l  ($A,A6),(6,A6)
            fmove.l (6,A6),FPIAR
            moveq   #4,D1
            add.l   D1,(6,A6)
            move.w  #$202C,($A,A6)
            clr.l   ($C,A6)
            move.w  D0,(-$E4,A6)
            clr.l   (-$DC,A6)
            bset    #5,(-$DB,A6)
            movem.l (-$C0,A6),D0-D1/A0-A1
            bra.w   unsupp.L4
.L3:
            movem.l (-$C0,A6),D0-D1/A0-A1
            frestore (SP)+
            unlk    A6
            addq.l  #4,SP
            move.l  ($1FC8).w,-(SP)
            rts
