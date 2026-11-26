            include "Include/ROMHeader.s"

            EXPORT  ADBOp,ADBReInit,EgretCheck,ExplicitRequestDone,GetADBInfo,GetIndADB
            EXPORT  ImplicitRequestDone,InitADB,InitADBDrvr,KBDMngr,KeyTrans,ReInit
            EXPORT  RSetKMap,SetADBInfo

            IMPORT  EgretPatches,InitADBPatchPwrMgr,RequestDonePatch

            SECTION "ADBMgr",CODE

KBDMngr:
CountADBs:
            moveq   #$10,D1
            move.w  D1,D0
            movea.l ADBBase,A1
            addq.w  #2,A1
            bra.b   .L2
.L1:
            lea     ($C,A1),A1
.L2:
            tst.b   (A1)
            dbeq    D1,.L1
            sub.w   D1,D0
            rts
GetIndADB:
            tst.w   D0
            ble.b   ADBNotFound
            cmpi.w  #numFDBAdr,D0
            bgt.b   ADBNotFound
            movea.l ADBBase,A1
            mulu.w  #fRecSize,D0
            lea     (-$C,A1,D0.l),A1
            moveq   #0,D0
            move.b  (2,A1),D0
.L1:
            move.b  (A1),(A0)+
            move.b  (1,A1),(A0)+
            move.l  (4,A1),(A0)+
            move.l  (8,A1),(A0)
            rts
GetADBInfo:
            bsr.b   FindFDBInfo
            beq.b   GetIndADB.L1
            rts
SetADBInfo:
            bsr.b   FindFDBInfo
            bne.b   .L1
            move.l  (A0)+,(4,A1)
            move.l  (A0),(8,A1)
.L1:
            rts
FindFDBInfo:
            moveq   #$10,D1
            movea.l ADBBase,A1
            bra.b   .L2
.L1:
            lea     ($C,A1),A1
.L2:
            cmp.b   (2,A1),D0
            beq.b   DoneFind
            tst.b   (2,A1)
            dbeq    D1,.L1
ADBNotFound:
            moveq   #-1,D0
            rts
DoneFind:
            moveq   #0,D0
            rts
ADBOp:
            movem.l D3/A2-A3,-(SP)
            movea.l ADBBase,A3
            move    SR,-(SP)
            ori     #$700,SR
            movea.l ($148,A3),A1
            btst    #2,($15D,A3)
            bne.b   .L1
            cmpa.l  ($144,A3),A1
            beq.b   .L5
.L1:
            move.b  D0,(A1)+
            addq.w  #1,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            cmpa.l  ($140,A3),A1
            bcs.b   .L2
            movea.l ($13C,A3),A1
.L2:
            move.l  A1,($148,A3)
            bclr    #2,($15D,A3)
            beq.b   .L3
            bsr.b   RunADBRequest
.L3:
            moveq   #0,D0
.L4:
            move    (SP)+,SR
            movem.l (SP)+,D3/A2-A3
            rts
.L5:
            moveq   #-1,D0
            bra.b   .L4
RunADBRequest:
            btst    #2,(fDBFlag,A3)
            beq.b   .L1
            moveq   #0,D2
            moveq   #-1,D3
            btst    #5,(fDBFlag,A3)
            beq.b   .L2
            rts
.L1:
            movea.l (fQHeadPtr,A3),A0
            moveq   #0,D3
            move.b  (A0),D3
            movea.l (2,A0),A2
            moveq   #$C,D2
            and.b   D3,D2
            subq.b  #8,D2
            seq     D2
            and.b   (A2)+,D2
.L2:
            movea.l ($130,A3),A0
            jmp     (A0)
ExplicitRequestDone:
            move.l  SP,-(SP)
            move    SR,D1
            ori     #HiIntMask,SR
            movea.l (fQHeadPtr,A3),A0
            lea     ($E,A0),A0
            movea.l A0,A1
            cmpa.l  (fQEndPtr,A3),A0
            bcs.b   .L1
            movea.l (fQBegPtr,A3),A0
.L1:
            move.l  A0,(fQHeadPtr,A3)
            cmpa.l  (fQEntPtr,A3),A0
            bne.b   .L2
            bset    #2,(fDBFlag,A3)
.L2:
            move.l  -(A1),-(SP)
            move.l  -(A1),-(SP)
            movea.l -(A1),A0
            move    D1,SR
            bra.b   RequestDone
ImplicitRequestDone:
            tst.b   D2
            beq.b   RunADBRequest
            move.b  D3,D0
            lsr.b   #4,D0
            bsr.w   FindFDBInfo
            bne.b   RunADBRequest
            suba.w  #12,SP
            movea.l SP,A0
            pea     (12,SP)
            move.l  (fDBOpData,A1),-(SP)
            move.l  (fDBCRA,A1),-(SP)
RequestDone:
            move.l  A0,-(SP)
            beq.b   .copyDone
            move.b  D2,(A0)+
            beq.b   .copyDone
            subq.w  #1,D2
.copyLoop:
            move.b  (A2)+,(A0)+
            dbra    D2,.copyLoop
.copyDone:
            move.l  D3,-(SP)
            bsr.w   RunADBRequest
            movem.l (SP)+,D0/A0-A2
            bra.l   RequestDonePatch
            nop
            nop
IOPStartReq:
            moveq   #5,D0
            add.b   D2,D0
            bclr    #0,(fDBAuFlag,A3)
            bne.b   .useRcv
            lea     (XmtRequest,A3),A0
            lea     (XmtMsg,A3),A1
            move.b  D0,(irMessageLen,A0)
            bra.b   .fillInReq
.useRcv:
            lea     ($188,A3),A0
            lea     ($1AC,A3),A1
            move.b  D0,($A,A0)
.fillInReq:
            move.w  #$6002,(A1)
            tst.l   D3
            bmi.b   .implicit
            clr.w   (A1)
            bset    #1,($15E,A3)
            bne.b   .SendToIOP
            move.b  #$80,(A1)+
            move.b  D2,(A1)+
            move.b  D3,(A1)+
            bra.b   .copyStart
.copyLoop:
            move.b  (A2)+,(A1)+
.copyStart:
            dbra    D2,.copyLoop
.SendToIOP:
            movea.l ($61C).w,A2
            jmp     (A2)
.implicit:
            move.w  ($14E,A3),(3,A1)
            bra.b   .SendToIOP
            ; Hardware-type dispatch from InitADB (name not from source). Overpatched to
            ; InitADBPatchPwrMgr (PwrControlsPatches), which falls back to EgretCheck.
PMgrCheck:
            bra.l   InitADBPatchPwrMgr
EgretCheck:
            moveq   #$E,D0
            and.l   UnivROMFlags,D0
            subq.l  #6,D0
            bne.b   .L1
            BigLea  EgretPatches,A0
            move.l  A0,($130,A3)
            move.w  #$FF01,($184,A3)
            bra.w   ReInit
.L1:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            bne.w   ReInit
            bra.w   VIAInitADB
            nop
IOPReqDone:
            movea.l ADBBase,A3
            move.b  ($1AC,A3),D0
            moveq   #4,D3
            and.b   D0,D3
            neg.l   D3
            move.b  ($1AE,A3),D3
            move.b  D3,($15C,A3)
            move.b  D3,($16E,A3)
            move.b  D2,D2
            lsr.b   #4,D2
            move.b  D2,($16C,A3)
            moveq   #0,D2
            move.b  ($1AD,A3),D2
            lea     ($1AF,A3),A2
            bset    #0,($15E,A3)
            btst    #7,D0
            beq.w   ImplicitRequestDone
            bclr    #1,($15E,A3)
            bra.w   ExplicitRequestDone
VIAStartReq:
            movea.l VIA,A1
            bset    #4,($15E,A3)
            beq.b   .notBusy
            rts
.notBusy:
            tst.l   D3
            bpl.b   .explicit
            move.b  ($16C,A3),D3
            lsl.b   #4,D3
            ori.b   #$C,D3
            bsr.w   .sendCmd
            beq.b   .autoReply
            move.b  ($15C,A3),($16E,A3)
            bsr.b   .StartAutoPoll
            btst    #2,($15D,A3)
            bne.b   .Idle
            pea     RunADBRequest
            move.w  TimeVIADB,D0
            lsr.w   #4,D0
.Delay:
            btst    #0,(A1)
            dbra    D0,.Delay
.Idle:
            bclr    #4,($15E,A3)
            rts
.StartAutoPoll:
            moveq   #$30,D1
            bsr.w   .waitForInput
            ori.b   #$90,($15E,A3)
            moveq   #$20,D1
            bra.b   .getReply
.explicit:
            moveq   #$C,D0
            and.b   D3,D0
            subq.b  #8,D0
            beq.w   .listen
            bsr.b   .sendCmd
            bne.b   .explicitReply
.autoReply:
            bset    #7,($15E,A3)
            move.b  ($16E,A3),($15C,A3)
.explicitReply:
            moveq   #$10,D1
.getReply:
            bsr.b   .waitForInput
            bne.b   .noTimeout
            bset    #5,($15E,A3)
.noTimeout:
            clr.b   ($163,A3)
            bsr.b   .getNextByte
            bne.b   .fetchLoop
            bset    #6,($15E,A3)
.fetchLoop:
            bsr.b   .getNextByte
            beq.b   .fetchDone
            cmpi.b  #8,($163,A3)
            bcs.b   .fetchLoop
.fetchDone:
            btst    #5,($15E,A3)
            seq     D0
            and.b   D0,($163,A3)
            bra.w   VIAReqDone
.sendCmd:
            andi.b  #$1F,($15E,A3)
            move    SR,D0
            ori     #$700,SR
            ori.b   #$1C,($1600,A1)
            move.b  D3,($1400,A1)
            move.b  D3,($15C,A3)
            andi.b  #$CF,(A1)
            move.l  (SP)+,($138,A3)
            move    D0,SR
            rts
.waitForInput:
            bclr    #4,($1600,A1)
            tst.b   ($1400,A1)
            eor.b   D1,(A1)
            move.l  (SP)+,($138,A3)
            rts
.getNextByte:
            lea     ($163,A3),A0
            moveq   #1,D0
            add.b   (A0),D0
            move.b  D0,(A0)
            move.b  ($1400,A1),(0,A0,D0.w)
            eori.b  #$30,(A1)
            move.l  (SP)+,($138,A3)
            rts
.listen:
            subq.b  #2,D2
            bcc.b   .minOK
            moveq   #0,D2
.minOK:
            subq.b  #6,D2
            bls.b   .maxOK
            moveq   #0,D2
.maxOK:
            addq.b  #8,D2
            move.b  D2,($163,A3)
            move.l  A2,($134,A3)
            bsr.b   .sendCmd
            beq.w   .autoReply
            bsr.b   .sendFirstByte
            bne.b   .noListenTimeout
            bset    #5,($15E,A3)
.noListenTimeout:
            bsr.b   .sendNextByte
            bne.b   .sendLoop
            bset    #6,($15E,A3)
.sendLoop:
            tst.b   ($163,A3)
            beq.b   VIAReqDone
            bsr.b   .sendNextByte
            bra.b   .sendLoop
.sendFirstByte:
            moveq   #$10,D1
            bra.b   .sendByte
.sendNextByte:
            moveq   #$30,D1
.sendByte:
            movea.l ($134,A3),A0
            move.b  (A0)+,($1400,A1)
            move.l  A0,($134,A3)
            subq.b  #1,($163,A3)
            eor.b   D1,(A1)
            move.l  (SP)+,($138,A3)
            rts
FDBShiftInt:
            movea.l ADBBase,A3
            movea.l ($138,A3),A0
            btst    #3,(A1)
            jmp     (A0)
VIAReqDone:
            move.b  ($15E,A3),D0
            move.b  ($15C,A3),D1
            moveq   #$40,D3
            and.b   D0,D3
            neg.l   D3
            move.b  D1,D3
            lsr.b   #4,D1
            tst.l   D3
            bpl.b   .NoSRQ
            move.w  ($14E,A3),D2
            bset    D1,D2
.SRQloop:
            addq.b  #1,D1
            andi.b  #$F,D1
            btst    D1,D2
            beq.b   .SRQloop
.NoSRQ:
            move.b  D1,($16C,A3)
            lea     ($163,A3),A0
            moveq   #0,D2
            move.b  (A0)+,D2
            movea.l A0,A2
            clr.b   ($15E,A3)
            btst    #7,D0
            bne.w   ImplicitRequestDone
            bra.w   ExplicitRequestDone
ADBReInit:
            movea.l JADBProc,A0
            moveq   #0,D0
            jsr     (A0)
            movem.l D0-D4/A0-A3,-(SP)
            movea.l ADBBase,A3
            bsr.w   ReInit
            bsr.b   InitADBDrvr
            movem.l (SP)+,D0-D4/A0-A3
            movea.l JADBProc,A0
            moveq   #1,D0
            jsr     (A0)
            rts
ADBProc:
            tst.l   D0
            bne.b   .L3
            _CountADBs
            move.w  D0,D2
            beq.b   .L3
            link.w  A6,#-$C
            moveq   #2,D1
.L1:
            lea     (-$C,A6),A0
            move.w  D2,D0
            _GetIndADB
            bmi.b   .L2
            cmp.b   (-$B,A6),D1
            bne.b   .L2
            movea.l (-6,A6),A1
            clr.l   (-6,A6)
            lea     (-$A,A6),A0
            _SetADBInfo
            movea.l A1,A0
            _DisposPtr
.L2:
            subq.w  #1,D2
            bgt.b   .L1
            unlk    A6
.L3:
            rts
InitADBDrvr:
            _CountADBs
            move.w  D0,D3
            beq.b   .L4
            moveq   #1,D4
            link.w  A6,#-$C
.L1:
            lea     (-$C,A6),A0
            move.w  D4,D0
            _GetIndADB
            move.b  D0,(-2,A6)
            bmi.b   .L3
            subq.l  #4,SP
            move.l  #'ADBS',-(SP)
            clr.w   -(SP)
            move.b  (-$B,A6),(1,SP)
            _GetResource
            move.l  (SP),D1
            bne.b   .L2
            addq.w  #4,SP
            bra.b   .L3
.L2:
            _DetachResource
            movea.l D1,A0
            move.l  (A0),D0
            _StripAddress
            movea.l D0,A0
            move.b  (-2,A6),D0
            move.b  (-$C,A6),D1
            jsr     (A0)
.L3:
            addq.w  #1,D4
            cmp.w   D4,D3
            bge.b   .L1
            unlk    A6
.L4:
            rts
InitADB:
            move.l  #fDBDSize,D0
            _NewPtrSysClear                         ; Allocate space on heap and clear
            movea.l A0,A3                           ; ADBBase is always in A3 by convention
            move.l  A3,ADBBase                      ; Save pointer to it
            lea     ADBProc,A0                      ; Get the ADBProc
            move.l  A0,JADBProc                     ; Install it into JADBProcc vector
            clr.b   KbdType                         ; Assume we have no keyboard to start
            bsr.w   RSetKMap                        ; Reset the keyboard map, etc.
            lea     FDBTask,A0                      ; Setup the FDB VBL task
            move.l  A0,JKybdTask                    ; Lomem vector
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .L1
            lea     IOPStartReq,A0
            move.l  A0,(StartReqProc,A3)
            move.b  #1,($176,A3)
            clr.b   ($177,A3)
            move.b  #3,($178,A3)
            lea     ($1A0,A3),A0
            move.l  A0,($17C,A3)
            move.b  #1,($18E,A3)
            move.b  #2,($18F,A3)
            move.b  #3,($190,A3)
            move.b  #$C,($191,A3)
            lea     ($1AC,A3),A0
            move.l  A0,($194,A3)
            move.l  A0,($198,A3)
            lea     IOPReqDone,A0
            move.l  A0,(RcvRequest+irHandler,A3)
            lea     (RcvRequest,A3),A0
            _IOPMsgRequest
            move.b  #1,(RcvRequest+irRequestKind,A3)
.L1:
            bra.w   PMgrCheck
            nop
            nop
VIAInitADB:
            lea     FDBShiftInt,A0
            move.l  A0,($19A).w
            lea     VIAStartReq,A0
            move.l  A0,(StartReqProc,A3)
            movea.l VIA,A1
            ori     #HiIntMask,SR
            move.b  #$84,(vIER,A1)
ReInit:
            ori     #HiIntMask,SR
            move.w  #((endCQ/4)-1),D0
            movea.l A3,A0
.ClrLoop:
            clr.l   (A0)+
            dbra    D0,.ClrLoop
            move.b  #(1<<fDBInit)|(1<<fDBQEmpty),(fDBFlag,A3)
            clr.b   (fDBAuFlag,A3)
            lea     (startCQ,A3),A0
            move.l  A0,(fQBegPtr,A3)
            move.l  A0,(fQHeadPtr,A3)
            move.l  A0,(fQEntPtr,A3)
            lea     (endCQ,A3),A0
            move.l  A0,(fQEndPtr,A3)
            bsr.b   InitDevT
            andi    #$F8FF,SR                       ; Clear interrupt mask
.wait:
            btst    #fDBInit,(fDBFlag,A3)
            bne.b   .wait
            rts
InitDevT:
            bsr.w   BusReset
            clr.b   (devTOffset,A3)
            clr.w   (hasDev,A3)
            moveq   #0,D0
.PollNext:
            move.b  D0,(InitAddr,A3)
            bsr.w   TalkR3
            move.b  (InitAddr,A3),D0
            tst.b   (A0)+
            beq.b   .NoDevice
            moveq   #0,D1
            move.b  (devTOffset,A3),D1
            move.b  (1,A0),(fDBDevTy,A3,D1.w)       ; Copy device handler ID into table
            move.b  D0,(fDBOAddr,A3,D1.w)
            move.b  D0,(fDBAddr,A3,D1.w)
            cmpi.b  #2,D0
            bne.b   .notKbd
            lea     KbdDrvr,A0
            move.l  A0,(fDBCRA,A3,D1.w)
.notKbd:
            cmpi.b  #3,D0
            bne.b   .notMouse
            lea     MouseDrvr,A0
            move.l  A0,(4,A3,D1.w)
.notMouse:
            addi.b  #fRecSize,D1
            move.b  D1,(devTOffset,A3)
            move.w  (hasDev,A3),D2
            bset    D0,D2
            move.w  D2,(hasDev,A3)
.NoDevice:
            addq.b  #1,D0
            cmpi.b  #numFDBAdr,D0
            bne.b   .PollNext
            move.b  #moveTime+1,(fDBMvCnt,A3)
            move.w  (hasDev,A3),(devMap,A3)
            bne.b   .movLoop
.ChgExit:
            bclr    #fDBInit,(fDBFlag,A3)
            jsr     DefaultDev
            jsr     KbdInstall
            jsr     RunADBRequest
            rts
.movLoop:
            st      (InitAddr,A3)
            subq.b  #1,(fDBMvCnt,A3)
            beq.b   .ChgExit
.ChgNext:
            addq.b  #1,(InitAddr,A3)
            bsr.w   GNextAddr
            bmi.b   .movLoop
            bsr.w   GEmptyAddr
            bmi.b   .ChgExit
            move.b  D0,(newAddr,A3)
            move.b  D0,D1
            move.b  (InitAddr,A3),D0
            bsr.w   ListenR3
            move.b  (InitAddr,A3),D0
            bsr.b   TalkR3
            tst.b   (A0)
            beq.b   .L8
            bsr.b   CopyEntry
            move.b  ($165,A3),(0,A3,D1.w)
            bra.b   .ChgNext
.L8:
            move.b  ($16F,A3),D1
            move.b  ($16D,A3),D0
            bsr.b   ListenR3
            move.b  ($16D,A3),D0
            bsr.b   TalkR3
            tst.b   (A0)
            beq.b   .L9
            bsr.b   CopyEntry
            move.b  ($165,A3),(-$C,A3,D2.w)
.L9:
            bra.b   .ChgNext
CopyEntry:
            moveq   #0,D0
            moveq   #0,D1
            move.b  ($16D,A3),D0
            move.w  ($14E,A3),D1
            bset    D0,D1
            move.w  D1,($14E,A3)
            moveq   #0,D1
            move.b  ($16F,A3),D0
.L1:
            cmp.b   (2,A3,D1.w),D0
            beq.b   .L2
            addi.w  #$C,D1
            bra.b   .L1
.L2:
            moveq   #0,D2
            move.b  ($161,A3),D2
            move.l  (0,A3,D1.w),(0,A3,D2.w)
            move.l  (4,A3,D1.w),(4,A3,D2.w)
            move.b  ($16D,A3),(2,A3,D2.w)
            addi.w  #$C,D2
            move.b  D2,($161,A3)
            rts
BusReset:
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            bra.b   MakeAsyncRequest
TalkR3:
            moveq   #$F,D1
            moveq   #0,D2
            bra.b   MakeAsyncRequest
ListenR3:
            move.b  D1,(fDBByte0,A3)
            move.b  #$FE,(fDBByte1,A3)
            moveq   #listenCmd+3,D1
            moveq   #2,D2
MakeAsyncRequest:
            lsl.b   #4,D0
            or.b    D1,D0
            move.b  D2,(fDBCnt,A3)
            pea     (fDBCnt,A3)
            movea.l SP,A0
            movea.l ($5F0).w,A1                     ; jADBop
            jsr     (A1)
            addq.w  #8,SP
            rts
GNextAddr:
            moveq   #0,D0
            moveq   #0,D1
            move.b  (InitAddr,A3),D0
            move.w  (devMap,A3),D1
.L1:
            btst    D0,D1
            bne.b   .L2
            addq.w  #1,D0
            cmpi.w  #numFDBAdr,D0
            blt.b   .L1
            moveq   #-1,D0
            rts
.L2:
            move.b  D0,(InitAddr,A3)
            rts
GEmptyAddr:
            moveq   #0,D1
            moveq   #numFDBAdr-1,D0
            move.w  (devMap,A3),D1
.L1:
            btst    D0,D1
            dbeq    D0,.L1
            tst.w   D0
            rts
FDBTask:
            rts
RSetKMap:
            lea     KeyMap,A0
            moveq   #8,D0
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            clr.w   HiKeyLast
            rts
DefaultDev:
            moveq   #kbdAddr,D0
            bsr.w   FindFDBInfo
            tst.b   D0
            beq.b   .ChkMouse
            move.b  #1,(A1)
            move.b  #2,(1,A1)
            move.b  #2,(2,A1)
            lea     KbdDrvr,A0
            move.l  A0,(4,A1)
            bset    #2,($14F,A3)
.ChkMouse:
            moveq   #3,D0
            bsr.w   FindFDBInfo
            beq.b   .L2
            move.b  #1,(A1)
            move.b  #3,(1,A1)
            move.b  #3,(2,A1)
            lea     MouseDrvr,A0
            move.l  A0,(4,A1)
            bset    #3,($14F,A3)
.L2:
            rts
MouseDrvr:
            lea     (1,A0),A1
            move.b  (A1)+,D2
            move.b  MBState,D1
            eor.b   D2,D1
            bpl.b   .L2
            move.l  Ticks,D1
            sub.l   MBTicks,D1
            movea.w #2,A0
            moveq   #-$80,D0
            and.b   D2,D0
            bmi.b   .L1
            subq.l  #2,D1
            blt.b   .L2
            addq.l  #2,D1
            subq.w  #1,A0
.L1:
            move.b  D0,MBState
            add.l   D1,MBTicks
            add.l   D1,RndSeed
            moveq   #0,D0
            _PostEvent
.L2:
            add.b   D2,D2
            beq.b   .L3
            asr.b   #1,D2
            ext.w   D2
            add.w   D2,MTemp
            move.b  CrsrCouple,CrsrNew
.L3:
            move.b  (A1),D2
            add.b   D2,D2
            beq.b   .L4
            asr.b   #1,D2
            ext.w   D2
            add.w   D2,($82A).w
            move.b  CrsrCouple,CrsrNew
.L4:
            rts
KbdDrvr:
            move.l  A2,D3
            beq.w   KbdDone
            movea.l A0,A1
            lsr.w   #4,D0
            moveq   #$F,D1
            and.l   D1,D0
            move.l  D0,D3
            lea     (-$A,SP),SP
            movea.l SP,A0
            _GetADBInfo
            ror.l   #8,D3
            move.w  (SP)+,D3
            addq.l  #8,SP
            swap    D3
            move.b  (1,A1),D0
            move.b  (2,A1),-(SP)
            bsr.b   KeyIn
            move.b  (SP)+,D0
KeyIn:
            cmpi.b  #$FF,D0
            beq.w   KbdDone
            clr.w   KeyLast
            clr.w   KbdVars
            moveq   #$7F,D1
            and.b   D0,D1
            movea.l (A2),A1
            move.b  (4,A1,D1.w),D3
            bpl.b   NoExcept
            bclr    #7,D3
            lea     ($84,A1),A0
            move.w  (A0)+,D2
            beq.b   NoExcept
            subq.w  #1,D2
ExLoop:
            cmp.b   (A0)+,D0
            beq.w   FoundEx
            move.b  (1,A0),D1
            lea     (2,A0,D1.w),A0
            dbra    D2,ExLoop
NoExcept:
            moveq   #0,D2
            move.b  D3,D2
            lsr.w   #3,D2
            tst.b   D0
            bmi.b   KeyUp
            bset    D3,(4,A2,D2.w)
            bra.b   Hammer
KeyUp:
            bclr    D3,(4,A2,D2.w)
            bset    #7,D3
Hammer:
            movem.l (4,A2),D0-D2/A0
            movem.l D0-D2/A0,KeyMap
            move.l  D3,D0
            lsr.l   #8,D0
            move.b  D0,($218).w
            swap    D0
            move.b  D0,KbdType
            move.w  ($A,A2),D0
            rol.w   #1,D0
            subq.l  #4,SP
            move.l  ($14,A2),-(SP)
            move.w  D3,-(SP)
            move.b  D0,(SP)
            pea     ($18,A2)
            _KeyTrans
            move.w  (SP)+,D0
            beq.b   NextWord
            bsr.b   PostIt
NextWord:
            move.w  (SP)+,D0
            beq.b   KbdDone
PostIt:
            ror.w   #8,D0
            swap    D0
            move.w  D3,D0
            rol.l   #8,D0
            tst.b   D3
            bmi.b   PostKeyUp
            move.l  Ticks,D1
            move.l  D1,KeyTime
            move.l  D1,KeyRepTime
            move.w  D0,KeyLast
            swap    D0
            move.w  D0,KbdVars
            swap    D0
            movea.w #3,A0
            _PostEvent
KbdDone:
            rts
PostKeyUp:
            movea.w #4,A0
            bclr    #$F,D0
            _PostEvent
            rts
FoundEx:
            move.b  (A0)+,D1
            bpl.b   .notXORKey
            moveq   #0,D2
            move.b  D3,D2
            lsr.w   #3,D2
            btst    D3,(4,A2,D2.w)
            seq     D0
.notXORKey:
            moveq   #$F,D2
            and.b   D1,D2
            beq.b   KbdDone
            tst.b   ($1C,A2)
            bne.w   NoExcept
            movem.l D0/A1,-(SP)
            move.l  A0,-(SP)
            cmpi.b  #$C,D2
            bge.b   .kbdTalk
            pea     KbdBufFree
            bra.b   .kbdBufAlloc
.kbdTalk:
            pea     KbdListen
.kbdBufAlloc:
            lea     ($1D,A2),A1
            move.b  (A1)+,D1
            beq.b   .kNoBufAvail
            subq.w  #1,D1
.kBufLoop:
            tst.b   (A1)+
            beq.b   .kGotABuf
            lea     (9,A1),A1
            dbra    D1,.kBufLoop
            bra.b   .kNoBufAvail
.kGotABuf:
            move.b  D0,(-1,A1)
            bset    #1,(-1,A1)
            move.l  A1,-(SP)
            move.b  (A0),D1
            cmpi.b  #8,D1
            bls.b   .kStrCopyLoop
            moveq   #8,D1
.kStrCopyLoop:
            move.b  (A0)+,(A1)+
            dbra    D1,.kStrCopyLoop
            move.w  D3,D0
            clr.b   D0
            lsr.w   #4,D0
            or.b    D2,D0
            movea.l SP,A0
            _ADBOp
            bne.b   .kOpFailed
            addq.l  #4,SP
.kNoBufAvail:
            addq.l  #8,SP
            movem.l (SP)+,D0/A1
            bra.w   NoExcept
.kOpFailed:
            movea.l (SP)+,A1
            clr.b   (-1,A1)
            bra.b   .kNoBufAvail
KbdListen:
            movea.l A0,A1
            moveq   #0,D1
            move.b  (A1)+,D1
            move.b  (A2)+,D2
            cmp.b   D2,D1
            bls.b   .notSmall
            move.b  D2,D1
.notSmall:
            tst.b   (-1,A0)
            bpl.b   .endClrLoop
            bra.b   .endSetLoop
.setLoop:
            move.b  (A2)+,D2
            or.b    D2,(A1)+
.endSetLoop:
            dbra    D1,.setLoop
            bra.b   .kLoopDone
.clrLoop:
            move.b  (A2)+,D2
            not.b   D2
            and.b   D2,(A1)+
.endClrLoop:
            dbra    D1,.clrLoop
.kLoopDone:
            clr.l   -(SP)
            pea     KbdBufFree
            move.l  A0,-(SP)
            movea.l SP,A0
            bclr    #2,D0
            _ADBOp
            bne.b   .kLSuccess
            movea.l (SP),A0
            clr.b   (-1,A0)
.kLSuccess:
            lea     ($C,SP),SP
            rts
KbdBufFree:
            clr.b   (-1,A0)
            rts
KbdInstall:
            moveq   #$10,D1
            movea.l ADBBase,A1
            bra.b   FirstInstall
InstallLoop:
            lea     ($C,A1),A1
FirstInstall:
            moveq   #2,D0
            cmp.b   (1,A1),D0
            bne.b   NotKbd
            moveq   #$32,D0
            _NewPtrSysClear
            movea.l A0,A2
            move.b  #2,($1D,A2)
            subq.l  #4,SP
            move.l  #'KCHR',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,D0
            beq.b   NotKbd
            movea.l D0,A0
            move.l  (A0),($14,A2)
            subq.l  #4,SP
            move.l  #'KMAP',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            move.l  (SP)+,D0
            beq.b   NotKbd
            movea.l D0,A0
            move.l  (A0),(A2)
            move.l  A2,(8,A1)
            move.b  (A1),KbdType
            move.b  (2,A1),($218).w
NotKbd:
            dbra    D1,InstallLoop
            rts
KeyTrans:
            movea.l IntlSpec,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L4
            move.l  ($176,A0),D0
            beq.b   .L4
            link.w  A6,#0
            movem.l D3-D5,-(SP)
            movea.l D0,A0
            movea.l (A0),A0
            moveq   #0,D4
            move.b  KbdType,D4
            swap    D4
            move.w  ($C,A6),D4
            move.w  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D0
            move.w  (A0)+,D1
            move.w  (A0)+,D2
            move.l  D4,D3
            and.w   D1,D3
            cmp.l   D0,D3
            bne.b   .L2
            and.w   D1,D2
            not.w   D1
            and.w   D1,D4
            or.w    D4,D2
            move.w  D2,($C,A6)
            bra.b   .L3
.L2:
            dbra    D5,.L1
.L3:
            movem.l (SP)+,D3-D5
            unlk    A6
.L4:
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            movem.l D3/A2,-(SP)
            move.w  D1,D2
            lsr.w   #8,D2
            move.b  (2,A1,D2.w),D2
            moveq   #$7F,D0
            and.b   D1,D0
            ext.w   D1
            ext.l   D1
            move.b  D2,D1
            lsl.w   #8,D1
            move.b  D0,D1
            lsl.w   #7,D2
            or.b    D1,D2
            lea     ($104,A1),A1
            move.b  (0,A1,D2.w),D0
            beq.b   .L8
            tst.l   D1
            bmi.b   .L10
            move.l  (A0),D3
            beq.b   .L10
            clr.l   (A0)
            lea     (0,A1,D3.l),A2
            move.w  (A2)+,D2
            beq.b   .L6
            subq.w  #1,D2
.L5:
            cmp.b   (A2)+,D0
            beq.b   .L7
            addq.l  #1,A2
            dbra    D2,.L5
.L6:
            swap    D0
            move.w  (A2),D0
            swap    D0
            bra.b   .L10
.L7:
            move.b  (A2),D0
            bra.b   .L10
.L8:
            move.w  (-2,A1),D3
            lsl.w   #7,D3
            lea     (0,A1,D3.w),A2
            move.w  (A2)+,D2
            beq.b   .L10
            subq.w  #1,D2
.L9:
            cmp.w   (A2)+,D1
            beq.b   .L11
            move.w  (A2)+,D3
            lsl.w   #1,D3
            lea     (2,A2,D3.w),A2
            dbra    D2,.L9
.L10:
            movem.l (SP)+,D3/A2
            move.l  D0,(4,SP)
            rts
.L11:
            tst.l   D1
            bmi.b   .L14
            move.l  (A0),D3
            beq.b   .L12
            moveq   #0,D2
            move.w  (0,A1,D3.l),D2
            lsl.w   #1,D2
            add.l   D2,D3
            move.w  (2,A1,D3.l),D0
.L12:
            tst.w   (A2)
            beq.b   .L13
            move.l  A2,D2
            sub.l   A1,D2
            move.l  D2,(A0)
            bra.b   .L10
.L13:
            clr.l   (A0)
            swap    D0
            move.w  (2,A2),D0
            bra.b   .L10
.L14:
            move.w  (A2)+,D3
            lsl.w   #1,D3
            move.w  (0,A2,D3.w),D0
            bra.b   .L10
            ds.b    8

            EVEN
