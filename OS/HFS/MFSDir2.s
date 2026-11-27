.L11:
            moveq   #-$2D,D0
            btst    #0,(A5)
            bne.b   .L12
            bsr.w   CkFileBusy
            bne.b   .L12
            subq.w  #1,($14,A2)
            bsr.w   MarkVCB
            move.w  ($16,A5),D3
            bsr.w   DAlBlks
            move.w  ($20,A5),D3
            bsr.w   DAlBlks
            move.l  ($12,A5),D0
            bsr.b   sub_40811094
            jsr     (TrashFBlocks.w,PC)
            bsr.w   sub_40810C48
            moveq   #0,D0
.L12:
            bra.w   CmdDone
sub_40811084:
            moveq   #0,D0
            move.b  ($32,A5),D0
            addi.w  #$34,D0
            bclr    #0,D0
            rts
sub_40811094:
            movem.l D0/A0-A1/A5,-(SP)
            movea.l A1,A0
            jsr     (MarkBlock.w,PC)
            clr.l   ($5A,A2)
            movea.l A5,A0
            bsr.b   sub_40811084
            adda.l  D0,A5
            lea     ($200,A1),A1
.L1:
            cmpa.l  A1,A5
            bcc.b   .L2
            move.w  (A5)+,(A0)+
            bra.b   .L1
.L2:
            clr.w   (A0)+
            cmpa.l  A1,A0
            bcs.b   .L2
            movem.l (SP)+,D0/A0-A1/A5
            rts
.L3:
            move.l  A0,-(SP)
            move.w  D2,D0
            movea.l A4,A0
            movem.l ($3D6).w,D2/A4
            swap    D0
            move.w  D2,D0
            movea.l A4,A1
            _CmpString
            movea.l (SP)+,A0
            beq.b   .L5
            bsr.w   FndFN2
            bne.b   .L4
            moveq   #-$30,D0
.L4:
            cmpi.w  #$FFD5,D0
            bne.b   .L9
.L5:
            bsr.w   FndFilName
            bne.b   .L9
            moveq   #-$2D,D0
            btst    #0,(A5)
            bne.b   .L9
            movea.l A6,A4
            movea.l A5,A3
            bsr.b   sub_40811084
.L6:
            move.w  (-2,A3,D0.w),-(A6)
            subq.w  #2,D0
            bgt.b   .L6
            bsr.b   sub_40811094
            move.l  ($3D6).w,D2
            bsr.w   FndFilSpc
            bne.b   .L10
            movea.l A5,A3
            moveq   #$18,D0
.L7:
            move.w  (A6)+,(A5)+
            dbra    D0,.L7
            movea.l A4,A6
            movem.l ($3D6).w,D2/A4
            move.b  D2,(A5)+
.L8:
            move.b  (A4)+,(A5)+
            subq.w  #1,D2
            bgt.b   .L8
            bsr.b   sub_40811156
            bsr.w   MarkVCBTime
            bsr.w   sub_40810C48
            moveq   #0,D0
.L9:
            bra.w   CmdDone
.L10:
            move.b  ($32,A6),D2
            bsr.w   FndFilSpc
            beq.b   .L11
            movea.l A4,A6
            moveq   #-$3B,D0
            bra.b   .L9
.L11:
            movea.l A5,A3
.L12:
            move.w  (A6)+,(A5)+
            cmpa.l  A6,A4
            bne.b   .L12
            bsr.b   sub_40811156
            moveq   #-$21,D0
            bra.b   .L9
sub_40811156:
            move.l  ($12,A3),D2
            move.w  FileVars,D0
            bsr.w   Gt1stMatch
            bne.b   .L2
.L1:
            move.w  D0,($1C,A1,D1.w)
            bsr.w   GtNxtMatch
            beq.b   .L1
.L2:
            rts
