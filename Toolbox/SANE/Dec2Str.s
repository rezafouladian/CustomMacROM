.L2:
            movem.l D2-D5,-(SP)
            link.w  A6,#0
            movea.l ($20,A6),A0
            move.l  (A0),D5
            movea.l ($18,A6),A0
            movea.l ($1C,A6),A1
            move.l  (A1)+,D4
            addq.w  #1,A0
            moveq   #-$50,D2
            moveq   #0,D1
            move.b  (A1)+,D1
            beq.b   .L6
            btst    #$18,D4
            beq.b   .L3
            move.b  #$2D,(A0)+
            bra.b   .L4
.L3:
            btst    #$18,D5
            bne.b   .L5
            move.b  #$20,(A0)+
.L4:
            addq.w  #1,D2
.L5:
            move.b  (A1),D0
            cmpi.b  #$3F,D0
.L6:
            beq.w   sub_4087A2BA.L1
            ori.b   #$20,D0
            cmpi.b  #$69,D0
            beq.w   sub_4087A2BA.L8
            cmpi.b  #$6E,D0
            bne.b   sub_4087A206.L2
            move.b  #$4E,(A0)+
            move.b  #$41,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$28,(A0)+
            move.b  #$29,(3,A0)
            addq.w  #5,D2
            moveq   #0,D3
            cmpi.b  #5,D1
            ble.b   .L7
            moveq   #5,D1
.L7:
            bsr.b   sub_4087A206
            move.l  D3,D0
            bsr.b   sub_4087A206
            asl.b   #4,D3
            or.l    D0,D3
.L8:
            moveq   #4,D0
            bra.b   sub_4087A206.L9
sub_4087A206:
            subq.w  #1,D1
            ble.b   sub_4087A15E.L8
            move.b  (0,A1,D1.w),D3
            cmpi.b  #$39,D3
            ble.b   .L1
            subq.b  #7,D3
.L1:
            andi.b  #$F,D3
            rts
.L2:
            cmpi.b  #$30,(A1)
            bne.b   .L3
            moveq   #1,D1
            moveq   #0,D4
.L3:
            btst    #$18,D5
            bne.w   sub_4087A2BA.L2
            tst.w   D5
            bgt.b   .L4
            moveq   #1,D5
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A29A
            move.w  D1,D3
            ext.l   D3
            subq.l  #1,D3
            bgt.b   .L5
            cmpi.w  #1,D5
            ble.b   .L6
.L5:
            bsr.b   sub_4087A2A8
            move.w  D3,D0
            bsr.b   sub_4087A29A
            move.w  D5,D0
            sub.w   D1,D0
            bsr.b   sub_4087A2BA
.L6:
            addq.w  #2,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$65,(A0)+
            ext.l   D4
            add.l   D4,D3
            blt.b   .L7
            move.b  #$2B,(A0)+
            bra.b   .L8
.L7:
            move.b  #$2D,(A0)+
            neg.l   D3
.L8:
            moveq   #0,D0
.L9:
            lea     sub_4087A2BA.L9,A1
.L10:
            addq.w  #2,D0
            cmp.w   (-2,A1,D0.w),D3
            bcs.b   .L13
            cmpi.b  #8,D0
            blt.b   .L10
.L11:
            divu.w  (-2,A1,D0.w),D3
.L12:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            addi.w  #$30,D3
            move.b  D3,(A0)+
            swap    D3
            ext.l   D3
.L13:
            subq.w  #2,D0
            bgt.b   .L11
            beq.b   .L12
            bra.b   sub_4087A2BA.L6
sub_4087A29A:
            ble.b   .L2
            add.w   D0,D2
            bgt.b   sub_4087A2BA.L1
.L1:
            move.b  (A1)+,(A0)+
            subq.w  #1,D0
            bgt.b   .L1
.L2:
            rts
sub_4087A2A8:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$2E,(A0)+
            rts
.L1:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$30,(A0)+
sub_4087A2BA:
            subq.w  #1,D0
            bge.b   sub_4087A2A8.L1
            rts
.L1:
            movea.l ($18,A6),A0
            move.w  #$13F,(A0)
            bra.b   .L7
.L2:
            move.w  D1,D3
            add.w   D4,D3
            ble.b   .L4
            tst.w   D4
            bge.b   .L3
            move.w  D3,D0
            bsr.b   sub_4087A29A
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D4,D0
            bra.b   .L5
.L3:
            move.w  D1,D0
            bsr.b   sub_4087A29A
            move.w  D4,D0
            bsr.b   sub_4087A2BA
            move.w  D5,D0
            ble.b   .L6
            bsr.b   sub_4087A2A8
            bsr.b   sub_4087A2BA
            bra.b   .L6
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A2BA
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D3,D0
            bsr.b   sub_4087A2BA
            move.w  D1,D0
.L5:
            bsr.b   sub_4087A29A
            move.w  D4,D0
            add.w   D5,D0
            bsr.b   sub_4087A2BA
.L6:
            movea.l ($18,A6),A0
            addi.w  #$50,D2
            move.b  D2,(A0)
.L7:
            unlk    A6
            movem.l (SP)+,D2-D5/A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            move.b  #$49,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$46,(A0)
            addq.w  #3,D2
            bra.b   .L6
.L9:
            dc.w    $000A,$0064,$03E8,$2710
            ds.b    10
