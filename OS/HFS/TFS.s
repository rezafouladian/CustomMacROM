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

            include "OS/HFS/TFSCommon.s" ; Common subroutines w. TFSUtil
            include "OS/HFS/TFSVol.s"    ; TFS volume level routines
            include "OS/HFS/MFSVol.s"    ; MFS-specific volume level stuff
            include "OS/HFS/TFSDir1.s"   ; routines using filenames
            include "OS/HFS/MFSDir1.s"   ; MFS routines using filenames
            include "OS/HFS/TFSDir2.s"   ; routines using filenames
            include "OS/HFS/MFSDir2.s"   ; MFS routines using filenames
            include "OS/HFS/TFSDir3.s"   ; routines using filenames
            include "OS/HFS/MFSDir3.s"   ; MFS routines using filenames
            include "OS/HFS/TFSRfN1.s"   ; routines using refnums
            include "OS/HFS/MFSRfN1.s"   ; MFS routines using refnums
            include "OS/HFS/TFSRfN2.s"   ; routines using refnums
            include "OS/HFS/MFSRfN2.s"   ; MFS routines using refnums
            include "OS/HFS/TFSRfN3.s"   ; routines using refnums
            include "OS/HFS/MFSRfN3.s"   ; MFS routines using refnums

            EVEN
