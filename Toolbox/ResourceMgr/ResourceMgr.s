            include "Include/ROMHeader.s"

            EXPORT  AddReference,AddResource,ChangedResource,CloseResFile,Count1Resources,Count1Types
            EXPORT  CountResources,CountTypes,CreateResFile,CurResFile,DetachResource,Get1IndResource
            EXPORT  Get1IndType,Get1NamedResource,Get1Resource,GetIndResource,GetIndType,GetNamedResource
            EXPORT  GetResAttrs,GetResFileAttrs,GetResInfo,GetResource,HomeResFile,InitResources
            EXPORT  LoadResource,MaxSizeRsrc,OpenResFile,OpenRFPerm,ReleaseResource,ResError
            EXPORT  RGETRESOURCE,RmveReference,RmveResource,RSRCMAPENTRY,RsrcZoneInit,SetResAttrs
            EXPORT  SetResFileAttrs,SetResInfo,SetResLoad,SetResPurge,SizeResource,Unique1ID
            EXPORT  UniqueID,UpdateResFile,UseResFile,vCheckLoad,vCmpFrm,vNewMap
            EXPORT  vRMgrStdEntry,VRMGRSTDEXIT,vSuperLoad,WriteResource

            IMPORT  RSRCMGRPATCH,FIXSMGRWORLD,SmgrInitialize,A

            SECTION "ResourceMgr",CODE

RMGR:
            dc.b    $00,$00,$01,$00,$00,$00,$01
            ds.b    8
            dc.b    $1E
            ds.b    9
            dc.b    $1C,$00,$1E,$FF,$FF,$00,$00,$00,$01
InitResources:
            clr.l   ($B84).w
            bsr.w   StdZEntry
            tst.l   TopMapHndl
            bgt.b   .L1
            clr.l   ResErrProc
            bsr.w   ROZInit
            move.l  A0,TopMapHndl
            move.l  A0,SysMapHndl
            move.l  OneOne,SysMap
            bsr.w   ReDoMap
            clr.l   ($10,A1)
            bra.b   .L3
.L1:
            lea     TheZone,A3
            move.l  (A3),-(SP)
            move.l  SysZone,(A3)
            lea     SysResName,A1
            bsr.w   sub_4081ADCE
            move.l  (SP)+,(A3)
            move.w  D6,(8,A6)
            tst.l   D0
            ble.b   .L3
            move.l  A4,TopMapHndl
            move.l  A4,SysMapHndl
            move.w  D6,CurMap
            move.w  D6,SysMap
            bsr.w   sub_4081AC5E
            bsr.w   ReDoMap
            move.l  SysMapHndl,($10,A1)
            movea.l SysMapHndl,A1
            movea.l (A1),A1
            clr.l   ($10,A1)
            bsr.b   RomOverRide
            move.l  IntlSpec,D0
            addq.w  #1,D0
            bne.b   .L2
            bsr.w   SmgrInitialize
            bra.b   .L3
.L2:
            bsr.w   FIXSMGRWORLD
.L3:
            bra.w   StdZeroExit
RomOverRide:
            subq.w  #4,SP
            move.l  #'ROvr',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            jsr     (A0)
.L1:
            rts
ROZInit:
            bsr.w   CountCombos
            move.l  D0,D5
            move.l  D1,D6
            moveq   #$18,D0
            add.w   D5,D0
            asl.l   #3,D0
            add.w   D6,D0
            movea.l D0,A1
            _NewPtrSys
            move.l  TheZone,-(SP)
            clr.l   -(SP)
            move.w  #4,-(SP)
            adda.l  A0,A1
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l A0,A1
            movea.l SP,A0
            _InitZone
            bset    #0,($16,A1)
            move.l  A1,TheZone
            lea     ($E,SP),SP
            move.l  D5,D0
            asl.l   #3,D0
            _NewPtr
            move.w  D6,D0
            _NewHandle
            _HLock
            move.l  A0,ROMMapHndl
            move.l  (SP)+,TheZone
            rts
ReDoMap:
            bsr.w   CountCombos
            move.l  D1,D0
            movea.l ROMMapHndl,A0
            movea.l A0,A4
            _SetHandleSize
            moveq   #$20,D0
            lea     RMGR,A0
            movea.l (A4),A1
            _BlockMove
            move.w  #1,($14,A1)
            clr.w   -(SP)
            movea.l SP,A0
            move.l  #$100AE,D0
            _ReadXPRam
            move.b  (A0),D3
            addq.w  #2,SP
            movea.l ROMBase,A2
            adda.l  ($1A,A2),A2
            moveq   #0,D2
            move.b  (5,A2),D2
            move.w  (8,A2),D4
            BigJsr  RSRCMGRPATCH,A3
            nop
            nop
            nop
            nop
            movea.l (A2),A2
            adda.l  ROMBase,A2
.L1:
            movea.l A2,A0
            moveq   #0,D0
            move.b  D3,D0
            lsr.b   #3,D0
            adda.w  D0,A0
            move.b  D3,D0
            eori.b  #$FF,D0
            andi.b  #7,D0
            btst    D0,(A0)
            adda.w  D2,A2
            beq.b   .L2
            movea.l (4,A2),A3
            adda.l  ROMBase,A3
            movea.l ROMMapHndl,A0
            _HandleZone
            move.l  (-4,A3),D0
            _StripAddress
            adda.l  D0,A0
            move.l  A3,(A0)
            move.l  A0,-(SP)
            move.l  (8,A2),-(SP)
            move.w  ($C,A2),-(SP)
            pea     ($F,A2)
            bsr.b   sub_4081AC14
.L2:
            movea.l (A2),A2
            move.l  A2,D0
            adda.l  ROMBase,A2
            bne.b   .L1
            move.w  #1,($14,A1)
            rts
CountCombos:
            movem.l D2-D4/A2,-(SP)
            movea.l ROMBase,A2
            adda.l  ($1A,A2),A2
            moveq   #0,D2
            move.b  (5,A2),D2
            movea.l (A2),A2
            adda.l  ROMBase,A2
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D3
.L1:
            addq.w  #1,D0
            adda.w  D2,A2
            move.b  ($B,A2),D3
            add.l   D3,D1
            movea.l (A2),A2
            move.l  A2,D4
            adda.l  ROMBase,A2
            bne.b   .L1
            move.l  D0,D2
            mulu.w  #$14,D2
            addi.l  #$1C,D2
            add.l   D2,D1
            movem.l (SP)+,D2-D4/A2
            rts
sub_4081AC14:
            move.w  #$FFFF,ROMMapInsert
            bsr.w   sub_4081B708
            movea.l ($12,A6),A1
            bsr.w   GetCurMap
            move.l  ($E,A6),D3
            bsr.w   AddNewRef
            move.w  ($C,A6),(A2)
            move.w  #$FFFF,(2,A2)
            movea.l (8,A6),A0
            bsr.w   AllocRes_wrongname
            movea.l ($12,A6),A0
            move.l  A0,(8,A2)
            movea.l (A0),A0
            suba.l  ROMBase,A0
            move.l  A0,(4,A2)
            move.b  #$58,(4,A2)
            moveq   #$E,D0
            bra.w   StdExit
sub_4081AC5E:
            st      ResLoad
Preload2:
            bsr.w   GetMap_ResourceMgr
            bmi.b   .L3
            bsr.w   GetRsrcCnt
            bmi.b   .L3
.L1:
            addq.w  #8,A2
            clr.l   (A2)+
            dbra    D4,.L1
            tst.b   ResLoad
            beq.b   .L3
            bsr.b   sub_4081AC96
            beq.b   .L3
            moveq   #2,D1
            bsr.w   sub_4081B030
            bmi.b   .L3
.L2:
            bsr.w   CheckLoad
            moveq   #2,D1
            bsr.w   sub_4081B036
            beq.b   .L2
.L3:
            rts
sub_4081AC96:
            movea.l ($7E4).w,A0
            jmp     (A0)
vSuperLoad:
            bsr.w   GetMaxLoad
            bmi.w   sub_4081B6E2.L3
            bsr.w   sub_4081B6B8
            movea.l (A4),A1
.L1:
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            cmp.l   ($B80).w,D0
            bge.b   .L4
            move.l  TheZone,-(SP)
            btst    #6,(4,A2)
            beq.b   .L2
            move.l  SysZone,TheZone
.L2:
            move.l  (4,A2),D2
            and.l   Lo3Bytes,D2
            bsr.b   SetupInBuff
            btst    #4,(4,A2)
            suba.l  (A4),A2
            suba.l  (A4),A3
            beq.b   .L3
            move.l  D0,D1
            _NewEmptyHandle
            bmi.b   .L5
            _DisposHandle
            bmi.b   .L5
            move.l  D1,D0
            _NewPtr
            bmi.b   .L5
            _DisposPtr
            bmi.b   .L5
            move.l  D1,D0
.L3:
            _NewHandle
            bmi.b   .L5
            move.l  A0,D1
            movea.l (A0),A1
            bsr.b   SetupInBuff
            _BlockMove
            adda.l  (A4),A2
            adda.l  (A4),A3
            move.l  D1,(8,A2)
            movea.l D1,A0
            move.b  (4,A2),D1
            bsr.w   sub_4081B97C
            move.l  (SP)+,TheZone
.L4:
            bsr.w   sub_4081B89E
            bpl.b   .L1
            movea.l D7,A0
            _DisposHandle
            moveq   #0,D0
            rts
.L5:
            move.l  (SP)+,TheZone
            movea.l D7,A0
            _DisposHandle
            bra.w   sub_4081B6E2.L3
SetupInBuff:
            movea.l D7,A0
            movea.l (A0),A0
            adda.l  D2,A0
OddSize:
            move.b  (A0)+,D0
            lsl.w   #8,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A0)+,D0
            lsl.w   #8,D0
            move.b  (A0)+,D0
            rts
GetMaxLoad:
            tst.l   ($B80).w
            beq.b   .L5
            moveq   #0,D7
            move.l  SP,D0
            _StripAddress
            sub.l   MinStack,D0
            cmp.l   ApplLimit,D0
            bcs.b   .L1
            move.l  ApplLimit,D0
.L1:
            sub.l   HeapEnd,D0
            ble.b   .L2
            cmpi.l  #$C,D0
            bls.b   .L2
            move.l  D0,D7
.L2:
            _MaxBlock
            cmp.l   D7,D0
            ble.b   .L3
            move.l  D0,D7
.L3:
            move.l  ($B90).w,D0
            bsr.b   SizeFits
            bpl.b   .L4
            move.l  ($B8C).w,D0
            bsr.b   SizeFits
            bpl.b   .L4
            move.l  ($B88).w,D0
            bsr.b   SizeFits
            bmi.b   .L5
.L4:
            _NewHandle
            bmi.b   .L5
            _DisposHandle
            move.l  D1,D0
            _NewHandle
            bmi.b   .L5
            move.l  D1,D0
            move.l  A0,D7
            move.l  (A0),D1
            movea.l (A4),A0
            move.l  (A0),D2
            bsr.w   RdData
            beq.b   .L6
            movea.l D7,A0
            _DisposHandle
.L5:
            moveq   #-1,D0
.L6:
            rts
SizeFits:
            move.l  D0,($B80).w
            beq.w   sub_4081B6E2.L3
            bmi.b   .L1
            move.l  D0,D1
            add.l   D0,D0
            movea.l (A4),A0
            add.l   ($C,A0),D0
            cmp.l   D0,D7
.L1:
            rts
sub_4081ADCE:
            movea.l ($7EC).w,A0
            jmp     (A0)
vNewMap:
            clr.l   ($B80).w
            clr.l   ($B84).w
            moveq   #$24,D0
            _NewHandle
            move.w  D0,ResErr
            bmi.w   .L5
            movea.l A0,A4
            bsr.w   SetFileIO
            bsr.w   ORFCommon
            beq.b   .L1
            cmpi.w  #$FFCF,D0
            bne.w   .L4
            movem.l D6/A2-A4,-(SP)
            bsr.w   GetMap_ResourceMgr
            movem.l (SP)+,D6/A2-A4
            bne.w   .L4
            clr.w   ResErr
            movea.l A4,A0
            _DisposHandle
            rts
.L1:
            _GetEOF
            move.w  #$FFD9,ResErr
            tst.l   ($1C,A0)
            beq.b   .L3
            moveq   #$24,D0
            movea.l (A4),A1
            move.l  A1,D1
            moveq   #0,D2
            bsr.w   RdData
            bmi.b   .L3
            movea.l A1,A0
            adda.w  #$10,A0
            lea     ($B80).w,A1
            moveq   #$14,D0
            _BlockMove
            movea.l A0,A1
            suba.w  #$10,A1
            bsr.b   PreFormat
            moveq   #$C,D1
            move.l  (4,A1),D2
            add.l   D1,D2
            move.l  ($C,A1),D4
            move.l  D4,D0
            movea.l A4,A0
            _SetHandleSize
            move.w  D0,ResErr
            bne.b   .L3
            movea.l (A4),A1
            move.l  D4,D0
            sub.l   D1,D0
            add.l   A1,D1
            bsr.w   RdData
            bmi.b   .L3
            tst.l   ($B80).w
            beq.b   .L2
            move.l  ($C,A1),($B80).w
            bsr.b   PreFormat
.L2:
            move.l  D4,($C,A1)
            bsr.w   CheckMap
            bmi.b   .L3
            clr.l   ($10,A1)
            move.w  D6,($14,A1)
            moveq   #1,D0
            rts
.L3:
            bsr.w   SetFileIO
            _Close
.L4:
            movea.l A4,A0
            _DisposHandle
.L5:
            clr.l   ($B80).w
            clr.l   ($B84).w
            moveq   #-1,D6
            moveq   #-1,D0
            rts
PreFormat:
            move.l  ($B80).w,D0
            subi.l  #$20B7A185,D0
            beq.b   .L1
            clr.l   ($B80).w
.L1:
            clr.l   ($B84).w
            rts
RsrcZoneInit:
            bsr.w   StdZEntry
            tst.w   SysMap
            bmi.b   .L3
            bsr.b   sub_4081AEEE
            movea.l SysMapHndl,A4
            bsr.w   GetRsrcCnt
            bmi.b   .L3
.L1:
            btst    #6,(4,A2)
            bne.b   .L2
            clr.l   (8,A2)
.L2:
            lea     ($C,A2),A2
            dbra    D4,.L1
.L3:
            bra.w   StdZeroExit
sub_4081AEEE:
            movea.l TopMapHndl,A0
            cmpa.l  SysMapHndl,A0
            beq.b   .L1
            movea.l (A0),A0
            move.w  ($14,A0),-(SP)
            _CloseResFile
            bra.b   sub_4081AEEE
.L1:
            rts
ORFCommon:
            move.l  A0,-(SP)
            move.w  CurMap,-(SP)
            move.b  ResLoad,-(SP)
            move.w  SysMap,CurMap
            sf      ResLoad
            subq.w  #4,SP
            move.w  #$E000,-(SP)
            _GetString
            move.l  (SP)+,D0
            move.b  (SP)+,ResLoad
            move.w  (SP)+,CurMap
            movea.l (SP)+,A0
            tst.l   D0
            beq.b   .L1
            exg     D0,A1
            movea.l (A1),A1
            exg     D0,A1
            cmpa.l  D0,A1
            bne.b   .L1
            move.w  BootDrive,($16,A0)
.L1:
            move.l  A1,($12,A0)
            clr.l   ($1C,A0)
            _OpenRF
            move.w  ($18,A0),D6
            move.w  D0,ResErr
            rts
CreateResFile:
            bsr.w   StdZEntry
            movea.l (A0),A1
            bsr.w   SetFileIO
            bsr.b   ORFCommon
            beq.b   .L1
            cmpi.w  #$FFD5,D0
            bne.b   .L3
            _Create
            move.w  D0,ResErr
            bmi.b   .L3
            bsr.b   ORFCommon
            bmi.b   .L3
.L1:
            _GetEOF
            move.w  #$FFD0,ResErr
            tst.l   ($1C,A0)
            bne.b   .L2
            moveq   #$10,D0
            lea     RMGR,A1
            move.l  A1,D1
            bsr.w   WrDataSt
            moveq   #$1E,D0
            moveq   #$40,D2
            asl.w   #2,D2
            bsr.w   WrData
.L2:
            _Close
.L3:
            bra.w   StdFourExit
OpenResFile:
            bsr.w   StdZEntry
.L1:
            move.l  MinusOne,LastSPExtra
            movea.l (A0),A1
            bsr.w   sub_4081ADCE
            move.w  D6,($C,A6)
            bmi.b   .L2
            move.w  D6,CurMap
            tst.w   D0
            beq.b   .L2
            move.l  TopMapHndl,($10,A1)
            move.l  A4,TopMapHndl
            bsr.w   Preload2
.L2:
            bra.w   StdFourExit
OpenRFPerm:
            movea.l (SP)+,A0
            move.b  (SP)+,RMGRPerm
            move.w  (SP)+,D0
            move.l  A0,-(SP)
            bsr.w   StdZEntry
            move.w  D0,(-$1C,A6)
            bra.b   OpenResFile.L1
UseResFile:
            bsr.b   sub_4081B010
            move.w  D6,CurMap
            bra.w   StdTwoExit
GetResFileAttrs:
            bsr.b   sub_4081B010
            move.b  ($16,A3),($B,A6)
            bra.w   StdTwoExit
SetResFileAttrs:
            bsr.w   StdZEntry
            move.w  ($A,A6),D6
            bsr.w   GetMap_ResourceMgr
            bmi.b   .L1
            move.b  (9,A6),($16,A3)
.L1:
            bra.w   StdFourExit
sub_4081B010:
            move.l  (SP)+,D0
            bsr.w   StdZEntry
            move.l  D0,-(SP)
            move.w  (A0),D6
            bsr.w   GetMap_ResourceMgr
            bmi.b   .L1
            rts
.L1:
            addq.w  #4,SP
            move.w  #$FF3F,ResErr
            bra.w   StdTwoExit
sub_4081B02E:
            moveq   #0,D1
sub_4081B030:
            moveq   #-1,D0
            bra.b   sub_4081B036.L1
ZNextRes:
            moveq   #0,D1
sub_4081B036:
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
.L1:
            movem.l D2-D7/A3,-(SP)
            move.l  D0,D2
            bsr.w   GetRsrcCnt
            bmi.b   .L7
            lea     MinusOne,A3
            subq.l  #4,A3
            move.l  A3,D6
            moveq   #-1,D7
            lsr.l   #1,D7
            tst.w   D1
            beq.b   .L4
.L2:
            btst    D1,(4,A2)
            beq.b   .L3
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            cmp.l   D0,D2
            bge.b   .L3
            cmp.l   D0,D7
            ble.b   .L3
            move.l  D0,D7
            move.l  A2,D6
.L3:
            lea     ($C,A2),A2
            dbra    D4,.L2
            bra.b   .L6
.L4:
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            cmp.l   D0,D2
            bge.b   .L5
            cmp.l   D0,D7
            ble.b   .L5
            move.l  D0,D7
            move.l  A2,D6
.L5:
            lea     ($C,A2),A2
            dbra    D4,.L4
.L6:
            movea.l D6,A2
            move.l  D7,D0
            move.l  (4,A2),D7
            and.l   Lo3Bytes,D7
            cmp.l   D0,D7
.L7:
            movem.l (SP)+,D2-D7/A3
            rts
UpdateResFile:
            bsr.w   sub_4081B010
            bsr.w   ResRW
            beq.b   .L1
            move.w  #$FF39,ResErr
            bra.w   StdTwoExit
.L1:
            btst    #5,($16,A0)
            beq.w   StdTwoExit
            bsr.w   SetRFEOF
            bmi.w   StdTwoExit
            bclr    #6,($16,A3)
            bne.b   .L4
            moveq   #1,D1
            bsr.w   sub_4081B030
            bmi.b   .L3
.L2:
            bsr.w   WrRsrc
            bsr.w   sub_4081B036
            beq.b   .L2
.L3:
            bra.w   vCmpFrm.L6
.L4:
            bsr.w   sub_4081B02E
            bmi.w   vCmpFrm.L6
            movea.l (A4),A0
            move.l  (A0),D7
            sub.l   (4,A0),D7
            bcs.b   .L6
            bsr.w   GetRsrcCnt
.L5:
            add.l   D7,(4,A2)
            lea     ($C,A2),A2
            dbra    D4,.L5
            move.l  (4,A0),(A0)
            bsr.w   sub_4081B02E
.L6:
            moveq   #0,D7
            bra.b   .L10
.L7:
            btst    #1,(4,A2)
            beq.b   .L8
            bsr.w   WrRsrc
            movea.l (8,A2),A0
            _GetHandleSize
            bra.b   .L9
.L8:
            bsr.w   ReadResData
.L9:
            addq.l  #4,D0
            move.l  (4,A2),D7
            add.l   D0,D7
            and.l   Lo3Bytes,D7
            bsr.w   ZNextRes
            bmi.w   vCmpFrm.L5
.L10:
            move.l  D7,D0
            sub.l   (4,A2),D0
            and.l   Lo3Bytes,D0
            beq.b   .L7
            suba.l  (A4),A2
            bsr.w   MaxRFEOF
            move.l  D0,D3
            _MaxBlock
            cmp.l   D3,D0
            bge.b   .L11
            exg     D3,D0
.L11:
            moveq   #$40,D0
            asl.w   #4,D0
            cmp.l   D0,D3
            bge.b   .L12
            move.l  D0,D3
            link.w  A3,#-$400
            move.l  SP,(A3)
            bra.b   .L13
.L12:
            move.l  D3,D0
            _NewHandle
            _HLock
            movea.l A0,A3
.L13:
            adda.l  (A4),A2
            move.l  (A3),D0
            _StripAddress
            add.l   D0,D3
            movea.l D0,A1
            move.l  A1,D4
            move.l  D7,D5
            movea.l ($7E8).w,A0
            jmp     (A0)
vCmpFrm:
            btst    #1,(4,A2)
            beq.b   .L1
            bsr.b   CmpFrmMem
            bpl.b   .L2
.L1:
            bsr.w   CmpFrmDsk
.L2:
            bsr.w   ZNextRes
            beq.b   vCmpFrm
            move.l  A1,D0
            sub.l   (A3),D0
            _StripAddress
            move.l  (A3),D1
            movea.l (A4),A0
            move.l  D7,D2
            add.l   (A0),D2
            bsr.w   WrData
            add.l   D0,D7
            cmpa.l  SP,A3
            bhi.b   .L3
            movea.l A3,A0
            _DisposHandle
            bra.b   .L4
.L3:
            unlk    A3
.L4:
            movea.l (A4),A3
.L5:
            move.l  D7,(8,A3)
.L6:
            bclr    #5,($16,A3)
            beq.b   .L7
            move.l  (8,A3),D2
            add.l   (A3),D2
            move.l  D2,(4,A3)
            move.l  ($C,A3),D0
            move.l  A3,D1
            bsr.w   WrData
            moveq   #$10,D0
            bsr.w   WrDataSt
            bsr.w   SetRFEOF
.L7:
            bra.w   StdTwoExit
CmpFrmMem:
            bsr.w   PartWrite
            movea.l (8,A2),A0
            _GetHandleSize
            tst.l   D0
            bmi.w   sub_4081B6E2.L3
            bsr.b   RLocnNew
            bsr.b   WriteSize
            move.l  D0,D2
            add.l   A1,D2
            cmp.l   D2,D4
            movea.l (A0),A0
            bge.b   sub_4081B23E
            move.l  D0,D2
            moveq   #0,D1
.L1:
            movea.l (8,A2),A0
            movea.l (A0),A0
            adda.l  D1,A0
            move.l  D3,D0
            sub.l   A1,D0
            cmp.l   D2,D0
            bge.b   .L2
            add.l   D0,D1
            sub.l   D0,D2
            bsr.b   sub_4081B23C
            bsr.w   PartWrite
            bra.b   .L1
.L2:
            move.l  D2,D0
sub_4081B23C:
            move.l  A1,D4
sub_4081B23E:
            cmpa.l  A0,A1
            beq.b   Ptr2Exit
            move.l  D0,-(SP)
            _BlockMove
            move.l  (SP)+,D0
Ptr2Exit:
            add.l   D0,D5
            adda.l  D0,A1
.L1:
            cmp.l   A1,D4
            bge.b   .L2
            move.l  A1,D4
.L2:
            rts
RLocnNew:
            movem.l D0-D1/A0,-(SP)
            moveq   #-3,D1
            lea     (4,A2),A0
            and.b   (A0),D1
            move.l  A1,D0
            sub.l   (A3),D0
            add.l   D7,D0
            move.l  D0,(A0)
            move.b  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rts
.L1:
            moveq   #0,D0
WriteSize:
            move.l  D1,-(SP)
            moveq   #3,D1
.L1:
            rol.l   #8,D0
            move.b  D0,(A1)+
            dbra    D1,.L1
            addq.l  #4,D5
            move.l  (SP)+,D1
            bra.b   Ptr2Exit.L1
CmpFrmDsk:
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            sub.l   D5,D0
            bge.b   .L1
            bsr.w   PartWrite
            bsr.b   RLocnNew
            bra.b   RLocnNew.L1
.L1:
            add.l   A1,D0
            addq.l  #4,D0
            cmp.l   D0,D4
            bge.b   .L2
            bsr.w   PartWrite
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            move.l  D0,D5
            bsr.b   PartRead
.L2:
            move.l  (4,A2),D0
            bsr.b   RLocnNew
            sub.l   D5,D0
            and.l   Lo3Bytes,D0
            movea.l A1,A0
            adda.l  D0,A0
            bsr.w   OddSize
            addq.l  #4,D0
            subq.l  #4,A0
            move.l  D0,D2
            add.l   A0,D2
            cmp.l   D2,D4
            bge.w   sub_4081B23E
            add.l   A0,D5
            sub.l   A1,D5
            and.l   Lo3Bytes,D5
            move.l  D0,D2
            move.l  D4,D0
            sub.l   A0,D0
            bsr.w   sub_4081B23E
            move.l  A1,D4
.L3:
            bsr.b   PartWrite
            bsr.b   PartRead
            beq.b   .L5
            sub.l   D0,D2
            movea.l A1,A0
            adda.l  D2,A0
            cmp.l   A0,D4
            bge.b   .L4
            move.l  D4,D0
            sub.l   A1,D0
            bsr.w   Ptr2Exit
            bra.b   .L3
.L4:
            move.l  A0,D0
            sub.l   A1,D0
            bra.w   Ptr2Exit
.L5:
            move.w  #$FF39,ResErr
            bra.w   Ptr2Exit.L1
PartRead:
            movem.l D0-D2/A0,-(SP)
            bsr.w   MaxRFEOF
            movea.l (A4),A0
            sub.l   D5,D0
            sub.l   (A0),D0
            and.l   Lo3Bytes,D0
            move.l  D3,D1
            sub.l   A1,D1
            cmp.l   D1,D0
            ble.b   .L1
            move.l  D1,D0
.L1:
            move.l  A1,D1
            move.l  D5,D2
            add.l   (A0),D2
            move.l  A1,D4
            add.l   D0,D4
            bsr.w   RdData
            tst.l   D0
            movem.l (SP)+,D0-D2/A0
            rts
PartWrite:
            movem.l D0-D2,-(SP)
            move.l  A1,D0
            sub.l   (A3),D0
            and.l   Lo3Bytes,D0
            beq.b   .L1
            movea.l (A4),A0
            move.l  D7,D2
            add.l   (A0),D2
            add.l   D2,D0
            andi.w  #$FE00,D0
            sub.l   D2,D0
            ble.b   .L1
            move.l  (A3),D1
            bsr.w   WrData
            add.l   D0,D7
            suba.l  D0,A1
            sub.l   D0,D4
            move.l  A1,-(SP)
            movea.l (A3),A1
            movea.l (A3),A0
            adda.l  D0,A0
            add.l   D4,D0
            sub.l   A0,D0
            and.l   Lo3Bytes,D0
            _BlockMove
            movea.l (SP)+,A1
.L1:
            movem.l (SP)+,D0-D2
            rts
CloseResFile:
            move.l  MinusOne,LastSPExtra
            move.w  ($B98).w,D0
            cmp.w   (4,SP),D0
            bne.b   .L1
            clr.l   ($B84).w
.L1:
            tst.w   (4,SP)
            bne.b   .L2
            bsr.w   sub_4081AEEE
.L2:
            bsr.w   sub_4081B010
            move.w  D6,-(SP)
            _UpdateResFile
            moveq   #$23,D0
            _GetTrapAddress
            bsr.w   GetRsrcCnt
            bmi.b   .L5
            movea.l A0,A4
            addq.w  #8,A2
.L3:
            move.l  (A2)+,D0
            beq.b   .L4
            movea.l D0,A0
            jsr     (A4)
.L4:
            addq.w  #8,A2
            dbra    D4,.L3
.L5:
            bsr.w   GetMap_ResourceMgr
            movea.l ($10,A3),A0
            tst.l   D0
            bne.b   .L6
            move.l  A0,TopMapHndl
            bra.b   .L7
.L6:
            movea.l D0,A1
            movea.l (A1),A1
            move.l  A0,($10,A1)
.L7:
            cmpa.l  SysMapHndl,A4
            bne.b   .L8
            lea     TopMapHndl,A0
            move.l  ROMMapHndl,(A0)+
            move.l  ROMMapHndl,(A0)+
            move.l  OneOne,(A0)+
            movea.l ROMMapHndl,A0
            movea.l (A0),A0
            clr.l   ($10,A0)
            bra.b   .L9
.L8:
            cmp.w   CurMap,D6
            bne.b   .L9
            movea.l (A0),A0
            move.w  ($14,A0),CurMap
.L9:
            bsr.w   SetFileIO
            _Close
            beq.b   .L10
            move.w  D0,ResErr
.L10:
            movea.l A4,A0
            _DisposHandle
            bra.w   StdTwoExit
Count1Resources:
            st      ($B9A).w
CountResources:
            bsr.w   sub_4081B708
            move.l  (A0),D3
            moveq   #0,D1
            bsr.w   sub_4081B63A
.L1:
            bsr.w   TypeScan
            bmi.b   .L2
            add.w   (4,A2),D1
            addq.w  #1,D1
.L2:
            bsr.w   sub_4081B67C
            beq.b   .L1
            move.w  D1,($C,A6)
            bra.w   StdFourExit
Get1IndResource:
            st      ($B9A).w
GetIndResource:
            bsr.w   sub_4081B708
            move.w  (A0)+,D7
            ble.w   .L7
            move.l  (A0)+,D3
            clr.l   (A0)+
            move.b  ($B9A).w,D0
            cmp.b   ($B9B).w,D0
            bne.b   .L2
            tst.l   ($B84).w
            beq.b   .L2
            cmp.l   ($B80).w,D3
            bne.b   .L2
            cmp.w   ($B9C).w,D7
            bne.b   .L2
            addq.w  #1,($B9C).w
            bsr.w   RestoreCache
            tst.w   D4
            beq.b   .L1
            subq.w  #1,D4
            lea     ($C,A2),A2
            bra.b   .L6
.L1:
            moveq   #0,D7
            bra.b   .L5
.L2:
            move.b  D0,($B9B).w
            move.w  D7,($B9C).w
            addq.w  #1,($B9C).w
            subq.w  #1,D7
            bsr.w   sub_4081B63A
.L3:
            bsr.w   TypeScan
            bmi.b   .L5
            bsr.w   sub_4081B6E2
            cmp.w   D7,D4
            bmi.b   .L4
            sub.w   D7,D4
            add.w   D7,D7
            add.w   D7,D7
            adda.w  D7,A2
            add.w   D7,D7
            adda.w  D7,A2
            bra.b   .L6
.L4:
            sub.w   D4,D7
            subq.w  #1,D7
.L5:
            bsr.w   sub_4081B67C
            beq.b   .L3
            bmi.b   .L7
.L6:
            bsr.w   SaveIndCache
            bsr.w   CheckLoad
            move.l  A0,($E,A6)
            move.l  A0,($B84).w
            bra.b   .L8
.L7:
            move.w  #$FF40,ResErr
.L8:
            bra.w   StdSixExit
Count1Types:
            st      ($B9A).w
CountTypes:
            bsr.w   sub_4081B708
            bsr.b   sub_4081B502
            unlk    A6
            move.w  D7,(8,A6)
            bra.w   StdZeroExit
sub_4081B502:
            movea.l (SP)+,A0
            link.w  A6,#0
            moveq   #0,D7
            bsr.w   sub_4081B63A
.L1:
            bsr.w   sub_4081B698
            bmi.b   .L6
.L2:
            move.l  (A2),D3
            movea.l SP,A1
            move.w  D7,D0
            subq.w  #1,D0
            bmi.b   .L4
.L3:
            cmp.l   (A1)+,D3
            dbeq    D0,.L3
            beq.b   .L5
.L4:
            move.l  D3,-(SP)
            addq.w  #1,D7
.L5:
            addq.l  #8,A2
            dbra    D5,.L2
.L6:
            bsr.w   sub_4081B67C
            beq.b   .L1
            jmp     (A0)
Get1IndType:
            st      ($B9A).w
GetIndType:
            bsr.w   sub_4081B708
            move.w  (A0)+,D2
            move.l  (A0),D1
            bsr.b   sub_4081B502
            movea.l D1,A0
            clr.l   (A0)
            subq.w  #1,D2
            bmi.b   .L1
            cmp.w   D2,D7
            ble.b   .L1
            asl.w   #2,D2
            move.l  (0,SP,D2.w),(A0)
.L1:
            unlk    A6
            bra.w   StdSixExit
Unique1ID:
            st      ($B9A).w
UniqueID:
            bsr.w   sub_4081B708
            move.w  ($16C).w,D7
.L1:
            bsr.w   sub_4081B63A
            subq.w  #2,SP
            _Random
            add.w   (SP)+,D7
            andi.w  #$7FFF,D7
            move.l  (8,A6),D3
            move.w  D7,D2
.L2:
            bsr.w   TypeScan
            bmi.b   .L3
            bsr.w   sub_4081B6E2
            bsr.w   sub_4081B6C2
            beq.b   .L1
.L3:
            bsr.w   sub_4081B67C
            beq.b   .L2
            move.w  D2,($C,A6)
            bra.w   StdFourExit
Get1Resource:
            st      ($B9A).w
GetResource:
            bsr.w   sub_4081B708
            bsr.w   GetCurMap
            bpl.b   .L1
            bsr.w   sub_4081B63A
.L1:
            move.w  (A0)+,D2
            move.l  (A0)+,D3
            clr.l   (A0)
.L2:
            bsr.w   TypeScan
            bmi.b   .L3
            bsr.w   sub_4081B6E2
            bsr.w   sub_4081B6C2
            beq.b   .L4
.L3:
            bsr.w   sub_4081B67C
            beq.b   .L2
            bra.b   .L5
.L4:
            bsr.w   sub_4081B866
            bsr.w   CheckLoad
            move.l  A0,($E,A6)
            move.l  A0,($B84).w
.L5:
            bra.w   StdSixExit
Get1NamedResource:
            st      ($B9A).w
GetNamedResource:
            bsr.w   sub_4081B708
            bsr.b   GetCurMap
            movea.l (A0),A1
            clr.l   ($10,A6)
.L1:
            move.l  ($C,A6),D3
            bsr.w   TypeScan
            bmi.b   .L4
            bsr.w   sub_4081B6E2
.L2:
            bsr.w   NameResource
            bmi.b   .L3
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
            _CmpString
            subq.w  #1,A1
            beq.b   .L5
.L3:
            bsr.w   sub_4081B89E
            beq.b   .L2
.L4:
            bsr.b   sub_4081B67C
            beq.b   .L1
            move.w  #$FF40,ResErr
            bra.b   .L6
.L5:
            bsr.w   sub_4081B866
            bsr.w   CheckLoad
            move.l  A0,($10,A6)
            move.l  A0,($B84).w
.L6:
            moveq   #8,D0
            bra.w   StdExit
sub_4081B63A:
            tst.b   ($B9A).w
            bne.b   GetCurMap
            movea.l TopMapHndl,A4
            movea.l (A4),A3
            move.w  ($14,A3),D6
            movea.l A3,A2
            rts
GetCurMap:
            move.w  CurMap,D6
GetMap_ResourceMgr:
            tst.w   D6
            bmi.w   sub_4081B6E2.L3
            bne.b   .L1
            move.w  SysMap,D6
.L1:
            movea.l TopMapHndl,A4
            moveq   #0,D0
            bra.b   .L3
.L2:
            move.l  ($10,A3),D0
            beq.w   sub_4081B6E2.L3
            exg     D0,A4
.L3:
            movea.l (A4),A3
            cmp.w   ($14,A3),D6
            bne.b   .L2
            movea.l A3,A2
            rts
sub_4081B67C:
            tst.b   ($B9A).w
            beq.b   .L1
            suba.l  A4,A4
            bra.b   .L2
.L1:
            movea.l (A4),A3
            movea.l ($10,A3),A4
.L2:
            move.l  A4,D0
            beq.b   sub_4081B6E2.L3
            movea.l (A4),A3
            move.w  ($14,A3),D6
            bra.b   sub_4081B6E2.L2
sub_4081B698:
            movea.l (A4),A3
            adda.w  ($18,A3),A3
            movea.l A3,A2
            move.w  (A2)+,D5
            rts
GetRsrcCnt:
            bsr.b   sub_4081B6B8
            bmi.b   .L3
            addq.w  #6,A3
            add.w   D5,D4
            bra.b   .L2
.L1:
            addq.w  #8,A3
            add.w   (A3),D4
.L2:
            dbra    D5,.L1
.L3:
            rts
sub_4081B6B8:
            bsr.b   sub_4081B698
            move.l  (A2),D3
            bsr.b   sub_4081B6E2
            tst.w   D5
            rts
sub_4081B6C2:
            moveq   #$C,D0
.L1:
            cmp.w   (A2),D2
            adda.w  D0,A2
            dbeq    D4,.L1
            beq.b   sub_4081B6E2.L1
            bra.b   sub_4081B6E2.L3
TypeScan:
            bsr.b   sub_4081B698
            bmi.b   sub_4081B6E2.L3
            moveq   #8,D0
.L1:
            cmp.l   (A2),D3
            adda.w  D0,A2
            dbeq    D5,.L1
            beq.b   sub_4081B6E2.L1
            bra.b   sub_4081B6E2.L3
sub_4081B6E2:
            move.w  (4,A2),D4
            move.l  D0,-(SP)
            moveq   #0,D0
            move.w  (6,A2),D0
            movea.l D0,A2
            move.l  (SP)+,D0
            adda.l  A3,A2
            rts
.L1:
            suba.w  D0,A2
.L2:
            moveq   #0,D0
            rts
.L3:
            moveq   #-1,D0
            rts
StdZEntry:
            clr.w   ROMMapInsert
Std1Entry:
            clr.b   ($B9A).w
sub_4081B708:
            movea.l ($698).w,A0
            jmp     (A0)
vRMgrStdEntry:
            clr.w   ResErr
            movea.l (SP)+,A0
            link.w  A6,#-$32
            clr.w   (-$1C,A6)
            clr.w   (-$18,A6)
            move.b  RMGRPerm,(-$17,A6)
            movem.l D1-D7/A1-A4,-(SP)
            suba.l  A4,A4
            move.l  A0,-(SP)
            lea     (8,A6),A0
            tst.b   ROMMapInsert
            beq.b   .L1
            moveq   #0,D1
            bsr.b   sub_4081B73E
.L1:
            rts
sub_4081B73E:
            movem.l D0/A0-A2,-(SP)
            movea.l SysMapHndl,A1
            movea.l ROMMapHndl,A2
            cmpa.l  A1,A2
            beq.b   .L7
            move.w  CurMap,D0
            tst.l   D1
            beq.b   .L1
            exg     A1,A2
            cmpi.w  #1,D0
            bne.b   .L2
            move.w  SysMap,CurMap
            bra.b   .L2
.L1:
            cmp.w   SysMap,D0
            bne.b   .L2
            move.w  #1,CurMap
.L2:
            movea.l TopMapHndl,A0
.L3:
            movea.l (A0),A0
            move.l  ($10,A0),D0
            beq.b   .L5
            cmp.l   A1,D0
            beq.b   .L4
            movea.l D0,A0
            bra.b   .L3
.L4:
            move.l  A2,($10,A0)
            bra.b   .L6
.L5:
            cmpa.l  TopMapHndl,A1
            bne.b   .L6
            move.l  A2,TopMapHndl
.L6:
            movea.l ROMMapHndl,A0
            movea.l (A0),A0
            move.l  SysMapHndl,($10,A0)
            move.b  ResLoad,D0
            move.b  ($B9F).w,ResLoad
            move.b  D0,($B9F).w
.L7:
            movem.l (SP)+,D0/A0-A2
            rts
StdSixExit:
            moveq   #6,D0
            bra.b   StdExit
StdFourExit:
            moveq   #4,D0
            bra.b   StdExit
StdTwoExit:
            moveq   #2,D0
            bra.b   StdExit
StdZeroExit:
            moveq   #0,D0
StdExit:
            movea.l ($69C).w,A1
            jmp     (A1)
VRMGRSTDEXIT:
            tst.b   ROMMapInsert
            beq.b   .L1
            moveq   #-1,D1
            bsr.w   sub_4081B73E
.L1:
            clr.b   ($B9A).w
            clr.w   ROMMapInsert
            clr.b   RMGRPerm
            movem.l (SP)+,D1-D7/A1-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.l  D0,SP
            move.l  A0,-(SP)
            suba.l  A0,A0
            move.w  ResErr,D0
            beq.b   .L2
            move.l  ResErrProc,-(SP)
            bne.b   .L2
            addq.w  #4,SP
.L2:
            rts
HandleScan:
            move.l  A1,D0
            beq.w   sub_4081B6E2.L3
            cmpa.l  ($B84).w,A1
            beq.b   RestoreCache
.L1:
            bsr.w   sub_4081B63A
            move.l  A0,-(SP)
.L2:
            bsr.w   sub_4081B6B8
            bmi.b   .L5
            movea.l A3,A0
            addq.w  #8,A0
.L3:
            addq.w  #2,A0
.L4:
            addq.w  #8,A2
            cmpa.l  (A2)+,A1
            dbeq    D4,.L4
            beq.b   .L6
            move.l  (A0)+,D3
            move.w  (A0)+,D4
            dbra    D5,.L3
.L5:
            bsr.w   sub_4081B67C
            beq.b   .L2
            movea.l (SP)+,A0
            bra.w   sub_4081B6E2.L3
.L6:
            suba.w  #$C,A2
            bsr.b   sub_4081B866
            movea.l (SP)+,A0
            bra.w   sub_4081B6E2.L2
RestoreCache:
            movem.l ($B80).w,D3/A1-A4
            movem.w ($B94).w,D4-D6
            adda.l  (A4),A2
            adda.l  (A4),A3
            cmpa.l  (8,A2),A1
            beq.w   sub_4081B6E2.L2
            clr.l   ($B84).w
            bra.b   HandleScan.L1
sub_4081B866:
            move.w  MinusOne,($B9C).w
SaveIndCache:
            move.l  (A4),D0
            suba.l  D0,A2
            suba.l  D0,A3
            movem.l D3/A1-A4,($B80).w
            movem.w D4-D6,($B94).w
            adda.l  D0,A2
            adda.l  D0,A3
            rts
NameResource:
            move.w  (2,A2),D0
            bmi.b   .L1
            movea.l (A4),A0
            adda.w  ($1A,A0),A0
            adda.w  D0,A0
            bra.w   sub_4081B6E2.L2
.L1:
            lea     RMGR,A0
            bra.w   sub_4081B6E2.L3
sub_4081B89E:
            lea     ($C,A2),A2
            subq.w  #1,D4
            bpl.w   sub_4081B6E2.L2
            subq.w  #1,D5
            bmi.w   sub_4081B6E2.L3
            move.w  (A3),D0
            sub.w   D5,D0
            asl.w   #3,D0
            move.l  (2,A3,D0.w),D3
            move.w  (6,A3,D0.w),D4
            moveq   #1,D0
            rts
.L1:
            move.l  A1,-(SP)
            move.l  (4,A2),D0
            and.l   Lo3Bytes,D0
            add.l   ROMBase,D0
            movea.l D0,A1
            movea.l ROMMapHndl,A0
            _HandleZone
            move.l  (-4,A1),D0
            and.l   Lo3Bytes,D0
            adda.l  D0,A0
            move.l  A0,(8,A2)
            tst.b   ResLoad
            beq.b   .L2
            move.l  A1,(A0)
            bsr.w   sub_4081B97C
.L2:
            movea.l (SP)+,A1
            rts
CheckLoad:
            movea.l ($7F0).w,A0
            jmp     (A0)
vCheckLoad:
            move.b  (4,A2),D1
            cmpa.l  ROMMapHndl,A4
            beq.b   sub_4081B89E.L1
            move.l  TheZone,-(SP)
            btst    #6,D1
            beq.b   .L1
            move.l  SysZone,TheZone
.L1:
            movea.l (8,A2),A0
            suba.l  (A4),A3
            tst.b   ResLoad
            beq.b   sub_4081B92C.L5
            move.l  A0,D0
            bne.b   sub_4081B92C.L2
            bsr.b   sub_4081B92C
            _NewHandle
            beq.b   sub_4081B92C.L3
            bra.b   sub_4081B92C.L4
sub_4081B92C:
            bsr.b   ReadResData
            move.l  D0,D2
            suba.l  (A4),A2
            btst    #4,D1
            beq.b   .L1
            _ResrvMem
.L1:
            move.l  D2,D0
            rts
.L2:
            tst.l   (A0)
            bne.b   .L7
            bsr.b   sub_4081B92C
            _ReallocHandle
            bmi.b   .L4
.L3:
            adda.l  (A4),A2
            move.l  A0,(8,A2)
            bsr.b   RdRsrc
            bsr.b   sub_4081B97C
            move.w  ResErr,D0
            beq.b   .L7
            suba.l  (A4),A2
.L4:
            move.w  D0,ResErr
            suba.l  A0,A0
            bra.b   .L6
.L5:
            move.l  A0,D0
            bne.b   .L7
            suba.l  (A4),A2
            _NewEmptyHandle
.L6:
            adda.l  (A4),A2
.L7:
            move.l  A0,D0
            beq.b   .L8
            move.l  A0,(8,A2)
.L8:
            adda.l  (A4),A3
            move.l  (SP)+,TheZone
            rts
sub_4081B97C:
            lsl.b   #3,D1
            rol.b   #1,D1
            roxr.b  #2,D1
            ori.b   #$20,D1
            andi.b  #$E0,D1
            _HGetState
            andi.b  #$1F,D0
            or.b    D1,D0
            _HSetState
            rts
ReadResData:
            movem.l D1-D2/A0-A1,-(SP)
            bsr.b   RREntry
            subq.l  #4,SP
            move.l  SP,D1
            moveq   #4,D0
            bsr.b   RdData
            move.l  (SP)+,D0
            movem.l (SP)+,D1-D2/A0-A1
            rts
RdRsrc:
            movem.l D0-D2/A0-A1,-(SP)
            move.l  D2,D0
            bsr.b   RREntry
            addq.l  #4,D2
            move.l  (A1),D1
            bsr.b   RdData
.L1:
            movem.l (SP)+,D0-D2/A0-A1
            rts
RREntry:
            andi.b  #$FD,(4,A2)
            movea.l (A4),A0
            move.l  (4,A2),D2
            and.l   Lo3Bytes,D2
            add.l   (A0),D2
            movea.l (8,A2),A1
            rts
WrRsrc:
            movem.l D0-D2/A0-A1,-(SP)
            bsr.b   RREntry
            movea.l A1,A0
            _GetHandleSize
            tst.l   D0
            bpl.b   .L1
            moveq   #0,D0
.L1:
            move.l  D0,-(SP)
            move.l  SP,D1
            moveq   #4,D0
            bsr.b   WrData
            addq.l  #4,D2
            move.l  (A1),D1
            move.l  (SP)+,D0
            bsr.b   WrData
            bra.b   RdRsrc.L1
SetFileIO:
            lea     (-$1A,A6),A0
            move.w  D6,(A0)+
            addq.w  #6,A0
            move.l  D1,(A0)+
            move.l  D0,(A0)+
            addq.w  #4,A0
            move.w  #1,(A0)+
            move.l  D2,(A0)+
            lea     (-$32,A6),A0
            rts
RdData:
            bsr.b   SaveRegs
            bsr.b   SetFileIO
            _Read
            bra.b   IOExit
WrDataSt:
            moveq   #0,D2
WrData:
            bsr.b   SaveRegs
            bsr.b   SetFileIO
            _Write
IOExit:
            move.w  D0,ResErr
RestRegs:
            adda.l  (A4),A3
            adda.l  (A4),A2
            movem.l (SP)+,D0-D1/A0-A1
            rts
SaveRegs:
            movem.l D0-D1/A0,-(SP)
            movea.l ($C,SP),A0
            move.l  A1,($C,SP)
            suba.l  (A4),A3
            suba.l  (A4),A2
            jmp     (A0)
SetRFEOF:
            bsr.b   SaveRegs
            bsr.w   ResRW
            bne.b   RestRegs
            bsr.b   SetFileIO
            bsr.b   MaxRFEOF
            move.l  D0,($1C,A0)
            _SetEOF
            bra.b   IOExit
MaxRFEOF:
            movem.l D1/A1,-(SP)
            movea.l (A4),A1
            move.l  (A1)+,D0
            move.l  (A1)+,D1
            add.l   (A1)+,D0
            add.l   (A1)+,D1
            cmp.l   D1,D0
            bpl.b   .L1
            move.l  D1,D0
.L1:
            movem.l (SP)+,D1/A1
            rts
GetHS:
            movea.l (8,A2),A0
            _GetHandleSize
            addq.l  #4,D0
            move.l  D0,D1
            rts
SpaceAt:
            movem.l D1/D7/A0-A2,-(SP)
            move.l  (4,A2),D7
            and.l   Lo3Bytes,D7
            movea.l (A4),A0
            move.l  (4,A0),D0
            sub.l   (A0),D0
            movea.l D0,A1
            bmi.b   .L2
            cmpa.l  D7,A1
            bmi.b   .L2
            bsr.w   ZNextRes
            bmi.b   .L1
            cmpa.l  D0,A1
            bpl.b   satNotLast
.L1:
            move.l  A1,D0
            bra.b   satLast
.L2:
            bsr.w   ZNextRes
            bpl.b   satNotLast
            bsr.b   MaxRFEOF
            sub.l   (A0),D0
satLast:
            sub.l   D7,D0
            moveq   #-1,D7
            bra.b   satReturn
satNotLast:
            sub.l   D7,D0
satReturn:
            movem.l (SP)+,D1/D7/A0-A2
            rts
ReallocRes:
            bsr.b   GetHS
            bsr.b   SpaceAt
            cmp.l   D0,D1
            ble.w   SetRFEOF
AllocRes:
            bsr.b   GetHS
            bsr.b   MaxRFEOF
            movea.l (A4),A0
            sub.l   (A0),D0
            move.b  (4,A2),-(SP)
            move.l  D0,(4,A2)
            move.b  (SP)+,(4,A2)
            add.l   D1,D0
            move.l  D0,(8,A0)
            ori.b   #$60,($16,A0)
            bra.w   SetRFEOF
ResRW:
            movea.l (A4),A0
            btst    #7,($16,A0)
            rts
CheckGrow:
            bsr.w   SaveRegs
            move.l  D2,-(SP)
            moveq   #$46,D1
            asl.w   #2,D1
            movea.l A4,A0
            _GetHandleSize
            move.l  D0,D2
            add.l   D1,D0
            _SetHandleSize
            exg     D0,D2
            _SetHandleSize
            move.w  D2,D0
            bmi.b   .L2
            bsr.b   ResRW
            bne.b   .L2
            move.l  A1,D0
            beq.b   .L1
            movea.l A1,A0
            _GetHandleSize
            move.l  D0,D2
            bmi.b   .L2
            add.l   D0,D1
.L1:
            bsr.w   SetFileIO
            lea     ($1C,A0),A1
            _GetEOF
            move.l  (A1),D2
            add.l   D1,(A1)
            _SetEOF
.L2:
            move.l  (SP)+,D2
            bra.w   IOExit
CheckMap:
            movem.l D0-D1/A0-A1,-(SP)
            movea.l (A4),A0
            bsr.w   MaxRFEOF
            cmp.l   Lo3Bytes,D0
            bge.b   .L5
            btst    #0,($19,A0)
            bne.b   .L5
            movea.l A0,A1
            adda.w  ($18,A0),A1
            move.w  (A1)+,D0
            bmi.b   .L2
            moveq   #0,D1
.L1:
            add.w   (4,A1),D1
            addq.w  #1,D1
            addq.w  #8,A1
            dbra    D0,.L1
            mulu.w  #$C,D1
            adda.l  D1,A1
.L2:
            move.w  ($1A,A0),D1
            bgt.b   .L3
            suba.l  A0,A1
            move.l  A1,D1
            and.l   Lo3Bytes,D1
            cmp.l   ($C,A0),D1
            bgt.b   .L5
            bra.b   .L4
.L3:
            adda.w  D1,A0
            cmpa.l  A1,A0
            bmi.b   .L5
.L4:
            moveq   #0,D0
            bra.b   .L6
.L5:
            move.w  #$FF39,ResErr
.L6:
            movem.l (SP)+,D0-D1/A0-A1
            rts
LoadResource:
            movem.l D0/A0,-(SP)
            pea     .L9
            bsr.w   Std1Entry
            movea.l ($14,A6),A1
            tst.l   (A1)
            bne.b   .L2
            bsr.w   HandleScan
            beq.b   .L1
            move.w  #$FF40,ResErr
            bra.b   .L2
.L1:
            move.b  ResLoad,-(SP)
            st      ResLoad
            bsr.w   CheckLoad
            move.b  (SP)+,ResLoad
.L2:
            bra.w   StdZeroExit
.L9:
            movem.l (SP)+,D0/A0
            move.l  (SP)+,(SP)
            rts
ReleaseResource:
            bsr.w   StdResEntry
            btst    #1,(4,A2)
            bne.b   .L3
            movea.l A1,A0
            _DisposHandle
.L1:
            cmpi.l  #'FONT',D3
            bne.b   .L2
            move.l  MinusOne,LastSPExtra
.L2:
            clr.l   (8,A2)
            clr.l   ($B84).w
.L3:
            bra.w   StdFourExit
DetachResource:
            bsr.b   StdResEntry
            btst    #1,(4,A2)
            bne.b   .L1
            movea.l A1,A0
            _HClrRBit
            bra.b   ReleaseResource.L1
.L1:
            move.w  #$FF3A,ResErr
            bra.b   ReleaseResource.L3
ChangedResource:
            bsr.b   StdResEntry
            movea.l A1,A0
            _HGetState
            move.b  D0,D7
            _HNoPurge
            btst    #3,(4,A2)
            bne.b   .L1
            bsr.w   CheckGrow
            bmi.b   .L2
            bset    #1,(4,A2)
            bsr.w   ReallocRes
            movea.l (A4),A0
            bset    #5,($16,A0)
            bra.b   .L2
.L1:
            move.w  #$FF3A,ResErr
.L2:
            movea.l A1,A0
            move.b  D7,D0
            _HSetState
            bra.w   StdFourExit
WriteResource:
            bsr.b   StdResEntry
            bsr.w   ResRW
            bne.b   .L1
            btst    #1,(4,A2)
            beq.b   .L1
            bsr.w   WrRsrc
.L1:
            bra.w   StdFourExit
Std2ResEntry:
            move.l  MinusOne,($C,SP)
StdResEntry:
            move.l  (SP)+,D0
            bsr.w   Std1Entry
            move.l  D0,-(SP)
            move.l  A0,D0
            beq.b   .L1
            movea.l (A0),A1
            bsr.w   RefHandle
            beq.b   .L2
.L1:
            addq.w  #4,SP
            bra.w   StdFourExit
.L2:
            rts
HomeResFile:
            move.w  #$FFFF,(8,SP)
            bsr.b   StdResEntry
            cmp.w   SysMap,D6
            bne.b   .L1
            moveq   #0,D6
.L1:
            move.w  D6,($C,A6)
            bra.w   StdFourExit
RPHook:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _HGetState
            btst    #5,D0
            beq.b   .L1
            move.l  A0,-(SP)
            _WriteResource
.L1:
            jmp     (A1)
SetResPurge:
            movea.l TheZone,A0
            move.l  (SP)+,D0
            tst.b   (SP)+
            pea     RPHook
            bne.b   .L1
            clr.l   (SP)
.L1:
            move.l  (SP)+,($28,A0)
            move.l  D0,-(SP)
.L2:
            clr.b   ($B9A).w
            clr.w   ROMMapInsert
            rts
SetResLoad:
            movea.l (SP)+,A0
            move.b  (SP)+,ResLoad
            move.l  A0,-(SP)
            bra.b   SetResPurge.L2
CurResFile:
            move.w  CurMap,(4,SP)
            bra.b   SetResPurge.L2
ResError:
            move.w  ResErr,(4,SP)
            bra.b   SetResPurge.L2
AddReference:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            move.l  A0,-(SP)
            move.w  #$FF3D,ResErr
            bra.b   SetResPurge.L2
RmveReference:
            move.l  (SP)+,(SP)
            move.w  #$FF3B,ResErr
            bra.b   SetResPurge.L2
GetResAttrs:
            bsr.w   Std1Entry
            movea.l (A0),A1
            bsr.b   RefHandle
            bmi.b   .L1
            move.b  (4,A2),($D,A6)
.L1:
            bra.w   StdFourExit
SetResAttrs:
            bsr.w   Std1Entry
            movea.l ($A,A6),A1
            bsr.b   RefHandle
            bmi.b   .L1
            cmpa.l  ROMMapHndl,A4
            beq.b   .L1
            move.b  (9,A6),(4,A2)
            movea.l (A4),A0
            bset    #5,($16,A0)
.L1:
            bra.w   StdSixExit
RefHandle:
            bsr.w   HandleScan
            beq.b   .L1
            move.w  #$FF40,ResErr
.L1:
            rts
GetResInfo:
            bsr.w   Std1Entry
            movea.l ($14,A6),A1
            bsr.b   RefHandle
            beq.b   .L1
            lea     MinusOne,A2
            moveq   #0,D3
.L1:
            lea     ($10,A6),A0
            movea.l (A0),A1
            move.l  A1,D0
            beq.b   .L2
            move.w  (A2),(A1)
.L2:
            movea.l -(A0),A1
            move.l  A1,D0
            beq.b   .L3
            move.l  D3,(A1)
.L3:
            movea.l -(A0),A1
            move.l  A1,D0
            beq.b   .L4
            clr.b   (A1)
            bsr.w   NameResource
            bmi.b   .L4
            bsr.b   CopyStr
.L4:
            moveq   #$10,D0
            bra.w   StdExit
CopyStr:
            moveq   #0,D0
            move.b  (A0),D0
            addq.w  #1,D0
            _BlockMove
            rts
SetResInfo:
            bsr.w   Std1Entry
            movea.l ($E,A6),A1
            bsr.b   RefHandle
            bmi.b   .L3
            btst    #3,(4,A2)
            bne.b   .L2
            move.l  (8,A6),D0
            beq.b   .L1
            suba.l  A1,A1
            bsr.w   CheckGrow
            bmi.b   .L3
            movea.l D0,A0
            bsr.w   RmveName
            bsr.w   AllocRes_wrongname
            bsr.w   SetRFEOF
.L1:
            movea.l (A4),A0
            bset    #5,($16,A0)
            move.w  ($C,A6),(A2)
            bra.b   .L3
.L2:
            move.w  #$FF3A,ResErr
.L3:
            moveq   #$A,D0
            bra.w   StdExit
AddResource:
            bsr.w   StdZEntry
            move.w  #$FF3E,ResErr
            movea.l ($12,A6),A1
            move.l  A1,D0
            beq.b   .L1
            bsr.w   HandleScan
            beq.b   .L1
            bsr.w   GetCurMap
            bsr.w   CheckGrow
            bmi.b   .L1
            move.l  ($E,A6),D3
            bsr.b   AddNewRef
            move.w  ($C,A6),(A2)+
            move.w  #$FFFF,(A2)+
            move.l  #$2000000,(A2)+
            movea.l ($12,A6),A0
            _HSetRBit
            move.l  A0,(A2)
            subq.l  #8,A2
            movea.l (8,A6),A0
            bsr.w   AllocRes_wrongname
            bsr.w   AllocRes
.L1:
            moveq   #$E,D0
            bra.w   StdExit
AddNewRef:
            bset    #5,($16,A3)
            bsr.w   TypeScan
            beq.b   .L2
            moveq   #$14,D0
            bsr.w   MoveNames
            bsr.w   sub_4081B698
            bmi.b   .L1
            bsr.w   sub_4081B6E2
.L1:
            movea.l A2,A3
            movea.l (A4),A2
            adda.w  ($1A,A2),A2
            suba.w  #$14,A2
            moveq   #8,D0
            movea.l A3,A0
            movea.l A2,A1
            bsr.w   ShiftBlock
            movea.l (A4),A0
            adda.w  ($18,A0),A0
            addq.w  #1,(A0)
            move.l  D3,(A3)+
            clr.w   (A3)+
            suba.l  A0,A1
            move.w  A1,(A3)
            addq.l  #8,A2
            move.w  (A0)+,D5
            bra.b   UTOffsets
.L2:
            moveq   #$C,D0
            bsr.w   MoveNames
            movea.l (A4),A1
            adda.w  ($1A,A1),A1
            suba.w  D0,A1
            bsr.w   TypeScan
            move.l  A2,-(SP)
            addq.w  #1,(4,A2)
            moveq   #$C,D0
            mulu.w  (4,A2),D0
            movea.w (6,A2),A2
            adda.l  A3,A2
            adda.w  D0,A2
            movea.l A2,A0
            moveq   #$C,D0
            bsr.w   ShiftBlock
            movea.l (SP)+,A0
            bra.b   UTInLoop
UTOffsets:
            add.w   D0,(6,A0)
UTInLoop:
            addq.w  #8,A0
            dbra    D5,UTOffsets
            rts
RmveResource:
            bsr.w   Std1Entry
            move.w  #$FF3C,ResErr
            movea.l (A0),A1
            bsr.w   HandleScan
            bmi.b   .L4
            btst    #3,(4,A2)
            bne.b   .L4
            cmp.w   CurMap,D6
            bne.b   .L4
            movea.l A1,A0
            _HClrRBit
            moveq   #$60,D0
            clr.l   ($B84).w
            movea.l (A4),A0
            or.b    D0,($16,A0)
            bsr.w   RmveName
            moveq   #-$C,D7
            movea.l A2,A0
            suba.w  D7,A0
            bsr.w   TypeScan
            movea.l (A4),A1
            adda.w  ($1A,A1),A1
            move.l  D7,D0
            bsr.w   ShiftBlock
            movea.l A2,A0
            addq.w  #8,A0
            subq.w  #1,D5
            bmi.b   .L1
            bsr.b   UTOffsets
.L1:
            subq.w  #1,(4,A2)
            bpl.b   .L2
            addq.w  #8,A2
            movea.l A2,A0
            adda.w  D0,A1
            moveq   #-8,D0
            add.l   D0,D7
            bsr.w   ShiftBlock
            movea.l (A4),A0
            adda.w  ($18,A0),A0
            subq.w  #1,(A0)
            move.w  (A0)+,D5
            bmi.b   .L2
            bsr.w   UTOffsets
.L2:
            move.l  D7,D0
            bsr.b   MoveNames
            cmpi.w  #1,D6
            beq.b   .L3
            bsr.w   SetRFEOF
.L3:
            clr.w   ResErr
.L4:
            clr.l   ($B84).w
            bra.w   StdFourExit
AllocRes_wrongname:
            clr.l   ($B84).w
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #-1,D2
            tst.b   (A0)
            beq.b   .L1
            movea.l (A4),A1
            move.l  ($C,A1),D1
            move.l  D1,D2
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            bsr.b   sub_4081BFBA
            moveq   #0,D0
            movea.l (A4),A1
            move.w  ($1A,A1),D0
            sub.l   D0,D2
            adda.l  D1,A1
            bsr.w   CopyStr
.L1:
            move.w  D2,(2,A2)
            movem.l (SP)+,D0-D2/A0-A1
            rts
MoveNames:
            movem.l D0-D1/D7/A0-A1,-(SP)
            movea.l (A4),A0
            move.l  ($C,A0),D1
            tst.l   D0
            bmi.b   .L1
            bsr.b   sub_4081BFBA
            movea.l (A4),A0
.L1:
            movea.l A0,A1
            moveq   #0,D7
            move.w  ($1A,A0),D7
            adda.l  D7,A0
            add.w   D0,($1A,A1)
            adda.l  D1,A1
            bsr.b   ShiftBlock
            tst.l   D0
            bpl.b   .L2
            bsr.b   sub_4081BFBA
.L2:
            movem.l (SP)+,D0-D1/D7/A0-A1
            rts
sub_4081BFBA:
            bsr.w   SaveRegs
            movea.l (A4),A0
            add.l   ($C,A0),D0
            move.l  D0,($C,A0)
            movea.l A4,A0
            _SetHandleSize
            bra.w   RestRegs
ShiftBlock:
            movem.l D0/A0-A1,-(SP)
            exg     D0,A1
            sub.l   A0,D0
            and.l   Lo3Bytes,D0
            adda.l  A0,A1
            _BlockMove
            movem.l (SP)+,D0/A0-A1
            rts
RmveName:
            movem.l D0-D2/A0-A1,-(SP)
            move.w  (2,A2),D2
            bmi.b   .L3
            movea.l (A4),A0
            movea.l A0,A1
            moveq   #0,D0
            move.w  ($1A,A0),D0
            adda.l  D0,A0
            adda.w  D2,A0
            adda.l  ($C,A1),A1
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            adda.l  D0,A0
            neg.l   D0
            move.l  D0,D1
            bsr.b   ShiftBlock
            bsr.b   sub_4081BFBA
            movem.l D3-D5/A2-A3,-(SP)
            bsr.w   GetRsrcCnt
.L1:
            cmp.w   (2,A2),D2
            bge.b   .L2
            add.w   D1,(2,A2)
.L2:
            lea     ($C,A2),A2
            dbra    D4,.L1
            movem.l (SP)+,D3-D5/A2-A3
.L3:
            movem.l (SP)+,D0-D2/A0-A1
            move.w  MinusOne,(2,A2)
            rts
SizeResource:
            bsr.w   Std2ResEntry
            tst.l   (A1)
            beq.b   .L1
            movea.l A1,A0
            _GetHandleSize
            bra.b   .L2
.L1:
            move.b  (4,A2),-(SP)
            bsr.w   ReadResData
            move.b  (SP)+,(4,A2)
.L2:
            move.l  D0,($C,A6)
            bra.w   StdFourExit
MaxSizeRsrc:
            bsr.w   Std2ResEntry
            tst.l   (A1)
            bne.b   .L1
            bsr.w   SpaceAt
            bra.b   .L2
.L1:
            movea.l A1,A0
            _GetHandleSize
.L2:
            bra.b   SizeResource.L2
RSRCMAPENTRY:
            bsr.w   Std2ResEntry
            move.l  A2,D0
            sub.l   (A4),D0
            _StripAddress
            bra.b   SizeResource.L2
RGETRESOURCE:
            clr.b   ROMMapInsert
            bsr.b   sub_4081C092
            bne.b   .L1
            st      ROMMapInsert
            bsr.b   sub_4081C092
.L1:
            movea.l (SP)+,A0
            addq.w  #6,SP
            jmp     (A0)
sub_4081C092:
            move.b  ResLoad,($B9F).w
            subq.w  #4,SP
            move.l  ($E,SP),-(SP)
            move.w  ($10,SP),-(SP)
            _GetResource
            move.l  (SP)+,($E,SP)
            rts
IAPPEND:
            ds.b    6

            EVEN
