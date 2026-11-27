            include "Include/ROMHeader.s"

            EXPORT  PrGlue

            IMPORT  A

            SECTION "PrintGlue",CODE

PrGlue:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            moveq   #0,D1
            move.b  (8,A6),D1
            lsr.b   #3,D1
            beq.b   .L1
            tst.b   (8,A6)
            bmi.w   .L8
            moveq   #0,D2
            move.b  (9,A6),D2
            bne.b   .L2
            moveq   #3,D2
            and.b   ChooserBits,D2
            bra.b   .L2
.L1:
            movea.l ($14,A6),A0
            movea.l (A0),A0
            moveq   #3,D2
            and.b   ($44,A0),D2
            andi.b  #$FC,ChooserBits
            or.b    D2,ChooserBits
.L2:
            movea.w CurMap,A3
            clr.l   -(SP)
            move.l  #'PDEF',-(SP)
            move.w  D2,-(SP)
            _GetResource
            move.l  (SP)+,D0
            tst.l   D0
            bne.b   .L6
            cmpi.w  #$FFFF,($952).w
            beq.b   .L3
            move.w  ($952).w,-(SP)
            _UseResFile
            tst.w   ResErr
            beq.b   .L5
.L3:
            bsr.w   sub_4082617A
            tst.w   D0
            beq.b   .L4
            move.w  D0,($944).w
            bra.w   .L11
.L4:
            move.w  ($952).w,-(SP)
            _UseResFile
.L5:
            clr.l   -(SP)
            move.l  #'PDEF',-(SP)
            move.w  D2,-(SP)
            _GetResource
            move.l  (SP)+,D0
            tst.l   D0
            bne.b   .L6
            move.w  A3,-(SP)
            _UseResFile
            move.w  #$FF40,($944).w
            bra.w   .L11
.L6:
            movea.l D0,A4
            movea.l A4,A0
            _HLock
            move.w  A3,-(SP)
            _UseResFile
            lea     ($C,A6),A0
            moveq   #7,D0
            and.b   (8,A6),D0
            add.b   ($A,A6),D0
            suba.w  D0,SP
            movea.l SP,A1
            _BlockMove
            move.b  ($B,A6),D0
            andi.b  #$7F,D0
            movea.l (A4),A0
            jsr     (0,A0,D0.w)
            move.b  ($B,A6),D0
            bpl.b   .L7
            movea.l A4,A0
            _HUnlock
.L7:
            bra.w   GetDCEHandle.L4
.L8:
            suba.w  #$32,SP
            lea     sub_4082617A.L3,A0
            move.l  A0,($12,SP)
            move.w  #$FFFD,($18,SP)
            clr.b   ($1B,SP)
            movea.l SP,A0
            moveq   #0,D0
            bclr    #4,D1
            add.w   D1,D1
            move.w  .L9(PC,D1.w),D1
            jmp     .L9(PC,D1.w)
.L9:
            dc.w    .L17-.L9
            dc.w    .L18-.L9
            dc.w    .L19-.L9
            dc.w    .L20-.L9
            dc.w    .L21-.L9
            dc.w    .L22-.L9
            dc.w    .L23-.L9
            dc.w    GetDCEHandle.L1-.L9
            dc.w    GetDCEHandle.L2-.L9
            dc.w    .L12-.L9
            dc.w    .L13-.L9
            dc.w    .L10-.L9
            dc.w    .L10-.L9
            dc.w    .L10-.L9
            dc.w    .L10-.L9
            dc.w    .L10-.L9
.L10:
            move.w  #$FFCE,($944).w
.L11:
            moveq   #0,D1
            move.b  ($A,A6),D1
            bra.w   GetDCEHandle.L7
.L12:
            move.l  #$80000000,-(SP)
            _PrGlue
            move.w  ($944).w,D0
            bne.b   .L16
            moveq   #0,D1
            bra.b   .L14
.L13:
            moveq   #1,D1
.L14:
            bsr.w   sub_4082617A
            tst.w   D0
            bne.b   .L16
            move.w  ($952).w,D0
            tst.w   ResErr
            bne.b   .L15
            tst.w   D1
            beq.b   .L15
            move.w  D0,-(SP)
            _CloseResFile
.L15:
            move.w  ResErr,D0
.L16:
            bra.w   GetDCEHandle.L3
.L17:
            _Open
            bra.b   GetDCEHandle.L3
.L18:
            _Close
            bra.b   GetDCEHandle.L3
.L19:
            bsr.b   GetDCEHandle
            lea     ($2E,SP),SP
            move.l  A0,(SP)
            bra.b   GetDCEHandle.L4
.L20:
            bsr.b   GetDCEHandle
            movea.l (A0),A0
            moveq   #0,D0
            move.b  (7,A0),D0
            lea     ($30,SP),SP
            move.w  D0,(SP)
            bra.b   GetDCEHandle.L4
.L21:
            move.l  ($C,A6),($24,A0)
            move.l  ($10,A6),($20,A0)
            move.l  ($14,A6),($1C,A0)
            move.w  ($18,A6),($1A,A0)
            _Control
            bra.b   GetDCEHandle.L3
.L22:
            bsr.b   GetDCEHandle
            movea.l (A0),A0
            btst    #6,(5,A0)
            beq.b   GetDCEHandle.L3
            movea.l (A0),A0
            _HPurge
            bra.b   GetDCEHandle.L3
.L23:
            bsr.b   GetDCEHandle
            movea.l (A0),A0
            btst    #6,(5,A0)
            beq.b   GetDCEHandle.L3
            movea.l (A0),A0
            _HNoPurge
            bra.b   GetDCEHandle.L3
GetDCEHandle:
            move.w  #1,($1A,A0)
            _Status
            movea.l ($1C,A0),A0
            rts
.L1:
            lea     ($30,SP),SP
            move.w  ($944).w,(SP)
            bra.b   .L4
.L2:
            move.w  ($C,A6),D0
.L3:
            lea     ($32,SP),SP
            move.w  D0,($944).w
.L4:
            moveq   #0,D1
            move.b  ($A,A6),D1
            moveq   #7,D0
            and.b   (8,A6),D0
            beq.b   .L7
            movea.l SP,A0
            lea     ($C,A6,D1.w),A1
            lsr.w   #1,D0
            bra.b   .L6
.L5:
            move.w  (SP)+,(A1)+
.L6:
            dbra    D0,.L5
.L7:
            movem.l (SP)+,A3-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.l  D1,SP
            addq.w  #4,SP
            jmp     (A0)
sub_4082615C:
            moveq   #0,D0
sub_4082615E:
            suba.w  #$40,SP
            movea.l SP,A0
            move.w  D0,($16,A0)
            clr.l   ($12,A0)
            _SetVol
            _GetVol
            move.w  ($16,A0),D0
            lea     ($40,SP),SP
            rts
sub_4082617A:
            subq.w  #4,SP
            move.w  #$E000,-(SP)
            _GetString
            move.l  (SP)+,D0
            bne.b   .L1
            move.w  #$FF40,D0
            bra.b   .L2
.L1:
            movea.l D0,A1
            bsr.b   sub_4082615C
            swap    D1
            move.w  D0,D1
            subq.w  #2,SP
            movea.l A1,A0
            _HLock
            move.l  (A1),-(SP)
            clr.w   -(SP)
            clr.b   -(SP)
            _OpenRFPerm
            move.w  (SP)+,($952).w
            movea.l A1,A0
            _HUnlock
            move.w  D1,D0
            swap    D1
            bsr.b   sub_4082615E
            move.w  ResErr,D0
.L2:
            rts
.L3:
            dc.b    6,'.Print'
            dc.b    $20,$00,$00

            EVEN
