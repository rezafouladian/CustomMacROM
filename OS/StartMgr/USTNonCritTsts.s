NonCritProc:
VramDataTest:
VramAddrTest:
MapRamUniqTest:
MapRamDataTest:
            moveq   #-1,D6
            RTS6
SetSCCIOPBypass:
            move.b  #$32,(-$1C,A3)
            lea     .L5,A0
            movea.l A0,A1
            move.w  (A0)+,D0
            move.w  (A0)+,(-$1F,A3)
.L1:
            move.b  (A0)+,(-$18,A3)
            dbra    D0,.L1
            move.w  (A1)+,D0
            move.w  (A1)+,(-$1F,A3)
.L2:
            move.b  (-$18,A3),D1
            cmp.b   (A1)+,D1
            bne.b   .L4
            dbra    D0,.L2
            move.b  #$36,(-$1C,A3)
            lsr.w   #6,D0
.L3:
            dbra    D0,.L3
.L4:
            addq.w  #1,D0
            RTS6
.L5:
            dc.w    $0011,$7FEE,$A981,$8D30,$F0A9,$448D,$31F0,$80FE
            dc.w    $EE7F,$EE7F,$EE7F
GetSCCVIABases:
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
            bclr    #3,($1E00,A2)
            bset    #3,($600,A2)
            addq.w  #2,A3
            rts
Restore_USTNonCritTsts:
            lea     LocalSCCInt.L3,A0
            bsr.b   writescc
            lea     LocalSCCInt.L4,A0
            bsr.b   writescc
            subq.w  #2,A3
            lea     LocalSCCInt.L4,A0
            bsr.b   writescc
            rts
writescc:
            move.w  (A0)+,D0
            move.b  (A3),D2
.L1:
            move.w  (SP),(SP)
            move.b  (A0)+,(0,A3,D3.l)
            dbra    D0,.L1
            rts
scclp:
            move.w  #$3E8,D0
.L1:
            tst.b   (A2)
            dbra    D0,.L1
            tst.b   (4,A3)
            move.w  #$80,D1
.L2:
            moveq   #-1,D4
            moveq   #0,D6
            move.b  #$30,(0,A3,D3.l)
            move.b  (SP),(SP)
.L3:
            btst    #2,(A3)
            bne.b   .L4
            dbra    D4,.L3
            moveq   #1,D6
            bra.b   .L11
.L4:
            move.b  D1,(4,A3,D3.l)
            moveq   #-1,D4
.L5:
            move.b  #1,(0,A3,D3.l)
            move.w  (SP),(SP)
            btst    #0,(A3)
            bne.b   .L6
            dbra    D4,.L5
            moveq   #2,D6
            bra.b   .L11
.L6:
            move.w  #$FFFF,D4
.L7:
            btst    #0,(A3)
            bne.b   .L8
            dbra    D4,.L7
            moveq   #3,D6
            bra.b   .L11
.L8:
            move.b  (4,A3),D2
            cmp.b   D1,D2
            beq.b   .L9
            moveq   #4,D6
            bra.b   .L11
.L9:
            move.b  #1,(0,A3,D3.l)
            move.w  (SP),(SP)
            move.b  (A3),D2
            andi.b  #$70,D2
            beq.b   .L10
            moveq   #5,D6
            bra.b   .L11
.L10:
            lsr.b   #1,D1
            bne.b   .L2
.L11:
            rts
SCCLoopTest:
            move    SR,-(SP)
            ori     #$700,SR
            movec   CACR,D3
            move.l  D3,-(SP)
            bclr    #$F,D3
            movec   D3,CACR
            bsr.w   GetSCCVIABases
            lea     LocalSCCInt.L2,A0
            bsr.w   writescc
            lea     LocalSCCInt.L5,A0
            bsr.w   writescc
            bsr.w   scclp
            bne.b   .L1
            bsr.w   writescc
            lea     LocalSCCInt.L2,A0
            bsr.w   writescc
            lea     LocalSCCInt.L5,A0
            bsr.w   writescc
            bsr.w   scclp
            addq.w  #2,A3
            beq.b   .L1
            addi.w  #$10,D6
.L1:
            bsr.w   Restore_USTNonCritTsts
            move.l  (SP)+,D3
            movec   D3,CACR
            move    (SP)+,SR
            RTS6
regLoop:
            moveq   #0,D6
            move.w  #$FF,D1
            moveq   #0,D4
            move.b  (A3),D0
            move.l  (SP),(SP)
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (A3),-(SP)
            move.l  (SP),(SP)
.L1:
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            and.b   D5,D4
            move.b  D4,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (A3),D0
            and.b   D5,D0
            cmp.b   D4,D0
            bne.b   .L2
            addq.l  #1,D4
            dbra    D1,.L1
            bra.b   .L3
.L2:
            move.b  #$FF,D6
            asl.l   #8,D6
            move.b  D2,D6
            asl.l   #8,D6
            move.b  D4,D6
            asl.l   #8,D6
            move.b  D0,D6
.L3:
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (SP)+,(0,A3,D3.l)
            tst.l   D6
            rts
SCCRegTest:
            bsr.w   GetSCCVIABases
            lea     LocalSCCInt.L3,A0
            bsr.w   writescc
            lea     LocalSCCInt.L7,A4
.L1:
            move.b  (A4)+,D2
            bmi.b   .L2
            move.b  (A4)+,D5
            bsr.b   regLoop
            beq.b   .L1
            bra.b   .L5
.L2:
            subq.w  #2,A3
            lea     LocalSCCInt.L8,A4
.L3:
            move.b  (A4)+,D2
            bmi.b   .L4
            move.b  (A4)+,D5
            bsr.w   regLoop
            beq.b   .L3
.L4:
            addq.w  #2,A3
.L5:
            bsr.w   Restore_USTNonCritTsts
            RTS6
DisableInts:
            movea.l (SP)+,A1
            ori     #$700,SR
            btst    #$12,D0
            beq.b   .L2
            movea.l ($48,A0),A2
            moveq   #$E,D1
.L1:
            move.b  (0,A2,D1.w),-(SP)
            clr.b   (0,A2,D1.w)
            dbra    D1,.L1
.L2:
            btst    #$B,D0
            beq.b   .L3
            movea.l ($2C,A0),A2
            move.b  ($1C00,A2),-(SP)
            move.b  #$7F,($1C00,A2)
.L3:
            btst    #$D,D0
            beq.b   .L4
            movea.l ($34,A0),A2
            move.b  ($13,A2),-(SP)
            move.b  #$7F,($13,A2)
.L4:
            movea.l (8,A0),A2
            move.b  ($1C00,A2),-(SP)
            move.b  #$7F,($1C00,A2)
            jmp     (A1)
RestoreInts:
            movea.l (SP)+,A1
            movea.l (8,A0),A2
            move.b  #$7F,($1C00,A2)
            move.b  (SP)+,($1C00,A2)
            btst    #$D,D0
            beq.b   .L1
            movea.l ($34,A0),A2
            move.b  (SP)+,($13,A2)
            move.b  #$FF,($12,A2)
.L1:
            btst    #$B,D0
            beq.b   .L2
            movea.l ($2C,A0),A2
            move.b  #$7F,($1C00,A2)
            move.b  (SP)+,($1C00,A2)
.L2:
            btst    #$12,D0
            beq.b   .L4
            movea.l ($48,A0),A2
            moveq   #0,D1
.L3:
            move.b  (SP)+,(0,A2,D1.w)
            addq.b  #1,D1
            cmpi.b  #$E,D1
            ble.b   .L3
.L4:
            jmp     (A1)
SCCTimerTest:
            bsr.w   GetSCCVIABases
            bsr.w   DisableInts
            move.l  D0,-(SP)
            move.l  A0,-(SP)
            btst    #$12,D0
            beq.b   .L1
            movea.l ($48,A0),A1
            move.b  #4,(7,A1)
.L1:
            movec   VBR,A5
            adda.w  #$70,A5
            move.l  (A5),-(SP)
            lea     LocalSCCInt,A1
            move.l  A1,(A5)
            lea     LocalSCCInt.L6,A0
            bsr.w   writescc
            moveq   #1,D6
            moveq   #-1,D1
            move.l  #$50000,D0
            move    #$2300,SR
.L2:
            tst.w   D1
            beq.b   .L3
            subq.l  #1,D0
            bne.b   .L2
            bra.b   .L5
.L3:
            tst.w   D1
            bne.b   .L4
            subq.l  #1,D0
            bne.b   .L3
            moveq   #2,D6
            bra.b   .L5
.L4:
            ori     #$700,SR
            sub.l   D2,D5
            moveq   #3,D6
            cmpi.l  #$10000,D5
            bgt.b   .L5
            moveq   #4,D6
            cmpi.l  #$100,D5
            blt.b   .L5
            moveq   #0,D6
.L5:
            lea     LocalSCCInt.L3,A0
            bsr.w   writescc
            ori     #$700,SR
            movec   VBR,A5
            adda.w  #$70,A5
            move.l  (SP)+,(A5)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            bsr.w   RestoreInts
            RTS6
LocalSCCInt:
            move.b  #$10,(0,A3,D3.l)
            move.l  D0,D2
            tst.w   D1
            bpl.b   .L1
            move.l  D2,D5
.L1:
            addq.w  #1,D1
            tst.b   ($1C00,A2)
            tst.b   ($1A00,A2)
            rte
.L2:
            dc.w    $0011,$09C0,$044C,$0B50,$0F00,$0C00,$0D00,$0E01
            dc.w    $03C1,$056A
.L3:
            dc.w    $0001,$09C0
.L4:
            dc.w    $0007,$0F08,$0010,$0101,$0908
.L5:
            dc.w    $0003,$0E11,$0568
.L6:
            dc.w    $0011,$09C0,$0CFF,$0DFF,$0E00,$0E03,$0F02,$0010
            dc.w    $0101,$090A
.L7:
            dc.w    $02FF,$0CFF,$0DFF,$0FFA,$FFFF
.L8:
            dc.w    $0200,$0CFF,$0DFF,$0FFA,$FFFF
VIATest:
            bsr.w   DisableInts
            btst    #$12,D0
            beq.b   .L1
            movea.l ($48,A0),A1
            move.b  #1,($B,A1)
            move.b  #1,($A,A1)
.L1:
            movec   VBR,A2
            adda.w  #$64,A2
            move.l  (A2),-(SP)
            lea     LocalVIA1Int,A3
            move.l  A3,(A2)
            moveq   #0,D6
            move.l  D0,D1
            movea.l (8,A0),A2
            andi.b  #$1F,($1600,A2)
            ori.b   #$40,($1600,A2)
            move.b  #$62,($1A00,A2)
            move.b  #$E2,($1C00,A2)
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            move.b  #$FF,($A00,A2)
            move.b  #$FF,($1200,A2)
            move.b  #$FF,($800,A2)
            move.b  #$FF,($1000,A2)
            move.b  #2,($A00,A2)
            move.b  #$3F,($1200,A2)
            move.l  #$F0000,D0
            move    #$2000,SR
.L2:
            cmpi.w  #$A,D3
            beq.b   .L3
            subq.l  #1,D0
            bne.b   .L2
.L3:
            ori     #$700,SR
            moveq   #1,D6
            tst.w   D3
            beq.w   .L9
            moveq   #2,D6
            cmpi.w  #$A,D3
            bne.w   .L9
            moveq   #3,D6
            tst.w   D4
            beq.w   .L9
            moveq   #4,D6
            cmpi.w  #$80,D4
            bmi.w   .L9
            moveq   #5,D6
            cmpi.w  #$D0,D4
            bpl.w   .L9
            moveq   #6,D6
            tst.w   D5
            beq.w   .L9
            moveq   #7,D6
            cmpi.w  #1,D5
            bne.w   .L9
            moveq   #8,D6
            moveq   #-1,D0
.L4:
            tst.b   ($800,A2)
            dbne    D0,.L4
            beq.w   .L9
            moveq   #9,D6
            moveq   #-1,D0
.L5:
            tst.b   ($1000,A2)
            dbne    D0,.L5
            beq.w   .L9
            andi.b  #$1F,($1600,A2)
            move.b  #$62,($1A00,A2)
            move.b  #$E2,($1C00,A2)
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            move.b  #$FF,($A00,A2)
            move.b  #$FF,($1200,A2)
            move.b  #$FF,($800,A2)
            move.b  #$FF,($1000,A2)
            move.b  #4,($A00,A2)
            move.b  #$1F,($1200,A2)
            move.l  #$F0000,D0
            move    #$2000,SR
.L6:
            cmpi.w  #$A,D3
            beq.b   .L7
            subq.l  #1,D0
            bne.b   .L6
.L7:
            ori     #$700,SR
            moveq   #$A,D6
            tst.w   D3
            beq.b   .L9
            moveq   #$B,D6
            tst.w   D4
            beq.b   .L9
            moveq   #$C,D6
            cmpi.w  #1,D4
            bne.b   .L9
            moveq   #$D,D6
            tst.w   D5
            beq.b   .L9
            moveq   #$E,D6
            cmpi.w  #1,D5
            bne.b   .L9
            moveq   #$F,D6
            moveq   #-1,D0
.L8:
            tst.b   ($1000,A2)
            dbne    D0,.L8
            beq.b   .L9
            clr.w   D6
.L9:
            andi.b  #$1F,($1600,A2)
            ori     #$700,SR
            movec   VBR,A2
            adda.w  #$64,A2
            move.l  (SP)+,(A2)
            move.l  D1,D0
            bsr.w   RestoreInts
            RTS6
LocalVIA1Int:
            move.l  D0,-(SP)
            move.b  ($1A00,A2),D0
            andi.b  #$62,D0
            move.b  D0,($1A00,A2)
            btst    #$12,D1
            beq.b   .L1
            move.w  ($202,A1),D2
            btst    #$A,D2
            beq.b   .L3
            clr.b   ($207,A1)
            bra.b   .L2
.L1:
            btst    #1,D0
            beq.b   .L3
.L2:
            addq.w  #1,D3
.L3:
            btst    #6,D0
            beq.b   .L4
            addq.w  #1,D4
.L4:
            btst    #5,D0
            beq.b   .L5
            addq.w  #1,D5
.L5:
            move.l  (SP)+,D0
            rte
TestSCSI:
            btst    #8,D0
            beq.w   .L2
            movea.l (8,A0),A2
            movea.l ($20,A0),A0
            movea.l A0,A1
            adda.w  #0,A1
            move.b  #$80,($10,A1)
            moveq   #0,D0
            move.b  D0,($10,A1)
            tst.b   ($70,A0)
            moveq   #1,D6
            move.b  #$80,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #$80,D1
            bne.w   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #$80,D1
            cmpi.b  #$80,D1
            bne.w   .L1
            clr.b   ($10,A1)
            addq.w  #1,D6
            tst.b   ($1C00,A2)
            tst.b   ($1A00,A2)
            move.b  #$10,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #$10,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($50,A0),D1
            andi.b  #1,D1
            cmpi.b  #1,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #8,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #8,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #$40,D1
            cmpi.b  #$40,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #4,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #4,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #2,D1
            cmpi.b  #2,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #2,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #2,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($50,A0),D1
            andi.b  #2,D1
            cmpi.b  #2,D1
            bne.b   .L1
            moveq   #0,D6
.L1:
            RTS6
.L2:
            moveq   #-1,D6
            RTS6
TestASC:
            btst    #$C,D0
            beq.w   sub_40847FC4.L12
            movem.l D0-D5/A0-A4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            movea.l (8,A0),A2
            movea.l ($30,A0),A1
            move.b  ($800,A1),D3
            andi.b  #$F0,D3
            cmpi.b  #$E0,D3
            bne.b   .L1
            lea     sub_40847FC4.L8,A4
            lea     sub_40847FC4.L9,A3
            bra.b   .L5
.L1:
            cmpi.b  #$B0,D3
            bne.b   .L2
            lea     sub_40847FC4.L6,A4
            lea     sub_40847FC4.L7,A3
            bra.b   .L5
.L2:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L3
            lea     sub_40847FC4.L2,A4
            lea     sub_40847FC4.L4,A3
            bra.b   .L5
.L3:
            lea     sub_40847FC4.L10,A4
            lea     sub_40847FC4.L11,A3
            move.b  #$1C,($806,A1)
            move.b  ($806,A1),D3
            andi.b  #$1C,D3
            bne.b   .L5
            lea     sub_40847FC4.L3,A4
            lea     sub_40847FC4.L5,A3
            bra.b   .L5
.L4:
            addq.l  #2,A4
.L5:
            move.l  (A4)+,D3
            bmi.b   .L7
            subq.w  #1,D3
.L6:
            swap    D3
            move.b  (A3)+,D4
            move.b  D4,(0,A1,D3.w)
            tst.b   (A2)
            move.b  (0,A1,D3.w),D5
            and.w   (A4),D5
            swap    D3
            cmp.b   D4,D5
            dbne    D3,.L6
            beq.b   .L4
            swap    D3
            move.l  #$10000,D6
            move.w  D3,D6
            bra.w   .L17
.L7:
            cmpi.b  #7,D2
            beq.w   .L17
            move.b  #2,($801,A1)
            clr.b   ($80A,A1)
            clr.b   ($806,A1)
            clr.b   D5
.L8:
            move.w  #$7FF,D4
            movea.l A1,A2
.L9:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  D3,(A2)+
            dbra    D4,.L9
            movea.l A1,A2
            move.w  #$7FF,D4
.L10:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  (A2)+,D1
            cmp.b   D3,D1
            bne.b   .L11
            dbra    D4,.L10
            cmpi.b  #$FF,D5
            beq.b   .L12
            move.b  #$FF,D5
            bra.b   .L8
.L11:
            move.l  #$20000,D6
            move.w  A2,D6
            andi.w  #$7FF,D6
            bra.w   .L17
.L12:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L17
            move.b  ($800,A1),D3
            andi.b  #$F0,D3
            cmpi.b  #$B0,D3
            beq.b   .L17
            move.b  #$81,($80A,A1)
            move.b  #$80,($803,A1)
            clr.b   ($803,A1)
            clr.b   D5
.L13:
            move.w  #$3FF,D4
            movea.l A1,A2
.L14:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  D3,(A2)+
            dbra    D4,.L14
            movea.l A1,A2
            move.w  #$3FF,D4
.L15:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  (A2)+,D1
            cmp.b   D3,D1
            bne.b   .L16
            dbra    D4,.L15
            cmpi.b  #$FF,D5
            beq.b   .L17
            move.b  #$FF,D5
            bra.b   .L13
.L16:
            move.l  #$30000,D6
            move.w  A2,D6
            andi.w  #$3FF,D6
.L17:
            bsr.b   sub_40847FC4
            btst    #$B,D0
            beq.b   .L18
            movea.l ($2C,A0),A2
            ori.b   #$90,($1C00,A2)
.L18:
            btst    #$D,D0
            beq.b   .L19
            movea.l ($34,A0),A2
            ori.b   #$90,(3,A2)
.L19:
            move    (SP)+,SR
            movem.l (SP)+,D0-D5/A0-A4
            RTS6
sub_40847FC4:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L1
            move.b  #1,($80A,A1)
            tst.b   ($804,A1)
            clr.b   ($80A,A1)
.L1:
            move.b  #1,($801,A1)
            clr.b   ($802,A1)
            move.b  #$80,($803,A1)
            clr.b   ($803,A1)
            tst.b   ($804,A1)
            clr.b   ($805,A1)
            clr.b   ($806,A1)
            clr.b   ($807,A1)
            clr.b   ($80F,A1)
            rts
.L2:
            dc.w    $080A,$0008,$0083
.L3:
            dc.w    $0801,$0004,$00FF,$0802,$000D,$007F,$0803,$0003
            dc.w    $00FF,$0804,$0006,$00FF,$0805,$000C,$00FF,$0807
            dc.w    $0004,$00FF,$FFFF,$FFFF,$FFFF
.L4:
            dc.w    $0001,$0203,$8182,$8300
.L5:
            dc.w    $0001,$0200,$0001,$0204,$0810,$1E1D,$1B17,$0F1F
            dc.w    0,$8000,$0001,$0204,$0800,$0080,$0102,$0408
            dc.w    $070B,$0D0E,$0F00,$0002,$0300
.L6:
            dc.w    $0801,$0003,$0003,$0806,$0008,$00E0,$080A,$0003
            dc.w    $0001,$0F08,$0009,$00FF,$0F28,$0009,$00FF,$FFFF
            dc.w    $FFFF,$FFFF
.L7:
            dc.w    $0001,0,$2040,$6080,$A0C0,$E000,$0100,$0001
            dc.w    $0203,$8081,$8283,0,$0102,$0380,$8182,$8300
.L8:
            dc.w    $0801,$0001,$00FF,$0802,$0001,$007F,$0806,$0008
            dc.w    $00FF,$080A,$0005,$00FF,$FFFF,$FFFF,$FFFF
.L9:
            dc.w    $0101,$0020,$4060,$80A0,$C0E0,$0001,$0203,0
.L10:
            dc.w    $0801,$0004,$00FF,$0802,$0005,$007F,$0803,$0009
            dc.w    $00FF,$0804,$0006,$00FF,$0805,$000C,$00FF,$0807
            dc.w    $0004,$00FF,$FFFF,$FFFF,$FFFF
.L11:
            dc.w    $0001,$0200,$0001,$0203,0,$0102,$8003,$8182
            dc.w    $8300,$0001,$0204,$0800,$0080,$0102,$0408,$070B
            dc.w    $0D0E,$0F00,$0002,$0300
.L12:
            moveq   #-1,D6
            RTS6
PramTest:
            move.l  A6,-(SP)
            movea.l (8,A0),A2
            move.l  #$FF,D3
            movea.l SP,A3
            lea     (-$100,SP),SP
.L1:
            move.l  A3,-(SP)
            move.l  D3,D1
            BSR6    RdXByte
            movea.l (SP)+,A3
            move.b  D1,-(A3)
            dbra    D3,.L1
            BSR6    CLKWPOFF
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            BSR6    WrXByte
            clr.w   -(SP)
            move.w  #$7F,-(SP)
            bsr.w   PRAMParamTest
            lea     (4,SP),SP
            tst.l   D6
            bne.b   .L2
            bsr.w   RestoreallPRAM
            move.l  #$7C00FC,D1
            moveq   #0,D2
            BSR6    WrXByte
            move.w  #$80,-(SP)
            move.w  #$FF,-(SP)
            bsr.w   PRAMParamTest
            lea     (4,SP),SP
.L2:
            bsr.w   RestoreallPRAM
            lea     ($100,SP),SP
            rts
RestoreallPRAM:
            lea     (4,SP),A3
            moveq   #0,D3
.L1:
            move.b  (A3)+,D2
            move.l  D3,D1
            move.l  A3,-(SP)
            BSR6    WrXByte
            movea.l (SP)+,A3
            addq.w  #1,D3
            cmpi.w  #$100,D3
            bne.b   .L1
            rts
PRAMParamTest:
            moveq   #0,D6
            move.w  (6,SP),D3
.L1:
            move.w  D3,D1
            move.w  #$A5,D2
            BSR6    WrXByte
            move.w  D3,D1
            BSR6    RdXByte
            cmpi.b  #$A5,D1
            beq.b   .L2
            move.b  D3,D6
            rol.l   #8,D6
            move.b  #$A5,D6
            rol.l   #8,D6
            move.b  D1,D6
            bra.b   .L3
.L2:
            addq.w  #1,D3
            cmp.w   (4,SP),D3
            ble.b   .L1
.L3:
            rts
TestRBV:
            move    #0,CCR
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            btst    #$D,D0
            beq.w   .L20
            movea.l ($34,A0),A0
            lea     .L17,A2
            lea     .L18,A3
            move.l  ($1C,A1),D1
            btst    #7,D1
            beq.b   .L1
            lea     .L19,A3
.L1:
            moveq   #0,D1
            move.b  (A2)+,D1
            bmi.w   .L7
            move.b  (A3)+,D2
            moveq   #-1,D4
            move.b  (0,A0,D1.w),-(SP)
.L2:
            move.b  D4,D3
            tst.b   D1
            bne.b   .L3
            ori.b   #$D,D4
.L3:
            and.b   D2,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            cmp.b   D4,D5
            bne.w   .L6
            move.b  D3,D4
            roxr.b  #1,D4
            cmpi.b  #$FF,D4
            bne.b   .L2
            roxr.b  #1,D4
            clr.b   D4
.L4:
            move.b  D4,D3
            tst.b   D1
            bne.b   .L5
            ori.b   #$D,D4
.L5:
            and.b   D2,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            cmp.b   D4,D5
            bne.w   .L6
            move.b  D3,D4
            roxr.b  #1,D4
            bne.b   .L4
            roxr.b  #1,D4
            move.b  (SP)+,(0,A0,D1.w)
            bra.b   .L1
.L6:
            move.b  (SP)+,(0,A0,D1.w)
            bra.w   .L15
.L7:
            move.b  (A2)+,D1
            bmi.w   .L16
            move.b  (0,A0,D1.w),-(SP)
            move.b  (A3)+,D2
            move.b  D2,(0,A0,D1.w)
            moveq   #1,D4
.L8:
            addi.w  #$80,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            bclr    #7,D4
            move.b  D4,D3
            and.b   D2,D3
            cmp.b   D3,D5
            beq.w   .L9
            move.b  D3,D4
            bra.w   .L14
.L9:
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            tst.b   D5
            beq.w   .L10
            clr.b   D4
            bra.w   .L14
.L10:
            rol.b   #1,D4
            cmpi.b  #$80,D4
            bne.b   .L8
            moveq   #1,D4
.L11:
            move.b  #$FF,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            bclr    #7,D5
            cmp.b   D2,D5
            beq.w   .L12
            move.b  D2,D4
            bra.w   .L14
.L12:
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            eori.b  #$FF,D5
            and.b   D2,D5
            move.b  D4,D3
            and.b   D2,D3
            cmp.b   D3,D5
            beq.w   .L13
            move.b  D3,D4
            bra.w   .L14
.L13:
            rol.b   #1,D4
            cmpi.b  #$80,D4
            bne.b   .L11
            move.b  D2,(0,A0,D1.w)
            move.b  (SP)+,D0
            ori.b   #$C0,D0
            move.b  D0,(0,A0,D1.w)
            bra.w   .L7
.L14:
            move.b  D2,(0,A0,D1.w)
            move.b  (SP)+,D0
            ori.b   #$C0,D0
            move.b  D0,(0,A0,D1.w)
.L15:
            move.b  D1,D6
            rol.l   #8,D6
            move.b  D4,D6
            rol.l   #8,D6
            move.b  D5,D6
.L16:
            RTS6
.L17:
            dc.w    $0010,$11FF,$1213,$FF00
.L18:
            dc.w    $8FC3,$FF7F,$1F00
.L19:
            dc.w    $0802,$0078,$7F00
.L20:
            moveq   #-1,D6
            RTS6
TestSWIM:
            btst    #5,D0
            bne.b   .L1
            moveq   #-1,D6
            RTS6
.L1:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l (8,A0),A2
            movea.l ($14,A0),A0
            lea     ($1E00,A2),A2
            tst.b   ($1400,A0)
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            moveq   #-9,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            bra.w   .L3
.L2:
            moveq   #-2,D6
            bra.w   .L32
.L3:
            moveq   #0,D6
            lea     .L33,A1
            move.w  #$F,D1
.L4:
            move.b  (0,A1,D1.w),($800,A0)
            nop
            move.b  ($1800,A0),D0
            cmp.b   (0,A1,D1.w),D0
            bne.w   .L20
            dbra    D1,.L4
            link.w  A4,#-$10
            move.b  ($1A00,A0),D4
            clr.b   ($A00,A0)
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L5:
            move.b  (A2),(A2)
            move.b  ($1600,A0),(0,SP,D1.w)
            dbra    D1,.L5
            lea     .L34,A1
            move.w  #4,D2
.L6:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
            moveq   #0,D0
.L7:
            move.b  (A2),(A2)
            move.b  (0,A1,D1.w),($600,A0)
            dbra    D1,.L7
            dbra    D2,.L6
            lea     .L35,A1
            move.b  #$38,($C00,A0)
            moveq   #0,D0
            moveq   #0,D2
            move.w  #$F,D1
            move.b  (A2),(A2)
.L8:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   (0,A1,D1.w),D0
            bne.w   .L21
            dbne    D1,.L8
            moveq   #0,D0
            moveq   #7,D2
            moveq   #1,D3
.L9:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L10:
            move.b  (A2),(A2)
            move.b  D3,($600,A0)
            dbra    D1,.L10
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L11:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   D3,D0
            bne.w   .L22
            dbra    D1,.L11
            rol.w   #1,D3
            dbra    D2,.L9
            moveq   #0,D0
            move.l  #$FF,D2
.L12:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L13:
            move.b  (A2),(A2)
            move.b  D2,($600,A0)
            dbra    D1,.L13
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L14:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   D2,D0
            bne.w   .L23
            dbra    D1,.L14
            dbra    D2,.L12
            BSR5    .L18
            move.b  ($1A00,A0),D3
            move.w  #7,D1
            moveq   #1,D2
.L15:
            move.b  D2,($A00,A0)
            move.b  ($1A00,A0),D0
            cmp.b   D2,D0
            bne.w   .L24
            rol.w   #1,D2
            dbra    D1,.L15
            move.b  D3,($A00,A0)
            move.b  ($1C00,A0),D3
            move.w  #7,D1
            move.b  #$BF,($C00,A0)
            move.b  ($1C00,A0),D0
            andi.b  #$BF,D0
            bne.w   .L25
.L16:
            moveq   #0,D2
            bset    D1,D2
            move.b  D2,($E00,A0)
            move.b  ($1C00,A0),D0
            btst    D1,D0
            beq.w   .L26
            cmpi.b  #6,D1
            beq.b   .L17
            move.b  D2,($C00,A0)
            move.b  ($1C00,A0),D0
            andi.b  #$BF,D0
            bne.w   .L25
.L17:
            dbra    D1,.L16
            jmp     .L28
.L18:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L19:
            move.b  (A2),(A2)
            move.b  (0,SP,D1.w),($600,A0)
            dbra    D1,.L19
            move.b  D4,($A00,A0)
            unlk    A4
            RTS5
.L20:
            move.b  ($1800,A0),D6
            ori.w   #$100,D6
            swap    D6
            or.b    (0,A1,D1.w),D6
            bra.w   .L31
.L21:
            move.b  (0,A1,D1.w),D2
            move.b  D0,D6
            ori.w   #$200,D6
            swap    D6
            or.w    D2,D6
            lea     .L31,A5
            jmp     .L18
.L22:
            move.b  D0,D6
            ori.w   #$300,D6
            swap    D6
            or.w    D3,D6
            lea     .L31,A5
            jmp     .L18
.L23:
            move.b  D0,D6
            ori.w   #$400,D6
            swap    D6
            or.w    D2,D6
            lea     .L31,A5
            jmp     .L18
.L24:
            move.b  D0,D6
            ori.w   #$500,D6
            swap    D6
            or.w    D2,D6
            move.b  D3,($A00,A0)
            jmp     .L31
.L25:
            move.b  D0,D6
            ori.w   #$600,D6
            swap    D6
            ori.w   #0,D6
            jmp     .L28
.L26:
            move.b  D0,D6
            ori.w   #$700,D6
            swap    D6
            or.w    D2,D6
            jmp     .L28
.L27:
            move.b  ($1C00,A0),D6
            ori.w   #$800,D6
            swap    D6
            or.w    D3,D6
            jmp     .L31
.L28:
            move.w  #7,D1
.L29:
            moveq   #0,D2
            btst    D1,D3
            beq.b   .L30
            bset    D1,D2
            move.b  D2,($E00,A0)
.L30:
            dbra    D1,.L29
            cmp.b   ($1C00,A0),D3
            bne.b   .L27
.L31:
            move.b  #$F8,($C00,A0)
.L32:
            tst.b   ($1C00,A0)
            tst.b   ($1800,A0)
            move    (SP)+,SR
            RTS6
.L33:
            dc.w    $F0F1,$F2F3,$F4F5,$F6F7,$F8F9,$FAFB,$FCFD,$FEFF
.L34:
            dc.w    $FFEE,$DDCC,$BBAA,$9988,$7766,$5544,$3322,$1100
.L35:
            dc.w    $FFEC,$DDCC,$BBAA,$9988,$7766,$5544,$3322,$1100
Float_Test:
            move.w  ($10,A1),D3
            btst    #$C,D3
            bne.b   .FPUInstalled
            moveq   #-1,D6
            RTS6
.FPUInstalled:
            move    SR,-(SP)
            movem.l D2/D7,-(SP)
            ori     #$700,SR
            link.w  A6,#-$640
            moveq   #1,D6
            moveq   #0,D5
            moveq   #0,D7
            move.w  #$FF,D0
            movec   VBR,A0
            movea.l A0,A5
            lea     (-$400,A6),A1
            movea.l A1,A2
.FTB1:
            move.l  (A0)+,(A1)+
            dbra    D0,.FTB1
            lea     .FPC_EHND,A0
            move.l  A0,($1C,A2)
            move.l  A0,($C0,A2)
            move.l  A0,($C4,A2)
            move.l  A0,($C8,A2)
            move.l  A0,($CC,A2)
            move.l  A0,($D0,A2)
            move.l  A0,($D4,A2)
            move.l  A0,($D8,A2)
            lea     .PM_EXCPT,A0
            move.l  A0,($2C,A2)
            move.l  A0,($34,A2)
            move.l  A0,($38,A2)
            movec   A2,VBR
            addq.w  #1,D6                           ; Subtest #2
            lea     .CP_PRES,A0
            moveq   #$B,D7
            fmove.l D0,FP0
.CP_PRES:
            tst.b   D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            lea     (-$514,A6),A4
            addq.w  #1,D6                           ; Subtest #3
            lea     .MOVLNGCR,A0
            fmove.l (A0),FPCR
            fmove.l FPCR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #4
            lea     .MOVLNG1,A0
            fmove.l (A0),FPIAR
            fmove.l FPIAR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG2,A0
            fmove.l (A0),FPIAR
            fmove.l FPIAR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG1,A0
            fmove.l (A0),FP0
            fmove.l FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG2,A0
            fmove.l (A0),FP0
            fmove.l FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVWD,A0
            fmove.w (A0),FP1
            fmove.w FP1,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVBT,A0
            fmove.b (A0),FP2
            fmove.b FP2,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVSGL,A0
            fmove.s (A0),FP3
            fmove.s FP3,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVDBL,A0
            fmove.d (A0),FP4
            fmove.d FP4,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVEXT,A0
            fmove.x (A0),FP5
            fmove.x FP5,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVBCDW,A0
            fmove.p (A0),FP6
            lea     .MOVBCDSR,A0
            fmove.p FP6,(A4){3}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            moveq   #-5,D2
            lea     .MOVBCDW,A0
            fmove.p (A0),FP7
            lea     .MOVBCDDR,A0
            fmove.p FP7,(A4){D2}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmovecr.x #0,FP0
            lea     .PI,A0
            fmove.p FP0,(A4){-7}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVMEXT,A0
            movea.l A0,A2
            lea     (-$4FC,A6),A4
            fmovem.x (A2)+,FP2/FP7
            fmovem.x FP2/FP7,-(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #17
            lea     (-$514,A6),A2
            clr.l   -(A2)
            frestore (A2)+
            fmovem.l FPCR/FPSR/FPIAR,-(A2)
            moveq   #2,D0
.FSRB1:
            tst.l   (A2)+
            dbne    D0,.FSRB1
            bne.w   .FAIL
            fmovem.x FP0-FP7,-(A2)
            moveq   #7,D0
            lea     .NAN,A1
.FSRB2:
            movea.l A1,A0
            cmpm.l  (A0)+,(A2)+
            bne.b   .FSRB3
            cmpm.l  (A0)+,(A2)+
            bne.b   .FSRB3
            cmpm.l  (A0)+,(A2)+
.FSRB3:
            dbne    D0,.FSRB2
            bne.w   .FAIL
            clr.l   -(A2)
            frestore (A2)
            fsave   -(A2)
            tst.b   (A2)
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
; Subtest #18
; Test the busy state FSAVE/FRESTORE
            addq.w  #1,D6                           ; Subtest #18
            lea     (-$514,A6),A2                   ; Get some stack space
            fmove.x .BIGNUM,FP0                     ; Get big number
            frem.x  .SMALLNUM,FP0                   ; Divide by small and calculate remainder
            fsave   -(A2)                           ; Cause busy state save
            clr.l   -(A2)                           ; Set format word for null
            frestore (A2)+
            frestore (A2)+
            lea     .FREMRSLT,A0
            lea     (-$514,A6),A4
            fmove.x FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #19
            lea     (-$514,A6),A2
            moveq   #$B,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .XDENORM,FP1
            fsave   -(A2)
            fmovem.l FPCR/FPSR,-(A2)
            clr.l   -(A2)
            frestore (A2)+
            fnop
            tst.b   D5
            bne.w   .FAIL
            fmovem.l (A2)+,FPCR/FPSR
            frestore (A2)+
            tst.b   D5
            bne.w   .FAIL
            moveq   #$33,D7
            fnop
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #20
            fmove.x .SGLNAN,FP0
            fadd.x  .SGLNAN,FP0
            moveq   #$E,D0
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #21
            moveq   #$F,D0
            fmove.x .SGLNAN,FP1
            fblt.w  .CKBSUN
.CKBSUN:
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #22
            moveq   #$A,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .ONE_X,FP2
            fdiv.x  .ZERO_X,FP2
            tst.b   D5
            bne.w   .FAIL
            moveq   #$32,D7
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #23
            moveq   #$C,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .BIGNO,FP3                      ; Move in an almost overflow number
            fmul.x  .BIGNO,FP3
            tst.b   D5
            bne.w   .FAIL
            moveq   #$35,D7
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            addq.w  #1,D6                           ; Subtest #24
            fmove.x .EXTNO,FP3
            tst.b   D5
            bne.w   .FAIL
            fmove.s FP3,(A4)
            cmpi.b  #1,D5
            bne.w   .FAIL
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #25
            moveq   #$B,D0
            fmove.x .SMALLNO,FP4
            fmul.x  .SMALLNO,FP4
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #26
            moveq   #9,D0
            fmove.x .MULOPRND,FP5
            fmul.x  .TINYNO,FP5
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5                              ; Did unexpected exception occur?
            bne.w   .FAIL                           ; Yes, failed
; Subtest #27
; Test status register oper bit
            addq.w  #1,D6                           ; Subtest #27
            moveq   #$D,D0                          ; Set bit test for operand error
            bsr.w   .SET_FPCR_BIT                   ; Enable operand error exception
            fsqrt.x .MINUS_X,FP6                    ; Cause an operand error
            tst.b   D5                              ; Did an unexpected exception occur?
            bne.w   .FAIL                           ; Yes, failed
            moveq   #$34,D7                         ; Expected exception number
            bsr.w   .CK_FPSTAT                      ; Is oper bit set
            beq.w   .FAIL                           ; No, failed
            cmpi.b  #1,D5                           ; Did expected exception occur
            bne.w   .FAIL                           ; No, failed
            moveq   #0,D5                           ; Clear exception pass/fail flag
            moveq   #0,D7                           ; Set exception vector to none expected
            fmove.l D7,FPCR                         ; Disable all FPC exceptions
            addq.w  #1,D6
            fmovecr.x #$C,FP0
            ftrapeq
            tst.b   D5
            bne.w   .FAIL
            moveq   #7,D7
            fmovecr.x #$F,FP1
            ftrapeq
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6
            fmovecr.x #0,FP0
            fmove.x FP0,FP1
            fadd.x  FP1,FP0
            fmul.x  #"$400040008000000000000000",FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmovecr.x #0,FP0
            fmove.x FP0,FP1
            fmove.x .ONE_X,FP2
            fmove.x FP2,FP3
            fdiv.x  #"$40004000C000000000000000",FP2
            fdiv.x  #"$40014001C000000000000000",FP3
            fmul.x  FP2,FP0
            fmul.x  FP3,FP1
            fsin.x  FP0,FP0
            fcos.x  FP1,FP1
            fmove.s FP0,D0
            fmove.s FP1,D1
            fmove.s D0,FP0
            fmove.s D1,FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            fsqrt.x #"$40004000C000000000000000",FP4
            fdiv.x  #"$400040008000000000000000",FP4
            fmove.s FP4,D2
            fmove.s D2,FP4
            fcmp.x  FP1,FP4
            fbne.w  .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmove.x .ONE_X,FP5
            fmove.x FP5,FP0
            fmovecr.x #0,FP6
            fdiv.x  #"$400140018000000000000000",FP5
            fmul.x  FP6,FP5
            ftan.x  FP5,FP5
            fdiv.x  #"$400040008000000000000000",FP0
            fmul.x  FP6,FP0
            fsin.x  FP0,FP0
            fmove.s FP0,D0
            fmove.s FP5,D1
            fmove.s D0,FP0
            fmove.s D1,FP5
            fcmp.x  FP0,FP5
            fbne.w  .FAIL
            tst.b   D5
            bne.b   .FAIL
            addq.w  #1,D6
            fmove.x #"$3FF83FF8A3D70A3D70A3D70B",FP0
            fmove.x FP0,FP1
            flog10.x FP1,FP1
            ftentox.x FP1,FP1
            fmove.s FP0,D0
            fmove.s FP1,D1
            fmove.s D0,FP0
            fmove.s D1,FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            tst.b   D5
            bne.b   .FAIL
            move.l  D6,D0
            moveq   #0,D6
            bra.b   .FPUFinish
.FAIL:
            move.l  D6,D0
.FPUFinish:
            moveq   #0,D2
            cmpi.b  #2,D0
            bls.b   .NO_FPU
            lea     (-$514,A6),A2
            clr.l   -(A2)
            frestore (A2)+
            fsave   -(A2)
            move.w  #1,D2
            move.b  (1,A2),D1
            cmpi.b  #$18,D1
            beq.b   .FL881
            addq.w  #1,D2
.FL881:
            swap    D2
.NO_FPU:
            or.l    D2,D0
            movea.l A5,A0
            movec   A0,VBR
            unlk    A6
            movem.l (SP)+,D2/D7
            cmpi.b  #2,D6
            bne.b   .FPUrtn
            move.w  D2,D1
            lsr.w   #8,D1
            lea     .FPUOptnBox,A0
.OptnLoop:
            move.b  (A0)+,D3
            cmpi.b  #$FD,D3
            beq.b   .FPUrtn
            cmp.b   D3,D1
            bne.b   .OptnLoop
            moveq   #-1,D6
.FPUrtn:
            move    (SP)+,SR
            RTS6
.FPUOptnBox:
            dc.w    $0C0D,$0FFD
.CK_FPSTAT:
            fmove.l FPSR,D1
            btst    D0,D1
            rts
.SET_FPCR_BIT:
            fmove.l FPCR,D1
            bset    D0,D1
            fmove.l D1,FPCR
            rts
.VER_DAT:
            movem.l D0/A4,-(SP)
            move.w  (-2,A0),D0
            subq.w  #1,D0
.VD1:
            cmpm.b  (A0)+,(A4)+
            dbne    D0,.VD1
            beq.b   .VD2
            moveq   #1,D0
.VD2:
            movem.l (SP)+,D0/A4
            rts
.FPC_EHND:
            move.l  D0,-(SP)
            fsave   -(SP)
            move.b  (SP),D0
            beq.w   .NULL
            moveq   #0,D0
            move.b  (1,SP),D0
            bset    #3,(0,SP,D0.w)
.NULL:
            frestore (SP)+
            moveq   #1,D5
            tst.b   D7
            beq.b   .FE1
            move.w  ($A,SP),D0
            andi.w  #$FFF,D0
            lsr.w   #2,D0
            cmp.b   D7,D0
            beq.b   .FE2
.FE1:
            moveq   #2,D5
.FE2:
            move.l  (SP)+,D0
            rte
.PM_EXCPT:
            moveq   #1,D5
            moveq   #$A,D1
            move.w  (6,SP),D0
            lsr.w   #2,D0
            cmp.b   D0,D7
            bne.b   .PE1
            lsr.w   D1,D0
            tst.b   D0
            bne.b   .PE2
            move.l  A0,(2,SP)
            bra.b   .PE3
.PE2:
            move.l  A0,(8,SP)
.PE3:
            rte
.PE1:
            lsr.w   D1,D0
            tst.b   D0
            bne.b   .PE4
            addq.l  #8,SP
            bra.b   .PE5
.PE4:
            adda.w  #$14,SP
.PE5:
            addi.w  #$1000,D6
            bra.w   .FAIL
.XDENORM:
            dc.w    $0000,$0000
            dc.w    $7FFF,$FFFF,$FFFF,$FFFF
.BIGNUM:
            dc.w    $7FFD,0,$E35F,$A931,$A000,0
.SMALLNUM:
            dc.w    $9001,0,$ABCC,$7711,$8461,$CEFD
.SGLNAN:
            dc.w    $7FFF,0,$00A0,$A0A0
            ds.b    4
.ZERO_X:
            ds.b    12
.ONE_X:
            dc.b    $3F,$FF,$3F,$FF,$80
            ds.b    7
.MINUS_X:
            dc.b    $BF,$FF,$BF,$FF,$80
            ds.b    7
.EXTNO:
            dc.w    $7FFE,0,$89AB,$CDEF,$0123,$4567
.BIGNO:
            dc.w    $7FFE,0,$8000,$1020
            ds.b    4
.SMALLNO:
            dc.w    $0002,0,$8000,$0001
            ds.b    4
.MULOPRND:
            dc.b    $3F,$FF,$00,$00,$C0
            ds.b    4
            dc.b    $01,$73,$A1
.TINYNO:
            dc.b    $3F,$FF,$00,$00,$80
            ds.b    6
            dc.b    $01,$00,$0C
.FREMRSLT:
            dc.w    $9000,0,$A0AC,$F842,$FB63,$6FFC,$000C
.NAN:
            dc.w    $7FFF,0,$FFFF,$FFFF,$FFFF,$FFFF,$0004
.MOVLNGCR:
            ds.b    5
            dc.b    $04
.MOVLNG1:
            dc.w    $5555,$5555,$0004
.MOVLNG2:
            dc.w    $AAAA,$AAAA,$0002
.MOVWD:
            dc.w    $5555,$0001
.MOVBT:
            dc.w    $AA00,$0004
.MOVSGL:
            dc.w    $4CEB,$79A3,$0008
.MOVDBL:
            dc.w    $437B,$69B4,$BACD,$05F1,$000C
.MOVEXT:
            dc.w    $4055,0,$CC3D,$FBE5,$C763,$3EF5,$000C
.MOVEXT2:
            ds.b    12
.MOVBCDW:
            dc.b    $00,$04,$00,$01,$23,$45,$67,$87,$65
            ds.b    4
            dc.b    $0C
.MOVBCDSR:
            dc.b    $00,$04,$00,$01,$23
            ds.b    8
            dc.b    $0C
.MOVBCDDR:
            dc.b    $00,$04,$00,$01,$23,$45,$67,$87,$70
            ds.b    4
            dc.b    $0C
.PI:
            dc.w    0,$0003,$1415,$9270
            ds.b    5
            dc.b    $18
.MOVMEXT:
            dc.w    $4055,0,$CC3D,$FBE5,$C763,$3EF5
            ds.b    12
TestPGC:
            btst    #$D,D0
            beq.b   .L6
            btst    #$12,D7
            beq.b   .L6
            movea.l (8,A0),A2
            movea.l ($34,A0),A3
            move.l  A6,-(SP)
            movea.l SP,A5
            bset    #$1B,D7
            move.l  #'PGCp',D0
            moveq   #$1F,D5
            moveq   #1,D4
            lea     (-4,SP),A4
            bclr    #6,(A2)
.L1:
            lea     .L2,A6
            bclr    #7,(A3)
            tst.b   (A2)
            move.l  D4,(A4)
            tst.l   (A4)
            bra.b   .L4
.L2:
            lea     .L3,A6
            bset    #7,(A3)
            tst.b   (A2)
            tst.l   (A4)
            bra.b   .L4
.L3:
            lea     .L4,A6
            move.l  D4,(A4)
            tst.l   (A4)
            rol.l   #1,D4
            dbra    D5,.L1
            moveq   #0,D6
            bra.b   .L5
.L4:
            moveq   #$10,D6
            bset    #6,(A2)
            bset    #7,(A3)
            tst.b   (A2)
.L5:
            moveq   #0,D0
            bclr    #$1B,D7
            rts
.L6:
            moveq   #-1,D6
            RTS6
FMCRegTest:
            btst    #$13,D0
            beq.w   .L11
            movea.l A6,A5
            movea.l ($4C,A0),A0
            moveq   #0,D6
            BSR6    .L9
            move.w  D0,D2
.L1:
            move.w  D6,D0
            BSR6    .L7
            move.l  .L2,D0
            bra.b   .L3
.L2:
            dc.w    $FFFF,$FFFF
.L3:
            BSR6    .L9
            cmp.w   D0,D6
            bne.b   .L5
            cmpi.w  #$FFFF,D6
            beq.b   .L4
            asl.w   #1,D6
            ori.w   #1,D6
            bra.b   .L1
.L4:
            moveq   #0,D6
            bra.b   .L6
.L5:
            swap    D6
            move.w  D0,D6
.L6:
            move.w  D2,D0
            BSR6    .L7
            movea.l A5,A6
            RTS6
.L7:
            moveq   #$F,D1
.L8:
            move.b  D0,(A0)
            ror.w   #1,D0
            dbra    D1,.L8
            RTS6
.L9:
            moveq   #0,D0
            moveq   #$F,D1
.L10:
            move.b  (A0),D0
            ror.l   #1,D0
            dbra    D1,.L10
            swap    D0
            RTS6
.L11:
            moveq   #-1,D6
            RTS6
FMCCacheTest:
            btst    #$13,D0
            beq.w   .L19
            movea.l #$8000,A2
            lea     ($40000000.l,A2),A3
            movea.l ($48,A0),A4
            movec   CACR,D4
            move.l  #$1909,D1
            movec   D1,CACR
            move.l  #$8000,D5
.L1:
            subq.l  #4,D5
            bmi.b   .L2
            tst.l   ($8000.l,A3,D5.l)
            bra.b   .L1
.L2:
            move.l  #$8000,D5
.L3:
            subq.l  #4,D5
            bmi.b   .L4
            move.l  (0,A3,D5.l),D3
            not.l   D3
            move.l  D3,(0,A2,D5.l)
            bra.b   .L3
.L4:
            bclr    #3,($204,A4)
            move.l  #$8000,D5
.L5:
            subq.l  #4,D5
            bmi.b   .L6
            tst.l   (0,A2,D5.l)
            bra.b   .L5
.L6:
            andi.l  #$FFFFEEFF,D1
            movec   D1,CACR
            bset    #3,($204,A4)
            move.l  #$8000,D5
.L7:
            subq.l  #4,D5
            bmi.b   .L8
            move.l  (0,A3,D5.l),D3
            cmp.l   (0,A2,D5.l),D3
            bne.w   .L13
            bra.b   .L7
.L8:
            move.l  #$8000,D5
.L9:
            subq.l  #4,D5
            bmi.b   .L10
            move.l  (0,A3,D5.l),D3
            not.l   D3
            move.l  D3,(0,A2,D5.l)
            bra.b   .L9
.L10:
            bclr    #3,($204,A4)
            move.l  #$8000,D5
.L11:
            subq.l  #4,D5
            bmi.b   .L12
            move.l  (0,A3,D5.l),D3
            not.l   D3
            cmp.l   (0,A2,D5.l),D3
            bne.b   .L14
            bra.b   .L11
.L12:
            moveq   #0,D6
            bra.b   .L16
.L13:
            move.l  #$10000000,D6
            bra.b   .L15
.L14:
            move.l  #$20000000,D6
.L15:
            move.w  D5,D6
            nop
.L16:
            bset    #3,($204,A4)
            ori.l   #$1900,D1
            movec   D1,CACR
            move.l  #$8000,D5
.L17:
            subq.l  #4,D5
            bmi.b   .L18
            tst.l   (0,A2,D5.l)
            clr.l   (0,A2,D5.l)
            bra.b   .L17
.L18:
            movec   D4,CACR
            RTS6
.L19:
            moveq   #-1,D6
            RTS6
OSSRegTest:
            btst    #$12,D0
            beq.w   .L10
            move    SR,D5
            ori     #$700,SR
            movea.l ($48,A0),A0
            lea     .L9,A1
            moveq   #0,D6
.L1:
            moveq   #0,D0
            move.l  (A1)+,D2
            beq.b   .L6
            move.w  D2,D4
            swap    D2
            move.b  (0,A0,D2.w),D3
.L2:
            move.b  D0,(0,A0,D2.w)
            move.l  .L3,D1
            bra.b   .L4
.L3:
            dc.w    $FFFF,$FFFF
.L4:
            move.b  (0,A0,D2.w),D1
            ror.w   #8,D4
            and.b   D4,D1
            eor.b   D0,D1
            bne.b   .L7
            ror.w   #8,D4
            cmp.b   D4,D0
            beq.b   .L5
            addq.w  #1,D0
            bra.b   .L2
.L5:
            move.b  D3,(0,A0,D2.w)
            addq.w  #1,D6
            bra.b   .L1
.L6:
            moveq   #0,D6
            bra.b   .L8
.L7:
            move.w  D3,(0,A0,D2.w)
            swap    D6
            move.w  D1,D6
.L8:
            move    D5,SR
            RTS6
.L9:
            dc.w    0,$0706,$0001,$0706,$0002,$0706,$0003,$0706
            dc.w    $0004,$0706,$0005,$0706,$0006,$0706,$0007,$0706
            dc.w    $0008,$0706,$0009,$0706,$000A,$0706,$000B,$0706
            dc.w    $000C,$0706,$000D,$0706,$0204,$1F1F,$0205,$0303
            ds.b    4
.L10:
            moveq   #-1,D6
            RTS6
OSSIntTest:
            btst    #$12,D0
            beq.w   sub_40849142.L1
            move    SR,D5
            andi    #$F8FF,SR
            movea.l ($48,A0),A0
            lea     sub_40849142,A3
            move.b  ($A,A0),D2
            move.b  #6,D6
            movec   VBR,A1
            adda.w  #$78,A1
.L1:
            movea.l (A1),A2
            move.l  A3,(A1)
            move.b  D6,($A,A0)
            move.w  #$8000,D1
            moveq   #0,D0
.L2:
            cmpi.l  #'debi',D0
            beq.b   .L3
            dbra    D1,.L2
            clr.b   ($A,A0)
            move.l  A2,(A1)
            bra.b   .L4
.L3:
            clr.b   ($A,A0)
            move.l  A2,(A1)
            subq.w  #1,D6
            subq.w  #4,A1
            tst.b   D6
            bne.b   .L1
.L4:
            move.b  D2,($A,A0)
            move    D5,SR
            RTS6
sub_40849142:
            clr.b   ($207,A0)
            move.l  #'debi',D0
            rte
.L1:
            moveq   #-1,D6
            RTS6
RPUTest:
            btst    #$14,D0
            beq.b   .L6
            btst    #$12,D7
            beq.b   .L6
            movea.l ($50,A0),A3
            move.l  A6,-(SP)
            movea.l SP,A5
            bset    #$1B,D7
            move.l  #'RPUp',D0
            moveq   #$1F,D5
            moveq   #1,D4
            lea     (-4,SP),A4
.L1:
            st      ($10,A3)
            move.l  (A3),D1
            bset    #$18,D1
            move.l  D1,(A3)
            lea     .L2,A6
            move.l  D4,(A4)
            tst.l   (A4)
            bra.b   .L4
.L2:
            move.l  (A3),D1
            bclr    #$18,D1
            move.l  D1,(A3)
            lea     .L3,A6
            tst.l   (A4)
            bra.b   .L4
.L3:
            lea     .L4,A6
            move.l  D4,(A4)
            tst.l   (A4)
            rol.l   #1,D4
            dbra    D5,.L1
            moveq   #0,D6
            bra.b   .L5
.L4:
            moveq   #$10,D6
            move.l  (A3),D1
            bclr    #$18,D1
            move.l  D1,(A3)
.L5:
            moveq   #0,D0
            bclr    #$1B,D7
            rts
.L6:
            moveq   #-1,D6
            RTS6
EgretTest:
            move.l  A6,-(SP)
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L12
            movea.l (8,A0),A2
            moveq   #1,D6
            btst    #3,(A2)
            beq.w   .L13
            addq.l  #1,D6
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L1:
            btst    #2,($1A00,A2)
            dbne    D0,.L1
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L11
            addq.l  #1,D6
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            beq.w   .L11
            addq.l  #1,D6
            moveq   #$F,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
            move.w  #$FFFF,D0
.L2:
            btst    #2,($1A00,A2)
            beq.b   .L3
            btst    #3,(A2)
            beq.b   .L4
.L3:
            dbra    D0,.L2
            bra.w   .L11
.L4:
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            bset    #5,(A2)
            addq.l  #1,D6
            swap    D6
            move.w  #4,D6
            link.w  A6,#-6
.L5:
            movem.l D6/A6,-(SP)
            BSR6    TM_GetByte
            movem.l (SP)+,D6/A6
            sne     D0
            move.b  D2,(-6,A6,D6.w)
            tst.b   D0
            bne.b   .L6
            dbra    D6,.L5
            swap    D6
            bra.b   .L10
.L6:
            tst.w   D6
            beq.b   .L7
            swap    D6
            bra.b   .L10
.L7:
            swap    D6
            addq.l  #1,D6
            cmpi.b  #$F,(-4,A6)
            bne.w   .L10
            addq.l  #1,D6
            tst.b   (-3,A6)
            beq.b   .L9
            cmpi.b  #3,(-3,A6)
            bne.b   .L8
            moveq   #$E,D0
            and.l   ($1C,A1),D0
            cmpi.w  #6,D0
            bne.b   .L9
.L8:
            moveq   #0,D6
            move.b  (-3,A6),D6
            rol.l   #8,D6
            move.b  (-5,A6),D6
            rol.l   #8,D6
            move.b  (-6,A6),D6
            bset    #$1F,D6
            bra.b   .L10
.L9:
            moveq   #0,D6
.L10:
            unlk    A6
.L11:
            bclr    #4,(A2)
            bclr    #5,(A2)
            BSR6    TM_Wait
            bra.b   .L13
.L12:
            moveq   #-1,D6
.L13:
            rts
TestSndInts:
            btst    #$C,D0
            beq.w   WaitforInt.L2
            movem.l D0-D1/D3-D5/D7/A0-A4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D4
            suba.l  A3,A3
            btst    #$B,D0
            beq.b   .VIA2done
            movea.l ($2C,A0),A3
            move.l  #$1A001C00,D7
.VIA2done:
            btst    #$D,D0
            beq.b   .RBVdone
            movea.l ($34,A0),A3
            move.l  #$30013,D7
.RBVdone:
            moveq   #-1,D6
            cmpa.w  #0,A3
            beq.w   .L22
            moveq   #0,D6
            movea.l A3,A5
            btst    #2,D0
            beq.b   .noVIA1
            movea.l (8,A0),A5
.noVIA1:
            movec   VBR,A4
            move.l  ($68,A4),-(SP)
            lea     IntHdlr,A1
            move.l  A1,($68,A4)
            movea.l ($30,A0),A4
            move.b  (ascVersion,A4),D3
            andi.b  #$F0,D3
            move.b  D3,D6
            swap    D6
            cmpi.b  #batmanSound,D3
            bne.w   .notBatman
            move.w  #$FFFF,D6
            bset    #$1E,D6
.Wait4FIFO:
            tst.b   (A5)
            move.b  (ascFifoInt,A4),D5
            cmpi.b  #$F,D5
            dbeq    D6,.Wait4FIFO
            bne.w   .L21
            bclr    #$1E,D6
            clr.w   D6
            move.b  #1,($F09,A4)
            move.b  #1,($F29,A4)
            clr.b   ($F08,A4)
            clr.b   ($F28,A4)
            move.b  #$3F,($F04,A4)
            move.b  #$DB,($F05,A4)
            move.b  #$3F,($F24,A4)
            move.b  #$DB,($F25,A4)
            bset    #7,($F08,A4)
            bset    #7,($F28,A4)
            clr.b   ($80A,A4)
            clr.b   ($80B,A4)
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            clr.b   (ascChipControl,A4)
            move.b  #1,(ascMode,A4)
            bra.b   .L6
.notBatman:
            move.b  #1,(ascMode,A4)
            clr.b   (ascPlayRecA,A4)
            move.b  #$80,(ascFifoControl,A4)
            clr.b   (ascFifoControl,A4)
            tst.b   (ascFifoInt,A4)
            move.b  #2,(ascChipControl,A4)
            clr.b   (ascWaveOneShot,A4)
            clr.b   (ascVolControl,A4)
            clr.b   (ascClockRate,A4)
.L6:
            move.b  #$90,(0,A3,D7.w)
            move.b  #$6F,(0,A3,D7.w)
            swap    D7
            move.b  #$FF,(0,A3,D7.w)
            cmpi.b  #$E0,D3
            bne.b   .ChanB
            bset    #$1F,D6
            bra.b   .L12
.ChanB:
            lea     (ascFiFoRight,A4),A2
            move.b  #8,D6
            cmpi.b  #$B0,D3
            bne.b   .ChBnotbat
            clr.b   ($F29,A4)
            move.b  #$FF,(0,A3,D7.w)
            move.w  #$3E8,D5
.FillB:
            move.b  D0,(A2)
            dbra    D5,.FillB
.ChBnotbat:
            bsr.w   FIFOFill
            bpl.b   .ChBFIFOFull
            cmpi.b  #$B0,D3
            bne.w   .L21
.ChBFIFOFull:
            lsr.b   #1,D6
            bsr.w   WaitforInt
            bmi.w   .L21
            cmpi.b  #$B0,D3
            bne.b   .L12
            lsl.b   #1,D6
            move.w  #$7FFF,D1
.L11:
            tst.b   (A5)
            move.b  ($804,A4),D5
            and.b   D6,D5
            dbne    D1,.L11
            beq.w   .L21
            ori     #$700,SR
            move.b  #1,($F29,A4)
            clr.b   ($F09,A4)
            move.b  #$FF,(0,A3,D7.w)
            moveq   #0,D4
.L12:
            lea     (A4),A2
            move.b  #2,D6
            move.w  #$3E8,D5
.L13:
            move.b  D0,(A2)
            dbra    D5,.L13
            bsr.w   FIFOFill
            bpl.b   .L14
            btst    #$1F,D6
            bne.b   .L14
            cmpi.b  #$B0,D3
            bne.w   .L21
.L14:
            lsr.b   #1,D6
            bsr.w   WaitforInt
            bmi.w   .L21
            btst    #$1F,D6
            bne.b   .L15
            cmpi.b  #$B0,D3
            bne.b   .L16
.L15:
            lsl.b   #1,D6
            bsr.w   WaitforInt
            bpl.b   .L16
            cmpi.b  #$B0,D3
            bne.b   .L21
            move.b  ($804,A4),D5
            and.b   D6,D5
            beq.b   .L21
.L16:
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            cmpi.b  #$E0,D3
            beq.b   .L17
            cmpi.b  #$B0,D3
            beq.b   .L17
            move.w  D2,D1
            lsr.w   #8,D1
            cmpi.b  #$C,D1
            bne.b   .L20
.L17:
            ori     #$700,SR
            clr.w   D6
            bset    #$F,D6
            move.b  #1,($80A,A4)
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            cmpi.b  #$B0,D3
            bne.b   .L18
            move.b  #1,($F09,A4)
            clr.b   ($F09,A4)
.L18:
            tst.b   ($804,A4)
            move.b  #$90,(0,A3,D7.w)
            move.w  #$7FFF,D5
            move    #$2100,SR
.L19:
            tst.b   (A5)
            tst.w   D6
            dbeq    D5,.L19
            bne.b   .L21
.L20:
            moveq   #0,D6
.L21:
            ori     #$700,SR
            swap    D7
            move.b  #$10,(0,A3,D7.w)
            move.b  #$80,($803,A4)
            clr.b   ($803,A4)
            clr.b   ($80A,A4)
            movec   VBR,A0
            move.l  (SP)+,($68,A0)
.L22:
            move    (SP)+,SR
            movem.l (SP)+,D0-D1/D3-D5/D7/A0-A4
            RTS6
IntHdlr:
            move.b  (0,A3,D7.w),D0
            btst    #4,D0
            bne.b   .L1
            move.b  #$FF,D6
            move    SR,(SP)
            bra.b   .L8
.L1:
            move.b  ($804,A4),D4
            btst    #$F,D6
            bne.b   .L2
            andi.b  #$F,D4
            btst    #$1F,D6
            beq.b   .L9
            move    SR,(SP)
            bra.b   .L9
.L2:
            cmpi.b  #$B0,D3
            beq.b   .L3
            btst    #0,D4
            bne.b   .L4
            bra.b   .L6
.L3:
            btst    #0,D4
            bne.b   .L6
.L4:
            move.w  #$7FFF,D1
.L5:
            tst.b   (A5)
            btst    #1,($804,A4)
            dbne    D1,.L5
            bne.b   .L7
            move.b  #2,D6
            bra.b   .L8
.L6:
            move.b  #1,D6
            bra.b   .L8
.L7:
            clr.w   D6
.L8:
            swap    D7
            move.b  #$10,(0,A3,D7.w)
            swap    D7
.L9:
            move.b  #$90,(0,A3,D7.w)
            rte
FIFOFill:
            move.w  #$7D0,D5
.L1:
            move    #$2100,SR
            move.b  D0,(A2)
            and.b   D6,D4
            dbne    D5,.L1
            tst.w   D5
            rts
WaitforInt:
            move.w  #$7FFF,D1
.L1:
            move    #$2100,SR
            tst.b   (A5)
            and.b   D6,D4
            dbne    D1,.L1
            tst.w   D1
            rts
.L2:
            moveq   #-1,D6
            RTS6
TestCLUT:
            move.l  ($18,A1),D0
            btst    #$E,D0
            beq.w   sub_408496F0.L2
            moveq   #0,D6
            move.l  A6,-(SP)
            movem.l D1-D3/A0/A2-A3,-(SP)
            movea.l ($38,A0),A0
            move.b  (8,A0),-(SP)
            move.b  #$FF,(8,A0)
            movea.l A0,A2
            lea     (1,A2),A3
            lea     (A2),A0
            move.b  ($12,A1),D0
            cmpi.b  #$D,D0
            beq.b   .L1
            lea     (4,A2),A3
            lea     (A2),A0
.L1:
            clr.b   (A0)
            bsr.w   sub_408496F0
            link.w  A2,#-$300
            movea.l SP,A2
            move.w  #$FF,D0
.L2:
            moveq   #2,D2
.L3:
            move.b  (A3),(A2)+
            dbra    D2,.L3
            dbra    D0,.L2
            clr.b   (A0)
            move.w  #$FF,D0
            move.b  #$FF,D1
.L4:
            moveq   #2,D2
.L5:
            addq.b  #1,D1
            move.b  D1,(A3)
            dbra    D2,.L5
            dbra    D0,.L4
            clr.b   (A0)
            bsr.w   sub_408496F0
            move.w  #$FF,D0
            move.b  #$FF,D1
.L6:
            moveq   #2,D2
.L7:
            addq.b  #1,D1
            move.b  (A3),D3
            cmp.b   D3,D1
            dbne    D2,.L7
            dbne    D0,.L6
            beq.b   .L8
            neg.b   D0
            subq.b  #1,D0
            neg.b   D2
            addq.b  #3,D2
            move.b  D2,D6
            lsl.l   #8,D6
            move.b  D0,D6
            lsl.l   #8,D6
            move.b  D1,D6
            lsl.l   #8,D6
            move.b  D3,D6
.L8:
            clr.b   (A0)
            move.w  #$FF,D0
            movea.l SP,A2
.L9:
            moveq   #2,D2
.L10:
            move.b  (A2)+,(A3)
            dbra    D2,.L10
            dbra    D0,.L9
            unlk    A2
            move.b  (SP)+,(8,A0)
            movem.l (SP)+,D1-D3/A0/A2-A3
            rts
sub_408496F0:
            move.b  ($12,A1),D0
            cmpi.b  #$D,D0
            beq.b   .L1
            tst.b   (A3)
            tst.b   (A3)
            tst.b   (A3)
.L1:
            rts
.L2:
            moveq   #-1,D6
            RTS6
SizeVRAM:
            move.b  ($13,A1),D0
            cmpi.b  #7,D0
            beq.b   .L1
            cmpi.b  #9,D0
            beq.b   .L3
            cmpi.b  #8,D0
            beq.b   .L4
            moveq   #-1,D6
            bra.w   .L16
.L1:
            movea.l ($34,A0),A2
            moveq   #0,D0
            btst    #2,(1,A2)
            beq.w   .L15
            move.l  #$40000,D0
            btst    #1,(1,A2)
            bne.b   .L2
            lsl.l   #1,D0
.L2:
            move.l  (8,A1),D1
            movea.l (0,A1,D1.l),A0
            lea     (0,A0,D0.l),A1
            bra.w   .L15
.L3:
            move.l  (8,A1),D0
            movea.l (0,A1,D0.l),A0
            move.l  #$8000,D0
            lea     (0,A0,D0.l),A1
            bra.w   .L15
.L4:
            movea.l ($68,A0),A2
            lea     .L17,A3
            moveq   #0,D1
            bra.b   .L6
.L5:
            move.w  (A3)+,D1
            move.l  D1,(0,A2,D0.w)
.L6:
            move.w  (A3)+,D0
            bpl.b   .L5
            movea.l ($2C,A0),A3
            btst    #5,(A3)
            beq.b   .L7
            ori.l   #$F00,($10,A2)
.L7:
            lea     ($300,A2),A3
            lea     .L18,A4
            moveq   #0,D0
.L8:
            move.b  (A4)+,D0
            bmi.b   .L9
            move.l  D0,(A3)
            lea     ($10,A3),A3
            bra.b   .L8
.L9:
            move.l  #3,($20,A2)
            bsr.w   sub_408498C2
            move.l  #7,($20,A2)
            bsr.w   sub_408498C2
            move.l  #3,($20,A2)
            bsr.w   sub_408498C2
            move.l  #2,($20,A2)
            bsr.w   sub_408498C2
            clr.l   ($20,A2)
            bsr.w   sub_408498C2
            movea.l #$F9000000,A3
            moveq   #0,D0
            move.l  #'Shel',D1
            moveq   #-1,D2
            moveq   #0,D6
.L10:
            lea     (0,A3,D0.l),A4
            move.l  D1,(A4)
            move.l  D2,(4,A4)
            move.l  D1,D3
            moveq   #0,D4
            moveq   #3,D5
.L11:
            cmp.b   (0,A4,D5.w),D3
            bne.b   .L12
            not.b   D3
            not.b   (0,A4,D5.w)
            move.l  D2,(4,A4)
            cmp.b   (0,A4,D5.w),D3
            beq.b   .L13
.L12:
            bset    D5,D4
.L13:
            ror.l   #8,D3
            dbra    D5,.L11
            cmpi.b  #$F,D4
            beq.b   .L14
            rol.l   #4,D6
            or.b    D4,D6
            move.l  D2,(0,A3,D0.l)
            addi.l  #$80000,D0
            cmpi.l  #$200000,D0
            bne.b   .L10
.L14:
            movea.l A3,A0
            lea     (0,A0,D0.l),A1
            bra.b   .L16
.L15:
            moveq   #0,D6
.L16:
            rts
.L17:
            dc.w    $0020,$0007,0,$0008,$0004,0,$0008,$0064
            dc.w    $000C,$0602,$0010,$0050,$0100,$0FF2,$0168,$008E
            dc.w    $0124,$031E,$0128,$01B0,$012C,$0020,$0130,$035F
            dc.w    $0134,$003F,$0138,$004B,$013C,$006F,$0140,$0098
            dc.w    $0144,$0318,$0148,$035E,$014C,$041A,$0150,$0418
            dc.w    $0154,$0004,$0158,$0009,$015C,$0052,$0160,$0412
            dc.w    $0164,$0416,$0220,$0098,$FFFF
.L18:
            dc.w    $0F07,0,$0501,0,$0002,$0506,$0401,0
            dc.w    $FF00
sub_408498C2:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            rts
TestVRAM:
            move.l  A6,-(SP)
            move.l  A1,-(SP)
            bsr.w   SizeVRAM
            movea.l (SP)+,A2
            cmpi.l  #$FFFFFFFF,D6
            beq.b   .L7
            tst.l   D0
            beq.b   .L7
            cmpi.b  #8,($13,A2)
            bne.b   .L5
            movea.l A1,A2
            movea.l A0,A1
            moveq   #0,D2
.L1:
            movea.l A1,A0
            adda.l  #$80000,A1
            rol.w   #4,D2
            moveq   #0,D6
            movem.l D2/A2,-(SP)
            BSR6    CritProc
            movem.l (SP)+,D2/A2
            tst.l   D6
            beq.b   .L4
            moveq   #3,D3
.L2:
            tst.b   D6
            beq.b   .L3
            bset    D3,D2
.L3:
            ror.l   #8,D6
            dbra    D3,.L2
.L4:
            cmpa.l  A1,A2
            bne.b   .L1
            move.l  D2,D6
            bra.b   .L6
.L5:
            moveq   #0,D6
            BSR6    CritProc
            tst.l   D6
            bne.b   .L6
            BSR6    RevMod3Test
.L6:
            rts
.L7:
            moveq   #-1,D6
            rts
TestC96:
            move.l  A6,-(SP)
            btst    #$18,D0
            bne.b   .L1
            btst    #$19,D0
            bne.b   .L2
            moveq   #-1,D6
            rts
.L1:
            movea.l ($60,A0),A2
            bsr.b   TestC96Chip
            bne.b   .L3
            btst    #$19,D0
            beq.b   .L3
.L2:
            movea.l ($64,A0),A2
            bsr.b   TestC96Chip
            beq.b   .L3
            bset    #$1F,D6
.L3:
            rts
TestC96Chip:
            movem.l D0-D3,-(SP)
            move.b  #2,($30,A2)
            moveq   #0,D6
            moveq   #0,D0
.L1:
            move.b  D0,(A2)
            ror.w   #8,D0
            move.b  D0,($10,A2)
            ror.w   #8,D0
            move.b  #$80,($30,A2)
            move.b  ($10,A2),D1
            asl.w   #8,D1
            move.b  (A2),D1
            cmp.w   D0,D1
            bne.w   .L7
            addq.l  #5,D0
            cmpi.l  #$FFFF,D0
            ble.b   .L1
            move.b  #3,D6
            swap    D6
            asl.l   #8,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            bne.w   .L16
            move.w  #$F,D0
.L2:
            move.b  D0,($20,A2)
            dbra    D0,.L2
            move.b  #4,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            cmpi.b  #$10,D0
            bne.w   .L9
            move.w  #$F,D0
            move.b  #5,D6
.L3:
            move.b  ($20,A2),D1
            cmp.b   D0,D1
            dbne    D0,.L3
            bne.w   .L10
            move.b  #6,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            bne.w   .L11
            move.w  #$F,D2
            moveq   #1,D0
.L4:
            move.b  D0,($20,A2)
            rol.b   #1,D0
            dbra    D2,.L4
            move.w  #$F,D2
            moveq   #1,D0
            move.b  #7,D6
.L5:
            move.b  ($20,A2),D1
            cmp.b   D0,D1
            bne.b   .L10
            rol.b   #1,D0
            dbra    D2,.L5
            move.w  #$300,D2
            moveq   #0,D0
.L6:
            move.b  D0,($80,A2)
            addq.l  #1,D0
            move.b  D0,($B0,A2)
            addq.l  #1,D0
            move.b  D0,($C0,A2)
            subq.l  #2,D0
            move.b  ($80,A2),D1
            cmp.b   D0,D1
            bne.b   .L12
            addq.l  #1,D0
            move.b  ($B0,A2),D1
            move.b  D0,D3
            andi.b  #$DF,D0
            cmp.b   D0,D1
            bne.b   .L13
            move.b  D3,D0
            addq.l  #1,D0
            move.b  ($C0,A2),D1
            move.b  D0,D3
            andi.b  #7,D0
            cmp.b   D0,D1
            bne.b   .L14
            move.b  D3,D0
            addq.l  #1,D0
            dbra    D2,.L6
            moveq   #0,D6
            bra.b   .L16
.L7:
            move.b  #1,D6
            cmp.b   D0,D1
            bne.b   .L8
            move.b  #2,D6
            ror.w   #8,D0
            ror.w   #8,D1
.L8:
            swap    D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
            bra.b   .L16
.L9:
            swap    D6
            move.b  #$10,D6
            asl.l   #8,D6
            move.b  D0,D6
            bra.b   .L16
.L10:
            asl.l   #8,D6
            move.b  ($70,A2),D6
            asl.l   #8,D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
            bra.b   .L16
.L11:
            swap    D6
            asl.l   #8,D6
            move.b  D0,D6
            bra.b   .L16
.L12:
            move.b  #8,D6
            bra.b   .L15
.L13:
            move.b  #9,D6
            bra.b   .L15
.L14:
            move.b  #$A,D6
.L15:
            swap    D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
.L16:
            move.b  #2,($30,A2)
            movem.l (SP)+,D0-D3
            tst.l   D6
            rts
            ds.b    14
