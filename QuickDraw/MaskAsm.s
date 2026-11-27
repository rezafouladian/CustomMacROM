SEEDCFILL:
            link.w  A6,#-$1E
            move.l  ($10,A6),-(SP)
            pea     (-$A,A6)
            jsr     ([$165C.w])
            lea     sub_4083D6FC,A0
            moveq   #-1,D0
            bra.b   CALCCMASK.L1
CALCCMASK:
            link.w  A6,#-$1E
            movea.l ($10,A6),A0
            lea     (-$A,A6),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            lea     sub_4083D728,A0
            moveq   #0,D0
.L1:
            movem.l D3-D5/A2-A4,-(SP)
            move.l  D0,D5
            move.l  ($C,A6),D0
            bne.b   .L2
            move.l  A0,($C,A6)
.L2:
            pea     (-$18,A6)
            jsr     ([$1664.w])
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            pea     (-$1E,A6)
            jsr     ([$1668.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            clr.l   -(SP)
            jsr     GETTEMPDEVICE
            movea.l (SP)+,A4
            move.l  TheGDevice,(-$12,A6)
            move.l  A4,TheGDevice
            movea.l (A4),A0
            movea.l ($16,A0),A0
            _HLock
            movea.l (A0),A3
            movea.l (A4),A1
            lea     (-$A,A6),A0
            move.l  A0,($1A,A1)
            move.l  (8,A6),(-4,A6)
            move.l  ($C,A6),-(SP)
            jsr     ([$16E8.w])
            movea.l ($18,A6),A0
            move.l  (A0)+,D1
            move.l  (A0)+,D0
            move.w  D0,D4
            sub.w   D1,D4
            ext.l   D4
            moveq   #$F,D2
            add.l   D2,D4
            asr.l   #4,D4
            ble.w   .L6
            add.w   D4,D4
            lea     (4,A3),A0
            move.w  D4,(A0)
            ori.w   #$8000,(A0)+
            move.l  D1,(A0)+
            move.l  D0,(A0)+
            swap    D1
            swap    D0
            sub.w   D1,D0
            mulu.w  D0,D4
            move.l  D4,D0
            moveq   #$F,D1
            add.l   D1,D0
            _NewHandle
            bne.w   .L6
            movea.l (A0),A1
            lsr.l   #4,D4
            move.l  D4,D0
            swap    D0
.L3:
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            dbra    D4,.L3
            dbra    D0,.L3
            move.l  A0,(-$E,A6)
            _HLock
            move.l  (A0),(A3)
            move.l  ($20,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($18,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            movea.l ($1C,A6),A0
            move.l  (A0)+,D0
            _StripAddress
            movea.l D0,A1
            move.w  (A0)+,D0
            move.l  (A0)+,D1
            movea.l ($14,A6),A0
            move.l  (A0)+,D2
            move.l  (A0),D3
            move.l  ($10,A6),D4
            sub.w   D2,D3
            addi.w  #$F,D3
            asr.w   #4,D3
            ble.b   .L5
            sub.w   D1,D4
            sub.w   D1,D2
            add.w   D2,D4
            asr.w   #3,D2
            adda.w  D2,A1
            swap    D1
            swap    D2
            swap    D3
            swap    D4
            sub.w   D2,D3
            ble.b   .L5
            sub.w   D1,D4
            sub.w   D1,D2
            add.w   D2,D4
            swap    D4
            muls.w  D0,D2
            adda.l  D2,A1
            move.l  (A3),-(SP)
            move.l  A1,-(SP)
            move.w  (4,A3),D1
            andi.w  #$7FFF,D1
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            move.l  D3,-(SP)
            tst.w   D5
            beq.b   .L4
            move.l  D4,-(SP)
            jsr     ([$EE4.w])
            bra.b   .L5
.L4:
            jsr     ([$EE0.w])
.L5:
            movea.l (-$E,A6),A0
            _DisposHandle
.L6:
            move.l  ($C,A6),-(SP)
            jsr     ([$1730.w])
            move.l  (-$12,A6),TheGDevice
            move.l  A4,-(SP)
            jsr     ([$16C0.w])
            pea     (-$18,A6)
            jsr     ([$1650.w])
            pea     (-$1E,A6)
            jsr     ([$1654.w])
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$1C
sub_4083D6FC:
            moveq   #0,D1
            moveq   #1,D0
.L1:
            move.w  #$100,($C,SP)
            movea.l (8,SP),A0
            movea.l TheGDevice,A1
            movea.l (A1),A1
            movea.l ($1A,A1),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L2
            cmpm.w  (A0)+,(A1)+
            bne.b   .L2
            exg     D0,D1
.L2:
            movea.l (4,SP),A0
            move.l  D0,(A0)
            rtd     #8
sub_4083D728:
            moveq   #1,D1
            moveq   #0,D0
            bra.b   sub_4083D6FC.L1
            dc.w    0
GETTEMPDEVICE:
            move.l  A4,-(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  MinusOne,-(SP)
            jsr     ([$16BC.w])
            movea.l (SP)+,A4
            movea.l A4,A0
            _HUnlock
            movea.l (A4),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            clr.w   ($1E,A0)
            move.w  #1,($20,A0)
            move.w  #1,($24,A0)
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP),(A0)
            movea.l (A4),A0
            movea.l ([6.w,A0]),A0
            move.l  (SP)+,(A0)
            move.l  A4,(8,SP)
            movea.l (SP)+,A4
            rts
MASKEND:
