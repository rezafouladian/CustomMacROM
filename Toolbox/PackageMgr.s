            include "Include/ROMHeader.s"

            EXPORT  InitAllPacks,Pack0,Pack1,Pack10,Pack11,Pack12
            EXPORT  Pack13,Pack14,Pack15,Pack2,Pack3,Pack4
            EXPORT  Pack5,Pack6,Pack7,Pack8,Pack9,PackDispatcher

            SECTION "PackageMgr",CODE

PackDispatcher:
InitPack:
            subq.l  #4,SP
            move.l  #'PACK',-(SP)
            move.w  ($C,SP),-(SP)
            move.w  #$FF00,ROMMapInsert
            _GetResource
            move.w  (8,SP),D0
            bsr.b   GetPHand
            move.l  (SP)+,(A0)
            movea.l (SP)+,A0
            addq.l  #2,SP
            jmp     (A0)
InitAllPacks:
            movea.l (SP)+,A0
            moveq   #$F,D0
.L1:
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            lea     PackDispatcher,A0
            dbra    D0,.L1
            move.l  A0,-(SP)
            clr.w   FPState
            lea     sub_40826202,A0
            move.l  A0,($A4C).w
            rts
sub_40826202:
            moveq   #$10,D0
            _SysError
Pack4:
            movem.l D0/A0-A1,-(SP)
            move.l  ($AC8).w,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(8,SP)
            beq.b   .L1
            movem.l (SP)+,D0/A0
            rts
.L1:
            movem.l (SP)+,D0/A0
            addq.l  #4,SP
            bra.w   Pack3.L1
Pack5:
            movem.l D0/A0-A1,-(SP)
            move.l  ($ACC).w,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),(8,SP)
            beq.b   .L1
            movem.l (SP)+,D0/A0
            rts
.L1:
            movem.l (SP)+,D0/A0
            addq.l  #4,SP
            bra.b   Pack3.L2
GetPHand:
            lea     App2Packs,A0
            subq.w  #8,D0
            bge.b   .L1
            lea     ($AB8).w,A0
            addq.w  #8,D0
.L1:
            lsl.w   #2,D0
            adda.w  D0,A0
            rts
PackCom:
            movem.l D0/A0,-(SP)
            move.l  (8,SP),D0
            lea     Pack1,A0
            sub.l   A0,D0
            lsr.w   #1,D0
            bsr.b   GetPHand
            tst.l   (A0)
            beq.b   .L2
            movea.l (A0),A0
            tst.l   (A0)
            bne.b   .L1
            move.l  A0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _LoadResource
            tst.l   (A0)
            beq.b   .L2
.L1:
            move.l  (A0),D0
            _StripAddress
            move.l  D0,(8,SP)
            movem.l (SP)+,D0/A0
            rts
.L2:
            move.l  (8,SP),D0
            lea     Pack1,A0
            sub.l   A0,D0
            lsr.w   #1,D0
            addi.w  #$11,D0
            _SysError
Pack0:
            bsr.b   PackCom
Pack1:
            bsr.b   PackCom
Pack2:
            bsr.b   PackCom
Pack3:
            bsr.b   PackCom
.L1:
            bsr.b   PackCom
.L2:
            bsr.b   PackCom
Pack6:
            bsr.b   PackCom
Pack7:
            bsr.b   PackCom
Pack8:
            bsr.b   PackCom
Pack9:
            bsr.b   PackCom
Pack10:
            bsr.b   PackCom
Pack11:
            bsr.b   PackCom
Pack12:
            bsr.b   PackCom
Pack13:
            bsr.b   PackCom
Pack14:
            bsr.b   PackCom
Pack15:
            bsr.b   PackCom
PackMgrEnd:
            ori.b   #0,D0
            ori.b   #0,D0
            dc.w    0

            EVEN
