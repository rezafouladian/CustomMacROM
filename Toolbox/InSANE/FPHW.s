            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_4

            IMPORT  BaseOfROM,RsrcEntryPACK_5_2

            SECTION "InSANE_FPHW",CODE

; FPHW.a: PACK 4 SANE floating point (FPU)

RsrcEntryPACK_4:
            dc.b    $70,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 4 (14916 bytes) - Combo mask
            dc.l    RsrcEntryPACK_5_2-BaseOfROM     ; Next entry
            dc.l    FP68K-BaseOfROM                 ; Data
            dc.b    'PACK'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            dc.b    'SRCSMBPKEBAL'
            dc.l    $C0A00000,$00003A50,$000001EC   ; Block header

            include "Toolbox/InSANE/FPHWCtrl.s"
            include "Toolbox/InSANE/FPHWArith.s"
            include "Toolbox/InSANE/FPHWNonArith.s"
            include "Toolbox/InSANE/FPHWB2DC.s"

            EVEN
