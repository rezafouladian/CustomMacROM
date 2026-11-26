            include "Include/ROMHeader.s"

            EXPORT  OSEVENTAVAILPATCH,OSEVENTMGRPATCH

            SECTION "OSEventMgrPatch",CODE

OSEVENTMGRPATCH:
POSTEVENTPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.w  SysEvtMask,D2
            move.w  A0,D1
            rts
OSEVENTAVAILPATCH:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.l  (A1)+,(A0)+
            subq.w  #1,D0
            bne.b   .L1
            rts
            ds.b    976

            EVEN
