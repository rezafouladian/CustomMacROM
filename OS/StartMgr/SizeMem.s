            include "Include/ROMHeader.s"

            EXPORT  SizeMemory

            IMPORT  GetHardwareInfo

            SECTION "SizeMem",CODE

SizeMemory:
            move.l  A6,D3
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l D3,A2
            moveq   #0,D3
            move.b  D2,D3
            add.w   D3,D3
            move.w  .splitTbl(PC,D3.w),D3
            jmp     .splitTbl(PC,D3.w)
.splitTbl:
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    .GlueSplit-.splitTbl
            dc.w    SizeBanks-.splitTbl
            dc.w    .FMCSplit-.splitTbl
            dc.w    .VisaSplit-.splitTbl
            dc.w    .OrwellSplit-.splitTbl
            dc.w    .JAWSSplit-.splitTbl
            dc.w    .MSCSplit-.splitTbl
.GlueSplit:
            movea.l ($2C,A0),A5
            ori.b   #$C0,($1E00,A5)
            bra.w   SizeBanks
.FMCSplit:
            movea.l ($4C,A0),A5
            move.w  #$F3EF,D2
            moveq   #$F,D3
.L4:
            move.b  D2,(A5)
            lsr.w   #1,D2
            dbra    D3,.L4
            move.b  D2,($10,A5)
            bra.w   SizeBanks
.OrwellSplit:
            movea.l ($54,A0),A5
            lea     (A5),A0
            move.l  #$30810,D3
            moveq   #$11,D2
.L6:
            move.l  D3,(A0)+
            lsr.l   #1,D3
            dbra    D2,.L6
            move.l  D2,($A0,A5)
            bra.w   SizeBanks
.VisaSplit:
            movea.l ($34,A0),A5
            ori.b   #$E0,(1,A5)
            bra.w   SizeBanks
.JAWSSplit:
            moveq   #0,D0
            movea.l ($58,A0),A5
            adda.l  #$10000,A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            bra.w   SizeBanks
.MSCSplit:
            movea.l ($6C,A0),A5
            ori.b   #$E0,(1,A5)
SizeBanks:
            movea.l A1,A5
            adda.l  (4,A5),A5
            movea.l A5,SP
            addq.l  #4,SP
            moveq   #0,D0
            moveq   #0,D5
            moveq   #0,D6
            move.l  #'Tina',D1
.SizeBank:
            ror.l   #4,D5
            ror.l   #4,D6
            movea.l (SP)+,A0
            move.l  A0,D2
            addq.l  #1,D2
            beq.b   .L13
            movea.l (SP)+,A1
            BSR6    CheckByteLanes
            moveq   #$F,D3
            and.b   D6,D3
            beq.b   .size
            cmpi.b  #$F,D3
            bne.b   .SizeBank
            eor.b   D3,D6
            bra.b   .SizeBank
.size:
            BSR6    SizeBank
            bra.b   .SizeBank
.L13:
            suba.l  A5,SP
            subq.l  #8,SP
            move.l  SP,D2
            lsr.w   #1,D2
            rol.l   D2,D5
            rol.l   D2,D6
            tst.l   D6
            beq.b   Concat
            jmp     (A2)
SizeBank:
            move.l  A0,D4
            subq.l  #4,A1
.L15:
            move.l  (A1),D2
            move.l  D1,(A1)
            cmp.l   (A1),D1
            beq.b   .L16
            suba.l  (A5),A1
            cmpa.l  A0,A1
            bgt.b   .L15
            bra.b   .L20
.L16:
            subq.l  #4,A0
.L17:
            adda.l  (A5),A0
            cmp.l   (A0),D1
            bne.b   .L17
            move.l  D2,(A0)+
            suba.l  D4,A0
            moveq   #0,D3
            move.l  A0,D2
            beq.b   .L19
            move.l  (A5),D2
.L18:
            addq.w  #1,D3
            cmpa.l  D2,A0
            beq.b   .L19
            add.l   D2,D2
            bra.b   .L18
.L19:
            or.b    D3,D5
            add.l   A0,D0
.L20:
            RTS6
CheckByteLanes:
            move.l  (A0),D3
            move.l  (4,A0),D4
            move.l  D1,(A0)
            moveq   #4-1,D2
.next:
            move.l  #$FFFFFFFF,(4,A0)
            cmp.b   (0,A0,D2.w),D1
            bne.b   .bad
            not.b   D1
            not.b   (0,A0,D2.w)
            cmp.b   (0,A0,D2.w),D1
            beq.b   .shift
.bad:
            bset    D2,D6
.shift:
            ror.l   #8,D1
            dbra    D2,.next
            move.l  D3,(A0)
            move.l  D4,(4,A0)
            RTS6
Concat:
            move.l  D0,D3
            moveq   #0,D2
            movea.w #$2600,SP
            move.l  A2,D4
            BigBSR6 GetHardwareInfo,A0
            movea.l D4,A2
            adda.l  (4,A1),A1
            add.b   D2,D2
            ext.w   D2
            move.w  .mergTbl(PC,D2.w),D1
            move.l  (A1)+,D2
            jmp     .mergTbl(PC,D1.w)
.mergTbl:
            ori.b   #$16,(A6)
            ori.b   #$16,(A6)
            ori.b   #$40,(A4)+
            dc.w    $007A,$011E,$00B8,$0154,$0212,$7214,$6000,$022A
            dc.w    $720F,$C205,$6604,$5049,$E88D,$103B,$1010,$2A68
            dc.w    $002C,$C12D,$1E00,$721C,$6000,$020E,$FF3F,$FF7F
            dc.w    $FFBF,$FFFF,$9BCD,$43E9,$0010,$4A05,$6700,$0226
            dc.w    $5149,$E98D,$3205,$E049,$0201,$000F,$67EC,$4DFA
            dc.w    $0006,$4EFA,$01D6,$220D,$660E,$2A51,$DBC0,$42A5
            dc.w    $42A5,$2B3C,$FFFF,$FFFF,$2B00,$2B11,$60CC,$323C
            dc.w    $F3EF,$0800,$0014,$6704,$323C,$F3FF,$3001,$720F
            dc.w    $C205,$6604,$5049,$E88D,$C03B,$101A,$2A68,$004C
            dc.w    $720F,$1A80,$E248,$51C9,$FFFA,$50ED,$0010,$721C
            dc.w    $6000,$0196,$FFFF,$FF3F,$7FBF,$FFFF,$3205,$4845
            dc.w    $3A01,$2C09,$97CB,$7600,$6032,$2203,$5381,$4C3C
            dc.w    $1001,0,$0006,$2A68,$0054,$4BF5,$1400,$220B
            dc.w    $7816,$E8A9,$383C,$0005,$2AC1,$E289,$51CC,$FFFA
            dc.w    $2A68,$0054,$4BED,$00A0,$1ABC,$00FF,$720F,$C205
            dc.w    $E88D,$4DFA,$0006,$4EFA,$0132,$D7C0,$4AA9,$0008
            dc.w    $6B06,$5089,$5283,$60B2,$722C,$260B,$2246,$6000
            dc.w    $0128,$1205,$E809,$4DFA,$0006,$4EFA,$010E,$2200
            dc.w    $70DF,$0C81,$0010,0,$6702,$70FF,$720F,$C205
            dc.w    $C03B,$1010,$2A68,$0034,$C12D,$0001,$721C,$6000
            dc.w    $00F8,$3FFF,$7FBF,$FF00,$7800,$7203,$BA81,$6604
            dc.w    $7800,$6020,$4841,$BA81,$6604,$7820,$6016,$4DFA
            dc.w    $0006,$4EFA,$0036,$4DFA,$0006,$4EFA,$002E,$700D
            dc.w    $E16C,$E0AC,$103B,$4050,$2A68,$0058,$DBFC,$0001
            dc.w    0,$1A80,$E408,$4BED,$2000,$1A80,$E408,$4BED
            dc.w    $2000,$1A80,$724C,$6000,$00A0,$2A4E,$7203,$4841
            dc.w    $323C,$000F,$E99D,$C205,$4DFA,$0006,$4EFA,$007C
            dc.w    $D880,$4841,$51C9,$FFE8,$4844,$E84C,$0C04,$0008
            dc.w    $6602,$5304,$4ED5,$0001,$0102
            ds.b    4
            dc.w    $1F13,$030A,$0900,$0608,$1F07,$0312,$0900,$0608
            dc.b    $1D,$04,$04,$19,$11,$00,$0E,$18,$17,$09,$05,$0F,$1B,$00,$16
            ds.b    9
            dc.w    $170B,$0B0C,$1400,$1A00,$170D,$0D15,$1700,$1700
            dc.w    $2205,$0281,$000F,0,$6614,$7015,$E0AB,$5343
            dc.w    $EB0B,$0003,$001F,$2A68,$006C,$C72D,$0001,$7234
            dc.w    $6000,$0010
expandSize:
            moveq   #0,D0
            tst.w   D1
            beq.b   .exit
            move.l  D2,D0
            subq.w  #1,D1
            lsl.l   D1,D0
.exit:
            RTS6
writeChunkTable:
            movea.l (A1),A5
            movea.l A5,A0
            adda.l  D3,A5
            suba.l  D1,A5
            movea.l A5,SP
.loop:
            moveq   #$F,D1
            and.b   D5,D1
            beq.b   .next
            BSR6    expandSize
            move.l  A0,(SP)+
            move.l  D0,(SP)+
            adda.l  D0,A0
.next:
            lsr.l   #4,D5
            bne.b   .loop
            subq.l  #1,D5
            move.l  D5,(SP)+
.fill:
            clr.l   (SP)+
            move.w  SP,D0
            bne.b   .fill
            movea.l (A1),SP
            adda.l  #$8000,SP
            move.l  A5,-(SP)
            moveq   #0,D6
            jmp     (A2)
            ds.b    14

            EVEN
