TMProc:
TestManager:
            movem.l D1-D5/A0-A6,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            movec   VBR,A2
            move.l  A2,-(SP)
            suba.w  #$100,SP
            move.l  D0,D3
            movea.l A0,A3
            movea.l A1,A4
            movea.l SP,A1
            BSR6    SETVECTORTABLE
            move.l  D3,D0
            movea.l A3,A0
            movea.l A4,A1
            lea     TestMgrCmds,A2
            cmp.w   (A2)+,D0
            bcc.b   TestMgrExit
            add.w   D0,D0
            adda.w  (0,A2,D0.w),A2
            jmp     (A2)
TestMgrExit:
            adda.w  #$100,SP
            movea.l (SP)+,A2
            movec   A2,VBR
            move    (SP)+,SR
            movem.l (SP)+,D1-D5/A0-A6
            rts
TestMgrCmds:
            dc.w    $000C,$0020,$001E,$0018,$0384,$002C,$0090,$009C
            dc.w    $FFEC,$0100,$014A,$02EE,$09C0,$006F,$0700,$0104
cmd1:
            bra.b   TestMgrExit
cmd0:
            moveq   #0,D6
            move.l  (A0),D7
            movea.l (8,A0),A1
            movea.l (4,A0),A0
cmd4:
            move.w  D7,D1
            lsr.w   #8,D1
            cmp.w   MaxTest,D1
            bge.b   TestMgrExit
            movea.l UnivInfoPtr,A2
            move.l  A2,USP
            add.w   D1,D1
            lea     TJump,A5
            adda.w  (A5,D1.w),A5
.loop:
            lea     .L1,A6
            RTS5
.L1:
            tst.l   D6
            beq.b   .noErr
            btst    #$1D,D7
            bne.b   TestLoop
            btst    #$1C,D7
            bne.b   StopTest
.noErr:
            subq.b  #1,D7
            bne.b   .loop
StopTest:
            btst    #$1E,D7
            beq.b   .L3
            move.l  USP,A1
            movea.l (A1),A2
            adda.l  A1,A2
            movea.l (8,A2),A2
            BSR6    StoreResults
.L3:
            btst    #$1F,D7
            beq.w   TestMgrExit
            BigJmp  StBoot,A0
TestLoop:
            lea     TestLoop,A6
            RTS5
cmd5:
            moveq   #0,D6
            move.l  (A0),D7
            movea.l (8,A0),A1
            movea.l (4,A0),A0
cmd6:
            moveq   #7,D1
            movea.l UnivInfoPtr,A2
            move.l  A2,USP
.next:
            addq.l  #1,D1
            cmpi.w  #$F,D1
            bgt.b   .cntPass
            btst    D1,D7
            beq.b   .next
            add.w   D1,D1
            lea     TJump,A5
            adda.w  (-$10,A5,D1.w),A5
            add.w   D1,D1
            lea     .return-32(PC,D1.w),A6
            RTS5
.return
            moveq   #8,D1
            bra.b   .checkErrors
            moveq   #9,D1
            bra.b   .checkErrors
            moveq   #$A,D1
            bra.b   .checkErrors
            moveq   #$B,D1
            bra.b   .checkErrors
            moveq   #$C,D1
            bra.b   .checkErrors
            moveq   #$D,D1
            bra.b   .checkErrors
            moveq   #$E,D1
            bra.b   .checkErrors
            moveq   #$F,D1
.checkErrors:
            tst.l   D6
            beq.b   .next
            btst    #$1D,D7
            bne.b   TestLoop
            btst    #$1C,D7
            bne.w   StopTest
.cntPass:
            subq.b  #1,D7
            bne.b   cmd6
            bclr    #$F,D7
            bne.b   cmd6
            bra.w   StopTest
cmd8:
            moveq   #0,D6
            move.l  (A0),D7
.loop:
            move.l  D7,D1
            lsr.w   #8,D1
            subi.w  #$80,D1
            cmp.w   MaxNTest,D1
            bge.b   .exit
            add.w   D1,D1
            lea     NJump,A5
            adda.w  (0,A5,D1.w),A5
.test:
            movea.l UnivInfoPtr,A1
            movea.l A1,A0
            adda.l  (A0),A0
            move.l  AddrMapFlags,D0
            move.w  ($12,A1),D2
            lea     .L1,A6
            RTS5
.L1:
            tst.l   D6
            beq.b   .cntPass
            btst    #$1D,D7
            bne.b   .test
            btst    #$1C,D7
            bne.b   .exit
.cntPass:
            subq.b  #1,D7
            bne.b   .loop
.exit:
            bra.w   TestMgrExit
cmd9:
            moveq   #0,D6
            move.l  (A0),D7
            lea     StartTest,A3
            lea     StartTest1,A4
            cmpa.l  (4,A3),A4
            beq.b   .onElsie
            lea     TMVectors,A3
.onElsie:
            movec   A3,VBR
            movec   CACR,D0
            move.l  D0,D1
            bset    #$F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$F,D0
            bne.b   .onAn040
            bset    #$D,D0
            movec   D0,CACR
            movec   CACR,D0
            movec   D1,CACR
            btst    #$D,D0
            beq.b   .not030
            lea     (-4,SP),SP
            pmove.l TC,(SP)
            move.l  (SP),D0
            bclr    #$1F,D0
            move.l  D0,(SP)
            pmove.l (SP),TC
            lea     (4,SP),SP
.not030:
            movec   CACR,D0
            bclr    #8,D0
            movec   D0,CACR
            bra.b   .begin
.onAn040:
            mc68040
            movec   TC,D0
            mc68030
            bclr    #$F,D0
            mc68040
            movec   D0,TC
            mc68030
            movec   CACR,D0
            bclr    #$1F,D0
            movec   D0,CACR
.begin:
            BSR6    SizeMemory
            movea.l (SP),SP
            movea.l SP,A4
            moveq   #0,D6
.testm:
            movea.l (A4)+,A0
            movea.l A0,A1
            adda.l  (A4)+,A1
            BSR6    CritProc
            tst.l   D6
            bne.w   .error
            BSR6    RevMod3Test
            tst.l   D6
            bne.w   .error
            BSR6    ExtRAMTest
            tst.l   D6
            bne.w   .error
            BSR6    SizeMemory
            movea.l (SP),SP
            moveq   #0,D6
            cmpi.l  #$FFFFFFFF,(A4)
            bne.b   .testm
            bra.w   .pass
.error:
            btst    #$1D,D7
            beq.b   .stp
.loop:
            lea     .loop,A6
            RTS5
.stp:
            btst    #$1C,D7
            bne.w   .done
.pass:
            subq.b  #1,D7
            bne.b   .begin
            bclr    #$F,D7
            bne.b   .begin
.done:
            btst    #$1E,D7
            beq.b   .boot
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            suba.l  SP,A4
            move.l  A4,D2
            lsl.w   #5,D2
            swap    D7
            move.w  D2,D7
            swap    D7
            BSR6    StoreResults
.boot:
            move.l  #'WLSC',(-4,SP)
            BigJmp  StBoot,A0
StoreResults:
            movea.l A6,A0
            BSR6    CLKWPOFF
            moveq   #0,D4
            move.l  #$F0,D3
.loop1:
            rol.l   #8,D7
            move.b  D7,D2
            move.b  D3,D1
            BSR6    TM_Wait
            BSR6    TM_Wait
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$F4,D3
            blt.b   .loop1
.loop2:
            rol.l   #8,D6
            move.b  D6,D2
            move.b  D3,D1
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$F8,D3
            blt.b   .loop2
            move.l  #$54480000,D5
            move.w  D4,D5
            move.l  D5,D4
.L7:
            rol.l   #8,D4
            move.b  D4,D2
            move.b  D3,D1
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$FC,D3
            blt.b   .L7
            jmp     (A0)
            move.w  (A0),D1
            ext.l   D1
            lea     USTSubtests,A1
            move.w  #$18,D2
            tst.w   (2,A0)
            beq.b   .L8
            lea     USTTests,A1
            move.w  #$10,D2
.L8:
            move.l  A1,D6
.L9:
            cmp.l   (A1),D1
            beq.b   .L10
            adda.w  D2,A1
            cmpi.l  #$FFFFFFFF,(A1)
            bne.b   .L9
            moveq   #0,D6
            bra.b   .L11
.L10:
            add.l   (8,A1),D6
.L11:
            bra.w   TestMgrExit
TJump:
            dc.w    SizeMem-TJump
            dc.w    DataBusTest-TJump
            dc.w    Mod3Test-TJump
            dc.w    AddrLineTest-TJump
            dc.w    RomTest-TJump
            dc.w    RevMod3Test-TJump
            dc.w    ExtRAMTest-TJump
            dc.w    MovInvTest-TJump
            dc.w    SizeV8VRAMShell-TJump
            dc.w    NoTest-TJump
MaxTest:
            dc.w    10
NJump:
            dc.w    MapRamDataTest-NJump
            dc.w    MapRamUniqTest-NJump
            dc.w    VramDataTest-NJump
            dc.w    VramAddrTest-NJump
            dc.w    SCCRegTest-NJump
            dc.w    SCCLoopTest-NJump
            dc.w    SCCTimerTest-NJump
            dc.w    VIATest-NJump
            dc.w    TestSCSI-NJump
            dc.w    TestASC-NJump
            dc.w    PramTest-NJump
            dc.w    TestRBV-NJump
            dc.w    TestSWIM-NJump
            dc.w    Float_Test-NJump
            dc.w    TestPGC-NJump
            dc.w    FMCRegTest-NJump
            dc.w    FMCCacheTest-NJump
            dc.w    OSSRegTest-NJump
            dc.w    OSSIntTest-NJump
            dc.w    RPUTest-NJump
            dc.w    EgretTest-NJump
            dc.w    TestSndInts-NJump
            dc.w    TestCLUT-NJump
            dc.w    TestVRAM-NJump
            dc.w    NoTest2-NJump
            dc.w    NoTest2-NJump
            dc.w    TestC96-NJump
MaxNTest:
            dc.w    27
NoTest2:
            moveq   #-1,D6
            jmp     (A6)
TMRestart:
            lea     (-$100,SP),SP
            movea.l SP,A1
            BSR6    SETVECTORTABLE
            moveq   #0,D6
            moveq   #0,D7
TMEntry1:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            btst    #$18,D2
            beq.b   .noPmgr
            BSR6    USTPmgrTurnOn
.noPmgr:
            btst    #$1A,D7
            bne.b   .SkipSound
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #$C,D0
            beq.b   .SkipSound
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep4,A0
.SkipSound:
            moveq   #0,D5
            BSR6    SETUPBASES
            BSR6    InitSCC
getCmd:
            BSR6    getchar
            tst.w   D0
            bmi.w   Continue
.gotChar:
            andi.b  #$7F,D0
            cmpi.b  #$2A,D0
            bne.b   .checkCmd
            bset    #$13,D7
            bra.w   Continue
.checkCmd:
            btst    #$13,D7
            bne.b   .gotStar
            cmpi.b  #$21,D0
            bne.w   Invalid
            bsr.w   UTECmd
            move.l  D0,-(SP)
            BSR6    SETUPBASES
            BSR6    InitSCC
            move.l  (SP)+,D0
            tst.l   D0
            bne.w   CTEReturn
            move.b  #$21,D0
            bra.w   CTEReturn
.gotStar:
            bclr    #$13,D7
            moveq   #0,D1
            moveq   #0,D2
            lea     CmdTable,A5
.loop:
            move.w  (A5)+,D2
            beq.w   Invalid
            cmp.b   D2,D0
            beq.b   .found
            addq.l  #2,A5
            bra.b   .loop
.found:
            move.l  A5,D5
            lsr.w   #8,D2
            BSR6    GetNBytes
            movea.l D5,A5
            move.b  (-1,A5),D5
            swap    D5
            move.w  (A5),D0
            jmp     (0,A5,D0.w)
CmdTable:
            dc.b    0,'S'
            dc.w    Service-*
            dc.b    4,'L'
            dc.w    LoadAddr-*
            dc.w    $0242,$016A,$0044,$0184,$0043,$01A4
            dc.w    $0447,$01C6,$0430,$01DC,$0431,$01F2,$0432,$0208
            dc.w    $0033,$0210,$0034,$0254,$0035,$0258,$0036,$0270
            dc.w    $0037,$0272,$0041,$0276,$0048,$027A,$0052,$027E
            dc.w    $004D,$029A,$0045,$02B8,$0049,$02BC,$0250,$02C2
            dc.w    $0454,$02CA,$044E,$0394,$0056,$0486,$005A,$04EA
            ds.b    4
EchoCmd:
            move.b  #'*',D0
            BSR6    OutChar
            swap    D5
            move.b  D5,D0
            swap    D5
CTEReturn:
            BSR6    OutChar
            bset    #$17,D7
            moveq   #0,D2
            BSR6    PutNBytes
            bclr    #$17,D7
            bra.b   Continue
Invalid:
            BSR6    OutChar
Continue:
            btst    #$10,D7
            beq.w   .NoUnQ
            btst    #$16,D7
            beq.b   .NoTimer
            btst    #5,($1A00,A2)
            beq.w   .NoUnQ
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            subq.w  #1,D4
            bpl.w   .NoUnQ
            move.w  #$C,D4
.NoTimer:
            lea     a1Msg,A1
            BSR6    SendString
            bclr    #$17,D7
            bset    #$14,D7
            move.l  D6,D0
            moveq   #4,D2
            BSR6    PutNBytes
            move.w  D7,D0
            moveq   #2,D2
            BSR6    PutNBytes
            bclr    #$14,D7
            move.b  #$2A,D0
            BSR6    OutChar
            BSR6    SETUPBASES
            lea     b1Msg,A1
            lsr.w   #8,D2
            ext.w   D2
            move.b  (0,A1,D2.w),D0
            BSR6    OutChar
            lea     trailer,A1
            BSR6    SendString
            btst    #$16,D7
            bne.b   .NoUnQ
            bclr    #$10,D7
.NoUnQ:
            bra.w   getCmd
Service:
            bclr    #$10,D7
            bclr    #$16,D7
            lea     EchoCmd,A6
            jmp     PutNBytes
LoadAddr:
            movea.l D1,A4
            swap    D4
            clr.w   D4
            swap    D4
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
ByteCnt
            swap    D4
            move.w  D1,D4
            swap    D4
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.w  D1,D0
            moveq   #2,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
GetData:
            moveq   #0,D6
            swap    D4
            subq.w  #1,D4
            blt.b   .exit
.fetch:
            moveq   #1,D2
            BSR6    GetNBytes
            move.b  D1,(A4)+
            moveq   #0,D0
            move.b  D1,D0
            add.l   D0,D6
            dbra    D4,.fetch
.exit:
            swap    D4
            bra.w   EchoCmd
CheckSum:
            moveq   #0,D6
            swap    D4
            subq.w  #1,D4
            blt.b   .noMore
.sum:
            move.b  (A4)+,D1
            moveq   #0,D0
            move.b  D1,D0
            add.l   D0,D6
            dbra    D4,.sum
.noMore:
            swap    D4
            bclr    #$17,D7
            move.l  D6,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
Execute:
            movea.l D1,A2
            lea     .L1,A6
            jmp     (A2)
.L1:
            BSR6    SETUPBASES
            move.l  #$470000,D5
            bra.w   EchoCmd
LoadA0:
            movea.l D1,A0
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
LoadA1:
            movea.l D1,A1
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
SetCache:
            movec   D1,CACR
            bra.w   EchoCmd
MMUDis:
            dc.l    0
MMUOff:
            movec   CACR,D0
            move.l  D0,D1
            bset    #31,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #31,D0
            bne.b   .onAn040
            bset    #CACR_WA_030,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #CACR_WA_030,D0
            beq.b   .exit
            lea     MMUDis,A0
            pmove.l (A0),TC
            bra.b   .restoreCACR
.onAn040:
            mc68040
            movec   TC,D0
            bclr    #15,D0
            movec   D0,TC
            mc68030
.restoreCACR:
            movec   D1,CACR
.exit:
            bra.w   EchoCmd
ClearResult:
            clr.w   D7
            moveq   #0,D6
            bra.w   EchoCmd
StartBootMsg:
            bset    #$16,D7
            bset    #$10,D7
            move.w  #$C,D4
            BSR6    StartTimer
            lea     EchoCmd,A6
            jmp     SETUPBASES
CPUReset:
            reset
            bra.w   EchoCmd
PreventSleep:
            bset    #$12,D7
            bra.w   EchoCmd
ASCIIMode:
            bset    #$14,D7
            bra.w   EchoCmd
HEXMode:
            bclr    #$14,D7
            bra.w   EchoCmd
SendResults:
            bclr    #$17,D7
            move.l  D6,D0
            moveq   #4,D2
            BSR6    PutNBytes
            bclr    #$17,D7
            move.w  D7,D0
            moveq   #2,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
MemDump:
            swap    D4
            subq.w  #1,D4
            bge.b   .L1
            clr.w   D4
.L1:
            bset    #$17,D7
.L2:
            move.l  (A4)+,D0
            moveq   #4,D2
            BSR6    PutNBytes
            dbra    D4,.L2
            swap    D4
            bra.w   EchoCmd
EchoOn:
            bset    #$15,D7
            bra.w   EchoCmd
InitTestManager:
            BigJmp  StBoot,A0
PwrMgrCmd:
            lea     ErrorMsg,A1
            lea     EchoCmd,A6
            jmp     SendString
DoCritTest:
            lea     ElsieTMVectors,A5
            lea     StartTest1,A4
            cmpa.l  (4,A5),A4
            beq.b   .L2
            lea     TMVectors,A5
.L2:
            movec   A5,VBR
            movea.l D1,A4
            btst    #$15,D7
            beq.b   .L3
            move.l  D1,D0
            moveq   #4,D2
            BSR6    PutNBytes
.L3:
            moveq   #2,D2
            BSR6    GetNBytes
            moveq   #-1,D0
            moveq   #$1C,D2
            lsl.l   D2,D0
            not.l   D0
            and.l   D0,D7
            move.w  D1,D0
            lsl.l   D2,D1
            or.l    D1,D7
            btst    #$15,D7
            beq.b   .Loop
            moveq   #2,D2
            BSR6    PutNBytes
.Loop:
            moveq   #0,D6
            move.l  A4,D1
            swap    D1
            move.b  #$3F,D0
            cmp.w   MaxTest,D1
            bge.w   Invalid
            asl.w   #1,D1
            lea     TJump,A5
            move.w  (0,A5,D1.w),D1
            lea     (0,A5,D1.w),A5
            lea     .L1,A6
            RTS5
.L1:
            movea.w #$2600,SP
            move.l  A0,D4
            move.l  A1,D5
            BSR6    SETUPBASES
            movea.l D4,A0
            movea.l D5,A1
            tst.l   D6
            beq.b   .Continue
            lea     ErrorMsg,A1
            BSR6    SendString
            btst    #$1D,D7
            beq.b   .NoLoop
.ErrLoop:
            lea     .ErrLoop,A6
            RTS5
.NoLoop:
            btst    #$1C,D7
            bne.b   .Echo
.Continue:
            move.l  A4,D1
            subq.w  #1,D1
            beq.b   .Echo
            movea.l D1,A4
            BSR6    getchar
            tst.w   D0
            bmi.b   .Loop
.Echo:
            move.l  #$540000,D5                     ; Fake an "N" to echo
            bra.w   EchoCmd                         
DoNonCritTest:
            movea.l D1,A4
            BSR6    SizeMemory
            movea.l (SP),A1
            movea.l (A1),A1
            BSR6    SETVECTORTABLE
            BSR6    SETUPBASES
            btst    #$15,D7
            beq.b   .getOpt
            move.l  A4,D0
            moveq   #4,D2
            BSR6    PutNBytes
.getOpt:
            moveq   #2,D2
            BSR6    GetNBytes
            moveq   #-1,D0
            moveq   #$1C,D2
            lsl.l   D2,D0
            not.l   D0
            and.l   D0,D7
            move.w  D1,D0
            lsl.l   D2,D1
            or.l    D1,D7
            btst    #$15,D7
            beq.b   .valid
            moveq   #2,D2
            BSR6    PutNBytes
.valid:
            move.l  A4,D1
            swap    D1
            subi.w  #$80,D1
            cmp.w   MaxNTest,D1
            blt.w   .table
            move.b  #$3F,D0
            bra.w   Invalid
.table:
            asl.w   #1,D1
            lea     NJump,A5
            move.w  (0,A5,D1.w),D1
            lea     (0,A5,D1.w),A5
            move.w  A4,-(SP)
            move.l  A5,-(SP)
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (SP)+,A5
            movem.l D0-D2/A0-A2/A5,-(SP)
.Loop:
            moveq   #0,D6
            movem.l (SP),D0-D2/A0-A2/A5
            lea     .L9,A6
            RTS5
.L9:
            BSR6    SETUPBASES
            BSR6    InitSCC
            tst.l   D6
            beq.b   .Continue
            lea     ErrorMsg,A1
            BSR6    SendString
            btst    #$1D,D7
            beq.b   .NoLoop
.ErrLoop:
            lea     .ErrLoop,A6
            movem.l (SP),D0-D2/A0-A2/A5
            RTS5
.NoLoop:
            btst    #$1C,D7
            bne.b   .Echo
.Continue:
            subq.w  #1,($1C,SP)
            beq.b   .Echo
            BSR6    getchar
            tst.w   D0
            bmi.b   .Loop
.Echo:
            lea     ($1E,SP),SP
            move.l  #$4E0000,D5
            bra.w   EchoCmd
EchoVersion
            BSR6    SETUPBASES
            BSR6    InitSCC
            lea     Version,A1
            BSR6    SendString
            move.l  D7,D4
            bset    #$14,D7
            bclr    #$17,D7
            BigLea  ROMVersion+1,A0
            move.b  (A0),D0
            moveq   #1,D2
            BSR6    PutNBytes
            move.b  #$20,D0
            BSR6    OutChar
            BigLea  BadDisk_L1,A0
            move.w  (A0),D0
            moveq   #2,D2
            bset    #$17,D7
            BSR6    PutNBytes
            move.l  D4,D7
            bra.w   EchoCmd
NubSTMDispatch:
            BigJmp  NubSTMDispatch,A0
NubMgrDispatch:
            BigJmp  NubMgrDispatch,A0
SETUPBASES:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l A3,A6
            movea.l (8,A0),A2
            btst    #$11,D0
            beq.b   .L1
            movea.l ($44,A0),A3
            moveq   #0,D3
            bra.b   .L2
.L1:
            movea.l ($C,A0),A3
            move.l  ($10,A0),D3
            sub.l   A3,D3
.L2:
            RTS6
InitSCC:
            movea.l A6,A5
            btst    #$11,D0
            beq.b   .L4
            BSR6    SetSCCIOPBypass
.L4:
            tst.b   (0,A3,D3.l)
            lea     .L7,A1
.L5:
            move.b  (A1)+,D0
            bmi.b   .L6
            move.b  D0,(2,A3,D3.l)
            move.b  (A1)+,(2,A3,D3.l)
            bra.b   .L5
.L6:
            bset    #$11,D7
            move.b  (6,A3),D0
            bset    #3,($600,A2)
            move.b  ($1E00,A2),D0
            bclr    #3,D0
            move.b  D0,($1E00,A2)
            RTS5
.L7:
            dc.w    $09C0,$0F00,$044C,$0B50,$0E00,$0C0A,$0D00,$0E01
            dc.w    $0A00,$03C1,$05EA,$0100,$FFFF
OutChar:
            move.b  #$30,(2,A3,D3.l)
            move.b  D0,(6,A3,D3.l)
.L1:
            move.w  #1,D0
            move.b  D0,(2,A3,D3.l)
            btst    #0,(2,A3)
            beq.b   .L1
            RTS6
SendString:
            movea.l A6,A0
.L3:
            move.b  (A1)+,D0
            beq.b   .L4
            BSR6    OutChar
            bra.b   .L3
.L4:
            jmp     (A0)
ErrorMsg:
            dc.b    '*ERROR*'
            dc.b    $00
a1Msg:
            dc.b    '*APPLE*'
            dc.b    $00,$30,$33,$32
b1Msg:
            dc.b    '11116788AAABCDEHIJ'
trailer:
            dc.b    '*',$0D,$0A,$00
Version:
            dc.b    'STM Version 2.1, Scott Smyers '
            dc.b    $0D,$0A
            dc.b    'CTE Version 1.5.1 '
            dc.b    $0D,$0A
            dc.b    'ROM Version '
            dc.b    $00
StartTimer:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            clr.b   ($1600,A2)
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            jmp     (A3)
            movea.l A6,A5
            bclr    #$F,D0
            btst    #5,($1A00,A2)
            beq.b   .L1
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            subq.w  #1,D4
            bpl.b   .L1
            move.w  D0,D4
            bset    #$F,D0
.L1:
            RTS5
getchar:
            move.w  #$8000,D0
            btst    #$11,D7
            beq.b   .L2
            btst    #0,(2,A3)
            beq.b   .L2
            moveq   #1,D0
            move.b  D0,(2,A3,D3.l)
            move.b  (2,A3),D0
            andi.b  #$70,D0
            beq.b   .L1
            move.b  #$30,(2,A3,D3.l)
.L1:
            lsl.l   #8,D0
            move.b  (6,A3),D0
.L2:
            RTS6
CVTASCII:
            andi.w  #$7F,D0
            subi.b  #$30,D0
            bmi.b   .L2
            cmpi.b  #$16,D0
            bgt.b   .L2
            cmpi.b  #9,D0
            ble.b   .L1
            subq.b  #7,D0
.L1:
            RTS6
.L2:
            clr.w   D0
            RTS6
GetNBytes:
            movea.l A6,A5
            tst.w   D2
            beq.b   .exit
            moveq   #0,D1
            btst    #$14,D7
            beq.b   .adjust
            asl.w   #1,D2
.adjust:
            subq.w  #1,D2
.loop:
            BSR6    getchar
            tst.w   D0
            bmi.b   .loop
            btst    #$14,D7
            beq.b   .hex
            BSR6    CVTASCII
            lsl.l   #4,D1
            or.b    D0,D1
            bra.b   .next
.hex:
            lsl.l   #8,D1
            move.b  D0,D1
.next:
            dbra    D2,.loop
.exit:
            RTS5
CvtHex:
            cmpi.b  #$A,D0
            blt.b   .num
            addq.b  #7,D0
.num:
            addi.b  #$30,D0
            RTS6
PutNBytes:
            movea.l A6,A5
            move.l  D0,D1
            tst.w   D2
            beq.b   .crlf
            moveq   #4,D0
            sub.w   D2,D0
            mulu.w  #8,D0
            rol.l   D0,D1
            btst    #$14,D7
            beq.b   .hex
            asl.w   #1,D2
.hex:
            subq.w  #1,D2
.loop:
            btst    #$14,D7
            bne.b   .ascii
            rol.l   #8,D1
            move.b  D1,D0
            bra.b   .send
.ascii:
            rol.l   #4,D1
            move.b  D1,D0
            andi.b  #$F,D0
            BSR6    CvtHex
.send:
            BSR6    OutChar
            dbra    D2,.loop
.crlf:
            btst    #$17,D7
            beq.b   .exit
            move.b  #$D,D0
            BSR6    OutChar
            move.b  #$A,D0
            BSR6    OutChar
.exit:
            RTS5
SendToClk:
            moveq   #8-1,D0                         ; Shifting out 8 bits
.ShiftLoop:
            swap    D0                              ; Save the count
            move.b  (vBufB,A2),D0                   ; Get the VIA register's contents
            ror.b   #1,D0
            roxl.b  #1,D1
            roxl.b  #1,D0
            move.b  D0,(vBufB,A2)
            bclr    #vRTCClk,(vBufB,A2)
            bset    #vRTCClk,(vBufB,A2)
            swap    D0
            dbra    D0,.ShiftLoop
            RTS6
.L2:
            moveq   #7,D1
            bclr    #vRTCData,(vDIRB,A2)
.L3:
            bclr    #vRTCClk,(vBufB,A2)
            bset    #vRTCClk,(vBufB,A2)
            move.b  (vBufB,A2),D0
            lsr.b   #vRTCData+1,D0
            roxl.b  #1,D2
            dbra    D1,.L3
            bset    #vRTCData,(vDIRB,A2)
            RTS6
WrXByte:
            movea.l A6,A3
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L8
            move.l  D2,D5
            btst    #5,(A2)
            beq.b   .L1
            bclr    #5,(A2)
            BSR6    TM_Wait
            bclr    #4,(A2)
            BSR6    TM_Wait
.L1:
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            btst    #3,(A2)
            beq.b   .L3
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L2:
            btst    #2,($1A00,A2)
            dbne    D0,.L2
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L4
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            bne.b   .L5
            bra.b   .L4
.L3:
            BSR6    TM_Wait
            tst.b   ($1400,A2)
.L4:
            bclr    #5,(A2)
            bclr    #4,(A2)
            bclr    #4,($1600,A2)
            BSR6    TM_Wait
            BSR6    dispose
            bra.b   .L1
.L5:
            moveq   #$C,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            lsr.l   #8,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            BSR6    TM_SendByte
            move.l  D5,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
.L6:
            btst    #2,($1A00,A2)
            beq.b   .L6
            btst    #3,(A2)
            bne.b   .L6
            tst.b   ($1400,A2)
            BSR6    TM_Wait
            bset    #5,(A2)
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.w   .L4
            BSR6    TM_GetByte
            beq.w   .L7
            cmpi.b  #$C,D2
            bne.w   .L4
            bclr    #5,(A2)
            bclr    #4,(A2)
            BSR6    TM_Wait
            jmp     (A3)
.L7:
            BSR6    TM_GetByte
            beq.b   .L7
            bra.w   .L4
.L8:
            bclr    #2,(A2)
            ror.w   #5,D1
            andi.b  #7,D1
            ori.b   #$38,D1
            BSR6    SendToClk
            rol.w   #7,D1
            BSR6    SendToClk
            move.b  D2,D1
            andi.w  #$FF,D1
            BSR6    SendToClk
            bset    #2,(A2)
            jmp     (A3)
RdXByte:
            movea.l A6,A3
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L8
            btst    #5,(A2)
            beq.b   .L1
            bclr    #5,(A2)
            BSR6    TM_Wait
            bclr    #4,(A2)
            BSR6    TM_Wait
.L1:
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            btst    #3,(A2)
            beq.b   .L3
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L2:
            btst    #2,($1A00,A2)
            dbne    D0,.L2
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L4
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            bne.b   .L5
            bra.b   .L4
.L3:
            BSR6    TM_Wait
            tst.b   ($1400,A2)
.L4:
            bclr    #5,(A2)
            bclr    #4,(A2)
            bclr    #4,($1600,A2)
            BSR6    TM_Wait
            BSR6    dispose
            bra.b   .L1
.L5:
            moveq   #7,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            lsr.l   #8,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
.L6:
            btst    #2,($1A00,A2)
            beq.b   .L6
            btst    #3,(A2)
            bne.b   .L6
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            bset    #5,(A2)
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.w   .L4
            cmpi.b  #7,D2
            bne.w   .L4
            BSR6    TM_GetByte
            bclr    #5,(A2)
.L7:
            btst    #3,(A2)
            beq.b   .L7
            bclr    #4,(A2)
            BSR6    TM_Wait
            move.l  D2,D1
            jmp     (A3)
.L8:
            bclr    #2,(A2)
            ror.w   #5,D1
            andi.b  #7,D1
            ori.b   #$B8,D1
            BSR6    SendToClk
            rol.w   #7,D1
            BSR6    SendToClk
            BSR6    SendToClk.L2
            bset    #2,(A2)
            andi.w  #$FF,D2
            move.l  D2,D1
            jmp     (A3)
TM_SendByte:
            movea.l A6,A5
            move.b  D2,($1400,A2)
            bset    #4,(A2)
.L1:
            btst    #2,($1A00,A2)
            beq.b   .L1
            tst.b   ($1400,A2)
            bclr    #4,(A2)
            movea.l A5,A6
            jmp     TM_Wait
TM_GetByte:
            movea.l A6,A5
            bclr    #4,(A2)
.L1:
            btst    #2,($1A00,A2)
            beq.b   .L1
            bset    #4,(A2)
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            andi.w  #$FF,D2
            btst    #3,(A2)
            RTS5
TM_Wait:
            move.w  #delay325uS,D0                  ; Delay using a VIA access as a time base
.delay:
            tst.b   (vBufB,A2)                      ; Touch the VIA (each access is ~127uS)
            dbra    D0,.delay                       ; Delay
            RTS6
dispose:
            movea.l A6,A4                           ; Save the return address
            btst    #vXcvrSesBit,(vBufB,A2)         ; Is XCVR Session asserted?
            bne.b   .L4                             ; If not, just delay an return
            BSR6    TM_Wait                         ; Give Egret a breather
            bset    #vSysSesbit,(vBufB,A2)          ; TElse set sys session
.L3:
            BSR6    TM_GetByte                      ; Read a byte - to throw away
            beq.b   .L3
            bclr    #vSysSesbit,(A2)
            bclr    #4,(A2)
.L4:
            movea.l A4,A6
            jmp     TM_Wait
CLKWPOFF:
            move.l  ($1C,A1),D1
            andi.l  #$70,D1
            cmpi.l  #$20,D1
            bne.b   .L1
            RTS6
.L1:
            movea.l A6,A5
            bclr    #2,(A2)
            moveq   #$35,D1
            moveq   #$55,D2
            BSR6    SendToClk
            move.w  D2,D1
            BSR6    SendToClk
            bset    #2,(A2)
            RTS5
            movea.l A6,A5
            RTS5
SizeMem:
            move.l  A6,USP
            BSR6    SizeMemory
            sne     D7
            bne.b   .L1
            move.l  (SP),D6
.L1:
            move.l  USP,A6
            RTS6
SizeV8VRAMShell:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            suba.l  A2,A2
            BSR6    SizeV8VRAM
            move.l  A2,D0
            bne.b   .L2
            moveq   #-1,D6
            bra.b   .L3
.L2:
            moveq   #0,D6
            btst    #2,(1,A2)
            beq.b   .L3
            move.l  #$40000,D6
            btst    #1,(1,A2)
            bne.b   .L3
            lsl.l   #1,D6
.L3:
            jmp     (A3)
