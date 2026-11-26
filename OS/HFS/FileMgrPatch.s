            include "Include/ROMHeader.s"

            EXPORT  CMDDONEPATCH,DSHOOKPATCH

            SECTION "FileMgrPatch",CODE

FILEMGRPATCH:
CMDDONEPATCH:
            movea.l ($362).w,A0
            cmpi.b  #2,(7,A0)
            bne.b   .L1
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
.L1:
            clr.b   ($377).w
            ext.l   D0
            rts
DSHOOKPATCH:
            move.w  (6,A0),D0
            bgt.b   .L1
            jmp     .L2
.L1:
            ori.b   #$A0,($B00).w
            move.b  #$60,($B01).w
            andi.w  #$FF,D0
.L2:
            move.l  D1,-(SP)
            jsr     ([$6F4.w])
            move.l  (SP)+,D1
            jmp     ($B00).w
            ds.b    1978

            EVEN
