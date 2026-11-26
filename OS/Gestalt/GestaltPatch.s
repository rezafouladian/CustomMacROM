            include "Include/ROMHeader.s"

            EXPORT  getAddrModePatch,getFPUTypePatch,getPageSizePatch

            SECTION "GestaltPatch",CODE

GestaltPatch:
getPageSizePatch:
            moveq   #0,D0
            cmpi.b  #cpu68040,CPUFlag
            bne.b   .L1
            mc68040
            movec   TC,D1
            mc68030
            btst    #$E,D1
            bne.b   .L2
            bset    #$C,D0
            bra.b   .L3
.L2:
            bset    #$D,D0
            bra.b   .L3
.L1:
            cmpi.b  #2,CPUFlag
            blt.w   .L4
            cmpi.b  #3,MMUType
            blt.b   .L5
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            lea     ($12,A0),A0
            pmove.l TC,(A0)
            bfextu  (A0){8:4},D1
            bset    D1,D0
            bra.b   .L3
.L5:
            move.l  #$8000,D0
.L3:
            bra.w   getAddrModePatch.L1
.L4:
            bra.w   getAddrModePatch.L3
getFPUTypePatch:
            btst    #4,HWCfgFlags
            beq.b   .L4
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #3,D0
            bra.b   .L5
.L1:
            movea.l SP,A0
            fnop
            fsave   -(SP)
            move.w  (SP),D0
            movea.l A0,SP
            cmpi.w  #$1F18,D0
            beq.b   .L2
            cmpi.w  #$3F18,D0
            beq.b   .L2
            cmpi.w  #$3F38,D0
            beq.b   .L3
            cmpi.w  #$1F38,D0
            beq.b   .L3
            moveq   #0,D0
            bra.b   .L5
.L2:
            moveq   #1,D0
            bra.b   .L5
.L3:
            moveq   #2,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            bra.b   getAddrModePatch.L1
getAddrModePatch:
            moveq   #0,D0
            move.b  ($B73).w,D0
            not.b   D0
            andi.l  #3,D0
            bset    #2,D0
            bra.w   .L1
.L3:
            move.w  #$EA52,($C,SP)
            bra.b   .L2
.L1:
            movea.l (4,SP),A0
            move.l  D0,(A0)
            clr.w   ($C,SP)
.L2:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
            ds.b    1842

            EVEN
