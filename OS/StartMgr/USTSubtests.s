USTTests:
            dc.w    0,$0001,0,$5490,0,$0030
            ds.b    7
            dc.b    $02,$00,$08,$3D,$60,$00,$00,$00,$3F
            ds.b    4
            dc.w    $FFFF,$FFFF
            ds.b    12
            dc.b    'ROM based test'
            dc.w    $0053
            dc.b    'ONIC Ethernet controller CTE Test'
            dc.b    $00
USTSubtests:
            dc.w    0,$0080,0,$171E,0,$02A0
            ds.b    15
            dc.b    $81,$00,$00,$17,$1E,$00,$00,$02,$B9
            ds.b    15
            dc.b    $82,$00,$00,$17,$1E,$00,$00,$02,$D8
            ds.b    15
            dc.b    $83,$00,$00,$17,$1E,$00,$00,$02,$EB
            ds.b    15
            dc.b    $84,$00,$00,$18,$FA,$00,$00,$03,$01
            ds.b    15
            dc.b    $85,$00,$00,$18,$46,$00,$00,$03,$2B
            ds.b    15
            dc.b    $86,$00,$00,$19,$D8,$00,$00,$03,$5E
            ds.b    15
            dc.b    $87,$00,$00,$1A,$D6,$00,$00,$03,$85
            ds.b    15
            dc.b    $88,$00,$00,$1C,$A4,$00,$00,$03,$A1
            ds.b    15
            dc.b    $89,$00,$00,$1D,$8C,$00,$00,$03,$B4
            ds.b    15
            dc.b    $8A,$00,$00,$20,$8E,$00,$00,$03,$C8
            ds.b    15
            dc.b    $8B,$00,$00,$21,$6A,$00,$00,$03,$D6
            ds.b    15
            dc.b    $8C,$00,$00,$22,$DA,$00,$00,$03,$FA
            ds.b    15
            dc.b    $8D,$00,$00,$25,$D0,$00,$00,$04,$11
            ds.b    15
            dc.b    $8E,$00,$00,$2D,$9C,$00,$00,$04,$25
            ds.b    15
            dc.b    $8F,$00,$00,$2E,$12,$00,$00,$04,$36
            ds.b    15
            dc.b    $90,$00,$00,$2E,$90,$00,$00,$04,$56
            ds.b    15
            dc.b    $91,$00,$00,$2F,$98,$00,$00,$04,$73
            ds.b    15
            dc.b    $92,$00,$00,$30,$42,$00,$00,$04,$9A
            ds.b    15
            dc.b    $93,$00,$00,$30,$B0,$00,$00,$04,$C2
            ds.b    15
            dc.b    $94,$00,$00,$31,$24,$00,$00,$04,$D3
            ds.b    15
            dc.b    $95,$00,$00,$32,$64,$00,$00,$04,$FA
            ds.b    15
            dc.b    $96,$00,$00,$35,$8A,$00,$00,$05,$0A
            ds.b    15
            dc.b    $97,$00,$00,$38,$32,$00,$00,$05,$1D
            ds.b    15
            dc.b    $9A,$00,$00,$38,$A8,$00,$00,$05,$27
            ds.b    15
            dc.b    $9B,$00,$08,$25,$0E,$00,$00,$05,$3D
            ds.b    7
            dc.b    $0C,$00,$00,$00,$2C,$00,$00,$00,$9C,$00,$08,$29,$DE,$00,$00,$05
            dc.b    $5E
            ds.b    7
            dc.b    $1C,$00,$00,$00,$18,$00,$00,$00,$9D,$00,$08,$2C,$5E,$00,$00,$05
            dc.b    $79
            ds.b    7
            dc.b    $80,$00,$00,$00,','
            dc.b    'Portable mapper RAM data'
            dc.b    $00
            dc.b    'Portable mapper RAM uniqueness'
            dc.b    $00
            dc.b    'Portable VRAM data'
            dc.b    $00
            dc.b    'Portable VRAM address'
            dc.b    $00
            dc.b    'Serial Communications Controller register'
            dc.b    $00
            dc.b    'Serial Communications Controller internal loopback'
            dc.b    $00
            dc.b    'Serial Communications Controller timer'
            dc.b    $00
            dc.b    'Versatile Interface Adapter'
            dc.b    $00
            dc.b    'SCSI chip register'
            dc.b    $00
            dc.b    'Sound chip register'
            dc.b    $00
            dc.b    'Parameter RAM'
            dc.b    $00
            dc.b    'RAM Based Video controller register'
            dc.b    $00
            dc.b    'Floppy controller chip'
            dc.b    $00
            dc.b    'Floating point unit'
            dc.b    $00
            dc.b    'IIci type parity'
            dc.b    $00
            dc.b    'Fast Memory Controller register'
            dc.b    $00
            dc.b    'Fast Memory Controller cache'
            dc.b    $00
            dc.b    'Operating System Support chip register'
            dc.b    $00
            dc.b    'Operating System Support chip interrupt'
            dc.b    $00
            dc.b    'IIfx type parity'
            dc.b    $00
            dc.b    'Apple Desktop Bus microcontroller self'
            dc.b    $00
            dc.b    'Sound interrupt'
            dc.b    $00
            dc.b    'Color lookup table'
            dc.b    $00
            dc.b    'Video RAM'
            dc.b    $00
            dc.b    '53C96 Turbo SCSI chip'
            dc.b    $00
            dc.b    'SONIC Ethernet register bitmarch'
            dc.b    $00
            dc.b    'SONIC Ethernet on-chip DMA'
            dc.b    $00
            dc.b    'SONIC Ethernet protocol loopback'
            dc.b    $00
USTCPUList:
            dc.w    $000C,0,$0024,$000E,0,$0078,$0010,0
            dc.w    $00CC,$000F,0,$0120,$000D,0,$0168,$00FD
            dc.w    0,$01C2,$0001,$0084,$001D,$0001,$0085,$001D
            dc.w    $0001,$0086,$001D,$0001,$0087,$001D,$0001,$0088
            dc.w    $001D,$0001,$0089,$001D,$0001,$008A,$001C,$0001
            dc.w    $008B,$001D,$0001,$008C,$001D,$0001,$008D,$001D
            dc.w    $0001,$0094,$001C,$0001,$0095,$001C,$0001,$0096
            dc.w    $001D,$FFFF,$FFFF,0,$0001,$0084,$001D,$0001
            dc.w    $0085,$001D,$0001,$0086,$001D,$0001,$0087,$001D
            dc.w    $0001,$0089,$001D,$0001,$0097,$001C,$0001,$0095
            dc.w    $001C,$0001,$0094,$001C,$0001,$008A,$001C,$0001
            dc.w    $009A,$001C,$0002,$009B,$001C,$0002,$009C,$001C
            dc.w    $0002,$009D,$001C,$FFFF,$FFFF,0,$0001,$0084
            dc.w    $001D,$0001,$0085,$001D,$0001,$0086,$001D,$0001
            dc.w    $0087,$001D,$0001,$0089,$001D,$0001,$008C,$001D
            dc.w    $0001,$0097,$001C,$0001,$0095,$001C,$0001,$008A
            dc.w    $001C,$0001,$009A,$001C,$0002,$009B,$001C,$0002
            dc.w    $009C,$001C,$0002,$009D,$001C,$FFFF,$FFFF,0
            dc.w    $0001,$0084,$001D,$0001,$0085,$001D,$0001,$0086
            dc.w    $001D,$0001,$0087,$001D,$0001,$0088,$001C,$0001
            dc.w    $0089,$001D,$0001,$008D,$001D,$0001,$008C,$001D
            dc.w    $0001,$0097,$001D,$0001,$0095,$001C,$0001,$008A
            dc.w    $001C,$FFFF,$FFFF,0,$0001,$0084,$001D,$0001
            dc.w    $0085,$001D,$0001,$0086,$001D,$0001,$0087,$001D
            dc.w    $0001,$0088,$001D,$0001,$0089,$001D,$0001,$008A
            dc.w    $001C,$0001,$008B,$001D,$0001,$008C,$001D,$0001
            dc.w    $008D,$001D,$0001,$0094,$001C,$0001,$0095,$001C
            dc.w    $0001,$0096,$001D,$0001,$0097,$001F,$FFFF,$FFFF
            dc.w    0,$0001,$0084,$001D,$0001,$0086,$001D,$0001
            dc.w    $0085,$001D,$0001,$0087,$001D,$0001,$0088,$001D
            dc.w    $0001,$0089,$001D,$0001,$008B,$001D,$0001,$008C
            dc.w    $001D,$0001,$008D,$001D,$0001,$008E,$001D,$0001
            dc.w    $0080,$001C,$0001,$0081,$001C,$0001,$0082,$001C
            dc.w    $0001,$0082,$001C,$0001,$008A,$001C,$0001,$0094
            dc.w    $001C,$0001,$0095,$001C,$0001,$0096,$001C,$0001
            dc.w    $0097,$001C,$FFFF,$FFFF
            ds.b    12
