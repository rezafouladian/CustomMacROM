            include "Include/ROMHeader.s"

            EXPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,ADBOp,ADBReInit
            EXPORT  AddDrive,AttachVBL,BadTrap,BlockMove68020,BMMOVELONGS,BMOVERLAP
            EXPORT  BMVERYSHORT,CacheFlush,CacheTrap,CallRoutines,Chain,ClearSCSIInt
            EXPORT  ClkNoMem,ClkRW,Close,CmpString,CompactMem,Control
            EXPORT  DebugUtil,Delay,DequeueTrap,DHBUSERRHANDLER,DisableIntSources,DisposePtr
            EXPORT  DoEject,DoVBLTask,DrvrInstall,DrvrRemove,DsposeHandle,DTCore
            EXPORT  EgretCheck,Eject_2,EmptyHandle,EMT1010,Enable60HzInts,EnableParityInts
            EXPORT  EnableSlotInts,EnableSWIMIOPInts,Events,ExitToShell,ExplicitRequestDone,FileAlloc
            EXPORT  FileCreate,FileDelete,FileWrite,FInitQueue,FlushEvents,FlushFile
            EXPORT  FlushVol,FreeMem,FSIODneTbl,GetADBInfo,GetAppParms,GetBlock
            EXPORT  GetEOF,GetFileInfo,GetFPos,GetHandleSize,GetIndADB,GetOSEvent
            EXPORT  GetPtrSize,GetTrapAddress,GetVol,GetVolInfo,GetZone,GOTSLOTHANDLER
            EXPORT  HandleZone,HeapGuts,HGetFlags,HLock,HNoPurge,HNoRSRC
            EXPORT  HPurge,HRSRC,HSetFlags,HUnlock,ImplicitRequestDone,InitADB
            EXPORT  InitADBDrvr,InitApplZone,InitDispatcher,InitFS,InitIntHandler,InitMemVect
            EXPORT  InitQueue,INITRELIABILITY,INITSCSIDONE,InitSCSIMgr,InitTimeMgr,InitUtil
            EXPORT  InitVBLQs,InitZone,InstallRDrivers,InsTime,INTHANDLERNOVIA2,KBDMngr
            EXPORT  KeyTrans,KillIO,Launch,Loader,LWRSTRING,MaxApplZone
            EXPORT  MaxBlock,MaxMem,MoreMasters,MountVol,MoveHHi,NewEmptyHandle
            EXPORT  NewPtr,NwHandle,Offline,Open,OPENPATCHRTN,OPENPATCHRTN1
            EXPORT  OpenRF,OSEventAvail,PollDone,PowerOff,PowerOffCont,PRAMInit
            EXPORT  PRAMInitTbl,PrimeTime,PtrZone,PurgeMem,PurgeSpace,QStuff
            EXPORT  Read,ReadDateTime,ReadParam,READPRAMPATCHRTN,ReadXPRam,ReAllocHandle
            EXPORT  RecoverHandle,ReInit,RelStringTrap,ReName,ResrvMem,RSetKMap
            EXPORT  RstFilLock,RunDone,RunKBD,SCCIOPBYPASSINT,SCSIBoots,SCSIExitCleanup
            EXPORT  SCSIINTHNDRESUME,SCSIMgr,SCSISetFlags,SetADBInfo,SetApplBase,SetApplLimit
            EXPORT  SetDateTimeTrap,SetEOF,SetFileInfo,SetFilLock,SetFilType,SetFPos
            EXPORT  SetGrowZone,SetHandleSize,SetPtrSize,SetTrapAddress,SetVol,SetZone
            EXPORT  ShutDownDisp,SlotVInstall,SlotVRemove,StackSpace,Status,StripAddress
            EXPORT  SYSENVIRONS,SYSUTIL,TimeMgr,TurboFS,UnloadSeg,UnmountVol
            EXPORT  uprstring,vAdjEOF,ValidatePRAM,VALIDATEPRAMCONT,vAllocNode,VBASICIO
            EXPORT  VBLCore,vBlkAlloc,VBLKDEALLOC,vBMChk,vBTClose,vBTDelete
            EXPORT  VBTFLUSH,vBTGetRecord,VBTINSERT,VBTOPEN,vBTSearch,vBTUpdate
            EXPORT  vCacheFlush,vCacheRdIP,vCacheWrIP,vCheckRemount,vCkExtFS,vCMSetUp
            EXPORT  vDeAllocFile,vDisptch,vDtrmV1,vDtrmV2,vDtrmV3,vExtBTFile
            EXPORT  vExtendFile,vFClose,vFileClose,vFileOpen,vFileRead,vFileWrite
            EXPORT  vFindDrive,vFlushCache,vFlushMDB,vFndFilName,vFreeNode,vGetBlock
            EXPORT  vGetNode,vGoDriver,vIAZInit,vIAZPostInit,vLaunchInit,VLG2PHYS
            EXPORT  VLOCCREC,vMapFBlock,vMarkBlock,VMTCHECK,vPermssnChk,VRDBLOCKS
            EXPORT  vReadBM,vRelBlock,vRelNode,VRemove,vRfNCall,vSegStack
            EXPORT  VSETUPTAGS,vSyncWait,vTrashBlocks,vTrashVBlks,vTreeSearch,vTruncateFile
            EXPORT  vTstMod,VUPDALTMDB,vWaitUntil,VWRBLOCKS,vXFSearch,Write
            EXPORT  WriteParam,WRITEPRAMPATCHRTN,WriteTimePatchRtn,WriteUpdateReturn,WriteXPRam,XPRAMCONT
            EXPORT  XPRAMEXIT1

            IMPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            IMPORT  ALIGN24TRAILER,ALIGN32TRAILER,AllocFakeRgns,CACHEVECTORPATCH,CLKNOMEMPATCH,DEBUGENTERCONT
            IMPORT  DEBUGEXITCONT,DEBUGPWRMGRADBPATCH1,DEBUGUTILRUNKBDPATCH,DEREFHANDLEPATCH,DISPATCHPATCH,DSHOOKPATCH
            IMPORT  EgretPatches,FILEMGRPATCH,FlushApplNM,INIT24ZONEALIGN,INIT32ZONEALIGN,InitADBPatchPwrMgr
            IMPORT  INITSCSIMGRPATCH1,INITSCSIMGRPATCH2,INITSLOTINTSPATCH,INSTALLSCSIINTHND96,IOPINTERRUPT,LoadSegPatch
            IMPORT  OPENPATCH,OSEVENTAVAILPATCH,OSEVENTMGRPATCH,OSSSLOTINT,PMGRPOWEROFFPATCH,PMSPSwOS
            IMPORT  POWEROFFPATCH,RBVSLOTINT,ReadPRamPatch,ReadTimePatch,READUPDATE,RequestDonePatch
            IMPORT  SCSIDOCOMPLETEPATCH,SCSIGETPATCH,SCSIMISCPATCH,SCSISETFLAGSPATCH,SETAPPLBASEPATCH,SHUTRESTARTANNEX
            IMPORT  SlotInt,SMGRPOSTMUNGING,SysErr1,UnloadSegPatch,V24CMGUTSPATCH,V24HLOCKPATCH
            IMPORT  V24MAXAPPLPATCH,V24MAXMEMPATCH,V24PURGESPACEPATCH,V32CMGUTSPATCH,V32HLOCKPATCH,V32MAXAPPLPATCH
            IMPORT  V32MAXMEMPATCH,V32PURGESPACEPATCH,ValidatePRAMPatch,WDCBSwOS,WritePRamPatch,WRITETIMEPATCH
            IMPORT  WRITEUPDATE,XPRAMPATCH,ZONECHECKPATCH

            SECTION "Part2",CODE

SCSIBoots:
SCSILoad:
            btst    #7,HWCfgFlags
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            movem.l D1-D7/A0-A6,-(SP)
            move.b  D0,-(SP)
            moveq   #7,D5
.L2:
            btst    D5,(SP)
            beq.b   .L3
            btst    D5,SCSIDrvrs
            bne.b   .L3
            bsr.b   sub_40807224
            beq.b   .L3
            bclr    D5,(SP)
.L3:
            dbra    D5,.L2
            moveq   #0,D0
            move.b  (SP)+,D0
            movem.l (SP)+,D1-D7/A0-A6
            tst.w   D0
            rts
sub_40807224:
            move.l  D3,-(SP)
            link.w  A6,#-$212
            movea.l SP,A2
            swap    D3
            moveq   #0,D0
            move.b  D3,D0
            move.w  D0,(-$A,A6)
            moveq   #0,D3
            moveq   #1,D2
            move.w  #$200,D4
            bsr.w   sub_4080738A
            bne.w   .L4
            cmpi.w  #$4552,(SP)
            bne.w   .L6
            move.w  (2,SP),D4
            move.w  ($10,SP),D0
            beq.b   .L6
            lea     ($12,SP),A0
            move.l  ($C,SP),D7
.L1:
            move.w  (-$A,A6),D1
            cmp.w   (6,A0),D1
            beq.b   .L2
            addq.l  #8,A0
            subq.w  #1,D0
            bne.b   .L1
            bra.b   .L6
.L2:
            bset    D5,SCSIDrvrs
            move.l  (A0),D3
            move.l  D3,(-4,A6)
            moveq   #0,D2
            move.w  (4,A0),D2
            move.l  D2,(-8,A6)
            move.l  D4,D0
            mulu.w  D2,D0
            _NewPtrSys
            bne.b   .L6
            movea.l A0,A3
            movea.l A0,A2
            bsr.w   sub_4080738A
            bne.b   .L5
            moveq   #1,D3
            move.l  D3,(-$12,A6)
            moveq   #1,D2
            move.w  #$200,D4
            movea.l SP,A2
            bsr.w   sub_4080738A
            bne.b   .L5
            cmpi.w  #1,(-$A,A6)
            bne.b   .L3
            cmpi.w  #$5453,(A2)
            beq.b   .L3
            cmpi.w  #$504D,(A2)
            bne.b   .L3
            move.l  (4,A2),D0
            move.l  D0,(-$E,A6)
            bra.b   .L8
.L3:
            movea.l A2,A0
            jsr     (A3)
.L4:
            moveq   #0,D0
            bra.b   .L7
.L5:
            movea.l A3,A0
            _DisposPtr
.L6:
            moveq   #-1,D0
.L7:
            unlk    A6
            move.l  (SP)+,D3
            tst.w   D0
            rts
.L8:
            cmpi.l  #'Appl',($30,A2)
            bne.b   .L9
            cmpi.l  #'e_Dr',($34,A2)
            bne.b   .L9
            cmpi.l  #'iver',($38,A2)
            bne.b   .L9
            cmpi.l  #'Maci',($10,A2)
            bne.b   .L9
            move.l  (-4,A6),D0
            cmp.l   (8,A2),D0
            bne.b   .L9
            movea.l A3,A0
            move.l  ($60,A2),D1
            bsr.w   sub_40807444
            cmp.l   ($74,A2),D0
            beq.b   .L10
            bra.b   .L5
.L9:
            addq.l  #1,(-$12,A6)
            move.l  (-$12,A6),D3
            cmp.l   (-$E,A6),D3
            bhi.b   .L10
            moveq   #1,D2
            move.w  #$200,D4
            bsr.b   sub_4080738A
            bne.b   .L9
            cmpi.w  #$504D,(A2)
            bne.b   .L9
            bra.b   .L8
.L10:
            moveq   #0,D0
            move.l  D0,(-$12,A6)
.L11:
            addq.l  #1,(-$12,A6)
            move.l  (-$12,A6),D3
            cmp.l   (-$E,A6),D3
            bhi.w   .L5
            moveq   #1,D2
            move.w  #$200,D4
            bsr.b   sub_4080738A
            bne.b   .L11
            cmpi.w  #$504D,(A2)
            bne.b   .L11
            cmpi.l  #'Appl',($30,A2)
            bne.b   .L11
            cmpi.l  #'e_HF',($34,A2)
            bne.b   .L11
            cmpi.b  #$53,($38,A2)
            bne.b   .L11
            bra.w   .L3
sub_4080738A:
            move.l  D7,-(SP)
            moveq   #0,D7
            swap    D2
            move.w  D4,D2
.L1:
            lea     Scratch8,A0
            move.b  #8,(A0)+
            swap    D3
            andi.b  #$1F,D3
            move.b  D3,(A0)+
            swap    D3
            move.w  D3,(A0)+
            move.l  D2,D4
            swap    D4
            move.b  D4,(A0)+
            clr.b   (A0)+
            mulu.w  D2,D4
            suba.w  #$14,SP
            move.l  SP,D6
            subq.l  #2,SP
            move.w  #1,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L5
            move.w  D5,-(SP)
            move.w  #2,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L5
            pea     Scratch8
            move.w  #6,-(SP)
            move.w  #3,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L2
            movea.l D6,A0
            move.w  #1,(A0)+
            move.l  A2,(A0)+
            move.l  D4,(A0)+
            move.w  #7,(A0)
            move.l  D6,-(SP)
            move.w  #5,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
.L2:
            pea     Scratch8
            pea     ($9FC).w
            move.l  #$3C,-(SP)
            move.w  #4,-(SP)
            _SCSIDispatch
            tst.w   D7
            beq.b   .L3
            cmpi.w  #5,D7
            beq.b   .L4
.L3:
            move.w  (SP),D7
            cmpi.w  #$A,D7
            bne.b   .L5
.L4:
            move.w  Scratch8,D7
            beq.b   .L5
            cmpi.w  #2,D7
            bne.b   .L5
            bset    #$1F,D7
            bne.b   .L5
            lea     ($16,SP),SP
            bra.w   .L1
.L5:
            bra.l   SCSIMISCPATCH
            ds.b    6
sub_40807444:
            moveq   #0,D0
            moveq   #0,D7
            bra.b   .L2
.L1:
            move.b  (A0)+,D7
            add.w   D7,D0
            rol.w   #1,D0
.L2:
            dbra    D1,.L1
            tst.w   D0
            bne.b   .L3
            subq.w  #1,D0
.L3:
            rts
            ds.b    4
SCSIMgr:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.l  A0,-(SP)
            cmpi.w  #$E,D0
            bcc.b   Unimplemented_
            link.w  A6,#-6
            movem.l D2-D7/A2-A5,-(SP)
            movea.l SCSIGlobals,A4
scsiMgrCommon:
            movea.l ($40,A4),A3
            moveq   #0,D7
            moveq   #0,D4
            move.w  D0,D1
            movea.l (0,A4,D0.w*4),A0
            jmp     (A0)
Unimplemented_:
            moveq   #$C,D0
            _SysError
L1:
            bra.b   L1
DoSCSIStat:
            bsr.w   DMAPENDINGPATCH
            nop
            bne.b   pending
normal:
            move.b  ($50,A3),(8,A6)
            move.b  ($40,A3),(9,A6)
            bra.b   NoByteExit
pending:
            move.b  #8,(8,A6)
            move.b  #$44,(9,A6)
            bra.b   NoByteExit
DoSCSIReset:
            movea.l ($1A4,A4),A0
            jsr     (A0)
            move.w  D7,(8,A6)
            bsr.b   SCSIExitCleanup
NoByteExit:
            moveq   #0,D0
            bra.w   SCSIStdExit
SCSIExitCleanup:
            moveq   #-1,D0
            movea.l ($198,A4),A0
            jsr     (A0)
            movea.l ($16C,A4),A0
            jsr     (A0)
            moveq   #1,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            rts
DoSCSIGet:
            bset    #0,($61,A4)
            bne.b   wasBusy
            move    SR,-(SP)
            ori     #$700,SR
            move.w  (SP),D0
            andi.w  #$700,D0
            beq.b   enqueueDummy
            tst.l   ($50,A4)
            beq.b   enqueueDummy
notFirst:
            move    (SP)+,SR
wasBusy:
            moveq   #7,D0
            bra.b   wait.L1
enqueueDummy:
            lea     ($2A4,A4),A1
            moveq   #-1,D0
            movea.l ($188,A4),A0
            jsr     (A0)
            move    (SP)+,SR
wait:
            cmpa.l  ($50,A4),A1
            bne.b   wait
            move.l  D7,D0
            bsr.l   SCSIGETPATCH
            bsr.w   Arbitrate
            beq.b   .L1
            move.l  D0,-(SP)
            bsr.b   SCSIExitCleanup
            move.l  (SP)+,D0
.L1:
            move.w  D0,(8,A6)
            bra.b   NoByteExit
DOSCSISELATN:
DOSCSISELECT:
            moveq   #0,D0
            move.w  (8,A6),D0
            cmpi.w  #$B,D1
            bne.b   .L1
            bset    #$1F,D0
.L1:
            bsr.w   Select
            beq.b   .L2
            move.l  D0,-(SP)
            bsr.w   SCSIExitCleanup
            move.l  (SP)+,D0
.L2:
            move.w  D0,($A,A6)
            moveq   #2,D0
            bra.w   SCSIStdExit
DoSCSICmd:
            movea.l ($A,A6),A2
            move.w  (8,A6),D2
            bsr.w   SendCMD
            beq.b   exit
error:
            move.l  D0,-(SP)
            bsr.w   SCSIExitCleanup
            move.l  (SP)+,D0
exit:
            move.w  D0,($E,A6)
            moveq   #6,D0
            bra.w   SCSIStdExit
NewSCSIWBlind:
            moveq   #$2C,D4
            bra.b   dataCommon
NewSCSIWrite:
            moveq   #$24,D4
            bra.b   dataCommon
NewSCSIRBlind:
            moveq   #$28,D4
            bra.b   startRead
NewSCSIRead:
            moveq   #$20,D4
startRead:
            move.b  #1,($30,A3)
            move.b  #2,($20,A3)
            btst    #4,($67,A4)
            beq.b   DMAdone
            move.l  #8,($80,A3)
DMAdone:
            move.b  D7,($70,A3)
dataCommon:
            movea.l (8,A6),A1
            bra.b   .L2
.L12:
            bset    #4,D4
.L7:
            movea.l ($19C,A4),A0
            jsr     (A0)
            bne.b   .L5
            add.l   D1,(2,A1)
            bclr    #4,D4
.L1:
            lea     ($A,A1),A1
.L2:
            move.w  (A1),D1
            movea.l (2,A1),A2
            move.l  (6,A1),D2
            cmpi.w  #8,D1
            bhi.b   .L4
            jmp     .L3(PC,D1.w*2)
.L3:
            bra.b   .L4
            bra.b   .L7
            bra.b   .L8
            bra.b   .L9
            bra.b   .L10
            bra.b   .L11
            bra.b   .L1
            bra.b   .L13
            bra.b   .L12
.L4:
            moveq   #4,D0
            bra.b   .L5
.L8:
            movea.l ($19C,A4),A0
            jsr     (A0)
            bne.b   .L5
            bra.b   .L1
.L9:
            add.l   D2,(A2)
            bra.b   .L1
.L10:
            movea.l D2,A0
            move.l  (A2),(A0)
            bra.b   .L1
.L11:
            tst.l   D2
            beq.b   .L1
            subq.l  #1,D2
            move.l  D2,(6,A1)
            beq.b   .L1
            adda.l  A2,A1
            bra.b   .L2
.L13:
            moveq   #0,D0
.L5:
            move.b  D7,($20,A3)
            btst    #4,($67,A4)
            beq.b   .L6
            move.l  #2,($80,A3)
.L6:
            move.b  D7,($10,A3)
            move.w  D0,($C,A6)
            moveq   #4,D0
            bra.w   SCSIStdExit
DOSCSICOMPLETE:
            move.w  D7,-(SP)
            move.b  D7,($20,A3)
            btst    #4,($67,A4)
            beq.b   .L1
            move.l  #2,($80,A3)
.L1:
            move.l  Ticks,D4
            add.l   (8,A6),D4
.L2:
            moveq   #0,D2
            bsr.w   GetStat
            beq.b   .L4
            cmpi.b  #5,D0
            bne.b   .L3
            bsr.w   CyclePhase
            beq.b   .L3
            move.w  D0,(SP)
.L3:
            cmp.l   Ticks,D4
            bhi.b   .L2
            bra.b   .L5
.L4:
            movea.l ($10,A6),A1
            move.w  D2,(A1)
            bsr.w   GetMsg
            beq.b   .L6
.L5:
            move.w  D0,(SP)
            bra.b   .L7
.L6:
            movea.l ($C,A6),A1
            move.w  D2,(A1)
.L7:
            bsr.l   SCSIDOCOMPLETEPATCH
            nop
            moveq   #$C,D0
            bra.b   SCSIStdExit
DOSCSIMSGIN:
            bsr.w   GetMsg
            bne.b   .L1
            movea.l (8,A6),A1
            move.w  D2,(A1)
.L1:
            move.w  D0,($C,A6)
            moveq   #4,D0
            bra.b   SCSIStdExit
DOSCSIMSGOUT:
            move.w  (8,A6),D2
            bsr.w   SendMsg
            move.w  D0,($A,A6)
            moveq   #2,D0
SCSIStdExit:
            movem.l (SP)+,D2-D7/A2-A5
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
Arbitrate:
            move.b  ($60,A4),(A3)
ArbRetry:
            move.b  D7,($20,A3)
            moveq   #0,D1
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            move.l  D1,D5
            swap    D5
            move.b  #1,($20,A3)
L0:
            btst    #6,($10,A3)
            dbne    D1,L0
            dbne    D5,L0
            bne.b   ArbStarted
ArbErr:
            move.b  D7,($20,A3)
            moveq   #3,D0
            rts
ArbStarted:
            bsr.w   busdelay
            btst    #5,($10,A3)
            bne.b   ArbRetry
            move.b  (A3),D0
            move.b  ($60,A4),D2
            eor.b   D2,D0
            cmp.b   D0,D2
            bcs.b   ArbRetry
            btst    #5,($10,A3)
            bne.b   ArbRetry
            moveq   #0,D0
            rts
Select:
            lea     ($10,A3),A0
            moveq   #1,D1
            lsl.b   D0,D1
            move.l  D0,D3
            move.b  #4,(A0)
            bsr.w   busdelay
            move.b  ($60,A4),D2
            move.b  D7,($30,A3)
            or.b    D2,D1
            move.b  D1,(A3)
            move.b  #$D,D4
            tst.l   D3
            bpl.b   .L1
            ori.b   #2,D4
.L1:
            move.b  D4,(A0)
            move.b  D7,($20,A3)
            move.b  D7,($40,A3)
            bclr    #3,D4
            move.b  D4,(A0)
            bsr.w   busdelay
            move.w  ($62,A4),D1
            bsr.w   wfbsy
            bne.b   .L2
            bsr.w   busdelay
            andi.b  #$A,D4
            move.b  D4,(A0)
            moveq   #0,D0
            rts
.L2:
            move.b  D7,(A0)
            tst.w   D0
            rts
SendCMD:
            move.b  #2,($30,A3)
            bsr.w   wfREQ
            bne.b   SendCmdRts
            bsr.w   CheckPhase
            bne.b   SendCmdRts
            subq.l  #1,D2
NextCmdByte:
            move.b  (A2)+,(A3)
            move.b  #1,($10,A3)
            bsr.w   wfREQ
            bne.b   SendCmdRts
            move.b  #$11,($10,A3)
            bsr.w   wfnREQ
            bne.b   SendCmdRts
            move.b  D7,($10,A3)
            dbra    D2,NextCmdByte
            move.l  D7,D0
            move.w  TimeSCSIDB,D0
            lsl.l   #8,D0
            move.l  D0,D2
            swap    D2
cmdHack:
            btst    #6,($40,A3)
            beq.b   exit_2
            btst    #3,($50,A3)
            dbeq    D0,cmdHack
            dbeq    D2,cmdHack
exit_2:
            moveq   #0,D0
SendCmdRts:
            rts
GetStat:
            move.b  #3,($30,A3)
            bsr.w   wfREQ
            bne.b   .L1
            bsr.w   CheckPhase
            bne.b   .L1
            move.b  (A3),D2
            move.b  #$10,($10,A3)
            bsr.w   wfnREQ
            bne.b   .L1
            move.b  D7,($10,A3)
            moveq   #0,D0
.L1:
            rts
GetMsg:
            move.b  #7,($30,A3)
            bsr.w   wfREQ
            bne.b   .L1
            bsr.w   CheckPhase
            bne.b   .L1
            moveq   #0,D2
            move.b  (A3),D2
            move.b  ($10,A3),D0
            bset    #4,D0
            move.b  D0,($10,A3)
            bsr.b   wfnREQ
            bne.b   .L1
            move.b  ($10,A3),D0
            bclr    #4,D0
            move.b  D0,($10,A3)
            moveq   #0,D0
.L1:
            rts
SendMsg:
            move.b  #6,($30,A3)
            bsr.b   wfREQ
            bne.b   .L1
            bsr.w   CheckPhase
            bne.b   .L1
            move.b  #1,($10,A3)
            move.b  D2,(A3)
            move.b  #$11,($10,A3)
            bsr.b   wfnREQ
            bne.b   .L1
            move.b  D7,($10,A3)
            moveq   #0,D0
.L1:
            rts
busdelay:
            move.w  TimeDBRA,D0
            lsr.w   #7,D0
L1_2:
            dbra    D0,L1_2
            rts
wfbsy:
            mulu.w  TimeSCSIDB,D1
            move.l  D1,D5
            swap    D5
            moveq   #0,D0
L1_3:
            btst    #6,($40,A3)
            dbne    D1,L1_3
            dbne    D5,L1_3
            bne.b   L2
            moveq   #2,D0
L2:
            tst.w   D0
            rts
wfnREQ:
            moveq   #0,D1
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            move.l  D1,D5
            swap    D5
            moveq   #0,D0
.L1:
            btst    #5,($40,A3)
            dbeq    D1,.L1
            dbeq    D5,.L1
            beq.b   .L2
            moveq   #2,D0
.L2:
            tst.w   D0
            rts
wfREQ:
            moveq   #0,D1
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            move.l  D1,D5
            swap    D5
            moveq   #0,D0
.L1:
            btst    #5,($40,A3)
            dbne    D1,.L1
            dbne    D5,.L1
            bne.b   .L2
            moveq   #2,D0
.L2:
            tst.w   D0
            rts
CyclePhase:
            move.w  D7,-(SP)
CyclePhase1:
            bsr.b   wfREQ
            beq.b   L1_4
            move.w  D0,(SP)
            bra.b   CycleRts
L1_4:
            btst    #3,($50,A3)
            bne.b   CycleRts
MatchPhase:
            move.b  ($30,A3),D3
            move.b  ($40,A3),D2
            asr.l   #2,D2
            andi.b  #7,D2
            move.b  D2,($30,A3)
            btst    #2,($40,A3)
            beq.b   WriteFiller
            move.b  (A3),D2
            move.b  #$10,($10,A3)
            bra.b   CycleHndshk
WriteFiller:
            move.b  #1,($10,A3)
            move.b  #$EE,(A3)
            move.b  #$11,($10,A3)
CycleHndshk:
            move.w  #$A,(SP)
            bsr.w   wfnREQ
            bne.b   CycleRts
            move.b  D7,($10,A3)
            move.b  D3,($30,A3)
            bsr.w   busdelay
            btst    #3,($50,A3)
            beq.b   CyclePhase1
CycleRts:
            move.w  (SP)+,D0
            rts
CheckPhase:
            moveq   #0,D0
            btst    #3,($50,A3)
            bne.b   L0_2
            moveq   #5,D0
L0_2:
            tst.w   D0
            rts
SCSINEW:
NEWSCSITRAP:
            movem.l D1-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            movea.l A0,A5
            movea.l ($40,A4),A3
            moveq   #0,D7
            tst.w   ($A,A5)
            beq.b   .L1
            movea.l ($200,A4),A0
            jsr     (A0)
            bra.b   .L3
.L1:
            cmpi.w  #2,D0
            bls.b   .L2
            move.w  #$FE2A,D0
            bra.b   .L3
.L2:
            lea     ($1E4,A4),A0
            movea.l (0,A0,D0.w*4),A0
            jsr     (A0)
.L3:
            movem.l (SP)+,D1-D7/A0-A5
            rts
AltBusCall:
            lea     (-$32,SP),SP
            movea.l SP,A0
            move.w  ($A,A5),($18,A0)
            move.w  D0,($1A,A0)
            move.l  A5,($20,A0)
            _Control
            lea     ($34,SP),SP
            beq.b   .L1
            move.w  #$FE2A,D0
.L1:
            rts
DoRequestIO:
            movea.l ($184,A4),A0
            jsr     (A0)
            bne.b   .L2
            moveq   #1,D0
            move.l  A5,D1
            movea.l ($168,A4),A0
            jsr     (A0)
            moveq   #0,D0
            move.l  ($20,A5),D1
            btst    #5,D1
            bne.b   .L2
.L1:
            tst.w   ($E,A5)
            bgt.b   .L1
.L2:
            rts
DoKillio:
            movea.l ($1A4,A4),A0
            jsr     (A0)
            moveq   #0,D0
            rts
DoBusInfo:
            moveq   #0,D0
            move.w  (8,A5),D1
            bne.b   check1
            move.l  D7,D1
            move.b  ($7E,A4),D1
            move.l  D1,(A5)
            rts
check1:
            subq.l  #1,D1
            bne.b   check2
            move.l  ($80,A4),(A5)
            rts
check2:
            subq.l  #1,D1
            bne.b   SCSIOops
            move.l  ($64,A4),D1
            andi.l  #$10,D1
            beq.b   DMArslt
            moveq   #1,D1
DMArslt:
            move.l  D1,(A5)
            rts
SCSIOops:
            move.w  #$FE2A,D0
            rts
; ResetBus
; Reset the SCSI bus and kill all the requests in queues
ResetBus:
            move    SR,-(SP)
            ori     #$700,SR
            move.b  #$80,($10,A3)
            lea     ($50,A4),A5
            lea     ($2A4,A4),A1
            move.w  #$FE24,D0
            movea.l ($198,A4),A0
.loop:
            movea.l (A5),A5
            cmp.l   A5,D7
            beq.b   .delay1
            cmpa.l  A1,A5
            beq.b   .killOldPB
            jsr     (A0)
            bra.b   .loop
.killOldPB:
            moveq   #-1,D1
            exg     D0,D1
            jsr     (A0)
            exg     D0,D1
            bra.b   .loop
.delay1:
            move.w  TimeDBRA,D0
            lsr.w   #2,D0
.delay:
            dbra    D0,.delay
            move.b  D7,($10,A3)
            movea.l ($16C,A4),A0
            jsr     (A0)
            move    (SP)+,SR
            move.w  TimeDBRA,D0
            mulu.w  #$1F4,D0
            move.l  D0,D1
            swap    D1
.L5:
            dbra    D0,.L5
            dbra    D1,.L5
            btst    #4,($67,A4)
            beq.b   .DMAdone
            move.l  #2,($80,A3)
.DMAdone:
            move.b  D7,($20,A3)
            rts
EnDequeue:
            move    SR,-(SP)
            ori     #$700,SR
            btst    #$1F,D0
            bne.b   .enqueue
            movem.l A2-A3,-(SP)
            movea.l ($50,A4),A2
            movea.l A2,A3
.deqLoop:
            cmpa.l  A3,A1
            beq.b   .delete
            movea.l A3,A2
            movea.l (A2),A3
            cmpa.l  ($54,A4),A2
            bne.b   .deqLoop
            bra.b   .deqDone1
.delete:
            cmpa.l  A2,A3
            bne.b   .delGeneral
            move.l  (A2),($50,A4)
            bne.b   .deqDone
            clr.l   ($54,A4)
            bra.b   .deqDone
.delGeneral:
            move.l  (A3),(A2)
            cmpa.l  ($54,A4),A1
            bne.b   .deqDone
            move.l  A2,($54,A4)
.deqDone:
            clr.l   (A1)
.deqDone1:
            movem.l (SP)+,A2-A3
            bra.b   .exit
.enqueue:
            movem.l D1/A2-A3,-(SP)
            movea.l A1,A3
.linkLoop:
            move.l  ($24,A3),D1
            beq.b   .noLink
            move.l  D1,(A3)
            movea.l D1,A3
            bra.b   .linkLoop
.noLink:
            move.l  ($50,A4),D1
            bne.b   .nonempty
            move.l  A1,($50,A4)
            move.l  A3,($54,A4)
            bra.b   .enqDone
.nonempty:
            cmpi.w  #$FFFF,D0
            bne.b   .front
            movea.l ($54,A4),A2
            move.l  A1,(A2)
            move.l  A3,($54,A4)
            bra.b   .enqDone
.front:
            move.l  D1,(A3)
            move.l  A1,($50,A4)
.enqDone:
            movem.l (SP)+,D1/A2-A3
.exit:
            move    (SP)+,SR
            moveq   #0,D0
            rts
LogError:
            cmp.l   A5,D7
            beq.b   .exit
            movea.l (4,A5),A0
            cmp.l   A0,D7
            beq.b   .exit
            tst.w   ($10,A0)
            bne.b   .exit
            move.w  D0,($10,A0)
.exit:
            rts
ClearState:
            movem.l D0-D7/A0-A5,-(SP)
            cmpi.w  #$FFFF,D0
            bne.b   newSCSIMgr
            move.l  ($50,A4),D1
            beq.b   clearGState
            moveq   #1,D0
            lea     ($2A4,A4),A1
            movea.l ($188,A4),A0
            jsr     (A0)
clearGState:
            move.b  D7,($61,A4)
            tst.b   ($7C,A4)
            beq.w   newSCSIMgr.exit
            move.b  ($60,A4),($40,A3)
            bra.w   newSCSIMgr.exit
newSCSIMgr:
            move.l  D7,($58,A4)
            movea.l A5,A1
            move.l  D0,D2
            moveq   #1,D0
            movea.l ($188,A4),A0
            jsr     (A0)
            move.l  (4,A5),D0
            beq.b   .cleanupGlobals
            movea.l D0,A0
            move.w  ($10,A0),D0
            beq.b   .rel1
            move.w  D0,D2
.rel1:
            move.l  D7,(4,A5)
            move.l  D7,(4,A0)
            move.l  D7,(8,A0)
            move.l  D7,($C,A0)
            move.l  D7,($10,A0)
            move.l  D7,($14,A0)
            move.l  D7,($18,A0)
            move.l  D7,($1C,A0)
            tst.l   ($3C,A4)
            bne.b   .cleanupGlobals
            move.l  A0,($3C,A4)
.cleanupGlobals:
            move.w  D2,($E,A5)
            lea     ($74,A4),A1
            move.l  D7,D2
            move.b  ($C,A5),D2
            move.b  ($D,A5),D1
            bclr    D1,(0,A1,D2.l)
            tst.b   (0,A1,D2.l)
            bne.b   .completion
            bclr    D2,($7C,A4)
.completion:
            move.l  ($20,A5),D0
            btst    #7,D0
            beq.b   .chkAsync
            move.l  D7,($68,A4)
.chkAsync:
            btst    #5,D0
            beq.b   .newTimeOut
            move.l  ($10,A5),D0
            beq.b   .newTimeOut
            movem.l D0-D7/A0-A5,-(SP)
            btst    #7,($67,A4)
            bne.b   .DUF
            movea.l D0,A1
            movea.l A5,A0
            jsr     (A1)
            bra.b   .afterCompletion
.DUF:
            movea.l D0,A0
            move.l  A5,D0
            nop
.afterCompletion:
            movem.l (SP)+,D0-D7/A0-A5
.newTimeOut:
            moveq   #-1,D0                          ; Start out with an "infinite" timeout
            lea     ($50,A4),A1
.loop:
            movea.l (A1),A1
            cmp.l   A1,D7
            beq.b   .setTimeOut
            move.l  (4,A1),D1
            beq.b   .loop
            movea.l D1,A0
            cmp.l   (8,A0),D0
            bcs.b   .loop
            move.l  (8,A0),D0
            bra.b   .loop
.setTimeOut:
            move.l  D0,($5C,A4)
.exit:
            movem.l (SP)+,D0-D7/A0-A5
            rts
ClearBus:
            movem.l D0-D7/A0-A5,-(SP)
            moveq   #$42,D0
            and.b   ($40,A3),D0
            beq.b   .L1
            movea.l ($1A4,A4),A0
            jsr     (A0)
.L1:
            movem.l (SP)+,D0-D7/A0-A5
            rts
Message:
            movem.l D0-D7/A0-A5,-(SP)
            bset    D0,($258,A4)
reselect:
            cmpi.b  #7,D0
            bne.b   newRequest
            move.b  D1,($25B,A4)
            bra.b   enqueueSCSIDT
newRequest:
            cmpi.b  #1,D0
            bne.b   enqueueSCSIDT
            movea.l ($188,A4),A0
            movea.l D1,A1
            move.l  ($20,A1),D1
            btst    #7,D1
            bne.b   enqInsert
            moveq   #-1,D0
            jsr     (A0)
            bra.b   enqueueSCSIDT
enqInsert:
            move.l  A1,($68,A4)
            moveq   #-2,D0
            jsr     (A0)
            movea.l ($178,A4),A0
            jsr     (A0)
enqueueSCSIDT:
            bset    #7,($7D,A4)
            bne.b   exit_3
            lea     ($24C,A4),A0
            _DTInstall
exit_3:
            movem.l (SP)+,D0-D7/A0-A5
            rts
Preflight:
            moveq   #0,D0
            tst.l   (A5)
            bne.w   noDMA.L11
            tst.l   (4,A5)
            bne.w   noDMA.L11
            tst.w   (8,A5)
            beq.w   noDMA.L11
            tst.l   ($24,A5)
            beq.b   checkPB
            bra.w   noDMA.L11
            movem.l A0/A5,-(SP)
            movea.l ($24,A5),A5
            jsr     (A0)
            movem.l (SP)+,A0/A5
checkPB:
            tst.l   ($18,A5)
            beq.w   noDMA.L11
            tst.w   ($1E,A5)
            beq.w   noDMA.L11
            cmpi.w  #1,(8,A5)
            bne.b   noDMA.L2
            move.l  ($20,A5),D2
            btst    #4,($67,A4)
            beq.b   noDMA
            andi.l  #$FFFFFF00,D2
            bra.b   noDMA.L1
noDMA:
            andi.l  #$FFFFFF10,D2
.L1:
            bne.w   .L11
.L2:
            moveq   #7,D2
            cmp.b   ($C,A5),D2
            bcs.w   .L11
            cmp.b   ($D,A5),D2
            bcs.w   .L11
            tst.l   ($30,A5)
            beq.b   .L11
            cmp.l   ($28,A5),D7
            beq.b   .L3
            cmpi.b  #4,($2C,A5)
            bcs.b   .L11
.L3:
            cmp.l   ($38,A5),D7
            bne.b   .L4
            cmp.l   ($34,A5),D7
            bne.b   .L11
            moveq   #0,D0
            bra.b   .L7
.L4:
            movea.l ($34,A5),A0
            cmp.l   A0,D7
            beq.b   .L11
.L5:
            tst.l   (A0)
            beq.b   .L6
            lea     ($10,A0),A0
            bra.b   .L5
.L6:
            tst.l   (4,A0)
            bne.b   .L11
            tst.l   (8,A0)
            bne.b   .L11
.L7:
            move.w  #1,($E,A5)
            move.b  D7,($2D,A5)
            move.l  D7,($3C,A5)
            move.b  #$FF,($2E,A5)
            tst.l   ($38,A5)
            beq.b   .L12
            movea.l ($34,A5),A0
            moveq   #-1,D2
.L8:
            move.l  (A0),D1
            beq.b   .L10
            cmp.l   D2,D1
            bne.b   .L9
            move.l  (4,A0),D1
.L9:
            move.l  D1,($C,A0)
            lea     ($10,A0),A0
            bra.b   .L8
.L10:
            move.l  D7,($C,A0)
            bra.b   .L12
.L11:
            move.w  #$FE2A,D0
.L12:
            tst.w   D0
            rts
SETUP:
            move.l  A5,($58,A4)
            move.l  Ticks,D2
            move.l  ($18,A5),D1
            asr.l   #4,D1
            movea.l (4,A5),A0
            move.l  (8,A0),D0
            bne.b   .L1
            move.l  D2,D0
            add.l   D1,D0
            move.l  D0,(8,A0)
            bra.b   .L2
.L1:
            sub.l   D2,D0
            bcs.b   .L2
            cmp.l   D1,D0
            bls.b   .L2
            move.l  D0,D1
.L2:
            move.l  D2,D0
            add.l   D1,D0
            move.l  D0,($5C,A4)
            mulu.w  #$11,D1
            move.l  D1,D0
            movea.l ($1A0,A4),A0
            jsr     (A0)
            rts
FIND:
            movem.l D1-D2/A0-A3,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            tst.l   ($58,A4)
            bne.b   .L6
            lea     ($74,A4),A1
            lea     ($50,A4),A0
            move.l  D7,D2
            btst    #$1F,D0
            beq.b   .L1
            move.b  ($7C,A4),D1
            eor.b   D1,D0
            bra.b   .L3
.L1:
            move.b  D0,D1
            bne.b   .L2
            bset    D7,D0
.L2:
            rol.w   #8,D0
.L3:
            movea.l (A0),A0
            cmp.l   A0,D7
            beq.b   .L6
            btst    #$1F,D0
            bne.b   .L4
            move.b  ($C,A0),D2
            blt.b   .L6
            btst    D2,D0
            beq.b   .L3
            move.b  ($D,A0),D2
            btst    D2,D1
            beq.b   .L3
            bra.b   .L5
.L4:
            move.b  ($C,A0),D2
            blt.b   .L6
            btst    D2,D0
            beq.b   .L3
            move.b  (0,A1,D2.w),D1
            move.b  ($D,A0),D2
            btst    D2,D1
            bne.b   .L3
.L5:
            move.l  A0,D0
            bra.b   .L7
.L6:
            move.l  D7,D0
.L7:
            move    (SP)+,SR
            movem.l (SP)+,D1-D2/A0-A3
            tst.l   D0
            rts
SETTIMER:
            lea     ($260,A4),A0
            tst.l   D0
            bne.b   .L1
            _RmvTime
            rts
.L1:
            move.l  D0,-(SP)
            _RmvTime
            _InsTime
            move.l  (SP)+,D0
            _PrimeTime
            rts
TIMETASK:
            movem.l D0-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            movea.l ($40,A4),A3
            moveq   #0,D7
            move.l  ($50,A4),D0
            beq.b   .L4
            move.l  Ticks,D0
            cmp.l   ($5C,A4),D0
            bcs.b   .L3
            movea.l ($58,A4),A5
            cmp.l   A5,D7
            beq.b   .L1
            movea.l (4,A5),A0
            cmp.l   (8,A0),D0
            bcs.b   .L3
            move.w  #$FE25,D0
            movea.l ($198,A4),A0
            jsr     (A0)
            bra.b   .L3
.L1:
            move.l  D0,D1
            move.w  #$FE25,D0
            lea     ($50,A4),A5
.L2:
            movea.l A5,A1
            movea.l (A5),A5
            cmp.l   A5,D7
            beq.b   .L3
            movea.l (4,A5),A0
            cmp.l   A0,D7
            beq.b   .L2
            cmp.l   (8,A0),D1
            bcs.b   .L2
            movea.l ($198,A4),A0
            jsr     (A0)
            movea.l A1,A5
            bra.b   .L2
.L3:
            move.l  D7,D0
            move.w  #$1388,D0
            movea.l ($1A0,A4),A0
            jsr     (A0)
.L4:
            movem.l (SP)+,D0-D7/A0-A5
            rts
SCSIDT:
            movem.l D0-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            moveq   #0,D7
            movea.l ($40,A4),A3
            movea.l ($58,A4),A5
            move.l  D7,($24C,A4)
            bclr    #7,($7D,A4)
.L1:
            tst.l   ($258,A4)
            bne.b   .chkBusReset
            move    SR,D0
            andi.w  #$700,D0
            cmpi.w  #$200,D0
            bcs.b   .chkBusReset
.waitForIRQ:
            btst    #4,($50,A3)
            beq.b   .waitForIRQ
            movea.l ($164,A4),A0
            jsr     (A0)
.chkBusReset:
            bclr    #3,($258,A4)
            beq.b   .L6
            lea     ($50,A4),A5
            lea     ($2A4,A4),A1
            move.w  #$FE24,D0
.L4:
            movea.l ($198,A4),A0
            movea.l (A5),A5
            cmp.l   A5,D7
            beq.w   .L25
            cmpa.l  A1,A5
            beq.b   .L5
            jsr     (A0)
            bra.b   .L4
.L5:
            moveq   #-1,D1
            exg     D0,D1
            jsr     (A0)
            exg     D0,D1
            bra.b   .L4
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
.L6:
            bclr    #7,($258,A4)
            beq.b   .L8
.L7:
            btst    #1,($40,A3)
            bne.b   .L7
            move.b  D7,($10,A3)
            bra.w   .L21
.L8:
            bclr    #6,($258,A4)
            beq.w   .L12
            btst    #4,($67,A4)
            beq.b   .L11
            bclr    #0,($7D,A4)
            move.l  ($80,A3),D0
            btst    #8,D0
            bne.b   .L9
            move.l  ($C0,A3),D0
            beq.b   .L10
.L9:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            bra.w   .L21
.L10:
            movea.l ($1B0,A4),A0
            jsr     (A0)
            btst    #0,($7D,A4)
            bne.w   .L25
.L11:
            bra.w   .L21
.L12:
            bclr    #5,($258,A4)
            beq.b   .L13
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            move.b  D7,($20,A3)
            bra.w   .L21
.L13:
            bclr    #1,($258,A4)
            beq.b   .L14
            bra.b   .L16
.L14:
            bclr    #4,($258,A4)
            beq.b   .L15
            move.b  D7,($20,A3)
            bra.b   .L16
.L15:
            bclr    #2,($258,A4)
            beq.b   .L16
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
.L16:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #-1,D0
            movea.l ($17C,A4),A0
            jsr     (A0)
            beq.w   .L19
            movea.l D0,A5
            tst.l   (4,A5)
            bne.b   .L18
            move.l  ($3C,A4),D0
            beq.b   .L19
            movea.l D0,A0
            move.l  A0,(4,A5)
            move.b  #1,(4,A0)
            move.l  D7,($3C,A4)
            lea     ($38,A4),A1
.L17:
            movea.l (A1),A1
            cmp.l   A1,D7
            beq.b   .L18
            tst.b   (4,A1)
            bne.b   .L17
            move.l  A1,($3C,A4)
.L18:
            movea.l ($18C,A4),A0
            jsr     (A0)
            beq.b   .L20
            movea.l (4,A5),A0
            move.b  D7,(4,A0)
            move.l  D7,(4,A5)
            tst.l   ($3C,A4)
            bne.b   .L19
            move.l  A0,($3C,A4)
.L19:
            move    (SP)+,SR
            bra.b   .L24
.L20:
            move    (SP)+,SR
            movea.l (4,A5),A0
            move.l  ($30,A5),($C,A0)
            movea.l ($180,A4),A0
            jsr     (A0)
            movea.l ($190,A4),A0
            jsr     (A0)
            beq.b   .L21
            movea.l ($174,A4),A0
            jsr     (A0)
            bra.b   .L24
.L21:
            move.l  D7,D0
.L22:
            move.b  ($40,A3),D0
            btst    #6,D0
            beq.b   .L24
            btst    #5,D0
            beq.b   .L22
            andi.b  #$1C,D0
            lea     ($84,A4),A0
            movea.l (0,A0,D0.w),A0
            lsr.b   #2,D0
            move.b  D0,($30,A3)
            addi.w  #$10,D0
            cmp.l   A5,D7
            beq.b   .L23
            move.w  D0,($E,A5)
.L23:
            jsr     (A0)
            btst    #0,($7D,A4)
            bne.b   .L24
            tst.l   ($58,A4)
            bne.b   .L21
.L24:
            tst.b   ($7C,A4)
            beq.b   .L25
            move.b  ($60,A4),($40,A3)
.L25:
            tst.l   ($68,A4)
            beq.b   .L26
            move    SR,D0
            andi.w  #$700,D0
            cmpi.w  #$200,D0
            bcc.b   .L27
.L26:
            tst.l   ($258,A4)
            bne.b   .L27
            btst    #0,($7D,A4)
            bne.b   .L28
            tst.l   ($3C,A4)
            beq.b   .L28
            tst.l   ($50,A4)
            beq.b   .L28
            moveq   #-1,D0
            movea.l ($17C,A4),A0
            jsr     (A0)
            beq.b   .L28
.L27:
            bra.w   .L1
.L28:
            tst.l   ($58,A4)
            bne.b   .L30
            movea.l ($1A0,A4),A0
            move.l  D7,D0
            tst.l   ($50,A4)
            beq.b   .L29
            move.w  #$1388,D0
.L29:
            jsr     (A0)
.L30:
            moveq   #1,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            movem.l (SP)+,D0-D7/A0-A5
            rts
COMMAND:
            movea.l (4,A5),A0
            movea.l ($C,A0),A2
            move.l  D7,D2
            move.b  ($2F,A5),D2
            subq.l  #1,D2
.L1:
            move.b  ($40,A3),D0
            btst    #6,D0
            beq.b   .L5
            btst    #5,D0
            beq.b   .L1
            btst    #3,($50,A3)
            beq.b   .L4
            move.b  (A2)+,(A3)
            move.b  #1,($10,A3)
            move.b  #$11,($10,A3)
.L2:
            btst    #6,($40,A3)
            beq.b   .L5
            btst    #5,($40,A3)
            bne.b   .L2
            move.b  D7,($10,A3)
            dbra    D2,.L1
            move.l  D7,D0
            move.w  TimeSCSIDB,D0
            lsl.l   #8,D0
            move.l  D0,D2
            swap    D2
.L3:
            btst    #6,($40,A3)
            beq.b   .L4
            btst    #3,($50,A3)
            dbeq    D0,.L3
            dbeq    D2,.L3
.L4:
            move.l  A2,($C,A0)
.L5:
            rts
STATUSPHASE:
            move.b  ($40,A3),D0
            btst    #6,D0
            beq.b   .L2
            btst    #5,D0
            beq.b   STATUSPHASE
            btst    #3,($50,A3)
            beq.b   .L2
            move.b  (A3),D0
            move.b  #$10,($10,A3)
.L1:
            btst    #6,($40,A3)
            beq.b   .L2
            btst    #5,($40,A3)
            bne.b   .L1
            move.b  D7,($10,A3)
            move.b  D0,($2E,A5)
            movea.l (4,A5),A0
            btst    #1,(4,A0)
            bne.b   .L2
            bset    #5,(4,A0)
.L2:
            rts
MSGIN:
            move.l  D7,D0
.L1:
            move.b  ($40,A3),D0
            btst    #6,D0
            beq.b   .L5
            btst    #5,D0
            beq.b   .L1
            btst    #3,($50,A3)
            beq.b   .L5
            move.b  (A3),D0
            move.b  #$10,($10,A3)
.L2:
            btst    #5,($40,A3)
            bne.b   .L2
            btst    #7,D0
            beq.b   .L3
            move.b  D0,D1
            movea.l ($E8,A4),A0
            jsr     (A0)
            bra.b   .L4
.L3:
            cmpi.b  #$23,D0
            bhi.b   .L6
            lea     ($204,A4),A0
            move.b  (0,A0,D0.l),D0
            lea     ($E4,A4),A0
            movea.l (0,A0,D0.l),A0
            jsr     (A0)
.L4:
            btst    #3,($50,A3)
            bne.b   MSGIN
.L5:
            rts
.L6:
            movea.l ($E4,A4),A0
            jsr     (A0)
            bra.b   .L4
MSGINVALIDIN:
            movea.l (4,A5),A0
            move.b  #1,(5,A0)
            move.b  #$12,($10,A3)
            move.b  #2,($10,A3)
            rts
MSGIDENTIFYIN:
            move.l  D7,D0
            move.b  ($25B,A4),D0
            move.b  D7,($25B,A4)
            rol.w   #8,D0
            andi.b  #7,D1
            bset    D1,D0
            movea.l ($17C,A4),A0
            jsr     (A0)
            movea.l D0,A5
            bne.b   .L1
            movea.l ($1A8,A4),A0
            jsr     (A0)
            rts
.L1:
            move.l  D7,D0
            move.b  ($C,A5),D0
            move.b  ($D,A5),D1
            lea     ($74,A4),A0
            bclr    D1,(0,A0,D0.w)
            tst.b   (0,A0,D0.w)
            bne.b   .L2
            bclr    D0,($7C,A4)
.L2:
            movea.l ($180,A4),A0
            jsr     (A0)
            movea.l ($F8,A4),A0
            jmp     (A0)
MSGCMDCOMPLETE:
            movea.l (4,A5),A0
            btst    #1,(4,A0)
            bne.w   .L1
            cmp.l   ($28,A5),D7
            beq.w   .L3
            move.b  ($2E,A5),D0
            andi.b  #$9E,D0
            btst    #7,D0
            bne.w   .L3
            cmpi.b  #2,D0
            bne.w   .L3
            lea     ($2A4,A4),A0
            move.l  ($10,A5),($10,A0)
            move.l  D7,($10,A5)
            move.l  ($20,A5),($20,A0)
            move.l  #2,($20,A5)
            move.l  ($24,A5),($24,A0)
            move.l  D7,($24,A5)
            lea     ($26E,A4),A1
            move.b  ($2C,A5),(4,A1)
            move.l  ($30,A5),($30,A0)
            move.l  A1,($30,A5)
            move.l  ($38,A5),($38,A0)
            move.l  D7,D0
            move.b  ($2C,A5),D0
            move.l  D0,($38,A5)
            move.l  ($3C,A5),($3C,A0)
            move.l  D7,($3C,A5)
            lea     ($274,A4),A1
            move.l  ($34,A5),($34,A0)
            move.l  A1,($34,A5)
            move.l  ($28,A5),D0
            move.l  D0,(A1)
            move.l  D0,($C,A1)
            lea     ($10,A1),A1
            move.l  ($38,A5),D0
            move.l  D0,(4,A1)
            move.l  D0,($C,A1)
            move.l  ($28,A5),($28,A0)
            move.l  D7,($28,A5)
            move.b  ($2C,A5),($2C,A0)
            move.b  D7,($2C,A5)
            move.b  ($2E,A5),($2E,A0)
            move.b  #$FF,($2E,A5)
            movea.l (4,A5),A1
            lea     ($2E4,A4),A0
            bset    #1,(4,A1)
            move.b  (5,A1),(5,A0)
            clr.b   (5,A1)
            move.l  ($C,A1),($C,A0)
            move.l  ($30,A5),($C,A1)
            move.l  ($14,A1),($14,A0)
            move.l  D7,($14,A1)
            move.l  ($18,A1),($18,A0)
            move.l  D7,($18,A1)
            move.l  D7,($58,A4)
            move.b  D7,($10,A3)
            bra.w   .L6
.L1:
            lea     ($2A4,A4),A0
            move.l  ($10,A0),($10,A5)
            move.l  ($20,A0),($20,A5)
            move.l  ($24,A0),($24,A5)
            move.l  ($30,A0),($30,A5)
            move.l  ($28,A0),($28,A5)
            move.b  ($2C,A0),($2C,A5)
            move.l  ($3C,A5),D0
            move.b  D0,($2D,A5)
            move.l  ($38,A0),($38,A5)
            move.l  ($3C,A0),($3C,A5)
            move.l  ($34,A0),($34,A5)
            move.b  ($2E,A5),D0
            move.b  ($2E,A0),($2E,A5)
            andi.b  #$9E,D0
            btst    #7,D0
            bne.b   .L2
            cmpi.b  #2,D0
            bne.b   .L2
            move.b  D7,($2D,A5)
.L2:
            movea.l (4,A5),A1
            lea     ($2E4,A4),A0
            bclr    #1,(4,A1)
            move.b  (5,A0),(5,A1)
            move.l  ($C,A0),($C,A1)
            move.l  ($14,A0),($14,A1)
            move.l  ($18,A0),($18,A1)
.L3:
            moveq   #0,D0
            movea.l (4,A5),A0
            btst    #5,(4,A0)
            bne.b   .L4
            move.w  #$FE22,D0
.L4:
            move.b  D7,($10,A3)
            movea.l ($198,A4),A0
            jsr     (A0)
.L5:
            move.l  ($24,A5),D0
            beq.b   .L6
            movea.l D0,A5
            move.w  #$FE21,D0
            jsr     (A0)
            bra.b   .L5
.L6:
            rts
MSGSAVEDATAPTR:
            movea.l ($34,A5),A0
            cmp.l   A0,D7
            beq.b   .L3
            movea.l (4,A5),A1
            move.l  ($18,A1),($14,A1)
            moveq   #-1,D0
.L1:
            move.l  (A0),D1
            beq.b   .L3
            cmp.l   D0,D1
            bne.b   .L2
            move.l  (4,A0),D1
.L2:
            move.l  D1,($C,A0)
            lea     ($10,A0),A0
            bra.b   .L1
.L3:
            move.b  D7,($10,A3)
            rts
MSGRESTOREPTRS:
            movea.l (4,A5),A0
            move.l  ($30,A5),($C,A0)
            move.l  ($14,A0),($18,A0)
            movea.l ($34,A5),A0
            cmp.l   A0,D7
            beq.b   .L4
            moveq   #-1,D0
.L1:
            move.l  ($C,A0),D3
            move.l  (A0),D1
            beq.b   .L4
            cmp.l   D0,D1
            bne.b   .L2
            move.l  D3,(4,A0)
            bra.b   .L3
.L2:
            move.l  D3,(A0)
.L3:
            lea     ($10,A0),A0
            bra.b   .L1
.L4:
            move.b  D7,($10,A3)
            rts
MSGDISCONNECT:
            move.l  D7,D1
            move.b  ($C,A5),D1
            move.b  ($D,A5),D0
            bset    D1,($7C,A4)
            lea     ($74,A4),A0
            bset    D0,(0,A0,D1.w)
            move.l  D7,($58,A4)
            move.w  #4,($E,A5)
            move.b  D7,($10,A3)
            rts
MSGMSGREJIN:
            move.b  D7,($10,A3)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
MSGLCCF:
            moveq   #0,D0
            movea.l (4,A5),A0
            btst    #5,(4,A0)
            bne.b   .L1
            move.w  #$FE22,D0
.L1:
            move.b  D7,($10,A3)
            movea.l ($198,A4),A0
            jsr     (A0)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
MSGOUT:
            moveq   #4,D0
            tst.l   ($58,A4)
            beq.b   .L2
.L1:
            btst    #6,($40,A3)
            beq.b   .L3
            btst    #5,($40,A3)
            beq.b   .L1
            btst    #3,($50,A3)
            beq.b   .L3
            movea.l (4,A5),A0
            move.l  D7,D0
            move.b  (5,A0),D0
            cmpi.b  #$23,D0
            bls.b   .L2
            moveq   #2,D0
.L2:
            lea     ($228,A4),A0
            move.b  (0,A0,D0.l),D0
            lea     ($E4,A4),A0
            movea.l (0,A0,D0.l),A0
            jsr     (A0)
            bra.b   MSGOUT
.L3:
            rts
MSGIDENTIFYOUT:
            move.b  ($D,A5),D1
            ori.b   #$C0,D1
            move.l  ($20,A5),D0
            btst    #7,D0
            bne.b   .L1
            btst    #1,D0
            beq.b   .L2
.L1:
            bclr    #6,D1
.L2:
            move.b  D1,(A3)
            move.b  D7,($10,A3)
            move.b  #1,($10,A3)
            move.b  #$11,($10,A3)
.L3:
            btst    #5,($40,A3)
            bne.b   .L3
            move.b  D7,($10,A3)
            movea.l (4,A5),A0
            move.b  #4,(5,A0)
            rts
MSGMSGREJOUT:
            move.b  #7,(A3)
            move.b  D7,($10,A3)
            move.b  #1,($10,A3)
            move.b  #$11,($10,A3)
.L1:
            btst    #5,($40,A3)
            bne.b   .L1
            move.b  D7,($10,A3)
            movea.l (4,A5),A0
            move.b  #4,(5,A0)
            rts
MSGINVALIDOUT:
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
MSGBUSDEVRST:
            rts
MSGKILLIO:
            movea.l ($1A4,A4),A0
            jsr     (A0)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
MSGNOOP:
            move.b  #8,(A3)
            move.b  #1,($10,A3)
            move.b  #$11,($10,A3)
.L1:
            btst    #5,($40,A3)
            bne.b   .L1
            move.b  D7,($10,A3)
            rts
DATAIO:
            move.w  #$FE29,D0
            tst.l   ($38,A5)
            beq.b   .L2
            moveq   #$1C,D4
            and.l   ($20,A5),D4
            movea.l (4,A5),A0
            move.l  ($18,A0),D5
            btst    #2,($40,A3)
            bne.b   .L3
            btst    #2,D4
            bne.b   .L5
.L1:
            move.w  #$FE28,D0
.L2:
            movea.l ($174,A4),A0
            jsr     (A0)
            bra.w   .L15
.L3:
            btst    #2,D4
            bne.b   .L1
            move.b  #2,($20,A3)
            btst    #4,($67,A4)
            beq.b   .L4
            move.l  #8,($80,A3)
.L4:
            move.b  D7,($70,A3)
.L5:
            movea.l ($34,A5),A1
.L6:
            move.l  (4,A1,D5.l),D2
            move.l  (0,A1,D5.l),D0
            beq.w   .L14
            movea.l D0,A2
            addq.l  #1,D0
            beq.w   .L13
.L7:
            btst    #6,($50,A3)
            bne.b   .L8
            btst    #5,($40,A3)
            beq.b   .L7
.L8:
            btst    #3,($50,A3)
            beq.w   .L14
            move.l  ($1C,A0),D0
            beq.b   .L9
            sub.l   D0,D2
            adda.l  D0,A2
.L9:
            move.l  ($3C,A5),D0
            add.l   D2,D0
            cmp.l   ($38,A5),D0
            bls.b   .L10
            move.w  #$FE29,D0
            movea.l ($174,A4),A0
            jsr     (A0)
            bra.b   .L14
.L10:
            movea.l ($19C,A4),A0
            jsr     (A0)
            tst.w   D0
            bne.b   .L14
            btst    #0,($7D,A4)
            bne.b   .L15
            movea.l (4,A5),A0
            add.l   D1,($3C,A5)
            cmp.l   D1,D2
            beq.b   .L11
            add.l   D1,($1C,A0)
            bra.b   .L6
.L11:
            move.l  (8,A1,D5.l),D0
            add.l   D0,(0,A1,D5.l)
            move.l  D7,($1C,A0)
.L12:
            moveq   #$10,D0
            add.l   D0,D5
            movea.l (4,A5),A0
            move.l  D5,($18,A0)
            bra.w   .L6
.L13:
            tst.l   D2
            beq.b   .L12
            subq.l  #1,D2
            move.l  D2,(4,A1,D5.l)
            beq.b   .L12
            move.l  (8,A1,D5.l),D0
            asl.l   #4,D0
            add.l   D0,D5
            movea.l (4,A5),A0
            move.l  D5,($18,A0)
            bra.w   .L6
.L14:
            move.b  D7,($20,A3)
            btst    #4,($67,A4)
            beq.b   .L15
            move.l  #2,($80,A3)
.L15:
            moveq   #0,D0
            rts
DATADMA:
            movea.l ($34,A5),A1
            movea.l (4,A5),A0
            lea     ($20,A0),A2
            move.l  ($18,A0),D5
            move.l  ($C,A2),D1
            add.l   D1,($3C,A5)
            tst.l   (4,A2)
            beq.b   .L1
            add.l   D1,($1C,A0)
            bra.b   .L3
.L1:
            move.l  (8,A1,D5.l),D0
            add.l   D0,(0,A1,D5.l)
            move.l  D7,($1C,A0)
.L2:
            moveq   #$10,D0
            add.l   D0,D5
            move.l  D5,($18,A0)
.L3:
            move.l  (4,A1,D5.l),D2
            move.l  (0,A1,D5.l),D0
            beq.w   .L9
            movea.l D0,A2
            addq.l  #1,D0
            beq.w   .L8
.L4:
            btst    #6,($50,A3)
            bne.b   .L5
            btst    #5,($40,A3)
            beq.b   .L4
.L5:
            btst    #3,($50,A3)
            beq.w   .L9
            move.l  ($1C,A0),D0
            beq.b   .L6
            sub.l   D0,D2
            adda.l  D0,A2
.L6:
            move.l  ($3C,A5),D0
            add.l   D2,D0
            cmp.l   ($38,A5),D0
            bls.b   .L7
            move.w  #$FE29,D0
            movea.l ($174,A4),A0
            jsr     (A0)
            bra.b   .L9
.L7:
            moveq   #0,D0
            move.l  D2,D1
            beq.b   .L1
            moveq   #$1C,D4
            and.l   ($20,A5),D4
            lea     ($A4,A4),A0
            movea.l (0,A0,D4.l),A0
            jmp     (A0)
.L8:
            tst.l   D2
            beq.b   .L2
            subq.l  #1,D2
            move.l  D2,(4,A1,D5.l)
            beq.b   .L2
            move.l  (8,A1,D5.l),D0
            asl.l   #4,D0
            add.l   D0,D5
            movea.l (4,A5),A0
            move.l  D5,($18,A0)
            bra.w   .L3
.L9:
            move.b  D7,($20,A3)
            move.l  #2,($80,A3)
            moveq   #0,D0
            rts
            ds.b    10
SCSIHW:
CLEARIRQ:
            move.b  ($70,A3),D1
            bra.w   ClearSCSIInt
DISENABLE:
            tst.l   D0
            beq.b   .L1
            bra.w   EnableSCSIInts
.L1:
            bra.w   DisableSCSIInts
BUSERRHANDLER:
            subq.w  #1,(-6,A6)
            beq.b   sub_40808A7A
            move.l  D0,-(SP)
            move.w  TimeDBRA,D0
            lsr.w   #4,D0
.L1:
            dbra    D0,.L1
            move.l  (SP)+,D0
            rte
sub_40808A7A:
            move.w  (SP),D0
            bfextu  (6,SP){0:4},D1
            bra.w   sub_40808E80.L1
.L1:
            bne.b   .L2
            lea     ($20,SP),SP
            bra.b   .L3
.L2:
            lea     ($5C,SP),SP
.L3:
            move.w  D7,-(SP)
            pea     .L4
            move.w  D0,-(SP)
            rte
.L4:
            dc.w    $60FF,$0008,$FC04
            ds.b    6
ARB:
            movem.l D1-D2/A0-A3,-(SP)
            move.w  #2,($E,A5)
            moveq   #0,D0
            btst    #1,($67,A4)
            beq.b   .notGDUOSS
            btst    #4,($67,A4)
            beq.b   .notGDUOSS
            move.l  #$FFFFFFFF,($140,A3)
            move.l  ($6C,A4),($80,A3)
            move.b  #1,($20,A3)
            move.w  TimeDBRA,D2
            lsr.w   #6,D2
.delay:
            dbra    D2,.delay
            move.l  ($80,A3),D1
            btst    #$D,D1
            beq.b   .busyGDU
            move.b  ($70,A3),D1
            move.l  #2,($80,A3)
            bra.b   .exit
.busyGDU:
            move.l  #2,($80,A3)
            bra.b   .L4
.notGDUOSS:
            move.b  ($60,A4),(A3)
            move.b  #1,($20,A3)
            btst    #6,($10,A3)
            beq.b   .L4
            movea.l ($194,A4),A0
            jsr     (A0)
            btst    #5,($10,A3)
            bne.b   .L4
            move.b  ($60,A4),D2
            move.b  (A3),D1
            eor.b   D2,D1
            cmp.b   D2,D1
            bhi.b   .L4
            btst    #5,($10,A3)
            beq.b   .exit
.L4:
            bsr.w   sub_40808E6C
            move.b  #4,($20,A3)
            moveq   #3,D0
.exit:
            movem.l (SP)+,D1-D2/A0-A3
            tst.l   D0
            rts
; Sel
Sel:
            movem.l D1-D7/A0-A5,-(SP)
            move.w  #3,($E,A5)
            move.b  #$C,($10,A3)
            move.b  D7,($20,A3)
            movea.l ($194,A4),A0
            jsr     (A0)                            ; Go to the routine
            move.b  D7,($30,A3)
            moveq   #1,D1
            move.b  ($C,A5),D2
            lsl.b   D2,D1
            or.b    ($60,A4),D1
            move.b  D1,(A3)
            move.b  #$F,($10,A3)
            move.b  D7,($40,A3)
            move.l  D7,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            move.b  #7,($10,A3)
            movea.l ($194,A4),A0
            jsr     (A0)
            move.w  ($1E,A5),D2
            mulu.w  TimeSCSIDB,D2
            move.l  D2,D0
            swap    D0
.L1:
            btst    #6,($40,A3)
            dbne    D2,.L1
            dbne    D0,.L1
            bne.b   .L3
            move.b  #4,($10,A3)
            move.w  TimeSCSIDB,D2
            lsr.w   #2,D2
.L2:
            dbra    D2,.L2
            btst    #6,($40,A3)
            bne.b   .L3
            move.w  #$FE26,D0
            move.b  D7,($10,A3)
            bra.b   .L4
.L3:
            movea.l ($194,A4),A0
            jsr     (A0)
            move.b  #2,($10,A3)
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1-D7/A0-A5
            tst.l   D0
            rts
DELAY22:
            movea.l VIA,A0
            tst.b   (vIFR,A0)
            tst.b   (vIFR,A0)
            tst.b   (vIFR,A0)
            rts
; SCSIIntHnd
SCSIIntHnd:
            movem.l D0-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            movea.l ($58,A4),A5
            moveq   #0,D7
            move.l  D7,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            movea.l ($40,A4),A3
            move    SR,-(SP)
            ori     #$700,SR
            move.b  ($50,A3),D0
            btst    #4,D0
            beq.w   .L1
            lsl.w   #8,D0
            move.b  ($40,A3),D0
            move.w  D0,D1
            andi.w  #$F5E2,D1
            cmpi.w  #$1002,D1
            bne.b   .L2
            move.b  (A3),D1
            beq.w   .L1
            move.b  ($60,A4),D0
            eor.b   D0,D1
            beq.w   .L1
            move.b  D7,($40,A3)
            move.b  ($10,A3),D0
            ori.b   #8,D0
            move.b  D0,($10,A3)
            moveq   #7,D0
            bra.b   .L3
.L2:
            move.w  D0,D1
            andi.w  #$F6C2,D1
            cmpi.w  #$9040,D1
            bne.b   .L4
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            moveq   #6,D0
            bra.b   .L3
.L4:
            move.w  D0,D1
            andi.w  #$BDE2,D1
            cmpi.w  #$1060,D1
            bne.b   .L5
            moveq   #5,D0
            bra.b   .L3
.L5:
            move.w  D0,D1
            andi.w  #$F7FF,D1
            cmpi.w  #$1400,D1
            bne.b   .L6
            moveq   #4,D0
            bra.b   .L3
.L6:
            move.w  D0,D1
            andi.w  #$F77F,D1
            cmpi.w  #$1000,D1
            bne.b   .L7
            bra.b   .L1
.L7:
            move.w  D0,D1
            andi.w  #$BCC2,D1
            cmpi.w  #$3840,D1
            bne.b   .L1
            moveq   #2,D0
.L3:
            movea.l ($168,A4),A0
            jsr     (A0)
            movea.l ($16C,A4),A0
            jsr     (A0)
            move    (SP)+,SR
            bra.b   .L8
.L1:
            move    (SP)+,SR
            btst    #4,($67,A4)
            beq.b   .L9
            move.l  ($80,A3),D0
            btst    #7,D0
            beq.b   .L9
            move.w  #$FE27,D0
            movea.l ($174,A4),A0
            jsr     (A0)
            moveq   #-1,D0
            move.l  D0,($140,A3)
.L9:
            movea.l ($16C,A4),A0
            jsr     (A0)
            moveq   #1,D0
            movea.l ($170,A4),A0
            jsr     (A0)
.L8:
            movem.l (SP)+,D0-D7/A0-A5
            rts
; Transfer
Transfer:
            link.w  A6,#-6
            bsr.w   sub_40808F02
            nop
            moveq   #0,D0                           ; Assume no error
            move.l  D2,D1                           ; Make a copy of the count
            beq.b   .exit                           ; Exit if count is zero
            movem.l D2-D6/A1-A5,-(SP)
            lea     ($50,A3),A1
            moveq   #6,D3
            move.l  BusErrVct,(-4,A6)
            move.l  ($1AC,A4),BusErrVct
            lea     ($A4,A4),A0
            movea.l (0,A0,D4.l),A0
            jsr     (A0)
.done:
            move.l  (-4,A6),BusErrVct
            movem.l (SP)+,D2-D6/A1-A5
            tst.w   D0
.exit:
            unlk    A6
            rts
; SlowRead
SlowRead:
            movea.l ($44,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.wait:
            btst    D3,(A1)
            bne.b   .SnRd
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            beq.b   .RdPhaseErr
.SnRd:
            btst    D3,(A1)
            beq.b   .SnRdChk
            move.b  (A0),(A2)+
            dbra    D2,.SnRd
            dbra    D5,.SnRd
            bra.b   .RdDone
.SnRdChk:
            bsr.w   NewPhaseCheck
            bne.b   .SnRd
.RdPhaseErr:
            moveq   #5,D0
            bra.b   .exit
.RdDone:
            btst    #0,($50,A3)
            beq.b   .exit
            btst    #5,($40,A3)
            beq.b   .exit
            btst    #3,(A1)
            bne.b   .RdDone
.exit:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            rts
; SlowWrite
SlowWrite:
            movea.l ($44,A4),A0
            adda.w  ($4C,A4),A0
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L2
            move.l  #$A,($80,A3)
.L2:
            move.b  D7,($50,A3)
            btst    #3,(A1)
            bne.b   .L3
            moveq   #5,D0
            bra.b   .L6
.L3:
            move.l  D2,D1
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.L4:
            btst    D3,(A1)
            beq.b   .L5
            move.b  (A2)+,(A0)
            dbra    D2,.L4
            dbra    D5,.L4
            bra.b   .L6
.L5:
            btst    #3,(A1)
            bne.b   .L4
            moveq   #5,D0
            bra.b   .L9
.L6:
            btst    #4,($67,A4)
            beq.b   .L8
.L7:
            btst    D3,($50,A3)
            bne.b   .L9
            btst    #3,($50,A3)
            bne.b   .L7
.L8:
            btst    D3,($50,A3)
            bne.b   .L9
            btst    #3,($50,A3)
            bne.b   .L8
.L9:
            move.b  D7,($10,A3)
            move.b  D7,($20,A3)
            btst    #4,($67,A4)
            beq.b   .DMAdone2
            move.l  #2,($80,A3)
.DMAdone2:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            rts
VFASTWRITEOSS:
            movea.l (4,A5),A0
            lea     ($20,A0),A0
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,(A0)
            move.l  D2,(4,A0)
            moveq   #1,D0
            movea.l D0,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.b   .L1
            movea.l (8,A0),A2
            move.l  ($C,A0),D2
            move.l  D2,D1
            movea.l ($C0,A4),A0
            jmp     (A0)
.L1:
            rts
sub_40808E6C:
            bset    #0,($7D,A4)
            move.b  D7,($20,A3)
            rts
NewPhaseCheck:
            moveq   #$48,D6
            and.b   ($50,A3),D6
            rts
sub_40808E80:
            bset    #1,($7D,A4)
            move.l  ($68,A4),($140,A3)
            rts
.L1:
            cmpi.b  #7,D1
            beq.b   .L2
            cmpi.b  #$A,D1
            bra.w   sub_40808A7A.L1
.L2:
            lea     ($3C,SP),SP
            bra.w   sub_40808A7A.L3
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFASTWRITEOSS:
            moveq   #0,D0
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            move.l  #8,($80,A3)
            move.b  D7,($50,A3)
            move.l  #$FFFFFFFF,($140,A3)
            move.l  #7,($80,A3)
            move.l  A2,($100,A3)
            move.l  D2,($C0,A3)
            move.b  #$A,($20,A3)
            move.b  #1,($10,A3)
            move.b  D7,($50,A3)
            bset    #0,($7D,A4)
            rts
sub_40808F02:
            moveq   #5,D0
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #1,D0
.L1:
            move.w  D0,(-6,A6)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFASTWRITE:
            rts
vFastWrite:
FASTWRITE:
            movea.l ($48,A4),A0
            adda.w  ($4C,A4),A0
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L2
            move.l  #$A,($80,A3)
.L2:
            move.b  D7,($50,A3)
.L3:
            btst    D3,(A1)
            bne.b   .L4
            btst    #5,($40,A3)
            beq.b   .L3
            btst    #3,(A1)
            bne.b   .L3
            moveq   #5,D0
            bra.w   .L12
.L4:
            move.l  D2,D1
            moveq   #3,D4
            cmp.l   D4,D2
            bhi.b   .L5
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .L11
.L5:
            move.l  A2,D5
            neg.l   D5
            and.l   D4,D5
            sub.l   D5,D2
            bra.b   .L7
.L6:
            move.b  (A2)+,(A0)
.L7:
            dbra    D5,.L6
            move.l  D2,D5
            lsr.l   #5,D5
            bne.b   .L8
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .L11
.L8:
            subq.l  #1,D5
            move.l  D5,D6
            swap    D6
            moveq   #$1F,D4
            and.l   D4,D2
.L9:
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            dbra    D5,.L9
            dbra    D6,.L9
            bra.b   .L11
.L10:
            move.b  (A2)+,(A0)
.L11:
            dbra    D2,.L10
            swap    D6
            move.w  D5,D6
            addq.l  #1,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
.L12:
            btst    #4,($67,A4)
            beq.b   .L14
.L13:
            btst    D3,($50,A3)
            bne.b   .L15
            btst    #3,($50,A3)
            bne.b   .L13
.L14:
            btst    D3,($50,A3)
            bne.b   .L15
            btst    #3,($50,A3)
            bne.b   .L14
.L15:
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L16
            move.l  #2,($80,A3)
.L16:
            rts
FASTWRITEOSS:
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,-(SP)
            lea     (-$14,SP),SP
            move.l  D0,(SP)
            move.l  D2,(4,SP)
            bsr.w   sub_40809148
            bne.w   .L8
            movea.l SP,A0
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .L8
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            moveq   #8,D5
            move.l  D5,($80,A3)
            move.b  D7,($50,A3)
.L2:
            btst    D3,($50,A3)
            bne.b   .L3
            btst    #5,($40,A3)
            beq.b   .L2
            btst    #3,($50,A3)
            bne.b   .L2
            moveq   #5,D0
            bra.w   .L6
.L3:
            nop
            bsr.w   sub_40808E80
            moveq   #7,D5
            move.l  D5,($80,A3)
            move.l  (8,A0),($100,A3)
            move.l  ($C,A0),($C0,A3)
            move.b  #$A,($20,A3)
            move.b  #1,($10,A3)
            move.b  D7,($50,A3)
            move.l  (4,A0),($C,A0)
            beq.b   .L4
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .L8
.L4:
            movea.l VIA2,A1
.L5:
            btst    #1,($202,A1)
            beq.b   .L5
            move.l  ($80,A3),D5
            andi.w  #$180,D5
            bne.b   .L8
            tst.l   ($C0,A3)
            bne.b   .L8
            move.b  D7,($20,A3)
            tst.b   ($70,A3)
            tst.l   ($C,A0)
            bne.b   .L3
            move.l  D2,D1
.L6:
            btst    #0,($50,A3)
            beq.b   .L7
            btst    #5,($40,A3)
            beq.b   .L7
            btst    #3,($50,A3)
            bne.b   .L6
.L7:
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            moveq   #2,D5
            move.l  D5,($80,A3)
            lea     ($14,SP),SP
            bra.b   .L9
.L8:
            moveq   #9,D0
            bra.b   .L7
            rts
.L9:
            bra.w   VFASTREADOSS.L2
sub_40809148:
            movea.l D0,A0
            movea.l D2,A1
            moveq   #2,D0
            _MemoryDispatch
            rts
            nop
            nop
VFASTREADOSS:
            movea.l (4,A5),A0
            lea     ($20,A0),A0
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,(A0)
            move.l  D2,(4,A0)
            moveq   #1,D0
            movea.l D0,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.b   .L1
            movea.l (8,A0),A2
            move.l  ($C,A0),D2
            move.l  D2,D1
            movea.l ($BC,A4),A0
            jmp     (A0)
.L1:
            rts
.L2:
            bclr    #1,($7D,A4)
            movea.l (SP)+,A0
            movea.l D2,A1
            move.w  D0,-(SP)
            moveq   #3,D0
            _MemoryDispatch
            move.w  (SP)+,D0
            rts
DMAPENDINGPATCH:
            btst    #7,($61,A4)
            bne.b   .L1
            btst    #1,($7D,A4)
.L1:
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFastReadOSS:
            moveq   #0,D0
            move.l  #$FFFFFFFF,($140,A3)
            move.l  #7,($80,A3)
            move.l  A2,($100,A3)
            move.l  D2,($C0,A3)
            move.b  #$A,($20,A3)
            move.b  D7,($70,A3)
            bset    #0,($7D,A4)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
; PFastRead
PFastRead:
            rts                                     ; Unimplemented
vFastRead:
FastRead:
            movea.l ($48,A4),A0
            adda.w  #$60,A0
.wait:
            btst    D3,(A1)
            bne.b   .start
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            bne.b   .start
            moveq   #5,D0
            bra.w   .exit
.start:
            move.l  D2,D1
            moveq   #3,D4
            cmp.l   D4,D2
            bhi.b   .over3
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .BlRdRmdr
.over3:
            move.l  A2,D5
            neg.l   D5
            and.l   D4,D5
            sub.l   D5,D2
            bra.b   .L5
.L4:
            move.b  (A0),(A2)+
.L5:
            dbra    D5,.L4
            move.l  D2,D5
            lsr.l   #5,D5
            bne.b   .over32
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .BlRdRmdr
.over32:
            subq.l  #1,D5
            move.l  D5,D6
            swap    D6
            moveq   #$1F,D4
            and.l   D4,D2
.BlRd32:
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            dbra    D5,.BlRd32
            dbra    D6,.BlRd32
            bra.b   .BlRdRmdr
.BlRdSingle:
            move.b  (A0),(A2)+
.BlRdRmdr:
            dbra    D2,.BlRdSingle
            swap    D6
            move.w  D5,D6
            addq.l  #1,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
.RdDone:
            btst    #0,($50,A3)
            beq.b   .exit
            btst    #5,($40,A3)
            beq.b   .exit
            btst    #3,(A1)
            bne.b   .RdDone
.exit:
            rts
FASTREADOSS:
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,-(SP)
            lea     (-$14,SP),SP
            move.l  D0,(SP)
            move.l  D2,(4,SP)
            bsr.w   sub_40809148
            bne.w   .badAddrError
            movea.l SP,A0
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .badAddrError
.wait:
            btst    D3,($50,A3)
            bne.b   .start
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,($50,A3)
            bne.b   .start
            moveq   #5,D0
            bra.w   .L6
.start:
            nop
            bsr.w   sub_40808E80
            moveq   #7,D5
            move.l  D5,($80,A3)
            move.l  (8,A0),($100,A3)
            move.l  ($C,A0),($C0,A3)
            move.b  #$A,($20,A3)
            move.b  D7,($70,A3)
            move.l  (4,A0),($C,A0)
            beq.b   .L3
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .badAddrError
.L3:
            movea.l VIA2,A1
.L4:
            btst    #1,($202,A1)
            beq.b   .L4
            move.l  ($80,A3),D5
            andi.w  #$180,D5
            bne.b   .badAddrError
            tst.l   ($C0,A3)
            bne.b   .badAddrError
            move.b  D7,($20,A3)
            tst.b   ($70,A3)
            move.b  #2,($20,A3)
            move.b  D7,($70,A3)
            tst.l   ($C,A0)
            bne.b   .start
            move.l  D2,D1
.L5:
            btst    #0,($50,A3)
            beq.b   .L6
            btst    #5,($40,A3)
            beq.b   .L6
            btst    #3,($50,A3)
            bne.b   .L5
.L6:
            lea     ($14,SP),SP
            bra.w   VFASTREADOSS.L2
.badAddrError:
            moveq   #9,D0
            bra.b   .L6
            rts
            nop
            nop
            nop
            nop
            nop
            nop
SlowComp:
            movea.l ($44,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.L1:
            btst    #6,(A1)
            bne.b   .L2
            btst    #5,($40,A3)
            beq.b   .L1
            btst    #3,(A1)
            beq.b   .L5
.L2:
            btst    #6,(A1)
            beq.b   .L4
            move.b  (A0),D3
            cmp.b   (A2)+,D3
            beq.b   .L3
            moveq   #6,D0
.L3:
            dbra    D2,.L2
            dbra    D5,.L2
            bra.b   .L6
.L4:
            bsr.w   NewPhaseCheck
            bne.b   .L2
.L5:
            moveq   #5,D0
            bra.b   .L7
.L6:
            btst    #0,($50,A3)
            beq.b   .L7
            btst    #5,($40,A3)
            beq.b   .L7
            btst    #3,(A1)
            bne.b   .L6
.L7:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            moveq   #6,D3
            rts
FastComp:
            movea.l ($48,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.wait:
            btst    #6,(A1)
            bne.b   .BlCmp
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            bne.b   .BlCmp
            moveq   #5,D0
            bra.b   .L5
.BlCmp:
            move.b  (A0),D3
            cmp.b   (A2)+,D3
            beq.b   .BlCmp1
            moveq   #6,D0
.BlCmp1:
            dbra    D2,.BlCmp
            dbra    D5,.BlCmp
.RdDone:
            btst    #0,($50,A3)
            beq.b   .L5
            btst    #5,($40,A3)
            beq.b   .L5
            btst    #3,(A1)
            bne.b   .RdDone
.L5:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            moveq   #6,D3
            rts
            ds.b    4
SCSIInit:
InitSCSIMgr:
            movem.l D0-D7/A0-A5,-(SP)
            moveq   #0,D7
            move.l  #$404,D0
            _NewPtrSysClear
            bne.w   INITSCSIDONE
            move.l  A0,SCSIGlobals
            movea.l A0,A4
            bsr.l   INITSCSIMGRPATCH1
            nop
            btst    #4,($67,A4)
            beq.b   .DMAdone
            movea.l SCSIBase,A3
            move.l  #2,($80,A3)
.DMAdone:
            moveq   #$D,D1
            lea     SCSIMgr,A1
            move.l  A1,D0
            lea     OffsetTbl,A1
            movea.l A4,A0
.MakeJmpTbl:
            moveq   #0,D2
            move.w  (A1)+,D2
            add.l   D0,D2
            move.l  D2,(A0)+
            dbra    D1,.MakeJmpTbl
            lea     ($40,A4),A0
            move.l  SCSIBase,(A0)+
            move.l  SCSIDMA,(A0)+
            move.l  SCSIHsk,(A0)+
            clr.w   (A0)+
            moveq   #-1,D0
            move.l  D0,($5C,A4)
            subq.l  #2,SP
            movea.l SP,A0
            move.l  #$20002,D0
            _ReadXPRam
            move.w  (SP),D0
            andi.w  #$7878,D0
            cmpi.w  #$4848,D0
            beq.b   .L3
            move.w  #$4F48,(SP)
            movea.l SP,A0
            move.l  #$20002,D0
            _WriteXPRam
.L3:
            move.w  (SP),D0
            andi.w  #$707,D0
            move.b  D0,SCSIPoll
            lsr.w   #8,D0
            moveq   #1,D1
            lsl.b   D0,D1
            move.b  D1,($60,A4)
            move.b  D1,SCSIDrvrs
            btst    #4,($67,A4)
            beq.b   .noDCTRL
            andi.l  #7,D0
            moveq   #9,D1
            lsl.l   D1,D0
            ori.l   #$1002,D0
            move.l  D0,($6C,A4)
.noDCTRL:
            move.w  #250,($62,A4)
            move.b  #1,($7E,A4)
            move.l  #4,($80,A4)
            btst    #4,($67,A4)
            beq.b   .initPhaseTable
            move.l  #$19999999,($80,A4)
.initPhaseTable:
            moveq   #$5F,D1
            lea     SCSIMgr,A1
            move.l  A1,D0
            lea     OffsetTbl2,A1
            lea     ($84,A4),A0
.MakeJmpTbl2:
            moveq   #0,D2
            move.w  (A1)+,D2
            beq.b   .zero
            add.l   D0,D2
            move.l  D2,(A0)+
            bra.b   .loop
.zero:
            move.l  D7,(A0)+
.loop:
            dbra    D1,.MakeJmpTbl2
            moveq   #$11,D1
            lea     msgTbl,A1
            lea     ($204,A4),A0
.makeMsgTbl:
            move.l  (A1)+,(A0)+
            dbra    D1,.makeMsgTbl
            lea     ($24C,A4),A1
            move.w  #7,(4,A1)
            lea     SCSIDT,A0
            move.l  A0,(8,A1)
            lea     ($260,A4),A0
            lea     TIMETASK,A1
            move.l  A1,(6,A0)
            _InsTime
            move.w  #$300,($26E,A4)
            lea     ($274,A4),A1
            moveq   #1,D0
            move.l  D0,(4,A1)
            move.l  D0,(8,A1)
            lea     ($10,A1),A1
            moveq   #-1,D0
            move.l  D0,(A1)
            move.l  D0,(8,A1)
            lea     ($2A4,A4),A1
            st      ($C,A1)
            lea     ($2E4,A4),A0
            move.l  A0,(4,A1)
            lea     ($344,A4),A1
            move.l  A1,($38,A4)
            move.l  A1,($3C,A4)
            move.l  A1,D0
            moveq   #$30,D1
            add.l   D1,D0
            move.l  D0,(A1)
            movea.l D0,A1
            add.l   D1,D0
            move.l  D0,(A1)
            bsr.l   INITSCSIMGRPATCH2
            btst    #4,($67,A4)
            beq.b   .L10
            btst    #1,($67,A4)
            bra.b   .L10
            lea     VFASTREADOSS,A0
            move.l  A0,($AC,A4)
            lea     VFASTWRITEOSS,A0
            move.l  A0,($B0,A4)
            lea     PFastReadOSS,A0
            move.l  A0,($BC,A4)
            lea     PFASTWRITEOSS,A0
            move.l  A0,($C0,A4)
            lea     FASTREADOSS,A0
            move.l  A0,($CC,A4)
            lea     FASTWRITEOSS,A0
            move.l  A0,($D0,A4)
.L10:
            btst    #1,($67,A4)
            bne.b   .L11
            btst    #2,($67,A4)
            beq.b   .L12
.L11:
            lea     SCSIIntHnd,A1
            move.l  A1,($D7C).w
.L12:
            btst    #3,($67,A4)
            beq.b   SCSIINTHNDRESUME.L2
            lea     SCSIIntHnd,A1
            bra.l   INSTALLSCSIINTHND96
SCSIINTHNDRESUME:
            beq.b   .L1
            move.l  A1,($D7C).w
            bra.b   .L2
.L1:
            move.l  A1,($D7C).w
.L2:
            btst    #$F,(SP)
            bne.b   .L3
            clr.w   -(SP)
            _SCSIDispatch
.L3:
            addq.l  #2,SP
INITSCSIDONE:
            movem.l (SP)+,D0-D7/A0-A5
            rts
OffsetTbl:
            dc.w    $0052,$007C,$00CC,$00F4,$01D2,$0120,$0118,$0028
            dc.w    $011C,$0114,$002E,$00CC,$0230,$0244
OffsetTbl2:
            dc.w    $13F8,$13F8,$0DD6,$0E4C,$05A4,$05A4,$1276,$0E98
            dc.w    $18DA,$1934,$1DEE,$1AF4
            ds.b    4
            dc.w    $1DEC,$1AF2,$18DA,$1934,$1DEE,$1AF4,$1F6E,0
            dc.w    $1FD4,0,$0EFC,$0F14,$0F60,0,$1122,$1152
            dc.w    $118C,$11B2,$1208
            ds.b    14
            dc.w    $12BE,$1304,$1330,$1382,$13DA,$1380
            ds.b    20
            dc.w    $179C,$07D4,$15F0,$15F8,$06A6,$0A6C,$0966,$0924
            dc.w    $0826,$0618,$1648,$16EC,$178A,$06BE,$189A,$09DC
            dc.w    $05A4,$07BC,$1604,$1518
            ds.b    24
            dc.w    $053C,$0562,$056C
            ds.b    8
            dc.w    $051A
msgTbl:
            dc.w    $0800,$1014,$1800,$001C
            ds.b    28
            dc.b    '@DHLPTHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'
            ds.b    30
SCSISetFlags:
            movem.l D1/A0,-(SP)
            moveq   #0,D0
            btst    #VIA2Exists-8,(AddrMapFlags+2).w ; TestFor VIA2Exists
            beq.b   .L1
            bset    #sVIA2Exists,D0
.L1:
            btst    #RBVExists-8,(AddrMapFlags+2).w ; TestFor RBVExists
            beq.b   .L2
            bset    #sRBVExists,D0
.L2:
            btst    #SCSIDMAExists-8,(AddrMapFlags+2).w ; TestFor SCSIDMAExists
            beq.b   .L3
            bset    #sSCSIDMAExists,D0
.L3:
            btst    #OSSExists-16,(AddrMapFlags+1).w ; TestFor OSSExists
            beq.b   .L4
            bset    #sOSSExists,D0
.L4:
            bsr.l   SCSISETFLAGSPATCH
            nop
            nop
            movem.l (SP)+,D1/A0
            rts
            dc.w    $6040,$0808,$0808,$4104,$1812
CacheProc:
CTrapTbl:
            dc.w    GetCSize-CTrapTbl               ; 0
            dc.w    SetCSize-CTrapTbl               ; 1
            dc.w    GetApZnSiz-CTrapTbl             ; 2
            dc.w    SetApZnSiz-CTrapTbl             ; 3
            dc.w    GetMaxCXfr-CTrapTbl             ; 4
            dc.w    SetMaxCXfr-CTrapTbl             ; 5
            dc.w    GetCStatus-CTrapTbl             ; 6
            dc.w    SetCStatus-CTrapTbl             ; 7
CacheTrap:
            cmpi.w  #(CacheTrap-CTrapTbl)/2,D0
            bcs.b   .L1
            moveq   #paramErr,D0
            rts
.L1:
            lea     CTrapTbl,A1
            add.w   D0,D0
            adda.w  (0,A1,D0.w),A1
            jmp     (A1)
CTExit:
            jmp     CmdDone
GetCSize:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetCSize:
            jsr     FSQueueSync
            move.l  ($1C,A0),D0                     ; ioMisc
            moveq   #15,D1
            lsr.l   D1,D0
            move.b  D0,($20A).w                     ; CacheConfig
            moveq   #0,D0
            bra.b   CTExit
GetApZnSiz:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($20,A1),($1C,A0)               ; CacheMinZn -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetApZnSiz:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($1C,A0),($20,A1)               ; ioMisc -> CacheMinZn
            moveq   #0,D0
            bra.b   CTExit
GetMaxCXfr:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($12,A1),($1C,A0)               ; CacheByteLim -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetMaxCXfr:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  ($1C,A0),D1                     ; ioMisc
            cmp.l   D1,D0
            bcc.b   .L1
            moveq   #paramErr,D0
            bra.w   CTExit
.L1:
            move.l  D1,($12,A1)                     ; CacheByteLim
            moveq   #0,D0
            bra.w   CTExit
GetCStatus:
            jsr     FSQueueSync
            movea.l ($394).w,A1                     ; CacheVars
            moveq   #0,D0
            tst.b   ($11,A1)                        ; CurEnable
            beq.b   .L1
            btst    #5,($20B).w                     ; CacheEnable
            beq.b   .L1
            moveq   #1,D0
.L1:
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.w   CTExit
SetCStatus:
            jsr     FSQueueSync
            tst.l   ($1C,A0)                        ; ioMisc
            beq.b   .L1
            bset    #5,($20B).w                     ; CacheEnable
            bra.b   .L2
.L1:
            bclr    #5,($20B).w                     ; CacheEnable
.L2:
            moveq   #0,D0
            bra.w   CTExit
            ds.b    10
QStuff:
Enqueue:
            move    SR,-(SP)
            addq.w  #2,A1
            ori     #$700,SR
            clr.l   (A0)
            tst.l   (A1)+
            bne.b   .L1
            move.l  A0,(A1)
            move.l  A0,-(A1)
            bra.b   .L2
.L1:
            move.l  A2,-(SP)
            movea.l (A1),A2
            move.l  A0,(A2)
            move.l  A0,(A1)
            movea.l (SP)+,A2
            subq.w  #4,A1
.L2:
            subq.w  #2,A1
            move    (SP)+,SR
            rts
DequeueTrap:
            move    SR,-(SP)
            movem.l A2-A3,-(SP)
            ori     #$700,SR
            movea.l (2,A1),A2
            movea.l A2,A3
.L1:
            cmpa.l  A3,A0
            beq.b   .L2
            movea.l A3,A2
            movea.l (A2),A3
            cmpa.l  (6,A1),A2
            bne.b   .L1
            moveq   #-1,D0
            bra.b   .L4
.L2:
            cmpa.l  A2,A3
            bne.b   .L5
            move.l  (A2),(2,A1)
            bne.b   .L3
            clr.l   (6,A1)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,A2-A3
            move    (SP)+,SR
            rts
.L5:
            move.l  (A3),(A2)
            cmpa.l  (6,A1),A3
            bne.b   .L3
            move.l  A2,(6,A1)
            bra.b   .L3
InitQueue:
            clr.w   (A1)+
            clr.l   (A1)+
            clr.l   (A1)
            subq.w  #6,A1
            rts
            ds.b    8
EMT1010:
Dispatcher:
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            movea.l ($A,SP),A2
            move.w  (A2)+,D2
            cmpi.w  #$A800,D2
            bcs.b   .L2
            subi.w  #$AC00,D2
            bcc.b   .L1
            move.l  ($1E00.w,D2.w*4),(8,SP)
            move.l  A2,($C,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rts
            ds.b    8
.L1:
            move.l  ($E00.w,D2.w*4),(8,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rtd     #4
.L2:
            move.l  D1,-(SP)
            move.l  A1,-(SP)
            move.w  D2,D1
            move.l  A2,($14,SP)
            andi.w  #$100,D2
            bne.b   .L3
            move.b  D1,D2
            move.l  A0,-(SP)
            jsr     ([DispatchTab.w,D2.w*4])
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
            ds.b    6
.L3:
            move.b  D1,D2
            jsr     ([D2.w*4])
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
sub_40809A34:
            lsl.w   #6,D1
            bpl.b   .L2
            bcc.b   .L3
.L1:
            andi.w  #$3FF,D0
            lea     ($E00.w,D0.w*4),A1
            rts
.L2:
            andi.w  #$1FF,D0
            moveq   #-$57,D1
            add.w   D0,D1
            bgt.b   .L1
            beq.b   .L3
            addq.w  #8,D1
            ble.b   .L3
            subq.w  #5,D1
            bne.b   .L1
.L3:
            andi.w  #$FF,D0
            lea     (DispatchTab.w,D0.w*4),A1
            rts
GetTrapAddress:
            bsr.b   sub_40809A34
            movea.l (A1),A0
            moveq   #0,D0
            rts
SetTrapAddress:
            bsr.b   sub_40809A34
            bra.l   DISPATCHPATCH
CacheFlush:
            move.l  ($6F4).w,-(SP)
            rts
vCacheFlush:
            movec   CACR,D1
            addq.w  #8,D1
            movec   D1,CACR
            rts
            lea     EMT1010,A0
            beq.b   .L1
            lea     EMT1010,A0
.L1:
            move.l  A0,LineAVector
InitDispatcher:
            lea     BadTrap,A4
            movea.l ROMBase,A3
            movea.l A3,A2
            lea     ($E00).w,A1
            movea.l A3,A0
            adda.l  ($22,A0),A0
            moveq   #$7F,D2
            move.w  #$3FF,D0
.L1:
            move.b  (A0)+,D1
            bmi.b   .L5
            lsl.w   #8,D1
            move.b  (A0)+,D1
.L2:
            add.w   D1,D1
            beq.b   .L7
            adda.w  D1,A2
.L3:
            move.l  A2,(A1)+
.L4:
            dbra    D0,.L1
            lea     DispatchTab,A1
            bra.b   .L1
.L5:
            and.w   D2,D1
            beq.b   .L6
            cmp.w   D2,D1
            bne.b   .L2
            movea.l (A0)+,A2
            adda.l  A3,A2
            bra.b   .L3
.L6:
            move.l  A4,(A1)+
            bra.b   .L4
.L7:
            bra.l   CACHEVECTORPATCH
            ds.b    4
BadTrap:
            movem.l D0-D7/A0-A7,seVars
            moveq   #$C,D0
            jmp     (SysErr1.w,PC)
            ds.b    14
IntHnd:
            rte
.L1:
            dc.w    $4E73
            ds.b    12
sub_40809B10:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L4,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B20:
            movem.l D0-D3/A0-A3,-(SP)
            lea     SCCIOPBYPASSINT,A3
            bra.b   sub_40809B60.L1
.L1:
            dc.w    $4E73
            ds.b    4
sub_40809B30:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L9,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B40:
            movem.l D0-D3/A0-A3,-(SP)
            lea     sub_40809B60.L7,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B50:
            movem.l D0-D3/A0-A3,-(SP)
            lea     ExtABInt.L7,A3
            bra.b   sub_40809B60.L1
            ds.b    6
sub_40809B60:
            movem.l D0-D3/A0-A3,-(SP)
            lea     .L6,A3
.L1:
            tst.b   MMU32bit
            bne.b   .L4
.L2:
            jsr     (A3)
            tst.l   ($D94).w
            beq.b   .L3
            moveq   #7,D0
            and.b   ($20,SP),D0
            bne.b   .L3
            movea.l ($6E4).w,A0
            jsr     (A0)
.L3:
            movem.l (SP)+,D0-D3/A0-A3
            rte
.L4:
            btst    #0,($B73).w
            beq.b   .L2
            moveq   #0,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            jsr     (A3)
            tst.l   ($D94).w
            beq.b   .L5
            moveq   #7,D0
            and.b   ($20,SP),D0
            bne.b   .L5
            movea.l ($6E4).w,A0
            jsr     (A0)
.L5:
            moveq   #1,D0
            movea.l JSwapMMU,A0
            jsr     (A0)
            movem.l (SP)+,D0-D3/A0-A3
            rte
            dc.w    0
.L6:
            movea.l VIA,A1
            moveq   #$7F,D0
            and.b   (vIFR,A1),D0
            and.b   (vIER,A1),D0
            movea.w .L8(PC,D0.w*2),A0
            movea.l (A0),A0
            jmp     (A0)
            ds.b    10
.L7:
            dc.w    $2278,$0CEC,$707F,$C029,$1A03,$41F8,$0BDE,$C029
            dc.w    $1C13,$D0FB,$0206,$2050,$4ED0
.L8:
            dc.w    $01AE,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A6,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01AA,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A6,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $01A2,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            dc.w    $019E,$0192,$0196,$0192,$019A,$0192,$0196,$0192
            ds.b    6
SCCIOPBYPASSINT:
            movea.l SCCRd,A0
            move.b  (A0),D0
            movea.l SCCWr,A1
            move.b  #2,(A1)
            lea     Lvl2DT,A2
            moveq   #$E,D0
            and.b   (A0),D0
            cmpi.b  #8,D0
            blt.b   .L1
            addq.w  #2,A0
            addq.w  #2,A1
.L1:
            movea.l (0,A2,D0.w*2),A2
            jmp     (A2)
            ds.b    10
ExtBInt:
            move.b  (A0),D0
            lea     SCCBSts,A3
            lea     ExtStsDT,A2
            bra.b   ExtABInt
            ds.b    4
ExtAInt:
            move.b  (A0),D0
            lea     SCCASts,A3
            lea     ($2C6).w,A2
ExtABInt:
            move.b  #15,(A1)
            move.b  (A3),D1
            move.b  D0,(A3)
            eor.b   D0,D1
            and.b   (A0),D1
            move.b  #$10,(A1)
            movea.l (A2),A2
            jmp     (A2)
            dc.w    0
.L4:
            moveq   #0,D0
            jmp     (IOPINTERRUPT.w,PC)
            ds.b    10
.L5:
            move.b  #1,($1A00,A1)
.L6:
            moveq   #1,D0
            jmp     (IOPINTERRUPT.w,PC)
            ds.b    4
.L7:
            movea.l VIA2,A1
            move.w  ($202,A1),D0
            btst    #6,D0
            bne.b   .L15
.L8:
            btst    #$B,D0
            bne.w   sub_40809B60.L6
            btst    #$A,D0
            bne.b   .L13
            rts
.L15:
            moveq   #7,D1
            and.b   (6,A1),D1
            bne.b   .L6
            bra.b   .L8
            ds.b    8
.L9:
            movea.l VIA2,A1
            move.w  ($202,A1),D0
            btst    #9,D0
            bne.b   .L16
.L10:
            btst    #8,D0
            bne.b   .L12
.L11:
            movea.l ($D74).w,A0
            jmp     (A0)
.L16:
            moveq   #7,D1
            and.b   (9,A1),D1
            beq.b   .L10
            movea.l ($D7C).w,A0
            jmp     (A0)
.L12:
            moveq   #7,D1
            and.b   (8,A1),D1
            beq.b   .L11
            movea.l ($D80).w,A0
            jmp     (A0)
            ds.b    10
.L13:
            lea     (-$17F9,A1),A1
            movea.l ($196).w,A0
            jmp     (A0)
            movea.l ($19A).w,A0
            jmp     (A0)
sub_40809E00:
            bset    #6,NMIFlag
            bne.b   .L1
            move    (SP),SR
            movem.l D0/A0,-(SP)
            _PowerOff
            movem.l (SP)+,D0/A0
.L1:
            rte
PowerOff:
            bsr.w   WaitAWhile
            bsr.l   PMGRPOWEROFFPATCH
            BigJmp  POWEROFFPATCH,A0
PowerOffCont:
            movea.l VIA2,A0
            bra.b   .L1
            ds.b    4
.L1:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   WaitAWhile
            bset    #7,($204,A0)
WaitAWhile:
            move.l  #$FE0C0000,D0
.L1:
            move.w  TimeDBRA,D0
.L2:
            dbra    D0,.L2
            addq.l  #1,D0
            bne.b   .L1
            rts
InitIntHandler:
            lea     Lvl1DT,A0
            lea     GOTSLOTHANDLER.L6,A1
            moveq   #$F,D0
.L1:
            move.l  A1,(A0)+
            dbra    D0,.L1
            lea     clock,A0
            move.l  A0,Lvl1DT
            lea     VBLInt,A0
            move.l  A0,($196).w
            btst    #2,HWCfgFlags
            beq.b   .L2
            lea     ($1B6).w,A2
            lea     ExtBInt,A0
            move.l  A0,(A2)
            lea     ExtAInt,A0
            move.l  A0,($10,A2)
            lea     ExtStsDT,A2
            lea     GOTSLOTHANDLER.L6,A0
            move.l  A0,(A2)+
            move.l  A0,(A2)+
            move.l  A0,(A2)+
            move.l  A0,(A2)+
.L2:
            lea     ($D70).w,A2
            moveq   #7,D0
.L3:
            move.l  A0,(A2)+
            dbra    D0,.L3
            lea     (SlotInt.w,PC),A0
            bra.l   INITSLOTINTSPATCH
            dc.w    0
INTHANDLERNOVIA2:
            lea     (RBVSLOTINT.w,PC),A0
            btst    #5,($DD2).w                     ; TestFor RBVExists
            bne.b   GOTSLOTHANDLER
            lea     (OSSSLOTINT.w,PC),A0
            btst    #2,($DD1).w                     ; TestFor OSSExists
            nop
GOTSLOTHANDLER:
            move.l  A0,($D74).w
            lea     Lev1AutoVector,A2
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            lea     sub_40809B50,A0
            move.l  A0,(A2)+
            lea     sub_40809B30,A0
            move.l  A0,(A2)+
.L1:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            bne.b   .L2
            lea     sub_40809B60,A0
            move.l  A0,(A2)+
            lea     sub_40809B40,A0
            move.l  A0,(A2)+
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L2
            lea     ExtABInt.L5,A0
            move.l  A0,($D70).w
.L2:
            lea     sub_40809B20.L1,A0
            move.l  A0,(A2)+
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .L3
            lea     sub_40809B10,A0
            move.l  A0,(A2)+
.L3:
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            bne.b   .L4
            lea     sub_40809B20,A0
            move.l  A0,(A2)+
.L4:
            lea     IntHnd.L1,A0
            move.l  A0,(A2)+
            lea     IntHnd,A0
            cmpi.b  #0,BoxFlag
            bne.b   .L5
            lea     sub_40809E00,A0
.L5:
            move.l  A0,(A2)+
.L6:
            rts
DisableIntSources:
            movea.l VIA,A0
            move.b  #$7F,(vIER,A0)
            movea.l VIA2,A0
            btst    #3,($DD2).w                     ; TestFor VIA2Exists
            bne.b   .L1
            btst    #5,($DD2).w                     ; TestFor RBVExists
            beq.b   .L2
.L1:
            move.b  #$7F,($1C13,A0)
.L2:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L4
            movea.l VIA2,A0
            lea     0.w(A0),A0
            moveq   #$E,D0
.L3:
            clr.b   (A0)+
            dbra    D0,.L3
            movea.l VIA2,A0
            move.b  #1,($B,A0)
            move.b  #4,(7,A0)
.L4:
            rts
Enable60HzInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #1,($A,A0)
            rts
.L1:
            movea.l VIA,A0
            move.b  #$82,(vIER,A0)
            rts
            ds.b    12
EnableSlotInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L2
            movea.l VIA2,A0
            lea     0.w(A0),A0
            moveq   #5,D0
.L1:
            move.b  #2,(A0)+
            dbra    D0,.L1
            rts
.L2:
            movea.l VIA2,A0
            move.b  #$82,($1C13,A0)
            rts
EnableSWIMIOPInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #1,(6,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$81,($1C13,A0)
            rts
EnableASCInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #2,(8,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$90,($1C13,A0)
            rts
DisableASCInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            clr.b   (8,A0)
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$10,($1C13,A0)
            rts
ClearASCInt:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            rts
.L1:
            movea.l VIA2,A0
            move.b  #$90,($1A03,A0)
            rts
EnableSCSIInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #2,(9,A0)
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #$88,($1C13,A0)
            rts
.L2:
            move.b  #$88,($1C13,A0)
            rts
            rts
DisableSCSIInts:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            movea.l VIA2,A0
            clr.b   (9,A0)
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #8,($1C13,A0)
            rts
.L2:
            move.b  #8,($1C13,A0)
            rts
            rts
ClearSCSIInt:
            btst    #2,($DD1).w                     ; TestFor OSSExists
            beq.b   .L1
            rts
.L1:
            movea.l VIA2,A0
            btst    #7,($DD2).w                     ; TestFor SCSIDMAExists
            beq.b   .L2
            move.b  #$88,($1A03,A0)
            rts
.L2:
            move.b  #$88,($1A03,A0)
            rts
            dc.w    $4E75
            ds.b    4
DebugUtil:
            lea     .table,A0
            cmp.l   (A0)+,D0
            bhi.b   .tooBig
            add.w   D0,D0
            adda.w  (A0,D0.w),A0
            jmp     (A0)
.tooBig:
            moveq   #paramErr,D0
            rts
.table:
            dc.l    (.last-.first)/2-1              ; Highest selector supported
.first:
            dc.w    .getMax-.first                  ; 0
            dc.w    DebugEnter-.first               ; 1
            dc.w    DebugExit-.first                ; 2
            dc.w    DebugPoll-.first                ; 3
.last:
.getMax:
            move.l  .table,D0
            rts
DebugEnter:
            bra.w   DoDebugEnter
            ds.b    8
DebugExit:
            bra.w   DoDebugExit
DebugPoll:
            btst    #2,HWCfgFlags
            beq.b   PollDone
            bsr.l   DEBUGPWRMGRADBPATCH1
            nop
            movea.l VIA,A1
            btst    #2,(vIFR,A1)
            beq.b   PollDone
            bsr.b   RunKBD
            nop
PollDone:
            moveq   #0,D0
            rts
RunKBD:
            movem.l D3/A3,-(SP)
            btst    #2,HWCfgFlags
            beq.b   RunDone
            bsr.l   DEBUGUTILRUNKBDPATCH
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            move.l  #$8080001,D0
            jsr     (IOPINTERRUPT.w,PC)
            bra.b   RunDone
.L1:
            movea.l VIA,A1
            movea.l ($19A).w,A0
            jsr     (A0)
            nop
RunDone:
            movem.l (SP)+,D3/A3
            rts
EnableParityInts:
            btst    #4,($DD1).w                     ; TestFor RPUExists
            beq.b   .L1
            movea.l VIA2,A0
            move.b  #7,($E,A0)
.L1:
            rts
DoDebugEnter:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            bsr.b   RunKBD
.L1:
            move.l  A0,-(SP)
            BigJsr  DEBUGENTERCONT,A0
            movea.l (SP)+,A0
            rts
DoDebugExit:
            move.l  A0,-(SP)
            BigJsr  DEBUGEXITCONT,A0
            movea.l (SP)+,A0
            rts
            dc.b    'GaryGaryGaryGary'
DTCore:
DTInstall:
            cmpi.w  #7,(4,A0)
            bne.b   .L1
            lea     DTQueue,A1
            jsr     QStuff
            moveq   #0,D0
            rts
.L1:
            moveq   #-2,D0
            rts
DisptchTsk:
            move.l  ($6E4).w,-(SP)
            rts
vDisptch:
            btst    #6,VBLQueue
            bne.b   .L1
            bset    #6,DTQueue
            beq.b   .L3
.L1:
            rts
.L2:
            movea.l D0,A0
            lea     DTQueue,A1
            jsr     DequeueTrap
            movea.l (8,A0),A2
            movea.l ($C,A0),A1
            andi    #$F8FF,SR
            jsr     (A2)
.L3:
            ori     #$700,SR
            move.l  ($D94).w,D0
            bne.b   .L2
            bclr    #6,DTQueue
            rts
            ds.b    6
VBLCore:
VInstall:
            lea     VBLQueue,A1
.L1:
            cmpi.w  #1,(4,A0)
            bne.b   .L4
            move.w  ($A,A0),D1
            beq.b   .L3
            tst.w   ($C,A0)
            beq.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            move.l  ($A,A1),D0
            swap    D0
            moveq   #0,D2
            move.w  D0,D2
            divu.w  D1,D2
            swap    D2
            move.w  D2,D0
            swap    D0
            divu.w  D1,D0
            swap    D0
            sub.w   ($C,A0),D0
            neg.w   D0
            bpl.b   .L2
            add.w   D1,D0
.L2:
            add.w   D0,($A,A0)
            move    (SP)+,SR
.L3:
            jsr     QStuff
            moveq   #0,D0
            rts
.L4:
            moveq   #-2,D0
            rts
VRemove:
            cmpi.w  #1,(4,A0)
            bne.b   VInstall.L4
            move.l  A1,-(SP)
            lea     VBLQueue,A1
            jsr     DequeueTrap
            movea.l (SP)+,A1
.L1:
            rts
VBLInt:
            addq.l  #1,Ticks
            move.b  #2,($1A00,A1)
            bset    #6,VBLQueue
            bne.b   VRemove.L1
            move    #$2000,SR
            move.l  StkLowPt,D0
            beq.b   .L2
            cmpa.l  D0,SP
            bcc.b   .L1
            move.l  SP,StkLowPt
.L1:
            movea.l ApplZone,A1
            cmpa.l  (A1),SP
            bcc.b   .L2
            moveq   #$1C,D0
            _SysError
.L2:
            lea     VBLQueue,A1
.L3:
            lea     (2,A1),A0
.L4:
            move.l  (A0),D0
            beq.b   .L5
            movea.l D0,A0
            subq.w  #1,($A,A0)
            bne.b   .L4
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            movea.l (6,A0),A1
            jsr     (A1)
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            tst.w   ($A,A0)
            bne.b   .L4
            jsr     DequeueTrap
            bra.b   .L4
.L5:
            bclr    #6,(A1)
            rts
GetSlotVBLQHdr:
            ext.w   D0
            cmpi.w  #$E,D0
            bgt.b   .L1
            movea.l ([$D04.w],D0.w*4),A1
            rts
.L1:
            move.w  #$FEAF,D0
            addq.w  #4,SP
            rts
SlotVInstall:
            bsr.b   GetSlotVBLQHdr
            bra.w   VInstall.L1
SlotVRemove:
            bsr.b   GetSlotVBLQHdr
            cmpi.w  #1,(4,A0)
            bne.w   VInstall.L4
            jmp     DequeueTrap
AttachVBL:
            bsr.b   GetSlotVBLQHdr
            move.l  A1,($D10).w
            moveq   #0,D0
            rts
DoVBLTask:
            bsr.b   GetSlotVBLQHdr
            addq.l  #1,($A,A1)
            cmpa.l  ($D10).w,A1
            bne.b   .L1
            move.l  JCrsrTask,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  A1,-(SP)
            jsr     (A0)
            movea.l (SP)+,A1
.L1:
            bra.w   VBLInt.L3
InitVBLQs:
            lea     DoVBLTask,A0
            move.l  A0,($D28).w
            clr.l   ($D10).w
            rts
            dc.w    0
KBDMngr:
CountADBs:
            moveq   #$10,D1
            move.w  D1,D0
            movea.l ADBBase,A1
            addq.w  #2,A1
            bra.b   .L2
.L1:
            lea     ($C,A1),A1
.L2:
            tst.b   (A1)
            dbeq    D1,.L1
            sub.w   D1,D0
            rts
GetIndADB:
            tst.w   D0
            ble.b   ADBNotFound
            cmpi.w  #numFDBAdr,D0
            bgt.b   ADBNotFound
            movea.l ADBBase,A1
            mulu.w  #fRecSize,D0
            lea     (-$C,A1,D0.l),A1
            moveq   #0,D0
            move.b  (2,A1),D0
.L1:
            move.b  (A1),(A0)+
            move.b  (1,A1),(A0)+
            move.l  (4,A1),(A0)+
            move.l  (8,A1),(A0)
            rts
GetADBInfo:
            bsr.b   FindFDBInfo
            beq.b   GetIndADB.L1
            rts
SetADBInfo:
            bsr.b   FindFDBInfo
            bne.b   .L1
            move.l  (A0)+,(4,A1)
            move.l  (A0),(8,A1)
.L1:
            rts
FindFDBInfo:
            moveq   #$10,D1
            movea.l ADBBase,A1
            bra.b   .L2
.L1:
            lea     ($C,A1),A1
.L2:
            cmp.b   (2,A1),D0
            beq.b   DoneFind
            tst.b   (2,A1)
            dbeq    D1,.L1
ADBNotFound:
            moveq   #-1,D0
            rts
DoneFind:
            moveq   #0,D0
            rts
ADBOp:
            movem.l D3/A2-A3,-(SP)
            movea.l ADBBase,A3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l ($148,A3),A1
            btst    #2,($15D,A3)
            bne.b   .L1
            cmpa.l  ($144,A3),A1
            beq.b   .L5
.L1:
            move.b  D0,(A1)+
            addq.w  #1,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            cmpa.l  ($140,A3),A1
            bcs.b   .L2
            movea.l ($13C,A3),A1
.L2:
            move.l  A1,($148,A3)
            bclr    #2,($15D,A3)
            beq.b   .L3
            bsr.b   RunADBRequest
.L3:
            moveq   #0,D0
.L4:
            move    (SP)+,SR
            movem.l (SP)+,D3/A2-A3
            rts
.L5:
            moveq   #-1,D0
            bra.b   .L4
RunADBRequest:
            btst    #2,(fDBFlag,A3)
            beq.b   .L1
            moveq   #0,D2
            moveq   #-1,D3
            btst    #5,(fDBFlag,A3)
            beq.b   .L2
            rts
.L1:
            movea.l (fQHeadPtr,A3),A0
            moveq   #0,D3
            move.b  (A0),D3
            movea.l (2,A0),A2
            moveq   #$C,D2
            and.b   D3,D2
            subq.b  #8,D2
            seq     D2
            and.b   (A2)+,D2
.L2:
            movea.l ($130,A3),A0
            jmp     (A0)
ExplicitRequestDone:
            move.l  SP,-(SP)
            move    SR,D1
            ori     #HiIntMask,SR
            movea.l (fQHeadPtr,A3),A0
            lea     ($E,A0),A0
            movea.l A0,A1
            cmpa.l  (fQEndPtr,A3),A0
            bcs.b   .L1
            movea.l (fQBegPtr,A3),A0
.L1:
            move.l  A0,(fQHeadPtr,A3)
            cmpa.l  (fQEntPtr,A3),A0
            bne.b   .L2
            bset    #2,(fDBFlag,A3)
.L2:
            move.l  -(A1),-(SP)
            move.l  -(A1),-(SP)
            movea.l -(A1),A0
            move    D1,SR
            bra.b   RequestDone
ImplicitRequestDone:
            tst.b   D2
            beq.b   RunADBRequest
            move.b  D3,D0
            lsr.b   #4,D0
            bsr.w   FindFDBInfo
            bne.b   RunADBRequest
            suba.w  #12,SP
            movea.l SP,A0
            pea     (12,SP)
            move.l  (fDBOpData,A1),-(SP)
            move.l  (fDBCRA,A1),-(SP)
RequestDone:
            move.l  A0,-(SP)
            beq.b   .copyDone
            move.b  D2,(A0)+
            beq.b   .copyDone
            subq.w  #1,D2
.copyLoop:
            move.b  (A2)+,(A0)+
            dbra    D2,.copyLoop
.copyDone:
            move.l  D3,-(SP)
            bsr.w   RunADBRequest
            movem.l (SP)+,D0/A0-A2
            bra.l   RequestDonePatch
            nop
            nop
IOPStartReq:
            moveq   #5,D0
            add.b   D2,D0
            bclr    #0,(fDBAuFlag,A3)
            bne.b   .useRcv
            lea     (XmtRequest,A3),A0
            lea     (XmtMsg,A3),A1
            move.b  D0,(irMessageLen,A0)
            bra.b   .fillInReq
.useRcv:
            lea     ($188,A3),A0
            lea     ($1AC,A3),A1
            move.b  D0,($A,A0)
.fillInReq:
            move.w  #$6002,(A1)
            tst.l   D3
            bmi.b   .implicit
            clr.w   (A1)
            bset    #1,($15E,A3)
            bne.b   .SendToIOP
            move.b  #$80,(A1)+
            move.b  D2,(A1)+
            move.b  D3,(A1)+
            bra.b   .copyStart
.copyLoop:
            move.b  (A2)+,(A1)+
.copyStart:
            dbra    D2,.copyLoop
.SendToIOP:
            movea.l ($61C).w,A2
            jmp     (A2)
.implicit:
            move.w  ($14E,A3),(3,A1)
            bra.b   .SendToIOP
.L11:
            bra.l   InitADBPatchPwrMgr
EgretCheck:
            moveq   #$E,D0
            and.l   UnivROMFlags,D0
            subq.l  #6,D0
            bne.b   .L1
            BigLea  EgretPatches,A0
            move.l  A0,($130,A3)
            move.w  #$FF01,($184,A3)
            bra.w   ReInit
.L1:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            bne.w   ReInit
            bra.w   InitADB.L2
            nop
.L2:
            movea.l ADBBase,A3
            move.b  ($1AC,A3),D0
            moveq   #4,D3
            and.b   D0,D3
            neg.l   D3
            move.b  ($1AE,A3),D3
            move.b  D3,($15C,A3)
            move.b  D3,($16E,A3)
            move.b  D2,D2
            lsr.b   #4,D2
            move.b  D2,($16C,A3)
            moveq   #0,D2
            move.b  ($1AD,A3),D2
            lea     ($1AF,A3),A2
            bset    #0,($15E,A3)
            btst    #7,D0
            beq.w   ImplicitRequestDone
            bclr    #1,($15E,A3)
            bra.w   ExplicitRequestDone
sub_4080A5AA:
            movea.l VIA,A1
            bset    #4,($15E,A3)
            beq.b   sub_4080A5B8
            rts
sub_4080A5B8:
            tst.l   D3
            bpl.b   sub_4080A5F6.L1
            move.b  ($16C,A3),D3
            lsl.b   #4,D3
            ori.b   #$C,D3
            bsr.w   sub_4080A656
            beq.b   sub_4080A5F6.L2
            move.b  ($15C,A3),($16E,A3)
            bsr.b   sub_4080A5F6
            btst    #2,($15D,A3)
            bne.b   .L2
            pea     RunADBRequest
            move.w  TimeVIADB,D0
            lsr.w   #4,D0
.L1:
            btst    #0,(A1)
            dbra    D0,.L1
.L2:
            bclr    #4,($15E,A3)
            rts
sub_4080A5F6:
            moveq   #$30,D1
            bsr.w   sub_4080A67C
            ori.b   #$90,($15E,A3)
            moveq   #$20,D1
            bra.b   .L4
.L1:
            moveq   #$C,D0
            and.b   D3,D0
            subq.b  #8,D0
            beq.w   sub_4080A68E.L1
            bsr.b   sub_4080A656
            bne.b   .L3
.L2:
            bset    #7,($15E,A3)
            move.b  ($16E,A3),($15C,A3)
.L3:
            moveq   #$10,D1
.L4:
            bsr.b   sub_4080A67C
            bne.b   .L5
            bset    #5,($15E,A3)
.L5:
            clr.b   ($163,A3)
            bsr.b   sub_4080A68E
            bne.b   .L6
            bset    #6,($15E,A3)
.L6:
            bsr.b   sub_4080A68E
            beq.b   .L7
            cmpi.b  #8,($163,A3)
            bcs.b   .L6
.L7:
            btst    #5,($15E,A3)
            seq     D0
            and.b   D0,($163,A3)
            bra.w   sub_4080A700.L1
sub_4080A656:
            andi.b  #$1F,($15E,A3)
            move    SR,D0
            ori     #$700,SR
            ori.b   #$1C,($1600,A1)
            move.b  D3,($1400,A1)
            move.b  D3,($15C,A3)
            andi.b  #$CF,(A1)
            move.l  (SP)+,($138,A3)
            move    D0,SR
            rts
sub_4080A67C:
            bclr    #4,($1600,A1)
            tst.b   ($1400,A1)
            eor.b   D1,(A1)
            move.l  (SP)+,($138,A3)
            rts
sub_4080A68E:
            lea     ($163,A3),A0
            moveq   #1,D0
            add.b   (A0),D0
            move.b  D0,(A0)
            move.b  ($1400,A1),(0,A0,D0.w)
            eori.b  #$30,(A1)
            move.l  (SP)+,($138,A3)
            rts
.L1:
            subq.b  #2,D2
            bcc.b   .L2
            moveq   #0,D2
.L2:
            subq.b  #6,D2
            bls.b   .L3
            moveq   #0,D2
.L3:
            addq.b  #8,D2
            move.b  D2,($163,A3)
            move.l  A2,($134,A3)
            bsr.b   sub_4080A656
            beq.w   sub_4080A5F6.L2
            bsr.b   sub_4080A6E2
            bne.b   .L4
            bset    #5,($15E,A3)
.L4:
            bsr.b   sub_4080A6E6
            bne.b   .L5
            bset    #6,($15E,A3)
.L5:
            tst.b   ($163,A3)
            beq.b   sub_4080A700.L1
            bsr.b   sub_4080A6E6
            bra.b   .L5
sub_4080A6E2:
            moveq   #$10,D1
            bra.b   sub_4080A6E6.L1
sub_4080A6E6:
            moveq   #$30,D1
.L1:
            movea.l ($134,A3),A0
            move.b  (A0)+,($1400,A1)
            move.l  A0,($134,A3)
            subq.b  #1,($163,A3)
            eor.b   D1,(A1)
            move.l  (SP)+,($138,A3)
            rts
sub_4080A700:
            movea.l ADBBase,A3
            movea.l ($138,A3),A0
            btst    #3,(A1)
            jmp     (A0)
.L1:
            move.b  ($15E,A3),D0
            move.b  ($15C,A3),D1
            moveq   #$40,D3
            and.b   D0,D3
            neg.l   D3
            move.b  D1,D3
            lsr.b   #4,D1
            tst.l   D3
            bpl.b   .L3
            move.w  ($14E,A3),D2
            bset    D1,D2
.L2:
            addq.b  #1,D1
            andi.b  #$F,D1
            btst    D1,D2
            beq.b   .L2
.L3:
            move.b  D1,($16C,A3)
            lea     ($163,A3),A0
            moveq   #0,D2
            move.b  (A0)+,D2
            movea.l A0,A2
            clr.b   ($15E,A3)
            btst    #7,D0
            bne.w   ImplicitRequestDone
            bra.w   ExplicitRequestDone
ADBReInit:
            movea.l JADBProc,A0
            moveq   #0,D0
            jsr     (A0)
            movem.l D0-D4/A0-A3,-(SP)
            movea.l ADBBase,A3
            bsr.w   ReInit
            bsr.b   InitADBDrvr
            movem.l (SP)+,D0-D4/A0-A3
            movea.l JADBProc,A0
            moveq   #1,D0
            jsr     (A0)
            rts
ADBProc:
            tst.l   D0
            bne.b   .L3
            _CountADBs
            move.w  D0,D2
            beq.b   .L3
            link.w  A6,#-$C
            moveq   #2,D1
.L1:
            lea     (-$C,A6),A0
            move.w  D2,D0
            _GetIndADB
            bmi.b   .L2
            cmp.b   (-$B,A6),D1
            bne.b   .L2
            movea.l (-6,A6),A1
            clr.l   (-6,A6)
            lea     (-$A,A6),A0
            _SetADBInfo
            movea.l A1,A0
            _DisposPtr
.L2:
            subq.w  #1,D2
            bgt.b   .L1
            unlk    A6
.L3:
            rts
InitADBDrvr:
            _CountADBs
            move.w  D0,D3
            beq.b   .L4
            moveq   #1,D4
            link.w  A6,#-$C
.L1:
            lea     (-$C,A6),A0
            move.w  D4,D0
            _GetIndADB
            move.b  D0,(-2,A6)
            bmi.b   .L3
            subq.l  #4,SP
            move.l  #'ADBS',-(SP)
            clr.w   -(SP)
            move.b  (-$B,A6),(1,SP)
            _GetResource
            move.l  (SP),D1
            bne.b   .L2
            addq.w  #4,SP
            bra.b   .L3
.L2:
            _DetachResource
            movea.l D1,A0
            move.l  (A0),D0
            _StripAddress
            movea.l D0,A0
            move.b  (-2,A6),D0
            move.b  (-$C,A6),D1
            jsr     (A0)
.L3:
            addq.w  #1,D4
            cmp.w   D4,D3
            bge.b   .L1
            unlk    A6
.L4:
            rts
InitADB:
            move.l  #fDBDSize,D0
            _NewPtrSysClear                         ; Allocate space on heap and clear
            movea.l A0,A3                           ; ADBBase is always in A3 by convention
            move.l  A3,ADBBase                      ; Save pointer to it
            lea     ADBProc,A0                      ; Get the ADBProc
            move.l  A0,JADBProc                     ; Install it into JADBProcc vector
            clr.b   KbdType                         ; Assume we have no keyboard to start
            bsr.w   RSetKMap                        ; Reset the keyboard map, etc.
            lea     FDBTask,A0                      ; Setup the FDB VBL task
            move.l  A0,JKybdTask                    ; Lomem vector
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            lea     IOPStartReq,A0
            move.l  A0,(StartReqProc,A3)
            move.b  #1,($176,A3)
            clr.b   ($177,A3)
            move.b  #3,($178,A3)
            lea     ($1A0,A3),A0
            move.l  A0,($17C,A3)
            move.b  #1,($18E,A3)
            move.b  #2,($18F,A3)
            move.b  #3,($190,A3)
            move.b  #$C,($191,A3)
            lea     ($1AC,A3),A0
            move.l  A0,($194,A3)
            move.l  A0,($198,A3)
            lea     EgretCheck.L2,A0
            move.l  A0,(RcvRequest+irHandler,A3)
            lea     (RcvRequest,A3),A0
            _IOPMsgRequest
            move.b  #1,(RcvRequest+irRequestKind,A3)
.L1:
            bra.w   IOPStartReq.L11
            nop
            nop
.L2:
            lea     sub_4080A700,A0
            move.l  A0,($19A).w
            lea     sub_4080A5AA,A0
            move.l  A0,(StartReqProc,A3)
            movea.l VIA,A1
            ori     #HiIntMask,SR
            move.b  #$84,(vIER,A1)
ReInit:
            ori     #HiIntMask,SR
            move.w  #((endCQ/4)-1),D0
            movea.l A3,A0
.ClrLoop:
            clr.l   (A0)+
            dbra    D0,.ClrLoop
            move.b  #(1<<fDBInit)|(1<<fDBQEmpty),(fDBFlag,A3)
            clr.b   (fDBAuFlag,A3)
            lea     (startCQ,A3),A0
            move.l  A0,(fQBegPtr,A3)
            move.l  A0,(fQHeadPtr,A3)
            move.l  A0,(fQEntPtr,A3)
            lea     (endCQ,A3),A0
            move.l  A0,(fQEndPtr,A3)
            bsr.b   InitDevT
            andi    #$F8FF,SR                       ; Clear interrupt mask
.wait:
            btst    #fDBInit,(fDBFlag,A3)
            bne.b   .wait
            rts
InitDevT:
            bsr.w   BusReset
            clr.b   (devTOffset,A3)
            clr.w   (hasDev,A3)
            moveq   #0,D0
.PollNext:
            move.b  D0,(InitAddr,A3)
            bsr.w   TalkR3
            move.b  (InitAddr,A3),D0
            tst.b   (A0)+
            beq.b   .NoDevice
            moveq   #0,D1
            move.b  (devTOffset,A3),D1
            move.b  (1,A0),(fDBDevTy,A3,D1.w)       ; Copy device handler ID into table
            move.b  D0,(fDBOAddr,A3,D1.w)
            move.b  D0,(fDBAddr,A3,D1.w)
            cmpi.b  #2,D0
            bne.b   .notKbd
            lea     KbdDrvr,A0
            move.l  A0,(fDBCRA,A3,D1.w)
.notKbd:
            cmpi.b  #3,D0
            bne.b   .notMouse
            lea     MouseDrvr,A0
            move.l  A0,(4,A3,D1.w)
.notMouse:
            addi.b  #fRecSize,D1
            move.b  D1,(devTOffset,A3)
            move.w  (hasDev,A3),D2
            bset    D0,D2
            move.w  D2,(hasDev,A3)
.NoDevice:
            addq.b  #1,D0
            cmpi.b  #numFDBAdr,D0
            bne.b   .PollNext
            move.b  #moveTime+1,(fDBMvCnt,A3)
            move.w  (hasDev,A3),(devMap,A3)
            bne.b   .movLoop
.ChgExit:
            bclr    #fDBInit,(fDBFlag,A3)
            jsr     DefaultDev
            jsr     sub_4080AD10
            jsr     RunADBRequest
            rts
.movLoop:
            st      (InitAddr,A3)
            subq.b  #1,(fDBMvCnt,A3)
            beq.b   .ChgExit
.ChgNext:
            addq.b  #1,(InitAddr,A3)
            bsr.w   GNextAddr
            bmi.b   .movLoop
            bsr.w   GEmptyAddr
            bmi.b   .ChgExit
            move.b  D0,(newAddr,A3)
            move.b  D0,D1
            move.b  (InitAddr,A3),D0
            bsr.w   ListenR3
            move.b  (InitAddr,A3),D0
            bsr.b   TalkR3
            tst.b   (A0)
            beq.b   .L8
            bsr.b   CopyEntry
            move.b  ($165,A3),(0,A3,D1.w)
            bra.b   .ChgNext
.L8:
            move.b  ($16F,A3),D1
            move.b  ($16D,A3),D0
            bsr.b   ListenR3
            move.b  ($16D,A3),D0
            bsr.b   TalkR3
            tst.b   (A0)
            beq.b   .L9
            bsr.b   CopyEntry
            move.b  ($165,A3),(-$C,A3,D2.w)
.L9:
            bra.b   .ChgNext
CopyEntry:
            moveq   #0,D0
            moveq   #0,D1
            move.b  ($16D,A3),D0
            move.w  ($14E,A3),D1
            bset    D0,D1
            move.w  D1,($14E,A3)
            moveq   #0,D1
            move.b  ($16F,A3),D0
.L1:
            cmp.b   (2,A3,D1.w),D0
            beq.b   .L2
            addi.w  #$C,D1
            bra.b   .L1
.L2:
            moveq   #0,D2
            move.b  ($161,A3),D2
            move.l  (0,A3,D1.w),(0,A3,D2.w)
            move.l  (4,A3,D1.w),(4,A3,D2.w)
            move.b  ($16D,A3),(2,A3,D2.w)
            addi.w  #$C,D2
            move.b  D2,($161,A3)
            rts
BusReset:
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            bra.b   MakeAsyncRequest
TalkR3:
            moveq   #$F,D1
            moveq   #0,D2
            bra.b   MakeAsyncRequest
ListenR3:
            move.b  D1,(fDBByte0,A3)
            move.b  #$FE,(fDBByte1,A3)
            moveq   #listenCmd+3,D1
            moveq   #2,D2
MakeAsyncRequest:
            lsl.b   #4,D0
            or.b    D1,D0
            move.b  D2,(fDBCnt,A3)
            pea     (fDBCnt,A3)
            movea.l SP,A0
            movea.l ($5F0).w,A1                     ; jADBop
            jsr     (A1)
            addq.w  #8,SP
            rts
GNextAddr:
            moveq   #0,D0
            moveq   #0,D1
            move.b  (InitAddr,A3),D0
            move.w  (devMap,A3),D1
.L1:
            btst    D0,D1
            bne.b   .L2
            addq.w  #1,D0
            cmpi.w  #numFDBAdr,D0
            blt.b   .L1
            moveq   #-1,D0
            rts
.L2:
            move.b  D0,(InitAddr,A3)
            rts
GEmptyAddr:
            moveq   #0,D1
            moveq   #numFDBAdr-1,D0
            move.w  (devMap,A3),D1
.L1:
            btst    D0,D1
            dbeq    D0,.L1
            tst.w   D0
            rts
FDBTask:
            rts
RSetKMap:
            lea     KeyMap,A0
            moveq   #8,D0
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            clr.w   HiKeyLast
            rts
DefaultDev:
            moveq   #kbdAddr,D0
            bsr.w   FindFDBInfo
            tst.b   D0
            beq.b   .ChkMouse
            move.b  #1,(A1)
            move.b  #2,(1,A1)
            move.b  #2,(2,A1)
            lea     KbdDrvr,A0
            move.l  A0,(4,A1)
            bset    #2,($14F,A3)
.ChkMouse:
            moveq   #3,D0
            bsr.w   FindFDBInfo
            beq.b   .L2
            move.b  #1,(A1)
            move.b  #3,(1,A1)
            move.b  #3,(2,A1)
            lea     MouseDrvr,A0
            move.l  A0,(4,A1)
            bset    #3,($14F,A3)
.L2:
            rts
MouseDrvr:
            lea     (1,A0),A1
            move.b  (A1)+,D2
            move.b  MBState,D1
            eor.b   D2,D1
            bpl.b   .L2
            move.l  Ticks,D1
            sub.l   MBTicks,D1
            movea.w #2,A0
            moveq   #-$80,D0
            and.b   D2,D0
            bmi.b   .L1
            subq.l  #2,D1
            blt.b   .L2
            addq.l  #2,D1
            subq.w  #1,A0
.L1:
            move.b  D0,MBState
            add.l   D1,MBTicks
            add.l   D1,RndSeed
            moveq   #0,D0
            _PostEvent
.L2:
            add.b   D2,D2
            beq.b   .L3
            asr.b   #1,D2
            ext.w   D2
            add.w   D2,MTemp
            move.b  CrsrCouple,CrsrNew
.L3:
            move.b  (A1),D2
            add.b   D2,D2
            beq.b   .L4
            asr.b   #1,D2
            ext.w   D2
            add.w   D2,($82A).w
            move.b  CrsrCouple,CrsrNew
.L4:
            rts
KbdDrvr:
            move.l  A2,D3
            beq.w   sub_4080AC00.L1
            movea.l A0,A1
            lsr.w   #4,D0
            moveq   #$F,D1
            and.l   D1,D0
            move.l  D0,D3
            lea     (-$A,SP),SP
            movea.l SP,A0
            _GetADBInfo
            ror.l   #8,D3
            move.w  (SP)+,D3
            addq.l  #8,SP
            swap    D3
            move.b  (1,A1),D0
            move.b  (2,A1),-(SP)
            bsr.b   sub_4080AB72
            move.b  (SP)+,D0
sub_4080AB72:
            cmpi.b  #$FF,D0
            beq.w   sub_4080AC00.L1
            clr.w   KeyLast
            clr.w   KbdVars
            moveq   #$7F,D1
            and.b   D0,D1
            movea.l (A2),A1
            move.b  (4,A1,D1.w),D3
            bpl.b   .L2
            bclr    #7,D3
            lea     ($84,A1),A0
            move.w  (A0)+,D2
            beq.b   .L2
            subq.w  #1,D2
.L1:
            cmp.b   (A0)+,D0
            beq.w   sub_4080AC00.L3
            move.b  (1,A0),D1
            lea     (2,A0,D1.w),A0
            dbra    D2,.L1
.L2:
            moveq   #0,D2
            move.b  D3,D2
            lsr.w   #3,D2
            tst.b   D0
            bmi.b   .L3
            bset    D3,(4,A2,D2.w)
            bra.b   .L4
.L3:
            bclr    D3,(4,A2,D2.w)
            bset    #7,D3
.L4:
            movem.l (4,A2),D0-D2/A0
            movem.l D0-D2/A0,KeyMap
            move.l  D3,D0
            lsr.l   #8,D0
            move.b  D0,($218).w
            swap    D0
            move.b  D0,KbdType
            move.w  ($A,A2),D0
            rol.w   #1,D0
            subq.l  #4,SP
            move.l  ($14,A2),-(SP)
            move.w  D3,-(SP)
            move.b  D0,(SP)
            pea     ($18,A2)
            _KeyTrans
            move.w  (SP)+,D0
            beq.b   .L5
            bsr.b   sub_4080AC00
.L5:
            move.w  (SP)+,D0
            beq.b   sub_4080AC00.L1
sub_4080AC00:
            ror.w   #8,D0
            swap    D0
            move.w  D3,D0
            rol.l   #8,D0
            tst.b   D3
            bmi.b   .L2
            move.l  Ticks,D1
            move.l  D1,KeyTime
            move.l  D1,KeyRepTime
            move.w  D0,KeyLast
            swap    D0
            move.w  D0,KbdVars
            swap    D0
            movea.w #3,A0
            _PostEvent
.L1:
            rts
.L2:
            movea.w #4,A0
            bclr    #$F,D0
            _PostEvent
            rts
.L3:
            move.b  (A0)+,D1
            bpl.b   .L4
            moveq   #0,D2
            move.b  D3,D2
            lsr.w   #3,D2
            btst    D3,(4,A2,D2.w)
            seq     D0
.L4:
            moveq   #$F,D2
            and.b   D1,D2
            beq.b   .L1
            tst.b   ($1C,A2)
            bne.w   sub_4080AB72.L2
            movem.l D0/A1,-(SP)
            move.l  A0,-(SP)
            cmpi.b  #$C,D2
            bge.b   .L5
            pea     sub_4080AD0A
            bra.b   .L6
.L5:
            pea     sub_4080ACC2
.L6:
            lea     ($1D,A2),A1
            move.b  (A1)+,D1
            beq.b   .L10
            subq.w  #1,D1
.L7:
            tst.b   (A1)+
            beq.b   .L8
            lea     (9,A1),A1
            dbra    D1,.L7
            bra.b   .L10
.L8:
            move.b  D0,(-1,A1)
            bset    #1,(-1,A1)
            move.l  A1,-(SP)
            move.b  (A0),D1
            cmpi.b  #8,D1
            bls.b   .L9
            moveq   #8,D1
.L9:
            move.b  (A0)+,(A1)+
            dbra    D1,.L9
            move.w  D3,D0
            clr.b   D0
            lsr.w   #4,D0
            or.b    D2,D0
            movea.l SP,A0
            _ADBOp
            bne.b   .L11
            addq.l  #4,SP
.L10:
            addq.l  #8,SP
            movem.l (SP)+,D0/A1
            bra.w   sub_4080AB72.L2
.L11:
            movea.l (SP)+,A1
            clr.b   (-1,A1)
            bra.b   .L10
sub_4080ACC2:
            movea.l A0,A1
            moveq   #0,D1
            move.b  (A1)+,D1
            move.b  (A2)+,D2
            cmp.b   D2,D1
            bls.b   .L1
            move.b  D2,D1
.L1:
            tst.b   (-1,A0)
            bpl.b   .L5
            bra.b   .L3
.L2:
            move.b  (A2)+,D2
            or.b    D2,(A1)+
.L3:
            dbra    D1,.L2
            bra.b   .L6
.L4:
            move.b  (A2)+,D2
            not.b   D2
            and.b   D2,(A1)+
.L5:
            dbra    D1,.L4
.L6:
            clr.l   -(SP)
            pea     sub_4080AD0A
            move.l  A0,-(SP)
            movea.l SP,A0
            bclr    #2,D0
            _ADBOp
            bne.b   .L7
            movea.l (SP),A0
            clr.b   (-1,A0)
.L7:
            lea     ($C,SP),SP
            rts
sub_4080AD0A:
            clr.b   (-1,A0)
            rts
sub_4080AD10:
            moveq   #$10,D1
            movea.l ADBBase,A1
            bra.b   .L2
.L1:
            lea     ($C,A1),A1
.L2:
            moveq   #2,D0
            cmp.b   (1,A1),D0
            bne.b   .L3
            moveq   #$32,D0
            _NewPtrSysClear
            movea.l A0,A2
            move.b  #2,($1D,A2)
            subq.l  #4,SP
            move.l  #'KCHR',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            move.l  (A0),($14,A2)
            subq.l  #4,SP
            move.l  #'KMAP',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            move.l  (A0),(A2)
            move.l  A2,(8,A1)
            move.b  (A1),KbdType
            move.b  (2,A1),($218).w
.L3:
            dbra    D1,.L1
            rts
KeyTrans:
            movea.l IntlSpec,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L4
            move.l  ($176,A0),D0
            beq.b   .L4
            link.w  A6,#0
            movem.l D3-D5,-(SP)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D4
            move.b  KbdType,D4
            swap    D4
            move.w  ($C,A6),D4
            move.w  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D0
            move.w  (A0)+,D1
            move.w  (A0)+,D2
            move.l  D4,D3
            and.w   D1,D3
            cmp.l   D0,D3
            bne.b   .L2
            and.w   D1,D2
            not.w   D1
            and.w   D1,D4
            or.w    D4,D2
            move.w  D2,($C,A6)
            bra.b   .L3
.L2:
            dbra    D5,.L1
.L3:
            movem.l (SP)+,D3-D5
            unlk    A6
.L4:
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            movem.l D3/A2,-(SP)
            move.w  D1,D2
            lsr.w   #8,D2
            move.b  (2,A1,D2.w),D2
            moveq   #$7F,D0
            and.b   D1,D0
            ext.w   D1
            ext.l   D1
            move.b  D2,D1
            lsl.w   #8,D1
            move.b  D0,D1
            lsl.w   #7,D2
            or.b    D1,D2
            lea     ($104,A1),A1
            move.b  (0,A1,D2.w),D0
            beq.b   .L8
            tst.l   D1
            bmi.b   .L10
            move.l  (A0),D3
            beq.b   .L10
            clr.l   (A0)
            lea     (0,A1,D3.l),A2
            move.w  (A2)+,D2
            beq.b   .L6
            subq.w  #1,D2
.L5:
            cmp.b   (A2)+,D0
            beq.b   .L7
            addq.l  #1,A2
            dbra    D2,.L5
.L6:
            swap    D0
            move.w  (A2),D0
            swap    D0
            bra.b   .L10
.L7:
            move.b  (A2),D0
            bra.b   .L10
.L8:
            move.w  (-2,A1),D3
            lsl.w   #7,D3
            lea     (0,A1,D3.w),A2
            move.w  (A2)+,D2
            beq.b   .L10
            subq.w  #1,D2
.L9:
            cmp.w   (A2)+,D1
            beq.b   .L11
            move.w  (A2)+,D3
            lsl.w   #1,D3
            lea     (2,A2,D3.w),A2
            dbra    D2,.L9
.L10:
            movem.l (SP)+,D3/A2
            move.l  D0,(4,SP)
            rts
.L11:
            tst.l   D1
            bmi.b   .L14
            move.l  (A0),D3
            beq.b   .L12
            moveq   #0,D2
            move.w  (0,A1,D3.l),D2
            lsl.w   #1,D2
            add.l   D2,D3
            move.w  (2,A1,D3.l),D0
.L12:
            tst.w   (A2)
            beq.b   .L13
            move.l  A2,D2
            sub.l   A1,D2
            move.l  D2,(A0)
            bra.b   .L10
.L13:
            clr.l   (A0)
            swap    D0
            move.w  (2,A2),D0
            bra.b   .L10
.L14:
            move.w  (A2)+,D3
            lsl.w   #1,D3
            move.w  (0,A2,D3.w),D0
            bra.b   .L10
            ds.b    8
TimeMgr:
RmvTime:
            move.l  D3,-(SP)
            bsr.w   FreezeTime
            moveq   #0,D2
            lea     (A2),A1
.L1:
            move.l  (A1),D0
            beq.b   .L3
            exg     D0,A1
            move.l  ($A,A1),D1
            add.l   D1,D2
            cmpa.l  A0,A1
            bne.b   .L1
            movea.l D0,A1
            move.l  (A0),D0
            move.l  D0,(A1)
            beq.b   .L2
            movea.l D0,A1
            add.l   D1,($A,A1)
.L2:
            move.l  D2,D0
.L3:
            sub.l   ($C,A2),D0
            bcc.b   .L4
            moveq   #0,D0
.L4:
            bsr.w   ThawTime
            movea.l D0,A1
            bsr.b   MultAndMerge
            _NewEmptyHandle clear
            dc.w    $10BC,$F800,0,$EB98,$4480,$6B0C,$2009,$6126
            dc.w    $053A,$8FE6
            ds.b    4
            dc.w    $2140,$000A,$261F,$7200
InsTime:
            moveq   #$1F,D0
            and.b   (4,A0),D0
            andi.w  #$600,D1
            lsr.w   #4,D1
            or.b    D1,D0
            move.b  D0,(4,A0)
            moveq   #0,D0
            rts
MultAndMerge:
            movea.l (SP)+,A2
            move.l  (A2)+,D1
            mulu.l  D0,D0:D1
            move.l  (A2)+,D2
            beq.b   .L1
            and.l   D2,D1
            add.l   D0,D2
            subx.l  D2,D2
            or.l    D2,D0
            or.l    D1,D0
.L1:
            jmp     (A2)
PrimeTime:
            move.l  D3,-(SP)
            tst.l   D0
            bpl.b   .L1
            neg.l   D0
            bsr.b   MultAndMerge
            dc.w    $0C88,$A47F
            ds.b    4
            dc.w    $600C
.L1:
            bsr.b   MultAndMerge
            muls.w  (SP),D1
            dc.w    $0A3E,$FC00,0,$ED98,$6100,$0082,$08E8,$0007
            dc.w    $0004,$666E,$0828,$0006,$0004,$6740,$242A,$0008
            dc.w    $2228,$000E,$672C,$9282,$6A26,$D081,$6524,$D480
            dc.w    $6602,$7401,$2142,$000E,$2200,$91AA,$000C,$7000
            dc.w    $43D2,$2411,$6734,$C589,$93A9,$000A,$C589,$602A
            dc.w    $D081,$D480,$6602,$7401,$2142,$000E,$D0AA,$000C
            dc.w    $43D2,$2411,$6714,$C589,$2229,$000A,$9081,$64F2
            dc.w    $D081,$9280,$2341,$000A,$C589,$2082,$2140,$000A
            dc.w    $2288,$6100,$009C,$261F,$7000,$4E75
FreezeTime:
            move    SR,D3
            swap    D3
            move.w  #$F0,D3
            movea.l VIA,A1
            lea     (vT2CH,A1),A1
            movea.l TimeVars,A2
            ori     #$700,SR
            move.b  (A1),D2
            moveq   #$20,D1
            and.b   ($800,A1),D1
            neg.l   D1
            move.b  D2,D1
            lsl.w   #8,D1
            move.b  (-$200,A1),D1
            sub.b   (A1),D2
            beq.b   .L1
            subx.l  D2,D2
            or.l    D2,D1
            move.b  (A1),D1
            lsl.w   #8,D1
            move.b  (-$200,A1),D1
.L1:
            moveq   #$F,D2
            add.l   D2,D1
            and.b   D1,D3
            asr.l   #4,D1
            sub.l   D1,(8,A2)
            move.l  (A2),D2
            beq.b   .L3
            movea.l D2,A1
            moveq   #0,D2
            sub.l   ($C,A2),D1
            bpl.b   .L4
            add.l   ($A,A1),D1
            bcs.b   .L2
            sub.l   D1,D2
            moveq   #0,D1
.L2:
            move.l  D1,($A,A1)
.L3:
            move.l  D2,($C,A2)
            rts
.L4:
            add.l   ($A,A1),D1
            bra.b   .L2
sub_4080B02C:
            bsr.b   FreezeTime
            move.l  (A2),D0
            beq.b   ThawTime
            movea.l D0,A0
            tst.l   ($A,A0)
            bne.b   ThawTime
            move.l  (A0),(A2)
            bclr    #7,(4,A0)
            bsr.b   ThawTime
            move.l  (6,A0),D0
            beq.b   .L1
            movea.l A0,A1
            movea.l D0,A0
            jmp     (A0)
.L1:
            rts
ThawTime:
            move.l  #$FFF,D2
            add.b   (4,A2),D3
            move.l  (A2),D1
            beq.b   .L4
            movea.l D1,A1
            move.l  ($A,A1),D1
            sub.l   ($C,A2),D1
            bcc.b   .L1
            neg.l   D1
            move.l  D1,($C,A2)
            moveq   #0,D1
            bra.b   .L2
.L1:
            clr.l   ($C,A2)
.L2:
            cmp.l   D2,D1
            bcc.b   .L3
            move.l  D1,D2
.L3:
            sub.l   D2,D1
            move.l  D1,($A,A1)
.L4:
            movea.l VIA,A1
            lea     (vT2C,A1),A1
            move.w  D3,D1
.L5:
            add.l   D2,(8,A2)
            lsl.w   #4,D2
            lea     ($200,A1),A2
            sub.b   (A1),D3
            sub.w   D3,D2
            bls.b   .L6
            move.b  D1,(A2)
            move.b  D2,(A1)
            lsr.w   #8,D2
            move.b  D2,(A2)
            swap    D3
            move    D3,SR
            rts
.L6:
            add.w   D2,D3
            sub.b   D3,D1
            neg.w   D2
            movea.l TimeVars,A2
            add.w   (6,A2),D2
            lsr.w   #4,D2
            add.l   D2,($C,A2)
            move.w  D1,D3
            bra.b   .L5
InitTimeMgr:
            movem.l D0-D5/A0-A4,-(SP)
            moveq   #$10,D0
            _NewPtrSysClear
            move.l  A0,TimeVars
            movea.l A0,A2
            move.w  #$18,(6,A2)
            lea     sub_4080B02C,A1
            move.l  A1,($1A6).w
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA,A4
            lea     (vT2C,A4),A1
            lea     (vT1C,A4),A3
            lea     (vACR,A4),A4
            moveq   #-$60,D1
            move.b  D1,($C00,A1)
            moveq   #-$21,D5
            and.b   (A4),D5
            moveq   #$3F,D0
            and.b   D5,D0
            move.b  D0,(A4)
            moveq   #0,D3
            move    SR,D3
            swap    D3
            move.b  D1,($200,A3)
            move.b  D1,($200,A1)
            move.b  (A1),D0
            sub.b   (A3),D0
            bsr.w   ThawTime
            move.b  (A1),D1
            sub.b   (A3),D1
            sub.b   D0,D1
            subi.w  #$FFF0,D1
            move.b  D1,(4,A0)
            move.b  D5,(A4)
            st      ($200,A1)
            move    (SP)+,SR
            movem.l (SP)+,D0-D5/A0-A4
            rts
            ds.b    6
clock:
OneSecInt:
            move.b  #1,($1A00,A1)
            addq.l  #1,TimeLM
            bclr    #5,AlarmSt
            tst.b   SPVolCtl
            bpl.b   .L1
            move.l  SPAlarm,D0
            beq.b   .L1
            cmp.l   TimeLM,D0
            bhi.b   .L1
            bclr    #1,AlarmSt
.L1:
            rts
ClkRW:
            move    SR,-(SP)
            movem.l D1/D3-D4/A0-A1/A5-A6,-(SP)
            movea.l VIA,A1
            lea     .L1,A5
            movea.l ($54C).w,A0
            jmp     (A0)
.L1:
            movem.l (SP)+,D1/D3-D4/A0-A1/A5-A6
            move    (SP)+,SR
            rts
ReadXPRam:
            movem.l D1-D3/A1-A2,-(SP)
            move.w  #$17E0,D1
            bra.b   WriteXPRam.L1
WriteXPRam:
            movem.l D1-D3/A1-A2,-(SP)
            jsr     WPOFF
            move.w  #$7E0,D1
.L1:
            btst    #6,HWCfgFlags
            beq.b   XPRAMEXIT1.L1
            BigJmp  XPRAMPATCH,A2
XPRAMCONT:
            lsl.w   #2,D0
            move.l  D0,D3
            swap    D3
            movea.l A0,A1
            bra.b   .L2
.L1:
            move.w  D0,D1
            ror.w   #8,D1
            move.b  (A1),D2
            bsr.b   ClkRW
            move.b  D2,(A1)+
            ori.b   #$80,D0
            addq.w  #4,D0
            andi.w  #$BFFF,D0
            ori.w   #$3800,D0
.L2:
            dbra    D3,.L1
            jsr     WPON
            moveq   #0,D0
XPRAMEXIT1:
            movem.l (SP)+,D1-D3/A1-A2
            rts
.L1:
            moveq   #-$57,D0
            bra.b   XPRAMEXIT1
ClkNoMem:
            BigJsr  CLKNOMEMPATCH,A6
            RTS5
            cmpi.w  #$38,D4
            bne.b   .L1
            move.w  D1,D4
            swap    D1
            move.w  D4,D1
            BSR6    .L5
            lsr.l   #8,D1
            tst.w   D1
            bra.b   .L2
.L1:
            tst.b   D1
.L2:
            bmi.b   .L3
            BSR6    .L5
            move.w  D2,D1
            BSR6    .L5
            bra.b   .L4
.L3:
            BSR6    .L5
            BSR6    .L7
.L4:
            bset    #2,(A1)
            RTS5
.L5:
            moveq   #7,D4
.L6:
            ror.b   #1,D3
            roxl.b  #1,D1
            roxl.b  #1,D3
            move.b  D3,(A1)
            bset    #1,(A1)
            dbra    D4,.L6
            RTS6
.L7:
            moveq   #7,D4
            bclr    #0,($400,A1)
.L8:
            move.b  D3,(A1)
            bset    #1,(A1)
            move.b  (A1),D1
            lsr.b   #1,D1
            roxl.b  #1,D2
            dbra    D4,.L8
            bset    #0,($400,A1)
            RTS6
.L9:
            moveq   #$35,D1
            moveq   #-$2B,D2
            bra.w   ClkNoMem
.L10:
            moveq   #$35,D1
            moveq   #$55,D2
            bra.w   ClkNoMem
ValidatePRAM:
            BigJmp  ValidatePRAMPatch,A2
            nop
VALIDATEPRAMCONT:
            movea.l A6,A4
            move    SR,D5
            swap    D5
            BSR5    ClkNoMem.L10
            moveq   #$31,D1
            moveq   #0,D2
            BSR5    ClkNoMem
            BSR5    ClkNoMem.L9
            moveq   #-$3F,D1
            BSR5    ClkNoMem
            cmpi.b  #$A8,D2
            beq.b   .L3
            BSR5    ClkNoMem.L10
            lea     PRAMInit,A2
            moveq   #$F,D6
            move.b  #$41,D5
.L1:
            move.b  D5,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            addq.b  #4,D5
            dbra    D6,.L1
            moveq   #3,D6
            move.b  #$21,D5
.L2:
            move.b  D5,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            addq.b  #4,D5
            dbra    D6,.L2
            BSR5    ClkNoMem.L9
.L3:
            move.w  #$B830,D5
            moveq   #3,D6
.L4:
            lsl.l   #8,D2
            move.w  D5,D1
            ror.w   #8,D1
            BSR5    ClkNoMem
            ori.w   #$80,D5
            addq.w  #4,D5
            dbra    D6,.L4
            lea     .L7,A2
            cmp.l   (A2),D2
            beq.b   .L6
            BSR5    ClkNoMem.L10
            move.w  #$3830,D5
            moveq   #3,D6
            BSR5    .L9
            move.w  #$3900,D5
.L5:
            lea     .L8,A2
            moveq   #3,D6
            BSR5    .L9
            cmpi.w  #$38A0,D5
            bne.b   .L5
            move.w  #$3B58,D5
            lea     PRAMInitTbl,A2
            moveq   #$13,D6
            BSR5    .L9
            BSR5    ClkNoMem.L9
.L6:
            swap    D5
            move    D5,SR
            jmp     (A4)
.L7:
            dc.w    $4E75,$4D63
.L8:
            ds.b    4
.L9:
            movea.l A5,A3
.L10:
            move.w  D5,D1
            ror.w   #8,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            ori.w   #$80,D5
            addq.w  #4,D5
            andi.w  #$BFFF,D5
            ori.w   #$3800,D5
            dbra    D6,.L10
            jmp     (A3)
            dc.w    0
Events:
PostEvent:
            bsr.l   OSEVENTMGRPATCH
            btst    D1,D2
            bne.b   .L1
            moveq   #1,D0
            rts
.L1:
            move    SR,-(SP)
            move.l  D0,-(SP)
            move.w  A0,-(SP)
            movea.l SysEvtBuf,A0
            addq.l  #6,A0
            moveq   #$16,D0
            moveq   #-1,D1
            suba.w  D0,A0
            move.w  EvtBufCnt,D2
            ori     #$700,SR
.L2:
            adda.w  D0,A0
            cmp.w   (A0),D1
            dbeq    D2,.L2
            lea     EventQueue,A1
            beq.b   .L3
            movea.l (2,A1),A0
            move.l  (A0),(2,A1)
            addq.l  #6,A0
.L3:
            move.w  (SP)+,(A0)
            move.l  (SP)+,(2,A0)
            bsr.b   FillRecord
            subq.l  #6,A0
            move.w  #4,(4,A0)
            jsr     QStuff
            move    (SP)+,SR
            moveq   #0,D0
            rts
FillRecord:
            move.l  Ticks,(6,A0)
            move.l  Mouse,($A,A0)
            move.w  ($17A).w,D1
            rol.w   #1,D1
            move.b  D1,($E,A0)
            move.b  MBState,($F,A0)
            rts
OSEventAvail:
            lea     EventQueue,A1
            move    SR,-(SP)
            ori     #$700,SR
            move.l  (2,A1),D1
            beq.b   .L2
.L1:
            movea.l D1,A1
            move.w  (6,A1),D1
            btst    D1,D0
            bne.b   .L3
            move.l  (A1),D1
            bne.b   .L1
.L2:
            and.w   SysEvtMask,D0
            btst    #5,D0
            beq.b   .L4
            move.w  KbdVars,D0
            swap    D0
            move.w  KeyLast,D0
            tst.l   D0
            beq.b   .L4
            move.l  Ticks,D1
            move.l  D1,D2
            sub.l   KeyTime,D1
            cmp.w   KeyThresh,D1
            blt.b   .L4
            sub.l   KeyRepTime,D2
            cmp.w   KeyRepThresh,D2
            blt.b   .L4
            move.l  Ticks,KeyRepTime
            move.l  A0,-(SP)
            movea.w #5,A0
            bsr.w   Events
            movea.l A0,A1
            movea.l (SP)+,A0
.L3:
            move    (SP)+,SR
            moveq   #4,D0
            movem.l A0-A1,-(SP)
            addq.l  #6,A1
            bsr.l   OSEVENTAVAILPATCH
            movem.l (SP)+,A0-A1
            rts
.L4:
            bsr.w   FillRecord
            move    (SP)+,SR
            clr.w   (A0)
            clr.l   (2,A0)
            moveq   #-1,D0
            rts
GetOSEvent:
            bsr.w   OSEventAvail
            bne.b   .L1
            move.l  A0,-(SP)
            movea.l A1,A0
            lea     EventQueue,A1
            bsr.b   sub_4080B4C0
            movea.l (SP)+,A0
            moveq   #0,D0
.L1:
            BigJmp  SMGRPOSTMUNGING,A1
sub_4080B4C0:
            jsr     DequeueTrap
            move.w  #$FFFF,(6,A0)
            rts
FlushEvents:
            move    SR,-(SP)
            movem.l D3-D4,-(SP)
            moveq   #-1,D1
            move.l  D1,LastSPExtra
            move.l  D0,D1
            swap    D1
            move.w  D0,D4
            and.w   FlEvtMask,D4
            lea     EventQueue,A1
            ori     #$700,SR
            move.l  (2,A1),D3
            beq.b   .L3
.L1:
            movea.l D3,A0
            move.l  (A0),D3
            move.w  (6,A0),D2
            btst    D2,D1
            bne.b   .L4
            btst    D2,D4
            beq.b   .L2
            bsr.b   sub_4080B4C0
.L2:
            tst.l   D3
            bne.b   .L1
.L3:
            moveq   #0,D2
.L4:
            movem.l (SP)+,D3-D4
            move.w  D2,D0
            ext.l   D0
            move    (SP)+,SR
            rts
            ds.b    12
FSIODneTbl:
IOCORE:
            dc.w    $0006,$004A,$0052
Fetch:
            bclr    #$F,D0
.L1:
            movem.l D1/A2-A3,-(SP)
            move.l  (8,A1),D1
            beq.b   .L5
            movea.l D1,A3
            move.l  ($28,A3),D1
            movea.l ($20,A3),A2
            bclr    #$F,D0
            bne.b   .L2
            move.b  (0,A2,D1.l),D0
            bra.b   .L3
.L2:
            move.b  D0,(0,A2,D1.l)
.L3:
            addq.l  #1,D1
            move.l  D1,($28,A3)
            cmp.l   ($24,A3),D1
            blt.b   .L4
            bset    #$F,D0
.L4:
            ext.l   D0
            movem.l (SP)+,D1/A2-A3
            rts
.L5:
            moveq   #$E,D0
            _SysError
Stash:
            bset    #$F,D0
            bra.b   Fetch.L1
.L1:
            moveq   #0,D0
IODone:
            move.w  D0,-(SP)
            move.l  D0,-(SP)
            move.l  A1,D0
            _StripAddress
            movea.l D0,A1
            move.l  (SP)+,D0
            bsr.b   sub_4080B584
            move.w  (SP)+,D0
            rts
sub_4080B584:
            move.l  (8,A1),D1
            beq.b   sub_4080B5A4.L1
            move    SR,-(SP)
            move    SR,D1
            ori     #$700,SR
            bsr.b   sub_4080B5A4
            bsr.b   PostCompletion
            ori     #$700,SR
            tst.l   (8,A1)
            bne.b   DoAsyncIO.L1
            move    (SP)+,SR
            rts
sub_4080B5A4:
            bclr    #7,(5,A1)
.L1:
            btst    #6,(4,A1)
            bne.b   .L2
            movea.l (A1),A0
            move.l  D0,-(SP)
            _HUnlock
            movea.l A1,A0
            _RecoverHandle sys
            _HUnlock
            move.l  (SP)+,D0
.L2:
            rts
PostCompletion:
            movea.l (8,A1),A0
            cmpi.w  #2,(4,A0)
            bne.b   Fetch.L5
            move.l  (A0),(8,A1)
            bne.b   .L1
            clr.l   ($C,A1)
.L1:
            move    D1,SR
            move.w  D0,($10,A0)
            ble.b   .L2
            clr.w   ($10,A0)
.L2:
            move.l  ($C,A0),D1
            beq.b   .L3
            move.l  A1,-(SP)
            movea.l D1,A1
            ext.l   D0
            jsr     (A1)
            movea.l (SP)+,A1
.L3:
            rts
DoAsyncIO:
            move.l  A1,D1
            lea     (6,A1),A1
            move    SR,-(SP)
            ori     #$700,SR
            jsr     QStuff
            movea.l D1,A1
.L1:
            bset    #7,(5,A1)
            beq.b   .L2
            moveq   #0,D0
            move    (SP)+,SR
            rts
.L2:
            move    (SP)+,SR
            movea.l (8,A1),A0
.L3:
            moveq   #$C,D1
            cmpi.b  #4,(7,A0)
            beq.b   GoDriver
            moveq   #$E,D1
            cmpi.b  #5,(7,A0)
            beq.b   GoDriver
            tst.l   ($24,A0)
            beq.w   Stash.L1
            move.w  ($2C,A0),D0
            move.l  ($2E,A0),D1
            roxr.b  #2,D0
            bpl.b   .L5
            bcc.b   .L4
            add.l   ($10,A1),D1
.L4:
            move.l  D1,($10,A1)
.L5:
            moveq   #$A,D1
GoDriver:
            move.l  ($6D4).w,-(SP)
            rts
vGoDriver:
            move.l  (A1),D0
            bne.b   .L1
            moveq   #-$16,D0
            move.w  D0,($10,A0)
            rts
.L1:
            movem.l D3-D7/A1-A6,-(SP)
            movea.l D0,A2
            btst    #6,(5,A1)
            beq.b   .L3
            movea.l A0,A3
            movea.l A1,A0
            _RecoverHandle sys
            _HLock
            exg     A0,A3
            tst.l   (A2)
            bne.b   .L2
            move.l  A2,-(SP)
            _LoadResource
            move.w  ResErr,D0
            bne.b   .L4
.L2:
            exg     A0,A2
            _HLock
            exg     A0,A2
            move.l  (A2),D0
            _StripAddress
            movea.l D0,A2
.L3:
            move.w  (0,A2,D1.w),D1
            moveq   #0,D0
            jsr     (0,A2,D1.w)
            bra.b   .L5
.L4:
            move.w  D0,($10,A0)
.L5:
            ext.l   D0
            movem.l (SP)+,D3-D7/A1-A6
            rts
MapUnit:
            not.w   D2
            bmi.b   .L1
            cmp.w   UnitNtryCnt,D2
            bge.b   .L1
            asl.w   #2,D2
            movea.l UTableBase,A1
            move.l  (0,A1,D2.w),D2
            beq.b   .L1
            movea.l D2,A2
            move.l  (A2),D2
            beq.w   Fetch.L5
            movea.l D2,A1
            rts
.L1:
            movea.l D5,A0
            movem.l (SP)+,D0/D3-D5/A2-A4
            moveq   #-$15,D0
            move.w  D0,($10,A0)
            rts
IsSlotDrvr:
            movem.l D0,-(SP)
            movea.l D5,A4
            btst    #1,(6,A4)
            beq.w   .L2
            btst    #0,($21,A4)
            bne.b   .L1
            tst.w   ($22,A4)
            beq.w   .L2
.L1:
            moveq   #0,D0
            bra.b   .L3
.L2:
            moveq   #-1,D0
.L3:
            movem.l (SP)+,D0
            rts
SetUpspBlk:
            movea.l D5,A0
            move.l  ($12,A0),($10,A4)
            move.w  ($20,A0),D0
            btst    #0,D0
            beq.b   .L1
            move.l  A0,D0
            movea.l ($22,A0),A0
            move.l  A0,($14,A4)
            move.b  (A0),($31,A4)
            move.b  (1,A0),($32,A4)
            move.b  ($10,A0),($33,A4)
            movea.l D0,A0
            bra.b   .L2
.L1:
            move.b  ($22,A0),($31,A4)
            move.b  ($23,A0),($32,A4)
            clr.b   ($33,A4)
.L2:
            rts
.L3:
            movea.l D5,A0
            move.w  (6,A0),D1
            BigJmp  OPENPATCH,A1
            nop
OPENPATCHRTN:
            jmp     FileOpen
OPENPATCHRTN1:
            moveq   #-$17,D0
            bra.w   OpenExit
Open:
            movem.l D3-D5/A2-A4,-(SP)
            move.l  A0,D5
            move.w  D1,(6,A0)
            move.w  ($1A,A0),D2
            movea.l ($12,A0),A0
            moveq   #0,D1
            move.b  (A0)+,D1
            cmpi.b  #$40,D2
            beq.w   NonSlotDrvr
            cmpi.b  #$2E,(A0)
            bne.b   SetUpspBlk.L3
            bsr.w   IsSlotDrvr
            bne.w   NonSlotDrvr
            suba.w  #$38,SP
            movea.l SP,A4
            bsr.w   SetUpspBlk
            move.w  UnitNtryCnt,D2
            subi.w  #$30,D2
            moveq   #-$31,D4
            movea.l UTableBase,A3
            moveq   #$30,D0
            lsl.l   #2,D0
            adda.l  D0,A3
.L1:
            move.l  (A3)+,D0
            beq.b   .L3
            movea.l D0,A2
            move.l  (A2),D0
            bne.b   .L2
            clr.l   -(A3)
            bra.b   .L1
.L2:
            movea.l D0,A1
            move.b  ($28,A1),D0
            cmp.b   ($31,A4),D0
            bne.b   .L3
            move.b  ($29,A1),D0
            cmp.b   ($32,A4),D0
            bne.b   .L3
            move.b  ($32,A1),D0
            cmp.b   ($33,A4),D0
            beq.b   .L4
.L3:
            subq.w  #1,D4
            subq.w  #1,D2
            bgt.b   .L1
            bra.b   .L6
.L4:
            move.l  (A1),D0
            beq.b   .L5
            movea.l D0,A1
            move.l  (A1),D0
            bne.w   .L14
.L5:
            movea.l A2,A0
            _DisposPtr
            clr.l   -(A3)
.L6:
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            move.l  ($10,A4),-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetNamedResource
            move.l  (SP)+,D3
            movea.l A4,A0
            _sGetDriver
            beq.b   .L7
            tst.l   D3
            bne.b   .L9
            bra.w   .L12
.L7:
            movea.l (A0),A3
            movea.l (A3),A1
            moveq   #0,D0
            move.b  ($12,A1),D0
            addq.w  #2,D0
            bclr    #0,D0
            move.w  ($12,A1,D0.w),D0
            tst.l   D3
            beq.b   .L8
            movea.l D3,A0
            movea.l (A0),A0
            moveq   #0,D2
            move.b  ($12,A0),D2
            addq.w  #2,D2
            bclr    #0,D2
            cmp.w   ($12,A0,D2.w),D0
            bge.b   .L8
            movea.l A3,A0
            _DisposHandle
            move.l  D3,-(SP)
            _DetachResource
            bra.b   .L9
.L8:
            move.l  D3,-(SP)
            _ReleaseResource
            move.l  A3,D3
.L9:
            move.l  D0,-(SP)
            move.l  D3,D0
            _StripAddress
            move.l  D0,D3
            move.l  (SP)+,D0
            moveq   #-$31,D4
            move.w  UnitNtryCnt,D2
            subi.w  #$30,D2
            movea.l UTableBase,A3
            moveq   #$30,D0
            lsl.l   #2,D0
            adda.l  D0,A3
.L10:
            tst.l   (A3)+
            beq.w   .L13
            subq.w  #1,D4
            subq.w  #1,D2
            bgt.b   .L10
            cmpi.w  #$80,UnitNtryCnt
            bge.b   .L11
            move.w  UnitNtryCnt,D0
            addq.w  #4,D0
            cmpi.w  #$80,D0
            bgt.b   .L11
            move.w  D0,UnitNtryCnt
            bra.b   .L13
.L11:
            movea.l D3,A0
            _DisposHandle
            move.w  #$FFE3,D0
            adda.w  #$38,SP
            bra.w   OpenEnd
.L12:
            adda.w  #$38,SP
            bra.w   SetUpspBlk.L3
.L13:
            adda.w  #$38,SP
            bra.w   InstallDrvr
.L14:
            adda.w  #$38,SP
            bra.w   DrvrLock
NonSlotDrvr:
            movea.l UTableBase,A3
            move.w  UnitNtryCnt,D2
            moveq   #-1,D4
CkInstLoop:
            move.l  (A3)+,D0
            beq.b   NextEntry
            movea.l D0,A2
            move.l  (A2),D0
            beq.b   NextEntry
            movea.l D0,A1
            btst    #6,(5,A1)
            movea.l (A1),A1
            beq.b   .L17
            move.l  A1,D0
            beq.b   NextEntry
            movea.l (A1),A1
.L17:
            move.l  A1,D0
            beq.b   NextEntry
            lea     ($12,A1),A1
            move.l  D1,D0
            swap    D0
            move.b  (A1)+,D0
            cmp.b   D0,D1
            bne.b   NextEntry
            _CmpString
            beq.w   DrvrLock
NextEntry:
            subq.w  #1,D4
            subq.w  #1,D2
            bgt.b   CkInstLoop
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            movea.l D5,A0
            move.l  ($12,A0),-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetNamedResource
            move.l  (SP)+,D3
            bne.b   gotDrvr
            move.w  ResErr,D0
            beq.w   SetUpspBlk.L3
            cmpi.w  #$FF40,D0
            beq.w   SetUpspBlk.L3
            bra.w   OpenEnd
gotDrvr:
            clr.w   -(SP)
            move.l  SP,D0
            move.l  D3,-(SP)
            move.l  D0,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResInfo
            move.w  (SP)+,D4
            not.w   D4
            move.w  D4,D0
            bsr.w   MpUnitNum
            bmi.w   OpenEnd
            bne.b   DInstalled
InstallDrvr:
            move.w  D4,D0
            movea.l D3,A0
            movea.l (A0),A0
            btst    #6,(A0)
            beq.b   .L0
            _DrvrInstall async
            bra.b   .L1
.L0:
            _DrvrInstall
.L1:
            bne.w   OpenEnd
DInstalled:
            move.w  D4,D2
            bsr.w   MapUnit
            bset    #5,(5,A1)
            bne.w   DrvrLock
            moveq   #$40,D0
            move.l  D3,(A1)
            movea.l D3,A0
            move.l  (A0),D0
            _StripAddress
            move.l  D0,D3
            move.l  ROMBase,D0
            _StripAddress
            cmp.l   D0,D3
            bcs.b   .L24
            move.l  D3,(A1)
            moveq   #0,D0
            bra.b   .L25
.L24:
            moveq   #$40,D0
.L25:
            movea.l D3,A0
            move.w  (A0)+,(4,A1)
            move.b  D0,(5,A1)
            move.l  (A0)+,($22,A1)
            move.w  (A0)+,($26,A1)
            bsr.w   IsSlotDrvr
            bne.w   DrvrLock
            suba.w  #$38,SP
            movea.l SP,A4
            bsr.w   SetUpspBlk
            move.b  ($31,A4),($28,A1)
            move.b  ($32,A4),($29,A1)
            move.b  ($33,A4),($32,A1)
            clr.l   ($2A,A1)
            movea.l A4,A0
            _sFindDevBase
            bne.b   .L26
            move.l  (A0),($2A,A1)
.L26:
            adda.w  #$38,SP
DrvrLock:
            movea.l (A2),A1
            btst    #6,(4,A1)
            beq.b   FoundUnit
            movea.l (A1),A0
            btst    #6,(5,A1)
            beq.b   .L1
            _HLock
.L1:
            movea.l A2,A0
            _HLock
FoundUnit:
            movea.l D5,A0
            move.w  D4,($18,A0)
            moveq   #-$17,D0
            move.b  (4,A1),D1
            move.w  D1,D2
            or.b    ($1B,A0),D1
            eor.b   D2,D1
            andi.b  #3,D1
            bne.w   OpenEnd
            bset    #5,(5,A1)
            beq.b   .L1
            cmpi.b  #$40,($1B,A0)
            bne.w   OpenOK
.L1:
            moveq   #8,D1
            bsr.w   GoDriver
            bpl.b   .UpdateSRT
            movea.l D5,A0
            clr.w   ($18,A0)
            bclr    #5,(5,A1)
            bra.b   UnLkStuff
.UpdateSRT:
            nop
            bsr.w   IsSlotDrvr
            bne.w   ToUnLkStuff
            suba.w  #$38,SP
            movea.l SP,A4
            bsr.w   SetUpspBlk
            move.w  D4,($26,A4)
            clr.w   ($24,A4)
            exg     A0,A4
            _sUpdateSRT
            exg     A4,A0
            adda.w  #$38,SP
ToUnLkStuff:
            btst    #6,(4,A1)
            bne.b   OpenEnd
UnLkStuff:
            movea.l (A1),A0
            btst    #6,(5,A1)
            beq.b   OpenEnd
            exg     D0,D3
            _HUnlock
            exg     D0,D3
            btst    #6,(4,A1)
            bne.b   OpenEnd
            movea.l A2,A0
            exg     D0,D3
            _HUnlock
            exg     D0,D3
OpenEnd:
            movea.l D5,A0
            movem.l (SP)+,D3-D5/A2-A4
OpenExit:
            move.w  D0,($10,A0)
            rts
OpenOK:
            moveq   #0,D0
            bra.b   OpenEnd
Close:
            move.w  ($18,A0),D2
            bmi.b   .IOClose
            jmp     FileClose
.IOClose:
            movem.l D3-D5/A2-A4,-(SP)
            move.l  A0,D5
            bsr.w   MapUnit
            btst    #5,(5,A1)
            beq.b   OpenOK
            move.l  ($6D8).w,-(SP)
            rts
vWaitUntil:
            btst    #7,(5,A1)
            bne.b   vWaitUntil
            moveq   #$10,D1
            bsr.w   GoDriver
            cmpi.w  #$FFE8,D0
            beq.b   ToUnLkStuff
            bclr    #5,(5,A1)
            tst.b   ($28,A1)
            beq.b   .L1
            suba.w  #$38,SP
            movea.l SP,A4
            move.b  ($28,A1),($31,A4)
            move.b  ($29,A1),($32,A4)
            move.b  ($32,A1),($33,A4)
            clr.w   ($26,A4)
            clr.w   ($24,A4)
            exg     A0,A4
            _sUpdateSRT
            exg     A4,A0
            adda.w  #$38,SP
.L1:
            bra.w   UnLkStuff
Read:
            bsr.l   READUPDATE
            nop
            move.w  ($18,A0),D2
            bmi.b   .L1
            jmp     FileRead
.L1:
            movem.l D3-D5/A2-A4,-(SP)
            moveq   #-$13,D0
            moveq   #0,D4
IORWCS:
            move.l  A0,D5
            bsr.w   MapUnit
            cmpi.b  #3,D1
            bgt.b   .L1
            clr.l   ($28,A0)
.L1:
            move.w  #1,($10,A0)
            move.w  D1,(6,A0)
            move.w  #2,(4,A0)
            btst    D4,(4,A1)
            movem.l (SP)+,D3-D5/A2-A4
            beq.b   vSyncWait.L1
            moveq   #-$1C,D0
            btst    #5,(5,A1)
            beq.b   vSyncWait.L1
            btst    #9,D1
            bne.w   DoAsyncIO.L3
            btst    #$A,D1
            bne.w   DoAsyncIO
            clr.l   ($C,A0)
            move.l  A0,-(SP)
            bsr.w   DoAsyncIO
            movea.l (SP)+,A0
            move.l  ($6DC).w,-(SP)
            rts
vSyncWait:
            move.w  ($10,A0),D0
            bgt.b   vSyncWait
            ext.l   D0
.L1:
            move.w  D0,($10,A0)
            rts
Write:
            bra.l   WRITEUPDATE
            nop
            nop
WriteUpdateReturn:
            movem.l D3-D5/A2-A4,-(SP)
            moveq   #-$14,D0
            moveq   #1,D4
            bra.b   IORWCS
Control:
            movem.l D3-D5/A2-A4,-(SP)
            move.w  ($18,A0),D2
            moveq   #-$11,D0
            moveq   #2,D4
            bra.w   IORWCS
Status:
            movem.l D3-D5/A2-A4,-(SP)
            move.w  ($18,A0),D2
            move.l  A0,D5
            cmpi.w  #1,($1A,A0)
            beq.b   .L1
            moveq   #-$12,D0
            moveq   #3,D4
            bra.w   IORWCS
.L1:
            bsr.w   MapUnit
            move.l  A2,($1C,A0)
            bra.w   OpenOK
KillIO:
            movem.l D3-D5/A2-A4,-(SP)
            move.w  ($18,A0),D2
            move.l  A0,D5
            bsr.w   MapUnit
            move.w  #1,($1A,A0)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #$C,D1
            moveq   #-$11,D0
            moveq   #2,D4
            btst    D4,(4,A1)
            beq.b   .L3
            moveq   #-$1C,D0
            btst    #5,(5,A1)
            beq.b   .L3
            bsr.w   GoDriver
            bne.b   .L3
.L1:
            tst.l   (8,A1)
            beq.b   .L2
            moveq   #-$1B,D0
            move.w  #$2700,D1
            bsr.w   PostCompletion
            bra.b   .L1
.L2:
            bsr.w   sub_4080B5A4
            moveq   #0,D0
.L3:
            move    (SP)+,SR
            bra.w   OpenEnd
DrvrInstall:
            movem.l D3-D5/A2-A4,-(SP)
            movea.l A0,A3
            move.l  D0,D3
            bsr.b   MpUnitNum
            bmi.b   .L5
            bne.b   .L2
            btst    #$A,D1
            beq.b   .L1
            moveq   #$34,D0
            _ResrvMem sys
.L1:
            moveq   #$34,D0
            _NewHandle sys
            bne.b   .L5
.L2:
            moveq   #$33,D0
            movea.l (A0),A1
.L3:
            clr.b   (A1)+
            dbra    D0,.L3
            move.l  A0,(A2)
            movea.l (A0),A3
            bset    #6,(5,A3)
            move.w  D3,($18,A3)
.L4:
            moveq   #0,D0
.L5:
            movem.l (SP)+,D3-D5/A2-A4
            rts
MpUnitNum:
            not.w   D0
            bmi.b   .L1
            cmp.w   UnitNtryCnt,D0
            bge.b   .L1
            asl.w   #2,D0
            movea.l UTableBase,A2
            adda.w  D0,A2
            movea.l (A2),A0
            move.l  A0,D0
            _StripAddress
            tst.l   D0
            rts
.L1:
            moveq   #-$15,D0
            rts
DrvrRemove:
            movem.l D3-D5/A2-A4,-(SP)
            bsr.b   MpUnitNum
            bmi.b   DrvrInstall.L5
            beq.b   DrvrInstall.L4
            movea.l A2,A3
            movea.l D0,A2
            movea.l (A2),A1
            btst    #5,(5,A1)
            bne.b   .L2
            btst    #6,(5,A1)
            beq.b   .L1
            move.l  (A1),-(SP)
            _ReleaseResource
.L1:
            movea.l A2,A0
            _DisposHandle async
            clr.l   (A3)
            bra.b   DrvrInstall.L4
.L2:
            moveq   #-$19,D0
            bra.b   DrvrInstall.L5
AddDrive:
            move.l  D0,(6,A0)
            lea     DrvQHdr,A1
            jsr     QStuff
            moveq   #0,D0
            rts
            ds.b    10
Loader:
LoadSeg:
            movem.l D0-D2/A0-A1,-(SP)
            bra.b   .L1
            ds.b    6
.L1:
            move.w  ($18,SP),D0
            bsr.b   LoadCode
            beq.b   .L6
            _HGetState
            btst    #7,D0
            bne.b   .L3
            tst.b   SegHiEnable
            beq.b   .L2
            _MoveHHi
.L2:
            _HLock
.L3:
            move.l  (A0),D0
            _StripAddress
            movea.l D0,A0
            movea.l A5,A1
            adda.w  CurJTOffset,A1
            adda.w  (A0),A1
            cmpi.w  #$4EF9,(2,A1)
            beq.b   .L4
            move.w  (2,A0),D0
            beq.b   .L4
            move.w  ($18,SP),D1
            moveq   #0,D2
            bsr.l   LoadSegPatch
            bra.b   .L4
            ds.b    12
.L4:
            movea.l ($14,SP),A1
            subq.l  #6,A1
            move.l  A1,($16,SP)
            movem.l (SP)+,D0-D2/A0-A1
            addq.w  #2,SP
            tst.b   LoadTrap
            beq.b   .L5
            _Debugger
.L5:
            rts
.L6:
            moveq   #$F,D0
            _SysError
            _Debugger
LoadCode:
            st      ResLoad
            subq.w  #4,SP
            move.l  #'CODE',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,D0
            rts
UnloadSeg:
            bra.l   UnloadSegPatch
            ds.b    66
AppZoneAddr:
            _StripAddress
            move.l  ApplZone,-(SP)
            move.l  SysZone,-(SP)
            cmpm.l  (SP)+,(SP)+
            beq.b   .L1
            cmp.l   ApplZone,D0
            bcs.b   .L1
            cmp.l   BufPtr,D0
            bcc.b   .L1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
FlushApplVBLs:
            movea.l ($162).w,A1
.L1:
            move.l  A1,D0
            beq.b   .L2
            movea.l A1,A0
            movea.l (A0),A1
            move.l  (6,A0),D0
            bsr.b   AppZoneAddr
            bne.b   .L1
            _VRemove
            bra.b   .L1
.L2:
            rts
.L3:
            move.l  MemTop,D0
            subi.l  #$5F00,D0
            bra.w   Launch.L9
Chain:
            clr.w   LaunchFlag
            bra.b   Launch.L3
Launch:
            st      LaunchFlag
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$32,SP
            move.w  #$FFFF,($1A,SP)
            movea.l UTableBase,A1
            move.w  UnitNtryCnt,D1
.L1:
            move.l  (A1)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            btst    #4,(4,A0)
            beq.b   .L2
            move.w  ($18,A0),($18,SP)
            movea.l SP,A0
            _Control
.L2:
            subq.w  #1,D1
            bne.b   .L1
            lea     ($32,SP),SP
            movem.l (SP)+,D0-D1/A0-A1
.L3:
            movea.l A0,A3
            movea.l (A3)+,A0
            move.w  (A3)+,CurPageOption
            lea     ($910).w,A1
            moveq   #$20,D0
            _BlockMove
            moveq   #0,D3
            cmpi.w  #$4C43,(A3)+
            bne.b   .L4
            addq.w  #4,A3
            move.w  (A3)+,D3
.L4:
            move.w  CurApRefNum,D0
            ble.b   .L5
            move.w  D0,-(SP)
            _CloseResFile
            clr.w   CurApRefNum
.L5:
            movea.l BufPtr,SP
            clr.l   StkLowPt
            tst.w   LaunchFlag
            beq.b   .L7
            move.l  ScrapHandle,D0
            ble.b   .L6
            movea.l D0,A0
            _GetHandleSize
            addq.l  #1,D0
            bclr    #0,D0
            suba.l  D0,SP
            movea.l SP,A1
            movea.l (A0),A0
            move.l  D0,-(SP)
            _BlockMove
.L6:
            _InitApplZone
            tst.l   ScrapHandle
            ble.b   .L7
            move.l  (SP)+,D1
            move.l  D1,D0
            _NewHandle
            move.l  A0,ScrapHandle
            move.l  D1,D0
            movea.l (A0),A1
            movea.l SP,A0
            _BlockMove
            adda.l  D1,SP
.L7:
            subq.w  #2,SP
            pea     ($910).w
            moveq   #0,D0
            btst    #6,D3
            beq.b   .L8
            moveq   #1,D0
.L8:
            move.b  D0,RMGRPerm
            _OpenResFile
            move.w  (SP)+,CurApRefNum
            ble.w   BadOpen
            moveq   #0,D0
            bsr.w   LoadCode
            beq.w   BadOpen
            move.l  A0,SaveSegHandle
            movea.l (A0),A0
            tst.w   CurPageOption
            beq.b   .L10
            bpl.w   FlushApplVBLs.L3
            move.l  MemTop,D0
            subi.l  #$D900,D0
.L9:
            cmp.l   SP,D0
            bge.b   .L10
            movea.l D0,SP
.L10:
            movea.l ($7E0).w,A3
            jmp     (A3)
vSegStack:
            suba.l  (A0)+,SP
            move.l  SP,D0
            andi.w  #$FFFC,D0
            movea.l D0,SP
            movea.l SP,A5
            suba.l  (A0)+,SP
            move.l  A5,CurrentA5
            move.l  SP,CurStackBase
            move.l  SP,StkLowPt
            move.l  (A0)+,D0
            movea.l (A0)+,A1
            move.w  A1,CurJTOffset
            adda.l  A5,A1
            lea     (2,A1),A3
            _BlockMove
            move.l  SaveSegHandle,-(SP)
            _ReleaseResource
            lea     (8,A5),A0
            clr.l   (A0)+
            clr.l   (A0)+
            move.l  ($AEC).w,(A0)+
            clr.w   (A0)+
            movea.l SP,A0
            suba.l  DefltStack,A0
            _SetApplLimit
            movea.l ($6F0).w,A0
            jsr     (A0)
            jsr     (A3)
ExitToShell:
            moveq   #$C,D0
            _PaletteDispatch
            suba.l  A0,A0
            _SetGrowZone
            subq.w  #4,SP
            _LoadScrap
            addq.w  #4,SP
            moveq   #$1F,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            movea.l SP,A0
            move.w  BootDrive,($16,A0)
            _SetVol
            lea     ($40,SP),SP
            lea     LoaderPBlock,A0
            movea.l A0,A1
            pea     ($2E0).w
            move.l  (SP)+,(A1)+
            clr.l   (A1)+
            _Launch
BadOpen:
            moveq   #$1A,D0
            _SysError
            _Debugger
vLaunchInit:
            btst    #$C,HWCfgFlags
            beq.b   .L1
            clr.l   -(SP)
            frestore (SP)+
.L1:
            moveq   #0,D7
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            moveq   #0,D3
            moveq   #0,D2
            moveq   #0,D1
            moveq   #0,D0
            movea.l ROMBase,A2
            adda.l  #$10000,A2
            movea.l A2,A1
            movea.l A2,A0
            move.l  A2,ResetStackPtr
            clr.l   (A5)
            rts
GetAppParms:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  ($10,A5),(A1)
            movea.l (SP)+,A1
            move.w  CurApRefNum,(A1)
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            lea     ($910).w,A0
            moveq   #$20,D0
            _BlockMove
            rts
InstallRDrivers:
            movem.l D0-D4/A0-A3,-(SP)
            movea.l UTableBase,A3
            move.w  UnitNtryCnt,D3
            moveq   #-1,D4
.L1:
            move.l  (A3)+,D0
            beq.b   .L5
            movea.l D0,A1
            move.l  (A1),D0
            beq.b   .L5
            movea.l D0,A1
            btst    #6,(5,A1)
            beq.b   .L5
            move.l  (A1),D0
            beq.b   .L5
            move.l  ($14,A1),D1
            bsr.w   AppZoneAddr
            bne.b   .L3
            moveq   #$33,D0
            movea.l A1,A0
.L2:
            clr.b   (A0)+
            dbra    D0,.L2
            bset    #6,(5,A1)
            move.w  D4,($18,A1)
.L3:
            clr.l   ($1E,A1)
            move.l  D1,D0
            bsr.w   AppZoneAddr
            bne.b   .L4
            moveq   #0,D1
.L4:
            move.l  D1,($14,A1)
.L5:
            subq.w  #1,D4
            subq.w  #1,D3
            bne.b   .L1
            movem.l (SP)+,D0-D4/A0-A3
            rts
SGLDREND:
            dc.w    0
SYSUTIL:
ASYNCPATCH:
            rts
ReadParam:
            lea     SPValid,A1
            bsr.b   XferPRam
            moveq   #0,D0
            rts
XferPRam:
            moveq   #$13,D2
.L1:
            lsr.l   #1,D0
            bcc.b   .L2
            move.b  (A1),(A0)+
.L2:
            addq.l  #1,A1
            dbra    D2,.L1
            rts
WriteParam:
            bsr.w   WritePram
            lea     Scratch20,A1
            bsr.w   ReadPram
            lea     SPValid,A0
            moveq   #-$57,D0
            moveq   #4,D2
.L1:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L2
            dbra    D2,.L1
            moveq   #0,D0
.L2:
            rts
ReadDateTime:
            bsr.w   ReadTime
            move.l  TimeLM,(A0)
            rts
SetDateTimeTrap:
            move.l  D0,TimeLM
            bra.w   WriteTime
Delay:
            move    #$2000,SR
            move.l  Ticks,D0
            add.l   A0,D0
.L1:
            cmp.l   Ticks,D0
            bgt.b   .L1
            rts
LWRSTRING:
            move.l  A2,-(SP)
            movem.l D0-D1/A0,-(SP)
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.w  #6,-(SP)
            _Pack6
            movea.l (SP)+,A2
            movem.l (SP)+,D0-D1/A0
            move.l  A2,D2
            beq.b   .L4
            movea.l (A2),A2
            btst    #0,(9,A2)
            beq.b   .L4
            movea.l A2,A1
            moveq   #0,D2
            move.w  ($E,A2),D2
            adda.l  D2,A1
            lsr.w   #8,D1
            andi.w  #6,D1
            move.w  sub_4080C100(PC,D1.w),D1
            move.w  (0,A2,D1.w),D2
            adda.l  D2,A2
            moveq   #0,D1
            bra.b   .L2
.L1:
            move.b  (A0),D1
            move.b  (0,A1,D1.w),D1
            move.b  (0,A2,D1.w),D1
            add.b   D1,(A0)+
.L2:
            dbra    D0,.L1
            moveq   #0,D0
.L3:
            movea.l (SP)+,A2
            rts
.L4:
            move.w  #$FF40,D0
            bra.b   .L3
sub_4080C100:
            ori.b   #$1A,(A2)
            ori.b   #$14,(A0)
uprstring:
            bsr.w   EntString
            bra.b   .L2
.L1:
            move.b  (A0),D2
            bsr.b   Canonizer
            move.b  D2,(A0)+
.L2:
            dbra    D0,.L1
            moveq   #0,D0
            bra.w   ExtString
CmpString:
            move.w  D0,D2
            swap    D0
            cmp.w   D0,D2
            bne.b   CSQuickNE
            swap    D0
            bsr.b   RelStringTrap
            bpl.b   .L1
            neg.l   D0
.L1:
            rts
CSQuickNE:
            moveq   #1,D0
            rts
RelStringTrap:
            bsr.b   EntString
            moveq   #0,D4
            move.w  D0,D2
            swap    D0
            cmp.w   D0,D2
            beq.b   ICLoopEntry
            bhi.b   .L1
            moveq   #1,D4
            move.w  D2,D0
            cmp.w   D4,D4
            bra.b   ICLoopEntry
.L1:
            moveq   #-1,D4
            cmp.w   D4,D4
            bra.b   ICLoopEntry
ICLoopTop:
            moveq   #0,D2
            move.b  (A0)+,D2
            bsr.b   Canonizer
            add.w   D2,D2
            move.w  (0,A3,D2.w),D3
            moveq   #0,D2
            move.b  (A1)+,D2
            bsr.b   Canonizer
            add.w   D2,D2
            cmp.w   (0,A3,D2.w),D3
ICLoopEntry:
            dbne    D0,ICLoopTop
            beq.b   ICEqual
            bhi.b   ICHigh
            moveq   #-1,D0
            bra.b   ICExit
ICHigh:
            moveq   #1,D4
ICEqual:
            move.l  D4,D0
ICExit:
            bra.b   ExtString
Canonizer:
            tst.w   D1
            bpl.b   dontStrip
            move.b  StripTab(PC,D2.w),D2
dontStrip:
            tst.b   D1
            bmi.b   dontUpper
            move.b  (0,A2,D2.w),D2
dontUpper:
            rts
EntString:
            move.l  (SP)+,D2
            movem.l D2-D4/A2-A3,-(SP)
            lea     UpperTab,A2
            lea     CmpTab,A3
            rol.w   #6,D1
            ror.b   #1,D1
            moveq   #0,D2
            rts
ExtString:
            movem.l (SP)+,D3-D4/A2-A3
            rts
StripTab:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$1819,$1A1B,$1C1D,$1E1F
            dc.b    $20,$21,$22
            dc.b    '#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_`abcdefghijklmnopqrstuvwxyz'
            dc.b    $7B,$7C,$7D,$7E,$7F
            dc.b    'AACENOUaaaaaaceeeeiiiinooooouuuu'
            dc.w    $A0A1,$A2A3,$A4A5,$A6A7,$A8A9,$AAAB,$ACAD,$AE4F
            dc.w    $B0B1,$B2B3,$B4B5,$B6B7,$B8B9,$BA61,$6FBD,$BE6F
            dc.w    $C0C1,$C2C3,$C4C5,$C6C7,$C8C9,$CA41,$414F,$CECF
            dc.w    $D0D1,$D2D3,$D4D5,$D6D7,$79D9,$DADB,$DCDD,$DEDF
            dc.w    $E0E1,$E2E3,$E4E5,$E6E7,$E8E9,$EAEB,$ECED,$EEEF
            dc.w    $F0F1,$F2F3,$F4F5,$F6F7,$F8F9,$FAFB,$FCFD,$FEFF
UpperTab:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$1819,$1A1B,$1C1D,$1E1F
            dc.b    $20,$21,$22
            dc.b    '#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_aABCDEFGHIJKLMNOPQRSTUVWXYZ'
            dc.b    $7B,$7C,$7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$CB,$89,$80
            dc.b    $CC,$81,$82,$83,$8F,$90,$91,$92,$93,$94,$95,$84,$97,$98,$99,$85
            dc.b    $CD,$9C,$9D,$9E,$86,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA
            dc.b    $AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA
            dc.b    $BB,$BC,$BD,$AE,$AF,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA
            dc.b    $CB,$CC,$CD,$CE,$CE,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA
            dc.b    $DB,$DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA
            dc.b    $EB,$EC,$ED,$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA
            dc.b    $FB,$FC,$FD,$FE,$FF
CmpTab:
            dc.w    0,$0100,$0200,$0300,$0400,$0500,$0600,$0700
            dc.w    $0800,$0900,$0A00,$0B00,$0C00,$0D00,$0E00,$0F00
            dc.w    $1000,$1100,$1200,$1300,$1400,$1500,$1600,$1700
            dc.w    $1800,$1900,$1A00,$1B00,$1C00,$1D00,$1E00,$1F00
            dc.w    $2000,$2100,$2200,$2300,$2400,$2500,$2600,$2700
            dc.w    $2800,$2900,$2A00,$2B00,$2C00,$2D00,$2E00,$2F00
            dc.w    $3000,$3100,$3200,$3300,$3400,$3500,$3600,$3700
            dc.w    $3800,$3900,$3A00,$3B00,$3C00,$3D00,$3E00,$3F00
            dc.w    $4000,$4100,$4200,$4300,$4400,$4500,$4600,$4700
            dc.w    $4800,$4900,$4A00,$4B00,$4C00,$4D00,$4E00,$4F00
            dc.w    $5000,$5100,$5200,$5300,$5400,$5500,$5600,$5700
            dc.w    $5800,$5900,$5A00,$5B00,$5C00,$5D00,$5E00,$5F00
            dc.w    $6100,$4180,$4280,$4380,$4480,$4580,$4680,$4780
            dc.w    $4880,$4980,$4A80,$4B80,$4C80,$4D80,$4E80,$4F80
            dc.w    $5080,$5180,$5280,$5380,$5480,$5580,$5680,$5780
            dc.w    $5880,$5980,$5A80,$7B00,$7C00,$7D00,$7E00,$7F00
            dc.w    $4108,$410C,$4310,$4502,$4E0A,$4F08,$5508,$4182
            dc.w    $4184,$4186,$4188,$418A,$418C,$4390,$4582,$4584
            dc.w    $4586,$4588,$4982,$4984,$4986,$4988,$4E8A,$4F82
            dc.w    $4F84,$4F86,$4F88,$4F8A,$5582,$5584,$5586,$5588
            dc.w    $A000,$A100,$A200,$A300,$A400,$A500,$A600,$5382
            dc.w    $A800,$A900,$AA00,$AB00,$AC00,$AD00,$4114,$4F0E
            dc.w    $B000,$B100,$B200,$B300,$B400,$B500,$B600,$B700
            dc.w    $B800,$B900,$BA00,$4192,$4F92,$BD00,$4194,$4F8E
            dc.w    $C000,$C100,$C200,$C300,$C400,$C500,$C600,$2206
            dc.w    $2208,$C900,$2000,$4104,$410A,$4F0A,$4F14,$4F94
            dc.w    $D000,$D100,$2202,$2204,$2702,$2704,$D600,$D700
            dc.w    $5988,$D900,$DA00,$DB00,$DC00,$DD00,$DE00,$DF00
            dc.w    $E000,$E100,$E200,$E300,$E400,$E500,$E600,$E700
            dc.w    $E800,$E900,$EA00,$EB00,$EC00,$ED00,$EE00,$EF00
            dc.w    $F000,$F100,$F200,$F300,$F400,$F500,$F600,$F700
            dc.w    $F800,$F900,$FA00,$FB00,$FC00,$FD00,$FE00,$FF00
; ReadPram
ReadPram:
            BigJmp  ReadPRamPatch,A0
READPRAMPATCHRTN:
            moveq   #-$5F,D1
            moveq   #3,D5
            bsr.b   sub_4080C5BE
            movem.l (SP)+,D1-D2/D5/A0-A1
            rts
sub_4080C5BE:
            jsr     ClkRW
            move.b  D2,(A1)+
            addq.b  #4,D1
            dbra    D5,sub_4080C5BE
            rts
; InitUtil
InitUtil:
            clr.w   -(SP)
            bsr.w   WPOFF
            moveq   #$31,D1
            clr.b   D2
            jsr     ClkRW
            bsr.w   WPON
            lea     SPValid,A1
            bsr.b   ReadPram
            bsr.w   ReadTime
            moveq   #0,D0
            cmpi.b  #$A8,(A1)
            beq.b   .L2
            move.w  #$FFA8,(SP)
            moveq   #4,D1
            lea     PRAMInit,A0
.L1:
            move.l  (A0)+,(A1)+
            dbra    D1,.L1
            bsr.w   WritePram
.L2:
            btst    #6,HWCfgFlags
            beq.b   .L5
            lea     Scratch20,A0
            move.l  #$4000C,D0
            _ReadXPRam
            move.l  #'NuMc',D1
            cmp.l   (A0),D1
            beq.b   .L5
            move.w  #$FFA8,(SP)
            move.l  D1,(A0)
            move.l  #$4000C,D0
            _WriteXPRam
            moveq   #$20,D1
.L3:
            moveq   #4,D0
            swap    D0
            move.w  D1,D0
            clr.l   (A0)
            _WriteXPRam
            addq.b  #4,D1
            cmpi.b  #8,D1
            bne.b   .L3
            movem.l A1,-(SP)
            lea     PRAMInitTbl,A0
            lea     Scratch20,A1
            moveq   #4,D0
.L4:
            move.l  (A0)+,(A1)+
            dbra    D0,.L4
            move.l  #$140076,D0
            lea     Scratch20,A0
            _WriteXPRam
            movem.l (SP)+,A1
.L5:
            move.w  (SP)+,D0
            bne.b   .L6
            bset    #5,HWCfgFlags
.L6:
            ext.l   D0
            rts
PRAMInit:
            dc.b    $A8,
            dc.b    0
            dc.b    0
            dc.w    $CC0A,$CC0A
            ds.b    5
            dc.b    $02,$63,$00,$13,$88,$00,$4C
PRAMInitTbl:
            dc.w    $0001,$FFFF,$FFDF
            ds.b    14
ReadTime:
            movem.l D1-D2/D4-D5/A0/A2-A3,-(SP)
            BigJmp  ReadTimePatch,A0                ; Overpatched: rest of the read loop zeroed
            ds.b    24
            ; Unreachable tail of the original ReadTime (same as ReadTimePatch .L4)
            moveq   #-$55,D0
            move.l  Scratch20,TimeLM
.NoEntry:
            movem.l (SP)+,D1-D2/D4-D5/A0/A2-A3
            tst.w   D0
            rts
WriteTime:
            BigJmp  WRITETIMEPATCH,A0
WriteTimePatchRtn:
            moveq   #1,D5
.L1:
            move.l  D3,D2
            moveq   #1,D1
            moveq   #3,D4
.L2:
            jsr     ClkRW
            addq.b  #4,D1
            lsr.l   #8,D2
            dbra    D4,.L2
            bsr.b   ReadTime
            bne.b   .L3
            cmp.l   TimeLM,D3
            dbeq    D5,.L1
            beq.b   .L3
            moveq   #-$56,D0
.L3:
            bsr.b   WPON
            movem.l (SP)+,D1-D5/A0
            rts
WPON:
            moveq   #$35,D1
            moveq   #-$2B,D2
            jmp     ClkRW
WPOFF:
            moveq   #$35,D1
            moveq   #$55,D2
            jmp     ClkRW
WritePram:
            BigJmp  WritePRamPatch,A1
WRITEPRAMPATCHRTN:
            move.b  #$41,D1
            moveq   #$F,D3
            bsr.b   sub_4080C73C
            move.b  #$21,D1
            moveq   #3,D3
            bsr.b   sub_4080C73C
            bsr.b   WPON
            movem.l (SP)+,D1-D3/A1-A2
            rts
sub_4080C73C:
            move.b  (A2)+,D2
            jsr     ClkRW
            addq.b  #4,D1
            dbra    D3,sub_4080C73C
            rts
            ds.b    6
SYSENVIRONS:
            movem.l D2/A0,-(SP)
            movea.l A0,A2
            move.w  #$EA83,D2
            tst.w   D0
            ble.w   .L14
            clr.w   D2
            move.w  D0,D1
            cmpi.w  #2,D0
            ble.b   .L1
            move.w  #$EA82,D2
            move.w  #$10,D0
            bra.b   .L2
.L1:
            move.w  #$10,D0
.L2:
            asr.w   #1,D0
            subq.w  #1,D0
.L3:
            clr.w   (A0)+
            dbra    D0,.L3
            move.w  D1,(A2)
            move.l  #'mach',D0
            _Gestalt
            tst.w   D0
            beq.b   .L4
            suba.l  A0,A0
            bra.b   .L5
.L4:
            subq.w  #2,A0
.L5:
            move.w  A0,(2,A2)
            move.l  #'sysv',D0
            _Gestalt
            tst.w   D0
            beq.b   .L6
            suba.l  A0,A0
.L6:
            move.w  A0,(4,A2)
            move.l  #'proc',D0
            _Gestalt
            tst.w   D0
            beq.b   .L7
            suba.l  A0,A0
.L7:
            move.w  A0,(6,A2)
            move.l  #'fpu ',D0
            _Gestalt
            tst.w   D0
            bne.b   .L8
            move.l  A0,D0
            beq.b   .L8
            move.b  #1,(8,A2)
.L8:
            move.l  #$71642020,D0
            _Gestalt
            tst.w   D0
            bne.b   .L9
            move.l  A0,D0
            beq.b   .L9
            move.b  #1,(9,A2)
.L9:
            move.l  #'kbd ',D0
            _Gestalt
            tst.w   D0
            beq.b   .L10
            suba.l  A0,A0
.L10:
            move.w  A0,($A,A2)
            move.l  #'atlk',D0
            _Gestalt
            tst.w   D0
            beq.b   .L11
            suba.l  A0,A0
.L11:
            move.w  A0,($C,A2)
            moveq   #0,D0
            move.w  #$3C,D1
.L12:
            clr.w   -(SP)
            dbra    D1,.L12
            movea.l SP,A0
            move.w  SysMap,($18,A0)
            moveq   #8,D0
            _HFSDispatch
            bne.b   .L13
            move.w  ($34,A0),($16,A0)
            _HGetVInfo
            bne.b   .L13
            move.l  ($5A,A0),($30,A0)
            move.l  #'ERIK',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            bne.b   .L13
            move.w  ($16,A0),($E,A2)
.L13:
            lea     ($7A,SP),SP
.L14:
            move.w  D2,D0
            movem.l (SP)+,D2/A0
            rts
            ds.b    8
INITRELIABILITY:
            subq.w  #4,SP
            move.l  TimeLM,D1
            subi.l  #$9FE31A80,D1
            bcs.b   .L1
            movea.l SP,A0
            move.l  #$400B8,D0
            _ReadXPRam
            move.l  (SP),D0
            andi.l  #$7FF80000,D0
            bne.b   .L1
            lsr.l   #8,D1
            divu.w  #$2A3,D1
            moveq   #$13,D0
            lsl.l   D0,D1
            andi.l  #$7FF80000,D1
            andi.l  #$8007FFFF,(SP)
            or.l    D1,(SP)
            move.l  #$400B8,D0
            _WriteXPRam
.L1:
            addq.w  #4,SP
            moveq   #$18,D0
            move.b  D0,D1
            _NewPtrSysClear
            bne.b   .L2
            movea.l ExpandMem,A1
            move.l  A0,($84,A1)
            move.b  D1,(1,A0)
            move.b  #1,(A0)
            bclr    #7,UnSwitchedFlags
            lea     (2,A0),A0
            lea     RELTIMETASK,A1
            move.l  A1,(6,A0)
            _InsXTime
            move.l  #$493E0,D0
            clr.l   ($E,A0)
            _PrimeTime
.L2:
            rts
            dc.w    0
RELTIMETASK:
            subq.w  #4,SP
            movea.l SP,A0
            move.l  #$400B8,D0
            _ReadXPRam
            move.l  (SP),D0
            move.l  D0,D1
            andi.l  #$7FFFF,D0
            addq.l  #1,D0
            andi.l  #$7FFFF,D0
            andi.l  #$FFF80000,D1
            or.l    D0,D1
            move.l  D1,(A0)
            move.l  #$400B8,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l A1,A0
            move.l  #$493E0,D0
            _PrimeTime
            rts
            dc.w    0
BLOCKMOVES:
            move.l  (A0)+,(A1)+
.L29:
            move.l  (A0)+,(A1)+
.L25:
            move.l  (A0)+,(A1)+
.L21:
            move.l  (A0)+,(A1)+
.L17:
            move.l  (A0)+,(A1)+
.L13:
            move.l  (A0)+,(A1)+
.L9:
            move.l  (A0)+,(A1)+
.L5:
            move.w  (A0)+,(A1)+
            moveq   #0,D0
            rts
            bra.b   .L3
            bra.b   .L4
            bra.b   .L5
            bra.b   .L6
            bra.b   .L7
            bra.b   .L8
            bra.b   .L9
            bra.b   .L10
            bra.b   .L11
            bra.b   .L12
            bra.b   .L13
            bra.b   .L14
            bra.b   .L15
            bra.b   .L16
            bra.b   .L17
            bra.b   .L18
            bra.b   .L19
            bra.b   .L20
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            bra.b   .L27
            bra.b   .L28
            bra.b   .L29
            bra.b   .L1
            bra.b   .L30
            bra.b   .L31
            bra.b   BLOCKMOVES
            move.l  (A0)+,(A1)+
.L1:
            move.l  (A0)+,(A1)+
.L26:
            move.l  (A0)+,(A1)+
.L22:
            move.l  (A0)+,(A1)+
.L18:
            move.l  (A0)+,(A1)+
.L14:
            move.l  (A0)+,(A1)+
.L10:
            move.l  (A0)+,(A1)+
.L6:
            move.w  (A0)+,(A1)+
.L4:
            move.b  (A0)+,(A1)+
            moveq   #0,D0
            rts
.L30:
            move.l  (A0)+,(A1)+
.L27:
            move.l  (A0)+,(A1)+
.L23:
            move.l  (A0)+,(A1)+
.L19:
            move.l  (A0)+,(A1)+
.L15:
            move.l  (A0)+,(A1)+
.L11:
            move.l  (A0)+,(A1)+
.L7:
            move.l  (A0)+,(A1)+
.L3:
            moveq   #0,D0
            rts
.L31:
            move.l  (A0)+,(A1)+
.L28:
            move.l  (A0)+,(A1)+
.L24:
            move.l  (A0)+,(A1)+
.L20:
            move.l  (A0)+,(A1)+
.L16:
            move.l  (A0)+,(A1)+
.L12:
            move.l  (A0)+,(A1)+
.L8:
            move.l  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
            moveq   #0,D0
            rts
            dc.w    0
.L2:
            move.l  ($6F4).w,-(SP)
            move.l  A1,D1
            moveq   #-4,D2
            or.l    D1,D2
            sub.l   A0,D1
            and.l   Lo3Bytes,D1
            cmp.l   D0,D1
            bcs.b   BMOVERLAP
BMMOVELONGS:
            jmp     .L1(PC,D2.w*2)
            bra.b   .L2
            move.b  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
.L1:
            add.l   D2,D0
.L2:
            moveq   #$20,D2
            sub.l   D2,D0
            bge.b   BMEXIT16.L1
BMEXIT16:
            jmp     BLOCKMOVES.L1(PC,D0.w*2)
.L1:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            sub.l   D2,D0
            bge.b   .L1
            jmp     BLOCKMOVES.L1(PC,D0.w*2)
BMOVERLAP:
            cmp.l   Lo3Bytes,D0
            bhi.b   .L2
            cmpa.l  A0,A1
.L1:
            adda.l  D0,A0
            adda.l  D0,A1
            bne.w   BMVERYSHORT.L7
            moveq   #0,D0
            rts
.L2:
            cmpa.l  A0,A1
            bcc.b   .L1
            jmp     BMMOVELONGS.L1(PC,D2.w*2)
BlockMove68020:
BlockMove:
            moveq   #-$C,D1
            add.l   D0,D1
            bgt.b   BLOCKMOVES.L2
BMVERYSHORT:
            tst.l   D0
            ble.b   .L3
            lsl.w   #3,D0
            addq.l  #4,D1
            ble.b   .L4
            addq.l  #8,A0
            bfextu  (A0){0:D0},D2
            move.l  -(A0),D1
            move.l  -(A0),(A1)+
.L1:
            move.l  D1,(A1)+
.L2:
            bfins   D2,(A1){0:D0}
.L3:
            moveq   #0,D0
            rts
.L4:
            addq.l  #4,D1
            ble.b   .L5
            move.l  (A0)+,D1
            bfextu  (A0){0:D0},D2
            bra.b   .L1
.L5:
            bfextu  (A0){0:D0},D2
            bra.b   .L2
.L40:
            move.l  -(A0),-(A1)
.L37:
            move.l  -(A0),-(A1)
.L33:
            move.l  -(A0),-(A1)
.L29:
            move.l  -(A0),-(A1)
.L25:
            move.l  -(A0),-(A1)
.L21:
            move.l  -(A0),-(A1)
.L17:
            move.l  -(A0),-(A1)
.L13:
            move.w  -(A0),-(A1)
            moveq   #0,D0
            rts
            bra.b   .L11
            bra.b   .L12
            bra.b   .L13
            bra.b   .L14
            bra.b   .L15
            bra.b   .L16
            bra.b   .L17
            bra.b   .L18
            bra.b   .L19
            bra.b   .L20
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            bra.b   .L27
            bra.b   .L28
            bra.b   .L29
            bra.b   .L30
            bra.b   .L31
            bra.b   .L32
            bra.b   .L33
            bra.b   .L34
            bra.b   .L35
            bra.b   .L36
            bra.b   .L37
            bra.b   .L6
            bra.b   .L38
            bra.b   .L39
            bra.b   .L40
            move.l  -(A0),-(A1)
.L6:
            move.l  -(A0),-(A1)
.L34:
            move.l  -(A0),-(A1)
.L30:
            move.l  -(A0),-(A1)
.L26:
            move.l  -(A0),-(A1)
.L22:
            move.l  -(A0),-(A1)
.L18:
            move.l  -(A0),-(A1)
.L14:
            move.w  -(A0),-(A1)
.L12:
            move.b  -(A0),-(A1)
            moveq   #0,D0
            rts
.L38:
            move.l  -(A0),-(A1)
.L35:
            move.l  -(A0),-(A1)
.L31:
            move.l  -(A0),-(A1)
.L27:
            move.l  -(A0),-(A1)
.L23:
            move.l  -(A0),-(A1)
.L19:
            move.l  -(A0),-(A1)
.L15:
            move.l  -(A0),-(A1)
.L11:
            moveq   #0,D0
            rts
.L39:
            move.l  -(A0),-(A1)
.L36:
            move.l  -(A0),-(A1)
.L32:
            move.l  -(A0),-(A1)
.L28:
            move.l  -(A0),-(A1)
.L24:
            move.l  -(A0),-(A1)
.L20:
            move.l  -(A0),-(A1)
.L16:
            move.l  -(A0),-(A1)
            move.b  -(A0),-(A1)
            moveq   #0,D0
            rts
            ds.b    12
.L7:
            move.l  A1,D1
            moveq   #3,D2
            and.l   D1,D2
            beq.b   .L9
            neg.l   D2
            jmp     .L8(PC,D2.w*2)
            move.b  -(A0),-(A1)
            move.b  -(A0),-(A1)
            move.b  -(A0),-(A1)
.L8:
            add.l   D2,D0
.L9:
            moveq   #$20,D2
            sub.l   D2,D0
            bge.b   .L10
            jmp     .L6(PC,D0.w*2)
.L10:
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            sub.l   D2,D0
            bge.b   .L10
            jmp     .L6(PC,D0.w*2)
            ds.b    8
Heap:
            dc.w    0,$CD06,0,$CD2C,0,$CD5E,0,$CD5E
            dc.w    0,$CF14,0,$CFBA,0,$D074,0,$D074
            dc.w    0,$D086,0,$D086,0,$D0B4,0,$D0E6
            dc.w    0,$D164,0,$D16A,0,$D0B8,0,$D0EA
            dc.w    0,$D126,0,$D13C,0,$D180,0,$D180
            dc.w    0,$D196,0,$D1B2,0,$D1DE,0,$D20A
            dc.w    0,$D24A,0,$D24A,0,$D260,0,$D294
            dc.w    0,$D2CA,0,$D2CA,0,$D2E8,0,$D320
            dc.w    0,$D36C,0,$D384,0,$D3AC,0,$D3BA
            dc.w    0,$D3D8,0,$D3DE,0,$D3F0,0,$D3F6
            dc.w    0,$D408,0,$D408,0,$D454,0,$D464
            dc.w    0,$D42E,0,$D436,0,$D490,0,$D496
            dc.w    0,$D4C0,0,$D4C8,0,$D4DC,0,$D4E4
            dc.w    0,$D4FE,0,$D4FE,0,$D510,0,$D53A
            dc.w    0,$D580,0,$D58C,0,$D5A6,0,$D5E4
            dc.w    0,$D634,0,$D640,0,$D65A,0,$D666
            dc.w    0,$D67C,0,$D684,0,$D69A,0,$D6A2
            dc.w    0,$D6C2,0,$D6CA,0,$D6E0,0,$D6E8
            dc.w    0,$D6FE,0,$D706,0,$D724,0,$D72A
            dc.w    0,$D740,0,$D752,0,$D77E,0,$D8DE
InitMemVect:
            movem.l D0-D1/A0-A2,-(SP)
            lea     MMFlags,A0
            move.l  #$1008A,D0
            _ReadXPRam
            btst    #0,MMFlags
            beq.b   .L1
            bclr    #0,($B73).w
.L1:
            btst    #2,MMFlags
            beq.b   .L2
            bclr    #1,($B73).w
.L2:
            move.l  ROMBase,D0
            lea     Heap,A0
            lea     ($1E00).w,A1
            lea     ($1F00).w,A2
            moveq   #$27,D1
.L3:
            move.l  (A0)+,(A1)
            add.l   D0,(A1)+
            move.l  (A0)+,(A2)
            add.l   D0,(A2)+
            dbra    D1,.L3
            addi.l  #$10000,D0
            move.l  D0,ResetStackPtr
            move.l  D0,ResetVector
            lea     MMNoPrologue,A0
            move.l  A0,($1EE0).w
            lea     MMPPrologue,A0
            move.l  A0,($1EE4).w
            lea     MMPrologue,A0
            move.l  A0,($1EE8).w
            lea     MMHPrologue,A0
            move.l  A0,($1EEC).w
            lea     MMRHPrologue,A0
            move.l  A0,vMMRHPrologue
            lea     MMMMPrologue,A0
            move.l  A0,vMMMMPrologue
            lea     MMEpilogue,A0
            move.l  A0,vMMEpilogue
            lea     MMNoErrEpilogue,A0
            move.l  A0,vMMNoErrEpilogue
            movem.l (SP)+,D0-D1/A0-A2
            rts
SetApplBase:
            clr.l   -(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            movem.l D3/A2-A6,-(SP)
            movea.l SysZone,A6
            move.l  A0,D0
            bsr.l   SETAPPLBASEPATCH
            movea.l D0,A0
            suba.w  #$C,A0
            cmpa.l  (A6),A0
            bls.b   .L1
            bsr.w   A24ZONEADJUSTEND
.L1:
            bsr.b   sub_4080CD84
            movem.l (SP)+,D3/A2-A6
            rts
            movem.l D3/A2-A6,-(SP)
            movea.l SysZone,A6
            move.l  A0,D0
            bsr.l   SETAPPLBASEPATCH
            movea.l D0,A0
            suba.w  #$10,A0
            cmpa.l  (A6),A0
            bls.b   .L2
            bsr.w   A32ZONEADJUSTEND
.L2:
            bsr.b   sub_4080CD84
            movem.l (SP)+,D3/A2-A6
            rts
InitApplZone:
            move.l  #4,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            movea.l ExpandMem,A0
            lea     ($18,A0),A0
            moveq   #3,D0
.L1:
            clr.l   (A0)+
            dbra    D0,.L1
            movea.l ($6E8).w,A0
            jsr     (A0)
            bsr.b   sub_4080CD84
            movea.l ($6EC).w,A0
            jsr     (A0)
            moveq   #0,D0
            move.w  D0,MemErr
            rts
sub_4080CD84:
            move.l  A6,-(SP)
            _RsrcZoneInit
            clr.l   ApplZone
            move.l  SP,D1
            sub.l   DefltStack,D1
            move.l  D1,ApplLimit
            move.l  D1,HiHeapMark
            movea.l SysZone,A6
            movea.l (A6),A0
            tst.b   ($1E,A6)
            bne.b   .L1
            lea     ($C,A0),A0
            bra.b   .L2
.L1:
            lea     ($10,A0),A0
.L2:
            movea.l A0,A1
            lea     ($1800,A1),A1
            cmpa.l  D1,A1
            bcs.b   .L3
            movea.l D1,A1
.L3:
            clr.l   -(SP)
            move.w  #$40,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            move.l  A0,ApplZone
            movea.l SP,A0
            _InitZone
            lea     ($E,SP),SP
            movea.l TheZone,A6
            move.l  (A6),HeapEnd
            moveq   #0,D0
            move.w  D0,MemErr
            movea.l (SP)+,A6
            rts
vIAZInit:
            move.l  IAZNotify,D0
            ble.b   .L1
            movea.l D0,A0
            jsr     (A0)
.L1:
            move.w  #$FFFF,GrafEnd
            st      FMExist
            clr.l   MenuList
            move.l  MinusOne,LastSPExtra
            st      SEvtEnb
            moveq   #$1F,D0
.L2:
            clr.w   -(SP)
            dbra    D0,.L2
            movea.l SP,A0
            move.l  ($358).w,D0
.L3:
            beq.b   .L5
            movea.l D0,A1
            move.w  ($48,A1),($16,A0)
            beq.b   .L4
            _FlushVol
.L4:
            move.l  (A1),D0
            bra.b   .L3
.L5:
            lea     ($40,SP),SP
            clr.l   DragHook
            clr.l   DeskHook
            lea     ($A88).w,A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.w   TaskLock
            clr.l   ResErrProc
            clr.l   EjectNotify
            movea.l ($6E0).w,A0
            jsr     (A0)
            bsr.w   FlushApplVBLs
            BigJsr  FlushApplNM,A0
            bsr.b   FlushApplPorts
            bsr.b   FlushPalettes
            movea.l MainDevice,A0
            move.l  A0,SrcDevice
            move.l  A0,TheGDevice
            move    #$2000,SR
            rts
FlushApplPorts:
            movea.l PortList,A1
            cmpa.l  MinusOne,A1
            beq.b   .L4
            movea.l (A1),A1
            movea.l A1,A0
            move.w  (A1)+,D1
            bra.b   .L2
.L1:
            move.l  (A1)+,D0
            bsr.w   AppZoneAddr
            beq.b   .L3
.L2:
            dbra    D1,.L1
            bra.b   .L4
.L3:
            subq.w  #1,(A0)
            move.l  -(A1),-(SP)
            clr.l   -(SP)
            move.l  PortList,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            pea     ($C,SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            pea     .L4
            clr.l   -(SP)
            _Munger
            addq.w  #8,SP
            bra.b   FlushApplPorts
.L4:
            rts
FlushPalettes:
            movem.l D3/A2-A3,-(SP)
            movea.l ($DC8).w,A2
            cmpa.l  MinusOne,A2
            beq.b   .L5
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HLock
            movea.l (A0),A3
            move.w  (8,A1),D3
            beq.b   .L4
            add.w   ($A,A1),D3
            bra.b   .L3
.L1:
            move.l  (A3),D1
            beq.b   .L2
            move.l  D1,D0
            bsr.w   AppZoneAddr
            bne.b   .L2
            move.l  D1,-(SP)
            _DisposePalette
.L2:
            addq.w  #8,A3
.L3:
            dbra    D3,.L1
.L4:
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HUnlock
.L5:
            movem.l (SP)+,D3/A2-A3
            rts
vIAZPostInit:
            _InitAllPacks
            clr.w   CurApRefNum
            _RDrvrInstall
            rts
InitZone:
            move.l  #8,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            movem.l A2-A3/A6,-(SP)
            movea.l A0,A1
            movea.l (A1)+,A6
            move.l  A6,TheZone
            movea.l A6,A0
            movea.l A6,A2
            moveq   #$C,D1
.L1:
            clr.l   (A0)+
            dbra    D1,.L1
            move.l  (A1)+,D1
            and.l   Lo3Bytes,D1
            bsr.l   ALIGN24TRAILER
            cmpa.l  HiHeapMark,A3
            blt.b   .L2
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            cmpa.l  D1,A3
            bgt.b   .L2
            move.l  A3,HiHeapMark
.L2:
            moveq   #$C,D1
            suba.l  D1,A3
            move.l  D1,(A3)
            move.l  A3,(A2)+
            move.l  A0,(A2)+
            addq.w  #4,A2
            suba.l  A0,A3
            move.l  A3,D0
            move.l  D0,(A2)+
            move.w  (A1)+,D1
            move.l  (A1)+,(A2)+
            lea     StdGZ,A1
            move.l  A1,($18,A2)
            move.w  D1,(A2)+
            move.w  MMDefFlags,(A2)+
            clr.b   ($1E,A6)
            move.l  #$1E00,($20,A6)
            bsr.w   a24MakeBkF
            bsr.w   A24HMAKEMOREMASTERS
            bsr.l   INIT24ZONEALIGN
            bra.b   .L3
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
.L3:
            movem.l (SP)+,A2-A3/A6
            moveq   #0,D0
            move.w  D0,MemErr
            rts
            movem.l A2-A3/A6,-(SP)
            movea.l A0,A1
            movea.l (A1)+,A6
            move.l  A6,TheZone
            movea.l A6,A0
            movea.l A6,A2
            moveq   #$C,D1
.L4:
            clr.l   (A0)+
            dbra    D1,.L4
            move.l  (A1)+,D1
            bsr.l   ALIGN32TRAILER
            cmpa.l  HiHeapMark,A3
            blt.b   .L5
            move.l  SP,D1
            cmpa.l  D1,A3
            bgt.b   .L5
            move.l  A3,HiHeapMark
.L5:
            moveq   #$10,D1
            suba.l  D1,A3
            clr.l   (A3)
            move.l  D1,(4,A3)
            move.l  A3,(A2)+
            move.l  A0,(A2)+
            addq.w  #4,A2
            suba.l  A0,A3
            move.l  A3,D0
            move.l  D0,(A2)+
            move.w  (A1)+,D1
            move.l  (A1)+,(A2)+
            lea     StdGZ,A1
            move.l  A1,($18,A2)
            move.w  D1,(A2)+
            move.w  MMDefFlags,(A2)+
            move.b  #1,($1E,A6)
            move.l  #$1F00,($20,A6)
            bsr.w   a32MakeBkF
            bsr.w   A32HMAKEMOREMASTERS
            bsr.l   INIT32ZONEALIGN
            bra.b   .L6
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
.L6:
            movem.l (SP)+,A2-A3/A6
.L7:
            moveq   #0,D0
            move.w  D0,MemErr
            rts
GetZone:
            move.l  #$C,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            movea.l TheZone,A0
            bra.b   InitZone.L7
SetZone:
            move.l  #$10,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            move.l  A0,TheZone
            bra.b   InitZone.L7
MaxBlock:
            pea     sub_4080D0A0
            move.l  RealMemTop,D0
            move.l  #$14,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
sub_4080D0A0:
            subq.l  #4,D0
            bge.b   .L1
            moveq   #0,D0
.L1:
            rts
CompactMem:
            move.l  #$1C,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            moveq   #1,D1
            bra.b   .L1
            moveq   #0,D1
.L1:
            bsr.w   A24ACTUALS
            lea     ($16,A6),A1
            move.b  (A1),D2
            tst.b   D1
            bne.b   .L2
            bset    #4,(A1)
            bra.b   .L3
.L2:
            bclr    #4,(A1)
.L3:
            bsr.l   V24CMGUTSPATCH
            move.l  D1,D0
            beq.w   PurgeMem.L4
            subq.l  #8,D0
            move.l  A0,D1
            beq.b   PurgeMem.L4
            bra.b   PurgeMem.L3
            moveq   #1,D1
            bra.b   .L4
            moveq   #0,D1
.L4:
            bsr.w   A32ACTUALS
            lea     ($16,A6),A1
            move.b  (A1),D2
            tst.b   D1
            bne.b   .L5
            bset    #4,(A1)
            bra.b   .L6
.L5:
            bclr    #4,(A1)
.L6:
            bsr.l   V32CMGUTSPATCH
            move.l  D1,D0
            beq.b   PurgeMem.L8
            subi.l  #$C,D0
            move.l  A0,D1
            beq.b   PurgeMem.L8
            bra.b   PurgeMem.L7
PurgeMem:
            move.l  #$20,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            bsr.w   A24ACTUALS
            bsr.w   a24PurgeHeap
.L1:
            move.l  A0,D0
            bne.b   .L2
            moveq   #-$6C,D0
            bra.b   .L4
.L2:
            moveq   #0,D0
.L3:
            addq.l  #8,A0
.L4:
            bra.b   .L8
            bsr.w   A32ACTUALS
            bsr.w   a32PurgeHeap
.L5:
            move.l  A0,D0
            bne.b   .L6
            moveq   #-$6C,D0
            bra.b   .L8
.L6:
            moveq   #0,D0
.L7:
            adda.w  #$C,A0
.L8:
            move.l  vMMEpilogue,-(SP)
            rts
PurgeSpace:
            move.l  #$18,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            bsr.w   A24TOTEPURGEABLES
            bra.b   .L1
            bsr.w   A32TOTEPURGEABLES
.L1:
            move.l  vMMEpilogue,-(SP)
            rts
FreeMem:
            move.l  #$24,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            move.l  ($C,A6),D0
            move.l  vMMEpilogue,-(SP)
            rts
ResrvMem:
            move.l  #$28,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            tst.l   (8,A6)
            bne.b   .L1
            move.w  ($14,A6),D2
            ext.l   D2
            asl.l   #2,D2
            addq.l  #8,D2
            add.l   D2,D0
.L1:
            bsr.w   A24MAKEPTRSPC
            movea.l A2,A0
            bra.w   PurgeMem.L1
            tst.l   (8,A6)
            bne.b   .L2
            move.w  ($14,A6),D2
            ext.l   D2
            asl.l   #2,D2
            addi.l  #$C,D2
            add.l   D2,D0
.L2:
            bsr.w   A32MAKEPTRSPC
            movea.l A2,A0
            bra.w   PurgeMem.L5
MaxMem:
            move.l  #$2C,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            move.l  RealMemTop,D0
            bsr.l   V24MAXMEMPATCH
            move.l  D1,D0
            beq.b   .L1
            subq.l  #8,D0
.L1:
            suba.l  A0,A0
            movea.l ApplZone,A1
            cmpa.l  TheZone,A1
            bne.b   .L2
            move.l  ApplLimit,D2
            bsr.w   A24MAXLIMIT
            sub.l   HeapEnd,D1
            movea.l D1,A0
.L2:
            bra.b   .L4
            move.l  RealMemTop,D0
            bsr.l   V32MAXMEMPATCH
            move.l  D1,D0
            beq.b   .L3
            subi.l  #$C,D0
.L3:
            suba.l  A0,A0
            movea.l ApplZone,A1
            cmpa.l  TheZone,A1
            bne.b   .L4
            move.l  ApplLimit,D2
            bsr.w   A32MAXLIMIT
            sub.l   HeapEnd,D1
            movea.l D1,A0
.L4:
            move.l  vMMEpilogue,-(SP)
            rts
SetGrowZone:
            move.l  #$30,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            movea.l TheZone,A1
            move.l  A0,($10,A1)
            bra.b   SetApplLimit.L2
SetApplLimit:
            move.l  #$34,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            move.l  A0,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            sub.l   DefltStack,D1
            cmp.l   D0,D1
            bgt.b   .L1
            movea.l D1,A0
.L1:
            move.l  A0,ApplLimit
            move.l  A0,HiHeapMark
            movea.l ApplZone,A1
            movea.l (A1),A1
            moveq   #-$6C,D0
            cmpa.l  A0,A1
            bhi.b   .L3
.L2:
            moveq   #0,D0
.L3:
            move.w  D0,MemErr
            rts
            move.l  A0,D0
            move.l  SP,D1
            sub.l   DefltStack,D1
            cmp.l   D0,D1
            bgt.b   .L4
            movea.l D1,A0
.L4:
            move.l  A0,ApplLimit
            move.l  A0,HiHeapMark
            movea.l ApplZone,A1
            movea.l (A1),A1
            moveq   #-$6C,D0
            cmpa.l  A0,A1
            bhi.b   .L5
            moveq   #0,D0
.L5:
            move.w  D0,MemErr
            rts
StackSpace:
            move.l  #$38,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            moveq   #$14,D0
            add.l   SP,D0
            andi.w  #$FFFC,D0
            sub.l   HiHeapMark,D0
            clr.w   MemErr
            rts
MaxApplZone:
            move.l  #$3C,-(SP)
            move.l  ($1EE0).w,-(SP)
            rts
            move.l  ApplLimit,D0
            bsr.l   V24MAXAPPLPATCH
            lea     HeapEnd,A1
            sub.l   (A1),D0
            moveq   #$C,D2
            cmp.l   D2,D0
            bcs.b   .L2
            movea.l (A1),A0
            move.l  D0,(A0)
            move.l  D1,(A1)
            movea.l D1,A0
            cmpa.l  HiHeapMark,A0
            bls.b   .L1
            move.l  A0,HiHeapMark
.L1:
            movea.l ApplZone,A1
            move.l  A0,(A1)
            move.l  D2,(A0)
            add.l   D0,($C,A1)
.L2:
            bra.w   SetApplLimit.L2
            move.l  ApplLimit,D0
            bsr.l   V32MAXAPPLPATCH
            lea     HeapEnd,A1
            sub.l   (A1),D0
            moveq   #$10,D2
            cmp.l   D2,D0
            bcs.b   .L4
            movea.l (A1),A0
            clr.l   (A0)
            move.l  D0,(4,A0)
            move.l  D1,(A1)
            movea.l D1,A0
            cmpa.l  HiHeapMark,A0
            bls.b   .L3
            move.l  A0,HiHeapMark
.L3:
            movea.l ApplZone,A1
            move.l  A0,(A1)
            clr.l   (A0)
            move.l  D2,(4,A0)
            add.l   D0,($C,A1)
.L4:
            bra.w   SetApplLimit.L2
NewPtr:
            move.l  #$40,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            suba.l  A1,A1
            bsr.w   A24MAKEPTRSPC
            bsr.w   a24AllocBk
            beq.b   .L2
            bsr.w   CheckClear
            moveq   #0,D0
.L1:
            bra.b   .L4
.L2:
            moveq   #-$6C,D0
            bra.b   .L1
            suba.l  A1,A1
            bsr.w   A32MAKEPTRSPC
            bsr.w   A32ALLOCBK
            beq.b   sub_4080D39C
            bsr.w   CheckClear
.L3:
            moveq   #0,D0
.L4:
            move.l  vMMEpilogue,-(SP)
            rts
sub_4080D39C:
            moveq   #-$6C,D0
            bra.b   NewPtr.L4
DisposePtr:
            move.l  #$44,-(SP)
            move.l  ($1EE4).w,-(SP)
            rts
DisposeTail24:
            btst    #0,($16,A6)
            bne.b   .L1
            bsr.w   a24FreeBk
            bra.b   NewPtr.L3
.L2:
            btst    #0,($16,A6)
            bne.b   .L1
            bsr.w   a32FreeBk
            bra.b   NewPtr.L3
.L1:
            moveq   #-$63,D0
            bra.b   NewPtr.L4
GetPtrSize:
            move.l  #$48,-(SP)
            move.l  ($1EE4).w,-(SP)
            rts
            bsr.w   a24GetSize
            bra.b   NewPtr.L4
            bsr.w   A32GETSIZE
            bra.b   NewPtr.L4
SetPtrSize:
            move.l  #$4C,-(SP)
            move.l  ($1EE4).w,-(SP)
            rts
            bsr.w   A24SETSIZE
            bra.b   NewPtr.L4
            bsr.w   A32SETSIZE
            bra.b   NewPtr.L4
PtrZone:
            move.l  #$50,-(SP)
            move.l  ($1EE4).w,-(SP)
            rts
            movea.l A6,A0
            bra.b   NewPtr.L3
CheckClear:
            btst    #9,D1
            beq.b   .L2
            move.l  A0,-(SP)
            addq.l  #1,D0
            lsr.l   #1,D0
.L1:
            clr.w   (A0)+
            subq.l  #1,D0
            bgt.b   .L1
            movea.l (SP)+,A0
.L2:
            rts
NewEmptyHandle:
            move.l  #$58,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            bsr.w   A24NEXTMASTER
            beq.b   NwHandle.L2
            bra.b   .L1
            bsr.w   A32NEXTMASTER
            beq.b   NwHandle.L2
.L1:
            movea.l A1,A0
            clr.l   (A0)
            moveq   #0,D0
            move.l  vMMEpilogue,-(SP)
            rts
NwHandle:
            move.l  #$54,-(SP)
            move.l  ($1EE8).w,-(SP)
            rts
            bsr.w   A24NEXTMASTER
            bne.b   .L1
            bra.b   .L2
.L1:
            bsr.w   a24AllocBk
            beq.b   .L7
            bra.b   .L4
            bsr.w   A32NEXTMASTER
            bne.b   .L3
.L2:
            moveq   #-$6C,D0
            bra.b   DsposeHandle.L3
.L3:
            bsr.w   A32ALLOCBK
            beq.b   .L7
.L4:
            bsr.b   CheckClear
            movea.l A1,A0
.L5:
            moveq   #0,D0
.L6:
            move.l  vMMEpilogue,-(SP)
            rts
.L7:
            moveq   #-$6C,D0
            bra.b   DsposeHandle.L2
DsposeHandle:
            move.l  #$5C,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            bne.w   DisposeTail24
            bra.b   .L1
            bne.w   DisposeTail24.L2
.L1:
            move.l  A1,D0
            beq.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            moveq   #0,D0
.L2:
            bsr.w   ReleaseMP
.L3:
            suba.l  A0,A0
            bra.b   NwHandle.L6
.L4:
            clr.l   (A1)
            bra.b   NwHandle.L5
GetHandleSize:
            move.l  #$60,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   SetHandleSize.L1
            bsr.w   a24GetSize
            bra.b   SetHandleSize.L2
            beq.b   SetHandleSize.L1
            bsr.w   A32GETSIZE
            bra.b   SetHandleSize.L2
SetHandleSize:
            move.l  #$64,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   .L1
            bsr.w   A24SETSIZE
            bra.b   .L2
            bne.b   .L3
.L1:
            moveq   #-$6D,D0
            bra.b   .L2
.L3:
            bsr.w   A32SETSIZE
.L2:
            movea.l A1,A0
            bra.b   NwHandle.L6
HandleZone:
            move.l  #$68,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            movea.l A6,A0
            bra.w   NwHandle.L5
RecoverHandle:
            move.l  #$6C,-(SP)
            move.l  vMMRHPrologue,-(SP)
            rts
            movea.l BusErrVct,A2
            lea     sub_4080D566,A3
            move.l  A3,BusErrVct
            movea.l (-4,A0),A1
            move.l  A2,BusErrVct
            adda.l  A6,A1
            move.l  (A1),D2
            and.l   Lo3Bytes,D2
            move.l  A0,D1
            and.l   Lo3Bytes,D1
            sub.l   D1,D2
            beq.b   .L1
            moveq   #-$73,D2
.L1:
            bra.b   .L2
            movea.l BusErrVct,A2
            lea     sub_4080D566,A3
            move.l  A3,BusErrVct
            movea.l (-4,A0),A1
            move.l  A2,BusErrVct
            adda.l  A6,A1
            move.l  (A1),D2
            move.l  A0,D1
            sub.l   D1,D2
            beq.b   .L2
            moveq   #-$73,D2
.L2:
            move.w  D2,MemErr
            movea.l A1,A0
            move.l  vMMNoErrEpilogue,-(SP)
            rts
sub_4080D566:
            andi.w  #$FEFF,($A,SP)
            move.l  ROMBase,($2C,SP)
            rte
EmptyHandle:
            move.l  #$70,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            bne.b   .L1
            moveq   #0,D0
            bra.b   .L3
.L1:
            bsr.w   a24EH
            bra.b   .L3
            bne.b   .L2
            moveq   #0,D0
            bra.b   .L3
.L2:
            bsr.w   a32EH
.L3:
            bra.w   SetHandleSize.L2
ReAllocHandle:
            move.l  #$74,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   .L1
            btst    #0,($16,A6)
            bne.b   .L2
            bsr.w   a24EH
            bne.w   SetHandleSize.L2
            move.l  D2,D0
.L1:
            move.l  A1,GZRootHnd
            clr.l   GZRootPtr
            bsr.w   a24AllocBk
            bsr.w   ClearGZStuff
            move.l  A0,D2
            bne.w   NwHandle.L4
            moveq   #-$6C,D0
            bra.w   SetHandleSize.L2
.L2:
            bsr.w   a24GetSize
            cmp.l   D0,D2
            bhi.b   .L5
            moveq   #-$63,D0
            bra.w   SetHandleSize.L2
            beq.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            bsr.w   a32EH
            bne.w   SetHandleSize.L2
            move.l  D2,D0
.L3:
            move.l  A1,GZRootHnd
            clr.l   GZRootPtr
            bsr.w   A32ALLOCBK
            bsr.w   ClearGZStuff
            move.l  A0,D2
            bne.w   NwHandle.L4
            moveq   #-$6C,D0
            bra.w   SetHandleSize.L2
.L4:
            bsr.w   A32GETSIZE
            cmp.l   D0,D2
            bhi.b   .L5
            moveq   #-$63,D0
            bra.w   SetHandleSize.L2
.L5:
            moveq   #-$63,D0
            bra.w   SetHandleSize.L2
HLock:
            move.l  #$78,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            bra.l   V24HLOCKPATCH
            nop
            bra.w   HNoPurge.L1
            bra.l   V32HLOCKPATCH
            ds.b    4
            bra.w   HNoPurge.L1
HUnlock:
            move.l  #$7C,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.w   HNoPurge.L2
            bclr    #7,(A1)
            bra.w   HNoPurge.L1
            beq.b   HNoPurge.L2
            bclr    #7,(-$B,A0)
            bra.b   HNoPurge.L1
HPurge:
            move.l  #$80,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   HNoPurge.L2
            bset    #6,(A1)
            bra.b   HNoPurge.L1
            beq.b   HNoPurge.L2
            bset    #6,(-$B,A0)
            bra.b   HNoPurge.L1
HNoPurge:
            move.l  #$84,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   .L2
            bclr    #6,(A1)
            bra.b   .L1
            beq.b   .L2
            bclr    #6,(-$B,A0)
.L1:
            moveq   #0,D0
            bra.b   .L3
.L2:
            moveq   #-$6D,D0
.L3:
            move.l  vMMEpilogue,-(SP)
            rts
HRSRC:
            move.l  #$88,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   HNoPurge.L2
            bset    #5,(A1)
            bra.b   HNoPurge.L1
            beq.b   HNoPurge.L2
            bset    #5,(-$B,A0)
            bra.b   HNoPurge.L1
HNoRSRC:
            move.l  #$8C,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   HNoPurge.L2
            bclr    #5,(A1)
            bra.b   HNoPurge.L1
            beq.b   HNoPurge.L2
            bclr    #5,(-$B,A0)
            bra.b   HNoPurge.L1
HGetFlags:
            move.l  #$90,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   HNoPurge.L2
            moveq   #0,D0
            move.b  (A1),D0
            bra.b   .L1
            beq.b   HNoPurge.L2
            moveq   #0,D0
            move.b  (-$B,A0),D0
.L1:
            clr.w   MemErr
            move.l  vMMNoErrEpilogue,-(SP)
            rts
HSetFlags:
            move.l  #$94,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            beq.b   HNoPurge.L2
            move.b  D0,(A1)
            bra.b   HNoPurge.L1
            beq.b   HNoPurge.L2
            move.b  D0,(-$B,A0)
            bra.w   HNoPurge.L1
MoreMasters:
            move.l  #$98,-(SP)
            move.l  vMMMMPrologue,-(SP)
            rts
            moveq   #0,D0
            bsr.w   A24HMAKEMOREMASTERS
            bne.b   .L1
            moveq   #-$6C,D0
.L1:
            movea.l (SP)+,A6
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bsr.w   A32HMAKEMOREMASTERS
            bne.b   .L2
            moveq   #-$6C,D0
.L2:
            movea.l (SP)+,A6
            move.w  D0,MemErr
            rts
StripAddress:
            btst    #0,MMFlags
            bne.b   .L1
            and.l   Lo3Bytes,D0
.L1:
            rts
MoveHHi:
            move.l  #$9C,-(SP)
            move.l  ($1EEC).w,-(SP)
            rts
            bne.b   .L2
            moveq   #-$6D,D0
.L1:
            bra.w   .L29
.L2:
            movea.l A1,A4
            tst.b   (A4)
            bpl.b   .L3
            moveq   #-$75,D0
            bra.b   .L1
.L3:
            movea.l (A6),A3
            subq.l  #8,A0
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            move.l  D1,D7
            subq.l  #8,D7
            moveq   #0,D0
            adda.l  D1,A0
            cmpa.l  A3,A0
            bcc.w   .L29
            tst.b   (A0)
            beq.b   .L4
            bpl.w   .L29
            movea.l (4,A0),A0
            adda.l  A6,A0
            tst.b   (A0)
            bmi.w   .L29
.L4:
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            sub.l   HiHeapMark,D1
            move.l  #$400,D2
            move.l  D2,D0
            add.l   D7,D0
            cmp.l   D0,D1
            blt.b   .L5
            move.l  D0,D1
.L5:
            moveq   #-1,D0
            cmp.l   D2,D1
            blt.w   .L29
            subi.l  #$80,D2
            sub.l   D2,D1
            suba.l  D1,SP
            suba.w  #$16,SP
            movea.l SP,A5
            move.l  D1,(8,A5)
            move.l  TheZone,($12,A5)
            move.l  A6,TheZone
            movea.l (A4),A0
            subq.w  #8,A0
            move.l  (A0),(A5)
            move.l  (A4),D0
            and.l   Lo3Bytes,D0
            move.l  D0,($C,A5)
            move.b  (A4),($10,A5)
            bsr.w   a24FindRgnTop
            tst.b   (A2)
            bne.b   .L8
            move.l  (A2),D1
            move.l  D1,D0
            subq.l  #8,D0
            cmp.l   D0,D7
            bhi.b   .L8
            sub.l   D7,D0
            beq.b   .L6
            moveq   #$C,D2
            cmp.l   D2,D0
            bcs.b   .L8
.L6:
            movea.l (A4),A0
            movea.l A2,A1
            adda.l  D1,A1
.L7:
            move.l  D7,D0
            suba.l  D0,A1
            sub.l   D0,($C,A6)
            _BlockMove
            movea.l A4,A0
            _EmptyHandle
            bra.b   .L13
.L8:
            moveq   #0,D6
            bsr.w   sub_4080DAC4
            bsr.w   sub_4080DB48
            bsr.w   a24FindRgnTop
.L9:
            move.l  (A2),D1
            move.l  (4,A5),D0
            lea     ($16,A5),A0
            movea.l A2,A1
            adda.l  D1,A1
            suba.l  D0,A1
            add.l   D0,D6
            sub.l   D0,($C,A6)
            _BlockMove
            tst.l   D7
            beq.b   .L13
            move.l  A1,D0
            sub.l   A2,D0
            beq.b   .L12
            move.l  D0,D1
            subq.l  #8,D1
            sub.l   D7,D1
            bcs.b   .L11
            beq.b   .L10
            moveq   #$C,D2
            cmp.l   D1,D2
            bcc.b   .L11
.L10:
            movea.l (A4),A0
            bra.b   .L7
.L11:
            move.l  D0,(A2)
.L12:
            movem.l (A1),D4-D5
            move.l  A6,(4,A1)
            move.l  D6,(A1)
            move.b  #$40,(A1)
            move.l  A1,-(SP)
            bsr.w   sub_4080DAC4
            bsr.w   sub_4080DB48
            bsr.w   a24FindRgnTop
            movea.l (SP)+,A1
            movem.l D4-D5,(A1)
            bra.b   .L9
.L13:
            subq.l  #8,A1
            subq.l  #8,($C,A6)
            move.l  A1,D0
            sub.l   A2,D0
            beq.b   .L14
            move.l  D0,(A2)
.L14:
            movea.l A1,A2
            move.l  (A5),(A2)+
            movea.l A4,A0
            suba.l  A6,A0
            move.l  A0,(A2)+
            move.l  A2,(A4)
            move.b  ($10,A5),(A4)
            move.l  ($12,A5),TheZone
            moveq   #0,D0
            adda.l  (8,A5),SP
            lea     ($16,SP),SP
            bra.w   .L29
            bne.b   .L16
            moveq   #-$6D,D0
.L15:
            bra.w   .L29
.L16:
            movea.l A1,A4
            tst.b   (-$B,A0)
            bpl.b   .L17
            moveq   #-$75,D0
            bra.b   .L15
.L17:
            movea.l (A6),A3
            suba.w  #$C,A0
            move.l  (4,A0),D1
            move.l  D1,D7
            subi.l  #$C,D7
            moveq   #0,D0
            adda.l  D1,A0
            cmpa.l  A3,A0
            bcc.w   .L29
            tst.b   (A0)
            beq.b   .L18
            bpl.w   .L29
            tst.b   (1,A0)
            bmi.w   .L29
.L18:
            move.l  SP,D1
            sub.l   HiHeapMark,D1
            move.l  #$400,D2
            move.l  D2,D0
            add.l   D7,D0
            cmp.l   D0,D1
            blt.b   .L19
            move.l  D0,D1
.L19:
            moveq   #-1,D0
            cmp.l   D2,D1
            blt.w   .L29
            subi.l  #$80,D2
            sub.l   D2,D1
            suba.l  D1,SP
            suba.w  #$18,SP
            movea.l SP,A5
            move.l  D1,($C,A5)
            move.l  TheZone,($14,A5)
            move.l  A6,TheZone
            movea.l (A4),A0
            suba.w  #$C,A0
            move.l  (A0),(A5)
            move.l  (A4),($10,A5)
            move.l  (4,A0),(4,A5)
            bsr.w   a32FindRgnTop
            tst.b   (A2)
            bne.b   .L22
            move.l  (4,A2),D1
            move.l  D1,D0
            subi.l  #$C,D0
            cmp.l   D0,D7
            bhi.b   .L22
            sub.l   D7,D0
            beq.b   .L20
            moveq   #$10,D2
            cmp.l   D2,D0
            bcs.b   .L22
.L20:
            movea.l (A4),A0
            movea.l A2,A1
            adda.l  D1,A1
.L21:
            move.l  D7,D0
            suba.l  D0,A1
            sub.l   D0,($C,A6)
            _BlockMove
            movea.l A4,A0
            _EmptyHandle
            bra.b   .L27
.L22:
            moveq   #0,D6
            bsr.w   a24FillStkBuf
            bsr.w   sub_4080DB48
            bsr.w   a32FindRgnTop
.L23:
            move.l  (4,A2),D1
            move.l  (8,A5),D0
            lea     ($18,A5),A0
            movea.l A2,A1
            adda.l  D1,A1
            suba.l  D0,A1
            add.l   D0,D6
            sub.l   D0,($C,A6)
            _BlockMove
            tst.l   D7
            beq.b   .L27
            move.l  A1,D0
            sub.l   A2,D0
            beq.b   .L26
            move.l  D0,D1
            subi.l  #$C,D1
            sub.l   D7,D1
            bcs.b   .L25
            beq.b   .L24
            moveq   #$10,D2
            cmp.l   D1,D2
            bcc.b   .L25
.L24:
            movea.l (A4),A0
            bra.b   .L21
.L25:
            clr.l   (A2)
            move.l  D0,(4,A2)
.L26:
            movem.l (A1),D3-D5
            move.l  A6,(8,A1)
            move.l  D6,(4,A1)
            move.b  #$40,(A1)
            move.l  A1,-(SP)
            bsr.w   a24FillStkBuf
            bsr.w   sub_4080DB48
            bsr.w   a32FindRgnTop
            movea.l (SP)+,A1
            movem.l D3-D5,(A1)
            bra.b   .L23
.L27:
            suba.w  #$C,A1
            subi.l  #$C,($C,A6)
            move.l  A1,D0
            sub.l   A2,D0
            beq.b   .L28
            clr.l   (A2)
            move.l  D0,(4,A2)
.L28:
            movea.l A1,A2
            move.l  (A5),(A2)+
            move.l  (4,A5),(A2)+
            movea.l A4,A0
            suba.l  A6,A0
            move.l  A0,(A2)+
            move.l  A2,(A4)
            move.l  ($14,A5),TheZone
            moveq   #0,D0
            adda.l  ($C,A5),SP
            lea     ($18,SP),SP
.L29:
            move.l  vMMEpilogue,-(SP)
            rts
a24FindRgnTop:
            move.l  (A4),D0
            beq.b   .L1
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            subq.w  #8,A0
            bra.b   .L2
.L1:
            lea     ($34,A6),A0
.L2:
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L4
            movea.l (4,A0),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L4
.L3:
            movea.l A0,A2
            adda.l  D1,A0
            cmpa.l  A3,A0
            bcs.b   .L2
            bra.b   .L5
.L4:
            cmpa.l  ($C,A5),A0
            bls.b   .L3
.L5:
            rts
a32FindRgnTop:
            move.l  (A4),D0
            beq.b   .L1
            movea.l D0,A0
            suba.w  #$C,A0
            bra.b   .L2
.L1:
            lea     ($34,A6),A0
.L2:
            move.l  (4,A0),D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L4
            tst.b   (1,A0)
            bmi.b   .L4
.L3:
            movea.l A0,A2
            adda.l  D1,A0
            cmpa.l  A3,A0
            bcs.b   .L2
            bra.b   .L5
.L4:
            cmpa.l  ($10,A5),A0
            bls.b   .L3
.L5:
            rts
sub_4080DAC4:
            move.l  (8,A5),D0
            cmp.l   D7,D0
            blt.b   .L1
            move.l  D7,D0
.L1:
            lea     ($16,A5),A1
            movea.l (A4),A0
            adda.l  D7,A0
            suba.l  D0,A0
            sub.l   D0,D7
            move.l  D0,(4,A5)
            move.l  D0,D1
            _BlockMove
            movea.l A4,A0
            move.l  D7,D0
            bne.b   .L2
            _EmptyHandle
            rts
.L2:
            movea.l (A0),A0
            subq.w  #8,A0
            move.b  (A0),D2
            addq.l  #8,D0
            move.l  D0,(A0)
            move.b  D2,(A0)
            adda.l  D0,A0
            move.l  D1,(A0)
            add.l   D1,($C,A6)
            rts
a24FillStkBuf:
            move.l  ($C,A5),D0
            cmp.l   D7,D0
            blt.b   .L1
            move.l  D7,D0
.L1:
            lea     ($18,A5),A1
            movea.l (A4),A0
            adda.l  D7,A0
            suba.l  D0,A0
            sub.l   D0,D7
            move.l  D0,(8,A5)
            move.l  D0,D1
            _BlockMove
            movea.l A4,A0
            move.l  D7,D0
            bne.b   .L2
            _EmptyHandle
            rts
.L2:
            movea.l (A0),A0
            suba.w  #$C,A0
            addi.l  #$C,D0
            move.l  D0,(4,A0)
            adda.l  D0,A0
            clr.l   (A0)
            move.l  D1,(4,A0)
            add.l   D1,($C,A6)
            rts
sub_4080DB48:
            move.l  RealMemTop,D0
            _CompactMem
            rts
HeapGuts:
ZCBUSERRHANDLER:
            andi.w  #$FEFF,($A,SP)
            clr.l   ($2C,SP)
            rte
DHBUSERRHANDLER:
            andi.w  #$FEFF,($A,SP)
            moveq   #-1,D0
            move.l  D0,($2C,SP)
            rte
sub_4080DB6A:
            bsr.l   DEREFHANDLEPATCH
            nop
            nop
            nop
            btst    #0,MMFlags
            bne.b   .L1
            move.l  A0,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            movea.l D0,A1
            beq.b   .L3
            bra.b   .L2
.L1:
            move.l  A0,D0
            movea.l D0,A1
            beq.b   .L3
.L2:
            movea.l (A1),A0
.L3:
            move.l  A2,BusErrVct
            move.l  A0,D0
            rts
sub_4080DB9C:
            btst    #0,MMFlags
            bne.b   .L5
            move.l  A0,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A0
            subq.l  #8,A0
            tst.b   (A0)
            beq.b   .L4
            bmi.b   .L1
            btst    #6,(A0)
            beq.b   .L4
            movea.l (4,A0),A6
            bra.b   .L2
.L1:
            movea.l A1,A6
            suba.l  (4,A0),A6
.L2:
            bsr.b   sub_4080DBF8
.L3:
            addq.l  #8,A0
            rts
.L4:
            moveq   #-$6F,D0
            bra.b   .L3
.L5:
            suba.w  #$C,A0
            tst.b   (A0)
            beq.b   .L9
            bmi.b   .L6
            btst    #6,(A0)
            beq.b   .L9
            movea.l (8,A0),A6
            bra.b   .L7
.L6:
            movea.l A1,A6
            suba.l  (8,A0),A6
.L7:
            bsr.b   sub_4080DBF8
.L8:
            adda.w  #$C,A0
            rts
.L9:
            moveq   #-$6F,D0
            bra.b   .L8
sub_4080DBF8:
            bsr.l   ZONECHECKPATCH
            nop
            nop
            nop
            btst    #0,MMFlags
            beq.b   .L1
            move.l  ($3C,A6),D0
            bra.b   .L2
.L1:
            move.l  A6,D0
            and.l   Lo3Bytes,D0
            movea.l D0,A6
            move.l  ($38,A6),D0
            and.l   Lo3Bytes,D0
.L2:
            move.l  A2,BusErrVct
            sub.l   A6,D0
            beq.b   .L3
            moveq   #-$71,D0
.L3:
            rts
MMPPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            suba.l  A1,A1
            bsr.w   sub_4080DB9C
            bmi.b   .L3
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L2
            move.l  #$1E00,D3
.L2:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L3:
            tst.w   (SP)+
            bne.w   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMHPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            bsr.w   sub_4080DB6A
            beq.b   .L4
            cmp.l   MinusOne,D0
            beq.b   .L7
            bsr.w   sub_4080DB9C
.L2:
            bmi.b   .L7
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L3
            move.l  #$1E00,D3
.L3:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            move.l  A0,D7
            rts
.L4:
            move.l  A1,D0
            beq.b   .L6
            cmpa.l  ApplZone,A6
            beq.b   .L5
            cmpa.l  SysZone,A6
            bne.b   .L6
            movea.l ApplZone,A6
.L5:
            cmp.l   A6,D0
            bhi.b   .L6
            movea.l SysZone,A6
.L6:
            bsr.w   sub_4080DBF8
            bra.b   .L2
.L7:
            tst.w   (SP)+
            bne.b   .L8
            movea.l A1,A0
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
.L8:
            bra.w   MMEpilogue.L1
MMNoPrologue:
            move.l  A0,-(SP)
            movea.l (4,SP),A0
            btst    #0,MMFlags
            bne.b   .L1
            adda.w  #$1E00,A0
            bra.b   .L2
.L1:
            adda.w  #$1F00,A0
.L2:
            move.l  (A0),(4,SP)
            movea.l (SP)+,A0
            rts
MMMMPrologue:
            movea.l (SP)+,A1
            move.l  A6,-(SP)
            movea.l TheZone,A6
            move.l  ($20,A6),D0
            bne.b   .L1
            move.l  #$1E00,D0
.L1:
            adda.l  D0,A1
            move.l  (A1),-(SP)
            rts
MMPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            btst    #$A,D1
            beq.b   .L2
            movea.l SysZone,A6
.L2:
            bsr.w   sub_4080DBF8
            bmi.b   .L4
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L3
            move.l  #$1E00,D3
.L3:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L4:
            tst.w   (SP)+
            bne.b   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMRHPrologue:
            movea.l (SP)+,A1
            movem.l D3-D7/A2-A6,-(SP)
            move.b  MMFlags,-(SP)
            movea.l A1,A4
            clr.w   -(SP)
            move.l  D0,D2
.L1:
            movea.l TheZone,A6
            btst    #$A,D1
            bne.b   .L2
            cmpa.l  SysZone,A6
            beq.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L5
.L2:
            movea.l SysZone,A6
.L3:
            move.l  A0,D0
            btst    #0,MMFlags
            bne.b   .L4
            and.l   Lo3Bytes,D0
.L4:
            cmp.l   ApplZone,D0
            bls.b   .L5
            movea.l ApplZone,A6
.L5:
            bsr.w   sub_4080DBF8
            bmi.b   .L7
            addq.l  #2,SP
            move.l  D2,D0
            move.l  ($20,A6),D3
            bne.b   .L6
            move.l  #$1E00,D3
.L6:
            adda.l  D3,A4
            move.l  (A4),-(SP)
            rts
.L7:
            tst.w   (SP)+
            bne.w   MMHPrologue.L8
            bchg    #0,MMFlags
            move.w  #1,-(SP)
            bra.b   .L1
MMEpilogue:
            clr.w   MemErr
            tst.l   D0
            bge.b   MMNoErrEpilogue
.L1:
            move.w  D0,MemErr
MMNoErrEpilogue:
            move.b  (SP)+,MMFlags
            movem.l (SP)+,D3-D7/A2-A6
            rts
a24MakeBkF:
            move.l  D0,(A0)
            clr.b   (A0)
            rts
a32MakeBkF:
            move.l  D0,(4,A0)
            clr.l   (A0)
            rts
sub_4080DDFC:
            movem.l D0/A1,-(SP)
            movea.l A0,A1
            adda.l  D0,A1
.L1:
            tst.b   (A1)
            bne.b   .L2
            cmpa.l  (A6),A1
            bcc.b   .L2
            add.l   (A1),D0
            adda.l  (A1),A1
            bra.b   .L1
.L2:
            move.l  D0,(A0)
            clr.b   (A0)
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/A1
            rts
sub_4080DE20:
            movem.l D0/A1,-(SP)
            movea.l A0,A1
            adda.l  D0,A1
.L1:
            tst.b   (A1)
            bne.b   .L2
            cmpa.l  (A6),A1
            bcc.b   .L2
            add.l   (4,A1),D0
            adda.l  (4,A1),A1
            bra.b   .L1
.L2:
            move.l  D0,(4,A0)
            clr.l   (A0)
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/A1
            rts
a24EH:
            btst    #7,(A1)
            bne.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            subq.l  #8,A0
            bsr.b   a24PurgeBlock
            addq.l  #8,A0
.L1:
            moveq   #0,D0
.L2:
            rts
.L3:
            moveq   #-$70,D0
            bra.b   .L2
.L4:
            clr.l   (A1)
            bra.b   .L1
a32EH:
            move.l  A2,-(SP)
            movea.l (A1),A2
            btst    #7,(-$B,A2)
            bne.b   .L3
            btst    #0,($16,A6)
            bne.b   .L4
            suba.w  #$C,A0
            bsr.b   a32PurgeBlock
            adda.w  #$C,A0
.L1:
            moveq   #0,D0
.L2:
            movea.l (SP)+,A2
            rts
.L3:
            moveq   #-$70,D0
            bra.b   .L2
.L4:
            clr.l   (A1)
            bra.b   .L1
CallPurgeProc:
            tst.l   ($28,A6)
            beq.b   .L1
            movem.l D0-D2/A0-A1,-(SP)
            move.l  A1,-(SP)
            movea.l ($28,A6),A1
            jsr     (A1)
            movem.l (SP)+,D0-D2/A0-A1
.L1:
            rts
a24PurgeBlock:
            move.l  D0,-(SP)
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            bsr.b   CallPurgeProc
            clr.l   (A1)
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
            move.l  (SP)+,D0
            rts
a32PurgeBlock:
            move.l  D0,-(SP)
            move.l  (4,A0),D0
            bsr.b   CallPurgeProc
            clr.l   (A1)
            bsr.w   a32MakeBkF
            bsr.w   AdjustFree
            move.l  (SP)+,D0
            rts
a24PurgeHeap:
            movem.l D2/A1-A4,-(SP)
.L1:
            movea.l (A6),A3
            lea     ($34,A6),A0
            btst    #6,($16,A6)
            bne.b   .L7
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (A2),D1
            and.l   Lo3Bytes,D1
            movea.l A2,A4
            adda.l  D1,A2
            tst.b   (A4)
            beq.b   .L3
            bpl.b   .L4
            movea.l (4,A4),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L4
            btst    #6,(A1)
            beq.b   .L6
            cmpa.l  (4,A6),A4
            bcs.b   .L5
.L3:
            add.l   D1,D2
            cmp.l   D0,D2
            bcs.b   .L6
            bra.b   .L8
.L4:
            moveq   #0,D2
.L5:
            movea.l A2,A0
.L6:
            cmpa.l  A3,A2
            bcs.b   .L2
            lea     ($34,A6),A0
            cmpa.l  (4,A6),A0
            beq.b   .L7
            move.l  A0,(4,A6)
            bra.b   .L1
.L7:
            movea.l A3,A2
.L8:
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            tst.b   (A0)
            bpl.b   .L9
            movea.l (4,A0),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L9
            btst    #6,(A1)
            beq.b   .L9
            bsr.w   a24PurgeBlock
            cmp.l   D0,D1
            bcc.b   .L10
.L9:
            adda.l  D1,A0
            move.l  A0,(4,A6)
            cmpa.l  A2,A0
            bcs.b   .L8
.L10:
            bsr.w   a24CompactHp
            movem.l (SP)+,D2/A1-A4
            rts
a32PurgeHeap:
            movem.l D2/A1-A4,-(SP)
.L1:
            movea.l (A6),A3
            lea     ($34,A6),A0
            btst    #6,($16,A6)
            bne.b   .L7
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (4,A2),D1
            movea.l A2,A4
            adda.l  D1,A2
            tst.b   (A4)
            beq.b   .L3
            bpl.b   .L4
            tst.b   (1,A4)
            bmi.b   .L4
            btst    #6,(1,A4)
            beq.b   .L6
            cmpa.l  (4,A6),A4
            bcs.b   .L5
.L3:
            add.l   D1,D2
            cmp.l   D0,D2
            bcs.b   .L6
            bra.b   .L8
.L4:
            moveq   #0,D2
.L5:
            movea.l A2,A0
.L6:
            cmpa.l  A3,A2
            bcs.b   .L2
            lea     ($34,A6),A0
            cmpa.l  (4,A6),A0
            beq.b   .L7
            move.l  A0,(4,A6)
            bra.b   .L1
.L7:
            movea.l A3,A2
.L8:
            move.l  (4,A0),D1
            tst.b   (A0)
            bpl.b   .L9
            movea.l (8,A0),A1
            adda.l  A6,A1
            tst.b   (1,A0)
            bmi.b   .L9
            btst    #6,(1,A0)
            beq.b   .L9
            bsr.w   a32PurgeBlock
            cmp.l   D0,D1
            bcc.b   .L10
.L9:
            adda.l  D1,A0
            move.l  A0,(4,A6)
            cmpa.l  A2,A0
            bcs.b   .L8
.L10:
            bsr.w   A32COMPACTHP
            movem.l (SP)+,D2/A1-A4
            rts
A24TOTEPURGEABLES:
            moveq   #0,D0
            move.l  D0,D1
            movea.l D0,A0
            lea     ($34,A6),A1
.L1:
            cmpa.l  (A6),A1
            bcc.b   .L5
            move.l  (A1),D2
            and.l   Lo3Bytes,D2
            tst.b   (A1)
            beq.b   .L2
            bpl.b   .L4
            movea.l (4,A1),A2
            adda.l  A6,A2
            tst.b   (A2)
            bmi.b   .L4
            btst    #6,(A2)
            beq.b   .L3
.L2:
            add.l   D2,D1
.L3:
            adda.l  D2,A1
            bra.b   .L1
.L4:
            pea     .L3
.L5:
            bsr.l   V24PURGESPACEPATCH
            nop
            moveq   #0,D1
            rts
A32TOTEPURGEABLES:
            moveq   #0,D0
            move.l  D0,D1
            movea.l D0,A0
            lea     ($34,A6),A1
.L1:
            cmpa.l  (A6),A1
            bcc.b   .L5
            move.l  (4,A1),D2
            tst.b   (A1)
            beq.b   .L2
            bpl.b   .L4
            tst.b   (1,A1)
            bmi.b   .L4
            btst    #6,(1,A1)
            beq.b   .L3
.L2:
            add.l   D2,D1
.L3:
            adda.l  D2,A1
            bra.b   .L1
.L4:
            pea     .L3
.L5:
            bsr.l   V32PURGESPACEPATCH
            nop
            moveq   #0,D1
            rts
CallGZProc:
            move.l  ($2C,A6),D2
            beq.b   .L1
            movem.l D0-D1/D3-D7/A0-A6,-(SP)
            movea.l ($2C,A6),A1
            clr.l   -(SP)
            move.l  D0,-(SP)
            jsr     (A1)
            move.l  (SP)+,D2
            movem.l (SP)+,D0-D1/D3-D7/A0-A6
.L1:
            rts
A24BKCOMPACTS:
            movem.l D0/D2,-(SP)
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L1
            tst.l   D2
            beq.b   .L1
            bsr.w   a24GrowZone
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
.L1:
            bsr.w   a24PurgeHeap
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            beq.b   .L3
.L2:
            bsr.b   CallGZProc
            bsr.w   a24CompactHp
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            bne.b   .L2
            suba.l  A0,A0
.L3:
            move.l  A0,D2
            movem.l (SP)+,D0/D2
            rts
A32BKCOMPACTS:
            movem.l D0/D2,-(SP)
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
            cmpa.l  ApplZone,A6
            bne.b   .L1
            tst.l   D2
            beq.b   .L1
            bsr.w   a32GrowZone
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
.L1:
            bsr.w   a32PurgeHeap
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            beq.b   .L3
.L2:
            bsr.w   CallGZProc
            bsr.w   A32COMPACTHP
            cmp.l   D1,D0
            bls.b   .L3
            tst.l   D2
            bne.b   .L2
            suba.l  A0,A0
.L3:
            move.l  A0,D2
            movem.l (SP)+,D0/D2
            rts
sub_4080E128:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  Lo3Bytes,D2
            lea     ($30,A6),A2
            btst    #5,($16,A6)
            beq.b   .L1
            clr.l   (A2)
.L1:
            move.l  (A2),D1
            movea.l D1,A1
            bne.b   .L2
            lea     ($34,A6),A1
.L2:
            cmpa.l  (A6),A1
            bcc.b   .L6
            move.l  (A1),D1
            tst.b   (A1)
            beq.b   .L4
.L3:
            and.l   D2,D1
            adda.l  D1,A1
            bra.b   .L2
.L4:
            movea.l A1,A0
            adda.l  D1,A0
            tst.b   (A0)
            bne.b   .L5
            cmpa.l  (A6),A0
            bcc.b   .L5
            add.l   (A0),D1
            move.l  D1,(A1)
            bra.b   .L4
.L5:
            cmp.l   D0,D1
            bcs.b   .L3
            movea.l A1,A0
            bra.b   .L8
.L6:
            tst.l   (A2)
            beq.b   .L7
            clr.l   (A2)
            bra.b   .L1
.L7:
            suba.l  A0,A0
.L8:
            move.l  A0,(A2)
            movem.l (SP)+,D1-D2/A1-A2
            rts
a32BFindS:
            movem.l D1-D2/A1-A2,-(SP)
            move.l  Lo3Bytes,D2
            lea     ($30,A6),A2
            btst    #5,($16,A6)
            beq.b   .L1
            clr.l   (A2)
.L1:
            move.l  (A2),D1
            movea.l D1,A1
            bne.b   .L2
            lea     ($34,A6),A1
.L2:
            cmpa.l  (A6),A1
            bcc.b   .L6
            move.l  (4,A1),D1
            tst.b   (A1)
            beq.b   .L4
.L3:
            adda.l  D1,A1
            bra.b   .L2
.L4:
            movea.l A1,A0
            adda.l  D1,A0
            tst.b   (A0)
            bne.b   .L5
            cmpa.l  (A6),A0
            bcc.b   .L5
            add.l   (4,A0),D1
            move.l  D1,(4,A1)
            clr.l   (A1)
            bra.b   .L4
.L5:
            cmp.l   D0,D1
            bcs.b   .L3
            movea.l A1,A0
            bra.b   .L8
.L6:
            tst.l   (A2)
            beq.b   .L7
            clr.l   (A2)
            bra.b   .L1
.L7:
            suba.l  A0,A0
.L8:
            move.l  A0,(A2)
            movem.l (SP)+,D1-D2/A1-A2
            rts
a24AllocBk:
            movem.l D0-D5,-(SP)
            move.l  D0,D4
            bsr.w   A24ACTUALS
            bsr.w   sub_4080E128
            bne.b   .L1
            moveq   #-1,D2
            bsr.w   A24BKCOMPACTS
            bne.b   .L1
            suba.l  A0,A0
            bra.b   .L4
.L1:
            move.l  D0,D2
            move.l  (A0),D0
            move.l  A1,D5
            beq.b   .L2
            sub.l   A6,D5
            moveq   #2,D1
            moveq   #-1,D3
            bra.b   .L3
.L2:
            move.l  A6,D5
            moveq   #1,D1
            moveq   #0,D3
.L3:
            bsr.w   a24MakeBK
            move.l  D5,(4,A0)
            move.l  D4,D0
            bsr.b   a24SetLogSize
            addq.l  #8,A0
            move.l  A1,D5
            beq.b   .L4
            move.l  A0,(A1)
.L4:
            move.l  A0,D0
            movem.l (SP)+,D0-D5
            rts
A32ALLOCBK:
            movem.l D0-D5,-(SP)
            move.l  D0,D4
            bsr.w   A32ACTUALS
            bsr.w   a32BFindS
            bne.b   .L1
            moveq   #-1,D2
            bsr.w   A32BKCOMPACTS
            bne.b   .L1
            suba.l  A0,A0
            bra.b   .L4
.L1:
            move.l  D0,D2
            move.l  (4,A0),D0
            move.l  A1,D5
            beq.b   .L2
            sub.l   A6,D5
            moveq   #2,D1
            moveq   #-1,D3
            bra.b   .L3
.L2:
            move.l  A6,D5
            moveq   #1,D1
            moveq   #0,D3
.L3:
            bsr.w   a32MakeBK
            move.l  D5,(8,A0)
            move.l  D4,D0
            bsr.b   a32SetLogSize
            adda.w  #$C,A0
            move.l  A1,D5
            beq.b   .L4
            move.l  A0,(A1)
.L4:
            move.l  A0,D0
            movem.l (SP)+,D0-D5
            rts
a24SetLogSize:
            move.l  D1,-(SP)
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            subq.l  #8,D1
            sub.l   D0,D1
            andi.b  #$F,D1
            andi.b  #$C0,(A0)
            or.b    D1,(A0)
            move.l  (SP)+,D1
            rts
a32SetLogSize:
            move.l  D1,-(SP)
            move.l  (4,A0),D1
            subi.l  #$C,D1
            sub.l   D0,D1
            move.b  D1,(3,A0)
            move.l  (SP)+,D1
            rts
a24MakeBK:
            movem.l D0-D2/D4/A1,-(SP)
            move.l  D0,D4
            sub.l   D2,D0
            movea.l A0,A1
            cmpi.l  #$C,D0
            bcs.b   .L3
            tst.w   D3
            beq.b   .L1
            tst.b   ($16,A6)
            bpl.b   .L1
            adda.l  D0,A1
            bra.b   .L2
.L1:
            adda.l  D2,A0
.L2:
            bsr.w   a24MakeBkF
            bra.b   .L4
.L3:
            move.l  D4,D2
.L4:
            move.l  D2,D0
            bsr.w   SubtractFree
            movea.l A1,A0
            ror.l   #2,D1
            add.l   D2,D1
            move.l  D1,(A0)
            movem.l (SP)+,D0-D2/D4/A1
            rts
a32MakeBK:
            movem.l D0-D2/D4/A1,-(SP)
            move.l  D0,D4
            sub.l   D2,D0
            movea.l A0,A1
            cmpi.l  #$10,D0
            bcs.b   .L3
            tst.w   D3
            beq.b   .L1
            tst.b   ($16,A6)
            bpl.b   .L1
            adda.l  D0,A1
            bra.b   .L2
.L1:
            adda.l  D2,A0
.L2:
            bsr.w   a32MakeBkF
            bra.b   .L4
.L3:
            move.l  D4,D2
.L4:
            move.l  D2,D0
            bsr.w   SubtractFree
            movea.l A1,A0
            ror.l   #2,D1
            move.l  D2,(4,A0)
            move.l  D1,(A0)
            movem.l (SP)+,D0-D2/D4/A1
            rts
HBlockMove:
            movem.l D0-D2/A0-A2,-(SP)
            movea.l ($4B8).w,A2
            jsr     (A2)
            movem.l (SP)+,D0-D2/A0-A2
            rts
a24CompactHp:
            movem.l D0/D2-D5/A1-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            lea     ($34,A6),A0
            bra.b   .L2
.L1:
            move.l  (A0),D4
            and.l   Lo3Bytes,D4
            adda.l  D4,A0
            cmpa.l  (A6),A0
            bcc.b   .L3
.L2:
            tst.b   (A0)
            bne.b   .L1
.L3:
            btst    #4,($16,A6)
            seq     D5
            movea.l A0,A2
.L4:
            movea.l A0,A1
            moveq   #0,D2
.L5:
            cmpa.l  (A6),A0
            bcc.b   .L9
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            tst.b   (A0)
            beq.b   .L6
            bpl.b   .L8
            movea.l (4,A0),A3
            adda.l  A6,A3
            tst.b   (A3)
            bmi.b   .L8
            tst.b   D5
            bne.b   .L7
            lea     (8,A1),A4
            move.b  (A3),D4
            move.l  A4,(A3)
            move.b  D4,(A3)
            bsr.b   HBlockMove
            adda.l  D0,A1
            bra.b   .L7
.L6:
            add.l   D0,D2
            movea.l A1,A3
            cmp.l   D3,D2
            bcs.b   .L7
            tst.b   D5
            beq.b   .L10
            clr.b   D5
            movea.l A2,A0
            bra.b   .L4
.L7:
            adda.l  D0,A0
            bra.b   .L5
.L8:
            bsr.w   a24MakeFree
            bra.b   .L1
.L9:
            suba.l  A3,A3
.L10:
            bsr.w   a24MakeFree
            movea.l A3,A0
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/D2-D5/A1-A4
            rts
A32COMPACTHP:
            movem.l D0/D2-D5/A1-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            lea     ($34,A6),A0
            bra.b   .L2
.L1:
            move.l  (4,A0),D4
            adda.l  D4,A0
            cmpa.l  (A6),A0
            bcc.b   .L3
.L2:
            tst.b   (A0)
            bne.b   .L1
.L3:
            btst    #4,($16,A6)
            seq     D5
            movea.l A0,A2
.L4:
            movea.l A0,A1
            moveq   #0,D2
.L5:
            cmpa.l  (A6),A0
            bcc.b   .L9
            move.l  (4,A0),D0
            tst.b   (A0)
            beq.b   .L6
            bpl.b   .L8
            movea.l (8,A0),A3
            adda.l  A6,A3
            tst.b   (1,A0)
            bmi.b   .L8
            tst.b   D5
            bne.b   .L7
            lea     ($C,A1),A4
            move.l  A4,(A3)
            bsr.w   HBlockMove
            adda.l  D0,A1
            bra.b   .L7
.L6:
            add.l   D0,D2
            movea.l A1,A3
            cmp.l   D3,D2
            bcs.b   .L7
            tst.b   D5
            beq.b   .L10
            clr.b   D5
            movea.l A2,A0
            bra.b   .L4
.L7:
            adda.l  D0,A0
            bra.b   .L5
.L8:
            bsr.w   a32MakeFree
            bra.b   .L1
.L9:
            suba.l  A3,A3
.L10:
            bsr.b   a32MakeFree
            movea.l A3,A0
            move.l  A0,($30,A6)
            movem.l (SP)+,D0/D2-D5/A1-A4
            rts
a24MakeFree:
            tst.l   D2
            beq.b   .L2
            tst.b   D5
            bne.b   .L1
            move.l  D2,(A1)
.L1:
            cmp.l   D2,D1
            bcc.b   .L2
            move.l  D2,D1
.L2:
            rts
a32MakeFree:
            tst.l   D2
            beq.b   .L2
            tst.b   D5
            bne.b   .L1
            clr.l   (A1)
            move.l  D2,(4,A1)
.L1:
            cmp.l   D2,D1
            bcc.b   .L2
            move.l  D2,D1
.L2:
            rts
ToMaxLimit:
            move.l  BufPtr,D2
            sub.l   DefltStack,D2
A24MAXLIMIT:
            bra.l   A24MAXLIMITPATCH
            ds.b    20
A32MAXLIMIT:
            bra.l   A32MAXLIMITPATCH
            ds.b    16
A24ZONEADJUSTEND:
            movem.l D0/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A6),A0
            move.l  A3,D0
            sub.l   A0,D0
            move.l  #$C,(A3)
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
            move.l  A3,(A6)
            movem.l (SP)+,D0/A0/A2-A3
            rts
A32ZONEADJUSTEND:
            movem.l D0/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A6),A0
            move.l  A3,D0
            sub.l   A0,D0
            clr.l   (A3)
            move.l  #$10,(4,A3)
            bsr.w   a32MakeBkF
            bsr.w   AdjustFree
            move.l  A3,(A6)
            movem.l (SP)+,D0/A0/A2-A3
            rts
a24GrowZone:
            movem.l D0-D3/A0-A2,-(SP)
            addi.l  #$400,D0
            andi.w  #$FC00,D0
            move.l  D0,D3
            move.l  ApplLimit,D2
            bsr.w   A24MAXLIMIT
            move.l  HeapEnd,D2
            cmp.l   D2,D1
            bls.b   .L3
            add.l   D0,D2
            bcs.b   .L3
            cmp.l   D2,D1
            bcs.b   .L1
            move.l  D2,D1
            moveq   #0,D3
            bra.b   .L2
.L1:
            move.l  D1,D0
            sub.l   HeapEnd,D0
            cmpi.l  #$C,D0
            bcs.b   .L3
.L2:
            move.l  D1,HeapEnd
            movea.l D1,A0
            bsr.w   A24ZONEADJUSTEND
.L3:
            movem.l (SP)+,D0-D3/A0-A2
            rts
a32GrowZone:
            movem.l D0-D3/A0-A2,-(SP)
            addi.l  #$400,D0
            andi.w  #$FC00,D0
            move.l  D0,D3
            move.l  ApplLimit,D2
            bsr.w   A32MAXLIMIT
            move.l  HeapEnd,D2
            cmp.l   D2,D1
            bls.b   .L3
            add.l   D0,D2
            bcs.b   .L3
            cmp.l   D2,D1
            bcs.b   .L1
            move.l  D2,D1
            moveq   #0,D3
            bra.b   .L2
.L1:
            move.l  D1,D0
            sub.l   HeapEnd,D0
            cmpi.l  #$10,D0
            bcs.b   .L3
.L2:
            move.l  D1,HeapEnd
            movea.l D1,A0
            bsr.w   A32ZONEADJUSTEND
.L3:
            movem.l (SP)+,D0-D3/A0-A2
            rts
A24ACTUALS:
            bra.l   A24ACTUALSPATCH
            ds.b    14
A32ACTUALS:
            bra.l   A32ACTUALSPATCH
            ds.b    18
a24GetSize:
            move.l  D1,-(SP)
            subq.l  #8,A0
            moveq   #$F,D1
            and.b   (A0),D1
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            subq.l  #8,D0
            sub.l   D1,D0
            addq.l  #8,A0
            move.l  (SP)+,D1
            rts
A32GETSIZE:
            move.l  D1,-(SP)
            suba.w  #$C,A0
            moveq   #0,D1
            move.b  (3,A0),D1
            move.l  (4,A0),D0
            subi.l  #$C,D0
            sub.l   D1,D0
            adda.w  #$C,A0
            move.l  (SP)+,D1
            rts
ClearGZStuff:
            clr.l   GZRootHnd
            clr.l   GZRootPtr
            rts
A24SETSIZE:
            movem.l D1-D6/A0-A3,-(SP)
            move.b  (A1),-(SP)
            bsr.l   A24SETSIZEPATCH
            bsr.b   a24GetSize
            cmp.l   D0,D1
            beq.w   .L18
            movea.l A0,A2
            subq.l  #8,A2
            move.l  (A2),D2
            and.l   Lo3Bytes,D2
            move.l  D2,D4
            cmp.l   D2,D3
            beq.w   .L17
            bcs.w   .L16
            move.l  D3,D5
            sub.l   D2,D5
            move.l  A1,GZRootHnd
            move.l  A0,GZRootPtr
            movea.l A2,A3
            adda.l  D4,A3
            moveq   #0,D6
.L1:
            cmpa.l  (A6),A3
            bcc.b   .L2
            tst.b   (A3)
            bne.b   .L2
            add.l   (A3),D6
            adda.l  (A3),A3
            bra.b   .L1
.L2:
            sub.l   D6,D5
            bls.w   .L12
            move.l  A1,D0
            beq.w   .L12
            tst.b   (SP)
            bmi.w   .L12
            lea     ($34,A6),A3
.L3:
            cmpa.l  A2,A3
            bcc.b   .L7
            move.l  (A3),D0
            tst.b   (A3)
            beq.b   .L4
            and.l   Lo3Bytes,D0
            adda.l  D0,A3
            moveq   #0,D0
            bra.b   .L3
.L4:
            movea.l A3,A0
            moveq   #0,D0
.L5:
            cmpa.l  ($30,A6),A3
            bne.b   .L6
            move.l  A0,($30,A6)
.L6:
            add.l   (A3),D0
            adda.l  (A3),A3
            tst.b   (A3)
            beq.b   .L5
            move.l  D0,(A0)
            bra.b   .L3
.L7:
            move.l  D5,D6
            lsr.l   #2,D6
            cmp.l   D6,D0
            bls.b   .L11
            moveq   #$C,D6
            cmp.l   D5,D6
            bls.b   .L8
            move.l  D6,D5
.L8:
            moveq   #$18,D6
            add.l   D5,D6
            cmp.l   D6,D0
            bcs.b   .L9
            sub.l   D5,D0
            move.l  D0,(A0)
            adda.l  D0,A0
            move.l  D5,D0
.L9:
            move.l  A0,(A1)
            addq.l  #8,(A1)
            move.b  (SP),(A1)
            movem.l D0/A1,-(SP)
            cmpa.l  ($30,A6),A2
            bne.b   .L10
            move.l  A0,($30,A6)
.L10:
            exg     A0,A2
            movea.l A2,A1
            move.l  D4,D0
            bsr.w   HBlockMove
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (SP)+,(A0)
            movea.l (SP)+,A1
            lea     (8,A2),A0
            move.l  A0,GZRootPtr
            bra.b   .L12
.L11:
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            cmp.l   D0,D3
            bcc.b   .L12
            tst.b   (A0)
            bne.b   .L13
.L12:
            movea.l A2,A0
            move.l  D3,D0
            sub.l   D2,D0
            adda.l  D2,A2
            bset    #7,(A1)
            bsr.w   a24MakeSpace
            bclr    #7,(A1)
            move.l  A2,D4
            bne.b   .L15
.L13:
            move.l  A1,D4
            beq.b   .L14
            tst.b   (SP)
            bmi.b   .L14
            move.l  D1,D0
            bclr    #6,(A1)
            bsr.w   a24RelocRel
            move.b  (SP),(A1)
            bsr.w   ClearGZStuff
            bra.b   .L19
.L14:
            bsr.w   ClearGZStuff
            moveq   #-$6C,D0
            bra.b   .L19
.L15:
            bsr.w   ClearGZStuff
            move.l  (A2),D0
            move.l  D0,D4
            add.l   D2,D4
            movea.l A0,A2
            move.b  (A2),D5
            move.l  D4,(A2)
            move.b  D5,(A2)
            bsr.w   SubtractFree
.L16:
            sub.l   D3,D4
            cmpi.l  #$C,D4
            bcs.b   .L17
            btst    #0,($16,A6)
            bne.b   .L20
            movea.l A2,A0
            adda.l  D3,A0
            move.b  (A2),D5
            move.l  D3,(A2)
            move.b  D5,(A2)
            move.l  D4,D0
            bsr.w   a24MakeBkF
            bsr.w   AdjustFree
.L17:
            movea.l A2,A0
            move.l  D1,D0
            bsr.w   a24SetLogSize
.L18:
            moveq   #0,D0
.L19:
            move.b  (SP)+,(A1)
            movem.l (SP)+,D1-D6/A0-A3
            rts
.L20:
            moveq   #-$63,D0
            bra.b   .L19
A32SETSIZE:
            movem.l D1-D6/A0-A3,-(SP)
            movea.l A0,A2
            move.b  (-$B,A2),-(SP)
            bsr.l   A32SETSIZEPATCH
            nop
            bsr.w   A32GETSIZE
            cmp.l   D0,D1
            beq.w   .L18
            movea.l A0,A2
            suba.w  #$C,A2
            move.l  (4,A2),D2
            move.l  D2,D4
            cmp.l   D2,D3
            beq.w   .L17
            bcs.w   .L16
            move.l  D3,D5
            sub.l   D2,D5
            move.l  A1,GZRootHnd
            move.l  A0,GZRootPtr
            movea.l A2,A3
            adda.l  D4,A3
            moveq   #0,D6
.L1:
            cmpa.l  (A6),A3
            bcc.b   .L2
            tst.b   (A3)
            bne.b   .L2
            add.l   (4,A3),D6
            adda.l  (4,A3),A3
            bra.b   .L1
.L2:
            sub.l   D6,D5
            bls.w   .L12
            move.l  A1,D0
            beq.w   .L12
            tst.b   (SP)
            bmi.w   .L12
            lea     ($34,A6),A3
.L3:
            cmpa.l  A2,A3
            bcc.b   .L7
            tst.b   (A3)
            beq.b   .L4
            move.l  (4,A3),D0
            adda.l  D0,A3
            moveq   #0,D0
            bra.b   .L3
.L4:
            movea.l A3,A0
            moveq   #0,D0
.L5:
            cmpa.l  ($30,A6),A3
            bne.b   .L6
            move.l  A0,($30,A6)
.L6:
            add.l   (4,A3),D0
            adda.l  (4,A3),A3
            tst.b   (A3)
            beq.b   .L5
            clr.l   (A0)
            move.l  D0,(4,A0)
            bra.b   .L3
.L7:
            move.l  D5,D6
            lsr.l   #2,D6
            cmp.l   D6,D0
            bls.b   .L11
            moveq   #$10,D6
            cmp.l   D5,D6
            bls.b   .L8
            move.l  D6,D5
.L8:
            moveq   #$20,D6
            add.l   D5,D6
            cmp.l   D6,D0
            bcs.b   .L9
            sub.l   D5,D0
            clr.l   (A0)
            move.l  D0,(4,A0)
            adda.l  D0,A0
            move.l  D5,D0
.L9:
            move.l  A0,(A1)
            addi.l  #$C,(A1)
            move.b  (SP),(1,A0)
            movem.l D0/A1,-(SP)
            cmpa.l  ($30,A6),A2
            bne.b   .L10
            move.l  A0,($30,A6)
.L10:
            exg     A0,A2
            movea.l A2,A1
            move.l  D4,D0
            bsr.w   HBlockMove
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (SP)+,(4,A0)
            clr.l   (A0)
            movea.l (SP)+,A1
            lea     ($C,A2),A0
            move.l  A0,GZRootPtr
            bra.b   .L12
.L11:
            movea.l A2,A0
            adda.l  D4,A0
            move.l  (4,A0),D0
            cmp.l   D0,D3
            bcc.b   .L12
            tst.b   (A0)
            bne.b   .L13
.L12:
            movea.l A2,A0
            move.l  D3,D0
            sub.l   D2,D0
            adda.l  D2,A2
            movea.l (A1),A3
            bset    #7,(-$B,A3)
            bsr.w   a32MakeSpace
            bclr    #7,(-$B,A3)
            move.l  A2,D4
            bne.b   .L15
.L13:
            move.l  A1,D4
            beq.b   .L14
            tst.b   (SP)
            bmi.b   .L14
            move.l  D1,D0
            movea.l (A1),A3
            bclr    #6,(-$B,A3)
            bsr.w   a32RelocRel
            move.b  (SP),(-$B,A3)
            bsr.w   ClearGZStuff
            bra.b   .L19
.L14:
            bsr.w   ClearGZStuff
            moveq   #-$6C,D0
            bra.b   .L19
.L15:
            bsr.w   ClearGZStuff
            move.l  (4,A2),D0
            move.l  D0,D4
            add.l   D2,D4
            movea.l A0,A2
            move.l  D4,(4,A2)
            bsr.b   SubtractFree
.L16:
            sub.l   D3,D4
            cmpi.l  #$10,D4
            bcs.b   .L17
            btst    #0,($16,A6)
            bne.b   .L20
            movea.l A2,A0
            adda.l  D3,A0
            move.l  D3,(4,A2)
            move.l  D4,D0
            bsr.w   a32MakeBkF
            bsr.b   AdjustFree
.L17:
            movea.l A2,A0
            move.l  D1,D0
            bsr.w   a32SetLogSize
.L18:
            moveq   #0,D0
.L19:
            movea.l (A1),A3
            move.b  (SP)+,(-$B,A3)
            movem.l (SP)+,D1-D6/A0-A3
            rts
.L20:
            moveq   #-$63,D0
            bra.b   .L19
AdjustFree:
            add.l   D0,($C,A6)
            bcs.b   .L1
            rts
.L1:
            moveq   #$21,D0
            _SysError
            rts
SubtractFree:
            sub.l   D0,($C,A6)
            bcs.b   SubFail
            rts
SubFail:
            moveq   #$21,D0
            _SysError
A24NEXTMASTER:
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A1
            move.l  A1,D0
            bne.b   .L1
            bsr.b   A24HMAKEMOREMASTERS
            beq.b   .L2
.L1:
            move.l  (A1),(8,A6)
            move.l  A1,D0
.L2:
            movem.l (SP)+,D0/A0
            rts
A32NEXTMASTER:
            movem.l D0/A0,-(SP)
            movea.l (8,A6),A1
            move.l  A1,D0
            bne.b   .L1
            bsr.b   A32HMAKEMOREMASTERS
            beq.b   .L2
.L1:
            move.l  (A1),(8,A6)
            move.l  A1,D0
.L2:
            movem.l (SP)+,D0/A0
            rts
A24HMAKEMOREMASTERS:
            movem.l D0-D1/A0,-(SP)
            move.w  ($14,A6),D0
            ext.l   D0
            bgt.b   .L1
            moveq   #$20,D0
.L1:
            move.l  D0,D1
            asl.l   #2,D0
            bsr.b   A24MAKEPTRSPC
            suba.l  A1,A1
            bsr.w   a24AllocBk
            beq.b   .L3
            movea.l A0,A1
.L2:
            bsr.b   ReleaseMP
            addq.l  #4,A1
            subq.w  #1,D1
            bne.b   .L2
            subq.l  #4,A1
.L3:
            move.l  A1,D0
            movem.l (SP)+,D0-D1/A0
            rts
A32HMAKEMOREMASTERS:
            movem.l D0-D1/A0,-(SP)
            move.w  ($14,A6),D0
            ext.l   D0
            bgt.b   .L1
            moveq   #$20,D0
.L1:
            move.l  D0,D1
            asl.l   #2,D0
            bsr.w   A32MAKEPTRSPC
            suba.l  A1,A1
            bsr.w   A32ALLOCBK
            beq.b   .L3
            movea.l A0,A1
.L2:
            bsr.b   ReleaseMP
            addq.l  #4,A1
            subq.w  #1,D1
            bne.b   .L2
            subq.l  #4,A1
.L3:
            move.l  A1,D0
            movem.l (SP)+,D0-D1/A0
            rts
ReleaseMP:
            move.l  (8,A6),(A1)
            move.l  A1,(8,A6)
            rts
A24MAKEPTRSPC:
            movem.l D0-D4/A0-A1/A3-A4,-(SP)
            bsr.w   A24ACTUALS
            movea.l A6,A4
            cmpa.l  ApplZone,A6
            seq     D3
.L1:
            lea     ($34,A4),A0
            movea.l (A6),A3
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L9
            movea.l (4,A0),A1
            adda.l  A6,A1
            tst.b   (A1)
            bmi.b   .L9
.L3:
            add.l   D1,D2
            adda.l  D1,A0
            cmp.l   D0,D2
            bcs.b   .L11
            bsr.w   a24MakeSpace
            move.l  A2,D2
            bne.b   .L8
            lea     ($34,A4),A2
.L4:
            move.l  (A2),D1
            and.l   Lo3Bytes,D1
            adda.l  D1,A2
            tst.b   (A2)
            bpl.b   .L5
            movea.l (4,A2),A1
            adda.l  A6,A1
            tst.b   (A1)
            bpl.b   .L6
.L5:
            cmpa.l  A0,A2
            bhi.b   .L7
.L6:
            cmpa.l  A3,A2
            bcs.b   .L4
.L7:
            movea.l A2,A0
            suba.l  A2,A2
.L8:
            move.l  A2,D2
            bne.b   .L13
            bra.b   .L10
.L9:
            adda.l  D1,A0
.L10:
            movea.l A0,A2
            moveq   #0,D2
.L11:
            cmpa.l  A3,A0
            bcs.b   .L2
            addq.b  #1,D3
            bne.b   .L12
            bsr.w   a24GrowZone
            bra.b   .L1
.L12:
            suba.l  A2,A2
.L13:
            movem.l (SP)+,D0-D4/A0-A1/A3-A4
            rts
A32MAKEPTRSPC:
            movem.l D0-D4/A0-A1/A3-A4,-(SP)
            bsr.w   A32ACTUALS
            movea.l A6,A4
            cmpa.l  ApplZone,A6
            seq     D3
.L1:
            lea     ($34,A4),A0
            movea.l (A6),A3
            movea.l A0,A2
            moveq   #0,D2
.L2:
            move.l  (4,A0),D1
            tst.b   (A0)
            beq.b   .L3
            bpl.b   .L9
            tst.b   (1,A0)
            bmi.b   .L9
.L3:
            add.l   D1,D2
            adda.l  D1,A0
            cmp.l   D0,D2
            bcs.b   .L11
            bsr.w   a32MakeSpace
            move.l  A2,D2
            bne.b   .L8
            lea     ($34,A4),A2
.L4:
            move.l  (4,A2),D1
            adda.l  D1,A2
            tst.b   (A2)
            bpl.b   .L5
            tst.b   (1,A2)
            bpl.b   .L6
.L5:
            cmpa.l  A0,A2
            bhi.b   .L7
.L6:
            cmpa.l  A3,A2
            bcs.b   .L4
.L7:
            movea.l A2,A0
            suba.l  A2,A2
.L8:
            move.l  A2,D2
            bne.b   .L13
            bra.b   .L10
.L9:
            adda.l  D1,A0
.L10:
            movea.l A0,A2
            moveq   #0,D2
.L11:
            cmpa.l  A3,A0
            bcs.b   .L2
            addq.b  #1,D3
            bne.b   .L12
            bsr.w   a32GrowZone
            bra.b   .L1
.L12:
            suba.l  A2,A2
.L13:
            movem.l (SP)+,D0-D4/A0-A1/A3-A4
            rts
a24MakeSpace:
            movem.l D0-D3/A0-A1/A3,-(SP)
            move.l  D0,D1
            movea.l A2,A3
            moveq   #0,D3
MSpLoop:
            cmp.l   D1,D3
            bcc.b   MSpDone
            cmpa.l  (A6),A3
            bcc.b   MSpDone
            tst.b   (A3)
            beq.b   MSpFree
            bpl.b   MSpDone
            movea.l (4,A3),A1
            adda.l  A6,A1
            move.b  (A1),D2
            bmi.b   MSpDone
            bsr.w   a24SafeReloc
            beq.b   MSpFree
            btst    #6,D2
            beq.b   MSpDone
            movea.l (A1),A0
            subq.l  #8,A0
            bsr.w   a24PurgeBlock
MSpFree:
            movea.l A3,A0
            move.l  (A0),D0
            cmpa.l  ($30,A6),A0
            bne.b   MSpNext
            clr.l   ($30,A6)
MSpNext:
            add.l   D0,D3
            adda.l  D0,A3
            bra.b   MSpLoop
MSpDone:
            and.l   Lo3Bytes,D3
            beq.b   .L1
            move.l  D3,(A2)
.L1:
            cmp.l   D1,D3
            bcc.b   .L2
            suba.l  A2,A2
.L2:
            clr.l   ($30,A6)
            movem.l (SP)+,D0-D3/A0-A1/A3
            rts
a32MakeSpace:
            movem.l D0-D3/A0-A1/A3,-(SP)
            move.l  D0,D1
            movea.l A2,A3
            moveq   #0,D3
MSpLoop_2:
            cmp.l   D1,D3
            bcc.b   MSpDone_2
            cmpa.l  (A6),A3
            bcc.b   MSpDone_2
            tst.b   (A3)
            beq.b   MSpFree_2
            bpl.b   MSpDone_2
            movea.l (8,A3),A1
            adda.l  A6,A1
            move.b  (1,A3),D2
            bmi.b   MSpDone_2
            bsr.b   a32SafeReloc
            beq.b   MSpFree_2
            btst    #6,D2
            beq.b   MSpDone_2
            movea.l (A1),A0
            suba.w  #$C,A0
            bsr.w   a32PurgeBlock
MSpFree_2:
            movea.l A3,A0
            move.l  (4,A0),D0
            cmpa.l  ($30,A6),A0
            bne.b   MSpNext_2
            clr.l   ($30,A6)
MSpNext_2:
            add.l   D0,D3
            adda.l  D0,A3
            bra.b   MSpLoop_2
MSpDone_2:
            tst.l   D3
            beq.b   .L1
            clr.l   (A2)
            move.l  D3,(4,A2)
.L1:
            cmp.l   D1,D3
            bcc.b   .L2
            suba.l  A2,A2
.L2:
            clr.l   ($30,A6)
            movem.l (SP)+,D0-D3/A0-A1/A3
            rts
a24SafeReloc:
            move.l  A0,-(SP)
            move.l  D3,D0
            beq.b   .L1
            move.l  D3,(A2)
            ori.l   #$40000000,(A2)
            move.l  A6,(4,A2)
            bsr.w   SubtractFree
.L1:
            movea.l (A1),A0
            bsr.w   a24GetSize
            bsr.b   a24RelocRel
            movea.l D0,A0
            move.l  D3,D0
            beq.b   .L2
            move.l  D3,(A2)
            bsr.w   AdjustFree
.L2:
            move.l  A0,D0
            movea.l (SP)+,A0
            rts
a32SafeReloc:
            move.l  A0,-(SP)
            move.l  D3,D0
            beq.b   .L1
            move.l  D3,(4,A2)
            move.l  #$40000000,(A2)
            move.l  A6,(8,A2)
            bsr.w   SubtractFree
.L1:
            movea.l (A1),A0
            bsr.w   A32GETSIZE
            bsr.b   a32RelocRel
            movea.l D0,A0
            move.l  D3,D0
            beq.b   .L2
            clr.l   (A2)
            move.l  D3,(4,A2)
            bsr.w   AdjustFree
.L2:
            move.l  A0,D0
            movea.l (SP)+,A0
            rts
a24RelocRel:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l A1,A2
            move.l  A1,GZMoveHnd
            move.b  (A2),D1
            suba.l  A1,A1
            bsr.w   a24AllocBk
            beq.b   RRFail
            tst.l   (A2)
            beq.b   RRFree
            movea.l A0,A1
            movea.l (A2),A0
            bsr.w   a24GetSize
            bsr.w   HBlockMove
            subq.l  #8,A0
            subq.l  #8,A1
            moveq   #-$10,D0
            and.b   (A0),D0
            eor.b   D0,(A0)
            moveq   #-$10,D2
            and.b   (A1),D2
            eor.b   D2,(A1)
            or.b    D0,(A1)
            or.b    D2,(A0)
            addq.l  #4,A0
            addq.l  #4,A1
            move.l  (A0),(A1)+
            move.l  A1,(A2)
            move.b  D1,(A2)
            move.l  A6,(A0)+
RRFree:
            bsr.b   a24FreeBk
            moveq   #0,D0
RRExit:
            clr.l   GZMoveHnd
            movem.l (SP)+,D1-D2/A0-A2
            rts
RRFail:
            move.b  D1,(A2)
            moveq   #-$6C,D0
            bra.b   RRExit
a32RelocRel:
            movem.l D1-D2/A0-A2,-(SP)
            movea.l A1,A2
            move.l  A1,GZMoveHnd
            suba.l  A1,A1
            bsr.w   A32ALLOCBK
            beq.b   RRFail_2
            tst.l   (A2)
            beq.b   RRFree_2
            movea.l A0,A1
            movea.l (A2),A0
            bsr.w   A32GETSIZE
            bsr.w   HBlockMove
            suba.w  #$C,A0
            suba.w  #$C,A1
            move.b  (A0),D0
            move.b  (A1),D2
            move.b  D0,(A1)
            move.b  D2,(A0)
            move.b  (1,A0),(1,A1)
            addq.l  #8,A0
            addq.l  #8,A1
            move.l  (A0),(A1)+
            move.l  A1,(A2)
            move.l  A6,(A0)+
RRFree_2:
            bsr.w   a32FreeBk
            moveq   #0,D0
RRExit_2:
            clr.l   GZMoveHnd
            movem.l (SP)+,D1-D2/A0-A2
            rts
RRFail_2:
            moveq   #-$6C,D0
            bra.b   RRExit_2
a24FreeBk:
            movem.l D0-D1/A0-A1,-(SP)
            subq.l  #8,A0
            move.l  (A0),D0
            move.l  D0,D1
            and.l   Lo3Bytes,D0
            eor.l   D0,D1
            beq.b   .L2
            bpl.b   .L1
            movea.l (4,A0),A1
            adda.l  A6,A1
            bsr.w   ReleaseMP
.L1:
            bsr.w   sub_4080DDFC
            bsr.w   AdjustFree
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
a32FreeBk:
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$C,A0
            move.l  (4,A0),D0
            tst.b   (A0)
            beq.b   .L2
            bpl.b   .L1
            movea.l (8,A0),A1
            adda.l  A6,A1
            bsr.w   ReleaseMP
.L1:
            bsr.w   sub_4080DE20
            bsr.w   AdjustFree
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
StdGZ:
            movea.l (SP)+,A1
            lea     GZRootHnd,A2
            movem.l (A2),D3-D5
            tst.l   D5
            beq.b   .L1
            cmp.l   D3,D5
            bne.b   .L2
.L1:
            btst    #3,($16,A6)
            bne.b   .L4
            move.l  (SP),D0
            clr.l   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            move.l  TheZone,-(SP)
            move.l  A6,TheZone
            _ResrvMem
            move.l  (SP)+,TheZone
            movem.l D3-D5,-(A2)
            tst.l   D0
            bmi.b   .L4
            move.l  (SP)+,(SP)
            jmp     (A1)
.L2:
            btst    #2,($16,A6)
            bne.b   .L4
.L3:
            addq.w  #4,SP
            jmp     (A1)
.L4:
            move.l  ($10,A6),D2
            beq.b   .L3
            move.l  A1,-(SP)
            move.l  D2,-(SP)
            rts
MEMMGREND:
            ds.b    10
ShutDown:
            bra.w   .L1
            dc.w    $494E,$4954,$0004,$10A3
.L1:
            bra.b   ShutDownDisp.L1
ShutDownDisp:
            move.l  (SP)+,D2
            move.w  (SP)+,D0
            move.l  D2,-(SP)
            subq.w  #1,D0
            bmi.b   .L1
            beq.w   sub_4080EDB2.L7
            subq.w  #2,D0
            bmi.b   sub_4080EDB2.L6
            beq.b   sub_4080EDB2
            bpl.b   sub_4080EDB2.L1
.L1:
            moveq   #$A,D0
            _NewPtrSysClear
            move.l  A0,($BBC).w
            pea     sub_4080EEC6
            move.w  #4,-(SP)
            bsr.b   sub_4080EDB2
            pea     DoUnmount
            move.w  #3,-(SP)
            bsr.b   sub_4080EDB2
            rts
sub_4080EDB2:
            move.l  (SP)+,D2
            move.w  (SP)+,D1
            movea.l (SP)+,A0
            move.l  D2,-(SP)
            movea.l A0,A1
            moveq   #$A,D0
            _NewPtrSys
            move.w  D1,(4,A0)
            move.l  A1,(6,A0)
            movea.l ($BBC).w,A1
            _Enqueue
            rts
.L1:
            move.l  (SP)+,D2
            movea.l (SP)+,A0
            move.l  D2,-(SP)
            move.l  A2,-(SP)
            movea.l ($BBC).w,A1
            addq.w  #2,A1
            movea.l (A1)+,A2
            move.l  (A1),D0
            beq.b   .L3
.L2:
            cmpa.l  (6,A2),A0
            beq.b   .L4
            movea.l (A2),A1
            cmp.l   A2,D0
            movea.l A1,A2
            bne.b   .L2
.L3:
            moveq   #-1,D0
            bra.b   .L5
.L4:
            movea.l ($BBC).w,A1
            movea.l A2,A0
            _Dequeue
            movea.l A2,A0
            _DisposPtr
.L5:
            movea.l (SP)+,A2
            rts
.L6:
            moveq   #1,D0
            BigJsr  SHUTRESTARTANNEX,A0
            cmpi.b  #3,(8,A0)
            lea     ($A,A0),A0
            nop
            jmp     (A0)
.L7:
            moveq   #0,D0
            bsr.b   CallRoutines
            _HideCursor
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetWMgrPort
            _SetPort
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            movea.l ROMBase,A1
            cmpi.b  #3,(8,A1)
            bne.b   .L8
            pea     (-8,A0)
            bra.b   .L9
.L8:
            pea     (-$10,A0)
.L9:
            move.l  (-$82,A0),-(SP)
            _SetClip
            _FillRgn
            movea.l ROMBase,A1
            cmpi.b  #3,(8,A1)
            beq.b   .L10
            btst    #6,ROM85
            bne.b   .L11
.L10:
            _PowerOff
.L11:
            clr.l   ResumeProc
            moveq   #$2A,D0
            _SysError
CallRoutines:
            movem.l D0-D5/A1-A3,-(SP)
            move.w  D0,D4
            tst.l   ($282).w
            ble.b   .L1
            movem.l (SP)+,D0-D5/A1-A3
            _ExitToShell
.L1:
            moveq   #3,D5
            bsr.b   CallCleanUp
            moveq   #2,D5
            bsr.b   CallCleanUp
            move.w  D4,D5
            bsr.b   CallCleanUp
            movem.l (SP)+,D0-D5/A1-A3
            rts
CallCleanUp:
            movea.l ($BBC).w,A1
            lea     (2,A1),A3
            movea.l (A3)+,A2
            move.l  (A3),D3
            beq.b   .L3
.L1:
            movea.l (A2),A3
            move.w  (4,A2),D0
            btst    D5,D0
            beq.b   .L2
            movea.l (6,A2),A0
            move.w  D5,D0
            jsr     (A0)
            move.l  (6,A2),-(SP)
            move.w  #4,-(SP)
            _ShutDown
.L2:
            cmp.l   A2,D3
            movea.l A3,A2
            bne.b   .L1
.L3:
            rts
sub_4080EEC6:
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$32,SP
            move.w  #$FFFF,($1A,SP)
            movea.l UTableBase,A1
            move.w  UnitNtryCnt,D1
.L1:
            move.l  (A1)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            btst    #4,(4,A0)
            beq.b   .L2
            move.w  ($18,A0),($18,SP)
            movea.l SP,A0
            _Control
.L2:
            subq.w  #1,D1
            bne.b   .L1
            lea     ($32,SP),SP
            movem.l (SP)+,D0-D1/A0-A1
            rts
DoUnmount:
            suba.w  #$32,SP
            movea.l SP,A0
            clr.l   ($12,A0)
            clr.w   ($18,A0)
            movea.l ($358).w,A1
            move.l  ($35C).w,D2
            beq.b   .L1
            bsr.b   ZapVCBQueue
.L1:
            lea     ($32,SP),SP
            rts
ZapVCBQueue:
            move.w  D1,-(SP)
            move.w  ($4E,A1),D1
            move.l  (A1),-(SP)
            cmpa.l  D2,A1
            movea.l (SP)+,A1
            beq.b   FlushTime
            bsr.b   ZapVCBQueue
FlushTime:
            move.w  D1,($16,A0)
            _Eject
            _HUnmountVol
            move.w  (SP)+,D1
            rts
TurboFS:
TFSDispatch:
            tst.w   D0
            blt.b   .L1
            cmpi.w  #$11,D0
            bls.b   .L2
.L1:
            bsr.b   FSQueue
            moveq   #-$32,D0
            bra.w   CmdDone
.L2:
            move.w  D0,D2
            lea     .L3,A2
            add.w   D2,D2
            adda.w  (0,A2,D2.w),A2
            jmp     (A2)
.L3:
            dc.w    $0024,$14D8,$1584,$1480,$14B4,$1FF0,$1B7E,$15BE
            dc.b    $2D,$8C,$24,$8E,$22,$C6,$13,$3C,$11,$66,$16,$D4,$16,$FE,$16
            dc.b    'l.D.Da'
            dc.b    $12,$21,$7C,$31,$2E,$32,$41,$00,$20,$70,$00,$60,$00,$00,$BA
FSQueueSync:
            bclr    #$A,D1
FSQueue:
            move.l  ($3E2).w,D2
            ble.b   .L1
            movea.l D2,A1
            jsr     (A1)
.L1:
            move.w  #1,($10,A0)
            move.w  D1,(6,A0)
            cmpi.b  #$60,D1
            bne.b   .L2
            andi.b  #$F,(6,A0)
            move.b  D0,(7,A0)
.L2:
            move.l  (SP)+,(8,A0)
            move.w  #5,(4,A0)
            btst    #$A,D1
            beq.b   .L3
            tst.b   ($349).w
            beq.b   FSAsync
            bra.b   .L4
.L3:
            clr.l   ($C,A0)
.L4:
            move.l  A0,-(SP)
            bsr.b   FSAsync
            movea.l (SP)+,A0
.L5:
            move.w  ($10,A0),D0
            bgt.b   .L5
            ext.l   D0
            cmpi.w  #$FFCB,D0
            bne.b   .L6
            move.l  ($3EA).w,-(SP)
            bgt.b   .L6
            addq.w  #4,SP
            btst    #7,DSAlertRect
            bne.w   DSHook
.L6:
            rts
FSAsync:
            lea     FSQHdr,A1
            move    SR,-(SP)
            ori     #$700,SR
            jsr     QStuff
.L1:
            bset    #0,FSQHdr
            beq.b   .L2
            moveq   #0,D0
            move    (SP)+,SR
            rts
.L2:
            move    (SP)+,SR
            movea.l ($362).w,A0
            movea.l (8,A0),A1
            movem.l D3-D7/A2-A6,-(SP)
            movea.l ($386).w,A6
            clr.w   (-2,A6)
            btst    #$A,(6,A0)
            sne     ($342).w
            movea.l ($36A).w,A6
            jsr     (A1)
            movem.l (SP)+,D3-D7/A2-A6
            rts
.L3:
            moveq   #$1B,D0
            _SysError
CmdDone:
            bsr.l   FILEMGRPATCH
            ble.b   .L1
            move.w  D0,($392).w
            moveq   #-$7F,D0
.L1:
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.b   FSAsync.L3
            cmpi.w  #$FFD5,D0
            bne.b   .L6
            btst    #9,(6,A0)
            beq.b   .L2
            tst.l   ($30,A0)
            bne.b   .L6
.L2:
            btst    #6,($376).w
            bne.b   .L6
            btst    #5,($376).w
            bne.b   .L6
            movea.l ($386).w,A1
            movem.l D1/A2,-(SP)
            move.w  (-2,A1),D1
.L3:
            addq.w  #6,D1
            cmp.w   (A1),D1
            bge.b   .L4
            move.w  (0,A1,D1.w),D0
            beq.b   .L4
            bsr.w   GetVCBRfn
            bne.b   .L4
            move.w  ($48,A2),D0
            ble.b   .L3
.L4:
            move.w  D1,(-2,A1)
            move.w  D1,D0
            movem.l (SP)+,D1/A2
            cmp.w   (A1),D0
            bge.b   .L5
            tst.w   (0,A1,D0.w)
            beq.b   .L5
            moveq   #0,D0
            move.b  (7,A0),D0
            movea.l (8,A0),A1
            jmp     (A1)
.L5:
            moveq   #-$2B,D0
.L6:
            bclr    #5,($376).w
            move.l  ($3E6).w,D2
            ble.b   .L7
            movea.l D2,A1
            jsr     (A1)
.L7:
            move.l  ($3F2).w,D2
            ble.b   .L10
            movea.l D2,A1
            cmpi.w  #$FFC6,D0
            beq.b   .L8
            cmpi.w  #$FFC7,D0
            bne.b   .L10
            clr.l   ($3EE).w
.L8:
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.w   FSAsync.L3
            moveq   #-$3A,D0
            tst.w   (6,A0)
            blt.b   .L9
            moveq   #0,D0
            move.b  (7,A0),D0
            clr.b   (7,A0)
            ori.w   #$A060,(6,A0)
.L9:
            jsr     (A1)
.L10:
            move    SR,-(SP)
            ori     #$700,SR
            clr.w   FSQHdr
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.w   FSAsync.L3
            move.l  (A0),($362).w
            bne.b   .L11
            clr.l   ($366).w
.L11:
            move    (SP)+,SR
            move.w  D0,($10,A0)
            move.l  ($C,A0),D1
            beq.b   .L12
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L12:
            move    SR,-(SP)
            ori     #$700,SR
            tst.l   ($362).w
            bne.w   FSAsync.L1
            move    (SP)+,SR
            rts
FInitQueue:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  ($362).w,D0
            beq.b   .L1
            movea.l D0,A0
            clr.l   (A0)
            move.l  A0,($366).w
.L1:
            moveq   #0,D0
            move    (SP)+,SR
            rts
DSHook:
            movem.l D0-D7/A0-A3/A6,-(SP)
            lea     ($B00).w,A1
            move.w  (6,A0),(A1)+
            move.w  #$4E75,(A1)
            bsr.w   MakeStkPB
            move.l  A0,D7
            movea.l ($3EE).w,A2
            move.w  ($4A,A2),D3
            bpl.b   .L1
            neg.w   D3
            move.w  D3,($16,A0)
            _MountVol
            bne.b   .L1
            moveq   #0,D3
            bra.w   .L15
.L1:
            move.l  #$500078,DSAlertRect
            move.l  #$980195,($3FC).w
            moveq   #0,D4
            moveq   #0,D5
            tst.b   QDExist
            bne.b   .L2
            movea.l (A5),A0
            move.l  (A0),D4
            movea.l ([MainDevice.w]),A0
            movea.l ([$16.w,A0]),A0
            cmpi.w  #1,($20,A0)
            bgt.b   .L2
            move.l  SP,D0
            subi.l  #$12BE,D0
            movea.l ApplZone,A0
            cmp.l   (A0),D0
            ble.b   .L2
            move.l  SP,D5
            addi.l  #$800,D0
            movea.l D0,SP
            move.l  D0,D6
            movea.l SP,A0
            pea     ($E,A0)
            move.l  (SP)+,(A0)+
            move.w  #$24,(A0)+
            clr.l   (A0)+
            move.l  #$48011D,(A0)+
            suba.w  #$74,SP
            movea.l SP,A6
            BigJsr  AllocFakeRgns,A0
            move.l  SP,-(SP)
            _InitPort
            movea.l (A5),A0
            move.l  A6,(A0)
            pea     (-$7A,A0)
            move.l  D6,-(SP)
            pea     DSAlertRect
            movea.l D6,A0
            pea     (6,A0)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
.L2:
            moveq   #$1E,D0
            _SysError
            move.l  ($30A).w,D0
.L3:
            beq.b   .L7
            movea.l D0,A1
            cmp.w   (6,A1),D3
            beq.b   .L4
            move.l  (A1),D0
            bra.b   .L3
.L4:
            move.b  (-3,A1),D0
            cmpi.b  #1,D0
            beq.b   .L5
            cmpi.b  #2,D0
            bne.b   .L7
.L5:
            move.w  D3,D1
.L6:
            moveq   #2,D2
            bsr.w   DoEject
.L7:
            suba.w  #$10,SP
.L8:
            move.w  #$88,D0
            movea.l SP,A0
            _GetOSEvent
            bne.b   .L8
            move.l  (2,SP),D0
            move.w  (SP),D3
            move.w  ($E,SP),D1
            lea     ($10,SP),SP
            subq.w  #7,D3
            beq.b   .L11
            cmpi.b  #$2E,D0
            beq.b   .L10
            moveq   #$B,D2
            lsr.w   #8,D1
            and.b   D1,D2
            subq.b  #3,D2
            bne.b   .L7
            moveq   #-$33,D1
            add.b   D0,D1
            addq.b  #3,D1
            bcc.b   .L7
            ext.w   D1
            bne.b   .L9
            moveq   #3,D1
.L9:
            moveq   #1,D2
            movea.l ($7DC).w,A0
            jsr     (A0)
            bra.b   .L7
.L10:
            btst    #8,D1
            beq.b   .L7
            bra.b   .L12
.L11:
            movea.l D7,A0
            move.w  D0,($16,A0)
            move.w  D0,D1
            _MountVol
            beq.b   .L12
            cmpi.w  #$FF94,D0
            bne.b   .L6
            moveq   #-1,D3
.L12:
            tst.l   D5
            beq.b   .L13
            move.l  D6,-(SP)
            movea.l (A5),A0
            move.l  A6,(A0)
            pea     (-$7A,A0)
            movea.l D6,A0
            pea     (6,A0)
            pea     DSAlertRect
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l D5,SP
            bra.b   .L14
.L13:
            clr.b   DSWndUpdate
            tst.l   D4
            beq.b   .L15
.L14:
            move.l  D4,-(SP)
            _SetPort
.L15:
            bset    #7,DSAlertRect
            lea     ($40,SP),SP
            tst.w   D3
            movem.l (SP)+,D0-D7/A0-A3/A6
            beq.b   .L16
            moveq   #-$35,D0
            rts
.L16:
            bra.l   DSHOOKPATCH
            jmp     ($B00).w
            ori.b   #$A0,($B00).w
            move.b  #$60,($B01).w
            andi.w  #$FF,D0
            jmp     ($B00).w
DoEject:
vDoEject:
            bsr.w   MakeStkPB
            move.w  D1,($16,A0)
            move.l  EjectNotify,D0
            ble.b   .L1
            movem.l D2/A0-A2,-(SP)
            clr.w   -(SP)
            move.w  D1,-(SP)
            move.w  D2,-(SP)
            movea.l D0,A0
            jsr     (A0)
            tst.b   (SP)+
            movem.l (SP)+,D2/A0-A2
            beq.b   .L2
.L1:
            _Eject
            beq.b   .L2
            move.w  #8,-(SP)
            _SysBeep
.L2:
            lea     ($40,SP),SP
            rts
InitFS:
            tst.w   FSFCBLen
            bpl.w   .L5
            move.w  #$5E,FSFCBLen
            lea     FileVars,A0
            moveq   #$50,D1
.L1:
            clr.w   (A0)+
            dbra    D1,.L1
            move.w  #2,($34C).w
            cmpi.w  #2,MemTop
            ble.b   .L2
            lsl.w   #2,D0
.L2:
            move.w  D0,D2
            mulu.w  #$5E,D0
            addq.w  #2,D0
            move.w  D0,D1
            _NewPtrSysClear
            bne.w   .L6
            move.w  D1,(A0)
            move.l  A0,($34E).w
            mulu.w  #$10,D2
            move.l  D2,D0
            addq.w  #2,D0
            move.w  D0,D1
            _NewPtrSysClear
            bne.w   .L6
            move.w  D1,(A0)
            move.l  A0,($372).w
            BigLea  WDCBSwOS,A2
            movea.w (A2),A2
            adda.l  SwitcherTPtr,A2
            move.l  A0,(A2)
            not.l   (A2)+
            move.w  D1,(A2)
            move.l  #$510,D0
            _NewPtrSysClear
            bne.b   .L6
            lea     ($500,A0),A0
            move.l  A0,($36A).w
            moveq   #$38,D0
            _NewPtrSysClear
            bne.b   .L6
            BigLea  PMSPSwOS,A2
            movea.w (A2),A2
            adda.l  SwitcherTPtr,A2
            move.l  A0,(A2)
            not.l   (A2)
            addq.l  #6,A0
            moveq   #$32,D0
            move.w  D0,(A0)
            move.l  A0,($386).w
            move.w  #$200,D1
            moveq   #1,D0
            jsr     InitCache
            bne.b   .L6
            move.l  A1,($378).w
            moveq   #1,D0
            cmpi.w  #2,MemTop
            ble.b   .L3
            moveq   #2,D0
.L3:
            jsr     InitCache
            bne.b   .L6
            move.l  A1,($37C).w
            moveq   #4,D0
            cmpi.w  #2,MemTop
            ble.b   .L4
            moveq   #$10,D0
.L4:
            jsr     InitCache
            bne.b   .L6
            move.l  A1,($380).w
            lea     DSHook,A0
            move.l  A0,($3EA).w
.L5:
            moveq   #0,D0
            rts
.L6:
            moveq   #-1,D0
            rts
DivUp:
            divu.w  D1,D0
            swap    D0
            tst.w   D0
            beq.b   .L1
            clr.w   D0
            swap    D0
            addq.w  #1,D0
            bra.b   .L2
.L1:
            swap    D0
.L2:
            rts
RoundAlloc:
            move.l  D1,-(SP)
            move.l  D0,-(SP)
            move.l  D1,D0
            move.l  ($1C,A2),D1
            bsr.b   DivUp
            move.l  D0,D1
            move.l  (SP)+,D0
            move.l  D1,-(SP)
            move.l  ($1C,A2),D1
            bsr.b   DivUp
            move.l  (SP)+,D1
            bsr.b   DivUp
            mulu.w  D1,D0
            move.l  (SP)+,D1
            rts
QWordSearch:
            move.l  D2,-(SP)
            move.l  (2,A0),D2
.L1:
            beq.b   .L4
            movea.l D2,A0
            cmp.w   (0,A0,D1.w),D0
            beq.b   .L2
            move.l  (A0),D2
            bra.b   .L1
.L2:
            moveq   #0,D0
.L3:
            move.l  (SP)+,D2
            tst.w   D0
            rts
.L4:
            moveq   #-1,D0
            bra.b   .L3
GetVCBRfn:
            movem.l D1/A0,-(SP)
            moveq   #$4E,D1
            lea     ($356).w,A0
            bsr.b   QWordSearch
            bne.b   .L2
            movea.l A0,A2
.L1:
            movem.l (SP)+,D1/A0
            rts
.L2:
            moveq   #-$23,D0
            bra.b   .L1
GetVCBDrv:
            movem.l D1-D2,-(SP)
            move.w  D0,D1
            move.w  D0,D2
            neg.w   D2
            movea.l ($358).w,A2
.L1:
            move.l  A2,D0
            beq.b   .L5
            cmp.w   ($48,A2),D1
            beq.b   .L3
            tst.w   ($48,A2)
            bne.b   .L2
            cmp.w   ($4A,A2),D2
            beq.b   .L3
.L2:
            movea.l (A2),A2
            bra.b   .L1
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1-D2
            rts
.L5:
            moveq   #-$23,D0
            bra.b   .L4
sub_4080F4FA:
            movea.l ($372).w,A3
            movem.l D1/A1,-(SP)
            moveq   #0,D1
            move.w  D0,D1
            bsr.w   sub_40810604
            bne.b   .L1
            subi.w  #$8001,D1
            adda.w  D1,A3
            moveq   #-$23,D0
            move.l  (A3),D1
            beq.b   .L1
            movea.l D1,A2
            moveq   #0,D0
.L1:
            movem.l (SP)+,D1/A1
            tst.w   D0
            rts
MarkVCB:
            bsr.b   sub_4080F52E
MarkVCBTime:
            move.l  TimeLM,($E,A2)
            rts
sub_4080F52E:
            st      (6,A2)
            rts
FlushMDB:
            move.l  ($6D0).w,-(SP)
            rts
vFlushMDB:
            move.l  (SP)+,-(A6)
            movem.l D0-D2/A0-A1,-(A6)
            tst.b   (6,A2)
            bpl.w   .L1
            movea.l ($54,A2),A1
            move.w  ($4E,A2),D0
            moveq   #0,D1
            moveq   #2,D2
            jsr     GetBlock
            bne.w   .L1
            movea.l A0,A1
            lea     (8,A2),A0
            move.l  #$A2,D0
            _BlockMove
            lea     ($5E,A2),A0
            lea     ($40,A1),A1
            moveq   #$42,D0
            _BlockMove
            suba.w  #$40,A1
            movea.l ($34E).w,A3
            move.w  ($A4,A2),D1
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($26,A3,D1.w),A0
            lea     ($86,A1),A1
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  ($C,A3,D1.w),D0
            move.l  D0,($82,A1)
            bclr    #7,(4,A3,D1.w)
            move.l  ($1C,A2),D1
            jsr     DivUp
            move.w  D0,($A0,A2)
            move.w  ($A6,A2),D1
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($26,A3,D1.w),A0
            lea     ($96,A1),A1
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  ($C,A3,D1.w),D0
            move.l  D0,($92,A1)
            bclr    #7,(4,A3,D1.w)
            move.l  ($1C,A2),D1
            jsr     DivUp
            move.w  D0,($A2,A2)
            moveq   #1,D1
            movea.l A1,A0
            movea.l ($54,A2),A1
            jsr     RelBlock
            clr.b   (6,A2)
.L1:
            movem.l (A6)+,D0-D2/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
MakeStkPB:
            movea.l (SP)+,A0
            moveq   #$1F,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            move.l  A0,-(SP)
            movea.l SP,A0
            addq.w  #4,A0
            rts
MountVol:
            move.w  ($16,A0),D2
            movem.l D1-D2/A0-A1,-(SP)
            bsr.b   sub_4080F65E
            movem.l (SP)+,D1-D2/A0-A1
            cmpi.w  #$FF94,D0
            beq.b   .L1
            cmpi.w  #$FFD6,D0
            beq.b   .L1
            rts
.L1:
            move.w  D2,($16,A0)
.L2:
            move.l  ($358).w,D0
.L3:
            beq.b   .L6
            movea.l D0,A1
            tst.w   ($4C,A1)
            bne.b   .L4
            move.w  ($48,A1),D2
            bne.b   .L5
.L4:
            move.l  (A1),D0
            bra.b   .L3
.L5:
            move.l  A0,-(SP)
            bsr.b   MakeStkPB
            move.w  D2,($16,A0)
            _OffLine
            lea     ($40,SP),SP
            movea.l (SP)+,A0
            bne.b   .L2
            bra.b   MountVol
.L6:
            moveq   #-$6C,D0
            rts
sub_4080F65E:
            bsr.w   FSQueueSync
            st      ($34A).w
.L1:
            moveq   #-$32,D0
            move.w  ($16,A0),D2
            ble.b   .L2
            move.w  D2,D0
            bsr.w   GetVCBDrv
            bne.b   .L3
            tst.w   ($48,A2)
            beq.b   .L3
            moveq   #-$37,D0
.L2:
            bra.w   vCheckRemount.L15
.L3:
            bsr.w   FindDrive
            bne.b   .L2
            movea.l A0,A2
            move.l  #$B2,D0
            _NewPtrSysClear
            bne.b   .L2
            lea     ($356).w,A1
            tst.l   (2,A1)
            bne.b   .L4
            move.l  A0,($352).w
            movea.l ($372).w,A1
            move.l  A0,(2,A1)
            moveq   #2,D0
            move.l  D0,(6,A1)
            clr.l   ($A,A1)
            clr.l   ($E,A1)
            lea     ($356).w,A1
.L4:
            jsr     QStuff
            exg     A0,A2
            move.w  D2,($48,A2)
            move.w  D1,($4A,A2)
            movea.l ($37C).w,A1
            move.l  A1,($54,A2)
            moveq   #0,D0
.L5:
            subq.w  #1,D0
            movem.l D0/A2,-(SP)
            bsr.w   GetVCBRfn
            movem.l (SP)+,D0/A2
            beq.b   .L5
            move.w  D0,($4E,A2)
            cmpa.l  ($352).w,A2
            bne.b   .L6
            move.w  D0,($384).w
.L6:
            moveq   #0,D1
            moveq   #2,D2
            jsr     GetBlock
            bne.w   vCheckRemount.L20
            movea.l A0,A5
            moveq   #2,D1
            jsr     RelBlock
            cmpi.w  #$4244,(A5)
            beq.b   .L7
            moveq   #-$39,D0
            cmpi.w  #$D2D7,(A5)
            bne.w   vCheckRemount.L20
.L7:
            moveq   #-$3C,D0
            move.l  ($14,A5),D1
            beq.w   vCheckRemount.L19
            andi.w  #$1FF,D1
            bne.w   vCheckRemount.L19
            lea     (8,A2),A1
            moveq   #$40,D0
            _BlockMove
            movea.l ($362).w,A0
            move.w  ($4E,A2),($16,A0)
            lea     ($3A4).w,A0
            move.w  #8,($1A,A0)
            clr.b   ($1E,A0)
            _Status
            moveq   #-$80,D0
            and.b   ($1E,A0),D0
            move.b  D0,($13,A2)
            bsr.w   TFSVCBTst
            bne.w   sub_40810604.L4
            lea     ($40,A5),A0
            lea     ($5E,A2),A1
            moveq   #$42,D0
            _BlockMove
            move.l  ($1C,A2),D1
            move.l  ($82,A5),D0
            jsr     DivUp
            move.w  D0,($A0,A2)
            move.l  ($92,A5),D0
            jsr     DivUp
            move.w  D0,($A2,A2)
            clr.w   ($18,A2)
            addq.l  #1,($64,A2)
            bsr.w   FindFCB
            bne.w   vCheckRemount.L18
            move.w  D1,($A4,A2)
            move.l  ($82,A5),(8,A1,D1.w)
            move.l  ($82,A5),($C,A1,D1.w)
            moveq   #$C,D0
            lea     ($86,A5),A0
            lea     ($26,A1,D1.w),A1
            _BlockMove
            bsr.w   FindFCB
            bne.w   vCheckRemount.L18
            move.w  D1,($A6,A2)
            move.l  ($92,A5),(8,A1,D1.w)
            move.l  ($92,A5),($C,A1,D1.w)
            moveq   #$C,D0
            lea     ($96,A5),A0
            lea     ($26,A1,D1.w),A1
            _BlockMove
            move.l  ($378).w,($50,A2)
            move.l  ($380).w,($A8,A2)
            move.w  ($A4,A2),D0
            moveq   #3,D1
            move.l  ($68,A2),D2
            movea.l ($A8,A2),A1
            lea     FXMKeyCmp,A3
            bsr.w   AccessBT
            bne.w   vCheckRemount.L17
            move.w  ($A6,A2),D0
            moveq   #4,D1
            move.l  ($6C,A2),D2
            movea.l ($A8,A2),A1
            lea     CMKEYCMP,A3
            bsr.w   AccessBT
            bne.w   vCheckRemount.L17
            bclr    #8,($12,A2)
            beq.w   vCheckRemount.L23
.L8:
            move.l  ($6C0).w,-(SP)
            rts
vCheckRemount:
            move.l  ($358).w,D0
.L1:
            beq.w   .L14
            movea.l D0,A4
            cmpa.l  A4,A2
            beq.b   .L3
            move.w  (8,A4),D0
            cmp.w   (8,A2),D0
            bne.b   .L3
            move.l  ($A,A4),D0
            cmp.l   ($A,A2),D0
            bne.b   .L3
            lea     ($2C,A4),A1
            lea     ($2C,A2),A3
            moveq   #$D,D0
.L2:
            cmpm.w  (A1)+,(A3)+
            dbne    D0,.L2
            bne.b   .L3
            tst.w   (A1)
            beq.b   .L4
.L3:
            move.l  (A4),D0
            bra.b   .L1
.L4:
            bsr.w   sub_408108C6
.L5:
            cmpa.l  ($14,A1,D1.w),A4
            bne.w   .L11
            bsr.w   TFSVCBTst
            beq.b   .L9
            move.w  ($1C,A1,D1.w),D3
            bsr.w   sub_40811A50
            bne.b   .L3
            moveq   #0,D0
            move.l  (0,A1,D1.w),D3
.L6:
            cmp.l   ($12,A5,D0.w),D3
            beq.b   .L7
            bsr.w   sub_40810C92
            bcs.b   .L6
            bra.b   .L3
.L7:
            lea     ($16,A5,D0.w),A3
            btst    #1,(4,A1,D1.w)
            beq.b   .L8
            lea     ($20,A5,D0.w),A3
.L8:
            move.w  (A3)+,D0
            cmp.w   (6,A1,D1.w),D0
            bne.b   .L3
            move.l  (A3)+,D0
            bra.b   .L10
.L9:
            move.l  (0,A1,D1.w),D0
            cmpi.l  #$10,D0
            bcs.b   .L11
            movem.l D2/A0-A1,-(A6)
            move.l  ($3A,A1,D1.w),D0
            lea     ($3E,A1,D1.w),A0
            moveq   #0,D2
            jsr     CMGetCN
            movea.l A1,A3
            movem.l (A6)+,D2/A0-A1
            bne.b   .L3
            cmpi.b  #2,(A3)
            bne.b   .L3
            move.l  ($1A,A3),D0
            btst    #1,(4,A1,D1.w)
            beq.b   .L10
            move.l  ($24,A3),D0
.L10:
            cmp.l   (8,A1,D1.w),D0
            bne.w   .L3
.L11:
            bsr.w   sub_408108CE
            bcs.w   .L5
            clr.b   ($34A).w
            move.w  ($4E,A4),D1
            lea     (8,A2),A0
            lea     (8,A4),A1
            moveq   #$56,D0
            bsr.w   TFSVCBTst
            bne.b   .L12
            move.w  #$AA,D0
.L12:
            _BlockMove
            move.w  D1,($4E,A4)
            bsr.w   TFSVCBTst
            bne.b   .L13
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D0
            move.l  A4,($14,A1,D0.w)
            move.w  ($A6,A2),D0
            move.l  A4,($14,A1,D0.w)
.L13:
            bsr.w   sub_4080FCA0
            movea.l A2,A0
            movea.l A4,A2
            lea     ($356).w,A1
            jsr     DequeueTrap
            _DisposPtr
            movea.l ($362).w,A0
            move.w  ($4E,A2),($16,A0)
.L14:
            moveq   #0,D0
.L15:
            tst.w   D0
            bne.b   .L16
            bsr.w   TFSVCBTst
            bne.b   .L16
            btst    #7,($13,A2)
            bne.b   .L16
            bsr.w   sub_4080F52E
            bsr.w   FlushMDB
.L16:
            bra.w   CmdDone
.L17:
            move.w  D0,($392).w
            moveq   #-$3C,D0
.L18:
            bsr.w   DsposFCBs
.L19:
            bsr.w   DsposVBlks
.L20:
            tst.b   ($34A).w
            beq.b   .L22
            bsr.w   DsposVCB
.L21:
            tst.w   D0
            ble.w   CmdDone
            movea.l ($362).w,A0
            bra.w   sub_4080F65E.L1
.L22:
            lea     ($48,A2),A2
            move.w  (A2),D3
            clr.w   (A2)+
            move.w  D3,(A2)+
            addq.w  #4,A2
            clr.l   (A2)+
            clr.l   (A2)+
            bra.b   .L21
.L23:
            move.l  ($6BC).w,-(SP)
            rts
VMTCHECK:
            moveq   #2,D0
            moveq   #0,D2
            movea.l D2,A0
            jsr     CMGetCN
            bne.b   vCheckRemount.L17
            moveq   #0,D0
            lea     (6,A0),A1
            move.b  (A1)+,D0
            swap    D0
            lea     ($2C,A2),A0
            move.b  (A0)+,D0
            swap    D0
            _CmpString case,marks
            beq.b   .L5
            subq.l  #1,A1
            subq.l  #1,A0
            moveq   #0,D0
            move.b  (A0),D0
            beq.b   .L2
            cmpi.w  #$1B,D0
            ble.b   .L1
            move.b  #$1B,(A0)
.L1:
            moveq   #2,D0
            movea.l A0,A1
            suba.l  A0,A0
            moveq   #0,D2
            jsr     CMRenameCN
            bne.w   vCheckRemount.L17
            bra.b   .L5
.L2:
            moveq   #0,D0
            move.b  (A1),D0
            beq.w   vCheckRemount.L17
            cmpi.w  #$1B,D0
            ble.b   .L3
            moveq   #$1B,D0
.L3:
            move.b  D0,(A0)+
            subq.w  #1,D0
            addq.l  #1,A1
.L4:
            move.b  (A1)+,(A0)+
            dbra    D0,.L4
.L5:
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            lea     ($26,A1,D1.w),A0
            bsr.w   sub_4080FB84
            move.w  ($A6,A2),D1
            lea     ($26,A1,D1.w),A0
            bsr.w   sub_4080FB84
            moveq   #2,D0
            suba.l  A0,A0
            jsr     CMGetCN
            bne.w   vCheckRemount.L17
            movea.l ($34E).w,A1
            move.w  ($A6,A2),D1
            move.l  ($C,A1,D1.w),D0
            moveq   #$46,D1
            bsr.w   DivUp
            move.l  D0,D2
            moveq   #$F,D4
            moveq   #0,D3
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
.L6:
            subq.l  #1,D2
            blt.w   vCheckRemount.L17
            move.w  ($A6,A2),D0
            moveq   #1,D1
            move.l  D2,-(A6)
            jsr     BTGetRecord
            move.l  (A6)+,D2
            tst.w   D0
            bne.b   .L11
            cmpi.b  #1,(A1)
            bne.b   .L8
            addq.l  #1,D6
            cmpi.l  #2,(2,A0)
            bne.b   .L7
            swap    D7
            addq.w  #1,D7
            swap    D7
.L7:
            cmp.l   (6,A1),D4
            bcc.b   .L6
            move.l  (6,A1),D4
            bra.b   .L6
.L8:
            cmpi.b  #2,(A1)
            bne.b   .L6
            addq.l  #1,D5
            cmpi.l  #2,(2,A0)
            bne.b   .L9
            addq.w  #1,D7
.L9:
            cmp.l   ($14,A1),D4
            bcc.b   .L10
            move.l  ($14,A1),D4
.L10:
            lea     ($4A,A1),A0
            bsr.w   sub_4080FB84
            lea     ($56,A1),A0
            bsr.w   sub_4080FB84
            bra.b   .L6
.L11:
            cmpi.w  #$20,D0
            bne.w   vCheckRemount.L17
            cmp.l   ($26,A2),D4
            bcs.b   .L12
            addq.l  #1,D4
            move.l  D4,($26,A2)
            bset    #0,($13,A2)
            moveq   #-1,D3
.L12:
            cmp.l   ($72,A2),D5
            beq.b   .L13
            move.l  D5,($72,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L13:
            cmp.l   ($76,A2),D6
            beq.b   .L14
            move.l  D6,($76,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L14:
            cmp.w   ($14,A2),D7
            beq.b   .L15
            move.w  D7,($14,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L15:
            swap    D7
            cmp.w   ($70,A2),D7
            beq.b   .L16
            move.w  D7,($70,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L16:
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            move.l  ($C,A1,D1.w),D0
            moveq   #$C,D1
            bsr.w   DivUp
            move.l  D0,D5
            move.w  ($A4,A2),D0
            subq.w  #8,A6
            movea.l A6,A0
            move.w  #$700,(A0)
            clr.l   (2,A0)
            clr.w   (6,A0)
            moveq   #0,D2
            jsr     BTSEARCH
            addq.w  #8,A6
            moveq   #0,D1
.L17:
            subq.l  #1,D5
            blt.w   vCheckRemount.L17
            move.w  ($A4,A2),D0
            jsr     BTGetRecord
            bne.b   .L18
            movea.l A1,A0
            bsr.b   sub_4080FB84
            moveq   #1,D1
            bra.b   .L17
.L18:
            cmpi.w  #$20,D0
            bne.w   vCheckRemount.L17
            jsr     UpdateFree
            bra.w   sub_4080F65E.L8
sub_4080FB84:
            move.l  ($7C0).w,-(SP)
            rts
vBMChk:
            move.l  (SP)+,-(A6)
            bsr.w   CVFlgs
            bne.b   .L1
            jsr     BLKCHK
            beq.b   .L1
            moveq   #-1,D3
            bset    #2,($13,A2)
.L1:
            move.l  (A6)+,-(SP)
            rts
DsposFCBs:
            movem.l D0-D1/A1,-(SP)
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            beq.b   .L1
            clr.l   (0,A1,D1.w)
.L1:
            move.w  ($A6,A2),D1
            beq.b   .L2
            clr.l   (0,A1,D1.w)
.L2:
            movem.l (SP)+,D0-D1/A1
            rts
DsposVCB:
            move.l  D0,-(SP)
            bsr.w   sub_40810CB8
.L1:
            bne.b   .L2
            clr.l   (0,A1,D1.w)
            clr.l   (4,A1,D1.w)
            bsr.w   sub_40810CC0
            bra.b   .L1
.L2:
            movea.l A2,A0
            lea     ($356).w,A1
            jsr     DequeueTrap
            cmpa.l  ($352).w,A2
            bne.b   .L3
            clr.l   ($352).w
            clr.w   ($384).w
.L3:
            _DisposPtr
            move.l  (SP)+,D0
            rts
DsposVBlks:
            move.l  A1,-(SP)
            movea.l ($378).w,A1
            jsr     TrashVBlks
            movea.l ($37C).w,A1
            jsr     TrashVBlks
            movea.l ($380).w,A1
            jsr     TrashVBlks
            movea.l (SP)+,A1
            rts
FindFCB:
            bsr.w   sub_408108C6
            bra.b   .L2
.L1:
            tst.l   (0,A1,D1.w)
            bne.b   .L2
            moveq   #-1,D0
            move.l  D0,(0,A1,D1.w)
            moveq   #0,D0
            bra.b   .L3
.L2:
            bsr.w   sub_408108CE
            bcs.b   .L1
            moveq   #-$2A,D0
.L3:
            rts
AccessBT:
            move.l  (SP)+,-(A6)
            movem.l D3/A0,-(A6)
            movea.l ($34E).w,A0
            lea     (0,A0,D0.w),A0
            clr.w   (4,A0)
            clr.w   (6,A0)
            clr.l   ($10,A0)
            move.l  D1,(A0)
            move.l  A2,($14,A0)
            move.l  D2,($1E,A0)
            movea.l A3,A0
            jsr     BTOPEN
            movem.l (A6)+,D3/A0
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FindDrive:
            move.l  ($6C8).w,-(SP)
            rts
vFindDrive:
            move.l  A0,-(SP)
            move.w  D2,D0
            lea     DrvQHdr,A0
            moveq   #6,D1
            bsr.w   QWordSearch
            bne.b   .L2
            movea.l A0,A3
            move.w  (8,A0),D1
            move.w  ($A,A0),D0
            beq.b   .L1
            moveq   #-$3A,D0
.L1:
            movea.l (SP)+,A0
            rts
.L2:
            moveq   #-$38,D0
            bra.b   .L1
Offline:
            st      NoEject
            bra.w   Eject_2.L1
sub_4080FCA0:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            clr.b   FlushOnly
            bra.b   FlushBuffers.L3
FlushBuffers:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            bsr.w   TFSVCBTst
            bne.b   .L3
            tst.b   FlushOnly
            bne.b   .L1
            bsr.w   CVFlgs
            bne.b   .L1
            bset    #8,($12,A2)
            bsr.w   sub_4080F52E
.L1:
            jsr     FlushMDB
            movea.l ($34E).w,A1
            move.w  ($A6,A2),D1
            bsr.w   sub_40811AA2
            bne.b   .L5
            tst.b   FlushOnly
            bne.b   .L2
            clr.w   ($A6,A2)
.L2:
            move.w  ($A4,A2),D1
            bsr.w   sub_40811AA2
            bne.b   .L5
            tst.b   FlushOnly
            bne.b   .L3
            clr.w   ($A6,A2)
.L3:
            moveq   #0,D1
            st      ($377).w
            movea.l ($378).w,A1
            move.w  ($4E,A2),D0
            jsr     FlushCache
            movea.l ($380).w,A1
            move.w  ($4E,A2),D0
            jsr     FlushCache
            movea.l ($37C).w,A1
            move.w  ($4E,A2),D0
            jsr     FlushCache
            tst.b   FlushOnly
            bne.b   .L4
            bsr.w   DsposVBlks
.L4:
            moveq   #0,D0
.L5:
            movem.l (A6)+,D1-D2/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
Eject_2:
            clr.b   NoEject
.L1:
            bsr.w   FSQueueSync
            bsr.w   DtrmV3
            bne.b   .L2
            bsr.w   sub_4080FEFA
            bne.b   .L4
            bra.b   .L5
.L2:
            move.w  ($16,A0),D2
.L3:
            bsr.w   FindDrive
            bne.b   .L4
            tst.b   NoEject
            beq.w   .L11
.L4:
            bra.w   CmdDone
.L5:
            lea     ($48,A2),A1
            move.w  (A1),D2
            bne.b   .L6
            move.w  (2,A1),D2
            bpl.b   .L4
            tst.b   NoEject
            bne.b   .L4
            neg.w   D2
            neg.w   (2,A1)
            bra.b   .L3
.L6:
            bsr.w   FindDrive
            bne.b   .L4
            tst.b   NoEject
            bne.b   .L7
            cmpi.b  #8,(-3,A3)
            blt.b   .L7
            st      NoEject
            cmpi.b  #$40,(-3,A3)
            blt.b   .L7
            move.b  #1,NoEject
.L7:
            st      FlushOnly
            bsr.w   sub_4080FE80
            bsr.w   TFSVCBTst
            bne.b   .L8
            clr.b   FlushOnly
            bsr.w   FlushBuffers
            bra.b   .L9
.L8:
            bsr.w   MFSFlush
            bsr.w   sub_408106CA
            bsr.w   DsposVBlks
.L9:
            clr.w   (A1)+
            tst.b   NoEject
            beq.b   .L10
            neg.w   D2
.L10:
            move.w  D2,(A1)+
            tst.b   NoEject
            beq.b   .L11
            movea.l A2,A0
            lea     ($356).w,A1
            bsr.l   DequeueTrap
            bsr.l   QStuff
            tst.b   NoEject
            bmi.w   .L4
.L11:
            lea     ($3A4).w,A0
            lea     ($16,A0),A1
            move.w  D2,(A1)+
            move.w  D1,(A1)+
            move.w  #7,(A1)
            lea     CmdDone,A1
            move.l  A1,($C,A0)
            _Control async
            rts
UnmountVol:
            bsr.w   FSQueueSync
            clr.b   FlushOnly
            bsr.w   DtrmV3
            bne.w   FlushVol.L5
            moveq   #0,D0
            btst    #9,(6,A0)
            bne.w   FlushVol.L1
            movem.l D1-D2/A1,-(SP)
            movea.l ($34E).w,A1
            moveq   #2,D1
.L1:
            move.l  (0,A1,D1.w),D2
            beq.b   .L3
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L3
            cmpi.w  #$D2D7,(8,A2)
            beq.b   .L2
            cmpi.l  #$10,D2
            bcs.b   .L3
            cmpi.w  #$4244,(8,A2)
            bne.b   .L2
            cmpi.l  #'GRT ',D2
            beq.b   .L3
.L2:
            moveq   #-$2F,D0
            bra.b   .L4
.L3:
            add.w   FSFCBLen,D1
            cmp.w   (A1),D1
            bcs.b   .L1
.L4:
            movem.l (SP)+,D1-D2/A1
            tst.w   D0
            bne.b   FlushVol.L5
            bra.b   FlushVol.L1
sub_4080FE80:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            bsr.w   sub_408108C6
.L1:
            tst.l   (0,A1,D1.w)
            beq.b   .L3
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L3
            bsr.w   TFSVCBTst
            bne.b   .L2
            cmpi.l  #$10,(0,A1,D1.w)
            bcs.b   .L3
.L2:
            bsr.w   sub_40811AA2
            bne.b   .L4
.L3:
            bsr.w   sub_408108CE
            bcs.b   .L1
            moveq   #0,D0
.L4:
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FlushVol:
            bsr.w   FSQueue
            st      FlushOnly
            bsr.b   DtrmV3
            bne.b   .L5
.L1:
            bsr.b   sub_4080FEFA
            bne.b   .L5
            bsr.b   sub_4080FE80
            bne.b   .L5
            bsr.w   TFSVCBTst
            beq.b   .L2
            bsr.w   MFSFlush
            bra.b   .L5
.L2:
            tst.w   ($48,A2)
            beq.b   .L3
            bsr.w   FlushBuffers
            bne.b   .L5
.L3:
            tst.b   FlushOnly
            bne.b   .L4
            bsr.w   DsposVCB
.L4:
            moveq   #0,D0
.L5:
            bra.w   CmdDone
sub_4080FEFA:
            move.l  ($7B8).w,-(SP)
            rts
vCkExtFS:
            move.w  ($4C,A2),D0
            beq.b   .L1
            moveq   #-$3A,D0
.L1:
            rts
DtrmV3:
            move.l  ($7BC).w,-(SP)
            rts
vDtrmV3:
            move.l  ($12,A0),D2
            movea.l D2,A4
            beq.b   DtrmV1
            tst.b   (A4)
            bne.w   AddSPEntry.L6
DtrmV1:
            move.l  ($778).w,-(SP)
            rts
vDtrmV1:
            moveq   #0,D3
            suba.l  A3,A3
            move.w  ($16,A0),D0
            beq.b   .L5
            bmi.b   .L1
            bsr.w   GetVCBDrv
            bra.b   .L3
.L1:
            cmpi.w  #$F000,D0
            ble.b   .L2
            bsr.w   GetVCBRfn
            bra.b   .L3
.L2:
            bsr.w   sub_4080F4FA
.L3:
            beq.b   .L6
.L4:
            moveq   #-$23,D0
            rts
.L5:
            move.l  ($352).w,D0
            beq.b   .L4
            movea.l D0,A2
            movea.l ($372).w,A3
            addq.l  #2,A3
.L6:
            moveq   #0,D0
            move.l  A2,($3EE).w
            btst    #6,($376).w
            bne.b   .L7
            btst    #5,($376).w
            beq.b   .L10
.L7:
            move.l  A4,-(SP)
            movea.l ($386).w,A4
            addq.l  #2,A4
            moveq   #$17,D0
.L8:
            clr.w   (A4)+
            dbra    D0,.L8
            movea.l (SP)+,A4
.L9:
            moveq   #0,D0
            rts
.L10:
            btst    #9,(6,A0)
            beq.b   .L11
            tst.l   ($30,A0)
            bne.b   .L9
.L11:
            movem.l D2/D4/A1/A4,-(SP)
            movea.l ($386).w,A4
            move.w  (-2,A4),D4
            bgt.b   .L16
            moveq   #2,D4
            move.w  ($4E,A2),D2
            move.l  A3,D0
            beq.b   .L12
            move.l  (4,A3),D0
            bra.b   .L13
.L12:
            moveq   #2,D0
.L13:
            bsr.b   AddSPEntry
            bsr.w   TFSVCBTst
            bne.b   .L15
            move.w  BootDrive,D0
            bge.b   .L14
            cmpi.w  #$F000,D0
            bgt.b   .L14
            bsr.w   sub_4080F4FA
            bne.b   .L14
            cmp.w   ($4E,A2),D2
            bne.b   .L14
            move.l  (4,A3),D0
            bsr.b   AddSPEntry
.L14:
            movea.l ($3EE).w,A2
            move.l  ($7A,A2),D0
            beq.b   .L15
            bsr.b   AddSPEntry
.L15:
            clr.w   (0,A4,D4.w)
            moveq   #2,D4
            move.w  D4,(-2,A4)
            move.l  (-6,A4),D0
            beq.b   .L16
            movea.l D0,A1
            jsr     (A1)
.L16:
            move.w  (0,A4,D4.w),D0
            bsr.w   GetVCBRfn
            bne.b   .L17
            movea.l ($372).w,A3
            lea     ($12,A3),A3
            move.l  A2,(A3)
            move.l  (2,A4,D4.w),(4,A3)
            clr.l   (8,A3)
            clr.l   ($C,A3)
            moveq   #0,D0
.L17:
            movem.l (SP)+,D2/D4/A1/A4
            rts
AddSPEntry:
            move.l  D4,-(SP)
            moveq   #2,D4
.L1:
            cmp.l   (SP),D4
            bcc.b   .L4
            cmp.w   (0,A4,D4.w),D2
            bne.b   .L2
            cmp.l   (2,A4,D4.w),D0
            beq.b   .L3
.L2:
            addq.w  #6,D4
            cmp.w   (A4),D4
            bcs.b   .L1
.L3:
            moveq   #0,D0
.L4:
            move.l  (SP)+,D4
            tst.l   D0
            beq.b   .L5
            move.w  D2,(0,A4,D4.w)
            move.l  D0,(2,A4,D4.w)
            addq.w  #6,D4
.L5:
            rts
.L6:
            move.l  ($12,A0),D2
sub_40810056:
            move.l  ($6C4).w,-(SP)
            rts
vDtrmV2:
            movem.l D4-D6/A0-A1,-(SP)
            tst.l   D2
            beq.b   .L5
            movea.l D2,A4
            moveq   #0,D2
            movea.l D2,A3
            move.b  (A4)+,D2
            beq.b   .L5
            moveq   #0,D3
.L1:
            move.b  (0,A4,D3.w),D4
            cmpi.b  #$3A,D4
            beq.b   .L2
            addq.w  #1,D3
            cmp.w   D3,D2
            bne.b   .L1
            bra.b   .L3
.L2:
            sub.l   D3,D2
            subq.w  #1,D2
            movea.l A4,A1
            adda.l  D3,A4
            addq.l  #1,A4
            tst.w   D3
            bgt.b   .L6
.L3:
            bsr.w   DtrmV1
.L4:
            movem.l (SP)+,D4-D6/A0-A1
            tst.w   D0
            rts
.L5:
            moveq   #-$25,D0
            bra.b   .L4
.L6:
            move.l  ($358).w,D0
.L7:
            beq.b   .L9
            movea.l D0,A2
            lea     ($2C,A2),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.w  D3,D0
            _CmpString
            bne.b   .L8
            move.l  A2,($3EE).w
            bra.b   .L4
.L8:
            move.l  (A2),D0
            bne.b   .L7
.L9:
            moveq   #-$23,D0
            bra.b   .L4
            bsr.w   FSQueue
            move.l  ($1C,A0),D0
            bmi.b   .L10
            movea.l ($386).w,A1
            move.l  D0,(-6,A1)
.L10:
            move.w  ($1A,A0),D0
            bclr    #6,($376).w
            btst    #0,D0
            bne.b   .L11
            bset    #6,($376).w
.L11:
            moveq   #0,D0
            bra.w   CmdDone
GetVolInfo:
            bsr.w   FSQueue
            move.w  ($1C,A0),D2
            bgt.b   .L3
            beq.b   .L1
            bsr.w   DtrmV3
            bra.b   .L2
.L1:
            bsr.w   DtrmV1
.L2:
            bne.w   .L22
            bra.b   .L5
.L3:
            moveq   #0,D3
            clr.w   ($16,A0)
            move.l  ($358).w,D1
.L4:
            beq.w   GetVol.L2
            subq.w  #1,D2
            movea.l D1,A2
            beq.b   .L5
            move.l  (A2),D1
            bra.b   .L4
.L5:
            moveq   #$20,D0
.L6:
            move.w  ($A,A2,D0.w),($1E,A0,D0.w)
            subq.w  #2,D0
            bpl.b   .L6
            bset    #6,($27,A0)
            bsr.w   sub_408108C6
.L7:
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L8
            bsr.w   TFSVCBTst
            bne.b   .L9
            move.l  (0,A1,D1.w),D0
            cmpi.l  #$10,D0
            bcc.b   .L9
.L8:
            bsr.w   sub_408108CE
            bcs.b   .L7
            bclr    #6,($27,A0)
.L9:
            bclr    #5,($27,A0)
            cmpa.l  ($352).w,A2
            bne.b   .L10
            bset    #5,($27,A0)
.L10:
            suba.l  A3,A3
            tst.w   ($1C,A0)
            bgt.b   .L14
            tst.w   D3
            bne.b   .L14
            move.w  ($16,A0),D1
            bgt.b   .L14
            blt.b   .L11
            moveq   #2,D1
            bra.b   .L12
.L11:
            cmpi.w  #$F000,D1
            bgt.b   .L14
            subi.w  #$8001,D1
.L12:
            movea.l ($372).w,A3
            adda.w  D1,A3
            bsr.w   ExtOffLinCk
            bne.b   .L14
            movem.l A0-A1,-(A6)
            movea.l ($372).w,A1
            move.l  (4,A1,D1.w),D0
            cmpi.l  #2,D0
            beq.b   .L13
            move.l  (8,A1,D1.w),D2
            suba.l  A0,A0
            jsr     CMGetCN
            bne.b   .L13
            move.w  (4,A1),D0
            movem.l (A6)+,A0-A1
            move.w  D0,($28,A0)
            bra.b   .L14
.L13:
            movem.l (A6)+,A0-A1
.L14:
            tst.w   D3
            bne.b   .L15
            tst.w   ($16,A0)
            blt.b   .L16
.L15:
            move.w  ($4E,A2),($16,A0)
.L16:
            bsr.w   XferVName
            bsr.w   TFSVCBTst
            bne.b   .L17
            move.w  ($A0,A2),D0
            sub.w   D0,($2E,A0)
            move.w  ($A2,A2),D0
            sub.w   D0,($2E,A0)
.L17:
            btst    #9,(6,A0)
            bne.b   .L19
            move.w  #$7C00,D0
            cmp.w   ($2E,A0),D0
            bhi.b   .L18
            move.w  D0,($2E,A0)
            cmp.w   ($3E,A0),D0
            bhi.b   .L18
            move.w  D0,($3E,A0)
.L18:
            bra.b   .L20
.L19:
            move.w  ($4E,A2),($16,A0)
            move.w  (8,A2),($40,A0)
            move.w  ($48,A2),($42,A0)
            move.w  ($4A,A2),($44,A0)
            move.w  ($4C,A2),($46,A0)
            clr.l   ($52,A0)
            move.w  ($14,A2),($54,A0)
            clr.l   ($56,A0)
            move.w  #1,($58,A0)
            bsr.w   TFSVCBTst
            bne.b   .L21
            move.l  ($5E,A2),($48,A0)
            move.w  ($62,A2),($4C,A0)
            move.l  ($64,A2),($4E,A0)
            move.l  ($72,A2),($52,A0)
            move.l  ($76,A2),($56,A0)
            move.l  A0,-(SP)
            lea     ($5A,A0),A1
            lea     ($7A,A2),A0
            moveq   #$20,D0
            _BlockMove
            movea.l (SP)+,A0
.L20:
            move.l  A2,($3EE).w
            bsr.w   TFSVCBTst
            bne.b   .L21
            bsr.w   sub_4080FEFA
            bne.b   .L22
.L21:
            moveq   #0,D0
.L22:
            bra.w   CmdDone
SetVolInfo:
            bsr.w   FSQueue
            bsr.w   DtrmV1
            bne.b   .L3
            bsr.w   CVFlgs
            bne.b   .L3
            bsr.w   ExtOffLinCk
            bne.b   .L3
            move.l  ($1E,A0),($A,A2)
            move.l  ($22,A0),($E,A2)
            move.w  ($26,A0),D0
            andi.w  #$8000,D0
            move.w  ($12,A2),D1
            andi.w  #$7FFF,D1
            or.w    D0,D1
            move.w  D1,($12,A2)
            bsr.w   TFSVCBTst
            bne.b   .L1
            move.l  ($34,A0),($20,A2)
            move.l  ($48,A0),($5E,A2)
            move.w  ($4C,A0),($62,A2)
            move.l  A0,-(SP)
            lea     ($5A,A0),A0
            lea     ($7A,A2),A1
            moveq   #$20,D0
            _BlockMove
            movea.l (SP)+,A0
.L1:
            move.l  ($12,A0),D0
            beq.b   .L2
            movea.l D0,A1
            bsr.b   SetVolName
.L2:
            bsr.w   MarkVCB
            moveq   #0,D0
.L3:
            bra.w   CmdDone
SetVolName:
            movem.l A1-A2,-(SP)
            lea     ($2C,A2),A2
            moveq   #1,D0
.L1:
            cmp.b   (A1),D0
            bgt.b   .L2
            cmpi.b  #$3A,(0,A1,D0.w)
            beq.b   .L2
            cmpi.b  #$1B,D0
            bgt.b   .L2
            move.b  (0,A1,D0.w),(0,A2,D0.w)
            addq.w  #1,D0
            bra.b   .L1
.L2:
            subq.w  #1,D0
            move.b  D0,(A2)
            movem.l (SP)+,A1-A2
            bsr.w   MarkVCB
            rts
CVFlgs:
            moveq   #-$2E,D0
            tst.w   ($12,A2)
            bmi.b   .L1
            moveq   #-$2C,D0
            tst.b   ($13,A2)
            bmi.b   .L1
            moveq   #0,D0
.L1:
            rts
GetVol:
            btst    #9,D1
            bne.w   GetDir
            bsr.w   FSQueue
            move.l  ($352).w,D0
            beq.b   .L2
            movea.l D0,A2
            move.w  ($384).w,($16,A0)
            bsr.b   XferVName
.L1:
            bra.w   CmdDone
.L2:
            moveq   #-$23,D0
            bra.b   .L1
XferVName:
            movem.l A1-A2,-(SP)
            lea     ($2C,A2),A2
            move.l  ($12,A0),D0
            beq.b   .L2
            _StripAddress
            movea.l D0,A1
            moveq   #0,D0
            move.b  (A2),D0
.L1:
            move.b  (A2)+,(A1)+
            dbra    D0,.L1
.L2:
            movem.l (SP)+,A1-A2
            moveq   #0,D0
            rts
SetVol:
            btst    #9,D1
            bne.b   SetDir
            bsr.w   FSQueue
            bsr.w   DtrmV3
            bne.b   .L4
            move.w  ($4E,A2),D0
            tst.w   D3
            bne.b   .L1
            tst.w   ($16,A0)
            bgt.b   .L1
            move.w  ($16,A0),D0
            beq.b   .L2
.L1:
            move.w  D0,($384).w
.L2:
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L3
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L3:
            bsr.w   sub_40810474
            moveq   #0,D0
.L4:
            bra.w   CmdDone
SetDir:
            bsr.w   FSQueue
            bsr.w   FndFilName
            beq.b   .L1
            cmpi.w  #$FFDB,D0
            bne.b   .L3
            tst.b   D2
            bne.b   .L3
            moveq   #2,D6
            bra.b   .L2
.L1:
            moveq   #-$78,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            move.l  (6,A5),D6
.L2:
            move.w  ($4E,A2),($384).w
            moveq   #0,D7
            bsr.b   sub_40810474
            moveq   #0,D0
.L3:
            bra.w   CmdDone
GetDir:
            bsr.w   FSQueue
            bsr.w   sub_40810CA8
            moveq   #-$23,D0
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            bsr.w   RetDefInfo
            bsr.w   XferVName
            move.w  ($384).w,($16,A0)
            moveq   #0,D0
.L1:
            bra.w   CmdDone
OpenWD:
            bsr.w   FSQueue
            bsr.w   FndFilName
            beq.b   .L1
            cmpi.w  #$FFDB,D0
            bne.b   .L3
            tst.b   D2
            bne.b   .L3
            bra.b   .L2
.L1:
            moveq   #-$78,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            move.l  (6,A5),D6
            cmpi.l  #2,D6
            beq.b   .L2
            moveq   #0,D7
            bsr.b   sub_40810498
            bra.b   .L3
.L2:
            move.w  ($4E,A2),($16,A0)
            moveq   #0,D0
.L3:
            bra.w   CmdDone
sub_40810474:
            move.l  A2,($352).w
            moveq   #2,D1
FillWDCB:
            movea.l ($372).w,A1
            move.l  A2,(0,A1,D1.w)
            move.l  D6,(4,A1,D1.w)
            move.l  D7,(8,A1,D1.w)
            move.l  ($1C,A0),D0
            move.l  D0,($C,A1,D1.w)
            addi.w  #$8001,D1
            rts
sub_40810498:
            move.l  ($1C,A0),D3
            moveq   #0,D2
            bsr.w   sub_40810CA8
            bsr.w   sub_40810CB0
.L1:
            bsr.w   sub_40810CB0
            bcc.b   .L3
            tst.l   (0,A1,D1.w)
            bne.b   .L2
            tst.w   D2
            bne.b   .L1
            move.w  D1,D2
            bra.b   .L1
.L2:
            cmpa.l  (0,A1,D1.w),A2
            bne.b   .L1
            cmp.l   (4,A1,D1.w),D6
            bne.b   .L1
            cmp.l   ($C,A1,D1.w),D3
            bne.b   .L1
            addi.w  #$8001,D1
            bra.b   .L4
.L3:
            move.w  D2,D1
            beq.b   .L5
            bsr.b   FillWDCB
.L4:
            move.w  D1,($16,A0)
            moveq   #0,D0
            rts
.L5:
            moveq   #-$79,D0
            rts
CloseWD:
            bsr.w   FSQueue
            moveq   #0,D1
            move.w  ($16,A0),D1
            bsr.w   sub_40810604
            beq.b   .L1
            cmpi.w  #$F000,D1
            bhi.b   .L3
            bra.b   .L4
.L1:
            subi.w  #$8001,D1
            movea.l (0,A1,D1.w),A2
            tst.w   ($4C,A2)
            beq.b   .L2
            move.l  A2,($3EE).w
            add.l   A1,D1
            moveq   #-$3A,D0
            bra.b   .L4
.L2:
            clr.l   (0,A1,D1.w)
.L3:
            moveq   #0,D0
.L4:
            bra.w   CmdDone
GetWDInfo:
            bsr.w   FSQueue
            bsr.b   GetWDCBInfo
            bne.b   .L1
            ext.l   D1
            add.l   A1,D1
            move.l  A2,($3EE).w
            bsr.w   sub_4080FEFA
            bne.b   .L1
            moveq   #0,D0
.L1:
            bra.w   CmdDone
GetWDCBInfo:
            tst.w   ($1A,A0)
            bgt.b   .L2
            moveq   #0,D1
            move.w  ($16,A0),D1
            bsr.w   sub_40810604
            beq.b   .L1
            bsr.w   DtrmV1
            bne.b   .L9
            clr.l   ($1C,A0)
            moveq   #2,D0
            move.l  D0,($30,A0)
            move.w  ($4E,A2),($20,A0)
            move.w  ($4E,A2),($16,A0)
            moveq   #0,D1
            bra.b   .L8
.L1:
            moveq   #-$23,D0
            subi.w  #$8001,D1
            tst.l   (0,A1,D1.w)
            beq.b   .L9
            bra.b   .L7
.L2:
            moveq   #-$23,D0
            moveq   #0,D2
            tst.w   ($16,A0)
            beq.b   .L3
            bsr.w   DtrmV3
            bne.b   .L9
            move.l  A2,D2
.L3:
            move.w  ($1A,A0),D4
            move.l  ($1C,A0),D3
            moveq   #-$23,D0
            bsr.w   sub_40810CA8
            bsr.w   sub_40810CB0
.L4:
            bsr.w   sub_40810CB0
            bcc.b   .L9
            tst.l   (0,A1,D1.w)
            beq.b   .L4
            tst.l   D3
            beq.b   .L5
            cmp.l   ($C,A1,D1.w),D3
            bne.b   .L4
.L5:
            tst.l   D2
            beq.b   .L6
            cmp.l   (0,A1,D1.w),D2
            bne.b   .L4
.L6:
            subq.w  #1,D4
            bgt.b   .L4
.L7:
            bsr.b   sub_408105E2
.L8:
            bsr.w   XferVName
.L9:
            tst.w   D0
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   GetWDCBInfo
            movem.l (SP)+,D3-D7/A1-A6
            move.w  D0,($10,A0)
            rts
sub_408105E2:
            move.l  ($C,A1,D1.w),($1C,A0)
RetDefInfo:
            movea.l (0,A1,D1.w),A2
            move.w  ($4E,A2),($20,A0)
            move.l  (4,A1,D1.w),($30,A0)
            move.w  D1,D0
            addi.w  #$8001,D0
            move.w  D0,($16,A0)
            rts
sub_40810604:
            move.l  D1,-(SP)
            moveq   #-$33,D0
            subi.w  #$8001,D1
            movea.l ($372).w,A1
            cmp.w   (A1),D1
            bcc.b   .L1
            subq.w  #2,D1
            divu.w  #$10,D1
            swap    D1
            tst.w   D1
            bne.b   .L1
            move.l  (SP),D1
            subi.w  #$8001,D1
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            moveq   #0,D0
.L1:
            move.l  (SP)+,D1
            tst.w   D0
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   DtrmV1
            bne.b   .L3
            move.l  ($30,A0),D6
            moveq   #0,D7
            bsr.w   sub_40810498
            bne.b   .L3
            move.w  D1,($16,A0)
.L2:
            moveq   #0,D0
.L3:
            movem.l (SP)+,D3-D7/A1-A6
            move.w  D0,($10,A0)
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   DtrmV1
            bne.b   .L3
            move.w  ($4E,A2),($384).w
            move.l  ($30,A0),D6
            moveq   #0,D7
            bsr.w   sub_40810474
            bra.b   .L2
.L4:
            moveq   #$5E,D0
            movea.l A2,A0
            _SetPtrSize
            moveq   #3,D2
            mulu.w  ($1A,A2),D2
            addq.l  #1,D2
            lsr.l   #1,D2
            move.w  D2,($58,A2)
            moveq   #$40,D7
            move.l  D2,D0
            _NewPtrSys
            bne.w   vCheckRemount.L19
            move.l  A0,($50,A2)
            moveq   #2,D3
.L5:
            move.w  (0,A5,D7.w),(A0)+
            addq.w  #2,D7
            subq.w  #2,D2
            ble.b   .L6
            cmpi.w  #$200,D7
            bcs.b   .L5
            addq.w  #1,D3
            bsr.w   sub_40811A5E
            bne.b   .L8
            moveq   #0,D7
            bra.b   .L5
.L6:
            bsr.b   CkMFSMap
            beq.b   CkMFSMap.L4
.L7:
            moveq   #-$3C,D0
.L8:
            bsr.b   sub_408106CA
            bra.w   vCheckRemount.L19
sub_408106CA:
            movem.l D0/A0,-(SP)
            movea.l ($50,A2),A0
            _DisposPtr
            clr.l   ($50,A2)
            movem.l (SP)+,D0/A0
            rts
CkMFSMap:
            moveq   #2,D3
            moveq   #0,D1
.L1:
            bsr.w   GtNxBlk
            bne.b   .L2
            addq.w  #1,D1
.L2:
            cmp.w   ($1A,A2),D3
            bhi.b   .L3
            addq.w  #1,D3
            bra.b   .L1
.L3:
            cmp.w   ($2A,A2),D1
            rts
.L4:
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D7
            bsr.w   sub_40811A30
            bne.b   sub_40810604.L8
.L5:
            tst.b   (A5)
            bne.b   .L6
            movea.l A5,A0
            exg     D1,D6
            moveq   #2,D1
            jsr     RelBlock
            exg     D1,D6
.L6:
            moveq   #0,D0
.L7:
            tst.b   (0,A5,D0.w)
            beq.b   .L9
            addq.w  #1,D1
            cmp.l   ($12,A5,D0.w),D2
            bhi.b   .L8
            move.l  ($12,A5,D0.w),D2
.L8:
            lea     ($16,A5,D0.w),A3
            bsr.b   CkFilLen
            bne.b   sub_40810604.L7
            lea     ($20,A5,D0.w),A3
            bsr.b   CkFilLen
            bne.b   sub_40810604.L7
            bsr.w   sub_40810C92
            bcs.b   .L7
.L9:
            bsr.w   sub_40811A40
            beq.b   .L5
            cmpi.w  #$FFDF,D0
            bne.w   sub_40810604.L8
            cmp.l   ($26,A2),D2
            bcs.b   .L10
            addq.l  #1,D2
            move.l  D2,($26,A2)
            addq.b  #1,D7
.L10:
            cmp.w   ($14,A2),D1
            beq.b   .L11
            move.w  D1,($14,A2)
            addq.b  #2,D7
.L11:
            tst.b   D7
            beq.b   .L12
            bsr.w   CVFlgs
            bne.b   .L12
            bsr.w   MarkVCB
.L12:
            or.b    D7,($13,A2)
            bra.w   sub_4080F65E.L8
CkFilLen:
            movem.l D0-D6,-(SP)
            move.w  ($1A,A2),D1
            moveq   #0,D6
            move.l  ($1C,A2),D2
            move.w  (A3),D3
            beq.b   .L2
.L1:
            bsr.w   GtNxBlk
            subq.w  #1,D1
            bcs.b   .L6
            move.w  D5,D3
            beq.b   .L2
            add.l   D2,D6
            cmpi.w  #1,D3
            bne.b   .L1
.L2:
            move.w  (A3)+,D3
            move.l  (A3)+,D4
            move.l  (A3)+,D5
            cmp.l   D5,D6
            beq.b   .L5
            move.l  D6,-(A3)
            bne.b   .L3
            clr.w   D3
.L3:
            cmp.l   D6,D4
            bls.b   .L4
            move.l  D6,D4
.L4:
            move.l  D4,-(A3)
            move.w  D3,-(A3)
            bsr.w   CVFlgs
            bne.b   .L6
            jsr     MarkA5Block
            bset    #2,D7
.L5:
            moveq   #0,D1
.L6:
            movem.l (SP)+,D0-D6
            rts
MFSFlush:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            tst.w   ($48,A2)
            beq.b   .L5
            tst.b   (6,A2)
            bpl.b   .L4
            bsr.w   CkMFSMap
            bne.b   .L4
            moveq   #2,D3
            bsr.w   MFSMapRead
            bne.b   .L8
            jsr     MarkA5Block
            moveq   #$1F,D0
            movea.l A5,A1
            lea     (8,A2),A0
            move.l  TimeLM,($E,A2)
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            movea.l ($50,A2),A0
            move.w  ($58,A2),D2
            moveq   #$40,D7
.L2:
            move.w  (A0)+,(0,A5,D7.w)
            addq.w  #2,D7
            subq.w  #2,D2
            ble.b   .L3
            cmpi.w  #$200,D7
            bcs.b   .L2
            addq.w  #1,D3
            bsr.w   MFSMapRead
            bne.b   .L8
            jsr     MarkA5Block
            moveq   #0,D7
            bra.b   .L2
.L3:
            cmpi.w  #$200,D7
            bcc.b   .L4
            clr.w   (0,A5,D7.w)
            addq.w  #2,D7
            bra.b   .L3
.L4:
            bsr.w   FlushBuffers
            bne.b   .L8
.L5:
            clr.b   (6,A2)
            tst.b   FlushOnly
            bne.b   .L7
            tst.w   ($48,A2)
            beq.b   .L6
            bsr.w   sub_408106CA
.L6:
            bsr.w   DsposVCB
.L7:
            moveq   #0,D0
.L8:
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            bsr.w   FSQueue
            move.w  ($1C,A0),D2
            bgt.b   .L11
            beq.b   .L9
            bsr.w   DtrmV3
            bra.b   .L10
.L9:
            bsr.w   DtrmV1
.L10:
            bne.b   .L17
            bra.b   .L13
.L11:
            move.l  ($358).w,D1
.L12:
            beq.w   GetVol.L2
            subq.w  #1,D2
            movea.l D1,A2
            beq.b   .L13
            move.l  (A2),D1
            bra.b   .L12
.L13:
            bset    #6,($13,A2)
            bsr.b   sub_408108C6
.L14:
            cmpa.l  ($14,A1,D1.w),A2
            beq.b   .L15
            bsr.b   sub_408108CE
            bcs.b   .L14
            bclr    #6,($13,A2)
.L15:
            moveq   #$20,D0
.L16:
            move.w  ($A,A2,D0.w),($1E,A0,D0.w)
            subq.w  #2,D0
            bpl.b   .L16
            bsr.w   XferVName
.L17:
            bra.w   CmdDone
sub_408108C6:
            movea.l ($34E).w,A1
            moveq   #2,D1
            rts
sub_408108CE:
            add.w   FSFCBLen,D1
            cmp.w   (A1),D1
            rts
Gt1stMatch:
            bsr.b   sub_408108C6
.L1:
            cmp.l   (0,A1,D1.w),D2
            bne.b   GtNxtMatch
            cmpa.l  ($14,A1,D1.w),A2
            beq.b   GtNxtMatch.L1
GtNxtMatch:
            bsr.b   sub_408108CE
            bcs.b   Gt1stMatch.L1
            move    #0,CCR
.L1:
            rts
OpenRF:
            bsr.w   FSQueue
            clr.b   ($347).w
            bra.b   vFileOpen.L1
FileOpen:
            move.l  ($784).w,-(SP)
            rts
vFileOpen:
            bsr.w   FSQueue
            st      ($347).w
.L1:
            bsr.b   sub_408108C6
.L2:
            tst.l   (0,A1,D1.w)
            beq.b   .L5
            bsr.b   sub_408108CE
            bcs.b   .L2
            moveq   #-$2A,D0
.L3:
            clr.w   ($18,A0)
.L4:
            bra.w   CmdDone
.L5:
            move.w  D1,($18,A0)
            add.l   A1,D1
            bsr.w   FndFilName
            bne.b   .L3
            move.l  A0,-(SP)
            movea.l D1,A0
            moveq   #0,D0
            move.w  FSFCBLen,D0
            lsr.w   #1,D0
            subq.w  #1,D0
.L6:
            clr.w   (A0)+
            dbra    D0,.L6
            movea.l (SP)+,A0
            bsr.w   TFSVCBTst
            bne.w   sub_40810B96.L2
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   .L3
            movea.l D1,A3
            move.l  D7,($36,A3)
            move.l  (4,A5),D0
            move.l  D0,($32,A3)
            move.l  D6,($3A,A3)
            moveq   #0,D0
            move.w  ($48,A5),D0
            beq.b   .L7
            mulu.w  ($1E,A2),D0
            bset    #6,(4,A3)
            bra.b   .L8
.L7:
            move.l  ($20,A2),D0
            bclr    #6,(4,A3)
.L8:
            move.l  D0,($1E,A3)
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($4A,A5),A0
            tst.b   ($347).w
            bne.b   .L9
            lea     ($56,A5),A0
.L9:
            lea     ($26,A3),A1
            _BlockMove
            moveq   #0,D0
            move.w  D2,D0
            movea.l A4,A0
            lea     ($3E,A3),A1
            move.b  D0,(A1)+
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  A0,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            lea     ($3E,A3),A0
            jsr     CMGetCN
            beq.w   .L10
            movea.l (A6)+,A0
            bmi.w   .L3
            moveq   #-$2B,D0
            bra.w   .L3
.L10:
            movea.l A1,A5
            lea     (6,A0),A0
            lea     ($3E,A3),A1
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            _BlockMove
            movea.l (A6)+,A0
            clr.w   D7
            move.w  (2,A5),D3
            andi.w  #$100,D3
            beq.b   .L11
            bset    #$D,D3
.L11:
            lea     ($14,A5),A5
            move.l  (A5)+,D2
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
            tst.b   ($347).w
            bne.b   .L12
            bset    #9,D3
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
.L12:
            bsr.b   sub_40810A74
            beq.b   .L14
            moveq   #0,D1
            move.w  FSFCBLen,D1
            lsr.w   #1,D1
            subq.w  #1,D1
.L13:
            clr.w   (A3)+
            dbra    D1,.L13
            bra.w   .L4
.L14:
            move.l  D2,(A3)+
            move.w  D3,(A3)+
            move.w  D4,(A3)+
            move.l  D5,(A3)+
            move.l  D6,(A3)+
            clr.l   (A3)+
            move.l  A2,(A3)+
            suba.l  A4,A4
            move.l  A4,D0
            nop
            move.l  A4,(A3)+
            move.w  D7,(A3)+
            addq.l  #4,A3
            clr.l   (A3)+
            bset    #7,(5,A2)
            move.w  ($18,A0),D4
            bsr.w   Gt1stMatch
.L15:
            cmp.w   D1,D4
            beq.b   .L16
            move.b  (4,A1,D1.w),D5
            move.b  D5,D6
            eor.b   D3,D6
            lsr.b   #2,D6
            bcc.b   .L17
.L16:
            bsr.w   GtNxtMatch
            beq.b   .L15
            bra.b   .L18
.L17:
            jsr     sub_40811E64
            move.b  D5,(4,A1,D1.w)
.L18:
            moveq   #0,D0
            bra.w   CmdDone
sub_40810A74:
            move.l  ($788).w,-(SP)
            rts
vPermssnChk:
            cmpi.b  #1,($1B,A0)
            beq.b   .L3
            bset    #8,D3
            beq.b   .L1
            tst.b   ($1B,A0)
            beq.b   .L3
            clr.w   ($18,A0)
            moveq   #-$36,D0
            bra.b   .L4
.L1:
            btst    #2,($1B,A0)
            beq.b   .L2
            bset    #$C,D3
.L2:
            bra.b   .L5
.L3:
            bclr    #8,D3
            moveq   #0,D0
.L4:
            rts
.L5:
            bsr.w   Gt1stMatch
.L6:
            bne.b   .L9
            move.w  (4,A1,D1.w),D0
            eor.w   D3,D0
            andi.w  #$300,D0
            bne.b   .L7
            btst    #$C,D3
            beq.b   .L8
            btst    #4,(4,A1,D1.w)
            beq.b   .L8
.L7:
            bsr.w   GtNxtMatch
            bra.b   .L6
.L8:
            move.w  D1,($18,A0)
            moveq   #-$31,D0
            bra.b   .L10
.L9:
            moveq   #0,D0
.L10:
            rts
CreateDir:
            bsr.w   FSQueue
            bset    #1,($376).w
            bra.b   FileCreate.L1
FileCreate:
            bsr.w   FSQueue
            bclr    #1,($376).w
.L1:
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #-$30,D0
            bra.b   .L7
.L2:
            cmpi.w  #$FFD5,D0
            bne.b   .L7
            bsr.w   CVFlgs
            bne.b   .L7
            bsr.w   TFSVCBTst
            beq.b   .L3
            btst    #1,($376).w
            beq.w   sub_40810B96.L6
            moveq   #-$7B,D0
            bra.b   .L7
.L3:
            move.b  ($1A,A0),D1
            swap    D1
            move.b  #2,D1
            btst    #1,($376).w
            beq.b   .L4
            move.b  #1,D1
.L4:
            move.l  A0,-(A6)
            bsr.b   PushCName
            move.w  D2,-(A6)
            move.l  D6,D0
            jsr     CMSvcs
            move.w  (A6)+,D2
            bsr.b   sub_40810B96
            movea.l (A6)+,A0
            tst.w   D0
            beq.b   .L5
            cmpi.w  #$30,D0
            bne.b   .L7
            moveq   #-$78,D0
            bra.b   .L7
.L5:
            btst    #1,($376).w
            beq.b   .L6
            move.l  D1,($30,A0)
.L6:
            moveq   #0,D0
.L7:
            bra.w   CmdDone
PushCName:
            movem.l D0/A1,-(SP)
            suba.l  A0,A0
            tst.w   D2
            beq.b   .L1
            movea.w D2,A0
            addq.w  #1,D2
            bclr    #0,D2
            suba.w  D2,A6
            move.w  D2,-(SP)
            move.w  A0,D2
            movea.l A4,A0
            movea.l A6,A1
            moveq   #0,D0
            move.w  D2,D0
            _BlockMove
            move.w  D2,-(A6)
            move.w  (SP)+,D2
            movea.l A6,A0
            addq.l  #1,A0
.L1:
            movem.l (SP)+,D0/A1
            rts
sub_40810B96:
            tst.w   D2
            beq.b   .L1
            move.w  (A6)+,-(SP)
            adda.w  D2,A6
            move.w  (SP)+,D2
.L1:
            rts
.L2:
            movea.l D1,A3
            move.w  FileVars,D7
            move.w  (A5),D3
            andi.w  #$1FF,D3
            btst    #8,D3
            beq.b   .L3
            bset    #$D,D3
.L3:
            move.l  ($20,A2),($1E,A3)
            lea     ($12,A5),A5
            move.l  (A5)+,D2
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
            tst.b   ($347).w
            bne.b   .L4
            bset    #9,D3
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
.L4:
            bsr.w   sub_40810A74
            bne.b   .L5
            bra.w   vFileOpen.L14
            clr.w   ($18,A0)
.L5:
            bra.w   CmdDone
.L6:
            tst.w   D2
            beq.b   .L8
            move.w  D2,D0
.L7:
            subq.w  #1,D0
            blt.b   .L10
            cmpi.b  #$3A,(0,A4,D0.w)
            bne.b   .L7
.L8:
            moveq   #-$25,D0
.L9:
            bra.w   CmdDone
.L10:
            bsr.b   FndFilSpc
            bne.b   .L9
            move.w  D5,D0
            movea.l A5,A1
.L11:
            clr.w   (A1)+
            subq.w  #2,D0
            bhi.b   .L11
            bset    #7,(A5)
            move.b  ($1A,A0),(1,A5)
            move.l  ($26,A2),($12,A5)
            addq.l  #1,($26,A2)
            lea     ($2A,A5),A5
            move.l  TimeLM,(A5)
            move.l  (A5)+,(A5)+
            move.b  D2,(A5)+
            beq.b   .L13
.L12:
            move.b  (A4)+,(A5)+
            subq.b  #1,D2
            bhi.b   .L12
.L13:
            bsr.w   MarkVCB
            addq.w  #1,($14,A2)
            bsr.b   sub_40810C48
            moveq   #0,D0
            bra.b   .L9
sub_40810C48:
            move.w  ($4E,A2),D0
            movea.l ($380).w,A1
            moveq   #0,D1
            jmp     FlushCache
FndFilSpc:
            movea.l (SP)+,A3
            moveq   #$34,D5
            add.w   D2,D5
            bclr    #0,D5
            bsr.w   sub_40811A30
            bra.b   .L2
.L1:
            bsr.w   sub_40811A40
.L2:
            bne.b   .L5
            moveq   #0,D0
.L3:
            tst.b   (0,A5,D0.w)
            beq.b   .L4
            bsr.b   sub_40810C92
            bcs.b   .L3
.L4:
            move.w  D0,D4
            add.w   D5,D4
            cmpi.w  #$200,D4
            bcc.b   .L1
            jsr     MarkA5Block
            lea     (0,A5,D0.w),A5
            clr.l   ($5A,A2)
            moveq   #0,D0
.L5:
            jmp     (A3)
sub_40810C92:
            moveq   #0,D6
            move.b  ($32,A5,D0.w),D6
            add.w   D6,D0
            addi.w  #$34,D0
            bclr    #0,D0
            cmpi.w  #$1CC,D0
            rts
sub_40810CA8:
            movea.l ($372).w,A1
            moveq   #2,D1
            rts
sub_40810CB0:
            addi.w  #$10,D1
            cmp.w   (A1),D1
            rts
sub_40810CB8:
            bsr.b   sub_40810CA8
.L1:
            cmpa.l  (0,A1,D1.w),A2
            beq.b   sub_40810CC0.L1
sub_40810CC0:
            bsr.b   sub_40810CB0
            bcs.b   sub_40810CB8.L1
            move    #0,CCR
.L1:
            rts
CkDirBusy:
            movem.l D2/A1,-(SP)
            move.l  (6,A5),D2
            bsr.b   sub_40810CB8
.L1:
            bne.b   .L2
            cmp.l   (4,A1,D1.w),D2
            beq.b   .L4
            bsr.b   sub_40810CC0
            bra.b   .L1
.L2:
            moveq   #0,D0
.L3:
            movem.l (SP)+,D2/A1
            rts
.L4:
            move.w  D1,($18,A0)
            moveq   #-$2F,D0
            bra.b   .L3
CkFileBusy:
            move.l  A1,-(SP)
            move.l  ($14,A5),D2
            bsr.w   TFSVCBTst
            beq.b   .L1
            move.l  ($12,A5),D2
.L1:
            bsr.w   Gt1stMatch
            beq.b   .L3
            moveq   #0,D0
.L2:
            movea.l (SP)+,A1
            rts
.L3:
            move.w  D1,($18,A0)
            moveq   #-$2F,D0
            bra.b   .L2
FileDelete:
            bsr.w   FSQueue
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   TFMove.L11
            moveq   #-$2D,D0
            btst    #0,(2,A5)
            bne.b   .L6
            bclr    #1,($376).w
            cmpi.b  #1,(A5)
            bne.b   .L1
            bset    #1,($376).w
            bsr.b   CkDirBusy
            bra.b   .L2
.L1:
            cmpi.b  #2,(A5)
            bne.b   .L3
            move.l  D2,-(A6)
            bsr.b   CkFileBusy
            move.l  (A6)+,D2
            tst.w   D0
.L2:
            bne.b   .L6
.L3:
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D7,D2
            cmpi.b  #2,(A5)
            bne.b   .L4
            move.l  ($14,A5),D0
            jsr     TrashFBlocks
            move.l  D6,D0
            jsr     DeAllocFile
            bne.b   .L6
.L4:
            move.l  D6,D0
            jsr     CMDeleteCN
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            cmpi.w  #$32,D0
            bne.b   .L5
            moveq   #-$2F,D0
            bra.b   .L6
.L5:
            cmpi.w  #$33,D0
            bne.b   .L6
            moveq   #-$32,D0
.L6:
            bra.w   CmdDone
ReName:
            bsr.w   FSQueue
            move.l  ($1C,A0),D2
            bsr.w   sub_40810056
            bne.w   .L13
            tst.w   D2
            beq.w   .L14
            movea.l A2,A1
            move.w  D3,D7
            movem.l D2/A4,($3D6).w
            bsr.w   DtrmV3
            bne.b   .L2
            cmpa.l  A1,A2
            beq.b   .L4
            tst.w   D7
            beq.b   .L4
.L1:
            moveq   #-$25,D0
.L2:
            cmpi.w  #$21,D0
            bne.b   .L3
            moveq   #-$30,D0
.L3:
            bra.w   CmdDone
.L4:
            bsr.w   CVFlgs
            bne.b   .L2
            bsr.w   TFSVCBTst
            bne.w   sub_40811094.L3
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #-$2D,D0
            btst    #0,(2,A5)
            bne.b   .L2
            move.l  D6,D4
            move.l  D7,D5
            movem.l D2/D4-D5/A4,-(A6)
            move.l  ($12,A0),-(A6)
            move.l  ($1C,A0),D2
            move.l  D2,($12,A0)
            bsr.w   FndFilName
            movem.l D2/A4,($3D6).w
            move.l  (A6)+,($12,A0)
            movem.l (A6)+,D2/D4-D5/A4
            tst.w   D0
            bne.b   .L6
            move.l  A0,-(SP)
            movem.l D2/A4,-(A6)
            move.w  D2,D0
            movea.l A4,A0
            swap    D0
            movem.l ($3D6).w,D2/A4
            move.w  D2,D0
            movea.l A4,A1
            _CmpString
            movem.l (A6)+,D2/A4
            movea.l (SP)+,A0
            bne.b   .L5
            cmp.l   D4,D6
            beq.b   .L7
.L5:
            moveq   #-$30,D0
.L6:
            cmpi.w  #$FFD5,D0
            bne.b   .L2
            cmp.l   D4,D6
            bne.w   .L1
.L7:
            bsr.w   PushCName
            move.l  D2,-(SP)
            movea.l A0,A1
            movem.l ($3D6).w,D2/A4
            bsr.w   PushCName
            move.l  (SP)+,-(A6)
            move.l  D2,-(A6)
            exg     A0,A1
            move.l  D4,D0
            move.l  D5,D2
            jsr     CMRenameCN
            move.l  D2,D7
            tst.w   D0
            bne.b   .L9
            cmpi.l  #1,D4
            beq.b   .L8
            cmpi.l  #2,D4
            bne.b   .L9
            tst.l   (4,A6)
            bgt.b   .L9
.L8:
            bsr.w   SetVolName
            moveq   #0,D0
            moveq   #1,D6
.L9:
            move.l  (A6)+,D2
            move.l  (A6)+,-(SP)
            bsr.w   sub_40810B96
            move.l  (SP)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            bne.w   .L2
            cmpi.l  #1,D6
            beq.w   .L2
            movem.l ($3D6).w,D2/A4
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            jsr     CMGetCN
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            bne.w   .L2
            move.b  D2,D3
            movea.l A1,A5
            movea.l A4,A0
            move.l  ($14,A5),D2
            bsr.w   Gt1stMatch
            bne.w   .L2
.L10:
            move.l  D7,($36,A1,D1.w)
            lea     ($3E,A1,D1.w),A1
            move.b  D3,(A1)+
            moveq   #0,D0
            move.b  D3,D0
            _BlockMove
            movea.l ($34E).w,A1
            bsr.w   GtNxtMatch
            beq.b   .L10
.L11:
            moveq   #0,D0
.L12:
            bra.w   .L2
.L13:
            cmpi.w  #$FFDD,D0
            bne.b   .L12
            tst.w   D2
            bne.w   .L1
.L14:
            tst.w   D3
            beq.b   .L12
            bsr.w   DtrmV3
            bne.b   .L12
            bsr.w   CVFlgs
            bne.b   .L12
            cmpi.w  #$4244,(8,A2)
            beq.b   .L15
            tst.w   ($48,A2)
            beq.b   .L12
            bra.b   .L16
.L15:
            bsr.w   ExtOffLinCk
            bne.b   .L12
.L16:
            movea.l ($1C,A0),A1
            bsr.w   SetVolName
            bsr.w   TFSVCBTst
            bne.b   .L11
            moveq   #0,D2
            moveq   #2,D0
            movea.l D2,A0
            lea     ($2C,A2),A1
            jsr     CMRenameCN
            bra.w   .L2
TFMove:
            bsr.w   FSQueue
            move.l  ($12,A0),-(A6)
            move.l  ($1C,A0),($12,A0)
            bsr.w   DtrmV3
            move.l  (A6)+,($12,A0)
            movea.l A2,A1
            move.w  D3,D7
            bsr.w   DtrmV3
            bne.b   .L2
            cmpa.l  A1,A2
            beq.b   .L3
            tst.w   D7
            beq.b   .L3
.L1:
            moveq   #-$25,D0
.L2:
            bra.w   CmdDone
.L3:
            bsr.w   CVFlgs
            bne.b   .L2
            bsr.w   ExtOffLinCk
            bne.b   .L2
            moveq   #-$32,D0
            bsr.w   TFSVCBTst
            bne.b   .L2
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #0,D3
            cmpi.b  #2,(A5)
            bne.b   .L4
            move.l  ($14,A5),D3
.L4:
            move.l  D6,D4
            move.l  D7,D5
            movem.l D2/A4,($3D6).w
            move.l  ($12,A0),-(A6)
            move.l  ($30,A0),-(A6)
            move.l  ($1C,A0),($12,A0)
            move.l  ($24,A0),($30,A0)
            movem.l D3-D5,-(A6)
            bsr.w   FndFilName
            movem.l (A6)+,D3-D5
            move.l  (A6)+,($30,A0)
            move.l  (A6)+,($12,A0)
            tst.w   D0
            beq.b   .L5
            cmpi.w  #$FFDB,D0
            bne.b   .L2
            tst.w   D2
            bne.b   .L1
            bra.b   .L6
.L5:
            cmpi.b  #1,(A5)
            bne.b   .L1
            move.l  (6,A5),D6
            moveq   #0,D7
.L6:
            movem.l ($3D6).w,D2/A4
            cmp.l   D4,D6
            beq.b   .L10
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D3,-(A6)
            move.l  D4,D0
            move.l  D5,D2
            move.l  D6,D1
            move.l  D7,D3
            suba.l  A1,A1
            jsr     CMMoveCN
            move.l  D2,D7
            move.l  (A6)+,D3
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            beq.b   .L8
            cmpi.w  #$31,D0
            bne.b   .L7
            moveq   #-$30,D0
.L7:
            bra.w   .L2
.L8:
            move.l  D3,D2
            beq.b   .L10
            bsr.w   Gt1stMatch
            bne.b   .L10
.L9:
            move.l  D7,($36,A1,D1.w)
            move.l  D6,($3A,A1,D1.w)
            bsr.w   GtNxtMatch
            beq.b   .L9
.L10:
            moveq   #0,D0
            bra.w   .L2
.L11:
            moveq   #-$2D,D0
            btst    #0,(A5)
            bne.b   .L12
            bsr.w   CkFileBusy
            bne.b   .L12
            subq.w  #1,($14,A2)
            bsr.w   MarkVCB
            move.w  ($16,A5),D3
            bsr.w   DAlBlks
            move.w  ($20,A5),D3
            bsr.w   DAlBlks
            move.l  ($12,A5),D0
            bsr.b   sub_40811094
            jsr     TrashFBlocks
            bsr.w   sub_40810C48
            moveq   #0,D0
.L12:
            bra.w   CmdDone
sub_40811084:
            moveq   #0,D0
            move.b  ($32,A5),D0
            addi.w  #$34,D0
            bclr    #0,D0
            rts
sub_40811094:
            movem.l D0/A0-A1/A5,-(SP)
            movea.l A1,A0
            jsr     MarkBlock
            clr.l   ($5A,A2)
            movea.l A5,A0
            bsr.b   sub_40811084
            adda.l  D0,A5
            lea     ($200,A1),A1
.L1:
            cmpa.l  A1,A5
            bcc.b   .L2
            move.w  (A5)+,(A0)+
            bra.b   .L1
.L2:
            clr.w   (A0)+
            cmpa.l  A1,A0
            bcs.b   .L2
            movem.l (SP)+,D0/A0-A1/A5
            rts
.L3:
            move.l  A0,-(SP)
            move.w  D2,D0
            movea.l A4,A0
            movem.l ($3D6).w,D2/A4
            swap    D0
            move.w  D2,D0
            movea.l A4,A1
            _CmpString
            movea.l (SP)+,A0
            beq.b   .L5
            bsr.w   FndFN2
            bne.b   .L4
            moveq   #-$30,D0
.L4:
            cmpi.w  #$FFD5,D0
            bne.b   .L9
.L5:
            bsr.w   FndFilName
            bne.b   .L9
            moveq   #-$2D,D0
            btst    #0,(A5)
            bne.b   .L9
            movea.l A6,A4
            movea.l A5,A3
            bsr.b   sub_40811084
.L6:
            move.w  (-2,A3,D0.w),-(A6)
            subq.w  #2,D0
            bgt.b   .L6
            bsr.b   sub_40811094
            move.l  ($3D6).w,D2
            bsr.w   FndFilSpc
            bne.b   .L10
            movea.l A5,A3
            moveq   #$18,D0
.L7:
            move.w  (A6)+,(A5)+
            dbra    D0,.L7
            movea.l A4,A6
            movem.l ($3D6).w,D2/A4
            move.b  D2,(A5)+
.L8:
            move.b  (A4)+,(A5)+
            subq.w  #1,D2
            bgt.b   .L8
            bsr.b   sub_40811156
            bsr.w   MarkVCBTime
            bsr.w   sub_40810C48
            moveq   #0,D0
.L9:
            bra.w   CmdDone
.L10:
            move.b  ($32,A6),D2
            bsr.w   FndFilSpc
            beq.b   .L11
            movea.l A4,A6
            moveq   #-$3B,D0
            bra.b   .L9
.L11:
            movea.l A5,A3
.L12:
            move.w  (A6)+,(A5)+
            cmpa.l  A6,A4
            bne.b   .L12
            bsr.b   sub_40811156
            moveq   #-$21,D0
            bra.b   .L9
sub_40811156:
            move.l  ($12,A3),D2
            move.w  FileVars,D0
            bsr.w   Gt1stMatch
            bne.b   .L2
.L1:
            move.w  D0,($1C,A1,D1.w)
            bsr.w   GtNxtMatch
            beq.b   .L1
.L2:
            rts
SetFilType:
            bsr.w   FSQueue
            move.b  ($1A,A0),D1
            move.b  ($1C,A0),($1A,A0)
            bsr.w   FndFilName
            move.b  D1,($1A,A0)
            tst.w   D0
            bne.b   .L1
            bsr.w   TFSVCBTst
            beq.b   .L2
            moveq   #-$30,D0
.L1:
            cmpi.w  #$FFD5,D0
            bne.b   RstFilLock.L5
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L33
.L2:
            moveq   #-$32,D0
            bra.b   RstFilLock.L5
SetFilLock:
            bsr.w   FSQueue
            st      ($348).w
            bra.b   RstFilLock.L1
RstFilLock:
            bsr.w   FSQueue
            clr.b   ($348).w
.L1:
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L34
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   .L5
            tst.b   ($348).w
            beq.b   .L2
            bset    #0,(2,A5)
            bne.b   .L4
            bra.b   .L3
.L2:
            bclr    #0,(2,A5)
            beq.b   .L4
.L3:
            move.l  D7,D2
            jsr     CMUpdateCN
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            bra.w   CmdDone
SetFileInfo:
            bsr.w   FSQueue
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L38
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   RstFilLock.L5
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,(4,A5)
            movem.l ($48,A0),D1-D2
            movem.l D1-D2,($2C,A5)
            bra.b   RstFilLock.L3
SetCatInfo:
            bsr.w   FSQueue
            bsr.b   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L38
            cmpi.b  #2,(A5)
            bne.b   .L1
            movem.l ($20,A0),D0-D3
            movem.l D0-D3,(4,A5)
            movem.l ($54,A0),D0-D3
            movem.l D0-D3,($38,A5)
            movem.l ($48,A0),D0-D1
            movem.l D0-D1,($2C,A5)
            move.l  ($50,A0),($34,A5)
            bra.b   .L2
.L1:
            moveq   #-$25,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,($16,A5)
            movem.l ($54,A0),D0-D3
            movem.l D0-D3,($26,A5)
            movem.l ($48,A0),D0-D2
            movem.l D0-D2,($A,A5)
.L2:
            moveq   #0,D0
.L3:
            bra.w   RstFilLock.L3
CkFilMod:
            move.l  (SP)+,-(A6)
            bsr.b   FndFilName
            bne.b   .L1
            bsr.w   CVFlgs
            bne.b   .L1
            move.l  (A6)+,-(SP)
            rts
.L1:
            addq.w  #4,A6
            bra.w   CmdDone
FndFilName:
            move.l  ($78C).w,-(SP)
            rts
vFndFilName:
            bsr.w   DtrmV3
            beq.b   .L2
.L1:
            rts
.L2:
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L3
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L3:
            move.l  A4,D0
            beq.b   .L4
            sub.l   ($12,A0),D0
            subq.l  #2,D0
            bgt.b   FndFN2
.L4:
            btst    #9,(6,A0)
            beq.b   FndFN2
            move.l  ($30,A0),D0
            beq.b   FndFN2
            move.l  D0,D6
            moveq   #0,D7
FndFN2:
            bsr.w   ExtOffLinCk
            bne.b   vFndFilName.L1
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L39
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            move.l  D2,D1
            move.l  D2,D4
.L1:
            moveq   #-$78,D0
            moveq   #0,D1
.L2:
            moveq   #0,D3
            cmp.w   D4,D1
            bge.b   .L5
            cmpi.b  #$3A,(0,A4,D1.w)
            beq.b   .L4
            cmpi.w  #$1F,D1
            blt.b   .L3
            moveq   #-$25,D0
            bra.w   .L11
.L3:
            addq.w  #1,D1
            bra.b   .L2
.L4:
            bset    #5,($376).w
            tst.w   D1
            seq     D3
            swap    D3
            move.w  D4,D3
            sub.w   D1,D3
            subq.w  #1,D3
            bgt.b   .L6
.L5:
            moveq   #-$2B,D0
.L6:
            swap    D3
            movem.l D6-D7,-(A6)
            movem.l D0/A1,-(SP)
            movea.l D1,A0
            addq.w  #1,D1
            lsr.w   #1,D1
            lsl.w   #1,D1
            suba.l  D1,A6
            move.l  D1,-(SP)
            move.l  A0,D1
            movea.l A4,A0
            movea.l A6,A1
            move.l  D1,D0
            _BlockMove
            move.w  D1,-(A6)
            move.l  (SP)+,D1
            movea.l A6,A0
            addq.l  #1,A0
            movem.l (SP)+,D0/A1
            exg     D6,D0
            move.l  D7,D2
            jsr     CMGetCN
            move.w  (A6)+,-(SP)
            adda.l  D1,A6
            moveq   #0,D1
            move.w  (SP)+,D1
            tst.w   D0
            bne.b   .L9
            tst.b   D3
            beq.b   .L7
            moveq   #-$78,D0
            cmpi.l  #1,(2,A0)
            beq.b   .L9
            move.l  (2,A0),D0
            moveq   #0,D2
            suba.l  A0,A0
            jsr     CMGetCN
            bne.b   .L9
            move.l  (2,A0),D0
            moveq   #0,D2
.L7:
            cmpi.w  #$FFD5,D6
            beq.b   .L8
            movem.l (A6)+,D6-D7
            move.l  (6,A1),D6
            move.l  D2,D7
            addq.w  #1,D1
            adda.l  D1,A4
            sub.w   D1,D4
            bra.w   .L1
.L8:
            moveq   #0,D0
            movea.l A1,A5
            move.l  D2,(4,A6)
            bra.b   .L10
.L9:
            cmpi.w  #$30,D0
            bne.b   .L10
            move.l  D6,D0
.L10:
            movem.l (A6)+,D6-D7
            move.l  D1,D2
.L11:
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtOffLinCk:
            bsr.w   sub_4080FEFA
            bne.b   .L1
            tst.w   ($48,A2)
            bne.b   .L1
            moveq   #-$35,D0
.L1:
            move.l  A2,($3EE).w
            tst.w   D0
            rts
GetCatInfo:
            bsr.w   FSQueue
            bset    #0,($376).w
            tst.w   ($1C,A0)
            bmi.b   GetFileInfo.L3
            bra.b   GetFileInfo.L1
GetFileInfo:
            bsr.w   FSQueue
            bclr    #0,($376).w
.L1:
            move.w  ($1C,A0),D1
            bgt.b   .L4
            bsr.w   FndFilName
            beq.b   .L2
            cmpi.w  #$FFDB,D0
            bne.w   .L17
            tst.b   D2
            bne.w   .L17
            btst    #0,($376).w
            bne.b   .L7
            bra.w   .L17
.L2:
            bsr.w   TFSVCBTst
            bne.w   .L57
            move.l  D6,D1
            bra.w   .L21
.L3:
            moveq   #0,D1
.L4:
            bset    #5,($376).w
            bsr.w   DtrmV1
            bne.w   .L17
            bsr.b   ExtOffLinCk
            bne.w   .L17
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L5
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L5:
            btst    #9,(6,A0)
            beq.b   .L6
            tst.l   ($30,A0)
            beq.b   .L6
            move.l  ($30,A0),D6
            moveq   #0,D7
.L6:
            bsr.w   TFSVCBTst
            beq.b   .L10
            moveq   #-$78,D0
            cmpi.l  #2,D6
            bne.w   .L17
            tst.w   D1
            bgt.w   .L49
.L7:
            lea     ($1E,A0),A1
            moveq   #$26,D0
.L8:
            clr.w   (A1)+
            dbra    D0,.L8
            bset    #4,($1E,A0)
            move.l  #2,($30,A0)
            move.l  #1,($64,A0)
            move.w  ($14,A2),($34,A0)
            move.l  ($A,A2),($48,A0)
            move.l  ($E,A2),($4C,A0)
            move.l  ($12,A0),D0
            beq.b   .L9
            tst.w   ($1C,A0)
            beq.b   .L9
            movea.l D0,A1
            lea     ($2C,A2),A0
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
.L9:
            moveq   #0,D0
            bra.b   .L17
.L10:
            moveq   #1,D0
            cmp.l   D0,D6
            beq.b   .L16
            tst.w   D1
            bne.b   .L11
            movem.l A0-A1,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     CMGetCN
            bne.b   .L15
            move.l  D2,D7
            bra.b   .L19
.L11:
            btst    #0,($376).w
            bne.b   .L18
            move.w  D1,D5
            move.w  ($B0,A2),D1
            cmp.l   ($AC,A2),D6
            bne.b   .L12
            cmp.w   ($5A,A2),D5
            bcs.b   .L12
            move.w  ($5A,A2),D0
            move.w  D5,($5A,A2)
            sub.w   D0,D5
            bra.b   .L13
.L12:
            moveq   #1,D1
            move.w  D5,($5A,A2)
            subq.w  #1,D5
.L13:
            movem.l A0-A1,-(A6)
.L14:
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     CMGetOff
            bne.b   .L15
            move.l  D2,D7
            addq.w  #1,D1
            cmpi.b  #2,(A1)
            bne.b   .L14
            dbra    D5,.L14
            bra.b   .L19
.L15:
            movem.l (A6)+,A0-A1
            cmpi.w  #$30,D0
            bne.b   .L17
.L16:
            moveq   #-$2B,D0
.L17:
            bra.w   CmdDone
.L18:
            movem.l A0-A1,-(A6)
            move.w  #$FFFF,($5A,A2)
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     CMGetOff
            bne.b   .L15
.L19:
            lea     (6,A0),A3
            move.l  (2,A0),D1
            movea.l A1,A5
            movem.l (A6)+,A0-A1
            move.l  ($12,A0),D0
            beq.b   .L21
            movea.l D0,A4
            move.b  (A3),D0
.L20:
            move.b  (A3)+,(A4)+
            subq.b  #1,D0
            bcc.b   .L20
.L21:
            btst    #0,($376).w
            bne.b   .L30
            cmpi.b  #2,(A5)
            bne.b   .L16
            lea     ($1E,A0),A4
            moveq   #$18,D0
            lea     (2,A5),A3
.L22:
            move.w  (A3)+,(A4)+
            dbra    D0,.L22
            bclr    #4,($1E,A0)
.L23:
            andi.b  #$73,($1E,A0)
            clr.w   ($18,A0)
            move.l  ($14,A5),D2
            bsr.w   TFSVCBTst
            beq.b   .L24
            move.l  ($12,A5),D2
.L24:
            bsr.w   Gt1stMatch
            bne.b   .L29
.L25:
            btst    #1,(4,A1,D1.w)
            beq.b   .L26
            bset    #2,($1E,A0)
            bra.b   .L27
.L26:
            bset    #3,($1E,A0)
.L27:
            bset    #7,($1E,A0)
            bne.b   .L28
            move.w  D1,($18,A0)
.L28:
            lea     ($34,A0),A3
            bsr.w   UpDatFlNtry
            bsr.w   GtNxtMatch
            beq.b   .L25
.L29:
            moveq   #0,D0
            bra.w   .L17
.L30:
            lea     ($1E,A0),A4
            cmpi.b  #2,(A5)
            bne.b   .L32
            moveq   #$22,D0
            lea     (2,A5),A3
.L31:
            move.w  (A3)+,(A4)+
            dbra    D0,.L31
            moveq   #0,D0
            move.w  ($48,A5),D0
            mulu.w  ($1E,A2),D0
            move.l  D0,($68,A0)
            move.l  D1,($64,A0)
            bclr    #4,($1E,A0)
            bra.w   .L23
.L32:
            cmpi.b  #1,(A5)
            bne.w   .L16
            move.w  (2,A5),($1E,A0)
            move.w  (4,A5),($34,A0)
            move.l  (6,A5),($30,A0)
            move.l  D1,($64,A0)
            movem.l ($A,A5),D0-D2
            movem.l D0-D2,($48,A0)
            movem.l ($16,A5),D0-D3
            movem.l D0-D3,($20,A0)
            movem.l ($26,A5),D0-D3
            movem.l D0-D3,($54,A0)
            bclr    #7,($1E,A0)
            bset    #4,($1E,A0)
            moveq   #0,D0
            bra.w   .L17
.L33:
            move.b  ($1C,A0),(1,A5)
            bra.b   .L36
.L34:
            tst.b   ($348).w
            beq.b   .L35
            bset    #0,(A5)
            bne.b   .L37
            bra.b   .L36
.L35:
            bclr    #0,(A5)
            beq.b   .L37
.L36:
            movea.l A1,A0
            jsr     MarkBlock
            bsr.w   sub_40810C48
.L37:
            moveq   #0,D0
            bra.w   CmdDone
.L38:
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,(2,A5)
            movem.l ($48,A0),D1-D2
            movem.l D1-D2,($2A,A5)
            bra.b   .L36
.L39:
            movea.l (SP)+,A3
            tst.b   D2
            bne.b   .L40
            moveq   #-$25,D0
            bra.b   .L48
.L40:
            move.w  ($14,A2),D7
            beq.b   .L42
            bsr.w   sub_40811A30
.L41:
            beq.b   .L43
            cmpi.w  #$FFDF,D0
            bne.b   .L48
.L42:
            moveq   #-$2B,D0
            bra.b   .L48
.L43:
            moveq   #0,D0
            movea.l A4,A1
.L44:
            move.w  D0,D4
            tst.b   (0,A5,D4.w)
            beq.b   .L46
            move.b  (1,A5,D4.w),D6
            cmp.b   ($1A,A0),D6
            bne.b   .L45
            move.l  A0,-(SP)
            lea     ($32,A5,D4.w),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.w  D2,D0
            _CmpString
            movea.l (SP)+,A0
            beq.b   .L47
.L45:
            subq.w  #1,D7
            beq.b   .L42
            move.w  D4,D0
            bsr.w   sub_40810C92
            bcs.b   .L44
.L46:
            bsr.w   sub_40811A40
            bra.b   .L41
.L47:
            movea.l A5,A1
            lea     (0,A5,D4.w),A5
.L48:
            jmp     (A3)
.L49:
            cmp.w   ($14,A2),D1
            bhi.b   .L54
            move.w  ($18,A2),D5
            move.w  ($16,A2),D3
            add.w   D3,D5
            move.w  ($5A,A2),D7
            beq.b   .L50
            cmp.w   D7,D1
            bcs.b   .L50
            move.w  ($5C,A2),D3
            bra.b   .L51
.L50:
            moveq   #1,D7
.L51:
            cmp.w   D5,D3
            bcc.b   .L54
            move.w  D3,($5C,A2)
            move.w  D7,($5A,A2)
            bsr.w   sub_40811A50
            bne.b   .L54
            moveq   #0,D0
.L52:
            moveq   #0,D6
            tst.b   (0,A5,D0.w)
            beq.b   .L53
            cmp.w   D7,D1
            beq.b   .L55
            addq.w  #1,D7
            bsr.w   sub_40810C92
            bcs.b   .L52
.L53:
            addq.w  #1,D3
            bra.b   .L51
.L54:
            moveq   #-$2B,D0
            bra.w   CmdDone
.L55:
            lea     (0,A5,D0.w),A5
            lea     ($32,A5),A3
            move.l  ($12,A0),D0
            beq.b   .L57
            movea.l D0,A4
            move.b  (A3),D0
.L56:
            move.b  (A3)+,(A4)+
            subq.b  #1,D0
            bcc.b   .L56
.L57:
            lea     ($1E,A0),A4
            moveq   #$18,D0
            lea     (A5),A3
.L58:
            move.w  (A3)+,(A4)+
            dbra    D0,.L58
            bclr    #4,($1E,A0)
            btst    #0,($376).w
            beq.b   .L60
            move.l  #2,($64,A0)
            clr.l   ($50,A0)
            move.l  A0,-(SP)
            lea     ($54,A0),A0
            moveq   #3,D0
.L59:
            clr.l   (A0)+
            dbra    D0,.L59
            movea.l (SP)+,A0
.L60:
            bra.w   .L23
sub_408117DE:
            btst    #9,(6,A0)
            rts
sub_408117E6:
            movea.l ($14,A1,D1.w),A2
TFSVCBTst:
            cmpi.w  #$4244,(8,A2)
            rts
Seek:
            clr.l   ($28,A0)
            moveq   #-$32,D0
            move.l  ($24,A0),D7
            bmi.b   .L6
            move.l  ($2E,A0),D2
            move.l  ($10,A1,D1.w),D5
            move.l  (8,A1,D1.w),D4
            move.b  ($2D,A0),D0
            roxr.b  #2,D0
            bcc.b   .L2
            bmi.b   .L1
            move.l  D4,D5
.L1:
            add.l   D2,D5
            bra.b   .L3
.L2:
            bpl.b   .L3
            move.l  D2,D5
.L3:
            bpl.b   .L4
            moveq   #-$28,D0
            bra.b   .L6
.L4:
            move.l  D5,D2
            sub.l   D4,D2
            ble.b   .L5
            move.l  D4,D5
.L5:
            move.l  D5,($10,A1,D1.w)
            moveq   #0,D0
.L6:
            rts
GetFPos:
            clr.b   ($2D,A0)
SetFPos:
            clr.l   ($24,A0)
FileRead:
            move.l  ($7A8).w,-(SP)
            rts
vFileRead:
            bsr.w   FSQueue
            bsr.w   sub_40811C86
            bne.w   .L9
            bsr.b   Seek
            bne.b   .L8
            neg.l   D2
            bmi.b   .L7
            cmp.l   D2,D7
            ble.b   .L1
            move.l  D2,D7
.L1:
            tst.l   D7
            beq.b   .L5
            move.w  ($2C,A0),D2
            lsr.w   #8,D2
            bcs.b   .L10
            btst    #6,($2D,A0)
            beq.b   .L2
            movem.l D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            movea.l ($54,A2),A1
            st      ($377).w
            jsr     FlushCache
            movem.l (A6)+,D1/A1
.L2:
            move.w  D5,D2
            andi.w  #$1FF,D2
            beq.b   .L4
.L3:
            bsr.w   RdFileBlk
            bne.b   .L6
            btst    #6,($2D,A0)
            sne     D0
            bsr.w   DoPart
            bne.b   .L6
.L4:
            move.l  D7,D4
            beq.b   .L5
            andi.w  #$FE00,D4
            tst.l   D4
            beq.b   .L3
            jsr     CacheRdIP
            bne.b   .L6
            bsr.w   sub_408119DE
            bra.b   .L4
.L5:
            moveq   #0,D0
.L6:
            tst.w   D0
            bne.b   .L8
            move.l  ($28,A0),D2
            cmp.l   ($24,A0),D2
            beq.b   .L8
.L7:
            moveq   #-$27,D0
.L8:
            move.l  D5,($10,A1,D1.w)
            move.l  D5,($2E,A0)
.L9:
            bra.w   CmdDone
.L10:
            bsr.b   RdFileBlk
            bne.b   .L6
            move.l  D5,D2
            andi.w  #$1FF,D2
            movea.l ($20,A0),A3
            move.l  ($28,A0),D4
.L11:
            move.b  (0,A5,D2.w),D0
            move.b  D0,(0,A3,D4.l)
            addq.l  #1,($28,A0)
            addq.l  #1,D4
            addq.w  #1,D2
            addq.l  #1,D5
            cmp.b   ($2C,A0),D0
            bne.b   .L12
            moveq   #0,D0
            bra.b   .L8
.L12:
            subq.l  #1,D7
            beq.b   .L5
            cmp.w   D6,D2
            bcs.b   .L11
            bra.b   .L10
sub_40811912:
            bsr.b   ReadBlock_TFSRFN1
            cmp.l   D3,D5
            bcs.b   RdFileBlk.L1
            moveq   #4,D1
            bra.b   RdFileBlk.L1
RdFileBlk:
            bsr.b   ReadBlock_TFSRFN1
            btst    #6,($2D,A0)
            beq.b   .L1
            moveq   #1,D1
.L1:
            movea.l ($54,A2),A1
            move.l  D5,D2
            lsr.l   #8,D2
            lsr.l   #1,D2
            rts
ReadBlock_TFSRFN1:
            movem.l D1-D2/A0-A1,-(A6)
            movea.l (SP)+,A1
            move.l  (SP)+,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            moveq   #2,D6
            lsl.l   #8,D6
            jsr     (A1)
            addq.b  #8,D1
            jsr     GetBlock
            movea.l A0,A5
            move.l  (A6)+,-(SP)
            movem.l (A6)+,D1-D2/A0-A1
            tst.w   D0
            rts
FileWrite:
            move.l  ($7AC).w,-(SP)
            rts
vFileWrite:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L10
            bsr.w   Seek
            bne.b   .L2
            tst.l   D2
            bmi.b   .L1
            add.l   D2,D5
.L1:
            move.l  #$1FF,D3
            add.l   D4,D3
            andi.w  #$FE00,D3
            move.l  D5,D4
            add.l   D7,D4
            cmp.l   (8,A1,D1.w),D4
            bls.b   .L4
            sub.l   ($C,A1,D1.w),D4
            bls.b   .L3
            bsr.w   sub_40811EF2
.L2:
            bne.b   .L9
.L3:
            move.l  D5,D4
            add.l   D7,D4
            move.l  D4,(8,A1,D1.w)
.L4:
            move.w  D5,D0
            andi.w  #$1FF,D0
            beq.b   .L6
.L5:
            bsr.w   sub_40811912
            bne.b   .L8
            moveq   #1,D0
            bsr.b   DoPart
            jsr     MarkA5Block
.L6:
            move.l  D7,D4
            beq.b   .L7
            andi.w  #$FE00,D4
            tst.l   D4
            beq.b   .L5
            jsr     CacheWrIP
            bne.b   .L8
            bsr.b   sub_408119DE
            bra.b   .L6
.L7:
            moveq   #0,D0
.L8:
            bsr.w   sub_40811E64
            move.l  D5,($10,A1,D1.w)
.L9:
            move.l  ($10,A1,D1.w),($2E,A0)
.L10:
            bra.w   CmdDone
sub_408119DE:
            sub.l   D6,D7
            add.l   D6,($28,A0)
            add.l   D6,D5
            rts
DoPart:
            move.l  D5,D2
            andi.w  #$1FF,D2
            sub.w   D2,D6
            cmp.l   D6,D7
            bcc.b   .L1
            move.l  D7,D6
.L1:
            movea.l ($20,A0),A3
            adda.l  ($28,A0),A3
            bsr.b   sub_408119DE
            movem.l D1/A0-A2,-(SP)
            movea.l A3,A0
            movea.l A5,A1
            adda.w  D2,A1
            tst.b   D0
            bgt.b   .L2
            bmi.b   .L5
            exg     A0,A1
.L2:
            move.l  D6,D0
            movea.l ($4B8).w,A2
            jsr     (A2)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1/A0-A2
            rts
.L5:
            moveq   #-$24,D0
            subq.w  #1,D6
.L6:
            cmpm.b  (A0)+,(A1)+
            dbne    D6,.L6
            bne.b   .L4
            bra.b   .L3
sub_40811A30:
            move.w  ($18,A2),D0
            move.w  ($16,A2),D3
            add.w   D3,D0
            move.w  D0,($344).w
            bra.b   sub_40811A50
sub_40811A40:
            move.w  FileVars,D3
            addq.w  #1,D3
            cmp.w   ($344).w,D3
            bcs.b   sub_40811A50
            moveq   #-$21,D0
            rts
sub_40811A50:
            move.w  D3,FileVars
            bsr.w   ReadBlock_TFSRFN1
            movea.l ($380).w,A1
            bra.b   MFSMapRead.L2
sub_40811A5E:
            bsr.w   ReadBlock_TFSRFN1
            bra.b   MFSMapRead.L1
MFSMapRead:
            bsr.w   ReadBlock_TFSRFN1
            moveq   #4,D1
.L1:
            movea.l ($37C).w,A1
.L2:
            moveq   #0,D2
            move.w  D3,D2
            move.w  ($4E,A2),D0
            rts
FlushFile:
            bsr.w   FSQueue
            st      FlushOnly
            bra.b   vFileClose.L1
FileClose:
            move.l  ($7A4).w,-(SP)
            rts
vFileClose:
            bsr.w   FSQueue
            clr.b   FlushOnly
.L1:
            bsr.w   sub_40811C86
            beq.b   .L2
            cmpi.w  #$FFCB,D0
            bne.b   .L3
.L2:
            bsr.b   sub_40811AA2
.L3:
            bra.w   CmdDone
sub_40811AA2:
            move.l  ($6CC).w,-(SP)
            rts
vFClose:
            move.l  (SP)+,-(A6)
            movem.l D1-D3/A0-A5,-(A6)
            bsr.w   TFSVCBTst
            bne.w   .L14
            tst.l   ($22,A1,D1.w)
            beq.b   .L3
            cmpi.l  #$10,(0,A1,D1.w)
            bcc.b   .L3
            move.w  D1,D0
            tst.b   FlushOnly
            bne.b   .L1
            jsr     BTSvcs
            bra.b   .L2
.L1:
            jsr     BTFlush
.L2:
            bne.w   .L13
.L3:
            moveq   #0,D0
            tst.w   ($48,A2)
            beq.w   .L11
            cmpi.l  #$10,(0,A1,D1.w)
            bcs.w   .L11
            bclr    #7,(4,A1,D1.w)
            beq.w   .L7
            bsr.w   TstMod1
            bne.b   .L4
            move.l  ($C,A1,D1.w),D3
            moveq   #0,D2
            jsr     TruncateFile
            bne.w   .L8
            bclr    #7,(4,A1,D1.w)
.L4:
            move.l  A1,-(A6)
            move.l  ($3A,A1,D1.w),D0
            lea     ($3E,A1,D1.w),A0
            moveq   #0,D2
            jsr     CMGetCN
            movea.l A1,A5
            movea.l (A6)+,A1
            bne.w   .L8
            movem.l A0-A1,-(SP)
            lea     ($26,A1,D1.w),A0
            lea     ($4A,A5),A3
            btst    #9,(4,A1,D1.w)
            beq.b   .L5
            lea     ($56,A5),A3
.L5:
            movea.l A3,A1
            moveq   #$C,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            lea     ($18,A5),A3
            bsr.w   UpDatFlNtry
            move.l  TimeLM,($30,A5)
            jsr     CMUpdateCN
            bne.b   .L8
            btst    #9,(4,A1,D1.w)
            beq.b   .L7
            cmpi.l  #$80,(8,A1,D1.w)
            bcs.b   .L7
            movem.l D1/A1,-(A6)
            movea.l A0,A3
            movea.l ($54,A2),A1
            move.w  D1,D0
            moveq   #0,D1
            moveq   #0,D2
            jsr     GetBlock
            bne.b   .L6
            move.l  A0,-(SP)
            lea     ($30,A0),A1
            lea     (6,A3),A0
            moveq   #$20,D0
            _BlockMove
            moveq   #$20,D0
            adda.l  D0,A1
            lea     (2,A5),A0
            moveq   #$12,D0
            _BlockMove
            moveq   #$12,D0
            adda.l  D0,A1
            lea     ($38,A5),A0
            moveq   #$10,D0
            _BlockMove
            moveq   #$10,D0
            adda.l  D0,A1
            move.l  ($2C,A5),(A1)+
            move.l  ($1A,A5),(A1)+
            move.l  ($24,A5),(A1)+
            movea.l (SP)+,A0
            movea.l ($54,A2),A1
            moveq   #4,D1
            jsr     RelBlock
.L6:
            movem.l (A6)+,D1/A1
.L7:
            moveq   #0,D0
.L8:
            movem.l D0-D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            tst.b   FlushOnly
            bne.b   .L9
            moveq   #1,D1
.L9:
            movea.l ($54,A2),A1
            jsr     FlushCache
            bsr.w   TFSVCBTst
            beq.b   .L10
            bsr.w   sub_40810C48
.L10:
            movem.l (A6)+,D0-D1/A1
.L11:
            tst.b   FlushOnly
            bne.b   .L13
            lea     (0,A1,D1.w),A3
            moveq   #0,D2
            move.w  FSFCBLen,D2
            lsr.w   #1,D2
            subq.w  #1,D2
.L12:
            clr.w   (A3)+
            dbra    D2,.L12
.L13:
            movem.l (A6)+,D1-D3/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
.L14:
            bclr    #7,(4,A1,D1.w)
            beq.b   .L7
            move.w  ($1C,A1,D1.w),D3
            bsr.w   sub_40811A50
            bne.b   .L8
            moveq   #0,D0
            move.l  (0,A1,D1.w),D3
.L15:
            cmp.l   ($12,A5,D0.w),D3
            beq.b   .L16
            bsr.w   sub_40810C92
            bcs.b   .L15
            moveq   #-$2B,D0
            bra.b   .L8
.L16:
            lea     ($16,A5,D0.w),A3
            bsr.b   UpDatFlNtry
            move.l  TimeLM,($2E,A5,D0.w)
            jsr     MarkA5Block
            bra.w   .L7
UpDatFlNtry:
            move.l  A4,-(SP)
            lea     (4,A1,D1.w),A4
            move.w  (A4)+,D3
            lsl.w   #7,D3
            bcc.b   .L1
            lea     ($A,A3),A3
.L1:
            move.w  (A4)+,(A3)+
            move.l  (A4)+,(A3)+
            move.l  (A4)+,(A3)+
            movea.l (SP)+,A4
            rts
GetEOF:
            bsr.w   FSQueue
            bsr.b   sub_40811C86
            bne.b   .L1
            move.l  (8,A1,D1.w),($1C,A0)
.L1:
            bra.w   CmdDone
sub_40811C86:
            move.l  ($790).w,-(SP)
            rts
vRfNCall:
            movea.l ($34E).w,A1
            moveq   #0,D1
            move.w  ($18,A0),D1
            bsr.b   CkFileRfn
            bne.b   .L1
            move.l  (0,A1,D1.w),D2
            movea.l ($14,A1,D1.w),A2
            move.l  A2,($3EE).w
            bsr.w   ExtOffLinCk
.L1:
            tst.w   D0
            rts
CkFileRfn:
            moveq   #-$33,D0
            moveq   #0,D2
            move.w  D1,D2
            divu.w  FSFCBLen,D2
            swap    D2
            subq.w  #2,D2
            bne.b   .L1
            cmp.w   (A1),D1
            bcc.b   .L1
            moveq   #-$26,D0
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
TstMod:
            move.l  ($7C4).w,-(SP)
            rts
vTstMod:
            bsr.b   sub_40811C86
            bne.b   TstMod1.L1
TstMod1:
            moveq   #-$3D,D0
            btst    #0,(4,A1,D1.w)
            beq.b   .L1
            bsr.w   CVFlgs
.L1:
            tst.w   D0
            rts
GetFCBInfo:
            bsr.w   FSQueue
            bsr.b   FndFCB
            bne.b   .L2
            move.w  D1,($18,A0)
            lea     (0,A1,D1.w),A3
            move.l  A0,-(SP)
            lea     ($20,A0),A1
            movea.l A3,A0
            moveq   #$14,D0
            _BlockMove
            movea.l (SP)+,A0
            move.w  ($4E,A2),($34,A0)
            move.l  ($1E,A3),($36,A0)
            move.l  ($3A,A3),($3A,A0)
            move.l  ($12,A0),D0
            beq.b   .L1
            movea.l D0,A1
            move.l  A0,-(SP)
            lea     ($3E,A3),A0
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            movea.l (SP)+,A0
.L1:
            move.l  A2,($3EE).w
            move.l  A3,D1
            bsr.w   sub_4080FEFA
.L2:
            bra.w   CmdDone
FndFCB:
            movea.l ($34E).w,A1
            move.w  ($18,A0),D1
            move.w  ($1C,A0),D0
            beq.b   .L6
            moveq   #0,D2
            move.w  ($16,A0),D2
            beq.b   .L1
            move.w  D2,D0
            bsr.w   DtrmV1
            bne.b   .L7
            move.l  A2,D2
            move.w  ($1C,A0),D0
.L1:
            bsr.w   sub_408108C6
.L2:
            move.l  (0,A1,D1.w),D3
            beq.b   .L5
            movea.l ($14,A1,D1.w),A2
            bsr.w   TFSVCBTst
            bne.b   .L3
            cmpi.l  #$10,D3
            bcs.b   .L5
.L3:
            tst.l   D2
            beq.b   .L4
            cmp.l   ($14,A1,D1.w),D2
            bne.b   .L5
.L4:
            subq.w  #1,D0
            beq.b   .L6
.L5:
            bsr.w   sub_408108CE
            bcs.b   .L2
            moveq   #-$26,D0
            bra.b   .L7
.L6:
            bsr.w   CkFileRfn
            movea.l ($14,A1,D1.w),A2
.L7:
            tst.w   D0
            rts
            bsr.w   FSQueue
            bsr.w   sub_40811C86
            bne.b   .L8
            moveq   #0,D0
.L8:
            bra.w   CmdDone
toAlloc:
            moveq   #0,D0
            bsr.w   TFSVCBTst
            bne.w   GtNxBlk.L2
            bsr.w   sub_408117DE
            beq.b   .L1
            moveq   #2,D0
.L1:
            bra.w   sub_40811EF2.L1
FileAlloc:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L2
            moveq   #0,D6
            move.l  ($24,A0),D4
            beq.b   .L1
            tst.w   ($2A,A2)
            beq.b   .L1
            bsr.b   toAlloc
            bne.b   .L2
.L1:
            move.l  D6,($28,A0)
            bsr.b   sub_40811E64
            moveq   #-$22,D0
            cmp.l   ($24,A0),D6
            bcs.b   .L2
            moveq   #0,D0
.L2:
            bra.w   CmdDone
SetEOF:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L4
            move.l  ($1C,A0),D7
            move.l  D7,D4
            sub.l   ($C,A1,D1.w),D4
            bhi.b   .L7
            bcs.b   .L5
.L1:
            bsr.w   sub_408117DE
            beq.b   .L2
            cmp.l   (8,A1,D1.w),D7
            bcc.b   .L3
.L2:
            move.l  D7,(8,A1,D1.w)
            cmp.l   ($10,A1,D1.w),D7
            bcc.b   .L3
            move.l  D7,($10,A1,D1.w)
.L3:
            bsr.b   sub_40811E64
            moveq   #0,D0
.L4:
            bra.w   CmdDone
.L5:
            bsr.w   sub_408117E6
            bne.b   vAdjEOF.L4
            move.l  D7,D4
            move.l  D4,D3
            moveq   #1,D2
            jsr     TruncateFile
            bne.b   .L4
.L6:
            movem.l D0-D2,-(A6)
            move.w  D1,D0
            move.l  ($C,A1,D1.w),D1
            moveq   #-1,D2
            jsr     TrashBlocks
            movem.l (A6)+,D0-D2
            bra.b   .L1
.L7:
            jsr     sub_40811EF2
            bne.b   .L4
            bra.b   .L1
sub_40811E64:
            move.l  ($794).w,-(SP)
            rts
vAdjEOF:
            movem.l D0-D6/A0-A5,-(SP)
            adda.w  D1,A1
            move.l  (A1)+,D2
            bset    #7,(A1)
            move.w  (A1),D0
            movem.l (A1)+,D3-D6/A2
            move.w  D0,D6
            lea     ($E,A1),A1
            movem.l (A1)+,A3-A5
            bsr.w   Gt1stMatch
            bne.b   .L3
.L1:
            lea     (4,A1,D1.w),A0
            move.w  (A0)+,D0
            eor.w   D6,D0
            lsl.w   #7,D0
            bcs.b   .L2
            move.w  D3,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)+
            lea     ($22,A0),A0
            movem.l A3-A5,-(A0)
.L2:
            bsr.w   GtNxtMatch
            beq.b   .L1
.L3:
            movem.l (SP)+,D0-D6/A0-A5
            rts
.L4:
            moveq   #0,D6
            move.w  (6,A1,D1.w),D3
            move.l  ($1C,A2),D2
            move.l  D7,D4
            bne.b   .L6
            clr.w   (6,A1,D1.w)
            bra.b   .L7
.L5:
            move.w  D5,D3
.L6:
            add.l   D2,D6
            bsr.w   GtNxBlk
            sub.l   D2,D4
            bhi.b   .L5
            cmp.l   ($C,A1,D1.w),D6
            bcc.w   SetEOF.L1
            move.w  D5,-(SP)
            moveq   #1,D5
            bsr.w   SubMrk
            move.w  (SP)+,D3
.L7:
            bsr.w   DAlBlks
            move.l  D6,($C,A1,D1.w)
            move.l  D6,D4
            bra.w   SetEOF.L6
sub_40811EF2:
            bsr.w   sub_408117E6
            bne.w   GtNxBlk.L1
            moveq   #1,D0
.L1:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            move.w  D0,D3
            jsr     ExtendFile
            move.l  (A6)+,D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
Lg2Phys:
            move.l  ($6FC).w,-(SP)
            rts
VLG2PHYS:
            bsr.w   sub_408117E6
            bne.b   .L1
            jmp     MapFBlock
.L1:
            movem.l D1-D2/D4-D5/D7,-(SP)
            move.l  ($1C,A2),D7
            move.w  (6,A1,D1.w),D3
            add.l   D5,D4
            subq.l  #1,D4
            moveq   #9,D1
            moveq   #0,D6
            lsr.l   D1,D4
            lsr.l   D1,D7
            move.l  D5,D2
            lsr.l   D1,D2
            bra.b   .L3
.L2:
            bsr.b   GtNxBlk
            move.w  D5,D3
            sub.w   D7,D4
            sub.w   D7,D2
.L3:
            cmp.w   D7,D2
            bcc.b   .L2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  D7,D0
            add.w   D2,D0
            add.w   ($24,A2),D0
            move.l  D0,-(SP)
.L4:
            move.w  D7,D0
            sub.w   D2,D0
            add.w   D0,D6
            sub.w   D0,D4
            bmi.b   .L5
            bsr.b   GtNxBlk
            moveq   #0,D2
            addq.w  #1,D3
            cmp.w   D3,D5
            beq.b   .L4
.L5:
            move.l  (SP)+,D3
            move.w  D3,D0
            add.w   D6,D0
            move.w  ($24,A2),D4
            mulu.w  ($1A,A2),D7
            add.w   D4,D7
            cmp.w   D7,D0
            bhi.b   .L7
            cmp.w   D4,D3
            bcs.b   .L7
            asl.l   D1,D6
            movem.l (SP)+,D1-D2/D4-D5/D7
            cmp.l   D4,D6
            bls.b   .L6
            move.l  D4,D6
.L6:
            moveq   #0,D0
            rts
.L7:
            movem.l (SP)+,D1-D2/D4-D5/D7
            move.w  #$10,D0
            rts
GtNxBlk:
            movem.l D0/A2,-(SP)
            movea.l ($50,A2),A2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  #$C,D0
            ror.l   #4,D0
            asl.w   #1,D0
            move.l  (0,A2,D0.w),D5
            clr.w   D0
            rol.l   #4,D0
            addi.w  #$C,D0
            rol.l   D0,D5
            andi.w  #$FFF,D5
            movem.l (SP)+,D0/A2
            rts
.L1:
            move.l  D4,D0
.L2:
            movem.l D1-D5/D7/A0-A3,-(SP)
            move.l  ($1C,A2),D7
            move.l  D7,D6
            mulu.w  ($2A,A2),D6
            cmp.l   D6,D4
            bls.b   .L3
            move.l  D6,D4
.L3:
            cmp.l   D0,D4
            bcc.b   .L5
            moveq   #-$22,D0
.L4:
            movem.l (SP)+,D1-D5/D7/A0-A3
            rts
.L5:
            move.l  ($C,A1,D1.w),D2
            moveq   #0,D6
            move.w  (6,A1,D1.w),D3
            bne.b   .L7
            bsr.b   GetFreeBk
            move.w  D5,(6,A1,D1.w)
            move.w  D5,D3
            moveq   #1,D5
            bsr.w   SubMrk
            bra.b   .L10
.L6:
            move.w  D5,D3
.L7:
            bsr.b   GtNxBlk
            cmpi.w  #1,D5
            bne.b   .L6
.L8:
            cmp.w   ($1A,A2),D3
            bhi.b   .L11
            addq.w  #1,D3
            bsr.b   GtNxBlk
            subq.w  #1,D3
            tst.w   D5
            bne.b   .L11
            move.w  D3,D5
            addq.w  #1,D5
.L9:
            bsr.w   SubMrk
            move.w  D5,D3
            moveq   #1,D5
            bsr.b   SubMrk
.L10:
            add.l   D7,D6
            add.l   D7,D2
            subq.w  #1,($2A,A2)
            cmp.l   D6,D4
            bhi.b   .L8
            move.l  D2,($C,A1,D1.w)
            bsr.w   MarkVCB
            moveq   #0,D0
            bra.b   .L4
.L11:
            bsr.b   GetFreeBk
            bra.b   .L9
GetFreeBk:
            movem.l D0-D4/D6/A1/A3,-(SP)
            sub.l   D6,D4
            cmp.l   ($20,A2),D4
            bcc.b   .L1
            move.l  ($20,A2),D4
.L1:
            movea.l ($50,A2),A1
            movea.w ($1A,A2),A3
            addq.w  #1,A3
            moveq   #0,D5
            moveq   #2,D0
            moveq   #2,D2
            moveq   #0,D3
            moveq   #0,D6
            clr.w   -(SP)
.L2:
            move.b  (A1)+,D1
            lsl.w   #8,D1
            bchg    #0,D5
            bne.b   .L3
            move.b  (A1),D1
            lsr.w   #4,D1
            bra.b   .L4
.L3:
            move.b  (A1)+,D1
            andi.w  #$FFF,D1
.L4:
            bne.b   .L6
            add.l   D7,D3
            cmp.l   D6,D3
            bls.b   .L5
            move.l  D3,D6
            move.w  D2,(SP)
            cmp.l   D4,D3
            bcc.b   .L8
.L5:
            addq.w  #1,D0
            bra.b   .L7
.L6:
            addq.w  #1,D0
            move.w  D0,D2
            moveq   #0,D3
.L7:
            cmp.w   A3,D0
            bls.b   .L2
.L8:
            move.w  (SP)+,D5
            movem.l (SP)+,D0-D4/D6/A1/A3
            rts
SubMrk:
            movem.l D0/D6/A2,-(SP)
            movea.l ($50,A2),A2
            move.w  D3,D0
            subq.w  #2,D0
            mulu.w  #$C,D0
            ror.l   #4,D0
            asl.w   #1,D0
            move.l  (0,A2,D0.w),D6
            swap    D0
            lsr.w   #8,D0
            lsr.w   #4,D0
            addi.w  #$C,D0
            rol.l   D0,D6
            andi.w  #$F000,D6
            or.w    D5,D6
            ror.l   D0,D6
            swap    D0
            move.l  D6,(0,A2,D0.w)
            movem.l (SP)+,D0/D6/A2
            rts
DAlBlks:
            tst.w   D3
            beq.b   .L2
.L1:
            bsr.w   GtNxBlk
            move.w  D5,-(SP)
            clr.w   D5
            bsr.b   SubMrk
            addq.w  #1,($2A,A2)
            move.w  (SP)+,D3
            cmpi.w  #1,D3
            bne.b   .L1
            bsr.w   MarkVCB
.L2:
            rts
            ds.b    12
BlkAlloc:
VSM:
            move.l  ($77C).w,-(SP)
            rts
vBlkAlloc:
            move.l  (SP)+,-(A6)
            movem.l D1/D4-D7/A0-A1,-(A6)
            tst.w   ($2A,A2)
            beq.w   .L17
            andi.w  #1,D3
            tst.w   D2
            bne.b   .L1
            move.w  ($18,A2),D2
            bset    #7,D3
.L1:
            swap    D3
            move.w  D2,D3
            swap    D3
            bclr    #$F,D3
.L2:
            bsr.w   ReadBM
            tst.w   D1
            bmi.w   .L16
            movea.w ($1A,A2),A1
.L3:
            cmp.w   A1,D2
            bcs.b   .L4
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            clr.w   D2
            bsr.w   ReadBM
            bset    #$F,D3
            bne.w   .L17
.L4:
            tst.w   D1
            bmi.w   .L16
            tst.l   D0
            bpl.b   .L5
            bsr.w   FrBitScan
            bra.b   .L3
.L5:
            suba.w  D2,A1
            btst    #0,D3
            beq.b   .L11
            move.l  D4,-(A6)
            movem.l D0-D1,-(A6)
            move.l  D4,D0
            move.w  ($1E,A2),D1
            jsr     DivUp
            move.l  D0,D4
            movem.l (A6)+,D0-D1
            clr.w   D7
.L6:
            cmp.w   D7,D4
            bls.b   .L10
            cmp.w   A1,D7
            beq.b   .L7
            tst.l   D0
            bmi.b   .L7
            addq.w  #1,D7
            bsr.w   NextBit
            tst.w   D1
            bmi.w   .L16
            bra.b   .L6
.L7:
            move.l  (A6)+,D4
            add.w   D7,D2
            cmp.w   A1,D7
            bcs.b   .L8
            btst    #$F,D3
            bne.b   .L9
            bset    #$F,D3
            clr.w   D2
.L8:
            btst    #$F,D3
            beq.w   .L2
            swap    D3
            cmp.w   D2,D3
            bls.b   .L9
            swap    D3
            bra.w   .L2
.L9:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            bra.w   .L17
.L10:
            move.l  (A6)+,D4
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            bsr.w   ReadBM
            tst.w   D1
            bmi.w   .L16
.L11:
            movem.l D0-D1,-(A6)
            move.l  D4,D0
            move.l  ($1E,A3),D1
            jsr     RoundAlloc
            move.l  D0,D4
            movem.l (A6)+,D0-D1
            moveq   #0,D7
.L12:
            tst.w   D4
            beq.b   .L13
            cmp.w   A1,D7
            bcc.b   .L13
            tst.l   D0
            bmi.b   .L13
            tst.w   ($2A,A2)
            beq.b   .L13
            subq.w  #1,($2A,A2)
            jsr     MarkVCB
            bset    #$1F,D0
            addq.w  #1,D7
            subq.w  #1,D4
            jsr     MarkBlock
            bsr.w   NextBit
            tst.w   D1
            bge.b   .L12
            bra.b   .L16
.L13:
            btst    #7,D3
            beq.b   .L15
            move.w  D2,D4
            cmp.w   ($1A,A2),D4
            bcs.b   .L14
            clr.w   D4
.L14:
            move.w  D4,($18,A2)
.L15:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            jsr     MarkBlock
            move.l  D7,D3
            moveq   #0,D0
.L16:
            movem.l (A6)+,D1/D4-D7/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
.L17:
            moveq   #0,D3
            moveq   #-$22,D0
            bra.b   .L16
BLKDEALLOC:
            move.l  ($780).w,-(SP)
            rts
VBLKDEALLOC:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0,-(A6)
            moveq   #0,D0
            tst.w   D3
            beq.b   .L3
            bsr.w   ReadBM
.L1:
            tst.w   D1
            bmi.b   .L3
            bclr    #$1F,D0
            jsr     MarkBlock
            addq.w  #1,($2A,A2)
            jsr     MarkVCB
            subq.w  #1,D3
            beq.b   .L2
            bsr.w   NextBit
            bra.b   .L1
.L2:
            rol.l   D1,D0
            move.l  D0,(0,A0,D6.w)
            moveq   #0,D0
.L3:
            movem.l (A6)+,D1-D6/A0
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BLKCHK:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A1,-(A6)
            movea.l A0,A1
            moveq   #0,D3
            moveq   #0,D7
.L1:
            move.w  (0,A1,D7.w),D2
            moveq   #0,D4
            move.w  (2,A1,D7.w),D4
            beq.b   .L6
            bsr.b   ReadBM
            bra.b   .L4
.L2:
            bset    #$1F,D0
            bne.b   .L3
            moveq   #-1,D3
            jsr     MarkBlock
.L3:
            addq.w  #1,D2
            rol.l   #1,D0
            subq.w  #1,D1
            bgt.b   .L4
            tst.w   D4
            beq.b   .L5
            bsr.w   NextWord
.L4:
            tst.w   D1
            bmi.b   .L7
            dbra    D4,.L2
            rol.l   D1,D0
.L5:
            move.l  D0,(0,A0,D6.w)
            addq.w  #4,D7
            cmpi.w  #$C,D7
            bcs.b   .L1
.L6:
            move.l  D3,D0
.L7:
            movem.l (A6)+,D1-D7/A1
            move.l  (A6)+,-(SP)
            tst.l   D0
            rts
UpdateFree:
            move.l  (SP)+,-(A6)
            movem.l D0-D6/A0-A1,-(A6)
            moveq   #0,D4
            moveq   #0,D2
            bsr.b   ReadBM
            move.w  ($1A,A2),D2
.L1:
            tst.w   D1
            bmi.b   .L4
            tst.l   D0
            bmi.b   .L2
            addq.w  #1,D4
.L2:
            subq.w  #1,D2
            beq.b   .L3
            bsr.b   NextBit
            bra.b   .L1
.L3:
            move.w  D4,($2A,A2)
.L4:
            movem.l (A6)+,D0-D6/A0-A1
            move.l  (A6)+,-(SP)
            rts
ReadBM:
            move.l  ($7D8).w,-(SP)
            rts
vReadBM:
            move.l  (SP)+,-(A6)
            move.w  D2,D5
            lsr.w   #8,D5
            lsr.w   #4,D5
            move.w  D2,D6
            andi.w  #$FE0,D6
            lsr.w   #3,D6
            move.w  D2,D1
            andi.w  #$1F,D1
            bsr.b   GetBMBlk
            beq.b   .L1
            moveq   #-1,D1
            bra.b   .L2
.L1:
            move.l  (0,A0,D6.w),D0
            rol.l   D1,D0
            neg.w   D1
            addi.w  #$20,D1
.L2:
            move.l  (A6)+,-(SP)
            rts
NextBit:
            move.l  (SP)+,-(A6)
            rol.l   #1,D0
            subq.w  #1,D1
            bne.b   .L1
            bsr.b   NextWord
.L1:
            move.l  (A6)+,-(SP)
            rts
FrBitScan:
            move.l  (SP)+,-(A6)
            addq.w  #1,D2
            bsr.b   NextBit
.L1:
            cmp.l   MinusOne,D0
            bne.b   NextBit.L1
            add.w   D1,D2
            cmp.w   A1,D2
            bcc.b   .L2
            bsr.b   NextWord
            bra.b   .L1
.L2:
            sub.w   D1,D2
            bra.b   NextBit.L1
NextWord:
            move.l  (SP)+,-(A6)
            move.l  D0,(0,A0,D6.w)
            addq.w  #4,D6
            cmpi.w  #$200,D6
            bcs.b   .L2
            addq.w  #1,D5
            bsr.b   GetBMBlk
            beq.b   .L1
            moveq   #-1,D1
            bra.b   .L3
.L1:
            clr.w   D6
.L2:
            move.l  (0,A0,D6.w),D0
            moveq   #$20,D1
.L3:
            move.l  (A6)+,-(SP)
            rts
GetBMBlk:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1-A2,-(A6)
            move.w  ($4E,A2),D0
            moveq   #0,D2
            move.w  ($16,A2),D2
            add.w   D5,D2
            movea.l ($50,A2),A1
            moveq   #8,D1
            jsr     GetBlock
            movem.l (A6)+,D1-D2/A1-A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            dc.w    0
DeAllocFile:
FXM:
            move.l  ($764).w,-(SP)
            rts
vDeAllocFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A1/A3-A4,-(A6)
            bsr.w   FXSetUp
            movea.l A0,A3
            move.l  D0,D7
            clr.b   D6
.L1:
            clr.w   D4
            movea.l A3,A0
            move.l  D7,D0
            moveq   #0,D2
            jsr     CMGetCN
            bne.w   .L11
            cmpi.b  #2,(A1)
            beq.b   .L2
            moveq   #$30,D0
            bne.w   .L11
.L2:
            move.l  ($14,A1),D5
            lea     (2,A4),A0
            clr.w   (6,A0)
            tst.b   D6
            bne.b   .L3
            lea     ($4A,A1),A1
            bra.b   .L5
.L3:
            lea     ($56,A1),A1
            bra.b   .L5
.L4:
            lea     (2,A4),A0
            move.b  #7,(A0)
            move.b  D6,(1,A0)
            move.l  D5,(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     BTSEARCH
            beq.b   .L5
            cmpi.w  #$20,D0
            beq.b   .L10
            bra.b   .L11
.L5:
            lea     ($A,A4),A0
            moveq   #2,D0
.L6:
            move.l  (A1)+,(A0)+
            dbra    D0,.L6
            lea     ($A,A4),A1
            clr.w   D1
.L7:
            move.w  (0,A1,D1.w),D2
            move.w  (2,A1,D1.w),D3
            beq.b   .L8
            jsr     BLKDEALLOC
            bne.b   .L11
            add.w   D3,D4
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L7
.L8:
            lea     (2,A4),A0
            tst.w   (6,A0)
            beq.b   .L9
            move.w  ($A4,A2),D0
            jsr     BTDelete
            bne.b   .L11
.L9:
            tst.w   D3
            bne.b   .L4
.L10:
            not.b   D6
            bne.w   .L1
            clr.w   D0
            bsr.w   XFFlush
.L11:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtendFile:
            move.l  ($768).w,-(SP)
            rts
vExtendFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/D7/A0-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.l  ($C,A3),-(A6)
            btst    #0,D3
            beq.b   .L1
            move.w  ($2A,A2),D0
            mulu.w  ($1E,A2),D0
            cmp.l   D4,D0
            bcc.b   .L1
            moveq   #-$22,D0
            bra.w   .L15
.L1:
            bset    #6,(A4)
            btst    #1,D3
            beq.b   .L2
            bset    #7,(A4)
.L2:
            move.l  ($1C,A2),D0
            add.l   D0,D4
            subq.l  #1,D4
            divu.w  D0,D4
            mulu.w  D0,D4
            move.l  ($C,A3),D0
            add.l   D4,D0
            subq.l  #1,D0
            bsr.w   sub_4081285E
            bne.b   .L3
            add.l   D4,($C,A3)
            bset    #7,(4,A3)
            bra.w   .L14
.L3:
            cmpi.w  #$10,D0
            bne.w   .L15
            move.l  D2,D7
            move.w  D3,D6
            move.w  D6,D0
            mulu.w  ($1E,A2),D0
            sub.l   ($C,A3),D0
            beq.b   .L4
            add.l   D0,($C,A3)
            bset    #7,(4,A3)
            sub.l   D0,D4
.L4:
            move.w  (0,A1,D1.w),D5
            add.w   (2,A1,D1.w),D5
.L5:
            move.w  D5,D2
            btst    #6,(A4)
            sne     D3
            jsr     BlkAlloc
            beq.b   .L6
            cmpi.w  #$FFDE,D0
            bne.w   .L15
            bclr    #6,(A4)
            beq.w   .L15
            btst    #7,(A4)
            bne.w   .L15
            bra.b   .L5
.L6:
            cmp.w   D2,D5
            bne.b   .L7
            add.w   D3,(2,A1,D1.w)
            bra.b   .L9
.L7:
            tst.w   (2,A1,D1.w)
            beq.b   .L8
            addq.w  #4,D1
            cmpi.w  #8,D1
            bgt.b   .L10
.L8:
            move.w  D2,(0,A1,D1.w)
            move.w  D3,(2,A1,D1.w)
.L9:
            move.l  D7,D2
            bsr.w   XRUpdate
            bne.w   .L15
            move.l  D2,D7
            bra.b   .L13
.L10:
            move.l  (A3),D5
            cmpi.l  #3,D5
            bne.b   .L11
            moveq   #$11,D0
            bra.b   .L15
.L11:
            lea     (2,A4),A0
            lea     ($A,A4),A1
            move.b  #7,(A0)
            clr.b   (1,A0)
            btst    #1,(4,A3)
            sne     (1,A0)
            move.l  D5,(2,A0)
            move.w  D6,(6,A0)
            move.w  #5,D0
.L12:
            clr.w   (A1)+
            dbra    D0,.L12
            lea     ($A,A4),A1
            clr.w   D1
            move.w  D2,(0,A1,D1.w)
            move.w  D3,(2,A1,D1.w)
            move.l  D1,-(A6)
            move.w  #$C,D1
            move.w  ($A4,A2),D0
            jsr     BTINSERT
            move.l  (A6)+,D1
            tst.w   D0
            bne.b   .L15
            move.l  D2,D7
.L13:
            add.w   D3,D6
            mulu.w  ($1E,A2),D3
            add.l   D3,($C,A3)
            bset    #7,(4,A3)
            sub.l   D3,D4
            bgt.w   .L4
            add.l   D4,($C,A3)
.L14:
            clr.w   D0
            bsr.w   XFFlush
.L15:
            move.l  ($C,A3),D6
            move.l  (A6)+,D1
            sub.l   D1,D6
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D5/D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FXMKeyCmp:
            movem.l A0-A1,-(SP)
            move.l  (2,A0),D0
            cmp.l   (2,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            move.b  (1,A0),D0
            cmp.b   (1,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            move.w  (6,A0),D0
            cmp.w   (6,A1),D0
            bhi.b   .L2
            bcs.b   .L1
            clr.w   D0
            bra.b   .L3
.L1:
            move.w  #$FFFF,D0
            bra.b   .L3
.L2:
            move.w  #1,D0
.L3:
            movem.l (SP)+,A0-A1
            tst.w   D0
            rts
MapFBlock:
            move.l  ($7D0).w,-(SP)
            rts
vMapFBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/D4-D5/D7/A0-A1/A3-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.l  D5,D0
            bsr.w   sub_4081285E
            bne.b   .L3
            lea     (0,A1,D1.w),A1
            move.w  D3,D1
            sub.w   (2,A1),D1
            move.w  D3,D2
            mulu.w  ($1E,A2),D2
            move.l  ($C,A3),D0
            cmp.l   D0,D2
            ble.b   .L1
            move.l  D0,D2
.L1:
            divu.w  ($1E,A2),D2
            move.l  ($1C,A2),D6
            divu.w  #$200,D6
            moveq   #0,D7
            move.w  ($24,A2),D7
            move.l  D5,D3
            divu.w  ($1E,A2),D3
            swap    D3
            moveq   #0,D0
            move.w  D3,D0
            lsr.l   #8,D0
            lsr.l   #1,D0
            swap    D3
            sub.w   D1,D3
            add.w   (A1),D3
            mulu.w  D6,D3
            add.l   D0,D3
            add.l   D7,D3
            move.w  D2,D6
            mulu.w  ($1E,A2),D6
            sub.l   D5,D6
            cmp.l   D4,D6
            bcs.b   .L2
            move.l  D4,D6
.L2:
            moveq   #0,D0
.L3:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D2/D4-D5/D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TruncateFile:
            move.l  ($76C).w,-(SP)
            rts
vTruncateFile:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A4,-(A6)
            bsr.w   FXSetUp
            lea     (0,A1,D1.w),A3
            move.b  D2,D6
            move.l  D3,D5
            move.l  ($1C,A2),D0
            add.l   D0,D5
            subq.l  #1,D5
            divu.w  D0,D5
            mulu.w  D0,D5
            move.l  D5,D0
            subq.l  #1,D0
            bge.b   .L1
            move.l  D5,($C,A3)
            bset    #7,(4,A3)
            suba.l  A0,A0
            moveq   #0,D7
            lea     ($26,A3),A1
            clr.w   D4
            bra.w   .L7
.L1:
            bsr.w   sub_4081285E
            bne.w   .L14
            move.l  D2,D7
            move.w  D3,D4
            move.l  D5,($C,A3)
            bset    #7,(4,A3)
            btst    #0,D6
            beq.b   .L2
            move.w  (2,A1,D1.w),D3
            bra.w   .L9
.L2:
            move.l  D5,D0
            subq.l  #1,D0
            divu.w  ($1E,A2),D0
            sub.w   D0,D3
            subq.w  #1,D3
            beq.b   .L3
            move.w  (0,A1,D1.w),D2
            add.w   (2,A1,D1.w),D2
            sub.w   D3,D2
            jsr     BLKDEALLOC
            bne.w   .L14
.L3:
            move.w  D3,D0
            move.w  (2,A1,D1.w),D3
            sub.w   D0,(2,A1,D1.w)
            bne.b   .L9
            clr.w   (0,A1,D1.w)
            bra.b   .L9
.L4:
            lea     (2,A4),A0
            move.b  #7,(A0)
            btst    #1,(4,A3)
            sne     (1,A0)
            move.l  (A3),(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     BTSEARCH
            beq.b   .L5
            cmpi.w  #$20,D0
            beq.b   .L13
            bra.b   .L14
.L5:
            move.l  D2,D7
            lea     ($A,A4),A0
            moveq   #2,D0
.L6:
            move.l  (A1)+,(A0)+
            dbra    D0,.L6
            lea     (2,A4),A0
            lea     ($A,A4),A1
.L7:
            clr.w   D1
.L8:
            move.w  (0,A1,D1.w),D2
            move.w  (2,A1,D1.w),D3
            beq.b   .L10
            jsr     BLKDEALLOC
            bne.b   .L14
            clr.l   (0,A1,D1.w)
            add.w   D3,D4
.L9:
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L8
.L10:
            tst.w   (2,A1)
            beq.b   .L11
            move.l  D7,D2
            bsr.w   XRUpdate
            bra.b   .L12
.L11:
            move.l  A0,D0
            beq.b   .L12
            move.w  ($A4,A2),D0
            jsr     BTDelete
            bne.b   .L14
.L12:
            tst.w   D3
            bne.w   .L4
.L13:
            clr.w   D0
            bsr.b   XFFlush
.L14:
            lea     ($16,A6),A6
            movem.l (A6)+,D1-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FXSetUp:
            suba.w  #$16,A6
            movea.l A6,A4
            clr.b   (A4)
            rts
XFFlush:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  ($A4,A2),D1
            move.w  D1,D0
            jsr     BTFlush
            bne.b   .L2
            movea.l ($34E).w,A1
            btst    #7,(4,A1,D1.w)
            beq.b   .L1
            jsr     MarkVCB
            jsr     FlushMDB
            bne.b   .L2
.L1:
            clr.w   D0
.L2:
            movem.l (A6)+,D1/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
sub_4081285E:
            move.l  ($7D4).w,-(SP)
            rts
vXFSearch:
            move.l  (SP)+,-(A6)
            movem.l D4-D6,-(A6)
            move.l  D0,D4
            divu.w  ($1E,A2),D4
            move.l  (A3),D5
            suba.l  A0,A0
            moveq   #0,D2
            lea     ($26,A3),A1
            move.w  D4,D0
            clr.w   D3
            bsr.w   XRSearch
            beq.w   .L6
            cmpi.w  #8,D1
            blt.w   .L7
            tst.w   (2,A1,D1.w)
            beq.w   .L7
            cmpi.l  #3,D5
            beq.w   .L7
            lea     (2,A4),A0
            move.b  #7,(A0)
            btst    #1,(4,A3)
            sne     D6
            move.b  D6,(1,A0)
            move.l  D5,(2,A0)
            move.w  D4,(6,A0)
            move.w  ($A4,A2),D0
            moveq   #0,D2
            jsr     BTSEARCH
            beq.b   .L3
            cmpi.w  #$20,D0
            bne.b   .L7
            move.w  ($A4,A2),D0
            moveq   #-1,D1
            jsr     BTGetRecord
            beq.b   .L1
            cmpi.w  #$20,D0
            beq.b   .L2
            bra.b   .L7
.L1:
            cmp.l   (2,A0),D5
            bne.b   .L2
            cmp.b   (1,A0),D6
            beq.b   .L3
.L2:
            suba.l  A0,A0
            moveq   #0,D2
            lea     ($26,A3),A1
            move.w  #8,D1
            moveq   #$10,D0
            bra.b   .L7
.L3:
            move.l  A1,-(SP)
            lea     (2,A4),A1
            moveq   #1,D0
.L4:
            move.l  (A0)+,(A1)+
            dbra    D0,.L4
            movea.l (SP)+,A0
            lea     ($A,A4),A1
            moveq   #2,D0
.L5:
            move.l  (A0)+,(A1)+
            dbra    D0,.L5
            lea     (2,A4),A0
            lea     ($A,A4),A1
            move.w  (6,A0),D3
            move.w  D4,D0
            bsr.b   XRSearch
            bne.b   .L7
.L6:
            clr.w   D0
.L7:
            movem.l (A6)+,D4-D6
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
XRSearch:
            move.l  D2,-(SP)
            move.w  D0,D2
            clr.w   D1
.L1:
            move.w  (2,A1,D1.w),D0
            beq.b   .L2
            add.w   D0,D3
            cmp.w   D2,D3
            bhi.b   .L4
            addq.w  #4,D1
            cmpi.w  #8,D1
            ble.b   .L1
.L2:
            subq.w  #4,D1
            bge.b   .L3
            clr.w   D1
.L3:
            moveq   #$10,D0
            bra.b   .L5
.L4:
            clr.w   D0
.L5:
            move.l  (SP)+,D2
            tst.w   D0
            rts
XRUpdate:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            move.l  A0,D0
            bne.b   .L1
            bset    #7,(4,A3)
            bra.b   .L3
.L1:
            move.w  ($A4,A2),D0
            jsr     BTSEARCH
            bne.b   .L4
            lea     ($A,A4),A0
            moveq   #2,D0
.L2:
            move.l  (A0)+,(A1)+
            dbra    D0,.L2
            move.w  ($A4,A2),D0
            jsr     BTUpdate
            bne.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            ds.b    14
CMSvcs:
CMCreateCN:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A0-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D1,D5
            move.l  D0,D3
            movea.l A0,A3
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCREC
            bne.w   .L7
            move.l  D3,D0
            movea.l A3,A0
            lea     (A4),A1
            jsr     CMMAINT
            lea     ($26,A4),A1
            movea.l A1,A0
            move.w  #$32,D0
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            move.b  D5,(A1)
            move.l  TimeLM,D2
            cmpi.b  #1,D5
            bne.b   .L2
            move.l  ($26,A2),D6
            move.l  D6,(6,A1)
            addq.l  #1,($26,A2)
            move.l  D2,($A,A1)
            move.l  D2,($E,A1)
            moveq   #$46,D1
            bra.b   .L3
.L2:
            move.l  D2,($2C,A1)
            move.l  D2,($30,A1)
            move.l  ($26,A2),($14,A1)
            addq.l  #1,($26,A2)
            swap    D5
            move.b  D5,(3,A1)
            swap    D5
            moveq   #$66,D1
.L3:
            move.w  ($A6,A2),D0
            lea     (A4),A0
            jsr     BTINSERT
            beq.b   .L4
            cmpi.w  #$21,D0
            bne.w   .L7
            moveq   #$31,D0
            bra.w   .L7
.L4:
            move.l  D2,D7
            cmpi.b  #1,D5
            bne.b   .L6
            move.l  D6,D0
            suba.l  A0,A0
            lea     (A4),A1
            jsr     CMMAINT
            lea     ($26,A4),A1
            move.w  #$16,D0
.L5:
            clr.w   (A1)+
            dbra    D0,.L5
            lea     ($26,A4),A1
            move.b  #3,(A1)
            move.l  D3,($A,A1)
            movea.l A3,A0
            lea     ($E,A1),A1
            jsr     UPDCNAME
            move.w  ($A6,A2),D0
            move.w  #$2E,D1
            lea     (A4),A0
            lea     ($26,A4),A1
            jsr     BTINSERT
            beq.b   .L6
            move.l  D0,-(A6)
            move.l  D3,D0
            movea.l A3,A0
            lea     (A4),A1
            jsr     CMMAINT
            movea.l A1,A0
            move.w  ($A6,A2),D0
            jsr     BTDelete
            move.l  (A6)+,D0
            cmpi.w  #$21,D0
            bne.b   .L7
            moveq   #$31,D0
            bra.b   .L7
.L6:
            move.l  D3,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.b   .L7
            addq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bne.b   .L7
            move.b  D5,D0
            move.l  D3,D1
            moveq   #1,D2
            bsr.w   sub_40812F14
            clr.w   D0
            move.l  D6,D1
            move.l  D7,D2
            jsr     MarkVCBTime
            jsr     CMFLUSH
.L7:
            lea     ($8C,A6),A6
            movem.l (A6)+,D3-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMDeleteCN:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D0,D3
            movea.l A0,A3
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L4
            move.b  (A1),D4
            move.l  (2,A0),D6
            cmpi.b  #1,D4
            bne.b   .L2
            move.l  (6,A1),D5
            cmpi.l  #2,D5
            bne.b   .L1
            moveq   #$33,D0
            bra.b   .L4
.L1:
            tst.w   (4,A1)
            beq.b   .L2
            moveq   #$32,D0
            bra.b   .L4
.L2:
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     BTDelete
            bne.b   .L4
            cmpi.b  #1,D4
            bne.b   .L3
            suba.l  A0,A0
            move.l  D5,D0
            lea     (A4),A1
            jsr     CMMAINT
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     BTDelete
            bne.b   .L4
.L3:
            move.l  D6,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.b   .L4
            subq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bne.b   .L4
            move.b  D4,D0
            move.l  D6,D1
            moveq   #-1,D2
            bsr.w   sub_40812F14
            clr.w   D0
            jsr     MarkVCBTime
            jsr     CMFLUSH
.L4:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1-D6/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMGetCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            jsr     LOCCNODE
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMGetOff:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D4/A4,-(A6)
            bsr.w   CMSetUp
            move.l  D0,D3
            move.w  D1,D4
            move.l  ($AC,A2),D1
            beq.b   .L1
            cmp.l   D3,D1
            beq.b   .L2
.L1:
            clr.l   ($AC,A2)
            move.l  D3,D0
            suba.l  A0,A0
            jsr     LOCCREC
            bne.b   .L6
            move.l  D3,($AC,A2)
            clr.w   ($B0,A2)
.L2:
            move.w  ($A6,A2),D0
            move.w  D4,D1
            sub.w   ($B0,A2),D1
            jsr     BTGetRecord
            beq.b   .L5
            cmpi.w  #$20,D0
            bne.b   .L4
.L3:
            moveq   #$30,D0
.L4:
            clr.l   ($AC,A2)
            bra.b   .L6
.L5:
            cmp.l   (2,A0),D3
            bne.b   .L3
            move.w  D4,($B0,A2)
.L6:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D4/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMMoveCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D1,D5
            move.l  A1,D6
            move.l  D0,D3
            movea.l A0,A3
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L11
            moveq   #0,D4
            cmpi.b  #1,(A1)
            bne.b   .L1
            move.l  (6,A1),D4
.L1:
            move.l  D5,D0
            movea.l D6,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L11
            cmpi.b  #1,(A1)
            beq.b   .L2
            move.w  #$FF86,D0
            bra.w   .L11
.L2:
            move.l  (6,A1),D7
            tst.l   D4
            beq.b   .L5
            cmpi.l  #2,D4
            beq.b   .L4
            cmp.l   D4,D7
            beq.b   .L4
.L3:
            move.l  (2,A0),D0
            cmp.l   D4,D0
            beq.b   .L4
            cmpi.l  #2,D0
            ble.b   .L5
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L11
            bra.b   .L3
.L4:
            move.w  #$FF86,D0
            bra.w   .L11
.L5:
            move.l  D3,D0
            movea.l A3,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L11
            cmp.l   (2,A0),D7
            bne.b   .L6
            move.l  D2,D7
            bra.w   .L10
.L6:
            move.l  A1,-(SP)
            lea     (A4),A1
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            movea.l (SP)+,A0
            lea     ($26,A4),A1
            move.w  D1,D0
            ext.l   D0
            _BlockMove
            lea     (A4),A0
            move.l  (2,A0),D4
            move.l  D7,(2,A0)
            lea     ($26,A4),A1
            moveq   #$66,D1
            cmpi.b  #2,(A1)
            beq.b   .L7
            moveq   #$46,D1
            move.l  TimeLM,($E,A1)
.L7:
            move.w  ($A6,A2),D0
            jsr     BTINSERT
            beq.b   .L8
            cmpi.w  #$21,D0
            bne.w   .L11
            moveq   #$31,D0
            bne.w   .L11
.L8:
            move.l  D2,D7
            move.l  (2,A0),D0
            exg     D5,D0
            movea.l D6,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L11
            addq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bne.w   .L11
            lea     ($26,A4),A1
            move.b  (A1),D0
            move.l  D5,D1
            moveq   #1,D2
            bsr.w   UpdRtCnts
            move.l  D3,D0
            movea.l A3,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.b   .L11
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     BTDelete
            bne.b   .L11
            lea     ($26,A4),A1
            cmpi.b  #1,(A1)
            bne.b   .L9
            move.l  (6,A1),D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCREC
            bne.b   .L11
            move.l  D5,($A,A1)
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bne.b   .L11
.L9:
            move.l  D4,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.b   .L11
            subq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bne.b   .L11
            lea     ($26,A4),A1
            move.b  (A1),D0
            move.l  D4,D1
            moveq   #-1,D2
            bsr.w   UpdRtCnts
.L10:
            clr.w   D0
            move.l  D7,D2
            jsr     MarkVCBTime
            jsr     CMFLUSH
.L11:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMRenameCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D0,D3
            movea.l A0,A3
            move.l  A1,D5
            jsr     LOCCNODE
            bne.w   .L7
            move.l  D2,D4
            move.w  D1,D6
            movea.l A1,A0
            lea     ($26,A4),A1
            move.w  D6,D0
            ext.l   D0
            _BlockMove
            lea     (A4),A1
            move.l  (2,A1),D0
            movea.l D5,A0
            jsr     CMMAINT
            movea.l A1,A0
            lea     ($26,A4),A1
            move.w  D6,D1
            move.w  ($A6,A2),D0
            jsr     BTINSERT
            beq.b   .L4
            cmpi.w  #$21,D0
            bne.w   .L7
            lea     (A4),A1
            move.l  (2,A1),D0
            movea.l D5,A0
            moveq   #0,D2
            jsr     LOCCNODE
            bne.w   .L7
            move.l  D2,D7
            move.l  A0,D6
            lea     ($26,A4),A0
            move.b  (A0),D0
            cmp.b   (A1),D0
            bne.b   .L2
            cmpi.b  #1,D0
            bne.b   .L1
            move.l  (6,A1),D1
            cmp.l   (6,A0),D1
            beq.b   .L3
            bra.b   .L2
.L1:
            move.l  ($14,A1),D1
            cmp.l   ($14,A0),D1
            beq.b   .L3
.L2:
            moveq   #$31,D0
            bra.b   .L7
.L3:
            movea.l D6,A1
            lea     (6,A1),A1
            movea.l D5,A0
            jsr     UPDCNAME
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            bra.b   .L5
.L4:
            move.l  D2,D7
            move.l  D3,D0
            movea.l A3,A0
            move.l  D4,D2
            jsr     LOCCNODE
            bne.b   .L7
            lea     (A4),A0
            move.w  ($A6,A2),D0
            moveq   #0,D2
            jsr     BTDelete
            bne.b   .L7
.L5:
            lea     ($26,A4),A1
            cmpi.b  #1,(A1)
            bne.b   .L6
            move.l  (6,A1),D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     LOCCREC
            bne.b   .L7
            movea.l D5,A0
            lea     ($E,A1),A1
            jsr     UPDCNAME
            move.w  ($A6,A2),D0
            jsr     BTUpdate
.L6:
            clr.w   D0
            move.l  D7,D2
            jsr     MarkVCBTime
            jsr     CMFLUSH
.L7:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMUpdateCN:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A0-A1,-(A6)
            bsr.b   CMSetUp
            move.w  ($A6,A2),D0
            jsr     BTUpdate
            beq.b   .L1
            cmpi.w  #$20,D0
            bne.b   .L2
            moveq   #$30,D0
            bra.b   .L2
.L1:
            jsr     MarkVCBTime
            jsr     CMFLUSH
.L2:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1-D2/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMSetUp:
            move.l  ($770).w,-(SP)
            rts
vCMSetUp:
            suba.w  #$8C,A6
            movea.l A6,A4
            rts
sub_40812F14:
            cmpi.b  #1,D0
            bne.b   .L1
            add.l   D2,($76,A2)
            bra.b   UpdRtCnts
.L1:
            add.l   D2,($72,A2)
UpdRtCnts:
            cmpi.l  #2,D1
            bne.b   .L2
            cmpi.b  #1,D0
            bne.b   .L1
            add.w   D2,($70,A2)
            bra.b   .L2
.L1:
            add.w   D2,($14,A2)
.L2:
            rts
            dc.w    0
CMMAINT:
BUILDKEY:
            movem.l D0/A0-A1,-(SP)
            move.b  #6,(A1)
            clr.b   (1,A1)
            move.l  D0,(2,A1)
            clr.b   (6,A1)
            move.l  A0,D0
            beq.b   .L1
            move.l  A1,-(SP)
            lea     (6,A1),A1
            bsr.w   UPDCNAME
            move.b  (A1),D0
            movea.l (SP)+,A1
            add.b   D0,(A1)
.L1:
            movem.l (SP)+,D0/A0-A1
            rts
CMFLUSH:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  ($A6,A2),D1
            move.w  D1,D0
            jsr     BTFlush
            bne.b   .L2
            movea.l ($34E).w,A1
            btst    #7,(4,A1,D1.w)
            beq.b   .L1
            jsr     MarkVCB
            jsr     FlushMDB
            bne.b   .L2
.L1:
            clr.w   D0
.L2:
            movem.l (A6)+,D1/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMKEYCMP:
            movem.l D1-D2/A0-A3,-(SP)
            movea.l A0,A2
            movea.l A1,A3
            move.l  (2,A2),D0
            cmp.l   (2,A3),D0
            bhi.b   .L3
            bcs.b   .L1
            lea     (6,A2),A0
            lea     (6,A3),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
            _RelString
            beq.b   .L2
            bgt.b   .L3
.L1:
            moveq   #-1,D0
            bra.b   .L4
.L2:
            moveq   #0,D0
            bra.b   .L4
.L3:
            moveq   #1,D0
.L4:
            movem.l (SP)+,D1-D2/A0-A3
            tst.w   D0
            rts
LOCCNODE:
            move.l  (SP)+,-(A6)
            jsr     LOCCREC
            bne.b   .L1
            cmpi.b  #3,(A1)
            bne.b   .L1
            lea     ($E,A1),A0
            move.l  ($A,A1),D0
            bsr.w   LOCCREC
.L1:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
LOCCREC:
            move.l  ($7C8).w,-(SP)
            rts
VLOCCREC:
            move.l  (SP)+,-(A6)
            lea     (A4),A1
            jsr     CMMAINT
            move.l  A0,D0
            bne.b   .L1
            moveq   #0,D2
.L1:
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     BTSEARCH
            beq.b   .L2
            cmpi.w  #$20,D0
            bne.b   .L2
            moveq   #$30,D0
.L2:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
UPDCNAME:
            movem.l D0-D1/A0-A1,-(SP)
            moveq   #0,D0
            move.b  (A0)+,D0
            moveq   #$1F,D1
            cmp.w   D1,D0
            ble.b   .L1
            move.w  D1,D0
.L1:
            move.b  D0,(A1)+
            _BlockMove
            movem.l (SP)+,D0-D1/A0-A1
            rts
            ds.b    10
BTSvcs:
; BTClose
; Closes a BTree file.
BTClose:
            move.l  ($730).w,-(SP)
            rts
vBTClose:
            move.l  (SP)+,-(A6)
            movem.l D1-D4/A0-A4,-(A6)
            move.w  D0,D3
            move.w  D3,D0
            jsr     LocBTCB
            jsr     BTFlush
            bne.b   .BCExit
            move.w  D3,D0
            moveq   #1,D1
            movea.l (8,A4),A1
            jsr     FlushCache
            bne.b   .BCExit
            movea.l A4,A0
            _DisposPtr
            movea.l ($34E).w,A4
            clr.l   ($22,A4,D3.w)
            clr.w   D0
.BCExit:
            movem.l (A6)+,D1-D4/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTDelete:
            move.l  ($734).w,-(SP)
            rts
vBTDelete:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/A0-A4,-(A6)
            bsr.w   BTSetUp
            clr.l   ($12,A4)
            suba.l  A2,A2
            suba.l  A3,A3
            jsr     TreeSearch
            movea.l A1,A3
            bne.w   .BDExit1
            move.w  D1,D5
.BDDelete:
            movea.l A3,A1
            move.w  D5,D1
            jsr     DeleteRec
            movea.l A3,A0
            jsr     MarkBlock
            tst.w   D5
            bne.b   .L1
            bset    #6,(A4)
.L1:
            cmpi.b  #$FF,(8,A3)
            bne.b   .BDRemove
            subq.l  #1,($1E,A4)
.BDRemove:
            tst.w   ($A,A3)
            bgt.b   .BDNxtLev
            movea.l A3,A0
            jsr     GetLtSib
            bne.w   .BDExit1
            tst.l   D1
            beq.b   .L4
            move.l  (A3),(A1)
            moveq   #4,D1
            movea.l A1,A0
            jsr     RelNode
.L4:
            movea.l A3,A0
            jsr     GetRtSib
            bne.w   .BDExit1
            tst.l   D1
            beq.b   .BDUpdPtrs
            move.l  (4,A3),(4,A1)
            moveq   #4,D1
            movea.l A1,A0
            jsr     RelNode
.BDUpdPtrs:
            cmpi.b  #$FF,(8,A3)
            bne.b   .BDFree
            tst.l   (4,A3)
            bne.b   .L6
            move.l  (A3),($22,A4)
.L6:
            tst.l   (A3)
            bne.b   .BDFree
            move.l  (4,A3),($26,A4)
.BDFree:
            movea.l A3,A0
            jsr     ClrNode
            moveq   #4,D1
            jsr     RelNode
            suba.l  A3,A3
            move.w  ($10,A4),D0
            jsr     LocTPR
            move.l  (A0),D1
            move.w  (2,A4),D0
            jsr     FreeNode
            bset    #4,(A4)
            bclr    #6,(A4)
.BDNxtLev:
            subq.w  #1,($10,A4)
            beq.b   .BDRoot
            btst    #6,(A4)
            bne.b   .L9
            btst    #4,(A4)
            beq.w   .BDExit
.L9:
            move.w  ($10,A4),D0
            jsr     LocTPR
            move.w  (4,A0),D5
            move.l  (A0),D2
            moveq   #0,D1
            jsr     GetNode
            bne.w   .BDExit1
            movea.l A0,A2
.BDUpdKey:
            btst    #6,(A4)
            beq.b   .L10
            move.w  D5,D0
            movea.l A2,A1
            jsr     GetRecA
            move.l  A0,-(SP)
            movea.l A3,A1
            clr.w   D0
            jsr     GetRecA
            movea.l (SP)+,A1
            jsr     UpdIKey
            movea.l A2,A0
            jsr     MarkBlock
            tst.w   D5
            beq.b   .L10
            bclr    #6,(A4)
.L10:
            moveq   #0,D1
            movea.l A3,A0
            jsr     RelNode
            movea.l A2,A3
            move.l  D2,D3
            bclr    #4,(A4)
            beq.b   .L11
            bra.w   .BDDelete
.L11:
            btst    #6,(A4)
            bne.b   .BDNxtLev
            bra.b   .BDExit
.BDRoot:
            move.l  A3,D0
            bne.b   .BDUpdDepth
            clr.w   ($18,A4)
            clr.l   ($1A,A4)
            bra.b   .BDExit
.BDUpdDepth:
            cmpi.w  #1,($A,A3)
            bgt.b   .BDExit
            tst.b   (8,A3)
            bne.b   .BDExit
            subq.w  #1,($18,A4)
            moveq   #0,D1
            movea.l A3,A1
            jsr     LocRec
            move.l  (A1),($1A,A4)
            movea.l A3,A0
            jsr     ClrNode
            moveq   #4,D1
            jsr     RelNode
            suba.l  A3,A3
            move.l  D3,D1
            move.w  (2,A4),D0
            jsr     FreeNode
            move.l  ($1A,A4),D3
            move.l  D3,D2
            moveq   #0,D1
            jsr     GetNode
            bne.b   .BDExit1
            movea.l A0,A3
            bra.b   .BDUpdDepth
.BDExit:
            bset    #7,(A4)
            clr.w   D0
.BDExit1:
            move.w  D0,-(A6)
            movea.l A3,A0
            moveq   #0,D1
            jsr     RelNode
            move.w  (A6)+,D0
            bsr.w   BTCleanUp
            movem.l (A6)+,D1-D5/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTFlush:
            move.l  ($738).w,-(SP)
            rts
VBTFLUSH:
            move.l  (SP)+,-(A6)
            movem.l D1-D4/A0-A4,-(A6)
            move.w  D0,D3
            movea.l ($34E).w,A1
            movea.l ($14,A1,D3.w),A2
            tst.w   ($48,A2)
            beq.b   .L3
            jsr     LocBTCB
            bclr    #7,(A4)
            beq.b   .L2
            moveq   #0,D1
            moveq   #0,D2
            jsr     GetNode
            bne.b   .L3
            movea.l A0,A3
            move.w  #$1D,D0
            lea     ($18,A4),A0
            lea     ($E,A3),A1
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
            moveq   #4,D1
            movea.l A3,A0
            jsr     RelNode
            bne.b   .L3
.L2:
            move.w  D3,D0
            moveq   #0,D1
            movea.l (8,A4),A1
            jsr     FlushCache
.L3:
            movem.l (A6)+,D1-D4/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTGetRecord:
            move.l  ($73C).w,-(SP)
            rts
vBTGetRecord:
            move.l  (SP)+,-(A6)
            movem.l D3-D5/A2-A4,-(A6)
            bsr.w   BTSetUp
            move.w  D1,D5
            suba.l  A3,A3
            move.w  ($16,A4),D4
            move.l  ($12,A4),D3
            bne.b   .L1
            moveq   #$20,D0
            bra.b   .GRExit1
.L1:
            add.w   D5,D4
.L2:
            bsr.b   GRGetNode
            bne.b   .GRExit1
.L3:
            tst.w   D4
            blt.b   .L5
            move.w  ($A,A3),D1
            cmp.w   D1,D4
            blt.b   .L8
            move.l  (A3),D0
            beq.b   .L4
            move.l  D0,D3
            sub.w   D1,D4
            bra.b   .L2
.L4:
            move.w  D1,D4
            subq.w  #1,D4
            bra.b   .L7
.L5:
            move.l  (4,A3),D0
            beq.b   .L6
            move.l  D0,D3
            bsr.b   GRGetNode
            bne.b   .GRExit1
            add.w   ($A,A3),D4
            bra.b   .L3
.L6:
            moveq   #0,D4
.L7:
            move.l  D3,($12,A4)
            move.w  D4,($16,A4)
            moveq   #$20,D0
            bra.b   .GRExit1
.L8:
            move.w  D4,D1
            movea.l A3,A1
            jsr     LocRec
            move.l  D3,($12,A4)
            move.w  D4,($16,A4)
            clr.w   D0
.GRExit1:
            movem.l D0-D1/A0-A1,-(A6)
            bsr.b   GRRelNode
            movem.l (A6)+,D0-D1/A0-A1
            move.l  D3,D2
            bsr.w   BTCleanUp
            movem.l (A6)+,D3-D5/A2-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GRGetNode:
            move.l  (SP)+,-(A6)
            bsr.b   GRRelNode
            moveq   #0,D1
            move.l  D3,D2
            jsr     GetNode
            bne.b   .L1
            movea.l A0,A3
.L1:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GRRelNode:
            move.l  (SP)+,-(A6)
            moveq   #0,D1
            movea.l A3,A0
            jsr     RelNode
            suba.l  A3,A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTINSERT:
            move.l  ($740).w,-(SP)
            rts
VBTINSERT:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A4,-(A6)
            jsr     LocBTCB
            move.l  A1,D7
            move.w  D1,D6
            move.l  A0,D5
            moveq   #1,D3
            add.w   ($18,A4),D3
            cmp.l   ($32,A4),D3
            ble.b   .L2
.L1:
            jsr     ExtBTFile
            bne.w   .L18
            cmp.l   ($32,A4),D3
            bgt.b   .L1
.L2:
            move.w  (2,A4),D0
            bsr.w   BTSetUp
            movem.l D6-D7,-(A6)
            moveq   #0,D4
            suba.l  A2,A2
            suba.l  A3,A3
            clr.l   ($12,A4)
            movea.l ($C,A4),A1
            lea     ($30,A1),A1
            movea.l D5,A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #2,D0
            lsr.l   #1,D0
            lsl.l   #1,D0
            add.w   D0,D6
            _BlockMove
            addq.w  #1,D6
            lsr.w   #1,D6
            lsl.w   #1,D6
            move.l  A1,D7
            jsr     TreeSearch
            movea.l A1,A3
            bne.b   .L3
            moveq   #$21,D0
            bra.w   .L17
.L3:
            cmpi.w  #$20,D0
            bne.w   .L17
            move.l  D2,D3
            move.w  D1,D5
            tst.w   ($10,A4)
            bgt.b   .L4
            move.w  (2,A4),D0
            jsr     BTAlloc
            bne.w   .L17
            move.l  D1,D3
            jsr     InitNode
            bne.w   .L17
            movea.l A0,A3
            move.b  #$FF,(8,A3)
            moveq   #1,D0
            move.b  D0,(9,A3)
            move.w  D0,($18,A4)
            move.l  D3,($1A,A4)
            move.l  D3,($22,A4)
            move.l  D3,($26,A4)
            move.w  #1,($10,A4)
.L4:
            movea.l D7,A0
            move.w  D6,D0
            movea.l A3,A1
            move.w  D5,D1
            jsr     InsertRec
            bne.b   .L5
            tst.w   D5
            bne.b   .L9
            bset    #6,(A4)
            bra.b   .L9
.L5:
            movea.l A3,A0
            jsr     GetLtSib
            bne.w   .L17
            tst.l   D1
            beq.b   .L6
            move.l  D1,D2
            movea.l A1,A2
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     BTMAINT1
            bne.b   .L6
            bra.b   .L8
.L6:
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     SPLITLT
            beq.b   .L7
            moveq   #$23,D0
            bra.w   .L17
.L7:
            bset    #5,(A4)
.L8:
            bset    #6,(A4)
            move.w  D1,D5
            movea.l A2,A0
            jsr     MarkBlock
.L9:
            movea.l A3,A0
            jsr     MarkBlock
            cmpi.b  #$FF,(8,A1)
            bne.b   .L11
            movem.l (A6),D0/A0
            jsr     UpdDRec
            addq.l  #1,($1E,A4)
            move.w  D5,($16,A4)
            move.l  D3,D0
            cmpa.l  A3,A1
            beq.b   .L10
            move.l  D2,D0
.L10:
            move.l  D0,($12,A4)
.L11:
            btst    #6,(A4)
            bne.b   .L12
            btst    #5,(A4)
            beq.w   .L16
.L12:
            subq.w  #1,($10,A4)
            beq.w   .L15
            move.w  ($10,A4),D0
            jsr     LocTPR
            move.w  (4,A0),D5
            move.l  (A0),D3
            move.l  D2,-(A6)
            moveq   #0,D1
            move.l  D3,D2
            jsr     GetNode
            bne.w   .L17
            move.l  A0,D4
            move.l  (A6)+,D2
            btst    #6,(A4)
            beq.b   .L13
            move.w  D5,D0
            movea.l D4,A1
            jsr     GetRecA
            move.l  A0,-(SP)
            movea.l A3,A1
            clr.w   D0
            jsr     GetRecA
            movea.l (SP)+,A1
            jsr     UpdIKey
            movea.l D4,A0
            jsr     MarkBlock
            tst.w   D5
            beq.b   .L13
            bclr    #6,(A4)
.L13:
            moveq   #0,D1
            movea.l A3,A0
            jsr     RelNode
            movea.l D4,A3
            moveq   #0,D4
            btst    #5,(A4)
            beq.b   .L14
            movea.l A2,A1
            move.l  D2,D0
            jsr     BTMaint2
.L14:
            moveq   #0,D1
            movea.l A2,A0
            jsr     RelNode
            suba.l  A2,A2
            btst    #5,(A4)
            beq.w   .L11
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            move.l  A0,D7
            jsr     GetMaxKey
            addq.w  #4,D0
            move.w  D0,D6
            bclr    #5,(A4)
            bra.w   .L4
.L15:
            btst    #5,(A4)
            beq.b   .L16
            move.w  (2,A4),D0
            jsr     BTAlloc
            bne.b   .L17
            move.l  D1,D3
            move.l  D3,D1
            jsr     InitNode
            bne.b   .L17
            move.l  A0,D4
            clr.b   (8,A0)
            moveq   #1,D0
            add.w   ($18,A4),D0
            move.b  D0,(9,A0)
            movea.l A2,A1
            move.l  D2,D0
            jsr     BTMaint2
            jsr     GetMaxKey
            addq.w  #4,D0
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            movea.l D4,A1
            clr.w   D1
            jsr     InsertRec
            move.w  #1,D0
            jsr     LocTPR
            move.l  (A0),D0
            movea.l A3,A1
            jsr     BTMaint2
            jsr     GetMaxKey
            addq.w  #4,D0
            movea.l ($C,A4),A0
            lea     ($30,A0),A0
            movea.l D4,A1
            move.w  #1,D1
            jsr     InsertRec
            movea.l D4,A0
            jsr     MarkBlock
            addq.w  #1,($18,A4)
            move.l  D3,($1A,A4)
.L16:
            bset    #7,(A4)
            clr.w   D0
.L17:
            move.w  D0,-(A6)
            movea.l A2,A0
            moveq   #0,D1
            jsr     RelNode
            movea.l A3,A0
            jsr     RelNode
            movea.l D4,A0
            jsr     RelNode
            move.w  (A6)+,D0
            move.l  ($12,A4),D2
            clr.l   ($12,A4)
            bsr.w   BTCleanUp
            addq.l  #8,A6
.L18:
            movem.l (A6)+,D1/D3-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTOPEN:
            move.l  ($744).w,-(SP)
            rts
VBTOPEN:
            move.l  (SP)+,-(A6)
            movem.l D1-D5/A0-A4,-(A6)
            move.w  D0,D3
            move.l  A0,D4
            move.l  A1,D5
            moveq   #$36,D0
            _NewPtrSysClear
            bne.w   .L6
            movea.l A0,A4
            movea.l ($34E).w,A3
            move.l  A4,($22,A3,D3.w)
            move.w  D3,(2,A4)
            move.l  D4,(4,A4)
            move.l  D5,(8,A4)
            move.w  D3,D0
            movea.l D5,A1
            moveq   #0,D1
            moveq   #0,D2
            jsr     GetBlock
            bne.b   .L6
            movea.l A0,A2
            lea     ($E,A2),A0
            move.w  ($12,A0),D0
            beq.b   .L1
            move.w  D0,D1
            andi.w  #$1FF,D1
            bne.b   .L1
            move.l  ($C,A3,D3.w),D2
            divu.w  D0,D2
            swap    D2
            clr.w   D2
            swap    D2
            cmp.l   ($16,A0),D2
            bne.b   .L1
            cmp.l   ($1A,A0),D2
            bcs.b   .L1
            subq.l  #1,D2
            cmpi.b  #8,(A0)
            bhi.b   .L1
            cmp.l   (2,A0),D2
            bcs.b   .L1
            cmp.l   ($A,A0),D2
            bcs.b   .L1
            cmp.l   ($E,A0),D2
            bcc.b   .L2
.L1:
            moveq   #$25,D0
            bra.b   .L4
.L2:
            move.w  #$1D,D0
            lea     ($E,A2),A0
            lea     ($18,A4),A1
.L3:
            move.b  (A0)+,(A1)+
            dbra    D0,.L3
            clr.w   D0
.L4:
            move.w  D0,-(A6)
            movea.l D5,A1
            moveq   #0,D1
            movea.l A2,A0
            jsr     RelBlock
            beq.b   .L5
            move.w  D0,(A6)
.L5:
            move.w  (A6)+,D0
.L6:
            movem.l (A6)+,D1-D5/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTSEARCH:
            move.l  ($748).w,-(SP)
            rts
vBTSearch:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A2-A4,-(A6)
            bsr.w   BTSetUp
            movea.l A0,A3
            suba.l  A2,A2
            tst.l   D2
            beq.b   .BSTSrch
            moveq   #0,D1
            jsr     GetNode
            bne.b   .BSExit
            movea.l A0,A2
            cmpi.b  #$FF,(8,A0)
            bne.b   .L1
            tst.w   ($A,A0)
            ble.b   .L1
            movea.l A3,A0
            movea.l A2,A1
            jsr     SearchNode
            beq.b   .BSTSrch1
.L1:
            movea.l A2,A0
            moveq   #0,D1
            jsr     RelNode
            bne.b   .BSExit
.BSTSrch:
            movea.l A3,A0
            jsr     TreeSearch
            movea.l A1,A2
            beq.b   .BSTSrch1
            cmpi.w  #$20,D0
            bne.b   .BSExit1
.BSTSrch1:
            move.w  D1,D5
            move.w  D0,-(A6)
            move.l  D2,($12,A4)
            move.w  D5,($16,A4)
            tst.w   (A6)
            bne.b   .BSExit
            move.w  D5,D0
            movea.l A2,A1
            jsr     LocRec
.BSExit:
            movem.l D1-D2/A0-A1,-(A6)
            movea.l A2,A0
            moveq   #0,D1
            jsr     RelNode
            movem.l (A6)+,D1-D2/A0-A1
            move.w  (A6)+,D0
.BSExit1:
            bsr.b   BTCleanUp
            movem.l (A6)+,D3-D7/A2-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTUpdate:
            move.l  ($74C).w,-(SP)
            rts
vBTUpdate:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1/A4,-(A6)
            jsr     LocBTCB
            moveq   #2,D1
            jsr     GetNode
            bne.b   .BUExit
            moveq   #4,D1
            jsr     RelNode
            bne.b   .BUExit
            clr.w   D0
.BUExit:
            movem.l (A6)+,D1/A0-A1/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTCleanUp:
            move.l  D0,-(SP)
            bsr.b   CalBTVars
            adda.l  D0,A6
            clr.l   ($C,A4)
            move.l  (SP)+,D0
            rts
BTSetUp:
            move.l  D0,-(SP)
            jsr     LocBTCB
            bsr.b   CalBTVars
            suba.l  D0,A6
            move.l  A6,($C,A4)
            bclr    #5,(A4)
            bclr    #4,(A4)
            bclr    #6,(A4)
            move.l  (SP)+,D0
            rts
CalBTVars:
            jsr     GetMaxKey
            addi.w  #$34,D0
            rts
            ds.b    14
BTAlloc:
AllocNode:
            move.l  ($758).w,-(SP)
            rts
vAllocNode:
            move.l  (SP)+,-(A6)
            movem.l D2-D4/A2-A3,-(A6)
            moveq   #0,D4
            suba.l  A2,A2
.L1:
            bsr.w   GetMap_BTALLOC
            beq.b   .L2
            cmpi.w  #$20,D0
            bne.b   .L8
            moveq   #$22,D0
            bra.b   .L8
.L2:
            move.w  D1,D2
            lsr.w   #2,D2
            subq.w  #1,D2
            movea.l A1,A0
.L3:
            move.l  (A0)+,D0
            cmpi.l  #$FFFFFFFF,D0
            bne.b   .L4
            dbra    D2,.L3
            ext.l   D1
            lsl.l   #3,D1
            add.l   D1,D4
            bra.b   .L1
.L4:
            move.w  #$1F,D2
.L5:
            btst    D2,D0
            beq.b   .L6
            dbra    D2,.L5
.L6:
            bset    D2,D0
            move.l  D0,D3
            lea     (-4,A0),A0
            movea.l A0,A3
            suba.l  A1,A0
            move.l  A0,D1
            lsl.l   #3,D1
            addi.l  #$1F,D1
            ext.l   D2
            sub.l   D2,D1
            add.l   D4,D1
            move.l  ($2E,A4),D0
            cmp.l   D1,D0
            bgt.b   .L7
            bsr.w   RelMap
            moveq   #$22,D0
            bra.b   .L8
.L7:
            move.l  D3,(A3)
            movea.l A2,A0
            jsr     MarkBlock
            subq.l  #1,($32,A4)
            bset    #7,(A4)
            clr.w   D0
            bsr.w   RelMap
.L8:
            movem.l (A6)+,D2-D4/A2-A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtBTFile:
            move.l  ($760).w,-(SP)
            rts
vExtBTFile:
            move.l  (SP)+,-(A6)
            movem.l D2-D6/A2,-(A6)
            move.w  (2,A4),D1
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            moveq   #0,D3
            move.l  ($1E,A1,D1.w),D4
            jsr     ExtendFile
            beq.b   .L1
            cmpi.w  #$FFDE,D0
            bne.w   .L7
            tst.l   D6
            beq.w   .L7
.L1:
            move.l  ($2E,A4),D3
            move.l  D3,D4
            move.l  ($C,A1,D1.w),D5
            divu.w  ($2A,A4),D5
            swap    D5
            clr.w   D5
            swap    D5
            move.l  D5,($2E,A4)
            subq.l  #1,D5
            move.l  D5,D6
            suba.l  A2,A2
.L2:
            bsr.w   GetMap_BTALLOC
            bne.w   .L7
            ext.l   D1
            lsl.l   #3,D1
            sub.l   D1,D3
            sub.l   D1,D5
            bge.b   .L3
            subq.l  #1,D4
            bra.b   .L6
.L3:
            tst.l   (A2)
            bne.b   .L2
            move.l  D4,(A2)
            tst.l   D3
            bge.b   .L4
            add.l   D1,D3
            divu.w  #8,D3
            move.w  D3,D0
            clr.w   D3
            swap    D3
            moveq   #7,D1
            sub.l   D3,D1
            bset    D1,(0,A1,D0.w)
            moveq   #-1,D3
.L4:
            movea.l A2,A0
            jsr     MarkBlock
            bsr.w   RelMap
            bne.b   .L7
            move.l  D4,D1
            jsr     InitNode
            bne.b   .L7
            movea.l A0,A2
            move.b  #2,(8,A2)
            move.w  #1,($A,A2)
            move.w  ($2A,A4),D1
            moveq   #-$12,D0
            add.w   D1,D0
            lsr.w   #2,D0
            lsl.w   #2,D0
            addi.w  #$E,D0
            move.w  D0,(-4,A2,D1.w)
            tst.l   D3
            blt.b   .L5
            move.b  #$80,($E,A2)
.L5:
            movea.l A2,A0
            jsr     MarkBlock
.L6:
            sub.l   D4,D6
            add.l   D6,($32,A4)
            bset    #7,(A4)
            clr.b   D0
            bsr.w   RelMap
            st      ($377).w
            bsr.w   sub_408139E6
.L7:
            movem.l (A6)+,D2-D6/A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FreeNode:
            move.l  ($75C).w,-(SP)
            rts
vFreeNode:
            move.l  (SP)+,-(A6)
            movem.l D2-D3/A2,-(A6)
            move.l  D1,D3
            suba.l  A2,A2
.L1:
            bsr.b   GetMap_BTALLOC
            bne.b   .L2
            ext.l   D1
            lsl.l   #3,D1
            sub.l   D1,D3
            bge.b   .L1
            add.l   D1,D3
            divu.w  #8,D3
            moveq   #0,D0
            move.w  D3,D0
            clr.w   D3
            swap    D3
            moveq   #7,D1
            sub.l   D3,D1
            bclr    D1,(0,A1,D0.w)
            movea.l A2,A0
            jsr     MarkBlock
            addq.l  #1,($32,A4)
            bset    #7,(A4)
            clr.b   D0
            bsr.b   RelMap
.L2:
            movem.l (A6)+,D2-D3/A2
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetMap_BTALLOC:
            move.l  (SP)+,-(A6)
            moveq   #0,D2
            move.l  A2,D0
            beq.b   .L1
            move.l  (A2),D2
            bsr.b   RelMap
            bne.b   .L3
            tst.l   D2
            bne.b   .L1
            moveq   #$20,D0
            bra.b   .L3
.L1:
            moveq   #0,D1
            jsr     GetNode
            bne.b   .L3
            movea.l A0,A2
            moveq   #0,D0
            cmpi.b  #1,(8,A2)
            bne.b   .L2
            moveq   #2,D0
.L2:
            movea.l A2,A1
            jsr     GetRecA
            move.l  A0,D1
            move.w  ($A,A2),D0
            jsr     GetRecA
            movea.l D1,A1
            suba.l  A1,A0
            move.w  A0,D1
            clr.w   D0
.L3:
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
RelMap:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            moveq   #0,D1
            movea.l A2,A0
            jsr     RelNode
            suba.l  A2,A2
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
sub_408139E6:
            move.l  ($7B4).w,-(SP)
            rts
VUPDALTMDB:
            move.l  (SP)+,-(A6)
            movem.l D0-D2/A0-A3/A5,-(A6)
            move.w  (2,A4),D1
            movea.l ($34E).w,A5
            lea     (0,A5,D1.w),A5
            movea.l ($14,A5),A2
            move.w  ($48,A2),D2
            jsr     FindDrive
            bne.w   .L10
            movem.l D0-D1/A0/A2,-(SP)
            suba.w  #$80,SP
            movea.l SP,A2
            moveq   #$18,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            movea.l SP,A0
            moveq   #0,D2
            move.w  ($C,A3),D2
            cmpi.w  #$FFFB,(8,A3)
            bne.b   .L5
            move.w  (6,A3),($16,A0)
            move.w  (8,A3),($18,A0)
            move.w  #6,($1A,A0)
            move.w  #$10,($1C,A0)
            move.l  A2,($1E,A0)
            _Status
            bne.b   .L4
            move.w  ($1C,A0),D0
            beq.b   .L4
            subq.w  #1,D0
.L2:
            btst    #6,(4,A2)
            bne.b   .L3
            addq.w  #8,A2
            dbra    D0,.L2
            bra.b   .L4
.L3:
            move.l  (A2),D2
            bra.b   .L6
.L4:
            move.w  #$320,D2
            tst.b   ($C,A3)
            beq.b   .L5
            add.l   D2,D2
.L5:
            tst.w   (4,A3)
            beq.b   .L6
            move.l  ($C,A3),D2
            swap    D2
.L6:
            lea     ($B2,SP),SP
            movem.l (SP)+,D0-D1/A0/A2
            subq.l  #2,D2
            move.w  ($4E,A2),D0
            moveq   #1,D1
            movea.l (8,A4),A1
            jsr     GetBlock
            bne.b   .L10
            moveq   #2,D1
            cmpi.w  #$4244,(A0)
            bne.b   .L9
            lea     ($92,A0),A3
            moveq   #4,D0
            cmp.l   (A5),D0
            beq.b   .L7
            moveq   #3,D0
            cmp.l   (A5),D0
            bne.b   .L9
            lea     ($82,A0),A3
.L7:
            move.l  ($C,A5),(A3)+
            moveq   #2,D0
            lea     ($26,A5),A1
.L8:
            move.l  (A1)+,(A3)+
            dbra    D0,.L8
            move.l  TimeLM,(6,A0)
            moveq   #1,D1
.L9:
            jsr     RelBlock
.L10:
            movem.l (A6)+,D0-D2/A0-A3/A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
BTMAINT1:
ROTATELT:
            movem.l D2-D7/A2-A5,-(SP)
            movea.l A0,A5
            move.w  D0,D5
            movea.l A2,A1
            jsr     GetNodeSiz
            move.w  D0,D2
            movea.l A3,A1
            jsr     GetNodeSiz
            add.w   D2,D0
            add.w   D5,D0
            addq.w  #2,D0
            lsr.w   #1,D0
            move.w  D0,D6
            move.w  ($A,A2),D3
            move.w  D1,D4
            add.w   D3,D4
            moveq   #-1,D7
.L1:
            cmp.w   D3,D4
            bne.b   .L2
            add.w   D5,D2
            bra.b   .L4
.L2:
            move.w  D3,D0
            sub.w   ($A,A2),D0
            cmp.w   D4,D3
            ble.b   .L3
            subq.w  #1,D0
.L3:
            jsr     GetRecA
            add.w   D0,D2
.L4:
            addq.w  #2,D2
            move.w  ($2A,A4),D1
            subi.w  #$10,D1
            cmp.w   D1,D2
            ble.b   .L5
            swap    D7
            tst.w   D7
            bge.b   .L9
            moveq   #-1,D0
            bra.w   .L16
.L5:
            move.w  D6,D0
            lsl.w   #1,D0
            sub.w   D2,D0
            cmp.w   D1,D0
            bgt.b   .L6
            move.w  D3,D7
.L6:
            cmp.w   D6,D2
            blt.b   .L8
            beq.b   .L7
            swap    D7
.L7:
            tst.w   D7
            bge.b   .L9
            swap    D7
            tst.w   D7
            bge.b   .L9
.L8:
            swap    D7
            move.w  #$FFFF,D7
            addq.w  #1,D3
            move.w  ($A,A2),D1
            add.w   ($A,A3),D1
            cmp.w   D1,D3
            ble.b   .L1
            moveq   #-1,D0
            bra.b   .L16
.L9:
            move.w  ($A,A2),D3
.L10:
            cmp.w   D3,D4
            bne.b   .L11
            movea.l A2,A1
            movea.l A5,A0
            move.w  D5,D0
            move.w  ($A,A1),D1
            jsr     InsertRec
            bne.b   .L14
            movea.l A1,A5
            move.w  D1,D5
            bra.b   .L12
.L11:
            movea.l A2,A0
            movea.l A3,A1
            bsr.w   RotRecLt
            bne.b   .L14
.L12:
            cmp.w   D7,D3
            beq.b   .L13
            addq.w  #1,D3
            bra.b   .L10
.L13:
            cmp.w   D7,D4
            ble.b   .L15
            movea.l A3,A1
            movea.l A5,A0
            move.w  D5,D0
            move.w  D4,D1
            sub.w   D7,D1
            subq.w  #1,D1
            jsr     InsertRec
            bne.b   .L14
            clr.w   D0
            bra.b   .L16
.L14:
            moveq   #$40,D0
            _SysError
.L15:
            clr.w   D0
            movea.l A5,A1
            move.w  D5,D1
.L16:
            movem.l (SP)+,D2-D7/A2-A5
            tst.w   D0
            rts
SPLITLT:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A3,-(A6)
            move.l  A0,D7
            move.w  D0,D6
            move.w  D1,D5
            move.w  ($10,A4),D0
            jsr     LocTPR
            move.l  (A0),D4
            move.w  (2,A4),D0
            jsr     BTAlloc
            bne.b   .L4
            move.l  D1,D3
            move.l  A2,D0
            beq.b   .L1
            move.l  D3,(A2)
            moveq   #4,D1
            movea.l A2,A0
            jsr     RelNode
            bne.b   .L4
.L1:
            move.l  D3,D1
            jsr     InitNode
            bne.b   .L4
            movea.l A0,A2
            move.b  (8,A3),(8,A2)
            move.l  (4,A3),(4,A2)
            move.l  D4,(A2)
            move.l  D3,(4,A3)
            moveq   #1,D0
            add.w   ($18,A4),D0
            sub.w   ($10,A4),D0
            move.b  D0,(9,A2)
            cmpi.b  #$FF,(8,A2)
            bne.b   .L2
            tst.l   (4,A2)
            bne.b   .L2
            move.l  D3,($22,A4)
.L2:
            movea.l D7,A0
            move.w  D6,D0
            move.w  D5,D1
            jsr     BTMAINT1
            beq.b   .L3
            bra.b   .L4
.L3:
            clr.w   D0
            move.l  D3,D2
.L4:
            movem.l (A6)+,D3-D7/A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TreeSearch:
            move.l  ($7CC).w,-(SP)
            rts
vTreeSearch:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A2-A3,-(A6)
            move.l  A0,D7
            tst.w   ($18,A4)
            bgt.b   .L1
            moveq   #$20,D0
            suba.l  A1,A1
            moveq   #0,D1
            moveq   #0,D2
            clr.w   ($10,A4)
            bra.b   .L5
.L1:
            moveq   #1,D6
            move.l  ($1A,A4),D3
.L2:
            moveq   #0,D1
            move.l  D3,D2
            jsr     GetNode
            bne.b   .L5
            movea.l A0,A1
            movea.l D7,A0
            jsr     SearchNode
            move.w  D0,D5
            move.w  D1,D4
            move.w  D6,D0
            jsr     LocTPR
            movea.l A0,A3
            move.l  D3,(A3)
            move.w  D4,D2
            tst.w   D5
            beq.b   .L3
            subq.w  #1,D2
            bge.b   .L3
            move.w  D4,D2
.L3:
            move.w  D2,(4,A3)
            cmp.w   ($18,A4),D6
            beq.b   .L4
            move.w  D2,D1
            move.l  A1,-(SP)
            jsr     LocRec
            move.l  (A1),D3
            movea.l (SP)+,A1
            moveq   #0,D1
            movea.l A1,A0
            jsr     RelNode
            addq.w  #1,D6
            bra.b   .L2
.L4:
            move.w  D6,($10,A4)
            move.w  D4,D1
            move.w  D5,D0
            move.l  D3,D2
.L5:
            movem.l (A6)+,D3-D7/A2-A3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
RotRecLt:
            movem.l A2-A3,-(SP)
            movea.l A0,A2
            movea.l A1,A3
            moveq   #0,D0
            jsr     GetRecA
            lea     ($E,A1),A0
            movea.l A2,A1
            move.w  ($A,A1),D1
            jsr     InsertRec
            movea.l A3,A1
            beq.b   .L1
            moveq   #-1,D0
            bra.b   .L2
.L1:
            clr.w   D1
            jsr     DeleteRec
            clr.w   D0
.L2:
            tst.w   D0
            movem.l (SP)+,A2-A3
            rts
            ds.b    8
BTMaint2:
BuildIRec:
            move.l  D2,-(SP)
            move.l  D0,D2
            clr.w   D0
            bsr.w   GetRecA
            movea.l ($C,A4),A1
            lea     ($30,A1),A1
            jsr     UpdIKey
            bsr.w   GetMaxKey
            move.l  D2,(0,A1,D0.w)
            move.l  (SP)+,D2
            rts
ChkNode:
            movem.l D1-D2/A0-A2,-(SP)
            move.w  (2,A4),D1
            movea.l ($34E).w,A2
            move.l  ($C,A2,D1.w),D0
            divu.w  ($2A,A4),D0
            moveq   #0,D1
            move.w  D0,D1
            cmp.l   (A1),D1
            bls.b   .L2
            cmp.l   (4,A1),D1
            bls.b   .L2
            move.b  (8,A1),D0
            addq.b  #1,D0
            cmpi.b  #3,D0
            bhi.b   .L2
            move.b  (9,A1),D0
            cmp.b   ($19,A4),D0
            bhi.b   .L2
            moveq   #0,D1
            move.w  ($2A,A4),D1
            moveq   #-$E,D0
            add.l   D1,D0
            divu.w  #6,D0
            cmp.w   ($A,A1),D0
            bcs.b   .L2
            move.w  ($A,A1),D1
            move.w  D1,D0
            bsr.w   GetOffset
            moveq   #2,D2
            add.l   A0,D2
            sub.l   A1,D2
.L1:
            move.w  (A0)+,D0
            btst    #0,D0
            bne.b   .L2
            cmpi.w  #$E,D0
            bcs.b   .L2
            cmp.w   D2,D0
            bcc.b   .L2
            move.w  D0,D2
            dbra    D1,.L1
            bra.b   .L3
.L2:
            moveq   #$24,D0
            bra.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (SP)+,D1-D2/A0-A2
            tst.w   D0
            rts
ClrNode:
            movem.l D0-D1/A0,-(SP)
            moveq   #3,D1
            add.w   ($2A,A4),D1
            lsr.w   #2,D1
            subq.w  #1,D1
            moveq   #0,D0
.L1:
            move.l  D0,(A0)+
            dbra    D1,.L1
            movem.l (SP)+,D0-D1/A0
            rts
DeleteRec:
            movem.l D2-D6/A2-A5,-(SP)
            move.w  D1,D5
            move.w  D1,D0
            jsr     GetOffset
            move.l  A0,D6
            move.w  D0,D4
            lea     (-2,A0),A3
            move.w  (A3),D3
            move.w  ($A,A1),D0
            jsr     GetOffset
            movea.l A0,A2
            move.w  D0,D2
            movea.l A1,A5
            lea     (0,A5,D3.w),A0
            lea     (0,A5,D4.w),A1
            move.w  D2,D0
            sub.w   D3,D0
            jsr     MovRecLt
            subq.w  #1,($A,A5)
            movea.l A3,A0
            movea.l D6,A1
            move.w  ($A,A5),D0
            sub.w   D5,D0
            move.w  D4,D1
            sub.w   D3,D1
            jsr     MovOffRt
            movem.l (SP)+,D2-D6/A2-A5
            rts
GetLtSib:
            move.l  (SP)+,-(A6)
            movem.l D2-D3,-(A6)
            clr.b   D3
            bra.b   GetRtSib.L1
GetRtSib:
            move.l  (SP)+,-(A6)
            movem.l D2-D3,-(A6)
            moveq   #1,D3
.L1:
            tst.b   D3
            bne.b   .L2
            move.l  (4,A0),D2
            bra.b   .L3
.L2:
            move.l  (A0),D2
.L3:
            bne.b   .L4
            moveq   #0,D1
            bra.b   .L5
.L4:
            moveq   #0,D1
            bsr.b   GetNode
            bne.b   .L6
            move.l  D2,D1
            movea.l A0,A1
.L5:
            clr.w   D0
.L6:
            movem.l (A6)+,D2-D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetMaxKey:
            moveq   #2,D0
            add.w   ($2C,A4),D0
            lsr.w   #1,D0
            lsl.w   #1,D0
            rts
GetNode:
            move.l  ($750).w,-(SP)
            rts
vGetNode:
            move.l  (SP)+,-(A6)
            movem.l D1/A1,-(A6)
            move.w  (2,A4),D0
            movea.l (8,A4),A1
            jsr     GetBlock
            bne.b   .L1
            movea.l A0,A1
            bsr.w   ChkNode
            beq.b   .L1
            move.w  D0,-(A6)
            moveq   #2,D1
            movea.l (8,A4),A1
            jsr     RelBlock
            move.w  (A6)+,D0
.L1:
            movem.l (A6)+,D1/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetNodeSiz:
            move.l  D1,-(SP)
            move.w  ($A,A1),D1
            move.w  D1,D0
            jsr     GetOffset
            subi.w  #$E,D0
            lsl.w   #1,D1
            add.w   D1,D0
            move.l  (SP)+,D1
            rts
GetOffset:
            bsr.b   GetOffA
            move.w  (A0),D0
            rts
GetOffA:
            suba.l  A0,A0
            movea.w ($2A,A4),A0
            adda.l  A1,A0
            lsl.w   #1,D0
            neg.w   D0
            lea     (-2,A0,D0.w),A0
            rts
GetRecA:
            movem.l D1-D2,-(SP)
            move.w  D0,D1
            bsr.b   GetOffset
            move.w  D0,D2
            move.w  D1,D0
            addq.w  #1,D0
            bsr.b   GetOffset
            sub.w   D2,D0
            lea     (0,A1,D2.w),A0
            movem.l (SP)+,D1-D2
            rts
InitNode:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            move.l  D1,D2
            move.w  (2,A4),D0
            moveq   #4,D1
            movea.l (8,A4),A1
            jsr     GetBlock
            bne.b   .L1
            bsr.w   ClrNode
            move.w  ($2A,A4),D2
            move.w  #$E,(-2,A0,D2.w)
            clr.w   D0
.L1:
            movem.l (A6)+,D1-D2/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
InsertRec:
            movem.l D1-D7/A1-A5,-(SP)
            move.w  D0,D7
            move.w  D1,D6
            move.l  A0,D5
            move.w  D1,D0
            jsr     GetOffset
            move.w  D0,D4
            move.w  ($A,A1),D0
            jsr     GetOffset
            movea.l A0,A3
            move.w  D0,D3
            move.l  A3,D1
            moveq   #0,D0
            move.w  D3,D0
            add.l   A1,D0
            sub.l   D0,D1
            moveq   #2,D0
            add.w   D7,D0
            cmp.w   D0,D1
            bge.b   .L1
            moveq   #-1,D0
            bra.b   .L2
.L1:
            movea.l A1,A5
            lea     (0,A5,D4.w),A0
            lea     (0,A0,D7.w),A1
            move.w  D3,D0
            sub.w   D4,D0
            jsr     MovRecRt
            movea.l A3,A0
            lea     (-2,A0),A1
            move.w  ($A,A5),D0
            sub.w   D6,D0
            move.w  D7,D1
            jsr     MovOffLt
            movea.l D5,A0
            lea     (0,A5,D4.w),A1
            move.w  D7,D0
            jsr     MovRecLt
            addq.w  #1,($A,A5)
            clr.w   D0
.L2:
            movem.l (SP)+,D1-D7/A1-A5
            tst.w   D0
            rts
LocBTCB:
            movea.l ($34E).w,A4
            movea.l ($22,A4,D0.w),A4
            rts
LocRec:
            movem.l D0/D2-D3,-(SP)
            move.w  D1,D3
            move.w  D3,D0
            jsr     GetRecA
            move.l  A0,D2
            move.w  D3,D0
            addq.w  #1,D0
            jsr     GetRecA
            move.l  A0,D1
            movea.l D2,A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #2,D0
            lsr.l   #1,D0
            lsl.l   #1,D0
            sub.l   D2,D1
            sub.l   D0,D1
            movea.l A0,A1
            adda.l  D0,A1
            movem.l (SP)+,D0/D2-D3
            rts
LocTPR:
            subq.w  #1,D0
            mulu.w  #6,D0
            movea.l ($C,A4),A0
            lea     (0,A0,D0.l),A0
            rts
MovOffLt:
            movem.l D0-D2/A0-A1,-(SP)
.L1:
            move.w  (A0)+,D2
            add.w   D1,D2
            move.w  D2,(A1)+
            dbra    D0,.L1
            bra.b   MovOffRt.L2
MovOffRt:
            movem.l D0-D2/A0-A1,-(SP)
            cmpm.w  (A0)+,(A1)+
.L1:
            move.w  -(A0),D2
            add.w   D1,D2
            move.w  D2,-(A1)
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D2/A0-A1
            rts
MovRecLt:
            movem.l D0-D1/A0-A1,-(SP)
            tst.w   D0
            ble.b   .L2
            subq.w  #1,D0
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
MovRecRt:
            movem.l D0-D1/A0-A1,-(SP)
            tst.w   D0
            ble.b   .L2
            adda.w  D0,A0
            adda.w  D0,A1
            subq.w  #1,D0
.L1:
            move.b  -(A0),-(A1)
            dbra    D0,.L1
.L2:
            movem.l (SP)+,D0-D1/A0-A1
            rts
RelNode:
            move.l  ($754).w,-(SP)
            rts
vRelNode:
            move.l  (SP)+,-(A6)
            move.l  A1,-(A6)
            move.l  A0,D0
            beq.b   .L1
            jsr     RelBlock
.L1:
            movea.l (A6)+,A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
SearchNode:
            movem.l D2-D5/A1-A3,-(SP)
            movea.l A0,A3
            movea.l A1,A2
            move.l  (4,A4),D5
            clr.w   D2
            move.w  ($A,A2),D3
            subq.w  #1,D3
            cmp.w   D3,D2
            bgt.b   .L4
.L1:
            move.w  D2,D4
            add.w   D3,D4
            lsr.w   #1,D4
            move.w  D4,D0
            movea.l A2,A1
            jsr     GetRecA
            movea.l A0,A1
            movea.l A3,A0
            move.l  A4,-(SP)
            movea.l D5,A4
            jsr     (A4)
            movea.l (SP)+,A4
            tst.w   D0
            beq.b   .L2
            bgt.b   .L3
            move.w  D4,D3
            subq.w  #1,D3
            cmp.w   D3,D2
            ble.b   .L1
            bra.b   .L4
.L2:
            clr.w   D0
            bra.b   .L5
.L3:
            move.w  D4,D2
            addq.w  #1,D2
            cmp.w   D3,D2
            ble.b   .L1
.L4:
            move.w  D2,D4
            moveq   #$20,D0
.L5:
            move.w  D4,D1
            movem.l (SP)+,D2-D5/A1-A3
            tst.w   D0
            rts
UpdDRec:
            movem.l D0-D1/A0-A2,-(SP)
            movea.l A0,A2
            jsr     LocRec
            move.l  A2,D1
            beq.b   .L2
            movea.l D1,A0
            ext.l   D0
            _BlockMove
            bra.b   .L3
.L1:
            clr.b   (A1)+
.L2:
            dbra    D0,.L1
.L3:
            movem.l (SP)+,D0-D1/A0-A2
            rts
UpdIKey:
            movem.l D0-D1/A0-A2,-(SP)
            movea.l A0,A2
            move.w  ($2C,A4),D1
            move.b  D1,(A1)+
            movea.l A2,A0
            move.b  (A0)+,D0
            ext.w   D0
            sub.w   D0,D1
            bge.b   .L2
            add.w   D1,D0
            bra.b   .L2
.L1:
            move.b  (A0)+,(A1)+
.L2:
            dbra    D0,.L1
            tst.w   D1
            ble.b   .L5
            bra.b   .L4
.L3:
            clr.b   (A1)+
.L4:
            dbra    D1,.L3
.L5:
            movem.l (SP)+,D0-D1/A0-A2
            rts
            dc.w    0
Cache:
            moveq   #0,D0
            beq.b   .L1
            movea.l D0,A4
            suba.w  #$1C,A4
.L1:
            rts
FlushOwnBuf:
            bsr.b   Cache
            beq.b   .L1
            btst    #5,($1A,A4)
            bne.b   .L1
            bclr    #7,($1A,A4)
            beq.b   .L1
            move.l  (SP)+,-(A6)
            jsr     WriteOwnBuf
            move.l  (A6)+,-(SP)
.L1:
            rts
FlushCache:
            move.l  ($700).w,-(SP)
            rts
vFlushCache:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0-A4,-(A6)
            cmpa.l  ($380).w,A1
            bne.b   .L4
            tst.b   ($377).w
            bne.b   .L4
            moveq   #0,D5
            movea.l A1,A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L2
            btst    #6,($1A,A4)
            bne.b   .L1
            btst    #7,($1A,A4)
            bne.b   .L1
.L2:
            addq.w  #1,D5
            bra.b   .L1
.L3:
            move.w  (8,A3),D6
            lsr.w   #2,D6
            cmp.w   D6,D5
            bhi.w   .L13
.L4:
            move.b  D1,D5
            movea.l A1,A3
            move.w  D0,D1
            ble.b   .L5
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            bsr.b   FlushOwnBuf
            move.l  (0,A1,D1.w),D3
            btst    #1,(4,A1,D1.w)
            sne     D6
.L5:
            moveq   #0,D4
.L6:
            moveq   #0,D2
            movea.l A3,A4
.L7:
            movea.l (A4),A4
            cmpa.l  A3,A4
            bne.b   .L8
            tst.l   D2
            beq.b   .L13
            movea.l A1,A4
            move.l  ($12,A4),D4
            bra.b   .L11
.L8:
            btst    #5,($1A,A4)
            bne.b   .L7
            cmpa.l  (8,A4),A2
            bne.b   .L7
            tst.w   D1
            blt.b   .L9
            cmp.l   ($C,A4),D3
            bne.b   .L7
            cmp.b   ($1B,A4),D6
            bne.b   .L7
.L9:
            tst.l   D2
            beq.b   .L10
            cmp.l   ($12,A4),D2
            blt.b   .L7
.L10:
            cmp.l   ($12,A4),D4
            bge.b   .L7
            move.l  ($12,A4),D2
            movea.l A4,A1
            bra.b   .L7
.L11:
            btst    #7,($1A,A4)
            beq.b   .L12
            jsr     WRITEBLOCK
            bclr    #7,($1A,A4)
.L12:
            btst    #0,D5
            beq.b   .L6
            btst    #6,($1A,A4)
            bne.b   .L6
            bsr.w   MarkEmpty
            bra.b   .L6
.L13:
            clr.w   D0
            movem.l (A6)+,D1-D6/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
GetBlock:
            move.l  ($704).w,-(SP)
            rts
vGetBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A1-A5,-(A6)
            move.b  D1,D3
            movea.l A1,A3
            move.w  D0,D1
            blt.w   .L4
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            move.l  (0,A1,D1.w),D7
            btst    #1,(4,A1,D1.w)
            sne     D4
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            cmp.l   ($C,A4),D7
            bne.b   .L1
            cmp.b   ($1B,A4),D4
            bne.b   .L1
            cmp.l   ($16,A4),D2
            beq.w   .L17
            bra.b   .L1
.L2:
            bsr.w   Cache
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L3
            cmp.l   ($16,A4),D2
            beq.w   .L20
.L3:
            movem.l D3-D4,-(A6)
            moveq   #0,D4
            move.w  ($A,A3),D4
            move.l  D2,D5
            lsl.l   #8,D5
            add.l   D5,D5
            jsr     Lg2Phys
            move.l  D2,D6
            move.l  D3,D2
            movem.l (A6)+,D3-D4
            tst.w   D0
            bne.w   .L21
            moveq   #0,D0
            beq.b   .L5
            bsr.w   FlushOwnBuf
            move.l  D2,($12,A4)
            move.l  D6,($16,A4)
            clr.b   ($1A,A4)
            jsr     CacheIO
            beq.w   .L20
            bsr.w   MarkEmpty
            bra.w   .L21
.L4:
            moveq   #0,D1
            moveq   #0,D7
            moveq   #-1,D6
            moveq   #0,D4
.L5:
            suba.l  A0,A0
            suba.l  A1,A1
            suba.l  A5,A5
            movea.l A3,A4
.L6:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L10
            btst    #5,($1A,A4)
            beq.b   .L7
            movea.l A4,A0
            bra.b   .L6
.L7:
            tst.w   D1
            bne.b   .L8
            cmpa.l  (8,A4),A2
            bne.b   .L8
            cmp.l   ($12,A4),D2
            beq.w   .L17
.L8:
            btst    #6,($1A,A4)
            bne.b   .L6
            btst    #7,($1A,A4)
            beq.b   .L9
            movea.l A4,A5
            bra.b   .L6
.L9:
            movea.l A4,A1
            bra.b   .L6
.L10:
            btst    #1,D3
            beq.b   .L11
            moveq   #3,D0
            bra.w   .L21
.L11:
            movea.l A0,A4
            move.l  A4,D0
            bne.b   .L14
            movea.l A1,A4
            move.l  A4,D0
            bne.b   .L14
            movea.l A5,A4
            move.l  A4,D0
            bne.b   .L12
            moveq   #1,D0
            bra.w   .L21
.L12:
            movem.l D0-D2/A1-A2,-(A6)
            move.b  ($377).w,D2
            st      ($377).w
            moveq   #0,D1
            movea.l A3,A1
            movea.l (8,A4),A2
            move.w  ($10,A4),D0
            bgt.b   .L13
            move.w  ($4E,A2),D0
.L13:
            jsr     FlushCache
            move.b  D2,($377).w
            movem.l (A6)+,D0-D2/A1-A2
            cmpa.l  ($380).w,A3
            bne.b   .L14
            st      ($377).w
.L14:
            bset    #6,($1A,A4)
            bclr    #5,($1A,A4)
            bclr    #7,($1A,A4)
            move.l  A2,(8,A4)
            move.l  D2,($12,A4)
            move.w  D1,($10,A4)
            move.l  D7,($C,A4)
            move.b  D4,($1B,A4)
            move.l  D6,($16,A4)
            btst    #2,D3
            bne.b   .L19
.L15:
            clr.l   BufTgDate
            jsr     CacheIO
            bne.b   .L16
            jsr     TFSVCBTst
            bne.b   .L19
            move.l  BufTgDate,D0
            cmp.l   ($64,A2),D0
            bls.b   .L19
            move.l  D0,($64,A2)
            bra.b   .L19
.L16:
            clr.b   ($1A,A4)
            bsr.w   MarkEmpty
            bra.b   .L21
.L17:
            bset    #6,($1A,A4)
            beq.b   .L18
            moveq   #2,D0
            bra.b   .L21
.L18:
            btst    #0,D3
            bne.b   .L15
.L19:
            jsr     sub_408145F6
            movea.l A3,A0
            jsr     sub_4081460C
            btst    #3,D3
            beq.b   .L20
            bclr    #6,($1A,A4)
.L20:
            lea     ($1C,A4),A0
            moveq   #0,D0
.L21:
            movem.l (A6)+,D1-D7/A1-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
InitCache:
            move.l  (SP)+,-(A6)
            movem.l D1-D3/A0/A4,-(A6)
            move.w  D0,D2
            move.w  D1,D3
            addi.w  #$1C,D1
            moveq   #0,D0
            move.w  D2,D0
            mulu.w  D1,D0
            addi.l  #$C,D0
            _NewPtrSysClear
            bne.b   .L2
            movea.l A0,A1
            move.l  A1,(A1)
            move.l  A1,(4,A1)
            move.w  D2,(8,A1)
            move.w  D3,($A,A1)
            lea     ($C,A1),A4
            subq.w  #1,D2
.L1:
            movea.l A1,A0
            jsr     sub_4081460C
            bsr.b   MarkEmpty
            adda.l  D1,A4
            dbra    D2,.L1
            clr.w   D0
.L2:
            movem.l (A6)+,D1-D3/A0/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
MarkEmpty:
            bset    #5,($1A,A4)
            clr.l   ($12,A4)
            rts
MarkBlock:
            move.l  ($708).w,-(SP)
            rts
vMarkBlock:
            bset    #7,(-2,A0)
            rts
MarkA5Block:
            exg     A0,A5
            bsr.b   MarkBlock
            exg     A0,A5
            rts
RelBlock:
            move.l  ($70C).w,-(SP)
            rts
vRelBlock:
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1/A3-A4,-(A6)
            lea     (-$1C,A0),A4
            bclr    #6,($1A,A4)
            btst    #1,D1
            beq.b   .L1
            bsr.b   MarkEmpty
            bclr    #7,($1A,A4)
            bra.b   .L3
.L1:
            btst    #2,D1
            beq.b   .L2
            bset    #7,($1A,A4)
.L2:
            btst    #0,D1
            beq.b   .L3
            movea.l A1,A3
            jsr     WRITEBLOCK
            bclr    #7,($1A,A4)
            bra.b   .L4
.L3:
            clr.w   D0
.L4:
            movem.l (A6)+,D1/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
TrashVBlks:
            move.l  ($714).w,-(SP)
            rts
vTrashVBlks:
            movem.l A3-A4,-(SP)
            movea.l A1,A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            bsr.w   MarkEmpty
            bra.b   .L1
.L2:
            movem.l (SP)+,A3-A4
            rts
TrashFBlocks:
            movem.l D0-D6/A0-A4,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            bra.b   TrashBlocks.L2
TrashBlocks:
            movem.l D0-D6/A0-A4,-(SP)
            moveq   #9,D3
            move.l  D1,D4
            lsr.l   D3,D4
            moveq   #-1,D5
            cmp.l   D2,D5
            beq.b   .L1
            move.l  D2,D5
            add.l   D1,D5
            subq.l  #1,D5
.L1:
            lsr.l   D3,D5
            move.w  D0,D1
            ble.b   vTrashBlocks.L3
            movea.l ($34E).w,A1
            movea.l ($14,A1,D1.w),A2
            move.l  (0,A1,D1.w),D3
            btst    #1,(4,A1,D1.w)
            sne     D6
            bsr.w   Cache
            beq.b   .L2
            btst    #5,($1A,A4)
            bne.b   .L2
            move.l  ($16,A4),D0
            cmp.l   D4,D0
            blt.b   .L2
            cmp.l   D5,D0
            bgt.b   .L2
            bsr.w   MarkEmpty
.L2:
            move.l  ($710).w,-(SP)
            rts
vTrashBlocks:
            movea.l ($54,A2),A3
            movea.l A3,A4
.L1:
            movea.l (A4),A4
            cmpa.l  A3,A4
            beq.b   .L3
            btst    #5,($1A,A4)
            bne.b   .L1
            cmpa.l  (8,A4),A2
            bne.b   .L1
            cmp.l   ($C,A4),D3
            bne.b   .L1
            tst.w   D1
            beq.b   .L2
            cmp.b   ($1B,A4),D6
            bne.b   .L1
            move.l  ($16,A4),D0
            cmp.l   D4,D0
            blt.b   .L1
            cmp.l   D5,D0
            bgt.b   .L1
.L2:
            bsr.w   MarkEmpty
            bra.b   .L1
.L3:
            movem.l (SP)+,D0-D6/A0-A4
            rts
CacheRdIP:
            move.l  ($71C).w,-(SP)
            rts
vCacheRdIP:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            movem.l D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            movea.l ($54,A2),A1
            bsr.w   FlushCache
            movem.l (A6)+,D1/A1
            bne.b   .L1
            jsr     Lg2Phys
            bne.b   .L1
            jsr     RDBLOCKS
.L1:
            bra.b   vCacheWrIP.L1
CacheWrIP:
            move.l  ($718).w,-(SP)
            rts
vCacheWrIP:
            move.l  (SP)+,-(A6)
            move.l  D3,-(A6)
            jsr     Lg2Phys
            bne.b   .L1
            movem.l D1-D2,-(A6)
            move.w  D1,D0
            move.l  D5,D1
            move.l  D6,D2
            bsr.w   TrashBlocks
            movem.l (A6)+,D1-D2
            jsr     WRBLOCKS
.L1:
            move.l  (A6)+,D3
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
sub_408145F6:
            movem.l A0-A1,-(SP)
            movea.l (4,A4),A0
            movea.l (A4),A1
            move.l  A1,(A0)
            move.l  A0,(4,A1)
            movem.l (SP)+,A0-A1
            rts
sub_4081460C:
            move.l  A1,-(SP)
            movea.l (A0),A1
            move.l  A1,(A4)
            move.l  A4,(4,A1)
            move.l  A4,(A0)
            move.l  A0,(4,A4)
            movea.l (SP)+,A1
            rts
CacheIO:
ReadOwnBuf:
ReadBlock:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            moveq   #0,D1
            bra.b   WRITEBLOCK.L3
WriteOwnBuf:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            bra.b   WRITEBLOCK.L1
WRITEBLOCK:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            movea.l (8,A4),A2
            move.l  ($12,A4),D0
            move.w  ($10,A4),D1
            beq.b   .L2
.L1:
            movea.l ($34E).w,A1
            move.l  ($16,A4),D0
.L2:
            bsr.w   sub_40814760
            moveq   #1,D1
.L3:
            lea     ($3A4).w,A0
            move.w  ($48,A2),($16,A0)
            move.w  ($4A,A2),($18,A0)
            lea     ($1C,A4),A1
            move.l  A1,($20,A0)
            move.w  #1,($2C,A0)
            move.l  #$200,($24,A0)
            move.l  ($12,A4),D0
            lsl.l   #8,D0
            add.l   D0,D0
            move.l  D0,($2E,A0)
.L4:
            move.l  ($720).w,-(SP)
            rts
VBASICIO:
            move.l  A6,($36E).w
            tst.b   ($342).w
            bne.b   .L2
            tst.b   D1
            bne.b   .L1
            _Read
            bra.b   sub_408146CC.L2
.L1:
            _Write
            bra.b   sub_408146CC.L2
.L2:
            lea     sub_408146CC,A1
            move.l  A1,($C,A0)
            bclr    #7,($376).w
            tst.b   D1
            bne.b   .L3
            _Read async
            bra.b   .L4
.L3:
            _Write async
.L4:
            beq.b   .L5
            tst.w   ($10,A0)
            ble.b   sub_408146CC.L1
.L5:
            bset    #7,($376).w
            bne.b   sub_408146CC.L2
.L6:
            rts
sub_408146CC:
            bset    #7,($376).w
            beq.b   VBASICIO.L6
.L1:
            movem.l D4-D7/A4-A6,-(SP)
            pea     sub_408146FA
.L2:
            movea.l ($36E).w,A6
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            beq.b   .L3
            cmpi.w  #$FFBF,D0
            beq.b   .L3
            move.w  D0,($3DE).w
            moveq   #-$24,D0
.L3:
            tst.w   D0
            rts
sub_408146FA:
            movem.l (SP)+,D4-D7/A4-A6
            rts
RDBLOCKS:
            move.l  ($724).w,-(SP)
            rts
VRDBLOCKS:
            moveq   #0,D0
.L1:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            movea.l ($20,A0),A5
            adda.l  ($28,A0),A5
            move.w  D0,D1
            moveq   #$40,D0
            and.b   ($2D,A0),D0
            lea     ($3A4).w,A0
            move.w  ($4A,A2),($18,A0)
            move.w  ($48,A2),($16,A0)
            move.l  A5,($20,A0)
            move.l  D6,($24,A0)
            move.w  #1,($2C,A0)
            or.b    D0,($2D,A0)
            move.l  D3,D0
            lsl.l   #8,D0
            add.l   D0,D0
            move.l  D0,($2E,A0)
            bra.w   WRITEBLOCK.L4
WRBLOCKS:
            move.l  ($728).w,-(SP)
            rts
VWRBLOCKS:
            move.l  D5,D0
            lsr.l   #8,D0
            lsr.l   #1,D0
            bsr.b   sub_40814760
            moveq   #1,D0
            bra.b   VRDBLOCKS.L1
sub_40814760:
            move.l  ($72C).w,-(SP)
            rts
VSETUPTAGS:
            tst.w   D1
            beq.b   .L2
            move.l  (0,A1,D1.w),BufTgFNum
            move.l  D0,BufTgFFlg
            move.b  (4,A1,D1.w),BufTgFFlg
            move.l  ($32,A1,D1.w),($38A).w
            move.l  ($3A,A1,D1.w),($38E).w
.L1:
            jsr     TFSVCBTst
            bne.b   .L3
            move.l  ($64,A2),BufTgDate
            addq.l  #1,($64,A2)
            rts
.L2:
            move.l  D0,BufTgFFlg
            moveq   #1,D0
            move.l  D0,BufTgFNum
            clr.l   ($38A).w
            clr.l   ($38E).w
            bra.b   .L1
.L3:
            move.l  TimeLM,BufTgDate
            rts
            ds.b    12

            EVEN
