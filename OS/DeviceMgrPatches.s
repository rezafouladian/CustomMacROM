            include "Include/ROMHeader.s"

            EXPORT  READUPDATE,WRITEUPDATE

            IMPORT  FileWrite,WriteUpdateReturn

            SECTION "DeviceMgrPatches",CODE

DEVICEMGRPATCH:
OPENIGNOREPATCH:
            _sUpdateSRT
            exg     A4,A0
            moveq   #0,D0
            rts
READUPDATE:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            moveq   #2,D0
            _PowerDispatch
.L1:
            rts
WRITEUPDATE:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            moveq   #2,D0
            _PowerDispatch
.L1:
            move.w  ($18,A0),D2
            bpl.l   FileWrite
            bra.l   WriteUpdateReturn
            ds.b    972

            EVEN
