GETCCURSOR:
            move.w  (4,SP),D0
            move.l  #'crsr',D1
            moveq   #$60,D2
            bra.b   PATSHARE
            dc.w    0
GETPIXPAT:
            move.w  (4,SP),D0
            move.l  #'ppat',D1
            moveq   #$1C,D2
PATSHARE:
            link.w  A6,#0
            movem.l D3/A2-A4,-(SP)
            move.l  D2,D3
            clr.l   ($A,A6)
            subq.w  #4,SP
            move.l  D1,-(SP)
            move.w  D0,-(SP)
            jsr     ([$1480.w])
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.w   .L5
            jsr     ([$1584.w])
            bne.w   .L5
            movea.l A0,A3
            _HLock
            movea.l (A3),A2
            movea.l A2,A0
            adda.l  (2,A2),A0
            moveq   #$32,D0
            jsr     ([$158C.w])
            bne.w   .L5
            movea.l A0,A4
            movea.l (A4),A1
            clr.l   ($2A,A1)
            movea.l A2,A0
            movea.l A2,A1
            adda.l  (2,A2),A1
            cmpi.w  #$10,($1E,A1)
            beq.b   .L1
            adda.l  ($2A,A1),A0
            move.w  (6,A0),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            ext.l   D0
            jsr     ([$158C.w])
            bne.w   .L5
            movea.l (A4),A1
            move.l  A0,($2A,A1)
            clr.l   -(SP)
            jsr     ([$16A0.w])
            movea.l (A0),A0
            move.l  (SP)+,(A0)
.L1:
            movea.l A2,A0
            movea.l A2,A1
            adda.l  (2,A2),A1
            move.l  ($2A,A1),D0
            sub.l   (6,A2),D0
            adda.l  (6,A2),A0
            jsr     ([$158C.w])
            bne.w   .L5
            move.l  A0,(6,A2)
            moveq   #2,D0
            _NewHandle
            bne.w   .L5
            move.l  A0,($A,A2)
            cmpi.w  #$60,D3
            beq.b   .L2
            moveq   #$16,D0
            _NewHandle
            bne.w   .L5
            move.l  A0,($10,A2)
.L2:
            move.l  A4,(2,A2)
            movea.l A3,A0
            _HUnlock
            move.l  D3,D0
            jsr     RSetHSize
            cmpi.w  #$60,D3
            bne.b   .L3
            clr.l   -(SP)
            jsr     ([$16A0.w])
            movea.l (A3),A0
            move.l  (SP)+,($5C,A0)
            bra.b   .L4
.L3:
            move.w  #$FFFF,($E,A2)
.L4:
            move.l  A3,($A,A6)
.L5:
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #2
            dc.w    0
NewPixPat:
            clr.l   -(SP)
            move.w  #$16,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            move.w  #$1C,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            jsr     ([$160C.w])
            movea.l (SP),A0
            clr.l   -(SP)
            move.w  #8,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            clr.w   -(SP)
            jsr     NewHandle
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  A1,(8,SP)
            movea.l (A1),A0
            move.l  D0,(2,A0)
            move.l  D1,(6,A0)
            move.l  D2,($A,A0)
            move.l  (SP)+,($10,A0)
            move.l  #$AA55AA55,D0
            move.l  D0,($14,A0)
            move.l  D0,($18,A0)
            move.w  #1,(A0)
            move.w  #$FFFF,($E,A0)
            rts
            ds.b    8
DisposCCursor:
DisposPixPat:
            move.l  (4,SP),D0
            beq.b   .L6
            movea.l D0,A1
            move.l  (A1),D0
            beq.b   .L6
            movea.l D0,A1
            move.w  (A1),-(SP)
            bmi.b   .L1
            movea.l ($10,A1),A0
            _DisposHandle
.L1:
            movea.l (6,A1),A0
            _DisposHandle
            movea.l ($A,A1),A0
            _DisposHandle
            move.l  (2,A1),-(SP)
            jsr     ([$1610.w])
            movea.l (6,SP),A0
            move.l  A0,D2
            _DisposHandle
            tst.w   (SP)+
            bmi.b   .L6
            movea.l PortList,A1
            movea.l (A1),A1
            move.w  (A1)+,D0
            bra.b   .L5
.L2:
            movea.l (A1)+,A0
            tst.w   (6,A0)
            bpl.b   .L5
            cmp.l   ($3A,A0),D2
            bne.b   .L3
            clr.l   ($3A,A0)
.L3:
            cmp.l   ($20,A0),D2
            bne.b   .L4
            clr.l   ($20,A0)
.L4:
            cmp.l   ($3E,A0),D2
            bne.b   .L5
            clr.l   ($3E,A0)
.L5:
            dbra    D0,.L2
.L6:
            move.l  (SP)+,(SP)
            rts
            ds.b    14
SetFillPat:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   D0
            beq.b   .L1
            move.l  A1,-(SP)
            jsr     PHILPIXPAT
            bra.b   .L3
.L1:
            tst.w   (6,A0)
            bpl.b   .L2
            move.l  A1,-(SP)
            pea     ($3E,A0)
            jsr     ([$1A44.w])
            bra.b   .L3
.L2:
            lea     ($28,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L3:
            rtd     #4
            ds.b    12
PenPixPat:
            moveq   #$3A,D0
            moveq   #$3A,D1
            bra.b   BackPixPat.L1
PHILPIXPAT:
            moveq   #$3E,D0
            moveq   #$28,D1
            bra.b   BackPixPat.L1
BackPixPat:
            moveq   #$20,D0
            moveq   #$20,D1
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bmi.b   .L3
            movea.l (4,SP),A1
            movea.l (A1),A1
            cmpi.w  #2,(A1)
            beq.b   .L2
            lea     ($14,A1),A1
            lea     (0,A0,D1.w),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            bra.b   .L5
.L2:
            movea.l (2,A1),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            pea     ($2A,A1)
            pea     (0,A0,D1.w)
            jsr     PutGray
            bra.b   .L5
.L3:
            move.l  (0,A0,D0.w),D1
            beq.b   .L4
            movea.l D1,A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L4
            move.w  D0,-(SP)
            move.l  D1,-(SP)
            jsr     ([$1620.w])
            move.w  (SP)+,D0
.L4:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),(0,A0,D0.w)
.L5:
            move.l  (SP)+,(SP)
            rts
            ds.b    10
CopyPixPat:
            moveq   #4,D0
            movea.l (8,SP),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            move.w  (A0)+,(A1)+
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.w  (A0)+,(A1)+
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            jsr     ([$1A14.w])
            jsr     ([$1A14.w])
            jsr     ([$1A14.w])
            jsr     ([$1614.w])
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    12
OLDPATTONEW:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l (8,A6),A0
            move.l  (A0),D0
            beq.b   .L1
            movea.l D0,A3
            movea.l (A3),A1
            tst.w   (A1)
            beq.b   .L2
.L1:
            clr.l   -(SP)
            jsr     ([$161C.w])
            movea.l (8,A6),A0
            move.l  (SP)+,(A0)
            movea.l (A0),A3
            movea.l (A3),A1
            clr.w   (A1)
            movea.l (2,A1),A1
            movea.l (A1),A1
            move.l  ($2A,A1),-(SP)
            jsr     OneBitCTable
            movea.l (A3),A1
.L2:
            move.w  #$FFFF,($E,A1)
            movea.l (6,A1),A0
            movea.l (A0),A0
            movea.l ($C,A6),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            movea.l (A3),A2
            movea.l (2,A2),A2
            movea.l (A2),A2
            movea.l A2,A3
            move.l  ($2A,A3),-(SP)
            lea     OneBitData,A1
            jsr     COPYPMAP
            move.w  #1,(4,A3)
            clr.l   (6,A3)
            move.l  #$80008,($A,A3)
            move.l  (SP)+,($2A,A3)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #8
            ds.b    10
PATEXPAND:
            tst.b   (-$A6,A6)
            bne.w   sub_4083093E.L11
            movea.l (SP)+,A0
            moveq   #$40,D0
            move.w  (-$76,A6),D1
            subq.w  #3,D1
            ble.b   .L1
            lsl.w   D1,D0
.L1:
            suba.w  D0,SP
            move.l  SP,(-$88,A6)
            move.l  A0,-(SP)
sub_4083093E:
            link.w  A4,#-$20
            movem.l D3-D6/A2-A3/A5,-(SP)
            move.w  (-$98,A6),D0
            move.w  (-$EC,A6),D2
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
            move.w  (-$76,A6),D5
            movea.l (-$9C,A6),A0
            lea     (-$8E,A6),A1
            andi.w  #$F3,D0
            beq.b   .L1
            btst    #5,D0
            bne.b   .L1
            moveq   #-1,D3
            moveq   #0,D4
.L1:
            movea.l (A5),A3
            moveq   #7,D0
            and.w   (-$A8,A3),D0
            beq.b   .L2
            move.l  (A0),(-$10,A4)
            move.l  (A0)+,(-8,A4)
            move.l  (A0),(-$C,A4)
            move.l  (A0),(-4,A4)
            lea     (-$10,A4),A0
            adda.w  D0,A0
.L2:
            add.w   (-$A6,A3),D2
            moveq   #7,D6
            and.w   D6,D2
            tst.w   D5
            bne.b   .L3
            movea.l (A3),A3
            move.w  ($5A,A3),D0
            cmpi.w  #$FFFE,D0
            beq.b   .L6
            cmpi.w  #2,D0
            beq.b   .L4
.L3:
            movea.l ($1AB8).w,A2
            adda.l  (0,A2,D5.w*4),A2
            jsr     (A2)
            bra.b   .L8
.L4:
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            clr.w   D0
.L5:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,-(SP)
            lsr.b   #4,D0
            move.b  .L9(PC,D0.w),(A1)+
            moveq   #$F,D0
            and.b   (SP)+,D0
            move.b  .L9(PC,D0.w),(A1)+
            move.w  (-2,A1),(A1)+
            move.l  (-4,A1),(A1)+
            dbra    D6,.L5
            bra.b   .L8
.L6:
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            clr.w   D0
.L7:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,-(SP)
            lsr.b   #4,D0
            move.b  .L10(PC,D0.w),(A1)+
            moveq   #$F,D0
            and.b   (SP)+,D0
            move.b  .L10(PC,D0.w),(A1)+
            move.w  (-2,A1),(A1)+
            clr.l   (A1)+
            dbra    D6,.L7
.L8:
            movem.l (SP)+,D3-D6/A2-A3/A5
            unlk    A4
            rts
.L9:
            dc.w    $0003,$0C0F,$3033,$3C3F,$C0C3,$CCCF,$F0F3,$FCFF
.L10:
            dc.w    $0001,$0405,$1011,$1415
            dc.b    '@ADEPQTU'
.L11:
            link.w  A4,#-$20
            movem.l D3-D6/A2-A3/A5,-(SP)
            move.l  SP,(-$14,A4)
            movea.l (A5),A3
            move.l  A3,(-$1C,A4)
            move.l  A5,(-$20,A4)
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L14
            movea.l ($A,A0),A0
            moveq   #$40,D0
            move.w  (-$76,A6),D1
            subq.w  #3,D1
            ble.b   .L12
            lsl.l   D1,D0
.L12:
            jsr     RSetHSize
            move.l  (A0),D0
            jsr     ([$644.w])
            move.l  D0,(-$88,A6)
            movea.l (-$9C,A6),A0
            move.l  A0,-(SP)
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            move.l  A0,(-$9C,A6)
            jsr     sub_4083093E
            move.l  (SP)+,(-$9C,A6)
.L13:
            movea.l (-$14,A4),SP
            bra.w   .L8
.L14:
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A2
            movea.l TheGDevice,A1
            movea.l (A1),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.w  ($20,A1),D1
            movea.l ($10,A2),A5
            movea.l (A5),A5
            cmp.w   ($E,A2),D1
            bne.b   .L15
            cmpi.w  #8,D1
            bgt.b   .L16
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            move.l  (A1),D0
            cmp.l   (6,A5),D0
            beq.b   .L16
.L15:
            move.l  D0,(6,A5)
            move.w  D1,($E,A2)
            move.l  A0,-(SP)
            movea.l (-$20,A4),A5
            jsr     ([$1A4C.w])
.L16:
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l ($10,A0),A5
            movea.l (A5),A5
            move.l  ([$A.w,A0]),D0
            jsr     ([$644.w])
            move.l  D0,(-$88,A6)
            move.w  (A5),(-$8E,A6)
            move.w  (2,A5),(-$8C,A6)
            move.w  (4,A5),(-$8A,A6)
            lea     ($A,A5),A2
            movea.l (A3),A1
            move.w  (A2)+,D0
            cmp.w   (-$EC,A6),D0
            bne.b   .L18
            cmp.l   (A2)+,D7
            bne.b   .L18
            move.w  (-$A8,A3),D0
            cmp.w   (A2)+,D0
            bne.b   .L18
            move.w  (-$A6,A3),D0
            cmp.w   (A2)+,D0
            bne.b   .L18
            move.w  ($5A,A1),D0
            cmp.w   (A2)+,D0
            beq.w   .L8
.L17:
            lea     ($C,A5),A2
            move.l  D7,(A2)+
            movea.l (-$1C,A4),A3
            move.l  (-$A8,A3),(A2)+
            movea.l (A3),A1
            move.w  ($5A,A1),(A2)+
            bra.w   .L13
.L18:
            move.w  (A5),D0
            bne.b   .L19
            moveq   #4,D0
.L19:
            movea.l (2,A0),A1
            movea.l (A1),A1
            move.w  (-$76,A6),D1
            lsl.w   #3,D0
            move.w  D0,D3
            move.w  D0,D4
            lsr.w   D1,D4
            lsr.w   #5,D0
.L20:
            clr.l   -(SP)
            dbra    D0,.L20
            move.w  (-$EC,A6),D2
            add.w   (-$A6,A3),D2
            move.w  D2,D0
            sub.w   ($A,A5),D2
            move.w  D0,($A,A5)
            subq.w  #1,D4
            and.w   D4,D2
            beq.b   .L17
            lsl.w   D1,D2
            move.w  D2,(-$18,A4)
            move.w  D3,(-$16,A4)
            movea.l ($A,A0),A3
            movea.l (A3),A3
            moveq   #$20,D6
            moveq   #$10,D5
            tst.w   (A5)
            beq.b   .L27
            move.w  ($A,A1),D5
            sub.w   (6,A1),D5
            moveq   #0,D3
            bra.b   .L27
.L21:
            movea.l SP,A2
            move.w  (-$16,A4),D3
            move.w  (-$18,A4),D2
            move.w  D2,D7
            ext.l   D7
            sub.w   D7,D3
.L22:
            bfextu  (A3){D7:0},D0
            add.l   D6,D7
            sub.w   D6,D3
            bmi.b   .L23
            move.l  D0,(A2)+
            bra.b   .L22
.L23:
            move.l  D6,D1
            add.w   D3,D1
            rol.l   D1,D0
            bfins   D0,(A2){0:D1}
            neg.w   D3
            bfextu  (A3){0:D3},D0
            bfins   D0,(A2){D1:D3}
            addq.w  #4,A2
            sub.w   D3,D2
            ble.b   .L25
.L24:
            bfextu  (A3){D3:0},D0
            add.l   D6,D3
            sub.w   D6,D2
            bmi.b   .L25
            move.l  D0,(A2)+
            bra.b   .L24
.L25:
            movea.l SP,A2
            move.w  (-$16,A4),D0
            subq.w  #1,D0
            lsr.w   #5,D0
.L26:
            move.l  (A2)+,(A3)+
            dbra    D0,.L26
.L27:
            dbra    D5,.L21
            bra.w   .L17
            ds.b    10
PATCONVERT:
            link.w  A6,#-$40
            movem.l D3-D7/A0/A2-A4,-(SP)
            move.l  SP,(-4,A6)
            bsr.l   GetDevPix
            move.w  ($20,A0),D6
            ext.l   D6
            movea.l (8,A6),A4
            movea.l (A4),A1
            move.w  (A1),D0
            bmi.b   .L1
            movea.l ($10,A1),A0
            movea.l (A0),A0
            clr.w   ($A,A0)
            cmpi.w  #2,D0
            bne.b   .L1
            move.l  A4,-(SP)
            jsr     ([$1A50.w])
            movea.l (A4),A1
.L1:
            movea.l (2,A1),A3
            movea.l (A3),A0
            move.w  ($20,A0),D7
            ext.l   D7
            move.w  (4,A0),D0
            andi.w  #$7FFF,D0
            move.w  D0,(-$E,A6)
            clr.w   (-$A,A6)
            clr.w   (-$C,A6)
            lea     ($C,A0),A2
            move.w  (A2),D4
            move.w  -(A2),D3
            sub.w   -(A2),D4
            sub.w   -(A2),D3
            move.w  D4,D0
            subq.w  #1,D0
            move.w  D0,(-6,A6)
            move.w  D3,D0
            subq.w  #1,D0
            move.w  D0,(-8,A6)
            move.w  (A1),D0
            bpl.b   .L2
            lsr.w   #3,D4
            mulu.w  D6,D4
            bra.b   .L6
.L2:
            movea.l ($10,A1),A2
            movea.l (A2),A2
            mulu.w  D6,D4
            moveq   #$20,D0
            divu.w  D4,D0
            subq.w  #1,D0
            bmi.b   .L3
            move.w  D0,(-$A,A6)
            clr.w   (A2)
            moveq   #4,D4
            moveq   #$10,D0
            divu.w  D3,D0
            cmpi.w  #1,D0
            blt.b   .L4
            mulu.w  D0,D3
            subq.w  #1,D0
            move.w  D0,(-$C,A6)
            bra.b   .L5
.L3:
            lsr.w   #3,D4
.L4:
            move.w  D4,(A2)
.L5:
            move.w  D4,D0
            subq.w  #1,D0
            andi.w  #$FFFC,D0
            move.w  D0,(2,A2)
            move.w  D4,D0
            mulu.w  D3,D0
            subq.w  #1,D0
            move.w  D0,(4,A2)
.L6:
            move.w  D4,D0
            mulu.w  D3,D0
            movea.l (A4),A0
            movea.l ($A,A0),A0
            jsr     RSetHSize
            cmpi.w  #8,D7
            bgt.b   .L12
            move.l  (A3),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            movea.l (A4),A1
            movea.l ([$A.w,A1]),A2
            moveq   #0,D5
.L7:
            movea.l (A4),A1
            movea.l ([6.w,A1]),A3
            move.w  (-8,A6),D3
.L8:
            move.w  (-$A,A6),D2
.L9:
            moveq   #0,D4
            move.w  (-6,A6),D1
.L10:
            bfextu  (A3){D4:D7},D0
            move.l  (0,SP,D0.w*4),D0
            bfins   D0,(A2){D5:D6}
            add.l   D7,D4
            add.l   D6,D5
            dbra    D1,.L10
            dbra    D2,.L9
            adda.w  (-$E,A6),A3
            dbra    D3,.L8
            subq.w  #1,(-$C,A6)
            bpl.b   .L7
.L11:
            movea.l (-4,A6),SP
            movem.l (SP)+,D3-D7/A0/A2-A4
            unlk    A6
            rtd     #4
.L12:
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            movea.l (A3),A1
            move.l  A0,(A1)
            bsr.l   GetDevPix
            lea     (-$40,A6),A1
            moveq   #$18,D0
.L13:
            move.w  (A0)+,(A1)+
            dbra    D0,.L13
            lea     (-$3A,A6),A0
            clr.l   (A0)+
            move.w  (-8,A6),(A0)
            addq.w  #1,(A0)+
            move.w  (-6,A6),(A0)
            addq.w  #1,(A0)
            movea.l (A4),A1
            movea.l ($A,A1),A0
            movea.l (A0),A0
            move.l  A0,(-$40,A6)
            ori.w   #$8000,D4
            move.w  D4,(-$3C,A6)
            movea.l (A3),A0
            move.l  (A3),-(SP)
            clr.l   -(SP)
            pea     (-$40,A6)
            pea     (6,A0)
            pea     (-$3A,A6)
            pea     (-$3A,A6)
            clr.w   -(SP)
            btst    #1,(1,A1)
            beq.b   .L14
            addi.w  #$40,(SP)
.L14:
            clr.l   -(SP)
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            st      -(SP)
            jsr     ([$1A9C.w])
            movea.l (A4),A1
            movea.l ([$A.w,A1]),A2
            move.w  (-6,A6),D7
            addq.w  #1,D7
            mulu.w  D6,D7
            andi.w  #$7FFF,(-$3C,A6)
            move.w  (-8,A6),D3
.L15:
            moveq   #0,D5
            move.l  D7,D4
            move.w  (-$A,A6),D2
            bra.b   .L18
.L16:
            move.w  (-6,A6),D1
.L17:
            bfextu  (A2){D5:D6},D0
            bfins   D0,(A2){D4:D6}
            add.l   D6,D4
            add.l   D6,D5
            dbra    D1,.L17
.L18:
            dbra    D2,.L16
            adda.w  (-$3C,A6),A2
            dbra    D3,.L15
            movea.l ([$A.w,A1]),A0
            move.w  (-$3C,A6),D1
            move.w  (-8,A6),D2
            addq.w  #1,D2
            mulu.w  D2,D1
            lsr.l   #2,D1
            subq.w  #1,D1
            move.w  (-$C,A6),D2
            bra.b   .L21
.L19:
            move.w  D1,D0
.L20:
            move.l  (A0)+,(A2)+
            dbra    D0,.L20
.L21:
            dbra    D2,.L19
            bra.w   .L11
            ds.b    8
MAKESCALETBL:
            movea.l (SP)+,A0
            move.w  (SP)+,D2
            movea.l (SP)+,A1
            move.w  ($20,A1),D1
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            subq.w  #1,D0
.L1:
            move.l  #$7FFFFFFF,-(SP)
            dbra    D0,.L1
            move.l  A0,-(SP)
            movem.l D3-D7/A2,-(SP)
            move.w  D2,D7
            moveq   #0,D5
            move.w  D1,D5
            subq.w  #6,SP
            clr.w   -(SP)
            moveq   #-1,D6
            move.l  ($2A,A1),D0
            beq.b   .L6
            movea.l D0,A2
            move.w  ([A2],6.w),D4
            move.w  ([A2],4.w),D3
            btst    #$E,D3
            bne.b   .L4
            moveq   #0,D6
            move.w  D4,D6
.L2:
            movea.l (A2),A0
            move.w  D4,D3
            tst.w   (4,A0)
            bmi.b   .L3
            move.w  (8,A0,D4.w*8),D3
.L3:
            move.w  ($A,A0,D4.w*8),(2,SP)
            move.l  ($C,A0,D4.w*8),(4,SP)
            clr.l   -(SP)
            pea     (6,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            move.l  D0,($24,SP,D3.w*4)
            dbra    D4,.L2
            bra.b   .L6
.L4:
            moveq   #0,D6
            move.w  D4,D6
.L5:
            movea.l (A2),A0
            move.w  D4,D3
            move.w  (8,A0,D4.w*8),(SP)
            move.w  ($A,A0,D4.w*8),(2,SP)
            move.l  ($C,A0,D4.w*8),(4,SP)
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$1C48.w])
            move.l  (SP)+,D0
            move.l  D0,($24,SP,D3.w*4)
            dbra    D4,.L5
.L6:
            addq.l  #1,D6
            sub.l   D5,D6
            neg.l   D6
            ble.w   .L13
            moveq   #-1,D0
            move.l  D0,-(SP)
            move.w  D0,-(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            btst    #5,D7
            beq.b   .L7
            pea     (6,SP)
            jsr     ([$1668.w])
            move.l  SP,-(SP)
            jsr     ([$1664.w])
.L7:
            movea.l SP,A1
            movea.l A1,A2
            moveq   #2,D0
.L8:
            move.w  #$8000,-(SP)
            move.w  (A1)+,-(SP)
            dbra    D0,.L8
            movea.l A2,A1
            lea     ($3C,SP,D5.w*4),A2
            subq.w  #1,D6
            beq.b   .L12
            lea     (6,A1),A0
            moveq   #2,D0
.L9:
            moveq   #0,D1
            move.w  (A0)+,D1
            sub.w   (A1)+,D1
            scs     D7
            bcc.b   .L10
            neg.w   D1
.L10:
            swap    D1
            divu.l  D6,D1
            tst.b   D7
            beq.b   .L11
            neg.l   D1
.L11:
            move.l  D1,-(SP)
            dbra    D0,.L9
            movem.l (SP)+,D3-D5
.L12:
            cmpi.l  #$7FFFFFFF,-(A2)
            bne.b   .L12
            move.w  (8,SP),($C,SP)
            move.w  (4,SP),($E,SP)
            move.w  (SP),($10,SP)
            clr.l   -(SP)
            pea     ($10,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            move.l  D0,(A2)
            movem.l (SP)+,D0-D2
            add.l   D3,D0
            add.l   D4,D1
            add.l   D5,D2
            movem.l D0-D2,-(SP)
            dbra    D6,.L12
            lea     ($18,SP),SP
.L13:
            movem.l (SP)+,D0-D1/D3-D7/A2
            rts
            dc.w    0
PATDITHER:
            link.w  A6,#-$1E
            movem.l A4,-(SP)
            movea.l (8,A6),A0
            movea.l (A0),A2
            cmpi.w  #2,(A2)
            bne.w   hocuspocus.L4
            movea.l (2,A2),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            lea     ($28,A0),A0
            lea     (-$C,A6),A2
            move.l  (2,A0),(A2)+
            move.w  (6,A0),(A2)
            clr.l   -(SP)
            pea     (-$C,A6)
            jsr     ([$16CC.w])
            pea     (-6,A6)
            jsr     ([$16D0.w])
            move.w  (-$C,A6),D0
            move.w  (-6,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1E,A6)
            move.w  (-$A,A6),D0
            move.w  (-4,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1C,A6)
            move.w  (-8,A6),D0
            move.w  (-2,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1A,A6)
            clr.l   -(SP)
            pea     (-$1E,A6)
            jsr     ([$16CC.w])
            pea     (-$18,A6)
            jsr     ([$16D0.w])
            move.w  (-$1E,A6),D0
            move.w  (-$18,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$18,A6)
            move.w  (-$1C,A6),D0
            move.w  (-$16,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$16,A6)
            move.w  (-$1A,A6),D0
            move.w  (-$14,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$14,A6)
            clr.l   -(SP)
            pea     (-$18,A6)
            jsr     ([$16CC.w])
            pea     (-$12,A6)
            jsr     ([$16D0.w])
            bra.b   hocuspocus.L3
hocuspocus:
            add.w   D0,D0
            bcs.b   .L1
            sub.w   D1,D0
            bcc.b   .L2
            moveq   #0,D0
            rts
.L1:
            sub.w   D1,D0
            bcs.b   .L2
            moveq   #-1,D0
.L2:
            rts
.L3:
            move.w  (-$18,A6),D0
            move.w  (-$12,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$12,A6)
            move.w  (-$16,A6),D0
            move.w  (-$10,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$10,A6)
            move.w  (-$14,A6),D0
            move.w  (-$E,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$E,A6)
            clr.l   -(SP)
            pea     (-$12,A6)
            jsr     ([$16CC.w])
            pea     (-$12,A6)
            jsr     ([$16D0.w])
            movea.l (8,A6),A2
            movea.l (A2),A2
            movea.l (2,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            lea     (8,A2),A2
            clr.w   (A2)+
            move.l  (-6,A6),(A2)+
            move.w  (-2,A6),(A2)+
            move.w  #1,(A2)+
            move.l  (-$12,A6),(A2)+
            move.w  (-$E,A6),(A2)+
            move.w  #2,(A2)+
            move.l  (-$18,A6),(A2)+
            move.w  (-$14,A6),(A2)+
            move.w  #3,(A2)+
            move.l  (-$1E,A6),(A2)+
            move.w  (-$1A,A6),(A2)+
.L4:
            movem.l (SP)+,A4
            unlk    A6
            rts
            ds.b    6
MAKERGBPAT:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l ($C,A6),A1
            movea.l (A1),A0
            move.w  #2,(A0)
            move.w  #$FFFF,($E,A0)
            move.l  #$AA55AA55,D0
            move.l  D0,($14,A0)
            move.l  D0,($18,A0)
            movea.l (2,A0),A3
            movea.l (A3),A0
            movea.l ($2A,A0),A0
            moveq   #$30,D0
            jsr     RSetHSize
            movea.l (A0),A0
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A0)
            clr.w   (4,A0)
            move.w  #4,(6,A0)
            lea     ($28,A0),A0
            movea.l (8,A6),A2
            move.w  #4,(A0)+
            move.l  (A2)+,(A0)+
            move.w  (A2)+,(A0)
            movea.l (A1),A0
            movea.l (6,A0),A0
            moveq   #$10,D0
            jsr     RSetHSize
            movea.l (A0),A0
            move.l  #$1111BBBB,D0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            movea.l (A3),A2
            move.l  ($2A,A2),-(SP)
            lea     OneBitData,A1
            jsr     COPYPMAP
            movea.l (A3),A2
            move.l  (SP)+,($2A,A2)
            move.w  #2,(4,A2)
            clr.l   (6,A2)
            move.l  #$80008,($A,A2)
            move.w  #2,($20,A2)
            move.w  #2,($24,A2)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #8
            ds.b    12
GetCIcon:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            clr.l   ($A,A6)
            subq.w  #4,SP
            move.l  #'cicn',-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1480.w])
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.w   .L1
            jsr     ([$1584.w])
            movea.l A0,A4
            _HLock
            movea.l (A4),A3
            move.w  ($A,A3),D4
            sub.w   (6,A3),D4
            lea     ($52,A3),A2
            move.w  ($36,A3),D0
            mulu.w  D4,D0
            adda.w  D0,A2
            move.w  ($44,A3),D0
            mulu.w  D4,D0
            adda.w  D0,A2
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A2)
            movea.l A2,A0
            move.w  (6,A2),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            ext.l   D0
            move.l  D0,D3
            jsr     ([$158C.w])
            bne.w   .L1
            move.l  A0,($2A,A3)
            movea.l A2,A0
            adda.l  D3,A0
            move.w  (4,A3),D0
            andi.w  #$7FFF,D0
            mulu.w  D4,D0
            mulu.w  ($20,A3),D0
            jsr     ([$158C.w])
            bne.w   .L1
            move.l  A0,($4E,A3)
            movea.l A4,A0
            _HUnlock
            move.l  A2,D0
            sub.l   A3,D0
            movea.l A4,A0
            jsr     RSetHSize
            move.l  A4,($A,A6)
.L1:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #2
            ds.b    12
PlotCIcon:
            link.w  A6,#-$70
            movem.l D3/A2-A4,-(SP)
            pea     (-6,A6)
            jsr     ([$1664.w])
            pea     (-$C,A6)
            jsr     ([$1668.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            moveq   #$1E,D0
            move.l  D0,-(SP)
            jsr     ([$F8C.w])
            movea.l (8,A6),A4
            movea.l A4,A0
            _HLock
            movea.l (A4),A3
            move.w  ($A,A3),D3
            sub.w   (6,A3),D3
            lea     ($52,A3),A0
            move.l  A0,($32,A3)
            move.w  ($36,A3),D0
            mulu.w  D3,D0
            adda.l  D0,A0
            move.l  A0,($40,A3)
            movea.l ($4E,A3),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,(A3)
            movea.l (A5),A0
            movea.l (A0),A0
            lea     (2,A0),A1
            lea     (-$5A,A6),A2
            jsr     ([$1A08.w])
            move.w  (-$3A,A6),D0
            suba.l  A0,A0
            move.w  D2,D3
            beq.b   .L2
            movea.l DeviceList,A2
            movea.l (A2),A1
            tst.l   ($1E,A1)
            beq.b   .L2
            movea.l ($C,A6),A0
            lea     (-$62,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)+
            move.l  (-$54,A6),D0
            move.w  D0,D1
            swap    D0
            sub.w   D1,-(A1)
            sub.w   D0,-(A1)
            sub.w   D1,-(A1)
            sub.w   D0,-(A1)
            lea     (-$6C,A6),A0
            move.l  A0,(-$70,A6)
            move.w  #$A,(A0)
.L1:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L5
            clr.b   -(SP)
            pea     (-$62,A6)
            pea     ($22,A0)
            pea     (-$6A,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L5
            move.l  (-$54,A6),D0
            move.w  D0,D1
            swap    D0
            lea     (-$6A,A6),A0
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)
            movea.l (A2),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            lea     (-$70,A6),A0
.L2:
            lea     ($40,A3),A1
            tst.w   (4,A1)
            beq.b   .L3
            cmpi.w  #2,D0
            ble.b   .L4
.L3:
            movea.l A3,A1
.L4:
            move.l  A1,-(SP)
            pea     ($32,A3)
            pea     (-$5A,A6)
            pea     (6,A1)
            pea     ($38,A3)
            move.l  ($C,A6),-(SP)
            bsr.w   COPYCICON
            tst.w   D3
            beq.b   .L6
.L5:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L1
.L6:
            movea.l ($4E,A3),A0
            _HUnlock
            movea.l A4,A0
            _HUnlock
            pea     (-6,A6)
            jsr     ([$1650.w])
            pea     (-$C,A6)
            jsr     ([$1654.w])
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #8
            ds.b    10
DisposCIcon:
            movea.l (SP)+,A1
            movea.l (SP),A0
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            movea.l ($4E,A0),A0
            _DisposHandle
            movea.l (SP)+,A0
            _DisposHandle
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    6
