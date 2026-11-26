            include "Include/ROMHeader.s"

            EXPORT  Events,FlushEvents,GetOSEvent,OSEventAvail

            IMPORT  DequeueTrap,OSEVENTAVAILPATCH,OSEVENTMGRPATCH,QStuff,SMGRPOSTMUNGING

            SECTION "OSEventMgr",CODE

Events:
PostEvent:
            bsr.l   OSEVENTMGRPATCH
            btst    D1,D2
            bne.b   .L1
            moveq   #1,D0
            rts
.L1:
            move    SR,-(SP)
            move.l  D0,-(SP)
            move.w  A0,-(SP)
            movea.l SysEvtBuf,A0
            addq.l  #6,A0
            moveq   #$16,D0
            moveq   #-1,D1
            suba.w  D0,A0
            move.w  EvtBufCnt,D2
            ori     #$700,SR
.L2:
            adda.w  D0,A0
            cmp.w   (A0),D1
            dbeq    D2,.L2
            lea     EventQueue,A1
            beq.b   .L3
            movea.l (2,A1),A0
            move.l  (A0),(2,A1)
            addq.l  #6,A0
.L3:
            move.w  (SP)+,(A0)
            move.l  (SP)+,(2,A0)
            bsr.b   FillRecord
            subq.l  #6,A0
            move.w  #4,(4,A0)
            jsr     (QStuff.w,PC)
            move    (SP)+,SR
            moveq   #0,D0
            rts
FillRecord:
            move.l  Ticks,(6,A0)
            move.l  Mouse,($A,A0)
            move.w  ($17A).w,D1
            rol.w   #1,D1
            move.b  D1,($E,A0)
            move.b  MBState,($F,A0)
            rts
OSEventAvail:
            lea     EventQueue,A1
            move    SR,-(SP)
            ori     #$700,SR
            move.l  (2,A1),D1
            beq.b   .L2
.L1:
            movea.l D1,A1
            move.w  (6,A1),D1
            btst    D1,D0
            bne.b   .L3
            move.l  (A1),D1
            bne.b   .L1
.L2:
            and.w   SysEvtMask,D0
            btst    #5,D0
            beq.b   .L4
            move.w  KbdVars,D0
            swap    D0
            move.w  KeyLast,D0
            tst.l   D0
            beq.b   .L4
            move.l  Ticks,D1
            move.l  D1,D2
            sub.l   KeyTime,D1
            cmp.w   KeyThresh,D1
            blt.b   .L4
            sub.l   KeyRepTime,D2
            cmp.w   KeyRepThresh,D2
            blt.b   .L4
            move.l  Ticks,KeyRepTime
            move.l  A0,-(SP)
            movea.w #5,A0
            bsr.w   Events
            movea.l A0,A1
            movea.l (SP)+,A0
.L3:
            move    (SP)+,SR
            moveq   #4,D0
            movem.l A0-A1,-(SP)
            addq.l  #6,A1
            bsr.l   OSEVENTAVAILPATCH
            movem.l (SP)+,A0-A1
            rts
.L4:
            bsr.w   FillRecord
            move    (SP)+,SR
            clr.w   (A0)
            clr.l   (2,A0)
            moveq   #-1,D0
            rts
GetOSEvent:
            bsr.w   OSEventAvail
            bne.b   .L1
            move.l  A0,-(SP)
            movea.l A1,A0
            lea     EventQueue,A1
            bsr.b   sub_4080B4C0
            movea.l (SP)+,A0
            moveq   #0,D0
.L1:
            BigJmp  SMGRPOSTMUNGING,A1
sub_4080B4C0:
            jsr     (DequeueTrap.w,PC)
            move.w  #$FFFF,(6,A0)
            rts
FlushEvents:
            move    SR,-(SP)
            movem.l D3-D4,-(SP)
            moveq   #-1,D1
            move.l  D1,LastSPExtra
            move.l  D0,D1
            swap    D1
            move.w  D0,D4
            and.w   FlEvtMask,D4
            lea     EventQueue,A1
            ori     #$700,SR
            move.l  (2,A1),D3
            beq.b   .L3
.L1:
            movea.l D3,A0
            move.l  (A0),D3
            move.w  (6,A0),D2
            btst    D2,D1
            bne.b   .L4
            btst    D2,D4
            beq.b   .L2
            bsr.b   sub_4080B4C0
.L2:
            tst.l   D3
            bne.b   .L1
.L3:
            moveq   #0,D2
.L4:
            movem.l (SP)+,D3-D4
            move.w  D2,D0
            ext.l   D0
            move    (SP)+,SR
            rts
            ds.b    12

            EVEN
