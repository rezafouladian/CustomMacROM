StdRgn:
            link.w  A6,#0
            movem.l D6-D7/A2-A4,-(SP)
            moveq   #0,D7
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            move.w  #$80,D0
            add.w   D7,D0
            jsr     DPutPicOp
            move.l  (8,A6),-(SP)
            jsr     PutPicRgn
.L1:
            pea     StdDraw_Regions
            pea     GetRect_Regions
            jsr     ([$1AA0.w])
            movem.l (SP)+,D6-D7/A2-A4
            unlk    A6
            rtd     #6
GetRect_Regions:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Regions:
            move.l  (8,A6),-(SP)
            jsr     ([$1A60.w])
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A6C.w])
.L1:
            jsr     FrRgn
            bra.b   .L3
.L2:
            jsr     DrawRgn
.L3:
            rts
            ds.b    14
FrameRgn:
            moveq   #0,D0
            bra.b   CallRgn
PaintRgn:
            moveq   #1,D0
            bra.b   CallRgn
EraseRgn:
            moveq   #2,D0
            bra.b   CallRgn
InvertRgn:
            moveq   #3,D0
            bra.b   CallRgn
FillRgn:
            moveq   #0,D0
            bra.b   FillCRgn.L1
FillCRgn:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1144).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($1C,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DrawRgn:
            link.w  A6,#-8
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.l  (2,A0),(-8,A6)
            move.l  (6,A0),(-4,A6)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            bmi.b   .L1
            movea.l A0,A1
            jsr     ([$1A5C.w])
            move.l  A0,-(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            pea     (-8,A6)
            clr.l   -(SP)
            pea     (-8,A6)
            move.w  ($C,A6),-(SP)
            ori.w   #8,(SP)
            move.l  (8,A6),-(SP)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  ($E,A6),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
.L1:
            unlk    A6
            rtd     #$A
            dc.w    0
FrRgn:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.w   ($42,A3)
            bmi.b   .L2
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmpi.w  #$A,(A0)
            bne.b   .L1
            pea     (2,A0)
            bsr.l   FrmRect
            bra.b   .L2
.L1:
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,D7
            move.l  ($E,A6),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1170.w])
            move.l  D7,-(SP)
            move.l  ($34,A3),-(SP)
            jsr     ([$1184.w])
            move.l  ($E,A6),-(SP)
            move.l  D7,-(SP)
            move.l  D7,-(SP)
            jsr     ([$1198.w])
            move.l  D7,-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     DrawRgn
            movea.l D7,A0
            _DisposHandle
.L2:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #$A
            ds.b    10
NewRgn:
            moveq   #$A,D0
            _NewHandle
            move.l  A0,(4,SP)
            tst.w   D0
            bne.b   .L1
            movea.l (A0),A0
            move.w  #$A,(A0)+
            clr.l   (A0)+
            clr.l   (A0)+
.L1:
            rts
            ds.b    8
DisposeRgn:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
OpenRgn:
            movem.l D3/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            moveq   #1,D0
            move.l  D0,($60,A0)
            clr.w   (-$96,A4)
            clr.l   -(SP)
            move.w  #$100,-(SP)
            move.w  (SP),(-$98,A4)
            jsr     NewHandle
            move.l  (SP)+,(-$94,A4)
            jsr     ([$1058.w])
            movem.l (SP)+,D3/A2-A4
            rts
CloseRgn:
            link.w  A6,#-2
            movem.l D3/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            tst.l   ($60,A0)
            beq.b   .L2
            clr.l   ($60,A0)
            jsr     ([$105C.w])
            move.w  (-$96,A4),D0
            cmpi.w  #$FF6D,QDErr
            bne.b   .L1
            moveq   #0,D0
            move.w  D0,QDErr
.L1:
            lsr.w   #2,D0
            move.w  D0,(-2,A6)
            movea.l (-$94,A4),A3
            move.l  (A3),-(SP)
            move.w  D0,-(SP)
            jsr     ([$1A98.w])
            move.l  (A3),-(SP)
            pea     (-2,A6)
            jsr     ([$1A18.w])
            move.l  A3,-(SP)
            move.w  (-2,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L2:
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #4
            ds.b    4
CopyRgn:
            link.w  A6,#0
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            cmpa.l  A0,A1
            beq.b   .L4
            movea.l (A0),A0
            movea.l (A1),A1
            move.w  (A0),D0
            cmp.w   (A1),D0
            beq.b   .L1
            movem.l D0/D3/A2,-(SP)
            move.l  (8,A6),-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            movem.l (SP)+,D0/D3/A2
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            movea.l (A0),A0
            movea.l (A1),A1
.L1:
            lsr.w   #2,D0
            bcc.b   .L3
            move.w  (A0)+,(A1)+
            bra.b   .L3
.L2:
            move.l  (A0)+,(A1)+
.L3:
            dbra    D0,.L2
.L4:
            unlk    A6
            rtd     #8
            ds.b    4
SetEmptyRgn:
            movea.l (SP)+,A0
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            jmp     SetRectRgn
            ds.b    4
SetRectRgn:
            link.w  A6,#0
            movem.l D3/A2,-(SP)
            movea.l ($10,A6),A0
            movea.l (A0),A1
            moveq   #$A,D0
            cmp.w   (A1),D0
            beq.b   .L1
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            movea.l ($10,A6),A0
            movea.l (A0),A1
            move.w  #$A,(A1)
.L1:
            move.l  ($C,A6),(2,A1)
            move.l  (8,A6),(6,A1)
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L2
            move.w  (2,A1),D0
            cmp.w   (6,A1),D0
            blt.b   .L3
.L2:
            clr.l   (2,A1)
            clr.l   (6,A1)
.L3:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$C
            ds.b    8
RectRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (A1)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  A0,-(SP)
            jmp     SetRectRgn
            dc.w    0
OffsetRgn:
            movea.l (SP)+,A1
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            movea.l (A0),A0
            addq.w  #2,A0
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            cmpi.w  #$A,(-$A,A0)
            beq.b   .L3
.L1:
            add.w   D1,(A0)+
.L2:
            add.w   D0,(A0)+
            add.w   D0,(A0)+
            cmpi.w  #$7FFF,(A0)
            bne.b   .L2
            addq.w  #2,A0
            cmpi.w  #$7FFF,(A0)
            bne.b   .L1
.L3:
            jmp     (A1)
            ds.b    14
InsetRgn:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            move.l  (8,A6),D6
            beq.b   .L2
            movea.l ($C,A6),A4
            movea.l (A4),A3
            move.w  (A3)+,D7
            cmpi.w  #$A,D7
            bne.b   .L3
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            jsr     ([$10A4.w])
            move.w  (2,A3),D0
            cmp.w   (6,A3),D0
            bge.b   .L1
            move.w  (A3),D0
            cmp.w   (4,A3),D0
            blt.b   .L2
.L1:
            clr.l   (A3)+
            clr.l   (A3)+
.L2:
            bra.b   sub_40836272.L4
.L3:
            add.w   D7,D7
            clr.l   -(SP)
            move.w  D7,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A3
            bsr.b   sub_40836272
            swap    D6
            bsr.b   sub_40836272
            bra.b   sub_40836272.L3
sub_40836272:
            clr.w   -(SP)
            move.l  A4,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            move.w  #8,-(SP)
            move.w  D6,-(SP)
            st      -(SP)
            jsr     ([$1A80.w])
            move.w  (SP)+,D5
            movea.l (A3),A0
            move.w  D5,D1
            bra.b   .L2
.L1:
            move.l  (A0),D0
            swap    D0
            move.l  D0,(A0)+
.L2:
            dbra    D1,.L1
            move.l  (A3),-(SP)
            move.w  D5,-(SP)
            jsr     ([$1A98.w])
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            rts
.L3:
            movea.l A3,A0
            _DisposHandle
.L4:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    14
EmptyRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            movea.l (A1),A1
            pea     (2,A1)
            move.l  A0,-(SP)
            jmp     ([$10B8.w])
            ds.b    14
EqualRgn:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            cmpa.l  A0,A1
            beq.b   .L3
            movea.l (A0),A0
            movea.l (A1),A1
            move.w  (A0),D0
            move.w  D0,D1
            lsr.w   #2,D1
            subq.w  #1,D1
.L1:
            cmpm.l  (A0)+,(A1)+
            dbne    D1,.L1
            bne.b   .L4
            andi.w  #3,D0
            beq.b   .L3
.L2:
            cmpm.b  (A0)+,(A1)+
            bne.b   .L4
            subq.w  #1,D0
            bne.b   .L2
.L3:
            moveq   #1,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            move.b  D0,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            dc.w    0
SectRgn:
            moveq   #0,D0
            bra.b   DoRgnOp
UnionRgn:
            moveq   #4,D0
            bra.b   DoRgnOp
DiffRgn:
            moveq   #2,D0
            bra.b   DoRgnOp
XorRgn:
            moveq   #6,D0
DoRgnOp:
            link.w  A6,#-8
            movem.l D3-D7/A2-A4,-(SP)
            move.w  D0,D5
            movea.l ($10,A6),A2
            movea.l ($C,A6),A3
            movea.l (8,A6),A4
            moveq   #2,D7
            clr.b   -(SP)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$118C.w])
            tst.b   (SP)+
            beq.b   .L3
            and.w   D7,D5
            bne.b   .L2
.L1:
            move.l  A2,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1170.w])
            bra.b   .L6
.L2:
            move.l  A4,-(SP)
            jsr     ([$1174.w])
            bra.b   .L6
.L3:
            movea.l (A2),A0
            movea.l (A3),A1
            cmp.w   D7,D5
            bgt.b   .L7
            blt.b   .L4
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L1
.L4:
            pea     (2,A0)
            pea     (2,A1)
            move.w  D7,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            bne.b   .L5
            tst.w   D5
            beq.b   .L2
            bra.b   .L1
.L5:
            movea.l (A2),A0
            movea.l (A3),A1
            tst.w   D5
            bne.b   .L8
            moveq   #$A,D0
            cmp.w   (A0),D0
            bne.b   .L8
            cmp.w   (A1),D0
            bne.b   .L8
            move.l  A4,-(SP)
            pea     (-8,A6)
            jsr     ([$117C.w])
.L6:
            bra.b   .L9
.L7:
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L1
            move.w  (4,A0),D0
            cmp.w   (8,A0),D0
            blt.b   .L8
            movea.l A3,A2
            bra.b   .L1
.L8:
            move.w  (A0),D4
            add.w   (A1),D4
            add.w   D4,D4
            clr.l   -(SP)
            move.w  D4,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A3
            clr.w   -(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            move.w  D5,-(SP)
            clr.w   -(SP)
            st      -(SP)
            jsr     ([$1A80.w])
            move.w  (SP)+,D6
            move.l  A3,-(SP)
            move.w  D6,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L9:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$C
            dc.w    0
PtInRgn:
            link.w  A6,#0
            move.l  D3,-(SP)
            move.w  ($E,A6),D1
            move.w  ($C,A6),D2
            clr.w   D3
            movea.l (8,A6),A0
            movea.l (A0),A0
            cmp.w   (4,A0),D1
            blt.b   .L4
            cmp.w   (8,A0),D1
            bge.b   .L4
            cmp.w   (2,A0),D2
            blt.b   .L4
            cmp.w   (6,A0),D2
            bge.b   .L4
            cmpi.w  #$A,(A0)
            bne.b   .L1
            not.w   D3
            bra.b   .L4
.L1:
            lea     ($A,A0),A0
.L2:
            cmp.w   (A0)+,D2
            blt.b   .L4
.L3:
            move.w  (A0)+,D0
            cmpi.w  #$7FFF,D0
            beq.b   .L2
            cmp.w   D1,D0
            bgt.b   .L3
            not.w   D3
            bra.b   .L3
.L4:
            neg.b   D3
            move.b  D3,($10,A6)
            move.l  (SP)+,D3
            unlk    A6
            rtd     #8
            dc.w    0
RectInRgn:
            link.w  A6,#-$24
            movem.l D0-D7/A1-A5,-(SP)
            move.l  SP,(-$C,A6)
            clr.b   ($10,A6)
            movea.l (8,A6),A1
            movea.l (A1),A1
            move.l  ($C,A6),-(SP)
            pea     (2,A1)
            move.w  #2,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            beq.b   .L4
            cmpi.w  #$A,(A1)
            beq.b   .L3
            movea.l A1,A0
            lea     (-$24,A6),A1
            move.w  (-6,A6),D0
            move.w  (-2,A6),D1
            move.w  D0,D2
            jsr     ([$1C54.w])
            move.w  ($C,A1),D5
            move.w  (-8,A6),D0
            jsr     ([$1A88.w])
            move.w  (-4,A6),D6
.L1:
            movea.l (8,A1),A0
            move.w  D5,D0
.L2:
            tst.l   (A0)+
            dbne    D0,.L2
            bne.b   .L3
            move.w  ($10,A1),D0
            cmp.w   D0,D6
            ble.b   .L4
            jsr     ([$1A88.w])
            bra.b   .L1
.L3:
            addq.b  #1,($10,A6)
.L4:
            movea.l (-$C,A6),SP
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #8
            ds.b    4
TrimRect:
            link.w  A6,#0
            movem.l D0-D7/A1-A5,-(SP)
            movea.l ($A,A6),A0
            movem.l (A0),D4-D5
            move.l  D4,D6
            swap    D6
            movea.l ($E,A6),A3
            movea.l (A3),A3
            move.w  (A3),D2
            cmpi.w  #$A,D2
            beq.w   .L21
            lea     ($A,A3),A3
            movea.l ($594).w,A0
            jsr     (A0)
            subi.l  #$640,D0
            ext.l   D2
            cmp.l   D2,D0
            bge.b   .L1
            move.w  D5,D2
            sub.w   D4,D2
            ext.l   D2
            lsl.l   #2,D2
            cmp.l   D0,D2
            ble.b   .L1
            bra.w   .L21
.L1:
            lsr.l   #1,D2
            bclr    #0,D2
            movea.l SP,A0
            suba.l  D2,SP
            movea.l SP,A4
            suba.l  D2,SP
            movea.l SP,A5
            moveq   #0,D2
            move.w  #$7FFF,D7
            movea.l A4,A1
            bra.b   .L3
.L2:
            cmp.w   D7,D0
            bne.b   .L4
.L3:
            move.w  D7,(A1)
            cmp.w   (A3)+,D6
            blt.b   .L12
            movea.l A4,A2
            movea.l A5,A1
            exg     A4,A5
.L4:
            move.w  (A2)+,D1
.L5:
            move.w  (A3)+,D0
.L6:
            cmp.w   D1,D0
            beq.b   .L2
            blt.b   .L7
            move.w  D1,(A1)+
            move.w  (A2)+,D1
            bra.b   .L6
.L7:
            cmp.w   D4,D0
            ble.b   .L8
            cmp.w   D0,D5
            ble.b   .L5
            move.w  D0,(A1)+
            bra.b   .L5
.L8:
            addq.w  #1,D2
            bra.b   .L5
.L9:
            move.w  (A3)+,D0
            cmp.w   D4,D0
            ble.b   .L10
            cmp.w   D0,D7
            beq.b   .L14
            cmp.w   D0,D5
            ble.b   .L9
            bra.b   .L11
.L10:
            move.w  (A3)+,D0
            cmp.w   D4,D0
            ble.b   .L9
.L11:
            cmpi.w  #0,D7
            bra.b   .L20
.L12:
            suba.l  A4,A1
            move.w  A1,D3
            cmpi.w  #4,D3
            bgt.b   .L20
            blt.b   .L13
            andi.w  #1,D2
            bne.b   .L11
.L13:
            move.l  D5,D6
            swap    D6
            subq.w  #2,A3
.L14:
            cmp.w   (A3)+,D6
            bgt.b   .L9
            tst.w   (8,A6)
            bne.b   .L15
            tst.w   D3
            beq.b   .L18
            bra.b   .L11
.L15:
            movea.l ($A,A6),A1
            move.w  D2,D0
            cmpi.w  #2,D3
            blt.b   .L18
            bgt.b   .L16
            btst    #0,D0
            bne.b   .L17
            move.w  (A4),(2,A1)
            bra.b   .L19
.L16:
            move.w  (A4)+,(2,A1)
.L17:
            move.w  (A4),(6,A1)
            bra.b   .L19
.L18:
            moveq   #1,D0
            and.w   D0,D2
.L19:
            cmp.w   D0,D2
.L20:
            movea.l A0,SP
.L21:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$A
            dc.w    0
MapRgn:
            link.w  A6,#-6
            movem.l D3/D6-D7/A2-A4,-(SP)
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            cmpm.l  (A0)+,(A1)+
            beq.b   .L2
.L1:
            movea.l ($10,A6),A4
            movea.l (A4),A0
            cmpi.w  #$A,(A0)
            bne.b   .L3
            pea     (2,A0)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$11E8.w])
.L2:
            bra.b   .L6
.L3:
            clr.l   -(SP)
            move.w  #$100,-(SP)
            move.w  (SP),(-4,A6)
            jsr     NewHandle
            movea.l (SP)+,A3
            clr.w   (-2,A6)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            pea     (-2,A6)
            pea     (-4,A6)
            jsr     ([$1A6C.w])
            move.w  (-2,A6),D7
            lsr.w   #2,D7
            move.w  D7,D6
            movea.l (A3),A2
            bra.b   .L5
.L4:
            move.l  A2,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$11E4.w])
            addq.l  #4,A2
.L5:
            dbra    D6,.L4
            move.l  (A3),-(SP)
            move.w  D7,-(SP)
            jsr     ([$1A98.w])
            move.l  (A3),-(SP)
            move.w  D7,(-6,A6)
            pea     (-6,A6)
            jsr     ([$1A18.w])
            move.l  A3,-(SP)
            move.w  (-6,A6),-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L6:
            movem.l (SP)+,D3/D6-D7/A2-A4
            unlk    A6
            rtd     #$C
            ds.b    10
BITMAPRGN:
            link.w  A6,#-$1E
            movem.l D3-D7/A2-A5,-(SP)
            clr.l   (-$C,A6)
            clr.w   ($10,A6)
            movea.l ($C,A6),A0
            movea.l (A0),A2
            moveq   #0,D0
            move.w  (A2),D0
            move.l  D0,(-$1A,A6)
            movea.l (8,A6),A1
            move.w  (4,A1),D0
            bpl.b   .L2
            btst    #$E,D0
            beq.b   .L1
            movea.l (A1),A0
            movea.l (A0),A1
.L1:
            cmpi.w  #1,($20,A1)
            beq.b   .L2
            move.w  #$FF6C,D0
            bra.w   sub_4083692A.L6
.L2:
            move.w  (4,A1),(-$10,A6)
            andi.w  #$7FFF,(-$10,A6)
            move.l  (6,A1),D2
            move.w  ($C,A1),D0
            sub.w   D2,D0
            ble.w   sub_4083692A.L7
            ext.l   D0
            move.l  D0,D4
            add.l   D4,D4
            addq.l  #6,D4
            add.l   D4,D4
            move.l  D4,(-$1E,A6)
            moveq   #$20,D7
            divu.w  D7,D0
            move.l  D0,D3
            swap    D3
            moveq   #-1,D1
            tst.w   D3
            beq.b   .L3
            addq.w  #1,D0
            sub.w   D3,D7
            asl.l   D7,D1
.L3:
            move.l  D1,(-8,A6)
            ext.l   D0
            move.l  D0,(-4,A6)
            asl.l   #2,D0
            _NewHandleClear
            bne.w   sub_4083692A.L6
            move.l  A0,(-$C,A6)
            move.l  D2,D3
            swap    D3
            move.w  ($A,A1),D0
            sub.w   D3,D0
            ble.w   sub_4083692A.L7
            move.w  D0,(-$E,A6)
            movea.l (A1),A4
            move.w  #$A,D7
.L4:
            movea.l ($C,A6),A2
            movea.l (A2),A2
.L5:
            lea     (0,A2,D7.w),A5
            move.l  (-$1A,A6),D1
            sub.w   D7,D1
            cmp.l   (-$1E,A6),D1
            bge.b   .L6
            move.l  (-$1A,A6),D0
            add.l   (-$1E,A6),D0
            move.l  D0,(-$1A,A6)
            movea.l ($C,A6),A0
            _SetHandleSize
            bne.w   sub_4083692A.L6
            bra.b   .L4
.L6:
            move.w  D2,D4
            moveq   #0,D6
            movea.l A4,A1
            move.l  (-4,A6),D5
            movea.l (-$C,A6),A3
            movea.l (A3),A3
            move.w  D3,D0
            bsr.w   sub_4083692A
            move.w  D7,(-$12,A6)
            bra.w   sub_40836862.L7
.L7:
            move.l  (A1)+,D0
.L8:
            move.l  (A3),D1
            eor.l   D0,D1
            bne.w   sub_40836862.L2
            tst.b   D6
            beq.b   .L9
            move.w  D4,(A5)+
            moveq   #0,D6
.L9:
            addi.w  #$20,D4
            addq.w  #4,A3
            bra.w   sub_40836862.L7
.L14:
            addq.w  #3,D4
.L10:
            move.w  D4,(A5)+
            addq.w  #1,D4
.L11:
            not.b   D6
            rts
.L15:
            addq.w  #2,D4
            move.w  D4,(A5)+
.L12:
            bsr.b   sub_4083683A
.L13:
            addq.w  #1,D4
            rts
.L16:
            addq.w  #2,D4
            move.w  D4,(A5)+
            addq.w  #2,D4
            bra.b   .L11
sub_40836820:
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
.L1:
            addq.w  #2,D4
            rts
.L2:
            bsr.b   sub_40836820
            subq.w  #1,D4
            bra.b   BITMAPRGN.L10
.L3:
            bsr.b   sub_4083683A
            addq.w  #1,D4
            bra.b   BITMAPRGN.L12
.L4:
            bsr.b   sub_4083683A
            addq.w  #3,D4
            bra.b   BITMAPRGN.L11
sub_4083683A:
            addq.w  #1,D4
            move.w  D4,(A5)+
            rts
.L1:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            addq.w  #3,D4
            rts
.L2:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            addq.w  #2,D4
            bra.b   BITMAPRGN.L10
.L3:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
            bra.b   BITMAPRGN.L12
.L4:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
            addq.w  #2,D4
            bra.b   BITMAPRGN.L11
sub_40836862:
            move.w  D4,(A5)+
            addq.w  #2,D4
            move.w  D4,(A5)+
            bra.b   sub_40836820.L1
.L12:
            bsr.b   sub_40836862
            subq.w  #1,D4
            bra.b   BITMAPRGN.L10
.L13:
            move.w  D4,(A5)+
            addq.w  #3,D4
            move.w  D4,(A5)+
            bra.b   BITMAPRGN.L13
.L1:
            bra.b   .L11
            bra.b   BITMAPRGN.L14
            bra.b   BITMAPRGN.L15
            bra.b   BITMAPRGN.L16
            bra.b   sub_40836820
            bra.b   sub_40836820.L2
            bra.b   sub_40836820.L3
            bra.b   sub_40836820.L4
            bra.b   sub_4083683A.L1
            bra.b   sub_4083683A.L2
            bra.b   sub_4083683A.L3
            bra.b   sub_4083683A.L4
            bra.b   sub_40836862
            bra.b   .L12
            bra.b   .L13
            move.w  D4,(A5)+
            not.b   D6
.L11:
            addq.w  #4,D4
            rts
.L2:
            move.l  D0,(A3)+
            moveq   #3,D7
            moveq   #0,D0
.L3:
            rol.l   #8,D1
            tst.b   D1
            bne.b   .L5
            tst.b   D6
            bne.b   .L5
            addq.w  #8,D4
            bra.b   .L6
.L4:
            move.l  (A1),D0
            and.l   (-8,A6),D0
            bra.w   BITMAPRGN.L8
.L5:
            move.b  D1,D0
            eor.b   D6,D0
            lsr.b   #4,D0
            add.w   D0,D0
            jsr     .L1(PC,D0.w)
            move.b  D1,D0
            eor.b   D6,D0
            andi.w  #$F,D0
            add.w   D0,D0
            jsr     .L1(PC,D0.w)
.L6:
            dbra    D7,.L3
.L7:
            subq.w  #1,D5
            bgt.w   BITMAPRGN.L7
            beq.b   .L4
            move.w  A5,D7
            sub.w   A2,D7
            cmp.w   (-$12,A6),D7
            beq.b   .L10
            blt.w   sub_4083692A.L5
            tst.b   D6
            beq.b   .L8
            move.w  D4,(A5)+
            addq.w  #2,D7
.L8:
            bsr.b   sub_40836926
.L9:
            addq.w  #1,D3
            move.w  D2,D4
            adda.w  (-$10,A6),A4
            subq.w  #1,(-$E,A6)
            bgt.w   BITMAPRGN.L5
            blt.b   sub_4083692A.L1
            move.l  (-4,A6),D0
            asl.l   #2,D0
            _NewHandleClear
            bne.b   sub_4083692A.L6
            move.l  A0,(-$16,A6)
            movea.l (A0),A4
            bra.w   BITMAPRGN.L4
.L10:
            subq.l  #2,A5
            subq.w  #2,D7
            bra.b   .L9
sub_40836926:
            move.w  #$7FFF,D0
sub_4083692A:
            move.w  D0,(A5)+
            addq.w  #2,D7
            rts
.L1:
            movea.l (-$16,A6),A0
            _DisposHandle
            cmpi.w  #$A,D7
            beq.b   .L7
            bsr.b   sub_40836926
            bmi.b   .L5
            lea     ($A,A2),A0
            move.w  #$7FFF,D4
            move.w  D4,D1
            move.w  #$8000,D2
            move.w  (A0),D3
            bra.b   .L4
.L2:
            movea.l A0,A1
            cmp.w   (A0)+,D1
            ble.b   .L3
            move.w  (-2,A0),D1
.L3:
            cmp.w   (A0)+,D4
            bne.b   .L3
            cmp.w   (-4,A0),D2
            bge.b   .L4
            move.w  (-4,A0),D2
.L4:
            move.w  (A0)+,D0
            cmp.w   D4,D0
            bne.b   .L2
            swap    D3
            move.w  D1,D3
            move.w  (-2,A1),D4
            swap    D4
            move.w  D2,D4
            cmpi.w  #$1C,D7
            beq.b   .L8
            bra.b   .L9
.L5:
            move.w  #$FE0C,D0
.L6:
            move.w  D0,($10,A6)
.L7:
            movea.l ($C,A6),A0
            movea.l (A0),A2
            moveq   #0,D3
            moveq   #0,D4
.L8:
            moveq   #$A,D7
.L9:
            move.w  D7,(A2)+
            move.l  D3,(A2)+
            move.l  D4,(A2)
            move.l  D7,D0
            movea.l ($C,A6),A0
            _SetHandleSize
            movea.l (-$C,A6),A0
            _DisposHandle
            movem.l (SP)+,D3-D7/A2-A5
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    8
