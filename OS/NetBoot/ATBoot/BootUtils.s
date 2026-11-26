            include "Include/ROMHeader.s"

            EXPORT  myGetA5,myGetIcn,myGetMask,mySetA5,TestPRam

            SECTION "ATBoot_BootUtils",CODE

TestPRam:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .write
            bsr.b   ReadPRAM
            bra.b   .Exit
.write:
            bsr.b   WritePRAM
.Exit:
            rts
pRamTable:
            dc.l    $00040004                       ; first four password bytes
            dc.l    $000300AB                       ; next three bytes
            dc.l    $000100BC                       ; last password byte
            dc.l    $00200020                       ; user name (32 bytes)
            dc.l    $0020008B                       ; server name (31 bytes)
ReadPRAM:
            moveq   #0,D0
            btst    #14,HWCfgFlags
            beq.b   .L2
            lea     pRamTable,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _ReadXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
WritePRAM:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     pRamTable,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _WriteXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
myGetA5:
            move.l  A5,D0
            rts
mySetA5:
            movea.l (4,SP),A5
            rts
myGetIcn:
            move.l  (4,SP),D0
            lsl.w   #7,D0
            lea     .myIcons,A0
            add.l   A0,D0
            rts
.myIcons:
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1210,$1090
            dc.w    $1210,$1090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1211,$1090
            dc.w    $1211,$1090,$1201,$0090,$1201,$0090,$1203,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
myGetMask:
            dc.w    $0FFF,$FFE0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0

            EVEN
