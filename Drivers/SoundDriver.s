            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_3

            IMPORT  BaseOfROM,RsrcEntryDRVR_9

            SECTION "SoundDriver",CODE

vblSndEnbState  EQU         $E                      ; SndEnb watcher VBL task: last vBufB bit 7
sqPhase         EQU         0                           ; Software square wave (dCtlStorage block)
sqIncr          EQU         4                           ; Phase increment ($11999999 / count)
sqLevelLo       EQU         8                           ; Low sample level
sqLevelHi       EQU         9                           ; High sample level
sqTicks         EQU         $A                      ; Ticks left in current tone

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
            bsr.b   IsAscMac
            beq.b   AscOpen
            bra.w   BufOpen
SoundPrimeCommon:
            bsr.b   IsAscMac
            beq.w   AscPrime
            bra.w   BufPrime
SoundCtlCommon:
            bsr.b   IsAscMac
            beq.w   AscControl
            bra.w   BufControl
SoundCloseCommon:
            bsr.b   IsAscMac
            beq.w   AscClose
            bra.w   BufClose
IsAscMac:
            move.l  A2,D2
            movea.l ASCBase,A2
            move.b  (ascVersion,A2),D1
            andi.b  #$F0,D1
            movea.l D2,A2
            rts
AscOpen:
            move.l  A1,SoundDCE
            move.b  SPVolCtl,D0
            bsr.w   SetSoundVolume
            bsr.b   InstallSndEnbWatch
            rts
InstallSndEnbWatch:
            clr.b   SoundActive
            tst.l   SoundBase
            beq.b   CommonExit
            moveq   #$10,D0
            _NewPtrSys
            tst.w   D0
            bne.b   CommonExit
            clr.l   (A0)
            move.w  #1,(qType,A0)
            lea     SndEnbWatchVBL,A1
            move.l  A1,(vblAddr,A0)
            move.w  #$3D,(vblCount,A0)
            move.w  #9,(vblPhase,A0)
            movea.l VIA,A1
            bset    #7,(vBufB,A1)
            move.w  #$80,(vblSndEnbState,A0)
            _VInstall
SetSoundBase:
            movea.l ASCBase,A0
            move.l  A0,SoundBase
CommonExit:
            moveq   #0,D0
            rts
AscKill:
            clr.w   CurPitch
AscClose:
            movea.l ASCBase,A0
            clr.b   (ascMode,A0)
            bsr.b   RemoveSoundVBL
            bra.b   CommonExit
RemoveSoundVBL:
            tst.b   SoundActive
            beq.b   .L1
            lea     SoundVBL,A0
            _VRemove
            clr.b   SoundActive
.L1:
            rts
SetSquareAmplitude:
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
            move.b  D1,(ascFiFoRight+$100,A0)
            move.b  D1,(ascFifoLeft+$100,A0)
            move.b  D0,(ascFiFoRight,A0)
            move.b  D0,(A0)+
            dbra    D3,.L2
            move.b  D2,(A0)
            move.b  D2,(ascFiFoRight,A0)
            move.l  A1,D2
            rts
SetSoundVolume:
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
            lea     BatmanVolTable,A0
            move.b  (0,A0,D0.w),D0
            movea.l ASCBase,A0
            move.b  D0,(bmLeftScaleA,A0)
            clr.b   (bmRightScaleA,A0)
            clr.b   (bmLeftScaleB,A0)
            move.b  D0,(bmRightScaleB,A0)
.L2:
            rts
BatmanVolTable:
            dc.b    $01,$12,$24,$36,$48,$5A,$6C,$7F
AscControl:
            move.w  (csCode,A0),D0
            beq.b   SoundStatus
            subq.w  #2,D0
            beq.b   AscSetVolume
            blt.w   AscKill
            move.w  (csParam,A0),D0
            bsr.w   SetSquareAmplitude
SoundStatus:
            bra.w   SoundDone
AscSetVolume:
            move.w  (csParam,A0),D0
            bsr.b   SetSoundVolume
            bra.b   SoundStatus
AscPrime:
            movea.l (ioBuffer,A0),A1
            tst.w   (A1)+
            beq.w   AscFreeFormStart
            bpl.w   AscFourToneStart
            move.l  A0,-(SP)
            movea.l ASCBase,A0
            lea     (ascVersion,A0),A0
            clr.b   (ascClockRate-$800,A0)
            move.b  #2,(ascChipControl-$800,A0)
            movem.l D0/A0,-(SP)
            lea     (ascWavePhase-$800,A0),A0
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
            clr.b   (ascWaveOneShot-$800,A0)
            cmpi.b  #2,(ascMode-$800,A0)
            beq.b   .L5
            move.b  #2,(ascMode-$800,A0)
.L5:
            movea.l (SP)+,A0
AscNextTone:
            movem.w (A1)+,D0-D2
            tst.w   D2
            beq.w   AscSquareEnd
            move.l  A0,-(SP)
            move.w  D0,CurPitch
            moveq   #0,D3
            tst.w   D0
            beq.b   .L7
            move.l  #$11999999,D3
            divu.l  D0,D3
.L7:
            movea.l ASCBase,A0
            move.b  D3,(ascWaveIncr+3,A0)
            move.b  D3,(ascWaveIncr+$10+3,A0)
            ror.l   #8,D3
            move.b  D3,(ascWaveIncr+2,A0)
            move.b  D3,(ascWaveIncr+$10+2,A0)
            ror.l   #8,D3
            move.b  D3,(ascWaveIncr+1,A0)
            move.b  D3,(ascWaveIncr+$10+1,A0)
            ror.l   #8,D3
            move.b  D3,(ascWaveIncr,A0)
            move.b  D3,(ascWaveIncr+$10,A0)
            move.w  D1,D0
            bsr.w   SetSquareAmplitude
            move.w  D2,D0
            lea     NextSquareTone,A1
            bsr.b   InstallVBL
            movea.l (SP)+,A0
            addq.l  #6,(ioActCount,A0)
            bra.w   CommonExit
InstallVBL1:
            moveq   #1,D0
InstallVBL:
            lea     SoundVBL,A0
            move.w  D0,(vblCount,A0)
            tst.b   SoundActive
            bne.b   .L1
            clr.l   (A0)
            move.w  #1,(qType,A0)
            move.l  A1,(vblAddr,A0)
            clr.w   (vblPhase,A0)
            _VInstall
            st      SoundActive
.L1:
            rts
NextSquareTone:
            movea.l SoundDCE,A1
            movea.l (dCtlQHead,A1),A0
            move.l  (ioActCount,A0),D0
            movea.l (ioBuffer,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   (ioReqCount,A0),D0
            blt.w   AscNextTone
AscSquareEnd:
            clr.w   CurPitch
            movea.l ASCBase,A0
            lea     (ascVersion,A0),A0
            clr.b   (ascWaveIncr-$800,A0)
            clr.b   (ascWaveIncr+1-$800,A0)
            clr.b   (ascWaveIncr+2-$800,A0)
            clr.b   (ascWaveIncr+3-$800,A0)
            clr.b   (ascWaveIncr+$8-$800,A0)
            clr.b   (ascWaveIncr+$8+1-$800,A0)
            clr.b   (ascWaveIncr+$8+2-$800,A0)
            clr.b   (ascWaveIncr+$8+3-$800,A0)
            clr.b   (ascWaveIncr+$10-$800,A0)
            clr.b   (ascWaveIncr+$10+1-$800,A0)
            clr.b   (ascWaveIncr+$10+2-$800,A0)
            clr.b   (ascWaveIncr+$10+3-$800,A0)
            clr.b   (ascWaveIncr+$18-$800,A0)
            clr.b   (ascWaveIncr+$18+1-$800,A0)
            clr.b   (ascWaveIncr+$18+2-$800,A0)
            clr.b   (ascWaveIncr+$18+3-$800,A0)
            clr.b   (ascMode-$800,A0)
            clr.b   (ascChipControl-$800,A0)
            clr.b   (ascFifoControl-$800,A0)
            clr.b   (ascFifoInt-$800,A0)
StopAndDone:
            bsr.w   RemoveSoundVBL
SoundDone:
            moveq   #0,D0
            movea.l SoundDCE,A1
            movea.l JIODone,A0
            jmp     (A0)
AscFourToneStart:
            move.l  (A1)+,SoundPtr
            movea.l ASCBase,A1
            lea     (ascVersion,A1),A1
            cmpi.b  #1,(ascMode-$800,A1)
            beq.b   .L2
            clr.b   (ascClockRate-$800,A1)
            clr.b   (ascChipControl-$800,A1)
            move.b  #1,(ascMode-$800,A1)
            bset    #7,(ascFifoControl-$800,A1)
            bclr    #7,(ascFifoControl-$800,A1)
.L2:
            lea     FourToneASC,A1
.StartVBL:
            bsr.w   InstallVBL1
            bra.w   CommonExit
FourToneDoneASC:
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            movem.l (SP)+,D0-D7/A0-A6
            bra.b   StopAndDone
FourToneASC:
            movem.l D0-D7/A0-A6,-(SP)
            movea.l SoundPtr,A6
            tst.w   (A6)
            beq.b   FourToneDoneASC
            lea     SoundVBL,A0
            move.w  #1,(vblCount,A0)
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
AscFreeFormStart:
            movea.l ASCBase,A1
            lea     (ascVersion,A1),A1
            cmpi.b  #1,(ascMode-$800,A1)
            beq.b   .L3
            clr.b   (ascClockRate-$800,A1)
            clr.b   (ascChipControl-$800,A1)
            move.b  #1,(ascMode-$800,A1)
            bset    #7,(ascFifoControl-$800,A1)
            bclr    #7,(ascFifoControl-$800,A1)
.L3:
            movea.l SoundDCE,A1
            clr.l   (dCtlPosition,A1)
            lea     FreeFormASC,A1
            bra.w   AscFourToneStart.StartVBL
FreeFormASC:
            movea.l SoundDCE,A1
            move.l  (dCtlQHead,A1),D0
            bne.b   .L1
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            bsr.w   RemoveSoundVBL
            rts
.L1:
            movea.l D0,A0
            move.l  (ioActCount,A0),D0
            cmp.l   (ioReqCount,A0),D0
            blt.b   .L2
            bsr.w   StopAndDone
            bra.b   FreeFormASC
.L2:
            move.l  (dCtlPosition,A1),D3
            lea     SoundVBL,A3
            move.w  #1,(vblCount,A3)
            movea.l (ioBuffer,A0),A1
            addq.w  #2,A1
            move.l  (A1)+,D1
            movea.l A1,A3
            adda.l  (ioReqCount,A0),A3
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
            add.l   D0,(ioActCount,A0)
            move.b  (-1,A1),SoundLevel
            movea.l SoundDCE,A1
            move.l  D3,(dCtlPosition,A1)
            move.l  (ioActCount,A0),D0
            cmp.l   (ioReqCount,A0),D0
            blt.b   .L4
            bsr.w   SoundDone
.L4:
            rts
SndEnbWatchVBL:
            move.w  #$3D,(vblCount,A0)
            movea.l VIA,A1
            move.b  (vBufB,A1),D0
            andi.b  #$80,D0
            move.b  (vblSndEnbState,A0),D1
            eor.b   D0,D1
            beq.b   .L2
            move.b  D0,(vblSndEnbState,A0)
            beq.b   .L1
            movea.l ASCBase,A1
            clr.b   (ascMode,A1)
            rts
.L1:
            movea.l ASCBase,A0
            lea     (ascVersion,A0),A0
            cmpi.b  #1,(ascMode-$800,A0)
            beq.b   .L2
            clr.b   (ascClockRate-$800,A0)
            clr.b   (ascChipControl-$800,A0)
            move.b  #1,(ascMode-$800,A0)
            bset    #7,(ascFifoControl-$800,A0)
            bclr    #7,(ascFifoControl-$800,A0)
.L2:
            rts
BufOpen:
            move.l  D1,D2
            move.l  A1,SoundDCE
            bsr.b   SilenceBuffer
            move.b  SPVolCtl,D0
            bsr.w   SetSoundVolume
            clr.b   SoundActive
            moveq   #$C,D0
            _NewPtrSys
            move.l  A0,D0
            beq.b   .L4
            movea.l SoundDCE,A1
            move.l  A0,(dCtlStorage,A1)
.L4:
            cmpi.b  #$B0,D2
            beq.w   InstallSndEnbWatch
            bra.w   SetSoundBase
.BufKill:
            clr.w   CurPitch
BufClose:
            bsr.w   RemoveSoundVBL
            bsr.b   SilenceBuffer
            bra.w   CommonExit
SilenceBuffer:
            move.b  #$80,D0
            bsr.b   FillSoundBuffer
ReleaseTimer1:
            movea.l VIA,A0
            tst.b   T1Arbitrate
            bne.b   .L1
            andi.b  #$3F,(vACR,A0)
            st      T1Arbitrate
.L1:
            rts
RefillSoundBuffer:
            move.b  SoundLevel,D0
FillSoundBuffer:
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
            lea     (ascWavePhase-$800,A0),A0
            dbra    D1,.L1
            movep.w D0,0.w(A0)
            rts
BufControl:
            move.w  (csCode,A0),D0
            beq.w   SoundStatus
            subq.w  #2,D0
            beq.w   AscSetVolume
            blt.b   BufOpen.BufKill
            move.w  (csParam,A0),D0
            bsr.w   IsAscMac
            cmpi.b  #elsieSound,D1
            beq.b   .L3
            cmpi.b  #batmanSound,D1
            beq.b   .L3
            bsr.b   FillSoundBuffer
            bra.w   SoundStatus
.L3:
            movea.l SoundDCE,A1
            movea.l (dCtlStorage,A1),A1
            move.b  D0,SoundLevel
            move.b  #$80,D1
            lsr.b   #1,D0
            move.b  D1,D2
            sub.b   D0,D2
            add.b   D1,D0
            move.b  D2,(sqLevelLo,A1)
            move.b  D0,(sqLevelHi,A1)
            bra.w   SoundStatus
BufPrime:
            movea.l VIA,A1
            bclr    #7,(vBufB,A1)
            movea.l (ioBuffer,A0),A1
            tst.w   (A1)+
            beq.w   BufFreeFormStart
            bpl.w   BufFourToneStart
            bsr.w   IsAscMac
            cmpi.b  #elsieSound,D1
            beq.w   SoftSquareStart
            cmpi.b  #batmanSound,D1
            beq.w   SoftSquareStart
BufNextTone:
            movem.w (A1)+,D0-D2
            tst.w   D2
            beq.w   BufSquareEnd
            move.l  A0,-(SP)
            tst.b   T1Arbitrate
            beq.b   .L6
            bclr    #7,T1Arbitrate
            beq.b   .L7
            clr.b   T1Arbitrate
.L6:
            movea.l VIA,A0
            ori.b   #$C0,(vACR,A0)
            cmp.w   CurPitch,D0
            beq.b   .L7
            move.b  D0,(vT1C,A0)
            ror.w   #8,D0
            move.b  D0,(vT1CH,A0)
            ror.w   #8,D0
.L7:
            move.w  D0,CurPitch
            move.w  D1,D0
            bsr.w   FillSoundBuffer
            move.w  D2,D0
            lea     BufNextSquareTone,A1
            bsr.b   BufInstallVBL
            movea.l (SP)+,A0
            addq.l  #6,(ioActCount,A0)
            bra.w   CommonExit
BufInstallVBL1:
            moveq   #1,D0
BufInstallVBL:
            lea     SoundVBL,A0
            move.w  D0,(vblCount,A0)
            tst.b   SoundActive
            bne.b   .L1
            clr.l   (A0)
            move.w  #1,(qType,A0)
            move.l  A1,(vblAddr,A0)
            clr.w   (vblPhase,A0)
            _VInstall
            st      SoundActive
.L1:
            rts
BufNextSquareTone:
            movea.l SoundDCE,A1
            movea.l (dCtlQHead,A1),A0
            move.l  (ioActCount,A0),D0
            movea.l (ioBuffer,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   (ioReqCount,A0),D0
            blt.w   BufNextTone
BufSquareEnd:
            bsr.w   ReleaseTimer1
            clr.w   CurPitch
BufStopAndDone:
            bsr.w   RemoveSoundVBL
            bsr.w   RefillSoundBuffer
            bra.w   SoundDone
SoftSquareStart:
            movea.l ASCBase,A0
            lea     (ascVersion,A0),A0
            cmpi.b  #1,(ascMode-$800,A0)
            beq.b   .L2
            clr.b   (ascClockRate-$800,A0)
            clr.b   (ascChipControl-$800,A0)
            move.b  #1,(ascMode-$800,A0)
            bset    #7,(ascFifoControl-$800,A0)
            bclr    #7,(ascFifoControl-$800,A0)
.L2:
            movea.l SoundDCE,A1
            movea.l (dCtlStorage,A1),A2
            clr.l   (A2)
            clr.w   (sqTicks,A2)
            lea     SoftSquareWave,A1
            bsr.w   InstallVBL1
            bra.w   CommonExit
SoftSquareWave:
            movem.l D4-D6,-(SP)
            move.w  #1,(vblCount,A0)
            movea.l SoundDCE,A1
            movea.l (dCtlStorage,A1),A2
            tst.w   (sqTicks,A2)
            bne.w   .L4
            movea.l SoundDCE,A1
            movea.l (dCtlQHead,A1),A0
            move.l  (ioActCount,A0),D0
            movea.l (ioBuffer,A0),A1
            adda.l  D0,A1
            addq.l  #2,A1
            addq.w  #4,D0
            cmp.l   (ioReqCount,A0),D0
            blt.w   .L2
.L1:
            clr.w   CurPitch
            movea.l ASCBase,A0
            clr.b   (ascMode,A0)
            bsr.w   RemoveSoundVBL
            movem.l (SP)+,D4-D6
            bra.w   SoundDone
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
            move.l  D3,(sqIncr,A2)
            move.b  D1,SoundLevel
            move.b  #$80,D0
            lsr.b   #1,D1
            move.b  D0,D3
            sub.b   D1,D3
            add.b   D0,D1
            move.b  D3,(sqLevelLo,A2)
            move.b  D1,(sqLevelHi,A2)
            move.w  D2,(sqTicks,A2)
            addq.l  #6,(ioActCount,A0)
.L4:
            subq.w  #1,(sqTicks,A2)
            move.l  (A2),D0
            move.l  (sqIncr,A2),D1
            move.b  (sqLevelLo,A2),D2
            move.b  (sqLevelHi,A2),D3
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
BufFourToneStart:
            move.l  (A1)+,SoundPtr
            lea     FourToneBuffer,A1
.StartVBL:
            bsr.w   BufInstallVBL1
            bra.w   CommonExit
FourToneDoneBuf:
            movem.l (SP)+,D0-D7/A0-A6
            bra.w   BufStopAndDone
FourToneBuffer:
            movem.l D0-D7/A0-A6,-(SP)
            movea.l SoundPtr,A6
            tst.w   (A6)
            beq.b   FourToneDoneBuf
            lea     SoundVBL,A0
            move.w  #1,(vblCount,A0)
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
BufFreeFormStart:
            movea.l SoundDCE,A1
            clr.l   (dCtlPosition,A1)
            lea     FreeFormBuffer,A1
            bra.w   BufFourToneStart.StartVBL
FreeFormBuffer:
            movea.l SoundDCE,A1
            move.l  (dCtlQHead,A1),D0
            bne.b   .L1
            bsr.w   RemoveSoundVBL
            bsr.w   RefillSoundBuffer
            rts
.L1:
            movea.l D0,A0
            move.l  (ioActCount,A0),D0
            cmp.l   (ioReqCount,A0),D0
            blt.b   .L2
            bsr.w   BufStopAndDone
            bra.b   FreeFormBuffer
.L2:
            move.l  (dCtlPosition,A1),D3
            lea     SoundVBL,A3
            move.w  #1,(vblCount,A3)
            move.l  A4,-(SP)
            movea.l (ioBuffer,A0),A1
            addq.w  #2,A1
            move.l  (A1)+,D1
            movea.l A1,A3
            adda.l  (ioReqCount,A0),A3
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
            add.l   D0,(ioActCount,A0)
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
            move.l  D3,(dCtlPosition,A1)
            move.b  (-2,A2),SoundLevel
            movea.l (SP)+,A4
            move.l  (ioActCount,A0),D0
            cmp.l   (ioReqCount,A0),D0
            blt.b   .L9
            bsr.w   SoundDone
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
