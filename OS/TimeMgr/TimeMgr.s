            include "Include/ROMHeader.s"

            EXPORT  InitTimeMgr,InsTime,PrimeTime,TimeMgr

            SECTION "TimeMgr",CODE

TimeMgr:
RmvTime:
            move.l  D3,-(SP)
            bsr.w   FreezeTime
            moveq   #0,D2
            lea     (A2),A1
.L1:
            move.l  (A1),D0
            beq.b   .L3
            exg     D0,A1
            move.l  ($A,A1),D1
            add.l   D1,D2
            cmpa.l  A0,A1
            bne.b   .L1
            movea.l D0,A1
            move.l  (A0),D0
            move.l  D0,(A1)
            beq.b   .L2
            movea.l D0,A1
            add.l   D1,($A,A1)
.L2:
            move.l  D2,D0
.L3:
            sub.l   ($C,A2),D0
            bcc.b   .L4
            moveq   #0,D0
.L4:
            bsr.w   ThawTime
            movea.l D0,A1
            bsr.b   MultAndMerge
            _NewEmptyHandle clear
            dc.w    $10BC,$F800,0,$EB98,$4480,$6B0C,$2009,$6126
            dc.w    $053A,$8FE6
            ds.b    4
            dc.w    $2140,$000A,$261F,$7200
InsTime:
            moveq   #$1F,D0
            and.b   (4,A0),D0
            andi.w  #$600,D1
            lsr.w   #4,D1
            or.b    D1,D0
            move.b  D0,(4,A0)
            moveq   #0,D0
            rts
MultAndMerge:
            movea.l (SP)+,A2
            move.l  (A2)+,D1
            mulu.l  D0,D0:D1
            move.l  (A2)+,D2
            beq.b   .L1
            and.l   D2,D1
            add.l   D0,D2
            subx.l  D2,D2
            or.l    D2,D0
            or.l    D1,D0
.L1:
            jmp     (A2)
PrimeTime:
            move.l  D3,-(SP)
            tst.l   D0
            bpl.b   .L1
            neg.l   D0
            bsr.b   MultAndMerge
            dc.w    $0C88,$A47F
            ds.b    4
            dc.w    $600C
.L1:
            bsr.b   MultAndMerge
            muls.w  (SP),D1
            dc.w    $0A3E,$FC00,0,$ED98,$6100,$0082,$08E8,$0007
            dc.w    $0004,$666E,$0828,$0006,$0004,$6740,$242A,$0008
            dc.w    $2228,$000E,$672C,$9282,$6A26,$D081,$6524,$D480
            dc.w    $6602,$7401,$2142,$000E,$2200,$91AA,$000C,$7000
            dc.w    $43D2,$2411,$6734,$C589,$93A9,$000A,$C589,$602A
            dc.w    $D081,$D480,$6602,$7401,$2142,$000E,$D0AA,$000C
            dc.w    $43D2,$2411,$6714,$C589,$2229,$000A,$9081,$64F2
            dc.w    $D081,$9280,$2341,$000A,$C589,$2082,$2140,$000A
            dc.w    $2288,$6100,$009C,$261F,$7000,$4E75
FreezeTime:
            move    SR,D3
            swap    D3
            move.w  #$F0,D3
            movea.l VIA,A1
            lea     (vT2CH,A1),A1
            movea.l TimeVars,A2
            ori     #$700,SR
            move.b  (A1),D2
            moveq   #$20,D1
            and.b   ($800,A1),D1
            neg.l   D1
            move.b  D2,D1
            lsl.w   #8,D1
            move.b  (-$200,A1),D1
            sub.b   (A1),D2
            beq.b   .L1
            subx.l  D2,D2
            or.l    D2,D1
            move.b  (A1),D1
            lsl.w   #8,D1
            move.b  (-$200,A1),D1
.L1:
            moveq   #$F,D2
            add.l   D2,D1
            and.b   D1,D3
            asr.l   #4,D1
            sub.l   D1,(8,A2)
            move.l  (A2),D2
            beq.b   .L3
            movea.l D2,A1
            moveq   #0,D2
            sub.l   ($C,A2),D1
            bpl.b   .L4
            add.l   ($A,A1),D1
            bcs.b   .L2
            sub.l   D1,D2
            moveq   #0,D1
.L2:
            move.l  D1,($A,A1)
.L3:
            move.l  D2,($C,A2)
            rts
.L4:
            add.l   ($A,A1),D1
            bra.b   .L2
sub_4080B02C:
            bsr.b   FreezeTime
            move.l  (A2),D0
            beq.b   ThawTime
            movea.l D0,A0
            tst.l   ($A,A0)
            bne.b   ThawTime
            move.l  (A0),(A2)
            bclr    #7,(4,A0)
            bsr.b   ThawTime
            move.l  (6,A0),D0
            beq.b   .L1
            movea.l A0,A1
            movea.l D0,A0
            jmp     (A0)
.L1:
            rts
ThawTime:
            move.l  #$FFF,D2
            add.b   (4,A2),D3
            move.l  (A2),D1
            beq.b   .L4
            movea.l D1,A1
            move.l  ($A,A1),D1
            sub.l   ($C,A2),D1
            bcc.b   .L1
            neg.l   D1
            move.l  D1,($C,A2)
            moveq   #0,D1
            bra.b   .L2
.L1:
            clr.l   ($C,A2)
.L2:
            cmp.l   D2,D1
            bcc.b   .L3
            move.l  D1,D2
.L3:
            sub.l   D2,D1
            move.l  D1,($A,A1)
.L4:
            movea.l VIA,A1
            lea     (vT2C,A1),A1
            move.w  D3,D1
.L5:
            add.l   D2,(8,A2)
            lsl.w   #4,D2
            lea     ($200,A1),A2
            sub.b   (A1),D3
            sub.w   D3,D2
            bls.b   .L6
            move.b  D1,(A2)
            move.b  D2,(A1)
            lsr.w   #8,D2
            move.b  D2,(A2)
            swap    D3
            move    D3,SR
            rts
.L6:
            add.w   D2,D3
            sub.b   D3,D1
            neg.w   D2
            movea.l TimeVars,A2
            add.w   (6,A2),D2
            lsr.w   #4,D2
            add.l   D2,($C,A2)
            move.w  D1,D3
            bra.b   .L5
InitTimeMgr:
            movem.l D0-D5/A0-A4,-(SP)
            moveq   #$10,D0
            _NewPtrSysClear
            move.l  A0,TimeVars
            movea.l A0,A2
            move.w  #$18,(6,A2)
            lea     sub_4080B02C,A1
            move.l  A1,($1A6).w
            move    SR,-(SP)
            ori     #$700,SR
            movea.l VIA,A4
            lea     (vT2C,A4),A1
            lea     (vT1C,A4),A3
            lea     (vACR,A4),A4
            moveq   #-$60,D1
            move.b  D1,($C00,A1)
            moveq   #-$21,D5
            and.b   (A4),D5
            moveq   #$3F,D0
            and.b   D5,D0
            move.b  D0,(A4)
            moveq   #0,D3
            move    SR,D3
            swap    D3
            move.b  D1,($200,A3)
            move.b  D1,($200,A1)
            move.b  (A1),D0
            sub.b   (A3),D0
            bsr.w   ThawTime
            move.b  (A1),D1
            sub.b   (A3),D1
            sub.b   D0,D1
            subi.w  #$FFF0,D1
            move.b  D1,(4,A0)
            move.b  D5,(A4)
            st      ($200,A1)
            move    (SP)+,SR
            movem.l (SP)+,D0-D5/A0-A4
            rts
            ds.b    6

            EVEN
