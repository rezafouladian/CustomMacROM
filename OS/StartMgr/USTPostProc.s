PostProc:
GoTM:
            tst.w   D7
            bne.b   Error1Handler
            move.l  #$87654321,D6
Error1Handler:
            movea.w #$2600,SP
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #$1A,D7
            bne.b   .L1
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep1,A0
            bra.w   TMEntry1
.L1:
            btst    #1,D0
            beq.b   .L2
            lea     .L2,A6
            bset    #$1B,D7
            movea.l (4,A0),A1
            movem.l (A1)+,D0/A0
            cmpi.l  #$AAAA5555,D0
            bne.b   .L2
            lea     .L2,A1
            jmp     (A0)
.L2:
            bclr    #$1B,D7
            bset    #$10,D7
            bset    #$16,D7
            move.w  #$C,D4
            BSR6    StartTimer
            movec   CACR,D0
            bset    #$F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$F,D0
            beq.b   .L3
            mc68040
            cinva   IC
            mc68030
            bra.b   .L4
.L3:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            movec   CACR,D0
            ori.b   #$11,D0
            movec   D0,CACR
.L4:
            bra.w   TMEntry1
Error2Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A2
            btst    #$1A,D7
            bne.b   .L1
            movea.l A2,A5
            BigBSR6 ErrorBeep1,A0
            BigJmp  CritErr,A0
.L1:
            bra.w   TMEntry1
Error3Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep2,A0
            BigJmp  CritErr,A0
Error4Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep3,A0
            BigJmp  CritErr,A0
NCErrorHandler:
            cmpi.l  #$FFFFFFFF,D6
            beq.w   .L5
            movea.l (8,A0),A2
            BSR6    CLKWPOFF
            move.w  #$F9,D1
            BSR6    RdXByte
            bset    #0,D1
            bne.b   .L2
            move.b  D1,D2
            move.w  #$F9,D1
            BSR6    WrXByte
            move.l  #$F00007,D4
.L1:
            swap    D4
            move.w  D4,D1
            addq.w  #1,D4
            moveq   #0,D2
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L1
.L2:
            move.l  #$F80006,D4
.L3:
            swap    D4
            subq.w  #2,D4
            move.w  D4,D1
            BSR6    RdXByte
            move.b  D1,D2
            addq.w  #1,D4
            move.w  D4,D1
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L3
            move.w  #$F0,D1
            move.b  D7,D2
            BSR6    WrXByte
            move.l  #$FC0003,D4
.L4:
            swap    D4
            move.w  D4,D1
            addq.l  #1,D4
            rol.l   #8,D6
            move.b  D6,D2
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L4
.L5:
            rts
            ds.b    4
