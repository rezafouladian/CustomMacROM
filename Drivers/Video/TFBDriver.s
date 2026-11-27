            include "Include/ROMHeader.s"

            SECTION "TFBDriver",CODE

TFBDRVR:
            dc.b    $4C
            ds.b    8
            dc.b    $2E,$00,$00,$01,$1E,$05,$8E,$00,$EA,$18
            dc.b    '.Display_Video_Apple_TFB'
            dc.b    $00,$00,$06,$26,$49,$70,$18,$A4,$40,$70,$18,$A7,$22,$66,$00,$00
            dc.b    $AC,$27,$48,$00,$14,$A0,$29,$22,$50,$49,$FA,$08,$EC,$70,$10,$A7
            dc.b    $1E,$66,$00,$00,$92,$23,$48,$00,$0C,$31,$7C,$00,$06,$00,$04,$21
            dc.b    $4C,$00,$08,$21,$6B,$00,$2A,$00,$0C,$70,$00,$10,$2B,$00,$28,$A0
            dc.b    $75,$66,$6C,$70,$00,$30,$3C,$01,$0C,$A7,$1E,$66,$56,$23,$48,$00
            dc.b    $10,$42,$98,$70,$01,$20,$C0,$20,$FC,$01,$00,$00,$08,$30,$3C,$00
            dc.b    $FF,$12,$00,$46,$01,$10,$C1,$51,$C8,$FF,$F8,$42,$69,$00,$14,$20
            dc.b    $6B,$00,$2A,$22,$3C,$00,$04,$23,$FC,$21,$BC,$4D,$41,$43,$32,$18
            dc.b    $00,$2F,$3C,$FF,$FF,$FF,$FF,$42,$9F,$20,$30,$18,$00,$0C,$80,$4D
            dc.b    $41,$43,$32,$56,$E9,$00,$16,$D1,$FC,$00,$0A,$00,$03,$42,$10,$70
            dc.b    $00
.L1:
            rts
            movea.l ($C,A1),A0
            moveq   #0,D0
            move.b  ($28,A3),D0
            _SIntRemove
            movea.l ($C,A1),A0
            _DisposPtr
            movea.l ($14,A3),A0
            _DisposHandle
            moveq   #-$17,D0
            bra.b   .L1
            movea.l ($2A,A1),A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            movea.l ($14,A1),A2
            movea.l (A2),A2
            movea.l ($C,A2),A0
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntRemove
            movea.l ($C,A2),A0
            _DisposPtr
            movea.l ($10,A2),A0
            _DisposPtr
            movea.l ($14,A1),A0
            _DisposHandle
            moveq   #0,D0
            rts
            movem.l D4/A0/A4,-(SP)
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #7,D0
            bhi.b   .L4
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L7-.L2
            dc.w    .L5-.L2
            dc.w    .L8-.L2
            dc.w    sub_40897D3E.L3-.L2
            dc.w    sub_40897D3E.L20-.L2
            dc.w    sub_40897D3E.L29-.L2
            dc.w    sub_40897D3E.L30-.L2
            dc.w    sub_40897D3E.L31-.L2
.L3:
            addq.w  #4,SP
.L4:
            moveq   #-$11,D0
            bra.b   .L6
.L5:
            moveq   #0,D0
.L6:
            movem.l (SP)+,D4/A0/A4
            bra.w   WaitVSync_TFBDriver.L4
.L7:
            bsr.w   sub_40898346
            move.w  #$80,(A2)
            move.w  #1,D1
            moveq   #0,D0
            move.w  D0,(6,A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            bsr.w   TFBSetDepth
            bsr.w   TFBSetPage
            move.l  (8,A3),(8,A2)
            bsr.w   GrayScreen_TFBDriver
            bra.b   .L5
.L8:
            move.w  (A2),D1
            bsr.w   ChkMode_TFBDriver
            bne.b   .L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.b   .L4
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (A2),D2
            cmp.w   (4,A3),D2
            beq.b   .L9
            bsr.b   sub_40897D3E
            bsr.w   TFBSetDepth
            bsr.w   TFBSetPage
            bra.b   .L10
.L9:
            bsr.w   TFBSetPage
.L10:
            move.l  (8,A3),(8,A2)
            bra.b   .L5
sub_40897D3E:
            movem.l D0-D1/A0-A1,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            bsr.w   WaitVSync_TFBDriver
            movea.l ($14,A1),A0
            movea.l (A0),A0
            movea.l ($10,A0),A0
            move.w  (4,A0),D0
            lea     ($C,A0),A0
            adda.w  D0,A0
            move.w  #$80,D1
            move.b  (0,A0,D1.w),D1
            not.b   D1
            movea.l ($2A,A1),A0
            adda.l  #$90018,A0
            move.w  #$FF,D0
.L2:
            move.b  D1,(A0)
            move.b  D1,(A0)
            move.b  D1,(A0)
            dbra    D0,.L2
            move    (SP)+,SR
            movem.l (SP)+,D0-D1/A0-A1
            rts
.L3:
            move.l  (A2),D0
            beq.w   TFBDRVR.L4
            movem.l D5-D7/A5-A6,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            move.w  ($14,A0),D5
            movea.l ($10,A0),A0
            move.w  (4,A0),D0
            lea     ($C,A0),A4
            adda.w  D0,A4
            movea.l A4,A5
            movea.l A4,A6
            cmpi.w  #1,(6,A0)
            beq.b   .L4
            move.w  (8,A0),D0
            move.w  ($A,A0),D1
            addq.w  #7,D1
            lsr.w   #3,D1
            mulu.w  D1,D0
            adda.w  D0,A5
            adda.w  D0,A6
            adda.w  D0,A6
.L4:
            suba.w  #$80,SP
            bsr.w   CvtIndex
            movea.l (A2),A0
            move.w  (4,A2),D1
            bmi.b   .L7
            cmpi.w  #$FF,D6
            bne.b   .L5
            cmpi.w  #4,(6,A2)
            bgt.w   .L13
.L5:
            movea.l SP,A3
            move.w  (6,A2),D0
.L6:
            move.w  D1,(A3)+
            move.l  (A0)+,D2
            move.w  D2,(A3)+
            move.l  (A0)+,(A3)+
            addq.w  #1,D1
            dbra    D0,.L6
            movea.l SP,A0
.L7:
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L8
            ori     #$200,SR
            andi    #$FAFF,SR
.L8:
            bsr.w   WaitVSync_TFBDriver
            move.w  (6,A2),D0
            movea.l ($2A,A1),A3
            adda.l  #$90018,A3
.L9:
            move.l  (A0)+,D2
            swap    D2
            moveq   #-1,D1
            move.w  D2,D1
            cmp.w   D6,D1
            bhi.b   .L11
            rol.l   D7,D1
            move.b  D1,(4,A3)
            swap    D2
            move.l  (A0)+,D3
            move.l  D3,D4
            swap    D3
            tst.w   D5
            bpl.b   .L10
            mulu.w  #$4CCC,D2
            mulu.w  #$970A,D3
            mulu.w  #$1C28,D4
            add.l   D3,D2
            add.l   D4,D2
            rol.l   #8,D2
            andi.w  #$FF,D2
            move.b  (0,A4,D2.w),D2
            not.b   D2
            move.b  D2,(A3)
            move.b  D2,(A3)
            move.b  D2,(A3)
            dbra    D0,.L9
            bra.b   .L12
.L10:
            ror.w   #8,D2
            moveq   #0,D1
            move.b  D2,D1
            move.b  (0,A4,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
            ror.w   #8,D3
            moveq   #0,D1
            move.b  D3,D1
            move.b  (0,A5,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
            ror.w   #8,D4
            moveq   #0,D1
            move.b  D4,D1
            move.b  (0,A6,D1.w),D1
            not.b   D1
            move.b  D1,(A3)
.L11:
            dbra    D0,.L9
.L12:
            move    (SP)+,SR
            lea     ($80,SP),SP
            movem.l (SP)+,D5-D7/A5-A6
            bra.w   TFBDRVR.L5
.L13:
            move.l  SP,D1
            move.l  D1,D0
            neg.w   D0
            andi.w  #3,D0
            beq.b   .L14
            suba.w  D0,SP
.L14:
            move.l  D1,-(SP)
            _StackSpace
            cmpi.l  #$500,D0
            blt.w   TFBDRVR.L3
            suba.w  #$400,SP
            move.w  (4,A2),D1
            lea     (0,SP,D1.w*4),A3
            move.w  (6,A2),D0
            movea.l (A2),A0
.L15:
            cmp.w   D6,D1
            bgt.b   .L17
            tst.w   D5
            bpl.b   .L16
            move.l  (A0)+,D2
            move.w  (A0)+,D3
            move.w  (A0)+,D4
            mulu.w  #$4CCC,D2
            mulu.w  #$970A,D3
            mulu.w  #$1C28,D4
            add.l   D3,D2
            add.l   D4,D2
            rol.l   #8,D2
            moveq   #0,D3
            move.b  D2,D3
            move.b  (0,A4,D3.w),D2
            move.b  D2,D3
            lsl.l   #8,D3
            move.b  D2,D3
            lsl.l   #8,D3
            move.b  D2,D3
            move.l  D3,(A3)+
            addq.w  #1,D1
            dbra    D0,.L15
            bra.b   .L17
.L16:
            moveq   #0,D2
            move.b  (6,A0),D2
            move.b  (0,A6,D2.w),D3
            lsl.l   #8,D3
            move.b  (4,A0),D2
            move.b  (0,A5,D2.w),D3
            lsl.l   #8,D3
            move.b  (2,A0),D2
            move.b  (0,A4,D2.w),D3
            move.l  D3,(A3)+
            addq.w  #1,D1
            addq.w  #8,A0
            dbra    D0,.L15
.L17:
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L18
            ori     #$200,SR
            andi    #$FAFF,SR
.L18:
            movea.l A3,A0
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A3
            adda.l  #$90003,A3
            moveq   #0,D1
            move.b  (5,A2),D1
            not.b   D1
            move.w  (6,A2),D0
            sub.w   D0,D1
            not.b   D1
            move.b  D1,($19,A3)
            adda.w  #$15,A3
.L19:
            move.l  -(A0),D1
            not.l   D1
            move.b  D1,(A3)
            lsr.l   #8,D1
            move.b  D1,(A3)
            lsr.l   #8,D1
            move.b  D1,(A3)
            dbra    D0,.L19
            move    (SP)+,SR
            lea     ($400,SP),SP
            movea.l (SP)+,SP
            lea     ($80,SP),SP
            movem.l (SP)+,D5-D7/A5-A6
            bra.w   TFBDRVR.L5
.L20:
            move.l  A1,-(SP)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.l  (A2),D0
            beq.w   .L26
            movea.l D0,A1
            tst.l   (A1)
            bne.b   .L25
            cmpi.w  #8,($A,A1)
            bne.b   .L25
            cmpi.w  #$100,(8,A1)
            bne.b   .L25
            movea.l ($10,A3),A0
            move.w  (4,A1),D0
            cmp.w   (4,A0),D0
            bne.b   .L21
            move.w  (6,A1),D0
            cmp.w   (6,A0),D0
            beq.b   .L22
            bgt.b   .L21
            _DisposPtr
            clr.l   ($10,A3)
.L21:
            move.w  #$100,D0
            mulu.w  (6,A1),D0
            add.w   (4,A1),D0
            addi.w  #$C,D0
            _NewPtrSys
            bne.b   .L25
            move.l  ($10,A3),D0
            move.l  A0,($10,A3)
            tst.l   D0
            beq.b   .L22
            movea.l D0,A0
            _DisposPtr
            movea.l ($10,A3),A0
.L22:
            move.w  (6,A1),D0
            move.w  (4,A1),D1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.w  #$100,D2
            mulu.w  D0,D2
            add.w   D1,D2
            subq.w  #1,D2
.L23:
            move.b  (A1)+,(A0)+
            dbra    D2,.L23
.L24:
            movea.l (SP)+,A1
            bra.w   TFBDRVR.L5
.L25:
            movea.l (SP)+,A1
            bra.w   TFBDRVR.L4
.L26:
            movea.l ($10,A3),A0
            move.w  (4,A0),D0
            move.w  (6,A0),D2
            subq.w  #1,D2
            lea     ($C,A0),A0
            adda.w  D0,A0
.L27:
            move.w  #$FF,D0
.L28:
            move.b  D0,(A0)
            not.b   (A0)+
            dbra    D0,.L28
            dbra    D2,.L27
            bra.b   .L24
.L29:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D1
            bsr.w   ChkMode_TFBDriver
            bne.w   TFBDRVR.L4
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.w   TFBDRVR.L4
            bsr.w   GrayScreen_TFBDriver
            bra.w   TFBDRVR.L5
.L30:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  ($14,A3),D0
            move.b  (A2),D1
            bfins   D1,D0{16:1}
            move.w  D0,($14,A3)
            bra.w   TFBDRVR.L5
.L31:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  ($14,A3),D0
            move.b  (A2),D1
            bfins   D1,D0{17:1}
            move.w  D0,($14,A3)
            btst    #$E,D0
            beq.b   .L32
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            movea.l ($C,A3),A0
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntRemove
            bra.w   TFBDRVR.L5
.L32:
            movea.l ($C,A3),A0
            lea     GrayScreen_TFBDriver.L6,A4
            move.w  #6,(4,A0)
            move.l  A4,(8,A0)
            move.l  ($2A,A1),($C,A0)
            moveq   #0,D0
            move.b  ($28,A1),D0
            _SIntInstall
            bne.w   TFBDRVR.L4
            movea.l ($2A,A1),A0
            adda.l  #$A0003,A0
            clr.b   (A0)
            bra.w   TFBDRVR.L5
            move.l  A0,-(SP)
            move.w  ($1A,A0),D0
            movea.l ($1C,A0),A2
            cmpi.w  #8,D0
            bhi.b   .L34
            lsl.w   #1,D0
            move.w  .L33(PC,D0.w),D0
            jmp     .L33(PC,D0.w)
.L33:
            dc.w    .L34-.L33
            dc.w    .L34-.L33
            dc.w    .L37-.L33
            dc.w    .L38-.L33
            dc.w    GECom.L3-.L33
            dc.w    GECom.L6-.L33
            dc.w    GECom.L7-.L33
            dc.w    GECom.L8-.L33
            dc.w    GECom.L9-.L33
.L34:
            moveq   #-$12,D0
            bra.b   .L36
.L35:
            moveq   #0,D0
.L36:
            movea.l (SP)+,A0
            bra.w   WaitVSync_TFBDriver.L4
.L37:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),(A2)
            move.w  (6,A3),(6,A2)
            move.l  (8,A3),(8,A2)
            bra.b   .L35
.L38:
            move.l  (A2),D0
            beq.b   .L34
            movea.l D0,A0
            move.w  (6,A2),D0
            cmpi.w  #$FFFF,(4,A2)
            beq.b   GECom
            move.w  D0,D1
            move.w  D0,D2
            add.w   (4,A2),D2
.L39:
            move.w  D2,(0,A0,D1.w*8)
            subq.w  #1,D2
            dbra    D1,.L39
GECom:
            movem.l D6-D7,-(SP)
            bsr.w   CvtIndex
            movea.l ($2A,A1),A3
            adda.l  #$90003,A3
.L1:
            move.w  (A0),D1
            cmp.w   D6,D1
            bhi.b   .L2
            ori.l   #$FFFF0000,D1
            rol.l   D7,D1
            move.b  D1,($19,A3)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(2,A0)
            move.b  D1,(3,A0)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(4,A0)
            move.b  D1,(5,A0)
            move.b  ($25,A3),D1
            not.w   D1
            move.b  D1,(6,A0)
            move.b  D1,(7,A0)
.L2:
            addq.l  #8,A0
            dbra    D0,.L1
            movem.l (SP)+,D6-D7
            bra.w   sub_40897D3E.L35
.L3:
            move.w  (A2),D1
            bsr.w   ChkMode_TFBDriver
            bne.w   sub_40897D3E.L34
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            bne.b   .L4
            moveq   #4,D0
            bra.b   .L5
.L4:
            moveq   #3,D0
.L5:
            divu.w  D1,D0
            addq.w  #1,D0
            move.w  D0,(6,A2)
            bra.w   sub_40897D3E.L35
.L6:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D1
            bsr.w   ChkMode_TFBDriver
            move.w  (6,A2),D0
            bsr.w   ChkPage_TFBDriver
            bne.w   sub_40897D3E.L34
            move.w  (4,A3),D1
            subi.w  #$80,D1
            lea     GrayScreen_TFBDriver.L5,A0
            mulu.w  (4,A0,D1.w*8),D0
            mulu.w  (6,A0,D1.w*8),D0
            moveq   #$20,D1
            add.l   D1,D0
            add.l   ($2A,A1),D0
            move.l  D0,(8,A2)
            bra.w   sub_40897D3E.L35
.L7:
            clr.w   (A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            tst.w   ($14,A3)
            bpl.w   sub_40897D3E.L35
            move.b  #1,(A2)
            bra.w   sub_40897D3E.L35
.L8:
            clr.w   (A2)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            btst    #$E,($14,A3)
            beq.w   sub_40897D3E.L35
            move.b  #1,(A2)
            bra.w   sub_40897D3E.L35
.L9:
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.l  ($10,A3),(A2)
            bra.w   sub_40897D3E.L35
WaitVSync_TFBDriver:
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L1
            ori     #$200,SR
            andi    #$FAFF,SR
.L1:
            movea.l ($2A,A1),A0
            adda.l  #$D0003,A0
.L2:
            move.b  (A0),D0
            btst    #0,D0
            bne.b   .L2
.L3:
            move.b  (A0),D0
            btst    #0,D0
            beq.b   .L3
            move    (SP)+,SR
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            rts
.L4:
            btst    #9,(6,A0)
            beq.b   .L5
            rts
.L5:
            movea.l JIODone,A0
            jmp     (A0)
CvtIndex:
            movem.l D0/D4/A3,-(SP)
            movea.l ($14,A1),A3
            movea.l (A3),A3
            move.w  (4,A3),D7
            subi.w  #$80,D7
            moveq   #1,D4
            lsl.w   D7,D4
            move.w  D4,D0
            subq.w  #1,D0
            moveq   #2,D6
            lsl.w   D0,D6
            subq.w  #1,D6
            moveq   #8,D7
            sub.w   D4,D7
            movem.l (SP)+,D0/D4/A3
            rts
ChkMode_TFBDriver:
            subi.w  #$80,D1
            bmi.b   .L2
            cmpi.w  #3,D1
            bgt.b   .L2
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            cmpi.w  #8,D1
            bne.b   .L1
            move.l  A0,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            movea.l (SP)+,A0
            bne.b   .L2
.L1:
            cmp.w   D1,D1
.L2:
            rts
ChkPage_TFBDriver:
            movem.l D2/A0,-(SP)
            movea.l ($14,A1),A0
            movea.l (A0),A0
            tst.b   ($16,A0)
            bne.b   .L1
            moveq   #4,D2
            bra.b   .L2
.L1:
            moveq   #3,D2
.L2:
            divu.w  D1,D2
            cmp.w   D2,D0
            sgt     D2
            tst.b   D2
            movem.l (SP)+,D2/A0
            rts
sub_40898346:
            movem.l D0/A0-A1,-(SP)
            movea.l ($2A,A1),A0
            adda.l  #$8FFFF,A0
            lea     .L2,A1
            moveq   #$F,D0
.L1:
            move.b  (A1)+,(A0)
            subq.w  #4,A0
            dbra    D0,.L1
            movem.l (SP)+,D0/A0-A1
            rts
.L2:
            dc.w    $DFB8,$FFFF,$E11A,$88B9,$FAFD,$FDFE,$F0BE,$FA37
TFBSetDepth:
            movem.l D0-D2/A0-A1,-(SP)
            move.w  (A2),(4,A3)
            bsr.w   WaitVSync_TFBDriver
            movea.l ($2A,A1),A0
            adda.l  #$80003,A0
            cmpi.w  #8,D1
            bgt.b   .L4
            moveq   #0,D0
.L1:
            lsr.w   #1,D1
            bcs.b   .L2
            addq.w  #1,D0
            bra.b   .L1
.L2:
            move.b  #$B7,($3C,A0)
            lea     .L5,A1
            lsl.w   #4,D0
            adda.w  D0,A1
            moveq   #$F,D0
.L3:
            move.b  (A1)+,D1
            not.b   D1
            move.b  D1,(A0)
            addq.w  #4,A0
            dbra    D0,.L3
.L4:
            movem.l (SP)+,D0-D2/A0-A1
            rts
.L5:
            dc.w    $2047,$0008,$1EE5,$7746,$0502,$0201,$0F41,$05C8
            dc.w    $4047,$0008,$3CE5,$7746,$0506,$0604,$2004,$0BD8
            dc.w    $8047,$0008,$78E5,$7746,$050E,$0E0A,$428A,$16E8
            dc.w    $0047,$0008,$F0E5,$7746,$051E,$1E16,$8696,$2DF9
TFBSetPage:
            movem.l D0-D1/A0-A1,-(SP)
            move.w  D0,(6,A3)
            move.w  (A2),D1
            subi.w  #$80,D1
            lea     GrayScreen_TFBDriver.L5,A0
            mulu.w  (4,A0,D1.w*8),D0
            mulu.w  (6,A0,D1.w*8),D0
            moveq   #$20,D1
            add.l   D1,D0
            move.l  D0,D1
            movea.l ($2A,A1),A0
            add.l   A0,D0
            move.l  D0,(8,A3)
            lsr.l   #2,D1
            adda.l  #$80003,A0
            not.w   D1
            move.b  D1,($C,A0)
            lsr.w   #8,D1
            move.b  D1,(8,A0)
            movem.l (SP)+,D0-D1/A0-A1
            rts
GrayScreen_TFBDriver:
            movem.l D0-D4/A0-A1,-(SP)
            move.w  (4,A3),D1
            subi.w  #$80,D1
            cmpi.w  #3,D1
            bne.b   .L1
            tst.b   ($16,A3)
            bne.b   .L4
.L1:
            lea     .L5,A1
            move.l  (0,A1,D1.w*8),D0
            move.w  (4,A1,D1.w*8),D4
            move.w  (6,A1,D1.w*8),D3
            subq.w  #1,D3
            move.l  D0,D1
            not.l   D1
            movea.l (8,A3),A1
.L2:
            movea.l A1,A0
            move.w  D4,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L3:
            move.l  D0,(A0)+
            dbra    D2,.L3
            exg     D0,D1
            adda.w  D4,A1
            dbra    D3,.L2
.L4:
            movem.l (SP)+,D0-D4/A0-A1
            rts
.L5:
            dc.w    $AAAA,$AAAA,$0080,$01E0,$CCCC,$CCCC,$0100,$01E0
            dc.w    $F0F0,$F0F0,$0200,$01E0,$FF00,$FF00,$0400,$01E0
.L6:
            dc.w    $2049,$2009,$D1FC,$000A,$0003,$4210,$E198,$0240
            dc.w    $000F,$2078,$0D28,$4E90,$7001,$4E75
TFBDRVRSIZE:
            dc.w    0,$094E
            ds.b    14

            EVEN
