            include "Include/ROMHeader.s"

            EXPORT  INITWINDOWSRGNPATCH,WINDOWMGRPATCH

            IMPORT  INITWINDOWSCRTRETURN,INITWINDOWSLCDRETURN,INITWINDOWSRGNRETURN

            SECTION "WindowMgrPatch",CODE

WINDOWMGRPATCH:
INITWINDOWSFRAMEPATCH:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            bra.l   INITWINDOWSLCDRETURN
.L1:
            move.l  A4,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            bra.l   INITWINDOWSCRTRETURN
INITWINDOWSRGNPATCH:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            move.l  A4,-(SP)
            _FrameRect
            bra.l   INITWINDOWSRGNRETURN
.L1:
            move.l  A4,-(SP)
            move.l  #$100010,-(SP)
            _FrameRoundRect
            bra.l   INITWINDOWSRGNRETURN
            ds.b    444

            EVEN
