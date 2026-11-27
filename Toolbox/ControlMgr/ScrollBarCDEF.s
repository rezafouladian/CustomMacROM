            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryCDEF_1

            IMPORT  BaseOfROM,RsrcEntryMBDF_0

            SECTION "ScrollBarCDEF",CODE

RsrcEntryCDEF_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CDEF' 1 (1492 bytes) - Combo mask
            dc.l    RsrcEntryMBDF_0-BaseOfROM       ; Next entry
            dc.l    RsrcCDEF_1-BaseOfROM            ; Data
            dc.b    'CDEF'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000005E0,$000000F4   ; Block header
RsrcCDEF_1:
            bra.b   .L1
            dc.w    0,$4344,$4546,$0001,$000A
.L1:
            link.w  A6,#-$32
            movem.l D3-D6/A1-A4,-(SP)
            cmpi.w  #6,($C,A6)
            bls.b   .L2
            cmpi.w  #$A,($C,A6)
            beq.b   .L2
            cmpi.w  #$B,($C,A6)
            bne.w   .L5
.L2:
            pea     (-$14,A6)
            _GetPenState
            _PenNormal
            cmpi.w  #$3FFF,ROM85
            sls     (-$16,A6)
            bhi.b   .L3
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (-$2C,A6)
            _GetForeColor
            pea     (-$32,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.b   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$22,A6)
            _HLock
            move.l  (A0),(-$26,A6)
.L3:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D6
            clr.l   (A0)
            movea.l (A3),A0
            cmpi.w  #6,D0
            bls.w   .L4
            subq.w  #3,D0
.L4:
            add.w   D0,D0
            lea     .L6,A1
            adda.w  (0,A1,D0.w),A1
            jsr     (A1)
            pea     (-$14,A6)
            _SetPenState
            tst.b   (-$16,A6)
            beq.b   .L5
            movea.l (-$22,A6),A0
            _HUnlock
            pea     (-$2C,A6)
            _RGBForeColor
            pea     (-$32,A6)
            _RGBBackColor
.L5:
            movem.l (SP)+,D3-D6/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L6:
            dc.w    $013A,$0326,$03C8,$0464,$0470,$0412,$0490,$03EC
            dc.w    $03FC
.L7:
            dc.w    $FFFF,$8081,$80C1,$80A1,$8F91,$8809,$8805,$8803
            dc.w    $8805,$8809,$8F91,$80A1,$80C1,$8081,$8001,$FFFF
            dc.w    $FFFF,$8081,$80C1,$80E1,$8FF1,$8FF9,$8FFD,$8FFF
            dc.w    $8FFD,$8FF9,$8FF1,$80E1,$80C1,$8081,$8001,$FFFF
.L8:
            dc.w    $FFFF,$8101,$8301,$8501,$89F1,$9011,$A011,$C011
            dc.w    $A011,$9011,$89F1,$8501,$8301,$8101,$8001,$FFFF
            dc.w    $FFFF,$8101,$8301,$8701,$8FF1,$9FF1,$BFF1,$FFF1
            dc.w    $BFF1,$9FF1,$8FF1,$8701,$8301,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8001,$8FE1,$8821,$8821,$8821,$F83D
            dc.w    $A009,$9011,$8821,$8441,$8281,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8001,$8FE1,$8FE1,$8FE1,$8FE1,$FFFD
            dc.w    $BFF9,$9FF1,$8FE1,$87C1,$8381,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8101,$8281,$8441,$8821,$9011,$A009
            dc.w    $F83D,$8821,$8821,$8821,$8FE1,$8001,$8001,$FFFF
            dc.w    $FFFF,$8001,$8101,$8381,$87C1,$8FE1,$9FF1,$BFF9
            dc.w    $FFFD,$8FE1,$8FE1,$8FE1,$8FE1,$8001,$8001,$FFFF
sub_40879498:
            move.l  D1,-(SP)
            movea.l (-$26,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
            tst.b   (-$16,A6)
            beq.b   .L3
            moveq   #0,D0
            bsr.b   sub_40879498
            _RGBForeColor
            moveq   #1,D0
            bsr.b   sub_40879498
            _RGBBackColor
            movea.l (A3),A0
.L3:
            tst.b   ($10,A0)
            beq.w   sub_40879572.L1
            cmpi.b  #$FF,D3
            bne.b   .L4
            moveq   #0,D3
.L4:
            move.b  ($11,A0),D4
            bsr.w   sub_40879698
            bsr.w   TestHV
            move.w  (0,A1,D0.w),D1
            add.w   D2,D1
            move.w  D1,(4,A1,D0.w)
            lea     RsrcCDEF_1.L8,A1
            moveq   #$14,D1
            movem.w D0/D2,-(SP)
            bsr.b   sub_40879572
            bne.b   .L5
            bsr.w   sub_408795E0
.L5:
            bsr.w   sub_40879698
            movem.w (SP)+,D0/D2
            move.w  (4,A1,D0.w),D1
            sub.w   D2,D1
            move.w  D1,(0,A1,D0.w)
            lea     RsrcCDEF_1.L7,A1
            moveq   #$15,D1
            bsr.b   sub_40879572
            bne.b   .L6
            bsr.w   sub_408795E0
.L6:
            cmpi.w  #1,D6
            beq.w   sub_4087957A.L4
            move.w  #$81,D1
            bsr.b   sub_40879572
            bne.b   sub_40879572.L1
            bsr.w   sub_40879698
            move.l  A1,-(SP)
            bsr.w   GetOldStyleLtGray
            move.l  A0,-(SP)
            bsr.b   sub_4087957A
            bne.b   .L7
            movea.l (A5),A0
            lea     (-8,A0),A0
            move.l  A0,(SP)
.L7:
            lea     Scratch8,A1
            movea.l A1,A0
            bsr.b   TestHV
            swap    D2
            move.w  #1,D2
            tst.w   D0
            beq.b   .L8
            swap    D2
.L8:
            move.l  A1,-(SP)
            move.l  D2,-(SP)
            _InsetRect
            _FillRect
            bra.b   sub_4087957A.L2
sub_40879572:
            tst.w   D3
            beq.b   .L1
            cmp.w   D1,D3
.L1:
            rts
sub_4087957A:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            addq.b  #1,D0
            beq.b   .L1
            addq.b  #1,D0
            beq.b   .L1
            move.w  ($14,A0),D0
            cmp.w   ($16,A0),D0
.L1:
            rts
.L2:
            tst.b   (-$16,A6)
            beq.b   .L3
            moveq   #3,D0
            bsr.w   sub_40879498
            _RGBBackColor
.L3:
            bsr.w   CalcIBox
            bsr.b   sub_4087957A
            beq.b   .L4
            move.l  ($1C,A0),-(SP)
            move.l  (SP),-(SP)
            movea.l (A5),A0
            pea     (-8,A0)
            _FillRgn
            _FrameRgn
.L4:
            movea.l (A3),A0
            pea     (8,A0)
            _FrameRect
            rts
TestHV:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (6,A0),D1
            sub.w   (2,A0),D1
            cmp.w   D0,D1
            bgt.b   .L1
            move.w  D1,D2
            moveq   #0,D0
            rts
.L1:
            move.w  D0,D2
            moveq   #2,D0
            rts
sub_408795E0:
            movea.l (A3),A0
            cmp.b   ($11,A0),D1
            bne.b   .L1
            lea     ($20,A1),A1
.L1:
            tst.w   D0
            bne.b   .L2
            lea     ($80,A1),A1
.L2:
            clr.w   D0
            bsr.b   sub_408795FA
            rts
sub_408795FA:
            lea     ($A0E).w,A0
            move.l  A1,(A0)+
            move.w  #2,(A0)+
            clr.l   (A0)+
            move.l  #$100010,(A0)
            pea     ($A0E).w
            movea.l (SP),A0
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
CalcIBox:
            move.w  D3,-(SP)
            lea     (-$1E,A6),A1
            bsr.b   GetCtlRect
            moveq   #0,D1
            movea.l (A3),A0
            lea     (8,A0),A0
            bsr.b   TestHV
            move.w  D2,D3
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            sub.w   D2,D1
            sub.w   D2,D1
            sub.w   D2,D1
            movea.l (A3),A0
            move.w  ($12,A0),D2
            sub.w   ($14,A0),D2
            mulu.w  D2,D1
            move.w  ($16,A0),D2
            sub.w   ($14,A0),D2
            beq.b   .L2
            divu.w  D2,D1
            bsr.w   RoundOff
            add.w   D3,D1
.L1:
            lea     (-$1E,A6),A1
            add.w   (0,A1,D0.w),D1
            move.w  D1,(0,A1,D0.w)
            add.w   D3,D1
            move.w  D1,(4,A1,D0.w)
            eori.w  #2,D0
            addq.w  #1,(0,A1,D0.w)
            subq.w  #1,(4,A1,D0.w)
            move.l  ($1C,A0),-(SP)
            move.l  A1,-(SP)
            _RectRgn
            move.w  (SP)+,D3
            rts
.L2:
            move.w  D3,D1
            bra.b   .L1
sub_40879698:
            lea     Scratch8,A1
GetCtlRect:
            movea.l (A3),A0
            lea     (8,A0),A0
            move.l  (A0),(A1)
            move.l  (4,A0),(4,A1)
.L1:
            rts
            move.b  ($11,A0),D4
            cmpi.b  #$FE,D4
            beq.b   .L2
            bsr.w   sub_4087957A
            beq.b   .L1
.L2:
            lea     (8,A0),A4
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  A4,-(SP)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L1
            addq.b  #2,D4
            beq.b   .L5
            bsr.b   sub_40879742
            move.w  D3,D1
            sub.w   (0,A4,D0.w),D1
            cmp.w   D2,D1
            bgt.b   .L3
            moveq   #$14,D0
            bra.b   .L4
.L3:
            move.w  (4,A4,D0.w),D1
            sub.w   D3,D1
            cmp.w   D2,D1
            bgt.b   .L6
            moveq   #$15,D0
.L4:
            move.w  D0,($16,A6)
            rts
.L5:
            move.w  #$FE,D0
            bra.b   .L4
.L6:
            cmpi.w  #1,D6
            beq.b   .L1
            bsr.w   CalcIBox
            bsr.b   sub_40879742
            clr.w   -(SP)
            move.l  D3,-(SP)
            movea.l (A3),A0
            move.l  ($1C,A0),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L7
            move.w  #$81,D0
            bra.b   .L4
.L7:
            bsr.b   sub_40879742
            movea.l (A3),A0
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            lsr.w   #1,D1
            add.w   (0,A0,D0.w),D1
            cmp.w   D1,D3
            blt.b   .L8
            moveq   #$17,D0
            bra.b   .L4
.L8:
            moveq   #$16,D0
            bra.b   .L4
sub_40879742:
            movea.l A4,A0
            bsr.w   TestHV
            bne.b   .L1
            swap    D3
.L1:
            rts
            tst.l   D3
            bpl.b   .L3
            andi.l  #$FFFFFF,D3
.L2:
            bsr.w   CalcIBox
            movea.l (A3),A0
            move.l  ($1C,A0),-(SP)
            move.l  D3,-(SP)
            _CopyRgn
            bsr.b   GetOldStyleLtGray
            move.l  (A0)+,DragPattern
            move.l  (A0),($A38).w
            rts
            move.b  #1,($17,A6)
.L3:
            move.l  D3,-(SP)
            pea     (8,A0)
            _RectRgn
            rts
            move.b  #1,($17,A6)
            bra.b   .L2
GetOldStyleLtGray:
            subq.w  #4,SP
            move.w  #$11,-(SP)
            _GetPattern
            movea.l (SP)+,A0
            movea.l (A0),A0
            rts
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            lea     (2,A0),A4
            add.w   (2,A4),D3
            swap    D3
            add.w   (A4),D3
            movea.l (A3),A0
            lea     (8,A0),A0
            bsr.w   TestHV
            beq.b   .L1
            swap    D3
.L1:
            sub.w   (0,A0,D0.w),D3
            sub.w   D2,D3
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            sub.w   D2,D1
            sub.w   D2,D1
            sub.w   D2,D1
            move.w  D1,D2
            movea.l (A3),A0
            move.w  ($16,A0),D1
            sub.w   ($14,A0),D1
            mulu.w  D3,D1
            divu.w  D2,D1
            bsr.b   RoundOff
            add.w   ($14,A0),D1
            move.l  A3,-(SP)
            move.w  D1,-(SP)
            _SetCtlValue
            rts
            subq.w  #4,SP
            _NewRgn
            movea.l (A3),A0
            move.l  (SP)+,($1C,A0)
            rts
            movea.l ($1C,A0),A0
            _DisposHandle
            rts
RoundOff:
            move.w  D0,-(SP)
            move.w  D2,D0
            lsr.w   #1,D0
            swap    D1
            cmp.w   D0,D1
            ble.b   .L2
            swap    D1
            addq.w  #1,D1
.L1:
            move.w  (SP)+,D0
            rts
.L2:
            swap    D1
            bra.b   .L1
            movea.l D3,A4
            move.l  (A4),D3
            lea     (A4),A2
            movea.l A2,A1
            bsr.w   GetCtlRect
            movea.l A2,A0
            bsr.w   TestHV
            move.w  D2,-(SP)
            swap    D2
            move.w  #$FFE8,D2
            move.w  D0,D4
            beq.b   .L3
            swap    D2
            bra.b   .L4
.L3:
            swap    D3
.L4:
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            _InsetRect
            lea     (8,A4),A0
            move.l  (A4),(A0)
            move.l  (4,A4),(4,A0)
            move.l  #$FF800000,D0
            tst.w   D4
            beq.b   .L5
            swap    D0
.L5:
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            _InsetRect
            movea.l (A3),A0
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            sub.w   (2,A0,D4.w),D3
            add.w   D3,(0,A2,D4.w)
            move.w  (SP)+,D2
            subq.w  #1,D2
            sub.w   D2,(4,A2,D4.w)
            add.w   D3,(4,A2,D4.w)
            lsr.w   #1,D4
            eori.w  #1,D4
            addq.w  #1,D4
            move.w  D4,($10,A4)
            rts
            ds.b    8

            EVEN
