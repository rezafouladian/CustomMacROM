            include "Include/ROMHeader.s"

            EXPORT  GetHardwareInfo,GotBusError,InitVIAs,JumpIntoROM,ROMBERRANDVBRRTN

            IMPORT  BaseOfROM,GetVIAInputs,MEMORYCTRLINITPATCH,RELOADBERRVBR,SNDCNTLECLIPSE,SNDCNTLSPIKE
            IMPORT  SNDCNTLTIM,TestForFPU,TESTFORIOP,TESTFORRPU,TESTFORRVIER,TESTFORSCSI96
            IMPORT  TestForSCSIDMA,TESTFORVIER,TESTVIERWRAP

            SECTION "Universal",CODE

JumpIntoROM:
Universal:
            movea.w #$2600,SP
            movea.l A6,A4
            lea     GotBusError,A0
            move.l  A0,D0
.loop:
            cmp.l   -(A0),D0
            beq.b   .found
            tst.l   (A0)
            bne.b   .loop
            lea     BusErrVct,A0
            move.l  D0,(A0)
.found:
            subq.w  #8,A0
            movec   A0,VBR
.L3:
            moveq   #0,D2
            BSR6    GetHardwareInfo
            btst    #0,D0
            beq.b   .L3
            lea     BaseOfROM(PC),A2
            jmp     CheckMoreBases.L18
.L4:
            adda.l  D3,A4
            jmp     .L5(PC,D3.l)
.L5:
            nop
            nop
            bra.w   RELOADBERRVBR
ROMBERRANDVBRRTN:
            btst    #$12,D0
            beq.b   .L1
            movea.l ($48,A0),A3
            move.b  #$D,($204,A3)
.L1:
            btst    #$13,D0
            beq.b   .L3
            movea.l ($4C,A0),A3
            move.w  #$F3FF,D3
            moveq   #$F,D4
.L2:
            move.b  D3,(A3)
            lsr.w   #1,D3
            dbra    D4,.L2
            move.b  D3,($10,A3)
.L3:
            bra.l   MEMORYCTRLINITPATCH
            dc.w    $4ED4
            ds.b    18
InitVIAs:
            btst    #2,D0
            beq.b   .L1
            movea.l (8,A0),A2
            movea.l A1,A3
            adda.l  ($28,A3),A3
            move.b  (A3)+,($1E00,A2)
            move.b  (A3)+,($600,A2)
            move.b  (A3)+,(A2)
            move.b  (A3)+,($400,A2)
            move.b  (A3)+,($1800,A2)
            move.b  (A3)+,($1600,A2)
            move.b  #$7F,($1C00,A2)
.L1:
            btst    #$B,D0
            beq.b   .L2
            movea.l ($2C,A0),A2
            movea.l A1,A3
            adda.l  ($2C,A3),A3
            move.b  ($1E00,A2),D3
            or.b    (A3)+,D3
            move.b  D3,($1E00,A2)
            move.b  (A3)+,($600,A2)
            move.b  (A3)+,(A2)
            move.b  (A3)+,($400,A2)
            move.b  (A3)+,($1800,A2)
            move.b  (A3)+,($1600,A2)
            move.b  #$7F,($1C00,A2)
            move.b  #$6E,($800,A2)
            move.b  #$19,($A00,A2)
.L2:
            btst    #$D,D0
            beq.b   .L3
            movea.l ($34,A0),A2
            move.b  #$7F,($13,A2)
            move.b  #$8F,(A2)
            move.b  #$40,($10,A2)
            move.b  #$FF,($12,A2)
.L3:
            RTS6
GetHardwareInfo:
            bset    #beok,D7                        ; Allow bus errors
            movea.l SP,A5                           ; Mark the stack for bus error handler
            tst.b   D2
            beq.b   .L4
            lea     ProductLookup-4,A0
.MatchLoop:
            addq.w  #4,A0
            move.l  (A0),D0                         ; See if end of list reached
            beq.b   .L4
            lea     (0,A0,D0.l),A1
            cmp.w   ($12,A1),D2
            bne.b   .MatchLoop
.L2:
            nop
            nop
            movea.l (A1),A0
            adda.l  A1,A0
            move.l  ($18,A1),D0
            beq.b   CheckBases
.L3:
            move.l  ($10,A1),D2
            bra.w   CheckMoreBases.L19
            ds.b    6
.L4:
            move.l  A6,D0
            lea     DecoderLookup,A1
CheckNextMap:
            movea.l A1,A0
            adda.l  (A1)+,A0
            movea.l (-8,A0),A2
            jmp     (0,A0,A2.l)
MapFound:
            movea.l D0,A2
            move.l  (-$14,A0),D0
            BSR6    GetVIAInputs
            movea.l A2,A6
            move.b  (-4,A0),D2
            lea     ProductLookup,A0
.MatchLoop:
            move.l  (A0)+,D0
            beq.b   GetHardwareInfo.L4
            lea     (-4,A0,D0.l),A1
            cmp.b   ($13,A1),D2
            bne.b   .MatchLoop
            move.l  D1,D0
            and.l   ($20,A1),D0
            cmp.l   ($24,A1),D0
            bne.b   .MatchLoop
            bra.b   GetHardwareInfo.L2
CheckBases:
            move.l  (-$14,A0),D0
            movea.l A6,A0
            btst    #$D,D0
            beq.b   .RBVDone
            movea.l (A1),A2
            movea.l ($34,A1,A2.l),A2
            lea     ($13,A2),A2
            BSR6    TESTFORRVIER
            beq.b   .RBVDone
            bclr    #$D,D0
            bclr    #$E,D0
.RBVDone:
            bclr    #$B,D0
            beq.b   .VIA2Done
            movea.l (A1),A2
            movea.l ($2C,A1,A2.l),A2
            lea     ($1C00,A2),A2
            BSR6    TESTFORVIER
            bne.b   .VIA2Done
            bset    #$B,D0
.VIA2Done:
            bclr    #$10,D0
            beq.b   .SWIMIOPDone
            movea.l (A1),A2
            movea.l ($40,A1,A2.l),A2
            BSR6    TESTFORIOP
            bne.b   .SWIMIOPDone
            bclr    #5,D0
            bset    #$10,D0
.SWIMIOPDone:
            bclr    #$11,D0
            beq.b   .SCCIOPDone
            movea.l (A1),A2
            movea.l ($44,A1,A2.l),A2
            BSR6    TESTFORIOP
            bne.b   .SCCIOPDone
            bset    #$11,D0
            bclr    #3,D0
            bclr    #4,D0
.SCCIOPDone:
            bclr    #$F,D0
            beq.b   .L7
            movea.l (A1),A2
            movea.l ($3C,A1,A2.l),A2
            BSR6    TestForSCSIDMA
            bne.b   .L7
            bset    #$F,D0
            bclr    #8,D0
            bclr    #9,D0
            bclr    #$A,D0
.L7:
            bra.l   CheckMoreBases
.L8:
            adda.l  (A0),A0
            bra.w   GetHardwareInfo.L3
CheckFeatures:
            move.l  ($1C,A1),D1
            bne.b   .allDone
            move.l  (-$10,A0),D1
.allDone:
            bclr    #$1B,D7
            RTS6
CheckForGLUE:
            movea.l (8,A0),A2
            lea     ($1C00,A2),A2
            move.l  #$20000,D2
            BSR6    TESTVIERWRAP
            bne.w   CheckNextMap
            bra.w   MapFound
CheckForMDU:
            movea.l (8,A0),A2
            lea     ($1C00,A2),A2
            move.l  #$40000,D2
            BSR6    TESTVIERWRAP
            bne.w   CheckNextMap
            subi.l  #$20000,D2
            BSR6    TESTVIERWRAP
            beq.w   CheckNextMap
            lea     CheckNextMap,A6
            movea.l ($34,A0),A2
            tst.b   (A2)
            movea.l ($38,A0),A2
            tst.b   (A2)
            bra.w   MapFound
CheckForOSSFMC:
            movea.l (8,A0),A2
            lea     ($1C00,A2),A2
            move.l  #$40000,D2
            BSR6    TESTVIERWRAP
            bne.w   CheckNextMap
            subi.l  #$20000,D2
            BSR6    TESTVIERWRAP
            beq.w   CheckNextMap
            lea     CheckNextMap,A6
            movea.l ($48,A0),A2
            move.b  (A2),D1
            lsl.w   #8,D1
            moveq   #6,D2
.L11:
            move.b  D2,(A2)
            tst.l   GotBusError.L1
            move.b  (A2),D1
            nop
            andi.b  #7,D1
            cmp.b   D1,D2
            dbne    D2,.L11
            lsr.w   #8,D1
            move.b  D1,(A2)
            tst.w   D2
            bpl.w   CheckNextMap
            bra.w   MapFound
CheckForVISADecoder:
            movea.l (8,A0),A2
            lea     ($1C00,A2),A2
            BSR6    TESTFORVIER
            bne.w   CheckNextMap
            move.l  #$40000,D2
            BSR6    TESTVIERWRAP
            beq.w   CheckNextMap
            lea     CheckNextMap,A6
            movea.l ($34,A0),A2
            tst.b   (A2)
            movea.l ($38,A0),A2
            tst.b   (A2)
            bra.w   MapFound
CheckForOrwell:
            lea     CheckNextMap,A6
            movea.l ($54,A0),A2
            move.l  (A2),D2
            bra.w   MapFound
CheckForJAWS:
            movea.l (8,A0),A2
            lea     ($1C00,A2),A2
            move.l  #$100000,D2
            BSR6    TESTVIERWRAP
            bne.w   CheckNextMap
            lsr.l   #1,D2
            BSR6    TESTVIERWRAP
            beq.w   CheckNextMap
            lsr.l   #1,D2
            BSR6    TESTVIERWRAP
            beq.w   CheckNextMap
            lea     CheckNextMap,A6
            movea.l ($58,A0),A2
            tst.b   (A2)
            bra.w   MapFound
CheckForUnknown:
            bra.w   MapFound
            dc.w    0
DecoderLookup:
            dc.l    JAWStable-@
            dc.l    OrwellDecoderTable-@
            dc.l    GLUEtable-@
            dc.l    MDUtable-@
            dc.l    OSSFMCtable-@
            dc.l    VISADecoderTable-@
            dc.l    UnknownDecoderTable-@
ProductLookup:
            dc.l    InfoMacIIx-@
            dc.l    InfoSE30-@
            dc.l    InfoMacIIcx-@
            dc.l    InfoMacIIci-@
            dc.l    InfoMacIIciPGC-@
            dc.l    InfoMacIIfx-@
            dc.l    InfoMacIIsi-@
            dc.l    InfoMacLC-@
            dc.l    InfoQuadra700-@
            dc.l    InfoQuadra900-@
            dc.l    InfoPowerBook170-@
            dc.l    InfoGLUEUnknown-@
            dc.l    InfoMDUUnknown-@
            dc.l    InfoOSSUnknown-@
            dc.l    InfoVISAUnknown-@
            dc.l    InfoJAWSUnknown-@
            dc.l    InfoUnknownUnknown-@
            dc.l    0                               ; End of list
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $00000000                       ; DefaultBases
            dc.l    $00000000                       ; DefExtFeatures
            dc.b    $00,$00,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForUnknown-UnknownDecoderTable ; CheckForProc
            dc.b    0                               ; AddrMap (UnknownDecoder)
            ds.b    3
UnknownDecoderTable:
            dc.l    $00000000                       ; ROM
            dc.l    $00000000                       ; DiagROM
            dc.l    $00000000                       ; VIA1
            dc.l    $00000000                       ; SCC read
            dc.l    $00000000                       ; SCC write
            dc.l    $00000000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $00000000                       ; SCSI
            dc.l    $00000000                       ; SCSIDack
            dc.l    $00000000                       ; SCSIHsk
            dc.l    $00000000                       ; VIA2
            dc.l    $00000000                       ; ASC
            dc.l    $00000000                       ; RBV
            dc.l    $00000000                       ; VDAC
            dc.l    $00000000                       ; SCSIDMA
            dc.l    $00000000                       ; SWIMIOP
            dc.l    $00000000                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $00001F3F                       ; DefaultBases
            dc.l    $00000000                       ; DefExtFeatures
            dc.b    $10,$00,$C0,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForGLUE-GLUEtable          ; CheckForProc
            dc.b    4                               ; AddrMap (GLUEDecoder)
            ds.b    3
GLUEtable:
            dc.l    $40800000                       ; ROM
            dc.l    $58000000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $50F04000                       ; SCC read
            dc.l    $50F04000                       ; SCC write
            dc.l    $50F16000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $50F10000                       ; SCSI
            dc.l    $50F12000                       ; SCSIDack
            dc.l    $50F06000                       ; SCSIHsk
            dc.l    $50F02000                       ; VIA2
            dc.l    $50F14000                       ; ASC
            dc.l    $00000000                       ; RBV
            dc.l    $00000000                       ; VDAC
            dc.l    $00000000                       ; SCSIDMA
            dc.l    $00000000                       ; SWIMIOP
            dc.l    $00000000                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $0003FF3F                       ; DefaultBases
            dc.l    $00000000                       ; DefExtFeatures
            dc.b    $00,$00,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForMDU-MDUtable            ; CheckForProc
            dc.b    5                               ; AddrMap (MDUDecoder)
            ds.b    3
MDUtable:
            dc.l    $40800000                       ; ROM
            dc.l    $58000000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $50F04000                       ; SCC read
            dc.l    $50F04000                       ; SCC write
            dc.l    $50F16000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $50F10000                       ; SCSI
            dc.l    $50F12000                       ; SCSIDack
            dc.l    $50F06000                       ; SCSIHsk
            dc.l    $50F02000                       ; VIA2
            dc.l    $50F14000                       ; ASC
            dc.l    $50F26000                       ; RBV
            dc.l    $50F24000                       ; VDAC
            dc.l    $50F18000                       ; SCSIDMA
            dc.l    $50F1E020                       ; SWIMIOP
            dc.l    $50F0C020                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $001F9007                       ; DefaultBases
            dc.l    $00000004                       ; DefExtFeatures
            dc.b    $00,$00,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForOSSFMC-OSSFMCtable      ; CheckForProc
            dc.b    6                               ; AddrMap (OSSFMCDecoder)
            ds.b    3
OSSFMCtable:
            dc.l    $40800000                       ; ROM
            dc.l    $58000000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $00000000                       ; SCC read
            dc.l    $00000000                       ; SCC write
            dc.l    $00000000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $00000000                       ; SCSI
            dc.l    $00000000                       ; SCSIDack
            dc.l    $00000000                       ; SCSIHsk
            dc.l    $00000000                       ; VIA2
            dc.l    $50F10000                       ; ASC
            dc.l    $00000000                       ; RBV
            dc.l    $00000000                       ; VDAC
            dc.l    $50F08000                       ; SCSIDMA
            dc.l    $50F12020                       ; SWIMIOP
            dc.l    $50F04020                       ; SCCIOP
            dc.l    $50F1A000                       ; OSS
            dc.l    $50F1C000                       ; FMC
            dc.l    $50F1E000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $0000773F                       ; DefaultBases
            dc.l    $000000A6                       ; DefExtFeatures
            dc.b    $00,$00,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForVISADecoder-VISADecoderTable ; CheckForProc
            dc.b    7                               ; AddrMap (VISADecoder)
            ds.b    3
VISADecoderTable:
            dc.l    $00A00000                       ; ROM
            dc.l    $50F80000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $50F04000                       ; SCC read
            dc.l    $50F04000                       ; SCC write
            dc.l    $50F16000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $50F10000                       ; SCSI
            dc.l    $50F12000                       ; SCSIDack
            dc.l    $50F06000                       ; SCSIHsk
            dc.l    $00000000                       ; VIA2
            dc.l    $50F14000                       ; ASC
            dc.l    $50F26000                       ; RBV
            dc.l    $50F24000                       ; VDAC
            dc.l    $00000000                       ; SCSIDMA
            dc.l    $00000000                       ; SWIMIOP
            dc.l    $00000000                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $07A3181F                       ; DefaultBases
            dc.l    $00000000                       ; DefExtFeatures
            dc.b    $00,$C0,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForOrwell-OrwellDecoderTable ; CheckForProc
            dc.b    8                               ; AddrMap (OrwellDecoder)
            ds.b    3
OrwellDecoderTable:
            dc.l    $40800000                       ; ROM
            dc.l    $58000000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $50F0C020                       ; SCC read
            dc.l    $50F0C020                       ; SCC write
            dc.l    $50F1E000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $00000000                       ; SCSI
            dc.l    $00000000                       ; SCSIDack
            dc.l    $00000000                       ; SCSIHsk
            dc.l    $50F02000                       ; VIA2
            dc.l    $50F14000                       ; ASC
            dc.l    $00000000                       ; RBV
            dc.l    $F9800000                       ; VDAC
            dc.l    $00000000                       ; SCSIDMA
            dc.l    $50F1E020                       ; SWIMIOP
            dc.l    $50F0C020                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $5000E000                       ; Orwell
            dc.l    $00000000                       ; JAWS
            dc.l    $50F0A000                       ; Sonic
            dc.l    $50F0F000                       ; 1st SCSI96
            dc.l    $50F0F402                       ; 2nd SCSI96
            dc.l    $F9800000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
            ds.b    16                              ; Zero in every DecoderInfo
            dc.l    $00401F3F                       ; DefaultBases
            dc.l    $00010032                       ; DefExtFeatures
            dc.b    $00,$00,$00,$00                 ; AvoidVIA1A/1B/2A/2B
            dc.l    CheckForJAWS-JAWStable          ; CheckForProc
            dc.b    9                               ; AddrMap (JAWSDecoder)
            ds.b    3
JAWStable:
            dc.l    $40800000                       ; ROM
            dc.l    $58000000                       ; DiagROM
            dc.l    $50F00000                       ; VIA1
            dc.l    $50F04000                       ; SCC read
            dc.l    $50F04000                       ; SCC write
            dc.l    $50F16000                       ; IWM
            dc.l    $00000000                       ; PWM
            dc.l    $00000000                       ; Sound
            dc.l    $50F10000                       ; SCSI
            dc.l    $50F06000                       ; SCSIDack
            dc.l    $50F06000                       ; SCSIHsk
            dc.l    $50F02000                       ; VIA2
            dc.l    $50F14000                       ; ASC
            dc.l    $00000000                       ; RBV
            dc.l    $00000000                       ; VDAC
            dc.l    $00000000                       ; SCSIDMA
            dc.l    $00000000                       ; SWIMIOP
            dc.l    $00000000                       ; SCCIOP
            dc.l    $00000000                       ; OSS
            dc.l    $00000000                       ; FMC
            dc.l    $00000000                       ; RPU
            dc.l    $00000000                       ; Orwell
            dc.l    $50F80000                       ; JAWS
            dc.l    $00000000                       ; Sonic
            dc.l    $00000000                       ; 1st SCSI96
            dc.l    $00000000                       ; 2nd SCSI96
            dc.l    $00000000                       ; DAFB
            dc.l    $00000000                       ; unused 27
            dc.l    $00000000                       ; unused 28
            dc.l    $00000000                       ; unused 29
            dc.l    $00000000                       ; unused 30
            dc.l    $00000000                       ; unused 31
InfoMacIIx:
            dc.l    GLUEtable-InfoMacIIx            ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIx     ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoSixSlotNoVid-InfoMacIIx ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    1                               ; ProductKind (boxMacIIx)
            dc.b    4                               ; DecoderKind (GLUEDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00001F3F                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $40,$00,$00,$08                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacII-InfoMacIIx        ; VIA1InitPtr
            dc.l    VIA2InitMacII-InfoMacIIx        ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoSE30:
            dc.l    GLUEtable-InfoSE30              ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoSE30       ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoSE30-InfoSE30          ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    3                               ; ProductKind (boxSE30)
            dc.b    4                               ; DecoderKind (GLUEDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00001F3F                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $40,$00,$00,$08                 ; VIAIdMask
            dc.b    $40,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacII-InfoSE30          ; VIA1InitPtr
            dc.l    VIA2InitMacII-InfoSE30          ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacIIcx:
            dc.l    GLUEtable-InfoMacIIcx           ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIcx    ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoMacIIcx-InfoMacIIcx    ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    2                               ; ProductKind (boxMacIIcx)
            dc.b    4                               ; DecoderKind (GLUEDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00001F3F                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $40,$00,$00,$08                 ; VIAIdMask
            dc.b    $40,$00,$00,$08                 ; VIAIdMatch
            dc.l    VIA1InitMacII-InfoMacIIcx       ; VIA1InitPtr
            dc.l    VIA2InitMacII-InfoMacIIcx       ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacIIci:
            dc.l    MDUtable-InfoMacIIci            ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIci    ; RamInfoPtr
            dc.l    VideoInfoMDU-InfoMacIIci        ; VideoInfoPtr
            dc.l    NuBusInfoMacIIci-InfoMacIIci    ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    5                               ; ProductKind (boxMacIIci)
            dc.b    5                               ; DecoderKind (MDUDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $0000773F                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $46,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMDU-InfoMacIIci         ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacIIciPGC:
            dc.l    MDUtable-InfoMacIIciPGC         ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIciPGC ; RamInfoPtr
            dc.l    VideoInfoMDU-InfoMacIIciPGC     ; VideoInfoPtr
            dc.l    NuBusInfoMacIIci-InfoMacIIciPGC ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    5                               ; ProductKind (boxMacIIci)
            dc.b    5                               ; DecoderKind (MDUDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $0000773F                       ; BasesValid
            dc.l    $00000001                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $56,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMDU-InfoMacIIciPGC      ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacIIfx:
            dc.l    OSSFMCtable-InfoMacIIfx         ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIfx    ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoSixSlotNoVid-InfoMacIIfx ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    7                               ; ProductKind (boxMacIIfx)
            dc.b    6                               ; DecoderKind (OSSFMCDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000004                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $52,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitOSS-InfoMacIIfx         ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacIIsi:
            dc.l    MDUtable-InfoMacIIsi            ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMacIIsi    ; RamInfoPtr
            dc.l    VideoInfoMacIIsi-InfoMacIIsi    ; VideoInfoPtr
            dc.l    NuBusInfoMacIIsi-InfoMacIIsi    ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    12                              ; ProductKind (boxMacIIsi)
            dc.b    5                               ; DecoderKind (MDUDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    4                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $0000773F                       ; BasesValid
            dc.l    $00000126                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $16,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacIIsi-InfoMacIIsi     ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMacLC:
            dc.l    VISADecoderTable-InfoMacLC      ; DecoderInfoPtr
            dc.l    RamInfoVISA-InfoMacLC           ; RamInfoPtr
            dc.l    VideoInfoVISA-InfoMacLC         ; VideoInfoPtr
            dc.l    NuBusInfoVISA-InfoMacLC         ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    13                              ; ProductKind (boxMacLC)
            dc.b    7                               ; DecoderKind (VISADecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    4                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $0000773F                       ; BasesValid
            dc.l    $000001A6                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $54,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacIIsi-InfoMacLC       ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoQuadra900:
            dc.l    OrwellDecoderTable-InfoQuadra900 ; DecoderInfoPtr
            dc.l    RamInfoQuadra900-InfoQuadra900  ; RamInfoPtr
            dc.l    VideoInfoDAFB-InfoQuadra900     ; VideoInfoPtr
            dc.l    NuBusInfoQuadra900-InfoQuadra900 ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    14                              ; ProductKind (boxQuadra900)
            dc.b    8                               ; DecoderKind (OrwellDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $07A31807                       ; BasesValid
            dc.l    $00040924                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $50,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitQuadra900-InfoQuadra900 ; VIA1InitPtr
            dc.l    VIA2InitQuadra900-InfoQuadra900 ; VIA2InitPtr
            dc.l    SNDCNTLECLIPSE-InfoQuadra900    ; SndControlPtr
            ds.b    12                              ; Unused
            ; Not in ProductLookup; its offsets are relative to InfoQuadra900
InfoOrwellUnused:
            dc.l    OrwellDecoderTable-InfoQuadra900 ; DecoderInfoPtr
            dc.l    RamInfoQuadra900-InfoQuadra900  ; RamInfoPtr
            dc.l    VideoInfoDAFB-InfoQuadra900     ; VideoInfoPtr
            dc.l    NuBusInfoQuadra900-InfoQuadra900 ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    18                              ; ProductKind (box 18)
            dc.b    8                               ; DecoderKind (OrwellDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $07A31807                       ; BasesValid
            dc.l    $00040924                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $10,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitQuadra900-InfoQuadra900 ; VIA1InitPtr
            dc.l    VIA2InitQuadra900-InfoQuadra900 ; VIA2InitPtr
            dc.l    SNDCNTLECLIPSE-InfoQuadra900    ; SndControlPtr
            ds.b    12                              ; Unused
InfoQuadra700:
            dc.l    OrwellDecoderTable-InfoQuadra700 ; DecoderInfoPtr
            dc.l    RAMInfo2Bank4Meg-InfoQuadra700  ; RamInfoPtr
            dc.l    VideoInfoDAFB-InfoQuadra700     ; VideoInfoPtr
            dc.l    NuBusInfoQuadra700-InfoQuadra700 ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    16                              ; ProductKind (boxQuadra700)
            dc.b    8                               ; DecoderKind (OrwellDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $05A0183F                       ; BasesValid
            dc.l    $00000900                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $40,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitQuadra700-InfoQuadra700 ; VIA1InitPtr
            dc.l    VIA2InitQuadra700-InfoQuadra700 ; VIA2InitPtr
            dc.l    SNDCNTLSPIKE-InfoQuadra700      ; SndControlPtr
            ds.b    12                              ; Unused
InfoPowerBook170:
            dc.l    JAWStable-InfoPowerBook170      ; DecoderInfoPtr
            dc.l    RAMInfoJaws-InfoPowerBook170    ; RamInfoPtr
            dc.l    VideoInfoJaws-InfoPowerBook170  ; VideoInfoPtr
            dc.l    NuBusInfoJaws-InfoPowerBook170  ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB)|(1<<hwCbPwrMgr) ; HwCfgWord
            dc.b    15                              ; ProductKind (boxPowerBook170)
            dc.b    9                               ; DecoderKind (JAWSDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    4                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00401F3F                       ; BasesValid
            dc.l    $00010932                       ; ExtValid
            dc.b    $56,$00,$00,$00                 ; VIAIdMask
            dc.b    $12,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitJaws-InfoPowerBook170   ; VIA1InitPtr
            dc.l    VIA2InitJaws-InfoPowerBook170   ; VIA2InitPtr
            dc.l    SNDCNTLTIM-InfoPowerBook170     ; SndControlPtr
            ds.b    12                              ; Unused
InfoGLUEUnknown:
            dc.l    GLUEtable-InfoGLUEUnknown       ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoGLUEUnknown ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoSixSlotNoVid-InfoGLUEUnknown ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    4                               ; DecoderKind (GLUEDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacII-InfoGLUEUnknown   ; VIA1InitPtr
            dc.l    VIA2InitMacII-InfoGLUEUnknown   ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoMDUUnknown:
            dc.l    MDUtable-InfoMDUUnknown         ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoMDUUnknown ; RamInfoPtr
            dc.l    VideoInfoMDU-InfoMDUUnknown     ; VideoInfoPtr
            dc.l    NuBusInfoSixSlotNoVid-InfoMDUUnknown ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    5                               ; DecoderKind (MDUDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMDU-InfoMDUUnknown      ; VIA1InitPtr
            dc.l    VIA2InitMDUUnknown-InfoMDUUnknown ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoOSSUnknown:
            dc.l    OSSFMCtable-InfoOSSUnknown      ; DecoderInfoPtr
            dc.l    RAMInfo2Bank1Meg-InfoOSSUnknown ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    NuBusInfoSixSlotNoVid-InfoOSSUnknown ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    6                               ; DecoderKind (OSSFMCDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitOSS-InfoOSSUnknown      ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoVISAUnknown:
            dc.l    VISADecoderTable-InfoVISAUnknown ; DecoderInfoPtr
            dc.l    RamInfoVISA-InfoVISAUnknown     ; RamInfoPtr
            dc.l    VideoInfoVISA-InfoVISAUnknown   ; VideoInfoPtr
            dc.l    NuBusInfoVISA-InfoVISAUnknown   ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbMMU)|(1<<hwCbADB) ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    7                               ; DecoderKind (VISADecoder)
            dc.w    $7FFF                           ; Rom85Word
            dc.b    4                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitMacIIsi-InfoVISAUnknown ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoJAWSUnknown:
            dc.l    JAWStable-InfoJAWSUnknown       ; DecoderInfoPtr
            dc.l    RAMInfoJaws-InfoJAWSUnknown     ; RamInfoPtr
            dc.l    VideoInfoJaws-InfoJAWSUnknown   ; VideoInfoPtr
            dc.l    NuBusInfoJaws-InfoJAWSUnknown   ; NuBusInfoPtr
            dc.w    (1<<hwCbSCSI)|(1<<hwCbClock)|(1<<hwCbFPU)|(1<<hwCbMMU)|(1<<hwCbADB)|(1<<hwCbPwrMgr) ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    9                               ; DecoderKind (JAWSDecoder)
            dc.w    $3FFF                           ; Rom85Word
            dc.b    2                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00010032                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    VIA1InitJaws-InfoJAWSUnknown    ; VIA1InitPtr
            dc.l    VIA2InitJaws-InfoJAWSUnknown    ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
InfoUnknownUnknown:
            dc.l    UnknownDecoderTable-InfoUnknownUnknown ; DecoderInfoPtr
            dc.l    0                               ; RamInfoPtr
            dc.l    0                               ; VideoInfoPtr
            dc.l    0                               ; NuBusInfoPtr
            dc.w    0                               ; HwCfgWord
            dc.b    253                             ; ProductKind (boxUnknown)
            dc.b    0                               ; DecoderKind (UnknownDecoder)
            dc.w    $FFFF                           ; Rom85Word
            dc.b    1                               ; DefaultRSRCs
            dc.b    0                               ; ProductInfoVers
            dc.l    $00000000                       ; BasesValid
            dc.l    $00000000                       ; ExtValid
            dc.b    $00,$00,$00,$00                 ; VIAIdMask
            dc.b    $00,$00,$00,$00                 ; VIAIdMatch
            dc.l    0                               ; VIA1InitPtr
            dc.l    0                               ; VIA2InitPtr
            dc.l    0                               ; SndControlPtr
            ds.b    12                              ; Unused
            ; VIA init values: vBufA, vDIRA, vBufB, vDIRB, vPCR, vACR
VIA1InitMacII:
            dc.b    $01,$3F,$37,$B7,$00,$00
VIA1InitMDU:
            dc.b    $21,$2F,$F7,$F7,$00,$00
VIA1InitMacLC:
VIA1InitMacIIsi:
            dc.b    $26,$2F,$48,$30,$00,$1C
VIA1InitOSS:
            dc.b    $01,$07,$87,$87,$00,$00
            dc.b    $01,$07,$87,$87,$00,$00         ; Not referenced
VIA1InitQuadra900:
            dc.b    $00,$00,$C9,$F1,$22,$1C
VIA1InitQuadra700:
            dc.b    $20,$28,$F7,$F7,$22,$00
VIA1InitJaws:
            dc.b    $21,$28,$87,$87,$22,$00
            dc.b    $00,$C0,$0F,$88,$60,$C0         ; Not referenced
VIA2InitMacII:
            dc.b    $00,$C0,$07,$80,$60,$C0
VIA2InitMDUUnknown:
            dc.b    $00,$C0,$0F,$89,$00,$C0
VIA2InitQuadra900:
            dc.b    $80,$80,$03,$C8,$22,$C0
VIA2InitQuadra700:
            dc.b    $80,$80,$06,$99,$22,$C0
VIA2InitJaws:
            dc.b    $00,$00,$E6,$BD,$22,$00
RAMInfo2Bank1Meg:
            dc.l    $00100000                       ; Smallest bank
            dc.l    $00000000,$04000000             ; Bank start, end
            dc.l    $04000000,$08000000             ; Bank start, end
            dc.l    $FFFFFFFF                       ; End of table
RamInfoVISA:
            dc.l    $00100000                       ; Smallest bank
            dc.l    $00000000,$00800000             ; Bank start, end
            dc.l    $00800000,$00A00000             ; Bank start, end
            dc.l    $FFFFFFFF                       ; End of table
RamInfoQuadra900:
            dc.l    $00400000                       ; Smallest bank
            dc.l    $00000000,$04000000             ; Bank start, end
            dc.l    $04000000,$08000000             ; Bank start, end
            dc.l    $08000000,$0C000000             ; Bank start, end
            dc.l    $0C000000,$10000000             ; Bank start, end
            dc.l    $FFFFFFFF                       ; End of table
RAMInfo2Bank4Meg:
            dc.l    $00400000                       ; Smallest bank
            dc.l    $00000000,$04000000             ; Bank start, end
            dc.l    $04000000,$08000000             ; Bank start, end
            dc.l    $FFFFFFFF                       ; End of table
RAMInfoJaws:
            dc.l    $00080000                       ; Smallest bank
            dc.l    $00000000,$00200000             ; Bank start, end
            dc.l    $00200000,$00400000             ; Bank start, end
            dc.l    $00400000,$00600000             ; Bank start, end
            dc.l    $00600000,$00800000             ; Bank start, end
            dc.l    $FFFFFFFF                       ; End of table
VideoInfoMDU:
            dc.l    $00000000                       ; VRAMPhysAddr
            dc.l    $FBB08000                       ; VRAMLogAddr32
            dc.l    $FBB08000                       ; VRAMLogAddr24
            dc.b    $0B                             ; SlotNumberAlias
            dc.b    $56                             ; SlotPramAddr
            dc.w    $0000
VideoInfoMacIIsi:
            dc.l    $00000000                       ; VRAMPhysAddr
            dc.l    $FEE08000                       ; VRAMLogAddr32
            dc.l    $FEE08000                       ; VRAMLogAddr24
            dc.b    $0E                             ; SlotNumberAlias
            dc.b    $6E                             ; SlotPramAddr
            dc.w    $0000
VideoInfoVISA:
            dc.l    $50F40000                       ; VRAMPhysAddr
            dc.l    $50F40000                       ; VRAMLogAddr32
            dc.l    $50F40000                       ; VRAMLogAddr24
            dc.b    $0B                             ; SlotNumberAlias
            dc.b    $56                             ; SlotPramAddr
            dc.w    $0000
            ; VideoInfo not referenced by any ProductInfo
            dc.l    $009F5000                       ; VRAMPhysAddr
            dc.l    $009F5000                       ; VRAMLogAddr32
            dc.l    $009F5000                       ; VRAMLogAddr24
            dc.b    $0B                             ; SlotNumberAlias
            dc.b    $56                             ; SlotPramAddr
            dc.w    $0000
VideoInfoJaws:
            dc.l    $FEE08000                       ; VRAMPhysAddr
            dc.l    $FEE08000                       ; VRAMLogAddr32
            dc.l    $FEE08000                       ; VRAMLogAddr24
            dc.b    $0B                             ; SlotNumberAlias
            dc.b    $56                             ; SlotPramAddr
            dc.w    $0000
VideoInfoDAFB:
            dc.l    $F9001000                       ; VRAMPhysAddr
            dc.l    $F9001000                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
            dc.l    $F9000E00                       ; VRAMPhysAddr
            dc.l    $F9000E00                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
            dc.l    $F9001020                       ; VRAMPhysAddr
            dc.l    $F9001020                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
            dc.l    $F9001400                       ; VRAMPhysAddr
            dc.l    $F9001400                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
            dc.l    $F9000E20                       ; VRAMPhysAddr
            dc.l    $F9000E20                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
            dc.l    $F9001420                       ; VRAMPhysAddr
            dc.l    $F9001420                       ; VRAMLogAddr32
            dc.l    $00000000                       ; VRAMLogAddr24
            dc.b    $09                             ; SlotNumberAlias
            dc.b    $46                             ; SlotPramAddr
            dc.w    $0000
NuBusInfoSixSlotNoVid:
            dc.b    $00,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$07,$07,$07,$07,$07,$07,$00
NuBusInfoSE30:
            dc.b    $00,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$13,$13,$13,$01,$01,$03,$00
NuBusInfoMacIIcx:
            dc.b    $00,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$07,$07,$07,$01,$01,$01,$00
NuBusInfoMacIIci:
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$01,$01,$08,$07,$07,$07,$00
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F, not referenced
            dc.b    $00,$01,$01,$08,$13,$13,$13,$00
NuBusInfoMacIIsi:
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$13,$13,$13,$01,$01,$08,$00
NuBusInfoVISA:
            dc.b    $03,$08,$08,$08,$08,$08,$08,$08 ; Slots 0-F
            dc.b    $08,$09,$09,$08,$09,$09,$13,$00
NuBusInfoQuadra900:
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$0A,$07,$07,$07,$07,$07,$00
NuBusInfoQuadra700:
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$0A,$08,$08,$08,$07,$07,$00
NuBusInfoJaws:
            dc.b    $03,$00,$00,$00,$00,$00,$00,$00 ; Slots 0-F
            dc.b    $00,$08,$08,$08,$08,$08,$08,$00
CheckMoreBases:
            bclr    #$18,D0
            beq.b   .L16
            movea.l (A1),A2
            movea.l ($60,A1,A2.l),A2
            BSR6    TESTFORSCSI96
            bne.b   .L16
            bset    #$18,D0
            bclr    #$F,D0
            bclr    #8,D0
            bclr    #9,D0
            bclr    #$A,D0
            bclr    #$19,D0
            beq.b   .L16
            movea.l (A1),A2
            movea.l ($64,A1,A2.l),A2
            BSR6    TESTFORSCSI96
            bne.b   .L16
            bset    #$19,D0
.L16:
            bclr    #$14,D0
            beq.b   .L17
            movea.l (A1),A2
            movea.l ($50,A1,A2.l),A2
            BSR6    TESTFORRPU
            bne.b   .L17
            bset    #$14,D0
.L17:
            movea.l A0,A6
            movea.l A1,A0
            bra.w   CheckBases.L8
.L18:
            move.l  (A0),D3
            sub.l   A2,D3
            adda.l  D3,A0
            adda.l  D3,A1
            jmp     Universal.L4
.L19:
            btst    #$1C,D2
            beq.w   CheckFeatures
            movea.l A6,A2
            BSR6    TestForFPU
            beq.b   .L20
            bclr    #$1C,D2
.L20:
            movea.l A2,A6
            bra.w   CheckFeatures
            ds.b    5
            dc.b    $A0,$3D,$EC,$40,$00,$3D,$EC
            dc.l    GotBusError
            dc.w    0,$3DEC
GotBusError:
            btst    #$1B,D7
            movea.l A5,SP
            RTS6
.L1:
            dc.w    $FFFF,$FFFF
            dc.b    'GaryGary'

            EVEN
