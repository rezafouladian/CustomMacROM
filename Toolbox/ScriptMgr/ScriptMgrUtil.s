            include "Include/ROMHeader.s"

            EXPORT  XSCRIPTUTIL,BitBucket,STDEXIT,STDUNLINK,utilTable,utilTableBase

            IMPORT  SwapIcon,SwapKybd,A

            SECTION "ScriptMgrUtil",CODE

STDUNLINK:
            unlk    A6
STDEXIT:
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
XSCRIPTUTIL:
            move.l  (4,SP),D0
            bclr    #$1F,D0
            bne.b   .L1
            movea.l (SP)+,A0
            swap    D0
            lsr.w   #1,D0
            move.b  utilTable.L1(PC,D0.w),D0
            move.w  D0,(SP)
            move.w  utilTable.L2(PC,D0.w),-(SP)
            move.l  A0,-(SP)
.L1:
            movea.l IntlSpec,A0
            cmp.w   ($58,A0),D0
            bgt.b   utilTable.L3
            cmp.w   ($56,A0),D0
            blt.b   BitBucket
            add.w   D0,D0
            movea.l ($52,A0),A0
            movea.l (0,A0,D0.w),A0
            jmp     (A0)
utilTableBase:
            dc.w    $0444,$29F4,$32A4,$2714,$20A4,$04E4,$0954,$07F4
            dc.w    $120C,$0E24,$0C14,$1634,$1584,$13C4
utilTable:
            dc.w    $006E,$0094,$0132,$00C0,$0206,$0246,$02B6,$032A
.L1:
            dc.w    $1012,$1416,$181A,$1C1E,$200C,$0E08,$0A00,$0204
            dc.w    $0600
.L2:
            dc.w    $0200,$0200,$0002,$0202,$0402,$0206,$0404,$0208
            dc.w    $0206,$0206,$020E,$020C,$020E,$0012,$000E,$0008
            dc.w    $000C
.L3:
            subq.w  #6,SP
            bsr.b   sub_4081E3DA
            addq.w  #2,SP
            movea.l ($24,A0),A0
            jmp     (A0)
BitBucket:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
BitBucketReg:
            swap    D0
            moveq   #0,D1
            move.b  D0,D1
            lsr.w   #8,D0
            andi.w  #$7F,D0
            adda.w  D1,SP
            movea.l SP,A1
            bra.b   .L2
.L1:
            clr.b   (A1)+
.L2:
            dbra    D0,.L1
            jmp     (A0)
sub_4081E3DA:
            tst.b   QDExist
            beq.b   .L2
.L1:
            moveq   #0,D0
            bra.b   .L3
.L2:
            move.l  (A5),D0
            ble.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            move.w  ($44,A0),D0
.L3:
            movea.l IntlSpec,A1
            moveq   #0,D1
            move.b  (6,A1),D1
            move.l  (SP)+,D2
            addq.l  #4,SP
            bra.b   .L7
            tst.b   QDExist
            beq.b   .L5
.L4:
            moveq   #0,D0
            bra.b   .L6
.L5:
            move.l  (A5),D0
            ble.b   .L4
            movea.l D0,A0
            movea.l (A0),A0
            move.w  ($44,A0),D0
.L6:
            movea.l IntlSpec,A1
            move.b  (7,A1),D1
            ext.w   D1
            ext.l   D1
            or.b    (6,A1),D1
            move.l  (SP)+,D2
            addq.l  #4,SP
            bra.b   .L7
            move.l  (SP)+,D2
            addq.l  #4,SP
            movea.l IntlSpec,A1
            moveq   #0,D1
            move.b  (6,A1),D1
            move.w  (SP)+,D0
.L7:
            clr.w   (8,A1)
            cmpi.w  #1,D0
            bhi.b   .L9
            bcs.b   .L8
            move.w  ApFontID,D0
            bra.b   .L9
.L8:
            move.w  SysFontFam,D0
.L9:
            subi.w  #$4000,D0
            bmi.b   .L10
            move.w  #9,D1
            lsr.w   D1,D0
            addq.w  #1,D0
            tst.l   D1
            bpl.b   .L12
            cmp.w   ($26,A1),D0
            bne.b   .L11
            bra.b   .L12
.L10:
            moveq   #0,D0
            tst.b   D1
            beq.b   .L12
.L11:
            st      (8,A1)
            move.w  ($26,A1),D0
.L12:
            move.w  D0,D1
            lsl.w   #2,D1
            move.l  ($72,A1,D1.w),D1
            beq.b   .L13
            movea.l D1,A0
            tst.b   (4,A0)
            bne.b   .L14
.L13:
            move.w  #$FF,(8,A1)
            clr.w   D0
            movea.l ($72,A1),A0
.L14:
            move.w  D0,(SP)
            movea.l D2,A1
            jmp     (A1)
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l IntlSpec,A2
            tst.b   (4,A2)
            beq.w   .L23
            move.l  ($176,A2),D0
            beq.b   .L15
            movea.l D0,A0
            _DisposHandle
            lea     ($176,A2),A0
            clr.l   (A0)
.L15:
            clr.l   -(SP)
            move.w  ($C,A6),-(SP)
            move.w  #$20,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            blt.b   .L16
            clr.l   -(SP)
            move.l  #'itlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L16
            lea     ($176,A2),A0
            move.l  D0,(A0)
            move.l  D0,-(SP)
            _DetachResource
.L16:
            move.w  ($C,A6),D1
            cmpi.w  #$41,D1
            bge.b   .L23
            addq.w  #1,D1
            beq.b   .L19
            move.w  ($26,A2),D0
            addq.w  #1,D1
            beq.b   .L18
            move.w  ($28,A2),D0
            addq.w  #1,D1
            blt.b   .L23
            bne.b   .L17
            cmp.w   ($2A,A2),D0
            beq.b   .L19
            bra.b   .L18
.L17:
            move.w  ($C,A6),D0
.L18:
            move.w  D0,D1
            lsl.w   #2,D1
            move.l  ($72,A2,D1.w),D1
            beq.b   .L23
            movea.l D1,A0
            tst.b   (4,A0)
            beq.b   .L23
            bra.b   .L22
.L19:
            move.w  ($2A,A2),D0
.L20:
            addq.w  #1,D0
            cmpi.w  #$41,D0
            blt.b   .L21
            moveq   #0,D0
.L21:
            move.w  D0,D1
            lsl.w   #2,D1
            move.l  ($72,A2,D1.w),D1
            beq.b   .L20
            movea.l D1,A0
            tst.b   (4,A0)
            beq.b   .L20
.L22:
            move.w  ($2A,A2),D1
            move.w  D1,($28,A2)
            move.w  D0,($2A,A2)
            addq.w  #1,(2,A2)
            bsr.w   SwapKybd
            bsr.w   SwapIcon
.L23:
            movea.l (SP)+,A2
            move.w  #6,D0
            bra.w   STDUNLINK
            link.w  A6,#0
            moveq   #0,D0
            movea.l IntlSpec,A1
            move.w  ($C,A6),D2
            cmpi.w  #$22,D2
            bhi.b   .L26
            lea     .L31,A0
            moveq   #0,D1
            adda.w  D2,A0
            move.b  (A0)+,D1
            lea     (0,A1,D1.w),A1
            move.b  (A0),D1
            subq.w  #2,D1
            bmi.b   .L24
            beq.b   .L25
            move.l  (A1),D0
            bra.b   .L26
.L24:
            move.b  (A1),D0
            bra.b   .L26
.L25:
            move.w  (A1),D0
.L26:
            move.l  D0,($E,A6)
            move.w  #6,D0
            bra.w   STDUNLINK
            link.w  A6,#0
            move.w  #$FFFF,($12,A6)
            movea.l IntlSpec,A1
            move.w  ($10,A6),D2
            cmpi.w  #$22,D2
            bhi.b   .L30
            addq.w  #1,(2,A1)
            lea     .L31,A0
            moveq   #0,D1
            adda.w  D2,A0
            move.b  (A0)+,D1
            lea     (0,A1,D1.w),A1
            move.b  (A0),D1
            move.l  ($C,A6),D0
            subq.w  #2,D1
            bmi.b   .L27
            beq.b   .L28
            move.l  D0,(A1)
            bra.b   .L29
.L27:
            move.b  D0,(A1)
            bra.b   .L29
.L28:
            move.w  D0,(A1)
.L29:
            clr.w   ($12,A6)
.L30:
            move.w  #$A,D0
            bra.w   STDUNLINK
.L31:
            dc.w    $0002,$0202,$0401,$0501,$0601,$0701,$0801,$0901
            dc.w    $1604,$2602,$2802,$2A02,$3402,$3C04,$3604,$0A04
            dc.w    $0E04,$3A02
            link.w  A6,#0
            move.w  ($E,A6),D0
            cmpi.w  #$40,D0
            bhi.b   .L33
            movea.l IntlSpec,A0
            lsl.w   #2,D0
            move.l  ($72,A0,D0.w),D0
            beq.b   .L33
            movea.l D0,A1
            tst.b   (4,A1)
            beq.b   .L33
            move.w  ($C,A6),D2
            bge.b   .L34
.L32:
            movea.l ($24,A1),A0
            unlk    A6
            jmp     (A0)
.L33:
            moveq   #0,D0
            bra.b   .L38
.L34:
            cmpi.w  #$2E,D2
            blt.b   .L35
            cmpi.w  #$4C,D2
            ble.b   .L32
.L35:
            cmpi.w  #$54,D2
            bhi.b   .L38
            lea     .L48,A0
            moveq   #0,D1
            adda.w  D2,A0
            move.b  (A0)+,D1
            lea     (0,A1,D1.w),A1
            move.b  (A0),D1
            moveq   #0,D0
            subq.w  #2,D1
            bmi.b   .L36
            beq.b   .L37
            move.l  (A1),D0
            bra.b   .L38
.L36:
            move.b  (A1),D0
            bra.b   .L38
.L37:
            move.w  (A1),D0
.L38:
            move.l  D0,($10,A6)
            move.w  #8,D0
            bra.w   STDUNLINK
            link.w  A6,#0
            move.w  ($12,A6),D0
            cmpi.w  #$40,D0
            bhi.b   .L46
            movea.l IntlSpec,A0
            lsl.w   #2,D0
            move.l  ($72,A0,D0.w),D0
            beq.b   .L46
            movea.l D0,A1
            tst.b   (4,A1)
            beq.b   .L46
            move.w  ($10,A6),D2
            bge.b   .L40
.L39:
            movea.l ($24,A1),A0
            unlk    A6
            jmp     (A0)
.L40:
            cmpi.w  #$2E,D2
            blt.b   .L41
            cmpi.w  #$4C,D2
            ble.b   .L39
.L41:
            cmpi.w  #$54,D2
            bhi.b   .L47
            addq.w  #1,(2,A1)
            lea     .L48,A0
            moveq   #0,D1
            adda.w  D2,A0
            move.b  (A0)+,D1
            lea     (0,A1,D1.w),A1
            move.b  (A0),D1
            move.l  ($C,A6),D0
            subq.w  #2,D1
            bmi.b   .L42
            beq.b   .L43
            move.l  D0,(A1)
            bra.b   .L44
.L42:
            move.b  D0,(A1)
            bra.b   .L44
.L43:
            move.w  D0,(A1)
.L44:
            moveq   #0,D0
.L45:
            move.w  D0,($14,A6)
            move.w  #$C,D0
            bra.w   STDUNLINK
.L46:
            move.w  #$FFFE,D0
            bra.b   .L45
.L47:
            moveq   #-1,D0
            bra.b   .L45
.L48:
            dc.w    $0002,$0202,$0401,$0501,$0601,$0701,$0802,$0A02
            dc.w    $0C02,$0E02,$1002,$1202,$1402,$1602,$1802,$1A02
            dc.w    $1C02,$1E02,$2004,$2404,$2804,$2C04,$3004
            ds.b    10

            EVEN
