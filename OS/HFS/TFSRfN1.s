sub_408117DE:
            btst    #9,(6,A0)
            rts
sub_408117E6:
            movea.l ($14,A1,D1.w),A2
TFSVCBTst:
            cmpi.w  #$4244,(8,A2)
            rts
Seek:
            clr.l   ($28,A0)
            moveq   #-$32,D0
            move.l  ($24,A0),D7
            bmi.b   .L6
            move.l  ($2E,A0),D2
            move.l  ($10,A1,D1.w),D5
            move.l  (8,A1,D1.w),D4
            move.b  ($2D,A0),D0
            roxr.b  #2,D0
            bcc.b   .L2
            bmi.b   .L1
            move.l  D4,D5
.L1:
            add.l   D2,D5
            bra.b   .L3
.L2:
            bpl.b   .L3
            move.l  D2,D5
.L3:
            bpl.b   .L4
            moveq   #-$28,D0
            bra.b   .L6
.L4:
            move.l  D5,D2
            sub.l   D4,D2
            ble.b   .L5
            move.l  D4,D5
.L5:
            move.l  D5,($10,A1,D1.w)
            moveq   #0,D0
.L6:
            rts
GetFPos:
            clr.b   ($2D,A0)
SetFPos:
            clr.l   ($24,A0)
FileRead:
            move.l  ($7A8).w,-(SP)
            rts
vFileRead:
            bsr.w   FSQueue
            bsr.w   sub_40811C86
            bne.w   .L9
            bsr.b   Seek
            bne.b   .L8
            neg.l   D2
            bmi.b   .L7
            cmp.l   D2,D7
            ble.b   .L1
            move.l  D2,D7
.L1:
            tst.l   D7
            beq.b   .L5
            move.w  ($2C,A0),D2
            lsr.w   #8,D2
            bcs.b   .L10
            btst    #6,($2D,A0)
            beq.b   .L2
            movem.l D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            movea.l ($54,A2),A1
            st      ($377).w
            jsr     (FlushCache.w,PC)
            movem.l (A6)+,D1/A1
.L2:
            move.w  D5,D2
            andi.w  #$1FF,D2
            beq.b   .L4
.L3:
            bsr.w   RdFileBlk
            bne.b   .L6
            btst    #6,($2D,A0)
            sne     D0
            bsr.w   DoPart
            bne.b   .L6
.L4:
            move.l  D7,D4
            beq.b   .L5
            andi.w  #$FE00,D4
            tst.l   D4
            beq.b   .L3
            jsr     (CacheRdIP.w,PC)
            bne.b   .L6
            bsr.w   sub_408119DE
            bra.b   .L4
.L5:
            moveq   #0,D0
.L6:
            tst.w   D0
            bne.b   .L8
            move.l  ($28,A0),D2
            cmp.l   ($24,A0),D2
            beq.b   .L8
.L7:
            moveq   #-$27,D0
.L8:
            move.l  D5,($10,A1,D1.w)
            move.l  D5,($2E,A0)
.L9:
            bra.w   CmdDone
.L10:
            bsr.b   RdFileBlk
            bne.b   .L6
            move.l  D5,D2
            andi.w  #$1FF,D2
            movea.l ($20,A0),A3
            move.l  ($28,A0),D4
.L11:
            move.b  (0,A5,D2.w),D0
            move.b  D0,(0,A3,D4.l)
            addq.l  #1,($28,A0)
            addq.l  #1,D4
            addq.w  #1,D2
            addq.l  #1,D5
            cmp.b   ($2C,A0),D0
            bne.b   .L12
            moveq   #0,D0
            bra.b   .L8
.L12:
            subq.l  #1,D7
            beq.b   .L5
            cmp.w   D6,D2
            bcs.b   .L11
            bra.b   .L10
sub_40811912:
            bsr.b   ReadBlock_TFSRFN1
            cmp.l   D3,D5
            bcs.b   RdFileBlk.L1
            moveq   #4,D1
            bra.b   RdFileBlk.L1
RdFileBlk:
            bsr.b   ReadBlock_TFSRFN1
            btst    #6,($2D,A0)
            beq.b   .L1
            moveq   #1,D1
.L1:
            movea.l ($54,A2),A1
            move.l  D5,D2
            lsr.l   #8,D2
            lsr.l   #1,D2
            rts
ReadBlock_TFSRFN1:
            movem.l D1-D2/A0-A1,-(A6)
            movea.l (SP)+,A1
            move.l  (SP)+,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            moveq   #2,D6
            lsl.l   #8,D6
            jsr     (A1)
            addq.b  #8,D1
            jsr     (GetBlock.w,PC)
            movea.l A0,A5
            move.l  (A6)+,-(SP)
            movem.l (A6)+,D1-D2/A0-A1
            tst.w   D0
            rts
FileWrite:
            move.l  ($7AC).w,-(SP)
            rts
vFileWrite:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L10
            bsr.w   Seek
            bne.b   .L2
            tst.l   D2
            bmi.b   .L1
            add.l   D2,D5
.L1:
            move.l  #$1FF,D3
            add.l   D4,D3
            andi.w  #$FE00,D3
            move.l  D5,D4
            add.l   D7,D4
            cmp.l   (8,A1,D1.w),D4
            bls.b   .L4
            sub.l   ($C,A1,D1.w),D4
            bls.b   .L3
            bsr.w   sub_40811EF2
.L2:
            bne.b   .L9
.L3:
            move.l  D5,D4
            add.l   D7,D4
            move.l  D4,(8,A1,D1.w)
.L4:
            move.w  D5,D0
            andi.w  #$1FF,D0
            beq.b   .L6
.L5:
            bsr.w   sub_40811912
            bne.b   .L8
            moveq   #1,D0
            bsr.b   DoPart
            jsr     (MarkA5Block.w,PC)
.L6:
            move.l  D7,D4
            beq.b   .L7
            andi.w  #$FE00,D4
            tst.l   D4
            beq.b   .L5
            jsr     (CacheWrIP.w,PC)
            bne.b   .L8
            bsr.b   sub_408119DE
            bra.b   .L6
.L7:
            moveq   #0,D0
.L8:
            bsr.w   sub_40811E64
            move.l  D5,($10,A1,D1.w)
.L9:
            move.l  ($10,A1,D1.w),($2E,A0)
.L10:
            bra.w   CmdDone
sub_408119DE:
            sub.l   D6,D7
            add.l   D6,($28,A0)
            add.l   D6,D5
            rts
DoPart:
            move.l  D5,D2
            andi.w  #$1FF,D2
            sub.w   D2,D6
            cmp.l   D6,D7
            bcc.b   .L1
            move.l  D7,D6
.L1:
            movea.l ($20,A0),A3
            adda.l  ($28,A0),A3
            bsr.b   sub_408119DE
            movem.l D1/A0-A2,-(SP)
            movea.l A3,A0
            movea.l A5,A1
            adda.w  D2,A1
            tst.b   D0
            bgt.b   .L2
            bmi.b   .L5
            exg     A0,A1
.L2:
            move.l  D6,D0
            movea.l ($4B8).w,A2
            jsr     (A2)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1/A0-A2
            rts
.L5:
            moveq   #-$24,D0
            subq.w  #1,D6
.L6:
            cmpm.b  (A0)+,(A1)+
            dbne    D6,.L6
            bne.b   .L4
            bra.b   .L3
