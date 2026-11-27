sub_40810CA8:
            movea.l ($372).w,A1
            moveq   #2,D1
            rts
sub_40810CB0:
            addi.w  #$10,D1
            cmp.w   (A1),D1
            rts
sub_40810CB8:
            bsr.b   sub_40810CA8
.L1:
            cmpa.l  (0,A1,D1.w),A2
            beq.b   sub_40810CC0.L1
sub_40810CC0:
            bsr.b   sub_40810CB0
            bcs.b   sub_40810CB8.L1
            move    #0,CCR
.L1:
            rts
CkDirBusy:
            movem.l D2/A1,-(SP)
            move.l  (6,A5),D2
            bsr.b   sub_40810CB8
.L1:
            bne.b   .L2
            cmp.l   (4,A1,D1.w),D2
            beq.b   .L4
            bsr.b   sub_40810CC0
            bra.b   .L1
.L2:
            moveq   #0,D0
.L3:
            movem.l (SP)+,D2/A1
            rts
.L4:
            move.w  D1,($18,A0)
            moveq   #-$2F,D0
            bra.b   .L3
CkFileBusy:
            move.l  A1,-(SP)
            move.l  ($14,A5),D2
            bsr.w   TFSVCBTst
            beq.b   .L1
            move.l  ($12,A5),D2
.L1:
            bsr.w   Gt1stMatch
            beq.b   .L3
            moveq   #0,D0
.L2:
            movea.l (SP)+,A1
            rts
.L3:
            move.w  D1,($18,A0)
            moveq   #-$2F,D0
            bra.b   .L2
FileDelete:
            bsr.w   FSQueue
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   TFMove.L11
            moveq   #-$2D,D0
            btst    #0,(2,A5)
            bne.b   .L6
            bclr    #1,($376).w
            cmpi.b  #1,(A5)
            bne.b   .L1
            bset    #1,($376).w
            bsr.b   CkDirBusy
            bra.b   .L2
.L1:
            cmpi.b  #2,(A5)
            bne.b   .L3
            move.l  D2,-(A6)
            bsr.b   CkFileBusy
            move.l  (A6)+,D2
            tst.w   D0
.L2:
            bne.b   .L6
.L3:
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D7,D2
            cmpi.b  #2,(A5)
            bne.b   .L4
            move.l  ($14,A5),D0
            jsr     (TrashFBlocks.w,PC)
            move.l  D6,D0
            jsr     (DeAllocFile.w,PC)
            bne.b   .L6
.L4:
            move.l  D6,D0
            jsr     (CMDeleteCN.w,PC)
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            cmpi.w  #$32,D0
            bne.b   .L5
            moveq   #-$2F,D0
            bra.b   .L6
.L5:
            cmpi.w  #$33,D0
            bne.b   .L6
            moveq   #-$32,D0
.L6:
            bra.w   CmdDone
ReName:
            bsr.w   FSQueue
            move.l  ($1C,A0),D2
            bsr.w   sub_40810056
            bne.w   .L13
            tst.w   D2
            beq.w   .L14
            movea.l A2,A1
            move.w  D3,D7
            movem.l D2/A4,($3D6).w
            bsr.w   DtrmV3
            bne.b   .L2
            cmpa.l  A1,A2
            beq.b   .L4
            tst.w   D7
            beq.b   .L4
.L1:
            moveq   #-$25,D0
.L2:
            cmpi.w  #$21,D0
            bne.b   .L3
            moveq   #-$30,D0
.L3:
            bra.w   CmdDone
.L4:
            bsr.w   CVFlgs
            bne.b   .L2
            bsr.w   TFSVCBTst
            bne.w   sub_40811094.L3
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #-$2D,D0
            btst    #0,(2,A5)
            bne.b   .L2
            move.l  D6,D4
            move.l  D7,D5
            movem.l D2/D4-D5/A4,-(A6)
            move.l  ($12,A0),-(A6)
            move.l  ($1C,A0),D2
            move.l  D2,($12,A0)
            bsr.w   FndFilName
            movem.l D2/A4,($3D6).w
            move.l  (A6)+,($12,A0)
            movem.l (A6)+,D2/D4-D5/A4
            tst.w   D0
            bne.b   .L6
            move.l  A0,-(SP)
            movem.l D2/A4,-(A6)
            move.w  D2,D0
            movea.l A4,A0
            swap    D0
            movem.l ($3D6).w,D2/A4
            move.w  D2,D0
            movea.l A4,A1
            _CmpString
            movem.l (A6)+,D2/A4
            movea.l (SP)+,A0
            bne.b   .L5
            cmp.l   D4,D6
            beq.b   .L7
.L5:
            moveq   #-$30,D0
.L6:
            cmpi.w  #$FFD5,D0
            bne.b   .L2
            cmp.l   D4,D6
            bne.w   .L1
.L7:
            bsr.w   PushCName
            move.l  D2,-(SP)
            movea.l A0,A1
            movem.l ($3D6).w,D2/A4
            bsr.w   PushCName
            move.l  (SP)+,-(A6)
            move.l  D2,-(A6)
            exg     A0,A1
            move.l  D4,D0
            move.l  D5,D2
            jsr     (CMRenameCN.w,PC)
            move.l  D2,D7
            tst.w   D0
            bne.b   .L9
            cmpi.l  #1,D4
            beq.b   .L8
            cmpi.l  #2,D4
            bne.b   .L9
            tst.l   (4,A6)
            bgt.b   .L9
.L8:
            bsr.w   SetVolName
            moveq   #0,D0
            moveq   #1,D6
.L9:
            move.l  (A6)+,D2
            move.l  (A6)+,-(SP)
            bsr.w   sub_40810B96
            move.l  (SP)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            bne.w   .L2
            cmpi.l  #1,D6
            beq.w   .L2
            movem.l ($3D6).w,D2/A4
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            jsr     (CMGetCN.w,PC)
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            bne.w   .L2
            move.b  D2,D3
            movea.l A1,A5
            movea.l A4,A0
            move.l  ($14,A5),D2
            bsr.w   Gt1stMatch
            bne.w   .L2
.L10:
            move.l  D7,($36,A1,D1.w)
            lea     ($3E,A1,D1.w),A1
            move.b  D3,(A1)+
            moveq   #0,D0
            move.b  D3,D0
            _BlockMove
            movea.l ($34E).w,A1
            bsr.w   GtNxtMatch
            beq.b   .L10
.L11:
            moveq   #0,D0
.L12:
            bra.w   .L2
.L13:
            cmpi.w  #$FFDD,D0
            bne.b   .L12
            tst.w   D2
            bne.w   .L1
.L14:
            tst.w   D3
            beq.b   .L12
            bsr.w   DtrmV3
            bne.b   .L12
            bsr.w   CVFlgs
            bne.b   .L12
            cmpi.w  #$4244,(8,A2)
            beq.b   .L15
            tst.w   ($48,A2)
            beq.b   .L12
            bra.b   .L16
.L15:
            bsr.w   ExtOffLinCk
            bne.b   .L12
.L16:
            movea.l ($1C,A0),A1
            bsr.w   SetVolName
            bsr.w   TFSVCBTst
            bne.b   .L11
            moveq   #0,D2
            moveq   #2,D0
            movea.l D2,A0
            lea     ($2C,A2),A1
            jsr     (CMRenameCN.w,PC)
            bra.w   .L2
TFMove:
            bsr.w   FSQueue
            move.l  ($12,A0),-(A6)
            move.l  ($1C,A0),($12,A0)
            bsr.w   DtrmV3
            move.l  (A6)+,($12,A0)
            movea.l A2,A1
            move.w  D3,D7
            bsr.w   DtrmV3
            bne.b   .L2
            cmpa.l  A1,A2
            beq.b   .L3
            tst.w   D7
            beq.b   .L3
.L1:
            moveq   #-$25,D0
.L2:
            bra.w   CmdDone
.L3:
            bsr.w   CVFlgs
            bne.b   .L2
            bsr.w   ExtOffLinCk
            bne.b   .L2
            moveq   #-$32,D0
            bsr.w   TFSVCBTst
            bne.b   .L2
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #0,D3
            cmpi.b  #2,(A5)
            bne.b   .L4
            move.l  ($14,A5),D3
.L4:
            move.l  D6,D4
            move.l  D7,D5
            movem.l D2/A4,($3D6).w
            move.l  ($12,A0),-(A6)
            move.l  ($30,A0),-(A6)
            move.l  ($1C,A0),($12,A0)
            move.l  ($24,A0),($30,A0)
            movem.l D3-D5,-(A6)
            bsr.w   FndFilName
            movem.l (A6)+,D3-D5
            move.l  (A6)+,($30,A0)
            move.l  (A6)+,($12,A0)
            tst.w   D0
            beq.b   .L5
            cmpi.w  #$FFDB,D0
            bne.b   .L2
            tst.w   D2
            bne.b   .L1
            bra.b   .L6
.L5:
            cmpi.b  #1,(A5)
            bne.b   .L1
            move.l  (6,A5),D6
            moveq   #0,D7
.L6:
            movem.l ($3D6).w,D2/A4
            cmp.l   D4,D6
            beq.b   .L10
            bsr.w   PushCName
            move.l  D2,-(A6)
            move.l  D3,-(A6)
            move.l  D4,D0
            move.l  D5,D2
            move.l  D6,D1
            move.l  D7,D3
            suba.l  A1,A1
            jsr     (CMMoveCN.w,PC)
            move.l  D2,D7
            move.l  (A6)+,D3
            move.l  (A6)+,D2
            bsr.w   sub_40810B96
            tst.w   D0
            beq.b   .L8
            cmpi.w  #$31,D0
            bne.b   .L7
            moveq   #-$30,D0
.L7:
            bra.w   .L2
.L8:
            move.l  D3,D2
            beq.b   .L10
            bsr.w   Gt1stMatch
            bne.b   .L10
.L9:
            move.l  D7,($36,A1,D1.w)
            move.l  D6,($3A,A1,D1.w)
            bsr.w   GtNxtMatch
            beq.b   .L9
.L10:
            moveq   #0,D0
            bra.w   .L2
