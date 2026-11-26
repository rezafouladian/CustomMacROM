            include "Include/ROMHeader.s"

            EXPORT  DDPCloseSocket,DDPOpenSocket,Glue_BlockMove_DRVR_50,Glue_DisposPtr_DRVR_50,Glue_GetPtrSize_DRVR_50,Glue_NewPtr_DRVR_50
            EXPORT  Glue_NewPtrSys_DRVR_50,Glue_NewPtrSysClear_DRVR_50,memset,MPPOpen_piMAIN,NBPExtract,sub_40856368
            EXPORT  sub_40856390,sub_408564EC,sub_408564FC,sub_408565D0,sub_40856614

            SECTION "ATBoot_Libraries",CODE

            move.l  (4,SP),D0
            move.l  (8,SP),D1
sub_40856368:
            move.l  D2,-(SP)
            move.l  D0,D2
            mulu.w  D1,D2
            movea.l D2,A0
            move.l  D1,D2
            swap    D2
            mulu.w  D0,D2
            swap    D0
            mulu.w  D0,D1
            add.w   D1,D2
            swap    D2
            clr.w   D2
            adda.l  D2,A0
            move.l  A0,D0
            move.l  (SP)+,D2
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_40856390:
            jsr     sub_408563A0
            move.l  D1,D0
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563A0:
            movem.l D5-D6,-(SP)
            move.l  D0,D5
            bpl.b   .L1
            neg.l   D0
.L1:
            move.l  D1,D6
            bpl.b   .L2
            neg.l   D1
.L2:
            jsr     sub_408563CE
            tst.l   D5
            bpl.b   .L3
            neg.l   D0
.L3:
            eor.l   D5,D6
            bpl.b   .L4
            neg.l   D1
.L4:
            movem.l (SP)+,D5-D6
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563CE:
            movem.l D2-D4,-(SP)
            move.l  D1,D2
            swap    D2
            tst.w   D2
            bne.b   .L2
            move.w  D0,D3
            clr.w   D0
            swap    D0
            beq.b   .L1
            divu.w  D1,D0
            move.w  D0,D2
.L1:
            swap    D2
            move.w  D3,D0
            divu.w  D1,D0
            move.w  D0,D2
            move.l  D2,D1
            clr.w   D0
            swap    D0
            bra.b   .L5
.L2:
            move.l  D0,D2
            clr.w   D0
            swap    D0
            swap    D2
            clr.w   D2
            move.l  D1,D3
            moveq   #0,D1
            moveq   #$F,D4
.L3:
            add.l   D2,D2
            addx.l  D0,D0
            add.l   D1,D1
            cmp.l   D3,D0
            blt.b   .L4
            sub.l   D3,D0
            addq.b  #1,D1
.L4:
            dbra    D4,.L3
.L5:
            movem.l (SP)+,D2-D4
            rts
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
.L6:
            moveq   #0,D0
.L7:
            move.l  A1,-(SP)
.L8:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L8
Glue_NewPtr_DRVR_50:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtr
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
Glue_NewPtrSys_DRVR_50:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSys
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
Glue_NewPtrSysClear_DRVR_50:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
Glue_DisposPtr_DRVR_50:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     sub_408563CE.L7
Glue_GetPtrSize_DRVR_50:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _GetPtrSize
            move.l  D0,(SP)
            bpl.b   .L1
            clr.l   (SP)
            jmp     sub_408563CE.L7
.L1:
            jmp     sub_408563CE.L6
Glue_BlockMove_DRVR_50:
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _BlockMove
            movea.l D1,A1
            jmp     sub_408563CE.L7
            move.w  ROM85,D0
            bpl.b   .L1
            btst    #5,PortBUse
            beq.b   .L1
            move.w  #$FFD7,D1
            moveq   #0,D0
            bra.b   .L2
.L1:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_408565A8.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            move.w  ($18,A0),D1
            adda.w  #$32,SP
.L2:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.w  D1,(A1)
            move.w  D0,(SP)
            jmp     (A0)
            move.w  #$F5,D0
            bra.w   sub_408564FC.L1
            move.w  #$F4,D0
            bra.w   sub_408564FC.L1
            move.w  #$F3,D0
            bra.w   sub_408564FC.L1
            move.w  #$F8,D0
            bra.w   sub_408564FC.L1
            move.w  #$F7,D0
            bra.w   sub_408564FC.L1
sub_408564EC:
            move.w  #$F6,D0
            bra.w   sub_408564FC.L1
            move.w  #$FD,D0
            bra.w   sub_408564FC.L1
sub_408564FC:
            move.w  #$FB,D0
            bra.w   .L1
            move.w  #$FA,D0
            bra.w   .L1
            move.w  #$FC,D0
            bra.w   .L1
            move.w  #$100,D0
            bra.w   .L1
            move.w  #$FE,D0
            bra.b   .L1
            move.w  #$FE,D0
            bra.w   sub_408565A8
            move.w  #$FA,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8
            move.w  #$FD,D0
            bra.b   sub_408565A8
            move.w  #$FC,D0
            bra.b   sub_408565A8
            move.w  #$FB,D0
            bra.b   sub_408565A8
            move.w  #$100,D0
            bra.b   sub_408565A8
            move.w  #$F9,D0
            bra.b   sub_408565A8
            move.w  #$F8,D0
            bra.b   sub_408565A8
            move.w  #$102,D0
            bra.b   sub_408565A8
            move.w  #$101,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8.L1
            move.w  #$FE,D0
            bra.b   sub_408565A8.L1
            move.w  #$F8,D0
            bra.b   sub_408565A8.L1
            move.w  #$F9,D0
            bra.b   sub_408565A8.L1
            move.w  #$F7,D0
            bra.b   sub_408565A8.L1
            move.w  #$FC,D0
            bra.b   sub_408565A8.L1
            move.w  #$FD,D0
            bra.b   sub_408565A8.L1
            move.w  #$FB,D0
            bra.b   sub_408565A8.L1
            move.w  #$FA,D0
            bra.b   sub_408565A8.L1
.L1:
            movea.l (6,SP),A0
            move.w  #$FFF6,($18,A0)
            bra.b   sub_408565A8.L1
sub_408565A8:
            movea.l (6,SP),A0
            move.w  #$FFF5,($18,A0)
.L1:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            movea.l (SP)+,A0
            move.w  D0,($1A,A0)
            tst.b   D1
            bne.b   .L2
            _Control
            bra.b   .L3
.L2:
            _Control async
.L3:
            move.w  D0,(SP)
            jmp     (A1)
.L4:
            dc.b    4,'.XPP'
            dc.b    $00
sub_408565D0:
            movem.l D1-D2/A0-A2,-(SP)
            movem.l ($18,SP),D1-D2/A0-A2
            pea     (1,A1)
            move.l  (SP)+,(2,A2)
            move.l  A0,(8,A2)
            clr.w   ($C,A2)
            swap    D2
            move.w  D2,(8,A1)
            swap    D2
            move.b  D2,($E,A1)
            asr.w   #8,D2
            move.b  D2,($C,A1)
            move.b  D1,($10,A1)
            swap    D1
            move.w  D1,(6,A2)
            movem.l (SP)+,D1-D2/A0-A2
            move.l  (SP),($14,SP)
            adda.w  #$14,SP
            rts
sub_40856614:
            movem.l D0/A0-A1,-(SP)
            moveq   #$1C,D0
            bsr.b   sub_40856636
            move.w  #$18,D0
            bsr.b   sub_40856636
            move.w  #$14,D0
            bsr.b   sub_40856636
            movem.l (SP)+,D0/A0-A1
            move.l  (SP),($10,SP)
            adda.w  #$10,SP
            rts
sub_40856636:
            movea.l (0,SP,D0.w),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            movea.l ($20,SP),A1
            add.l   D0,($20,SP)
            _BlockMove
            rts
.L1:
            ds.b    28
.L2:
            ds.b    72
.L3:
            ds.b    26
.L4:
            dc.b    4,'.MPP'
            dc.b    $20,$04,$2E,$41,$54,$50,$20
            ds.b    102
RemoveHdlBlks:
            movem.l A1-A2,-(SP)
            lea     sub_40856636.L1,A1
.L1:
            move    SR,-(SP)
            move    #$2600,SR
            movea.l (A1),A0
            movea.l (A0),A2
            move.l  A0,D0
            beq.b   .L2
            move.l  (A2),(A1)
.L2:
            move    (SP)+,SR
            tst.l   D0
            beq.b   .L3
            _DisposHandle
            bra.b   .L1
.L3:
            movem.l (SP)+,A1-A2
            rts
.L4:
            move.l  (SP)+,D3
            move.w  D0,(SP)
            movea.l D2,A1
            jmp     (A1)
UnlockAndLinkHdl:
            move.l  A1,-(SP)
            _HUnlock
            movea.l (A0),A1
            move    SR,-(SP)
            move    #$2600,SR
            move.l  sub_40856636.L1,(A1)
            lea     sub_40856636.L1,A1
            move.l  A0,(A1)
            move    (SP)+,SR
            movea.l (SP)+,A1
            rts
IsMPPOpen:
            moveq   #0,D1
            move.b  PortBUse,D0
            bmi.b   .L1
            andi.b  #$F,D0
            subq.b  #1,D0
            bne.b   .L1
            moveq   #1,D1
.L1:
            move.b  D1,(4,SP)
            rts
MPPOpen_piMAIN:
            clr.w   -(SP)
            jsr     IsMPPOpen
            clr.w   D0
            tst.b   (SP)+
            bne.b   .L3
            move.b  PortBUse,D1
            bmi.b   .L1
            moveq   #-$61,D0
            bra.b   .L3
.L1:
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            ble.b   .L2
            moveq   #-$62,D0
            bra.b   .L3
.L2:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_40856636.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            adda.w  #$32,SP
.L3:
            move.w  D0,(4,SP)
            rts
sub_408567E4:
            moveq   #4,D3
            cmp.w   D3,D1
            bcc.b   .L1
            move.w  D1,D3
.L1:
            lea     sub_40856636.L3,A5
            move.l  A3,(2,A5)
            move.w  D3,D2
            swap    D2
            move.b  D0,D2
            tst.w   D3
            beq.b   .L2
            jsr     (A4)
            bne.b   .L4
.L2:
            lea     sub_40856636.L2,A3
            moveq   #$B,D3
.L3:
            cmp.b   (0,A3,D3.w),D2
            dbeq    D3,.L3
            bne.b   .L5
            lsl.w   #2,D3
            move.w  D3,(A5)
            movea.l ($18,A3,D3.w),A3
            move.l  A3,D0
            beq.b   .L5
            movea.l (4,A3),A3
            movea.l (A3),A3
            move.w  ($10,A3),D3
            movea.l ($14,A3),A3
            swap    D2
            adda.w  D2,A3
            sub.w   D2,D3
            jsr     (2,A4)
            bne.b   .L4
            bra.b   .L6
.L4:
            rts
.L5:
            moveq   #0,D3
            jmp     (2,A4)
.L6:
            tst.w   D3
            bge.b   .L7
            move.w  #$F3E3,D0
.L7:
            move.l  A2,-(SP)
            lea     sub_40856636.L3,A1
            lea     sub_40856636.L2,A2
            move.w  (A1),D1
            movea.l ($18,A2,D1.w),A2
            movea.l (4,A2),A0
            movea.l (A0),A0
            move.w  ($10,A0),D1
            sub.w   D3,D1
            move.w  D1,($12,A0)
            movea.l (2,A1),A3
            movea.l ($14,A0),A2
            cmp.w   ($10,A0),D2
            ble.b   .L8
            move.w  ($10,A0),D2
.L8:
            subq.w  #1,D2
            blt.b   .L9
            move.b  (0,A3,D2.w),(0,A2,D2.w)
            bra.b   .L8
.L9:
            movea.l (SP)+,A2
            move.w  D0,(2,A0)
            clr.b   (8,A0)
            move.b  (-1,A3),(9,A0)
            move.b  (-2,A3),($F,A0)
            clr.b   ($18,A0)
            move.b  (1,A2),($19,A0)
            move.w  (A1),D2
            move.w  D2,D1
            lsr.w   #2,D1
            lea     sub_40856636.L2,A1
            cmpi.b  #1,(3,A2)
            bne.b   .L10
            move.b  (2,A2),($E,A0)
            clr.w   ($C,A0)
            movea.l ($18,A1,D2.w),A3
            bra.b   .L11
.L10:
            move.b  (-4,A3),($E,A0)
            move.w  (-7,A3),($C,A0)
            tst.w   (-$B,A3)
            movea.l ($18,A1,D2.w),A3
            beq.b   .L11
            tst.w   D0
            bne.b   .L11
            bsr.w   CalcCheckSum
            beq.b   .L11
            tst.b   (9,A3)
            beq.b   .L14
            move.w  #$F3E1,(2,A0)
.L11:
            movea.l (4,A3),A0
            _HUnlock
            tst.b   (8,A3)
            beq.b   .L12
            move.l  A0,D0
            movea.w #$A,A0
            _PostEvent
            bra.b   .L13
.L12:
            st      ($C,A1,D1.w)
.L13:
            move.l  (A3),($18,A1,D2.w)
            movea.l ($A,A3),A0
            jsr     UnlockAndLinkHdl
.L14:
            rts
CalcCheckSum:
            movem.l D1/A1,-(SP)
            clr.w   D3
            lea     (8,A2),A1
            moveq   #9,D1
            bsr.b   sub_40856946
            movea.l ($14,A0),A1
            move.w  ($12,A0),D1
            bsr.b   sub_40856946
            tst.w   D3
            bne.b   .L1
            subq.w  #1,D3
.L1:
            sub.w   (6,A2),D3
            movem.l (SP)+,D1/A1
            rts
sub_40856946:
            clr.w   D0
            subq.w  #1,D1
.L1:
            move.b  (A1)+,D0
            add.w   D0,D3
            rol.w   #1,D3
            dbra    D1,.L1
            rts
sub_40856956:
            lea     sub_40856636.L2,A1
            moveq   #$B,D1
.L1:
            cmp.b   (0,A1,D1.w),D3
            dbeq    D1,.L1
            rts
DDPOpenSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            move.l  A1,D1
            bne.b   .L1
            lea     sub_408567E4,A1
            move.l  A1,D1
.L1:
            movea.l (SP)+,A1
            move.l  D3,-(SP)
            move.b  (1,A1),D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.l  D1,($1E,A0)
            move.w  #$F8,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            tst.w   D0
            bne.b   .L4
            move.b  ($1C,A0),D3
            move.b  D3,(1,A1)
            lea     sub_408567E4,A0
            cmpa.l  D1,A0
            bne.b   .L4
            lea     sub_40856636.L2,A1
            move.w  #$B,D1
.L2:
            tst.b   (0,A1,D1.w)
            dbeq    D1,.L2
            bne.b   .L3
            move.b  D3,(0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            clr.l   ($18,A1,D1.w)
            bra.b   .L4
.L3:
            move.w  #$FFA5,D0
.L4:
            adda.w  #$32,SP
            jmp     RemoveHdlBlks.L4
DDPCloseSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            move.w  (SP)+,D0
            move.l  D3,-(SP)
            move.b  D0,D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.w  #$F7,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            adda.w  #$32,SP
            tst.b   D0
            bne.b   .L2
            jsr     sub_40856956
            bne.b   .L2
            clr.b   (0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            movea.l ($18,A1,D1.w),A0
            clr.l   ($18,A1,D1.w)
            movea.l A0,A1
.L1:
            move.l  A1,D0
            beq.b   .L2
            movea.l (4,A1),A0
            _HUnlock
            movea.l A1,A0
            _RecoverHandle
            movea.l (A1),A1
            jsr     UnlockAndLinkHdl
            bra.b   .L1
.L2:
            jmp     RemoveHdlBlks.L4
NBPExtract:
            jsr     RemoveHdlBlks
            lea     ($C,SP),A0
            move.w  #$F3E0,D2
            move.w  (A0)+,D1
            beq.b   .L5
            cmp.w   (A0)+,D1
            bhi.b   .L5
            movea.l (A0),A1
.L1:
            subq.w  #1,D1
            beq.b   .L2
            addq.w  #5,A1
            clr.w   D2
            move.b  (A1),D2
            add.b   (1,A1,D2.w),D2
            add.b   (2,A1,D2.w),D2
            addq.b  #3,D2
            adda.w  D2,A1
            bra.b   .L1
.L2:
            movea.l (4,SP),A0
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            addq.w  #1,A1
            moveq   #3,D2
            move.l  (8,SP),D0
.L3:
            movea.l D0,A0
            move.b  (A1),D1
.L4:
            move.b  (A1)+,(A0)+
            subq.b  #1,D1
            bcc.b   .L4
            addi.l  #$22,D0
            subq.w  #1,D2
            bne.b   .L3
.L5:
            movea.l (SP)+,A1
            adda.w  #$10,SP
            move.w  D2,(SP)
            jmp     (A1)
memset:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($10,A6),D6
            move.l  ($C,A6),D7
            movea.l (8,A6),A4
            movea.l A4,A3
            bra.b   .L2
.L1:
            move.b  D7,(A4)+
.L2:
            move.l  D6,D0
            subq.l  #1,D6
            tst.l   D0
            bhi.b   .L1
            move.l  A3,D0
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
            dc.b    $86,$6D,$65,$6D,$73,$65,$74
            ds.b    13

            EVEN
