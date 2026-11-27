            include "Include/ROMHeader.s"

            EXPORT  disable,spl_

            SECTION "SetProcessorLevel",CODE

disable:
            moveq   #0,D0
            move    SR,D0
            lsr.w   #8,D0
            andi.w  #7,D0
            ori     #$700,SR
            rts
spl_:
            move    SR,D0
            move.w  (6,SP),D1
            lsl.w   #8,D1
            andi.w  #$F8FF,D0
            or.w    D1,D0
            move    D0,SR
            rts
            ds.b    14

            EVEN
