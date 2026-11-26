            include "Include/ROMHeader.s"

            EXPORT  EgretDispatch,EgretInit,EgretMgr,INITEGRETALT,SendEgretCmd,SETRESPONSEPARAMS

            IMPORT  CHECKPACKETPATCH,DELAY100PATCH,EGRETPATCHTOO,Error1Handler,GetHardwareInfo,SETTRANSFERPARMSPATCH
            IMPORT  SHIFTREGIRQPATCH

            SECTION "EgretMgr",CODE

EgretMgr:
InitEgret:
            moveq   #$4C,D0
            _NewPtrSysClear
INITEGRETALT:
            move.l  A0,EgretBase
            movea.l A0,A2
            move    SR,-(SP)
            ori     #$700,SR
            lea     ($38,A2),A0
            move.l  A0,($30,A2)
            bsr.w   SETRESPONSEPARAMS
            lea     ShiftRegIRQ,A0
            move.l  A0,($19A).w
            lea     TickHandler,A0
            move.l  A0,($28,A2)
            movea.l VIA,A1
            bclr    #4,(vACR,A1)
            move.b  #$84,(vIER,A1)
            move    (SP)+,SR
            rts
EgretDispatch:
            bsr.w   CheckPacket
            bne.w   .L7
            movea.l EgretBase,A2
            movea.l VIA,A1
            cmpi.b  #$FF,(vBufB,A0)
            bsr.l   EGRETPATCHTOO
            nop
            nop
.L1:
            move    SR,-(SP)
            ori     #$700,SR
            btst    #3,(A1)
            beq.b   .L2
            bset    #0,(A2)
            beq.b   .L3
.L2:
            move    (SP)+,SR
            bsr.w   PollByte
            bra.b   .L1
.L3:
            bset    #5,(A1)
            bset    #4,($1600,A1)
            move.b  (A0),($1400,A1)
            bset    #4,(A1)
.L4:
            btst    #2,($1A00,A1)
            beq.b   .L4
            btst    #3,(A1)
            bne.b   .L5
            bclr    #4,($1600,A1)
            bclr    #5,(A1)
            bsr.w   CallShiftRegIRQ
            bra.b   .L2
.L5:
            jsr     SetTransferParams
            bsr.w   CallShiftRegIRQ
            move    (SP)+,SR
            tst.l   ($10,A0)
            bne.b   .L7
.L6:
            btst    #0,(A2)
            beq.b   .L7
            bsr.b   PollByte
            bra.b   .L6
.L7:
            moveq   #0,D0
            rts
CheckPacket:
            bsr.l   CHECKPACKETPATCH
            cmpi.b  #2,(A0)
            bhi.b   .L1
            cmpi.b  #1,(A0)
            bne.b   .L3
            cmpi.b  #$21,(1,A0)
            bls.b   .L3
            move.w  #$202,(2,A0)
            move.w  (A0),(4,A0)
            bra.b   .L2
.L1:
            move.w  #$201,(2,A0)
            move.w  (A0),(4,A0)
.L2:
            move.w  #$FFCE,($E,A0)
            bra.b   .L4
.L3:
            clr.w   ($E,A0)
.L4:
            rts
PollByte:
            move    SR,D0
            andi.w  #$700,D0
            beq.b   .L1
            btst    #2,($1A00,A1)
            beq.b   .L1
            bsr.b   CallShiftRegIRQ
.L1:
            rts
SendByte:
            bclr    #4,(A1)
            bsr.b   Delay100
            move.b  D0,($1400,A1)
            bset    #4,(A1)
            rts
CallShiftRegIRQ:
            movem.l D0-D3/A0-A3,-(SP)
            movea.l ($19A).w,A0
            jsr     (A0)
            movem.l (SP)+,D0-D3/A0-A3
            rts
viaFullAck:
            bset    #4,(A1)
            bsr.b   Delay100
            rts
Delay100:
            bra.l   DELAY100PATCH
            lsr.w   #3,D1
.L1:
            tst.b   (A1)
            dbra    D1,.L1
            move.l  (SP)+,D1
            rts
ShiftRegIRQ:
            move    SR,D3
            ori     #$700,SR
            movea.l EgretBase,A2
            bset    #0,(A2)
            btst    #4,($1600,A1)
            beq.b   .L3
            tst.b   ($1400,A1)
            tst.w   (2,A2)
            ble.b   .L1
            movea.l (4,A2),A0
            move.b  (A0)+,D0
            move.l  A0,(4,A2)
            bsr.b   SendByte
            subq.w  #1,(2,A2)
            bra.w   .L24
.L1:
            tst.w   (8,A2)
            ble.b   .L2
            movea.l ($A,A2),A0
            move.b  (A0)+,D0
            move.l  A0,($A,A2)
            bsr.b   SendByte
            subq.w  #1,(8,A2)
            bra.w   .L24
.L2:
            bclr    #4,($1600,A1)
            andi.b  #$CF,(A1)
            bsr.b   Delay100
            bra.w   .L24
.L3:
            move.b  ($1400,A1),D0
            tst.w   ($E,A2)
            ble.b   .L6
            btst    #5,(A1)
            bne.b   .L4
            bsr.w   Delay100
            bra.b   .L5
.L4:
            bsr.w   viaFullAck
.L5:
            move.w  ($10,A2),D1
            lea     ($18,A2),A0
            move.b  D0,(0,A0,D1.w)
            addq.w  #1,($10,A2)
            subq.w  #1,($E,A2)
            ble.b   .L8
            btst    #3,(A1)
            bne.b   .L11
            bset    #5,(A1)
            bra.w   .L23
.L6:
            movea.l ($14,A2),A0
            move.b  D0,(A0)+
            move.l  A0,($14,A2)
            subq.w  #1,($12,A2)
            bgt.b   .L9
            btst    #1,(A2)
            beq.b   .L9
            bsr.w   viaFullAck
            bclr    #5,(A1)
.L7:
            btst    #3,(A1)
            beq.b   .L7
            bra.b   .L11
.L8:
            lea     ($18,A2),A0
            cmpi.b  #2,(1,A0)
            bne.b   .L10
            bclr    #2,(A2)
            bne.b   .L10
            addq.w  #1,($E,A2)
            bset    #2,(A2)
            bra.w   .L23
.L9:
            bsr.w   viaFullAck
.L10:
            btst    #3,(A1)
            bne.b   .L11
            tst.w   ($12,A2)
            bgt.w   .L23
.L11:
            bclr    #4,(A1)
            bclr    #5,(A1)
            bsr.w   Delay100
            movea.l ($34,A2),A0
            lea     ($18,A2),A1
            cmpi.b  #2,(1,A1)
            bne.b   .L12
            move.l  (1,A1),(2,A0)
            move.w  #$FFCE,($E,A0)
.L12:
            cmpa.l  ($30,A2),A0
            beq.b   .L18
            tst.b   (1,A1)
            bne.b   .L17
            cmpa.l  ($30,A2),A0
            bne.b   .L13
            bset    #6,(2,A1)
.L13:
            btst    #6,(2,A1)
            bne.w   .L20
            move.b  (2,A1),($C,A0)
            move.w  ($10,A2),D0
            subq.w  #4,D0
            beq.b   .L14
            move.w  D0,(6,A0)
.L14:
            movea.l (8,A0),A2
            addq.w  #4,A1
            bra.b   .L16
.L15:
            move.b  (A1)+,(A2)+
.L16:
            dbra    D0,.L15
            movea.l EgretBase,A2
.L17:
            move.l  ($10,A0),D0
            beq.w   .L22
            movea.l D0,A1
            move.l  A0,-(SP)
            bsr.w   SETRESPONSEPARAMS
            move    D3,SR
            movea.l (SP)+,A0
            jmp     (A1)
.L18:
            tst.b   (1,A1)
            beq.b   .L20
            cmpi.b  #3,(1,A1)
            beq.b   .L19
            cmpi.b  #1,(1,A1)
            bsr.l   SHIFTREGIRQPATCH
            nop
            nop
.L19:
            move.l  ($28,A2),D2
            beq.b   .L22
            bra.b   .L21
.L20:
            bset    #6,(2,A1)
            tst.l   A0
            beq.b   .L22
            move.l  ($10,A0),D2
            beq.b   .L22
.L21:
            suba.w  #$C,SP
            movea.l SP,A2
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            movea.l EgretBase,A2
            move.w  ($10,A2),D0
            subq.w  #4,D0
            bsr.w   SETRESPONSEPARAMS
            move    D3,SR
            movea.l SP,A1
            addq.l  #2,A1
            movea.l D2,A3
            jsr     (A3)
            lea     ($C,SP),SP
            bra.b   .L24
.L22:
            bsr.w   SETRESPONSEPARAMS
            move    D3,SR
            bra.b   .L24
.L23:
            bclr    #4,(A1)
.L24:
            rts
SetTransferParams:
            move.l  A1,-(SP)
            lea     (1,A0),A1
            move.l  A1,(4,A2)
            moveq   #0,D0
            move.b  (1,A0),D0
            tst.b   (A0)
            bne.b   .L1
            bsr.l   SETTRANSFERPARMSPATCH
            nop
            bra.b   .L3
.L1:
            cmpi.b  #$E,(1,A0)
            bne.b   .L2
            move.w  (6,A0),D1
            addq.w  #1,D1
            move.w  D1,(2,A2)
            clr.w   (8,A2)
            clr.w   (8,A2)
            clr.l   ($A,A2)
            bra.b   .L5
.L2:
            lea     PseudoCntTable,A1
.L3:
            lsl.w   #1,D0
            move.w  (0,A1,D0.w),D1
            ror.w   #8,D1
            tst.b   D1
            bmi.b   .L4
            move.b  D1,D0
            ext.w   D0
            addq.b  #1,D0
            move.w  D0,(2,A2)
            clr.w   (8,A2)
            clr.l   ($A,A2)
            bra.b   .L5
.L4:
            moveq   #$7F,D0
            and.w   D1,D0
            addq.w  #1,D0
            move.w  D0,(2,A2)
            move.w  (6,A0),(8,A2)
            move.l  (8,A0),($A,A2)
.L5:
            clr.w   ($10,A2)
            move.w  #4,($E,A2)
            asr.w   #8,D1
            bmi.b   .L7
            tst.b   (A0)
            beq.b   .L6
            lea     (2,A0),A1
            move.l  A1,($14,A2)
            move.w  D1,($12,A2)
            bra.b   .L8
.L6:
            add.w   D1,($E,A2)
            clr.w   ($12,A2)
            bclr    #1,(A2)
            bra.b   .L8
.L7:
            move.w  (6,A0),($12,A2)
            move.l  (8,A0),($14,A2)
            bset    #1,(A2)
.L8:
            move.l  A0,($34,A2)
            movea.l (SP)+,A1
            rts
SETRESPONSEPARAMS:
            clr.l   (4,A2)
            clr.w   (2,A2)
            clr.w   (8,A2)
            clr.l   ($A,A2)
            move.w  #$C,($E,A2)
            clr.w   ($10,A2)
            clr.w   ($12,A2)
            clr.l   ($14,A2)
            move.l  ($30,A2),($34,A2)
            andi.b  #$FC,(A2)
            rts
TickHandler:
            movea.l VIA,A1
            movea.l Lvl1DT,A0
            jmp     (A0)
PseudoCntTable:
            dc.w    0,$0100,$02FF,$0004,$0002,$0002,$0002,$02FF
            dc.w    $8200,$0400,0,$0400,$8200,$0100,$0100,$0002
            dc.w    $0001,0,$0100,$0100,$0100,$0002,$0001,$0100
            dc.w    $0001,$0200,$0002,$0100,$0100,$0100,$0100,$0001
            dc.b    $80,$00,$01
            ds.b    29
EgretInit:
            movea.l (8,A0),A1
            bclr    #5,(A1)
            bclr    #4,(A1)
            moveq   #$28,D0
.L1:
            BSR5    delay100us
            dbra    D0,.L1
            movea.l A6,A4
            move.l  #$10001,D0
            moveq   #0,D1
            moveq   #1,D2
            BSR6    SendEgretCmd
            tst.w   D0
            bne.b   .L4
            move.l  #$1B0001,D0
            moveq   #0,D1
            moveq   #1,D2
            BSR6    SendEgretCmd
            tst.w   D0
            bne.b   .L4
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A2
            btst    #7,($1F,A1)
            beq.b   .L2
            moveq   #$57,D1
            bra.b   .L3
.L2:
            moveq   #0,D1
.L3:
            move.l  #$E0001,D0
            moveq   #1,D2
            BSR6    SendEgretCmd
            tst.w   D0
.L4:
            movea.l A4,A6
            RTS6
SendEgretCmd:
            movea.l (8,A0),A1
            move.l  #$20000100,D4
            BSR5    delay100us
            btst    #5,(A1)
            beq.b   .L2
.L1:
            bclr    #5,(A1)
            bclr    #4,(A1)
            BSR5    delay100us
            BSR5    delay100us
.L2:
            swap    D4
            btst    #3,(A1)
            beq.w   IrqMissed
            bset    #5,(A1)
            BSR5    .L6
            beq.w   RealAbort
            swap    D0
            BSR5    sendByte1
            BSR5    delay100us
            move.l  D1,D0
            subq.w  #1,D2
            cmpi.w  #3,D2
            bhi.b   .L4
.L3:
            BSR5    sendByte1
            BSR5    delay100us
            lsr.l   #8,D0
            dbra    D2,.L3
.L4:
            bclr    #4,($1600,A1)
            bclr    #5,(A1)
            BSR5    delay100us
            BSR5    readAttn
            BSR5    delay100us
            bset    #5,(A1)
            BSR5    readByte
            andi.w  #$FF,D0
            swap    D0
            BSR5    readByte
            andi.w  #$FF,D0
            swap    D0
            exg     D0,D1
            BSR5    readByte
            bclr    #5,(A1)
            BSR5    delay100us
            move.l  D1,D0
            cmpi.b  #2,D0
            beq.b   .L5
            sub.w   D0,D0
.L5:
            RTS6
.L6:
            bset    #4,($1600,A1)
            btst    #3,(A1)
            beq.b   .L10
            move.b  D0,($1400,A1)
            bset    #4,(A1)
.L7:
            btst    #2,($1A00,A1)
            bne.b   .L8
            dbra    D4,.L7
            move.w  #$2000,D4
            swap    D4
            subq.w  #1,D4
            bne.w   .L1
            move.w  #$30,D7
            moveq   #1,D6
            BigJmp  Error1Handler,A3
.L8:
            tst.b   ($1400,A1)
            bclr    #4,(A1)
            move.w  #$68,D3
.L9:
            tst.b   (A1)
            dbra    D3,.L9
            btst    #3,(A1)
.L10:
            RTS5
RealAbort:
            bclr    #5,(A1)
IrqMissed:
            BSR5    delay100us
            bclr    #4,($1600,A1)
            tst.b   ($1400,A1)
            bset    #5,(A1)
DumpAbort:
            bclr    #4,(A1)
.L14:
            btst    #2,($1A00,A1)
            beq.b   .L14
            bset    #4,(A1)
            tst.b   ($1400,A1)
            move.w  #$68,D3
.L15:
            tst.b   (A1)
            dbra    D3,.L15
            beq.b   DumpAbort
            bclr    #4,(A1)
            bclr    #5,(A1)
            BSR5    delay100us
            bra.w   SendEgretCmd
sendByte1:
            bset    #4,($1600,A1)
            move.b  D0,($1400,A1)
            bset    #4,(A1)
.L17:
            btst    #2,($1A00,A1)
            beq.b   .L17
            tst.b   ($1400,A1)
            bclr    #4,(A1)
            RTS5
readByte:
            btst    #2,($1A00,A1)
            beq.b   readByte
            bset    #4,(A1)
            move.b  ($1400,A1),D0
            move.w  #$68,D3
.L19:
            tst.b   (A1)
            dbra    D3,.L19
            bclr    #4,(A1)
            RTS5
readAttn:
            btst    #2,($1A00,A1)
            beq.b   readAttn
            tst.b   ($1400,A1)
            RTS5
delay100us:
            move.w  #$68,D3
.L22:
            tst.b   (A1)
            dbra    D3,.L22
            RTS5
            ds.b    588

            EVEN
