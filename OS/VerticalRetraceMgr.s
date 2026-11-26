            include "Include/ROMHeader.s"

            EXPORT  AttachVBL,DoVBLTask,InitVBLQs,SlotVInstall,SlotVRemove,VBLCore
            EXPORT  VBLInt,VRemove

            IMPORT  DequeueTrap,QStuff

            SECTION "VerticalRetraceMgr",CODE

VBLCore:
VInstall:
            lea     VBLQueue,A1
.L1:
            cmpi.w  #1,(4,A0)
            bne.b   .L4
            move.w  ($A,A0),D1
            beq.b   .L3
            tst.w   ($C,A0)
            beq.b   .L3
            move    SR,-(SP)
            ori     #$700,SR
            move.l  ($A,A1),D0
            swap    D0
            moveq   #0,D2
            move.w  D0,D2
            divu.w  D1,D2
            swap    D2
            move.w  D2,D0
            swap    D0
            divu.w  D1,D0
            swap    D0
            sub.w   ($C,A0),D0
            neg.w   D0
            bpl.b   .L2
            add.w   D1,D0
.L2:
            add.w   D0,($A,A0)
            move    (SP)+,SR
.L3:
            jsr     (QStuff.w,PC)
            moveq   #0,D0
            rts
.L4:
            moveq   #-2,D0
            rts
VRemove:
            cmpi.w  #1,(4,A0)
            bne.b   VInstall.L4
            move.l  A1,-(SP)
            lea     VBLQueue,A1
            jsr     (DequeueTrap.w,PC)
            movea.l (SP)+,A1
.L1:
            rts
VBLInt:
            addq.l  #1,Ticks
            move.b  #2,($1A00,A1)
            bset    #6,VBLQueue
            bne.b   VRemove.L1
            move    #$2000,SR
            move.l  StkLowPt,D0
            beq.b   .L2
            cmpa.l  D0,SP
            bcc.b   .L1
            move.l  SP,StkLowPt
.L1:
            movea.l ApplZone,A1
            cmpa.l  (A1),SP
            bcc.b   .L2
            moveq   #$1C,D0
            _SysError
.L2:
            lea     VBLQueue,A1
.L3:
            lea     (2,A1),A0
.L4:
            move.l  (A0),D0
            beq.b   .L5
            movea.l D0,A0
            subq.w  #1,($A,A0)
            bne.b   .L4
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            movea.l (6,A0),A1
            jsr     (A1)
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            tst.w   ($A,A0)
            bne.b   .L4
            jsr     (DequeueTrap.w,PC)
            bra.b   .L4
.L5:
            bclr    #6,(A1)
            rts
GetSlotVBLQHdr:
            ext.w   D0
            cmpi.w  #$E,D0
            bgt.b   .L1
            movea.l ([$D04.w],D0.w*4),A1
            rts
.L1:
            move.w  #$FEAF,D0
            addq.w  #4,SP
            rts
SlotVInstall:
            bsr.b   GetSlotVBLQHdr
            bra.w   VInstall.L1
SlotVRemove:
            bsr.b   GetSlotVBLQHdr
            cmpi.w  #1,(4,A0)
            bne.w   VInstall.L4
            jmp     (DequeueTrap.w,PC)
AttachVBL:
            bsr.b   GetSlotVBLQHdr
            move.l  A1,($D10).w
            moveq   #0,D0
            rts
DoVBLTask:
            bsr.b   GetSlotVBLQHdr
            addq.l  #1,($A,A1)
            cmpa.l  ($D10).w,A1
            bne.b   .L1
            move.l  JCrsrTask,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  A1,-(SP)
            jsr     (A0)
            movea.l (SP)+,A1
.L1:
            bra.w   VBLInt.L3
InitVBLQs:
            lea     DoVBLTask,A0
            move.l  A0,($D28).w
            clr.l   ($D10).w
            rts
            dc.w    0

            EVEN
