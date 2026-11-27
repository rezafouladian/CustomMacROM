            include "Include/ROMHeader.s"

            EXPORT  CmdDone,DoEject,Eject_2,FileAlloc,FileClose,FileCreate
            EXPORT  FileDelete,FileOpen,FileRead,FileWrite,FInitQueue,FlushFile
            EXPORT  FlushVol,FSQueueSync,GetEOF,GetFileInfo,GetFPos,GetVol
            EXPORT  GetVolInfo,InitFS,MountVol,Offline,OpenRF,ReName
            EXPORT  RstFilLock,SetEOF,SetFileInfo,SetFilLock,SetFilType,SetFPos
            EXPORT  SetVol,TurboFS,UnmountVol,vAdjEOF,vBMChk,vCheckRemount
            EXPORT  vCkExtFS,vDtrmV1,vDtrmV2,vDtrmV3,vFClose,vFileClose
            EXPORT  vFileOpen,vFileRead,vFileWrite,vFindDrive,vFlushMDB,vFndFilName
            EXPORT  VLG2PHYS,VMTCHECK,vPermssnChk,vRfNCall,vTstMod,DivUp
            EXPORT  MarkVCB,RoundAlloc,FlushMDB,MarkVCBTime,FindDrive,Lg2Phys
            EXPORT  TFSVCBTst

            IMPORT  AllocFakeRgns,CMDDONEPATCH,DequeueTrap,DSHOOKPATCH,PMSPSwOS,QStuff
            IMPORT  WDCBSwOS,BLKCHK,UpdateFree,DeAllocFile,ExtendFile,FXMKeyCmp
            IMPORT  MapFBlock,TruncateFile,CMDeleteCN,CMGetCN,CMGetOff,CMMoveCN
            IMPORT  CMRenameCN,CMSvcs,CMUpdateCN,CMKEYCMP,BTFlush,BTGetRecord
            IMPORT  BTOPEN,BTSEARCH,BTSvcs,CacheRdIP,CacheWrIP,FlushCache
            IMPORT  GetBlock,InitCache,MarkA5Block,MarkBlock,RelBlock,TrashBlocks
            IMPORT  TrashFBlocks,TrashVBlks

            SECTION "TFS",CODE

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
            jsr     (InitCache.w,PC)
            bne.b   FSInitErr
            move.l  A1,($378).w
            moveq   #1,D0
            cmpi.w  #2,MemTop
            ble.b   .L3
            moveq   #2,D0
.L3:
            jsr     (InitCache.w,PC)
            bne.b   FSInitErr
            move.l  A1,($37C).w
            moveq   #4,D0
            cmpi.w  #2,MemTop
            ble.b   .L4
            moveq   #$10,D0
.L4:
            jsr     (InitCache.w,PC)
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
            jsr     (GetBlock.w,PC)
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
            jsr     (RelBlock.w,PC)
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
            jsr     (GetBlock.w,PC)
            bne.w   vCheckRemount.L20
            movea.l A0,A5
            moveq   #2,D1
            jsr     (RelBlock.w,PC)
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
            lea     (FXMKeyCmp.w,PC),A3
            bsr.w   AccessBT
            bne.w   vCheckRemount.L17
            move.w  ($A6,A2),D0
            moveq   #4,D1
            move.l  ($6C,A2),D2
            movea.l ($A8,A2),A1
            lea     (CMKEYCMP.w,PC),A3
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMRenameCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (BTGetRecord.w,PC)
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
            jsr     (BTSEARCH.w,PC)
            addq.w  #8,A6
            moveq   #0,D1
.L17:
            subq.l  #1,D5
            blt.w   vCheckRemount.L17
            move.w  ($A4,A2),D0
            jsr     (BTGetRecord.w,PC)
            bne.b   .L18
            movea.l A1,A0
            bsr.b   sub_4080FB84
            moveq   #1,D1
            bra.b   .L17
.L18:
            cmpi.w  #$20,D0
            bne.w   vCheckRemount.L17
            jsr     (UpdateFree.w,PC)
            bra.w   sub_4080F65E.L8
sub_4080FB84:
            move.l  ($7C0).w,-(SP)
            rts
vBMChk:
            move.l  (SP)+,-(A6)
            bsr.w   CVFlgs
            bne.b   .L1
            jsr     (BLKCHK.w,PC)
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
            jsr     (TrashVBlks.w,PC)
            movea.l ($37C).w,A1
            jsr     (TrashVBlks.w,PC)
            movea.l ($380).w,A1
            jsr     (TrashVBlks.w,PC)
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
            jsr     (BTOPEN.w,PC)
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
            jsr     (FlushCache.w,PC)
            movea.l ($380).w,A1
            move.w  ($4E,A2),D0
            jsr     (FlushCache.w,PC)
            movea.l ($37C).w,A1
            move.w  ($4E,A2),D0
            jsr     (FlushCache.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (RelBlock.w,PC)
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
            jsr     (MarkA5Block.w,PC)
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
            jsr     (MarkA5Block.w,PC)
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
            jsr     (MarkA5Block.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMSvcs.w,PC)
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
            jmp     (FlushCache.w,PC)
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
            jsr     (MarkA5Block.w,PC)
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
            jsr     (TrashFBlocks.w,PC)
            move.l  D6,D0
            jsr     (DeAllocFile.w,PC)
            bne.b   .L6
.L4:
            move.l  D6,D0
            jsr     (CMDeleteCN.w,PC)
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
            jsr     (CMRenameCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMRenameCN.w,PC)
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
            jsr     (CMMoveCN.w,PC)
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
            jsr     (TrashFBlocks.w,PC)
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
            jsr     (MarkBlock.w,PC)
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
            jsr     (CMUpdateCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMGetOff.w,PC)
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
            jsr     (CMGetOff.w,PC)
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
            jsr     (MarkBlock.w,PC)
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
            jsr     (FlushCache.w,PC)
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
            jsr     (CacheRdIP.w,PC)
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
            jsr     (GetBlock.w,PC)
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
            jsr     (MarkA5Block.w,PC)
.L6:
            move.l  D7,D4
            beq.b   .L7
            andi.w  #$FE00,D4
            tst.l   D4
            beq.b   .L5
            jsr     (CacheWrIP.w,PC)
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
            jsr     (BTSvcs.w,PC)
            bra.b   .L2
.L1:
            jsr     (BTFlush.w,PC)
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
            jsr     (TruncateFile.w,PC)
            bne.w   .L8
            bclr    #7,(4,A1,D1.w)
.L4:
            move.l  A1,-(A6)
            move.l  ($3A,A1,D1.w),D0
            lea     ($3E,A1,D1.w),A0
            moveq   #0,D2
            jsr     (CMGetCN.w,PC)
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
            jsr     (CMUpdateCN.w,PC)
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
            jsr     (GetBlock.w,PC)
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
            jsr     (RelBlock.w,PC)
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
            jsr     (FlushCache.w,PC)
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
            jsr     (MarkA5Block.w,PC)
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
            jsr     (TruncateFile.w,PC)
            bne.b   .L4
.L6:
            movem.l D0-D2,-(A6)
            move.w  D1,D0
            move.l  ($C,A1,D1.w),D1
            moveq   #-1,D2
            jsr     (TrashBlocks.w,PC)
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
            jsr     (ExtendFile.w,PC)
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
            jmp     (MapFBlock.w,PC)
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

            EVEN
