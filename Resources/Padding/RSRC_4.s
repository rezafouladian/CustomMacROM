            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryRSRC_4

            IMPORT  BaseOfROM,RsrcEntryclut_1

            SECTION "Padding_RSRC_4",CODE

RsrcEntryRSRC_4:
            dc.b    $00,$20,$00,$00,$00,$00,$00,$00 ; Resource 'RSRC' 4 (9524 bytes) - Combo mask
            dc.l    RsrcEntryclut_1-BaseOfROM       ; Next entry
            dc.l    RsrcRSRC_4-BaseOfROM            ; Data
            dc.b    'RSRC'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00002540,$00000124   ; Block header
RsrcRSRC_4:
            ds.b    9520

            EVEN
