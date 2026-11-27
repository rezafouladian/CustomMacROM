            include "Include/ROMHeader.s"

            IMPORT  STDUNLINK,A

            SECTION "ScriptMgrUtilDate",CODE

MonthStarts:
            dc.w    0,$001F,$003B,$005A,$0078,$0097,$00B5,$00D4
            dc.w    $00F3,$0111,$0130,$014E,$03E8
LeapStarts:
            dc.w    0,$001F,$003C,$005B,$0079,$0098,$00B6,$00D5
            dc.w    $00F4,$0112,$0131,$014F,$03E8,$400F
secsInDayX:
            dc.w    $400F,$A8C0
            ds.b    6
            dc.w    $401E
maxOldDate:
            dc.w    $401E,$FFFF,$FFFF
            ds.b    4
maxVal:
            dc.w    0,$0096,$000D,$0023,$0018,$003C,$003C,$0007
            dc.w    $0190,$003C
ValidDate:
            link.w  A6,#-$1C
            movem.l D3/A2-A4,-(SP)
            move.w  #1,D3
            movea.l ($C,A6),A2
            lea     (-$1C,A6),A3
            movea.l ($14,A6),A4
            move.l  A4,-(SP)
            move.l  A2,-(SP)
            move.l  #$8008FFF2,-(SP)
            _ScriptUtil
            move.l  ($10,A6),D0
            btst    #$1F,D0
            beq.b   .L1
            tst.l   (A2)
            bne.b   .L3
            btst    #$1B,D0
            beq.b   .L1
            cmpi.l  #$1E187E00,(4,A2)
            bcs.b   .L3
            cmpi.l  #$DA319179,(4,A2)
            bhi.b   .L3
.L1:
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            move.l  #$8008FFF0,-(SP)
            _ScriptUtil
            move.l  ($10,A6),D2
            move.w  #$FFFF,D3
            adda.w  #$16,A4
            adda.w  #$16,A3
            moveq   #$A,D1
.L2:
            move.w  -(A3),D0
            cmp.w   -(A4),D0
            dbne    D1,.L2
            beq.b   .L3
            btst    D1,D2
            dbne    D1,.L2
            beq.b   .L3
            move.w  D1,D3
.L3:
            move.w  D3,($18,A6)
            movem.l (SP)+,D3/A2-A4
            move.w  #$10,D0
            bra.w   STDUNLINK
            dc.b    8,'VALIDDAT'
            ds.b    9
ToggleDate:
            link.w  A6,#-$60
            movem.l D3-D7/A2-A4,-(SP)
            move.b  ($12,A6),D3
            ext.w   D3
            moveq   #0,D4
            move.b  ($14,A6),D4
            move.w  D4,D0
            add.w   D0,D0
            lea     (-$1C,A6,D0.w),A2
            lea     maxVal,A4
            movea.l ($C,A6),A0
            move.l  (A0),D0
            andi.w  #$7F,D0
            btst    #$1C,D0
            beq.b   .L1
            ori.w   #$400,D0
.L1:
            move.l  D0,(-$60,A6)
            move.l  ($16,A6),-(SP)
            pea     (-$1C,A6)
            move.l  #$8008FFF0,-(SP)
            _ScriptUtil
            tst.w   (-$1C,A6)
            blt.w   sub_4081EAD4.L7
            move.w  #7,($1A,A6)
            move.l  (-$60,A6),D0
            btst    #$1F,D0
            beq.b   .L3
            movea.l ($16,A6),A0
            tst.l   (A0)
            bne.w   sub_4081EAD4.L11
            btst    #$1B,D0
            beq.b   .L3
            cmpi.l  #$1E187E00,(4,A0)
            bcs.b   .L2
            cmpi.l  #$DA319179,(4,A0)
            bls.b   .L3
            subi.w  #$64,(-$1A,A6)
            bra.b   .L3
.L2:
            addi.w  #$64,(-$1A,A6)
.L3:
            move.w  #3,($1A,A6)
            move.w  D3,D0
            subq.w  #1,D0
            bgt.b   .L4
            addq.w  #2,D0
            blt.b   .L4
            move.w  #2,($1A,A6)
            cmpi.w  #$A,D4
            bne.b   .L5
            tst.w   D3
            beq.b   .L6
            bra.w   .L24
.L4:
            bra.w   sub_4081EAD4.L11
.L5:
            cmpi.w  #1,D4
            blt.b   .L4
            cmpi.w  #6,D4
            bgt.b   .L4
.L6:
            tst.w   D3
            bne.w   sub_4081EAD4.L1
            move.w  #4,($1A,A6)
            lea     ($10,A6),A0
            moveq   #2,D0
            _UpperText
            move.w  (A0),D6
            beq.b   .L4
            cmpi.w  #$A,D4
            bne.b   .L9
            movea.l ($C,A6),A0
            addq.w  #8,A0
            cmpi.w  #$C,(-$14,A6)
            blt.b   .L7
            subq.w  #4,A0
.L7:
            moveq   #3,D1
.L8:
            cmp.b   (A0)+,D6
            dbeq    D1,.L8
            beq.w   .L24
.L9:
            move.w  #6,($1A,A6)
            cmpi.w  #$FF,D6
            bhi.w   .L23
            andi.w  #$7F,D6
            cmpi.w  #$30,D6
            bcs.w   .L23
            cmpi.w  #$39,D6
            bhi.w   .L23
            andi.b  #$F,D6
            move.w  (A2),D5
            cmpi.w  #4,D4
            bne.b   .L12
            move.l  (-$60,A6),D1
            btst    #$1E,D1
            beq.b   .L12
            btst    #$1D,D1
            beq.b   .L10
            cmpi.w  #$C,D5
            blt.b   .L12
            subi.w  #$C,D5
            bra.b   .L12
.L10:
            cmpi.w  #$C,D5
            ble.b   .L11
            subi.w  #$C,D5
            bra.b   .L12
.L11:
            tst.w   D5
            bne.b   .L12
            moveq   #$C,D5
.L12:
            move.w  D5,D1
            ext.l   D1
            divs.w  #$64,D1
            swap    D1
            move.w  D5,D7
            sub.w   D1,D7
            sub.w   D7,D5
            bge.b   .L13
            neg.w   D6
.L13:
            muls.w  #$A,D5
            cmpi.w  #$64,D5
            blt.b   .L14
            divs.w  #$64,D5
            swap    D5
.L14:
            move.w  D7,D0
            add.w   D5,D0
            add.w   D6,D0
            cmpi.w  #4,D4
            bne.b   .L18
            move.l  (-$60,A6),D1
            btst    #$1E,D1
            beq.b   .L18
            btst    #$1D,D1
            beq.b   .L15
            cmpi.w  #$C,D0
            bge.b   .L17
            tst.w   (-8,A6)
            beq.b   .L18
            addi.w  #$C,D0
            bra.b   .L18
.L15:
            tst.w   D0
            beq.b   .L17
            tst.w   (-8,A6)
            beq.b   .L16
            cmpi.w  #$C,D0
            beq.b   .L18
            bgt.b   .L17
            addi.w  #$C,D0
            bra.b   .L18
.L16:
            cmpi.w  #$C,D0
            bgt.b   .L17
            blt.b   .L18
            clr.w   D0
            bra.b   .L18
.L17:
            move.w  #$FFFF,D0
.L18:
            move.w  D0,(A2)
            bsr.w   sub_4081EAAE
            blt.w   sub_4081EAD4.L8
            cmpi.w  #1,D4
            bne.b   .L22
            move.l  (-$60,A6),D0
            btst    #$1F,D0
            beq.b   .L22
            btst    #$1B,D0
            beq.b   .L22
            tst.l   (-$5C,A6)
            bmi.b   .L20
            bne.b   .L19
            cmpi.l  #$1E187E00,(-$58,A6)
            bcs.b   .L20
            cmpi.l  #$DA319179,(-$58,A6)
            bls.b   .L22
.L19:
            subi.w  #$64,(A2)
            bra.b   .L21
.L20:
            addi.w  #$64,(A2)
.L21:
            bsr.b   sub_4081EAAE
            blt.w   sub_4081EAD4.L8
.L22:
            tst.w   D5
            bne.w   .L13
            tst.w   D6
            beq.b   .L23
            move.w  D6,D5
            clr.w   D6
            bra.w   .L13
.L23:
            bra.w   sub_4081EAD4.L11
.L24:
            move.w  (-$14,A6),D0
            subi.w  #$C,D0
            bge.b   .L25
            addi.w  #$18,D0
.L25:
            move.w  D0,(-$14,A6)
            pea     (-$1C,A6)
            move.l  ($16,A6),-(SP)
            move.l  #$8008FFF2,-(SP)
            _ScriptUtil
            bra.w   sub_4081EAD4.L9
sub_4081EAAE:
            clr.w   -(SP)
            pea     (-$1C,A6)
            move.l  (-$60,A6),-(SP)
            pea     (-$5C,A6)
            move.l  #$820CFFE4,-(SP)
            _ScriptUtil
            move.w  (SP)+,D0
            rts
sub_4081EAC8:
            lea     (-$1C,A6),A0
            lea     (-$38,A6),A1
sub_4081EAD0:
            move.w  #$D,D0
sub_4081EAD4:
            move.w  (A0)+,(A1)+
            dbra    D0,sub_4081EAD4
            rts
.L1:
            bsr.b   sub_4081EAC8
            add.w   D3,(A2)
            bsr.b   sub_4081EAAE
            blt.b   .L8
            cmpi.w  #$A,D0
            bne.b   .L2
            move.w  #4,D0
.L2:
            cmp.w   D4,D0
            ble.b   .L4
            add.w   D0,D0
            lea     (-$1C,A6,D0.w),A3
            move.w  (0,A4,D0.w),D5
.L3:
            subq.w  #1,(A3)
            bsr.b   sub_4081EAAE
            dblt    D5,.L3
            blt.b   .L8
.L4:
            lea     (-$38,A6),A0
            lea     (-$1C,A6),A1
            bsr.b   sub_4081EAD0
            move.w  D4,D0
            add.w   D0,D0
            move.w  (0,A4,D0.w),D5
            move.w  D5,D0
            tst.w   D3
            blt.b   .L5
            neg.w   D0
.L5:
            add.w   D0,(A2)
.L6:
            add.w   D3,(A2)
            bsr.b   sub_4081EAAE
            dblt    D5,.L6
            blt.b   .L8
.L7:
            moveq   #5,D0
            bra.b   .L10
.L8:
            lea     (-$5C,A6),A0
            movea.l ($16,A6),A1
            move.w  #4,D0
            bsr.b   sub_4081EAD4
.L9:
            moveq   #1,D0
.L10:
            move.w  D0,($1A,A6)
.L11:
            movem.l (SP)+,D3-D7/A2-A4
            move.w  #$12,D0
            bra.w   STDUNLINK
            dc.b    8,'TOGGLEDA'
            ds.b    7
LongDate2Secs:
            link.w  A6,#-$E
            movem.l D3-D7/A2,-(SP)
            movea.l ($10,A6),A2
            lea     (A2),A0
            move.w  (A0)+,D1
            move.w  (A0)+,D3
            tst.w   D1
            bge.b   .L1
            subq.w  #1,D3
            neg.w   D3
.L1:
            subi.w  #$7D1,D3
            move.w  (A0)+,D4
            addq.w  #2,A0
            subq.w  #1,D4
            moveq   #0,D5
            move.w  (A0)+,D6
            muls.w  #$3C,D6
            add.w   (A0)+,D6
            muls.w  #$3C,D6
            move.w  (A0)+,D1
            ext.l   D1
            add.l   D1,D6
            clr.b   (-$A,A6)
            move.w  #$C,D7
            cmp.w   D7,D4
            bcs.b   .L2
            ext.l   D4
            divs.w  D7,D4
            add.w   D4,D3
            swap    D4
            tst.w   D4
            bge.b   .L2
            subq.w  #1,D3
            add.w   D7,D4
.L2:
            move.w  #$190,D7
            cmp.w   D7,D3
            bcs.b   .L5
            bgt.b   .L3
            move.w  D7,D0
            add.w   D3,D0
            bge.b   .L4
.L3:
            ext.l   D3
            divs.w  D7,D3
            move.w  D3,D1
            swap    D3
            ext.l   D1
            move.l  D1,-(SP)
            move.l  #$23AB1,-(SP)
            pea     (-8,A6)
            _LongMul
            add.l   (-4,A6),D5
            tst.w   D3
            bge.b   .L5
.L4:
            add.w   D7,D3
            subi.l  #$23AB1,D5
.L5:
            subq.w  #1,D7
            cmp.w   D7,D3
            bne.b   .L6
            move.b  #2,(-$A,A6)
.L6:
            move.w  #$64,D7
            cmp.w   D7,D3
            bcs.b   .L7
            ext.l   D3
            divu.w  D7,D3
            move.w  D3,D1
            swap    D3
            mulu.w  #$4756,D1
            asl.l   #1,D1
            add.l   D1,D5
.L7:
            subq.w  #1,D7
            cmp.w   D7,D3
            bne.b   .L8
            subq.b  #1,(-$A,A6)
.L8:
            moveq   #4,D7
            cmp.w   D7,D3
            bcs.b   .L9
            ext.l   D3
            divu.w  D7,D3
            move.w  D3,D1
            swap    D3
            mulu.w  #$5B5,D1
            add.l   D1,D5
.L9:
            subq.w  #1,D7
            cmp.w   D7,D3
            bne.b   .L10
            addq.b  #1,(-$A,A6)
.L10:
            mulu.w  #$16D,D3
            add.l   D3,D5
            lea     MonthStarts,A0
            tst.b   (-$A,A6)
            ble.b   .L11
            lea     LeapStarts,A0
.L11:
            add.w   D4,D4
            moveq   #0,D0
            move.w  (0,A0,D4.w),D0
            add.l   D0,D5
            move.w  (6,A2),D0
            bne.b   .L13
            move.w  ($10,A2),D0
            bne.b   .L13
            move.w  ($12,A2),D0
            subq.w  #1,D0
            muls.w  #7,D0
            move.l  D5,D1
            subq.l  #1,D1
            divs.w  #7,D1
            swap    D1
            tst.w   D1
            bge.b   .L12
            addq.w  #7,D1
.L12:
            sub.w   D1,D0
            add.w   ($E,A2),D0
            addq.w  #1,D0
.L13:
            ext.l   D0
            addi.l  #$8A65,D0
            add.l   D0,D5
            move.l  D5,-(SP)
            move.l  #$15180,-(SP)
            move.l  ($C,A6),-(SP)
            _LongMul
            moveq   #0,D1
            movea.l ($C,A6),A0
            move.l  (A0)+,D0
            add.l   D6,(A0)
            addx.l  D1,D0
            move.l  D0,-(A0)
            movem.l (SP)+,D3-D7/A2
            move.w  #$C,D0
            bra.w   STDUNLINK
            dc.b    8,'LDAT2SEX'
            dc.b    $00
LongSecs2Date:
            link.w  A6,#-$18
            movem.l D3-D7/A2,-(SP)
            movea.l ($C,A6),A2
            moveq   #1,D4
            movea.l ($10,A6),A0
            move.l  (A0)+,D0
            move.l  (A0)+,D1
            cmpi.l  #$CE,D0
            bcs.b   .L2
            bge.b   .L1
            cmpi.l  #$FFFFFF15,D0
            bge.b   .L2
.L1:
            moveq   #0,D0
            moveq   #0,D1
.L2:
            move.l  #$15180,D2
            divs.l  D2,D0:D1
            move.l  D1,D5
            move.l  D0,D6
            bge.b   .L3
            addi.l  #$15180,D6
            subq.l  #1,D5
.L3:
            move.l  D5,D0
            addq.l  #5,D0
            divs.w  #7,D0
            bvc.b   .L4
            divs.w  #$41A7,D0
            swap    D0
            ext.l   D0
            divs.w  #7,D0
.L4:
            swap    D0
            tst.w   D0
            bge.b   .L5
            addq.w  #7,D0
.L5:
            addq.w  #1,D0
            lea     ($E,A2),A0
            move.w  D0,(A0)
            move.w  #$3C,D0
            divu.w  D0,D6
            swap    D6
            move.w  D6,-(A0)
            clr.w   D6
            swap    D6
            divu.w  D0,D6
            move.w  D6,D0
            swap    D6
            move.w  D6,-(A0)
            move.w  D0,-(A0)
            lea     ($14,A2),A0
            cmpi.w  #$C,D0
            sge     D0
            neg.b   D0
            move.w  D0,(A0)+
            clr.l   (A0)+
            subi.l  #$8A66,D5
            moveq   #0,D3
            move.l  #$23AB1,D7
            cmp.l   D7,D5
            bcs.b   .L8
            bgt.b   .L6
            move.l  D7,D0
            add.l   D5,D0
            bge.b   .L7
.L6:
            move.l  D7,D2
            move.l  D5,D1
            slt     D0
            ext.w   D0
            ext.l   D0
            divs.l  D2,D0:D1
            muls.w  #$190,D1
            add.l   D1,D3
            move.l  D0,D5
            bge.b   .L8
.L7:
            addi.l  #$23AB1,D5
            subi.l  #$190,D3
.L8:
            clr.w   D0
            move.l  #$8EAC,D7
            cmp.l   D7,D5
            blt.b   .L10
            move.l  D5,D1
            divu.w  #$8EAC,D5
            move.w  D5,D0
            clr.w   D5
            swap    D5
            mulu.w  #$64,D0
            cmpi.w  #$12C,D0
            blt.b   .L10
            beq.b   .L9
            subi.l  #$64,D0
            addi.l  #$8EAC,D5
.L9:
            addq.b  #2,D4
.L10:
            add.w   D0,D3
            divu.w  #$5B5,D5
            move.w  D5,D0
            asl.w   #2,D0
            swap    D5
            cmpi.w  #$60,D0
            bne.b   .L11
            subq.b  #1,D4
.L11:
            add.l   D0,D3
            ext.l   D5
            divu.w  #$16D,D5
            move.w  D5,D0
            swap    D5
            cmpi.w  #3,D0
            blt.b   .L13
            beq.b   .L12
            subq.w  #1,D0
            addi.w  #$16D,D5
.L12:
            addq.b  #4,D4
.L13:
            add.w   D0,D3
            move.w  D5,D0
            addq.w  #1,D0
            move.w  D0,($10,A2)
            move.w  D5,D1
            ext.l   D1
            divu.w  #7,D1
            move.w  D1,D0
            swap    D1
            cmp.w   ($E,A2),D1
            blt.b   .L14
            addq.w  #1,D0
.L14:
            addq.w  #1,D0
            move.w  D0,($12,A2)
            lea     MonthStarts,A0
            cmpi.b  #4,D4
            ble.b   .L15
            lea     LeapStarts,A0
.L15:
            moveq   #-1,D0
.L16:
            addq.w  #1,D0
            cmp.w   (A0)+,D5
            bge.b   .L16
            lea     (A2),A1
            clr.w   D1
            addi.w  #$7D1,D3
            bgt.b   .L17
            moveq   #-1,D1
            neg.w   D3
            addq.w  #1,D3
.L17:
            move.w  D1,(A1)+
            move.w  D3,(A1)+
            move.w  D0,(A1)+
            sub.w   (-4,A0),D5
            addq.w  #1,D5
            move.w  D5,(A1)+
            movem.l (SP)+,D3-D7/A2
            move.w  #$C,D0
            bra.w   STDUNLINK
            dc.b    8,'LSEX2DAT'
            dc.b    $00
ValidLong:
            movem.l D3-D4,-(SP)
            move.l  #$80000000,D0
            moveq   #0,D4
            move.b  (A0)+,D4
            ble.b   .L3
            moveq   #0,D1
            move.b  (A0)+,D1
            subi.b  #$30,D1
            subq.b  #1,D4
            move.l  D1,D2
            bra.b   .L2
.L1:
            add.l   D2,D2
            move.l  D2,D3
            lsl.l   #2,D2
            add.l   D3,D2
            add.l   D1,D2
.L2:
            move.b  (A0)+,D1
            subi.b  #$30,D1
            dbra    D4,.L1
            move.l  D2,D0
.L3:
            tst.l   D0
            movem.l (SP)+,D3-D4
            rts
            ds.b    4
Block2String:
            move.l  D3,-(SP)
            move.l  A1,-(SP)
            move.b  D2,D3
            move.b  D1,D2
            moveq   #0,D1
            tst.l   D0
            ble.b   .L9
            not.b   D1
            cmp.l   D1,D0
            ble.b   .L1
            move.l  D1,D0
.L1:
            move.l  A1,-(SP)
            move.l  D0,D1
            addq.l  #1,A1
            tst.b   D2
            beq.b   .L5
            bra.b   .L3
.L2:
            subq.b  #1,D1
.L3:
            move.b  (A0)+,D2
            cmpi.b  #$20,D2
            beq.b   .L4
            cmp.b   D3,D2
.L4:
            dbne    D0,.L2
            beq.b   .L9
            tst.b   D2
            bne.b   .L7
.L5:
            move.b  (A0)+,D2
            bra.b   .L7
.L6:
            move.b  D2,(A1)+
            move.b  (A0)+,D2
.L7:
            dbeq    D0,.L6
            bne.b   .L8
            sub.b   D0,D1
.L8:
            movea.l (SP)+,A1
.L9:
            move.b  D1,(A1)
            movea.l (SP)+,A0
            moveq   #0,D0
            move.b  (A0)+,D0
            _UpperText
            move.l  (SP)+,D3
            rts
            ds.b    8
COMPARE:
            cmp.w   D1,D0
            bgt.b   .L2
            subq.w  #1,D0
.L1:
            cmpm.b  (A0)+,(A1)+
            dbne    D0,.L1
            moveq   #0,D0
            bra.b   .L3
.L2:
            moveq   #-1,D0
.L3:
            rts
            ds.b    12
MatchString:
            link.w  A6,#0
            movem.l D3-D5/A2-A4,-(SP)
            movea.l ($14,A6),A3
            move.w  ($12,A6),D3
            movea.l ($C,A6),A4
            move.w  ($A,A6),D4
            move.w  (8,A6),D5
            bra.b   .L5
.L1:
            movea.l A3,A0
            move.l  D3,D0
            moveq   #0,D1
            move.b  (A4)+,D1
            movea.l A4,A1
            cmp.w   D1,D0
            bgt.b   .L4
            beq.b   .L2
            cmp.w   ($10,A6),D0
            blt.b   .L4
.L2:
            subq.w  #1,D0
            blt.b   .L4
.L3:
            cmpm.b  (A0)+,(A1)+
            dbne    D0,.L3
            beq.b   .L6
.L4:
            adda.w  D4,A4
.L5:
            dbra    D5,.L1
            bra.b   .L7
.L6:
            sub.w   (8,A6),D5
            neg.w   D5
.L7:
            move.w  D5,($18,A6)
            movem.l (SP)+,D3-D5/A2-A4
            move.w  #$10,D0
            bra.w   STDUNLINK
            dc.w    0
InitDateCache:
            link.w  A6,#-$2E
            movem.l D3-D4/A2-A4,-(SP)
            clr.w   ($10,A6)
            movea.l ($C,A6),A2
            move.b  #$20,(-$26,A6)
            subq.l  #6,SP
            move.l  #$82000002,-(SP)
            _ScriptUtil
            move.w  #6,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            tst.l   (SP)+
            beq.b   .L1
            move.b  #$A0,(-$26,A6)
.L1:
            lea     (-$2E,A6),A0
            clr.l   (A0)+
            move.l  TimeLM,(A0)+
            pea     (-$2E,A6)
            pea     (2,A2)
            move.l  #$8008FFF0,-(SP)
            _ScriptUtil
            lea     (-$2E,A6),A0
            clr.l   (A0)+
            clr.l   (A0)+
            pea     (-$2E,A6)
            pea     ($1E,A2)
            move.l  #$8008FFF0,-(SP)
            _ScriptUtil
            clr.l   -(SP)
            clr.w   -(SP)
            move.w  #6,-(SP)
            _Pack6
            move.l  (SP)+,(-$20,A6)
            move.w  ResErr,D0
            beq.b   .L2
            move.w  D0,($10,A6)
            bra.w   .L9
.L2:
            clr.l   -(SP)
            move.w  #1,-(SP)
            move.w  #6,-(SP)
            _Pack6
            move.l  (SP)+,(-$24,A6)
            tst.w   ResErr
            beq.b   .L3
            move.w  ResErr,($10,A6)
            bra.w   .L9
.L3:
            movea.l (-$20,A6),A3
            movea.l A3,A0
            _MoveHHi
            movea.l A3,A0
            _HLock
            movea.l (A3),A3
            lea     ($10,A3),A0
            lea     ($16A,A2),A1
            moveq   #4,D0
            move.b  #1,D1
            move.b  (-$26,A6),D2
            jsr     Block2String
            lea     ($C,A3),A0
            lea     ($17A,A2),A1
            moveq   #4,D0
            move.b  #1,D1
            move.b  (-$26,A6),D2
            jsr     Block2String
            lea     ($15,A3),A0
            lea     ($18A,A2),A1
            moveq   #1,D0
            move.b  #1,D1
            move.b  (-$26,A6),D2
            jsr     Block2String
            move.b  ($14,A3),($19A,A2)
            move.b  (7,A3),($19E,A2)
            move.b  (9,A3),($19B,A2)
            movea.l (-$20,A6),A0
            _HUnlock
            movea.l (-$24,A6),A3
            movea.l A3,A0
            _MoveHHi
            movea.l A3,A0
            _HLock
            movea.l (A3),A3
            moveq   #0,D1
            clr.w   D0
            move.b  ($131,A3),D0
            beq.b   .L6
            moveq   #1,D1
            cmpi.b  #$FF,D0
            beq.b   .L6
.L4:
            move.b  D0,D2
            andi.b  #3,D2
            cmpi.b  #0,D2
            beq.b   .L6
            cmpi.b  #3,D2
            beq.b   .L5
            lsr.b   #2,D0
            bne.b   .L4
.L5:
            moveq   #2,D1
.L6:
            move.b  D1,($19F,A2)
            move.b  ($133,A3),($1A0,A2)
            lea     ($70,A3),A4
            lea     ($3A,A2),A1
            moveq   #$B,D3
            jsr     sub_4081F16C
            lea     (A3),A4
            lea     ($FA,A2),A1
            moveq   #6,D3
            jsr     sub_4081F16C
            movea.l (-$24,A6),A0
            _HUnlock
            lea     (-$1C,A6),A0
            move.l  A0,($1AA,A2)
            moveq   #2,D0
            move.l  D0,($1AE,A2)
            clr.l   ($1B2,A2)
            clr.l   ($1C2,A2)
            lea     ($1C6,A2),A0
            move.w  #$D,D0
.L7:
            move.w  #$7F,(A0)+
            dbra    D0,.L7
            clr.l   -(SP)
            move.w  #4,-(SP)
            move.w  #6,-(SP)
            _Pack6
            move.l  (SP)+,($1E2,A2)
            lea     ($19A,A2),A0
            move.l  A0,($1A2,A2)
            moveq   #2,D0
            move.l  D0,($1A6,A2)
            clr.b   -(SP)
            pea     ($1A2,A2)
            move.l  #$8204FFFA,-(SP)
            _ScriptUtil
            tst.b   (SP)+
            beq.b   .L8
            move.w  #$8000,($10,A6)
            bra.b   .L9
.L8:
            move.w  (-$1C,A6),($19A,A2)
            move.w  (-$E,A6),($19C,A2)
            move.l  #$20,($1AE,A2)
.L9:
            movem.l (SP)+,D3-D4/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
sub_4081F16C:
            move.l  A1,D4
.L1:
            movea.l A3,A0
            movea.l D4,A1
            move.b  (A0)+,D0
            moveq   #1,D1
            move.b  (-$26,A6),D2
            jsr     Block2String
            addi.l  #$10,D4
            lea     ($10,A3),A3
            dbra    D3,.L1
            rts
            dc.w    0
String2Date:
            link.w  A6,#-$324
            movem.l D3-D7/A2-A4,-(SP)
            bsr.w   DateTimeEntry
            tst.w   ($20,A6)
            bne.w   .L28
            moveq   #-1,D4
            clr.w   (-$1E6,A6)
            lea     (2,A4),A1
            lea     (-$1DC,A6),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.w  (A1)+,(A0)+
            clr.w   (A0)+
            move.b  ($1A0,A4),D6
.L1:
            move.w  (A3),D1
            cmpi.w  #$10,D1
            bge.b   .L2
            subq.w  #1,D1
            beq.w   .L13
            subq.w  #3,D1
            beq.b   .L8
            subq.w  #1,D1
            beq.b   .L5
            subq.w  #6,D1
            beq.b   .L5
            bra.w   .L13
.L2:
            tst.b   D7
            beq.b   .L3
            ori.w   #$20,($20,A6)
.L3:
            addq.b  #1,D7
            tst.w   D5
            bmi.w   .L13
            bne.b   .L4
            move.w  D1,(-$1E8,A6)
            bra.w   .L13
.L4:
            cmp.w   (-$1E8,A6),D1
            beq.w   .L13
            ori.w   #$44,($20,A6)
            bra.w   .L13
.L5:
            tst.w   D7
            bne.b   .L7
            tst.w   D5
            blt.b   .L7
            bne.b   .L6
            move.w  #1,(-$1E8,A6)
            bra.b   .L7
.L6:
            cmpi.w  #1,(-$1E8,A6)
            beq.b   .L7
            ori.w   #$44,($20,A6)
.L7:
            moveq   #0,D7
            cmpi.w  #2,D5
            bge.b   .L11
            movea.l ($A,A3),A0
            jsr     ValidLong
            bmi.w   .L28
            bsr.w   FixValue
            bra.b   .L12
.L8:
            moveq   #0,D7
            movea.l ($A,A3),A2
            addq.l  #1,A2
            movea.l A2,A0
            move.l  (6,A3),D0
            _UpperText
            tst.w   D4
            bpl.b   .L9
            clr.w   -(SP)
            move.l  A2,-(SP)
            move.w  (8,A3),-(SP)
            move.w  D6,-(SP)
            pea     ($3A,A4)
            move.w  #$F,-(SP)
            move.w  #$13,-(SP)
            jsr     MatchString
            move.w  (SP)+,D2
            ble.b   .L11
            subq.w  #7,D2
            ble.b   .L9
            cmpi.w  #2,D5
            bge.b   .L11
            addq.w  #1,D5
            move.w  D5,D1
            add.w   D1,D1
            lea     (-$1E2,A6),A1
            move.w  D2,(0,A1,D1.w)
            move.w  D5,D4
            bra.b   .L12
.L9:
            tst.b   (-$1E6,A6)
            bne.b   .L11
            sle     (-$1E6,A6)
            addq.w  #7,D2
            move.w  D2,(-$1CE,A6)
            tst.w   D5
            bmi.b   .L10
            ori.w   #8,($20,A6)
.L10:
            bra.b   .L12
.L11:
            tst.w   (-$1F0,A6)
            bpl.b   .L13
            move.w  D3,(-$1F0,A6)
            bra.b   .L13
.L12:
            move.w  D3,(-$1EA,A6)
            move.l  A3,(-$1EE,A6)
.L13:
            adda.w  #$E,A3
            cmpi.w  #2,D5
            sge     D0
            and.b   (-$1E6,A6),D0
            dbne    D3,.L1
            tst.w   D5
            bpl.b   .L14
            ori.w   #$8400,($20,A6)
            bra.w   .L28
.L14:
            bsr.w   sub_4081F434
            lea     sub_4081F506.L1,A0
            lea     (-$1E2,A6),A1
            move.b  ($19F,A4),D2
            tst.w   D4
            bpl.b   .L15
            move.b  ($19E,A4),D2
            tst.w   D5
            beq.b   .L17
            move.w  (-$1E8,A6),D0
            cmp.w   ($19C,A4),D0
            beq.b   .L17
            ori.w   #4,($20,A6)
            bra.b   .L17
.L15:
            ori.w   #1,($20,A6)
            andi.w  #$FFB3,($20,A6)
            tst.w   D5
            bne.b   .L16
            moveq   #1,D5
            move.w  #1,(2,A1)
.L16:
            move.w  D4,D0
            mulu.w  #6,D0
            add.b   D2,D0
            move.b  (0,A0,D0.w),D2
.L17:
            moveq   #0,D1
            lea     (-$1DC,A6),A2
            move.w  D5,D0
            mulu.w  #$18,D0
            add.b   D2,D2
            add.b   D2,D2
            add.b   D2,D0
            move.b  ($12,A0,D0.w),D1
            bmi.b   .L18
            add.w   D1,D1
            move.w  (0,A1,D1.w),(-$1DA,A6)
.L18:
            move.b  ($13,A0,D0.w),D1
            bmi.b   .L19
            add.w   D1,D1
            move.w  (0,A1,D1.w),(-$1D8,A6)
.L19:
            move.b  ($14,A0,D0.w),D1
            add.w   D1,D1
            move.w  (0,A1,D1.w),(-$1D6,A6)
            cmpi.w  #1,D5
            ble.b   .L24
            move.w  ($20,A4),D0
            move.w  (-$1DA,A6),D1
            cmp.w   D1,D0
            ble.b   .L24
            cmpi.w  #$64,D1
            bge.b   .L22
            move.w  (4,A4),D0
            divu.w  #$64,D0
            mulu.w  #$64,D0
            move.w  D0,D1
            move.w  (4,A4),D0
            sub.w   D1,D0
            move.w  (-$1DA,A6),D1
            cmpi.w  #$5A,D0
            bls.b   .L20
            cmpi.w  #$A,D1
            bgt.b   .L21
            addi.w  #$64,(-$1DA,A6)
            bra.b   .L21
.L20:
            cmpi.w  #$A,D0
            bgt.b   .L21
            cmpi.w  #$5A,D1
            bls.b   .L21
            subi.w  #$64,(-$1DA,A6)
.L21:
            move.w  #$64,D0
            bra.b   .L23
.L22:
            cmpi.w  #$3E8,D1
            bge.b   .L24
            move.w  #$3E8,D0
.L23:
            move.w  (4,A4),D1
            divu.w  D0,D1
            mulu.w  D0,D1
            add.w   D1,(-$1DA,A6)
.L24:
            moveq   #$E,D0
            tst.w   (-$1CE,A6)
            beq.b   .L25
            ori.l   #$80,D0
.L25:
            bsr.w   sub_4081F506
            blt.b   .L26
            ori.w   #$8800,($20,A6)
            bra.b   .L28
.L26:
            movea.l ($C,A6),A1
            lea     (-$1DC,A6),A0
            move.w  ($E,A0),($E,A1)
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l ($10,A6),A0
.L27:
            movea.l (-$1EE,A6),A1
            move.l  (2,A1),(A0)
            move.l  ($1C,A6),D0
            sub.l   (6,A1),D0
            sub.l   D0,(A0)
.L28:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$18,SP
            jmp     (A0)
sub_4081F434:
            movea.l (-$1EE,A6),A3
            adda.w  #$E,A3
            move.w  (-$1EA,A6),D3
            tst.w   (-$1F0,A6)
            bmi.b   .L1
            cmp.w   (-$1F0,A6),D3
            bgt.b   .L1
            ori.w   #$10,($20,A6)
.L1:
            moveq   #0,D1
            bra.b   .L3
.L2:
            move.w  (A3),D1
            subq.w  #1,D1
            adda.w  #$E,A3
.L3:
            dbne    D3,.L2
            tst.b   D3
            bmi.b   .L4
            ori.w   #2,($20,A6)
.L4:
            rts
FixValue:
            addq.w  #1,D5
            move.w  D5,D1
            add.w   D1,D1
            lea     (-$1E2,A6),A1
            move.w  D0,(0,A1,D1.w)
            rts
DateTimeEntry:
            move.w  #$8400,($20,A6)
            tst.l   ($18,A6)
            ble.b   .L2
            clr.w   ($20,A6)
            movea.l ($14,A6),A4
            moveq   #0,D7
            moveq   #0,D6
            moveq   #-1,D5
            clr.w   (-$1E8,A6)
            clr.w   (-$1EA,A6)
            move.w  #$FFFF,(-$1F0,A6)
            movea.l ($10,A6),A0
            clr.l   (A0)
            lea     (-$1E2,A6),A0
            clr.l   (A0)+
            clr.w   (A0)+
            lea     (-$1C0,A6),A0
            move.l  A0,($1AA,A4)
            st      ($1C2,A4)
            lea     (-$324,A6),A0
            move.l  A0,($1B6,A4)
            move.l  #$12C,($1BA,A4)
            move.l  ($1C,A6),($1A2,A4)
            move.l  ($18,A6),($1A6,A4)
            lea     (-$1C0,A6),A3
            clr.b   -(SP)
            pea     ($1A2,A4)
            move.l  #$8204FFFA,-(SP)
            _ScriptUtil
            tst.b   (SP)+
            beq.b   .L1
            ori.w   #$8000,($20,A6)
            bra.b   .L2
.L1:
            move.l  ($1B2,A4),D3
            subq.w  #1,D3
            clr.w   ($20,A6)
.L2:
            rts
sub_4081F506:
            clr.w   -(SP)
            pea     (-$1DC,A6)
            move.l  D0,-(SP)
            pea     (-$1F8,A6)
            move.l  #$820CFFE4,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            rts
.L1:
            dc.w    0,$0303,$0003,$0101,$0202,$0102,$0404,$0505
            dc.w    $0405,$FFFF,0,$FFFF,0,$FFFF,0,$FFFF
            dc.w    0,$FFFF,0,$FFFF,0,$FF00,$0100,$FF01
            dc.w    0,$FF00,$0100,$FF00,$0100,$FF01,0,$FF01
            dc.w    0,$0200,$0100,$0201,0,$0001,$0200,$0100
            dc.w    $0200,$0102,0,$0002,$0100
String2Time:
            link.w  A6,#-$324
            movem.l D3-D7/A2-A4,-(SP)
            bsr.w   DateTimeEntry
            tst.w   ($20,A6)
            bne.w   String2Date.L28
            clr.w   D4
            lea     (-$1DC,A6),A0
            lea     ($1E,A4),A1
            move.w  ($E,A1),($E,A0)
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L1:
            move.w  (A3),D1
            cmpi.w  #$10,D1
            bge.b   .L2
            subq.w  #1,D1
            beq.w   .L15
            subq.w  #3,D1
            beq.w   .L10
            subq.w  #1,D1
            beq.b   .L6
            subq.w  #6,D1
            beq.b   .L6
            bra.w   .L15
.L2:
            tst.b   D7
            beq.b   .L3
            ori.w   #$20,($20,A6)
.L3:
            addq.b  #1,D7
            tst.w   D5
            beq.b   .L4
            bpl.b   .L5
            ori.w   #$10,($20,A6)
            bra.w   .L15
.L4:
            move.w  D1,(-$1E8,A6)
            bra.w   .L15
.L5:
            cmp.w   (-$1E8,A6),D1
            beq.w   .L15
            ori.w   #$44,($20,A6)
            bra.w   .L15
.L6:
            tst.w   D7
            bne.b   .L8
            tst.w   D5
            blt.b   .L8
            bne.b   .L7
            move.w  #1,(-$1E8,A6)
            bra.b   .L8
.L7:
            cmpi.w  #1,(-$1E8,A6)
            beq.b   .L8
            ori.w   #$44,($20,A6)
.L8:
            moveq   #0,D7
            cmpi.w  #2,D5
            bge.b   .L13
            movea.l ($A,A3),A0
            jsr     ValidLong
            bmi.w   String2Date.L28
            tst.b   D6
            beq.b   .L9
            ori.w   #8,($20,A6)
.L9:
            bsr.w   FixValue
            bra.b   .L14
.L10:
            tst.b   D6
            bne.b   .L13
            movea.l ($A,A3),A2
            addq.l  #1,A2
            movea.l A2,A0
            move.l  (6,A3),D0
            _UpperText
            clr.w   -(SP)
            move.l  A2,-(SP)
            move.w  (8,A3),-(SP)
            move.w  #2,-(SP)
            pea     ($16A,A4)
            move.w  #$F,-(SP)
            move.w  #3,-(SP)
            jsr     MatchString
            move.w  (SP)+,D2
            ble.b   .L12
            cmpi.w  #2,D2
            bgt.b   .L11
            st      D4
            blt.b   .L11
            neg.b   D4
.L11:
            st      D6
            tst.b   D7
            beq.b   .L12
            ori.w   #$20,($20,A6)
.L12:
            moveq   #0,D7
            tst.b   D6
            bne.b   .L14
.L13:
            tst.w   (-$1F0,A6)
            bpl.b   .L15
            move.w  D3,(-$1F0,A6)
            bra.b   .L15
.L14:
            move.w  D3,(-$1EA,A6)
            move.l  A3,(-$1EE,A6)
.L15:
            adda.w  #$E,A3
            tst.b   D6
            dbne    D3,.L1
            tst.w   D5
            bpl.b   .L16
            ori.w   #$8400,($20,A6)
            bra.w   String2Date.L28
.L16:
            bsr.w   sub_4081F434
            tst.w   D5
            beq.b   .L17
            move.w  (-$1E8,A6),D0
            cmp.w   ($19A,A4),D0
            beq.b   .L17
            ori.w   #4,($20,A6)
.L17:
            moveq   #$C,D0
            tst.b   D4
            beq.b   .L19
            blt.b   .L18
            sub.w   (-$1E2,A6),D0
            bgt.b   .L19
            neg.w   D0
            move.w  D0,(-$1E2,A6)
            bra.b   .L19
.L18:
            cmp.w   (-$1E2,A6),D0
            ble.b   .L19
            add.w   D0,(-$1E2,A6)
.L19:
            cmpi.w  #$18,(-$1E2,A6)
            bne.b   .L20
            clr.w   (-$1E2,A6)
.L20:
            lea     (-$1E2,A6),A2
            lea     (-$1D4,A6),A3
            move.l  (A2)+,(A3)+
            move.w  (A2)+,(A3)+
            moveq   #$70,D0
            bsr.w   sub_4081F506
            blt.b   .L21
            ori.w   #$8800,($20,A6)
            bra.w   String2Date.L28
.L21:
            movea.l ($C,A6),A1
            addq.l  #8,A1
            lea     (-$1D4,A6),A0
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            movea.l ($10,A6),A0
            bra.w   String2Date.L27
            dc.w    0

            EVEN
