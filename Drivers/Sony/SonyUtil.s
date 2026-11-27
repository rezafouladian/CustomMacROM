DrvVarOS:
            dc.w    $004A,$008C,$014E,$016A         ; drive vars offsets for drives 1-4
; Return the stuff, but do not translate the drive number.
GetRDrive:
            movea.l IWM,A0                          ; set up hardware pointers
            movea.l VIA,A2
            bsr.b   GetDrv2
            move.w  DrvVarOS-2(PC,D1.w),D1          ; untranslated drive vars
            rts
; Return the stuff, but logically translate the drive number.
GetDrive:
            movea.l IWM,A0
            movea.l VIA,A2
GetDrv1:
            bsr.b   GetDrv2
            move.w  DrvVarOS-2(PC,D1.w),D1          ; driver vars offset
            rts
GetDrv2:
            movea.l SonyVars,A1
            move.w  ($12,A1),D1
            cmpi.w  #4,D1
            bls.b   .L1
            moveq   #4,D1
.L1:
            add.w   D1,D1
            rts
AdrDisk:
            bsr.b   GetDrive
            tst.b   ($139,A1)
            bmi.w   mAdrDisk
            tst.b   ($200,A0)
            tst.b   ($600,A0)
            lsr.b   #1,D0
            bcc.b   .L1
            tst.b   ($A00,A0)
            bra.b   .L2
.L1:
            tst.b   ($800,A0)
.L2:
            lsr.b   #1,D0
            bcc.b   .L3
            bset    #5,($1E00,A2)
            bra.b   .L4
.L3:
            bclr    #5,($1E00,A2)
.L4:
            lsr.b   #1,D0
            bcs.b   .L5
            tst.b   (A0)
.L5:
            lsr.b   #1,D0
            bcs.b   .L6
            tst.b   ($400,A0)
.L6:
            rts
AdrAndSense:
            bsr.b   AdrDisk
Sense:
            tst.b   ($139,A1)
            bmi.w   mSense
            move    SR,-(SP)
            ori     #$700,SR
            tst.b   ($1A00,A0)
            move.b  ($1C00,A0),D0
            tst.b   ($1800,A0)
            move    (SP)+,SR
            tst.b   D0
            rts
AdrAndStrb:
            bsr.b   AdrDisk
Pulse:
            tst.b   ($139,A1)
            bmi.w   mPulse
            move    SR,-(SP)
            ori     #$700,SR
            tst.b   ($E00,A0)
            move.b  ($1E00,A2),($1E00,A2)
            tst.b   ($C00,A0)
            move    (SP)+,SR
            rts
sub_4086D492:
            moveq   #$D,D0
            bsr.b   AdrAndSense
            bpl.b   .L1
            tst.b   (A0)
            bsr.b   Sense
            bpl.b   .L1
            tst.b   ($200,A0)
            tst.b   ($400,A0)
            bsr.b   Sense
            bra.b   .L2
.L1:
            moveq   #-1,D0
.L2:
            rts
sub_4086D4AE:
            bclr    #$B,D6
            move.l  ($236).w,-(SP)
            rts
jtSeek:
            movea.l (SP)+,A6
            bsr.w   GetDrv1
            move.w  (0,A1,D1.w),D7
            bpl.b   .L1
            bsr.w   Recal
            move.w  D0,D7
            bra.b   .L4
.L1:
            moveq   #0,D0
            move.w  D6,D5
            sub.w   D7,D5
            beq.b   .L6
            bgt.b   .L2
            moveq   #1,D0
            neg.w   D5
.L2:
            bsr.b   AdrAndStrb
            moveq   #-$4B,D7
            subq.w  #1,D5
.L3:
            moveq   #4,D0
            bsr.w   AdrAndSense
            bpl.b   .L4
            bsr.b   Pulse
            bsr.b   Wait100
            dbra    D5,.L3
            move.w  D6,D7
.L4:
            bsr.w   GetDrv1
            move.w  D7,(0,A1,D1.w)
            tst.b   ($139,A1)
            bpl.b   .L5
            bsr.w   NotSWIM2
            beq.b   .L5
            move.w  D0,D7
.L5:
            move.w  ($34,A1),D0
            moveq   #5,D2
            bsr.b   sub_4086D548
.L6:
            move.w  ($14,A1),D0
            moveq   #0,D2
            bsr.b   sub_4086D548
            move.w  D7,D0
            RTS6
Wait100:
            move.w  ($3C,A1),D0
            bsr.b   sub_4086D53A
            moveq   #$50,D2
.L1:
            moveq   #4,D0
            bsr.w   AdrAndSense
            dbmi    D2,.L1
            move.w  TimeDBRA,D2
            lsr.w   #5,D2
.L2:
            dbra    D2,.L2
            rts
sub_4086D53A:
            tst.b   ($13,A1,D1.w)
            bmi.b   .L1
            addq.w  #4,SP
            tst.w   D0
            bne.b   WakeUp_SonyRWT
.L1:
            rts
sub_4086D548:
            bsr.b   sub_4086D53A
            movea.l (SP)+,A4
            move.w  #$3E8,D5
            move.w  D2,D0
            beq.b   .L2
.L1:
            bsr.b   WakeUp_SonyRWT
.L2:
            moveq   #$B,D0
            bsr.w   AdrAndSense
            bpl.b   .L3
            moveq   #$A,D0
            dbra    D5,.L1
.L3:
            clr.w   ($14,A1)
            jmp     (A4)
WakeUp_SonyRWT:
            move.l  ($246).w,-(SP)
            rts
jtWakeUp:
            movem.l D3-D7/A3-A6,($D0,A1)
            move.l  (SP)+,DskRtnAdr
            bsr.b   WakeSetUp
            bra.b   WakeGo.L1
WakeGo:
            movem.l D3-D7/A3-A6,($D0,A1)
            move.l  (SP)+,DskRtnAdr
.L1:
            moveq   #0,D0
            andi    #$F8FF,SR
            rts
WakeSetUp:
            movea.l SonyVars,A1
            sub.w   D0,($14,A1)
            bgt.b   .L1
            clr.w   ($14,A1)
.L1:
            lea     ($118,A1),A0
            lea     GoWakeIt,A1
            move.l  A1,(6,A0)
            andi.l  #$FFFF,D0
            cmpi.w  #$A,D0
            bcc.b   .L2
            moveq   #$A,D0
.L2:
            divu.w  #$A,D0
            ext.l   D0
            movea.l ($568).w,A1
            jsr     (A1)
            bra.w   GetDrv1
GoWakeIt:
            movem.l D0-D7/A0-A6,-(SP)
            bsr.w   GetDrive
            movem.l ($D0,A1),D3-D7/A3-A6
            moveq   #0,D0
            bsr.w   sub_4086D7F2
            movem.l (SP)+,D0-D7/A0-A6
            rts
Recal:
            move.l  ($23E).w,-(SP)
            rts
jtRecal:
            movea.l (SP)+,A5
            bsr.w   GetDrive
            bsr.w   sub_4086D6AC
            bsr.w   SetChipMode
            bne.b   .L5
            bsr.w   PowerUp
            moveq   #$50,D7
            moveq   #1,D0
            bsr.w   AdrAndStrb
.L1:
            bra.w   sub_408707FE.L1
            ds.b    12
.L2:
            moveq   #$A,D0
            bsr.w   AdrAndSense
            bpl.b   .L4
            moveq   #4,D0
            bsr.w   AdrAndSense
            bpl.b   .L3
            moveq   #-$4C,D0
            subq.w  #1,D7
            beq.b   .L5
            bsr.w   Pulse
            bra.b   .L1
.L3:
            moveq   #-$4B,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            move.w  D0,(0,A1,D1.w)
            RTS5
SetIWMMode:
            tst.b   ($1A00,A0)
            moveq   #$1F,D0
            and.b   ($1C00,A0),D0
            tst.b   ($1800,A0)
            cmpi.b  #$17,D0
            beq.b   .L2
            moveq   #8,D2
            swap    D2
.L1:
            moveq   #-$4D,D0
            subq.l  #1,D2
            bmi.b   .L3
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$3F,D0
            and.b   ($1C00,A0),D0
            bclr    #5,D0
            bne.b   .L1
            cmpi.b  #$17,D0
            beq.b   .L2
            move.b  #$17,($1E00,A0)
            tst.b   ($1C00,A0)
            bra.b   .L1
.L2:
            tst.b   ($1800,A0)
            moveq   #0,D0
.L3:
            rts
PowerDown:
            bsr.w   GetDrv1
            move.w  D0,($1A,A1)
            beq.b   .L1
            move.w  ($12,A1),($116,A1)
            rts
.L1:
            moveq   #9,D0
            bsr.w   AdrAndStrb
            move.b  #$80,($C00,A0)
            tst.b   ($1000,A0)
            rts
sub_4086D6AC:
            move.w  ($102,A1),D0
            cmp.w   ($12,A1),D0
            bne.b   .L1
            clr.w   ($102,A1)
.L1:
            rts
sub_4086D6BC:
            moveq   #0,D0
            bra.b   PowerUp.L1
PowerUp:
            move.w  ($38,A1),D0
.L1:
            move.w  D0,D2
            bsr.b   sub_4086D716
            move.b  ($16,A1,D1.w),D5
            bpl.b   .L3
            moveq   #7,D0
            bsr.w   AdrAndSense
            move.b  D0,-(SP)
            moveq   #7,D0
            move.b  ($17,A1,D1.w),D5
            bpl.b   .L2
            moveq   #6,D0
.L2:
            bsr.w   AdrAndStrb
            move.b  (SP)+,D0
            eor.b   D0,D5
.L3:
            moveq   #8,D0
            bsr.w   AdrAndSense
            or.b    D5,D0
            bpl.b   .L4
            bsr.w   Pulse
            move.w  D2,D0
            move.w  #$2EE,D2
            move.l  (SP)+,D4
            bsr.w   sub_4086D548
            move.l  D4,-(SP)
            cmpi.b  #2,($33,A1)
            beq.b   .L4
            move.w  #$1770,D0
            bra.w   WakeUp_SonyRWT
.L4:
            rts
sub_4086D716:
            bsr.w   GetDrive
sub_4086D71A:
            move.l  jDiskSel,-(SP)
            rts
jtDiskSel:
            tst.w   ($1A,A1)
            beq.b   .L1
            move.w  ($116,A1),D0
            cmp.w   ($12,A1),D0
            beq.b   .L1
            moveq   #0,D0
            bsr.w   PowerDown
.L1:
            clr.w   ($1A,A1)
            tst.b   ($139,A1)
            bmi.w   mPulse.L8
            cmpi.w  #$4A,D1
            bne.b   .L2
            tst.b   ($1400,A0)
            tst.b   ($1200,A0)
            rts
.L2:
            tst.b   ($A00,A0)
            tst.b   ($600,A0)
            tst.b   ($200,A0)
            bclr    #5,($1E00,A2)
            tst.b   ($1600,A0)
            tst.b   ($FC,A1)
            beq.b   .L3
            tst.b   ($1200,A0)
            rts
.L3:
            cmpi.w  #$8C,D1
            bne.b   .L7
            tst.b   ($1200,A0)
            moveq   #2,D0
.L4:
            move    SR,-(SP)
            ori     #$700,SR
            tst.b   ($1A00,A0)
.L5:
            tst.b   ($1C00,A0)
            dbpl    D0,.L6
            tst.b   ($1800,A0)
            move    (SP)+,SR
            rts
.L6:
            tst.b   ($E00,A0)
            move.b  ($1E00,A2),($1E00,A2)
            tst.b   ($C00,A0)
            move.b  ($1E00,A2),($1E00,A2)
            tst.b   ($400,A0)
            move.b  ($1E00,A2),($1E00,A2)
            tst.b   ($600,A0)
            move.b  ($1E00,A2),($1E00,A2)
            bra.b   .L5
.L7:
            tst.b   ($1000,A0)
            move.w  ($12,A1),D0
            move.b  ($1E00,A2),($1E00,A2)
            tst.b   ($1200,A0)
            subq.w  #3,D0
            bra.b   .L4
MakeSpdTbl:
            move.l  ($24E).w,-(SP)
            rts
jtMakeSpdTbl:
            move.w  #$1F40,D0
            bra.w   WakeUp_SonyRWT
            move.l  DiskVars,-(SP)
            rts
jtFigTrkSpd:
            moveq   #-1,D0
            rts
sub_4086D7F2:
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
sub_4086D7FA:
            move    SR,-(SP)
            movea.l SonyVars,A1
            bsr.w   sub_40870834
            nop
            ori     #$700,SR
            tst.b   ($19,A1)
            bne.b   .L4
            tst.w   ($1A,A1)
            beq.b   .L1
            subq.w  #1,($1A,A1)
            bne.b   .L4
            moveq   #9,D0
            bsr.w   AdrAndStrb
.L1:
            moveq   #1,D3
.L2:
            bsr.b   sub_4086D848
            addq.w  #1,D3
            cmpi.w  #4,D3
            bgt.b   .L3
            tst.b   ($FC,A1)
            beq.b   .L2
            cmpi.w  #3,D3
            ble.b   .L2
.L3:
            move.b  #$80,($C00,A0)
            bsr.w   sub_4087083E
.L4:
            move    (SP)+,SR
            rts
sub_4086D848:
            move.w  D3,($12,A1)
            bsr.w   GetDrive
            tst.b   (4,A1,D1.w)
            bmi.b   .L8
            tst.b   (3,A1,D1.w)
            bgt.b   .L1
            beq.b   .L2
            bra.w   sub_4087083E.L3
            nop
            nop
.L1:
            cmpi.w  #3,($12,A1)
            bge.b   .L8
            bsr.w   sub_4086D71A
            bsr.b   sub_4086D8D0
            bpl.b   .L8
            moveq   #-1,D0
            move.w  ($12,A1),D0
            movea.w #7,A0
            _PostEvent
            bra.b   .L8
.L2:
            bsr.w   sub_4086D71A
            cmpi.w  #3,($12,A1)
            blt.b   .L5
            tst.b   ($139,A1)
            bpl.b   .L3
            move.b  #$F2,($800,A0)
            bra.b   .L4
.L3:
            tst.b   (A0)
            tst.b   ($800,A0)
.L4:
            bsr.w   Sense
            bmi.b   .L6
            bra.b   .L8
.L5:
            moveq   #2,D0
            bsr.w   AdrAndSense
            bmi.b   .L8
.L6:
            bsr.b   sub_4086D8D0
            moveq   #7,D0
            movea.l D0,A0
            move.w  ($12,A1),D0
            _PostEvent
            bne.b   .L7
            addq.b  #1,(3,A1,D1.w)
.L7:
            st      (0,A1,D1.w)
            movea.l IWM,A0
.L8:
            rts
sub_4086D8D0:
            tst.b   (5,A1,D1.w)
            bpl.b   .L1
            moveq   #$C,D0
            bsr.w   AdrAndSense
            bpl.b   .L1
            moveq   #3,D0
            bsr.w   AdrAndStrb
            moveq   #-1,D0
.L1:
            rts
