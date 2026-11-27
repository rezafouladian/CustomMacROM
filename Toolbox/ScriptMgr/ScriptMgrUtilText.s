            include "Include/ROMHeader.s"

            IMPORT  STDUNLINK,A

            SECTION "ScriptMgrUtilText",CODE

StyledLineBreak:
            link.w  A6,#-$12
            movem.l D4-D6/A2-A3,-(SP)
            movea.l ($10,A6),A3
            move.l  ($24,A6),D5
            add.l   ($1C,A6),D5
            move.w  TESysJust,(-$10,A6)
            clr.w   TESysJust
            clr.w   -(SP)
            move.l  #$82000000,-(SP)
            _ScriptUtil
            move.w  (SP)+,D0
            lsl.w   #2,D0
            movea.l IntlSpec,A2
            movea.l ($72,A2,D0.w),A2
            move.b  ($12,A2),(-$12,A6)
            bclr    #$F,($12,A2)
            move.l  ($18,A6),D4
            sub.l   ($1C,A6),D4
            ble.w   .L3
            tst.l   (A3)
            bmi.w   .L6
            clr.w   -(SP)
            move.l  D5,-(SP)
            move.w  D4,-(SP)
            clr.w   -(SP)
            move.w  (A3),-(SP)
            pea     (-$D,A6)
            move.l  #$820E0014,-(SP)
            _ScriptUtil
            moveq   #0,D6
            move.w  (SP)+,D6
            tst.l   (A3)
            bne.b   .L1
            st      (-$D,A6)
.L1:
            movea.l D5,A0
            move.w  D6,D0
            bsr.w   FindCarriage
            add.w   ($1E,A6),D1
            tst.b   D0
            bne.w   .L9
            move.l  D6,D0
            add.l   ($1C,A6),D6
            cmp.l   D4,D0
            blt.b   .L2
            tst.b   (-$D,A6)
            bne.b   .L3
.L2:
            move.l  ($24,A6),-(SP)
            move.w  ($22,A6),-(SP)
            move.w  D6,-(SP)
            move.b  (-$D,A6),-(SP)
            move.l  MinusOne,-(SP)
            pea     (-$C,A6)
            move.l  #$8012001A,-(SP)
            _ScriptUtil
            clr.w   -(SP)
            move.l  ($24,A6),-(SP)
            move.w  (-$C,A6),-(SP)
            move.l  #$82060012,-(SP)
            _ScriptUtil
            move.w  (SP)+,D0
            moveq   #0,D1
            move.w  (-$C,A6),D1
            andi.w  #$F0F,D0
            cmpi.w  #$300,D0
            bne.b   .L4
            btst    #$F,(-$12,A6)
            sne     D0
            cmp.b   (-$F,A6),D0
            bne.b   .L4
            movea.l ($24,A6),A0
            moveq   #0,D6
            move.w  (-$C,A6),D6
            adda.l  D6,A0
            move.w  (-$A,A6),D0
            sub.w   D6,D0
            bsr.w   FindCarriage
            add.w   D6,D1
            bra.b   .L9
.L3:
            clr.w   -(SP)
            move.l  D5,-(SP)
            clr.w   -(SP)
            move.w  D4,-(SP)
            _TextWidth
            move.w  (SP)+,D0
            swap    D0
            clr.w   D0
            sub.l   D0,(A3)
            move.l  ($18,A6),D6
            moveq   #2,D0
            bra.b   .L10
.L4:
            tst.l   D1
            bne.b   .L9
            movea.l ($C,A6),A0
            tst.l   (A0)
            beq.b   .L9
            tst.b   (-$D,A6)
            bne.b   .L5
            subq.l  #1,D6
            clr.w   -(SP)
            move.l  D5,-(SP)
            move.l  D6,D0
            sub.l   ($1C,A6),D0
            move.w  D0,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            ble.b   .L5
            subq.l  #1,D6
.L5:
            tst.l   D6
            bgt.b   .L8
            bra.b   .L7
.L6:
            movea.l ($C,A6),A0
            tst.l   (A0)
            bne.b   .L7
            moveq   #0,D1
            bra.b   .L9
.L7:
            moveq   #1,D6
            clr.w   -(SP)
            move.l  D5,-(SP)
            move.w  #1,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            ble.b   .L8
            addq.l  #1,D6
.L8:
            moveq   #1,D0
            bra.b   .L10
.L9:
            moveq   #0,D6
            move.w  D1,D6
            moveq   #0,D0
.L10:
            movea.l ($C,A6),A0
            move.l  D6,(A0)
            move.b  D0,($28,A6)
            move.b  (-$12,A6),($12,A2)
            move.w  (-$10,A6),TESysJust
            movem.l (SP)+,D4-D6/A2-A3
            move.w  #$20,D0
            bra.w   STDUNLINK
            dc.w    0
FindCarriage:
            move.w  D0,D1
            move.b  #$D,D2
            bra.b   .L2
.L1:
            cmp.b   (A0)+,D2
.L2:
            dbeq    D0,.L1
            beq.b   .L3
            sf      D0
            bra.b   .L4
.L3:
            sub.w   D0,D1
            st      D0
.L4:
            rts
            ds.b    6
FormatOrder:
            link.w  A6,#0
            movem.l D4-D6/A2-A3,-(SP)
            movea.l ($1A,A6),A2
            move.w  ($18,A6),D3
            move.w  ($16,A6),D4
            cmp.w   D3,D4
            ble.b   .L6
            movea.l ($10,A6),A3
            moveq   #2,D5
            move.b  ($14,A6),D6
            beq.b   .L1
            move.w  D4,D0
            sub.w   D3,D0
            add.w   D0,D0
            adda.w  D0,A2
            neg.w   D5
.L1:
            clr.b   -(SP)
            move.w  D3,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     (A3)
            move.w  D3,D1
            cmp.b   (SP)+,D6
            beq.b   .L2
            not.w   D1
.L2:
            move.w  D1,(A2)
            adda.w  D5,A2
            addq.w  #1,D3
            cmp.w   D3,D4
            bge.b   .L1
            sub.w   ($18,A6),D4
            moveq   #-1,D5
            clr.w   D3
            movea.l ($1A,A6),A2
            movea.l A2,A3
.L3:
            tst.w   (A3)+
            bge.b   .L4
            tst.w   D5
            bge.b   .L5
            move.w  D3,D5
            bra.b   .L5
.L4:
            tst.w   D5
            blt.b   .L5
            bsr.b   ReverseCluster
            moveq   #-1,D5
.L5:
            addq.w  #1,D3
            cmp.w   D3,D4
            bge.b   .L3
            tst.w   D5
            blt.b   .L6
            bsr.b   ReverseCluster
.L6:
            movem.l (SP)+,D4-D6/A2-A3
            move.w  #$16,D0
            bra.w   STDUNLINK
ReverseCluster:
            move.w  D3,D2
            sub.w   D5,D2
            subq.w  #1,D2
            asr.w   #1,D2
            move.w  D5,D0
            add.w   D0,D0
            lea     (0,A2,D0.w),A0
            move.w  D3,D0
            add.w   D0,D0
            lea     (0,A2,D0.w),A1
.L1:
            move.w  (A0),D0
            not.w   D0
            move.w  -(A1),D1
            not.w   D1
            move.w  D0,(A1)
            move.w  D1,(A0)+
            dbra    D2,.L1
            rts
            dc.w    0
IntlTokenize:
            link.w  A6,#0
            movem.l D2-D7/A2-A6,-(SP)
            movea.l ($C,A6),A5
            movea.l ($40,A5),A4
            move.l  (A4),D6
            bne.b   .L1
            move.l  A4,-(SP)
            _LoadResource
            move.l  (A4),D6
.L1:
            movea.l D6,A4
            movea.l (A5),A0
            move.l  (4,A5),D0
            movea.l (8,A5),A1
            tst.b   ($21,A5)
            beq.b   .L2
            move.l  ($10,A5),D6
            mulu.w  #$E,D6
            adda.l  D6,A1
.L2:
            move.l  A1,-(SP)
            move.l  ($C,A5),D1
            move.l  ($24,A5),D3
            move.l  ($2C,A5),D4
            move.l  ($30,A5),D5
            move.l  ($14,A4),D6
            lea     (0,A4,D6.w),A4
            lea     sub_40820040.L2,A6
            move.l  A6,(-8,A4)
            movea.l IntlSpec,A6
            lea     ($17C,A6),A6
            lea     (-2,A6),A2
            clr.w   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            clr.l   (A2)+
            movea.l A0,A2
            clr.w   D6
            move.b  D3,D6
            bmi.b   .L3
            asr.w   #3,D6
            bset    D3,(0,A6,D6.w)
.L3:
            swap    D3
            clr.w   D6
            move.b  D3,D6
            bmi.b   .L4
            asr.w   #3,D6
            bset    D3,(0,A6,D6.w)
.L4:
            swap    D3
            clr.w   D6
            move.b  D4,D6
            bmi.b   .L5
            asr.w   #3,D6
            bset    D4,(0,A6,D6.w)
.L5:
            clr.w   D6
            move.b  D5,D6
            bmi.b   .L6
            asr.w   #3,D6
            bset    D5,(0,A6,D6.w)
.L6:
            moveq   #0,D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L7
            move.b  (0,A4,D2.w),D2
            bpl.b   .L8
.L7:
            bsr.w   sub_4082002E
.L8:
            swap    D2
            bra.b   .L10
.L9:
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  D2,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
.L10:
            movea.l A3,A2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L11
            move.b  (0,A4,D2.w),D2
            bpl.b   .L12
.L11:
            bsr.w   sub_4082002E
.L12:
            swap    D2
            move.w  D2,D6
            asr.w   #3,D6
            btst    D2,(0,A6,D6.w)
            bne.w   .L108
.L13:
            cmpi.w  #4,D2
            beq.w   .L24
            cmpi.w  #1,D2
            beq.b   .L14
            cmpi.w  #$10,D2
            bge.w   .L89
            cmpi.w  #5,D2
            beq.b   .L19
            cmpi.w  #6,D2
            beq.b   .L9
            cmpi.w  #$B,D2
            beq.w   .L70
            tst.w   D2
            beq.b   .L9
            bmi.w   sub_40820040.L1
            bra.w   sub_40820040.L6
.L14:
            swap    D2
.L15:
            cmpi.w  #1,D2
            bne.b   .L18
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L16
            move.b  (0,A4,D2.w),D2
            bpl.b   .L17
.L16:
            bsr.w   sub_4082002E
.L17:
            bra.b   .L15
.L18:
            swap    D2
            bra.w   .L9
.L19:
            swap    D2
            moveq   #5,D7
.L20:
            cmp.w   D7,D2
            bne.b   .L23
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L21
            move.b  (0,A4,D2.w),D2
            bpl.b   .L22
.L21:
            bsr.w   sub_4082002E
.L22:
            bra.b   .L20
.L23:
            cmp.w   ($3E,A5),D2
            beq.w   .L75
            swap    D2
            bra.w   .L9
.L24:
            swap    D2
            moveq   #4,D7
            tst.b   ($22,A5)
            beq.b   .L29
.L25:
            cmp.w   D7,D2
            beq.b   .L26
            cmpi.w  #5,D2
            beq.b   .L26
            cmpi.w  #$B,D2
            bne.b   .L32
.L26:
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L27
            move.b  (0,A4,D2.w),D2
            bpl.b   .L28
.L27:
            bsr.w   sub_4082002E
.L28:
            bra.b   .L25
.L29:
            cmp.w   D7,D2
            bne.b   .L32
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L30
            move.b  (0,A4,D2.w),D2
            bpl.b   .L31
.L30:
            bsr.w   sub_4082002E
.L31:
            bra.b   .L29
.L32:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #4,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L33:
            move.l  ($28,A5),D3
            swap    D3
            bra.b   .L35
.L34:
            move.l  ($28,A5),D3
.L35:
            move.w  ($3C,A5),D4
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #2,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            swap    D2
.L36:
            cmp.w   D2,D3
            beq.w   .L44
            cmp.w   D2,D4
            bne.b   .L41
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #9,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L37
            move.b  (0,A4,D2.w),D2
            bpl.b   .L38
.L37:
            bsr.w   sub_4082002E
.L38:
            bmi.w   sub_40820040.L5
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$A,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L39
            move.b  (0,A4,D2.w),D2
            bpl.b   .L40
.L39:
            bsr.w   sub_4082002E
.L40:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  D2,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            swap    D2
            bra.b   .L36
.L41:
            tst.w   D2
            bmi.w   sub_40820040.L5
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L42
            move.b  (0,A4,D2.w),D2
            bpl.b   .L43
.L42:
            bsr.w   sub_4082002E
.L43:
            bra.w   .L36
.L44:
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #9,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            move.l  ($24,A5),D3
            move.l  ($2C,A5),D4
            movea.l A3,A2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L45
            move.b  (0,A4,D2.w),D2
            bpl.b   .L46
.L45:
            bsr.w   sub_4082002E
.L46:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #3,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L47:
            move.l  ($38,A5),D3
            movea.w #1,A6
            bra.b   .L49
.L48:
            move.l  D4,D5
            movea.w #1,A6
            move.l  ($34,A5),D3
.L49:
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L50
            move.b  (0,A4,D2.w),D2
            bpl.b   .L51
.L50:
            bsr.w   sub_4082002E
.L51:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #7,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            tst.l   D3
            bmi.b   .L55
            bra.w   .L62
.L52:
            move.l  ($38,A5),D3
            bra.b   .L54
.L53:
            move.l  ($34,A5),D3
.L54:
            movea.w #1,A6
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #7,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            tst.l   D3
            bmi.b   .L55
            bra.b   .L62
.L55:
            swap    D2
.L56:
            cmp.w   D2,D3
            beq.b   .L59
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L57
            move.b  (0,A4,D2.w),D2
            bpl.b   .L58
.L57:
            bsr.w   sub_4082002E
.L58:
            bpl.b   .L56
            bra.w   sub_40820040.L5
.L59:
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #9,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L60
            move.b  (0,A4,D2.w),D2
            bpl.b   .L61
.L60:
            bsr.w   sub_4082002E
.L61:
            swap    D2
            move.l  ($24,A5),D3
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #8,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            move.l  ($30,A5),D5
            movea.l IntlSpec,A6
            lea     ($17C,A6),A6
            bra.w   .L10
.L62:
            move.l  A3,D7
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L63
            move.b  (0,A4,D2.w),D2
            bpl.b   .L64
.L63:
            bsr.w   sub_4082002E
.L64:
            swap    D2
            cmp.l   D2,D5
            beq.b   .L66
.L65:
            cmp.l   D2,D3
            beq.b   .L67
            tst.w   D2
            bpl.b   .L62
            bra.w   sub_40820040.L5
.L66:
            tst.b   ($23,A5)
            beq.b   .L65
            movea.l D7,A3
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #9,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l D7,A2
            addq.w  #1,A6
            bra.w   .L49
.L67:
            movea.l D7,A3
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #9,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l D7,A2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L68
            move.b  (0,A4,D2.w),D2
            bpl.b   .L69
.L68:
            bsr.w   sub_4082002E
.L69:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #8,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            movea.l A3,A2
            subq.w  #1,A6
            cmpa.w  #0,A6
            bne.w   .L62
            move.l  ($24,A5),D3
            move.l  ($30,A5),D5
            movea.l IntlSpec,A6
            lea     ($17C,A6),A6
            bra.w   .L10
.L70:
            swap    D2
            moveq   #$B,D7
.L71:
            cmp.w   D7,D2
            bne.b   .L74
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L72
            move.b  (0,A4,D2.w),D2
            bpl.b   .L73
.L72:
            bsr.w   sub_4082002E
.L73:
            bra.b   .L71
.L74:
            cmp.w   ($3E,A5),D2
            beq.b   .L82
            swap    D2
            bra.w   .L9
.L75:
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L76
            move.b  (0,A4,D2.w),D2
            bpl.b   .L77
.L76:
            bsr.w   sub_4082002E
.L77:
            moveq   #5,D7
.L78:
            cmp.w   D7,D2
            bne.b   .L81
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L79
            move.b  (0,A4,D2.w),D2
            bpl.b   .L80
.L79:
            bsr.w   sub_4082002E
.L80:
            bra.b   .L78
.L81:
            swap    D2
            move.w  #$C,D2
            bra.w   .L9
.L82:
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L83
            move.b  (0,A4,D2.w),D2
            bpl.b   .L84
.L83:
            bsr.w   sub_4082002E
.L84:
            moveq   #$B,D7
.L85:
            cmp.w   D7,D2
            bne.b   .L88
            swap    D2
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L86
            move.b  (0,A4,D2.w),D2
            bpl.b   .L87
.L86:
            bsr.w   sub_4082002E
.L87:
            bra.b   .L85
.L88:
            swap    D2
            move.w  #$D,D2
            bra.w   .L9
.L89:
            swap    D2
            cmpi.w  #$21,D2
            bne.w   .L104
            swap    D2
            cmpi.w  #$1F,D2
            bne.b   .L92
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L90
            move.b  (0,A4,D2.w),D2
            bpl.b   .L91
.L90:
            bsr.w   sub_4082002E
.L91:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$22,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L92:
            cmpi.w  #$20,D2
            bne.b   .L95
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L93
            move.b  (0,A4,D2.w),D2
            bpl.b   .L94
.L93:
            bsr.w   sub_4082002E
.L94:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$24,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L95:
            cmpi.w  #$44,D2
            bne.b   .L98
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L96
            move.b  (0,A4,D2.w),D2
            bpl.b   .L97
.L96:
            bsr.w   sub_4082002E
.L97:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$27,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L98:
            cmpi.w  #$21,D2
            bne.b   .L101
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L99
            move.b  (0,A4,D2.w),D2
            bpl.b   .L100
.L99:
            bsr.w   sub_4082002E
.L100:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$26,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L101:
            cmpi.w  #$2B,D2
            bne.b   .L107
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L102
            move.b  (0,A4,D2.w),D2
            bpl.b   .L103
.L102:
            bsr.w   sub_4082002E
.L103:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$2A,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L104:
            swap    D2
            cmpi.l  #$1F0020,D2
            bne.b   .L107
            movea.l A0,A3
            move.b  (A0)+,D2
            subq.l  #1,D0
            bmi.b   .L105
            move.b  (0,A4,D2.w),D2
            bpl.b   .L106
.L105:
            bsr.w   sub_4082002E
.L106:
            swap    D2
            move.l  A3,D6
            sub.l   A2,D6
            subq.l  #1,D1
            bmi.w   sub_40820040.L4
            move.w  #$29,(A1)+
            move.l  A2,(A1)+
            move.l  D6,(A1)+
            clr.l   (A1)+
            bra.w   .L10
.L107:
            move.l  A3,D7
            sub.l   A2,D7
            bra.w   .L9
.L108:
            cmp.w   D2,D3
            beq.w   .L34
            swap    D3
            cmp.w   D2,D3
            beq.w   .L33
            swap    D3
            tst.l   D4
            bpl.b   .L109
            cmp.w   D2,D4
            bne.b   .L110
            bra.w   .L53
.L109:
            cmp.l   D2,D4
            beq.w   .L48
.L110:
            tst.l   D5
            bpl.b   .L111
            cmp.w   D2,D5
            beq.w   .L52
            bra.w   .L13
.L111:
            cmp.l   D2,D5
            beq.w   .L47
            bra.w   .L13
sub_4082002E:
            tst.l   D0
            bpl.b   .L1
            move.w  #$FFFF,D2
            rts
.L1:
            move.l  (-4,A4),D6
            jmp     (0,A4,D6.l)
sub_40820040:
            movea.l ($40,A5),A6
            movea.l (A6),A6
            move.l  ($18,A6),D6
            jmp     (0,A6,D6.l)
.L1:
            moveq   #0,D6
.L2:
            move.w  D6,-(SP)
            move.l  A1,D6
            sub.l   (8,A5),D6
            divs.w  #$E,D6
            move.l  D6,($10,A5)
            tst.b   ($20,A5)
            beq.b   .L3
            bsr.b   sub_40820040
.L3:
            move.w  (SP)+,D0
            addq.l  #4,SP
            movem.l (SP)+,D2-D7/A2-A6
            unlk    A6
            movea.l (SP)+,A0
            addq.l  #8,SP
            move.b  D0,(SP)
            jmp     (A0)
.L4:
            move.w  #1,D6
            bra.b   .L2
.L5:
            move.w  #3,D6
            bra.b   .L2
.L6:
            move.w  #5,D6
            bra.b   .L2
            ds.b    4

            EVEN
