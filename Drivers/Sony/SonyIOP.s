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
            lea     DrvTbl,A3
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
            lea     ControlDecode,A3
            moveq   #-$11,D0
            moveq   #$A,D1
            bsr.w   sub_4086C578
            lea     (-$150,A1),A2
            lea     StatusDecode,A3
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
StatusDecode:
            dc.w    $0006                           ; FmtLstCode
            dc.b    $06,$E0                         ; IOP request kind, flags
            dc.w    IopGetFormatList-RsrcDRVR_4
            dc.w    $0008                           ; DrvStsCode
            dc.b    $06,$A0                         ; IOP request kind, flags
            dc.w    IopDriveStatus-RsrcDRVR_4
            dc.w    $000A                           ; MFMStsCode
            dc.b    $06,$A0                         ; IOP request kind, flags
            dc.w    IopMFMStatus-RsrcDRVR_4
            dc.w    'DV'                            ; DupVerSts
            dc.b    $10,$20                         ; IOP request kind, flags
            dc.w    IopDupVersion-RsrcDRVR_4
            dc.w    'SC'                            ; FmtByteSts
            dc.b    $10,$20                         ; IOP request kind, flags
            dc.w    IopGetFmtByte-RsrcDRVR_4
ControlDecode:
            dc.w    $0001                           ; killCode
            dc.b    $00,$00                         ; IOP request kind, flags
            dc.w    IopCtlKillIO-RsrcDRVR_4
            dc.w    $0005                           ; VerifyCC
            dc.b    $09,$E0                         ; IOP request kind, flags
            dc.w    IopCtlDone-RsrcDRVR_4
            dc.w    $0006                           ; FormatCC
            dc.b    $08,$C0                         ; IOP request kind, flags
            dc.w    IopCtlFormat-RsrcDRVR_4
            dc.w    $0007                           ; EjectCode
            dc.b    $07,$E0                         ; IOP request kind, flags
            dc.w    IopCtlEject-RsrcDRVR_4
            dc.w    $0008                           ; tgBuffCode
            dc.b    $0E,$20                         ; IOP request kind, flags
            dc.w    IopCtlDone-RsrcDRVR_4
            dc.w    $0009                           ; TCacheCC
            dc.b    $0D,$20                         ; IOP request kind, flags
            dc.w    IopCtlDone-RsrcDRVR_4
            dc.w    $0015                           ; IconCC
            dc.b    $06,$E0                         ; IOP request kind, flags
            dc.w    IopCtlPhysIcon-RsrcDRVR_4
            dc.w    $0016                           ; IconLogCC
            dc.b    $06,$E0                         ; IOP request kind, flags
            dc.w    IopCtlLogIcon-RsrcDRVR_4
            dc.w    $0017                           ; InfoCC
            dc.b    $06,$E0                         ; IOP request kind, flags
            dc.w    IopCtlDrvInfo-RsrcDRVR_4
            dc.w    'SC'                            ; FmtCopyCC
            dc.b    $08,$C0                         ; IOP request kind, flags
            dc.w    IopCtlFmtCopy-RsrcDRVR_4
            dc.w    'GD'                            ; GetRawDataCC
            dc.b    $11,$C0                         ; IOP request kind, flags
            dc.w    IopCtlGetRawData-RsrcDRVR_4
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
IopCtlEject:
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
            dc.l    38965                           ; HD-20
            dc.b    $40,0,0,0                       ;  THS invalid, current disk has this format
            dc.l    400*2                           ; 400K GCR
            dc.b    $81,10                          ;  THS valid, SD, 1 head; 10 sectors (average)
            dc.w    80                              ;  80 tracks
            dc.l    800*2                           ; 800K GCR
            dc.b    $82,10                          ;  THS valid, SD, 2 heads; 10 sectors (average)
            dc.w    80                              ;  80 tracks
            dc.l    720*2                           ; 720K (1M) MFM
            dc.b    $82,9                           ;  THS valid, SD, 2 heads; 9 sectors
            dc.w    80                              ;  80 tracks
            dc.l    1440*2                          ; 1440K (2M) MFM
            dc.b    $92,18                          ;  THS valid, DD, 2 heads; 18 sectors
            dc.w    80                              ;  80 tracks
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
