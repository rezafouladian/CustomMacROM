            include "Include/ROMHeader.s"

            EXPORT  CheckForEgret,DrawBeepScreen,DrawBeepScreenReturn,ForeignOS,GOOFYDoEject,InitCrsrVars
            EXPORT  InitIWM,InitMemMgr,InitSCC,InitSCSI,InitShutdownMgr,PMSPSwOS
            EXPORT  ResetEntry,SoundInitPatchRtn,StartBoot,StartInit1,WDCBSwOS,AddVidDevice
            EXPORT  CLOSENETBOOTPATCH,OpensDrvr

            IMPORT  BacklightPatch,BadTrap,BaseOfROM,Critical,CrsrCore,CrsrVBLTask
            IMPORT  DisableIntSources,DisableMMUPatch,DoEject,DrawBeepScreenPatch,DTCore,ECLIPSEEGRETPATCHES
            IMPORT  EgretMgr,ElsieTranslate24To32,EMT1010,EnableCachesPatch,EnableExtCache,ENABLEONESECINTS
            IMPORT  ENABLEPARITYPATCH,EnableSlotInts,EnableSWIMIOPInts,FSIODneTbl,GetHardwareInfo,InitADB
            IMPORT  InitDispatcher,INITEGRETALT,InitGestalt,InitHWRoutines,InitIntHandler,INITIOPMGR
            IMPORT  INITMEMDISPANDSHUTDOWNMGRS,InitMemMgrPatch,InitMemVect,InitMMU,InitMMUGlobals,InitMMUTrap
            IMPORT  InitQueue,INITSCSIHW,InitSCSIMgr,InitSDTbl,InitTimeMgr,InitVBLQs
            IMPORT  InitVIAs,INSTALLSONYDRIVERPATCH,JumpIntoROM,MMUCleanupFor8Mb,NMGNEFILTER,NMInit
            IMPORT  POWERDWNPTCH,PowerMngr,PwrCntrlPatch,SCCIOPByPass,SCCIOPHwInit,SetupMiscSCSI
            IMPORT  SoundInitPatch,StartSDeclMgr,StartTest1,SysErrInitPatch,TEGlobalInit,ValidatePRAM
            IMPORT  WhichCPUPatch,MyBoot

            SECTION "StartInit",CODE

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

            EVEN
