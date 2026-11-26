            include "Include/ROMHeader.s"

            EXPORT  AttachVBL,BadTrap,CacheFlush,CacheTrap,ClearASCInt,ClearSCSIInt
            EXPORT  DebugUtil,DequeueTrap,DisableASCInts,DisableIntSources,DoVBLTask,DTCore
            EXPORT  EMT1010,Enable60HzInts,EnableASCInts,EnableParityInts,EnableSlotInts,EnableSWIMIOPInts
            EXPORT  GetTrapAddress,GOTSLOTHANDLER,InitDispatcher,InitIntHandler,InitQueue,INITSCSIDONE
            EXPORT  InitSCSIMgr,InitVBLQs,INTHANDLERNOVIA2,PollDone,PowerOff,PowerOffCont
            EXPORT  QStuff,RunDone,RunKBD,SCCIOPBYPASSINT,SCSIBoots,SCSIExitCleanup
            EXPORT  SCSIINTHNDRESUME,SCSIMgr,SCSISetFlags,SetTrapAddress,SlotVInstall,SlotVRemove
            EXPORT  VBLCore,vCacheFlush,vDisptch,VRemove

            IMPORT  CACHEVECTORPATCH,clock,CmdDone,DEBUGENTERCONT,DEBUGEXITCONT,DEBUGPWRMGRADBPATCH1
            IMPORT  DEBUGUTILRUNKBDPATCH,DISPATCHPATCH,FSQueueSync,INITSCSIMGRPATCH1,INITSCSIMGRPATCH2,INITSLOTINTSPATCH
            IMPORT  INSTALLSCSIINTHND96,IOPINTERRUPT,OSSSLOTINT,PMGRPOWEROFFPATCH,POWEROFFPATCH,RBVSLOTINT
            IMPORT  SCSIDOCOMPLETEPATCH,SCSIGETPATCH,SCSIMISCPATCH,SCSISETFLAGSPATCH,SlotInt,SysErr1

            SECTION "Part3",CODE

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
            jmp     (CmdDone.w,PC)
GetCSize:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetCSize:
            jsr     (FSQueueSync.w,PC)
            move.l  ($1C,A0),D0                     ; ioMisc
            moveq   #15,D1
            lsr.l   D1,D0
            move.b  D0,($20A).w                     ; CacheConfig
            moveq   #0,D0
            bra.b   CTExit
GetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($20,A1),($1C,A0)               ; CacheMinZn -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($1C,A0),($20,A1)               ; ioMisc -> CacheMinZn
            moveq   #0,D0
            bra.b   CTExit
GetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($12,A1),($1C,A0)               ; CacheByteLim -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
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
            jsr     (FSQueueSync.w,PC)
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
            jsr     (FSQueueSync.w,PC)
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
            lea     (clock.w,PC),A0
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

            EVEN
