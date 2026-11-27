FlushFile:
            bsr.w   FSQueue
            st      FlushOnly
            bra.b   vFileClose.L1
FileClose:
            move.l  ($7A4).w,-(SP)
            rts
vFileClose:
            bsr.w   FSQueue
            clr.b   FlushOnly
.L1:
            bsr.w   sub_40811C86
            beq.b   .L2
            cmpi.w  #$FFCB,D0
            bne.b   .L3
.L2:
            bsr.b   sub_40811AA2
.L3:
            bra.w   CmdDone
sub_40811AA2:
            move.l  ($6CC).w,-(SP)
            rts
vFClose:
            move.l  (SP)+,-(A6)
            movem.l D1-D3/A0-A5,-(A6)
            bsr.w   TFSVCBTst
            bne.w   .L14
            tst.l   ($22,A1,D1.w)
            beq.b   .L3
            cmpi.l  #$10,(0,A1,D1.w)
            bcc.b   .L3
            move.w  D1,D0
            tst.b   FlushOnly
            bne.b   .L1
            jsr     (BTSvcs.w,PC)
            bra.b   .L2
.L1:
            jsr     (BTFlush.w,PC)
.L2:
            bne.w   .L13
.L3:
            moveq   #0,D0
            tst.w   ($48,A2)
            beq.w   .L11
            cmpi.l  #$10,(0,A1,D1.w)
            bcs.w   .L11
            bclr    #7,(4,A1,D1.w)
            beq.w   .L7
            bsr.w   TstMod1
            bne.b   .L4
            move.l  ($C,A1,D1.w),D3
            moveq   #0,D2
            jsr     (TruncateFile.w,PC)
            bne.w   .L8
            bclr    #7,(4,A1,D1.w)
.L4:
            move.l  A1,-(A6)
            move.l  ($3A,A1,D1.w),D0
            lea     ($3E,A1,D1.w),A0
            moveq   #0,D2
            jsr     (CMGetCN.w,PC)
            movea.l A1,A5
            movea.l (A6)+,A1
            bne.w   .L8
            movem.l A0-A1,-(SP)
            lea     ($26,A1,D1.w),A0
            lea     ($4A,A5),A3
            btst    #9,(4,A1,D1.w)
            beq.b   .L5
            lea     ($56,A5),A3
.L5:
            movea.l A3,A1
            moveq   #$C,D0
            _BlockMove
            movem.l (SP)+,A0-A1
            lea     ($18,A5),A3
            bsr.w   UpDatFlNtry
            move.l  TimeLM,($30,A5)
            jsr     (CMUpdateCN.w,PC)
            bne.b   .L8
            btst    #9,(4,A1,D1.w)
            beq.b   .L7
            cmpi.l  #$80,(8,A1,D1.w)
            bcs.b   .L7
            movem.l D1/A1,-(A6)
            movea.l A0,A3
            movea.l ($54,A2),A1
            move.w  D1,D0
            moveq   #0,D1
            moveq   #0,D2
            jsr     (GetBlock.w,PC)
            bne.b   .L6
            move.l  A0,-(SP)
            lea     ($30,A0),A1
            lea     (6,A3),A0
            moveq   #$20,D0
            _BlockMove
            moveq   #$20,D0
            adda.l  D0,A1
            lea     (2,A5),A0
            moveq   #$12,D0
            _BlockMove
            moveq   #$12,D0
            adda.l  D0,A1
            lea     ($38,A5),A0
            moveq   #$10,D0
            _BlockMove
            moveq   #$10,D0
            adda.l  D0,A1
            move.l  ($2C,A5),(A1)+
            move.l  ($1A,A5),(A1)+
            move.l  ($24,A5),(A1)+
            movea.l (SP)+,A0
            movea.l ($54,A2),A1
            moveq   #4,D1
            jsr     (RelBlock.w,PC)
.L6:
            movem.l (A6)+,D1/A1
.L7:
            moveq   #0,D0
.L8:
            movem.l D0-D1/A1,-(A6)
            move.w  D1,D0
            moveq   #0,D1
            tst.b   FlushOnly
            bne.b   .L9
            moveq   #1,D1
.L9:
            movea.l ($54,A2),A1
            jsr     (FlushCache.w,PC)
            bsr.w   TFSVCBTst
            beq.b   .L10
            bsr.w   sub_40810C48
.L10:
            movem.l (A6)+,D0-D1/A1
.L11:
            tst.b   FlushOnly
            bne.b   .L13
            lea     (0,A1,D1.w),A3
            moveq   #0,D2
            move.w  FSFCBLen,D2
            lsr.w   #1,D2
            subq.w  #1,D2
.L12:
            clr.w   (A3)+
            dbra    D2,.L12
.L13:
            movem.l (A6)+,D1-D3/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
.L14:
            bclr    #7,(4,A1,D1.w)
            beq.b   .L7
            move.w  ($1C,A1,D1.w),D3
            bsr.w   sub_40811A50
            bne.b   .L8
            moveq   #0,D0
            move.l  (0,A1,D1.w),D3
.L15:
            cmp.l   ($12,A5,D0.w),D3
            beq.b   .L16
            bsr.w   sub_40810C92
            bcs.b   .L15
            moveq   #-$2B,D0
            bra.b   .L8
.L16:
            lea     ($16,A5,D0.w),A3
            bsr.b   UpDatFlNtry
            move.l  TimeLM,($2E,A5,D0.w)
            jsr     (MarkA5Block.w,PC)
            bra.w   .L7
UpDatFlNtry:
            move.l  A4,-(SP)
            lea     (4,A1,D1.w),A4
            move.w  (A4)+,D3
            lsl.w   #7,D3
            bcc.b   .L1
            lea     ($A,A3),A3
.L1:
            move.w  (A4)+,(A3)+
            move.l  (A4)+,(A3)+
            move.l  (A4)+,(A3)+
            movea.l (SP)+,A4
            rts
GetEOF:
            bsr.w   FSQueue
            bsr.b   sub_40811C86
            bne.b   .L1
            move.l  (8,A1,D1.w),($1C,A0)
.L1:
            bra.w   CmdDone
sub_40811C86:
            move.l  ($790).w,-(SP)
            rts
vRfNCall:
            movea.l ($34E).w,A1
            moveq   #0,D1
            move.w  ($18,A0),D1
            bsr.b   CkFileRfn
            bne.b   .L1
            move.l  (0,A1,D1.w),D2
            movea.l ($14,A1,D1.w),A2
            move.l  A2,($3EE).w
            bsr.w   ExtOffLinCk
.L1:
            tst.w   D0
            rts
CkFileRfn:
            moveq   #-$33,D0
            moveq   #0,D2
            move.w  D1,D2
            divu.w  FSFCBLen,D2
            swap    D2
            subq.w  #2,D2
            bne.b   .L1
            cmp.w   (A1),D1
            bcc.b   .L1
            moveq   #-$26,D0
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
TstMod:
            move.l  ($7C4).w,-(SP)
            rts
vTstMod:
            bsr.b   sub_40811C86
            bne.b   TstMod1.L1
TstMod1:
            moveq   #-$3D,D0
            btst    #0,(4,A1,D1.w)
            beq.b   .L1
            bsr.w   CVFlgs
.L1:
            tst.w   D0
            rts
GetFCBInfo:
            bsr.w   FSQueue
            bsr.b   FndFCB
            bne.b   .L2
            move.w  D1,($18,A0)
            lea     (0,A1,D1.w),A3
            move.l  A0,-(SP)
            lea     ($20,A0),A1
            movea.l A3,A0
            moveq   #$14,D0
            _BlockMove
            movea.l (SP)+,A0
            move.w  ($4E,A2),($34,A0)
            move.l  ($1E,A3),($36,A0)
            move.l  ($3A,A3),($3A,A0)
            move.l  ($12,A0),D0
            beq.b   .L1
            movea.l D0,A1
            move.l  A0,-(SP)
            lea     ($3E,A3),A0
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            movea.l (SP)+,A0
.L1:
            move.l  A2,($3EE).w
            move.l  A3,D1
            bsr.w   sub_4080FEFA
.L2:
            bra.w   CmdDone
FndFCB:
            movea.l ($34E).w,A1
            move.w  ($18,A0),D1
            move.w  ($1C,A0),D0
            beq.b   .L6
            moveq   #0,D2
            move.w  ($16,A0),D2
            beq.b   .L1
            move.w  D2,D0
            bsr.w   DtrmV1
            bne.b   .L7
            move.l  A2,D2
            move.w  ($1C,A0),D0
.L1:
            bsr.w   sub_408108C6
.L2:
            move.l  (0,A1,D1.w),D3
            beq.b   .L5
            movea.l ($14,A1,D1.w),A2
            bsr.w   TFSVCBTst
            bne.b   .L3
            cmpi.l  #$10,D3
            bcs.b   .L5
.L3:
            tst.l   D2
            beq.b   .L4
            cmp.l   ($14,A1,D1.w),D2
            bne.b   .L5
.L4:
            subq.w  #1,D0
            beq.b   .L6
.L5:
            bsr.w   sub_408108CE
            bcs.b   .L2
            moveq   #-$26,D0
            bra.b   .L7
.L6:
            bsr.w   CkFileRfn
            movea.l ($14,A1,D1.w),A2
.L7:
            tst.w   D0
            rts
            bsr.w   FSQueue
            bsr.w   sub_40811C86
            bne.b   .L8
            moveq   #0,D0
.L8:
            bra.w   CmdDone
toAlloc:
            moveq   #0,D0
            bsr.w   TFSVCBTst
            bne.w   GtNxBlk.L2
            bsr.w   sub_408117DE
            beq.b   .L1
            moveq   #2,D0
.L1:
            bra.w   sub_40811EF2.L1
FileAlloc:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L2
            moveq   #0,D6
            move.l  ($24,A0),D4
            beq.b   .L1
            tst.w   ($2A,A2)
            beq.b   .L1
            bsr.b   toAlloc
            bne.b   .L2
.L1:
            move.l  D6,($28,A0)
            bsr.b   sub_40811E64
            moveq   #-$22,D0
            cmp.l   ($24,A0),D6
            bcs.b   .L2
            moveq   #0,D0
.L2:
            bra.w   CmdDone
SetEOF:
            bsr.w   FSQueue
            bsr.w   TstMod
            bne.b   .L4
            move.l  ($1C,A0),D7
            move.l  D7,D4
            sub.l   ($C,A1,D1.w),D4
            bhi.b   .L7
            bcs.b   .L5
.L1:
            bsr.w   sub_408117DE
            beq.b   .L2
            cmp.l   (8,A1,D1.w),D7
            bcc.b   .L3
.L2:
            move.l  D7,(8,A1,D1.w)
            cmp.l   ($10,A1,D1.w),D7
            bcc.b   .L3
            move.l  D7,($10,A1,D1.w)
.L3:
            bsr.b   sub_40811E64
            moveq   #0,D0
.L4:
            bra.w   CmdDone
.L5:
            bsr.w   sub_408117E6
            bne.b   vAdjEOF.L4
            move.l  D7,D4
            move.l  D4,D3
            moveq   #1,D2
            jsr     (TruncateFile.w,PC)
            bne.b   .L4
.L6:
            movem.l D0-D2,-(A6)
            move.w  D1,D0
            move.l  ($C,A1,D1.w),D1
            moveq   #-1,D2
            jsr     (TrashBlocks.w,PC)
            movem.l (A6)+,D0-D2
            bra.b   .L1
.L7:
            jsr     sub_40811EF2
            bne.b   .L4
            bra.b   .L1
sub_40811E64:
            move.l  ($794).w,-(SP)
            rts
vAdjEOF:
            movem.l D0-D6/A0-A5,-(SP)
            adda.w  D1,A1
            move.l  (A1)+,D2
            bset    #7,(A1)
            move.w  (A1),D0
            movem.l (A1)+,D3-D6/A2
            move.w  D0,D6
            lea     ($E,A1),A1
            movem.l (A1)+,A3-A5
            bsr.w   Gt1stMatch
            bne.b   .L3
.L1:
            lea     (4,A1,D1.w),A0
            move.w  (A0)+,D0
            eor.w   D6,D0
            lsl.w   #7,D0
            bcs.b   .L2
            move.w  D3,(A0)+
            move.l  D4,(A0)+
            move.l  D5,(A0)+
            lea     ($22,A0),A0
            movem.l A3-A5,-(A0)
.L2:
            bsr.w   GtNxtMatch
            beq.b   .L1
.L3:
            movem.l (SP)+,D0-D6/A0-A5
            rts
