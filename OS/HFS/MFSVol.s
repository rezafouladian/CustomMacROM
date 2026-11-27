.L4:
            moveq   #$5E,D0
            movea.l A2,A0
            _SetPtrSize
            moveq   #3,D2
            mulu.w  ($1A,A2),D2
            addq.l  #1,D2
            lsr.l   #1,D2
            move.w  D2,($58,A2)
            moveq   #$40,D7
            move.l  D2,D0
            _NewPtrSys
            bne.w   vCheckRemount.L19
            move.l  A0,($50,A2)
            moveq   #2,D3
.L5:
            move.w  (0,A5,D7.w),(A0)+
            addq.w  #2,D7
            subq.w  #2,D2
            ble.b   .L6
            cmpi.w  #$200,D7
            bcs.b   .L5
            addq.w  #1,D3
            bsr.w   sub_40811A5E
            bne.b   .L8
            moveq   #0,D7
            bra.b   .L5
.L6:
            bsr.b   CkMFSMap
            beq.b   CkMFSMap.L4
.L7:
            moveq   #-$3C,D0
.L8:
            bsr.b   sub_408106CA
            bra.w   vCheckRemount.L19
sub_408106CA:
            movem.l D0/A0,-(SP)
            movea.l ($50,A2),A0
            _DisposPtr
            clr.l   ($50,A2)
            movem.l (SP)+,D0/A0
            rts
CkMFSMap:
            moveq   #2,D3
            moveq   #0,D1
.L1:
            bsr.w   GtNxBlk
            bne.b   .L2
            addq.w  #1,D1
.L2:
            cmp.w   ($1A,A2),D3
            bhi.b   .L3
            addq.w  #1,D3
            bra.b   .L1
.L3:
            cmp.w   ($2A,A2),D1
            rts
.L4:
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D7
            bsr.w   sub_40811A30
            bne.b   sub_40810604.L8
.L5:
            tst.b   (A5)
            bne.b   .L6
            movea.l A5,A0
            exg     D1,D6
            moveq   #2,D1
            jsr     (RelBlock.w,PC)
            exg     D1,D6
.L6:
            moveq   #0,D0
.L7:
            tst.b   (0,A5,D0.w)
            beq.b   .L9
            addq.w  #1,D1
            cmp.l   ($12,A5,D0.w),D2
            bhi.b   .L8
            move.l  ($12,A5,D0.w),D2
.L8:
            lea     ($16,A5,D0.w),A3
            bsr.b   CkFilLen
            bne.b   sub_40810604.L7
            lea     ($20,A5,D0.w),A3
            bsr.b   CkFilLen
            bne.b   sub_40810604.L7
            bsr.w   sub_40810C92
            bcs.b   .L7
.L9:
            bsr.w   sub_40811A40
            beq.b   .L5
            cmpi.w  #$FFDF,D0
            bne.w   sub_40810604.L8
            cmp.l   ($26,A2),D2
            bcs.b   .L10
            addq.l  #1,D2
            move.l  D2,($26,A2)
            addq.b  #1,D7
.L10:
            cmp.w   ($14,A2),D1
            beq.b   .L11
            move.w  D1,($14,A2)
            addq.b  #2,D7
.L11:
            tst.b   D7
            beq.b   .L12
            bsr.w   CVFlgs
            bne.b   .L12
            bsr.w   MarkVCB
.L12:
            or.b    D7,($13,A2)
            bra.w   sub_4080F65E.L8
CkFilLen:
            movem.l D0-D6,-(SP)
            move.w  ($1A,A2),D1
            moveq   #0,D6
            move.l  ($1C,A2),D2
            move.w  (A3),D3
            beq.b   .L2
.L1:
            bsr.w   GtNxBlk
            subq.w  #1,D1
            bcs.b   .L6
            move.w  D5,D3
            beq.b   .L2
            add.l   D2,D6
            cmpi.w  #1,D3
            bne.b   .L1
.L2:
            move.w  (A3)+,D3
            move.l  (A3)+,D4
            move.l  (A3)+,D5
            cmp.l   D5,D6
            beq.b   .L5
            move.l  D6,-(A3)
            bne.b   .L3
            clr.w   D3
.L3:
            cmp.l   D6,D4
            bls.b   .L4
            move.l  D6,D4
.L4:
            move.l  D4,-(A3)
            move.w  D3,-(A3)
            bsr.w   CVFlgs
            bne.b   .L6
            jsr     (MarkA5Block.w,PC)
            bset    #2,D7
.L5:
            moveq   #0,D1
.L6:
            movem.l (SP)+,D0-D6
            rts
MFSFlush:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            tst.w   ($48,A2)
            beq.b   .L5
            tst.b   (6,A2)
            bpl.b   .L4
            bsr.w   CkMFSMap
            bne.b   .L4
            moveq   #2,D3
            bsr.w   MFSMapRead
            bne.b   .L8
            jsr     (MarkA5Block.w,PC)
            moveq   #$1F,D0
            movea.l A5,A1
            lea     (8,A2),A0
            move.l  TimeLM,($E,A2)
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            movea.l ($50,A2),A0
            move.w  ($58,A2),D2
            moveq   #$40,D7
.L2:
            move.w  (A0)+,(0,A5,D7.w)
            addq.w  #2,D7
            subq.w  #2,D2
            ble.b   .L3
            cmpi.w  #$200,D7
            bcs.b   .L2
            addq.w  #1,D3
            bsr.w   MFSMapRead
            bne.b   .L8
            jsr     (MarkA5Block.w,PC)
            moveq   #0,D7
            bra.b   .L2
.L3:
            cmpi.w  #$200,D7
            bcc.b   .L4
            clr.w   (0,A5,D7.w)
            addq.w  #2,D7
            bra.b   .L3
.L4:
            bsr.w   FlushBuffers
            bne.b   .L8
.L5:
            clr.b   (6,A2)
            tst.b   FlushOnly
            bne.b   .L7
            tst.w   ($48,A2)
            beq.b   .L6
            bsr.w   sub_408106CA
.L6:
            bsr.w   DsposVCB
.L7:
            moveq   #0,D0
.L8:
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
            bsr.w   FSQueue
            move.w  ($1C,A0),D2
            bgt.b   .L11
            beq.b   .L9
            bsr.w   DtrmV3
            bra.b   .L10
.L9:
            bsr.w   DtrmV1
.L10:
            bne.b   .L17
            bra.b   .L13
.L11:
            move.l  ($358).w,D1
.L12:
            beq.w   GetVol.L2
            subq.w  #1,D2
            movea.l D1,A2
            beq.b   .L13
            move.l  (A2),D1
            bra.b   .L12
.L13:
            bset    #6,($13,A2)
            bsr.b   sub_408108C6
.L14:
            cmpa.l  ($14,A1,D1.w),A2
            beq.b   .L15
            bsr.b   sub_408108CE
            bcs.b   .L14
            bclr    #6,($13,A2)
.L15:
            moveq   #$20,D0
.L16:
            move.w  ($A,A2,D0.w),($1E,A0,D0.w)
            subq.w  #2,D0
            bpl.b   .L16
            bsr.w   XferVName
.L17:
            bra.w   CmdDone
