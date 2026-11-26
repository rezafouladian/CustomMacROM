            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_127

            IMPORT  BaseOfROM

            SECTION "EthernetShell",CODE

RsrcEntryDRVR_127:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 127 ".ENET" (340 bytes) - Combo mask
            dc.l    0                               ; Next entry
            dc.l    RsrcDRVR_127-BaseOfROM          ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    127                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    5,'.ENET'                       ; Name
            dc.b    'AAGCSLR'
            dc.l    $C0A00000,$00000160,$0000028C   ; Block header
RsrcDRVR_127:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    ENETOpen-RsrcDRVR_127           ; drvrOpen
            dc.w    ENETPrime-RsrcDRVR_127          ; drvrPrime
            dc.w    ENETPrime-RsrcDRVR_127          ; drvrCtl
            dc.w    ENETPrime-RsrcDRVR_127          ; drvrStatus
            dc.w    ENETClose-RsrcDRVR_127          ; drvrClose
            dc.b    5,'.ENET'
            dc.b    $7F,$02,$80,$00,$00,$00,$09
            dc.b    '127.0.2  ;Ethernet Shell v127.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1990-1991'
ENETOpen:
            link.w  A6,#0
            movea.l A0,A2
            move.w  (6,A2),D0
            andi.w  #$200,D0
            beq.w   .L6
            move.w  #$1B,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            movea.l SP,A0
            move.b  #3,($30,A0)
            move.b  ($22,A2),($31,A0)
            move.w  #1,($28,A0)
            clr.w   ($2A,A0)
            _sNextTypesRsrc
            bne.w   .L6
            move.b  ($31,A0),D0
            cmp.b   ($22,A2),D0
            bne.w   .L6
            move.b  #$20,($32,A0)
            _sReadWord
            bne.w   .L6
            move.l  (A0),D0
            clr.l   -(SP)
            move.l  #'enet',-(SP)
            move.w  D0,-(SP)
            _GetResource
            tst.l   (SP)
            bne.b   .L2
            addq.w  #4,SP
            movea.l SP,A0
            move.b  ($23,A2),($32,A0)
            _sGetDriver
            bne.b   .L6
            move.l  (A0),-(SP)
            movea.l (SP),A0
            _MoveHHi sys
            movea.l (SP),A0
            _HLock async
            bra.b   .L3
.L2:
            move.l  (SP),-(SP)
            _DetachResource
.L3:
            movea.l (SP),A3
            move.l  (A3),D0
            _StripAddress
            movea.l D0,A3
            movea.l (A1),A4
            move.w  (4,A1),D1
            move.l  A3,(A1)
            move.b  (A3),(4,A1)
            bclr    #6,(5,A1)
            movea.l A2,A0
            move.w  (8,A3),D0
            movem.l D1/A1/A4,-(SP)
            jsr     (0,A3,D0.w)
            movem.l (SP)+,D1/A1/A4
            move.w  D0,D3
            beq.b   .L4
            movea.l (SP)+,A0
            _DisposHandle
            move.l  A4,(A1)
            move.w  D1,(4,A1)
            move.w  D3,D0
            bra.b   .L7
.L4:
            lea     RsrcDRVR_127,A0
            _RecoverHandle
            tst.w   MemErr
            bne.b   .L5
            move.l  A0,-(SP)
            _DetachResource
.L5:
            moveq   #0,D0
            bra.b   .L7
.L6:
            moveq   #-$17,D0
.L7:
            unlk    A6
ENETPrime:
            rts
ENETClose:
            moveq   #-$18,D0
            bra.b   ENETPrime
            dc.b    'MLPATWTO'

            EVEN
