            include "Include/ROMHeader.s"

            SECTION "JMFBDriver",CODE

JMFBDRVR:
            dc.b    $4C
            ds.b    7
            dc.b    $0B,$6A,$00,$00,$0D,$E0,$13,$82,$13,$58,$18
            dc.b    '.Display_Video_Apple_MDC'
            dc.b    $00,$01,$10,$07,$03,$01,$00,$FF,$03,$01,$00,$FF,$FF,$00,$90,$01
            dc.b    $20,$02,$40,$04,$80,$00,$00,$03,$66,$00,$C0,$20,$02,$00,$F8,$00
            dc.b    $04,$00,$24,$00,$03,$00,$00,$00,$90,$01,$1E,$00,$16,$00,$1E,$00
            dc.b    $12,$00,$03,$00,$00,$06,$CC,$00,$4E,$00,$06,$00,$06,$00,$00,$01
            dc.b    $4C,$00,$C8,$20,$02,$00,$FC,$00,$04,$00,$48,$00,$03,$00,$00,$00
            dc.b    $90,$01,$1E,$00,$1A,$00,$1E,$00,$0E,$00,$03,$00,$00,$06,$CC,$00
            dc.b    $4E,$00,$06,$00,$06,$00,$00,$01,$4C,$00,$D0,$20,$02,$00,$FE,$00
            dc.b    $04,$00,$90,$00,$03,$00,$00,$00,$90,$01,$1E,$00,$1C,$00,$1E,$00
            dc.b    $0C,$00,$03,$00,$00,$06,$CC,$00,$4E,$00,$06,$00,$06,$00,$00,$01
            dc.b    $4C,$00,$D8,$20,$02,$00,$FF,$00,$04,$01,$20,$00,$03,$00,$00,$00
            dc.b    $90,$01,$1E,$00,$1D,$00,$1E,$00,$0B,$00,$03,$00,$00,$06,$CC,$00
            dc.b    $4E,$00,$06,$00,$06,$00,$00,$01,$4C,$0E,$06,$02,$00,$FF,$06,$02
            dc.b    $00,$FF,$FF,$00,$50,$00,$A0,$01,$40,$02,$80,$00,$00,$03,$66,$00
            dc.b    $A0,$00,$02,$00,$F0,$00,$04,$00,$14,$00,$03,$00,$00,$00,$A0,$01
            dc.b    $3E,$00,$12,$00,$26,$00,$22,$00,$03,$00,$00,$06,$CC,$00,$54,$00
            dc.b    $06,$00,$06,$00,$00,$01,$78,$00,$A8,$00,$02,$00,$F8,$00,$04,$00
            dc.b    $28,$00,$03,$00,$00,$00,$A0,$01,$3E,$00,$1A,$00,$26,$00,$1A,$00
            dc.b    $03,$00,$00,$06,$CC,$00,$54,$00,$06,$00,$06,$00,$00,$01,$78,$00
            dc.b    $B0,$00,$02,$00,$FC,$00,$04,$00,$50,$00,$03,$00,$00,$00,$A0,$01
            dc.b    $3E,$00,$1E,$00,$26,$00,$16,$00,$03,$00,$00,$06,$CC,$00,$54,$00
            dc.b    $06,$00,$06,$00,$00,$01,$78,$00,$B8,$00,$02,$00,$FE,$00,$04,$00
            dc.b    $A0,$00,$03,$00,$00,$00,$A0,$01,$3E,$00,$20,$00,$26,$00,$14,$00
            dc.b    $03,$00,$00,$06,$CC,$00,$54,$00,$06,$00,$06,$00,$00,$01,$78,$1A
            dc.b    $0C,$05,$02,$00,$0C,$05,$02,$00,$FF,$00,$50,$00,$A0,$01,$40,$02
            dc.b    $80,$0A,$00,$01,$E0,$00,$80,$00,$82,$00,$E0,$00,$50,$00,$14,$00
            dc.b    $03,$00,$00,$01,$3A,$02,$7E,$00,$34,$00,$3E,$00,$68,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$00,$88,$00
            dc.b    $82,$00,$F0,$00,$50,$00,$28,$00,$03,$00,$00,$01,$2A,$02,$7E,$00
            dc.b    $44,$00,$3E,$00,$58,$00,$03,$00,$00,$03,$C0,$00,$4E,$00,$06,$00
            dc.b    $06,$00,$04,$03,$20,$00,$90,$00,$82,$00,$F8,$00,$50,$00,$50,$00
            dc.b    $03,$00,$00,$01,$22,$02,$7E,$00,$4C,$00,$3E,$00,$50,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$00,$98,$00
            dc.b    $82,$00,$FC,$00,$50,$00,$A0,$00,$03,$00,$00,$01,$1E,$02,$7E,$00
            dc.b    $50,$00,$3E,$00,$4C,$00,$03,$00,$00,$03,$C0,$00,$4E,$00,$06,$00
            dc.b    $06,$00,$04,$03,$20,$00,$9A,$00,$86,$00,$FF,$00,$1E,$00,$F0,$00
            dc.b    $03,$00,$00,$01,$40,$02,$7E,$00,$53,$00,$3E,$00,$49,$00,$03,$00
            dc.b    $00,$03,$C0,$00,$4E,$00,$06,$00,$06,$00,$04,$03,$20,$29,$14,$09
            dc.b    $04,$00,$14,$09,$04,$01,$FF,$00,$40,$00,$80,$01,$00,$02,$00,$08
            dc.b    $00,$01,$80,$00,$80,$00,$82,$00,$E0,$00,$50,$00,$10,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$24,$00,$1E,$00,$38,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$00,$88,$00,$82,$00
            dc.b    $F0,$00,$50,$00,$20,$00,$03,$00,$00,$01,$00,$01,$FE,$00,$34,$00
            dc.b    $1E,$00,$28,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00,$02,$00
            dc.b    $04,$02,$60,$00,$90,$00,$82,$00,$F8,$00,$50,$00,$40,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$3C,$00,$1E,$00,$20,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$00,$98,$00,$82,$00
            dc.b    $FC,$00,$50,$00,$80,$00,$03,$00,$00,$01,$00,$01,$FE,$00,$40,$00
            dc.b    $1E,$00,$1C,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00,$02,$00
            dc.b    $04,$02,$60,$00,$9A,$00,$86,$00,$FF,$00,$1E,$00,$C0,$00,$03,$00
            dc.b    $00,$01,$00,$01,$FE,$00,$43,$00,$1E,$00,$19,$00,$03,$00,$00,$03
            dc.b    $00,$00,$26,$00,$06,$00,$02,$00,$04,$02,$60,$FF,$FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$04,$00,$04,$00,$04
            ds.b    5
            dc.w    $0240,$0080,$8112,$00E0,$0100,$0100,$0003,0
            dc.w    $0160,$02FE,$0031,$0043,$0036,$0003,0,$023F
            dc.w    $0028,$0005,$0005,$005E,$0193,$0088,$8112,$00F0
            dc.w    $0100,$0100,$0003,0,$0150,$02FE,$0041,$0043
            dc.w    $0026,$0003,0,$023F,$0028,$0005,$0005,$005E
            dc.w    $0193,$0090,$8112,$00F8,$0100,$0100,$0003,0
            dc.w    $0148,$02FE,$0049,$0043,$001E,$0003,0,$023F
            dc.w    $0028,$0005,$0005,$005E,$0193,$0098,$8112,$00FC
            dc.b    $01
            ds.b    4
            dc.b    $03,$00,$00,$01,$44,$02,$FE,$00,$4D,$00,$43,$00,$1A,$00,$03,$00
            dc.b    $00,$02,$3F,$00,$28,$00,$05,$00,$05,$00,$5E,$01,$93
            ds.b    4
            dc.w    $FFFF,$FFFF,$FFFF,$0400,$0400,$0400,$0400,0
            dc.b    $02,$40,$00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00C9
            dc.b    $81,$32,$00,$FC,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0150,$02FE,$0041,$0043,$0026,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00D1
            dc.b    $81,$32,$00,$FE,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0148,$02FE,$0049,$0043,$001E,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$00D9
            dc.b    $81,$32,$00,$FF,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0144,$02FE,$004D,$0043,$001A,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$FFFF
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$01,$20,$02,$7E,$00
            dc.b    $71,$00,$43,$00,$76,$00,$03,$00,$00,$02,$0F,$00,$58,$00,$05,$00
            dc.b    $05,$00,$5E,$01,$93,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$10,$02,$7E,$00,$81,$00,$43,$00,$66,$00,$03,$00
            dc.b    $00,$02,$0F,$00,$58,$00,$05,$00,$05,$00,$5E,$01,$93,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$01,$08,$02,$7E,$00
            dc.b    $89,$00,$43,$00,$5E,$00,$03,$00,$00,$02,$0F,$00,$58,$00,$05,$00
            dc.b    $05,$00,$5E,$01,$93,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$04,$02,$7E,$00,$8D,$00,$43,$00,$5A,$00,$03,$00
            dc.b    $00,$02,$0F,$00,$58,$00,$05,$00,$05,$00,$5E,$01,$93
            ds.b    5
            dc.b    $FF,$FF,$FF,$FF,$FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01
            dc.b    $E0,$00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0120,$027E,$0071,$0043,$0076,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00C9
            dc.b    $81,$32,$00,$FC,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0110,$027E,$0081,$0043,$0066,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00D1
            dc.b    $81,$32,$00,$FE,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0108,$027E,$0089,$0043,$005E,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$00D9
            dc.b    $81,$32,$00,$FF,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0104,$027E,$008D,$0043,$005A,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$009A
            dc.w    $8116,$00FF,0,$00F0
            ds.b    6
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0101,$027E,$0090,$0043,$0057,$0003
            dc.w    0,$020F,$0058,$0005,$0005,$005E,$0193,$0101
            dc.w    $0101
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$01,$36,$02,$7E,$00
            dc.b    $12,$00,$3A,$00,$3A,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$26,$02,$7E,$00,$22,$00,$3A,$00,$2A,$00,$03,$00
            dc.b    $00,$01,$E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$01,$1E,$02,$7E,$00
            dc.b    $2A,$00,$3A,$00,$22,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$01,$1A,$02,$7E,$00,$2E,$00,$3A,$00,$1E,$00,$03,$00
            dc.b    $00,$01,$E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$01,$01,$01
            dc.b    $01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$E0,$00,$C1,$81
            dc.b    $32,$00,$F8,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02
            dc.b    $00,$07,$03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00
            dc.b    $00,$01,$36,$02,$7E,$00,$12,$00,$3A,$00,$3A,$00,$03,$00,$00,$01
            dc.b    $E0,$00,$21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$C9,$81,$32,$00
            dc.b    $FC,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07
            dc.b    $03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01
            dc.b    $26,$02,$7E,$00,$22,$00,$3A,$00,$2A,$00,$03,$00,$00,$01,$E0,$00
            dc.b    $21,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$D1,$81,$32,$00,$FE,$00
            dc.b    $60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00
            dc.b    $00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1E,$02
            dc.b    $7E,$00,$2A,$00,$3A,$00,$22,$00,$03,$00,$00,$01,$E0,$00,$21,$00
            dc.b    $06,$00,$06,$00,$6E,$01,$4A,$00,$D9,$81,$32,$00,$FF,$00,$60,$01
            dc.b    $00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00
            dc.b    $02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1A,$02,$7E,$00
            dc.b    $2E,$00,$3A,$00,$1E,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$9A,$81,$16,$00,$FF,$00,$00,$00,$F0,$00
            dc.b    $1B,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00,$04,$0D
            dc.b    $06,$00,$01,$00,$00,$00,$03,$00,$00,$01,$1D,$02,$7E,$00,$2B,$00
            dc.b    $3A,$00,$21,$00,$03,$00,$00,$01,$E0,$00,$21,$00,$06,$00,$06,$00
            dc.b    $6E,$01,$4A,$01,$01,$01,$01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$80,$00,$80,$81
            dc.b    $12,$00,$E0,$01,$00,$01,$00,$00,$03,$00,$00,$00,$F4,$01,$FE,$00
            dc.b    $54,$00,$3A,$00,$78,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$88,$81,$12,$00,$F0,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$00,$E4,$01,$FE,$00,$64,$00,$3A,$00,$68,$00,$03,$00
            dc.b    $00,$01,$B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$90,$81
            dc.b    $12,$00,$F8,$01,$00,$01,$00,$00,$03,$00,$00,$00,$DC,$01,$FE,$00
            dc.b    $6C,$00,$3A,$00,$60,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$98,$81,$12,$00,$FC,$01,$00,$01,$00,$00
            dc.b    $03,$00,$00,$00,$D8,$01,$FE,$00,$70,$00,$3A,$00,$5C,$00,$03,$00
            dc.b    $00,$01,$B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$01,$01,$01
            dc.b    $01
            ds.b    5
            dc.b    $FF,$04,$00,$04,$00,$04,$00,$04,$00,$0A,$00,$01,$80,$00,$C1,$81
            dc.b    $32,$00,$F8,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02
            dc.b    $00,$07,$03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00
            dc.b    $00,$00,$F4,$01,$FE,$00,$54,$00,$3A,$00,$78,$00,$03,$00,$00,$01
            dc.b    $B0,$00,$51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$C9,$81,$32,$00
            dc.b    $FC,$00,$60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07
            dc.b    $03,$00,$00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00
            dc.b    $E4,$01,$FE,$00,$64,$00,$3A,$00,$68,$00,$03,$00,$00,$01,$B0,$00
            dc.b    $51,$00,$06,$00,$06,$00,$6E,$01,$4A,$00,$D1,$81,$32,$00,$FE,$00
            dc.b    $60,$01,$00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00
            dc.b    $00,$00,$02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$DC,$01
            dc.b    $FE,$00,$6C,$00,$3A,$00,$60,$00,$03,$00,$00,$01,$B0,$00,$51,$00
            dc.b    $06,$00,$06,$00,$6E,$01,$4A,$00,$D9,$81,$32,$00,$FF,$00,$60,$01
            dc.b    $00,$00,$6C,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00
            dc.b    $02,$0D,$06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$D8,$01,$FE,$00
            dc.b    $70,$00,$3A,$00,$5C,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00
            dc.b    $06,$00,$6E,$01,$4A,$00,$9A,$81,$16,$00,$FF,$00,$00,$00,$F0,$00
            dc.b    $1B,$00,$B0,$00,$00,$0C,$01,$02,$00,$07,$03,$00,$00,$00,$04,$0D
            dc.b    $06,$00,$01,$00,$00,$00,$03,$00,$00,$00,$D5,$01,$FE,$00,$73,$00
            dc.b    $3A,$00,$59,$00,$03,$00,$00,$01,$B0,$00,$51,$00,$06,$00,$06,$00
            dc.b    $6E,$01,$4A
.L1:
            dc.b    $01,$03,$0F,$FF,$FF
            dc.b    'Software by Casey King, Hardware by James Lundblad and Moham'
            dc.b    'med Sritip$'
            dc.w    $A440,$7024,$A722,$6600,$0268,$2348,$0014,$A029
            dc.w    $2010,$A055,$2640,$223C,$F000,0,$1029,$0028
            dc.w    $EFC1,$0104,$2041,$2748,$0018,$2F08,$9EFC,$0038
            dc.w    $204F,$1140,$0031,$514F,$208F,$7011,$A06E,$0C2F
            dc.w    0,$0006,$6706,$08EB,$000C,$001E,$4FEF,$0040
            dc.w    $205F,$1629,$0029,$0803,$0004,$6606,$08EB,$0008
            dc.w    $0010,$0803,$0005,$6606,$08EB,$000D,$0010,$7001
            dc.w    $A05D,$3F00,$203C,$0020,0,$E9F0,$1503,$0800
            dc.w    $0C01,$0007,$661C,$2200,$2F09,$2248,$6100,$0932
            dc.w    $225F,$0C00,$0014,$6606,$123C,$0004,$600E,$4201
            dc.w    $600A,$0C01,0,$6604,$123C,$0007,$301F,$A05D
            dc.w    $0801,0,$6718,$08EB,$0009,$0010,$0881,$0002
            dc.w    $660C,$08EB,$000F,$0010,$08EB,$000C,$0010,$2001
            dc.w    $0C40,$0007,$6200,$019A,$303B,$0206,$4EFB,$0002
            dc.w    $0030,$0028,$0018,$0020,$0038,$0028,$0010,$0020
            dc.w    $41FA,$F552,$6000,$009E,$41FA,$F628,$6000,$0096
            dc.w    $41FA,$F3D6,$6000,$008E,$41FA,$F484,$6000,$0086
            dc.w    $08EB,$000D,$001E,$6006,$08AB,$000D,$001E,$08EB
            dc.w    $000B,$0010,$0803,$0003,$6606,$08EB,$000F,$001E
            dc.w    $082B,$000D,$0010,$672C,$082B,$000F,$001E,$6612
            dc.w    $0C01,$0004,$6706,$41FA,$F6B8,$6048,$41FA,$FA78
            dc.w    $6042,$0C01,$0004,$6706,$41FA,$F86A,$6036,$41FA
            dc.w    $FC68,$6030,$08EB,$000E,$001E,$082B,$000F,$001E
            dc.w    $6612,$0C01,$0004,$6706,$41FA,$F73C,$6016,$41FA
            dc.w    $FAFC,$6010,$0C01,$0004,$6706,$41FA,$F8EE,$6004
            dc.w    $41FA,$FCEC,$2748,$0012,$3741,$001C,$0883,$0003
            dc.w    $0883,$0004,$0883,$0005,$9EFC,$0038,$7010,$A71E
            dc.w    $6600,$00B4,$2748,$0008,$6100,$05AA,$6600,$00A8
            dc.w    $204F,$1169,$0028,$0031,$4268,$0032,$4228,$0030
            dc.w    $317C,$0003,$0028,$317C,$0001,$002A,$317C,$0001
            dc.w    $002C,$317C,$0019,$002E,$4228,$0034,$7015,$A06E
            dc.w    $117C,$0040,$0032,$7006,$A06E,$117C,$0080,$0032
            dc.w    $7005,$A06E,$661C,$2050,$2748,$0020,$5448,$4A18
            dc.w    $66FC,$5248,$2008,$0280,$FFFF,$FFFE,$2740,$000C
            dc.w    $603C,$700C,$0640,$0100,$A71E,$663A,$2748,$0020
            dc.w    $2748,$000C,$317C,$0019,$0002,$317C,$0001,$0006
            dc.w    $317C,$0100,$0008,$317C,$0008,$000A,$41E8,$000C
            dc.w    $303C,$00FF,$7200,$10C1,$5241,$51C8,$FFFA,$4FEF
            dc.w    $0038,$7000
.L2:
            rts
            movea.l ($14,A1),A0
            _DisposHandle
            lea     ($38,SP),SP
            moveq   #-$17,D0
            bra.b   .L2
            move.l  A0,-(SP)
            move.l  A1,D0
            _StripAddress
            movea.l D0,A1
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            move.l  ($1C,A0),D0
            _StripAddress
            movea.l D0,A2
            move.w  ($1A,A0),D0
            cmpi.w  #9,D0
            bhi.b   .L4
            move.w  .L3(PC,D0.w*2),D0
            jmp     .L3(PC,D0.w)
.L3:
            dc.w    .L7-.L3
            dc.w    .L5-.L3
            dc.w    .L8-.L3
            dc.w    .L12-.L3
            dc.w    SetGamma-.L3
            dc.w    SetGamma.L13-.L3
            dc.w    SetGamma.L17-.L3
            dc.w    sub_40896BDE-.L3
            dc.w    sub_40896C78-.L3
            dc.w    sub_40896C78.L1-.L3
.L4:
            moveq   #-$11,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movea.l (SP)+,A0
            bra.w   sub_40896C78.L22
.L7:
            move.w  #$80,(A2)
            move.w  #$80,(A3)
            move.w  #1,D1
            moveq   #0,D4
            move.w  D4,(6,A2)
            bsr.w   sub_40896FF8
            bsr.w   JMFBSetPage
            move.l  (4,A3),(8,A2)
            bsr.w   GrayScreen_JMFBDriver
            bra.b   .L5
.L8:
            move.w  (A2),D1
            bsr.w   sub_40896EF8
            bne.b   .L4
            move.w  (6,A2),D0
            move.w  D0,D4
            bsr.w   ChkPage_JMFBDriver
            bne.b   .L4
            move.w  (A2),D2
            cmp.w   (A3),D2
            beq.b   .L11
            move.w  (A2),(A3)
            movea.l ($C,A3),A0
            move.w  (4,A0),D3
            move.w  (8,A0),D2
            lsr.w   #1,D2
            lea     ($C,A0),A0
            adda.w  D3,A0
            move.b  (0,A0,D2.w),D3
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L9
            ori     #$200,SR
            andi    #$FAFF,SR
.L9:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D2
.L10:
            move.l  D3,(A0)
            move.l  D3,(A0)
            move.l  D3,(A0)
            dbra    D2,.L10
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bsr.w   sub_40896FF8
.L11:
            bsr.w   JMFBSetPage
            move.l  (4,A3),(8,A2)
            bra.w   .L5
.L12:
            move.l  (A2),D0
            beq.w   .L4
            btst    #$A,($10,A3)
            bne.w   .L4
SetEntCom:
            movem.l D4-D7/A4-A6,-(SP)
            move.w  ($10,A3),D5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L1
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L1:
            move.w  (A3),D1
            subi.w  #$80,D1
            lea     JMFBDRVR.L1,A3
            moveq   #0,D6
            move.b  (0,A3,D1.w),D6
            move.w  (6,A2),D3
            cmp.w   D6,D3
            bhi.w   .L13
            move.w  (4,A2),D0
            addq.w  #1,D0
            bmi.w   .L13
            move.l  SP,D1
            move.l  D1,D0
            neg.w   D0
            andi.w  #3,D0
            beq.b   .L2
            suba.w  D0,SP
.L2:
            move.l  D1,-(SP)
            move.l  D3,D4
            addq.w  #1,D4
            asl.w   #2,D4
            suba.w  D4,SP
            movea.l SP,A0
            move.l  (A2),D0
            _StripAddress
            movea.l D0,A3
.L3:
            bsr.w   GetGammaCSpec
            move.l  D2,(A0)+
            dbra    D3,.L3
            move.w  (6,A2),D3
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D1
            move    SR,D6
            moveq   #7,D0
            ror.w   #8,D6
            and.b   D6,D0
            rol.w   #8,D6
            subq.w  #2,D0
            bge.b   .L4
            ori     #$200,SR
            andi    #$FAFF,SR
.L4:
            bsr.w   WaitVSync_JMFBDriver
            movea.l ($18,A3),A3
            adda.l  #$200204,A3
            move.w  (4,A2),D7
            bpl.b   .L8
.L5:
            move.l  (SP)+,D2
            move.l  D2,(-4,A3)
            lsr.l   #8,D2
            btst    #$C,D5
            beq.b   .L6
            clr.l   (A3)
            clr.l   (A3)
            move.l  D2,(A3)
            bra.b   .L7
.L6:
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
.L7:
            dbra    D3,.L5
            bra.b   .L12
.L8:
            move.l  D7,(-4,A3)
.L9:
            move.l  (SP)+,D2
            lsr.l   #8,D2
            btst    #$C,D5
            beq.b   .L10
            clr.l   (A3)
            clr.l   (A3)
            move.l  D2,(A3)
            bra.b   .L11
.L10:
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
            lsr.l   #8,D2
            move.l  D2,(A3)
.L11:
            dbra    D3,.L9
.L12:
            move.w  D1,D0
            _SwapMMUMode
            move    D6,SR
            movea.l (SP)+,SP
            movem.l (SP)+,D4-D7/A4-A6
            bra.w   JMFBDRVR.L5
.L13:
            movem.l (SP)+,D4-D7/A4-A6
            bra.w   JMFBDRVR.L4
GetGammaCSpec:
            move.l  D3,-(SP)
            move.w  (A3)+,D3
            move.w  (A3)+,D0
            move.w  (A3)+,D1
            move.w  (A3)+,D2
            tst.w   D5
            bpl.b   .L1
            btst    #$A,D5
            bne.b   .L1
            mulu.w  #$4CCC,D0
            mulu.w  #$970A,D1
            mulu.w  #$1C29,D2
            add.l   D1,D0
            add.l   D2,D0
            bfextu  D0{0:D7},D1
            move.w  D1,D0
            move.w  D1,D2
            bra.b   .L2
.L1:
            bfextu  D0{16:D7},D0
            bfextu  D1{16:D7},D1
            bfextu  D2{16:D7},D2
.L2:
            move.b  (0,A6,D2.w),D2
            lsl.l   #8,D2
            move.b  (0,A5,D1.w),D2
            lsl.l   #8,D2
            move.b  (0,A4,D0.w),D2
            lsl.l   #8,D2
            move.b  D3,D2
            move.l  (SP)+,D3
            rts
SetGamma:
            move.l  (A2),D0
            beq.w   .L6
            movea.l D0,A2
            tst.w   (A2)
            bne.w   JMFBDRVR.L4
            cmpi.w  #6,($1C,A3)
            bne.b   .L1
            tst.w   (2,A2)
            beq.b   .L2
.L1:
            cmpi.w  #$19,(2,A2)
            bne.w   JMFBDRVR.L4
            tst.w   (4,A2)
            beq.b   .L2
            move.w  ($C,A2),D0
            cmp.w   ($16,A3),D0
            beq.b   .L2
            addq.w  #1,D0
            bne.w   JMFBDRVR.L4
.L2:
            movea.l ($C,A3),A0
            move.w  (4,A2),D0
            cmp.w   (4,A0),D0
            bne.b   .L3
            move.w  (6,A2),D0
            cmp.w   (6,A0),D0
            beq.b   .L4
            bgt.b   .L3
            movea.l ($20,A3),A0
            _DisposPtr
            clr.l   ($20,A3)
.L3:
            move.w  (8,A2),D0
            mulu.w  (6,A2),D0
            add.w   (4,A2),D0
            addi.w  #$C,D0
            _NewPtrSys
            bne.w   JMFBDRVR.L4
            move.l  ($20,A3),D0
            move.l  A0,($C,A3)
            tst.l   D0
            beq.b   .L4
            movea.l D0,A0
            _DisposPtr
            movea.l ($C,A3),A0
            move.l  A0,($20,A3)
.L4:
            move.w  (6,A2),D0
            move.w  (4,A2),D1
            move.w  (8,A2),D2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            mulu.w  D0,D2
            add.w   D1,D2
            subq.w  #1,D2
.L5:
            move.b  (A2)+,D0
            move.b  D0,(A0)+
            dbra    D2,.L5
            bra.b   .L9
.L6:
            movea.l ($C,A3),A0
            move.w  (4,A0),D0
            move.w  (6,A0),D2
            subq.w  #1,D2
            lea     ($C,A0),A0
            adda.w  D0,A0
.L7:
            move.w  #$FF,D0
.L8:
            move.b  D0,(A0)
            not.b   (A0)+
            dbra    D0,.L8
            dbra    D2,.L7
.L9:
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L10
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L10:
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L11
            ori     #$200,SR
            andi    #$FAFF,SR
.L11:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D0
            moveq   #0,D1
.L12:
            move.b  (0,A4,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A5,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A6,D1.w),D2
            move.l  D2,(A0)
            addq.w  #1,D1
            dbra    D0,.L12
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bra.w   JMFBDRVR.L5
.L13:
            move.w  (A3),D1
            move.w  D1,(A2)
            bsr.w   sub_40896EF8
            bne.w   JMFBDRVR.L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_JMFBDriver
            bne.w   JMFBDRVR.L4
            bsr.w   GrayScreen_JMFBDriver
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L5
            movea.l ($C,A3),A0
            lea     ($C,A0),A4
            adda.w  (4,A0),A4
            movea.l A4,A5
            movea.l A4,A6
            move.w  ($A,A0),D7
            cmpi.w  #1,(6,A0)
            beq.b   .L14
            move.w  (8,A0),D0
            move.w  D7,D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L14:
            movea.l ($18,A3),A0
            adda.l  #$200204,A0
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L15
            ori     #$200,SR
            andi    #$FAFF,SR
.L15:
            bsr.w   WaitVSync_JMFBDriver
            clr.l   (-4,A0)
            move.w  #$FF,D0
            moveq   #0,D1
.L16:
            move.b  (0,A4,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A5,D1.w),D2
            move.l  D2,(A0)
            move.b  (0,A6,D1.w),D2
            move.l  D2,(A0)
            addq.w  #1,D1
            dbra    D0,.L16
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
            bra.w   JMFBDRVR.L5
.L17:
            btst    #$C,($10,A3)
            beq.b   .L18
            move.b  #1,(A2)
.L18:
            moveq   #0,D1
            bsr.b   sub_40896BD4
            bra.w   JMFBDRVR.L5
sub_40896BD4:
            move.b  (A2),D0
            bfins   D0,($10,A3){D1:1}
            rts
sub_40896BDE:
            moveq   #1,D1
            bsr.b   sub_40896BD4
            bne.b   .L1
            bsr.b   EnableVGuts_JMFBDriver
            bne.w   JMFBDRVR.L4
            bra.w   JMFBDRVR.L5
.L1:
            bsr.b   DisableVGuts_JMFBDriver
            bra.w   JMFBDRVR.L5
DisableVGuts_JMFBDriver:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D3
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            clr.w   D0
            move.b  ($28,A1),D0
            movea.l ($18,A3),A0
            adda.l  #$20013C,A0
            move.l  #7,(A0)
            move.w  D3,D0
            _SwapMMUMode
            movea.l (8,A3),A0
            _SIntRemove
            move    (SP)+,SR
            rts
EnableVGuts_JMFBDriver:
            movea.l (8,A3),A0
            lea     BeginIH,A2
            move.l  A2,D0
            _StripAddress
            movea.l D0,A2
            move.w  #6,(4,A0)
            move.l  A2,(8,A0)
            movea.l ($18,A3),A2
            adda.l  #$200148,A2
            move.l  A2,($C,A0)
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntInstall
            bne.b   .L1
            adda.w  #$FFF4,A2
            moveq   #1,D0
            _SwapMMUMode
            move.l  #5,(A2)
            _SwapMMUMode
            cmp.w   D1,D1
            rts
.L1:
            moveq   #1,D0
            rts
sub_40896C78:
            move.l  (A2),D0
            beq.w   JMFBDRVR.L4
            btst    #$A,($10,A3)
            beq.w   JMFBDRVR.L4
            bra.w   SetEntCom
.L1:
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  ($28,A1),($31,A0)
            clr.b   ($33,A0)
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (A2),(3,SP)
            move.l  SP,(4,A0)
            _sPutPRAMRec
            lea     ($40,SP),SP
            bra.w   JMFBDRVR.L5
            move.l  A1,D0
            _StripAddress
            movea.l D0,A1
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            bsr.w   DisableVGuts_JMFBDriver
            movea.l ($20,A3),A0
            _DisposPtr
            movea.l ($14,A1),A0
            _DisposHandle
            movea.l (8,A3),A0
            _DisposPtr
            moveq   #0,D0
            rts
            move.l  A0,-(SP)
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #9,D0
            bhi.b   .L3
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L3-.L2
            dc.w    .L3-.L2
            dc.w    .L6-.L2
            dc.w    .L7-.L2
            dc.w    .L12-.L2
            dc.w    .L15-.L2
            dc.w    .L17-.L2
            dc.w    .L19-.L2
            dc.w    .L20-.L2
            dc.w    .L21-.L2
.L3:
            moveq   #-$12,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            movea.l (SP)+,A0
            bra.w   .L22
.L6:
            move.w  (A3),(A2)
            move.w  (2,A3),(6,A2)
            move.l  (4,A3),(8,A2)
            bra.b   .L4
.L7:
            move.l  (A2),D0
            beq.b   .L3
            _StripAddress
            movea.l D0,A0
            move.w  (A3),D1
            subi.w  #$80,D1
            lea     JMFBDRVR.L1,A3
            moveq   #0,D3
            move.b  (0,A3,D1.w),D3
            move.w  (6,A2),D4
            tst.w   D4
            bmi.b   .L3
            cmp.w   D3,D4
            bhi.b   .L3
            move.w  D4,D2
            cmpi.w  #$FFFF,(4,A2)
            beq.b   .L9
            move.w  D4,D1
            add.w   (4,A2),D2
.L8:
            move.w  D2,(0,A0,D1.w*8)
            subq.w  #1,D2
            dbra    D1,.L8
.L9:
            movea.l ($14,A1),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            movea.l ($18,A3),A3
            adda.l  #$200204,A3
            moveq   #1,D0
            _SwapMMUMode
.L10:
            move.w  (A0),D1
            cmp.w   D3,D1
            bhi.b   .L11
            move.l  D1,(-4,A3)
            move.l  (A3),D1
            move.b  D1,(2,A0)
            move.b  D1,(3,A0)
            move.l  (A3),D1
            move.b  D1,(4,A0)
            move.b  D1,(5,A0)
            move.l  (A3),D1
            move.b  D1,(6,A0)
            move.b  D1,(7,A0)
.L11:
            addq.l  #8,A0
            dbra    D4,.L10
            _SwapMMUMode
            bra.w   .L4
.L12:
            move.w  (A2),D1
            move.w  D1,D2
            bsr.w   sub_40896EF8
            bne.w   .L3
            subi.w  #$80,D2
            movea.l ($12,A3),A0
            btst    #$D,($10,A3)
            bne.b   .L13
            move.b  (-$16,A0,D2.w),D1
            ext.w   D1
            bra.b   .L14
.L13:
            move.b  (-$11,A0,D2.w),D1
            ext.w   D1
.L14:
            addq.w  #1,D1
            move.w  D1,(6,A2)
            bra.w   .L4
.L15:
            move.w  (A3),D1
            move.w  D1,(A2)
            bsr.w   sub_40896EF8
            move.w  (6,A2),D0
            bsr.w   ChkPage_JMFBDriver
            bne.w   .L3
            move.w  (A3),D1
            subi.w  #$80,D1
            movea.l ($12,A3),A0
            mulu.w  (-$C,A0,D1.w*2),D0
            mulu.w  (-2,A0),D0
            move.l  D0,D1
            bsr.w   sub_40897218
            add.l   D1,D0
            add.l   ($18,A3),D0
            btst    #8,($10,A3)
            bne.b   .L16
            bfextu  D0{4:4},D1
            bfins   D1,D0{8:4}
.L16:
            move.l  D0,(8,A2)
            bra.w   .L4
.L17:
            moveq   #0,D1
.L18:
            bfextu  ($10,A3){D1:1},D0
            move.b  D0,(A2)
            bra.w   .L4
.L19:
            moveq   #1,D1
            bra.b   .L18
.L20:
            move.l  ($C,A3),(A2)
            bra.w   .L4
.L21:
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  ($28,A1),($31,A0)
            clr.b   ($33,A0)
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (3,SP),(A2)
            lea     ($40,SP),SP
            bra.w   .L4
.L22:
            btst    #9,(6,A0)
            beq.b   .L23
            rts
.L23:
            movea.l JIODone,A0
            jmp     (A0)
            movem.l D2-D6,-(SP)
            clr.w   D0
            moveq   #9,D5
            moveq   #4,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D0
            lsl.b   #2,D0
            moveq   #2,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D6
            andi.b  #1,D6
            lsr.b   #1,D2
            or.b    D6,D2
            or.b    D2,D0
            lsl.b   #2,D0
            moveq   #1,D3
            lsl.l   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            lsr.l   #1,D2
            or.b    D2,D0
            movem.l (SP)+,D2-D6
            rts
sub_40896EF8:
            subi.w  #$80,D1
            bmi.b   .L5
            cmpi.w  #4,D1
            bgt.b   .L5
            bclr    #$A,($10,A3)
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            cmpi.w  #4,D1
            ble.b   .L4
            btst    #$D,($10,A3)
            bne.b   .L2
            cmpi.w  #8,D1
            beq.b   .L4
            btst    #9,($10,A3)
            bne.b   .L5
            btst    #8,($10,A3)
            beq.b   .L5
            btst    #$D,($1E,A3)
            beq.b   .L1
            btst    #$F,($1E,A3)
            beq.b   .L5
.L1:
            bset    #$A,($10,A3)
            bra.b   .L4
.L2:
            btst    #9,($10,A3)
            bne.b   .L5
            btst    #$D,($1E,A3)
            beq.b   .L3
            btst    #$F,($1E,A3)
            beq.b   .L5
.L3:
            cmpi.w  #8,D1
            bne.b   .L5
.L4:
            cmp.w   D1,D1
            bra.b   .L6
.L5:
            st      D1
            tst.b   D1
.L6:
            rts
ChkPage_JMFBDriver:
            movem.l D2-D3/A0-A1,-(SP)
            tst.w   D0
            bmi.b   .L3
            moveq   #0,D3
            move.w  (A2),D2
            subi.w  #$80,D2
            movea.l ($12,A3),A1
            btst    #$D,($10,A3)
            bne.b   .L1
            move.b  (-$16,A1,D2.w),D3
            ext.w   D3
            cmp.w   D3,D0
            bra.b   .L2
.L1:
            move.b  (-$11,A1,D2.w),D3
            ext.w   D3
            cmp.w   D3,D0
.L2:
            sgt     D2
            tst.b   D2
            bra.b   .L4
.L3:
            st      D2
            tst.b   D2
.L4:
            movem.l (SP)+,D2-D3/A0-A1
            rts
WaitVSync_JMFBDriver:
            movem.l D0/A0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            movea.l ($18,A3),A0
            adda.l  #$2001C0,A0
.L2:
            bfextu  (A0){29:1},D0
            cmpi.b  #1,D0
            bne.b   .L2
.L3:
            bfextu  (A0){29:1},D0
            cmpi.b  #0,D0
            bne.b   .L3
.L4:
            bfextu  (A0){29:1},D0
            cmpi.b  #1,D0
            bne.b   .L4
            move    (SP)+,SR
            movem.l (SP)+,D0/A0
            rts
sub_40896FF8:
            movem.l D0-D2/A0-A4,-(SP)
            cmpi.w  #$10,D1
            bgt.w   .L16
            move.w  (A2),(A3)
            movea.l ($12,A3),A0
            cmpi.w  #1,D1
            beq.b   .L4
            cmpi.w  #2,D1
            beq.b   .L3
            cmpi.w  #4,D1
            beq.b   .L2
            cmpi.w  #8,D1
            beq.b   .L1
            adda.w  #$A0,A0
            bra.b   .L4
.L1:
            adda.w  #$78,A0
            bra.b   .L4
.L2:
            adda.w  #$50,A0
            bra.b   .L4
.L3:
            adda.w  #$28,A0
.L4:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.w  #2,D0
            bge.b   .L5
            ori     #$200,SR
            andi    #$FAFF,SR
.L5:
            bsr.w   WaitVSync_JMFBDriver
            btst    #$E,($1E,A3)
            beq.b   .L6
            move.w  (A3),D2
            subi.w  #$80,D2
            mulu.w  #$16,D2
            adda.l  D2,A0
.L6:
            movea.l ($18,A3),A1
            move.w  ($1E,A3),D2
            movea.l A3,A4
            movea.l A1,A3
            adda.l  #$200208,A1
            moveq   #0,D0
            move.w  (A0)+,D0
            move.l  D0,(A1)
            movea.l A3,A1
            adda.l  #$200000,A1
            movea.l A1,A2
            move.w  #2,D1
            moveq   #0,D0
            move.w  (A0)+,D0
            btst    #$C,($1E,A4)
            bne.b   .L7
            ori.w   #$2000,D0
.L7:
            move.l  D0,(A1)+
.L8:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L8
            movea.l A3,A1
            adda.l  #$200300,A1
            btst    #$E,D2
            beq.b   .L12
            btst    #$C,($1E,A4)
            bne.b   .L10
            move.w  #2,D1
            moveq   #0,D0
.L9:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L9
            adda.w  #$10,A0
            bra.b   .L12
.L10:
            addq.l  #6,A0
            move.w  #$F,D1
            moveq   #0,D0
.L11:
            move.b  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L11
.L12:
            adda.w  #0,A2
            btst    #$C,($1E,A4)
            bne.b   .L13
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$2000,D1
            move.l  D1,(A2)
.L13:
            move.w  #5,D1
.L14:
            dbra    D1,.L14
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$8000,D1
            move.l  D1,(A2)
            movea.l A3,A1
            adda.l  #$200100,A1
            move.w  #$E,D1
            moveq   #0,D0
.L15:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L15
            move.l  #4,(A1)
            move.l  #5,(A1)
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #8,D1
            move.l  D1,(A2)
            movea.l A4,A3
            bsr.w   WaitVSync_JMFBDriver
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$40,D1
            move.l  D1,(A2)
            move    (SP)+,SR
            move.w  (SP)+,D0
            _SwapMMUMode
.L16:
            movem.l (SP)+,D0-D2/A0-A4
            rts
JMFBSetPage:
            movem.l D0-D5/A0,-(SP)
            move.w  D4,(2,A3)
            move.w  (A3),D1
            subi.w  #$80,D1
            movea.l ($12,A3),A0
            move.w  (-$C,A0,D1.w*2),D2
            mulu.w  D2,D4
            mulu.w  (-2,A0),D4
            bsr.w   sub_40897218
            add.l   D0,D4
            move.l  D4,D5
            moveq   #1,D0
            _SwapMMUMode
            btst    #$B,($10,A3)
            beq.b   .L6
            btst    #$D,($10,A3)
            beq.b   .L1
            subi.l  #$400,D4
            bra.b   .L2
.L1:
            cmpi.b  #3,D1
            bgt.b   .L4
            subi.l  #$1400,D4
.L2:
            movea.l ($18,A3),A0
            addi.w  #$2000,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L3:
            move.l  #$FFFFFFFF,(A0)+
            dbra    D2,.L3
            bra.b   .L6
.L4:
            subi.l  #$A00,D4
            movea.l ($18,A3),A0
            addi.w  #$A00,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L5:
            clr.l   (A0)+
            dbra    D2,.L5
.L6:
            add.l   ($18,A3),D5
            btst    #8,($10,A3)
            bne.b   .L7
            bfextu  D5{4:4},D3
            bfins   D3,D5{8:4}
.L7:
            move.l  D5,(4,A3)
            movea.l ($18,A3),A0
            adda.l  #$200000,A0
            addq.l  #8,A0
            cmpi.b  #3,D1
            ble.b   .L8
            asr.l   #2,D4
            dc.w    $4C3C,$4004,0,$0003,$E28C
.L8:
            lsr.l   #5,D4
            move.l  D4,(A0)
            _SwapMMUMode
            movem.l (SP)+,D0-D5/A0
            rts
sub_40897218:
            btst    #$B,($10,A3)
            bne.b   .L2
            btst    #9,($10,A3)
            beq.b   .L1
            move.l  #$80,D0
            bra.b   .L4
.L1:
            move.l  #$A00,D0
            bra.b   .L4
.L2:
            cmpi.w  #$83,(A3)
            bgt.b   .L3
            move.l  #$2000,D0
            bra.b   .L4
.L3:
            move.l  #$A00,D0
.L4:
            rts
GrayScreen_JMFBDriver:
            movem.l D0-D6/A0-A1,-(SP)
            move.w  (A3),D1
            subi.w  #$80,D1
            move.w  D1,D3
            lea     .L13,A1
            move.l  (0,A1,D3.w*4),D5
            movea.l ($12,A3),A1
            move.w  (-$C,A1,D1.w*2),D4
            move.w  (-2,A1),D3
            subq.w  #1,D3
            movea.l (4,A3),A1
            btst    #8,($10,A3)
            bne.b   .L1
            move.l  A1,D0
            andi.l  #$FF0FFFFF,D0
            movea.l D0,A1
.L1:
            moveq   #1,D0
            _SwapMMUMode
            cmpi.b  #4,D1
            beq.b   .L7
.L2:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            move.w  D2,D7
            subq.w  #1,D2
.L3:
            move.l  D5,(A0)+
            dbra    D2,.L3
            not.l   D5
            adda.w  D4,A1
            dbra    D3,.L2
            btst    #$B,($10,A3)
            beq.b   .L12
            btst    #$F,($1E,A3)
            beq.b   .L12
            move.w  D7,D2
            btst    #$D,($1E,A3)
            bne.b   .L4
            mulu.w  #$32,D2
            bra.b   .L5
.L4:
            mulu.w  #$3A,D2
.L5:
            subq.w  #1,D2
.L6:
            move.l  #$FFFFFFFF,(A0)+
            dbra    D2,.L6
            bra.b   .L12
.L7:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            move.w  D2,D7
            subq.w  #1,D2
.L8:
            move.l  D5,(A0)+
            not.l   D5
            dbra    D2,.L8
            not.l   D5
            adda.w  D4,A1
            dbra    D3,.L7
            btst    #$B,($10,A3)
            beq.b   .L12
            btst    #$F,($1E,A3)
            beq.b   .L12
            move.w  D7,D2
            btst    #$D,($1E,A3)
            bne.b   .L9
            mulu.w  #$32,D2
            bra.b   .L10
.L9:
            mulu.w  #$3A,D2
.L10:
            subq.w  #1,D2
.L11:
            clr.l   (A0)+
            dbra    D2,.L11
.L12:
            _SwapMMUMode
            movem.l (SP)+,D0-D6/A0-A1
            rts
.L13:
            dc.b    $AA,$AA,$AA,$AA,$CC,$CC,$CC,$CC,$F0,$F0,$F0,$F0,$FF,$00,$FF
            ds.b    5
BeginIH:
            movem.l D1-D2/A0-A1,-(SP)
            moveq   #1,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D1-D2/A0-A1
            move.l  D1,-(SP)
.L1:
            move.l  ($84,A1),D1
            andi.w  #8,D1
            bne.b   .L1
            move.l  (SP)+,D1
            move.l  #1,(A1)
            movem.l D1-D2/A0-A1,-(SP)
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D1-D2/A0-A1
            move.l  A1,D0
            rol.l   #8,D0
            andi.w  #$F,D0
            movea.l ($D28).w,A0
            jsr     (A0)
            moveq   #1,D0
            rts
JMFBDRVRSIZE:
            dc.w    0,$1A20
            ds.b    12

            EVEN
