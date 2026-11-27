CritProc:
Mod3Test:
            movem.l .L10(PC),D0-D5
            movea.l A0,A2
            suba.w  #$78,A1
            bra.b   .L2
.L1:
            movem.l D0-D5,(A2)
            movem.l D0-D5,($18,A2)
            movem.l D0-D5,($30,A2)
            movem.l D0-D5,($48,A2)
            movem.l D0-D5,($60,A2)
            lea     ($78,A2),A2
.L2:
            cmpa.l  A1,A2
            ble.b   .L1
            suba.w  #$FF94,A1
            moveq   #$C,D5
            bra.b   .L4
.L3:
            movem.l D0-D2,(A2)
            adda.w  D5,A2
.L4:
            cmpa.l  A1,A2
            ble.b   .L3
            adda.w  D5,A1
            moveq   #4,D4
            cmpa.l  A2,A1
            beq.b   .L5
            move.l  D0,(A2)+
            moveq   #8,D4
            cmpa.l  A2,A1
            beq.b   .L5
            move.l  D1,(A2)+
            moveq   #0,D4
.L5:
            movea.l A0,A2
            move.l  A1,D3
            sub.l   A0,D3
            subq.l  #4,D3
            moveq   #$3F,D2
            and.w   D3,D2
            neg.w   D2
            lsr.l   #6,D3
            eor.l   D1,(A2)
            addi.l  #$FFFFFFFF,D5
            jmp     .L7(PC,D2.w)
.L6:
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
.L7:
            dbra    D3,.L6
            subi.l  #$10000,D3
            bpl.b   .L6
            cmpi.w  #$15,D7
            beq.w   .L9
            cmp.l   D0,D1
            beq.b   .L8
            move.l  D0,D1
            bra.b   .L5
.L8:
            movem.l (-$C,A1),D0-D2
            movem.l .L10(PC,D4.w),D3-D5
            eor.l   D3,D0
            eor.l   D4,D1
            eor.l   D5,D2
            or.l    D2,D0
            or.l    D1,D0
            or.l    D0,D6
            btst    #$12,D7
            beq.b   .L9
            move.w  #$15,D7
            movem.l .L11(PC),D0-D5
            bra.w   .L5
.L9:
            RTS6
.L10:
            dc.w    $6DB6,$DB6D
.L11:
            dc.w    $B6DB,$6DB6,$DB6D,$B6DB,$6DB6,$DB6D,$B6DB,$6DB6
            dc.w    $DB6D,$B6DB,0
RevMod3Test:
            movem.l sub_40847486(PC),D0-D5
            movea.l A1,A2
            lea     ($78,A0),A0
            bra.b   .L2
.L1:
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
.L2:
            cmpa.l  A2,A0
            ble.b   .L1
            lea     (-$6C,A0),A0
            bra.b   .L4
.L3:
            movem.l D0-D2,-(A2)
.L4:
            cmpa.l  A2,A0
            ble.b   .L3
            suba.w  #$C,A0
            moveq   #8,D4
            cmpa.l  A2,A0
            beq.b   .L5
            move.l  D2,-(A2)
            moveq   #4,D4
            cmpa.l  A2,A0
            beq.b   .L5
            move.l  D1,-(A2)
            moveq   #0,D4
.L5:
            movea.l A1,A2
            subq.l  #4,A2
            move.l  A2,D3
            sub.l   A0,D3
            moveq   #$3F,D0
            and.w   D3,D0
            neg.w   D0
            lsr.l   #6,D3
            eor.l   D1,(A2)
            addi.l  #$FFFFFFFF,D5
            jmp     .L7(PC,D0.w)
.L6:
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
.L7:
            dbra    D3,.L6
.L8:
            subi.l  #$10000,D3
            bpl.b   .L6
.L9:
            cmpi.w  #$15,D7
.L10:
            beq.w   .L12
            cmp.l   D2,D1
            beq.b   .L11
            move.l  D2,D1
            bra.b   .L5
.L11:
            movem.l (A0),D0-D2
            movem.l sub_40847486(PC,D4.w),D3-D5
            eor.l   D3,D0
            eor.l   D4,D1
            eor.l   D5,D2
            or.l    D2,D0
            or.l    D1,D0
            or.l    D0,D6
            btst    #$12,D7
            beq.b   .L12
            move.w  #$15,D7
            movem.l sub_40847486.L1+2(PC),D0-D5
            bra.w   .L5
.L12:
            RTS6
sub_40847486:
            blt.b   RevMod3Test.L7
.L1:
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L8+2
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L9
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L10+2
            add.w   D5,(-$4925,A5)
RomTest:
            BigLea  BaseOfROM,A0
            lea     ($30,A0),A1
            move.l  ($40,A0),D0
            lea     (0,A0,D0.l),A2
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D4
            addq.l  #4,A0
.L1:
            move.b  (A0)+,D4
            add.l   D4,D0
            move.b  (A0)+,D4
            add.l   D4,D1
            move.b  (A0)+,D4
            add.l   D4,D2
            move.b  (A0)+,D4
            add.l   D4,D3
            cmpa.l  A0,A1
            bne.b   .L2
            adda.w  #$10,A0
            bra.b   .L1
.L2:
            cmpa.l  A0,A2
            bgt.b   .L1
            cmp.l   (A1)+,D0
            beq.b   .L3
            bset    #0,D6
.L3:
            cmp.l   (A1)+,D1
            beq.b   .L4
            bset    #1,D6
.L4:
            cmp.l   (A1)+,D2
            beq.b   .L5
            bset    #2,D6
.L5:
            cmp.l   (A1)+,D3
            beq.b   .L6
            bset    #3,D6
.L6:
            RTS6
StartUpROMTest:
            moveq   #0,D0
            moveq   #0,D1
            BigLea  BaseOfROM,A0
            move.l  ($40,A0),D3
            subq.l  #4,D3
            move.l  (A0)+,D4
.L1:
            move.w  (A0)+,D0
            add.l   D0,D1
            subq.l  #2,D3
            bne.b   .L1
            nop
            nop
            eor.l   D4,D1
            beq.b   .L2
            move.w  #$FFFF,D6
.L2:
            RTS6
ExtRAMTest:
            moveq   #0,D0
            moveq   #-1,D1
            movea.l A0,A2
            move.l  A1,D2
            sub.l   A0,D2
            lsr.l   #2,D2
            move.l  D2,D3
.L1:
            move.l  D0,(A2)+
            subq.l  #1,D2
            bne.b   .L1
            move.l  D3,D2
            movea.l A0,A2
.L2:
            tst.l   (A2)
            bne.b   .L7
            eor.l   D1,(A2)+
            subq.l  #1,D2
            bne.b   .L2
            move.l  D3,D2
.L3:
            eor.l   D1,-(A2)
            bne.b   .L7
            subq.l  #1,D2
            bne.b   .L3
            move.l  D3,D2
.L4:
            tst.l   (A2)
            bne.b   .L7
            eor.l   D1,(A2)+
            subq.l  #1,D2
            bne.b   .L4
            move.l  D3,D2
.L5:
            eor.l   D1,-(A2)
            bne.b   .L7
            subq.l  #1,D2
            bne.b   .L5
            move.l  D3,D2
.L6:
            tst.l   (A2)
            bne.b   .L7
            addq.l  #4,A2
            subq.l  #1,D2
            bne.b   .L6
            RTS6
.L7:
            or.l    (A2),D6
            RTS6
AddrLineTest:
            clr.b   D7
            movea.l A6,A3
            BSR6    SizeMemory
            movea.l A3,A6
            bne.b   .L8
            movea.l (SP),A0
.L1:
            addq.b  #1,D7
            movea.l (A0)+,A1
            cmpa.w  #$FFFF,A1
            beq.b   .L3
            movea.l (A0)+,A2
            move.l  A1,(A1)
            moveq   #4,D5
.L2:
            movea.l D5,A3
            adda.l  A1,A3
            move.l  A3,(A3)
            lsl.l   #1,D5
            cmp.l   A2,D5
            blt.b   .L2
            bra.b   .L1
.L3:
            lea     (-4,A0),A0
.L4:
            subq.b  #1,D7
            movea.l -(A0),A2
            movea.l -(A0),A1
            moveq   #4,D5
.L5:
            lsl.l   #1,D5
            cmp.l   A2,D5
            blt.b   .L5
.L6:
            lsr.l   #1,D5
            move.l  D5,D0
            add.l   A1,D0
            movea.l D0,A3
            move.l  (A3),D6
            eor.l   D0,D6
            bne.b   .L8
            cmpi.l  #4,D5
            bgt.b   .L6
            tst.l   D5
            beq.b   .L7
            moveq   #0,D5
            bra.b   .L6
.L7:
            cmpa.l  (SP),A0
            bgt.b   .L4
            clr.b   D7
.L8:
            RTS6
DataBusTest:
            moveq   #1,D0
            moveq   #-2,D1
            move.w  #$FF,D2
.L1:
            movem.l D0-D1,(A0)
            eor.l   D0,(A0)
            or.l    (A0),D6
            eor.l   D1,(4,A0)
            or.l    (4,A0),D6
            rol.l   #1,D0
            rol.l   #1,D1
            dbra    D2,.L1
            RTS6
.L2:
            dc.w    $0011,$2233
.L3:
            dc.w    $8888,$8888,$8800,$1122,$3388,$8888,$8888,$0011
            dc.w    $2233,$8888,$8888,$8800,$1122,$3388,$8888,$8888
            dc.w    $0011,$2233,$0011,$8888,$8888,$8888,$8800,$1188
            dc.w    $8888,$8888,$8888,$0011,$8888,$8888,$8888,$8800
            dc.w    $1188,$8888,$8888,$8888,$0011,$8888,$0088,$8888
            dc.w    $8888,$8888,$8800,$8888,$8888,$8888,$8888,$0088
            dc.w    $8888,$8888,$8888,$8800,$8888,$8888,$8888,$8888
            dc.w    $0088,$8888
dynamic_bussize_test:
            move.l  #$7FFF,D6
            lea     DataBusTest.L2,A1
            lea     DataBusTest.L3,A2
            move.l  #$112233,D0
            moveq   #0,D1
.L1:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.l  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L2
            cmp.l   D5,D3
            bne.b   .L2
            swap    D1
            bclr    D1,D6
            swap    D1
.L2:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L1
            move.w  #$11,D0
            clr.w   D1
.L3:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.w  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L4
            cmp.l   D5,D3
            bne.b   .L4
            swap    D1
            bclr    D1,D6
            swap    D1
.L4:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L3
            moveq   #0,D0
            clr.w   D1
.L5:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.b  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L6
            cmp.l   D5,D3
            bne.b   .L6
            swap    D1
            bclr    D1,D6
            swap    D1
.L6:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L5
            RTS6
MovInvTest:
            movea.l A0,A5
            move.l  A1,D3
            sub.l   A0,D3
.L1:
            clr.l   (A0)+
            subq.l  #4,D3
            bne.b   .L1
            moveq   #0,D1
            move.w  #4,D1
.L2:
            suba.l  A2,A2
.L3:
            movea.l A5,A0
            adda.l  A2,A0
            moveq   #0,D2
            moveq   #0,D4
.L4:
            movea.l A0,A3
.L5:
            move.l  (A3),D3
            cmp.l   D3,D4
            bne.w   .L9
            bset    D2,D3
            move.l  D3,(A3)
            move.l  (A3),D5
            cmp.l   D5,D3
            bne.w   .L10
            adda.l  D1,A3
            cmpa.l  A1,A3
            bmi.b   .L5
            move.l  D5,D4
            addq.w  #1,D2
            cmpi.w  #$20,D2
            bne.b   .L4
            moveq   #0,D2
            moveq   #-1,D4
.L6:
            movea.l A0,A3
.L7:
            move.l  (A3),D3
            cmp.l   D3,D4
            bne.w   .L9
            bclr    D2,D3
            move.l  D3,(A3)
            move.l  (A3),D5
            cmp.l   D5,D3
            bne.w   .L10
            adda.l  D1,A3
            cmpa.l  A1,A3
            bmi.b   .L7
            move.l  D5,D4
            addq.w  #1,D2
            cmpi.w  #$20,D2
            bne.b   .L6
            addq.l  #4,A2
            cmpa.l  D1,A2
            bne.b   .L3
            asl.l   #1,D1
            cmpi.l  #$80000,D1
            bne.b   .L2
.L8:
            movea.l A5,A0
            RTS6
.L9:
            eor.l   D3,D4
            move.l  D4,D6
            bra.b   .L8
.L10:
            eor.l   D5,D3
            move.l  D3,D6
            bra.b   .L8
NoTest:
            moveq   #0,D6
            RTS6
            dc.w    0
