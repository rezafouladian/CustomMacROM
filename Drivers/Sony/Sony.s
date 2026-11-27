            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_4

            IMPORT  BaseOfROM,RsrcEntrySERD_0

            SECTION "Sony",CODE

RsrcEntryDRVR_4:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 4 ".Sony" (26820 bytes) - Combo mask
            dc.l    RsrcEntrySERD_0-BaseOfROM       ; Next entry
            dc.l    RsrcDRVR_4-BaseOfROM            ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    5,'.Sony'                       ; Name
            ds.b    7
            dc.l    $C0A00000,$000068D0,$00000174   ; Block header
RsrcDRVR_4:
            dc.w    $4F00                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    SonyOpen-RsrcDRVR_4             ; drvrOpen
            dc.w    SonyPrime-RsrcDRVR_4            ; drvrPrime
            dc.w    SonyCtl-RsrcDRVR_4              ; drvrCtl
            dc.w    SonyStatus-RsrcDRVR_4           ; drvrStatus
            dc.w    SonyClose-RsrcDRVR_4            ; drvrClose
            dc.b    5,'.Sony'
SonyOpen:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.w   sub_4086CA2A.L1
            bra.w   IopDiskOpen
SonyPrime:
            move.l  ($226).w,-(SP)
            rts
            ds.b    8
SonyCtl:
            move.l  ($242).w,-(SP)                  ; JControl
            rts
            ds.b    8
SonyStatus:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.w   DiskStatus
            bra.w   IopDiskStatus
SonyClose:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.w   ReceivedCallFromIop.L4
            bra.w   sub_4086C59A.L1
IopDiskOpen:
            move.l  #$302,D0
            _NewPtrSysClear
            lea     ($276,A0),A0
            move.l  A0,SonyVars
            move.l  A1,(-4,A0)
            move.b  #2,(7,A1)
            movea.l A0,A1
            bsr.w   sub_4086E0AA
            move.w  (A2),D0
            bsr.b   sub_4086C47C
            move.l  A3,(-8,A1)
            move.w  (2,A2),D0
            bsr.b   sub_4086C47C
            move.l  A3,(-$C,A1)
            move.w  (8,A2),D0
            bsr.b   sub_4086C47C
            move.l  A3,(-$10,A1)
            bra.b   sub_4086C47C.L2
sub_4086C47C:
            lea     (0,A2,D0.w),A3
            bclr    #0,D0
            beq.b   .L1
            lea     sub_4086D8D0.L2,A3
            adda.w  D0,A3
.L1:
            rts
.L2:
            lea     (-$5E,A1),A0
            move.w  #$102,(A0)+
            move.l  #$2202000,(A0)+
            lea     (-$84,A1),A2
            move.l  A2,(A0)+
            move.l  A2,(A0)+
            lea     ReceivedCallFromIop,A2
            move.l  A2,(A0)+
            lea     (-$64,A1),A0
            _IOPMsgRequest
            bne.w   .L6
            lea     (-$22,A1),A0
            move.w  #$100,(A0)+
            move.l  #$2202000,(A0)+
            lea     (-$48,A1),A2
            move.l  A2,(A0)+
            move.l  A2,(A0)+
            lea     IOPCallReturned,A2
            move.l  A2,(A0)+
            move.b  #1,(-$48,A1)
            bsr.w   sub_4086C590
            lea     sub_4086C5AC,A2
            move.l  A2,($226).w
            lea     sub_4086C6D4,A2
            move.l  A2,($242).w
            lea     (-$100,A1),A2
            lea     sub_4086C5AC.L5,A3
            moveq   #-$11,D0
            moveq   #$A,D1
            bsr.w   sub_4086C578
            lea     (-$150,A1),A2
            lea     sub_4086C5AC.L4,A3
            moveq   #-$12,D0
            moveq   #4,D1
            bsr.b   sub_4086C578
            lea     ($14,A1),A2
            lea     (A1),A3
            lea     (-$44,A1),A4
            moveq   #0,D1
            moveq   #6,D2
            moveq   #3,D3
            move.w  #$F7C,D4
.L3:
            move.b  (A4)+,D5
            btst    D5,D3
            bne.b   .L5
            move.l  A2,(A3)
            move.b  #1,(2,A2)
            moveq   #-5,D0
            btst    D5,D4
            bne.b   .L4
            moveq   #-2,D0
            move.w  #1,(8,A2)
            movea.l UTableBase,A0
            move.l  ($10,A0),(4,A0)
.L4:
            swap    D0
            move.w  D1,D0
            swap    D0
            lea     (4,A2),A0
            _AddDrive
            lea     ($14,A2),A2
.L5:
            addq.l  #4,A3
            addq.w  #1,D1
            cmpi.w  #4,D1
            bls.b   .L3
            move.b  #5,(-$48,A1)
            move.l  #$38A,(-$44,A1)
            bsr.b   sub_4086C590
            move.b  #3,(-$48,A1)
            bsr.b   sub_4086C590
            moveq   #0,D0
.L6:
            rts
sub_4086C578:
            move.l  A2,(-4,A2)
            move.w  D1,(A2)+
            move.w  D0,(A2)+
.L1:
            move.l  (A3)+,(A2)+
            lea     RsrcDRVR_4,A4
            adda.w  (A3)+,A4
            move.l  A4,(A2)+
            dbra    D1,.L1
            rts
sub_4086C590:
            pea     sub_4086C59A
            bsr.w   CallIOPRoutine
            rts
sub_4086C59A:
            tst.l   (-$4C,A1)
            bne.b   sub_4086C59A
            rts
.L1:
            moveq   #-$18,D0
            rts
            move.l  ($226).w,-(SP)
            rts
sub_4086C5AC:
            bsr.w   sub_40871114
            nop
            moveq   #$A,D0
            cmpi.b  #2,(7,A0)
            bne.b   .L1
            moveq   #$B,D0
            btst    #6,($2D,A0)
            beq.b   .L1
            moveq   #$C,D0
.L1:
            move.b  D0,(A3)+
            moveq   #-$38,D0
            move.w  ($16,A0),D1
            cmpi.w  #4,D1
            bhi.w   .L3
            move.b  D1,(A3)+
            clr.w   (A3)+
            move.l  ($20,A0),(A3)+
            moveq   #-$32,D0
            moveq   #9,D1
            move.l  ($10,A2),D2
            ror.l   D1,D2
            move.l  D2,(A3)+
            rol.l   D1,D2
            andi.w  #$1FF,D2
            bne.b   .L3
            move.l  ($24,A0),D2
            ror.l   D1,D2
            move.l  D2,(A3)+
            rol.l   D1,D2
            andi.w  #$1FF,D2
            bne.b   .L3
            lea     BufTgFNum,A2
            move.l  (A2)+,(A3)+
            move.l  (A2)+,(A3)+
            move.l  (A2)+,(A3)+
            bsr.w   CallIOPRoutine
            lea     (-$38,A1),A0
            lea     BufTgFNum,A2
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            moveq   #0,D1
            move.b  (-$47,A1),D1
            move.l  (0,A1,D1.w*4),D2
            beq.b   .L2
            movea.l D2,A3
            cmpi.b  #2,(1,A3)
            beq.b   .L2
            move.w  (-$46,A1),(-$276,A1)
            move.b  #6,(-$48,A1)
            bsr.w   CallIOPRoutine
            bsr.w   UpdateXmtDriveStatus
            move.w  (-$276,A1),(-$46,A1)
.L2:
            move.w  (-$46,A1),D0
            bne.b   .L3
            movea.l (-4,A1),A2
            movea.l (8,A2),A0
            move.l  ($24,A0),D1
            move.l  D1,($28,A0)
            add.l   D1,($10,A2)
.L3:
            bra.w   DiskIODone
.L4:
            dc.w    $0006,$06E0,$0480,$0008,$06A0,$04D6,$000A,$06A0
            dc.w    $04EA,$4456,$1020,$04F2,$5343,$1020,$04FC
.L5:
            dc.w    $0001,0,$036A,$0005,$09E0,$0380,$0006,$08C0
            dc.w    $036E,$0007,$07E0,$037C,$0008,$0E20,$0380,$0009
            dc.w    $0D20,$0380,$0015,$06E0,$0386,$0016,$06E0,$03A8
            dc.w    $0017,$06E0,$03DC,$5343,$08C0,$03E8,$4744,$11C0
            dc.w    $0458
IopDiskControl:
            move.l  ($242).w,-(SP)                  ; JControl
            rts
sub_4086C6D4:
            movea.w #$FEFC,A2
            bra.b   IopDiskStatus.L2
IopDiskStatus:
            movea.w #$FEAC,A2
.L2:
            bsr.w   sub_4087112E
            bra.b   .SearchLoop
            ds.b    12
.SearchLoop:
            cmp.w   (A2),D2
            addq.l  #8,A2
            dbeq    D1,.SearchLoop
            bne.b   DiskIODone
            moveq   #0,D0
            movea.l -(A2),A3
            move.w  ($16,A0),D1
            move.b  -(A2),D2
            bpl.b   .DriveNumInRange
            cmpi.w  #4,D1
            bls.b   .DriveNumInRange
            moveq   #-$38,D0
            bra.b   DiskIODone
.DriveNumInRange:
            add.b   D2,D2
            bpl.b   .DriveExists
            tst.l   (0,A1,D1.w*4)
            bne.b   .DriveExists
            moveq   #-$40,D0
            bra.b   DiskIODone
.DriveExists:
            move.b  D1,(-$47,A1)
            move.b  -(A2),(-$48,A1)
            move.l  ($1C,A0),(-$44,A1)
            add.b   D2,D2
            bpl.b   .DontCallIOP
            move.l  A3,-(SP)
            bra.w   CallIOPRoutine
.DontCallIOP:
            jmp     (A3)
DiskIODone:
            move.l  JIODone,-(SP)
            movea.l (-4,A1),A1
            ext.l   D0
            beq.b   .noError
            move.w  D0,DskErr
.noError:
            rts
IopCtlKillIO:
            moveq   #ControlErr,D0
            bra.b   DiskIODone
IopCtlFormat:
            lea     (-$42,A1),A2
            clr.w   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            bsr.w   CallIOPRoutine
            bsr.w   UpdateXmtDriveStatus
IopCtlDone:
            move.w  (-$46,A1),D0
            bra.b   DiskIODone
IopCtlPhysIcon:
            bsr.w   UpdateXmtDriveStatus
            movea.l (-$C,A1),A3
            btst    #3,(-$38,A1)
            beq.b   .gotDefault
            movea.l (-$10,A1),A3
.gotDefault:
            move.w  #1,(-$40,A1)
            btst    #1,(-$2A,A1)
            bra.b   IconCommon
IopCtlLogIcon:
            bsr.w   UpdateXmtDriveStatus
            movea.l (-8,A1),A3
            clr.w   (-$40,A1)
            btst    #0,(-$2A,A1)
IconCommon:
            bne.b   .callForIcon
            move.l  A3,(A0)
            bra.b   DiskIODone
.callForIcon:
            lea     (-$274,A1),A3
            move.l  A3,(A0)
            move.l  A3,(-$44,A1)
            move.w  #$120,(-$3C,A1)
            move.b  #$F,(-$48,A1)
            bsr.w   CallIOPRoutine
            bra.b   IopCtlDone
IopCtlDrvInfo:
            bsr.w   UpdateXmtDriveStatus
            move.l  ($E,A2),(A0)
            bra.w   DiskIODone
IopCtlFmtCopy:
            lea     (-$42,A1),A2
            move.b  ($26,A0),(A2)+
            clr.b   (A2)+
            move.l  ($1E,A0),(A2)+
            move.l  ($22,A0),(A2)+
            bsr.w   CallIOPRoutine
            bsr.w   UpdateXmtDriveStatus
            move.w  (-$46,A1),D0
            bne.b   .done
            tst.b   ($B,A0)
            beq.b   .done
            move.l  (-$2E,A1),(-$3C,A1)
            move.b  #$C,(-$48,A1)
            move.l  (2,A0),(-$44,A1)
            clr.l   (-$40,A1)
            bsr.w   CallIOPRoutine
            move.w  (-$46,A1),(-$276,A1)
            move.b  #6,(-$48,A1)
            bsr.w   CallIOPRoutine
            move.w  (-$276,A1),D0
            bne.b   .done
            moveq   #0,D1
            move.b  (-$47,A1),D1
            movea.l (0,A1,D1.w*4),A2
            moveq   #-$44,D0
            move.w  ($12,A2),D1
            cmp.w   (-$3C,A1),D1
            bne.b   .done
            moveq   #0,D0
.done:
            bra.b   ToDiskIODone
IopCtlGetRawData:
            lea     (-$44,A1),A2
            lea     ($1C,A0),A0
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            clr.l   (A0)+
            move.l  (A0)+,(A2)+
            move.w  (A0)+,(A2)+
            bsr.w   CallIOPRoutine
            move.w  (-$46,A1),D0
            bne.b   ToDiskIODone
            move.l  (-$3C,A1),($28,A0)
ToDiskIODone:
            bra.w   DiskIODone
IopGetFormatList:
            bsr.w   UpdateXmtDriveStatus
            moveq   #-$41,D0
            cmpi.b  #2,(7,A2)
            blt.b   ToDiskIODone
            moveq   #-$32,D0
            move.w  (A0)+,D2
            ble.b   ToDiskIODone
            move.w  ($18,A2),D0
            move.w  ($16,A2),D1
            movea.l (A0),A2
            lea     IopDiskFmtTbl,A3
            clr.w   -(A0)
            moveq   #0,D3
.loop:
            bclr    D3,D0
            beq.b   .L17
            move.l  (0,A3,D3.w*8),(A2)+
            move.l  (4,A3,D3.w*8),(A2)+
            bclr    D3,D1
            beq.b   .currentDone
            bset    #6,(-4,A2)
            tst.w   D3
            bne.b   .currentDone
            move.l  (-$2E,A1),(-8,A2)
.currentDone:
            addq.w  #1,(A0)
            subq.w  #1,D2
            ble.b   .L18
.L17:
            addq.w  #1,D3
            tst.w   D0
            bne.b   .loop
.L18:
            moveq   #0,D0
            bra.b   ToDiskIODone
IopDriveStatus:
            bsr.b   UpdateXmtDriveStatus
            addq.l  #4,A2
            addq.l  #4,A3
            move.w  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A3)+,(A0)+
            move.l  (A3)+,(A0)+
            move.l  (A3)+,(A0)+
            move.l  (A2)+,(A0)+
            bra.b   ToDiskIODone
IopMFMStatus:
            bsr.b   UpdateXmtDriveStatus
            move.l  ($12,A2),(A0)
            bra.b   ToDiskIODone
IopDupVersion:
            move.w  (-$44,A1),($1C,A0)
            bra.w   IopCtlDone
IopGetFmtByte:
            move.b  (-$42,A1),($1C,A0)
            bra.w   IopCtlDone
UpdateXmtDriveStatus:
            lea     (-$48,A1),A2
UpdateDriveStatus:
            moveq   #0,D1
            move.b  (1,A2),D1
            lea     nullPerDriveInfo,A3
            move.l  (0,A1,D1.w*4),D2
            beq.b   .done
            movea.l D2,A3
            move.l  (6,A2),(A3)
            move.l  ($A,A2),($10,A3)
            cmpi.w  #1,(8,A3)
            bne.b   .done
            move.l  ($1A,A2),D3
            swap    D3
            move.l  D3,($10,A3)
.done:
            movea.l (-4,A1),A0
            movea.l (8,A0),A0
            lea     ($1C,A0),A0
            moveq   #0,D0
            rts
IopDiskFmtTbl:
            dc.b    $00,$00,$98,$35,$40
            ds.b    5
            dc.w    $0320,$810A,$0050,0,$0640,$820A,$0050,0
            dc.w    $05A0,$8209,$0050,0,$0B40,$9212,$0050
nullPerDriveInfo:
            ds.b    20
CallIOPRoutine:
            move.l  (SP)+,(-$4C,A1)
            lea     (-$28,A1),A0
            _IOPMsgRequest
            rts
IOPCallReturned:
            lea     ($28,A0),A1
            move.l  (-$4C,A1),-(SP)
            clr.l   (-$4C,A1)
            movea.l (-4,A1),A2
            movea.l (8,A2),A0
            rts
ReceivedCallFromIop:
            lea     ($64,A0),A1
            lea     (-$84,A1),A2
            clr.w   (2,A2)
            move.b  (A2),D2
            bsr.w   sub_4087116A
            beq.b   .postEvent
            nop
            moveq   #-1,D0
            cmpi.b  #2,D2
            bne.b   .updateStatus
.postEvent:
            movea.w #7,A0
            clr.w   D0
            move.b  (1,A2),D0
            _PostEvent
            move.w  D0,(2,A2)
            bne.b   .sendReply
.updateStatus:
            bsr.w   UpdateDriveStatus
.sendReply:
            lea     (-$64,A1),A0
            move.b  #1,(7,A0)
            _IOPMsgRequest
            rts
            dc.b    'GaryGaryGaryGaryGary'
.L4:
            moveq   #-$18,D0
            rts
.L5:
            dc.w    $0E0E,$04B8,$17AA,$189A,$1AFE,$0AD8,$1764,$0C08
            dc.w    $01DE,$0B90,$0758,$0E00,$0A2C,$0180,$1C48,$0D40
            dc.w    $3440,$3A0C,$2444,$2506,$25DC
.L6:
            dc.w    $0800,$0200,$4000,$0800,0,$012C,$05DC,$0FA0
            dc.w    $0005,$0078,$0064,$001E,$1D4C,0,$3840,$FC00
sub_4086CA2A:
            moveq   #0,D2
            move.w  (A0)+,D2
            add.l   D0,D2
            move.l  D2,(A1)+
            dbra    D1,sub_4086CA2A
            rts
.L1:
            move.l  #$336,D0
            _NewPtrSysClear
            move.l  A0,SonyVars
            move.l  A1,(A0)
            movea.l UTableBase,A2
            move.l  ($10,A2),(4,A2)
            move.b  #2,(7,A1)
            bsr.w   sub_4087087E
            bsr.w   sub_4086E0AA
            move.l  A2,($134,A0)
            movea.l A0,A2
            lea     ReceivedCallFromIop.L5,A0
            lea     DiskVars,A1
            moveq   #$E,D1
            move.l  A0,D0
            bsr.b   sub_4086CA2A
            lea     jDiskSel,A1
            moveq   #2,D1
            bsr.b   sub_4086CA2A
            moveq   #2,D1
            lea     ($680).w,A1
            bsr.b   sub_4086CA2A
            st      ($18,A2)
            lea     ($2A,A2),A1
            lea     ReceivedCallFromIop.L6,A0
            moveq   #$20,D0
            _BlockMove
            lea     (4,A2),A0
            move.w  #1,(4,A0)
            lea     sub_4086D7FA,A1
            move.l  A1,(6,A0)
            move.w  #$1E,($A,A0)
            _VInstall
            bsr.w   sub_40870886
            nop
            bsr.w   Check4SWIM
            move.w  #5,($12,A1)
            bsr.w   sub_4086D716
            bsr.w   sub_4086D492
            spl     ($FC,A1)
            moveq   #1,D2
            move.l  D2,D5
.L2:
            move.w  D2,($12,A1)
            bsr.w   GetDrive
            st      (4,A1,D1.w)
            cmpi.w  #3,D2
            ble.b   .L3
            tst.b   ($FC,A1)
            bmi.w   .L7
.L3:
            bsr.w   sub_4086D716
            cmpi.w  #3,D2
            blt.b   .L4
            move.w  ($12,A1),D5
            bsr.w   sub_4086D492
            bmi.b   .L7
            move.w  #1,($A,A1,D1.w)
            moveq   #-2,D3
            bra.b   .L6
.L4:
            moveq   #$D,D0
            bsr.w   AdrAndSense
            bmi.b   .L7
            moveq   #9,D0
            bsr.w   AdrAndSense
            smi     (5,A1,D1.w)
            moveq   #$F,D0
            bsr.w   AdrAndSense
            smi     ($13,A1,D1.w)
            moveq   #5,D0
            bsr.w   AdrAndSense
            bpl.b   .L5
            st      ($13,A1,D1.w)
            tst.b   ($138,A1)
            bpl.b   .L5
            st      ($16,A1,D1.w)
            st      ($FD,A1)
.L5:
            moveq   #-5,D3
.L6:
            move.w  D2,D0
            move.b  #1,(4,A1,D1.w)
            swap    D0
            move.w  D3,D0
            lea     (6,A1,D1.w),A0
            _AddDrive
            addq.w  #1,D5
.L7:
            addq.w  #1,D2
            cmpi.w  #4,D2
            ble.w   .L2
            bsr.w   sub_408708AE
            moveq   #0,D0
            rts
.L8:
            moveq   #-$11,D0
.L9:
            tst.w   D0
            beq.b   .L10
            move.w  D0,DskErr
.L10:
            movea.l SonyVars,A1
            bra.w   sub_408708AE.L1
.L11:
            dc.w    $0001,$0082,$0082,$0005,$0090,$01D6,$0006,$0088
            dc.w    $01CE,$0007,$0112,$01DE,$0008,$0098,$0098,$0009
            dc.w    $00A4,$00A4,$0015,$14E2,$38E6,$0016,$14CA,$38E6
            dc.w    $0017,$14FC,$14FC,$5343,$280E,$0082,$4744,$39B0
            dc.w    $0082,0
            move.l  ($242).w,-(SP)                  ; DiskControl: JControl
            rts
            bsr.w   CkDrvNum
            bne.b   .L12
            tst.b   (4,A1,D1.w)
            bpl.b   .L12
            moveq   #-$40,D0
.L12:
            lea     .L11,A3
            movea.l A3,A4
.L13:
            move.w  (A3)+,D2
            beq.b   .L16
            cmp.w   ($1A,A0),D2
            bne.b   .L15
            cmpi.w  #3,($12,A1)
            blt.b   .L14
            addq.w  #2,A3
.L14:
            adda.w  (A3),A4
            tst.w   D0
            jmp     (A4)
.L15:
            addq.w  #4,A3
            bra.b   .L13
.L16:
            moveq   #-$11,D0
            bra.w   .L9
            moveq   #-1,D0
            bra.w   .L9
            bne.w   .L9
            bra.w   WrData.L26
            bne.w   .L9
            bra.w   CtlVerify
            move.l  ($1C,A0),($F4,A1)
            moveq   #0,D0
            bra.w   .L9
            lea     ($1C,A0),A0
            move.b  (A0)+,D1
            move.b  (A0)+,D0
            beq.b   .L19
            bpl.b   .L17
            bsr.b   TCdispose
            bra.b   .L19
.L17:
            tst.l   ($10A,A1)
            bne.b   .L19
            cmpi.w  #2,MemTop
            ble.b   .L19
            move.l  #$1890,D0
            tst.b   ($FD,A1)
            bpl.b   .L18
            move.l  #$24D8,D0
.L18:
            _NewPtrSysClear
            bne.b   .L19
            move.l  A0,($10A,A1)
            clr.w   ($102,A1)
.L19:
            tst.l   ($10A,A1)
            sne     ($101,A1)
            beq.b   .L20
            tst.b   D1
            sne     ($101,A1)
.L20:
            moveq   #0,D0
            bra.w   .L9
TCdispose:
            clr.l   -(SP)
            move.l  ($10A,A1),D0
            beq.b   .L1
            movea.l D0,A0
            _GetPtrSize
            move.l  D0,(SP)
            _DisposPtr
            clr.l   ($10A,A1)
            clr.b   ($101,A1)
.L1:
            move.l  (SP)+,D0
            rts
            bne.w   sub_4086CA2A.L9
            bsr.w   sub_408708C0
            ble.b   .L3
            bsr.w   PowerUp
            moveq   #$28,D6
            bsr.w   sub_4086D4AE
            bgt.b   .L3
            beq.b   .L2
            bsr.w   Recal
            bmi.b   .L3
.L2:
            moveq   #$4F,D6
            bsr.w   sub_4086D4AE
.L3:
            bsr.w   sub_4086D6AC
            moveq   #0,D0
            bsr.w   PowerDown
            bsr.w   sub_4086D716
            moveq   #2,D0
            bsr.w   AdrAndSense
            bpl.b   .L4
            moveq   #0,D0
            bsr.w   PowerDown
            bra.b   .L12
.L4:
            move.w  #$7D0,D0
            bsr.w   WakeUp_SonyRWT
            moveq   #$D,D0
            bsr.w   AdrDisk
            tst.b   ($139,A1)
            bpl.b   .L5
            move.b  #$FF,($800,A0)
            bra.b   .L6
.L5:
            tst.b   ($E00,A0)
.L6:
            tst.b   ($13,A1,D1.w)
            bmi.b   .L8
            move.w  ($42,A1),D0
            bsr.w   WakeUp_SonyRWT
            tst.b   ($139,A1)
            bpl.b   .L7
            move.b  #$F7,($800,A0)
            bra.b   .L12
.L7:
            tst.b   ($C00,A0)
            bra.b   .L12
.L8:
            tst.b   ($139,A1)
            bpl.b   .L9
            move.b  #$F7,($800,A0)
            bra.b   .L10
.L9:
            tst.b   ($C00,A0)
.L10:
            moveq   #$F,D3
.L11:
            move.w  #$3E8,D0
            bsr.w   WakeUp_SonyRWT
            moveq   #2,D0
            bsr.w   AdrAndSense
            dbmi    D3,.L11
            moveq   #$A,D0
            bsr.w   WakeUp_SonyRWT
.L12:
            move.b  ($48,A1),(3,A1,D1.w)
            moveq   #0,D0
            bra.w   sub_4086CA2A.L9
            bne.w   sub_4086CA2A.L9
            bra.w   sub_40870474.L1
            bne.w   sub_4086CA2A.L9
            bra.w   sub_40870474
            bne.w   sub_4086CA2A.L9
            clr.b   (3,A1,D1.w)
            moveq   #0,D0
            bra.w   sub_4086CA2A.L9
StatusTbl:
            dc.w    $0006,$0050,$0008,$0044,$000A,$00FA,$4456,$260E
            dc.w    $5343,$2618,0
DiskStatus:
            moveq   #StatusErr,D0
            lea     StatusTbl,A3
            movea.l A3,A4
            bra.b   .L16
.L15:
            addq.w  #2,A3
.L16:
            move.w  (A3)+,D2
            beq.b   .L17
            cmp.w   ($1A,A0),D2
            bne.b   .L15
            bsr.w   CkDrvNum
            bne.b   .L17
            moveq   #-$40,D0
            tst.b   (4,A1,D1.w)
            lea     ($1C,A0),A0
            adda.w  (A3),A4
            jsr     (A4)
.L17:
            bra.w   sub_4086CA2A.L9
DriveStatus:
            moveq   #$B,D0
            adda.w  D1,A1
.L18:
            move.w  (A1)+,(A0)+
            subq.w  #1,D0
            bgt.b   .L18
            rts
PassportSts:
            ble.b   .L19
            moveq   #-$41,D0
            cmpi.b  #2,(3,A1,D1.w)
            blt.b   .L19
            moveq   #-$32,D0
            move.w  (A0),D2
.L19:
            ble.b   .L26
            cmpi.w  #3,($12,A1)
            blt.b   .L20
            move.l  ($12,A1,D1.w),D0
            swap    D0
            move.w  #1,(A0)+
            movea.l (A0),A0
            move.l  D0,(A0)+
            move.l  #$40000000,(A0)+
            bra.b   .L25
.L20:
            lea     diskFmtTbl,A2
            moveq   #1,D3
            moveq   #0,D0
            tst.b   (5,A1,D1.w)
            bpl.b   .L21
            move.b  ($12,A1,D1.w),D0
            neg.b   D0
            moveq   #2,D3
            tst.b   ($16,A1,D1.w)
            bpl.b   .L21
            moveq   #3,D3
            tst.b   ($17,A1,D1.w)
            bpl.b   .L21
            moveq   #2,D0
            tst.b   ($18,A1,D1.w)
            bpl.b   .L21
            lea     diskFmtTbl.L28,A2
            moveq   #0,D0
            moveq   #1,D3
.L21:
            cmp.w   D3,D2
            ble.b   .L22
            move.w  D3,D2
.L22:
            move.w  D2,(A0)+
            subq.w  #1,D2
            move.w  D2,D3
            sub.w   D0,D3
            movea.l (A0),A0
.L23:
            move.l  (A2)+,(A0)+
            move.l  (A2)+,D0
            cmp.w   D2,D3
            bne.b   .L24
            bset    #$1E,D0
.L24:
            move.l  D0,(A0)+
            dbra    D2,.L23
.L25:
            moveq   #0,D0
.L26:
            rts
diskFmtTbl:
            dc.w    0,$0320,$810A,$0050,0,$0640,$820A,$0050
            dc.w    0,$05A0,$8209,$0050
.L28:
            dc.w    0,$0B40,$9212,$0050,$2031,$1016,$1029,$0138
            dc.w    $2080,$7000,$4E75
CkDrvNum:
            movea.l SonyVars,A1
            st      ($19,A1)
            move.w  ($16,A0),D0
            beq.b   .L1
            cmpi.w  #4,D0
            bhi.b   .L1
            move.w  ($12,A1),($112,A1)
            move.w  D0,($12,A1)
            bsr.w   GetDrv1
            moveq   #0,D0
            rts
.L1:
            moveq   #NSDrvErr,D0
            rts
            move.l  ($226).w,-(SP)
            rts
            ori     #$100,SR
            move.w  (6,A0),D3
            btst    #6,($2D,A0)
            sne     DskVerify
            bsr.b   CkDrvNum
            bne.w   DskRWOff.L9
            move.w  D3,($32,A1)
            moveq   #-$40,D0
            tst.b   (4,A1,D1.w)
            bsr.w   sub_408707FE
            tst.b   ($138,A1)
            bpl.b   .L2
            bsr.w   SetChipMode
.L2:
            bsr.w   sub_4086D716
            cmpi.w  #3,($12,A1)
            bge.w   mDoFormat.L50
            moveq   #2,D0
            bsr.w   AdrAndSense
            bpl.b   .L3
            clr.b   (3,A1,D1.w)
            move.b  #$80,($C00,A0)
            tst.b   ($1000,A0)
            moveq   #-$41,D0
            bra.b   DskRWOff.L9
.L3:
            cmpi.b  #2,(3,A1,D1.w)
            beq.b   .L5
            clr.b   ($17,A1,D1.w)
            tst.b   ($138,A1)
            bpl.b   .L4
            bsr.w   SetChipMode
.L4:
            bsr.w   sub_4086D6BC
            bsr.w   Recal
            bmi.b   DskRWOff.L7
            bsr.w   MakeSpdTbl
            bne.b   DskRWOff.L7
            moveq   #6,D0
            bsr.w   AdrAndSense
            spl     (2,A1,D1.w)
            clr.b   ($12,A1,D1.w)
            move.b  #2,(3,A1,D1.w)
            bra.w   NotSWIM2.L8
.L5:
            bsr.w   CheckRead
            beq.b   DskRWOff.L10
            move.w  BufTgFBkNum,($26,A1)
            tst.b   (2,A1,D1.w)
            bpl.b   DskRWOff.L10
            moveq   #-$2C,D0
DskRWOff:
            move.w  ($3A,A1),D2
            bra.b   .L8
.L7:
            moveq   #0,D2
.L8:
            move.w  D0,-(SP)
            move.w  D2,D0
            bsr.w   PowerDown
            move.w  (SP)+,D0
.L9:
            andi    #$F8FF,SR
            bra.w   sub_4086CA2A.L9
.L10:
            move.w  (0,A1,D1.w),D6
            bsr.w   PowerUp
GetTrack:
            movea.l (A1),A2
            movea.l (8,A2),A0
            move.l  ($10,A2),D0
            moveq   #9,D7
            lsr.l   D7,D0
            tst.b   ($17,A1,D1.w)
            bmi.w   mPulse.L15
            moveq   #0,D4
            tst.b   ($12,A1,D1.w)
            beq.b   .L12
            moveq   #1,D4
.L12:
            moveq   #$64,D2
            lsl.w   #3,D2
            lsl.w   D4,D2
            cmp.l   D2,D0
            blt.b   .L15
.L13:
            moveq   #-$32,D0
.L14:
            bra.b   DskRWOff
.L15:
            moveq   #7,D3
            lsl.w   #4,D3
            lsl.w   D4,D3
            moveq   #$10,D5
            lsl.w   D4,D5
.L16:
            add.w   D5,D3
            sub.l   D3,D2
            cmp.l   D2,D0
            blt.b   .L16
            lsr.w   #4,D3
            moveq   #-1,D5
.L17:
            add.w   D3,D2
            addq.w  #1,D5
            cmp.w   D2,D0
            bge.b   .L17
            lsr.w   D4,D3
            moveq   #$C,D6
            sub.w   D3,D6
            lsl.w   #4,D6
            add.w   D6,D5
            move.l  D4,D6
            sub.w   D3,D2
            cmp.l   D2,D0
            bge.b   .L18
            sub.w   D3,D2
            moveq   #0,D6
.L18:
            tst.b   D6
            beq.b   .L19
            bset    #$B,D5
            tst.b   (5,A1,D1.w)
            bne.b   .L19
            moveq   #-$4E,D0
            bra.b   .L14
.L19:
            move.w  D5,($16,A1)
            sub.w   D2,D0
            sub.w   D0,D3
            move.w  D0,($20,A1)
            move.l  ($24,A0),D5
            move.l  ($28,A0),D2
            sub.l   D2,D5
            lsr.l   D7,D5
            beq.b   .L13
            cmp.w   D5,D3
            slt     D6
            ble.b   .L20
            move.w  D5,D3
.L20:
            moveq   #0,D5
            move.w  D0,D4
            move.w  D3,-(SP)
.L21:
            bset    D0,D5
            addq.w  #1,D0
            subq.w  #1,D3
            bne.b   .L21
            move.w  (SP)+,D3
            move.l  D5,($22,A1)
            movea.l ($20,A0),A3
            adda.l  D2,A3
            move.l  A3,($1C,A1)
            lsr.l   D7,D2
            move.w  D2,($28,A1)
            move.b  ($2C,A1),($2D,A1)
            clr.b   ($100,A1)
            bsr.w   CheckRead
            beq.b   .L23
            bsr.w   CacheValid
            bne.b   .L22
            move.l  D5,D0
            not.l   D0
            and.l   D0,($106,A1)
.L22:
            bra.w   ReSeek
.L23:
            tst.b   DskVerify
            bne.b   .L22
            bsr.w   CacheValid
            bne.w   .L30
            move.l  D5,D2
            and.l   ($106,A1),D2
            beq.w   .L29
            moveq   #2,D7
            asl.l   #8,D7
            move.w  D4,D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L24
            subq.w  #1,D0
.L24:
            mulu.w  #$20C,D0
            movea.l ($10A,A1),A4
            adda.w  D0,A4
.L25:
            btst    D4,D2
            beq.b   .L28
            bclr    D4,D5
            movem.l A0-A1,-(SP)
            tst.l   ($F4,A1)
            beq.b   .L26
            move.w  D4,D0
            sub.w   ($20,A1),D0
            add.w   ($28,A1),D0
            mulu.w  #$C,D0
            movea.l ($F4,A1),A1
            adda.l  D0,A1
            bra.b   .L27
.L26:
            lea     BufTgFNum,A1
.L27:
            movea.l A4,A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l A3,A1
            move.l  D7,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            addq.w  #1,($110,A1)
            add.l   D7,($10,A2)
            add.l   D7,($28,A0)
.L28:
            adda.l  D7,A3
            adda.l  D7,A4
            lea     ($C,A4),A4
            addq.w  #1,D4
            subq.w  #1,D3
            bne.b   .L25
            move.l  D5,($22,A1)
            bne.b   .L29
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.w   GetTrack
            moveq   #0,D0
            bra.w   DskRWOff
.L29:
            bsr.b   TCRdEnbChk
            bra.b   ReSeek
.L30:
            bsr.b   TCRdEnbChk
            bne.b   ReSeek
            move.w  ($12,A1),($102,A1)
            move.w  ($16,A1),($104,A1)
            clr.l   ($106,A1)
            bra.b   ReSeek
TCRdEnbChk:
            tst.b   ($101,A1)
            beq.b   .L2
            btst    #$A,($32,A1)
            bne.b   .L1
            tst.b   D6
.L1:
            seq     ($100,A1)
            rts
.L2:
            moveq   #1,D6
            bra.b   .L1
CacheValid:
            tst.b   ($101,A1)
            beq.b   .L1
            move.w  ($102,A1),D0
            beq.b   .L1
            cmp.w   ($12,A1),D0
            bne.b   .L1
            move.w  ($16,A1),D0
            sub.w   ($104,A1),D0
            beq.b   .L2
.L1:
            moveq   #-1,D0
.L2:
            rts
ReSeek:
            move.l  ($24A).w,-(SP)
            rts
            move.b  ($30,A1),($31,A1)
            move.w  ($16,A1),D6
            bsr.w   sub_4086D4AE
            bmi.b   .L4
            move.b  ($2A,A1),($2B,A1)
            bra.b   OnTrack
.L4:
            bra.w   DoRecal
OnTrack:
            move.b  ($2E,A1),($2F,A1)
OnTrack1:
            move.w  D1,D6
            bsr.w   RdAddrSetup
            bmi.w   AdrDtaErr
            cmp.w   ($16,A1),D1
            bne.w   WrgSideTrk
            move.b  D3,($14C,A1)
            move.w  D2,($FE,A1)
            move.w  D2,TagData
            move.l  ($22,A1),D0
            btst    D2,D0
            bne.w   OTSetUp
            tst.b   ($100,A1)
            beq.w   WrgSectAdr
            move.l  ($106,A1),D0
            btst    D2,D0
            bne.w   WrgSectAdr
            lea     sub_4086E27A,A0
            cmpa.l  ($22E).w,A0
            sne     ($100,A1)
            bne.w   WrgSectAdr
            move.w  D2,D1
            tst.b   ($17,A1,D6.w)
            bpl.b   .L7
            subq.w  #1,D2
.L7:
            mulu.w  #$20C,D2
            movea.l ($10A,A1),A0
            adda.l  D2,A0
            lea     ($C,A0),A0
            bsr.w   RdData
            bsr.w   GetDrv1
            move.w  D1,D6
            tst.w   D0
            spl     ($100,A1)
            bmi.b   .L9
            addq.w  #1,($10E,A1)
            move.w  ($FE,A1),D2
            movea.l ($10A,A1),A0
            move.w  D2,D1
            tst.b   ($17,A1,D6.w)
            bpl.b   .L8
            subq.w  #1,D1
.L8:
            mulu.w  #$20C,D1
            adda.l  D1,A0
            lea     BufTgFNum,A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  ($106,A1),D4
            bset    D2,D4
            move.l  D4,($106,A1)
.L9:
            bset    #7,($15F).w
            bne.b   .L11
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D6.w)
            bpl.b   .L10
            moveq   #$4B,D0
.L10:
            bsr.w   WakeSetUp
            bsr.w   EmptyPD
            bsr.w   WakeGo
            bra.b   .L12
.L11:
            bsr.w   EmptyPD
            andi    #$F8FF,SR
.L12:
            bra.w   OnTrack
OTSetUp:
            cmpi.b  #$1F,D3
            sgt     ($12,A1,D6.w)
            sub.w   ($20,A1),D2
            move.w  D2,D1
            asl.l   #8,D1
            add.l   D1,D1
            add.l   ($1C,A1),D1
            movea.l D1,A0
            move.w  ($28,A1),D1
            add.w   D2,D1
            move.w  D1,D0
            add.w   D1,D1
            add.w   D0,D1
            asl.w   #2,D1
            move.w  D1,($F8,A1)
            bsr.w   CheckRead
            beq.b   OTRead
            move.l  ($F4,A1),D3
            beq.b   .L14
            movea.l D3,A1
            adda.w  D1,A1
            lea     BufTgFNum,A2
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            bra.b   .L15
.L14:
            add.w   ($26,A1),D0
            move.w  D0,BufTgFBkNum
.L15:
            bsr.w   WrData
            bmi.w   AdrDtaErr
            bra.b   GotSect
OTRead:
            bsr.w   RdData
            bmi.w   AdrDtaErr
            movea.l SonyVars,A1
            move.l  ($F4,A1),D0
            beq.b   GotSect
            movea.l D0,A0
            adda.w  ($F8,A1),A0
            lea     BufTgFNum,A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
GotSect:
            bsr.w   GetDrv1
            move.l  ($22,A1),D4
            move.w  ($FE,A1),D2
            bclr    D2,D4
            move.l  D4,($22,A1)
            movea.l (A1),A2
            movea.l (8,A2),A0
            moveq   #2,D3
            asl.l   #8,D3
            add.l   D3,($10,A2)
            add.l   D3,($28,A0)
            move.l  ($24,A0),D3
            sub.l   ($28,A0),D3
            bset    #7,($15F).w
            beq.b   .L19
            bsr.b   CheckRead
            beq.b   .L21
            tst.l   D4
            bne.b   .L18
            bsr.b   EmptyPD
            moveq   #7,D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L22
.L18:
            tst.b   ($13,A1,D1.w)
            bmi.b   .L21
.L19:
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L20
            moveq   #$4B,D0
.L20:
            bsr.w   WakeSetUp
            bsr.b   EmptyPD
            bsr.w   WakeGo
            bra.b   .L22
.L21:
            bsr.b   EmptyPD
            andi    #$F8FF,SR
.L22:
            move.l  D4,D0
            bne.w   OnTrack
            tst.l   D3
            bgt.w   GetTrack
            tst.b   ($12,A1,D1.w)
            beq.b   ToDskRWOff
            tst.b   (5,A1,D1.w)
            bne.b   ToDskRWOff
            moveq   #-$4E,D0
ToDskRWOff:
            bra.w   DskRWOff
CheckRead:
            cmpi.b  #2,($33,A1)
            rts
EmptyPD:
            movea.l (SP)+,A4
            pea     .L2
            move.l  PollProc,-(SP)
            beq.b   .L1
            movea.l SonyVars,A1
            movem.l D0/D2-D3/A0/A4,($D0,A1)
            rts
.L2:
            bsr.w   GetDrv1
            movem.l ($D0,A1),D0/D2-D3/A0/A4
            jmp     (A4)
.L1:
            movea.l PollStack,SP
            bsr.w   GetDrv1
            jmp     (A4)
AdrDtaErr:
            bsr.b   EmptyPD
            andi    #$F8FF,SR
            addq.w  #1,($FA,A1)
            addq.w  #1,($14,A1,D1.w)
            tst.b   ($2D,A1)
            beq.b   .L1
            bsr.b   CheckRead
            bne.b   DoRecal
.L1:
            subq.b  #1,($2B,A1)
            bpl.w   OnTrack
            bra.b   DoRecal
WrgSectAdr:
            movea.l SonyVars,A1
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D6.w)
            bpl.b   .L5
            moveq   #$4B,D0
.L5:
            bsr.w   WakeSetUp
            bsr.b   EmptyPD
            bsr.w   WakeGo
            addq.l  #1,RndSeed
            moveq   #-$51,D0
            subq.b  #1,($2F,A1)
            bmi.b   DoRecal
            bra.w   OnTrack1
WrgSideTrk:
            bsr.b   EmptyPD
            moveq   #-$50,D0
DoRecal:
            andi    #$F8FF,SR
            subq.b  #1,($2D,A1)
            ble.b   .L8
            bsr.w   Recal
            bmi.b   .L8
            bsr.w   MakeSpdTbl
            bpl.w   ReSeek
.L8:
            bra.w   ToDskRWOff
            dc.w    $004A,$008C,$014E,$016A,$2078,$01E0,$2478,$01D4
            dc.w    $6116,$323B,$10EA,$4E75
GetDrive:
            movea.l IWM,A0
            movea.l VIA,A2
GetDrv1:
            bsr.b   GetDrv2
            move.w  DoRecal.L8+2(PC,D1.w),D1
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
            move.w  #$1F40,D0
            bra.w   WakeUp_SonyRWT
            move.l  DiskVars,-(SP)
            rts
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
.L2:
            dc.w    $0048,$034E,$0003,$0048,$024C,$0803,$0048,$0048
            dc.w    $0507,$0048,$0048,$0D07,$0030,$053A,$0003,$0030
            dc.w    $063C,$0103,$0030,$0030,$0507,$0030,$0030,$0D07
            dc.w    $0018,$0420,$0003,$0018,$011A,$0103,$0018,$0018
            dc.w    $0507,$0018,$0018,$0D07,$7FFF,$FFF8,$8100,$0104
            dc.w    $8100,$7102,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$8901,$8100,$8901,$8100,$7101,$8100,$0101
            dc.w    $80FF,$FE01,$8000,$0001,$8000,$0001,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$8000,$0001,$8000,$0001
            dc.w    $87FF,$FFE1,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$7FFF,$FFFE,$7FFF,$FFF8,$FFFF,$FFFC
            dc.w    $FFFF,$FFFE,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$7FFF,$FFFE
            ds.b    26
            dc.w    $7FFF,$8000,$8000,$4000,$9FFE,$4000,$A001,$4000
            dc.w    $A001,$4000,$A001,$4000,$A001,$4000,$A001,$4000
            dc.w    $A001,$4040,$A001,$4040,$A001,$4040,$9FFE,$4040
            dc.w    $8000,$41F0,$8000,$40E0,$8000,$4040,$80FE,$4000
            dc.w    $8000,$5FFF,$8000,$5001,$8000,$5001,$8000,$53F9
            dc.w    $7FFF,$9001,$4000,$9001,$7FFF,$9FFF
            ds.b    36
            dc.w    $7FFF,$8000,$FFFF,$C000,$FFFF,$C000,$FFFF,$C000
            dc.w    $FFFF,$C000,$FFFF,$C000,$FFFF,$C000,$FFFF,$C000
            dc.w    $FFFF,$C000,$FFFF,$C000,$FFFF,$C000,$FFFF,$C000
            dc.w    $FFFF,$C000,$FFFF,$C000,$FFFF,$C000,$FFFF,$C000
            dc.w    $FFFF,$DFFF,$FFFF,$DFFF,$FFFF,$DFFF,$FFFF,$DFFF
            dc.w    $7FFF,$9FFF,$7FFF,$9FFF,$7FFF,$9FFF
            ds.b    58
            dc.w    $FFFF,$FFFF,$8000,$0001,$8000,$0001,$903F,$C7F9
            dc.w    $8000,$0001,$8004,$0001,$800E,$0001,$801F,$0001
            dc.w    $8004,$0001,$8004,$0001,$8004,$0001,$8000,$0001
            dc.w    $FFFF,$FFFF
            ds.b    76
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF
            ds.b    78
            dc.w    $FFFF,$FFFF,$8000,$0001,$8000,$0001,$903F,$C7F9
            dc.w    $8000,$0001,$8000,$0081,$8000,$01C1,$8000,$03E1
            dc.w    $8000,$0081,$8000,$0081,$8000,$0081,$8000,$0001
            dc.w    $FFFF,$FFFF
            ds.b    76
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF
            ds.b    38
            dc.w    $07FF,$FFE0,$0800,$0010,$0800,$0010,$08FF,$FF10
            dc.w    $0900,$0090,$0955,$5090,$0900,$0090,$0955,$0090
            dc.w    $0900,$0090,$0950,$0090,$0900,$0090,$0950,$0090
            dc.w    $0900,$0090,$0954,$0090,$0900,$0090,$0900,$0090
            dc.w    $08FF,$FF10,$0800,$0010,$0800,$0010,$0800,$0010
            dc.w    $0810,$0010,$0818,$0010,$08FC,$FF10,$0818,$0010
            dc.w    $0810,$0010,$0800,$0010,$07FF,$FFE0,$0400,$0020
            dc.w    $0400,$0020,$0400,$0020,$03FF,$FFC0
            ds.b    4
            dc.w    $07FF,$FFE0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0,$0FFF,$FFF0,$07FF,$FFE0,$07FF,$FFE0
            dc.w    $07FF,$FFE0,$07FF,$FFE0,$03FF,$FFC0
            ds.b    25
            dc.b    $80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$03
            dc.b    $E0,$00,$00,$01,$C0,$00,$00,$00,$80
            ds.b    4
            dc.w    $FFFF,$FFFF,$8000,$0001,$FFFF,$FFFF,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$FFFF,$FFFF,$8000,$0FF9
            dc.w    $8000,$0001,$8000,$0001,$A000,$0001,$8000,$0001
            dc.w    $FFFF,$FFFF,$8000,$0001,$FFFF,$FFFF
            ds.b    39
            dc.b    $80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$03
            dc.b    $E0,$00,$00,$01,$C0,$00,$00,$00,$80
            ds.b    4
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            ds.b    65
            dc.b    $10,$00,$00,$00,$10,$FF,$FF,$FC,$10,$80,$00,$04,$10,$FF,$FF,$FC
            dc.b    $7C,$80,$00,$04,$38,$FF,$FF,$FC,$10,$80,$01,$F4,$00,$A0,$00,$05
            dc.b    $FF,$80,$00,$05,$01,$FF,$FF,$FD,$7D,$80,$00,$05,$01,$FF,$FF,$FD
            dc.b    $FF
            ds.b    79
            dc.b    $10,$00,$00,$00,$10,$FF,$FF,$FC,$10,$FF,$FF,$FC,$10,$FF,$FF,$FC
            dc.b    $7C,$FF,$FF,$FC,$38,$FF,$FF,$FC,$10,$FF,$FF,$FC,$00,$FF,$FF,$FD
            dc.b    $FF,$FF,$FF,$FD,$FF,$FF,$FF,$FD,$FF,$FF,$FF,$FD,$FF,$FF,$FF,$FD
            dc.b    $FF
            ds.b    34
            dc.w    $6650,$6152,$3013,$2669,$0134,$0880,0,$6704
            dc.w    $47FA,$F898,$6000
            dc.b    $27,'0f8a:0+'
            dc.w    $0002,$2669,$0134,$0880,0,$6704,$47FA,$F87E
            dc.w    $6000,$2716,$661E,$6120,$302B,$0004,$0C69,$0003
            dc.w    $0012,$6C0A,$4A31,$1016,$6A04,$103C,$0004
.L3:
            move.l  D0,($1C,A0)
            moveq   #0,D0
            bra.w   sub_4086CA2A.L9
            move.w  ($12,A1),D0
            subq.w  #1,D0
            add.w   D0,D0
            movea.w D0,A3
            add.w   D0,D0
            add.w   A3,D0
            movea.l ($134,A1),A3
            adda.w  D0,A3
            rts
sub_4086E0AA:
            lea     .L3,A2
.L1:
            addq.w  #4,A2
            move.w  (A2)+,D0
            bmi.b   .L2
            cmp.b   BoxFlag,D0
            bne.b   .L1
            adda.l  (A2),A2
            rts
.L2:
            lea     .L4,A2
.L3:
            adda.l  (A2),A2
            rts
            dc.w    0
.L4:
            dc.w    $FFFF,$F820,$0001,$FFFF,$F81A,$0003,$FFFF,$F844
            dc.w    $0002,$FFFF,$F826,$0005,$FFFF,$F820,$0006,$FFFF
            dc.w    $F802,$0007,$FFFF,$F7FC,$0008,$FFFF,$F80E,$0009
            dc.w    $FFFF,$F820,$0009,$FFFF,$F81A,$000C,0,$288A
            dc.w    $000D,0,$289C,$000E,0,$28AE,$000F,0
            dc.b    $28,$C0,$00,$10,$00,$00,$28,$D2,$FF
            ds.b    23
.L5:
            dc.b    $D5,$AA,$96,$DE,$AA,$FF         ; address marks
SetUpPoll:
            move.l  ($23A).w,-(SP)
            rts
            movea.l SCCRd,A6
            addq.l  #6,A6
            movea.l VIA,A5
            lea     ($1E00,A5),A5
            ori     #$700,SR
            move.l  SP,PollStack
            add.l   D0,PollStack
            rts
RdAddrSetup:
            moveq   #8,D0
            bsr.b   SetUpPoll
            moveq   #1,D0
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
sub_4086E174:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   mPulse.L18
            lea     sub_4086E0AA.L5,A2
            move.l  ($22A).w,-(SP)
            rts
            moveq   #3,D3
            move.w  #$23F,D2
            moveq   #0,D5
            movea.l IWM,A4
            lea     ($1800,A4),A4
            move.l  (SP)+,DskRtnAdr
.L1:
            move.b  (A5),(A5)
            bmi.b   .L2
            move.b  (A6),-(SP)
.L2:
            move.b  (A4),D5
            dbra    D2,.L3
            moveq   #-$42,D0
            bra.w   .L16
.L3:
            bpl.b   .L1
            subq.w  #1,D3
            bne.b   .L1
            move.w  #$5DC,D0
            tst.b   ($13,A1,D1.w)
            beq.b   .L4
            move.w  #$5BC,D0
.L4:
            lea     sub_4086E27A.DNib-$96,A3
.L5:
            movea.l A2,A0
            moveq   #3,D1
.L6:
            move.b  (A4),D5
            bpl.b   .L6
            move.b  (A5),(A5)
            bmi.b   .L7
            move.b  (A6),-(SP)
.L7:
            dbra    D0,.L8
            moveq   #-$43,D0
            bra.b   .L16
.L8:
            cmp.b   (A0)+,D5
            bne.b   .L5
            subq.w  #1,D1
            bne.b   .L6
            move.b  (A5),(A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            move.b  (A4),D5
            bpl.b   .L9
            move.b  (0,A3,D5.w),D1
            move.b  D1,D4
            ror.w   #6,D1
            move.b  (A5),(A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            move.b  (A4),D5
            bpl.b   .L10
            moveq   #0,D2
            move.b  (0,A3,D5.w),D2
            eor.b   D2,D4
            move.b  (A5),(A5)
            bmi.b   .L11
            move.b  (A6),-(SP)
.L11:
            move.b  (A4),D5
            bpl.b   .L11
            move.b  (0,A3,D5.w),D1
            eor.b   D1,D4
            rol.w   #6,D1
            move.b  (A5),(A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D5
            bpl.b   .L12
            move.b  (0,A3,D5.w),D3
            eor.b   D3,D4
            move.b  (A5),(A5)
            bmi.b   .L13
            move.b  (A6),-(SP)
.L13:
            move.b  (A4),D5
            bpl.b   .L13
            move.b  (0,A3,D5.w),D5
            eor.b   D5,D4
            bne.b   .L17
            moveq   #1,D4
.L14:
            move.b  (A5),(A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            move.b  (A4),D5
            bpl.b   .L15
            cmp.b   (A0)+,D5
            bne.b   .L18
            dbra    D4,.L14
.L16:
            bra.w   sub_4086D7F2
.L17:
            moveq   #-$45,D0
            bra.b   .L16
.L18:
            moveq   #-$46,D0
            bra.b   .L16
DtaMks:
            dc.b    $D5,$AA,$AD,$DE,$AA,$FF         ; data marks
RdData:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   sub_4086EEDC
            lea     DtaMks,A1
            move.l  ($22E).w,-(SP)
            rts
sub_4086E27A:
            move.l  (SP)+,DskRtnAdr
            moveq   #$30,D2
            moveq   #0,D3
            moveq   #-$40,D0
            move.l  #$1FE000A,D4
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
.L1:
            movea.l A1,A2
            moveq   #3,D1
.L2:
            move.b  (A4),D3
            bpl.b   .L2
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            dbra    D2,.L4
            moveq   #-$47,D0
            bra.b   sub_4086E174.L16
.L4:
            cmp.b   (A2)+,D3
            bne.b   .L1
            subq.w  #1,D1
            bne.b   .L2
.L5:
            move.b  (A4),D3
            bpl.b   .L5
            lea     ($2FB).w,A1
            move.b  (0,A3,D3.w),(A1)+
.L6:
            tst.b   (A5)
            bmi.b   .L7
            move.b  (A6),-(SP)
.L7:
            move.b  (A4),D3
            bpl.b   .L6
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L8:
            move.b  (A4),D3
            bpl.b   .L8
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            move.b  D2,(A1)+
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L9:
            move.b  (A4),D3
            bpl.b   .L9
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            move.b  D2,(A1)+
            addx.b  D2,D6
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            move.b  (A4),D3
            bpl.b   .L10
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            move.b  D1,(A1)+
            addx.b  D1,D7
            subq.w  #3,D4
            bpl.b   .L6
            swap    D4
            tst.b   DskVerify
            beq.b   .L12
            bra.b   .L17
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D3
            bpl.b   .L11
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L13:
            move.b  (A4),D3
            bpl.b   .L13
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            move.b  D2,(A0)+
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L14:
            move.b  (A4),D3
            bpl.b   .L14
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            move.b  D2,(A0)+
            addx.b  D2,D6
            tst.w   D4
            beq.b   .L23
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            move.b  (A4),D3
            bpl.b   .L15
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            move.b  D1,(A0)+
            addx.b  D1,D7
            subq.w  #3,D4
            bra.b   .L11
.L16:
            tst.b   (A5)
            bmi.b   .L17
            move.b  (A6),-(SP)
.L17:
            move.b  (A4),D3
            bpl.b   .L16
            move.b  (0,A3,D3.w),D1
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L18:
            move.b  (A4),D3
            bpl.b   .L18
            or.b    (0,A3,D3.w),D2
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            eor.b   D7,D2
            cmp.b   (A0)+,D2
            bne.b   .L22
            addx.b  D2,D5
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L19:
            move.b  (A4),D3
            bpl.b   .L19
            or.b    (0,A3,D3.w),D2
            eor.b   D5,D2
            cmp.b   (A0)+,D2
            bne.b   .L29
            addx.b  D2,D6
            tst.w   D4
            beq.b   .L23
            rol.b   #2,D1
            and.b   D0,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            move.b  (A4),D3
            bpl.b   .L21
            or.b    (0,A3,D3.w),D1
            eor.b   D6,D1
            cmp.b   (A0)+,D1
.L22:
            bne.b   .L29
            addx.b  D1,D7
            subq.w  #3,D4
            bra.b   .L16
.L23:
            tst.b   (A5)
            bmi.b   .L24
            move.b  (A6),-(SP)
.L24:
            move.b  (A4),D3
            bpl.b   .L24
            move.b  (0,A3,D3.w),D1
            bmi.b   .L28
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L25:
            move.b  (A4),D3
            bpl.b   .L25
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D2
            cmp.b   D2,D5
            bne.b   .L28
            rol.b   #2,D1
            move.b  D1,D2
            and.b   D0,D2
.L26:
            move.b  (A4),D3
            bpl.b   .L26
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D2
            cmp.b   D2,D6
            bne.b   .L28
            rol.b   #2,D1
            and.b   D0,D1
            tst.b   (A5)
            bmi.b   .L27
            move.b  (A6),-(SP)
.L27:
            move.b  (A4),D3
            bpl.b   .L27
            move.b  (0,A3,D3.w),D3
            bmi.b   .L28
            or.b    D3,D1
            cmp.b   D1,D7
            beq.b   .L30
.L28:
            moveq   #-$48,D0
            bra.b   .L33
.L29:
            moveq   #-$44,D0
            bra.b   .L33
.L30:
            moveq   #1,D4
.L31:
            move.b  (A4),D3
            bpl.b   .L31
            tst.b   (A5)
            bmi.b   .L32
            move.b  (A6),-(SP)
.L32:
            cmp.b   (A2)+,D3
            bne.b   .L34
            dbra    D4,.L31
            moveq   #0,D0
.L33:
            bra.w   sub_4086D7F2
.L34:
            moveq   #-$49,D0
            bra.b   .L33
; Denibblizing table (nibbles $96 thru $FF converted to $00 thru $3F)
.DNib:
            dc.b    $00,$01,$FF,$FF,$02,$03         ; $96,$97,   ,   ,$9A,$9B
            dc.b    $FF,$04,$05,$06,$FF,$FF         ; ,$9D,$9E,$9F,   ,
            dc.b    $FF,$FF,$FF,$FF,$07,$08         ; ,   ,   ,   ,$A6,$A7
            dc.b    $FF,$FF,$FF,$09,$0A,$0B         ; ,   ,   ,$AB,$AC,$AD
            dc.b    $0C,$0D,$FF,$FF,$0E,$0F         ; $AE,$AF,   ,   ,$B2,$B3
            dc.b    $10,$11,$12,$13,$FF,$14         ; $B4,$B5,$B6,$B7,   ,$B9
            dc.b    $15,$16,$17,$18,$19,$1A         ; $BA,$BB,$BC,$BD,$BE,$BF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF         ; ,   ,   ,   ,   ,
            dc.b    $FF,$FF,$FF,$FF,$FF,$1B         ; ,   ,   ,   ,   ,$CB
            dc.b    $FF,$1C,$1D,$1E,$FF,$FF         ; ,$CD,$CE,$CF,
            dc.b    $FF,$1F,$FF,$FF,$20,$21         ; ,$D3,   ,   ,$D6,$D7
            dc.b    $FF,$22,$23,$24,$25,$26         ; ,$D9,$DA,$DB,$DC,$DD
            dc.b    $27,$28,$FF,$FF,$FF,$FF         ; $DE,$DF,
            dc.b    $FF,$29,$2A,$2B,$FF,$2C         ; ,$E5,$E6,$E7,   ,$E9
            dc.b    $2D,$2E,$2F,$30,$31,$32         ; $EA,$EB,$EC,$ED,$EE,$EF
            dc.b    $FF,$FF,$33,$34,$35,$36         ; ,   ,$F2,$F3,$F4,$F5
            dc.b    $37,$38,$FF,$39,$3A,$3B         ; $F6,$F7,   ,$F9,$FA,$FB
            dc.b    $3C,$3D,$3E,$3F                 ; $FC,$FD,$FE,$FF
.L35:
            dc.w    $FF3F,$CFF3,$FCFF,$D5AA
WrData:
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bmi.w   sub_4086EEDC.L17
            lea     sub_4086E27A.L35,A2
            move.l  ($232).w,-(SP)
            rts
            move.l  (SP)+,DskRtnAdr
            lea     ($2FB).w,A1
            move.l  #$2010009,D4
            moveq   #0,D2
            moveq   #0,D3
            movea.l IWM,A3
            tst.b   ($1A00,A3)
            moveq   #6,D0
            moveq   #0,D5
            move.b  (A2)+,($1E00,A3)
            lea     ($1A00,A3),A3
            moveq   #0,D6
            moveq   #0,D7
.L1:
            move.b  (A2)+,D1
.L2:
            tst.b   (A4)
            bpl.b   .L2
            move.b  D1,(A3)
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            subq.w  #1,D0
            bne.b   .L1
            move.b  (A2)+,D1
            lea     .L24,A2
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D1,(A3)
            moveq   #$B,D1
            move.b  (A1)+,D2
            bra.b   .L10
.L5:
            movea.l A0,A1
.L6:
            addx.b  D2,D7
            eor.b   D6,D2
            move.b  D2,D3
            lsr.w   #6,D3
.L7:
            tst.b   (A4)
            bpl.b   .L7
            move.b  (0,A2,D3.w),(A3)
            subq.w  #3,D4
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
            andi.b  #$3F,D0
.L8:
            tst.b   (A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (0,A2,D0.w),(A3)
.L10:
            move.b  (A1)+,D0
            addx.b  D0,D5
            eor.b   D7,D0
            move.b  D0,D3
            rol.w   #2,D3
            andi.b  #$3F,D1
.L11:
            tst.b   (A4)
            bpl.b   .L11
            move.b  (0,A2,D1.w),(A3)
            move.b  (A1)+,D1
            addx.b  D1,D6
            eor.b   D5,D1
            move.b  D1,D3
            rol.w   #2,D3
            andi.b  #$3F,D2
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  (0,A2,D2.w),(A3)
            move.b  (A1)+,D2
            tst.w   D4
            bne.b   .L6
            swap    D4
            bne.b   .L5
            clr.b   D3
            lsr.w   #6,D3
.L13:
            tst.b   (A4)
            bpl.b   .L13
            move.b  (0,A2,D3.w),(A3)
            move.b  D5,D3
            rol.w   #2,D3
            move.b  D6,D3
            rol.w   #2,D3
            andi.b  #$3F,D0
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (0,A2,D0.w),(A3)
            andi.b  #$3F,D1
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  (0,A2,D1.w),(A3)
            move.b  D7,D3
            lsr.w   #6,D3
.L16:
            tst.b   (A4)
            bpl.b   .L16
            move.b  (0,A2,D3.w),(A3)
            andi.b  #$3F,D5
.L17:
            tst.b   (A4)
            bpl.b   .L17
            move.b  (0,A2,D5.w),(A3)
            andi.b  #$3F,D6
            tst.b   (A5)
            bmi.b   .L18
            move.b  (A6),-(SP)
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  (0,A2,D6.w),(A3)
            andi.b  #$3F,D7
.L19:
            tst.b   (A4)
            bpl.b   .L19
            move.b  (0,A2,D7.w),(A3)
            lea     .L23,A2
            moveq   #3,D2
.L20:
            move.b  (A4),D1
            bpl.b   .L20
            move.b  (A2)+,(A3)
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            dbra    D2,.L20
            moveq   #0,D0
            btst    #6,D1
            bne.b   .L22
            moveq   #-$4A,D0
.L22:
            tst.b   ($200,A3)
            bra.w   sub_4086D7F2
.L23:
            dc.w    $DEAA,$FFFF
.L24:
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
.L25:
            dc.b    $FF,$3F,$CF,$F3,$FC,$FF,$D5,$AA,$96
            ds.b    5
            dc.w    $DEAA,$FFFF,$3FCF,$F3FC,$FFD5,$AAAD,0
.L26:
            suba.w  #$200,SP
            bsr.w   sub_408707EE
            move.w  ($1C,A0),D4
            beq.b   .L28
            moveq   #2,D3
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L27
            moveq   #3,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L27
            moveq   #1,D3
.L27:
            moveq   #-$32,D0
            cmp.w   D3,D4
            bhi.w   .L37
            cmpi.w  #3,D4
            seq     D0
            or.b    ($18,A1,D1.w),D0
            smi     ($17,A1,D1.w)
.L28:
            tst.b   ($138,A1)
            bpl.b   .L29
            bsr.w   SetChipMode
            bne.w   .L37
.L29:
            bsr.w   sub_4086D716
            tst.b   ($17,A1,D1.w)
            smi     ($32,A1)
            bmi.b   .L30
            tst.b   (5,A1,D1.w)
            smi     ($32,A1)
            bpl.b   .L30
            subq.w  #1,D4
            bne.b   .L30
            clr.b   ($32,A1)
.L30:
            tst.b   ($32,A1)
            sne     ($12,A1,D1.w)
            move.w  #8,($22,A1)
            bsr.w   sub_4086EA80
            moveq   #6,D0
            bsr.w   AdrAndSense
            bmi.b   .L31
            moveq   #-$2C,D0
            bra.b   .L37
.L31:
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            lea     .L25,A1
            moveq   #$B,D0
.L32:
            moveq   #$1A,D1
            movea.l A1,A2
.L33:
            move.b  (A2)+,(A0)+
            dbra    D1,.L33
            dbra    D0,.L32
            bsr.w   GetDrv1
            clr.w   ($16,A1)
.L34:
            bsr.b   sub_4086E768
            bne.b   .L37
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bpl.b   .L35
            bsr.w   mFmtTrack
            bra.b   .L36
.L35:
            bsr.w   FormatTrack
.L36:
            bne.b   .L37
            bsr.w   GetDrv1
            bclr    #3,($16,A1)
            addq.w  #1,($16,A1)
            cmpi.w  #$50,($16,A1)
            blt.b   .L34
            moveq   #0,D0
.L37:
            lea     ($200,SP),SP
            bra.w   DskRWOff
sub_4086E768:
            move.b  ($30,A1),($31,A1)
            move.w  ($16,A1),D6
            bsr.w   sub_4086EA66
            bsr.w   GetDrv1
            move.w  (0,A1,D1.w),D6
            bmi.b   .L1
            moveq   #0,D0
.L1:
            rts
FormatTrack:
            bsr.w   GetDrv1
            move.w  ($16,A1),D6
            move.w  D6,D1
            bclr    #$B,D1
            lsr.w   #4,D1
            moveq   #$C,D0
            sub.w   D1,D0
            move.w  D0,($20,A1)
            bsr.w   FillInMarks
.L1:
            bsr.b   sub_4086E81C
            beq.b   .L2
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            bra.w   .L6
.L2:
            bsr.w   sub_4086E174
            bmi.b   .L3
            tst.b   D2
            beq.b   .L3
            moveq   #-$52,D0
.L3:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            lea     ($22,A1),A0
            move.w  DskErr,D0
            bmi.b   .L8
            move.l  #$5E0,D2
            sub.w   D0,D2
            divu.w  #5,D2
            move.w  #$FFAD,DskErr
            sub.w   (A0),D2
            bmi.b   .L7
            ext.l   D2
            divu.w  ($20,A1),D2
            beq.b   .L4
            subq.w  #1,D2
            beq.b   .L4
            addq.w  #1,(A0)
.L4:
            bsr.w   GetDrv1
            bset    #3,($16,A1)
            bne.b   .L5
            tst.b   ($32,A1)
            bne.b   FormatTrack
.L5:
            clr.w   DskErr
.L6:
            move.w  DskErr,D0
            rts
.L7:
            addq.w  #1,D2
            beq.b   .L4
.L8:
            subq.w  #1,(A0)
            cmpi.w  #4,(A0)
            blt.b   .L6
            bra.b   .L1
sub_4086E81C:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            movea.l SonyVars,A1
            tst.b   ($32,A1)
            beq.b   .L1
            btst    #$B,D6
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l IWM,A4
            lea     ($1A00,A4),A3
            movea.l ($1C,A1),A0
            move.w  ($20,A1),D0
            move.w  ($22,A1),D1
            subq.w  #2,D1
            lea     WrData.L25,A1
            move.w  #$C7,D3
            tst.b   (A3)
            move.b  D3,($1E00,A4)
            lea     ($1800,A4),A4
.L2:
            movea.l A1,A2
            moveq   #2,D2
.L3:
            move.b  (A2)+,D4
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D4,(A3)
            move.b  (A2)+,D4
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            tst.b   (A4)
            bpl.b   .L5
            move.b  D4,(A3)
            dbra    D2,.L3
            dbra    D3,.L2
.L6:
            move.w  D1,D3
.L7:
            movea.l A1,A2
            moveq   #5,D2
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (A2)+,(A3)
            tst.b   (A5)
            bmi.b   .L9
            move.b  (A6),-(SP)
.L9:
            dbra    D2,.L8
            dbra    D3,.L7
            moveq   #$1A,D2
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  (A0)+,(A3)
            tst.b   (A5)
            bmi.b   .L11
            move.b  (A6),-(SP)
.L11:
            dbra    D2,.L10
            move.w  #$2BE,D2
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  #$96,(A3)
            tst.b   (A5)
            bmi.b   .L13
            move.b  (A6),-(SP)
.L13:
            dbra    D2,.L12
            moveq   #3,D2
            addq.w  #8,A2
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (A2)+,(A3)
            dbra    D2,.L14
            subq.w  #1,D0
            bgt.b   .L6
            move.b  (A4),D0
            moveq   #0,D2
            btst    #6,D0
            bne.b   .L15
            moveq   #-$4A,D0
            bra.b   .L16
.L15:
            moveq   #0,D0
.L16:
            tst.b   ($200,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
FillInMarks:
            movem.l D0-D7/A0-A1,-(SP)
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            moveq   #2,D3
            tst.b   ($32,A1)
            beq.b   .L1
            moveq   #$22,D3
.L1:
            movea.l ($25A).w,A1
            move.b  (0,A1,D3.w),D7
            move.b  D3,D5
            moveq   #$3F,D3
            and.b   D6,D3
            move.b  (0,A1,D3.w),D2
            eor.b   D3,D5
            lsr.w   #6,D6
            eor.b   D6,D5
            move.b  (0,A1,D6.w),D6
            move.w  D0,D1
            subq.w  #1,D1
            lsr.w   #1,D1
            addq.w  #1,D1
            swap    D1
            clr.w   D1
.L2:
            move.b  (0,A1,D1.w),D3
            moveq   #0,D4
            move.b  D5,D4
            eor.b   D1,D4
            lea     (9,A0),A0
            move.b  D2,(A0)+
            move.b  D3,(A0)+
            move.b  D6,(A0)+
            move.b  D7,(A0)+
            move.b  (0,A1,D4.w),(A0)+
            lea     ($C,A0),A0
            move.b  D3,(A0)+
            addq.w  #1,D1
            swap    D1
            subq.w  #1,D0
            bne.b   .L2
            movem.l (SP)+,D0-D7/A0-A1
            rts
CtlVerify:
            suba.w  #$200,SP
            bsr.w   sub_408707EE
            tst.b   ($138,A1)
            bpl.b   .L1
            bsr.w   SetChipMode
            bne.w   WrData.L37
.L1:
            bsr.w   sub_4086EA80
            moveq   #4,D2
            move.w  #$7F,D4
            moveq   #$4F,D6
.L2:
            lsl.w   #1,D4
            addq.w  #1,D4
            moveq   #$F,D3
.L3:
            movem.l D2-D6,-(SP)
            bsr.w   sub_4086EA66
            movem.l (SP)+,D2-D6
            bsr.w   GetDrv1
            move.w  (0,A1,D1.w),D0
            bmi.b   .L6
            tst.b   ($17,A1,D1.w)
            bpl.b   .L4
            bsr.w   sub_4086F306
            bra.b   .L5
.L4:
            bsr.b   VerTrack
.L5:
            bne.b   .L6
            subq.w  #1,D6
            dbra    D3,.L3
            dbra    D2,.L2
.L6:
            bra.w   WrData.L37
VerTrack:
            movem.l D2-D6,-(SP)
            ori     #$700,SR
            lea     ($22,A1),A0
            move.w  D4,(A0)
            moveq   #$C,D3
            sub.w   D2,D3
            lsl.w   #2,D3
            move.w  D3,(2,A0)
            move.l  (A0)+,(A0)+
            bclr    #3,($16,A1)
.L1:
            move.l  D1,D6
            bsr.w   RdAddrSetup
            bpl.b   .L2
            bsr.b   toEmptyPD
            andi    #$F8FF,SR
            bra.b   .L7
.L2:
            lea     ($20,A1),A0
            move.w  D2,(A0)+
            move.w  (A0)+,D0
            bclr    D2,D0
            bne.b   .L3
            bsr.b   toEmptyPD
            andi    #$F8FF,SR
            lea     ($24,A1),A0
            bra.b   .L4
.L3:
            cmpi.b  #$1F,D3
            sgt     ($12,A1,D6.w)
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   RdData
            bsr.b   toEmptyPD
            tst.w   D0
            bne.b   .L7
            lea     ($20,A1),A0
            move.w  (A0)+,D2
            move.w  (A0),D0
            bclr    D2,D0
            move.w  D0,(A0)+
            beq.b   .L5
.L4:
            subq.w  #1,(A0)
            bne.b   .L1
            moveq   #-$54,D0
            bra.b   .L7
.L5:
            bsr.w   GetDrv1
            tst.b   ($12,A1,D1.w)
            beq.b   .L6
            bset    #3,($16,A1)
            bne.b   .L6
            addq.w  #2,A0
            move.l  (A0),-(A0)
            bra.b   .L1
.L6:
            moveq   #0,D0
.L7:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D6
            tst.w   D0
            rts
toEmptyPD:
            move.w  D0,DskErr
            bra.w   EmptyPD
sub_4086EA66:
            lea     sub_4086D4AE,A0
.L1:
            clr.b   DskErr
            bsr.b   sub_4086EA78
.L2:
            tst.b   DskErr
            beq.b   .L2
            rts
sub_4086EA78:
            jsr     (A0)
            st      DskErr
            rts
sub_4086EA80:
            lea     PowerUp,A0
            bra.b   sub_4086EA66.L1
Check4SWIM:
            movea.l SonyVars,A1
            move    SR,-(SP)
            ori     #$700,SR
            movea.l IWM,A0
            tst.b   ($1400,A0)
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            moveq   #-9,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L1
            st      ($138,A1)
            move.b  #$F8,($C00,A0)
.L1:
            tst.b   ($1C00,A0)
            tst.b   ($1800,A0)
            tst.b   ($1200,A0)
            move    (SP)+,SR
            rts
SetChipMode:
            bsr.w   GetDrv1
            tst.b   ($138,A1)
            bpl.w   SetIWMMode
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #1,D2
.L1:
            movea.l IWM,A0
            move.b  #$38,($C00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            moveq   #-9,D0
            move.b  D0,($800,A0)
            cmp.b   ($1800,A0),D0
            bne.b   .L2
            tst.b   ($17,A1,D1.w)
            bmi.b   .L3
            move.b  #$F8,($C00,A0)
            tst.b   ($1C00,A0)
.L2:
            clr.b   ($139,A1)
            move.l  D2,-(SP)
            bsr.w   SetIWMMode
            move.l  (SP)+,D2
            tst.w   D0
            bne.b   .L7
            tst.b   ($17,A1,D1.w)
            bpl.b   .L7
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            dbra    D2,.L1
            bra.b   .L5
.L3:
            move.b  #$38,($C00,A0)
            move.b  #$C0,($400,A0)
            moveq   #$20,D0
            move.b  D0,($A00,A0)
            cmp.b   ($1A00,A0),D0
            bne.b   .L4
            bsr.b   NotSWIM2
            beq.b   .L6
.L4:
            move.b  #$F8,($C00,A0)
.L5:
            tst.b   ($1C00,A0)
            moveq   #-$4D,D0
.L6:
            seq     ($139,A1)
.L7:
            move    (SP)+,SR
            tst.w   D0
            rts
NotSWIM2:
            move.w  (0,A1,D1.w),D0
            movea.l VIA,A1
            lea     ($1E00,A1),A1
            lea     .L6,A2
.L1:
            addq.w  #2,A2
            cmp.w   (A2)+,D0
            bge.b   .L1
            move.w  (A2),D0
            lea     .L7(PC,D0.w),A2
            moveq   #4,D2
.L2:
            move.b  #$38,($C00,A0)
            swap    D2
            moveq   #$F,D0
.L3:
            move.b  (A1),(A1)
            move.b  ($1600,A0),D2
            cmp.b   (0,A2,D0.w),D2
            dbne    D0,.L3
            bne.b   .L4
            movea.l SonyVars,A1
            moveq   #0,D0
            rts
.L4:
            move.b  #$38,($C00,A0)
            moveq   #$F,D0
.L5:
            move.b  (A1),(A1)
            move.b  (0,A2,D0.w),($600,A0)
            dbra    D0,.L5
            swap    D2
            dbra    D2,.L2
            movea.l SonyVars,A1
            moveq   #-$4D,D0
.L6:
            rts
.L7:
            dc.w    $0050,$0010,$0050,$0020,$0050,$0010,$0050,$0010
            dc.w    $3B57,$1B97,$1919,$2F2F,$1B1B,$1818,$2E2E,$4118
            dc.w    $3B57,$1B97,$1919,$2F2F,$1B1B,$1818,$2E2E,$4118
            dc.b    'SO...WHAT ARE YOU STARING AT?   '
.L8:
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L11
            moveq   #$F,D0
            bsr.w   AdrAndSense
            spl     ($18,A1,D1.w)
            bsr.b   GetASector
            tst.w   D0
            bmi.b   .L9
            move.b  ($18,A1,D1.w),($17,A1,D1.w)
            bpl.b   .L11
            addq.b  #1,(3,A1,D1.w)
            move.w  #$FE70,D0
            bra.w   DskRWOff
.L9:
            st      ($17,A1,D1.w)
            bsr.w   Recal
            bne.b   .L10
            tst.b   ($18,A1,D1.w)
            bmi.b   .L11
            bsr.b   GetASector
            subi.b  #$22,D3
            or.w    D3,D0
            beq.b   .L11
.L10:
            move.b  ($18,A1,D1.w),($17,A1,D1.w)
.L11:
            bra.w   CkDrvNum.L5
GetASector:
            moveq   #5,D1
.L1:
            move.w  D1,-(SP)
            move    SR,-(SP)
            clr.w   ($16,A1)
            bsr.w   RdAddrSetup
            bsr.w   EmptyPD
            move    (SP)+,SR
            move.w  (SP)+,D1
            tst.w   D0
            dbpl    D1,.L1
            bra.w   GetDrv1
mAdrDisk:
            move.b  #$F3,($800,A0)
            btst    #1,D0
            beq.b   .L3
            bset    #5,($1E00,A2)
            bra.b   .L4
.L3:
            bclr    #5,($1E00,A2)
.L4:
            move.b  .L5(PC,D0.w),($800,A0)
            rts
.L5:
            dc.w    $F0F4,$F0F4,$F1F5,$F1F5,$F2F6,$F2F6,$F3F7,$F3F7
            dc.w    $5357,$4321
mSense:
            btst    #3,($1E00,A0)
            sne     D0
            tst.b   D0
            rts
mPulse:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  D0,-(SP)
            moveq   #-8,D0
            or.b    ($1800,A0),D0
            move.b  D0,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            subq.b  #8,D0
            move.b  D0,($800,A0)
            move.l  (SP)+,D0
            move    (SP)+,SR
            rts
.L8:
            cmpi.w  #$4A,D1
            bne.b   .L9
            move.b  #4,($C00,A0)
            move.b  #$82,($E00,A0)
            rts
.L9:
            move.b  #$F7,($800,A0)
            bclr    #5,($1E00,A2)
            tst.b   ($FC,A1)
            beq.b   .L10
            move.b  #2,($C00,A0)
            move.b  #$84,($E00,A0)
            rts
.L10:
            cmpi.w  #$8C,D1
            bne.b   .L14
            move.b  #2,($C00,A0)
            move.b  #$84,($E00,A0)
            moveq   #2,D0
.L11:
            move    SR,-(SP)
            ori     #$700,SR
            bra.b   .L13
.L12:
            move.b  #$FF,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F7,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F5,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$F7,($800,A0)
            move.b  ($1E00,A2),($1E00,A2)
.L13:
            btst    #3,($1E00,A0)
            dbeq    D0,.L12
            move    (SP)+,SR
            rts
.L14:
            move.b  #4,($E00,A0)
            move.b  #$80,($C00,A0)
            move.w  ($12,A1),D0
            move.b  ($1E00,A2),($1E00,A2)
            move.b  #$80,($E00,A0)
            subq.w  #3,D0
            bra.b   .L11
.L15:
            moveq   #$5A,D2
            lsl.w   #4,D2
            moveq   #9,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L16
            add.w   D2,D2
            moveq   #$12,D3
.L16:
            cmp.l   D2,D0
            bge.w   GetTrack.L13
            divu.w  D3,D0
            lsr.w   #1,D0
            scs     D6
            move.w  D0,D5
            swap    D0
            moveq   #-1,D2
            addq.w  #1,D3
            bra.w   GetTrack.L18
.L17:
            dc.w    $A1A1,$A1FE
.L18:
            lea     .L17,A2
            move.l  ($680).w,-(SP)
            rts
            move.l  (SP)+,DskRtnAdr
            lea     BufTgFNum,A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            movea.l IWM,A4
            lea     ($1E00,A4),A3
            lea     ($1200,A4),A4
            moveq   #-$43,D0
            move.w  #$4E20,D2
.L19:
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            movea.l A2,A0
            moveq   #3,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A3)
            dbmi    D2,.L20
            bpl.w   sub_4086EEDC.L14
            move.b  (A4),D5
            cmp.b   (A0)+,D5
            dbne    D1,.L20
            bne.b   .L19
            moveq   #$1E,D0
.L22:
            tst.b   (A3)
            dbmi    D0,.L22
            bpl.b   .L28
            moveq   #0,D1
            move.b  (A4),D1
            lea     BufTgFNum,A0
            move.b  D1,(A0)+
            moveq   #$1E,D0
.L23:
            tst.b   (A3)
            dbmi    D0,.L23
            bpl.b   .L28
            move.b  (A4),(A0)+
            beq.b   .L24
            bset    #$B,D1
.L24:
            moveq   #$1E,D0
            moveq   #0,D2
.L25:
            tst.b   (A3)
            dbmi    D0,.L25
            bpl.b   .L28
            move.b  (A4),D2
            move.b  D2,(A0)+
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            moveq   #$1E,D0
            moveq   #$20,D3
.L27:
            tst.b   (A3)
            dbmi    D0,.L27
            bpl.b   .L28
            or.b    (A4),D3
            move.b  D3,(A0)+
            moveq   #-$45,D0
            bra.w   sub_4086EEDC.L11
.L28:
            bra.w   sub_4086EEDC.L15
mAdrDisk9:
            dc.w    $A1A1,$A1FB
sub_4086EEDC:
            lea     mAdrDisk9,A1
            move.l  ($684).w,-(SP)
            rts
            move.l  (SP)+,DskRtnAdr
            move.w  #$1FF,D4
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            moveq   #-$47,D0
            moveq   #3,D1
            moveq   #-1,D2
.L1:
            tst.b   (A5)
            bmi.b   .L2
            move.b  (A6),-(SP)
.L2:
            tst.b   (A3)
            dbmi    D2,.L1
            bpl.b   .L6
            moveq   #$1E,D2
            move.b  (A4),D5
            cmp.b   (A1)+,D5
            dbne    D1,.L1
            bne.b   .L14
            tst.b   DskVerify
            bne.b   .L7
.L3:
            tst.b   (A3)
            bmi.b   .L5
            moveq   #$1E,D1
            tst.b   (A5)
            bmi.b   .L4
            move.b  (A6),-(SP)
.L4:
            tst.b   (A3)
            dbmi    D1,.L4
            bpl.b   .L6
.L5:
            move.b  (A4),(A0)+
            dbra    D4,.L3
            bra.b   .L10
.L6:
            bra.b   .L15
.L7:
            tst.b   (A3)
            bmi.b   .L9
            moveq   #$1E,D1
            tst.b   (A5)
            bmi.b   .L8
            move.b  (A6),-(SP)
.L8:
            tst.b   (A3)
            dbmi    D1,.L8
            bpl.b   .L6
.L9:
            move.b  (A4),D2
            cmp.b   (A0)+,D2
            dbne    D4,.L7
            bne.b   .L16
.L10:
            moveq   #-$48,D0
            lea     BufTgDate,A0
.L11:
            moveq   #$1E,D4
.L12:
            tst.b   (A3)
            dbmi    D4,.L12
            bpl.b   .L15
            move.b  (A4),(A0)+
            moveq   #$1E,D4
.L13:
            move.b  (A3),D5
            dbmi    D4,.L13
            bpl.b   .L15
            move.b  (A4),(A0)+
            move.b  ($200,A4),(A0)+
            move.b  D5,(A0)
            andi.b  #$22,D5
            bne.b   .L14
            moveq   #0,D0
.L14:
            move.b  #$18,(-$600,A4)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
.L15:
            moveq   #-$42,D0
            bra.b   .L14
.L16:
            moveq   #-$44,D0
            bra.b   .L14
.L17:
            lea     mAdrDisk9,A2
            move.l  ($688).w,-(SP)
            rts
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     (A4),A3
            lea     ($1E00,A4),A4
            move.b  #$F5,($800,A3)
            tst.b   ($1400,A3)
            move.b  #$18,($C00,A3)
            move.b  #$10,($E00,A3)
            move.b  #1,($E00,A3)
            move.b  #1,($C00,A3)
            tst.b   ($1400,A3)
            move.w  #$4978,D0
            mulu.w  TimeVIADB,D0
            swap    D0
.L18:
            btst    #7,(A5)
            dbeq    D0,.L18
            bne.b   .L19
            move.b  (A6),-(SP)
            subq.w  #2,D0
            bpl.b   .L18
.L19:
            moveq   #9,D0
            moveq   #0,D1
            move.b  D1,(A3)
            move.b  D1,(A3)
            move.b  #8,($E00,A3)
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  D1,(A3)
            dbra    D0,.L20
            moveq   #2,D0
.L22:
            tst.b   (A5)
            bmi.b   .L23
            move.b  (A6),-(SP)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  (A2)+,($200,A3)
            dbra    D0,.L22
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  (A2),(A3)
            move.w  #$1FF,D0
.L25:
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            tst.b   (A4)
            bpl.b   .L26
            move.b  (A0)+,(A3)
            dbra    D0,.L25
.L27:
            tst.b   (A4)
            bpl.b   .L27
            move.b  D0,($400,A3)
            moveq   #3,D0
.L28:
            tst.b   (A5)
            bmi.b   .L29
            move.b  (A6),-(SP)
.L29:
            move.b  (A4),D2
            bpl.b   .L29
            move.b  #$4E,(A3)
            dbra    D0,.L28
            moveq   #0,D0
            btst    #5,D2
            beq.b   .L30
            moveq   #-$4A,D0
.L30:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
mFmtTrack:
            bsr.w   GetDrv1
            move.w  ($16,A1),D4
            moveq   #0,D5
            bclr    #$B,D4
            beq.b   .L2
            moveq   #1,D5
            moveq   #0,D2
            move.w  TimeDBRA,D2
            move.l  D2,D0
            add.l   D2,D0
            add.l   D2,D0
            lsr.l   #2,D0
.L1:
            dbra    D0,.L1
.L2:
            moveq   #8,D2
            move.b  ($18,A1,D1.w),D0
            bpl.b   .L3
            moveq   #$11,D2
            bset    #$1F,D2
.L3:
            bsr.b   sub_4086F0DC
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            move.w  DskErr,D0
            bne.b   .L4
            bsr.w   GetDrv1
            bset    #3,($16,A1)
            beq.b   mFmtTrack
            moveq   #0,D0
.L4:
            rts
sub_4086F0DC:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            tst.w   D5
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l IWM,A4
            lea     (A4),A3
            lea     ($1E00,A4),A4
            tst.b   ($1400,A3)
            move.b  #$18,($C00,A3)
            move.b  #$10,($E00,A3)
            move.b  #1,($E00,A3)
            move.b  #1,($C00,A3)
            moveq   #$4E,D1
            move.b  D1,(A3)
            move.b  D1,(A3)
            move.b  #8,($E00,A3)
            move.w  #$34BC,D3
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            move.b  (A4),D0
            bpl.b   .L3
            move.b  D1,(A3)
            btst    #3,D0
            beq.b   .L4
            dbra    D3,.L2
            bra.w   .L44
.L4:
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            move.b  (A4),D0
            bpl.b   .L5
            move.b  D1,(A3)
            btst    #3,D0
            bne.b   .L6
            dbra    D3,.L4
            bra.w   .L44
.L6:
            move.b  #$F5,($800,A3)
            moveq   #$4E,D0
.L7:
            tst.b   (A5)
            bmi.b   .L8
            move.b  (A6),-(SP)
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  D1,(A3)
            dbra    D0,.L7
            moveq   #$B,D0
            moveq   #0,D1
.L9:
            tst.b   (A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  D1,(A3)
            dbra    D0,.L9
            moveq   #2,D0
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  #$C2,($200,A3)
            dbra    D0,.L11
.L13:
            tst.b   (A4)
            bpl.b   .L13
            move.b  #$FC,(A3)
            moveq   #$31,D0
.L14:
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  #$4E,(A3)
            dbra    D0,.L14
            moveq   #1,D6
            bra.b   .L19
.L16:
            moveq   #$4F,D0
            tst.l   D2
            bpl.b   .L17
            moveq   #$64,D0
.L17:
            tst.b   (A5)
            bmi.b   .L18
            move.b  (A6),-(SP)
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  #$4E,(A3)
            dbra    D0,.L17
.L19:
            moveq   #$B,D0
            moveq   #0,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  D1,(A3)
            dbra    D0,.L20
            moveq   #2,D0
.L22:
            tst.b   (A5)
            bmi.b   .L23
            move.b  (A6),-(SP)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  #$A1,($200,A3)
            dbra    D0,.L22
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  #$FE,(A3)
            tst.b   (A5)
            bmi.b   .L25
            move.b  (A6),-(SP)
.L25:
            tst.b   (A4)
            bpl.b   .L25
            move.b  D4,(A3)
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            tst.b   (A4)
            bpl.b   .L26
            move.b  D5,(A3)
            tst.b   (A5)
            bmi.b   .L27
            move.b  (A6),-(SP)
.L27:
            tst.b   (A4)
            bpl.b   .L27
            move.b  D6,(A3)
            tst.b   (A5)
            bmi.b   .L28
            move.b  (A6),-(SP)
.L28:
            tst.b   (A4)
            bpl.b   .L28
            move.b  #2,(A3)
            tst.b   (A5)
            bmi.b   .L29
            move.b  (A6),-(SP)
.L29:
            tst.b   (A4)
            bpl.b   .L29
            move.b  D0,($400,A3)
            moveq   #$15,D0
.L30:
            tst.b   (A5)
            bmi.b   .L31
            move.b  (A6),-(SP)
.L31:
            tst.b   (A4)
            bpl.b   .L31
            move.b  #$4E,(A3)
            dbra    D0,.L30
            moveq   #$B,D0
            moveq   #0,D1
.L32:
            tst.b   (A5)
            bmi.b   .L33
            move.b  (A6),-(SP)
.L33:
            tst.b   (A4)
            bpl.b   .L33
            move.b  D1,(A3)
            dbra    D0,.L32
            moveq   #2,D0
.L34:
            tst.b   (A5)
            bmi.b   .L35
            move.b  (A6),-(SP)
.L35:
            tst.b   (A4)
            bpl.b   .L35
            move.b  #$A1,($200,A3)
            dbra    D0,.L34
.L36:
            tst.b   (A4)
            bpl.b   .L36
            move.b  #$FB,(A3)
            move.w  #$1FF,D0
.L37:
            tst.b   (A5)
            bmi.b   .L38
            move.b  (A6),-(SP)
.L38:
            tst.b   (A4)
            bpl.b   .L38
            move.b  #$F6,(A3)
            dbra    D0,.L37
.L39:
            tst.b   (A4)
            bpl.b   .L39
            move.b  D0,($400,A3)
            addq.w  #1,D6
            dbra    D2,.L16
            moveq   #4,D0
            moveq   #$4E,D1
            move.w  #$3E8,D3
            tst.w   D5
            bne.b   .L41
            moveq   #4,D3
            bra.b   .L41
.L40:
            move.b  #$F4,($800,A3)
.L41:
            tst.b   (A5)
            bmi.b   .L42
            move.b  (A6),-(SP)
.L42:
            move.b  (A4),D2
            bpl.b   .L42
            move.b  D1,(A3)
            subq.w  #1,D0
            bgt.b   .L43
            beq.b   .L40
            btst    #3,D2
            bne.b   .L45
.L43:
            dbra    D3,.L41
            tst.w   D5
            beq.b   .L45
.L44:
            moveq   #-$53,D0
            bra.b   .L46
.L45:
            moveq   #0,D0
            btst    #5,D2
            beq.b   .L46
            moveq   #-$4A,D0
.L46:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
sub_4086F306:
            movem.l D2-D7,-(SP)
            ori     #$700,SR
            move.w  D6,($16,A1)
.L1:
            moveq   #$24,D7
            move.l  #$3FE,D6
            tst.b   ($18,A1,D1.w)
            bpl.b   .L2
            moveq   #$48,D7
            move.l  #$7FFFE,D6
.L2:
            bsr.w   RdAddrSetup
            bne.b   .L3
            btst    D2,D6
            beq.b   .L3
            cmp.w   ($16,A1),D1
            bne.b   .L3
            move.w  D2,D3
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   sub_4086EEDC
            bne.b   .L3
            bclr    D3,D6
.L3:
            bsr.w   toEmptyPD
            tst.l   D6
            dbeq    D7,.L2
            beq.b   .L4
            moveq   #-$54,D0
            bra.b   .L5
.L4:
            bset    #3,($16,A1)
            beq.b   .L1
.L5:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D7
            tst.w   D0
            rts
            move.w  #$410,(A0)
            moveq   #0,D0
            bra.w   sub_4086CA2A.L9
            move.b  ($14C,A1),(A0)
            moveq   #0,D0
            bra.w   sub_4086CA2A.L9
            bne.w   sub_4086CA2A.L9
            suba.w  #$200,SP
            bsr.w   sub_40870774
            lea     ($1E,A0),A0
            move.l  A0,($148,A1)
            move.w  -(A0),D4
            beq.b   .L7
            moveq   #2,D3
            move.b  ($138,A1),D0
            and.b   ($16,A1,D1.w),D0
            bpl.b   .L6
            moveq   #3,D3
            tst.b   ($18,A1,D1.w)
            bpl.b   .L6
            moveq   #1,D3
.L6:
            moveq   #-$32,D0
            cmp.w   D3,D4
            bhi.w   .L16
            cmpi.w  #3,D4
            seq     D0
            or.b    ($18,A1,D1.w),D0
            smi     ($17,A1,D1.w)
.L7:
            tst.b   ($138,A1)
            bpl.b   .L8
            bsr.w   SetChipMode
            bne.w   .L16
.L8:
            bsr.w   sub_4086D716
            tst.b   ($17,A1,D1.w)
            smi     ($32,A1)
            bmi.b   .L9
            tst.b   (5,A1,D1.w)
            smi     ($32,A1)
            bpl.b   .L9
            subq.w  #1,D4
            bne.b   .L9
            clr.b   ($32,A1)
.L9:
            tst.b   ($32,A1)
            sne     ($12,A1,D1.w)
            move.w  #8,($22,A1)
            bsr.w   sub_4086EA80
            moveq   #6,D0
            bsr.w   AdrAndSense
            bmi.b   .L10
            moveq   #-$2C,D0
            bra.b   .L16
.L10:
            movea.l SonyVars,A1
            movea.l ($1C,A1),A0
            moveq   #$B,D0
.L11:
            moveq   #$23,D1
            lea     WrData.L25,A1
.L12:
            move.b  (A1)+,(A0)+
            dbra    D1,.L12
            dbra    D0,.L11
            bsr.w   GetDrv1
            clr.w   ($16,A1)
.L13:
            bsr.w   sub_4086E768
            bne.b   .L16
            bsr.w   GetDrv1
            tst.b   ($17,A1,D1.w)
            bpl.b   .L14
            bsr.w   mFmtCopyTrk
            bra.b   .L15
.L14:
            bsr.w   gFmtCopyTrk
.L15:
            bne.b   .L16
            bsr.w   GetDrv1
            bclr    #3,($16,A1)
            addq.w  #1,($16,A1)
            cmpi.w  #$50,($16,A1)
            blt.b   .L13
            moveq   #0,D0
.L16:
            lea     ($200,SP),SP
            bra.w   DskRWOff
gFmtCopyTrk:
            bsr.w   GetDrv1
            move.w  ($16,A1),D6
            bsr.w   FillMarks
.L1:
            bsr.w   gDoFmtCopy
            beq.b   .L2
            andi    #$F8FF,SR
            bra.w   .L7
.L2:
            bsr.w   GetDrv1
            bsr.w   RdAddrSetup
            bmi.b   .L3
            tst.b   D2
            beq.b   .L3
            moveq   #-$52,D0
.L3:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            lea     ($22,A1),A0
            move.w  DskErr,D0
            bmi.b   sub_4086F50C.L1
            move.l  #$5E0,D2
            sub.w   D0,D2
            divu.w  #5,D2
            moveq   #-$53,D0
            sub.w   (A0),D2
            bmi.b   sub_4086F50C
            ext.l   D2
            divu.w  ($20,A1),D2
            beq.b   .L4
            subq.w  #1,D2
            beq.b   .L4
            addq.w  #1,(A0)
.L4:
            bsr.w   GetDrv1
            movea.l ($148,A1),A0
            tst.b   (9,A0)
            beq.b   .L5
            bsr.b   gVerCopy
            bne.b   .L7
            movea.l ($148,A1),A0
.L5:
            moveq   #0,D1
            move.w  ($20,A1),D1
            lsl.l   #2,D1
            move.l  D1,D2
            add.l   D1,D1
            add.l   D1,D2
            lsl.l   #6,D1
            add.l   D1,(A0)+
            add.l   D2,(A0)+
            bset    #3,($16,A1)
            bne.b   .L6
            tst.b   ($32,A1)
            bne.w   gFmtCopyTrk
.L6:
            moveq   #0,D0
.L7:
            tst.w   D0
            rts
sub_4086F50C:
            addq.w  #1,D2
            beq.b   gFmtCopyTrk.L4
.L1:
            subq.w  #1,(A0)
            cmpi.w  #4,(A0)
            blt.b   gFmtCopyTrk.L7
            bra.w   gFmtCopyTrk.L1
gVerCopy:
            ori     #$700,SR
            lea     ($26,A1),A0
            moveq   #0,D0
            move.b  ($17,A1),D0
            lsr.w   #4,D0
            move.w  #$FFF,D2
            lsr.w   D0,D2
            move.w  D2,(A0)+
            moveq   #$C,D2
            sub.w   D0,D2
            lsl.w   #2,D2
            move.w  D2,(A0)
.L1:
            bsr.w   RdAddrSetup
            bmi.b   .L2
            move.w  D2,($24,A1)
            cmp.w   ($16,A1),D1
            bne.b   .L2
            movea.l ($148,A1),A0
            movea.l (A0),A0
            moveq   #9,D0
            lsl.w   D0,D2
            adda.w  D2,A0
            st      DskVerify
            bsr.w   RdData
            bmi.b   .L2
            bsr.w   GetDrv1
            lea     ($24,A1),A0
            move.w  (A0)+,D2
            move.w  (A0),D3
            bclr    D2,D3
            move.w  D3,(A0)
.L2:
            bsr.w   toEmptyPD
            lea     ($26,A1),A0
            tst.w   (A0)+
            beq.b   .L3
            subq.w  #1,(A0)
            bne.b   .L1
            moveq   #-$54,D0
            bra.b   .L4
.L3:
            moveq   #0,D0
.L4:
            andi    #$F8FF,SR
            tst.w   D0
            rts
gDoFmtCopy:
            ori     #$700,SR
            moveq   #1,D0
            movea.l SonyVars,A1
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            movea.l IWM,A4
            lea     ($1A00,A4),A3
            lea     ($1800,A4),A4
            movea.l ($1C,A1),A5
            lea     mDoFormat.L49,A2
            move.w  ($20,A1),-(SP)
            move.w  ($22,A1),D1
            subq.w  #2,D1
            move.w  D1,DskErr
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            move.w  #$C7,D6
            tst.b   (A3)
            move.b  D6,($400,A3)
.L2:
            lea     WrData.L25,A6
            moveq   #2,D7
.L3:
            move.b  (A6)+,D4
.L4:
            tst.b   (A4)
            bpl.b   .L4
            move.b  D4,(A3)
            move.b  (A6)+,D4
.L5:
            tst.b   (A4)
            bpl.b   .L5
            move.b  D4,(A3)
            dbra    D7,.L3
            dbra    D6,.L2
.L6:
            move.w  DskErr,D6
.L7:
            lea     WrData.L25,A6
            moveq   #5,D7
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  (A6)+,(A3)
            dbra    D7,.L8
            dbra    D6,.L7
            moveq   #$16,D7
.L9:
            tst.b   (A4)
            bpl.b   .L9
            move.b  (A5)+,(A3)
            dbra    D7,.L9
            move.b  (A5)+,D0
            move.b  (A5)+,D3
            move.b  (A5)+,D1
            move.b  (A5)+,D2
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  D0,(A3)
            addq.w  #1,A5
            movea.l (A5)+,A1
            movea.l (A5)+,A0
            move.l  #$2010009,D4
.L11:
            tst.b   (A4)
            bpl.b   .L11
            move.b  D3,(A3)
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
            bra.b   .L16
.L12:
            movea.l A0,A1
.L13:
            addx.b  D2,D7
            eor.b   D6,D2
            move.b  D2,D3
            lsr.w   #6,D3
.L14:
            tst.b   (A4)
            bpl.b   .L14
            move.b  (0,A2,D3.w),(A3)
            subq.w  #3,D4
            move.b  D7,D3
            add.b   D7,D3
            rol.b   #1,D7
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  (0,A2,D0.w),(A3)
.L16:
            move.b  (A1)+,D0
            addx.b  D0,D5
            eor.b   D7,D0
            move.b  D0,D3
            rol.w   #2,D3
.L17:
            tst.b   (A4)
            bpl.b   .L17
            move.b  (0,A2,D1.w),(A3)
            move.b  (A1)+,D1
            addx.b  D1,D6
            eor.b   D5,D1
            move.b  D1,D3
            rol.w   #2,D3
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  (0,A2,D2.w),(A3)
            move.b  (A1)+,D2
            tst.w   D4
            bne.b   .L13
            swap    D4
            bne.b   .L12
            clr.b   D3
            lsr.w   #6,D3
.L19:
            tst.b   (A4)
            bpl.b   .L19
            move.b  (0,A2,D3.w),(A3)
            move.b  D5,D3
            rol.w   #2,D3
            move.b  D6,D3
            rol.w   #2,D3
.L20:
            tst.b   (A4)
            bpl.b   .L20
            move.b  (0,A2,D0.w),(A3)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  (0,A2,D1.w),(A3)
            move.b  D7,D3
            lsr.w   #6,D3
.L22:
            tst.b   (A4)
            bpl.b   .L22
            move.b  (0,A2,D3.w),(A3)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  (0,A2,D5.w),(A3)
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  (0,A2,D6.w),(A3)
.L25:
            tst.b   (A4)
            bpl.b   .L25
            move.b  (0,A2,D7.w),(A3)
            moveq   #3,D7
            addq.w  #8,A6
.L26:
            move.b  (A4),D1
            bpl.b   .L26
            move.b  (A6)+,(A3)
            dbra    D7,.L26
            subq.w  #1,(SP)
            bgt.w   .L6
            addq.w  #2,SP
            moveq   #0,D0
            btst    #6,D1
            bne.b   .L27
            moveq   #-$4A,D0
.L27:
            tst.b   ($400,A4)
            tst.b   (A4)
            move.w  D0,DskErr
            rts
FillMarks:
            movem.l D0-D7/A0-A4,-(SP)
            movea.l ($1C,A1),A0
            movea.l ($148,A1),A2
            movea.l (A2)+,A4
            movea.l (A2)+,A3
            moveq   #0,D3
            move.b  (A2),D3
            moveq   #$C,D0
            moveq   #$7F,D2
            and.w   D6,D2
            lsr.w   #4,D2
            sub.w   D2,D0
            move.w  D0,($20,A1)
            lea     mDoFormat.L49,A1
            lea     mDoFormat.L48,A2
            move.b  (0,A1,D3.w),D7
            move.b  D3,D5
            andi.b  #$F,D3
            subq.b  #2,D3
            beq.b   .L1
            lea     mDoFormat.L47,A2
.L1:
            mulu.w  #$C,D2
            adda.w  D2,A2
            moveq   #$3F,D3
            and.b   D6,D3
            move.b  (0,A1,D3.w),D2
            eor.b   D3,D5
            lsr.w   #6,D6
            eor.b   D6,D5
            move.b  (0,A1,D6.w),D6
.L2:
            swap    D0
            moveq   #0,D1
            move.b  (0,A2,D0.w),D1
            move.b  (0,A1,D1.w),D3
            moveq   #0,D4
            move.b  D5,D4
            eor.b   D1,D4
            lea     (9,A0),A0
            move.b  D2,(A0)+
            move.b  D3,(A0)+
            move.b  D6,(A0)+
            move.b  D7,(A0)+
            move.b  (0,A1,D4.w),(A0)+
            lea     ($B,A0),A0
            move.b  #$B,(A0)+
            move.b  D1,(A0)+
            clr.b   (A0)+
            move.l  D1,D4
            add.w   D4,D4
            add.w   D1,D4
            lsl.w   #2,D4
            add.l   A3,D4
            move.l  D4,(A0)+
            moveq   #9,D4
            lsl.w   D4,D1
            add.l   A4,D1
            move.l  D1,(A0)+
            addq.w  #1,D0
            move.w  D0,D1
            swap    D0
            cmp.w   D0,D1
            blt.b   .L2
            movem.l (SP)+,D0-D7/A0-A4
            rts
mFmtCopyTrk:
            bsr.w   GetDrv1
            move.w  ($16,A1),D4
            moveq   #0,D5
            bclr    #$B,D4
            beq.b   .L2
            moveq   #1,D5
            moveq   #0,D2
            move.w  TimeDBRA,D2
            move.l  D2,D0
            add.l   D2,D0
            add.l   D2,D0
            lsr.l   #2,D0
.L1:
            dbra    D0,.L1
.L2:
            moveq   #8,D2
            move.b  ($18,A1,D1.w),D0
            bpl.b   .L3
            moveq   #$11,D2
            bset    #$1F,D2
.L3:
            bsr.w   mDoFormat
            movea.l ($148,A1),A1
            movea.l (A1),A2
            move.l  A0,(A1)
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
            move.w  DskErr,D0
            bne.b   .L5
            movea.l ($148,A1),A0
            tst.b   (9,A0)
            beq.b   .L4
            bsr.b   mVerCopy
            bne.b   .L5
            bsr.w   GetDrv1
.L4:
            bset    #3,($16,A1)
            beq.b   mFmtCopyTrk
            moveq   #0,D0
.L5:
            rts
mVerCopy:
            movem.l D2-D7,-(SP)
            ori     #$700,SR
            moveq   #$12,D7
            move.l  #$3FE,D6
            bsr.w   GetDrv1
            tst.b   ($18,A1,D1.w)
            bpl.b   .L1
            moveq   #$24,D7
            move.l  #$7FFFE,D6
.L1:
            bsr.w   RdAddrSetup
            bne.b   .L2
            btst    D2,D6
            beq.b   .L2
            cmp.w   ($16,A1),D1
            bne.b   .L2
            move.w  D2,D3
            subq.w  #1,D2
            moveq   #9,D0
            lsl.l   D0,D2
            add.l   ($1C,A1),D2
            movea.l D2,A0
            st      DskVerify
            bsr.w   sub_4086EEDC
            bne.b   .L2
            bclr    D3,D6
.L2:
            bsr.w   toEmptyPD
            tst.l   D6
            dbeq    D7,.L1
            beq.b   .L3
            moveq   #-$54,D0
.L3:
            andi    #$F8FF,SR
            movem.l (SP)+,D2-D7
            tst.w   D0
            rts
mDoFormat:
            move.l  (SP)+,DskRtnAdr
            moveq   #1,D0
            tst.w   D5
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l ($148,A1),A0
            movea.l (A0),A0
            move.l  A0,($1C,A1)
            movea.l IWM,A4
            lea     (A4),A3
            lea     ($1E00,A4),A4
            tst.b   ($1400,A3)
            move.b  #$18,($C00,A3)
            move.b  #$10,($E00,A3)
            move.b  #1,($E00,A3)
            move.b  #1,($C00,A3)
            moveq   #$4E,D1
            move.b  D1,(A3)
            move.b  D1,(A3)
            move.b  #8,($E00,A3)
            move.w  #$34BC,D3
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            move.b  (A4),D0
            bpl.b   .L3
            move.b  D1,(A3)
            btst    #3,D0
            beq.b   .L4
            dbra    D3,.L2
            bra.w   .L44
.L4:
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            move.b  (A4),D0
            bpl.b   .L5
            move.b  D1,(A3)
            btst    #3,D0
            bne.b   .L6
            dbra    D3,.L4
            bra.w   .L44
.L6:
            move.b  #$F5,($800,A3)
            moveq   #$4E,D0
.L7:
            tst.b   (A5)
            bmi.b   .L8
            move.b  (A6),-(SP)
.L8:
            tst.b   (A4)
            bpl.b   .L8
            move.b  D1,(A3)
            dbra    D0,.L7
            moveq   #$B,D0
            moveq   #0,D1
.L9:
            tst.b   (A5)
            bmi.b   .L10
            move.b  (A6),-(SP)
.L10:
            tst.b   (A4)
            bpl.b   .L10
            move.b  D1,(A3)
            dbra    D0,.L9
            moveq   #2,D0
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            tst.b   (A4)
            bpl.b   .L12
            move.b  #$C2,($200,A3)
            dbra    D0,.L11
.L13:
            tst.b   (A4)
            bpl.b   .L13
            move.b  #$FC,(A3)
            moveq   #$31,D0
.L14:
            tst.b   (A5)
            bmi.b   .L15
            move.b  (A6),-(SP)
.L15:
            tst.b   (A4)
            bpl.b   .L15
            move.b  #$4E,(A3)
            dbra    D0,.L14
            moveq   #1,D6
            bra.b   .L19
.L16:
            moveq   #$4F,D0
            tst.l   D2
            bpl.b   .L17
            moveq   #$64,D0
.L17:
            tst.b   (A5)
            bmi.b   .L18
            move.b  (A6),-(SP)
.L18:
            tst.b   (A4)
            bpl.b   .L18
            move.b  #$4E,(A3)
            dbra    D0,.L17
.L19:
            moveq   #$B,D0
            moveq   #0,D1
.L20:
            tst.b   (A5)
            bmi.b   .L21
            move.b  (A6),-(SP)
.L21:
            tst.b   (A4)
            bpl.b   .L21
            move.b  D1,(A3)
            dbra    D0,.L20
            moveq   #2,D0
.L22:
            tst.b   (A5)
            bmi.b   .L23
            move.b  (A6),-(SP)
.L23:
            tst.b   (A4)
            bpl.b   .L23
            move.b  #$A1,($200,A3)
            dbra    D0,.L22
.L24:
            tst.b   (A4)
            bpl.b   .L24
            move.b  #$FE,(A3)
            tst.b   (A5)
            bmi.b   .L25
            move.b  (A6),-(SP)
.L25:
            tst.b   (A4)
            bpl.b   .L25
            move.b  D4,(A3)
            tst.b   (A5)
            bmi.b   .L26
            move.b  (A6),-(SP)
.L26:
            tst.b   (A4)
            bpl.b   .L26
            move.b  D5,(A3)
            tst.b   (A5)
            bmi.b   .L27
            move.b  (A6),-(SP)
.L27:
            tst.b   (A4)
            bpl.b   .L27
            move.b  D6,(A3)
            tst.b   (A5)
            bmi.b   .L28
            move.b  (A6),-(SP)
.L28:
            tst.b   (A4)
            bpl.b   .L28
            move.b  #2,(A3)
            tst.b   (A5)
            bmi.b   .L29
            move.b  (A6),-(SP)
.L29:
            tst.b   (A4)
            bpl.b   .L29
            move.b  D0,($400,A3)
            moveq   #$15,D0
.L30:
            tst.b   (A5)
            bmi.b   .L31
            move.b  (A6),-(SP)
.L31:
            tst.b   (A4)
            bpl.b   .L31
            move.b  #$4E,(A3)
            dbra    D0,.L30
            moveq   #$B,D0
            moveq   #0,D1
.L32:
            tst.b   (A5)
            bmi.b   .L33
            move.b  (A6),-(SP)
.L33:
            tst.b   (A4)
            bpl.b   .L33
            move.b  D1,(A3)
            dbra    D0,.L32
            moveq   #2,D0
.L34:
            tst.b   (A5)
            bmi.b   .L35
            move.b  (A6),-(SP)
.L35:
            tst.b   (A4)
            bpl.b   .L35
            move.b  #$A1,($200,A3)
            dbra    D0,.L34
.L36:
            tst.b   (A4)
            bpl.b   .L36
            move.b  #$FB,(A3)
            move.w  #$1FF,D0
.L37:
            tst.b   (A5)
            bmi.b   .L38
            move.b  (A6),-(SP)
.L38:
            tst.b   (A4)
            bpl.b   .L38
            move.b  (A0)+,(A3)
            dbra    D0,.L37
.L39:
            tst.b   (A4)
            bpl.b   .L39
            move.b  D0,($400,A3)
            addq.w  #1,D6
            dbra    D2,.L16
            moveq   #4,D0
            moveq   #$4E,D1
            move.w  #$3E8,D3
            tst.w   D5
            bne.b   .L41
            moveq   #4,D3
            bra.b   .L41
.L40:
            move.b  #$F4,($800,A3)
.L41:
            tst.b   (A5)
            bmi.b   .L42
            move.b  (A6),-(SP)
.L42:
            move.b  (A4),D2
            bpl.b   .L42
            move.b  D1,(A3)
            subq.w  #1,D0
            bgt.b   .L43
            beq.b   .L40
            btst    #3,D2
            bne.b   .L45
.L43:
            dbra    D3,.L41
            tst.w   D5
            beq.b   .L45
.L44:
            moveq   #-$53,D0
            bra.b   .L46
.L45:
            moveq   #0,D0
            btst    #5,D2
            beq.b   .L46
            moveq   #wrUnderrun,D0
.L46:
            move.b  #$18,($C00,A3)
            move.l  DskRtnAdr,-(SP)
            tst.w   D0
            rts
.L47:
            dc.w    $0003,$0609,$0104,$070A,$0205,$080B,$0003,$0609
            dc.w    $0104,$070A,$0205,$0800,$0005,$0308,$0106,$0409
            dc.b    $02,$07,$00,$00,$00,$07,$05,$03,$01,$08,$06,$04,$02
            ds.b    4
            dc.b    $02,$04,$06,$01,$03,$05,$07
            ds.b    4
.L48:
            dc.w    $0006,$0107,$0208,$0309,$040A,$050B,$0006,$0107
            dc.w    $0208,$0309,$040A,$0500,$0005,$0106,$0207,$0308
            dc.b    $04,$09,$00,$00,$00,$05,$01,$06,$02,$07,$03,$08,$04
            ds.b    4
            dc.b    $04,$01,$05,$02,$06,$03,$07
            ds.b    4
.L49:
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
            dc.w    $9697,$9A9B,$9D9E,$9FA6,$A7AB,$ACAD,$AEAF,$B2B3
            dc.w    $B4B5,$B6B7,$B9BA,$BBBC,$BDBE,$BFCB,$CDCE,$CFD3
            dc.w    $D6D7,$D9DA,$DBDC,$DDDE,$DFE5,$E6E7,$E9EA,$EBEC
            dc.w    $EDEE,$EFF2,$F3F4,$F5F6,$F7F9,$FAFB,$FCFD,$FEFF
.L50:
            andi    #$F8FF,SR
            move.w  ($112,A1),D0
            cmp.w   ($12,A1),D0
            beq.b   .L51
            moveq   #$A,D0
            bsr.w   WakeUp_SonyRWT
.L51:
            movea.l IWM,A0
            tst.b   (A0)
            tst.b   ($800,A0)
            cmpi.b  #2,(3,A1,D1.w)
            bge.b   sub_4086FC5C.L1
            lea     sub_4086FC5C,A0
            move.l  A0,($1BE,A1)
            bra.w   sub_40870446.L2
sub_4086FC5C:
            bne.w   .L15
            bsr.w   GetDrive
            move.b  #8,(3,A1,D1.w)
            move.l  ($1C8,A1),($16,A1,D1.w)
            move.l  ($1CC,A1),D0
            swap    D0
            move.l  D0,($12,A1,D1.w)
            clr.b   ($14,A1,D1.w)
            lsr.w   #8,D0
            move.b  D0,($1A,A1,D1.w)
            btst    #3,D0
            sne     (2,A1,D1.w)
            btst    #4,D0
            beq.b   .L1
            move.b  #2,(3,A1,D1.w)
.L1:
            movea.l (A1),A2
            move.l  ($10,A2),D5
            moveq   #9,D1
            lsr.l   D1,D5
            movea.l (8,A2),A0
            movea.l ($F4,A1),A5
            movea.l ($20,A0),A4
            move.l  ($24,A0),D3
            moveq   #-$32,D0
            andi.w  #$1FF,D3
            bne.w   .L15
            move.l  ($24,A0),D3
            tst.b   DskVerify
            beq.b   .L2
            bsr.w   CheckRead
            bne.b   .L2
            move.l  D3,($28,A0)
            add.l   D3,($10,A2)
            moveq   #0,D0
            bra.w   .L15
.L2:
            bsr.w   sub_40870722
            nop
            nop
.L3:
            moveq   #9,D1
            lsr.l   D1,D3
            moveq   #0,D0
            subq.b  #1,D0
            cmp.l   D0,D3
            blt.b   .L4
            move.l  D0,D3
.L4:
            move.w  D3,D2
            swap    D3
            move.w  D2,D3
            move.b  #3,($2D,A1)
            clr.b   ($1E5,A1)
.L5:
            bsr.w   sub_4086FDEE
            bsr.w   sub_4086FE1A
            bne.b   .L8
.L6:
            bsr.w   sub_4086FDAA
            bpl.b   .L7
            move.b  #2,($1E4,A1)
            clr.l   ($1E0,A1)
            move.b  #$40,($1E0,A1)
            bra.b   .L8
.L7:
            bsr.w   sub_4086FEC4
            beq.b   .L6
            add.l   D4,D5
            tst.w   D0
            beq.b   .L13
.L8:
            subq.b  #1,($2D,A1)
            blt.b   .L11
            beq.b   .L9
            cmpi.b  #2,($1E4,A1)
            bne.b   .L10
            btst    #$1E,($1E0,A1)
            bne.b   .L10
            tst.b   ($1E5,A1)
            beq.b   .L9
            clr.b   ($2D,A1)
.L9:
            bsr.w   sub_408703E6
            bne.b   .L11
            st      ($1E5,A1)
.L10:
            bra.b   .L5
.L11:
            moveq   #-$13,D0
            cmpi.b  #2,($33,A1)
            beq.b   .L12
            moveq   #-$14,D0
.L12:
            bra.b   .L15
.L13:
            moveq   #9,D1
            clr.w   D3
            swap    D3
            cmpi.b  #2,($33,A1)
            beq.b   .L14
            add.l   D3,BufTgFFlg
.L14:
            lsl.l   D1,D3
            movea.l (A1),A3
            add.l   D3,($10,A3)
            movea.l (8,A3),A0
            add.l   D3,($28,A0)
            move.l  ($24,A0),D3
            sub.l   ($28,A0),D3
            bgt.w   .L3
            moveq   #0,D0
.L15:
            movea.l IWM,A0
            bsr.w   sub_40870730
            andi    #$F8FF,SR
            bra.w   sub_4086CA2A.L9
sub_4086FDAA:
            movea.l (SP)+,A3
.L1:
            moveq   #$64,D0
            movea.l VIA,A2
            lea     (vBufA,A2),A2
.L2:
            move.b  (A2),(A2)
            tst.b   ($1A00,A0)
            tst.b   ($1C00,A0)
            dbpl    D0,.L2
            bpl.b   .L3
            subq.w  #1,($1E8,A1)
            bmi.b   .L3
            move.w  ($1E6,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L1
.L3:
            jmp     (A3)
sub_4086FDD8:
            move.l  A2,-(SP)
            movea.l VIA,A2
            lea     ($1E00,A2),A2
            moveq   #$10,D0
.L1:
            move.b  (A2),(A2)
            dbra    D0,.L1
            movea.l (SP)+,A2
            rts
sub_4086FDEE:
            move.l  D5,D0
            lsl.l   #8,D0
            move.l  D0,($1C4,A1)
            move.b  D3,($1C3,A1)
            move.w  #$A,($1E6,A1)
            move.w  #$2710,($1E8,A1)
            move.l  #$200,D6
            moveq   #0,D7
            andi.b  #$3F,($1C2,A1)
            bne.b   .L1
            exg     D6,D7
.L1:
            rts
sub_4086FE1A:
            move.l  jSendCmd,-(SP)
            rts
            movea.l IWM,A0
            lea     ($1800,A0),A3
            move.l  D6,($1DC,A1)
            add.l   D7,($1DC,A1)
            move.b  ($1C2,A1),D1
            cmpi.b  #3,D1
            bge.b   .L2
            tst.b   D1
            bne.b   .L1
            addi.w  #$14,D7
            bra.b   .L2
.L1:
            addi.w  #$14,D6
            move.l  A5,D0
            bne.b   .L2
            lea     ($1C8,A1),A1
            move.l  BufTgFNum,(A1)+
            move.l  BufTgFFlg,(A1)+
            move.l  BufTgDate,(A1)+
            move.l  ($38A).w,(A1)+
            move.l  ($38E).w,(A1)+
            movea.l SonyVars,A1
.L2:
            addq.w  #6,D6
            divu.w  #7,D6
            andi.w  #$7F,D6
            addq.w  #6,D7
            divu.w  #7,D7
            andi.w  #$7F,D7
            moveq   #0,D4
            bra.b   .L4
.L3:
            tst.b   D1
            beq.b   .L6
            ori.b   #$40,($1C2,A1)
            move.b  D3,($1C3,A1)
            addq.l  #1,($1CC,A1)
            move.w  #7,($1E6,A1)
            move.w  #$2710,($1E8,A1)
.L4:
            cmpi.b  #3,D1
            bge.b   .L5
            tst.b   D1
            beq.b   .L5
            move.l  A5,D0
            beq.b   .L5
            lea     ($1C8,A1),A1
            move.l  (A5)+,(A1)+
            move.l  (A5)+,(A1)+
            move.l  (A5)+,(A1)+
            movea.l SonyVars,A1
.L5:
            bsr.w   sub_408701B4
            bne.w   sub_4086FEC4.L5
.L6:
            rts
sub_4086FEC4:
            movea.l IWM,A0
            lea     ($1800,A0),A3
            move.b  ($1C2,A1),D1
            andi.b  #$3F,D1
            bsr.w   sub_4086FF7A
            bne.w   .L5
            move.l  ($1C2,A1),D0
            move.b  #$30,D0
            subi.b  #$80,($1C2,A1)
            cmp.b   ($1C2,A1),D1
            bne.b   .L5
            cmpi.b  #3,D1
            bge.b   .L3
            move.b  #$31,D0
            cmp.b   ($1C3,A1),D3
            beq.b   .L1
            swap    D0
            move.b  D3,D0
            swap    D0
            ror.l   #8,D0
            move.b  ($1C3,A1),D0
            rol.l   #8,D0
            bra.b   .L5
.L1:
            tst.b   D1
            bne.b   .L3
            move.l  A5,D0
            beq.b   .L2
            lea     ($1C8,A1),A1
            move.l  (A1)+,(A5)+
            move.l  (A1)+,(A5)+
            move.l  (A1)+,(A5)+
            movea.l SonyVars,A1
.L2:
            lea     ($1C8,A1),A1
            move.l  (A1)+,BufTgFNum
            move.l  (A1)+,BufTgFFlg
            move.l  (A1)+,BufTgDate
            move.l  (A1)+,($38A).w
            move.l  (A1)+,($38E).w
            movea.l SonyVars,A1
.L3:
            moveq   #1,D2
            move.l  ($1C4,A1),D0
            btst    #$18,D0
            bne.b   .L6
            cmpi.b  #$A,($1C4,A1)
            beq.b   .L6
            adda.l  ($1DC,A1),A4
            addq.l  #1,D4
            subq.b  #1,D3
            bne.w   sub_4086FE1A.L3
            moveq   #0,D0
.L4:
            andi    #$FFFB,SR
            rts
.L5:
            moveq   #2,D2
            ror.l   #8,D0
.L6:
            move.l  D0,($1E0,A1)
            move.b  D2,($1E4,A1)
            moveq   #1,D0
            bra.b   .L4
sub_4086FF7A:
            move    SR,-(SP)
            movem.l D1-D7/A1-A2/A4-A6,-(SP)
            movem.l SCCRd,A5-A6
            bsr.w   sub_40870738
            lea     ($1C2,A1),A1
            moveq   #0,D5
            tst.b   ($1A00,A0)
            moveq   #$20,D0
            tst.b   ($1C00,A0)
            bmi.w   .L35
            movea.l VIA,A2
            lea     ($1E00,A2),A2
            ori     #$700,SR
            tst.b   ($200,A0)
            tst.b   ($400,A0)
            tst.b   (A3)
            moveq   #$21,D0
            moveq   #8,D6
            swap    D6
.L1:
            subq.l  #1,D6
            beq.w   .L35
            cmpi.b  #$AA,(A3)
            bne.b   .L1
            move.w  #$40,D6
.L2:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L2
            bpl.b   .L11
            cmpi.b  #$BF,D1
            bne.b   .L3
            moveq   #6,D7
            swap    D7
.L3:
            swap    D1
.L4:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L4
            bpl.b   .L11
            swap    D1
.L5:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L5
            bpl.b   .L11
            swap    D2
.L6:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L6
            bpl.b   .L11
            swap    D2
.L7:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L7
            bpl.b   .L11
            swap    D3
.L8:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L8
            bpl.b   .L11
            swap    D3
.L9:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L9
            bpl.b   .L11
            swap    D4
.L10:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L10
            bpl.b   .L11
            dbra    D7,.L12
            bra.w   .L28
.L11:
            moveq   #$22,D0
            bra.w   .L35
.L12:
            moveq   #3,D6
            swap    D6
            move.w  #$40,D6
.L13:
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            move.b  D1,(A1)+
.L14:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L14
            bpl.b   .L11
            swap    D1
            move.b  #3,(A6)
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            move.b  D1,(A1)+
.L15:
            move.b  (A2),(A2)
            move.b  (A3),D1
            dbmi    D6,.L15
            bpl.b   .L11
            swap    D1
            tst.w   D7
            beq.b   .L16
            tst.b   (A5)
.L16:
            sne     D0
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            move.b  D2,(A1)+
.L17:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L17
            bpl.b   .L11
            swap    D2
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            move.b  D2,(A1)+
.L18:
            move.b  (A2),(A2)
            move.b  (A3),D2
            dbmi    D6,.L18
            bpl.b   .L11
            swap    D2
            tst.b   D0
            beq.b   .L19
            tst.b   (A0)
.L19:
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            move.b  D3,(A1)+
.L20:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L20
.L21:
            bpl.w   .L11
            swap    D3
            swap    D6
            dbra    D6,.L22
            movea.l A4,A1
.L22:
            swap    D6
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            move.b  D3,(A1)+
.L23:
            move.b  (A2),(A2)
            move.b  (A3),D3
            dbmi    D6,.L23
            bpl.b   .L21
            swap    D3
            lsr.b   #1,D4
            swap    D4
            addx.b  D4,D4
            add.b   D4,D5
            move.b  D4,(A1)+
.L24:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L24
            bpl.b   .L21
            swap    D4
            move.w  #$40,D6
.L25:
            move.b  (A2),(A2)
            move.b  (A3),D4
            dbmi    D6,.L25
            bpl.b   .L21
            tst.b   D0
            dbne    D7,.L13
            beq.b   .L28
            tst.b   (A5)
            andi    #$F8FF,SR
            subq.w  #1,D7
            bsr.w   sub_4086FDD8
            ori     #$700,SR
            tst.b   ($200,A0)
            tst.b   (A3)
            clr.w   D0
.L26:
            subq.w  #1,D0
            beq.b   .L27
            cmpi.b  #$AA,(A3)
            bne.b   .L26
            bra.w   .L13
.L27:
            moveq   #$24,D0
            bra.b   .L35
.L28:
            swap    D7
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            subq.w  #1,D7
            bmi.b   .L29
            move.b  D1,(A1)+
.L29:
            swap    D1
            lsr.b   #1,D4
            addx.b  D1,D1
            add.b   D1,D5
            subq.w  #1,D7
            bmi.b   .L30
            move.b  D1,(A1)+
.L30:
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            subq.w  #1,D7
            bmi.b   .L31
            move.b  D2,(A1)+
.L31:
            swap    D2
            lsr.b   #1,D4
            addx.b  D2,D2
            add.b   D2,D5
            subq.w  #1,D7
            bmi.b   .L32
            move.b  D2,(A1)+
.L32:
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            subq.w  #1,D7
            bmi.b   .L33
            move.b  D3,(A1)+
.L33:
            swap    D3
            lsr.b   #1,D4
            addx.b  D3,D3
            add.b   D3,D5
            subq.w  #1,D7
            bmi.b   .L34
            move.b  D3,(A1)+
.L34:
            lsr.b   #1,D4
            swap    D4
            addx.b  D4,D4
            add.b   D4,D5
            tst.b   ($600,A0)
            tst.b   ($1A00,A0)
            moveq   #$25,D0
            tst.b   ($1C00,A0)
            bpl.b   .L35
            move.b  D5,D0
            beq.b   .L35
            moveq   #$26,D0
.L35:
            tst.b   (A5)
            tst.b   ($600,A0)
            tst.b   (A0)
            movem.l (SP)+,D1-D7/A1-A2/A4-A6
            move    (SP)+,SR
            tst.w   D0
            rts
sub_408701B4:
            move    SR,-(SP)
            movem.l D1-D7/A1/A4-A6,-(SP)
            movem.l SCCRd,A5-A6
            bsr.w   sub_40870738
            lea     ($1C2,A1),A1
            move.b  D1,D4
            swap    D4
            swap    D6
            move.w  D7,D6
            swap    D6
            moveq   #-$80,D0
            moveq   #0,D5
            st      D4
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            swap    D4
            tst.b   ($1A00,A0)
            moveq   #$10,D0
            tst.b   ($1C00,A0)
            bpl.w   .L29
            tst.b   ($200,A0)
            moveq   #$11,D0
            moveq   #$50,D7
            swap    D7
.L1:
            subq.l  #1,D7
            beq.w   .L29
            tst.b   ($1C00,A0)
            bmi.b   .L1
            tst.b   ($400,A0)
            lea     ($1A00,A0),A0
            ori     #$700,SR
            moveq   #2,D7
            cmpi.b  #4,D4
            blt.b   .L2
            moveq   #-1,D7
            movea.l A4,A1
.L2:
            bsr.w   sub_4086FDD8
            move.l  D6,D0
            addi.l  #$810081,D0
            move.b  #$AA,($400,A0)
.L3:
            tst.b   (A3)
            bpl.b   .L3
            move.b  D0,(A0)
            swap    D0
.L4:
            tst.b   (A3)
            bpl.b   .L4
            move.b  D0,(A0)
            moveq   #-$80,D0
            bra.w   .L14
.L5:
            move.b  (A1)+,D4
            add.b   D4,D5
            roxr.b  #1,D4
            or.b    D0,D4
            swap    D4
            roxr.b  #2,D4
.L6:
            tst.b   (A3)
            bpl.b   .L6
            move.b  D4,(A0)
            st      D4
            move.b  #3,(A6)
.L7:
            tst.b   (A3)
            bpl.b   .L7
            move.b  D1,(A0)
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            tst.b   (A5)
            beq.b   .L8
            bset    #$1F,D6
.L8:
            tst.b   (A3)
            bpl.b   .L8
            move.b  D1,(A0)
            move.b  (A1)+,D1
            add.b   D1,D5
            roxr.b  #1,D1
            or.b    D0,D1
            roxr.b  #1,D4
            swap    D1
            tst.w   D6
            bne.b   .L9
            bclr    #$1F,D6
.L9:
            tst.b   (A3)
            bpl.b   .L9
            move.b  D2,(A0)
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
            btst    #$1F,D6
            beq.b   .L10
            tst.b   (-$1A00,A0)
.L10:
            tst.b   (A3)
            bpl.b   .L10
            move.b  D2,(A0)
            move.b  (A1)+,D2
            add.b   D2,D5
            roxr.b  #1,D2
            or.b    D0,D2
            roxr.b  #1,D4
            swap    D2
.L11:
            tst.b   (A3)
            bpl.b   .L11
            move.b  D3,(A0)
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            dbra    D7,.L12
            movea.l A4,A1
.L12:
            tst.b   (A3)
            bpl.b   .L12
            move.b  D3,(A0)
            move.b  (A1)+,D3
            add.b   D3,D5
            roxr.b  #1,D3
            or.b    D0,D3
            roxr.b  #1,D4
            swap    D3
            swap    D4
.L13:
            tst.b   (A3)
            bpl.b   .L13
            move.b  D4,(A0)
            bclr    #$1F,D6
            bne.b   .L15
.L14:
            dbra    D6,.L5
            bra.b   .L17
.L15:
            clr.b   D0
.L16:
            tst.b   (A3)
            bpl.b   .L16
            move.b  D0,(A0)
            andi    #$F8FF,SR
            bsr.w   sub_4086FDD8
            subq.w  #1,D6
            tst.b   ($200,A0)
            tst.b   (-$200,A0)
            tst.b   (A0)
            tst.b   (-$1800,A0)
            bsr.w   sub_4086FDD8
            moveq   #-$80,D0
            ori     #$700,SR
            move.b  #$AA,($400,A0)
            bra.w   .L5
.L17:
            neg.b   D5
            roxr.b  #1,D5
            or.b    D0,D5
            swap    D4
            roxr.b  #2,D4
.L18:
            tst.b   (A3)
            bpl.b   .L18
            move.b  D4,(A0)
.L19:
            tst.b   (A3)
            bpl.b   .L19
            move.b  D1,(A0)
            swap    D1
.L20:
            tst.b   (A3)
            bpl.b   .L20
            move.b  D1,(A0)
.L21:
            tst.b   (A3)
            bpl.b   .L21
            move.b  D2,(A0)
            swap    D2
.L22:
            tst.b   (A3)
            bpl.b   .L22
            move.b  D2,(A0)
.L23:
            tst.b   (A3)
            bpl.b   .L23
            move.b  D3,(A0)
            swap    D3
.L24:
            tst.b   (A3)
            bpl.b   .L24
            move.b  D3,(A0)
.L25:
            tst.b   (A3)
            bpl.b   .L25
            move.b  D5,(A0)
.L26:
            tst.b   (A3)
            bpl.b   .L26
            moveq   #0,D0
            move.b  D0,(A0)
.L27:
            tst.b   (A3)
            bpl.b   .L27
            move.b  D0,(A0)
            movea.l IWM,A0
            tst.b   ($600,A0)
            moveq   #$13,D0
            moveq   #-1,D7
.L28:
            subq.w  #1,D7
            beq.b   .L29
            tst.b   ($1C00,A0)
            bpl.b   .L28
            moveq   #0,D0
.L29:
            tst.b   ($600,A0)
            tst.b   (A0)
            movem.l (SP)+,D1-D7/A1/A4-A6
            move    (SP)+,SR
            tst.w   D0
            rts
sub_408703E6:
            move.l  jDCDReset,-(SP)
            rts
            movea.l (SP)+,A3
            bsr.w   SetChipMode
            bsr.w   sub_4086D716
            tst.b   ($A00,A0)
            tst.b   ($400,A0)
            tst.b   (A0)
            move.w  #$3E8,D0
            bsr.w   WakeUp_SonyRWT
            tst.b   ($600,A0)
            tst.b   ($800,A0)
            move.w  #$4E20,D0
            bsr.w   WakeUp_SonyRWT
            move.w  #$64,($1E6,A1)
            move.w  #$640,($1E8,A1)
.L1:
            bsr.w   Sense
            bmi.b   .L2
            subq.w  #1,($1E8,A1)
            bmi.b   .L3
            move.w  ($1E6,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L1
.L2:
            moveq   #0,D0
            jmp     (A3)
.L3:
            tst.b   ($1800,A0)
            moveq   #-1,D0
            jmp     (A3)
sub_40870446:
            bne.b   .L1
            lea     ($216,A1),A2
            movea.l (A1),A0
            movea.l (8,A0),A0
            move.l  A2,($1C,A0)
.L1:
            bra.w   sub_4086FC5C.L15
            bne.w   sub_4086CA2A.L9
            btst    #2,($1A,A1,D1.w)
            beq.w   sub_4086CA2A.L8
            lea     sub_40870446,A0
            move.l  A0,($1BE,A1)
.L2:
            moveq   #3,D3
            bra.b   sub_40870474.L2
sub_40870474:
            moveq   #$1A,D3
            bra.b   .L2
.L1:
            moveq   #$19,D3
.L2:
            bsr.w   sub_40870754
            tst.b   (A0)
            tst.b   ($800,A0)
            clr.b   ($1E5,A1)
            move.b  D3,($1C2,A1)
.L3:
            movea.l SonyVars,A1
            andi.b  #$3F,($1C2,A1)
            suba.l  A4,A4
            suba.l  A5,A5
            moveq   #1,D3
            moveq   #0,D6
            moveq   #0,D7
            move.w  #$64,($1E6,A1)
            move.w  #$4650,($1E8,A1)
            cmpi.b  #3,($1C2,A1)
            bne.b   .L4
            move.l  #$14C,D7
            move.w  #$A,($1E6,A1)
            move.w  #$2710,($1E8,A1)
            lea     ($1EA,A1),A4
.L4:
            bsr.w   sub_4086FE1A
            beq.b   .L7
.L5:
            cmpi.b  #2,($1E0,A1)
            beq.b   .L6
            btst    #$1E,($1E0,A1)
            beq.b   .L6
            bset    #1,($1E5,A1)
            bne.b   .L3
.L6:
            bset    #0,($1E5,A1)
            bne.b   .L8
            bsr.w   sub_408703E6
            bne.b   .L8
            bra.b   .L3
.L7:
            bsr.w   sub_4086FDAA
            bmi.b   .L5
            bsr.w   sub_4086FEC4
            tst.w   D0
            bne.b   .L5
            moveq   #0,D0
            bra.b   .L9
.L8:
            moveq   #-$11,D0
.L9:
            andi.b  #$3F,($1C2,A1)
            cmpi.b  #3,($1C2,A1)
            bne.w   sub_4086FC5C.L15
            movea.l ($1BE,A1),A0
            tst.w   D0
            jmp     (A0)
            tst.w   D0
            bne.w   sub_4086CA2A.L9
            lea     (-$200,SP),SP
            move.l  SP,($1C,A1)
            lea     ($1C,A0),A0
            move.l  A0,($22,A1)
            clr.l   ($C,A0)
            move.l  (A0)+,D0
            or.l    (A0)+,D0
            beq.b   .L11
            addq.w  #8,A0
            moveq   #-$32,D0
            move.w  (A0)+,D7
            cmpi.w  #3,D7
            bhi.b   .L11
            bne.b   .L10
            tst.b   ($17,A1,D1.w)
            bmi.b   .L10
            clr.w   (-2,A0)
.L10:
            move.w  (A0)+,D2
            cmpi.w  #$50,D2
            bcc.b   .L11
            rol.w   #8,D2
            move.b  (A0)+,D2
            cmpi.b  #2,D2
.L11:
            bcc.w   .L19
            asl.b   #3,D2
            rol.w   #8,D2
            move.w  D2,($16,A1)
            moveq   #0,D2
            move.b  (A0)+,D2
            move.w  D2,($FE,A1)
            bsr.w   sub_408708E4
            tst.b   ($138,A1)
            bpl.b   .L12
            bsr.w   SetChipMode
            bne.w   .L19
.L12:
            bsr.w   sub_4086D716
            bsr.w   sub_4086EA80
            bsr.w   sub_4086E768
            bne.b   .L19
            moveq   #4,D0
            bsr.w   SetUpPoll
            movea.l ($22,A1),A0
            move.w  ($10,A0),D7
            cmpi.w  #3,D7
            bne.b   .L13
            bsr.b   sub_40870614
            beq.b   .L17
            bra.b   .L18
.L13:
            tst.w   D7
            beq.b   .L17
            move.w  #$FF,D6
.L14:
            bsr.w   RdAddrSetup
            bmi.b   .L15
            cmp.w   ($16,A1),D1
            bne.b   .L15
            cmp.w   ($FE,A1),D2
            beq.b   .L16
.L15:
            bsr.w   toEmptyPD
            dbra    D6,.L14
            moveq   #-$51,D0
            bra.b   .L19
.L16:
            subq.w  #1,D7
            beq.b   .L17
            movea.l ($1C,A1),A0
            clr.b   DskVerify
            bsr.w   RdData
            bmi.b   .L19
.L17:
            bsr.b   sub_4087065E
            bne.b   .L18
            movea.l SonyVars,A1
            movea.l ($22,A1),A1
            move.l  (8,A1),($C,A1)
.L18:
            bsr.w   toEmptyPD
            andi    #$F8FF,SR
.L19:
            lea     ($200,SP),SP
            bra.w   DskRWOff
sub_40870614:
            move.l  (SP)+,DskRtnAdr
            moveq   #$E,D0
            bsr.w   AdrDisk
            moveq   #$6E,D2
            tst.b   ($18,A1,D1.w)
            bmi.b   .L1
            add.w   D2,D2
.L1:
            mulu.w  TimeDBRA,D2
            movea.l IWM,A4
            lea     ($1E00,A4),A4
            moveq   #0,D0
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            btst    #3,(A4)
            beq.b   .L4
            subq.l  #1,D2
            bgt.b   .L2
            bra.b   .L6
.L4:
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            btst    #3,(A4)
            bne.b   .L7
            subq.l  #1,D2
            bgt.b   .L4
.L6:
            moveq   #-$53,D0
.L7:
            bra.w   sub_4086D7F2
sub_4087065E:
            bsr.w   GetDrv1
            moveq   #1,D0
            btst    #3,($16,A1)
            beq.b   .L1
            moveq   #3,D0
.L1:
            bsr.w   AdrDisk
            movea.l ($22,A1),A4
            movea.l (A4)+,A2
            movea.l (A4)+,A0
            move.l  (A4)+,D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L10
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     ($1E00,A4),A3
            lea     ($1200,A4),A4
            tst.b   ($200,A4)
            move.b  #$18,(-$600,A4)
            move.b  #1,(-$400,A4)
            move.b  #1,(-$600,A4)
            tst.b   ($200,A4)
            move.b  #8,(-$400,A4)
            moveq   #-1,D2
            bra.b   .L4
.L2:
            tst.b   (A5)
            bmi.b   .L3
            move.b  (A6),-(SP)
.L3:
            move.b  (A3),D3
            dbmi    D2,.L2
            bpl.b   .L9
            moveq   #$1E,D2
            move.b  (A4),(A0)+
            lsr.b   #1,D3
            addx.b  D1,D1
            bcc.b   .L5
            move.b  D1,(A2)+
.L4:
            moveq   #1,D1
.L5:
            subq.l  #1,D0
            bge.b   .L2
            cmpi.b  #1,D1
            beq.b   .L7
.L6:
            add.b   D1,D1
            bcc.b   .L6
            move.b  D1,(A2)+
.L7:
            moveq   #0,D0
.L8:
            move.b  #$18,(-$600,A4)
            bra.w   sub_4086D7F2
.L9:
            moveq   #-$42,D0
            bra.b   .L8
.L10:
            move.l  (SP)+,DskRtnAdr
            movea.l IWM,A4
            lea     ($1800,A4),A4
            moveq   #-1,D2
            bra.b   .L13
.L11:
            tst.b   (A5)
            bmi.b   .L12
            move.b  (A6),-(SP)
.L12:
            move.b  (A4),D1
            dbmi    D2,.L11
            bpl.b   .L15
            move.b  D1,(A0)+
            moveq   #$1E,D2
.L13:
            subq.l  #1,D0
            bge.b   .L11
            moveq   #0,D0
.L14:
            bra.w   sub_4086D7F2
.L15:
            moveq   #-$42,D0
            bra.b   .L14
sub_40870722:
            move.b  ($33,A1),($1C2,A1)
            subq.b  #2,($1C2,A1)
            bra.w   sub_4087091A
sub_40870730:
            tst.b   ($1000,A0)
            bra.w   sub_408708C8
sub_40870738:
            addq.w  #2,A5
            addq.w  #2,A6
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            moveq   #2,D0
            and.b   ($13A,A1),D0
            bne.b   .L1
            lea     .L2,A5
.L1:
            rts
.L2:
            dc.w    0
sub_40870754:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            bsr.w   sub_408708E4
            bsr.w   sub_4087091A
.L1:
            tst.b   ($138,A1)
            bpl.b   .L2
            bsr.w   SetChipMode
.L2:
            bsr.w   sub_4086D716
            rts
sub_40870774:
            move.l  A0,-(SP)
            lea     (8,SP),A0
            move.l  A0,($1C,A1)
            movea.l (SP)+,A0
            bra.w   sub_408708E4
            ext.l   D0
            add.l   A3,D0
            bra.w   sub_4086D8D0.L3
            lea     ($118,A2),A0
            _RmvTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            lea     ($13C,A2),A0
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Dequeue
.L1:
            rts
            move.l  A0,SonyVars
            movea.l A0,A1
            bra.w   sub_408708E4
            lea     ($118,A2),A0
            _InsTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            lea     ($13C,A2),A0
            clr.w   ($A,A0)
            move.w  #$10,(4,A0)
            lea     sub_40870938,A1
            move.l  A1,(6,A0)
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Enqueue
.L2:
            rts
            bsr.w   sub_408708C8
            clr.b   ($19,A1)
            rts
sub_408707EE:
            move.l  A0,-(SP)
            lea     (8,SP),A0
            move.l  A0,($1C,A1)
            movea.l (SP)+,A0
            bra.w   sub_408708E4
sub_408707FE:
            bmi.w   DskRWOff.L9
            bra.w   sub_408708E4
.L1:
            tst.b   ($13,A1,D1.w)
            bpl.b   .L3
            subq.w  #1,D7
.L2:
            moveq   #4,D0
            bsr.w   AdrAndSense
            bpl.w   Recal.L3
            bsr.w   Pulse
            bsr.w   Wait100
            dbra    D7,.L2
            bra.w   Recal.L4
.L3:
            move.w  ($3C,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.w   Recal.L2
sub_40870834:
            move.w  ($40,A1),($A,A0)
            bra.w   sub_408708E4
sub_4087083E:
            tst.b   ($1000,A0)
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            tst.l   D3
            bmi.w   .L1
            bra.b   sub_408708C8
.L1:
            addq.l  #4,SP
            bra.w   sub_4086D7FA.L4
.L2:
            rts
.L3:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L4
            addq.b  #1,(3,A1,D1.w)
            bpl.w   sub_4086D848.L2
            bset    #$1F,D3
            bra.w   sub_4086D848.L7
.L4:
            addq.b  #1,(3,A1,D1.w)
            bmi.w   sub_4086D848.L7
            bra.w   sub_4086D848.L2
sub_4087087E:
            st      ($19,A0)
            movea.l A0,A1
            bra.b   sub_408708E4
sub_40870886:
            lea     ($118,A2),A0
            _InsTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            lea     ($13C,A2),A0
            clr.w   ($A,A0)
            move.w  #$10,(4,A0)
            lea     sub_40870938,A1
            move.l  A1,(6,A0)
            _SleepQInstall
.L1:
            rts
sub_408708AE:
            clr.b   ($19,A1)
            bra.b   sub_408708C8
.L1:
            clr.b   ($19,A1)
            movea.l (A1),A1
            move.l  JIODone,-(SP)
            rts
sub_408708C0:
            bsr.b   sub_408708E4
            tst.b   (3,A1,D1.w)
            rts
sub_408708C8:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   sub_408708E4.L3
            movem.l D0/A0,-(SP)
            moveq   #1,D0
            and.b   ($13A,A1),D0
            beq.b   sub_408708E4.L2
            clr.b   ($13A,A1)
            moveq   #1,D0
            bra.b   sub_408708E4.L1
sub_408708E4:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L3
            movem.l D0/A0,-(SP)
            moveq   #1,D0
            and.b   ($13A,A1),D0
            bne.b   .L2
            move.w  #$81,D0
            move.b  D0,($13A,A1)
.L1:
            move.b  D0,-(SP)
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.l  #$100001,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($E,SP),SP
.L2:
            movem.l (SP)+,D0/A0
.L3:
            rts
sub_4087091A:
            movem.l D0/A0,-(SP)
            pea     ($13A,A1)
            move.l  (SP),-(SP)
            move.l  #$180000,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($C,SP),SP
            movem.l (SP)+,D0/A0
            rts
sub_40870938:
            movem.l D1/A0-A1,-(SP)
            movea.l SonyVars,A1
            cmpi.w  #3,D0
            beq.b   .L2
            moveq   #$5A,D1
            add.l   Ticks,D1
.L1:
            cmp.l   Ticks,D1
            bls.b   .L3
            moveq   #1,D0
            and.b   ($13A,A1),D0
            bne.b   .L1
            bra.b   .L3
.L2:
            moveq   #1,D1
            and.b   ($13A,A1),D1
            bsr.b   sub_408708E4
            movea.l IWM,A0
            move.b  #$F8,($C00,A0)
            tst.b   ($1C00,A0)
            clr.b   ($139,A1)
            bsr.w   SetIWMMode
            tst.b   D1
            beq.b   .L4
            bsr.w   SetChipMode
.L3:
            movem.l (SP)+,D1/A0-A1
            rts
.L4:
            bsr.w   sub_408708C8
            bra.b   .L3
            dc.w    $CFA2,$0078,$0003,$CFA2,$017A,$0103,$CFA2,$CFA2
            dc.w    $0507,$CFA2,$CFA2,$0D07,$CF8A,$0366,$0003,$CF8A
            dc.w    $0264,$0803,$CF8A,$CF8A,$0507,$CF8A,$CF8A,$0D07
            dc.w    $CF72,$0450,$0003,$CF72,$0450,$0103,$CF72,$CF72
            dc.w    $0507,$CF72,$CF72,$0D07,$CF5A,$053A,$0003,$CF5A
            dc.w    $053A,$0103,$CF5A,$CF5A,$0507,$CF5A,$CF5A,$0D07
            dc.w    $CF42,$0624,$0003,$CF42,$0624,$0103,$CF42,$CF42
            dc.w    $0507,$CF42,$CF42,$0D07
            ds.b    38
            dc.w    $0400,0,$0400,0,$0400,0,$1F00,0
            dc.b    $0E,$00,$00,$00,$04
            ds.b    5
            dc.w    $1FFF,$FFF8,$1000,$0008,$1000,$7FC8,$1000,$0008
            dc.w    $1300,$0008,$1000,$0008,$1FFF,$FFF8,$0800,$0010
            dc.w    $0FFF,$FFF0
            ds.b    66
            dc.w    $0400,0,$0400,0,$0400,0,$1F00,0
            dc.b    $0E,$00,$00,$00,$04
            ds.b    5
            dc.w    $1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8
            dc.w    $1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0
            ds.b    81
            dc.b    $10,$00,$00,$00,$10,$00,$00,$00,$10,$FF,$FF,$FC,$7C,$80,$00,$04
            dc.b    $38,$80,$3F,$E4,$10,$80,$00,$04,$00,$A0,$00,$05,$FF,$80,$00,$05
            dc.b    $01,$FF,$FF,$FD,$7D,$40,$00,$09,$01,$7F,$FF,$F9,$FF
            ds.b    83
            dc.b    $10,$00,$00,$00,$10,$00,$00,$00,$10,$FF,$FF,$FC,$7C,$FF,$FF,$FC
            dc.b    $38,$FF,$FF,$FC,$10,$FF,$FF,$FC,$00,$FF,$FF,$FD,$FF,$FF,$FF,$FD
            dc.b    $FF,$FF,$FF,$FD,$FF,$7F,$FF,$F9,$FF,$7F,$FF,$F9,$FF
            ds.b    39
            dc.b    $80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$03
            dc.b    $E0,$00,$00,$01,$C0,$00,$00,$00,$80
            ds.b    6
            dc.w    $FFFF,$FFFF,$8000,$0001,$8FF8,$1FF1,$8000,$0001
            dc.w    $8000,$0001,$FFFF,$FFFF,$2000,$0004,$3FFF,$FFFC
            ds.b    60
            dc.w    $01C0,0,$01C0,0,$01C0,0,$01C0,0
            dc.w    $0FF8,0,$07F0,0,$03E0,0,$01C0,0
            dc.w    $0080,0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$3FFF,$FFFC
            dc.w    $3FFF,$FFFC
            ds.b    68
            dc.w    $0100,0,$0100,0,$0100,0,$0100,0
            dc.b    $07,$C0,$00,$00,$03,$80,$00,$00,$01
            ds.b    5
            dc.w    $FFFF,$FFFF,$8000,$0001,$8000,$1FF1,$8000,$0001
            dc.w    $8000,$0001,$FFFF,$FFFF,$2000,$0004,$3FFF,$FFFC
            ds.b    62
            dc.w    $0380,0,$0380,0,$0380,0,$0380,0
            dc.w    $1FF0,0,$0FE0,0,$07C0,0,$0380,0
            dc.w    $0100,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$3FFF,$FFFC,$3FFF
            dc.w    $FFFC
            ds.b    66
            dc.w    $0FFF,$F000,$0800,$1000,$08FF,$F000,$0880,$1080
            dc.w    $0880,$1180,$08BF,$D3F8,$0880,$1180,$0880,$1080
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $08BF,$D000,$0880,$1000,$08BF,$D000,$0880,$1000
            dc.w    $08BF,$D000,$0880,$1000,$08BF,$D000,$0880,$1000
            dc.b    $08,$BF,$D0,$00,$08,$80,$10,$00,$0F,$FF,$F0
            ds.b    5
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F080
            dc.w    $0FFF,$F180,$0FFF,$F3F8,$0FFF,$F180,$0FFF,$F080
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.b    $0F,$FF,$F0,$00,$0F,$FF,$F0,$00,$0F,$FF,$F0
            ds.b    58
            dc.b    $02,$00,$00,$00,$05,$00,$00,$00,$09,$00,$00,$00,$12,$00,$00,$00
            dc.b    $24,$00,$00,$00,$48,$00,$00,$00,$90,$00,$00,$01,$20,$00,$00,$02
            dc.b    $40,$00,$00,$04,$80,$00,$00,$09,$00,$00,$00,$0E,$00,$00,$00,$1C
            dc.b    $00,$00,$DB,$7E,$00,$01,$FF,$C2,$10,$7F,$00,$42,$30,$80,$3F,$42
            dc.b    $7F,$80,$00,$42,$30,$FF,$FF,$FC,$10
            ds.b    55
            dc.b    $02,$00,$00,$00,$07,$00,$00,$00,$0F,$00,$00,$00,$1E,$00,$00,$00
            dc.b    $3C,$00,$00,$00,$78,$00,$00,$00,$F0,$00,$00,$01,$E0,$00,$00,$03
            dc.b    $C0,$00,$00,$07,$80,$00,$00,$0F,$00,$00,$00,$0E,$00,$00,$00,$1C
            dc.b    $00,$00,$DB,$7E,$00,$01,$FF,$FE,$10,$7F,$FF,$FE,$30,$FF,$FF,$FE
            dc.b    $7F,$FF,$FF,$FE,$30,$FF,$FF,$FC,$10
            ds.b    18
            dc.w    $1FFF,$8000,$1000,$8000,$1000,$8000,$17A0,$8000
            dc.w    $1020,$8400,$17A0,$8C00,$1020,$9FC0,$17A0,$8C00
            dc.w    $1020,$8400,$17A6,$8000,$1026,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1782,$8000
            dc.b    $10,$00,$80,$00,$17,$82,$80,$00,$10,$00,$80,$00,$1F,$FF,$80
            ds.b    17
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8400,$1FFF,$8C00,$1FFF,$9FC0,$1FFF,$8C00
            dc.w    $1FFF,$8400,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    0
sub_40871114:
            movea.l A1,A2
            movea.l SonyVars,A1
            lea     (-$48,A1),A3
            bsr.w   CheckIfSecure
            bne.b   .L1
            moveq   #-$24,D0
            addq.w  #4,SP
            bra.w   DiskIODone
.L1:
            rts
sub_4087112E:
            movea.l SonyVars,A1
            cmpi.w  #7,($1A,A0)
            beq.b   .L1
            bsr.w   CheckIfSecure
            bne.b   .L1
            moveq   #-$24,D0
            addq.w  #4,SP
            bra.w   DiskIODone
.L1:
            movea.l (0,A1,A2.l),A2
            move.w  (A2)+,D1
            move.w  (A2)+,D0
            move.w  ($1A,A0),D2
            rts
CheckIfSecure:
            bsr.b   CheckForCabooseKeyswitch
            beq.b   .L1
            rts
.L1:
            move.l  A1,D0
            movea.l VIA2,A1
            btst    #0,(A1)
            movea.l D0,A1
            rts
sub_4087116A:
            cmpi.b  #1,D2
            bne.b   .L2
            bsr.b   CheckIfSecure
            bne.b   .L1
            bsr.w   UpdateDriveStatus
            move.b  #2,D2
            bra.b   .L2
.L1:
            moveq   #0,D0
.L2:
            rts
CheckForCabooseKeyswitch:
            move.l  D0,-(SP)
            move.l  #$C0000,D0
            and.l   UnivROMFlags,D0
            subi.l  #$40000,D0
            movem.l (SP)+,D0
            rts
            ds.b    6918

            EVEN
