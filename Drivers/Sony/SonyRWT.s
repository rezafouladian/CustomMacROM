            move.l  ($226).w,-(SP)
            rts
jtDiskPrime:
            ori     #$100,SR
            move.w  (6,A0),D3
            btst    #6,($2D,A0)
            sne     DskVerify
            bsr.b   CkDrvNum
            bne.w   DskRWOff.L9
            move.w  D3,($32,A1)
            moveq   #-$40,D0
            tst.b   (4,A1,D1.w)
            bsr.w   sub_408707FE
            tst.b   ($138,A1)
            bpl.b   .L2
            bsr.w   SetChipMode
.L2:
            bsr.w   sub_4086D716
            cmpi.w  #3,($12,A1)
            bge.w   mDoFormat.L50
            moveq   #2,D0
            bsr.w   AdrAndSense
            bpl.b   .L3
            clr.b   (3,A1,D1.w)
            move.b  #$80,($C00,A0)
            tst.b   ($1000,A0)
            moveq   #-$41,D0
            bra.b   DskRWOff.L9
.L3:
            cmpi.b  #2,(3,A1,D1.w)
            beq.b   .L5
            clr.b   ($17,A1,D1.w)
            tst.b   ($138,A1)
            bpl.b   .L4
            bsr.w   SetChipMode
.L4:
            bsr.w   sub_4086D6BC
            bsr.w   Recal
            bmi.b   DskRWOff.L7
            bsr.w   MakeSpdTbl
            bne.b   DskRWOff.L7
            moveq   #6,D0
            bsr.w   AdrAndSense
            spl     (2,A1,D1.w)
            clr.b   ($12,A1,D1.w)
            move.b  #2,(3,A1,D1.w)
            bra.w   ChkDiskType
.L5:
            bsr.w   CheckRead
            beq.b   DskRWOff.L10
            move.w  BufTgFBkNum,($26,A1)
            tst.b   (2,A1,D1.w)
            bpl.b   DskRWOff.L10
            moveq   #-$2C,D0
DskRWOff:
            move.w  ($3A,A1),D2
            bra.b   .L8
.L7:
            moveq   #0,D2
.L8:
            move.w  D0,-(SP)
            move.w  D2,D0
            bsr.w   PowerDown
            move.w  (SP)+,D0
.L9:
            andi    #$F8FF,SR
            bra.w   DiskRTS.L9
.L10:
            move.w  (0,A1,D1.w),D6
            bsr.w   PowerUp
GetTrack:
            movea.l (A1),A2
            movea.l (8,A2),A0
            move.l  ($10,A2),D0
            moveq   #9,D7
            lsr.l   D7,D0
            tst.b   ($17,A1,D1.w)
            bmi.w   mPulse.L15
            moveq   #0,D4
            tst.b   ($12,A1,D1.w)
            beq.b   .L12
            moveq   #1,D4
.L12:
            moveq   #$64,D2
            lsl.w   #3,D2
            lsl.w   D4,D2
            cmp.l   D2,D0
            blt.b   .L15
.L13:
            moveq   #-$32,D0
.L14:
            bra.b   DskRWOff
.L15:
            moveq   #7,D3
            lsl.w   #4,D3
            lsl.w   D4,D3
            moveq   #$10,D5
            lsl.w   D4,D5
.L16:
            add.w   D5,D3
            sub.l   D3,D2
            cmp.l   D2,D0
            blt.b   .L16
            lsr.w   #4,D3
            moveq   #-1,D5
.L17:
            add.w   D3,D2
            addq.w  #1,D5
            cmp.w   D2,D0
            bge.b   .L17
            lsr.w   D4,D3
            moveq   #$C,D6
            sub.w   D3,D6
            lsl.w   #4,D6
            add.w   D6,D5
            move.l  D4,D6
            sub.w   D3,D2
            cmp.l   D2,D0
            bge.b   .L18
            sub.w   D3,D2
            moveq   #0,D6
.L18:
            tst.b   D6
            beq.b   .L19
            bset    #$B,D5
            tst.b   (5,A1,D1.w)
            bne.b   .L19
            moveq   #-$4E,D0
            bra.b   .L14
.L19:
            move.w  D5,($16,A1)
            sub.w   D2,D0
            sub.w   D0,D3
            move.w  D0,($20,A1)
            move.l  ($24,A0),D5
            move.l  ($28,A0),D2
            sub.l   D2,D5
            lsr.l   D7,D5
            beq.b   .L13
            cmp.w   D5,D3
            slt     D6
            ble.b   .L20
            move.w  D5,D3
.L20:
            moveq   #0,D5
            move.w  D0,D4
            move.w  D3,-(SP)
.L21:
            bset    D0,D5
            addq.w  #1,D0
            subq.w  #1,D3
            bne.b   .L21
            move.w  (SP)+,D3
            move.l  D5,($22,A1)
            movea.l ($20,A0),A3
            adda.l  D2,A3
            move.l  A3,($1C,A1)
            lsr.l   D7,D2
            move.w  D2,($28,A1)
            move.b  ($2C,A1),($2D,A1)
            clr.b   ($100,A1)
            bsr.w   CheckRead
            beq.b   .L23
            bsr.w   CacheValid
            bne.b   .L22
            move.l  D5,D0
            not.l   D0
            and.l   D0,($106,A1)
.L22:
            bra.w   ReSeek
.L23:
            tst.b   DskVerify
            bne.b   .L22
            bsr.w   CacheValid
            bne.w   .L30
            move.l  D5,D2
            and.l   ($106,A1),D2
            beq.w   .L29
            moveq   #2,D7
            asl.l   #8,D7
            move.w  D4,D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L24
            subq.w  #1,D0
.L24:
            mulu.w  #$20C,D0
            movea.l ($10A,A1),A4
            adda.w  D0,A4
.L25:
            btst    D4,D2
            beq.b   .L28
            bclr    D4,D5
            movem.l A0-A1,-(SP)
            tst.l   ($F4,A1)
            beq.b   .L26
            move.w  D4,D0
            sub.w   ($20,A1),D0
            add.w   ($28,A1),D0
            mulu.w  #$C,D0
            movea.l ($F4,A1),A1
            adda.l  D0,A1
            bra.b   .L27
.L26:
            lea     BufTgFNum,A1
.L27:
            movea.l A4,A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l A3,A1
            move.l  D7,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            addq.w  #1,($110,A1)
            add.l   D7,($10,A2)
            add.l   D7,($28,A0)
.L28:
            adda.l  D7,A3
            adda.l  D7,A4
            lea     ($C,A4),A4
            addq.w  #1,D4
            subq.w  #1,D3
            bne.b   .L25
            move.l  D5,($22,A1)
            bne.b   .L29
            move.l  ($28,A0),D0
            cmp.l   ($24,A0),D0
            blt.w   GetTrack
            moveq   #0,D0
            bra.w   DskRWOff
.L29:
            bsr.b   TCRdEnbChk
            bra.b   ReSeek
.L30:
            bsr.b   TCRdEnbChk
            bne.b   ReSeek
            move.w  ($12,A1),($102,A1)
            move.w  ($16,A1),($104,A1)
            clr.l   ($106,A1)
            bra.b   ReSeek
TCRdEnbChk:
            tst.b   ($101,A1)
            beq.b   .L2
            btst    #$A,($32,A1)
            bne.b   .L1
            tst.b   D6
.L1:
            seq     ($100,A1)
            rts
.L2:
            moveq   #1,D6
            bra.b   .L1
CacheValid:
            tst.b   ($101,A1)
            beq.b   .L1
            move.w  ($102,A1),D0
            beq.b   .L1
            cmp.w   ($12,A1),D0
            bne.b   .L1
            move.w  ($16,A1),D0
            sub.w   ($104,A1),D0
            beq.b   .L2
.L1:
            moveq   #-1,D0
.L2:
            rts
ReSeek:
            move.l  ($24A).w,-(SP)
            rts
jtReSeek:
            move.b  ($30,A1),($31,A1)
            move.w  ($16,A1),D6
            bsr.w   sub_4086D4AE
            bmi.b   .L4
            move.b  ($2A,A1),($2B,A1)
            bra.b   OnTrack
.L4:
            bra.w   DoRecal
OnTrack:
            move.b  ($2E,A1),($2F,A1)
OnTrack1:
            move.w  D1,D6
            bsr.w   RdAddrSetup
            bmi.w   AdrDtaErr
            cmp.w   ($16,A1),D1
            bne.w   WrgSideTrk
            move.b  D3,($14C,A1)
            move.w  D2,($FE,A1)
            move.w  D2,TagData
            move.l  ($22,A1),D0
            btst    D2,D0
            bne.w   OTSetUp
            tst.b   ($100,A1)
            beq.w   WrgSectAdr
            move.l  ($106,A1),D0
            btst    D2,D0
            bne.w   WrgSectAdr
            lea     jtRdData,A0
            cmpa.l  ($22E).w,A0
            sne     ($100,A1)
            bne.w   WrgSectAdr
            move.w  D2,D1
            tst.b   ($17,A1,D6.w)
            bpl.b   .L7
            subq.w  #1,D2
.L7:
            mulu.w  #$20C,D2
            movea.l ($10A,A1),A0
            adda.l  D2,A0
            lea     ($C,A0),A0
            bsr.w   RdData
            bsr.w   GetDrv1
            move.w  D1,D6
            tst.w   D0
            spl     ($100,A1)
            bmi.b   .L9
            addq.w  #1,($10E,A1)
            move.w  ($FE,A1),D2
            movea.l ($10A,A1),A0
            move.w  D2,D1
            tst.b   ($17,A1,D6.w)
            bpl.b   .L8
            subq.w  #1,D1
.L8:
            mulu.w  #$20C,D1
            adda.l  D1,A0
            lea     BufTgFNum,A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  ($106,A1),D4
            bset    D2,D4
            move.l  D4,($106,A1)
.L9:
            bset    #7,($15F).w
            bne.b   .L11
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D6.w)
            bpl.b   .L10
            moveq   #$4B,D0
.L10:
            bsr.w   WakeSetUp
            bsr.w   EmptyPD
            bsr.w   WakeGo
            bra.b   .L12
.L11:
            bsr.w   EmptyPD
            andi    #$F8FF,SR
.L12:
            bra.w   OnTrack
OTSetUp:
            cmpi.b  #$1F,D3
            sgt     ($12,A1,D6.w)
            sub.w   ($20,A1),D2
            move.w  D2,D1
            asl.l   #8,D1
            add.l   D1,D1
            add.l   ($1C,A1),D1
            movea.l D1,A0
            move.w  ($28,A1),D1
            add.w   D2,D1
            move.w  D1,D0
            add.w   D1,D1
            add.w   D0,D1
            asl.w   #2,D1
            move.w  D1,($F8,A1)
            bsr.w   CheckRead
            beq.b   OTRead
            move.l  ($F4,A1),D3
            beq.b   .L14
            movea.l D3,A1
            adda.w  D1,A1
            lea     BufTgFNum,A2
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            bra.b   .L15
.L14:
            add.w   ($26,A1),D0
            move.w  D0,BufTgFBkNum
.L15:
            bsr.w   WrData
            bmi.w   AdrDtaErr
            bra.b   GotSect
OTRead:
            bsr.w   RdData
            bmi.w   AdrDtaErr
            movea.l SonyVars,A1
            move.l  ($F4,A1),D0
            beq.b   GotSect
            movea.l D0,A0
            adda.w  ($F8,A1),A0
            lea     BufTgFNum,A2
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
            move.l  (A2)+,(A0)+
GotSect:
            bsr.w   GetDrv1
            move.l  ($22,A1),D4
            move.w  ($FE,A1),D2
            bclr    D2,D4
            move.l  D4,($22,A1)
            movea.l (A1),A2
            movea.l (8,A2),A0
            moveq   #2,D3
            asl.l   #8,D3
            add.l   D3,($10,A2)
            add.l   D3,($28,A0)
            move.l  ($24,A0),D3
            sub.l   ($28,A0),D3
            bset    #7,($15F).w
            beq.b   .L19
            bsr.b   CheckRead
            beq.b   .L21
            tst.l   D4
            bne.b   .L18
            bsr.b   EmptyPD
            moveq   #7,D0
            bsr.w   WakeUp_SonyRWT
            bra.b   .L22
.L18:
            tst.b   ($13,A1,D1.w)
            bmi.b   .L21
.L19:
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D1.w)
            bpl.b   .L20
            moveq   #$4B,D0
.L20:
            bsr.w   WakeSetUp
            bsr.b   EmptyPD
            bsr.w   WakeGo
            bra.b   .L22
.L21:
            bsr.b   EmptyPD
            andi    #$F8FF,SR
.L22:
            move.l  D4,D0
            bne.w   OnTrack
            tst.l   D3
            bgt.w   GetTrack
            tst.b   ($12,A1,D1.w)
            beq.b   ToDskRWOff
            tst.b   (5,A1,D1.w)
            bne.b   ToDskRWOff
            moveq   #-$4E,D0
ToDskRWOff:
            bra.w   DskRWOff
CheckRead:
            cmpi.b  #2,($33,A1)
            rts
EmptyPD:
            movea.l (SP)+,A4
            pea     .L2
            move.l  PollProc,-(SP)
            beq.b   .L1
            movea.l SonyVars,A1
            movem.l D0/D2-D3/A0/A4,($D0,A1)
            rts
.L2:
            bsr.w   GetDrv1
            movem.l ($D0,A1),D0/D2-D3/A0/A4
            jmp     (A4)
.L1:
            movea.l PollStack,SP
            bsr.w   GetDrv1
            jmp     (A4)
AdrDtaErr:
            bsr.b   EmptyPD
            andi    #$F8FF,SR
            addq.w  #1,($FA,A1)
            addq.w  #1,($14,A1,D1.w)
            tst.b   ($2D,A1)
            beq.b   .L1
            bsr.b   CheckRead
            bne.b   DoRecal
.L1:
            subq.b  #1,($2B,A1)
            bpl.w   OnTrack
            bra.b   DoRecal
WrgSectAdr:
            movea.l SonyVars,A1
            move.w  ($3E,A1),D0
            tst.b   ($17,A1,D6.w)
            bpl.b   .L5
            moveq   #$4B,D0
.L5:
            bsr.w   WakeSetUp
            bsr.b   EmptyPD
            bsr.w   WakeGo
            addq.l  #1,RndSeed
            moveq   #-$51,D0
            subq.b  #1,($2F,A1)
            bmi.b   DoRecal
            bra.w   OnTrack1
WrgSideTrk:
            bsr.b   EmptyPD
            moveq   #-$50,D0
DoRecal:
            andi    #$F8FF,SR
            subq.b  #1,($2D,A1)
            ble.b   .L8
            bsr.w   Recal
            bmi.b   .L8
            bsr.w   MakeSpdTbl
            bpl.w   ReSeek
.L8:
            bra.w   ToDskRWOff
