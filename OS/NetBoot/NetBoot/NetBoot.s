            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_49

            IMPORT  BaseOfROM,DOCLOSE,DOOPEN,DOREAD,myGrowZone,RsrcEntryPACK_5

            SECTION "NetBoot",CODE

RsrcEntryDRVR_49:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 49 ".netBOOT" (1988 bytes) - Combo mask
            dc.l    RsrcEntryPACK_5-BaseOfROM       ; Next entry
            dc.l    netBOOT-BaseOfROM               ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    49                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    8,'.netBOOT'                    ; Name
            ds.b    4
            dc.l    $C0A00000,$000007D0,$000001DC   ; Block header
netBOOT:
            dc.w    $4500                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    NBOpen-netBOOT                  ; drvrOpen
            dc.w    NBRead-netBOOT                  ; drvrPrime
            dc.w    NBControl-netBOOT               ; drvrCtl
            dc.w    NBAnRTS-netBOOT                 ; drvrStatus
            dc.w    NBClose-netBOOT                 ; drvrClose
            dc.b    8,'.netBOOT'
            dc.b    $00,$02,$00
NBOpen:
            move.l  A1,-(SP)
            move.l  ($14,A1),D1
            bne.b   Xit
            movea.l A0,A2
            move.l  #$DE,D0
            _NewPtrSysClear
            bne.b   ErrXit
            move.l  A0,D1
            movea.l (SP),A1
            move.l  A0,($14,A1)
            moveq   #0,D0
            move.w  ($18,A2),D0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            jsr     (DOOPEN.w,PC)
            addq.l  #8,SP
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            pea     ATBootDrvrName
            _GetNamedResource
            move.l  (SP)+,D0
            beq.b   Xit
            movea.l D0,A1
            move.l  A3,-(SP)
            movea.l (A1),A3
            move.w  (4,SP),D0
            movea.l A1,A3
            subq.w  #1,D0
            dc.w    $A53D                           ; A-trap $A53D
            bne.b   Xit
            _HLock
            movea.l (A0),A0
            move.l  A3,(A0)+
            move.w  (A3),(A0)+
            movea.l (SP)+,A3
Xit:
            addq.w  #2,SP
            moveq   #0,D0
            addq.l  #4,SP
            rts
ErrXit:
            movea.l (SP)+,A1
            move.l  ($14,A1),D1
            beq.b   .L1
            movea.l D1,A0
            _DisposPtr
.L1:
            move.w  #$FFE9,D0
            rts
ATBootDrvrName:
            dc.b    $07,$07,'.atBoot',$00
NBClose:
            move.l  ($14,A1),D1
            beq.b   NBAnRTS
            move.l  A1,-(SP)
            move.w  ($18,A1),D0
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            jsr     (DOCLOSE.w,PC)
            addq.l  #8,SP
            movea.l (SP)+,A1
            clr.l   ($14,A1)
            tst.l   D0
            beq.b   OkExit
            moveq   #-$18,D0
OkExit:
NBAnRTS:
            rts
NBControl:
            move.w  #$FFBF,D0
            bra.b   GoHome
NBRead:
            btst    #3,($17B).w
            beq.w   NBDontSkip
            move.w  #$FFBF,D0
            bra.w   GoHome
NBDontSkip:
            move.l  ($14,A1),D1
            beq.b   GoHome
            movem.l A0-A1,-(SP)
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  ($10,A1),-(SP)
            lea     (myGrowZone.w,PC),A2
            move.l  A2,($10,A1)
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            jsr     (DOREAD.w,PC)
            addq.l  #8,SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
.L2:
            movem.l (SP)+,A0-A1
GoHome:
            move.w  D0,($10,A0)
            movea.l JIODone,A3
            jmp     (A3)

            EVEN
