            include "Include/ROMHeader.s"

            EXPORT  InitMMU

            IMPORT  BaseOfROM,CLOCKPATCH,Critical

            SECTION "MMUTables",CODE

TOP512KOFROM:
MMUSTUFF:
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
            bsr.w   CleanupGlobals
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
            bsr.w   ReadPRAMByte
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
            bsr.w   ReadPRAMByte
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
ReadPRAMByte:
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
CleanupGlobals:
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
            bhi.w   MMUSTUFF.L13
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
            bra.w   MMUSTUFF.L13
            moveq   #2,D0
            moveq   #2,D0
            bra.w   .L19
.L3:
            lea     MMUSTUFF.L1,A0
            lea     TOP512KOFROM,A1
            tst.l   D2
            bne.b   .L4
            addq.l  #1,D4
            beq.w   .L19
.L4:
            cmpi.b  #1,(-$1A,A6)
            bne.w   .L18
            bra.w   MMUSTUFF.L13
.L5:
            lea     MMUSTUFF.L8,A0
            lea     MMUSTUFF.L7,A1
            bra.w   .L19
.L6:
            movea.l (-4,A5),A0
            movea.l A0,A1
            adda.l  (8,A0),A1
            move.l  (A1),(-$A4,A5)
            move.l  (4,A1),(-$B4,A5)
            move.l  (8,A1),(-$B0,A5)
            move.l  #$8000,(-$A8,A5)
            lea     MMUSTUFF.L10,A0
            lea     MMUSTUFF.L9,A1
            bra.w   .L19
.L7:
            movea.l (-4,A5),A0
            movea.l A0,A1
            adda.l  (8,A0),A1
            move.l  (A1),(-$A4,A5)
            move.l  (4,A1),(-$B4,A5)
            move.l  (8,A1),(-$B0,A5)
            move.l  #$8000,(-$A8,A5)
            lea     MMUSTUFF.L12,A0
            lea     MMUSTUFF.L11,A1
            bra.w   .L19
.L8:
            lea     MMUSTUFF.L1,A0
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
            lea     MMUSTUFF.L4,A3
            bra.b   .L11
.L10:
            lea     MMUSTUFF.L6,A3
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
            lea     MMUSTUFF.L3,A1
            bra.b   .L16
.L15:
            lea     MMUSTUFF.L5,A1
.L16:
            bra.b   .L19
.L17:
            movea.l (-4,A5),A2
            movea.l ($34,A1),A3
            bsr.w   GetVISASize
            tst.l   D2
            bne.w   MMUSTUFF.L13
            addq.l  #1,D4
            beq.w   .L19
            bra.w   MMUSTUFF.L13
.L18:
            move.l  (-$A0,A5),D0
            bfffo   D0{0:0},D0
            subq.w  #5,D0
            muls.w  #$FFEE,D0
            lea     ($408800A2.w,PC,D0.w),A0
            lea     MMUSTUFF.L2,A1
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
            bsr.w   ReadPRAMByte
            eor.b   D3,D0
            btst    #3,D0
            bne.b   .L3
            move.w  D2,D0
            addq.w  #3,D0
            bsr.w   ReadPRAMByte
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
            bsr.w   ReadPRAMByte
            cmp.b   D4,D0
            bne.b   .L4
            move.w  D2,D0
            subq.w  #1,D0
            bsr.w   ReadPRAMByte
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

            EVEN
