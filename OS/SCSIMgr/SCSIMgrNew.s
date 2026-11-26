            include "Include/ROMHeader.s"

            EXPORT  SCSIDT,TIMETASK

            SECTION "SCSIMgrNew",CODE

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

            EVEN
