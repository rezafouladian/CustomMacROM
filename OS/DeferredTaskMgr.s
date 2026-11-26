            include "Include/ROMHeader.s"

            EXPORT  DTCore,vDisptch

            IMPORT  DequeueTrap,QStuff

            SECTION "DeferredTaskMgr",CODE

DTCore:
DTInstall:
            cmpi.w  #7,(4,A0)
            bne.b   .L1
            lea     DTQueue,A1
            jsr     (QStuff.w,PC)
            moveq   #0,D0
            rts
.L1:
            moveq   #-2,D0
            rts
DisptchTsk:
            move.l  ($6E4).w,-(SP)
            rts
vDisptch:
            btst    #6,VBLQueue
            bne.b   .L1
            bset    #6,DTQueue
            beq.b   .L3
.L1:
            rts
.L2:
            movea.l D0,A0
            lea     DTQueue,A1
            jsr     (DequeueTrap.w,PC)
            movea.l (8,A0),A2
            movea.l ($C,A0),A1
            andi    #$F8FF,SR
            jsr     (A2)
.L3:
            ori     #$700,SR
            move.l  ($D94).w,D0
            bne.b   .L2
            bclr    #6,DTQueue
            rts
            ds.b    6

            EVEN
