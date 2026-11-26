            include "Include/ROMHeader.s"

            EXPORT  CACHEVECTORPATCH,DISPATCHPATCH

            IMPORT  EMT1010

            SECTION "DispatchPatchROM",CODE

DISPATCHPATCH:
SETTRAPADDRESSPATCH:
            jsr     ([$6F4.w])
            move.l  A0,(A1)
            moveq   #0,D0
            rts
CACHEVECTORPATCH:
            BigLea  EMT1010,A0
            move.l  A0,LineAVector
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            lea     .L2,A1
            move.l  A1,($6F4).w
.L1:
            rts
            ds.b    4
.L2:
            nop
            mc68040
            cpusha  BC
            mc68030
            rts
            ds.b    970

            EVEN
