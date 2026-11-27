.L2:
            movea.l D1,A3
            move.w  FileVars,D7
            move.w  (A5),D3
            andi.w  #$1FF,D3
            btst    #8,D3
            beq.b   .L3
            bset    #$D,D3
.L3:
            move.l  ($20,A2),($1E,A3)
            lea     ($12,A5),A5
            move.l  (A5)+,D2
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
            tst.b   ($347).w
            bne.b   .L4
            bset    #9,D3
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
.L4:
            bsr.w   sub_40810A74
            bne.b   .L5
            bra.w   vFileOpen.L14
            clr.w   ($18,A0)
.L5:
            bra.w   CmdDone
.L6:
            tst.w   D2
            beq.b   .L8
            move.w  D2,D0
.L7:
            subq.w  #1,D0
            blt.b   .L10
            cmpi.b  #$3A,(0,A4,D0.w)
            bne.b   .L7
.L8:
            moveq   #-$25,D0
.L9:
            bra.w   CmdDone
.L10:
            bsr.b   FndFilSpc
            bne.b   .L9
            move.w  D5,D0
            movea.l A5,A1
.L11:
            clr.w   (A1)+
            subq.w  #2,D0
            bhi.b   .L11
            bset    #7,(A5)
            move.b  ($1A,A0),(1,A5)
            move.l  ($26,A2),($12,A5)
            addq.l  #1,($26,A2)
            lea     ($2A,A5),A5
            move.l  TimeLM,(A5)
            move.l  (A5)+,(A5)+
            move.b  D2,(A5)+
            beq.b   .L13
.L12:
            move.b  (A4)+,(A5)+
            subq.b  #1,D2
            bhi.b   .L12
.L13:
            bsr.w   MarkVCB
            addq.w  #1,($14,A2)
            bsr.b   sub_40810C48
            moveq   #0,D0
            bra.b   .L9
sub_40810C48:
            move.w  ($4E,A2),D0
            movea.l ($380).w,A1
            moveq   #0,D1
            jmp     (FlushCache.w,PC)
FndFilSpc:
            movea.l (SP)+,A3
            moveq   #$34,D5
            add.w   D2,D5
            bclr    #0,D5
            bsr.w   sub_40811A30
            bra.b   .L2
.L1:
            bsr.w   sub_40811A40
.L2:
            bne.b   .L5
            moveq   #0,D0
.L3:
            tst.b   (0,A5,D0.w)
            beq.b   .L4
            bsr.b   sub_40810C92
            bcs.b   .L3
.L4:
            move.w  D0,D4
            add.w   D5,D4
            cmpi.w  #$200,D4
            bcc.b   .L1
            jsr     (MarkA5Block.w,PC)
            lea     (0,A5,D0.w),A5
            clr.l   ($5A,A2)
            moveq   #0,D0
.L5:
            jmp     (A3)
sub_40810C92:
            moveq   #0,D6
            move.b  ($32,A5,D0.w),D6
            add.w   D6,D0
            addi.w  #$34,D0
            bclr    #0,D0
            cmpi.w  #$1CC,D0
            rts
