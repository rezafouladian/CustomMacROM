            include "Include/ROMHeader.s"

            EXPORT  InitSDTbl,OSSSLOTINT,RBVSLOTINT,SIntInstall,SIntRemove,SlotInt
            EXPORT  SlotIntCommon

            SECTION "SlotInterrupts",CODE

SINTCORE:
            cmpi.w  #6,(4,A0)
            bne.b   .L1
            ext.w   D0
            cmpi.w  #$E,D0
            bgt.b   .L2
            lea     ([$D04.w],D0.w*4,$40.w),A1
            rts
.L1:
            moveq   #-2,D0
            bra.b   .L3
.L2:
            move.w  #$FEAF,D0
.L3:
            addq.w  #4,SP
            rts
SIntInstall:
            bsr.b   SINTCORE
            move.b  (7,A0),D0
            move    SR,-(SP)
            ori     #$700,SR
.L1:
            move.l  (A1),D1
            beq.b   .L2
            exg     D1,A1
            cmp.b   (7,A1),D0
            bls.b   .L1
            exg     D1,A1
.L2:
            move.l  D1,(A0)
            move.l  A0,(A1)
            move    (SP)+,SR
            moveq   #0,D0
            rts
SIntRemove:
            bsr.b   SINTCORE
            moveq   #-1,D0
            move    SR,-(SP)
            ori     #$700,SR
.L1:
            move.l  (A1),D1
            beq.b   .L2
            exg     D1,A1
            cmpa.l  A0,A1
            bne.b   .L1
            movea.l D1,A1
            move.l  (A0),(A1)
            moveq   #0,D0
.L2:
            move    (SP)+,SR
            rts
SlotInt:
VIA2SLOTINT:
            move.b  #2,($1A00,A1)
            moveq   #-$40,D0
            or.b    ($1E00,A1),D0
            not.l   D0
            bne.b   SlotIntCommon
            rts
RBVSLOTINT:
            move.b  #$82,(3,A1)
            moveq   #-$80,D0
            or.b    (2,A1),D0
            not.l   D0
            and.b   ($12,A1),D0
            bne.b   SlotIntCommon
            rts
OSSSLOTINT:
            moveq   #$3F,D0
            and.b   ($203,A1),D0
            bne.b   SlotIntCommon
            rts
SlotIntCommon:
            subq.l  #4,SP
            move.b  D0,(SP)
.loop:
            move.b  SlotPriority(PC,D0.w),D0
            bclr    D0,(SP)
            lsr.b   #4,D0
            bsr.b   RunSlotHandlers
            bne.b   .noHandler
            move.b  (SP),D0
            bne.b   .loop
            addq.l  #4,SP
            movea.l VIA2,A1
            movea.l ($D74).w,A0
            jmp     (A0)
.noHandler:
            _SysError
RunSlotHandlers:
            lea     ([$D04.w],D0.w*4,$40.w),A1
.RunNext:
            move.l  (A1),D0
            beq.b   .notFound
            movea.l D0,A1
            move.l  A1,-(SP)
            movea.l (8,A1),A0
            movea.l ($C,A1),A1
            jsr     (A0)
            movea.l (SP)+,A1
            tst.w   D0
            beq.b   .RunNext
            moveq   #0,D0
            rts
.notFound:
            moveq   #dsBadSlotInt,D0
            rts
SlotPriority:
            dc.w    $0090,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $E590,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $0690,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $E590,$A190,$B290,$A190,$C390,$A190,$B290,$A190
            dc.w    $D490,$A190,$B290,$A190,$C390,$A190,$B290,$A190
InitSDTbl:
            move.l  #$170,D0
            _NewPtrSysClear
            move.l  A0,($D04).w
            lea     ($82,A0),A1
            moveq   #$E,D0
.init:
            move.l  A1,(A0)+
            lea     ($10,A1),A1
            dbra    D0,.init
            moveq   #0,D0
            rts
InitSPTbl:
            rts
            ds.b    10

            EVEN
