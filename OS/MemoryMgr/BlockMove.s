            include "Include/ROMHeader.s"

            EXPORT  BlockMove68020,BMEXIT16,BMMOVELONGS,BMOVERLAP,BMVERYSHORT

            SECTION "BlockMove",CODE

BLOCKMOVES:
            move.l  (A0)+,(A1)+
.L29:
            move.l  (A0)+,(A1)+
.L25:
            move.l  (A0)+,(A1)+
.L21:
            move.l  (A0)+,(A1)+
.L17:
            move.l  (A0)+,(A1)+
.L13:
            move.l  (A0)+,(A1)+
.L9:
            move.l  (A0)+,(A1)+
.L5:
            move.w  (A0)+,(A1)+
            moveq   #0,D0
            rts
            bra.b   .L3
            bra.b   .L4
            bra.b   .L5
            bra.b   .L6
            bra.b   .L7
            bra.b   .L8
            bra.b   .L9
            bra.b   .L10
            bra.b   .L11
            bra.b   .L12
            bra.b   .L13
            bra.b   .L14
            bra.b   .L15
            bra.b   .L16
            bra.b   .L17
            bra.b   .L18
            bra.b   .L19
            bra.b   .L20
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            bra.b   .L27
            bra.b   .L28
            bra.b   .L29
            bra.b   .L1
            bra.b   .L30
            bra.b   .L31
            bra.b   BLOCKMOVES
            move.l  (A0)+,(A1)+
.L1:
            move.l  (A0)+,(A1)+
.L26:
            move.l  (A0)+,(A1)+
.L22:
            move.l  (A0)+,(A1)+
.L18:
            move.l  (A0)+,(A1)+
.L14:
            move.l  (A0)+,(A1)+
.L10:
            move.l  (A0)+,(A1)+
.L6:
            move.w  (A0)+,(A1)+
.L4:
            move.b  (A0)+,(A1)+
            moveq   #0,D0
            rts
.L30:
            move.l  (A0)+,(A1)+
.L27:
            move.l  (A0)+,(A1)+
.L23:
            move.l  (A0)+,(A1)+
.L19:
            move.l  (A0)+,(A1)+
.L15:
            move.l  (A0)+,(A1)+
.L11:
            move.l  (A0)+,(A1)+
.L7:
            move.l  (A0)+,(A1)+
.L3:
            moveq   #0,D0
            rts
.L31:
            move.l  (A0)+,(A1)+
.L28:
            move.l  (A0)+,(A1)+
.L24:
            move.l  (A0)+,(A1)+
.L20:
            move.l  (A0)+,(A1)+
.L16:
            move.l  (A0)+,(A1)+
.L12:
            move.l  (A0)+,(A1)+
.L8:
            move.l  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
            moveq   #0,D0
            rts
            dc.w    0
.L2:
            move.l  ($6F4).w,-(SP)
            move.l  A1,D1
            moveq   #-4,D2
            or.l    D1,D2
            sub.l   A0,D1
            and.l   Lo3Bytes,D1
            cmp.l   D0,D1
            bcs.b   BMOVERLAP
BMMOVELONGS:
            jmp     .L1(PC,D2.w*2)
            bra.b   .L2
            move.b  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
            move.b  (A0)+,(A1)+
.L1:
            add.l   D2,D0
.L2:
            moveq   #$20,D2
            sub.l   D2,D0
            bge.b   BMEXIT16.L1
BMEXIT16:
            jmp     BLOCKMOVES.L1(PC,D0.w*2)
.L1:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            sub.l   D2,D0
            bge.b   .L1
            jmp     BLOCKMOVES.L1(PC,D0.w*2)
BMOVERLAP:
            cmp.l   Lo3Bytes,D0
            bhi.b   .L2
            cmpa.l  A0,A1
.L1:
            adda.l  D0,A0
            adda.l  D0,A1
            bne.w   BMVERYSHORT.L7
            moveq   #0,D0
            rts
.L2:
            cmpa.l  A0,A1
            bcc.b   .L1
            jmp     BMMOVELONGS.L1(PC,D2.w*2)
BlockMove68020:
BlockMove:
            moveq   #-$C,D1
            add.l   D0,D1
            bgt.b   BLOCKMOVES.L2
BMVERYSHORT:
            tst.l   D0
            ble.b   .L3
            lsl.w   #3,D0
            addq.l  #4,D1
            ble.b   .L4
            addq.l  #8,A0
            bfextu  (A0){0:D0},D2
            move.l  -(A0),D1
            move.l  -(A0),(A1)+
.L1:
            move.l  D1,(A1)+
.L2:
            bfins   D2,(A1){0:D0}
.L3:
            moveq   #0,D0
            rts
.L4:
            addq.l  #4,D1
            ble.b   .L5
            move.l  (A0)+,D1
            bfextu  (A0){0:D0},D2
            bra.b   .L1
.L5:
            bfextu  (A0){0:D0},D2
            bra.b   .L2
.L40:
            move.l  -(A0),-(A1)
.L37:
            move.l  -(A0),-(A1)
.L33:
            move.l  -(A0),-(A1)
.L29:
            move.l  -(A0),-(A1)
.L25:
            move.l  -(A0),-(A1)
.L21:
            move.l  -(A0),-(A1)
.L17:
            move.l  -(A0),-(A1)
.L13:
            move.w  -(A0),-(A1)
            moveq   #0,D0
            rts
            bra.b   .L11
            bra.b   .L12
            bra.b   .L13
            bra.b   .L14
            bra.b   .L15
            bra.b   .L16
            bra.b   .L17
            bra.b   .L18
            bra.b   .L19
            bra.b   .L20
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            bra.b   .L27
            bra.b   .L28
            bra.b   .L29
            bra.b   .L30
            bra.b   .L31
            bra.b   .L32
            bra.b   .L33
            bra.b   .L34
            bra.b   .L35
            bra.b   .L36
            bra.b   .L37
            bra.b   .L6
            bra.b   .L38
            bra.b   .L39
            bra.b   .L40
            move.l  -(A0),-(A1)
.L6:
            move.l  -(A0),-(A1)
.L34:
            move.l  -(A0),-(A1)
.L30:
            move.l  -(A0),-(A1)
.L26:
            move.l  -(A0),-(A1)
.L22:
            move.l  -(A0),-(A1)
.L18:
            move.l  -(A0),-(A1)
.L14:
            move.w  -(A0),-(A1)
.L12:
            move.b  -(A0),-(A1)
            moveq   #0,D0
            rts
.L38:
            move.l  -(A0),-(A1)
.L35:
            move.l  -(A0),-(A1)
.L31:
            move.l  -(A0),-(A1)
.L27:
            move.l  -(A0),-(A1)
.L23:
            move.l  -(A0),-(A1)
.L19:
            move.l  -(A0),-(A1)
.L15:
            move.l  -(A0),-(A1)
.L11:
            moveq   #0,D0
            rts
.L39:
            move.l  -(A0),-(A1)
.L36:
            move.l  -(A0),-(A1)
.L32:
            move.l  -(A0),-(A1)
.L28:
            move.l  -(A0),-(A1)
.L24:
            move.l  -(A0),-(A1)
.L20:
            move.l  -(A0),-(A1)
.L16:
            move.l  -(A0),-(A1)
            move.b  -(A0),-(A1)
            moveq   #0,D0
            rts
            ds.b    12
.L7:
            move.l  A1,D1
            moveq   #3,D2
            and.l   D1,D2
            beq.b   .L9
            neg.l   D2
            jmp     .L8(PC,D2.w*2)
            move.b  -(A0),-(A1)
            move.b  -(A0),-(A1)
            move.b  -(A0),-(A1)
.L8:
            add.l   D2,D0
.L9:
            moveq   #$20,D2
            sub.l   D2,D0
            bge.b   .L10
            jmp     .L6(PC,D0.w*2)
.L10:
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            sub.l   D2,D0
            bge.b   .L10
            jmp     .L6(PC,D0.w*2)
            ds.b    8

            EVEN
