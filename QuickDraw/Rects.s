StdRect:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            moveq   #$30,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  (8,A6),-(SP)
            jsr     PutPicRect
.L1:
            pea     StdDraw_Rects
            pea     GetRect_Rects
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
GetRect_Rects:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Rects:
            move.l  (8,A6),-(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     PUTRECT
.L1:
            jsr     FrmRect
            bra.b   .L3
.L2:
            jsr     ([$1A60.w])
            jsr     DrawRect
.L3:
            rts
            ds.b    12
STDDEVLOOP:
            link.w  A6,#-$26
            clr.l   (-$C,A6)
            movea.l DeviceList,A0
            movea.l (A0),A0
            tst.l   ($1E,A0)
            beq.w   .L10
            clr.w   (-$E,A6)
            movea.l A3,A0
            jsr     ([$1A5C.w])
            move.l  A0,(-$22,A6)
            move.l  (A0),D0
            movea.l MainDevice,A0
            movea.l (A0),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            cmp.l   (A1),D0
            bne.w   .L10
            move.b  HiliteMode,(-$24,A6)
            move.l  ($30,A3),(-$12,A6)
            move.w  ($E,A3),(-$26,A6)
            move.l  SrcDevice,-(SP)
            move.l  TheGDevice,-(SP)
            move.l  ($64,A3),-(SP)
            move.l  ($60,A3),-(SP)
            movea.l ($2A,A1),A0
            movea.l (A0),A0
            move.l  (A0),(-$16,A6)
            move.l  ($50,A3),(-$1A,A6)
            move.l  ($54,A3),(-$1E,A6)
            move.l  A6,-(SP)
            movea.l (8,A6),A0
            pea     (-8,A6)
            movea.l (A6),A6
            jsr     (A0)
            movea.l (SP)+,A6
            lea     (-8,A6),A0
            movea.l (-$22,A6),A1
            move.l  (6,A1),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A0)+
            bvc.b   .L1
            jsr     ([$1A58.w])
.L1:
            sub.w   D0,(A0)+
            bvc.b   .L2
            jsr     ([$1A58.w])
.L2:
            sub.w   D1,(A0)+
            bvc.b   .L3
            jsr     ([$1A58.w])
.L3:
            sub.w   D0,(A0)+
            bvc.b   .L4
            jsr     ([$1A58.w])
.L4:
            movea.l DeviceList,A0
.L5:
            movea.l (A0),A1
            tst.w   ($14,A1)
            bpl.w   .L12
            move.l  A0,TheGDevice
            move.l  A0,SrcDevice
            move.l  A0,(-$C,A6)
            lea     ($22,A1),A0
            lea     (-8,A6),A1
            move.l  (A1)+,D0
            move.l  (A1)+,D1
            swap    D1
            cmp.w   (A0)+,D1
            ble.w   .L11
            swap    D1
            cmp.w   (A0)+,D1
            ble.w   .L11
            swap    D0
            cmp.w   (A0)+,D0
            bge.w   .L11
            swap    D0
            cmp.w   (A0)+,D0
            bge.w   .L11
            move.b  (-$24,A6),HiliteMode
            move.l  (-$12,A6),($30,A3)
            tst.w   (6,A3)
            bpl.w   .L10
            move.w  (-$26,A6),($E,A3)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            cmp.l   (-$16,A6),D0
            beq.b   .L10
            move.l  D0,(-$16,A6)
            subq.w  #6,SP
            clr.l   -(SP)
            move.l  (8,A3),D0
            beq.b   .L6
            movea.l D0,A0
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .L6
            move.w  ($18,A0),D2
            move.w  ($16,A0),(2,SP)
            btst    #1,D2
            sne     (SP)
            btst    #0,D2
            beq.b   .L6
            move.w  ($10,A0),-(SP)
            jsr     ([$185C.w])
            bra.b   .L7
.L6:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
.L7:
            tst.b   (SP)
            beq.b   .L8
            move.w  (2,SP),-(SP)
            jsr     ([$1860.w])
            bra.b   .L9
.L8:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
.L9:
            lea     ($A,SP),SP
.L10:
            movea.l ($C,A6),A0
            move.l  A6,-(SP)
            movea.l (A6),A6
            jsr     (A0)
            movea.l (SP)+,A6
            st      (-$E,A6)
            move.l  (-$C,A6),D0
            beq.b   .L13
            clr.l   ($60,A3)
            clr.l   ($64,A3)
.L11:
            movea.l (-$C,A6),A0
            movea.l (A0),A1
.L12:
            move.l  ($1E,A1),D0
            movea.l D0,A0
            bne.w   .L5
            clr.l   (-$C,A6)
            move.l  (SP)+,($60,A3)
            move.l  (SP)+,($64,A3)
            move.l  (SP)+,TheGDevice
            move.l  (SP)+,SrcDevice
            move.l  (-$1A,A6),($50,A3)
            move.l  (-$1E,A6),($54,A3)
            tst.w   (-$E,A6)
            beq.b   .L10
.L13:
            bset    #7,HiliteMode
            unlk    A6
            rtd     #8
            ds.b    10
PINIT:
            tst.w   (-2,A0)
            bpl.b   .L1
            move.w  #$7FFE,(-2,A0)
            rts
.L1:
            move.w  #$8002,(-2,A0)
            rts
            ds.b    10
PUSHVERB:
            movea.l (SP)+,A0
            move.w  #8,-(SP)
            cmpi.b  #1,D7
            ble.b   .L5
            cmpi.b  #3,D7
            blt.b   .L3
            beq.b   .L4
            lea     ($28,A3),A1
            tst.w   (6,A3)
            bpl.b   .L2
.L1:
            lea     ($3E,A3),A1
.L2:
            move.l  A1,-(SP)
            bra.b   .L6
.L3:
            pea     ($20,A3)
            bra.b   .L6
.L4:
            addq.w  #2,(SP)
            lea     (-$10,A4),A1
            tst.w   (6,A3)
            bpl.b   .L2
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            moveq   #0,D0
            jsr     ([$1A8C.w])
            movea.l (SP)+,A0
            bra.b   .L1
.L5:
            move.w  ($38,A3),D0
            or.w    D0,(SP)
            pea     ($3A,A3)
.L6:
            jmp     (A0)
            ds.b    12
FillRect:
            moveq   #0,D0
            bra.b   FillCRect.L1
FillCRect:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
            bra.b   CallRect
FrameRect:
            moveq   #0,D0
            bra.b   CallRect
PaintRect:
            moveq   #1,D0
            bra.b   CallRect
EraseRect:
            moveq   #2,D0
            bra.b   CallRect
InvertRect:
            moveq   #3,D0
CallRect:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1080).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (8,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DrawRect:
            link.w  A6,#0
            movea.l (A5),A0
            movea.l (A0),A1
            tst.w   ($42,A1)
            blt.b   .L1
            pea     (2,A1)
            clr.l   -(SP)
            pea     (2,A1)
            move.l  ($E,A6),-(SP)
            clr.l   -(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            ori.w   #8,(SP)
            move.l  (8,A6),-(SP)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  (-$82,A0),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
.L1:
            unlk    A6
            rtd     #$A
            ds.b    8
FrmRect:
            link.w  A6,#-$1C
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            blt.w   DORECT.L2
            movea.l (8,A6),A1
            move.l  (A1)+,(-$1C,A6)
            move.l  (A1)+,(-$18,A6)
            lea     (-$1C,A6),A1
            move.w  ($36,A0),D2
            move.w  (2,A1),D0
            move.w  D0,(-2,A6)
            add.w   D2,D0
            move.w  D0,(-4,A6)
            move.w  (6,A1),D1
            move.w  D1,(-$A,A6)
            sub.w   D2,D1
            move.w  D1,(-6,A6)
            cmp.w   D1,D0
            bge.b   .L1
            move.w  ($34,A0),D2
            move.w  (A1),D0
            move.w  D0,(-$C,A6)
            add.w   D2,D0
            move.w  D0,(-$E,A6)
            move.w  (4,A1),D1
            move.w  D1,(-$14,A6)
            sub.w   D2,D1
            move.w  D1,(-$10,A6)
            cmp.w   D1,D0
            bge.b   .L1
            move.w  (-2,A6),(-$1A,A6)
            move.w  (-6,A6),(-$16,A6)
            move.w  (-$C,A6),(-$1C,A6)
            move.w  (-$E,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-6,A6),(-$1A,A6)
            move.w  (-$A,A6),(-$16,A6)
            move.w  (-$10,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-4,A6),(-$1A,A6)
            move.w  (-$10,A6),(-$1C,A6)
            move.w  (-$14,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-2,A6),(-$1A,A6)
            move.w  (-4,A6),(-$16,A6)
            move.w  (-$E,A6),(-$1C,A6)
.L1:
            bra.b   DORECT.L1
DORECT:
            move.b  HiliteMode,-(SP)
            movea.l (A5),A0
            movea.l (A0),A1
            pea     (2,A1)
            clr.l   -(SP)
            pea     (2,A1)
            pea     (-$1C,A6)
            clr.l   -(SP)
            pea     (-$1C,A6)
            move.w  ($38,A1),-(SP)
            ori.w   #8,(SP)
            pea     ($3A,A1)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  (-$82,A0),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            move.b  (SP)+,HiliteMode
            rts
.L1:
            bsr.b   DORECT
            bset    #7,HiliteMode
.L2:
            unlk    A6
            rtd     #4
            ds.b    4
SetRect:
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,(A1)+
            move.l  D1,(A1)+
            jmp     (A0)
            dc.w    0
EqualRect:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            move.b  #1,(SP)
            bra.b   .L2
.L1:
            clr.b   (SP)
.L2:
            move.l  D0,-(SP)
            rts
            ds.b    6
EmptyRect:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            cmp.w   (A0)+,D0
            bge.b   .L1
            cmp.w   (A0)+,D1
            bge.b   .L1
            clr.b   (SP)
            bra.b   .L2
.L1:
            move.b  #1,(SP)
.L2:
            jmp     (A1)
            ds.b    6
OffsetRect:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            jmp     (A0)
            ds.b    14
InsetRect:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            sub.w   D1,(A1)+
            sub.w   D0,(A1)+
            jmp     (A0)
            ds.b    14
SectRect:
            link.w  A6,#0
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.w  #2,-(SP)
            move.l  (8,A6),-(SP)
            bsr.b   RSECT
            sne     ($14,A6)
            neg.b   ($14,A6)
            unlk    A6
            rtd     #$C
RSECT:
            link.w  A6,#0
            movem.l D1-D4/A1,-(SP)
            lea     ($C,A6),A1
            move.w  (A1)+,D0
            ble.b   .L6
            movea.l (A1)+,A0
            movem.w (A0)+,D1-D4
            subq.w  #1,D0
            bra.b   .L5
.L1:
            movea.l (A1)+,A0
            cmp.w   (A0)+,D1
            bge.b   .L2
            move.w  (-2,A0),D1
.L2:
            cmp.w   (A0)+,D2
            bge.b   .L3
            move.w  (-2,A0),D2
.L3:
            cmp.w   (A0)+,D3
            ble.b   .L4
            move.w  (-2,A0),D3
.L4:
            cmp.w   (A0)+,D4
            ble.b   .L5
            move.w  (-2,A0),D4
.L5:
            cmp.w   D1,D3
            ble.b   .L6
            cmp.w   D2,D4
            ble.b   .L6
            dbra    D0,.L1
            bra.b   .L7
.L6:
            clr.w   D1
            clr.w   D2
            clr.w   D3
            clr.w   D4
.L7:
            movea.l (8,A6),A0
            move.w  D1,(A0)+
            move.w  D2,(A0)+
            move.w  D3,(A0)+
            move.w  D4,(A0)+
            move.w  ($C,A6),D0
            lsl.w   #2,D0
            addq.w  #6,D0
            cmp.w   D1,D3
            movem.l (SP)+,D1-D4/A1
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
            ds.b    8
UnionRect:
            movea.l ($C,SP),A0
            movea.l (8,SP),A1
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            ble.b   .L1
            move.w  (-2,A1),D0
.L1:
            swap    D0
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            ble.b   .L2
            move.w  (-2,A1),D0
.L2:
            move.w  (A0)+,D1
            cmp.w   (A1)+,D1
            bge.b   .L3
            move.w  (-2,A1),D1
.L3:
            swap    D1
            move.w  (A0)+,D1
            cmp.w   (A1)+,D1
            bge.b   .L4
            move.w  (-2,A1),D1
.L4:
            movea.l (4,SP),A0
            move.l  D0,(A0)+
            move.l  D1,(A0)+
            bra.b   Pt2Rect.L3
Pt2Rect:
            movea.l (4,SP),A0
            move.w  ($E,SP),D0
            move.w  ($A,SP),D1
            cmp.w   D0,D1
            bge.b   .L1
            exg     D0,D1
.L1:
            move.w  D0,(2,A0)
            move.w  D1,(6,A0)
            move.w  ($C,SP),D0
            move.w  (8,SP),D1
            cmp.w   D0,D1
            bge.b   .L2
            exg     D0,D1
.L2:
            move.w  D0,(A0)
            move.w  D1,(4,A0)
.L3:
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
            ds.b    12
PtInRect:
            link.w  A6,#0
            movea.l (8,A6),A0
            move.w  ($E,A6),D0
            move.w  ($C,A6),D1
            clr.b   ($10,A6)
            cmp.w   (A0)+,D1
            blt.b   .L1
            cmp.w   (A0)+,D0
            blt.b   .L1
            cmp.w   (A0)+,D1
            bge.b   .L1
            cmp.w   (A0)+,D0
            bge.b   .L1
            addq.b  #1,($10,A6)
.L1:
            unlk    A6
            rtd     #8
            dc.w    0
PUTRECT:
            link.w  A6,#0
            movea.l ($C,A6),A0
            cmpi.w  #$FBEF,(A0)
            bls.b   .L1
            move.w  #$FF6D,QDErr
            bra.b   .L3
.L1:
            movea.l (8,A6),A1
            moveq   #$10,D0
            add.w   (A0),D0
            cmp.w   (A1),D0
            bls.b   .L2
            addi.w  #$400,(A1)
            movem.l D3/A2,-(SP)
            move.l  ($10,A6),-(SP)
            move.w  (A1),-(SP)
            jsr     SetHSize
            movem.l (SP)+,D3/A2
            movea.l ($C,A6),A0
.L2:
            movea.l ($10,A6),A1
            movea.l (A1),A1
            moveq   #0,D0
            move.w  (A0),D0
            adda.l  D0,A1
            addi.w  #$10,(A0)
            movea.l ($14,A6),A0
            move.l  (A0),(A1)+
            move.w  (A0),(A1)+
            move.w  (6,A0),(A1)+
            move.w  (4,A0),(A1)+
            move.w  (2,A0),(A1)+
            move.l  (4,A0),(A1)+
.L3:
            unlk    A6
            rtd     #$10
            ds.b    6
