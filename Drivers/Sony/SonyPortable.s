sub_40870722:
            move.b  ($33,A1),($1C2,A1)
            subq.b  #2,($1C2,A1)
            bra.w   sub_4087091A
sub_40870730:
            tst.b   ($1000,A0)
            bra.w   sub_408708C8
sub_40870738:
            addq.w  #2,A5
            addq.w  #2,A6
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            moveq   #2,D0
            and.b   ($13A,A1),D0
            bne.b   .L1
            lea     .L2,A5
.L1:
            rts
.L2:
            dc.w    0
sub_40870754:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            bsr.w   sub_408708E4
            bsr.w   sub_4087091A
.L1:
            tst.b   ($138,A1)
            bpl.b   .L2
            bsr.w   SetChipMode
.L2:
            bsr.w   sub_4086D716
            rts
sub_40870774:
            move.l  A0,-(SP)
            lea     (8,SP),A0
            move.l  A0,($1C,A1)
            movea.l (SP)+,A0
            bra.w   sub_408708E4
IconAddrTail:
            ext.l   D0
            add.l   A3,D0
            bra.w   CtlParam
            lea     ($118,A2),A0
            _RmvTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            lea     ($13C,A2),A0
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Dequeue
.L1:
            rts
            move.l  A0,SonyVars
            movea.l A0,A1
            bra.w   sub_408708E4
            lea     ($118,A2),A0
            _InsTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            lea     ($13C,A2),A0
            clr.w   ($A,A0)
            move.w  #$10,(4,A0)
            lea     sub_40870938,A1
            move.l  A1,(6,A0)
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Enqueue
.L2:
            rts
            bsr.w   sub_408708C8
            clr.b   ($19,A1)
            rts
sub_408707EE:
            move.l  A0,-(SP)
            lea     (8,SP),A0
            move.l  A0,($1C,A1)
            movea.l (SP)+,A0
            bra.w   sub_408708E4
sub_408707FE:
            bmi.w   DskRWOff.L9
            bra.w   sub_408708E4
.L1:
            tst.b   ($13,A1,D1.w)
            bpl.b   .L3
            subq.w  #1,D7
.L2:
            moveq   #4,D0
            bsr.w   AdrAndSense
            bpl.w   jtRecal.L3
            bsr.w   Pulse
            bsr.w   Wait100
            dbra    D7,.L2
            bra.w   jtRecal.L4
.L3:
            move.w  ($3C,A1),D0
            bsr.w   WakeUp_SonyRWT
            bra.w   jtRecal.L2
sub_40870834:
            move.w  ($40,A1),($A,A0)
            bra.w   sub_408708E4
sub_4087083E:
            tst.b   ($1000,A0)
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            tst.l   D3
            bmi.w   .L1
            bra.b   sub_408708C8
.L1:
            addq.l  #4,SP
            bra.w   sub_4086D7FA.L4
.L2:
            rts
.L3:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L4
            addq.b  #1,(3,A1,D1.w)
            bpl.w   sub_4086D848.L2
            bset    #$1F,D3
            bra.w   sub_4086D848.L7
.L4:
            addq.b  #1,(3,A1,D1.w)
            bmi.w   sub_4086D848.L7
            bra.w   sub_4086D848.L2
sub_4087087E:
            st      ($19,A0)
            movea.l A0,A1
            bra.b   sub_408708E4
sub_40870886:
            lea     ($118,A2),A0
            _InsTime
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            lea     ($13C,A2),A0
            clr.w   ($A,A0)
            move.w  #$10,(4,A0)
            lea     sub_40870938,A1
            move.l  A1,(6,A0)
            _SleepQInstall
.L1:
            rts
sub_408708AE:
            clr.b   ($19,A1)
            bra.b   sub_408708C8
.L1:
            clr.b   ($19,A1)
            movea.l (A1),A1
            move.l  JIODone,-(SP)
            rts
sub_408708C0:
            bsr.b   sub_408708E4
            tst.b   (3,A1,D1.w)
            rts
sub_408708C8:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   sub_408708E4.L3
            movem.l D0/A0,-(SP)
            moveq   #1,D0
            and.b   ($13A,A1),D0
            beq.b   sub_408708E4.L2
            clr.b   ($13A,A1)
            moveq   #1,D0
            bra.b   sub_408708E4.L1
sub_408708E4:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L3
            movem.l D0/A0,-(SP)
            moveq   #1,D0
            and.b   ($13A,A1),D0
            bne.b   .L2
            move.w  #$81,D0
            move.b  D0,($13A,A1)
.L1:
            move.b  D0,-(SP)
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.l  #$100001,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($E,SP),SP
.L2:
            movem.l (SP)+,D0/A0
.L3:
            rts
sub_4087091A:
            movem.l D0/A0,-(SP)
            pea     ($13A,A1)
            move.l  (SP),-(SP)
            move.l  #$180000,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($C,SP),SP
            movem.l (SP)+,D0/A0
            rts
sub_40870938:
            movem.l D1/A0-A1,-(SP)
            movea.l SonyVars,A1
            cmpi.w  #3,D0
            beq.b   .L2
            moveq   #$5A,D1
            add.l   Ticks,D1
.L1:
            cmp.l   Ticks,D1
            bls.b   .L3
            moveq   #1,D0
            and.b   ($13A,A1),D0
            bne.b   .L1
            bra.b   .L3
.L2:
            moveq   #1,D1
            and.b   ($13A,A1),D1
            bsr.b   sub_408708E4
            movea.l IWM,A0
            move.b  #$F8,($C00,A0)
            tst.b   ($1C00,A0)
            clr.b   ($139,A1)
            bsr.w   SetIWMMode
            tst.b   D1
            beq.b   .L4
            bsr.w   SetChipMode
.L3:
            movem.l (SP)+,D1/A0-A1
            rts
.L4:
            bsr.w   sub_408708C8
            bra.b   .L3
            dc.w    $CFA2,$0078,$0003,$CFA2,$017A,$0103,$CFA2,$CFA2
            dc.w    $0507,$CFA2,$CFA2,$0D07,$CF8A,$0366,$0003,$CF8A
            dc.w    $0264,$0803,$CF8A,$CF8A,$0507,$CF8A,$CF8A,$0D07
            dc.w    $CF72,$0450,$0003,$CF72,$0450,$0103,$CF72,$CF72
            dc.w    $0507,$CF72,$CF72,$0D07,$CF5A,$053A,$0003,$CF5A
            dc.w    $053A,$0103,$CF5A,$CF5A,$0507,$CF5A,$CF5A,$0D07
            dc.w    $CF42,$0624,$0003,$CF42,$0624,$0103,$CF42,$CF42
            dc.w    $0507,$CF42,$CF42,$0D07
            ds.b    38
            dc.w    $0400,0,$0400,0,$0400,0,$1F00,0
            dc.b    $0E,$00,$00,$00,$04
            ds.b    5
            dc.w    $1FFF,$FFF8,$1000,$0008,$1000,$7FC8,$1000,$0008
            dc.w    $1300,$0008,$1000,$0008,$1FFF,$FFF8,$0800,$0010
            dc.w    $0FFF,$FFF0
            ds.b    66
            dc.w    $0400,0,$0400,0,$0400,0,$1F00,0
            dc.b    $0E,$00,$00,$00,$04
            ds.b    5
            dc.w    $1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8
            dc.w    $1FFF,$FFF8,$1FFF,$FFF8,$1FFF,$FFF8,$0FFF,$FFF0
            dc.w    $0FFF,$FFF0
            ds.b    81
            dc.b    $10,$00,$00,$00,$10,$00,$00,$00,$10,$FF,$FF,$FC,$7C,$80,$00,$04
            dc.b    $38,$80,$3F,$E4,$10,$80,$00,$04,$00,$A0,$00,$05,$FF,$80,$00,$05
            dc.b    $01,$FF,$FF,$FD,$7D,$40,$00,$09,$01,$7F,$FF,$F9,$FF
            ds.b    83
            dc.b    $10,$00,$00,$00,$10,$00,$00,$00,$10,$FF,$FF,$FC,$7C,$FF,$FF,$FC
            dc.b    $38,$FF,$FF,$FC,$10,$FF,$FF,$FC,$00,$FF,$FF,$FD,$FF,$FF,$FF,$FD
            dc.b    $FF,$FF,$FF,$FD,$FF,$7F,$FF,$F9,$FF,$7F,$FF,$F9,$FF
            ds.b    39
            dc.b    $80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$00,$80,$00,$00,$03
            dc.b    $E0,$00,$00,$01,$C0,$00,$00,$00,$80
            ds.b    6
            dc.w    $FFFF,$FFFF,$8000,$0001,$8FF8,$1FF1,$8000,$0001
            dc.w    $8000,$0001,$FFFF,$FFFF,$2000,$0004,$3FFF,$FFFC
            ds.b    60
            dc.w    $01C0,0,$01C0,0,$01C0,0,$01C0,0
            dc.w    $0FF8,0,$07F0,0,$03E0,0,$01C0,0
            dc.w    $0080,0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$3FFF,$FFFC
            dc.w    $3FFF,$FFFC
            ds.b    68
            dc.w    $0100,0,$0100,0,$0100,0,$0100,0
            dc.b    $07,$C0,$00,$00,$03,$80,$00,$00,$01
            ds.b    5
            dc.w    $FFFF,$FFFF,$8000,$0001,$8000,$1FF1,$8000,$0001
            dc.w    $8000,$0001,$FFFF,$FFFF,$2000,$0004,$3FFF,$FFFC
            ds.b    62
            dc.w    $0380,0,$0380,0,$0380,0,$0380,0
            dc.w    $1FF0,0,$0FE0,0,$07C0,0,$0380,0
            dc.w    $0100,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$3FFF,$FFFC,$3FFF
            dc.w    $FFFC
            ds.b    66
            dc.w    $0FFF,$F000,$0800,$1000,$08FF,$F000,$0880,$1080
            dc.w    $0880,$1180,$08BF,$D3F8,$0880,$1180,$0880,$1080
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $0880,$1000,$0880,$1000,$0880,$1000,$0880,$1000
            dc.w    $08BF,$D000,$0880,$1000,$08BF,$D000,$0880,$1000
            dc.w    $08BF,$D000,$0880,$1000,$08BF,$D000,$0880,$1000
            dc.b    $08,$BF,$D0,$00,$08,$80,$10,$00,$0F,$FF,$F0
            ds.b    5
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F080
            dc.w    $0FFF,$F180,$0FFF,$F3F8,$0FFF,$F180,$0FFF,$F080
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.w    $0FFF,$F000,$0FFF,$F000,$0FFF,$F000,$0FFF,$F000
            dc.b    $0F,$FF,$F0,$00,$0F,$FF,$F0,$00,$0F,$FF,$F0
            ds.b    58
            dc.b    $02,$00,$00,$00,$05,$00,$00,$00,$09,$00,$00,$00,$12,$00,$00,$00
            dc.b    $24,$00,$00,$00,$48,$00,$00,$00,$90,$00,$00,$01,$20,$00,$00,$02
            dc.b    $40,$00,$00,$04,$80,$00,$00,$09,$00,$00,$00,$0E,$00,$00,$00,$1C
            dc.b    $00,$00,$DB,$7E,$00,$01,$FF,$C2,$10,$7F,$00,$42,$30,$80,$3F,$42
            dc.b    $7F,$80,$00,$42,$30,$FF,$FF,$FC,$10
            ds.b    55
            dc.b    $02,$00,$00,$00,$07,$00,$00,$00,$0F,$00,$00,$00,$1E,$00,$00,$00
            dc.b    $3C,$00,$00,$00,$78,$00,$00,$00,$F0,$00,$00,$01,$E0,$00,$00,$03
            dc.b    $C0,$00,$00,$07,$80,$00,$00,$0F,$00,$00,$00,$0E,$00,$00,$00,$1C
            dc.b    $00,$00,$DB,$7E,$00,$01,$FF,$FE,$10,$7F,$FF,$FE,$30,$FF,$FF,$FE
            dc.b    $7F,$FF,$FF,$FE,$30,$FF,$FF,$FC,$10
            ds.b    18
            dc.w    $1FFF,$8000,$1000,$8000,$1000,$8000,$17A0,$8000
            dc.w    $1020,$8400,$17A0,$8C00,$1020,$9FC0,$17A0,$8C00
            dc.w    $1020,$8400,$17A6,$8000,$1026,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1780,$8000
            dc.w    $1000,$8000,$1780,$8000,$1000,$8000,$1782,$8000
            dc.b    $10,$00,$80,$00,$17,$82,$80,$00,$10,$00,$80,$00,$1F,$FF,$80
            ds.b    17
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8400,$1FFF,$8C00,$1FFF,$9FC0,$1FFF,$8C00
            dc.w    $1FFF,$8400,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    $1FFF,$8000,$1FFF,$8000,$1FFF,$8000,$1FFF,$8000
            dc.w    0
sub_40871114:
            movea.l A1,A2
            movea.l SonyVars,A1
            lea     (-$48,A1),A3
            bsr.w   CheckIfSecure
            bne.b   .L1
            moveq   #-$24,D0
            addq.w  #4,SP
            bra.w   DiskIODone
.L1:
            rts
sub_4087112E:
            movea.l SonyVars,A1
            cmpi.w  #7,($1A,A0)
            beq.b   .L1
            bsr.w   CheckIfSecure
            bne.b   .L1
            moveq   #-$24,D0
            addq.w  #4,SP
            bra.w   DiskIODone
.L1:
            movea.l (0,A1,A2.l),A2
            move.w  (A2)+,D1
            move.w  (A2)+,D0
            move.w  ($1A,A0),D2
            rts
CheckIfSecure:
            bsr.b   CheckForCabooseKeyswitch
            beq.b   .L1
            rts
.L1:
            move.l  A1,D0
            movea.l VIA2,A1
            btst    #0,(A1)
            movea.l D0,A1
            rts
sub_4087116A:
            cmpi.b  #1,D2
            bne.b   .L2
            bsr.b   CheckIfSecure
            bne.b   .L1
            bsr.w   UpdateDriveStatus
            move.b  #2,D2
            bra.b   .L2
.L1:
            moveq   #0,D0
.L2:
            rts
CheckForCabooseKeyswitch:
            move.l  D0,-(SP)
            move.l  #$C0000,D0
            and.l   UnivROMFlags,D0
            subi.l  #$40000,D0
            movem.l (SP)+,D0
            rts
            ds.b    6918
