            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_50

            IMPORT  BaseOfROM,RsrcEntryDRVR_49

            SECTION "ATBoot",CODE

RsrcEntryDRVR_50:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 50 ".ATBOOT" (17796 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_49-BaseOfROM      ; Next entry
            dc.l    ATBOOT-BaseOfROM                ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    50                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'.ATBOOT'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00004590,$000001D4   ; Block header
ATBOOT:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    ATOpen-ATBOOT                   ; drvrOpen
            dc.w    ATAnRTS-ATBOOT                  ; drvrPrime
            dc.w    ATControl-ATBOOT                ; drvrCtl
            dc.w    ATAnRTS-ATBOOT                  ; drvrStatus
            dc.w    ATClose-ATBOOT                  ; drvrClose
            dc.b    7,'.ATBOOT'
            dc.w    $0100
ATOpen:
            move.l  ($14,A1),D3
            bgt.b   GotMem
            move.l  #$272,D0
            _NewPtrSysClear
            move.l  A0,D3
            beq.w   ATErrXit
            move.l  D3,($14,A1)
GotMem:
            suba.w  #ioQElSize,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     BootDiskName,A1
            move.l  A1,($12,A0)
            _Open
            tst.w   ($10,A0)
            adda.w  #$32,SP
            bgt.w   ATErrXit
            movea.l D3,A3
            move.w  ($18,A0),(A3)
            btst    #3,($17B).w
            bne.w   ATErrXit
            movem.l D2-D7/A0-A6,-(SP)
            moveq   #-$62,D1
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            bgt.b   .NoPatchee
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'lmgr',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D5
            beq.b   .OldAppleTalk
            bsr.w   sub_40856164
            beq.b   .lapOK
            move.w  D0,D1
            bra.b   .NoPatchee
.lapOK:
            move.w  #$A090,D0
            _GetOSTrapAddress
            movea.l A0,A5
            move.w  #$A090,D0
            lea     mySysEnvirons,A0
            _SetOSTrapAddress
.OldAppleTalk:
            suba.w  #ioQElSize,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     MPPName,A1
            move.l  A1,($12,A0)
            _Open
            move.w  ($10,A0),D1
            lea     ($32,SP),SP
            tst.l   D5
            beq.b   .NoPatchee
            movea.l A5,A0
            move.w  #$A090,D0
            _SetOSTrapAddress
.NoPatchee:
            movem.l (SP)+,D2-D7/A0-A6
            tst.w   D1
            bne.b   ATErrXit
            moveq   #0,D0
            rts
ATErrXit:
            move.w  #$FFE9,D0
            rts
MPPName:
            dc.b    4,'.MPP'
            dc.b    $00
BootDiskName:
            dc.b    8,'.netBoot'
            dc.b    0
OpenStr:
            dc.b    11,'ATBoot Open'
            dc.w    0
ATClose:
            move.l  ($14,A1),D3
            beq.b   ATCloseExit
            movea.l D3,A3
            move.l  ($26A,A3),D0
            beq.b   .nopram
            movea.l D0,A0
            _DisposPtr
.nopram:
            move.l  (4,A3),D0
            beq.b   .noBuffer
            movea.l D0,A0
            _DisposPtr
.noBuffer:
            movea.l A3,A0
            _DisposPtr
            clr.l   ($14,A3)
ATCloseExit:
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #$FFF6,($18,A0)
            _Close
            lea     ($32,SP),SP
            moveq   #0,D0
ATAnRTS:
            rts
CloseStr:
            dc.b    12,'ATBoot Close'
            dc.b    $00,$4E,$75
ATControl:
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            moveq   #-1,D0
            move.l  ($14,A1),-(SP)
            beq.w   NoGo
            move.l  A0,-(SP)
            jsr     DoATControl
NoGo:
            addq.l  #8,SP
            movea.l (SP)+,A0
            move.l  #$400,($28,A0)
            move.w  D0,($10,A0)
            movea.l (SP)+,A1
            movea.l JIODone,A3
            jmp     (A3)
ControlStr:
            dc.b    14,'ATBoot Control'
            dc.b    $00
mySysEnvirons:
            move.w  #$0605,(4,A0)                   ; Fake good system version
            moveq   #0,D0                           ; Return no error
            rts
sub_408526F0:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .L1
            bsr.b   sub_40852716
            bra.b   .L2
.L1:
            bsr.b   sub_40852736
.L2:
            rts
sub_40852702:
            ori.b   #4,D4
            ori.b   #$AB,D3
            ori.b   #$BC,D1
            ori.b   #$20,-(A0)
            ori.b   #$8B,-(A0)
sub_40852716:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40852702,A1
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
sub_40852736:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40852702,A1
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
sub_40852756:
            move.l  A5,D0
            rts
sub_4085275A:
            movea.l (4,SP),A5
            rts
sub_40852760:
            move.l  (4,SP),D0
            lsl.w   #7,D0
            lea     .L1,A0
            add.l   A0,D0
            rts
.L1:
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1210,$1090
            dc.w    $1210,$1090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1211,$1090
            dc.w    $1211,$1090,$1201,$0090,$1201,$0090,$1203,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
.L2:
            dc.w    $0FFF,$FFE0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0
sub_4085296E:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($CE,A3)
            jsr     sub_4085275A
            pea     ($CA,A3)
            _InitGraf
            pea     ($D2,A3)
            _OpenPort
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
sub_4085298E:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($D2,A3)
            _CloseCPort
            movea.l (SP)+,A3
            rts
sub_4085299E:
            movem.l D6-D7/A3,-(SP)
            move.w  ($1A,SP),D6
            move.w  ($16,SP),D7
            movea.l ($10,SP),A3
            move.w  (4,A3),D0
            sub.w   (A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D6
            sub.l   D6,D0
            add.w   D0,(A3)
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D7
            sub.l   D7,D0
            add.w   D0,(2,A3)
            move.w  D6,D0
            add.w   (A3),D0
            add.w   D6,D0
            move.w  D0,(4,A3)
            move.w  D7,D0
            add.w   (2,A3),D0
            add.w   D7,D0
            move.w  D0,(6,A3)
            movem.l (SP)+,D6-D7/A3
            rts
sub_408529EE:
            link.w  A6,#-$24
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A3
            lea     (-8,A6),A0
            lea     ($E2,A3),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            moveq   #$10,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            pea     (-8,A6)
            jsr     sub_4085299E
            pea     ($D2,A3)
            _SetPort
            move.l  A4,(-$24,A6)
            move.w  #4,(-$20,A6)
            pea     (-$1E,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            lea     sub_40852760.L2,A0
            move.l  A0,(-$16,A6)
            move.w  #4,(-$12,A6)
            pea     (-$10,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            tst.l   ($10,A6)
            lea     ($C,SP),SP
            beq.b   .L1
            pea     (-8,A6)
            pea     ($B2,A3)
            _FillRect
.L1:
            pea     (-$24,A6)
            pea     (-$16,A6)
            pea     ($D4,A3)
            pea     (-$1E,A6)
            pea     (-$10,A6)
            pea     (-8,A6)
            _CopyMask
            movem.l (-$2C,A6),A3-A4
            unlk    A6
            rts
sub_40852A92:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A3
            moveq   #0,D7
            moveq   #3,D0
            cmp.w   ($13E,A3),D0
            ble.b   .L2
            tst.w   ($13E,A3)
            bne.b   .L1
            moveq   #1,D7
.L1:
            move.w  ($13E,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852760
            movea.l D0,A4
            addq.w  #1,($13E,A3)
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408529EE
            lea     ($10,SP),SP
.L2:
            movem.l (SP)+,D7/A3-A4
            rts
sub_40852AD2:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            lea     (-$12,A6),A4
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,($42,A3)
            pea     ($2C,A3)
            move.l  A4,-(SP)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #$2A,D1
            move.w  D1,-(SP)
            jsr     sub_408565D0
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408564EC
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
sub_40852B1C:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($14,A6),A4
            lea     ($38,A4),A3
            move.l  A4,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            pea     .L1
            jsr     sub_40856614
            move.l  A4,($1E,A3)
            move.b  ($23,A6),($1C,A3)
            move.b  ($27,A6),($1D,A3)
            move.l  ($10,A6),($22,A3)
            move.w  #$DE,($26,A3)
            move.w  ($1A,A6),($28,A3)
            moveq   #0,D0
            move.l  D0,($C,A3)
            subq.l  #2,SP
            pea     ($38,A4)
            move.b  ($1F,A6),-(SP)
            jsr     sub_408564FC
            move.w  (SP)+,D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
.L1:
            dc.w    $012A,0
sub_40852B84:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            lea     ($3E,A3),A0
            movea.l A4,A1
            moveq   #9,D0
.L1:
            move.l  (A1)+,(A0)+
            dbra    D0,.L1
            move.w  (A1)+,(A0)+
            movem.l (SP)+,A3-A4
            rts
sub_40852BB8:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.l ($14,SP),A3
            lea     .L1,A4
            moveq   #$F,D0
            and.w   D7,D0
            ext.l   D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(1,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #4,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(2,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #8,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(3,A3)
            ext.l   D7
            moveq   #$C,D0
            move.l  D7,D1
            asr.l   D0,D1
            moveq   #$F,D0
            and.l   D1,D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(4,A3)
            move.b  #4,(A3)
            movem.l (SP)+,D7/A3-A4
            rts
.L1:
            dc.b    '0123456789ABCDEF'
            dc.w    0
sub_40852C2A:
            link.w  A6,#-$23E
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($1C,A6),A3
            moveq   #0,D0
            movea.l D0,A4
            moveq   #1,D5
            move.w  #$FFFF,(-$16E,A6)
            move.b  #$FF,(-$16C,A6)
            move.b  #$FF,(-$16B,A6)
            move.l  A3,D1
            beq.w   .L6
            move.w  #$FFFF,(A3)
            pea     (-$100,A6)
            moveq   #0,D0
            move.w  ($16,A6),D0
            move.l  D0,-(SP)
            jsr     sub_40852BB8
            pea     (-$23A,A6)
            move.l  ($18,A6),-(SP)
            jsr     sub_40852B84
            subq.l  #4,SP
            pea     ($DE).w
            jsr     sub_40856442
            movea.l (SP)+,A4
            move.l  A4,D0
            lea     ($10,SP),SP
            beq.w   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L2
            moveq   #0,D0
            move.b  ($F,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #1,D1
            move.l  D1,-(SP)
            pea     (-$1D2,A6)
            move.l  A4,-(SP)
            pea     (-$100,A6)
            move.l  ($10,A6),-(SP)
            jsr     sub_40852B1C
            tst.w   D0
            lea     ($20,SP),SP
            bne.w   .L6
            bra.b   .L2
.L1:
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     sub_40852AD2
            addq.l  #8,SP
.L2:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L3
            cmp.w   (-$170,A6),D5
            bgt.b   .L3
            subq.l  #2,SP
            move.l  A4,-(SP)
            move.w  (-$170,A6),-(SP)
            move.w  D5,-(SP)
            addq.w  #1,D5
            pea     (-$16A,A6)
            pea     (-$104,A6)
            jsr     NBPExtract
            move.w  (SP)+,(-$19C,A6)
            beq.b   .L1
.L3:
            tst.w   (-$170,A6)
            ble.b   .L6
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D6
            move.b  ($B,A6),D0
            lsl.b   #4,D0
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D7
            move.l  D6,D4
            move.l  D7,D0
            lsl.l   #2,D0
            move.l  D0,(-$23E,A6)
            bra.b   .L5
.L4:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D4,D0
            cmp.l   D0,D7
            bcc.b   .L5
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D4
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     sub_40852AD2
            addq.l  #8,SP
.L5:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D6,D0
            cmp.l   (-$23E,A6),D0
            bcc.b   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L4
.L6:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L7
            move.l  ($26,A3),(-$16E,A6)
.L7:
            move.l  A4,D0
            beq.b   .L8
            move.l  A4,-(SP)
            jsr     sub_4085645A
.L8:
            move.l  (-$16E,A6),D0
            movem.l (-$256,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40852D92:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l ($C,A6),A3
            move.w  ($30,A3),D0
            cmp.w   (2,A3),D0
            bne.b   .L3
            tst.w   ($3A,A3)
            bne.b   .L3
            move.w  ($38,A3),(A3)
            move.l  (8,A6),($26,A3)
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   ($32,A3),D0
            lsl.l   #2,D0
            move.w  D0,($1E,A3)
            moveq   #4,D0
            cmp.w   ($1E,A3),D0
            ble.b   .L1
            moveq   #4,D0
            bra.b   .L2
.L1:
            move.w  ($1E,A3),D0
            ext.l   D0
.L2:
            move.w  D0,($1E,A3)
.L3:
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_40852DE4:
            link.w  A6,#0
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            tst.l   ($C,A6)
            bne.b   .L2
            tst.l   ($22,A3)
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,($22,A3)
.L1:
            move.l  D7,($16,A3)
            addq.w  #1,($A,A3)
.L2:
            move.l  D7,($12,A3)
            movem.l (-8,A6),D7/A3
            unlk    A6
            rts
sub_40852E1E:
            movem.l D5-D7/A3-A4,-(SP)
            movea.l ($1C,SP),A4
            movea.l ($18,SP),A3
            clr.w   D5
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            move.b  #3,($3E,A3)
            move.b  #1,($3F,A3)
            move.w  (A4),($40,A3)
            clr.b   ($42,A3)
            clr.b   ($43,A3)
            moveq   #0,D0
            move.w  (8,A4),D0
            divs.w  #8,D0
            move.w  D0,D6
            moveq   #0,D0
            move.w  (8,A4),D0
            move.l  D0,D5
            lsr.l   #3,D5
            beq.b   .L1
            addq.w  #1,D6
.L1:
            clr.w   D7
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.w  D7,D0
            move.b  #$FF,($46,A3,D0.l)
            addq.w  #1,D7
.L3:
            cmp.w   D7,D6
            bhi.b   .L2
            tst.w   D5
            beq.b   .L4
            move.w  D6,D0
            subq.w  #1,D0
            moveq   #0,D1
            move.w  D0,D1
            move.b  #$FF,($46,A3,D1.l)
.L4:
            movem.l (SP)+,D5-D7/A3-A4
            rts
sub_40852E9C:
            movem.l D6-D7/A3-A4,-(SP)
            move.w  ($1E,SP),D6
            movea.l ($18,SP),A4
            movea.l ($14,SP),A3
            ext.l   D6
            move.l  D6,D0
            divs.w  #8,D0
            move.w  D0,D7
            bra.b   .L2
.L1:
            move.b  (A3)+,D0
            not.b   D0
            move.b  D0,(A4)+
.L2:
            move.w  D7,D0
            subq.w  #1,D7
            tst.w   D0
            bne.b   .L1
            ext.l   D6
            move.l  D6,D0
            asr.l   #3,D0
            beq.b   .L3
            move.b  (A3),D0
            not.b   D0
            move.b  D0,(A4)
.L3:
            movem.l (SP)+,D6-D7/A3-A4
            rts
sub_40852EDA:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l (8,A6),A3
            pea     ($2C,A3)
            pea     (-$12,A6)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.w  (8,A4),D1
            move.l  D1,D0
            moveq   #8,D1
            jsr     sub_40856390
            addq.l  #8,D0
            moveq   #0,D1
            move.w  (8,A4),D1
            lsr.l   #3,D1
            beq.b   .L1
            moveq   #1,D1
            bra.b   .L2
.L1:
            moveq   #0,D1
.L2:
            add.l   D0,D1
            move.w  D1,-(SP)
            jsr     sub_408565D0
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408564EC
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
sub_40852F3E:
            link.w  A6,#-$80C
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            move.l  (8,A6),D5
            lea     (-$344,A6),A3
            clr.w   (-$592,A6)
            moveq   #0,D4
            pea     ($140).w
            moveq   #0,D0
            move.l  D0,-(SP)
            pea     (-$140,A6)
            jsr     sub_40856A9E
            jsr     sub_40852756
            move.l  D0,(-$144,A6)
            pea     (-$140,A6)
            jsr     sub_4085296E
            move.w  #$FFFF,(-$80C,A6)
            move.w  #1,(-$80A,A6)
            move.l  A3,(-$808,A6)
            clr.w   (-$804,A6)
            clr.w   (-$802,A6)
            moveq   #0,D0
            move.l  D0,(-$800,A6)
            clr.w   (-$7FC,A6)
            move.l  D0,(-$7FA,A6)
            move.l  D0,(-$7F6,A6)
            move.l  D5,D1
            asr.l   #3,D1
            move.l  D1,(-$7F2,A6)
            move.w  #4,(-$7EE,A6)
            move.w  #1,(-$7EC,A6)
            move.l  D0,(-$7EA,A6)
            moveq   #-1,D1
            move.l  D1,(-$7E6,A6)
            pea     (-$80C,A6)
            jsr     sub_40853292
            subq.l  #2,SP
            jsr     MPPOpen_piMAIN
            move.w  (SP)+,(-$594,A6)
            lea     ($14,SP),SP
            beq.b   .L1
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L1:
            tst.b   ($17,A6)
            beq.b   .L2
            moveq   #$F,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            asl.w   #2,D1
            move.b  D1,(-$58C,A6)
            move.w  #$F0,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            lsr.l   #4,D1
            move.b  D1,(-$58B,A6)
            bra.b   .L3
.L2:
            move.b  #4,(-$58C,A6)
            move.b  #1,(-$58B,A6)
.L3:
            move.w  #$A,(-$592,A6)
            subq.l  #2,SP
            pea     (-$592,A6)
            pea     sub_4085329A
            jsr     DDPOpenSocket
            move.w  (SP)+,(-$594,A6)
            beq.b   .L4
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L4:
            move.b  #1,(A4)
            move.b  #1,(1,A4)
            moveq   #0,D0
            move.l  D0,(4,A4)
            move.w  #$FFFF,(-$590,A6)
            move.b  #$FF,(-$58E,A6)
            move.b  #$FF,(-$58D,A6)
            pea     (-$80C,A6)
            move.l  A4,-(SP)
            moveq   #0,D1
            move.w  ($E,A6),D1
            move.l  D1,-(SP)
            pea     sub_40853286
            moveq   #0,D1
            move.b  (-$58B,A6),D1
            move.l  D1,-(SP)
            moveq   #0,D1
            move.b  (-$58C,A6),D1
            move.l  D1,-(SP)
            jsr     sub_40852C2A
            move.l  D0,(-$590,A6)
            moveq   #0,D0
            move.w  (-$80C,A6),D0
            cmpi.l  #$FFFF,D0
            lea     ($18,SP),SP
            beq.w   .L15
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            beq.w   .L15
            move.w  (-$7D6,A6),(-$7FC,A6)
            move.l  (-$7D0,A6),D0
            subq.l  #1,D0
            move.w  D0,(-$804,A6)
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     sub_40856390
            cmpi.l  #$1FF,D0
            bge.b   .L5
            move.w  (-$7FC,A6),D0
            mulu.w  (-$804,A6),D0
            move.l  D0,-(SP)
            move.l  BufPtr,D0
            moveq   #4,D1
            jsr     sub_40856390
            move.l  D0,D1
            move.l  (SP)+,D0
            cmp.l   D0,D1
            bcc.b   .L6
.L5:
            moveq   #-2,D4
            bra.w   .L16
.L6:
            subq.l  #4,SP
            moveq   #0,D0
            move.w  (-$7D6,A6),D0
            move.l  D0,D1
            move.l  (-$7D0,A6),D0
            jsr     sub_40856368
            move.l  D0,-(SP)
            jsr     sub_40856442
            move.l  (SP)+,(-$800,A6)
            bne.b   .L7
            moveq   #-2,D4
            bra.w   .L16
.L7:
            pea     (-$80C,A6)
            pea     (-$58A,A6)
            jsr     sub_40852E1E
            clr.w   D6
            addq.l  #8,SP
            bra.b   .L9
.L8:
            clr.b   (0,A3,D6.w)
            addq.w  #1,D6
.L9:
            ext.l   D6
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     sub_40856390
            addq.l  #1,D0
            cmp.l   D6,D0
            bgt.b   .L8
            bra.w   .L14
.L10:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            moveq   #0,D0
            move.w  (-$802,A6),D0
            move.l  D0,D1
            add.l   D0,D0
            add.l   D1,D0
            moveq   #0,D1
            move.w  (-$804,A6),D1
            jsr     sub_40856390
            move.w  (-2,A6),D1
            ext.l   D1
            cmp.l   D0,D1
            bgt.b   .L11
            pea     (-$140,A6)
            jsr     sub_40852A92
            addq.l  #4,SP
.L11:
            move.l  D7,D0
            sub.l   (-$7FA,A6),D0
            cmp.l   (-$7F2,A6),D0
            bgt.b   .L12
            move.l  D7,D0
            sub.l   (-$7F6,A6),D0
            move.l  (-$7F2,A6),D2
            move.l  D2,D1
            mulu.w  #$32,D2
            swap    D1
            mulu.w  #$32,D1
            swap    D1
            clr.w   D1
            add.l   D1,D2
            cmp.l   D0,D2
            bge.b   .L14
.L12:
            tst.l   (-$7EA,A6)
            beq.b   .L13
            move.w  (-$7EC,A6),D0
            add.w   D0,(-$7EC,A6)
            move.w  (-$7EE,A6),D0
            muls.w  (-$7EC,A6),D0
            move.l  D0,(-$7F2,A6)
.L13:
            moveq   #0,D0
            move.w  (-$804,A6),D0
            move.l  D0,-(SP)
            pea     (-$544,A6)
            move.l  A3,-(SP)
            jsr     sub_40852E9C
            move.l  D7,(-$7EA,A6)
            move.l  D7,(-$7F6,A6)
            move.l  D7,(-$7FA,A6)
            pea     (-$80C,A6)
            move.l  (-$590,A6),-(SP)
            pea     (-$58A,A6)
            jsr     sub_40852EDA
            lea     ($18,SP),SP
.L14:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L16
            cmp.l   (-$7F2,A6),D5
            bgt.w   .L10
            bra.b   .L16
.L15:
            moveq   #-3,D4
.L16:
            pea     (-$140,A6)
            jsr     sub_4085298E
            move.l  (-$144,A6),-(SP)
            jsr     sub_4085275A
            tst.w   (-$592,A6)
            addq.l  #8,SP
            beq.b   .L17
            subq.l  #2,SP
            move.w  (-$592,A6),-(SP)
            jsr     DDPCloseSocket
            move.w  (SP)+,(-$594,A6)
.L17:
            tst.l   (-$800,A6)
            beq.b   .L18
            tst.l   D4
            beq.b   .L18
            move.l  (-$800,A6),-(SP)
            jsr     sub_4085645A
            bra.b   .L19
.L18:
            movea.l ($18,A6),A0
            move.l  (-$800,A6),(A0)
.L19:
            tst.l   D4
            beq.b   .L20
            move.l  D4,D0
            bra.b   .L23
.L20:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L21
            moveq   #-4,D0
            bra.b   .L23
.L21:
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            bne.b   .L22
            moveq   #-3,D0
            bra.b   .L23
.L22:
            movea.l ($1C,A6),A0
            move.l  (-$590,A6),(A0)
            pea     (-$7DE,A6)
            move.l  ($20,A6),-(SP)
            pea     ($24A).w
            jsr     sub_40856478
            move.l  D4,D0
.L23:
            movem.l (-$824,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40853286:
            eori.w  #$6F6F,D2
            moveq   #$53,D2
            bcs.b   sub_4085329A.L3
            moveq   #$65,D3
            moveq   #0,D1
sub_40853292:
            movea.l (SP)+,A0
            move.l  (SP)+,($B50).w
            jmp     (A0)
sub_4085329A:
            movem.l D4-D7,-(SP)
            cmpi.b  #$A,(-1,A3)
            bne.b   .L4
            cmpi.w  #6,D1
            bmi.b   .L4
            movea.l ($B50).w,A5
            cmpi.b  #1,(3,A2)
            bne.b   .L1
            move.b  (2,A2),D2
            swap    D2
            move.w  ($1A,A2),D2
            bra.b   .L2
.L1:
            move.b  (-4,A3),D2
            swap    D2
            move.w  (-7,A3),D2
.L2:
            swap    D2
            lsl.w   #8,D2
            move.b  (-2,A3),D2
            moveq   #6,D3
            suba.l  D3,SP
            movea.l SP,A3
            jsr     (A4)
            move.w  (SP)+,D0
            move.l  (SP)+,D5
            swap    D5
            tst.w   D3
            bne.w   .L7
            move.b  D0,D3
            cmpi.b  #1,D3
            bgt.b   .L4
            lsr.w   #8,D0
            cmpi.b  #4,D0
            bne.b   .L6
            cmp.l   ($26,A5),D2
            bne.b   .L4
.L3:
            cmp.w   (A5),D5
            bne.b   .L4
            swap    D5
            cmp.w   (8,A5),D5
            bgt.b   .L4
            movea.l (4,A5),A3
            move.l  A3,D6
            move.w  D5,D0
            bsr.w   sub_408533A6
            beq.b   .L5
            moveq   #-1,D0
            move.l  A5,D7
            jsr     sub_40853398
.L4:
            movem.l (SP)+,D4-D7
            moveq   #0,D3
            jmp     (2,A4)
.L5:
            move.l  ($C,A5),D0
            beq.b   .L4
            movea.l D0,A3
            move.w  D5,D0
            bsr.w   sub_408533C2
            move.w  ($10,A5),D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            tst.w   D3
            bgt.b   .L7
            movea.l D6,A0
            move.w  D5,D0
            jsr     sub_408533B8
            moveq   #0,D0
            jsr     sub_40853398
            bra.b   .L7
.L6:
            cmpi.b  #7,D0
            beq.b   .L7
            cmpi.w  #$FFFF,(A5)
            bne.b   .L4
            cmpi.b  #2,D0
            bne.b   .L4
            lea     ($2E,A5),A3
            move.b  D0,(A3)+
            move.b  D3,(A3)+
            swap    D5
            move.l  D5,(A3)+
            move.l  #$24A,D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            move.l  D7,-(SP)
            move.l  D2,-(SP)
            jsr     sub_40852D92
            lea     (8,SP),SP
.L7:
            movem.l (SP)+,D4-D7
            rts
sub_40853398:
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     sub_40852DE4
            lea     (8,SP),SP
            rts
sub_408533A6:
            movem.l D1,-(SP)
            move.w  D0,D1
            lsr.w   #3,D0
            btst    D1,(0,A3,D0.w)
            movem.l (SP)+,D1
            rts
sub_408533B8:
            move.w  D0,D1
            lsr.w   #3,D0
            bset    D1,(0,A0,D0.w)
            rts
sub_408533C2:
            move.l  D0,-(SP)
            mulu.w  ($10,A5),D0
            adda.l  D0,A3
            move.l  (SP)+,D0
            rts
sub_408533CE:
            link.w  A6,#-$34
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($C,A6),A0
            move.l  (A0),(-$34,A6)
            movea.l ($C,A6),A0
            move.l  (4,A0),(-$30,A6)
            movea.l ($C,A6),A0
            move.l  (8,A0),(-$2C,A6)
            movea.l ($C,A6),A0
            move.l  ($C,A0),(-$28,A6)
            movea.l ($C,A6),A0
            move.l  ($10,A0),(-$24,A6)
            movea.l ($C,A6),A0
            move.l  ($14,A0),(-$20,A6)
            movea.l ($C,A6),A0
            move.l  ($18,A0),(-$1C,A6)
            movea.l ($C,A6),A0
            move.l  ($1C,A0),(-$18,A6)
            movea.l ($C,A6),A0
            move.l  ($20,A0),(-$14,A6)
            movea.l ($C,A6),A0
            move.l  ($24,A0),(-$10,A6)
            movea.l ($C,A6),A0
            move.l  ($28,A0),(-$C,A6)
            movea.l ($C,A6),A0
            move.l  ($2C,A0),(-8,A6)
            movea.l ($C,A6),A0
            move.l  ($30,A0),D4
            movea.l ($C,A6),A0
            move.l  ($34,A0),D5
            movea.l ($C,A6),A0
            move.l  ($38,A0),D6
            movea.l ($C,A6),A0
            move.l  ($3C,A0),(-4,A6)
            move.l  ($10,A6),D0
            eor.l   D0,(-$34,A6)
            move.l  ($14,A6),D0
            eor.l   D0,(-$30,A6)
            move.l  ($18,A6),D0
            eor.l   D0,(-$2C,A6)
            movea.l ($1C,A6),A0
            lea     (A0),A3
            movea.l A3,A4
            adda.l  #$400,A4
            move.l  #$FF,D0
            and.l   (-$34,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            move.l  #$FF,D0
            and.l   (-$30,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            move.l  #$FF,D0
            and.l   (-$2C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            move.l  #$FF,D0
            and.l   (-$28,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            move.l  #$FF,D0
            and.l   (-$24,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            move.l  #$FF,D0
            and.l   (-$20,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            move.l  #$FF,D0
            and.l   (-$1C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            move.l  #$FF,D0
            and.l   (-$18,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            move.l  #$FF,D0
            and.l   (-$14,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            move.l  #$FF,D0
            and.l   (-$10,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            move.l  #$FF,D0
            and.l   (-$C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            move.l  #$FF,D0
            and.l   (-8,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            move.l  #$FF,D0
            and.l   D4,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            move.l  #$FF,D0
            and.l   D5,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            move.l  #$FF,D0
            and.l   D6,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            move.l  #$FF,D0
            and.l   (-4,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            adda.w  #$4000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            moveq   #$10,D0
            move.l  (-$34,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            moveq   #$10,D0
            move.l  (-$30,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            moveq   #$10,D0
            move.l  (-$2C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            moveq   #$10,D0
            move.l  (-$28,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            moveq   #$10,D0
            move.l  (-$24,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            moveq   #$10,D0
            move.l  (-$20,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            moveq   #$10,D0
            move.l  (-$1C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            moveq   #$10,D0
            move.l  (-$18,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            moveq   #$10,D0
            move.l  (-$14,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            moveq   #$10,D0
            move.l  (-$10,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            moveq   #$10,D0
            move.l  (-$C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            moveq   #$10,D0
            move.l  (-8,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            moveq   #$10,D0
            move.l  D4,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            moveq   #$10,D0
            move.l  D5,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            moveq   #$10,D0
            move.l  D6,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            moveq   #$10,D0
            move.l  (-4,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            suba.w  #$2000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            moveq   #$18,D0
            move.l  (-$34,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            moveq   #$18,D0
            move.l  (-$30,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            moveq   #$18,D0
            move.l  (-$2C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            moveq   #$18,D0
            move.l  (-$28,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            moveq   #$18,D0
            move.l  (-$24,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            moveq   #$18,D0
            move.l  (-$20,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            moveq   #$18,D0
            move.l  (-$1C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            moveq   #$18,D0
            move.l  (-$18,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            moveq   #$18,D0
            move.l  (-$14,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            moveq   #$18,D0
            move.l  (-$10,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            moveq   #$18,D0
            move.l  (-$C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            moveq   #$18,D0
            move.l  (-8,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            moveq   #$18,D0
            move.l  D4,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            moveq   #$18,D0
            move.l  D5,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            moveq   #$18,D0
            move.l  D6,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            moveq   #$18,D0
            move.l  (-4,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            adda.w  #$4000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            move.l  (-$34,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            move.l  (-$30,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            move.l  (-$2C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$28,A6)
            move.l  (-$28,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$24,A6)
            move.l  (-$24,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$20,A6)
            move.l  (-$20,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$1C,A6)
            move.l  (-$1C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$18,A6)
            move.l  (-$18,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$14,A6)
            move.l  (-$14,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$10,A6)
            move.l  (-$10,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$C,A6)
            move.l  (-$C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-8,A6)
            move.l  (-8,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D4
            move.l  D4,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D5
            move.l  D5,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            move.l  D6,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            move.l  (-4,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D6
            move.l  ($10,A6),D0
            eor.l   D0,D6
            move.l  ($14,A6),D0
            eor.l   D0,D5
            move.l  ($18,A6),D0
            eor.l   D0,D4
            movea.l ($C,A6),A0
            move.l  (-4,A6),D0
            move.l  (A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(A0)
            movea.l ($C,A6),A0
            move.l  D6,D0
            move.l  (4,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(4,A0)
            movea.l ($C,A6),A0
            move.l  D5,D0
            move.l  (8,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(8,A0)
            movea.l ($C,A6),A0
            move.l  D4,D0
            move.l  ($C,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,($C,A0)
            movem.l (-$4C,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40853B2A:
            link.w  A6,#0
            movem.l D3-D7/A3-A4,-(SP)
            subq.l  #4,SP
            move.l  #$8000,-(SP)
            jsr     sub_40856436
            movea.l ($C,A6),A0
            move.l  (SP)+,(A0)
            movea.l ($C,A6),A0
            tst.l   (A0)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.w   .L7
.L1:
            moveq   #0,D4
            moveq   #8,D3
.L2:
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A4
            clr.w   D7
            move.w  #$100,D2
.L3:
            move.l  (A3)+,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L3
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($2000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #$18,D5
            moveq   #8,D6
            clr.w   D7
            move.w  #$100,D2
.L4:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L4
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($4000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #$10,D6
            move.b  D6,D5
            clr.w   D7
            move.w  #$100,D2
.L5:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L5
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($6000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #8,D5
            moveq   #$18,D6
            clr.w   D7
            move.w  #$100,D2
.L6:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L6
            addq.l  #1,D4
            cmp.l   D4,D3
            bgt.w   .L2
            moveq   #0,D0
.L7:
            movem.l (-$1C,A6),D3-D7/A3-A4
            unlk    A6
            rts
sub_40853CC6:
            link.w  A6,#-$40
            movem.l D3-D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            lea     (-$40,A6),A3
            move.l  ($18,A6),D4
            moveq   #0,D4
            moveq   #0,D5
            move.l  ($18,A6),D0
            asl.l   #3,D0
            move.l  D0,D6
            move.l  #$FFFFFC0,D0
            and.l   ($18,A6),D0
            move.l  D0,($18,A6)
            tst.l   (A4)
            bne.b   .L1
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     sub_40853B2A
            move.w  D0,D7
            addq.l  #8,SP
            beq.b   .L1
            move.w  D7,D0
            bra.w   .L5
.L1:
            moveq   #0,D7
            moveq   #$10,D3
.L2:
            move.l  D7,D0
            asl.w   #2,D0
            moveq   #0,D1
            move.l  D1,(0,A3,D0.w)
            addq.l  #1,D7
            cmp.l   D7,D3
            bgt.b   .L2
            moveq   #0,D7
.L3:
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  ($10,A6),-(SP)
            move.l  D7,D0
            asl.w   #2,D0
            pea     (0,A3,D0.w)
            jsr     sub_408533CE
            addq.l  #1,D6
            subi.l  #$40,($18,A6)
            addi.l  #$40,($10,A6)
            addq.l  #4,D7
            moveq   #$10,D0
            cmp.l   D7,D0
            lea     ($18,SP),SP
            bgt.b   .L4
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408533CE
            moveq   #4,D7
            addq.l  #1,D6
            lea     ($18,SP),SP
.L4:
            tst.l   ($18,A6)
            bhi.b   .L3
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            move.l  ($14,A6),-(SP)
            jsr     sub_408533CE
            moveq   #0,D0
            lea     ($18,SP),SP
.L5:
            movem.l (-$5C,A6),D3-D7/A3-A4
            unlk    A6
            rts
sub_40853D9A:
            lea     .L1,A0
            move.l  A0,D0
            rts
.L1:
            dc.w    $64F9,$001B,$FEDD,$CDF6,$7C8F,$F1E2,$11D7,$1514
            dc.w    $8B8C,$18D3,$DDDF,$881E,$6EAB,$5056,$88CE,$D8E1
            dc.b    $49,$14,$89,$59,$69,$C5,$6F,$D5,$B7,$99,$4F,$03,$0F,$BC,$EE
            dc.b    '><&I@!U~X'
            dc.w    $E14B,$3FC2,$2E5C,$F591,$DCEF,$F8CE,$092A,$1648
            dc.w    $BE81,$2936,$FF7B,$0C6A,$D525,$1037,$AFA4,$48F1
            dc.w    $7DAF,$C95A,$1EA6,$9C3F,$A417,$ABE7,$5890,$E423
            dc.w    $B0CB,$70C0,$C850,$25F7,$244D,$97E3,$1FF3,$595F
            dc.w    $C4EC,$6396,$5918,$1E17,$E635,$B477,$354E,$7DBF
            dc.w    $796F,$7753,$66EB,$52CC,$77C3,$F995,$32E3,$A927
            dc.w    $80CC,$AED6,$4E2B,$E89D,$375B,$BD28,$AD1A,$3D05
            dc.w    $2B1B,$42B3,$16C4,$4C71,$4D54,$BFA8,$E57D,$DC7A
            dc.w    $EC6D,$8144,$5A71,$046B,$D822,$9650,$87FC,$8F24
            dc.w    $CBC6,$0E09,$B639,$0366,$D9F7,$6092,$D393,$A70B
            dc.w    $1D31,$A08A,$9CD9,$71C9,$5C1E,$F445,$86FA,$B694
            dc.w    $FDB4,$4165,$8EAA,$FCBE,$4BCA,$C6EB,$FB7A,$94E5
            dc.w    $5789,$D04E,$FA13,$CF35,$236B,$8DA9,$4133,$F000
            dc.w    $6224,$261C,$F412,$F23B,$E75E,$56A4,$3002,$2116
            dc.w    $BAF1,$7F1F,$D098,$72F9,$C1A3,$699C,$F1E8,$02AA
            dc.w    $0DD1,$45DC,$4FDC,$E093,$8D84,$12F0,$6CD0,$F376
            dc.w    $3DE6,$B73D,$84BA,$737F,$B43A,$30F2,$4456,$9F69
            dc.w    $00E4,$EACA,$B58D,$E3B0,$9591,$13C8,$D62E,$FEE9
            dc.w    $9086,$1F83,$CED6,$9874,$2F79,$3CEE,$E857,$1C30
            dc.w    $4836,$65D1,$AB07,$B031,$914C,$844F,$15BF,$3BE8
            dc.w    $2C3F,$2A9A,$9EB9,$5FD4,$92E7,$472D,$2297,$CC5B
            dc.w    $EE5F,$2782,$5377,$B562,$DB8E,$BBCF,$F961,$DEDD
            dc.w    $C59B,$5C60,$1BD3,$910D,$26D2,$06AD,$B285,$14D8
            dc.w    $5ECF,$6B52,$7FEA,$78BB,$5048,$79AC,$ED34,$A884
            dc.w    $36E5,$1D3C,$1753,$741D,$8C47,$CAED,$9D0A,$40EF
            dc.w    $3145,$E221,$DA27,$EB70,$DF73,$0BA3,$183C,$8789
            dc.w    $739A,$C0A6,$9A58,$DFC6,$54B1,$34C1,$AC3E,$242E
            dc.w    $CC49,$3902,$7B2D,$DA99,$8F15,$BC01,$29FD,$38C7
            dc.w    $27D5,$318F,$604A,$AFF5,$F29C,$6818,$C38A,$A2EC
            dc.w    $1019,$D4C3,$A8FB,$936E,$20ED,$7B39,$0B68,$6119
            dc.w    $89A0,$906F,$1CC7,$829E,$9952,$EF4B,$850E,$9E8C
            dc.w    $CD06,$3A90,$6700,$2F8E,$CFAC,$8CB7,$EAA2,$4B11
            dc.w    $988B,$4E6C,$46F0,$66DF,$CA7E,$EC08,$C7BB,$A664
            dc.w    $831D,$17BD,$63F5,$75E6,$9764,$350E,$4787,$0D42
            dc.w    $026C,$A4A2,$8167,$D587,$61B6,$ADAB,$AA65,$64D2
            dc.w    $70DA,$237B,$25E1,$C74A,$A1C9,$01A0,$0EB0,$A5DA
            dc.w    $7670,$F741,$51C0,$5AEA,$933D,$FA32,$0759,$FF1A
            dc.w    $5601,$0AB8,$5FDE,$CB78,$3F32,$EDF8,$AEBE,$DBB9
            dc.w    $39F8,$326D,$D208,$58C5,$9B63,$8BE4,$A572,$C80A
            dc.w    $28E0,$A19F,$4320,$99FC,$3A37,$C3CD,$BF95,$C585
            dc.w    $B392,$C12A,$6AA7,$07D7,$52F6,$6A61,$12D4,$83B1
            dc.w    $9643,$5B5E,$3E75,$802B,$3BA5,$2B33,$A99F,$51A5
            dc.w    $BDA1,$E157,$78C2,$E70C,$FCAE,$7CE0,$D160,$2267
            dc.w    $2AFF,$AC4D,$4A51,$0947,$0AB2,$B83A,$7A04,$E579
            dc.w    $340D,$FD80,$B916,$E922,$E29D,$5E9B,$F562,$4AF4
            dc.w    $4CA9,$D9AF,$6BBD,$2CFE,$E3B7,$F620,$C274,$6E07
            dc.w    $5B42,$B9B6,$A069,$19BC,$F0F2,$C40F,$7221,$7AB5
            dc.w    $14C1,$9DF3,$F380,$2DAE,$E094,$BEB4,$A210,$1AFF
            dc.w    $0529,$575D,$55CD,$B27C,$A33B,$DDB2,$6528,$B37D
            dc.w    $740C,$05DB,$E96A,$62C4
            dc.b    '@x(Fm0'
            dc.w    $D706,$BBF4,$8E2C,$BCE2,$D3DE,$049E,$37FA,$01B5
            dc.w    $E634,$2D88,$6D8D,$7E5A,$2E7E,$D741,$2013,$06E9
            dc.w    $0F97,$E45D,$3EBA,$B8AD,$3386,$1305,$1B25,$0C03
            dc.w    $5354,$71C8,$9B75,$C638,$FBD0,$197F,$11A1,$EF0F
            dc.b    $08,$FB,$F8,$44,$86,$51,$38,$40,$95
            dc.b    'cE/DC]FMU'
            dc.w    $03D8,$764C,$B1B8,$D638,$A70B,$BA2F,$94B3,$D210
            dc.w    $EB66,$92A7,$D409,$C2D9,$6883,$8526,$A6DB,$8A15
            dc.w    $751F,$6C98,$DE76,$9A88,$C9EE,$4668,$1A82,$A373
            dc.w    $0896,$AA49,$4223,$3681,$F62C,$55CB,$9F1C,$5404
            dc.w    $F74F,$B15C,$C06E,$4312,$6FFE,$5D72,$8AA8,$678B
            dc.w    $337C,$D129,$8211,$CEFD,$61B0,$B02F,$00E2,$7716
            dc.w    $BF32,$D884,$6FA3,$56FF,$3584
            dc.b    $27,' T`rax('
            dc.w    $C5AE,$2942,$11CF,$4E81,$528B,$DD54,$57A7,$0D9D
            dc.w    $32BE,$AF55,$B23F,$3F86,$99A0,$DBB4,$AF42,$D744
            dc.w    $DC65,$0C93,$ECF0,$E359,$680B,$046D,$F2EF,$1BF2
            dc.w    $4487,$5951,$46D2,$8BDF,$D42B,$2B0D,$38EA,$AC18
            dc.w    $A09F,$73AF,$8D78,$68AE,$BA06,$C5FF,$A500,$8DB3
            dc.w    $6B2D,$A040,$D9B7,$8583,$C012,$B5FC,$22E3,$2397
            dc.w    $14D5,$A795,$C69A,$B43F,$BCDB,$628D,$4AE0,$187A
            dc.w    $5941,$A949,$1C34,$77CB,$9482,$1453,$0C67,$478A
            dc.w    $1253,$754A,$E323,$7EA8,$C1E7,$9087,$BFAF,$D219
            dc.w    $BBE5,$6085,$00CB,$3E69,$40A4,$3B7D,$5F5B,$B95E
            dc.w    $86F7,$08CD,$C2E1,$02F7,$AD77,$40B5,$DAF1,$8E72
            dc.w    $5492,$740F,$A82C,$3094,$F8E8,$C925,$810A,$89FA
            dc.w    $96C6,$7C43,$75D1,$2F36,$B383,$A461,$C74F,$4426
            dc.w    $906D,$2009,$3EDA,$2C41,$DFD8,$D8E0,$6097,$D08B
            dc.w    $1A03,$5EBB,$EA72,$AD56,$0825,$795B,$1388,$7D6F
            dc.w    $4DFE,$E7D9,$F74E,$EC89,$19A1,$82F0,$B55F,$0B70
            dc.w    $FCD4,$C433,$D7C7,$0305,$C3B8,$9CCC,$826E,$9B0A
            dc.w    $5848,$B3A4,$7130,$633D,$24ED,$3DDC,$E217,$B837
            dc.w    $6E76,$0139,$FDAC,$5CA2,$3769,$6BBE,$5B59,$883B
            dc.w    $AEBB,$21D6,$E605,$53B6,$23CD,$F5F1,$CB80,$4ACF
            dc.w    $04C2,$4C3A,$91B4,$DA45,$E998,$B15F,$7B24,$57A7
            dc.w    $4CBC,$674E,$0B1D,$B0D1,$8A3D,$E9D0,$677B,$382F
            dc.w    $9DC0,$3403,$1701,$1A9B,$1B02,$E5DE,$7DA9,$33C4
            dc.w    $A173,$4D1B,$8B0F
            dc.b    '7n/o$~.'
            dc.b    $EE,$27,$F6,$CF,$A8,$28,$14,$E0,$4D,$15,$5A,$E7,$7E,$25,$92,$48
            dc.b    $3C,$17,$47,$31,$43,$99,$23,$CD,$46,$DF,$1A,$06,$D9,$72,$4F,$69
            dc.b    $E6,$B7,$6B,$70,$FA,$B6,$A5,$36,$FB,$F4,$EE,$09,$51,$EE,$35,$7E
            dc.b    $EC,$87,$4D,$B9,$52,$52,$57,$9C,$1F,$FE,$E4,$0F,$32,$5D,$4B,$30
            dc.b    $09,$BC,$71,$EF,$8A,$FD,$AC,$88,$4B,$4B,$9C,$50,$CC,$F7,$2B,$B8
            dc.b    $8E,$7B,$0B,$97,$4C,$AB,$D3,$CC,$8C,$58,$C9,$61,$C5,$2D,$73,$42
            dc.b    $28,$5A,$FB,$05,$BF,$AA,$76,$62,$27,$76,$E8,$BD,$F9,$C7,$0E,$29
            dc.b    $1E,$FB,$48,$18,$9D,$CA,$F4,$0A,$79,$0F,$29,$8C,$9E,$9F,$1C,$F3
            dc.b    $D3,$65,$8E,$74,$70,$C2,$CE,$3B,$26,$6D,$04,$D3,$DF,$8C,$C7,$80
            dc.b    $8D,$92,$BD,$43,$C9,$A8,$8C,$B4,$90,$5B,$52,$84,$0D,$32,$D8,$FF
            dc.b    $58,$D9,$B2,$7F,$C8,$0E,$D2,$2C,$15,$7A,$63,$6F,$5A,$56,$99,$9E
            dc.b    $18,$F0,$50,$DB,$F2,$42,$67,$51,$29,$A2,$3C,$2A,$1A,$98,$66,$9B
            dc.b    $19,$1E,$88,$15,$40,$D3,$F5,$89,$F3,$D1,$64,$F5,$5C,$13,$CA,$D5
            dc.b    $45,$F3,$AA,$F0,$AB,$5F,$A1,$D0,$B6,$9A,$EC,$49,$08,$A5,$E5,$3A
            dc.b    $A2,$E2,$12,$A2,$54,$9D,$6C,$F6,$0E,$2E,$90,$1E,$6B,$12,$79,$6C
            dc.b    $36,$C8,$C2,$83,$AD,$41,$1D,$21,$63,$07,$D7,$E4,$35,$46,$11,$DE
            dc.b    $74,$A6,$96,$5A,$93,$E4,$34,$26,$60,$26,$C3,$E5,$7F,$F1,$10,$95
            dc.b    $F5,$93,$A9,$8F,$91,$BA,$2E,$B7,$4A,$C3,$65,$EE,$04,$55,$38,$A7
            dc.b    $E9,$1D,$75,$DD,$3E,$CC,$31,$53,$E4,$BB,$77,$E8,$21,$91,$B7,$0E
            dc.b    $44,$06,$91,$D6,$5E,$DE,$16,$5C,$A6,$A3,$78,$C9,$68,$CD,$13,$34
            dc.b    $D0,$CE,$00,$66,$94,$71,$0C,$28,$3A,$E6,$2D,$C8,$7A,$1C,$1E,$F9
            dc.b    $7D,$E0,$AB,$92,$AA,$B2,$46,$79,$2E,$4F,$B9,$FA,$DE,$51,$74,$AC
            dc.b    $1C,$69,$68,$25,$57,$E8,$98,$55,$37,$45,$A6,$6D,$A3,$96,$1F,$4B
            dc.b    $99,$DC,$7F,$3C,$F8,$49,$02,$02,$0C,$6E,$17,$FB,$7C,$C0,$FD,$87
            dc.b    $47,$CB,$8F,$EB,$6A,$84,$58,$CE,$B9,$64,$BC,$F1,$96,$10,$21,$AA
            dc.b    $D6,$50,$C0,$1F,$B3,$AE,$C5,$D1,$75,$86,$4C,$9A,$22,$7F,$E3,$85
            dc.b    $1B,$3C,$B8,$AB,$33,$31,$9A,$4E,$FD,$EB,$C6,$65,$13,$E1,$E9,$E1
            dc.b    $64,$48,$B1,$35,$85,$8F,$DD,$A3,$E2,$36,$D4,$1D,$07,$70,$E1,$9F
            dc.b    $5D,$C1,$27,$3F,$39,$83,$6A,$98,$B1,$A1
            dc.b    '03q:,x'
            dc.b    $81,$0A,$5D,$16,$86,$D5,$06,$01,$50,$05,$C8,$B6,$8F,$BE,$F8,$A6
            dc.b    $C1,$2A,$82,$03,$11,$80,$BA,$4F,$10,$EA,$9F,$76,$CA,$EF,$80,$CA
            dc.b    $3B,$D4,$7C,$47,$55,$BD,$07,$ED,$89,$FA,$C1,$7A,$95,$39,$9E,$2B
            dc.b    $56,$16,$DA,$D2,$6C,$CF,$2A,$41,$A5,$6A,$AD,$B1,$EB,$81,$DB,$5E
            dc.b    $F6,$6C,$E6,$2D,$9B,$9E,$EF,$07,$FC,$66,$62,$10,$BD,$94,$20,$20
            dc.b    $49,$F9,$5C,$39,$62,$19,$A0,$F4,$B0,$F2,$F9,$63,$B2,$97,$EB,$73
            dc.b    $14,$43,$08,$64,$66,$1F,$ED,$0D,$CE,$F8,$3E,$FE,$DC,$C6,$E7,$A4
            dc.b    $31,$8A,$BF,$8E,$38,$22,$F3,$45,$B5,$95,$7B,$5D,$DD,$FC,$15,$93
            dc.b    $BA,$11,$01,$A9,$C3,$F6,$22,$BE,$2A,$ED,$FE,$7C,$C4,$09,$EA,$3D
            dc.b    $9C,$FF,$24,$C4,$D7,$D6,$D5,$6A,$F4,$48,$76,$00,$CE,$42,$5C,$8F
            dc.b    $FA,$BE,$C6,$79,$96,$D0,$CC,$61,$0C,$B2,$A1,$D0,$1D,$AD,$AE,$8C
            dc.b    $7A,$0A,$B5,$D3,$92,$02,$0B,$2E,$45,$30,$32,$55,$88,$8B,$63,$02
            dc.b    $49,$92,$73,$20,$E4,$2E,$98,$A9,$2D,$B7,$08,$17,$DF,$EB,$68,$58
            dc.b    $AA,$20,$31,$86,$A6,$22,$5D,$08,$23,$3F,$66,$BA,$BE,$7E,$48,$53
            dc.b    $BF,$6E,$96,$68,$4E,$E6,$3B,$D6,$3D,$D4,$6E,$C4,$F8,$4B,$2E,$89
            dc.b    $A7,$0C,$A5,$AD,$9D,$F0,$C3,$9E,$2E,$6D,$86,$6D,$FB,$19,$27,$FE
            dc.b    $8A,$A4,$DB,$62,$D2,$F4,$C0,$6E,$25,$8A,$1D,$B2,$F9,$AB,$7E,$0F
            dc.b    $9E,$FB,$CB,$5A,$79,$13
            dc.b    '+j*x4M'
            dc.b    $A3,$08,$07,$7B,$50,$A3,$78,$DA,$3F,$B0,$E5,$A6,$81,$94,$EF,$41
            dc.b    $4F,$AF,$88,$94,$C2,$52,$37,$4B,$69,$45,$17,$3E,$46,$6A,$A6,$60
            dc.b    $44,$2F,$BF,$64,$FC,$91,$85,$FF,$C3,$BC,$8C,$07,$E2,$DC,$11,$19
            dc.b    $6F,$C2,$DE,$9B,$41,$76,$F0,$06,$B9,$DB,$39,$31,$72,$67,$97,$50
            dc.b    $DB,$CA,$65,$52,$04,$79,$B1,$AA,$01,$6B,$7F,$1D,$B1,$AA,$83,$4C
            dc.b    $35,$9B,$12,$15,$07,$69,$59,$33,$5A,$B6,$6F,$C3,$D5,$1F,$7D,$56
            dc.b    $ED,$F2,$74,$F2,$94,$5D,$49,$16,$02,$77,$B2,$DB,$E8,$3E,$92,$EF
            dc.b    $61,$E0,$D5,$DD,$A0,$14,$EE,$C0,$7F,$BB,$0C,$3B,$3E,$BF,$9A,$46
            dc.b    $B8,$EE,$51,$3A,$CF,$C5,$77,$F6,$BC,$D1,$62,$DF,$D9,$07,$95,$B7
            dc.b    $18,$EC,$1A,$38,$95,$68,$A8,$1E,$B7,$7C,$3F,$3C,$47,$9D,$1F,$EC
            dc.b    $76,$C3,$B6,$11,$32,$A7,$33,$BD,$A9,$98,$3A,$D4,$34,$93,$D7,$99
            dc.b    $BB,$9E,$D2,$66,$70,$00,$FA,$DC,$1C,$56,$BE,$48,$43,$09,$4C,$A4
            dc.b    $91,$6F,$F2,$B9,$C4,$A2,$93,$C9,$33,$2D,$42,$28,$EB,$1E,$F4,$BB
            dc.b    $77,$06,$9B,$B6,$5C,$A9,$A0,$2C,$DA,$8F,$16,$91,$D4,$B4,$4F,$0E
            dc.b    $5E,$8C,$E7,$A5,$2B,$9F,$61,$E4,$5F,$49,$2D,$EE,$16,$D9,$D9,$27
            dc.b    $C5,$DA,$71,$1A,$09,$47,$A9,$2A,$C0,$A5,$22,$72,$15,$1B,$10,$01
            dc.b    $1A,$FA,$EA,$5F,$7D,$54,$19,$5D,$E0,$90,$CE,$63,$8D,$C4,$F7,$98
            dc.b    $EA,$81,$D6,$2F,$38,$1D,$14,$D5,$21,$AE,$23,$14,$65,$38,$D3,$E1
            dc.b    $26,$35,$3E,$A7,$48,$E1,$C8,$75,$D3,$7B,$BB,$B4,$E7,$0F,$FB,$E5
            dc.b    $0E,$EF,$28,$9A,$BA,$BA,$99,$7F,$7C,$50,$C2,$D8,$87,$C9,$5B,$90
            dc.b    $9A,$6C,$B9,$FC,$F0,$DD,$E9,$D1,$58,$62,$ED,$71,$56,$04,$55,$04
            dc.b    $67,$EA,$3D,$80,$7B,$E5,$6A,$E7,$AD,$FF,$57,$1C,$54,$E4,$C1,$D2
            dc.b    $B3,$15,$2F,$A2,$FF,$21,$01,$A3,$F3,$7A,$26,$F9,$CC,$CF,$C9,$12
            dc.b    $80,$2C,$67,$CB,$CA,$FC,$24,$32,$24,$FE,$2A,$78,$D8,$B8,$69,$37
            dc.b    $A8,$74,$A2,$F0,$A2,$99,$47,$0D,$8B,$18,$E2,$C8,$C6,$F7,$60,$7E
            dc.b    $0B,$F6,$AD,$BC,$85,$58,$C5,$4E,$74,$CB,$F1,$C2,$14,$0E,$8F,$B1
            dc.b    $4A,$C0,$B8,$45,$00,$C8,$A7,$54,$62,$64,$5F,$CF,$5D,$4A,$B4,$84
            dc.b    $66,$D6,$A3,$E3,$FE,$95,$F5,$7A,$20,$4C,$4D,$B0,$A1,$43,$0D,$C7
            dc.b    $82,$85,$A4,$44,$BD,$88,$5E,$7D,$E9,$AC,$3C,$AF,$EC,$63,$4B,$0A
            dc.b    $39,$C1,$EC,$39,$03,$D5,$8A,$E2,$AB,$4F,$F6,$5B,$71,$B3,$81,$95
            dc.b    $2F,$17,$53,$47,$F6,$E7,$52,$3F,$97,$E9,$F9,$7C,$89,$DF,$94,$13
            dc.b    $DD,$72,$B3,$69,$2C,$97,$40,$CA,$84,$80,$D1,$70,$F7,$0B,$4E,$30
            dc.b    $12,$A0,$56,$B3,$9C,$CC,$15,$1B,$E1,$37,$E6,$CC,$60,$E2,$9D,$6F
            dc.b    $52,$0D,$BC,$8D,$3C,$3C,$1B,$18,$8E,$39,$CA,$23,$AE,$D7,$05,$B8
            dc.b    $31,$89,$DC,$EA,$36,$A8,$F3,$77,$63,$4D,$4A,$51,$EF,$5E,$02,$FD
            dc.b    $F2,$5F,$09,$FA,$FD,$36,$AA,$35,$6C,$71,$9E,$E6,$17,$5A,$E1,$9F
            dc.b    $1E,$3D,$DF,$49,$73,$4E,$B0,$AC,$83,$7F,$35,$97,$F4,$31,$8E,$A1
            dc.b    $53,$32,$D0,$F8,$A5,$16,$46,$93,$19,$FD,$AB,$74,$CD,$1C,$FE,$83
            dc.b    $40,$26,$89,$1F,$59,$51,$7A,$87,$EE,$66,$87,$40,$DE,$44,$FD,$AE
            dc.b    $4C,$55,$FF,$C6,$1B,$70,$F8,$8E,$90,$A1,$03,$ED,$29,$B1,$8B,$9D
            dc.b    $E6,$B9,$AF,$26,$C8,$12,$84,$59,$F1,$CD,$29,$BF,$27,$41,$38,$03
            dc.b    $9B,$F5,$AC,$AB,$05,$40,$44,$43,$CB,$F8,$82,$A0,$10
            dc.b    'ursjFP'
            dc.w    $8811,$D270,$214D,$61E4,$0B55,$2390,$5ED6,$6021
            dc.w    $0C22,$290A,$8568,$D8C7,$5CC9,$B591,$346D,$591E
            dc.w    $B5E5,$1025,$2DAF,$96EB,$65DC,$A61C,$3699,$8318
            dc.w    $6728,$1141,$7664,$DEDA,$D7AC,$337B,$9CB0,$87BA
            dc.w    $2B8F,$735A,$F375,$C66B,$E857,$E3DD,$296B,$3445
            dc.w    $C14B,$C70E,$3D7E,$24FC,$E03B,$86E8,$EB08,$25CF
            dc.w    $FB93,$CED4,$8A9F,$D36D,$F5B4,$3AD8,$10C1,$570F
            dc.w    $82D0,$8EE3,$D9C7,$BD6C,$CD8C,$2B20,$DE98,$E813
            dc.w    $4AE3,$2880,$42B2,$2AB7,$C530,$1A54,$9237,$F343
            dc.w    $8106,$0130,$BE6E,$F900,$4F5B,$5BBD,$F7D7,$0358
            dc.w    $8B0D,$F12C,$05B5,$8DCD,$A842,$5336,$0913,$9A64
            dc.w    $F178,$2706,$6C51,$0504,$57B6,$9CE0,$E91F,$5C75
            dc.w    $9686,$659C,$CE0F,$827C,$240A,$3BC4,$253A,$ED8D
            dc.w    $F4D1,$7D79,$22A4,$849F,$6BF5,$3A13,$DB47,$0FA7
            dc.w    $3FED,$F597,$74B2,$A82D,$2E39,$1B01,$C668,$BA41
            dc.w    $E59E,$696D,$3AEE,$973F,$5F48,$E1E9,$E028,$9023
            dc.w    $7B57,$6467,$E6C7,$E080,$FBA8,$3C77,$1A13,$BF9D
            dc.w    $F688,$2C3E,$B876,$E4EA,$C142,$D824,$0C0F,$31CE
            dc.w    $FD5C,$8BF3,$76DA,$CDEC,$51AB,$4D49,$19C6,$C35F
            dc.w    $2904,$EDBF,$EB08,$DD7C,$0A6F,$74D3,$3B98,$D7D5
            dc.w    $B0C0,$E300,$84FD,$B861,$A6D5,$3BCC,$8C91,$BBB7
            dc.w    $17A6,$575C,$5D74,$F1DD,$F1A4,$4B3D,$5C64,$1508
            dc.w    $DDBB,$76ED,$5317,$52E0,$C463,$1014,$4197,$EB5B
            dc.w    $A202,$4160,$B1F0,$BC94,$6A7C,$AC4B,$70D8,$4AB4
            dc.w    $A424,$9B6A,$C0AC,$35DC,$D9A5,$AA30,$2BC9,$D6EB
            dc.w    $FEEB,$065E,$EAB7,$55B9,$9035,$683A,$010E,$421F
            dc.w    $10D0,$21C6,$A980,$C863,$78C1,$7DEE,$B734,$B1C8
            dc.w    $301F,$C52F,$2D2C,$862B,$FF7D,$A962,$9441,$A3D9
            dc.w    $7F59,$1718,$BD01,$C683,$5582,$B0FE,$00FF,$190C
            dc.w    $9F73,$5BD7,$56EC,$8847,$F2D4,$11C4,$DF51,$B288
            dc.w    $068C,$AE2E,$28B3,$56B6,$3610,$5A12,$3EBA,$6E0F
            dc.w    $8906,$03BC,$6649,$2809,$3C14,$7E48,$8685,$4338
            dc.w    $E49F,$FBE7,$1358,$D571,$E30C,$0816,$12F1,$820A
            dc.w    $C972,$9999,$228F,$A633,$DE9A,$C7D2,$464C,$8452
            dc.w    $73BF,$7B36,$16DB,$1FAF,$02AA,$B99C,$A0B4,$D1D4
            dc.w    $F7D9,$E7A3,$D060,$651B,$50F2,$7272,$AA69,$B3DA
            dc.w    $9753,$EFE4,$0D1E,$9443,$779D,$33FA,$8F1A,$47BA
            dc.w    $8EDD,$F789,$9965,$3F55,$57C2,$C99E,$3526,$44AA
            dc.w    $D554,$1E10,$F3D6,$EE9A,$0BB6,$8D79,$9DD2,$B5AC
            dc.w    $CF7E,$9F21,$5E05,$D054,$2A5F,$F37D,$D6FE,$6691
            dc.w    $6C36,$045D,$1E4A,$9C1E,$EF1B,$3757,$7120,$803C
            dc.w    $CB19,$96CD,$593A,$F968,$A7CE,$22CB,$60EA,$EC7B
            dc.w    $6803,$26A4,$1855,$D2A5,$CA15,$F404,$2FA2,$1806
            dc.w    $CD87,$9EAB,$BEB1,$5840,$95FC,$2AB8,$4071,$38EF
            dc.w    $F83F,$61A1,$C812,$142A,$61C5,$FFA8,$0F8A,$4511
            dc.w    $8A9C,$2965,$7262,$FDE6,$2786,$50F8,$A50A,$D94F
            dc.w    $7CA1,$CA02,$E8C4,$F06F,$E9F5,$5FE8,$1C0B,$858A
            dc.w    $5277,$B4E3,$4DA7,$E9CF,$E7CA,$8AFC,$CCFA,$8FE1
            dc.w    $7E50,$A7BD,$B97A,$530B,$C7DE,$818C,$67E2,$A2D8
            dc.w    $442D,$3646,$1D93,$91F6,$982A,$0193,$3D2B,$2D51
            dc.w    $BF38,$EA87,$B678,$398B,$7909,$5C2C,$0366,$CBAE
            dc.w    $31FB,$6A19,$343D,$FC1A,$42DF,$7856,$AF37,$7FFF
            dc.w    $ACCC,$6350,$26D1,$5D84,$FA46,$E259,$0ECD,$62F2
            dc.w    $F423,$B6BB,$BC32,$9D8F,$4C96,$C464,$374E,$4E69
            dc.w    $838D,$5E9B,$BB94,$02C1,$435A,$BEE5,$2190,$B7DE
            dc.w    $246C,$40FB,$6D99,$6FAD,$D84B,$3495,$E143,$6CB3
            dc.w    $1B07,$CE25,$5B5E,$798E,$49C3,$321D,$8B8E,$3D53
            dc.w    $C3E7,$D303,$D3E4,$DC0D,$936A,$30F5,$6FDC,$C0A2
            dc.w    $4ED7,$4998,$09B9,$2774,$B4B5,$A1E2,$9EE6,$A007
            dc.w    $DCE0,$0E31,$4AAD,$1D82,$E21C,$984E,$9B2F,$E87A
            dc.w    $AD25,$6D17,$EC2E,$AFF1,$116D,$C258,$CEA3,$2B45
            dc.w    $A161,$87FD,$45F9,$C190,$6944,$2EB1,$D275,$4CA0
            dc.w    $A392,$1CC2,$FC29,$6B8D,$1F6E,$4F4D,$7AC8,$DF5A
            dc.w    $F9E1,$0939,$96F8,$DA9F,$87B0,$E6BE,$80E9,$7378
            dc.w    $3340,$1626,$65EF,$5428,$F545,$71CA,$B55D,$AD6B
            dc.w    $4B52,$F632,$B3E5,$D43B,$ED3C,$92F9,$C2AE,$A57F
            dc.w    $6B1D,$0A05,$6E84,$20F7,$634D,$7CC7,$B230,$0535
            dc.w    $9A33,$8976,$1522,$12D1,$644F,$CC27,$A883,$48B0
            dc.w    $8D18,$131C,$D431,$1A4C,$D789,$0D70,$5ABC,$25B2
            dc.w    $3879,$E5F4,$7D56,$246C,$BA27,$6781,$82F7,$4644
            dc.w    $AB3B,$7A15,$7595,$0729,$540D,$23A9,$85D3,$5166
            dc.w    $C55B,$0085,$4F6B,$0B86,$DABD,$75F0,$0711,$F2DF
            dc.w    $D1B8,$BDC5,$EEF4,$8EB5,$929B,$0C96,$08AF,$DE75
            dc.w    $25CB,$FE37,$47E8,$ABDB,$587F,$9AD0,$48F3,$F842
            dc.w    $043E,$8C73,$2070,$2F22,$91A9,$CFD6,$0516,$FA34
            dc.w    $818B,$7720,$14A0,$3E6E,$3200,$83A6,$62E3,$707E
            dc.w    $9C81,$600E,$2C7B,$A44A,$88BE,$59C3,$F0F6,$95C9
            dc.w    $2321,$9392,$39CF,$DBC0,$AE67,$7F19,$B458,$E0C3
            dc.w    $EBFB,$6D37,$05F2,$2F95,$D838,$5E6E,$1A99,$A155
            dc.w    $5BA3,$35ED,$5DB1,$E8B8,$90EC,$3E2E,$0767,$1606
            dc.w    $476F,$848F,$E1AA,$8D0E,$A0C7,$F829,$8704,$FAE6
            dc.w    $BCBD,$97E1,$59D8,$82EF,$B64C,$B0D0,$76AF,$2072
            dc.w    $4D94,$6B27,$2980,$6F16,$8F44,$24D6,$3BD5,$6A3C
            dc.w    $A1A4,$3F4C,$8917,$B2A1,$3556,$EF26,$CAC8,$EC02
            dc.w    $845F,$E6FE,$E650,$4E77,$387C,$142F,$85FC,$B16F
            dc.w    $3DC4,$54FC,$C6D6,$78B0,$A702,$4548,$D6F5,$0A69
            dc.w    $4BAD,$2BA2,$1BE4,$680A,$E09B,$1E3A,$B1F8,$6E36
            dc.w    $6CE6,$9F8D,$324F,$9B5E,$8C89,$395C,$06F0,$BB53
            dc.w    $DA09,$E763,$D196,$DA6A,$0AF1,$0870,$E477,$CB40
            dc.w    $5E22,$EB44,$B890,$D13E,$7442,$0365,$6BD0,$C23B
            dc.w    $1E23,$D9DD,$8BDB,$4375,$0EB7,$0B73,$40EE,$ACA4
            dc.b    $4A,$07,$1D,$E2,$A6,$CA,$2A,$EC,$4E,$0E,$A5
            dc.b    $2B,$49,$27,'aZzr'
            dc.w    $CD62,$01CF,$CEFF,$B3A8,$8EC7,$E735,$918E,$4254
            dc.w    $EE9F,$128C,$8820,$08EA,$E21F,$F474,$0DE5,$BEF6
            dc.w    $8FC4,$ABD7,$A7DB,$5830,$87C6,$0D18,$7E9B,$0B4A
            dc.w    $B3AF,$3775,$8BD3,$730F,$D6B3,$7088,$9A7B,$9655
            dc.w    $F2A8,$30C1,$8696,$4161,$D7AD,$FD3C,$2335,$5C73
            dc.w    $94C1,$C25B,$1ABA,$5ADA,$D0F1,$7D06,$9CF8,$8081
            dc.w    $2E07,$7586,$A91B,$036C,$119E,$7119,$80B9,$0945
            dc.w    $C3D2,$B09D,$B5A0,$DD66,$E1C9,$FC1B,$3094,$A484
            dc.w    $2688,$EA8E,$92A7,$63C0,$A62C,$F637,$2D56,$97EB
            dc.w    $5C66,$025E,$17F4,$672C,$25BB,$ED11,$3691,$52E8
            dc.w    $CC4E,$3FD4,$DDDE,$D33D,$B4C0,$C34E,$4490,$6D93
            dc.w    $50CF,$2DD2,$311C,$7EA6,$6728,$EE1E,$60E9,$57CC
            dc.w    $37B4,$A346,$ED09,$D53F,$4014,$B9AC,$AE41,$D047
            dc.w    $6311,$2CBC,$F146,$B700,$66F2,$9B2B,$6C85,$AE6E
            dc.w    $AB04,$78ED,$526B,$3EA0,$7B7C,$C0FE,$004F,$B260
            dc.w    $FECE,$BD34,$F959,$FBB8,$B947,$101F,$8CC2,$39BA
            dc.w    $BA74,$158F,$F31E,$6936,$DCF5,$3152,$E9DA,$C810
            dc.w    $F023,$D4CB,$3D30,$DBCD,$997E,$4FFA,$B8C5,$F382
            dc.w    $BF08,$E9EF,$E40B,$942F,$74BC,$DC97,$FF99,$79CE
            dc.w    $3CEB,$F179,$29A5,$6068,$A2E4,$6812,$2C5B,$2EBE
            dc.w    $FC86,$7239,$1952,$AD71,$90B7,$1C6D,$C6CD,$AC03
            dc.w    $C539,$BFA2,$F660,$20A5,$C84A,$647B,$69DC,$1691
            dc.w    $5951,$191D,$D438,$6670,$8576,$AF41,$E34D,$88A9
            dc.w    $72E7,$A87E,$D331,$92C6,$286C,$560D,$5D81,$1F51
            dc.w    $0542,$FE85,$C0B6,$2321,$38A3,$817F,$5B0F,$279C
            dc.w    $898C,$62B4,$A317,$6F2E,$34AA,$9595,$E51D,$D29A
            dc.w    $21D5,$B5F4,$F5F3,$24F7,$4880,$C4B2,$9D57,$A54B
            dc.w    $B600,$D7D3,$DFF6,$E29E,$1F93,$36F3,$AD7A,$D9B0
            dc.w    $753F,$340B,$A07F,$3CE9,$554B,$8313,$C7B1,$2A3E
            dc.w    $81F7,$E332,$0F12,$4429,$7D25,$0CB3,$9667,$0F8A
            dc.w    $7661,$33A1,$8AAB,$9D8B,$CA8A,$F06B,$DB13,$CCFF
            dc.w    $AF97,$E8DE,$4110,$1DF9,$4B01,$9125,$71DF,$F81A
            dc.w    $182D,$DE87,$4245,$F7DF,$DEEE,$7F31,$4FBD,$FA16
            dc.w    $019A,$5020,$9354,$464D,$1518,$54E3,$FB64,$9A62
            dc.w    $1CB2,$2805,$BE84,$8A83,$3B49,$CD76,$770D,$AA92
            dc.w    $732A,$BB24,$FDD1,$9E98,$D2E8,$0043,$4789,$A92D
            dc.w    $5858,$7BC9,$490C,$3A78,$7C9D,$453A,$7998,$BA57
            dc.w    $A4B5,$6A7D,$95E3,$9FB9,$27AE,$C7D9,$9887,$4CDC
            dc.w    $53AC,$7C59,$6405,$438D,$C424,$2149,$126D,$2226
            dc.w    $1B71,$CBC2,$338B,$86B6,$C992,$F9FD,$4CFB,$F564
            dc.w    $BC9C,$8D5A,$627D,$5FBB,$D53D,$2B14,$5F68,$98B5
            dc.w    $2221,$250A,$F4D9,$65E1,$3AE0,$48E0,$C1BF,$6E9F
            dc.w    $02A9,$9C2A,$4DF9,$827A,$0CF0,$14E7,$13D7,$180C
            dc.b    'W2/cFP'
            dc.w    $FFAB,$0EFD,$C5E2,$061A,$13D1,$07FA,$55DD,$F7CC
            dc.w    $C1AE,$7A03,$EC48,$7078,$1128,$CFCA,$9340,$BD34
            dc.w    $5153,$9E83,$8EBF,$6522
            dc.b    'a;V_S3'
            dc.w    $1015,$CEC5,$4A79,$EFC3,$5AA6,$A25D,$0982,$2615
            dc.w    $D8D8,$7765,$B75D,$9908,$A8EA,$DF5C,$5133,$1769
            dc.w    $EACB,$CFA7,$04BE,$F26A,$32C8,$0401,$AAD4,$C9E5
            dc.w    $8343,$E51C,$B98F,$D895,$BD66,$8A92,$B89A,$BB2E
            dc.w    $FA0A,$5642,$DE5B,$9B33,$1E37,$6359,$F33A,$FD57
            dc.w    $A71E,$B7F9,$91AA,$4213,$E7CE,$2415,$D0A3,$670D
            dc.w    $CB80,$A1AE,$C43C,$6E9A,$3452,$7F29,$9A9F,$DA8A
            dc.w    $1B88,$A685,$0CF9,$E49D,$E26D,$6AA6,$1F4E,$4CEB
            dc.w    $A090,$3CC1,$7CCC,$43E7,$4620,$0708,$7608,$2BB6
            dc.w    $DAF5,$1132,$7E26,$B08E,$21B5,$EE04,$3967,$D13E
            dc.w    $9DD8,$46DC,$3717,$ACD9,$8A93,$7A2C,$841F,$9452
            dc.w    $4B35,$146D,$5EF1,$EB70,$3B6B,$8490,$78A1,$BDBC
            dc.w    $1DAE,$9AB8,$075E,$A424,$2A42,$3DFC,$7003,$B181
            dc.w    $9694,$D7B1,$949B,$F531,$E64D,$2745,$B591,$C6C2
            dc.w    $0989,$C23B,$25AD,$B2DE,$FD1C,$A88B,$CF50,$374D
            dc.w    $D816,$6830,$5284,$1F00,$3EB1,$99DA,$FC8C,$1E26
            dc.w    $AD7A,$AFBA,$F938,$CCA7,$2912,$D5C0,$1125,$3A79
            dc.w    $28F3,$93ED,$267B,$10F8,$F406,$012A,$EA0F,$60F5
            dc.w    $43A8,$3F20,$0232,$821D,$83EA,$9893,$352A,$890C
            dc.w    $E8DA,$5734,$7A29,$5DE6,$44EE,$6C0F,$7D63,$F1F1
            dc.w    $5A4C,$3E62,$CE92,$5036,$81F7,$CF09,$54DE,$17D4
            dc.w    $4DFD,$0D63,$03FB,$2022,$73C1,$9676,$8E41,$4782
            dc.w    $3D5A,$8C53,$E3CD,$09A1,$042E,$2EFD,$1957,$0EB0
            dc.w    $C3E4,$FBEE,$AB14,$8384,$B2BC,$1205,$4E5C,$778F
            dc.w    $5B97,$DFF2,$E477,$9DFB,$FB59,$A255,$0F76,$9E69
            dc.w    $4162,$4950,$F810,$E1D3,$8515,$19D7,$2F54,$B97E
            dc.w    $93E7,$855E,$599D,$AD4C,$2D58,$F07F,$D1CA,$26A0
            dc.w    $0D2B,$C9EF,$458E,$36A5,$6840,$9CB3,$6F7E,$E7A2
            dc.w    $F6CF,$B3A8,$0EDF,$F3A4,$2CC3,$72CE,$9F69,$DB49
            dc.w    $63A0,$E87D,$7B5D,$B888,$C547,$7171,$3605,$5F60
            dc.w    $A6E5,$1516,$3171,$FF98,$12F4,$4DC8,$CAD7,$751F
            dc.w    $DFAC,$B6CD,$7F31,$0AB7,$D56C,$38E3,$66D0,$41C5
            dc.w    $6A18,$0BF0,$0833,$FAEA,$47EF,$1A6F,$1600,$2174
            dc.w    $A8E1,$5C77,$F52F,$30CA,$D621,$E99F,$E13F,$51B9
            dc.w    $8BF6,$7DF7,$487D,$9510,$4298,$ECBD,$01DD,$A7FF
            dc.w    $BA3E,$083C,$DD3D,$32D8,$E5B6,$D61A,$1CDC,$D2E4
            dc.w    $50D2,$D975,$53FF,$AAF6,$AF68,$7BB4,$6595,$293A
            dc.w    $5160,$C7DD,$5DF2,$86AB,$D2A2,$97C9,$13D5,$BAE1
            dc.w    $156F,$7007,$0A1B,$28BB,$88B0,$4F9C,$DC27,$4AE9
            dc.w    $2349,$64E8,$40A9,$2D17,$6C9C,$B561,$5CE6,$8106
            dc.w    $0BFE,$4037,$BFB7,$8B4B,$67CB,$DE41,$B001,$2519
            dc.w    $C178,$04D1,$EB45,$1C97,$69B2,$FC28,$33E8,$556A
            dc.w    $CD09,$9265,$9579,$C49B,$E9C4,$8ECB,$BB4A,$9F8D
            dc.w    $B16E,$EA73,$D773,$F958,$6011,$D33F,$9E87,$A354
            dc.w    $182C,$B486,$9822,$5296,$A46A,$E5FA,$3C61,$8D5F
            dc.w    $BC81,$5340,$3AD4,$BF66,$EC70,$7EE0,$6234,$7C1B
            dc.w    $5664,$06C7,$C0AB,$5A51,$1A1A,$DC18,$AEC9,$45A9
            dc.w    $10D1,$915B,$6D23,$CB0E,$A5FC,$CEB5,$FFBE,$4899
            dc.w    $FEBB,$DD1C,$B60E,$61EC,$279E,$447B,$570B,$A0BF
            dc.w    $7707,$8778,$6BC0,$1638,$4C4B,$1802,$F0A4,$8087
            dc.w    $8C3B,$E60A,$D3E2,$5467,$5574,$1D0B,$714F,$C59E
            dc.w    $4A0C,$E2AF,$9B8D,$35DF,$49D3,$3143,$38BD,$7603
            dc.w    $6EED,$F794,$2448,$5823,$89D9,$884F,$20F0,$628C
            dc.w    $82F8,$ABAA,$DB28,$D056,$EF19,$1BE2,$EDC8,$2F4E
            dc.w    $F2EB,$2AD5,$9CD6,$0C39,$AA55,$595C,$BE86,$BE12
            dc.w    $A9BF,$F272,$E0A5,$FE5A,$5F82,$4B46,$C256,$C114
            dc.w    $F753,$786C,$3013,$D4FE,$79A7,$652B,$327F,$F64A
            dc.w    $C7C5,$E07A,$99C6,$4E68,$2265,$A92D,$2E7C,$6BC3
            dc.w    $61E9,$0247,$97E0,$8FCC,$80C7,$74D6,$B436,$A5F3
            dc.w    $8FC2,$39A3,$AC46,$F825,$06DB,$79C4,$7583,$05D0
            dc.w    $F1A6,$E37C,$B799,$BCB2,$D430,$5E6E,$90B8,$3B11
            dc.w    $C602,$66DB,$92AF,$CA91,$648A,$C06B,$CC51,$6948
            dc.w    $A143,$23F4,$5844,$7321,$3F0D,$5B64,$7204,$CD83
            dc.w    $D972,$1389,$C9B4,$2CCF,$A375,$EF80,$A2EC,$6D35
            dc.w    $17BA,$C32F,$87E3,$03E5,$1485,$34BE,$00B9,$AE27
            dc.w    $4F1D,$903D,$EE39,$F45D,$052D,$EDD2,$745F,$6F44
            dc.w    $86FA,$C801,$8DB3,$22AC,$B324,$0FC6,$2B96,$33AD
            dc.w    $C88B,$001E,$D93B,$928F,$15FC,$CA5F,$1FEE,$C53E
            dc.w    $780A,$03EB,$C2EA,$8AD0,$5465,$EE0D,$483F,$EDAA
            dc.w    $9DAF,$59F1,$B877,$B015,$595C,$8F9B,$7CB6,$71DB
            dc.w    $EB80,$0ECB,$0421,$C47A,$02B9,$7B8C,$BAB4,$D553
            dc.w    $ADC7,$45BA,$7DDA,$F8B1,$D5CF,$B16C,$5338,$AF82
            dc.w    $D047,$8D81,$8D9B,$344D,$4407,$4BC5,$4CC5,$1188
            dc.w    $000F,$6DA7,$BBE4,$4DD7,$9C4B,$D055,$B062,$B296
            dc.w    $5D41,$6BAC,$9334,$EBBF,$8A9F,$A94F,$D625,$5C6A
            dc.w    $7BF5,$88E4,$A64E,$533C,$B958,$FAF6,$56D5,$1E9D
            dc.w    $5275,$E669,$87E6,$A8A2,$5CC0,$1061,$BFF2,$2B60
            dc.w    $C811,$BAC4,$AC1A,$6832,$A1B3,$D459,$E9C2,$138E
            dc.w    $1B18,$EC64,$C6FD,$1422,$DA98,$9842,$FD30,$3658
            dc.w    $F7DD,$9FA0,$C393,$2695,$9F81,$ABAE,$6039,$62C0
            dc.w    $6416,$6949,$A037,$0B18,$4FF4,$38D2,$996D,$1F00
            dc.w    $3D64,$DB4C,$1E67,$5AD6,$CFD0,$1D47,$901E,$3F57
            dc.w    $C9A5,$41E9,$9208,$8213,$756F,$FF3A,$2151,$0AB8
            dc.w    $8357,$A4B9,$17F3,$DE8B,$3471,$2730,$DEBC,$E78A
            dc.w    $BE2D,$5E20,$CEF7,$C039,$97FB,$F79F,$0BF9,$6197
            dc.w    $8682,$4768,$AEF8,$350B,$2988,$E1EF,$43F0,$2D34
            dc.w    $4B3E,$8E78,$D74A,$676D,$7F76,$F0BE,$2FD3,$1CFD
            dc.w    $7073,$D97C,$011F,$000F,$6E9A,$B3C6,$B66B,$7A09
            dc.w    $4D1D,$17AF,$57BF,$312D,$72A2,$77FF,$4229,$568D
            dc.w    $5F50,$EA26,$1CB0,$E854,$EA95,$E9BB,$2DEF,$E340
            dc.w    $207B,$B41B,$25CA,$FC2E,$14C4,$B602,$F179,$06BD
            dc.w    $3B52,$A135,$0A89,$A094,$ECB7,$7523,$F6C8,$A648
            dc.w    $6F70,$8BB4,$3CFE,$1AE1,$0536,$1680,$58D2
            dc.b    '7g9jssPE'
            dc.w    $15CF,$802A,$40A4,$4540,$9CD8,$18E7,$707D,$6BBB
            dc.w    $D2E0,$D290,$095E,$B3B2,$2117,$66CD,$843F,$8904
            dc.w    $7FB0,$A98F,$3E71,$FAA1,$D1DE,$0D26,$B96E,$5159
            dc.w    $CC04,$F0C3,$CEFA,$3F0E,$6F14,$FC94,$04C1,$F203
            dc.w    $95E7,$11AB,$97ED,$76C1,$CD19,$2620,$199E,$302B
            dc.w    $0711,$36FF,$FBCE,$CB7D,$3212,$8878,$A2AB,$AB24
            dc.w    $579C,$388D,$12DF,$DDD8,$9601,$63C6,$AC90,$22E1
            dc.w    $BE05,$3EAA,$054A,$9E54,$83A1,$1AD1,$0CD5,$6A19
            dc.w    $48B5,$4A9E,$6C52,$B1A9,$C843,$9431,$20AD,$19DB
            dc.w    $E5FB,$AAA7,$661D,$F406,$24B2,$F5AE,$9056,$CA1C
            dc.w    $65CA,$035B,$7D46,$A722,$39E8,$072E,$3C29,$4E84
            dc.w    $2F75,$BCAC,$A303,$162C,$9A4B,$BDF6,$44F3,$6C35
            dc.w    $DC86,$2E92,$F536,$EF4F,$2537,$06E8,$6EF9,$8F68
            dc.w    $A5E5,$D35A,$426B,$5BF1,$5B50,$E33D,$BD31,$C71B
            dc.w    $AAB7,$77E5,$D76F,$98CB,$4A91,$27EC,$28F0,$9A17
            dc.w    $D3A6,$68A3,$870E,$3515,$FD77,$914D,$3AC3,$339D
            dc.w    $E425,$84FA,$BCEC,$F999,$5F10,$0EA8,$3D27,$FBB1
            dc.w    $897E,$DB28,$552A,$C561,$C3E3,$E710,$C993,$326E
            dc.w    $DF51,$1043,$D8D1,$239C,$0DA8,$2B55,$BB08,$2C0C
            dc.w    $DD5C,$2891,$3B5D,$553C,$0F45,$C144,$64CC,$40AD
            dc.w    $79A9,$4101,$937F,$3A97,$5D87,$0C63,$C144,$82EB
            dc.w    $B5C9,$7387,$85F2,$D469,$5466,$C0A6,$C6A5,$B77A
            dc.w    $5838,$7AD9,$2ADA,$B413,$4641,$6985,$7862,$E88B
            dc.w    $8CF7,$71BD,$7C33,$5E0D,$9EBC,$ED66,$8192,$318C
            dc.w    $02FE,$A8A4,$6306,$CD0B,$8070,$08B8,$4FF5,$4912
            dc.b    $EF,$EA,$0F
            dc.b    '2L!Z#R'
            dc.b    $99,$C4,$74,$FE,$F8,$6D,$D7,$1B,$2B,$E5,$CE,$08,$1F,$DC,$46,$B7
            dc.b    $2C,$E0,$86,$F1,$DC,$7E,$4C,$91,$5A,$13,$DC,$50,$72,$81,$33,$F3
            dc.b    $76,$A3,$D6,$F4,$D4,$95,$DE,$6A,$1A,$E1,$42,$9D,$E2,$A4,$27,$F2
            dc.b    $83,$79,$E2,$86,$3D,$8B,$D4,$E0,$07,$CC,$7F,$B8,$24,$F3,$CC,$51
            dc.b    $9A,$E6,$DF,$F9,$84,$B5,$96,$22,$74,$B2,$7E,$72,$1C,$37,$09,$49
            dc.b    $1E,$24,$B5,$C7,$B3,$96,$14,$AE,$98,$62,$56,$DA,$CD,$A5,$BA,$C2
            dc.b    $C2,$F8,$53,$BF,$D9,$FF,$60,$2C,$DD,$D8,$00,$F6,$65,$47,$ED,$CF
            dc.b    $28,$9B,$6C,$43,$63,$85,$02,$CB,$79,$E2,$48,$A7,$C7,$EE,$05,$7E
            dc.b    $E6,$65,$5D,$23,$F4,$1D,$BE,$D6,$3B,$FE,$83,$29,$B6,$8C,$7C,$99
            dc.b    $0C,$AF,$49,$9B,$FC,$DF,$72,$74,$2F,$12,$3A,$30,$A3,$D1,$2F,$76
            dc.b    $EE,$E4,$8E,$AD,$16,$46,$A0,$E2,$0A,$61,$8A,$94,$5B,$09,$E3,$60
            dc.b    $4E,$A2,$C9,$2E,$D3,$74,$5F,$4E,$7B,$67,$5E,$33,$85,$8E,$E9,$18
            dc.b    $C8,$2A,$E0,$01,$89,$E4,$3B,$C2,$FC,$12,$29,$ED,$8E,$4F,$74,$3A
            dc.b    $F7,$A1,$D9,$0A,$44,$D5,$1F
            dc.b    '6Rl+QQHEnc`'
            dc.b    $8E,$1E,$E6,$CB,$68,$53,$3F,$0D,$F3,$FF,$B6,$98,$06,$48,$0E,$D4
            dc.b    $FC,$0B,$8A,$67,$44,$FD,$20,$05,$A4,$14,$39,$AF,$81,$F7,$16,$61
            dc.b    $42,$D2,$3B,$86,$BE,$AB,$77,$24,$80,$4C,$36,$34,$79,$31,$F4,$F9
            dc.b    $4F,$39,$E9,$AD,$0F,$C8,$D4,$EC,$12,$FA,$BD,$D8,$0D,$62,$FF,$78
            dc.b    $70,$1F,$FD,$66,$76,$D6,$9A,$9E,$8D,$43,$A3,$13,$57,$97,$84,$2F
            dc.b    $95,$45,$59,$58,$AF,$12,$73,$14,$99,$DD,$05,$1A,$FA,$E5,$7C,$0F
            dc.b    $7F,$A4,$4D,$09,$CC,$A0,$9E,$30,$A0,$99,$55,$51,$FF,$F0,$DC,$BE
            dc.b    $94,$92,$7D,$18,$31,$11,$BB,$4E,$26,$0E,$DA,$97,$D7,$83,$92,$32
            dc.b    $52,$28,$99,$F4,$7C,$3B,$CD,$FF,$E7,$B8,$9F,$E8,$AB,$9B,$7E,$6F
            dc.b    $8A,$4B,$CF,$2B,$E5,$CD,$A0,$D1,$B1,$F9,$A9,$7A,$16,$C1,$3E,$B2
            dc.b    $69,$DC,$5B,$B0,$72,$D9,$0A,$C6,$A5,$F5,$E5,$DB,$B9,$A2,$F1,$7F
            dc.b    $25,$69,$8C,$82,$B2,$67,$02,$72,$EA,$8F,$D3,$B6,$DF,$3C,$33,$BF
            dc.b    $20,$2C,$2E,$E5,$51,$52,$96,$F5,$00,$81,$D7,$8F,$3C,$9E,$62,$C4
            dc.b    $87,$1C,$EB,$B1,$BB,$13,$72,$46,$C8,$7A,$23,$EB,$14,$B2,$04,$87
            dc.b    $6F,$9D,$74,$42,$08,$08,$AD,$8D,$4D,$FC,$F2,$93,$F1,$22,$C0,$55
            dc.b    $5B,$E9,$32,$5B,$B0,$6B,$4E,$41,$90,$AC,$C9,$A9,$22,$75,$4A,$10
            dc.b    $36,$1A,$B2,$CE,$ED,$63,$6E,$74,$18,$C4,$0C,$BB,$DE,$01,$FE,$11
            dc.b    $AA,$09,$F5,$52,$07,$04,$91,$73,$B6,$66,$6A,$62,$CB,$86,$90,$36
            dc.b    $19,$20,$D9,$16,$4C,$A1,$A1,$FD,$6C,$EA,$08,$1D,$3D,$82,$3C,$3E
            dc.b    $C9,$6A,$AB,$4A,$1B,$73,$80,$6A,$1A,$0F,$67,$A0,$5D,$E7,$FB,$83
            dc.b    $E8,$76,$E7,$75,$9B,$5C,$8F,$37,$28,$06,$2A,$7E,$D6,$46,$30,$20
            dc.b    $B4,$16,$CC,$40,$D3,$B6,$C4,$0B,$BC,$E8,$34,$C7,$B8,$24,$54,$35
            dc.b    $1C,$9C,$4F,$08,$A1,$F4,$09,$FC,$7B,$93,$D0,$31,$40,$88,$82,$B5
            dc.b    $9F,$BA,$AA,$F6,$75,$03,$49,$5C,$D8,$5B,$EF,$D2,$AD,$96,$0F,$39
            dc.b    $4B,$B9,$E0,$5D,$9E,$56,$93,$BD,$BA,$CF,$DB,$76,$5A,$F3,$21,$EA
            dc.b    $EE,$F6,$B4,$AC,$98,$A8,$31,$25,$62,$21,$8D,$5F,$C6,$40,$5D,$E7
            dc.b    $FD,$EB,$D8,$F2,$B7,$77,$C5,$57,$B5,$27,$13,$56,$66,$C0,$9C,$0C
            dc.b    $2F,$41,$B3,$3D,$E1,$15,$E8,$1C,$CD,$6C,$41,$68,$67,$8D,$1E,$54
            dc.b    $58,$F2,$71,$8A,$39,$E4,$40,$BA,$7A,$AF,$24,$DE,$1E,$71,$1F,$69
            dc.b    $EB,$44,$06,$2A,$96,$33,$6C,$99,$54,$38,$5E,$AA,$E2,$26,$BA,$92
            dc.b    $38,$2E,$60,$91,$E9,$57,$B0,$8E,$88,$8C,$F9,$17,$83,$72,$18,$1E
            dc.b    $85,$3F,$12,$44,$D5,$BF,$C3,$FA,$A8,$59,$61,$E3,$5E,$78,$D5,$C9
            dc.b    $2E,$34,$10,$9A,$6A,$5D,$A2,$C8,$8B,$4F,$86,$6E,$BD,$AD,$1A,$00
            dc.b    $05,$49,$75,$94,$F0,$A5,$BC,$23,$DB,$6F,$07,$27,$49,$84,$98,$70
            dc.b    $13,$A6,$4C,$ED,$5F,$E3,$AE,$28,$2C,$CC,$83,$77,$F4,$7B,$88,$E6
            dc.b    $CF,$29,$DE,$DD,$E6,$D1,$46,$C3,$3E,$AA,$2C,$F0,$35,$0D,$C7,$D6
            dc.b    $33,$2A,$D2,$E0,$53,$23,$43,$64,$02,$2B,$F3,$03,$27,$DB,$94,$63
            dc.b    $6D,$05,$EC,$2D,$84,$61,$ED,$06,$6E,$FE,$B5,$3F,$17,$60,$D1,$AE
            dc.b    $C7,$B5,$01,$F8,$59,$17,$97,$3B,$A7,$5E,$03,$C0,$6B,$1D,$26,$65
            dc.b    $9C,$42,$5F,$38,$A9,$19,$2B,$4B,$F7,$BB,$22,$88,$2D,$64,$27,$F7
            dc.b    $24,$D7,$BE,$DC,$0B,$65,$AC,$A8,$37,$90,$E2,$CF,$5C,$47,$3A,$D9
            dc.b    $09,$91,$17,$15,$D0,$5A,$C8,$B3,$65,$D5,$D6,$C2,$01,$CE,$B7,$45
            dc.b    $C3,$DF,$58,$95,$C4,$8B,$E1,$2C,$86,$2D,$0B,$A2,$56,$55,$9D,$96
            dc.b    $4A,$D3,$76,$9D,$9D,$E6,$89,$49,$8C,$32,$A8,$AB,$73,$B3,$68,$02
            dc.b    $FE,$E0,$A5,$7B,$C1,$10,$E3,$43,$82,$A7,$48,$59,$0E,$4D,$AF,$A7
            dc.b    $0A,$30,$EE,$47,$AE,$94,$C1,$33,$55,$7D,$53,$FE,$1D,$35,$FA,$1F
            dc.b    $9A,$50,$BF,$7D,$F8,$E1,$28,$6B,$30,$CB,$5A,$9B,$03,$18,$CB,$F3
            dc.b    $A2,$6D,$81,$53,$21,$74,$50,$07,$3A,$9F,$19,$85,$60,$4A,$38,$F1
            dc.b    $F6,$7C,$A6,$9F,$4E,$AE,$56,$7C,$EF,$EC,$79,$01,$15,$EE,$70,$FB
            dc.b    $CA,$25,$B9,$D7,$32,$E2,$25,$4D,$47,$C6,$CA,$0E,$E4,$07,$47,$2E
            dc.b    $50,$2F,$EA,$B4,$77,$7F,$F6,$0A,$FB,$D0,$64,$5E,$97,$3E,$1C,$04
            dc.b    $71,$7E,$15,$CD,$DA,$D8,$A7,$A4,$DD,$54,$69,$DF,$61,$C3,$14,$84
            dc.b    $C5,$C7,$66,$22,$AC,$68,$3D,$80,$23,$9A,$6B,$71,$D1,$02,$F8,$DA
            dc.b    $7E,$95,$87,$4C,$89,$C9,$DF,$B7,$0C,$00,$85,$CA,$B3,$D4,$11,$19
            dc.b    $A6,$3D,$57,$9C,$EC,$80,$7B,$3C,$DC,$DA,$DD,$8C,$E0,$8A,$35,$D0
            dc.b    $93,$A9,$8B,$5A,$78,$4E,$45,$E1,$3F,$87,$B8,$C5,$48,$F8,$29,$81
            dc.b    $7D,$BD,$6F,$BC,$BF,$70,$7F,$79,$04,$79,$E4,$3A,$11,$B4,$37,$89
            dc.b    $CE,$37,$6D,$CC,$10,$89,$4B,$21,$F5,$A3,$65,$C1,$92,$BC,$78,$A3
            dc.b    $A3,$0C,$9B,$B9,$C0,$B1,$2D,$E9,$2A,$F1,$00,$A5,$34,$58,$1D,$A6
            dc.b    $F9,$FB,$CE,$8B,$41,$CA,$1B,$50,$D4,$1B,$C2,$EF,$E3,$8E,$5C,$29
            dc.b    $C2,$5F,$0D,$B8,$64,$EF,$C6,$90,$63,$B7,$7A,$6D,$43,$98,$B1,$EE
            dc.b    $91,$DE,$95,$1B,$46,$B0,$A4,$D3,$D2,$C5,$2F,$26,$F2,$BE,$F0,$E2
            dc.b    $8F,$85,$42
sub_40855DA2:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408526F0
            moveq   #0,D0
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_40855DC4:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            subq.l  #4,SP
            moveq   #$48,D0
            move.l  D0,-(SP)
            jsr     sub_4085644E
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
            jsr     sub_40855DA2
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
sub_40855DF4:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($14,A6),D6
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            bra.b   .L2
.L1:
            addq.w  #1,D7
.L2:
            cmpi.w  #2,D7
            bge.b   .L3
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            cmpi.l  #'PWD ',(A0)
            beq.b   .L1
.L3:
            cmpi.w  #2,D7
            blt.b   .L5
            tst.l   ($10,A6)
            beq.b   .L4
            move.l  D6,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D6,D1
            add.l   ($10,A6),D1
            moveq   #$10,D2
            sub.l   D2,D1
            move.l  D1,-(SP)
            move.l  A4,-(SP)
            jsr     sub_40855DF4
            lea     ($10,SP),SP
            bra.b   .L10
.L4:
            moveq   #-5,D0
            bra.b   .L10
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            moveq   #8,D0
            move.l  D0,-(SP)
            jsr     sub_40856478
            moveq   #0,D0
            bra.b   .L10
.L5:
            clr.w   D7
            bra.b   .L7
.L6:
            addq.w  #1,D7
.L7:
            cmpi.w  #2,D7
            bge.b   .L8
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A4,D0
            movea.l D0,A1
            move.l  (A0),D0
            cmp.l   (A1),D0
            beq.b   .L6
.L8:
            cmpi.w  #2,D7
            blt.b   .L9
            moveq   #0,D0
            bra.b   .L10
.L9:
            moveq   #-5,D0
.L10:
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
sub_40855EA0:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            clr.b   D7
            movea.l A4,A3
.L1:
            tst.b   (A4)+
            beq.b   .L2
            move.b  D7,D0
            addq.b  #1,D7
            cmpi.b  #$1F,D0
            blt.b   .L1
.L2:
            cmpi.b  #$1F,D7
            blt.b   .L3
            moveq   #$1F,D7
.L3:
            move.l  A3,-(SP)
            move.l  ($C,A6),D0
            addq.l  #1,D0
            move.l  D0,-(SP)
            ext.w   D7
            ext.l   D7
            move.l  D7,-(SP)
            jsr     sub_40856478
            movea.l ($C,A6),A0
            move.b  D7,(A0)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
sub_40855EEA:
            link.w  A6,#-$36
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            movea.l ($26A,A3),A0
            move.b  (A0),D0
            ext.w   D0
            move.w  D0,(-$30,A6)
            pea     (-$2A,A6)
            movea.l ($26A,A3),A0
            pea     ($16,A0)
            jsr     sub_40855EA0
            movea.l ($26A,A3),A0
            tst.b   (5,A0)
            addq.l  #8,SP
            bne.b   .L1
            movea.l ($26A,A3),A0
            move.b  #2,(5,A0)
.L1:
            pea     ($1C,A3)
            pea     ($18,A3)
            pea     (4,A3)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (4,A0),D0
            move.l  D0,-(SP)
            pea     (-$32,A6)
            movea.l ($26A,A3),A0
            move.w  ($3E,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (5,A0),D0
            muls.w  #$3C,D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852F3E
            move.w  D0,D7
            lea     ($1C,SP),SP
            bne.w   .L6
            moveq   #0,D0
            move.l  D0,(-$36,A6)
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     sub_40856464
            move.l  (SP)+,D0
            moveq   #$40,D1
            sub.l   D1,D0
            move.l  D0,-(SP)
            pea     (8,A3)
            move.l  (4,A3),-(SP)
            pea     (-$36,A6)
            jsr     sub_40853D9A
            move.l  D0,-(SP)
            jsr     sub_40853CC6
            move.w  D0,D7
            lea     ($14,SP),SP
            beq.b   .L2
            move.w  D7,D0
            bra.b   .L7
.L2:
            move.l  (-$36,A6),-(SP)
            jsr     sub_4085645A
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     sub_40856464
            move.l  (4,A3),-(SP)
            movea.l ($26A,A3),A0
            pea     (6,A0)
            pea     (8,A3)
            jsr     sub_40855DF4
            move.w  D0,D7
            lea     ($10,SP),SP
            beq.b   .L3
            move.l  (4,A3),-(SP)
            jsr     sub_4085645A
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.w  D7,D0
            bra.b   .L7
.L3:
            tst.l   (4,A3)
            beq.b   .L4
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #1,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L5
.L4:
            moveq   #-6,D7
.L5:
            tst.w   D7
            beq.b   .L6
            move.w  D7,D0
            bra.b   .L7
.L6:
            move.w  D7,D0
.L7:
            movem.l (-$3E,A6),D7/A3
            unlk    A6
            rts
DoATControl:
            link.w  A6,#-8
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            move.w  (2,A3),D7
            tst.l   ($26A,A3)
            bne.b   .L1
            pea     ($26A,A3)
            jsr     sub_40855DC4
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L1
            move.w  D7,D0
            bra.w   .L14
.L1:
            move.w  ($1A,A4),D0
            subq.w  #1,D0
            bmi.w   .L11
            cmpi.w  #4,D0
            bgt.w   .L11
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
            dc.w    .L5-(.L2+2)
            dc.w    .L7-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L10-(.L2+2)
.L4:
            move.l  A3,-(SP)
            jsr     sub_40855EEA
            move.w  D0,D7
            addq.l  #4,SP
            bne.b   .L12
            pea     ($BA,A3)
            move.l  ($20,A4),-(SP)
            move.l  ($24,A4),-(SP)
            jsr     sub_40856478
            bra.b   .L12
.L5:
            tst.l   (4,A3)
            beq.b   .L6
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L12
.L6:
            moveq   #-6,D7
            bra.b   .L12
.L7:
            tst.l   (4,A3)
            beq.b   .L8
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #3,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bne.b   .L12
            move.l  (-8,A6),($1C,A4)
            move.l  (-4,A6),($20,A4)
            bra.b   .L12
.L8:
            moveq   #-6,D7
            bra.b   .L12
.L9:
            moveq   #-$32,D7
            bra.b   .L12
.L10:
            move.l  A3,($1C,A4)
            bra.b   .L12
.L11:
            moveq   #-$32,D7
.L12:
            movea.l ($26A,A3),A0
            moveq   #$40,D0
            and.b   (3,A0),D0
            bne.b   .L13
            movea.l ($26A,A3),A0
            tst.w   ($3E,A0)
            beq.b   .L13
            tst.w   D7
            beq.b   .L13
            move.w  ($26E,A3),D0
            addq.w  #1,($26E,A3)
            cmpi.w  #5,D0
            blt.b   .L13
            movea.l ($26A,A3),A0
            addq.l  #6,A0
            move.l  A0,(-8,A6)
            addq.l  #4,(-8,A6)
            move.l  #'PWD ',(A0)
            movea.l (-8,A6),A0
            move.l  #'PWD ',(A0)
            movea.l ($26A,A3),A0
            clr.w   ($3E,A0)
            movea.l ($26A,A3),A0
            clr.b   ($16,A0)
            clr.w   ($26E,A3)
            move.w  D7,($270,A3)
.L13:
            move.w  D7,D0
.L14:
            movem.l (-$14,A6),D7/A3-A4
            unlk    A6
            rts
sub_40856164:
            bsr.w   InstallDRVRs_DRVR_50
            bne.w   .L4
            bsr.w   ReadPRAM_DRVR_50
            moveq   #1,D2
            moveq   #$10,D0
            addi.w  #$30A,D0
            _NewPtrSysClear
            bne.w   .L4
            move.w  D2,(A0)
            movea.l ExpandMem,A1
            lea     ($74,A1),A1
            move.l  A0,(A1)
            move.l  D1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($74,A0),A0
            lea     LAPMgrPtr,A1
            movea.l UTableBase,A2
            moveq   #$24,D1
            movea.l (0,A2,D1.w),A2
            movea.l (A2),A2
            movea.l (A2),A2
            move.w  (8,A2),D1
            move.w  (-2,A2,D1.w),D1
            lea     (0,A2,D1.w),A3
            move.l  A3,D0
            _StripAddress
            move.l  D0,(A1)
            moveq   #$10,D0
            jsr     (2,A3)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            move.l  (SP)+,D1
            tst.b   D1
            bne.b   .L1
            bsr.w   InstallPrintAtlk_DRVR_50
            bra.b   .L2
.L1:
            bsr.w   sub_408561EC
            bne.b   .L4
.L2:
            lea     ($30A,A3),A3
            tst.l   (8,A3)
            bne.b   .L3
            bset    #5,(6,A3)
.L3:
            moveq   #0,D0
.L4:
            rts
sub_408561EC:
            movem.l D4,-(SP)
            moveq   #-1,D4
            bsr.w   InstallADEV
            move.l  D1,($312,A3)
            tst.w   D0
            beq.b   .L1
            bsr.w   sub_40856208
.L1:
            movem.l (SP)+,D4
            rts
sub_40856208:
            exg     D0,D1
            st      PortBUse
            moveq   #-$B,D0
            _DrvrRemove
            moveq   #-$A,D0
            _DrvrRemove
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            move.l  ($1EE,A1),D0
            beq.b   .L1
            movea.l D0,A0
            move.w  #$A9A0,D0
            _SetTrapAddress
.L1:
            movea.l A1,A0
            _DisposPtr
            move.l  MinusOne,LAPMgrPtr
            move.l  D1,D0
            rts
InstallPrintAtlk_DRVR_50:
            move.w  #1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L1
            move.l  #$53432020,D1
            move.w  #$101,D1
            move.w  #$FFFF,D4
            bsr.b   sub_40856270
.L1:
            rts
GetRomAtlk_DRVR_50:
            move.l  D2,-(SP)
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  (SP)+,D2
            rts
sub_40856270:
            movem.l D2-D4/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A0),A0
            tst.w   D4
            bpl.b   .L1
            moveq   #0,D4
.L1:
            moveq   #1,D0
            jsr     (2,A0)
            movem.l (SP)+,D2-D4/A0/A2-A3
            tst.w   D0
            rts
InstallADEV:
            moveq   #0,D2
            clr.w   D0
            move.b  D1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L4
            move.l  D1,D3
            bsr.b   sub_40856270
            beq.b   .L2
.L1:
            move.w  D0,D2
            bra.b   .L4
.L2:
            bsr.b   CheckPramVal_DRVR_50
            bne.b   .L1
            cmp.l   D1,D3
            beq.b   .L3
            bsr.w   sub_4085634C
.L3:
            moveq   #0,D0
            nop
.L4:
            tst.w   D0
            rts
CheckPramVal_DRVR_50:
            moveq   #0,D0
            move.b  D3,D1
            tst.w   D4
            bmi.b   .L1
            cmp.l   D1,D3
            beq.b   .L1
            movea.l (A0),A0
            bsr.w   sub_408562CE
            moveq   #-1,D0
.L1:
            tst.w   D0
            rts
sub_408562CE:
            movem.l D0-D3/A0-A3,-(SP)
            moveq   #2,D0
            jsr     (2,A0)
            movem.l (SP)+,D0-D3/A0-A3
            rts
InstallDRVRs_DRVR_50:
            moveq   #-$B,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #-$A,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
sub_408562F2:
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            move.w  D3,-(SP)
            not.w   (SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,-(SP)
            move.l  A0,D0
            beq.b   InstallDRVRs_DRVR_50.L1
            move.w  D3,D0
            _DrvrInstall async
            movea.l UTableBase,A0
            not.w   D3
            lsl.w   #2,D3
            movea.l (0,A0,D3.w),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A1),(A0)
            movea.l (A0),A1
            move.b  (A1),(4,A0)
            bclr    #6,(5,A0)
            moveq   #0,D0
            rts
ReadPRAM_DRVR_50:
            clr.l   -(SP)
            btst    #$E,HWCfgFlags
            beq.b   .L1
            movea.l SP,A0
            move.l  #$400E0,D0
            _ReadXPRam
.L1:
            move.l  (SP)+,D1
            rts
sub_4085634C:
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            movea.l SP,A0
            move.l  #$400E0,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l (SP)+,A0
            rts
            move.l  (4,SP),D0
            move.l  (8,SP),D1
sub_40856368:
            move.l  D2,-(SP)
            move.l  D0,D2
            mulu.w  D1,D2
            movea.l D2,A0
            move.l  D1,D2
            swap    D2
            mulu.w  D0,D2
            swap    D0
            mulu.w  D0,D1
            add.w   D1,D2
            swap    D2
            clr.w   D2
            adda.l  D2,A0
            move.l  A0,D0
            move.l  (SP)+,D2
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_40856390:
            jsr     sub_408563A0
            move.l  D1,D0
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563A0:
            movem.l D5-D6,-(SP)
            move.l  D0,D5
            bpl.b   .L1
            neg.l   D0
.L1:
            move.l  D1,D6
            bpl.b   .L2
            neg.l   D1
.L2:
            jsr     sub_408563CE
            tst.l   D5
            bpl.b   .L3
            neg.l   D0
.L3:
            eor.l   D5,D6
            bpl.b   .L4
            neg.l   D1
.L4:
            movem.l (SP)+,D5-D6
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563CE:
            movem.l D2-D4,-(SP)
            move.l  D1,D2
            swap    D2
            tst.w   D2
            bne.b   .L2
            move.w  D0,D3
            clr.w   D0
            swap    D0
            beq.b   .L1
            divu.w  D1,D0
            move.w  D0,D2
.L1:
            swap    D2
            move.w  D3,D0
            divu.w  D1,D0
            move.w  D0,D2
            move.l  D2,D1
            clr.w   D0
            swap    D0
            bra.b   .L5
.L2:
            move.l  D0,D2
            clr.w   D0
            swap    D0
            swap    D2
            clr.w   D2
            move.l  D1,D3
            moveq   #0,D1
            moveq   #$F,D4
.L3:
            add.l   D2,D2
            addx.l  D0,D0
            add.l   D1,D1
            cmp.l   D3,D0
            blt.b   .L4
            sub.l   D3,D0
            addq.b  #1,D1
.L4:
            dbra    D4,.L3
.L5:
            movem.l (SP)+,D2-D4
            rts
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
.L6:
            moveq   #0,D0
.L7:
            move.l  A1,-(SP)
.L8:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L8
sub_40856436:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtr
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_40856442:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSys
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_4085644E:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_4085645A:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     sub_408563CE.L7
sub_40856464:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _GetPtrSize
            move.l  D0,(SP)
            bpl.b   .L1
            clr.l   (SP)
            jmp     sub_408563CE.L7
.L1:
            jmp     sub_408563CE.L6
sub_40856478:
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _BlockMove
            movea.l D1,A1
            jmp     sub_408563CE.L7
            move.w  ROM85,D0
            bpl.b   .L1
            btst    #5,PortBUse
            beq.b   .L1
            move.w  #$FFD7,D1
            moveq   #0,D0
            bra.b   .L2
.L1:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_408565A8.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            move.w  ($18,A0),D1
            adda.w  #$32,SP
.L2:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.w  D1,(A1)
            move.w  D0,(SP)
            jmp     (A0)
            move.w  #$F5,D0
            bra.w   sub_408564FC.L1
            move.w  #$F4,D0
            bra.w   sub_408564FC.L1
            move.w  #$F3,D0
            bra.w   sub_408564FC.L1
            move.w  #$F8,D0
            bra.w   sub_408564FC.L1
            move.w  #$F7,D0
            bra.w   sub_408564FC.L1
sub_408564EC:
            move.w  #$F6,D0
            bra.w   sub_408564FC.L1
            move.w  #$FD,D0
            bra.w   sub_408564FC.L1
sub_408564FC:
            move.w  #$FB,D0
            bra.w   .L1
            move.w  #$FA,D0
            bra.w   .L1
            move.w  #$FC,D0
            bra.w   .L1
            move.w  #$100,D0
            bra.w   .L1
            move.w  #$FE,D0
            bra.b   .L1
            move.w  #$FE,D0
            bra.w   sub_408565A8
            move.w  #$FA,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8
            move.w  #$FD,D0
            bra.b   sub_408565A8
            move.w  #$FC,D0
            bra.b   sub_408565A8
            move.w  #$FB,D0
            bra.b   sub_408565A8
            move.w  #$100,D0
            bra.b   sub_408565A8
            move.w  #$F9,D0
            bra.b   sub_408565A8
            move.w  #$F8,D0
            bra.b   sub_408565A8
            move.w  #$102,D0
            bra.b   sub_408565A8
            move.w  #$101,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8.L1
            move.w  #$FE,D0
            bra.b   sub_408565A8.L1
            move.w  #$F8,D0
            bra.b   sub_408565A8.L1
            move.w  #$F9,D0
            bra.b   sub_408565A8.L1
            move.w  #$F7,D0
            bra.b   sub_408565A8.L1
            move.w  #$FC,D0
            bra.b   sub_408565A8.L1
            move.w  #$FD,D0
            bra.b   sub_408565A8.L1
            move.w  #$FB,D0
            bra.b   sub_408565A8.L1
            move.w  #$FA,D0
            bra.b   sub_408565A8.L1
.L1:
            movea.l (6,SP),A0
            move.w  #$FFF6,($18,A0)
            bra.b   sub_408565A8.L1
sub_408565A8:
            movea.l (6,SP),A0
            move.w  #$FFF5,($18,A0)
.L1:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            movea.l (SP)+,A0
            move.w  D0,($1A,A0)
            tst.b   D1
            bne.b   .L2
            _Control
            bra.b   .L3
.L2:
            _Control async
.L3:
            move.w  D0,(SP)
            jmp     (A1)
.L4:
            dc.b    4,'.XPP'
            dc.b    $00
sub_408565D0:
            movem.l D1-D2/A0-A2,-(SP)
            movem.l ($18,SP),D1-D2/A0-A2
            pea     (1,A1)
            move.l  (SP)+,(2,A2)
            move.l  A0,(8,A2)
            clr.w   ($C,A2)
            swap    D2
            move.w  D2,(8,A1)
            swap    D2
            move.b  D2,($E,A1)
            asr.w   #8,D2
            move.b  D2,($C,A1)
            move.b  D1,($10,A1)
            swap    D1
            move.w  D1,(6,A2)
            movem.l (SP)+,D1-D2/A0-A2
            move.l  (SP),($14,SP)
            adda.w  #$14,SP
            rts
sub_40856614:
            movem.l D0/A0-A1,-(SP)
            moveq   #$1C,D0
            bsr.b   sub_40856636
            move.w  #$18,D0
            bsr.b   sub_40856636
            move.w  #$14,D0
            bsr.b   sub_40856636
            movem.l (SP)+,D0/A0-A1
            move.l  (SP),($10,SP)
            adda.w  #$10,SP
            rts
sub_40856636:
            movea.l (0,SP,D0.w),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            movea.l ($20,SP),A1
            add.l   D0,($20,SP)
            _BlockMove
            rts
.L1:
            ds.b    28
.L2:
            ds.b    72
.L3:
            ds.b    26
.L4:
            dc.b    4,'.MPP'
            dc.b    $20,$04,$2E,$41,$54,$50,$20
            ds.b    102
RemoveHdlBlks:
            movem.l A1-A2,-(SP)
            lea     sub_40856636.L1,A1
.L1:
            move    SR,-(SP)
            move    #$2600,SR
            movea.l (A1),A0
            movea.l (A0),A2
            move.l  A0,D0
            beq.b   .L2
            move.l  (A2),(A1)
.L2:
            move    (SP)+,SR
            tst.l   D0
            beq.b   .L3
            _DisposHandle
            bra.b   .L1
.L3:
            movem.l (SP)+,A1-A2
            rts
.L4:
            move.l  (SP)+,D3
            move.w  D0,(SP)
            movea.l D2,A1
            jmp     (A1)
UnlockAndLinkHdl:
            move.l  A1,-(SP)
            _HUnlock
            movea.l (A0),A1
            move    SR,-(SP)
            move    #$2600,SR
            move.l  sub_40856636.L1,(A1)
            lea     sub_40856636.L1,A1
            move.l  A0,(A1)
            move    (SP)+,SR
            movea.l (SP)+,A1
            rts
IsMPPOpen:
            moveq   #0,D1
            move.b  PortBUse,D0
            bmi.b   .L1
            andi.b  #$F,D0
            subq.b  #1,D0
            bne.b   .L1
            moveq   #1,D1
.L1:
            move.b  D1,(4,SP)
            rts
MPPOpen_piMAIN:
            clr.w   -(SP)
            jsr     IsMPPOpen
            clr.w   D0
            tst.b   (SP)+
            bne.b   .L3
            move.b  PortBUse,D1
            bmi.b   .L1
            moveq   #-$61,D0
            bra.b   .L3
.L1:
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            ble.b   .L2
            moveq   #-$62,D0
            bra.b   .L3
.L2:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_40856636.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            adda.w  #$32,SP
.L3:
            move.w  D0,(4,SP)
            rts
sub_408567E4:
            moveq   #4,D3
            cmp.w   D3,D1
            bcc.b   .L1
            move.w  D1,D3
.L1:
            lea     sub_40856636.L3,A5
            move.l  A3,(2,A5)
            move.w  D3,D2
            swap    D2
            move.b  D0,D2
            tst.w   D3
            beq.b   .L2
            jsr     (A4)
            bne.b   .L4
.L2:
            lea     sub_40856636.L2,A3
            moveq   #$B,D3
.L3:
            cmp.b   (0,A3,D3.w),D2
            dbeq    D3,.L3
            bne.b   .L5
            lsl.w   #2,D3
            move.w  D3,(A5)
            movea.l ($18,A3,D3.w),A3
            move.l  A3,D0
            beq.b   .L5
            movea.l (4,A3),A3
            movea.l (A3),A3
            move.w  ($10,A3),D3
            movea.l ($14,A3),A3
            swap    D2
            adda.w  D2,A3
            sub.w   D2,D3
            jsr     (2,A4)
            bne.b   .L4
            bra.b   .L6
.L4:
            rts
.L5:
            moveq   #0,D3
            jmp     (2,A4)
.L6:
            tst.w   D3
            bge.b   .L7
            move.w  #$F3E3,D0
.L7:
            move.l  A2,-(SP)
            lea     sub_40856636.L3,A1
            lea     sub_40856636.L2,A2
            move.w  (A1),D1
            movea.l ($18,A2,D1.w),A2
            movea.l (4,A2),A0
            movea.l (A0),A0
            move.w  ($10,A0),D1
            sub.w   D3,D1
            move.w  D1,($12,A0)
            movea.l (2,A1),A3
            movea.l ($14,A0),A2
            cmp.w   ($10,A0),D2
            ble.b   .L8
            move.w  ($10,A0),D2
.L8:
            subq.w  #1,D2
            blt.b   .L9
            move.b  (0,A3,D2.w),(0,A2,D2.w)
            bra.b   .L8
.L9:
            movea.l (SP)+,A2
            move.w  D0,(2,A0)
            clr.b   (8,A0)
            move.b  (-1,A3),(9,A0)
            move.b  (-2,A3),($F,A0)
            clr.b   ($18,A0)
            move.b  (1,A2),($19,A0)
            move.w  (A1),D2
            move.w  D2,D1
            lsr.w   #2,D1
            lea     sub_40856636.L2,A1
            cmpi.b  #1,(3,A2)
            bne.b   .L10
            move.b  (2,A2),($E,A0)
            clr.w   ($C,A0)
            movea.l ($18,A1,D2.w),A3
            bra.b   .L11
.L10:
            move.b  (-4,A3),($E,A0)
            move.w  (-7,A3),($C,A0)
            tst.w   (-$B,A3)
            movea.l ($18,A1,D2.w),A3
            beq.b   .L11
            tst.w   D0
            bne.b   .L11
            bsr.w   CalcCheckSum
            beq.b   .L11
            tst.b   (9,A3)
            beq.b   .L14
            move.w  #$F3E1,(2,A0)
.L11:
            movea.l (4,A3),A0
            _HUnlock
            tst.b   (8,A3)
            beq.b   .L12
            move.l  A0,D0
            movea.w #$A,A0
            _PostEvent
            bra.b   .L13
.L12:
            st      ($C,A1,D1.w)
.L13:
            move.l  (A3),($18,A1,D2.w)
            movea.l ($A,A3),A0
            jsr     UnlockAndLinkHdl
.L14:
            rts
CalcCheckSum:
            movem.l D1/A1,-(SP)
            clr.w   D3
            lea     (8,A2),A1
            moveq   #9,D1
            bsr.b   sub_40856946
            movea.l ($14,A0),A1
            move.w  ($12,A0),D1
            bsr.b   sub_40856946
            tst.w   D3
            bne.b   .L1
            subq.w  #1,D3
.L1:
            sub.w   (6,A2),D3
            movem.l (SP)+,D1/A1
            rts
sub_40856946:
            clr.w   D0
            subq.w  #1,D1
.L1:
            move.b  (A1)+,D0
            add.w   D0,D3
            rol.w   #1,D3
            dbra    D1,.L1
            rts
sub_40856956:
            lea     sub_40856636.L2,A1
            moveq   #$B,D1
.L1:
            cmp.b   (0,A1,D1.w),D3
            dbeq    D1,.L1
            rts
DDPOpenSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            move.l  A1,D1
            bne.b   .L1
            lea     sub_408567E4,A1
            move.l  A1,D1
.L1:
            movea.l (SP)+,A1
            move.l  D3,-(SP)
            move.b  (1,A1),D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.l  D1,($1E,A0)
            move.w  #$F8,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            tst.w   D0
            bne.b   .L4
            move.b  ($1C,A0),D3
            move.b  D3,(1,A1)
            lea     sub_408567E4,A0
            cmpa.l  D1,A0
            bne.b   .L4
            lea     sub_40856636.L2,A1
            move.w  #$B,D1
.L2:
            tst.b   (0,A1,D1.w)
            dbeq    D1,.L2
            bne.b   .L3
            move.b  D3,(0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            clr.l   ($18,A1,D1.w)
            bra.b   .L4
.L3:
            move.w  #$FFA5,D0
.L4:
            adda.w  #$32,SP
            jmp     RemoveHdlBlks.L4
DDPCloseSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            move.w  (SP)+,D0
            move.l  D3,-(SP)
            move.b  D0,D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.w  #$F7,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            adda.w  #$32,SP
            tst.b   D0
            bne.b   .L2
            jsr     sub_40856956
            bne.b   .L2
            clr.b   (0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            movea.l ($18,A1,D1.w),A0
            clr.l   ($18,A1,D1.w)
            movea.l A0,A1
.L1:
            move.l  A1,D0
            beq.b   .L2
            movea.l (4,A1),A0
            _HUnlock
            movea.l A1,A0
            _RecoverHandle
            movea.l (A1),A1
            jsr     UnlockAndLinkHdl
            bra.b   .L1
.L2:
            jmp     RemoveHdlBlks.L4
NBPExtract:
            jsr     RemoveHdlBlks
            lea     ($C,SP),A0
            move.w  #$F3E0,D2
            move.w  (A0)+,D1
            beq.b   .L5
            cmp.w   (A0)+,D1
            bhi.b   .L5
            movea.l (A0),A1
.L1:
            subq.w  #1,D1
            beq.b   .L2
            addq.w  #5,A1
            clr.w   D2
            move.b  (A1),D2
            add.b   (1,A1,D2.w),D2
            add.b   (2,A1,D2.w),D2
            addq.b  #3,D2
            adda.w  D2,A1
            bra.b   .L1
.L2:
            movea.l (4,SP),A0
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            addq.w  #1,A1
            moveq   #3,D2
            move.l  (8,SP),D0
.L3:
            movea.l D0,A0
            move.b  (A1),D1
.L4:
            move.b  (A1)+,(A0)+
            subq.b  #1,D1
            bcc.b   .L4
            addi.l  #$22,D0
            subq.w  #1,D2
            bne.b   .L3
.L5:
            movea.l (SP)+,A1
            adda.w  #$10,SP
            move.w  D2,(SP)
            jmp     (A1)
sub_40856A9E:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($10,A6),D6
            move.l  ($C,A6),D7
            movea.l (8,A6),A4
            movea.l A4,A3
            bra.b   .L2
.L1:
            move.b  D7,(A4)+
.L2:
            move.l  D6,D0
            subq.l  #1,D6
            tst.l   D0
            bhi.b   .L1
            move.l  A3,D0
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
            dc.b    $86,$6D,$65,$6D,$73,$65,$74
            ds.b    13

            EVEN
