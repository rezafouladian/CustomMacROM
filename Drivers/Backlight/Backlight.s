            include "Include/ROMHeader.s"

            EXPORT  asahiTbl,DRVRClose,DRVRControl,DRVROpen,DRVRPrime,DRVRStatus
            EXPORT  GetBacklightInfo,KeyHookVars,PortableMaxTbl,PortableTable7V,PortableTbl5V,PotInputRangeShiftTblPWM
            EXPORT  PWMMaxTbl,SaveBacklightInfo,SleepEntry,timTbl,timTblLow

            IMPORT  Glue_DisposPtr,Glue_NewPtrSysClear,Glue_VInstall,Glue_VRemove,InitPWMControls,InitRegControls,Sleep_Task

            SECTION "Backlight",CODE

DRVROpen:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            subq.l  #4,SP
            moveq   #$64,D0
            move.l  D0,-(SP)
            jsr     (Glue_NewPtrSysClear.w,PC)
            movea.l (SP)+,A3
            move.l  A3,D0
            bne.b   .L1
            move.w  #$FFE9,($10,A6)
            bra.w   .L7
.L1:
            movea.w #$D18,A4
            movea.l (8,A6),A0
            move.l  A3,($14,A0)
            move.w  #$101,($1E,A3)
            bset    #2,($23,A3)
            movea.l (A4),A0
            move.b  ($D,A0),D0
            ext.w   D0
            move.w  D0,($52,A3)
            cmp.w   ($56,A3),D0
            ble.b   .L2
            move.w  ($52,A3),D0
            ext.l   D0
            bra.b   .L3
.L2:
            move.w  ($56,A3),D0
            ext.l   D0
.L3:
            move.w  D0,($54,A3)
            move.b  BoxFlag,D7
            move.b  D7,D0
            subq.b  #4,D0
            beq.b   .L4
            subi.b  #$B,D0
            beq.b   .L5
            subq.b  #4,D0
            beq.b   .L5
            bra.b   .L6
.L4:
            move.l  A3,-(SP)
            jsr     (InitRegControls.w,PC)
            addq.l  #4,SP
            bra.b   .L6
.L5:
            move.l  A3,-(SP)
            jsr     (InitPWMControls.w,PC)
            addq.l  #4,SP
.L6:
            move.l  A3,($C,A3)
            move.w  #1,($14,A3)
            lea     VBLEntry,A0
            move.l  A0,($16,A3)
            move.w  ($58,A3),($1A,A3)
            clr.w   ($1C,A3)
            subq.l  #2,SP
            pea     ($10,A3)
            jsr     (Glue_VInstall.w,PC)
            clr.w   ($10,A6)
            addq.l  #2,SP
.L7:
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
DRVRClose:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($14,A4),A3
            subq.l  #2,SP
            pea     ($10,A3)
            jsr     (Glue_VRemove.w,PC)
            tst.l   ($34,A3)
            addq.l  #2,SP
            beq.b   .L1
            move.l  A3,-(SP)
            movea.l ($34,A3),A0
            jsr     (A0)
            addq.l  #4,SP
.L1:
            move.l  A3,-(SP)
            jsr     (Glue_DisposPtr.w,PC)
            moveq   #0,D0
            move.l  D0,($14,A4)
            clr.w   ($10,A6)
            movem.l (-8,A6),A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
DRVRPrime:
            move.w  #$FFDC,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
DRVRControl:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A0
            movea.l ($14,A0),A3
            bclr    #2,($23,A3)
            moveq   #0,D6
            move.w  ($1A,A4),D0
            subi.w  #$4303,D0
            bmi.w   .L16
            cmpi.w  #4,D0
            bgt.w   .L16
            add.w   D0,D0
            move.w  .L2(PC,D0.w),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L3-(.L1+2)
            dc.w    .L16-(.L1+2)
            dc.w    .L16-(.L1+2)
            dc.w    .L6-(.L1+2)
            dc.w    .L12-(.L1+2)
.L3:
            tst.w   ($1C,A4)
            beq.b   .L4
            moveq   #1,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            andi.b  #$FE,($23,A3)
            andi.b  #1,D0
            or.b    D0,($23,A3)
            bra.w   .L17
.L6:
            move.w  ($1C,A4),D0
            ext.l   D0
            move.l  D0,D7
            moveq   #4,D0
            cmp.l   D7,D0
            bge.b   .L7
            moveq   #4,D0
            bra.b   .L9
.L7:
            tst.l   D7
            bge.b   .L8
            moveq   #0,D0
            bra.b   .L9
.L8:
            move.l  D7,D0
.L9:
            move.l  D0,D7
            move.w  D7,($56,A3)
            move.w  ($52,A3),D0
            cmp.w   ($56,A3),D0
            ble.b   .L10
            move.w  ($52,A3),D0
            ext.l   D0
            bra.b   .L11
.L10:
            move.w  ($56,A3),D0
            ext.l   D0
.L11:
            move.w  D0,($54,A3)
            move.l  A3,-(SP)
            move.w  ($5A,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            movea.l ($24,A3),A0
            jsr     (A0)
            move.w  D0,($5A,A3)
            addq.l  #8,SP
            bra.b   .L17
.L12:
            btst    #5,($23,A3)
            bne.b   .L13
            moveq   #-$11,D6
            bra.b   .L17
.L13:
            tst.w   ($1C,A4)
            beq.b   .L14
            move.l  ($4A,A3),D0
            bra.b   .L15
.L14:
            move.l  ($46,A3),D0
.L15:
            move.l  D0,($42,A3)
            move.l  A3,-(SP)
            move.w  ($5A,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            movea.l ($24,A3),A0
            jsr     (A0)
            move.w  D0,($5A,A3)
            addq.l  #8,SP
            bra.b   .L17
.L16:
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            movea.l ($2C,A3),A0
            jsr     (A0)
            ext.l   D0
            move.l  D0,D6
            addq.l  #8,SP
.L17:
            bset    #2,($23,A3)
            move.w  D6,($10,A6)
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
DRVRStatus:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            clr.w   D7
            movea.l (8,A6),A0
            movea.l ($14,A0),A3
            bclr    #2,($23,A3)
            move.w  ($1A,A4),D0
            subi.w  #$5307,D0
            bmi.b   .L4
            cmpi.w  #0,D0
            bgt.b   .L4
            add.w   D0,D0
            move.w  .L2(PC,D0.w),D0
.L1:
            jmp     .L1+2(PC,D0.w)
.L2:
            dc.w    .L3-(.L1+2)
.L3:
            move.w  ($1E,A3),($1C,A4)
            bra.b   .L5
.L4:
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            movea.l ($30,A3),A0
            jsr     (A0)
            move.w  D0,D7
            addq.l  #8,SP
.L5:
            bset    #2,($23,A3)
            move.w  D7,($10,A6)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
VBL_Task:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.w #$D18,A4
            move.l  (8,A6),D0
            subq.l  #4,D0
            movea.l D0,A0
            movea.l (A0),A3
            move.w  ($58,A3),($1A,A3)
            btst    #2,($23,A3)
            sne     D0
            andi.w  #1,D0
            ext.l   D0
            beq.b   .L3
            tst.l   ($38,A3)
            beq.b   .L1
            move.l  A3,-(SP)
            movea.l ($38,A3),A0
            jsr     (A0)
            addq.l  #4,SP
.L1:
            btst    #0,($23,A3)
            bne.b   .L2
            move.l  A3,-(SP)
            jsr     UserAdjust
            addq.l  #4,SP
.L2:
            movea.l (A4),A0
            move.b  ($D,A0),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,D7
            moveq   #2,D0
            cmp.l   D7,D0
            beq.b   .L3
            move.w  ($52,A3),D0
            ext.l   D0
            cmp.l   D0,D7
            beq.b   .L3
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            jsr     PowerChange
            addq.l  #8,SP
.L3:
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
UserAdjust:
            link.w  A6,#-$32
            movem.l D6-D7/A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($5A,A3),D0
            ext.l   D0
            move.l  D0,D7
            move.l  A3,-(SP)
            movea.l ($28,A3),A0
            jsr     (A0)
            move.l  D0,D6
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            movea.l ($24,A3),A0
            jsr     (A0)
            move.w  D0,($5A,A3)
            btst    #3,($23,A3)
            lea     ($C,SP),SP
            bne.b   .L1
            move.w  ($5A,A3),D0
            ext.l   D0
            cmp.l   D0,D7
            beq.b   .L1
            move.w  #$4302,(-$18,A6)
            move.l  A3,-(SP)
            pea     (-$32,A6)
            movea.l ($2C,A3),A0
            jsr     (A0)
            addq.l  #8,SP
.L1:
            movem.l (-$3E,A6),D6-D7/A3
            unlk    A6
            rts
PowerChange:
            movem.l D5-D7/A3,-(SP)
            move.l  ($18,SP),D6
            movea.l ($14,SP),A3
            move.w  ($52,A3),D0
            ext.l   D0
            cmp.l   D0,D6
            sgt     D5
            neg.b   D5
            move.w  D6,($52,A3)
            move.w  ($52,A3),D0
            cmp.w   ($56,A3),D0
            ble.b   .L1
            move.w  ($52,A3),D0
            ext.l   D0
            bra.b   .L2
.L1:
            move.w  ($56,A3),D0
            ext.l   D0
.L2:
            move.w  D0,($54,A3)
            move.l  A3,-(SP)
            movea.l ($28,A3),A0
            jsr     (A0)
            move.l  D0,D7
            tst.b   D5
            addq.l  #4,SP
            beq.b   .L3
            tst.l   D6
            beq.b   .L3
            btst    #3,($23,A3)
            bne.b   .L3
            tst.l   D7
            beq.b   .L3
            asr.l   #1,D7
            tst.l   D7
            bne.b   .L3
            moveq   #1,D7
.L3:
            move.l  A3,-(SP)
            move.l  D7,-(SP)
            movea.l ($24,A3),A0
            jsr     (A0)
            move.w  D0,($5A,A3)
            addq.l  #8,SP
            movem.l (SP)+,D5-D7/A3
            rts
GetBacklightInfo:
            link.w  A6,#-2
            moveq   #$74,D0
            move.w  D0,-(SP)
            moveq   #1,D1
            move.w  D1,-(SP)
            pea     (-1,A6)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            _ReadXPRam
            moveq   #0,D0
            move.b  (-1,A6),D0
            move.w  ($A,A6),D1
            ext.l   D1
            and.l   D0,D1
            move.w  ($E,A6),D0
            asr.l   D0,D1
            move.l  D1,D0
            unlk    A6
            rts
SaveBacklightInfo:
            link.w  A6,#-2
            movem.l D6-D7,-(SP)
            move.w  ($E,A6),D6
            moveq   #$70,D7
            move.l  D7,D0
            addq.l  #4,D0
            move.w  D0,-(SP)
            moveq   #1,D0
            move.w  D0,-(SP)
            pea     (-1,A6)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            _ReadXPRam
            move.w  D6,D0
            not.w   D0
            and.b   D0,(-1,A6)
            move.w  ($12,A6),D0
            move.w  ($A,A6),D1
            lsl.w   D0,D1
            move.w  D6,D0
            and.w   D1,D0
            or.b    D0,(-1,A6)
            move.l  D7,D0
            addq.l  #4,D0
            move.w  D0,-(SP)
            moveq   #1,D0
            move.w  D0,-(SP)
            pea     (-1,A6)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            _WriteXPRam
            movem.l (-$A,A6),D6-D7
            unlk    A6
            rts
VBLEntry:
            move.l  A0,-(SP)
            jsr     VBL_Task
            movea.l (SP)+,A0
            rts

            movem.l D1/A1,-(SP)
            lea     KeyHookVars,A1
            move.l  A0,D1
            tst.b   (5,A1)
            beq.b   .L2
            cmpi.w  #3,D1
            beq.b   .L1
            tst.b   (4,A1)
            beq.b   .L2
            cmpi.w  #5,D1
            bne.b   .L2
            bra.b   .L3
.L1:
            move.w  ($17A).w,D1
            rol.w   #1,D1
            cmp.b   (5,A1),D1
            bne.b   .L2
            st      (4,A1)
            bra.b   .L3
.L2:
            sf      (4,A1)
            movea.l (A1),A1
            jsr     (A1)
.L3:
            movem.l (SP)+,D1/A1
            rts
KeyHookVars:
            ds.b    8
SleepEntry:
            move.l  D0,-(SP)
            move.l  A0,-(SP)
            jsr     (Sleep_Task.w,PC)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            moveq   #0,D0
            rts
PortableTable7V:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$191C,$2024,$282D,$3200
PortableTbl5V:
            dc.w    $0002,$0507,$090B,$0D0F,$1113,$1517,$191B,$1D1F
            dc.b    '!#%',$27,'*-036:>BFKP'
            dc.b    $00
PortableMaxTbl:
            dc.w    $001E,$000F,$000F,$0007,$0003
asahiTbl:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$1819,$1A1B,$1C1D,$1E1F
timTbl:
            dc.w    $1F1E,$1D1C,$1B1A,$1918,$1716,$1514,$1312,$1110
            dc.w    $0F0E,$0D0C,$0B0A,$0908,$0706,$0504,$0302,$0100
timTblLow:
            dc.w    $1F1E,$1E1D,$1C1C,$1B1A,$1919,$1817,$1616,$1514
            dc.w    $1413,$1211,$1110,$0F0E,$0E0D,$0C0B,$0B0B,$0A0A
PWMMaxTbl:
            dc.w    $001F,$000F,$000F,$0007,$0003
PotInputRangeShiftTblPWM:
            dc.w    0,$0001,$0001,$0002,$0003

            EVEN
