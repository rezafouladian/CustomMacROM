DrvTbl:
; Per-drive table, 3 sets of 4 drives: logical icon, physical icon, drive info (offsets from the set)
            dc.w    DiskMediaIcon-DrvTbl,IntDrvIcon1-DrvTbl,$0003
            dc.w    DiskMediaIcon-DrvTbl,ExtDrvIcon1-DrvTbl,$0803
            dc.w    DiskMediaIcon-DrvTbl,DiskMediaIcon-DrvTbl,$0507
            dc.w    DiskMediaIcon-DrvTbl,DiskMediaIcon-DrvTbl,$0D07
DrvTbl2:
            dc.w    DiskMediaIcon-DrvTbl2,IntDrvIcon2-DrvTbl2,$0003
            dc.w    DiskMediaIcon-DrvTbl2,ExtDrvIcon2-DrvTbl2,$0103
            dc.w    DiskMediaIcon-DrvTbl2,DiskMediaIcon-DrvTbl2,$0507
            dc.w    DiskMediaIcon-DrvTbl2,DiskMediaIcon-DrvTbl2,$0D07
DrvTbl3:
            dc.w    DiskMediaIcon-DrvTbl3,IntDrvIcon3-DrvTbl3,$0003
            dc.w    DiskMediaIcon-DrvTbl3,ExtDrvIcon3-DrvTbl3,$0103
            dc.w    DiskMediaIcon-DrvTbl3,DiskMediaIcon-DrvTbl3,$0507
            dc.w    DiskMediaIcon-DrvTbl3,DiskMediaIcon-DrvTbl3,$0D07
DiskMediaIcon:
            dc.l    $7FFFFFF8,$81000104,$81007102,$81008901
            dc.l    $81008901,$81008901,$81008901,$81008901
            dc.l    $81007101,$81000101,$80FFFE01,$80000001
            dc.l    $80000001,$80000001,$80000001,$80000001
            dc.l    $80000001,$80000001,$87FFFFE1,$88000011
            dc.l    $88000011,$88000011,$88000011,$88000011
            dc.l    $88000011,$88000011,$88000011,$88000011
            dc.l    $88000011,$88000011,$88000011,$7FFFFFFE
            dc.l    $7FFFFFF8,$FFFFFFFC,$FFFFFFFE,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$7FFFFFFE
            dc.b    0,0
ExtDrvIcon3:
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$7FFF8000,$80004000
            dc.l    $9FFE4000,$A0014000,$A0014000,$A0014000
            dc.l    $A0014000,$A0014000,$A0014040,$A0014040
            dc.l    $A0014040,$9FFE4040,$800041F0,$800040E0
            dc.l    $80004040,$80FE4000,$80005FFF,$80005001
            dc.l    $80005001,$800053F9,$7FFF9001,$40009001
            dc.l    $7FFF9FFF,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$7FFF8000,$FFFFC000
            dc.l    $FFFFC000,$FFFFC000,$FFFFC000,$FFFFC000
            dc.l    $FFFFC000,$FFFFC000,$FFFFC000,$FFFFC000
            dc.l    $FFFFC000,$FFFFC000,$FFFFC000,$FFFFC000
            dc.l    $FFFFC000,$FFFFC000,$FFFFDFFF,$FFFFDFFF
            dc.l    $FFFFDFFF,$FFFFDFFF,$7FFF9FFF,$7FFF9FFF
            dc.l    $7FFF9FFF,$00000000,$00000000,$00000000
            dc.b    0,0
ExtDrvIcon1:
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$FFFFFFFF
            dc.l    $80000001,$80000001,$903FC7F9,$80000001
            dc.l    $80040001,$800E0001,$801F0001,$80040001
            dc.l    $80040001,$80040001,$80000001,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.b    0,0
IntDrvIcon1:
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$FFFFFFFF
            dc.l    $80000001,$80000001,$903FC7F9,$80000001
            dc.l    $80000081,$800001C1,$800003E1,$80000081
            dc.l    $80000081,$80000081,$80000001,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.b    0,0
IntDrvIcon3:
            dc.l    $00000000,$07FFFFE0,$08000010,$08000010
            dc.l    $08FFFF10,$09000090,$09555090,$09000090
            dc.l    $09550090,$09000090,$09500090,$09000090
            dc.l    $09500090,$09000090,$09540090,$09000090
            dc.l    $09000090,$08FFFF10,$08000010,$08000010
            dc.l    $08000010,$08100010,$08180010,$08FCFF10
            dc.l    $08180010,$08100010,$08000010,$07FFFFE0
            dc.l    $04000020,$04000020,$04000020,$03FFFFC0
            dc.l    $00000000,$07FFFFE0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$0FFFFFF0
            dc.l    $0FFFFFF0,$0FFFFFF0,$0FFFFFF0,$07FFFFE0
            dc.l    $07FFFFE0,$07FFFFE0,$07FFFFE0,$03FFFFC0
            dc.b    0,0
IntDrvIcon2:
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000080,$00000080,$00000080
            dc.l    $00000080,$000003E0,$000001C0,$00000080
            dc.l    $00000000,$FFFFFFFF,$80000001,$FFFFFFFF
            dc.l    $80000001,$80000001,$80000001,$FFFFFFFF
            dc.l    $80000FF9,$80000001,$80000001,$A0000001
            dc.l    $80000001,$FFFFFFFF,$80000001,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000080,$00000080,$00000080
            dc.l    $00000080,$000003E0,$000001C0,$00000080
            dc.l    $00000000,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.b    0,0
ExtDrvIcon2:
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000010
            dc.l    $00000010,$FFFFFC10,$80000410,$FFFFFC7C
            dc.l    $80000438,$FFFFFC10,$8001F400,$A00005FF
            dc.l    $80000501,$FFFFFD7D,$80000501,$FFFFFDFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000010
            dc.l    $00000010,$FFFFFC10,$FFFFFC10,$FFFFFC7C
            dc.l    $FFFFFC38,$FFFFFC10,$FFFFFC00,$FFFFFDFF
            dc.l    $FFFFFDFF,$FFFFFDFF,$FFFFFDFF,$FFFFFDFF
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.l    $00000000,$00000000,$00000000,$00000000
            dc.b    0,0
ctlLogIcon:
            bne.b   ctlRet
            bsr.b   getDrvTbl
            move.w  (A3),D0                         ; D0= icon ptr offset
            movea.l ($134,A1),A3                    ; A3= base of current DrvTbl
            bclr    #0,D0                           ; Test & clear "use ROM table" bit
            beq.b   .L1
            lea     DrvTbl,A3
.L1:
            bra.w   IconAddrTail
ctlPhysIcon:
            bne.b   ctlRet
            bsr.b   getDrvTbl
            move.w  (2,A3),D0                       ; D0= icon ptr offset
            movea.l ($134,A1),A3                    ; A3= base of current DrvTbl
            bclr    #0,D0                           ; Test & clear "use ROM table" bit
            beq.b   .L1
            lea     DrvTbl,A3
.L1:
            bra.w   IconAddrTail
ctlDrvInfo:
            bne.b   ctlRet
            bsr.b   getDrvTbl
            move.w  (4,A3),D0                       ; D0.L= drive characteristics
            cmpi.w  #3,($12,A1)
            bge.b   CtlParam
            tst.b   ($16,A1,D1.w)                   ; mfmDrive: is this a SuperDrive?
            bpl.b   CtlParam
            move.b  #4,D0                           ; Yes, mark it as such
CtlParam:
            move.l  D0,($1C,A0)
            moveq   #0,D0
ctlRet:
            bra.w   DiskRTS.L9
getDrvTbl:
            move.w  ($12,A1),D0
            subq.w  #1,D0
            add.w   D0,D0
            movea.w D0,A3
            add.w   D0,D0
            add.w   A3,D0
            movea.l ($134,A1),A3
            adda.w  D0,A3
            rts
sub_4086E0AA:
            lea     .L3,A2
.L1:
            addq.w  #4,A2
            move.w  (A2)+,D0
            bmi.b   .L2
            cmp.b   BoxFlag,D0
            bne.b   .L1
            adda.l  (A2),A2
            rts
.L2:
            lea     .L4,A2
.L3:
            adda.l  (A2),A2
            rts
            dc.w    0
.L4:
            dc.w    $FFFF,$F820,$0001,$FFFF,$F81A,$0003,$FFFF,$F844
            dc.w    $0002,$FFFF,$F826,$0005,$FFFF,$F820,$0006,$FFFF
            dc.w    $F802,$0007,$FFFF,$F7FC,$0008,$FFFF,$F80E,$0009
            dc.w    $FFFF,$F820,$0009,$FFFF,$F81A,$000C,0,$288A
            dc.w    $000D,0,$289C,$000E,0,$28AE,$000F,0
            dc.b    $28,$C0,$00,$10,$00,$00,$28,$D2,$FF
            ds.b    23
