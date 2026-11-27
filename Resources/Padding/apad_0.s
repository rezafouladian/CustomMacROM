            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryapad_0

            IMPORT  BaseOfROM,RsrcEntryRSRC_3

            SECTION "Padding_apad_0",CODE

RsrcEntryapad_0:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'apad' 0 "Main" (3140 bytes) - Combo mask
            dc.l    RsrcEntryRSRC_3-BaseOfROM       ; Next entry
            dc.l    Rsrcapad_0-BaseOfROM            ; Data
            dc.b    'apad'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            ds.b    8
            dc.l    $C0A00000,$00000C50,$000001C4   ; Block header
Rsrcapad_0:
            ds.b    3136

            EVEN
