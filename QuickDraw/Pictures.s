StdComment:
            link.w  A6,#0
            movem.l D6-D7,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.l   ($5C,A0)
            beq.b   .L2
            move.w  ($E,A6),D6
            move.w  ($C,A6),D7
            bgt.b   .L1
            move.w  #$A0,D0
            jsr     DPutPicOp
            move.w  D6,-(SP)
            jsr     PutPicWord
            bra.b   .L2
.L1:
            move.w  #$A1,D0
            jsr     DPutPicOp
            move.w  D6,-(SP)
            jsr     PutPicWord
            move.w  D7,-(SP)
            jsr     PutPicWord
            movea.l (8,A6),A0
            _HLock
            move.l  (A0),-(SP)
            move.w  D7,-(SP)
            jsr     PutPicData
            movea.l (8,A6),A0
            _HUnlock
.L2:
            movem.l (SP)+,D6-D7
            unlk    A6
            rtd     #8
            dc.w    0
StdGetPic:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            movea.l (A5),A0
            move.l  (-$B4,A0),D0
            movea.l (-$9C,A0),A0
            movea.l (A0),A0
            adda.l  D0,A0
            bra.b   .L2
.L1:
            move.b  (A0)+,(A1)+
.L2:
            dbra    D1,.L1
            rts
StdPutPic:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A4
            tst.l   ($5C,A4)
            beq.b   .L4
            movea.l ($5C,A4),A4
            movea.l (A4),A1
            move.l  (8,A1),D7
            beq.b   .L4
            movea.l (A1),A3
            move.w  (8,A6),D0
            ext.l   D0
            add.l   D7,D0
            move.l  D0,(8,A1)
            movea.l (A3),A0
            move.w  D0,(A0)
            cmp.l   (4,A1),D0
            ble.b   .L1
            addi.l  #$200,D0
            move.l  D0,(4,A1)
            movea.l A3,A0
            _SetHandleSize
            movea.l (A4),A1
            beq.b   .L1
            clr.l   (8,A1)
            moveq   #$A,D0
            movea.l A3,A0
            _SetHandleSize
            movea.l (A3),A0
            move.w  #$FFFF,(A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            bra.b   .L4
.L1:
            movea.l (A1),A1
            movea.l (A1),A1
            adda.l  D7,A1
            movea.l ($A,A6),A0
            move.w  (8,A6),D0
            bra.b   .L3
.L2:
            move.b  (A0)+,(A1)+
.L3:
            dbra    D0,.L2
.L4:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
            dc.w    0
StdOpcodeProc:
            link.w  A6,#0
            movem.l D6-D7,-(SP)
            move.l  #$100,D6
            suba.l  D6,SP
            move.w  ($A,A6),D0
            bmi.b   .L1
            lsr.w   #8,D0
            add.w   D0,D0
            ext.l   D0
            bra.b   .L2
.L1:
            andi.w  #$7F00,D0
            beq.b   .L5
            jsr     GetLong
.L2:
            move.l  D0,D7
.L3:
            move.w  D6,D0
            cmp.l   D6,D7
            bge.b   .L4
            move.w  D7,D0
.L4:
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            sub.l   D6,D7
            bgt.b   .L3
.L5:
            adda.l  D6,SP
            movem.l (SP)+,D6-D7
            unlk    A6
            rtd     #$C
            ds.b    6
PicComment:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11C4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($24,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
OpenCPicture:
            link.w  A6,#-2
            move.w  #$2FF,(-2,A6)
            jmp     OPShare
            dc.w    0
OpenPicture:
            link.w  A6,#-2
            move.w  #1,(-2,A6)
OPShare:
            movem.l D3/A3-A4,-(SP)
            clr.l   ($C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($5C,A3)
            bne.w   .L5
            jsr     ([$1058.w])
            tst.w   (6,A3)
            bpl.b   .L1
            move.w  #$2FF,(-2,A6)
            move.l  #$3E8,D0
            _NewHandle
            bne.w   .L5
            _DisposHandle
.L1:
            move.l  #$8C,D0
            _NewHandle
            movea.l A0,A4
            move.l  A4,($5C,A3)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  #$100,D0
            _NewHandle
            movea.l A0,A1
            move.l  A1,($C,A6)
            movea.l (A4),A4
            move.l  A1,(A4)+
            movea.l (A1),A1
            move.w  #$A,(A1)+
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  #$100,(A4)+
            move.l  #$A,(A4)+
            move.l  (SP)+,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.w  #1,(A4)+
            clr.w   (A4)+
            clr.l   (A4)+
            move.l  #$10001,D0
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.l  D0,(A4)+
            move.w  #8,(A4)+
            moveq   #-1,D0
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.l  ($10,A3),(A4)+
            move.l  #$21,(A4)+
            move.l  #$1E,(A4)+
            move.w  (-2,A6),(A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            move.l  D0,(A4)+
            move.w  D0,(A4)+
            move.l  #$8000,(A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            cmpi.w  #1,(-2,A6)
            beq.b   .L3
            moveq   #2,D3
.L2:
            clr.l   -(SP)
            suba.l  ([$5C.w,A3]),A4
            jsr     ([$161C.w])
            movea.l (SP)+,A0
            adda.l  ([$5C.w,A3]),A4
            move.l  A0,(A4)+
            movea.l (A0),A0
            clr.w   (A0)
            dbra    D3,.L2
.L3:
            moveq   #$11,D0
            jsr     DPutPicOp
            move.w  (-2,A6),D0
            cmpi.w  #1,D0
            bne.b   .L4
            jsr     DPutPicByte
            bra.b   .L5
.L4:
            move.w  D0,-(SP)
            jsr     PutPicWord
            move.w  #$C00,D0
            jsr     DPutPicOp
            clr.l   -(SP)
            movea.l (8,A6),A0
            move.l  (4,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (6,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (2,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            moveq   #-1,D0
            move.l  D0,-(SP)
            move.l  SP,-(SP)
            move.w  #$18,-(SP)
            jsr     PutPicData
            lea     ($18,SP),SP
.L5:
            movem.l (SP)+,D3/A3-A4
            unlk    A6
            rtd     #4
            ds.b    4
ClosePicture:
            movem.l D6-D7/A3,-(SP)
            movea.l (A5),A3
            movea.l (A3),A3
            move.l  ($5C,A3),D7
            beq.b   .L3
            move.w  #$FF,-(SP)
            jsr     PutPicOp
            movea.l D7,A0
            movea.l (A0),A0
            move.l  ($C,A0),D6
            move.l  (8,A0),D0
            beq.b   .L1
            movea.l (A0),A0
            _SetHandleSize
.L1:
            movea.l D6,A0
            _DisposHandle
            movea.l D7,A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            beq.b   .L2
            lea     ($80,A0),A0
            move.l  (A0)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A0)+,-(SP)
            jsr     ([$1620.w])
            jsr     ([$1620.w])
            jsr     ([$1620.w])
.L2:
            movea.l D7,A0
            _DisposHandle
            clr.l   ($5C,A3)
            jsr     ([$105C.w])
.L3:
            movem.l (SP)+,D6-D7/A3
            rts
            ds.b    8
KillPicture:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
DrawPicture:
            link.w  A6,#-$AA
            movem.l D3-D7/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($C,A6)
            beq.w   .L8
            movea.l (8,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            ble.w   .L8
            move.w  D0,(-$18,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            ble.w   .L8
            move.w  D0,(-$1A,A6)
            lea     (-$22,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l ($C,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            ble.w   .L8
            move.w  D0,(-$14,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            ble.w   .L8
            move.w  D0,(-$16,A6)
            lea     (-$2A,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l A3,A0
            lea     (-$AA,A6),A1
            moveq   #$35,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            clr.l   (-$A8,A4)
            move.l  ($C,A6),(-$9C,A4)
            move.l  #$A,(-$B4,A4)
            lea     (-$3E,A6),A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            move.l  ($1C,A3),(-$E,A6)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,(-$12,A6)
            move.w  #$8000,D0
            move.w  D0,(-8,A6)
            move.w  D0,(-6,A6)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,($1C,A3)
            lea     ($20,A3),A0
            clr.l   (A0)+
            clr.l   (A0)+
            moveq   #-1,D0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            clr.l   (A0)+
            move.l  #$10001,D1
            move.l  D1,(A0)+
            move.w  #8,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            addq.w  #2,A0
            clr.l   (A0)+
            move.w  #1,(A0)+
            clr.w   (A0)+
            clr.l   (A0)+
            move.l  #$21,(A0)+
            move.l  #$1E,(A0)+
            pea     ($34,A3)
            pea     (-$2A,A6)
            pea     (-$22,A6)
            jsr     ([$11E0.w])
            tst.w   (6,A3)
            bmi.b   .L2
            clr.l   -(SP)
            jsr     ([$161C.w])
            move.l  (SP)+,(-4,A6)
            bra.b   .L3
.L2:
            clr.l   ($20,A3)
            clr.l   ($3A,A3)
            clr.l   ($3E,A3)
            move.l  A3,-(SP)
            jsr     INITCOLORSTUFF
.L3:
            move.w  #1,(-$A,A6)
            movea.l ($C,A6),A0
            _HGetState
            move.w  D0,-(SP)
            _HLock
.L4:
            clr.b   -(SP)
            pea     (-$3E,A6)
            jsr     ([$1C68.w])
            move.b  (SP)+,D0
            bne.b   .L4
            movea.l ($C,A6),A0
            move.w  (SP)+,D0
            _HSetState
            movea.l (-$12,A6),A0
            _DisposHandle
            tst.w   (6,A3)
            bmi.b   .L5
            move.l  (-4,A6),-(SP)
            jsr     ([$1620.w])
            bra.b   .L6
.L5:
            move.l  ($20,A3),-(SP)
            jsr     ([$1620.w])
            move.l  ($3A,A3),-(SP)
            jsr     ([$1620.w])
            move.l  ($3E,A3),-(SP)
            jsr     ([$1620.w])
.L6:
            movea.l ($1C,A3),A0
            _DisposHandle
            lea     (-$AA,A6),A0
            moveq   #$35,D0
.L7:
            move.w  (A0)+,(A3)+
            dbra    D0,.L7
            clr.l   (-$A8,A4)
            clr.l   (-$9C,A4)
            clr.l   (-$B4,A4)
.L8:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    4
PicItem1:
            link.w  A6,#-$16E
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$16E,A6)
            clr.l   (-$C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l (8,A6),A2
            clr.b   ($C,A6)
            bsr.w   GetPicOp
            move.w  D0,D7
            cmpi.w  #$FF,D7
            beq.w   GETHND2.L7
            bcs.b   .L2
            move.l  ($68,A3),D0
            movea.l ($1DE0).w,A0
            beq.b   .L1
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l D0,A0
            movea.l ($34,A0),A0
.L1:
            pea     ($14,A2)
            pea     ($1C,A2)
            move.w  D7,-(SP)
            move.w  ($34,A2),-(SP)
            jsr     (A0)
            move.b  #1,($C,A6)
            bra.w   GETHND2.L7
.L2:
            move.b  #1,($C,A6)
            cmpi.w  #$20,D7
            bcs.b   .L4
            move.b  D7,D0
            andi.w  #$F0,D0
            btst    #3,D7
            sne     (-$5E,A6)
            andi.w  #7,D7
            lsr.w   #3,D0
            move.w  .L3(PC,D0.w),D0
            jmp     .L3(PC,D0.w)
.L3:
            dc.w    GETHND2.L7-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    sub_4083237E.L4-.L3
            dc.w    sub_4083237E.L16-.L3
            dc.w    sub_4083237E.L19-.L3
            dc.w    sub_4083237E.L22-.L3
            dc.w    sub_4083237E.L25-.L3
            dc.w    sub_4083237E.L28-.L3
            dc.w    sub_4083237E.L32-.L3
            dc.w    sub_4083237E.L36-.L3
            dc.w    sub_4083237E.L49-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    sub_408320D8.L41-.L3
            dc.w    sub_408320D8.L40-.L3
            dc.w    sub_408320D8.L40-.L3
.L4:
            andi.w  #$1F,D7
            add.w   D7,D7
            move.w  .L5(PC,D7.w),D0
            jmp     .L5(PC,D0.w)
.L5:
            dc.w    GETHND2.L7-.L5
            dc.w    .L6-.L5
            dc.w    sub_408320D8.L1-.L5
            dc.w    sub_408320D8.L8-.L5
            dc.w    sub_408320D8.L9-.L5
            dc.w    sub_408320D8.L10-.L5
            dc.w    sub_408320D8.L12-.L5
            dc.w    sub_408320D8.L13-.L5
            dc.w    sub_408320D8.L17-.L5
            dc.w    sub_408320D8.L4-.L5
            dc.w    sub_408320D8.L5-.L5
            dc.w    sub_408320D8.L21-.L5
            dc.w    sub_408320D8.L22-.L5
            dc.w    sub_408320D8.L11-.L5
            dc.w    sub_408320D8.L6-.L5
            dc.w    sub_408320D8.L7-.L5
            dc.w    sub_408320D8.L14-.L5
            dc.w    sub_408320D8.L15-.L5
            dc.w    sub_408320D8.L25-.L5
            dc.w    sub_408320D8.L26-.L5
            dc.w    sub_408320D8.L27-.L5
            dc.w    sub_408320D8.L29-.L5
            dc.w    sub_408320D8.L31-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    sub_408320D8.L23-.L5
            dc.w    sub_408320D8.L24-.L5
            dc.w    sub_408320D8.L32-.L5
            dc.w    sub_408320D8.L33-.L5
            dc.w    sub_408320D8.L35-.L5
            dc.w    sub_408320D8.L37-.L5
.L6:
            bsr.w   sub_40832AE6
            movea.l (8,A6),A2
            move.l  (-4,A6),-(SP)
            move.l  ($2C,A2),-(SP)
.L7:
            jsr     ([$1170.w])
            movea.l (8,A6),A2
            movea.l (-4,A6),A0
            movea.l (A0),A0
            cmpi.w  #$A,(A0)+
            bne.b   .L8
            cmpi.l  #$80018001,(A0)+
            bne.b   .L8
            cmpi.l  #$7FFF7FFF,(A0)+
            bra.b   .L9
.L8:
            move.l  (-4,A6),-(SP)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
.L9:
            movea.l (8,A6),A2
            move.l  (-4,A6),-(SP)
            move.l  ($30,A2),-(SP)
            move.l  ($1C,A3),-(SP)
            jsr     ([$1190.w])
            bra.w   GETHND2.L4
            moveq   #8,D6
            bra.w   sub_4083237E.L56
.L10:
            moveq   #4,D6
            bra.w   sub_4083237E.L56
.L11:
            moveq   #2,D6
            bra.w   sub_4083237E.L56
sub_408320C6:
            tst.w   (6,A3)
            bmi.b   .L1
            rts
.L1:
            move.l  A0,-(SP)
            jsr     ([$1620.w])
            rts
sub_408320D8:
            movea.l (SP)+,A0
            moveq   #8,D0
            suba.w  D0,SP
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jmp     GetPicData
.L1:
            movea.l ($20,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            jsr     ([$FF0.w])
.L2:
            addq.w  #8,SP
.L3:
            move.b  #1,($C,A6)
            bra.w   GETHND2.L7
.L4:
            movea.l ($3A,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            jsr     ([$1074.w])
            bra.b   .L2
.L5:
            movea.l ($3E,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            moveq   #0,D0
            jsr     SetFillPat
            bra.b   .L2
.L6:
            jsr     GetLong
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            bra.b   .L3
.L7:
            jsr     GetLong
            move.l  D0,-(SP)
            jsr     ([$F8C.w])
            bra.b   .L3
.L8:
            lea     ($44,A3),A3
            bra.w   PicItem1.L11
.L9:
            lea     ($46,A3),A3
            moveq   #1,D6
            bra.w   sub_4083237E.L56
.L10:
            pea     ($48,A3)
            bra.w   .L18
.L11:
            lea     ($4A,A3),A3
            bra.w   PicItem1.L11
.L12:
            lea     ($4C,A3),A3
            bra.w   PicItem1.L10
.L13:
            jsr     GetLong
            move.l  D0,($34,A3)
            pea     ($34,A3)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L14:
            movea.l (8,A6),A3
            jsr     GetLong
            move.l  D0,($24,A3)
            jsr     GetLong
            move.l  D0,($28,A3)
            pea     ($24,A3)
            pea     ($28,A3)
            pea     ($14,A3)
            jsr     MapRatio
            pea     ($24,A3)
            pea     ($14,A3)
            pea     ($1C,A3)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L15:
            jsr     GetUByte
            cmpi.w  #1,D0
            beq.b   .L16
            move.w  D0,D6
            lsl.w   #8,D6
            jsr     GetUByte
            move.b  D0,D6
            move.w  D6,D0
.L16:
            movea.l (8,A6),A3
            move.w  D0,($34,A3)
            bra.w   GETHND2.L7
.L17:
            pea     ($38,A3)
.L18:
            jsr     GetWord
            tst.w   (6,A3)
            bmi.b   .L19
            tst.l   ($68,A3)
            beq.b   .L19
            btst    #5,D0
            beq.b   .L19
            andi.w  #7,D0
            move.b  .L20(PC,D0.w),D0
.L19:
            movea.l (SP)+,A0
            move.w  D0,(A0)
            bra.w   GETHND2.L7
.L20:
            dc.w    $0003,$0201,$0103,$0201
.L21:
            jsr     GetLong
            movea.l (8,A6),A2
            move.l  D0,($10,A2)
            pea     ($10,A2)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L22:
            jsr     GetLong
            movea.l (8,A6),A2
            add.w   D0,($14,A2)
            add.w   D0,($18,A2)
            add.w   D0,(-$A8,A4)
            swap    D0
            add.w   D0,($16,A2)
            add.w   D0,($1A,A2)
            add.w   D0,(-$A6,A4)
            move.l  ($2C,A2),-(SP)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP),(-4,A6)
            bra.w   PicItem1.L7
.L23:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            move.w  D0,-(SP)
            move.l  D6,-(SP)
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            bra.w   GETHND2.L7
.L24:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            move.w  D0,-(SP)
            move.l  D6,-(SP)
            move.l  SP,-(SP)
            jsr     ([$1654.w])
            addq.w  #6,SP
            bra.w   GETHND2.L7
.L25:
            pea     ($20,A3)
            move.l  ($20,A3),-(SP)
            bra.b   .L28
.L26:
            pea     ($3A,A3)
            move.l  ($3A,A3),-(SP)
            bra.b   .L28
.L27:
            pea     ($28,A3)
            move.l  ($3E,A3),-(SP)
.L28:
            jsr     GetPicPixPat
            bra.w   GETHND2.L7
.L29:
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L30
            movea.l (8,A6),A2
            move.w  D0,($38,A2)
.L30:
            bra.w   GETHND2.L7
.L31:
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L30
            move.w  D0,($C,A3)
            bra.w   GETHND2.L7
.L32:
            bclr    #7,HiliteMode
            bra.w   GETHND2.L7
.L33:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L34
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  D6,(6,A0)
            move.w  D0,($A,A0)
.L34:
            bra.w   GETHND2.L7
.L35:
            tst.w   (6,A3)
            bpl.b   .L36
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  ($DA0).w,(6,A0)
            move.w  ($DA4).w,($A,A0)
.L36:
            bra.w   GETHND2.L7
.L37:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L38
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  D6,(A0)
            move.w  D0,(4,A0)
.L38:
            bra.w   GETHND2.L7
.L39:
            tst.b   (-$5E,A6)
            beq.b   .L42
            move.l  D1,D0
            bra.b   .L42
.L40:
            jsr     GetLong
            bra.b   .L42
.L41:
            jsr     GetWord
            swap    D0
            clr.w   D0
            swap    D0
.L42:
            bsr.b   sub_4083237E
            bra.w   GETHND2.L7
sub_4083237E:
            movem.l D6-D7,-(SP)
            move.l  #$100,D6
            suba.l  D6,SP
            move.l  D0,D7
            beq.b   .L3
.L1:
            move.w  D6,D0
            cmp.l   D6,D7
            bge.b   .L2
            move.w  D7,D0
.L2:
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            sub.l   D6,D7
            bgt.b   .L1
.L3:
            adda.l  D6,SP
            movem.l (SP)+,D6-D7
            rts
.L4:
            cmpi.w  #3,D7
            bgt.b   sub_408320D8.L41
            tst.b   (-$5E,A6)
            bne.w   .L9
            movea.l (8,A6),A2
            move.l  (8,A2),D0
            ror.w   #1,D7
            bcs.b   .L5
            jsr     GetLong
.L5:
            move.l  D0,($30,A3)
            move.l  D0,(-$62,A6)
            movea.l (8,A6),A2
            pea     ($30,A3)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
            ror.w   #1,D7
            bcs.b   .L6
            jsr     GetLong
            move.l  D0,(-$62,A6)
            bra.b   .L7
.L6:
            bsr.w   GETSBYTE
            add.w   D0,(-$60,A6)
            bsr.w   GETSBYTE
            add.w   D0,(-$62,A6)
.L7:
            movea.l (8,A6),A2
            move.l  (-$62,A6),(8,A2)
            pea     (-$62,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
            move.l  (-$62,A6),-(SP)
            movea.l ($1040).w,A0
            move.l  ($68,A3),D0
            beq.b   .L8
            movea.l D0,A0
            movea.l (4,A0),A0
.L8:
            bra.w   GETHND2.L1
.L9:
            movea.l (8,A6),A2
            move.w  ($38,A2),($36,A2)
            move.w  #$8000,($38,A2)
            andi.w  #3,D7
            beq.b   .L11
            ror.w   #1,D7
            bcc.b   .L10
            jsr     GetUByte
            movea.l (8,A6),A2
            add.w   D0,($E,A2)
.L10:
            ror.w   #1,D7
            bcc.b   .L12
            jsr     GetUByte
            movea.l (8,A6),A2
            add.w   D0,($C,A2)
            bra.b   .L12
.L11:
            jsr     GetLong
            movea.l (8,A6),A2
            move.l  D0,($C,A2)
.L12:
            jsr     GetUByte
            move.w  D0,D6
            pea     (-$162,A6)
            move.w  D6,-(SP)
            jsr     GetPicData
            move.l  ($C,A2),($30,A3)
            movea.l (8,A6),A2
            cmpi.w  #1,($34,A2)
            beq.b   .L13
            tst.w   (6,A3)
            bpl.b   .L13
            move.w  ($36,A2),-(SP)
            move.w  ($E,A2),-(SP)
            move.w  #$8000,-(SP)
            move.w  ($C,A2),-(SP)
            move.l  SP,-(SP)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     MapFixPt
            move.w  (SP)+,($30,A3)
            move.w  (SP)+,D0
            move.w  (SP)+,($32,A3)
            move.w  (SP)+,($E,A3)
            bra.b   .L14
.L13:
            pea     ($30,A3)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
.L14:
            move.w  D6,-(SP)
            pea     (-$162,A6)
            movea.l (8,A6),A2
            move.l  ($24,A2),-(SP)
            move.l  ($28,A2),-(SP)
            movea.l JStdTEXT,A0
            move.l  ($68,A3),D0
            beq.b   .L15
            movea.l D0,A0
            movea.l (A0),A0
.L15:
            bra.w   GETHND2.L1
.L16:
            cmpi.w  #4,D7
            ble.w   .L17
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L17:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l ($1080).w,A0
            move.l  ($68,A3),D0
            beq.b   .L18
            movea.l D0,A0
            movea.l (8,A0),A0
.L18:
            bra.w   GETHND2.L1
.L19:
            cmpi.w  #4,D7
            ble.w   .L20
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L20:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l (8,A6),A2
            move.l  ($10,A2),-(SP)
            movea.l ($10BC).w,A0
            move.l  ($68,A3),D0
            beq.b   .L21
            movea.l D0,A0
            movea.l ($C,A0),A0
.L21:
            bra.w   GETHND2.L1
.L22:
            cmpi.w  #4,D7
            ble.w   .L23
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L23:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l ($10D8).w,A0
            move.l  ($68,A3),D0
            beq.b   .L24
            movea.l D0,A0
            movea.l ($10,A0),A0
.L24:
            bra.w   GETHND2.L1
.L25:
            cmpi.w  #4,D7
            ble.w   .L26
            moveq   #$C,D0
            moveq   #4,D1
            bra.w   sub_408320D8.L39
.L26:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            jsr     GetWord
            move.w  D0,-(SP)
            jsr     GetWord
            move.w  D0,-(SP)
            movea.l ($10F4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L27
            movea.l D0,A0
            movea.l ($14,A0),A0
.L27:
            bra.w   GETHND2.L1
.L28:
            cmpi.w  #4,D7
            ble.w   .L30
            tst.b   (-$5E,A6)
            bne.b   .L29
            bsr.w   sub_40832AE6
.L29:
            bra.w   GETHND2.L7
.L30:
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11F0.w])
            move.b  D7,-(SP)
            move.l  (-4,A6),-(SP)
            movea.l ($1114).w,A0
            move.l  ($68,A3),D0
            beq.b   .L31
            movea.l D0,A0
            movea.l ($18,A0),A0
.L31:
            bra.w   GETHND2.L2
.L32:
            cmpi.w  #4,D7
            ble.w   .L34
            tst.b   (-$5E,A6)
            bne.b   .L33
            bsr.w   sub_40832AE6
.L33:
            bra.w   GETHND2.L7
.L34:
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
            move.b  D7,-(SP)
            move.l  (-4,A6),-(SP)
            movea.l ($1144).w,A0
            move.l  ($68,A3),D0
            beq.b   .L35
            movea.l D0,A0
            movea.l ($1C,A0),A0
.L35:
            bra.w   GETHND2.L2
.L36:
            cmpi.w  #3,D7
            bgt.w   sub_408320D8.L41
            cmpi.w  #1,D7
            ble.b   .L37
            jsr     GetLong
.L37:
            jsr     GetWord
            move.w  D0,(-$4A,A6)
            moveq   #8,D1
            move.w  D0,D6
            bpl.b   .L38
            moveq   #$2C,D1
.L38:
            pea     (-$48,A6)
            move.w  D1,-(SP)
            jsr     GetPicData
            clr.w   (-$40,A6)
            tst.w   D6
            bpl.b   .L39
            clr.l   (-$24,A6)
            btst    #1,D7
            bne.b   .L39
            moveq   #8,D0
            jsr     RNewHandle
            move.l  A0,(-$24,A6)
            move.l  A0,-(SP)
            jsr     GetPicTable
.L39:
            pea     (-$1C,A6)
            move.w  #$10,-(SP)
            jsr     GetPicData
            movea.l (8,A6),A2
            pea     (-$14,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E8.w])
            pea     (-$4E,A6)
            pea     (-$1C,A6)
            pea     (-$14,A6)
            jsr     GetWord
            move.w  D0,-(SP)
            clr.l   -(SP)
            btst    #0,D7
            beq.b   .L40
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
            move.l  (-4,A6),(SP)
            move.l  (-4,A6),(-8,A6)
.L40:
            move.w  (-$44,A6),D6
            sub.w   (-$48,A6),D6
            move.w  D6,D5
            move.w  (-$4A,A6),D0
            andi.w  #$7FFF,D0
            mulu.w  D0,D5
            move.l  D5,D0
            _NewHandle
            bne.w   .L46
            move.l  A0,(-4,A6)
            _HLock
.L41:
            pea     (-$4E,A6)
            move.l  A0,-(SP)
            jsr     GetPMData
            movea.l (-4,A6),A0
            move.l  (A0),(-$4E,A6)
            movea.l ($11AC).w,A0
            move.l  ($68,A3),D0
            beq.b   .L43
            exg     D0,A0
            cmp.l   ($20,A0),D0
            beq.b   .L42
            tst.w   (-$4A,A6)
            bpl.b   .L42
            tst.w   (6,A3)
            bmi.b   .L42
            lea     (-$4A,A6),A0
            moveq   #0,D0
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            lsl.l   #3,D0
            divu.w  (-$2E,A6),D0
            addi.w  #$F,D0
            lsr.l   #4,D0
            beq.b   .L44
            add.w   D0,D0
            lea     (-$58,A6),A1
            move.w  D0,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (-$4E,A6),(-$5C,A6)
            pea     (-$4E,A6)
            pea     (-$5C,A6)
            pea     (-$48,A6)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            lea     (-$5C,A6),A0
            move.l  A0,($E,SP)
            movea.l ($68,A3),A0
.L42:
            movea.l ($20,A0),A0
.L43:
            jsr     (A0)
.L44:
            tst.w   (-$4A,A6)
            bpl.b   .L45
            move.l  (-$24,A6),D0
            beq.b   .L45
            movea.l D0,A0
            _DisposHandle
.L45:
            btst    #0,D7
            beq.w   GETHND2.L4
            bra.w   GETHND2.L3
.L46:
            move.l  D5,D0
            jsr     ([$1A70.w])
            move.l  A0,(-$C,A6)
            move.l  A0,(-4,A6)
            move.l  D0,D4
            cmp.l   D5,D0
            bge.w   .L41
            move.w  (-$4A,A6),D5
            andi.w  #$7FFF,D5
            ext.l   D5
            _PurgeSpace
            move.l  A0,D3
            cmp.l   D3,D4
            ble.b   .L47
            move.l  D4,D3
            divu.l  D5,D3
            bne.b   .L48
            bra.w   GETHND2.L6
.L47:
            movea.l (-$C,A6),A0
            jsr     ([$1A78.w])
            clr.l   (-$C,A6)
            divu.l  D5,D3
            beq.w   GETHND2.L6
            move.l  D5,D0
            mulu.l  D3,D0
            _NewHandle
            bne.w   GETHND2.L6
            move.l  A0,(-4,A6)
            _HLock
.L48:
            move.w  (-$44,A6),D6
            move.w  (-$48,A6),D0
            add.w   D3,D0
            move.w  D0,(-$44,A6)
            move.w  (-$1C,A6),D0
            add.w   D3,D0
            move.w  D0,(-$18,A6)
            move.w  (-$10,A6),D5
            move.w  D5,D4
            sub.w   (-$14,A6),D4
            clr.l   -(SP)
            move.w  D4,-(SP)
            move.w  D6,-(SP)
            move.w  (-$48,A6),D0
            sub.w   D0,(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            move.l  D0,D4
            dc.w    $4C03,$4004,$342E,$FFEC,$4842,$4242,$D484,$4842
            dc.w    $3D42,$FFF0,$4842,$206E,$FFFC,$2D50,$FFB2,$2878
            dc.b    $11,$AC,$08,$87,$00,$1F,$20,$2B,$00
            dc.b    'hgR @ ('
            dc.w    $0020,$B08C
            dc.b    'gH(@Jn'
            dc.w    $FFB6,$6A40,$4A6B,$0006,$6B3A,$08C7,$001F,$41EE
            dc.w    $FFB6,$7000,$3018,$0240,$7FFF,$E788,$80EE,$FFD2
            dc.w    $0640,$000F,$E888,$6700,$FEEC,$D040,$43EE,$FFA8
            dc.w    $32C0,$22D8,$22D8,$2D6E,$FFB2,$FFA4,$41EE,$FFA4
            dc.w    $2F48,$000E,$486E,$FFB2,$2F2E,$FFFC,$2442,$4EBA
            dc.w    $0D26,$4A87,$6A18,$486E,$FFB2,$486E,$FFA4,$486E
            dc.w    $FFB8,$2F17,$4267,$42A7,$4EB0,$81E1,$11B0,$2F2F
            dc.w    $000E,$2F2F,$000E,$2F2F,$000E,$3F2F,$0010,$2F2F
            dc.w    $000E,$4E94,$240A,$D76E,$FFB8,$D76E,$FFBC,$D76E
            dc.w    $FFAA,$D76E,$FFAE,$D76E,$FFE4,$D76E,$FFE8,$3D6E
            dc.w    $FFF0,$FFEC,$D484,$4842,$3D42,$FFF0,$4842,$BC6E
            dc.w    $FFBC,$6E90,$3D45,$FFF0,$3D46,$FFBC,$3D46,$FFAE
            dc.w    $3D46,$FFE8,$486E,$FFB2,$2F2E,$FFFC,$4EBA,$0CA8
            dc.w    $4A87,$6A18,$486E,$FFB2,$486E,$FFA4,$486E,$FFB8
            dc.w    $2F17,$4267,$42A7,$4EB0,$81E1,$11B0,$4E94,$6000
            dc.w    $FE24
.L49:
            tst.b   (-$5E,A6)
            bne.w   sub_408320D8.L41
            cmpi.w  #1,D7
            bgt.w   sub_408320D8.L41
            jsr     GetWord
            move.w  D0,-(SP)
            tst.b   D7
            bne.b   .L51
            clr.w   -(SP)
            clr.l   -(SP)
            movea.l ($11C4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L50
            movea.l D0,A0
            movea.l ($24,A0),A0
.L50:
            bra.w   GETHND2.L1
.L51:
            jsr     GetWord
            move.w  D0,-(SP)
            clr.w   D4
            bsr.w   GETHND2
            move.l  (-4,A6),-(SP)
            movea.l ($11C4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L52
            movea.l D0,A0
            movea.l ($24,A0),A0
.L52:
            bra.w   GETHND2.L2
            movea.l (A5),A0
            movea.l (-$7A,A0),A1
            move.w  (-$76,A0),D0
            andi.w  #$7FFF,D0
            lea     .L55,A0
            moveq   #$18,D1
.L53:
            move.l  (A0)+,(A1)
            adda.w  D0,A1
            dbra    D1,.L53
.L54:
            bra.b   .L54
.L55:
            ds.b    4
            dc.w    $7EE9,$D200,$44A9,$1A00,$74A9,$9610,$14A9,$1230
            dc.b    $74,$EF,$D2,$60,$00,$00,$00
            dc.b    '@wtCXEW'
            dc.w    $C7FC,$7755,$4FFE,$4654,$4FF8,$4574,$4FF0,0
            dc.w    $0FF0,$7774,$EFF8,$5554,$8FFE,$7774,$CFFE,$5444
            dc.w    $87BC,$5447,$E318
            ds.b    4
            dc.w    $7745,$D7FE
            dc.b    'EmUJEU'
            dc.w    $D56E,$4545,$154C,$7745,$1D7A
            ds.b    4
.L56:
            move.l  A3,-(SP)
            move.w  D6,-(SP)
            jsr     GetPicData
            bra.w   GETHND2.L7
GETSBYTE:
            clr.b   -(SP)
            move.l  SP,-(SP)
            move.w  #1,-(SP)
            jsr     GetPicData
            move.b  (SP)+,D0
            ext.w   D0
            rts
sub_40832A82:
            tst.b   (-$5E,A6)
            bne.b   .L1
            movea.l (8,A6),A2
            pea     (A2)
            move.w  #8,-(SP)
            jsr     GetPicData
.L1:
            movea.l (8,A6),A2
            move.l  (A2),(-$14,A6)
            move.l  (4,A2),(-$10,A6)
            pea     (-$14,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E8.w])
            movea.l (SP)+,A0
            pea     (-$14,A6)
            jmp     (A0)
GetPicOp:
            movea.l (8,A6),A2
            cmpi.w  #1,($34,A2)
            beq.b   .L2
            movea.l (A5),A0
            move.l  (-$B4,A0),D0
            btst    #0,D0
            beq.b   .L1
            jsr     GetUByte
.L1:
            jsr     GetWord
            rts
.L2:
            jsr     GetUByte
            rts
sub_40832AE6:
            moveq   #2,D4
            jsr     GetWord
GETHND2:
            ext.l   D0
            move.l  D0,D5
            _NewHandle
            bne.b   .L6
            move.l  A0,(-4,A6)
            _HLock
            movea.l (A0),A0
            move.w  D5,(A0)
            sub.w   D4,D5
            pea     (0,A0,D4.w)
            move.w  D5,-(SP)
            jsr     GetPicData
            movea.l (-4,A6),A0
            _HUnlock
            rts
.L1:
            jsr     (A0)
            bra.b   .L7
.L2:
            jsr     (A0)
            bra.b   .L4
.L3:
            movea.l (-8,A6),A0
            _DisposHandle
.L4:
            tst.l   (-$C,A6)
            beq.b   .L5
            movea.l (-$C,A6),A0
            jsr     ([$1A78.w])
            bra.b   .L7
.L5:
            movea.l (-4,A6),A0
            _DisposHandle
            bra.b   .L7
.L6:
            movea.l (-$16E,A6),SP
            clr.b   ($C,A6)
            move.w  #$FF6F,QDErr
.L7:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #4
            ds.b    14
GetUByte:
            clr.b   -(SP)
            move.l  SP,-(SP)
            move.w  #1,-(SP)
            jsr     GetPicData
            clr.w   D0
            move.b  (SP)+,D0
            rts
            ds.b    14
GetWord:
            clr.w   -(SP)
            move.l  SP,-(SP)
            move.w  #2,-(SP)
            jsr     GetPicData
            move.w  (SP)+,D0
            rts
GetLong:
            clr.l   -(SP)
            move.l  SP,-(SP)
            move.w  #4,-(SP)
            jsr     GetPicData
            move.l  (SP)+,D0
            rts
GetPicData:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B8).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($2C,A0),A0
.L1:
            move.l  (6,SP),-(SP)
            move.w  (8,SP),-(SP)
            jsr     (A0)
            movea.l (A5),A0
            moveq   #0,D0
            move.w  (4,SP),D0
            add.l   D0,(-$B4,A0)
            rtd     #6
            dc.w    0
PutPicData:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11C0).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($30,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DPutPicByte:
            movea.l (SP)+,A0
            move.b  D0,-(SP)
            move.l  A0,-(SP)
PutPicByte:
            pea     (4,SP)
            move.w  #1,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.b   (SP)+
            jmp     (A0)
            ds.b    8
PutPicWord:
            pea     (4,SP)
            move.w  #2,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.w   (SP)+
            jmp     (A0)
            ds.b    14
PutPicLong:
            pea     (4,SP)
            move.w  #4,-(SP)
            jsr     PutPicData
            move.l  (SP)+,(SP)
            rts
PutPicRect:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            moveq   #0,D0
            move.b  (SP)+,D0
            move.l  A0,-(SP)
            move.l  (A1),D2
            move.l  (4,A1),D1
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            cmp.l   ($4A,A0),D2
            bne.b   .L1
            cmp.l   ($4E,A0),D1
            bne.b   .L1
            addq.w  #8,D0
            jmp     DPutPicOp
.L1:
            move.l  D2,($4A,A0)
            move.l  D1,($4E,A0)
            move.l  A1,-(SP)
            move.w  #8,-(SP)
            jsr     DPutPicOp
            jsr     PutPicData
            rts
            ds.b    12
DPutPicOp:
            movea.l (SP)+,A0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
PutPicOp:
            jsr     PutPicPad
PutPicOp2:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            moveq   #2,D0
            lea     (4,SP),A1
            cmpi.w  #1,($62,A0)
            bne.b   .L1
            moveq   #1,D0
            addq.w  #1,A1
.L1:
            move.l  A1,-(SP)
            move.w  D0,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.w   (SP)+
            jmp     (A0)
            ds.b    12
PutPicRgn:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,-(SP)
            move.w  (A0),-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    6
PutPicPad:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            beq.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
            move.w  (A0),D0
            btst    #0,D0
            beq.b   .L1
            moveq   #0,D0
            jsr     DPutPicByte
.L1:
            rts
            ds.b    10
PutPicPat:
            movea.l (SP)+,A0
            move.w  #8,-(SP)
            move.l  A0,-(SP)
            jmp     PutPicData
            ds.b    4
PutPicVerb:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.b  (8,A6),D7
            cmpi.b  #1,D7
            blt.b   .L2
            beq.b   .L3
            cmpi.b  #3,D7
            beq.w   .L6
            blt.b   .L1
            pea     ($28,A3)
            move.l  ($3E,A3),-(SP)
            pea     ($42,A4)
            move.l  ($80,A4),-(SP)
            move.w  #$A,-(SP)
            move.w  #$14,-(SP)
            jsr     UpdatePat
            bra.w   .L6
.L1:
            pea     ($20,A3)
            move.l  ($20,A3),-(SP)
            pea     ($10,A4)
            move.l  ($88,A4),-(SP)
            move.w  #2,-(SP)
            move.w  #$12,-(SP)
            jsr     UpdatePat
            bra.b   .L6
.L2:
            move.l  ($34,A3),D7
            cmp.l   ($34,A4),D7
            beq.b   .L3
            moveq   #7,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($34,A4)
.L3:
            move.w  ($38,A3),D7
            cmp.w   ($38,A4),D7
            beq.b   .L5
            cmpi.w  #1,($62,A4)
            bne.b   .L4
            btst    #5,D7
            beq.b   .L4
            andi.w  #7,D7
            move.b  .L7(PC,D7.w),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L5
.L4:
            moveq   #8,D0
            jsr     DPutPicOp
            move.w  D7,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($38,A4)
.L5:
            pea     ($3A,A3)
            move.l  ($3A,A3),-(SP)
            pea     ($3A,A4)
            move.l  ($84,A4),-(SP)
            move.w  #9,-(SP)
            move.w  #$13,-(SP)
            jsr     UpdatePat
.L6:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #2
.L7:
            dc.w    $0003,$0201,$0103,$0201
UpdatePat:
            link.w  A6,#0
            movem.l D5-D6,-(SP)
            cmpi.w  #1,($62,A4)
            bne.b   .L3
            movea.l ($18,A6),A0
            move.l  (A0)+,D5
            move.l  (A0),D6
.L1:
            movea.l ($10,A6),A0
            cmp.l   (A0)+,D5
            bne.b   .L2
            cmp.l   (A0),D6
            beq.w   .L6
.L2:
            movea.l ($10,A6),A0
            move.l  D5,(A0)+
            move.l  D6,(A0)
            move.w  ($A,A6),D0
            jsr     DPutPicOp
            move.l  ($10,A6),-(SP)
            jsr     PutPicPat
            bra.b   .L6
.L3:
            movea.l ($C,A6),A1
            movea.l (A1),A1
            move.w  (A1),D0
            movea.l ($14,A6),A0
            movea.l (A0),A0
            cmpi.w  #0,(A0)
            bne.b   .L4
            clr.w   (A1)
            movea.l (6,A0),A0
            movea.l (A0),A0
            move.l  (A0)+,D5
            move.l  (A0),D6
            cmpi.w  #0,D0
            bne.b   .L2
            bra.b   .L1
.L4:
            cmpi.w  #0,D0
            beq.b   .L5
            clr.b   -(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($C,A6),-(SP)
            jsr     EqualPat
            tst.b   (SP)+
            bne.b   .L6
.L5:
            move.l  ($14,A6),-(SP)
            move.l  ($C,A6),-(SP)
            jsr     ([$1624.w])
            move.w  (8,A6),D0
            jsr     DPutPicOp
            move.l  ($C,A6),-(SP)
            jsr     PutPicPixPat
.L6:
            movem.l (SP)+,D5-D6
            unlk    A6
            rtd     #$14
            ds.b    8
EqualPat:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            clr.b   ($10,A6)
            movea.l (8,A6),A4
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A1
            _GetHandleSize
            move.l  D0,D2
            movea.l ($C,A6),A3
            movea.l (A3),A0
            movea.l (6,A0),A0
            _GetHandleSize
            cmp.l   D0,D2
            bne.b   .L4
            lsr.l   #1,D0
            subq.w  #1,D0
            movea.l (A0),A0
.L1:
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L1
            movea.l (A3),A0
            movea.l (A4),A1
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            move.l  ($12,A0),D0
            cmp.l   ($12,A1),D0
            bne.b   .L4
            move.l  ($16,A0),D1
            cmp.w   ($16,A1),D1
            bne.b   .L4
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (A1),A1
            movea.l (A1),A1
            cmpm.l  (A0)+,(A1)+
            move.w  #$12,D0
.L2:
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L2
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (A1),A1
            movea.l (A1),A1
            cmpm.l  (A0)+,(A1)+
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            bne.b   .L4
.L3:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L3
            move.b  #1,($10,A6)
.L4:
            movem.l (SP)+,A3-A4
            unlk    A6
            rtd     #8
            ds.b    4
GetPicTable:
            jsr     GetLong
            cmpi.l  #$3FF,D0
            blt.b   .L1
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,D0
.L1:
            move.l  D0,-(SP)
            jsr     GetLong
            move.l  D0,-(SP)
            move.w  D0,D2
            addq.w  #1,D2
            mulu.w  #8,D2
            move.l  D2,D0
            addq.w  #8,D0
            movea.l ($C,SP),A0
            jsr     RSetHSize
            _HLock
            movea.l (A0),A0
            move.l  (SP)+,D0
            move.l  (SP)+,(A0)+
            move.l  D0,(A0)+
            move.l  A0,-(SP)
            move.w  D2,-(SP)
            jsr     GetPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            dc.w    0
PutPicTable:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,-(SP)
            move.w  (6,A0),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            move.w  D0,-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    10
GetPicPixMap:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            clr.l   (A0)+
            move.l  A0,-(SP)
            move.w  #$2E,-(SP)
            jsr     GetPicData
            move.l  (SP)+,D0
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  D0,($2A,A0)
            move.l  D0,-(SP)
            jsr     GetPicTable
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    12
PutPicPixMap:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            pea     (4,A0)
            move.w  #$2E,-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  ($2A,A0),D0
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     PutPicTable
.L1:
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
GetPicPixPat:
            moveq   #$A,D0
            suba.w  D0,SP
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            cmpi.w  #2,(SP)
            bne.w   PutGray.L3
            subq.w  #6,SP
            bsr.w   GetLong
            move.l  D0,(SP)
            bsr.w   GetWord
            move.w  D0,(4,SP)
            tst.w   (6,A3)
            bmi.b   PutGray.L2
            move.l  SP,-(SP)
            move.l  ($1C,SP),-(SP)
            bsr.b   PutGray
            lea     ($10,SP),SP
            bra.w   PutGray.L6
PutGray:
            movea.l (8,SP),A1
            move.w  (A1)+,D0
            mulu.w  #$4CCC,D0
            move.w  (A1)+,D1
            mulu.w  #$970A,D1
            add.l   D1,D0
            move.w  (A1)+,D1
            mulu.w  #$1C28,D1
            add.l   D1,D0
            clr.w   D0
            rol.l   #3,D0
            lea     .L1,A0
            lea     (0,A0,D0.w*4),A0
            movea.l (4,SP),A1
            move.l  (A0),(A1)+
            move.l  (A0),(A1)
            rtd     #8
.L1:
            dc.w    $FFFF,$FFFF,$DDFF,$77FF,$FF55,$FF55,$EE55,$BB55
            dc.b    $AA,$55,$AA,$55,$88,$55,$22,$55,$88,$00,$22
            ds.b    5
.L2:
            move.l  ($14,SP),-(SP)
            pea     (4,SP)
            jsr     ([$1634.w])
            addq.w  #6,SP
.L3:
            tst.w   (6,A3)
            bmi.b   .L4
            movea.l ($12,SP),A1
            move.w  (SP)+,D0
            move.l  (SP)+,(A1)+
            move.l  (SP)+,(A1)+
            movea.l (8,A6),A2
            move.l  ($3A,A2),-(SP)
            bsr.b   GETPMD
            bra.b   .L6
.L4:
            movea.l ($E,SP),A0
            movea.l (A0),A0
            move.w  (SP)+,(A0)
            move.l  (SP)+,($14,A0)
            move.l  (SP)+,($18,A0)
            cmpi.w  #2,(A0)
            beq.b   .L5
            move.l  (4,SP),-(SP)
            bsr.b   GETPMD
.L5:
            move.l  (4,SP),-(SP)
            jsr     ([$1A4C.w])
.L6:
            rtd     #8
GETPMD:
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  (2,A0),-(SP)
            jsr     GetPicPixMap
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (2,A0),A1
            movea.l (A1),A1
            movea.l (6,A0),A0
            move.w  ($A,A1),D1
            sub.w   (6,A1),D1
            move.w  (4,A1),D0
            andi.w  #$7FFF,D0
            mulu.w  D1,D0
            jsr     RSetHSize
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (6,A0),A0
            _HLock
            movea.l A0,A1
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (2,A0),A0
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            _HLock
            move.l  (A0),-(SP)
            move.l  A1,-(SP)
            jsr     GetPMData
            movea.l (SP)+,A0
            _HUnlock
            movea.l (SP)+,A0
            _HUnlock
            rtd     #4
            ds.b    8
PutPicPixPat:
            move.l  A2,-(SP)
            movea.l (8,SP),A0
            _HLock
            movea.l (A0),A2
            movea.l (2,A2),A0
            movea.l (A0),A0
            move.w  (A2),-(SP)
            jsr     PutPicWord
            move.l  ($14,A2),-(SP)
            jsr     PutPicLong
            move.l  ($18,A2),-(SP)
            jsr     PutPicLong
            cmpi.w  #2,(A2)
            bne.b   .L1
            movea.l (2,A2),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            lea     ($28,A0),A0
            move.w  (6,A0),-(SP)
            move.l  (2,A0),-(SP)
            jsr     PutPicLong
            jsr     PutPicWord
            bra.b   .L2
.L1:
            move.l  (2,A2),-(SP)
            jsr     PutPicPixMap
            movea.l (6,A2),A0
            _HLock
            movea.l (2,A2),A1
            movea.l (A1),A1
            move.l  A1,-(SP)
            move.l  (A0),-(SP)
            move.w  (4,A1),D0
            andi.w  #$7FFF,D0
            move.w  D0,-(SP)
            jsr     PutPMData
            movea.l (6,A2),A0
            _HUnlock
.L2:
            movea.l (8,SP),A0
            _HUnlock
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            ds.b    10
GETDIRECTPMDATA:
            link.w  A6,#-$14
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$14,A6)
            movea.l ($C,A6),A2
            movea.l (8,A6),A0
            movea.l (A0),A3
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.w   .L23
            cmpi.w  #4,($10,A2)
            bgt.w   .L17
            beq.b   .L2
            cmpi.w  #3,($10,A2)
            beq.w   .L12
            move.w  D5,D0
            mulu.w  D7,D0
            lsr.l   #2,D0
            move.l  D0,D7
            add.l   D0,D0
            add.l   D7,D0
            move.l  A3,-(SP)
            add.l   D7,(SP)
            move.l  D0,-(SP)
            jsr     GETBIGPICDATA
            movea.l A3,A0
            movea.l A3,A1
            adda.l  D7,A1
.L1:
            clr.b   (A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            subq.l  #1,D7
            bhi.b   .L1
            bra.w   .L24
.L2:
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            suba.w  D5,SP
            move.w  D5,D0
            lsr.w   #7,D0
            addq.w  #2,D0
            bclr    #0,D0
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            cmpi.w  #4,($22,A2)
            beq.b   .L5
            move.w  D5,D1
            mulu.w  D7,D1
            lsr.l   #2,D1
            move.w  D1,D2
            swap    D1
            moveq   #0,D3
            movea.l A3,A0
            bra.b   .L4
.L3:
            move.l  D3,(A0)+
.L4:
            dbra    D2,.L3
            dbra    D1,.L4
.L5:
            addq.w  #4,A3
            suba.w  ($22,A2),A3
            move.w  D5,D4
            lsr.w   #2,D4
            mulu.w  ($22,A2),D4
            bra.b   .L11
.L6:
            cmpi.w  #$FA,D5
            bgt.b   .L7
            jsr     GetUByte
            bra.b   .L8
.L7:
            jsr     GetWord
.L8:
            move.l  (-$10,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            move.l  (-$C,A6),(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D4,-(SP)
            jsr     ([$1140.w])
            move.w  ($22,A2),D3
            subq.w  #1,D3
            movea.l (-$C,A6),A0
            move.w  D5,D0
            lsr.w   #2,D0
            subq.w  #1,D0
.L9:
            movea.l A3,A4
            addq.w  #1,A3
            move.w  D0,D6
.L10:
            move.b  (A0)+,(A4)
            addq.w  #4,A4
            dbra    D6,.L10
            dbra    D3,.L9
            suba.w  ($22,A2),A3
            adda.w  D5,A3
.L11:
            dbra    D7,.L6
            bra.b   .L24
.L12:
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$10,A6)
            move.l  A3,(-8,A6)
            bra.b   .L16
.L13:
            cmpi.w  #$FA,D5
            bgt.b   .L14
            jsr     GetUByte
            bra.b   .L15
.L14:
            jsr     GetWord
.L15:
            move.l  (-$10,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     UNPACKWORDS
.L16:
            dbra    D7,.L13
            bra.b   .L24
.L17:
            move.w  D5,D6
            mulu.w  D7,D6
            bra.b   .L21
.L18:
            cmpi.w  #$FA,D5
            bgt.b   .L19
            jsr     GetUByte
            bra.b   .L20
.L19:
            jsr     GetWord
.L20:
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
.L21:
            dbra    D7,.L18
            movea.l A3,A0
.L22:
            clr.b   (A0)+
            subq.l  #1,D6
            bhi.b   .L22
            bra.b   .L24
.L23:
            mulu.w  D7,D5
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            jsr     GETBIGPICDATA
.L24:
            movea.l (8,A6),A0
            movea.l (-$14,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    12
PUTDIRECTPMDATA:
            link.w  A6,#-$14
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$14,A6)
            movea.l ($E,A6),A2
            movea.l ($A,A6),A3
            move.w  (8,A6),D4
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.w   .L17
            cmpi.w  #2,($10,A2)
            blt.w   .L17
            beq.w   .L12
            cmpi.w  #3,($10,A2)
            beq.w   .L7
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            suba.w  D5,SP
            move.w  D5,D0
            lsr.w   #8,D0
            addq.w  #1,D0
            add.l   D0,D0
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            addq.w  #4,A3
            suba.w  ($22,A2),A3
            bra.b   .L6
.L1:
            move.w  ($22,A2),D3
            subq.w  #1,D3
            movea.l (-$C,A6),A0
            move.w  D5,D0
            lsr.w   #2,D0
            subq.w  #1,D0
.L2:
            movea.l A3,A4
            addq.w  #1,A3
            move.w  D0,D6
.L3:
            move.b  (A4),(A0)+
            addq.w  #4,A4
            dbra    D6,.L3
            dbra    D3,.L2
            suba.w  ($22,A2),A3
            move.l  (-$C,A6),(-4,A6)
            movea.l (-$10,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            addq.w  #1,D0
            mulu.w  ($22,A2),D0
            move.w  D0,-(SP)
            jsr     ([$113C.w])
            move.l  (-8,A6),D6
            movea.l (-$10,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L4
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L5
.L4:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L5:
            move.l  (-$10,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L6:
            dbra    D7,.L1
            bra.w   .L18
.L7:
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$10,A6)
            bra.b   .L11
.L8:
            move.l  A3,(-4,A6)
            movea.l (-$10,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     PACKWORDS
            move.l  (-8,A6),D6
            movea.l (-$10,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L9
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L10
.L9:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L10:
            move.l  (-$10,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L11:
            dbra    D7,.L8
            bra.w   .L18
.L12:
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            move.w  D5,D6
            lsr.w   #2,D6
            subq.w  #1,D6
            bra.b   .L15
.L13:
            movea.l (-$C,A6),A0
            movea.l A3,A4
            move.w  D6,D0
.L14:
            addq.w  #1,A4
            move.b  (A4)+,(A0)+
            move.b  (A4)+,(A0)+
            move.b  (A4)+,(A0)+
            dbra    D0,.L14
            suba.l  (-$C,A6),A0
            move.l  (-$C,A6),-(SP)
            move.w  A0,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L15:
            dbra    D7,.L13
            bra.b   .L18
.L16:
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L17:
            dbra    D7,.L16
.L18:
            movea.l (-$14,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    12
GETBIGPICDATA:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A3
            movea.l ($10,SP),A4
            move.l  A4,D7
            moveq   #$E,D0
            lsr.l   D0,D7
            beq.b   .L2
.L1:
            move.l  A3,-(SP)
            move.w  #$4000,-(SP)
            jsr     GetPicData
            lea     ($4000,A3),A3
            suba.w  #$4000,A4
            subq.l  #1,D7
            bne.b   .L1
.L2:
            move.l  A3,-(SP)
            move.w  A4,-(SP)
            jsr     GetPicData
            movem.l (SP)+,D7/A3-A4
            rtd     #8
            ds.b    6
PUTBIGPICDATA:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A3
            movea.l ($10,SP),A4
            move.l  A4,D7
            moveq   #$E,D0
            lsr.l   D0,D7
            beq.b   .L2
.L1:
            move.l  A3,-(SP)
            move.w  #$4000,-(SP)
            jsr     PutPicData
            lea     ($4000,A3),A3
            suba.w  #$4000,A4
            subq.l  #1,D7
            bne.b   .L1
.L2:
            move.l  A3,-(SP)
            move.w  A4,-(SP)
            jsr     PutPicData
            movem.l (SP)+,D7/A2-A4
            rtd     #8
            ds.b    6
GetPMData:
            link.w  A6,#-$10
            movem.l D4-D6/A2-A3,-(SP)
            move.l  SP,(-$10,A6)
            movea.l ($C,A6),A2
            movea.l (8,A6),A0
            movea.l (A0),A3
            moveq   #8,D6
            move.w  ($A,A2),D4
            sub.w   (6,A2),D4
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.b   .L6
            tst.w   (4,A2)
            bpl.b   .L1
            cmpi.w  #$10,($1E,A2)
            bne.b   .L1
            cmpi.w  #1,($10,A2)
            beq.b   .L6
            movem.l (SP)+,D4-D6/A2-A3
            unlk    A6
            jmp     GETDIRECTPMDATA
.L1:
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            move.l  A3,(-8,A6)
            bra.b   .L5
.L2:
            cmpi.w  #$FA,D5
            bgt.b   .L3
            jsr     GetUByte
            bra.b   .L4
.L3:
            jsr     GetWord
.L4:
            move.l  (-$C,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     ([$1140.w])
.L5:
            dbra    D4,.L2
            bra.b   .L7
.L6:
            mulu.w  D4,D5
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            jsr     GETBIGPICDATA
.L7:
            movea.l (8,A6),A0
            movea.l (-$10,A6),SP
            movem.l (SP)+,D4-D6/A2-A3
            unlk    A6
            rtd     #8
            ds.b    14
PutPMData:
            link.w  A6,#-$10
            movem.l D4-D7/A2-A3,-(SP)
            move.l  SP,(-$10,A6)
            movea.l ($E,A6),A2
            movea.l ($A,A6),A3
            move.w  (8,A6),D4
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.b   .L6
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            bra.b   .L4
.L1:
            move.l  A3,(-4,A6)
            movea.l (-$C,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     ([$113C.w])
            move.l  (-8,A6),D6
            movea.l (-$C,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L2
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L3
.L2:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L3:
            move.l  (-$C,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L4:
            dbra    D7,.L1
            bra.b   .L7
.L5:
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L6:
            dbra    D7,.L5
.L7:
            movea.l (-$10,A6),SP
            movem.l (SP)+,D4-D7/A2-A3
            unlk    A6
            rtd     #$A
            ds.b    8
CheckPic:
            movem.l D6-D7,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($5C,A3)
            beq.w   .L18
            cmpi.w  #$FFFF,($42,A3)
            blt.w   .L18
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            cmpi.w  #1,($62,A4)
            beq.w   .L7
            tst.w   (6,A3)
            bpl.w   .L6
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  (A0),D7
            move.w  (4,A0),D6
            cmp.l   ($74,A4),D7
            bne.b   .L1
            cmp.w   ($78,A4),D6
            beq.b   .L2
.L1:
            moveq   #$1F,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($74,A4)
            move.w  D6,($78,A4)
.L2:
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  (6,A0),D7
            move.w  ($A,A0),D6
            cmp.l   ($7A,A4),D7
            bne.b   .L3
            cmp.w   ($7E,A4),D6
            beq.b   .L6
.L3:
            cmp.l   ($DA0).w,D7
            bne.b   .L4
            cmp.w   ($DA4).w,D6
            bne.b   .L4
            moveq   #$1E,D0
            jsr     DPutPicOp
            bra.b   .L5
.L4:
            moveq   #$1D,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
.L5:
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($7A,A4)
            move.w  D6,($7E,A4)
.L6:
            btst    #7,HiliteMode
            bne.b   .L7
            moveq   #$1C,D0
            jsr     DPutPicOp
.L7:
            move.l  ($50,A3),D7
            tst.w   (6,A3)
            bpl.b   .L8
            move.l  ($24,A3),D7
            move.w  ($28,A3),D6
            cmpi.w  #1,($62,A4)
            bne.b   .L9
            move.w  D6,-(SP)
            move.l  D7,-(SP)
            movea.l SP,A1
            bsr.l   RGB2Old
            move.l  D0,D7
            addq.w  #6,SP
.L8:
            cmp.l   ($5A,A4),D7
            beq.b   .L11
            moveq   #$E,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($5A,A4)
            bra.b   .L11
.L9:
            cmp.l   ($64,A4),D7
            bne.b   .L10
            cmp.w   ($68,A4),D6
            beq.b   .L11
.L10:
            moveq   #$1A,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($64,A4)
            move.w  D6,($68,A4)
.L11:
            move.l  ($54,A3),D7
            tst.w   (6,A3)
            bpl.b   .L12
            move.l  ($2A,A3),D7
            move.w  ($2E,A3),D6
            cmpi.w  #1,($62,A4)
            bne.b   .L13
            move.w  D6,-(SP)
            move.l  D7,-(SP)
            movea.l SP,A1
            bsr.l   RGB2Old
            move.l  D0,D7
            addq.w  #6,SP
.L12:
            cmp.l   ($5E,A4),D7
            beq.b   .L15
            moveq   #$F,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($5E,A4)
            bra.b   .L15
.L13:
            cmp.l   ($6A,A4),D7
            bne.b   .L14
            cmp.w   ($6E,A4),D6
            beq.b   .L15
.L14:
            moveq   #$1B,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($6A,A4)
            move.w  D6,($6E,A4)
.L15:
            move.l  ($10,A3),D0
            cmp.l   ($56,A4),D0
            beq.b   .L16
            move.w  ($12,A3),D7
            sub.w   ($58,A4),D7
            add.w   D7,($58,A4)
            swap    D7
            move.w  ($10,A3),D7
            sub.w   ($56,A4),D7
            add.w   D7,($56,A4)
            moveq   #$C,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
.L16:
            clr.b   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($C,A4),-(SP)
            jsr     ([$118C.w])
            tst.b   (SP)+
            bne.b   .L17
            move.l  ($1C,A3),-(SP)
            move.l  ($C,A4),-(SP)
            moveq   #1,D0
            jsr     DPutPicOp
            move.l  ($1C,A3),-(SP)
            jsr     PutPicRgn
            jsr     ([$1170.w])
.L17:
            movea.l (A5),A4
            moveq   #1,D0
.L18:
            movem.l (SP)+,D6-D7
            rts
            dc.w    0
ScalePt:
            link.w  A6,#0
            movem.l D0-D3/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   SCALE1
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   SCALE1
            movem.l (SP)+,D0-D3/A0-A2
            unlk    A6
            rtd     #$C
SCALE1:
            move.w  (4,A1),D3
            sub.w   (A1),D3
            move.w  (4,A2),D2
            sub.w   (A2),D2
            cmp.w   D2,D3
            beq.b   .L3
            move.w  D3,D1
            lsr.w   #1,D1
            ext.l   D1
            move.w  (A0),D0
            bgt.b   .L1
            clr.w   (A0)
            rts
.L1:
            mulu.w  D2,D0
            add.l   D1,D0
            divu.w  D3,D0
            bne.b   .L2
            moveq   #1,D0
.L2:
            move.w  D0,(A0)
.L3:
            rts
            ds.b    12
MapPt:
            link.w  A6,#0
            movem.l D0-D5/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   MAP1_Pictures
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   MAP1_Pictures
            movem.l (SP)+,D0-D5/A0-A2
            unlk    A6
            rtd     #$C
MAP1_Pictures:
            move.w  (A1),D2
            move.w  (4,A1),D3
            sub.w   D2,D3
            move.w  (A2),D4
            move.w  (4,A2),D5
            sub.w   D4,D5
            move.w  (A0),D0
            sub.w   D2,D0
            cmp.w   D3,D5
            beq.b   .L2
            move.w  D3,D1
            lsr.w   #1,D1
            ext.l   D1
            move.w  D0,D2
            bpl.b   .L1
            neg.w   D0
.L1:
            mulu.w  D5,D0
            add.l   D1,D0
            divu.w  D3,D0
            tst.w   D2
            bpl.b   .L2
            neg.w   D0
.L2:
            add.w   D4,D0
            move.w  D0,(A0)
            rts
            dc.w    0
MapFixPt:
            link.w  A6,#0
            movem.l D0-D7/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   MAP1_Pictures_2
            addq.w  #4,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   MAP1_Pictures_2
            movem.l (SP)+,D0-D7/A0-A2
            unlk    A6
            rtd     #$C
MAP1_Pictures_2:
            move.l  (A1),D2
            clr.w   D2
            move.l  (4,A1),D3
            clr.w   D3
            sub.l   D2,D3
            move.l  (A2),D4
            clr.w   D4
            move.l  (4,A2),D5
            clr.w   D5
            sub.l   D4,D5
            move.l  (A0),D0
            sub.l   D2,D0
            cmp.l   D3,D5
            beq.b   .L1
            muls.l  D5,D6:D0
            divs.l  D3,D6:D0
.L1:
            add.l   D4,D0
            move.l  D0,(A0)
            rts
            ds.b    10
MapRect:
            move.l  ($C,SP),-(SP)
            move.l  ($C,SP),-(SP)
            move.l  ($C,SP),-(SP)
            bsr.w   MapPt
            addq.l  #4,($C,SP)
            bra.w   MapPt
            ds.b    8
MapRatio:
            link.w  A6,#0
            movem.l D0-D1/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            move.w  (6,A2),D0
            sub.w   (2,A2),D0
            move.w  (2,A0),D1
            mulu.w  D0,D1
            divu.w  (2,A1),D1
            move.w  D1,(2,A0)
            move.w  D0,(2,A1)
            move.w  (4,A2),D0
            sub.w   (A2),D0
            move.w  (A0),D1
            mulu.w  D0,D1
            divu.w  (A1),D1
            move.w  D1,(A0)
            move.w  D0,(A1)
            movem.l (SP)+,D0-D1/A0-A2
            unlk    A6
            rtd     #$C
            ds.b    8
