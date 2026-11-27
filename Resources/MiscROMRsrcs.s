            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPICT_501

            IMPORT  BaseOfROM,RsrcEntryapad_0

            SECTION "MiscROMRsrcs",CODE

RsrcEntryPICT_501:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PICT' 501 "Decrypt Data" (276 bytes) - Combo mask
            dc.l    RsrcEntryapad_0-BaseOfROM       ; Next entry
            dc.l    RsrcPICT_501-BaseOfROM          ; Data
            dc.b    'PICT'                          ; Type
            dc.w    501                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    12,'Decrypt Data'               ; Name
            dc.l    $C0A00000,$00000120,$000001BC   ; Block header
RsrcPICT_501:
            dc.b    $01,$12,$00,$7B,$00,$52,$00,$93,$00,$91,$11,$01,$A0,$00,$82,$A0
            dc.b    $00,$8E,$01,$00,$0A,$00,$00,$00,$00,$02,$D0,$02,$40,$98,$00,$0A
            dc.b    $00,$7B,$00,$50,$00,$93,$00,$98,$00,$7B,$00,$52,$00,$93,$00,$91
            dc.b    $00,$7B,$00,$52,$00,$93,$00,$91,$00,$00,$02,$F7,$00,$02,$F7,$00
            dc.b    $09,$00,$1E,$FD,$00,$01,$30,$30,$FE,$00,$09,$00,$1B,$FD,$00,$01
            dc.b    $30,$30,$FE,$00,$0B,$07,$19,$9C,$73,$ED,$9E,$78,$3C,$D8,$FF,$00
            dc.b    $0B,$07,$19,$B6,$DB,$8D,$9B,$30,$36,$D8,$FF,$00,$0B,$07,$19,$BE
            dc.b    $C3,$0D,$9B,$30,$36,$D8,$FF,$00,$0B,$07,$1B,$30,$DB,$0D,$9B,$30
            dc.b    $36,$D8,$FF,$00,$0B,$07,$1E,$1C,$73,$07,$9E,$18,$3C,$78,$FF,$00
            dc.b    $0A,$FE,$00,$04,$01,$98,$00,$00,$18,$FF,$00,$0A,$FE,$00,$04,$07
            dc.b    $18,$00,$00,$70,$FF,$00,$02,$F7,$00,$02,$F7,$00,$02,$F7,$00,$0B
            dc.b    $00,$0F,$FE,$00,$03,$1F,$00,$C1,$80,$FF,$00,$0A,$06,$19,$80,$00
            dc.b    $00,$19,$80,$C0,$FE,$00,$0B,$07,$19,$B0,$CE,$78,$19,$B6,$F3,$BC
            dc.b    $FF,$00,$0B,$07,$19,$9F,$9B,$6C,$1F,$36,$D9,$B6,$FF,$00,$0B,$07
            dc.b    $19,$9F,$9F,$6C,$1E,$36,$D9,$B6,$FF,$00,$0B,$07,$19,$8F,$18,$6C
            dc.b    $1B,$36,$D9,$B6,$FF,$00,$0B,$07,$0F,$0F,$0E,$6C,$19,$9E,$F1,$B6
            dc.b    $FF,$00,$02,$F7,$00,$02,$F7,$00,$02,$F7,$00,$A0,$00,$8F,$A0,$00
            dc.b    $83,$FF,$00,$00
            ds.b    12

            EVEN
