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

            include "Drivers/Sony/SonyIOP.s"           ; SWIM IOP based driver code
            include "Drivers/Sony/Sony.s"              ; Open, Control, Status calls
            include "Drivers/Sony/SonyRWT.s"           ; Prime (high-level read/write)
            include "Drivers/Sony/SonyUtil.s"          ; utility routines
            include "Drivers/Sony/SonyIcon.s"          ; icon & info support
            include "Drivers/Sony/SonyRead.s"          ; floppy read data, read addr marks
            include "Drivers/Sony/SonyWrite.s"         ; floppy write data
            include "Drivers/Sony/SonyFormat.s"        ; floppy format code
            include "Drivers/Sony/SonyMFM.s"           ; MFM/SuperDrive support
            include "Drivers/Sony/SonyDup.s"           ; Disk Duplicator support
            include "Drivers/Sony/SonyHD20.s"          ; HD20 support (not in the old sources)
            include "Drivers/Sony/SonyRawTrack.s"      ; Raw Track Dump control call
            include "Drivers/Sony/SonyPortable.s"      ; PowerBook power manager / secure support (not in the old sources)

            EVEN
