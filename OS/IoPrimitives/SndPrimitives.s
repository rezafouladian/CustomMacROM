            include "Include/ROMHeader.s"

            EXPORT  SNDCNTLECLIPSE,SNDCNTLSPIKE,SNDCNTLTIM

            IMPORT  USTPMGRSENDBYTE,ClearASCInt,DisableASCInts,EnableASCInts,SendEgretCmd

            SECTION "SndPrimitives",CODE

SNDPRIM:
            dc.w    11                          ; number of entries, TIM (PowerBook 140/170)
SNDCNTLTIM:
            dc.l    TimDFACInit-SNDCNTLTIM ; DFACInit
            dc.l    VIA2DFACSend-SNDCNTLTIM ; DFACSend
            dc.l    TimPlayBackVol-SNDCNTLTIM ; SetVol
            dc.l    EnableASCInts-SNDCNTLTIM ; EnableASCInts
            dc.l    DisableASCInts-SNDCNTLTIM ; DisableASCInts
            dc.l    ClearASCInt-SNDCNTLTIM ; ClearASCInt
            dc.l    TIMInputSelect-SNDCNTLTIM ; InputSelect
            dc.l    QueryInput-SNDCNTLTIM ; QueryInput
            dc.l    ByPassControl-SNDCNTLTIM ; ByPassControl
            dc.l    PlayThruVol-SNDCNTLTIM ; PlayThruVol
            dc.l    AGCControl-SNDCNTLTIM ; AGCControl
            dc.w    11                          ; number of entries, Eclipse (Quadra 900/950)
SNDCNTLECLIPSE:
            dc.l    EclipseDFACInit-SNDCNTLECLIPSE ; DFACInit
            dc.l    EgretDFACSend-SNDCNTLECLIPSE ; DFACSend
            dc.l    ASCSetVol-SNDCNTLECLIPSE ; SetVol
            dc.l    EnableASCInts-SNDCNTLECLIPSE ; EnableASCInts
            dc.l    DisableASCInts-SNDCNTLECLIPSE ; DisableASCInts
            dc.l    ClearASCInt-SNDCNTLECLIPSE ; ClearASCInt
            dc.l    EclipseInputSelect-SNDCNTLECLIPSE ; InputSelect
            dc.l    QueryInput-SNDCNTLECLIPSE ; QueryInput
            dc.l    ByPassControl-SNDCNTLECLIPSE ; ByPassControl
            dc.l    PlayThruVol-SNDCNTLECLIPSE ; PlayThruVol
            dc.l    AGCControl-SNDCNTLECLIPSE ; AGCControl
            dc.w    11                          ; number of entries, Spike (Quadra 700)
SNDCNTLSPIKE:
            dc.l    SpikeDFACInit-SNDCNTLSPIKE ; DFACInit
            dc.l    VIA2DFACSend-SNDCNTLSPIKE ; DFACSend
            dc.l    ASCSetVol-SNDCNTLSPIKE ; SetVol
            dc.l    EnableASCInts-SNDCNTLSPIKE ; EnableASCInts
            dc.l    DisableASCInts-SNDCNTLSPIKE ; DisableASCInts
            dc.l    ClearASCInt-SNDCNTLSPIKE ; ClearASCInt
            dc.l    InputSelect-SNDCNTLSPIKE ; InputSelect
            dc.l    QueryInput-SNDCNTLSPIKE ; QueryInput
            dc.l    ByPassControl-SNDCNTLSPIKE ; ByPassControl
            dc.l    PlayThruVol-SNDCNTLSPIKE ; PlayThruVol
            dc.l    AGCControl-SNDCNTLSPIKE ; AGCControl
            dc.w    11                          ; number of entries, Apollo (Classic II / LC "Elsie")
SNDCNTLAPOLLO:
            dc.l    ElsieDFACInit-SNDCNTLAPOLLO ; DFACInit
            dc.l    EgretDFACSend-SNDCNTLAPOLLO ; DFACSend
            dc.l    ASCSetVol-SNDCNTLAPOLLO ; SetVol
            dc.l    EnableASCInts-SNDCNTLAPOLLO ; EnableASCInts
            dc.l    DisableASCInts-SNDCNTLAPOLLO ; DisableASCInts
            dc.l    ClearASCInt-SNDCNTLAPOLLO ; ClearASCInt
            dc.l    ElsieInputSelect-SNDCNTLAPOLLO ; InputSelect
            dc.l    QueryInput-SNDCNTLAPOLLO ; QueryInput
            dc.l    ByPassControl-SNDCNTLAPOLLO ; ByPassControl
            dc.l    PlayThruVol-SNDCNTLAPOLLO ; PlayThruVol
            dc.l    AGCControl-SNDCNTLAPOLLO ; AGCControl
            dc.w    11                          ; number of entries, DBLite
SNDCNTLDBLITE:
            dc.l    DBLiteDFACInit-SNDCNTLDBLITE ; DFACInit
            dc.l    DBLiteDFACSend-SNDCNTLDBLITE ; DFACSend
            dc.l    ASCSetVol-SNDCNTLDBLITE ; SetVol
            dc.l    EnableASCInts-SNDCNTLDBLITE ; EnableASCInts
            dc.l    DisableASCInts-SNDCNTLDBLITE ; DisableASCInts
            dc.l    ClearASCInt-SNDCNTLDBLITE ; ClearASCInt
            dc.l    InputSelect-SNDCNTLDBLITE ; InputSelect
            dc.l    QueryInput-SNDCNTLDBLITE ; QueryInput
            dc.l    ByPassControl-SNDCNTLDBLITE ; ByPassControl
            dc.l    PlayThruVol-SNDCNTLDBLITE ; PlayThruVol
            dc.l    AGCControl-SNDCNTLDBLITE ; AGCControl
EclipseDFACInit:
            moveq   #0,D1
            bra.b   EgretDFACInit.common
ElsieDFACInit:
            moveq   #-$16,D1
            bra.b   EgretDFACInit.common
EgretDFACInit:
            moveq   #0,D1
.common:
            movea.l A6,A3
            move.l  #$E0001,D0                  ; WrDFAC pseudo command
            moveq   #1,D2
            BigBSR6 SendEgretCmd,A2
            tst.w   D0
            jmp     (A3)
EgretDFACSend:
            movem.l D1-D3/A0-A1,-(SP)
            move.l  D0,D3
            moveq   #0,D1
            moveq   #7,D2
.Loop:
            asr.b   #1,D0
            roxl.b  #1,D1
            dbra    D2,.Loop
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
            bne.b   .Done
            movea.l ([ExpandMem.w],$1AA.w),A0
            move.b  D3,(-3,A0)
.Done:
            movem.l (SP)+,D1-D3/A0-A1
            rts
TimPlayBackVol:
            move.l  A0,-(SP)
            andi.w  #$FF,D0
            move.b  .TimVolumeTable(PC,D0.w),D0
            move    SR,-(SP)
            ori     #$700,SR
            movea.l ASCBase,A0
            move.b  D0,(bmLeftScaleA,A0)
            clr.b   (bmRightScaleA,A0)
            clr.b   (bmLeftScaleB,A0)
            move.b  D0,(bmRightScaleB,A0)
            move    (SP)+,SR
            movea.l (SP)+,A0
            rts
.TimVolumeTable:
            dc.b    1,18,36,54,72,90,108,127
AGCInputSelect:
            tst.b   D0
            beq.b   InputSelect
            ori.b   #8,D0
InputSelect:
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
            beq.b   .send
            or.b    (-4,A0),D1
            or.b    (-5,A0),D1
.send:
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
EclipseInputSelect:
            move    SR,-(SP)
            ori     #$700,SR
            movem.l D0-D1,-(SP)
            move.b  ([VIA2.w]),D1
            andi.b  #$B7,D1
            andi.w  #$FF,D0
            or.b    EclipseSelectTable(PC,D0.w),D1
            move.b  D1,([VIA2.w])
            movem.l (SP)+,D0-D1
            move    (SP)+,SR
            tst.b   D0
            beq.b   InputSelect
            moveq   #1,D0
            bra.b   InputSelect
EclipseSelectTable:
            dc.b    $00,$40,$48,$08
ElsieInputSelect:
            cmpi.b  #1,D0
            beq.w   InputSelect
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
TIMInputSelect:
            move    SR,-(SP)
            movem.l D2/A0-A1,-(SP)
            movea.l PmgrBase,A1
            movea.l ([ExpandMem.w],$1AA.w),A0
            ori     #$700,SR
            moveq   #3,D2
            and.b   (-3,A0),D2
            beq.b   .currentlyOff
            tst.b   D0
            bne.b   .setsource
            subq.b  #1,($F8,A1)
            bra.b   .setsource
.currentlyOff:
            tst.b   D0
            beq.b   .setsource
            addq.b  #1,($F8,A1)
.setsource:
            movem.l (SP)+,D2/A0-A1
            bsr.w   AGCInputSelect
            move    (SP)+,SR
            rts
PlayThruVol:
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            move    SR,-(SP)
            ori     #$700,SR
            asl.b   #5,D0
            move.b  D0,(-4,A0)
            moveq   #-4,D1
            and.b   (-3,A0),D1
            beq.b   .Done
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
.Done:
            move    (SP)+,SR
            movem.l (SP)+,D1/A0
            rts
AGCControl:
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #4,D1
            tst.b   D0
            beq.b   .continue
            moveq   #8,D1
.continue:
            move    SR,-(SP)
            ori     #$700,SR
            move.b  D1,(-5,A0)
            moveq   #-4,D0
            and.b   (-3,A0),D0
            beq.b   .Done
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
.Done:
            move    (SP)+,SR
            movem.l (SP)+,D1/A0
            rts
SpikeDFACInit:
            moveq   #0,D0
            bra.b   VIA2DFACInit
TimDFACInit:
            moveq   #0,D0
VIA2DFACInit:
            movea.l ($2C,A0),A3
            bset    #0,(A3)
            bset    #4,(A3)
            bclr    #0,(A3)
            moveq   #7,D1
.Loop:
            asr.b   #1,D0
            bcc.b   .zeroBit
            bset    #3,(A3)
            bra.b   .clock
.zeroBit:
            bclr    #3,(A3)
.clock:
            bclr    #4,(A3)
            bset    #4,(A3)
            dbra    D1,.Loop
            bset    #0,(A3)
            RTS6
VIA2DFACSend:
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
.Loop:
            asr.b   #1,D0
            bcc.b   .zeroBit
            bset    #3,(A0)
            bra.b   .clock
.zeroBit:
            bclr    #3,(A0)
.clock:
            bclr    #4,(A0)
            bset    #4,(A0)
            dbra    D1,.Loop
            bset    #0,(A0)
            move    (SP)+,SR
            movem.l (SP)+,D1-D2/A0
            rts
ASCSetVol:
            move.l  A0,-(SP)
            movea.l ASCBase,A0
            lsl.b   #5,D0
            move.b  D0,($806,A0)
            movea.l (SP)+,A0
            rts
ByPassControl:
            movem.l D1/A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #0,D1
            tst.b   D0
            beq.b   .continue
            moveq   #$10,D1
.continue:
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
QueryInput:
            move.l  A0,-(SP)
            movea.l ([ExpandMem.w],$1AA.w),A0
            moveq   #3,D0
            and.b   (-3,A0),D0
            movea.l (SP)+,A0
            rts
DBLiteDFACInit:
            moveq   #-$1E,D0
            movea.l (8,A0),A2
            movea.l ($2C,A0),A3
            BigBSR5 USTPMGRSENDBYTE,A4
            move.b  D0,D3
            BigBSR5 USTPMGRSENDBYTE,A4
            RTS6
DBLiteDFACSend:
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
