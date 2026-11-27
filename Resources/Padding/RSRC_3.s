            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryRSRC_3

            IMPORT  BaseOfROM,RsrcEntryDRVR_50

            SECTION "Padding_RSRC_3",CODE

RsrcEntryRSRC_3:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'RSRC' 3 (2052 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_50-BaseOfROM      ; Next entry
            dc.l    RsrcRSRC_3-BaseOfROM            ; Data
            dc.b    'RSRC'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000810,$000001CC   ; Block header
RsrcRSRC_3:
            ds.b    2048

            EVEN
