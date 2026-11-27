            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryclut_1

            IMPORT  BaseOfROM,RsrcEntrywctb_0

            SECTION "CQDRsrc",CODE

RsrcEntrymitq_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'mitq' 0 (20 bytes) - Combo mask
            dc.l    RsrcEntrywctb_0-BaseOfROM       ; Next entry
            dc.l    Rsrcmitq_0-BaseOfROM            ; Data
            dc.b    'mitq'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000020,$0000015C   ; Block header
Rsrcmitq_0:
            dc.b    $00,$00,$12,$A0,$00,$00,$22,$00,$00,$00,$3C
            ds.b    5
RsrcEntrygama_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'gama' 0 "StdGamma" (276 bytes) - Combo mask
            dc.l    RsrcEntrymitq_0-BaseOfROM       ; Next entry
            dc.l    Rsrcgama_0-BaseOfROM            ; Data
            dc.b    'gama'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    8,'StdGamma'                    ; Name
            ds.b    4
            dc.l    $C0A00000,$00000120,$00000154   ; Block header
Rsrcgama_0:
            ds.b    7
            dc.b    $01,$01,$00,$00,$08,$00,$05,$09,$0B,$0E,$10,$13,$15,$17,$19,$1B
            dc.b    $1D,$1E,$20,$22
            dc.b    $24,$25,$27,'(*,-/0134678:;<>?@BCDEGHIJKMNOPQRTUVWXYZ['
            dc.b    $5C,$5E
            dc.b    '_`abcdefghijklmnopqrstuvwxyz'
            dc.b    $7B,$7C,$7D,$7E,$7F,$80,$81,$81,$82,$83,$84,$85,$86,$87,$88,$89
            dc.b    $8A,$8B,$8C,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95,$95,$96,$97
            dc.b    $98,$99,$9A,$9B,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A1,$A2,$A3,$A4,$A5
            dc.b    $A6,$A6,$A7,$A8,$A9,$AA,$AB,$AB,$AC,$AD,$AE,$AF,$B0,$B0,$B1,$B2
            dc.b    $B3,$B4,$B4,$B5,$B6,$B7,$B8,$B8,$B9,$BA,$BB,$BC,$BC,$BD,$BE,$BF
            dc.b    $C0,$C0,$C1,$C2,$C3,$C3,$C4,$C5,$C6,$C7,$C7,$C8,$C9,$CA,$CA,$CB
            dc.b    $CC,$CD,$CD,$CE,$CF,$D0,$D0,$D1,$D2,$D3,$D3,$D4,$D5,$D6,$D6,$D7
            dc.b    $D8,$D9,$D9,$DA,$DB,$DC,$DC,$DD,$DE,$DF,$DF,$E0,$E1,$E1,$E2,$E3
            dc.b    $E4,$E4,$E5,$E6,$E7,$E7,$E8,$E9,$E9,$EA,$EB,$EC,$EC,$ED,$EE,$EE
            dc.b    $EF,$F0,$F1,$F1,$F2,$F3,$F3,$F4,$F5,$F5,$F6,$F7,$F8,$F8,$F9,$FA
            dc.b    $FA,$FB,$FC,$FC,$FD,$FE,$FF
            ds.b    4
RsrcEntryclut_127:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'clut' 127 "DefQDColors" (84 bytes) - Combo mask
            dc.l    RsrcEntrygama_0-BaseOfROM       ; Next entry
            dc.l    Rsrcclut_127-BaseOfROM          ; Data
            dc.b    'clut'                          ; Type
            dc.w    127                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    11,'DefQDColors'                ; Name
            dc.b    $00
            dc.l    $C0A00000,$00000060,$0000014C   ; Block header
Rsrcclut_127:
            dc.w    0,$007F,0,$0007
            ds.b    9
            dc.b    $01,$FC,$00,$F3,$7D,$05,$2F,$00,$02,$F2,$D7,$08,$56,$84,$EC,$00
            dc.b    $03,$DD,$6B,$08,$C2,$06,$A2,$00,$04,$02,$41,$AB,$54,$EA,$FF,$00
            dc.b    $05,$00,$00,$64,$AF,$11,$B0,$00,$06
            ds.b    4
            dc.w    $D400,$0007,$FFFF,$FFFF,$FFFF
            ds.b    8
RsrcEntryclut_8:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'clut' 8 "8BitStd" (2068 bytes) - Combo mask
            dc.l    RsrcEntryclut_127-BaseOfROM     ; Next entry
            dc.l    Rsrcclut_8-BaseOfROM            ; Data
            dc.b    'clut'                          ; Type
            dc.w    8                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'8BitStd'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00000820,$00000144   ; Block header
Rsrcclut_8:
            dc.w    0,$0008,$8000,$00FF,0,$FFFF,$FFFF,$FFFF
            dc.w    0,$FFFF,$FFFF,$CCCC,0,$FFFF,$FFFF,$9999
            dc.w    0,$FFFF,$FFFF,$6666,0,$FFFF,$FFFF,$3333
            dc.w    0,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$CCCC,$FFFF,0,$FFFF,$CCCC,$CCCC,0
            dc.w    $FFFF,$CCCC,$9999,0,$FFFF,$CCCC,$6666,0
            dc.w    $FFFF,$CCCC,$3333,0,$FFFF,$CCCC
            ds.b    4
            dc.w    $FFFF,$9999,$FFFF,0,$FFFF,$9999,$CCCC,0
            dc.w    $FFFF,$9999,$9999,0,$FFFF,$9999,$6666,0
            dc.w    $FFFF,$9999,$3333,0,$FFFF,$9999
            ds.b    4
            dc.w    $FFFF,$6666,$FFFF,0,$FFFF,$6666,$CCCC,0
            dc.w    $FFFF,$6666,$9999,0,$FFFF,$6666,$6666,0
            dc.w    $FFFF,$6666,$3333,0,$FFFF,$6666
            ds.b    4
            dc.w    $FFFF,$3333,$FFFF,0,$FFFF,$3333,$CCCC,0
            dc.w    $FFFF,$3333,$9999,0,$FFFF,$3333,$6666,0
            dc.w    $FFFF,$3333,$3333,0,$FFFF,$3333
            ds.b    4
            dc.w    $FFFF,0,$FFFF,0,$FFFF,0,$CCCC,0
            dc.w    $FFFF,0,$9999,0,$FFFF,0,$6666,0
            dc.w    $FFFF,0,$3333,0,$FFFF
            ds.b    6
            dc.w    $CCCC,$FFFF,$FFFF,0,$CCCC,$FFFF,$CCCC,0
            dc.w    $CCCC,$FFFF,$9999,0,$CCCC,$FFFF,$6666,0
            dc.w    $CCCC,$FFFF,$3333,0,$CCCC,$FFFF
            ds.b    4
            dc.w    $CCCC,$CCCC,$FFFF,0,$CCCC,$CCCC,$CCCC,0
            dc.w    $CCCC,$CCCC,$9999,0,$CCCC,$CCCC,$6666,0
            dc.w    $CCCC,$CCCC,$3333,0,$CCCC,$CCCC
            ds.b    4
            dc.w    $CCCC,$9999,$FFFF,0,$CCCC,$9999,$CCCC,0
            dc.w    $CCCC,$9999,$9999,0,$CCCC,$9999,$6666,0
            dc.w    $CCCC,$9999,$3333,0,$CCCC,$9999
            ds.b    4
            dc.w    $CCCC,$6666,$FFFF,0,$CCCC,$6666,$CCCC,0
            dc.w    $CCCC,$6666,$9999,0,$CCCC,$6666,$6666,0
            dc.w    $CCCC,$6666,$3333,0,$CCCC,$6666
            ds.b    4
            dc.w    $CCCC,$3333,$FFFF,0,$CCCC,$3333,$CCCC,0
            dc.w    $CCCC,$3333,$9999,0,$CCCC,$3333,$6666,0
            dc.w    $CCCC,$3333,$3333,0,$CCCC,$3333
            ds.b    4
            dc.w    $CCCC,0,$FFFF,0,$CCCC,0,$CCCC,0
            dc.w    $CCCC,0,$9999,0,$CCCC,0,$6666,0
            dc.w    $CCCC,0,$3333,0,$CCCC
            ds.b    6
            dc.w    $9999,$FFFF,$FFFF,0,$9999,$FFFF,$CCCC,0
            dc.w    $9999,$FFFF,$9999,0,$9999,$FFFF,$6666,0
            dc.w    $9999,$FFFF,$3333,0,$9999,$FFFF
            ds.b    4
            dc.w    $9999,$CCCC,$FFFF,0,$9999,$CCCC,$CCCC,0
            dc.w    $9999,$CCCC,$9999,0,$9999,$CCCC,$6666,0
            dc.w    $9999,$CCCC,$3333,0,$9999,$CCCC
            ds.b    4
            dc.w    $9999,$9999,$FFFF,0,$9999,$9999,$CCCC,0
            dc.w    $9999,$9999,$9999,0,$9999,$9999,$6666,0
            dc.w    $9999,$9999,$3333,0,$9999,$9999
            ds.b    4
            dc.w    $9999,$6666,$FFFF,0,$9999,$6666,$CCCC,0
            dc.w    $9999,$6666,$9999,0,$9999,$6666,$6666,0
            dc.w    $9999,$6666,$3333,0,$9999,$6666
            ds.b    4
            dc.w    $9999,$3333,$FFFF,0,$9999,$3333,$CCCC,0
            dc.w    $9999,$3333,$9999,0,$9999,$3333,$6666,0
            dc.w    $9999,$3333,$3333,0,$9999,$3333
            ds.b    4
            dc.w    $9999,0,$FFFF,0,$9999,0,$CCCC,0
            dc.w    $9999,0,$9999,0,$9999,0,$6666,0
            dc.w    $9999,0,$3333,0,$9999
            ds.b    6
            dc.w    $6666,$FFFF,$FFFF,0,$6666,$FFFF,$CCCC,0
            dc.w    $6666,$FFFF,$9999,0,$6666,$FFFF,$6666,0
            dc.w    $6666,$FFFF,$3333,0,$6666,$FFFF
            ds.b    4
            dc.w    $6666,$CCCC,$FFFF,0,$6666,$CCCC,$CCCC,0
            dc.w    $6666,$CCCC,$9999,0,$6666,$CCCC,$6666,0
            dc.w    $6666,$CCCC,$3333,0,$6666,$CCCC
            ds.b    4
            dc.w    $6666,$9999,$FFFF,0,$6666,$9999,$CCCC,0
            dc.w    $6666,$9999,$9999,0,$6666,$9999,$6666,0
            dc.w    $6666,$9999,$3333,0,$6666,$9999
            ds.b    4
            dc.w    $6666,$6666,$FFFF,0,$6666,$6666,$CCCC,0
            dc.w    $6666,$6666,$9999,0
            dc.b    'ffffff'
            dc.w    0
            dc.b    'ffff33'
            dc.w    0,$6666,$6666
            ds.b    4
            dc.w    $6666,$3333,$FFFF,0,$6666,$3333,$CCCC,0
            dc.w    $6666,$3333,$9999,0
            dc.b    'ff33ff'
            dc.w    0
            dc.b    'ff3333'
            dc.w    0,$6666,$3333
            ds.b    4
            dc.w    $6666,0,$FFFF,0,$6666,0,$CCCC,0
            dc.w    $6666,0,$9999,0,$6666,0,$6666,0
            dc.w    $6666,0,$3333,0,$6666
            ds.b    6
            dc.w    $3333,$FFFF,$FFFF,0,$3333,$FFFF,$CCCC,0
            dc.w    $3333,$FFFF,$9999,0,$3333,$FFFF,$6666,0
            dc.w    $3333,$FFFF,$3333,0,$3333,$FFFF
            ds.b    4
            dc.w    $3333,$CCCC,$FFFF,0,$3333,$CCCC,$CCCC,0
            dc.w    $3333,$CCCC,$9999,0,$3333,$CCCC,$6666,0
            dc.w    $3333,$CCCC,$3333,0,$3333,$CCCC
            ds.b    4
            dc.w    $3333,$9999,$FFFF,0,$3333,$9999,$CCCC,0
            dc.w    $3333,$9999,$9999,0,$3333,$9999,$6666,0
            dc.w    $3333,$9999,$3333,0,$3333,$9999
            ds.b    4
            dc.w    $3333,$6666,$FFFF,0,$3333,$6666,$CCCC,0
            dc.w    $3333,$6666,$9999,0
            dc.b    '33ffff'
            dc.w    0
            dc.b    '33ff33'
            dc.w    0,$3333,$6666
            ds.b    4
            dc.w    $3333,$3333,$FFFF,0,$3333,$3333,$CCCC,0
            dc.w    $3333,$3333,$9999,0
            dc.b    '3333ff'
            dc.w    0
            dc.b    '333333'
            dc.w    0,$3333,$3333
            ds.b    4
            dc.w    $3333,0,$FFFF,0,$3333,0,$CCCC,0
            dc.w    $3333,0,$9999,0,$3333,0,$6666,0
            dc.w    $3333,0,$3333,0,$3333
            ds.b    8
            dc.w    $FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$CCCC
            ds.b    4
            dc.w    $FFFF,$9999
            ds.b    4
            dc.w    $FFFF,$6666
            ds.b    4
            dc.w    $FFFF,$3333
            ds.b    4
            dc.w    $FFFF
            ds.b    6
            dc.w    $CCCC,$FFFF
            ds.b    4
            dc.w    $CCCC,$CCCC
            ds.b    4
            dc.w    $CCCC,$9999
            ds.b    4
            dc.w    $CCCC,$6666
            ds.b    4
            dc.w    $CCCC,$3333
            ds.b    4
            dc.w    $CCCC
            ds.b    6
            dc.w    $9999,$FFFF
            ds.b    4
            dc.w    $9999,$CCCC
            ds.b    4
            dc.w    $9999,$9999
            ds.b    4
            dc.w    $9999,$6666
            ds.b    4
            dc.w    $9999,$3333
            ds.b    4
            dc.w    $9999
            ds.b    6
            dc.w    $6666,$FFFF
            ds.b    4
            dc.w    $6666,$CCCC
            ds.b    4
            dc.w    $6666,$9999
            ds.b    4
            dc.w    $6666,$6666
            ds.b    4
            dc.w    $6666,$3333
            ds.b    4
            dc.w    $6666
            ds.b    6
            dc.w    $3333,$FFFF
            ds.b    4
            dc.w    $3333,$CCCC
            ds.b    4
            dc.w    $3333,$9999
            ds.b    4
            dc.w    $3333,$6666
            ds.b    4
            dc.w    $3333,$3333
            ds.b    4
            dc.w    $3333
            ds.b    8
            dc.w    $FFFF
            ds.b    6
            dc.w    $CCCC
            ds.b    6
            dc.w    $9999
            ds.b    6
            dc.w    $6666
            ds.b    6
            dc.w    $3333,0,$EEEE
            ds.b    6
            dc.w    $DDDD
            ds.b    6
            dc.w    $BBBB
            ds.b    6
            dc.w    $AAAA
            ds.b    6
            dc.w    $8888
            ds.b    6
            dc.w    $7777
            ds.b    6
            dc.w    $5555
            ds.b    6
            dc.w    $4444
            ds.b    6
            dc.w    $2222
            ds.b    6
            dc.w    $1111
            ds.b    8
            dc.w    $EEEE
            ds.b    6
            dc.w    $DDDD
            ds.b    6
            dc.w    $BBBB
            ds.b    6
            dc.w    $AAAA
            ds.b    6
            dc.w    $8888
            ds.b    6
            dc.w    $7777
            ds.b    6
            dc.w    $5555
            ds.b    6
            dc.w    $4444
            ds.b    6
            dc.w    $2222
            ds.b    6
            dc.w    $1111
            ds.b    8
            dc.w    $EEEE
            ds.b    6
            dc.w    $DDDD
            ds.b    6
            dc.w    $BBBB
            ds.b    6
            dc.w    $AAAA
            ds.b    6
            dc.w    $8888
            ds.b    6
            dc.w    $7777
            ds.b    6
            dc.w    $5555
            ds.b    6
            dc.w    $4444
            ds.b    6
            dc.w    $2222
            ds.b    6
            dc.w    $1111,0,$EEEE,$EEEE,$EEEE,0,$DDDD,$DDDD
            dc.w    $DDDD,0,$BBBB,$BBBB,$BBBB,0,$AAAA,$AAAA
            dc.w    $AAAA,0,$8888,$8888,$8888,0
            dc.b    'wwwwww'
            dc.w    0
            dc.b    'UUUUUU'
            dc.w    0
            dc.b    'DDDDDD'
            dc.w    0,$2222,$2222,$2222,0,$1111,$1111,$1111
            ds.b    16
RsrcEntryclut_4:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'clut' 4 "4BitStd" (148 bytes) - Combo mask
            dc.l    RsrcEntryclut_8-BaseOfROM       ; Next entry
            dc.l    Rsrcclut_4-BaseOfROM            ; Data
            dc.b    'clut'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'4BitStd'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$000000A0,$0000013C   ; Block header
Rsrcclut_4:
            dc.w    0,$0004,$8000,$000F,0,$FFFF,$FFFF,$FFFF
            dc.w    0,$FC00,$F37D,$052F,0,$FFFF,$648A,$028C
            dc.w    0,$DD6B,$08C2,$06A2,0,$F2D7,$0856,$84EC
            dc.w    0,$46E3,0,$A53E
            ds.b    6
            dc.w    $D400,0,$0241,$AB54,$EAFF,0,$1F21,$B793
            dc.w    $1431
            ds.b    4
            dc.w    $64AF,$11B0,0,$5600,$2C9D,$0524,0,$90D7
            dc.w    $7160,$3A34,0,$C000,$C000,$C000,0,$8000
            dc.b    $80,$00,$80,$00,$00,$00,$40,$00,$40,$00,$40
            ds.b    17
RsrcEntryclut_2:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'clut' 2 "2BitStd" (52 bytes) - Combo mask
            dc.l    RsrcEntryclut_4-BaseOfROM       ; Next entry
            dc.l    Rsrcclut_2-BaseOfROM            ; Data
            dc.b    'clut'                          ; Type
            dc.w    2                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'2BitStd'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00000040,$00000134   ; Block header
Rsrcclut_2:
            dc.w    0,$0002,$8000,$0003,0,$FFFF,$FFFF,$FFFF
            dc.w    0,$ACAC,$ACAC,$ACAC,0
            dc.b    'UUUUUU'
            ds.b    16
RsrcEntryclut_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'clut' 1 "1BitStd" (36 bytes) - Combo mask
            dc.l    RsrcEntryclut_2-BaseOfROM       ; Next entry
            dc.l    Rsrcclut_1-BaseOfROM            ; Data
            dc.b    'clut'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'1BitStd'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00000030,$0000012C   ; Block header
Rsrcclut_1:
            dc.w    0,$0001,$8000,$0001,0,$FFFF,$FFFF,$FFFF
            ds.b    16

            EVEN
