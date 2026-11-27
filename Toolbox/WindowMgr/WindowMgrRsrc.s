            include "Include/ROMHeader.s"

            EXPORT  RsrcEntrywctb_0

            IMPORT  BaseOfROM,RsrcEntryDRVR_4

            SECTION "WindowMgrRsrc",CODE

RsrcEntrycctb_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'cctb' 0 (52 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_4-BaseOfROM       ; Next entry
            dc.l    Rsrccctb_0-BaseOfROM            ; Data
            dc.b    'cctb'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000040,$0000016C   ; Block header
Rsrccctb_0:
            ds.b    7
            dc.b    $03
            ds.b    9
            dc.b    $01,$FF,$FF,$FF,$FF,$FF,$FF,$00,$02
            ds.b    7
            dc.b    $03,$FF,$FF,$FF,$FF,$FF,$FF
            ds.b    8
RsrcEntrywctb_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'wctb' 0 (52 bytes) - Combo mask
            dc.l    RsrcEntrycctb_0-BaseOfROM       ; Next entry
            dc.l    Rsrcwctb_0-BaseOfROM            ; Data
            dc.b    'wctb'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000040,$00000164   ; Block header
Rsrcwctb_0:
            ds.b    7
            dc.b    $04,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$01
            ds.b    7
            dc.b    $02
            ds.b    7
            dc.b    $03
            ds.b    7
            dc.b    $04,$FF,$FF,$FF,$FF,$FF,$FF

            EVEN
