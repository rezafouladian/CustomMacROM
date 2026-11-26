            include "Include/ROMHeader.s"

            EXPORT  SysErr1,SysErrInit,SystemError

            IMPORT  DSErrorHandler,SEPARITYPATCH

            SECTION "StartErr",CODE

SysErrInit:
            suba.l  A0,A0
            move.l  A0,D0
            movec   D0,VBR
            addq.w  #8,A0
            lea     GenExcps,A1
            moveq   #9,D0
.L1:
            move.l  A1,(A0)+
            addq.w  #2,A1
            dbra    D0,.L1
            moveq   #$C,D0
.L2:
            move.l  A1,(A0)+
            dbra    D0,.L2
            lea     IRQException,A2
            moveq   #5,D0
.L3:
            move.l  A2,(A0)+
            dbra    D0,.L3
            lea     NMIExcp,A2
            move.l  A2,(A0)+
            moveq   #$1F,D0
.L4:
            move.l  A1,(A0)+
            dbra    D0,.L4
            clr.b   NMIFlag
            lea     seVars,A0
            moveq   #$1F,D0
.L5:
            clr.l   (A0)+
            dbra    D0,.L5
            clr.l   MacJmp
            clr.b   MacJmpFlag
            RTS6
            ds.b    12
Debugger:
            movem.l D0-D7/A0-A7,seVars
            bset    #7,MacJmpFlag
            link.w  A6,#0
            lea     (8,A6),A0
            move.w  (A0)+,D0
            move.w  (A0)+,seCmdSize
            bsr.b   DebugProlog
            ble.b   DebugErr
            bset    #$F,D0
            jsr     (A1)
DebugAdios:
            unlk    A6
            movem.l seVars,D0-D7/A0-A7
            movea.l (SP)+,A0
            adda.w  seCmdSize,SP
            addq.l  #4,SP
            bclr    #7,MacJmpFlag
            jmp     (A0)
DebugErr:
            moveq   #-8,D0
            bra.b   DebugAdios
DebugProlog:
            movea.l MacJmp,A1
            move.b  MacJmpFlag,D3
            add.b   D3,D3
            rts
            ds.b    4
ToDeepShit:
            move    #$2700,SR
            tst.b   MacJmpFlag
            bmi.b   .L1
            movem.l D0-D7/A0-A7,seVars
.L1:
            lea     GenExcps,A0
            move.l  (SP)+,D0
            sub.l   A0,D0
            lsr.w   #1,D0
            tst.b   CPUFlag
            bne.b   .L2
            cmpi.w  #2,D0
            bgt.b   .L2
            move.l  (SP)+,($C7C).w
            move.l  (SP)+,($C80).w
.L2:
            tst.b   MacJmpFlag
            bmi.b   .L3
            move.w  (SP)+,seSR
            move.l  (SP)+,sePC
            bra.b   SysErr2
.L3:
            addq.w  #6,SP
            bra.b   SysErr2
            ds.b    14
GenExcps:
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
            bsr.b   ToDeepShit
IRQException:
            bsr.b   ToDeepShit
NMIExcp:
            bset    #7,NMIFlag
            beq.b   IRQException
            rte
            ds.b    12
SystemError:
            movem.l D0-D7/A0-A7,seVars           
SysErr1:
            move    SR,seSR
            move.l  (SP)+,sePC
            tst.b   CPUFlag
            beq.b   SysErr2
            clr.w   -(SP)
SysErr2:
            tst.b   MacJmpFlag
            bmi.b   .L1
            move.l  SP,($C6C).w
.L1:
            bset    #7,MacJmpFlag
            cmpi.w  #$D,D0
            bne.b   .continue
            bsr.l   SEPARITYPATCH
            beq.b   .continue
            bra.b   .parityErr
            dc.b    'SWC!SWC!SWC!SWC!SWC!SWC!SWC!'
.parityErr:
            moveq   #1,D0
            _SwapMMUMode
            movea.l BootGlobPtr,A1
            clr.l   (-4,A1)
            _SwapMMUMode
            clr.l   WarmStart
            moveq   #$65,D0
.continue:
            move.w  D0,DSErrCode
            bsr.w   DebugProlog
            bpl.b   Call2DS
            bne.b   CallDB
Call2DS:
            cmpi.w  #$D,D0
            bne.b   CallDS
            moveq   #0,D0
            bra.b   CallDB
CallDS:
            lea     (DSErrorHandler.w,PC),A1
CallDB:
            move.l  A1,D1
            beq.b   CallDS
            jsr     (A1)
            tst.w   D0
            bne.b   CallDS
SysErrExit:
            bclr    #7,MacJmpFlag
            movem.l seVars,D0-D7/A0-A7
            move.l  sePC,-(SP)
            move.w  seSR,-(SP)
            rte

            EVEN
