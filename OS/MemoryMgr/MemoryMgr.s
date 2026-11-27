            include "Include/ROMHeader.s"

            EXPORT  CompactMem,DisposePtr,DsposeHandle,EmptyHandle,FreeMem,GetHandleSize
            EXPORT  GetPtrSize,GetZone,HandleZone,HGetFlags,HLock,HNoPurge
            EXPORT  HNoRSRC,HPurge,HRSRC,HSetFlags,HUnlock,InitApplZone
            EXPORT  InitMemVect,InitZone,MaxApplZone,MaxBlock,MaxMem,MoreMasters
            EXPORT  MoveHHi,NewEmptyHandle,NewPtr,NwHandle,PtrZone,PurgeMem
            EXPORT  PurgeSpace,ReAllocHandle,RecoverHandle,ResrvMem,SetApplBase,SetApplLimit
            EXPORT  SetGrowZone,SetHandleSize,SetPtrSize,SetZone,StackSpace,StripAddress
            EXPORT  vIAZInit,vIAZPostInit

            IMPORT  ALIGN24TRAILER,ALIGN32TRAILER,FlushApplNM,INIT24ZONEALIGN,INIT32ZONEALIGN,SETAPPLBASEPATCH
            IMPORT  V24CMGUTSPATCH,v24HlockPatch,V24MAXAPPLPATCH,V24MAXMEMPATCH,V32CMGUTSPATCH,v32HlockPatch
            IMPORT  V32MAXAPPLPATCH,V32MAXMEMPATCH,AppZoneAddr,FlushApplVBLs,A24ACTUALS,A24HMAKEMOREMASTERS
            IMPORT  A24MAKEPTRSPC,A24MAXLIMIT,A24NEXTMASTER,A24SETSIZE,A24TOTEPURGEABLES,A24ZONEADJUSTEND
            IMPORT  A32ACTUALS,A32ALLOCBK,A32GETSIZE,A32HMAKEMOREMASTERS,A32MAKEPTRSPC,A32MAXLIMIT
            IMPORT  A32NEXTMASTER,A32SETSIZE,A32TOTEPURGEABLES,A32ZONEADJUSTEND,ClearGZStuff,MMEpilogue
            IMPORT  MMHPrologue,MMMMPrologue,MMNoErrEpilogue,MMNoPrologue,MMPPrologue,MMPrologue
            IMPORT  MMRHPrologue,ReleaseMP,StdGZ,a24AllocBk,a24EH,a24FreeBk
            IMPORT  a24GetSize,a24MakeBkF,a24PurgeHeap,a32EH,a32FreeBk,a32MakeBkF
            IMPORT  a32PurgeHeap

            SECTION "MemoryMgr",CODE

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
            lea     (MMNoPrologue.w,PC),A0
            move.l  A0,($1EE0).w
            lea     (MMPPrologue.w,PC),A0
            move.l  A0,($1EE4).w
            lea     (MMPrologue.w,PC),A0
            move.l  A0,($1EE8).w
            lea     (MMHPrologue.w,PC),A0
            move.l  A0,($1EEC).w
            lea     (MMRHPrologue.w,PC),A0
            move.l  A0,vMMRHPrologue
            lea     (MMMMPrologue.w,PC),A0
            move.l  A0,vMMMMPrologue
            lea     (MMEpilogue.w,PC),A0
            move.l  A0,vMMEpilogue
            lea     (MMNoErrEpilogue.w,PC),A0
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
            lea     (StdGZ.w,PC),A1
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
            lea     (StdGZ.w,PC),A1
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

            EVEN
