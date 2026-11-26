            include "Include/ROMHeader.s"

            EXPORT  MACEVERSION

            SECTION "SoundMgrVersion",CODE

SNDSOUNDMANAGERVERSION:
            move.l  #$2000000,(4,SP)
            rts
            ds.b    6
MACEVERSION:
            move.l  #$2000000,(4,SP)
            rts
            ds.b    6

            EVEN
