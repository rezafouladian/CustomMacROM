            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_49

            IMPORT  BaseOfROM,RsrcEntryPACK_5

            SECTION "NetBoot",CODE

RsrcEntryDRVR_49:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 49 ".netBOOT" (1988 bytes) - Combo mask
            dc.l    RsrcEntryPACK_5-BaseOfROM       ; Next entry
            dc.l    netBOOT-BaseOfROM               ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    49                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    8,'.netBOOT'                    ; Name
            ds.b    4
            dc.l    $C0A00000,$000007D0,$000001DC   ; Block header
netBOOT:
            dc.w    $4500                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    NBOpen-netBOOT                  ; drvrOpen
            dc.w    NBRead-netBOOT                  ; drvrPrime
            dc.w    NBControl-netBOOT               ; drvrCtl
            dc.w    NBAnRTS-netBOOT                 ; drvrStatus
            dc.w    NBClose-netBOOT                 ; drvrClose
            dc.b    8,'.netBOOT'
            dc.b    $00,$02,$00
NBOpen:
            move.l  A1,-(SP)
            move.l  ($14,A1),D1
            bne.b   Xit
            movea.l A0,A2
            move.l  #$DE,D0
            _NewPtrSysClear
            bne.b   ErrXit
            move.l  A0,D1
            movea.l (SP),A1
            move.l  A0,($14,A1)
            moveq   #0,D0
            move.w  ($18,A2),D0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            jsr     sub_408522A4
            addq.l  #8,SP
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            pea     sub_40851E04
            _GetNamedResource
            move.l  (SP)+,D0
            beq.b   Xit
            movea.l D0,A1
            move.l  A3,-(SP)
            movea.l (A1),A3
            move.w  (4,SP),D0
            movea.l A1,A3
            subq.w  #1,D0
            dc.w    $A53D                           ; A-trap $A53D
            bne.b   Xit
            _HLock
            movea.l (A0),A0
            move.l  A3,(A0)+
            move.w  (A3),(A0)+
            movea.l (SP)+,A3
Xit:
            addq.w  #2,SP
            moveq   #0,D0
            addq.l  #4,SP
            rts
ErrXit:
            movea.l (SP)+,A1
            move.l  ($14,A1),D1
            beq.b   .L1
            movea.l D1,A0
            _DisposPtr
.L1:
            move.w  #$FFE9,D0
            rts
sub_40851E04:
            btst    D3,D7
            movea.l -(A1),SP
            moveq   #$42,D2
            ble.b   NBDontSkip.L2+1
            moveq   #0,D2
NBClose:
            move.l  ($14,A1),D1
            beq.b   NBAnRTS
            move.l  A1,-(SP)
            move.w  ($18,A1),D0
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            jsr     sub_40852346
            addq.l  #8,SP
            movea.l (SP)+,A1
            clr.l   ($14,A1)
            tst.l   D0
            beq.b   OkExit
            moveq   #-$18,D0
OkExit:
NBAnRTS:
            rts
NBControl:
            move.w  #$FFBF,D0
            bra.b   GoHome
NBRead:
            btst    #3,($17B).w
            beq.w   NBDontSkip
            move.w  #$FFBF,D0
            bra.w   GoHome
NBDontSkip:
            move.l  ($14,A1),D1
            beq.b   GoHome
            movem.l A0-A1,-(SP)
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  ($10,A1),-(SP)
            lea     sub_40852050,A2
            move.l  A2,($10,A1)
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            jsr     sub_408523AE
            addq.l  #8,SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
.L2:
            movem.l (SP)+,A0-A1
GoHome:
            move.w  D0,($10,A0)
            movea.l JIODone,A3
            jmp     (A3)
sub_40851E88:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .L1
            bsr.b   sub_40851EAE
            bra.b   .L2
.L1:
            bsr.b   sub_40851ECE
.L2:
            rts
sub_40851E9A:
            ori.b   #4,D4
            ori.b   #$AB,D3
            ori.b   #$BC,D1
            ori.b   #$20,-(A0)
            ori.b   #$8B,-(A0)
sub_40851EAE:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40851E9A,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _ReadXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40851ECE:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40851E9A,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _WriteXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40851EEE:
            link.w  A6,#-$32
            lea     DrvQHdr,A0
            moveq   #4,D0
.L1:
            movea.l (2,A0),A1
.L2:
            cmp.w   (6,A1),D0
            beq.b   .L3
            cmpa.l  (6,A0),A1
            beq.b   .L4
            movea.l (A1),A1
            bra.b   .L2
.L3:
            addq.w  #1,D0
            bra.b   .L1
.L4:
            move.w  D0,($12,A6)
            moveq   #$1A,D0
            _NewPtrSys
            beq.b   .L5
            move.w  D0,($12,A6)
            bra.b   .L6
.L5:
            move.l  #$80000,(A0)+
            move.w  #1,(4,A0)
            move.w  #1,($A,A0)
            move.w  ($E,A6),($E,A0)
            move.w  ($10,A6),($C,A0)
            move.l  (8,A6),($10,A0)
            move.w  ($12,A6),D0
            swap    D0
            move.w  ($C,A6),D0
            _AddDrive
.L6:
            unlk    A6
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
sub_40851F5A:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            ble.b   .L2
            subq.l  #1,D0
            moveq   #0,D1
.L1:
            move.b  D1,(A0)+
            dbra    D0,.L1
.L2:
            rts
sub_40851F70:
            movem.l D1-D2/A0-A4,-(SP)
            cmpi.b  #$F,(7,A0)
            bne.w   .L5
            move.w  ($16,A0),D0
            cmpi.w  #4,D0
            bne.w   .L5
            lea     DrvQHdr,A2
            movea.l (2,A2),A1
.L1:
            cmp.w   (6,A1),D0
            beq.b   .L2
            cmpa.l  (6,A2),A1
            beq.w   .L4
            movea.l (A1),A1
            bra.b   .L1
.L2:
            cmpi.w  #1,($A,A1)
            bne.w   .L4
            move.l  ($10,A1),D0
            movea.l A1,A4
            beq.w   .L4
            movea.l D0,A2
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  ($10,A0),-(SP)
            lea     sub_40852050,A1
            move.l  A1,($10,A0)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #3,($1A,A0)
            move.w  (4,A2),($18,A0)
            _Control
            beq.b   .L3
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            bra.w   .L5
.L3:
            movea.l ($1C,A0),A1
            move.l  A1,($352).w
            movea.l ($372).w,A3
            move.l  A1,(2,A3)
            moveq   #2,D0
            move.l  D0,(6,A3)
            clr.l   ($A,A3)
            clr.l   ($E,A3)
            movea.l ($20,A0),A1
            move.w  ($A,A1),($A,A4)
            move.w  (8,A1),(8,A4)
            move.b  (-3,A1),(-3,A4)
            subq.w  #4,A1
            movea.l A1,A0
            _DisposPtr
            clr.l   ($10,A4)
            move.l  (8,A2),($3F2).w
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            moveq   #0,D0
            bra.b   .L5
.L4:
            moveq   #-1,D0
.L5:
            movem.l (SP)+,D1-D2/A0-A4
            rts
sub_40852050:
            move.l  (4,SP),D0
            move.l  A2,-(SP)
            movea.l SysZone,A1
            movea.l (A1),A0
            movea.l A0,A2
            addi.l  #$4000,D0
            lea     (0,A0,D0.l),A0
            move.l  D0,D1
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L1
            move.l  A1,D1
            sub.l   A2,D1
            movea.l A1,A0
.L1:
            _SetAppBase
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  A1,ApplZone
            move.l  (A1),HeapEnd
            movea.l (SP)+,A2
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  D1,(SP)
            jmp     (A0)
sub_40852098:
            movea.l (4,SP),A0
            clr.l   -(SP)
            move.l  #'DRVR',-(SP)
            move.l  ($12,A0),-(SP)
            _GetNamedResource
            clr.w   D0
            tst.l   (SP)+
            beq.b   .L1
            movea.l (4,SP),A0
            _Open
            move.w  ($18,A0),D0
.L1:
            rts
sub_408520BC:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     sub_40851E88
            moveq   #0,D0
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_408520DE:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            subq.l  #4,SP
            moveq   #$48,D0
            move.l  D0,-(SP)
            jsr     sub_40852496
            move.l  (SP)+,(A3)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.b   .L2
.L1:
            moveq   #1,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     sub_408520BC
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
sub_4085210E:
            link.w  A6,#-$38
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #$38,D0
            move.l  D0,-(SP)
            pea     (-$38,A6)
            jsr     sub_40851F5A
            move.w  #$28,(-$10,A6)
            move.w  #1,(-$E,A6)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.w  D0,(-$C,A6)
            move.b  #1,(-8,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     sub_40852506
            move.w  (SP)+,D7
            beq.b   .L1
            move.w  D7,D0
            bra.b   .L2
.L1:
            move.l  ($18,A6),(-$38,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     sub_40852512
            move.w  (SP)+,D7
            move.b  (-7,A6),(A3)
            move.b  (-6,A6),(A4)
            movea.l ($14,A6),A0
            move.b  (-5,A6),(A0)
            move.w  D7,D0
.L2:
            movem.l (-$44,A6),D7/A3-A4
            unlk    A6
            rts
sub_40852186:
            link.w  A6,#-$7A
            movem.l D7/A3-A4,-(SP)
            lea     (-$22,A6),A4
            movea.l (8,A6),A3
            moveq   #0,D0
            move.l  D0,(-$7A,A6)
            pea     (-$7A,A6)
            jsr     sub_408520DE
            movea.l (-$7A,A6),A0
            moveq   #1,D0
            cmp.b   (1,A0),D0
            addq.l  #4,SP
            bne.b   .L1
            moveq   #$50,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     sub_40851F5A
            lea     .L8,A0
            move.l  A0,(-$60,A6)
            pea     (-$72,A6)
            jsr     sub_40852098
            move.w  D0,(-$5A,A6)
            lea     ($C,SP),SP
            bra.w   .L3
.L1:
            subq.l  #4,SP
            move.w  #$A06E,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408524B6
            subq.l  #4,SP
            move.w  #$A89F,-(SP)
            jsr     sub_408524AC
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            beq.b   .L2
            move.l  A4,-(SP)
            pea     (-$73,A6)
            pea     (-$74,A6)
            pea     (-$75,A6)
            movea.l (-$7A,A6),A0
            move.b  (1,A0),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_4085210E
            move.w  D0,D7
            lea     ($14,SP),SP
            bne.b   .L6
            moveq   #$24,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     sub_40851F5A
            move.b  (-$75,A6),(-$50,A6)
            move.b  (-$74,A6),(-$4F,A6)
            move.l  A4,(-$60,A6)
            subq.l  #2,SP
            pea     (-$72,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_4085251E
            move.w  (SP)+,D7
            move.b  (-$75,A6),(1,A3)
            move.b  (-$74,A6),(2,A3)
            addq.l  #8,SP
            bra.b   .L3
.L2:
            moveq   #-$A,D7
            bra.b   .L6
.L3:
            tst.w   D7
            bne.b   .L4
            tst.w   (-$5A,A6)
            bne.b   .L5
.L4:
            tst.w   D7
            bne.b   .L6
            moveq   #-$17,D7
            bra.b   .L6
.L5:
            movea.l (-$7A,A6),A0
            move.b  (1,A0),(A3)
            move.w  (-$5A,A6),(4,A3)
.L6:
            tst.l   (-$7A,A6)
            beq.b   .L7
            move.l  (-$7A,A6),-(SP)
            jsr     sub_408524A2
.L7:
            move.w  D7,D0
            movem.l (-$86,A6),D7/A3-A4
            unlk    A6
            rts
.L8:
            dc.b    7,'.ATBOOT'
            dc.w    0
sub_408522A4:
            link.w  A6,#-4
            movem.l D6-D7/A3,-(SP)
            movea.l ($C,A6),A3
            pea     (-4,A6)
            jsr     sub_408520DE
            tst.w   D0
            addq.l  #4,SP
            bne.b   .L1
            tst.l   (-4,A6)
            bne.b   .L2
.L1:
            moveq   #-$17,D0
            bra.b   .L4
.L2:
            movea.l (-4,A6),A0
            move.b  (3,A0),D7
            move.l  (-4,A6),-(SP)
            jsr     sub_408524A2
            ext.w   D7
            ext.l   D7
            move.l  #$80,D0
            and.l   D7,D0
            bne.b   .L3
            moveq   #-$17,D0
            bra.b   .L4
.L3:
            subq.l  #2,SP
            pea     ($4000).w
            move.w  ($A,A6),-(SP)
            move.l  A3,-(SP)
            jsr     sub_40851EEE
            move.w  (SP)+,D6
            moveq   #0,D0
.L4:
            movem.l (-$10,A6),D6-D7/A3
            unlk    A6
            rts
sub_40852308:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.w #$308,A4
            movea.l (2,A4),A3
            bra.b   .L2
.L1:
            movea.l (A3),A3
.L2:
            cmpa.l  (6,A4),A3
            beq.b   .L3
            cmp.w   (8,A3),D7
            bne.b   .L1
.L3:
            cmp.w   (8,A3),D7
            bne.b   .L4
            subq.l  #2,SP
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     sub_408524CE
            move.l  A3,-(SP)
            jsr     sub_408524A2
            addq.l  #2,SP
.L4:
            movem.l (SP)+,D7/A3-A4
            rts
sub_40852346:
            link.w  A6,#-$50
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852308
            tst.w   (4,A3)
            addq.l  #4,SP
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.w  (4,A3),(-$38,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     sub_408524E2
            move.w  (SP)+,D7
.L1:
            tst.l   ($DA,A3)
            beq.b   .L2
            move.l  ($DA,A3),-(SP)
            _CloseCPort
            move.l  ($DA,A3),-(SP)
            jsr     sub_408524A2
            moveq   #0,D0
            move.l  D0,($DA,A3)
.L2:
            move.l  A3,-(SP)
            jsr     sub_408524A2
            moveq   #0,D0
            movem.l (-$58,A6),D7/A3
            unlk    A6
            rts
sub_408523AE:
            link.w  A6,#-$82
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            move.w  #$FF,D0
            and.w   (6,A3),D0
            cmpi.w  #2,D0
            beq.b   .L1
            moveq   #-$40,D0
            bra.w   .L8
.L1:
            move.l  A4,-(SP)
            jsr     sub_40852186
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L2
            moveq   #-$40,D0
            bra.w   .L8
.L2:
            move.w  (4,A4),(-$38,A6)
            bne.b   .L3
            moveq   #-$40,D0
            bra.w   .L8
.L3:
            move.w  #1,(-$36,A6)
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.l  ($24,A3),(-$2C,A6)
            move.w  ($2C,A3),(-$24,A6)
            move.l  ($2E,A3),(-$22,A6)
            move.l  ($20,A3),(-$30,A6)
            move.l  ($1C,A3),(-$34,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     sub_408524F4
            move.w  (SP)+,D7
            bne.b   .L4
            move.w  #2,(-$68,A6)
            move.w  (4,A4),(-$6A,A6)
            subq.l  #2,SP
            pea     (-$82,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408524F4
            move.w  (SP)+,D7
            move.l  ($3F2).w,(8,A4)
            lea     sub_40851F70,A0
            move.l  A0,($3F2).w
.L4:
            tst.w   D7
            beq.b   .L7
            move.w  D7,(6,A4)
            ble.b   .L5
            moveq   #-$40,D0
            bra.b   .L6
.L5:
            moveq   #-$41,D0
.L6:
            move.w  D0,D7
.L7:
            move.l  (-$28,A6),($28,A3)
            move.w  D7,D0
.L8:
            movem.l (-$8E,A6),D7/A3-A4
            unlk    A6
            rts
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
            moveq   #0,D0
.L9:
            move.l  A1,-(SP)
.L10:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L10
sub_40852496:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     sub_408523AE.L9
sub_408524A2:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     sub_408523AE.L9
sub_408524AC:
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            _GetTrapAddress
            move.l  A0,(SP)
            jmp     (A1)
sub_408524B6:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            move.w  (SP)+,D0
            move.l  A1,-(SP)
            tst.b   D1
            beq.b   .L1
            _GetToolBoxTrapAddress
            bra.b   .L2
.L1:
            _GetOSTrapAddress
.L2:
            move.l  A0,(4,SP)
            rts
sub_408524CE:
            movea.l (4,SP),A1
            movea.l (8,SP),A0
            _Dequeue
            move.w  D0,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
sub_408524E2:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Close
            bra.b   .L2
.L1:
            _Close async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
sub_408524F4:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Control
            bra.b   .L2
.L1:
            _Control async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
sub_40852506:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sNextTypesRsrc
            move.w  D0,(SP)
            jmp     (A1)
sub_40852512:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sReadDrvrName
            move.w  D0,(SP)
            jmp     (A1)
sub_4085251E:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _HOpen
            bra.b   .L2
.L1:
            _HOpen async
.L2:
            move.w  D0,(SP)
            jmp     (A1)

            EVEN
