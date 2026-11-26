            include "Include/ROMHeader.s"

            EXPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            EXPORT  ALIGN24TRAILER,ALIGN32TRAILER,BLOCKMOVEPATCH,CACHEVECTORPATCH,CHECKPACKETPATCH,CLKNOMEMPATCH
            EXPORT  DEBUGUTILRUNKBDPATCH,DELAY100PATCH,DEREFHANDLEPATCH,DISPATCHPATCH,DSHOOKPATCH,ECLIPSEEGRETPATCHES
            EXPORT  EGRETPATCHTOO,FILEMGRPATCH,FLUSHCRANGE,FLUSHDCACHEPATCH,FLUSHICACHEPATCH,getAddrModePatch
            EXPORT  getFPUTypePatch,getPageSizePatch,GETREALPROC,HWPrivPatch,INIT24ZONEALIGN,INIT32ZONEALIGN
            EXPORT  InitMemoryDispatch,InitMMU,NEWLOCKMEMORY,NEWLOCKMEMORYCONTIGUOUS,NEWUNLOCKMEMORY,OSEVENTAVAILPATCH
            EXPORT  OSEVENTMGRPATCH,READUPDATE,RequestDonePatch,RomRsrcHead,SETAPPLBASEPATCH,SETTRANSFERPARMSPATCH
            EXPORT  SHIFTREGIRQPATCH,SWAPDCACHEPATCH,UNWRITEPROTECTPROC,V24CMGUTSPATCH,V24HLOCKPATCH,V24MAXAPPLPATCH
            EXPORT  V24MAXMEMPATCH,V24PURGESPACEPATCH,V32CMGUTSPATCH,V32HLOCKPATCH,V32MAXAPPLPATCH,V32MAXMEMPATCH
            EXPORT  V32PURGESPACEPATCH,WRITEPROTECTPROC,WRITEUPDATE,ZONECHECKPATCH

            IMPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,BaseOfROM,BMMOVELONGS
            IMPORT  BMOVERLAP,BMVERYSHORT,Critical,DEBUGPWRMGRADBPATCH2,DHBUSERRHANDLER,EGRETPOWEROFF
            IMPORT  EMT1010,FileWrite,HeapGuts,INITRELIABILITY,RsrcEntryDRVR_4,SCSIBoots
            IMPORT  SETRESPONSEPARAMS,WriteUpdateReturn

            SECTION "Part4",CODE

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
RsrcEntryWDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'WDEF' 0 (2116 bytes) - Combo mask
            dc.l    RsrcEntryapad_2-BaseOfROM       ; Next entry
            dc.l    RsrcWDEF_0-BaseOfROM            ; Data
            dc.b    'WDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000850,$00000114   ; Block header
RsrcWDEF_0:
            bra.b   .L1
            dc.w    0,$5744,$4546,0,$000B
.L1:
            link.w  A6,#-$22
            movem.l D3-D7/A1-A4,-(SP)
            cmpi.w  #6,($C,A6)
            bgt.w   .L7
            cmpi.w  #0,($C,A6)
            bmi.w   .L7
            movea.l (A5),A0
            move.l  (A0),-(SP)
            cmpi.w  #$3FFF,ROM85
            sls     (-$22,A6)
            bhi.b   .L2
            bsr.w   sub_408769FA
            bra.b   .L3
.L2:
            move.l  WMgrPort,-(SP)
            _SetPort
.L3:
            lea     (-8,A6),A3
            move.l  A3,-(SP)
            _GetFontInfo
            move.w  (A3)+,D7
            add.w   (A3)+,D7
            addq.w  #4,D7
            bset    #0,D7
            moveq   #$13,D1
            cmp.w   D1,D7
            bge.b   .L4
            sub.w   D7,D1
            lsr.w   #1,D1
            add.w   D1,(-8,A6)
            moveq   #$13,D7
.L4:
            move.w  D7,(A3)+
            move.w  D7,D0
            subi.w  #$D,D0
            lsr.w   #1,D0
            move.w  D0,(A3)
            clr.l   -(SP)
            _NewRgn
            move.l  (SP)+,(-$C,A6)
            tst.b   (-$22,A6)
            beq.b   .L5
            pea     (-$1A,A6)
            _GetForeColor
            pea     (-$20,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$10,A6)
            _HLock
            move.l  (A0),(-$14,A6)
.L5:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D5
            move.w  D5,D6
            andi.w  #3,D5
            clr.l   (A0)
            add.w   D0,D0
            lea     .L8,A0
            adda.w  .L8(PC,D0.w),A0
            jsr     (A0)
            move.l  (-$C,A6),-(SP)
            _DisposRgn
            tst.b   (-$22,A6)
            beq.b   .L6
            movea.l (-$10,A6),A0
            _HUnlock
            pea     (-$20,A6)
            _RGBBackColor
            pea     (-$1A,A6)
            _RGBForeColor
.L6:
            _SetPort
.L7:
            movem.l (SP)+,D3-D7/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            dc.w    $0134,$0464,$053A,$0046,$00F2,$05D2,$0684
sub_408769FA:
            move.l  ($D2C).w,-(SP)
            _SetPort
            movea.l WMgrPort,A0
            movea.l ($D2C).w,A1
            pea     ($20,A0)
            pea     ($3A,A0)
            lea     ($30,A0),A0
            lea     ($30,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            addq.w  #8,A0
            addq.w  #8,A1
            move.w  #$14,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            _PenPat
            _BackPat
            rts
            btst    #3,D6
            beq.b   sub_40876A6E.L1
            clr.b   ($71,A3)
            tst.w   ROM85
            bmi.b   sub_40876A6E.L1
            moveq   #$10,D0
            _NewHandleClear
            bne.b   sub_40876A6E.L1
            addq.b  #1,($71,A3)
            move.l  A0,($82,A3)
            movea.l (A0),A4
            addq.w  #8,A4
            movea.l (A5),A1
            move.l  (-$74,A1),(A4)+
            move.l  (-$70,A1),(A4)+
            moveq   #3,D0
            sub.w   D0,-(A4)
            sub.w   D0,-(A4)
            add.w   D0,-(A4)
            add.w   D0,-(A4)
            add.w   D7,(A4)
            add.w   D7,(A4)
            movea.l (A0),A4
sub_40876A6E:
            move.l  A4,-(SP)
            move.l  ($10,A3),(A4)
            move.l  ($14,A3),(4,A4)
            movea.l A3,A0
            bsr.w   sub_40876B12
            move.l  (6,A0),-(SP)
            neg.w   (SP)
            neg.w   (2,SP)
            _OffsetRect
.L1:
            rts
sub_40876A8E:
            subq.w  #8,SP
            movea.l SP,A4
            bsr.b   sub_40876A6E
            movea.l ($82,A3),A0
            movea.l (A0),A2
            addq.w  #8,A2
            bsr.b   sub_40876AB2
            bne.b   .L1
            bsr.b   sub_40876AB2
            beq.b   .L2
.L1:
            movea.l ($82,A3),A0
            movea.l (A0),A4
            bsr.b   sub_40876A6E
            moveq   #1,D0
.L2:
            addq.w  #8,SP
            rts
sub_40876AB2:
            move.l  (A2),-(SP)
            move.l  (A2)+,-(SP)
            move.l  SP,-(SP)
            move.l  #$FFF9FFF9,-(SP)
            _InsetRect
            clr.w   -(SP)
            move.l  (A4)+,-(SP)
            pea     (6,SP)
            _PtInRect
            subq.b  #1,(SP)
            move.b  (SP)+,D0
            addq.w  #8,SP
            rts
sub_40876AD2:
            btst    #3,D6
            beq.b   .L1
            tst.b   ($71,A3)
.L1:
            rts
            bsr.b   sub_40876AD2
            beq.b   .L2
            movea.l ($82,A3),A0
            _DisposHandle
.L2:
            rts
sub_40876AEA:
            move.l  D1,-(SP)
            movea.l (-$14,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
sub_40876B12:
            addq.w  #2,A0
            tst.w   (4,A0)
            bpl.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
            tst.b   ($6E,A3)
            beq.w   .L12
            cmpi.w  #4,D3
            bge.w   sub_40876CA6.L1
            _PenNormal
            tst.w   D5
            bne.w   sub_40876CEC.L3
            bsr.w   sub_40876CA6
            tst.b   (-$22,A6)
            beq.b   .L2
            move.w  #1,D0
            bsr.b   sub_40876AEA
            _RGBForeColor
            move.w  #4,D0
            bsr.b   sub_40876AEA
            _RGBBackColor
.L2:
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            _FrameRect
            move.l  OneOne,-(SP)
            _InsetRect
            _EraseRect
            bsr.w   sub_40876D26
            tst.b   ($6F,A3)
            beq.w   .L6
            tst.b   (-$22,A6)
            beq.b   .L3
            move.w  #4,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #3,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
.L3:
            pea     Scratch8
            move.w  #1,-(SP)
            move.w  (-2,A6),-(SP)
            _InsetRect
            move.w  ($A00).w,-(SP)
            move.w  D3,($A00).w
            move.l  Scratch8,D0
            andi.l  #$70007,D0
            movea.l (A5),A4
            move.l  D0,(-$A8,A4)
            pea     Scratch8
            pea     .L13
            _FillRect
            bsr.w   sub_40876AD2
            beq.b   .L4
            move.w  (SP),D0
            subi.w  #$1A,D0
            cmp.w   D4,D0
            bge.b   .L4
            move.w  D0,D4
.L4:
            move.w  (SP)+,($A00).w
            move.w  D4,($9FC).w
            pea     Scratch8
            pea     .L13
            _FillRect
            clr.l   (-$A8,A4)
            tst.b   ($70,A3)
            beq.b   .L5
            bsr.w   sub_40876CA6
            lea     sub_40876D26.L8,A1
            moveq   #0,D0
            bsr.w   sub_40876CEC
.L5:
            bsr.w   sub_40876AD2
            beq.b   .L6
            bsr.w   sub_40876CA6
            lea     sub_40876D26.L6,A1
            moveq   #0,D0
            bsr.w   sub_40876CD6
.L6:
            move.l  OneOne,D4
.L7:
            tst.b   (-$22,A6)
            beq.b   .L8
            moveq   #1,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
            moveq   #0,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
.L8:
            movea.l ($72,A3),A0
            movea.l (A0),A0
            lea     (2,A0),A4
            sub.w   D4,(4,A4)
            sub.w   D4,(6,A4)
            move.l  A4,-(SP)
            _FrameRect
            cmpi.w  #3,D5
            beq.b   .L9
            tst.w   D5
            bne.b   .L10
.L9:
            bsr.w   sub_40877018
.L10:
            cmpi.w  #1,D5
            bne.b   .L11
            move.l  (A4),Scratch8
            move.l  (4,A4),($9FE).w
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            move.l  #$70007,-(SP)
            _PenSize
            movea.l (A5),A0
            pea     (-8,A0)
            _PenPat
            _FrameRect
            movea.l (A5),A0
            pea     (-$10,A0)
            _PenPat
            move.l  #$20002,-(SP)
            move.l  (SP),-(SP)
            _PenSize
            _InsetRect
            pea     Scratch8
            _FrameRect
            _PenNormal
.L11:
            add.w   D4,(4,A4)
            add.w   D4,(6,A4)
.L12:
            rts
.L13:
            dc.w    $FF00,$FF00,$FF00,$FF00
sub_40876CA6:
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  (A0),D0
            add.w   D7,D0
            move.w  D0,(4,A0)
            subq.w  #1,(6,A0)
            rts
.L1:
            beq.b   sub_40876CD6.L1
            bsr.w   sub_40876AD2
            beq.b   sub_40876CEC.L2
            bsr.b   sub_40876CA6
            lea     sub_40876D26.L7,A1
            moveq   #2,D0
sub_40876CD6:
            lea     Scratch8,A0
            move.w  (6,A0),(2,A0)
            moveq   #-$16,D1
            bra.b   sub_40876CEC.L1
.L1:
            bsr.b   sub_40876CA6
            lea     sub_40876D26.L9,A1
            moveq   #2,D0
sub_40876CEC:
            lea     Scratch8,A0
            moveq   #7,D1
.L1:
            add.w   D1,(2,A0)
            move.w  (-2,A6),D1
            add.w   D1,(A0)
            subq.w  #1,(A0)
            move.l  (A0)+,(A0)
            moveq   #$10,D1
            add.w   D1,(A0)+
            add.w   D1,(A0)
            move.l  #$100010,D1
            bsr.w   sub_40877044
.L2:
            rts
.L3:
            move.l  #$20002,D4
            cmpi.w  #3,D5
            beq.w   sub_40876B12.L7
            moveq   #0,D4
            bra.w   sub_40876B12.L7
sub_40876D26:
            move.w  ($A00).w,D4
            move.w  D4,D3
            sub.w   ($9FC).w,D3
            sub.w   ($8A,A3),D3
            asr.w   #1,D3
            moveq   #2,D0
            tst.b   ($70,A3)
            beq.b   .L1
            moveq   #$20,D0
.L1:
            cmp.w   D0,D3
            bge.b   .L2
            move.w  D0,D3
.L2:
            add.w   ($9FC).w,D3
            move.w  D4,-(SP)
            bsr.w   sub_40876AD2
            beq.b   .L3
            subi.w  #$20,D4
.L3:
            move.l  (-$C,A6),-(SP)
            move.l  (SP),-(SP)
            _GetClip
            move.w  D4,($A00).w
            pea     Scratch8
            _ClipRect
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($1C,A0),-(SP)
            move.l  (SP),-(SP)
            _SectRgn
            move.w  (SP)+,($A00).w
            move.w  D3,-(SP)
            move.w  Scratch8,D0
            add.w   (-8,A6),D0
            addq.w  #1,D0
            move.w  D0,-(SP)
            _MoveTo
            tst.b   (-$22,A6)
            beq.b   .L4
            move.w  #4,D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #2,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
            move.w  #1,-(SP)
            _TextMode
.L4:
            movea.l ($86,A3),A0
            _HLock
            move.l  (A0),-(SP)
            _DrawString
            movea.l ($86,A3),A0
            _HUnlock
            move.l  (-$C,A6),-(SP)
            _SetClip
            move.w  D3,D0
            subq.w  #6,D3
            add.w   ($8A,A3),D0
            cmp.w   D4,D0
            bge.b   .L5
            move.w  D0,D4
.L5:
            addq.w  #6,D4
            rts
.L6:
            ds.b    4
            dc.w    $BFFB,$2088,$A08B,$2088,$A08B,$2088,$BF8B,$2008
            dc.w    $A00B,$2008,$BFFB
            ds.b    6
.L7:
            ds.b    6
            dc.w    $0180,$09A0,$05C0,$0080,$1CF0,$1F80,$0540,$0920
            dc.b    $01
            ds.b    9
.L8:
            ds.b    4
            dc.w    $BFFB,$2008,$A00B,$2008,$A00B,$2008,$A00B,$2008
            dc.w    $A00B,$2008,$BFFB
            ds.b    6
.L9:
            ds.b    6
            dc.w    $0100,$0920,$0540,0,$1C70,0,$0540,$0920
            dc.b    $01
            ds.b    9
            dc.w    $4267,$2F03,$2F2B,$0076,$A8E8,$4A1F
            dc.b    'g8JEf.'
            dc.w    $0806,$0002,$6E28,$4A2B,$006F,$6722,$206B,$0076
            dc.w    $2050,$2028,$0006,$780E,$9044,$B640,$6D10,$4840
            dc.w    $9044,$4843,$B640,$6D06,$7003,$6000,$0092,$7001
            dc.w    $6000,$008C,$4A45,$6600,$008A,$6100,$FE08,$4267
            dc.w    $2F03,$2F08,$A8AD,$4A1F,$6778,$4A2B,$006F,$676C
            dc.w    $2003,$4840,$204B,$6100,$FC58,$D068,$0006,$906B
            dc.w    $0010,$D06E,$FFFE,$6A54,$0640,$000B,$6B4E,$4A2B
            dc.w    $0070,$6718,$2003,$D068,$0008,$906B,$0012,$0C40
            dc.w    $0012,$6E08,$5140,$6B34,$7004,$6032,$6100,$FBE2
            dc.w    $672A,$3003,$204B,$6100,$FC18,$D068,$0008,$906B
            dc.w    $0016,$0C40,$FFED,$6D14,$0C40,$FFF7,$6E0E,$6100
            dc.w    $FB7C,$6704,$7006,$6006,$7005,$6002,$7002,$2D40
            dc.w    $0014,$4E75
            bsr.w   sub_40876AD2
            beq.b   .L10
            bsr.w   sub_40876A8E
.L10:
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  ($10,A3),(A0)+
            move.l  ($14,A3),(A0)
            movea.l A3,A0
            bsr.w   sub_40876B12
            move.l  (6,A0),-(SP)
            neg.w   (SP)
            neg.w   (2,SP)
            _OffsetRect
            move.l  ($76,A3),-(SP)
            pea     Scratch8
            _RectRgn
            move.l  #$20002,D4
            move.l  ($72,A3),-(SP)
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  MinusOne,-(SP)
            _InsetRect
            tst.w   D5
            bne.b   .L14
            move.w  D7,D0
            subq.w  #1,D0
            sub.w   D0,Scratch8
            lsr.l   #1,D4
.L11:
            _RectRgn
            tst.w   D5
            beq.b   .L12
            cmpi.w  #3,D5
            bne.b   .L13
.L12:
            move.l  (-$C,A6),-(SP)
            pea     Scratch8
            move.l  (SP),-(SP)
            move.l  D4,-(SP)
            _OffsetRect
            _RectRgn
            move.l  ($72,A3),-(SP)
            move.l  (-$C,A6),-(SP)
            move.l  ($72,A3),-(SP)
            _UnionRgn
.L13:
            rts
.L14:
            cmpi.w  #1,D5
            bne.b   .L11
            pea     Scratch8
            move.l  #$FFF9FFF9,-(SP)
            _InsetRect
            bra.b   .L11
            move.l  D3,-(SP)
            move.l  MinusOne,-(SP)
            _InsetRect
            movea.l D3,A3
            move.l  (A3),-(SP)
            move.w  D7,D0
            subq.w  #1,D0
            sub.w   D0,(A3)
            move.l  D3,-(SP)
            _FrameRect
            move.w  (2,A3),-(SP)
            move.w  (4,A3),-(SP)
            subi.w  #$10,(SP)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (6,A3),(2,SP)
            _LineTo
            move.l  (SP),(A3)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (6,A3),(2,SP)
            _LineTo
            move.w  (6,A3),-(SP)
            subi.w  #$10,(SP)
            move.w  (A3),-(SP)
            move.l  (SP),-(SP)
            _MoveTo
            move.w  (4,A3),(SP)
            _LineTo
            move.l  D3,-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            rts
sub_40877018:
            move.l  D4,-(SP)
            _PenSize
            move.w  (6,A4),D0
            move.w  D0,-(SP)
            move.w  (A4),-(SP)
            move.w  D0,-(SP)
            move.w  (4,A4),D0
            move.w  D0,-(SP)
            move.w  (2,A4),-(SP)
            move.w  D0,-(SP)
            add.w   D4,(2,SP)
            add.w   D4,(8,SP)
            _MoveTo
            _LineTo
            _LineTo
            _PenNormal
            rts
sub_40877044:
            lea     ($A0E).w,A0
            move.l  A1,(A0)+
            move.w  #2,(A0)+
            clr.l   (A0)+
            move.l  D1,(A0)
            pea     ($A0E).w
            movea.l (SP),A0
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
            movea.l (A5),A0
            move.l  (A0),-(SP)
            move.l  A3,-(SP)
            _SetPort
            tst.b   (-$22,A6)
            beq.b   .L1
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetForeColor
            subq.w  #6,SP
            move.l  SP,-(SP)
            _GetBackColor
            clr.w   D0
            bsr.w   sub_40876AEA
            _RGBBackColor
            move.w  #1,D0
            bsr.w   sub_40876AEA
            _RGBForeColor
.L1:
            lea     Scratch8,A4
            move.l  ($14,A3),(4,A4)
            move.l  (4,A4),(A4)
            subi.w  #$F,(A4)
            subi.w  #$F,(2,A4)
            tst.b   ($6F,A3)
            beq.b   .L4
            lea     .L5,A1
            moveq   #0,D0
            move.l  #$100010,D1
            bsr.w   sub_40877044
.L2:
            move.w  (2,A4),-(SP)
            move.w  (SP),-(SP)
            move.w  ($10,A3),-(SP)
            _MoveTo
            move.w  ($14,A3),-(SP)
            _LineTo
            move.w  ($12,A3),-(SP)
            move.w  (A4),-(SP)
            _MoveTo
            move.w  ($16,A3),-(SP)
            move.w  (A4),-(SP)
            _LineTo
            tst.b   (-$22,A6)
            beq.b   .L3
            move.l  SP,-(SP)
            _RGBBackColor
            addq.w  #6,SP
            move.l  SP,-(SP)
            _RGBForeColor
            addq.w  #6,SP
.L3:
            _SetPort
            rts
.L4:
            pea     Scratch8
            _EraseRect
            bra.b   .L2
.L5:
            ds.b    6
            dc.w    $1FE0,$1020,$103E,$1022,$1022,$1022,$1022,$1FE2
            dc.w    $0402,$0402,$0402,$07FE
            ds.b    8
RsrcEntryWDEF_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'WDEF' 1 (1284 bytes) - Combo mask
            dc.l    RsrcEntryWDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcWDEF_1-BaseOfROM            ; Data
            dc.b    'WDEF'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000510,$0000010C   ; Block header
RsrcWDEF_1:
            bra.b   .L1
            dc.w    0,$5744,$4546,$0001,$000A
.L1:
            link.w  A6,#-$1E
            movem.l D3-D5/A3-A4,-(SP)
            cmpi.w  #2,($C,A6)
            bgt.w   .L7
            cmpi.w  #0,($C,A6)
            bmi.w   .L7
            movea.l (A5),A0
            move.l  (A0),-(SP)
            cmpi.w  #$3FFF,ROM85
            sls     (-$1E,A6)
            bhi.b   .L2
            bsr.w   UpdateCPort
            pea     (-$1C,A6)
            _GetForeColor
            pea     (-$16,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$10,A6)
            _HLock
            move.l  (A0),(-$C,A6)
            bra.b   .L3
.L2:
            move.l  WMgrPort,-(SP)
            _SetPort
.L3:
            lea     (-8,A6),A3
            move.l  A3,-(SP)
            _GetFontInfo
            move.w  (A3)+,D0
            add.w   (A3)+,D0
            addq.w  #4,D0
            bset    #0,D0
            moveq   #$13,D1
            cmp.w   D1,D0
            bge.b   .L4
            sub.w   D0,D1
            lsr.w   #1,D1
            add.w   D1,(-8,A6)
            moveq   #$13,D0
.L4:
            move.w  D0,(A3)+
            subi.w  #$D,D0
            lsr.w   #1,D0
            move.w  D0,(A3)
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D5
            lsr.w   #1,D5
            asl.w   #2,D5
            clr.l   (A0)
            cmpi.w  #3,D0
            bge.b   .L5
            asl.w   #2,D0
            jsr     .L8(PC,D0.w)
.L5:
            tst.b   (-$1E,A6)
            beq.b   .L6
            pea     (-$1C,A6)
            _RGBForeColor
            pea     (-$16,A6)
            _RGBBackColor
            movea.l (-$10,A6),A0
            _HUnlock
.L6:
            _SetPort
.L7:
            movem.l (SP)+,D3-D5/A3-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            bra.w   sub_408772B2.L13
            bra.w   sub_408774A6.L10
            bra.w   sub_408774A6.L11
.L9:
            rts
UpdateCPort:
            move.l  ($D2C).w,-(SP)
            _SetPort
            movea.l WMgrPort,A0
            movea.l ($D2C).w,A1
            pea     ($20,A0)
            pea     ($3A,A0)
            lea     ($30,A0),A0
            lea     ($30,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            addq.w  #8,A0
            addq.w  #8,A1
            move.w  #$14,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            _PenPat
            _BackPat
            rts
sub_4087728A:
            move.l  D1,-(SP)
            movea.l (-$C,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
sub_408772B2:
            addq.w  #2,A0
            tst.w   (4,A0)
            bpl.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
.L13:
            tst.b   ($6E,A3)
            beq.b   RsrcWDEF_1.L9
            cmpi.w  #4,D3
            beq.w   BuildTBarRect_WDEF_1.L1
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            move.w  (-4,A0),D0
            add.w   (-4,A6),D0
            move.w  D0,(A0)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A4
            pea     Scratch8
            bsr.w   sub_40877480
            move.l  D0,-(SP)
            st      -(SP)
            clr.w   -(SP)
            bsr.w   sub_408774A6
            tst.b   (-$1E,A6)
            beq.b   .L2
            move.w  #1,D0
            bsr.w   sub_4087728A
            _RGBForeColor
            _PenNormal
.L2:
            move.l  A4,-(SP)
            _FrameRgn
            tst.b   (-$1E,A6)
            beq.b   .L5
            tst.b   ($6F,A3)
            bne.b   .L3
            moveq   #4,D0
            bsr.w   sub_4087728A
            _RGBForeColor
            moveq   #1,D0
            bsr.w   sub_4087728A
            bra.b   .L4
.L3:
            moveq   #4,D0
            bsr.w   sub_4087728A
.L4:
            _RGBBackColor
.L5:
            move.l  A4,-(SP)
            move.l  OneOne,-(SP)
            _InsetRgn
            move.l  A4,-(SP)
            tst.b   (-$1E,A6)
            beq.b   .L6
            _PaintRgn
            bra.b   .L7
.L6:
            _EraseRgn
.L7:
            bsr.w   DoTitleString
            tst.b   ($6F,A3)
            beq.b   .L11
            tst.b   ($70,A3)
            beq.b   .L10
            tst.b   (-$1E,A6)
            beq.b   .L8
            moveq   #4,D1
            bra.b   .L9
.L8:
            moveq   #0,D1
.L9:
            lea     sub_40877600.L1,A1
            bsr.b   PlotGoAway
.L10:
            tst.b   (-$1E,A6)
            bne.b   .L11
            subq.w  #1,($9FE).w
            pea     Scratch8
            _InverRect
.L11:
            move.l  A4,-(SP)
            _DisposRgn
            tst.b   (-$1E,A6)
            beq.b   .L12
            moveq   #1,D0
            bsr.w   sub_4087728A
            _RGBForeColor
.L12:
            move.l  ($72,A3),-(SP)
            _FrameRgn
            rts
BuildTBarRect_WDEF_1:
            lea     Scratch8,A0
            movea.l ($72,A3),A1
            movea.l (A1),A1
            addq.w  #2,A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  (A0),D0
            add.w   (-4,A6),D0
            move.w  D0,(4,A0)
            subq.w  #1,(6,A0)
            rts
.L1:
            bsr.b   BuildTBarRect_WDEF_1
            lea     sub_40877600.L1,A1
            lea     ($20,A1),A1
            moveq   #2,D1
PlotGoAway:
            lea     Scratch8,A0
            move.w  (-2,A6),D0
            add.w   D0,(A0)
            subq.w  #1,(A0)
            addq.w  #8,(2,A0)
            move.l  (A0)+,(A0)
            moveq   #$10,D0
            add.w   D0,(A0)+
            add.w   D0,(A0)
            move.w  D1,D0
            move.l  #$100010,D1
            bsr.b   PlotSymbol
            bsr.b   BuildTBarRect_WDEF_1
            rts
PlotSymbol:
            lea     ($A0E).w,A0
            move.l  A1,(A0)
            move.w  #2,(4,A0)
            move.l  #$100010,($A,A0)
            move.l  A0,-(SP)
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
DoTitleString:
            bsr.w   BuildTBarRect_WDEF_1
            move.w  ($A00).w,D3
            sub.w   ($9FC).w,D3
            sub.w   ($8A,A3),D3
            asr.w   #1,D3
            tst.b   ($70,A3)
            beq.b   .L2
            tst.w   D3
            bmi.b   .L1
            cmpi.w  #$1C,D3
            bgt.b   .L2
.L1:
            moveq   #$1C,D3
.L2:
            add.w   ($9FC).w,D3
            move.w  D3,-(SP)
            move.w  Scratch8,D0
            add.w   (-8,A6),D0
            addq.w  #2,D0
            move.w  D0,-(SP)
            _MoveTo
            tst.b   (-$1E,A6)
            beq.b   .L3
            move.w  ($48,A3),-(SP)
            move.w  #4,-(SP)
            _TextMode
.L3:
            movea.l ($86,A3),A0
            _HLock
            move.l  (A0),-(SP)
            _DrawString
            movea.l ($86,A3),A0
            _HUnlock
            tst.b   (-$1E,A6)
            beq.b   .L4
            _TextMode
.L4:
            rts
sub_40877480:
            move.l  .L1(PC,D5.w),D0
            rts
.L1:
            dc.w    $0010,$0010,$0004,$0004,$0006,$0006,$0008,$0008
            dc.w    $000A,$000A,$000C,$000C,$0014,$0014,$0018,$0018
sub_408774A6:
            link.w  A6,#0
            move.l  A3,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            tst.l   ($C,A6)
            bne.b   .L2
.L1:
            move.l  ($14,A6),-(SP)
            move.l  ($10,A6),-(SP)
            _RectRgn
            bra.b   .L5
.L2:
            _HidePen
            _OpenRgn
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            _FrameRoundRect
            move.l  ($14,A6),-(SP)
            _CloseRgn
            _ShowPen
            movea.l ($10,A6),A0
            tst.w   (8,A6)
            bne.b   .L3
            move.w  (4,A0),D1
            move.w  D1,D0
            subq.w  #8,D0
            bra.b   .L4
.L3:
            tst.w   ($A,A6)
            bne.b   .L5
            move.w  (A0),D0
            move.w  D0,D1
            addq.w  #8,D1
.L4:
            lea     ToolScratch,A1
            move.w  D0,(A1)+
            move.w  (2,A0),(A1)+
            move.w  D1,(A1)+
            move.w  (6,A0),(A1)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A3
            pea     ToolScratch
            _RectRgn
            move.l  ($14,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($14,A6),-(SP)
            _UnionRgn
            move.l  A3,-(SP)
            _DisposRgn
.L5:
            movea.l (SP)+,A3
            unlk    A6
            movea.l (SP)+,A0
            lea     ($10,SP),SP
            jmp     (A0)
.L10:
            moveq   #$10,D4
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  ($76,A3),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L6
            moveq   #1,D0
            bra.b   .L8
.L6:
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  ($72,A3),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L9
            clr.w   -(SP)
            move.l  D3,-(SP)
            movea.l ($76,A3),A4
            movea.l (A4),A4
            addq.w  #2,A4
            move.w  (-4,A6),D0
            sub.w   D0,(A4)
            move.l  A4,-(SP)
            _PtInRect
            move.w  (-4,A6),D0
            add.w   D0,(A4)
            tst.b   (SP)+
            beq.b   .L9
            tst.b   ($70,A3)
            beq.b   .L7
            tst.b   ($6F,A3)
            beq.b   .L7
            move.w  D3,D0
            movea.l A3,A0
            bsr.w   sub_408772B2
            add.w   (8,A0),D0
            sub.w   ($12,A3),D0
            cmpi.w  #$12,D0
            bgt.b   .L7
            subq.w  #8,D0
            bmi.b   .L7
            move.l  D3,D0
            swap    D0
            add.w   (6,A0),D0
            sub.w   ($10,A3),D0
            add.w   (-2,A6),D0
            bpl.b   .L7
            addi.w  #$B,D0
            bmi.b   .L7
            moveq   #4,D0
            bra.b   .L8
.L7:
            moveq   #2,D0
.L8:
            move.l  D0,($14,A6)
.L9:
            rts
.L11:
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  ($10,A3),(A0)+
            move.l  ($14,A3),(A0)
            movea.l A3,A0
            bsr.w   sub_408772B2
            move.l  (6,A0),-(SP)
            neg.w   (2,SP)
            neg.w   (SP)
            _OffsetRect
            movea.l ($76,A3),A0
            clr.w   D1
            bsr.b   sub_40877600
            pea     Scratch8
            move.l  MinusOne,-(SP)
            _InsetRect
            move.w  (-4,A6),D0
            subq.w  #1,D0
            sub.w   D0,Scratch8
            moveq   #1,D1
            movea.l ($72,A3),A0
sub_40877600:
            move.l  A0,-(SP)
            pea     Scratch8
            bsr.w   sub_40877480
            move.l  D0,-(SP)
            move.w  D1,-(SP)
            st      -(SP)
            bsr.w   sub_408774A6
            rts
.L1:
            ds.b    4
            dc.w    $7FF0,$4010,$4010,$4010,$4010,$4010,$4010,$4010
            dc.w    $4010,$4010,$7FF0
            ds.b    10
            dc.w    $7FF0,$4210,$5250,$4A90,$4010,$5DD0,$4010,$4A90
            dc.w    $5250,$4210,$7FF0
            ds.b    16
RsrcEntryMDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'MDEF' 0 (3604 bytes) - Combo mask
            dc.l    RsrcEntryWDEF_1-BaseOfROM       ; Next entry
            dc.l    RsrcMDEF_0-BaseOfROM            ; Data
            dc.b    'MDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000E20,$00000104   ; Block header
RsrcMDEF_0:
            bra.b   .L1
            dc.w    0,$4D44,$4546,0,$000C
.L1:
            link.w  A6,#-$44
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($14,A6),A3
            movea.l A3,A0
            _HLock
            clr.w   (-$1C,A6)
            clr.w   (-$1E,A6)
            clr.w   (-$3C,A6)
            cmpi.w  #$3FFF,ROM85
            sls     (-$3C,A6)
            lea     .L3,A0
            move.w  ($18,A6),D0
            cmpi.w  #3,D0
            bhi.b   .L2
            cmpi.w  #0,D0
            bcs.b   .L2
            add.w   D0,D0
            adda.w  .L3(PC,D0.w),A0
            jsr     (A0)
.L2:
            movea.l A3,A0
            _HUnlock
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($12,SP),SP
            jmp     (A0)
.L3:
            dc.w    $04D6,$0008,$09DA,$0AD2,$6100,$029E,$286E,$0008
            dc.w    $3614,$4254,$246E,$0010,$2D52,$FFCC,$2D6A,$0004
            dc.w    $FFD0,$42AE,$FFC8,$302E,$FFFE,$E240,$3D40,$FFC6
            dc.w    $426E,$FFE0,$3003,$2053,$6100,$0960,$0C29,$001B
            dc.w    $0001,$6606,$3D7C,$0001,$FFE0,$3838,$0A0A,$2A2E
            dc.w    $000C,$6700,$0192,$3038,$0A0C,$B06A,$0004,$6F08
            dc.w    $302E,$FFFE,$916A,$0004,$3038,$0A0A,$B052,$6C06
            dc.w    $302E,$FFFE,$D152,$4267,$2F05,$2F0A,$A8AD,$4A1F
            dc.w    $6600,$010A,$BA6A,$0002,$6D00,$015C,$BA6A,$0006
            dc.w    $6E00,$0154,$3E2E,$FFFE,$4845,$BA52,$6C00,$00AA
            dc.w    $D847,$B852,$6E00,$0140,$3012,$9045,$B06E,$FFC6
            dc.w    $6E08,$2D7C,0,$000A,$FFC8,$3038,$0A0C,$B06A
            dc.w    $0004,$6E18,$D06E,$FFFE,$B06A,$0004,$6F0E,$204A
            dc.w    $6100,$048E,$302E,$FFFE,$916A,$0004,$3003,$6100
            dc.w    $0298,$2078,$0B5C,$2050,$4A68,$0010,$6608,$317C
            dc.w    $0001,$0010,$604A,$31C4,$0A0A,$42A7,$A8D8,$2C17
            dc.w    $42A7,$A8D8,$6100,$0B0E,$3D7C,$000A,$FFE6,$6100
            dc.w    $0B5A,$6100,$0104,$2F0A,$4267,$3F07,$2F06,$A8EF
            dc.w    $6100,$013A,$6100,$0B22,$2F17,$A87A,$2F06,$A879
            dc.w    $6100,$034E,$DF78,$0A0C,$2F17,$A879,$A8D9,$A8D9
            dc.w    $4278,$0B56,$6000,$00C6,$302A,$0004,$BA40,$6D00
            dc.w    $0096,$B078,$0A0C,$6C00,$008E,$4447,$D847,$3005
            dc.w    $906A,$0004,$B06E,$FFC6,$6E08,$2D7C,0,$000A
            dc.w    $FFC8,$3038,$0A0A,$B052,$6600,$FF62,$204A,$6100
            dc.w    $040A,$302E,$FFFE,$D152,$6000,$FF52,$B852,$6F06
            dc.w    $B86E,$000C,$6E50,$3404,$7801,$2053,$3004,$6100
            dc.w    $07FA,$6742,$6100,$019E,$D440,$B46E,$000C,$6E04
            dc.w    $5244,$60E6,$41F8,$09FA,$226E,$0010,$2099,$2151
            dc.w    $0004,$3142,$0004,$9440,$3082,$2078,$0B5C,$2050
            dc.w    $2178,$09FA,$0006,$2178,$09FE,$000A,$6100,$0178
            dc.w    $6706,$3884,$6002,$4244,$B654,$6714,$3003,$6100
            dc.w    $0188,$3014,$466E,$FFE4,$6100,$017E,$426E,$FFE4
            dc.w    $2053,$4844,$3810,$4844,$21C4,$0B54,$24AE,$FFCC
            dc.w    $256E,$FFD0,$0004,$4E75
            tst.l   (-$38,A6)
            beq.b   .L8
            move.l  D3,-(SP)
            subq.w  #4,SP
            _TickCount
            move.l  (SP)+,D3
            add.l   (-$38,A6),D3
.L4:
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetMouse
            move.l  (SP)+,D5
            swap    D5
            tst.w   D7
            bge.b   .L5
            move.w  D5,D0
            sub.w   (4,A2),D0
            cmp.w   (-$3A,A6),D0
            bgt.b   .L7
            bra.b   .L6
.L5:
            move.w  (A2),D0
            sub.w   D5,D0
            cmp.w   (-$3A,A6),D0
            bgt.b   .L7
.L6:
            subq.w  #4,SP
            _TickCount
            cmp.l   (SP)+,D3
            bgt.b   .L4
.L7:
            move.l  (SP)+,D3
.L8:
            rts
            tst.w   D7
            bge.b   .L10
            move.w  D7,D0
            neg.w   D0
            add.w   (-2,A6),D0
            add.w   (4,A2),D0
            cmp.w   ($A0C).w,D0
            blt.b   .L9
            movea.l D6,A0
            movea.l (A0),A0
            move.w  (-2,A6),D0
            add.w   D0,(6,A0)
            add.w   D0,(4,A2)
            move.l  D6,-(SP)
            _EraseRgn
.L9:
            rts
.L10:
            move.w  (A2),D0
            sub.w   (-2,A6),D0
            cmp.w   ($A0A).w,D0
            bgt.b   .L11
            movea.l D6,A0
            movea.l (A0),A0
            move.w  (-2,A6),D0
            sub.w   D0,(2,A0)
            sub.w   D0,(A2)
            move.l  D6,-(SP)
            _EraseRgn
.L11:
            rts
sub_40877998:
            lea     (-8,A6),A2
            move.l  A2,-(SP)
            _GetFontInfo
            move.w  (A2)+,D0
            add.w   (A2)+,D0
            tst.w   ROM85
            bmi.b   .L1
            tst.w   SysFontFam
            bne.b   .L2
.L1:
            tst.w   CurFMInput
            bne.b   .L2
            subq.w  #2,(A2)
.L2:
            addq.w  #2,A2
            add.w   D0,(A2)
            subq.l  #2,SP
            move.w  #$20,-(SP)
            _CharWidth
            move.w  (SP)+,(-$A,A6)
            rts
sub_408779CA:
            cmpi.b  #$1C,(1,A1)
            beq.b   .L1
            tst.b   (A1)
            bne.b   .L2
.L1:
            moveq   #0,D1
            rts
.L2:
            tst.b   (-$3C,A6)
            beq.b   .L3
            subq.l  #4,SP
            move.l  #'cicn',-(SP)
            move.w  #$100,D0
            move.b  (A1),D0
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D1
            beq.b   .L3
            move.l  D1,-(SP)
            _LoadResource
            movea.l D1,A0
            movea.l (A0),A0
            move.l  ($A,A0),D1
            sub.l   (6,A0),D1
            bra.b   .L4
.L3:
            move.l  #$200020,D1
.L4:
            cmpi.b  #$1D,(1,A1)
            beq.b   .L5
            cmpi.b  #$1E,(1,A1)
            bne.b   .L6
.L5:
            lsr.l   #1,D1
            bclr    #$F,D1
.L6:
            rts
sub_40877A26:
            movem.l A1,-(SP)
            movea.l A4,A1
            bsr.b   sub_40877A34
            movem.l (SP)+,A1
            rts
sub_40877A34:
            bsr.b   sub_408779CA
            swap    D1
            move.w  (-2,A6),D0
            addq.w  #4,D1
            cmp.w   D0,D1
            blt.b   .L1
            move.w  D1,D0
.L1:
            rts
sub_40877A46:
            movea.l (A3),A0
            move.l  ($A,A0),D0
            cmpi.w  #$1F,D4
            bgt.b   .L1
            btst    D4,D0
            beq.b   .L2
.L1:
            btst    #0,D0
            beq.b   .L2
            move.w  D4,D0
            bsr.w   sub_4087808A
            bsr.w   sub_40877D2A
.L2:
            rts
sub_40877A68:
            movem.l D3-D4,-(SP)
            move.w  D0,D3
            beq.w   .L5
            move.w  ($A0A).w,D2
            moveq   #1,D4
.L1:
            move.w  D4,D0
            movea.l (A3),A0
            bsr.w   sub_4087808A
            beq.w   .L5
            bsr.b   sub_40877A34
            cmp.b   D3,D4
            beq.b   .L2
            add.w   D0,D2
            addq.w  #1,D4
            bra.b   .L1
.L2:
            move.b  (1,A0),D1
            lea     Scratch8,A0
            movea.l ($10,A6),A1
            move.l  (A1)+,(A0)
            move.l  (A1),(4,A0)
            move.w  D2,(A0)
            add.w   D0,D2
            move.w  D2,(4,A0)
            movem.l D3-D7/A2-A4,-(SP)
            move.w  #1,-(SP)
            _TextMode
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),-(SP)
            _GetClip
            subq.w  #2,SP
            move.l  ($10,A6),-(SP)
            pea     Scratch8
            pea     (-$2C,A6)
            _SectRect
            addq.w  #2,SP
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            subq.w  #2,SP
            pea     ($10,A0)
            pea     (-$2C,A6)
            pea     (-$2C,A6)
            _SectRect
            addq.w  #2,SP
            pea     (-$2C,A6)
            _ClipRect
            tst.w   (-$1E,A6)
            bne.b   .L3
            tst.w   (-$3C,A6)
            bne.b   .L3
            tst.w   (-$20,A6)
            bne.b   .L3
            pea     Scratch8
            _InverRect
            bra.b   .L4
.L3:
            bsr.w   sub_40878304
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            pea     Scratch8
            _EraseRect
            bsr.w   sub_40878338
            lea     Scratch8,A0
            move.w  (A0),D3
            add.w   (-8,A6),D3
            bsr.w   sub_40877D3C
.L4:
            move.l  (SP),-(SP)
            _SetClip
            _DisposRgn
            movem.l (SP)+,D3-D7/A2-A4
.L5:
            movem.l (SP)+,D3-D4
            rts
sub_40877B3E:
            move.l  A0,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            _PaintRect
            _PenNormal
            rts
sub_40877B5E:
            move.w  D5,D2
            add.w   D0,D5
            tst.b   ($BAD).w
            bpl.b   .L1
            sub.w   D0,D6
            sub.w   D0,D5
            move.w  D6,D2
.L1:
            rts
            move.w  D4,D2
            moveq   #1,D4
            tst.w   D7
            bge.b   .L2
            move.w  (4,A2),D3
            subq.w  #1,D3
            bra.b   .L3
.L2:
            move.w  (A2),D3
            addq.w  #1,D3
.L3:
            movea.l (A3),A0
            move.w  D4,D0
            bsr.w   sub_4087808A
            beq.b   .L4
            bsr.w   sub_40877A34
            add.w   D0,D2
            cmp.w   D3,D2
            bgt.b   .L5
            addq.w  #1,D4
            bra.b   .L3
.L4:
            subq.w  #1,D4
.L5:
            move.w  D4,D0
            move.w  #1,(-$1E,A6)
            bsr.w   sub_40877A68
            tst.w   D7
            bge.b   .L6
            subq.w  #1,D4
            move.w  D4,D0
            bsr.w   sub_40877A68
            bra.b   .L7
.L6:
            addq.w  #1,D4
            move.w  D4,D0
            bsr.w   sub_40877A68
.L7:
            clr.w   (-$1E,A6)
            rts
            bsr.w   sub_40877998
            movea.l ($10,A6),A0
            clr.w   ($A0C).w
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.w   ($10,A0)
            bsr.b   sub_40877BE2
            bsr.b   sub_40877C30
            rts
sub_40877BE2:
            movem.l D3-D7/A2-A4,-(SP)
            moveq   #1,D4
            move.w  ($A0A).w,D3
            add.w   (-8,A6),D3
            clr.l   -(SP)
            _TextFace
            _TextFont
            move.w  #1,-(SP)
            _TextMode
.L1:
            movea.l ($10,A6),A0
            bsr.w   sub_40877D3C
            beq.b   .L3
            cmpi.b  #$1C,(1,A4)
            beq.b   .L2
            tst.b   (A4)
            beq.b   .L2
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D7
            add.w   D7,D3
.L2:
            add.w   (-2,A6),D3
            addq.w  #1,D4
            bra.b   .L1
.L3:
            sub.w   (-8,A6),D3
            move.w  D3,($A0C).w
            movem.l (SP)+,D3-D7/A2-A4
            rts
sub_40877C30:
            movea.l ($10,A6),A0
            move.w  ($A0C).w,D0
            cmp.w   (4,A0),D0
            ble.b   .L1
            bsr.b   sub_40877C50
.L1:
            movea.l ($10,A6),A0
            move.w  ($A0A).w,D0
            cmp.w   (A0),D0
            bge.b   .L2
            bsr.b   sub_40877C7A
.L2:
            rts
sub_40877C50:
            movem.l D4/A3-A4,-(SP)
            move.w  (4,A0),(-$28,A6)
            move.w  (4,A0),(-$2C,A6)
            move.w  (-2,A6),D0
            sub.w   D0,(-$2C,A6)
            move.w  (2,A0),(-$2A,A6)
            move.w  (6,A0),(-$26,A6)
            lea     sub_40878400.L3,A4
            bra.b   sub_40877C7A.L1
sub_40877C7A:
            movem.l D4/A3-A4,-(SP)
            move.w  (A0),(-$2C,A6)
            move.w  (A0),(-$28,A6)
            move.w  (-2,A6),D0
            add.w   D0,(-$28,A6)
            move.w  (2,A0),(-$2A,A6)
            move.w  (6,A0),(-$26,A6)
            lea     sub_40878400.L4,A4
.L1:
            bsr.w   sub_40878304
            move.w  #$FFFF,D4
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            pea     (-$2C,A6)
            _EraseRect
            moveq   #$E,D0
            _NewHandle
            _HLock
            movea.l (A0),A3
            move.w  #2,(4,A3)
            clr.l   (6,A3)
            move.l  #$100010,($A,A3)
            move.l  A4,(A3)
            move.w  (-4,A6),D0
            add.w   (-$2A,A6),D0
            move.w  D0,(-$2A,A6)
            move.w  D0,(-$26,A6)
            moveq   #$10,D0
            cmp.w   (-2,A6),D0
            bge.b   .L2
            move.w  (-2,A6),D0
.L2:
            add.w   D0,(-$26,A6)
            move.w  (-$2C,A6),(-$28,A6)
            add.w   D0,(-$28,A6)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.l  A3,-(SP)
            pea     (2,A0)
            pea     (6,A3)
            pea     (-$2C,A6)
            move.w  #1,-(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l A3,A0
            _RecoverHandle
            _DisposHandle
            movem.l (SP)+,D4/A3-A4
            bsr.w   sub_40878338
            rts
sub_40877D2A:
            cmpi.b  #$2D,(1,A0)
            bne.b   .L1
            tst.b   (A1)
            bne.b   .L1
            tst.b   (1,A1)
.L1:
            rts
sub_40877D3C:
            move.w  (2,A0),D5
            move.w  (6,A0),D6
            move.w  D4,D0
            movea.l (A3),A0
            bsr.w   sub_4087808A
            beq.w   .L21
            movea.l A0,A2
            movea.l A1,A4
            bsr.w   sub_40878304
            movea.l A2,A0
            movea.l A4,A1
            bsr.b   sub_40877D2A
            bne.b   .L1
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  D3,-(SP)
            move.w  D5,-(SP)
            move.w  (-2,A6),D0
            lsr.w   #1,D0
            sub.w   (-8,A6),D0
            add.w   D0,D3
            move.w  D3,-(SP)
            _MoveTo
            move.w  D6,-(SP)
            move.w  D3,-(SP)
            _LineTo
            move.w  (SP)+,D3
            _PenNormal
            bra.w   .L20
.L1:
            addq.w  #2,D5
            cmpi.b  #$1C,(1,A4)
            beq.b   .L2
            move.b  (A4),D0
            beq.b   .L2
            bsr.w   sub_40877A26
            sub.w   (-2,A6),D0
            move.w  D0,D7
            lsr.w   #1,D0
            add.w   D0,D3
.L2:
            move.w  (-4,A6),D0
            bsr.w   sub_40877B5E
            cmpi.b  #$1B,(1,A4)
            beq.b   .L3
            tst.b   (2,A4)
            beq.b   .L3
            move.w  D2,-(SP)
            move.w  D3,-(SP)
            _MoveTo
            move.w  #4,(-$1A,A6)
            bsr.w   sub_4087835A
            clr.w   D0
            move.b  (2,A4),D0
            move.w  D0,-(SP)
            _DrawChar
.L3:
            movea.l A4,A1
            bsr.w   sub_408779CA
            tst.l   D1
            beq.w   .L12
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            move.w  D3,D1
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D1
            sub.w   (-8,A6),D1
            addq.w  #2,D1
            move.l  (SP)+,D0
            move.w  D1,(A0)+
            move.w  D5,D2
            tst.b   ($BAD).w
            bpl.b   .L4
            move.w  D6,D2
            sub.w   D0,D2
.L4:
            move.w  D2,(A0)+
            move.l  (-4,A0),(A0)
            add.l   D0,(A0)
            add.w   (-$A,A6),D0
            bsr.w   sub_40877B5E
            tst.b   (-$3C,A6)
            beq.b   .L8
            subq.w  #4,SP
            move.w  #$100,D0
            move.b  (A4),D0
            move.w  D0,-(SP)
            _GetCIcon
            move.l  (SP)+,(-$24,A6)
            beq.b   .L8
            cmpi.w  #4,(-$18,A6)
            blt.b   .L5
            pea     RGBBlack
            _RGBForeColor
            pea     RGBWhite
            _RGBBackColor
            bra.b   .L7
.L5:
            pea     RGBBlack
            pea     RGBWhite
            tst.w   (-$1C,A6)
            bne.b   .L6
            _RGBBackColor
            _RGBForeColor
            bra.b   .L7
.L6:
            _RGBForeColor
            _RGBBackColor
.L7:
            move.l  (-$24,A6),-(SP)
            _PlotCIcon
            move.l  (-$24,A6),-(SP)
            _DisposCIcon
            bra.b   .L12
.L8:
            cmpi.b  #$1E,(1,A4)
            bne.b   .L9
            clr.l   -(SP)
            move.l  #'SICN',-(SP)
            bra.b   .L10
.L9:
            clr.l   -(SP)
            move.l  #'ICON',-(SP)
.L10:
            move.w  #$100,D0
            move.b  (A4),D0
            move.w  D0,-(SP)
            _GetResource
            move.l  #$100010,D0
            moveq   #2,D1
            cmpi.b  #$1E,(1,A4)
            beq.b   .L11
            add.l   D0,D0
            add.l   D1,D1
.L11:
            move.l  D0,-(SP)
            move.w  D1,-(SP)
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            bsr.w   sub_40878400
.L12:
            tst.b   (1,A4)
            beq.b   .L16
            cmpi.b  #$1C,(1,A4)
            beq.b   .L16
            cmpi.b  #$1D,(1,A4)
            beq.b   .L16
            cmpi.b  #$1E,(1,A4)
            beq.b   .L16
            move.w  #$10,(-$1A,A6)
            bsr.w   sub_4087835A
            move.w  (-4,A6),D0
            add.w   D0,D0
            sub.w   D0,D6
            move.w  D6,-(SP)
            tst.b   ($BAD).w
            bpl.b   .L13
            addq.w  #2,D5
            move.w  D5,(SP)
            add.w   D0,D5
            add.w   D0,D6
.L13:
            move.w  D3,-(SP)
            _MoveTo
            cmpi.b  #$1B,(1,A4)
            bne.b   .L14
            bsr.w   sub_4087800E
            bra.b   .L16
.L14:
            move.b  ($BAD).w,D1
            ext.w   D1
            bne.b   .L15
            move.w  #$11,-(SP)
            _DrawChar
            clr.w   D0
            move.b  (1,A4),D0
            move.w  D0,-(SP)
            _DrawChar
            bra.b   .L16
.L15:
            clr.w   D0
            move.b  (1,A4),D0
            move.w  D0,-(SP)
            _DrawChar
            move.w  #$11,-(SP)
            _DrawChar
.L16:
            move.w  #$A,(-$1A,A6)
            bsr.w   sub_4087835A
            clr.w   D0
            move.b  (3,A4),D0
            move.w  D0,-(SP)
            _TextFace
            cmpi.b  #$1C,(1,A4)
            bne.b   .L17
            move.b  (A4),D0
            bsr.w   sub_40877FF0
.L17:
            move.b  ($BAD).w,D1
            ext.w   D1
            bne.b   .L18
            move.w  D5,-(SP)
            move.w  D3,-(SP)
            _MoveTo
            move.l  A2,-(SP)
            _DrawString
            bra.b   .L19
.L18:
            lea     Scratch8,A0
            subq.w  #1,D5
            move.w  D3,(A0)
            move.w  (-8,A6),D0
            sub.w   D0,(A0)+
            move.w  D5,(A0)+
            move.w  D3,(A0)
            move.w  (-6,A6),D0
            add.w   D0,(A0)+
            move.w  D6,(A0)
            moveq   #0,D0
            move.b  (A2)+,D0
            move.l  A2,-(SP)
            move.l  D0,-(SP)
            pea     Scratch8
            move.w  D1,-(SP)
            _TETextBox
.L19:
            clr.l   -(SP)
            _TextFace
            _TextFont
            bsr.w   sub_40877A46
            bne.b   .L20
            bsr.b   sub_40877FB2
.L20:
            bsr.w   sub_40878338
            moveq   #1,D0
.L21:
            rts
sub_40877FB2:
            movem.l D3/D7,-(SP)
            tst.b   (A4)
            beq.b   .L1
            move.w  D7,D0
            lsr.w   #1,D0
            sub.w   D0,D7
            add.w   D7,D3
.L1:
            add.w   (-2,A6),D3
            lea     Scratch8,A0
            movea.l ($10,A6),A1
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            sub.w   (-8,A6),D3
            move.w  D3,(4,A0)
            bsr.w   sub_40877A26
            sub.w   D0,D3
            move.w  D3,(A0)
            bsr.w   sub_40877B3E
            movem.l (SP)+,D3/D7
            rts
sub_40877FF0:
            clr.l   -(SP)
            andi.w  #$FF,D0
            move.w  D0,-(SP)
            move.w  #$C,-(SP)
            move.l  #$8404000C,-(SP)
            _ScriptUtil
            move.l  (SP)+,D0
            blt.b   .L1
            move.w  D0,-(SP)
            _TextFont
.L1:
            rts
sub_4087800E:
            movem.l D4/A3,-(SP)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPen
            move.l  (SP)+,D4
            swap    D4
            sub.w   (-8,A6),D4
            swap    D4
            move.l  D4,(-$2C,A6)
            move.l  D4,(-$28,A6)
            move.w  (-2,A6),D4
            cmpi.w  #$10,D4
            ble.b   .L1
            move.w  #$10,D4
.L1:
            add.w   D4,(-$28,A6)
            add.w   D4,(-$26,A6)
            moveq   #$E,D0
            _NewHandle
            _HLock
            movea.l (A0),A3
            move.w  #2,(4,A3)
            clr.l   (6,A3)
            move.l  #$100010,($A,A3)
            lea     sub_40878400.L2,A1
            move.l  A1,(A3)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.l  A3,-(SP)
            pea     (2,A0)
            pea     (6,A3)
            pea     (-$2C,A6)
            move.w  #1,-(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l A3,A0
            _RecoverHandle
            _DisposHandle
            movem.l (SP)+,D4/A3
            rts
sub_4087808A:
            tst.w   D0
            ble.b   .L2
            moveq   #0,D1
            lea     ($E,A0),A1
            move.b  (A1)+,D1
            adda.w  D1,A1
.L1:
            subq.w  #1,D0
            beq.b   .L3
            move.b  (A1)+,D1
            beq.b   .L2
            addq.w  #4,D1
            adda.w  D1,A1
            bra.b   .L1
.L2:
            suba.l  A0,A0
            movea.l A0,A1
            move.l  A0,D0
            clr.l   (-$40,A6)
            clr.l   (-$44,A6)
            rts
.L3:
            tst.b   (A1)
            beq.b   .L2
            movea.l A1,A0
            move.b  (A1)+,D1
            adda.w  D1,A1
            move.l  A0,(-$40,A6)
            move.l  A1,(-$44,A6)
            rts
            clr.w   -(SP)
            _TextFont
            bsr.w   sub_40877998
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.w  ($14,A0),D5
            sub.w   ($10,A0),D5
            tst.w   ROM85
            bmi.b   .L4
            sub.w   MBarHeight,D5
            bne.b   .L5
.L4:
            subi.w  #$14,D5
.L5:
            subi.w  #$10,D5
            moveq   #0,D6
            moveq   #1,D0
            movea.l (A3),A0
            bsr.b   sub_4087808A
            beq.w   .L13
            movea.l A0,A4
.L6:
            moveq   #0,D7
            movea.l (A3),A0
            moveq   #0,D0
            move.b  (A4),D0
            beq.w   .L12
            lea     (1,A4,D0.w),A1
            bsr.w   sub_40877A34
            swap    D1
            move.w  D1,D7
            add.w   (-$A,A6),D7
            swap    D6
            add.w   D0,D6
            cmp.w   D5,D6
            blt.b   .L7
            sub.w   D0,D6
.L7:
            swap    D6
            move.w  (-4,A6),D1
            add.w   D1,D7
            cmpi.b  #$1C,(1,A1)
            beq.b   .L8
            cmpi.b  #$1D,(1,A1)
            beq.b   .L8
            cmpi.b  #$1E,(1,A1)
            beq.b   .L8
            tst.b   (1,A1)
            beq.b   .L8
            add.w   D1,D7
            add.w   D1,D7
            addq.w  #8,D7
.L8:
            moveq   #0,D1
            move.b  (3,A1),D1
            move.w  D1,-(SP)
            _TextFace
            cmpi.b  #$1C,(1,A1)
            bne.b   .L9
            move.b  (A1),D0
            bsr.w   sub_40877FF0
            clr.w   -(SP)
            move.l  A4,-(SP)
            _StringWidth
            clr.w   -(SP)
            _TextFont
            bra.b   .L10
.L9:
            clr.w   -(SP)
            move.l  A4,-(SP)
            _StringWidth
.L10:
            add.w   (SP)+,D7
            cmp.w   D7,D6
            bge.b   .L11
            move.w  D7,D6
.L11:
            moveq   #0,D0
            move.b  (A4),D0
            lea     (5,A4,D0.w),A4
            bra.w   .L6
.L12:
            addq.w  #4,D6
.L13:
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            move.w  ($16,A0),D0
            sub.w   ($12,A0),D0
            subi.w  #$10,D0
            cmp.w   D0,D6
            ble.b   .L14
            move.w  D0,D6
.L14:
            movea.l (A3),A0
            move.w  D6,(2,A0)
            swap    D6
            move.w  D6,(4,A0)
            clr.w   -(SP)
            _TextFace
            rts
            bsr.w   sub_40877998
            movea.l (8,A6),A4
            move.w  (A4),D3
            clr.w   D2
            clr.w   D6
            moveq   #1,D4
.L15:
            cmp.w   D3,D4
            bgt.b   .L16
            move.w  D6,D2
.L16:
            movea.l (A3),A0
            move.w  D4,D0
            bsr.w   sub_4087808A
            beq.b   .L17
            bsr.w   sub_40877A34
            add.w   D0,D6
            addq.w  #1,D4
            bra.b   .L15
.L17:
            tst.w   D2
            bne.b   .L18
            moveq   #1,D4
.L18:
            movea.l (A3),A0
            tst.l   (2,A0)
            bpl.b   .L19
            move.l  D2,-(SP)
            move.l  A3,-(SP)
            _CalcMenuSize
            move.l  (SP)+,D2
.L19:
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A1
            movea.l ($10,A6),A0
            movea.l (A3),A2
            move.w  ($E,A6),D5
            move.w  D5,D4
            sub.w   D2,D4
            cmpi.w  #0,D3
            bne.b   .L20
            move.w  ($14,A1),D0
            sub.w   D5,D0
            subq.w  #8,D0
            cmp.w   D6,D0
            blt.b   .L25
            bra.b   .L21
.L20:
            move.w  ($14,A1),D0
            sub.w   ($10,A1),D0
            subq.w  #8,D0
            cmp.w   D6,D0
            blt.b   .L25
.L21:
            move.w  D4,(A0)
            move.w  D4,(A4)
            move.w  D4,(4,A0)
            add.w   D6,(4,A0)
            move.w  ($10,A1),D0
            add.w   MBarHeight,D0
            addq.w  #2,D0
            cmp.w   D0,D4
            bge.b   .L23
            move.w  D4,D1
.L22:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            blt.b   .L22
            move.w  D1,(A0)
            add.w   D6,D1
            move.w  D1,(4,A0)
            bra.b   .L31
.L23:
            move.w  D4,D0
            add.w   D6,D0
            move.w  ($14,A1),D1
            subq.w  #5,D1
            cmp.w   D1,D0
            ble.b   .L31
.L24:
            sub.w   (-2,A6),D0
            cmp.w   D1,D0
            bgt.b   .L24
            move.w  D0,(4,A0)
            sub.w   D6,D0
            move.w  D0,(A0)
            bra.b   .L31
.L25:
            move.w  D4,(A4)
            move.w  D4,D1
            move.w  D1,(A0)
            cmpi.w  #0,D3
            beq.b   .L29
            move.w  ($10,A1),D0
            addq.w  #2,D0
            cmp.w   D0,D4
            ble.b   .L27
            move.w  D4,D1
.L26:
            sub.w   (-2,A6),D1
            cmp.w   D0,D1
            bge.b   .L26
            add.w   (-2,A6),D1
            move.w  D1,(A0)
            bra.b   .L29
.L27:
            move.w  D4,D1
.L28:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            blt.b   .L28
            move.w  D1,(A0)
.L29:
            move.w  ($14,A1),D0
            subq.w  #5,D0
.L30:
            add.w   (-2,A6),D1
            cmp.w   D0,D1
            ble.b   .L30
            sub.w   (-2,A6),D1
            move.w  D1,(4,A0)
.L31:
            move.w  ($C,A6),D0
            move.w  ($12,A1),D2
            addq.w  #4,D2
            cmp.w   D2,D0
            bge.b   .L32
            move.w  D2,D0
.L32:
            move.w  D0,D1
            add.w   (2,A2),D1
            move.w  ($16,A1),D2
            subq.w  #4,D2
            cmp.w   D2,D1
            ble.b   .L33
            move.w  D2,D1
            move.w  D1,D0
            sub.w   (2,A2),D0
.L33:
            move.w  D0,(2,A0)
            move.w  D1,(6,A0)
            rts
sub_40878304:
            tst.b   (-$3C,A6)
            beq.b   .L1
            pea     (-$10,A6)
            pea     (-$16,A6)
            _GetBackColor
            _GetForeColor
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPort
            movea.l (SP)+,A0
            subq.w  #4,SP
            pea     ($10,A0)
            _GetMaxDevice
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            move.w  ($20,A1),(-$18,A6)
.L1:
            rts
sub_40878338:
            tst.b   (-$3C,A6)
            beq.b   .L1
            pea     (-$10,A6)
            pea     (-$16,A6)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            moveq   #$21,D0
            move.l  D0,-(SP)
            _ForeColor
            moveq   #$1E,D0
            move.l  D0,-(SP)
            _BackColor
.L2:
            rts
sub_4087835A:
            tst.b   (-$3C,A6)
            beq.w   .L7
            cmpi.w  #2,(-$18,A6)
            blt.b   .L4
            tst.w   (-$1C,A6)
            beq.b   .L1
            move.w  #$A,(-$1A,A6)
.L1:
            subq.w  #4,SP
            movea.l (A3),A0
            move.w  (A0),-(SP)
            move.w  D4,-(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L2
            movea.l D1,A0
            move.w  (-$1A,A6),D0
            pea     (0,A0,D0.w)
            pea     ($16,A0)
            bra.b   .L5
.L2:
            subq.w  #4,SP
            movea.l (A3),A0
            move.w  (A0),-(SP)
            clr.w   -(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L3
            movea.l D1,A0
            move.w  #$10,D0
            pea     (0,A0,D0.w)
            pea     ($16,A0)
            bra.b   .L5
.L3:
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D1
            beq.b   .L4
            movea.l D1,A0
            move.w  #$10,D0
            pea     (0,A0,D0.w)
            pea     ($A,A0)
            bra.b   .L5
.L4:
            pea     RGBBlack
            pea     RGBWhite
.L5:
            tst.w   (-$1C,A6)
            beq.b   .L6
            _RGBForeColor
            _RGBBackColor
            bra.b   .L9
.L6:
            _RGBBackColor
            _RGBForeColor
            bra.b   .L9
.L7:
            moveq   #$21,D0
            move.l  D0,-(SP)
            moveq   #$1E,D0
            move.l  D0,-(SP)
            tst.w   (-$1C,A6)
            beq.b   .L8
            _ForeColor
            _BackColor
            bra.b   .L9
.L8:
            _BackColor
            _ForeColor
.L9:
            rts
sub_40878400:
            lea     ($A0E).w,A1
            move.l  ($A,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(A1)+
            move.w  (4,SP),(A1)+
            clr.l   (A1)+
            move.l  (6,SP),(A1)
            move.l  ($E,SP),D1
            lea     ($A0E).w,A1
            move.l  A1,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (2,A0)
            pea     (6,A1)
            move.l  D1,-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
.L1:
            movea.l (SP)+,A0
            lea     ($E,SP),SP
            jmp     (A0)
.L2:
            ds.b    5
            dc.b    $20,$00,$30,$00,$38,$00,$3C,$00,$3E,$00,$3F,$00,$3E,$00,$3C,$00
            dc.b    $38,$00,$30,$00,$20
            ds.b    6
.L3:
            ds.b    10
            dc.b    $7F,$F0,$3F,$E0,$1F,$C0,$0F,$80,$07,$00,$02
            ds.b    11
.L4:
            ds.b    10
            dc.w    $0200,$0700,$0F80,$1FC0,$3FE0,$7FF0
            ds.b    12
RsrcEntryMBDF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'MBDF' 0 (3524 bytes) - Combo mask
            dc.l    RsrcEntryMDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcMBDF_0-BaseOfROM            ; Data
            dc.b    'MBDF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000DD0,$000000FC   ; Block header
RsrcMBDF_0:
            bra.b   .L1
            dc.w    0,$4D42,$4446,0,$000C
.L1:
            link.w  A6,#-$42
            movem.l D3-D5/A2-A4,-(SP)
            movea.l (A5),A0
            move.l  (A0),-(SP)
            clr.w   (-$3A,A6)
            cmpi.w  #$3FFF,ROM85
            sls     (-$3A,A6)
            movea.l ROMBase,A0
            cmpi.b  #3,(8,A0)
            bne.b   .L2
            tst.b   NTSC
            bne.b   .L2
            bset    #7,(-$39,A6)
.L2:
            tst.b   (-$3A,A6)
            beq.b   .L3
            movea.l ($D2C).w,A2
            bra.b   .L4
.L3:
            movea.l WMgrPort,A2
.L4:
            move.l  A2,-(SP)
            _SetPort
            clr.l   -(SP)
            _TextFont
            _TextFace
            movea.l MenuList,A0
            tst.l   (A0)
            bne.b   .L5
            moveq   #$54,D0
            _SysError
.L5:
            _HLock
            movea.l (A0),A3
            lea     .L7,A0
            move.w  ($E,A6),D0
            cmpi.w  #$D,D0
            bhi.b   .L6
            cmpi.w  #0,D0
            bcs.b   .L6
            add.w   D0,D0
            adda.w  .L7(PC,D0.w),A0
            jsr     (A0)
.L6:
            _SetPort
            movea.l MenuList,A0
            _HUnlock
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  #$A,SP
            jmp     (A0)
.L7:
            dc.w    $009A,$03BE,$0446,$0026,$0046,$048A,$0048,$05F2
            dc.w    $0A40,$0AFE,$0B3E,$0B68,$0B92,$0BB6
sub_40878586:
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            _SetClip
            rts
            cmpi.l  #$FFFFFFFF,($B5C).w
            bne.b   .L1
            move.l  #$A8,D0
            _NewHandleClear async
            move.l  A0,($B5C).w
.L1:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            clr.w   (A0)
            rts
            rts
            bsr.b   sub_408785C2
            moveq   #3,D1
            add.w   D0,D1
            swap    D0
            add.w   D0,D1
            move.w  D1,MBarHeight
            rts
sub_408785C2:
            subq.w  #8,SP
            move.l  SP,-(SP)
            _GetFontInfo
            move.l  (SP)+,D0
            swap    D0
            add.w   (2,SP),D0
            addq.w  #1,D0
            swap    D0
            addq.w  #4,SP
            rts
GetMenuAscent:
            bsr.b   sub_408785C2
            swap    D0
            add.w   ($10,A2),D0
            moveq   #0,D4
            move.w  D0,D4
            rts
sub_408785E6:
            move.l  ($1C,A2),-(SP)
            move.w  ($12,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  ($16,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  MBarHeight,D0
            add.w   D0,(SP)
            _SetRecRgn
            rts
            bsr.b   sub_408785E6
            move.l  (8,A6),D3
            bgt.w   .L9
            tst.b   (-$3A,A6)
            beq.b   .L2
            bsr.w   sub_40878802
            bsr.w   sub_4087890C
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L2
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            pea     (4,A0)
            pea     ($16,A0)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            pea     RGBBlack
            pea     RGBWhite
            _RGBBackColor
            _RGBForeColor
.L2:
            pea     ($10,A2)
            btst    #7,(-$39,A6)
            beq.b   .L3
            _EraseRect
            bra.b   .L4
.L3:
            move.l  #$100010,-(SP)
            _EraseRoundRect
.L4:
            tst.b   (-$3A,A6)
            beq.b   .L5
            pea     RGBBlack
            pea     RGBWhite
            _RGBBackColor
            _RGBForeColor
.L5:
            move.l  ($10,A2),Scratch8
            move.l  ($14,A2),($9FE).w
            lea     Scratch8,A0
            btst    #7,(-$39,A6)
            bne.b   .L6
            move.l  A0,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            move.l  #$30003,-(SP)
            _PenSize
            lea     Scratch8,A0
            move.l  A0,-(SP)
            move.l  #$160016,-(SP)
            _FrameRoundRect
.L6:
            _PenNormal
            move.w  ($16,A2),-(SP)
            move.w  ($12,A2),D0
            swap    D0
            move.w  ($10,A2),D0
            add.w   MBarHeight,D0
            subq.w  #1,D0
            move.w  D0,-(SP)
            swap    D0
            move.l  D0,-(SP)
            _MoveTo
            _LineTo
            bsr.w   sub_408788BC
            cmpi.l  #$FFFFFFFF,(8,A6)
            beq.w   .L12
            tst.w   (A3)
            beq.w   .L11
            clr.w   (-$38,A6)
            moveq   #6,D3
.L7:
            move.w  D3,D0
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.b   sub_40878766
            move.w  TheMenu,D0
            movea.l (0,A3,D3.w),A4
            movea.l (A4),A4
            cmp.w   (A4),D0
            bne.b   .L8
            move.w  D3,(-$38,A6)
.L8:
            movea.l (0,A3,D3.w),A0
            _HUnlock
            addq.w  #6,D3
            cmp.w   (A3),D3
            ble.b   .L7
            move.w  (-$38,A6),D0
            beq.b   .L11
            move.w  (-$38,A6),D0
            move.w  D0,D3
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.w   sub_40878A64
            movea.l (0,A3,D3.w),A0
            _HUnlock
            bra.b   .L11
.L9:
            cmp.w   (A3),D3
            bgt.b   .L11
            move.l  D3,D0
            bsr.w   sub_40878AFE
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            bsr.b   sub_40878766
            move.w  TheMenu,D0
            cmp.w   (A4),D0
            bne.b   .L10
            bsr.w   sub_40878A64
.L10:
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L11:
            bsr.w   sub_40878586
.L12:
            rts
sub_40878766:
            clr.w   (-$1A,A6)
            cmpi.w  #6,D3
            bne.b   sub_4087877C
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  #$FFFF,($12,A0)
sub_4087877C:
            bsr.w   GetMenuAscent
            move.w  (4,A3,D3.w),-(SP)
            move.w  ($12,A2),D0
            add.w   D0,(SP)
            addq.w  #8,(SP)
            move.w  D4,-(SP)
            _MoveTo
            clr.w   (-$1C,A6)
            bsr.b   sub_40878810
            pea     Scratch8
            _EraseRect
sub_4087879C:
            move.w  #1,-(SP)
            _TextMode
            tst.b   (-$3A,A6)
            beq.b   .L1
            cmpi.w  #$114,($E,A4)
            bne.b   .L1
            bsr.w   sub_4087890C
            cmpi.w  #4,(-$1E,A6)
            blt.b   .L1
            subq.l  #4,SP
            move.w  #$14,-(SP)
            _GetCIcon
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A1
            movea.l (A1),A0
            movem.l (6,A0),D0-D1
            movem.l D0-D1,(-$14,A6)
            move.l  A1,-(SP)
            pea     (-$14,A6)
            move.l  A1,-(SP)
            pea     (-$14,A6)
            subq.l  #4,SP
            move.l  SP,-(SP)
            _GetPen
            _OffsetRect
            _PlotCIcon
            _DisposCIcon
            bra.b   .L2
.L1:
            pea     ($E,A4)
            _DrawString
.L2:
            bsr.w   sub_408788DE
            bsr.w   sub_408788BC
            rts
sub_40878802:
            pea     (-$2C,A6)
            _GetBackColor
            pea     (-$32,A6)
            _GetForeColor
            rts
sub_40878810:
            tst.b   (-$3A,A6)
            beq.w   .L9
            bsr.b   sub_40878802
            tst.w   (-$1C,A6)
            beq.b   .L1
            lea     (-8,A6),A0
            bra.b   .L2
.L1:
            lea     ($10,A2),A0
.L2:
            bsr.w   sub_40878910
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L6
            subq.w  #4,SP
            move.w  (A4),-(SP)
            clr.w   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L4
            movea.l D0,A0
            tst.w   (-$1C,A6)
            beq.b   .L3
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L7
.L3:
            pea     (4,A0)
            pea     ($A,A0)
            bra.b   .L7
.L4:
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L6
            movea.l D0,A0
            tst.w   (-$1C,A6)
            beq.b   .L5
            pea     ($10,A0)
            pea     ($A,A0)
            bra.b   .L7
.L5:
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L7
.L6:
            pea     RGBBlack
            pea     RGBWhite
.L7:
            tst.w   (-$1A,A6)
            beq.b   .L8
            movea.l (SP),A0
            move.l  (4,SP),(SP)
            move.l  A0,(4,SP)
.L8:
            _RGBBackColor
            _RGBForeColor
            bra.b   .L11
.L9:
            moveq   #$1E,D0
            move.l  D0,-(SP)
            moveq   #$21,D0
            move.l  D0,-(SP)
            tst.w   (-$1A,A6)
            beq.b   .L10
            _BackColor
            _ForeColor
            bra.b   .L11
.L10:
            _ForeColor
            _BackColor
.L11:
            rts
sub_408788BC:
            tst.b   (-$3A,A6)
            beq.b   .L1
            pea     (-$32,A6)
            pea     (-$2C,A6)
            _RGBBackColor
            _RGBForeColor
            bra.b   .L2
.L1:
            moveq   #$21,D0
            move.l  D0,-(SP)
            moveq   #$1E,D0
            move.l  D0,-(SP)
            _BackColor
            _ForeColor
.L2:
            rts
sub_408788DE:
            btst    #0,($D,A4)
            bne.b   .L1
            suba.w  #$12,SP
            move.l  SP,-(SP)
            _GetPenState
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            pea     Scratch8
            _PaintRect
            move.l  SP,-(SP)
            _SetPenState
            lea     ($12,SP),SP
.L1:
            rts
sub_4087890C:
            lea     ($10,A2),A0
sub_40878910:
            subq.w  #4,SP
            move.l  A0,-(SP)
            _GetMaxDevice
            movea.l (SP)+,A0
            movea.l (A0),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.w  ($20,A1),(-$1E,A6)
            rts
            move.l  (8,A6),D1
            swap    D1
            move.w  ($10,A2),D0
            cmp.w   D0,D1
            blt.b   .L5
            add.w   MBarHeight,D0
            cmp.w   D0,D1
            bge.b   .L5
            swap    D1
            move.w  ($12,A2),D0
            cmp.w   D0,D1
            blt.b   .L5
            move.w  ($16,A2),D0
            cmp.w   D0,D1
            bgt.b   .L5
            sub.w   ($12,A2),D1
            cmp.w   (2,A3),D1
            bgt.b   .L4
            cmpi.w  #$A,D1
            blt.b   .L4
            moveq   #0,D0
            move.w  (A3),D0
.L1:
            cmp.w   (4,A3,D0.w),D1
            bge.b   .L2
            subq.w  #6,D0
            bra.b   .L1
.L2:
            move.l  D0,($12,A6)
.L3:
            rts
.L4:
            clr.l   ($12,A6)
            bra.b   .L3
.L5:
            movea.l ($B5C).w,A0
            movea.l (A0),A3
            move.w  (A3),D3
            beq.b   .L8
.L6:
            clr.w   -(SP)
            move.l  (8,A6),-(SP)
            pea     (0,A3,D3.w)
            _PtInRect
            tst.b   (SP)+
            bne.b   .L7
            subi.w  #$1C,D3
            beq.b   .L8
            bra.b   .L6
.L7:
            clr.l   ($12,A6)
            move.w  ($E,A3,D3.w),($14,A6)
            bra.b   .L3
.L8:
            move.l  MinusOne,($12,A6)
            bra.b   .L3
            tst.w   (A3)
            beq.b   .L12
            move.l  (8,A6),D0
            tst.w   D0
            beq.b   .L9
            cmp.w   (A3),D0
            bgt.b   .L12
            move.w  (4,A3,D0.w),D3
            bra.b   .L10
.L9:
            moveq   #$A,D3
            moveq   #6,D4
            move.w  D3,(4,A3,D4.w)
.L10:
            movea.l (0,A3,D4.w),A0
            movea.l (A0),A0
            clr.w   -(SP)
            pea     ($E,A0)
            _StringWidth
            add.w   (SP)+,D3
            addi.w  #$D,D3
            addq.w  #6,D4
            cmp.w   (A3),D4
            bgt.b   .L11
            move.w  D3,(4,A3,D4.w)
            bra.b   .L10
.L11:
            move.w  D3,(2,A3)
.L12:
            rts
            bsr.w   sub_408785E6
            move.w  ($A,A6),D0
            cmpi.w  #0,D0
            beq.w   sub_40878A64.L1
            cmp.w   (2,A3),D0
            bgt.b   .L15
            bsr.w   sub_40878AFE
            moveq   #0,D3
            move.w  ($A,A6),D3
            cmpi.w  #1,(8,A6)
            bgt.b   .L15
            movea.l (0,A3,D3.w),A0
            _HLock
            movea.l (A0),A4
            cmpi.w  #1,(8,A6)
            beq.b   .L13
            bsr.b   sub_40878A3E
            bra.b   .L14
.L13:
            bsr.b   sub_40878A64
.L14:
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L15:
            bsr.w   sub_40878586
            rts
sub_40878A3E:
            move.w  (A3),D0
            addq.w  #6,D0
            movea.l (2,A3,D0.w),A0
            clr.l   (2,A3,D0.w)
            move.l  A0,D0
            bne.b   .L1
            clr.w   TheMenu
            _DrawMenuBar
            bra.b   .L2
.L1:
            move.l  A0,-(SP)
            bsr.w   sub_40878FCA
            addq.w  #4,SP
.L2:
            clr.l   SavedHandle
            rts
sub_40878A64:
            bsr.w   sub_40878E3E
            move.w  (A3),D0
            addq.w  #6,D0
            move.l  SavedHandle,(2,A3,D0.w)
            clr.l   SavedHandle
            move.w  #1,(-$1A,A6)
            bsr.w   sub_4087877C
            rts
.L1:
            tst.b   (-$3A,A6)
            beq.b   .L4
            bsr.w   sub_40878802
            bsr.w   sub_4087890C
            cmpi.w  #2,(-$1E,A6)
            blt.b   .L4
            subq.w  #4,SP
            clr.l   -(SP)
            _GetMCEntry
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            pea     (4,A0)
            pea     ($16,A0)
            bra.b   .L3
.L2:
            pea     RGBBlack
            pea     RGBWhite
.L3:
            _RGBBackColor
            _HiliteColor
            bclr    #7,HiliteMode
.L4:
            subq.w  #4,SP
            _NewRgn
            _OpenRgn
            pea     ($10,A2)
            btst    #7,(-$39,A6)
            beq.b   .L5
            _FrameRect
            bra.b   .L6
.L5:
            move.l  #$100010,-(SP)
            _FrameRoundRect
.L6:
            move.l  (SP),-(SP)
            _CloseRgn
            move.l  (SP),-(SP)
            move.l  ($1C,A2),-(SP)
            move.l  ($1C,A2),-(SP)
            _SectRgn
            _DisposRgn
            pea     ($10,A2)
            _InverRect
            bsr.w   sub_408788BC
            bra.w   sub_40878910.L15
sub_40878AFE:
            tst.w   D0
            beq.b   .L4
            lea     Scratch8,A0
            move.w  ($10,A2),(A0)
            addq.w  #1,(A0)+
            move.w  (4,A3,D0.w),(A0)
            move.w  ($12,A2),D1
            add.w   D1,(A0)
            subq.w  #1,(A0)+
            move.w  ($10,A2),(A0)
            move.w  MBarHeight,D1
            add.w   D1,(A0)
            subq.w  #1,(A0)+
            move.w  ($12,A2),(A0)
            cmp.w   (A3),D0
            beq.b   .L1
            addq.w  #6,D0
            move.w  (4,A3,D0.w),D1
            add.w   D1,(A0)
            bra.b   .L2
.L1:
            move.w  (2,A3),D1
            add.w   D1,(A0)
.L2:
            addq.w  #4,(A0)
.L3:
            rts
.L4:
            lea     Scratch8,A0
            move.w  ($10,A2),(A0)+
            move.w  ($12,A2),(A0)+
            move.w  ($10,A2),(A0)
            move.w  MBarHeight,D1
            add.w   D1,(A0)+
            move.w  ($16,A2),(A0)
            bra.b   .L3
            bsr.w   sub_40878586
            movea.l (8,A6),A0
            lea     (-8,A6),A1
            move.l  (A0),(A1)
            move.l  (4,A0),(4,A1)
            lea     Scratch8,A0
            lea     (-8,A6),A1
            move.l  A0,-(SP)
            move.w  (A1),(A0)
            addq.w  #3,(A0)
            move.w  (2,A1),(2,A0)
            move.l  (4,A1),(4,A0)
            move.l  #$FFFCFFFC,-(SP)
            _InsetRect
            bsr.w   sub_40878E3E
            subq.w  #2,SP
            pea     (-8,A6)
            _EmptyRect
            tst.b   (SP)+
            bne.w   .L7
            tst.b   (-$3A,A6)
            beq.b   .L5
            move.w  ($C,A6),D0
            movea.l (0,A3,D0.w),A1
            movea.l (A1),A4
            move.w  #1,(-$1C,A6)
            clr.w   (-$1A,A6)
            bsr.w   sub_40878810
.L5:
            lea     (-8,A6),A4
            move.l  A4,-(SP)
            _EraseRect
            tst.b   (-$3A,A6)
            beq.b   .L6
            bsr.w   sub_408788BC
.L6:
            _PenNormal
            move.w  (2,A4),-(SP)
            subq.w  #1,(SP)
            move.w  (SP),-(SP)
            move.w  (SP),-(SP)
            move.w  (A4),-(SP)
            _MoveTo
            move.w  (4,A4),-(SP)
            _LineTo
            move.w  (6,A4),-(SP)
            move.w  (4,A4),-(SP)
            _LineTo
            move.w  (6,A4),-(SP)
            move.w  (A4),-(SP)
            subq.w  #1,(SP)
            _LineTo
            move.w  (A4),-(SP)
            subq.w  #1,(SP)
            _LineTo
            move.l  #$20002,-(SP)
            _PenSize
            move.w  (6,A4),D0
            move.w  D0,-(SP)
            move.w  (A4),-(SP)
            addq.w  #2,(SP)
            move.w  D0,-(SP)
            move.w  (4,A4),D0
            move.w  D0,-(SP)
            move.w  (2,A4),-(SP)
            addq.w  #2,(SP)
            move.w  D0,-(SP)
            _MoveTo
            _LineTo
            _LineTo
            _PenNormal
.L7:
            clr.w   (-$24,A6)
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            beq.b   .L8
            move.w  (2,A0,D0.w),D1
            cmp.w   (-6,A6),D1
            blt.b   .L8
            move.w  #1,(-$24,A6)
.L8:
            addi.w  #$1C,(A0)
            move.w  (A0),D0
            move.l  (-8,A6),(0,A0,D0.w)
            move.l  (-4,A6),(4,A0,D0.w)
            move.l  SavedHandle,(8,A0,D0.w)
            move.w  (-$24,A6),($C,A0,D0.w)
            move.w  ($C,A6),D1
            move.w  D1,($E,A0,D0.w)
            move.l  (0,A3,D1.w),($10,A0,D0.w)
            rts
CalcMenuRect:
            move.l  (8,A6),D0
            move.w  (8,A6),(-$26,A6)
            movea.l (0,A3,D0.w),A1
            move.w  (4,A3,D0.w),D3
            add.w   ($12,A2),D3
            movea.l (A1),A0
            tst.l   (2,A0)
            bpl.b   .L1
            move.l  A1,-(SP)
            move.l  A1,-(SP)
            _CalcMenuSize
            movea.l (SP)+,A0
            movea.l (A0),A0
.L1:
            bsr.b   MakeMRect
            rts
MakeMRect:
            move.w  (-$26,A6),D1
            bne.b   MakeHMRect
            clr.w   (-$24,A6)
            move.w  ($10,A2),D1
            add.w   MBarHeight,D1
            move.w  D3,D0
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   StoreRect
            move.w  #1,(-$24,A6)
            move.w  ($16,A2),D3
            subq.w  #8,D3
            sub.w   (2,A0),D3
StoreRect:
            lea     (-8,A6),A1
            move.w  D1,(A1)+
            move.w  D3,(A1)+
            add.w   (4,A0),D1
            move.w  D1,(A1)+
            add.w   (2,A0),D3
            move.w  D3,(A1)
            rts
MakeHMRect:
            movem.l D2-D5/A0-A3,-(SP)
            move.l  D1,D5
            bsr.w   GetSizes
            bsr.w   GetA1SaveData
            move.w  ($14,A1),D2
            movea.l ($10,A1),A3
            movea.l (A3),A3
            moveq   #1,D4
.ItemLoop:
            move.w  D4,D0
            movea.l A3,A0
            bsr.w   GetItemRecord
            bsr.w   GetItemHeight
            add.w   D0,D2
            cmp.w   D5,D2
            bgt.b   .L4
            addq.w  #1,D4
            bra.b   .ItemLoop
.L4:
            sub.w   D0,D2
            move.w  D2,D1
            movem.l (SP)+,D2-D5/A0-A3
            subq.w  #7,D1
            cmp.w   MBarHeight,D1
            bge.b   .L5
            move.w  MBarHeight,D1
.L5:
            addq.w  #7,D1
            move.w  D1,D0
            add.w   (4,A0),D0
            addi.w  #$C,D0
            cmp.w   ($14,A2),D0
            bls.b   .L6
            move.w  ($14,A2),D0
            subi.w  #$C,D0
            sub.w   (4,A0),D0
            move.w  D0,D1
.L6:
            bsr.w   GetA1SaveData
            move.w  ($C,A1),(-$24,A6)
            cmpi.w  #1,(-$24,A6)
            beq.b   .L7
            move.w  (6,A1),D0
            subq.w  #4,D0
            move.w  D0,D3
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   .L8
            move.w  #1,(-$24,A6)
            move.w  (2,A1),D0
            sub.w   (2,A0),D0
            addq.w  #8,D0
            move.w  D0,D3
            subq.w  #8,D0
            cmp.w   ($12,A2),D0
            bge.b   .L8
            move.w  ($12,A2),D0
            addq.w  #8,D0
            move.w  D0,D3
            clr.w   (-$24,A6)
            bra.b   .L8
.L7:
            move.w  (2,A1),D0
            addq.w  #8,D0
            sub.w   (2,A0),D0
            move.w  D0,D3
            subq.w  #8,D0
            cmp.w   ($12,A2),D0
            bgt.b   .L8
            clr.w   (-$24,A6)
            move.w  (6,A1),D0
            subq.w  #4,D0
            move.w  D0,D3
            add.w   (2,A0),D0
            addq.w  #8,D0
            cmp.w   ($16,A2),D0
            ble.b   .L8
            move.w  ($16,A2),D0
            sub.w   (2,A0),D0
            subq.w  #8,D0
            move.w  D0,D3
            move.w  #1,(-$24,A6)
.L8:
            bra.w   StoreRect
GetItemRecord:
            tst.w   D0
            ble.b   .L2
            moveq   #0,D1
            lea     ($E,A0),A1
            move.b  (A1)+,D1
            adda.w  D1,A1
.L1:
            subq.w  #1,D0
            beq.b   .L3
            move.b  (A1)+,D1
            beq.b   .L2
            addq.w  #4,D1
            adda.w  D1,A1
            bra.b   .L1
.L2:
            suba.l  A0,A0
            movea.l A0,A1
            move.l  A0,D0
            rts
.L3:
            tst.b   (A1)
            beq.b   .L2
            movea.l A1,A0
            move.b  (A1)+,D1
            adda.w  D1,A1
            rts
GetSizes:
            lea     (-$42,A6),A2
            move.l  A2,-(SP)
            _GetFontInfo
            move.w  (A2)+,D0
            add.w   (A2)+,D0
            cmpi.w  #$E,(A2)
            bne.b   .L1
            subq.w  #2,(A2)
.L1:
            addq.w  #2,A2
            add.w   D0,(A2)
            rts
GetItemHeight:
            move.w  (-$3C,A6),D0
            cmpi.b  #$1C,(1,A1)
            beq.b   .L1
            tst.b   (A1)
            beq.b   .L1
            moveq   #$24,D0
.L1:
            rts
sub_40878E3E:
            movem.l D3-D4/A3-A4,-(SP)
            tst.b   (-$3A,A6)
            beq.b   .L1
            lea     Scratch8,A0
            bsr.w   sub_40878910
            movea.l A1,A4
            move.l  TheGDevice,-(SP)
            move.l  A0,TheGDevice
            subq.l  #4,SP
            _NewPixMap
            move.l  (SP)+,D0
            move.l  (SP)+,TheGDevice
            tst.l   D0
            beq.w   .L4
            movea.l A4,A1
            movea.l D0,A0
            _HLock
            move.l  A0,SavedHandle
            movea.l (A0),A4
            movea.l ($2A,A4),A0
            _DisposHandle
            move.l  ($2A,A1),($2A,A4)
            move.w  (-$1E,A6),D3
            bra.b   .L2
.L1:
            moveq   #$E,D0
            _NewHandleClear
            bne.w   .L4
            _HLock
            move.l  A0,SavedHandle
            movea.l (A0),A4
            moveq   #1,D3
.L2:
            move.w  ($A00).w,D1
            sub.w   ($9FC).w,D1
            mulu.w  D1,D3
            addi.w  #$F,D3
            lsr.w   #4,D3
            add.w   D3,D3
            move.w  (4,A4),D1
            andi.w  #$C000,D1
            or.w    D3,D1
            move.w  D1,(4,A4)
            move.w  ($9FE).w,D4
            sub.w   Scratch8,D4
            mulu.w  D4,D3
            addq.l  #4,D3
            move.w  #$8F,D0
            _GetToolBoxTrapAddress
            movea.l A0,A1
            move.w  #$9F,D0
            _GetToolBoxTrapAddress
            cmpa.l  A0,A1
            beq.b   .L5
            subq.l  #8,SP
            pea     (4,SP)
            move.w  #$15,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            addq.l  #4,SP
            cmp.l   D3,D0
            bcs.b   .L5
            subq.l  #6,SP
            move.l  D3,-(SP)
            pea     (8,SP)
            move.w  #$1D,-(SP)
            _OSDispatch
            movea.l (SP)+,A3
            tst.w   (SP)+
            bne.b   .L5
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1E,-(SP)
            _OSDispatch
            addq.l  #2,SP
            movea.l (A3),A0
            st      (A0)
            bra.b   .L6
.L3:
            movea.l SavedHandle,A0
            _DisposHandle
.L4:
            clr.l   SavedHandle
            bra.b   .L8
.L5:
            move.l  D3,D0
            _NewHandle
            bne.b   .L3
            _HLock
            movea.l A0,A3
            movea.l (A3),A0
            sf      (A0)
.L6:
            move.l  Scratch8,(6,A4)
            move.l  ($9FE).w,($A,A4)
            addq.l  #4,A0
            move.l  A0,(A4)
            movea.l A4,A0
            move.l  ($50,A2),-(SP)
            moveq   #-1,D0
            move.l  D0,($50,A2)
            pea     (2,A2)
            move.l  A0,-(SP)
            bsr.b   sub_40878F84
            move.l  (SP)+,($50,A2)
            movea.l SavedHandle,A0
            _HUnlock
            movea.l (A0),A4
            move.l  A3,(A4)
            movea.l (A3),A0
            tst.b   (A0)
            beq.b   .L7
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1F,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L8
.L7:
            movea.l A3,A0
            _HUnlock
.L8:
            movem.l (SP)+,D3-D4/A3-A4
            rts
sub_40878F84:
            move.l  (SP)+,D4
            pea     (6,A0)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            move.l  D4,-(SP)
            rts
sub_40878F96:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            adda.w  (A0),A0
            rts
GetA1SaveData:
            movea.l ($B5C).w,A1
            movea.l (A1),A1
            adda.w  (A1),A1
            rts
            bsr.w   sub_40878586
            bsr.b   sub_40878F96
            movea.l (8,A0),A0
            move.l  A0,D0
            beq.b   sub_40878FCA.L5
            move.l  A0,-(SP)
            bsr.b   sub_40878FCA
            addq.w  #4,SP
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            subi.w  #$1C,(A0)
            rts
sub_40878FCA:
            movem.l A3-A4,-(SP)
            movea.l A0,A4
            _HLock
            movea.l (A4),A0
            movea.l (A0),A3
            movea.l (A3),A1
            tst.b   (A1)
            beq.b   .L1
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$1E,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L2
.L1:
            movea.l A3,A0
            _HLock
.L2:
            movea.l (A4),A0
            movea.l (A3),A1
            addq.l  #4,A1
            move.l  A1,(A0)
            move.l  A0,-(SP)
            pea     (2,A2)
            bsr.b   sub_40878F84
            movea.l A4,A0
            _DisposHandle
            movea.l (A3),A0
            tst.b   (A0)
            beq.b   .L3
            subq.l  #2,SP
            move.l  A3,-(SP)
            pea     (4,SP)
            move.w  #$20,-(SP)
            _OSDispatch
            addq.l  #2,SP
            bra.b   .L4
.L3:
            movea.l A3,A0
            _DisposHandle
.L4:
            movem.l (SP)+,A3-A4
            rts
.L5:
            lea     (-8,A6),A1
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            move.l  (0,A0,D0.w),(A1)+
            move.l  (4,A0,D0.w),(A1)+
            addq.w  #2,-(A1)
            addq.w  #2,-(A1)
            subq.w  #1,-(A1)
            subq.w  #1,-(A1)
            subq.w  #4,SP
            _NewRgn
            move.l  (SP),-(SP)
            pea     (-8,A6)
            _RectRgn
            subq.w  #4,SP
            _FrontWindow
            move.l  (4,SP),-(SP)
            _PaintBehind
            _DisposRgn
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            subi.w  #$1C,(A0)
            rts
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L9
.L6:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L7
            subi.w  #$1C,D1
            beq.b   .L9
            bra.b   .L6
.L7:
            lea     (0,A0,D1.w),A1
            move.l  A1,($12,A6)
.L8:
            rts
.L9:
            bsr.w   CalcMenuRect
            lea     Scratch8,A0
            lea     (-8,A6),A1
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.l  A0,($12,A6)
            bra.b   .L8
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L12
.L10:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L11
            subi.w  #$1C,D1
            beq.b   .L12
            bra.b   .L10
.L11:
            move.w  ($A0A).w,($14,A0,D1.w)
            move.w  ($A0C).w,($16,A0,D1.w)
.L12:
            rts
            move.l  (8,A6),D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  (A0),D1
            beq.b   .L15
.L13:
            cmp.w   ($E,A0,D1.w),D0
            beq.b   .L14
            subi.w  #$1C,D1
            beq.b   .L15
            bra.b   .L13
.L14:
            move.w  ($14,A0,D1.w),($A0A).w
            move.w  ($16,A0,D1.w),($A0C).w
.L15:
            rts
            move.l  (8,A6),-(SP)
            move.w  ($12,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  ($16,A2),-(SP)
            move.w  ($10,A2),-(SP)
            move.w  MBarHeight,D0
            add.w   D0,(SP)
            _SetRecRgn
            move.l  (8,A6),($12,A6)
            rts
            clr.l   ($12,A6)
            moveq   #6,D3
            cmp.w   (A3),D3
            bgt.w   .L27
            move.w  (A3),D0
            addq.w  #6,D0
            tst.l   (2,A3,D0.w)
            bne.w   .L27
            movea.l (0,A3,D3.w),A0
            movea.l (A0),A4
            cmpi.w  #$114,($E,A4)
            bne.w   .L27
            _HLock
            bsr.w   sub_408785E6
            clr.w   (-$1A,A6)
            clr.w   (-$1C,A6)
            bsr.w   sub_40878810
            move.l  D3,D0
            bsr.w   sub_40878AFE
            moveq   #$10,D1
            move.w  ($A00).w,D0
            sub.w   ($9FC).w,D0
            sub.w   D1,D0
            cmp.w   D1,D0
            bge.b   .L16
            move.w  D0,D1
.L16:
            pea     Scratch8
            asr.w   #1,D1
            move.l  D1,-(SP)
            _InsetRect
            move.w  ($C,A6),D4
            beq.b   .L17
            subq.l  #4,SP
            _NewRgn
            move.l  (SP)+,D5
            pea     Scratch8
            move.w  D4,-(SP)
            clr.w   -(SP)
            move.l  D5,-(SP)
            _ScrollRect
            move.l  D5,-(SP)
            _SetClip
            move.l  D5,-(SP)
            _DisposRgn
            bra.b   .L18
.L17:
            pea     Scratch8
            _EraseRect
.L18:
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  ($12,A0),D5
            bgt.b   .L19
            move.w  ($A00).w,D5
            sub.w   ($9FC).w,D5
.L19:
            move.w  ($9FC).w,D1
            tst.l   (8,A6)
            bne.b   .L20
            move.w  (4,A3,D3.w),D1
            add.w   ($12,A2),D1
            addq.w  #8,D1
.L20:
            move.w  D4,D0
            blt.b   .L21
            bgt.b   .L22
            moveq   #0,D5
            bra.b   .L23
.L21:
            add.w   D0,D5
            add.w   D5,D1
            bra.b   .L23
.L22:
            sub.w   D0,D5
            sub.w   D5,D1
.L23:
            movea.l ($1C,A2),A0
            movea.l (A0),A0
            move.w  D1,-(SP)
            bsr.w   GetMenuAscent
            move.w  D4,-(SP)
            _MoveTo
            move.l  (8,A6),D0
            beq.b   .L24
            move.l  #$FFF40000,(-$14,A6)
            move.l  #$40010,(-$10,A6)
            pea     (-$14,A6)
            move.l  D0,-(SP)
            pea     (-$14,A6)
            subq.l  #4,-(SP)
            move.l  SP,-(SP)
            _GetPen
            _OffsetRect
            bsr.b   sub_40879244
            bra.b   .L25
.L24:
            bsr.w   sub_4087879C
.L25:
            moveq   #0,D0
            movea.l ($B5C).w,A0
            movea.l (A0),A0
            move.w  D5,($12,A0)
            bgt.b   .L26
            moveq   #-1,D0
.L26:
            move.l  D0,($12,A6)
            bsr.w   sub_408788BC
            bsr.w   sub_40878586
            movea.l (0,A3,D3.w),A0
            _HUnlock
.L27:
            rts
sub_40879244:
            lea     ($A0E).w,A1
            move.l  (4,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(A1)+
            move.w  #2,(A1)+
            clr.l   (A1)+
            move.l  #$100010,(A1)
            move.l  (8,SP),D1
            lea     ($A0E).w,A1
            move.l  A1,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (2,A0)
            pea     (6,A1)
            move.l  D1,-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
.L1:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
            ds.b    14
RsrcEntryCDEF_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CDEF' 1 (1492 bytes) - Combo mask
            dc.l    RsrcEntryMBDF_0-BaseOfROM       ; Next entry
            dc.l    RsrcCDEF_1-BaseOfROM            ; Data
            dc.b    'CDEF'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000005E0,$000000F4   ; Block header
RsrcCDEF_1:
            bra.b   .L1
            dc.w    0,$4344,$4546,$0001,$000A
.L1:
            link.w  A6,#-$32
            movem.l D3-D6/A1-A4,-(SP)
            cmpi.w  #6,($C,A6)
            bls.b   .L2
            cmpi.w  #$A,($C,A6)
            beq.b   .L2
            cmpi.w  #$B,($C,A6)
            bne.w   .L5
.L2:
            pea     (-$14,A6)
            _GetPenState
            _PenNormal
            cmpi.w  #$3FFF,ROM85
            sls     (-$16,A6)
            bhi.b   .L3
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (-$2C,A6)
            _GetForeColor
            pea     (-$32,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.b   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$22,A6)
            _HLock
            move.l  (A0),(-$26,A6)
.L3:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D6
            clr.l   (A0)
            movea.l (A3),A0
            cmpi.w  #6,D0
            bls.w   .L4
            subq.w  #3,D0
.L4:
            add.w   D0,D0
            lea     .L6,A1
            adda.w  (0,A1,D0.w),A1
            jsr     (A1)
            pea     (-$14,A6)
            _SetPenState
            tst.b   (-$16,A6)
            beq.b   .L5
            movea.l (-$22,A6),A0
            _HUnlock
            pea     (-$2C,A6)
            _RGBForeColor
            pea     (-$32,A6)
            _RGBBackColor
.L5:
            movem.l (SP)+,D3-D6/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L6:
            dc.w    $013A,$0326,$03C8,$0464,$0470,$0412,$0490,$03EC
            dc.w    $03FC
.L7:
            dc.w    $FFFF,$8081,$80C1,$80A1,$8F91,$8809,$8805,$8803
            dc.w    $8805,$8809,$8F91,$80A1,$80C1,$8081,$8001,$FFFF
            dc.w    $FFFF,$8081,$80C1,$80E1,$8FF1,$8FF9,$8FFD,$8FFF
            dc.w    $8FFD,$8FF9,$8FF1,$80E1,$80C1,$8081,$8001,$FFFF
.L8:
            dc.w    $FFFF,$8101,$8301,$8501,$89F1,$9011,$A011,$C011
            dc.w    $A011,$9011,$89F1,$8501,$8301,$8101,$8001,$FFFF
            dc.w    $FFFF,$8101,$8301,$8701,$8FF1,$9FF1,$BFF1,$FFF1
            dc.w    $BFF1,$9FF1,$8FF1,$8701,$8301,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8001,$8FE1,$8821,$8821,$8821,$F83D
            dc.w    $A009,$9011,$8821,$8441,$8281,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8001,$8FE1,$8FE1,$8FE1,$8FE1,$FFFD
            dc.w    $BFF9,$9FF1,$8FE1,$87C1,$8381,$8101,$8001,$FFFF
            dc.w    $FFFF,$8001,$8101,$8281,$8441,$8821,$9011,$A009
            dc.w    $F83D,$8821,$8821,$8821,$8FE1,$8001,$8001,$FFFF
            dc.w    $FFFF,$8001,$8101,$8381,$87C1,$8FE1,$9FF1,$BFF9
            dc.w    $FFFD,$8FE1,$8FE1,$8FE1,$8FE1,$8001,$8001,$FFFF
sub_40879498:
            move.l  D1,-(SP)
            movea.l (-$26,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
            tst.b   (-$16,A6)
            beq.b   .L3
            moveq   #0,D0
            bsr.b   sub_40879498
            _RGBForeColor
            moveq   #1,D0
            bsr.b   sub_40879498
            _RGBBackColor
            movea.l (A3),A0
.L3:
            tst.b   ($10,A0)
            beq.w   sub_40879572.L1
            cmpi.b  #$FF,D3
            bne.b   .L4
            moveq   #0,D3
.L4:
            move.b  ($11,A0),D4
            bsr.w   sub_40879698
            bsr.w   TestHV
            move.w  (0,A1,D0.w),D1
            add.w   D2,D1
            move.w  D1,(4,A1,D0.w)
            lea     RsrcCDEF_1.L8,A1
            moveq   #$14,D1
            movem.w D0/D2,-(SP)
            bsr.b   sub_40879572
            bne.b   .L5
            bsr.w   sub_408795E0
.L5:
            bsr.w   sub_40879698
            movem.w (SP)+,D0/D2
            move.w  (4,A1,D0.w),D1
            sub.w   D2,D1
            move.w  D1,(0,A1,D0.w)
            lea     RsrcCDEF_1.L7,A1
            moveq   #$15,D1
            bsr.b   sub_40879572
            bne.b   .L6
            bsr.w   sub_408795E0
.L6:
            cmpi.w  #1,D6
            beq.w   sub_4087957A.L4
            move.w  #$81,D1
            bsr.b   sub_40879572
            bne.b   sub_40879572.L1
            bsr.w   sub_40879698
            move.l  A1,-(SP)
            bsr.w   GetOldStyleLtGray
            move.l  A0,-(SP)
            bsr.b   sub_4087957A
            bne.b   .L7
            movea.l (A5),A0
            lea     (-8,A0),A0
            move.l  A0,(SP)
.L7:
            lea     Scratch8,A1
            movea.l A1,A0
            bsr.b   TestHV
            swap    D2
            move.w  #1,D2
            tst.w   D0
            beq.b   .L8
            swap    D2
.L8:
            move.l  A1,-(SP)
            move.l  D2,-(SP)
            _InsetRect
            _FillRect
            bra.b   sub_4087957A.L2
sub_40879572:
            tst.w   D3
            beq.b   .L1
            cmp.w   D1,D3
.L1:
            rts
sub_4087957A:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            addq.b  #1,D0
            beq.b   .L1
            addq.b  #1,D0
            beq.b   .L1
            move.w  ($14,A0),D0
            cmp.w   ($16,A0),D0
.L1:
            rts
.L2:
            tst.b   (-$16,A6)
            beq.b   .L3
            moveq   #3,D0
            bsr.w   sub_40879498
            _RGBBackColor
.L3:
            bsr.w   CalcIBox
            bsr.b   sub_4087957A
            beq.b   .L4
            move.l  ($1C,A0),-(SP)
            move.l  (SP),-(SP)
            movea.l (A5),A0
            pea     (-8,A0)
            _FillRgn
            _FrameRgn
.L4:
            movea.l (A3),A0
            pea     (8,A0)
            _FrameRect
            rts
TestHV:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (6,A0),D1
            sub.w   (2,A0),D1
            cmp.w   D0,D1
            bgt.b   .L1
            move.w  D1,D2
            moveq   #0,D0
            rts
.L1:
            move.w  D0,D2
            moveq   #2,D0
            rts
sub_408795E0:
            movea.l (A3),A0
            cmp.b   ($11,A0),D1
            bne.b   .L1
            lea     ($20,A1),A1
.L1:
            tst.w   D0
            bne.b   .L2
            lea     ($80,A1),A1
.L2:
            clr.w   D0
            bsr.b   sub_408795FA
            rts
sub_408795FA:
            lea     ($A0E).w,A0
            move.l  A1,(A0)+
            move.w  #2,(A0)+
            clr.l   (A0)+
            move.l  #$100010,(A0)
            pea     ($A0E).w
            movea.l (SP),A0
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     Scratch8
            move.w  D0,-(SP)
            clr.l   -(SP)
            _CopyBits
            rts
CalcIBox:
            move.w  D3,-(SP)
            lea     (-$1E,A6),A1
            bsr.b   GetCtlRect
            moveq   #0,D1
            movea.l (A3),A0
            lea     (8,A0),A0
            bsr.b   TestHV
            move.w  D2,D3
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            sub.w   D2,D1
            sub.w   D2,D1
            sub.w   D2,D1
            movea.l (A3),A0
            move.w  ($12,A0),D2
            sub.w   ($14,A0),D2
            mulu.w  D2,D1
            move.w  ($16,A0),D2
            sub.w   ($14,A0),D2
            beq.b   .L2
            divu.w  D2,D1
            bsr.w   RoundOff
            add.w   D3,D1
.L1:
            lea     (-$1E,A6),A1
            add.w   (0,A1,D0.w),D1
            move.w  D1,(0,A1,D0.w)
            add.w   D3,D1
            move.w  D1,(4,A1,D0.w)
            eori.w  #2,D0
            addq.w  #1,(0,A1,D0.w)
            subq.w  #1,(4,A1,D0.w)
            move.l  ($1C,A0),-(SP)
            move.l  A1,-(SP)
            _RectRgn
            move.w  (SP)+,D3
            rts
.L2:
            move.w  D3,D1
            bra.b   .L1
sub_40879698:
            lea     Scratch8,A1
GetCtlRect:
            movea.l (A3),A0
            lea     (8,A0),A0
            move.l  (A0),(A1)
            move.l  (4,A0),(4,A1)
.L1:
            rts
            move.b  ($11,A0),D4
            cmpi.b  #$FE,D4
            beq.b   .L2
            bsr.w   sub_4087957A
            beq.b   .L1
.L2:
            lea     (8,A0),A4
            clr.w   -(SP)
            move.l  D3,-(SP)
            move.l  A4,-(SP)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L1
            addq.b  #2,D4
            beq.b   .L5
            bsr.b   sub_40879742
            move.w  D3,D1
            sub.w   (0,A4,D0.w),D1
            cmp.w   D2,D1
            bgt.b   .L3
            moveq   #$14,D0
            bra.b   .L4
.L3:
            move.w  (4,A4,D0.w),D1
            sub.w   D3,D1
            cmp.w   D2,D1
            bgt.b   .L6
            moveq   #$15,D0
.L4:
            move.w  D0,($16,A6)
            rts
.L5:
            move.w  #$FE,D0
            bra.b   .L4
.L6:
            cmpi.w  #1,D6
            beq.b   .L1
            bsr.w   CalcIBox
            bsr.b   sub_40879742
            clr.w   -(SP)
            move.l  D3,-(SP)
            movea.l (A3),A0
            move.l  ($1C,A0),-(SP)
            _PtInRgn
            tst.b   (SP)+
            beq.b   .L7
            move.w  #$81,D0
            bra.b   .L4
.L7:
            bsr.b   sub_40879742
            movea.l (A3),A0
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            lsr.w   #1,D1
            add.w   (0,A0,D0.w),D1
            cmp.w   D1,D3
            blt.b   .L8
            moveq   #$17,D0
            bra.b   .L4
.L8:
            moveq   #$16,D0
            bra.b   .L4
sub_40879742:
            movea.l A4,A0
            bsr.w   TestHV
            bne.b   .L1
            swap    D3
.L1:
            rts
            tst.l   D3
            bpl.b   .L3
            andi.l  #$FFFFFF,D3
.L2:
            bsr.w   CalcIBox
            movea.l (A3),A0
            move.l  ($1C,A0),-(SP)
            move.l  D3,-(SP)
            _CopyRgn
            bsr.b   GetOldStyleLtGray
            move.l  (A0)+,DragPattern
            move.l  (A0),($A38).w
            rts
            move.b  #1,($17,A6)
.L3:
            move.l  D3,-(SP)
            pea     (8,A0)
            _RectRgn
            rts
            move.b  #1,($17,A6)
            bra.b   .L2
GetOldStyleLtGray:
            subq.w  #4,SP
            move.w  #$11,-(SP)
            _GetPattern
            movea.l (SP)+,A0
            movea.l (A0),A0
            rts
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            lea     (2,A0),A4
            add.w   (2,A4),D3
            swap    D3
            add.w   (A4),D3
            movea.l (A3),A0
            lea     (8,A0),A0
            bsr.w   TestHV
            beq.b   .L1
            swap    D3
.L1:
            sub.w   (0,A0,D0.w),D3
            sub.w   D2,D3
            move.w  (4,A0,D0.w),D1
            sub.w   (0,A0,D0.w),D1
            sub.w   D2,D1
            sub.w   D2,D1
            sub.w   D2,D1
            move.w  D1,D2
            movea.l (A3),A0
            move.w  ($16,A0),D1
            sub.w   ($14,A0),D1
            mulu.w  D3,D1
            divu.w  D2,D1
            bsr.b   RoundOff
            add.w   ($14,A0),D1
            move.l  A3,-(SP)
            move.w  D1,-(SP)
            _SetCtlValue
            rts
            subq.w  #4,SP
            _NewRgn
            movea.l (A3),A0
            move.l  (SP)+,($1C,A0)
            rts
            movea.l ($1C,A0),A0
            _DisposHandle
            rts
RoundOff:
            move.w  D0,-(SP)
            move.w  D2,D0
            lsr.w   #1,D0
            swap    D1
            cmp.w   D0,D1
            ble.b   .L2
            swap    D1
            addq.w  #1,D1
.L1:
            move.w  (SP)+,D0
            rts
.L2:
            swap    D1
            bra.b   .L1
            movea.l D3,A4
            move.l  (A4),D3
            lea     (A4),A2
            movea.l A2,A1
            bsr.w   GetCtlRect
            movea.l A2,A0
            bsr.w   TestHV
            move.w  D2,-(SP)
            swap    D2
            move.w  #$FFE8,D2
            move.w  D0,D4
            beq.b   .L3
            swap    D2
            bra.b   .L4
.L3:
            swap    D3
.L4:
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            _InsetRect
            lea     (8,A4),A0
            move.l  (A4),(A0)
            move.l  (4,A4),(4,A0)
            move.l  #$FF800000,D0
            tst.w   D4
            beq.b   .L5
            swap    D0
.L5:
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            _InsetRect
            movea.l (A3),A0
            movea.l ($1C,A0),A0
            movea.l (A0),A0
            sub.w   (2,A0,D4.w),D3
            add.w   D3,(0,A2,D4.w)
            move.w  (SP)+,D2
            subq.w  #1,D2
            sub.w   D2,(4,A2,D4.w)
            add.w   D3,(4,A2,D4.w)
            lsr.w   #1,D4
            eori.w  #1,D4
            addq.w  #1,D4
            move.w  D4,($10,A4)
            rts
            ds.b    8
RsrcEntryCDEF_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CDEF' 0 (1268 bytes) - Combo mask
            dc.l    RsrcEntryCDEF_1-BaseOfROM       ; Next entry
            dc.l    RsrcCDEF_0-BaseOfROM            ; Data
            dc.b    'CDEF'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000500,$000000EC   ; Block header
RsrcCDEF_0:
            bra.b   .L1
            dc.w    0,$4344,$4546,0,$000A
.L1:
            link.w  A6,#-$38
            movem.l D3-D7/A1-A4,-(SP)
            cmpi.w  #2,($C,A6)
            bls.b   .L2
            cmpi.w  #$A,($C,A6)
            beq.b   .L2
            cmpi.w  #$B,($C,A6)
            bne.w   .L8
.L2:
            pea     (-$14,A6)
            _GetPenState
            _PenNormal
            cmpi.w  #$3FFF,ROM85
            sls     (-$16,A6)
            bhi.b   .L5
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($48,A0),-(SP)
            move.w  #1,-(SP)
            _TextMode
            pea     (-$32,A6)
            _GetForeColor
            pea     (-$38,A6)
            _GetBackColor
            clr.l   -(SP)
            clr.b   -(SP)
            move.l  ($E,A6),-(SP)
            pea     (6,SP)
            _GetAuxCtl
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            move.l  A0,(-$22,A6)
            _HLock
            move.l  (A0),(-$26,A6)
            clr.l   -(SP)
            clr.b   -(SP)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.l  (4,A0),-(SP)
            pea     (6,SP)
            _GetAuxWin
            addq.w  #2,SP
            movea.l (SP)+,A0
            movea.l (A0),A0
            movea.l (8,A0),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            mulu.w  #8,D0
.L3:
            tst.w   (8,A0,D0.w)
            beq.b   .L4
            subq.w  #8,D0
            bge.b   .L3
            moveq   #0,D0
.L4:
            move.l  ($A,A0,D0.w),(-$2C,A6)
            move.w  ($E,A0,D0.w),(-$28,A6)
.L5:
            lea     (8,A6),A0
            move.l  (A0)+,D3
            move.w  (A0)+,D0
            movea.l (A0)+,A3
            move.w  (A0)+,D6
            move.w  D6,D7
            andi.w  #7,D6
            clr.l   (A0)
            movea.l (A3),A0
            cmpi.w  #2,D0
            bls.w   .L6
            subq.w  #7,D0
.L6:
            add.w   D0,D0
            lea     .L9,A1
            adda.w  (0,A1,D0.w),A1
            jsr     (A1)
            tst.b   (-$16,A6)
            beq.b   .L7
            movea.l (-$22,A6),A0
            _HUnlock
            pea     (-$32,A6)
            _RGBForeColor
            pea     (-$38,A6)
            _RGBBackColor
            _TextMode
.L7:
            pea     (-$14,A6)
            _SetPenState
.L8:
            movem.l (SP)+,D3-D7/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
.L9:
            dc.w    $0034,$028C,$02C4,$02BE,$02BE
.L10:
            rts
sub_408799E4:
            move.l  D1,-(SP)
            movea.l (-$26,A6),A0
            move.w  (6,A0),D1
            mulu.w  #8,D1
.L1:
            cmp.w   (8,A0,D1.w),D0
            beq.b   .L2
            subq.w  #8,D1
            bge.b   .L1
            moveq   #0,D1
.L2:
            lea     ($A,A0,D1.w),A0
            move.l  A0,D0
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D0,-(SP)
            jmp     (A0)
            tst.b   ($10,A0)
            beq.b   RsrcCDEF_0.L10
            bsr.w   sub_40879C4A
            tst.b   (-$16,A6)
            beq.b   .L7
            tst.b   D6
            beq.b   .L3
            pea     (-$2C,A6)
            bra.b   .L6
.L3:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            subq.b  #1,D0
            cmpi.b  #$FD,D0
            bcc.b   .L4
            moveq   #2,D0
            bra.b   .L5
.L4:
            moveq   #1,D0
.L5:
            bsr.b   sub_408799E4
.L6:
            _RGBBackColor
            movea.l (A3),A0
.L7:
            lea     (8,A0),A4
            tst.b   D6
            beq.b   .L8
            tst.b   D3
            bne.b   .L9
.L8:
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _EraseRoundRect
.L9:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($44,A0),-(SP)
            move.w  ($4A,A0),-(SP)
            subq.w  #8,D7
            bge.b   .L11
            clr.l   ($44,A0)
            move.w  #$C,D0
            tst.w   ROM85
            bmi.b   .L10
            move.w  SysFontSize,D0
            bne.b   .L10
            move.b  FMDefaultSize,D0
.L10:
            move.w  D0,($4A,A0)
.L11:
            move.l  ($1C,A0),-(SP)
            clr.l   -(SP)
            _NewRgn
            movea.l (SP),A2
            _GetClip
            movea.l (A3),A0
            pea     (8,A0)
            _ClipRect
            move.l  A2,-(SP)
            move.l  (4,SP),-(SP)
            _SectRgn
            movem.l D4/A2-A3,-(SP)
            movea.l (A3),A0
            lea     ($28,A0),A2
            lea     (8,A0),A4
            moveq   #0,D7
            move.b  (A2),D7
            beq.w   .L20
            moveq   #0,D4
.L12:
            addq.w  #1,D4
            bsr.w   Pt2Next
            tst.b   D7
            bpl.b   .L12
            move.b  (A2),D7
            subq.w  #8,SP
            movea.l SP,A3
            move.l  A3,-(SP)
            _GetFontInfo
            bsr.w   sub_40879BF4
            mulu.w  D4,D0
            move.w  (4,A4),D1
            move.w  D1,D5
            sub.w   (A4),D1
            sub.w   D0,D1
            asr.w   #1,D1
            sub.w   D1,D5
            sub.w   (6,A3),D5
            sub.w   (2,A3),D5
.L13:
            bsr.w   Pt2Next
            clr.w   -(SP)
            move.l  A2,-(SP)
            move.w  D7,D0
            addq.b  #2,D0
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            _TextWidth
            move.w  (SP)+,D0
            tst.b   D6
            beq.b   .L15
            tst.w   ROM85
            bmi.b   .L14
            tst.w   TESysJust
            beq.b   .L14
            move.w  (6,A4),D1
            sub.w   (2,A4),D1
            sub.w   D0,D1
            subi.w  #$12,D1
            add.w   (2,A4),D1
            bra.b   .L16
.L14:
            move.w  (2,A4),D1
            addi.w  #$12,D1
            bra.b   .L16
.L15:
            move.w  (6,A4),D1
            sub.w   (2,A4),D1
            sub.w   D0,D1
            asr.w   #1,D1
            add.w   (2,A4),D1
.L16:
            move.w  D1,-(SP)
            move.w  D5,-(SP)
            _MoveTo
            tst.b   (-$16,A6)
            beq.b   .L19
            tst.b   D6
            bne.b   .L17
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.b  ($11,A0),D0
            subq.w  #1,D0
            cmpi.b  #$FD,D0
            bcc.b   .L17
            move.w  #1,D0
            bra.b   .L18
.L17:
            move.w  #2,D0
.L18:
            bsr.w   sub_408799E4
            _RGBForeColor
.L19:
            move.l  A2,-(SP)
            move.w  D7,D0
            addq.b  #2,D0
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            _DrawText
            bsr.w   sub_40879BF4
            sub.w   D0,D5
            tst.b   D7
            bpl.w   .L13
            addq.w  #8,SP
.L20:
            movem.l (SP)+,D4/A2-A3
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (SP)+,($4A,A0)
            move.l  (SP)+,($44,A0)
            tst.b   (-$16,A6)
            beq.b   .L21
            moveq   #0,D0
            bsr.w   sub_408799E4
            _RGBForeColor
.L21:
            tst.b   D6
            bne.w   sub_40879C4A.L6
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _FrameRoundRect
            tst.b   (-$16,A6)
            beq.b   .L22
            movea.l (A3),A0
            cmpi.b  #$FE,($11,A0)
            bcc.b   sub_40879BF4.L1
            bra.b   .L23
.L22:
            movea.l (A3),A0
            move.b  ($11,A0),D0
            beq.b   .L23
            cmpi.b  #$FE,D0
            bcc.b   sub_40879BF4.L1
            move.l  A4,-(SP)
            move.l  D4,-(SP)
            _InverRoundRect
.L23:
            _PenNormal
            move.l  A2,-(SP)
            _SetClip
            move.l  A2,-(SP)
            _DisposRgn
            rts
Pt2Next:
            moveq   #0,D3
            tst.b   D7
            beq.b   .L2
.L1:
            cmpi.b  #$D,(0,A2,D7.w)
            beq.b   .L2
            addq.w  #1,D3
            subq.b  #1,D7
            bne.b   .L1
.L2:
            subq.b  #1,D7
            rts
sub_40879BF4:
            moveq   #0,D0
            add.w   (A3),D0
            add.w   (2,A3),D0
            add.w   (6,A3),D0
            rts
.L1:
            bsr.b   DisableText
            bra.b   sub_408799E4.L23
DisableText:
            tst.b   (-$16,A6)
            beq.b   .L1
            tst.b   D6
            bne.b   .L1
            moveq   #2,D0
            bsr.w   sub_408799E4
            _RGBForeColor
            moveq   #1,D0
            bsr.w   sub_408799E4
            _RGBBackColor
.L1:
            move.l  A4,-(SP)
            move.l  #$10003,-(SP)
            _InsetRect
            move.l  A4,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _PenPat
            move.w  #$B,-(SP)
            _PenMode
            _PaintRect
            _PenNormal
            move.l  A4,-(SP)
            move.l  #$FFFFFFFD,-(SP)
            _InsetRect
            rts
sub_40879C4A:
            tst.b   D6
            bne.b   .L1
            move.w  ($C,A0),D4
            sub.w   (8,A0),D4
            lsr.w   #1,D4
            move.w  D4,D0
            swap    D4
            move.w  D0,D4
            rts
.L1:
            moveq   #0,D4
            rts
            move.b  ($11,A0),D4
            addq.b  #1,D4
            beq.b   .L2
            clr.w   -(SP)
            move.l  D3,-(SP)
            pea     (8,A0)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L2
            addq.b  #1,D4
            beq.b   .L3
            move.w  #$A,($16,A6)
            tst.b   D6
            beq.b   .L2
            addq.w  #1,($16,A6)
.L2:
            rts
.L3:
            move.w  #$FE,($16,A6)
            rts
            move.b  #1,($17,A6)
            tst.b   D6
            bne.b   .L5
            bsr.b   sub_40879C4A
            _HidePen
            _OpenRgn
            movea.l A3,A0
            _HLock
            movea.l (A3),A0
            pea     (8,A0)
            move.l  D4,-(SP)
            _FrameRoundRect
            move.l  D3,-(SP)
            _CloseRgn
            _ShowPen
            movea.l A3,A0
            _HUnlock
.L4:
            movea.l (A5),A0
            lea     (-$18,A0),A0
            move.l  (A0)+,DragPattern
            move.l  (A0),($A38).w
            rts
.L5:
            move.l  D3,-(SP)
            pea     (8,A0)
            _RectRgn
            bra.b   .L4
.L6:
            tst.b   (-$16,A6)
            beq.b   .L7
            pea     (-$2C,A6)
            _RGBBackColor
.L7:
            subq.w  #8,SP
            move.w  (4,A4),D0
            move.w  D0,D1
            sub.w   (A4),D0
            subi.w  #$C,D0
            asr.w   #1,D0
            sub.w   D0,D1
            move.w  D1,(4,SP)
            subi.w  #$C,D1
            move.w  D1,(SP)
            tst.w   ROM85
            bmi.b   .L8
            tst.w   TESysJust
            beq.b   .L8
            move.w  (6,A4),D1
            subq.w  #2,D1
            move.w  D1,(6,SP)
            subi.w  #$C,D1
            move.w  D1,(2,SP)
            bra.b   .L9
.L8:
            move.w  (2,A4),D1
            addq.w  #2,D1
            move.w  D1,(2,SP)
            addi.w  #$C,D1
            move.w  D1,(6,SP)
.L9:
            move.l  SP,-(SP)
            _EraseRect
            movea.l (A3),A0
            move.w  ($12,A0),D5
            move.b  ($11,A0),D0
            beq.b   .L11
            cmpi.b  #$FE,D0
            bcs.b   .L10
            bsr.w   DisableText
            bra.b   .L11
.L10:
            move.l  #$20002,-(SP)
            _PenSize
.L11:
            move.l  SP,-(SP)
            cmpi.b  #2,D6
            beq.b   .L12
            _FrameRect
            bra.b   .L13
.L12:
            _FrameOval
.L13:
            _PenNormal
            lsr.w   #1,D5
            bcc.b   .L15
            cmpi.w  #2,D6
            beq.b   .L14
            move.l  SP,-(SP)
            move.l  OneOne,-(SP)
            _InsetRect
            move.l  (SP),-(SP)
            _MoveTo
            move.l  (4,SP),-(SP)
            _LineTo
            move.w  (6,SP),-(SP)
            move.w  (2,SP),-(SP)
            subq.w  #1,(SP)
            _MoveTo
            move.w  (2,SP),-(SP)
            subq.w  #1,(SP)
            move.w  (6,SP),-(SP)
            _LineTo
            bra.b   .L15
.L14:
            move.l  SP,-(SP)
            move.l  #$30003,-(SP)
            _InsetRect
            move.l  SP,-(SP)
            _PaintOval
.L15:
            addq.w  #8,SP
            bra.w   sub_408799E4.L23
RsrcEntryPACK_7:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 7 (1380 bytes) - Combo mask
            dc.l    RsrcEntryCDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcPACK_7-BaseOfROM            ; Data
            dc.b    'PACK'                          ; Type
            dc.w    7                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000570,$000000E4   ; Block header
RsrcPACK_7:
            bra.b   .L1
            dc.w    0,$5041,$434B,$0007,$0001
.L1:
            subq.w  #1,(4,SP)
            bpl.b   sub_40879E54.L3
            move.l  (SP),(2,SP)
            addq.w  #2,SP
            movem.l D0-D6/A1,-(SP)
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            moveq   #$1F,D6
            lea     (1,A0),A1
            tst.l   D0
            bgt.b   .L3
            bmi.b   .L2
            move.b  #$30,(A1)+
            bra.b   .L4
.L2:
            move.b  #$2D,(A1)+
            neg.l   D0
.L3:
            add.l   D0,D0
            abcd    D5,D5
            abcd    D4,D4
            abcd    D3,D3
            abcd    D2,D2
            abcd    D1,D1
            dbra    D6,.L3
            bsr.b   sub_40879E4E
            move.b  D2,D1
            bsr.b   sub_40879E4E
            move.b  D3,D1
            bsr.b   sub_40879E4E
            move.b  D4,D1
            bsr.b   sub_40879E4E
            move.b  D5,D1
            bsr.b   sub_40879E4E
.L4:
            move.w  A1,D0
            sub.w   A0,D0
            subq.b  #1,D0
            move.b  D0,(A0)
            movem.l (SP)+,D0-D6/A1
            rts
sub_40879E4E:
            ror.w   #4,D1
            bsr.b   sub_40879E54
            rol.w   #4,D1
sub_40879E54:
            tst.w   D6
            bpl.b   .L1
            tst.b   D1
            beq.b   .L2
            moveq   #0,D6
.L1:
            ori.b   #$30,D1
            move.b  D1,(A1)+
            sub.b   D1,D1
.L2:
            rts
.L3:
            move.w  (4,SP),D0
            move.l  (SP),(2,SP)
            addq.w  #2,SP
            subq.w  #1,D0
            bpl.b   .L7
            movem.l D1-D3/A0,-(SP)
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D3
            move.b  (A0)+,D2
            beq.b   .L6
            cmpi.b  #$2B,(A0)
            beq.b   .L4
            cmpi.b  #$2D,(A0)
            bne.b   .L5
            moveq   #1,D3
.L4:
            addq.l  #1,A0
            subq.b  #1,D2
            beq.b   .L6
.L5:
            moveq   #$F,D1
            and.b   (A0)+,D1
            add.l   D0,D0
            add.l   D0,D1
            lsl.l   #2,D0
            add.l   D1,D0
            subq.b  #1,D2
            bne.b   .L5
            tst.b   D3
            beq.b   .L6
            neg.l   D0
.L6:
            movem.l (SP)+,D1-D3/A0
            rts
.L7:
            subq.w  #1,D0
            bmi.b   .L8
            beq.b   .L9
            cmpi.w  #1,D0
            beq.b   .L10
            rts
.L8:
            jmp     .L12
.L9:
            jmp     sub_4087A15E.L2
.L10:
            jmp     .L11
            dc.w    0
.L11:
            moveq   #1,D1
            ror.l   #1,D1
            bra.b   .L13
.L12:
            moveq   #0,D1
.L13:
            link.w  A6,#0
            movem.l D2-D7/A2-A3,-(SP)
            movem.l ($C,A6),D4-D6
            move.l  D6,D0
            _StripAddress
            movea.l D0,A0
            movea.l D5,A1
            moveq   #0,D6
            move.b  (A0),D6
            lea     (0,A0,D6.w),A3
            adda.w  (A1),A0
            move.l  A0,D6
            movea.l D4,A1
            lea     (4,A1),A2
            move.l  D1,D4
            addi.b  #$30,D4
            moveq   #$39,D7
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D5
            clr.l   (A1)
            move.l  #$54E3030,(A2)
            move.w  #$3131,(4,A2)
.L14:
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$20,D0
            beq.b   .L14
            cmpi.b  #$CA,D0
            beq.b   .L14
            cmpi.b  #9,D0
            beq.b   .L14
            cmpi.b  #$2B,D0
            beq.b   .L15
            cmpi.b  #$2D,D0
            bne.b   .L16
            addq.b  #1,(A1)
.L15:
            bsr.b   GetChar_Str2Dec
.L16:
            cmpi.b  #$30,D0
            bcs.b   .L17
            bhi.b   .L18
            bset    #$F,D4
            moveq   #-1,D6
            bsr.b   GetChar_Str2Dec
            bra.b   .L16
.L17:
            cmpi.b  #$2E,D0
            beq.w   GetChar_Str2Dec.L5
            tst.w   D4
            bpl.w   GetChar_Str2Dec.L26
            bra.w   GetChar_Str2Dec.L16
.L18:
            cmpi.b  #$39,D0
            bls.b   .L19
            tst.w   D4
            bpl.w   GetChar_Str2Dec.L23
            bra.w   GetChar_Str2Dec.L10
.L19:
            moveq   #-1,D6
.L20:
            bsr.b   AppendDigit
            bcs.b   .L21
            cmpi.b  #$39,D0
            bls.b   .L20
.L21:
            cmpi.b  #$2E,D0
            bne.w   GetChar_Str2Dec.L10
            bsr.b   GetChar_Str2Dec
            bcs.w   GetChar_Str2Dec.L16
            bra.b   GetChar_Str2Dec.L9
AppendDigit:
            cmpi.b  #$13,D2
            blt.b   .L1
            bgt.b   .L2
            addq.w  #1,D1
.L1:
            addq.l  #1,A2
            move.b  D0,(A2)
            addq.b  #1,D2
            bra.b   GetChar_Str2Dec
.L2:
            or.b    D0,(A2)
            addq.w  #1,D1
GetChar_Str2Dec:
            tst.l   D4
            bpl.b   .L1
            move.b  (A0)+,D0
            beq.b   .L4
            bra.b   .L2
.L1:
            cmpa.l  A0,A3
            blt.b   .L3
            move.b  (A0)+,D0
.L2:
            cmpi.b  #$30,D0
            rts
.L3:
            addq.l  #1,A0
.L4:
            bset    #$10,D4
            tst.l   D6
            bpl.w   .L26
            bra.w   .L16
.L5:
            bsr.b   GetChar_Str2Dec
            beq.b   .L7
            bcs.b   .L6
            cmpi.b  #$39,D0
            bls.b   .L8
.L6:
            tst.w   D4
            bpl.w   .L26
            bra.b   .L10
.L7:
            bset    #$F,D4
            moveq   #-1,D6
            subq.w  #1,D1
            bra.b   .L5
.L8:
            moveq   #-1,D6
            subq.w  #1,D1
            bsr.b   AppendDigit
            bcs.b   .L16
.L9:
            cmpi.b  #$39,D0
            bls.b   .L8
.L10:
            move.l  A0,D6
            subq.l  #1,D6
            cmpi.b  #$45,D0
            beq.b   .L11
            cmpi.b  #$65,D0
            bne.b   .L16
.L11:
            bsr.b   GetChar_Str2Dec
            cmpi.b  #$2B,D0
            beq.b   .L12
            cmpi.b  #$2D,D0
            bne.b   .L13
            bset    #$1F,D2
.L12:
            bsr.b   GetChar_Str2Dec
.L13:
            cmpi.b  #$30,D0
            bcs.b   .L15
            cmpi.b  #$39,D0
            bhi.b   .L15
            moveq   #-1,D6
            andi.w  #$F,D0
            mulu.w  #$A,D5
            add.w   D0,D5
            cmpi.w  #$2000,D5
            bcs.b   .L14
            move.w  #$2000,D5
.L14:
            bra.b   .L12
.L15:
            tst.l   D6
            bpl.w   .L26
.L16:
            subq.l  #1,A0
.L17:
            tst.b   D2
            bne.b   .L18
            tst.w   D4
            bpl.b   .L22
            move.w  #$130,(A2)
            bra.b   .L22
.L18:
            tst.l   D2
            bpl.b   .L19
            neg.w   D5
.L19:
            cmpi.b  #$30,(4,A1,D2.w)
            bne.b   .L21
            subq.b  #1,D2
            cmpi.b  #$13,D2
            beq.b   .L20
            addq.w  #1,D5
.L20:
            bra.b   .L19
.L21:
            move.b  D2,(4,A1)
            add.w   D1,D5
            move.w  D5,(2,A1)
.L22:
            suba.l  ($14,A6),A0
            movea.l ($10,A6),A1
            move.w  A0,(A1)
            movea.l (4,A6),A0
            movea.l (8,A6),A1
            swap    D4
            move.b  D4,(A1)
            movem.l (-$20,A6),D2-D7/A2-A3
            unlk    A6
            lea     ($14,SP),SP
            jmp     (A0)
.L23:
            cmpi.b  #$B0,D0
            beq.w   .L28
            subq.l  #1,A0
            moveq   #$49,D3
            bsr.w   sub_4087A146
            beq.w   .L27
            cmpi.b  #$4E,D0
            bne.b   .L26
            moveq   #$41,D3
            bsr.w   sub_4087A146
            bne.b   .L26
            moveq   #$4E,D3
            bsr.w   sub_4087A146
            bne.w   .L26
            move.l  #$54E3430,(A2)+
            move.w  #$3030,(A2)
            move.l  A0,D6
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$28,D0
            bne.b   .L26
            moveq   #0,D3
.L24:
            bsr.w   GetChar_Str2Dec
            bcs.b   .L25
            cmpi.b  #$39,D0
            bhi.b   .L26
            mulu.w  #$A,D3
            andi.w  #$F,D0
            add.w   D0,D3
            bra.b   .L24
.L25:
            cmpi.b  #$29,D0
            bne.b   .L26
            bsr.b   sub_4087A15E
            ror.w   #8,D0
            ror.b   #4,D3
            bsr.b   sub_4087A15E
            ror.w   #8,D0
            move.w  D0,(A2)
            bra.b   .L29
.L26:
            movea.l D6,A0
            bra.w   .L17
.L27:
            moveq   #$4E,D3
            bsr.b   sub_4087A146
            bne.b   .L26
            moveq   #$46,D3
            bsr.b   sub_4087A146
            bne.b   .L26
.L28:
            move.w  #$149,(A2)
.L29:
            moveq   #-1,D6
            tst.l   D4
            bpl.b   .L30
            move.b  (A0),D0
            bne.w   .L22
            bra.b   .L31
.L30:
            cmpa.l  A0,A3
            bge.w   .L22
.L31:
            bset    #$10,D4
            bra.w   .L22
sub_4087A146:
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$61,D0
            bcs.b   .L1
            cmpi.b  #$7A,D0
            bhi.b   .L1
            subi.b  #$20,D0
.L1:
            cmp.b   D3,D0
            rts
sub_4087A15E:
            move.b  #$F,D0
            and.b   D3,D0
            cmpi.b  #9,D0
            bls.b   .L1
            addq.b  #7,D0
.L1:
            addi.b  #$30,D0
            rts
            ds.b    14
.L2:
            movem.l D2-D5,-(SP)
            link.w  A6,#0
            movea.l ($20,A6),A0
            move.l  (A0),D5
            movea.l ($18,A6),A0
            movea.l ($1C,A6),A1
            move.l  (A1)+,D4
            addq.w  #1,A0
            moveq   #-$50,D2
            moveq   #0,D1
            move.b  (A1)+,D1
            beq.b   .L6
            btst    #$18,D4
            beq.b   .L3
            move.b  #$2D,(A0)+
            bra.b   .L4
.L3:
            btst    #$18,D5
            bne.b   .L5
            move.b  #$20,(A0)+
.L4:
            addq.w  #1,D2
.L5:
            move.b  (A1),D0
            cmpi.b  #$3F,D0
.L6:
            beq.w   sub_4087A2BA.L1
            ori.b   #$20,D0
            cmpi.b  #$69,D0
            beq.w   sub_4087A2BA.L8
            cmpi.b  #$6E,D0
            bne.b   sub_4087A206.L2
            move.b  #$4E,(A0)+
            move.b  #$41,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$28,(A0)+
            move.b  #$29,(3,A0)
            addq.w  #5,D2
            moveq   #0,D3
            cmpi.b  #5,D1
            ble.b   .L7
            moveq   #5,D1
.L7:
            bsr.b   sub_4087A206
            move.l  D3,D0
            bsr.b   sub_4087A206
            asl.b   #4,D3
            or.l    D0,D3
.L8:
            moveq   #4,D0
            bra.b   sub_4087A206.L9
sub_4087A206:
            subq.w  #1,D1
            ble.b   sub_4087A15E.L8
            move.b  (0,A1,D1.w),D3
            cmpi.b  #$39,D3
            ble.b   .L1
            subq.b  #7,D3
.L1:
            andi.b  #$F,D3
            rts
.L2:
            cmpi.b  #$30,(A1)
            bne.b   .L3
            moveq   #1,D1
            moveq   #0,D4
.L3:
            btst    #$18,D5
            bne.w   sub_4087A2BA.L2
            tst.w   D5
            bgt.b   .L4
            moveq   #1,D5
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A29A
            move.w  D1,D3
            ext.l   D3
            subq.l  #1,D3
            bgt.b   .L5
            cmpi.w  #1,D5
            ble.b   .L6
.L5:
            bsr.b   sub_4087A2A8
            move.w  D3,D0
            bsr.b   sub_4087A29A
            move.w  D5,D0
            sub.w   D1,D0
            bsr.b   sub_4087A2BA
.L6:
            addq.w  #2,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$65,(A0)+
            ext.l   D4
            add.l   D4,D3
            blt.b   .L7
            move.b  #$2B,(A0)+
            bra.b   .L8
.L7:
            move.b  #$2D,(A0)+
            neg.l   D3
.L8:
            moveq   #0,D0
.L9:
            lea     sub_4087A2BA.L9,A1
.L10:
            addq.w  #2,D0
            cmp.w   (-2,A1,D0.w),D3
            bcs.b   .L13
            cmpi.b  #8,D0
            blt.b   .L10
.L11:
            divu.w  (-2,A1,D0.w),D3
.L12:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            addi.w  #$30,D3
            move.b  D3,(A0)+
            swap    D3
            ext.l   D3
.L13:
            subq.w  #2,D0
            bgt.b   .L11
            beq.b   .L12
            bra.b   sub_4087A2BA.L6
sub_4087A29A:
            ble.b   .L2
            add.w   D0,D2
            bgt.b   sub_4087A2BA.L1
.L1:
            move.b  (A1)+,(A0)+
            subq.w  #1,D0
            bgt.b   .L1
.L2:
            rts
sub_4087A2A8:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$2E,(A0)+
            rts
.L1:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$30,(A0)+
sub_4087A2BA:
            subq.w  #1,D0
            bge.b   sub_4087A2A8.L1
            rts
.L1:
            movea.l ($18,A6),A0
            move.w  #$13F,(A0)
            bra.b   .L7
.L2:
            move.w  D1,D3
            add.w   D4,D3
            ble.b   .L4
            tst.w   D4
            bge.b   .L3
            move.w  D3,D0
            bsr.b   sub_4087A29A
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D4,D0
            bra.b   .L5
.L3:
            move.w  D1,D0
            bsr.b   sub_4087A29A
            move.w  D4,D0
            bsr.b   sub_4087A2BA
            move.w  D5,D0
            ble.b   .L6
            bsr.b   sub_4087A2A8
            bsr.b   sub_4087A2BA
            bra.b   .L6
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A2BA
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D3,D0
            bsr.b   sub_4087A2BA
            move.w  D1,D0
.L5:
            bsr.b   sub_4087A29A
            move.w  D4,D0
            add.w   D5,D0
            bsr.b   sub_4087A2BA
.L6:
            movea.l ($18,A6),A0
            addi.w  #$50,D2
            move.b  D2,(A0)
.L7:
            unlk    A6
            movem.l (SP)+,D2-D5/A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            move.b  #$49,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$46,(A0)
            addq.w  #3,D2
            bra.b   .L6
.L9:
            dc.w    $000A,$0064,$03E8,$2710
            ds.b    10
RsrcEntrysnd_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'snd ' 1 "Brass Horn" (2772 bytes) - Combo mask
            dc.l    RsrcEntryPACK_7-BaseOfROM       ; Next entry
            dc.l    Rsrcsnd_1-BaseOfROM             ; Data
            dc.b    'snd '                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    10,'Brass Horn'                 ; Name
            dc.w    0
            dc.l    $C0A00000,$00000AE0,$000000DC   ; Block header
Rsrcsnd_1:
            dc.w    $0001,$0001,$0005
            ds.b    5
            dc.b    $01,$80,$51
            ds.b    5
            dc.b    $14
            ds.b    6
            dc.w    $0AA0,$56EE
            ds.b    4
            dc.w    $0A80,0,$0A90,$003C,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$8080,$8080,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8180,$8080,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
            dc.w    $8080,$8080,$7F7F,$7F7F,$7F7F,$7F7F,$7F7F,$7F7F
            dc.b    $7F,$7F,$7E,$7E,$7F
            dc.b    '~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
            dc.b    $7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D
            dc.b    '~~~~~~~~~~~~'
            dc.b    $7F,$7F,$7F,$7F,$7F,$7F,$7F,$80,$80,$80,$80,$80,$80,$80,$80,$80
            dc.b    $80,$80,$80,$80,$80,$80,$80,$80,$81,$81,$81,$81,$81,$81,$81,$82
            dc.b    $82,$82,$82,$82,$82,$82,$83,$83,$82,$81,$81,$83,$84,$84,$84,$84
            dc.b    $83,$83,$84,$84,$84,$84,$83,$83,$85,$85,$84,$83,$82,$83,$83,$84
            dc.b    $85,$84,$84,$84,$83,$83,$85,$84,$82,$82,$84,$84,$82,$81,$83,$86
            dc.b    $85,$83,$85,$85,$87,$86,$85,$84,$83,$84,$82,$84,$86,$85,$84,$85
            dc.b    $82,$82,$81,$84,$85,$82,$82,$81,$84,$84,$85,$82,$80,$80,$81,$80
            dc.b    $82,$85,$82,$83,$85,$84,$86,$88,$83,$7F,$81,$82,$85,$85,$83,$82
            dc.b    $80,$80,$84,$86,$83,$81,$82,$83,$83,$84,$87,$82,$82,$82,$81,$86
            dc.b    $84,$82,$7D,$80,$84,$7C,$7B,$80,$82,$81,$82,$7D,$7A,$83,$82,$7F
            dc.b    $85,$84,$81,$82,$83,$7F,$82,$84,$84,$83,$7E,$80,$81,$81,$7E,$81
            dc.b    $83,$82,$80,$7F,$7F,$7D,$7F,$80,$81,$7F,$7D,$78,$7B,$7E,$7F,$80
            dc.b    $84,$80,$7D,$81,$84,$86,$84,$88,$8A,$86,$82,$88,$89,$84,$86,$86
            dc.b    $84,$86,$84,$7E,$7B,$7C,$7B,$7C,$7D
            dc.b    'vtuwvwxuwsst|'
            dc.b    $7F,$7B,$7F,$85,$84,$82,$80,$80,$81,$8F,$8D,$8A,$86,$86,$8D,$8E
            dc.b    $85,$85,$8D,$87,$85,$84,$80,$82,$80,$7E,$78,$76,$7C,$7B
            dc.b    'yuuuuvw'
            dc.w    $7B7D,$7D77,$797C,$858D,$8B84,$8696,$8F91,$9296
            dc.b    $8E,$8B,$90,$8E,$8E,$88,$8A,$88,$82
            dc.b    '|vvokikfglnlhnorsxuz'
            dc.b    $88,$8B,$8D,$8F,$93,$98,$9A,$9B,$9D,$A5,$A6,$A6,$A0,$9F,$99,$96
            dc.b    $96,$97,$8F,$80
            dc.b    'spja`[TWY_XX`inttwv|'
            dc.b    $88,$97,$93,$9B,$A4,$A0,$9E,$A8,$B1,$B8,$BA,$BF,$B5,$AF,$B0,$A5
            dc.b    $8C,$79
            dc.b    'dQF=736AMX_'
            dc.w    $5C67,$7069,$6C78,$7E7D,$9599,$A2A7,$AFBA,$CCCE
            dc.w    $D6D7,$DAE0,$E1C0,$9675,$4D27,$1B0D,$030B
            dc.b    '!6Lemmht'
            dc.w    $8079,$7E7E,$90A1,$AEB4,$BBC5,$D7E1,$E8EB,$E9EB
            dc.b    $E8,$C9,$92,$54,$20,$01,$04,$00,$00,$00,$16
            dc.b    ':Xmvroz~~~'
            dc.b    $88,$99,$A6,$B6,$BD,$C1,$C7,$DB,$EF,$F0,$F1,$EF,$E8,$DD,$B9,$76
            dc.b    $46,$14,$00,$03,$00,$00,$03,$17
            dc.b    '<dsspxvy'
            dc.b    $7F,$8A,$8C,$9E,$AF,$B8,$C0,$C4,$D5,$E3,$F2,$F4,$F8,$F1,$F0,$DF
            dc.b    $A7,$6A,$28
            ds.b    5
            dc.b    $01,$22,$54,$76,$82,$77,$74,$77,$81,$7E,$84,$87,$97,$A6,$B8,$C4
            dc.b    $C6,$CF,$E9,$F8,$FF,$FF,$FF,$FE,$E8,$BC,$7D,$35
            ds.b    6
            dc.b    $1C,$57,$70,$79,$75,$71,$79,$82,$84,$7E,$81,$95,$A6,$BE,$C8,$D3
            dc.b    $D2,$F2,$FF,$FF,$FF,$FF,$F3,$DC,$B0,$53
            ds.b    6
            dc.b    $0F,$3C,$66,$7A,$71,$6E,$72,$7D,$82,$85,$7C,$89,$A1,$B1,$C6,$D0
            dc.b    $D2,$DC,$F7,$FF,$FF,$FF,$FF,$F4,$CB,$84,$2C
            ds.b    6
            dc.w    $164C,$797A,$6F6C,$7480,$8280,$818C,$9DB7,$C3CE
            dc.b    $D1,$ED,$FC,$FF,$FF,$FF,$FB,$EA,$B7,$72,$14
            ds.b    6
            dc.b    $2A,$55,$7F,$81,$6F,$6A,$7D,$86,$87,$82,$86,$94,$B2,$C6,$D6,$D3
            dc.b    $E6,$FC,$FF,$FF,$FF,$FF,$E8,$D4,$95,$30
            ds.b    6
            dc.b    $10,$51,$81,$87,$75,$6E,$74,$81,$8C,$86,$86,$9A,$B5,$C9,$D8,$D9
            dc.b    $D8,$EF,$FF,$FF,$FF,$FF,$EB,$D2,$A2,$53
            ds.b    7
            dc.w    $3665,$7D75,$6F76,$8088,$8277,$869C,$B6BF,$C3C3
            dc.b    $C9,$D8,$F1,$F3,$F3,$F6,$F9,$E3,$B0,$68,$2A
            ds.b    6
            dc.b    $16,$52,$76,$7C,$71,$82,$7E,$85,$82,$82,$7E,$92,$9D,$B3,$BD,$C4
            dc.b    $CA,$DA,$F3,$FF,$FF,$FF,$FA,$DF,$BA,$78,$24
            ds.b    6
            dc.w    $1852,$7686,$7886,$888E,$8A8C,$818A,$A4B5,$C1D0
            dc.w    $D6E6,$FEFF,$FFFF,$E3CC,$9848
            ds.b    6
            dc.w    $123F,$647C,$7975,$7F89,$8A91,$8E91,$92A4,$A7B2
            dc.w    $B4C7,$EAFF,$FFFF,$FBEE,$D797,$5008
            ds.b    5
            dc.b    $1C,$33,$62,$7A,$86,$7D,$7D,$7D,$86,$90,$8E,$85,$90,$99,$A2,$AC
            dc.b    $B4,$BB,$CD,$E1,$F9,$F6,$F3,$E8,$E8,$BA,$7D,$31
            ds.b    4
            dc.b    $07,$12,$35,$50,$6E,$86,$80,$77,$7D,$85,$92,$8C,$8F,$88,$94,$98
            dc.b    $A8,$A8,$B0,$BB,$DF,$F1,$FA,$F8,$FB,$DB,$BF,$84,$43
            ds.b    4
            dc.w    $021C,$345D,$6E86,$7E78,$7987,$8989,$888B,$9397
            dc.w    $A3A4,$A5B4,$CEEE,$F2F9,$EAE4,$CB98,$5717,0
            dc.w    $030F,$1C35,$5271,$7F84,$7F7F,$7984,$858B,$888F
            dc.w    $9394,$9A9B,$A9BD,$D9E7,$E8F0,$E2D5,$A36C,$3211
            dc.w    $1010,$1118,$2F4C,$6B7E,$837A,$7A7B,$8084,$8387
            dc.w    $8891,$8E92,$969C,$AAC0,$D8E3,$E0EA,$DABC,$8A5E
            dc.b    $31,$24,$1F,$1A,$1A
            dc.b    '-A[pz||'
            dc.w    $7F7C,$7E83,$8283,$8B8C,$8790,$92A0,$B6C7,$D4DC
            dc.w    $E0D9,$CBAB,$8058,$3B2B,$2421,$2230,$4561,$737D
            dc.w    $7D76,$747A,$7F86,$8485,$8B8A,$8790,$969F,$ACC0
            dc.b    $CD,$D4,$D7,$D1,$C5,$AC,$82
            dc.b    'aF83--9Lbs'
            dc.b    $7B,$7C,$79,$78,$82,$7D,$81,$82,$83,$82,$86,$82,$83,$86,$92,$A4
            dc.b    $B0,$B9,$B8,$C2,$C7,$C5,$B5,$99,$80
            dc.b    'g_NG=;FQcrtzvyy'
            dc.b    $7D,$7E
            dc.b    'xysutv|'
            dc.w    $8696,$A0AA,$B1B6,$BABB,$B9A5,$927F
            dc.b    'tf_SKOVbkqxy'
            dc.b    $80,$81,$7D
            dc.b    '~vvqqopy'
            dc.b    $80,$8A,$94,$9F,$A7,$AD,$B3,$B1,$B4,$AE,$A3,$8E,$81
            dc.b    'wneYRUZekrx'
            dc.b    $7D,$86,$83,$82,$81,$7B,$79,$75,$75,$73,$75,$7B,$7F,$89,$91,$9B
            dc.b    $9F,$A4,$A8,$A9,$AA,$A6,$9F,$92,$87
            dc.b    '|und][`fov'
            dc.w    $7D82,$8686,$8580,$7D78,$7373,$7277,$7B82,$888C
            dc.b    $93,$98,$A0,$A2,$A3,$A1,$9C,$98,$93,$8C,$81
            dc.b    'wokfcfjrx|'
            dc.b    $81,$83,$86,$85,$82,$7E,$7B,$79,$78,$77,$79,$7B,$80,$85,$8A,$8E
            dc.b    $91,$94,$97,$9C,$9B,$99,$93,$8D,$88,$82,$7B
            dc.b    'rmjiknsy~'
            dc.b    $82,$84,$84,$83,$82,$80,$7D,$7B,$7A,$7A,$7B,$7C,$7F,$83,$86,$8B
            dc.b    $8F,$91,$92,$95,$94,$94,$90,$8C,$86,$80
            dc.b    '|vqnoqsvz'
            dc.w    $7D81,$8283,$8280,$7F7D,$7C7B,$7B7C,$7E81,$8486
            dc.b    $87,$8A,$8D,$8F,$8F,$90,$8F,$8C,$89,$85,$80
            dc.b    '|xusstvy'
            dc.b    $7B,$7D,$7F,$80,$81,$81,$80,$7F,$7E,$7F,$7D,$7C,$7C,$7E,$80,$82
            dc.b    $85,$86,$88,$8A,$8C,$8D,$8C,$8C,$8A,$87,$84,$81
            dc.b    '~zxxwwxz|~'
            dc.b    $80,$80,$81,$81,$80,$7F,$7E,$7D,$7E,$7E,$7E,$7F,$80,$81,$83,$85
            dc.b    $87,$88,$8A,$8A,$8A,$89,$88,$85,$83,$81,$7E,$7B
            dc.b    'yxxyyz|'
            dc.w    $7D7F,$8081,$8080,$807F,$7E7E,$7E7E,$7F81,$8384
            dc.w    $8587,$8889,$8989,$8886,$8481,$7F7C,$7B7A,$797A
            dc.w    $7B7C,$7D7E,$7F80,$8080,$8080,$7F7F,$7F7F,$7F80
            dc.w    $8081,$8384,$8586,$8788,$8786,$8583,$817F,$7D7C
            dc.w    $7B7B,$7B7C,$7C7D,$7E7E,$7F7F,$8080,$8080,$8080
            dc.w    $7F80,$8080,$8283,$8484,$8586,$8686,$8584,$8281
            dc.w    $7F7E,$7D7C,$7C7C,$7D7D,$7D7E,$7E7F,$8080,$8081
            dc.w    $8181,$8181,$8181,$8282,$8383,$8485,$8585,$8483
            dc.w    $8382,$8180,$7F7E,$7E7D,$7D7D,$7E7E,$7E7F,$8080
            dc.w    $8081,$8181,$8181,$8182,$8282,$8283,$8384,$8384
            dc.w    $8383,$8382,$8281,$8180,$807F
            dc.b    '~~~~~~'
            dc.w    $7F80,$8181,$8182,$8182,$8282,$8282,$8282,$8282
            dc.w    $8283,$8383,$8383,$8382,$8282,$8180,$807F,$7E7E
            dc.w    $7E7F,$7F80,$8181,$8182,$8282,$8282,$8281,$8181
            dc.w    $8181,$8182,$8282,$8282,$8282,$8282,$8181,$8080
            dc.w    $7F7F,$7F7F,$7F80,$8080,$8181,$8182,$8281,$8181
            dc.w    $8181,$8180,$8181,$8182,$8282,$8283,$8282,$8282
            dc.w    $8181,$8180,$8080,$8080,$8080,$8181,$8181,$8181
            dc.w    $8181,$8080,$8080,$8180,$8182,$8282,$8282,$8282
            dc.w    $8282,$8281,$8180,$8080,$8080,$8081,$8181,$8181
            dc.w    $8181,$8080,$8080,$8080,$8080,$8181,$8182,$8282
            dc.w    $8282,$8282,$8281,$8181,$8080,$8080,$8080,$8181
            dc.w    $8181,$8181,$8180,$8080,$8081,$8080,$8181,$8181
            dc.w    $8282,$8283,$8282,$8282,$8181,$8180,$8080,$8081
            dc.w    $8181,$8181,$8181,$8181,$8181,$8180,$8081,$8181
            dc.w    $8182,$8282,$8282,$8282,$8282,$8181,$8180,$8080
            dc.w    $8080,$8080,$8181,$8081,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8182,$8282,$8282,$8282,$8281,$8181
            dc.w    $8180,$8080,$8080,$8080,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8282,$8282,$8282,$8282
            dc.w    $8181,$8080,$8080,$8080,$8080,$8081,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8182,$8282,$8282
            dc.w    $8282,$8281,$8181,$8180,$8080,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8282,$8282,$8281,$8181,$8080,$8081,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8180,$8081,$8181,$8181
            dc.w    $8181,$8182,$8282,$8281,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8282,$8281,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8182,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8282,$8181,$8181,$8181,$8181,$8180,$8080
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8182,$8281,$8181,$8181,$8180,$8080
            dc.w    $8080,$8081,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8282,$8281,$8282,$8181,$8181
            dc.w    $8080,$8080,$8080,$8080,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8182,$8282,$8281,$8181
            dc.w    $8181,$8180,$8080,$8080,$8081,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8282,$8182,$8282,$8281,$8181
            dc.w    $8181,$8181,$8181,$8080,$8081,$8181,$8181,$8180
            dc.w    $8181,$8181,$8181,$8181,$8281,$8282,$8281,$8181
            dc.w    $8181,$8181,$8181,$8080,$8181,$8181,$8181,$8181
            dc.w    $8081,$8181,$8181,$8181,$8181,$8182,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8182,$8282,$8282
            dc.w    $8282,$8181,$8181,$8180,$8081,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8282,$8282
            dc.w    $8282,$8181,$8181,$8181,$8181,$8180,$8081,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8282
            dc.w    $8282,$8281,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8282,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181,$8181,$8181,$8181,$8181,$8181
            dc.w    $8181,$8181,$8181
            ds.b    6
RsrcEntryKCAP_7:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'KCAP' 7 (580 bytes) - Combo mask
            dc.l    RsrcEntrysnd_1-BaseOfROM        ; Next entry
            dc.l    RsrcKCAP_7-BaseOfROM            ; Data
            dc.b    'KCAP'                          ; Type
            dc.w    7                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000250,$000000D4   ; Block header
RsrcKCAP_7:
            dc.w    $003C,$002D,$00DC,$01C7,$000C,$002A,$0024,$0170
            dc.w    $0008,0,$0015,$0015,$0043,$0035,$0032,$000A
            dc.w    $0012,0,$0014,$0013,0,$0014,$0014,0
            dc.w    $0014,$0015,0,$0014,$0017,0,$0014,$0016
            dc.w    0,$0014,$001A,0,$0014,$001C,0,$0014
            dc.w    $0019,0,$0014,$001D,0,$0014,$001B,0
            dc.w    $0014,$0018,0,$0014,$001E,$0014,$000A,$0021
            dc.w    0,$FFEC,$0023,0,$FFEC,$001F,0,$FFEC
            dc.w    $0022,0,$FFEC,$0020,0,$FFEC,$0010,0
            dc.w    $FFEC,$0011,0,$FFEC,$000F,0,$FFEC,$000E
            dc.w    0,$FFEC,$000D,0,$FFEC,$000C,0,$FFEC
            dc.w    0,$0014,$0005,$0001,0,$0014,$0002,0
            dc.w    $0014,$0003,0,$0014,$0005,0,$0014,$0004
            dc.w    0,$0014,$0026,0,$0014,$0028,0,$0014
            dc.w    $0025,0,$0014,$0029,0,$0014,$0027,0
            dc.w    $0014,$002A,0,$0014,$007E,$0014,$000F,$002C
            dc.w    0,$FFD3,$002F,0,$FFEC,$002B,0,$FFEC
            dc.w    $002E,0,$FFEC,$002D,0,$FFEC,$000B,0
            dc.w    $FFEC,$0009,0,$FFEC,$0008,0,$FFEC,$0007
            dc.w    0,$FFEC,$0006,0,$FFEC,$0032,0,$FFEC
            dc.w    $007B,$0014,$00CD,$007C,0,$0014,$007D,0
            dc.w    $0014,$0041,0,$0050,$0055,$FFEC,0,$0054
            dc.w    0,$FFEC,$0053,0,$FFEC,$0056,$FFEC,0
            dc.w    $0057,0,$0014,$0058,0,$0014,$0045,0
            dc.w    $0014,$004E,$FFEC,0,$005C,0,$FFEC,$005B
            dc.w    0,$FFEC,$0059,0,$FFEC,$0047,$FFEC,0
            dc.w    $0051,0,$0014,$004B,0,$0014,$0043,0
            dc.w    $0014,0,$0015,$001A,$0002,$0038,$006E,$000A
            dc.w    $0038,0,$00F5,$003B,$0014,$FF0B,0,$0015
            dc.w    $001F,$0002,$003A,$0082,$0023,$0030,$FFC4,$FFE7
            dc.w    $0033,$FFEC,$0104,0,$0015,$0024,$0002,$0039
            dc.w    $005A,$000A,$0037,$0028,$0037,$0034,0,$008C
            dc.w    0,$0015,$0029,0,$0052,$0082,$0140,0
            dc.w    $0015,$006A,0,$0031,$0082,$0064,$0001,$0015
            dc.w    $0015,$0029,$0005,0,$0024,$0046,$0118,0
            dc.w    $0029,$0015,0,$004C,$006E,$017C
            ds.b    4
RsrcEntryKCAP_6:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'KCAP' 6 (564 bytes) - Combo mask
            dc.l    RsrcEntryKCAP_7-BaseOfROM       ; Next entry
            dc.l    RsrcKCAP_6-BaseOfROM            ; Data
            dc.b    'KCAP'                          ; Type
            dc.w    6                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000240,$000000CC   ; Block header
RsrcKCAP_6:
            dc.w    $003C,$002D,$00DC,$01C7,$000C,$002A,$0024,$0170
            dc.w    $0007,0,$0015,$0015,$0046,$0035,$0032,$000A
            dc.w    $0012,0,$0014,$0013,0,$0014,$0014,0
            dc.w    $0014,$0015,0,$0014,$0017,0,$0014,$0016
            dc.w    0,$0014,$001A,0,$0014,$001C,0,$0014
            dc.w    $0019,0,$0014,$001D,0,$0014,$001B,0
            dc.w    $0014,$0018,0,$0014,$002A,$0014,$001E,$001E
            dc.w    0,$FFEC,$0021,0,$FFEC,$0023,0,$FFEC
            dc.w    $001F,0,$FFEC,$0022,0,$FFEC,$0020,0
            dc.w    $FFEC,$0010,0,$FFEC,$0011,0,$FFEC,$000F
            dc.w    0,$FFEC,$000E,0,$FFEC,$000D,0,$FFEC
            dc.w    $000C,0,$FFEC,0,$0014,$0005,$0001,0
            dc.w    $0014,$0002,0,$0014,$0003,0,$0014,$0005
            dc.w    0,$0014,$0004,0,$0014,$0026,0,$0014
            dc.w    $0028,0,$0014,$0025,0,$0014,$0029,0
            dc.w    $0014,$0027,0,$0014,$002C,$0014,$FFF6,$002F
            dc.w    0,$FFEC,$002B,0,$FFEC,$002E,0,$FFEC
            dc.w    $002D,0,$FFEC,$000B,0,$FFEC,$0009,0
            dc.w    $FFEC,$0008,0,$FFEC,$0007,0,$FFEC,$0006
            dc.w    0,$FFEC,$0039,$0014,$FFD3,$003A,0,$0014
            dc.w    $0032,0,$0037,$0034,0,$0073,$007B,0
            dc.w    $0014,$007C,0,$0014,$007D,0,$0014,$007E
            dc.w    0,$0014,$0041,0,$0050,$0055,$FFEC,0
            dc.w    $0054,0,$FFEC,$0053,0,$FFEC,$0056,$FFEC
            dc.w    0,$0057,0,$0014,$0058,0,$0014,$0045
            dc.w    0,$0014,$004E,$FFEC,0,$005C,0,$FFEC
            dc.w    $005B,0,$FFEC,$0059,0,$FFEC,$0047,$FFEC
            dc.w    0,$0051,0,$0014,$004B,0,$0014,$0043
            dc.w    0,$0014,0,$0015,$001F,$0001,$0030,$0046
            dc.w    $000A,$0033,$FFEC,$0104,0,$0015,$0024,$0002
            dc.w    $003B,$005A,$000A,$0024,0,$00FF,$0037,$0028
            dc.w    $FF29,0,$0015,$0029,0,$0052,$0082,$0140
            dc.w    0,$0015,$002E,$0001,$0038,$006E,$000A,$0038
            dc.w    0,$00F5,0,$0015,$0060,0,$0031,$0082
            dc.w    $0069,0,$0029,$0015,0,$004C,$006E,$017C
RsrcEntryKMAP_2:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'KMAP' 2 (148 bytes) - Combo mask
            dc.l    RsrcEntryKCAP_6-BaseOfROM       ; Next entry
            dc.l    RsrcKMAP_2-BaseOfROM            ; Data
            dc.b    'KMAP'                          ; Type
            dc.w    2                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000000A0,$000000C4   ; Block header
RsrcKMAP_2:
            dc.w    $0002,0,$0001,$0203,$0405,$0607,$0809,$0A0B
            dc.w    $0C0D,$0E0F,$1011,$1213,$1415,$1617,$1819,$1A1B
            dc.b    $1C,$1D,$1E,$1F,$20,$21,$22
            dc.b    '#$%&',$27,'()*+,-./012345;78'
            dc.b    $B9,$3A,$7B,$7C,$7D
            dc.b    '~?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_`abcdefghijklmnopqrstuvwxyz<=>6'
            dc.b    $7F,$00,$02,$39,$0E,$02,$00,$02,$B9,$0E,$02,$00,$02
RsrcEntryKMAP_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'KMAP' 0 (148 bytes) - Combo mask
            dc.l    RsrcEntryKMAP_2-BaseOfROM       ; Next entry
            dc.l    RsrcKMAP_0-BaseOfROM            ; Data
            dc.b    'KMAP'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000000A0,$000000BC   ; Block header
RsrcKMAP_0:
            ds.b    5
            dc.b    $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10
            dc.b    $11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20
            dc.b    $21,$22
            dc.b    '#$%&',$27,'()*+,-./012345;789:'
            dc.b    $7B,$7C,$7D
            dc.b    '~?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_`abcdefghijklmnopqrstuvwxyz<=>6'
            dc.b    $7F
            ds.b    12
RsrcEntryKCHR_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'KCHR' 0 (1428 bytes) - Combo mask
            dc.l    RsrcEntryKMAP_0-BaseOfROM       ; Next entry
            dc.l    RsrcKCHR_0-BaseOfROM            ; Data
            dc.b    'KCHR'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000005A0,$000000B4   ; Block header
RsrcKCHR_0:
            ds.b    4
            dc.w    $0100,$0202,$0100,$0306,$0404,$0505,$0404,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0100
            dc.w    $0100,$0100,$0100,$0404,$0404,$0404,$0404,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0306
            dc.w    $0404,$0505,$0404,$0306,$0404,$0505,$0404,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0404
            dc.w    $0404,$0404,$0404,$0404,$0404,$0404,$0404,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0707
            dc.w    $0707,$0707,$0707,$0707,$0707,$0707,$0707,$0008
            dc.b    'asdfhgzxcv'
            dc.w    $0062
            dc.b    'qweryt123465=97-80]ou[ip'
            dc.w    $0D6C,$6A27,$6B3B,$5C2C,$2F6E,$6D2E,$0920,$6008
            dc.w    $031B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00
            dc.b    'ASDFHGZXCV'
            dc.w    $0042
            dc.b    'QWERYT!@#$^%+(&_*)'
            dc.w    $7D4F,$557B,$4950,$0D4C,$4A22
            dc.b    'K:|<?NM>'
            dc.w    $0920,$7E08,$031B
            ds.b    11
            dc.b    $2E,$2A,$2A,$00,$2B,$2B,$1B,$3D,$00,$00,$2F,$03,$2F,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00
            dc.b    'ASDFHGZXCV'
            dc.w    $0042
            dc.b    'QWERYT123465=97-80]OU[IP'
            dc.w    $0D4C,$4A27,$4B3B,$5C2C,$2F4E,$4D2E,$0920,$6008
            dc.w    $031B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$8CA7,$B6C4,$FAA9,$BDC5,$8DC3
            dc.w    $00BA,$CFB7,$00A8,$B4A0,$C1AA,$A3A2,$A4B0,$ADBB
            dc.w    $A6D0,$A5BC,$D4BF,$00D2,$00B9,$0DC2,$C6BE,$FBC9
            dc.w    $C7B2,$D600,$B5B3,$09CA,$0008,$031B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$81EA,$EBEC,$EEFD,$FCFE,$82D7
            dc.w    $00F5,$CEE3,$E4E5,$E7E6,$DADB,$DCDD,$DFDE,$B1E1
            dc.w    $E0D1,$A1E2,$D5AF,$E8D3,$E9B8,$0DF1,$EFAE,$F0F2
            dc.w    $C8F8,$C0F6,$F7F9,$09CA,$FF08,$031B
            ds.b    11
            dc.b    $2E,$2A,$2A,$00,$2B,$2B,$1B,$3D,$00,$00,$2F,$03,$2F,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$81EA,$EBEC,$EEFD,$FCFE,$82D7
            dc.w    $00F5,$CEE3,$E4E5,$E7E6,$C1AA,$A3A2,$A4B0,$ADBB
            dc.w    $A6D0,$A5BC,$D4AF,$E8D2,$E9B8,$0DF1,$EFAE,$F0C9
            dc.w    $C7B2,$D6F6,$F7B3,$09CA,$6008,$031B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$8CA7,$B6C4,$FAA9,$BDC5,$8DC3
            dc.w    $00BA,$CFB7,$ABA8,$B4A0,$C1AA,$A3A2,$A4B0,$ADBB
            dc.w    $A6D0,$A5BC,$D4BF,$ACD2,$5EB9,$0DC2,$C6BE,$FBC9
            dc.w    $C7B2,$D67E,$B5B3,$09CA,$6008,$031B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$0113,$0406,$0807,$1A18,$0316
            dc.w    $3002,$1117,$0512,$1914
            dc.b    '123465=97'
            dc.b    $1F,$38,$30,$1D,$0F,$15,$1B,$09,$10,$0D,$0C,$0A,$27,$0B,$3B,$1C
            dc.b    $2C,$2F,$0E,$0D,$2E,$09,$20,$60,$08,$03,$1B
            ds.b    11
            dc.b    $2E,$1D,$2A,$00,$2B,$1C,$1B,$1F,$00,$00,$2F,$03,$1E,$2D,$00,$00
            dc.b    '=01234567'
            dc.w    $0038,$3900,0,$1010,$1010,$1010,$1010,$1010
            dc.w    $1010,$1010,$1010,$1010,$0501,$0B7F,$1004,$100C
            dc.w    $101C,$1D1F,$1E00,$0005,$030E,$000B,$20AB,$41E7
            dc.w    $4583,$49EA,$4FEE,$55F2,$6187,$658E,$6992,$6F97
            dc.w    $759C,$00AB,$0332,$000B,$2060,$41CB,$45E9,$49ED
            dc.w    $4FF1,$55F4,$6188,$658F,$6993,$6F98,$759D,$0060
            dc.w    $0322,$000B,$205E,$41E5,$45E6,$49EB,$4FEF,$55F3
            dc.w    $6189,$6590,$6994,$6F99,$759E,$005E,$0320,$000D
            dc.w    $20AC,$4180,$45E8,$49EC,$4F85,$5586,$59D9,$618A
            dc.w    $6591,$6995,$6F9A,$759F,$79D8,$00AC,$032D,$0007
            dc.w    $207E,$41CC,$4E84,$4FCD,$618B,$6E96,$6F9B,$007E
            dc.w    0
RsrcEntryFONT_521:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 521 (2468 bytes) - Combo mask
            dc.l    RsrcEntryKCHR_0-BaseOfROM       ; Next entry
            dc.l    RsrcFONT_521-BaseOfROM          ; Data
            dc.b    'FONT'                          ; Type
            dc.w    521                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$000009B0,$000000AC   ; Block header
RsrcFONT_521:
            dc.w    $9001,0,$00D9,$0006,0,$FFF7,$0006,$000B
            dc.w    $0312,$0009,$0002,0,$0033
            ds.b    50
            dc.b    $A2,$00,$4D,$52,$80
            ds.b    15
            dc.w    $01C0
            ds.b    11
            dc.b    $03
            ds.b    5
            dc.b    $30,$00,$00,$02,$1A,$D0
            ds.b    8
            dc.b    $10
            ds.b    46
            dc.w    $0700,$0500,$9600,$0442,$01A6,$0090,$4032,$0D12
            dc.w    $0806,$8904,$0060,$3220,$7980
            ds.b    9
            dc.b    $04
            ds.b    5
            dc.b    $40,$00,$00,$01,$2D,$60
            ds.b    7
            dc.w    $D539,$EC98,$4000,$0B97,$385F,$77DC,$E000,$1CE7
            dc.w    $79DE,$FFDD,$1863,$08C5,$DE77,$9DF8,$C631,$8FF8
            dc.w    $D010,$2000,$80C1,$0984
            ds.b    4
            dc.w    $2000,0,$0A9A,$E73B,$F174,$4825,$2AC9,$0108
            dc.w    $A54D,$B621,$14AB,$108A,$5290,$4920,$AA79,$CF5A
            dc.w    $07B8,$0032,$204F,$FC04,$7670,$0048,$0040,0
            dc.w    $039C,$E780,$00AA,$E002,$8078,$DFD6,$B2A5,$5200
            dc.w    $0C78,$C4D0,$8063,$1041,$2318,$C631,$8423,$1865
            dc.w    $0DE6,$318C,$6248,$C62A,$8868,$6808,$2000,$8101
            dc.w    $0084
            ds.b    4
            dc.w    $2000,0,$0AAD,$18C6,$198C,$4000,$0006
            ds.b    10
            dc.w    $0792,$428E,$AC44,$25E0,$2A44,$0449,$4024,$A804
            dc.w    $9988,0,$0640,$9000,$0463,$1A00,$014B,$2420
            dc.w    $3F48,$8552,$D442,$E200,$1450,$855E,$F063,$1ABE
            dc.w    $83D8,$C611,$8421,$1869,$0AD6,$318C,$6048,$C624
            dc.w    $88A4,$4003,$FCE7,$BB9F,$E997,$D677,$9F67,$F463
            dc.w    $58C7,$EA81,$18C2,$158C,$5EF7,$BDEF,$739C,$E74A
            dc.w    $5673,$9CE7,$4631,$8A67,$725F,$ACB2,$D5C1,$FA4F
            dc.w    $6487,$F232,$2BE4,$998B,$9C48,$04E7,$1000,$0463
            dc.w    $1A28,$0155,$C054,$4048,$8FB9,$4843,$5F9F,$1451
            dc.w    $1A41,$889D,$1100,$455F,$FA11,$F7A7,$F871,$08CE
            dc.w    $3E8F,$9C48,$C624,$5124,$4004,$6318,$C523,$19A6
            dc.w    $B98C,$6398
            dc.b    '$cUDRA'
            dc.w    $FFC3,$D38C,$6318,$C631,$8C63,$18CA,$598C,$6318
            dc.w    $C631,$8A0A,$C13F,$7CAB,$1000,$4F56,$BF48,$9251
            dc.w    $2944,$768D,$668F,$C848,$A932,$07FF,$1B57,$FE00
            dc.w    $1F8C,$7F48,$8515,$B542,$4200,$2452,$07E1,$8922
            dc.w    $F0BE,$89E8,$C611,$8423,$1C69,$08C6,$308C,$4248
            dc.w    $C6A4,$2222,$4004,$6308,$FD23,$19E6,$B18C,$6307
            dc.w    $2463,$5244,$8A81,$18C2,$118C,$6318,$C631,$87FF
            dc.w    $FFCA,$518C,$6318,$C631,$8A0A,$40BF,$2C72,$D001
            dc.w    $FA67,$6433,$F292,$2944,$008D,$EB08,$6847,$2A49
            dc.w    $0463,$1A5C,0,$0054,$4048,$0056,$B224,$0200
            dc.w    $2454,$4451,$8922,$1041,$0108,$C631,$8423,$1C65
            dc.w    $08C6,$308C,$6248,$AB6A,$2422,$4004,$E308,$C123
            dc.w    $1996,$B18C,$6300,$A4D5,$5545,$0A81,$18C6,$118C
            dc.w    $6739,$CE73,$8421,$084A,$518C,$6318,$CE73,$980A
            dc.w    $C64E,$2C6C,$2000,$8A44,$0400,$9294,$A944,$FF55
            dc.w    $3318,$5048,$4649,$0463,$1A50,0,$0424,$7F48
            dc.w    $803A,$4D18,$0020,$C39F,$B84E,$711C,$EA00,$08E8
            dc.w    $F9DE,$FC1D,$1BA3,$F8C5,$D074,$5C47,$1231,$27F1
            dc.w    $C7E3,$7CF7,$BD1F,$198E,$B177,$9F0F,$1B48,$A8BF
            dc.w    $EA81,$18BB,$F173,$9AD6,$B5AD,$7BDE,$F7CA,$5173
            dc.w    $9CE7,$35AD,$6807,$7A20,$2D81,$C000,$0BB8,$1FFC
            dc.w    $9D6F,$A944,$00DB,$DCE8,$1040,$7D32,$AC62,$E7AC
            dc.b    $00,$00,$00,$03,$C0,$78,$00,$10,$00,$00,$00,$20,$40
            ds.b    5
            dc.b    $02
            ds.b    12
            dc.b    $08
            ds.b    5
            dc.b    $01
            ds.b    5
            dc.b    $02,$01,$00,$00,$04,$02
            ds.b    4
            dc.b    $04,$07
            ds.b    9
            dc.b    $20
            ds.b    10
            dc.b    $02,$01,$C0,$04
            ds.b    7
            dc.w    $1000,$0004
            ds.b    5
            dc.b    $40
            ds.b    10
            dc.b    $40
            ds.b    6
            dc.b    $40
            ds.b    6
            dc.b    $04
            ds.b    24
            dc.b    $1C,$06,$00,$00,$04,$02
            ds.b    4
            dc.b    $38
            ds.b    10
            dc.b    $40
            ds.b    21
            dc.w    $1000,$0018
            ds.b    4
            dc.w    $0180
            ds.b    9
            dc.b    $03,$80
            ds.b    70
            dc.b    $01,$00,$04,$00,$09,$00,$0E,$00,$13,$00,$18,$00,$19,$00,$1C,$00
            dc.b    $1F,$00,$24,$00,$29,$00,$2B,$00,$30,$00,$31,$00,$35,$00,$3A,$00
            dc.b    $3C,$00,$41,$00,$46,$00,$4B,$00,$50,$00,$55,$00,$5A,$00,$5F,$00
            dc.b    $64,$00,$65,$00,$67,$00,$6A,$00,$6F,$00,$72,$00,$77,$00,$7C,$00
            dc.b    $81,$00,$86,$00,$8B,$00,$90,$00,$95,$00,$9A,$00,$9F,$00,$A4,$00
            dc.b    $A5,$00,$AA,$00,$AF,$00,$B4,$00,$B9,$00,$BE,$00,$C3,$00,$C8,$00
            dc.b    $CD,$00,$D2,$00,$D7,$00,$DC,$00,$E1,$00,$E6,$00,$EB,$00,$F0,$00
            dc.b    $F5,$00,$FA,$00,$FC,$01,$00,$01,$02,$01,$05,$01,$0B,$01,$0D,$01
            dc.b    $12,$01,$17,$01,$1C,$01,$21,$01,$26,$01,$2A,$01,$2F,$01,$34,$01
            dc.b    $35,$01,$38,$01,$3D,$01,$3E,$01,$43,$01,$48,$01,$4D,$01,$52,$01
            dc.b    $57,$01,$5C,$01,$61,$01,$65,$01,$6A,$01,$6F,$01,$74,$01,$79,$01
            dc.b    $7E,$01,$83,$01,$86,$01,$87,$01,$8A,$01,$8F,$01,$8F,$01,$94,$01
            dc.b    $99,$01,$9E,$01,$A3,$01,$A8,$01,$AD,$01,$B2,$01,$B7,$01,$BC,$01
            dc.b    $C1,$01,$C6,$01,$CB,$01,$D0,$01,$D5,$01,$DA,$01,$DF,$01,$E4,$01
            dc.b    $E9,$01,$EB,$01,$ED,$01,$F0,$01,$F3,$01,$F8,$01,$FD,$02,$02,$02
            dc.b    $07,$02,$0C,$02,$11,$02,$16,$02,$1B,$02,$20,$02,$25,$02,$28,$02
            dc.b    $2C,$02,$31,$02,$36,$02,$3B,$02,$40,$02,$45,$02,$4A,$02,$4F,$02
            dc.b    $54,$02,$5A,$02,$5C,$02,$5F,$02,$64,$02,$69,$02,$6E,$02,$73,$02
            dc.b    $78,$02,$7B,$02,$7E,$02,$83,$02,$88,$02,$8C,$02,$91,$02,$96,$02
            dc.b    $9B,$02,$A0,$02,$A4,$02,$A8,$02,$AD,$02,$B2,$02,$B7,$02,$BC,$02
            dc.b    $BD,$02,$C2,$02,$C7,$02,$CC,$02,$D1,$02,$D6,$02,$DB,$02,$E0,$02
            dc.b    $E5,$02,$E5,$02,$EA,$02,$EF,$02,$F4,$02,$F9,$02,$FE,$03,$01,$03
            dc.b    $07,$03,$0B,$03,$0F,$03,$11,$03,$13,$03,$18,$03,$1D,$03,$22,$03
            dc.b    $28,$03,$2E
            ds.b    12
            dc.w    $FFFF,$FFFF,$FFFF,$0606,$FFFF,$FFFF,$FFFF,0
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$0606,$0206,$0106,$0006,$0006,$0006
            dc.w    $0006,$0206,$0106,$0206,$0006,$0006,$0106,$0006
            dc.w    $0206,$0106,$0006,$0206,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0206,$0106,$0106,$0006
            dc.w    $0106,$0006,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0206,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0206,$0106,$0206
            dc.w    $0106,$0006,$0206,$0006,$0006,$0006,$0006,$0006
            dc.w    $0106,$0006,$0006,$0206,$0006,$0006,$0206,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0006,$0106,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0206,$0206,$0106
            dc.w    $0006,0,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0206,$0106,$0106,$0106
            dc.w    $0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0106,$0106,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0006,$0206,$0106,$0006
            dc.w    $0006,$0006,$0006,$0006,$0106,$0206,$0006,$0006
            dc.w    $0106,$0006,$0006,$0006,$0006,$0106,$0106,$0006
            dc.w    $0006,$0006,$0006,$0306,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0606,$0006,$0006,$0006
            dc.w    $0006,$0006,$0106,$0006,$0106,$0106,$0206,$0206
            dc.w    $0006,$0006,$0006,$0006,$0006
            ds.b    68
            dc.w    $0207,$0202,$0205,$0109,$0207,$0207,$0202,$0207
            dc.w    $0207,$0205,$0305,$0803,$0501,$0801,$0208,$0207
            dc.w    $0207,$0207,$0207,$0207,$0207,$0207,$0207,$0207
            dc.w    $0207,$0405,$0407,$0305,$0403,$0305,$0207,$0207
            dc.w    $0207,$0207,$0207,$0207,$0207,$0207,$0207,$0207
            dc.w    $0207,$0207,$0207,$0207,$0207,$0207,$0207,$0207
            dc.w    $0208,$0207,$0207,$0207,$0207,$0207,$0207,$0207
            dc.w    $0207,$0207,$0207,$0208,$0207,$0202,$0801,$0202
            dc.w    $0405,$0207,$0405,$0207,$0405,$0207,$0407,$0207
            dc.w    $0207,$0209,$0207,$0207,$0405,$0405,$0405,$0407
            dc.w    $0407,$0405,$0405,$0207,$0405,$0405,$0405,$0405
            dc.w    $0407,$0405,$0109,$0109,$0109,$0202,0,$0009
            dc.w    $0009,$0207,$0009,$0009,$0009,$0009,$0108,$0108
            dc.w    $0108,$0207,$0108,$0108,$0407,$0108,$0108,$0108
            dc.w    $0207,$0108,$0108,$0108,$0207,$0108,$0108,$0108
            dc.w    $0108,$0207,$0108,$0108,$0108,$0108,$0207,$0205
            dc.w    $0104,$0307,$0108,$000A,$0305,$0108,$0109,$0206
            dc.w    $0207,$0203,$0202,$0201,$0305,$0207,$0207,$0403
            dc.w    $0306,$0207,$0207,$0207,$0407,$0207,$0207,$0207
            dc.w    $0405,$000B,$0206,$0206,$0207,$0405,$0405,$0207
            dc.w    $0207,$0503,$0306,$000B,$0305,$0306,$0504,$0504
            dc.w    $0801,0,$0009,$0009,$0009,$0207,$0405,$0501
            dc.w    $0501,$0203,$0203,$0203,$0203,$0305,$0305,$0209
            dc.w    $0305,$0207,$0208
            ds.b    12
RsrcEntryFONT_512:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 512 "Monaco" (4 bytes) - Combo mask
            dc.l    RsrcEntryFONT_521-BaseOfROM     ; Next entry
            dc.l    RsrcEntryFONT_396-BaseOfROM     ; Data
            dc.b    'FONT'                          ; Type
            dc.w    512                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    6,'Monaco'                      ; Name
            ds.b    6
            dc.l    $C0A00000,$00000010,$000000A4   ; Block header
RsrcEntryFONT_396:
RsrcFONT_512:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 396 (3188 bytes) - Combo mask
            dc.l    RsrcEntryFONT_512-BaseOfROM     ; Next entry
            dc.l    RsrcFONT_396-BaseOfROM          ; Data
            dc.b    'FONT'                          ; Type
            dc.w    396                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000C80,$0000009C   ; Block header
RsrcFONT_396:
            dc.w    $9001,0,$00D9,$000F,0,$FFF4,$000F,$000F
            dc.w    $0474,$000C,$0003,$0001,$003D
            ds.b    59
            dc.b    $70,$01,$32
            ds.b    4
            dc.b    $06
            ds.b    42
            dc.b    $81,$96,$40
            ds.b    68
            dc.b    $28,$88,$02,$4C,$92,$40,$00,$00,$09
            ds.b    42
            dc.b    $42,$69,$80
            ds.b    11
            dc.b    $04,$00,$00,$30,$00,$00,$04
            ds.b    29
            dc.b    $07,$0C
            ds.b    17
            dc.w    $0700,$0088,0,$0004,$2100,$D900,$8820,$1906
            dc.w    $8904,$0344,$8201
            ds.b    26
            dc.b    $60
            ds.b    10
            dc.b    $4A,$54,$00,$00,$18,$00,$00,$D1,$4E,$7E,$61,$49,$20,$00,$04,$C4
            dc.b    $EF,$C1,$7E,$77,$EF,$3C,$00,$00,$F0,$00,$8F,$9E,$F3,$FF,$7A,$18
            dc.b    $30,$C2,$0E,$2F,$7C,$F7,$CF,$7F,$86,$0C,$06,$31,$FD,$05,$00,$40
            dc.b    $80,$02,$03,$04,$13,$0C
            ds.b    4
            dc.b    $02
            ds.b    4
            dc.w    $0A99,$1071,$EFE2,$F428,$1295,$6601,$0452,$A6DB
            dc.w    $108A,$5588,$452B,$B00C,$7803,$CE00,$0074,$5A00
            dc.w    $7E7A,0,$0440,$33FF,$E005,$EE3C,0,$2400
            dc.b    $44
            ds.b    4
            dc.b    $40,$87,$9E,$F0,$00,$00,$92,$64,$00,$22,$30,$07,$F8,$D7,$F5,$92
            dc.b    $91,$48,$C0,$00,$09,$2D,$10,$83,$40,$80,$30,$C2,$00,$01,$09,$E0
            dc.b    $88,$61,$8A,$10,$86,$18,$31,$43,$1E,$30,$C3,$0C,$30,$88,$86,$0C
            dc.b    $06,$31,$0C,$86,$80,$20,$80,$02,$04,$04,$01,$04
            ds.b    4
            dc.b    $02
            ds.b    4
            dc.w    $0AA6,$1022,$1863,$0C20
            ds.b    13
            dc.b    $01,$49,$12,$84,$05,$51,$1E,$1E,$26,$E0,$00,$A0,$84,$00,$00,$02
            dc.b    $80,$09,$14,$40,$2A,$31,$42
            ds.b    4
            dc.w    $8801,0,$0040,$8861,0,$0094,$A802,$0060
            dc.w    $0408,$8294,$94A0,$87F2,$000A,$1611,$0541,$0050
            dc.w    $C204,$110A,$1148,$6086,$1082,$1832,$42AD,$30C3
            dc.w    $0C30,$0886,$0C45,$5114,$8400,$0EF3,$9EEE,$7DB7
            dc.w    $16CD,$6779,$F777,$4631,$18C7,$EA80,$2852,$0853
            dc.w    $0C2E,$739C,$E739,$CE73,$A52B,$39CE,$73A3,$18C5
            dc.w    $4B90,$81E9,$5121,$2125,$4000,$A08C,$0021,$27D1
            dc.w    $0484,$4FCA,$3181,$771D,$2400,$8801,0,$00A1
            dc.w    $4861,$0770,0,$0085,$22FF,$A408,$8FCC,$6840
            dc.w    $84C2,$0012,$1413,$097D,$F04F,$4348,$0814,$E94F
            dc.w    $A086,$1082,$1834,$424D,$30C3,$0C30,$0885,$1249
            dc.w    $4A14,$4400,$118C,$6314,$8E53,$2733,$98C6,$388A
            dc.w    $4631,$18C4,$2A80,$2852,$0853,$0C31,$8C63,$18C6
            dc.w    $318C,$652C,$C631,$8C63,$18C5,$3550,$7BF9,$525C
            dc.w    $CCA4,$4011,$2094,$C622,$1111,$1C44,$544A,$7181
            dc.w    $88A2,$2401,$1D92,$8000,$00A1,$4861,$0888,0
            dc.w    $0008,$A3FF,$E408,$8506,$10A0,$852F,$9F12,$1420
            dc.w    $9103,$0890,$C213,$E425,$2A28,$6087,$DE9F,$F838
            dc.w    $420C,$B0FD,$0FCF,$0885,$12A8,$8A24,$4400,$0F8C
            dc.w    $2314,$8C53,$4623,$18C6,$3082,$462A,$A544,$5240
            dc.w    $448A,$0F4B,$0C2F,$7BDE,$F7C2,$318C,$6528,$C631
            dc.w    $8C63,$18C4,$0538,$87F9,$5152,$D080,$01F9,$FCA5
            dc.w    $29FC,$0FD1,$2424,$4449,$AE81,$78A6,$47E1,$0A62
            dc.w    $84C8,$0112,$2861,$E888,0,$03F0,$63FF,$C408
            dc.w    $8005,$2D14,$8402,$0022,$1440,$6103,$0890,$BE20
            dc.w    $0245,$2A28,$6086,$1086,$1834,$420C,$B0C1,$0D00
            dc.w    $8884,$A2A9,$4444,$2400,$118C,$23F4,$8C53,$8623
            dc.w    $18C6,$3072,$454A,$A244,$8A80,$448A,$084B,$0C31
            dc.w    $8C63,$18C3,$FFFF,$E528,$C631,$8C63,$18C4,$0510
            dc.w    $87F5,$50DC,$D080,$0022,$20C5,$1122,$1111,$4444
            dc.w    $4448,$0042,$8FAA,$8432,$0804,$4924,$0112,$2861
            dc.w    $08FF,$FF00,$0010,$621F,$C408,$8005,$5308,$8402
            dc.w    $0022,$1480,$7F83,$0910,$8210,$0444,$F7F8,$6086
            dc.w    $1086,$1C32,$420C,$70C1,$0C80,$8884,$A111,$4444
            dc.w    $2400,$118C,$2304,$8C53,$4623,$18C6,$300A,$4544
            dc.w    $4545,$0A80,$FFFE,$0847,$0C31,$8C63,$18C2,$1084
            dc.w    $2528,$C631,$8C63,$18C4,$0510,$7BF3,$D0D2,$CC80
            dc.w    $0042,$2085,$2921,$2111,$4484,$444B,$FF42,$8832
            dc.w    $8C2A,$0994,$5212,$03FF,$F861,$0880,0,$0088
            dc.w    $A230,$F408,$0015,$9314,$4800,$0041,$2508,$8143
            dc.w    $0910,$840B,$E802,$0418,$618A,$1086,$1C31,$420C
            dc.w    $70C1,$2C50,$8884,$4112,$2484,$1400,$118C,$6314
            dc.w    $8C53,$2623,$18C6,$308A,$4C84,$48C6,$0A80,$8306
            dc.w    $1847,$0C31,$8C63,$18C6,$318C,$6528,$C631,$8C67
            dc.w    $39CC,$0551,$05E1,$5121,$2100,$01FC,$2184,$C600
            dc.w    $0111,$4914,$4448,$0024,$88A2,$8C04,$0A68,$2924
            dc.w    $020C,$1861,$0888,0,$0005,$2240,$0408,$800E
            dc.w    $8CE2,$4800,$20C0,$C7F7,$013C,$F10F,$3944,$1041
            dc.w    $C41F,$9EF3,$F07A,$1BD0,$FE0C,$2F40,$F42F,$0878
            dc.w    $4112,$24FC,$147F,$8FF3,$9EE4,$7C53,$1623,$1779
            dc.w    $F071,$B484,$48BF,$EA80,$8305,$EFC2,$F3CF,$7BDE
            dc.w    $F7B9,$CE73,$A528,$B9CE,$739A,$D6B4,$03BE,$8401
            dc.w    $761E,$1E00,$0084,$3E78,$00FF,$F91E,$B3F4,$4888
            dc.w    $0066,$775C,$7404,$080F,$E4C9,$260C,$179E,$F770
            dc.b    $00,$00,$00,$02,$1E,$00,$07,$F8,$00,$04,$00,$00,$30,$00,$20
            ds.b    8
            dc.b    $40
            ds.b    14
            dc.b    $08
            ds.b    6
            dc.b    $06,$0C
            ds.b    5
            dc.b    $08,$02,$00,$00,$00,$40,$20
            ds.b    4
            dc.b    $04,$07,$00,$00,$00,$40
            ds.b    6
            dc.b    $10
            ds.b    10
            dc.b    $01,$00,$78
            ds.b    12
            dc.b    $10,$00,$00,$00,$08
            ds.b    6
            dc.b    $08
            ds.b    13
            dc.b    $02
            ds.b    9
            dc.b    $40
            ds.b    8
            dc.b    $80
            ds.b    28
            dc.b    $88,$02,$00,$00,$00,$40,$20
            ds.b    4
            dc.b    $44
            ds.b    4
            dc.b    $20
            ds.b    6
            dc.b    $20
            ds.b    25
            dc.b    $20,$00,$00,$00,$08
            ds.b    6
            dc.b    $08
            ds.b    13
            dc.b    $22
            ds.b    47
            dc.w    $700C
            ds.b    9
            dc.b    $38
            ds.b    4
            dc.b    $40
            ds.b    36
            dc.b    $10
            ds.b    6
            dc.b    $10
            ds.b    13
            dc.b    $1C
            ds.b    72
            dc.b    $01,$00,$04,$00,$0B,$00,$10,$00,$17,$00,$1F,$00,$20,$00,$23,$00
            dc.b    $26,$00,$2C,$00,$31,$00,$33,$00,$38,$00,$39,$00,$3E,$00,$44,$00
            dc.b    $46,$00,$4C,$00,$52,$00,$59,$00,$5F,$00,$65,$00,$6B,$00,$71,$00
            dc.b    $77,$00,$78,$00,$7A,$00,$7E,$00,$83,$00,$87,$00,$8D,$00,$95,$00
            dc.b    $9C,$00,$A2,$00,$A8,$00,$AE,$00,$B3,$00,$B8,$00,$BE,$00,$C4,$00
            dc.b    $C5,$00,$CB,$00,$D1,$00,$D6,$00,$DD,$00,$E3,$00,$E9,$00,$EF,$00
            dc.b    $F5,$00,$FB,$01,$01,$01,$08,$01,$0E,$01,$15,$01,$1E,$01,$23,$01
            dc.b    $28,$01,$2D,$01,$2F,$01,$34,$01,$36,$01,$39,$01,$41,$01,$43,$01
            dc.b    $48,$01,$4D,$01,$52,$01,$57,$01,$5C,$01,$60,$01,$65,$01,$6A,$01
            dc.b    $6C,$01,$6F,$01,$74,$01,$76,$01,$7F,$01,$84,$01,$89,$01,$8E,$01
            dc.b    $93,$01,$98,$01,$9D,$01,$A1,$01,$A6,$01,$AB,$01,$B4,$01,$B9,$01
            dc.b    $BE,$01,$C3,$01,$C6,$01,$C7,$01,$CA,$01,$D0,$01,$D0,$01,$D7,$01
            dc.b    $DE,$01,$E4,$01,$E9,$01,$EF,$01,$F5,$01,$FB,$02,$00,$02,$05,$02
            dc.b    $0A,$02,$0F,$02,$14,$02,$19,$02,$1E,$02,$23,$02,$28,$02,$2D,$02
            dc.b    $32,$02,$34,$02,$36,$02,$39,$02,$3C,$02,$41,$02,$46,$02,$4B,$02
            dc.b    $50,$02,$55,$02,$5A,$02,$5F,$02,$64,$02,$69,$02,$6E,$02,$71,$02
            dc.b    $75,$02,$7A,$02,$80,$02,$86,$02,$8C,$02,$92,$02,$99,$02,$A1,$02
            dc.b    $A9,$02,$B2,$02,$B4,$02,$B7,$02,$BD,$02,$C7,$02,$CF,$02,$D8,$02
            dc.b    $DD,$02,$E1,$02,$E5,$02,$EA,$02,$F1,$02,$F6,$02,$FC,$03,$03,$03
            dc.b    $0B,$03,$0E,$03,$13,$03,$18,$03,$20,$03,$29,$03,$30,$03,$35,$03
            dc.b    $36,$03,$3B,$03,$43,$03,$46,$03,$4C,$03,$53,$03,$59,$03,$5F,$03
            dc.b    $66,$03,$66,$03,$6D,$03,$74,$03,$7A,$03,$84,$03,$8D,$03,$91,$03
            dc.b    $98,$03,$9D,$03,$A2,$03,$A4,$03,$A6,$03,$AB,$03,$B2,$03,$B7,$03
            dc.b    $C4,$03,$CE,$00,$00,$FF,$FF
            ds.b    8
            dc.w    $FFFF,$FFFF,$FFFF,$0808,$FFFF,$FFFF,$FFFF,0
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$0404,$0103,$0105,$0109,$0107,$0109
            dc.w    $0009,$0103,$0105,$0105,$0108,$0107,$0104,$0107
            dc.w    $0103,$0107,$0108,$0308,$0108,$0108,$0108,$0108
            dc.w    $0108,$0108,$0108,$0108,$0103,$0104,$0106,$0107
            dc.w    $0106,$0108,$010A,$0109,$0108,$0108,$0108,$0107
            dc.w    $0107,$0108,$0108,$0205,$0007,$0108,$0107,$0109
            dc.w    $0108,$0108,$0108,$0108,$0108,$0108,$0008,$0108
            dc.w    $0109,$010B,$0107,$0107,$0107,$0104,$0107,$0104
            dc.w    $0104,$0008,$0104,$0107,$0107,$0107,$0107,$0107
            dc.w    $0106,$0107,$0107,$0105,$0106,$0107,$0105,$010B
            dc.w    $0107,$0107,$0107,$0107,$0106,$0107,$0106,$0107
            dc.w    $0107,$010B,$0107,$0107,$0107,$0105,$0103,$0105
            dc.w    $0108,0,$0109,$0109,$0108,$0107,$0108,$0108
            dc.w    $0108,$0107,$0107,$0107,$0107,$0107,$0107,$0107
            dc.w    $0107,$0107,$0107,$0107,$0205,$0105,$0105,$0105
            dc.w    $0107,$0107,$0107,$0107,$0107,$0107,$0107,$0107
            dc.w    $0107,$0107,$0105,$0106,$0107,$0108,$0108,$0108
            dc.w    $0108,$0109,$010A,$010A,$010B,$0104,$0105,$0108
            dc.w    $010C,$0008,$010B,$0107,$0106,$0106,$0107,$0109
            dc.w    $0107,$0108,$0109,$010A,$0105,$0006,$0006,$010A
            dc.w    $010B,$0007,$0108,$0204,$0107,$010A,$0105,$0108
            dc.w    $0109,$0108,$0108,$020A,$0808,$0109,$0109,$0108
            dc.w    $010C,$010B,$0106,$0109,$0107,$0107,$0104,$0104
            dc.w    $0107,$0109,$0108,$010F,$000A
            ds.b    68
            dc.w    $0309,$0302,$0305,$020B,$0309,$0309,$0302,$020B
            dc.w    $020B,$0305,$0505,$0B03,$0701,$0B01,$020A,$0309
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0606,$0608,$0507,$0704,$0507,$0309,$0408
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $030A,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0309,$020B,$020A,$020B,$0302,$0B01,$0302
            dc.w    $0507,$0309,$0507,$0309,$0507,$0309,$050A,$0309
            dc.w    $0309,$030C,$0309,$0309,$0507,$0507,$0507,$0509
            dc.w    $0509,$0507,$0507,$0309,$0507,$0507,$0507,$0507
            dc.w    $050A,$0507,$020B,$020B,$020B,$0302,0,$010B
            dc.w    $000C,$030C,$000C,$000C,$010B,$010B,$020A,$020A
            dc.w    $020A,$0309,$020A,$000C,$0509,$020A,$020A,$020A
            dc.w    $0309,$020A,$020A,$020A,$0309,$020A,$020A,$020A
            dc.w    $020A,$0309,$020A,$020A,$020A,$020A,$0309,$0205
            dc.w    $0304,$0409,$0309,$030A,$0506,$0309,$0309,$0408
            dc.w    $0408,$0304,$0302,$0301,$0606,$0309,$0309,$0605
            dc.w    $0507,$0507,$0507,$0309,$0509,$0309,$0309,$0309
            dc.w    $0408,$030C,$0307,$0307,$0309,$0507,$0507,$0309
            dc.w    $0309,$0703,$020A,$030C,$0605,$0408,$0705,$0705
            dc.w    $0B01,0,$000C,$000C,$000C,$0309,$0507,$0801
            dc.w    $0801,$0203,$0203,$0203,$0203,$0505,$0408,$030C
            dc.w    $0209,$0309,$001E
            ds.b    8
RsrcEntryFONT_393:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 393 (2596 bytes) - Combo mask
            dc.l    RsrcEntryFONT_396-BaseOfROM     ; Next entry
            dc.l    RsrcFONT_393-BaseOfROM          ; Data
            dc.b    'FONT'                          ; Type
            dc.w    393                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000A30,$00000094   ; Block header
RsrcFONT_393:
            dc.w    $9001,0,$00D9,$000A,0,$FFF6,$000A,$000C
            dc.w    $0351,$000A,$0002,0,$0034
            ds.b    49
            dc.b    $03,$80,$4D
            ds.b    41
            dc.b    $6B,$40
            ds.b    58
            dc.b    $54,$40,$96,$52,$80,$00,$01,$80
            ds.b    25
            dc.b    $02
            ds.b    5
            dc.b    $04,$00,$00,$00,$04,$B5,$80
            ds.b    9
            dc.w    $0510,$00C0,$C000,$0080
            ds.b    23
            dc.b    $01,$C6
            ds.b    14
            dc.b    $03,$80,$03,$80,$00,$00,$09,$08,$16,$40,$91,$01,$90,$52,$44,$05
            dc.b    $24,$40,$4C,$00,$38,$00,$01,$E1,$E0
            ds.b    10
            dc.b    $04,$00,$70,$00,$00,$00,$68,$00,$00,$00,$02
            ds.b    4
            dc.b    $0A,$AA
            ds.b    5
            dc.w    $DFB9,$FD25,$2500,$00B9,$77C5,$F37D,$CE00,$018E
            dc.w    $13CE,$E7FB,$A30C,$620E,$5DE7,$79DF,$8C60,$C63F
            dc.w    $4280,$8200,$40C2,$1318,0,$0004,0,$0005
            dc.w    $4D21,$1DF9,$7450,$9569,$810A,$A66D,$A42A,$9A42
            dc.w    $A9F2,$4344,$0F72,$1217,$8B40,$3E74,0,$0883
            dc.w    $3FF8,$14EC,$8800,$0500,$4800,0,$0423,$9FC0
            dc.w    $0014,$B201,$1200,$FC00,$D556,$4946,$1210,$0147
            dc.w    $888D,$0406,$3104,$1251,$1231,$9444,$630C,$A31E
            dc.w    $6318,$C624,$8C60,$C623,$2340,$4200,$4102,$0108
            dc.w    0,$0004,0,$0005,$5621,$2319,$8C40
            ds.b    11
            dc.b    $52,$E4,$41,$D5,$8D,$CC,$CA,$DC,$04,$50,$89,$8C,$42,$45,$48,$92
            dc.b    $93,$E5,$33,$04,$01,$A0,$00,$88,$24,$00,$00,$04,$24,$62,$00,$00
            dc.b    $15,$54,$42,$80,$7C,$84,$00,$8F,$D2,$50,$82,$1F,$90,$01,$45,$09
            dc.b    $15,$E8,$0A,$31,$AB,$E8,$66,$AA,$30,$8C,$44,$23,$0D,$22,$AD,$63
            dc.b    $18,$C6,$04,$8C,$55,$29,$45,$22,$00,$1B,$99,$DB,$9F,$B7,$2F,$6E
            dc.b    $6E,$7B,$7F,$31,$83,$19,$F5,$40,$52,$A1,$15,$8C,$5D,$DD,$DD,$D9
            dc.b    $99,$9B,$F6,$E6,$66,$66,$99,$99,$4D,$54,$3B,$F5,$8D,$2D,$0A,$A8
            dc.b    $3E,$50,$9A,$52,$44,$2F,$C9,$48,$95,$25,$33,$05,$F2,$45,$00,$9D
            dc.b    $C4,$26,$40,$0A,$54,$62,$1B,$00,$00,$00,$04,$51,$82,$84,$00,$85
            dc.b    $39,$B9,$52,$12,$7C,$F2,$45,$13,$A4,$1F,$09,$CF,$10,$04,$AA,$AB
            dc.b    $D0,$8F,$74,$FF,$0E,$22,$4D,$63,$E8,$F9,$C4,$8A,$95,$10,$89,$12
            dc.b    $00,$06,$66,$65,$26,$53,$4C,$99,$99,$9C,$85,$2A,$54,$A9,$29,$20
            dc.b    $52,$A1,$D5,$8C
            dc.b    'fffffeR'
            dc.w    $9999,$9999,$9941,$4E47,$F5B5,$CD0A,$8808,$FCAA
            dc.w    $23F8,$124A,$4491,$24ED,$064A,$C9FD,$0A2A,$4920
            dc.w    $0A54,$63A4,$8000,$01F8,$3187,$8400,$8014,$6622
            dc.w    $1510,$0245,$207E,$1892,$210B,$E92A,$FE30,$8C44
            dc.w    $638D,$220C,$E308,$D024,$8A8A,$2891,$1200,$1E62
            dc.b    $7D,$26,$53,$8C,$99,$99,$98
            dc.b    'e*TIE@'
            dc.b    $FF,$E1,$13,$8C,$66,$66,$66,$63,$FF,$FD,$52,$99,$99,$99,$99,$99
            dc.b    $01,$54,$3B,$EF,$8D,$2C,$C8,$00,$3E,$90,$CA,$52,$44,$2F,$CA,$48
            dc.b    $91,$24,$00,$8A,$7B,$51,$15,$09,$CA,$90,$90,$1F,$FC,$62,$27,$FF
            dc.b    $E0,$00,$04,$51,$83,$84,$00,$00,$54,$A6,$52,$10,$10,$04,$45,$44
            dc.b    $45,$18,$92,$22,$04,$10,$27,$46,$31,$94,$44,$63,$8C,$A2,$0C,$E3
            dc.b    $0A,$CA,$24,$89,$0A,$44,$91,$0A,$00
            dc.b    '&fa&SL'
            dc.w    $9999,$9815,$2428,$A985,$408C,$6313,$8C66,$6666
            dc.w    $6622,$2152,$9999,$9999,$9900,$E485,$C58A,$1210
            dc.w    $0011,$1089,$8C42,$424A,$5291,$25FE,$5242,$5312
            dc.w    $0A11,$4920,$118C,$6224,0,$0042,$917C,$8400
            dc.w    $8039,$1989,$2001,$0C39,$FB84,$E711,$CCA0,$0110
            dc.w    $47CE,$E7C3,$A374,$7E0C,$5D07,$45C4,$710A,$449F
            dc.w    $0A3F,$1F99,$D91E,$532C,$996E,$78E2,$E429,$17F5
            dc.w    $408C,$5DF1,$739D,$DDDD,$D9D9,$9D52,$9666,$6677
            dc.w    $7700,$4F44,$05B1,$E1E0,$0001,$1F70,$01FF,$F275
            dc.w    $BE92,$4400,$D9F5,$8D02,$081F,$2649,$318B,$9FDF
            dc.w    0,$0001,$0F44,$FC00,$0010,0,$C001
            ds.b    7
            dc.b    $20,$00,$0E
            ds.b    9
            dc.b    $01
            ds.b    5
            dc.b    $01,$86
            ds.b    4
            dc.b    $04,$02,$00,$00,$08,$10,$00,$00,$00,$01,$03,$80,$00,$08
            ds.b    5
            dc.b    $08
            ds.b    10
            dc.b    $38
            ds.b    11
            dc.b    $40,$00,$00,$04
            ds.b    5
            dc.b    $08
            ds.b    11
            dc.b    $01
            ds.b    8
            dc.b    $02
            ds.b    7
            dc.b    $40
            ds.b    23
            dc.b    $18,$0C,$00,$00,$08,$10,$00,$00,$00,$06,$00,$00,$00,$10
            ds.b    5
            dc.b    $10
            ds.b    22
            dc.b    $40,$00,$00,$08
            ds.b    5
            dc.b    $10
            ds.b    11
            dc.b    $0E
            ds.b    72
            dc.b    $01,$00,$04,$00,$09,$00,$0E,$00,$16,$00,$1D,$00,$1E,$00,$21,$00
            dc.b    $24,$00,$29,$00,$2E,$00,$30,$00,$34,$00,$35,$00,$39,$00,$3E,$00
            dc.b    $40,$00,$45,$00,$4A,$00,$4F,$00,$54,$00,$59,$00,$5E,$00,$63,$00
            dc.b    $68,$00,$69,$00,$6B,$00,$6E,$00,$73,$00,$76,$00,$7A,$00,$81,$00
            dc.b    $86,$00,$8B,$00,$90,$00,$95,$00,$99,$00,$9D,$00,$A2,$00,$A7,$00
            dc.b    $A8,$00,$AD,$00,$B2,$00,$B6,$00,$BD,$00,$C2,$00,$C7,$00,$CC,$00
            dc.b    $D1,$00,$D6,$00,$DB,$00,$E0,$00,$E5,$00,$EA,$00,$F1,$00,$F6,$00
            dc.b    $FB,$00,$FF,$01,$01,$01,$05,$01,$07,$01,$0A,$01,$10,$01,$12,$01
            dc.b    $16,$01,$1A,$01,$1E,$01,$22,$01,$26,$01,$2A,$01,$2E,$01,$32,$01
            dc.b    $34,$01,$37,$01,$3B,$01,$3D,$01,$44,$01,$48,$01,$4C,$01,$50,$01
            dc.b    $54,$01,$58,$01,$5C,$01,$5F,$01,$63,$01,$68,$01,$6F,$01,$74,$01
            dc.b    $78,$01,$7C,$01,$7F,$01,$80,$01,$83,$01,$88,$01,$88,$01,$8D,$01
            dc.b    $92,$01,$97,$01,$9B,$01,$A0,$01,$A5,$01,$AA,$01,$AE,$01,$B2,$01
            dc.b    $B6,$01,$BA,$01,$BE,$01,$C2,$01,$C6,$01,$CA,$01,$CE,$01,$D2,$01
            dc.b    $D6,$01,$D8,$01,$DA,$01,$DD,$01,$E0,$01,$E4,$01,$E8,$01,$EC,$01
            dc.b    $F0,$01,$F4,$01,$F8,$01,$FC,$02,$00,$02,$04,$02,$08,$02,$0B,$02
            dc.b    $0F,$02,$14,$02,$19,$02,$1E,$02,$23,$02,$28,$02,$2D,$02,$35,$02
            dc.b    $3D,$02,$45,$02,$47,$02,$4A,$02,$4F,$02,$57,$02,$5E,$02,$67,$02
            dc.b    $6C,$02,$70,$02,$74,$02,$79,$02,$7E,$02,$82,$02,$87,$02,$8D,$02
            dc.b    $94,$02,$97,$02,$9B,$02,$9F,$02,$A6,$02,$AD,$02,$B3,$02,$B7,$02
            dc.b    $B8,$02,$BC,$02,$C3,$02,$C6,$02,$CB,$02,$D0,$02,$D6,$02,$DC,$02
            dc.b    $E3,$02,$E3,$02,$E8,$02,$ED,$02,$F2,$02,$FA,$03,$01,$03,$05,$03
            dc.b    $0B,$03,$0F,$03,$13,$03,$15,$03,$17,$03,$1C,$03,$23,$03,$28,$03
            dc.b    $30,$03,$37
            ds.b    12
            dc.w    $FFFF,$FFFF,$FFFF,$0606,$FFFF,$FFFF,$FFFF,0
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$0707,$FFFF
            dc.w    $FFFF,$FFFF,$0303,$0103,$0105,$0107,$0006,$0009
            dc.w    $0008,$0103,$0004,$0004,$0107,$0006,$0104,$0005
            dc.w    $0103,$0106,$0006,$0106,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0006,$0006,$0204,$0104,$0105,$0006
            dc.w    $0105,$0106,$0008,$0107,$0006,$0006,$0006,$0005
            dc.w    $0005,$0006,$0006,$0103,$0006,$0006,$0005,$0008
            dc.w    $0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006
            dc.w    $0006,$0008,$0006,$0006,$0005,$0104,$0106,$0104
            dc.w    $0004,$0006,$0003,$0005,$0005,$0005,$0005,$0005
            dc.w    $0004,$0005,$0005,$0003,$0004,$0005,$0003,$0008
            dc.w    $0005,$0005,$0005,$0005,$0005,$0005,$0004,$0005
            dc.w    $0006,$0008,$0006,$0006,$0005,$0004,$0002,$0004
            dc.w    $0006,0,$0107,$0107,$0006,$0005,$0006,$0006
            dc.w    $0006,$0005,$0005,$0005,$0005,$0005,$0005,$0005
            dc.w    $0005,$0005,$0005,$0005,$0003,$0003,$0004,$0004
            dc.w    $0005,$0005,$0005,$0005,$0005,$0005,$0005,$0005
            dc.w    $0005,$0005,$0004,$0005,$0006,$0006,$0006,$0006
            dc.w    $0006,$0006,$0009,$0009,$0009,$0104,$0004,$0006
            dc.w    $0009,$0007,$000A,$0006,$0005,$0005,$0006,$0006
            dc.w    $0005,$0006,$0007,$0008,$0105,$0005,$0005,$0008
            dc.w    $0109,$0006,$0106,$0103,$0005,$0008,$0105,$0006
            dc.w    $0107,$0008,$0108,$0008,$0606,$0107,$0107,$0006
            dc.w    $0009,$0008,$0005,$0007,$0107,$0207,$0104,$0104
            dc.w    $0006,$0008,$0006,$0009,$0007
            ds.b    68
            dc.w    $0307,$0302,$0205,$0209,$0307,$0208,$0302,$0209
            dc.w    $0209,$0305,$0405,$0903,$0601,$0901,$0208,$0307
            dc.w    $0307,$0307,$0307,$0307,$0307,$0307,$0307,$0307
            dc.w    $0307,$0505,$0507,$0405,$0503,$0405,$0307,$0308
            dc.w    $0307,$0307,$0307,$0307,$0307,$0307,$0307,$0307
            dc.w    $0307,$0307,$0307,$0307,$0307,$0307,$0307,$0307
            dc.w    $0308,$0307,$0307,$0307,$0307,$0307,$0307,$0307
            dc.w    $0307,$0307,$0209,$0208,$0209,$0302,$0901,$0302
            dc.w    $0505,$0307,$0505,$0307,$0505,$0307,$0507,$0307
            dc.w    $0307,$0309,$0307,$0307,$0505,$0505,$0505,$0507
            dc.w    $0507,$0505,$0505,$0307,$0505,$0505,$0505,$0505
            dc.w    $0507,$0505,$0209,$0209,$0209,$0302,0,$0109
            dc.w    $000A,$0309,$000A,$000A,$0109,$0109,$0208,$0208
            dc.w    $0208,$0307,$0208,$0109,$0507,$0208,$0208,$0208
            dc.w    $0307,$0208,$0208,$0208,$0307,$0208,$0208,$0208
            dc.w    $0208,$0307,$0208,$0208,$0208,$0208,$0307,$0205
            dc.w    $0204,$0307,$0307,$0209,$0405,$0307,$0307,$0208
            dc.w    $0208,$0304,$0302,$0301,$0405,$0307,$0307,$0405
            dc.w    $0406,$0406,$0406,$0307,$0408,$0307,$0307,$0307
            dc.w    $0307,$010B,$0306,$0306,$0208,$0505,$0406,$0307
            dc.w    $0307,$0603,$0208,$010B,$0405,$0406,$0505,$0505
            dc.w    $0901,0,$0109,$000A,$000A,$0307,$0505,$0701
            dc.w    $0701,$0203,$0203,$0203,$0203,$0405,$0307,$0309
            dc.w    $0406,$0307
            ds.b    4
            ds.b    12
RsrcEntryFONT_384:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 384 "Geneva" (4 bytes) - Combo mask
            dc.l    RsrcEntryFONT_393-BaseOfROM     ; Next entry
            dc.l    RsrcEntryFONT_12-BaseOfROM      ; Data
            dc.b    'FONT'                          ; Type
            dc.w    384                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    6,'Geneva'                      ; Name
            ds.b    6
            dc.l    $C0A00000,$00000010,$0000008C   ; Block header
RsrcEntryFONT_12:
RsrcFONT_384:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 12 (3620 bytes) - Combo mask
            dc.l    RsrcEntryFONT_384-BaseOfROM     ; Next entry
            dc.l    RsrcFONT_12-BaseOfROM           ; Data
            dc.b    'FONT'                          ; Type
            dc.w    12                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000E30,$00000084   ; Block header
RsrcFONT_12:
            dc.w    $9001,0,$00F0,$000E,0,$FFF4,$000C,$000F
            dc.w    $0521,$000C,$0003,$0001,$0047
            ds.b    69
            dc.b    $06,$00,$26,$40
            ds.b    4
            dc.b    $01,$80
            ds.b    46
            dc.b    $02,$19,$64
            ds.b    14
            dc.w    $0600,0,$0180
            ds.b    62
            dc.b    $02,$49,$00,$49,$89,$24,$00,$00,$00,$02,$40
            ds.b    46
            dc.b    $01,$26,$98
            ds.b    8
            dc.w    $3000,$0C00,0,$0C00,0,$0300,$1223,$7000
            dc.w    $6000,$0008
            ds.b    31
            dc.b    $F0,$E0,$00,$80
            ds.b    18
            dc.b    $38,$00,$09
            ds.b    4
            dc.w    $2106,$00CA,$4008,$4180,$3303,$2210,$600C,$8841
            dc.w    $8000,$2007
            ds.b    26
            dc.b    $E0
            ds.b    15
            dc.w    $6000,$4800,$0004,$0831,$8000,$021D,$1274,$91E2
            dc.w    $9100,$000B,$CDEF,$C37E,$77EF,$3C00,$000F,$001E
            dc.w    $F9EF,$BFF7,$B3C3,$C788,$060B,$DF3D,$F3BF,$CF3C
            dc.w    $CF3C,$FFD0,$6400,$4060,$00C0,$3818,$63C3
            ds.b    5
            dc.b    $06
            ds.b    5
            dc.b    $54,$03,$CF,$3D,$F8,$2F,$66,$40,$89,$25,$31,$80,$10,$22,$49,$4C
            dc.b    $CC,$C4,$08,$92,$53,$10,$22,$49,$26,$71,$C8,$81,$F9,$E3,$C3,$CE
            dc.b    $89,$90,$0F,$F1,$E8,$00,$00,$03,$0C,$00,$0F,$FF,$E0,$03,$73,$8F
            dc.b    $00,$00,$03,$30,$00,$86
            ds.b    4
            dc.b    $07,$9E,$79,$FE,$00,$00,$02,$76,$E0,$00,$90,$43,$FC,$8C,$00,$00
            dc.b    $08,$77,$4A,$40,$22,$1D,$DD,$7F,$AC,$A3,$33,$9D,$40,$00,$16,$7E
            dc.b    $31,$87,$60,$C0,$79,$E6,$03,$03,$11,$9F,$33,$CF,$1C,$F1,$8C,$73
            dc.b    $C3,$CD,$8C,$0F,$0E,$79,$E7,$9E,$4C,$CF,$3C,$CF,$3C,$C3,$C8,$6A
            dc.b    $00,$20,$60,$00,$C0,$60,$18,$00,$C3
            ds.b    5
            dc.b    $06
            ds.b    5
            dc.b    $54,$06,$79,$E3,$8C,$39,$E6
            ds.b    17
            dc.b    $79,$AB,$2C,$03,$2B,$34,$24,$24,$DA,$00,$19,$83,$30,$00,$00,$01
            dc.b    $98,$01,$C6,$2C,$C0,$16,$9E,$D9,$80,$00,$03,$30,$01,$0C,$00,$80
            dc.b    $00,$00,$0C,$F3,$CF,$30,$00,$00,$04,$B7,$60,$10,$03,$BA,$04,$6E
            dc.b    $00,$00,$0B,$81,$CA,$40,$67,$3F,$FD,$24,$E3,$23,$37,$9B,$88,$00
            dc.b    $16,$6C,$33,$0B,$61,$80,$79,$E7,$E6,$01,$81,$A0,$B3,$CF,$0C,$F1
            dc.b    $8C,$33,$C3,$D9,$8E,$1F,$8E,$79,$E7,$9E,$0C,$CF,$3C,$CF,$3C,$C3
            dc.b    $C8,$71,$00,$0F,$7C,$E7,$DE,$F3,$FF,$63,$CF,$FF,$BE,$7B,$E7,$F6
            dc.b    $EF,$CF,$3C,$CF,$3C,$FF,$54,$CE,$79,$E1,$8E,$39,$E6,$F3,$CF,$3C
            dc.b    $F3,$CF,$3C,$F3,$CF,$7B,$37,$CF,$3C,$F3,$CF,$67,$9E,$79,$A9,$A3
            dc.b    $06,$3B,$2B,$3B,$99,$94,$AC,$00,$99,$83,$33,$8F,$10,$93,$FD,$98
            dc.b    $63,$0C,$CF,$E6,$7E,$F0,$DF,$E3,$D0,$00,$01,$0C,$08,$81,$32,$00
            dc.b    $0C,$F3,$CF,$30,$FF,$00,$06,$D3,$A4,$29,$9F,$FE,$04,$00,$00,$00
            dc.b    $0B,$82,$3F,$80,$CF,$BF,$98,$24,$E0,$41,$85,$9D,$48,$00,$26,$6C
            dc.b    $37,$93,$7D,$F0,$79,$E7,$EC,$FC,$C3,$4E,$73,$CF,$0C,$F1,$8C,$33
            dc.b    $C3,$F1,$8F,$3F,$CE,$79,$E7,$9F,$0C,$CF,$3C,$CF,$3C,$C6,$C4,$60
            dc.b    $00,$11,$E7,$9C,$F3,$66,$79,$E3,$DB,$CC,$F3,$CF,$3C,$F9,$96,$CF
            dc.b    $3C,$CF,$3C,$C3,$55,$36,$79,$E1,$8F,$39,$E7,$1C,$71,$C7,$1C,$78
            dc.b    $E7,$9E,$79,$FB,$36,$79,$E7,$9E,$79,$E7,$9E,$79,$A6,$A3,$0B,$7F
            dc.b    $2B,$6A,$5A,$54,$88,$0F,$F9,$83,$74,$58,$91,$08,$61,$98,$F1,$8C
            dc.b    $D6,$66,$DE,$F0,$E3,$36,$63,$30,$22,$1E,$F1,$42,$49,$00,$0C,$F3
            dc.b    $CF,$31,$99,$80,$06,$E5,$C0,$45,$9F,$F2,$05,$B0,$00,$00,$0B,$82
            dc.b    $0A,$01,$9F,$FF,$98,$FE,$70,$43,$39,$99,$3E,$7C,$26,$6C,$60,$E3
            dc.b    $07,$98,$CF,$66,$18,$00,$66,$52,$7F,$FB,$0C,$FD,$ED,$FF,$C3,$E1
            dc.b    $8B,$EE,$EE,$7F,$67,$F3,$8C,$CF,$3C,$CD,$E7,$8C,$C4,$60,$00,$0F
            dc.b    $E7,$8C,$F3,$66,$79,$E3,$F3,$CC,$F3,$CF,$3C,$F1,$C6,$CF,$3C,$CF
            dc.b    $3C,$C6,$92,$07,$FF,$E1,$EB,$B9,$E6,$FB,$EF,$BE,$FB,$F8,$67,$9E
            dc.b    $79,$FB,$36,$79,$E7,$9E,$79,$E7,$9E,$79,$A0,$AF,$89,$FD,$EB,$3B
            dc.b    $9A,$10,$00,$01,$1F,$E3,$B4,$30,$FE,$07,$FD,$99,$B0,$CC,$C6,$66
            dc.b    $DE,$F0,$DF,$36,$63,$3F,$E2,$0D,$09,$44,$84,$80,$0F,$FF,$CF,$3D
            dc.b    $99,$FF,$F8,$00,$1F,$83,$9F,$F2,$05,$FE,$00,$00,$0B,$81,$BF,$A3
            dc.b    $0F,$BF,$F8,$48,$38,$9B,$31,$98,$08,$00,$46,$6C,$C0,$FF,$87,$99
            dc.b    $99,$BE,$0C,$FC,$C6,$52,$73,$CF,$0C,$F1,$8C,$F3,$F3,$F1,$89,$CE
            dc.b    $7E,$78,$67,$99,$CC,$CF,$3C,$CF,$33,$18,$C2,$60,$00,$19,$E7,$8C
            dc.b    $FF,$66,$79,$E3,$E3,$CC,$F3,$CF,$3C,$F0,$E6,$CF,$3C,$CD,$EC,$CC
            dc.b    $54,$06,$79,$E1,$89,$F9,$E7,$9E,$79,$E7,$9E,$78,$7F,$FF,$FF,$FB
            dc.b    $36,$79,$E7,$9E,$79,$E7,$9E,$79,$80,$73,$0C,$FC,$2B,$3A,$5A,$50
            dc.b    $00,$0F,$F9,$83,$34,$68,$91,$08,$61,$9B,$31,$8C,$C6,$66,$7B,$90
            dc.b    $B3,$F6,$E6,$30,$94,$0C,$F2,$29,$02,$40,$0C,$F3,$CF,$31,$9F,$80
            dc.b    $00,$00,$00,$45,$9F,$FE,$04,$66,$00,$00,$07,$80,$CA,$76,$07,$3F
            dc.b    $E0,$48,$38,$A7,$31,$98,$08,$00,$46,$6D,$80,$C3,$07,$99,$99,$86
            dc.b    $06,$01,$80,$4D,$B3,$CF,$0C,$F1,$8C,$F3,$F3,$D9,$88,$8E,$3E,$78
            dc.b    $67,$98,$CC,$CF,$3C,$CF,$33,$30,$C2,$60,$00,$19,$E7,$8C,$F0,$66
            dc.b    $79,$E3,$F3,$CC,$F3,$CF,$3C,$F0,$76,$CF,$3C,$CF,$3C,$D8,$54,$06
            dc.b    $79,$E1,$88,$F9,$E7,$9E,$79,$E7,$9E,$78,$61,$86,$18,$7B,$36,$79
            dc.b    $E7,$9E,$79,$E7,$9E,$79,$80,$23,$06,$B8,$2B,$3A,$59,$90,$00,$02
            dc.b    $19,$83,$33,$C7,$10,$90,$61,$9B,$33,$0C,$C6,$66,$00,$09,$33,$07
            dc.b    $6C,$30,$94,$0D,$02,$24,$84,$80,$0C,$F3,$CF,$31,$98,$00,$00,$00
            dc.b    $04,$29,$9F,$FE,$04,$36,$00,$00,$00,$49,$4A,$5C,$02,$1F,$D8,$00
            dc.b    $A9,$27,$31,$98,$01,$83,$86,$6F,$08,$C3,$47,$99,$99,$8D,$E3,$03
            dc.b    $06,$20,$33,$CF,$1C,$F1,$8C,$F3,$F3,$CD,$88,$0E,$1E,$78,$67,$9C
            dc.b    $CC,$CF,$2C,$CB,$33,$30,$C1,$60,$00,$19,$E7,$9C,$F1,$66,$79,$E3
            dc.b    $DB,$CC,$F3,$CF,$3C,$F1,$36,$CF,$2C,$CB,$3C,$F0,$54,$06,$79,$E3
            dc.b    $88,$79,$E7,$9E,$79,$E7,$9E,$78,$E3,$8E,$38,$FB,$36,$79,$E7,$9E
            dc.b    $79,$E7,$9E,$79,$80,$03,$13,$00,$2B,$34,$24,$20,$00,$00,$19,$87
            dc.b    $30,$00,$00,$00,$61,$9B,$26,$2C,$C6,$66,$FF,$C9,$33,$16,$6C,$70
            dc.b    $08,$0C,$04,$12,$49,$33,$3C,$F3,$CF,$31,$98,$80,$00,$00,$00,$11
            dc.b    $9B,$FA,$04
            ds.b    4
            dc.w    $3631,$8800,$0D98,$0071,$19E0,$9001,$8383,$CFF7
            dc.w    $833C,$F18F,$39E0,$0006,$1F33,$F9EF,$BF87,$B3DE
            dc.w    $C7F8,$0E0B,$D83D,$9B8C,$7BCF,$F333,$3FC1,$60FF
            dc.w    $0FFC,$E7DE,$63F9,$E3CF,$CCF3,$7BE7,$F0E3,$7FCF
            dc.w    $F337,$FF54,$0679,$BDF8,$2F3C,$FBEF,$BEFB,$EF3C
            dc.w    $F3CF,$7B36,$6F3C,$F3CF,$3EFB,$EF80,$07E1,$802F
            dc.w    $63C3,$C000,$0019,$F9E0,$007F,$FC61,$F5CF,$ECC4
            dc.w    $4600,$199F,$EBC7,$B008,$0C07,$F132,$333C,$F379
            dc.w    $FEFF
            ds.b    5
            dc.b    $F9,$B2,$04
            ds.b    11
            dc.b    $20,$00,$00,$60,$00,$80
            ds.b    8
            dc.b    $20
            ds.b    15
            dc.b    $06
            ds.b    7
            dc.b    $E0,$E0
            ds.b    6
            dc.b    $60,$03,$00,$00,$00,$03,$00,$C0
            ds.b    5
            dc.b    $C0,$38,$00,$00,$18
            ds.b    7
            dc.b    $06
            ds.b    14
            dc.b    $08,$80
            ds.b    12
            dc.b    $01
            ds.b    4
            dc.b    $06
            ds.b    7
            dc.b    $0C
            ds.b    14
            dc.b    $18,$03,$FC
            ds.b    15
            dc.b    $01
            ds.b    9
            dc.b    $40
            ds.b    30
            dc.b    $04,$60,$13,$00,$00,$00,$03,$00,$C0
            ds.b    4
            dc.b    $08,$C0,$00,$00,$00,$08
            ds.b    7
            dc.b    $02
            ds.b    14
            dc.b    $07
            ds.b    13
            dc.b    $02
            ds.b    4
            dc.b    $0C
            ds.b    7
            dc.b    $18
            ds.b    13
            dc.w    $0118
            ds.b    58
            dc.b    $03,$C0,$0E
            ds.b    10
            dc.b    $07,$80,$00,$00,$00,$10
            ds.b    7
            dc.b    $04
            ds.b    56
            dc.b    $F0
            ds.b    41
            dc.b    $09,$00,$12,$00,$1B,$00,$22,$00,$2B,$00,$2B,$00,$2B,$00,$2B,$00
            dc.b    $2B,$00,$2B,$00,$2B,$00,$2B,$00,$2B,$00,$2B,$00,$2B,$00,$2B,$00
            dc.b    $2B,$00,$2D,$00,$30,$00,$38,$00,$3D,$00,$46,$00,$4E,$00,$4F,$00
            dc.b    $52,$00,$55,$00,$5A,$00,$5F,$00,$61,$00,$66,$00,$68,$00,$6D,$00
            dc.b    $73,$00,$76,$00,$7C,$00,$82,$00,$89,$00,$8F,$00,$95,$00,$9B,$00
            dc.b    $A1,$00,$A7,$00,$A9,$00,$AB,$00,$B0,$00,$B6,$00,$BB,$00,$C1,$00
            dc.b    $CA,$00,$D0,$00,$D6,$00,$DC,$00,$E2,$00,$E7,$00,$EC,$00,$F2,$00
            dc.b    $F8,$00,$FA,$01,$00,$01,$07,$01,$0C,$01,$16,$01,$1D,$01,$23,$01
            dc.b    $29,$01,$2F,$01,$35,$01,$3A,$01,$40,$01,$46,$01,$4C,$01,$56,$01
            dc.b    $5C,$01,$62,$01,$68,$01,$6B,$01,$70,$01,$73,$01,$78,$01,$80,$01
            dc.b    $83,$01,$89,$01,$8F,$01,$94,$01,$9A,$01,$A0,$01,$A5,$01,$AB,$01
            dc.b    $B1,$01,$B3,$01,$B8,$01,$BE,$01,$C0,$01,$CA,$01,$D0,$01,$D6,$01
            dc.b    $DC,$01,$E2,$01,$E7,$01,$EC,$01,$F0,$01,$F6,$01,$FC,$02,$06,$02
            dc.b    $0C,$02,$12,$02,$18,$02,$1B,$02,$1C,$02,$1F,$02,$25,$02,$25,$02
            dc.b    $2B,$02,$31,$02,$37,$02,$3C,$02,$43,$02,$49,$02,$4F,$02,$55,$02
            dc.b    $5B,$02,$61,$02,$67,$02,$6D,$02,$73,$02,$79,$02,$7F,$02,$85,$02
            dc.b    $8B,$02,$91,$02,$93,$02,$95,$02,$99,$02,$9D,$02,$A3,$02,$A9,$02
            dc.b    $AF,$02,$B5,$02,$BB,$02,$C1,$02,$C7,$02,$CD,$02,$D3,$02,$D9,$02
            dc.b    $DC,$02,$E0,$02,$E5,$02,$EC,$02,$F1,$02,$F6,$02,$FD,$03,$04,$03
            dc.b    $0C,$03,$14,$03,$1D,$03,$20,$03,$24,$03,$2B,$03,$34,$03,$3D,$03
            dc.b    $49,$03,$4E,$03,$52,$03,$56,$03,$5E,$03,$66,$03,$6C,$03,$73,$03
            dc.b    $7B,$03,$84,$03,$88,$03,$8D,$03,$92,$03,$9A,$03,$A4,$03,$AC,$03
            dc.b    $B2,$03,$B4,$03,$B9,$03,$C3,$03,$C7,$03,$CD,$03,$D4,$03,$DB,$03
            dc.b    $E2,$03,$EC,$03,$EC,$03,$F2,$03,$F8,$03,$FE,$04,$07,$04,$11,$04
            dc.b    $15,$04,$1D,$04,$22,$04,$27,$04,$29,$04,$2B,$04,$30,$04,$37,$04
            dc.b    $3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04
            dc.b    $3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04
            dc.b    $3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04,$3D,$04
            dc.b    $46,$04,$4E,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$08,$08,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF
            dc.b    $FF,$FF,$FF,$01,$0B,$01,$0B,$01,$0B,$01,$09,$01,$0B,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$04,$04,$02,$06,$02,$07,$01,$0A,$01,$07,$01,$0B,$01
            dc.b    $0A,$01,$03,$01,$05,$01,$05,$01,$07,$01,$07,$01,$04,$01,$07,$01
            dc.b    $04,$01,$07,$01,$08,$02,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01
            dc.b    $08,$01,$08,$01,$08,$01,$08,$01,$04,$01,$04,$00,$06,$01,$08,$00
            dc.b    $06,$01,$08,$01,$0B,$01,$08,$01,$08,$01,$08,$01,$08,$01,$07,$01
            dc.b    $07,$01,$08,$01,$08,$02,$06,$00,$07,$01,$09,$01,$07,$01,$0C,$01
            dc.b    $09,$01,$08,$01,$08,$01,$08,$01,$08,$01,$07,$00,$06,$01,$08,$01
            dc.b    $08,$01,$0C,$01,$08,$01,$08,$01,$08,$01,$05,$01,$07,$01,$05,$02
            dc.b    $08,$00,$08,$01,$06,$01,$08,$01,$08,$01,$07,$01,$08,$01,$08,$01
            dc.b    $06,$01,$08,$01,$08,$01,$04,$00,$06,$01,$08,$01,$04,$01,$0C,$01
            dc.b    $08,$01,$08,$01,$08,$01,$08,$01,$06,$01,$07,$01,$06,$01,$08,$01
            dc.b    $08,$01,$0C,$01,$08,$01,$08,$01,$08,$01,$05,$02,$05,$01,$05,$01
            dc.b    $08,$08,$08,$01,$08,$01,$08,$01,$08,$01,$07,$01,$09,$01,$08,$01
            dc.b    $08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01
            dc.b    $08,$01,$08,$01,$08,$01,$08,$02,$06,$02,$06,$01,$06,$01,$06,$01
            dc.b    $08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01,$08,$01
            dc.b    $08,$01,$08,$01,$05,$01,$06,$01,$07,$01,$09,$01,$07,$01,$07,$01
            dc.b    $09,$01,$09,$01,$0A,$01,$0A,$01,$0B,$01,$05,$01,$06,$01,$09,$01
            dc.b    $0B,$00,$09,$01,$0E,$01,$07,$01,$06,$01,$06,$01,$0A,$01,$0A,$01
            dc.b    $08,$01,$09,$01,$0A,$01,$0B,$01,$06,$01,$07,$01,$07,$01,$0A,$01
            dc.b    $0C,$00,$08,$01,$08,$02,$06,$01,$07,$01,$0C,$01,$06,$02,$0A,$01
            dc.b    $09,$01,$09,$01,$09,$02,$0E,$08,$08,$01,$08,$01,$08,$01,$08,$01
            dc.b    $0B,$01,$0C,$01,$06,$01,$0A,$01,$07,$01,$07,$01,$04,$01,$04,$01
            dc.b    $07,$01,$09,$01,$08,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$01,$0B,$01,$0A,$00,$0A
            ds.b    32
            dc.w    $010B,$0309,$0408,$0407,$010B
            ds.b    24
            dc.w    $0309,$0303,$0208,$020B,$020A,$0309,$0303,$020B
            dc.w    $020B,$0305,$0505,$0A04,$0701,$0A02,$020A,$0309
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0507,$0509,$0407,$0603,$0407,$0309,$0408
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $030A,$0309,$0309,$0309,$0309,$0309,$0309,$0309
            dc.w    $0309,$0309,$020B,$020A,$020B,$0303,$0B01,$0203
            dc.w    $0507,$0309,$0507,$0309,$0507,$0309,$050A,$0309
            dc.w    $0309,$030C,$0309,$0309,$0507,$0507,$0507,$0509
            dc.w    $0509,$0507,$0507,$0309,$0507,$0507,$0507,$0507
            dc.w    $050A,$0507,$020B,$020B,$020B,$0502,0,$010B
            dc.w    $000C,$030C,$000C,$000C,$010B,$010B,$020A,$020A
            dc.w    $020A,$0309,$020A,$000C,$050A,$020A,$020A,$020A
            dc.w    $0309,$020A,$020A,$020A,$0309,$020A,$020A,$020A
            dc.w    $020A,$0309,$020A,$020A,$020A,$020A,$0309,$0305
            dc.w    $0304,$0208,$0309,$020C,$0505,$0309,$0309,$0309
            dc.w    $0309,$0304,$0303,$0301,$0505,$0309,$0309,$0505
            dc.w    $0507,$0507,$0507,$0309,$0509,$0408,$0309,$0309
            dc.w    $0408,$030B,$0308,$0308,$0309,$0507,$0507,$0309
            dc.w    $0309,$0703,$020A,$030B,$0505,$0408,$0507,$0507
            dc.w    $0A02,0,$000C,$000C,$000C,$0309,$0507,$0701
            dc.w    $0701,$0304,$0304,$0304,$0304,$0505,$0407,$030C
            ds.b    46
            dc.w    $010B,$030A,$6DB6,0
RsrcEntryFONT_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'FONT' 0 "Chicago" (4 bytes) - Combo mask
            dc.l    RsrcEntryFONT_12-BaseOfROM      ; Next entry
            dc.l    RsrcEntryCURS_4-BaseOfROM       ; Data
            dc.b    'FONT'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'Chicago'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00000010,$0000007C   ; Block header
RsrcEntryCURS_4:
RsrcFONT_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CURS' 4 (68 bytes) - Combo mask
            dc.l    RsrcEntryFONT_0-BaseOfROM       ; Next entry
            dc.l    RsrcCURS_4-BaseOfROM            ; Data
            dc.b    'CURS'                          ; Type
            dc.w    4                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000050,$00000074   ; Block header
RsrcCURS_4:
            dc.w    $3F00,$3F00,$3F00,$3F00,$4080,$8440,$8440,$8460
            dc.w    $9C60,$8040,$8040,$4080,$3F00,$3F00,$3F00,$3F00
            dc.w    $3F00,$3F00,$3F00,$3F00,$7F80,$FFC0,$FFC0,$FFC0
            dc.w    $FFC0,$FFC0,$FFC0,$7F80,$3F00,$3F00,$3F00,$3F00
            dc.w    $0008,$0008
            ds.b    12
RsrcEntryCURS_3:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CURS' 3 (68 bytes) - Combo mask
            dc.l    RsrcEntryCURS_4-BaseOfROM       ; Next entry
            dc.l    RsrcCURS_3-BaseOfROM            ; Data
            dc.b    'CURS'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000050,$0000006C   ; Block header
RsrcCURS_3:
            dc.w    0,$07C0,$0460,$0460,$0460,$7C7C,$4386,$4286
            dc.w    $4386,$7C7E,$3C7E,$0460,$0460,$07E0,$03E0,0
            dc.w    $0FC0,$0FE0,$0FF0,$0FF0,$FFFF,$FFFE,$FC7F,$FC7F
            dc.w    $FC7F,$FFFF,$7FFF,$7FFF,$0FF0,$0FF0,$07F0,$03E0
            dc.w    $0008,$0008
            ds.b    12
RsrcEntryCURS_2:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CURS' 2 (68 bytes) - Combo mask
            dc.l    RsrcEntryCURS_3-BaseOfROM       ; Next entry
            dc.l    RsrcCURS_2-BaseOfROM            ; Data
            dc.b    'CURS'                          ; Type
            dc.w    2                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000050,$00000064   ; Block header
RsrcCURS_2:
            dc.w    $0400,$0400,$0400,$0400,$0400,$FFE0,$0400,$0400
            dc.b    $04,$00,$04,$00,$04,$00,$04
            ds.b    42
            dc.b    $05,$00,$05
            ds.b    12
RsrcEntryCURS_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'CURS' 1 (68 bytes) - Combo mask
            dc.l    RsrcEntryCURS_2-BaseOfROM       ; Next entry
            dc.l    RsrcCURS_1-BaseOfROM            ; Data
            dc.b    'CURS'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000050,$0000005C   ; Block header
RsrcCURS_1:
            dc.w    $0C60,$0280,$0100,$0100,$0100,$0100,$0100,$0100
            dc.w    $0100,$0100,$0100,$0100,$0100,$0100,$0280,$0C60
            ds.b    33
            dc.b    $04,$00,$07
            ds.b    12
RomRsrcHead:
            dc.l    RsrcEntryCURS_1-BaseOfROM       ; Offset to first resource entry
            dc.b    $0A,$08                         ; Max valid index, combo field size
            dc.w    $0001,$000C                     ; Combo version, header size
            ds.b    5094
TOP512KOFROM:
MMUSTUFF_2:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $02C8,0,$0638
.L1:
            dc.w    $80F0,$5750
            ds.b    8
            dc.w    $0156,$0466,$0626
.L2:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $02A4,$FFDC,$0614,$80F0,$5750
            ds.b    8
            dc.w    $0132,$0442,$0602,$80F0,$5660
            ds.b    8
            dc.w    $0120,$0430,$05F0,$80F0,$5570
            ds.b    8
            dc.w    $010E,$041E,$05DE,$80F0,$5480
            ds.b    9
            dc.b    $FC,$04,$0C,$05,$CC,$80,$F0,$89
            ds.b    10
            dc.b    $EA,$03,$FA,$05,$BA,$80,$F0,$7A
            ds.b    10
            dc.b    $D8,$03,$E8,$05,$A8,$80,$F0,$6B
            ds.b    10
            dc.b    $C6,$03,$D6,$05,$96
.L3:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $025C,$FF4C,$072A
.L4:
            dc.w    $80F0,$5750
            ds.b    9
            dc.b    $CA,$03,$EA,$07,$18
.L5:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $0288,$FF28,$0874
.L6:
            dc.w    $80F0,$5750
            ds.b    9
            dc.b    $E6,$04,$16,$08,$62
.L7:
            dc.b    $00,$00,$C0
            ds.b    9
            dc.w    $02BC,$FF04,$0AA2
.L8:
            dc.w    0,$C000,$F900,$C060,$807F,$C040,$0102,$0442
            dc.w    $0A90
.L9:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $02F8,$FEE0,$099A
.L10:
            dc.w    $80F0,$5750
            ds.b    8
            dc.w    $011E,$046E,$0988
.L11:
            dc.b    $80,$F8,$45
            ds.b    9
            dc.w    $030C,$FEBC,$09CC
.L12:
            dc.w    $80F0,$5750
            ds.b    8
            dc.b    $01,$3A,$04,$9A,$09,$BA,$40
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$80
            ds.b    6
            dc.b    $20,$40
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7B,$B0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05,$04,$40
            ds.b    5
            dc.b    $20,$40
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7E,$E0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05,$01,$10
            ds.b    5
            dc.b    $20
            dc.w    $4080
            ds.b    5
            dc.b    $11,$00,$10
            ds.b    5
            dc.b    $12,$10,$60
            ds.b    5
            dc.b    $07,$00,$04
            ds.b    5
            dc.b    $20,$00,$04
            ds.b    5
            dc.b    $30,$1F,$08
            ds.b    5
            dc.b    $07,$10
            ds.b    6
            dc.b    $1A,$80
            ds.b    6
            dc.b    $07,$40
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7E,$E0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$00,$80
            ds.b    4
            dc.b    $09,$01,$1F
            ds.b    5
            dc.b    $20,$40
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$10
            ds.b    6
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$0F,$FF,$80
            ds.b    4
            dc.b    $05,$10
            ds.b    6
            dc.b    $0A,$80
            ds.b    6
            dc.b    $20,$00,$80
            ds.b    5
            dc.b    $01,$00,$10
            ds.b    5
            dc.b    $03,$00,$10,$00,$00,$F9,$00,$00,$26,$00,$10,$00,$00,$FA,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FB,$00,$00,$26,$00,$10,$00,$00,$FC,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FD,$00,$00,$26,$00,$10,$00,$00,$FE,$00,$00
            dc.b    $26,$00,$10,$00,$00,$50,$00,$00,$26,$00,$80
            ds.b    5
            dc.b    $01,$00,$10
            ds.b    5
            dc.b    $03,$00,$10,$00,$00,$F9,$00,$00,$26,$00,$10,$00,$00,$FA,$00,$00
            dc.b    $26,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05,$00,$10,$00,$00,$FC,$00,$00,$26,$00,$10,$00,$00,$FD,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FE,$00,$00,$26,$00,$10,$00,$00,$50,$00,$00
            dc.b    $26,$00,$80
            ds.b    5
            dc.b    $01,$00,$10
            ds.b    5
            dc.b    $03,$00,$10,$00,$00,$F9,$00,$00,$26,$00,$10,$00,$00,$FA,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FB,$00,$00,$26,$00,$10,$00,$00,$FC,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FD,$00,$00,$26,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05
            ds.b    7
            dc.b    $07,$00,$10,$00,$00,$50,$00,$00,$26,$00,$80
            ds.b    5
            dc.b    $11,$00,$10
            ds.b    5
            dc.b    $13,$00,$10,$00,$00,$F9,$00,$00,$36,$00,$10,$00,$00,$FA,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FB,$00,$00,$26,$00,$10,$00,$00,$FC,$00,$00
            dc.b    $26,$00,$10,$00,$00,$FD,$00,$00,$26,$00,$10,$00,$00,$FE,$00,$00
            dc.b    $26,$00,$04,$00,$00,$50,$F0,$00,$26,$00,$04,$00,$00,$50,$F4,$00
            dc.b    $36,$00,$08
            ds.b    5
            dc.b    $07,$FF,$00,$00,$01,$00,$00,$00,$08,$00,$80
            ds.b    5
            dc.b    $01,$00,$10
            ds.b    5
            dc.b    $03,$00,$50
            ds.b    5
            dc.b    $07,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$00,$80
            ds.b    4
            dc.b    $09,$00,$0F
            ds.b    5
            dc.b    $07,$00,$10,$00,$00,$50,$00,$00,$26,$00,$80
            ds.b    5
            dc.b    $01,$00,$10
            ds.b    5
            dc.b    $03,$00,$50
            ds.b    5
            dc.b    $07,$00,$10,$00,$00,$FE,$00,$00,$26,$00,$10,$00,$00,$50,$00,$00
            dc.b    $26,$00,$01
            ds.b    5
            dc.b    $01,$37,$FF
            ds.b    5
            dc.b    $07,$08
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$80
            ds.b    6
            dc.b    $20,$00,$01
            ds.b    5
            dc.b    $01,$37,$FF
            ds.b    5
            dc.b    $07,$08
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7B,$B0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05,$04,$40
            ds.b    5
            dc.b    $20,$00,$01
            ds.b    5
            dc.b    $01,$37,$FF
            ds.b    5
            dc.b    $07,$08
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7E,$E0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$0F,$80
            ds.b    4
            dc.b    $05,$01,$10
            ds.b    5
            dc.b    $20,$00,$01
            ds.b    5
            dc.b    $11,$37,$FF
            ds.b    5
            dc.b    $07,$08,$80
            ds.b    5
            dc.b    $11,$00,$10
            ds.b    5
            dc.b    $12,$10,$60
            ds.b    5
            dc.b    $07,$00,$04
            ds.b    5
            dc.b    $20,$00,$04
            ds.b    5
            dc.b    $30,$1F,$08
            ds.b    5
            dc.b    $07,$10
            ds.b    6
            dc.b    $1A,$80
            ds.b    6
            dc.b    $07,$00,$01
            ds.b    5
            dc.b    $01,$37,$FF
            ds.b    5
            dc.b    $07,$08
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$20
            ds.b    6
            dc.b    $20,$10
            ds.b    6
            dc.b    $0A,$7E,$E0
            ds.b    5
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$00,$00,$80
            ds.b    4
            dc.b    $05,$01,$1F
            ds.b    5
            dc.b    $20,$00,$01
            ds.b    5
            dc.b    $01,$37,$FF
            ds.b    5
            dc.b    $07,$08
            ds.b    6
            dc.b    $01,$10
            ds.b    6
            dc.b    $02,$10
            ds.b    6
            dc.b    $20,$00,$00,$80
            ds.b    4
            dc.b    $04,$0F,$FF,$80
            ds.b    4
            dc.b    $05,$10
            ds.b    6
            dc.b    $0A,$80
            ds.b    6
            dc.b    $20,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01,$40,$00,$00,$00,$10,$00,$00,$00,$40,$00,$00,$00,$10
            ds.b    4
            dc.b    $80,$00,$00,$00,$10,$00,$00,$00,$03,$00,$00,$50,$00,$00,$00,$10
            dc.b    $00,$00,$00,$50,$00,$00,$00,$10
            ds.b    4
            dc.b    $F0,$00,$00,$00,$10,$00,$00,$00,$05,$00,$00,$90,$00,$00,$00,$10
            dc.b    $00,$00,$00,$90,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$A0,$00,$00,$00,$10,$00,$00,$00,$A0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$B0,$00,$00,$00,$10,$00,$00,$00,$B0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$C0,$00,$00,$00,$10,$00,$00,$00,$C0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$D0,$00,$00,$00,$10,$00,$00,$00,$D0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$E0,$00,$00,$00,$10,$00,$00,$00,$E0,$00,$00,$00,$10
            ds.b    12
            dc.b    $04,$00,$00,$F9,$00,$00,$00,$01,$00,$00,$00,$F9,$00,$00,$00,$01
            ds.b    4
            dc.b    $90,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FA,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FA,$00,$00,$00,$01
            ds.b    4
            dc.b    $A0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FB,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FB,$00,$00,$00,$01
            ds.b    4
            dc.b    $B0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FC,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FC,$00,$00,$00,$01
            ds.b    4
            dc.b    $C0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FD,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FD,$00,$00,$00,$01
            ds.b    4
            dc.b    $D0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FE,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FE,$00,$00,$00,$01
            ds.b    4
            dc.b    $E0,$00,$00,$00,$10,$00,$00,$FF,$FF,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01,$40,$00,$00,$00,$10,$00,$00,$00,$40,$00,$00,$00,$10
            ds.b    4
            dc.b    $80,$00,$00,$00,$10,$00,$00,$00,$03,$00,$00,$50,$00,$00,$00,$10
            dc.b    $00,$00,$00,$50,$00,$00,$00,$10
            ds.b    4
            dc.b    $F0,$00,$00,$00,$10,$00,$00,$00,$05,$00,$00,$90,$00,$00,$00,$10
            dc.b    $00,$00,$00,$90,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$A0,$00,$00,$00,$10,$00,$00,$00,$A0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$C0,$00,$00,$00,$10,$00,$00,$00,$C0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$D0,$00,$00,$00,$10,$00,$00,$00,$D0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$E0,$00,$00,$00,$10,$00,$00,$00,$E0,$00,$00,$00,$10
            ds.b    12
            dc.b    $04,$00,$00,$F9,$00,$00,$00,$01,$00,$00,$00,$F9,$00,$00,$00,$01
            ds.b    4
            dc.b    $90,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FA,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FA,$00,$00,$00,$01
            ds.b    4
            dc.b    $A0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FC,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FC,$00,$00,$00,$01
            ds.b    4
            dc.b    $C0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FD,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FD,$00,$00,$00,$01
            ds.b    4
            dc.b    $D0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FE,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FE,$00,$00,$00,$01
            ds.b    4
            dc.b    $E0,$00,$00,$00,$10,$00,$00,$FF,$FF,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01,$40,$00,$00,$00,$10,$00,$00,$00,$40,$00,$00,$00,$10
            ds.b    4
            dc.b    $80,$00,$00,$00,$10,$00,$00,$00,$03,$00,$00,$50,$00,$00,$00,$10
            dc.b    $00,$00,$00,$50,$00,$00,$00,$10
            ds.b    4
            dc.b    $F0,$00,$00,$00,$10,$00,$00,$00,$05,$00,$00,$90,$00,$00,$00,$10
            dc.b    $00,$00,$00,$90,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$A0,$00,$00,$00,$10,$00,$00,$00,$A0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$B0,$00,$00,$00,$10,$00,$00,$00,$B0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$C0,$00,$00,$00,$10,$00,$00,$00,$C0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$D0,$00,$00,$00,$10,$00,$00,$00,$D0,$00,$00,$00,$10
            ds.b    12
            dc.b    $04,$00,$00,$F9,$00,$00,$00,$01,$00,$00,$00,$F9,$00,$00,$00,$01
            ds.b    4
            dc.b    $90,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FA,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FA,$00,$00,$00,$01
            ds.b    4
            dc.b    $A0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FB,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FB,$00,$00,$00,$01
            ds.b    4
            dc.b    $B0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FC,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FC,$00,$00,$00,$01
            ds.b    4
            dc.b    $C0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FD,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FD,$00,$00,$00,$01
            ds.b    4
            dc.b    $D0,$00,$00,$00,$10,$00,$00,$FF,$FF,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01,$40,$00,$00,$00,$10,$00,$00,$00,$40,$00,$00,$00,$10
            ds.b    4
            dc.b    $80,$00,$00,$00,$10,$00,$00,$00,$03,$00,$00,$50,$00,$00,$00,$10
            dc.b    $00,$00,$00,$50,$00,$00,$00,$10
            ds.b    4
            dc.b    $F0,$00,$00,$00,$10,$00,$00,$FF,$FF,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01,$40,$00,$00,$00,$10,$00,$00,$00,$40,$00,$00,$00,$10
            ds.b    4
            dc.b    $80,$00,$00,$00,$10,$00,$00,$00,$03,$00,$00,$50,$00,$00,$00,$10
            dc.b    $00,$00,$00,$50,$00,$00,$00,$10
            ds.b    4
            dc.b    $F0,$00,$00,$00,$10,$00,$00,$00,$05,$00,$00,$E0,$00,$00,$00,$10
            dc.b    $00,$00,$00,$E0,$00,$00,$00,$10
            ds.b    12
            dc.b    $04,$00,$00,$FE,$00,$00,$00,$01,$00,$00,$00,$FE,$00,$00,$00,$01
            ds.b    4
            dc.b    $E0,$00,$00,$00,$10,$00,$00,$FF,$FF,$00,$01,$00,$01
            ds.b    25
            dc.b    $02,$00,$01
            dc.w    $4080,0,$0010,0
            dc.w    $4080,0,$0010,0,$0080,0,$0010,0
            dc.w    $0003,0,$50F0,0,$0004,0,$50F0,0
            dc.w    $0004,0,$00F0,0,$0004,0,$0003,0
            dc.w    $50F4,0,$0004,0,$50F4,0,$0004,0
            dc.w    $00F4,0,$0004,0,$0005,0,$A000,0
            dc.b    $10,$00,$00,$00,$A0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$B0,$00,$00,$00,$10,$00,$00,$00,$B0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$C0,$00,$00,$00,$10,$00,$00,$00,$C0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$D0,$00,$00,$00,$10,$00,$00,$00,$D0,$00,$00,$00,$10
            ds.b    12
            dc.b    $05,$00,$00,$E0,$00,$00,$00,$10,$00,$00,$00,$E0,$00,$00,$00,$10
            ds.b    12
            dc.b    $08,$00,$00,$F9,$00,$00,$00,$01,$00,$00,$00,$F9,$00,$00,$00,$01
            ds.b    4
            dc.b    $90,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FA,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FA,$00,$00,$00,$01
            ds.b    4
            dc.b    $A0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FB,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FB,$00,$00,$00,$01
            ds.b    4
            dc.b    $B0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FC,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FC,$00,$00,$00,$01
            ds.b    4
            dc.b    $C0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FD,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FD,$00,$00,$00,$01
            ds.b    4
            dc.b    $D0,$00,$00,$00,$10,$00,$00,$00,$04,$00,$00,$FE,$00,$00,$00,$01
            dc.b    $00,$00,$00,$FE,$00,$00,$00,$01
            ds.b    4
            dc.b    $E0,$00,$00,$00,$10,$00,$00,$FF,$FF
.L13:
            move.w  #$66,D6
            moveq   #$F,D7
            BigJmp  Critical,A0
InitMMU:
            link.w  A5,#-$BC
            bsr.w   sub_40880E3C
            bsr.w   FindInfo
            cmpi.b  #1,(-$1A,A6)
            bne.b   .L1
            movem.l (-$18,A5),D0-D2/D7/A0-A1
            movea.l A6,A4
            unlk    A5
            rts
.L1:
            movea.l A1,A4
            movea.l A0,A2
            bsr.w   MakePhysicalTable
            movea.l A2,A0
            bsr.w   sub_40881482
            lea     (-$42,A6),A1
            bsr.w   SaveMMUInfo
            btst    #0,(-$19,A6)
            bne.b   .L2
            movea.l A4,A0
            movea.l A4,A2
            bsr.w   sub_40881482
.L2:
            lea     (-$2E,A6),A1
            bsr.w   SaveMMUInfo
            bsr.w   CleanupGlobals_MMUTables
            cmpi.w  #4,D7
            beq.b   .L8
            pflusha
            movec   CACR,D5
            ori.w   #$808,D5
            movec   D5,CACR
            pmove.l (4,A3),TT0
            pmove.l (8,A3),TT1
            lea     (-8,A3),A6
            lea     .L3,A5
            bra.b   .L4
.L3:
            lea     .L7,A5
            adda.l  D3,A5
            moveq   #0,D5
            movec   D5,VBR
            nop
.L4:
            bne.b   .L5
            pmove.d (A6),CRP
.L5:
            nop
            bne.b   .L6
            pmove.l (A3),TC
.L6:
            RTS5
.L7:
            jmp     (A2)
.L8:
            mc68040
            pflusha
            mc68030
            move.l  (4,A3),D5
            mc68040
            movec   D5,ITT0
            movec   D5,DTT0
            mc68030
            move.l  (8,A3),D5
            mc68040
            movec   D5,ITT1
            movec   D5,DTT1
            mc68030
            moveq   #0,D5
            lea     .L10,A5
            bra.b   .L11
.L10:
            lea     .L7,A5
            adda.l  D3,A5
            movec   D5,VBR
            movea.l (-4,A3),A6
            move.l  (A3),D5
            bra.b   .L11
            ds.b    10
.L11:
            beq.b   .L9
            mc68040
            movec   A6,SRP
            movec   D5,TC
            mc68030
.L9:
            RTS5
sub_40880E3C:
            movem.l D0-D2/D7/A0-A1,(-$18,A5)
            move.l  (A0),D0
            move.l  D0,(-$B8,A5)
            cmpi.w  #4,D7
            beq.b   .L1
            andi.l  #$FF000000,D0
.L1:
            move.l  D0,(-$BC,A5)
            bsr.w   GetMMUType
            move.b  D0,(-$1A,A6)
            clr.l   (-$AC,A5)
            clr.l   (-$A8,A5)
            clr.l   (-$A4,A5)
            move.l  #$70000000,(-$4A,A6)
            clr.l   (-$46,A6)
            move.l  #$FFFFFFFF,(-$98,A5)
            lea     ($FFFFFFB6).w,A0
            move.l  A0,(-$C,A6)
            move.b  #$AF,D0
            bsr.w   ReadPRAMByte_MMUTables
            andi.l  #$FF,D0
            beq.b   .L3
            moveq   #0,D3
            lea     (4,A6),A0
.L2:
            add.l   (A0)+,D3
            tst.l   (A0)+
            bpl.b   .L2
            lsr.l   #8,D3
            mulu.l  D3,D0
            addi.l  #$7FFF,D0
            andi.w  #$8000,D0
            cmpi.l  #$30000,D0
            bcs.b   .L3
            lea     (A6),A0
            lea     (-$98,A5),A1
            bsr.w   StealChunks
            move.l  D1,(-$46,A6)
.L3:
            lea     (A6),A0
            lea     (-$58,A5),A1
            bsr.w   CopyChunks
            move.l  D0,(-$A0,A5)
            move.l  D1,(-$14,A6)
            sub.l   A0,D1
            move.b  #$8A,D0
            bsr.w   ReadPRAMByte_MMUTables
            btst    #0,D0
            bne.b   .L4
            bclr    #4,D0
            bra.b   .L5
.L4:
            btst    #4,D0
            beq.b   .L5
            addi.l  #$37FF0000,D1
.L5:
            move.b  D0,(-$19,A6)
            move.l  D1,(-$18,A6)
            rts
ReadPRAMByte_MMUTables:
            movem.l D1-D6/A0-A3,-(SP)
            movea.l (-8,A5),A0
            movea.l (-4,A5),A1
            move.l  (-$14,A5),D1
            moveq   #1,D3
            swap    D3
            move.w  D0,D3
            subq.w  #2,SP
            movea.l SP,A3
            bsr.w   CLOCKPATCH
            moveq   #0,D0
            move.b  (SP)+,D0
            movem.l (SP)+,D1-D6/A0-A3
            rts
CleanupGlobals_MMUTables:
            movea.l A6,A0
            adda.l  (-$10,A6),A0
            adda.l  (-$9C,A5),A0
            move.l  (-8,A6),D0
            sub.l   (-$C,A6),D0
            sub.l   D0,(8,A0)
            move.l  (4,A0),D1
            add.l   (8,A0),D1
            lea     ($1C,A0),A0
            move.l  D1,(4,A0)
            move.l  D0,(8,A0)
            move.w  #7,(A0)
            move.l  (SP),D5
            move.l  A6,D0
            add.l   (-$18,A6),D0
            movea.l D0,A4
            add.l   (-$C,A6),D0
            btst    #4,(-$19,A6)
            beq.b   .L1
            movea.l D0,SP
            subi.l  #$37FF0000,D0
            lsr.l   #1,D0
            suba.l  D0,SP
            bra.b   .L4
.L1:
            cmpi.l  #$200000,D0
            bge.b   .L2
            lsr.l   #2,D0
            mulu.l  #3,D0
            bra.b   .L3
.L2:
            move.l  #$180000,D0
.L3:
            movea.l D0,SP
.L4:
            BigLea  BaseOfROM,A1
            move.l  (-$B8,A5),D3
            sub.l   A1,D3
            movea.l (4,A5),A2
            adda.l  D3,A2
            lea     (-$3A,A6),A3
            movem.l (-$18,A5),D0-D2/D7/A0-A1
            movea.l D5,A5
            RTS5
SaveMMUInfo:
            move.l  (A2),(8,A1)
            move.l  (4,A2),($C,A1)
            move.l  (8,A2),($10,A1)
            move.l  D0,(A1)
            move.l  A0,(4,A1)
            cmpi.w  #4,D7
            bne.b   .L1
            andi.l  #$FFFFFE00,(4,A1)
.L1:
            rts
MMUTypes:
            dc.w    0,$0104,$0500
GetMMUType:
            cmpi.w  #4,D7
            bhi.w   MMUSTUFF_2.L13
            moveq   #0,D0
            move.b  MMUTypes(PC,D7.w),D0
            cmpi.b  #1,D0
            bne.b   .L3
            movea.l (-8,A5),A0
            cmpi.b  #7,(-4,A0)
            beq.b   .L3
            move.l  ($2C,A0),D1
            movea.l D1,A0
            bfclr   D1{0:8}
            movea.l D1,A1
            move.b  ($400,A1),D2
            move.b  ($400,A0),D1
            addq.b  #1,D1
            move.b  D1,($400,A1)
            subq.b  #1,D1
            andi.b  #$F7,(A0)
            cmp.b   ($400,A1),D1
            beq.b   .L1
            moveq   #3,D0
            bra.b   .L2
.L1:
            ori.b   #8,(A0)
.L2:
            move.b  D2,($400,A1)
.L3:
            rts
CopyChunks:
            movem.l D2-D5,-(SP)
            moveq   #0,D1
            moveq   #-1,D0
            moveq   #-1,D5
            bra.b   .L3
.L1:
            cmp.l   D0,D3
            bcc.b   .L2
            move.l  D3,D0
.L2:
            add.l   D3,D1
            move.l  D2,D4
            add.l   D3,D4
.L3:
            move.l  (A0)+,D2
            move.l  (A0)+,D3
            move.l  D2,(A1)+
            move.l  D3,(A1)+
            bne.b   .L4
            subq.w  #8,A1
.L4:
            cmp.l   D5,D2
            bne.b   .L1
            movea.l D4,A0
            movem.l (SP)+,D2-D5
            rts
StealChunks:
            movem.l D2-D5/A4,-(SP)
            movea.l A0,A2
            movea.l A1,A3
            move.l  D0,D2
            moveq   #0,D3
.L1:
            cmpi.l  #$FFFFFFFF,(A2)+
            beq.b   .L2
            add.l   (A2)+,D3
            bra.b   .L1
.L2:
            subi.l  #$1C0000,D3
            ble.w   .L7
            cmp.l   D3,D2
            bhi.w   .L7
            addi.l  #$40000,D2
            subq.l  #4,A2
            cmpi.l  #$40000,(-4,A2)
            beq.b   .L3
            move.l  (-4,A2),D4
            subi.l  #$40000,D4
            move.l  D4,(-4,A2)
            add.l   (-8,A2),D4
            move.l  D4,(A2)
            move.l  #$40000,(4,A2)
            move.l  #$FFFFFFFF,(8,A2)
            addq.l  #8,A2
            movea.l A2,A4
.L3:
            sub.l   -(A2),D2
            subq.l  #4,A2
            bgt.b   .L3
            movea.l A2,A0
            bsr.w   CopyChunks
            add.l   D2,D1
            neg.l   D2
            move.l  D2,(4,A2)
            sub.l   D2,(4,A3)
            add.l   D2,(A3)
            move.l  (-8,A4),(8,A2)
            move.l  (-4,A4),($C,A2)
            move.l  #$FFFFFFFF,($10,A2)
.L4:
            cmpi.l  #$FFFFFFFF,(A3)+
            beq.b   .L5
            addq.l  #4,A3
            bra.b   .L4
.L5:
            move.l  #$FFFFFFFF,(-$C,A3)
            subi.l  #$40000,D1
.L6:
            movem.l (SP)+,D2-D5/A4
            rts
.L7:
            moveq   #0,D1
            bra.b   .L6
FindInfo:
            movem.l D2-D6/A2,-(SP)
            movem.l (-$58,A5),D2-D5
            movea.l (-8,A5),A1
            move.l  (-$18,A5),D6
            moveq   #0,D0
            move.b  (-$D,A5),D0
            move.w  .L1(PC,D0.w*2),D0
            jmp     .L1(PC,D0.w)
.L1:
            dc.w    .L2-.L1
            dc.w    .L2-.L1
            dc.w    .L2-.L1
            dc.w    .L2-.L1
            dc.w    .L3-.L1
            dc.w    .L9-.L1
            dc.w    .L8-.L1
            dc.w    .L17-.L1
            dc.w    .L5-.L1
            dc.w    .L6-.L1
            dc.w    .L7-.L1
.L2:
            bra.w   MMUSTUFF_2.L13
            moveq   #2,D0
            moveq   #2,D0
            bra.w   .L19
.L3:
            lea     MMUSTUFF_2.L1,A0
            lea     TOP512KOFROM,A1
            tst.l   D2
            bne.b   .L4
            addq.l  #1,D4
            beq.w   .L19
.L4:
            cmpi.b  #1,(-$1A,A6)
            bne.w   .L18
            bra.w   MMUSTUFF_2.L13
.L5:
            lea     MMUSTUFF_2.L8,A0
            lea     MMUSTUFF_2.L7,A1
            bra.w   .L19
.L6:
            movea.l (-4,A5),A0
            movea.l A0,A1
            adda.l  (8,A0),A1
            move.l  (A1),(-$A4,A5)
            move.l  (4,A1),(-$B4,A5)
            move.l  (8,A1),(-$B0,A5)
            move.l  #$8000,(-$A8,A5)
            lea     MMUSTUFF_2.L10,A0
            lea     MMUSTUFF_2.L9,A1
            bra.w   .L19
.L7:
            movea.l (-4,A5),A0
            movea.l A0,A1
            adda.l  (8,A0),A1
            move.l  (A1),(-$A4,A5)
            move.l  (4,A1),(-$B4,A5)
            move.l  (8,A1),(-$B0,A5)
            move.l  #$8000,(-$A8,A5)
            lea     MMUSTUFF_2.L12,A0
            lea     MMUSTUFF_2.L11,A1
            bra.w   .L19
.L8:
            lea     MMUSTUFF_2.L1,A0
            lea     TOP512KOFROM,A1
            tst.l   D2
            bne.w   .L18
            bra.w   .L19
.L9:
            btst    #$D,D6
            beq.w   .L18
            movea.l (-4,A5),A0
            movea.l A0,A1
            adda.l  (8,A0),A1
            move.l  (A1),(-$A4,A5)
            move.l  (4,A1),(-$B4,A5)
            move.l  (8,A1),(-$B0,A5)
            cmpi.l  #$FBB08000,(-$B4,A5)
            adda.l  (A0),A0
            bne.b   .L10
            lea     MMUSTUFF_2.L4,A3
            bra.b   .L11
.L10:
            lea     MMUSTUFF_2.L6,A3
.L11:
            bfextu  (A3){8:4},D0
            moveq   #0,D6
            bset    D0,D6
            move.l  (-$14,A6),D0
            moveq   #0,D1
            movea.l ($34,A0),A0
            movea.l (-4,A5),A2
            bsr.w   sub_40881988
            move.l  D0,(-$A8,A5)
            move.l  (-$14,A6),D0
            move.l  D6,D1
            BigJsr  sub_40881988,A4
            move.l  D0,(-$AC,A5)
            beq.w   .L18
            tst.l   D2
            bne.w   .L18
            sub.l   D0,D3
            move.l  D3,(-$54,A5)
            add.l   D0,D2
            move.l  D2,(-$58,A5)
            sub.l   D0,(-$18,A6)
            movea.l A3,A0
            lea     (-$50,A5),A1
            tst.l   (-$46,A6)
            beq.b   .L12
            addq.l  #8,A1
.L12:
            tst.l   (A1)
            bmi.b   .L14
            tst.l   (-$46,A6)
            bne.b   .L13
            sub.l   D1,D5
.L13:
            lea     (-$58,A5),A1
            move.l  D4,(A1)+
            move.l  D5,(A1)+
            move.l  D2,(A1)+
            move.l  D3,(A1)+
            tst.l   (-$46,A6)
            bne.b   .L14
            add.l   D5,D4
            move.l  D4,(A1)+
            move.l  D1,(A1)+
            moveq   #-1,D4
            move.l  D4,(A1)+
            move.l  D4,(A1)+
.L14:
            move.l  #$B08000,D2
            move.l  (-$B0,A5),D3
            andi.l  #$FFFFFF,D2
            andi.l  #$FFFFFF,D3
            cmp.l   D3,D2
            bne.b   .L15
            lea     MMUSTUFF_2.L3,A1
            bra.b   .L16
.L15:
            lea     MMUSTUFF_2.L5,A1
.L16:
            bra.b   .L19
.L17:
            movea.l (-4,A5),A2
            movea.l ($34,A1),A3
            bsr.w   GetVISASize
            tst.l   D2
            bne.w   MMUSTUFF_2.L13
            addq.l  #1,D4
            beq.w   .L19
            bra.w   MMUSTUFF_2.L13
.L18:
            move.l  (-$A0,A5),D0
            bfffo   D0{0:0},D0
            subq.w  #5,D0
            muls.w  #$FFEE,D0
            lea     ($408800A2.w,PC,D0.w),A0
            lea     MMUSTUFF_2.L2,A1
.L19:
            movem.l (SP)+,D2-D6/A2
            rts
MakePhysicalTable:
            movem.l A1-A2,-(SP)
            suba.w  #$32E,SP
            movea.l SP,A2
            movea.l A2,A1
            adda.w  ($10,A0),A0
.L1:
            move.w  (A0),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L5
            cmpi.w  #1,D0
            bne.b   .L2
            bsr.w   doPhysRam
            lea     ($1C,A0),A0
            bra.b   .L1
.L2:
            cmpi.w  #2,D0
            bne.b   .L3
            bsr.w   sub_4088144E
            lea     ($1C,A0),A0
            bra.b   .L1
.L3:
            moveq   #$1B,D0
.L4:
            move.b  (A0)+,(A1)+
            dbra    D0,.L4
            bra.b   .L1
.L5:
            suba.l  A2,A1
            move.l  A1,D1
            addq.l  #4,A1
            movea.l A6,A0
            move.l  (-$C,A6),D0
            sub.l   A1,D0
            move.l  D0,(-$10,A6)
            move.l  D0,(-$C,A6)
            adda.l  D0,A0
            move.l  D1,D0
            divu.w  #$1C,D0
            move.w  D0,(A0)+
            move.w  #$1C,(A0)+
            bra.b   .L7
.L6:
            move.b  (A2)+,(A0)+
.L7:
            dbra    D1,.L6
            lea     ($32E,SP),SP
            movem.l (SP)+,A1-A2
            rts
doPhysRam:
            movem.l D2-D4/A3-A4,-(SP)
            move.l  (-$A8,A5),D0
            beq.b   .L1
            move.l  (-$A4,A5),D4
            moveq   #8,D1
            move.l  (-$B4,A5),D2
            move.l  (-$B0,A5),D3
            bsr.w   sub_40881436
            add.l   D0,D2
            add.l   D0,D3
            move.l  #$8000,D0
            moveq   #9,D1
            bsr.b   sub_40881436
            move.l  (-$B4,A5),D2
            sub.l   D0,D2
            move.l  (-$B0,A5),D3
            sub.l   D0,D3
            bsr.b   sub_40881436
.L1:
            tst.l   (-$46,A6)
            beq.b   .L3
            moveq   #$A,D1
            move.l  (-$4A,A6),D2
            moveq   #0,D3
            lea     (-$98,A5),A3
.L2:
            move.l  (A3)+,D4
            move.l  (A3)+,D0
            cmpi.l  #$FFFFFFFF,D4
            beq.b   .L3
            bsr.w   sub_40881436
            add.l   D0,D2
            bra.b   .L2
.L3:
            moveq   #6,D0
            lea     (-$58,A5),A3
.L4:
            movem.l (A3)+,D1-D2
            cmpi.l  #$FFFFFFFF,D1
            beq.b   .L5
            movea.l A1,A4
            move.w  D0,(A1)+
            move.w  #1,(A1)+
            move.l  D1,(A1)+
            move.l  D2,(A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            moveq   #1,D0
            bra.b   .L4
.L5:
            move.l  A4,D0
            sub.l   A2,D0
            addq.l  #4,D0
            move.l  D0,(-$9C,A5)
            moveq   #$1B,D0
.L6:
            move.b  (A4)+,(A1)+
            dbra    D0,.L6
            movem.l (SP)+,D2-D4/A3-A4
            rts
sub_40881436:
            move.w  D1,(A1)+
            clr.w   (A1)+
            move.l  D4,(A1)+
            move.l  D0,(A1)+
            move.l  D2,(A1)+
            move.l  D0,(A1)+
            move.l  D3,(A1)
            andi.l  #$FFFFFF,(A1)+
            move.l  D0,(A1)+
            rts
sub_4088144E:
            exg     D1,A3
            move.w  #2,(A1)+
            move.w  #1,(A1)+
            BigLea  BaseOfROM,A3
            move.l  A3,(A1)+
            move.l  ($40,A3),D0
            move.l  D0,(A1)+
            exg     D1,A3
            move.l  (-$B8,A5),D1
            move.l  D1,(A1)+
            move.l  D0,(A1)+
            andi.l  #$FFFFFF,D1
            move.l  D1,(A1)+
            move.l  D0,(A1)+
            exg     D1,A3
            rts
sub_40881482:
            link.l  A4,#-$3009E
            movem.l D2/A1,-(SP)
            move.l  A0,(-4,A4)
            move.w  ($C,A0),D0
            btst    #4,(-$19,A6)
            beq.b   .L1
            move.w  ($E,A0),D0
.L1:
            adda.w  D0,A0
            move.l  A0,(-8,A4)
            lea     (-$58,A5),A0
            lea     (-$50,A4),A1
            bsr.w   CopyChunks
            lea     (-$98,A5),A0
            lea     (-$90,A4),A1
            bsr.w   CopyChunks
            move.l  (-$A4,A5),(-$94,A4)
            move.l  (-$AC,A5),(-$98,A4)
            bsr.b   IntermediateTable
            bsr.w   FinalTable
            movem.l (SP)+,D2/A1
            unlk    A4
            rts
IntermediateTable:
            move.l  D2,-(SP)
            lea     (-$9E,A4),A0
            move.l  A0,(-$10,A4)
            clr.l   (-$C,A4)
            clr.w   (-$9A,A4)
            moveq   #1,D0
            bsr.b   sub_408814F8
            moveq   #0,D2
            bsr.w   WriteTableNode
            move.l  (SP)+,D2
            rts
sub_408814F8:
            movem.l D2-D4,-(SP)
            move.w  D0,D2
            bsr.w   sub_40881792
            move.l  D0,D3
            move.l  D1,D4
            bra.b   .L2
.L1:
            bsr.b   sub_40881514
.L2:
            dbra    D4,.L1
            movem.l (SP)+,D2-D4
            rts
sub_40881514:
            bsr.b   sub_40881546
            move.b  .L1(PC,D0.w),D0
            jmp     .L1(PC,D0.w)
.L1:
            dc.w    $040A,$1026,$6100,$01AE,$601C,$6100,$01C4,$6016
            dc.w    $6100,$017A,$670C,$3002,$5240,$61BE,$6100,$01BA
            dc.w    $6004,$6100,$01AC,$4E75
sub_40881546:
            movem.l D3-D5,-(SP)
            movea.l (-8,A4),A0
            moveq   #0,D5
            move.l  (-$C,A4),D0
.L1:
            move.l  (A0),D1
            move.l  D0,D4
            sub.l   D5,D4
            cmp.l   D4,D1
            bhi.b   .L2
            add.l   D1,D5
            addq.l  #8,A0
            bra.b   .L1
.L2:
            move.l  D3,D0
            add.l   D4,D3
            cmp.l   D3,D1
            bcc.b   .L3
            moveq   #2,D0
            bra.w   .L5
.L3:
            move.l  (4,A0),D3
            move.l  D3,D5
            andi.l  #$F,D5
            move.b  .L4(PC,D5.w),D5
            jmp     .L4(PC,D5.w)
.L4:
            dc.w    $0C12,$2026,$2E34,$461C,$163A,$4000,$206C,$FFF4
            dc.b    '`@al`>9|'
            dc.w    $0001,$FF66,$7001,$6034,$206D,$FF44,$6004,$206D
            dc.w    $FF48,$D1C4,$6024,$206D,$FF5C,$601E,$6100,$0084
            dc.w    $601A,$206D,$FF5C,$6012,$6100,$00A8,$600E,$2003
            dc.w    $0280,$FFFF,0,$2040,$D1C4,$7000,$0C47,$0004
            dc.w    $6708,$0283,0,$0020,$6014,$0283,0,$0030
            dc.w    $0C42,$0003,$6708,$0C40,0,$6602,$7002,$E38B
            dc.w    $3203
.L5:
            movem.l (SP)+,D3-D5
            rts
GrabRAM:
            lea     (-$50,A4),A0
            move.l  D0,D1
            moveq   #1,D0
.loop:
            cmpi.l  #$FFFFFFFF,(A0)+
            beq.b   .done
            tst.l   (A0)+
            beq.b   .loop
            moveq   #2,D0
            cmp.l   (-4,A0),D1
            bhi.b   .done
            cmpi.w  #4,D7
            bne.b   .term
            cmpi.w  #3,D2
            bne.b   .valid
.term:
            move.l  (-8,A0),D0
            add.l   D1,(-8,A0)
            sub.l   D1,(-4,A0)
            movea.l D0,A0
.valid:
            moveq   #0,D0
.done:
            rts
            move.l  D0,D1
            movea.l (-$A4,A5),A0
            tst.l   (-$98,A4)
            beq.b   .L4
            moveq   #2,D0
            cmp.l   (-$98,A4),D1
            bhi.b   .L5
            cmpi.w  #4,D7
            bne.b   .L3
            cmpi.w  #3,D2
            bne.b   .L4
.L3:
            movea.l (-$94,A4),A0
            add.l   D1,(-$94,A4)
            sub.l   D1,(-$98,A4)
.L4:
            moveq   #0,D0
.L5:
            rts
GrabEdisk:
            lea     (-$90,A4),A0
            move.l  D0,D1
            moveq   #1,D0
.L1:
            cmpi.l  #$FFFFFFFF,(A0)+
            beq.b   .L4
            tst.l   (A0)+
            beq.b   .L1
            moveq   #2,D0
            cmp.l   (-4,A0),D1
            bhi.b   .L4
            cmpi.w  #4,D7
            bne.b   .L2
            cmpi.w  #3,D2
            bne.b   .L3
.L2:
            move.l  (-8,A0),D0
            add.l   D1,(-8,A0)
            sub.l   D1,(-4,A0)
            movea.l D0,A0
.L3:
            moveq   #0,D0
.L4:
            rts
            cmpi.w  #4,D7
            bne.b   .L5
            cmpi.w  #3,D2
            bra.b   .L6
.L5:
            cmpi.w  #4,D2
            beq.b   .L6
            moveq   #0,D0
            move.w  D2,D0
            addq.w  #1,D0
            lsl.w   #2,D0
            addi.w  #$C,D0
            movea.l (-4,A4),A0
            bfextu  (A0){D0:4},D0
.L6:
            rts
            moveq   #0,D0
            move.w  D2,D0
            lsl.w   #3,D0
            or.w    D1,D0
            add.l   A0,D0
            addq.w  #1,D0
.L7:
            add.l   D3,(-$C,A4)
.L8:
            movea.l (-$10,A4),A0
            move.l  D0,-(A0)
            move.l  A0,(-$10,A4)
            rts
            moveq   #0,D0
            move.w  D2,D0
            lsl.w   #3,D0
            bra.b   .L7
WriteTableNode:
            cmpi.w  #4,D7
            bne.b   .L1
            movea.l #$7FFF0000,A0
            bra.b   .L2
.L1:
            bsr.b   Limit
.L2:
            moveq   #0,D0
            move.w  D2,D0
            lsl.w   #3,D0
            tst.w   A0
            bne.b   .L3
            addq.w  #2,D0
            add.l   A0,D0
            ori.w   #$FC00,D0
.L3:
            bra.b   GrabEdisk.L8
Limit:
            move.l  D3,-(SP)
            bsr.b   sub_40881742
            move.w  D0,D3
            bsr.b   CountTrailing
            move.w  D0,D1
            or.w    D3,D0
            bne.b   .L1
            movea.l #$7FFF0000,A0
            bra.b   .L3
.L1:
            cmp.w   D1,D3
            bhi.b   .L2
            move.w  D1,D0
            bsr.b   HandleTrailing
            bra.b   .L3
.L2:
            move.w  D3,D0
            bsr.b   sub_40881746
.L3:
            move.l  (SP)+,D3
            rts
sub_40881742:
            moveq   #0,D0
            rts
sub_40881746:
            movea.l #$7FFF0000,A0
            rts
CountTrailing:
            moveq   #0,D0
            movea.l (-$10,A4),A0
.L1:
            move.l  (A0)+,D1
            bfextu  D1{30:2},D1
            bne.b   .L2
            addq.w  #1,D0
            cmpa.l  (-$9E,A4),A0
            bne.b   .L1
.L2:
            rts
HandleTrailing:
            move.l  D2,-(SP)
            exg     D2,D0
            addq.w  #1,D0
            bsr.b   sub_40881792
            cmp.w   D2,D1
            blt.b   .L1
            sub.w   D2,D1
            subq.w  #1,D1
            swap    D1
            clr.w   D1
            movea.l D1,A0
            moveq   #0,D0
            move.w  D2,D0
            bra.b   .L2
.L1:
            move.l  D1,D0
            movea.w #1,A0
.L2:
            lsl.l   #2,D0
            add.l   D0,(-$10,A4)
            move.l  (SP)+,D2
            rts
sub_40881792:
            movem.l D2-D3,-(SP)
            movea.l (-4,A4),A0
            cmpi.w  #4,D7
            bne.b   .L2
            moveq   #0,D2
            moveq   #0,D3
            subq.w  #1,D0
            move.b  ($408817E4.w,PC,D0.w*2),D2
            move.b  ($408817E5.w,PC,D0.w*2),D3
            moveq   #$E,D0
            btst    D0,(A0)
            beq.b   .L1
            subq.w  #1,D2
            addq.w  #1,D3
.L1:
            bra.b   .L4
.L2:
            moveq   #$20,D2
            bfextu  (A0){12:4},D1
            sub.l   D1,D2
            moveq   #$10,D1
            subq.w  #1,D0
.L3:
            bfextu  (A0){D1:4},D3
            sub.l   D3,D2
            addq.w  #4,D1
            dbra    D0,.L3
.L4:
            moveq   #0,D0
            bset    D2,D0
            moveq   #0,D1
            bset    D3,D1
            movem.l (SP)+,D2-D3
            rts
            move.b  D7,-(A4)
            move.b  D7,D1
            btst    D6,D5
FinalTable:
            lea     (-$9E,A4),A0
            move.l  A0,(-$10,A4)
            moveq   #1,D0
            bsr.b   sub_4088181E
            tst.w   (-$9A,A4)
            beq.b   .L1
            bsr.w   sub_4088192C
.L1:
            move.l  ([-$10.w,A4],-4.w),D1
            add.w   D0,D1
            andi.w  #3,D1
            cmpi.b  #3,(-$1A,A6)
            bne.b   .L2
            bset    #9,D1
.L2:
            move.l  D1,D0
            rts
sub_4088181E:
            movem.l D2-D4/A1-A2,-(SP)
            move.l  D0,D4
            bsr.b   sub_40881864
            move.w  D0,D3
            move.w  D1,D2
            bsr.b   AllocTbl
            movea.l A0,A1
            movea.l A0,A2
            bra.b   .L3
.L1:
            move.l  ([-$10.w,A4],-4.w),D0
            bfextu  D0{27:2},D1
            cmp.w   D1,D4
            bcc.b   .L2
            move.w  D4,D0
            addq.w  #1,D0
            bsr.b   sub_4088181E
            bsr.w   MakeTableEntry
            bra.b   .L3
.L2:
            bne.b   .L4
            bsr.w   sub_40881902
.L3:
            dbra    D3,.L1
            movea.l A2,A0
            move.w  D2,D0
            movem.l (SP)+,D2-D4/A1-A2
            rts
.L4:
            _Debugger
sub_40881864:
            movem.l D2-D4,-(SP)
            move.w  D0,D2
            movea.l (-$10,A4),A0
            moveq   #0,D1
            moveq   #0,D0
.L1:
            move.l  -(A0),D3
            bfextu  D3{27:2},D4
            cmp.w   D4,D2
            bhi.b   .L2
            bne.b   .L1
            addq.w  #1,D0
            bfextu  D3{30:2},D4
            cmpi.w  #2,D4
            bne.b   .L1
            swap    D3
            cmpi.w  #$7FFF,D3
            beq.b   .L1
            moveq   #1,D1
            bra.b   .L1
.L2:
            movem.l (SP)+,D2-D4
            rts
AllocTbl:
            andi.l  #$FFFF,D0
            addq.w  #2,D1
            ext.l   D1
            lsl.l   D1,D0
            move.l  A6,D1
            add.l   (-$C,A6),D1
            sub.l   D0,D1
            cmpi.w  #4,D7
            bne.b   .L1
            lea     .L3,A0
            and.w   (0,A0,D4.w*2),D1
            bra.b   .L2
.L1:
            andi.b  #$F0,D1
.L2:
            movea.l D1,A0
            sub.l   A6,D1
            move.l  D1,(-$C,A6)
            rts
.L3:
            dc.w    0,$FE00,$FE00,$FF00
MakeTableEntry:
            subq.l  #4,(-$10,A4)
            move.l  ([-$10.w,A4]),D1
            add.w   D0,D1
            bfextu  D1{30:2},D0
            tst.w   D2
            bne.b   .L1
            add.l   A0,D0
            bset    #3,D0
            move.l  D0,(A1)+
            bra.b   .L2
.L1:
            bfclr   D1{24:6}
            bset    #3,D1
            move.l  D1,(A1)+
            move.l  A0,(A1)+
.L2:
            rts
sub_40881902:
            subq.l  #4,(-$10,A4)
            move.l  ([-$10.w,A4]),D0
            bfextu  D0{25:7},D1
            andi.w  #$FF00,D0
            bfset   D1{27:2}
            tst.w   D2
            bne.b   .L1
            add.l   D0,D1
            move.l  D1,(A1)+
            bra.b   .L2
.L1:
            bfset   D1{1:21}
            move.l  D1,(A1)+
            move.l  D0,(A1)+
.L2:
            rts
sub_4088192C:
            movem.l D2/A1-A2,-(SP)
            movea.l A0,A2
            move.w  #2,D0
            bsr.w   sub_40881792
            mulu.l  D1,D0
            moveq   #$18,D2
            lsr.l   D2,D0
            andi.l  #$FFFF,D1
            divu.w  D0,D1
            move.l  (A2),D2
            andi.l  #$FFFFFFF0,D2
            movea.l D2,A1
            subq.l  #2,D0
            movea.l A1,A0
            lsl.l   #2,D1
.L1:
            adda.l  D1,A0
            moveq   #0,D2
.L2:
            move.l  (0,A1,D2.w),(0,A0,D2.w)
            addq.l  #4,D2
            cmp.l   D2,D1
            bne.b   .L2
            dbra    D0,.L1
            moveq   #1,D0
            bsr.w   sub_40881792
            movea.l A2,A1
            addq.l  #4,A1
            subq.w  #2,D1
.L3:
            move.l  (A2),(A1)+
            dbra    D1,.L3
            movea.l A2,A0
            movem.l (SP)+,D2/A1-A2
            rts
sub_40881988:
            bra.b   TRANS.L1
TRANS:
            dc.w    0,$0040,$0020
            ds.b    5
            dc.b    $40,$00,$30,$00,$00,$00,$02,$AC,$00,$00,$00,$55,$80,$00,$01,$56
            dc.b    $00,$00,$00,$A6,$00,$00,$03
            ds.b    4
            dc.w    $6000,$0001,$8000,0,$C000,$0004,$B000,0
            dc.w    $9600,$0002,$5800,$0001,$2C00,$0004,$3F80,$0001
            dc.w    $0FE0,$0002,$1FC0
.L1:
            movem.l D1-D4/A0,-(SP)
            move.l  D1,-(SP)
            moveq   #$38,D4
            and.b   ($10,A0),D4
            lsr.b   #3,D4
            moveq   #0,D3
            cmpi.l  #$180000,D0
            bge.b   .L2
            bset    #3,D3
.L2:
            movea.l A2,A0
            adda.l  (8,A2),A0
            moveq   #0,D2
            move.b  ($D,A0),D2
            move.w  D2,D0
            addq.w  #4,D0
            bsr.w   ReadPRAMByte_MMUTables
            eor.b   D3,D0
            btst    #3,D0
            bne.b   .L3
            move.w  D2,D0
            addq.w  #3,D0
            bsr.w   ReadPRAMByte_MMUTables
            bclr    #7,D0
            move.w  D0,D3
            andi.l  #7,D0
            moveq   #0,D1
            move.w  (TRANS.w,PC,D4.w*2),D1
            beq.b   .L6
            cmp.b   D0,D4
            beq.b   .L5
.L3:
            btst    #3,D3
            beq.b   .L4
            bclr    #4,D3
.L4:
            or.b    D4,D3
.L5:
            lea     TRANS,A0
            moveq   #0,D1
            move.w  (TRANS.w,PC,D4.w*2),D1
            beq.b   .L6
            adda.l  D1,A0
            lsr.w   #3,D3
            move.l  (0,A0,D3.w*4),D1
            move.l  (SP),D0
            beq.b   .L6
            move.l  D1,D2
            divul.l D0,D3:D2
            tst.l   D3
            beq.b   .L6
            sub.l   D3,D0
            add.l   D0,D1
.L6:
            move.l  D1,D0
            move.l  (SP)+,D1
            movem.l (SP)+,D1-D4/A0
            rts
GetVISASize:
            movem.l D0/D2/D4/A0/A2-A3,-(SP)
            move.b  ($10,A3),D4
            lsr.b   #3,D4
            andi.b  #7,D4
            cmpi.b  #7,D4
            beq.b   .L6
            cmpi.b  #2,D4
            bne.b   .L1
            lea     .L7,A1
            bra.b   .L2
.L1:
            lea     .L8,A1
.L2:
            adda.l  (8,A2),A2
            moveq   #0,D2
            move.b  ($D,A2),D2
            addq.w  #4,D2
            move.w  D2,D0
            bsr.w   ReadPRAMByte_MMUTables
            cmp.b   D4,D0
            bne.b   .L4
            move.w  D2,D0
            subq.w  #1,D0
            bsr.w   ReadPRAMByte_MMUTables
            cmpi.w  #$A8,D0
            bne.b   .L3
            move.b  #$A2,D0
.L3:
            lsr.b   #3,D0
            andi.b  #3,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
            cmpi.b  #2,D4
            bne.b   .L5
            cmpi.l  #$100000,(-$14,A6)
            bgt.b   .L5
            addq.w  #1,D0
.L5:
            move.l  (0,A1,D0.w*4),D0
            move.l  (-$14,A6),D2
            sub.l   D0,D2
            sub.l   A6,D2
            move.l  D2,(-$C,A6)
.L6:
            movem.l (SP)+,D0/D2/D4/A0/A2-A3
            rts
.L7:
            dc.w    $0001,$B400,0,$7000,$0003,$B400,$0002,$7000
.L8:
            dc.b    $00,$00,$B0
            ds.b    6
            dc.b    $02,$B0
            ds.b    9465
CLOCKPATCH:
PRAMIO:
            movem.l D0-D2/A1-A2,-(SP)
            andi.b  #$70,D1
            cmpi.b  #$20,D1
            bne.b   .L2
            movea.l (8,A0),A1
            bclr    #$1F,D3
            beq.b   .L1
            bsr.w   sub_408840CE
            bra.b   .L5
.L1:
            bsr.b   sub_40884082
            bra.b   .L5
.L2:
            movea.l (8,A0),A1
            move.l  D3,D0
            swap    D0
            subq.w  #1,D0
            bclr    #$F,D0
            beq.b   .L4
            moveq   #$35,D1
            moveq   #$55,D2
            bsr.w   CLKNOMEMPATCH
.L3:
            move.w  D3,D1
            rol.w   #3,D1
            ror.b   #1,D1
            ror.w   #8,D1
            andi.w  #$7C07,D1
            ori.b   #$38,D1
            move.b  (A3)+,D2
            bsr.w   CLKNOMEMPATCH
            addq.w  #1,D3
            dbra    D0,.L3
            moveq   #$35,D1
            moveq   #-$2B,D2
            bsr.w   CLKNOMEMPATCH
            bra.b   .L5
.L4:
            move.w  D3,D1
            rol.w   #3,D1
            ror.b   #1,D1
            ror.w   #8,D1
            andi.w  #$7C07,D1
            ori.b   #$B8,D1
            bsr.w   CLKNOMEMPATCH
            move.b  D2,(A3)+
            addq.w  #1,D3
            dbra    D0,.L4
.L5:
            movem.l (SP)+,D0-D2/A1-A2
            rts
sub_40884082:
            bsr.w   sub_40884112
            bset    #5,(A1)
            moveq   #1,D4
            bsr.w   sub_4088411C
            moveq   #7,D4
            bsr.w   sub_4088411C
            moveq   #0,D4
            bsr.w   sub_4088411C
            move.w  D3,D4
            bsr.w   sub_4088411C
            bclr    #5,(A1)
            bsr.w   sub_4088417A
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            swap    D3
            subq.w  #1,D3
            bra.b   .L2
.L1:
            bsr.w   sub_4088413E
            move.b  D4,(A3)+
.L2:
            dbra    D3,.L1
            bsr.w   sub_40884156
            move.b  D4,(A3)+
            rts
sub_408840CE:
            bsr.w   sub_40884112
            bset    #5,(A1)
            moveq   #1,D4
            bsr.w   sub_4088411C
            moveq   #8,D4
            bsr.w   sub_4088411C
            moveq   #1,D4
            bsr.w   sub_4088411C
            move.w  D3,D4
            bsr.w   sub_4088411C
            swap    D3
            subq.w  #1,D3
.L1:
            move.b  (A3)+,D4
            bsr.w   sub_4088411C
            dbra    D3,.L1
            bclr    #5,(A1)
            bsr.w   sub_4088417A
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            bsr.w   sub_40884156
            rts
sub_40884112:
            moveq   #$50,D5
.L1:
            tst.b   (A1)
            dbra    D5,.L1
            rts
sub_4088411C:
            bset    #4,($1600,A1)
            move.b  D4,($1400,A1)
            bset    #4,(A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bclr    #4,(A1)
            bsr.b   sub_40884112
            rts
sub_4088413E:
            btst    #2,($1A00,A1)
            beq.b   sub_4088413E
            move.b  ($1400,A1),D4
            bset    #4,(A1)
            bsr.b   sub_40884112
            bclr    #4,(A1)
            rts
sub_40884156:
            btst    #2,($1A00,A1)
            beq.b   sub_40884156
            move.b  ($1400,A1),D4
            bset    #4,(A1)
            bsr.b   sub_40884112
            bclr    #5,(A1)
.L1:
            btst    #3,(A1)
            beq.b   .L1
            bclr    #4,(A1)
            bsr.b   sub_40884112
            rts
sub_4088417A:
            bclr    #4,($1600,A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bsr.b   sub_40884112
            bsr.b   sub_40884112
            bset    #5,(A1)
            rts
            moveq   #$35,D1
            moveq   #-$2B,D2
            bsr.b   sub_408841A6
            rts
            moveq   #$35,D1
            moveq   #$55,D2
            bsr.b   sub_408841A6
            rts
sub_408841A6:
            movem.l A0-A1,-(SP)
            movea.l VIA,A1
            movea.l ($54C).w,A0
            jsr     (A0)
            movem.l (SP)+,A0-A1
            rts
CLKNOMEMPATCH:
            movem.l D1/D3-D4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #-7,D3
            and.b   (A1),D3
            moveq   #$78,D4
            and.w   D1,D4
            cmpi.w  #$38,D4
            bne.b   .L1
            move.w  D1,D4
            swap    D1
            move.w  D4,D1
            bsr.b   sub_408841FC
            lsr.l   #8,D1
            tst.w   D1
            bra.b   .L2
.L1:
            tst.b   D1
.L2:
            bmi.b   .L3
            bsr.b   sub_408841FC
            move.w  D2,D1
            bsr.b   sub_408841FC
            bra.b   .L4
.L3:
            bsr.b   sub_408841FC
            bsr.b   sub_40884210
.L4:
            bset    #2,(A1)
            move    (SP)+,SR
            movem.l (SP)+,D1/D3-D4
            rts
sub_408841FC:
            moveq   #7,D4
.L1:
            ror.b   #1,D3
            roxl.b  #1,D1
            roxl.b  #1,D3
            move.b  D3,(A1)
            bset    #1,(A1)
            dbra    D4,.L1
            rts
sub_40884210:
            moveq   #7,D4
            bclr    #0,($400,A1)
.L1:
            move.b  D3,(A1)
            bset    #1,(A1)
            move.b  (A1),D1
            lsr.b   #1,D1
            roxl.b  #1,D2
            dbra    D4,.L1
            bset    #0,($400,A1)
            rts
            ds.b    464
BLOCKMOVEPATCH:
BlockMove68040:
            moveq   #-$C,D1
            add.l   D0,D1
            bgt.b   .L1
            bra.l   BMVERYSHORT
.L1:
            move.l  D0,-(SP)
            move.l  A1,-(SP)
            BigLea  FLUSHCRANGEFORBM,A1
            move.l  A1,-(SP)
            movea.l (4,SP),A1
            bra.b   .L2
            move.l  ($6F4).w,-(SP)
.L2:
            move.l  A1,D1
            moveq   #-4,D2
            or.l    D1,D2
            sub.l   A0,D1
            and.l   Lo3Bytes,D1
            cmp.l   D0,D1
            bcs.b   .L4
            cmpi.l  #$2F,D0
            bcs.b   .L3
            andi.b  #$F,D1
            beq.b   .L5
.L3:
            bra.l   BMMOVELONGS
.L4:
            bra.l   BMOVERLAP
.L5:
            move.l  A1,D1
            neg.l   D1
            moveq   #$F,D2
            and.l   D1,D2
            beq.b   .L9
            sub.l   D2,D0
            lsr.l   #1,D2
            bcc.b   .L6
            move.b  (A0)+,(A1)+
.L6:
            lsr.l   #1,D2
            bcc.b   .L7
            move.w  (A0)+,(A1)+
.L7:
            lsr.l   #1,D2
            bcc.b   .L8
            move.l  (A0)+,(A1)+
            tst.l   D2
.L8:
            beq.b   .L9
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
.L9:
            moveq   #$20,D2
            sub.l   D2,D0
            bclr    #4,D0
            nop
            beq.b   .L10
            dc.w    $F620,$9000,$6008
            ds.b    8
.L10:
            dc.w    $F620,$9000,$9082,$F620,$9000,$6CF4,$60FF,$FFF8
            dc.w    $853A
            ds.b    1886
DEVICEMGRPATCH:
OPENIGNOREPATCH:
            _sUpdateSRT
            exg     A4,A0
            moveq   #0,D0
            rts
READUPDATE:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            moveq   #2,D0
            _PowerDispatch
.L1:
            rts
WRITEUPDATE:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            moveq   #2,D0
            _PowerDispatch
.L1:
            move.w  ($18,A0),D2
            bpl.l   FileWrite
            bra.l   WriteUpdateReturn
            ds.b    972
DISPATCHPATCH:
SETTRAPADDRESSPATCH:
            jsr     ([$6F4.w])
            move.l  A0,(A1)
            moveq   #0,D0
            rts
CACHEVECTORPATCH:
            BigLea  EMT1010,A0
            move.l  A0,LineAVector
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            lea     .L2,A1
            move.l  A1,($6F4).w
.L1:
            rts
            ds.b    4
.L2:
            nop
            mc68040
            cpusha  BC
            mc68030
            rts
            ds.b    970
EGRETPATCHTOO:
EGRETDISPATCHPATCH:
            bne.b   .L1
            move.l  A0,($30,A2)
            bra.b   .L2
.L1:
            cmpi.b  #$FE,(A0)
            bne.b   .L3
            move.l  (2,A0),($2C,A2)
.L2:
            moveq   #0,D0
            addq.w  #4,SP
.L3:
            rts
CHECKPACKETPATCH:
            cmpi.b  #$FF,(A0)
            beq.b   .L1
            cmpi.b  #$FE,(A0)
            bne.b   .L2
.L1:
            clr.w   ($E,A0)
            addq.w  #4,SP
.L2:
            rts
DELAY100PATCH:
            move.l  D1,-(SP)
            move.w  TimeVIADB,D1
            lsr.w   #3,D1
            addi.w  #$19,D1
.L1:
            tst.b   (A1)
            dbra    D1,.L1
            move.l  (SP)+,D1
            rts
SHIFTREGIRQPATCH:
            bne.b   .L1
            cmpi.b  #3,(3,A1)
            bne.b   .L2
            rts
.L1:
            cmpi.b  #4,(1,A1)
            bne.b   .L2
            move.l  ($2C,A2),D2
            beq.b   .L2
            movea.l D2,A3
            move.b  (3,A1),D0
            bsr.l   SETRESPONSEPARAMS
            move    D3,SR
            jsr     (A3)
            bra.b   .L3
.L2:
            bsr.l   SETRESPONSEPARAMS
            move    D3,SR
            bra.b   .L3
            bclr    #4,(A1)
.L3:
            addq.w  #4,SP
            rts
SETTRANSFERPARMSPATCH:
            andi.b  #$F,D0
            lea     .L1,A1
            rts
.L1:
            ds.b    16
            dc.w    $8000,$8000,$8000,$8000,$0008,$0008,$0008,$0008
ECLIPSEEGRETPATCHES:
            bsr.l   INITRELIABILITY
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            subi.l  #$20,D0
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            bsr.w   ECLIPSEDFACPATCH
            bsr.b   ECLIPSEPDMPATCH
.L1:
            rts
ECLIPSEPDMPATCH:
            movem.l A0-A1,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$FE00,(A0)
            clr.l   ($10,A0)
            lea     KEYSWITCHHANDLER,A1
            move.l  A1,(2,A0)
            _EgretDispatch
            movea.l ExpandMem,A1
            moveq   #$22,D0
            _NewPtrSysClear
            move.l  A0,($1B6,A1)
            adda.w  #$14,SP
            movem.l (SP)+,A0-A1
            rts
KEYSWITCHHANDLER:
            tst.b   D0
            bne.b   .L2
            movem.l A0-A1,-(SP)
            movea.l ExpandMem,A1
            movea.l ($1B6,A1),A0
            movea.l A0,A1
            moveq   #$10,D0
.L1:
            clr.w   (A1)+
            dbra    D0,.L1
            lea     sub_40885550.L4,A1
            move.l  A1,(6,A0)
            _InsTime
            move.l  #$1388,D0
            _PrimeTime
            lea     ($E,A0),A0
            move.w  #7,(4,A0)
            lea     sub_40885550,A1
            move.l  A1,(8,A0)
            jsr     ([JDTInstall.w])
            movem.l (SP)+,A0-A1
            tst.w   D0
            bne.b   sub_40885550.L4
.L2:
            rts
sub_40885550:
            movea.l ($358).w,A1
            bra.b   .L3
.L1:
            tst.w   ($4C,A1)
            bne.b   .L2
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  ($4E,A1),($16,A0)
            clr.l   ($12,A0)
            clr.l   ($C,A0)
            move.l  A1,-(SP)
            _HUnmountVol
            movea.l (SP)+,A1
            lea     ($32,SP),SP
.L2:
            movea.l (A1),A1
.L3:
            move.l  A1,D0
            bne.b   .L1
.L4:
            bsr.l   EGRETPOWEROFF
            bra.b   .L4
ECLIPSEDFACPATCH:
            movem.l A0-A1,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$120,(A0)
            clr.l   ($10,A0)
            move.w  #$100,-(SP)
            move.l  SP,(8,A0)
            move.w  #2,(6,A0)
            _EgretDispatch
            adda.w  #$16,SP
            movem.l (SP)+,A0-A1
            rts
RequestDonePatch:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.l  A1,D1
            beq.b   .noHandler
            bsr.b   sub_40885604
            bne.b   .JustDoIt
            btst    #5,($15D,A3)
            bne.b   .JustDoIt
            move.l  A1,-(SP)
            movea.l VIA2,A1
            btst    #0,(A1)
            movea.l (SP)+,A1
            beq.b   .noHandler
.JustDoIt:
            jsr     (A1)
.noHandler:
            movea.l (SP),SP
            rts
DEBUGUTILRUNKBDPATCH:
            bsr.b   sub_40885604
            bne.b   .L1
            move.l  A1,-(SP)
            movea.l VIA2,A1
            btst    #2,(A1)
            movea.l (SP)+,A1
            beq.b   .L2
.L1:
            bra.l   DEBUGPWRMGRADBPATCH2
.L2:
            bra.w   sub_40885550.L4
sub_40885604:
            move.l  D0,-(SP)
            move.l  #$C0000,D0
            and.l   UnivROMFlags,D0
            subi.l  #$40000,D0
            movem.l (SP)+,D0
            rts
            ds.b    1508
FILEMGRPATCH:
CMDDONEPATCH:
            movea.l ($362).w,A0
            cmpi.b  #2,(7,A0)
            bne.b   .L1
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
.L1:
            clr.b   ($377).w
            ext.l   D0
            rts
DSHOOKPATCH:
            move.w  (6,A0),D0
            bgt.b   .L1
            jmp     .L2
.L1:
            ori.b   #$A0,($B00).w
            move.b  #$60,($B01).w
            andi.w  #$FF,D0
.L2:
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
            jmp     ($B00).w
            ds.b    1978
GestaltPatch:
getPageSizePatch:
            moveq   #0,D0
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            mc68040
            movec   TC,D1
            mc68030
            btst    #$E,D1
            bne.b   .L2
            bset    #$C,D0
            bra.b   .L3
.L2:
            bset    #$D,D0
            bra.b   .L3
.L1:
            cmpi.b  #2,CPUFlag
            blt.w   .L4
            cmpi.b  #3,MMUType
            blt.b   .L5
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            lea     ($12,A0),A0
            pmove.l TC,(A0)
            bfextu  (A0){8:4},D1
            bset    D1,D0
            bra.b   .L3
.L5:
            move.l  #$8000,D0
.L3:
            bra.w   getAddrModePatch.L1
.L4:
            bra.w   getAddrModePatch.L3
getFPUTypePatch:
            btst    #4,HWCfgFlags
            beq.b   .L4
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #3,D0
            bra.b   .L5
.L1:
            movea.l SP,A0
            fnop
            fsave   -(SP)
            move.w  (SP),D0
            movea.l A0,SP
            cmpi.w  #$1F18,D0
            beq.b   .L2
            cmpi.w  #$3F18,D0
            beq.b   .L2
            cmpi.w  #$3F38,D0
            beq.b   .L3
            cmpi.w  #$1F38,D0
            beq.b   .L3
            moveq   #0,D0
            bra.b   .L5
.L2:
            moveq   #1,D0
            bra.b   .L5
.L3:
            moveq   #2,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            bra.b   getAddrModePatch.L1
getAddrModePatch:
            moveq   #0,D0
            move.b  ($B73).w,D0
            not.b   D0
            andi.l  #3,D0
            bset    #2,D0
            bra.w   .L1
.L3:
            move.w  #$EA52,($C,SP)
            bra.b   .L2
.L1:
            movea.l (4,SP),A0
            move.l  D0,(A0)
            clr.w   ($C,SP)
.L2:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
            ds.b    1842
GETREALPROC:
            move.w  #6,-(SP)
            bra.b   GetPageDescProc.L1
GetPageDescProc:
            move.w  #7,-(SP)
.L1:
            movem.l D1-D4,-(SP)
            link.w  A6,#-$1A
            cmpi.b  #3,MMUType
            bge.b   .L2
            move.w  #$FD8E,D0
            bra.b   .L8
.L2:
            move.l  A0,D2
            jsr     GETMMUINFO
            move.b  MMU32bit,-(SP)
            bne.b   .L3
            moveq   #1,D0
            _SwapMMUMode
            and.l   Lo3Bytes,D2
            bra.b   .L4
.L3:
            jsr     CHECKTTREGS
            bne.b   .L4
            movea.l D2,A0
            suba.l  A2,A2
            moveq   #0,D3
            bra.b   .L6
.L4:
            cmpi.b  #5,MMUType
            beq.b   .L5
            jsr     translate030
            bra.b   .L6
.L5:
            jsr     translate040
.L6:
            move.b  (SP)+,D0
            bne.b   .L7
            _SwapMMUMode
.L7:
            move.w  D3,D0
.L8:
            unlk    A6
            movem.l (SP)+,D1-D4
            cmpi.w  #7,(SP)+
            bne.b   .L9
            movea.l A2,A0
.L9:
            rts
GETMMUINFO:
            cmpi.b  #5,MMUType
            beq.b   .L1
            pmove.d CRP,(-$10,A6)
            pmove.l TC,(-8,A6)
            move.l  (-8,A6),D4
            moveq   #$C,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$15,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$19,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$18,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$17,A6)
            addq.l  #4,D3
            bfextu  D4{D3:4},D0
            move.b  D0,(-$16,A6)
            bra.b   .L2
.L1:
            mc68040
            movec   SRP,D0
            mc68030
            move.l  D0,(-$C,A6)
            clr.l   (-$10,A6)
            move.b  #7,(-$19,A6)
            move.b  #7,(-$18,A6)
            move.b  #5,(-$17,A6)
            mc68040
            movec   TC,D0
            mc68030
            move.w  D0,(-8,A6)
            btst    #$E,D0
            bne.b   .L5
            move.b  #6,(-$17,A6)
.L5:
            clr.b   (-$16,A6)
            clr.b   (-$15,A6)
.L2:
            clr.l   (-$14,A6)
            cmpi.l  #$FFFFFFFF,ExpandMem
            beq.b   .L3
            move.l  #'addr',D0
            _Gestalt
            tst.w   D0
            bne.b   .L4
            move.l  A0,D0
            btst    #2,D0
            beq.b   .L4
            move.l  #$766D2020,D0
            _Gestalt
            tst.w   D0
            bne.b   .L3
            move.l  A0,D0
            btst    #0,D0
            bne.b   .L4
.L3:
            move.l  Phys2Log,(-$14,A6)
.L4:
            rts
CHECKTTREGS:
            cmpi.b  #5,MMUType
            beq.b   .L1
            subq.w  #4,SP
            pmove.l TT0,(SP)
            move.l  (SP),D0
            pmove.l TT1,(SP)
            move.l  (SP),D1
            addq.w  #4,SP
            bra.b   .L2
.L1:
            mc68040
            movec   DTT0,D0
            movec   DTT1,D1
            mc68030
.L2:
            btst    #$F,D0
            beq.b   .L3
            move.l  D2,D3
            eor.l   D0,D3
            rol.l   #8,D3
            swap    D0
            not.b   D0
            and.b   D0,D3
            beq.b   .L5
.L3:
            btst    #$F,D1
            beq.b   .L4
            move.l  D2,D3
            eor.l   D1,D3
            rol.l   #8,D3
            swap    D1
            not.b   D1
            and.b   D1,D3
            bra.b   .L5
.L4:
            andi    #$FFFB,SR
.L5:
            rts
translate030:
            movem.l D4-D7,-(SP)
            move.l  (-$C,A6),D1
            move.l  (-$10,A6),D7
            move.b  D7,D3
            andi.b  #3,D3
            move.l  (-8,A6),D0
            btst    #$19,D0
            bne.w   .paramErr
            btst    #$18,D0
            bne.w   .paramErr
            btst    #$1F,D0
            bne.b   .L1
            movea.l D2,A1
            moveq   #0,D1
            moveq   #0,D3
            bra.b   .xlatDone
.L1:
            moveq   #0,D4
            move.b  (-$15,A6),D4
            lea     (-$19,A6),A1
            moveq   #0,D5
            move.b  (A1)+,D5
.xlatLoop:
            cmpi.b  #1,D3
            beq.b   .getPage
            bfextu  D2{D4:D5},D6
            tst.l   D7
            beq.b   .noLimit
            jsr     checkLimit
            bcs.b   .paramErr
.noLimit:
            andi.l  #$FFFFFFF0,D1
            cmpi.b  #2,D3
            bne.b   .not4byte
            add.l   (-$14,A6),D1
            movea.l D1,A2
            lsl.w   #2,D6
            adda.l  D6,A2
            move.l  (A2),D1
            moveq   #0,D7
            move.b  D1,D3
            bra.b   .doNext
.not4byte:
            cmpi.b  #3,D3
            bne.b   .paramErr
            add.l   (-$14,A6),D1
            movea.l D1,A2
            lsl.w   #3,D6
            adda.l  D6,A2
            move.l  (4,A2),D1
            move.l  (A2),D7
            move.b  D7,D3
.doNext:
            add.l   D5,D4
            move.b  (A1)+,D5
            andi.b  #3,D3
            bra.b   .xlatLoop
.getPage:
            moveq   #$20,D5
            sub.l   D4,D5
            bfextu  D1{0:D4},D0
            bfextu  D2{D4:D5},D6
            lsl.l   D5,D0
            add.l   D6,D0
            movea.l D0,A0
            adda.l  (-$14,A6),A2
            moveq   #0,D3
.xlatDone:
            movem.l (SP)+,D4-D7
            rts
.paramErr:
            move.w  #$FFCE,D3
            bra.b   .xlatDone
translate040:
            movem.l D4-D7,-(SP)
            move.l  (-$C,A6),D1
            move.w  (-8,A6),D0
            btst    #$F,D0
            bne.b   .startTranslate
            movea.l D2,A1
            moveq   #0,D1
            moveq   #0,D3
            bra.b   .L5
.startTranslate:
            moveq   #0,D4
            clr.w   D3
            moveq   #0,D5
            lea     (-$19,A6),A1
.L2:
            move.b  (A1)+,D5
            moveq   #$1E,D0
            sub.l   D5,D0
            bfextu  D1{0:D0},D1
            lsl.l   D5,D1
            lsl.l   #2,D1
            bfextu  D2{D4:D5},D6
            lsl.w   #2,D6
            add.l   D6,D1
            add.l   (-$14,A6),D1
            movea.l D1,A2
            move.l  (A2),D1
            cmpi.w  #2,D3
            beq.b   .L3
            btst    #1,D1
            beq.b   .L6
            add.l   D5,D4
            addq.w  #1,D3
            bra.b   .L2
.L3:
            move.b  D1,D0
            andi.b  #3,D0
            cmpi.b  #1,D0
            beq.b   .L4
            cmpi.b  #2,D0
            bne.b   .L6
            andi.l  #$FFFFFFFC,D1
            add.l   (-$14,A6),D1
            movea.l D1,A2
            move.l  (A2),D1
.L4:
            add.l   D5,D4
            moveq   #$20,D5
            sub.l   D4,D5
            bfextu  D1{0:D4},D0
            bfextu  D2{D4:D5},D6
            lsl.l   D5,D0
            add.l   D6,D0
            movea.l D0,A0
            moveq   #0,D3
.L5:
            movem.l (SP)+,D4-D7
            rts
.L6:
            move.w  #$FFCE,D3
            bra.b   .L5
checkLimit:
            swap    D7
            btst    #$F,D7
            bne.b   .L1
            cmp.w   D6,D7
            bra.b   .L2
.L1:
            andi.w  #$7FFF,D7
            cmp.w   D7,D6
.L2:
            rts
            ds.b    10
EDISKPROTECT:
            movem.l D2-D4/A2,-(SP)
            link.w  A6,#-$1A
            move.l  A0,D2
            movea.w A1,A2
            move    SR,D0
            btst    #$D,D0
            bne.b   .L1
            moveq   #8,D0
            _DebugUtil
.L1:
            move.w  D0,-(SP)
            move.b  MMU32bit,-(SP)
            bne.b   .L2
            moveq   #1,D0
            _SwapMMUMode
            bra.b   .L3
.L2:
            jsr     CHECKTTREGS
            bne.b   .L3
            movea.l D2,A0
            moveq   #-$32,D3
            bra.b   cleanup
.L3:
            jsr     GETMMUINFO
            moveq   #0,D0
            moveq   #0,D1
            move.b  (-$15,A6),D0
            move.b  (-$19,A6),D1
            bfextu  D2{D0:D1},D0
            lsl.l   #2,D0
            btst    #0,(-$D,A6)
            beq.b   .L4
            lsl.l   #1,D0
.L4:
            add.l   (-$C,A6),D0
            add.l   (-$14,A6),D0
            movea.l D0,A0
            bset    #2,(3,A0)
            tst.w   A2
            bne.b   .L5
            bclr    #2,(3,A0)
.L5:
            cmpi.b  #4,CPUFlag
            bne.b   .L6
            mc68040
            pflusha
            mc68030
            bra.b   cleanup
.L6:
            pflusha
cleanup:
            move.b  (SP)+,D0
            bne.b   skipMMUSwap
            _SwapMMUMode
skipMMUSwap:
            move.w  (SP)+,D0
            move    D0,SR
            move.w  D3,D0
            unlk    A6
            movem.l (SP)+,D2-D4/A2
            rts
            ds.b    128
HWPrivPatch:
SWAPICACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L2
            movec   CACR,D0
            bfextu  D0{31:1},D1
            bclr    #0,D0
            move.l  A0,D2
            beq.b   .L1
            ori.b   #9,D0
.L1:
            bra.b   .L3
.L2:
            movec   CACR,D0
            bfextu  D0{16:1},D1
            bclr    #$F,D0
            move.l  A0,D2
            beq.b   .L3
            jsr     ([$6F4.w])
            bset    #$F,D0
.L3:
            movea.l D1,A0
            movec   D0,CACR
            moveq   #0,D0
            rts
FLUSHICACHEPATCH:
            jsr     ([$6F4.w])
            moveq   #0,D0
            rts
SWAPDCACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L2
            movec   CACR,D0
            bfextu  D0{23:1},D1
            bclr    #8,D0
            move.l  A0,D2
            beq.b   .L1
            ori.w   #$900,D0
.L1:
            bra.b   .L3
.L2:
            movec   CACR,D0
            bfextu  D0{0:1},D1
            bset    #$1F,D0
            move.l  A0,D2
            bne.b   .L3
            nop
            mc68040
            cpusha  DC
            mc68030
            bclr    #$1F,D0
.L3:
            movea.l D1,A0
            movec   D0,CACR
            moveq   #0,D0
            rts
FLUSHDCACHEPATCH:
            cmpi.b  #4,CPUFlag
            bge.b   .L1
            movec   CACR,D0
            bset    #$B,D0
            movec   D0,CACR
            bra.b   .L2
.L1:
            nop
            mc68040
            cpusha  DC
            mc68030
.L2:
            moveq   #0,D0
            rts
FLUSHCRANGEFORBM:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
FLUSHCRANGE:
            cmpi.b  #4,CPUFlag
            blt.w   .L4
            lea     ($F,A1),A1
            move.l  A1,D1
            andi.w  #$FFF0,D1
            move    SR,D0
            btst    #$D,D0
            bne.b   .L1
            moveq   #8,D0
            _DebugUtil
.L1:
            cmpi.l  #$C00,D1
            blt.b   .L2
            nop
            mc68040
            cpusha  BC
            mc68030
            bra.b   .L3
.L2:
            movem.l D3-D5/A0-A1,-(SP)
            ori     #$700,SR
            moveq   #5,D2
            movec   D2,DFC
            move.w  #$D000,D4
            mc68040
            movec   TC,D2
            mc68030
            lsr.w   #2,D2
            eor.w   D2,D4
            move.w  D4,D5
            not.w   D5
.L8:
            movea.l A0,A1
            mc68040
            ptestr  (A1)
            movec   MMUSR,D3
            mc68030
            and.w   D4,D3
            move.w  A1,D2
            and.w   D5,D2
            or.w    D2,D3
            movea.l D3,A1
            eor.w   D5,D2
            addq.w  #1,D2
            sub.w   D2,D1
            bpl.b   .L5
            add.w   D1,D2
.L5:
            adda.w  D2,A0
            asr.w   #4,D2
            cmpi.w  #$10,D2
            blt.b   .L6
            nop
            mc68040
            cpushp  BC,(A1)
            mc68030
            bra.b   .L7
.L6:
            mc68040
            cpushl  BC,(A1)
            mc68030
            lea     ($10,A1),A1
            dbra    D2,.L6
.L7:
            tst.w   D1
            bgt.b   .L8
            movem.l (SP)+,D3-D5/A0-A1
.L3:
            move    D0,SR
            moveq   #0,D0
            rts
.L4:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            moveq   #0,D0
            rts
WRITEPROTECTPROC:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l LockMemCT,A2
            moveq   #-$32,D0
            move.l  (4,A2),D2
            subq.l  #1,D2
            move.l  A0,D1
            and.l   D2,D1
            bne.b   .L2
            move.l  A1,D1
            and.l   D2,D1
            bne.b   .L2
            bsr.w   GetPageRange
            bne.b   .L2
            moveq   #3,D0
            _HWPriv
            moveq   #1,D0
            _HWPriv
            bsr.w   MMUFlushATC
            lea     ($1C,A2,D1.w*2),A1
            moveq   #4,D0
.L1:
            ori.w   #$8000,(A1)+
            bsr.w   MMUSetWriteProtect
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D2/A0-A2
            rts
UNWRITEPROTECTPROC:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l LockMemCT,A2
            moveq   #-$32,D0
            move.l  (4,A2),D2
            subq.l  #1,D2
            move.l  A0,D1
            and.l   D2,D1
            bne.b   .L2
            move.l  A1,D1
            and.l   D2,D1
            bne.b   .L2
            bsr.w   GetPageRange
            bne.b   .L2
            lea     ($1C,A2,D1.w*2),A1
            moveq   #0,D0
.L1:
            andi.w  #$7FFF,(A1)+
            bsr.w   MMUSetWriteProtect
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D2/A0-A2
            rts
NEWLOCKMEMORY:
            movem.l D1-D4/A0-A2,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L2
            lea     ($1C,A2,D1.w*2),A1
            moveq   #1,D0
.L1:
            addq.w  #1,(A1)+
            bsr.w   MMUSetCacheInhibit
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #3,D0
            _HWPriv
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D4/A0-A2
            rts
NEWUNLOCKMEMORY:
            movem.l D1-D4/A0-A2,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L5
            lea     ($1C,A2,D1.w*2),A1
            move.l  D2,D3
            move.w  #$FD91,D0
.L1:
            tst.w   (A1)+
            beq.b   .L5
            subq.l  #1,D3
            bhi.b   .L1
            lea     ($1C,A2,D1.w*2),A1
            move.l  D2,D3
            moveq   #0,D0
            moveq   #0,D4
.L2:
            subq.w  #1,(A1)+
            bne.b   .L3
            bsr.w   MMUSetCacheInhibit
            moveq   #1,D4
.L3:
            addq.l  #1,D1
            subq.l  #1,D3
            bhi.b   .L2
            tst.l   D4
            beq.b   .L4
            bsr.w   MMUFlushATC
.L4:
            moveq   #0,D0
.L5:
            movem.l (SP)+,D1-D4/A0-A2
            rts
NEWLOCKMEMORYCONTIGUOUS:
            movem.l D1-D4/A0-A3,-(SP)
            movea.l LockMemCT,A2
            bsr.w   GetPageRange
            bne.b   .L2
            movea.l A0,A3
            movem.l D1/A1-A2,-(SP)
            bsr.w   GETREALPROC
            movem.l (SP)+,D1/A1-A2
            exg     A0,A3
            adda.l  A1,A0
            subq.l  #1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GETREALPROC
            movem.l (SP)+,D1/A1-A2
            suba.l  A3,A0
            addq.l  #1,A0
            cmpa.l  A1,A0
            bne.b   .L3
            lea     ($1C,A2,D1.w*2),A1
            moveq   #1,D0
.L1:
            addq.w  #1,(A1)+
            bsr.w   MMUSetCacheInhibit
            addq.l  #1,D1
            subq.l  #1,D2
            bhi.b   .L1
            bsr.w   MMUFlushATC
            moveq   #3,D0
            _HWPriv
            moveq   #0,D0
.L2:
            movem.l (SP)+,D1-D4/A0-A3
            rts
.L3:
            move.w  #$FD92,D0
            bra.b   .L2
GetPageRange:
            movem.l A1-A2,-(SP)
            move.l  A0,D0
            tst.b   MMU32bit
            bne.b   .noStrip
            _StripAddress
.noStrip:
            movea.l D0,A0
            cmpa.w  #0,A1
            beq.b   .error
            move.l  D0,D1
            move.l  D0,D2
            add.l   A1,D2
            subq.l  #1,D2
            cmp.l   RealMemTop,D2
            bcc.b   .error
            move.l  (8,A2),D0
            lsr.l   D0,D1
            lsr.l   D0,D2
            sub.l   D1,D2
            addq.l  #1,D2
            moveq   #0,D0
.exit:
            movem.l (SP)+,A1-A2
            rts
.error:
            moveq   #paramErr,D0
            bra.b   .exit
MMUSetWriteProtect:
            cmpi.b  #3,MMUType
            bcs.w   .L2
            movem.l D0-D4/A0-A1,-(SP)
            move.l  D0,D4
            cmp.l   ($C,A2),D1
            scs     D3
            move.l  (8,A2),D0
            asl.l   D0,D1
            moveq   #0,D0
            _SwapMMUMode
            move.l  D0,D2
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            movea.l A0,A1
            moveq   #1,D0
            _SwapMMUMode
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            bclr    #2,(3,A0)
            or.l    D4,(A0)
            tst.b   D3
            beq.b   .L1
            bclr    #2,(3,A1)
            or.l    D4,(A1)
.L1:
            move.l  D2,D0
            _SwapMMUMode
            movem.l (SP)+,D0-D4/A0-A1
.L2:
            rts
MMUSetCacheInhibit:
            cmpi.b  #3,MMUType
            bcs.w   .noPages
            movem.l D0-D4/A0-A1,-(SP)
            move.l  D0,D4
            cmp.l   ($C,A2),D1
            scs     D3
            move.l  (8,A2),D0
            asl.l   D0,D1
            moveq   #0,D0
            _SwapMMUMode
            move.l  D0,D2
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            movea.l A0,A1
            moveq   #1,D0
            _SwapMMUMode
            movea.l D1,A0
            movem.l D1/A1-A2,-(SP)
            bsr.w   GetPageDescProc
            movem.l (SP)+,D1/A1-A2
            bsr.b   MMUSetCacheMode
            tst.b   D3
            beq.b   .exit
            movea.l A1,A0
            bsr.b   MMUSetCacheMode
.exit:
            move.l  D2,D0
            _SwapMMUMode
            movem.l (SP)+,D0-D4/A0-A1
.noPages:
            rts
MMUSetCacheMode:
            movem.l D0-D1,-(SP)
            tst.b   D4
            beq.b   .L1
            move.l  (A0),D1
            bset    #6,D1
            bclr    #5,D1
            move.l  D1,(A0)
            bra.b   .L2
.L1:
            moveq   #0,D1
            bfextu  CacheFlags{24:1},D1
            lsl.l   #5,D1
            or.l    (A0),D1
            bclr    #6,D1
            move.l  D1,(A0)
.L2:
            movem.l (SP)+,D0-D1
            rts
MMUFlushATC:
            cmpi.b  #3,MMUType
            bcs.b   .exit
            cmpi.b  #5,MMUType
            beq.b   .handle040
            pflusha
.exit:
            rts
.handle040:
            mc68040
            pflusha
            mc68030
            rts
; InitMemoryDispatch
; Allocate and initialize the MemoryDispatch globals
InitMemoryDispatch:
            link.w  A6,#-4
            movem.l D0-D4/A0-A3,-(SP)
            clr.l   LockMemCT
            move.b  CPUFlag,D1
            moveq   #0,D2
            move.l  PhysMemTop,D3
            cmpi.b  #cpu68040,D1
            bne.b   .not040
            mc68040
            moveq   #12,D1
            movec   TC,D0
            btst    #14,D0
            beq.b   .gotPageSize
            addq.l  #1,D1
            bra.b   .gotPageSize
            mc68030
.not040:
            cmpi.b  #cpu68020,D1
            blt.b   .noPages
            cmpi.b  #3,MMUType
            blt.b   .noPages
            pmove.l TC,(-4,A6)
            bfextu  (-4,A6){8:4},D1
.gotPageSize:
            bset    D1,D2
            lsr.l   D1,D3
            move.l  D3,D4
            move.l  D3,D0
            asl.l   #1,D0
            addi.w  #$1C,D0
            move.l  D0,D3
            _NewPtrSysClear
            bne.b   .noPages
            move.l  A0,LockMemCT
            move.l  D3,(A0)
            move.l  D2,(4,A0)
            move.l  D1,(8,A0)
            move.l  D4,($10,A0)
            move.l  D4,($18,A0)
            move.l  #$800000,D3
            cmp.l   PhysMemTop,D3
            bcs.b   .use8meg
            move.l  PhysMemTop,D3
.use8meg:
            lsr.l   D1,D3
            move.l  D3,($C,A0)
.noPages:
            movem.l (SP)+,D0-D4/A0-A3
            unlk    A6
            rts
WAITFORSCSIDEVS:
            movem.l D2-D4,-(SP)
            move.l  A0,D1
            move.l  D1,D2
            swap    D2
            or.b    D1,D2
            subq.w  #2,SP
            movea.l SP,A0
            _GetOSDefault
            suba.l  A0,A0
            _InternalWait
            bne.b   .L1
            moveq   #$14,D0
.L1:
            mulu.w  #$3C,D0
            move.l  D0,D4
            move.w  (SP)+,D3
            swap    D3
.L2:
            move.l  D2,D0
            bsr.l   SCSIBoots
            move.b  SCSIDrvrs,D0
            and.b   D1,D0
            cmp.b   D1,D0
            beq.b   .L5
            move.l  Ticks,D0
            cmp.l   D4,D0
            bhi.w   .L4
            addi.l  #$F,D0
.L3:
            cmp.l   Ticks,D0
            bhi.b   .L3
            cmp.l   D4,D0
            bcs.b   .L2
.L4:
            movea.w #$FFFF,A0
            bra.b   .L6
.L5:
            suba.l  A0,A0
.L6:
            movem.l (SP)+,D2-D4
            rts
            ds.b    804
MEMORYMGRPATCH:
V24HLOCKPATCH:
            beq.w   V32HLOCKPATCH.L3
            bset    #7,(A1)
            bra.w   V32HLOCKPATCH.L1
V32HLOCKPATCH:
            beq.w   .L3
            bset    #7,(-$B,A0)
.L1:
            cmpi.b  #4,CPUFlag
            bne.b   .L2
            jsr     ([$6F4.w])
.L2:
            moveq   #0,D0
            bra.b   .L4
.L3:
            moveq   #-$6D,D0
.L4:
            move.l  vMMEpilogue,-(SP)
            rts
ZONECHECKPATCH:
            movea.l BusErrVct,A2
            BigLea  HeapGuts,A3
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            lea     sub_4088787A,A3
.L1:
            move.l  A3,BusErrVct
            rts
DEREFHANDLEPATCH:
            movea.l BusErrVct,A2
            BigLea  DHBUSERRHANDLER,A3
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            lea     sub_40887870,A3
.L1:
            move.l  A3,BusErrVct
            rts
sub_40887870:
            moveq   #-1,D0
            movea.l D0,A0
            addq.l  #2,(2,SP)
            rte
sub_4088787A:
            sub.l   D0,D0
            addq.l  #4,(2,SP)
            rte
A24MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A32MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A24ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addi.l  #$17,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addq.l  #8,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$C,D0
            bcc.b   .L2
            moveq   #$C,D0
.L2:
            rts
A32ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$1B,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addi.l  #$C,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
.L2:
            rts
A24SETSIZEPATCH:
            move.l  D0,D1
            lea     ($3C,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addq.l  #8,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A24ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
A32SETSIZEPATCH:
            move.l  D0,D1
            lea     ($40,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$C,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A32ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
SETAPPLBASEPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$F,D0
            andi.w  #$FFF0,D0
            rts
.L1:
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            rts
INIT24ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addq.l  #8,D0
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(A0)
            add.l   D0,(A0)
            sub.l   D0,(A1)
            move.l  (A1),(0,A1,D0.w)
            adda.l  D0,A1
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            adda.l  D0,A1
            addq.b  #2,(A0)
            addq.l  #2,(A0)
            subq.l  #2,(A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
INIT32ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addi.l  #$C,D0
            move.l  (4,A0),D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(3,A0)
            add.l   D0,(4,A0)
            sub.l   D0,(4,A1)
            move.l  (4,A1),(4,A1,D0.w)
            adda.l  D0,A1
            clr.l   (A1)
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (4,A0),D0
            adda.l  D0,A1
            addq.b  #2,(3,A0)
            addq.l  #2,(4,A0)
            subq.l  #2,(4,A1)
            move.l  (4,A1),(6,A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
ALIGN24TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
ALIGN32TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
V24CMGUTSPATCH:
            bsr.l   a24CompactHp
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32CMGUTSPATCH:
            bsr.l   A32COMPACTHP
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A24BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A32BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V32PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V24MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D0
            subq.l  #8,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
V32MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D0
            subi.l  #$C,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
            ds.b    1032
OSEVENTMGRPATCH:
POSTEVENTPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.w  SysEvtMask,D2
            move.w  A0,D1
            rts
OSEVENTAVAILPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.l  (A1)+,(A0)+
            subq.w  #1,D0
            bne.b   .L1
            rts
            ds.b    976

            EVEN
