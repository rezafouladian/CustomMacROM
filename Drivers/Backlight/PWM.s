            include "Include/ROMHeader.s"

            EXPORT  InitPWMControls

            IMPORT  abs,asahiTbl,PotInputRangeShiftTblPWM,PWMMaxTbl,timTbl,timTblLow

            SECTION "BacklightPWM",CODE

InitPWMControls:
            movem.l D6-D7/A3,-(SP)
            movea.l ($10,SP),A3
            bset    #3,($23,A3)
            bset    #4,($23,A3)
            bset    #5,($23,A3)
            move.w  #$A,($58,A3)
            lea     (PWMMaxTbl.w,PC),A0
            move.l  A0,($4E,A3)
            lea     (timTblLow.w,PC),A0
            move.l  A0,($46,A3)
            lea     (timTbl.w,PC),A0
            move.l  A0,($4A,A3)
            move.l  ($4A,A3),($42,A3)
            moveq   #0,D0
            move.b  BoxFlag,D0
            move.l  D0,D7
            subi.l  #$F,D0
            bmi.b   .L5
            cmpi.l  #4,D0
            bgt.b   .L5
            add.l   D0,D0
            move.w  .L2(PC,D0.l),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L4-(.L1+2)
            dc.w    .L5-(.L1+2)
            dc.w    .L5-(.L1+2)
            dc.w    .L5-(.L1+2)
            dc.w    .L3-(.L1+2)
.L3:
            bclr    #4,($23,A3)
            bclr    #5,($23,A3)
            lea     (asahiTbl.w,PC),A0
            move.l  A0,($42,A3)
            bra.b   .L5
.L4:
            moveq   #2,D0
            and.b   ($50FB4000).l,D0
            beq.b   .L5
            bclr    #5,($23,A3)
.L5:
            btst    #5,($23,A3)
            beq.b   .L6
            move.w  #1,($3C,A3)
            move.w  #$A3,($3E,A3)
            move.w  #$AD,($40,A3)
            lea     ChargerAdjust,A0
            move.l  A0,($38,A3)
            move.l  A3,-(SP)
            jsr     LowTable
            andi.b  #$BF,($23,A3)
            lsl.b   #6,D0
            andi.b  #$40,D0
            or.b    D0,($23,A3)
            btst    #6,($23,A3)
            addq.l  #4,SP
            beq.b   .L6
            move.l  ($46,A3),($42,A3)
.L6:
            lea     SetPWM,A0
            move.l  A0,($24,A3)
            lea     PotControl,A0
            move.l  A0,($28,A3)
            lea     PWMCloseRoutine,A0
            move.l  A0,($34,A3)
            lea     PWMControl,A0
            move.l  A0,($2C,A3)
            lea     PWMStatus,A0
            move.l  A0,($30,A3)
            move.l  A3,-(SP)
            jsr     PotControl
            move.l  D0,D6
            move.w  #$FFFF,($5A,A3)
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            jsr     SetPWM
            move.w  D0,($5A,A3)
            lea     ($C,SP),SP
            movem.l (SP)+,D6-D7/A3
            rts
PWMCloseRoutine:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.l  A3,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     SetPWM
            moveq   #0,D0
            addq.l  #8,SP
            movea.l (SP)+,A3
            rts
SetPWM:
            link.w  A6,#-$E
            movem.l D7/A3,-(SP)
            move.l  (8,A6),D7
            movea.l ($C,A6),A3
            movea.l ($4E,A3),A0
            move.w  ($54,A3),D0
            ext.l   D0
            add.l   D0,D0
            move.w  (0,A0,D0.l),D0
            ext.l   D0
            cmp.l   D7,D0
            bge.b   .L1
            movea.l ($4E,A3),A0
            move.w  ($54,A3),D0
            ext.l   D0
            add.l   D0,D0
            move.w  (0,A0,D0.l),D0
            ext.l   D0
            bra.b   .L3
.L1:
            tst.l   D7
            bge.b   .L2
            moveq   #0,D0
            bra.b   .L3
.L2:
            move.l  D7,D0
.L3:
            move.l  D0,D7
            movea.l ($42,A3),A0
            move.b  (0,A0,D7.l),(-1,A6)
            tst.w   ($5A,A3)
            blt.b   .L4
            moveq   #0,D0
            move.b  (-1,A6),D0
            move.w  ($5C,A3),D1
            ext.l   D1
            cmp.l   D0,D1
            bne.b   .L4
            move.l  D7,D0
            bra.w   .L9
.L4:
            btst    #7,($23,A3)
            beq.b   .L8
            move.w  ($5C,A3),D0
            ext.l   D0
            moveq   #0,D1
            move.b  (-1,A6),D1
            sub.l   D1,D0
            move.l  D0,-(SP)
            jsr     (abs.w,PC)
            move.w  ($3C,A3),D1
            ext.l   D1
            cmp.l   D0,D1
            addq.l  #4,SP
            bge.b   .L7
            move.w  ($5C,A3),D0
            ext.l   D0
            moveq   #0,D1
            move.b  (-1,A6),D1
            move.w  ($5C,A3),D2
            ext.l   D2
            cmp.l   D2,D1
            bge.b   .L5
            move.w  ($3C,A3),D1
            neg.w   D1
            ext.l   D1
            bra.b   .L6
.L5:
            move.w  ($3C,A3),D1
            ext.l   D1
.L6:
            add.l   D0,D1
            move.b  D1,(-1,A6)
            bra.b   .L8
.L7:
            bclr    #7,($23,A3)
.L8:
            moveq   #0,D0
            move.b  (-1,A6),D0
            move.w  D0,($5C,A3)
            move.w  #$40,(-$E,A6)
            move.w  #1,(-$C,A6)
            lea     (-1,A6),A0
            move.l  A0,(-$A,A6)
            moveq   #0,D0
            move.l  D0,(-6,A6)
            subq.l  #2,SP
            pea     (-$E,A6)
            movea.l (SP)+,A0
            _PMgrOp
            move.w  D0,(SP)
            move.l  D7,D0
            addq.l  #2,SP
.L9:
            movem.l (-$16,A6),D7/A3
            unlk    A6
            rts
Get_AtoD:
            link.w  A6,#-$E
            move.l  D7,-(SP)
            move.b  ($B,A6),(-2,A6)
            move.w  #$D8,(-$E,A6)
            move.w  #1,(-$C,A6)
            lea     (-2,A6),A0
            move.l  A0,(-$A,A6)
            lea     (-1,A6),A0
            move.l  A0,(-6,A6)
            subq.l  #2,SP
            pea     (-$E,A6)
            movea.l (SP)+,A0
            _PMgrOp
            move.w  D0,(SP)
            move.w  (SP)+,D7
            beq.b   .L1
            moveq   #0,D0
            bra.b   .L2
.L1:
            moveq   #0,D0
            move.b  (-1,A6),D0
.L2:
            move.l  (-$12,A6),D7
            unlk    A6
            rts
GetPortableValues:
            link.w  A6,#-$10
            movem.l D7/A3,-(SP)
            lea     (-4,A6),A3
            move.w  #$68,(-$10,A6)
            clr.w   (-$E,A6)
            moveq   #0,D0
            move.l  D0,(-$C,A6)
            move.l  A3,(-8,A6)
            subq.l  #2,SP
            pea     (-$10,A6)
            movea.l (SP)+,A0
            _PMgrOp
            move.w  D0,(SP)
            move.w  (SP)+,D7
            beq.b   .L1
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.w  ($A,A6),D0
            moveq   #0,D1
            move.b  (0,A3,D0.w),D1
            move.l  D1,D0
.L2:
            movem.l (-$18,A6),D7/A3
            unlk    A6
            rts
PotControl:
            movem.l D7/A3,-(SP)
            movea.l ($C,SP),A3
            btst    #4,($23,A3)
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     Get_AtoD
            moveq   #0,D1
            move.b  D0,D1
            addq.l  #4,SP
            bra.b   .L2
.L1:
            moveq   #2,D0
            move.l  D0,-(SP)
            jsr     GetPortableValues
            moveq   #0,D1
            move.b  D0,D1
            addq.l  #4,SP
.L2:
            move.l  D1,D7
            move.w  ($62,A3),D0
            ext.l   D0
            sub.l   D7,D0
            move.l  D0,-(SP)
            jsr     (abs.w,PC)
            moveq   #5,D1
            cmp.l   D0,D1
            addq.l  #4,SP
            blt.b   .L3
            move.w  ($62,A3),D0
            ext.l   D0
            move.l  D0,D7
.L3:
            move.w  D7,($62,A3)
            lsr.l   #3,D7
            tst.l   D7
            beq.b   .L4
            move.w  ($54,A3),D0
            add.w   D0,D0
            lea     (PotInputRangeShiftTblPWM.w,PC),A0
            move.w  (0,A0,D0.w),D0
            lsr.l   D0,D7
            tst.l   D7
            bne.b   .L4
            moveq   #1,D7
.L4:
            move.l  D7,D0
            movem.l (SP)+,D7/A3
            rts
PWMControl:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($18,SP),A3
            moveq   #0,D7
            btst    #0,($23,A3)
            bne.b   .L1
            moveq   #-$11,D7
            bra.b   .L6
.L1:
            move.w  ($1A,A4),D0
            subi.w  #$4301,D0
            bmi.b   .L5
            cmpi.w  #0,D0
            bgt.b   .L5
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
.L4:
            move.w  ($1C,A4),D0
            ext.l   D0
            move.l  D0,D6
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            jsr     SetPWM
            move.w  D0,($5A,A3)
            addq.l  #8,SP
            bra.b   .L6
.L5:
            moveq   #-$11,D7
.L6:
            move.w  D7,D0
            movem.l (SP)+,D6-D7/A3-A4
            rts
PWMStatus:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($10,SP),A3
            clr.w   D7
            move.w  ($1A,A3),D0
            subi.w  #$5301,D0
            bmi.b   .L6
            cmpi.w  #5,D0
            bgt.b   .L6
            add.w   D0,D0
            move.w  .L2(PC,D0.w),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L3-(.L1+2)
            dc.w    .L6-(.L1+2)
            dc.w    .L4-(.L1+2)
            dc.w    .L6-(.L1+2)
            dc.w    .L6-(.L1+2)
            dc.w    .L5-(.L1+2)
.L3:
            move.w  ($5A,A4),($1C,A3)
            bra.b   .L7
.L4:
            move.w  #$1F,($1C,A3)
            clr.w   ($1E,A3)
            bra.b   .L7
.L5:
            movea.l ($4E,A4),A0
            move.w  ($54,A4),D0
            ext.l   D0
            add.l   D0,D0
            move.w  (0,A0,D0.l),($1C,A3)
            bra.b   .L7
.L6:
            moveq   #-$12,D7
.L7:
            move.w  D7,D0
            movem.l (SP)+,D7/A3-A4
            rts
ChargerAdjust:
            movem.l D7/A3,-(SP)
            movea.l ($C,SP),A3
            btst    #6,($23,A3)
            sne     D0
            andi.w  #1,D0
            ext.l   D0
            move.l  D0,D7
            move.l  A3,-(SP)
            jsr     LowTable
            andi.b  #$BF,($23,A3)
            lsl.b   #6,D0
            andi.b  #$40,D0
            or.b    D0,($23,A3)
            btst    #6,($23,A3)
            sne     D0
            andi.w  #1,D0
            ext.l   D0
            cmp.l   D0,D7
            addq.l  #4,SP
            beq.b   .L3
            bset    #7,($23,A3)
            btst    #6,($23,A3)
            beq.b   .L1
            move.l  ($46,A3),D0
            bra.b   .L2
.L1:
            move.l  ($4A,A3),D0
.L2:
            move.l  D0,($42,A3)
.L3:
            movem.l (SP)+,D7/A3
            rts
LowTable:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.w #$D18,A3
            btst    #6,($23,A4)
            sne     D6
            neg.b   D6
            clr.b   D7
            tst.b   D6
            beq.b   .L1
            movea.l (A3),A0
            moveq   #0,D0
            move.b  ($52,A0),D0
            moveq   #0,D1
            move.w  ($40,A4),D1
            cmp.l   D0,D1
            bls.b   .L2
.L1:
            tst.b   D6
            bne.b   .L3
            movea.l (A3),A0
            moveq   #0,D0
            move.b  ($52,A0),D0
            moveq   #0,D1
            move.w  ($3E,A4),D1
            cmp.l   D0,D1
            bhi.b   .L3
.L2:
            movea.l (A3),A0
            moveq   #1,D7
            and.b   ($F,A0),D7
.L3:
            tst.b   D7
            beq.b   .L4
            moveq   #0,D0
            bra.b   .L5
.L4:
            moveq   #1,D0
.L5:
            movem.l (SP)+,D6-D7/A3-A4
            rts

            EVEN
