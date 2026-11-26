            include "Include/ROMHeader.s"

            EXPORT  BOOTBLOCKFLUSHRETURN,CheckForEgret,DrawBeepScreen,DrawBeepScreenReturn,ForeignOS,GetDefaultStartup
            EXPORT  GetOSDefault,GetVideoDefault,GOOFYDoEject,InitCrsrVars,InitEvents,InitIWM
            EXPORT  InitMemMgr,InitSCC,InitSCSI,InitShutdownMgr,InternalWait,PMSPSwOS
            EXPORT  ResetEntry,SetDefaultStartup,SetOSDefault,SetVideoDefault,SoundInitPatchRtn,StartBoot
            EXPORT  StartInit1,WDCBSwOS

            IMPORT  BacklightPatch,BadTrap,BaseOfROM,BOOTBLOCKFLUSHPATCH,Critical,CrsrCore
            IMPORT  CrsrVBLTask,DisableIntSources,DisableMMUPatch,DoEject,DrawBeepScreenPatch,DTCore
            IMPORT  ECLIPSEEGRETPATCHES,EgretMgr,ElsieTranslate24To32,EMT1010,EnableCachesPatch,EnableExtCache
            IMPORT  ENABLEONESECINTS,ENABLEPARITYPATCH,EnableSlotInts,EnableSWIMIOPInts,FSIODneTbl,GetHardwareInfo
            IMPORT  InitADB,InitADBDrvr,InitDispatcher,INITEGRETALT,InitGestalt,InitHWRoutines
            IMPORT  InitIntHandler,INITIOPMGR,INITMEMDISPANDSHUTDOWNMGRS,InitMemMgrPatch,InitMemVect,InitMMU
            IMPORT  InitMMUGlobals,InitMMUTrap,InitQueue,INITSCSIHW,InitSCSIMgr,InitSDTbl
            IMPORT  InitTimeMgr,InitVBLQs,InitVIAs,INSTALLSONYDRIVERPATCH,JumpIntoROM,MMUCleanupFor8Mb
            IMPORT  NMGNEFILTER,NMInit,POWERDWNPTCH,PowerMngr,PwrCntrlPatch,SCCIOPByPass
            IMPORT  SCCIOPHwInit,SCSIBoots,SetupMiscSCSI,SoundInitPatch,StartSDeclMgr,StartTest1
            IMPORT  SysErrInitPatch,TEGlobalInit,ValidatePRAM,WhichCPUPatch

            SECTION "Part1",CODE

ResetEntry:
            jmp     StartBoot
RomLoc:
            dc.b    $0
            dc.b    $0
            dc.l    $120B50F
            dc.l    $138C8FB
            dc.l    $11EE472
            dc.l    $1388767
            dc.l    1024*1024                       ; Size of ROM
ForeignOS:
            dc.l    InitDispatcher-BaseOfROM
            dc.l    EMT1010-BaseOfROM
            dc.l    BadTrap-BaseOfROM
            dc.l    StartSDeclMgr-BaseOfROM
            dc.l    InitMemVect-BaseOfROM
            dc.l    SwitchMMU-BaseOfROM
SwitchMMU:
            movec   CACR,D0
            move.w  D0,D1
            andi.w  #$FEFE,D0                       ; Clear cache enable bits
            movec   D0,CACR                         ; Disable instruction/data caches
            lea     TCOff,A2
            pmove.l (A2),TC
            pflusha                                 ; Flush translation cache
            pmove.d (theCRP,A0),CRP
            pmove.l (theTC,A0),TC
            ori.w   #$808,D1                        ; Set the flush bits in old cache control register
            movec   D1,CACR
            jmp     (A1)
TCOff:
            dc.w    0
StartBoot:
            move    #$2700,SR
            lea     DisableMMUPatchReturn,A6
            bra.w   DisableMMUPatch
            ds.b    4
DisableMMUPatchReturn:
            reset
            BSR6    JumpIntoROM                     ; Init the hardware
            BigBSR6 PwrCntrlPatch,A0                ; Check to see if we are coming out of sleep
            bra.w   RunDiags
StartInit1:
            moveq   #0,D2
            movem.l D5-D7/A5-A6,-(SP)
            BSR6    GetHardwareInfo                 ; Figure out what we are running on
            movea.l (8,A0),A4
            moveq   #$40,D4
            and.b   (A4),D4
            BSR6    InitVIAs
            cmpi.b  #5,D2
            bne.b   .L1
            moveq   #-$41,D3
            and.b   (A4),D3
            or.b    D4,D3
            move.b  D3,(A4)
.L1:
            movem.l D0-D2/A0-A3,-(SP)
            BigBSR6 ValidatePRAM,A5
            movem.l (SP)+,D0-D2/A0-A3
            movem.l (SP)+,D5-D7/A5-A6
            bsr.w   WhichCPU
            bsr.w   WhichBoard
            bsr.w   ConfigureRAM
            bsr.w   GoToInitMMU
            movea.l (sgTotalRAM,A4),A6
            movea.l A4,A5
            adda.l  (sgAllocOff,A4),A5
            move.l  D0,AddrMapFlags
            move.l  D1,UnivROMFlags
            move.l  A1,UnivInfoPtr
            swap    D2
            move.w  D2,HWCfgFlags
            swap    D2
            bsr.w   SetupHWBases
            bsr.l   InitHWRoutines
            nop
            nop
            nop
            move.l  WarmStart,-(SP)
            move.l  AddrMapFlags,-(SP)
            move.l  UnivROMFlags,-(SP)
            move.l  UnivInfoPtr,-(SP)
            jsr     FlagsPatch
            move.l  (SP)+,UnivInfoPtr
            move.l  (SP)+,UnivROMFlags
            move.l  (SP)+,AddrMapFlags
            move.l  (SP)+,WarmStart
            bsr.w   SetupHWBases
            move.b  D7,CPUFlag
            swap    D7
            move.b  D7,BoxFlag
            move.l  A6,MemTop
            move.l  A5,BufPtr
            move.l  A4,BootGlobPtr
            bsr.w   InitMMUGlobals
            bsr.w   SysErrInitPatch
            nop
            nop
            bsr.w   EnableCachesPatch
            bra.b   .L2
            ds.b    4
.L2:
            bsr.w   EnableExtCache
            BigJsr  DisableIntSources,A0
            bsr.w   SetUpTimeK                      ; Initialize TimeDBRA and TimeSCCDB
            bsr.w   InitHiMemGlobals
; BootRetry
BootRetry:
            move    #$2700,SR
            moveq   #1,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            jsr     InitGlobalVars
            BigJsr  DisableIntSources,A0
            BigJsr  InitIntHandler,A0
            BigJsr  InitDispatcher,A0
            bsr.w   InitMMUTrap
            bra.w   InitEgretPatch
EgretPatchCont:
            bsr.w   InitMemMgrPatch
            btst    #0,MMFlags
            beq.b   .L1
            lea     NewTranslate24To32,A0
            move.l  A0,($644).w
.L1:
            moveq   #0,D0
            _SwapMMUMode
            bsr.w   SetUpSysAppZone
            bsr.w   InitSwitcherTable
            bra.w   INITEGRETPATCH1
EgretPatch1Cont:
            BigJsr  NMInit,A0
            BigJsr  InitTimeMgr,A0
            bsr.w   INITMEMDISPANDSHUTDOWNMGRS
            BigJsr  InitSlots,A0
            bsr.w   InitDTQueue
            BigJsr  ENABLEONESECINTS,A0
            BigJsr  ENABLEPARITYPATCH,A0
            move    #$2000,SR
            bsr.w   InitVidGlobals
            bsr.w   CompBootStack
            movea.l A0,SP
            suba.w  #$2000,A0
            move.b  MMFlags,-(SP)
            btst    #2,MMFlags
            beq.b   .L1
            bset    #0,MMFlags
            bra.b   .L2
.L1:
            bclr    #MMStartMode,MMFlags
.L2:
            _SetApplLimit
            move.b  (SP)+,MMFlags
            lea     DrvQHdr,A1
            BigJsr  InitQueue,A0
            BigJsr  InitSCSIMgr,A0
            bsr.w   InitIOMgr
            BigJsr  InitADB,A0
            bsr.w   InitCrsrMgr
            move.l  #$1BA,D0
            _NewPtrSysClear
            move.l  A0,ExpandMem
            move.w  #$11A,(A0)+
            move.l  #$1BA,(A0)
            BigJsr  InitGestalt,A0
            BigJsr  ECLIPSEEGRETPATCHES,A0
            BigJsr  TEGlobalInit,A0
            movea.l SysZone,A0
            movea.l (A0),A0
            adda.w  #$4000,A0
            _SetAppBase
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  A0,ApplZone
            move.l  (A0),HeapEnd
            lea     ($400,SP),A6
            lea     ($190,SP),A5
            BigJsr  EnableSlotInts,A0
            bsr.w   POWERDWNPTCH
            bsr.b   CheckForResetPRAM
            move.l  #'WLSC',WarmStart
            moveq   #1,D0
            _SwapMMUMode
            movea.l BootGlobPtr,A0
            move.l  #'WLSC',(-4,A0)
            _SwapMMUMode
            BigJsr  SoundInitPatch,A0
SoundInitPatchRtn:
            bra.w   MyBoot
CheckForResetPRAM:
            lea     .Keys,A1
            lea     KeyMap,A0
            moveq   #3,D0
.L1:
            cmpm.l  (A0)+,(A1)+
            dbne    D0,.L1
            beq.b   .L2
            rts
.L2:
            subq.w  #4,SP
            movea.l SP,A0
            move.l  #$400B8,D0
            _ReadXPRam
            movea.l A1,A0
            move.l  (A0)+,D0
            _WriteXPRam
            lea     SPValid,A0
            moveq   #-1,D0
            move.b  D0,(A0)
            _WriteParam
            _InitUtil
            movea.l SP,A0
            move.l  #$400B8,D0
            _WriteXPRam
            jmp     StartBoot
.Keys:
            dc.l    $00800000
            dc.l    $08008004
            dc.l    $00000000
            dc.l    $00000000
            dc.l    $0004000C
            dc.l    'Gone'
            ds.b    2
PATCHSPACE1:
EDISKPATCH2:
            lea     .L1,A1
            move.l  A1,($12,A0)
            _Open
            lea     SNDNAME,A1
            rts
.L1:
            dc.b    6,'.EDisk'
            ds.b    217
JmpTblInit:
            move.l  A0,D0
JmpTbl2:
            moveq   #0,D2
            move.w  (A0)+,D2
            add.l   D0,D2
            move.l  D2,(A1)+
            dbra    D1,JmpTbl2
NewTranslate24To32:
            rts
FillWithOnes:
            move.l  A1,D0
            sub.l   A0,D0
            lsr.l   #2,D0
            moveq   #-1,D1
.L1:
            move.l  D1,(A0)+
            subq.l  #1,D0
            bne.b   .L1
            rts
CompBootStack:
            move.l  BufPtr,D0
            add.l   SysZone,D0
            lsr.l   #1,D0
            bclr    #0,D0
            subi.w  #$400,D0
            movea.l D0,A0
            rts
            ds.b    10
SetUpSysAppZone:
            lea     SysHeap,A0
            move.b  MMFlags,-(SP)
            btst    #2,MMFlags
            beq.b   .do24
            bset    #0,MMFlags
            btst    #4,MMFlags
            beq.b   .knowHeap
            lea     SysHoleHeap,A0
            bra.b   .knowHeap
.do24:
            bclr    #MMStartMode,MMFlags
.knowHeap:
            _InitZone
            move.l  TheZone,SysZone
            move.l  SysZone,RAMBase
            movea.l SysZone,A0
            move.l  A0,ApplZone
            movea.l (A0),A0
            move.l  A0,HeapEnd
            bsr.b   CompBootStack
            cmpa.l  SP,A0
            bls.b   .L3
            movea.l SP,A0
.L3:
            suba.w  #$2000,A0
            _SetApplLimit
            move.b  (SP)+,MMFlags
            rts
SysHeap:
            dc.l    HeapStart
            dc.l    HeapStart+SysZoneSize
            dc.w    2*dfltMasters
            dc.l    0
SysHoleHeap:
            dc.l    HoleSysHeap
            dc.l    HoleSysHeap+SysZoneSize
            dc.w    2*dfltMasters
            dc.l    0
            ds.b    10
DrawBeepScreen:
            pea     (-4,A5)
            _InitGraf
            pea     (-$200,A6)
            _OpenCPort
            movea.l (A5),A2
            pea     (-$6C,A2)
            _SetCursor
            bra.l   DrawBeepScreenPatch
DrawBeepScreenReturn:
            lea     Scratch8,A1
            move.l  A1,-(SP)
            move.l  A1,-(SP)
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            move.l  #$30003,-(SP)
            _PenSize
            move.l  #$160016,-(SP)
            _FrameRoundRect
            _PenNormal
            move.l  #$100010,-(SP)
            pea     (-$18,A2)
            _FillRoundRect
            rts
            dc.w    0
InitShutdownMgr:
            clr.w   -(SP)
            _ShutDown
            rts
            ds.b    10
InitHiMemGlobals:
            move.w  #$FFFF,PWMValue
            movea.l BufPtr,A0
            move.l  MemTop,PhysMemTop
            move.l  A0,RealMemTop
            move.l  ([BootGlobPtr.w],-$18.w),Phys2Log
            moveq   #0,D1
            btst    #0,([BootGlobPtr.w],-$19.w)
            bne.b   .L2
            move.l  #$800000,D0
            cmpa.l  D0,A0
            bls.b   .L1
            movea.l D0,A0
.L1:
            cmp.l   BootGlobPtr,D0
            bgt.b   .L2
            moveq   #1,D1
            bra.b   .L2
            ds.b    12
.L2:
            suba.w  #$2FF,A0
            move.l  A0,PWMBuf1
            move.l  A0,PWMBuf2
            subq.w  #1,A0
            move.l  A0,SoundBase
            move.l  A0,BufPtr
            tst.l   D1
            beq.b   .L3
            bsr.w   MMUCleanupFor8Mb
.L3:
            rts
            dc.w    0
InitGlobalVars:
            lea     BaseOfROM(PC),A0
            move.l  A0,ROMBase
            moveq   #-1,D0
            move.l  D0,SMGlobals
            movea.l UnivInfoPtr,A0
            move.w  ($14,A0),ROM85
            nop
            nop
            nop
            move.l  #$10001,OneOne
            moveq   #-1,D0
            move.l  D0,MinusOne
            move.w  D0,FSFCBLen
            bsr.w   SetupHWBases
            clr.l   PollProc
            clr.l   DSAlertTab
            BigLea  FSIODneTbl,A0
            lea     JFetch,A1
            moveq   #2,D1
            bsr.w   JmpTblInit
            clr.b   DskVerify
            clr.b   LoadTrap
            clr.b   MmInOK
            clr.w   SysEvtMask
            clr.l   JKybdTask
            clr.l   StkLowPt
            lea     VBLQueue,A1
            BigJsr  InitQueue,A0
            clr.l   Ticks
            move.b  #$80,MBState
            clr.l   MBTicks
            clr.l   SysFontFam
            clr.l   WidthTabHandle
            clr.w   TESysJust
            clr.b   WordRedraw
            clr.l   SynListHandle
            move.w  MinusOne,FMExist
            jsr     InitCrsrVars
            clr.w   SysVersion
            bclr    #0,AlarmSt
            BigLea  NMGNEFILTER,A0
            move.l  A0,GNEFilter
            clr.l   IAZNotify
            move.w  #$FF7F,FlEvtMask
            moveq   #-1,D0
            move.w  D0,ChunkyDepth
            move.l  D0,CrsrPtr
            move.l  D0,PortList
            lea     RGBWhite,A0
            move.l  D0,(A0)+
            move.w  D0,(A0)
            lea     RGBBlack,A0
            clr.l   (A0)+
            clr.w   (A0)
            clr.l   LockMemCT
            rts
            ds.b    8
SwitchGoodies:
            dc.w    $0400,$0400,$0E00,$1000,$0B80,$0026,$0BAE,$0052
            dc.w    $0376,$0002,$0384,$0002,$0352,$0004,$02F8,$0002
            dc.w    $0398,$0004,$0D54,$0004,$0100,$0002,$0108,$0014
            dc.w    $015C,$0004,$031E,$0022,$0800,$02FC,$0130,$0004
            dc.w    $02AA,$0004,$0CD0,$0004,$0CD4,$0004,$0B50,$0004
            dc.w    $0D50,$0004,$0B54,$0008,$0CC8,$0004
            ds.b    11
            dc.b    $04
            ds.b    4
WDCBSwOS:
            dc.w    $005C
PMSPSwOS:
            dc.w    $0062
InitSwitcherTable:
            moveq   #$6C,D0
            _NewPtrSysClear
            movea.l A0,A1
            lea     SwitchGoodies,A0
            moveq   #$6C,D0
            _BlockMove
            move.l  A1,SwitcherTPtr
            rts
            ds.b    12
GetPRAM:
            _InitUtil
            moveq   #0,D1
            move.b  SPKbd,D1
            moveq   #$F,D0
            and.w   D1,D0
            bne.b   .L1
            moveq   #$48,D0
.L1:
            add.w   D0,D0
            move.w  D0,KeyRepThresh
            lsr.w   #4,D1
            bne.b   .L2
            move.w  #$1FFF,D1
.L2:
            lsl.w   #2,D1
            move.w  D1,KeyThresh
            move.b  SPClikCaret,D1
            moveq   #$F,D0
            and.b   D1,D0
            lsl.b   #2,D0
            move.l  D0,CaretTime
            lsr.b   #2,D1
            moveq   #$3C,D0
            and.b   D1,D0
            move.l  D0,DoubleTime
            rts
            dc.w    0
WhichCPU:
            moveq   #2,D7
            jmp     .CheckIndexScale-2(PC,D7.w*2)
.CheckIndexScale:
            bra.b   .NoIndexScale
.HasIndexScale:
            bra.w   WhichCPUPatch
            ds.b    14
.NoIndexScale:
            move.l  SP,D7
            clr.w   -(SP)
            bsr.b   .doRTE
            exg     D7,SP
            sub.l   SP,D7
            addq.l  #2,D7
            lsr.l   #1,D7
            rts
.doRTE:
            move    SR,-(SP)
            rte
            dc.w    0
WhichBoard:
            swap    D7
            clr.w   D7
            move.b  ($12,A1),D7
            swap    D7
            rts
            ds.b    4
SetUpTimeK:
            move.l  Lev1AutoVector,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA,A1
            bclr    #5,(vACR,A1)
            move.b  #$FF,(vT2CH,A1)
            move.b  #$A0,(vIER,A1)
            moveq   #$C,D1
            moveq   #3,D2
            movea.l SP,A3
            lea     TimerInt,A0
            move.l  A0,Lev1AutoVector
            lea     TimingTable,A4
.nextRoutine:
            movea.l A4,A0
            adda.w  (A4),A0
            moveq   #2,D0
            lea     .cacheLoaded,A2
            jmp     (A0)
.cacheLoaded:
            movea.l A4,A0
            adda.w  (A4)+,A0
            moveq   #-1,D0
            lea     .timedOut,A2
            andi    #$F8FF,SR
            jmp     (A0)
.timedOut:
            not.w   D0
            movea.w (A4)+,A0
            move.w  D0,(A0)
            tst.w   (A4)
            bne.b   .nextRoutine
            move.b  #$20,($1C00,A1)
            move    (SP)+,SR
            move.l  (SP)+,Lev1AutoVector
            rts
TimerInt:
            tst.b   ($1000,A1)
            movea.l A3,SP
            jmp     (A2)
TimingTable:
            dc.w    $0012,$0D00,$001C,$0D02,$002E,$0B24,$0042,$0CEA
            dc.w    0,$1341,$1000,$1342,$1200,$51C8,$FFFE,$4ED2
            movea.l SCCRd,A0
            move.b  D1,($1000,A1)
            move.b  D2,($1200,A1)
.L2:
            btst    #0,(A0)
            dbra    D0,.L2
            jmp     (A2)
            dc.w    $60FF,0,$38A0
            ds.b    18
            dc.w    $41E9,$1C00,$1341,$1000,$1342,$1200,$0810,0
            dc.w    $51C8,$FFFA,$4ED2
            ds.b    14
RunDiags:
            BigJmp  StartTest1,A0
            ds.b    30
STARTTESTFLAGS:
            ds.b    8
SetupHWBases:
            move.l  AddrMapFlags,D0
            movea.l UnivInfoPtr,A0
            adda.l  (A0),A0
            lea     .BaseInitTable,A2
.loop:
            move.w  (A2)+,D3
            bmi.b   .exit
            movea.w (A2)+,A3
            btst    D3,D0
            beq.b   .loop
            lsl.w   #2,D3
            move.l  (0,A0,D3.w),(A3)
            bra.b   .loop
.exit:
            bra.l   SetupMiscSCSI
            ds.b    20
.BaseInitTable:
            dc.w    VIA1Exists,VIA
            dc.w    SCCRdExists,SCCRd
            dc.w    SCCWrExists,SCCWr
            dc.w    SCCIOPExists,SCCRd
            dc.w    SCCIOPExists,SCCWr
            dc.w    $0005,$01E0,$0010,$01E0,$0006,$0B0A
            dc.w    $0006,$0312,$0007,$0266,$0008,$0C00,$0009,$0C04
            dc.w    $000A,$0C08,$000B,$0CEC,$000C,$0CC0,$000D,$0CEC
            dc.w    $000F,$0C00,$000F,$0C04,$000F,$0C08,$0012,$0CEC
            dc.w    -1
            ds.b    4
InitSCSI:
            bra.l   INITSCSIHW
            ds.b    26
InitIWM:
            btst    #IWMExists,(AddrMapFlags+3).w   ; TestFor IWMExists
            beq.b   .ExitInitIWM
            movea.l IWM,A0
            moveq   #IWMInitMode,D0
.L1:
            move.b  #$BE,(wZeroes,A0)
            move.b  #$F8,(wZeroes,A0)
            tst.b   (q7L,A0)
            tst.b   (mtrOff,A0)
            tst.b   (q6H,A0)
            move.b  (q7L,A0),D2
            btst    #5,D2
            bne.b   .L1
            and.b   D0,D2
            cmp.b   D0,D2
            beq.b   .L2
            move.b  D0,(q7H,A0)
            tst.b   (q7L,A0)
            bra.b   .L1
.L2:
            tst.b   (q6L,A0)
.ExitInitIWM:
            rts
            ds.b    10
SCCInitTbl:
            dc.w    $09C0,$0940,$044C,$0200,$03C0,$0F00,$0010,$0010
            dc.w    $0100,$0980,$044C,$03C0,$0F00,$0010,$0010,$0100
InitSCC:
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .NoIOP
            jsr     (SCCIOPHwInit.w,PC)
.NoIOP:
            movea.l SCCWr,A0
            movea.l SCCRd,A1
            nop
            lea     SCCInitTbl,A2
            moveq   #$12,D1
            bsr.b   sub_40800A54
            addq.w  #2,A0
            addq.w  #2,A1
            moveq   #$E,D1
sub_40800A54:
            move.b  (A1),D2
            bra.b   .L2
.L1:
            move.l  (SP),(SP)
            move.l  (SP),(SP)
            move.b  (A2)+,(A0)
.L2:
            dbra    D1,.L1
            rts
            ds.b    12
ConfigureRAM:
            movea.l (SP)+,SP
            move.l  (4,A6),D3
            cmpi.l  #$200000,D3
            bge.b   .plentyORam
            lsr.l   #2,D3
            mulu.l  #3,D3
            bra.b   .stakOk
.plentyORam:
            move.l  #$180000,D3
.stakOk:
            exg     D3,SP
            adda.l  (A6),SP
            move.l  D3,-(SP)
            movea.l A6,A3
.L2:
            movea.l A3,A2
            move.l  (A3)+,D3
.L3:
            add.l   (A3)+,D3
            cmp.l   (A3)+,D3
            beq.b   .L3
            sub.l   (A2)+,D3
            move.l  D3,(A2)+
            subq.l  #4,A3
            cmpi.l  #$FFFFFFFF,(A3)
            bne.b   .L2
            move.l  (A3),(A2)+
.L4:
            clr.l   (A2)+
            move.w  A2,D3
            bne.b   .L4
            suba.l  A6,A2
            move.l  A2,(-8,A6)
            rts
            ds.b    288
InitVidGlobals:
            rts
            dc.w    $4E75
            ds.b    12
RdVidParam:
            movem.l D3/A1-A2,-(SP)
            move.b  ($32,A0),D3
            clr.b   ($33,A0)
            _sRsrcInfo
            bne.w   .L1
            _sFindDevBase
            bne.w   .L1
            move.l  (A0),ScrnBase
            move.b  #$B,($32,A0)
            _sReadLong
            bne.w   .L1
            move.l  (A0),ScreenBytes
            move.b  D3,($32,A0)
            bsr.w   GetDefVidMode
            move.b  D0,($32,A0)
            _sFindStruct
            bne.w   .L1
            move.b  #1,($32,A0)
            _sGetBlock
            bne.w   .L1
            movea.l (A0),A1
            move.w  ($A,A1),ColLines
            move.w  ($C,A1),RowBits
            move.w  (4,A1),D0
            move.w  D0,ScreenRow
            move.w  D0,CRSRROW
            move.w  ($1A,A1),ScrVRes
            move.w  ($16,A1),ScrHRes
            move.l  (A1),D0
            add.l   D0,ScrnBase
            move.l  ScrnBase,CRSRBASE
            moveq   #0,D0
            move.b  ($31,A0),D0
            _AttachVBL
            move.l  #videoMagic,VideoInfoOK
            move.l  A1,(4,A0)
            _sDisposePtr
            moveq   #0,D0
            bra.b   .L2
.L1:
            moveq   #1,D0
.L2:
            move.b  D3,($32,A0)
            movem.l (SP)+,D3/A1-A2
            tst.w   D0
            rts
OpensDrvr:
            move.l  A2,-(SP)
            suba.w  #$18,SP
            movea.l SP,A2
            move.l  A2,($14,A0)
            suba.w  #$100,SP
            move.l  SP,(A0)
            _sReadDrvrName
            bne.b   .L1
            move.l  (A0),($C,A2)
            move.b  ($31,A0),(A2)
            move.b  ($32,A0),(1,A2)
            clr.b   ($10,A2)
            move.l  ($C,A2),($12,A1)
            clr.l   ($1C,A1)
            clr.w   ($20,A1)
            bset    #0,($21,A1)
            move.l  A2,($22,A1)
            clr.b   ($1B,A1)
            exg     A0,A1
            _HOpen
            exg     A0,A1
.L1:
            lea     ($118,SP),SP
            movea.l (SP)+,A2
            rts
            ds.b    12
OpnVidDeflt:
            movea.l A0,A2
            subq.w  #2,SP
            movea.l SP,A0
            _GetVideoDefault
            move.b  (A0)+,($31,A2)
            move.b  (A0)+,($32,A2)
            addq.w  #2,SP
            movea.l A2,A0
            clr.b   ($33,A0)
            _sRsrcInfo
            bne.b   .L1
            cmpi.l  #$30001,($28,A0)
            bne.b   .L1
            cmpi.w  #1,($2C,A0)
            bne.b   .L1
            bsr.w   RdVidParam
            bne.b   .L1
            bsr.w   OpensDrvr
            bne.b   .L1
            bsr.w   InitVidDeflt
.L1:
            rts
            ds.b    14
InitVidDeflt:
            movem.l D1-D2/A0-A1,-(SP)
            clr.l   -(SP)
            move.w  ($18,A1),-(SP)
            bsr.w   GetDefVidMode
            move.l  D0,-(SP)
            _NewGDevice
            movea.l (SP)+,A0
            move.l  A0,TheGDevice
            move.l  A0,DeviceList
            move.l  A0,MainDevice
            move.l  A0,SrcDevice
            move.l  A0,CrsrDevice
            movea.l (A0),A1
            ori.w   #$B800,($14,A1)
            jsr     InitDefGamma
            movem.l (SP)+,D1-D2/A0-A1
            moveq   #0,D0
            rts
            ds.b    4
AddVidDevice:
            movem.l D1-D2/A0-A3,-(SP)
            move.w  ($18,A1),D1
            move.l  DeviceList,D0
.L1:
            movea.l D0,A2
            movea.l (A2),A3
            cmp.w   (A3),D1
            beq.b   .L2
            move.l  ($1E,A3),D0
            bne.b   .L1
            clr.l   -(SP)
            move.w  ($18,A1),-(SP)
            bsr.w   GetDefVidMode
            move.l  D0,-(SP)
            _NewGDevice
            movea.l (A2),A0
            move.l  (SP),($1E,A0)
            movea.l (SP),A0
            movea.l (A0),A0
            ori.w   #$2000,($14,A0)
            movea.l (SP)+,A0
            jsr     InitDefGamma
.L2:
            movem.l (SP)+,D1-D2/A0-A3
            moveq   #0,D0
            rts
            ds.b    10
GetDefVidMode:
            move.l  (4,A0),-(SP)
            move.b  ($32,A0),-(SP)
            move.l  A1,-(SP)
            subq.w  #8,SP
            movea.l SP,A1
            move.l  A1,(A0)
            _sReadPRAMrec
            bne.b   .L1
            clr.b   ($33,A0)
            _sRsrcInfo
            bne.w   .L1
            move.b  (2,A1),($32,A0)
            _sFindStruct
            bne.b   .L1
            moveq   #0,D0
            move.b  (2,A1),D0
            bra.b   .L2
.L1:
            move.b  #$80,(2,A1)
            move.l  A1,(4,A0)
            _sPutPRAMRec
            move.l  #$80,D0
.L2:
            addq.w  #8,SP
            movea.l (SP)+,A1
            move.b  (SP)+,($32,A0)
            move.l  (SP)+,(4,A0)
            rts
            ds.b    8
InitDefGamma:
            link.w  A6,#-$4C
            movem.l A2-A3,-(SP)
            movea.l A0,A2
            movea.l (A2),A0
            move.w  (A0),D0
            not.w   D0
            movea.l UTableBase,A0
            movea.l (0,A0,D0.w*4),A0
            movea.l (A0),A0
            suba.w  #$38,SP
            move.b  ($28,A0),($31,SP)
            movea.l SP,A0
            clr.w   ($32,A0)
            move.w  #3,($28,A0)
            move.w  #1,($2A,A0)
            move.w  #1,($2C,A0)
            move.b  #1,($30,A0)
            _sNextTypesRsrc
            bne.w   .L4
            cmpi.w  #1,($2E,A0)
            beq.w   .L2
            move.b  #$40,($32,A0)
            _sFindStruct
            bne.w   .L4
            move.b  #$80,($32,A0)
            _sReadPBSize
            bne.b   .L4
            movea.l A0,A3
            move.l  (8,A0),D0
            _NewHandle
            bne.b   .L4
            _HLock
            exg     A0,A3
            movea.l (A3),A1
            move.l  A1,(A0)
            subq.w  #4,(8,A0)
            _sReadStruct
            bne.b   .L4
            movea.l (A0),A0
            addq.w  #2,A0
.L1:
            tst.b   (A0)+
            bne.b   .L1
            move.l  A0,D0
            addq.l  #1,D0
            andi.b  #$FE,D0
            movea.l D0,A0
            bra.b   .L3
.L2:
            subq.w  #4,SP
            move.l  #'gama',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP),-(SP)
            _DetachResource
            movea.l (SP)+,A0
            _HLock
            movea.l A0,A3
            movea.l (A0),A0
.L3:
            lea     (-$4C,A6),A1
            move.l  A0,(A1)
            lea     (-$40,A6),A0
            move.l  A1,($1C,A0)
            move.w  #4,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A2),A1
            move.w  (A1),($18,A0)
            _Control immed
            movea.l A3,A0
            _HUnlock
            _DisposHandle
.L4:
            lea     ($38,SP),SP
            movem.l (SP)+,A2-A3
            unlk    A6
            rts
            ds.b    14
InitDummyScreen:
            moveq   #$20,D0
            move.w  D0,ColLines
            move.w  D0,RowBits
            moveq   #4,D1
            move.w  D1,ScreenRow
            move.w  D1,CRSRROW
            mulu.w  D1,D0
            move.l  D0,ScreenBytes
            _NewPtr
            move.l  A0,ScrnBase
            move.l  A0,IconTLAddr
            move.l  A0,CRSRBASE
            moveq   #$48,D0
            move.w  D0,ScrHRes
            move.w  D0,ScrVRes
            clr.l   -(SP)
            clr.w   -(SP)
            moveq   #-1,D0
            move.l  D0,-(SP)
            _NewGDevice
            movea.l (SP)+,A0
            move.l  A0,TheGDevice
            move.l  A0,DeviceList
            move.l  A0,MainDevice
            move.l  A0,SrcDevice
            move.l  A0,CrsrDevice
            movea.l (A0),A1
            move.w  #$FC00,($14,A1)
            move.w  #4,($A,A1)
            movea.l ($16,A1),A0
            movea.l (A0),A0
            move.l  ScrnBase,(A0)
            move.w  ScreenRow,(4,A0)
            moveq   #$20,D0
            move.w  D0,($C,A0)
            move.w  D0,($A,A0)
            move.w  D0,($28,A1)
            move.w  D0,($26,A1)
            moveq   #$48,D0
            swap    D0
            move.l  D0,($16,A0)
            move.l  D0,($1A,A0)
            moveq   #1,D0
            move.w  D0,($20,A0)
            move.w  D0,($22,A0)
            move.w  D0,($24,A0)
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            moveq   #1,D1
            move.l  D1,(A0)+
            move.l  D1,(A0)+
            clr.w   (A0)+
            moveq   #-1,D0
            move.l  D0,(A0)+
            move.w  D0,(A0)+
            swap    D1
            move.l  D1,(A0)+
            clr.l   (A0)+
            rts
            ds.b    8
FROVideo:
            movea.l A0,A1
            link.w  A6,#-$38
            movea.l SP,A0
            bsr.w   OpnVidDeflt
            beq.b   .End
            move.l  #$30001,($28,A0)
            move.w  #1,($2C,A0)
            move.b  #1,($30,A0)
            clr.b   ($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
.NextVidsRsrc:
            _sNextTypesRsrc
            beq.b   .L2
            bsr.w   InitDummyScreen
            bra.b   .End
.L2:
            bsr.w   RdVidParam
            bne.b   .NextVidsRsrc
            bsr.w   OpensDrvr
            bne.b   .NextVidsRsrc
            bsr.w   InitVidDeflt
            bne.b   .NextVidsRsrc
.End:
            unlk    A6
            rts
InitCrsrVars:
            lea     GrafBegin,A0
            lea     GrafEnd,A1
.L1:
            clr.w   (A0)+
            cmpa.l  A1,A0
            bcs.b   .L1
            rts
InitCrsrMgr:
            move.l  #$F000F,D0
            lea     MTemp,A0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            clr.l   (A0)+
            move.w  ColLines,(A0)+
            move.w  RowBits,(A0)
            moveq   #$1C,D0
            _NewPtrSys
            move.l  A0,MickeyBytes
            move.w  #1,(A0)
            move.w  #8,(2,A0)
            clr.w   ($12,A0)
            lea     .L1,A1
            lea     ($14,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)
            lea     GrafEnd,A1
            BigLea  CrsrVBLTask,A0
            move.l  A0,-(A1)
            move.w  #6,-(A1)
            BigLea  CrsrCore,A0
            lea     GrafBegin,A1
            moveq   #7,D1
            bsr.w   JmpTblInit
            lea     JAllocCrsr,A1
            moveq   #1,D1
            bsr.w   JmpTbl2
            lea     ($DA0).w,A0
            move.l  #$60082,D0
            _ReadXPRam
            moveq   #-1,D0
            move.w  D0,CrsrNew
            move.l  D0,MouseMask
            rts
.L1:
            dc.w    $040A,$0FFF,$FF53,$4D48,0
InitIOMgr:
            bsr.w   INITIOPMGR
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            BigJsr  EnableSWIMIOPInts,A0
.L1:
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .L2
            bsr.w   SCCIOPByPass
.L2:
            moveq   #$40,D0
            move.w  D0,UnitNtryCnt
            move.l  #$80,D0
            asl.l   #2,D0
            _NewPtrSysClear
            move.l  A0,UTableBase
            suba.w  #$32,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     .L5,A1
            jsr     PATCHSPACE2
            nop
            jsr     PATCHSPACE1
            move.l  A1,($12,A0)
            _Open
            movea.l SonyVars,A1
            move.l  ($130,A1),-(SP)
            bsr.w   FROVideo
            move.l  (SP)+,D0
            cmpi.b  #3,BoxFlag
            bne.b   .L3
            movea.l SonyVars,A1
            move.l  D0,($130,A1)
.L3:
            lea     ($32,SP),SP
            bsr.l   BacklightPatch
            nop
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L4
            movea.l D0,A0
            movea.l (A0),A0
            jsr     (A0)
.L4:
            rts
.L5:
            dc.b    5,'.Sony'
SNDNAME:
            dc.b    6,'.Sound'
            dc.b    $20
            ds.b    14
InitMemMgr:
            move.l  #$FFFFFF,Lo3Bytes
            move.l  #$400,MinStack
            move.l  #$6000,DefltStack
            clr.w   MMDefFlags
            BigJsr  InitMemVect,A0
            rts
            ds.b    8
InitRsrcMgr:
            st      SysMap
            clr.l   TopMapHndl
            move.b  MMFlags,-(SP)
            bset    #0,MMFlags
            clr.w   -(SP)
            _InitResources
            addq.w  #2,SP
            move.b  (SP)+,MMFlags
            rts
            dc.w    0
InitDTQueue:
            lea     DTQueue,A1
            BigJsr  InitQueue,A0
            BigLea  DTCore,A1
            move.l  A1,JDTInstall
            rts
            dc.w    0
InitSlots:
            BigJsr  InitSDTbl,A0
            BigJsr  InitVBLQs,A0
            jsr     (StartSDeclMgr.w,PC)
            beq.b   .L1
            move.l  D0,D6
            moveq   #$1F,D7
            bra.w   Critical
.L1:
            rts
            ds.b    12
GOOFYDoEject:
            BigJmp  DoEject,A0
            ds.b    6
PATCHSPACE2:
OPENNETBOOTPATCH:
            bsr.l   INSTALLSONYDRIVERPATCH
            move.l  A0,-(SP)
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            pea     .L2
            _GetNamedResource
            tst.l   (SP)+
            movea.l (SP)+,A0
            beq.b   .L1
            lea     .L2,A1
            move.l  A1,($12,A0)
            _Open
.L1:
            rts
.L2:
            dc.b    8,'.netBOOT'
            dc.b    $00
FMCPARITYPATCH:
            move.w  #$F3EF,D5
            btst    #$14,D0
            beq.b   .L1
            move.w  #$F3FF,D5
.L1:
            rts
FlagsPatch:
            move.w  HWCfgFlags,-(SP)
            lea     SysCom,A0
            lea     ($2000).w,A1
            bsr.w   FillWithOnes
            move.w  (SP)+,HWCfgFlags
            rts
InitEgretPatch:
            jsr     CheckForEgret
            bne.b   .L1
            suba.w  #$4C,SP
            movea.l SP,A0
            BigJsr  INITEGRETALT,A1
.L1:
            bsr.w   GetPRAM
            btst    #7,($DD7).w                     ; TestFor V8ChipBit
            beq.b   .L2
            BigLea  ElsieTranslate24To32,A0
            move.l  A0,($644).w
.L2:
            jmp     EgretPatchCont
            ds.b    4
INITEGRETPATCH1:
            bsr.l   PowerMngr
            jsr     CheckForEgret
            bne.b   .L1
            lea     ($4C,SP),SP
            bsr.l   EgretMgr
.L1:
            bsr.w   InitRsrcMgr
            jmp     EgretPatch1Cont
            dc.w    0
GoToInitMMU:
            BigJmp  InitMMU,A4
CLOSENETBOOTPATCH:
            lea     (-$400,A6),A0
            move.w  #$FFCE,($18,A0)
            _Close
            moveq   #-1,D0
            move.l  D0,($D1C).w
            move.l  D0,LAPMgrPtr
            bra.w   BootRetry
CheckForEgret:
            moveq   #$E,D0
            and.l   UnivROMFlags,D0
            subq.l  #6,D0
            beq.b   .L1
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            cmpi.b  #$20,D0
.L1:
            rts
            ds.b    22
FindStartupDevice:
            bsr.w   EmbarkOnSearch
            bsr.w   LoadSlotDrvrs
            bsr.w   LoadDrivers
            bsr.w   WaitForInternal
            bra.b   .L3
.L1:
            bsr.w   PlanStrategy
            bsr.w   LoadDrivers
.L2:
            bsr.w   VisualUpdate
.L3:
            bsr.w   FindNextCandidate
            beq.b   .L1
            bsr.w   SelectDevice
            bsr.w   CheckMouseEject
            beq.b   .L2
            bsr.w   GetStartupInfo
            beq.b   .L4
            bsr.w   ReactToFailure
            bra.b   .L2
.L4:
            bra.w   ShowSuccess
            dc.w    0
GetDefaultStartup:
            move.l  #$40078,D0
            _ReadXPRam
            rts
            ds.b    6
SetDefaultStartup:
            move.l  #$40078,D0
            _WriteXPRam
            rts
            ds.b    6
GetOSDefault:
            move.l  #$20076,D0
            _ReadXPRam
            rts
            ds.b    6
SetOSDefault:
            cmpi.l  #$9961010,SetOSPassword
            bne.b   .L1
            clr.l   SetOSPassword
            move.l  #$20076,D0
            _WriteXPRam
            rts
.L1:
            clr.l   SetOSPassword
            moveq   #-1,D0
            rts
GetVideoDefault:
            move.l  #$20080,D0
            _ReadXPRam
            rts
            ds.b    6
SetVideoDefault:
            move.l  #$20080,D0
            _WriteXPRam
            rts
            ds.b    6
InternalWait:
            move.l  A0,D1
            cmpi.w  #9,D1
            bhi.b   .L1
            add.w   D1,D1
            lea     .L2,A1
            move.w  (0,A1,D1.w),D1
            jsr     (0,A1,D1.w)
.L1:
            rts
.L2:
            dc.w    $07E8,$07F8,$0818,$0828,$0848,$0868,$0888,$08A8
            ds.b    8
EmbarkOnSearch:
            subq.w  #4,SP
            movea.l SP,A0
            _GetDefaultStartup
            move.w  (SP)+,D3
            move.w  (SP)+,D4
            subq.w  #2,SP
            movea.l SP,A0
            _GetOSDefault
            swap    D3
            move.w  (SP)+,D3
            swap    D3
            suba.l  A2,A2
            lea     IsItFlopOrDef,A3
            tst.w   D4
            bne.b   .L1
            lea     IsItAnything,A3
.L1:
            movea.l Ticks,A4
            clr.w   D6
            rts
            ds.b    4
WaitForInternal:
            movem.l D5/A2,-(SP)
            movea.w #2,A0
            _InternalWait
            andi.b  #$80,D0
            bne.b   .L8
            suba.l  A0,A0
            _InternalWait
            bne.b   .L1
            moveq   #$14,D0
.L1:
            mulu.w  #$3C,D0
            move.l  D0,D5
            movea.w #6,A0
            _InternalWait
.L2:
            move.w  ($17A).w,D0
            cmpi.w  #$8805,D0
            beq.b   .L8
            moveq   #7,D1
            and.b   SCSIPoll,D1
            moveq   #0,D0
            bset    D1,D0
            move.l  A0,-(SP)
            BigJsr  SCSIBoots,A0
            movea.l (SP)+,A0
            beq.b   .L7
            suba.l  A2,A2
            moveq   #-$21,D0
            sub.w   D1,D0
            move.w  D0,D1
.L3:
            bsr.w   NextDQEntry
            beq.b   .L4
            cmp.w   (8,A2),D1
            bne.b   .L3
            bra.b   .L7
.L4:
            cmp.l   Ticks,D5
            bcs.b   .L6
            moveq   #$F,D0
            add.l   Ticks,D0
.L5:
            cmp.l   Ticks,D0
            bcc.b   .L5
            bra.b   .L2
.L6:
            movea.w #4,A0
            _InternalWait
.L7:
            movea.w #7,A0
            _InternalWait
.L8:
            movem.l (SP)+,D5/A2
            rts
            ds.b    12
LoadSlotDrvrs:
            tst.w   D4
            ble.b   .L3
            suba.w  #$38,SP
            movea.l SP,A0
            suba.w  #$18,SP
            movea.l SP,A1
            move.l  A1,($14,A0)
            move.b  D4,($32,A0)
            lsr.w   #8,D4
            move.b  D4,($31,A0)
            _sFindsRsrcPtr
            bne.b   .L1
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            move.l  D3,D0
            move.b  D0,($11,A1)
            lsr.l   #8,D0
            move.b  D0,($10,A1)
            lsr.l   #8,D0
            move.b  D0,($12,A1)
            lsr.l   #8,D0
            move.b  D0,($13,A1)
            clr.b   ($16,A1)
            move.b  #6,($32,A0)
            _sExec
            bne.b   .L1
            tst.w   (2,A1)
            bne.b   .L1
            move.w  ($14,A1),D4
            bra.b   .L2
.L1:
            clr.w   D4
.L2:
            lea     ($50,SP),SP
.L3:
            rts
            ds.b    6
LoadDrivers:
            moveq   #-1,D0
            cmpi.w  #$8805,($17A).w
            bne.b   .L1
            moveq   #7,D1
            and.b   SCSIPoll,D1
            bclr    D1,D0
.L1:
            move.l  A0,-(SP)
            BigJsr  SCSIBoots,A0
            movea.l (SP)+,A0
            rts
            ds.b    14
PlanStrategy:
            cmpi.w  #$FFFB,D4
            beq.b   .L1
            lea     IsItAnything,A3
.L1:
            rts
            ds.b    4
FindNextCandidate:
            bsr.w   NextDQEntry
            beq.b   .L1
            bsr.w   IsReject
            beq.b   FindNextCandidate
            jsr     (A3)
            bne.b   FindNextCandidate
.L1:
            move.l  A2,D0
            rts
            ds.b    12
NextDQEntry:
            move.l  A2,D0
            bne.b   .L1
            movea.l ($30A).w,A2
            bra.b   .L2
.L1:
            movea.l (A2),A2
.L2:
            move.l  A2,D0
            rts
SelectDevice:
            lea     (-$400,A6),A0
            move.w  (8,A2),D0
            move.w  D0,($18,A0)
            move.w  D0,BtDskRfn
            move.w  (6,A2),D0
            move.w  D0,($16,A0)
            move.w  D0,BootDrive
            rts
            dc.w    0
CheckMouseEject:
            tst.b   MBState
            bmi.b   .L1
            bsr.w   EjectMe
.L1:
            rts
            ds.b    4
GetStartupInfo:
            move.w  #1,($2C,A0)
            clr.l   ($2E,A0)
            move.l  A6,($20,A0)
            move.l  #$400,($24,A0)
            bra.l   BOOTBLOCKFLUSHPATCH
            dc.w    $0200
BOOTBLOCKFLUSHRETURN:
            rts
ReactToFailure:
            cmpi.w  #$FFBF,D0
            beq.b   .L3
            cmpi.w  #$FFC0,D0
            beq.b   .L1
            bsr.w   EjectMe
            beq.b   .L2
.L1:
            bsr.w   NeverAgain
.L2:
            bsr.w   ShowDeviceFail
.L3:
            rts
            ds.b    4
VisualUpdate:
            bset    #8,D6
            beq.b   .L4
            cmpa.l  Ticks,A4
            bhi.b   .L4
            movea.l Ticks,A4
            lea     ($3C,A4),A4
            bclr    #$A,D6
            beq.b   .L1
            move.b  #3,D6
.L1:
            bchg    #9,D6
            bne.b   .L2
            bsr.w   ShowPlainDisk
            bra.b   .L4
.L2:
            tst.b   D6
            beq.b   .L3
            bsr.w   ShowDiskX
            subq.b  #1,D6
            bra.b   .L4
.L3:
            bsr.w   ShowDiskQ
.L4:
            rts
EnableXFlash:
            bset    #$A,D6
            rts
            ds.b    14
ShowDeviceFail:
            bsr.w   IsItFloppy
            bne.b   .L1
            bsr.b   EnableXFlash
.L1:
            rts
            ds.b    6
ShowSuccess:
            _HideCursor
            movem.l A5-A6,-(SP)
            BSR6    HappyMac
            movem.l (SP)+,A5-A6
            rts
            ds.b    12
EjectMe:
            lea     (-$400,A6),A0
            move.w  #7,($1A,A0)
            _Control
            rts
            dc.w    0
IsReject:
            bsr.w   InBootMask
            bne.b   .L1
            move.w  (6,A2),D1
            move.w  BootMask,D0
            btst    D1,D0
.L1:
            rts
            ds.b    14
IsItFlopOrDef:
            cmp.w   (8,A2),D4
            bne.b   IsItFloppy
            rts
            ds.b    8
IsItFloppy:
            cmpi.w  #$FFFB,(8,A2)
            rts
            ds.b    8
IsItAnything:
            cmp.w   D0,D0
            rts
            ds.b    12
NeverAgain:
            bsr.w   InBootMask
            bne.b   .L1
            move.w  (6,A2),D1
            move.w  BootMask,D0
            bclr    D1,D0
            move.w  D0,BootMask
.L1:
            rts
            ds.b    10
InBootMask:
            cmpi.w  #$F,(6,A2)
            bhi.b   .L1
            moveq   #0,D0
.L1:
            rts
            ds.b    4
HappyMac:
            bsr.w   EraseMyIcon
            lea     EraseMyIcon.L1,A0
            bsr.b   PlotMyIcon
            RTS6
ShowPlainDisk:
            lea     EraseMyIcon.L2,A0
            bra.b   PlotMyIcon
ShowDiskQ:
            lea     EraseMyIcon.L3,A0
            bra.b   PlotMyIcon
ShowDiskX:
            lea     EraseMyIcon.L4,A0
PlotMyIcon:
            move.l  A0,-(SP)
            bsr.b   PshIcnRect
            move.l  SP,-(SP)
            move.l  ($C,SP),-(SP)
            bsr.b   PlotIcnn
            lea     ($C,SP),SP
            rts
PshIcnRect:
            movea.l (SP)+,A1
            move.l  #$200020,-(SP)
            clr.l   -(SP)
            movea.l (A5),A0
            pea     (-$74,A0)
            pea     (4,SP)
            move.l  A1,-(SP)
            bra.w   CenterRect
PlotIcnn:
            movem.l (SP)+,D0-D2
            move.l  D0,-(SP)
            movea.l SP,A0
            move.l  #$200020,-(SP)
            clr.l   -(SP)
            move.w  #4,-(SP)
            move.l  D1,-(SP)
            move.l  -(A0),-(SP)
            move.l  -(A0),-(SP)
            move.w  -(A0),-(SP)
            movea.l -(A0),A1
            pea     ($80,A1)
            move.l  A0,-(SP)
            pea     (4,SP)
            movea.l (A5),A1
            movea.l (A1),A1
            pea     (2,A1)
            pea     (6,A0)
            pea     ($16,SP)
            move.l  D2,-(SP)
            _CopyMask
            lea     ($1C,SP),SP
            rts
EraseMyIcon:
            movem.l D0-D2/A0-A1,-(SP)
            bsr.b   PshIcnRect
            move.l  SP,-(SP)
            movea.l (A5),A0
            pea     (-$18,A0)
            _FillRect
            addq.w  #8,SP
            movem.l (SP)+,D0-D2/A0-A1
            rts
.L1:
            dc.w    $07FF,$FFC0,$0800,$0020,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1211,$1090
            dc.w    $1211,$1090,$1201,$0090,$1201,$0090,$1203,$0090
            dc.w    $1200,$0090,$1208,$4090,$1207,$8090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$0FFF,$FFE0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $07FF,$FFC0,$0FFF,$FFE0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0
.L2:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$8800,$0011
            dc.w    $8800,$0011,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
.L3:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8807,$E011,$880F,$F011,$880C,$3011
            dc.w    $880C,$3011,$8800,$7011,$8800,$E011,$8801,$C011
            dc.w    $8801,$8011,$8801,$8011,$8800,$0011,$8801,$8011
            dc.w    $8801,$8011,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
.L4:
            dc.w    $7FFF,$FFF0,$8100,$0108,$8100,$7104,$8100,$8902
            dc.w    $8100,$8901,$8100,$8901,$8100,$8901,$8100,$8901
            dc.w    $8100,$7101,$8100,$0101,$80FF,$FE01,$8000,$0001
            dc.w    $8000,$0001,$8000,$0001,$87FF,$FFE1,$8800,$0011
            dc.w    $8800,$0011,$8810,$0811,$8838,$1C11,$881C,$3811
            dc.w    $880E,$7011,$8807,$E011,$8803,$C011,$8803,$C011
            dc.w    $8807,$E011,$880E,$7011,$881C,$3811,$8838,$1C11
            dc.w    $8810,$0811,$8800,$0011,$8800,$0011,$FFFF,$FFFE
            dc.w    $7FFF,$FFF0,$FFFF,$FFF8,$FFFF,$FFFC,$FFFF,$FFFE
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFE
            ds.b    14
iGetTimeOut:
            jsr     GetRawTimeout
            andi.b  #$1F,D0
            rts
            ds.b    6
iSetTimeOut:
            move.b  D0,-(SP)
            jsr     GetRawTimeout
            move.b  (SP)+,D1
            cmpi.b  #$1F,D1
            bls.b   .L1
            moveq   #$1F,D1
.L1:
            andi.b  #$E0,D0
            or.b    D1,D0
            jmp     SetRawTimeout
            ds.b    6
iGetWaitFlags:
            jsr     GetRawTimeout
            andi.b  #$E0,D0
            rts
            ds.b    6
iSetWaitFlags:
            move.b  D0,-(SP)
            jsr     GetRawTimeout
            move.b  (SP)+,D1
            andi.b  #$E0,D1
            andi.b  #$1F,D0
            or.b    D1,D0
            jmp     SetRawTimeout
            ds.b    10
iDisableDynWait:
            movea.w #2,A0
            _InternalWait
            bset    #7,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iEnableDynWait:
            movea.w #2,A0
            _InternalWait
            bclr    #7,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iDisablePermWait:
            movea.w #2,A0
            _InternalWait
            bset    #6,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
iEnablePermWait:
            movea.w #2,A0
            _InternalWait
            bclr    #6,D0
            movea.w #3,A0
            _InternalWait
            rts
            ds.b    14
GetRawTimeout:
            clr.b   -(SP)
            movea.l SP,A0
            move.l  #$10001,D0
            _ReadXPRam
            moveq   #0,D0
            move.b  (SP)+,D0
            rts
            ds.b    14
SetRawTimeout:
            move.b  D0,-(SP)
            movea.l SP,A0
            move.l  #$10001,D0
            _WriteXPRam
            move.b  (SP)+,D0
            rts
MyBoot:
BootMe:
            bsr.w   FindStartupDevice
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  A0,ApplZone
            move.l  (A0),HeapEnd
            move.b  (6,A6),D1
            cmpi.b  #$44,D1
            beq.b   .L1
            andi.b  #$C0,D1
            cmpi.b  #$C0,D1
            bne.b   .L2
.L1:
            jsr     (2,A6)
.L2:
            move.w  ($7C,A6),D0
            _InitEvents
            move.w  ($7A,A6),D0
            _InitFS
            lea     (-$400,A6),A0
            move.w  BootDrive,($16,A0)
            _MountVol
            bne.w   .L27
            clr.l   ($12,A0)
            clr.w   ($1C,A0)
            _HGetVInfo
            bne.b   .L3
            movea.l ($5E,A0),A4
            move.l  ($5A,A0),D0
            bsr.w   sub_40802142
.L3:
            lea     SysResName,A1
            lea     ($A,A6),A0
            moveq   #$10,D0
            _BlockMove
            subq.w  #2,SP
            clr.l   ResErrProc
            _InitResources
            tst.w   (SP)+
            bpl.b   .L4
            lea     (-$400,A6),A0
            clr.l   ($12,A0)
            _UnmountVol
            jmp     .L27
.L4:
            moveq   #0,D0
            bsr.w   sub_408020AC
            move.l  D0,D5
            bne.b   .L5
            moveq   #0,D7
            bra.b   .L6
.L5:
            movea.l D5,A0
            move.l  (A0),DSAlertTab
.L6:
            _InitFonts
            subq.w  #2,SP
            pea     ($4A,A6)
            _OpenResFile
            move.w  (SP)+,D3
            cmpi.w  #$FFFF,D3
            beq.b   .L9
            subq.w  #4,SP
            clr.w   -(SP)
            _GetPicture
            move.l  (SP)+,D0
            beq.b   .L8
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            movea.l (A0),A0
            move.l  (6,A0),-(SP)
            move.l  (2,A0),-(SP)
            lea     (-$1FE,A6),A0
            tst.w   (4,A0)
            bpl.b   .L7
            movea.l (A0),A0
            movea.l (A0),A0
.L7:
            pea     (6,A0)
            pea     (4,SP)
            bsr.w   CenterRect
            bsr.w   EraseMyIcon
            move.l  A2,-(SP)
            pea     (4,SP)
            _DrawPicture
            addq.w  #8,SP
            moveq   #0,D7
.L8:
            move.w  D3,-(SP)
            _CloseResFile
            tst.b   D7
            beq.b   .L11
.L9:
            lea     ($4A,A6),A1
            moveq   #1,D3
            bsr.w   sub_408020D2
            sne     D7
            bne.b   .L11
            lea     (-$1FE,A6),A2
            tst.w   (4,A2)
            bpl.b   .L10
            movea.l (A2),A2
            movea.l (A2),A2
.L10:
            move.l  #$1560200,-(SP)
            clr.l   -(SP)
            pea     (6,A2)
            pea     (4,SP)
            bsr.w   CenterRect
            move.w  #$40,-(SP)
            pea     ($800,A6)
            move.l  SP,-(SP)
            move.l  A2,-(SP)
            pea     ($E,SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            lea     ($E,SP),SP
.L11:
            tst.b   D7
            beq.b   .L12
            bsr.w   EraseMyIcon
.L12:
            moveq   #$28,D0
            bsr.w   sub_408020A4
            subi.l  #$400,BufPtr
            lea     ($2A,A6),A1
            bsr.w   sub_408020D0
            beq.b   .L13
            addi.l  #$400,BufPtr
            bra.b   .L14
.L13:
            jsr     (A1)
            moveq   #-$A,D0
            bsr.w   sub_408020A4
            lea     ($3A,A6),A1
            bsr.w   sub_408020D0
            bne.b   .L14
            jsr     (A1)
            moveq   #-$B,D0
            bsr.w   sub_408020A4
.L14:
            lea     SysResName,A1
            moveq   #-1,D3
            bsr.w   sub_408020D2
            bne.b   .L15
            jsr     (A1)
.L15:
            suba.w  #$38,SP
            movea.l SP,A0
            _sSecondaryInit
            lea     ($38,SP),SP
            BigJsr  InitADBDrvr,A0
            bsr.w   MouseInit
            bsr.w   OpenSlots
            moveq   #2,D0
            bsr.w   sub_408020AC
            beq.b   .L16
            movea.l D0,A0
            move.l  (A0),DSAlertTab
            move.l  A0,-(SP)
            _DetachResource
.L16:
            move.l  D5,-(SP)
            _ReleaseResource
            moveq   #$C,D0
            _NewHandleClear async
            move.l  A0,($AEC).w
            lea     (-$400,A6),A0
            move.w  #$FFFB,($18,A0)
            move.w  #9,($1A,A0)
            move.w  #$FF01,($1C,A0)
            _Control
            _InitApplZone
            _RDrvrInstall
            moveq   #0,D6
.L17:
            movem.l A5-A6,($B36).w
            _FreeMem sys
            subi.l  #$4000,D0
            neg.l   D0
            ble.b   .L18
            addi.l  #$3FF,D0
            andi.w  #$FC00,D0
            movea.l SysZone,A0
            movea.l (A0),A0
            adda.l  D0,A0
            _SetAppBase
            _InitApplZone
.L18:
            moveq   #0,D5
.L19:
            not.b   D5
            beq.b   .L20
            move.b  D5,ROMMapInsert
            move.b  ResLoad,($B9F).w
            subq.w  #4,SP
            move.l  #'INIT',-(SP)
            move.w  D6,-(SP)
            _GetResource
            move.l  (SP)+,D7
            beq.b   .L19
            move.l  D7,-(SP)
            _DetachResource
            movea.l D7,A0
            movea.l (A0),A0
            jsr     (A0)
.L20:
            movem.l ($B36).w,A5-A6
            addq.w  #1,D6
            cmpi.w  #$24,D6
            blt.b   .L17
            pea     (-$200,A6)
            _CloseCPort
            moveq   #$40,D0
            swap    D0
            _PurgeMem sys
            movea.l SysZone,A0
            move.l  #$18000,D0
            move.w  (6,A6),D1
            cmpi.w  #$14,D1
            bls.b   .L21
            move.l  ($86,A6),D0
            btst    #$F,D1
            beq.b   .L21
            btst    #$D,D1
            beq.b   .L21
            subq.w  #4,SP
            move.l  BufPtr,-(SP)
            move.l  ($90,A6),-(SP)
            dc.w    $A84A                           ; A-trap $A84A
            move.l  (SP)+,D0
            add.l   ($8C,A6),D0
            movea.l SysZone,A0
            movea.l (A0),A0
.L21:
            adda.l  D0,A0
            _FreeMem sys
            subi.l  #$4000,D0
            neg.l   D0
            bpl.b   .L22
            moveq   #0,D0
.L22:
            movea.l SysZone,A1
            add.l   (A1),D0
            cmpa.l  D0,A0
            bcc.b   .L23
            movea.l D0,A0
.L23:
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L24
            movea.l A1,A0
.L24:
            _SetAppBase
            _InitApplZone
            movea.l PortList,A0
            moveq   #2,D0
            _SetHandleSize
            movea.l (A0),A0
            clr.w   (A0)
            lea     ($6A,A6),A0
            lea     ScrapTag,A1
            move.l  A1,ScrapName
            moveq   #$10,D0
            _BlockMove
            lea     ($1A,A6),A0
            lea     ($2E0).w,A1
            moveq   #$10,D0
            _BlockMove
            clr.w   CurApRefNum
            lea     (-$400,A6),A0
            clr.l   ($12,A0)
            _GetVol
            move.w  ($16,A0),BootDrive
            move.l  A4,D0
            bsr.w   sub_40802142
            lea     ($5A,A6),A3
            bsr.w   sub_408020BC
            beq.b   .L25
            lea     ($1A,A6),A3
            bsr.w   sub_408020BC
            bne.b   .L26
.L25:
            clr.w   -(SP)
            clr.l   -(SP)
            move.l  A3,-(SP)
            movea.l SP,A0
            _Launch
.L26:
            moveq   #$29,D0
            _SysError
            _Debugger
.L27:
            move.w  BootDrive,D3
            move.w  BtDskRfn,D1
            bsr.b   getDiskInPlace
            cmpi.b  #8,D0
            beq.b   .L28
            move.b  D0,-(SP)
            lea     (-$400,A6),A0
            move.w  BtDskRfn,($18,A0)
            move.w  #7,($1A,A0)
            move.w  D3,($16,A0)
            _Control
            bne.b   .L28
            move.b  (SP)+,D0
            cmpi.b  #8,D0
            bge.w   .L28
            cmpi.w  #$FFFE,BtDskRfn
            bne.b   .L29
.L28:
            move.w  BootMask,D0
            bclr    D3,D0
            move.w  D0,BootMask
.L29:
            bra.w   CLOSENETBOOTPATCH
getDiskInPlace:
            lea     ($30A).w,A0
.L1:
            move.l  (A0),D0
            beq.b   .L2
            movea.l D0,A0
            cmp.w   (6,A0),D3
            bne.b   .L1
            cmp.w   (8,A0),D1
            bne.b   .L1
            move.b  (-3,A0),D0
.L2:
            rts
sub_408020A4:
            tst.b   D7
            beq.b   .L1
            _SysError
.L1:
            rts
sub_408020AC:
            clr.l   -(SP)
            move.l  #'DSAT',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            rts
sub_408020BC:
            lea     (-$400,A6),A0
            clr.w   ($16,A0)
            clr.l   ($1A,A0)
            move.l  A3,($12,A0)
            _GetFileInfo
            rts
sub_408020D0:
            moveq   #0,D3
sub_408020D2:
            lea     (-$400,A6),A0
            moveq   #-1,D2
            lea     ($12,A0),A2
            move.l  A1,(A2)+
            clr.l   (A2)+
            clr.b   (A2)+
            move.b  #1,(A2)+
            pea     ($400,A6)
            move.l  (SP)+,(A2)
            _Open
            bne.b   .L3
            _GetEOF
            bne.b   .L2
            move.l  (A2)+,D4
            moveq   #$40,D6
            asl.w   #3,D6
            sub.l   D6,D4
            tst.w   D3
            bmi.b   .L5
            bne.b   .L4
            movea.l BufPtr,A1
            suba.l  D4,A1
.L1:
            lea     (-$400,A6),A0
            lea     ($20,A0),A2
            move.l  A1,(A2)+
            move.l  D4,(A2)+
            addq.w  #4,A2
            move.w  #1,(A2)+
            move.l  D6,(A2)
            _Read
            bne.b   .L2
            moveq   #0,D2
.L2:
            lea     (-$400,A6),A0
            _Close
.L3:
            move.w  D2,D0
            rts
.L4:
            lea     ($800,A6),A1
            add.l   D6,D4
            moveq   #0,D6
            bra.b   .L1
.L5:
            move.l  D4,D0
            _NewPtrSys
            move.w  D0,D2
            bne.b   .L2
            movea.l A0,A1
            bra.b   .L1
sub_40802142:
            tst.l   D0
            beq.b   .L1
            lea     (-$400,A6),A0
            move.l  D0,($30,A0)
            clr.l   ($12,A0)
            move.l  #'ERIK',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            bne.b   .L1
            _SetVol
.L1:
            rts
            ds.b    12
CenterRect:
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            bsr.b   sub_4080217E
            bsr.b   sub_4080217E
            movea.l D2,A0
            jmp     (A0)
sub_4080217E:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (4,A1),D1
            sub.w   (A1),D1
            sub.w   D1,D0
            asr.w   #1,D0
            add.w   (A0)+,D0
            move.w  D0,(A1)+
            add.w   D1,D0
            move.w  D0,(2,A1)
            rts
            ds.b    6
MouseInit:
            moveq   #$78,D0
            and.b   SPVolCtl,D0
            lsr.b   #3,D0
            cmpi.b  #4,D0
            ble.b   .L1
            andi.b  #$57,SPVolCtl
            ori.b   #$10,SPVolCtl
            moveq   #2,D0
.L1:
            subq.w  #4,SP
            move.l  #'mcky',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            movea.l MickeyBytes,A1
            lea     ($14,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
.L2:
            rts
            dc.w    0
OpenBDrvrs:
            move.b  ($31,A0),-(SP)
            move.b  ($32,A0),-(SP)
            movem.l D0-D3/A0-A1,-(SP)
            suba.w  #$18,SP
            movea.l SP,A1
            move.l  A1,($14,A0)
            move.l  A0,D3
            subq.l  #2,SP
            movea.l SP,A0
            _GetOSDefault
            move.w  (SP)+,D2
            movea.l D3,A0
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            clr.b   ($11,A1)
            clr.b   ($10,A1)
            move.b  D2,($12,A1)
            lsr.l   #8,D2
            move.b  D2,($13,A1)
            move.b  #1,($16,A1)
            move.b  #6,($32,A0)
            _sExec
            lea     ($18,SP),SP
            movem.l (SP)+,D0-D3/A0-A1
            move.b  (SP)+,($32,A0)
            move.b  (SP)+,($31,A0)
            rts
OpenSlots:
            movem.l D0-D4/A0-A1,-(SP)
            suba.w  #$32,SP
            movea.l SP,A1
            clr.b   ($1B,A1)
            suba.w  #$38,SP
            movea.l SP,A0
            clr.b   ($31,A0)
            clr.b   ($33,A0)
            clr.b   D3
.Repeat:
            move.b  D3,($32,A0)
            _sNextsRsrc
            bne.b   .L4
            move.b  ($32,A0),D3
            move.l  (4,A0),D4
            move.b  #7,($32,A0)
            _sReadWord
            bne.b   .L2
            move.w  (2,A0),D0
            btst    #1,D0
            beq.b   .Repeat
.L2:
            move.b  #6,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.b  D3,($32,A0)
            move.l  D4,(4,A0)
            bsr.w   OpenBDrvrs
            bra.b   .Repeat
.L3:
            move.b  D3,($32,A0)
            bsr.w   OpensDrvr
            bne.b   .Repeat
            cmpi.l  #$30001,($28,A0)
            bne.b   .Repeat
            cmpi.w  #1,($2C,A0)
            bne.b   .Repeat
            bsr.w   AddVidDevice
            bra.b   .Repeat
.L4:
            lea     ($6A,SP),SP
            movea.l DeviceList,A0
            movea.l (A0),A0
            bclr    #$C,($14,A0)
            movem.l (SP)+,D0-D4/A0-A1
            rts
            ds.b    8
InitEvents:
            move.w  D0,D2
            moveq   #$16,D0
            mulu.w  D2,D0
            move.l  D0,D1
            _NewPtrSysClear
            lea     EvtBufCnt,A1
            subq.w  #1,D2
            move.w  D2,(A1)
            clr.l   -(A1)
            clr.l   -(A1)
            clr.w   -(A1)
            move.l  A0,-(A1)
.L1:
            not.w   (A0)+
            subq.w  #2,D1
            bne.b   .L1
            move.w  #$FFEF,-(A1)
            clr.w   KeyLast
            rts
            ds.b    6

            EVEN
