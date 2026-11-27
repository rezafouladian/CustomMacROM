sub_408108C6:
            movea.l ($34E).w,A1
            moveq   #2,D1
            rts
sub_408108CE:
            add.w   FSFCBLen,D1
            cmp.w   (A1),D1
            rts
Gt1stMatch:
            bsr.b   sub_408108C6
.L1:
            cmp.l   (0,A1,D1.w),D2
            bne.b   GtNxtMatch
            cmpa.l  ($14,A1,D1.w),A2
            beq.b   GtNxtMatch.L1
GtNxtMatch:
            bsr.b   sub_408108CE
            bcs.b   Gt1stMatch.L1
            move    #0,CCR
.L1:
            rts
OpenRF:
            bsr.w   FSQueue
            clr.b   ($347).w
            bra.b   vFileOpen.L1
FileOpen:
            move.l  ($784).w,-(SP)
            rts
vFileOpen:
            bsr.w   FSQueue
            st      ($347).w
.L1:
            bsr.b   sub_408108C6
.L2:
            tst.l   (0,A1,D1.w)
            beq.b   .L5
            bsr.b   sub_408108CE
            bcs.b   .L2
            moveq   #-$2A,D0
.L3:
            clr.w   ($18,A0)
.L4:
            bra.w   CmdDone
.L5:
            move.w  D1,($18,A0)
            add.l   A1,D1
            bsr.w   FndFilName
            bne.b   .L3
            move.l  A0,-(SP)
            movea.l D1,A0
            moveq   #0,D0
            move.w  FSFCBLen,D0
            lsr.w   #1,D0
            subq.w  #1,D0
.L6:
            clr.w   (A0)+
            dbra    D0,.L6
            movea.l (SP)+,A0
            bsr.w   TFSVCBTst
            bne.w   sub_40810B96.L2
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   .L3
            movea.l D1,A3
            move.l  D7,($36,A3)
            move.l  (4,A5),D0
            move.l  D0,($32,A3)
            move.l  D6,($3A,A3)
            moveq   #0,D0
            move.w  ($48,A5),D0
            beq.b   .L7
            mulu.w  ($1E,A2),D0
            bset    #6,(4,A3)
            bra.b   .L8
.L7:
            move.l  ($20,A2),D0
            bclr    #6,(4,A3)
.L8:
            move.l  D0,($1E,A3)
            movem.l A0-A1,-(SP)
            moveq   #$C,D0
            lea     ($4A,A5),A0
            tst.b   ($347).w
            bne.b   .L9
            lea     ($56,A5),A0
.L9:
            lea     ($26,A3),A1
            _BlockMove
            moveq   #0,D0
            move.w  D2,D0
            movea.l A4,A0
            lea     ($3E,A3),A1
            move.b  D0,(A1)+
            _BlockMove
            movem.l (SP)+,A0-A1
            move.l  A0,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            lea     ($3E,A3),A0
            jsr     (CMGetCN.w,PC)
            beq.w   .L10
            movea.l (A6)+,A0
            bmi.w   .L3
            moveq   #-$2B,D0
            bra.w   .L3
.L10:
            movea.l A1,A5
            lea     (6,A0),A0
            lea     ($3E,A3),A1
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            _BlockMove
            movea.l (A6)+,A0
            clr.w   D7
            move.w  (2,A5),D3
            andi.w  #$100,D3
            beq.b   .L11
            bset    #$D,D3
.L11:
            lea     ($14,A5),A5
            move.l  (A5)+,D2
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
            tst.b   ($347).w
            bne.b   .L12
            bset    #9,D3
            move.w  (A5)+,D4
            move.l  (A5)+,D5
            move.l  (A5)+,D6
.L12:
            bsr.b   sub_40810A74
            beq.b   .L14
            moveq   #0,D1
            move.w  FSFCBLen,D1
            lsr.w   #1,D1
            subq.w  #1,D1
.L13:
            clr.w   (A3)+
            dbra    D1,.L13
            bra.w   .L4
.L14:
            move.l  D2,(A3)+
            move.w  D3,(A3)+
            move.w  D4,(A3)+
            move.l  D5,(A3)+
            move.l  D6,(A3)+
            clr.l   (A3)+
            move.l  A2,(A3)+
            suba.l  A4,A4
            move.l  A4,D0
            nop
            move.l  A4,(A3)+
            move.w  D7,(A3)+
            addq.l  #4,A3
            clr.l   (A3)+
            bset    #7,(5,A2)
            move.w  ($18,A0),D4
            bsr.w   Gt1stMatch
.L15:
            cmp.w   D1,D4
            beq.b   .L16
            move.b  (4,A1,D1.w),D5
            move.b  D5,D6
            eor.b   D3,D6
            lsr.b   #2,D6
            bcc.b   .L17
.L16:
            bsr.w   GtNxtMatch
            beq.b   .L15
            bra.b   .L18
.L17:
            jsr     sub_40811E64
            move.b  D5,(4,A1,D1.w)
.L18:
            moveq   #0,D0
            bra.w   CmdDone
sub_40810A74:
            move.l  ($788).w,-(SP)
            rts
vPermssnChk:
            cmpi.b  #1,($1B,A0)
            beq.b   .L3
            bset    #8,D3
            beq.b   .L1
            tst.b   ($1B,A0)
            beq.b   .L3
            clr.w   ($18,A0)
            moveq   #-$36,D0
            bra.b   .L4
.L1:
            btst    #2,($1B,A0)
            beq.b   .L2
            bset    #$C,D3
.L2:
            bra.b   .L5
.L3:
            bclr    #8,D3
            moveq   #0,D0
.L4:
            rts
.L5:
            bsr.w   Gt1stMatch
.L6:
            bne.b   .L9
            move.w  (4,A1,D1.w),D0
            eor.w   D3,D0
            andi.w  #$300,D0
            bne.b   .L7
            btst    #$C,D3
            beq.b   .L8
            btst    #4,(4,A1,D1.w)
            beq.b   .L8
.L7:
            bsr.w   GtNxtMatch
            bra.b   .L6
.L8:
            move.w  D1,($18,A0)
            moveq   #-$31,D0
            bra.b   .L10
.L9:
            moveq   #0,D0
.L10:
            rts
CreateDir:
            bsr.w   FSQueue
            bset    #1,($376).w
            bra.b   FileCreate.L1
FileCreate:
            bsr.w   FSQueue
            bclr    #1,($376).w
.L1:
            bsr.w   FndFilName
            bne.b   .L2
            moveq   #-$30,D0
            bra.b   .L7
.L2:
            cmpi.w  #$FFD5,D0
            bne.b   .L7
            bsr.w   CVFlgs
            bne.b   .L7
            bsr.w   TFSVCBTst
            beq.b   .L3
            btst    #1,($376).w
            beq.w   sub_40810B96.L6
            moveq   #-$7B,D0
            bra.b   .L7
.L3:
            move.b  ($1A,A0),D1
            swap    D1
            move.b  #2,D1
            btst    #1,($376).w
            beq.b   .L4
            move.b  #1,D1
.L4:
            move.l  A0,-(A6)
            bsr.b   PushCName
            move.w  D2,-(A6)
            move.l  D6,D0
            jsr     (CMSvcs.w,PC)
            move.w  (A6)+,D2
            bsr.b   sub_40810B96
            movea.l (A6)+,A0
            tst.w   D0
            beq.b   .L5
            cmpi.w  #$30,D0
            bne.b   .L7
            moveq   #-$78,D0
            bra.b   .L7
.L5:
            btst    #1,($376).w
            beq.b   .L6
            move.l  D1,($30,A0)
.L6:
            moveq   #0,D0
.L7:
            bra.w   CmdDone
PushCName:
            movem.l D0/A1,-(SP)
            suba.l  A0,A0
            tst.w   D2
            beq.b   .L1
            movea.w D2,A0
            addq.w  #1,D2
            bclr    #0,D2
            suba.w  D2,A6
            move.w  D2,-(SP)
            move.w  A0,D2
            movea.l A4,A0
            movea.l A6,A1
            moveq   #0,D0
            move.w  D2,D0
            _BlockMove
            move.w  D2,-(A6)
            move.w  (SP)+,D2
            movea.l A6,A0
            addq.l  #1,A0
.L1:
            movem.l (SP)+,D0/A1
            rts
sub_40810B96:
            tst.w   D2
            beq.b   .L1
            move.w  (A6)+,-(SP)
            adda.w  D2,A6
            move.w  (SP)+,D2
.L1:
            rts
