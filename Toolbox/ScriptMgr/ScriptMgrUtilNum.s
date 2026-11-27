            include "Include/ROMHeader.s"

            IMPORT  STDUNLINK,A

            SECTION "ScriptMgrUtilNum",CODE

CharComp:
            link.w  A6,#0
            lea     ($A,A6),A0
            move.w  #2,D0
            _UpperText
            move.w  (A0),D1
            lea     (8,A6),A0
            move.w  #2,D0
            _UpperText
            cmp.w   (A0),D1
            seq     ($C,A6)
            move.w  #4,D0
            bra.w   STDUNLINK
            ds.b    8
NextFormatClass:
            ext.w   D0
            addq.w  #1,D0
            cmpi.w  #3,D0
            bne.b   .L1
            moveq   #0,D0
.L1:
            rts
            dc.w    0
GetSANEClass:
            clr.w   -(SP)
            movea.l SP,A0
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            move.w  #$1C,-(SP)
            _FP68K
            move.w  (SP)+,D0
            rts
            ds.b    14
SendByte:
            move.b  D0,D1
            beq.b   .L1
            moveq   #8,D0
            move.w  (A1),D2
            cmp.b   (A0),D2
            bcc.b   .L2
            move.b  D1,(0,A0,D2.w)
            addq.w  #1,(A1)
.L1:
            moveq   #0,D0
.L2:
            rts
            ds.b    10
SendCharRev0:
            ror.w   #8,D0
SendChar0:
            move.w  D0,-(SP)
            move.b  (SP),D0
            bsr.b   SendByte
            move.w  (SP)+,D0
            bsr.b   SendByte
            rts
            dc.w    0
SendCharRev:
            move.b  ($C,SP),D0
            move.b  ($D,SP),($C,SP)
            move.b  D0,($D,SP)
SendChar:
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.l  D2,-(SP)
            bsr.b   SendChar0
            move.w  D0,(4,SP)
            rts
RetrieveChar:
INUNQUOTEDS:
            link.w  A6,#-2
            movem.l D7/A2-A4,-(SP)
            movea.l ($C,A6),A3
            movea.l (8,A6),A4
            clr.w   ($10,A6)
            movea.l ($14,A4),A2
            clr.w   D0
            move.b  (A2),D0
            cmp.w   (A3),D0
            blt.b   .L3
            clr.w   -(SP)
            pea     (1,A2)
            move.w  (A3),D0
            subq.w  #1,D0
            move.w  D0,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            move.w  (SP)+,D7
            bne.b   .L1
            move.w  (A3),D0
            clr.w   D1
            move.b  (0,A2,D0.w),D1
            move.w  D1,($10,A6)
            addq.w  #1,(A3)
            bra.b   .L3
.L1:
            bpl.b   .L2
            move.w  (A3),D0
            cmp.b   (A2),D0
            bge.b   .L2
            move.b  (0,A2,D0.w),($10,A6)
            move.b  (1,A2,D0.w),($11,A6)
            addq.w  #2,(A3)
            bra.b   .L3
.L2:
            move.w  #2,($18,A4)
.L3:
            movem.l (SP)+,D7/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
            ds.b    14
CheckExp:
            link.w  A6,#-4
            movem.l D6-D7/A2-A4,-(SP)
            movea.l (8,A6),A2
            movea.l (8,A2),A3
            movea.l ($10,A3),A4
            addq.w  #2,A4
            movea.l ($C,A6),A0
            tst.w   (A0)
            blt.b   .L2
            move.w  (2,A0),D6
            beq.b   .L2
            move.w  #$1E,D7
.L1:
            cmp.w   (A4)+,D6
            dbeq    D7,.L1
            bne.b   .L2
            clr.b   ($C,A2)
.L2:
            movem.l (SP)+,D6-D7/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
CheckPartsIntegrity:
            link.w  A6,#-6
            movem.l D5-D7/A4,-(SP)
            movea.l (8,A6),A0
            movea.l ($10,A0),A4
            st      ($C,A6)
            cmpi.w  #1,(A4)
            bne.w   .L9
            moveq   #1,D7
            bra.b   .L6
.L1:
            move.w  D7,D0
            add.w   D0,D0
            move.w  (0,A4,D0.w),D5
            beq.b   .L5
            move.w  D7,D6
            addq.w  #1,D6
            bra.b   .L4
.L2:
            move.w  D6,D0
            add.w   D0,D0
            cmp.w   (0,A4,D0.w),D5
            bne.b   .L3
            cmpi.w  #3,D7
            seq     D0
            cmpi.w  #4,D6
            seq     D1
            and.b   D1,D0
            cmpi.w  #1,D7
            seq     D1
            cmpi.w  #2,D6
            seq     D2
            and.b   D2,D1
            or.b    D1,D0
            beq.b   .L9
.L3:
            addq.w  #1,D6
.L4:
            cmpi.w  #$1F,D6
            ble.b   .L2
.L5:
            addq.w  #1,D7
.L6:
            cmpi.w  #$1E,D7
            ble.b   .L1
            pea     ($40,A4)
            move.l  A6,-(SP)
            jsr     CheckExp
            pea     ($56,A4)
            move.l  A6,-(SP)
            jsr     CheckExp
            lea     (2,A4),A0
            move.w  #$1F,D7
.L7:
            subq.w  #1,D7
            blt.b   .L8
            move.w  (A0)+,D0
            beq.b   .L7
            cmpi.b  #$20,D0
            bcc.b   .L7
            bra.b   .L9
.L8:
            cmpi.w  #9,($82,A4)
            beq.b   .L10
.L9:
            sf      ($C,A6)
.L10:
            movem.l (SP)+,D5-D7/A4
            unlk    A6
            move.l  (SP)+,(SP)
            rts
            ds.b    4
IsSubstring:
            link.w  A6,#-6
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A3
            movea.l (8,A3),A4
            moveq   #1,D7
            move.w  (-8,A4),(-6,A6)
            sf      ($C,A6)
            movea.l ($10,A3),A0
            bra.b   .L2
.L1:
            movea.l ($14,A4),A0
            clr.w   D0
            move.b  (A0),D0
            cmp.w   (-6,A6),D0
            blt.b   .L3
            clr.w   -(SP)
            pea     (-6,A6)
            move.l  A4,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1EC,A0),A0
            jsr     (A0)
            move.w  (SP)+,(-4,A4)
            movea.l ($10,A3),A0
            move.w  D7,D0
            add.w   D0,D0
            move.w  (-4,A4),D1
            cmp.w   (2,A0,D0.w),D1
            bne.b   .L3
            addq.w  #1,D7
            movea.l ($10,A3),A0
.L2:
            cmp.w   (A0),D7
            ble.b   .L1
            move.w  (-6,A6),(-8,A4)
            st      ($C,A6)
.L3:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            move.l  (SP)+,(SP)
            rts
            ds.b    10
MakeExp:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A4),A3
            sf      ($14,A6)
            clr.w   -(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1F0,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            beq.b   .L4
            move.w  (-$10,A4),D0
            andi.l  #$600,D0
            beq.b   .L1
            move.w  #7,($18,A4)
            bra.b   .L3
.L1:
            btst    #4,(-$10,A4)
            bne.b   .L2
            move.b  (-1,A4),D0
            ext.w   D0
            add.w   D0,D0
            move.w  (-6,A4),(2,A3,D0.w)
.L2:
            move.w  ($E,A6),D0
            move.w  D0,D1
            asr.w   #3,D0
            bset    D1,(-$10,A4,D0.w)
            move.w  (-6,A4),D0
            move.b  ($D,A6),($2C,A3,D0.w)
            addq.w  #1,(-6,A4)
.L3:
            st      ($14,A6)
.L4:
            movem.l (SP)+,A3-A4
            move.w  #$C,D0
            bra.w   STDUNLINK
            ds.b    6
ProcessLead:
            movea.l ($C,A6),A0
            move.w  (-6,A6),D1
            move.b  D0,($2C,A0,D1.w)
            addq.w  #1,(-6,A6)
            move.w  (-$10,A6),D0
            andi.l  #$600,D0
            bne.b   .L2
            move.b  (-1,A6),D0
            ext.w   D0
            add.w   D0,D0
            btst    #4,(-$10,A6)
            beq.b   .L1
            addq.w  #1,($14,A0,D0.w)
            bra.b   .L2
.L1:
            addq.w  #1,($E,A0,D0.w)
.L2:
            rts
            ds.b    8
getc:
            clr.w   -(SP)
            pea     (-8,A6)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1EC,A0),A0
            jsr     (A0)
            move.w  (SP)+,(-4,A6)
            rts
            ds.b    8
xStr2Form:
            link.w  A6,#-$10
            movem.l D3-D7/A3-A4,-(SP)
            clr.w   ($18,A6)
            moveq   #0,D6
            clr.w   -(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1E8,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            bne.b   .L1
            move.w  #$A,($18,A6)
            bra.w   .L50
.L1:
            movea.l ($C,A6),A4
            movea.l ($10,A6),A3
            moveq   #4,D3
.L2:
            clr.w   ($1A,A4,D3.w)
            clr.w   (2,A4,D3.w)
            move.w  #1,(8,A4,D3.w)
            clr.w   ($E,A4,D3.w)
            clr.w   ($14,A4,D3.w)
            subq.b  #2,D3
            bpl.b   .L2
            clr.b   (-1,A6)
            cmpi.w  #$23,($A,A3)
            sne     D4
            beq.b   .L3
            move.w  #$2100,(-$10,A6)
            bra.b   .L4
.L3:
            move.w  #$100,(-$10,A6)
.L4:
            moveq   #1,D0
            move.w  D0,(-8,A6)
            move.w  D0,(-6,A6)
            move.b  #$D3,($2C,A4)
            movea.l ($14,A6),A0
            move.b  (A0),D0
            beq.w   .L42
            st      D5
.L5:
            move.b  D5,D0
            beq.w   .L43
            clr.w   D0
            move.b  ($2C,A4),D0
            cmp.w   (-6,A6),D0
            bge.b   .L6
            move.w  #8,($18,A6)
            bra.w   .L50
.L6:
            jsr     getc
            clr.w   D7
.L7:
            addq.w  #1,D7
            cmpi.w  #$E,D7
            bgt.b   .L8
            move.w  D7,D1
            add.w   D1,D1
            move.w  (-4,A6),D2
            cmp.w   (0,A3,D1.w),D2
            bne.b   .L7
.L8:
            move.w  D7,D0
            subq.w  #1,D0
            bmi.w   .L40
            cmpi.w  #$E,D0
            bgt.w   .L40
            add.w   D0,D0
            move.w  .L10(PC,D0.w),D0
.L9:
            jmp     .L9+2(PC,D0.w)
.L10:
            dc.w    .L11-(.L9+2)
            dc.w    .L14-(.L9+2)
            dc.w    .L16-(.L9+2)
            dc.w    .L32-(.L9+2)
            dc.w    .L15-(.L9+2)
            dc.w    .L15-(.L9+2)
            dc.w    .L20-(.L9+2)
            dc.w    .L31-(.L9+2)
            dc.w    .L31-(.L9+2)
            dc.w    .L31-(.L9+2)
            dc.w    .L32-(.L9+2)
            dc.w    .L23-(.L9+2)
            dc.w    .L32-(.L9+2)
            dc.w    .L17-(.L9+2)
            dc.w    .L33-(.L9+2)
.L11:
            jsr     getc
            move.w  (-4,A6),D0
            cmp.w   ($1A,A3),D0
            bne.b   .L12
            jsr     getc
            clr.w   -(SP)
            move.w  (-4,A6),-(SP)
            pea     ($2C,A4)
            pea     (-6,A6)
            jsr     SendChar
            or.w    (SP)+,D6
            bra.b   .L11
.L12:
            move.w  (-4,A6),D0
            beq.b   .L13
            cmp.w   (4,A3),D0
            beq.w   .L40
            clr.w   -(SP)
            move.w  (-4,A6),-(SP)
            pea     ($2C,A4)
            pea     (-6,A6)
            jsr     SendChar
            or.w    (SP)+,D6
            bra.b   .L11
.L13:
            move.w  #6,($18,A6)
            bra.w   .L40
.L14:
            move.w  #4,($18,A6)
            bra.w   .L40
.L15:
            move.w  D7,D0
            jsr     ProcessLead
            bra.w   .L40
.L16:
            move.w  #4,D0
            jsr     ProcessLead
            bra.w   .L40
.L17:
            btst    #4,(-$10,A6)
            beq.b   .L18
            move.w  #5,($18,A6)
            bra.b   .L19
.L18:
            move.w  (-6,A6),D0
            move.b  #$E,($2C,A4,D0.w)
            move.b  (-1,A6),D0
            ext.w   D0
            add.w   D0,D0
            move.w  (-6,A6),(2,A4,D0.w)
            addq.w  #1,(-6,A6)
            bset    #4,(-$10,A6)
.L19:
            bra.w   .L40
.L20:
            btst    #3,(-$10,A6)
            beq.b   .L21
            move.w  #$B,($18,A6)
            bra.b   .L22
.L21:
            bset    #3,(-$10,A6)
            move.w  (-6,A6),D0
            move.b  D7,($2C,A4,D0.w)
            addq.w  #1,(-6,A6)
.L22:
            bra.w   .L40
.L23:
            cmpi.b  #2,(-1,A6)
            bne.b   .L24
            move.w  #$C,($18,A6)
            bra.b   .L30
.L24:
            move.b  (-1,A6),D1
            ext.w   D1
            add.w   D1,D1
            move.w  (-$10,A6),D0
            andi.l  #$1600,D0
            bne.b   .L25
            move.w  (-6,A6),(2,A4,D1.w)
.L25:
            move.w  ($E,A4,D1.w),D0
            add.w   ($14,A4,D1.w),D0
            bne.b   .L27
            move.w  (-6,A6),D0
            cmp.w   (8,A4,D1.w),D0
            ble.b   .L26
            move.w  (-$10,A6),D0
            andi.w  #$1E00,D0
            beq.b   .L27
.L26:
            clr.w   ($1A,A4,D1.w)
            move.w  #$D,D6
            bra.w   .L46
.L27:
            move.w  (-$10,A6),($1A,A4,D1.w)
            addq.b  #1,(-1,A6)
            move.b  D4,D0
            beq.b   .L28
            move.w  #$2100,(-$10,A6)
            bra.b   .L29
.L28:
            move.w  #$100,(-$10,A6)
.L29:
            move.b  (-1,A6),D0
            ext.w   D0
            add.w   D0,D0
            move.w  (-6,A6),(8,A4,D0.w)
.L30:
            bra.w   .L40
.L31:
            move.w  (-6,A6),D0
            move.b  D7,($2C,A4,D0.w)
            addq.w  #1,(-6,A6)
            bra.w   .L40
.L32:
            move.w  #3,($18,A6)
            bra.w   .L40
.L33:
            clr.w   -(SP)
            move.w  (-4,A6),-(SP)
            move.w  ($42,A3),-(SP)
            jsr     CharComp
            tst.b   (SP)+
            beq.b   .L35
            clr.w   -(SP)
            pea     ($40,A3)
            move.w  #1,-(SP)
            move.w  #$F,-(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1E4,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            bne.b   .L34
            clr.w   -(SP)
            pea     ($56,A3)
            move.w  #2,-(SP)
            move.w  #$10,-(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1E4,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            bne.b   .L34
            move.w  #3,($18,A6)
.L34:
            bra.b   .L40
.L35:
            clr.w   -(SP)
            move.w  (-4,A6),-(SP)
            move.w  ($58,A3),-(SP)
            jsr     CharComp
            tst.b   (SP)+
            beq.b   .L37
            clr.w   -(SP)
            pea     ($56,A3)
            move.w  #2,-(SP)
            moveq   #$10,D0
            move.w  D0,-(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1E4,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            bne.b   .L36
            move.w  #3,($18,A6)
.L36:
            bra.b   .L40
.L37:
            lea     ($3C,A3),A1
            move.w  (-4,A6),D1
            beq.b   .L39
            moveq   #$F,D2
.L38:
            cmp.w   -(A1),D1
            dbeq    D2,.L38
            bne.b   .L39
            clr.w   -(SP)
            move.w  (-4,A6),-(SP)
            pea     ($2C,A4)
            pea     (-6,A6)
            jsr     SendChar
            or.w    (SP)+,D6
            bra.b   .L40
.L39:
            move.w  #3,($18,A6)
.L40:
            movea.l ($14,A6),A0
            clr.w   D0
            move.b  (A0),D0
            cmp.w   (-8,A6),D0
            bge.b   .L41
            sf      D5
.L41:
            bra.w   .L5
.L42:
            move.w  #$D,D6
            bclr    #0,(-$10,A6)
.L43:
            move.b  (-1,A6),D1
            ext.w   D1
            add.w   D1,D1
            move.w  ($E,A4,D1.w),D0
            add.w   ($14,A4,D1.w),D0
            bne.b   .L45
            move.w  (-6,A6),D0
            cmp.w   (8,A4,D1.w),D0
            ble.b   .L44
            move.w  (-$10,A6),D0
            andi.w  #$1E00,D0
            beq.b   .L45
.L44:
            clr.w   (-$10,A6)
            move.w  #$D,D6
.L45:
            move.w  (-$10,A6),($1A,A4,D1.w)
            moveq   #0,D0
            move.w  (-$10,A6),D0
            andi.l  #$1600,D0
            bne.b   .L46
            move.w  (-6,A6),(2,A4,D1.w)
.L46:
            cmpi.b  #0,(-1,A6)
            bne.b   .L48
            move.w  (-6,A6),($A,A4)
.L47:
            move.w  (-6,A6),($C,A4)
            bra.b   .L49
.L48:
            cmpi.b  #1,(-1,A6)
            beq.b   .L47
.L49:
            move.w  (-6,A6),(8,A4)
            move.w  (-6,A6),D0
            subq.w  #1,D0
            move.b  D0,($2C,A4)
            addi.b  #$2C,D0
            move.b  D0,(A4)
            tst.w   D6
            beq.b   .L50
            move.w  D6,($18,A6)
.L50:
            clr.b   (1,A4)
            movem.l (SP)+,D3-D7/A3-A4
            move.w  #$10,D0
            bra.w   STDUNLINK
            ds.b    12
TackOnExp:
            link.w  A6,#-4
            movem.l D7/A2-A4,-(SP)
            movea.l (8,A6),A3
            movea.l (8,A3),A4
            movea.l ($C,A6),A2
            move.w  (A2),(-4,A6)
            lea     (2,A2),A2
            clr.w   D7
            bra.b   .L2
.L1:
            clr.w   -(SP)
            move.w  (A2)+,-(SP)
            pea     (-$32,A3)
            pea     (-$34,A3)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
            addq.w  #1,D7
.L2:
            cmp.w   (-4,A6),D7
            ble.b   .L1
            movem.l (SP)+,D7/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
            ds.b    8
TranslateToText:
            link.w  A6,#-$36
            movem.l D7/A3-A4,-(SP)
            move.w  ($C,A6),D7
            movea.l (8,A6),A4
            movea.l ($14,A4),A3
            move.w  #1,(-$34,A6)
            move.b  #$31,(-$32,A6)
            cmpi.w  #$20,D7
            bge.w   .L8
            tst.b   (-$D,A4)
            beq.b   .L1
            sf      (-$D,A4)
            clr.w   -(SP)
            move.w  (2,A3),-(SP)
            pea     (-$32,A6)
            pea     (-$34,A6)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
.L1:
            move.l  #$47F0,D0
            btst    D7,D0
            bne.b   .L2
            cmpi.w  #$F,D7
            beq.b   .L5
            cmpi.w  #$10,D7
            beq.b   .L6
            bra.b   .L4
.L2:
            clr.w   -(SP)
            move.w  #6,D0
            cmpi.w  #4,D7
            beq.b   .L3
            move.w  D7,D0
            add.w   D0,D0
.L3:
            move.w  (0,A3,D0.w),-(SP)
            pea     (-$32,A6)
            pea     (-$34,A6)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
            bra.b   .L12
.L4:
            move.l  #$33F3F3F,(-$32,A6)
            move.w  #4,(-$34,A6)
            bra.b   .L12
.L5:
            pea     ($40,A3)
            bra.b   .L7
.L6:
            pea     ($56,A3)
.L7:
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1E0,A0),A0
            jsr     (A0)
            bra.b   .L12
.L8:
            tst.b   (-$D,A4)
            bne.b   .L9
            clr.w   -(SP)
            move.w  (2,A3),-(SP)
            pea     (-$32,A6)
            pea     (-$34,A6)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
            st      (-$D,A4)
.L9:
            move.w  ($1A,A3),D0
            cmp.w   D0,D7
            beq.b   .L10
            cmp.w   (4,A3),D7
            bne.b   .L11
.L10:
            clr.w   -(SP)
            move.w  D0,-(SP)
            pea     (-$32,A6)
            pea     (-$34,A6)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
.L11:
            clr.w   -(SP)
            move.w  D7,-(SP)
            pea     (-$32,A6)
            pea     (-$34,A6)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
.L12:
            move.w  (-$34,A6),D0
            subq.w  #1,D0
            move.b  D0,(-$32,A6)
            clr.w   D0
            move.b  (-$32,A6),D0
            move.w  D0,(-$36,A6)
            move.w  #1,(-$34,A6)
            bra.b   .L14
.L13:
            movea.l ($10,A4),A0
            move.w  (-4,A4),D0
            move.w  (-$34,A6),D1
            clr.w   D2
            lea     (-$32,A6),A1
            move.b  (0,A1,D1.w),(0,A0,D0.w)
            addq.w  #1,(-4,A4)
            addq.w  #1,(-$34,A6)
.L14:
            move.w  (-$34,A6),D0
            cmp.w   (-$36,A6),D0
            ble.b   .L13
            movem.l (SP)+,D7/A3-A4
            move.w  #6,D0
            bra.w   STDUNLINK
            ds.b    10
CheckForm:
            link.w  A6,#-6
            movem.l D3-D7/A2-A4,-(SP)
            move.b  ($C,A6),D7
            movea.l (8,A6),A4
            movea.l ($18,A4),A3
            movea.l ($14,A4),A0
            move.l  A0,(-4,A6)
            clr.w   D5
            move.b  D7,D3
            ext.w   D3
            add.w   D3,D3
            move.b  D7,D0
            jsr     NextFormatClass
            add.w   D0,D0
            move.w  (8,A3,D0.w),D2
            subq.w  #1,D2
            move.w  D2,(-6,A6)
            moveq   #1,D6
            tst.w   D7
            beq.b   .L1
            move.w  (8,A3,D3.w),D6
            cmp.w   D6,D2
            blt.b   .L6
            move.w  #$18,D0
            bsr.b   sub_40820A60
            movea.l ($C,A4),A0
            move.b  D7,D0
            ext.w   D0
            asl.w   #2,D0
            move.w  (-4,A4),(0,A0,D0.w)
.L1:
            bra.b   .L4
.L2:
            clr.w   D1
            lea     ($2C,A3,D6.w),A0
            move.b  (A0)+,D5
            clr.w   -(SP)
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            beq.b   .L3
            asl.w   #8,D5
            move.b  (A0),D5
            addq.w  #1,D6
.L3:
            move.w  D5,-(SP)
            move.l  (8,A6),-(SP)
            jsr     TranslateToText
            addq.w  #1,D6
.L4:
            cmp.w   (-6,A6),D6
            ble.b   .L2
            tst.b   (-$D,A4)
            beq.b   .L5
            sf      (-$D,A4)
            move.w  #4,D0
            bsr.b   sub_40820A60
.L5:
            movea.l ($C,A4),A0
            move.b  D7,D0
            ext.w   D0
            asl.w   #2,D0
            move.w  (-4,A4),D1
            sub.w   (0,A0,D0.w),D1
            move.w  D1,(2,A0,D0.w)
.L6:
            movem.l (SP)+,D3-D7/A2-A4
            move.w  #6,D0
            bra.w   STDUNLINK
sub_40820A60:
            clr.w   -(SP)
            movea.l (-4,A6),A0
            move.w  (0,A0,D0.w),-(SP)
            move.l  ($10,A4),-(SP)
            pea     (-4,A4)
            jsr     SendChar
            move.w  (SP)+,(-2,A4)
            rts
            ds.b    4
xForm2Str:
            link.w  A6,#-$E
            movem.l D6-D7/A3-A4,-(SP)
            clr.w   ($1C,A6)
            clr.w   (-2,A6)
            movea.l ($10,A6),A0
            move.b  #$FF,(A0)
            movea.l ($C,A6),A0
            moveq   #8,D7
.L1:
            clr.w   (0,A0,D7.w)
            clr.w   (2,A0,D7.w)
            subq.b  #4,D7
            bpl.b   .L1
            movea.l ($18,A6),A4
            tst.b   ($2C,A4)
            beq.b   .L2
            movea.l ($14,A6),A0
            move.l  A0,(-$A,A6)
            move.w  #1,(-4,A6)
            movea.l ($C,A6),A0
            move.w  #1,(A0)
            sf      (-$D,A6)
            clr.b   -(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A3
            movea.l ($1DC,A3),A3
            jsr     (A3)
            sf      (-$D,A6)
            move.b  #1,-(SP)
            move.l  A6,-(SP)
            jsr     (A3)
            sf      (-$D,A6)
            move.b  #2,-(SP)
            move.l  A6,-(SP)
            jsr     (A3)
            movea.l ($10,A6),A0
            move.w  (-4,A6),D0
            subq.w  #1,D0
            move.b  D0,(A0)
            bra.b   .L3
.L2:
            move.w  #$D,(-2,A6)
            movea.l ($10,A6),A0
            clr.b   (A0)
.L3:
            tst.w   (-2,A6)
            beq.b   .L4
            move.w  (-2,A6),($1C,A6)
.L4:
            movem.l (SP)+,D6-D7/A3-A4
            move.w  #$14,D0
            bra.w   STDUNLINK
            ds.b    10
MatchingSubstring:
            link.w  A6,#0
            movem.l D3/A3-A4,-(SP)
            movea.l ($E,A6),A3
            movea.l (8,A6),A4
            move.w  (A3),D2
            movea.l ($18,A4),A0
            adda.w  D2,A0
            sf      ($14,A6)
            move.w  ($12,A6),D0
            beq.b   .L5
            cmpi.w  #$FF,D0
            bls.b   .L1
            cmp.w   (-$E,A4),D2
            bge.b   .L5
            moveq   #2,D3
            move.b  (A0)+,D1
            lsl.w   #8,D1
            move.b  (A0),D1
            bra.b   .L2
.L1:
            cmp.w   (-$E,A4),D2
            bgt.b   .L5
            clr.w   D1
            move.b  (A0),D1
            moveq   #1,D3
.L2:
            tst.w   ($C,A6)
            beq.b   .L3
            clr.w   -(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            jsr     CharComp
            not.b   (SP)+
            bra.b   .L4
.L3:
            cmp.w   D0,D1
.L4:
            bne.b   .L5
            add.w   D3,(A3)
            st      ($14,A6)
.L5:
            movem.l (SP)+,D3/A3-A4
            move.w  #$C,D0
            bra.w   STDUNLINK
            dc.w    0
matchingBlocks:
            link.w  A6,#-6
            movem.l D7/A2-A4,-(SP)
            movea.l (8,A6),A3
            movea.l ($C,A6),A4
            move.w  (-$12,A3),(-2,A6)
            sf      ($10,A6)
            move.w  (A4),D7
            blt.b   .L2
            lea     (2,A4),A4
            movea.l IntlSpec,A2
            movea.l ($1D4,A2),A2
.L1:
            clr.w   -(SP)
            move.w  (A4)+,-(SP)
            pea     (-2,A6)
            move.w  #1,-(SP)
            move.l  A3,-(SP)
            jsr     (A2)
            move.b  (SP)+,D0
            dbeq    D7,.L1
            beq.b   .L2
            st      ($10,A6)
            move.w  (-2,A6),(-$12,A3)
.L2:
            movem.l (SP)+,D7/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
            ds.b    8
CheckForDigits:
            link.w  A6,#-$E
            movem.l D5-D7/A2-A4,-(SP)
            movea.l (8,A6),A4
            sf      D5
            movea.l ($14,A4),A1
            movea.l ($10,A4),A3
            lea     (-$114,A4),A2
            adda.w  (-$10,A4),A2
            movea.l ($18,A4),A0
            move.w  (-$12,A4),D0
            move.b  (0,A0,D0.w),D1
            cmpi.b  #$30,D1
            blt.b   .L2
            cmpi.b  #$39,D1
            bgt.b   .L2
            move.b  D1,(A2)
            addq.w  #1,(-$10,A4)
            addq.w  #1,(-$12,A4)
            st      D5
            cmpi.b  #$30,D1
            beq.b   .L1
            move.b  #$7F,D5
.L1:
            bra.b   .L4
.L2:
            move.b  (-8,A4),D0
            ext.w   D0
            add.w   D0,D0
            btst    #5,($1A,A1,D0.w)
            beq.b   .L4
            sf      D6
            move.w  #9,D7
            lea     ($84,A3),A3
            movea.l IntlSpec,A1
            movea.l ($1D4,A1),A1
.L3:
            clr.w   -(SP)
            move.w  (A3)+,-(SP)
            pea     (-$12,A4)
            clr.w   -(SP)
            move.l  A4,-(SP)
            jsr     (A1)
            move.b  (SP)+,D6
            dbne    D7,.L3
            beq.b   .L4
            moveq   #$39,D0
            sub.b   D7,D0
            move.b  D0,(A2)
            addq.w  #1,(-$10,A4)
            st      D5
            cmpi.b  #$30,D0
            beq.b   .L4
            move.b  #$7F,D5
.L4:
            move.b  D5,($C,A6)
            movem.l (SP)+,D5-D7/A2-A4
            unlk    A6
            move.l  (SP)+,(SP)
            rts
            ds.b    6
Cond:
            link.w  A6,#0
            movem.l D3-D5/A2-A4,-(SP)
            movea.l (8,A6),A4
            movea.l (8,A4),A3
            sf      ($10,A4)
            lea     (-$114,A3),A2
            adda.w  (-$10,A3),A2
            move.b  ($F,A6),D3
            move.l  ($14,A6),D4
            moveq   #1,D5
.L1:
            clr.w   -(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            jsr     matchingBlocks
            move.b  (SP)+,D0
            bne.b   .L2
            tst.l   D5
            beq.w   .L3
            move.b  ($D,A6),D3
            move.l  ($10,A6),D4
            moveq   #0,D5
            bra.b   .L1
.L2:
            move.b  #$45,(A2)+
            move.b  D3,(A2)
            addq.w  #2,(-$10,A3)
            st      ($10,A4)
.L3:
            movem.l (SP)+,D3-D5/A2-A4
            move.w  #$10,D0
            bra.w   STDUNLINK
ExpMatching:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A3
            movea.l ($10,A3),A4
            lea     ($56,A4),A1
            movea.l IntlSpec,A4
            movea.l ($1D8,A4),A4
            movea.l ($C,A6),A0
            move.w  (A0),D0
            cmp.w   (A1),D0
            blt.b   .L1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            move.l  #$2D002B,-(SP)
            move.l  A6,-(SP)
            jsr     (A4)
            bra.b   .L2
.L1:
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            move.l  #$2B002D,-(SP)
            move.l  A6,-(SP)
            jsr     (A4)
.L2:
            movem.l (SP)+,A3-A4
            move.w  #8,D0
            bra.w   STDUNLINK
xFormStr2X:
            link.w  A6,#-$144
            movem.l D3-D7/A2-A5,-(SP)
            sf      (-6,A6)
            movea.l ($18,A6),A0
            clr.w   D0
            move.b  (A0),D0
            move.w  D0,(-$E,A6)
            move.b  #$31,(-$113,A6)
            movea.l ($14,A6),A3
            movea.l ($10,A6),A4
            lea     (-8,A6),A2
            clr.w   D0
            move.b  ($2C,A3),D0
            move.w  D0,(-$A,A6)
            sf      D5
            sf      (-3,A6)
            sf      (-2,A6)
            st      (-4,A6)
            clr.w   (A2)
            btst    #0,($1A,A3)
            beq.w   sub_40820EEC.L21
            clr.w   ($1C,A6)
            moveq   #1,D0
            move.w  D0,(-$12,A6)
            move.l  D0,D7
            move.w  D0,(-$10,A6)
            sf      (-$11B,A6)
            st      (-$143,A6)
            clr.w   D3
            move.w  ($12,A4),D0
            bsr.w   sub_40820EBC
            move.b  D0,(-5,A6)
            move.w  (-$A,A6),D0
            beq.w   sub_40820EEC.L33
            cmp.w   D0,D7
            sle     D5
            move.w  (-$12,A6),D1
            cmp.w   (-$E,A6),D1
            sle     D1
            and.b   D1,D5
.L1:
            move.b  D5,D0
            beq.w   sub_40820EEC.L20
            clr.w   D4
            move.b  ($2C,A3,D7.w),D4
            cmpi.w  #$20,D4
            bge.w   sub_40820EEC.L2
            move.w  D4,D0
            subq.w  #4,D0
            bmi.w   .L13
            cmpi.w  #$C,D0
            bgt.w   .L13
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
            dc.w    .L6-(.L2+2)
            dc.w    .L4-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L13-(.L2+2)
            dc.w    .L13-(.L2+2)
            dc.w    .L13-(.L2+2)
            dc.w    .L8-(.L2+2)
            dc.w    .L10-(.L2+2)
            dc.w    .L11-(.L2+2)
.L4:
            bsr.w   sub_40820ED6
            bne.b   .L5
            move.w  D4,D0
            add.w   D0,D0
            move.w  (0,A4,D0.w),D0
            bsr.b   sub_40820EBC
            beq.w   sub_40820EEC.L1
.L5:
            bra.w   sub_40820EEC.L3
.L6:
            tst.w   D3
            bne.b   .L7
            move.w  D7,D3
            move.w  (-$10,A6),(-$118,A6)
            move.w  (-$12,A6),(-$116,A6)
.L7:
            bsr.b   sub_40820ED6
            beq.w   sub_40820EEC.L1
            bra.w   sub_40820EEC.L3
.L8:
            st      (-$11B,A6)
            clr.w   D3
            move.w  ($1C,A4),D0
            bsr.b   sub_40820EBC
            beq.w   sub_40820EEC.L1
            move.w  (-$10,A6),D0
            lea     (-$114,A6),A0
            move.b  #$2E,(0,A0,D0.w)
            addq.w  #1,(-$10,A6)
            bra.b   .L13
.L9:
            move.w  D4,D0
            add.w   D0,D0
            move.w  (0,A4,D0.w),D0
            bsr.b   sub_40820EBC
            beq.b   sub_40820EEC.L1
            bra.w   sub_40820EEC.L3
.L10:
            lea     ($40,A4),A0
            bsr.b   sub_40820EEC
            beq.b   sub_40820EEC.L1
            bra.b   .L12
.L11:
            lea     ($6C,A4),A0
            jsr     sub_40820EEC
            beq.b   sub_40820EEC.L1
.L12:
            moveq   #0,D3
            clr.b   (-$11B,A6)
            st      (-$143,A6)
.L13:
            bra.b   sub_40820EEC.L3
sub_40820EBC:
            clr.w   -(SP)
            move.w  D0,-(SP)
            pea     (-$12,A6)
            clr.w   -(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1D4,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            rts
sub_40820ED6:
            clr.w   -(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1D0,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            and.b   (-$143,A6),D0
            rts
sub_40820EEC:
            clr.w   -(SP)
            move.l  A0,-(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1CC,A0),A0
            jsr     (A0)
            move.b  (SP)+,D0
            rts
.L1:
            move.b  (A2),D0
            ext.w   D0
            clr.b   (-4,A6,D0.w)
            bra.b   .L3
.L2:
            clr.w   -(SP)
            move.w  D4,-(SP)
            movea.l ($18,A6),A0
            adda.w  (-$12,A6),A0
            move.b  (A0),D0
            move.w  D0,-(SP)
            jsr     CharComp
            tst.b   (SP)+
            beq.b   .L1
            addq.w  #1,(-$12,A6)
.L3:
            move.b  (A2),D0
            jsr     NextFormatClass
            add.w   D0,D0
            move.w  (8,A3,D0.w),D6
            move.b  (A2),D1
            ext.w   D1
            move.w  (-$12,A6),D0
            cmp.w   (-$E,A6),D0
            ble.b   .L4
            move.w  D6,D0
            subq.w  #1,D0
            cmp.w   D7,D0
            ble.b   .L4
            sf      (-4,A6,D1.w)
.L4:
            tst.b   (-4,A6,D1.w)
            bne.w   .L12
            tst.b   (-$11B,A6)
            bne.b   .L5
            tst.w   D3
            bne.b   .L10
            bra.w   .L12
.L5:
            move.w  D6,D3
            clr.b   (-$11C,A6)
.L6:
            cmp.w   D6,D7
            bge.b   .L11
            move.w  D7,D1
            addq.w  #1,D1
            cmpi.b  #5,($2C,A3,D7.w)
            bne.b   .L7
            move.b  (A2),D0
            ext.w   D0
            st      (-4,A6,D0.w)
            tst.b   (-$11C,A6)
            bne.b   .L9
            move.w  D1,D3
            bra.b   .L9
.L7:
            cmpi.b  #$F,($2C,A3,D7.w)
            beq.b   .L8
            cmpi.b  #$10,($2C,A3,D7.w)
            bne.b   .L9
.L8:
            st      (-$11C,A6)
            st      (-$143,A6)
.L9:
            move.w  D1,D7
            bra.b   .L6
.L10:
            addq.w  #1,D3
            cmp.w   D6,D3
            bge.b   .L11
            move.b  ($2C,A3,D3.w),D0
            cmpi.b  #$1F,D0
            bgt.b   .L10
            move.l  #$1C370,D1
            btst    D0,D1
            beq.b   .L10
.L11:
            cmp.w   D3,D6
            ble.b   .L13
            move.w  D3,D7
            move.b  (A2),D0
            ext.w   D0
            st      (-4,A6,D0.w)
            tst.b   (-$11B,A6)
            bne.b   .L13
            clr.w   D3
            move.w  (-$116,A6),(-$12,A6)
            move.w  (-$118,A6),(-$10,A6)
            bra.b   .L13
.L12:
            addq.w  #1,D7
.L13:
            move.b  (A2),D0
            ext.w   D0
            cmp.w   D7,D6
            bgt.b   .L14
            move.w  (-$12,A6),D1
            cmp.w   (-$E,A6),D1
            bgt.b   .L14
            sf      (-4,A6,D0.w)
.L14:
            move.b  (-4,A6,D0.w),D1
            bne.b   .L19
            cmpi.b  #2,(A2)
            bne.b   .L15
            sf      D5
            bra.b   .L19
.L15:
            clr.b   (-5,A6)
            move.b  (A2),D0
            ext.w   D0
            addq.w  #1,D0
            move.b  D0,(A2)
            move.w  D0,D1
            add.w   D0,D0
            btst    #0,($1A,A3,D0.w)
            beq.b   .L18
            moveq   #1,D2
            cmpi.w  #2,D1
            bne.b   .L16
            move.b  #$80,(-$143,A6)
            bra.b   .L17
.L16:
            st      (-$143,A6)
.L17:
            move.b  #$31,(-$113,A6)
            sf      (-$11B,A6)
            clr.w   D3
            move.b  D2,(-4,A6,D1.w)
            move.w  D2,(-$12,A6)
            move.w  (8,A3,D0.w),D7
            move.w  D2,(-$10,A6)
            bra.b   .L19
.L18:
            clr.b   D5
.L19:
            cmp.w   (-$A,A6),D7
            sle     D0
            move.w  (-$12,A6),D1
            cmp.w   (-$E,A6),D1
            sle     D1
            and.b   D1,D0
            and.b   D0,D5
            bra.w   xFormStr2X.L1
.L20:
            move.b  (A2),D0
            ext.w   D0
            move.b  (-4,A6,D0.w),D1
            beq.b   .L21
            add.w   D0,D0
            btst    #3,($1A,A3,D0.w)
            sne     D0
            move.b  D0,(-6,A6)
            bra.w   .L37
.L21:
            move.w  #1,($1C,A6)
            sf      (-6,A6)
            sf      (-5,A6)
            sf      (-$11B,A6)
            st      (-$143,A6)
            clr.w   (A2)
            move.w  #1,(-$12,A6)
            move.w  #1,(-$10,A6)
.L22:
            move.w  (-$12,A6),D0
            cmp.w   (-$E,A6),D0
            bgt.w   .L37
            bsr.w   sub_40820ED6
            bne.w   .L32
            clr.w   D6
.L23:
            addq.w  #1,D6
            cmpi.w  #$E,D6
            bgt.b   .L24
            move.w  D6,D1
            add.w   D1,D1
            move.w  (0,A4,D1.w),D0
            bsr.w   sub_40820EBC
            beq.b   .L23
.L24:
            move.w  D6,D0
            subq.w  #7,D0
            beq.b   .L27
            subq.w  #2,D0
            beq.b   .L26
            subq.w  #5,D0
            beq.b   .L25
            subq.w  #1,D0
            beq.b   .L28
            bra.w   .L32
.L25:
            tst.b   (-$11B,A6)
            bne.w   .L35
            st      (-$11B,A6)
            move.w  (-$10,A6),D0
            lea     (-$114,A6),A0
            move.b  #$2E,(0,A0,D0.w)
            addq.w  #1,(-$10,A6)
            bra.w   .L32
.L26:
            tst.b   (-5,A6)
            bne.w   .L36
            st      (-5,A6)
            bra.b   .L32
.L27:
            tst.b   (-6,A6)
            bne.b   .L34
            st      (-6,A6)
            bra.b   .L32
.L28:
            lea     ($40,A4),A0
            bsr.w   sub_40820EEC
            bne.b   .L32
            lea     ($6C,A4),A0
            jsr     sub_40820EEC
            bne.b   .L32
            clr.w   -(SP)
            move.l  ($18,A6),-(SP)
            move.w  (-$12,A6),-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            movea.l ($18,A6),A0
            move.w  (-$12,A6),D0
            adda.w  D0,A0
            move.b  (A0)+,D0
            tst.w   (SP)+
            beq.b   .L29
            lsl.w   #8,D0
            move.b  (A0)+,D0
.L29:
            lea     ($3C,A4),A0
            moveq   #$F,D1
.L30:
            cmp.w   -(A0),D0
            dbeq    D1,.L30
            bne.b   .L36
.L31:
            addq.w  #1,(-$12,A6)
            clr.w   -(SP)
            move.l  ($18,A6),D0
            addq.w  #1,D0
            move.l  D0,-(SP)
            move.w  (-$12,A6),D0
            subq.w  #1,D0
            move.w  D0,-(SP)
            move.l  #$82060010,-(SP)
            _ScriptUtil
            tst.w   (SP)+
            bgt.b   .L31
.L32:
            bra.w   .L22
.L33:
            move.w  #$D,($1C,A6)
            bra.b   .L37
.L34:
            move.w  #$B,($1C,A6)
            bra.b   .L37
.L35:
            move.w  #5,($1C,A6)
            bra.b   .L37
.L36:
            move.w  #3,($1C,A6)
.L37:
            move.w  (-$10,A6),D0
            subq.w  #1,D0
            bne.b   .L38
            moveq   #1,D0
            tst.w   (-$E,A6)
            beq.b   .L39
            move.b  (A2),D1
            ext.w   D1
            tst.b   (-4,A6,D1.w)
            beq.b   .L39
.L38:
            move.b  D0,(-$114,A6)
            cmpi.b  #2,(A2)
            bne.b   .L40
            movea.l ($C,A6),A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.w   (A0)
            bra.w   .L46
.L39:
            pea     .L48
            bra.b   .L41
.L40:
            pea     (-$114,A6)
.L41:
            move.w  #1,(-$120,A6)
            pea     (-$120,A6)
            pea     (-$13C,A6)
            pea     (-$122,A6)
            move.w  #2,-(SP)
            _DECSTR68K
            pea     (-$13C,A6)
            move.l  ($C,A6),-(SP)
            move.w  #9,-(SP)
            _FP68K
            movea.l ($C,A6),A1
            bsr.w   GetSANEClass
            cmpi.w  #2,D0
            beq.b   .L44
            cmpi.w  #$FFFE,D0
            beq.b   .L44
            cmpi.w  #1,D0
            beq.b   .L44
            cmpi.w  #$FFFF,D0
            beq.b   .L44
            cmpi.w  #3,D0
            beq.b   .L45
            cmpi.w  #$FFFD,D0
            beq.b   .L45
            move.b  (-6,A6),D0
            beq.b   .L42
            pea     .L47
            move.l  ($C,A6),-(SP)
            move.w  #6,-(SP)
            _FP68K
.L42:
            cmpi.b  #1,(A2)
            beq.b   .L43
            tst.b   (-5,A6)
            beq.b   .L46
.L43:
            movea.l ($C,A6),A0
            tst.l   (A0)
            beq.b   .L46
            eori.b  #$80,(A0)
            bra.b   .L46
.L44:
            move.w  #9,($1C,A6)
            bra.b   .L46
.L45:
            move.w  #8,($1C,A6)
.L46:
            movem.l (SP)+,D3-D7/A2-A5
            move.w  #$14,D0
            bra.w   STDUNLINK
.L47:
            dc.b    $40,$05,$C8
            ds.b    7
.L48:
            dc.b    'nan(17)'
            ds.b    15
num2dec:
            pea     (-4,A6)
            move.l  ($12,A6),-(SP)
            pea     (-$1E,A6)
            move.w  #$B,-(SP)
            _FP68K
            rts
            ds.b    12
Int2String:
            ext.l   D0
            movea.l A0,A1
            move.b  #1,(A0)+
            move.l  A0,D1
.L1:
            divu.w  #$A,D0
            swap    D0
            addi.b  #$30,D0
            move.b  D0,(A0)+
            swap    D0
            ext.l   D0
            bne.b   .L1
            sub.l   A0,D1
            neg.w   D1
            move.b  D1,(A1)
            rts
            ds.b    12
ConvertToString:
            link.w  A6,#-$22
            movem.l D4-D7/A2-A4,-(SP)
            move.w  ($C,A6),D6
            move.w  ($E,A6),D4
            movea.l (8,A6),A4
            move.b  D6,(-$72,A4)
            move.b  D4,(-$A4,A4)
            move.w  D6,(-$154,A4)
            move.b  ($10,A6),D0
            beq.w   .L11
            lea     (-$1C,A6),A2
            clr.b   (-4,A6)
            move.w  D4,D0
            add.w   D6,D0
            move.w  D0,(-2,A6)
            jsr     num2dec
            cmpi.b  #$30,(-$19,A6)
            bne.b   .L5
            move.b  #$30,D0
            lea     (-$A3,A4),A0
            move.w  D4,D7
            subq.w  #1,D7
            blt.b   .L2
.L1:
            move.b  D0,(A0)+
            dbra    D7,.L1
.L2:
            lea     (-$71,A4),A0
            move.w  D6,D7
            subq.w  #1,D7
            blt.b   .L4
.L3:
            move.b  D0,(A0)+
            dbra    D7,.L3
.L4:
            clr.w   (A2)
            clr.b   (-$C,A4)
            bra.b   .L10
.L5:
            moveq   #0,D1
            move.w  (A2),D0
            add.w   D6,D0
            bpl.b   .L6
            neg.w   D0
            st      D1
.L6:
            move.b  D1,(-$C,A4)
            move.w  D0,(A2)
            lea     (-$A3,A4),A0
            lea     (-$19,A6,D4.w),A1
            movea.l A1,A3
            move.w  D4,D7
            subq.w  #1,D7
            blt.b   .L8
.L7:
            move.b  -(A3),(A0)+
            dbra    D7,.L7
.L8:
            lea     (-$71,A4),A0
            move.w  D6,D7
            subq.w  #1,D7
            blt.b   .L10
.L9:
            move.b  (A1)+,(A0)+
            dbra    D7,.L9
.L10:
            move.w  (A2),D0
            lea     (-$40,A4),A0
            jsr     Int2String
            bra.b   .L17
.L11:
            sf      (-$C,A4)
            clr.b   (-$40,A4)
            move.b  #1,(-4,A6)
            move.w  D6,(-2,A6)
            jsr     num2dec
            lea     (-$71,A4),A0
            clr.w   D0
            lea     (-$1A,A6),A3
            move.b  (A3)+,D0
            move.w  D6,D7
            subq.w  #1,D7
            blt.b   .L15
            sub.w   D6,D0
            bge.b   .L13
.L12:
            move.b  #$30,(A0)+
            subq.w  #1,D6
            addq.w  #1,D0
            dbge    D7,.L12
            subq.w  #1,D7
.L13:
            adda.w  D0,A3
.L14:
            move.b  (A3)+,(A0)+
            dbra    D7,.L14
.L15:
            lea     (-$1A,A6),A3
            moveq   #0,D5
            move.b  (A3)+,D5
            sub.w   D6,D5
            adda.w  D5,A3
            lea     (-$A4,A4),A0
            move.b  D5,(A0)+
            subq.w  #1,D5
            blt.b   .L17
.L16:
            move.b  -(A3),(A0)+
            dbra    D5,.L16
.L17:
            move.w  (-$154,A4),D0
            subi.w  #$71,D0
            lea     (0,A4,D0.w),A0
.L18:
            cmpi.b  #$30,-(A0)
            bne.b   .L19
            cmpi.w  #1,(-$154,A4)
            beq.b   .L19
            subq.w  #1,(-$154,A4)
            bra.b   .L18
.L19:
            movem.l (SP)+,D4-D7/A2-A4
            move.w  #$E,D0
            bra.w   STDUNLINK
            dc.w    0
ExpHandling:
            link.w  A6,#-8
            movem.l D5-D7/A2-A4,-(SP)
            movea.l (8,A6),A2
            movea.l (8,A2),A4
            movea.l ($14,A2),A2
            movea.l ($10,A4),A0
            sf      (-$145,A4)
            move.b  (-$C,A4),D0
            beq.b   .L1
            lea     ($56,A0),A3
            bra.b   .L2
.L1:
            movea.l ($C,A6),A3
.L2:
            move.w  (A3),D5
            clr.w   D7
            bra.b   .L4
.L3:
            clr.w   -(SP)
            move.w  D7,D0
            add.w   D0,D0
            move.w  (2,A3,D0.w),-(SP)
            move.l  A2,-(SP)
            pea     (-$13E,A4)
            jsr     SendChar
            move.w  (SP)+,D6
            addq.w  #1,D7
.L4:
            cmp.w   D5,D7
            ble.b   .L3
            movem.l (SP)+,D5-D7/A2-A4
            move.w  #8,D0
            bra.w   STDUNLINK
            ds.b    6
AppendSymbol:
            link.w  A6,#-6
            movem.l D5-D7/A2-A4,-(SP)
            move.w  ($1C,A6),D6
            move.l  ($18,A6),D5
            movea.l (8,A6),A4
            moveq   #0,D7
            move.l  ($14,A4),(-6,A6)
            movea.l ($10,A4),A3
            cmpi.w  #$20,D6
            blt.b   .L1
            movea.l ($14,A6),A0
            move.w  (-$13E,A4),D0
            move.b  D6,(0,A0,D0.w)
            addq.w  #1,(-$13E,A4)
            addq.w  #1,(-$144,A4)
            bra.w   sub_408215B6.L4
.L1:
            move.w  D6,D0
            subq.w  #4,D0
            bmi.w   sub_408215B6.L4
            cmpi.w  #$C,D0
            bgt.w   sub_408215B6.L4
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L6-(.L2+2)
            dc.w    .L6-(.L2+2)
            dc.w    .L6-(.L2+2)
            dc.w    sub_408215B6.L4-(.L2+2)
            dc.w    sub_408215B6.L3-(.L2+2)
            dc.w    sub_408215B6.L3-(.L2+2)
            dc.w    sub_408215B6.L3-(.L2+2)
            dc.w    sub_408215B6.L4-(.L2+2)
            dc.w    sub_408215B6.L4-(.L2+2)
            dc.w    sub_408215B6.L4-(.L2+2)
            dc.w    sub_408215B6.L4-(.L2+2)
            dc.w    .L4-(.L2+2)
            dc.w    .L5-(.L2+2)
.L4:
            pea     ($40,A3)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1C8,A0),A0
            jsr     (A0)
            bra.w   sub_408215B6.L4
.L5:
            pea     ($6C,A3)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1C8,A0),A0
            jsr     (A0)
            bra.w   sub_408215B6.L4
.L6:
            movea.l D5,A0
            clr.w   D0
            move.b  (A0),D0
            cmp.w   (-$142,A4),D0
            blt.b   .L10
            lea     (-$14C,A4),A1
            btst    #5,(A1)
            beq.b   .L8
            clr.w   -(SP)
            move.w  (-$142,A4),D0
            clr.w   D1
            move.b  (0,A0,D0.w),D1
            subi.w  #$30,D1
            add.w   D1,D1
            lea     ($84,A3),A0
            move.w  (0,A0,D1.w),-(SP)
            move.l  ($14,A6),-(SP)
            pea     (-$13E,A4)
            lea     ($C,A6),A0
            move.l  (A0)+,D0
            beq.b   .L7
            move.l  D0,-(SP)
.L7:
            movea.l (A0),A0
            jsr     (A0)
            move.w  (SP)+,D7
            bra.b   .L9
.L8:
            movea.l ($14,A6),A0
            move.w  (-$13E,A4),D0
            movea.l D5,A1
            move.w  (-$142,A4),D1
            move.b  (0,A1,D1.w),(0,A0,D0.w)
            addq.w  #1,(-$13E,A4)
.L9:
            addq.w  #1,(-$142,A4)
            move.w  (-$13E,A4),(-$150,A4)
            bra.b   sub_408215B6.L4
.L10:
            cmpi.w  #5,D6
            bne.b   sub_408215B6.L2
            move.w  (-$13E,A4),(-$14E,A4)
            bra.b   sub_408215B6.L4
sub_408215B6:
            move.w  D6,D0
            add.w   D0,D0
            clr.w   -(SP)
            move.w  (0,A3,D0.w),-(SP)
            move.l  ($14,A6),-(SP)
            pea     (-$13E,A4)
            lea     ($C,A6),A0
            move.l  (A0)+,D0
            beq.b   .L1
            move.l  D0,-(SP)
.L1:
            movea.l (A0),A0
            jsr     (A0)
            move.w  (SP)+,D7
            rts
.L2:
            jsr     sub_408215B6
            move.w  (-$13E,A4),(-$150,A4)
            clr.w   (-$14E,A4)
            bra.b   .L4
.L3:
            jsr     sub_408215B6
.L4:
            tst.w   D7
            beq.b   .L5
            movea.l (8,A6),A0
            move.w  D7,($1C,A0)
.L5:
            movem.l (SP)+,D5-D7/A2-A4
            move.w  #$16,D0
            bra.w   STDUNLINK
            ds.b    10
xFormX2Str:
            link.w  A6,#-$15C
            movem.l D4-D7/A2-A5,-(SP)
            movea.l ($18,A6),A0
            lea     (-$13E,A6),A5
            lea     (-$A,A6),A1
            movea.l A1,A2
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.w  (A0),(A2)
            moveq   #0,D5
            clr.w   ($1C,A6)
            movea.l ($14,A6),A4
            tst.b   ($2C,A4)
            beq.w   .L38
            movea.l ($10,A6),A3
            sf      D4
            st      (-$145,A6)
            sf      (-$D,A6)
            move.w  #$31,D0
            move.b  D0,(-$13A,A6)
            move.b  D0,(-$108,A6)
            move.b  D0,(-$D6,A6)
            bsr.w   GetSANEClass
            cmpi.w  #$FFFC,D0
            beq.b   .L2
            cmpi.w  #2,D0
            beq.w   .L36
            cmpi.w  #$FFFE,D0
            beq.w   .L36
            cmpi.w  #1,D0
            beq.w   .L36
            cmpi.w  #$FFFF,D0
            beq.w   .L36
            cmpi.w  #3,D0
            beq.w   .L37
            cmpi.w  #$FFFD,D0
            beq.w   .L37
            btst    #0,($1A,A4)
            beq.w   .L38
            tst.b   (A1)
            bpl.b   .L1
            moveq   #1,D6
            eori.b  #$80,(A1)
            bra.b   .L4
.L1:
            bne.b   .L3
.L2:
            moveq   #2,D6
            bra.b   .L4
.L3:
            moveq   #0,D6
.L4:
            move.w  D6,D0
            add.w   D0,D0
            btst    #0,($1A,A4,D0.w)
            bne.b   .L5
            cmpi.b  #1,D6
            seq     (-$D,A6)
            moveq   #0,D6
.L5:
            move.w  D6,D0
            add.w   D0,D0
            lea     (-$14C,A6),A2
            lea     ($1A,A4,D0.w),A0
            move.w  (A0),(A2)
            btst    #3,(A2)
            beq.b   .L6
            pea     .L41
            move.l  A1,-(SP)
            move.w  #4,-(SP)
            _FP68K
.L6:
            pea     (-$A,A6)
            moveq   #0,D0
            move.w  (A2),D0
            andi.l  #$600,D0
            sne     D0
            move.b  D0,-(SP)
            move.w  D6,D0
            add.w   D0,D0
            move.w  ($E,A4,D0.w),-(SP)
            move.w  ($14,A4,D0.w),-(SP)
            move.l  A6,-(SP)
            movea.l IntlSpec,A0
            movea.l ($1C4,A0),A0
            jsr     (A0)
            move.w  #1,(A5)
            move.w  #1,(-$142,A6)
            move.w  #1,(-$144,A6)
            move.w  D6,D0
            add.w   D0,D0
            move.w  (2,A4,D0.w),D7
            subq.w  #1,D7
            cmpi.b  #0,D6
            bne.b   .L7
            move.w  #1,(-$13C,A6)
            bra.b   .L8
.L7:
            move.w  (8,A4,D0.w),(-$13C,A6)
.L8:
            btst    #4,(A2)
            beq.b   .L9
            clr.w   -(SP)
            move.w  ($1C,A3),-(SP)
            pea     (-$13A,A6)
            move.l  A5,-(SP)
            jsr     SendCharRev
            move.w  (SP)+,D5
.L9:
            clr.w   (-$14E,A6)
            move.w  (A5),(-$150,A6)
            move.l  A2,-(SP)
            movea.l IntlSpec,A2
            movea.l ($1C0,A2),A2
.L10:
            cmp.w   (-$13C,A6),D7
            blt.b   .L12
            clr.w   D1
            move.b  ($2C,A4,D7.w),D1
            move.w  D1,-(SP)
            pea     (-$A4,A6)
            pea     (-$13A,A6)
            pea     SendCharRev
            clr.l   -(SP)
            move.l  A6,-(SP)
            jsr     (A2)
            tst.w   (-$14E,A6)
            beq.b   .L11
            move.w  (-$150,A6),(A5)
            clr.w   (-$14E,A6)
.L11:
            subq.w  #1,D7
            bra.b   .L10
.L12:
            movea.l (SP)+,A2
            clr.w   D0
            move.b  (-$A4,A6),D0
            cmp.w   (-$142,A6),D0
            blt.b   .L13
            move.w  (-$13E,A6),D0
            cmp.w   (-$144,A6),D0
            beq.b   .L13
            st      D4
            move.w  #8,($1C,A6)
.L13:
            move.w  (A5),D0
            subq.w  #1,D0
            move.b  D0,(-$13A,A6)
            move.b  D4,D0
            bne.w   .L26
            move.b  D6,D0
            ext.w   D0
            add.w   D0,D0
            move.w  (2,A4,D0.w),D7
            btst    #4,(A2)
            beq.b   .L14
            addq.w  #1,D7
.L14:
            move.w  #1,(A5)
            move.w  #1,(-$142,A6)
            clr.w   (-$152,A6)
            move.l  A2,-(SP)
            movea.l IntlSpec,A2
            movea.l ($1C0,A2),A2
.L15:
            move.b  D6,D0
            jsr     NextFormatClass
            add.w   D0,D0
            cmp.w   (8,A4,D0.w),D7
            slt     D0
            and.b   (-$145,A6),D0
            beq.b   .L21
            move.w  (A5),(-$156,A6)
            clr.w   D1
            move.b  ($2C,A4,D7.w),D1
            move.w  D1,(-$158,A6)
            move.w  D1,-(SP)
            pea     (-$72,A6)
            pea     (-$108,A6)
            pea     SendChar
            clr.l   -(SP)
            move.l  A6,-(SP)
            jsr     (A2)
            move.w  (-$154,A6),D0
            cmp.w   (-$142,A6),D0
            bge.b   .L20
            move.w  (-$158,A6),D1
            cmpi.b  #4,D1
            beq.b   .L16
            cmpi.b  #6,D1
            bne.b   .L17
.L16:
            clr.w   (-$152,A6)
            bra.b   .L20
.L17:
            cmpi.b  #5,D1
            bne.b   .L19
            addq.w  #1,D0
            cmp.w   (-$142,A6),D0
            bge.b   .L20
            move.w  (-$152,A6),D1
            bne.b   .L18
            move.w  (-$156,A6),D1
            move.w  D1,(-$152,A6)
.L18:
            move.w  D1,(A5)
            bra.b   .L20
.L19:
            tst.w   (-$152,A6)
            bne.b   .L20
            move.w  (-$156,A6),(-$152,A6)
.L20:
            addq.w  #1,D7
            bra.w   .L15
.L21:
            movea.l (SP)+,A2
            move.w  (A5),D0
            subq.w  #1,D0
            move.b  D0,(-$108,A6)
            move.w  D7,(-$14A,A6)
            move.b  D6,D0
            jsr     NextFormatClass
            add.w   D0,D0
            move.w  (8,A4,D0.w),D7
            subq.w  #1,D7
            move.w  #1,(A5)
            move.w  #1,(-$142,A6)
            clr.w   (-$14E,A6)
            clr.w   (-$150,A6)
            move.b  (-$145,A6),D0
            beq.b   .L22
            clr.b   (-$D6,A6)
            bra.b   .L26
.L22:
            move.l  A2,-(SP)
            movea.l IntlSpec,A2
            movea.l ($1C0,A2),A2
.L23:
            cmp.w   (-$14A,A6),D7
            blt.b   .L25
            clr.w   D1
            move.b  ($2C,A4,D7.w),D1
            move.w  D1,-(SP)
            pea     (-$40,A6)
            pea     (-$D6,A6)
            pea     SendCharRev
            clr.l   -(SP)
            move.l  A6,-(SP)
            jsr     (A2)
            tst.w   (-$14E,A6)
            beq.b   .L24
            move.w  (-$150,A6),(A5)
            clr.w   (-$14E,A6)
.L24:
            subq.w  #1,D7
            bra.b   .L23
.L25:
            movea.l (SP)+,A2
            move.w  (A5),D0
            subq.w  #1,D0
            move.b  D0,(-$D6,A6)
            clr.w   D0
            move.b  (-$40,A6),D0
            cmp.w   (-$142,A6),D0
            blt.b   .L26
            st      D4
.L26:
            move.b  D4,D0
            beq.b   .L27
            move.w  #8,($1C,A6)
            bra.w   .L39
.L27:
            movea.l ($C,A6),A0
            move.b  #$FF,(A0)
            move.w  #1,(A5)
            move.b  (-$D,A6),D0
            beq.b   .L28
            clr.w   -(SP)
            move.w  ($12,A3),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A5,-(SP)
            jsr     SendChar
            move.w  (SP)+,D5
.L28:
            clr.w   D0
            move.b  (-$13A,A6),D0
            move.w  D0,D7
            bra.b   .L30
.L29:
            movea.l ($C,A6),A0
            move.w  (A5),D0
            lea     (-$13A,A6),A1
            move.b  (0,A1,D7.w),(0,A0,D0.w)
            addq.w  #1,(A5)
            subq.w  #1,D7
.L30:
            cmpi.w  #1,D7
            bge.b   .L29
            clr.w   D0
            move.b  (-$108,A6),D0
            move.w  D0,(-$15A,A6)
            moveq   #1,D7
            bra.b   .L32
.L31:
            movea.l ($C,A6),A0
            move.w  (A5),D0
            lea     (-$108,A6),A1
            move.b  (0,A1,D7.w),(0,A0,D0.w)
            addq.w  #1,(A5)
            addq.w  #1,D7
.L32:
            cmp.w   (-$15A,A6),D7
            ble.b   .L31
            clr.w   D0
            move.b  (-$D6,A6),D0
            move.w  D0,D7
            bra.b   .L34
.L33:
            movea.l ($C,A6),A0
            move.w  (A5),D0
            lea     (-$D6,A6),A1
            move.b  (0,A1,D7.w),(0,A0,D0.w)
            addq.w  #1,(A5)
            subq.w  #1,D7
.L34:
            tst.w   D7
            bgt.b   .L33
            btst    #3,(A2)
            beq.b   .L35
            clr.w   -(SP)
            move.w  ($E,A3),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A5,-(SP)
            jsr     SendChar
            move.w  (SP)+,D5
.L35:
            movea.l ($C,A6),A0
            move.w  (A5),D0
            subq.w  #1,D0
            move.b  D0,(A0)
            bra.b   .L39
.L36:
            move.w  #9,D5
            bra.b   .L39
.L37:
            move.w  #8,D5
            bra.b   .L39
.L38:
            move.w  #$D,D5
.L39:
            tst.w   D5
            beq.b   .L40
            move.w  D5,($1C,A6)
.L40:
            movem.l (SP)+,D4-D7/A2-A5
            move.w  #$14,D0
            bra.w   STDUNLINK
.L41:
            dc.b    $40,$05,$C8
            ds.b    9

            EVEN
