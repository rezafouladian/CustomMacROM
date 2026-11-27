            dc.b    $00,$00,$00,$00,$02,$03,$02,$03,$02,$03,$03,$02,$03,$02,$02,$03
sub_4088E4FE:
            fmove.l #0,FPCR
            movem.l D2-D5,-(SP)
            moveq   #2,D2
            moveq   #4,D3
            lea     (-$74,A6),A0
            move.l  (-$CC,A6),(A0)
            move.l  (-$C8,A6),(4,A0)
            move.l  (-$C4,A6),(8,A0)
            move.l  (A0),D4
            moveq   #0,D1
.a_1326:
            mulu.l  #$A,D1
            bfextu  D4{D3:4},D0
            add.l   D0,D1
            addq.b  #$4,D3
            dbra    D2,.a_1326
            btst    #$1E,D4
            beq.b   .a_1342
            neg.l   D1
.a_1342:
            subi.l  #$10,D1
            bge.b   .a_1358
            neg.l   D1
            ori.l   #$40000000,D4
            ori.l   #$40000000,(A0)
.a_1358:
            move.l  D1,(-$54,A6)
            moveq   #$1,D1
            fmove.b  #$0,FP0
            bfextu  (A0){28:4},D0
            fadd.b  D0,FP0
.a_136C:
            move.l  (0,A0,D1.l*4),D4
            moveq   #$0,D3
            moveq   #$7,D2
.a_1374:
            fmul.b  #$A,FP0
            bfextu  D4{D3:4},D0
            fadd.b  D0,FP0
            addq.b  #$4,D3
            dbra    D2,.a_1374
            addq.l  #$1,D1
            cmpi.l  #$2,D1
            ble.b   .a_136C
            btst    #$1F,(A0)
            beq.b   .a_139C
            fneg.x  FP0
.a_139C:
            move.l  (-$54,A6),D1
            cmpi.l  #$1B,D1
            ble.w   .a_1484
            btst    #$1E,(A0)
            bne.b   .a_1420
            moveq   #$0,D1
            move.l  (A0),D4
            bfextu  D4{28:4},D0
            bne.b   .a_13DE
            addq.l  #$1,D1
            moveq   #$1,D5
            move.l  (0,A0,D5.l*4),D4
            bne.b   .a_13CC
            addq.l  #$8,D1
            addq.l  #$1,D5
            move.l  (0,A0,D5.l*4),D4
.a_13CC:
            moveq   #$0,D3
            moveq   #$7,D2
.a_13D0:
            bfextu  D4{D3:4},D0
            bne.b   .a_13DE
            addq.l  #$4,D3
            addq.l  #$1,D1
            dbra    D2,.a_13D0
.a_13DE:
            move.l  D1,D0
            move.l  (-$54,A6),D1
            sub.l   D0,D1
            bge.b   .a_13F8
            neg.l   D1
            move.l  (A0),D4
            ori.l   #$40000000,D4
            ori.l   #$40000000,(A0)
.a_13F8:
            lea     (sub_408934EA.L8.w,PC),A1
            moveq   #$0,D3
            fmove.b  #$1,FP1
            moveq   #$3,D2
.a_1406:
            asr.l   #$1,D0
            bcc.b   .a_1410
            fmul.x  ($0,A1,D3.w),FP1
.a_1410:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .a_1406
            fmul.x  FP1,FP0
            bra.b   .a_1484
.a_1420:
            moveq   #$0,D1
            moveq   #$2,D5
            move.l  (0,A0,D5.l*4),D4
            bne.b   .a_1432
            subq.l  #$1,D5
            addq.l  #$8,D1
            move.l  (0,A0,D5.l*4),D4
.a_1432:
            moveq   #$1C,D3
            moveq   #$7,D2
.a_1436:
            bfextu  D4{D3:4},D0
            bne.b   .a_1444
            subq.l  #$4,D3
            addq.l  #$1,D1
            dbra    D2,.a_1436
.a_1444:
            move.l  D1,D0
            move.l  (-$54,A6),D1
            sub.l   D0,D1
            bgt.b   .a_145E
            neg.l   D1
            move.l  (A0),D4
            andi.l  #$BFFFFFFF,D4
            andi.l  #$BFFFFFFF,(A0)
.a_145E:
            lea     (sub_408934EA.L8.w,PC),A1
            moveq   #$0,D3
            fmove.b  #$1,FP1
            moveq   #$3,D2
.a_146C:
            asr.l   #$1,D0
            bcc.b   .a_1476
            fmul.x  ($0,A1,D3.w),FP1
.a_1476:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .a_146C
            fdiv.x  FP1,FP0
.a_1484:
            move.l  (-$80,A6),D3
            bfextu  D3{26:2},D2
            move.l  (A0),D4
            asl.l   #$2,D2
            bfextu  D4{0:2},D0
            add.l   D0,D2
            lea     (InstallFPSP+$12EE.w,PC),A1
            move.b  (0,A1,D2.w),D0
            moveq   #$0,D3
            bfins   D0,D3{26:2}
            fmove.l D3,FPCR
            asr.l   #$1,D0
            bcc.b   .a_14B2
            lea     (sub_408934EA.L12.w,PC),A1
            bra.b   .a_14C0
.a_14B2:
            asr.l   #$1,D0
            bcc.b   .a_14BC
            lea     (sub_408934EA.L10.w,PC),A1
            bra.b   .a_14C0
.a_14BC:
            lea     (sub_408934EA.L8.w,PC),A1
.a_14C0:
            move.l  D1,D0
            bpl.b   .a_14CC
            neg.l   D0
            ori.l   #$40000000,(A0)
.a_14CC:
            moveq   #$0,D3
            fmove.b  #$1,FP1
.a_14D4:
            asr.l   #$1,D0
            bcc.b   .a_14DE
            fmul.x  ($0,A1,D3.w),FP1
.a_14DE:
            addi.l  #$C,D3
            tst.l   D0
            bne.b   .a_14D4
            btst    #$1E,(A0)
            beq.b   .a_14F4
            fdiv.x  FP1,FP0
            bra.b   .a_14F8
.a_14F4:
            fmul.x  FP1,FP0
.a_14F8:
            fmove.l FPSR,D0
            bclr    #$9,D0
            fmove.l D0,FPSR
            beq.b   .a_150E
            ori.l   #$108,(-$7C,A6)
.a_150E:
            movem.l (SP)+,D2-D5
            rts
