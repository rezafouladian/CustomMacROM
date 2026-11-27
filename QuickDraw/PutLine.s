PutLine:
            movem.l D3-D7/A2-A4,-(SP)
            move.w  ($36,SP),D2
            move.w  ($32,SP),D4
            cmp.w   D2,D4
            beq.w   .L13
            move.w  D2,D0
            sub.w   D4,D0
            bpl.b   .L1
            neg.w   D0
.L1:
            move.w  ($34,SP),D1
            sub.w   ($30,SP),D1
            bpl.b   .L2
            neg.w   D1
.L2:
            cmp.w   D1,D0
            ble.b   .L3
            move.w  D1,D0
.L3:
            addq.w  #1,D0
            ext.l   D0
            lsl.l   #3,D0
            movea.l ($2C,SP),A3
            movea.l ($28,SP),A4
            moveq   #0,D1
            move.w  (A4),D1
            add.l   D1,D0
            cmpi.l  #$FE00,D0
            blt.b   .L4
            move.w  #$FF6D,QDErr
            bra.w   .L13
.L4:
            movea.l ($24,SP),A0
            cmp.w   (A0),D0
            bls.b   .L5
            addi.w  #$200,D0
            move.w  D0,(A0)
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            move.w  ($36,SP),D2
.L5:
            movea.l (A3),A3
            moveq   #0,D0
            move.w  (A4),D0
            adda.l  D0,A3
            move.w  ($34,SP),D1
            move.w  ($30,SP),D3
            cmp.w   D1,D3
            bne.b   .L6
            move.w  D1,(A3)+
            move.w  D2,(A3)+
            move.w  D3,(A3)+
            move.w  D4,(A3)+
            bra.b   .L12
.L6:
            bgt.b   .L7
            exg     D1,D3
            exg     D2,D4
.L7:
            move.w  D1,D6
            clr.l   -(SP)
            move.w  D4,-(SP)
            sub.w   D2,(SP)
            move.w  D3,-(SP)
            sub.w   D1,(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D7
            move.w  D2,D1
            swap    D1
            move.w  #$8000,D1
            move.l  D7,D0
            asr.l   #1,D0
            add.l   D0,D1
            move.l  #$10000,D0
            tst.l   D7
            bmi.b   .L8
            cmp.l   D0,D7
            bge.b   .L9
            add.l   D7,D1
            bra.b   .L9
.L8:
            cmpi.l  #$FFFF0000,D7
            bge.b   .L9
            add.l   D0,D1
.L9:
            move.w  D2,D5
.L10:
            swap    D1
            cmp.w   D1,D5
            beq.b   .L11
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            move.w  D1,D5
            move.w  D6,(A3)+
            move.w  D5,(A3)+
.L11:
            swap    D1
            addq.w  #1,D6
            add.l   D7,D1
            cmp.w   D6,D3
            bne.b   .L10
            cmp.w   D4,D5
            beq.b   .L12
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            move.w  D6,(A3)+
            move.w  D4,(A3)+
.L12:
            movea.l ($2C,SP),A0
            suba.l  (A0),A3
            move.w  A3,(A4)
.L13:
            movem.l (SP)+,D3-D7/A2-A4
            movea.l (SP)+,A0
            lea     ($14,SP),SP
            jmp     (A0)
            ds.b    6
