SetFilType:
            bsr.w   FSQueue
            move.b  ($1A,A0),D1
            move.b  ($1C,A0),($1A,A0)
            bsr.w   FndFilName
            move.b  D1,($1A,A0)
            tst.w   D0
            bne.b   .L1
            bsr.w   TFSVCBTst
            beq.b   .L2
            moveq   #-$30,D0
.L1:
            cmpi.w  #$FFD5,D0
            bne.b   RstFilLock.L5
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L33
.L2:
            moveq   #-$32,D0
            bra.b   RstFilLock.L5
SetFilLock:
            bsr.w   FSQueue
            st      ($348).w
            bra.b   RstFilLock.L1
RstFilLock:
            bsr.w   FSQueue
            clr.b   ($348).w
.L1:
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L34
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   .L5
            tst.b   ($348).w
            beq.b   .L2
            bset    #0,(2,A5)
            bne.b   .L4
            bra.b   .L3
.L2:
            bclr    #0,(2,A5)
            beq.b   .L4
.L3:
            move.l  D7,D2
            jsr     (CMUpdateCN.w,PC)
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            bra.w   CmdDone
SetFileInfo:
            bsr.w   FSQueue
            bsr.w   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L38
            moveq   #-$2B,D0
            cmpi.b  #2,(A5)
            bne.b   RstFilLock.L5
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,(4,A5)
            movem.l ($48,A0),D1-D2
            movem.l D1-D2,($2C,A5)
            bra.b   RstFilLock.L3
SetCatInfo:
            bsr.w   FSQueue
            bsr.b   CkFilMod
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L38
            cmpi.b  #2,(A5)
            bne.b   .L1
            movem.l ($20,A0),D0-D3
            movem.l D0-D3,(4,A5)
            movem.l ($54,A0),D0-D3
            movem.l D0-D3,($38,A5)
            movem.l ($48,A0),D0-D1
            movem.l D0-D1,($2C,A5)
            move.l  ($50,A0),($34,A5)
            bra.b   .L2
.L1:
            moveq   #-$25,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            movem.l ($20,A0),D1-D4
            movem.l D1-D4,($16,A5)
            movem.l ($54,A0),D0-D3
            movem.l D0-D3,($26,A5)
            movem.l ($48,A0),D0-D2
            movem.l D0-D2,($A,A5)
.L2:
            moveq   #0,D0
.L3:
            bra.w   RstFilLock.L3
CkFilMod:
            move.l  (SP)+,-(A6)
            bsr.b   FndFilName
            bne.b   .L1
            bsr.w   CVFlgs
            bne.b   .L1
            move.l  (A6)+,-(SP)
            rts
.L1:
            addq.w  #4,A6
            bra.w   CmdDone
FndFilName:
            move.l  ($78C).w,-(SP)
            rts
vFndFilName:
            bsr.w   DtrmV3
            beq.b   .L2
.L1:
            rts
.L2:
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L3
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L3:
            move.l  A4,D0
            beq.b   .L4
            sub.l   ($12,A0),D0
            subq.l  #2,D0
            bgt.b   FndFN2
.L4:
            btst    #9,(6,A0)
            beq.b   FndFN2
            move.l  ($30,A0),D0
            beq.b   FndFN2
            move.l  D0,D6
            moveq   #0,D7
FndFN2:
            bsr.w   ExtOffLinCk
            bne.b   vFndFilName.L1
            bsr.w   TFSVCBTst
            bne.w   GetFileInfo.L39
            move.l  (SP)+,-(A6)
            movem.l D1/A0-A1,-(A6)
            move.l  D2,D1
            move.l  D2,D4
.L1:
            moveq   #-$78,D0
            moveq   #0,D1
.L2:
            moveq   #0,D3
            cmp.w   D4,D1
            bge.b   .L5
            cmpi.b  #$3A,(0,A4,D1.w)
            beq.b   .L4
            cmpi.w  #$1F,D1
            blt.b   .L3
            moveq   #-$25,D0
            bra.w   .L11
.L3:
            addq.w  #1,D1
            bra.b   .L2
.L4:
            bset    #5,($376).w
            tst.w   D1
            seq     D3
            swap    D3
            move.w  D4,D3
            sub.w   D1,D3
            subq.w  #1,D3
            bgt.b   .L6
.L5:
            moveq   #-$2B,D0
.L6:
            swap    D3
            movem.l D6-D7,-(A6)
            movem.l D0/A1,-(SP)
            movea.l D1,A0
            addq.w  #1,D1
            lsr.w   #1,D1
            lsl.w   #1,D1
            suba.l  D1,A6
            move.l  D1,-(SP)
            move.l  A0,D1
            movea.l A4,A0
            movea.l A6,A1
            move.l  D1,D0
            _BlockMove
            move.w  D1,-(A6)
            move.l  (SP)+,D1
            movea.l A6,A0
            addq.l  #1,A0
            movem.l (SP)+,D0/A1
            exg     D6,D0
            move.l  D7,D2
            jsr     (CMGetCN.w,PC)
            move.w  (A6)+,-(SP)
            adda.l  D1,A6
            moveq   #0,D1
            move.w  (SP)+,D1
            tst.w   D0
            bne.b   .L9
            tst.b   D3
            beq.b   .L7
            moveq   #-$78,D0
            cmpi.l  #1,(2,A0)
            beq.b   .L9
            move.l  (2,A0),D0
            moveq   #0,D2
            suba.l  A0,A0
            jsr     (CMGetCN.w,PC)
            bne.b   .L9
            move.l  (2,A0),D0
            moveq   #0,D2
.L7:
            cmpi.w  #$FFD5,D6
            beq.b   .L8
            movem.l (A6)+,D6-D7
            move.l  (6,A1),D6
            move.l  D2,D7
            addq.w  #1,D1
            adda.l  D1,A4
            sub.w   D1,D4
            bra.w   .L1
.L8:
            moveq   #0,D0
            movea.l A1,A5
            move.l  D2,(4,A6)
            bra.b   .L10
.L9:
            cmpi.w  #$30,D0
            bne.b   .L10
            move.l  D6,D0
.L10:
            movem.l (A6)+,D6-D7
            move.l  D1,D2
.L11:
            movem.l (A6)+,D1/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
ExtOffLinCk:
            bsr.w   sub_4080FEFA
            bne.b   .L1
            tst.w   ($48,A2)
            bne.b   .L1
            moveq   #-$35,D0
.L1:
            move.l  A2,($3EE).w
            tst.w   D0
            rts
GetCatInfo:
            bsr.w   FSQueue
            bset    #0,($376).w
            tst.w   ($1C,A0)
            bmi.b   GetFileInfo.L3
            bra.b   GetFileInfo.L1
GetFileInfo:
            bsr.w   FSQueue
            bclr    #0,($376).w
.L1:
            move.w  ($1C,A0),D1
            bgt.b   .L4
            bsr.w   FndFilName
            beq.b   .L2
            cmpi.w  #$FFDB,D0
            bne.w   .L17
            tst.b   D2
            bne.w   .L17
            btst    #0,($376).w
            bne.b   .L7
            bra.w   .L17
.L2:
            bsr.w   TFSVCBTst
            bne.w   .L57
            move.l  D6,D1
            bra.w   .L21
.L3:
            moveq   #0,D1
.L4:
            bset    #5,($376).w
            bsr.w   DtrmV1
            bne.w   .L17
            bsr.b   ExtOffLinCk
            bne.w   .L17
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L5
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L5:
            btst    #9,(6,A0)
            beq.b   .L6
            tst.l   ($30,A0)
            beq.b   .L6
            move.l  ($30,A0),D6
            moveq   #0,D7
.L6:
            bsr.w   TFSVCBTst
            beq.b   .L10
            moveq   #-$78,D0
            cmpi.l  #2,D6
            bne.w   .L17
            tst.w   D1
            bgt.w   .L49
.L7:
            lea     ($1E,A0),A1
            moveq   #$26,D0
.L8:
            clr.w   (A1)+
            dbra    D0,.L8
            bset    #4,($1E,A0)
            move.l  #2,($30,A0)
            move.l  #1,($64,A0)
            move.w  ($14,A2),($34,A0)
            move.l  ($A,A2),($48,A0)
            move.l  ($E,A2),($4C,A0)
            move.l  ($12,A0),D0
            beq.b   .L9
            tst.w   ($1C,A0)
            beq.b   .L9
            movea.l D0,A1
            lea     ($2C,A2),A0
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
.L9:
            moveq   #0,D0
            bra.b   .L17
.L10:
            moveq   #1,D0
            cmp.l   D0,D6
            beq.b   .L16
            tst.w   D1
            bne.b   .L11
            movem.l A0-A1,-(A6)
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     (CMGetCN.w,PC)
            bne.b   .L15
            move.l  D2,D7
            bra.b   .L19
.L11:
            btst    #0,($376).w
            bne.b   .L18
            move.w  D1,D5
            move.w  ($B0,A2),D1
            cmp.l   ($AC,A2),D6
            bne.b   .L12
            cmp.w   ($5A,A2),D5
            bcs.b   .L12
            move.w  ($5A,A2),D0
            move.w  D5,($5A,A2)
            sub.w   D0,D5
            bra.b   .L13
.L12:
            moveq   #1,D1
            move.w  D5,($5A,A2)
            subq.w  #1,D5
.L13:
            movem.l A0-A1,-(A6)
.L14:
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     (CMGetOff.w,PC)
            bne.b   .L15
            move.l  D2,D7
            addq.w  #1,D1
            cmpi.b  #2,(A1)
            bne.b   .L14
            dbra    D5,.L14
            bra.b   .L19
.L15:
            movem.l (A6)+,A0-A1
            cmpi.w  #$30,D0
            bne.b   .L17
.L16:
            moveq   #-$2B,D0
.L17:
            bra.w   CmdDone
.L18:
            movem.l A0-A1,-(A6)
            move.w  #$FFFF,($5A,A2)
            move.l  D6,D0
            move.l  D7,D2
            suba.l  A0,A0
            jsr     (CMGetOff.w,PC)
            bne.b   .L15
.L19:
            lea     (6,A0),A3
            move.l  (2,A0),D1
            movea.l A1,A5
            movem.l (A6)+,A0-A1
            move.l  ($12,A0),D0
            beq.b   .L21
            movea.l D0,A4
            move.b  (A3),D0
.L20:
            move.b  (A3)+,(A4)+
            subq.b  #1,D0
            bcc.b   .L20
.L21:
            btst    #0,($376).w
            bne.b   .L30
            cmpi.b  #2,(A5)
            bne.b   .L16
            lea     ($1E,A0),A4
            moveq   #$18,D0
            lea     (2,A5),A3
.L22:
            move.w  (A3)+,(A4)+
            dbra    D0,.L22
            bclr    #4,($1E,A0)
.L23:
            andi.b  #$73,($1E,A0)
            clr.w   ($18,A0)
            move.l  ($14,A5),D2
            bsr.w   TFSVCBTst
            beq.b   .L24
            move.l  ($12,A5),D2
.L24:
            bsr.w   Gt1stMatch
            bne.b   .L29
.L25:
            btst    #1,(4,A1,D1.w)
            beq.b   .L26
            bset    #2,($1E,A0)
            bra.b   .L27
.L26:
            bset    #3,($1E,A0)
.L27:
            bset    #7,($1E,A0)
            bne.b   .L28
            move.w  D1,($18,A0)
.L28:
            lea     ($34,A0),A3
            bsr.w   UpDatFlNtry
            bsr.w   GtNxtMatch
            beq.b   .L25
.L29:
            moveq   #0,D0
            bra.w   .L17
.L30:
            lea     ($1E,A0),A4
            cmpi.b  #2,(A5)
            bne.b   .L32
            moveq   #$22,D0
            lea     (2,A5),A3
.L31:
            move.w  (A3)+,(A4)+
            dbra    D0,.L31
            moveq   #0,D0
            move.w  ($48,A5),D0
            mulu.w  ($1E,A2),D0
            move.l  D0,($68,A0)
            move.l  D1,($64,A0)
            bclr    #4,($1E,A0)
            bra.w   .L23
.L32:
            cmpi.b  #1,(A5)
            bne.w   .L16
            move.w  (2,A5),($1E,A0)
            move.w  (4,A5),($34,A0)
            move.l  (6,A5),($30,A0)
            move.l  D1,($64,A0)
            movem.l ($A,A5),D0-D2
            movem.l D0-D2,($48,A0)
            movem.l ($16,A5),D0-D3
            movem.l D0-D3,($20,A0)
            movem.l ($26,A5),D0-D3
            movem.l D0-D3,($54,A0)
            bclr    #7,($1E,A0)
            bset    #4,($1E,A0)
            moveq   #0,D0
            bra.w   .L17
