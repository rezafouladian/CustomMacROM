            include "Include/ROMHeader.s"

            EXPORT  BOOTBLOCKFLUSHRETURN,GetDefaultStartup,GetOSDefault,GetVideoDefault,InternalWait,SetDefaultStartup
            EXPORT  SetOSDefault,SetVideoDefault,EraseMyIcon,FindStartupDevice

            IMPORT  BOOTBLOCKFLUSHPATCH,SCSIBoots,CenterRect

            SECTION "StartSearch",CODE

FindStartupDevice:
            bsr.w   EmbarkOnSearch
            bsr.w   LoadSlotDrvrs
            bsr.w   LoadDrivers
            bsr.w   WaitForInternal
            bra.b   .L3
.L1:
            bsr.w   PlanStrategy
            bsr.w   LoadDrivers
.L2:
            bsr.w   VisualUpdate
.L3:
            bsr.w   FindNextCandidate
            beq.b   .L1
            bsr.w   SelectDevice
            bsr.w   CheckMouseEject
            beq.b   .L2
            bsr.w   GetStartupInfo
            beq.b   .L4
            bsr.w   ReactToFailure
            bra.b   .L2
.L4:
            bra.w   ShowSuccess
            dc.w    0
GetDefaultStartup:
            move.l  #$40078,D0
            _ReadXPRam
            rts
            ds.b    6
SetDefaultStartup:
            move.l  #$40078,D0
            _WriteXPRam
            rts
            ds.b    6
GetOSDefault:
            move.l  #$20076,D0
            _ReadXPRam
            rts
            ds.b    6
SetOSDefault:
            cmpi.l  #$9961010,SetOSPassword
            bne.b   .L1
            clr.l   SetOSPassword
            move.l  #$20076,D0
            _WriteXPRam
            rts
.L1:
            clr.l   SetOSPassword
            moveq   #-1,D0
            rts
GetVideoDefault:
            move.l  #$20080,D0
            _ReadXPRam
            rts
            ds.b    6
SetVideoDefault:
            move.l  #$20080,D0
            _WriteXPRam
            rts
            ds.b    6
InternalWait:
            move.l  A0,D1
            cmpi.w  #9,D1
            bhi.b   .L1
            add.w   D1,D1
            lea     .L2,A1
            move.w  (0,A1,D1.w),D1
            jsr     (0,A1,D1.w)
.L1:
            rts
.L2:
            dc.w    $07E8,$07F8,$0818,$0828,$0848,$0868,$0888,$08A8
            ds.b    8
EmbarkOnSearch:
            subq.w  #4,SP
            movea.l SP,A0
            _GetDefaultStartup
            move.w  (SP)+,D3
            move.w  (SP)+,D4
            subq.w  #2,SP
            movea.l SP,A0
            _GetOSDefault
            swap    D3
            move.w  (SP)+,D3
            swap    D3
            suba.l  A2,A2
            lea     IsItFlopOrDef,A3
            tst.w   D4
            bne.b   .L1
            lea     IsItAnything,A3
.L1:
            movea.l Ticks,A4
            clr.w   D6
            rts
            ds.b    4
WaitForInternal:
            movem.l D5/A2,-(SP)
            movea.w #2,A0
            _InternalWait
            andi.b  #$80,D0
            bne.b   .L8
            suba.l  A0,A0
            _InternalWait
            bne.b   .L1
            moveq   #$14,D0
.L1:
            mulu.w  #$3C,D0
            move.l  D0,D5
            movea.w #6,A0
            _InternalWait
.L2:
            move.w  ($17A).w,D0
            cmpi.w  #$8805,D0
            beq.b   .L8
            moveq   #7,D1
            and.b   SCSIPoll,D1
            moveq   #0,D0
            bset    D1,D0
            move.l  A0,-(SP)
            BigJsr  SCSIBoots,A0
            movea.l (SP)+,A0
            beq.b   .L7
            suba.l  A2,A2
            moveq   #-$21,D0
            sub.w   D1,D0
            move.w  D0,D1
.L3:
            bsr.w   NextDQEntry
            beq.b   .L4
            cmp.w   (8,A2),D1
            bne.b   .L3
            bra.b   .L7
.L4:
            cmp.l   Ticks,D5
            bcs.b   .L6
            moveq   #$F,D0
            add.l   Ticks,D0
.L5:
            cmp.l   Ticks,D0
            bcc.b   .L5
            bra.b   .L2
.L6:
            movea.w #4,A0
            _InternalWait
.L7:
            movea.w #7,A0
            _InternalWait
.L8:
            movem.l (SP)+,D5/A2
            rts
            ds.b    12
LoadSlotDrvrs:
            tst.w   D4
            ble.b   .L3
            suba.w  #$38,SP
            movea.l SP,A0
            suba.w  #$18,SP
            movea.l SP,A1
            move.l  A1,($14,A0)
            move.b  D4,($32,A0)
            lsr.w   #8,D4
            move.b  D4,($31,A0)
            _sFindsRsrcPtr
            bne.b   .L1
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            move.l  D3,D0
            move.b  D0,($11,A1)
            lsr.l   #8,D0
            move.b  D0,($10,A1)
            lsr.l   #8,D0
            move.b  D0,($12,A1)
            lsr.l   #8,D0
            move.b  D0,($13,A1)
            clr.b   ($16,A1)
            move.b  #6,($32,A0)
            _sExec
            bne.b   .L1
            tst.w   (2,A1)
            bne.b   .L1
            move.w  ($14,A1),D4
            bra.b   .L2
.L1:
            clr.w   D4
.L2:
            lea     ($50,SP),SP
.L3:
            rts
            ds.b    6
LoadDrivers:
            moveq   #-1,D0
            cmpi.w  #$8805,($17A).w
            bne.b   .L1
            moveq   #7,D1
            and.b   SCSIPoll,D1
            bclr    D1,D0
.L1:
            move.l  A0,-(SP)
            BigJsr  SCSIBoots,A0
            movea.l (SP)+,A0
            rts
            ds.b    14
PlanStrategy:
            cmpi.w  #$FFFB,D4
            beq.b   .L1
            lea     IsItAnything,A3
.L1:
            rts
            ds.b    4
FindNextCandidate:
            bsr.w   NextDQEntry
            beq.b   .L1
            bsr.w   IsReject
            beq.b   FindNextCandidate
            jsr     (A3)
            bne.b   FindNextCandidate
.L1:
            move.l  A2,D0
            rts
            ds.b    12
NextDQEntry:
            move.l  A2,D0
            bne.b   .L1
            movea.l ($30A).w,A2
            bra.b   .L2
.L1:
            movea.l (A2),A2
.L2:
            move.l  A2,D0
            rts
SelectDevice:
            lea     (-$400,A6),A0
            move.w  (8,A2),D0
            move.w  D0,($18,A0)
            move.w  D0,BtDskRfn
            move.w  (6,A2),D0
            move.w  D0,($16,A0)
            move.w  D0,BootDrive
            rts
            dc.w    0
CheckMouseEject:
            tst.b   MBState
            bmi.b   .L1
            bsr.w   EjectMe
.L1:
            rts
            ds.b    4
GetStartupInfo:
            move.w  #1,($2C,A0)
            clr.l   ($2E,A0)
            move.l  A6,($20,A0)
            move.l  #$400,($24,A0)
            bra.l   BOOTBLOCKFLUSHPATCH
            dc.w    $0200
BOOTBLOCKFLUSHRETURN:
            rts
ReactToFailure:
            cmpi.w  #$FFBF,D0
            beq.b   .L3
            cmpi.w  #$FFC0,D0
            beq.b   .L1
            bsr.w   EjectMe
            beq.b   .L2
.L1:
            bsr.w   NeverAgain
.L2:
            bsr.w   ShowDeviceFail
.L3:
            rts
            ds.b    4
VisualUpdate:
            bset    #8,D6
            beq.b   .L4
            cmpa.l  Ticks,A4
            bhi.b   .L4
            movea.l Ticks,A4
            lea     ($3C,A4),A4
            bclr    #$A,D6
            beq.b   .L1
            move.b  #3,D6
.L1:
            bchg    #9,D6
            bne.b   .L2
            bsr.w   ShowPlainDisk
            bra.b   .L4
.L2:
            tst.b   D6
            beq.b   .L3
            bsr.w   ShowDiskX
            subq.b  #1,D6
            bra.b   .L4
.L3:
            bsr.w   ShowDiskQ
.L4:
            rts
EnableXFlash:
            bset    #$A,D6
            rts
            ds.b    14
ShowDeviceFail:
            bsr.w   IsItFloppy
            bne.b   .L1
            bsr.b   EnableXFlash
.L1:
            rts
            ds.b    6
ShowSuccess:
            _HideCursor
            movem.l A5-A6,-(SP)
            BSR6    HappyMac
            movem.l (SP)+,A5-A6
            rts
            ds.b    12
EjectMe:
            lea     (-$400,A6),A0
            move.w  #7,($1A,A0)
            _Control
            rts
            dc.w    0
IsReject:
            bsr.w   InBootMask
            bne.b   .L1
            move.w  (6,A2),D1
            move.w  BootMask,D0
            btst    D1,D0
.L1:
            rts
            ds.b    14
IsItFlopOrDef:
            cmp.w   (8,A2),D4
            bne.b   IsItFloppy
            rts
            ds.b    8
IsItFloppy:
            cmpi.w  #$FFFB,(8,A2)
            rts
            ds.b    8
IsItAnything:
            cmp.w   D0,D0
            rts
            ds.b    12
NeverAgain:
            bsr.w   InBootMask
            bne.b   .L1
            move.w  (6,A2),D1
            move.w  BootMask,D0
            bclr    D1,D0
            move.w  D0,BootMask
.L1:
            rts
            ds.b    10
InBootMask:
            cmpi.w  #$F,(6,A2)
            bhi.b   .L1
            moveq   #0,D0
.L1:
            rts
            ds.b    4
HappyMac:
            bsr.w   EraseMyIcon
            lea     EraseMyIcon.L1,A0
            bsr.b   PlotMyIcon
            RTS6
ShowPlainDisk:
            lea     EraseMyIcon.L2,A0
            bra.b   PlotMyIcon
ShowDiskQ:
            lea     EraseMyIcon.L3,A0
            bra.b   PlotMyIcon
ShowDiskX:
            lea     EraseMyIcon.L4,A0
PlotMyIcon:
            move.l  A0,-(SP)
            bsr.b   PshIcnRect
            move.l  SP,-(SP)
            move.l  ($C,SP),-(SP)
            bsr.b   PlotIcnn
            lea     ($C,SP),SP
            rts
PshIcnRect:
            movea.l (SP)+,A1
            move.l  #$200020,-(SP)
            clr.l   -(SP)
            movea.l (A5),A0
            pea     (-$74,A0)
            pea     (4,SP)
            move.l  A1,-(SP)
            bra.w   CenterRect
PlotIcnn:
            movem.l (SP)+,D0-D2
            move.l  D0,-(SP)
            movea.l SP,A0
            move.l  #$200020,-(SP)
            clr.l   -(SP)
            move.w  #4,-(SP)
            move.l  D1,-(SP)
            move.l  -(A0),-(SP)
            move.l  -(A0),-(SP)
            move.w  -(A0),-(SP)
            movea.l -(A0),A1
            pea     ($80,A1)
            move.l  A0,-(SP)
            pea     (4,SP)
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     ($16,SP)
            move.l  D2,-(SP)
            _CopyMask
            lea     ($1C,SP),SP
            rts
EraseMyIcon:
            movem.l D0-D2/A0-A1,-(SP)
            bsr.b   PshIcnRect
            move.l  SP,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _FillRect
            addq.w  #8,SP
            movem.l (SP)+,D0-D2/A0-A1
            rts
.L1:
            dc.w    $07FF,$FFC0,$0800,$0020,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1211,$1090
            dc.w    $1211,$1090,$1201,$0090,$1201,$0090,$1203,$0090
            dc.w    $1200,$0090,$1208,$4090,$1207,$8090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$0FFF,$FFE0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $07FF,$FFC0,$0FFF,$FFE0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0
.L2:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
.L3:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8807,$E011,$880F,$F011,$880C,$3011
            dc.w    $880C,$3011,$8800,$7011,$8800,$E011,$8801,$C011
            dc.w    $8801,$8011,$8801,$8011,$8800,$0011,$8801,$8011
            dc.w    $8801,$8011,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
.L4:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8810,$0811,$8838,$1C11,$881C,$3811
            dc.w    $880E,$7011,$8807,$E011,$8803,$C011,$8803,$C011
            dc.w    $8807,$E011,$880E,$7011,$881C,$3811,$8838,$1C11
            dc.w    $8810,$0811,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
            ds.b    14
iGetTimeOut:
            jsr     GetRawTimeout
            andi.b  #$1F,D0
            rts
            ds.b    6
iSetTimeOut:
            move.b  D0,-(SP)
            jsr     GetRawTimeout
            move.b  (SP)+,D1
            cmpi.b  #$1F,D1
            bls.b   .L1
            moveq   #$1F,D1
.L1:
            andi.b  #$E0,D0
            or.b    D1,D0
            jmp     SetRawTimeout
            ds.b    6
iGetWaitFlags:
            jsr     GetRawTimeout
            andi.b  #$E0,D0
            rts
            ds.b    6
iSetWaitFlags:
            move.b  D0,-(SP)
            jsr     GetRawTimeout
            move.b  (SP)+,D1
            andi.b  #$E0,D1
            andi.b  #$1F,D0
            or.b    D1,D0
            jmp     SetRawTimeout
            ds.b    10
iDisableDynWait:
            movea.w #2,A0
            _InternalWait
            bset    #7,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iEnableDynWait:
            movea.w #2,A0
            _InternalWait
            bclr    #7,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iDisablePermWait:
            movea.w #2,A0
            _InternalWait
            bset    #6,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iEnablePermWait:
            movea.w #2,A0
            _InternalWait
            bclr    #6,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
GetRawTimeout:
            clr.b   -(SP)
            movea.l SP,A0
            move.l  #$10001,D0
            _ReadXPRam
            moveq   #0,D0
            move.b  (SP)+,D0
            rts
            ds.b    14
SetRawTimeout:
            move.b  D0,-(SP)
            movea.l SP,A0
            move.l  #$10001,D0
            _WriteXPRam
            move.b  (SP)+,D0
            rts

            EVEN
