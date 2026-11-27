XPALETTES:
SYSCOLORS:
            dc.w    0,$0003,0,$000F,0,$FFFF,$FFFF,$FFFF
            dc.w    $0001
            ds.b    6
SYSCOLOREND:
            ds.b    8
UPDATEPALETTE:
            link.w  A6,#-$74
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #1,D3
            clr.l   (-4,A6)
            movea.l ($DC8).w,A2
            movea.l (8,A6),A3
            bra.b   ACTIVATEPALETTE.L2
ACTIVATEPALETTE:
            link.w  A6,#-$74
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #1,D3
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.w   .L16
            movea.l (A2),A0
            move.w  (A0),D0
            beq.w   .L16
            movea.l (8,A6),A3
            cmpa.w  #0,A3
            beq.w   .L16
            move.l  A3,(-4,A6)
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l (8,A3),A0
            movea.l (A0),A0
            movea.l ($C,A0),A3
            cmpa.w  #0,A3
            bne.b   .L2
.L1:
            movea.l ($DCC).w,A3
            move.l  A3,D0
            bne.b   .L2
            movea.l (A2),A0
            movea.l ($C,A0),A3
            move.l  A3,D0
            beq.w   .L16
.L2:
            movea.l A2,A0
            _HLock
            movea.l A3,A0
            move.l  A3,(-8,A6)
            _HLock
            movea.l (A2),A4
            move.l  A4,(-$12,A6)
            movea.l (4,A4),A0
            _HLock
            move.l  (A0),(-$1A,A6)
            move.w  (A4),(-$22,A6)
            lea     ($38,A4),A0
            move.l  A0,(-$16,A6)
            move.l  TheGDevice,(-$44,A6)
            clr.l   (-$3C,A6)
            movea.l (A3),A4
            move.l  A4,(-$C,A6)
            move.w  (A4),D4
            move.w  D4,(-$E,A6)
            clr.w   (-$48,A6)
            clr.w   (-$4A,A6)
            jsr     CALCDEVS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            tst.l   (-$30,A6)
            beq.w   .L10
            lea     ($10,A4),A4
            move.w  (-$E,A6),D4
            bra.b   .L7
.L3:
            move.w  (6,A4),D1
            btst    #2,D1
            beq.b   .L4
            addq.w  #1,(-$48,A6)
            bra.b   .L6
.L4:
            btst    #1,D1
            beq.b   .L5
            move.l  (A4),D0
            move.b  (4,A4),D0
            tst.l   D0
            beq.b   .L5
            addq.l  #1,D0
            beq.b   .L5
            addq.w  #1,(-$4A,A6)
            bra.b   .L6
.L5:
            bset    #$F,(6,A4)
.L6:
            lea     ($10,A4),A4
.L7:
            dbra    D4,.L3
            move.w  (-$48,A6),D0
            or.w    (-$4A,A6),D0
            beq.w   .L10
            move.l  #$200,D0
            _NewHandleClear
            bne.w   .L12
            move.l  A0,(-$3C,A6)
            _HLock
            movea.l (A0),A0
            move.l  A0,(-$40,A6)
            moveq   #0,D4
.L8:
            move.l  (-$30,A6),D0
            btst    D4,D0
            beq.b   .L9
            move.w  (-$48,A6),(-$4C,A6)
            move.w  (-$4A,A6),(-$4E,A6)
            move.w  D4,(-$1C,A6)
            jsr     SETDEV
            beq.b   .L9
            addq.w  #1,D3
.L9:
            addq.w  #1,D4
            cmp.w   (-$22,A6),D4
            bmi.b   .L8
            move.l  (-$44,A6),TheGDevice
.L10:
            movea.l (-$12,A6),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            movea.l (-$C,A6),A1
            move.w  (6,A1),D0
            andi.w  #$FFF,D0
            move.w  (4,A0,D0.w*8),D0
            beq.b   .L11
            movea.l (-$12,A6),A0
            move.l  (8,A1),D0
            move.l  (-$2C,A6),D1
            not.l   D1
            and.l   D1,D0
            beq.b   .L11
            jsr     UNRESERVEDEVICES
.L11:
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            jsr     UPDATEDEVICES
            move.l  (-$2C,A6),(8,A1)
            subq.w  #1,D3
.L12:
            movea.l (-$12,A6),A0
            movea.l (4,A0),A0
            _HUnlock
            movea.l A2,A0
            _HUnlock
            movea.l (-$C,A6),A0
            bclr    #$D,(6,A0)
            move.w  (A0),D0
            lea     ($10,A0),A0
            bra.b   .L14
.L13:
            move.w  (6,A0),D1
            andi.w  #$3F0F,D1
            move.w  D1,(6,A0)
            adda.w  #$10,A0
.L14:
            dbra    D0,.L13
            movea.l A3,A0
            _HUnlock
            movea.l (-$3C,A6),A0
            cmpa.w  #0,A0
            beq.b   .L15
            _DisposHandle
.L15:
            moveq   #0,D3
.L16:
            move.l  D3,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #4
            ds.b    12
Allocate:
            movem.l D3-D4/A2-A3,-(SP)
            tst.w   (-$4C,A6)
            beq.w   .L7
            movea.l (-$C,A6),A3
            moveq   #0,D4
            moveq   #0,D2
            moveq   #0,D3
            lea     ($10,A3),A2
            bra.b   .L6
.L1:
            move.w  ($A,A2),D0
            bmi.b   .L5
            btst    #2,D0
            beq.b   .L5
            btst    #3,($B,A2)
            beq.b   .L2
            move.w  D4,D3
            and.w   (-$46,A6),D3
            beq.b   .L5
            cmp.w   (-$46,A6),D3
            beq.b   .L5
            bftst   (-$74,A6){D3:1}
            bne.b   .L5
            bfset   (-$74,A6){D3:1}
            clr.w   -(SP)
            move.w  ($C,A2),-(SP)
            jsr     FINDLINK
            move.w  (SP)+,D2
            bne.b   .L4
            move.w  D3,-(SP)
            jsr     PILLAGE
            move.w  D3,D2
            bra.b   .L3
.L2:
            clr.w   -(SP)
            move.w  ($C,A2),-(SP)
            jsr     FINDLINK
            move.w  (SP)+,D2
            bne.b   .L4
            subq.w  #2,SP
            bsr.w   GIMMEINDEX
            move.w  (SP)+,D2
            beq.b   .L5
.L3:
            move.w  D2,-(SP)
            jsr     PILLAGE
            move.w  D4,D0
            movea.l A2,A0
            bsr.w   CLAIMINDEX
.L4:
            bset    #$F,($A,A2)
.L5:
            adda.w  #$10,A2
            addq.w  #1,D4
.L6:
            cmp.w   (A3),D4
            blt.b   .L1
.L7:
            movem.l (SP)+,D3-D4/A2-A3
            rts
CHECKALLDEVICECLUTS:
            movem.l D3-D4/A0-A3,-(SP)
            movea.l ($DC8).w,A2
            movea.l A2,A0
            _HLock
            movea.l (A2),A3
            move.w  (A3),D3
            subq.w  #1,D3
            moveq   #0,D4
.L1:
            subq.w  #2,SP
            move.l  ($38,A3,D3.w*8),-(SP)
            jsr     CHECKDEVICECOLORS
            tst.w   (SP)+
            beq.b   .L2
            bset    D3,D4
.L2:
            dbra    D3,.L1
            or.l    D4,($10,A3)
            movea.l A2,A0
            _HUnlock
            movem.l (SP)+,D3-D4/A0-A3
            rts
            ds.b    10
CHECKFORJUGGLER:
            move.l  A0,-(SP)
            move.w  #$A88F,D0
            _GetTrapAddress
            move.l  A0,-(SP)
            move.w  #$A89F,D0
            _GetTrapAddress
            cmpa.l  (SP)+,A0
            seq     D0
            extb.l  D0
            movea.l (SP)+,A0
            rts
            ds.b    6
PMGREXIT:
            cmpi.l  #$FFFFFFFF,($DC8).w
            beq.b   .L1
            clr.l   ($DCC).w
            jsr     DISPOSEAPPPALETTES
            jsr     CHECKALLDEVICECLUTS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            bsr.b   CHECKFORJUGGLER
            bne.b   .L1
            jsr     UPDATEDEVICES
            move.l  MainDevice,TheGDevice
.L1:
            rts
            ds.b    4
INSTALLMYEXITTOSHELL:
            jsr     CHECKFORJUGGLER
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            lea     ($18,A0),A0
            or.l    (A0),D0
            bne.b   .L1
            move.l  ($15D0).w,(A0)
            lea     MYEXITTOSHELL,A0
            move.l  A0,($15D0).w
.L1:
            rts
MYEXITTOSHELL:
            moveq   #$C,D0
            _PaletteDispatch
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($18,A0),A0
            jmp     (A0)
RECORDPALETTE:
            link.w  A6,#0
            movem.l D3/A2-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.w   .L8
            movea.l (A2),A0
            movea.l (4,A0),A3
            moveq   #0,D0
            move.w  (2,A0),D0
            _NewHandleClear
            bne.w   .L8
            movea.l (A4),A1
            move.l  A0,($C,A1)
            movea.l (A2),A1
            move.w  ($A,A1),D0
            bne.b   .L3
            moveq   #0,D3
            move.w  (8,A1),D3
            move.l  D3,D0
            addi.w  #$10,D0
            bmi.b   .L8
            lsl.l   #3,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L8
            movea.l A3,A0
            movea.l (A0),A0
            lea     (0,A0,D3.w*8),A0
            moveq   #$10,D0
            bra.b   .L2
.L1:
            clr.l   (A0)+
            clr.l   (A0)+
.L2:
            dbra    D0,.L1
            addq.w  #1,D3
            movea.l (A3),A0
            lea     (0,A0,D3.w*8),A0
            movea.l (A2),A1
            move.w  #$F,($A,A1)
            bra.b   .L7
.L3:
            move.w  (8,A1),D0
            add.w   ($A,A1),D0
            moveq   #0,D3
            movea.l (A3),A0
            bra.b   .L5
.L4:
            move.l  (A0),D1
            beq.b   .L6
            addq.w  #8,A0
            addq.w  #1,D3
.L5:
            dbra    D0,.L4
            bra.b   .L8
.L6:
            subq.w  #1,($A,A1)
.L7:
            addq.w  #1,(8,A1)
            move.l  A4,(A0)
            clr.l   (4,A0)
            movea.l (A4),A0
            move.w  (6,A0),D0
            andi.w  #$E000,D0
            or.w    D0,D3
            move.w  D3,(6,A0)
            moveq   #0,D0
            bra.b   .L9
.L8:
            movea.l A4,A0
            _DisposHandle
            moveq   #1,D0
.L9:
            tst.l   D0
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #4
            ds.b    12
NewPalette:
            link.w  A6,#0
            movem.l D3/A2,-(SP)
            clr.l   ($12,A6)
            move.w  ($10,A6),D3
            moveq   #0,D0
            move.w  D3,D0
            addq.w  #1,D0
            lsl.l   #4,D0
            _NewHandleClear
            bne.b   .L7
            movea.l A0,A2
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L7
            move.l  A2,($12,A6)
            movea.l (A2),A0
            move.w  D3,(A0)
            clr.l   (2,A0)
            move.w  D3,D0
            move.w  ($A,A6),D1
            swap    D1
            move.w  (8,A6),D1
            lea     ($16,A0),A0
            bra.b   .L2
.L1:
            move.l  D1,(A0)
            lea     ($10,A0),A0
.L2:
            dbra    D0,.L1
            movea.l ($C,A6),A1
            cmpa.w  #0,A1
            beq.b   .L6
            movea.l (A1),A1
            move.w  (6,A1),D0
            addq.w  #1,D0
            ble.b   .L6
            movea.l (A2),A0
            adda.w  #$10,A0
            adda.w  #$A,A1
            cmp.w   D0,D3
            bge.b   .L3
            move.w  D3,D0
.L3:
            moveq   #0,D1
            bra.b   .L5
.L4:
            move.l  (A1),(A0)
            move.b  (A1),(1,A0)
            move.b  (2,A1),(3,A0)
            move.w  (4,A1),(4,A0)
            move.b  (4,A1),(5,A0)
            addq.l  #8,A1
            adda.w  #$10,A0
.L5:
            dbra    D0,.L4
.L6:
            moveq   #0,D0
.L7:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$A
            ds.b    12
GetNewPalette:
            link.w  A6,#0
            move.l  A2,-(SP)
            clr.l   ($A,A6)
            clr.l   -(SP)
            move.l  #'pltt',-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D1
            beq.b   .L2
            movea.l D1,A2
            move.l  D1,-(SP)
            jsr     ([$1448.w])
            movea.l A2,A0
            _HNoPurge
            tst.w   D0
            bne.b   .L2
            movea.l (A2),A0
            move.w  #$C000,D1
            move.w  (2,A0),D0
            bpl.b   .L1
            add.w   D0,D0
            move.w  D0,D1
.L1:
            move.w  D1,(6,A0)
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L2
            move.l  A2,($A,A6)
            movea.l (A2),A2
            clr.l   (8,A2)
.L2:
            movea.l (SP)+,A2
            unlk    A6
            rtd     #2
CLAIMINDEX:
            movea.l (-$28,A6),A1
            movea.l (A1),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            bset    #$F,($A,A0)
            move.l  (A0),($A,A1,D2.w*8)
            move.w  (4,A0),($E,A1,D2.w*8)
            addq.w  #1,(-$52,A6)
            bset    #6,(8,A1,D2.w*8)
            movea.l (-$20,A6),A1
            andi.w  #$7FFF,D0
            ori.w   #$6000,D0
            move.w  D0,(2,A1,D2.w*4)
            move.w  (-$1C,A6),D0
            lsl.w   #8,D0
            or.w    D2,D0
            bset    #$F,D0
            move.w  ($C,A0),D1
            move.w  D0,($C,A0)
            tst.w   D1
            bne.b   .L1
            movea.l (-$C,A6),A0
            move.w  (6,A0),D0
            andi.w  #$FFF,D0
            ori.w   #$6000,D0
            move.w  D0,(0,A1,D2.w*4)
            bra.b   .L2
.L1:
            move.w  D1,(0,A1,D2.w*4)
            bfextu  D1{24:8},D2
            bfextu  D1{19:5},D1
            lsl.w   #8,D1
            add.w   D2,D1
            movea.l (-$12,A6),A1
            adda.w  #$138,A1
            move.w  D0,(2,A1,D1.l*4)
.L2:
            movea.l (-$1A,A6),A0
            movea.l (-$C,A6),A1
            move.w  (6,A1),D0
            andi.w  #$FFF,D0
            addq.w  #1,(4,A0,D0.w*8)
            addq.w  #1,(-$52,A6)
            rts
            dc.w    0
CLEARPALETTE:
            link.w  A6,#0
            movem.l D2-D4/A2-A4,-(SP)
            movea.l ($DC8).w,A3
            cmpa.w  #$FFFF,A3
            beq.b   .L6
            movea.l (A3),A3
            movea.l (8,A6),A1
            movea.l (A1),A2
            move.w  (6,A2),D0
            andi.w  #$FFF,D0
            movea.l (4,A3),A0
            movea.l (A0),A0
            cmpa.l  (0,A0,D0.w*8),A1
            bne.b   .L7
            move.w  (4,A0,D0.w*8),D3
            clr.l   (4,A0,D0.w*8)
            clr.l   (8,A2)
            movea.l ($C,A2),A0
            movea.l (A0),A0
            move.w  (2,A3),D0
            lsr.w   #2,D0
            bra.b   .L2
.L1:
            clr.l   (A0)+
.L2:
            dbra    D0,.L1
            tst.w   D3
            beq.b   .L6
            move.w  (A2),D0
            adda.w  #$10,A2
            lea     ($38,A3),A4
            adda.w  #$138,A3
            bra.b   .L5
.L3:
            move.w  ($C,A2),D3
            bpl.b   .L4
            jsr     CLEARSTRAND
            or.l    D4,(-$128,A3)
.L4:
            clr.w   ($A,A2)
            clr.l   ($C,A2)
            adda.w  #$10,A2
.L5:
            dbra    D0,.L3
.L6:
            moveq   #0,D0
.L7:
            movem.l (SP)+,D2-D4/A2-A4
            unlk    A6
            rtd     #4
            ds.b    4
CLEARSTRAND:
            moveq   #0,D4
.L1:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            movea.l (0,A4,D1.w*8),A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D2
            bhi.b   .L2
            move.w  #$1000,(8,A0,D2.w*8)
            bset    D1,D4
.L2:
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A3,D1.l*4),A0
            move.w  (A0),D3
            clr.l   (A0)
            tst.w   D3
            bmi.b   .L1
            rts
            ds.b    4
ERASEPALETTE:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l (8,A6),A3
            movea.l (A3),A2
            movea.l ($C,A2),A0
            cmpa.w  #0,A0
            beq.b   .L1
            _DisposHandle
.L1:
            movea.l WindowList,A0
            bra.b   .L4
.L2:
            tst.w   (6,A0)
            bpl.b   .L3
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  ($C,A1),D0
            cmp.l   (8,A6),D0
            bne.b   .L3
            clr.l   ($C,A1)
.L3:
            movea.l ($90,A0),A0
.L4:
            move.l  A0,D0
            bne.b   .L2
            cmpa.l  ($DCC).w,A3
            bne.b   .L5
            clr.l   ($DCC).w
.L5:
            move.w  (6,A2),D0
            andi.w  #$FFF,D0
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.b   .L6
            movea.l (A2),A2
            move.w  (8,A2),D1
            add.w   ($A,A2),D1
            cmp.w   D1,D0
            bpl.b   .L6
            movea.l (4,A2),A1
            movea.l (A1),A1
            cmpa.l  (0,A1,D0.w*8),A3
            bne.b   .L6
            clr.l   (0,A1,D0.w*8)
            addq.w  #1,($A,A2)
            subq.w  #1,(8,A2)
.L6:
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #4
            dc.w    0
CORRELATE:
            movem.l D3-D7/A2-A3,-(SP)
            tst.w   (-$4E,A6)
            beq.w   .L11
            moveq   #0,D4
            movea.l (-$C,A6),A2
            lea     ($10,A2),A2
            movea.l (-$28,A6),A3
            movea.l A3,A0
            _HLock
            movea.l (A3),A3
            moveq   #0,D3
.L1:
            move.w  (6,A2),D7
            btst    #1,D7
            beq.b   .L3
            btst    #3,D7
            beq.b   .L3
            move.w  D4,D3
            and.w   (-$46,A6),D3
            beq.b   .L3
            cmp.w   (-$46,A6),D3
            beq.b   .L3
            bftst   (-$74,A6){D3:1}
            bne.b   .L3
            bfset   (-$74,A6){D3:1}
            move.w  D3,-(SP)
            jsr     PILLAGE
            subq.w  #2,SP
            pea     (A2)
            pea     ($A,A3,D3.w*8)
            bsr.l   DELTARGB
            move.w  (SP)+,D1
            cmp.w   (8,A2),D1
            bls.b   .L2
            lea     (8,A3,D3.w*8),A0
            move.l  (A2),(2,A0)
            move.w  (4,A2),(6,A0)
            bset    #5,(A0)
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
            addq.w  #1,(-$52,A6)
.L2:
            bset    #$F,($A,A2)
.L3:
            lea     ($10,A2),A2
            addq.w  #1,D4
            cmp.w   (-$E,A6),D4
            blt.b   .L1
            movea.l (-$C,A6),A2
            lea     ($10,A2),A2
            moveq   #0,D7
            moveq   #0,D4
            move.w  (-$46,A6),D5
.L4:
            tst.w   ($A,A2)
            bmi.w   .L9
            btst    #1,(7,A2)
            beq.w   .L9
            move.w  (8,A2),D6
            cmpi.w  #$21,(-$4E,A6)
            blt.b   .L5
            btst    #$1F,D4
            beq.b   .L5
            cmpi.w  #$400,D6
            bls.b   .L6
.L5:
            subq.w  #4,SP
            pea     (A2)
            jsr     ([$16CC.w])
            move.l  (SP)+,D7
            subq.w  #2,SP
            pea     (A2)
            pea     ($A,A3,D7.w*8)
            bsr.l   DELTARGB
            cmp.w   (SP)+,D6
            bcc.b   .L8
            bftst   (-$74,A6){D7:1}
            beq.b   .L7
.L6:
            subq.w  #2,SP
            bsr.w   GIMMEINDEX
            move.w  (SP)+,D7
            beq.b   .L10
            bftst   (-$74,A6){D7:1}
            bne.b   .L6
            move.w  D7,-(SP)
            jsr     PILLAGE
.L7:
            lea     (8,A3,D7.w*8),A0
            move.l  (A2),(2,A0)
            move.w  (4,A2),(6,A0)
            bset    #5,(A0)
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
            addq.w  #1,(-$52,A6)
            bset    #$1F,D4
.L8:
            bfset   (-$74,A6){D7:1}
.L9:
            lea     ($10,A2),A2
            addq.w  #1,D4
            cmp.w   (-$E,A6),D4
            bne.w   .L4
.L10:
            movea.l (-$28,A6),A0
            _HUnlock
.L11:
            movem.l (SP)+,D3-D7/A2-A3
            rts
            ds.b    8
DISPOSEAPPPALETTES:
            movem.l D0-D3/A0-A3,-(SP)
            movea.l ($DC8).w,A2
            cmpa.l  MinusOne,A2
            beq.w   .L5
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HLock
            movea.l (A0),A3
            move.w  (8,A1),D3
            beq.b   .L4
            add.w   ($A,A1),D3
            clr.l   WindowList
            bra.b   .L3
.L1:
            move.l  (A3),D1
            beq.b   .L2
            cmp.l   ApplZone,D1
            bcs.b   .L2
            cmp.l   HeapEnd,D1
            bcc.b   .L2
            move.l  D1,-(SP)
            jsr     ([$184C.w])
.L2:
            addq.w  #8,A3
.L3:
            dbra    D3,.L1
.L4:
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HUnlock
.L5:
            clr.l   ($DCC).w
            movem.l (SP)+,D0-D3/A0-A3
            rts
            ds.b    6
DEVSETENTRIES:
            move.l  A2,-(SP)
            move.l  TheGDevice,-(SP)
            movea.l (A0),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            move.l  (A2),-(SP)
            move.l  A0,TheGDevice
            clr.w   -(SP)
            move.w  (6,A2),-(SP)
            pea     (8,A2)
            jsr     ([$16FC.w])
            move.l  (SP)+,(A2)
            move.l  (SP)+,TheGDevice
            movea.l (SP)+,A2
            rts
            ds.b    12
DisposePalette:
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l (8,A6),A2
            cmpa.w  #0,A2
            beq.b   .L1
            move.l  A2,-(SP)
            jsr     CLEARPALETTE
            bne.b   .L1
            move.l  A2,-(SP)
            jsr     ERASEPALETTE
            movea.l A2,A0
            _DisposHandle
.L1:
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
            ds.b    5
.L2:
            dc.b    $00,$00,$01,$02,$03,$04,$00,$00,$05,$06
.L3:
            dc.b    $01,$22,$42,$24,$44,$28,$08
GETCLUT:
            link.w  A6,#-6
            movem.l D0-D3/A0-A1,-(SP)
            _GetZone
            move.l  A0,(-4,A6)
            movea.l SysZone,A0
            _SetZone
            movea.l (8,A6),A0
            movea.l (A0),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            move.w  ($20,A1),D0
            cmpi.w  #1,D0
            beq.b   .L1
            btst    #0,($15,A0)
            beq.b   .L1
            addq.w  #1,D0
.L1:
            lea     DisposePalette.L2,A1
            move.b  (0,A1,D0.w),D0
            move.w  D0,(-6,A6)
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($1C,A0,D0.w*4),A0
            move.l  A0,D1
            beq.b   .L3
            move.l  (A0),D1
            beq.b   .L2
            move.l  A0,($C,A6)
            bra.b   .L7
.L2:
            _DisposHandle
            move.w  (-6,A6),D0
.L3:
            lea     DisposePalette.L3,A0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            subq.w  #4,SP
            move.w  D3,-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            move.l  A0,($C,A6)
            beq.b   .L7
            movea.l (A0),A1
            cmp.l   (A1),D3
            bne.b   .L5
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  D3,-(SP)
            move.l  A0,D3
            move.w  #$FFFF,ROMMapInsert
            jsr     ([$E7C.w])
            move.l  (SP)+,D2
            beq.b   .L4
            move.l  D2,($C,A6)
            movea.l D3,A0
            _DisposHandle
            bra.b   .L6
.L4:
            movea.l D3,A0
.L5:
            _HPurge
.L6:
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (-6,A6),D0
            move.l  ($C,A6),($1C,A0,D0.w*4)
.L7:
            movea.l (-4,A6),A0
            _SetZone
            movem.l (SP)+,D0-D3/A0-A1
            unlk    A6
            rtd     #4
            ds.b    6
InitPalettes:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            move.l  ($DC8).w,D0
            cmpi.l  #$FFFFFFFF,D0
            bne.w   .L13
            move.l  #$138,D4
            move.l  D4,D0
            _NewHandleClear async
            bne.w   .L19
            movea.l A0,A3
            move.l  A0,($DC8).w
            moveq   #0,D3
            movea.l (A3),A4
            clr.l   ($10,A4)
            clr.l   ($14,A4)
            lea     ($38,A4),A4
            clr.l   -(SP)
            jsr     ([$16A4.w])
            movea.l (SP)+,A2
            bra.b   .L3
.L1:
            movea.l (A2),A0
            move.w  ($14,A0),D0
            btst    #$D,D0
            beq.b   .L2
            addq.w  #1,D3
            move.l  A2,(A4)
            clr.l   (4,A4)
            addq.w  #8,A4
            addi.l  #$400,D4
            cmpi.w  #$20,D3
            bpl.b   .L4
.L2:
            movea.l ($1E,A0),A2
.L3:
            move.l  A2,D0
            bne.b   .L1
.L4:
            movea.l (A3),A4
            move.w  D3,(A4)
            move.w  D3,D0
            bne.b   .L5
            addq.w  #1,D0
.L5:
            lsl.w   #2,D0
            move.w  D0,(2,A4)
            clr.w   (8,A4)
            move.w  #$10,($A,A4)
            move.l  D4,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L6
            moveq   #$10,D0
            lsl.w   #3,D0
            _NewHandleClear async
            beq.b   .L7
            movea.l A3,A0
            _DisposHandle
.L6:
            move.l  #$FFFFFFFF,($DC8).w
            bra.w   .L19
.L7:
            movea.l (A3),A4
            move.l  A0,(4,A4)
            movea.l A3,A0
            _HLock
            movea.l (A3),A4
            lea     ($1C,A4),A0
            moveq   #6,D0
.L8:
            clr.l   (A0)+
            dbra    D0,.L8
            move.w  D3,D0
            lsl.w   #8,D0
            lea     ($138,A4),A0
            bra.b   .L10
.L9:
            clr.l   (A0)+
.L10:
            dbra    D0,.L9
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            clr.l   -(SP)
            clr.w   -(SP)
            jsr     ([$1848.w])
            move.l  (SP)+,($C,A4)
            bne.b   .L11
            lea     MASKEND,A0
            moveq   #$18,D0
            jsr     ([$158C.w])
            move.l  A0,D3
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.l  A0,-(SP)
            clr.w   -(SP)
            clr.w   -(SP)
            jsr     ([$1844.w])
            move.l  (SP)+,($C,A4)
            movea.l D3,A0
            _DisposHandle
.L11:
            movea.l ($C,A4),A0
            cmpa.w  #0,A0
            beq.b   .L12
            movea.l (A0),A0
            bset    #$F,(6,A0)
            bset    #$E,(6,A0)
.L12:
            move.l  (SP)+,TheZone
            movea.l A3,A0
            _HUnlock
            jsr     CHECKALLDEVICECLUTS
            move.w  #1,-(SP)
            jsr     SCATTERDEVICES
            clr.l   ($DCC).w
            bra.b   .L14
.L13:
            move.l  ($DCC).w,D0
            beq.b   .L14
            addq.l  #1,D0
            bne.w   .L18
            clr.l   ($DCC).w
.L14:
            tst.w   CurApRefNum
            beq.b   .L18
            clr.w   -(SP)
            jsr     ([$1450.w])
            move.w  (SP)+,D3
            cmp.w   CurApRefNum,D3
            beq.b   .L15
            move.w  CurApRefNum,-(SP)
            jsr     ([$1460.w])
            clr.w   -(SP)
            jsr     ([$14BC.w])
            move.w  (SP)+,D0
            bne.b   .L18
.L15:
            clr.l   -(SP)
            move.l  #'pltt',-(SP)
            clr.w   -(SP)
            jsr     ([$E7C.w])
            movea.l (SP)+,A2
            move.l  A2,D0
            beq.b   .L17
            move.l  A2,-(SP)
            jsr     ([$1448.w])
            movea.l (A2),A0
            move.w  #$C000,D1
            move.w  (2,A0),D0
            bpl.b   .L16
            add.w   D0,D0
            move.w  D0,D1
.L16:
            move.w  D1,(6,A0)
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L17
            move.l  A2,($DCC).w
            movea.l (A2),A0
            bset    #$C,(6,A0)
            clr.l   (8,A0)
.L17:
            cmp.w   CurApRefNum,D3
            beq.b   .L18
            move.w  D3,-(SP)
            jsr     ([$1460.w])
.L18:
            jsr     INSTALLMYEXITTOSHELL
            jsr     UPDATEDEVICES
.L19:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rts
            ds.b    6
CHECKDEVICECOLORS:
            link.w  A6,#0
            movem.l D0-D2/A0-A3,-(SP)
            clr.w   D2
            movea.l (8,A6),A2
            movea.l (A2),A3
            tst.w   (4,A3)
            bne.b   .L4
            tst.w   ($14,A3)
            bpl.b   .L4
            subq.w  #4,SP
            move.l  A2,-(SP)
            jsr     GETCLUT
            movea.l (SP)+,A0
            movea.l (A0),A0
            lea     ($A,A0),A0
            movea.l ($16,A3),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            move.w  (6,A1),D0
            lea     (8,A1),A1
.L1:
            btst    #6,(A1)
            bne.b   .L3
            bset    #3,(A1)
            move.l  (A0),D1
            cmp.l   (2,A1),D1
            bne.b   .L2
            move.w  (4,A0),D1
            cmp.w   (6,A1),D1
            beq.b   .L3
.L2:
            bset    #4,(A1)
            moveq   #-1,D2
.L3:
            addq.w  #8,A0
            addq.w  #8,A1
            dbra    D0,.L1
.L4:
            move.w  D2,($C,A6)
            movem.l (SP)+,D0-D2/A0-A3
            unlk    A6
            rtd     #4
            ds.b    8
FINDLINK:
            link.w  A4,#0
            move.l  D3,-(SP)
            clr.w   ($A,A4)
            move.w  (8,A4),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L4
            move.w  (-$22,A6),D3
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            bra.b   .L2
.L1:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            cmp.w   (-$1C,A6),D1
            beq.b   .L3
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D0
            bpl.b   .L4
.L2:
            dbra    D3,.L1
            bra.b   .L4
.L3:
            andi.w  #$FF,D2
            move.w  D2,($A,A4)
.L4:
            move.l  (SP)+,D3
            unlk    A4
            rtd     #2
            ds.b    12
ANALYZEDEV:
            movem.l D3-D5/A2-A3,-(SP)
            lea     (-$74,A6),A2
            movea.l (-$28,A6),A3
            movea.l (A3),A3
            moveq   #0,D3
            move.w  (-$46,A6),D3
            clr.w   D4
            bsr.w   ClearAvailBits
            movea.l (-$C,A6),A0
            moveq   #0,D0
            moveq   #0,D2
            lea     ($10,A0),A1
            bra.b   .L3
.L1:
            move.w  ($A,A1),D1
            bmi.b   .L2
            btst    #3,D1
            beq.b   .L2
            move.w  D0,D2
            and.w   D3,D2
            bfset   (A2){D2:1}
.L2:
            lea     ($10,A1),A1
            addq.w  #1,D0
.L3:
            cmp.w   (A0),D0
            bcs.b   .L1
            movea.l (-$40,A6),A1
            move.w  D3,D0
            moveq   #0,D1
.L4:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L5
            ror.b   #4,D1
.L5:
            bftst   (A2){D1:1}
            bne.b   .L6
            move.w  (8,A3,D1.w*8),D2
            andi.w  #$6000,D2
            bne.b   .L6
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L6:
            dbra    D0,.L4
            move.w  D3,D0
.L7:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L8
            ror.b   #4,D1
.L8:
            bftst   (A2){D1:1}
            bne.b   .L9
            btst    #6,(8,A3,D1.w*8)
            bne.b   .L9
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L9:
            dbra    D0,.L7
            move.w  (6,A0),D5
            andi.w  #$FFF,D5
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            move.w  D3,D0
.L10:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L11
            ror.b   #4,D1
.L11:
            bftst   (A2){D1:1}
            bne.b   .L13
            move.w  (-$1C,A6),D2
            lsl.w   #8,D2
            move.b  D1,D2
.L12:
            andi.w  #$1FFF,D2
            move.w  (0,A0,D2.w*4),D2
            beq.b   .L13
            bmi.b   .L12
            andi.w  #$1FFF,D2
            cmp.w   D2,D5
            beq.b   .L13
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L13:
            dbra    D0,.L10
            move.w  D4,(-$50,A6)
            clr.w   (-$54,A6)
            bsr.b   ClearAvailBits
            movem.l (SP)+,D3-D5/A2-A3
            rts
ClearAvailBits:
            moveq   #7,D0
.L1:
            clr.l   (-$74,A6,D0.w*4)
            dbra    D0,.L1
            bfset   (-$74,A6){0:1}
            bfset   (-$74,A6){D3:1}
            rts
            ds.b    14
PILLAGE:
            link.w  A4,#0
            movem.l D3-D4,-(SP)
            move.w  (8,A4),D3
            move.w  (-$1C,A6),D4
            lsl.w   #8,D4
            move.b  D3,D4
            move.w  D4,-(SP)
            bsr.w   ZAPLINKS
            movea.l (-$28,A6),A0
            movea.l (A0),A0
            clr.w   (8,A0,D3.w*8)
            movem.l (SP)+,D3-D4
            unlk    A4
            rtd     #2
            dc.w    0
GIMMEINDEX:
            clr.w   D1
            move.w  (-$54,A6),D0
            cmp.w   (-$50,A6),D0
            beq.b   .L1
            movea.l (-$40,A6),A0
            move.w  (0,A0,D0.w*2),D1
            addq.w  #1,(-$54,A6)
.L1:
            move.w  D1,(4,SP)
            rts
            dc.w    0
MARKDEVUBIT:
            move.w  (-$1C,A6),D0
            movea.l (-$12,A6),A0
            move.l  ($14,A0),D1
            bset    D0,D1
            move.l  D1,($14,A0)
            rts
            ds.b    12
REDRAWDESKTOP:
            subq.w  #4,SP
            jsr     ([$1160.w])
            movea.l (SP),A3
            move.l  A2,-(SP)
            jsr     ([$117C.w])
            clr.l   -(SP)
            move.l  A3,-(SP)
            jsr     ([$1230.w])
            move.l  A3,-(SP)
            jsr     ([$1164.w])
            rts
            ds.b    10
DIRTYSEEDS:
            link.w  A6,#0
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (2,A0),D0
            lsr.w   #2,D0
            subq.w  #1,D0
            movea.l (8,A6),A0
            movea.l (A0),A0
            bset    #$D,(6,A0)
            movea.l ($C,A0),A0
            movea.l (A0),A0
.L1:
            clr.l   (A0)+
            dbra    D0,.L1
            unlk    A6
            rtd     #4
SetPalette:
            link.w  A6,#0
            move.l  D3,-(SP)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.w   .L9
            movea.l ($E,A6),A0
            cmpa.w  #$FFFF,A0
            bne.b   .L4
            move.l  ($DCC).w,D0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            btst    #$C,(6,A0)
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     ([$184C.w])
.L1:
            movea.l ($A,A6),A0
            move.l  A0,($DCC).w
            beq.b   .L2
            movea.l (A0),A0
            bset    #$E,(6,A0)
            bset    #$F,(6,A0)
            movea.l ($A,A6),A0
            bra.b   .L3
.L2:
            movea.l (A1),A0
            movea.l ($C,A0),A0
            move.l  A0,D0
            beq.w   .L9
.L3:
            move.l  A0,-(SP)
            bsr.w   DIRTYSEEDS
            clr.l   -(SP)
            jsr     ([$1290.w])
            bra.b   .L8
.L4:
            tst.w   (6,A0)
            bpl.b   .L9
            move.l  ($A,A6),D0
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  ($C,A1),D3
            move.l  D0,($C,A1)
            beq.b   .L7
            movea.l D0,A1
            movea.l (A1),A1
            bclr    #$E,(6,A1)
            bset    #$F,(6,A1)
            tst.b   (8,A6)
            beq.b   .L7
            bpl.b   .L6
            btst    #$E,(8,A6)
            bne.b   .L5
            bclr    #$F,(6,A1)
.L5:
            btst    #$D,(8,A6)
            beq.b   .L7
.L6:
            bset    #$E,(6,A1)
.L7:
            cmp.l   D0,D3
            beq.b   .L9
            move.l  A0,-(SP)
            tst.l   D3
            beq.b   .L8
            move.l  D3,-(SP)
            jsr     UPDATEPALETTE
            movea.l D3,A0
            movea.l (A0),A0
            btst    #$C,(6,A0)
            beq.b   .L8
            move.l  D3,-(SP)
            jsr     ([$184C.w])
.L8:
            jsr     ([$1850.w])
.L9:
            move.l  (SP)+,D3
            unlk    A6
            rtd     #$A
GetPalette:
            link.w  A6,#0
            clr.l   ($C,A6)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.b   .L2
            movea.l (8,A6),A0
            cmpa.w  #0,A0
            beq.b   .L2
            cmpa.w  #$FFFF,A0
            bne.b   .L1
            move.l  ($DCC).w,($C,A6)
            bne.b   .L2
            movea.l (A1),A1
            movea.l ($C,A1),A0
            move.l  A0,D0
            beq.b   .L2
            jsr     ([$1584.w])
            tst.w   D0
            bne.b   .L2
            move.l  A0,($DCC).w
            move.l  A0,($C,A6)
            move.l  A0,-(SP)
            movea.l (A0),A0
            clr.l   ($C,A0)
            bclr    #$C,(6,A0)
            jsr     RECORDPALETTE
            beq.b   .L2
            clr.l   ($DCC).w
            clr.l   ($C,A6)
            bra.b   .L2
.L1:
            tst.w   (6,A0)
            bpl.b   .L2
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            move.l  A0,($C,A6)
            beq.b   .L2
            movea.l (A0),A0
            bclr    #$C,(6,A0)
.L2:
            unlk    A6
            rtd     #4
            ds.b    8
FINDINDEX:
            movem.l D3-D4,-(SP)
            move.w  ($C,A3),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L6
            movea.l ($DC8).w,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L6
            movea.l (A0),A0
            move.w  (A0),D3
            beq.b   .L6
            lea     ($38,A0),A1
            bra.b   .L2
.L1:
            move.l  (0,A1,D3.w*8),D4
            cmp.l   TheGDevice,D4
            beq.b   .L3
.L2:
            dbra    D3,.L1
            bra.b   .L6
.L3:
            move.w  (A0),D4
            adda.w  #$138,A0
            bra.b   .L5
.L4:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            cmp.w   D3,D1
            beq.b   .L7
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D0
            bpl.b   .L6
.L5:
            dbra    D4,.L4
.L6:
            bra.b   .L8
.L7:
            andi.w  #$FF,D2
            move.w  D2,D0
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D0
            blt.b   .L9
.L8:
            moveq   #0,D0
.L9:
            movem.l (SP)+,D3-D4
            rts
            ds.b    14
ENTRY2INDEX:
            link.w  A6,#-4
            movem.l A2-A3,-(SP)
            move.w  #1,QDErr
            clr.l   ($A,A6)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.w   .L7
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.w   .L7
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L7
.L1:
            move.l  A2,(-4,A6)
            movea.l A2,A0
            _HLock
            movea.l (A2),A2
            moveq   #0,D0
            move.w  (8,A6),D0
            cmp.w   (A2),D0
            bcc.w   .L6
            asl.l   #4,D0
            lea     ($10,A2,D0.l),A3
            clr.l   -(SP)
            pea     (A3)
            btst    #2,(7,A3)
            beq.b   .L2
            addq.l  #1,(SP)
.L2:
            jsr     ([$16CC.w])
            move.l  (SP)+,($A,A6)
            clr.w   QDErr
            movea.l TheGDevice,A0
            movea.l (A0),A0
            move.w  (4,A0),D1
            beq.b   .L3
            subq.w  #1,D1
            bne.b   .L6
.L3:
            tst.w   ($14,A0)
            bpl.b   .L6
            move.w  (6,A3),D1
            moveq   #0,D0
            move.w  (8,A6),D0
            btst    #2,D1
            beq.b   .L4
            jsr     FINDINDEX
            tst.w   D0
            beq.b   .L6
            bra.b   .L5
.L4:
            btst    #3,D1
            beq.b   .L6
            btst    #1,D1
            bne.b   .L6
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            and.w   (6,A0),D0
.L5:
            move.l  D0,($A,A6)
.L6:
            movea.l (-4,A6),A0
            _HUnlock
.L7:
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #2
            ds.b    6
INDEX2ENTRIES:
            link.w  A6,#0
            movem.l D3-D7/A2,-(SP)
            movea.l (A5),A0
            move.l  (A0),D0
            beq.b   .L3
            subq.w  #4,SP
            move.l  D0,-(SP)
            jsr     ([$1858.w])
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (A0),D4
            move.l  (8,A6),D0
            beq.b   .L3
            movea.l D0,A0
            _HGetState
            move.b  D0,D3
            _HNoPurge
            _HUnlock
            move.w  D4,D0
            add.w   D0,D0
            addq.w  #2,D0
            ext.l   D0
            _SetHandleSize
            _HLock
            movea.l (A0),A2
            moveq   #0,D5
            move.l  ($C,A6),D6
            bra.b   .L2
.L1:
            subq.w  #4,SP
            move.w  D4,-(SP)
            moveq   #0,D0
            _PaletteDispatch
            cmp.l   (SP)+,D6
            bne.b   .L2
            addq.w  #1,D5
            move.w  D4,(0,A2,D5.w*2)
.L2:
            dbra    D4,.L1
            movea.l (8,A6),A0
            move.l  D5,D0
            add.l   D0,D0
            addq.l  #2,D0
            _SetHandleSize
            move.b  D3,D0
            _HSetState
.L3:
            movem.l (SP)+,D3-D6/A2
            unlk    A6
            rtd     #6
            ds.b    8
PmForeColor:
            moveq   #1,D0
            bra.b   PmBackColor.L1
PmBackColor:
            moveq   #0,D0
.L1:
            link.w  A6,#-2
            move.w  D0,(-2,A6)
            clr.l   -(SP)
            move.w  (8,A6),-(SP)
            moveq   #0,D0
            _PaletteDispatch
            move.l  (SP)+,D0
            tst.w   QDErr
            bne.b   .L4
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  D0,-(SP)
            tst.w   (-2,A6)
            beq.b   .L2
            move.l  D0,($50,A0)
            move.w  (8,A6),($10,A1)
            bset    #0,($19,A1)
            pea     ($24,A0)
            bra.b   .L3
.L2:
            move.l  D0,($54,A0)
            move.w  (8,A6),($16,A1)
            bset    #1,($19,A1)
            pea     ($2A,A0)
.L3:
            jsr     ([$16D0.w])
.L4:
            unlk    A6
            rtd     #2
            ds.b    8
AnimateEntry:
            link.w  A6,#-$E
            movem.l D3-D5/A2-A4,-(SP)
            movea.l ($DC8).w,A3
            cmpa.w  #$FFFF,A3
            beq.w   .L5
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.w   .L5
            tst.w   (6,A0)
            bpl.w   .L5
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L5
.L1:
            movea.l (A2),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.w   .L5
            lsl.w   #4,D1
            lea     ($10,A0,D1.l),A2
            btst    #2,(7,A2)
            beq.w   .L5
            movea.l (8,A6),A0
            move.l  (A0),D0
            move.l  D0,(-$A,A6)
            ror.l   #8,D0
            move.b  D0,(2,A2)
            swap    D0
            move.b  D0,(A2)
            move.w  (4,A0),D0
            move.w  D0,(-6,A6)
            ror.w   #8,D0
            move.b  D0,(4,A2)
            move.w  ($C,A2),D3
            bfextu  D3{16:3},D1
            cmpi.w  #4,D1
            bne.w   .L5
            movea.l A3,A0
            _HLock
            move.l  TheGDevice,(-4,A6)
            movea.l (A3),A2
            move.w  (A2),D5
            lea     ($38,A2),A4
            adda.w  #$138,A2
            move.w  D3,D0
            bra.b   .L4
.L2:
            bfextu  D0{19:5},D3
            bfextu  D0{24:8},D4
            movea.l (0,A4,D3.w*8),A0
            move.l  A0,TheGDevice
            movea.l (A0),A0
            clr.w   (2,A0)
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            cmp.w   D4,D0
            ble.b   .L3
            move.l  (A0),(-$E,A6)
            move.l  (-$A,A6),($A,A0,D4.w*8)
            move.w  (-6,A6),($E,A0,D4.w*8)
            move.w  D4,-(SP)
            clr.w   -(SP)
            pea     (8,A0,D4.w*8)
            jsr     ([$16FC.w])
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (-$E,A6),(A0)
.L3:
            lsl.w   #8,D3
            add.w   D4,D3
            move.w  (0,A2,D3.l*4),D0
.L4:
            dbpl    D5,.L2
            move.l  (-4,A6),TheGDevice
            movea.l A3,A0
            _HUnlock
.L5:
            moveq   #0,D0
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    4
AnimatePalette:
            link.w  A6,#-$8A
            movem.l D3-D6/A2-A4,-(SP)
            movea.l ($DC8).w,A4
            cmpa.w  #$FFFF,A4
            beq.w   .L15
            movea.l ($12,A6),A0
            cmpa.w  #0,A0
            beq.w   .L15
            tst.w   (6,A0)
            bpl.w   .L15
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L15
.L1:
            movea.l ($E,A6),A3
            move.l  A3,D0
            beq.w   .L15
            movea.l (A2),A2
            move.w  (A2),D0
            beq.w   .L15
            moveq   #0,D3
            move.w  ($A,A6),D3
            cmp.w   D0,D3
            bcc.w   .L15
            movea.l (A3),A3
            move.w  ($C,A6),D4
            cmp.w   (6,A3),D4
            bhi.w   .L15
            sub.w   D3,D0
            move.w  D0,D5
            move.w  (6,A3),D0
            addq.w  #1,D0
            sub.w   D4,D0
            cmp.w   D0,D5
            bls.b   .L2
            move.w  D0,D5
.L2:
            cmp.w   (8,A6),D5
            bls.b   .L3
            move.w  (8,A6),D5
.L3:
            movea.l (A4),A1
            move.w  (A1),D0
            move.w  D0,(-$A,A6)
            lea     ($38,A1),A4
            lea     (-$8A,A6),A0
            bra.b   .L5
.L4:
            clr.l   (A0)+
.L5:
            dbra    D0,.L4
            adda.w  #$138,A1
            lsl.l   #4,D3
            lea     ($10,A2,D3.l),A2
            lea     (8,A3,D4.w*8),A3
            bra.w   .L11
.L6:
            btst    #2,(7,A2)
            beq.w   .L10
            move.b  (2,A3),(A2)
            move.b  (4,A3),(2,A2)
            move.b  (6,A3),(4,A2)
            move.w  ($C,A2),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L10
            move.w  (-$A,A6),D6
            subq.w  #1,D6
.L7:
            bfextu  D0{19:5},D3
            bfextu  D0{24:8},D4
            lea     (-$8A,A6),A0
            movea.l (0,A0,D3.w*4),A0
            cmpa.w  #0,A0
            bne.b   .L8
            movea.l (0,A4,D3.w*8),A0
            movea.l (A0),A0
            clr.w   (2,A0)
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  ($2A,A0),D0
            lea     (-$8A,A6),A0
            move.l  D0,(0,A0,D3.w*4)
            movea.l D0,A0
.L8:
            movea.l (A0),A0
            move.w  (6,A0),D0
            cmp.w   D4,D0
            ble.b   .L9
            move.w  (A2),($A,A0,D4.w*8)
            move.w  (2,A2),($C,A0,D4.w*8)
            move.w  (4,A2),($E,A0,D4.w*8)
.L9:
            lsl.w   #8,D3
            add.w   D4,D3
            move.w  (0,A1,D3.l*4),D0
            dbpl    D6,.L7
.L10:
            adda.w  #$10,A2
            addq.l  #8,A3
.L11:
            dbra    D5,.L6
            move.l  TheGDevice,(-4,A6)
            move.w  (-$A,A6),D6
            lea     (-$8A,A6),A2
            bra.b   .L14
.L12:
            movea.l (A2)+,A3
            cmpa.w  #0,A3
            beq.b   .L13
            move.l  (A4),TheGDevice
            movea.l (A3),A0
            move.l  (A0),(-8,A6)
            clr.w   -(SP)
            move.w  (6,A0),-(SP)
            pea     (8,A0)
            jsr     ([$16FC.w])
            movea.l (A3),A0
            move.l  (-8,A6),(A0)
.L13:
            addq.l  #8,A4
.L14:
            dbra    D6,.L12
            move.l  (-4,A6),TheGDevice
.L15:
            moveq   #0,D0
            movem.l (SP)+,D3-D6/A2-A4
            unlk    A6
            rtd     #$E
            ds.b    12
GetEntryColor:
            link.w  A6,#0
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L1
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L1
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l (8,A6),A1
            move.l  (A0),(A1)
            move.w  (4,A0),(4,A1)
.L1:
            moveq   #0,D0
            unlk    A6
            rtd     #$A
            ds.b    10
SCATTERDEVICES:
            link.w  A6,#0
            movem.l D1-D5/A0/A2-A4,-(SP)
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.l  ($10,A0),D4
            beq.w   .L8
            clr.l   ($10,A0)
            or.l    D4,($14,A0)
            move.w  (A0),D3
            subq.w  #1,D3
            lea     ($38,A0),A2
.L1:
            btst    D3,D4
            beq.w   .L7
            subq.w  #4,SP
            movea.l (0,A2,D3.w*8),A3
            move.l  A3,-(SP)
            jsr     GETCLUT
            movea.l (SP)+,A4
            movea.l (A4),A4
            move.l  (A4),D2
            lea     ($A,A4),A4
            movea.l (A3),A3
            movea.l ($16,A3),A3
            movea.l (A3),A3
            movea.l ($2A,A3),A3
            movea.l (A3),A3
            move.w  (6,A3),D1
            lea     (8,A3),A0
            clr.w   D5
.L2:
            btst    #3,(A0)
            beq.b   .L3
            addq.w  #1,D5
.L3:
            btst    #4,(A0)
            beq.b   .L4
            clr.w   (A0)
            move.l  (A4),(2,A0)
            move.w  (4,A4),(6,A0)
.L4:
            addq.w  #8,A0
            addq.w  #8,A4
            dbra    D1,.L2
            movea.l (0,A2,D3.w*8),A4
            cmp.w   (6,A3),D5
            ble.b   .L5
            move.l  D2,(A3)
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            clr.l   (A0)
            bra.b   .L6
.L5:
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
.L6:
            tst.w   (8,A6)
            beq.b   .L7
            movea.l A4,A0
            jsr     DEVSETENTRIES
.L7:
            dbra    D3,.L1
.L8:
            movem.l (SP)+,D1-D5/A0/A2-A4
            unlk    A6
            rtd     #2
            ds.b    6
.L9:
            dc.w    0,$0809,$0A0B,0,$0C0D
SETDEV:
            link.w  A4,#-$C
            movem.l D3-D5/A2-A3,-(SP)
            move.w  (-$1C,A6),D3
            movea.l (-$16,A6),A0
            movea.l (0,A0,D3.w*8),A0
            move.l  A0,TheGDevice
            movea.l (A0),A0
            tst.w   (4,A0)
            bne.w   .L6
            tst.w   ($14,A0)
            bpl.w   .L6
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            move.l  A0,(-$28,A6)
            movea.l (A0),A0
            move.w  (6,A0),D0
            move.w  D0,(-$46,A6)
            addq.w  #1,D0
            move.w  D0,(-$24,A6)
            move.l  (A0),D0
            movea.l (-$C,A6),A0
            btst    #$D,(6,A0)
            bne.b   .L1
            movea.l ($C,A0),A0
            movea.l (A0),A0
            cmp.l   (0,A0,D3.w*4),D0
            beq.w   .L6
.L1:
            movea.l (-$16,A6),A0
            lea     (0,A0,D3.w*8),A0
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            move.w  D3,D0
            lsl.w   #8,D0
            lea     (0,A0,D0.w*4),A0
            move.l  A0,(-$20,A6)
            clr.w   (-$52,A6)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            move.w  ($14,A0),D3
            andi.w  #1,D3
            movea.l ($16,A0),A0
            movea.l (A0),A0
            add.w   ($20,A0),D3
            lea     SCATTERDEVICES.L9,A0
            move.b  (0,A0,D3.w),D3
            move.w  (-$E,A6),D0
            movea.l (-$C,A6),A0
            lea     ($10,A0),A0
            bra.b   .L4
.L2:
            move.w  (6,A0),D1
            btst    D3,D1
            beq.b   .L3
            bset    #$F,D1
.L3:
            move.w  D1,($A,A0)
            adda.w  #$10,A0
.L4:
            dbra    D0,.L2
            jsr     ANALYZEDEV
            jsr     Allocate
            jsr     CORRELATE
            tst.w   (-$52,A6)
            beq.b   .L5
            jsr     MARKDEVUBIT
.L5:
            movea.l (-$28,A6),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$C,A6),A0
            movea.l ($C,A0),A1
            movea.l (A1),A1
            move.w  (-$1C,A6),D3
            move.l  D0,(0,A1,D3.w*4)
.L6:
            moveq   #0,D0
            movem.l (SP)+,D3-D5/A2-A3
            unlk    A4
            rts
            ds.b    4
SetEntryColor:
            link.w  A6,#0
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L2
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L2
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l (8,A6),A1
            move.l  (A1),(A0)
            move.w  (4,A1),(4,A0)
            btst    #2,(7,A0)
            beq.b   .L1
            lea     (A0),A0
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
.L1:
            move.l  ($E,A6),-(SP)
            bsr.w   DIRTYSEEDS
.L2:
            moveq   #0,D0
            unlk    A6
            rtd     #$A
            dc.w    0
GetEntryUsage:
            link.w  A6,#0
            movea.l ($12,A6),A0
            cmpa.w  #0,A0
            beq.b   .L1
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($10,A6),D1
            cmp.w   D0,D1
            bcc.b   .L1
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l ($C,A6),A1
            move.w  (6,A0),(A1)
            movea.l (8,A6),A1
            move.w  (8,A0),(A1)
.L1:
            moveq   #0,D0
            unlk    A6
            rtd     #$E
            ds.b    6
SetEntryUsage:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L3
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L3
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A2
            move.w  (6,A2),D0
            btst    #2,D0
            beq.b   .L1
            move.w  ($A,A6),D3
            eor.w   D3,D0
            andi.w  #$3F0C,D0
            beq.b   .L1
            move.w  ($C,A2),D3
            bpl.b   .L1
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            lea     ($138,A0),A3
            lea     ($38,A0),A4
            moveq   #0,D4
            jsr     CLEARSTRAND
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            or.l    D4,($10,A0)
            clr.w   ($C,A2)
.L1:
            move.w  ($A,A6),D0
            btst    #2,D0
            beq.b   .L2
            lea     (A2),A0
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
.L2:
            move.w  D0,(6,A2)
            move.w  (8,A6),(8,A2)
            move.l  ($E,A6),-(SP)
            bsr.w   DIRTYSEEDS
.L3:
            moveq   #0,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    12
CTab2Palette:
            link.w  A6,#0
            movem.l D3/A2-A3,-(SP)
            movea.l ($C,A6),A2
            cmpa.w  #0,A2
            beq.w   .L4
            move.l  ($C,A6),-(SP)
            jsr     CLEARPALETTE
            bne.b   .L4
            movea.l ($10,A6),A3
            cmpa.w  #0,A3
            beq.b   .L4
            movea.l (A3),A1
            moveq   #0,D3
            move.w  (6,A1),D3
            addq.w  #1,D3
            movea.l A2,A0
            move.l  D3,D0
            addq.w  #1,D0
            asl.w   #4,D0
            _SetHandleSize
            bne.b   .L4
            move.l  A2,-(SP)
            bsr.w   DIRTYSEEDS
            movea.l (A2),A0
            move.w  D3,(A0)
            adda.w  #$10,A0
            movea.l (A3),A1
            addq.l  #8,A1
            move.w  ($A,A6),D1
            swap    D1
            move.w  (8,A6),D1
            bra.b   .L3
.L1:
            move.l  (2,A1),(A0)
            move.w  (6,A1),(4,A0)
            btst    #$12,D1
            beq.b   .L2
            move.b  (2,A1),(1,A0)
            move.b  (4,A1),(3,A0)
            move.b  (6,A1),(5,A0)
.L2:
            move.l  D1,(6,A0)
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            adda.w  #$10,A0
            addq.l  #8,A1
.L3:
            dbra    D3,.L1
.L4:
            moveq   #0,D0
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #$C
Palette2CTab:
            link.w  A6,#0
            movem.l D3/A2-A3,-(SP)
            movea.l ($C,A6),A2
            cmpa.w  #0,A2
            beq.b   .L3
            movea.l (8,A6),A3
            cmpa.w  #0,A3
            beq.b   .L3
            movea.l (A2),A0
            moveq   #0,D3
            move.w  (A0),D3
            move.l  D3,D0
            addq.l  #1,D0
            lsl.l   #3,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L3
            movea.l (A2),A0
            movea.l (A3),A1
            move.w  D3,D0
            subq.w  #1,D0
            clr.l   (A1)
            move.w  D0,(6,A1)
            clr.w   (4,A1)
            addq.w  #8,A1
            lea     ($10,A0),A0
            moveq   #0,D1
            bra.b   .L2
.L1:
            move.w  D1,(A1)
            move.l  (A0),(2,A1)
            move.w  (4,A0),(6,A1)
            adda.w  #$10,A0
            addq.l  #8,A1
            addq.w  #1,D1
.L2:
            dbra    D3,.L1
.L3:
            moveq   #0,D0
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #8
            dc.w    0
CLEARONE:
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l (8,A6),A0
            move.l  ($C,A0),D0
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            movea.l (4,A6),A1
            lea     ($38,A1),A2
            adda.w  #$138,A1
.L1:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            movea.l (0,A2,D1.w*8),A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D2
            bhi.b   .L2
            clr.w   (8,A0,D2.w*8)
.L2:
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A1,D1.l*4),A0
            move.w  (A0),D0
            clr.l   (A0)
            tst.w   D0
            bmi.b   .L1
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
            dc.w    0
CopyPalette:
            link.w  A6,#-2
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($DC8).w,A4
            cmpa.w  #$FFFF,A4
            beq.w   .L8
            movea.l ($E,A6),A2
            cmpa.w  #0,A2
            beq.w   .L8
            movea.l ($12,A6),A3
            cmpa.w  #0,A3
            beq.w   .L8
            cmpa.l  A2,A3
            beq.w   .L8
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.w   .L8
            move.l  D0,D3
            add.w   ($C,A6),D0
            movea.l (A3),A1
            move.w  (A1),D1
            sub.w   D0,D1
            bpl.b   .L1
            add.w   D1,D3
.L1:
            movea.l (A2),A0
            move.w  (A0),D4
            move.w  ($A,A6),D0
            add.w   D3,D0
            cmp.w   D4,D0
            ble.b   .L4
            move.w  D0,D4
            movea.l A2,A0
            addq.w  #1,D0
            asl.w   #4,D0
            _SetHandleSize
            bne.w   .L8
            movea.l (A2),A0
            move.w  D4,D2
            moveq   #0,D1
            move.w  (A0),D1
            sub.w   D1,D2
            move.w  D4,(A0)
            lea     ($10,A0),A1
            asl.w   #4,D1
            adda.l  D1,A1
            bra.b   .L3
.L2:
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
.L3:
            dbra    D2,.L2
.L4:
            cmpa.l  A2,A3
            beq.b   .L8
            move.l  A3,-(SP)
            bsr.w   DIRTYSEEDS
            movea.l (A3),A1
            moveq   #0,D0
            move.w  ($A,A6),D0
            asl.l   #4,D0
            movea.l (A2),A0
            lea     ($10,A0,D0.w),A0
            moveq   #0,D1
            move.w  ($C,A6),D0
            asl.l   #4,D0
            lea     ($10,A1,D0.w),A1
            bra.b   .L7
.L5:
            move.l  ($C,A0),D0
            beq.b   .L6
            movem.l A0-A1,-(SP)
            move.l  A0,-(SP)
            move.l  (A4),-(SP)
            jsr     CLEARONE
            movem.l (SP)+,A0-A1
.L6:
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.w  (8,A1),(8,A0)
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            adda.w  #$10,A0
            adda.w  #$10,A1
.L7:
            dbra    D3,.L5
.L8:
            moveq   #0,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #$E
            ds.b    10
UPDATEDEVICE:
            link.w  A6,#-$E
            movem.l D0-D3/A0-A3,-(SP)
            subq.w  #4,SP
            jsr     ([$1290.w])
            move.l  (SP)+,D3
            pea     (-4,A6)
            jsr     ([$FD0.w])
            movea.l ($DC8).w,A1
            movea.l (A1),A1
            move.w  (8,A6),D0
            movea.l ($38,A1,D0.w*8),A2
            movea.l A2,A0
            jsr     DEVSETENTRIES
            movea.l (A2),A0
            lea     ($22,A0),A2
            move.w  ($14,A0),D0
            btst    #$B,D0
            beq.b   .L1
            move.l  MenuList,D0
            beq.b   .L1
            movea.l D0,A0
            tst.l   (A0)
            beq.b   .L1
            jsr     ([$12DC.w])
.L1:
            moveq   #0,D0
            movea.l ($DCC).w,A0
            move.l  A0,D1
            bne.b   .L2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            move.l  A0,D1
            beq.b   .L3
.L2:
            movea.l (A0),A0
            move.w  (6,A0),D0
            andi.w  #$C000,D0
.L3:
            move.w  D0,(-$E,A6)
            jsr     CHECKFORJUGGLER
            bne.b   .L4
            move.l  A2,-(SP)
            move.w  (8,A6),-(SP)
            move.w  (-$E,A6),-(SP)
            move.w  #$25,-(SP)
            _OSDispatch
            bra.w   .L11
.L4:
            movea.l WindowList,A3
            cmpa.w  #$FFFF,A3
            beq.w   .L11
            bra.w   .L10
.L5:
            move.w  (-$E,A6),D1
            move.w  #$E,D0
            cmpa.l  D3,A3
            bne.b   .L6
            move.w  #$F,D0
.L6:
            tst.b   ($6E,A3)
            beq.w   .L9
            tst.w   (6,A3)
            bpl.b   .L7
            movea.l (8,A3),A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            cmpa.w  #0,A0
            beq.b   .L7
            movea.l (A0),A0
            move.w  (6,A0),D1
.L7:
            btst    D0,D1
            beq.b   .L9
            lea     (2,A3),A0
            tst.w   (4,A0)
            bpl.b   .L8
            movea.l (A0),A0
            movea.l (A0),A0
.L8:
            lea     (6,A0),A0
            move.w  (A2),D0
            add.w   (A0),D0
            cmp.w   ($14,A3),D0
            bge.b   .L9
            move.w  D0,(-$C,A6)
            move.w  (2,A2),D0
            add.w   (2,A0),D0
            cmp.w   ($16,A3),D0
            bge.b   .L9
            move.w  D0,(-$A,A6)
            move.w  (4,A2),D0
            add.w   (A0),D0
            cmp.w   ($10,A3),D0
            ble.b   .L9
            move.w  D0,(-8,A6)
            move.w  (6,A2),D0
            add.w   (2,A0),D0
            cmp.w   ($12,A3),D0
            ble.b   .L9
            move.w  D0,(-6,A6)
            move.l  A3,-(SP)
            jsr     ([$FCC.w])
            pea     (-$C,A6)
            jsr     ([$12A0.w])
.L9:
            movea.l ($90,A3),A3
.L10:
            cmpa.w  #0,A3
            bne.w   .L5
            bsr.w   REDRAWDESKTOP
.L11:
            move.l  (-4,A6),-(SP)
            jsr     ([$FCC.w])
            moveq   #0,D0
            movem.l (SP)+,D0-D3/A0-A3
            unlk    A6
            rtd     #2
            ds.b    10
UPDATEDEVICES:
            movem.l D0-D1/A0,-(SP)
            cmpi.l  #$FFFFFFFF,WindowList
            beq.b   .L3
            cmpi.l  #$FFFFFFFF,($910).w
            beq.b   .L3
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            subq.w  #1,D0
            move.l  ($14,A0),D1
            beq.b   .L3
            clr.l   ($14,A0)
.L1:
            btst    D0,D1
            beq.b   .L2
            move.w  D0,-(SP)
            jsr     UPDATEDEVICE
.L2:
            dbra    D0,.L1
            moveq   #$11,D0
            _PaletteDispatch
.L3:
            movem.l (SP)+,D0-D1/A0
            rts
            ds.b    12
WHATPAL:
            tst.w   (6,A2)
            bpl.b   .L1
            movea.l (8,A2),A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
            bne.b   .L2
.L1:
            move.l  ($DCC).w,D0
            bne.b   .L2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
.L2:
            movea.l D0,A0
            tst.l   D0
            rts
            ds.b    8
CALCDEVS:
            movem.l D3-D7/A2-A3,-(SP)
            subq.w  #8,SP
            movea.l WindowList,A2
            moveq   #0,D3
            moveq   #0,D4
            clr.l   -(SP)
            jsr     ([$1290.w])
            move.l  (SP)+,D6
            bra.w   .L8
.L1:
            tst.b   ($6E,A2)
            bsr.w   WHATPAL
            cmpa.l  (-8,A6),A0
            bne.w   .L7
            lea     (2,A2),A0
            tst.w   (4,A0)
            bpl.w   .L2
            movea.l (A0),A0
            movea.l (A0),A0
.L2:
            move.l  (6,A0),D0
            move.l  ($10,A2),D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            move.l  D1,(-$38,A6)
            move.l  ($14,A2),D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            swap    D1
            move.l  D1,(-$34,A6)
            movea.l (-$12,A6),A0
            move.w  (A0),D5
            subq.w  #1,D5
            lea     ($38,A0),A3
.L3:
            movea.l (0,A3,D5.w*8),A0
            movea.l (A0),A0
            clr.w   -(SP)
            pea     ($22,A0)
            pea     (-$38,A6)
            pea     ($A,SP)
            jsr     ([$10A8.w])
            tst.w   (SP)+
            beq.b   .L6
            bset    D5,D3
            tst.b   ($6F,A2)
            beq.b   .L6
            cmp.l   A2,D6
            bne.b   .L4
            move.l  A2,(4,A3,D5.w*8)
            bra.b   .L5
.L4:
            cmpa.l  (4,A3,D5.w*8),A2
            bne.b   .L6
.L5:
            bset    D5,D4
.L6:
            dbra    D5,.L3
.L7:
            movea.l ($90,A2),A2
.L8:
            move.l  A2,D0
            bne.w   .L1
            move.l  D3,(-$2C,A6)
            move.l  D4,(-$30,A6)
            addq.l  #8,SP
            movem.l (SP)+,D3-D7/A2-A3
            rts
            ds.b    8
UNHOOKDEVICE:
            link.w  A6,#-$74
            movem.l D2-D4/A2,-(SP)
            movea.l ($DC8).w,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L4
            movea.l (A0),A0
            move.w  (A0),D3
            lea     ($38,A0),A1
            move.l  (8,A6),D1
            subq.w  #1,D3
.L1:
            cmp.l   (0,A1,D3.w*8),D1
            beq.b   .L2
            dbra    D3,.L1
            bra.b   .L4
.L2:
            lsl.w   #8,D3
            movea.l D1,A2
            movea.l (A2),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            move.w  #$FF,D4
.L3:
            move.b  D4,D3
            move.w  D3,-(SP)
            bsr.w   ZAPLINKS
            dbra    D4,.L3
            subq.w  #2,SP
            move.l  D1,-(SP)
            jsr     CHECKDEVICECOLORS
            tst.w   (SP)+
            beq.b   .L4
            moveq   #0,D0
            lsr.w   #8,D3
            bset    D3,D0
            or.l    D0,($10,A0)
            move.w  #1,-(SP)
            jsr     SCATTERDEVICES
            move.w  D3,-(SP)
            jsr     UPDATEDEVICE
.L4:
            movem.l (SP)+,D2-D4/A2
            unlk    A6
            rtd     #4
            ds.b    4
UNRESERVEDEVICES:
            movem.l D1-D4/A2-A4,-(SP)
            lea     ($138,A0),A2
            move.w  (A1),D1
            lea     ($10,A1),A3
            moveq   #0,D4
            bra.b   .L5
.L1:
            move.w  ($C,A3),D2
            bpl.b   .L4
.L2:
            bfextu  D2{19:5},D3
            btst    D3,D0
            beq.b   .L3
            bset    D3,D4
            move.w  D2,-(SP)
            jsr     ZAPLINKS
            movea.l ($38,A0,D3.w*8),A4
            bfextu  D2{24:8},D3
            movea.l (A4),A4
            movea.l ($16,A4),A4
            movea.l (A4),A4
            movea.l ($2A,A4),A4
            movea.l (A4),A4
            cmp.w   (6,A4),D3
            bhi.b   .L3
            move.w  #$1000,(8,A4,D3.w*8)
.L3:
            andi.w  #$1FFF,D2
            move.w  (0,A2,D2.w*4),D2
            bmi.b   .L2
.L4:
            lea     ($10,A3),A3
.L5:
            dbra    D1,.L1
            or.l    D4,($10,A0)
            movem.l (SP)+,D1-D4/A2-A4
            rts
            ds.b    10
ZAPLINKS:
            link.w  A6,#0
            movem.l D0-D4/A0-A2,-(SP)
            movea.l ($DC8).w,A1
            movea.l (A1),A1
            lea     ($138,A1),A0
            movea.l (4,A1),A2
            movea.l (A2),A2
            move.w  (8,A6),D0
            andi.w  #$1FFF,D0
            move.w  D0,D1
            lsr.w   #8,D1
            movea.l ($38,A1,D1.w*8),A1
            movea.l (A1),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.l  ($2A,A1),D1
            beq.b   .L1
            movea.l D1,A1
            movea.l (A1),A1
            clr.w   D1
            move.b  D0,D1
            cmp.w   (6,A1),D0
            bhi.b   .L1
            bclr    #6,(8,A1,D1.w*8)
.L1:
            move.w  (0,A0,D0.w*4),D3
            beq.w   .L10
            move.w  (2,A0,D0.w*4),D4
            clr.l   (0,A0,D0.w*4)
            tst.w   D3
            bmi.b   .L2
            tst.w   D4
            bmi.b   .L5
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
            movea.l (0,A2,D3.w*8),A0
            movea.l (A0),A0
            andi.l  #$1FFF,D4
            lsl.l   #4,D4
            clr.l   ($1C,A0,D4.l)
            bra.w   .L10
.L2:
            tst.w   D4
            bmi.b   .L7
            move.w  D3,D0
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D4,(2,A1)
            move.w  (A1),D3
            bpl.b   .L4
.L3:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D3
            bmi.b   .L3
.L4:
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
            movea.l (0,A2,D3.w*8),A0
            movea.l (A0),A0
            andi.l  #$1FFF,D4
            lsl.l   #4,D4
            move.w  D0,($1C,A0,D4.l)
            bra.b   .L10
.L5:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D3,(A1)
            move.w  (2,A1),D4
            bpl.b   .L9
.L6:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (2,A0,D1.l*4),D4
            bmi.b   .L6
            bra.b   .L9
.L7:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D3,(A1)
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D4,(2,A1)
            move.w  (A1),D3
            bpl.b   .L9
.L8:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D3
            bmi.b   .L8
.L9:
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
.L10:
            movem.l (SP)+,D0-D4/A0-A2
            unlk    A6
            rtd     #2
            ds.b    10
RESIZEPALETTE:
            link.w  A6,#0
            movem.l D3-D4/A2,-(SP)
            movea.l ($A,A6),A0
            move.l  A0,D0
            addq.l  #1,D0
            bne.b   .L1
            movea.l ($DCC).w,A0
.L1:
            movea.l (A0),A2
            move.w  (8,A6),D3
            move.w  (A2),D4
            cmp.w   D4,D3
            beq.b   .L6
            bhi.b   .L4
            _HLock
            movea.l (A0),A2
            move.w  D4,D0
            lsl.w   #4,D0
            lea     ($10,A2,D0.w),A2
.L2:
            suba.w  #$10,A2
            subq.w  #1,D4
            move.w  (6,A2),D0
            andi.w  #6,D0
            beq.b   .L3
            move.l  ($A,A6),-(SP)
            move.w  D4,-(SP)
            clr.l   -(SP)
            jsr     ([$1878.w])
.L3:
            cmp.w   D4,D3
            bne.b   .L2
            movea.l ($A,A6),A0
            _HUnlock
.L4:
            move.w  D3,D0
            ext.l   D0
            lsl.l   #4,D0
            addi.l  #$10,D0
            _SetHandleSize
            bne.b   .L6
            movea.l (A0),A2
            move.w  D3,(A2)
            cmp.l   D3,D4
            bcc.b   .L6
            sub.l   D4,D3
            lsl.w   #4,D4
            lea     ($10,A2,D4.w),A0
            lsl.w   #2,D3
            subq.w  #1,D3
.L5:
            clr.l   (A0)+
            dbra    D3,.L5
.L6:
            movem.l (SP)+,D3-D4/A2
            unlk    A6
            rtd     #6
            ds.b    4
RESTOREDEVICECLUT:
            tst.l   (4,SP)
            bne.w   UNHOOKDEVICE
            move.l  A3,-(SP)
            move.l  DeviceList,D0
            bra.b   .L2
.L1:
            movea.l D0,A3
            move.l  A3,-(SP)
            jsr     UNHOOKDEVICE
            movea.l (A3),A3
            move.l  ($1E,A3),D0
.L2:
            bne.b   .L1
            movea.l (SP)+,A3
            rtd     #4
            ds.b    10
NEWHILITECOLOR:
            move.l  ($DC8).w,D1
            beq.b   .L3
            movea.l D1,A1
            movea.l (A1),A1
            move.l  ($24,A1),D0
            beq.b   .L1
            clr.l   ($24,A1)
            movea.l D0,A0
            _DisposHandle
.L1:
            movea.l D1,A1
            movea.l (A1),A1
            move.l  ($2C,A1),D0
            beq.b   .L2
            clr.l   ($2C,A1)
            movea.l D0,A0
            _DisposHandle
.L2:
            jsr     CHECKALLDEVICECLUTS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            jsr     UPDATEDEVICES
.L3:
            rts
            ds.b    6
SAVEFORE:
            moveq   #0,D0
            bra.b   SAVEBACK.L1
SAVEBACK:
            moveq   #1,D0
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L4
            move.l  (8,A0),D1
            beq.b   .L4
            movea.l D1,A0
            movea.l (A0),A0
            btst    D0,($19,A0)
            beq.b   .L4
            move.w  #1,(A1)
            tst.w   D0
            beq.b   .L2
            move.w  ($16,A0),(2,A1)
            bra.b   .L3
.L2:
            move.w  ($10,A0),(2,A1)
.L3:
            rtd     #4
.L4:
            clr.w   (A1)
            pea     (2,A1)
            tst.w   D0
            beq.b   .L5
            jsr     ([$1668.w])
            bra.b   .L3
.L5:
            jsr     ([$1664.w])
            bra.b   .L3
            ds.b    8
RESTOREFORE:
            movea.l (4,SP),A1
            tst.w   (A1)+
            bne.b   .L2
            pea     (A1)
            jsr     ([$1650.w])
.L1:
            rtd     #4
.L2:
            move.w  (A1),-(SP)
            jsr     ([$185C.w])
            bra.b   .L1
RESTOREBACK:
            movea.l (4,SP),A1
            tst.w   (A1)+
            bne.b   .L1
            pea     (A1)
            jsr     ([$1654.w])
            bra.b   RESTOREFORE.L1
.L1:
            move.w  (A1),-(SP)
            jsr     ([$1860.w])
            bra.b   RESTOREFORE.L1
            ds.b    6
REINSTANTIATECOLORS:
            movem.l D3-D4/A2-A4,-(SP)
            movem.l (SP)+,D3-D4/A2-A4
            rts
            ds.b    6
RELEASELIST:
            tst.l   ($DC8).w
            beq.b   .L5
            movem.l D3-D4/A2,-(SP)
            movea.l ($10,SP),A2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            lea     ($38,A0),A0
            clr.w   D3
            move.l  TheGDevice,D1
.L1:
            cmp.l   (0,A0,D3.w*8),D1
            beq.b   .L2
            addq.w  #1,D3
            cmp.w   D0,D3
            bcs.b   .L1
            bra.b   .L4
.L2:
            lsl.w   #8,D3
            move.w  (A2)+,D4
.L3:
            move.w  (A2)+,D0
            move.b  D0,D3
            move.w  D3,-(SP)
            bsr.w   ZAPLINKS
            dbra    D4,.L3
.L4:
            movem.l (SP)+,D3-D4/A2
.L5:
            rtd     #4
            ds.b    8
.L6:
            dc.b    $EE,$B0,$EF,$90,$FE,$90,$FE
            ds.b    13
            dc.w    $D1E0,$FEC0,$E090,$FF00,$FF04,$FF60,$FF7E,$FFA0
            dc.w    $FFB0
PMgrDispatch:
            cmpi.b  #$13,D0
            bcc.b   .L1
            lea     RELEASELIST.L6,A0
            move.w  (0,A0,D0.w*2),D0
            beq.b   .L1
            adda.w  D0,A0
            jmp     (A0)
.L1:
            lsr.w   #8,D0
            movea.l (SP)+,A0
            adda.w  D0,SP
            moveq   #-1,D0
            jmp     (A0)
            ds.b    12
