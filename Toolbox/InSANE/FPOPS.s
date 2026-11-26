            include "Include/ROMHeader.s"

            EXPORT  QABS_PACK_4_2,QADDB,QADDX_PACK_4_2,QB2X,QCLASSB,QCLASSX_PACK_4_2
            EXPORT  QCMPB,QCMPX_PACK_4_2,QCPYSGN_PACK_4_2,QDIVB,QDIVX_PACK_4_2,QGETENV_PACK_4_2
            EXPORT  QGETHV_PACK_4_2,QLOGBX_PACK_4_2,QMULB,QMULX_PACK_4_2,QNEG_PACK_4_2,QNEXTB
            EXPORT  QPROCENTRY_PACK_4_2,QPROCEXIT_PACK_4_2,QREMB,QREMX_PACK_4_2,QRINTX_PACK_4_2,QSCALBX_PACK_4_2
            EXPORT  QSETENV_PACK_4_2,QSETHV_PACK_4_2,QSETXCP_PACK_4_2,QSQRTX_PACK_4_2,QSUBB,QSUBX_PACK_4_2
            EXPORT  QTESTXCP_PACK_4_2,QTINTX_PACK_4_2,QX2B,QX2X_PACK_4_2

            IMPORT  COERCE,COERCED,COERCES,COERCEX,DCOERCE,FINI1OP
            IMPORT  FINI2OPS,FINICMPS,FP020,FPNANIN,FPNANOUT,INVALIDOP
            IMPORT  NORMCOERCE,PACKX,RDST,RDSTSGN,RTSHIFT,SCOERCE
            IMPORT  UNPACKXB,UNPACKXX,UNPBOP,UNPXOP,ZNORMCOERCEX

            SECTION "FPOPS",CODE

QADDX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     ADDTOP,A0
            bra.w   UNPACKXX
QADDB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     ADDTOP,A0
            bra.w   UNPACKXB
QSUBX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     SUBTOP,A0
            bra.w   UNPACKXX
QSUBB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     SUBTOP,A0
            bra.w   UNPACKXB
SUBTOP:
            eori.b  #$A0,D6
ADDTOP:
            lea     (FINI2OPS.w,PC),A0
            move.w  .L2(PC,D0.w),D0
            jmp     ADDTOP(PC,D0.w)
.L2:
            dc.w    ADDNUM-ADDTOP
            dc.w    ADDEM.L30-ADDTOP
            dc.w    PACKX-ADDTOP
            dc.w    ADDEM.L31-ADDTOP
            dc.w    ADDEM.L27-ADDTOP
            dc.w    PACKX-ADDTOP
            dc.w    RDSTSGN-ADDTOP
            dc.w    RDSTSGN-ADDTOP
            dc.w    ADDEM.L32-ADDTOP
ADDNUM:
            exg     D4,D3
            exg     D5,A2
            move.w  A4,D0
            sub.w   A3,D0
            beq.w   ADDEM
            bgt.b   .L4
            exg     D5,A2
            exg     D4,D3
            movea.l A3,A4
            add.b   D6,D6
            neg.w   D0
            asr.b   #1,D6
.L4:
            move.l  D0,D2
            cmpi.w  #$42,D0
            bhi.w   ADDSHLOTS
            add.w   D2,D2
            move.w  ADDSHCASE(PC,D2.w),D2
            jmp     ADDNUM(PC,D2.w)
ADDSHCASE:
            dc.w    ADDEM-ADDNUM
            dc.w    ADDSH1-ADDNUM
            dc.w    ADDSH2-ADDNUM
            dc.w    ADDSH3-ADDNUM
            dc.w    ADDSH4-ADDNUM
            dc.w    ADDSH5-ADDNUM
            dc.w    ADDSH6-ADDNUM
            dc.w    ADDSH7-ADDNUM
            dc.w    ADDSH8-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH16-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH2TO31-ADDNUM
            dc.w    ADDSH32-ADDNUM
            dc.w    ADDSH33-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH33TO63-ADDNUM
            dc.w    ADDSH64-ADDNUM
            dc.w    ADDSH65-ADDNUM
            dc.w    ADDSH66-ADDNUM
ADDSHLOTS:
            moveq   #0,D4
            moveq   #0,D5
            not.b   D7
            bra.w   ADDEM
ADDSH66:
            or.w    D4,D5
            tst.l   D5
            sne     D7
            lsr.l   #2,D4
            bra.b   BIGSTICK
ADDSH65:
            or.w    D4,D5
            tst.l   D5
            sne     D7
            lsr.l   #1,D4
            bra.b   BIGSTICK
ADDSH64:
            tst.l   D5
            sne     D7
BIGSTICK:
            or.l    D4,D7
            moveq   #0,D4
            moveq   #0,D5
            bra.w   ADDEM
ADDSH33TO63:
            move.l  D5,D7
            subi.w  #$20,D0
            move.l  D4,D5
            ror.l   D0,D7
            lsr.l   D0,D5
            bftst   D7{0:D0}
            beq.b   .L12
            ori.w   #$FF,D7
.L12:
            bfins   D4,D7{0:D0}
            moveq   #0,D4
            bra.w   ADDEM
ADDSH33:
            move.l  D5,D7
            move.l  D4,D5
            moveq   #0,D4
            lsr.l   #1,D5
            roxr.l  #1,D7
            scs     D7
            bra.w   ADDEM
ADDSH32:
            move.l  D5,D7
            move.l  D4,D5
            moveq   #0,D4
            bra.w   ADDEM
ADDSH2TO31:
            bfins   D5,D7{0:D0}
            lsr.l   D0,D5
            bfins   D4,D5{0:D0}
            lsr.l   D0,D4
            bra.b   ADDEM
ADDSH16:
            move.w  D5,D7
            move.w  D4,D5
            clr.w   D4
            swap    D5
            swap    D4
            swap    D7
            bra.b   ADDEM
ADDSH8:
            bfins   D5,D7{0:8}
            move.b  D4,D5
            lsr.l   #8,D4
            ror.l   #8,D5
            bra.b   ADDEM
ADDSH7:
            bfins   D5,D7{0:7}
            lsr.l   #7,D5
            bfins   D4,D5{0:7}
            lsr.l   #7,D4
            bra.b   ADDEM
ADDSH6:
            bfins   D5,D7{0:6}
            lsr.l   #6,D5
            bfins   D4,D5{0:6}
            lsr.l   #6,D4
            bra.b   ADDEM
ADDSH5:
            bfins   D5,D7{0:5}
            lsr.l   #5,D5
            bfins   D4,D5{0:5}
            lsr.l   #5,D4
            bra.b   ADDEM
ADDSH4:
            bfins   D5,D7{0:4}
            lsr.l   #4,D5
            bfins   D4,D5{0:4}
            lsr.l   #4,D4
            bra.b   ADDEM
ADDSH3:
            bfins   D5,D7{0:3}
            lsr.l   #3,D5
            bfins   D4,D5{0:3}
            lsr.l   #3,D4
            bra.b   ADDEM
ADDSH2:
            bfins   D5,D7{0:2}
            lsr.l   #2,D5
            bfins   D4,D5{0:2}
            lsr.l   #2,D4
            bra.b   ADDEM
ADDSH1:
            lsr.l   #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
ADDEM:
            btst    #5,D6
            bne.b   .L26
            add.l   A2,D5
            addx.l  D3,D4
            bcc.w   COERCE
            roxr.l  #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
            scs     D1
            or.b    D1,D7
            addq.l  #1,A4
            bra.w   COERCE
.L26:
            not.b   D6
            sub.l   A2,D5
            subx.l  D3,D4
            beq.b   .L28
            bcc.w   NORMCOERCE
            neg.l   D7
            negx.l  D5
            negx.l  D4
            not.b   D6
            bra.w   NORMCOERCE
.L27:
            btst    #5,D6
            beq.w   PACKX
.L28:
            suba.l  A4,A4
            movea.w #$A4A,A1
            clr.b   D6
            btst    #6,(A1)
            beq.b   .L29
            btst    #5,(A1)
            bne.b   .L29
            not.b   D6
.L29:
            bra.w   PACKX
.L30:
            move.l  A2,D5
            move.l  D3,D4
            movea.l A3,A4
            add.b   D6,D6
.L31:
            bra.w   COERCE
.L32:
            btst    #5,D6
            bne.b   .L33
            bra.w   PACKX
.L33:
            moveq   #2,D0
            bra.w   INVALIDOP
QMULX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8796,A0
            bra.w   UNPACKXX
QMULB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8796,A0
            bra.w   UNPACKXB
sub_408E8796:
            lea     (FINI2OPS.w,PC),A0
            lsl.b   #2,D6
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E8796(PC,D0.w)
.L1:
            dc.w    .L2-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    RDST-sub_408E8796
            dc.w    PACKX-sub_408E8796
            dc.w    .L5-sub_408E8796
            dc.w    RDST-sub_408E8796
            dc.w    .L5-sub_408E8796
            dc.w    PACKX-sub_408E8796
.L2:
            adda.l  A3,A4
            suba.w  #$3FFE,A4
            move.l  D3,D2
            move.l  A2,D3
            movea.l D6,A1
            movea.l D4,A2
            movea.l D5,A3
            moveq   #0,D7
            moveq   #0,D6
            move.l  A2,D5
            mulu.l  D2,D4:D5
            move.l  A3,D7
            beq.b   .L3
            mulu.l  D2,D0:D7
            add.l   D0,D5
            addx.l  D6,D4
.L3:
            move.l  D3,D0
            beq.b   .L4
            move.l  A2,D1
            mulu.l  D0,D0:D1
            add.l   D1,D7
            addx.l  D0,D5
            addx.l  D6,D4
            move.l  A3,D1
            beq.b   .L4
            mulu.l  D3,D0:D1
            add.l   D0,D7
            addx.l  D6,D5
            addx.l  D6,D4
            tst.l   D1
            sne     D1
            or.b    D1,D7
.L4:
            move.l  A1,D6
            bra.w   NORMCOERCE
.L5:
            moveq   #8,D0
            bra.w   INVALIDOP
QDIVX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E882C,A0
            bra.w   UNPACKXX
QDIVB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E882C,A0
            bra.w   UNPACKXB
sub_408E882C:
            lea     (FINI2OPS.w,PC),A0
            lsl.b   #2,D6
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E882C(PC,D0.w)
.L1:
            dc.w    .L5-sub_408E882C
            dc.w    .L2-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    .L4-sub_408E882C
            dc.w    .L3-sub_408E882C
            dc.w    RDST-sub_408E882C
            dc.w    RDST-sub_408E882C
            dc.w    .L4-sub_408E882C
.L2:
            bset    #$B,D6
            movea.w #$7FFF,A4
            moveq   #0,D4
            moveq   #0,D5
            bra.w   PACKX
.L3:
            suba.l  A4,A4
            move.l  A4,D4
            move.l  D4,D5
            bra.w   PACKX
.L4:
            moveq   #4,D0
            bra.w   INVALIDOP
.L5:
            exg     A3,A4
            suba.l  A3,A4
            lea     ($3FFF,A4),A4
            movea.l D6,A3
            move.l  D3,D2
            move.l  A2,D3
            moveq   #0,D1
            move.l  D2,D6
            sub.l   D5,D3
            subx.l  D4,D2
            bcc.b   .L6
            subq.l  #1,A4
            add.l   A2,D3
            addx.l  D6,D2
.L6:
            bsr.b   DIV32
            movea.l D0,A2
            bsr.b   DIV32
            move.l  D0,D5
            move.l  A2,D4
            move.l  A3,D6
            moveq   #1,D7
            lsr.l   #1,D7
            roxr.l  #1,D4
            roxr.l  #1,D5
            roxr.l  #1,D7
            or.l    D2,D3
            sne     D7
            bra.w   COERCE
DIV32:
            divu.l  D4,D2:D3
            bvs.b   sub_408E88C8
            move.l  D3,D0
            move.l  D3,D7
            mulu.l  D5,D6:D7
.L1:
            move.l  D1,D3
            sub.l   D7,D3
            subx.l  D6,D2
            bcc.b   .L3
.L2:
            subq.l  #1,D0
            add.l   D5,D3
            addx.l  D4,D2
            bcc.b   .L2
.L3:
            rts
sub_408E88C8:
            move.l  D5,D6
            moveq   #0,D7
            move.l  D3,D2
            moveq   #0,D0
            bra.b   DIV32.L1
QREMX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     REMTOP,A0
            bra.w   UNPACKXX
QREMB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     REMTOP,A0
            bra.w   UNPACKXB
REMTOP:
            lea     (FINI2OPS.w,PC),A0
            clr.w   (2,SP)
            add.b   D6,D6
            move.w  REMCASE(PC,D0.w),D0
            jmp     REMTOP(PC,D0.w)
REMCASE:
            dc.w    REMNUM-REMTOP
            dc.w    INVREM-REMTOP
            dc.w    REMDST-REMTOP
            dc.w    RDST-REMTOP
            dc.w    INVREM-REMTOP
            dc.w    RDST-REMTOP
            dc.w    INVREM-REMTOP
            dc.w    INVREM-REMTOP
            dc.w    INVREM-REMTOP
INVREM:
            moveq   #9,D0
            bra.w   INVALIDOP
REMNUM:
            move.l  A3,D0
            addq.l  #1,D0
            sub.l   A4,D0
            bpl.b   REMDIV
REMDST:
            move.l  D3,D4
            move.l  A2,D5
            movea.l A3,A4
            bra.b   REMFIN
REMDIV:
            subq.l  #1,A4
            cmpi.l  #9,D0
            bgt.b   REMSHIFT
            move.l  D3,D1
            move.l  A2,D2
            move.l  D4,D3
            movea.l D5,A2
            addq.l  #1,D0
            bsr.b   RESTORE
REMPOSTRESTORING:
            btst    #0,D5
            beq.b   REMQUO
            tst.l   D1
            bne.b   .L7
            tst.l   D2
            bne.b   .L7
            btst    #1,D5
            beq.b   .L8
.L7:
            bchg    #7,D6
            addq.w  #2,D5
.L8:
            exg     D2,A2
            exg     D1,D3
            sub.l   A2,D2
            subx.l  D3,D1
REMQUO:
            lsr.b   #1,D5
            btst    #6,D6
            beq.b   .L10
            neg.b   D5
.L10:
            ext.w   D5
            move.w  D5,(2,SP)
            move.l  D1,D4
            move.l  D2,D5
REMFIN:
            bra.w   ZNORMCOERCEX
RESTORE:
            moveq   #0,D4
            move.l  D4,D5
            bra.b   .L2
.L1:
            add.l   D5,D5
            addx.l  D4,D4
            add.l   D2,D2
            addx.l  D1,D1
            bcs.b   .L4
.L2:
            cmp.l   D3,D1
            bne.b   .L3
            cmp.l   A2,D2
.L3:
            bcs.b   .L5
.L4:
            addq.b  #1,D5
            sub.l   A2,D2
            subx.l  D3,D1
.L5:
            subq.w  #1,D0
            bne.b   .L1
            rts
REMSHIFT:
            movea.l D6,A3
            move.l  A2,D1
            moveq   #0,D2
            movea.l D0,A2
            andi.l  #$1F,D0
            beq.b   .L1
            bfextu  D3{0:D0},D2
            lsl.l   D0,D3
            bfextu  D1{0:D0},D6
            lsl.l   D0,D1
            or.l    D6,D3
.L1:
            bsr.w   DIV32
            move.l  A2,D6
            bfextu  D6{16:11},D6
            beq.b   REMDIVDONE
            movea.l D6,A1
            moveq   #0,D1
REMLP32:
            bsr.w   DIV32
            subq.l  #1,A1
            move.l  A1,D6
            bne.b   REMLP32
REMDIVDONE:
            move.l  D2,D1
            move.l  D3,D2
            move.l  D4,D3
            movea.l D5,A2
            move.l  D0,D5
            move.l  A3,D6
            bra.w   REMPOSTRESTORING
QCMPX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8A08,A0
            bra.w   UNPACKXX
QCMPB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     sub_408E8A08,A0
            bra.w   UNPACKXB
sub_408E8A08:
            move.w  .L1(PC,D0.w),D0
            jmp     sub_408E8A08(PC,D0.w)
.L1:
            dc.w    .L7-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L6-sub_408E8A08
            dc.w    .L3-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L2-sub_408E8A08
            dc.w    .L5-sub_408E8A08
.L2:
            add.b   D6,D6
            not.b   D6
.L3:
            moveq   #0,D7
            tst.b   D6
            bmi.b   .L4
            moveq   #$19,D7
.L4:
            bra.w   FINICMPS
.L5:
            btst    #5,D6
            bne.b   .L3
.L6:
            moveq   #4,D7
            bra.w   FINICMPS
.L7:
            btst    #5,D6
            bne.b   .L3
            cmpa.l  A4,A3
            bgt.b   .L8
            blt.b   .L9
            cmp.l   D4,D3
            bhi.b   .L8
            bcs.b   .L9
            cmpa.l  D5,A2
            beq.b   .L6
            bcs.b   .L9
.L8:
            not.b   D6
.L9:
            moveq   #$19,D7
            tst.b   D6
            bpl.w   FINICMPS
            moveq   #0,D7
            bra.w   FINICMPS
QX2X_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI2OPS.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
C2XCOMMON:
            moveq   #0,D7
            tst.w   D0
            bne.w   FPNANOUT
            tst.l   D0
            beq.w   COERCE
            bra.w   PACKX
QB2X:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI2OPS.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            move.l  D6,D1
            clr.w   D1
            rol.l   #6,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            movea.l ($E,A6),A1
            bsr.w   UNPBOP
            bra.b   C2XCOMMON
QSQRTX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI1OP.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L3
            tst.w   D0
            bne.w   FPNANOUT
            btst    #$11,D0
            bne.w   PACKX
            tst.b   D6
            bpl.w   PACKX
.L2:
            moveq   #1,D0
            bra.w   INVALIDOP
.L3:
            tst.b   D6
            bmi.b   .L2
            move.w  A4,D0
            asr.w   #1,D0
            move    SR,D7
            bcc.b   .L4
            addq.w  #1,D0
.L4:
            addi.w  #$1FFF,D0
            movea.w D0,A4
            movea.l D6,A3
            move.l  D5,D3
            move.l  D4,D2
            add.l   D3,D3
            addx.l  D2,D2
            moveq   #1,D1
            move    D7,CCR
            bcs.b   .L5
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
.L5:
            subq.w  #1,D1
            moveq   #1,D0
            moveq   #0,D4
            move.l  D4,D5
            move.l  #$40000000,D6
            bra.b   .L7
.L6:
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
.L7:
            or.l    D6,D4
            sub.l   D4,D2
            subx.w  D0,D1
            bcc.b   .L8
            add.l   D4,D2
            addx.w  D0,D1
            eor.l   D6,D4
            bra.b   .L9
.L8:
            add.l   D6,D4
.L9:
            lsr.l   #1,D6
            bcc.b   .L6
            move.l  #$80000000,D6
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
            sub.l   D6,D3
            subx.l  D4,D2
            subx.w  D0,D1
            bcc.b   .L10
            add.l   D6,D3
            addx.l  D4,D2
            addx.w  D0,D1
            bra.b   .L11
.L10:
            addq.w  #1,D4
.L11:
            move.l  D3,D7
            or.w    D1,D7
            or.l    D2,D7
            bne.b   .L12
            lsr.w   #1,D0
            roxr.l  #1,D4
            roxr.l  #1,D5
            bra.b   .L17
.L12:
            ror.l   #1,D6
.L13:
            add.l   D3,D3
            addx.l  D2,D2
            addx.w  D1,D1
            or.l    D6,D5
            sub.l   D5,D3
            subx.l  D4,D2
            subx.w  D0,D1
            bcc.b   .L14
            add.l   D5,D3
            addx.l  D4,D2
            addx.w  D0,D1
            eor.l   D6,D5
            bra.b   .L15
.L14:
            add.l   D6,D5
.L15:
            lsr.l   #1,D6
            bcc.b   .L13
            moveq   #0,D7
            addq.w  #1,D5
            lsr.w   #1,D0
            roxr.l  #1,D4
            roxr.l  #1,D5
            subx.l  D5,D3
            subx.l  D4,D2
            subx.w  D7,D1
            bcs.b   .L16
            bset    #$1F,D7
.L16:
            addi.w  #$FF,D7
.L17:
            move.l  A3,D6
            bra.w   COERCE
QRINTX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI1OP.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L18
            tst.w   D0
            bne.w   FPNANOUT
            bra.w   PACKX
.L18:
            bsr.w   sub_408E8C86
            bgt.b   RINT1
COMINT1:
            bftst   D1{25:2}
            beq.w   COERCEX
            bpl.w   COERCED
            bra.w   COERCES
RINT1:
            bsr.w   RNDINT
            tst.l   D4
            bmi.w   PACKX
COMINT2:
            bfffo   D4{0:0},D0
            beq.b   .L22
            suba.w  D0,A4
            lsl.l   D0,D4
            bfextu  D5{0:D0},D2
            lsl.l   D0,D5
            or.l    D2,D4
            bra.w   PACKX
.L22:
            suba.w  #$20,A4
            exg     D4,D5
            bfffo   D4{0:0},D0
            beq.b   .L23
            bmi.w   PACKX
            suba.w  D0,A4
            lsl.l   D0,D4
            bra.w   PACKX
.L23:
            suba.l  A4,A4
            bra.w   PACKX
QTINTX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI1OP.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L24
            tst.w   D0
            bne.w   FPNANOUT
            bra.w   PACKX
.L24:
            bsr.b   sub_408E8C86
            bgt.b   .L25
            ori.w   #$6000,D1
            bra.w   COMINT1
.L25:
            tst.l   D7
            beq.b   COMINT2
            bset    #$C,D6
            bra.b   COMINT2
sub_408E8C86:
            move.w  FPState,D1
            bftst   D1{25:2}
            beq.b   sub_408E8C9A
            bmi.b   .L1
            moveq   #$34,D0
            bra.b   sub_408E8C9A.L1
.L1:
            moveq   #$17,D0
            bra.b   sub_408E8C9A.L1
sub_408E8C9A:
            moveq   #$3F,D0
.L1:
            moveq   #0,D7
            addi.w  #$3FFF,D0
            move.w  D0,D2
            sub.l   A4,D0
            bgt.b   .L2
            rts
.L2:
            movea.w D2,A4
            bsr.w   RTSHIFT
            move    #0,CCR
            rts
RNDINT:
            tst.l   D7
            bne.b   .L1
            rts
.L1:
            bset    #$C,D6
            bftst   D1{17:2}
            beq.b   .L4
            bmi.b   .L2
            tst.b   D6
            bpl.b   .L6
            rts
.L2:
            btst    #$D,D1
            beq.b   .L3
            rts
.L3:
            tst.b   D6
            bmi.b   .L6
            rts
.L4:
            add.l   D7,D7
            bcs.b   .L5
            rts
.L5:
            bne.b   .L6
            btst    #0,D5
            bne.b   .L6
            rts
.L6:
            moveq   #0,D0
            addq.l  #1,D5
            addx.l  D0,D4
            rts
QX2B:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI2OPS.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($E,A6),A1
            bsr.w   UNPXOP
            moveq   #$1A,D7
            move.l  D6,D1
            lsr.l   D7,D1
            andi.w  #$E,D1
            subq.w  #2,D1
            moveq   #0,D7
            move.w  .L1(PC,D1.w),D1
            jmp     QX2B(PC,D1.w)
.L1:
            dc.w    .L2-QX2B
            dc.w    .L9-QX2B
            dc.w    QX2X_PACK_4_2-QX2B
            dc.w    .L25-QX2B
            dc.w    .L20-QX2B
            dc.w    .L15-QX2B
.L2:
            movea.l ($A,A6),A2
            tst.l   D0
            beq.b   .L3
            tst.w   D0
            beq.b   .L5
            andi.w  #$F800,D5
            bsr.w   FPNANIN
            bra.b   .L5
.L3:
            move.w  FPState,D1
            btst    #6,D1
            beq.b   .L4
            bsr.w   SCOERCE
            bra.b   .L5
.L4:
            bsr.w   DCOERCE
.L5:
            move.w  A4,D3
            cmpi.w  #$7FFF,D3
            bne.b   .L6
            move.w  #$4400,D3
            bra.b   .L7
.L6:
            tst.w   D3
            bne.b   .L7
            move.w  #$3C01,D3
.L7:
            subi.w  #$3C00,D3
            tst.l   D4
            bmi.b   .L8
            subq.w  #1,D3
.L8:
            lsr.l   #8,D5
            lsr.l   #3,D5
            bfins   D4,D5{0:11}
            lsr.l   #8,D4
            lsr.l   #2,D4
            bfins   D3,D4{0:11}
            add.b   D6,D6
            roxr.l  #1,D4
            move.l  D4,(A2)+
            move.l  D5,(A2)
            jmp     (A0)
.L9:
            movea.l ($A,A6),A2
            tst.l   D0
            beq.b   .L10
            tst.w   D0
            beq.b   .L11
            moveq   #0,D5
            clr.b   D4
            bsr.w   FPNANIN
            bra.b   .L11
.L10:
            move.w  FPState,D1
            bsr.w   SCOERCE
.L11:
            move.w  A4,D3
            cmpi.w  #$7FFF,D3
            bne.b   .L12
            move.w  #$4080,D3
            bra.b   .L13
.L12:
            tst.w   D3
            bne.b   .L13
            move.w  #$3F81,D3
.L13:
            subi.w  #$3F80,D3
            add.l   D4,D4
            bcs.b   .L14
            subq.w  #1,D3
.L14:
            or.w    D3,D4
            ror.l   #8,D4
            add.b   D6,D6
            roxr.l  #1,D4
            move.l  D4,(A2)
            jmp     (A0)
.L15:
            tst.l   D0
            beq.b   .L18
            btst    #$11,D0
            bne.b   .L19
            tst.b   D0
            bne.b   .L17
.L16:
            bset    #8,D6
            bclr    #$C,D6
.L17:
            moveq   #1,D4
            moveq   #0,D5
            ror.l   #1,D4
            bra.b   .L19
.L18:
            bsr.w   sub_408E8C9A
            ble.b   .L16
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bmi.b   .L16
            tst.b   D6
            bpl.b   .L19
            neg.l   D5
            negx.l  D4
.L19:
            movea.l ($A,A6),A2
            move.l  D4,(A2)+
            move.l  D5,(A2)
            jmp     (A0)
.L20:
            tst.l   D0
            beq.b   .L22
            btst    #$11,D0
            bne.b   .L24
.L21:
            moveq   #1,D5
            bset    #8,D6
            ror.l   #1,D5
            bclr    #$C,D6
            bra.b   .L24
.L22:
            bsr.w   sub_408E8C9A
            ble.b   .L21
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bne.b   .L21
            tst.l   D5
            bpl.b   .L23
            neg.l   D5
            bpl.b   .L21
            tst.b   D6
            bpl.b   .L21
.L23:
            tst.b   D6
            bpl.b   .L24
            neg.l   D5
.L24:
            movea.l ($A,A6),A2
            move.l  D5,(A2)
            jmp     (A0)
.L25:
            tst.l   D0
            beq.b   .L27
            btst    #$11,D0
            bne.b   .L29
.L26:
            move.w  #$8000,D5
            bset    #8,D6
            bclr    #$C,D6
            bra.b   .L29
.L27:
            bsr.w   sub_408E8C9A
            ble.b   .L26
            move.w  FPState,D1
            bsr.w   RNDINT
            tst.l   D4
            bne.b   .L26
            cmpi.l  #$8000,D5
            bcs.b   .L28
            bhi.b   .L26
            tst.b   D6
            bpl.b   .L26
.L28:
            tst.b   D6
            bpl.b   .L29
            neg.w   D5
.L29:
            movea.l ($A,A6),A2
            move.w  D5,(A2)
            jmp     (A0)
QLOGBX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI1OP.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            clr.b   D6
            tst.l   D0
            beq.b   .L30
            tst.w   D0
            bne.w   FPNANOUT
            btst    #$11,D0
            beq.w   PACKX
            ori.w   #$880,D6
            movea.w #$7FFF,A4
            moveq   #0,D4
            move.l  D4,D5
            bra.w   PACKX
.L30:
            moveq   #0,D5
            suba.w  #$3FFF,A4
            move.l  A4,D4
            bgt.b   .L32
            blt.b   .L31
            suba.l  A4,A4
            move.l  D5,D4
            bra.w   PACKX
.L31:
            ori.b   #$80,D6
            neg.l   D4
.L32:
            movea.w #$401E,A4
            bfffo   D4{0:0},D0
            lsl.l   D0,D4
            suba.w  D0,A4
            bra.w   PACKX
QSCALBX_PACK_4_2:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            lea     (FINI2OPS.w,PC),A0
            move.w  (8,A6),D6
            moveq   #0,D0
            swap    D6
            clr.w   D6
            movea.l ($A,A6),A1
            bsr.w   UNPXOP
            tst.l   D0
            beq.b   .L33
            tst.w   D0
            bne.w   FPNANOUT
            bra.w   PACKX
.L33:
            movea.l ($E,A6),A2
            adda.w  (A2),A4
            moveq   #0,D7
            bra.w   COERCE
QCLASSX_PACK_4_2:
            movem.l D0-D1/A0,-(SP)
            movea.l ($16,SP),A0
            move.w  (A0)+,D0
            btst    #5,($11,SP)
            beq.b   .L34
            addq.w  #2,A0
.L34:
            add.l   D0,D0
            lsr.w   #1,D0
            bset    #$1F,D0
            bclr    #$F,D0
            cmpi.w  #$7FFF,D0
            beq.b   .L38
            move.l  (A0)+,D1
            bpl.b   .L41
.L35:
            moveq   #5,D1
.L36:
            btst    #$10,D0
            beq.b   .L37
            neg.w   D1
.L37:
            movea.l ($12,SP),A0
            move.w  D1,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #$A
.L38:
            move.l  (A0)+,D1
            add.l   D1,D1
            lsr.l   #1,D1
            beq.b   .L40
            btst    #$1E,D1
            beq.b   .L39
            moveq   #2,D1
            bra.b   .L36
.L39:
            moveq   #1,D1
            bra.b   .L36
.L40:
            move.l  (A0),D1
            bne.b   .L39
            moveq   #3,D1
            bra.b   .L36
.L41:
            beq.b   .L44
.L42:
            subq.w  #1,D0
            add.l   D1,D1
            bpl.b   .L42
.L43:
            tst.w   D0
            bpl.b   .L35
            moveq   #6,D1
            bra.b   .L36
.L44:
            subi.w  #$20,D0
            move.l  (A0),D1
            beq.b   .L45
            bpl.b   .L42
            bra.b   .L43
.L45:
            moveq   #4,D1
            bra.b   .L36
QCLASSB:
            movem.l D0-D1/A0,-(SP)
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            btst    #$B,D0
            bne.b   .L46
            btst    #$D,D0
            bne.b   .L55
            move.l  (A0),D0
            add.l   D0,D0
            beq.b   .L48
            bfextu  D0{0:8},D1
            beq.b   .L49
            cmpi.b  #$FF,D1
            bne.b   .L50
            bftst   D0{8:23}
            beq.b   .L53
            btst    #$17,D0
            bne.b   .L47
            bra.b   .L54
.L46:
            move.l  (A0)+,D0
            or.w    (A0)+,D0
            or.w    (A0),D0
            add.l   D0,D0
            beq.b   .L48
            bfextu  D0{0:11},D1
            beq.b   .L49
            cmpi.w  #$7FF,D1
            bne.b   .L50
            bftst   D0{11:20}
            beq.b   .L53
            btst    #$14,D0
            beq.b   .L54
.L47:
            moveq   #2,D0
            bra.b   .L51
.L48:
            moveq   #4,D0
            bra.b   .L51
.L49:
            moveq   #6,D0
            bra.b   .L51
.L50:
            moveq   #5,D0
.L51:
            movea.l ($12,SP),A0
            roxr.w  #1,D1
            bpl.b   .L52
            neg.w   D0
.L52:
            move.w  D0,(A0)
            movem.l (SP)+,D0-D1/A0
            rtd     #$A
.L53:
            moveq   #3,D0
            bra.b   .L51
.L54:
            moveq   #1,D0
            bra.b   .L51
.L55:
            move.l  (A0)+,D0
            add.l   D0,D0
            or.l    (A0),D0
            bne.b   .L50
            addx.w  D0,D0
            beq.b   .L48
            bra.b   .L47
QSETENV_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  (A0),FPState
            movea.l (SP)+,A0
            rtd     #6
QGETENV_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  FPState,(A0)
            movea.l (SP)+,A0
            rtd     #6
QSETHV_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.l  (A0),($A4C).w
            movea.l (SP)+,A0
            rtd     #6
QGETHV_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.l  ($A4C).w,(A0)
            movea.l (SP)+,A0
            rtd     #6
QNEG_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            bchg    #7,(A0)
            movea.l (SP)+,A0
            rtd     #6
QABS_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            bclr    #7,(A0)
            movea.l (SP)+,A0
            rtd     #6
QCPYSGN_PACK_4_2:
            movem.l A0,-(SP)
            movea.l ($E,SP),A0
            bclr    #7,(A0)
            tst.b   ([$A.w,SP])
            bpl.b   .L56
            bset    #7,(A0)
.L56:
            movea.l (SP)+,A0
            rtd     #$A
QPROCENTRY_PACK_4_2:
            move.l  A0,-(SP)
            movea.l ($A,SP),A0
            move.w  FPState,(A0)
            clr.w   FPState
            movea.l (SP)+,A0
            rtd     #6
QTESTXCP_PACK_4_2:
            movem.l D0/A0,-(SP)
            movea.l ($E,SP),A0
            move.w  (A0),D0
            btst    D0,FPState
            sne     D0
            neg.b   D0
            move.b  D0,(A0)
            movem.l (SP)+,D0/A0
            rtd     #6
QSETXCP_PACK_4_2:
            movem.l D0/D6/A0,-(SP)
            move.w  #$15,D6
            swap    D6
            clr.w   D6
            movea.l ($12,SP),A0
            move.w  (A0),D0
            addq.w  #8,D0
            bset    D0,D6
            move.w  FPState,D0
            bra.b   FASTFIN
QPROCEXIT_PACK_4_2:
            movem.l D0/D6/A0,-(SP)
            movea.l ($12,SP),A0
            move.w  #$19,D6
            swap    D6
            move.w  #$1F00,D6
            and.w   FPState,D6
            move.w  (A0),D0
FASTFIN:
            or.w    D6,D0
            move.w  D0,FPState
            lsr.w   #8,D6
            and.w   D6,D0
            bne.b   .L59
.L58:
            move    D0,CCR
            movem.l (SP)+,D0/D6/A0
            rtd     #6
.L59:
            lea     ($12,SP),A0
            clr.w   -(SP)
            move.w  D0,-(SP)
            pea     (SP)
            move.l  (8,A0),-(SP)
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            swap    D6
            move.w  D6,-(SP)
            movea.l ($A4C).w,A0
            jsr     (A0)
            move.l  (SP)+,D0
            bra.b   .L58
QNEXTB:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            move.w  (8,A6),D6
            movem.l ($A,A6),A1-A2
            suba.w  #$16,SP
            movea.l SP,A4
            move.w  FPState,D3
            clr.w   FPState
            moveq   #0,D2
            move.w  D6,D5
            andi.w  #$3800,D5
            bne.b   .L60
            move.b  #$20,D2
            and.b   D6,D2
            beq.b   .L60
            move.w  (A2),(2,A2)
            addq.l  #2,A2
.L60:
            swap    D6
            clr.w   D6
            pea     (A2)
            pea     ($C,A4)
            moveq   #$E,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   FP020
            tst.w   D5
            bne.b   .L61
            move.l  ($C,A4),(A2)
            move.l  ($10,A4),(4,A2)
            move.w  ($14,A4),(8,A2)
.L61:
            bfextu  ($C,A4){1:15},D1
            or.l    ($E,A4),D1
            or.l    ($12,A4),D1
            sne     D4
            pea     (A1)
            pea     (A4)
            or.b    D2,D0
            move.w  D0,-(SP)
            bsr.w   FP020
            tst.b   D2
            beq.b   .L62
            move.l  (4,A4),(2,A4)
            move.l  (8,A4),(6,A4)
.L62:
            pea     (A4)
            pea     ($C,A4)
            move.w  #8,-(SP)
            bsr.w   FP020
            bvc.b   .L63
            pea     (A4)
            pea     ($C,A4)
            move.w  #4,-(SP)
            bsr.w   FP020
            pea     ($C,A4)
            pea     (A2)
            moveq   #$10,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   FP020
            bra.w   .L73
.L63:
            beq.w   .L73
            bcc.b   .L64
            btst    #7,(A2)
            beq.b   .L65
            bra.w   .L75
.L64:
            btst    #7,(A2)
            beq.w   .L75
.L65:
            btst    #$C,D5
            beq.b   .L66
            addq.l  #1,(A2)
            bra.b   .L70
.L66:
            btst    #$B,D5
            beq.b   .L68
            addq.l  #1,(4,A2)
            bcc.b   .L67
            addq.l  #1,(A2)
.L67:
            bra.b   .L70
.L68:
            addq.l  #1,(6,A2)
            bcc.b   .L70
            addq.l  #1,(2,A2)
            bcc.b   .L70
            roxr    (2,A2)
            addq.w  #1,(A2)
            cmpi.w  #$7FFF,(A2)
            beq.b   .L69
            cmpi.w  #$FFFF,(A2)
            bne.b   .L70
.L69:
            bclr    #7,(2,A2)
.L70:
            pea     (A2)
            pea     ($A,A4)
            moveq   #$1C,D0
            or.w    D5,D0
            move.w  D0,-(SP)
            bsr.w   FP020
            move.w  ($A,A4),D1
            bpl.b   .L71
            neg.w   D1
.L71:
            cmpi.w  #3,D1
            bne.b   .L72
            ori.w   #$1400,D6
            bra.b   .L73
.L72:
            cmpi.w  #5,D1
            beq.b   .L73
            ori.w   #$1200,D6
.L73:
            lea     ($16,SP),SP
            tst.b   D2
            beq.b   .L74
            move.w  (A2),(-2,A2)
.L74:
            move.w  FPState,D7
            move.w  D3,FPState
            or.w    D7,D6
            bra.w   FINI2OPS
.L75:
            btst    #$C,D5
            beq.b   .L77
            tst.b   D4
            bne.b   .L76
            bchg    #7,(A2)
            addq.l  #1,(A2)
            bra.b   .L70
.L76:
            subq.l  #1,(A2)
            bra.b   .L70
.L77:
            btst    #$B,D5
            beq.b   .L80
            tst.b   D4
            bne.b   .L78
            bchg    #7,(A2)
            addq.w  #1,(6,A2)
            bra.b   .L70
.L78:
            subq.l  #1,(4,A2)
            bcc.b   .L79
            subq.l  #1,(A2)
.L79:
            bra.b   .L70
.L80:
            tst.b   D4
            bne.b   .L81
            bchg    #7,(A2)
            addq.w  #1,(8,A2)
            bra.w   .L70
.L81:
            subq.l  #1,(6,A2)
            bcc.b   .L84
            subq.l  #1,(2,A2)
            bmi.b   .L82
            tst.w   (A2)
            beq.b   .L84
            cmpi.w  #$8000,(A2)
            beq.b   .L84
            addi.w  #$8000,(2,A2)
            bra.b   .L83
.L82:
            bcc.b   .L84
.L83:
            subq.w  #1,(A2)
.L84:
            bra.w   .L70

            EVEN
