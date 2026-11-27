FP68K:
            bra.b   OMEGA881BASE
            dc.w    0
            dc.b    'PACK'
            dc.w    4,8                     ; PACK 4, version 8
OMEGA881BASE:
            subq.w  #2,SP
            movem.l D0/A0-A1,-(SP)
            lea     (QADDX.w,PC),A0
            move.l  A0,($B6E).w
            move.w  ($12,SP),D0
            bne.b   OBASENOTADD
            movea.l ($E,SP),A1
            subq.l  #2,A1
            cmpi.w  #$A9EB,(A1)
            bne.b   VECTOROFF
            subq.l  #2,A1
            cmpi.w  #$4267,(A1)
            beq.b   FOUNDADD
            subq.l  #2,A1
            bra.b   TRYLONGADD
FOUNDADD:
            move.w  #$4EB8,(A1)+
            move.w  #$B6C,(A1)
            bsr.b   FlushIt
            move.w  #$4EF9,($B6C).w
            movea.w #$B6C,A1
            bra.b   PullTheHandle
OBASENOTADD:
            rol.w   #8,D0
            lsl.b   #2,D0
            bfexts  D0{18:10},D0
            move.w  (FP881CASE.w,PC,D0.w),D0      ; D0 = offset
            lea     OMEGA881BASE(PC,D0.w),A0
            movea.l ($E,SP),A1
            subq.l  #2,A1
            cmpi.w  #$A9EB,(A1)
            bne.b   VECTOROFF
            subq.l  #4,A1
TRYLONGADD:
            cmpi.w  #$3F3C,(A1)
            bne.b   VECTOROFF
            move.w  #$4EB9,(A1)+
            move.l  A0,(A1)
PullTheHandle:
            bsr.b   FlushIt
VECTOROFF:
            move.l  ($E,SP),($10,SP)
            move.l  A0,($C,SP)
            lea     (OPERRHANDLER.w,PC),A0
            cmpi.b  #cpu68040,CPUFlag
            blt.b   .notAn040
            lea     (OPERRHANDLER040.w,PC),A0
            move.l  A0,($1FD4).w
            bra.b   .getOnWithIt
.notAn040:
            move.l  A0,OPERRVector
.getOnWithIt:
            fmove.l FPCR,D0
            bset    #$D,D0
            fmove.l D0,FPCR
            movem.l (SP)+,D0/A0-A1
            rts
FlushIt:
            cmpi.b  #cpu68040,CPUFlag
            blt.b   .L2
            movem.l D0-D4/A1-A2,-(SP)
            move    SR,D0
            btst    #$D,D0
            bne.b   .InSuper
            moveq   #8,D0
            _DebugUtil
.InSuper:
            moveq   #5,D1
            movec   D1,DFC
            moveq   #1,D4
            subq.l  #2,A1
            movea.l A1,A2
            ori     #$700,SR
            move.w  #$D000,D3
            mc68040
            movec   TC,D2
            mc68030
            lsr.w   #2,D2
            eor.w   D2,D3
.FlusherRoo:
            mc68040
            ptestr  (A1)
            movec   MMUSR,D1
            mc68030
            and.w   D3,D1
            move.w  A1,D2
            not.w   D3
            and.w   D3,D2
            or.w    D2,D1
            movea.l D1,A1
            mc68040
            cpushl  BC,(A1)
            mc68030
            not.w   D3
            movea.l A2,A1
            lea     ($10,A1),A1
            dbra    D4,.FlusherRoo
            move    D0,SR
            movem.l (SP)+,D0-D4/A1-A2
            rts
.L2:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            rts

            dc.w    QADDX96-OMEGA881BASE
            dc.w    QADDD96-OMEGA881BASE
            dc.w    QADDS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QADDI96-OMEGA881BASE
            dc.w    QADDL96-OMEGA881BASE
            dc.w    QADDC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETENV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSUBX96-OMEGA881BASE
            dc.w    QSUBD96-OMEGA881BASE
            dc.w    QSUBS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QSUBI96-OMEGA881BASE
            dc.w    QSUBL96-OMEGA881BASE
            dc.w    QSUBC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QGETENV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QMULX96-OMEGA881BASE
            dc.w    QMULD96-OMEGA881BASE
            dc.w    QMULS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QMULI96-OMEGA881BASE
            dc.w    QMULL96-OMEGA881BASE
            dc.w    QMULC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETHV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QDIVX96-OMEGA881BASE
            dc.w    QDIVD96-OMEGA881BASE
            dc.w    QDIVS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QDIVI96-OMEGA881BASE
            dc.w    QDIVL96-OMEGA881BASE
            dc.w    QDIVC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QGETHV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCMPX96-OMEGA881BASE
            dc.w    QCMPD96-OMEGA881BASE
            dc.w    QCMPS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCMPI96-OMEGA881BASE
            dc.w    QCMPL96-OMEGA881BASE
            dc.w    QCMPC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QDEC2X96-OMEGA881BASE
            dc.w    QDEC2D-OMEGA881BASE
            dc.w    QDEC2S-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QDEC2I-OMEGA881BASE
            dc.w    QDEC2L-OMEGA881BASE
            dc.w    QDEC2C-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCPXX96-OMEGA881BASE
            dc.w    QCPXD96-OMEGA881BASE
            dc.w    QCPXS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCPXI96-OMEGA881BASE
            dc.w    QCPXL96-OMEGA881BASE
            dc.w    QCPXC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2DEC96-OMEGA881BASE
            dc.w    QD2DEC-OMEGA881BASE
            dc.w    QS2DEC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QI2DEC-OMEGA881BASE
            dc.w    QL2DEC-OMEGA881BASE
            dc.w    QC2DEC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QREMX96-OMEGA881BASE
            dc.w    QREMD96-OMEGA881BASE
            dc.w    QREMS96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QREMI96-OMEGA881BASE
            dc.w    QREML96-OMEGA881BASE
            dc.w    QREMC96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QNEG-OMEGA881BASE
            dc.w    QNEG-OMEGA881BASE
            dc.w    QNEG-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2X96-OMEGA881BASE
            dc.w    QD2X96-OMEGA881BASE
            dc.w    QS2X96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QI2X96-OMEGA881BASE
            dc.w    QL2X96-OMEGA881BASE
            dc.w    QC2X96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QABS-OMEGA881BASE
            dc.w    QABS-OMEGA881BASE
            dc.w    QABS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2X96-OMEGA881BASE
            dc.w    QX2D96-OMEGA881BASE
            dc.w    QX2S96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QX2I96-OMEGA881BASE
            dc.w    QX2L96-OMEGA881BASE
            dc.w    QX2C96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSQRTX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QNEXTX96-OMEGA881BASE
            dc.w    QNEXTD-OMEGA881BASE
            dc.w    QNEXTS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QRINTX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETXCP-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QTINTX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QPROCENTRY-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSCALBX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QSCALBX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QPROCEXIT-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QLOGBX96-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QTESTXCP-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCLASSX96-OMEGA881BASE
            dc.w    QCLASSD-OMEGA881BASE
            dc.w    QCLASSS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCLASSC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
FP881CASE:
            dc.w    QADDX-OMEGA881BASE
            dc.w    QADDD-OMEGA881BASE
            dc.w    QADDS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QADDI-OMEGA881BASE
            dc.w    QADDL-OMEGA881BASE
            dc.w    QADDC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETENV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSUBX-OMEGA881BASE
            dc.w    QSUBD-OMEGA881BASE
            dc.w    QSUBS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QSUBI-OMEGA881BASE
            dc.w    QSUBL-OMEGA881BASE
            dc.w    QSUBC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QGETENV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QMULX-OMEGA881BASE
            dc.w    QMULD-OMEGA881BASE
            dc.w    QMULS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QMULI-OMEGA881BASE
            dc.w    QMULL-OMEGA881BASE
            dc.w    QMULC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETHV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QDIVX-OMEGA881BASE
            dc.w    QDIVD-OMEGA881BASE
            dc.w    QDIVS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QDIVI-OMEGA881BASE
            dc.w    QDIVL-OMEGA881BASE
            dc.w    QDIVC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QGETHV-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCMPX-OMEGA881BASE
            dc.w    QCMPD-OMEGA881BASE
            dc.w    QCMPS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCMPI-OMEGA881BASE
            dc.w    QCMPL-OMEGA881BASE
            dc.w    QCMPC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QDEC2X-OMEGA881BASE
            dc.w    QDEC2D-OMEGA881BASE
            dc.w    QDEC2S-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QDEC2I-OMEGA881BASE
            dc.w    QDEC2L-OMEGA881BASE
            dc.w    QDEC2C-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCPXX-OMEGA881BASE
            dc.w    QCPXD-OMEGA881BASE
            dc.w    QCPXS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCPXI-OMEGA881BASE
            dc.w    QCPXL-OMEGA881BASE
            dc.w    QCPXC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2DEC-OMEGA881BASE
            dc.w    QD2DEC-OMEGA881BASE
            dc.w    QS2DEC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QI2DEC-OMEGA881BASE
            dc.w    QL2DEC-OMEGA881BASE
            dc.w    QC2DEC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QREMX-OMEGA881BASE
            dc.w    QREMD-OMEGA881BASE
            dc.w    QREMS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QREMI-OMEGA881BASE
            dc.w    QREML-OMEGA881BASE
            dc.w    QREMC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QNEG-OMEGA881BASE
            dc.w    QNEG-OMEGA881BASE
            dc.w    QNEG-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2X-OMEGA881BASE
            dc.w    QD2X-OMEGA881BASE
            dc.w    QS2X-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QI2X-OMEGA881BASE
            dc.w    QL2X-OMEGA881BASE
            dc.w    QC2X-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QABS-OMEGA881BASE
            dc.w    QABS-OMEGA881BASE
            dc.w    QABS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QX2X-OMEGA881BASE
            dc.w    QX2D-OMEGA881BASE
            dc.w    QX2S-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QX2I-OMEGA881BASE
            dc.w    QX2L-OMEGA881BASE
            dc.w    QX2C-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    QCPYSGN-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSQRTX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QNEXTX-OMEGA881BASE
            dc.w    QNEXTD-OMEGA881BASE
            dc.w    QNEXTS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QRINTX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSETXCP-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QTINTX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QPROCENTRY-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QSCALBX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QSCALBX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QPROCEXIT-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QLOGBX-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QTESTXCP-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    QCLASSX-OMEGA881BASE
            dc.w    QCLASSD-OMEGA881BASE
            dc.w    QCLASSS-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    QCLASSC-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE

            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
            dc.w    UnknownOp-OMEGA881BASE
UnknownOp:
            moveq   #81,D0                          ; Error exit for unknown opcode
            _SysError
