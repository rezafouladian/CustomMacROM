            include "Include/ROMHeader.s"

            EXPORT  OrigBootBeep6,OrigErrorBeep1,OrigErrorBeep2,OrigErrorBeep3,OrigErrorBeep4,SystemBeep

            SECTION "Beep",CODE

SystemBeep:
            movem.l D0-D7/A1-A6,-(SP)
            move    SR,D0
            andi.w  #$700,D0
            bne.b   .L4
            movea.l SMGlobals,A0
            tst.w   ($18,A0)
            beq.b   .L2
            bra.b   .L4
.L1:
            tst.b   GrafEnd
            bne.b   .L4
            clr.l   -(SP)
            _FlashMenuBar
            suba.l  A0,A0
            addq.w  #8,A0
            _Delay
            _FlashMenuBar
            bra.b   .L4
.L2:
            clr.w   -(SP)
            movea.l SP,A0
            move.l  #$2007C,D0
            _ReadXPRam
            move.w  (SP),D0
.L3:
            clr.l   -(SP)
            move.l  #'snd ',-(SP)
            move.w  D0,-(SP)
            move.b  ResLoad,D4
            move.b  #1,ResLoad
            _RGetResource
            move.b  D4,ResLoad
            movea.l (SP)+,A0
            clr.w   -(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            clr.w   -(SP)
            _SndPlay
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            tst.w   D0
            beq.b   .L4
            cmpi.w  #1,D1
            beq.b   .L1
            move.w  #1,D0
            move.w  D0,-(SP)
            bra.b   .L3
.L4:
            movem.l (SP)+,D0-D7/A1-A6
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
OrigBootBeep:
            movea.l A6,A2
            lea     OrigErrorBeep4.L14,A4
            BSR6    OrigErrorBeep4.L1
            movea.l A2,A6
            rts
OrigBootBeep6:
            lea     OrigErrorBeep4.L14,A4
            bra.b   OrigErrorBeep4.L1
OrigErrorBeep1:
            lea     OrigErrorBeep4.L15,A4
            bra.b   OrigErrorBeep4.L1
OrigErrorBeep2:
            lea     OrigErrorBeep4.L16,A4
            bra.b   OrigErrorBeep4.L1
OrigErrorBeep3:
            lea     OrigErrorBeep4.L17,A4
            bra.b   OrigErrorBeep4.L1
OrigErrorBeep4:
            lea     .L18,A4
.L1:
            clr.b   ($801,A3)
            clr.b   ($807,A3)
            move.w  (A4)+,D0
            lsl.w   #2,D0
            tst.b   ($800,A3)
            bne.b   .L2
            lsr.w   #5,D0
.L2:
            move.b  D0,($806,A3)
            moveq   #1,D0
            tst.b   ($800,A3)
            bne.b   .L3
            moveq   #0,D0
.L3:
            move.b  D0,($802,A3)
            lea     ($810,A3),A0
            moveq   #$1F,D0
.L4:
            clr.b   (A0)+
            dbra    D0,.L4
            moveq   #-2,D0
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  D0,(A0)+
            move.b  #2,($801,A3)
            clr.b   ($803,A3)
            move.l  #$C001FF40,D0
            tst.b   ($800,A3)
            bne.b   .L5
            move.l  #$30013F10,D0
.L5:
            movea.l A3,A0
            moveq   #$1F,D1
.L6:
            moveq   #$3F,D2
.L7:
            move.b  D0,(A0)+
            dbra    D2,.L7
            ror.l   #8,D0
            dbra    D1,.L6
            movem.l (A4)+,D0-D2
            move.w  (A4)+,D3
            moveq   #0,D5
            lea     ($1C00,A5),A5
            lea     ($814,A3),A1
            movea.l A3,A0
            lea     ($200,A3),A3
            bra.b   .L11
.L8:
            move.b  (A0)+,D4
            cmpa.l  A0,A3
            bhi.b   .L9
            lea     (-$200,A0),A0
.L9:
            add.b   (A0),D4
            roxr.b  #1,D4
            move.b  D4,($600,A0)
            move.b  D4,($400,A0)
            move.b  D4,($200,A0)
            move.b  D4,(A0)
            move.w  D0,D4
.L10:
            tst.b   (A5)
            dbra    D4,.L10
.L11:
            dbra    D5,.L12
            tst.w   D3
            beq.b   .L12
            move.w  D1,D5
            move.b  (A4)+,(A1)+
            move.b  (A4)+,(A1)+
            move.b  (A4)+,(A1)+
            move.b  (A4)+,(A1)+
            addq.w  #4,A1
            subq.w  #1,D3
.L12:
            dbra    D2,.L8
            lea     (-$200,A3),A3
            lea     (-$1C00,A5),A5
            lea     ($814,A3),A0
            moveq   #3,D2
.L13:
            clr.b   (A0)+
            clr.b   (A0)+
            clr.b   (A0)+
            clr.b   (A0)+
            addq.w  #4,A0
            dbra    D2,.L13
            clr.b   ($801,A3)
            RTS6
.L14:
            dc.w    $0204,0,$000D,0,$012C,0,$7530,$0004
            dc.w    $0001,$8000,$0002,0,$0001,$8179,$0003,0
.L15:
            dc.w    $0607,0,$0027
            ds.b    6
            dc.w    $1388,$0004,0,$C09C,0,$E0B6,$0001,$20EA
            dc.w    $0001,$82B1
.L16:
            dc.w    $0506,0,$0027,0,$0BB8,0,$4E20,$0001
            dc.w    $0003,$0272
.L17:
            dc.w    $0506,0,$0027,0,$0BB8,0,$4E20,$0002
            dc.w    $0003,$0272,$0004,$8524
.L18:
            dc.w    $0607,0,$002B,0,$0BB8,0,$61A8,$0004
            dc.w    $0001,$43EF,$0001,$94EB,$0001,$E5E7,$0002,$8957
            ds.b    12

            EVEN
