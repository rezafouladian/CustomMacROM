            include "Include/ROMHeader.s"

            EXPORT  OPERRHANDLER,OPERRHANDLER040,QABS,QCPYSGN,QGETENV,QGETHV
            EXPORT  QNEG,QNEXTD,QNEXTS,QNEXTX,QNEXTX96,QPROCENTRY
            EXPORT  QPROCEXIT,QSETENV,QSETHV,QSETXCP,QTESTXCP

            SECTION "FPHWNonArith",CODE

QGETENV:
            movem.l D0-D2/A0,-(SP)
            fmove.l FPSR,D0
            movea.l ($14,SP),A0
            moveq   #0,D2
            fmove.l FPCR,D1
            bfextu  D0{24:5},D0
            move.b  .L2(PC,D0.w),D0
            bfins   D0,D2{19:5}
            bclr    #$D,D1
            bftst   D1{16:2}
            beq.b   .L1
            bset    #$D,D1
.L1:
            bfextu  D1{18:5},D0
            move.b  .L2(PC,D0.w),D0
            bfins   D0,D2{27:5}
            bfextu  D1{24:2},D0
            move.b  .L3(PC,D0.w),D0
            bfins   D0,D2{25:2}
            bfextu  D1{26:2},D0
            move.b  .L4(PC,D0.w),D0
            bfins   D0,D2{17:2}
            move.w  D2,(A0)
            movem.l (SP)+,D0-D2/A0
            rtd     #4
.L2:
            dc.w    $0010,$0818,$0212,$0A1A,$0414,$0C1C,$0616,$0E1E
            dc.w    $0111,$0919,$0313,$0B1B,$0515,$0D1D,$0717,$0F1F
.L3:
            dc.w    $0002,$0103
.L4:
            dc.w    $0003,$0201
QSETENV:
            movem.l D0-D2/A0,-(SP)
            movea.l ($14,SP),A0
            move.w  (A0),D2
            fmove.l FPSR,D1
            bfextu  D2{19:5},D0
            move.b  .L1(PC,D0.w),D0
            bfins   D0,D1{24:5}
            fmove.l D1,FPSR
            fmove.l FPCR,D1
            bfextu  D2{27:5},D0
            move.b  .L1(PC,D0.w),D0
            bset    #4,D0
            bfins   D0,D1{16:7}
            bfextu  D2{25:2},D0
            move.b  QGETENV.L3(PC,D0.w),D0
            bfins   D0,D1{24:2}
            bfextu  D2{17:2},D0
            move.b  QGETENV.L4(PC,D0.w),D0
            bfins   D0,D1{26:2}
            fmove.l D1,FPCR
            movem.l (SP)+,D0-D2/A0
            rtd     #4
.L1:
            dc.w    $0070,$0474,$0878,$0C7C,$0272,$0676,$0A7A,$0E7E
            dc.w    $0171,$0575,$0979,$0D7D,$0373,$0777,$0B7B,$0F7F
QSETHV:
            movem.l D0/A0-A1,-(SP)
            movea.l ($10,SP),A0
            move.l  (A0),($A4C).w
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            pea     STDHANDLER040
            pea     sub_408EDA10.L5
            pea     OPERRHANDLER040
            pea     sub_408EDA10.L5
            pea     DZHANDLER040
            pea     sub_408EDA10.L5
            pea     sub_408EDA10.L5
            bra.b   .L3
.L2:
            pea     sub_408EDC6E
            pea     sub_408EDCF0.L4
            pea     OPERRHANDLER
            pea     sub_408EDCF0.L4
            pea     DZHANDLER
            pea     sub_408EDCF0.L4
            pea     sub_408EDCF0.L4
.L3:
            movea.l SP,A0
            move.w  #2,D0
            bsr.w   sub_408EDCF0.L8
            lea     ($1C,SP),SP
            movem.l (SP)+,D0/A0-A1
            rtd     #4
QGETHV:
            move.l  ($A4C).w,([4.w,SP])
            rtd     #4
QNEG:
            bchg    #7,([4.w,SP])
            rtd     #4
QABS:
            bclr    #7,([4.w,SP])
            rtd     #4
QPROCENTRY:
            move.l  (4,SP),-(SP)
            bsr.w   QGETENV
            fmovem.l .L1(PC),FPCR/FPSR
            rtd     #4
.L1:
            dc.b    $00,$00,$20
            ds.b    5
QTESTXCP:
            movem.l D0-D1/A0,-(SP)
            moveq   #0,D0
            movea.l ($10,SP),A0
            fmove.l FPSR,D1
            move.w  (A0),D0
            move.w  .L2(PC,D0.w*2),D0
            bfextu  D1{D0:1},D1
            move.b  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #4
.L2:
            dc.w    $0018,$001A,$0019,$001B,$001C
preFMOVE:
            fmove.l FPCR,D2
            move.l  #$8C0,D3
            and.l   D2,D3
            beq.b   .L1
            eor.l   D3,D2
            fmove.l D2,FPCR
.L1:
            rts
postFMOVE:
            tst.l   D3
            beq.b   .L1
            eor.l   D3,D2
            fmove.l D2,FPCR
.L1:
            rts
QNEXTX96:
            link.w  A6,#-$5E
            move.l  #$100033,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.b   preFMOVE
            movea.l (8,A6),A0
            fmove.x (A0),FP1
            movea.l ($C,A6),A0
            fmove.x (A0),FP0
            fmove.x FP0,(A0)
            move.w  (A0)+,(A0)
            bra.b   QNEXTXENTRY
QNEXTX:
            link.w  A6,#-$5E
            move.l  #$100013,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.b   preFMOVE
            movea.l (8,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP1
            movea.l ($C,A6),A0
            addq.w  #6,A0
            move.l  (A0),-(SP)
            move.l  -(A0),-(SP)
            subq.w  #2,A0
            move.l  (A0),-(SP)
            fmove.x (SP)+,FP0
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
QNEXTXENTRY:
            fcmp.x  FP0,FP1
            fbogl.w .L4
            fbeq.w  .L3
            fcmp.x  FP0,FP0
            fbun.w  .L3
            fmove.x FP1,FP0
.L3:
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
            bsr.w   postFMOVE
            bra.w   .L14
.L4:
            fsolt   D1
            ftst.x  FP0
            fbne.w  .L6
            fmove.x #"$000000000000000000000001",FP0
            ftst.x  FP1
            fbogt.w .L5
            fneg.x  FP0,FP0
.L5:
            fmove.x FP0,-(SP)
            move.w  (SP)+,(A0)+
            addq.w  #2,SP
            move.l  (SP)+,(A0)+
            move.l  (SP)+,(A0)
            subq.w  #6,A0
            bra.b   .L11
.L6:
            fsolt   D0
            eor.b   D1,D0
            bpl.b   .L8
            bftst   (A0){1:15}
            beq.b   .L7
            bclr    #7,(2,A0)
.L7:
            subq.l  #1,(6,A0)
            bcc.b   .L10
            subq.l  #1,(2,A0)
            bcc.b   .L10
            subq.w  #1,(A0)
            bra.b   .L10
.L8:
            bftst   (A0){1:15}
            beq.b   .L9
            bset    #7,(2,A0)
.L9:
            addq.l  #1,(6,A0)
            bcc.b   .L10
            addq.l  #1,(2,A0)
            bcc.b   .L10
            addq.w  #1,(A0)
.L10:
            move.l  (A0),D0
            bfchg   D0{1:15}
            bne.b   .L12
.L11:
            bsr.w   postFMOVE
            btst    #7,(2,A0)
            bne.b   .L14
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L14
.L12:
            bsr.w   postFMOVE
            bfchg   D0{1:15}
            beq.b   .L13
            bset    #7,(2,A0)
            bra.b   .L14
.L13:
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L14:
            btst    #5,(-1,A6)
            beq.b   .L15
            move.w  (A0),-(A0)
.L15:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
QNEXTD:
            link.w  A6,#-$5E
            move.l  #$100813,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            bsr.w   preFMOVE
            movea.l (8,A6),A0
            fmove.d (A0),FP1
            movea.l ($C,A6),A0
            fmove.d (A0),FP0
            fcmp.x  FP0,FP1
            fbogl.w .L17
            fbeq.w  .L16
            fcmp.x  FP0,FP0
            fbun.w  .L16
            fmove.x FP1,FP0
.L16:
            fmove.d FP0,(A0)
            bsr.w   postFMOVE
            bra.b   .L24
.L17:
            fsolt   D1
            ftst.x  FP0
            fbne.w  .L19
            fmove.d #"$0000000000000001",FP0
            ftst.x  FP1
            fbogt.w .L18
            fneg.x  FP0,FP0
.L18:
            fmove.d FP0,(A0)
            bra.b   .L22
.L19:
            fsolt   D0
            eor.b   D1,D0
            bpl.b   .L20
            subq.l  #1,(4,A0)
            bcc.b   .L21
            subq.l  #1,(A0)
            bra.b   .L21
.L20:
            addq.l  #1,(4,A0)
            bcc.b   .L21
            addq.l  #1,(A0)
.L21:
            move.l  (A0),D0
            bfchg   D0{1:11}
            bne.b   .L23
.L22:
            bsr.w   postFMOVE
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L24
.L23:
            bsr.w   postFMOVE
            bfchg   D0{1:11}
            bne.b   .L24
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L24:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
QNEXTS:
            link.w  A6,#-$5E
            move.l  #$101013,(-4,A6)
            movem.l D0-D3/A0,-(SP)
            movea.l (8,A6),A0
            move.l  (A0),D1
            movea.l ($C,A6),A0
            move.l  (A0),D0
            bsr.w   preFMOVE
            fmove.s D1,FP1
            fmove.s D0,FP0
            fcmp.x  FP0,FP1
            fbogl.w .L26
            fbeq.w  .L25
            fcmp.x  FP0,FP0
            fbun.w  .L25
            fmove.x FP1,FP0
.L25:
            fmove.s FP0,(A0)
            bsr.w   postFMOVE
            bra.b   .L30
.L26:
            bsr.w   postFMOVE
            bftst   D0{1:31}
            bne.b   .L27
            moveq   #2,D0
            add.l   D1,D1
            roxr.l  #1,D0
            move.l  D0,(A0)
            bra.b   .L28
.L27:
            btst    #$1F,D0
            sne     D0
            fsolt   D1
            eor.b   D1,D0
            extb.l  D0
            add.l   D0,D0
            addq.l  #1,D0
            add.l   D0,(A0)
            move.l  (A0),D0
            bfchg   D0{1:8}
            bne.b   .L29
.L28:
            fmovecr.x #$32,FP1
            fscale.w #$8000,FP1
            fnop
            bra.b   .L30
.L29:
            bfchg   D0{1:8}
            bne.b   .L30
            fmovecr.x #$32,FP1
            fscale.w #$7FFF,FP1
            fnop
.L30:
            movem.l (SP)+,D0-D3/A0
            unlk    A6
            rtd     #8
QPROCEXIT:
            link.w  A6,#-$5A
            move.l  #$C0019,(-4,A6)
            movem.l D0-D1/A0,-(SP)
            fmove.l FPSR,D1
            bfexts  D1{24:5},D0
            bfins   D0,D1{16:7}
            move.l  (8,A6),-(SP)
            bsr.w   QSETENV
            bra.b   SetE
QXCPMAP:    ; all but overflow/underflow in the right order
            dc.w    $E080,$0820,$1040,$0410,$0208
QSETXCP:
            link.w  A6,#-$5A
            move.l  #$C0015,(-4,A6)
            movem.l D0-D1/A0,-(SP)
            movea.l (8,A6),A0
            moveq   #0,D1
            move.w  (A0),D1
            move.w  QXCPMAP(PC,D1.w*2),D1
SetE:
            fmove.l FPCR,D0
            and.w   D1,D0
            andi.w  #$DF00,D0
            beq.w   .L9
            cmpi.b  #4,CPUFlag
            blt.w   .L8
            movea.l D0,A0
            fmove.l FPSR,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            move.l  A0,D0
            btst    #$F,D0
            beq.b   .L2
            fmove.s #"$7FFFFFFF",FP1
            fbgt.w  .L7
            fnop
            bra.b   .L10
.L2:
            btst    #$E,D0
            beq.b   .L3
            fcmp.s  #"$7FBFFFFF",FP1
            bra.b   .L7
.L3:
            btst    #$C,D0
            beq.b   .L4
            fmove.s #"$7F000000",FP1
            dc.w    $F200,$04E3,$6036
.L4:
            btst    #$B,D0
            beq.b   .L5
            fmove.s #"$1F000000",FP1
            dc.w    $F200,$04E3,$6022
.L5:
            btst    #$A,D0
            beq.b   .L6
            fmove.b #1,FP1
            fdiv.b  #0,FP1
            bra.b   .L7
.L6:
            fmove.b #1,FP1
            fadd.s  #"$01000000",FP1
.L7:
            fnop
            bra.b   .L10
.L8:
            movea.l D1,A0
            moveq   #0,D0
            bsr.w   sub_408EDCF0.L8
            fnop
            bra.b   .L10
.L9:
            fmove.l FPSR,D0
            and.w   ($FF).w,D0
            or.w    D1,D0
            fmove.l D0,FPSR
.L10:
            movem.l (SP)+,D0-D1/A0
            unlk    A6
            rtd     #4
QCPYSGN:
            move.l  A0,-(SP)
            movea.l ($C,SP),A0
            bclr    #7,(A0)
            tst.w   ([8.w,SP])
            bpl.b   .L11
            bset    #7,(A0)
.L11:
            movea.l (SP)+,A0
            rtd     #8
WRITEFPU:
            movea.l (SP)+,A0
            jmp     CASEFP0(PC,D0.w*8)
CASEFP0:
            fmovem.x (SP)+,FP0
            bra.w   .L1
            fmovem.x (SP)+,FP1
            bra.w   .L1
            fmovem.x (SP)+,FP2
            bra.w   .L1
            fmovem.x (SP)+,FP3
            bra.w   .L1
            fmovem.x (SP)+,FP4
            bra.w   .L1
            fmovem.x (SP)+,FP5
            bra.w   .L1
            fmovem.x (SP)+,FP6
            bra.w   .L1
            dc.w    $F21F,$D001
.L1:
            jmp     (A0)
NAN2FPU:
            clr.l   -(SP)
            move.l  #$40000000,-(SP)
            move.b  D1,(1,SP)
            move.l  #$7FFF0000,-(SP)
            bsr.b   WRITEFPU
            rts
DZHANDLER040:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   .L2
.L1:
            frestore (SP)+
            rte
.L2:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            moveq   #$7F,D1
            bftst   D2{7:3}
            bne.w   sub_408EDA10.L6
            and.w   D2,D1
            bclr    #6,D1
            beq.b   .L3
            bclr    #2,D1
.L3:
            bfextu  D2{22:3},D0
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  #$7FFF0000,-(SP)
            cmpi.b  #$20,D1
            beq.b   .L4
            cmpi.b  #$24,D1
            beq.b   .L4
            cmpi.b  #6,D1
            beq.b   .L6
            cmpi.b  #$14,D1
            beq.b   .L6
            cmpi.b  #$15,D1
            beq.b   .L6
            cmpi.b  #$16,D1
            beq.b   .L6
            cmpi.b  #$D,D1
            beq.b   .L7
            lea     ($C,SP),SP
            bra.w   sub_408EDA10.L6
.L4:
            move.l  (-$18,A1),D1
            move.l  (-$C,A1),D2
            eor.l   D1,D2
            bpl.b   .L5
            bset    #7,(SP)
.L5:
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
.L6:
            bset    #7,(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
.L7:
            btst    #7,(-$C,A1)
            beq.b   .L8
            bset    #7,(SP)
.L8:
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
STDHANDLER040:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   sub_408ED99E
.L1:
            frestore (SP)+
            rte
sub_408ED99E:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   sub_408EDA10.L6
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   sub_408EDA10.L6
.L1:
            bfextu  D2{22:3},D0
            lea     (-$C,A1),A0
            bfextu  (-$28,A1){0:3},D1
            cmpi.b  #3,D1
            beq.b   .L2
            lea     (-$C,A0),A0
.L2:
            move.l  (8,A0),D1
            move.l  D1,-(SP)
            move.l  (4,A0),D1
            bset    #$1E,D1
            move.l  D1,-(SP)
            move.l  (A0),-(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDA10.L6
OPERRHANDLER040:
            fsave   -(SP)
            tst.b   (SP)
            beq.b   .L1
            tst.b   (1,SP)
            bne.b   sub_408EDA10
.L1:
            frestore (SP)+
            rte
sub_408EDA10:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   .L6
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   .L6
.L1:
            bfextu  D2{25:7},D1
            bpl.b   .L2
            bclr    #6,D1
            bclr    #2,D1
            cmpi.b  #1,D1
            bne.b   .L2
            moveq   #4,D1
.L2:
            move.b  .L4(PC,D1.w),D1
            beq.b   .L3
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bra.b   .L6
.L3:
            move.b  #$21,D1
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bfextu  D2{29:3},D0
            bsr.w   NAN2FPU
            bra.b   .L6
.L4:
            dc.w    $FFFF,$FFFF,$01FF,$24FF,$FFFF,$FFFF,$2224,$2121
            dc.w    $FFFF,$FFFF,$2424,$24FF,$FFFF,$FFFF,$2221,$FFFF
            dc.w    $0409,$0208,$0409,$FF08,$02FF,$FFFF,$FFFF,$FFFF
            ds.b    8
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,$F018,$2A4A
.L5:
            dc.w    $F327,$4A17,$6706,$4A2F,$0001,$6604,$F35F,$4E73
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            moveq   #4,D0
            add.b   ($21,SP),D0
            lea     ($20,SP),A1
            adda.l  D0,A1
.L6:
            movem.l (SP),D1-D2
            bclr    #1,(-$1C,A1)
            bne.b   .L7
            bclr    #2,(-$1C,A1)
.L7:
            movea.l (8,SP),A0
            suba.l  ($B6E).w,A0
            dc.w    $02FA,$8000,$FFBA,$6500,$033C,$9CFC,$0018,$F226
            dc.w    $BC00,$9CFC,$000C,$2001,$ECC0,$0408,$F200,$9000
            dc.w    $2001,$ECC0,$0403,$E8C1,$0402,$6704,$EEC0,$0403
            dc.w    $C042,$E8C0,$0402,$6704,$08C0,$000D,$E9C0,$0485
            dc.w    $103B,$0120,$F7A8,$41EE,$0030,$514E,$3C80,$2D0E
            dc.w    $2D28,$0010,$2D28,$000C,$2D28,$0008,$3D28,$FFFE
            dc.w    $3028,$FFFC,$E448,$5940,$6706,$6B08,$2D28,$0010
            dc.w    $2D28,$000C,$2D28,$0008,$43FA,$02D6,$2D09,$2D10
            dc.w    $2D28,$FFFC,$584E,$6000,$02BC
sub_408EDB88:
            movea.l (SP)+,A0
            jmp     .L1(PC,D0.w*8)
.L1:
            fmovem.x FP0,-(SP)
            bra.w   .L2
            fmovem.x FP1,-(SP)
            bra.w   .L2
            fmovem.x FP2,-(SP)
            bra.w   .L2
            fmovem.x FP3,-(SP)
            bra.w   .L2
            fmovem.x FP4,-(SP)
            bra.w   .L2
            fmovem.x FP5,-(SP)
            bra.w   .L2
            fmovem.x FP6,-(SP)
            bra.w   .L2
            dc.w    $F227,$E080
.L2:
            jmp     (A0)
DZHANDLER:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   .L1
            frestore (SP)+
            rte
.L1:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            moveq   #$3F,D1
            bftst   D2{7:3}
            bne.w   sub_408EDCF0.L5
            and.w   D2,D1
            bfextu  D2{22:3},D0
            clr.w   D2
            move.b  ($21,SP),D2
            move.l  ($10,SP,D2.w),D2
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  #$7FFF0000,-(SP)
            cmpi.b  #$20,D1
            beq.b   .L2
            cmpi.b  #$24,D1
            beq.b   .L2
            cmpi.b  #6,D1
            beq.b   .L4
            cmpi.b  #$14,D1
            beq.b   .L4
            cmpi.b  #$15,D1
            beq.b   .L4
            cmpi.b  #$16,D1
            beq.b   .L4
            cmpi.b  #$D,D1
            beq.b   .L5
            lea     ($C,SP),SP
            bra.w   sub_408EDCF0.L5
.L2:
            bsr.w   sub_408EDB88
            move.l  (SP)+,D1
            addq.w  #8,SP
            eor.l   D1,D2
            bpl.b   .L3
            bset    #7,(SP)
.L3:
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L4:
            bset    #7,(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L5:
            tst.l   D2
            bpl.b   .L6
            bset    #7,(SP)
.L6:
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
sub_408EDC6E:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   sub_408EDC78
            frestore (SP)+
            rte
sub_408EDC78:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   sub_408EDCF0.L5
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   sub_408EDCF0.L5
.L1:
            bfextu  D2{22:3},D0
            bsr.w   sub_408EDB88
            lea     (SP),A1
            move.l  (A1)+,D1
            not.l   D1
            bftst   D1{1:15}
            bne.b   .L2
            move.l  (A1)+,D1
            bclr    #$1F,D1
            or.l    (A1),D1
            beq.b   .L2
            bset    #6,-(A1)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
.L2:
            lea     ($C,SP),SP
            clr.w   D1
            move.b  ($21,SP),D1
            lea     ($18,SP,D1.w),A1
            move.l  (A1),-(SP)
            move.l  -(A1),-(SP)
            bset    #6,(SP)
            move.l  -(A1),-(SP)
            bsr.w   WRITEFPU
            bra.w   sub_408EDCF0.L5
OPERRHANDLER:
            fsave   -(SP)
            tst.b   (SP)
            bne.b   sub_408EDCF0
            frestore (SP)+
            rte
sub_408EDCF0:
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
            movea.l (8,SP),A0
            move.l  (A0),D2
            bftst   D2{7:3}
            bne.w   .L5
            bfextu  D2{16:3},D0
            beq.b   .L1
            subq.w  #2,D0
            beq.b   .L1
            bra.w   .L5
.L1:
            move.w  D2,D1
            andi.w  #$3F,D1
            move.b  .L3(PC,D1.w),D1
            beq.b   .L2
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bra.b   .L5
.L2:
            move.b  #$21,D1
            bfextu  D2{22:3},D0
            bsr.w   NAN2FPU
            bfextu  D2{29:3},D0
            bsr.w   NAN2FPU
            bra.b   .L5
.L3:
            dc.w    $FFFF,$FFFF,$01FF,$24FF,$FFFF,$FFFF,$2224,$2121
            dc.w    $FFFF,$FFFF,$2424,$24FF,$FFFF,$FFFF,$2221,$FFFF
            dc.w    $0409,$0208,$0409,$FF08,$02FF,$FFFF,$FFFF,$FFFF
            ds.b    8
            dc.w    $FFFF,$FFFF,$FFFF,$FFFF,0,$0080
.L4:
            dc.w    $F327,$4A17,$6604,$F35F,$4E73
            movem.l D0-D2/A0-A1,-(SP)
            fmovem.l FPCR/FPSR/FPIAR,-(SP)
.L5:
            movem.l (SP),D1-D2
            clr.w   D0
            move.b  ($21,SP),D0
            bset    #3,($20,SP,D0.w)
            movea.l (8,SP),A0
            suba.l  ($B6E).w,A0
            dc.w    $02FA,$8000,$FD0A,$6410,$206F,$0008,$91F8,$065C
            dc.w    $02FA,$8000,$FFBE,$657C,$9CFC,$0018,$F226,$BC00
            dc.w    $9CFC,$000C,$2001,$ECC0,$0408,$F200,$9000,$2001
            dc.w    $ECC0,$0403,$E8C1,$0402,$6704,$EEC0,$0403,$C042
            dc.w    $E8C0,$0402,$6704,$08C0,$000D,$E9C0,$0485,$103B
            dc.w    $0120,$F4EA,$41EE,$0030,$514E,$3C80,$2D0E,$2D28
            dc.w    $0010,$2D28,$000C,$2D28,$0008,$3D28,$FFFE,$3028
            dc.w    $FFFC,$E448,$5940,$6706,$6B08,$2D28,$0010,$2D28
            dc.w    $000C,$2D28,$0008,$43FA,$0018,$2D09,$2D10,$2D28
            dc.w    $FFFC,$584E,$4FEF,$000C,$4CDF,$0307,$F35F,$4E73
            fmovem.x FP3,($1A,SP)
            movem.l D0-D2/A0-A1,($32,SP)
            lea     ($14,SP),A0
            move    CCR,(A0)+
            move.l  D0,(A0)
            tst.w   (-4,A0)
            beq.b   .L6
            movea.l ($A4C).w,A0
            jsr     (A0)
            bra.b   .L7
.L6:
            lea     ($12,SP),SP
.L7:
            lea     ($34,SP),A6
            move.w  (A6),D1
            move.l  (8,A6),(0,A6,D1.w)
            addq.w  #2,SP
            move.l  (2,SP),($1E,SP)
            move    (SP),CCR
            addq.w  #6,SP
            fmovem.x (SP)+,FP3
            fmovem.l (SP)+,FPCR/FPSR/FPIAR
            movem.l (SP)+,D0-D2/A0-A1
            movea.l (4,A6),A6
            adda.w  (SP),SP
            rts
.L8:
            dc.w    $A097
            rts

            EVEN
