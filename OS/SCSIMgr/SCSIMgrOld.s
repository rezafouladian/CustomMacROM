            include "Include/ROMHeader.s"

            EXPORT  SCSIExitCleanup,SCSIMgr

            IMPORT  DMAPENDINGPATCH,SCSIDOCOMPLETEPATCH,SCSIGETPATCH

            SECTION "SCSIMgrOld",CODE

SCSIOld:
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

            EVEN
