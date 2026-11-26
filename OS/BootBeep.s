            include "Include/ROMHeader.s"

            EXPORT  BOOTBEEP6,DoBeep,ErrorBeep1,ErrorBeep2,ErrorBeep3,ErrorBeep4

            IMPORT  BOOTBEEPPATCH,OrigBootBeep6,OrigErrorBeep1,OrigErrorBeep2,OrigErrorBeep3,OrigErrorBeep4

            SECTION "BootBeep",CODE

BootBeep:
            BSR6    BOOTBEEP6
            rts
BOOTBEEP6:
            bra.l   BOOTBEEPPATCH
            bne.b   DoBeep
            BigJmp  OrigBootBeep6,A0
ErrorBeep1:
            moveq   #1,D0
            tst.b   (ascVersion,A3)
            bne.b   DoBeep
            BigJmp  OrigErrorBeep1,A0
ErrorBeep2:
            moveq   #2,D0
            tst.b   (ascVersion,A3)
            bne.b   DoBeep
            BigJmp  OrigErrorBeep2,A0
ErrorBeep3:
            moveq   #3,D0
            tst.b   (ascVersion,A3)
            bne.b   DoBeep
            BigJmp  OrigErrorBeep3,A0
ErrorBeep4:
            moveq   #4,D0
            tst.b   (ascVersion,A3)
            bne.b   DoBeep
            BigJmp  OrigErrorBeep4,A0
DoBeep:
            movea.l A6,A2
            movea.l A3,A6
            lea     sub_40845DF6.L5,A4
            add.w   D0,D0
            move.w  (0,A4,D0.w),D0
            lea     (0,A4,D0.w),A4
            cmpi.b  #batmanSound,(ascVersion,A6)
            bne.b   .L1
            move.b  #1,(bmIntControlA,A6)
            move.b  #1,(bmIntControlB,A6)
            move.b  #2,(ascPlayRecA,A6)
.L1:
            ori.b   #$80,(ascFifoControl,A6)
            andi.b  #$7F,(ascFifoControl,A6)
            move.b  #$E0,(ascVolControl,A6)
            move.b  #1,(ascMode,A6)
            cmpi.b  #batmanSound,(ascVersion,A6)
            beq.b   .L2
            clr.b   (ascClockRate,A6)
            move.b  #2,(ascChipControl,A6)
            bra.b   .L3
.L2:
            clr.b   (bmFifoControlA,A6)
            clr.b   (bmFifoControlB,A6)
            move.w  #$812F,(bmSrcTimeIncrA,A6)
            move.w  #$812F,(bmSrcTimeIncrB,A6)
            clr.w   ($F10,A6)
            move.w  #$3C,($F12,A6)
            move.w  #$CC73,($F14,A6)
            move.w  #$C962,($F16,A6)
            clr.w   ($F30,A6)
            move.w  #$3C,($F32,A6)
            move.w  #$CC73,($F34,A6)
            move.w  #$C962,($F36,A6)
            move.b  #$7F,(bmLeftScaleA,A6)
            clr.b   (bmRightScaleA,A6)
            clr.b   (bmLeftScaleB,A6)
            move.b  #$7F,(bmRightScaleB,A6)
            move.b  #$80,(bmFifoControlA,A6)
            move.b  #$80,(bmFifoControlB,A6)
.L3:
            moveq   #0,D6
            move.l  D6,D3
            movea.l D6,A3
            movea.l D6,A0
            move.l  #$10001,D2
            move.l  #$10001,D4
            cmpi.b  #batmanSound,(ascVersion,A6)
            bne.b   .L5
            move.w  #$7F,D5
.L4:
            move.l  #$80808080,(ascFifoLeft,A6)
            move.l  #$80808080,(ascFiFoRight,A6)
            dbra    D5,.L4
.L5:
            move.l  #$4000,D5
            move.w  (8,A4),D2
            tst.w   (A4)
            bne.b   .L6
            swap    D2
            move.w  ($A,A4),D2
            swap    D2
            move.w  ($C,A4),D4
            swap    D4
            move.w  ($E,A4),D4
            swap    D4
            bra.b   sub_40845DCE.L1
.L6:
            swap    D5
            move.w  (2,A4),D5
.L7:
            swap    D5
            lea     sub_40845D82,A1
            jmp     sub_40845DF6.L6
sub_40845D82:
            lea     sub_40845D8A,A1
            jmp     sub_40845DF6.L4
sub_40845D8A:
            swap    D5
            subq.w  #1,D5
            bne.b   DoBeep.L7
            swap    D2
            move.w  ($A,A4),D2
            swap    D2
            move.w  (4,A4),D5
.L1:
            swap    D5
            lea     sub_40845DA6,A1
            jmp     sub_40845DF6.L6
sub_40845DA6:
            lea     sub_40845DAE,A1
            jmp     sub_40845DF6.L4
sub_40845DAE:
            swap    D5
            subq.w  #1,D5
            bne.b   sub_40845D8A.L1
            move.w  ($C,A4),D4
            move.w  (6,A4),D5
.L1:
            swap    D5
            lea     sub_40845DC6,A1
            jmp     sub_40845DF6.L6
sub_40845DC6:
            lea     sub_40845DCE,A1
            jmp     sub_40845DF6.L4
sub_40845DCE:
            swap    D5
            subq.w  #1,D5
            bne.b   sub_40845DAE.L1
            swap    D4
            move.w  ($E,A4),D4
            swap    D4
            bra.b   .L2
.L1:
            swap    D5
.L2:
            move.w  #$21,D5
.L3:
            swap    D5
            lea     sub_40845DEE,A1
            jmp     sub_40845DF6.L6
sub_40845DEE:
            lea     sub_40845DF6,A1
            jmp     sub_40845DF6.L4
sub_40845DF6:
            subi.w  #$200,D5
            swap    D5
            cmpi.b  #batmanSound,(ascVersion,A6)
            nop
            subq.w  #1,D5
            bne.b   sub_40845DCE.L3
            cmpi.b  #batmanSound,(ascVersion,A6)
            bne.b   .L2
.L1:
            move.b  ($804,A6),D0
            andi.b  #3,D0
            cmpi.b  #3,D0
            bne.b   .L1
.L2:
            clr.b   (ascMode,A6)
            clr.b   (ascVolControl,A6)
            cmpi.b  #batmanSound,(ascVersion,A6)
            bne.b   .L3
            clr.b   (bmIntControlA,A6)
            clr.b   (bmIntControlB,A6)
.L3:
            movea.l A6,A3
            movea.l A2,A6
            RTS6
.L4:
            move.b  (ascFifoInt,A6),D0
            andi.b  #1,D0
            beq.b   .L4
            jmp     (A1)
.L5:
            dc.w    $000A,$001A,$002A,$003A,$004A
            ds.b    8
            dc.w    $8000,$C000,0,$C080,$0001,$0008,$0008,$0008
            dc.w    $8000,$A145,$BFC9,0,$0001,$0008,$0008,$0008
            dc.w    $8000,$9838,$B505,$D745,$0001,$000C,$0006,$000C
            dc.w    $8000,$8FAD,$9838,$8000,$0001,$0008,$0008,$0008
            dc.w    $A145,$AADC,$A145,$879C
.L6:
            move.l  #$FF0000,D1
            lea     .WaveTable,A5
.L7:
            clr.w   D1
            moveq   #0,D0
            move.w  D2,D0
            bne.b   .L8
            addi.l  #$10000,D3
.L8:
            add.l   D0,D3
            swap    D2
            move.w  D2,D0
            bne.b   .L9
            adda.l  #$10000,A3
.L9:
            adda.l  D0,A3
            swap    D2
            move.w  D4,D0
            bne.b   .L10
            adda.l  #$10000,A0
.L10:
            adda.l  D0,A0
            swap    D4
            move.w  D4,D0
            bne.b   .L11
            addi.l  #$10000,D6
.L11:
            add.l   D0,D6
            swap    D4
            move.l  D3,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D1
            move.l  A3,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,D1
            move.l  A0,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,D1
            move.l  D6,D0
            and.l   D1,D0
            swap    D0
            move.b  (0,A5,D0.w),D0
            add.w   D0,D1
            moveq   #0,D0
            move.w  D1,D0
            subi.w  #$200,D0
            ext.l   D0
            muls.w  D5,D0
            swap    D0
            addi.w  #$80,D0
            move.b  D0,(ascFifoLeft,A6)
            move.b  D0,(ascFiFoRight,A6)
            move.b  (ascFifoInt,A6),D0
            andi.b  #2,D0
            beq.w   .L7
            jmp     (A1)
.WaveTable:                                 ; 256-byte triangle wave (8 periods of 32), offset binary
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            dc.b    $80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$FF,$F0,$E0,$D0,$C0,$B0,$A0,$90
            dc.b    $80,$70,$60,$50,$40,$30,$20,$10,$00,$10,$20,$30,$40,$50,$60,$70
            ds.b    4

            EVEN
