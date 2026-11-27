            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_4_2

            IMPORT  BaseOfROM,RsrcEntryDRVR_51

            SECTION "InSANE_FP020",CODE

; FP020.a: PACK 4 SANE floating point (68020)

RsrcEntryPACK_4_2:
            dc.b    $08,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 4 (8308 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_51-BaseOfROM      ; Next entry
            dc.l    FP020-BaseOfROM                 ; Data
            dc.b    'PACK'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'le Computer,'
            dc.l    $C0A00000,$00002080,$000001FC   ; Block header

            include "Toolbox/InSANE/FPCTRL.s"
            include "Toolbox/InSANE/FPOPS.s"
            include "Toolbox/InSANE/FPBD.s"

            EVEN
