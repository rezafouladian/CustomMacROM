            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryapad_1

            IMPORT  BaseOfROM,RsrcEntryiopc_0

            SECTION "Padding_apad_1",CODE

RsrcEntryapad_1:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'apad' 1 "Main" (43700 bytes) - Combo mask
            dc.l    RsrcEntryiopc_0-BaseOfROM       ; Next entry
            dc.l    Rsrcapad_1-BaseOfROM            ; Data
            dc.b    'apad'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            ds.b    8
            dc.l    $C0A00000,$0000AAC0,$00000184   ; Block header
Rsrcapad_1:
            ds.b    43696

            EVEN
