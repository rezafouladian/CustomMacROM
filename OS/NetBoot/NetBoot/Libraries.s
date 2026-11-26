            include "Include/ROMHeader.s"

            EXPORT  Glue_Dequeue_DRVR_49,Glue_DisposPtr_DRVR_49,Glue_GetTrapAddress_DRVR_49,Glue_NewPtrSysClear_DRVR_49,Glue_NGetTrapAddress_DRVR_49,Glue_PBClose_DRVR_49
            EXPORT  Glue_PBControl_DRVR_49,Glue_PBHOpen_DRVR_49,Glue_sNextTypesRsrc_DRVR_49,Glue_sReadDrvrName_DRVR_49

            SECTION "NetBoot_Libraries",CODE

Glue_CompactMem_DRVR_49:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
            moveq   #0,D0
Glue_MemErrExit_DRVR_49:
            move.l  A1,-(SP)
.L10:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L10
Glue_NewPtrSysClear_DRVR_49:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     Glue_MemErrExit_DRVR_49
Glue_DisposPtr_DRVR_49:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     Glue_MemErrExit_DRVR_49
Glue_GetTrapAddress_DRVR_49:
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            _GetTrapAddress
            move.l  A0,(SP)
            jmp     (A1)
Glue_NGetTrapAddress_DRVR_49:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            move.w  (SP)+,D0
            move.l  A1,-(SP)
            tst.b   D1
            beq.b   .L1
            _GetToolBoxTrapAddress
            bra.b   .L2
.L1:
            _GetOSTrapAddress
.L2:
            move.l  A0,(4,SP)
            rts
Glue_Dequeue_DRVR_49:
            movea.l (4,SP),A1
            movea.l (8,SP),A0
            _Dequeue
            move.w  D0,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
Glue_PBClose_DRVR_49:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Close
            bra.b   .L2
.L1:
            _Close async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
Glue_PBControl_DRVR_49:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Control
            bra.b   .L2
.L1:
            _Control async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
Glue_sNextTypesRsrc_DRVR_49:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sNextTypesRsrc
            move.w  D0,(SP)
            jmp     (A1)
Glue_sReadDrvrName_DRVR_49:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sReadDrvrName
            move.w  D0,(SP)
            jmp     (A1)
Glue_PBHOpen_DRVR_49:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _HOpen
            bra.b   .L2
.L1:
            _HOpen async
.L2:
            move.w  D0,(SP)
            jmp     (A1)

            EVEN
