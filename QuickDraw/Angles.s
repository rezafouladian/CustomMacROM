AngleFromSlope:
            move.l  (4,SP),D0
            smi     D2
            bpl.b   .L1
            neg.l   D0
.L1:
            subi.l  #$1F4,D0
            move.l  D0,(4,SP)
            lea     CONTINUE_Angles,A0
            moveq   #-1,D1
.L2:
            addq.w  #1,D1
            move.w  D1,D0
            clr.l   -(SP)
            bra.b   SlopeFromAngle.L3
CONTINUE_Angles:
            move.l  (8,SP),D0
            cmp.l   (SP)+,D0
            bgt.b   AngleFromSlope.L2
            move.w  #$B4,D0
            sub.w   D1,D0
            tst.b   D2
            bpl.b   .L1
            move.w  D1,D0
.L1:
            move.l  (SP)+,(SP)
            move.w  D0,(4,SP)
            rts
SlopeFromAngle:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            ext.l   D0
            divs.w  #$B4,D0
            swap    D0
            tst.w   D0
            bpl.b   .L2
.L1:
            addi.w  #$B4,D0
.L2:
            move.w  #$8000,(SP)
.L3:
            cmpi.w  #$5A,D0
            ble.b   .L4
            clr.w   (SP)
            subi.w  #$B4,D0
            neg.w   D0
.L4:
            cmpi.w  #$2D,D0
            blt.b   .L5
            addq.w  #1,(SP)
            cmpi.w  #$40,D0
            blt.b   .L5
            move.b  .L1+3(PC,D0.w),(1,SP)
            bpl.b   .L5
            ori.b   #$7F,(SP)
.L5:
            add.w   D0,D0
            move.w  .L7(PC,D0.w),(2,SP)
            bclr    #7,(SP)
            beq.b   .L6
            neg.l   (SP)
.L6:
            jmp     (A0)
            dc.w    $0102,$0202,$0202,$0202,$0203,$0303,$0304,$0404
            dc.w    $0505,$0607,$0809,$0B0E,$131C,$39FF
.L7:
            dc.w    0,$0478,$08F1,$0D6B,$11E7,$1666,$1AE8,$1F6F
            dc.w    $23FA,$288C,$2D24,$31C3,$366A,$3B1A,$3FD4,$4498
            dc.b    'IhNDS.X&]-bEgnl'
            dc.b    $AA,$71,$FB,$77,$60,$7C,$DC,$82,$70,$88,$1E,$8D,$E7,$93,$CD,$99
            dc.b    $D2,$9F,$F7,$A6,$40,$AC,$AD,$B3,$41,$B9,$FF,$C0,$E9,$C8,$02,$CF
            dc.b    $4E,$D6,$CF,$DE,$8A,$E6,$81,$EE,$B9,$F7,$37,$00,$00,$09,$19,$12
            dc.b    $87,$1C,$51,$26,$7F,$31,$17,$3C,$22,$47,$AA,$53,$B9,$60,$5B,$6D
            dc.b    $9B,$7B,$89,$8A,$35,$99,$AF,$AA,$0E,$BB,$68,$CD,$D6,$E1,$77,$F6
            dc.b    $6E,$0C,$E1,$24,$FE,$3E,$FC,$5B,$19,$79,$9F,$9A,$E7,$BF,$5B,$E7
            dc.b    $7A,$13,$E3,$45,$56,$7C,$C7,$BB,$68,$02,$C2,$54,$DB,$B4,$62,$25
            dc.b    $01,$AB,$D9,$50,$51,$1D,$88,$24,$F3,$83,$AD,$6E,$17,$4C,$F5,$14
            dc.b    $BD,$A2,$D7,$4A,$30,$FF,$FF
            ds.b    14
PtToAngle:
            link.w  A6,#0
            movem.l D6-D7/A4,-(SP)
            movea.l ($10,A6),A4
            move.w  (4,A4),D0
            add.w   (A4),D0
            asr.w   #1,D0
            move.w  ($C,A6),D1
            sub.w   D0,D1
            move.w  (6,A4),D0
            add.w   (2,A4),D0
            asr.w   #1,D0
            move.w  ($E,A6),D7
            sub.w   D0,D7
            bne.b   .L1
            tst.w   D1
            ble.b   .L2
            move.w  #$B4,D0
            bra.b   .L3
.L1:
            clr.l   -(SP)
            move.w  D7,-(SP)
            move.w  D1,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D6
            clr.l   -(SP)
            move.w  (4,A4),D0
            sub.w   (A4),D0
            move.w  D0,-(SP)
            move.w  (6,A4),D0
            sub.w   (2,A4),D0
            move.w  D0,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D6,-(SP)
            move.l  D0,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,D0
            clr.w   -(SP)
            move.l  D0,-(SP)
            jsr     ([$1110.w])
            move.w  (SP)+,D0
            tst.w   D7
            bpl.b   .L3
            addi.w  #$B4,D0
            cmpi.w  #$168,D0
            bne.b   .L3
.L2:
            clr.w   D0
.L3:
            movea.l (8,A6),A0
            move.w  D0,(A0)
            movem.l (SP)+,D6-D7/A4
            unlk    A6
            rtd     #$C
            ds.b    6
