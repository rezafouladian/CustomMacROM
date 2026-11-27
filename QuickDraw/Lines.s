StdLine:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            jsr     ([$1A3C.w])
            ble.b   .L6
            clr.b   -(SP)
            bsr.l   PutPicVerb
            moveq   #$20,D7
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  ($30,A3),D0
            cmp.l   ($30,A4),D0
            bne.b   .L1
            addq.w  #1,D7
.L1:
            move.w  ($A,A6),D6
            sub.w   D0,D6
            move.w  D6,D0
            ext.w   D0
            cmp.w   D6,D0
            bne.b   .L2
            move.w  (8,A6),D5
            sub.w   ($30,A3),D5
            move.w  D5,D0
            ext.w   D0
            cmp.w   D5,D0
            bne.b   .L2
            addq.w  #2,D7
.L2:
            move.w  D7,-(SP)
            bsr.l   PutPicOp
            ror.w   #1,D7
            bcs.b   .L3
            move.l  ($30,A3),-(SP)
            bsr.l   PutPicLong
.L3:
            ror.w   #1,D7
            bcs.b   .L4
            move.l  (8,A6),-(SP)
            bsr.l   PutPicLong
            bra.b   .L5
.L4:
            move.b  D6,-(SP)
            bsr.l   PutPicByte
            move.b  D5,-(SP)
            bsr.l   PutPicByte
.L5:
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  (8,A6),($30,A4)
.L6:
            pea     sub_4082965A
            pea     GetRect_Lines
            jsr     ([$1AA0.w])
            movem.l (SP)+,D5-D7/A3-A4
            unlk    A6
            rtd     #4
GetRect_Lines:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (8,A6),D0
            move.l  ($30,A3),D1
            cmp.w   D0,D1
            bgt.b   .L1
            exg     D0,D1
.L1:
            move.w  D0,(2,A1)
            add.w   ($36,A3),D1
            move.w  D1,(6,A1)
            swap    D0
            swap    D1
            cmp.w   D0,D1
            bgt.b   .L2
            exg     D0,D1
.L2:
            move.w  D0,(A1)
            add.w   ($34,A3),D1
            move.w  D1,(4,A1)
            jmp     (A0)
sub_4082965A:
            move.l  (8,A6),-(SP)
            jsr     ([$1A40.w])
            rts
            ds.b    10
LineTo:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1040).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (4,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
Line:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($32,A0),D0
            add.w   D0,(6,SP)
            move.w  ($30,A0),D0
            add.w   D0,(4,SP)
            jmp     LineTo
            ds.b    8
MoveTo:
            movea.l (SP)+,A0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  (SP)+,($30,A1)
CommonMoveEnd:
            tst.w   (6,A1)
            bpl.b   .L1
            move.w  #$8000,($E,A1)
.L1:
            jmp     (A0)
            ds.b    8
Move_:
MOOV:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (A5),A1
            movea.l (A1),A1
            add.w   D0,($30,A1)
            add.w   D1,($32,A1)
            bra.b   CommonMoveEnd
            ds.b    12
DoLine:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  ($14,SP),D7
            move.l  ($30,A3),D6
            tst.l   ($64,A3)
            beq.b   .L3
            movea.l (-$A2,A4),A1
            movea.l (A1),A0
            moveq   #0,D0
            move.w  (A0),D0
            cmpi.w  #$A,D0
            bne.b   .L1
            move.l  D6,(0,A0,D0.l)
            addq.w  #4,D0
            bcs.b   .L2
.L1:
            move.l  D7,(0,A0,D0.l)
            addq.w  #4,D0
            move.w  D0,(A0)
            cmp.w   (-$A4,A4),D0
            bcs.b   .L2
            addi.w  #$100,(-$A4,A4)
            move.l  A1,-(SP)
            move.w  (-$A4,A4),-(SP)
            jsr     SetHSize
.L2:
            bra.b   .L4
.L3:
            tst.l   ($60,A3)
            beq.b   .L4
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A64.w])
.L4:
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            jsr     ([$1A28.w])
            move.l  D7,($30,A3)
            tst.w   (6,A3)
            bpl.b   .L5
            move.w  #$8000,($E,A3)
.L5:
            movem.l (SP)+,D6-D7/A3-A4
            move.l  (SP)+,(SP)
            rts
            ds.b    4
HidePen:
            moveq   #-1,D0
            bra.b   ShowPen.L1
ShowPen:
            moveq   #1,D0
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            add.w   D0,($42,A0)
            rts
GetPenState:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            lea     ($30,A0),A0
            movea.l (4,SP),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            tst.w   D1
            bmi.b   .L3
.L1:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
.L2:
            move.l  (SP)+,(SP)
            rts
.L3:
            move.l  (A0),(A1)
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            beq.b   .L4
            ori.w   #$8000,(-2,A1)
            bra.b   .L2
.L4:
            movea.l (6,A0),A0
            movea.l (A0),A0
            bra.b   .L1
SetPenState:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            lea     ($30,A0),A1
            movea.l (4,SP),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)
            andi.w  #$7FFF,(A1)+
            tst.w   D1
            bpl.b   GetPenState.L1
            tst.w   (-2,A0)
            bpl.b   .L1
            move.l  (A0),-(SP)
            jsr     ([$1628.w])
            bra.b   GetPenState.L2
.L1:
            move.l  A0,-(SP)
            jsr     ([$1074.w])
            bra.b   GetPenState.L2
            ds.b    12
GetPen:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            move.l  ($30,A0),(A1)
            move.l  (SP)+,(SP)
            rts
PenSize:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),($34,A0)
            move.l  (SP)+,(SP)
            rts
            dc.w    0
PenMode:
            moveq   #$38,D0
            jmp     PortWord
            ds.b    10
PenPat:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
.L1:
            tst.w   (6,A0)
            bmi.b   .L3
            lea     ($3A,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L2:
            move.l  (SP)+,(SP)
            rts
.L3:
            move.l  A1,-(SP)
            pea     ($3A,A0)
            jsr     ([$1A44.w])
            bra.b   .L2
PenNormal:
            movea.l (A5),A0
            lea     (-$10,A0),A1
            movea.l (A0),A0
            move.l  #$10001,($34,A0)
            move.w  #8,($38,A0)
            move.l  (SP),-(SP)
            bra.b   PenPat.L1
            ds.b    14
