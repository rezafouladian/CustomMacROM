            include "Include/ROMHeader.s"

            EXPORT  BOOTBLOCKFLUSHPATCH,DisableMMUPatch,DrawBeepScreenPatch,EnableCachesPatch,EnableExtCache,ENDGETSLOTDRVR
            EXPORT  GetHardwareInfo,HWPRIV,InitHWRoutines,INITIOPMGR,INITMEMDISPANDSHUTDOWNMGRS,InitMemMgrPatch
            EXPORT  InitMMUGlobals,InitMMUTrap,InitSDTbl,INITSNDNORAM,InitVIAs,INSTALLSONYDRIVERPATCH
            EXPORT  IOPINTERRUPT,IOPMGR,IOPMOVEDATA,IOPMsgRequest,JumpIntoROM,MEMORYDISPATCH
            EXPORT  MMUCleanupFor8Mb,ORIGGETSLOTDRVR,OSSSLOTINT,POWERDWNPTCH,RBVSLOTINT,SCCIOPByPass
            EXPORT  SCCIOPHwInit,SetupMiscSCSI,SIntInstall,SIntRemove,SlotInt,SlotIntCommon
            EXPORT  SlotManager,StartSDeclMgr,SysErrInitPatch,WhichCPUPatch

            IMPORT  ALLOCSLOTOVERPATCH1,ALLOCSLOTOVERPATCH2,BaseOfROM,BOOTBLOCKFLUSHRETURN,CacheFlush,DequeueTrap
            IMPORT  DrawBeepScreen,DrawBeepScreenReturn,FLUSHDCACHEPATCH,FLUSHICACHEPATCH,GETREALPROC,HWPrivPatch
            IMPORT  InitIWM,INITJMPTBLPATCH,InitMemMgr,InitMemoryDispatch,InitSCC,InitSCSI
            IMPORT  InitShutdownMgr,InstallFPSP,INSTALLPRIVTRAP,NEWLOCKMEMORY,NEWLOCKMEMORYCONTIGUOUS,NEWUNLOCKMEMORY
            IMPORT  Overpatch,QStuff,RdXByte,SCCIOPBYPASSINT,SLOTBUSEXCPTNPTCH,SLOTGETDRIVERPATCH
            IMPORT  SLOTMGRPATCH,SLOTPRIMARYINITPATCH,SNDCNTLECLIPSE,SNDCNTLSPIKE,SNDCNTLTIM,STATLOADPATCH
            IMPORT  SWAPDCACHEPATCH,SysErrInit,UNWRITEPROTECTPROC,WRITEPROTECTPROC

            SECTION "Part2",CODE

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
MMUSTUFF:
; InitMMUTrap
InitMMUTrap:
            movea.l JSwapMMU,A0
            move.w  #$A05D,D0
            _SetOSTrapAddress
            rts
InitMMUGlobals:
            movea.l BootGlobPtr,A1
            clr.b   MMUFlags
            move.b  #true32b,MMU32bit
            lea     (-$42,A1),A0
            move.l  A0,MMU32Info
            lea     (-$2E,A1),A0
            move.l  A0,MMU24Info
            moveq   #0,D0
            move.b  (-$1A,A1),D0
            move.b  D0,MMUType
            btst    #0,(-$19,A1)
            beq.b   .findSwap
            lea     Swap32Only,A0
            bra.b   .gotSwap
.findSwap:
            move.w  .swaps(PC,D0.w*2),D0
            lea     .swaps(PC,D0.w),A0
.gotSwap:
            move.l  A0,JSwapMMU
.NoSwap:
            rts
.swaps:
            dc.w    .NoSwap-.swaps
            dc.w    SwapHMMU-.swaps
            dc.w    .NoSwap-.swaps
            dc.w    Swap851-.swaps
            dc.w    Swap030-.swaps
            dc.w    Swap040-.swaps
            dc.w    .NoSwap-.swaps
            dc.w    .NoSwap-.swaps
MMUCleanupFor8Mb:
            movea.l BufPtr,A0
            suba.w  #$28,A0
            move.l  A0,BufPtr
            lea     MMU32Info,A1
            bsr.b   .doCopy
            lea     MMU24Info,A1
.doCopy:
            movea.l (A1),A2
            move.l  A0,(A1)
            moveq   #$13,D0
.copy:
            move.b  (A2)+,(A0)+
            dbra    D0,.copy
            rts
Swap32Only:
            moveq   #1,D0
            rts
Swap851:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            move    SR,-(SP)
            ori     #$700,SR
            movea.l MMU24Info,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            move    SR,-(SP)
            ori     #$700,SR
            movea.l MMU32Info,A0
.swap:
            pmove.l (theCRP,A0),TC
            pmove.d (theCRP,A0),CRP
            pmove.l (theTC,A0),TC
            pflusha
            move.b  D1,MMU32bit
            movec   CACR,D1
            ori.w   #8,D1
            movec   D1,CACR
            move    (SP)+,SR
.endif:
            rts
Swap030:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            movea.l MMUTbl,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            movea.l MMUTblSize,A0
.swap:
            move    SR,-(SP)
            ori     #$700,SR
            ploadr  #5,(8,A0)
            pmove.l ($C,A0),TT0
            pmove.l ($10,A0),TT1
            pmovefd.d (A0),CRP
            pmove.l (8,A0),TC
            move.b  D1,MMU32bit
            movec   CACR,D1
            ori.w   #$808,D1
            movec   D1,CACR
            pflusha
            move    (SP)+,SR
.endif:
            rts
Swap040:
            move.b  D0,D1
            bne.b   .to32
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .endif
            movea.l MMUTbl,A0
            bra.b   .swap
.to32:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .endif
            movea.l MMUTblSize,A0
.swap:
            move    SR,-(SP)
            ori     #$700,SR
            move.b  D1,MMU32bit
            move.l  ($C,A0),D1
            mc68040
            movec   D1,ITT0
            movec   D1,DTT0
            mc68030
            move.l  ($10,A0),D1
            mc68040
            movec   D1,ITT1
            movec   D1,DTT1
            mc68030
            move.l  (8,A0),D1
            movea.l (4,A0),A0
            mc68040
            movec   A0,SRP
            movec   D1,TC
            pflusha
            mc68030
            move    (SP)+,SR
.endif:
            rts
SwapHMMU:
            move.b  D0,D1
            bne.b   .L1
            moveq   #0,D0
            move.b  MMU32bit,D0
            beq.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA2,A0
            bclr    #3,(A0)
            bra.b   .common
.L1:
            moveq   #0,D0
            move.b  MMU32bit,D0
            bne.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA2,A0
            bset    #3,(A0)
.common:
            move.b  D1,MMU32bit
            movec   CACR,D1
            bset    #3,D1
            movec   D1,CACR
            movea.l ASCBase,A0
            lea     (ascFifoInt,A0),A0
            move.b  (A0),D1
            beq.b   .L2
            or.b    D1,(A0)
.L2:
            move    (SP)+,SR
.L3:
            rts
            ds.b    38
WhichCPUPatch:
            sub.l   D7,D7
            bset    #CACR_DE_040,D7
            movec   D7,CACR
            movec   CACR,D7
            bclr    #CACR_DE_040,D7
            movec   D7,CACR
            beq.b   .notAn040
            mc68040
            cinva   BC
            mc68030
            moveq   #cpu68040,D7
            rts
.notAn040:
            ; Set EI (enable inst. cache), CI (flush inst cache),
            ; CD (flush data cache) and WA in the 020/030 CACR
            move.w  #(1<<CACR_EI_020_030|1<<CACR_CI_020_030|1<<CACR_CD_030|1<<CACR_WA_030),D7
            movec   D7,CACR
            movec   CACR,D7
            lsl.w   #3,D7
            moveq   #2>>1,D7
            addx.l  D7,D7
            rts
EnableCachesPatch:
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            move.l  #$80008000,D0
            movec   D0,CACR
            bra.b   .L2
.L1:
            move.l  #$3919,D0
            movec   D0,CACR
.L2:
            rts
DisableMMUPatch:
            sub.l   D0,D0
            bset    #CACR_DE_040,D0                 ; Set Data Cache Enable bit on 040s
            movec   D0,CACR
            movec   CACR,D0
            btst    #CACR_DE_040,D0                 ; See if bit exists in CACR
            beq.b   .not040
            mc68040
            cinva   BC                              ; Make sure caches are invalidated
            sub.l   D0,D0                           ; Clear D0
            movec   D0,CACR
            movec   D0,TC
            move.l  #nuBusTTxlat,D0
            movec   D0,DTT0
            move.l  #ioNuBusTTxlat,D0
            movec   D0,DTT1
            bra.b   .not030
            mc68030
.not040:
            move.l  #(1<<CACR_WA_030),D0
            movec   D0,CACR
            movec   CACR,D0
            tst.l   D0
            beq.b   .not030
            lea     .TCOff,A0
            pmove.l (A0),TC
.not030:
            RTS6
.TCOff:
            ds.l    1
SwitchMMUPatch:
            movec   CACR,D1
            sub.l   D0,D0
            bset    #$1F,D0
            movec   D0,CACR
            movec   CACR,D0
            bclr    #$1F,D0
            beq.b   .L1
            movec   D0,CACR
            mc68040
            movec   D0,TC
            pflusha
            mc68030
            movea.l (A0),A2
            move.l  (8,A0),D0
            mc68040
            movec   D0,TC
            cpusha  BC
            mc68030
            bra.b   .L2
.L1:
            movec   CACR,D0
            move.w  D0,D1
            andi.w  #$FEFE,D0
            movec   D0,CACR
            lea     DisableMMUPatch.TCOff,A2
            pmove.l (A2),TC
            pflusha
            pmove.d (A0),CRP
            pmove.l (8,A0),TC
            ori.w   #$808,D1
.L2:
            movec   D1,CACR
            jmp     (A1)
SetupMiscSCSI:
            btst    #$18,D0
            beq.b   .L1
            move.w  #$18,D3
            lsl.w   #2,D3
            move.l  (0,A0,D3.w),SCSIBase
.L1:
            btst    #$19,D0
            beq.b   .L2
            move.w  #$19,D3
            lsl.w   #2,D3
            move.l  (0,A0,D3.w),SCSI2Base
            bra.b   .L4
.L2:
            btst    #9,D0
            bne.b   .L3
            move.l  SCSIHsk,SCSIDMA
.L3:
            btst    #$A,D0
            bne.b   .L4
            move.l  SCSIDMA,SCSIHsk
.L4:
            rts
SETUPSCSITIME:
            movea.l SCSIBase,A0
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L2
            move.b  D1,($1000,A1)
            move.b  D2,($1200,A1)
.L1:
            btst    #0,($40,A0)
            dbra    D0,.L1
            jmp     (A2)
.L2:
            move.b  D1,($1000,A1)
            move.b  D2,($1200,A1)
.L3:
            btst    #0,($40,A0)
            dbra    D0,.L3
            jmp     (A2)
SysErrInitPatch:
            BSR6    SysErrInit
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            bsr.l   InstallFPSP
.L1:
            rts
InitMemMgrPatch:
            bsr.w   InitMemMgr
            bsr.l   INSTALLPRIVTRAP
            rts
INITMEMDISPANDSHUTDOWNMGRS:
            bsr.l   InitMemoryDispatch
            bsr.l   InitShutdownMgr
            rts
DrawBeepScreenPatch:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            pea     (-$18,A2)
            _FillRect
            _PenNormal
            rts
.L1:
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            bra.l   DrawBeepScreenReturn
BOOTBLOCKFLUSHPATCH:
            _Read
            bne.b   .L1
            bsr.l   CacheFlush
            cmpi.w  #$4C4B,(A6)
.L1:
            bra.l   BOOTBLOCKFLUSHRETURN
INSTALLSONYDRIVERPATCH:
            btst    #IWMExists,(AddrMapFlags+3).w   ; TestFor IWMExists
            bne.b   .L1
            btst    #SWIMIOPExists-16,(AddrMapFlags+1).w ; TestFor SWIMIOPExists
            beq.b   .L2
.L1:
            move.l  A1,($12,A0)
            _Open
.L2:
            rts
POWERDWNPTCH:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            subq.w  #4,SP
            move.b  #$5B,(SP)
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.w  #1,-(SP)
            move.w  #$10,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($10,SP),SP
            movea.l PmgrBase,A0
            bclr    #2,($54,A0)
.L1:
            bsr.w   DrawBeepScreen
            rts
InitHWRoutines:
            bsr.l   InitSCC
            move.w  D2,-(SP)
            bsr.l   InitIWM
            move.w  (SP)+,D2
            bsr.l   InitSCSI
            bsr.b   INITSNDHW
            rts
INITSNDHW:
            movem.l D3-D4/A0-A6,-(SP)
            movea.l UnivInfoPtr,A0
            adda.l  (A0),A0
            move.b  SdVolume,D0
            BSR6    INITSNDNORAM.L4
            movem.l (SP)+,D3-D4/A0-A6
            rts
INITSNDNORAM:
            move.l  A5,D3
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l (8,A0),A2
            move.w  #$10,D1
            BigBSR6 RdXByte,A0
            cmpi.b  #$A8,D1
            beq.b   .L1
            moveq   #5,D1
            bra.b   .L2
.L1:
            move.w  #8,D1
            BigBSR6 RdXByte,A0
.L2:
            andi.b  #7,D1
            bne.b   .L3
            move.b  #5,D1
.L3:
            move.b  D1,D4
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            move.b  D4,D0
            BSR6    .L4
            movea.l D3,A5
            RTS5
.L4:
            movea.l ($30,A0),A3
            move.b  D0,D1
            asl.b   #5,D1
            move.b  D1,($806,A3)
            move.b  ($800,A3),D1
            andi.b  #$F0,D1
            cmpi.b  #$B0,D1
            bne.w   .L6
            move.w  #$7F00,($F06,A3)
            move.w  #$7F,($F26,A3)
            cmpi.b  #9,(-4,A0)
            bne.b   .L5
            mulu.w  #$12,D0
            move.b  D0,($F06,A3)
            clr.b   ($F07,A3)
            clr.b   ($F26,A3)
            move.b  D0,($F27,A3)
.L5:
            move.b  #1,($F09,A3)
            move.b  #1,($F29,A3)
            ori.b   #$80,($803,A3)
            andi.b  #$7F,($803,A3)
            move.b  #2,($80A,A3)
            move.b  #1,($801,A3)
            clr.b   ($F08,A3)
            clr.b   ($F28,A3)
            move.w  #$812F,($F04,A3)
            move.w  #$812F,($F24,A3)
            clr.w   ($F10,A3)
            move.w  #$3C,($F12,A3)
            move.w  #$CC73,($F14,A3)
            move.w  #$C962,($F16,A3)
            clr.w   ($F30,A3)
            move.w  #$3C,($F32,A3)
            move.w  #$CC73,($F34,A3)
            move.w  #$C962,($F36,A3)
            move.b  #$80,($F08,A3)
            move.b  #$80,($F28,A3)
.L6:
            RTS6
            ds.b    694
UNIVERSALPATCH:
TestForFPU:
            movec   CACR,D1
            bset    #$1F,D1
            movec   D1,CACR
            movec   CACR,D1
            bclr    #$1F,D1
            beq.b   .L1
            movec   D1,CACR
            bra.b   .L2
.L1:
            move.b  #7,D1
            movec   D1,SFC
            moves.w ($22000).l,D1
.L2:
            cmp.b   D1,D1
            RTS6
TESTFORRPU:
            tst.b   (A2)
            tst.b   (A2)
            tst.b   (A2)
            tst.b   (A2)
            st      ($10,A2)
            move.b  (A2),D2
            st      ($10,A2)
            st      (A2)
            clr.b   ($10,A2)
            moveq   #1,D1
            and.b   (A2),D1
            seq     D1
            beq.b   .L1
            st      ($10,A2)
            clr.b   (A2)
            st      ($10,A2)
            moveq   #1,D1
            and.b   (A2),D1
.L1:
            st      ($10,A2)
            move.b  D2,(A2)
            tst.b   D1
            RTS6
TESTFORVIER:
            moveq   #0,D2
TESTVIERWRAP:
            tst.b   (0,A2,D2.l)
            move.b  (A2),D1
            rol.w   #8,D1
            st      D1
            move.b  D1,(A2)
.L1:
            neg.b   D1
            move.b  D1,(A2)
            add.b   D1,D1
            beq.b   .L2
            neg.b   D1
            cmp.b   (0,A2,D2.l),D1
            bne.b   .L2
            cmp.b   (A2),D1
            beq.b   .L1
.L2:
            ror.w   #8,D1
            move.b  #$7F,(A2)
            move.b  D1,(A2)
            lsr.w   #8,D1
            RTS6
TESTFORRVIER:
            move.b  (A2),D1
            rol.w   #8,D1
            st      D1
            move.b  D1,(A2)
.L1:
            neg.b   D1
            move.b  D1,(A2)
            add.b   D1,D1
            beq.b   .L2
            neg.b   D1
            move.b  (A2),D2
            eor.b   D1,D2
            andi.b  #$9F,D2
            beq.b   .L1
.L2:
            ror.w   #8,D1
            move.b  #$7F,(A2)
            move.b  D1,(A2)
            lsr.w   #8,D1
            RTS6
TestForSCSIDMA:
            tst.l   ($80,A2)
            cmp.b   D1,D1
            RTS6
TESTFORSCSI96:
            tst.b   ($C0,A2)
            cmpi.b  #4,($C0,A2)
            RTS6
TestForSCC:
            tst.b   (0,A2,D2.l)
            ror.b   #8,D1
            move.b  #$D,(A2)
            ror.b   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$C,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$D,(A2)
            ror.b   #8,D1
            move.b  #$47,(A2)
            ror.b   #8,D1
            move.b  #$C,(A2)
            ror.b   #8,D1
            move.b  #$44,(A2)
            ror.b   #8,D1
            move.b  #$D,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$C,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            subi.w  #$4744,D1
            ror.l   #8,D1
            move.b  #$C,(A2)
            ror.l   #8,D1
            move.b  D1,(A2)
            ror.b   #8,D1
            move.b  #$D,(A2)
            lsr.l   #8,D1
            move.b  D1,(A2)
            lsr.l   #8,D1
            RTS6
TESTFORIOP:
            move.b  (-$1C,A2),D1
            moveq   #6,D2
            and.b   D1,D2
            swap    D1
            move.w  (-$1F,A2),D1
            ori.b   #2,D2
            move.b  D2,(-$1C,A2)
            tst.l   (-$18,A2)
            move.w  (-$1F,A2),D2
            move.w  D1,(-$1F,A2)
            subq.w  #4,D2
            sub.w   D1,D2
            swap    D1
            andi.b  #$CF,D1
            move.b  D1,(-$1C,A2)
            tst.w   D2
            RTS6
GetVIAInputs:
            moveq   #0,D1                           ; Initialize via info result
            btst    #2,D0                           ; See if VIA1 exists
            beq.b   .noVIA1                         ; If not, skip it
            movea.l (8,A0),A1
            move.b  ($1E00,A1),D2
            lsl.w   #8,D2                           ; Make room for direction bits
            move.b  ($600,A1),D2
            move.b  D2,D1
            and.b   (-$C,A0),D1
            move.b  D1,($600,A1)
            move.b  ($1E00,A1),D1
            move.b  D2,($600,A1)
            lsr.w   #8,D2
            move.b  D2,($1E00,A1)
            lsl.w   #8,D1
            move.b  (A1),D2
            lsl.w   #8,D2
            move.b  ($400,A1),D2
            move.b  D2,D1
            and.b   (-$B,A0),D1
            move.b  D1,($400,A1)
            move.b  (A1),D1
            move.b  D2,($400,A1)
            lsr.w   #8,D2
            move.b  D2,(A1)
.noVIA1:
            swap    D1
            btst    #$B,D0
            beq.b   .noVIA2
            movea.l ($2C,A0),A1
            move.b  ($1E00,A1),D2
            lsl.w   #8,D2
            move.b  ($600,A1),D2
            move.b  D2,D1
            and.b   (-$A,A0),D1
            move.b  D1,($600,A1)
            move.b  ($1E00,A1),D1
            move.b  D2,($600,A1)
            lsr.w   #8,D2
            move.b  D2,($1E00,A1)
            lsl.w   #8,D1
            move.b  (A1),D2
            lsl.w   #8,D2
            move.b  ($400,A1),D2
            move.b  D2,D1
            and.b   (-9,A0),D1
            move.b  D1,($400,A1)
            move.b  (A1),D1
            move.b  D2,($400,A1)
            lsr.w   #8,D2
            move.b  D2,(A1)
.noVIA2:
            RTS6
MEMORYCTRLINITPATCH:
            btst    #$15,D0
            beq.b   .L5
            movea.l ($54,A0),A3
            move.l  #$124F0810,D4
            moveq   #$1F,D3
            movea.l ($2C,A0),A2
            bclr    #5,($400,A2)
            btst    #5,(A2)
            beq.b   .L1
            move.l  #$138B0810,D4
.L1:
            lea     (A3),A2
.L2:
            move.l  D4,(A2)+
            lsr.l   #1,D4
            dbra    D3,.L2
            moveq   #0,D4
            move.l  D4,(A2)+
            move.l  D3,($A0,A3)
            move.l  D3,($A4,A3)
            move.l  D3,($A8,A3)
            move.l  D3,($AC,A3)
            move.l  D3,($B0,A3)
            move.l  D3,($B4,A3)
            move.l  ($48,A3),D4
            btst    #0,D4
            beq.b   .L3
            moveq   #0,D4
            bra.b   .L4
.L3:
            moveq   #1,D4
.L4:
            move.l  D4,(A2)
            move.l  D3,($B8,A3)
.L5:
            btst    #$16,D0
            beq.b   .L6
            movea.l ($58,A0),A2
            movea.l A2,A3
            adda.l  #$34000,A3
            move.b  (A3),D3
            andi.b  #1,D3
            move.b  D3,(A2)
.L6:
            jmp     (A4)
RELOADBERRVBR:
            adda.l  D3,SP
            lea     GotBusError,A0
            move.l  A0,D0
.L1:
            cmp.l   -(A0),D0
            beq.b   .L2
            tst.l   (A0)
            bne.b   .L1
            lea     BusErrVct,A0
            move.l  D0,(A0)
.L2:
            subq.w  #8,A0
            movec   A0,VBR
.L3:
            moveq   #0,D2
            BSR6    GetHardwareInfo
            btst    #0,D0
            beq.b   .L3
            BSR6    InitVIAs
            bra.w   ROMBERRANDVBRRTN
            ds.b    960
IOPMGR:
IOPInfoAccess:
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #noErr,D0
            moveq   #0,D1                           ; Zero extend
            move.b  (A0),D1
            cmpi.b  #2,D1
            bhi.b   .paramError
            move.w  .JumpTable(PC,D1.w*2),D2
            move.b  (1,A0),D1
            cmpi.b  #7,D1
            bhi.b   .paramError
            lea     ([IOPMgrVars.w],D1.w*4),A1
            jmp     .JumpTable(PC,D2.w)
.JumpTable:
            dc.w    .InstallIOP-.JumpTable
            dc.w    .GetIOPInfo-.JumpTable
            dc.w    .RemoveIOP-.JumpTable
.paramError:
            moveq   #-$32,D0
            bra.b   .Done
.GetIOPInfo:
            move.l  (A1),(4,A0)
.Done:
            movem.l (SP)+,D3-D4/A2-A4
            rts
.RemoveIOP:
            move.l  (A1),(4,A0)
            clr.l   (A1)
            bra.b   .Done
.InstallIOP:
            tst.l   (A1)
            bne.b   .paramError
            movea.l (4,A0),A4
            move.l  D1,D3
            subq.l  #4,SP
            move.l  #'iopc',-(SP)
            move.w  D3,-(SP)
            _RGetResource
            move.l  (SP)+,D0
            beq.b   .paramError
            movea.l D0,A0
            movea.l (A0),A0
            move    SR,-(SP)
            ori     #$700,SR
            movea.l (A4)+,A2
            movea.l (A4)+,A3
            movea.l (A4),A1
            move.b  #$32,(A1)
            move.w  #$7FFF,D0
            moveq   #-1,D1
.Fill_FF_Loop:
            move.w  D0,(A2)
            move.b  D1,(A3)
            dbra    D0,.Fill_FF_Loop
            move.w  #$7FFF,D0
.ComplementLoop:
            move.w  D0,(A2)
            move.b  (A3),D1
            not.b   D1
            move.w  D0,(A2)
            move.b  D1,(A3)
            dbne    D0,.ComplementLoop
            bne.b   .InitError
            move.w  #$7FFF,D0
.Check_00_Loop:
            move.w  D0,(A2)
            move.b  (A3),D1
            dbne    D0,.Check_00_Loop
            bne.b   .InitError
            movea.l A0,A1
.SegLoop:
            move.b  (A0)+,D0
            beq.b   .LoadDone
            move.w  (A0)+,(A2)
.LoadLoop:
            move.b  (A0)+,(A3)
            subq.b  #1,D0
            bne.b   .LoadLoop
            move.b  (A1)+,D0
            move.w  (A1)+,(A2)
.CheckCodeLoop:
            move.b  (A3),D1
            cmp.b   (A1)+,D1
            bne.b   .InitError
            subq.b  #1,D0
            bne.b   .CheckCodeLoop
            bra.b   .SegLoop
.LoadDone:
            move.w  #$31F,(A2)
            clr.b   (A3)
            movea.l (A4),A1
            move.b  #$36,(A1)
            moveq   #-1,D0
.AliveWaitLoop:
            move.w  #$31F,(A2)
            cmpi.b  #$FF,(A3)
            dbeq    D0,.AliveWaitLoop
            beq.b   .Alive
.InitError:
            move    (SP)+,SR
            bra.w   .paramError
.Alive:
            move.w  #$200,(A2)
            addq.l  #8,A4
            move.b  (A3),(A4)+
            move.w  #$300,(A2)
            move.b  (A3),(A4)
            suba.w  #$11,A4
            move.l  A4,([IOPMgrVars.w],D3.w*4)
            lea     ($14,A4),A0
            lea     (6,A0),A1
            move.b  D3,(A1)+
            move.b  #2,(A1)+
            move.l  #$10C0C00,(A1)+
            lea     ($2C,A4),A2
            move.l  A2,(A1)+
            move.l  A2,(A1)+
            lea     MOVEREQHANDLER,A2
            move.l  A2,(A1)+
            _IOPMsgRequest
            move    (SP)+,SR
            bra.w   .Done
IOPMsgRequest:
            movem.l D3-D4/A2-A3,-(SP)
            moveq   #-$32,D0
            moveq   #0,D2
            lea     (6,A0),A1
            move.b  (A1)+,D2
            cmpi.w  #7,D2
            bhi.b   .L3
            movea.l IOPMgrVars,A2
            movea.l (0,A2,D2.w*4),A2
            move.l  A2,D3
            beq.b   .L2
            move.b  ($10,A2),D3
            move.b  (A1)+,D2
            beq.b   .CheckReqKind
            move.b  ($11,A2),D3
.CheckReqKind:
            cmpi.w  #3,D2
            bhi.b   .L3
            move.w  .JumpTable(PC,D2.w*2),D1
            move.b  (A1)+,D2
.L2:
            beq.b   .paramError
            cmp.b   D3,D2
.L3:
            bhi.b   .paramError
            move.w  D2,D3
            lsl.w   #4,D2
            moveq   #$20,D4
            cmp.b   (A1)+,D4
            bcs.b   .paramError
            cmp.b   (A1)+,D4
            bcs.b   .paramError
            lea     ($28,A2,D2.w),A3
            jmp     .JumpTable(PC,D1.w)
.JumpTable:
            dc.w    .SendXmtMessage-.JumpTable
            dc.w    .SendRcvReply-.JumpTable
            dc.w    .WaitRcvMessage-.JumpTable
            dc.w    .RemoveRcvWaiter-.JumpTable
.SendXmtMessage:
            st      (A1)
            dc.w    $43EB,$0006,$40C2
            dc.w    $007C,$0700,$B1E9,$0002,$670A,$4EBA,$4ADC,$B1E9
            dc.w    $0002,$6640,$46C2,$7000,$1028,$0009,$2268,$000C
            dc.w    $1F3C,$0001,$0043,$0200
.SendAndInterrupt:
            move.w  D3,-(SP)
            lsl.b   #5,D3
            move.l  (8,A2),-(SP)
            movea.l (4,A2),A3
            movea.l (A2),A2
            move.w  (A2),-(SP)
            move.w  D3,(A2)
            bsr.w   CopyToIop
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            move.w  (SP)+,(A2)
            move.b  (SP)+,(A3)
            move.w  D0,(A2)
            move.b  #$E,(A1)
.success:
            moveq   #0,D0
.paramError:
            movem.l (SP)+,D3-D4/A2-A3
            rts
.notAtHead:
            move    D2,SR
            bra.b   .success
.SendRcvReply:
            cmpa.l  (A3),A0
            bne.b   .paramError
            tst.b   (A1)
            bne.b   .paramError
            st      (A1)
            moveq   #0,D0
            move.b  ($A,A0),D0
            movea.l ($10,A0),A1
            move.b  #3,-(SP)
            ori.w   #$300,D3
            bra.b   .SendAndInterrupt
.WaitRcvMessage:
            tst.l   (A3)
            bne.b   .paramError
            st      (A1)
            move.l  A0,(A3)
            bra.b   .success
.RemoveRcvWaiter:
            cmpa.l  (A3),A0
            bne.b   .paramError
            clr.b   (A1)
            clr.l   (A3)
            bra.b   .success
IOPMOVEDATA:
            movem.l A2-A3,-(SP)
            moveq   #-$32,D0
            moveq   #0,D2
            move.b  (A0)+,D2
            cmpi.w  #3,D2
            bhi.b   .L1
            move.w  .L2(PC,D2.w*2),D1
            move.b  (A0)+,D2
            cmpi.w  #7,D2
            bhi.b   .L1
            movea.l IOPMgrVars,A1
            movea.l (0,A1,D2.w*4),A2
            move.l  A2,D2
            beq.b   .L1
            movea.l (4,A2),A3
            movea.l (A2),A2
            moveq   #0,D0
            move.w  (A0)+,D0
            movea.l (A0)+,A1
            move.w  (A2),-(SP)
            move.w  (A0)+,(A2)
            jsr     .L2(PC,D1.w)
            move.w  (SP)+,(A2)
            moveq   #0,D0
.L1:
            movem.l (SP)+,A2-A3
            rts
.L2:
            dc.w    $0034,$0088,$00DC,$0008,$40C2,$007C,$0700,$323C
            dc.w    $021F,$3481,$7001,$1680,$3481,$B013,$67FA,$1019
            dc.w    $670A,$3499,$1699,$5300,$66FA,$60F2,$3481,$4213
            dc.w    $46C2,$4E75
CopyFromIop:
            cmpi.w  #3,D0
            bls.b   .L6
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .L1
            subq.w  #4,D1
            add.w   D1,D0
            jmp     .L1(PC,D1.w*2)
            move.b  (A3),(A1)+
            move.b  (A3),(A1)+
            move.b  (A3),(A1)+
.L1:
            ror.l   #2,D0
            moveq   #7,D1
            and.w   D0,D1
            neg.w   D1
            lsr.w   #3,D0
            jmp     .L3(PC,D1.w*2)
.L2:
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
.L3:
            dbra    D0,.L2
            add.l   D0,D0
            bcs.b   .L7
.L4:
            bpl.b   .L5
            move.b  (A3),(A1)
.L5:
            rts
.L6:
            roxr.l  #2,D0
            bcc.b   .L4
.L7:
            bpl.b   .L8
            move.b  (A3),(A1)+
.L8:
            move.w  (A3),(A1)
            rts
CopyToIop:
            cmpi.w  #3,D0
            bls.b   .L6
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .Aligned
            subq.w  #4,D1
            add.w   D1,D0
            jmp     .Aligned(PC,D1.w*2)
            move.b  (A1)+,(A3)
            move.b  (A1)+,(A3)
            move.b  (A1)+,(A3)
.Aligned:
            ror.l   #2,D0
            moveq   #7,D1
            and.w   D0,D1
            neg.w   D1
            lsr.w   #3,D0
            jmp     .L3(PC,D1.w*2)
.L2:
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
.L3:
            dbra    D0,.L2
            add.l   D0,D0
            bcs.b   .L7
.L4:
            bpl.b   .L5
            move.b  (A1),(A3)
.L5:
            rts
.L6:
            roxr.l  #2,D0
            bcc.b   .L4
.L7:
            bpl.b   .L8
            move.b  (A1)+,(A3)
.L8:
            move.w  (A1),(A3)
            rts
            cmpi.w  #3,D0
            bls.b   .L10
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .L10
            subq.w  #4,D1
            add.w   D1,D0
            not.w   D1
.L9:
            move.b  (A3),D2
            cmp.b   (A1)+,D2
            dbne    D1,.L9
            bne.b   .L14
.L10:
            moveq   #3,D1
            and.w   D0,D1
            lsr.w   #2,D0
            beq.b   .L13
            subq.w  #1,D0
.L11:
            move.l  (A3),D2
            cmp.l   (A1)+,D2
            dbne    D0,.L11
            bra.b   .L13
.L12:
            move.b  (A3),D2
            cmp.b   (A1)+,D2
.L13:
            dbne    D1,.L12
.L14:
            sne     (A0)
            bls.b   .L15
            neg.b   (A0)
.L15:
            rts
IOPINTERRUPT:
            movea.l IOPMgrVars,A0
            jmp     ([-4.w,A0])
vIOPInterrupt:
            move.l  (0,A0,D0.w*4),D1
            beq.b   .noIop
            movea.l D1,A0
            movea.l (A0)+,A2
            movea.l (A0)+,A3
            move    SR,D2
            move.b  D0,D2
            move.l  A0,-(SP)
.checkAgain:
            movea.l (A0)+,A1
            move.b  (A1),D1
            lsr.b   #5,D1
            bcs.b   .xmtComp
            lsr.b   #1,D1
            bcs.b   .rcvNew
            lsr.b   #1,D1
            bcs.b   .bypassInt
.IntHandled:
            move    D2,SR
            addq.l  #4,SP
            lsr.l   #8,D0
            bne.w   .RunNonDeferrable
            rts
.noIop:
            cmpi.w  #0,D0
            beq.w   SCCIOPBYPASSINT
            rts
.bypassInt:
            move.l  (A0),D1
            beq.b   .IntHandled
            move    D2,SR
            move.l  D0,(SP)
            movea.l D1,A0
            jsr     (A0)
            move.l  (SP)+,D0
            bra.b   IOPINTERRUPT
.rcvNew:
            move.b  #$26,(A1)
            move.w  #$201,D1
            move.w  #$301,D3
            lea     .RcvFound,A1
            move.b  (5,A0),D0
            lea     ($1C,A0),A0
            move.w  (A2),-(SP)
            bra.b   .SearchStart
.xmtComp:
            move.b  #$16,(A1)
            moveq   #3,D1
            move.w  #$201,D3
            lea     .xmtFound,A1
            move.b  (4,A0),D0
            lea     ($1C,A0),A0
            move.w  (A2),-(SP)
            bra.b   .SearchStart
.L7:
            lea     ($10,A0),A0
            cmp.b   (A3),D1
            dbeq    D0,.L7
            bne.b   .searchDone
            move.w  (A2),D3
            movem.l D0-D3/A0-A1,-(SP)
            subq.w  #1,D3
            move.w  D3,(A2)
            lsr.w   #8,D1
            move.b  D1,(A3)
            move    D2,SR
            jsr     (A1)
            movem.l (SP)+,D0-D3/A0-A1
.SearchStart:
            ori     #$700,SR
            move.w  D3,(A2)
            dbra    D0,.L7
.searchDone:
            move.w  (SP)+,(A2)
            clr.w   D0
            move.b  D2,D0
            movea.l IOPMgrVars,A1
            tst.b   (-$F,A1)
            bne.b   .toCkAgain
            tst.l   (-$C,A1)
            beq.b   .toCkAgain
            st      (-$F,A1)
            lea     (-$24,A1),A0
            movem.l D0/D2/A2,-(SP)
            jsr     ([JDTInstall.w])
            movem.l (SP)+,D0/D2/A2
.toCkAgain:
            move    D2,SR
            movea.l (SP),A0
            bra.w   .checkAgain
.xmtFound:
            lea     (8,A0),A1
            move.l  (A1),D1
            beq.b   .empty
            move.l  A1,-(SP)
            movea.l D1,A0
            subq.l  #2,A1
            jsr     (DequeueTrap.w,PC)
            movea.l ($10,A0),A1
            moveq   #0,D0
            move.b  ($A,A0),D0
            bsr.b   .CopyAndQueue
            movea.l (SP)+,A1
            move.l  (A1),D1
            beq.b   .empty
            movea.l D1,A0
            jmp     ([$61C.w])
.empty:
            rts
.RcvFound:
            move.l  (A0),D1
            beq.b   .empty
            movea.l D1,A0
            movea.l ($C,A0),A1
            moveq   #0,D0
            move.b  (9,A0),D0
.CopyAndQueue:
            beq.b   .CopyDone
            move.w  D3,D1
            lsl.b   #5,D1
            move.w  D1,(A2)
            bsr.w   CopyFromIop
.CopyDone:
            movea.l IOPMgrVars,A1
            lea     (-$E,A1),A1
            tst.l   ($14,A0)
            beq.b   .NoHandler
            jmp     (QStuff.w,PC)
.NoHandler:
            clr.b   ($B,A0)
            rts
.RunNonDeferrable:
            move.l  D0,D3
            lsr.l   #8,D3
            movea.l IOPMgrVars,A1
            lea     (-$E,A1),A1
            lea     (2,A1),A0
            ori     #$700,SR
.RunLoop:
            move.l  (A0),D0
            beq.b   .RunDone
            movea.l D0,A0
            cmp.b   (6,A0),D2
            bne.b   .RunLoop
            move.b  (8,A0),D0
            tst.b   (7,A0)
            bne.b   .ChkMsgNum
            addq.b  #8,D0
.ChkMsgNum:
            btst    D0,D3
            beq.b   .RunLoop
            jsr     (DequeueTrap.w,PC)
            move.l  A0,-(SP)
            bsr.b   .RunLoop
            movea.l (SP)+,A0
            clr.b   ($B,A0)
            move.l  ($14,A0),D0
            beq.b   .RunRTS
            movea.l D0,A1
            jmp     (A1)
.RunDone:
            move    D2,SR
.RunRTS:
            rts
CallCompHandler:
            move    (SP)+,SR
            movea.l D0,A0
            jsr     (DequeueTrap.w,PC)
            clr.b   ($B,A0)
            move.l  ($14,A0),D0
            beq.b   IOPDefTask
            move.l  A1,-(SP)
            movea.l D0,A1
            jsr     (A1)
            movea.l (SP)+,A1
IOPDefTask:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  (2,A1),D0
            bne.b   CallCompHandler
            clr.b   -(A1)
            move    (SP)+,SR
            rts
MOVEREQHANDLER:
            movea.l A0,A2
            movea.l ($C,A0),A0
            move.b  (6,A2),(1,A0)
            jsr     ([$620.w])
            movea.l A2,A0
            move.b  #1,(7,A0)
            jmp     ([$61C.w])
INITIOPMGR:
            movem.l D0/A0-A3,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D0
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .noSCCIOP
            addi.w  #$A8,D0
.noSCCIOP:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .noSWIMIOP
            addi.w  #$A8,D0
.noSWIMIOP:
            tst.w   D0
            beq.b   .noIOPs
            addi.w  #$44,D0
            _NewPtrSysClear
            lea     ($24,A0),A2
            move.l  A2,IOPMgrVars
            move.w  #7,(-$20,A2)
            lea     IOPDefTask,A0
            move.l  A0,(-$1C,A2)
            lea     (-$E,A2),A0
            move.l  A0,(-$18,A2)
            lea     vIOPInterrupt,A0
            move.l  A0,(-4,A2)
            lea     ($20,A2),A2
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .SCCIOPdone
            moveq   #0,D0
            movea.l SCCRd,A1
            lea     (SCCIOPBYPASSINT.w,PC),A3
            bsr.b   .InstallIOP
.SCCIOPdone:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .SWIMIOPdone
            moveq   #1,D0
            movea.l IWM,A1
            suba.l  A3,A3
            bsr.b   .InstallIOP
.SWIMIOPdone:
.Done
            move    (SP)+,SR
            movem.l (SP)+,D0/A0-A3
            rts
.noIOPs:
            lea     .traps,A1
            move.w  (A1)+,D0
            _GetToolBoxTrapAddress
.trapLoop:
            move.w  (A1)+,D0
            beq.b   .SWIMIOPdone
            _SetOSTrapAddress
            bra.b   .trapLoop
.traps:
            dc.w    $A89F,$A086,$A087,$A088,0
.InstallIOP:
            movea.l A2,A0
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            lea     (-$1F,A1),A1
            move.l  A1,(A0)+
            addq.w  #7,A1
            move.l  A1,(A0)+
            subq.w  #4,A1
            move.l  A1,(A0)+
            move.l  A3,(A0)+
            movea.l SP,A0
            _IOPInfoAccess
            addq.l  #8,SP
            lea     ($A8,A2),A2
            rts
SCCIOPByPass:
            movem.l D0/A0-A2,-(SP)
            move.l  #$10089,D0
            clr.b   -(SP)
            movea.l SP,A0
            _ReadXPRam
            bsr.b   sub_40805364
            and.b   (SP)+,D0
            bne.b   .Done
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (4,SP)
            pea     .ByPassMsg
            move.l  #$10301FF,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            movea.l SP,A0
            _IOPMsgRequest
            bne.b   .FlagBypass
.Sync_Loop:
            tst.b   ($B,SP)
            bne.b   .Sync_Loop
.FlagBypass:
            lea     ($1C,SP),SP
            bsr.b   sub_4080536E
.Done:
            movem.l (SP)+,D0/A0-A2
            rts
.ByPassMsg:
            dc.w    $0400,$FF00
SCCIOPHwInit:
            movea.l SCCRd,A1
            move.b  #$32,(-$1C,A1)
            lea     .L3,A0
            move.w  (A0)+,D0
            move.w  (A0)+,(-$1F,A1)
.L1:
            move.b  (A0)+,(-$18,A1)
            dbra    D0,.L1
            move.b  #$36,(-$1C,A1)
            lsr.w   #6,D0
.L2:
            dbra    D0,.L2
            rts
.L3:
            dc.w    $0011,$7FEE,$A981,$8D30,$F0A9,$238D,$31F0,$80FE
            dc.w    $EE7F,$EE7F,$EE7F
sub_40805364:
            move.b  (4,SP),($BFE).w
            moveq   #1,D0
            rts
sub_4080536E:
            beq.b   .L1
            bset    #0,($BFE).w
.L1:
            rts
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.w    $4761,$7279
HWPRIVPROC:
            dc.w    HWPRIV.L2-HWPRIVPROC
            dc.w    HWPRIV.L3-HWPRIVPROC
            dc.w    HWPRIV.L4-HWPRIVPROC
            dc.w    HWPRIV.L5-HWPRIVPROC
            dc.w    EnableExtCache-HWPRIVPROC
            dc.w    sub_408054F4-HWPRIVPROC
            dc.w    sub_408054F4.L2-HWPRIVPROC
            dc.w    0,$0034,$0056,$02C4,0
HWPRIV:
            cmpi.w  #$A,D0
            bhi.b   .L1
            move.w  HWPRIVPROC(PC,D0.w*2),D0
            jmp     HWPRIVPROC(PC,D0.w)
.L1:
            move.l  #$FFFFFE0A,D0
            rts
.L2:
            bra.l   HWPrivPatch
            dc.w    $60FF,$0008,$1A8A
            ds.b    18
.L3:
            bra.l   FLUSHICACHEPATCH
            ds.b    4
            dc.w    $60FF,$0008,$1C26
.L4:
            bra.l   SWAPDCACHEPATCH
            ds.b    24
.L5:
            bra.l   FLUSHDCACHEPATCH
            ds.b    10
EnableExtCache:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l UnivInfoPtr,A0
            cmpi.b  #5,($13,A0)
            bne.b   .L2
            movea.l VIA2,A0
            lea     (A0),A0
            moveq   #-9,D0
            and.b   (A0),D0
            btst    #0,D0
            beq.b   .L2
            move.b  D0,(A0)
            bset    #3,D0
.L1:
            move.b  D0,(A0)
            move.b  (A0),(A0)
            move.b  (A0),(A0)
            bclr    #0,D0
            bne.b   .L1
.L2:
            move    (SP)+,SR
            moveq   #0,D0
            rts
sub_408054F4:
            movea.l UnivInfoPtr,A0
            cmpi.b  #5,($13,A0)
            bne.b   .L1
            movea.l VIA2,A0
            lea     (A0),A0
            ori.b   #1,(A0)
.L1:
            moveq   #0,D0
            rts
.L2:
            bsr.b   sub_408054F4
            bsr.b   EnableExtCache
            rts
            ds.b    12
MEMORYDPROC:
            dc.w    MEMORYDISPATCH.L2-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L3-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L4-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L5-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L6-MEMORYDPROC
            dc.w    MEMORYDISPATCH.L7-MEMORYDPROC
            dc.w    sub_408055DE.L11-MEMORYDPROC
            dc.w    sub_408055DE.L12-MEMORYDPROC
            ds.b    8
MEMORYDISPATCH:
            cmpi.w  #7,D0
            bhi.b   .L1
            move.w  MEMORYDPROC(PC,D0.w*2),D0
            jmp     MEMORYDPROC(PC,D0.w)
.L1:
            move.l  #$FFFFFE0A,D0
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            moveq   #0,D0
            rts
.L4:
            bra.l   NEWLOCKMEMORY
.L5:
            bra.l   NEWUNLOCKMEMORY
.L6:
            bra.l   NEWLOCKMEMORYCONTIGUOUS
.L7:
            movem.l D3/A3-A4,-(SP)
            move.l  A0,-(SP)
            movea.l A0,A4
            move.l  A1,D3
            move.l  (A4)+,D2
            movea.l D2,A0
            add.l   (A4),D2
            cmp.l   RealMemTop,D2
            bhi.b   .L10
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.b   .L10
            movea.l A0,A3
            movea.l D2,A0
            subq.l  #1,A0
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.b   .L10
            suba.l  A3,A0
            addq.l  #1,A0
            cmpa.l  (A4),A0
            bne.b   .L11
            tst.l   D3
            beq.b   .L8
            move.l  (A4)+,D0
            add.l   D0,(-8,A4)
            clr.l   (-4,A4)
            move.l  A3,(A4)+
            move.l  D0,(A4)
.L8:
            movea.w #1,A0
            clr.w   D2
.L9:
            move.l  D2,D0
            movea.l (SP)+,A1
            movem.l (SP)+,D3/A3-A4
            rts
.L10:
            suba.l  A0,A0
            move.w  #$FFCE,D2
            bra.b   .L9
.L11:
            movea.l (SP),A4
            movea.l (A4),A0
            addq.l  #8,A4
            move.l  D3,D1
            bsr.w   sub_408055DE
            tst.w   D2
            bmi.b   .L10
            movea.l D1,A0
            bra.b   .L9
sub_408055DE:
            link.w  A6,#-$24
            movem.l D3-D7,-(SP)
            move.l  D1,(-$14,A6)
            move.l  #1,(-$18,A6)
            clr.l   (-$1C,A6)
            move.l  (-8,A4),(-$20,A6)
            move.l  (-4,A4),(-$24,A6)
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.w   .L10
            move.l  A0,(-4,A6)
            move.l  #'pgsz',D0
            _Gestalt
            move.l  A0,(-$C,A6)
            move.l  A0,D2
            subq.w  #1,D2
            move.l  (-4,A6),D3
            neg.l   D3
            and.l   D3,D2
            move.l  D2,(-$10,A6)
            movea.l (-$20,A6),A3
            adda.l  D2,A3
.L1:
            movea.l A3,A0
            bsr.l   GETREALPROC
            tst.w   D0
            bmi.w   .L10
            move.l  (-4,A6),D3
            add.l   (-$10,A6),D3
            cmpa.l  D3,A0
            bne.b   .L3
            move.l  (-$10,A6),D3
.L2:
            add.l   (-$C,A6),D3
            cmp.l   (-4,A4),D3
            bcc.b   .L5
            move.l  D3,(-$10,A6)
            adda.l  (-$C,A6),A3
            bra.b   .L1
.L3:
            tst.l   (-$14,A6)
            beq.b   .L4
            move.l  (-$1C,A6),D3
            move.l  (-4,A6),(0,A4,D3.l*8)
            move.l  (-$10,A6),(4,A4,D3.l*8)
            addq.l  #1,D3
            cmp.l   (-$14,A6),D3
            bcc.b   .L7
            move.l  D3,(-$1C,A6)
.L4:
            addq.l  #1,(-$18,A6)
            move.l  (-$10,A6),D3
            add.l   D3,(-8,A4)
            sub.l   D3,(-4,A4)
            move.l  A0,(-4,A6)
            moveq   #0,D3
            bra.b   .L2
.L5:
            tst.l   (-$14,A6)
            bne.b   .L6
            move.l  (-$18,A6),D1
            move.l  (-$20,A6),(-8,A4)
            move.l  (-$24,A6),(-4,A4)
            bra.b   .L8
.L6:
            move.l  (-$1C,A6),D3
            move.l  (-4,A6),(0,A4,D3.l*8)
            move.l  (-4,A4),(4,A4,D3.l*8)
            move.l  (-4,A4),D2
            add.l   D2,(-8,A4)
            clr.l   (-4,A4)
            addq.l  #1,D3
.L7:
            move.l  D3,D1
.L8:
            moveq   #0,D2
.L9:
            movem.l (SP)+,D3-D7
            unlk    A6
            rts
.L10:
            move.w  #$FFFF,D2
            bra.b   .L9
.L11:
            bra.l   WRITEPROTECTPROC
.L12:
            bra.l   UNWRITEPROTECTPROC
WAITFORSCSIDEVSNUB:
            dc.w    $60FF,$0008,$1D88
            ds.b    406
READSLOTBYTE:
            move.l  (4,A0),-(SP)
            clr.b   (3,A0)
            _sOffsetData
            bne.b   .L1
            move.b  ($F,A0),(3,A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    4
READSLOTWORD:
            move.l  (4,A0),-(SP)
            clr.w   (2,A0)
            _sOffsetData
            bne.b   .L1
            move.w  ($E,A0),(2,A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    4
READSLOTLONG:
            move.l  (4,A0),-(SP)
            clr.l   (A0)
            bclr    #1,($36,A0)
            _sReadPBSize
            bne.b   .L1
            move.l  (8,A0),(A0)
            moveq   #0,D0
.L1:
            move.l  (SP)+,(4,A0)
            rts
            dc.w    0
GETCSTRING:
            movem.l A2-A3,-(SP)
            move.l  (4,A0),-(SP)
            move.b  ($31,A0),-(SP)
            _sFindStruct
            bne.b   sub_40805950.L1
            movea.l (4,A0),A3
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40805950.L1
            move.l  (A0),D1
            moveq   #0,D0
            moveq   #0,D2
            movea.l A3,A1
            lea     sub_40805950.L1,A2
            pea     sub_4080592C
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_4080592C:
            addq.l  #1,D0
            move.b  (A1),D2
            beq.b   .L2
            move.b  D1,D2
            adda.w  D2,A1
.L1:
            ror.l   #8,D1
            tst.b   D1
            beq.b   .L1
            bra.b   sub_4080592C
.L2:
            move.l  D0,(8,A0)
            pea     sub_40805950
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805950:
            movea.l A0,A2
            _NewPtr
            bne.b   .L1
            move.l  A0,(A2)
            movea.l A2,A0
            move.l  A3,(4,A0)
            _sReadStruct
            beq.b   .L1
            move.l  D0,D1
            movea.l A0,A1
            movea.l (4,A1),A0
            _DisposPtr
            movea.l A1,A0
            move.l  D1,D0
.L1:
            move.b  (SP)+,($31,A0)
            move.l  (SP)+,(4,A0)
            movem.l (SP)+,A2-A3
            rts
GETSLOTBLOCK:
            move.l  (4,A0),-(SP)
            bset    #1,($36,A0)
            _sReadPBSize
            bne.b   .L2
            move.l  (8,A0),D0
            subq.l  #4,D0
            bgt.b   .L1
            move.w  #$FEB0,D0
            bra.b   .L2
.L1:
            move.l  D0,(8,A0)
            movea.l A0,A1
            _NewPtrSys
            bne.b   .L2
            move.l  A0,(A1)
            movea.l A1,A0
            _sReadStruct
            beq.b   .L2
            move.l  D0,D1
            movea.l A0,A1
            movea.l (4,A1),A0
            _DisposPtr
            movea.l A1,A0
            move.l  D1,D0
.L2:
            move.l  (SP)+,(4,A0)
            rts
            ds.b    10
FINDSLOTSTRUCT:
            _sOffsetData
            bne.b   .L1
            _sCalcsPointer
.L1:
            rts
            ds.b    4
READSLOTSTRUCT:
            movem.l D1-D3/A1-A3,-(SP)
            move.b  ($31,A0),-(SP)
            movea.l (4,A0),A3
            move.l  A3,-(SP)
            move.l  (A0),D0
            _StripAddress
            move.l  D0,-(SP)
            movea.l D0,A1
            _sPtrToSlot
            bne.b   sub_40805A26.L4
            _sFindsInfoRecPtr
            bne.b   sub_40805A26.L4
            movea.l (A0),A2
            move.b  (9,A2),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40805A26.L4
            move.l  (A0),D1
            pea     sub_40805A26
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805A26:
            moveq   #0,D3
            move.l  (8,A0),D2
            subq.l  #1,D2
            lea     .L3,A2
            move.w  #$FECC,D0
.L1:
            move.b  (A3),(A1)+
            move.b  D1,D3
            adda.w  D3,A3
.L2:
            ror.l   #8,D1
            tst.b   D1
            beq.b   .L2
            dbra    D2,.L1
            moveq   #0,D0
.L3:
            pea     .L4
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
.L4:
            move.l  (SP)+,(A0)
            move.l  (SP)+,(4,A0)
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1-D3/A1-A3
            tst.w   D0
            rts
            ds.b    8
READSLOTINFO:
            movem.l A2,-(SP)
            movea.l (A0),A2
            move.l  A2,-(SP)
            _sFindsInfoRecPtr
            bne.w   .L2
            movea.l (A0),A1
            moveq   #$F,D2
.L1:
            move.b  (A1)+,(A2)+
            dbra    D2,.L1
            moveq   #0,D0
.L2:
            move.l  (SP)+,(A0)
            movem.l (SP)+,A2
            rts
            ds.b    12
SLOTDISPOSPTR:
            move.l  A0,-(SP)
            movea.l (4,A0),A0
            _DisposPtr
            beq.b   .L1
            move.l  #$FFFFFEC8,D0
.L1:
            movea.l (SP)+,A0
            rts
            ds.b    12
READSLOTDRVRNAME:
            movem.l A2-A3,-(SP)
            move.b  ($32,A0),D2
            movea.l (A0),A3
            move.l  A3,-(SP)
            clr.b   ($33,A0)
            clr.l   ($18,A0)
            _sGetsRsrcPtr
            bne.b   .L2
            move.b  #2,($32,A0)
            _sGetcString
            bne.b   .L2
            movea.l (A0),A2
            move.l  (8,A0),D1
            subq.b  #1,D1
            cmpi.l  #$FE,D1
            bhi.b   .L1
            move.b  ($B,A0),(A3)+
            move.b  #$2E,(A3)+
            movem.l A0-A1,-(SP)
            movea.l A2,A0
            movea.l A3,A1
            move.l  D1,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            bne.b   .L1
            exg     A2,A0
            _DisposPtr
            movea.l A2,A0
            moveq   #0,D0
            bra.b   .L3
.L1:
            exg     A2,A0
            _DisposPtr
            movea.l A2,A0
.L2:
            move.l  #$FFFFFEAA,D0
.L3:
            move.l  (SP)+,(A0)
            move.b  D2,($32,A0)
            movem.l (SP)+,A2-A3
            rts
            ds.b    14
FINDDEVBASE:
            move.l  A1,-(SP)
            move.b  ($32,A0),-(SP)
            move.l  ($18,A0),-(SP)
            clr.l   ($18,A0)
            bset    #1,($1B,A0)
            pea     sub_40805B62
            move.l  ([SDMJmpTblPtr.w],$2C.w),-(SP)
            rts
sub_40805B62:
            bne.b   .L5
            moveq   #0,D2
            move.b  ($31,A0),D2
            move.b  #$A,($32,A0)
            _sReadLong
            bne.b   .L1
            move.l  (A0),D1
            andi.l  #$FFFFFF,D1
            bra.b   .L2
.L1:
            move.b  #$C,($32,A0)
            _sReadLong
            bne.b   .L5
            move.l  (A0),D1
            andi.l  #$FFFFFFF,D1
            ror.l   #4,D2
            or.l    D1,D2
            bra.b   .L4
.L2:
            move.l  #$F0000000,D0
            or.l    D1,D0
            bfins   D2,D0{4:4}
            bfins   D2,D0{8:4}
            move.l  D0,D2
            nop
            nop
            nop
            tst.b   ($31,A0)
            bne.b   .L3
            movea.l UnivInfoPtr,A1
            adda.l  (8,A1),A1
            move.l  (8,A1),D2
            move.l  (4,A1),D1
.L3:
            move.b  #7,($32,A0)
            _sReadWord
            bne.b   .L4
            bsr.l   Overpatch
            nop
.L4:
            move.l  D2,(A0)
            moveq   #0,D0
.L5:
            move.l  (SP)+,($18,A0)
            move.b  (SP)+,($32,A0)
            movem.l (SP)+,A1
            rts
            dc.w    0
CARDCHANGED:
            clr.b   (3,A0)
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A1
            btst    #1,($B,A1)
            sne     (3,A0)
            moveq   #0,D0
.L1:
            rts
            ds.b    6
SLOTEXEC:
            dc.w    $6028
sub_40805C12:
            cmpi.b  #2,(A2)
            beq.b   .L1
            move.l  #$FFFFFEB3,D0
            bra.b   .L3
.L1:
            cmpi.b  #2,(1,A2)
            bls.b   .L2
            move.l  #$FFFFFEB2,D0
            bra.b   .L3
.L2:
            addq.l  #4,A2
            movea.l (A2),A1
            adda.l  A1,A2
            moveq   #0,D0
.L3:
            rts
            movem.l D3-D4/A2-A3,-(SP)
            move.l  (4,A0),-(SP)
            _sGetBlock
            bne.b   .L5
            movea.l (A0),A2
            movea.l A2,A3
            bsr.b   sub_40805C12
            bne.b   .L4
            bsr.l   SLOTMGRPATCH
            bra.b   .L4
            ds.b    8
.L4:
            exg     D0,D2
            exg     A3,A0
            _DisposPtr
            movea.l A3,A0
            exg     D2,D0
.L5:
            move.l  (SP)+,(4,A0)
            movem.l (SP)+,D3-D4/A2-A3
            rts
            ds.b    12
CALCSPOINTER:
            movem.l D3-D6,-(SP)
            movea.l (4,A0),A1
            moveq   #0,D1
            move.w  A1,D1
            andi.b  #3,D1
            btst    D1,($35,A0)
            bne.b   .L1
            move.l  #$FFFFFEA6,D0
            bra.b   .L10
.L1:
            moveq   #0,D2
            moveq   #3,D3
.L2:
            btst    D3,($35,A0)
            beq.b   .L3
            addq.w  #1,D2
.L3:
            dbra    D3,.L2
            tst.b   D2
            bne.b   .L4
            move.l  #$FFFFFEA5,D0
            bra.b   .L10
.L4:
            move.l  ($C,A0),D4
            btst    #$17,D4
            beq.b   .L5
            ori.l   #$FF000000,D4
.L5:
            move.l  D4,D5
            divsl.l D2,D6:D5
            lsl.l   #2,D5
            tst.b   D6
            beq.b   .L9
            bpl.b   .L7
            neg.w   D6
            subq.w  #1,D6
.L6:
            subq.b  #1,D1
            andi.b  #3,D1
            subq.l  #1,D5
            btst    D1,($35,A0)
            beq.b   .L6
            dbra    D6,.L6
            bra.b   .L9
.L7:
            subq.w  #1,D6
.L8:
            addq.b  #1,D1
            andi.b  #3,D1
            addq.l  #1,D5
            btst    D1,($35,A0)
            beq.b   .L8
            dbra    D6,.L8
.L9:
            add.l   D5,(4,A0)
            moveq   #0,D0
.L10:
            movem.l (SP)+,D3-D6
            rts
GETSLOTDRVR:
            bra.w   sub_40805D4A.L5
DynLoadDrvr:
            clr.l   ($18,A0)
            _sGetsRsrcPtr
            bne.b   .L1
            move.b  #5,($32,A0)
            _sExec
            bne.b   .L1
            movea.l ($14,A0),A2
            tst.w   (2,A2)
            bne.b   .L1
            move.l  (8,A2),(A0)
            move.b  (4,A2),($36,A0)
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.l  #$FFFFFEA7,D0
.L2:
            rts
sub_40805D4A:
            _sRsrcInfo
            bne.b   .L3
            move.b  #4,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.b  #2,($32,A0)
            bset    #1,($36,A0)
            _sReadPBSize
            beq.b   .L1
            move.b  #1,($32,A0)
            bset    #1,($36,A0)
            _sReadPBSize
            bne.b   .L3
.L1:
            subq.l  #4,(8,A0)
            move.l  (8,A0),D0
            _ResrvMem sys
            bne.b   .L3
            move.l  (8,A0),D0
            _NewHandle sys
            bne.b   .L3
            movea.l A0,A3
            move.l  (A0),D0
            _StripAddress
            move.l  D0,(A1)
            movea.l A1,A0
            _sReadStruct
            bne.b   .L2
            bsr.l   STATLOADPATCH
            bra.b   .L4
.L2:
            movea.l A3,A0
            _DisposHandle
.L3:
            movea.l A1,A0
            clr.l   (A0)
            move.l  #$FFFFFEA7,D0
.L4:
            rts
.L5:
            bra.l   SLOTGETDRIVERPATCH
ORIGGETSLOTDRVR:
            move.b  ($32,A0),D2
            bsr.w   DynLoadDrvr
            beq.b   .L1
            move.b  D2,($32,A0)
            bsr.w   sub_40805D4A
.L1:
            movea.l A1,A0
            move.b  D2,($32,A0)
            movem.l (SP)+,A2-A3
ENDGETSLOTDRVR:
            rts
StartSDeclMgr:
            suba.w  #$38,SP
            movea.l SP,A0
            jsr     INITJMPTBL
            bne.b   .L2
            bsr.b   INITSLOTMGR
            bsr.w   InitsRsrcTable
            bsr.w   InitPRAMRecs
            clr.b   ($36,A0)
            move.l  WarmStart,D0
            cmpi.l  #'WLSC',D0
            bne.b   .L1
            bset    #2,($36,A0)
.L1:
            bsr.w   PRIMARY_INIT
            moveq   #0,D0
.L2:
            lea     ($38,SP),SP
            rts
            ds.b    8
INITSLOTMGR:
            movem.l D1/A1-A2,-(SP)
            bsr.w   sub_40805E48
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            _sFindsInfoRecPtr
            movea.l (A0),A1
            tst.w   (4,A1)
            bmi.b   .L2
            bsr.w   sub_40805F2A
.L2:
            dbra    D1,.L1
            movem.l (SP)+,D1/A1-A2
            rts
sub_40805E48:
            movem.l D1-D2/A0-A3,-(SP)
            move.l  SP,SInfoPtr
            suba.w  #$14,SP
            movea.l #$FEFFFFFF,A1
            moveq   #$E,D1
            moveq   #0,D2
            movea.l UnivInfoPtr,A3
            adda.l  ($C,A3),A3
            lea     sub_40805E78.L1,A2
            pea     sub_40805E78
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805E78:
            move.w  #$FFFE,-(SP)
            bsr.l   ALLOCSLOTOVERPATCH1
            bne.b   .L2
            move.b  (A1),D0
            addq.w  #1,D2
            move.w  D2,(SP)
            bra.b   .L2
.L1:
            move.w  #$FFFF,(SP)
.L2:
            suba.l  #$1000000,A1
            subq.w  #1,D1
            bne.b   sub_40805E78
            pea     sub_40805EA8
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805EA8:
            move.l  D2,D0
            mulu.w  #$18,D0
            addi.l  #$B0,D0
            _NewPtrSysClear
            lea     ($14,A0),A0
            move.l  A0,SInfoPtr
            movea.l A0,A1
            lea     ($3C,A0),A0
            bsr.l   ALLOCSLOTOVERPATCH2
            lea     ($18,A0),A0
            move.w  #$FED4,(4,A0)
            lea     ($18,A0),A0
            move.l  ([ROMBase.w],$40.w),D0
            subq.l  #1,D0
            add.l   ROMBase,D0
            move.l  D0,($10,A0)
            move.w  #1,($C,A0)
            move.l  A0,(A1)
            move.w  #1,D0
.L1:
            movea.l A0,A2
            move.w  (SP)+,D1
            muls.w  #$18,D1
            adda.l  D1,A2
            move.l  A2,(0,A1,D0.w*4)
            move.w  #$64,($C,A2)
            move.b  D0,($14,A2)
            not.l   ($10,A2)
            bfins   D0,($10,A2){4:4}
            addq.w  #1,D0
            cmpi.w  #$E,D0
            ble.b   .L1
            lea     ($14,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            rts
sub_40805F2A:
            movem.l D1/A2,-(SP)
            suba.w  #$14,SP
            movea.l SP,A2
            move.l  A2,(A0)
            moveq   #3,D1
.L1:
            bsr.b   sub_40805F90
            bne.b   .L4
            _sReadFHeader
            bne.b   .L2
            cmpi.l  #videoMagic,($E,A2)
            bne.b   .L2
            bsr.w   sub_40805FEE
            bne.b   .L2
            bsr.w   sub_40806014
            beq.b   .L3
.L2:
            subq.l  #1,($10,A1)
            dbra    D1,.L1
            move.w  #$FECB,D0
            bra.b   .L4
.L3:
            move.l  ($10,A1),(4,A0)
            move.l  (A2),($C,A0)
            addi.l  #$FFFFFFED,($C,A0)
            _sCalcsPointer
            bne.b   .L4
            move.l  (4,A0),(A1)
.L4:
            lea     ($14,SP),SP
            move.w  D0,(4,A1)
            movem.l (SP)+,D1/A2
            rts
sub_40805F90:
            movem.l D2/A0/A2,-(SP)
            movea.l ($10,A1),A0
            pea     sub_40805FA6
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40805FA6:
            lea     .L2,A2
.L1:
            move.b  (A0),D0
            moveq   #$F,D2
            and.b   D0,D2
            beq.b   .L2
            not.b   D0
            asr.w   #4,D0
            cmp.b   D0,D2
            bne.b   .L2
            btst    D1,D0
            bne.b   .L3
.L2:
            subq.w  #1,A0
            dbra    D1,.L1
            move.w  #$FECB,D0
            bra.b   .L4
.L3:
            move.b  D0,(9,A1)
            move.l  A0,($10,A1)
            move.l  A0,D0
            move.b  D0,($A,A1)
            moveq   #0,D0
.L4:
            pea     sub_40805FE8
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40805FE8:
            movem.l (SP)+,D2/A0/A2
            rts
sub_40805FEE:
            cmpi.b  #1,($D,A2)
            bne.b   .L1
            cmpi.b  #9,($C,A2)
            bhi.b   .L1
            tst.b   ($12,A2)
            bne.b   .L1
            move.l  (A2),D0
            beq.b   .L1
            rol.l   #8,D0
            ext.w   D0
            beq.b   .L2
.L1:
            move.w  #$FED2,D0
.L2:
            rts
sub_40806014:
            movem.l D1-D4/A2-A4,-(SP)
            movea.l A2,A4
            move.l  (4,A4),D2
            beq.b   sub_40806058.L6
            moveq   #1,D1
            sub.l   D2,D1
            move.l  ($10,A1),(4,A0)
            move.l  D1,($C,A0)
            _sCalcsPointer
            bne.b   sub_40806058.L6
            movea.l (4,A0),A3
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806058.L6
            move.l  (A0),D4
            moveq   #0,D1
            moveq   #0,D3
            pea     sub_40806058
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40806058:
            move.w  #$FED3,D0
            lea     .L5,A2
.L1:
            rol.l   #1,D1
            cmpi.l  #$C,D2
            bhi.b   .L2
            cmpi.l  #8,D2
            bhi.b   .L3
.L2:
            move.b  (A3),D3
            add.l   D3,D1
.L3:
            move.b  D4,D3
            adda.w  D3,A3
.L4:
            ror.l   #8,D4
            tst.b   D4
            beq.b   .L4
            subq.l  #1,D2
            bne.b   .L1
            cmp.l   (8,A4),D1
            bne.b   .L5
            moveq   #0,D0
.L5:
            pea     .L6
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
.L6:
            movem.l (SP)+,D1-D4/A2-A4
            rts
InitsRsrcTable:
            movem.l A1-A2,-(SP)
            pea     sub_408060B2
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
sub_408060B2:
            move.l  A1,SRsrcTblPtr
            clr.b   ($31,A0)
            clr.w   ($24,A0)
            clr.w   ($26,A0)
            clr.b   ($33,A0)
            clr.b   ($34,A0)
.L1:
            _sFindsInfoRecPtr
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L2
            bsr.w   sub_408060EC
.L2:
            addq.b  #1,($31,A0)
            cmpi.b  #$E,($31,A0)
            ble.b   .L1
            movem.l (SP)+,A1-A2
            rts
sub_408060EC:
            movem.l D3-D5/A3,-(SP)
            move.l  (A2),(4,A0)
            move.b  (9,A2),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.w   sub_4080617E.L1
            move.l  (A0),($18,A0)
            move.l  (A2),D4
            moveq   #0,D3
.L1:
            move.l  D4,(4,A0)
            pea     sub_40806122
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806122:
            bne.b   sub_4080617E.L1
            move.l  (4,A0),D5
            move.l  D4,(4,A0)
            move.l  D5,D4
            move.b  (A0),D5
            cmpi.b  #$FF,D5
            beq.b   sub_4080617E.L1
            cmp.b   D3,D5
            bls.b   sub_4080617E.L1
            move.b  D5,D3
            move.b  D3,($32,A0)
            move.l  (A0),D5
            andi.l  #$FFFFFF,D5
            move.l  D5,($C,A0)
            _sCalcsPointer
            bne.b   sub_4080617E.L1
            cmpi.w  #$FFFF,(A1)
            bne.b   .L2
            movea.l A1,A3
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
.L1:
            move.l  A1,(2,A3)
.L2:
            clr.l   ($18,A0)
            pea     sub_4080617E
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
sub_4080617E:
            bne.b   .L1
            addq.w  #1,([SInfoPtr.w],-$12.w)
            move.l  A1,([SInfoPtr.w],-$10.w)
            adda.w  #$18,A1
            bra.w   sub_408060EC.L1
.L1:
            movem.l (SP)+,D3-D5/A3
            rts
            dc.w    0
InitPRAMRecs:
            movem.l D1-D5/A1-A2,-(SP)
            nop
            nop
            nop
            subq.w  #8,SP
            movea.l SP,A1
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            movea.l UnivInfoPtr,A2
            adda.l  ($C,A2),A2
            btst    #3,(0,A2,D1.w)
            bne.b   .L6
            clr.w   (A1)
            move.l  A1,(A0)
            _sReadPRAMrec
            move.w  (A1),D4
            clr.l   (A1)
            clr.l   (4,A1)
            moveq   #0,D5
.L2:
            move.b  D5,($32,A0)
            bsr.w   sub_4080636E
            bne.b   .L5
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L5
            cmpi.b  #2,(8,A2)
            bge.b   .L6
            move.b  ($32,A0),D5
            move.b  #$20,($32,A0)
            _sReadWord
            beq.b   .L3
            move.w  #$FEC5,(4,A2)
            bra.b   .L5
.L3:
            move.w  (2,A0),D2
            cmp.w   D4,D2
            beq.b   .L6
            tst.b   D1
            beq.b   .L2
            move.b  #$21,($32,A0)
            _sReadPBSize
            bne.b   .L4
            subq.l  #4,(8,A0)
            move.l  A1,(A0)
            _sReadStruct
            bne.b   .L4
            bset    #1,($B,A2)
.L4:
            move.w  D2,(A1)
.L5:
            move.l  A1,(4,A0)
            _sInitSlotPRAM
.L6:
            dbra    D1,.L1
            moveq   #0,D0
            addq.w  #8,SP
            movem.l (SP)+,D1-D5/A1-A2
            rts
PRIMARYINITRTN:
            move.l  A2,($14,A0)
            move.b  #$20,(1,A2)
            moveq   #0,D0
            _SwapMMUMode
            move.b  D0,-(SP)
            clr.b   ($31,A0)
            bsr.b   sub_4080627A
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            bsr.b   sub_4080627A
            subq.w  #1,D1
            bne.b   .L1
            move.b  (SP)+,D0
            _SwapMMUMode
            lea     ($18,SP),SP
            movem.l (SP)+,D1/A1-A3
            rts
sub_4080627A:
            clr.b   ($32,A0)
            bsr.w   sub_4080636E
            bne.w   .L1
            movea.l (4,A0),A3
            movea.l (A0),A1
            tst.w   (4,A1)
            bmi.b   .L1
            cmpi.b  #3,(8,A1)
            bcc.b   .L1
            move.b  #$22,($32,A0)
            _sFindStruct
            bne.b   .L1
            move.l  A2,-(SP)
            BigJmp  SLOTPRIMARYINITPATCH,A2
            ds.b    8
.L1:
            rts
SECONDARY_INIT:
            movem.l D1-D2/A1-A3,-(SP)
            suba.w  #$18,SP
            movea.l SP,A2
            move.l  A2,($14,A0)
            move.b  #$20,(1,A2)
            moveq   #$E,D1
.L1:
            move.b  D1,($31,A0)
            clr.b   ($32,A0)
            bsr.w   sub_4080636E
            bne.b   .L4
            movea.l (4,A0),A3
            movea.l (A0),A1
            cmpi.b  #4,(8,A1)
            bcc.b   .L4
            move.w  (4,A1),D0
            bpl.b   .L2
            cmpi.w  #$FEC4,D0
            bne.b   .L4
            cmpi.w  #$8080,(6,A1)
            bgt.b   .L4
            clr.w   (4,A1)
            bset    #2,($B,A1)
.L2:
            move.w  D0,D2
            move.b  #$26,($32,A0)
            _sFindStruct
            beq.b   .L3
            move.w  D2,(4,A1)
            bclr    #2,($B,A1)
            beq.b   .L4
            move.w  #$FEC4,(4,A1)
            bra.b   .L4
.L3:
            move.l  A3,(4,A0)
            move.b  D1,(A2)
            move.b  ($36,A0),(4,A2)
            _sExec
            bclr    #2,($B,A1)
            move.b  #4,(8,A1)
            move.w  (2,A2),(6,A1)
            bpl.b   .L4
            move.w  #$FEC4,(4,A1)
.L4:
            dbra    D1,.L1
            cmpi.b  #$E,D1
            bls.w   .L1
            lea     ($18,SP),SP
            movem.l (SP)+,D1-D2/A1-A3
            rts
sub_4080636E:
            move.l  A1,-(SP)
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.l  #$10000,($28,A0)
            clr.l   ($2C,A0)
            clr.b   ($30,A0)
            clr.b   ($33,A0)
            clr.l   ($18,A0)
            ori.b   #3,($1B,A0)
            _sGetTypesRsrc
            beq.b   .L1
            move.w  #$FEC7,D0
.L1:
            move.l  A1,(A0)
            movea.l (SP)+,A1
            tst.w   D0
            rts
            ds.b    10
SLOTPRAM:
READSLOTPRAM:
            moveq   #0,D0
            move.l  (A0),($18,A0)
            bra.b   CommonPRAM
PutSlotPRAM:
            moveq   #1,D0
            move.l  (4,A0),($18,A0)
            bra.b   CommonPRAM
InitSlotPRAM:
            moveq   #2,D0
            move.l  (4,A0),($18,A0)
CommonPRAM:
            movem.l D1/D3/A0-A1,-(SP)
            clr.w   D3
            move.l  D0,D1
            move.b  ($31,A0),D3
            bne.b   .CheckRange
            nop
            nop
            nop
            nop
            movea.l UnivInfoPtr,A1
            adda.l  (8,A1),A1
            move.b  ($C,A1),D3
.CheckRange:
            movea.l ($18,A0),A1
            move.w  #$FEAF,D0
            cmpi.b  #$E,D3
            bhi.b   .Done
            cmpi.b  #9,D3
            bge.b   .InternalPRAM
            tst.w   ([SInfoPtr.w],-$13.w)
            beq.b   .Done
            bra.b   .Done
.InternalPRAM:
            subi.b  #9,D3
            mulu.w  #8,D3
            addi.w  #$46,D3
            move.l  #$80000,D0
            move.w  D3,D0
            movea.l A1,A0
            tst.b   D1
            bne.b   .WritePRAM
            _ReadXPRam
            bra.b   .Done
.WritePRAM:
            subq.l  #2,D1
            beq.b   .DoWrite
            addq.l  #2,A0
            subi.l  #$1FFFE,D0
.DoWrite:
            _WriteXPRam
.Done:
            movem.l (SP)+,D1/D3/A0-A1
            rts
            dc.w    0
FINDSINFORECPTR:
            moveq   #0,D0
            move.b  ($31,A0),D0
            cmpi.b  #$E,D0
            bhi.b   .L1
            move.l  ([SInfoPtr.w],D0.w*4),(A0)
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.w  #$FEAF,D0
.L2:
            rts
            ds.b    4
FINDSRSRCPTR:
            clr.b   ($33,A0)
            clr.l   ($18,A0)
GETSRSRCPTR:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L1
            movea.l (4,A0),A1
            move.l  ($10,A1),(4,A0)
.L1:
            movea.l (SP)+,A1
            rts
            dc.w    0
PTRTOSLOT:
            movem.l D1-D2,-(SP)
            move.w  #$FEB1,D0
            move.l  (4,A0),D1
            beq.b   .L3
            clr.b   D1
            rol.l   #4,D1
            cmpi.b  #$F,D1
            beq.b   .L1
            move.b  ROMBase,D2
            lsr.b   #4,D2
            cmp.b   D2,D1
            bhi.b   .L2
            moveq   #0,D1
            bra.b   .L2
.L1:
            clr.b   D1
            rol.l   #4,D1
.L2:
            move.w  #$FEAF,D0
            cmpi.b  #$E,D1
            bhi.b   .L3
            move.b  D1,($31,A0)
            moveq   #0,D0
.L3:
            tst.w   D0
            movem.l (SP)+,D1-D2
            rts
            ds.b    14
READFHEADER:
            movem.l A1-A2,-(SP)
            movea.l (A0),A2
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   .L1
            move.l  ($10,A1),(4,A0)
            move.l  #$FFFFFFED,($C,A0)
            move.b  (9,A1),($35,A0)
            _sCalcsPointer
            bne.b   .L1
            move.l  A2,(A0)
            move.l  #$14,(8,A0)
            _sReadStruct
.L1:
            movem.l (SP)+,A1-A2
            rts
            ds.b    14
CKCARDSTAT:
            move.l  A2,-(SP)
            _sFindsInfoRecPtr
            bne.b   .L1
            movea.l (A0),A2
            tst.w   (4,A2)
            bmi.b   .L1
            moveq   #0,D0
            bra.b   .L2
.L1:
            move.l  #$FFFFFEAB,D0
.L2:
            movea.l (SP)+,A2
            rts
            dc.w    0
SLOTVERSION:
            move.l  #2,(A0)
            clr.l   (4,A0)
            moveq   #0,D0
            rts
            dc.w    0
NEXTSRSRC:
            clr.l   ($18,A0)
            bset    #2,($1B,A0)
GETSRSRC:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L2
            movea.l (4,A0),A1
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
.L1:
            bra.b   .L3
.L2:
            move.w  #$FEA8,D0
.L3:
            movea.l (SP)+,A1
            tst.w   D0
            rts
NEXTTYPESRSRC:
            clr.l   ($18,A0)
GETTYPESRSRC:
            movem.l D1-D6/A1,-(SP)
            moveq   #0,D0
            move.b  ($30,A0),D0
            lea     sub_408065E6.L2,A1
            lsr.b   #2,D0
            move.l  (0,A1,D0.w*4),D1
            move.b  ($30,A0),D0
            andi.b  #3,D0
            move.l  (0,A1,D0.w*4),D2
            move.l  ($28,A0),D3
            move.l  ($2C,A0),D4
            and.l   D1,D3
            and.l   D2,D4
.L1:
            bset    #2,($1B,A0)
            _sFindSRTRec
            bne.b   sub_408065E6.L1
            movea.l (4,A0),A1
            move.l  (A1),($31,A0)
            move.l  D1,D5
            and.l   (8,A1),D5
            cmp.l   D3,D5
            bne.b   .L1
            move.l  D2,D6
            and.l   ($C,A1),D6
            cmp.l   D4,D6
            bne.b   .L1
            pea     sub_408065E6
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
sub_408065E6:
            moveq   #0,D0
            nop
.L1:
            movem.l (SP)+,D1-D6/A1
            rts
.L2:
            dc.w    $FFFF,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF
            ds.b    4
UPDATESRT:
            moveq   #1,D0
            clr.l   (4,A0)
            clr.l   ($18,A0)
            bra.b   sub_4080660E
INSERTSRT:
            moveq   #0,D0
sub_4080660E:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  D0,D1
            movea.l (4,A0),A2
            move.l  ($18,A0),D2
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            beq.b   .L2
            move.l  A2,(4,A0)
            move.l  D2,($18,A0)
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D0.w),-(SP)
            rts
.L1:
            bra.b   .L5
.L2:
            movea.l (4,A0),A1
            tst.w   D1
            beq.b   .L3
            move.w  #$FEA8,D0
            btst    #0,($17,A1)
            bne.b   .L5
            move.w  ($24,A0),(6,A1)
            move.w  ($26,A0),(4,A1)
            moveq   #0,D0
            bra.b   .L5
.L3:
            move.l  A2,D0
            beq.b   .L5
            move.l  A2,(4,A0)
            move.l  D2,($18,A0)
            pea     .L4
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
.L4:
            nop
.L5:
            movem.l (SP)+,D1-D2/A1-A2
            rts
SEARCHSRT:
            clr.l   ($18,A0)
            btst    #0,($36,A0)
            beq.b   FINDSRTREC
            bset    #2,($1B,A0)
FINDSRTREC:
            movem.l D2-D4/A1-A3,-(SP)
            movea.l SRsrcTblPtr,A1
            move.l  ($31,A0),D2
            clr.b   D2
            movea.l A1,A2
            movea.l A1,A3
            move.l  MinusOne,D3
.L1:
            bsr.w   sub_40806984
            bne.b   .L4
            move.l  (A1),D4
            clr.b   D4
            cmp.l   D2,D4
            bgt.b   .L2
            blt.b   .L3
            movea.l A1,A2
            btst    #2,($1B,A0)
            beq.b   .L6
            bra.b   .L3
.L2:
            cmp.l   D3,D4
            bhi.b   .L3
            movea.l A1,A3
            move.l  D4,D3
.L3:
            lea     ($18,A1),A1
            bra.b   .L1
.L4:
            tst.l   D3
            bmi.b   .L5
            moveq   #0,D0
            movea.l A3,A2
            btst    #2,($1B,A0)
            beq.b   .L5
            btst    #1,($1B,A0)
            beq.b   .L6
            move.b  ($31,A0),D1
            cmp.b   (A2),D1
            beq.b   .L6
.L5:
            move.w  #$FEA8,D0
.L6:
            move.l  A2,(4,A0)
            movem.l (SP)+,D2-D4/A1-A3
            tst.w   D0
            rts
DELETESRTREC:
            movem.l A0-A2,-(SP)
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            bne.w   .L5
            movea.l (4,A0),A1
            move.w  #$FF01,(A1)
            movea.l ([SInfoPtr.w],-$10.w),A2
            move.w  #$17,D0
.L1:
            move.b  (A2)+,(A1)+
            dbra    D0,.L1
            movea.l ([SInfoPtr.w],-$10.w),A2
            move.w  #$FF01,(A2)
            subq.w  #1,([SInfoPtr.w],-$12.w)
            move.w  ([SInfoPtr.w],-$12.w),D0
            divu.w  #8,D0
            andi.l  #$FFFF0000,D0
            bne.b   .L4
            move.b  MMU32bit,-(SP)
            clr.b   D0
            _SwapMMUMode
            movea.l A2,A0
            _DisposPtr
            move.b  (SP)+,D0
            _SwapMMUMode
            movea.l SRsrcTblPtr,A1
.L2:
            lea     ($C0,A1),A1
            cmpa.l  (2,A1),A2
            beq.b   .L3
            movea.l (2,A1),A1
            bra.b   .L2
.L3:
            clr.l   (2,A1)
            movea.l A1,A2
.L4:
            suba.w  #$18,A2
            move.l  A2,([SInfoPtr.w],-$10.w)
            moveq   #0,D0
            bra.b   .L6
.L5:
            move.w  #$FEA1,D0
.L6:
            movem.l (SP)+,A0-A2
            rts
SLOTRSRCINFO:
            clr.l   ($18,A0)
GETSRSRCINFO:
            move.l  A1,-(SP)
            _sFindSRTRec
            bne.b   .L2
            movea.l (4,A0),A1
            pea     .L1
            move.l  ([SDMJmpTblPtr.w],$D8.w),-(SP)
            rts
.L1:
            bra.b   .L2
            move.w  #$FEA1,D0
.L2:
            movea.l (SP)+,A1
            rts
SETSRSRCSTATE:
            movem.l D1/A1,-(SP)
            move.l  ($18,A0),D1
            clr.l   ($18,A0)
            bset    #0,($1B,A0)
            _sFindSRTRec
            bne.b   .L1
            movea.l (4,A0),A1
            bclr    #0,($17,A1)
            tst.b   D1
            beq.b   .L1
            bset    #0,($17,A1)
            moveq   #0,D0
.L1:
            move.l  D1,($18,A0)
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
PNEWSRTENTRY:
            movem.l D1/A1-A2,-(SP)
            move.l  (4,A0),D0
            bne.b   .L1
            move.l  ($18,A0),D1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.l  (A1),(4,A0)
            _sFindStruct
            bne.b   sub_4080686A.L1
            move.l  D1,($18,A0)
.L1:
            movea.l ([SInfoPtr.w],-$10.w),A1
.L2:
            cmpi.w  #$FF01,(A1)
            beq.b   sub_40806856.L1
            cmpi.w  #$FFFF,(A1)
            beq.b   .L3
            lea     ($18,A1),A1
            bra.b   .L2
.L3:
            movea.l A1,A2
            pea     sub_40806856
            move.l  ([SDMJmpTblPtr.w],$F0.w),-(SP)
            rts
sub_40806856:
            bne.b   sub_4080686A.L1
            move.l  A1,(2,A2)
.L1:
            pea     sub_4080686A
            move.l  ([SDMJmpTblPtr.w],$D4.w),-(SP)
            rts
sub_4080686A:
            bne.b   .L1
            addq.w  #1,([SInfoPtr.w],-$12.w)
            move.l  A1,([SInfoPtr.w],-$10.w)
.L1:
            movem.l (SP)+,D1/A1-A2
            rts
PINITENTRY:
            movem.l D1/A2,-(SP)
            subq.w  #8,SP
            movea.l SP,A2
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            move.b  ($33,A0),(2,A1)
            clr.b   (3,A1)
            move.w  ($26,A0),(4,A1)
            move.w  ($24,A0),(6,A1)
            move.l  (4,A0),($10,A1)
            clr.l   ($14,A1)
            move.l  ($18,A0),D0
            beq.b   .L1
            bset    #0,($17,A1)
.L1:
            move.b  #8,($32,A0)
            _sReadByte
            bne.b   .L2
            move.b  (3,A0),(3,A1)
.L2:
            move.b  #1,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.l  #8,(8,A0)
            move.l  A2,(A0)
            _sReadStruct
            bne.b   .L3
            move.l  (A2),(8,A1)
            move.l  (4,A2),($C,A1)
            moveq   #0,D0
            move.w  ($26,A0),D1
            beq.b   .L4
            bsr.b   sub_40806930
            bne.b   .L3
            _sFindDevBase
            bne.b   .L3
            move.l  (A0),($2A,A2)
            move.b  (1,A1),($29,A2)
            move.b  (2,A1),($32,A2)
            bra.b   .L4
.L3:
            move.w  #$FF01,(A1)
.L4:
            move.l  ($10,A1),(4,A0)
            addq.w  #8,SP
            movem.l (SP)+,D1/A2
            tst.w   D0
            rts
sub_40806930:
            move.w  #$FFCD,D0
            not.w   D1
            bmi.b   .L1
            cmp.w   UnitNtryCnt,D1
            bge.b   .L1
            asl.w   #2,D1
            movea.l UTableBase,A2
            move.l  (0,A2,D1.w),D1
            beq.b   .L1
            movea.l D1,A2
            move.l  (A2),D1
            beq.b   .L2
            movea.l D1,A2
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
.L2:
            moveq   #$E,D0
            _SysError
PALLOCSRTBLK:
            move.l  A0,-(SP)
            move.l  #$C6,D0
            _NewPtrSysClear
            bne.b   .L2
            movea.l A0,A1
            move.w  #7,D0
.L1:
            move.w  #$FF01,(A0)
            lea     ($18,A0),A0
            dbra    D0,.L1
            move.w  #$FFFF,(A0)
            moveq   #0,D0
.L2:
            movea.l (SP)+,A0
            rts
sub_40806984:
            movem.l D1-D2/A0,-(SP)
.L1:
            move.w  (A1),D1
            bmi.b   .L2
            btst    #0,($1B,A0)
            bne.b   .L5
            btst    #0,($17,A1)
            beq.b   .L5
            bra.b   .L3
.L2:
            cmpi.w  #$FFFF,D1
            bne.b   .L3
            tst.l   (2,A1)
            beq.b   .L4
            movea.l (2,A1),A1
            bra.b   .L1
.L3:
            lea     ($18,A1),A1
            bra.b   .L1
.L4:
            move.w  #$FEA1,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movem.l (SP)+,D1-D2/A0
            rts
PSRTOSPBLOCK:
            move.b  (A1),($31,A0)
            move.b  (1,A1),($32,A0)
            move.b  (2,A1),($33,A0)
            move.b  (3,A1),($34,A0)
            move.w  (4,A1),($26,A0)
            move.w  (6,A1),($24,A0)
            move.w  (8,A1),($28,A0)
            move.w  ($A,A1),($2A,A0)
            move.w  ($C,A1),($2C,A0)
            move.w  ($E,A1),($2E,A0)
            move.l  ($10,A1),(4,A0)
            clr.l   ($18,A0)
            btst    #0,($17,A1)
            beq.b   .L1
            move.l  #1,($18,A0)
.L1:
            rts
            ds.b    6
CALCSTEP:
            movem.l D1-D3/A1,-(SP)
            move.w  #$FEA6,D0
            clr.w   D1
            clr.w   D2
            move.b  (7,A0),D1
            andi.l  #3,D1
            move.b  ($35,A0),D2
            btst    D1,D2
            beq.b   .L3
            move.l  D2,D3
            asl.w   #2,D3
            btst    #5,($36,A0)
            beq.b   .L1
            lea     .L4,A1
            move.l  (0,A1,D3.w),D2
            mulu.w  #8,D1
            ror.l   D1,D2
            move.l  D2,(A0)
            bra.b   .L2
.L1:
            lea     .L5,A1
            move.l  (0,A1,D3.w),(A0)
            bpl.b   .L2
            lea     .L6,A1
            andi.b  #7,D2
            subq.b  #3,D2
            asl.l   #4,D2
            adda.l  D1,A1
            move.l  (0,A1,D2.w),(A0)
.L2:
            clr.w   D0
.L3:
            movem.l (SP)+,D1-D3/A1
            rts
.L4:
            ds.b    4
            dc.w    $0404,$0404,$0404,$0404,$0301,$0301,$0404,$0404
            dc.w    $0202,$0202,$0301,$0301,$0002,$0101,$0404,$0404
            dc.w    $0103,$0103,$0202,$0202,$0001,$0201,$0301,$0301
            dc.w    $0001,$0102,$0002,$0101,$0101,$0101
.L5:
            ds.b    4
            dc.w    $1010,$1010,$1010,$1010,$0808,$0808,$1010,$1010
            dc.w    $0808,$0808,$0808,$0808,$FFFF,$FFFF,$1010,$1010
            dc.w    $0808,$0808,$0808,$0808,$FFFF,$FFFF,$0808,$0808
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$0404,$0404
.L6:
            dc.w    $0505,$0505,$0606,$0606
            ds.b    4
            dc.w    $0505,$0505
            ds.b    16
            dc.w    $0606,$0606
            ds.b    4
            dc.w    $0505,$0505,$0505,$0505
            ds.b    4
            dc.w    $0505,$0505,$0505,$0505,$0606,$0606,$0505,$0505
            dc.w    $0505,$0505,$0606,$0606
            ds.b    4
OFFSETDATA:
            movem.l D1-D2/A1,-(SP)
            move.b  ($31,A0),-(SP)
            move.w  #$FEB6,D0
            cmpi.b  #$FF,($32,A0)
            beq.w   sub_40806BA6.L1
            _sPtrToSlot
            bne.w   sub_40806BA6.L1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   sub_40806BA6.L1
            move.b  (9,A1),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806BA6.L1
            move.l  (A0),($18,A0)
            moveq   #0,D1
.L1:
            move.b  D1,D2
            movea.l (4,A0),A1
            pea     sub_40806BA6
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806BA6:
            bne.b   .L1
            move.b  (A0),D1
            move.w  #$FEB5,D0
            cmp.b   D2,D1
            bcs.b   .L1
            move.w  #$FEB6,D0
            cmpi.b  #$FF,D1
            beq.b   .L1
            cmp.b   ($32,A0),D1
            bne.b   OFFSETDATA.L1
            move.l  (A0),D0
            andi.l  #$FFFFFF,D0
            move.l  D0,($C,A0)
            move.l  A1,(4,A0)
            moveq   #0,D0
.L1:
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1-D2/A1
            tst.w   D0
            rts
READPBSIZE:
            movem.l D1/A1,-(SP)
            move.b  ($31,A0),-(SP)
            _sFindStruct
            bne.b   sub_40806C24.L1
            _sPtrToSlot
            bne.b   sub_40806C24.L1
            _sFindsInfoRecPtr
            movea.l (A0),A1
            move.w  (4,A1),D0
            bmi.b   sub_40806C24.L1
            move.b  (9,A1),($35,A0)
            bset    #5,($36,A0)
            _sCalcStep
            bne.b   sub_40806C24.L1
            move.l  (A0),($18,A0)
            pea     sub_40806C24
            move.l  ([SDMJmpTblPtr.w],$DC.w),-(SP)
            rts
sub_40806C24:
            bne.b   .L1
            move.l  (A0),(8,A0)
            moveq   #0,D0
            btst    #1,($36,A0)
            beq.b   .L1
            move.b  (A0),D1
            beq.b   .L1
            move.w  #$FEB4,D0
.L1:
            move.b  (SP)+,($31,A0)
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
            ds.b    8
PREAD4BYTES:
            movem.l D1-D4/A1-A2,-(SP)
            move.l  ($18,A0),D2
            movea.l (4,A0),A1
            moveq   #3,D3
            moveq   #0,D4
            pea     sub_40806C6E
            move.l  ([SDMJmpTblPtr.w],$E8.w),-(SP)
            rts
sub_40806C6E:
            lea     .L3,A2
            move.w  #$FECC,D0
.L1:
            asl.l   #8,D1
            move.b  (A1),D1
            move.b  D2,D4
            adda.w  D4,A1
.L2:
            ror.l   #8,D2
            tst.b   D2
            beq.b   .L2
            dbra    D3,.L1
            move.l  D1,(A0)
            move.l  A1,(4,A0)
            moveq   #0,D0
.L3:
            pea     sub_40806C9E
            move.l  ([SDMJmpTblPtr.w],$EC.w),-(SP)
            rts
sub_40806C9E:
            movem.l (SP)+,D1-D4/A1-A2
            rts
            ds.b    12
PBUSEXCEPTION:
            move.l  D0,-(SP)
            move.w  ($E,SP),D0
            andi.w  #$F1C0,D0
            cmpi.w  #$140,D0
            bne.b   .L1
            move.b  ($A,SP),D0
            lsr.b   #4,D0
            cmpi.b  #$B,D0
            bne.b   .L1
            move.b  ($14,SP),D0
            cmpi.b  #$90,D0
            bcs.b   .L1
            cmpi.b  #$FF,D0
            beq.b   .L1
            cmpi.b  #$F0,D0
            beq.b   .L1
            move.l  A0,-(SP)
            BigJmp  SLOTBUSEXCPTNPTCH,A0
.L1:
            move.l  (SP)+,D0
            move.l  ([SInfoPtr.w],-8.w),-(SP)
            rts
; pInstallBus
; Install the slot manager's bus exception vector
pInstallBus:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #1,D0
            _SwapMMUMode
            move.b  D0,([SInfoPtr.w],-4.w)
            move.l  BusErrVct,([SInfoPtr.w],-8.w)
            move.l  ([SDMJmpTblPtr.w],$E4.w),BusErrVct
            move    (SP)+,SR
            rts
pRestoreBus:
            move.l  D0,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            move.b  ([SInfoPtr.w],-4.w),D0
            _SwapMMUMode
            move.l  ([SInfoPtr.w],-8.w),BusErrVct
            move    (SP)+,SR
            move.l  (SP)+,D0
            rts
PRIMARY_INIT:
            movem.l D1/A1-A3,-(SP)
            suba.w  #$18,SP
            movea.l SP,A2
            jmp     PRIMARYINITRTN
            ds.b    12
INITJMPTBL:
            movem.l A0-A2,-(SP)
            cmpi.l  #$FFFFFFFF,SDMJmpTblPtr
            beq.b   .L1
            movea.l SDMJmpTblPtr,A0
            _DisposPtr
.L1:
            move.l  #$F4,D0
            _NewPtrSysClear
            move.l  A0,SDMJmpTblPtr
            moveq   #$3C,D0
            lea     SDMJmpTable,A1
.Loop:
            movea.l A1,A2
            adda.w  (A1)+,A2
            move.l  A2,(A0)+
            dbra    D0,.Loop
            bra.l   INITJMPTBLPATCH
            dc.w    0
SDMJmpTable:
            dc.w    $EAF8,$EB16,$EB34,$EB52,$0084,$EBDE,$EC2C,$EC3A
            dc.w    $F798,$FA26,$F860,$F7AC,$F7D4,$0072,$0070,$006E
            dc.w    $ECB8,$F5F6,$F5FC,$F712,$F790,$F7BE,$F9E4,$ECDA
            dc.w    $F758,$ECF6,$F8D0,$ED72,$ED70,$F696,$0050,$004E
            dc.w    $F048,$FF6C,$EE14,$EE32,$FD70,$F3BE,$FDFC,$003E
            dc.w    $FC38,$F2B6,$F89E,$F812,$EE90,$EF1E,$F68C,$F64A
            dc.w    $F668,$F912,$F4C0,$F5C4,$FA0A,$FA80,$FBC0,$FE4A
            dc.w    $001C,$FEA6,$FEEE,$FF16,$FB4C,$322E,$3130
SlotManager:
            cmpi.w  #$3D,D0
            bhi.b   .L1
            movea.l ([SDMJmpTblPtr.w],D0.w*4),A1
            jmp     (A1)
.L1:
            move.w  #$FEAE,D0
            rts
            ds.b    6
SINTCORE:
            cmpi.w  #6,(4,A0)
            bne.b   .L1
            ext.w   D0
            cmpi.w  #$E,D0
            bgt.b   .L2
            lea     ([$D04.w],D0.w*4,$40.w),A1
            rts
.L1:
            moveq   #-2,D0
            bra.b   .L3
.L2:
            move.w  #$FEAF,D0
.L3:
            addq.w  #4,SP
            rts
SIntInstall:
            bsr.b   SINTCORE
            move.b  (7,A0),D0
            move    SR,-(SP)
            ori     #$700,SR
.L1:
            move.l  (A1),D1
            beq.b   .L2
            exg     D1,A1
            cmp.b   (7,A1),D0
            bls.b   .L1
            exg     D1,A1
.L2:
            move.l  D1,(A0)
            move.l  A0,(A1)
            move    (SP)+,SR
            moveq   #0,D0
            rts
SIntRemove:
            bsr.b   SINTCORE
            moveq   #-1,D0
            move    SR,-(SP)
            ori     #$700,SR
.L1:
            move.l  (A1),D1
            beq.b   .L2
            exg     D1,A1
            cmpa.l  A0,A1
            bne.b   .L1
            movea.l D1,A1
            move.l  (A0),(A1)
            moveq   #0,D0
.L2:
            move    (SP)+,SR
            rts
SlotInt:
VIA2SLOTINT:
            move.b  #2,($1A00,A1)
            moveq   #-$40,D0
            or.b    ($1E00,A1),D0
            not.l   D0
            bne.b   SlotIntCommon
            rts
RBVSLOTINT:
            move.b  #$82,(3,A1)
            moveq   #-$80,D0
            or.b    (2,A1),D0
            not.l   D0
            and.b   ($12,A1),D0
            bne.b   SlotIntCommon
            rts
OSSSLOTINT:
            moveq   #$3F,D0
            and.b   ($203,A1),D0
            bne.b   SlotIntCommon
            rts
SlotIntCommon:
            subq.l  #4,SP
            move.b  D0,(SP)
.loop:
            move.b  SlotPriority(PC,D0.w),D0
            bclr    D0,(SP)
            lsr.b   #4,D0
            bsr.b   RunSlotHandlers
            bne.b   .noHandler
            move.b  (SP),D0
            bne.b   .loop
            addq.l  #4,SP
            movea.l VIA2,A1
            movea.l ($D74).w,A0
            jmp     (A0)
.noHandler:
            _SysError
RunSlotHandlers:
            lea     ([$D04.w],D0.w*4,$40.w),A1
.RunNext:
            move.l  (A1),D0
            beq.b   .notFound
            movea.l D0,A1
            move.l  A1,-(SP)
            movea.l (8,A1),A0
            movea.l ($C,A1),A1
            jsr     (A0)
            movea.l (SP)+,A1
            tst.w   D0
            beq.b   .RunNext
            moveq   #0,D0
            rts
.notFound:
            moveq   #dsBadSlotInt,D0
            rts
SlotPriority:
            dc.w    $0090,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $E590,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $0690,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $E590,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
InitSDTbl:
            move.l  #$170,D0
            _NewPtrSysClear
            move.l  A0,($D04).w
            lea     ($82,A0),A1
            moveq   #$E,D0
.init:
            move.l  A1,(A0)+
            lea     ($10,A1),A1
            dbra    D0,.init
            moveq   #0,D0
            rts
InitSPTbl:
            rts
            ds.b    10

            EVEN
