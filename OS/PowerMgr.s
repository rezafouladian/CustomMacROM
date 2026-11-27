            include "Include/ROMHeader.s"

            EXPORT  GoToSleep,PmgrOp,POWERDISPATCH,PowerMngr

            IMPORT  GETREALPROC,InitQueue,InitSCSI,RSetKMap

            SECTION "PowerMgr",CODE

PowerMngr:
InitPmgrVars:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            bne.b   .DoPMgrInit
            lea     .Traps,A1
            move.w  (A1)+,D0
            _GetToolBoxTrapAddress
.TrapLoop:
            move.w  (A1)+,D0
            beq.b   .exit
            _SetOSTrapAddress
            bra.b   .TrapLoop
.exit:
            rts
.Traps:
            dc.w    $A89F,$A085,$A09F,$A08A,0
.DoPMgrInit:
            move.l  #$106,D0
            _NewPtrSysClear
            move.l  A0,PmgrBase
            movea.l A0,A3
            lea     (2,A3),A1
            bsr.l   InitQueue
            st      ($11,A3)
            moveq   #1,D0
            move.l  D0,($1A,A3)
            move.l  D0,($1E,A3)
            move.w  #$14,($F6,A3)
            lea     ($24,A3),A0
            move.w  #8,(4,A0)
            moveq   #-1,D2
            move.l  D2,($14,A0)
            moveq   #0,D2
            move.w  D2,($E,A0)
            lea     BatInt,A1
            move.l  A1,($64,A3)
            lea     EnvInt,A1
            move.l  A1,($68,A3)
            lea     ($90,A3),A0
            move.w  #1,(4,A0)
            move.w  #$258,($A,A0)
            lea     SndWatch,A1
            move.l  A1,(6,A0)
            _VInstall
            lea     ($82,A3),A0
            move.w  #1,(4,A0)
            move.w  #$3C,($A,A0)
            lea     BatWatch,A1
            move.l  A1,(6,A0)
            _VInstall
            lea     PmgrInt,A0
            move.l  A0,($1A2).w
            lea     (-$10,SP),SP
            lea     ($C,SP),A0
            move.l  A0,(8,SP)
            move.l  A0,(4,SP)
            clr.l   (A0)
            clr.w   (2,SP)
            move.w  #$21,(SP)
            movea.l SP,A0
            _PMgrOp
            move.w  #2,(2,A0)
            move.w  #$4202,($C,A0)
            move.w  #$3A,(A0)
            _PMgrOp
            move.w  ($C,A0),($22,A3)
            lea     ($10,SP),SP
            move.l  #$60070,D0
            _ReadXPRam
            move.b  (5,A0),($53,A3)
            move.b  ($53,A3),NTSC
            bclr    #7,NTSC
            tst.b   (A0)
            beq.b   .L5
            tst.b   (1,A0)
            bne.b   .L6
.L5:
            move.b  #$20,(A0)
            move.b  #$10,(1,A0)
            move.l  #$20070,D0
            _WriteXPRam
.L6:
            move.b  (A0),(A3)
            move.b  (1,A0),(1,A3)
            movea.l UnivInfoPtr,A0
            movea.l A0,A1
            adda.l  (A0),A0
            movea.l ($58,A0),A0
            adda.l  #$20000,A0
            move.l  A0,($9E,A3)
            adda.l  (8,A1),A1
            move.l  (A1),($A2,A3)
            lea     WakeUp,A2
            move.l  A2,($12,A3)
            move.l  A3,D0
            _StripAddress
            movea.l D0,A0
            bsr.l   GETREALPROC
            move.l  A0,($A6,A3)
            move.w  #$78,($AC,A3)
            move.w  #3,($AA,A3)
            move.w  #$A,($AE,A3)
            move.w  #$384,($B0,A3)
            move.w  #$A,($E2,A3)
            move.w  #$600,($E4,A3)
            move.w  #7,D0
            _PowerDispatch
            move.b  D0,($E,A3)
            cmpi.b  #4,MMUType
            bne.b   .L7
            lea     PowerCycle030,A2
            move.l  A2,($E6,A3)
            lea     Restore030,A2
            move.l  A2,($EA,A3)
            bra.b   .L8
.L7:
            lea     PowerCycle020,A2
            move.l  A2,($E6,A3)
            lea     Restore020,A2
            move.l  A2,($EA,A3)
.L8:
            lea     ModemSndOnInt,A1
            move.l  A1,($102,A3)
            movea.l VIA,A1
            move.b  #$90,($1A00,A1)
            move.b  #$90,($1C00,A1)
            rts
PMGRrecv:
            moveq   #0,D1
PMGRsend:
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            movea.l SP,A0
            _PMgrOp
            move.w  (2,SP),D1
            lea     (8,SP),SP
            movea.l (SP)+,A0
            rts
PmgrInt:
            move.b  #$90,($1A00,A1)
            suba.w  #$C,SP
            movea.l SP,A0
            addq.l  #2,A0
            moveq   #$78,D0
            bsr.b   PMGRrecv
            tst.w   D0
            bne.b   .L4
            move.b  (A0),D0
            lsr.b   #4,D0
            btst    #0,D0
            bne.b   .L2
            btst    #1,D0
            bne.b   .L1
            btst    #2,D0
            beq.b   .L4
            movea.l PmgrBase,A2
            move.l  ($68,A2),D0
            bra.b   .L3
.L1:
            movea.l PmgrBase,A2
            move.l  ($64,A2),D0
            bra.b   .L3
.L2:
            andi.b  #$F,(A0)
            move.b  (1,A0),-(A0)
            subq.b  #2,D1
            move.b  D1,(2,A0)
            move.l  ($19A).w,D0
.L3:
            beq.b   .L4
            movea.l D0,A1
            jsr     (A1)
.L4:
            lea     ($C,SP),SP
            rts
EnvInt:
            rts
BatInt:
            moveq   #0,D2
            move.b  (1,A0),D2
            move.b  D2,($F,A2)
            btst    #2,D2
            beq.b   .Done
            bsr.w   RemoveMsg
.BatIntCont:                                ; re-entry point used by PowerMgrPatches.a NewBatInt
            bset    #3,($54,A2)
            lea     ($EE,A2),A1
            bset    #4,($54,A2)
            beq.b   .L1
            addq.l  #4,A1
            bclr    #4,($54,A2)
.L1:
            tst.l   (A1)
            beq.b   .Done
            lea     ($24,A2),A0
            move.l  (A1),($18,A0)
            lea     .BatResp,A1
            move.l  A1,($1C,A0)
            move.l  ($6E,A2),($10,A0)
            _NMInstall
            subq.l  #4,SP
            movea.l SP,A0
            move.b  #$E0,D0
            moveq   #3,D1
            move.w  #$21,(A0)
            andi.l  #$FFFFFFFA,D2
            move.b  D2,(2,A0)
            bsr.w   PMGRsend
            addq.l  #4,SP
.Done:
            rts
.BatResp:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _NMRemove
            movea.l PmgrBase,A0
            bclr    #3,($54,A0)
            jmp     (A1)
BatWatch:
            movea.l PmgrBase,A2
            tst.b   ($C,A2)
            bne.b   .didsystask
            lea     ($82,A2),A0
            move.w  #$3C,($A,A0)
            rts
.didsystask:
            bsr.w   GetLevel
            bne.b   .valid
            move.b  #$FF,($D,A2)
            bra.b   .BatWatchOut
.valid:
            tst.b   D0
            bpl.b   .positive
            bsr.b   RemoveMsg
            move.b  D0,($D,A2)
            bra.b   .BatWatchOut
.positive:
            beq.b   .lesser
            tst.b   ($D,A2)
            bmi.b   .newmsg
            cmp.b   ($D,A2),D0
            bls.b   .lesser
.newmsg:
            bsr.b   RemoveMsg
            bsr.b   InstallMsg
            clr.b   ($6D,A2)
            move.b  D0,($D,A2)
            bra.b   .BatWatchOut
.lesser:
            cmpi.b  #4,($D,A2)
            bne.b   .BatWatchOut
            addq.b  #1,($6D,A2)
.BatWatchOut:
            lea     ($82,A2),A0
            move.w  #$3C,($A,A0)
            tst.b   ($11,A2)
            beq.b   .exit
            clr.b   ($11,A2)
            lea     Scratch20,A0
            move.l  #$60070,D0
            _ReadXPRam
            move.b  (2,A0),($10,A2)
            move.w  (A0),(A2)
            _IdleUpdate
            move.l  ($1E,A2),D0
            beq.b   .exit
            addq.l  #1,D0
            beq.b   .exit
            move.l  Ticks,($1E,A2)
.exit:
            rts
RemoveMsg:
            tst.b   ($50,A2)
            beq.b   .L1
            btst    #3,($54,A2)
            bne.b   .L1
            move.l  D0,-(SP)
            lea     ($24,A2),A0
            _NMRemove
            move.l  (SP)+,D0
            clr.b   ($50,A2)
.L1:
            rts
InstallMsg:
            btst    #3,($54,A2)
            bne.b   .L2
            move.l  D0,-(SP)
            lea     ($24,A2),A0
            lea     .L2,A1
            move.l  A1,($1C,A0)
            move.l  ($6E,A2),($10,A0)
            move.w  D0,D2
            subq.w  #1,D2
            lsl.w   #2,D2
            move.l  ($72,A2,D2.w),($18,A0)
            tst.l   ($18,A0)
            beq.b   .L1
            _NMInstall
            st      ($50,A2)
.L1:
            move.l  (SP)+,D0
.L2:
            rts
GetLevel:
            subq.w  #4,SP
            movea.l SP,A0
            moveq   #$69,D0
            bsr.w   PMGRrecv
            moveq   #0,D3
            move.b  (A0)+,($F,A2)
            move.b  (A0),D3
            addq.w  #4,SP
            btst    #5,($F,A2)
            beq.b   .ChargeSame
            st      ($11,A2)
.ChargeSame:
            subq.b  #1,($5F,A2)
            bpl.b   .IndexOK
            move.b  #7,($5F,A2)
.IndexOK:
            moveq   #0,D0
            move.b  ($5F,A2),D0
            move.b  D3,($48,A2,D0.w)
            tst.b   ($48,A2)
            beq.b   GetLevel
            moveq   #0,D3
            move.b  ($48,A2),D0
            add.w   D0,D3
            move.b  ($49,A2),D0
            add.w   D0,D3
            move.b  ($4A,A2),D0
            add.w   D0,D3
            move.b  ($4B,A2),D0
            add.w   D0,D3
            move.b  ($4C,A2),D0
            add.w   D0,D3
            move.b  ($4D,A2),D0
            add.w   D0,D3
            move.b  ($4E,A2),D0
            add.w   D0,D3
            move.b  ($4F,A2),D0
            add.w   D0,D3
            lsr.w   #1,D3
            moveq   #0,D2
            move.b  ($22,A2),D2
            moveq   #0,D1
            move.b  ($23,A2),D1
            sub.w   D1,D2
            asl.w   #2,D1
            moveq   #4,D0
            add.w   D2,D1
            cmp.w   D1,D3
            bls.b   .foundlevel
            moveq   #3,D0
            add.w   D2,D1
            cmp.w   D1,D3
            bls.b   .foundlevel
            moveq   #2,D0
            add.w   D2,D1
            cmp.w   D1,D3
            bls.b   .foundlevel
            moveq   #1,D0
            add.w   D2,D1
            cmp.w   D1,D3
            bls.b   .foundlevel
            moveq   #0,D0
            move.w  ($F6,A2),D2
            asl.w   #2,D2
            add.w   D2,D1
            cmp.w   D1,D3
            bls.b   .foundlevel
            moveq   #-1,D0
.foundlevel:
            lsr.w   #2,D3
            move.b  D3,($52,A2)
            tst.b   ($48,A2)
            rts
SndWatch:
            movea.l PmgrBase,A2
            lea     ($90,A2),A0
            move.w  #$258,($A,A0)
            subq.w  #4,SP
            movea.l SP,A0
            move.w  #$98,D0
            bsr.w   PMGRrecv
            move.b  (A0),D2
            beq.b   .noSound
            btst    #1,D2
            bne.b   .Clearlatch
            clr.b   (A0)
            moveq   #1,D1
            move.w  #$90,D0
            bsr.w   PMGRsend
            bra.b   .noSound
.Clearlatch:
            move.b  #3,(A0)
            moveq   #1,D1
            move.w  #$90,D0
            bsr.w   PMGRsend
            _IdleUpdate
.noSound:
            addq.w  #4,SP
            rts
PwrDispatchVects:
            dc.w    PmgrTrap-PwrDispatchVects
            dc.w    IdleUpdate-PwrDispatchVects
            dc.w    IdleDelay-PwrDispatchVects
            dc.w    IdleMind-PwrDispatchVects
            dc.w    IdleRead-PwrDispatchVects
            dc.w    IdleEnable-PwrDispatchVects
            dc.w    IdleDisable-PwrDispatchVects
            dc.w    IdleDisable.L31-PwrDispatchVects
            ds.b    20
POWERDISPATCH:
            cmpi.w  #7,D0
            bhi.b   .L1
            move.w  PwrDispatchVects(PC,D0.w*2),D0
            jmp     PwrDispatchVects(PC,D0.w)
.L1:
            move.w  #$FFCE,D0
            rts
PmgrOp:
            andi.w  #$600,D1
            beq.w   PmgrTrap
            cmpi.w  #$400,D1
            beq.w   Restore020.L26
            bcs.b   IdleUpdate
            bra.w   IdleDisable.L38
IdleUpdate:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l PmgrBase,A1
            move.l  ($1A,A1),D0
            cmp.l   Ticks,D0
            bhi.b   .noLastActupdate
            move.l  Ticks,($1A,A1)
.noLastActupdate:
            move.l  ($1A,A1),D0
            move    (SP)+,SR
            rts
IdleDelay:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l PmgrBase,A1
            moveq   #0,D0
            move.w  ($B0,A1),D0
            add.l   Ticks,D0
            cmp.l   ($1A,A1),D0
            ble.b   .Done
            move.l  D0,($1A,A1)
.Done:
            move    (SP)+,SR
            rts
IdleMind:
            movem.l D0-D2/A0-A2,-(SP)
            movea.l PmgrBase,A2
            st      ($C,A2)
            cmpi.b  #4,($D,A2)
            bne.b   .L1
            cmpi.b  #$A,($6D,A2)
            bls.b   .L1
            moveq   #6,D0
            bra.w   .L7
.L1:
            tst.b   ($11,A2)
            bne.w   .L16
            move.l  ($1E,A2),D0
            beq.b   .L4
            btst    #0,($F,A2)
            beq.b   .L2
            btst    #1,($10,A2)
            bne.b   .L4
.L2:
            moveq   #0,D0
            move.b  (1,A2),D0
            bne.b   .L3
            move.b  #$10,D0
.L3:
            mulu.w  #$384,D0
            move.l  Ticks,D1
            sub.l   ($1E,A2),D1
            cmp.l   D0,D1
            bcs.b   .L4
            tst.l   ($16,A2)
            beq.b   .L4
            movea.l ($16,A2),A0
            jsr     (A0)
.L4:
            move.l  ($1A,A2),D0
            cmp.l   Ticks,D0
            bhi.w   .L16
            btst    #0,($F,A2)
            beq.b   .L5
            btst    #1,($10,A2)
            bne.b   .L8
.L5:
            moveq   #0,D0
            move.b  (A2),D0
            bne.b   .L6
            move.b  #$20,D0
.L6:
            mulu.w  #$384,D0
            add.l   ($1A,A2),D0
            cmp.l   Ticks,D0
            bcc.b   .L8
            tst.b   ($F8,A2)
            bgt.w   .L16
            moveq   #1,D0
.L7:
            _Sleep
            move.l  Ticks,D0
            move.l  D0,($1A,A2)
            bra.w   .L17
.L8:
            tst.b   MBState
            beq.b   .L9
            tst.b   ($5E,A2)
            beq.b   .L10
.L9:
            move.l  Ticks,($1A,A2)
            bra.w   .L17
.L10:
            btst    #0,($10,A2)
            bne.b   .L17
            tst.b   ($51,A2)
            bne.b   .L17
            move.l  Ticks,D0
            sub.l   ($1A,A2),D0
            bmi.b   .L17
            moveq   #0,D2
            move.w  ($AC,A2),D2
            cmp.l   D2,D0
            bcs.b   .L17
            move.w  ($AE,A2),D1
            move.l  ($1A,A2),D0
            cmp.l   ($B2,A2),D0
            bne.b   .L12
            move.w  ($B6,A2),D1
            add.w   ($E2,A2),D1
            cmp.w   ($E4,A2),D1
            bcc.b   .L11
            move.w  D1,($B6,A2)
            bra.b   .L13
.L11:
            move.w  ($E4,A2),D1
            bra.b   .L13
.L12:
            move.l  D0,($B2,A2)
            move.w  D1,($B6,A2)
.L13:
            bsr.w   SetSupervisorMode
            move.w  D0,($C8,A2)
            move.l  AutoInt7,($CA,A2)
.L14:
            move.l  ($1A,A2),-(SP)
            movea.l ($E6,A2),A0
            jsr     (A0)
            move.l  (SP)+,D0
            cmp.l   ($1A,A2),D0
            bne.b   .L15
            dbra    D1,.L14
.L15:
            move    ($C8,A2),SR
            move.l  ($CA,A2),AutoInt7
.L16:
            movem.l (SP)+,D0-D2/A0-A2
            rts
.L17:
            clr.l   ($B2,A2)
            bra.b   .L16
PowerCycle030:
            move.w  SR,-(SP)
            ori     #$700,SR
            movem.l D1-D7/A0-A6,-(SP)
            movec   CACR,D0
            ori.w   #$808,D0
            movec   CAAR,D1
            movec   VBR,A0
            move.l  USP,A1
            movec   MSP,A2
            movem.l D0-D1/A0-A2,-(SP)
            moveq   #0,D0
            movec   D0,VBR
            movea.l PmgrBase,A1
            movea.l ($9E,A1),A2
            move.l  ($EA,A1),ResetVector
            move.l  SP,($C4,A1)
            pmove.l TC,($CE,A1)
            pmove.d CRP,($D2,A1)
            pmove.l TT1,($DA,A1)
            pmove.l TT0,($DE,A1)
            movea.l ($A6,A1),A3
            lea     ($C2,A3),A3
            move.l  A3,ResetStackPtr
            move.l  ($EA,A1),AutoInt7
            movea.l SCCRd,A3
            btst    #0,(A3)
            bne.b   .DontCycle
            move.l  D0,([ROMBase.w])
            move.l  D0,(A2)
.L19:
            bra.b   .L19
.DontCycle:
            movec   A0,VBR
            move.l  ($CA,A1),AutoInt7
            adda.w  #$14,SP
            movem.l (SP)+,D1-D7/A0-A6
            move    (SP)+,SR
            rts
PowerCycle020:
            move.w  SR,-(SP)
            ori     #$700,SR
            movem.l A0-A6/D1-D7,-(SP)
            movec   CACR,D0
            ori.w   #$808,D0
            movec   CAAR,D1
            movec   VBR,A0
            move.l  USP,A1
            movec   MSP,A2
            movem.l D0-D1/A0-A2,-(SP)
            moveq   #0,D0
            movec   D0,VBR
            movea.l PmgrBase,A1
            movea.l ($9E,A1),A2
            move.l  ($EA,A1),ResetVector
            move.l  SP,ResetStackPtr
            move.l  ($EA,A1),AutoInt7
            movea.l SCCRd,A3
            btst    #0,(A3)
            bne.b   .DontCycle
            move.l  D0,([ROMBase.w])
            move.l  D0,(A2)
.L22:
            bra.b   .L22
.DontCycle:
            movec   A0,VBR
            move.l  ($CA,A1),AutoInt7
            adda.w  #$14,SP
            movem.l (SP)+,D1-D7/A0-A6
            move    (SP)+,SR
            rts
Restore030:
            mc68030
            ori     #$700,SR
            movea.l ResetSP,A0
            movea.l (2,A0),SP
            pmove.l ($1C,A0),TT0
            pmove.l ($18,A0),TT1
            pmove.d ($10,A0),CRP
            pmove.l ($C,A0),TC
            movem.l (SP)+,D0-D1/A0-A2
            movec   D0,CACR
            movec   D1,CAAR
            movec   A0,VBR
            movec   A1,USP
            movec   A2,MSP
            movea.l PmgrBase,A0
            move.l  ($CA,A0),AutoInt7
            movem.l (SP)+,D1-D7/A0-A6
            move    (SP)+,SR
            rts
Restore020:
            ori     #$700,SR
            movem.l (SP)+,D0-D1/A0-A2
            movec   D0,CACR
            movec   D1,CAAR
            movec   A0,VBR
            move.l  A1,USP
            movec   A2,MSP
            movea.l PmgrBase,A0
            move.l  ($CA,A0),AutoInt7
            movem.l (SP)+,D1-D7/A0-A6
            move    (SP)+,SR
            rts
.L26:
            tst.l   D0
            bmi.b   IdleRead
            beq.b   IdleEnable
            bra.b   IdleDisable
IdleRead:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l PmgrBase,A0
            moveq   #0,D0
            move.b  ($E,A0),D0
            move    (SP)+,SR
            rts
IdleEnable:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D0
            movea.l PmgrBase,A0
            subq.b  #1,($51,A0)
            bpl.b   .DontClr
            clr.b   ($51,A0)
.DontClr:
            move.b  ($51,A0),D0
            move    (SP)+,SR
            rts
IdleDisable:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D0
            movea.l PmgrBase,A0
            addq.b  #1,($51,A0)
            move.b  ($51,A0),D0
            move    (SP)+,SR
            rts
.L31:
            btst    #6,($DD1).w                     ; TestFor JAWSExists
            beq.b   .L37
            movea.l UnivInfoPtr,A0
            adda.l  (A0),A0
            movea.l ($58,A0),A0
            movea.l A0,A1
            adda.l  #$34000,A0
            adda.w  #$4000,A1
            btst    #0,(A0)
            beq.b   .L32
            move.w  #$19,D0
            swap    D0
            bra.b   .L34
.L32:
            move.w  #$19,D0
            swap    D0
            btst    #1,(A1)
            beq.b   .L33
            move.w  #8,D0
            bra.b   .L36
.L33:
            move.w  #$10,D0
            bra.b   .L36
.L34:
            btst    #1,(A1)
            beq.b   .L35
            move.w  #$10,D0
            bra.b   .L36
.L35:
            move.w  #$19,D0
.L36:
            rts
.L37:
            moveq   #0,D0
            rts
.L38:
            bclr    #7,D0
            bne.w   .L42
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$10,SP
            lea     ($C,SP),A0
            move.l  A0,(8,SP)
            move.l  A0,(4,SP)
            movea.l SP,A0
            bclr    #0,D0
            bne.w   .L41
            tst.b   D0
            beq.w   .L41
            move.w  #$58,(A0)
            clr.w   (2,A0)
            _PMgrOp
            move.b  ($C,A0),D1
            btst    #3,D1
            beq.w   .L41
            move.l  #$10072,D0
            _ReadXPRam
            btst    #2,(A0)
            bne.w   .L41
            bclr    #7,([VIA2.w],$400.w)
            andi.b  #7,D1
            bset    #0,D1
            move.b  D1,($C,A0)
            move.w  #1,(2,A0)
            move.w  #$50,(A0)
            _PMgrOp
            move.w  TimeDBRA,D0
            asl.w   #1,D0
.L39:
            dbra    D0,.L39
            move.b  #$88,($C,A0)
            move.w  #1,(2,A0)
            move.w  #$10,(A0)
            _PMgrOp
            move.w  TimeDBRA,D0
            asl.w   #3,D0
.L40:
            dbra    D0,.L40
            movea.l PmgrBase,A1
            move.l  ($102,A1),($19E).w
            move.b  #$88,([VIA.w],$1C00.w)
            bset    #7,([VIA2.w],$400.w)
            bclr    #7,([VIA2.w])
.L41:
            move.b  #$82,($C,A0)
            move.w  #1,(2,A0)
            move.w  #$10,(A0)
            _PMgrOp
            lea     ($10,SP),SP
            movem.l (SP)+,D0-D1/A0-A1
            rts
.L42:
            movem.l D0-D3/A0,-(SP)
            suba.w  #$10,SP
            lea     ($C,SP),A0
            move.l  A0,(8,SP)
            move.l  A0,(4,SP)
            movea.l SP,A0
            move.l  D0,D2
            bclr    #0,D2
            bne.w   .L45
            btst    #2,D2
            beq.b   .L45
            move.w  #$58,(A0)
            clr.w   (2,A0)
            _PMgrOp
            move.b  ($C,A0),D1
            andi.b  #7,D1
            btst    #0,D1
            beq.b   .L45
            move.b  #8,($C,A0)
            move.w  #1,(2,A0)
            move.w  #$10,(A0)
            _PMgrOp
            moveq   #0,D0
            move.w  TimeDBRA,D0
            asl.l   #1,D0
            asl.l   #8,D0
            move.l  D0,D3
            swap    D3
.L43:
            dbra    D0,.L43
            dbra    D3,.L43
            bclr    #0,D1
            move.b  D1,($C,A0)
            move.w  #$50,(A0)
            _PMgrOp
            move.w  TimeDBRA,D0
            asl.w   #3,D0
.L44:
            dbra    D0,.L44
            bclr    #7,([VIA2.w],$400.w)
            move.b  #8,([VIA.w],$1C00.w)
.L45:
            move.b  PortAUse,D0
            btst    #2,D2
            beq.b   .L46
            bsr.b   sub_40888E5A
.L46:
            cmpi.b  #$FF,D0
            bne.b   .L47
            move.b  #2,($C,A0)
            move.w  #1,(2,A0)
            move.w  #$10,(A0)
            _PMgrOp
.L47:
            lea     ($10,SP),SP
            movem.l (SP)+,D0-D3/A0
            rts
sub_40888E5A:
            movem.l D1/A0,-(SP)
            movea.l LAPMgrPtr,A0
            move.w  #$13,D0
            jsr     (2,A0)
            move.b  D1,D0
            movem.l (SP)+,D1/A0
            rts
ModemSndOnInt:
            move.b  #8,([VIA.w],$1A00.w)
            moveq   #1,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   ($20,A0)
            beq.b   .L1
            movea.l ($20,A0),A0
            jsr     (A0)
.L1:
            movea.l (SP)+,A0
            bclr    #6,([VIA.w],$1800.w)
            lea     ModemSndOffInt,A0
            move.l  A0,($19E).w
            rts
ModemSndOffInt:
            move.b  #8,([VIA.w],$1A00.w)
            moveq   #0,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   ($20,A0)
            beq.b   .L1
            movea.l ($20,A0),A0
            jsr     (A0)
.L1:
            movea.l (SP)+,A0
            bset    #6,([VIA.w],$1800.w)
            lea     ModemSndOnInt,A0
            move.l  A0,($19E).w
            rts
PmgrTrap:
            movem.l D1-D6/A0-A6,-(SP)
            move    SR,D5
            movea.l VIA,A1
            movea.l VIA2,A4
            lea     ($1E00,A1),A5
            move.b  ($1C00,A1),D1
            move.b  D1,-(SP)
            andi.b  #$10,D1
            move.b  #$10,($1C00,A1)
            subq.l  #2,SP
            movea.l PmgrBase,A2
            suba.w  #$30,SP
            movea.l SP,A3
            movea.l SCCRd,A6
            addq.l  #6,A6
            moveq   #7,D3
.L3:
            clr.b   ($600,A4)
            move.w  TimeVIADB,D2
.L4:
            btst    #1,(A4)
            dbne    D2,.L4
            bne.b   .L5
            move.l  #$FFFFCD38,D0
            bra.w   .L17
.L5:
            ori     #$700,SR
            move.b  ($600,A1),D6
            bclr    #7,($600,A1)
            lea     (1,A0),A2
            move.w  TimeVIADB,D2
            lsl.w   #3,D2
            bsr.w   sub_40889054
            beq.b   .L9
            move.l  A3,PollStack
            cmpa.l  PollStack,SP
            beq.b   .L7
            move.l  A3,D7
            movem.l D0-D6/A0-A4,(A3)
            move.l  PollProc,D2
            beq.b   .L6
            nop
            nop
            pea     .L6
            move.l  D2,-(SP)
            rts
.L6:
            movea.l D7,A3
            movem.l (A3),D0-D6/A0-A4
.L7:
            moveq   #$40,D2
            move.b  D6,($600,A1)
.L8:
            move    D5,SR
            dbra    D2,.L8
            dbra    D3,.L3
            bra.b   .L17
.L9:
            moveq   #0,D1
            lea     (3,A0),A2
            move.b  (A2),D1
            bsr.w   sub_40889050
            bne.b   .L17
            subq.w  #1,D1
            bmi.b   .L11
            movea.l (4,A0),A2
.L10:
            bsr.w   sub_40889050
            bne.b   .L17
            dbra    D1,.L10
.L11:
            move.b  (1,A0),D0
            btst    #3,D0
            beq.b   .L16
            movea.l A0,A2
            addq.l  #1,A2
            move.w  TimeVIADB,D2
.L12:
            btst    #1,(A4)
            beq.b   .L14
            move.b  (A5),(A5)
            bmi.b   .L13
            nop
            move.b  (A6),-(SP)
.L13:
            dbra    D2,.L12
            move.l  #$FFFFCD37,D0
            bra.b   .L17
.L14:
            clr.l   (A0)
            bsr.w   sub_408890AC
            bne.b   .L17
            addq.l  #1,A2
            bsr.w   sub_408890AC
            bne.b   .L17
            move.w  (2,A0),D1
            movea.l (8,A0),A2
            subq.w  #1,D1
            bmi.b   .L16
.L15:
            bsr.w   sub_408890AC
            bne.b   .L17
            dbra    D1,.L15
.L16:
            moveq   #0,D0
.L17:
            clr.b   ($600,A4)
            move.l  D0,D4
            move.l  A3,PollStack
            cmpa.l  PollStack,SP
            beq.b   .L18
            move.l  PollProc,D2
            beq.b   .L18
            nop
            nop
            pea     .L18
            move.l  D2,-(SP)
            rts
.L18:
            movea.l PollStack,SP
            adda.w  #$30,SP
            move.l  D4,D0
            movea.l VIA,A1
            move.b  D6,($600,A1)
            movea.l PmgrBase,A2
            cmpa.w  #$FFFF,A2
            nop
            addq.l  #2,SP
            move.b  (SP)+,D4
            move.b  D4,($1C00,A1)
            move    D5,SR
            movem.l (SP)+,D1-D6/A0-A6
            tst.w   D0
            rts
sub_40889050:
            move.w  #$400,D2
sub_40889054:
            moveq   #0,D0
            move.l  (SP)+,D4
            move.b  #$FF,($600,A4)
            move.b  (A2)+,($200,A4)
            bclr    #2,(A4)
.L1:
            btst    #1,(A4)
            beq.b   .L3
            move.b  (A5),(A5)
            bmi.b   .L2
            nop
            move.b  (A6),-(SP)
.L2:
            dbra    D2,.L1
            move.l  #$FFFFCD36,D0
            bra.b   .L6
.L3:
            moveq   #$40,D2
            bset    #2,(A4)
.L4:
            btst    #1,(A4)
            bne.b   .L6
            move.b  (A5),(A5)
            bmi.b   .L5
            nop
            move.b  (A6),-(SP)
.L5:
            dbra    D2,.L4
            move.l  #$FFFFCD35,D0
.L6:
            bset    #2,(A4)
            clr.b   ($600,A4)
            move.l  D4,-(SP)
            tst.l   D0
            rts
sub_408890AC:
            moveq   #0,D0
            move.l  (SP)+,D4
            clr.b   ($600,A4)
            moveq   #$40,D2
.L1:
            btst    #1,(A4)
            beq.b   .L3
            move.b  (A5),(A5)
            bmi.b   .L2
            nop
            move.b  (A6),-(SP)
.L2:
            dbra    D2,.L1
            move.l  #$FFFFCD34,D0
            bra.b   sub_40889054.L6
.L3:
            moveq   #$40,D2
            bclr    #2,(A4)
            move.b  ($200,A4),(A2)+
.L4:
            btst    #1,(A4)
            bne.b   sub_40889054.L6
            move.b  (A5),(A5)
            bmi.b   .L5
            nop
            move.b  (A6),-(SP)
.L5:
            dbra    D2,.L4
            move.l  #$FFFFCD33,D0
            bra.b   sub_40889054.L6
GoToSleep:
            btst    #9,D1
            bne.w   SlpQInstall
            btst    #$A,D1
            bne.w   SlpQRemove
            movea.l PmgrBase,A0
            move.l  D0,D1
            bsr.w   SetSupervisorMode
            move.w  D0,($C8,A0)
            move.l  D1,D0
            bsr.b   DreamAway
            move    ($C8,A0),SR
            rts
DreamAway:
            movem.l D1-D7/A0-A6,-(SP)
            move.l  D0,D2
            bset    #0,($54,A0)
            bne.b   .exitsleep
            cmpi.b  #1,D0
            beq.b   .validselector
            cmpi.b  #2,D0
            beq.b   .validselector
            cmpi.b  #6,D0
            bne.b   .abortsleep
.validselector:
            move    ($C8,A0),SR
            bclr    #1,($54,A0)
            bne.b   .traverse
            move.l  ($60,A0),D1
            beq.b   .closeAT
            movea.l D1,A1
            jsr     (A1)
            bne.b   .abortsleep
            bra.b   .traverse
.closeAT:
            bsr.w   CheckAppleTalk
            bne.b   .abortsleep
.traverse:
            move.w  D2,D0
            cmpi.w  #6,D0
            bne.b   .doQ
            moveq   #2,D0
.doQ:
            bsr.w   DoQueueStack
            move.l  D0,D1
            bsr.w   SetSupervisorMode
            tst.l   D1
            bne.w   .abortsleep
            bsr.w   CloseAppleTalk
            bclr    #0,($54,A0)
            bra.b   didqueue
.abortsleep:
            bsr.w   SetSupervisorMode
            bclr    #0,($54,A0)
.exitsleep:
            move.w  D2,D0
            movem.l (SP)+,D1-D7/A0-A6
            rts
didqueue:
            subq.l  #4,SP
            move.w  #4,-(SP)
            _GetCursor
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  A0,-(SP)
            _SetCursor
            movea.l PmgrBase,A1
            btst    #2,($54,A1)
            beq.b   .L8
            tst.l   ($16,A1)
            beq.b   .L8
            movea.l ($16,A1),A0
            jsr     (A0)
.L8:
            tst.l   ($FA,A1)
            beq.b   .L9
            movea.l ($FA,A1),A0
            jsr     (A0)
.L9:
            ori     #$700,SR
            lea     (-4,SP),SP
.L10:
            movea.l SP,A0
            moveq   #$58,D0
            bsr.w   PMGRrecv
            move.b  (A0),D0
            btst    #2,D0
            beq.b   .L11
            btst    #4,D0
            bne.b   .L10
.L11:
            addq.w  #4,SP
            movea.l VIA,A0
            move.b  (vBufB,A0),D0
            move.b  (vDIRB,A0),D1
            move.b  (vBufA,A0),D2
            move.b  (vDIRA,A0),D3
            move.b  (vIER,A0),D4
            move.b  (vACR,A0),D5
            move.b  (vPCR,A0),D6
            movem.w D0-D6,-(SP)
            movea.l ASCBase,A1
            move.b  (ascMode,A1),-(SP)
            move.b  (ascVolControl,A1),-(SP)
            move.b  (ascPlayRecA,A1),-(SP)
            move.b  (ascTestReg,A1),-(SP)
            moveq   #0,D1
.L12:
            lea     ($F0A,A1),A0
            adda.l  D1,A0
            moveq   #9,D0
.L13:
            move.b  -(A0),-(SP)
            dbra    D0,.L13
            lea     ($F18,A1),A0
            adda.l  D1,A0
            moveq   #7,D0
.L14:
            move.b  -(A0),-(SP)
            dbra    D0,.L14
            tst.l   D1
            bne.b   .L15
            moveq   #$20,D1
            bra.b   .L12
.L15:
            movea.l VIA2,A0
            move.b  (vBufB,A0),D0
            move.b  (vDIRB,A0),D1
            move.b  (vBufA,A0),D2
            move.b  (vDIRA,A0),D3
            move.b  (vIER,A0),D4
            move.b  (vACR,A0),D5
            move.b  (vPCR,A0),D6
            movem.w D0-D6,-(SP)
            bclr    #6,(A0)
            move.l  USP,A0
            movec   MSP,A1
            movem.l A0-A1,-(SP)
            movec   VBR,A0
            move.l  A0,-(SP)
            movec   CACR,D0
            ori.w   #$808,D0
            movec   CAAR,D1
            movem.l D0-D1,-(SP)
            moveq   #0,D0
            movec   D0,VBR
            movea.l PmgrBase,A2
            move.w  D0,($C2,A2)
            move.l  SP,($C4,A2)
            subq.w  #4,SP
            movea.l SP,A0
            move.l  #'MATT',(A0)
            moveq   #4,D1
            moveq   #$7F,D0
            bsr.w   PMGRsend
            addq.w  #4,SP
            movea.l ($A6,A2),A3
            cmpi.b  #4,MMUType
            bne.b   .L16
            pmove.l TC,($CE,A2)
            pmove.d CRP,($D2,A2)
            pmove.l TT1,($DA,A2)
            pmove.l TT0,($DE,A2)
            move.w  #$FFFF,($C2,A2)
            lea     .L18,A0
            pmove.l (A0),TC
.L16:
            movea.l ($A2,A3),A4
            move.l  A3,(-$38,A4)
            move.l  ($12,A3),(-$34,A4)
            move.l  #'SARA',(-$30,A4)
.L17:
            bra.b   .L17
.L18:
            dc.w    0
WakeUp:
            ori     #$700,SR
            move.l  #'WLSC',(-$30,A1)
            movea.l (-$38,A1),A0
            move.w  ($C2,A0),D0
            beq.b   .L1
            movea.l ($C4,A0),SP
            pmove.l ($DE,A0),TT0
            pmove.l ($DA,A0),TT1
            pmove.d ($D2,A0),CRP
            pmove.l ($CE,A0),TC
.L1:
            movem.l (SP)+,D0-D1
            movec   D0,CACR
            movec   D1,CAAR
            movea.l (SP)+,A0
            movec   A0,VBR
            movem.l (SP)+,A0-A1
            move.l  A0,USP
            movec   A1,MSP
            movea.l VIA2,A0
            movem.w (SP)+,D0-D6
            move.b  D0,(vBufB,A0)
            move.b  D1,(vDIRB,A0)
            move.b  D2,(vBufA,A0)
            move.b  D3,(vDIRA,A0)
            move.b  D4,(vIER,A0)
            move.b  D5,(vACR,A0)
            move.b  D6,(vPCR,A0)
            movea.l ASCBase,A1
            moveq   #$20,D1
.L2:
            lea     ($F10,A1),A0
            adda.l  D1,A0
            moveq   #7,D0
.L3:
            move.b  (SP)+,(A0)+
            dbra    D0,.L3
            lea     ($F00,A1),A0
            adda.l  D1,A0
            moveq   #9,D0
.L4:
            move.b  (SP)+,(A0)+
            dbra    D0,.L4
            tst.l   D1
            beq.b   .L5
            moveq   #0,D1
            bra.b   .L2
.L5:
            move.b  (SP)+,(ascTestReg,A1)
            move.b  (SP)+,(ascPlayRecA,A1)
            move.b  (SP)+,(ascVolControl,A1)
            move.b  (SP)+,(ascMode,A1)
            movea.l VIA,A0
            movem.w (SP)+,D0-D6
            move.b  D0,(vBufB,A0)
            move.b  D1,(vDIRB,A0)
            move.b  D2,($1E00,A0)
            move.b  D3,($600,A0)
            move.b  D4,($1C00,A0)
            move.b  D5,($1600,A0)
            move.b  D6,($1800,A0)
            move.b  (vT2CH,A0),(vT2CH,A0)
            move.b  (vT1CH,A0),(vT1CH,A0)
            subq.w  #4,SP
            movea.l SP,A0
            move.b  #2,(A0)
            moveq   #1,D1
            move.w  #$90,D0
            bsr.w   PMGRsend
            addq.w  #4,SP
            movea.l ([ExpandMem.w],$1AA.w),A0
            move.b  (-3,A0),D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L6
            movea.l (4,A0),A0
            jsr     (A0)
.L6:
            movea.l (SP)+,A0
            bsr.l   InitSCSI
            lea     TimeLM,A0
            _ReadDateTime
            bsr.w   KbdReset
            movem.l (SP),D1-D7/A0-A6
            movea.l PmgrBase,A2
            tst.l   ($FE,A2)
            beq.b   .L7
            movea.l ($FE,A2),A0
            jsr     (A0)
.L7:
            move    ($C8,A2),SR
            bsr.w   sub_40889612
            moveq   #3,D0
            bsr.w   DoQueue
            bsr.w   SetSupervisorMode
            movea.l PmgrBase,A2
            bsr.w   RemoveMsg
            clr.b   ($6D,A2)
            move.b  #$FF,($D,A2)
            clr.l   ($48,A2)
            clr.l   ($4C,A2)
            move.b  #8,($5F,A2)
            _CountADBs
            cmpi.b  #2,D0
            ble.b   .L8
            _ADBReInit
.L8:
            moveq   #0,D0
            movem.l (SP)+,D1-D7/A0-A6
            rts
SetSupervisorMode:
            movea.l (SP)+,A1
            moveq   #8,D0
            _DebugUtil
            cmpi.w  #paramErr,D0
            bne.b   .Cont
            move    SR,D0
.Cont:
            andi    #$EFFF,SR
            jmp     (A1)
CheckAppleTalk:
            movem.l D1-D2/A0-A3,-(SP)
            suba.w  #$32,SP
            movea.l SP,A3
            movea.l PmgrBase,A2
            moveq   #$F,D1
            and.b   PortBUse,D1
            cmpi.b  #1,D1
            bne.w   .okexit
            move.w  D0,D1
            cmpi.b  #1,D0
            bne.b   .dmndcase
            btst    #6,ChooserBits
            beq.w   .done
            btst    #0,($F,A2)
            bne.w   .done
            btst    #5,PortBUse
            bne.b   .reqcase1
            move.b  #1,($6C,A2)
            bra.w   .okexit
.reqcase1:
            bsr.w   XPPCheck
            bne.w   .done
            move.b  #2,($6C,A2)
            bra.w   .okexit
.dmndcase:
            cmpi.b  #2,D0
            bne.b   .nowcase
            btst    #6,ChooserBits
            bne.b   .dmndcase1
            bsr.w   HarshWarn
            bne.w   .done
            move.b  #4,($6C,A2)
            bset    #6,ChooserBits
            bra.w   .okexit
.dmndcase1:
            btst    #5,PortBUse
            bne.b   .dmndcase2
            bsr.w   WimpyWarn
            bne.b   .done
            move.b  #1,($6C,A2)
            bra.b   .okexit
.dmndcase2:
            bsr.w   XPPCheck
            bne.b   .dmndcase3
            bsr.w   WimpyWarn
            bne.b   .done
            move.b  #2,($6C,A2)
            bra.b   .okexit
.dmndcase3:
            bsr.w   StrongWarn
            bne.b   .done
            move.b  #3,($6C,A2)
            bra.b   .okexit
.nowcase:
            move.b  #4,($6C,A2)
            bset    #6,ChooserBits
            beq.b   .okexit
            move.b  #1,($6C,A2)
            btst    #5,PortBUse
            bne.b   .okexit
            move.b  #2,($6C,A2)
            bsr.w   XPPCheck
            beq.b   .okexit
            move.b  #3,($6C,A2)
.okexit:
            moveq   #0,D0
.done:
            lea     ($32,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            tst.w   D0
            rts
CloseAppleTalk:
            movem.l D1-D2/A0-A3,-(SP)
            suba.w  #$32,SP
            movea.l SP,A3
            movea.l PmgrBase,A2
            moveq   #$F,D1
            and.b   PortBUse,D1
            cmpi.b  #1,D1
            bne.w   .L1
            bsr.w   sub_408895EC
.L1:
            lea     ($32,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            tst.w   D0
            rts
StrongWarn:
            move.w  #$BFFE,D0
            bra.b   HarshWarn.L1
WimpyWarn:
            move.w  #$BFFD,D0
            bra.b   HarshWarn.L1
HarshWarn:
            move.w  #$BFFC,D0
.L1:
            clr.w   -(SP)
            move.w  D0,-(SP)
            clr.l   -(SP)
            _Alert
            move.w  (SP)+,D0
            subq.w  #1,D0
            rts
            movea.l A3,A0
            move.w  #$FFF6,($18,A0)
            _Close
            tst.w   D0
            rts
            movea.l A3,A0
            lea     XPPName,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            _Close
            tst.w   D0
            rts
sub_408895EC:
            movea.l A3,A0
            lea     XPPName,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            move.w  #$F7,($1A,A0)
            _Control
            _Close
            move.w  #$FFF6,($18,A0)
            _Close
            tst.w   D0
            rts
sub_40889612:
            movem.l D1-D2/A0-A3,-(SP)
            suba.w  #$32,SP
            movea.l SP,A0
            lea     MPPName,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            lea     ($32,SP),SP
            movem.l (SP)+,D1-D2/A0-A3
            rts
DoQueueStack:
            movem.l D1/A0,-(SP)
            movea.l (4,A0),A0
            cmpi.w  #1,D0
            bne.b   .runTheQueue
            bsr.b   Handle_Element
            bne.b   .undosleepreq
            moveq   #2,D0
.runTheQueue:
            bsr.b   Handle_Element
            moveq   #0,D0
.exit:
            movem.l (SP)+,D1/A0
            rts
.undosleepreq:
            moveq   #4,D0
            bsr.b   Handle_Element
            moveq   #4,D0
            bra.b   .exit
Handle_Element:
            move.l  A0,D1
            beq.b   .L1
            move.l  D0,D1
            movem.l D1/A0,-(SP)
            movea.l (A0),A0
            bsr.b   Handle_Element
            movem.l (SP)+,D1/A0
            bne.b   .L2
            move.l  D1,D0
            move.l  (6,A0),D1
            beq.b   .L1
            movea.l D1,A1
            movem.l D1-D7/A0-A6,-(SP)
            jsr     (A1)
            movem.l (SP)+,D1-D7/A0-A6
            tst.l   D0
            rts
.L1:
            moveq   #0,D0
.L2:
            rts
XPPCheck:
            movea.l A3,A0
            move.w  #$FFD7,($18,A0)
            _Close
            move.l  D0,-(SP)
            lea     XPPName,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            move.l  (SP)+,D0
            tst.w   D0
            rts
DoQueue:
            cmpi.w  #6,D0
            beq.b   .mustsleep
            cmpi.w  #2,D0
            beq.b   .mustsleep
            cmpi.w  #3,D0
            beq.b   .mustsleep
.startreq:
            move.l  D0,D7
            movea.l PmgrBase,A1
            movea.l (4,A1),A0
            move.l  A0,D2
            beq.w   .noentries
.getreq:
            movea.l (6,A0),A2
            move.l  A2,D2
            beq.b   .nextreq
            move.w  D7,D0
            movem.l A0-A1,-(SP)
            jsr     (A2)
            movem.l (SP)+,A0-A1
            tst.l   D0
            beq.b   .nextreq
            cmpi.w  #4,D7
            beq.b   .nextreq
            moveq   #4,D0
            move.l  D0,D7
            bra.b   .startreq
.nextreq:
            cmpa.l  (8,A1),A0
            beq.b   .checkreq
            movea.l (A0),A0
            bra.b   .getreq
.checkreq:
            moveq   #2,D0
            cmpi.w  #4,D7
            bne.b   .mustsleep
            moveq   #5,D0
            rts
.mustsleep:
            move.w  D0,D7
            movea.l PmgrBase,A1
            movea.l (4,A1),A0
            move.l  A0,D2
            beq.b   .noentries
.getdemand:
            movea.l (6,A0),A2
            move.l  A2,D2
            beq.b   .nextdemand
            move.w  D7,D0
            movem.l A0-A1,-(SP)
            jsr     (A2)
            movem.l (SP)+,A0-A1
.nextdemand:
            cmpa.l  (8,A1),A0
            beq.b   .noentries
            movea.l (A0),A0
            bra.b   .getdemand
.noentries:
            moveq   #0,D0
            rts
KbdReset:
            BigJsr  RSetKMap,A1
            moveq   #$10,D1
            movea.l ADBBase,A1
            bra.b   .L2
.loop:
            lea     ($C,A1),A1
.L2:
            moveq   #2,D0
            cmp.b   (1,A1),D0
            bne.b   .L3
            movea.l (8,A1),A0
            lea     (4,A0),A0
            moveq   #0,D0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
.L3:
            dbra    D1,.loop
            rts
SlpQInstall:
            cmpi.w  #$10,(4,A0)
            bne.b   SlpQErr
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Enqueue
            rts
SlpQErr:
            moveq   #-5,D0
            rts
SlpQRemove:
            cmpi.w  #$10,(4,A0)
            bne.b   SlpQErr
            movea.l PmgrBase,A1
            lea     (2,A1),A1
            _Dequeue
            rts
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
            dc.b    'YEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAHYEAH'
MPPName:
            dc.b    4,'.MPP'
            dc.b    $00
XPPName:
            dc.b    4,'.XPP'
            ds.b    5

            EVEN
