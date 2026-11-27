; Sony.s - Open, Control, Status calls
; Included by Drivers/Sony/SonyHdr.s

.L4:
            moveq   #-$18,D0
            rts
InitDskTbl:
            dc.w    jtFigTrkSpd-InitDskTbl
            dc.w    jtDiskPrime-InitDskTbl
            dc.w    jtRdAddr-InitDskTbl
            dc.w    jtRdData-InitDskTbl
            dc.w    jtWrData-InitDskTbl
            dc.w    jtSeek-InitDskTbl
            dc.w    jtSetUpPoll-InitDskTbl
            dc.w    jtRecal-InitDskTbl
            dc.w    jtControl-InitDskTbl
            dc.w    jtWakeUp-InitDskTbl
            dc.w    jtReSeek-InitDskTbl
            dc.w    jtMakeSpdTbl-InitDskTbl
            dc.w    AdrDisk-InitDskTbl           ; provide access to these routines
            dc.w    DiskRTS-InitDskTbl           ; SetSpeed does nothing if no PWM
            dc.w    Nibl-InitDskTbl              ;  programs (not patchable)
InitDsk2:
            dc.w    jtDiskSel-InitDskTbl         ; interface select routine
            dc.w    jtSendCmd-InitDskTbl         ; HD20
            dc.w    jtDCDReset-InitDskTbl
            dc.w    jtMRdAddr-InitDskTbl         ; Read MFM address routine
            dc.w    jtMRdData-InitDskTbl         ; Read MFM data routine
            dc.w    jtMWrData-InitDskTbl         ; Write MFM data routine
InitParams:
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
            lea     InitDskTbl,A0
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
            lea     InitParams,A0
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
DiskRTS:
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
CtlTbl:
; Control call dispatch table: csCode, offset for drives 1-2, offset for drives 3-4 (HD20)
            dc.w    $0001,ctlKillIO-CtlTbl,ctlKillIO-CtlTbl             ; killCode
            dc.w    $0005,ctlSonyVer-CtlTbl,HD20CtlVerify-CtlTbl        ; VerifyCC
            dc.w    $0006,ctlSonyFmt-CtlTbl,HD20CtlFormat-CtlTbl        ; FormatCC
            dc.w    $0007,CtlSonyEjc-CtlTbl,HD20CtlEject-CtlTbl         ; EjectCode
            dc.w    $0008,ctlTagBuf-CtlTbl,ctlTagBuf-CtlTbl             ; TagBufCC
            dc.w    $0009,ctlTrkCache-CtlTbl,ctlTrkCache-CtlTbl         ; TCacheCC
            dc.w    $0015,ctlPhysIcon-CtlTbl,HD20CtlIcon-CtlTbl         ; IconCC
            dc.w    $0016,ctlLogIcon-CtlTbl,HD20CtlIcon-CtlTbl          ; IconLogCC
            dc.w    $0017,ctlDrvInfo-CtlTbl,ctlDrvInfo-CtlTbl           ; InfoCC
            dc.w    'SC',CtlFmtCopy-CtlTbl,ctlKillIO-CtlTbl             ; FmtCopyCC
            dc.w    'GD',CtlRawTrackDump-CtlTbl,ctlKillIO-CtlTbl        ; GetRawDataCC
            dc.w    0
            move.l  ($242).w,-(SP)                  ; DiskControl: JControl
            rts
jtControl:
            bsr.w   CkDrvNum
            bne.b   .L12
            tst.b   (4,A1,D1.w)
            bpl.b   .L12
            moveq   #-$40,D0
.L12:
            lea     CtlTbl,A3
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
            bra.w   DiskRTS.L9
ctlKillIO:
            moveq   #-1,D0
            bra.w   DiskRTS.L9
ctlSonyFmt:
            bne.w   DiskRTS.L9
            bra.w   Nibl.L26
ctlSonyVer:
            bne.w   DiskRTS.L9
            bra.w   CtlVerify
ctlTagBuf:
            move.l  ($1C,A0),($F4,A1)
            moveq   #0,D0
            bra.w   DiskRTS.L9
ctlTrkCache:
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
            bra.w   DiskRTS.L9
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
CtlSonyEjc:
            bne.w   DiskRTS.L9
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
            bra.w   DiskRTS.L9
HD20CtlFormat:
            bne.w   DiskRTS.L9
            bra.w   sub_40870474.L1
HD20CtlVerify:
            bne.w   DiskRTS.L9
            bra.w   sub_40870474
HD20CtlEject:
            bne.w   DiskRTS.L9
            clr.b   (3,A1,D1.w)
            moveq   #0,D0
            bra.w   DiskRTS.L9
StatusTbl:
            dc.w    $0006,PassportSts-StatusTbl         ; FmtLstCode
            dc.w    $0008,DriveStatus-StatusTbl         ; DrvStsCode
            dc.w    $000A,MFMStatus-StatusTbl           ; MFMStsCode
            dc.w    'DV',DupVersion-StatusTbl           ; DupVerSts
            dc.w    'SC',GetFmtByte-StatusTbl           ; FmtByteSts
            dc.w    0
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
            bra.w   DiskRTS.L9
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
            dc.l    2*400                           ; 400K GCR
            dc.b    $81,10                          ;  THS valid, SD, 1 head; 10 sectors (average)
            dc.w    80                              ;  80 tracks
            dc.l    2*800                           ; 800K GCR
            dc.b    $82,10                          ;  THS valid, SD, 2 heads; 10 sectors (average)
            dc.w    80                              ;  80 tracks
            dc.l    2*720                           ; 720K (1M) MFM
            dc.b    $82,9                           ;  THS valid, SD, 2 heads; 9 sectors
            dc.w    80                              ;  80 tracks
.L28:
            dc.l    2*1440                          ; 1440K (2M) MFM
            dc.b    $92,18                          ;  THS valid, DD, 2 heads; 18 sectors
            dc.w    80                              ;  80 tracks
MFMStatus:
            move.l  ($16,A1,D1.w),D0                ; get mfmDrive, mfmDisk, twoMegFmt
            move.b  ($138,A1),D0                    ; stuff the FDC type (isSWIM) into the lsb
            move.l  D0,(A0)
            moveq   #0,D0                           ; always return no error
            rts
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
