            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryRSRC_5

            IMPORT  BaseOfROM,RsrcEntryattx_1

            SECTION "Padding_RSRC_5",CODE

RsrcEntryRSRC_5:
            dc.b    $00,$20,$00,$00,$00,$00,$00,$00 ; Resource 'RSRC' 5 (4660 bytes) - Combo mask
            dc.l    RsrcEntryattx_1-BaseOfROM       ; Next entry
            dc.l    RsrcRSRC_5-BaseOfROM            ; Data
            dc.b    'RSRC'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00001240,$000001AC   ; Block header
RsrcRSRC_5:
            ds.b    4656

            EVEN
