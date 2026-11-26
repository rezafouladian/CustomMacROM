            include "Include/ROMHeader.s"

            EXPORT  abs,Glue_DisposPtr,Glue_NewPtrSysClear,Glue_VInstall,Glue_VRemove

            SECTION "BacklightLibraries",CODE

abs:
            link.w  A6,#0
            move.l  D7,-(SP)
            move.l  (8,A6),D7
            blt.b   .L1
            move.l  D7,D0
            bra.b   .L2
.L1:
            move.l  D7,D0
            neg.l   D0
.L2:
            move.l  (-4,A6),D7
            unlk    A6
            rts
            dc.w    $8361,$6273,0,$225F,$201F,$A04C,$2E80,$4E71
            dc.w    $7000
.L3:
            move.l  A1,-(SP)
.L4:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L4
Glue_NewPtrSysClear:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     abs.L3
Glue_DisposPtr:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     abs.L3
Glue_VInstall:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _VInstall
            move.w  D0,(SP)
            jmp     (A1)
Glue_VRemove:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _VRemove
            move.w  D0,(SP)
            jmp     (A1)
            dc.w    $4154

            EVEN
