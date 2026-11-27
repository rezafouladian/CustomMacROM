.L11:
            bfextu  (-$E4,A6){9:7},D0
            bfextu  (-$80,A6){26:2},D1
            tst.b   D0
            beq.b   .L13
            cmpi.b  #$A,D0
            ble.b   .L12
            cmpi.b  #$E,D0
            ble.b   .L16
            cmpi.b  #$2F,D0
            ble.b   .L12
            cmpi.b  #$3F,D0
            ble.b   .L19
.L12:
            fmove.b #0,FP0
            rts
.L13:
            tst.b   D1
            beq.b   .L14
            cmpi.b  #3,D1
            beq.b   .L15
            lea     sub_408934EA.L2,A0
            bra.w   .L22
.L14:
            lea     sub_408934EA.L1,A0
            bra.w   .L22
.L15:
            lea     sub_408934EA.L3,A0
            bra.b   .L22
.L16:
            subi.l  #$B,D0
            tst.b   D1
            beq.b   .L17
            cmpi.b  #3,D1
            beq.b   .L18
            lea     sub_408934EA.L5,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L17:
            lea     sub_408934EA.L4,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L18:
            lea     sub_408934EA.L6,A0
            cmpi.b  #2,D0
            ble.b   .L22
            bra.b   .L23
.L19:
            subi.l  #$30,D0
            tst.b   D1
            beq.b   .L20
            cmpi.b  #3,D1
            beq.b   .L21
            lea     sub_408934EA.L9,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
            bra.b   .L22
.L20:
            lea     sub_408934EA.L7,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
            bra.b   .L22
.L21:
            lea     sub_408934EA.L11,A0
            cmpi.b  #1,D0
            ble.b   .L22
            cmpi.b  #7,D0
            ble.b   .L23
.L22:
            ori.l   #$208,(-$7C,A6)
.L23:
            mulu.l  #$C,D0
            move.l  D1,(-$54,A6)
            bfextu  (-$80,A6){24:2},D1
            tst.l   D1
            bne.b   .L24
            fmovem.x (0,A0,D0.w),FP0
            rts
.L24:
            swap    D1
            add.l   (-$54,A6),D1
            move.l  (0,A0,D0.w),(-$74,A6)
            move.l  (4,A0,D0.w),(-$70,A6)
            move.l  (8,A0,D0.w),(-$6C,A6)
            moveq   #0,D0
            lea     (-$74,A6),A0
            btst    #7,(A0)
            sne     (2,A0)
            bsr.w   round
            bfclr   (2,A0){0:8}
            beq.b   .L25
            bset    #7,(A0)
.L25:
            fmovem.x (A0),FP0
            rts
            ds.b    8
