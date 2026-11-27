StdPoly:
            link.w  A6,#-8
            movem.l D5-D7/A2-A4,-(SP)
            moveq   #0,D7
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            moveq   #$70,D0
            add.w   D7,D0
            jsr     DPutPicOp
            move.l  (8,A6),-(SP)
            jsr     PutPicRgn
.L1:
            pea     StdDraw_Polygons
            pea     GetRect_Polygons
            jsr     ([$1AA0.w])
            movem.l (SP)+,D5-D7/A2-A4
            unlk    A6
            rtd     #6
GetRect_Polygons:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            pea     (-4,A1)
            move.l  ($34,A3),D0
            neg.w   D0
            move.w  D0,-(SP)
            swap    D0
            neg.w   D0
            move.w  D0,-(SP)
            jsr     ([$10A4.w])
            rts
StdDraw_Polygons:
            movea.l (8,A6),A2
            tst.b   D7
            bne.b   .L1
            move.l  A2,-(SP)
            jsr     FrPoly
            bra.b   .L2
.L1:
            movea.l (A2),A0
            pea     (2,A0)
            movea.l ($18,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($1C,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #3,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            beq.b   .L2
            move.l  A2,-(SP)
            jsr     ([$1A60.w])
            jsr     DrawPoly
.L2:
            rts
            ds.b    6
FramePoly:
            moveq   #0,D0
            bra.b   CallPoly
PaintPoly:
            moveq   #1,D0
            bra.b   CallPoly
ErasePoly:
            moveq   #2,D0
            bra.b   CallPoly
InvertPoly:
            moveq   #3,D0
            bra.b   CallPoly
FillPoly:
            moveq   #0,D0
            bra.b   FillCPoly.L1
FillCPoly:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallPoly:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1114).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($18,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
OpenPoly:
            jsr     ([$1058.w])
            clr.l   -(SP)
            move.w  #$8A,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A1
            move.l  A1,(4,SP)
            movea.l (A5),A0
            move.l  A1,(-$A2,A0)
            move.w  #$8A,(-$A4,A0)
            movea.l (A0),A0
            moveq   #1,D0
            move.l  D0,($64,A0)
            movea.l (A1),A1
            move.w  #$A,(A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            rts
            ds.b    10
ClosePoly:
            movem.l D3-D7/A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            clr.l   ($64,A0)
            movea.l (-$A2,A4),A4
            movea.l (A4),A0
            move.w  (A0)+,D7
            clr.l   (A0)+
            clr.l   (A0)+
            move.w  D7,D6
            subi.w  #$A,D6
            lsr.w   #2,D6
            beq.b   .L6
            move.w  (A0)+,D1
            move.w  D1,D2
            move.w  (A0)+,D3
            move.w  D3,D4
            subq.w  #1,D6
            bra.b   .L5
.L1:
            move.w  (A0)+,D0
            cmp.w   D1,D0
            bge.b   .L2
            move.w  D0,D1
.L2:
            cmp.w   D2,D0
            ble.b   .L3
            move.w  D0,D2
.L3:
            move.w  (A0)+,D0
            cmp.w   D3,D0
            bge.b   .L4
            move.w  D0,D3
.L4:
            cmp.w   D4,D0
            ble.b   .L5
            move.w  D0,D4
.L5:
            dbra    D6,.L1
            movea.l (A4),A0
            lea     (2,A0),A0
            move.w  D1,(A0)+
            move.w  D3,(A0)+
            move.w  D2,(A0)+
            move.w  D4,(A0)+
.L6:
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            jsr     SetHSize
            jsr     ([$105C.w])
            movem.l (SP)+,D3-D7/A4
            rts
KillPoly:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
OffsetPoly:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.w  (A1)+,D2
            subq.w  #2,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L1:
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            dbra    D2,.L1
            jmp     (A0)
            ds.b    4
MapPoly:
            link.w  A6,#0
            movem.l D7/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l (8,A6),A3
            move.l  (A2),D0
            cmp.l   (A3),D0
            bne.b   .L1
            move.l  (4,A2),D0
            cmp.l   (4,A3),D0
            beq.b   .L4
.L1:
            movea.l ($10,A6),A4
            movea.l (A4),A4
            pea     (2,A4)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$11E8.w])
            moveq   #$A,D0
            move.w  (A4),D7
            sub.w   D0,D7
            lsr.w   #2,D7
            adda.w  D0,A4
            bra.b   .L3
.L2:
            move.l  A4,-(SP)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$11E4.w])
            addq.w  #4,A4
.L3:
            dbra    D7,.L2
.L4:
            movem.l (SP)+,D7/A2-A4
            unlk    A6
            rtd     #$C
            ds.b    4
FrPoly:
            link.w  A6,#0
            movem.l D6-D7/A4,-(SP)
            movea.l (8,A6),A4
            movea.l (A4),A0
            move.w  (A0),D7
            subi.w  #$A,D7
            lsr.w   #2,D7
            beq.b   .L3
            move.l  ($A,A0),-(SP)
            jsr     ([$104C.w])
            moveq   #$E,D6
            subq.w  #1,D7
            bra.b   .L2
.L1:
            move.b  HiliteMode,-(SP)
            movea.l (A4),A0
            move.l  (0,A0,D6.w),-(SP)
            addq.w  #4,D6
            jsr     ([$1A40.w])
            move.b  (SP)+,HiliteMode
.L2:
            dbra    D7,.L1
.L3:
            movem.l (SP)+,D6-D7/A4
            bset    #7,HiliteMode
            unlk    A6
            rtd     #4
            ds.b    14

            include "QuickDraw/QuickPolys.s"

DrawPoly:
            link.w  A6,#-8
            movea.l ([$E.w,A6]),A0
            move.w  (A0)+,D0
            cmpi.w  #$1E,D0
            bne.b   .L1
            move.l  ($18,A0),D1
            cmp.l   (8,A0),D1
            bne.b   .L4
            bra.b   .L2
.L1:
            cmpi.w  #$1A,D0
            bne.b   .L4
.L2:
            moveq   #2,D0
            addq.w  #8,A0
            lea     (4,A0),A1
.L3:
            cmpm.w  (A0)+,(A1)+
            seq     D1
            cmpm.w  (A0)+,(A1)+
            seq     D2
            or.b    D1,D2
            beq.b   .L4
            dbra    D0,.L3
            lea     (-$C,A0),A1
            cmpm.w  (A0)+,(A1)+
            seq     D1
            cmpm.w  (A0)+,(A1)+
            seq     D2
            or.b    D1,D2
            beq.b   .L4
            lea     (-8,A6),A0
            move.l  A0,-(SP)
            move.l  (-$C,A1),(A0)+
            move.l  (-8,A1),(A0)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   DrawRect
            bra.w   .L14
.L4:
            movem.l D3-D5/A2,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            bmi.w   .L13
            movea.l ($E,A6),A0
            move.l  A0,D0
            beq.w   .L13
            _HLock
            movea.l (A0),A0
            move.l  (2,A0),(-8,A6)
            move.l  (6,A0),(-4,A6)
            move.w  (A0),D4
            subi.w  #$A,D4
            lsr.w   #2,D4
            moveq   #0,D0
            move.w  D4,D0
            addq.l  #1,D0
            asl.l   #3,D0
            _NewHandle
            tst.w   D0
            bne.w   .L12
            movea.l A0,A2
            _HLock
            moveq   #0,D3
            movea.l ($E,A6),A1
            movea.l (A1),A1
            adda.w  #$A,A1
            move.l  (A1)+,D5
            move.w  D4,D2
            subq.l  #1,D2
            movea.l (A2),A0
            bra.b   .L8
.L5:
            move.l  D5,D4
            move.l  (A1)+,D5
            move.l  D4,D0
            move.l  D5,D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            beq.b   .L8
            bmi.b   .L6
            move.l  D4,(A0)+
            bra.b   .L7
.L6:
            move.l  D5,(A0)+
.L7:
            addq.w  #1,D3
            swap    D1
            move.l  D1,(A0)+
.L8:
            dbra    D2,.L5
            move.l  D5,D4
            movea.l ($E,A6),A1
            movea.l (A1),A1
            move.l  ($A,A1),D5
            cmp.l   D4,D5
            beq.b   .L11
            move.l  D4,D0
            move.l  D5,D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            beq.b   .L11
            bmi.b   .L9
            move.l  D4,(A0)+
            bra.b   .L10
.L9:
            move.l  D5,(A0)+
.L10:
            addq.w  #1,D3
            swap    D1
            move.l  D1,(A0)+
.L11:
            movea.l ($E,A6),A0
            _HUnlock
            move.l  (A2),-(SP)
            move.w  D3,-(SP)
            jsr     XDrawPoly
            move.l  (A2),-(SP)
            move.w  D3,-(SP)
            st      -(SP)
            pea     (-8,A6)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     PaintVector
            movea.l A2,A0
            _HUnlock
            movea.l A2,A0
            _DisposHandle
            moveq   #0,D0
            bra.b   .L13
.L12:
            movea.l ($E,A6),A0
            _HUnlock
.L13:
            movem.l (SP)+,D3-D5/A2
.L14:
            unlk    A6
            rtd     #$A
            ds.b    10
