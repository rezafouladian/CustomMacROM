            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_51

            IMPORT  BaseOfROM,RsrcEntryDRVR_m16511

            SECTION "EDiskDriver",CODE

RsrcEntryDRVR_51:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 51 ".EDisk" (2500 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_m16511-BaseOfROM  ; Next entry
            dc.l    EDiskDRVR-BaseOfROM             ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    51                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    6,'.EDisk'                      ; Name
            dc.b    't Appl'
            dc.l    $C0A00000,$000009D0,$00000204   ; Block header
EDiskDRVR:
            dc.w    $4F00                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    EDiskOpen-EDiskDRVR             ; drvrOpen
            dc.w    EDiskPrime-EDiskDRVR            ; drvrPrime
            dc.w    EDiskControl-EDiskDRVR              ; drvrCtl
            dc.w    EDiskStatus-EDiskDRVR           ; drvrStatus
            dc.w    EDiskClose-EDiskDRVR            ; drvrClose
            dc.b    6,'.EDisk'
            dc.b    $00
StatusDecode:
            dc.w    $04CA,$0006,$04E6,$0008,$04F4,$4544,$FFFF,$FFEE
ControlDecode:
            dc.w    $03CE,$0001,$0474,$0005,$03EE,$0006,$03CC,$0007
            dc.w    $04EC,$0015,$04EE,$0016,$04DA,$0017,$FFFF,$FFEF
InitTable:
            dc.l    0
            bclr    D2,(A0)
            dc.w    $086A,$0868,$0854,0,$0410,$0248
            ds.b    4
            dc.w    $05C2,$0858,$0856,$0830,0,$0411,$0208
.L4:
            ori.b   #0,D0
            bclr    D2,($46,A0,D0.l)
            dc.w    $0844,$081E,0,$0C11,$0208
; EDiskOpen
EDiskOpen:
            jsr     JumpTo32Bit
            move.l  A0,-(SP)
            move.l  ($18,A1),D7
            move.w  #5,D7
            move.l  ($30A).w,D0
            beq.b   .L3
.NextDriveQueue:
            movea.l D0,A0
            cmp.w   (6,A0),D7
            bcc.b   .L2
            move.w  (6,A0),D7
.L2:
            move.l  (A0),D0
            bne.b   .NextDriveQueue
.L3:
            addq.w  #1,D7
            lea     InitTable,A6
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            jsr     ([JSwapMMU.w])
            movea.l BootGlobPtr,A2
            move.l  (-$4A,A2),D2
            move.l  D2,D3
            add.l   (-$46,A2),D3
            move.b  (SP)+,D0
            jsr     ([JSwapMMU.w])
            suba.l  A2,A2
            move.l  D2,D1
            moveq   #0,D2
            cmp.l   D1,D3
            bsr.w   CreateEDrive
            movea.l ROMBase,A2
.L4:
            bsr.w   CheckForRomDisk
            bne.b   .L5
            moveq   #0,D1
            move.l  A2,D2
            move.l  A2,D3
            bsr.b   CreateEDrive
            lea     InitTable.L4,A6
.L5:
            adda.l  #$10000,A2
            cmpa.l  #$E00000,A2
            bcs.b   .L4
            moveq   #-$17,D0
            swap    D7
            lea     ($30A).w,A0
.L6:
            move.l  (A0),D1
            beq.b   .L8
            movea.l D1,A0
            cmp.w   (8,A0),D7
            bne.b   .L6
            move.l  #$140,D0
            _NewPtrSysClear
            movea.l A0,A2
            move.l  A2,($14,A1)
            move.l  A1,($C,A2)
            move.w  .L9,(A2)
            move.w  .L9,(6,A2)
            lea     EDiskPollTask,A4
            moveq   #7,D4
.L7:
            lea     ($12,A2),A0
            jsr     (A4)
            dbra    D4,.L7
            lea     ($12,A2),A0
            addq.w  #1,(4,A0)
            move.l  A4,(6,A0)
            _VInstall
            moveq   #0,D0
.L8:
            movea.l (SP)+,A0
            move.w  D0,($10,A0)
.L9:
            rts
; CreateEDrive
CreateEDrive:
            beq.b   .Done
            moveq   #$4C,D0
            _NewPtrSysClear
            bne.b   .Done
            adda.w  #$3C,A0
            movea.l A6,A3
            move.l  (A3)+,(-$3C,A0)
            movea.w (A3)+,A4
            adda.l  A3,A4
            move.l  A4,(-$38,A0)
            move.l  A2,(-$34,A0)
            move.l  D1,(-$28,A0)
            move.l  D2,(-$24,A0)
            move.l  D3,(-$20,A0)
            movea.w (A3)+,A4
            adda.l  A3,A4
            move.l  A4,(-$1C,A0)
            movea.w (A3)+,A4
            adda.l  A3,A4
            move.l  A4,(-$18,A0)
            movea.w (A3)+,A4
            adda.l  A3,A4
            move.l  A4,(-$14,A0)
            move.l  (A3)+,(-$10,A0)
            move.w  (A3)+,(-$C,A0)
            move.b  #$55,(-$A,A0)
            sub.l   D1,D3
            move.l  D3,(-8,A0)
            addq.w  #1,(4,A0)
            addq.w  #1,(-2,A0)
            move.l  D7,D0
            swap    D0
            _AddDrive
.Done:
            addq.w  #1,D7
            lea     ($12,A6),A6
            rts
; CheckForRomDisk
CheckForRomDisk:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  BusErrVct,-(SP)
            lea     .L2,A0
            move.l  A0,BusErrVct
            movea.l SP,A4
            lea     HeaderTemplate,A3
            lea     ($80,A2),A0
            moveq   #3,D0
.L1:
            cmpm.l  (A0)+,(A3)+
            dbne    D0,.L1
.L2:
            movea.l A4,SP
            move.l  (SP)+,BusErrVct
            move    (SP)+,SR
            addq.w  #1,D0
            bne.b   .L5
            move.l  D7,D1
            swap    D1
            lea     ($30A).w,A0
.L3:
            move.l  (A0),D0
            beq.b   .L5
            movea.l D0,A0
            cmp.w   (8,A0),D1
            bne.b   .L3
            cmpi.b  #$11,(-$D,A0)
            bne.b   .L3
            moveq   #$7F,D0
            movea.l A2,A3
            movea.l (-$34,A0),A4
.L4:
            cmpm.l  (A3)+,(A4)+
            dbne    D0,.L4
            bne.b   .L3
.L5:
            tst.l   D0
            rts
; EDiskClose
EDiskClose:
            moveq   #closErr,D0
            rts
EDiskPrime:
            jsr     JumpTo32Bit
            move.w  (6,A0),-(SP)
            moveq   #0,D4
            movem.l D4/A0-A1,-(SP)
            bsr.w   FindDQE
            bne.w   .PrimeErr
            moveq   #-$32,D0
            move.l  ($24,A0),D1
            beq.w   .PrimeErr
            move.l  ($10,A1),D2
            movem.l (-$28,A3),A4-A6
            adda.l  D2,A5
            suba.l  A5,A6
            cmpa.l  D1,A6
            blt.w   .PrimeErr
            move.l  D1,D7
            or.l    D2,D7
            andi.w  #$1FF,D7
            bne.b   .PrimeErr
            move.l  ($20,A0),D6
            moveq   #$40,D7
            and.w   ($2C,A0),D7
            sne     D7
            neg.b   D7
            move.l  D6,D0
            _StripAddress
            cmpi.b  #3,(7,A0)
            movea.l A5,A0
            movea.l D0,A1
            bne.b   .paramsOK
            moveq   #2,D7
            exg     A0,A1
            moveq   #-$2C,D0
            tst.b   (-4,A3)
            bmi.b   .PrimeErr
            moveq   #2,D0
            bsr.w   HWDependent
.paramsOK:
            roxr.b  #1,D6
            addx.b  D7,D7
            move.l  A4,D6
            subq.l  #1,D6
            roxl.w  #2,D7
            lsr.l   #7,D2
            adda.l  D2,A4
            lea     .DispatchTable,A5
            adda.w  (0,A5,D7.w),A5
            jsr     (6,A2)
            move.l  #$200,D3
            move.b  MMU32bit,-(SP)
            movem.l D1/A0,-(SP)
            moveq   #1,D0
            jsr     ([JSwapMMU.w])
            movem.l (SP)+,D1/A0
.BlockLoop:
            moveq   #0,D5
            moveq   #$7F,D2
            jmp     (A5)                            ; Dispatch to the routine
.BlockDone:
            add.l   D3,D4
            sub.l   D3,D1
            bhi.b   .BlockLoop
.PrimeDone:
            moveq   #noErr,D0
.PrimeErr:
            move.l  D0,D2
            move.b  (SP)+,D0
            jsr     ([JSwapMMU.w])
            moveq   #3,D0
            bsr.w   HWDependent
            move.l  D2,D0
            movem.l (SP)+,D1/A0-A1
            move.l  D4,($28,A0)
            add.l   D4,($10,A1)
            bra.w   EDiskDone
.ReadWrite:
            move.l  D1,D0
            _BlockMove
            move.l  D1,D4
            bra.b   .PrimeDone
.ReadEvenXsum:
            moveq   #(512/8)-1,D2
.ReadEvenLoop:
            move.l  (A0)+,D7
            add.l   D5,D5
            addx.l  D7,D5
            move.l  D7,(A1)+
            move.l  (A0)+,D7
            add.l   D5,D5
            addx.l  D7,D5
            move.l  D7,(A1)+
            dbra    D2,.ReadEvenLoop
.ReadDone:
            cmp.l   (A4)+,D5
            beq.b   .BlockDone
            moveq   #-$48,D0
            bra.b   .PrimeErr
.ReadOddXsum:
            subq.l  #3,A1
            move.l  (A1),D7
            addq.l  #6,A5
.ReadOddLoop:
            move.l  (A0)+,D6
            add.l   D5,D5
            addx.l  D6,D5
            rol.l   #8,D6
            move.b  D6,D7
            move.l  D7,(A1)+
            move.l  D6,D7
            dbra    D2,.ReadOddLoop
            move.b  (3,A1),D7
            move.l  D7,(A1)
            bra.b   .ReadDone
.VerifyEven:
            movea.l SP,A4
.VerifyEvenXsum:
.VerifyEvenLoop:
            move.l  (A0)+,D7
            add.l   D5,D5
            addx.l  D7,D5
            cmp.l   (A1)+,D7
            dbne    D2,.VerifyEvenLoop
            beq.b   .VerifyGood
.VerifyError:
            moveq   #dataVerErr,D0
            bra.b   .PrimeErr
.VerifyOddXsum:
            lea     .VerifyOddLoop,A5
.VerifyOddSetup:
            subq.l  #1,A1
            move.l  (A1)+,D6
            rol.l   #8,D6
            jmp     (A5)
.VerifyOdd:
            addq.l  #4,A5
            bra.b   .VerifyOddSetup
            movea.l SP,A4
.VerifyOddLoop:
            move.l  D6,D7
            move.l  (A1)+,D6
            rol.l   #8,D6
            move.b  D6,D7
            add.l   D5,D5
            addx.l  D7,D5
            cmp.l   (A0)+,D7
            dbne    D2,.VerifyOddLoop
            bne.b   .VerifyError
.VerifyGood:
            move.l  D5,(SP)
            bra.b   .ReadDone
.WriteEvenXsum:
            moveq   #(512/8)-1,D2
.WriteEvenLoop:
            move.l  (A0)+,D7
            add.l   D5,D5
            addx.l  D7,D5
            move.l  D7,(A1)+
            move.l  (A0)+,D7
            add.l   D5,D5
            addx.l  D7,D5
            move.l  D7,(A1)+
            dbra    D2,.WriteEvenLoop
.WriteDone:
            move.l  D5,(A4)+
            bra.w   .BlockDone
.WriteOddXsum:
            subq.l  #1,A0
            move.l  (A0)+,D7
            rol.l   #8,D7
            addq.l  #8,A5
.WriteOddLoop:
            move.l  (A0)+,D6
            rol.l   #8,D6
            move.b  D6,D7
            add.l   D5,D5
            addx.l  D7,D5
            move.l  D7,(A1)+
            move.l  D6,D7
            dbra    D2,.WriteOddLoop
            bra.b   .WriteDone
.DispatchTable:
            dc.w    .ReadEvenXsum-.DispatchTable    ; 0 0 0 0 - read, even, xsum enabled
            dc.w    .ReadWrite-.DispatchTable       ; 0 0 0 1 - read, even, xsum disabled
            dc.w    .ReadOddXsum-.DispatchTable     ; 0 0 1 0 - read, odd, xsum enabled
            dc.w    .ReadWrite-.DispatchTable       ; 0 0 1 1 - read, odd, xsum disabled
            dc.w    .VerifyEvenXsum-.DispatchTable  ; 0 1 0 0 - verify, even, xsum enabled
            dc.w    .VerifyEven-.DispatchTable      ; 0 1 0 1 - verify, even, xsum disabled
            dc.w    .VerifyOddXsum-.DispatchTable   ; 0 1 1 0 - verify, odd, xsum enabled
            dc.w    .VerifyOdd-.DispatchTable       ; 0 1 1 1 - verify, odd, xsum disabled
            dc.w    .WriteEvenXsum-.DispatchTable   ; 1 0 0 0 - write, even, xsum enabled
            dc.w    .ReadWrite-.DispatchTable       ; 1 0 0 1 - write, even, xsum disabled
            dc.w    .WriteOddXsum-.DispatchTable    ; 1 0 1 0 - write, odd, xsum enabled
            dc.w    .ReadWrite-.DispatchTable       ; 1 0 1 1 - write, odd, xsum disabled
EDiskControl:
            jsr     JumpTo32Bit
            lea     ControlDecode,A2
            bra.b   HandleControlStatus
EDiskStatus:
            lea     StatusDecode,A2
HandleControlStatus::
            move.w  (6,A0),-(SP)
            pea     EDiskDone
            move.w  ($1A,A0),D1
.search:
            move.l  (A2)+,D0
            bmi.b   .exit
            cmp.w   D0,D1
            bne.b   .search
            swap    D0
            pea     (0,A2,D0.w)
            bra.w   FindDQE
.exit:
            movea.l ($14,A1),A2
            rts
ctlKillIO:
            move.w  #$200,(4,SP)
            moveq   #-$11,D0
            rts
ctlEject:
            move.l  D1,D0
            bne.b   .EjectErr
            bclr    #0,(-$C,A3)
            move.b  (-3,A3),D0
            ble.b   .EjectDone
            subq.b  #8,D0
            beq.b   .EjectDone
            moveq   #4,D0
            bsr.w   HWDependent
.EjectDone:
            moveq   #noErr,D0
.EjectErr:
            rts
ctlFormat:
            bne.w   .exit
            moveq   #2,D0
            bsr.w   HWDependent
            move.l  A4,D0
            _StripAddress
            movea.l D0,A4
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            jsr     ([JSwapMMU.w])
            moveq   #-$32,D0
            move.w  (A4),D1
            subq.w  #1,D1
            bls.b   .CheckWrProt
            addq.w  #2,D1
            bne.b   .done
            cmpi.b  #$10,(-$D,A3)
            bne.b   .done
            lea     DrvQHdr,A1
            movea.l A3,A0
            _Dequeue
            moveq   #0,D6
            bra.b   .SkipTest
.CheckWrProt:
            moveq   #wPrErr,D0
            tst.b   (-4,A3)
            bmi.b   .done
            bsr.w   CreateEDiskHeader
            moveq   #0,D6
.SkipTest:
            movem.l (-$28,A3),A0-A1/A4
            move.l  A0,D2
            bne.b   .ClearDisk
            movea.l A1,A0
.ClearDisk:
            moveq   #0,D0
            tst.l   D6
            beq.b   .FormatStart
            moveq   #-$52,D0
            bra.b   .done
.NextBlock:
            moveq   #(512/4)-1,D1
.BlockLoop:
            move.l  D0,(A1)+
            dbra    D1,.BlockLoop
            move.l  D0,(A0)+
.FormatStart:
            cmpa.l  A1,A4
            bhi.b   .NextBlock
.done:
            move.l  D0,D2
            move.b  (SP)+,D0
            jsr     ([JSwapMMU.w])
            moveq   #3,D0
            bsr.w   HWDependent
            move.l  D2,D0
.exit:
            rts
ctlVerify:
            move.l  D0,D2
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            jsr     ([JSwapMMU.w])
            move.l  D2,D0
            bne.b   .L16
            movem.l (-$28,A3),A0-A1/A4
            move.l  A0,D0
            beq.b   .L16
            moveq   #0,D0
.NextBlock:
            cmpa.l  A1,A4
            bls.b   .L16
            moveq   #$7F,D1
.BlockLoop:
            move.l  (A1)+,D3
            add.l   D0,D0
            addx.l  D3,D0
            dbra    D1,.BlockLoop
            sub.l   (A0)+,D0
            beq.b   .NextBlock
            moveq   #-$54,D0
.L16:
            move.l  D0,D2
            move.b  (SP)+,D0
            jsr     ([JSwapMMU.w])
            move.l  D2,D0
            rts
statFmtLst:
            bne.b   .Done
            moveq   #-$32,D0
            tst.w   (A4)
            ble.b   .Done
            move.w  #1,(A4)+
            movea.l (A4),A4
            move.l  ($C,A3),D0
            swap    D0
            move.l  D0,(A4)+
            move.l  #$40000000,(A4)
            moveq   #0,D0
.Done:
            rts
statDrvSts:
            move.l  D1,D0
            bne.b   .Done
            movea.l A4,A1
            clr.w   (A1)+
            lea     (-4,A3),A0
            moveq   #$14,D0
            _BlockMove
.Done:
            rts
statDrvSize:
            move.l  (-8,A3),(A4)
            rts
ctlDriveInfo:
            move.l  D1,D0
            bne.b   .Done
            move.l  (-$10,A3),(A4)
.Done:
            rts
ctlDriveIcon:
            movea.l (-$18,A3),A0
            bra.b   IconCommon
ctlMediaIcon:
            movea.l (-$1C,A3),A0
IconCommon:
            move.l  D1,D0
            bne.b   .Done
            moveq   #-$11,D0
            move.l  A0,D1
            beq.b   .Done
            lea     ($20,A2),A1
            move.l  A1,(A4)
            move.l  #$100,D0
            _BlockMove
            lea     ($120,A2),A1
            clr.b   (A1)
            move.l  (-$14,A3),D1
            beq.b   .Done
            movea.l D1,A0
            moveq   #1,D0
            add.b   (A0),D0
            cmpi.w  #$20,D0
            bls.b   .CopyString
            moveq   #$20,D0
.CopyString:
            _BlockMove
.Done:
            rts
; FindDQE
FindDQE:
            movea.l ($14,A1),A2
            addq.b  #1,($10,A2)
            jsr     (A2)
            lea     ($30A).w,A3
            move.w  ($16,A0),D2
            bpl.b   .search
            neg.w   D2
.search:
            move.l  (A3),D0
            beq.b   .notFound
            _StripAddress
            movea.l D0,A3
            cmp.w   (6,A3),D2
            bne.b   .search
            move.w  ($18,A1),D2
            cmp.w   (8,A3),D2
            bne.b   .search
            moveq   #0,D1
            tst.b   (-3,A3)
            ble.b   .offLine
            moveq   #0,D0
            bsr.b   HWDependent
            beq.b   .offLine
            move.l  A0,D0
            _StripAddress
            movea.l D0,A0
            moveq   #0,D0
.Done:
            lea     ($1C,A0),A4
            rts
.offLine:
            moveq   #-$41,D0
            bra.b   .Done
.notFound:
            moveq   #-$38,D1
            moveq   #-$38,D0
            bra.b   .Done
EDiskDone:
            subq.b  #1,($10,A2)
            movea.l ($C,A2),A1
            btst    #1,(SP)+
            bne.b   .immed
            move.l  JIODone,-(SP)
.immed:
            ext.l   D0
            beq.b   .done
            move.w  D0,DskErr
.done:
            rts
HWDependent:
            move.l  (-$38,A3),-(SP)
            rts
RAMDiskHandler:
            move.b  .decode(PC,D0.w),D0
            jmp     .decode(PC,D0.w)
.decode:
            dc.w    $060A,$0C20,$3600
.checkInserted:
            moveq   #-1,D0
            rts
.checkReadOnly:
            moveq   #0,D0
.enableWrites:
            movem.l D1/A0-A1,-(SP)
            moveq   #8,D0
            movea.l (-$28,A3),A0
            suba.l  A1,A1
            _HWPriv
            movem.l (SP)+,D1/A0-A1
            rts
.disableWrites:
            movem.l D1/A0-A1,-(SP)
            moveq   #8,D0
            movea.l (-$28,A3),A0
            movea.w #1,A1
            _HWPriv
            movem.l (SP)+,D1/A0-A1
            rts
.eject:
            clr.b   (-3,A3)
.done:
            rts
ROMDiskHandler:
            move.b  .decode(PC,D0.w),D0
            jmp     .decode(PC,D0.w)
.decode:
            dc.w    $0606,$0808,$0A00
            moveq   #-1,D0
            rts
.eject:
            clr.b   (-3,A3)
.done:
            rts
; EDiskPollTask
EDiskPollTask:
            lea     (-$12,A0),A2
            lea     ($30A).w,A3
            movea.l ($C,A2),A1
            move.w  ($18,A1),D3
            tst.b   ($10,A2)
            beq.b   .next
            addq.w  #1,($1C,A2)
            rts
.search:
            movea.l D2,A3
            cmp.w   (8,A3),D3
            beq.b   .CheckDrive
.next:
            move.l  (A3),D2
            bne.b   .search
            move.w  #$11,($1C,A2)
            rts
.CheckDrive:
            moveq   #0,D0
            bsr.w   HWDependent
            addq.w  #1,D0
            move.b  (-$A,A3),D1
            addx.b  D1,D1
            move.b  D1,(-$A,A3)
            moveq   #7,D0
            and.b   D0,D1
            bne.b   .L4
            tst.b   (-3,A3)
            bpl.b   .next
            clr.b   (-3,A3)
            bra.b   .next
.L4:
            cmp.b   D0,D1
            bne.b   .next
            tst.b   (-3,A3)
            bmi.b   .next
            beq.b   .OnLine
.mount:
            btst    #0,(-$C,A3)
            bne.b   .next
            moveq   #7,D0
            movea.l D0,A0
            move.w  (6,A3),D0
            _PostEvent
            bne.b   .next
            bset    #0,(-$C,A3)
            bra.b   .next
.OnLine:
            move.b  (-$B,A3),(-3,A3)
            clr.b   (-4,A3)
            move.l  (-$34,A3),D0
            beq.b   .SetupRAMDisk
            movea.l D0,A0
            move.l  ($94,A0),(-$30,A3)
            move.l  ($98,A0),(-$2C,A3)
            moveq   #1,D0
            bsr.w   HWDependent
            move.b  D0,(-4,A3)
            bne.b   .SetupROMDisk
            tst.l   (-$3C,A3)
            beq.b   .SetupRAMDisk
            moveq   #2,D0
            bsr.w   HWDependent
            bsr.w   ComputeSLIMSize
            add.l   A0,D0
            move.l  D0,(-$20,A3)
            lea     ($200,A0),A0
            move.l  A0,(-$28,A3)
            moveq   #3,D0
            bsr.w   HWDependent
.SetupRAMDisk:
            movem.l (-$28,A3),D0-D2
            tst.l   D0
            beq.b   .BaseFound
            move.l  D0,D1
            moveq   #0,D0
.BaseFound:
            btst    #1,(-$C,A3)
            beq.b   .UpdateBasePtrs
            move.l  D1,D0
            sub.l   D2,D1
            neg.l   D1
            addi.l  #$FFFF,D1
            lsr.l   #7,D1
            andi.w  #$FE00,D1
            add.l   D0,D1
.UpdateBasePtrs:
            movem.l D0-D1,(-$28,A3)
.SetupDriveSize:
            sub.l   D1,D2
            bcc.b   .DriveSizeOK
            move.l  D1,(-$20,A3)
            moveq   #0,D2
.DriveSizeOK:
            rol.l   #7,D2
            move.l  D2,($C,A3)
            bra.w   .mount
.SetupROMDisk:
            move.l  A0,D0
            lea     HeaderTemplate,A1
            lea     ($80,A0),A0
            moveq   #3,D2
.cmpLoop:
            cmpm.l  (A0)+,(A1)+
            dbne    D2,.cmpLoop
            beq.b   .SigOK
            move.l  D0,D1
            move.l  D1,D2
            bra.b   .UpdateBasePtrs
.SigOK:
            move.l  (A0)+,D0
            addq.w  #8,A0
            lea     (-$28,A3),A1
            moveq   #2,D2
            tst.l   (-$3C,A3)
            bne.b   .offsetLoop
            moveq   #5,D2
            move.l  ($18,A0),D1
            beq.b   .offsetLoop
            move.l  D1,(-$10,A3)
.offsetLoop:
            addq.l  #4,A1
            move.l  (A0)+,D1
            beq.b   .nextOffset
            cmp.l   D0,D1
            bhi.b   .nextOffset
            add.l   (-$34,A3),D1
            move.l  D1,(-4,A1)
.nextOffset:
            dbra    D2,.offsetLoop
            movem.l (-$24,A3),D1-D2
            bra.b   .SetupDriveSize
ComputeSLIMSize:
            adda.l  #$200000,A0
            movea.l A0,A1
            moveq   #0,D0
            move.l  #'Gary',D1
            moveq   #4-1,D2
.FillLoop:
            suba.l  #$80000,A0
            move.l  (A0),-(SP)
            rol.l   #8,D1
            move.l  D1,(A0)
            cmp.l   (A0),D1
            bne.b   .NotRAM1
            not.l   D1
            move.l  D1,(A0)
            cmp.l   (A0),D1
            bne.b   .NotRAM2
            bset    D2,D0
.NotRAM2:
            not.l   D1
.NotRAM1:
            dbra    D2,.FillLoop
            not.l   D1
            moveq   #3,D2
.CheckLoop:
            suba.l  #$80000,A1
            rol.l   #8,D1
            cmp.l   (A1),D1
            beq.b   .IsRAM
            bclr    D2,D0
.IsRAM:
            dbra    D2,.CheckLoop
            moveq   #3,D2
.RestoreLoop:
            move.l  (SP)+,(A1)
            adda.l  #$80000,A1
            dbra    D2,.RestoreLoop
            move.b  .SizesTable(PC,D0.w),D0
            moveq   #$13,D1
            lsl.l   D1,D0
            rts
.SizesTable:
            dc.b    0
            dc.b    1
            dc.b    0
            dc.b    2
            dc.w    0,$0003
            ds.b    7
            dc.b    $04
; CreateEDiskHeader
CreateEDiskHeader:
            move.l  (-$34,A3),D0
            beq.b   .Done
            movea.l D0,A0
            moveq   #$7F,D3
.clrLoop:
            clr.l   (A0)+
            dbra    D3,.clrLoop
            lea     HeaderTemplate,A1
            lea     (-$180,A0),A0
            moveq   #3,D3
.cpyLoop:
            move.l  (A1)+,(A0)+
            dbra    D3,.cpyLoop
            move.l  (-$20,A3),D2
            sub.l   D0,D2
            move.l  D2,(A0)+
            lea     (-$30,A3),A1
            move.l  TimeLM,(A1)
            move.l  (A1)+,(A0)+
            move.l  Ticks,(A1)
            move.l  (A1)+,(A0)+
            moveq   #5,D3
.offsetLoop:
            addq.l  #4,A0
            move.l  (A1)+,D1
            sub.l   D0,D1
            cmp.l   D1,D2
            bcs.b   .nextOffset
            move.l  D1,(-4,A0)
.nextOffset:
            dbra    D3,.offsetLoop
.Done:
            rts
; JumpTo32Bit
JumpTo32Bit:
            move.l  (SP),D0
            _Translate24To32
            move.l  D0,(SP)
            rts
HeaderTemplate:
            dc.w    $0200,$0001
            dc.b    'EDisk Gary D'
            dc.b    16,'Upper SLIM Drive'
            dc.b    $00,$10
            dc.b    'Lower SLIM Drive'
            dc.b    $00,$11
            dc.b    'Internal ROM Disk'
            dc.b    17,'Internal RAM Disk'
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$8901,$8100,$7101,$80FF,$FF01,$8000,$0001
            dc.w    $8000,$2001,$8000,$D001,$8000,$8801,$8003,$0401
            dc.w    $8002,$0601,$800C,$0C01,$8008,$1E01,$8030,$3201
            dc.w    $8020,$7A01,$80C0,$CA01,$80C1,$E801,$80E3,$2801
            dc.w    $80F7,$A001,$80BC,$A001,$809E,$8001,$800A,$8001
            dc.w    $8002,$0001,$8002,$0001,$8000,$0001,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
            ds.b    4

            EVEN
