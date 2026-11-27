QDEXTDISPATCHER:
            cmpi.w  #$15,D0
            bhi.b   .L2
            jmp     .L1(PC,D0.w*4)
.L1:
            jmp     NEWGWORLD
            dc.w    $4EFA,$1080,$4EFA,$10BC,$4EFA,$0618,$4EFA,$0574
            dc.w    $4EFA,$0510,$4EFA,$052C,$4EFA,$10F8,$4EFA,$10E4
            dc.w    $4EFA,$10D0,$4EFA,$110C,$4EFA,$1118,$4EFA,$1134
            dc.w    $4EFA,$1150,$4EFA,$117C,$4EFA,$11D8,$4EFA,$1224
            dc.w    $4EFA,$1400,$4EFA,$05AC,$4EFA,$1028,$4EFA,$1424
            dc.w    $4EFA,$1214
.L2:
            movea.l (SP)+,A0
            swap    D0
            ext.l   D0
            adda.l  D0,SP
            move.w  #$FFCE,D0
            move.w  D0,QDErr
            jmp     (A0)
            ds.b    12
NEWGWORLD:
            link.w  A6,#-$3E
            movem.l D3-D7/A2-A4,-(SP)
            clr.w   ($1E,A6)
            clr.l   (-$A,A6)
            clr.l   (-$E,A6)
            clr.l   (-$12,A6)
            clr.l   (-$16,A6)
            clr.l   (-$1A,A6)
            clr.l   (-$1E,A6)
            clr.b   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$10B8.w])
            move.b  (SP)+,D0
            bne.w   .L23
            move.l  TheGDevice,(-$26,A6)
            moveq   #$6C,D0
            _ResrvMem
            bne.w   .L24
            moveq   #$6C,D0
            _NewHandle
            bne.w   .L24
            move.l  A0,(-$1E,A6)
            _HLock
            move.l  (A0),D0
            _StripAddress
            move.l  D0,(-$22,A6)
            movea.l D0,A0
            clr.w   (6,A0)
            move.l  (8,A6),D3
            move.w  ($18,A6),D7
            bmi.w   .L22
            beq.b   .L2
            cmpi.w  #$20,D7
            bgt.w   .L22
            clr.w   (-$2E,A6)
            movea.l ($14,A6),A0
            move.l  (A0),(-$3E,A6)
            move.l  (4,A0),(-$3A,A6)
            btst    #1,D3
            beq.b   .L1
            move.l  ($C,A6),D0
            beq.w   .L23
            move.l  D0,(-$26,A6)
.L1:
            bra.b   .L3
.L2:
            clr.l   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$26,A6)
            movea.l (A0),A0
            movea.l ($14,A6),A1
            move.w  (2,A1),D0
            sub.w   ($24,A0),D0
            move.w  D0,(-$2E,A6)
            move.w  (6,A1),D0
            sub.w   (2,A1),D0
            move.w  D0,(-$38,A6)
            move.w  (4,A1),D0
            sub.w   (A1),D0
            move.w  D0,(-$3A,A6)
            clr.l   (-$3E,A6)
            movea.l ([-$26.w,A6]),A0
            movea.l ([$16.w,A0]),A1
            move.w  ($20,A1),D7
.L3:
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D0
            bmi.w   .L22
            move.w  D0,(-2,A6)
            move.w  (-$3E,A6),(-$36,A6)
            move.w  (-$2E,A6),D1
            lsl.w   D0,D1
            andi.w  #$1F,D1
            lsr.w   D0,D1
            move.w  (-$3C,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$34,A6)
            move.l  (-$3A,A6),(-$32,A6)
            move.w  (-$38,A6),D0
            sub.w   (-$3C,A6),D0
            ext.l   D0
            move.w  (-2,A6),D1
            lsl.l   D1,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-6,A6)
            move.w  (-$3A,A6),D1
            sub.w   (-$3E,A6),D1
            mulu.w  D1,D0
            btst    #2,D3
            beq.b   .L4
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L5
            move.w  #$FF69,D0
            bra.w   .L24
.L4:
            _NewHandle
            bne.w   .L24
.L5:
            move.l  A0,(-$A,A6)
            _MoveHHi
            btst    #0,D3
            beq.b   .L6
            _HPurge
.L6:
            movea.l ([-$26.w,A6]),A0
            move.w  ($A,A0),(-4,A6)
            moveq   #$32,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$E,A6)
            movea.l (A0),A1
            move.l  (-$A,A6),(A1)
            move.w  (-6,A6),D0
            ori.w   #$8000,D0
            move.w  D0,(4,A1)
            move.l  (-$36,A6),(6,A1)
            move.l  (-$32,A6),($A,A1)
            move.w  #2,($E,A1)
            move.w  #$48,($16,A1)
            move.w  #$48,($1A,A1)
            move.w  D7,($20,A1)
            cmpi.w  #$10,D7
            blt.b   .L9
            move.w  #2,(-$2C,A6)
            move.w  #$10,($1E,A1)
            move.w  #3,($22,A1)
            moveq   #8,D0
            cmpi.w  #$20,D7
            beq.b   .L7
            moveq   #5,D0
.L7:
            move.w  D0,($24,A1)
            move.w  #8,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            movea.l (A0),A0
            moveq   #$18,D0
            cmpi.w  #$20,D7
            beq.b   .L8
            moveq   #$F,D0
.L8:
            move.l  D0,(A0)
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$1A,A6)
            bra.w   .L15
.L9:
            clr.w   (-$2C,A6)
            clr.w   ($1E,A1)
            move.w  #1,($22,A1)
            move.w  D7,($24,A1)
            movea.l ($10,A6),A0
            suba.l  A4,A4
            btst    #1,D3
            beq.b   .L10
            movea.l ([-$26.w,A6]),A0
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            bra.w   .L17
.L10:
            tst.w   ($18,A6)
            beq.b   .L11
            cmpa.w  #0,A0
            bne.b   .L12
            clr.l   -(SP)
            move.w  ($18,A6),-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L13
.L11:
            movea.l ([-$26.w,A6]),A0
            movea.l (6,A0),A4
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
.L12:
            jsr     ([$1584.w])
            bne.w   .L24
.L13:
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            movea.l A4,A0
            tst.l   A0
            bne.b   .L14
            clr.l   -(SP)
            move.l  (-$12,A6),-(SP)
            jsr     FINDINVERSETABLE
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L14
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$1A,A6)
            move.l  (-$12,A6),-(SP)
            move.l  A0,-(SP)
            move.w  (-4,A6),-(SP)
            jsr     ([$16E4.w])
            move.w  QDErr,D0
            bne.w   .L24
            bra.b   .L15
.L14:
            jsr     ([$1584.w])
            bne.w   .L24
            move.l  A0,(-$1A,A6)
.L15:
            btst    #1,D3
            bne.b   .L17
            moveq   #$3E,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$16,A6)
            movea.l (A0),A0
            move.w  (-$2C,A6),(4,A0)
            move.l  (-$1A,A6),(6,A0)
            move.w  (-4,A6),($A,A0)
            move.w  #$4000,D0
            cmpi.w  #1,D7
            beq.b   .L16
            ori.w   #1,D0
.L16:
            move.w  D0,($14,A0)
            move.l  (-$E,A6),($16,A0)
            move.l  (-$36,A6),($22,A0)
            move.l  (-$32,A6),($26,A0)
            move.l  #$FFFFFFFF,($2A,A0)
            move.l  (-$16,A6),(-$26,A6)
.L17:
            move.l  TheGDevice,(-$2A,A6)
            move.l  (-$26,A6),TheGDevice
            move.l  (-$22,A6),-(SP)
            jsr     ([$1600.w])
            move.l  (-$2A,A6),TheGDevice
            btst    #1,D3
            beq.b   .L18
            movea.l (-$22,A6),A0
            movea.l (2,A0),A0
            _DisposHandle
            movea.l (-$E,A6),A0
            movea.l (-$22,A6),A1
            move.l  A0,(2,A1)
.L18:
            movea.l (-$22,A6),A1
            move.l  (-$3E,A6),($10,A1)
            move.l  (-$3A,A6),($14,A1)
            move.l  ($18,A1),-(SP)
            pea     ($10,A1)
            jsr     ([$117C.w])
            movea.l (-$22,A6),A0
            movea.l (8,A0),A0
            moveq   #$20,D0
            _SetHandleSize
            bne.b   .L24
            movea.l (-$22,A6),A0
            movea.l ([8.w,A0]),A0
            move.l  (-$26,A6),($1A,A0)
            moveq   #1,D0
            btst    #1,D3
            beq.b   .L19
            moveq   #0,D0
.L19:
            move.b  D0,($1E,A0)
            moveq   #0,D0
            btst    #2,D3
            beq.b   .L20
            moveq   #1,D0
.L20:
            move.b  D0,($1F,A0)
            movea.l (-$22,A6),A0
            ori.w   #1,(6,A0)
            movea.l ($1A,A6),A0
            move.l  (-$22,A6),(A0)
.L21:
            move.w  ($1E,A6),D0
            ext.l   D0
            move.w  D0,QDErr
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$16
.L22:
            move.w  #$FF63,($1E,A6)
            bra.b   .L25
.L23:
            move.w  #$FFCE,($1E,A6)
            bra.b   .L25
.L24:
            move.w  D0,($1E,A6)
            nop
.L25:
            movea.l (-$A,A6),A0
            _DisposHandle
            movea.l (-$E,A6),A0
            _DisposHandle
            movea.l (-$12,A6),A0
            _DisposHandle
            movea.l (-$16,A6),A0
            _DisposHandle
            movea.l (-$1A,A6),A0
            _DisposHandle
            move.l  (-$1E,A6),D7
            beq.b   .L21
            movea.l D7,A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            andi.w  #$C000,D0
            cmpi.w  #$C000,D0
            bne.w   .L26
            move.l  (A0),-(SP)
            jsr     ([$1608.w])
.L26:
            movea.l D7,A0
            _DisposHandle
            bra.b   .L21
SHIFTTABLE:
            dc.w    $FF00,$01FF,$02FF,$FFFF,$03FF,$FFFF,$FFFF,$FFFF
            dc.w    $04FF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.b    $05
            ds.b    5
FINDINVERSETABLE:
            movea.l ([4.w,SP]),A0
            move.l  (A0),D0
            movea.l DeviceList,A0
            tst.l   A0
            beq.b   .L2
.L1:
            movea.l (A0),A0
            movea.l (6,A0),A2
            movea.l (A2),A1
            cmp.l   (A1),D0
            beq.b   .L2
            movea.l ($1E,A0),A0
            tst.l   A0
            bne.b   .L1
            suba.l  A2,A2
.L2:
            move.l  A2,(8,SP)
            rtd     #4
            dc.w    0
GETGWORLD:
            movea.l (8,SP),A0
            movea.l (A5),A1
            move.l  (A1),(A0)
            movea.l (4,SP),A0
            move.l  TheGDevice,(A0)
            rtd     #8
            ds.b    12
SETGWORLD:
            movea.l (A5),A0
            move.l  (8,SP),(A0)
            movea.l (4,SP),A1
            movea.l (8,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            bne.b   .L1
            movea.l ([8.w,A0]),A0
            movea.l ($1A,A0),A1
.L1:
            tst.l   A1
            bne.b   .L2
            movea.l MainDevice,A1
.L2:
            move.l  A1,TheGDevice
            rtd     #8
            ds.b    10
DISPOSEGWORLD:
            movea.l (4,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            bne.b   .L5
            movea.l ([2.w,A0]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _DisposHandle
.L2:
            movea.l (4,SP),A0
            movea.l ([8.w,A0]),A0
            move.b  ($1E,A0),D0
            beq.b   .L4
            movea.l ($1A,A0),A0
            cmpa.l  TheGDevice,A0
            bne.b   .L3
            move.l  MainDevice,TheGDevice
.L3:
            move.l  A0,-(SP)
            jsr     ([$16C0.w])
.L4:
            move.l  (4,SP),-(SP)
            jsr     ([$1608.w])
            movea.l (4,SP),A0
            _RecoverHandle
            _DisposHandle
.L5:
            rtd     #4
            ds.b    4
GETGWORLDDEVICE:
            movea.l (4,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            beq.b   .L1
            move.l  TheGDevice,(8,SP)
            bra.b   .L2
.L1:
            movea.l ([8.w,A0]),A0
            move.l  ($1A,A0),(8,SP)
.L2:
            rtd     #4
            ds.b    6
UPDATEGWORLD:
            link.w  A6,#-$66
            movem.l D5-D7/A2-A4,-(SP)
            move.l  SP,(-$40,A6)
            clr.l   ($1E,A6)
            clr.l   (-$18,A6)
            move.l  (8,A6),D0
            andi.l  #$8FFFFFFF,D0
            tst.l   D0
            bne.w   .L67
            move.l  (8,A6),D0
            andi.l  #$30000000,D0
            cmpi.l  #$30000000,D0
            beq.w   .L67
            move.l  (8,A6),D0
            btst    #$1E,D0
            beq.w   .L1
            andi.l  #$30000000,D0
            beq.w   .L67
.L1:
            movea.l ([$1A.w,A6]),A3
            pea     (-$24,A6)
            pea     (-$28,A6)
            moveq   #5,D0
            jsr     ([$1A74.w])
            move.l  ($C,A6),D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            movea.l ([$16.w,A0]),A0
            move.w  ($20,A0),($18,A6)
            move.l  ($2A,A0),($10,A6)
.L2:
            movea.l ($14,A6),A0
            move.w  ($18,A6),D7
            blt.w   .L64
            beq.b   .L3
            cmpi.w  #$20,D7
            bgt.w   .L64
            bra.b   .L4
.L3:
            clr.l   (-$30,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-$2C,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-$2A,A6)
            clr.l   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$44,A6)
            movea.l (A0),A1
            movea.l ([$16.w,A1]),A0
            move.w  ($20,A0),(-$32,A6)
            movea.l ([$2A.w,A0]),A0
            move.l  (A0),(-$36,A6)
            movea.l ($14,A6),A0
            move.w  (2,A0),D0
            sub.w   ($24,A1),D0
            move.w  D0,(-$38,A6)
            bra.b   .L8
.L4:
            move.l  (A0),(-$30,A6)
            move.l  (4,A0),(-$2C,A6)
            clr.w   (-$38,A6)
            move.w  ($18,A6),(-$32,A6)
            move.l  ($10,A6),D0
            beq.b   .L5
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$36,A6)
            bra.b   .L8
.L5:
            move.w  ($18,A6),D0
            cmpi.w  #$10,D0
            bne.b   .L6
            move.w  #$F,D0
            bra.b   .L7
.L6:
            cmpi.w  #$20,D0
            bne.b   .L7
            move.w  #$18,D0
.L7:
            ext.l   D0
            move.l  D0,(-$36,A6)
.L8:
            move.w  (-$32,A6),D7
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D7
            bmi.w   .L64
            move.w  (-$38,A6),D0
            lsl.w   D7,D0
            andi.w  #$1F,D0
            lsr.w   D7,D0
            move.w  D0,(-$38,A6)
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D0
            andi.w  #$7FFF,D0
            move.w  D0,(-$3A,A6)
            clr.b   (-$1E,A6)
            move.l  ($10,A3),D0
            cmp.l   (-$30,A6),D0
            bne.b   .L9
            move.l  ($14,A3),D0
            cmp.l   (-$2C,A6),D0
            bne.b   .L9
            move.b  #1,(-$1E,A6)
            bra.w   .L13
.L9:
            move.w  ($16,A3),D0
            sub.w   ($12,A3),D0
            move.w  (-$2A,A6),D1
            sub.w   (-$2E,A6),D1
            cmp.w   D0,D1
            bne.b   .L10
            move.w  ($14,A3),D0
            sub.w   ($10,A3),D0
            move.w  (-$2C,A6),D1
            sub.w   (-$30,A6),D1
            cmp.w   D0,D1
            beq.b   .L13
.L10:
            move.w  (-$2A,A6),D0
            sub.w   (-$2E,A6),D0
            ext.l   D0
            lsl.l   D7,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-$3A,A6)
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D1
            andi.w  #$7FFF,D1
            move.w  D1,(-$3C,A6)
            cmp.w   D1,D0
            beq.b   .L11
            ori.l   #$80000,($1E,A6)
.L11:
            move.l  (8,A6),D0
            andi.l  #$10000000,D0
            bne.b   .L12
            move.l  #$20000000,D0
.L12:
            move.l  D0,($1E,A6)
.L13:
            movea.l ([2.w,A3]),A0
            move.w  (8,A0),D0
            move.w  (-$38,A6),D1
            neg.w   D1
            cmp.w   D1,D0
            beq.b   .L14
            ori.l   #$40000,($1E,A6)
.L14:
            clr.w   (-$20,A6)
            movea.l ([2.w,A3]),A0
            move.w  ($20,A0),D0
            cmp.w   (-$32,A6),D0
            beq.b   .L15
            ori.l   #$20000,($1E,A6)
            move.l  (8,A6),D0
            andi.l  #$40000000,D0
            beq.b   .L15
            move.w  #$40,(-$20,A6)
            ori.l   #$40000000,($1E,A6)
.L15:
            movea.l ([$2A.w,A0]),A0
            move.l  (A0),D0
            cmp.l   (-$36,A6),D0
            beq.b   .L16
            ori.l   #$10000,($1E,A6)
.L16:
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$D,D0
            jsr     ([$1A74.w])
            move.l  (SP)+,D0
            move.l  D0,(-$1C,A6)
            move.l  (2,A3),-(SP)
            moveq   #$C,D0
            jsr     ([$1A74.w])
            clr.b   (-$1D,A6)
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            move.l  (SP)+,D0
            bne.b   .L17
            ori.l   #1,(-$18,A6)
            ori.l   #$100000,($1E,A6)
            move.b  #1,(-$1D,A6)
            move.l  #$40,(-$1C,A6)
            bra.b   .L18
.L17:
            move.l  (-$1C,A6),D0
            btst    #6,D0
            beq.b   .L18
            ori.l   #1,(-$18,A6)
.L18:
            movea.l ([8.w,A3]),A0
            move.b  ($1E,A0),D0
            bne.b   .L19
            ori.l   #2,(-$18,A6)
.L19:
            tst.b   ($1F,A0)
            beq.b   .L20
            ori.l   #4,(-$18,A6)
.L20:
            move.l  ($1E,A6),D0
            beq.b   .L22
            cmpi.l  #$100000,D0
            beq.b   .L23
            tst.l   (8,A6)
            beq.w   .L41
            cmpi.l  #$10000,D0
            bne.b   .L21
            tst.b   (-$1E,A6)
            beq.b   .L21
            cmpi.w  #4,D7
            blt.w   .L29
.L21:
            cmpi.l  #$40000,D0
            beq.b   .L24
            bra.w   .L41
.L22:
            move.l  A3,(-4,A6)
            bra.w   .L57
.L23:
            move.w  (-$2C,A6),D0
            sub.w   (-$30,A6),D0
            mulu.w  (-$3A,A6),D0
            movea.l ([2.w,A3]),A1
            movea.l (A1),A0
            _ReallocHandle
            bne.w   .L63
            _MoveHHi
            move.l  A3,(-4,A6)
            bra.w   .L57
.L24:
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            movea.l (SP)+,A1
            move.w  (-$2C,A6),D0
            sub.w   (-$30,A6),D0
            move.w  (-$3A,A6),D1
            mulu.w  D1,D0
            movea.l A1,A4
            adda.l  D0,A4
            movea.l ([2.w,A3]),A0
            move.w  (8,A0),D6
            neg.w   D6
            sub.w   (-$38,A6),D6
            ext.l   D6
            lsl.l   D7,D6
            blt.b   .L26
.L25:
            bfextu  (A1){D6:0},D0
            move.l  D0,(A1)+
            cmpa.l  A4,A1
            blt.b   .L25
            bra.b   .L28
.L26:
            subi.l  #$20,D6
.L27:
            bfextu  (A4){D6:0},D0
            move.l  D0,-(A4)
            cmpa.l  A4,A1
            blt.b   .L27
.L28:
            movea.l ([2.w,A3]),A0
            move.w  (-$30,A6),(6,A0)
            move.w  (-$2E,A6),D0
            sub.w   (-$38,A6),D0
            move.w  D0,(8,A0)
            move.l  (-$2C,A6),($A,A0)
            move.l  (-$30,A6),($10,A3)
            move.l  (-$2C,A6),($14,A3)
            move.l  ($18,A3),-(SP)
            pea     ($10,A3)
            jsr     ([$117C.w])
            move.l  A3,(-4,A6)
            movea.l ([8.w,A3]),A1
            move.b  ($1E,A1),D0
            beq.w   .L57
            movea.l ([$1A.w,A1]),A1
            move.l  (6,A0),($22,A1)
            move.l  ($A,A0),($26,A1)
            movea.l ([$16.w,A1]),A1
            move.l  (6,A0),(6,A1)
            move.l  ($A,A0),($A,A1)
            bra.w   .L57
.L29:
            move.l  TheGDevice,(-$28,A6)
            move.l  A3,(-4,A6)
            movea.l ([8.w,A3]),A4
            move.l  A3,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$D,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$E,D0
            _PaletteDispatch
            move.l  (-$18,A6),D0
            andi.l  #2,D0
            beq.b   .L31
            move.l  ($C,A6),TheGDevice
            move.l  ([2.w,A3]),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            movea.l ($1A,A4),A0
            movea.l (-$28,A6),A1
            cmpa.l  A0,A1
            bne.b   .L30
            move.l  ($C,A6),(-$28,A6)
.L30:
            move.l  A0,-(SP)
            jsr     ([$16C0.w])
            movea.l ($C,A6),A0
            move.l  A0,($1A,A4)
            movea.l (A0),A0
            movea.l ([$16.w,A0]),A0
            movea.l ([2.w,A3]),A1
            move.l  ($2A,A0),($2A,A1)
            move.l  (-$28,A6),TheGDevice
            bra.w   .L37
.L31:
            movea.l ([$1A.w,A4]),A0
            move.w  ($A,A0),(-$4E,A6)
            movea.l ($10,A6),A0
            clr.l   (-$4C,A6)
            tst.w   ($18,A6)
            beq.b   .L32
            cmpa.w  #0,A0
            bne.b   .L33
            clr.l   -(SP)
            move.w  ($18,A6),-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            tst.l   A0
            beq.w   .L65
            bra.b   .L34
.L32:
            movea.l ([-$44.w,A6]),A0
            move.l  (6,A0),(-$4C,A6)
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
.L33:
            jsr     ([$1584.w])
            bne.w   .L63
.L34:
            move.l  A0,(-$48,A6)
            movea.l (-$4C,A6),A0
            tst.l   A0
            bne.b   .L35
            clr.l   -(SP)
            move.l  (-$48,A6),-(SP)
            jsr     FINDINVERSETABLE
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L35
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L63
            move.l  A0,(-$4C,A6)
            move.l  (-$48,A6),-(SP)
            move.l  A0,-(SP)
            move.w  (-$4E,A6),-(SP)
            jsr     ([$16E4.w])
            move.w  QDErr,D0
            bne.w   .L68
            bra.b   .L36
.L35:
            jsr     ([$1584.w])
            bne.w   .L63
            move.l  A0,(-$4C,A6)
.L36:
            movea.l ([8.w,A3]),A4
            movea.l ([$1A.w,A4]),A0
            movea.l (6,A0),A0
            _DisposHandle
            movea.l ([$1A.w,A4]),A0
            move.l  (-$4C,A6),(6,A0)
            movea.l ([$16.w,A0]),A0
            move.l  (-$48,A6),($2A,A0)
            move.l  ($1A,A4),TheGDevice
            move.l  ([2.w,A3]),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.l  (-$28,A6),TheGDevice
            movea.l ([2.w,A3]),A4
            movea.l ($2A,A4),A0
            _DisposHandle
            move.l  (-$48,A6),($2A,A4)
.L37:
            moveq   #1,D0
            move.w  (-$32,A6),D7
            lsl.w   D7,D0
            moveq   #0,D1
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.l  D1,A0
.L38:
            cmp.l   -(A0),D0
            dbne    D0,.L38
            beq.w   .L57
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            movea.l (SP)+,A1
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D1
            andi.w  #$7FFF,D1
            move.w  ($A,A0),D0
            sub.w   (6,A0),D0
            mulu.w  D1,D0
            movea.l A1,A4
            adda.l  D0,A4
            moveq   #0,D6
            moveq   #$1F,D1
.L39:
            move.l  (A1),D5
.L40:
            bfextu  D5{D6:D7},D0
            move.l  (0,SP,D0.w*4),D0
            bfins   D0,D5{D6:D7}
            add.w   D7,D6
            and.w   D1,D6
            bne.b   .L40
            move.l  D5,(A1)+
            cmpa.l  A4,A1
            blt.b   .L39
            pea     (-$5A,A6)
            moveq   #$F,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$10,D0
            _PaletteDispatch
            bra.w   .L57
.L41:
            move.l  (8,A6),D0
            bne.b   .L42
            andi.l  #$100000,($1E,A6)
.L42:
            move.l  (-$18,A6),D0
            andi.l  #2,D0
            bne.b   .L43
            clr.l   ($C,A6)
.L43:
            clr.l   (-$52,A6)
            tst.b   (-$1D,A6)
            bne.b   .L44
            move.l  (8,A6),D0
            bne.b   .L45
.L44:
            movea.l (2,A3),A4
            move.l  A4,-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
            movea.l (A4),A1
            movea.l (A1),A4
            clr.l   (A1)
            movea.l A4,A0
            _GetHandleSize
            move.l  D0,(-$52,A6)
            movea.l A4,A0
            _DisposHandle
.L45:
            clr.w   -(SP)
            pea     (-4,A6)
            move.w  ($18,A6),-(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (-$18,A6),-(SP)
            moveq   #0,D0
            jsr     ([$1A74.w])
            move.w  (SP)+,D0
            bne.w   .L69
            movea.l (-4,A6),A4
            move.w  ($C,A3),($C,A4)
            move.w  ($E,A3),($E,A4)
            move.l  ($1C,A3),-(SP)
            move.l  ($1C,A4),-(SP)
            jsr     ([$1170.w])
            move.l  (8,A6),D0
            andi.l  #$10000000,D0
            bne.w   .L46
            move.l  ($1C,A4),-(SP)
            pea     ($10,A3)
            pea     ($10,A4)
            jsr     ([$11EC.w])
            bra.w   .L47
.L46:
            move.l  ($1C,A4),-(SP)
            move.w  ($12,A4),D0
            sub.w   ($12,A3),D0
            move.w  D0,-(SP)
            move.w  ($10,A4),D0
            sub.w   ($10,A3),D0
            move.w  D0,-(SP)
            jsr     ([$1180.w])
.L47:
            move.l  ($20,A3),D0
            beq.w   .L48
            move.l  D0,-(SP)
            move.l  ($20,A4),-(SP)
            jsr     ([$1624.w])
.L48:
            move.l  ($24,A3),($24,A4)
            move.l  ($28,A3),($28,A4)
            move.l  ($2C,A3),($2C,A4)
            move.l  ($30,A3),($30,A4)
            move.l  ($34,A3),($34,A4)
            move.w  ($38,A3),($38,A4)
            move.l  ($3A,A3),D0
            beq.w   .L49
            move.l  D0,-(SP)
            move.l  ($3A,A4),-(SP)
            jsr     ([$1624.w])
.L49:
            move.l  ($3E,A3),D0
            beq.w   .L50
            move.l  D0,-(SP)
            move.l  ($3E,A4),-(SP)
            jsr     ([$1624.w])
.L50:
            lea     ($42,A3),A0
            lea     ($42,A4),A1
            moveq   #$14,D0
.L51:
            move.w  (A0)+,(A1)+
            dbra    D0,.L51
            movea.l ([2.w,A3]),A0
            movea.l ([2.w,A4]),A1
            move.w  ($10,A0),($10,A1)
            move.l  ($12,A0),($12,A1)
            move.l  ($16,A0),($16,A1)
            move.l  ($1A,A0),($1A,A1)
            movea.l ([8.w,A3]),A0
            movea.l ([8.w,A4]),A1
            moveq   #$C,D0
.L52:
            move.w  (A0)+,(A1)+
            dbra    D0,.L52
            move.l  ($68,A3),($68,A4)
            movea.l ([8.w,A3]),A0
            movea.l ([$1A.w,A0]),A0
            movea.l ([8.w,A4]),A1
            movea.l ([$1A.w,A1]),A1
            move.l  ($C,A0),($C,A1)
            move.l  ($10,A0),($10,A1)
            move.l  ($1A,A0),($1A,A1)
            movea.l ([$16.w,A0]),A0
            movea.l ([$16.w,A1]),A1
            move.w  ($10,A0),($10,A1)
            move.l  ($12,A0),($12,A1)
            move.l  ($16,A0),($16,A1)
            move.l  ($1A,A0),($1A,A1)
            move.l  A3,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$D,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$E,D0
            _PaletteDispatch
            move.l  A4,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$F,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$10,D0
            _PaletteDispatch
            tst.b   (-$1D,A6)
            bne.w   .L56
            move.l  (8,A6),D0
            beq.w   .L56
            clr.b   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
            clr.b   -(SP)
            movea.l (-4,A6),A0
            move.l  (2,A0),-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
            beq.w   .L66
            move.l  (-4,A6),-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP),(-$66,A6)
            jsr     ([$FE8.w])
            movea.l (-4,A6),A0
            pea     ($10,A0)
            jsr     ([$FEC.w])
            move.l  ([2.w,A3]),-(SP)
            movea.l (-4,A6),A1
            move.l  ([2.w,A1]),-(SP)
            lea     ($10,A3),A0
            lea     ($10,A1),A1
            move.l  (8,A6),D0
            btst    #$1D,D0
            bne.b   .L55
            move.l  (A0),(-$C,A6)
            move.l  (A1),(-$14,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (4,A1),D1
            sub.w   (A1),D1
            cmp.w   D0,D1
            blt.b   .L53
            move.w  D0,D1
.L53:
            move.w  (A0),D0
            add.w   D1,D0
            move.w  D0,(-8,A6)
            move.w  (A1),D0
            add.w   D1,D0
            move.w  D0,(-$10,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  (6,A1),D1
            sub.w   (2,A1),D1
            cmp.w   D0,D1
            blt.b   .L54
            move.w  D0,D1
.L54:
            move.w  (2,A0),D0
            add.w   D1,D0
            move.w  D0,(-6,A6)
            move.w  (2,A1),D0
            add.w   D1,D0
            move.w  D0,(-$E,A6)
            lea     (-$C,A6),A0
            lea     (-$14,A6),A1
.L55:
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            move.w  (-$20,A6),-(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  (-$66,A6),-(SP)
            jsr     ([$FE4.w])
            move.l  (-$66,A6),-(SP)
            jsr     ([$1164.w])
            movea.l (-4,A6),A0
            move.l  (2,A0),-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
.L56:
            move.l  A3,-(SP)
            moveq   #4,D0
            jsr     ([$1A74.w])
.L57:
            movea.l (-4,A6),A3
.L58:
            move.l  (2,A3),-(SP)
            move.l  (-$1C,A6),-(SP)
            moveq   #$E,D0
            jsr     ([$1A74.w])
            movea.l ($1A,A6),A0
            movea.l (A0),A0
            cmpa.l  (-$24,A6),A0
            bne.b   .L59
            move.l  A3,(-$24,A6)
.L59:
            movea.l ([8.w,A0]),A0
            movea.l ($1A,A0),A0
            cmpa.l  (-$28,A6),A0
            bne.b   .L60
            movea.l ([8.w,A3]),A0
            move.l  ($1A,A0),(-$28,A6)
.L60:
            move.l  (-$24,A6),-(SP)
            move.l  (-$28,A6),-(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            movea.l ($1A,A6),A0
            move.l  A3,(A0)
.L61:
            clr.w   QDErr
            move.l  ($1E,A6),D0
            bpl.b   .L62
            move.w  D0,QDErr
.L62:
            movea.l (-$40,A6),SP
            movem.l (SP)+,D5-D7/A2-A4
            unlk    A6
            rtd     #$16
.L63:
            ext.l   D0
            move.l  D0,($1E,A6)
            bra.b   .L58
.L64:
            move.l  #$FFFFFF63,($1E,A6)
            bra.b   .L61
.L65:
            move.w  QDErr,D0
            bne.b   .L63
            move.w  MemErr,D0
            bne.b   .L63
            clr.w   -(SP)
            jsr     ([$14BC.w])
            move.w  (SP)+,D0
            bra.w   .L58
.L66:
            move.l  #$FFFFFF68,($1E,A6)
            bra.w   .L58
.L67:
            move.l  #$FFFFFFCE,($1E,A6)
            bra.b   .L61
.L68:
            ext.l   D0
            move.l  D0,($1E,A6)
            movea.l (-$48,A6),A0
            _DisposHandle
            movea.l (-$4C,A6),A0
            _DisposHandle
            bra.w   .L58
.L69:
            move.l  (-$52,A6),D1
            beq.b   .L63
            move.w  D0,D7
            move.l  D1,D0
            movea.l ([8.w,A3]),A0
            tst.b   ($1F,A0)
            beq.b   .L70
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L71
            move.w  D7,D0
            bra.b   .L63
.L70:
            _NewHandle
            bne.b   .L63
.L71:
            movea.l ([2.w,A3]),A1
            move.l  A0,(A1)
            move.w  D7,D0
            bra.w   .L63
QDDONE:
            move.b  #1,(8,SP)
            rtd     #4
            ds.b    6
LOCKPIXELS:
            move.b  #1,(8,SP)
            movea.l ([4.w,SP]),A1
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            bne.b   .L2
            movea.l (A1),A0
            move.l  (A0),D0
            jsr     ([$644.w])
            tst.l   D0
            bne.b   .L1
            clr.b   (8,SP)
            bra.b   .L2
.L1:
            move.l  D0,(A1)
            move.w  #1,($E,A1)
            _HLock
.L2:
            rtd     #4
            ds.b    8
UNLOCKPIXELS:
            movea.l ([4.w,SP]),A1
            move.w  ($E,A1),D0
            cmpi.w  #1,D0
            bne.b   .L1
            movea.l (A1),A0
            _RecoverHandle
            _HUnlock
            movea.l ([4.w,SP]),A1
            move.l  A0,(A1)
            move.w  #2,($E,A1)
.L1:
            rtd     #4
            ds.b    8
PORTCHANGED:
            dc.w    $4E74,$0004
            ds.b    12
PIXPATCHANGED:
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.w  #$FFFF,($E,A0)
            rtd     #4
CTABCHANGED:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,D0
            movea.l ([4.w,SP]),A0
            move.l  D0,(A0)
            rtd     #4
            ds.b    10
GDEVICECHANGED:
            dc.w    $4E74,$0004
            ds.b    12
ALLOWPURGEPIXELS:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HPurge
.L2:
            rtd     #4
NOPURGEPIXELS:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HNoPurge
.L2:
            rtd     #4
GETPIXELSSTATE:
            clr.l   (8,SP)
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HGetState
            move.l  D0,(8,SP)
.L2:
            rtd     #4
            ds.b    8
SETPIXELSSTATE:
            move.l  (4,SP),D0
            btst    #6,D0
            bne.b   .L1
            move.l  (8,SP),-(SP)
            moveq   #$C,D0
            jsr     ([$1A74.w])
            bra.w   .L2
.L1:
            move.l  (8,SP),-(SP)
            moveq   #$B,D0
            jsr     ([$1A74.w])
.L2:
            move.l  (4,SP),D0
            btst    #7,D0
            bne.b   .L3
            move.l  (8,SP),-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
            bra.b   .L4
.L3:
            movea.l (8,SP),A0
            clr.b   -(SP)
            move.l  A0,-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
.L4:
            rtd     #8
            ds.b    12
GETPIXBASEADDR:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.l  A0,(8,SP)
            move.w  ($E,A1),D0
            beq.b   .L3
            btst    #1,D0
            beq.b   .L2
            move.l  (A0),D0
.L1:
            jsr     ([$644.w])
            move.l  D0,(8,SP)
.L2:
            rtd     #4
.L3:
            move.l  A0,D0
            movea.l DeviceList,A1
.L4:
            movea.l (A1),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            cmp.l   (A0),D0
            beq.b   .L2
            movea.l (A1),A0
            move.l  ($1E,A0),D1
            movea.l D1,A1
            bne.b   .L4
            bra.b   .L1
            ds.b    10
NEWSCREENBUFFER:
            clr.b   D0
            bra.b   NewTempScreenBuffer.L1
NewTempScreenBuffer:
            move.b  #1,D0
.L1:
            link.w  A6,#-$2A
            movem.l D3-D7/A2-A4,-(SP)
            move.b  D0,(-$2A,A6)
            clr.w   ($16,A6)
            clr.l   (-8,A6)
            clr.l   (-$C,A6)
            clr.b   -(SP)
            move.l  ($12,A6),-(SP)
            jsr     ([$10B8.w])
            move.b  (SP)+,D0
            bne.w   .L10
            clr.l   -(SP)
            move.l  ($12,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$10,A6)
            movea.l (A0),A0
            movea.l ($12,A6),A1
            move.w  (2,A1),D0
            sub.w   ($24,A0),D0
            move.w  D0,(-$18,A6)
            move.w  (6,A1),D0
            sub.w   (2,A1),D0
            move.w  D0,(-$22,A6)
            move.w  (4,A1),D0
            sub.w   (A1),D0
            move.w  D0,(-$24,A6)
            clr.l   (-$28,A6)
            movea.l ([-$10.w,A6]),A0
            movea.l ([$16.w,A0]),A1
            move.w  ($20,A1),D7
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D0
            bmi.w   .L9
            move.w  D0,(-2,A6)
            move.w  (-$28,A6),(-$20,A6)
            move.w  (-$18,A6),D1
            lsl.w   D0,D1
            andi.w  #$1F,D1
            lsr.w   D0,D1
            move.w  (-$26,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$1E,A6)
            move.l  (-$24,A6),(-$1C,A6)
            move.w  (-$22,A6),D0
            sub.w   (-$26,A6),D0
            ext.l   D0
            move.w  (-2,A6),D1
            lsl.l   D1,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-4,A6)
            move.w  (-$24,A6),D1
            sub.w   (-$28,A6),D1
            mulu.w  D1,D0
            tst.b   (-$2A,A6)
            beq.b   .L2
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L3
            move.w  #$FF69,D0
            bra.w   .L11
.L2:
            _NewHandle
            bne.w   .L11
.L3:
            move.l  A0,(-8,A6)
            _MoveHHi
            tst.b   ($10,A6)
            beq.b   .L4
            _HPurge
.L4:
            moveq   #$32,D0
            _NewHandleClear
            bne.w   .L11
            move.l  A0,(-$C,A6)
            movea.l (A0),A1
            move.l  (-8,A6),(A1)
            move.w  (-4,A6),D0
            ori.w   #$8000,D0
            move.w  D0,(4,A1)
            move.l  (-$20,A6),(6,A1)
            move.l  (-$1C,A6),($A,A1)
            move.w  #2,($E,A1)
            move.w  #$48,($16,A1)
            move.w  #$48,($1A,A1)
            move.w  D7,($20,A1)
            cmpi.w  #$10,D7
            blt.b   .L6
            move.w  #$10,($1E,A1)
            move.w  #3,($22,A1)
            moveq   #8,D0
            cmpi.w  #$20,D7
            beq.b   .L5
            moveq   #5,D0
.L5:
            move.w  D0,($24,A1)
            bra.b   .L7
.L6:
            clr.w   ($1E,A1)
            move.w  #1,($22,A1)
            move.w  D7,($24,A1)
.L7:
            movea.l ([-$10.w,A6]),A0
            movea.l ([$16.w,A0]),A0
            move.l  ($2A,A0),($2A,A1)
            movea.l (8,A6),A0
            move.l  (-$C,A6),(A0)
            movea.l ($C,A6),A0
            move.l  (-$10,A6),(A0)
.L8:
            move.w  ($16,A6),D0
            ext.l   D0
            move.w  D0,QDErr
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$E
.L9:
            move.w  #$FF63,($16,A6)
            bra.b   .L12
.L10:
            move.w  #$FFCE,($16,A6)
            bra.b   .L12
.L11:
            move.w  D0,($16,A6)
            bra.b   .L12
            move.w  QDErr,($16,A6)
            nop
.L12:
            move.l  (-8,A6),D0
            _DisposHandle
            move.l  (-$C,A6),D0
            _DisposHandle
            bra.b   .L8
            ds.b    4
DISPOSESCREENBUFFER:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _DisposHandle
            movea.l (4,SP),A0
            _DisposHandle
.L2:
            rtd     #4
            ds.b    10
OFFSCREENVERSION:
            move.l  #$101,(4,SP)
            rts
            ds.b    6
QDEXTEND:
