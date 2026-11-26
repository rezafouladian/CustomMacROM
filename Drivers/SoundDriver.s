            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_3

            IMPORT  BaseOfROM,RsrcEntryDRVR_9

            SECTION "SoundDriver",CODE

RsrcEntryDRVR_3:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 3 ".Sound" (2468 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_9-BaseOfROM       ; Next entry
            dc.l    SoundDrvr-BaseOfROM             ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    6,'.Sound'                      ; Name
            dc.b    'BMGGDC'
            dc.l    $C0A00000,$000009B0,$00000214   ; Block header
SoundDrvr:
            dc.w    $4E00                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    SoundOpenCommon-SoundDrvr       ; drvrOpen
            dc.w    SoundPrimeCommon-SoundDrvr      ; drvrPrime
            dc.w    SoundCtlCommon-SoundDrvr        ; drvrCtl
            dc.w    SoundStatus-SoundDrvr           ; drvrStatus
            dc.w    SoundCloseCommon-SoundDrvr      ; drvrClose
            dc.b    6,'.Sound'
            dc.b    $20
SoundOpenCommon:
            bsr.b   sub_408E5A30
            beq.b   sub_408E5A30.L1
            bra.w   sub_408E5E78.L3
SoundPrimeCommon:
            bsr.b   sub_408E5A30
            beq.w   SoundStatus.L2
            bra.w   sub_408E5F2A.L4
SoundCtlCommon:
            bsr.b   sub_408E5A30
            beq.w   sub_408E5B3C.L1
            bra.w   sub_408E5F2A.L2
SoundCloseCommon:
            bsr.b   sub_408E5A30
            beq.w   sub_408E5A52.L4
            bra.w   sub_408E5E78.L6
sub_408E5A30:
            move.l  A2,D2
            movea.l ASCBase,A2
            move.b  (ascVersion,A2),D1
            andi.b  #$F0,D1
            movea.l D2,A2
            rts
.L1:
            move.l  A1,SoundDCE
            move.b  SPVolCtl,D0
            bsr.w   sub_408E5B00
            bsr.b   sub_408E5A52
            rts
sub_408E5A52:
            clr.b   SoundActive
            tst.l   SoundBase
            beq.b   .L2
            moveq   #$10,D0
            _NewPtrSys
            tst.w   D0
            bne.b   .L2
            clr.l   (A0)
            move.w  #1,(4,A0)
            lea     sub_408E5E78,A1
            move.l  A1,(6,A0)
            move.w  #$3D,($A,A0)
            move.w  #9,($C,A0)
            movea.l VIA,A1
            bset    #7,(A1)
            move.w  #$80,($E,A0)
            _VInstall
.L1:
            movea.l ASCBase,A0
            move.l  A0,SoundBase
.L2:
            moveq   #0,D0
            rts
.L3:
            clr.w   CurPitch
.L4:
            movea.l ASCBase,A0
            clr.b   (ascMode,A0)
            bsr.b   sub_408E5AAC
            bra.b   .L2
sub_408E5AAC:
            tst.b   SoundActive
            beq.b   .L1
            lea     SoundVBL,A0
            _VRemove
            clr.b   SoundActive
.L1:
            rts
sub_408E5ABE:
            move.b  D0,SoundLevel
            movea.l ASCBase,A0
            movea.l D2,A1
            move.b  #$80,D2
            lsr.b   #1,D0
            tst.b   (ascVersion,A0)
            bne.b   .L1
            move.b  #$40,D2
            lsr.b   #1,D0
.L1:
            move.b  D2,D1
            sub.b   D0,D1
            add.b   D2,D0
            move.w  #$FF,D3
.L2:
            move.b  D1,($500,A0)
            move.b  D1,($100,A0)
            move.b  D0,($400,A0)
            move.b  D0,(A0)+
            dbra    D3,.L2
            move.b  D2,(A0)
            move.b  D2,($400,A0)
            move.l  A1,D2
            rts
sub_408E5B00:
            andi.w  #7,D0
            move.b  D0,SdVolume
            move.b  BoxFlag,D1
            cmpi.b  #$F,D1
            beq.b   .L1
            movea.l ASCBase,A0
            lsl.b   #5,D0
            move.b  D0,(ascVolControl,A0)
            bra.b   .L2
.L1:
            lea     sub_408E5B3C,A0
            move.b  (0,A0,D0.w),D0
            movea.l ASCBase,A0
            move.b  D0,(bmLeftScaleA,A0)
            clr.b   (bmRightScaleA,A0)
            clr.b   (bmLeftScaleB,A0)
            move.b  D0,(bmRightScaleB,A0)
.L2:
            rts
sub_408E5B3C:
            btst    D0,(A2)
            move.l  ($5A,A6,D4.l),D2
            bge.b   SoundStatus.L4+1
.L1:
            move.w  ($1A,A0),D0
            beq.b   SoundStatus
            subq.w  #2,D0
            beq.b   SoundStatus.L1
            blt.w   sub_408E5A52.L3
            move.w  ($1C,A0),D0
            bsr.w   sub_408E5ABE
SoundStatus:
            bra.w   sub_408E5CE2
.L1:
            move.w  ($1C,A0),D0
            bsr.b   sub_408E5B00
            bra.b   SoundStatus
.L2:
            movea.l ($20,A0),A1
            tst.w   (A1)+
            beq.w   sub_408E5D36.L2
            bpl.w   sub_408E5CE2.L1
            move.l  A0,-(SP)
            movea.l ASCBase,A0
            lea     ($800,A0),A0
            clr.b   (7,A0)
            move.b  #2,(2,A0)
            movem.l D0/A0,-(SP)
            lea     ($10,A0),A0
            move.w  #$1F,D0
.L3:
            clr.b   (A0)+
            dbra    D0,.L3
            movem.l (SP)+,D0/A0
            move.b  #$FE,($30,A0)
            clr.b   ($31,A0)
            move.b  #$FE,($32,A0)
            clr.b   ($33,A0)
            move.b  #$FE,($34,A0)
            clr.b   ($35,A0)
            move.b  #$FE,($36,A0)
.L4:
            clr.b   ($37,A0)
            clr.b   (5,A0)
            cmpi.b  #2,(1,A0)
            beq.b   .L5
            move.b  #2,(1,A0)
.L5:
            movea.l (SP)+,A0
.L6:
            movem.w (A1)+,D0-D2
            tst.w   D2
            beq.w   sub_408E5C64.L1
            move.l  A0,-(SP)
            move.w  D0,CurPitch
            moveq   #0,D3
            tst.w   D0
            beq.b   .L7
            move.l  #$11999999,D3
            divu.l  D0,D3
.L7:
            movea.l ASCBase,A0
            move.b  D3,($817,A0)
            move.b  D3,($827,A0)
            ror.l   #8,D3
            move.b  D3,($816,A0)
            move.b  D3,($826,A0)
            ror.l   #8,D3
            move.b  D3,($815,A0)
            move.b  D3,($825,A0)
            ror.l   #8,D3
            move.b  D3,(ascWaveIncr,A0)
            move.b  D3,($824,A0)
            move.w  D1,D0
            bsr.w   sub_408E5ABE
            move.w  D2,D0
            lea     sub_408E5C64,A1
            bsr.b   sub_408E5C3E
            movea.l (SP)+,A0
            addq.l  #6,($28,A0)
            bra.w   sub_408E5A52.L2
sub_408E5C3C:
            moveq   #1,D0
sub_408E5C3E:
            lea     SoundVBL,A0
            move.w  D0,($A,A0)
            tst.b   SoundActive
            bne.b   .L1
            clr.l   (A0)
            move.w  #1,(4,A0)
            move.l  A1,(6,A0)
            clr.w   ($C,A0)
            _VInstall
            st      SoundActive
.L1:
            rts
sub_408E5C64:
            movea.l SoundDCE,A1
            movea.l (8,A1),A0
            move.l  ($28,A0),D0
            movea.l ($20,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   ($24,A0),D0
            blt.w   SoundStatus.L6
.L1:
            clr.w   CurPitch
            movea.l ASCBase,A0
            lea     ($800,A0),A0
            clr.b   (ascWaveIncr-$800,A0)
            clr.b   (ascWaveIncr+1-$800,A0)
            clr.b   ($16,A0)
            clr.b   ($17,A0)
            clr.b   ($1C,A0)
            clr.b   ($1D,A0)
            clr.b   ($1E,A0)
            clr.b   ($1F,A0)
            clr.b   ($24,A0)
            clr.b   ($25,A0)
            clr.b   ($26,A0)
            clr.b   ($27,A0)
            clr.b   ($2C,A0)
            clr.b   ($2D,A0)
            clr.b   ($2E,A0)
            clr.b   ($2F,A0)
            clr.b   (ascMode-$800,A0)
            clr.b   (ascChipControl-$800,A0)
            clr.b   (ascFifoControl-$800,A0)
            clr.b   (ascFifoInt-$800,A0)
sub_408E5CDE:
            bsr.w   sub_408E5AAC
sub_408E5CE2:
            moveq   #0,D0
            movea.l SoundDCE,A1
            movea.l JIODone,A0
            jmp     (A0)
.L1:
            move.l  (A1)+,SoundPtr
            movea.l ASCBase,A1
            lea     ($800,A1),A1
            cmpi.b  #1,(ascMode-$800,A1)
            beq.b   .L2
            clr.b   (ascClockRate-$800,A1)
            clr.b   (ascChipControl-$800,A1)
            move.b  #1,(ascMode-$800,A1)
            bset    #7,(ascFifoControl-$800,A1)
            bclr    #7,(ascFifoControl-$800,A1)
.L2:
            lea     sub_408E5D36,A1
.L3:
            bsr.w   sub_408E5C3C
            bra.w   sub_408E5A52.L2
sub_408E5D28:
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            movem.l (SP)+,D0-D7/A0-A6
            bra.b   sub_408E5CDE
sub_408E5D36:
            movem.l D0-D7/A0-A6,-(SP)
            movea.l SoundPtr,A6
            tst.w   (A6)
            beq.b   sub_408E5D28
            lea     SoundVBL,A0
            move.w  #1,($A,A0)
            subq.w  #1,(A6)+
            movem.l (A6),D2-D7/A0-A5
            movea.l ASCBase,A6
            move.l  #$FF0000,D1
            move.w  #$172,-(SP)
.L1:
            clr.w   D1
            add.l   D2,D3
            add.l   D4,D5
            add.l   D6,D7
            adda.l  A0,A1
            move.l  D3,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A2,D0.w),D1
            move.l  D5,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A3,D0.w),D0
            add.w   D0,D1
            move.l  D7,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A4,D0.w),D0
            add.w   D0,D1
            move.l  A1,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,D1
            lsr.w   #2,D1
            move.b  D1,(A6)
            subq.w  #1,(SP)
            bne.b   .L1
            move.b  D1,SoundLevel
            addq.w  #2,SP
            movea.l SoundPtr,A6
            addq.w  #2,A6
            movem.l D2-D7/A0-A1,(A6)
            movem.l (SP)+,D0-D7/A0-A6
            rts
.L2:
            movea.l ASCBase,A1
            lea     ($800,A1),A1
            cmpi.b  #1,(ascMode-$800,A1)
            beq.b   .L3
            clr.b   (7,A1)
            clr.b   (2,A1)
            move.b  #1,(1,A1)
            bset    #7,(3,A1)
            bclr    #7,(3,A1)
.L3:
            movea.l SoundDCE,A1
            clr.l   ($10,A1)
            lea     sub_408E5DF0,A1
            bra.w   sub_408E5CE2.L3
sub_408E5DF0:
            movea.l SoundDCE,A1
            move.l  (8,A1),D0
            bne.b   .L1
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            bsr.w   sub_408E5AAC
            rts
.L1:
            movea.l D0,A0
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.b   .L2
            bsr.w   sub_408E5CDE
            bra.b   sub_408E5DF0
.L2:
            move.l  ($10,A1),D3
            lea     SoundVBL,A3
            move.w  #1,($A,A3)
            movea.l ($20,A0),A1
            addq.w  #2,A1
            move.l  (A1)+,D1
            movea.l A1,A3
            adda.l  ($24,A0),A3
            adda.l  D0,A1
            movea.l ASCBase,A2
            move.w  #$171,D2
            moveq   #0,D0
.L3:
            move.b  (A1),(A2)
            add.l   D1,D3
            swap    D3
            adda.w  D3,A1
            add.w   D3,D0
            clr.w   D3
            swap    D3
            cmpa.l  A1,A3
            dble    D2,.L3
            add.l   D0,($28,A0)
            move.b  (-1,A1),SoundLevel
            movea.l SoundDCE,A1
            move.l  D3,($10,A1)
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.b   .L4
            bsr.w   sub_408E5CE2
.L4:
            rts
sub_408E5E78:
            move.w  #$3D,($A,A0)
            movea.l VIA,A1
            move.b  (A1),D0
            andi.b  #$80,D0
            move.b  ($E,A0),D1
            eor.b   D0,D1
            beq.b   .L2
            move.b  D0,($E,A0)
            beq.b   .L1
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            rts
.L1:
            movea.l ASCBase,A0
            lea     ($800,A0),A0
            cmpi.b  #1,(ascMode-$800,A0)
            beq.b   .L2
            clr.b   (7,A0)
            clr.b   (2,A0)
            move.b  #1,(1,A0)
            bset    #7,(3,A0)
            bclr    #7,(3,A0)
.L2:
            rts
.L3:
            move.l  D1,D2
            move.l  A1,SoundDCE
            bsr.b   sub_408E5F0A
            move.b  SPVolCtl,D0
            bsr.w   sub_408E5B00
            clr.b   SoundActive
            moveq   #$C,D0
            _NewPtrSys
            move.l  A0,D0
            beq.b   .L4
            movea.l SoundDCE,A1
            move.l  A0,($14,A1)
.L4:
            cmpi.b  #$B0,D2
            beq.w   sub_408E5A52
            bra.w   sub_408E5A52.L1
.L5:
            clr.w   CurPitch
.L6:
            bsr.w   sub_408E5AAC
            bsr.b   sub_408E5F0A
            bra.w   sub_408E5A52.L2
sub_408E5F0A:
            move.b  #$80,D0
            bsr.b   sub_408E5F2A
sub_408E5F10:
            movea.l VIA,A0
            tst.b   T1Arbitrate
            bne.b   .L1
            andi.b  #$3F,(vACR,A0)
            st      T1Arbitrate
.L1:
            rts
sub_408E5F26:
            move.b  SoundLevel,D0
sub_408E5F2A:
            move.b  D0,SoundLevel
            move.b  D0,D1
            lsl.w   #8,D0
            move.b  D1,D0
            move.w  D0,D1
            swap    D0
            move.w  D1,D0
            movea.l SoundBase,A0
            moveq   #$2D,D1
.L1:
            movep.l D0,0.w(A0)
            movep.l D0,(8,A0)
            lea     ($10,A0),A0
            dbra    D1,.L1
            movep.w D0,0.w(A0)
            rts
.L2:
            move.w  ($1A,A0),D0
            beq.w   SoundStatus
            subq.w  #2,D0
            beq.w   SoundStatus.L1
            blt.b   sub_408E5E78.L5
            move.w  ($1C,A0),D0
            bsr.w   sub_408E5A30
            cmpi.b  #$E0,D1
            beq.b   .L3
            cmpi.b  #$B0,D1
            beq.b   .L3
            bsr.b   sub_408E5F2A
            bra.w   SoundStatus
.L3:
            movea.l SoundDCE,A1
            movea.l ($14,A1),A1
            move.b  D0,SoundLevel
            move.b  #$80,D1
            lsr.b   #1,D0
            move.b  D1,D2
            sub.b   D0,D2
            add.b   D1,D0
            move.b  D2,(8,A1)
            move.b  D0,(9,A1)
            bra.w   SoundStatus
.L4:
            movea.l VIA,A1
            bclr    #7,(A1)
            movea.l ($20,A0),A1
            tst.w   (A1)+
            beq.w   sub_408E61AC.L6
            bpl.w   sub_408E60C2.L8
            bsr.w   sub_408E5A30
            cmpi.b  #$E0,D1
            beq.w   sub_408E6072.L1
            cmpi.b  #$B0,D1
            beq.w   sub_408E6072.L1
.L5:
            movem.w (A1)+,D0-D2
            tst.w   D2
            beq.w   sub_408E604C.L1
            move.l  A0,-(SP)
            tst.b   T1Arbitrate
            beq.b   .L6
            bclr    #7,T1Arbitrate
            beq.b   .L7
            clr.b   T1Arbitrate
.L6:
            movea.l VIA,A0
            ori.b   #$C0,($1600,A0)
            cmp.w   CurPitch,D0
            beq.b   .L7
            move.b  D0,($800,A0)
            ror.w   #8,D0
            move.b  D0,($A00,A0)
            ror.w   #8,D0
.L7:
            move.w  D0,CurPitch
            move.w  D1,D0
            bsr.w   sub_408E5F2A
            move.w  D2,D0
            lea     sub_408E604C,A1
            bsr.b   sub_408E6026
            movea.l (SP)+,A0
            addq.l  #6,($28,A0)
            bra.w   sub_408E5A52.L2
sub_408E6024:
            moveq   #1,D0
sub_408E6026:
            lea     SoundVBL,A0
            move.w  D0,($A,A0)
            tst.b   SoundActive
            bne.b   .L1
            clr.l   (A0)
            move.w  #1,(4,A0)
            move.l  A1,(6,A0)
            clr.w   ($C,A0)
            _VInstall
            st      SoundActive
.L1:
            rts
sub_408E604C:
            movea.l SoundDCE,A1
            movea.l (8,A1),A0
            move.l  ($28,A0),D0
            movea.l ($20,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   ($24,A0),D0
            blt.w   sub_408E5F2A.L5
.L1:
            bsr.w   sub_408E5F10
            clr.w   CurPitch
sub_408E6072:
            bsr.w   sub_408E5AAC
            bsr.w   sub_408E5F26
            bra.w   sub_408E5CE2
.L1:
            movea.l ASCBase,A0
            lea     (ascVersion,A0),A0
            cmpi.b  #1,(1,A0)
            beq.b   .L2
            clr.b   (7,A0)
            clr.b   (2,A0)
            move.b  #1,(1,A0)
            bset    #7,(3,A0)
            bclr    #7,(3,A0)
.L2:
            movea.l SoundDCE,A1
            movea.l ($14,A1),A2
            clr.l   (A2)
            clr.w   ($A,A2)
            lea     sub_408E60C2,A1
            bsr.w   sub_408E5C3C
            bra.w   sub_408E5A52.L2
sub_408E60C2:
            movem.l D4-D6,-(SP)
            move.w  #1,($A,A0)
            movea.l SoundDCE,A1
            movea.l ($14,A1),A2
            tst.w   ($A,A2)
            bne.w   .L4
            movea.l SoundDCE,A1
            movea.l (8,A1),A0
            move.l  ($28,A0),D0
            movea.l ($20,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   ($24,A0),D0
            blt.w   .L2
.L1:
            clr.w   CurPitch
            movea.l ASCBase,A0
            clr.b   (ascMode,A0)
            bsr.w   sub_408E5AAC
            movem.l (SP)+,D4-D6
            bra.w   sub_408E5CE2
.L2:
            movem.w (A1)+,D0-D2
            tst.w   D2
            beq.b   .L1
            moveq   #0,D3
            tst.w   D0
            beq.b   .L3
            move.l  #$11999999,D3
            divu.l  D0,D3
            move.w  D0,CurPitch
.L3:
            move.l  D3,(4,A2)
            move.b  D1,SoundLevel
            move.b  #$80,D0
            lsr.b   #1,D1
            move.b  D0,D3
            sub.b   D1,D3
            add.b   D0,D1
            move.b  D3,(8,A2)
            move.b  D1,(9,A2)
            move.w  D2,($A,A2)
            addq.l  #6,($28,A0)
.L4:
            subq.w  #1,($A,A2)
            move.l  (A2),D0
            move.l  (4,A2),D1
            move.b  (8,A2),D2
            move.b  (9,A2),D3
            movea.l ASCBase,A0
            move.l  #$800000,D4
            move.w  #$172,D6
            tst.l   D0
            bne.b   .L5
            move.w  #$1F2,D6
.L5:
            add.l   D1,D0
            move.l  D0,D5
            and.l   D4,D5
            bne.b   .L6
            move.b  D3,(A0)
            bra.b   .L7
.L6:
            move.b  D2,(A0)
.L7:
            subq.w  #1,D6
            bne.b   .L5
            move.l  D0,(A2)
            movem.l (SP)+,D4-D6
            rts
.L8:
            move.l  (A1)+,SoundPtr
            lea     sub_408E61AC,A1
.L9:
            bsr.w   sub_408E6024
            bra.w   sub_408E5A52.L2
sub_408E61A4:
            movem.l (SP)+,D0-D7/A0-A6
            bra.w   sub_408E6072
sub_408E61AC:
            movem.l D0-D7/A0-A6,-(SP)
            movea.l SoundPtr,A6
            tst.w   (A6)
            beq.b   sub_408E61A4
            lea     SoundVBL,A0
            move.w  #1,($A,A0)
            subq.w  #1,(A6)+
            movem.l (A6),D2-D7/A0-A5
            movea.l SoundBase,A6
            move.l  #$FF0000,D1
            move.l  A0,D0
            bne.b   .L1
            move.l  D6,D0
            bne.b   .L1
            move.l  D4,D0
            beq.b   .L3
.L1:
            lea     ($172,A6),A6
            move.w  #2,-(SP)
            move.w  #$B9,-(SP)
.L2:
            clr.w   D1
            add.l   D2,D3
            add.l   D4,D5
            add.l   D6,D7
            adda.l  A0,A1
            move.l  D3,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A2,D0.w),D1
            move.l  D5,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A3,D0.w),D0
            add.w   D0,D1
            move.l  D7,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A4,D0.w),D0
            add.w   D0,D1
            move.l  A1,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,D1
            lsr.w   #2,D1
            move.b  D1,(A6)
            addq.w  #2,A6
            subq.w  #1,(SP)
            bne.b   .L2
            move.b  (-2,A2),SoundLevel
            movea.l SoundBase,A6
            move.w  #$B9,(SP)
            subq.w  #1,(2,SP)
            bne.b   .L2
            bra.b   .L5
.L3:
            lea     ($8C,A6),A6
            move.w  #2,-(SP)
            move.w  #$12C,-(SP)
            move.l  D5,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A3,D0.w),D0
            move.w  D0,-(SP)
            move.l  D7,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A4,D0.w),D0
            add.w   D0,(SP)
            move.l  A1,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,(SP)
.L4:
            clr.w   D1
            add.l   D2,D3
            move.l  D3,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A2,D0.w),D1
            add.w   (SP),D1
            lsr.w   #2,D1
            move.b  D1,(A6)
            addq.w  #2,A6
            subq.w  #1,(2,SP)
            bne.b   .L4
            move.b  (-2,A2),SoundLevel
            movea.l SoundBase,A6
            move.w  #$46,(2,SP)
            subq.w  #1,(4,SP)
            bne.b   .L4
            addq.w  #2,SP
.L5:
            addq.w  #4,SP
            movea.l SoundPtr,A6
            addq.w  #2,A6
            movem.l D2-D7/A0-A1,(A6)
            movem.l (SP)+,D0-D7/A0-A6
            rts
.L6:
            movea.l SoundDCE,A1
            clr.l   ($10,A1)
            lea     sub_408E62C8,A1
            bra.w   sub_408E60C2.L9
sub_408E62C8:
            movea.l SoundDCE,A1
            move.l  (8,A1),D0
            bne.b   .L1
            bsr.w   sub_408E5AAC
            bsr.w   sub_408E5F26
            rts
.L1:
            movea.l D0,A0
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.b   .L2
            bsr.w   sub_408E6072
            bra.b   sub_408E62C8
.L2:
            move.l  ($10,A1),D3
            lea     SoundVBL,A3
            move.w  #1,($A,A3)
            move.l  A4,-(SP)
            movea.l ($20,A0),A1
            addq.w  #2,A1
            move.l  (A1)+,D1
            movea.l A1,A3
            adda.l  ($24,A0),A3
            adda.l  D0,A1
            movea.l SoundBase,A2
            lea     ($40,A2),A2
            lea     ($2A4,A2),A4
            clr.w   -(SP)
            move.w  #$151,D2
.L3:
            moveq   #0,D0
.L4:
            move.b  (A1),(A2)
            addq.w  #2,A2
            add.l   D1,D3
            swap    D3
            adda.w  D3,A1
            add.w   D3,D0
            clr.w   D3
            swap    D3
            cmpa.l  A1,A3
            dble    D2,.L4
            add.l   D0,($28,A0)
            tst.w   (SP)+
            beq.b   .L10
            tst.w   D2
            bmi.b   .L8
.L5:
            moveq   #0,D0
.L6:
            move.b  D0,(A2)
            addq.w  #2,A2
            cmpa.l  A2,A4
            bgt.b   .L7
            movea.l SoundBase,A2
.L7:
            dbra    D2,.L6
.L8:
            movea.l SoundDCE,A1
            move.l  D3,($10,A1)
            move.b  (-2,A2),SoundLevel
            movea.l (SP)+,A4
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.b   .L9
            bsr.w   sub_408E5CE2
.L9:
            rts
.L10:
            tst.w   D2
            bmi.b   .L11
            addi.w  #$20,D2
            bra.b   .L5
.L11:
            move.w  #1,-(SP)
            movea.l SoundBase,A2
            moveq   #$1F,D2
            bra.b   .L3
            ds.b    4

            EVEN
