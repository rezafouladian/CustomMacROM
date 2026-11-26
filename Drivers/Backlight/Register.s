            include "Include/ROMHeader.s"

            EXPORT  InitRegControls,Sleep_Task

            IMPORT  abs,GetBacklightInfo,KeyHookVars,PortableMaxTbl,PortableTable7V,PortableTbl5V
            IMPORT  SaveBacklightInfo,SleepEntry

            SECTION "BacklightRegister",CODE

InitRegControls:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A3
            lea     (KeyHookVars.w,PC),A4
            clr.b   (4,A4)
            clr.b   (5,A4)
            move.w  #1,($58,A3)
            moveq   #2,D0
            and.b   ($FC0200).l,D0
            beq.b   .L1
            lea     (PortableTbl5V.w,PC),A0
            move.l  A0,D0
            bra.b   .L2
.L1:
            lea     (PortableTable7V.w,PC),A0
            move.l  A0,D0
.L2:
            move.l  D0,($42,A3)
            lea     (PortableMaxTbl.w,PC),A0
            move.l  A0,($4E,A3)
            lea     SetBrightness,A0
            move.l  A0,($24,A3)
            lea     KbdControl,A0
            move.l  A0,($28,A3)
            lea     RegisterClose,A0
            move.l  A0,($34,A3)
            lea     RegisterStatus,A0
            move.l  A0,($30,A3)
            lea     RegisterControl,A0
            move.l  A0,($2C,A3)
            moveq   #5,D0
            move.l  D0,-(SP)
            pea     ($E0).w
            jsr     (GetBacklightInfo.w,PC)
            move.w  D0,($60,A3)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #$1F,D1
            move.l  D1,-(SP)
            jsr     (GetBacklightInfo.w,PC)
            move.l  D0,D7
            subq.l  #1,D7
            move.w  ($60,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     setNewKeys
            tst.l   D7
            lea     ($14,SP),SP
            bcc.b   .L3
            moveq   #1,D7
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #$1F,D1
            move.l  D1,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            jsr     (SaveBacklightInfo.w,PC)
            lea     ($C,SP),SP
.L3:
            move.w  #$1E,($5A,A3)
            move.l  A3,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     SetBrightness
            move.w  D0,($5A,A3)
            move.l  A3,-(SP)
            move.l  D7,-(SP)
            jsr     SetBrightness
            move.w  D0,($5A,A3)
            cmpi.b  #$A3,($FC0200).l
            lea     ($10,SP),SP
            bne.b   .L4
            move.w  #$10,(4,A3)
            lea     (SleepEntry.w,PC),A0
            move.l  A0,(6,A3)
            move.l  A3,-(SP)
            movea.l (SP)+,A0
            _SleepQInstall
            addq.l  #4,SP
.L4:
            pea     ShutdownBacklight
            moveq   #3,D0
            move.w  D0,-(SP)
            move.w  #3,-(SP)
            _ShutDown
            movem.l (SP)+,D7/A3-A4
            rts
StrobeCount:
            movem.l D5-D7/A3,-(SP)
            movea.l ($14,SP),A3
            move.l  ($18,SP),D5
            move.b  ($1F,SP),D6
            tst.l   D5
            beq.b   .L3
            ori.b   #$80,D6
            move.l  D5,D7
            lsl.l   #1,D7
            bra.b   .L2
.L1:
            eori.b  #$80,D6
            move.b  D6,(A3)
            subq.l  #1,D7
.L2:
            tst.l   D7
            bne.b   .L1
.L3:
            movem.l (SP)+,D5-D7/A3
            rts
ShutdownBacklight:
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     TurnOnOff
            addq.l  #4,SP
            rts
Sleep_Task:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.l  ($C,A6),D0
            subq.l  #1,D0
            bmi.b   .L6
            cmpi.l  #3,D0
            bgt.b   .L6
            add.l   D0,D0
            move.w  .L2(PC,D0.l),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L6-(.L1+2)
            dc.w    .L3-(.L1+2)
            dc.w    .L4-(.L1+2)
            dc.w    .L6-(.L1+2)
.L3:
            bclr    #2,($23,A3)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     TurnOnOff
            addq.l  #4,SP
            bra.b   .L6
.L4:
            tst.w   ($5A,A3)
            beq.b   .L5
            moveq   #1,D0
            move.l  D0,-(SP)
            jsr     TurnOnOff
            addq.l  #4,SP
.L5:
            bset    #2,($23,A3)
.L6:
            movea.l (-4,A6),A3
            unlk    A6
            rts
TurnOnOff:
            movem.l D5-D7/A3,-(SP)
            move.b  ($17,SP),D5
            movea.l #$FC0202,A3
            moveq   #4,D7
            and.b   ($FC0200).l,D7
            move.b  #$A0,D6
            tst.b   D7
            beq.b   .L1
            tst.b   D5
            bne.b   .L2
.L1:
            tst.b   D7
            bne.b   .L3
            tst.b   D5
            bne.b   .L3
.L2:
            ori.b   #2,D6
.L3:
            move.b  D6,(A3)
            movem.l (SP)+,D5-D7/A3
            rts
SetBrightness:
            link.w  A6,#-6
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($C,A6),A3
            move.l  (8,A6),D7
            tst.w   ($5A,A3)
            slt     D4
            neg.b   D4
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
            tst.b   D4
            beq.b   .L4
            moveq   #0,D0
            bra.b   .L5
.L4:
            move.w  ($5A,A3),D0
            ext.l   D0
.L5:
            move.l  D0,(-4,A6)
            movea.l ($42,A3),A0
            move.b  (0,A0,D7.l),D5
            tst.b   D4
            bne.b   .L6
            moveq   #0,D0
            move.b  D5,D0
            move.w  ($5C,A3),D1
            ext.l   D1
            cmp.l   D0,D1
            bne.b   .L6
            move.l  D7,D0
            bra.w   .L15
.L6:
            move.b  ($FC0200).l,D6
            moveq   #4,D0
            and.b   D6,D0
            move.b  D0,(-5,A6)
            moveq   #1,D4
            and.b   D6,D4
            movea.l #$FC0202,A4
            move.b  #$A0,D6
            tst.b   (-5,A6)
            beq.b   .L7
            tst.l   D7
            bne.b   .L8
.L7:
            tst.b   (-5,A6)
            bne.b   .L9
            tst.l   D7
            bne.b   .L9
.L8:
            ori.b   #2,D6
.L9:
            tst.b   D4
            beq.b   .L10
            cmp.l   (-4,A6),D7
            ble.b   .L11
.L10:
            tst.b   D4
            bne.b   .L12
            cmp.l   (-4,A6),D7
            blt.b   .L12
.L11:
            ori.b   #$40,D6
.L12:
            tst.l   D7
            bne.b   .L13
            move.l  #$100,D0
            bra.b   .L14
.L13:
            move.w  ($5C,A3),D0
            ext.l   D0
            moveq   #0,D1
            move.b  D5,D1
            sub.l   D1,D0
            move.l  D0,-(SP)
            jsr     (abs.w,PC)
.L14:
            move.l  D0,D4
            andi.b  #$DF,D6
            move.b  D6,(A4)
            moveq   #0,D0
            move.b  D6,D0
            move.l  D0,-(SP)
            move.l  D4,-(SP)
            move.l  A4,-(SP)
            jsr     StrobeCount
            ori.b   #$20,D6
            move.b  D6,(A4)
            moveq   #0,D0
            move.b  D5,D0
            move.w  D0,($5C,A3)
            move.l  D7,D0
.L15:
            movem.l (-$1E,A6),D4-D7/A3-A4
            unlk    A6
            rts
KeysDown:
            movem.l D6-D7/A3,-(SP)
            move.l  ($10,SP),D6
            movea.l ($14,SP),A3
            tst.l   D6
            bne.b   .L1
            moveq   #0,D0
            bra.b   .L5
.L1:
            moveq   #0,D7
            move.b  (7,A3),D0
            ext.w   D0
            ext.l   D0
            move.l  #$88,D1
            and.l   D0,D1
            beq.b   .L2
            addq.l  #1,D7
.L2:
            moveq   #$11,D0
            and.b   (7,A3),D0
            beq.b   .L3
            addq.l  #2,D7
.L3:
            moveq   #$44,D0
            and.b   (7,A3),D0
            beq.b   .L4
            addq.l  #4,D7
.L4:
            cmp.l   D7,D6
            seq     D0
            neg.b   D0
.L5:
            movem.l (SP)+,D6-D7/A3
            rts
KbdControl:
            link.w  A6,#-$10
            movem.l D5-D7/A3-A4,-(SP)
            lea     (-$10,A6),A4
            movea.l (8,A6),A3
            move.w  ($5A,A3),D0
            ext.l   D0
            move.l  D0,D5
            movea.l ($4E,A3),A0
            move.w  ($54,A3),D0
            ext.l   D0
            add.l   D0,D0
            move.w  (0,A0,D0.l),D0
            ext.l   D0
            move.l  D0,D6
            move.w  ($5A,A3),D0
            ext.l   D0
            cmp.l   D0,D6
            bge.b   .L1
            move.l  D6,D0
            bra.w   .L12
.L1:
            move.l  A4,-(SP)
            _GetKeys
            move.l  A4,-(SP)
            move.w  ($60,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     KeysDown
            tst.b   D0
            addq.l  #8,SP
            bne.b   .L2
            clr.w   ($5E,A3)
            bclr    #1,($23,A3)
            bra.b   .L11
.L2:
            addq.w  #1,($5E,A3)
            btst    #1,($23,A3)
            beq.b   .L3
            moveq   #5,D0
            bra.b   .L4
.L3:
            moveq   #1,D0
.L4:
            move.w  ($5E,A3),D1
            ext.l   D1
            cmp.l   D1,D0
            bge.b   .L11
            bset    #1,($23,A3)
            move.w  #1,($5E,A3)
            moveq   #0,D7
            moveq   #$40,D0
            and.b   ($F,A4),D0
            bne.b   .L5
            moveq   #$10,D0
            and.b   ($F,A4),D0
            beq.b   .L6
.L5:
            moveq   #1,D7
.L6:
            moveq   #$20,D0
            and.b   ($F,A4),D0
            bne.b   .L7
            moveq   #8,D0
            and.b   ($F,A4),D0
            beq.b   .L8
.L7:
            moveq   #-1,D7
.L8:
            move.w  ($5A,A3),D0
            ext.l   D0
            add.l   D7,D0
            cmp.l   D0,D6
            bge.b   .L9
            moveq   #0,D7
.L9:
            move.w  ($5A,A3),D0
            ext.l   D0
            add.l   D7,D0
            bge.b   .L10
            moveq   #0,D7
.L10:
            move.w  ($5A,A3),D0
            ext.l   D0
            move.l  D0,D5
            add.l   D7,D5
.L11:
            move.l  D5,D0
.L12:
            movem.l (-$24,A6),D5-D7/A3-A4
            unlk    A6
            rts
RegisterClose:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            move.w  #$1E,($5A,A3)
            move.l  A3,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            jsr     SetBrightness
            move.w  D0,($5A,A3)
            move.l  A3,-(SP)
            movea.l (SP)+,A0
            _SleepQRemove
            pea     ShutdownBacklight
            move.w  #4,-(SP)
            _ShutDown
            moveq   #0,D0
            lea     ($C,SP),SP
            movea.l (SP)+,A3
            rts
RegisterControl:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($18,SP),A3
            moveq   #0,D6
            move.w  ($1A,A4),D0
            subi.w  #$4301,D0
            bmi.w   .L7
            cmpi.w  #4,D0
            bgt.b   .L7
            add.w   D0,D0
            move.w  .L2(PC,D0.w),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L3-(.L1+2)
            dc.w    .L4-(.L1+2)
            dc.w    .L7-(.L1+2)
            dc.w    .L5-(.L1+2)
            dc.w    .L6-(.L1+2)
.L3:
            move.w  ($1C,A4),D0
            ext.l   D0
            move.l  D0,D7
            move.l  A3,-(SP)
            move.l  D7,-(SP)
            jsr     SetBrightness
            move.w  D0,($5A,A3)
            addq.l  #8,SP
            bra.b   .L8
.L4:
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #$1F,D1
            move.l  D1,-(SP)
            move.w  ($5A,A3),D2
            ext.l   D2
            addq.l  #1,D2
            move.l  D2,-(SP)
            jsr     (SaveBacklightInfo.w,PC)
            lea     ($C,SP),SP
            bra.b   .L8
.L5:
            move.w  ($1C,A4),D0
            ext.l   D0
            move.l  D0,D7
            moveq   #7,D0
            and.l   D7,D0
            move.w  D0,($60,A3)
            ext.l   D0
            move.l  D0,-(SP)
            jsr     setNewKeys
            addq.l  #4,SP
            bra.b   .L8
.L6:
            moveq   #5,D0
            move.l  D0,-(SP)
            pea     ($E0).w
            move.w  ($60,A3),D1
            ext.l   D1
            move.l  D1,-(SP)
            jsr     (SaveBacklightInfo.w,PC)
            lea     ($C,SP),SP
            bra.b   .L8
.L7:
            moveq   #-$11,D6
.L8:
            move.w  D6,D0
            movem.l (SP)+,D6-D7/A3-A4
            rts
RegisterStatus:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A4
            movea.l ($10,SP),A3
            clr.w   D7
            move.w  ($1A,A3),D0
            subi.w  #$5301,D0
            bmi.b   .L9
            cmpi.w  #5,D0
            bgt.b   .L9
            add.w   D0,D0
            move.w  .L2(PC,D0.w),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L3-(.L1+2)
            dc.w    .L4-(.L1+2)
            dc.w    .L5-(.L1+2)
            dc.w    .L6-(.L1+2)
            dc.w    .L7-(.L1+2)
            dc.w    .L8-(.L1+2)
.L3:
            move.w  ($5A,A4),($1C,A3)
            bra.b   .L10
.L4:
            move.w  ($60,A4),($1C,A3)
            bra.b   .L10
.L5:
            move.w  #$1E,($1C,A3)
            clr.w   ($1E,A3)
            bra.b   .L10
.L6:
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #$1F,D1
            move.l  D1,-(SP)
            jsr     (GetBacklightInfo.w,PC)
            subq.l  #1,D0
            move.w  D0,($1C,A3)
            addq.l  #8,SP
            bra.b   .L10
.L7:
            moveq   #5,D0
            move.l  D0,-(SP)
            pea     ($E0).w
            jsr     (GetBacklightInfo.w,PC)
            move.w  D0,($1C,A3)
            addq.l  #8,SP
            bra.b   .L10
.L8:
            movea.l ($4E,A4),A0
            move.w  ($54,A4),D0
            ext.l   D0
            add.l   D0,D0
            move.w  (0,A0,D0.l),($1C,A3)
            bra.b   .L10
.L9:
            moveq   #-$12,D7
.L10:
            move.w  D7,D0
            movem.l (SP)+,D7/A3-A4
            rts
setNewKeys:
            movem.l D6-D7/A3,-(SP)
            move.l  ($10,SP),D6
            clr.b   D7
            btst    #0,D6
            beq.b   .L1
            ori.b   #$10,D7
.L1:
            moveq   #2,D0
            and.l   D6,D0
            beq.b   .L2
            ori.b   #2,D7
.L2:
            moveq   #4,D0
            and.l   D6,D0
            beq.b   .L3
            ori.b   #8,D7
.L3:
            lea     (KeyHookVars.w,PC),A3
            move.b  D7,(5,A3)
            movem.l (SP)+,D6-D7/A3
            rts

            EVEN
