            include "Include/ROMHeader.s"

            EXPORT  DoATControl

            IMPORT  generate_hash,get_image,GetsBoxBase,Glue_BlockMove_DRVR_50,Glue_DisposPtr_DRVR_50,Glue_GetPtrSize_DRVR_50
            IMPORT  Glue_NewPtrSysClear_DRVR_50,TestPRam

            SECTION "ATBoot_C",CODE

rwPRAM:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     (TestPRam.w,PC)
            moveq   #0,D0
            movea.l (-4,A6),A3
            unlk    A6
            rts
get_PRAM:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            subq.l  #4,SP
            moveq   #$48,D0
            move.l  D0,-(SP)
            jsr     (Glue_NewPtrSysClear_DRVR_50.w,PC)
            move.l  (SP)+,(A3)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.b   .L2
.L1:
            moveq   #1,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     rwPRAM
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
compare_signature:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($14,A6),D6
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            bra.b   .L2
.L1:
            addq.w  #1,D7
.L2:
            cmpi.w  #2,D7
            bge.b   .L3
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            cmpi.l  #'PWD ',(A0)
            beq.b   .L1
.L3:
            cmpi.w  #2,D7
            blt.b   .L5
            tst.l   ($10,A6)
            beq.b   .L4
            move.l  D6,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D6,D1
            add.l   ($10,A6),D1
            moveq   #$10,D2
            sub.l   D2,D1
            move.l  D1,-(SP)
            move.l  A4,-(SP)
            jsr     compare_signature
            lea     ($10,SP),SP
            bra.b   .L10
.L4:
            moveq   #-5,D0
            bra.b   .L10
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            moveq   #8,D0
            move.l  D0,-(SP)
            jsr     (Glue_BlockMove_DRVR_50.w,PC)
            moveq   #0,D0
            bra.b   .L10
.L5:
            clr.w   D7
            bra.b   .L7
.L6:
            addq.w  #1,D7
.L7:
            cmpi.w  #2,D7
            bge.b   .L8
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A4,D0
            movea.l D0,A1
            move.l  (A0),D0
            cmp.l   (A1),D0
            beq.b   .L6
.L8:
            cmpi.w  #2,D7
            blt.b   .L9
            moveq   #0,D0
            bra.b   .L10
.L9:
            moveq   #-5,D0
.L10:
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
copy_userName:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            clr.b   D7
            movea.l A4,A3
.L1:
            tst.b   (A4)+
            beq.b   .L2
            move.b  D7,D0
            addq.b  #1,D7
            cmpi.b  #$1F,D0
            blt.b   .L1
.L2:
            cmpi.b  #$1F,D7
            blt.b   .L3
            moveq   #$1F,D7
.L3:
            move.l  A3,-(SP)
            move.l  ($C,A6),D0
            addq.l  #1,D0
            move.l  D0,-(SP)
            ext.w   D7
            ext.l   D7
            move.l  D7,-(SP)
            jsr     (Glue_BlockMove_DRVR_50.w,PC)
            movea.l ($C,A6),A0
            move.b  D7,(A0)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
get_the_image:
            link.w  A6,#-$36
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            movea.l ($26A,A3),A0
            move.b  (A0),D0
            ext.w   D0
            move.w  D0,(-$30,A6)
            pea     (-$2A,A6)
            movea.l ($26A,A3),A0
            pea     ($16,A0)
            jsr     copy_userName
            movea.l ($26A,A3),A0
            tst.b   (5,A0)
            addq.l  #8,SP
            bne.b   .L1
            movea.l ($26A,A3),A0
            move.b  #2,(5,A0)
.L1:
            pea     ($1C,A3)
            pea     ($18,A3)
            pea     (4,A3)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (4,A0),D0
            move.l  D0,-(SP)
            pea     (-$32,A6)
            movea.l ($26A,A3),A0
            move.w  ($3E,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (5,A0),D0
            muls.w  #$3C,D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     (get_image.w,PC)
            move.w  D0,D7
            lea     ($1C,SP),SP
            bne.w   .L6
            moveq   #0,D0
            move.l  D0,(-$36,A6)
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     (Glue_GetPtrSize_DRVR_50.w,PC)
            move.l  (SP)+,D0
            moveq   #$40,D1
            sub.l   D1,D0
            move.l  D0,-(SP)
            pea     (8,A3)
            move.l  (4,A3),-(SP)
            pea     (-$36,A6)
            jsr     (GetsBoxBase.w,PC)
            move.l  D0,-(SP)
            jsr     (generate_hash.w,PC)
            move.w  D0,D7
            lea     ($14,SP),SP
            beq.b   .L2
            move.w  D7,D0
            bra.b   .L7
.L2:
            move.l  (-$36,A6),-(SP)
            jsr     (Glue_DisposPtr_DRVR_50.w,PC)
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     (Glue_GetPtrSize_DRVR_50.w,PC)
            move.l  (4,A3),-(SP)
            movea.l ($26A,A3),A0
            pea     (6,A0)
            pea     (8,A3)
            jsr     compare_signature
            move.w  D0,D7
            lea     ($10,SP),SP
            beq.b   .L3
            move.l  (4,A3),-(SP)
            jsr     (Glue_DisposPtr_DRVR_50.w,PC)
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.w  D7,D0
            bra.b   .L7
.L3:
            tst.l   (4,A3)
            beq.b   .L4
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #1,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L5
.L4:
            moveq   #-6,D7
.L5:
            tst.w   D7
            beq.b   .L6
            move.w  D7,D0
            bra.b   .L7
.L6:
            move.w  D7,D0
.L7:
            movem.l (-$3E,A6),D7/A3
            unlk    A6
            rts
DoATControl:
            link.w  A6,#-8
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            move.w  (2,A3),D7
            tst.l   ($26A,A3)
            bne.b   .L1
            pea     ($26A,A3)
            jsr     get_PRAM
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L1
            move.w  D7,D0
            bra.w   .L14
.L1:
            move.w  ($1A,A4),D0
            subq.w  #1,D0
            bmi.w   .L11
            cmpi.w  #4,D0
            bgt.w   .L11
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
            dc.w    .L5-(.L2+2)
            dc.w    .L7-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L10-(.L2+2)
.L4:
            move.l  A3,-(SP)
            jsr     get_the_image
            move.w  D0,D7
            addq.l  #4,SP
            bne.b   .L12
            pea     ($BA,A3)
            move.l  ($20,A4),-(SP)
            move.l  ($24,A4),-(SP)
            jsr     (Glue_BlockMove_DRVR_50.w,PC)
            bra.b   .L12
.L5:
            tst.l   (4,A3)
            beq.b   .L6
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L12
.L6:
            moveq   #-6,D7
            bra.b   .L12
.L7:
            tst.l   (4,A3)
            beq.b   .L8
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #3,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bne.b   .L12
            move.l  (-8,A6),($1C,A4)
            move.l  (-4,A6),($20,A4)
            bra.b   .L12
.L8:
            moveq   #-6,D7
            bra.b   .L12
.L9:
            moveq   #-$32,D7
            bra.b   .L12
.L10:
            move.l  A3,($1C,A4)
            bra.b   .L12
.L11:
            moveq   #-$32,D7
.L12:
            movea.l ($26A,A3),A0
            moveq   #$40,D0
            and.b   (3,A0),D0
            bne.b   .L13
            movea.l ($26A,A3),A0
            tst.w   ($3E,A0)
            beq.b   .L13
            tst.w   D7
            beq.b   .L13
            move.w  ($26E,A3),D0
            addq.w  #1,($26E,A3)
            cmpi.w  #5,D0
            blt.b   .L13
            movea.l ($26A,A3),A0
            addq.l  #6,A0
            move.l  A0,(-8,A6)
            addq.l  #4,(-8,A6)
            move.l  #'PWD ',(A0)
            movea.l (-8,A6),A0
            move.l  #'PWD ',(A0)
            movea.l ($26A,A3),A0
            clr.w   ($3E,A0)
            movea.l ($26A,A3),A0
            clr.b   ($16,A0)
            clr.w   ($26E,A3)
            move.w  D7,($270,A3)
.L13:
            move.w  D7,D0
.L14:
            movem.l (-$14,A6),D7/A3-A4
            unlk    A6
            rts

            EVEN
