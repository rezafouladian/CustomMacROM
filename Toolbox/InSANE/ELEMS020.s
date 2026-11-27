            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_5_2

            IMPORT  BaseOfROM,RsrcEntryPACK_4_2

            SECTION "InSANE_ELEMS020",CODE

; ELEMS020.a: PACK 5 SANE elementary functions (68020)

RsrcEntryPACK_5_2:
            dc.b    $08,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 5 (4660 bytes) - Combo mask
            dc.l    RsrcEntryPACK_4_2-BaseOfROM     ; Next entry
            dc.l    ELEMS020-BaseOfROM          ; Data
            dc.b    'PACK'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'ter, Inc. 19'
            dc.l    $C0A00000,$00001240,$000001F4   ; Block header

            include "Toolbox/InSANE/ELEMS020_1.s"
            include "Toolbox/InSANE/ELEMS020_2.s"
            include "Toolbox/InSANE/ELEMS020_3.s"
            include "Toolbox/InSANE/ELEMS020_C.s"

            EVEN
