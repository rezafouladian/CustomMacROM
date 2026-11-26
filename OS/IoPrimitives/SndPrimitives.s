            include "Include/ROMHeader.s"

            EXPORT  SNDCNTLECLIPSE,SNDCNTLSPIKE,SNDCNTLTIM

            IMPORT  USTPMGRSENDBYTE

            SECTION "SndPrimitives",CODE

SNDPRIM:
            dc.w    $000B
SNDCNTLTIM:
            dc.w    0,$0320,0,$0354,0,$0160,$FFF7,$DC0C
            dc.w    $FFF7,$DC2C,$FFF7,$DC4A,0,$024A,0,$03F4
            dc.w    0,$03B2,0,$0286,0,$02CE,$000B
SNDCNTLECLIPSE:
            dc.w    0,$00B6,0,$00DC,0,$0374,$FFF7,$DBDE
            dc.w    $FFF7,$DBFE,$FFF7,$DC1C,0,$01BC,0,$03C6
            dc.w    0,$0384,0,$0258,0,$02A0,$000B
SNDCNTLSPIKE:
            dc.w    0,$02C0,0,$02F8,0,$0346,$FFF7,$DBB0
            dc.w    $FFF7,$DBD0,$FFF7,$DBEE,0,$013E,0,$0398
            dc.w    0,$0356,0,$022A,0,$0272,$000B
SNDCNTLAPOLLO:
            dc.w    0,$005E,0,$0080,0,$0318,$FFF7,$DB82
            dc.w    $FFF7,$DBA2,$FFF7,$DBC0,0,$0194,0,$036A
            dc.w    0,$0328,0,$01FC,0,$0244,$000B
SNDCNTLDBLITE:
            dc.w    0,$0350,0,$037A,0,$02EA,$FFF7,$DB54
            dc.w    $FFF7,$DB74,$FFF7,$DB92,0,$00E2,0,$033C
            dc.w    0,$02FA,0,$01CE,0,$0216,$7200,$6006
            dc.w    $72EA,$6002,$7200,$264E,$203C,$000E,$0001,$7401
            dc.w    $4DFA,$000C,$45F9,$FFF8,$87CA,$4EFB,$A8F8,$4A40
            dc.w    $4ED3
            movem.l D1-D3/A0-A1,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            moveq   #7,D2
.L1:
            asr.b   #1,D0
            roxl.b  #1,D1
            dbra    D2,.L1
            suba.w  #$14,SP
            movea.l SP,A0
            move.b  #1,(A0)
            move.b  #$E,(1,A0)
            move.w  #1,(6,A0)
            clr.l   (8,A0)
            clr.w   ($C,A0)
            clr.w   ($E,A0)
            clr.l   ($10,A0)
            move.b  D1,(2,A0)
            _EgretDispatch
            lea     ($14,SP),SP
            bne.b   .L2
            movea.l ([ExpandMem.w],$1AA.w),A0
            move.b  D3,(-3,A0)
.L2:
            movem.l (SP)+,D1-D3/A0-A1
            rts
            move.l  A0,-(SP)
            andi.w  #$FF,D0
            move.b  sub_4088C58C(PC,D0.w),D0
            move    SR,-(SP)
            ori     #$700,SR
            movea.l ASCBase,A0
            move.b  D0,($F06,A0)
            clr.b   ($F07,A0)
            clr.b   ($F26,A0)
            move.b  D0,($F27,A0)
            move    (SP)+,SR
            movea.l (SP)+,A0
            rts
sub_4088C58C:
            btst    D0,(A2)
            move.l  ($5A,A6,D4.l),D2
            bge.b   sub_4088C59C.L3+1
sub_4088C594:
            tst.b   D0
            beq.b   sub_4088C59C
            dc.w    0,$0008
sub_4088C59C:
            movem.l D1/A0-A1,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #3,D2
            and.b   (-3,A0),D2
            moveq   #$10,D1
            and.b   (-3,A0),D1
            or.b    D0,D1
            tst.b   D0
            beq.b   .L1
            or.b    (-4,A0),D1
            or.b    (-5,A0),D1
.L1:
            move.b  D1,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L2
            movea.l (4,A0),A0
            jsr     (A0)
.L2:
            movea.l (SP)+,A0
            move    (SP)+,SR
            move.b  D2,D0
            movem.l (SP)+,D1/A0-A1
            rts
            move    SR,-(SP)
            ori     #$700,SR
            movem.l D0-D1,-(SP)
            move.b  ([VIA2.w]),D1
            andi.b  #$B7,D1
            andi.w  #$FF,D0
            or.b    sub_4088C61C(PC,D0.w),D1
            move.b  D1,([VIA2.w])
            movem.l (SP)+,D0-D1
.L3:
            move    (SP)+,SR
            tst.b   D0
            beq.b   sub_4088C59C
            moveq   #1,D0
            bra.b   sub_4088C59C
sub_4088C61C:
            ori.w   #$4808,D0
            cmpi.b  #1,D0
            beq.w   sub_4088C59C
            movem.l D1/A0,-(SP)
            moveq   #-$16,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L1
            movea.l (4,A0),A0
            jsr     (A0)
.L1:
            movea.l (SP)+,A0
            movem.l (SP)+,D1/A0
            rts
            move    SR,-(SP)
            movem.l D2/A0-A1,-(SP)
            movea.l PmgrBase,A1
            movea.l ([ExpandMem.w],$1AA.w),A0
            ori     #$700,SR
            moveq   #3,D2
            and.b   (-3,A0),D2
            beq.b   .L2
            tst.b   D0
            bne.b   .L3
            subq.b  #1,($F8,A1)
            bra.b   .L3
.L2:
            tst.b   D0
            beq.b   .L3
            addq.b  #1,($F8,A1)
.L3:
            movem.l (SP)+,D2/A0-A1
            bsr.w   sub_4088C594
            move    (SP)+,SR
            rts
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            move    SR,-(SP)
            ori     #$700,SR
            asl.b   #5,D0
            move.b  D0,(-4,A0)
            moveq   #-4,D1
            and.b   (-3,A0),D1
            beq.b   .L5
            moveq   #$1F,D1
            and.b   (-3,A0),D1
            or.b    D1,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L4
            movea.l (4,A0),A0
            jsr     (A0)
.L4:
            movea.l (SP)+,A0
.L5:
            move    (SP)+,SR
            movem.l (SP)+,D1/A0
            rts
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #4,D1
            tst.b   D0
            beq.b   .L6
            moveq   #8,D1
.L6:
            move    SR,-(SP)
            ori     #$700,SR
            move.b  D1,(-5,A0)
            moveq   #-4,D0
            and.b   (-3,A0),D0
            beq.b   .L8
            moveq   #-$D,D0
            and.b   (-3,A0),D0
            or.b    D1,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L7
            movea.l (4,A0),A0
            jsr     (A0)
.L7:
            movea.l (SP)+,A0
.L8:
            move    (SP)+,SR
            movem.l (SP)+,D1/A0
            rts
            moveq   #0,D0
            bra.b   .L9
            moveq   #0,D0
.L9:
            movea.l ($2C,A0),A3
            bset    #0,(A3)
            bset    #4,(A3)
            bclr    #0,(A3)
            moveq   #7,D1
.L10:
            asr.b   #1,D0
            bcc.b   .L11
            bset    #3,(A3)
            bra.b   .L12
.L11:
            bclr    #3,(A3)
.L12:
            bclr    #4,(A3)
            bset    #4,(A3)
            dbra    D1,.L10
            bset    #0,(A3)
            RTS6
            movem.l D1-D2/A0,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            movea.l ([ExpandMem.w],$1AA.w),A0
            move.b  D0,(-3,A0)
            movea.l VIA2,A0
            bset    #0,(A0)
            bset    #4,(A0)
            bclr    #0,(A0)
            moveq   #7,D1
.L13:
            asr.b   #1,D0
            bcc.b   .L14
            bset    #3,(A0)
            bra.b   .L15
.L14:
            bclr    #3,(A0)
.L15:
            bclr    #4,(A0)
            bset    #4,(A0)
            dbra    D1,.L13
            bset    #0,(A0)
            move    (SP)+,SR
            movem.l (SP)+,D1-D2/A0
            rts
            move.l  A0,-(SP)
            movea.l ASCBase,A0
            lsl.b   #5,D0
            move.b  D0,($806,A0)
            movea.l (SP)+,A0
            rts
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #0,D1
            tst.b   D0
            beq.b   .L16
            moveq   #$10,D1
.L16:
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #-$11,D0
            and.b   (-3,A0),D0
            or.b    D1,D0
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            tst.l   (4,A0)
            beq.b   .L17
            movea.l (4,A0),A0
            jsr     (A0)
.L17:
            movea.l (SP)+,A0
            move    (SP)+,SR
            movem.l (SP)+,D1/A0
            rts
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #3,D0
            and.b   (-3,A0),D0
            movea.l (SP)+,A0
            rts
            moveq   #-$1E,D0
            movea.l (8,A0),A2
            movea.l ($2C,A0),A3
            BigBSR5 USTPMGRSENDBYTE,A4
            move.b  D0,D3
            BigBSR5 USTPMGRSENDBYTE,A4
            RTS6
            movem.l D1-D2/A0-A1,-(SP)
            move.b  D0,-(SP)
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.w  #1,-(SP)
            move.w  #$91,-(SP)
            _PMgrOp
            lea     ($E,SP),SP
            movem.l (SP)+,D1-D2/A0-A1
            rts
            ds.b    1966

            EVEN
