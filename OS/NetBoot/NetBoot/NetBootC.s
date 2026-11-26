            include "Include/ROMHeader.s"

            EXPORT  DOCLOSE,DOOPEN,DOREAD

            IMPORT  AddMyDrive,DoATBootOpen,Glue_Dequeue_DRVR_49,Glue_DisposPtr_DRVR_49,Glue_GetTrapAddress_DRVR_49,Glue_NewPtrSysClear_DRVR_49
            IMPORT  Glue_NGetTrapAddress_DRVR_49,Glue_PBClose_DRVR_49,Glue_PBControl_DRVR_49,Glue_PBHOpen_DRVR_49,Glue_sNextTypesRsrc_DRVR_49,Glue_sReadDrvrName_DRVR_49
            IMPORT  myExtFSFilter,pdbzero,TestPRam_DRVR_49

            SECTION "NetBoot_C",CODE

rwPRAM:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     (TestPRam_DRVR_49.w,PC)
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
            jsr     (Glue_NewPtrSysClear_DRVR_49.w,PC)
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
find_BPTentry:
            link.w  A6,#-$38
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #$38,D0
            move.l  D0,-(SP)
            pea     (-$38,A6)
            jsr     (pdbzero.w,PC)
            move.w  #$28,(-$10,A6)
            move.w  #1,(-$E,A6)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.w  D0,(-$C,A6)
            move.b  #1,(-8,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     (Glue_sNextTypesRsrc_DRVR_49.w,PC)
            move.w  (SP)+,D7
            beq.b   .L1
            move.w  D7,D0
            bra.b   .L2
.L1:
            move.l  ($18,A6),(-$38,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     (Glue_sReadDrvrName_DRVR_49.w,PC)
            move.w  (SP)+,D7
            move.b  (-7,A6),(A3)
            move.b  (-6,A6),(A4)
            movea.l ($14,A6),A0
            move.b  (-5,A6),(A0)
            move.w  D7,D0
.L2:
            movem.l (-$44,A6),D7/A3-A4
            unlk    A6
            rts
FINDNOPENDRIVER:
            link.w  A6,#-$7A
            movem.l D7/A3-A4,-(SP)
            lea     (-$22,A6),A4
            movea.l (8,A6),A3
            moveq   #0,D0
            move.l  D0,(-$7A,A6)
            pea     (-$7A,A6)
            jsr     get_PRAM
            movea.l (-$7A,A6),A0
            moveq   #1,D0
            cmp.b   (1,A0),D0
            addq.l  #4,SP
            bne.b   .L1
            moveq   #$50,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     (pdbzero.w,PC)
            lea     .L8,A0
            move.l  A0,(-$60,A6)
            pea     (-$72,A6)
            jsr     (DoATBootOpen.w,PC)
            move.w  D0,(-$5A,A6)
            lea     ($C,SP),SP
            bra.w   .L3
.L1:
            subq.l  #4,SP
            move.w  #$A06E,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     (Glue_NGetTrapAddress_DRVR_49.w,PC)
            subq.l  #4,SP
            move.w  #$A89F,-(SP)
            jsr     (Glue_GetTrapAddress_DRVR_49.w,PC)
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            beq.b   .L2
            move.l  A4,-(SP)
            pea     (-$73,A6)
            pea     (-$74,A6)
            pea     (-$75,A6)
            movea.l (-$7A,A6),A0
            move.b  (1,A0),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     find_BPTentry
            move.w  D0,D7
            lea     ($14,SP),SP
            bne.b   .L6
            moveq   #$24,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     (pdbzero.w,PC)
            move.b  (-$75,A6),(-$50,A6)
            move.b  (-$74,A6),(-$4F,A6)
            move.l  A4,(-$60,A6)
            subq.l  #2,SP
            pea     (-$72,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     (Glue_PBHOpen_DRVR_49.w,PC)
            move.w  (SP)+,D7
            move.b  (-$75,A6),(1,A3)
            move.b  (-$74,A6),(2,A3)
            addq.l  #8,SP
            bra.b   .L3
.L2:
            moveq   #-$A,D7
            bra.b   .L6
.L3:
            tst.w   D7
            bne.b   .L4
            tst.w   (-$5A,A6)
            bne.b   .L5
.L4:
            tst.w   D7
            bne.b   .L6
            moveq   #-$17,D7
            bra.b   .L6
.L5:
            movea.l (-$7A,A6),A0
            move.b  (1,A0),(A3)
            move.w  (-$5A,A6),(4,A3)
.L6:
            tst.l   (-$7A,A6)
            beq.b   .L7
            move.l  (-$7A,A6),-(SP)
            jsr     (Glue_DisposPtr_DRVR_49.w,PC)
.L7:
            move.w  D7,D0
            movem.l (-$86,A6),D7/A3-A4
            unlk    A6
            rts
.L8:
            dc.b    7,'.ATBOOT'
            dc.w    0
DOOPEN:
            link.w  A6,#-4
            movem.l D6-D7/A3,-(SP)
            movea.l ($C,A6),A3
            pea     (-4,A6)
            jsr     get_PRAM
            tst.w   D0
            addq.l  #4,SP
            bne.b   .L1
            tst.l   (-4,A6)
            bne.b   .L2
.L1:
            moveq   #-$17,D0
            bra.b   .L4
.L2:
            movea.l (-4,A6),A0
            move.b  (3,A0),D7
            move.l  (-4,A6),-(SP)
            jsr     (Glue_DisposPtr_DRVR_49.w,PC)
            ext.w   D7
            ext.l   D7
            move.l  #$80,D0
            and.l   D7,D0
            bne.b   .L3
            moveq   #-$17,D0
            bra.b   .L4
.L3:
            subq.l  #2,SP
            pea     ($4000).w
            move.w  ($A,A6),-(SP)
            move.l  A3,-(SP)
            jsr     (AddMyDrive.w,PC)
            move.w  (SP)+,D6
            moveq   #0,D0
.L4:
            movem.l (-$10,A6),D6-D7/A3
            unlk    A6
            rts
findNRemoveDrive:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.w #$308,A4
            movea.l (2,A4),A3
            bra.b   .L2
.L1:
            movea.l (A3),A3
.L2:
            cmpa.l  (6,A4),A3
            beq.b   .L3
            cmp.w   (8,A3),D7
            bne.b   .L1
.L3:
            cmp.w   (8,A3),D7
            bne.b   .L4
            subq.l  #2,SP
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     (Glue_Dequeue_DRVR_49.w,PC)
            move.l  A3,-(SP)
            jsr     (Glue_DisposPtr_DRVR_49.w,PC)
            addq.l  #2,SP
.L4:
            movem.l (SP)+,D7/A3-A4
            rts
DOCLOSE:
            link.w  A6,#-$50
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     findNRemoveDrive
            tst.w   (4,A3)
            addq.l  #4,SP
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.w  (4,A3),(-$38,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     (Glue_PBClose_DRVR_49.w,PC)
            move.w  (SP)+,D7
.L1:
            tst.l   ($DA,A3)
            beq.b   .L2
            move.l  ($DA,A3),-(SP)
            _CloseCPort
            move.l  ($DA,A3),-(SP)
            jsr     (Glue_DisposPtr_DRVR_49.w,PC)
            moveq   #0,D0
            move.l  D0,($DA,A3)
.L2:
            move.l  A3,-(SP)
            jsr     (Glue_DisposPtr_DRVR_49.w,PC)
            moveq   #0,D0
            movem.l (-$58,A6),D7/A3
            unlk    A6
            rts
DOREAD:
            link.w  A6,#-$82
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            move.w  #$FF,D0
            and.w   (6,A3),D0
            cmpi.w  #2,D0
            beq.b   .L1
            moveq   #-$40,D0
            bra.w   .L8
.L1:
            move.l  A4,-(SP)
            jsr     FINDNOPENDRIVER
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L2
            moveq   #-$40,D0
            bra.w   .L8
.L2:
            move.w  (4,A4),(-$38,A6)
            bne.b   .L3
            moveq   #-$40,D0
            bra.w   .L8
.L3:
            move.w  #1,(-$36,A6)
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.l  ($24,A3),(-$2C,A6)
            move.w  ($2C,A3),(-$24,A6)
            move.l  ($2E,A3),(-$22,A6)
            move.l  ($20,A3),(-$30,A6)
            move.l  ($1C,A3),(-$34,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     (Glue_PBControl_DRVR_49.w,PC)
            move.w  (SP)+,D7
            bne.b   .L4
            move.w  #2,(-$68,A6)
            move.w  (4,A4),(-$6A,A6)
            subq.l  #2,SP
            pea     (-$82,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     (Glue_PBControl_DRVR_49.w,PC)
            move.w  (SP)+,D7
            move.l  ($3F2).w,(8,A4)
            lea     (myExtFSFilter.w,PC),A0
            move.l  A0,($3F2).w
.L4:
            tst.w   D7
            beq.b   .L7
            move.w  D7,(6,A4)
            ble.b   .L5
            moveq   #-$40,D0
            bra.b   .L6
.L5:
            moveq   #-$41,D0
.L6:
            move.w  D0,D7
.L7:
            move.l  (-$28,A6),($28,A3)
            move.w  D7,D0
.L8:
            movem.l (-$8E,A6),D7/A3-A4
            unlk    A6
            rts

            EVEN
