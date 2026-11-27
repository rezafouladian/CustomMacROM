            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryapad_2

            IMPORT  BaseOfROM,RsrcEntryRSRC_4

            SECTION "Padding_apad_2",CODE

RsrcEntryapad_2:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'apad' 2 "Main" (2596 bytes) - Combo mask
            dc.l    RsrcEntryRSRC_4-BaseOfROM       ; Next entry
            dc.l    Rsrcapad_2-BaseOfROM            ; Data
            dc.b    'apad'                          ; Type
            dc.w    2                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            ds.b    8
            dc.l    $C0A00000,$00000A30,$0000011C   ; Block header
Rsrcapad_2:
            ds.b    2592

            EVEN
