            include "Include/ROMHeader.s"

            EXPORT  INITMACEDISPATCH

            IMPORT  DispAddTool,IQUADEL2_TABLE,IQUADEL3_TABLE,MACEVERSION,MIN2_TABLE,MIN3_TABLE
            IMPORT  TABLES

            SECTION "MACE",CODE

INITMACEDISPATCH:
            clr.w   -(SP)
            move.w  #$10,-(SP)
            pea     .L1
            jsr     (DispAddTool.w,PC)
            move.w  (SP)+,D0
            rts
.L1:
            jmp     .L2(PC,D0.w)
.L2:
            jmp     (MACEVERSION.w,PC)              ; _SoundDispatch $00000010
            jmp     Comp3to1                        ; _SoundDispatch $00040010
            jmp     Exp1to3                         ; _SoundDispatch $00080010
            jmp     Comp6to1                        ; _SoundDispatch $000C0010
            jmp     Exp1to6                         ; _SoundDispatch $00100010
            ds.b    6
Comp3to1:
            link.w  A6,#0
            movem.l D0-D7/A0-A5,-(SP)
            cmpi.l  #6,($18,A6)
            blt.w   .L39
            movea.l ($14,A6),A0
            cmpa.w  #0,A0
            bne.b   .L1
            clr.w   D3
            move.w  D3,D4
            move.w  D3,D5
            move.w  D3,D6
            bra.b   .L2
.L1:
            move.w  (A0),D3
            move.w  (2,A0),D4
            move.w  (4,A0),D5
            move.w  (6,A0),D6
.L2:
            movea.l ($20,A6),A2
            movea.l ($1C,A6),A3
            move.l  (8,A6),D0
            subq.l  #1,D0
            adda.l  D0,A2
            movea.l ($C,A6),A5
            subq.l  #1,A5
.L3:
            move.b  (A2)+,D0
            adda.l  A5,A2
            addi.b  #$80,D0
            ext.w   D0
            asl.w   #8,D0
            addi.b  #$80,D0
            sub.w   D4,D0
            bvc.b   .L5
            bmi.b   .L4
            move.w  #$8001,D0
            bra.b   .L5
.L4:
            move.w  #$7FFF,D0
.L5:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A4
            adda.w  D1,A4
            muls.w  (A4),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L9
            cmpi.w  #$13,D0
            bgt.b   .L6
            moveq   #0,D2
            bra.b   .L13
.L6:
            cmpi.w  #$28,D0
            bgt.b   .L7
            moveq   #1,D2
            bra.b   .L13
.L7:
            cmpi.w  #$43,D0
            bgt.b   .L8
            moveq   #2,D2
            bra.b   .L13
.L8:
            moveq   #3,D2
            bra.b   .L13
.L9:
            not.w   D0
            cmpi.w  #$13,D0
            bgt.b   .L10
            moveq   #7,D2
            bra.b   .L13
.L10:
            cmpi.w  #$28,D0
            bgt.b   .L11
            moveq   #6,D2
            bra.b   .L13
.L11:
            cmpi.w  #$43,D0
            bgt.b   .L12
            moveq   #5,D2
            bra.b   .L13
.L12:
            moveq   #4,D2
.L13:
            asl.w   #3,D1
            lea     (IQUADEL3_TABLE.w,PC),A4
            add.w   D2,D1
            add.w   D2,D1
            adda.w  D1,A4
            move.w  (A4),D6
            add.w   D4,D6
            bvc.b   .L15
            bmi.b   .L14
            move.w  #$8001,D6
            bra.b   .L15
.L14:
            move.w  #$7FFF,D6
.L15:
            move.w  D6,D0
            move.w  D6,D4
            asr.w   #3,D0
            sub.w   D0,D4
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D2,A4
            adda.w  D2,A4
            add.w   (A4),D3
            bge.b   .L16
            clr.w   D3
.L16:
            move.b  D2,D7
            move.b  (A2)+,D0
            adda.l  A5,A2
            addi.b  #$80,D0
            ext.w   D0
            asl.w   #8,D0
            addi.b  #$80,D0
            sub.w   D4,D0
            bvc.b   .L18
            bmi.b   .L17
            move.w  #$8001,D0
            bra.b   .L18
.L17:
            move.w  #$7FFF,D0
.L18:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A4
            adda.w  D1,A4
            muls.w  (A4),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L20
            cmpi.w  #$23,D0
            bgt.b   .L19
            moveq   #0,D2
            bra.b   .L22
.L19:
            moveq   #1,D2
            bra.b   .L22
.L20:
            not.w   D0
            cmpi.w  #$23,D0
            bgt.b   .L21
            moveq   #3,D2
            bra.b   .L22
.L21:
            moveq   #2,D2
.L22:
            asl.w   #3,D1
            lea     (IQUADEL2_TABLE.w,PC),A4
            add.w   D2,D1
            add.w   D2,D1
            adda.w  D1,A4
            move.w  (A4),D6
            add.w   D4,D6
            bvc.b   .L24
            bmi.b   .L23
            move.w  #$8001,D6
            bra.b   .L24
.L23:
            move.w  #$7FFF,D6
.L24:
            move.w  D6,D0
            move.w  D6,D4
            asr.w   #3,D0
            sub.w   D0,D4
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN2_TABLE.w,PC),A4
            adda.w  D2,A4
            adda.w  D2,A4
            add.w   (A4),D3
            bge.b   .L25
            clr.w   D3
.L25:
            asl.b   #3,D2
            add.b   D2,D7
            move.b  (A2)+,D0
            adda.l  A5,A2
            addi.b  #$80,D0
            ext.w   D0
            asl.w   #8,D0
            addi.b  #$80,D0
            sub.w   D4,D0
            bvc.b   .L27
            bmi.b   .L26
            move.w  #$8001,D0
            bra.b   .L27
.L26:
            move.w  #$7FFF,D0
.L27:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A4
            adda.w  D1,A4
            muls.w  (A4),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L31
            cmpi.w  #$13,D0
            bgt.b   .L28
            moveq   #0,D2
            bra.b   .L35
.L28:
            cmpi.w  #$28,D0
            bgt.b   .L29
            moveq   #1,D2
            bra.b   .L35
.L29:
            cmpi.w  #$43,D0
            bgt.b   .L30
            moveq   #2,D2
            bra.b   .L35
.L30:
            moveq   #3,D2
            bra.b   .L35
.L31:
            not.w   D0
            cmpi.w  #$13,D0
            bgt.b   .L32
            moveq   #7,D2
            bra.b   .L35
.L32:
            cmpi.w  #$28,D0
            bgt.b   .L33
            moveq   #6,D2
            bra.b   .L35
.L33:
            cmpi.w  #$43,D0
            bgt.b   .L34
            moveq   #5,D2
            bra.b   .L35
.L34:
            moveq   #4,D2
.L35:
            asl.w   #3,D1
            lea     (IQUADEL3_TABLE.w,PC),A4
            add.w   D2,D1
            add.w   D2,D1
            adda.w  D1,A4
            move.w  (A4),D6
            add.w   D4,D6
            bvc.b   .L37
            bmi.b   .L36
            move.w  #$8001,D6
            bra.b   .L37
.L36:
            move.w  #$7FFF,D6
.L37:
            move.w  D6,D0
            move.w  D6,D4
            asr.w   #3,D0
            sub.w   D0,D4
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D2,A4
            adda.w  D2,A4
            add.w   (A4),D3
            bge.b   .L38
            clr.w   D3
.L38:
            asl.b   #5,D2
            add.b   D2,D7
            move.b  D7,(A3)+
            subq.l  #3,($18,A6)
            bgt.w   .L3
            movea.l ($10,A6),A0
            cmpa.w  #0,A0
            beq.b   .L39
            move.w  D3,(A0)
            move.w  D4,(2,A0)
            move.w  D5,(4,A0)
            move.w  D6,(6,A0)
.L39:
            movem.l (SP)+,D0-D7/A0-A5
            movea.l (4,A6),A0
            unlk    A6
            adda.w  #$20,SP
            jmp     (A0)
            ds.b    10
Exp1to3:
            link.w  A6,#0
            movem.l D0-D7/A0-A5,-(SP)
            cmpi.l  #1,($18,A6)
            blt.w   .L22
            movea.l ($14,A6),A0
            cmpa.w  #0,A0
            bne.b   .L1
            clr.w   D2
            clr.w   D3
            bra.b   .L2
.L1:
            move.w  (A0),D2
            move.w  (2,A0),D3
.L2:
            movea.l ($20,A6),A2
            movea.l ($1C,A6),A3
            move.w  #$7F0,D6
            movea.w #$10,A5
            move.w  #$8080,D7
            move.l  (8,A6),D0
            subq.l  #1,D0
            lsl.l   #1,D0
            adda.l  D0,A2
            movea.l ($C,A6),A1
            subq.l  #1,A1
            adda.l  A1,A1
.L3:
            move.b  (A2)+,D4
            moveq   #7,D1
            and.b   D4,D1
            add.w   D1,D1
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L4
            moveq   #0,D2
.L4:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L6
            bmi.b   .L5
            move.w  #$8001,D3
            bra.b   .L6
.L5:
            move.w  #$7FFF,D3
.L6:
            move.w  D3,D0
            move.w  D0,D5
            andi.w  #$FF00,D5
            asr.w   #3,D0
            sub.w   D0,D3
            lsr.w   #2,D4
            moveq   #6,D1
            and.b   D4,D1
            lea     (MIN2_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L7
            moveq   #0,D2
.L7:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L9
            bmi.b   .L8
            move.w  #$8001,D3
            bra.b   .L9
.L8:
            move.w  #$7FFF,D3
.L9:
            move.w  D3,D0
            asr.w   #3,D0
            sub.w   D0,D3
            lsr.w   #5,D0
            andi.w  #$FF,D0
            or.w    D0,D5
            eor.w   D7,D5
            move.w  D5,(A3)+
            lsr.w   #2,D4
            moveq   #$E,D1
            and.b   D4,D1
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L10
            moveq   #0,D2
.L10:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L12
            bmi.b   .L11
            move.w  #$8001,D3
            bra.b   .L12
.L11:
            move.w  #$7FFF,D3
.L12:
            move.w  D3,D0
            move.w  D0,D5
            andi.w  #$FF00,D5
            asr.w   #3,D0
            sub.w   D0,D3
            move.b  (A2)+,D4
            moveq   #7,D1
            and.b   D4,D1
            add.w   D1,D1
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L13
            moveq   #0,D2
.L13:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L15
            bmi.b   .L14
            move.w  #$8001,D3
            bra.b   .L15
.L14:
            move.w  #$7FFF,D3
.L15:
            move.w  D3,D0
            asr.w   #3,D0
            sub.w   D0,D3
            lsr.w   #5,D0
            andi.w  #$FF,D0
            or.w    D0,D5
            eor.w   D7,D5
            move.w  D5,(A3)+
            lsr.w   #2,D4
            moveq   #6,D1
            and.b   D4,D1
            lea     (MIN2_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L16
            moveq   #0,D2
.L16:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L18
            bmi.b   .L17
            move.w  #$8001,D3
            bra.b   .L18
.L17:
            move.w  #$7FFF,D3
.L18:
            move.w  D3,D0
            move.w  D0,D5
            andi.w  #$FF00,D5
            asr.w   #3,D0
            sub.w   D0,D3
            lsr.w   #2,D4
            moveq   #$E,D1
            and.b   D4,D1
            lea     (MIN3_TABLE.w,PC),A4
            adda.w  D1,A4
            move.w  D2,D1
            move.w  D2,D0
            asr.w   #5,D0
            sub.w   D0,D2
            add.w   (A4),D2
            bge.b   .L19
            moveq   #0,D2
.L19:
            and.w   D6,D1
            add.w   A5,D1
            adda.w  D1,A4
            add.w   (A4),D3
            bvc.b   .L21
            bmi.b   .L20
            move.w  #$8001,D3
            bra.b   .L21
.L20:
            move.w  #$7FFF,D3
.L21:
            move.w  D3,D0
            asr.w   #3,D0
            sub.w   D0,D3
            lsr.w   #5,D0
            andi.w  #$FF,D0
            or.w    D0,D5
            eor.w   D7,D5
            move.w  D5,(A3)+
            adda.l  A1,A2
            subq.l  #1,($18,A6)
            bne.w   .L3
            movea.l ($10,A6),A0
            cmpa.w  #0,A0
            beq.b   .L22
            move.w  D2,(A0)
            move.w  D3,(2,A0)
.L22:
            movem.l (SP)+,D0-D7/A0-A5
            movea.l (4,A6),A0
            unlk    A6
            adda.w  #$20,SP
            jmp     (A0)
            ds.b    8
Comp6to1:
            link.w  A6,#-4
            movem.l D0-D7/A0-A5,-(SP)
            cmpi.l  #6,($18,A6)
            blt.w   .L54
            movea.l ($14,A6),A0
            cmpa.w  #0,A0
            bne.b   .L1
            move.w  #$FC02,D6
            movea.w #$FC02,A5
            move.w  #$E00F,D7
            movea.w #$E00F,A4
            clr.w   D3
            clr.w   D4
            clr.w   D5
            suba.l  A2,A2
            bra.b   .L2
.L1:
            move.w  (A0),D6
            movea.w (2,A0),A5
            move.w  (4,A0),D7
            movea.w (6,A0),A4
            move.w  (8,A0),D3
            move.w  ($A,A0),D4
            move.w  ($C,A0),D5
            movea.w ($E,A0),A2
.L2:
            movea.l ($20,A6),A0
            movea.l ($1C,A6),A1
            move.l  (8,A6),D0
            subq.l  #1,D0
            adda.l  D0,A0
            move.l  ($C,A6),(-4,A6)
            subq.l  #1,(-4,A6)
.L3:
            moveq   #-$80,D1
            add.b   (A0)+,D1
            adda.l  (-4,A6),A0
            ext.w   D1
            asl.w   #4,D1
            add.w   D6,D1
            sub.w   A5,D1
            asr.w   #1,D1
            move.w  A5,D0
            add.w   D6,D0
            add.w   D6,D0
            add.w   D1,D0
            movea.w D6,A5
            move.w  D1,D6
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D0,D7
            moveq   #-$80,D0
            add.b   (A0)+,D0
            adda.l  (-4,A6),A0
            ext.w   D0
            asl.w   #4,D0
            add.w   D6,D0
            sub.w   A5,D0
            asr.w   #1,D0
            move.w  A5,D1
            add.w   D6,D1
            add.w   D6,D1
            add.w   D0,D1
            movea.w D6,A5
            move.w  D0,D6
            move.w  A4,D0
            add.w   D7,D0
            add.w   D7,D0
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D1,D7
            add.w   D7,D0
            sub.w   D4,D0
            bvc.b   .L5
            bmi.b   .L4
            move.w  #$8001,D0
            bra.b   .L5
.L4:
            move.w  #$7FFF,D0
.L5:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A3
            adda.w  D1,A3
            muls.w  (A3),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L9
            cmpi.w  #$15,D0
            bgt.b   .L6
            moveq   #0,D2
            bra.b   .L13
.L6:
            cmpi.w  #$2B,D0
            bgt.b   .L7
            moveq   #1,D2
            bra.b   .L13
.L7:
            cmpi.w  #$48,D0
            bgt.b   .L8
            moveq   #2,D2
            bra.b   .L13
.L8:
            moveq   #3,D2
            bra.b   .L13
.L9:
            not.w   D0
            cmpi.w  #$15,D0
            bgt.b   .L10
            moveq   #7,D2
            bra.b   .L13
.L10:
            cmpi.w  #$2B,D0
            bgt.b   .L11
            moveq   #6,D2
            bra.b   .L13
.L11:
            cmpi.w  #$48,D0
            bgt.b   .L12
            moveq   #5,D2
            bra.b   .L13
.L12:
            moveq   #4,D2
.L13:
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN3_TABLE.w,PC),A3
            adda.w  D2,A3
            adda.w  D2,A3
            add.w   (A3),D3
            bge.b   .L14
            clr.w   D3
.L14:
            asl.w   #3,D1
            lea     ($10,A3),A3
            adda.w  D1,A3
            move.w  (A3),D0
            move.w  A2,D1
            eor.w   D0,D1
            bmi.b   .L18
            add.w   D4,D0
            bvc.b   .L16
            bmi.b   .L15
            move.w  #$8001,D0
            bra.b   .L16
.L15:
            move.w  #$7FFF,D0
.L16:
            movea.w D0,A2
            addi.w  #$1FA,D5
            bvc.b   .L17
            move.w  #$7FFF,D5
.L17:
            bra.b   .L21
.L18:
            add.w   D4,D0
            bvc.b   .L20
            bmi.b   .L19
            move.w  #$8001,D0
            bra.b   .L20
.L19:
            move.w  #$7FFF,D0
.L20:
            movea.w D0,A2
            subi.w  #$13A,D5
            bvc.b   .L21
            move.w  #$8001,D5
.L21:
            muls.w  D5,D0
            add.l   D0,D0
            swap    D0
            move.w  D0,D4
            asl.b   #5,D2
            move.b  D2,(A1)
            moveq   #-$80,D1
            add.b   (A0)+,D1
            adda.l  (-4,A6),A0
            ext.w   D1
            asl.w   #4,D1
            add.w   D6,D1
            sub.w   A5,D1
            asr.w   #1,D1
            move.w  A5,D0
            add.w   D6,D0
            add.w   D6,D0
            add.w   D1,D0
            movea.w D6,A5
            move.w  D1,D6
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D0,D7
            moveq   #-$80,D0
            add.b   (A0)+,D0
            adda.l  (-4,A6),A0
            ext.w   D0
            asl.w   #4,D0
            add.w   D6,D0
            sub.w   A5,D0
            asr.w   #1,D0
            move.w  A5,D1
            add.w   D6,D1
            add.w   D6,D1
            add.w   D0,D1
            movea.w D6,A5
            move.w  D0,D6
            move.w  A4,D0
            add.w   D7,D0
            add.w   D7,D0
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D1,D7
            add.w   D7,D0
            sub.w   D4,D0
            bvc.b   .L23
            bmi.b   .L22
            move.w  #$8001,D0
            bra.b   .L23
.L22:
            move.w  #$7FFF,D0
.L23:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A3
            adda.w  D1,A3
            muls.w  (A3),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L25
            cmpi.w  #$25,D0
            bgt.b   .L24
            moveq   #0,D2
            bra.b   .L27
.L24:
            moveq   #1,D2
            bra.b   .L27
.L25:
            not.w   D0
            cmpi.w  #$25,D0
            bgt.b   .L26
            moveq   #3,D2
            bra.b   .L27
.L26:
            moveq   #2,D2
.L27:
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN2_TABLE.w,PC),A3
            adda.w  D2,A3
            adda.w  D2,A3
            add.w   (A3),D3
            bge.b   .L28
            clr.w   D3
.L28:
            asl.w   #3,D1
            lea     ($10,A3),A3
            adda.w  D1,A3
            move.w  (A3),D0
            move.w  A2,D1
            eor.w   D0,D1
            bmi.b   .L32
            add.w   D4,D0
            bvc.b   .L30
            bmi.b   .L29
            move.w  #$8001,D0
            bra.b   .L30
.L29:
            move.w  #$7FFF,D0
.L30:
            movea.w D0,A2
            addi.w  #$1FA,D5
            bvc.b   .L31
            move.w  #$7FFF,D5
.L31:
            bra.b   .L35
.L32:
            add.w   D4,D0
            bvc.b   .L34
            bmi.b   .L33
            move.w  #$8001,D0
            bra.b   .L34
.L33:
            move.w  #$7FFF,D0
.L34:
            movea.w D0,A2
            subi.w  #$13A,D5
            bvc.b   .L35
            move.w  #$8001,D5
.L35:
            muls.w  D5,D0
            add.l   D0,D0
            swap    D0
            move.w  D0,D4
            asl.b   #3,D2
            add.b   D2,(A1)
            moveq   #-$80,D1
            add.b   (A0)+,D1
            adda.l  (-4,A6),A0
            ext.w   D1
            asl.w   #4,D1
            add.w   D6,D1
            sub.w   A5,D1
            asr.w   #1,D1
            move.w  A5,D0
            add.w   D6,D0
            add.w   D6,D0
            add.w   D1,D0
            movea.w D6,A5
            move.w  D1,D6
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D0,D7
            moveq   #-$80,D0
            add.b   (A0)+,D0
            adda.l  (-4,A6),A0
            ext.w   D0
            asl.w   #4,D0
            add.w   D6,D0
            sub.w   A5,D0
            asr.w   #1,D0
            move.w  A5,D1
            add.w   D6,D1
            add.w   D6,D1
            add.w   D0,D1
            movea.w D6,A5
            move.w  D0,D6
            move.w  A4,D0
            add.w   D7,D0
            add.w   D7,D0
            movea.w D7,A4
            asr.w   #1,D7
            add.w   D1,D7
            add.w   D7,D0
            sub.w   D4,D0
            bvc.b   .L37
            bmi.b   .L36
            move.w  #$8001,D0
            bra.b   .L37
.L36:
            move.w  #$7FFF,D0
.L37:
            move.w  D3,D1
            asr.w   #4,D1
            add.w   D1,D1
            lea     (TABLES.w,PC),A3
            adda.w  D1,A3
            muls.w  (A3),D0
            swap    D0
            or.w    D0,D0
            bmi.b   .L41
            cmpi.w  #$15,D0
            bgt.b   .L38
            moveq   #0,D2
            bra.b   .L45
.L38:
            cmpi.w  #$2B,D0
            bgt.b   .L39
            moveq   #1,D2
            bra.b   .L45
.L39:
            cmpi.w  #$48,D0
            bgt.b   .L40
            moveq   #2,D2
            bra.b   .L45
.L40:
            moveq   #3,D2
            bra.b   .L45
.L41:
            not.w   D0
            cmpi.w  #$15,D0
            bgt.b   .L42
            moveq   #7,D2
            bra.b   .L45
.L42:
            cmpi.w  #$2B,D0
            bgt.b   .L43
            moveq   #6,D2
            bra.b   .L45
.L43:
            cmpi.w  #$48,D0
            bgt.b   .L44
            moveq   #5,D2
            bra.b   .L45
.L44:
            moveq   #4,D2
.L45:
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            lea     (MIN3_TABLE.w,PC),A3
            adda.w  D2,A3
            adda.w  D2,A3
            add.w   (A3),D3
            bge.b   .L46
            clr.w   D3
.L46:
            asl.w   #3,D1
            lea     ($10,A3),A3
            adda.w  D1,A3
            move.w  (A3),D0
            move.w  A2,D1
            eor.w   D0,D1
            bmi.b   .L50
            add.w   D4,D0
            bvc.b   .L48
            bmi.b   .L47
            move.w  #$8001,D0
            bra.b   .L48
.L47:
            move.w  #$7FFF,D0
.L48:
            movea.w D0,A2
            addi.w  #$1FA,D5
            bvc.b   .L49
            move.w  #$7FFF,D5
.L49:
            bra.b   .L53
.L50:
            add.w   D4,D0
            bvc.b   .L52
            bmi.b   .L51
            move.w  #$8001,D0
            bra.b   .L52
.L51:
            move.w  #$7FFF,D0
.L52:
            movea.w D0,A2
            subi.w  #$13A,D5
            bvc.b   .L53
            move.w  #$8001,D5
.L53:
            muls.w  D5,D0
            add.l   D0,D0
            swap    D0
            move.w  D0,D4
            add.b   D2,(A1)+
            subq.l  #6,($18,A6)
            bgt.w   .L3
            movea.l ($10,A6),A0
            cmpa.w  #0,A0
            beq.b   .L54
            move.w  D6,(A0)
            move.w  A5,(2,A0)
            move.w  D7,(4,A0)
            move.w  A4,(6,A0)
            move.w  D3,(8,A0)
            move.w  D4,($A,A0)
            move.w  D5,($C,A0)
            move.w  A2,($E,A0)
.L54:
            movem.l (SP)+,D0-D7/A0-A5
            movea.l (4,A6),A0
            unlk    A6
            adda.w  #$20,SP
            jmp     (A0)
            ds.b    4
Exp1to6:
            link.w  A6,#-4
            movem.l D0-D7/A0-A5,-(SP)
            cmpi.l  #1,($18,A6)
            blt.w   .L28
            movea.l ($14,A6),A0
            cmpa.w  #0,A0
            bne.b   .L1
            suba.l  A4,A4
            move.w  A4,D5
            move.w  A4,D3
            movea.w A4,A5
            move.w  A4,D4
            move.w  A4,D2
            bra.b   .L2
.L1:
            movea.w (A0),A4
            move.w  (2,A0),D5
            move.w  (4,A0),D3
            movea.w (6,A0),A5
            move.w  (8,A0),D4
            move.w  ($A,A0),D2
.L2:
            movea.l ($20,A6),A0
            movea.l ($1C,A6),A2
            move.w  #$7F0,D6
            move.w  #$10,D7
            move.l  (8,A6),D0
            subq.l  #1,D0
            adda.l  D0,A0
            movea.l ($C,A6),A3
            subq.l  #1,A3
.L3:
            move.b  (A0)+,D1
            moveq   #7,D0
            and.w   D1,D0
            add.w   D0,D0
            move.w  D0,(-2,A6)
            lsr.w   #2,D1
            moveq   #6,D0
            and.w   D1,D0
            move.w  D0,(-4,A6)
            lsr.w   #2,D1
            andi.w  #$E,D1
            lea     (MIN3_TABLE.w,PC),A1
            adda.w  D1,A1
            move.w  D3,D1
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            add.w   (A1),D3
            bge.b   .L4
            clr.w   D3
.L4:
            and.w   D6,D1
            add.w   D7,D1
            adda.w  D1,A1
            move.w  (A1),D0
            eor.w   D0,D2
            bmi.b   .L8
            add.w   A5,D0
            bvc.b   .L6
            bmi.b   .L5
            move.w  #$8001,D0
            bra.b   .L6
.L5:
            move.w  #$7FFF,D0
.L6:
            move.w  D0,D2
            addi.w  #$1FA,D4
            bvc.b   .L7
            move.w  #$7FFF,D4
.L7:
            bra.b   .L11
.L8:
            add.w   A5,D0
            bvc.b   .L10
            bmi.b   .L9
            move.w  #$8001,D0
            bra.b   .L10
.L9:
            move.w  #$7FFF,D0
.L10:
            move.w  D0,D2
            subi.w  #$13A,D4
            bvc.b   .L11
            move.w  #$8001,D4
.L11:
            muls.w  D4,D0
            add.l   D0,D0
            swap    D0
            movea.w D0,A5
            asr.w   #1,D2
            move.w  D5,D1
            sub.w   D2,D1
            asr.w   #2,D1
            move.w  D5,D0
            add.w   A4,D0
            sub.w   D1,D0
            move.w  A4,D5
            movea.w D2,A4
            add.w   A4,D1
            add.w   D5,D1
            andi.w  #$FF00,D0
            lsr.w   #8,D1
            or.w    D0,D1
            eori.w  #$8080,D1
            move.w  D1,(A2)+
            move.w  (-4,A6),D1
            lea     (MIN2_TABLE.w,PC),A1
            adda.w  D1,A1
            move.w  D3,D1
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            add.w   (A1),D3
            bge.b   .L12
            clr.w   D3
.L12:
            and.w   D6,D1
            add.w   D7,D1
            adda.w  D1,A1
            move.w  (A1),D0
            eor.w   D0,D2
            bmi.b   .L16
            add.w   A5,D0
            bvc.b   .L14
            bmi.b   .L13
            move.w  #$8001,D0
            bra.b   .L14
.L13:
            move.w  #$7FFF,D0
.L14:
            move.w  D0,D2
            addi.w  #$1FA,D4
            bvc.b   .L15
            move.w  #$7FFF,D4
.L15:
            bra.b   .L19
.L16:
            add.w   A5,D0
            bvc.b   .L18
            bmi.b   .L17
            move.w  #$8001,D0
            bra.b   .L18
.L17:
            move.w  #$7FFF,D0
.L18:
            move.w  D0,D2
            subi.w  #$13A,D4
            bvc.b   .L19
            move.w  #$8001,D4
.L19:
            muls.w  D4,D0
            add.l   D0,D0
            swap    D0
            movea.w D0,A5
            asr.w   #1,D2
            move.w  D5,D1
            sub.w   D2,D1
            asr.w   #2,D1
            move.w  D5,D0
            add.w   A4,D0
            sub.w   D1,D0
            move.w  A4,D5
            movea.w D2,A4
            add.w   A4,D1
            add.w   D5,D1
            andi.w  #$FF00,D0
            lsr.w   #8,D1
            or.w    D0,D1
            eori.w  #$8080,D1
            move.w  D1,(A2)+
            move.w  (-2,A6),D1
            lea     (MIN3_TABLE.w,PC),A1
            adda.w  D1,A1
            move.w  D3,D1
            move.w  D3,D0
            asr.w   #5,D0
            sub.w   D0,D3
            add.w   (A1),D3
            bge.b   .L20
            clr.w   D3
.L20:
            and.w   D6,D1
            add.w   D7,D1
            adda.w  D1,A1
            move.w  (A1),D0
            eor.w   D0,D2
            bmi.b   .L24
            add.w   A5,D0
            bvc.b   .L22
            bmi.b   .L21
            move.w  #$8001,D0
            bra.b   .L22
.L21:
            move.w  #$7FFF,D0
.L22:
            move.w  D0,D2
            addi.w  #$1FA,D4
            bvc.b   .L23
            move.w  #$7FFF,D4
.L23:
            bra.b   .L27
.L24:
            add.w   A5,D0
            bvc.b   .L26
            bmi.b   .L25
            move.w  #$8001,D0
            bra.b   .L26
.L25:
            move.w  #$7FFF,D0
.L26:
            move.w  D0,D2
            subi.w  #$13A,D4
            bvc.b   .L27
            move.w  #$8001,D4
.L27:
            muls.w  D4,D0
            add.l   D0,D0
            swap    D0
            movea.w D0,A5
            asr.w   #1,D2
            move.w  D5,D1
            sub.w   D2,D1
            asr.w   #2,D1
            move.w  D5,D0
            add.w   A4,D0
            sub.w   D1,D0
            move.w  A4,D5
            movea.w D2,A4
            add.w   A4,D1
            add.w   D5,D1
            andi.w  #$FF00,D0
            lsr.w   #8,D1
            or.w    D0,D1
            eori.w  #$8080,D1
            move.w  D1,(A2)+
            adda.l  A3,A0
            subq.l  #1,($18,A6)
            bne.w   .L3
            movea.l ($10,A6),A0
            cmpa.w  #0,A0
            beq.b   .L28
            move.w  A4,(A0)
            move.w  D5,(2,A0)
            move.w  D3,(4,A0)
            move.w  A5,(6,A0)
            move.w  D4,(8,A0)
            move.w  D2,($A,A0)
.L28:
            movem.l (SP)+,D0-D7/A0-A5
            movea.l (4,A6),A0
            unlk    A6
            adda.w  #$20,SP
            jmp     (A0)

            EVEN
