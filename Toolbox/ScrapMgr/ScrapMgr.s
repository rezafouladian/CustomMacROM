            include "Include/ROMHeader.s"

            EXPORT  GetScrap,InfoScrap,LoadScrap,PutScrap,UnloadScrap,ZeroScrap

            SECTION "ScrapMgr",CODE

InfoScrap:
SCRAPMGR:
            tst.w   ScrapState
            bge.b   .L1
            subq.w  #4,SP
            _ZeroScrap
            addq.w  #4,SP
.L1:
            movea.l (SP)+,A0
            lea     ScrapVars,A1
            move.l  A1,(SP)
            jmp     (A0)
StdEntry_ScrapMgr:
            movea.l (SP)+,A1
            link.w  A6,#-$58
            movem.l D2-D7/A2-A4,-(SP)
            move.l  A1,-(SP)
StdSetup:
            movem.l ScrapVars,D4-D6/A2
            lea     ScrapHandle,A4
            lea     (-$50,A6),A0
            movea.l A0,A3
            move.l  A2,($12,A0)
            move.w  BootDrive,($16,A0)
            clr.w   ($1A,A0)
            clr.l   ($1C,A0)
            tst.w   D6
            bne.b   UnloadScrap.L4
StdOpen:
            _Open
            beq.b   UnloadScrap.L5
            cmpi.w  #$FFCF,D0
            beq.b   UnloadScrap.L4
            cmpi.w  #$FFD5,D0
            bne.b   UnloadScrap.L5
            _Create
            bne.b   UnloadScrap.L5
            _GetFileInfo
            move.l  #'CLIP',($20,A0)
            move.l  #'MACS',($24,A0)
            bset    #4,($28,A0)
            _SetFileInfo
            bne.b   UnloadScrap.L5
            bra.b   StdOpen
UnloadScrap:
            bsr.b   StdEntry_ScrapMgr
            bne.b   .L2
            tst.w   D6
            ble.b   .L1
            bsr.b   StdOpen
            bne.b   .L2
            move.l  D4,D0
            bsr.b   SetupRW
            _Write
            bne.b   .L2
            movea.l D5,A0
            _DisposHandle
            clr.l   (A4)+
            clr.l   (A4)+
.L1:
            moveq   #0,D0
.L2:
            ext.l   D0
            move.l  D0,(8,A6)
            moveq   #0,D0
.L3:
            movem.l (SP)+,D2-D7/A2-A4
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
.L4:
            moveq   #0,D0
.L5:
            rts
LoadScrap:
            bsr.w   StdEntry_ScrapMgr
            bne.b   UnloadScrap.L2
            tst.w   D6
            bne.b   UnloadScrap.L1
            move.l  D4,D0
            _NewHandle
            bne.b   UnloadScrap.L2
            move.l  A0,(A4)+
            addq.l  #1,(A4)+
            move.l  D4,D0
            bsr.b   SetupRW2
            _Read
            bra.b   UnloadScrap.L2
SetupRW:
            movea.l D5,A0
SetupRW2:
            move.l  (A0),($20,A3)
            move.l  D0,($24,A3)
            move.w  #1,($2C,A3)
            clr.l   ($2E,A3)
            movea.l A3,A0
            rts
ZeroScrap:
            bsr.w   StdEntry_ScrapMgr
            bne.b   UnloadScrap.L2
            move.l  D0,ScrapVars
            addq.w  #8,(4,A4)
            bpl.b   .L1
            neg.w   (4,A4)
.L1:
            tst.w   D6
            beq.b   .L4
            bgt.b   .L2
            _NewHandle
            bra.b   .L3
.L2:
            movea.l D5,A0
            _SetHandleSize
.L3:
            move.l  A0,(A4)+
            move.w  (A4)+,(A4)
            bra.b   UnloadScrap.L2
.L4:
            clr.l   ($1C,A0)
            _SetEOF
            bra.b   UnloadScrap.L2
DoGet:
            tst.w   D6
            beq.b   .L1
            movea.l D5,A2
            movea.l (A2),A0
            adda.l  D3,A0
            _BlockMove
            bra.b   UnloadScrap.L4
.L1:
            bsr.b   SetupRW
            move.l  D3,($2E,A0)
            move.l  A1,($20,A0)
            _Read
            rts
GetScrap:
            bsr.w   StdEntry_ScrapMgr
            bne.b   .L4
            bsr.w   FailSafe
            bmi.b   .L4
            moveq   #0,D3
.L1:
            cmp.l   D4,D3
            bge.b   .L2
            moveq   #8,D0
            lea     (-$58,A6),A1
            bsr.b   DoGet
            bne.b   .L4
            addq.l  #8,D3
            move.l  (A1)+,D7
            cmp.l   ($C,A6),D7
            beq.b   .L3
            add.l   (A1)+,D3
            addq.l  #1,D3
            bclr    D0,D3
            bra.b   .L1
.L2:
            moveq   #-$66,D0
            bra.b   .L5
.L3:
            movea.l (8,A6),A2
            move.l  D3,(A2)
            move.l  (A1),D0
            move.l  D0,($14,A6)
            move.l  ($10,A6),D1
            beq.b   .L6
            movea.l D1,A0
            _SetHandleSize
            bne.b   .L4
            move.l  (A1),D0
            movea.l (A0),A1
            bsr.b   DoGet
            beq.b   .L6
.L4:
            ext.l   D0
.L5:
            move.l  D0,($14,A6)
.L6:
            moveq   #$C,D0
            bra.w   UnloadScrap.L3
FailSafe:
            tst.w   D6
            bge.b   .L1
            subq.w  #4,SP
            _ZeroScrap
            move.l  (SP)+,D0
            bmi.b   GetScrap.L4
            bsr.w   StdSetup
.L1:
            rts
PutScrap:
            bsr.w   StdEntry_ScrapMgr
            bsr.b   FailSafe
            bmi.b   GetScrap.L4
            bsr.w   SetupRW
            moveq   #8,D0
            lea     ($C,A6),A0
            bsr.b   DoPut
            movea.l (8,A6),A0
            move.l  ($10,A6),D0
            moveq   #-2,D1
            addq.l  #1,D0
            and.l   D1,D0
            bsr.b   DoPut
            move.l  D4,-(A4)
            bra.b   GetScrap.L4
DoPut:
            move.l  D4,($2E,A3)
            add.l   D0,D4
            tst.w   D6
            beq.b   .L1
            movea.l D5,A1
            _PtrAndHand
            rts
.L1:
            move.l  A0,($20,A3)
            move.l  D0,($24,A3)
            movea.l A3,A0
            _Write
            rts
            ds.b    10

            EVEN
