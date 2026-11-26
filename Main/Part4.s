            include "Include/ROMHeader.s"

            EXPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,AddDrive,BlockMove68020
            EXPORT  BMEXIT16,BMMOVELONGS,BMOVERLAP,BMVERYSHORT,CallRoutines,Chain,ClkNoMem
            EXPORT  ClkRW,clock,Close,CmdDone,CmpString,CompactMem
            EXPORT  Control,Delay,DHBusErrHandler,DisposePtr,DoEject,DrvrInstall
            EXPORT  DrvrRemove,DsposeHandle,Eject_2,EmptyHandle,Events,ExitToShell
            EXPORT  FileAlloc,FileCreate,FileDelete,FileWrite,FInitQueue,FlushEvents
            EXPORT  FlushFile,FlushVol,FreeMem,FSIODneTbl,FSQueueSync,GetAppParms
            EXPORT  GetBlock,GetEOF,GetFileInfo,GetFPos,GetHandleSize,GetOSEvent
            EXPORT  GetPtrSize,GetVol,GetVolInfo,GetZone,HandleZone,HeapGuts
            EXPORT  HGetFlags,HLock,HNoPurge,HNoRSRC,HPurge,HRSRC
            EXPORT  HSetFlags,HUnlock,InitApplZone,InitFS,InitMemVect,INITRELIABILITY
            EXPORT  InitTimeMgr,InitUtil,InitZone,InstallRDrivers,InsTime,KillIO
            EXPORT  Launch,Loader,LWRSTRING,MaxApplZone,MaxBlock,MaxMem
            EXPORT  MoreMasters,MountVol,MoveHHi,NewEmptyHandle,NewPtr,NwHandle
            EXPORT  Offline,Open,OPENPATCHRTN,OPENPATCHRTN1,OpenRF,OSEventAvail
            EXPORT  PRAMInit,PRAMInitTbl,PrimeTime,PtrZone,PurgeMem,PurgeSpace
            EXPORT  Read,ReadDateTime,ReadParam,READPRAMPATCHRTN,ReadXPRam,ReAllocHandle
            EXPORT  RecoverHandle,RelStringTrap,ReName,ResrvMem,RstFilLock,SetApplBase
            EXPORT  SetApplLimit,SetDateTimeTrap,SetEOF,SetFileInfo,SetFilLock,SetFilType
            EXPORT  SetFPos,SetGrowZone,SetHandleSize,SetPtrSize,SetVol,SetZone
            EXPORT  ShutDownDisp,StackSpace,Status,StripAddress,SYSENVIRONS,SYSUTIL
            EXPORT  TimeMgr,TurboFS,UnloadSeg,UnmountVol,uprstring,vAdjEOF
            EXPORT  ValidatePRAM,VALIDATEPRAMCONT,vAllocNode,VBASICIO,vBlkAlloc,VBLKDEALLOC
            EXPORT  vBMChk,vBTClose,vBTDelete,VBTFLUSH,vBTGetRecord,VBTINSERT
            EXPORT  VBTOPEN,vBTSearch,vBTUpdate,vCacheRdIP,vCacheWrIP,vCheckRemount
            EXPORT  vCkExtFS,vCMSetUp,vDeAllocFile,vDtrmV1,vDtrmV2,vDtrmV3
            EXPORT  vExtBTFile,vExtendFile,vFClose,vFileClose,vFileOpen,vFileRead
            EXPORT  vFileWrite,vFindDrive,vFlushCache,vFlushMDB,vFndFilName,vFreeNode
            EXPORT  vGetBlock,vGetNode,vGoDriver,vIAZInit,vIAZPostInit,vLaunchInit
            EXPORT  VLG2PHYS,VLOCCREC,vMapFBlock,vMarkBlock,VMTCHECK,vPermssnChk
            EXPORT  VRDBLOCKS,vReadBM,vRelBlock,vRelNode,vRfNCall,vSegStack
            EXPORT  VSETUPTAGS,vSyncWait,vTrashBlocks,vTrashVBlks,vTreeSearch,vTruncateFile
            EXPORT  vTstMod,VUPDALTMDB,vWaitUntil,VWRBLOCKS,vXFSearch,Write
            EXPORT  WriteParam,WRITEPRAMPATCHRTN,WriteTimePatchRtn,WriteUpdateReturn,WriteXPRam,XPRAMCONT
            EXPORT  XPRAMEXIT1

            IMPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            IMPORT  ALIGN24TRAILER,ALIGN32TRAILER,AllocFakeRgns,CLKNOMEMPATCH,DequeueTrap,DerefHandlePatch
            IMPORT  CMDDONEPATCH,DSHOOKPATCH,FlushApplNM,INIT24ZONEALIGN,INIT32ZONEALIGN,LoadSegPatch
            IMPORT  OPENPATCH,OSEVENTAVAILPATCH,OSEVENTMGRPATCH,PMSPSwOS,QStuff,ReadPRamPatch
            IMPORT  ReadTimePatch,READUPDATE,SETAPPLBASEPATCH,SHUTRESTARTANNEX,SMGRPOSTMUNGING,UnloadSegPatch
            IMPORT  V24CMGUTSPATCH,v24HlockPatch,V24MAXAPPLPATCH,V24MAXMEMPATCH,V24PURGESPACEPATCH,V32CMGUTSPATCH
            IMPORT  v32HlockPatch,V32MAXAPPLPATCH,V32MAXMEMPATCH,V32PURGESPACEPATCH,ValidatePRAMPatch,WDCBSwOS
            IMPORT  WritePRamPatch,WRITETIMEPATCH,WRITEUPDATE,XPRAMPATCH,ZoneCheckPatch

            SECTION "Part4",CODE

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
            jsr     (QStuff.w,PC)
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
            jsr     (DequeueTrap.w,PC)
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
            jsr     (QStuff.w,PC)
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
            jsr     (QStuff.w,PC)
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
            bra.l   v24HlockPatch
            nop
            bra.w   HNoPurge.L1
            bra.l   v32HlockPatch
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
DHBusErrHandler:
            andi.w  #$FEFF,($A,SP)
            moveq   #-1,D0
            move.l  D0,($2C,SP)
            rte
sub_4080DB6A:
            bsr.l   DerefHandlePatch
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
            bsr.l   ZoneCheckPatch
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
            lea     TFSTrpTbl,A2
            add.w   D2,D2
            adda.w  (0,A2,D2.w),A2
            jmp     (A2)
TFSTrpTbl:
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
            jsr     (QStuff.w,PC)
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
toDSFSErr:
            moveq   #$1B,D0
            _SysError
CmdDone:
            bsr.l   CMDDONEPATCH
            ble.b   .L1
            move.w  D0,($392).w
            moveq   #-$7F,D0
.L1:
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.b   toDSFSErr
            cmpi.w  #$FFD5,D0
            bne.b   cd_CkExtFS
            btst    #9,(6,A0)
            beq.b   .L2
            tst.l   ($30,A0)
            bne.b   cd_CkExtFS
.L2:
            btst    #6,($376).w
            bne.b   cd_CkExtFS
            btst    #5,($376).w
            bne.b   cd_CkExtFS
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
cd_CkExtFS:
            bclr    #5,($376).w
            move.l  ($3E6).w,D2
            ble.b   .L7
            movea.l D2,A1
            jsr     (A1)
.L7:
            move.l  ($3F2).w,D2
            ble.b   cd_DeQueue
            movea.l D2,A1
            cmpi.w  #$FFC6,D0
            beq.b   .L8
            cmpi.w  #$FFC7,D0
            bne.b   cd_DeQueue
            clr.l   ($3EE).w
.L8:
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.w   toDSFSErr
            moveq   #-$3A,D0
            tst.w   (6,A0)
            blt.b   .L9
            moveq   #0,D0
            move.b  (7,A0),D0
            clr.b   (7,A0)
            ori.w   #$A060,(6,A0)
.L9:
            jsr     (A1)
cd_DeQueue:
            move    SR,-(SP)
            ori     #$700,SR
            clr.w   FSQHdr
            movea.l ($362).w,A0
            cmpi.w  #5,(4,A0)
            bne.w   toDSFSErr
            move.l  (A0),($362).w
            bne.b   cd_CallComp
            clr.l   ($366).w
cd_CallComp:
            move    (SP)+,SR
            move.w  D0,($10,A0)
            move.l  ($C,A0),D1
            beq.b   cd_DispNext
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
cd_DispNext:
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
            bpl.b   TellUser
            neg.w   D3
            move.w  D3,($16,A0)
            _MountVol
            bne.b   TellUser
            moveq   #0,D3
            bra.w   TellUser.L15
TellUser:
            move.l  #$500078,DSAlertRect
            move.l  #$980195,DSAlertRect+4
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
            bpl.w   FSInitOK
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
            bne.w   FSInitErr
            move.w  D1,(A0)
            move.l  A0,($34E).w
            mulu.w  #$10,D2
            move.l  D2,D0
            addq.w  #2,D0
            move.w  D0,D1
            _NewPtrSysClear
            bne.w   FSInitErr
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
            bne.b   FSInitErr
            lea     ($500,A0),A0
            move.l  A0,($36A).w
            moveq   #$38,D0
            _NewPtrSysClear
            bne.b   FSInitErr
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
            bne.b   FSInitErr
            move.l  A1,($378).w
            moveq   #1,D0
            cmpi.w  #2,MemTop
            ble.b   .L3
            moveq   #2,D0
.L3:
            jsr     InitCache
            bne.b   FSInitErr
            move.l  A1,($37C).w
            moveq   #4,D0
            cmpi.w  #2,MemTop
            ble.b   .L4
            moveq   #$10,D0
.L4:
            jsr     InitCache
            bne.b   FSInitErr
            move.l  A1,($380).w
            lea     DSHook,A0
            move.l  A0,($3EA).w
FSInitOK:
            moveq   #0,D0
            rts
FSInitErr:
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
            jsr     (QStuff.w,PC)
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
            jsr     (DequeueTrap.w,PC)
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
            jsr     (DequeueTrap.w,PC)
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
