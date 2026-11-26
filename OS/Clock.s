            include "Include/ROMHeader.s"

            EXPORT  ClkNoMem,ClkRW,clock,ReadXPRam,ValidatePRAM,VALIDATEPRAMCONT
            EXPORT  WriteXPRam,XPRAMCONT,XPRAMEXIT1

            IMPORT  CLKNOMEMPATCH,PRAMInit,PRAMInitTbl,ValidatePRAMPatch,WPOFF,WPON
            IMPORT  XPRAMPATCH

            SECTION "Clock",CODE

clock:
OneSecInt:
            move.b  #1,($1A00,A1)
            addq.l  #1,TimeLM
            bclr    #5,AlarmSt
            tst.b   SPVolCtl
            bpl.b   .L1
            move.l  SPAlarm,D0
            beq.b   .L1
            cmp.l   TimeLM,D0
            bhi.b   .L1
            bclr    #1,AlarmSt
.L1:
            rts
ClkRW:
            move    SR,-(SP)
            movem.l D1/D3-D4/A0-A1/A5-A6,-(SP)
            movea.l VIA,A1
            lea     .L1,A5
            movea.l ($54C).w,A0
            jmp     (A0)
.L1:
            movem.l (SP)+,D1/D3-D4/A0-A1/A5-A6
            move    (SP)+,SR
            rts
ReadXPRam:
            movem.l D1-D3/A1-A2,-(SP)
            move.w  #$17E0,D1
            bra.b   WriteXPRam.L1
WriteXPRam:
            movem.l D1-D3/A1-A2,-(SP)
            jsr     (WPOFF.w,PC)
            move.w  #$7E0,D1
.L1:
            btst    #6,HWCfgFlags
            beq.b   XPRAMEXIT1.L1
            BigJmp  XPRAMPATCH,A2
XPRAMCONT:
            lsl.w   #2,D0
            move.l  D0,D3
            swap    D3
            movea.l A0,A1
            bra.b   .L2
.L1:
            move.w  D0,D1
            ror.w   #8,D1
            move.b  (A1),D2
            bsr.b   ClkRW
            move.b  D2,(A1)+
            ori.b   #$80,D0
            addq.w  #4,D0
            andi.w  #$BFFF,D0
            ori.w   #$3800,D0
.L2:
            dbra    D3,.L1
            jsr     (WPON.w,PC)
            moveq   #0,D0
XPRAMEXIT1:
            movem.l (SP)+,D1-D3/A1-A2
            rts
.L1:
            moveq   #-$57,D0
            bra.b   XPRAMEXIT1
ClkNoMem:
            BigJsr  CLKNOMEMPATCH,A6
            RTS5
            cmpi.w  #$38,D4
            bne.b   .L1
            move.w  D1,D4
            swap    D1
            move.w  D4,D1
            BSR6    .L5
            lsr.l   #8,D1
            tst.w   D1
            bra.b   .L2
.L1:
            tst.b   D1
.L2:
            bmi.b   .L3
            BSR6    .L5
            move.w  D2,D1
            BSR6    .L5
            bra.b   .L4
.L3:
            BSR6    .L5
            BSR6    .L7
.L4:
            bset    #2,(A1)
            RTS5
.L5:
            moveq   #7,D4
.L6:
            ror.b   #1,D3
            roxl.b  #1,D1
            roxl.b  #1,D3
            move.b  D3,(A1)
            bset    #1,(A1)
            dbra    D4,.L6
            RTS6
.L7:
            moveq   #7,D4
            bclr    #0,($400,A1)
.L8:
            move.b  D3,(A1)
            bset    #1,(A1)
            move.b  (A1),D1
            lsr.b   #1,D1
            roxl.b  #1,D2
            dbra    D4,.L8
            bset    #0,($400,A1)
            RTS6
.L9:
            moveq   #$35,D1
            moveq   #-$2B,D2
            bra.w   ClkNoMem
.L10:
            moveq   #$35,D1
            moveq   #$55,D2
            bra.w   ClkNoMem
ValidatePRAM:
            BigJmp  ValidatePRAMPatch,A2
            nop
VALIDATEPRAMCONT:
            movea.l A6,A4
            move    SR,D5
            swap    D5
            BSR5    ClkNoMem.L10
            moveq   #$31,D1
            moveq   #0,D2
            BSR5    ClkNoMem
            BSR5    ClkNoMem.L9
            moveq   #-$3F,D1
            BSR5    ClkNoMem
            cmpi.b  #$A8,D2
            beq.b   .L3
            BSR5    ClkNoMem.L10
            lea     (PRAMInit.w,PC),A2
            moveq   #$F,D6
            move.b  #$41,D5
.L1:
            move.b  D5,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            addq.b  #4,D5
            dbra    D6,.L1
            moveq   #3,D6
            move.b  #$21,D5
.L2:
            move.b  D5,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            addq.b  #4,D5
            dbra    D6,.L2
            BSR5    ClkNoMem.L9
.L3:
            move.w  #$B830,D5
            moveq   #3,D6
.L4:
            lsl.l   #8,D2
            move.w  D5,D1
            ror.w   #8,D1
            BSR5    ClkNoMem
            ori.w   #$80,D5
            addq.w  #4,D5
            dbra    D6,.L4
            lea     .L7,A2
            cmp.l   (A2),D2
            beq.b   .L6
            BSR5    ClkNoMem.L10
            move.w  #$3830,D5
            moveq   #3,D6
            BSR5    .L9
            move.w  #$3900,D5
.L5:
            lea     .L8,A2
            moveq   #3,D6
            BSR5    .L9
            cmpi.w  #$38A0,D5
            bne.b   .L5
            move.w  #$3B58,D5
            lea     (PRAMInitTbl.w,PC),A2
            moveq   #$13,D6
            BSR5    .L9
            BSR5    ClkNoMem.L9
.L6:
            swap    D5
            move    D5,SR
            jmp     (A4)
.L7:
            dc.w    $4E75,$4D63
.L8:
            ds.b    4
.L9:
            movea.l A5,A3
.L10:
            move.w  D5,D1
            ror.w   #8,D1
            move.b  (A2)+,D2
            BSR5    ClkNoMem
            ori.w   #$80,D5
            addq.w  #4,D5
            andi.w  #$BFFF,D5
            ori.w   #$3800,D5
            dbra    D6,.L10
            jmp     (A3)
            dc.w    0

            EVEN
