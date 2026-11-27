OneBitCTable:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            moveq   #$18,D0
            jsr     RSetHSize
            movea.l (A0),A0
FillOneBit:
            moveq   #1,D1
            move.l  D1,(A0)+
            move.l  D1,(A0)+
            clr.w   (A0)+
            moveq   #-1,D0
            move.l  D0,(A0)+
            move.w  D0,(A0)+
            swap    D1
            move.l  D1,(A0)+
            clr.l   (A0)+
            jmp     (A1)
            ds.b    14
PortToMap:
            addq.w  #2,A0
BitsToMap:
            tst.w   (4,A0)
            bpl.b   .L1
            btst    #$E,(4,A0)
            beq.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
            ds.b    10
OpenCPort:
            move.l  (4,SP),-(SP)
            move.l  (SP),-(SP)
            jsr     NewPort
            jsr     InsPortList
            clr.l   -(SP)
            move.w  #$32,-(SP)
            jsr     NewHandle
            movea.l (8,SP),A0
            move.l  (SP)+,(2,A0)
            clr.l   ($20,A0)
            clr.l   ($3A,A0)
            clr.l   ($3E,A0)
            clr.l   (8,A0)
            move.w  #$C000,(6,A0)
InitCPort:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            tst.w   (6,A2)
            bpl.w   .L2
            jsr     InitShared
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (2,A2),A1
            movea.l (A1),A1
            move.w  #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            move.l  A2,-(SP)
            jsr     INITCOLORSTUFF
.L2:
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
INITCOLORSTUFF:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  SP,-(SP)
            pea     ($20,A2)
            jsr     ([$1A44.w])
            not.l   (SP)
            not.l   (4,SP)
            move.l  SP,-(SP)
            pea     ($3A,A2)
            jsr     ([$1A44.w])
            move.l  SP,-(SP)
            pea     ($3E,A2)
            jsr     ([$1A44.w])
            addq.w  #8,SP
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            move.l  #$8000,($C,A2)
            tst.l   (8,A2)
            bne.b   .L1
            moveq   #$1A,D0
            jsr     RNewHandle
            move.l  A0,(8,A2)
.L1:
            movea.l ([8.w,A2]),A0
            clr.l   (A0)+
            clr.w   (A0)+
            move.l  ($DA0).w,(A0)+
            move.w  ($DA4).w,(A0)+
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            dc.w    0
CloseCPort:
ClosePort:
            move.l  (4,SP),-(SP)
            jsr     DelPortList
            movea.l (4,SP),A0
            movea.l ($1C,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            movea.l ($18,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            tst.w   (6,A0)
            bpl.b   .L7
            moveq   #-1,D0
            tst.l   ($20,A0)
            beq.b   .L1
            addq.w  #1,D0
            move.l  ($20,A0),-(SP)
.L1:
            tst.l   ($3A,A0)
            beq.b   .L2
            addq.w  #1,D0
            move.l  ($3A,A0),-(SP)
.L2:
            tst.l   ($3E,A0)
            beq.b   .L3
            addq.w  #1,D0
            move.l  ($3E,A0),-(SP)
.L3:
            tst.w   D0
            bmi.b   .L6
.L4:
            movea.l (SP)+,A0
            tst.w   ([A0])
            bne.b   .L5
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jsr     ([$1620.w])
            move.w  (SP)+,D0
.L5:
            dbra    D0,.L4
.L6:
            movea.l (4,SP),A0
            movea.l (2,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            movea.l (8,A0),A0
            _DisposHandle
.L7:
            rtd     #4
SETCPORTPIX:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L1
            move.l  (4,SP),(2,A0)
.L1:
            rtd     #4
            ds.b    12
NEWCTAB:
            clr.l   -(SP)
            move.w  #$18,-(SP)
            jsr     NewHandle
            move.l  (SP)+,(4,SP)
            rts
DisposCTable:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            _DisposHandle
.L1:
            jmp     (A1)
            ds.b    4
GETCTSEED:
            move.l  D0,-(SP)
            move.l  TableSeed,D0
            addq.l  #1,D0
            bmi.b   .L1
            cmpi.l  #$3FF,D0
            bgt.b   .L1
            move.l  #$3FF,D0
.L1:
            move.l  D0,TableSeed
            move.l  (SP)+,D0
            move.l  TableSeed,(4,SP)
            rts
            ds.b    10
OpenPixMap:
            clr.l   -(SP)
            move.w  #$32,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            jsr     NEWCTAB
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.l  A0,(4,SP)
            movea.l (A0),A0
            move.l  D0,($2A,A0)
            rts
NewPixMap:
            clr.l   -(SP)
            jsr     OpenPixMap
            move.l  (SP),(8,SP)
            jsr     InitPixMap
            rts
DisposPixMap:
            move.l  (4,SP),D0
            beq.b   .L2
            movea.l D0,A1
            movea.l (A1),A1
            move.l  ($2A,A1),D0
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     ([$1690.w])
.L1:
            movea.l (4,SP),A0
            _DisposHandle
.L2:
            move.l  (SP)+,(SP)
            rts
            ds.b    14
InitPixMap:
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            move.l  ($2A,A1),-(SP)
            move.l  A1,-(SP)
            moveq   #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            movea.l (SP)+,A1
            move.l  (SP)+,($2A,A1)
            ori.w   #$8000,(4,A1)
            move.l  (SP)+,(SP)
            rts
CopyPixMap:
            movea.l (8,SP),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            moveq   #$14,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            move.l  (4,A0),(4,A1)
            move.l  (A0),-(SP)
            move.l  (A1),-(SP)
            jsr     ([$1A14.w])
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    6
BitsToPix:
            moveq   #0,D2
            move.w  (4,A1),D0
            bpl.b   .L2
            btst    #$E,D0
            beq.b   .L1
            movea.l (A1),A1
            movea.l (A1),A1
.L1:
            move.l  (6,A1),D1
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            move.l  (A0),D0
            cmp.l   (A1),D0
            bne.w   COPYPMAP
            bra.b   .L3
.L2:
            move.l  (6,A1),D1
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            move.l  (A0),D0
            cmp.l   (A1),D0
            bne.b   .L6
.L3:
            moveq   #1,D2
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0)+,(A2)+
            move.w  (A0)+,(A2)+
            cmp.l   ($A,A1),D1
            bne.b   .L4
            move.l  D1,(A2)+
            move.l  D1,(A2)+
            addq.l  #8,A0
            bra.b   .L5
.L4:
            move.l  (A0)+,D0
            add.w   D1,D0
            swap    D0
            swap    D1
            add.w   D1,D0
            swap    D0
            move.l  D0,(A2)+
            move.l  (A0)+,D0
            swap    D0
            add.w   D1,D0
            swap    D0
            swap    D1
            add.w   D1,D0
            move.l  D0,(A2)+
.L5:
            movea.l A0,A1
            bra.b   COPYPMAP.L3
.L6:
            lea     OneBitData,A0
            pea     PUTONETABLE
            move.l  (A1),D0
            jsr     ([$644.w])
            move.l  D0,(A2)+
            exg     A0,A1
            lea     ($E,A1),A1
            addq.w  #4,A0
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            mulu.w  ($12,A1),D0
            ori.w   #$8000,D0
            move.w  D0,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            bra.b   COPYPMAP.L3
PUTONETABLE:
            move.l  A2,(-8,A2)
            lea     (4,A2),A0
            move.l  A0,(A2)
            movea.l (SP)+,A1
            jmp     FillOneBit
.L1:
            movea.l (A1)+,A0
            btst    #1,D0
            beq.b   .L2
            movea.l (A0),A0
.L2:
            btst    #2,D0
            exg     D0,A0
            beq.b   COPYPMAP.L1
            bra.b   COPYPMAP.L2
COPYPMAP:
            move.w  ($E,A1),D0
            bne.b   PUTONETABLE.L1
            move.l  (A1)+,D0
.L1:
            jsr     ([$644.w])
.L2:
            move.l  D0,(A2)+
            move.w  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
.L3:
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            rts
OneBitData:
            ds.b    23
            dc.b    $48,$00,$00,$00,$48
            ds.b    5
            dc.b    $01,$00,$01,$00,$01
            ds.b    12
ShftTbl:
            dc.b    $00,$00,$01,$00,$02,$00,$00,$00,$03
            ds.b    7
            dc.b    $04
            ds.b    15
            dc.b    $05
            ds.b    9
SetCPixel:
            link.w  A6,#-$18
            pea     (-$12,A6)
            jsr     ([$1060.w])
            pea     (-$18,A6)
            jsr     ([$1664.w])
            move.l  (8,A6),-(SP)
            jsr     ([$1650.w])
            jsr     ([$1078.w])
            move.l  ($C,A6),-(SP)
            jsr     ([$104C.w])
            clr.l   -(SP)
            jsr     ([$1048.w])
            pea     (-$18,A6)
            jsr     ([$1650.w])
            pea     (-$12,A6)
            jsr     ([$1064.w])
            unlk    A6
            rtd     #8
            ds.b    12
HiliteColor:
            moveq   #6,D0
            bra.b   SETGRAFVARSCOMMON
            ds.b    12
OPCOLOR:
            moveq   #0,D0
SETGRAFVARSCOMMON:
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L1
            movea.l ([8.w,A0]),A0
            adda.w  D0,A0
            move.l  (A1)+,(A0)+
            move.w  (A1),(A0)
.L1:
            movea.l D2,A0
            jmp     (A0)
