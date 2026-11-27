AllocCursor:
            lea     AllocCrsr,A0
            move.l  JAllocCrsr,D0
            beq.b   .L1
            movea.l D0,A0
.L1:
            jmp     (A0)
            dc.w    0
InitCursor:
            movea.l (A5),A0
            pea     (-$6C,A0)
            jsr     ([$F44.w])
            movea.l ($814).w,A0
            jmp     (A0)
            ds.b    14
SetCursor:
            movea.l (4,SP),A0
            move.l  ($40,A0),-(SP)
            move.w  #$10,-(SP)
            pea     (A0)
            pea     ($20,A0)
            movea.l ($818).w,A0
            jsr     (A0)
            move.l  (SP)+,(SP)
            rts
            ds.b    4
SetCCursor:
            move.l  (4,SP),-(SP)
            movea.l JSetCCrsr,A0
            jsr     (A0)
            move.l  (SP)+,(SP)
            rts
            dc.w    0
HideCursor:
            move.l  GrafBegin,-(SP)
            rts
            ds.b    10
ShowCursor:
            move.l  ($804).w,-(SP)
            rts
            ds.b    10
ShieldCursor:
            movem.l D0-D3/A0-A1,-(SP)
            movea.l ($20,SP),A0
            movem.w (A0)+,D0-D3
            lea     ($1C,SP),A1
            sub.w   (A1),D0
            sub.w   (A1)+,D2
            sub.w   (A1),D1
            sub.w   (A1),D3
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            move.w  D2,-(SP)
            movea.l ($808).w,A0
            jsr     (A0)
            movem.l (SP)+,D0-D3/A0-A1
            move.l  (SP)+,(SP)
            move.l  (SP)+,(SP)
            rts
ObscureCursor:
            movea.l JCrsrObscure,A0
            jmp     (A0)
            ds.b    10
