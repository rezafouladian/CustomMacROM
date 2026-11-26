            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_m16511

            IMPORT  BaseOfROM,DRVRClose,DRVRControl,DRVROpen,DRVRPrime,DRVRStatus
            IMPORT  RsrcEntryDRVR_3

            SECTION "BacklightDRVRRuntime",CODE

RsrcEntryDRVR_m16511:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' -16511 ".Backlight" (4372 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_3-BaseOfROM       ; Next entry
            dc.l    RsrcDRVR_m16511-BaseOfROM       ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    -16511                          ; ID
            dc.b    $58                             ; Attributes
            dc.b    10,'.Backlight'                 ; Name
            dc.w    $4247
            dc.l    $C0A00000,$00001120,$0000020C   ; Block header
RsrcDRVR_m16511:
            dc.w    $4C00                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    BacklightOpen-RsrcDRVR_m16511   ; drvrOpen
            dc.w    BacklightPrime-RsrcDRVR_m16511  ; drvrPrime
            dc.w    BacklightCtl-RsrcDRVR_m16511    ; drvrCtl
            dc.w    BacklightStatus-RsrcDRVR_m16511 ; drvrStatus
            dc.w    BacklightClose-RsrcDRVR_m16511  ; drvrClose
            dc.b    10,'.Backlight'
            ds.b    21
BacklightOpen:
            bra.w   BacklightClose.L1
BacklightPrime:
            bra.w   BacklightClose.L2
BacklightCtl:
            bra.w   BacklightClose.L3
BacklightStatus:
            bra.w   BacklightClose.L4
BacklightClose:
            bra.w   .L5
.L1:
            pea     (DRVROpen.w,PC)
            bra.b   .L6
.L2:
            pea     (DRVRPrime.w,PC)
            bra.b   .L6
.L3:
            pea     (DRVRControl.w,PC)
            bra.b   .L6
.L4:
            pea     (DRVRStatus.w,PC)
            bra.b   .L6
.L5:
            pea     (DRVRClose.w,PC)
            nop
.L6:
            movem.l A0-A1,-(SP)
            clr.w   -(SP)
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            movea.l ($12,SP),A0
            jsr     (A0)
            move.w  (SP)+,D0
            movem.l (SP)+,A0-A1
            addq.w  #4,SP
            btst    #1,(6,A0)
            bne.b   .L7
            move.l  JIODone,-(SP)
.L7:
            rts

            EVEN
