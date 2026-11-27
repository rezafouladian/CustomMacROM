PRLOG:
RBIMGR:
            BSR6    sub_4084A146.L2
            BSR6    SizeMemory
            bne.w   .L21
            move.w  #3,D7
            movea.l (SP),SP
            movea.l SP,A4
.L1:
            movea.l (A4)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L3
            movea.l (A4)+,A1
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L2
            movea.l SP,A1
.L2:
            BSR6    CritProc
            tst.l   D6
            bne.w   .L21
            addq.w  #1,D7
            bra.b   .L1
.L3:
            clr.w   D7
            BSR6    USTINIT
            movea.l ($2E,A5),A1
            suba.w  #$13E,A1
            bsr.w   sub_4084A146
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A0-A2,($164,A5)
            bsr.w   sub_4084A1C4
            movem.l ($164,A5),A0-A2
            bsr.w   IndicatorOn
            move.l  A5,-(SP)
            BSR6    CLKWPOFF
            move.l  #$7C00FC,D3
            BSR6    ReadPramSig
            movea.l (SP)+,A5
            cmpi.l  #'RBBI',D4
            beq.b   .L4
            clr.w   -(SP)
            move.w  #$80,-(SP)
            bra.b   .L5
.L4:
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            move.l  A5,-(SP)
            BSR6    WrXByte
            movea.l (SP)+,A5
            move.w  #$80,-(SP)
            clr.w   -(SP)
.L5:
            move.w  #$80,-(SP)
            bsr.w   RelocatePRAM
            lea     (6,SP),SP
            bsr.w   InvalidUpper
            move.w  #$E6,-(SP)
            pea     ($32,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            addq.w  #1,($32,A5)
            pea     ($32,A5)
            move.w  #$E6,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            move.w  #$F2,-(SP)
            pea     ($146,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$F4,-(SP)
            pea     ($148,A5)
            move.w  #4,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$D0,-(SP)
            pea     ($14C,A5)
            move.w  #4,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E8,-(SP)
            pea     ($150,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$EA,-(SP)
            pea     ($152,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E0,-(SP)
            pea     ($154,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E2,-(SP)
            pea     ($156,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$80,-(SP)
            pea     ($3C,A5)
            move.w  #$20,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  ($150,A5),D1
            sub.w   D1,($146,A5)
.L6:
            clr.w   ($3A,A5)
            subq.w  #1,($146,A5)
            bmi.w   .L16
            addq.w  #1,($150,A5)
            move.l  ($148,A5),D0
            moveq   #$1F,D1
.L7:
            tst.l   D0
            beq.w   .L14
            asl.l   #1,D0
            bcc.w   .L13
            move.w  D1,D7
            ori.w   #$C0,D7
            move.b  ($3C,A5,D1.w),D2
            andi.w  #$FF,D2
            moveq   #0,D5
            bset    D1,D5
            move.l  D5,($36,A5)
            andi.l  #$E0000000,D5
            bne.b   .L9
            cmp.w   ($144,A5),D1
            bge.w   .L13
            move.l  ($5C,A5,D1.w*8),($158,A5)
            move.l  ($60,A5,D1.w*8),($15C,A5)
            movem.l D0-D1/A5,-(SP)
            movea.l ($16,A5),A3
.L8:
            movem.l D1-D2/A3,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  ($15C,A5),-(SP)
            move.l  ($158,A5),-(SP)
            pea     (A3)
            BigJsr  GI_ExecuteTest,A0
            adda.w  #$14,SP
            movem.l (SP)+,D1-D2/A3
            move.l  D0,D6
            dbne    D2,.L8
            bra.b   .L11
.L9:
            move.l  D1,($158,A5)
            move.l  #1,($15C,A5)
            lea     sub_4084A23A.L2,A0
            move.w  #$1F,D5
            sub.w   D1,D5
            move.l  (0,A0,D5.w*4),D5
            lea     (0,A0,D5.l),A0
            movem.l D0-D1/A5,-(SP)
.L10:
            movem.l D2/A0,-(SP)
            jsr     (A0)
            movem.l (SP)+,D2/A0
            tst.l   D6
            dbne    D2,.L10
.L11:
            movem.l (SP),D0-D1/A5
            movem.l ($164,A5),A0-A2
            bsr.w   IndicatorOn
            move.l  D6,($160,A5)
            beq.b   .L12
            bsr.w   sub_4084A23A
.L12:
            movem.l (SP)+,D0-D1/A5
.L13:
            subq.w  #1,D1
            bra.w   .L7
.L14:
            bsr.w   InvalidUpper
            pea     ($150,A5)
            move.w  #$E8,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            tst.w   ($3A,A5)
            bne.w   .L15
            addq.w  #1,($152,A5)
            pea     ($152,A5)
            move.w  #$EA,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
.L15:
            bsr.w   UpperToLower
            bra.w   .L6
.L16:
            clr.w   D7
            bsr.w   InvalidUpper
            pea     sub_4084A23A.L10
            move.w  #$EC,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            tst.l   ($14C,A5)
            bne.b   .L21
            move.w  #$F0,-(SP)
            pea     ($32,A5)
            move.w  #1,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            tst.b   ($32,A5)
            bne.b   .L21
            bsr.w   IndicatorOff
            moveq   #0,D2
.L17:
            move.w  #$1F4,D0
.L18:
            move.w  #$320,D1
.L19:
            tst.b   (A2)
            dbra    D1,.L19
            dbra    D0,.L18
            eori.b  #1,D2
            beq.b   .L20
            bsr.w   IndicatorOn
            bra.b   .L17
.L20:
            bsr.w   IndicatorOff
            bra.b   .L17
.L21:
            bsr.w   IndicatorOff
            bra.w   Error1Handler
InvalidUpper:
            move.l  A5,-(SP)
            move.l  #$7C00FC,D1
            moveq   #0,D2
            BSR6    WrXByte
            movea.l (SP)+,A5
            rts
UpperToLower:
            move.l  A5,-(SP)
            move.l  #$7C00FC,D1
            move.l  #'RBBI',D2
            rol.l   #8,D2
            BSR6    WrXByte
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            BSR6    WrXByte
            move.w  #$80,-(SP)
            clr.w   -(SP)
            move.w  #$80,-(SP)
            bsr.w   RelocatePRAM
            lea     (6,SP),SP
            movea.l (SP)+,A5
            rts
RelocatePRAM:
            move.l  A5,-(SP)
.L1:
            move.w  ($C,SP),D1
            BSR6    RdXByte
            move.b  D1,D2
            move.w  ($A,SP),D1
            BSR6    WrXByte
            addq.w  #1,($C,SP)
            addq.w  #1,($A,SP)
            subq.w  #1,(8,SP)
            bne.b   .L1
            movea.l (SP)+,A5
            rts
IndicatorOn:
            move.l  ($2A,A5),D0
            btst    #8,D0
            beq.b   .L1
            movea.l ($20,A0),A3
            bset    #3,($10,A3)
            rts
.L1:
            bsr.w   FindC96Base
            move.b  #$22,($30,A3)
            rts
IndicatorOff:
            move.l  ($2A,A5),D0
            btst    #8,D0
            beq.b   .L1
            movea.l ($20,A0),A3
            bclr    #3,($10,A3)
            rts
.L1:
            bsr.w   FindC96Base
            move.b  #$1B,($30,A3)
            rts
FindC96Base:
            movea.l ($60,A0),A3
            btst    #$19,D0
            beq.b   .L1
            movea.l ($64,A0),A3
.L1:
            move.b  #2,($30,A3)
            clr.b   ($30,A3)
            move.b  #8,($80,A3)
            move.b  #1,($A0,A3)
            rts
COPYRAMTOPRAM:
            move.w  (6,SP),D1
            movea.l (8,SP),A3
            move.w  (4,SP),D3
            moveq   #0,D2
            subq.w  #1,D3
            blt.b   .L2
.L1:
            move.b  (A3)+,D2
            movem.l D1/D3/A3/A5,-(SP)
            BSR6    WrXByte
            movem.l (SP)+,D1/D3/A3/A5
            addq.w  #1,D1
            dbra    D3,.L1
.L2:
            rts
COPYPRAMTORAM:
            move.w  ($A,SP),D2
            movea.l (6,SP),A3
            move.w  (4,SP),D3
            subq.w  #1,D3
            blt.b   .L2
.L1:
            move.w  D2,D1
            movem.l D2-D3/A3/A5,-(SP)
            BSR6    RdXByte
            movem.l (SP)+,D2-D3/A3/A5
            move.b  D1,(A3)+
            addq.w  #1,D2
            dbra    D3,.L1
.L2:
            rts
sub_4084A146:
            lea     ($32,A5),A0
            move.l  A0,D0
            sub.l   SP,D0
            move.l  D0,D1
            movea.l A1,A2
            lsr.l   #2,D0
            addq.l  #1,D0
.L1:
            move.l  -(A0),-(A1)
            dbra    D0,.L1
            movea.l A2,A0
            suba.l  D1,A0
            movea.l A0,SP
            addq.l  #4,A0
            movec   A0,VBR
            lea     (-$32,A2),A5
            rts
.L2:
            sub.l   D0,D0
            bset    #$1F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$1F,D0
            beq.b   .L3
            mc68040
            cinva   BC
            mc68030
            sub.l   D0,D0
            movec   D0,CACR
            mc68040
            movec   D0,TC
            mc68030
            move.l  #$FFC040,D0
            mc68040
            movec   D0,DTT0
            mc68030
            move.l  #$FFC040,D0
            mc68040
            movec   D0,DTT1
            mc68030
            bra.b   .L4
.L3:
            move.l  #$2000,D0
            movec   D0,CACR
            movec   CACR,D0
            tst.l   D0
            beq.b   .L4
            lea     .L5,A0
            pmove.l (A0),TC
.L4:
            RTS6
.L5:
            ds.b    4
sub_4084A1C4:
            movea.l (SP)+,A1
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            movea.l SP,A0
            move.l  A1,-(SP)
            move.w  #$10,(8,A5)
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            movea.l ($12,A5),A0
            lea     ($5C,A5),A1
            clr.w   ($144,A5)
.L1:
            moveq   #0,D0
            move.w  (2,A0),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L3
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L2
            moveq   #0,D1
            move.w  (A0),D1
            move.l  D1,(A1)+
            move.l  D0,(A1)+
            movem.l A0-A1,-(SP)
            bsr.w   USTGETANDINSTALL
            movem.l (SP)+,A0-A1
            addq.w  #1,($144,A5)
            cmpi.w  #$1D,($144,A5)
            beq.b   .L3
.L2:
            addq.w  #6,A0
            bra.b   .L1
.L3:
            bsr.w   UTEINSTROMTESTS
            rts
sub_4084A23A:
            bsr.w   InvalidUpper
            addq.w  #1,($3A,A5)
            move.w  ($150,A5),($156,A5)
            pea     ($156,A5)
            move.w  #$E2,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($158,A5)
            move.w  #$D4,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($15C,A5)
            move.w  #$D8,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($160,A5)
            move.w  #$DC,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            tst.w   ($154,A5)
            bne.b   .L1
            move.w  ($150,A5),($154,A5)
            pea     ($154,A5)
            move.w  #$E0,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
.L1:
            move.l  ($36,A5),D2
            or.l    D2,($14C,A5)
            pea     ($14C,A5)
            move.w  #$D0,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            rts
.L2:
            dc.w    0,$0010,0,$0050,0,$00E0
            ds.b    4
            dc.w    $7C00,$2B7C,0,$0001,$015C,$2F0D,$4DFA,$0006
            dc.w    $4EFA,$D1A2,$2A5F,$4A86,$6620,$2B7C,0,$0002
            dc.w    $015C,$2F0D,$4DFA,$0006,$4EFA,$D1EC,$2A5F,$4A86
            dc.w    $6606,$42AD,$0160,$6002,$2C01,$2B46,$0160,$4E75
            moveq   #0,D6
            movea.l ($2E,A5),A3
.L3:
            movea.l (A3)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L5
            movea.l (A3)+,A1
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L4
            move.l  SP,D0
            andi.b  #$FC,D0
            movea.l D0,A1
.L4:
            move.l  #1,($15C,A5)
            BSR6    CritProc
            tst.l   D6
            bne.b   .L6
            move.l  #2,($15C,A5)
            BSR6    RevMod3Test
            tst.l   D6
            bne.b   .L6
            move.l  #3,($15C,A5)
            BSR6    ExtRAMTest
            tst.l   D6
            bne.b   .L6
            bra.b   .L3
.L5:
            movea.l ($2E,A5),A0
            movea.l (A0),A0
            lea     ($100,A0),A0
            move.l  #4,($15C,A5)
            BSR6    DataBusTest
            move.l  D6,($160,A5)
            rts
.L6:
            movea.l ($2E,A5),A1
            suba.l  A1,A3
            move.l  A3,D0
            lsl.l   #1,D0
            or.l    D0,($15C,A5)
            move.l  D6,($160,A5)
            rts
            move.l  A5,-(SP)
            moveq   #0,D6
            move.l  #1,($15C,A5)
            movea.l ($2E,A5),A3
.L7:
            movea.l (A3)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L9
            movea.l (A3)+,A1
            move.l  A3,-(SP)
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L8
            move.l  SP,D0
            andi.b  #$FC,D0
            movea.l D0,A1
.L8:
            BSR6    MovInvTest
            movea.l (SP)+,A3
            tst.l   D6
            beq.b   .L7
            movea.l (SP)+,A5
            bra.b   .L6
.L9:
            movea.l (SP)+,A5
            move.l  D6,($160,A5)
            rts
.L10:
            dc.w    $444F,$4E45
            ds.b    14
