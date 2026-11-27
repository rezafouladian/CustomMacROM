UpdatePixMap:
            rts
            ds.b    14
MakeITable:
            link.w  A6,#-$16
            movem.l D3-D7/A2-A5,-(SP)
            clr.w   QDErr
            move.w  (8,A6),D7
            cmpi.l  #-1,TheGDevice
            beq.b   .ResCheck
            movea.l ([TheGDevice.w]),A0
            tst.l   ($A,A6)
            bne.b   .DoCTabH
            move.l  (6,A0),($A,A6)
.DoCTabH:
            tst.l   ($E,A6)
            bne.b   .DoITabRes
            movea.l ([$16.w,A0]),A1
            move.l  ($2A,A1),($E,A6)
.DoITabRes:
            tst.w   D7
            bne.b   .ResCheck
            move.w  ($A,A0),D7
            bne.b   .ResSubst
            moveq   #4,D7
.ResSubst:
            move.w  D7,(8,A6)
.ResCheck:
            cmpi.w  #2,D7
            ble.b   .BadRes
            cmpi.w  #6,D7
            blt.b   .ResOK
.BadRes:
            move.w  #$FF64,QDErr
            bra.w   sub_4083BFBE.L25
.ResOK:
            move.w  D7,D1
            moveq   #1,D0
            lsl.l   D1,D0
            lsl.l   D1,D0
            lsl.l   D1,D0
            addq.l  #6,D0
            move.l  D0,(-$14,A6)
            addi.l  #$206,D0
            movea.l ($A,A6),A0
            tst.l   (A0)
            beq.b   .L7
            _SetHandleSize
            bra.b   .L8
.L7:
            _ReallocHandle
.L8:
            beq.b   .L9
            move.w  #$FF68,QDErr
            bra.w   sub_4083BFBE.L25
.L9:
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            lea     (8,A0),A1
.nextEntry:
            move.l  (A1)+,D1
            move.l  (A1)+,D2
            cmp.w   D1,D2
            bne.b   .notGray
            swap    D2
            cmp.w   D1,D2
            bne.b   .notGray
.skippy:
            dbra    D0,.nextEntry
            jsr     ([$1C6C.w])
            bra.w   sub_4083BFBE.L25
.notGray:
            btst    #$1E,D1
            bne.b   .skippy
            move.l  TheZone,(-8,A6)
            move.l  ApplZone,TheZone
            subq.w  #4,SP
            move.l  #'mitq',-(SP)
            clr.w   -(SP)
            _RGetResource
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (-$C,A0,D7.w*4),D0
            move.l  D0,D3
            _NewPtr
            bne.w   sub_4083BFBE.L27
            move.l  A0,(-4,A6)
            adda.l  D3,A0
            movea.l A0,A5
            moveq   #1,D6
            lsl.l   D7,D6
            move.l  D6,D5
            addq.w  #2,D6
            move.l  D6,D0
            mulu.w  D6,D0
            mulu.w  D6,D0
            add.l   D0,D0
            move.l  D0,(-$10,A6)
            clr.b   (-$16,A6)
            _NewHandle
            beq.b   .notTemp2
            move.l  (-$10,A6),D0
            jsr     ([$1AB4.w])
            st      (-$16,A6)
            move.l  A0,D0
            beq.w   sub_4083BFBE.L26
.notTemp2:
            move.l  A0,(-$C,A6)
            movea.l (A0),A0
            movea.l A0,A3
            move.l  #$7FFF7FFF,D1
            move.l  #$80008000,D0
            move.w  D6,D4
            mulu.w  D6,D4
            sub.w   D6,D4
            subq.w  #1,D4
            lsr.w   #1,D4
.L14:
            move.l  D1,(A0)+
            dbra    D4,.L14
            subq.l  #2,A0
            move.w  D5,D4
            subq.w  #1,D4
.L15:
            move.l  D6,D3
            subq.w  #1,D3
.L16:
            move.l  D1,(A0)+
            dbra    D3,.L16
            move.l  D5,D2
            subq.w  #1,D2
.L17:
            move.l  D1,(A0)+
            move.w  D5,D3
            lsr.w   #1,D3
            subq.w  #1,D3
.L18:
            move.l  D0,(A0)+
            dbra    D3,.L18
            dbra    D2,.L17
            dbra    D4,.L15
            move.w  D1,(A0)+
            move.w  D6,D4
            mulu.w  D6,D4
            add.l   D6,D4
            subq.w  #1,D4
            lsr.w   #1,D4
.L19:
            move.l  D1,(A0)+
            dbra    D4,.L19
            move.l  D6,D4
            subq.w  #3,D4
            moveq   #8,D3
            sub.w   (8,A6),D3
            moveq   #1,D5
            lsl.w   D3,D5
            subq.w  #1,D5
            move.l  D6,D7
            mulu.w  D6,D7
            move.l  D7,D0
            add.l   D6,D0
            addq.w  #1,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l A5,A0
            suba.w  #$800,A0
            movea.l A0,A2
.L20:
            move.l  D5,D3
.L21:
            move.w  D0,(A0)+
            move.w  D1,(A0)+
            move.w  D2,(A0)+
            addq.w  #2,A0
            dbra    D3,.L21
            add.w   D7,D0
            add.w   D6,D1
            addq.w  #1,D2
            dbra    D4,.L20
            movea.l (-4,A6),A4
            addq.w  #2,A4
            movea.l ([$A.w,A6]),A1
            adda.l  (-$14,A6),A1
            clr.w   (A1)
            clr.w   (4,A1)
            clr.w   (2,A1)
            movea.l ([$E.w,A6]),A0
            moveq   #0,D5
            bsr.b   sub_4083BFBE
            move.w  (6,A0),D5
            bsr.b   sub_4083BFBE
            move.l  D5,D4
            subq.w  #2,D4
            ble.b   sub_4083BFBE.L4
            moveq   #1,D5
.L22:
            bsr.b   sub_4083BFBE
            addq.w  #1,D5
            dbra    D4,.L22
            bra.b   sub_4083BFBE.L4
sub_4083BFBE:
            btst    #6,(8,A0,D5.w*8)
            bne.b   .L3
            moveq   #0,D0
            moveq   #0,D1
            move.b  ($A,A0,D5.w*8),D0
            move.w  (0,A2,D0.w*8),D1
            move.b  ($C,A0,D5.w*8),D0
            add.w   (2,A2,D0.w*8),D1
            move.b  ($E,A0,D5.w*8),D0
            add.w   (4,A2,D0.w*8),D1
            move.w  (0,A3,D1.l*2),D2
            bmi.b   .L1
            move.b  (6,A1,D2.w),(6,A1,D5.w)
            move.b  D5,(6,A1,D2.w)
            addq.w  #1,(A1)
            bra.b   .L3
.L1:
            move.b  D5,(6,A1,D5.w)
            move.w  D5,(0,A3,D1.l*2)
            cmpa.l  A4,A5
            bne.b   .L2
            movea.l (-4,A6),A4
.L2:
            move.l  D1,D0
            addi.l  #0,D0
            move.w  D0,(A4)+
.L3:
            rts
.L4:
            movea.l (-4,A6),A1
            addq.l  #2,A1
            moveq   #1,D5
            bra.w   .L17
.L5:
            lea     (0,A3,D1.l*2),A0
            move.w  (A0),D4
            btst    #7,(0,A0,D5.l*2)
            beq.b   .L7
            move.w  D4,(0,A0,D5.l*2)
            cmpa.l  A4,A5
            bne.b   .L6
            movea.l (-4,A6),A4
.L6:
            move.l  D1,D0
            add.l   D5,D0
            move.w  D0,(A4)+
.L7:
            neg.l   D5
            btst    #7,(0,A0,D5.l*2)
            beq.b   .L9
            move.w  D4,(0,A0,D5.l*2)
            cmpa.l  A4,A5
            bne.b   .L8
            movea.l (-4,A6),A4
.L8:
            move.l  D1,D0
            add.l   D5,D0
            move.w  D0,(A4)+
.L9:
            btst    #7,(0,A0,D6.l*2)
            beq.b   .L11
            move.w  D4,(0,A0,D6.l*2)
            cmpa.l  A4,A5
            bne.b   .L10
            movea.l (-4,A6),A4
.L10:
            move.l  D1,D0
            add.l   D6,D0
            move.w  D0,(A4)+
.L11:
            neg.l   D6
            btst    #7,(0,A0,D6.l*2)
            beq.b   .L13
            move.w  D4,(0,A0,D6.l*2)
            cmpa.l  A4,A5
            bne.b   .L12
            movea.l (-4,A6),A4
.L12:
            move.l  D1,D0
            add.l   D6,D0
            move.w  D0,(A4)+
.L13:
            btst    #7,(0,A0,D7.l*2)
            beq.b   .L15
            move.w  D4,(0,A0,D7.l*2)
            cmpa.l  A4,A5
            bne.b   .L14
            movea.l (-4,A6),A4
.L14:
            move.l  D1,D0
            add.l   D7,D0
            move.w  D0,(A4)+
.L15:
            neg.l   D7
            btst    #7,(0,A0,D7.l*2)
            beq.b   .L17
            move.w  D4,(0,A0,D7.l*2)
            cmpa.l  A4,A5
            bne.b   .L16
            movea.l (-4,A6),A4
.L16:
            move.l  D1,D0
            add.l   D7,D0
            move.w  D0,(A4)+
            moveq   #0,D1
.L17:
            cmpa.l  A1,A5
            bne.b   .L18
            movea.l (-4,A6),A1
.L18:
            cmpa.l  A4,A1
            bne.b   .L19
            moveq   #0,D1
            bra.b   .L20
.L19:
            move.w  (A1)+,D1
.L20:
            bne.w   .L5
            movea.l ($A,A6),A0
            movea.l (A0),A0
            movea.l ([$E.w,A6]),A2
            move.l  (A2),(A0)+
            move.w  (8,A6),(A0)+
            move.l  (-$10,A6),D0
            lsr.l   #1,D0
            subq.w  #1,D0
            movea.l (-$C,A6),A2
            movea.l (A2),A2
.L21:
            move.w  (A2)+,D1
            cmpi.w  #$7FFF,D1
            beq.b   .L22
            move.b  D1,(A0)+
.L22:
            dbra    D0,.L21
            movea.l (-$C,A6),A0
            tst.b   (-$16,A6)
            beq.b   .QnotTmp
            jsr     ([$1A78.w])
            bra.b   .QallGone
.QnotTmp:
            _DisposHandle
.QallGone:
            movea.l (-4,A6),A0
            _DisposPtr
            move.l  (-8,A6),TheZone
.L25:
            movem.l (SP)+,D3-D7/A2-A5
            unlk    A6
            rtd     #$A
.L26:
            movea.l (-4,A6),A0
            _DisposPtr
.L27:
            move.w  #$FF69,QDErr
            bra.b   .L25
MAKEGRAYITAB:
            moveq   #-1,D0
            moveq   #$3F,D1
.L1:
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            dbra    D1,.L1
            clr.w   ($1FE,SP)
            move.w  #$FF,(SP)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            moveq   #0,D2
.L2:
            move.w  D0,D1
            btst    #6,(8,A0,D0.w*8)
            bne.b   .L3
            move.b  ($A,A0,D0.w*8),D2
            move.w  D1,(0,SP,D2.w*2)
.L3:
            dbra    D0,.L2
            movea.l SP,A1
            lea     ($200,A1),A1
.L4:
            moveq   #0,D1
            lea     (2,SP),A0
.L5:
            cmpa.l  A0,A1
            ble.b   .L6
            tst.w   (A0)+
            bpl.b   .L5
            move.w  (-4,A0),(-2,A0)
            addq.w  #2,A0
            st      D1
            bra.b   .L5
.L6:
            subq.w  #2,A0
.L7:
            cmpa.l  A0,SP
            bge.b   .L8
            tst.w   -(A0)
            bpl.b   .L7
            move.w  (2,A0),(A0)
            subq.w  #2,A0
            st      D1
            bra.b   .L7
.L8:
            tst.w   D1
            bne.b   .L4
            movea.l ($A,A6),A1
            movea.l (A1),A1
            movea.l ([$E.w,A6]),A2
            move.l  (A2),(A1)
            move.w  (8,A6),(4,A1)
            adda.l  (-$14,A6),A1
            bset    #$F,(2,A1)
            move.w  #$FF,D0
            lea     ($106,A1),A3
.L9:
            move.b  (1,SP,D0.w*2),D1
            move.b  D1,(6,A1,D0.w)
            move.b  ($A,A2,D1.w*8),(0,A3,D0.w)
            dbra    D0,.L9
            lea     ($200,SP),SP
            movea.l ([$A.w,A6]),A0
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            subq.w  #1,D0
            lea     (6,A0),A0
            lea     (6,A1),A1
            move.w  #$200,D4
            lsr.w   D2,D4
            move.w  #$900,D5
            lsr.w   D2,D5
            subi.w  #$200,D5
            move.w  #$500,D6
            lsr.w   D2,D6
            subi.w  #$900,D6
            suba.l  A2,A2
            move.w  D0,D1
.L10:
            move.w  D0,D2
.L11:
            move.w  D0,D3
.L12:
            move.w  A2,D7
            lsr.w   #4,D7
            move.b  (0,A1,D7.w),(A0)+
            adda.w  D4,A2
            dbra    D3,.L12
            adda.w  D5,A2
            dbra    D2,.L11
            adda.w  D6,A2
            dbra    D1,.L10
            rts
            ds.b    12
ITabMatch:
            link.w  A6,#-$A
            move.l  A2,-(SP)
            clr.b   ($10,A6)
            movea.l ([TheGDevice.w]),A2
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            move.l  ([6.w,A2]),D0
            cmp.l   (D0.l),D1
            beq.b   .L1
            move.l  A0,-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            movea.l ([TheGDevice.w]),A2
            move.l  ([6.w,A2]),D0
.L1:
            movea.l D0,A0
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            move.l  A1,(-$A,A6)
            tst.w   (2,A1)
            bpl.b   .L2
            movea.l ($C,A6),A0
            lea     (A0),A0
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            move.w  (A0),D2
            movea.l D1,A0
            add.l   D0,D1
            lsr.l   #1,D1
            add.l   D2,D1
            lsr.l   #1,D1
            add.l   D0,D1
            lsr.l   #1,D1
            add.l   A0,D1
            lsr.l   #1,D1
            lsr.l   #8,D1
            move.b  (6,A1,D1.w),D1
            bra.w   .L10
.L2:
            move.w  (4,A0),D2
            movea.l ($C,A6),A1
            bfextu  (A1){0:D2},D0
            lsl.l   D2,D0
            bfextu  (2,A1){0:D2},D1
            or.l    D1,D0
            lsl.l   D2,D0
            bfextu  (4,A1){0:D2},D1
            or.l    D1,D0
            move.b  (6,A0,D0.w),D1
            movea.l (-$A,A6),A1
            cmp.b   (6,A1,D1.w),D1
            beq.b   .L10
            movea.l ($C,A6),A0
            movea.l ([TheGDevice.w]),A2
            movea.l ([$16.w,A2]),A2
            movea.l ([$2A.w,A2]),A2
            move.w  D1,(-2,A6)
            move.w  D1,(-6,A6)
            move.w  #$7FFF,(-4,A6)
.L3:
            move.w  ($A,A2,D1.w*8),D0
            sub.w   (A0),D0
            bpl.b   .L4
            neg.w   D0
.L4:
            move.w  ($C,A2,D1.w*8),D2
            sub.w   (2,A0),D2
            bpl.b   .L5
            neg.w   D2
.L5:
            cmp.w   D2,D0
            bge.b   .L6
            move.w  D2,D0
.L6:
            move.w  ($E,A2,D1.w*8),D2
            sub.w   (4,A0),D2
            bpl.b   .L7
            neg.w   D2
.L7:
            cmp.w   D2,D0
            bge.b   .L8
            move.w  D2,D0
.L8:
            tst.w   D0
            beq.b   .L10
            cmp.w   (-4,A6),D0
            bge.b   .L9
            move.w  D0,(-4,A6)
            move.w  D1,(-2,A6)
.L9:
            move.b  (6,A1,D1.w),D1
            cmp.w   (-6,A6),D1
            bne.b   .L3
            move.w  (-2,A6),D1
.L10:
            movea.l (8,A6),A0
            ext.l   D1
            move.l  D1,(A0)
            move.b  #1,($10,A6)
            movea.l (SP)+,A2
            unlk    A6
            rtd     #8
            ds.b    10
COLORTHING2INDEX:
            link.w  A6,#-4
            clr.l   -(SP)
            movea.l (8,A6),A0
            move.w  (A0)+,-(SP)
            move.l  A0,(8,A6)
            moveq   #0,D0
            jsr     ([$1888.w])
            move.l  (SP)+,($C,A6)
            move.w  QDErr,D0
            bne.b   Color2Index.L1
            unlk    A6
            rtd     #4
Color2Index:
            link.w  A6,#-4
.L1:
            move.l  A2,-(SP)
            movea.l ([TheGDevice.w]),A2
            move.l  ($C,A2),D0
.L2:
            beq.b   .L4
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            subq.w  #2,SP
            move.l  (8,A6),-(SP)
            pea     (-4,A6)
            movea.l (A2),A0
            movea.l (4,A0),A0
            jsr     (A0)
            movea.l A2,A0
            _HUnlock
            tst.b   (SP)+
            bne.b   .L3
            movea.l (A2),A0
            move.l  (A0),D0
            bra.b   .L2
.L3:
            move.l  (-4,A6),D0
            move.l  D0,($C,A6)
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
.L4:
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #2,(4,A0)
            beq.b   .L5
            clr.b   -(SP)
            move.l  (8,A6),-(SP)
            pea     (-4,A6)
            jsr     ([$1C44.w])
            tst.b   (SP)+
            bra.b   .L7
.L5:
            movea.l ([$16.w,A0]),A1
            move.w  ($24,A1),D1
            movea.l (8,A6),A0
            moveq   #0,D0
            move.b  (A0),D0
            lsl.l   D1,D0
            move.b  (2,A0),D0
            lsl.l   D1,D0
            move.b  (4,A0),D0
            neg.w   D1
            addq.w  #8,D1
            ble.b   .L6
            lsr.l   D1,D0
.L6:
            move.l  D0,(-4,A6)
.L7:
            bra.b   .L3
            dc.w    0
Index2Color:
            move.l  (8,SP),D0
            movea.l (4,SP),A0
            movea.l ([TheGDevice.w]),A1
            movea.l ([$16.w,A1]),A1
            cmpi.w  #$10,($1E,A1)
            beq.b   .L3
            movea.l ([$2A.w,A1]),A1
            move.w  (6,A1),D1
            cmp.w   D1,D0
            bgt.b   .L2
            move.w  ($A,A1,D0.l*8),(A0)
            move.l  ($C,A1,D0.l*8),(2,A0)
.L1:
            rtd     #8
.L2:
            move.w  #$FF67,QDErr
            bra.b   .L1
.L3:
            moveq   #8,D1
            sub.w   ($24,A1),D1
            beq.b   .L4
            lsl.l   D1,D0
            move.w  ($24,A1),D1
            move.b  D0,D2
            lsl.w   D1,D2
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(4,A0)
            move.b  D2,(5,A0)
            move.w  D0,D2
            lsr.l   D1,D0
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(2,A0)
            move.b  D2,(3,A0)
            move.w  D0,D2
            lsr.l   D1,D0
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(A0)
            move.b  D2,(1,A0)
            bra.b   .L1
.L4:
            move.b  D0,(4,A0)
            move.b  D0,(5,A0)
            lsr.w   #8,D0
            move.b  D0,(2,A0)
            move.b  D0,(3,A0)
            swap    D0
            move.b  D0,(A0)
            move.b  D0,(1,A0)
            bra.b   .L1
            ds.b    6
InvertColor:
            move.l  A2,-(SP)
            movea.l ([TheGDevice.w]),A2
            move.l  ($10,A2),D0
.L1:
            beq.b   .L3
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            clr.b   -(SP)
            move.l  (8,SP),-(SP)
            movea.l (A0),A0
            movea.l (4,A0),A0
            jsr     (A0)
            movea.l A2,A0
            _HUnlock
            tst.b   (SP)+
            bne.b   .L2
            movea.l (A2),A0
            move.l  (A0),D0
            bra.b   .L1
.L2:
            movea.l (SP)+,A2
            rtd     #4
.L3:
            movea.l (8,SP),A0
            not.w   (A0)+
            not.w   (A0)+
            not.w   (A0)
            bra.b   .L2
            ds.b    14
RGBForeColor:
            moveq   #$50,D0
            moveq   #$24,D1
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (0,A0,D0.w)
            tst.w   (6,A0)
            bmi.b   .L2
            jsr     RGB2Old
            bra.b   .L6
.L2:
            move.l  (8,A0),D2
            beq.b   .L5
            movea.l D2,A1
            movea.l (A1),A1
            move.w  ($18,A1),D2
            cmpi.w  #$50,D0
            bne.b   .L3
            bclr    #0,D2
            bra.b   .L4
.L3:
            bclr    #1,D2
.L4:
            move.w  D2,($18,A1)
            movea.l (8,SP),A1
.L5:
            move.l  (A1),(0,A0,D1.w)
            move.w  (4,A1),(4,A0,D1.w)
            move.l  (2,A1),-(SP)
            move.w  (A1),-(SP)
            subq.w  #4,SP
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            addq.w  #6,SP
.L6:
            movea.l (SP)+,A0
            move.l  D0,(A0)
            rtd     #4
RGB2Old:
            moveq   #0,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            swap    D1
            lea     .L1,A0
            moveq   #0,D0
            move.w  (0,A0,D1.w*2),D0
            rts
.L1:
            dc.w    $0021,$0199,$0155,$0111,$00CD,$0089,$0045,$001E
RGBBackColor:
            moveq   #$54,D0
            moveq   #$2A,D1
            bra.w   RGBForeColor.L1
            dc.w    0
GetForeColor:
            moveq   #$50,D0
            moveq   #$24,D1
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L3
            move.l  (0,A0,D1.w),(A1)
            move.w  (4,A0,D1.w),(4,A1)
.L2:
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
.L3:
            move.l  (0,A0,D0.w),D0
            lsr.w   #1,D0
            bcs.b   .L4
            ori.w   #$E0,D0
.L4:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            lea     (2,A0,D0.w*8),A0
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            bra.b   .L2
GetBackColor:
            moveq   #$54,D0
            moveq   #$2A,D1
            bra.b   GetForeColor.L1
            ds.b    8
RealColor:
            link.w  A6,#-6
            clr.b   ($C,A6)
            subq.w  #4,SP
            move.l  (8,A6),-(SP)
            jsr     ([$16CC.w])
            pea     (-6,A6)
            jsr     ([$16D0.w])
            movea.l ([TheGDevice.w]),A0
            movea.l ([6.w,A0]),A0
            move.w  (4,A0),D2
            bfextu  ([8.w,A6]){0:D2},D0
            bfextu  (-6,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            bfextu  ([8.w,A6],2.w){0:D2},D0
            bfextu  (-4,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            bfextu  ([8.w,A6],4.w){0:D2},D0
            bfextu  (-2,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            move.b  #1,($C,A6)
.L1:
            unlk    A6
            rtd     #4
            ds.b    12
SetEntries:
            link.w  A6,#-$28
            movem.l D3/A2,-(SP)
            movea.l ([TheGDevice.w]),A0
            move.w  (2,A0),D2
            cmpi.w  #0,(4,A0)
            bne.w   .L13
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A2
            bset    #$D,(4,A2)
            bne.b   .L4
            move.w  ($C,A6),D1
            move.w  ($E,A6),D0
            bmi.b   .L5
            add.w   D1,D0
            cmp.w   (6,A2),D0
            bgt.b   .L3
.L1:
            btst    #7,(8,A2,D0.w*8)
            bne.b   .L4
            btst    #6,(8,A2,D0.w*8)
            beq.b   .L2
            cmp.b   (9,A2,D0.w*8),D2
            bne.b   .L4
.L2:
            subq.w  #1,D0
            dbra    D1,.L1
            bra.b   .L8
.L3:
            move.w  #$FF67,D0
            bra.w   .L14
.L4:
            move.w  #$FF66,D0
            bra.w   .L14
.L5:
            movea.l (8,A6),A0
.L6:
            move.w  (A0),D0
            andi.w  #$FF,D0
            cmp.w   (6,A2),D0
            bgt.b   .L3
            btst    #7,(8,A2,D0.w*8)
            bne.b   .L4
            btst    #6,(8,A2,D0.w*8)
            beq.b   .L7
            cmp.b   (9,A2,D0.w*8),D2
            bne.b   .L4
.L7:
            addq.w  #8,A0
            dbra    D1,.L6
.L8:
            move.w  ($E,A6),(-$24,A6)
            move.w  ($C,A6),(-$22,A6)
            move.l  (8,A6),(-$28,A6)
            clr.l   (-$14,A6)
            clr.w   (-$A,A6)
            movea.l ([TheGDevice.w]),A1
            move.w  (A1),(-8,A6)
            move.w  #3,(-6,A6)
            lea     (-$28,A6),A1
            move.l  A1,(-4,A6)
            lea     (-$20,A6),A0
            _Control immed
            tst.w   D0
            bne.b   .L14
            movea.l (8,A6),A0
            move.w  ($C,A6),D0
            move.w  ($E,A6),D1
            bmi.b   .L10
            lea     (8,A2,D1.w*8),A1
.L9:
            addq.w  #1,A1
            move.b  D2,(A1)+
            move.l  (A0)+,D3
            move.w  D3,(A1)+
            move.l  (A0)+,(A1)+
            dbra    D0,.L9
            bra.b   .L11
.L10:
            move.w  (A0)+,D3
            move.b  D2,(9,A2,D3.w*8)
            move.w  (A0)+,($A,A2,D3.w*8)
            move.l  (A0)+,($C,A2,D3.w*8)
            dbra    D0,.L10
.L11:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A2)
            bclr    #$D,(4,A2)
            move.l  MinusOne,LastSPExtra
.L12:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #8
.L13:
            move.w  #$FF65,D0
.L14:
            move.w  D0,QDErr
            bra.b   .L12
            ds.b    10
RestoreEntries:
            link.w  A6,#-$28
            movem.l D3/A2-A3,-(SP)
            clr.w   QDErr
            movea.l ([$10.w,A6]),A2
            movea.l (8,A6),A1
            move.w  (A1),D2
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #0,(4,A0)
            bne.w   .L11
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A0
            movea.l ([$C.w,A6]),A3
            cmpa.l  A0,A3
            beq.b   .L1
            tst.l   ($C,A6)
            bne.b   .L6
            movea.l A0,A3
.L1:
            moveq   #0,D1
            move.w  D2,D1
            addq.w  #1,D1
            asl.w   #1,D1
            suba.w  D1,SP
            move.w  D2,D0
.L2:
            move.w  (8,A2,D0.w*8),(0,SP,D0.w*2)
            dbra    D0,.L2
            move.w  D2,D0
.L3:
            move.w  (2,A1,D0.w*2),D3
            cmp.w   (6,A3),D3
            bgt.w   .L12
            move.w  D3,(8,A2,D0.w*8)
            dbra    D0,.L3
            clr.l   (-$14,A6)
            clr.w   (-$A,A6)
            movea.l ([TheGDevice.w]),A0
            move.w  (A0),(-8,A6)
            move.w  #3,(-6,A6)
            lea     (-$28,A6),A0
            move.l  A0,(-4,A6)
            lea     (8,A2),A0
            move.l  A0,(-$28,A6)
            move.w  #$FFFF,(-$24,A6)
            move.w  D2,(-$22,A6)
            lea     (-$20,A6),A0
            _Control immed
            beq.b   .L4
            move.w  D0,QDErr
.L4:
            move.w  D2,D0
.L5:
            move.w  (0,SP,D0.w*2),(8,A2,D0.w*8)
            dbra    D0,.L5
            adda.w  D1,SP
.L6:
            move.w  (2,A1,D2.w*2),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L7
            cmp.w   (6,A3),D0
            bgt.b   .L10
            move.l  (8,A2,D2.w*8),(8,A3,D0.w*8)
            move.l  ($C,A2,D2.w*8),($C,A3,D0.w*8)
.L7:
            dbra    D2,.L6
.L8:
            tst.l   ($C,A6)
            bne.b   .L9
            move.l  (8,A6),-(SP)
            move.w  #$12,D0
            _PaletteDispatch
.L9:
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #$C
.L10:
            move.w  #$FF67,QDErr
            bra.b   .L7
.L11:
            move.w  #$FF65,QDErr
            bra.b   .L9
.L12:
            move.w  #$FF67,QDErr
            move.w  D2,D0
.L13:
            move.w  (0,SP,D0.w*2),(8,A2,D0.w*8)
            dbra    D0,.L13
            adda.w  D1,SP
            bra.b   .L8
            dc.w    0
SaveEntries:
            link.w  A6,#0
            move.l  A2,-(SP)
            clr.w   QDErr
            tst.l   ($10,A6)
            bne.b   .L1
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #0,(4,A0)
            bne.b   .L11
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A2
            bra.b   .L2
.L1:
            movea.l ([$10.w,A6]),A2
.L2:
            movea.l (8,A6),A1
            move.w  (A1),D2
            move.w  D2,D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            movea.l ($C,A6),A0
            tst.l   (A0)
            beq.b   .L3
            _SetHandleSize
            bra.b   .L4
.L3:
            _ReallocHandle
.L4:
            beq.b   .L5
            move.w  #$FF68,QDErr
            bra.b   .L8
.L5:
            movea.l (A0),A0
            clr.l   (A0)
            clr.w   (4,A0)
            move.w  D2,(6,A0)
.L6:
            move.w  (2,A1,D2.w*2),D0
            cmp.w   (6,A2),D0
            bgt.b   .L10
            move.l  (8,A2,D0.w*8),(8,A0,D2.w*8)
            move.l  ($C,A2,D0.w*8),($C,A0,D2.w*8)
.L7:
            dbra    D2,.L6
.L8:
            movea.l (SP)+,A2
            unlk    A6
.L9:
            rtd     #$C
.L10:
            move.w  #$FFFF,(2,A1,D2.w*2)
            move.w  #$FF67,QDErr
            bra.b   .L7
.L11:
            move.w  #$FF65,QDErr
            bra.b   .L9
            dc.w    0
ProtectEntry:
            moveq   #7,D2
            bsr.b   CTCommon
.L1:
            rtd     #4
.L2:
            move.w  #$FF66,QDErr
            bra.b   .L4
.L3:
            move.w  #$FF67,QDErr
.L4:
            addq.w  #4,SP
            bra.b   .L1
CTCommon:
            clr.w   QDErr
            movea.l ([TheGDevice.w]),A0
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A0
            move.w  ($A,SP),D0
            cmp.w   (6,A0),D0
            bgt.b   ProtectEntry.L3
            tst.b   (8,SP)
            beq.b   .L1
            btst    D2,(8,A0,D0.w*8)
            bne.b   ProtectEntry.L2
            bset    D2,(8,A0,D0.w*8)
            bra.b   .L2
.L1:
            bclr    D2,(8,A0,D0.w*8)
.L2:
            rts
ReserveEntry:
            moveq   #6,D2
            bsr.b   CTCommon
            tst.b   (4,SP)
            beq.b   .L1
            move.w  (8,A0,D0.w*8),D1
            movea.l ([TheGDevice.w]),A1
            move.b  (3,A1),(9,A0,D0.w*8)
.L1:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A0)
            rtd     #4
            ds.b    6
SetClientID:
            movea.l ([TheGDevice.w]),A0
            move.w  (4,SP),(2,A0)
            rtd     #2
AddSearch:
            clr.w   QDErr
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            beq.b   .L1
            moveq   #8,D0
            _NewHandle
            bne.b   .L2
            move.l  D1,D0
            jsr     ([$644.w])
            movea.l ([TheGDevice.w]),A1
            move.l  ($C,A1),D1
            move.l  A0,($C,A1)
            movea.l (A0),A0
            move.l  D0,(4,A0)
            move.l  D1,(A0)
.L1:
            jmp     (D2.l)
.L2:
            move.w  #$FF68,QDErr
            bra.b   .L1
AddComp:
            clr.w   QDErr
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            beq.b   .L1
            moveq   #8,D0
            _NewHandle
            bne.b   AddSearch.L2
            move.l  D1,D0
            jsr     ([$644.w])
            movea.l ([TheGDevice.w]),A1
            move.l  ($10,A1),D1
            move.l  A0,($10,A1)
            movea.l (A0),A0
            move.l  D0,(4,A0)
            move.l  D1,(A0)
.L1:
            jmp     (D2.l)
            ds.b    4
DelSearch:
            move.l  (4,SP),D1
            movea.l ([TheGDevice.w]),A1
            lea     ($C,A1),A1
            move.l  (A1),D2
.L1:
            beq.b   .L3
            movea.l D2,A0
            movea.l (A0),A0
            cmp.l   (4,A0),D1
            beq.b   .L2
            lea     (A0),A1
            move.l  (A0),D2
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            movea.l D2,A0
            _DisposHandle
.L3:
            rtd     #4
            ds.b    4
DelComp:
            move.l  (4,SP),D1
            movea.l ([TheGDevice.w]),A1
            lea     ($10,A1),A1
            move.l  (A1),D2
.L1:
            beq.b   .L3
            movea.l D2,A0
            movea.l (A0),A0
            cmp.l   (4,A0),D1
            beq.b   .L2
            lea     (A0),A1
            move.l  (A0),D2
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            movea.l D2,A0
            _DisposHandle
.L3:
            rtd     #4
            ds.b    4
GetSubTable:
            link.w  A6,#-$C
            movem.l D3/A2,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            _NewEmptyHandle
            move.l  A0,(-4,A6)
            move.l  (8,A6),-(SP)
            move.l  A0,-(SP)
            move.w  ($C,A6),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            bne.b   .L3
            movea.l ([TheGDevice.w]),A1
            move.l  (6,A1),(-8,A6)
            move.l  (-4,A6),(6,A1)
            movea.l ([$16.w,A1]),A1
            move.l  ($2A,A1),(-$C,A6)
            move.l  ($E,A6),($2A,A1)
            movea.l ([$2A.w,A1]),A1
            move.l  (A1),D0
            movea.l ([-4.w,A6]),A1
            move.l  D0,(A1)
.L1:
            movea.l ($E,A6),A0
            _HLock
            movea.l (A0),A2
            move.w  (6,A2),D3
.L2:
            subq.w  #4,SP
            pea     ($A,A2,D3.w*8)
            jsr     ([$16CC.w])
            addq.w  #2,SP
            move.w  (SP)+,(8,A2,D3.w*8)
            dbra    D3,.L2
            movea.l ($E,A6),A0
            _HUnlock
            tst.l   (8,A6)
            beq.b   .L4
            movea.l ([TheGDevice.w]),A1
            move.l  (-8,A6),(6,A1)
            movea.l ([$16.w,A1]),A1
            move.l  (-$C,A6),($2A,A1)
.L3:
            movea.l (-4,A6),A0
            _DisposHandle
.L4:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$A
            ds.b    12
QDError:
            move.w  QDErr,(4,SP)
            clr.w   QDErr
            rts
            ds.b    4
DELTARGB:
            link.w  A6,#0
            movem.l D0-D1/A0-A1,-(SP)
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcc.b   .L1
            neg.w   D0
.L1:
            move.w  (A1)+,D1
            sub.w   (A0)+,D1
            bcc.b   .L2
            neg.w   D1
.L2:
            cmp.w   D0,D1
            bcs.b   .L3
            move.w  D1,D0
.L3:
            move.w  (A1),D1
            sub.w   (A0),D1
            bcc.b   .L4
            neg.w   D1
.L4:
            cmp.w   D0,D1
            bcs.b   .L5
            move.w  D1,D0
.L5:
            move.w  D0,($10,A6)
            movem.l (SP)+,D0-D1/A0-A1
            unlk    A6
            rtd     #8
            ds.b    12
.L6:
            dc.w    0,$FFFF,$5555,0,$1111
            ds.b    6
            dc.w    $0101
.L7:
            andi.w  #$F,D0
            move.w  D0,(4,SP)
            moveq   #0,D1
            addq.w  #3,D0
            bset    D0,D1
            addq.l  #8,D1
            move.l  D1,D0
            _NewHandle
            beq.b   .L8
            clr.l   (6,SP)
            rtd     #2
.L8:
            move.w  (4,SP),D0
            lea     .L6,A1
            move.w  (0,A1,D0.w*2),D1
            move.w  D1,D2
            swap    D2
            move.w  D1,D2
            movea.l (A0),A1
            move.w  #$8000,(4,A1)
            clr.w   D1
            bset    D0,D1
            subq.w  #1,D1
            move.w  D1,(6,A1)
            cmpi.w  #3,D0
            blt.b   .L9
            addi.w  #$20,D0
.L9:
            move.l  D0,(A1)
            lea     (8,A1),A1
            moveq   #-1,D0
            moveq   #0,D1
.L10:
            move.w  D1,(A1)+
            addq.w  #1,D1
            move.l  D0,(A1)+
            move.w  D0,(A1)+
            sub.l   D2,D0
            bcc.b   .L10
            bra.w   GETCTABLE.L1
.L11:
            andi.w  #$F,D0
            move.w  D0,-(SP)
            bsr.w   sub_4083CDBE
            move.l  A0,D0
            beq.w   GETCTABLE.L1
            movea.l (A0),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            move.w  (4,SP),D0
            btst    #1,D0
            beq.b   .L13
            lea     ($DA0).w,A1
            move.b  (A1),D1
            cmp.b   (2,A1),D1
            bne.b   .L12
            cmp.b   (4,A1),D1
            beq.w   GETCTABLE.L1
.L12:
            movea.l (A0),A1
            lea     ($12,A1),A1
            move.l  #$7FFF7FFF,(A1)+
            move.w  #$7FFF,(A1)+
            addq.w  #2,A1
            move.l  ($DA0).w,(A1)+
            move.w  ($DA4).w,(A1)
            bra.w   GETCTABLE.L1
.L13:
            btst    #2,D0
            beq.w   GETCTABLE.L1
            move.w  #$E,D2
            move.l  #$1FFFF,D1
.L14:
            subq.w  #2,SP
            pea     ($DA0).w
            pea     ($A,A1,D2.w*8)
            jsr     DELTARGB
            move.w  (SP)+,D0
            cmp.w   D0,D1
            bls.b   .L15
            move.w  D0,D1
            swap    D1
            move.w  D2,D1
            swap    D1
.L15:
            subq.w  #1,D2
            bne.b   .L14
            cmpi.w  #$3000,D1
            bls.b   GETCTABLE.L1
            swap    D1
            lea     ($A,A1,D1.w*8),A1
.L16:
            move.l  ($DA0).w,D0
            swap    D0
            add.w   (A1),D0
            roxr.w  #1,D0
            move.w  D0,(A1)
            swap    D0
            add.w   (2,A1),D0
            roxr.w  #1,D0
            move.w  D0,(2,A1)
            move.w  ($DA4).w,D0
            add.w   (4,A1),D0
            roxr.w  #1,D0
            move.w  D0,(4,A1)
            subq.w  #2,SP
            pea     ($DA0).w
            pea     (A1)
            jsr     DELTARGB
            cmpi.w  #$3000,(SP)+
            bhi.b   .L16
            bra.b   GETCTABLE.L1
GETCTABLE:
            move.w  (4,SP),-(SP)
            bsr.b   sub_4083CDBE
            move.l  A0,D0
            beq.b   .L3
.L1:
            move.l  A0,(6,SP)
.L2:
            rtd     #2
.L3:
            move.w  (4,SP),D0
            cmpi.w  #$48,D0
            bhi.b   .L2
            move.l  #$116,D1
            btst    D0,D1
            beq.b   .L2
            btst    #5,D0
            bne.w   DELTARGB.L7
            btst    #6,D0
            bne.w   DELTARGB.L11
            bra.b   .L2
sub_4083CDBE:
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  ($C,SP),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   .L1
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            jsr     ([$1448.w])
            movea.l (SP)+,A0
            _HNoPurge
            movea.l (A0),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            bra.b   .L3
.L1:
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  ($C,SP),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            jsr     ([$1584.w])
            beq.b   .L3
.L2:
            suba.l  A0,A0
.L3:
            rtd     #2
            ds.b    4
