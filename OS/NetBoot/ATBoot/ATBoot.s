            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_50

            IMPORT  BaseOfROM,DoATControl,DoOpenLap,RsrcEntryDRVR_49

            SECTION "ATBoot",CODE

RsrcEntryDRVR_50:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 50 ".ATBOOT" (17796 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_49-BaseOfROM      ; Next entry
            dc.l    ATBOOT-BaseOfROM                ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    50                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'.ATBOOT'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00004590,$000001D4   ; Block header
ATBOOT:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    ATOpen-ATBOOT                   ; drvrOpen
            dc.w    ATAnRTS-ATBOOT                  ; drvrPrime
            dc.w    ATControl-ATBOOT                ; drvrCtl
            dc.w    ATAnRTS-ATBOOT                  ; drvrStatus
            dc.w    ATClose-ATBOOT                  ; drvrClose
            dc.b    7,'.ATBOOT'
            dc.w    $0100
ATOpen:
            move.l  ($14,A1),D3
            bgt.b   GotMem
            move.l  #$272,D0
            _NewPtrSysClear
            move.l  A0,D3
            beq.w   ATErrXit
            move.l  D3,($14,A1)
GotMem:
            suba.w  #ioQElSize,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     BootDiskName,A1
            move.l  A1,($12,A0)
            _Open
            tst.w   ($10,A0)
            adda.w  #$32,SP
            bgt.w   ATErrXit
            movea.l D3,A3
            move.w  ($18,A0),(A3)
            btst    #3,($17B).w
            bne.w   ATErrXit
            movem.l D2-D7/A0-A6,-(SP)
            moveq   #-$62,D1
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            bgt.b   .NoPatchee
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'lmgr',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D5
            beq.b   .OldAppleTalk
            bsr.w   DoOpenLap
            beq.b   .lapOK
            move.w  D0,D1
            bra.b   .NoPatchee
.lapOK:
            move.w  #$A090,D0
            _GetOSTrapAddress
            movea.l A0,A5
            move.w  #$A090,D0
            lea     mySysEnvirons,A0
            _SetOSTrapAddress
.OldAppleTalk:
            suba.w  #ioQElSize,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     MPPName,A1
            move.l  A1,($12,A0)
            _Open
            move.w  ($10,A0),D1
            lea     ($32,SP),SP
            tst.l   D5
            beq.b   .NoPatchee
            movea.l A5,A0
            move.w  #$A090,D0
            _SetOSTrapAddress
.NoPatchee:
            movem.l (SP)+,D2-D7/A0-A6
            tst.w   D1
            bne.b   ATErrXit
            moveq   #0,D0
            rts
ATErrXit:
            move.w  #$FFE9,D0
            rts
MPPName:
            dc.b    4,'.MPP'
            dc.b    $00
BootDiskName:
            dc.b    8,'.netBoot'
            dc.b    0
OpenStr:
            dc.b    11,'ATBoot Open'
            dc.w    0
ATClose:
            move.l  ($14,A1),D3
            beq.b   ATCloseExit
            movea.l D3,A3
            move.l  ($26A,A3),D0
            beq.b   .nopram
            movea.l D0,A0
            _DisposPtr
.nopram:
            move.l  (4,A3),D0
            beq.b   .noBuffer
            movea.l D0,A0
            _DisposPtr
.noBuffer:
            movea.l A3,A0
            _DisposPtr
            clr.l   ($14,A3)
ATCloseExit:
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #$FFF6,($18,A0)
            _Close
            lea     ($32,SP),SP
            moveq   #0,D0
ATAnRTS:
            rts
CloseStr:
            dc.b    12,'ATBoot Close'
            dc.b    $00,$4E,$75
ATControl:
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            moveq   #-1,D0
            move.l  ($14,A1),-(SP)
            beq.w   NoGo
            move.l  A0,-(SP)
            jsr     (DoATControl.w,PC)
NoGo:
            addq.l  #8,SP
            movea.l (SP)+,A0
            move.l  #$400,($28,A0)
            move.w  D0,($10,A0)
            movea.l (SP)+,A1
            movea.l JIODone,A3
            jmp     (A3)
ControlStr:
            dc.b    14,'ATBoot Control'
            dc.b    $00
mySysEnvirons:
            move.w  #$0605,(4,A0)                   ; Fake good system version
            moveq   #0,D0                           ; Return no error
            rts

            EVEN
