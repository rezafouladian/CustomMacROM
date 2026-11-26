            include "Include/ROMHeader.s"

            EXPORT  AddDrive,Close,Control,DrvrInstall,DrvrRemove,FSIODneTbl
            EXPORT  KillIO,Open,OPENPATCHRTN,OPENPATCHRTN1,Read,Status
            EXPORT  vGoDriver,vSyncWait,vWaitUntil,Write,WriteUpdateReturn

            IMPORT  FileClose,FileOpen,FileRead,OPENPATCH,QStuff,READUPDATE
            IMPORT  WRITEUPDATE

            SECTION "DeviceMgr",CODE

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
            jmp     (FileOpen.w,PC)
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
            jmp     (FileClose.w,PC)
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
            jmp     (FileRead.w,PC)
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

            EVEN
