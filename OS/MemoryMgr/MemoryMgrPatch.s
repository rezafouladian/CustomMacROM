            include "Include/ROMHeader.s"

            EXPORT  A24ACTUALSPATCH,A24MAXLIMITPATCH,A24SETSIZEPATCH,A32ACTUALSPATCH,A32MAXLIMITPATCH,A32SETSIZEPATCH
            EXPORT  ALIGN24TRAILER,ALIGN32TRAILER,DerefHandlePatch,INIT24ZONEALIGN,INIT32ZONEALIGN,SETAPPLBASEPATCH
            EXPORT  V24CMGUTSPATCH,v24HlockPatch,V24MAXAPPLPATCH,V24MAXMEMPATCH,V24PURGESPACEPATCH,V32CMGUTSPATCH
            EXPORT  v32HlockPatch,V32MAXAPPLPATCH,V32MAXMEMPATCH,V32PURGESPACEPATCH,ZoneCheckPatch

            IMPORT  A24BKCOMPACTS,a24CompactHp,A32BKCOMPACTS,A32COMPACTHP,DHBusErrHandler,HeapGuts

            SECTION "MemoryMgrPatch",CODE

MEMORYMGRPATCH:
v24HlockPatch:
            beq.w   HFail
            bset    #7,(A1)
            bra.w   v32HlockPatch.L1
v32HlockPatch:
            beq.w   HFail
            bset    #7,(-$B,A0)
.L1:
            cmpi.b  #cpu68040,CPUFlag
            bne.b   HGood
            jsr     ([$6F4.w])
HGood:
            moveq   #0,D0
            bra.b   HFail.L4
HFail:
            moveq   #-$6D,D0
.L4:
            move.l  vMMEpilogue,-(SP)
            rts
ZoneCheckPatch:
            movea.l BusErrVct,A2
            BigLea  HeapGuts,A3
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            lea     sub_4088787A,A3
.L1:
            move.l  A3,BusErrVct
            rts
DerefHandlePatch:
            movea.l BusErrVct,A2
            BigLea  DHBusErrHandler,A3
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            lea     sub_40887870,A3
.L1:
            move.l  A3,BusErrVct
            rts
sub_40887870:
            moveq   #-1,D0
            movea.l D0,A0
            addq.l  #2,(2,SP)
            rte
sub_4088787A:
            sub.l   D0,D0
            addq.l  #4,(2,SP)
            rte
A24MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            and.l   Lo3Bytes,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A32MAXLIMITPATCH:
            andi.w  #$FFFC,D2
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D2
.L1:
            move.l  SP,D1
            sub.l   MinStack,D1
            andi.w  #$FFFC,D1
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            andi.w  #$FFF0,D1
.L2:
            cmp.l   D2,D1
            bcs.b   .L3
            move.l  D2,D1
.L3:
            rts
A24ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addi.l  #$17,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addq.l  #8,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$C,D0
            bcc.b   .L2
            moveq   #$C,D0
.L2:
            rts
A32ACTUALSPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$1B,D0
            andi.w  #$FFF0,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
            bra.b   .L2
.L1:
            addi.l  #$C,D0
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            cmpi.l  #$10,D0
            bcc.b   .L2
            moveq   #$10,D0
.L2:
            rts
A24SETSIZEPATCH:
            move.l  D0,D1
            lea     ($3C,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            addq.l  #8,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A24ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
A32SETSIZEPATCH:
            move.l  D0,D1
            lea     ($40,A6),A2
            cmpa.l  A0,A2
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$C,D0
            move.l  A2,D2
            add.l   D0,D2
            andi.l  #$F,D2
            beq.b   .L2
            not.b   D2
            andi.b  #$F,D2
            addq.b  #1,D2
            add.l   D2,D0
            bra.b   .L2
.L1:
            bsr.w   A32ACTUALSPATCH
.L2:
            move.l  D0,D3
            rts
SETAPPLBASEPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            addi.l  #$F,D0
            andi.w  #$FFF0,D0
            rts
.L1:
            addq.l  #3,D0
            andi.w  #$FFFC,D0
            rts
INIT24ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addq.l  #8,D0
            move.l  (A0),D1
            and.l   Lo3Bytes,D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(A0)
            add.l   D0,(A0)
            sub.l   D0,(A1)
            move.l  (A1),(0,A1,D0.w)
            adda.l  D0,A1
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (A0),D0
            and.l   Lo3Bytes,D0
            adda.l  D0,A1
            addq.b  #2,(A0)
            addq.l  #2,(A0)
            subq.l  #2,(A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
INIT32ZONEALIGN:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            lea     ($34,A6),A0
            move.l  A0,D0
            addi.l  #$C,D0
            move.l  (4,A0),D1
            add.l   D1,D0
            andi.l  #$F,D0
            beq.b   .L2
            not.b   D0
            andi.b  #$F,D0
            addq.b  #1,D0
            sub.l   D0,($C,A6)
            movea.l A0,A1
            adda.l  D1,A1
            add.b   D0,(3,A0)
            add.l   D0,(4,A0)
            sub.l   D0,(4,A1)
            move.l  (4,A1),(4,A1,D0.w)
            adda.l  D0,A1
            clr.l   (A1)
            move.l  A1,($30,A6)
            bra.b   .L2
.L1:
            move.l  A6,D0
            btst    #1,D0
            beq.b   .L2
            subq.l  #2,($C,A6)
            lea     ($34,A6),A0
            movea.l A0,A1
            move.l  (4,A0),D0
            adda.l  D0,A1
            addq.b  #2,(3,A0)
            addq.l  #2,(4,A0)
            subq.l  #2,(4,A1)
            move.l  (4,A1),(6,A1)
            move.l  (A1),(2,A1)
            addq.l  #2,A1
            move.l  A1,($30,A6)
.L2:
            rts
ALIGN24TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
ALIGN32TRAILER:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            subq.l  #4,D1
            andi.w  #$FFF0,D1
            addq.l  #4,D1
            movea.l D1,A3
            rts
.L1:
            andi.w  #$FFFC,D1
            movea.l D1,A3
            rts
V24CMGUTSPATCH:
            bsr.l   a24CompactHp
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32CMGUTSPATCH:
            bsr.l   A32COMPACTHP
            move.b  D2,(A1)
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A24BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V32MAXMEMPATCH:
            moveq   #0,D2
            bsr.l   A32BKCOMPACTS
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D1
.L1:
            rts
V24PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            tst.l   ($B78).w
            bpl.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V32PURGESPACEPATCH:
            add.l   D1,D0
            cmpa.l  D1,A0
            bcc.b   .L1
            movea.l D1,A0
.L1:
            cmpi.b  #4,CPUFlag
            blt.b   .L2
            move.l  A0,D1
            andi.w  #$FFF0,D1
            movea.l D1,A0
.L2:
            rts
V24MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            tst.l   ($B78).w
            bpl.b   .L1
            andi.w  #$FFF0,D0
            subq.l  #8,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
V32MAXAPPLPATCH:
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            andi.w  #$FFF0,D0
            subi.l  #$C,D0
            bra.b   .L2
.L1:
            andi.w  #$FFFC,D0
.L2:
            move.l  D0,D1
            rts
            ds.b    1032

            EVEN
