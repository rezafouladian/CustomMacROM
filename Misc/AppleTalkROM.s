            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryDRVR_9

            IMPORT  BaseOfROM,RsrcEntryDRVR_127

            SECTION "AppleTalkROM",CODE

RsrcEntryatlk_10:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'atlk' 10 "Main" (3236 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_127-BaseOfROM     ; Next entry
            dc.l    Rsrcatlk_10-BaseOfROM           ; Data
            dc.b    'atlk'                          ; Type
            dc.w    10                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            dc.b    ' Apple C'
            dc.l    $C0A00000,$00000CB0,$00000284   ; Block header
Rsrcatlk_10:
            bra.b   .L1
            dc.w    $6004,0,$0078,$0C40,$0001,$6700,$00B2,$487A
            dc.w    $000E
            movem.l D0/A0,-(SP)
            move.w  #8,D0
            bra.w   sub_408D9DB2.L7
            cmpi.w  #2,D0
            beq.w   sub_408D91CA.L2
            cmpi.w  #3,D0
            beq.w   sub_408D94C2
            cmpi.w  #4,D0
            beq.w   sub_408D950E
            cmpi.w  #5,D0
            beq.w   sub_408D952C
            cmpi.w  #6,D0
            beq.w   sub_408D952C.L1
            moveq   #-1,D0
            rts
.L1:
            pea     sub_408D91CA
            movem.l D0/A0,-(SP)
            clr.w   D0
            bra.w   sub_408D9DB2.L7
sub_408D91CA:
            cmpi.b  #1,D0
            beq.w   sub_408D96A2.L6
            cmpi.b  #0,D0
            beq.w   sub_408D952C.L4
            cmpi.b  #$FF,D0
            beq.w   sub_408D96A2.L8
            jmp     (A0)
            ds.b    4
            dc.b    $02,$22,$80,$00,$00,$00,$07
            dc.b    '2.2.2  9EtherTalk atlk v2.2.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1987-1991 <'
            dc.w    0,$03EA,$A71E,$6600,$01FC,$2678,$02B6,$47EB
            dc.b    $01,$0C,$26,$88,$26,$48,$37,$7C,$00,$06,$01
            dc.b    'HYO/<aarp '
            dc.b    $01,$48,$40,$E0,$48,$3F,$00,$A9,$A0,$20,$1F,$67,$08
            dc.b    ' @ P7P'
            dc.w    $0148,$6100,$079A,$4841,$3741,$0032,$303C,$A06E
            dc.w    $A346,$2F08,$303C,$A89F,$A746,$B1DF,$57C3,$41EB
            dc.w    $0010,$4A03,$670C,$43FA,$01AC,$2149,$0012,$A000
            dc.w    $600A,$43FA,$019A,$2149,$0012,$A200,$6748,$4A03
            dc.w    $6600,$0174,$701B,$4267,$51C8,$FFFC,$204F,$317C
            dc.w    $0004,$0028,$317C,$0001,$002A,$117C,$0003,$0030
            dc.w    $7015,$A06E,$3228,$0031,$4FEF,$0038,$4A40,$6708
            dc.w    $50C3,$323C,$FFFF,$60A6,$3741,$0032,$41EB,$0010
            dc.w    $A200,$6600,$0132,$4841
            movem.l D1/A0,-(SP)
            move.w  ($18,A0),D2
            lea     sub_408D993C,A0
            lea     sub_408D9A72.L1,A1
            moveq   #$15,D0
            movea.l LAPMgrPtr,A2
            jsr     (2,A2)
            movem.l (SP)+,D1/A0
            bne.w   .L1
            movem.l D1/A0,-(SP)
            move.w  ($18,A0),D2
            lea     sub_408D97D0,A0
            lea     sub_408D9A72.L2,A1
            moveq   #$15,D0
            movea.l LAPMgrPtr,A2
            jsr     (2,A2)
            movem.l (SP)+,D1/A0
            bne.w   .L1
            move.w  #$F6,($1A,A0)
            lea     ($1C,A0),A1
            move.l  #$9000700,(A1)
            st      (3,A1)
            st      (4,A1)
            st      (5,A1)
            _Control
            bne.w   .L1
            move.w  #$FC,($1A,A0)
            move.w  #6,($22,A0)
            lea     ($CE,A3),A1
            move.l  A1,($1E,A0)
            _Control
            move.w  #$F9,($1A,A0)
            lea     ($E2,A3),A1
            move.l  #$9000700,(A1)
            st      (3,A1)
            st      (4,A1)
            st      (5,A1)
            lea     ($C,A1),A1
            move.w  #$24,(A1)+
            move.w  #$AAAA,(A1)+
            move.b  #3,(A1)+
            clr.b   (A1)+
            clr.w   (A1)+
            move.w  #$80F3,(A1)+
            move.w  #1,(A1)+
            move.w  #$809B,(A1)+
            move.b  #6,(A1)+
            move.b  #4,(A1)+
            addq.w  #2,A1
            move.l  ($CE,A3),(A1)+
            move.w  ($D2,A3),(A1)+
            lea     ($4A,A3),A1
            moveq   #$3A,D0
            _BlockMove
            lea     ($7C,A3),A0
            move.l  A0,($1E,A1)
            move.w  #$32,(A0)+
            lea     ($114,A3),A1
            move.l  A1,(A0)
            lea     ($C,A1),A1
            move.w  #$24,(A1)+
            move.w  #$AAAA,(A1)+
            move.b  #3,(A1)+
            clr.b   (A1)+
            clr.w   (A1)+
            move.w  #$80F3,(A1)+
            lea     ($D4,A3),A0
            move.w  #1,(4,A0)
            lea     sub_408D964A,A1
            move.l  A1,(6,A0)
            move.w  #$E10,($A,A0)
            _VInstall
            clr.b   D1
            moveq   #2,D0
            move.w  #$FD00,D2
            lea     Rsrcatlk_10,A0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            moveq   #0,D0
            rts
.L1:
            move.l  D0,-(SP)
            bsr.w   sub_408D9B54
            movea.l A3,A0
            _DisposPtr
            movea.l ExpandMem,A3
            lea     ($10C,A3),A3
            clr.l   (A3)
            move.l  (SP)+,D0
            rts
            dc.b    5,'.ENET'
            dc.b    6,'.ENET0'
            dc.b    $00
.L2:
            moveq   #3,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            lea     ($10,A3),A0
            move.w  #$F5,($1A,A0)
            lea     ($1C,A0),A1
            move.l  #$9000700,(A1)
            st      (3,A1)
            st      (4,A1)
            st      (5,A1)
            _Control
            movem.l A2,-(SP)
            move.w  ($18,A0),D2
            lea     sub_408D9A72.L1,A1
            moveq   #$16,D0
            movea.l LAPMgrPtr,A2
            jsr     (2,A2)
            move.w  ($18,A0),D2
            lea     sub_408D9A72.L2,A1
            moveq   #$16,D0
            movea.l LAPMgrPtr,A2
            jsr     (2,A2)
            movem.l (SP)+,A2
            lea     ($D4,A3),A0
            _VRemove
            bsr.w   sub_408D9B54
            movea.l A3,A0
            _DisposPtr
            movea.l ExpandMem,A3
            lea     ($10C,A3),A3
            clr.l   (A3)
            moveq   #0,D0
            rts
sub_408D94C2:
            movem.l A1,-(SP)
            cmpi.w  #$16,D1
            blt.b   .L1
            move.l  A3,-(SP)
            movea.l ExpandMem,A3
            move.l  ($10C,A3),D0
            movea.l (SP)+,A3
            beq.b   .L1
            move.w  #3,(A1)+
            move.w  #$16,(A1)+
            move.l  #$989680,(A1)+
            clr.l   (A1)+
            moveq   #0,D0
            bset    #7,D0
            move.b  D0,(A1)+
            move.b  #6,(A1)+
            movea.l D1,A0
            move.l  ($CE,A0),(A1)+
            move.w  ($D2,A0),(A1)+
            clr.w   (A1)+
            moveq   #0,D0
            bra.b   .L2
.L1:
            moveq   #-1,D0
.L2:
            movem.l (SP)+,A1
            rts
sub_408D950E:
            move.l  #$9000700,(A1)
            clr.b   (4,A1)
            andi.l  #$FFFF,D1
            divu.w  #$FD,D1
            swap    D1
            move.b  D1,(5,A1)
            moveq   #0,D0
            rts
sub_408D952C:
            movea.l ExpandMem,A0
            movea.l ($10C,A0),A0
            move.w  ($28,A0),($9C,A0)
            lea     ($84,A0),A0
            move.w  #$F6,($1A,A0)
            bra.b   .L2
.L1:
            movea.l ExpandMem,A0
            movea.l ($10C,A0),A0
            move.w  ($28,A0),($BE,A0)
            lea     ($A6,A0),A0
            move.w  #$F5,($1A,A0)
.L2:
            move.w  (A1)+,($1C,A0)
            move.l  (A1)+,($1E,A0)
            moveq   #-1,D0
            tst.w   ($10,A0)
            bgt.b   .L3
            _Control async
.L3:
            rts
.L4:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            bset    #4,($C8,A3)
            move.l  A0,($3D2,A3)
            move.l  A1,($3C6,A3)
            movea.l (2,A1),A0
            move.l  A0,($3C0,A3)
            addq.w  #3,(2,A1)
            moveq   #0,D0
            move.w  (A1),D0
            move.w  D0,($3C4,A3)
            subq.w  #3,(A1)
            move.l  A4,-(SP)
            lea     ($15C,A3),A4
            move.w  #$AAAA,(A4)+
            move.b  #3,(A4)+
            move.b  #8,(A4)+
            clr.b   (A4)+
            move.b  #7,(A4)+
            move.w  #$809B,(A4)+
            addq.w  #3,A0
            subq.w  #3,D0
            movea.l A4,A1
            movea.l (SP)+,A4
            tst.w   D0
            beq.b   .L5
            _BlockMove
.L5:
            lea     ($14E,A3),A1
            cmpi.b  #$FF,D2
            bne.b   .L6
            move.l  #$9000700,(A1)
            st      (3,A1)
            st      (4,A1)
            st      (5,A1)
            bra.w   sub_408D96A2.L1
.L6:
            bsr.w   sub_408D9A48
            bmi.b   .L7
            move.w  D1,(A1)+
            move.l  D0,(A1)+
            bra.w   sub_408D96A2.L1
.L7:
            move.l  D2,($14A,A3)
            lea     ($F8,A3),A1
            move.w  #1,(6,A1)
            move.l  D2,($18,A1)
            lea     ($10,A3),A0
            move.w  #$F9,($1A,A0)
            lea     ($42,A3),A1
            move.l  A1,($1E,A0)
            bclr    #5,($C8,A3)
            move.w  #$A,($146,A3)
            move.w  ($148,A3),($DE,A3)
.L8:
            bset    #6,($C8,A3)
            bne.b   sub_408D9682.L1
            lea     sub_408D9682,A1
.L9:
            move.l  A1,($C,A0)
            _Control async
            cmpi.w  #$FFE4,D0
            beq.b   .L10
            rts
.L10:
            tst.w   D0
            jmp     (A1)
sub_408D964A:
            move.w  #$E10,($A,A0)
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            tst.w   ($146,A3)
            beq.b   sub_408D9682.L1
            subq.w  #1,($146,A3)
            beq.b   .L2
.L1:
            move.w  ($148,A3),($A,A0)
            lea     ($10,A3),A0
            bra.b   sub_408D952C.L8
.L2:
            btst    #6,($C8,A3)
            beq.b   .L3
            addq.w  #1,($146,A3)
            bra.b   .L1
.L3:
            moveq   #-$5F,D0
            bra.b   sub_408D96A2.L5
sub_408D9682:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            move    SR,-(SP)
            move    #$2600,SR
            bclr    #6,($C8,A3)
            btst    #5,($C8,A3)
            bne.b   sub_408D96A2
            move    (SP)+,SR
.L1:
            rts
sub_408D96A2:
            move    (SP)+,SR
            movea.l ($3CA,A3),A2
.L1:
            moveq   #0,D0
            movea.l ($3C6,A3),A1
            movea.l A1,A0
            tst.w   (A0)
            beq.b   .L3
.L2:
            move.w  (A0),D1
            beq.b   .L4
            add.w   D1,D0
.L3:
            addq.w  #6,A0
            bra.b   .L2
.L4:
            addq.w  #8,D0
            lea     ($15A,A3),A0
            move.w  D0,(A0)
            lea     ($10,A3),A0
            move.w  #$F9,($1A,A0)
            move.l  A1,($1E,A0)
            addi.w  #$16,(A1)+
            lea     ($14E,A3),A3
            move.l  A3,(A1)
            lea     .L5,A1
            bra.w   sub_408D952C.L9
.L5:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            movea.l ($3CA,A3),A2
            movea.l ($3C6,A3),A1
            move.w  ($3C4,A3),(A1)
            movea.l ($3C0,A3),A0
            move.l  A0,(2,A1)
            movea.l ($3D2,A3),A0
            jmp     (A0)
.L6:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            move.l  A0,($3D2,A3)
            move.l  A1,($3C6,A3)
            movea.l (2,A1),A0
            move.l  A0,($3C0,A3)
            addq.w  #3,(2,A1)
            addq.w  #3,A0
            moveq   #0,D0
            move.w  (A1),D0
            move.w  D0,($3C4,A3)
            subq.w  #3,(A1)
            subq.w  #3,D0
            lea     ($15C,A3),A1
            move.w  #$AAAA,(A1)+
            move.b  #3,(A1)+
            move.b  #8,(A1)+
            clr.b   (A1)+
            move.b  #7,(A1)+
            move.w  #$809B,(A1)+
            tst.w   D0
            beq.b   .L7
            _BlockMove
.L7:
            lea     ($14E,A3),A1
            movea.l D2,A0
            move.w  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            bra.w   .L1
.L8:
            move.l  A0,-(SP)
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            move.l  A2,($3CA,A3)
            move.l  A1,($3CE,A3)
            bclr    #4,($C8,A3)
            lea     ($42,A3),A1
            move.l  A1,($2E,A3)
            move.w  #$32,(A1)+
            lea     ($E2,A3),A0
            move.l  A0,(A1)+
            clr.w   (A1)+
            move.w  #3,($1C,A0)
            move.l  D2,($CA,A3)
            lea     ($F8,A3),A1
            move.l  D2,($E,A1)
            move.l  D2,($18,A1)
            lea     ($10,A3),A0
            move.w  #$F9,($1A,A0)
            bclr    #3,($C8,A3)
            _Control
            moveq   #0,D0
            move.w  ($148,A3),D0
            add.w   D0,D0
            add.l   Ticks,D0
.L9:
            btst    #3,($C8,A3)
            bne.b   .L10
            cmp.l   Ticks,D0
            bhi.b   .L9
.L10:
            rts
sub_408D97D0:
            pea     sub_408D97E0
            movem.l D0/A0,-(SP)
            move.w  #$C,D0
            bra.w   sub_408D9DB2.L7
sub_408D97E0:
            movea.l ExpandMem,A2
            movea.l ($10C,A2),A2
            bset    #7,($C8,A2)
            bne.w   sub_408D9842.L1
            lea     ($12A,A2),A3
            move.l  D0,(A3)+
            move.w  #$18,D3
            jsr     (2,A4)
            movea.l A2,A3
            bne.b   .L1
            movea.l ($3CA,A3),A2
            lea     ($12A,A3),A1
            lea     (4,A1),A0
            cmpi.w  #$604,(A0)+
            bne.b   .L1
            move.l  ($E,A1),D2
            move.w  (8,A1),D1
            move.l  ($A,A1),D0
            cmpi.w  #2,(A0)
            bne.b   sub_408D9842.L2
            bsr.w   sub_408D991E
            bne.b   .L1
            btst    #4,($C8,A3)
            bne.b   sub_408D9842
            bsr.w   sub_408D990E
.L1:
            bclr    #7,($C8,A3)
.L2:
            rts
sub_408D9842:
            bsr.w   sub_408D9A2A
            cmp.l   ($14A,A3),D2
            bne.b   sub_408D97E0.L1
            tst.w   ($146,A3)
            beq.b   sub_408D97E0.L1
            clr.w   ($146,A3)
            move.w  #$E10,($DE,A3)
            move.w  D1,($14E,A3)
            move.l  D0,($150,A3)
            bclr    #7,($C8,A3)
            bset    #5,($C8,A3)
            btst    #6,($C8,A3)
            bne.b   sub_408D97E0.L2
            bra.w   sub_408D96A2.L1
.L1:
            moveq   #0,D3
            jmp     (2,A4)
.L2:
            cmpi.w  #3,(A0)
            bne.b   sub_408D98A4
            bsr.w   sub_408D9A72
            bsr.w   sub_408D991E
            bne.b   .L3
            btst    #4,($C8,A3)
            bne.b   sub_408D98A4.L1
            bsr.b   sub_408D990E
.L3:
            bclr    #7,($C8,A3)
            rts
sub_408D98A4:
            cmpi.w  #1,(A0)
            bne.b   sub_408D9842.L3
            bsr.w   sub_408D9A2A
            bsr.b   sub_408D991E
            bne.b   sub_408D9842.L3
            btst    #4,($C8,A3)
            beq.b   sub_408D9842.L3
.L1:
            move.l  (8,A1),D1
            move.l  D1,(-$16,A1)
            move.l  D1,($12,A1)
            move.w  ($C,A1),D1
            move.w  D1,(-$12,A1)
            move.w  D1,($16,A1)
            move.l  ($E,A1),D1
            move.l  ($18,A1),($E,A1)
            move.l  D1,($18,A1)
            move.l  ($CE,A3),(8,A1)
            move.w  ($D2,A3),($C,A1)
            move.w  #2,(6,A1)
            lea     ($4A,A3),A0
            lea     sub_408D98FE,A1
            bra.w   sub_408D952C.L9
sub_408D98FE:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            bclr    #7,($C8,A3)
            rts
sub_408D990E:
            bset    #3,($C8,A3)
            moveq   #5,D0
            movea.l LAPMgrPtr,A0
            jmp     (2,A0)
sub_408D991E:
            move.l  ($3CE,A3),D3
            beq.b   .L1
            movea.l D3,A0
            move.b  (A0),D3
            bmi.b   .L2
            andi.b  #$F,D3
.L1:
            subq.b  #1,D3
            bne.b   .L2
            move.l  ($18,A1),D3
            cmp.l   ($CA,A3),D3
.L2:
            rts
sub_408D993C:
            movea.l ExpandMem,A2
            movea.l ($10C,A2),A2
            move.l  ($3CE,A2),D2
            beq.w   sub_408D99F2.L1
            movea.l D2,A5
            move.b  (A5),D2
            bmi.w   sub_408D99F2.L1
            andi.b  #$F,D2
            subq.b  #1,D2
            bne.w   sub_408D99F2.L1
            move.l  D1,D3
            move.w  (-$10,A3),D0
            move.l  (-$E,A3),D1
            movem.l D0-D1,($3D6,A2)
            move.l  D3,D1
            movea.l ($3CA,A2),A2
            move.w  ($1C,A2),D3
            addi.w  #$100,D3
            move    D3,SR
            lea     (4,A2),A3
            moveq   #$D,D3
            jsr     (A4)
            bne.b   sub_408D99F2.L2
            lea     (4,A2),A3
            move.w  (A3),D0
            andi.w  #$3FF,D0
            subi.w  #$D,D0
            cmp.w   D1,D0
            bhi.b   .L1
            move.w  D0,D1
.L1:
            move.w  (A3),D0
            andi.w  #$3C00,D0
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            beq.b   .L2
            lea     ($3D8,A3),A3
            move.l  A3,D3
            bra.b   .L3
.L2:
            move.l  D1,D3
            movem.l ($3D6,A3),D0-D1
            exg     D0,D1
            moveq   #0,D2
            move.w  ($A,A2),D2
            lsl.l   #8,D2
            move.b  ($D,A2),D2
            bsr.b   sub_408D9A2A
            move.l  D3,D1
            moveq   #0,D3
.L3:
            move.b  ($C,A2),(1,A2)
            move.b  ($D,A2),(2,A2)
            move.b  #2,(3,A2)
            pea     sub_408D99F2
            movem.l D0/A0,-(SP)
            move.w  #4,D0
            bra.w   sub_408D9DB2.L7
sub_408D99F2:
            lea     ($11,A2),A3
            moveq   #1,D0
            movea.l LAPMgrPtr,A5
            jsr     (2,A5)
.L1:
            moveq   #0,D3
            jmp     (2,A4)
.L2:
            rts
            movem.l D1-D2/A1-A2,-(SP)
            moveq   #$3C,D0
            move.w  #$FD,D1
            swap    D1
            move.w  #$64,D1
            move.w  #4,D2
            swap    D2
            move.w  #6,D2
            bsr.b   sub_408D9A9E
            movem.l (SP)+,D1-D2/A1-A2
            rts
sub_408D9A2A:
            movem.l A0-A3,-(SP)
            move.l  D2,-(SP)
            movea.l SP,A0
            move.l  D0,-(SP)
            move.w  D1,-(SP)
            movea.l SP,A1
            bsr.w   sub_408D9B76
            move.w  (SP)+,D1
            move.l  (SP)+,D0
            move.l  (SP)+,D2
            movem.l (SP)+,A0-A3
            rts
sub_408D9A48:
            movem.l A0-A3,-(SP)
            move.l  D2,-(SP)
            movea.l SP,A0
            subq.w  #6,SP
            movea.l SP,A1
            bsr.w   sub_408D9C96
            tst.w   D0
            beq.b   .L1
            move    #8,CCR
.L1:
            movem.w (SP)+,D1
            movem.l (SP)+,D0
            movem.l (SP)+,D2
            movem.l (SP)+,A0-A3
            rts
sub_408D9A72:
            movem.l D0-D1/A0-A3,-(SP)
            move.l  D2,-(SP)
            movea.l SP,A0
            bsr.w   sub_408D9CC4
            move.l  (SP)+,D2
            movem.l (SP)+,D0-D1/A0-A3
            rts
.L1:
            dc.b    $01,$AA,$05,$08,$00,$07,$80,$9B,$00
.L2:
            dc.b    $01,$AA,$05,$00,$00,$00,$80,$F3,$04,$00,$01,$80,$9B,$00,$00
sub_408D9A9E:
            move.l  D0,-(SP)
            moveq   #$2A,D0
            _NewPtrSysClear
            movem.l (SP)+,D0
            bne.w   .L6
            lea     ($3E6,A3),A2
            move.l  A0,(A2)
            movea.l A0,A2
            move.l  #'xAMT',(A2)
            move.w  D0,($A,A2)
            move.w  D1,($C,A2)
            swap    D1
            move.w  D1,(4,A2)
            move.w  D2,(8,A2)
            swap    D2
            move.w  D2,(6,A2)
            moveq   #0,D0
            move.w  (4,A2),D0
            lsl.l   #2,D0
            _NewPtrSysClear
            bne.b   .L5
            move.l  A0,($14,A2)
            moveq   #0,D0
            move.w  (6,A2),D0
            add.w   (8,A2),D0
            addq.w  #6,D0
            move.w  D0,($E,A2)
            mulu.w  ($C,A2),D0
            _NewPtrSysClear
            bne.b   .L4
            move.l  A0,($18,A2)
            moveq   #0,D1
            move.w  ($C,A2),D1
            subq.w  #1,D1
.L1:
            move.l  ($10,A2),(A0)
            move.l  A0,($10,A2)
            adda.w  ($E,A2),A0
            dbra    D1,.L1
            lea     ($1C,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408D9D1C,A1
            move.l  A1,(6,A0)
            move.w  ($A,A2),D0
            beq.b   .L2
            mulu.w  #$3C,D0
            move.w  D0,($A,A0)
            _VInstall
            tst.w   D0
            bne.b   .L3
.L2:
            rts
.L3:
            movea.l ($18,A2),A0
            _DisposPtr
.L4:
            movea.l ($14,A2),A0
            _DisposPtr
.L5:
            movea.l A2,A0
            _DisposPtr
.L6:
            move.w  #$FFFF,D0
            rts
sub_408D9B54:
            movea.l ($3E6,A3),A1
            move.w  ($A,A1),D0
            beq.b   .L1
            lea     ($1C,A1),A0
            _VRemove
.L1:
            movea.l ($14,A1),A0
            _DisposPtr
            movea.l ($18,A1),A0
            _DisposPtr
            movea.l A1,A0
            _DisposPtr
            rts
sub_408D9B76:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            movea.l ($3E6,A3),A3
            move    SR,-(SP)
            move    #$2600,SR
            jsr     sub_408D9D72
            bne.b   .L2
            bset    #7,(4,A2)
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
            addq.w  #6,A2
            adda.w  (6,A3),A2
.L1:
            move.w  (A1)+,(A2)+
            dbra    D1,.L1
            suba.w  (8,A3),A1
            move    (SP)+,SR
            clr.w   D0
            rts
.L2:
            move.l  A1,D1
            lea     ($10,A3),A1
            move.l  (A1),D0
            beq.b   .L6
            movea.l D0,A2
            move.l  (A2),(A1)
            movea.l D1,A1
.L3:
            bset    #7,(4,A2)
            addq.w  #6,A2
            move.w  (6,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L4:
            move.w  (A0)+,(A2)+
            dbra    D1,.L4
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L5:
            move.w  (A1)+,(A2)+
            dbra    D1,.L5
            suba.w  (8,A3),A1
            suba.w  (8,A3),A2
            suba.w  (6,A3),A2
            suba.w  (6,A3),A0
            subq.w  #6,A2
            movea.l D2,A3
            move.l  (A3),(A2)
            move.l  A2,(A3)
            move    (SP)+,SR
            clr.w   D0
            rts
.L6:
            movea.l D1,A1
            move.w  ($A,A3),D0
            bne.b   .L7
            move    (SP)+,SR
            move.w  #$FFFF,D0
            rts
.L7:
            movem.l D2/A0-A1,-(SP)
            move.w  ($20E).w,-(SP)
            move.w  ($20E).w,-(SP)
            move.w  ($20E).w,-(SP)
            movea.l SP,A0
            jsr     sub_408D9DB2
            addq.l  #6,SP
.L8:
            movea.l A2,A0
.L9:
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L11
            btst    #7,(4,A2)
            bne.b   .L9
            move.l  (A2),(A1)
.L10:
            movem.l (SP)+,D2/A0-A1
            bra.w   .L3
.L11:
            movea.l A0,A2
            addq.l  #4,A2
            cmpa.l  D2,A2
            bne.b   .L14
.L12:
            movea.l A2,A0
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L13
            move.l  (A2),(A1)
            bra.b   .L10
.L13:
            movea.l A0,A2
            addq.l  #4,A2
            moveq   #0,D1
            move.w  (4,A3),D1
            lsl.l   #2,D1
            movea.l ($14,A3),A0
            adda.l  D1,A0
            cmpa.l  A2,A0
            bne.b   .L12
            movea.l ($14,A3),A2
            bra.b   .L12
.L14:
            moveq   #0,D1
            move.w  (4,A3),D1
            lsl.l   #2,D1
            movea.l ($14,A3),A0
            adda.l  D1,A0
            cmpa.l  A2,A0
            bne.b   .L8
            movea.l ($14,A3),A2
            cmpa.l  D2,A2
            beq.b   .L12
            bra.b   .L8
sub_408D9C96:
            movea.l ($3E6,A3),A3
            jsr     sub_408D9D72
            bne.b   .L2
            move    SR,D0
            move    #$2600,SR
            addq.w  #6,A2
            adda.w  (6,A3),A2
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L1:
            move.w  (A2)+,(A1)+
            dbra    D1,.L1
            move    D0,SR
            suba.w  (8,A3),A1
            clr.w   D0
.L2:
            rts
sub_408D9CC4:
            movea.l ($3E6,A3),A3
            jsr     sub_408D9DB2
.L1:
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D0
            beq.b   .L4
            addq.w  #6,A2
            move.w  (6,A3),D0
            asr.w   #1,D0
            subq.w  #1,D0
.L2:
            cmpm.w  (A0)+,(A2)+
            dbne    D0,.L2
            bne.b   .L3
            move.w  (6,A3),D0
            suba.w  D0,A2
            suba.w  D0,A0
            subq.w  #6,A2
            move    SR,D0
            move    #$2600,SR
            move.l  (A2),(A1)
            lea     ($10,A3),A1
            move.l  (A1),(A2)
            move.l  A2,(A1)
            move    D0,SR
            clr.w   D0
            rts
.L3:
            move.w  (6,A3),D1
            asl.w   #1,D0
            sub.w   D0,D1
            suba.w  D1,A0
            suba.w  D1,A2
            subq.w  #6,A2
            bra.b   .L1
.L4:
            move.w  #$FFFF,D0
            rts
sub_408D9D1C:
            movea.l ExpandMem,A3
            movea.l ($10C,A3),A3
            movea.l ($3E6,A3),A3
            move.w  ($A,A3),D0
            mulu.w  #$3C,D0
            move.w  D0,($A,A0)
            movea.l ($14,A3),A2
            move.w  (4,A3),D0
            subq.w  #1,D0
.L1:
            movea.l A2,A0
            move    SR,-(SP)
            move    #$2600,SR
.L2:
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L3
            bclr    #7,(4,A2)
            bne.b   .L2
            move.l  A1,D2
            move.l  (A2),(A1)
            lea     ($10,A3),A1
            move.l  (A1),(A2)
            move.l  A2,(A1)
            movea.l D2,A2
            bra.b   .L2
.L3:
            move    (SP)+,SR
            movea.l A0,A2
            addq.l  #4,A2
            dbra    D0,.L1
            rts
sub_408D9D72:
            jsr     sub_408D9DB2
.L1:
            movea.l (A2),A2
            move.l  A2,D0
            beq.b   .L4
            move.w  (6,A3),D0
            asr.w   #1,D0
            subq.w  #1,D0
            addq.w  #6,A2
.L2:
            cmpm.w  (A0)+,(A2)+
            dbne    D0,.L2
            bne.b   .L3
            move.w  (6,A3),D0
            suba.w  D0,A2
            suba.w  D0,A0
            subq.w  #6,A2
            clr.w   D0
            rts
.L3:
            move.w  (6,A3),D1
            asl.w   #1,D0
            sub.w   D0,D1
            suba.w  D1,A0
            suba.w  D1,A2
            subq.w  #6,A2
            bra.b   .L1
.L4:
            move.w  #$FFFF,D0
            rts
sub_408D9DB2:
            cmpi.w  #2,(6,A3)
            bne.b   .L1
            moveq   #0,D0
            move.w  (A0),D0
            bra.b   .L5
.L1:
            adda.w  (6,A3),A0
            move.l  -(A0),D0
            bpl.b   .L2
            neg.l   D0
.L2:
            cmpi.w  #4,(6,A3)
            beq.b   .L3
            subq.w  #2,A0
.L3:
            moveq   #0,D2
            move.w  (4,A3),D2
            swap    D2
.L4:
            sub.l   D2,D0
            bge.b   .L4
            divu.w  (4,A3),D0
            bvc.b   .L6
            add.l   D2,D0
.L5:
            divu.w  (4,A3),D0
.L6:
            swap    D0
            asl.w   #2,D0
            movea.l ($14,A3),A2
            adda.w  D0,A2
            move.l  A2,D2
            rts
.L7:
            movea.l ExpandMem,A0
            movea.l ($10C,A0),A0
            move.l  (0,A0,D0.w),D0
            beq.b   .L8
            movea.l D0,A0
            jmp     (A0)
.L8:
            movem.l (SP)+,D0/A0
            rts
            dc.b    ' DEVAJMP>>[(c)'
RsrcEntryiopc_128:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'iopc' 128 "IOPCLap A" (2676 bytes) - Combo mask
            dc.l    RsrcEntryatlk_10-BaseOfROM      ; Next entry
            dc.l    Rsrciopc_128-BaseOfROM          ; Data
            dc.b    'iopc'                          ; Type
            dc.w    128                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    9,'IOPCLap A'                   ; Name
            dc.b    $39,$38,$39
            dc.l    $C0A00000,$00000A80,$0000027C   ; Block header
Rsrciopc_128:
            dc.b    $4C,$5D,$2D,$4C,$84,$2D,$09,$A6,$A0,$36,$A2,$C1,$A9,$00,$20,$69
            dc.b    $37,$A0,$2E,$A9,$97,$A2,$04,$38,$20,$48,$37,$A0,$2E,$A9,$90,$A2
            dc.b    $04,$38,$20,$45,$37,$A2,$00,$A9,$02,$20,$5A,$37,$4C,$B0,$2D,$38
            dc.b    $20,$60,$37,$A0,$00,$A2,$00,$A9,$00,$20,$69,$37,$A2,$04,$18,$20
            dc.b    $48,$37,$A2,$06,$18,$20,$4E,$37,$A2,$0E,$18,$20,$4E,$37,$A2,$04
            dc.b    $18,$20,$45,$37,$A2,$05,$18,$20,$51,$37,$60,$A9,$07,$20,$57,$37
            dc.b    $0A,$AA,$7C,$B8,$2D,$35,$2E,$FF,$2D,$35,$2E,$CA,$2D,$CA,$2D,$FF
            dc.b    $2D,$35,$2E,$CA,$2D,$A9,$FB,$20,$5D,$37,$A0,$02,$BE,$6C,$37,$BD
            dc.b    $00,$02,$C9,$05,$B0,$0A,$C9,$01,$90,$06,$DA,$0A,$AA,$7C,$F5,$2D
            dc.b    $A9,$FE,$9D,$00,$02,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C
            dc.b    $B0,$2D,$9E,$2E,$FF,$2E,$39,$2F,$E1,$2F,$A9,$FD,$20,$5D,$37,$A2
            dc.b    $02,$BC,$6C,$37,$A9,$01,$99,$00,$03,$A6,$55,$BD,$AB,$37,$99,$01
            dc.b    $03,$BD,$A1,$37,$99,$02,$03,$B5,$73,$99,$03,$03,$B5,$6A,$99,$04
            dc.b    $03,$A2,$02,$A9,$01,$9D,$00,$03,$A9,$08,$0C,$35,$F0,$4C,$B0,$2D
            dc.b    $08,$78,$A9,$FE,$20,$5D,$37,$A5,$57,$F0,$0D,$A6,$56,$E8,$E0,$09
            dc.b    $90,$02,$A2,$00,$86,$56,$64,$57,$A6,$55,$74,$61,$E8,$E0,$09,$90
            dc.b    $02,$A2,$00,$86,$55,$E4,$56,$F0,$2E,$A2,$02,$BC,$6C,$37,$A9,$01
            dc.b    $99,$00,$03,$A6,$55,$BD,$AB,$37,$99,$01,$03,$BD,$A1,$37,$99,$02
            dc.b    $03,$B5,$73,$99,$03,$03,$B5,$6A,$99,$04,$03,$A2,$02,$A9,$01,$9D
            dc.b    $00,$03,$A9,$08,$0C,$35,$F0,$28,$4C,$B0,$2D,$A2,$05,$A9,$04,$4C
            dc.b    $5A,$37,$A2,$05,$A9,$01,$4C,$5A,$37,$A2,$08,$74,$61,$CA,$10,$FB
            dc.b    $64,$56,$64,$55,$A9,$FF,$85,$57,$A6,$56,$A9,$80,$95,$61,$A9,$C1
            dc.b    $85,$7C,$A9,$37,$85,$7D,$FA,$9E,$00,$02,$BD,$01,$02,$85,$8A,$A9
            dc.b    $54,$9D,$01,$02,$A9,$4C,$9D,$02,$02,$5A,$A0,$34,$A9,$47,$A2,$06
            dc.b    $38,$20,$4B,$37,$A0,$34,$A9,$47,$A2,$0E,$38,$20,$4E,$37,$08,$78
            dc.b    $A9,$02,$0C,$33,$F0,$20,$FE,$2F,$20,$5D,$36,$28,$7A,$A9,$03,$99
            dc.b    $00,$02,$A9,$04,$0C,$35,$F0,$4C,$B0,$2D,$FA,$5A,$BD,$01,$02,$9E
            dc.b    $01,$02,$85,$7F,$DA,$78,$A2,$06,$8E,$41,$F0,$8D,$41,$F0,$58,$A4
            dc.b    $7F,$A6,$7F,$A9,$81,$20,$3F,$31,$90,$06,$FA,$9E,$00,$02,$80,$06
            dc.b    $FA,$A9,$FF,$9D,$00,$02,$7A,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35
            dc.b    $F0,$4C,$B0,$2D,$FA,$BD,$01,$02,$8D,$C3,$37,$9E,$01,$02,$BD,$02
            dc.b    $02,$8D,$C4,$37,$9E,$02,$02,$5A,$DA,$AC,$4C,$54,$AD,$4E,$54,$A6
            dc.b    $7F,$20,$3F,$31,$90,$04,$A9,$FF,$80,$24,$EE,$98,$37,$D0,$0D,$EE
            dc.b    $99,$37,$D0,$08,$EE,$9A,$37,$D0,$03,$EE,$9B,$37,$A6,$56,$74,$61
            dc.b    $64,$57,$A9,$95,$8D,$FB,$2D,$A9,$2F,$8D,$FC,$2D,$A9,$00,$FA,$9D
            dc.b    $00,$02,$7A,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C,$B0,$2D
            dc.b    $FA,$BD,$01,$02,$8D,$C3,$37,$9E,$01,$02,$BD,$02,$02,$8D,$C4,$37
            dc.b    $9E,$02,$02,$5A,$DA,$AC,$4C,$54,$AD,$4E,$54,$A6,$7F,$20,$3F,$31
            dc.b    $90,$04,$A9,$FF,$80,$14,$EE,$98,$37,$D0,$0D,$EE,$99,$37,$D0,$08
            dc.b    $EE,$9A,$37,$D0,$03,$EE,$9B,$37,$A9,$00,$FA,$9D,$00,$02,$7A,$A9
            dc.b    $03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C,$B0,$2D,$FA,$5A,$9E,$00
            dc.b    $02,$A9,$37,$8D,$01,$02,$A9,$74,$8D,$02,$02,$7A,$A9,$03,$99,$00
            dc.b    $02,$A9,$04,$0C,$35,$F0,$4C,$B0,$2D,$A5,$5F,$05,$5E,$D0,$04,$A9
            dc.b    $03,$85,$5E,$A9,$01,$85,$5C,$85,$5D,$85,$5A,$3A,$3A,$85,$5B,$38
            dc.b    $20,$60,$37,$A5,$8A,$10,$17,$A0,$00,$B9,$B6,$30,$99,$84,$00,$C8
            dc.b    $C0,$06,$90,$F5,$AD,$32,$F0,$09,$10,$8D,$32,$F0,$80,$15,$AD,$30
            dc.b    $F0,$29,$E7,$8D,$30,$F0,$A0,$00,$B9,$B0,$30,$99,$84,$00,$C8,$C0
            dc.b    $06,$90,$F5,$AD,$41,$F0,$A5,$8A,$10,$16,$A2,$00,$BD,$99,$30,$A8
            dc.b    $C8,$F0,$23,$8D,$41,$F0,$E8,$BD,$99,$30,$8D,$41,$F0,$E8,$80,$EC
            dc.b    $A2,$00,$BD,$7C,$30,$A8,$C8,$F0,$0D,$8D,$41,$F0,$E8,$BD,$7C,$30
            dc.b    $8D,$41,$F0,$E8,$80,$EC,$60,$04,$20,$0A,$E0,$06,$00,$07,$7E,$0C
            dc.b    $06,$0D,$00,$0E,$C0,$03,$DD,$02,$00,$0F,$00,$01,$18,$0B,$70,$0E
            dc.b    $21,$05,$60,$FF,$04,$20,$0A,$E0,$06,$00,$07,$7E,$03,$DD,$02,$00
            dc.b    $0F,$00,$01,$18,$0B,$00,$0E,$60,$05,$60,$FF,$08,$04,$24,$1A,$07
            dc.b    $0E,$04,$02,$0A,$02,$00,$01,$A8,$29,$0F,$AA,$98,$4A,$4A,$4A,$4A
            dc.b    $A8,$18,$BD,$CE,$30,$79,$CE,$30,$60,$00,$01,$01,$02,$01,$02,$02
            dc.b    $03,$01,$02,$02,$03,$02,$03,$03,$04,$20,$E1,$30,$A2,$04,$A5,$5E
            dc.b    $6A,$6A,$45,$5E,$85,$7E,$A5,$5F,$6A,$6A,$6A,$6A,$45,$5F,$6A,$6A
            dc.b    $6A,$45,$7E,$6A,$26,$5E,$26,$5F,$CA,$D0,$E3,$A5,$5E,$60,$A0,$19
            dc.b    $A6,$56,$AD,$23,$F0,$C9,$5D,$D0,$0C,$AD,$24,$F0,$C9,$02,$D0,$05
            dc.b    $88,$D0,$EF,$18,$60,$38,$60,$A0,$27,$AD,$23,$F0,$C9,$05,$D0,$05
            dc.b    $88,$D0,$F6,$18,$60,$38,$60,$A9,$20,$A2,$10,$CA,$D0,$FD,$2C,$32
            dc.b    $F0,$D0,$05,$88,$D0,$F3,$18,$60,$38,$60,$85,$81,$84,$82,$86,$83
            dc.b    $8E,$4D,$54,$A9,$20,$85,$58,$85,$59,$A5,$5A,$20,$BC,$30,$C9,$03
            dc.b    $90,$0B,$A5,$5C,$2A,$29,$0F,$85,$5C,$64,$5A,$80,$0F,$A5,$5B,$20
            dc.b    $BC,$30,$C9,$02,$90,$06,$46,$5C,$A0,$FF,$84,$5B,$06,$5B,$06,$5A
            dc.b    $A5,$5C,$85,$5D,$20,$E1,$30,$A9,$20,$2C,$32,$F0,$F0,$1E,$38,$26
            dc.b    $5D,$A9,$01,$04,$5B,$A0,$0F,$A2,$F1,$A9,$20,$2C,$32,$F0,$F0,$0C
            dc.b    $CA,$F0,$04,$80,$00,$80,$F4,$88,$D0,$F1,$80,$D8,$78,$A4,$84,$20
            dc.b    $2C,$31,$B0,$0E,$A5,$5E,$25,$5D,$29,$0F,$F0,$27,$A8,$20,$2C,$31
            dc.b    $90,$21,$EE,$74,$37,$D0,$0D,$EE,$75,$37,$D0,$08,$EE,$76,$37,$D0
            dc.b    $03,$EE,$77,$37,$A9,$01,$04,$5B,$C6,$59,$F0,$04,$58,$4C,$79,$31
            dc.b    $58,$38,$60,$A5,$81,$10,$11,$0A,$AA,$7C,$E1,$31,$00,$00,$99,$32
            dc.b    $D7,$32,$00,$00,$C3,$32,$CD,$32,$A4,$83,$8C,$B9,$37,$A4,$82,$8C
            dc.b    $B8,$37,$C0,$FF,$F0,$49,$20,$29,$33,$20,$5D,$36,$E6,$8B,$A5,$85
            dc.b    $0A,$A8,$20,$2C,$31,$90,$5F,$20,$1C,$31,$90,$5A,$20,$23,$34,$B0
            dc.b    $55,$64,$8B,$A5,$60,$C9,$80,$D0,$4D,$A2,$06,$CA,$D0,$FD,$A0,$00
            dc.b    $B1,$7C,$8D,$21,$F0,$C8,$B1,$7C,$8D,$22,$F0,$C8,$B1,$7C,$8D,$24
            dc.b    $F0,$C8,$B1,$7C,$8D,$23,$F0,$20,$3B,$33,$20,$5D,$36,$58,$60,$20
            dc.b    $29,$33,$20,$5D,$36,$A0,$00,$B1,$7C,$8D,$21,$F0,$C8,$B1,$7C,$8D
            dc.b    $22,$F0,$C8,$B1,$7C,$8D,$24,$F0,$C8,$B1,$7C,$8D,$23,$F0,$20,$3B
            dc.b    $33,$20,$5D,$36,$58,$60,$EE,$78,$37,$D0,$0D,$EE,$79,$37,$D0,$08
            dc.b    $EE,$7A,$37,$D0,$03,$EE,$7B,$37,$A5,$01,$04,$5A,$38,$26,$5D,$C6
            dc.b    $58,$F0,$09,$20,$5D,$36,$64,$8B,$58,$4C,$79,$31,$20,$5D,$36,$64
            dc.b    $8B,$38,$58,$60,$A4,$82,$8C,$BE,$37,$8C,$BF,$37,$20,$E1,$32,$20
            dc.b    $5D,$36,$A5,$85,$0A,$A8,$20,$2C,$31,$90,$BB,$20,$03,$31,$90,$B6
            dc.b    $20,$23,$34,$B0,$B1,$A5,$60,$C9,$40,$D0,$AB,$18,$58,$60,$A4,$82
            dc.b    $A6,$83,$20,$29,$33,$4C,$5D,$36,$A4,$82,$A6,$83,$20,$0F,$33,$4C
            dc.b    $5D,$36,$A4,$82,$A6,$83,$20,$F5,$32,$4C,$5D,$36,$A9,$BE,$8D,$21
            dc.b    $F0,$A9,$37,$8D,$22,$F0,$9C,$24,$F0,$A9,$03,$8D,$23,$F0,$80,$46
            dc.b    $8C,$B5,$37,$8E,$B6,$37,$A9,$B5,$8D,$21,$F0,$A9,$37,$8D,$22,$F0
            dc.b    $9C,$24,$F0,$A9,$03,$8D,$23,$F0,$80,$2C,$8C,$BB,$37,$8E,$BC,$37
            dc.b    $A9,$BB,$8D,$21,$F0,$A9,$37,$8D,$22,$F0,$9C,$24,$F0,$A9,$03,$8D
            dc.b    $23,$F0,$80,$12,$A9,$B8,$8D,$21,$F0,$A9,$37,$8D,$22,$F0,$9C,$24
            dc.b    $F0,$A9,$03,$8D,$23,$F0,$A6,$8A,$10,$27,$AD,$30,$F0,$29,$E7,$09
            dc.b    $08,$8D,$30,$F0,$A0,$0A,$8C,$41,$F0,$A9,$E0,$8D,$41,$F0,$A0,$03
            dc.b    $8C,$41,$F0,$A9,$D0,$8D,$41,$F0,$A9,$31,$8D,$20,$F0,$A0,$05,$80
            dc.b    $27,$A0,$03,$8C,$41,$F0,$A9,$D0,$8D,$41,$F0,$A9,$31,$8D,$20,$F0
            dc.b    $A0,$05,$8C,$41,$F0,$A9,$63,$8D,$41,$F0,$EA,$8C,$41,$F0,$A9,$61
            dc.b    $8D,$41,$F0,$A2,$01,$CA,$D0,$FD,$8C,$41,$F0,$A9,$6B,$8D,$41,$F0
            dc.b    $A6,$89,$CA,$D0,$FD,$A9,$01,$8D,$41,$F0,$A9,$C0,$8D,$41,$F0,$A9
            dc.b    $80,$8D,$41,$F0,$A9,$C0,$8D,$41,$F0,$A0,$0F,$A2,$F1,$A9,$40,$2C
            dc.b    $41,$F0,$D0,$0D,$CA,$F0,$04,$80,$00,$80,$F4,$88,$D0,$F1,$4C,$05
            dc.b    $34,$A6,$87,$A9,$04,$2C,$41,$F0,$D0,$06,$CA,$D0,$F8,$4C,$05,$34
            dc.b    $A6,$88,$CA,$D0,$FD,$A0,$05,$8C,$41,$F0,$A9,$E3,$8D,$41,$F0,$A6
            dc.b    $86,$CA,$D0,$FD,$8C,$41,$F0,$A9,$E1,$8D,$41,$F0,$9C,$20,$F0,$A9
            dc.b    $10,$8D,$41,$F0,$A9,$0A,$8D,$34,$F0,$A9,$30,$8D,$41,$F0,$18,$60
            dc.b    $A9,$05,$8D,$41,$F0,$A9,$E1,$8D,$41,$F0,$9C,$20,$F0,$A9,$10,$8D
            dc.b    $41,$F0,$A9,$0A,$8D,$34,$F0,$A9,$30,$8D,$41,$F0,$38,$60,$A0,$30
            dc.b    $A2,$01,$8E,$41,$F0,$AD,$41,$F0,$30,$18,$88,$D0,$F5,$EE,$90,$37
            dc.b    $D0,$0D,$EE,$91,$37,$D0,$08,$EE,$92,$37,$D0,$03,$EE,$93,$37,$4C
            dc.b    $5D,$36,$9C,$20,$F0,$A9,$03,$8D,$41,$F0,$A9,$D0,$8D,$41,$F0,$64
            dc.b    $60,$A9,$01,$8D,$41,$F0,$AD,$41,$F0,$89,$60,$F0,$30,$89,$40,$F0
            dc.b    $12,$EE,$7C,$37,$D0,$0D,$EE,$7D,$37,$D0,$08,$EE,$7E,$37,$D0,$03
            dc.b    $EE,$7F,$37,$89,$20,$F0,$12,$EE,$80,$37,$D0,$0D,$EE,$81,$37,$D0
            dc.b    $08,$EE,$82,$37,$D0,$03,$EE,$83,$37,$38,$4C,$5D,$36,$A9,$10,$8D
            dc.b    $41,$F0,$A9,$0A,$8D,$34,$F0,$A9,$30,$8D,$41,$F0,$A5,$90,$10,$15
            dc.b    $29,$7F,$C9,$06,$B0,$0F,$0A,$AA,$7C,$AE,$34,$BD,$34,$CC,$34,$BA
            dc.b    $34,$F6,$34,$D4,$34,$4C,$5D,$36,$A2,$06,$CA,$D0,$FD,$A4,$7F,$A6
            dc.b    $7F,$20,$F5,$32,$4C,$5D,$36,$A9,$40,$85,$60,$18,$4C,$5D,$36,$A5
            dc.b    $8B,$F0,$08,$64,$8B,$A9,$80,$85,$60,$18,$60,$EE,$94,$37,$D0,$0D
            dc.b    $EE,$95,$37,$D0,$08,$EE,$96,$37,$D0,$03,$EE,$97,$37,$18,$4C,$5D
            dc.b    $36,$A6,$57,$D0,$51,$A5,$8E,$C9,$FF,$F0,$0C,$A2,$06,$CA,$D0,$FD
            dc.b    $A4,$8F,$A6,$7F,$20,$0F,$33,$20,$F6,$35,$A5,$85,$0A,$A8,$20,$2C
            dc.b    $31,$90,$1D,$20,$03,$31,$90,$18,$A0,$A2,$A2,$0B,$A9,$01,$8D,$41
            dc.b    $F0,$AD,$41,$F0,$30,$4C,$88,$F0,$04,$80,$00,$80,$EF,$CA,$D0,$EC
            dc.b    $EE,$90,$37,$D0,$0D,$EE,$91,$37,$D0,$08,$EE,$92,$37,$D0,$03,$EE
            dc.b    $93,$37,$38,$4C,$5D,$36,$EE,$9C,$37,$D0,$0D,$EE,$9D,$37,$D0,$08
            dc.b    $EE,$9E,$37,$D0,$03,$EE,$9F,$37,$A5,$8E,$C9,$FF,$F0,$04,$18,$4C
            dc.b    $5D,$36,$20,$5D,$36,$A4,$85,$C8,$20,$2C,$31,$20,$1C,$31,$18,$4C
            dc.b    $5D,$36,$29,$60,$D0,$4B,$A6,$56,$BD,$A1,$37,$85,$8C,$BD,$AB,$37
            dc.b    $85,$8D,$A0,$02,$B1,$8C,$30,$39,$38,$A9,$5D,$ED,$23,$F0,$95,$6A
            dc.b    $A9,$02,$ED,$24,$F0,$95,$73,$A9,$81,$95,$61,$E4,$55,$D0,$09,$DA
            dc.b    $A2,$05,$A9,$02,$20,$5A,$37,$FA,$E8,$E0,$09,$90,$02,$A2,$00,$E4
            dc.b    $55,$F0,$06,$86,$56,$18,$4C,$5D,$36,$A9,$FF,$85,$57,$18,$4C,$5D
            dc.b    $36,$89,$40,$F0,$12,$EE,$7C,$37,$D0,$0D,$EE,$7D,$37,$D0,$08,$EE
            dc.b    $7E,$37,$D0,$03,$EE,$7F,$37,$89,$20,$F0,$12,$EE,$80,$37,$D0,$0D
            dc.b    $EE,$81,$37,$D0,$08,$EE,$82,$37,$D0,$03,$EE,$83,$37,$38,$4C,$5D
            dc.b    $36,$A9,$03,$8D,$41,$F0,$A9,$C0,$8D,$41,$F0,$AD,$43,$F0,$AD,$43
            dc.b    $F0,$AD,$43,$F0,$A5,$8A,$10,$14,$AD,$30,$F0,$29,$E7,$09,$10,$8D
            dc.b    $30,$F0,$A9,$0A,$8D,$41,$F0,$A9,$80,$8D,$41,$F0,$A9,$30,$8D,$41
            dc.b    $F0,$A9,$03,$8D,$41,$F0,$A9,$DD,$8D,$41,$F0,$A9,$01,$8D,$41,$F0
            dc.b    $A9,$F8,$8D,$41,$F0,$A6,$56,$BD,$A1,$37,$8D,$21,$F0,$BD,$AB,$37
            dc.b    $8D,$22,$F0,$A9,$02,$8D,$24,$F0,$A9,$5D,$8D,$23,$F0,$A9,$35,$8D
            dc.b    $20,$F0,$A9,$0A,$8D,$34,$F0,$60,$A9,$03,$8D,$41,$F0,$A9,$C0,$8D
            dc.b    $41,$F0,$A9,$10,$8D,$41,$F0,$AD,$43,$F0,$AD,$43,$F0,$AD,$43,$F0
            dc.b    $A5,$8A,$10,$14,$AD,$30,$F0,$29,$E7,$09,$10,$8D,$30,$F0,$A9,$0A
            dc.b    $8D,$41,$F0,$A9,$80,$8D,$41,$F0,$A9,$30,$8D,$41,$F0,$A9,$03,$8D
            dc.b    $41,$F0,$A9,$DD,$8D,$41,$F0,$A9,$01,$8D,$41,$F0,$A9,$F8,$8D,$41
            dc.b    $F0,$A9,$8E,$8D,$21,$F0,$9C,$22,$F0,$9C,$24,$F0,$A9,$05,$8D,$23
            dc.b    $F0,$A9,$35,$8D,$20,$F0,$A9,$0A,$8D,$34,$F0,$60,$02,$0B,$4C,$6F
            dc.b    $63,$61,$6C,$54,$61,$6C,$6B,$2B,$2B,$2C,$56,$65,$72,$73,$69,$6F
            dc.b    $6E,$20,$35,$36,$2E,$30,$20,$A9,$20,$41,$70,$70,$6C,$65,$20,$43
            dc.b    $6F,$6D,$70,$75,$74,$65,$72,$20,$49,$6E,$63,$2E,$20,$31,$39,$38
            dc.b    $38,$2D,$31,$39,$39,$31,$38,$01,$80,$00,$00,$00,$08,$35,$36,$2E
            dc.b    $30,$2E,$31,$20,$20,$00,$39,$49,$4F,$50,$20,$4C,$6F,$63,$61,$6C
            dc.b    $54,$61,$6C,$6B,$20,$76,$35,$36,$2E,$30,$2E,$31,$20,$20,$3B,$20
            dc.b    $A9,$20,$41,$70,$70,$6C,$65,$20,$43,$6F,$6D,$70,$75,$74,$65,$72
            dc.b    $2C,$20,$49,$6E,$63,$2E,$20,$31,$39,$38,$38,$2D,$31,$39,$39,$31
            dc.b    $6C,$00,$00,$6C,$02,$00,$6C,$04,$00,$6C,$06,$00,$6C,$08,$00,$6C
            dc.b    $0A,$00,$6C,$0C,$00,$6C,$0E,$00,$6C,$10,$00,$6C,$12,$00,$6C,$14
            dc.b    $00,$6C,$16,$00,$6C,$18,$00,$00,$20,$40,$60,$80,$A0,$C0,$E0,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$08,$EF,$92,$35,$D8
            dc.b    $7B,$1E,$C1,$64,$07,$AA,$51,$4F,$4D,$4A,$48,$46,$43,$41,$3F,$3C
            dc.b    $00,$00,$82,$00,$00,$84,$00,$00,$85,$00,$00,$81,$4C,$54,$00,$00
RsrcEntryatlk_3:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'atlk' 3 "ATalk" (372 bytes) - Combo mask
            dc.l    RsrcEntryiopc_128-BaseOfROM     ; Next entry
            dc.l    Rsrcatlk_3-BaseOfROM            ; Data
            dc.b    'atlk'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    5,'ATalk'                       ; Name
            dc.b    'BGMSHJM'
            dc.l    $C0A00000,$00000180,$00000274   ; Block header
Rsrcatlk_3:
            bra.b   .L1
            dc.b    $60,$54,$00,$00,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3A
            dc.b    'LocalTalk atlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00
.L1:
            moveq   #-$5F,D0
            jmp     (A0)
            movem.l D0-D7/A1-A6,-(SP)
            cmpi.w  #8,D0
            bhi.w   .L7
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L7-.L2
            dc.w    .L3-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
.L3:
            tst.w   ROM85
            bmi.w   .L7
            move.l  #$72A,D0
            _NewPtrSysClear
            bne.w   .L7
            move.b  D4,($2E4,A0)
            movea.l ExpandMem,A2
            move.l  A0,($100,A2)
            movea.l A0,A2
            move.w  #$A89F,D0
            _GetTrapAddress
            movea.l A0,A1
            move.w  #$A1AD,D0
            _GetOSTrapAddress
            move.l  A1,D0
            cmp.l   A0,D0
            beq.b   .L4
            move.l  #$766D2020,D0
            _Gestalt
            bne.b   .L4
            move.l  A0,D0
            beq.b   .L4
            move.b  D0,($727,A2)
.L4:
            move.w  #$A086,D0
            _GetOSTrapAddress
            move.l  A0,D0
            _StripAddress
            move.l  D0,-(SP)
            move.w  #$A89F,D0
            _GetOSTrapAddress
            move.l  A0,D0
            _StripAddress
            cmp.l   (SP)+,D0
            beq.b   .L5
            move.b  ($BFE).w,D0
            btst    #0,D0
            bne.b   .L5
            move.w  #3,D0
            bsr.b   sub_408DAA22
            bra.b   .L6
.L5:
            move.w  #2,D0
            bsr.b   sub_408DAA22
.L6:
            move.l  A0,D0
            beq.b   .L7
            move.l  (A0),D0
            _StripAddress
            move.l  D0,-(SP)
            lea     Rsrcatlk_3,A0
            movea.l LAPMgrPtr,A1
            moveq   #3,D0
            jsr     (2,A1)
            movea.l (SP),A0
            moveq   #2,D0
            moveq   #$38,D1
            clr.w   D2
            jsr     (2,A1)
            movea.l (SP)+,A0
            movem.l (SP)+,D0-D7/A1-A6
            jmp     (2,A0)
.L7:
            movem.l (SP)+,D0-D7/A1-A6
            move.w  #$FFFF,D0
            rts
sub_408DAA22:
            move.w  D0,-(SP)
            move.w  CurMap,-(SP)
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'ltlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.w  (SP)+,CurMap
            move.l  A0,D0
            bne.b   .L1
            move.w  (SP)+,D0
            subq.w  #4,SP
            move.l  #'ltlk',-(SP)
            move.w  D0,-(SP)
            _Get1Resource
            movea.l (SP)+,A0
            rts
.L1:
            addq.w  #2,SP
            rts
RsrcEntryltlk_2:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'ltlk' 2 "LTLK" (2868 bytes) - Combo mask
            dc.l    RsrcEntryatlk_3-BaseOfROM       ; Next entry
            dc.l    Rsrcltlk_2-BaseOfROM            ; Data
            dc.b    'ltlk'                          ; Type
            dc.w    2                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'LTLK'                        ; Name
            dc.b    '9-1990]['
            dc.l    $C0A00000,$00000B40,$0000026C   ; Block header
Rsrcltlk_2:
            bra.b   .L1
            dc.b    $60,$54,$05,$EC,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3E
            dc.b    'SCC LocalTalk ltlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00,$0C,$40,$00,$08,$62,$1C,$E3,$48,$30,$3B,$00,$06,$4E,$FB,$00
            dc.b    $02,$00,$12,$00,$94,$00,$C8,$00,$12,$00,$12,$00,$12,$00,$12,$00
            dc.b    $AA,$00,$B6,$70,$FF,$4E,$75
.L1:
            movea.l ExpandMem,A3
            movea.l ($100,A3),A3
            movem.l D2/A0-A2,($2C4,A3)
            exg     A2,A3
            tst.b   D0
            beq.b   .L4
            tst.b   ($2BA,A2)
            bne.b   .L2
            move.l  A3,($2BC,A2)
            move.l  A1,($2E6,A2)
            bsr.w   sub_408DAC28
            st      ($2BA,A2)
.L2:
            st      ($5E2,A2)
            move.b  D2,(A2)
            movea.l SCCWr,A1
            addq.w  #2,A1
            move.b  #6,(A1)
            nop
            move.b  (A2),(A1)
            bsr.w   sub_408DAD6E
            tst.b   ($5E1,A2)
            beq.b   .L5
            clr.b   ($5E1,A2)
            moveq   #$C,D0
            movea.l LAPMgrPtr,A3
            move.b  ($2E4,A2),D4
            move.l  A2,-(SP)
            movea.l ($2BC,A2),A2
            jsr     (2,A3)
            tst.w   D0
            beq.b   .L3
            moveq   #5,D0
            jsr     (2,A3)
.L3:
            movea.l (SP)+,A2
            bra.b   .L5
.L4:
            st      ($5DF,A2)
            bsr.w   sub_408DAD66
.L5:
            movem.l ($2C4,A2),D2/A0-A2
            jmp     (A0)
            movem.l D1/D4,-(SP)
            lea     Rsrcltlk_2,A0
            _RecoverHandle
            move.l  A0,-(SP)
            _DetachResource
            movem.l (SP)+,D1/D4
            clr.w   D0
            rts
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            bsr.b   sub_408DABE0
            rts
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            move.l  A2,-(SP)
            bsr.b   sub_408DABF4
            movea.l (SP)+,A2
            bsr.b   sub_408DABFA
            rts
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            move.l  A2,-(SP)
            bsr.b   sub_408DABF4
            movea.l (SP),A2
            bsr.b   sub_408DABFA
            movea.l LAPMgrPtr,A1
            moveq   #3,D0
            jsr     (2,A1)
            movea.l (SP)+,A0
            _DisposPtr
            rts
sub_408DABE0:
            moveq   #-$61,D0
            tst.b   PortAUse
            bpl.b   .L1
            move.b  #1,PortAUse
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
sub_408DABF4:
            st      PortAUse
            rts
sub_408DABFA:
            tst.b   ($2BA,A2)
            beq.b   .L1
            lea     sub_408DB296.L24,A0
            bsr.w   sub_408DAD52
            lea     ($292,A2),A0
            _VRemove
            lea     ($618,A2),A0
            lea     ($1CA).w,A3
            move.l  (A0)+,(A3)+
            move.l  (A0)+,(A3)+
            move.l  (A0)+,($2C6).w
            clr.b   ($5DF,A2)
            clr.b   ($2BA,A2)
.L1:
            rts
sub_408DAC28:
            movem.l D0-D7/A0-A6,-(SP)
            suba.w  #$10,SP
            movea.l SP,A0
            moveq   #1,D0
            _SysEnvirons
            move.w  (2,A0),D0
            addq.w  #2,D0
            move.w  D0,($6E2,A2)
            adda.w  #$10,SP
            movea.l ROMBase,A3
            movea.l VIA,A1
            lea     ($1E00,A1),A1
            cmpi.b  #3,(8,A3)
            bne.b   .L1
            suba.w  #$1E00,A1
            bra.b   .L2
.L1:
            cmpi.w  #$D,($6E2,A2)
            bne.b   .L2
            movea.l SCCRd,A1
            lea     (-$1C,A1),A1
.L2:
            move.l  A1,($638,A2)
            lea     sub_408DB296.L21,A0
            move.l  (A0)+,($63C,A2)
            move.w  (A0)+,($640,A2)
            move.w  (A0)+,($1C,A2)
            cmpi.b  #$75,(9,A3)
            beq.b   .L3
            cmpi.b  #$76,(9,A3)
            beq.b   .L3
            move.w  #$2300,($1C,A2)
.L3:
            cmpi.b  #$75,(9,A3)
            bhi.b   .L4
            moveq   #$14,D0
            lea     sub_408DB296.L22,A0
            lea     ($5EC,A2),A1
            _BlockMove
            bra.b   .L9
.L4:
            bsr.w   sub_408DB3E2
            moveq   #0,D7
            move.w  D0,D7
            bsr.w   sub_408DB4C8
            moveq   #0,D6
            move.w  D0,D6
            moveq   #$14,D0
            lea     ($5EC,A2),A1
            movea.l ROMBase,A0
            moveq   #0,D1
            move.w  D7,D1
            divu.w  #$64,D1
            lea     sub_408DB296.L23,A3
.L5:
            move.w  (A3)+,D3
            moveq   #0,D2
            move.b  (A3)+,D2
            divu.w  D1,D2
            sub.w   D2,D3
            tst.b   (A3)+
            bmi.b   .L8
            mulu.w  D7,D3
.L6:
            divu.w  #$3E8,D3
            subq.w  #1,D3
            bpl.b   .L7
            moveq   #0,D3
.L7:
            move.w  D3,(A1)+
            subq.w  #2,D0
            bne.b   .L5
            bra.b   .L9
.L8:
            mulu.w  D6,D3
            bra.b   .L6
.L9:
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($1CA).w,A3
            lea     ($618,A2),A1
            lea     sub_408DB0B0,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408DB204.L3,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408DAF22,A0
            move.l  ($2C6).w,(A1)
            move.l  A0,($2C6).w
            lea     ($292,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408DAF6E,A1
            move.l  A1,(6,A0)
            move.w  #$14,($A,A0)
            _VInstall
            bsr.b   sub_408DAD48
            move    (SP)+,SR
            movem.l (SP)+,D0-D7/A0-A6
            rts
sub_408DAD48:
            lea     sub_408DB296.L19,A0
            bsr.b   sub_408DAD52
            lea     sub_408DB296.L20,A0
sub_408DAD52:
            movea.l SCCWr,A3
            addq.w  #2,A3
.L1:
            move.w  (A0)+,D0
            beq.b   .L2
            move.b  D0,(A3)
            ror.w   #8,D0
            move.b  D0,(A3)
            bra.b   .L1
.L2:
            rts
sub_408DAD66:
            clr.b   ($5E2,A2)
            move.l  A1,($5D4,A2)
sub_408DAD6E:
            movea.l ROMBase,A3
            cmpi.b  #3,(8,A3)
            bne.b   .L1
            movea.l PmgrBase,A3
            move.b  #$10,($E,A3)
            tst.w   ($FE0000).l
.L1:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            _IdleUpdate
.L2:
            move.l  (SP)+,($5D8,A2)
            move.b  D2,($5DE,A2)
            lea     ($5E5,A2),A3
            move.b  (A3)+,D3
            move.b  (A3),D2
            add.b   D2,(A3)+
            bsr.b   sub_408DADB8
            ble.b   sub_408DADB8.L3
            add.b   D3,D3
            addq.b  #1,D3
            andi.w  #$F,D3
            clr.b   (-1,A3)
            bra.b   sub_408DADB8.L4
sub_408DADB8:
            moveq   #0,D0
            moveq   #7,D1
.L1:
            btst    D1,D2
            beq.b   .L2
            addq.w  #1,D0
.L2:
            dbra    D1,.L1
            subq.b  #2,D0
            rts
.L3:
            move.b  (A3),D2
            bsr.b   sub_408DADB8
            bge.b   .L4
            lsr.b   #1,D3
            st      (A3)
.L4:
            move.b  (A3),D2
            add.b   D2,(A3)+
            moveq   #$20,D0
            move.b  D0,(A3)+
            move.b  D0,(A3)
            subq.w  #5,A3
            move.b  D3,(A3)+
            move.b  D3,(A3)+
            movem.l SCCRd,A0-A1
            addq.w  #2,A0
            addq.w  #2,A1
.L5:
            move    SR,-(SP)
.L6:
            move.w  D0,D3
            btst    #4,(A0)
            beq.b   .L10
            bsr.w   sub_408DAFD4
            and.b   ($5E4,A2),D0
            andi.w  #$F,D0
            move.w  D0,D3
            beq.b   .L8
.L7:
            bsr.b   sub_408DAE88
            beq.b   .L10
            subq.w  #1,D0
            bne.b   .L7
.L8:
            move    #$2600,SR
            moveq   #3,D0
            addq.w  #3,D3
.L9:
            move.b  #$E,(A1)
            nop
            move.b  #$41,(A1)
            bsr.b   sub_408DAE88
            dbeq    D0,.L9
.L10:
            beq.w   sub_408DAE88.L9
            move.b  #$A,(A1)
            move.b  ($5DE,A2),D2
            tst.b   (A0)
            bmi.w   sub_408DAE88.L9
            move.b  #5,(A1)
            moveq   #-$7C,D0
            move.b  #$62,(A1)
            tst.b   ($5E2,A2)
            beq.b   .L11
            moveq   #-$7F,D0
.L11:
            move.b  #5,(A1)
            nop
            move.b  ($63D,A2),(A1)
            move.w  ($5FE,A2),D1
.L12:
            dbra    D1,.L12
            bsr.w   sub_408DB068
            addq.b  #1,D2
            beq.b   sub_408DAE88.L4
            clr.b   ($5E0,A2)
            bsr.w   sub_408DAFB8
            tst.b   ($5E2,A2)
            beq.b   .L13
            tst.b   ($5E1,A2)
            beq.b   sub_408DAE88.L8
            bra.b   sub_408DAE88.L6
.L13:
            tst.b   ($5E0,A2)
            st      ($5E0,A2)
            beq.b   sub_408DAE88.L8
            bra.b   sub_408DAE88.L5
sub_408DAE88:
            move.w  ($5FA,A2),D1
            bra.b   .L2
.L1:
            dbra    D1,.L1
            bra.b   .L3
.L2:
            bra.b   .L1
.L3:
            btst    #4,(A0)
            rts
.L4:
            bsr.b   sub_408DAE88
            beq.b   .L8
            cmpi.w  #$72,($5FA,A2)
            bcs.b   .L5
            bsr.b   sub_408DAE88
            beq.b   .L8
.L5:
            bsr.w   sub_408DB01C
.L6:
            moveq   #0,D0
            addq.l  #1,($6F2,A2)
.L7:
            move    (SP)+,SR
            movea.l ($5D8,A2),A0
            jmp     (A0)
.L8:
            addq.l  #1,($70E,A2)
            move    (SP),SR
            bset    #0,($5E6,A2)
            move.b  ($5E4,A2),D0
            add.b   D0,D0
            addq.b  #1,D0
            move.b  D0,($5E4,A2)
            moveq   #-$5F,D0
            subq.b  #1,($5E9,A2)
            beq.b   .L7
            bra.w   sub_408DADB8.L6
.L9:
            sub.w   D0,D3
            subq.w  #4,D3
            blt.b   .L10
            addq.l  #1,($712,A2)
            moveq   #-$5F,D0
            subq.b  #1,($5E8,A2)
            beq.b   .L7
            bset    #0,($5E4,A2)
            bset    #0,($5E7,A2)
.L10:
            clr.b   ($726,A2)
            move    #$2600,SR
            move.b  #$F,(A1)
            moveq   #-$78,D0
            move.b  D0,(A1)
            move.b  #2,($5E3,A2)
            moveq   #0,D0
            movem.l ($2C4,A2),D2/A0-A2
.L11:
            move    (SP)+,SR
            rts
sub_408DAF22:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            tst.b   ($5E3,A2)
            bne.b   .L1
            btst    #3,D1
            beq.w   sub_408DAFB8.L3
            movea.l ($2CA).w,A3
            jmp     (A3)
.L1:
            move.b  #$F,(A1)
            moveq   #8,D0
            move.b  D0,(A1)
            clr.b   ($5E3,A2)
            move    ($1C,A2),SR
            tst.b   ($727,A2)
            beq.b   sub_408DAF5E.L1
            move.l  A2,D0
            lea     sub_408DAF5E,A0
            _DeferUserFn
            rts
sub_408DAF5E:
            movea.l A0,A2
            movem.l SCCRd,A0-A1
            addq.w  #2,A0
            addq.w  #2,A1
.L1:
            bra.w   sub_408DADB8.L5
sub_408DAF6E:
            bsr.w   sub_408DB3D2
            move    SR,-(SP)
            move    #$2600,SR
            tst.b   ($5E3,A2)
            beq.b   sub_408DAE88.L11
            subq.b  #1,($5E3,A2)
            bne.b   sub_408DAE88.L11
            addq.w  #2,SP
            movem.l SCCRd,A0-A1
            addq.w  #2,A0
            addq.w  #2,A1
            bsr.w   sub_408DB25A
            addq.l  #1,($716,A2)
            move.b  #$F,(A1)
            moveq   #8,D0
            move.b  D0,(A1)
            move    ($1C,A2),SR
            bra.w   sub_408DADB8.L5
            move.w  #$3FC,($A,A0)
            lea     (-$6AE,A0),A2
            clr.w   ($6AC,A2)
            rts
sub_408DAFB8:
            movem.l A0-A2,-(SP)
            move.w  ($5F4,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L2
            bsr.w   sub_408DB0BC
.L2:
            movem.l (SP)+,A0-A2
.L3:
            rts
sub_408DAFD4:
            move.w  ($5DC,A2),D0
            mulu.w  #$305,D0
            addq.w  #1,D0
            move.w  D0,-(SP)
            lsl.w   #8,D0
            move.b  (SP)+,D0
            move.w  D0,($5DC,A2)
            rts
.L1:
            dc.w    $056B,$03D0
sub_408DAFEE:
            move.w  ($5F0,A2),D1
.L1:
            btst    #2,(A0)
            dbne    D1,.L1
            beq.b   .L2
            move.b  D3,(4,A1)
.L2:
            tst.w   D1
            rts
sub_408DB004:
            lea     sub_408DAFD4.L1,A3
            moveq   #4,D3
            bsr.w   sub_408DB0A8
            move.w  ($5F6,A2),D3
.L1:
            dbra    D3,.L1
            move.b  #$80,(A1)
            rts
sub_408DB01C:
            movem.l A0-A1/A4-A6,($624,A2)
            movea.l ($5D4,A2),A4
            bsr.b   sub_408DB004
            move.w  (A4)+,D3
            movea.l (A4)+,A3
            move.b  (A3)+,(4,A1)
            subq.w  #1,D3
            move.b  (A2),(A3)
.L1:
            move.w  ($5F0,A2),D0
.L2:
            btst    #2,(A0)
            dbne    D0,.L2
            bne.b   .L3
            bsr.b   sub_408DB0A2
            bra.b   .L5
.L3:
            move.b  (A3)+,(4,A1)
            subq.w  #1,D3
            bgt.b   .L1
            move.w  (A4)+,D3
            beq.b   .L4
            movea.l (A4)+,A3
            bra.b   .L1
.L4:
            bsr.b   sub_408DB07E
.L5:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            movem.l ($624,A2),A0-A1/A4-A6
            rts
sub_408DB068:
            bsr.b   sub_408DB004
            move.b  D2,(4,A1)
            move.b  (A2),D3
            bsr.w   sub_408DAFEE
            bmi.b   sub_408DB0A2
            move.b  D0,D3
            bsr.w   sub_408DAFEE
            bmi.b   sub_408DB0A2
sub_408DB07E:
            move.b  #$C0,(A1)
            lsl.w   #1,D3
.L1:
            btst    #6,(A0)
            beq.b   .L1
.L2:
            btst    #2,(A0)
            beq.b   .L2
            move.b  #5,(A1)
            moveq   #0,D3
            move.b  #$62,(A1)
            move.w  ($5EC,A2),D3
.L3:
            dbra    D3,.L3
sub_408DB0A2:
            lea     ($63C,A2),A3
            moveq   #6,D3
sub_408DB0A8:
            move.b  (A3)+,(A1)
            subq.w  #1,D3
            bne.b   sub_408DB0A8
            rts
sub_408DB0B0:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            addq.l  #1,($6EA,A2)
sub_408DB0BC:
            move.b  (4,A0),D0
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            movea.l ($2BC,A2),A3
            lea     (1,A3),A3
            move.b  D0,(A3)+
            move.b  D0,(1,A2)
            move.w  ($5EE,A2),D1
            add.w   D1,D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L5
            move.b  (4,A0),(A3)+
            move.b  (-1,A3),(2,A2)
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   .L5
            move.b  (4,A0),D0
            move.b  D0,(A3)+
            bmi.w   .L7
            move.b  D0,D2
            move.w  ($5EE,A2),D0
            add.w   D0,D0
.L3:
            btst    #0,(A0)
            dbne    D0,.L3
            beq.b   .L5
            move.b  (4,A0),(A3)
            moveq   #3,D1
            and.b   (A3)+,D1
            lsl.w   #8,D1
            movem.l A4-A5,($2FE,A2)
.L4:
            btst    #0,(A0)
            dbne    D0,.L4
.L5:
            beq.w   sub_408DB204.L2
            move.b  (4,A0),D1
            move.b  D1,(A3)+
            subq.w  #2,D1
            move.l  ($2E6,A2),D0
            beq.b   .L6
            movea.l D0,A5
            move.b  (A5),D0
            bmi.b   .L6
            andi.b  #$F,D0
            subq.b  #1,D0
            bne.b   .L6
            movea.l ($2BC,A2),A2
            movea.l LAPMgrPtr,A5
            lea     sub_408DB296.L6,A4
            moveq   #1,D0
            jsr     (2,A5)
.L6:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            movem.l ($2FE,A2),A4-A5
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            bne.w   sub_408DB296.L1
            addq.l  #1,($702,A2)
            clr.w   D3
            bra.w   sub_408DB296.L7
.L7:
            moveq   #$7F,D2
            and.b   D0,D2
            cmpi.b  #5,D2
            bgt.w   sub_408DB204.L1
            bsr.w   sub_408DB220
            bne.b   .L8
            move.b  (A2),D0
            cmpi.b  #$FF,(1,A2)
            seq     D1
            beq.b   .L9
            tst.b   ($5DF,A2)
            bne.b   .L9
            cmp.b   (1,A2),D0
            bne.b   .L8
            st      ($5E1,A2)
.L8:
            rts
.L9:
            cmp.b   (1,A2),D0
            bne.b   .L11
            subq.b  #1,D2
            beq.b   .L16
            subq.b  #3,D2
            beq.b   .L12
            tst.b   ($5E0,A2)
            beq.b   .L10
            addq.l  #1,($722,A2)
.L10:
            subq.b  #1,D2
            seq     ($5E0,A2)
.L11:
            rts
.L12:
            tst.b   D1
            bne.b   .L14
            move.w  ($5F8,A2),D0
.L13:
            dbra    D0,.L13
            moveq   #-$7B,D0
            bsr.b   sub_408DB204
.L14:
            move.w  ($5F2,A2),D1
.L15:
            btst    #0,(A0)
            dbne    D1,.L15
            bne.w   sub_408DB0BC
            addq.l  #1,($71E,A2)
            rts
.L16:
            move.w  ($5F8,A2),D0
.L17:
            dbra    D0,.L17
            moveq   #-$7E,D0
sub_408DB204:
            move.b  (2,A2),D2
            bra.w   sub_408DB068
            addq.l  #1,($702,A2)
            bra.b   .L3
.L1:
            addq.l  #1,($70A,A2)
            bra.b   .L3
.L2:
            addq.l  #1,($6FE,A2)
.L3:
            bsr.b   sub_408DB25A
            bra.b   sub_408DB25A
sub_408DB220:
            clr.w   D0
            move.w  ($5EE,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.w   sub_408DB296.L3
            bsr.b   sub_408DB296
            bmi.b   sub_408DB296.L2
            tst.b   (4,A0)
            move.w  ($5EE,A2),D1
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   sub_408DB296.L3
            bsr.b   sub_408DB296
            bpl.b   sub_408DB296.L2
            lsl.b   #1,D1
            bmi.b   sub_408DB296.L4
            move.w  ($5FC,A2),D1
.L3:
            dbra    D1,.L3
            bra.b   sub_408DB25A.L3
sub_408DB25A:
            bsr.b   sub_408DB296
            btst    #5,D1
            beq.b   .L1
            bclr    #7,($15F).w
.L1:
            moveq   #-$30,D1
            bsr.b   sub_408DB28C
            moveq   #2,D1
.L2:
            tst.b   (4,A0)
            move.b  #$30,(A1)
            dbra    D1,.L2
            moveq   #-$23,D1
            bsr.b   sub_408DB28C
.L3:
            move.b  #$30,(A1)
            move.w  (SP),(SP)
            move.b  #$20,(A1)
            tst.w   D0
            rts
sub_408DB28C:
            move.b  #3,(A1)
            nop
            move.b  D1,(A1)
            rts
sub_408DB296:
            move.b  #1,(A1)
            nop
            move.b  (A0),D1
            rts
.L1:
            move.b  D0,D1
            moveq   #0,D0
.L2:
            btst    #5,D1
            bne.b   .L5
            addq.l  #1,($706,A2)
            moveq   #-4,D0
            bra.b   sub_408DB25A
.L3:
            addq.l  #1,($6FE,A2)
            moveq   #-3,D0
            bra.b   sub_408DB25A
.L4:
            addq.l  #1,($6F6,A2)
            moveq   #-2,D0
            bra.b   sub_408DB25A
.L5:
            addq.l  #1,($6FA,A2)
            moveq   #-1,D0
            bra.b   sub_408DB25A
.L26:
            bra.w   .L25
.L6:
            bra.b   .L26
.L7:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            movea.l ($638,A2),A5
            movea.l SP,A4
.L8:
            move.w  ($5EE,A2),D0
            subq.w  #1,D1
            bmi.b   .L10
.L9:
            btst    #0,(A0)
            dbne    D0,.L9
            beq.b   .L10
            move.b  (4,A0),D0
            subq.w  #1,D3
            bmi.b   .L8
            move.b  D0,(A3)+
            bra.b   .L8
.L10:
            bsr.w   sub_408DB220
.L11:
            movem.l ($2FE,A2),A4-A5
            tst.w   D0
            bne.b   .L12
            addq.l  #1,($6EE,A2)
.L12:
            tst.w   D0
.L13:
            movea.l ($2BC,A2),A2
            rts
.L25:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            sub.w   D3,D1
.L14:
            move.w  ($5EE,A2),D0
.L15:
            btst    #0,(A0)
            dbne    D0,.L15
            beq.b   .L16
            move.b  (4,A0),(A3)+
            subq.w  #1,D3
            bne.b   .L14
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            beq.b   .L13
            bmi.b   .L17
            addq.l  #1,($6FA,A2)
            moveq   #-1,D0
            bra.b   .L18
.L16:
            addq.l  #1,($6FE,A2)
            moveq   #-3,D0
            bra.b   .L18
.L17:
            addq.l  #1,($706,A2)
            moveq   #-4,D0
.L18:
            bsr.w   sub_408DB25A
            bra.b   .L11
.L19:
            dc.w    $8009,$2004,$E00A,$0006,$7E07,$060C,$000D,$C00E
            dc.w    $DD03,$0002,$080F,$0901,$0A09,0
.L20:
            dc.w    $700B,$210E,$6005,0
.L21:
            dc.w    $0560,$0E41,$03DD,$2100
.L22:
            dc.w    $0035,$0014,$001E,$0082,$0066,$0010,0,$0039
            ds.b    4
.L23:
            dc.w    $006E,$3A00,$0064,$00FF,$00C8,$00FF,$01F4,$00FF
            dc.w    $0190,$72FF,$0046,$2C00,$001E,0,$0064,$5A00
            dc.w    $003C,$FF00,$000A,$4000
.L24:
            dc.w    $8A09,$000A,$1000,$080F,$0101,0
sub_408DB3D2:
            move.w  #$14,($A,A0)
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            rts
sub_408DB3E2:
            movem.l D1-D7/A1,-(SP)
            lea     sub_408DB3E2,A1
            movea.l ROMBase,A0
            cmpi.b  #$75,(9,A0)
            bcs.b   .L2
            move.l  A0,D0
            _StripAddress
            cmpa.l  D0,A1
            bcs.b   .L1
            movea.l D0,A0
            add.l   ($40,A0),D0
            cmpa.l  D0,A1
            bcs.b   .L2
.L1:
            suba.w  #$E,SP
            movea.l SP,A0
            clr.l   ($A,A0)
            move.w  #$FFFF,(4,A0)
            _InsTime
            move.b  (4,A0),D0
            bpl.b   .L3
            _RmvTime
            adda.w  #$E,SP
.L2:
            move.w  TimeDBRA,D0
            movem.l (SP)+,D1-D7/A1
            rts
.L3:
            _RmvTime
            adda.w  #$E,SP
            movem.l D4-D7,-(SP)
            moveq   #6,D0
.L4:
            clr.w   -(SP)
            dbra    D0,.L4
            moveq   #9,D4
            move.l  #$FFFF,D5
.L5:
            move.l  #$3938700,D7
            movea.l SP,A0
            move    SR,-(SP)
            move    #$2700,SR
            _InsTime
            move.l  D7,D6
            move.l  D7,D0
            neg.l   D0
            _PrimeTime
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D7
            movea.l SP,A0
            _InsTime
            move    SR,-(SP)
            move    #$2700,SR
            move.l  D6,D0
            neg.l   D0
            _PrimeTime
            move.w  TimeDBRA,D0
.L6:
            dbra    D0,.L6
            move.w  TimeDBRA,D0
.L7:
            dbra    D0,.L7
            move.w  TimeDBRA,D0
.L8:
            dbra    D0,.L8
            move.w  TimeDBRA,D0
.L9:
            dbra    D0,.L9
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D6
            sub.l   D7,D6
            cmp.l   D6,D5
            bcs.b   .L10
            move.l  D6,D5
.L10:
            dbra    D4,.L5
            move.w  TimeDBRA,D1
            mulu.w  #$FA0,D1
            divu.w  D5,D1
            move.w  D1,D0
            movem.l (SP)+,D4-D7
            adda.w  #$E,SP
            movem.l (SP)+,D1-D7/A1
            rts
sub_408DB4C8:
            movem.l D1-D7/A1,-(SP)
            lea     sub_408DB4C8,A1
            movea.l ROMBase,A0
            cmpi.b  #$75,(9,A0)
            bcs.b   .L2
            move.l  A0,D0
            _StripAddress
            cmpa.l  D0,A1
            bcs.b   .L1
            movea.l D0,A0
            add.l   ($40,A0),D0
            cmpa.l  D0,A1
            bcs.b   .L2
.L1:
            suba.w  #$E,SP
            movea.l SP,A0
            clr.l   ($A,A0)
            move.w  #$FFFF,(4,A0)
            _InsTime
            move.b  (4,A0),D0
            bpl.b   .L3
            _RmvTime
            adda.w  #$E,SP
.L2:
            move.w  TimeSCCDB,D0
            movem.l (SP)+,D1-D7/A1
            rts
.L3:
            _RmvTime
            adda.w  #$E,SP
            movem.l D4-D7,-(SP)
            moveq   #6,D0
.L4:
            clr.w   -(SP)
            dbra    D0,.L4
            moveq   #9,D4
            move.l  #$FFFF,D5
.L5:
            move.l  #$3938700,D7
            movea.l SP,A0
            move    SR,-(SP)
            move    #$2700,SR
            _InsTime
            move.l  D7,D6
            move.l  D7,D0
            neg.l   D0
            _PrimeTime
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D7
            movea.l SP,A0
            _InsTime
            move    SR,-(SP)
            move    #$2700,SR
            move.l  D6,D0
            neg.l   D0
            _PrimeTime
            move.w  TimeSCCDB,D0
            movea.l SCCRd,A1
.L6:
            btst    #0,(A1)
            dbra    D0,.L6
            move.w  TimeSCCDB,D0
.L7:
            btst    #0,(A1)
            dbra    D0,.L7
            move.w  TimeSCCDB,D0
.L8:
            btst    #0,(A1)
            dbra    D0,.L8
            move.w  TimeSCCDB,D0
.L9:
            btst    #0,(A1)
            dbra    D0,.L9
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D6
            sub.l   D7,D6
            cmp.l   D6,D5
            bcs.b   .L10
            move.l  D6,D5
.L10:
            dbra    D4,.L5
            move.w  TimeSCCDB,D1
            mulu.w  #$FA0,D1
            divu.w  D5,D1
            move.w  D1,D0
            movem.l (SP)+,D4-D7
            adda.w  #$E,SP
            movem.l (SP)+,D1-D7/A1
            rts
            dc.b    'CHDAFDJWGMRSWC'
RsrcEntryltlk_3:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'ltlk' 3 "LTLK" (1716 bytes) - Combo mask
            dc.l    RsrcEntryltlk_2-BaseOfROM       ; Next entry
            dc.l    Rsrcltlk_3-BaseOfROM            ; Data
            dc.b    'ltlk'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'LTLK'                        ; Name
            dc.b    'GSG DEVA'
            dc.l    $C0A00000,$000006C0,$00000264   ; Block header
Rsrcltlk_3:
            bra.b   .L1
            dc.b    $60,$00,$01,$1A,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3E
            dc.b    'IOP LocalTalk ltlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00
.L1:
            movea.l ExpandMem,A3
            movea.l ($100,A3),A3
            tst.b   D0
            bne.b   sub_408DB6B2.L2
            movem.l D2/A0-A2,($2EE,A3)
            move.w  ($308,A3),($58C,A3)
            moveq   #0,D1
.L2:
            move.w  (A1)+,D2
            beq.b   .L3
            add.w   D2,D1
            move.w  D2,($586,A3)
            move.l  (A1)+,($588,A3)
            lea     ($584,A3),A0
            _IOPMoveData
            add.w   D2,($58C,A3)
            bra.b   .L2
.L3:
            move.b  #3,($590,A3)
            move.w  D1,($591,A3)
            move.w  #$310,($575,A3)
            lea     sub_408DB6B2,A0
            move.l  A0,($580,A3)
            lea     ($56C,A3),A0
            _IOPMsgRequest
            movem.l ($2EE,A3),D2/A0-A2
            rts
sub_408DB6B2:
            movea.l ExpandMem,A3
            movea.l ($100,A3),A3
            tst.b   ($590,A3)
            bne.b   .L1
            moveq   #0,D0
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
.L1:
            moveq   #-1,D0
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
.L2:
            movem.l D2/A0-A2,($2EE,A3)
            move.b  #2,($590,A3)
            move.b  D2,($591,A3)
            move.w  #$210,($575,A3)
            clr.l   ($580,A3)
            lea     ($56C,A3),A0
            _IOPMsgRequest
.L3:
            tst.b   ($577,A3)
            bne.b   .L3
            tst.b   ($590,A3)
            bne.b   .L4
            movem.l ($2EE,A3),D2/A0-A2
            move.l  A2,($2EA,A3)
            jmp     (A0)
.L4:
            moveq   #5,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
            cmpi.w  #8,D0
            bhi.b   .L6
            lsl.w   #1,D0
            move.w  .L5(PC,D0.w),D0
            jmp     .L5(PC,D0.w)
.L5:
            dc.w    .L6-.L5
            dc.w    .L7-.L5
            dc.w    sub_408DB884.L3-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L8-.L5
            dc.w    sub_408DB884.L2-.L5
.L6:
            moveq   #-1,D0
            rts
.L7:
            movem.l D1/D4,-(SP)
            lea     Rsrcltlk_3,A0
            _RecoverHandle
            move.l  A0,-(SP)
            _DetachResource
            movem.l (SP)+,D1/D4
            clr.w   D0
            rts
.L8:
            movem.l D1-D3/A0-A3,-(SP)
            bsr.w   sub_408DBA3E
            bne.w   .L17
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            move.w  #$100,($584,A2)
            clr.w   ($5B8,A2)
            move.l  #$103,($572,A2)
            move.l  #$1000100,($590,A2)
            move.b  #$10,($576,A2)
            lea     ($590,A2),A0
            move.l  A0,($57C,A2)
            move.l  A0,($578,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L9:
            tst.b   ($577,A2)
            bne.b   .L9
            tst.b   ($590,A2)
            bne.w   .L16
            move.w  #$80,D0
            bsr.w   sub_408DB884
            tst.l   A0
            beq.w   .L14
            move.w  D1,($586,A2)
            move.l  (A0),($588,A2)
            move.w  #$2D55,($58C,A2)
            lea     ($584,A2),A0
            _IOPMoveData
            move.w  #$300,($590,A2)
            move.w  #$210,($575,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L10:
            tst.b   ($577,A2)
            bne.b   .L10
            tst.b   ($590,A2)
            bne.b   .L14
            move.b  #2,($574,A2)
            move.w  #$210,($575,A2)
            move.b  ($BFE).w,D0
            btst    #2,D0
            beq.b   .L11
            move.w  #$180,($590,A2)
            bra.b   .L12
.L11:
            move.w  #$100,($590,A2)
.L12:
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L13:
            tst.b   ($577,A2)
            bne.b   .L13
            tst.b   ($590,A2)
            bne.b   .L14
            move.w  ($591,A2),($308,A2)
            move.l  #$20210,($5A6,A2)
            move.b  #4,($5AA,A2)
            lea     ($5C4,A2),A0
            move.l  A0,($5AC,A2)
            move.l  A0,($5B0,A2)
            lea     sub_408DB8F8,A0
            move.l  A0,($5B4,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            movem.l (SP)+,D1-D3/A0-A3
            clr.w   D0
            rts
.L14:
            move.l  #$1021000,($574,A2)
            move.w  #$200,($590,A2)
            clr.l   ($580,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L15:
            tst.b   ($577,A2)
            bne.b   .L15
.L16:
            bsr.w   sub_408DBA38
.L17:
            movem.l (SP)+,D1-D3/A0-A3
            moveq   #-1,D0
            rts
sub_408DB884:
            subq.w  #4,SP
            move.l  #'iopc',-(SP)
            move.w  D0,-(SP)
            bsr.w   sub_408DBA52
            movea.l (SP),A0
            move.l  A0,D0
            beq.b   .L1
            _GetHandleSize
            move.l  D0,D1
.L1:
            movea.l (SP)+,A0
            rts
.L2:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            bsr.b   sub_408DB8C8
            rts
.L3:
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            bsr.b   sub_408DB8C8
            moveq   #3,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movea.l A2,A0
            _DisposPtr
            moveq   #0,D0
            rts
sub_408DB8C8:
            bsr.w   sub_408DBA38
            move.b  #3,($5A7,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            move.l  #$1021000,($574,A2)
            move.w  #$200,($590,A2)
            clr.l   ($580,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L1:
            tst.b   ($577,A2)
            bne.b   .L1
            rts
sub_408DB8F8:
            movea.l ExpandMem,A3
            movea.l ($100,A3),A3
            move    SR,($2C0,A3)
            move    #$2600,SR
            movem.l A4-A5,($2FE,A3)
            move.w  ($5C7,A3),D0
            subq.w  #2,D0
            move.w  D0,($5BA,A3)
            lea     ($30E,A3),A0
            move.l  A0,($5BC,A3)
            move.w  ($5C5,A3),($5C0,A3)
            lea     ($5B8,A3),A0
            _IOPMoveData
            movea.l ($2EA,A3),A2
            lea     (1,A2),A0
            lea     ($30E,A3),A1
            move.l  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.l  A1,($30A,A3)
            move.w  ($5C7,A3),D1
            subq.w  #5,D1
            move.w  (4,A2),D2
            andi.w  #$3FF,D2
            cmp.w   D2,D1
            beq.b   .L1
            addq.l  #1,($706,A3)
            bra.b   .L2
.L1:
            subq.w  #2,D1
            move.w  D1,($306,A3)
            movea.l A0,A3
            lea     .L3,A4
            move.b  (3,A2),D2
            moveq   #1,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movea.l ExpandMem,A3
            movea.l ($100,A3),A3
            addq.l  #1,($702,A3)
.L2:
            move    ($2C0,A3),SR
            move.b  #1,($5A7,A3)
            clr.b   ($5C4,A2)
            lea     ($5A0,A3),A0
            _IOPMsgRequest
            movem.l ($2FE,A3),A4-A5
            rts
.L3:
            bra.b   .L10
            bra.b   .L11
.L10:
            movem.l A0-A1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($100,A0),A0
            cmp.w   ($306,A0),D3
            bgt.b   .L6
            sub.w   D3,($306,A0)
            movea.l ($30A,A0),A1
            bra.b   .L5
.L4:
            move.b  (A1)+,(A3)+
.L5:
            dbra    D3,.L4
            move.l  A1,($30A,A0)
            move.w  ($306,A0),D1
            moveq   #0,D0
            moveq   #0,D3
            movem.l (SP)+,A0-A1
            rts
.L6:
            move    ($2C0,A0),SR
            movem.l ($2FE,A0),A4-A5
            movem.l (SP)+,A0-A1
            move.b  #$FF,D0
            rts
.L11:
            movem.l A0-A2,-(SP)
            movea.l ExpandMem,A2
            movea.l ($100,A2),A2
            tst.w   D3
            beq.b   .L9
            tst.w   ($306,A2)
            beq.b   .L9
            movea.l ($30A,A2),A1
            move.w  ($306,A2),D0
            cmp.w   D0,D3
            bge.b   .L8
            move.w  D3,D0
            bra.b   .L8
.L7:
            move.b  (A1)+,(A3)+
.L8:
            dbra    D0,.L7
.L9:
            move    ($2C0,A2),SR
            move.b  #1,($5A7,A2)
            clr.b   ($5C4,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            sub.w   ($306,A2),D3
            movem.l ($2FE,A2),A4-A5
            movem.l (SP)+,A0-A2
            moveq   #0,D0
            rts
sub_408DBA38:
            st      PortAUse
            rts
sub_408DBA3E:
            moveq   #-$61,D0
            tst.b   PortAUse
            bpl.b   .L1
            move.b  #1,PortAUse
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
sub_408DBA52:
            link.w  A6,#-2
            movem.l D1-D4/A1-A3,-(SP)
            move.w  CurMap,(-2,A6)
            moveq   #0,D3
            moveq   #0,D4
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _Get1Resource
            movea.l (SP)+,A2
            tst.w   ResErr
            beq.b   .L1
            suba.l  A2,A2
.L1:
            move.w  SysMap,CurMap
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _Get1Resource
            movea.l (SP)+,A3
            tst.w   ResErr
            beq.b   .L2
            suba.l  A3,A3
.L2:
            subq.w  #4,SP
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            move.l  ($A,A6),-(SP)
            bsr.w   sub_408DBB06
            movea.l (SP)+,A2
            move.l  D0,D3
            move.w  (-2,A6),CurMap
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            tst.w   ResErr
            beq.b   .L3
            suba.l  A3,A3
.L3:
            subq.w  #4,SP
            movem.l A2-A3,-(SP)
            move.l  ($A,A6),-(SP)
            bsr.w   sub_408DBB06
            movea.l (SP)+,A2
            move.l  D0,D3
            clr.w   ResErr
            move.l  A2,($E,A6)
            bne.b   .L4
            move.w  #$FF40,ResErr
.L4:
            movea.l A2,A0
            move.l  D3,D0
            movem.l (SP)+,D1-D4/A1-A3
            move.l  (4,A6),($A,A6)
            unlk    A6
            addq.w  #6,SP
            rts
sub_408DBB06:
            link.w  A6,#0
            movem.l D1-D4/A1-A3,-(SP)
            movea.l ($10,A6),A2
            movea.l ($C,A6),A3
            subq.w  #4,SP
            move.l  A2,-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   sub_408DBB7E
            move.l  (SP)+,D3
            cmpi.w  #$8000,D3
            bne.b   .L1
            move.b  #$FF,D3
.L1:
            subq.w  #4,SP
            move.l  A3,-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   sub_408DBB7E
            move.l  (SP)+,D4
            cmpi.w  #$8000,D4
            bne.b   .L2
            move.b  #$FF,D4
.L2:
            cmp.l   D3,D4
            bcs.b   .L3
            exg     A2,A3
            exg     D3,D4
.L3:
            cmpa.l  A2,A3
            beq.b   .L4
            cmpa.w  #0,A3
            beq.b   .L4
            move.l  A3,-(SP)
            _ReleaseResource
.L4:
            move.l  A2,($14,A6)
            movea.l A2,A0
            cmpi.w  #$80FF,D3
            bne.b   .L5
            clr.b   D3
.L5:
            move.l  D3,D0
            movem.l (SP)+,D1-D4/A1-A3
            move.l  (4,A6),($10,A6)
            unlk    A6
            lea     ($C,SP),SP
            rts
sub_408DBB7E:
            link.w  A6,#0
            movem.l D1-D5/A1-A2,-(SP)
            tst.l   ($C,A6)
            beq.w   .L4
            movea.l ($C,A6),A0
            move.l  (A0),D5
            beq.w   .L4
            movea.l ($C,A6),A0
            _GetHandleSize
            move.l  D0,D2
            bmi.b   .L4
            movea.l D5,A2
            cmpi.l  #'DRVR',(8,A6)
            beq.b   .L1
            cmpi.l  #8,D2
            bls.b   .L4
            move.w  (6,A2),D4
            adda.w  D4,A2
            addi.l  #$B,D4
            cmp.l   D4,D2
            bls.b   .L4
            move.l  (A2),D3
            clr.w   -(SP)
            move.l  A2,-(SP)
            bsr.w   sub_408DBC2E
            tst.w   (SP)+
            bne.b   .L5
            bra.b   .L4
.L1:
            move.w  #$12,D4
            cmp.l   D4,D2
            bls.b   .L4
            moveq   #0,D0
            move.b  (0,A2,D4.w),D0
            addq.w  #1,D0
            btst    #0,D0
            beq.b   .L2
            addq.w  #1,D0
            add.w   D0,D4
.L2:
            adda.w  D4,A2
            addi.l  #$B,D4
            cmp.l   D4,D2
            bls.b   .L4
            move.l  (A2),D3
            clr.w   -(SP)
            move.l  A2,-(SP)
            bsr.w   sub_408DBC2E
            tst.w   (SP)+
            bne.b   .L3
            move.w  (A2),D3
            clr.b   D3
            swap    D3
            move.w  #$8000,D3
.L3:
            bra.b   .L5
.L4:
            moveq   #0,D3
.L5:
            move.l  D3,($10,A6)
            move.l  D3,D0
            movem.l (SP)+,D1-D5/A1-A2
            move.l  (4,A6),($C,A6)
            unlk    A6
            addq.w  #8,SP
            rts
sub_408DBC2E:
            link.w  A6,#-$10
            movem.l D1-D4/A1-A2,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            movea.l (8,A6),A2
            move.l  (A2),D3
            lea     (-$10,A6),A0
            move.l  D3,D0
            swap    D0
            lsr.w   #8,D0
            andi.l  #$FF,D0
            clr.w   -(SP)
            _DECSTR68K
            moveq   #0,D0
            move.b  (A0)+,D0
            adda.w  D0,A0
            move.l  D3,D0
            swap    D0
            lsr.w   #4,D0
            andi.l  #$F,D0
            clr.w   -(SP)
            _DECSTR68K
            lea     (-$10,A6),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.w  #1,D0
            move.b  #$2E,(0,A0,D0.w)
            move.l  (A0),D0
            andi.l  #$FFFFFF,D0
            lea     (6,A2),A0
            move.l  (A0),D1
            andi.l  #$FFFFFF,D1
            cmp.l   D0,D1
            beq.b   .L2
.L1:
            moveq   #0,D0
            bra.b   .L3
.L2:
            moveq   #1,D0
.L3:
            move.w  D0,($C,A6)
            movem.l (SP)+,D1-D4/A1-A2
            move.l  (4,A6),(8,A6)
            unlk    A6
            addq.w  #4,SP
            rts
            dc.w    $4141
RsrcEntryiopc_127:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'iopc' 127 "IOPCLap B" (2676 bytes) - Combo mask
            dc.l    RsrcEntryltlk_3-BaseOfROM       ; Next entry
            dc.l    Rsrciopc_127-BaseOfROM          ; Data
            dc.b    'iopc'                          ; Type
            dc.w    127                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    9,'IOPCLap B'                   ; Name
            dc.b    $43,$53,$4D
            dc.l    $C0A00000,$00000A80,$0000025C   ; Block header
Rsrciopc_127:
            dc.b    $4C,$B2,$56,$4C,$D9,$56,$09,$A6,$A0,$60,$A2,$16,$A9,$01,$20,$BE
            dc.b    $60,$A0,$57,$A9,$EC,$A2,$0A,$38,$20,$9D,$60,$A0,$57,$A9,$E5,$A2
            dc.b    $0A,$38,$20,$9A,$60,$A2,$00,$A9,$02,$20,$AF,$60,$4C,$05,$57,$18
            dc.b    $20,$B5,$60,$A0,$00,$A2,$00,$A9,$01,$20,$BE,$60,$A2,$0A,$18,$20
            dc.b    $9D,$60,$A2,$04,$18,$20,$A3,$60,$A2,$06,$18,$20,$A3,$60,$A2,$0A
            dc.b    $18,$20,$9A,$60,$A2,$0A,$18,$20,$A6,$60,$60,$A9,$07,$20,$AC,$60
            dc.b    $0A,$AA,$7C,$0D,$57,$8A,$57,$54,$57,$8A,$57,$1F,$57,$1F,$57,$54
            dc.b    $57,$8A,$57,$1F,$57,$A9,$FB,$20,$B2,$60,$A0,$05,$BE,$C1,$60,$BD
            dc.b    $00,$02,$C9,$05,$B0,$0A,$C9,$01,$90,$06,$DA,$0A,$AA,$7C,$4A,$57
            dc.b    $A9,$FE,$9D,$00,$02,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C
            dc.b    $05,$57,$F3,$57,$54,$58,$8E,$58,$36,$59,$A9,$FD,$20,$B2,$60,$A2
            dc.b    $05,$BC,$C1,$60,$A9,$01,$99,$00,$03,$A6,$AA,$BD,$00,$61,$99,$01
            dc.b    $03,$BD,$F6,$60,$99,$02,$03,$B5,$C8,$99,$03,$03,$B5,$BF,$99,$04
            dc.b    $03,$A2,$05,$A9,$01,$9D,$00,$03,$A9,$08,$0C,$35,$F0,$4C,$05,$57
            dc.b    $08,$78,$A9,$FE,$20,$B2,$60,$A5,$AC,$F0,$0D,$A6,$AB,$E8,$E0,$09
            dc.b    $90,$02,$A2,$00,$86,$AB,$64,$AC,$A6,$AA,$74,$B6,$E8,$E0,$09,$90
            dc.b    $02,$A2,$00,$86,$AA,$E4,$AB,$F0,$2E,$A2,$05,$BC,$C1,$60,$A9,$01
            dc.b    $99,$00,$03,$A6,$AA,$BD,$00,$61,$99,$01,$03,$BD,$F6,$60,$99,$02
            dc.b    $03,$B5,$C8,$99,$03,$03,$B5,$BF,$99,$04,$03,$A2,$05,$A9,$01,$9D
            dc.b    $00,$03,$A9,$08,$0C,$35,$F0,$28,$4C,$05,$57,$A2,$0A,$A9,$04,$4C
            dc.b    $AF,$60,$A2,$0A,$A9,$01,$4C,$AF,$60,$A2,$08,$74,$B6,$CA,$10,$FB
            dc.b    $64,$AB,$64,$AA,$A9,$FF,$85,$AC,$A6,$AB,$A9,$80,$95,$B6,$A9,$16
            dc.b    $85,$D1,$A9,$61,$85,$D2,$FA,$9E,$00,$02,$BD,$01,$02,$85,$DF,$A9
            dc.b    $7D,$9D,$01,$02,$A9,$91,$9D,$02,$02,$5A,$A0,$5D,$A9,$9C,$A2,$04
            dc.b    $38,$20,$A0,$60,$A0,$5D,$A9,$9C,$A2,$06,$38,$20,$A3,$60,$08,$78
            dc.b    $A9,$04,$0C,$33,$F0,$20,$53,$59,$20,$B2,$5F,$28,$7A,$A9,$03,$99
            dc.b    $00,$02,$A9,$04,$0C,$35,$F0,$4C,$05,$57,$FA,$5A,$BD,$01,$02,$9E
            dc.b    $01,$02,$85,$D4,$DA,$78,$A2,$06,$8E,$40,$F0,$8D,$40,$F0,$58,$A4
            dc.b    $D4,$A6,$D4,$A9,$81,$20,$94,$5A,$90,$06,$FA,$9E,$00,$02,$80,$06
            dc.b    $FA,$A9,$FF,$9D,$00,$02,$7A,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35
            dc.b    $F0,$4C,$05,$57,$FA,$BD,$01,$02,$8D,$18,$61,$9E,$01,$02,$BD,$02
            dc.b    $02,$8D,$19,$61,$9E,$02,$02,$5A,$DA,$AC,$91,$7D,$AD,$93,$7D,$A6
            dc.b    $D4,$20,$94,$5A,$90,$04,$A9,$FF,$80,$24,$EE,$ED,$60,$D0,$0D,$EE
            dc.b    $EE,$60,$D0,$08,$EE,$EF,$60,$D0,$03,$EE,$F0,$60,$A6,$AB,$74,$B6
            dc.b    $64,$AC,$A9,$EA,$8D,$50,$57,$A9,$58,$8D,$51,$57,$A9,$00,$FA,$9D
            dc.b    $00,$02,$7A,$A9,$03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C,$05,$57
            dc.b    $FA,$BD,$01,$02,$8D,$18,$61,$9E,$01,$02,$BD,$02,$02,$8D,$19,$61
            dc.b    $9E,$02,$02,$5A,$DA,$AC,$91,$7D,$AD,$93,$7D,$A6,$D4,$20,$94,$5A
            dc.b    $90,$04,$A9,$FF,$80,$14,$EE,$ED,$60,$D0,$0D,$EE,$EE,$60,$D0,$08
            dc.b    $EE,$EF,$60,$D0,$03,$EE,$F0,$60,$A9,$00,$FA,$9D,$00,$02,$7A,$A9
            dc.b    $03,$99,$00,$02,$A9,$04,$0C,$35,$F0,$4C,$05,$57,$FA,$5A,$9E,$00
            dc.b    $02,$A9,$60,$8D,$01,$02,$A9,$C9,$8D,$02,$02,$7A,$A9,$03,$99,$00
            dc.b    $02,$A9,$04,$0C,$35,$F0,$4C,$05,$57,$A5,$B4,$05,$B3,$D0,$04,$A9
            dc.b    $03,$85,$B3,$A9,$01,$85,$B1,$85,$B2,$85,$AF,$3A,$3A,$85,$B0,$18
            dc.b    $20,$B5,$60,$A5,$DF,$10,$17,$A0,$00,$B9,$0B,$5A,$99,$D9,$00,$C8
            dc.b    $C0,$06,$90,$F5,$AD,$32,$F0,$09,$40,$8D,$32,$F0,$80,$15,$AD,$30
            dc.b    $F0,$29,$9F,$8D,$30,$F0,$A0,$00,$B9,$05,$5A,$99,$D9,$00,$C8,$C0
            dc.b    $06,$90,$F5,$AD,$40,$F0,$A5,$DF,$10,$16,$A2,$00,$BD,$EE,$59,$A8
            dc.b    $C8,$F0,$23,$8D,$40,$F0,$E8,$BD,$EE,$59,$8D,$40,$F0,$E8,$80,$EC
            dc.b    $A2,$00,$BD,$D1,$59,$A8,$C8,$F0,$0D,$8D,$40,$F0,$E8,$BD,$D1,$59
            dc.b    $8D,$40,$F0,$E8,$80,$EC,$60,$04,$20,$0A,$E0,$06,$00,$07,$7E,$0C
            dc.b    $06,$0D,$00,$0E,$C0,$03,$DD,$02,$00,$0F,$00,$01,$18,$0B,$70,$0E
            dc.b    $21,$05,$60,$FF,$04,$20,$0A,$E0,$06,$00,$07,$7E,$03,$DD,$02,$00
            dc.b    $0F,$00,$01,$18,$0B,$00,$0E,$60,$05,$60,$FF,$08,$04,$24,$1A,$07
            dc.b    $0E,$04,$02,$0A,$02,$00,$01,$A8,$29,$0F,$AA,$98,$4A,$4A,$4A,$4A
            dc.b    $A8,$18,$BD,$23,$5A,$79,$23,$5A,$60,$00,$01,$01,$02,$01,$02,$02
            dc.b    $03,$01,$02,$02,$03,$02,$03,$03,$04,$20,$36,$5A,$A2,$04,$A5,$B3
            dc.b    $6A,$6A,$45,$B3,$85,$D3,$A5,$B4,$6A,$6A,$6A,$6A,$45,$B4,$6A,$6A
            dc.b    $6A,$45,$D3,$6A,$26,$B3,$26,$B4,$CA,$D0,$E3,$A5,$B3,$60,$A0,$19
            dc.b    $A6,$AB,$AD,$2B,$F0,$C9,$5D,$D0,$0C,$AD,$2C,$F0,$C9,$02,$D0,$05
            dc.b    $88,$D0,$EF,$18,$60,$38,$60,$A0,$27,$AD,$2B,$F0,$C9,$05,$D0,$05
            dc.b    $88,$D0,$F6,$18,$60,$38,$60,$A9,$80,$A2,$10,$CA,$D0,$FD,$2C,$32
            dc.b    $F0,$D0,$05,$88,$D0,$F3,$18,$60,$38,$60,$85,$D6,$84,$D7,$86,$D8
            dc.b    $8E,$92,$7D,$A9,$20,$85,$AD,$85,$AE,$A5,$AF,$20,$11,$5A,$C9,$03
            dc.b    $90,$0B,$A5,$B1,$2A,$29,$0F,$85,$B1,$64,$AF,$80,$0F,$A5,$B0,$20
            dc.b    $11,$5A,$C9,$02,$90,$06,$46,$B1,$A0,$FF,$84,$B0,$06,$B0,$06,$AF
            dc.b    $A5,$B1,$85,$B2,$20,$36,$5A,$A9,$80,$2C,$32,$F0,$F0,$1E,$38,$26
            dc.b    $B2,$A9,$01,$04,$B0,$A0,$0F,$A2,$F1,$A9,$80,$2C,$32,$F0,$F0,$0C
            dc.b    $CA,$F0,$04,$80,$00,$80,$F4,$88,$D0,$F1,$80,$D8,$78,$A4,$D9,$20
            dc.b    $81,$5A,$B0,$0E,$A5,$B3,$25,$B2,$29,$0F,$F0,$27,$A8,$20,$81,$5A
            dc.b    $90,$21,$EE,$C9,$60,$D0,$0D,$EE,$CA,$60,$D0,$08,$EE,$CB,$60,$D0
            dc.b    $03,$EE,$CC,$60,$A9,$01,$04,$B0,$C6,$AE,$F0,$04,$58,$4C,$CE,$5A
            dc.b    $58,$38,$60,$A5,$D6,$10,$11,$0A,$AA,$7C,$36,$5B,$00,$00,$EE,$5B
            dc.b    $2C,$5C,$00,$00,$18,$5C,$22,$5C,$A4,$D8,$8C,$0E,$61,$A4,$D7,$8C
            dc.b    $0D,$61,$C0,$FF,$F0,$49,$20,$7E,$5C,$20,$B2,$5F,$E6,$E0,$A5,$DA
            dc.b    $0A,$A8,$20,$81,$5A,$90,$5F,$20,$71,$5A,$90,$5A,$20,$78,$5D,$B0
            dc.b    $55,$64,$E0,$A5,$B5,$C9,$80,$D0,$4D,$A2,$06,$CA,$D0,$FD,$A0,$00
            dc.b    $B1,$D1,$8D,$29,$F0,$C8,$B1,$D1,$8D,$2A,$F0,$C8,$B1,$D1,$8D,$2C
            dc.b    $F0,$C8,$B1,$D1,$8D,$2B,$F0,$20,$90,$5C,$20,$B2,$5F,$58,$60,$20
            dc.b    $7E,$5C,$20,$B2,$5F,$A0,$00,$B1,$D1,$8D,$29,$F0,$C8,$B1,$D1,$8D
            dc.b    $2A,$F0,$C8,$B1,$D1,$8D,$2C,$F0,$C8,$B1,$D1,$8D,$2B,$F0,$20,$90
            dc.b    $5C,$20,$B2,$5F,$58,$60,$EE,$CD,$60,$D0,$0D,$EE,$CE,$60,$D0,$08
            dc.b    $EE,$CF,$60,$D0,$03,$EE,$D0,$60,$A5,$01,$04,$AF,$38,$26,$B2,$C6
            dc.b    $AD,$F0,$09,$20,$B2,$5F,$64,$E0,$58,$4C,$CE,$5A,$20,$B2,$5F,$64
            dc.b    $E0,$38,$58,$60,$A4,$D7,$8C,$13,$61,$8C,$14,$61,$20,$36,$5C,$20
            dc.b    $B2,$5F,$A5,$DA,$0A,$A8,$20,$81,$5A,$90,$BB,$20,$58,$5A,$90,$B6
            dc.b    $20,$78,$5D,$B0,$B1,$A5,$B5,$C9,$40,$D0,$AB,$18,$58,$60,$A4,$D7
            dc.b    $A6,$D8,$20,$7E,$5C,$4C,$B2,$5F,$A4,$D7,$A6,$D8,$20,$64,$5C,$4C
            dc.b    $B2,$5F,$A4,$D7,$A6,$D8,$20,$4A,$5C,$4C,$B2,$5F,$A9,$13,$8D,$29
            dc.b    $F0,$A9,$61,$8D,$2A,$F0,$9C,$2C,$F0,$A9,$03,$8D,$2B,$F0,$80,$46
            dc.b    $8C,$0A,$61,$8E,$0B,$61,$A9,$0A,$8D,$29,$F0,$A9,$61,$8D,$2A,$F0
            dc.b    $9C,$2C,$F0,$A9,$03,$8D,$2B,$F0,$80,$2C,$8C,$10,$61,$8E,$11,$61
            dc.b    $A9,$10,$8D,$29,$F0,$A9,$61,$8D,$2A,$F0,$9C,$2C,$F0,$A9,$03,$8D
            dc.b    $2B,$F0,$80,$12,$A9,$0D,$8D,$29,$F0,$A9,$61,$8D,$2A,$F0,$9C,$2C
            dc.b    $F0,$A9,$03,$8D,$2B,$F0,$A6,$DF,$10,$27,$AD,$30,$F0,$29,$9F,$09
            dc.b    $20,$8D,$30,$F0,$A0,$0A,$8C,$40,$F0,$A9,$E0,$8D,$40,$F0,$A0,$03
            dc.b    $8C,$40,$F0,$A9,$D0,$8D,$40,$F0,$A9,$21,$8D,$28,$F0,$A0,$05,$80
            dc.b    $27,$A0,$03,$8C,$40,$F0,$A9,$D0,$8D,$40,$F0,$A9,$21,$8D,$28,$F0
            dc.b    $A0,$05,$8C,$40,$F0,$A9,$63,$8D,$40,$F0,$EA,$8C,$40,$F0,$A9,$61
            dc.b    $8D,$40,$F0,$A2,$01,$CA,$D0,$FD,$8C,$40,$F0,$A9,$6B,$8D,$40,$F0
            dc.b    $A6,$DE,$CA,$D0,$FD,$A9,$01,$8D,$40,$F0,$A9,$C0,$8D,$40,$F0,$A9
            dc.b    $80,$8D,$40,$F0,$A9,$C0,$8D,$40,$F0,$A0,$0F,$A2,$F1,$A9,$40,$2C
            dc.b    $40,$F0,$D0,$0D,$CA,$F0,$04,$80,$00,$80,$F4,$88,$D0,$F1,$4C,$5A
            dc.b    $5D,$A6,$DC,$A9,$04,$2C,$40,$F0,$D0,$06,$CA,$D0,$F8,$4C,$5A,$5D
            dc.b    $A6,$DD,$CA,$D0,$FD,$A0,$05,$8C,$40,$F0,$A9,$E3,$8D,$40,$F0,$A6
            dc.b    $DB,$CA,$D0,$FD,$8C,$40,$F0,$A9,$E1,$8D,$40,$F0,$9C,$28,$F0,$A9
            dc.b    $10,$8D,$40,$F0,$A9,$0C,$8D,$34,$F0,$A9,$30,$8D,$40,$F0,$18,$60
            dc.b    $A9,$05,$8D,$40,$F0,$A9,$E1,$8D,$40,$F0,$9C,$28,$F0,$A9,$10,$8D
            dc.b    $40,$F0,$A9,$0C,$8D,$34,$F0,$A9,$30,$8D,$40,$F0,$38,$60,$A0,$30
            dc.b    $A2,$01,$8E,$40,$F0,$AD,$40,$F0,$30,$18,$88,$D0,$F5,$EE,$E5,$60
            dc.b    $D0,$0D,$EE,$E6,$60,$D0,$08,$EE,$E7,$60,$D0,$03,$EE,$E8,$60,$4C
            dc.b    $B2,$5F,$9C,$28,$F0,$A9,$03,$8D,$40,$F0,$A9,$D0,$8D,$40,$F0,$64
            dc.b    $B5,$A9,$01,$8D,$40,$F0,$AD,$40,$F0,$89,$60,$F0,$30,$89,$40,$F0
            dc.b    $12,$EE,$D1,$60,$D0,$0D,$EE,$D2,$60,$D0,$08,$EE,$D3,$60,$D0,$03
            dc.b    $EE,$D4,$60,$89,$20,$F0,$12,$EE,$D5,$60,$D0,$0D,$EE,$D6,$60,$D0
            dc.b    $08,$EE,$D7,$60,$D0,$03,$EE,$D8,$60,$38,$4C,$B2,$5F,$A9,$10,$8D
            dc.b    $40,$F0,$A9,$0C,$8D,$34,$F0,$A9,$30,$8D,$40,$F0,$A5,$E5,$10,$15
            dc.b    $29,$7F,$C9,$06,$B0,$0F,$0A,$AA,$7C,$03,$5E,$12,$5E,$21,$5E,$0F
            dc.b    $5E,$4B,$5E,$29,$5E,$4C,$B2,$5F,$A2,$06,$CA,$D0,$FD,$A4,$D4,$A6
            dc.b    $D4,$20,$4A,$5C,$4C,$B2,$5F,$A9,$40,$85,$B5,$18,$4C,$B2,$5F,$A5
            dc.b    $E0,$F0,$08,$64,$E0,$A9,$80,$85,$B5,$18,$60,$EE,$E9,$60,$D0,$0D
            dc.b    $EE,$EA,$60,$D0,$08,$EE,$EB,$60,$D0,$03,$EE,$EC,$60,$18,$4C,$B2
            dc.b    $5F,$A6,$AC,$D0,$51,$A5,$E3,$C9,$FF,$F0,$0C,$A2,$06,$CA,$D0,$FD
            dc.b    $A4,$E4,$A6,$D4,$20,$64,$5C,$20,$4B,$5F,$A5,$DA,$0A,$A8,$20,$81
            dc.b    $5A,$90,$1D,$20,$58,$5A,$90,$18,$A0,$A2,$A2,$0B,$A9,$01,$8D,$40
            dc.b    $F0,$AD,$40,$F0,$30,$4C,$88,$F0,$04,$80,$00,$80,$EF,$CA,$D0,$EC
            dc.b    $EE,$E5,$60,$D0,$0D,$EE,$E6,$60,$D0,$08,$EE,$E7,$60,$D0,$03,$EE
            dc.b    $E8,$60,$38,$4C,$B2,$5F,$EE,$F1,$60,$D0,$0D,$EE,$F2,$60,$D0,$08
            dc.b    $EE,$F3,$60,$D0,$03,$EE,$F4,$60,$A5,$E3,$C9,$FF,$F0,$04,$18,$4C
            dc.b    $B2,$5F,$20,$B2,$5F,$A4,$DA,$C8,$20,$81,$5A,$20,$71,$5A,$18,$4C
            dc.b    $B2,$5F,$29,$60,$D0,$4B,$A6,$AB,$BD,$F6,$60,$85,$E1,$BD,$00,$61
            dc.b    $85,$E2,$A0,$02,$B1,$E1,$30,$39,$38,$A9,$5D,$ED,$2B,$F0,$95,$BF
            dc.b    $A9,$02,$ED,$2C,$F0,$95,$C8,$A9,$81,$95,$B6,$E4,$AA,$D0,$09,$DA
            dc.b    $A2,$0A,$A9,$02,$20,$AF,$60,$FA,$E8,$E0,$09,$90,$02,$A2,$00,$E4
            dc.b    $AA,$F0,$06,$86,$AB,$18,$4C,$B2,$5F,$A9,$FF,$85,$AC,$18,$4C,$B2
            dc.b    $5F,$89,$40,$F0,$12,$EE,$D1,$60,$D0,$0D,$EE,$D2,$60,$D0,$08,$EE
            dc.b    $D3,$60,$D0,$03,$EE,$D4,$60,$89,$20,$F0,$12,$EE,$D5,$60,$D0,$0D
            dc.b    $EE,$D6,$60,$D0,$08,$EE,$D7,$60,$D0,$03,$EE,$D8,$60,$38,$4C,$B2
            dc.b    $5F,$A9,$03,$8D,$40,$F0,$A9,$C0,$8D,$40,$F0,$AD,$42,$F0,$AD,$42
            dc.b    $F0,$AD,$42,$F0,$A5,$DF,$10,$14,$AD,$30,$F0,$29,$9F,$09,$40,$8D
            dc.b    $30,$F0,$A9,$0A,$8D,$40,$F0,$A9,$80,$8D,$40,$F0,$A9,$30,$8D,$40
            dc.b    $F0,$A9,$03,$8D,$40,$F0,$A9,$DD,$8D,$40,$F0,$A9,$01,$8D,$40,$F0
            dc.b    $A9,$F8,$8D,$40,$F0,$A6,$AB,$BD,$F6,$60,$8D,$29,$F0,$BD,$00,$61
            dc.b    $8D,$2A,$F0,$A9,$02,$8D,$2C,$F0,$A9,$5D,$8D,$2B,$F0,$A9,$25,$8D
            dc.b    $28,$F0,$A9,$0C,$8D,$34,$F0,$60,$A9,$03,$8D,$40,$F0,$A9,$C0,$8D
            dc.b    $40,$F0,$A9,$10,$8D,$40,$F0,$AD,$42,$F0,$AD,$42,$F0,$AD,$42,$F0
            dc.b    $A5,$DF,$10,$14,$AD,$30,$F0,$29,$9F,$09,$40,$8D,$30,$F0,$A9,$0A
            dc.b    $8D,$40,$F0,$A9,$80,$8D,$40,$F0,$A9,$30,$8D,$40,$F0,$A9,$03,$8D
            dc.b    $40,$F0,$A9,$DD,$8D,$40,$F0,$A9,$01,$8D,$40,$F0,$A9,$F8,$8D,$40
            dc.b    $F0,$A9,$E3,$8D,$29,$F0,$9C,$2A,$F0,$9C,$2C,$F0,$A9,$05,$8D,$2B
            dc.b    $F0,$A9,$25,$8D,$28,$F0,$A9,$0C,$8D,$34,$F0,$60,$02,$0B,$4C,$6F
            dc.b    $63,$61,$6C,$54,$61,$6C,$6B,$2B,$2B,$2C,$56,$65,$72,$73,$69,$6F
            dc.b    $6E,$20,$35,$36,$2E,$30,$20,$A9,$20,$41,$70,$70,$6C,$65,$20,$43
            dc.b    $6F,$6D,$70,$75,$74,$65,$72,$20,$49,$6E,$63,$2E,$20,$31,$39,$38
            dc.b    $38,$2D,$31,$39,$39,$31,$38,$01,$80,$00,$00,$00,$08,$35,$36,$2E
            dc.b    $30,$2E,$31,$20,$20,$00,$39,$49,$4F,$50,$20,$4C,$6F,$63,$61,$6C
            dc.b    $54,$61,$6C,$6B,$20,$76,$35,$36,$2E,$30,$2E,$31,$20,$20,$3B,$20
            dc.b    $A9,$20,$41,$70,$70,$6C,$65,$20,$43,$6F,$6D,$70,$75,$74,$65,$72
            dc.b    $2C,$20,$49,$6E,$63,$2E,$20,$31,$39,$38,$38,$2D,$31,$39,$39,$31
            dc.b    $6C,$00,$00,$6C,$02,$00,$6C,$04,$00,$6C,$06,$00,$6C,$08,$00,$6C
            dc.b    $0A,$00,$6C,$0C,$00,$6C,$0E,$00,$6C,$10,$00,$6C,$12,$00,$6C,$14
            dc.b    $00,$6C,$16,$00,$6C,$18,$00,$00,$20,$40,$60,$80,$A0,$C0,$E0,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01
            dc.b    $00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$08,$34,$D7,$7A,$1D
            dc.b    $C0,$63,$06,$A9,$4C,$EF,$7B,$78,$76,$74,$71,$6F,$6D,$6A,$68,$65
            dc.b    $00,$00,$82,$00,$00,$84,$00,$00,$85,$00,$00,$81,$91,$7D,$00,$00
RsrcEntryatlk_1:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'atlk' 1 "ATalk" (372 bytes) - Combo mask
            dc.l    RsrcEntryiopc_127-BaseOfROM     ; Next entry
            dc.l    Rsrcatlk_1-BaseOfROM            ; Data
            dc.b    'atlk'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    5,'ATalk'                       ; Name
            dc.b    '>>[(c) '
            dc.l    $C0A00000,$00000180,$00000254   ; Block header
Rsrcatlk_1:
            bra.b   .L1
            dc.b    $60,$54,$00,$00,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3A
            dc.b    'LocalTalk atlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00
.L1:
            moveq   #-$5F,D0
            jmp     (A0)
            movem.l D0-D7/A1-A6,-(SP)
            cmpi.w  #8,D0
            bhi.w   .L7
            lsl.w   #1,D0
            move.w  .L2(PC,D0.w),D0
            jmp     .L2(PC,D0.w)
.L2:
            dc.w    .L7-.L2
            dc.w    .L3-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
            dc.w    .L7-.L2
.L3:
            tst.w   ROM85
            bmi.w   .L7
            move.l  #$72A,D0
            _NewPtrSysClear
            bne.w   .L7
            move.b  D4,($2E4,A0)
            movea.l ExpandMem,A2
            move.l  A0,($70,A2)
            movea.l A0,A2
            move.w  #$A89F,D0
            _GetTrapAddress
            movea.l A0,A1
            move.w  #$A1AD,D0
            _GetOSTrapAddress
            move.l  A1,D0
            cmp.l   A0,D0
            beq.b   .L4
            move.l  #$766D2020,D0
            _Gestalt
            bne.b   .L4
            move.l  A0,D0
            beq.b   .L4
            move.b  D0,($727,A2)
.L4:
            move.w  #$A086,D0
            _GetOSTrapAddress
            move.l  A0,D0
            _StripAddress
            move.l  D0,-(SP)
            move.w  #$A89F,D0
            _GetOSTrapAddress
            move.l  A0,D0
            _StripAddress
            cmp.l   (SP)+,D0
            beq.b   .L5
            move.b  ($BFE).w,D0
            btst    #0,D0
            bne.b   .L5
            move.w  #1,D0
            bsr.b   sub_408DC8B0
            bra.b   .L6
.L5:
            clr.w   D0
            bsr.b   sub_408DC8B0
.L6:
            move.l  A0,D0
            beq.b   .L7
            move.l  (A0),D0
            _StripAddress
            move.l  D0,-(SP)
            lea     Rsrcatlk_1,A0
            movea.l LAPMgrPtr,A1
            moveq   #3,D0
            jsr     (2,A1)
            movea.l (SP),A0
            moveq   #2,D0
            moveq   #$38,D1
            clr.w   D2
            jsr     (2,A1)
            movea.l (SP)+,A0
            movem.l (SP)+,D0-D7/A1-A6
            jmp     (2,A0)
.L7:
            movem.l (SP)+,D0-D7/A1-A6
            move.w  #$FFFF,D0
            rts
sub_408DC8B0:
            move.w  D0,-(SP)
            move.w  CurMap,-(SP)
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'ltlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.w  (SP)+,CurMap
            move.l  A0,D0
            bne.b   .L1
            move.w  (SP)+,D0
            subq.w  #4,SP
            move.l  #'ltlk',-(SP)
            move.w  D0,-(SP)
            _Get1Resource
            movea.l (SP)+,A0
            rts
.L1:
            addq.w  #2,SP
            rts
            dc.w    $5748
RsrcEntryltlk_0:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'ltlk' 0 "LTLK" (2996 bytes) - Combo mask
            dc.l    RsrcEntryatlk_1-BaseOfROM       ; Next entry
            dc.l    Rsrcltlk_0-BaseOfROM            ; Data
            dc.b    'ltlk'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'LTLK'                        ; Name
            dc.b    'MBPKEBAL'
            dc.l    $C0A00000,$00000BC0,$0000024C   ; Block header
Rsrcltlk_0:
            bra.b   .L1
            dc.b    $60,$54,$05,$EC,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3E
            dc.b    'SCC LocalTalk ltlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00,$0C,$40,$00,$08,$62,$1C,$E3,$48,$30,$3B,$00,$06,$4E,$FB,$00
            dc.b    $02,$00,$12,$00,$92,$00,$C6,$00,$12,$00,$12,$00,$12,$00,$12,$00
            dc.b    $A8,$00,$B4,$70,$FF,$4E,$75
.L1:
            movea.l ExpandMem,A3
            movea.l ($70,A3),A3
            movem.l D2/A0-A2,($2C4,A3)
            exg     A2,A3
            tst.b   D0
            beq.b   .L4
            tst.b   ($2BA,A2)
            bne.b   .L2
            move.l  A3,($2BC,A2)
            move.l  A1,($2E6,A2)
            bsr.w   sub_408DCAC6
            st      ($2BA,A2)
.L2:
            st      ($5E2,A2)
            move.b  D2,(A2)
            movea.l SCCWr,A1
            move.b  #6,(A1)
            nop
            move.b  (A2),(A1)
            bsr.w   sub_408DCC0A
            tst.b   ($5E1,A2)
            beq.b   .L5
            clr.b   ($5E1,A2)
            moveq   #$C,D0
            movea.l LAPMgrPtr,A3
            move.b  ($2E4,A2),D4
            move.l  A2,-(SP)
            movea.l ($2BC,A2),A2
            jsr     (2,A3)
            tst.w   D0
            beq.b   .L3
            moveq   #5,D0
            jsr     (2,A3)
.L3:
            movea.l (SP)+,A2
            bra.b   .L5
.L4:
            st      ($5DF,A2)
            bsr.w   sub_408DCC02
.L5:
            movem.l ($2C4,A2),D2/A0-A2
            jmp     (A0)
            movem.l D1/D4,-(SP)
            lea     Rsrcltlk_0,A0
            _RecoverHandle
            move.l  A0,-(SP)
            _DetachResource
            movem.l (SP)+,D1/D4
            clr.w   D0
            rts
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            bsr.b   sub_408DCA6E
            rts
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            move.l  A2,-(SP)
            bsr.b   sub_408DCA8A
            movea.l (SP)+,A2
            bsr.b   sub_408DCA98
            rts
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            move.l  A2,-(SP)
            bsr.b   sub_408DCA8A
            movea.l (SP),A2
            bsr.b   sub_408DCA98
            movea.l LAPMgrPtr,A1
            moveq   #3,D0
            jsr     (2,A1)
            movea.l (SP)+,A0
            _DisposPtr
            rts
sub_408DCA6E:
            movem.l D1/A1,-(SP)
            movea.l LAPMgrPtr,A1
            moveq   #$11,D0
            moveq   #1,D1
            jsr     (2,A1)
            movem.l (SP)+,D1/A1
            bne.b   .L1
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
sub_408DCA8A:
            moveq   #$12,D0
            moveq   #1,D1
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            rts
sub_408DCA98:
            tst.b   ($2BA,A2)
            beq.b   .L1
            lea     sub_408DD158.L26,A0
            bsr.w   sub_408DCBF0
            lea     ($292,A2),A0
            _VRemove
            lea     ($618,A2),A0
            lea     ($1BA).w,A3
            move.l  (A0)+,(A3)+
            move.l  (A0)+,(A3)+
            move.l  (A0)+,ExtStsDT
            clr.b   ($5DF,A2)
            clr.b   ($2BA,A2)
.L1:
            rts
sub_408DCAC6:
            movem.l D0-D7/A0-A6,-(SP)
            suba.w  #$10,SP
            movea.l SP,A0
            moveq   #1,D0
            _SysEnvirons
            move.w  (2,A0),D0
            addq.w  #2,D0
            move.w  D0,($6E2,A2)
            adda.w  #$10,SP
            movea.l ROMBase,A3
            movea.l VIA,A1
            lea     ($1E00,A1),A1
            cmpi.b  #3,(8,A3)
            bne.b   .L1
            suba.w  #$1E00,A1
            bra.b   .L2
.L1:
            cmpi.w  #$D,($6E2,A2)
            bne.b   .L2
            movea.l SCCRd,A1
            lea     (-$1C,A1),A1
.L2:
            move.l  A1,($638,A2)
            lea     sub_408DD158.L23,A0
            move.l  (A0)+,($63C,A2)
            move.w  (A0)+,($640,A2)
            move.w  (A0)+,($1C,A2)
            cmpi.b  #$75,(9,A3)
            beq.b   .L3
            cmpi.b  #$76,(9,A3)
            beq.b   .L3
            move.w  #$2300,($1C,A2)
.L3:
            cmpi.b  #$75,(9,A3)
            bhi.b   .L4
            moveq   #$14,D0
            lea     sub_408DD158.L24,A0
            lea     ($5EC,A2),A1
            _BlockMove
            bra.b   .L9
.L4:
            bsr.w   sub_408DD2EE
            moveq   #0,D7
            move.w  D0,D7
            bsr.w   sub_408DD3D4
            moveq   #0,D6
            move.w  D0,D6
            moveq   #$14,D0
            lea     ($5EC,A2),A1
            movea.l ROMBase,A0
            moveq   #0,D1
            move.w  D7,D1
            divu.w  #$64,D1
            lea     sub_408DD158.L25,A3
.L5:
            move.w  (A3)+,D3
            moveq   #0,D2
            move.b  (A3)+,D2
            divu.w  D1,D2
            sub.w   D2,D3
            tst.b   (A3)+
            bmi.b   .L8
            mulu.w  D7,D3
.L6:
            divu.w  #$3E8,D3
            subq.w  #1,D3
            bpl.b   .L7
            moveq   #0,D3
.L7:
            move.w  D3,(A1)+
            subq.w  #2,D0
            bne.b   .L5
            bra.b   .L9
.L8:
            mulu.w  D6,D3
            bra.b   .L6
.L9:
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($1BA).w,A3
            lea     ($618,A2),A1
            lea     sub_408DCF72,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408DD0C6.L3,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408DCDBA,A0
            move.l  ExtStsDT,(A1)
            move.l  A0,ExtStsDT
            lea     ($292,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408DCE02,A1
            move.l  A1,(6,A0)
            move.w  #$14,($A,A0)
            _VInstall
            bsr.b   sub_408DCBE6
            move    (SP)+,SR
            movem.l (SP)+,D0-D7/A0-A6
            rts
sub_408DCBE6:
            lea     sub_408DD158.L21,A0
            bsr.b   sub_408DCBF0
            lea     sub_408DD158.L22,A0
sub_408DCBF0:
            movea.l SCCWr,A3
.L1:
            move.w  (A0)+,D0
            beq.b   .L2
            move.b  D0,(A3)
            ror.w   #8,D0
            move.b  D0,(A3)
            bra.b   .L1
.L2:
            rts
sub_408DCC02:
            clr.b   ($5E2,A2)
            move.l  A1,($5D4,A2)
sub_408DCC0A:
            movea.l ROMBase,A3
            cmpi.b  #3,(8,A3)
            bne.b   .L1
            movea.l PmgrBase,A3
            move.b  #$10,($E,A3)
            tst.w   ($FE0000).l
.L1:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            _IdleUpdate
.L2:
            move.l  (SP)+,($5D8,A2)
            move.b  D2,($5DE,A2)
            lea     ($5E5,A2),A3
            move.b  (A3)+,D3
            move.b  (A3),D2
            add.b   D2,(A3)+
            bsr.b   sub_408DCC54
            ble.b   sub_408DCC54.L3
            add.b   D3,D3
            addq.b  #1,D3
            andi.w  #$F,D3
            clr.b   (-1,A3)
            bra.b   sub_408DCC54.L4
sub_408DCC54:
            moveq   #0,D0
            moveq   #7,D1
.L1:
            btst    D1,D2
            beq.b   .L2
            addq.w  #1,D0
.L2:
            dbra    D1,.L1
            subq.b  #2,D0
            rts
.L3:
            move.b  (A3),D2
            bsr.b   sub_408DCC54
            bge.b   .L4
            lsr.b   #1,D3
            st      (A3)
.L4:
            move.b  (A3),D2
            add.b   D2,(A3)+
            moveq   #$20,D0
            move.b  D0,(A3)+
            move.b  D0,(A3)
            subq.w  #5,A3
            move.b  D3,(A3)+
            move.b  D3,(A3)+
            movem.l SCCRd,A0-A1
.L5:
            move    SR,-(SP)
.L6:
            move.w  D0,D3
            btst    #4,(A0)
            beq.b   .L10
            bsr.w   sub_408DCE64
            and.b   ($5E4,A2),D0
            andi.w  #$F,D0
            move.w  D0,D3
            beq.b   .L8
.L7:
            bsr.b   sub_408DCD20
            beq.b   .L10
            subq.w  #1,D0
            bne.b   .L7
.L8:
            move    #$2600,SR
            moveq   #3,D0
            addq.w  #3,D3
.L9:
            move.b  #$E,(A1)
            nop
            move.b  #$41,(A1)
            bsr.b   sub_408DCD20
            dbeq    D0,.L9
.L10:
            beq.w   sub_408DCD20.L9
            move.b  #$A,(A1)
            move.b  ($5DE,A2),D2
            tst.b   (A0)
            bmi.w   sub_408DCD20.L9
            move.b  #5,(A1)
            moveq   #-$7C,D0
            move.b  #$62,(A1)
            tst.b   ($5E2,A2)
            beq.b   .L11
            moveq   #-$7F,D0
.L11:
            move.b  #5,(A1)
            nop
            move.b  ($63D,A2),(A1)
            move.w  ($5FE,A2),D1
.L12:
            dbra    D1,.L12
            bsr.w   sub_408DCF28
            addq.b  #1,D2
            beq.b   sub_408DCD20.L4
            clr.b   ($5E0,A2)
            bsr.w   sub_408DCE48
            tst.b   ($5E2,A2)
            beq.b   .L13
            tst.b   ($5E1,A2)
            beq.b   sub_408DCD20.L8
            bra.b   sub_408DCD20.L6
.L13:
            tst.b   ($5E0,A2)
            st      ($5E0,A2)
            beq.b   sub_408DCD20.L8
            bra.b   sub_408DCD20.L5
sub_408DCD20:
            move.w  ($5FA,A2),D1
            bra.b   .L2
.L1:
            dbra    D1,.L1
            bra.b   .L3
.L2:
            bra.b   .L1
.L3:
            btst    #4,(A0)
            rts
.L4:
            bsr.b   sub_408DCD20
            beq.b   .L8
            cmpi.w  #$72,($5FA,A2)
            bcs.b   .L5
            bsr.b   sub_408DCD20
            beq.b   .L8
.L5:
            bsr.w   sub_408DCEAC
.L6:
            moveq   #0,D0
            addq.l  #1,($6F2,A2)
.L7:
            move    (SP)+,SR
            movea.l ($5D8,A2),A0
            jmp     (A0)
.L8:
            addq.l  #1,($70E,A2)
            move    (SP),SR
            bset    #0,($5E6,A2)
            move.b  ($5E4,A2),D0
            add.b   D0,D0
            addq.b  #1,D0
            move.b  D0,($5E4,A2)
            moveq   #-$5F,D0
            subq.b  #1,($5E9,A2)
            beq.b   .L7
            bra.w   sub_408DCC54.L6
.L9:
            sub.w   D0,D3
            subq.w  #4,D3
            blt.b   .L10
            addq.l  #1,($712,A2)
            moveq   #-$5F,D0
            subq.b  #1,($5E8,A2)
            beq.b   .L7
            bset    #0,($5E4,A2)
            bset    #0,($5E7,A2)
.L10:
            clr.b   ($726,A2)
            move    #$2600,SR
            move.b  #$F,(A1)
            moveq   #-$78,D0
            move.b  D0,(A1)
            move.b  #2,($5E3,A2)
            moveq   #0,D0
            movem.l ($2C4,A2),D2/A0-A2
.L11:
            move    (SP)+,SR
            rts
sub_408DCDBA:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            tst.b   ($5E3,A2)
            bne.b   .L1
            btst    #3,D1
            beq.w   sub_408DCE48.L3
            movea.l ($2C2).w,A3
            jmp     (A3)
.L1:
            move.b  #$F,(A1)
            moveq   #8,D0
            move.b  D0,(A1)
            clr.b   ($5E3,A2)
            move    ($1C,A2),SR
            tst.b   ($727,A2)
            beq.b   sub_408DCDF6.L1
            move.l  A2,D0
            lea     sub_408DCDF6,A0
            _DeferUserFn
            rts
sub_408DCDF6:
            movea.l A0,A2
            movem.l SCCRd,A0-A1
.L1:
            bra.w   sub_408DCC54.L5
sub_408DCE02:
            bsr.w   sub_408DD2DE
            move    SR,-(SP)
            move    #$2600,SR
            tst.b   ($5E3,A2)
            beq.b   sub_408DCD20.L11
            subq.b  #1,($5E3,A2)
            bne.b   sub_408DCD20.L11
            addq.w  #2,SP
            movem.l SCCRd,A0-A1
            bsr.w   sub_408DD11C
            addq.l  #1,($716,A2)
            move.b  #$F,(A1)
            moveq   #8,D0
            move.b  D0,(A1)
            move    ($1C,A2),SR
            bra.w   sub_408DCC54.L5
            move.w  #$3FC,($A,A0)
            lea     (-$6AE,A0),A2
            clr.w   ($6AC,A2)
            rts
sub_408DCE48:
            movem.l A0-A2,-(SP)
            move.w  ($5F4,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L2
            bsr.w   sub_408DCF7E
.L2:
            movem.l (SP)+,A0-A2
.L3:
            rts
sub_408DCE64:
            move.w  ($5DC,A2),D0
            mulu.w  #$305,D0
            addq.w  #1,D0
            move.w  D0,-(SP)
            lsl.w   #8,D0
            move.b  (SP)+,D0
            move.w  D0,($5DC,A2)
            rts
.L1:
            dc.w    $056B,$03D0
sub_408DCE7E:
            move.w  ($5F0,A2),D1
.L1:
            btst    #2,(A0)
            dbne    D1,.L1
            beq.b   .L2
            move.b  D3,(4,A1)
.L2:
            tst.w   D1
            rts
sub_408DCE94:
            lea     sub_408DCE64.L1,A3
            moveq   #4,D3
            bsr.w   sub_408DCF6A
            move.w  ($5F6,A2),D3
.L1:
            dbra    D3,.L1
            move.b  #$80,(A1)
            rts
sub_408DCEAC:
            movem.l A0-A1/A4-A6,($624,A2)
            move.l  DskRtnAdr,-(SP)
            move.l  PollStack,-(SP)
            move.l  SP,PollStack
            movea.l ($638,A2),A5
            lea     (6,A0),A6
            movea.l ($5D4,A2),A4
            bsr.b   sub_408DCE94
            move.w  (A4)+,D3
            movea.l (A4)+,A3
            move.b  (A3)+,(4,A1)
            subq.w  #1,D3
            move.b  (A2),(A3)
.L1:
            move.w  ($5F0,A2),D0
.L2:
            btst    #2,(A0)
            dbne    D0,.L2
            bne.b   .L3
            bsr.b   sub_408DCF64
            bra.b   .L6
.L3:
            move.b  (A3)+,(4,A1)
            tst.b   (A5)
            bmi.b   .L4
            move.b  (A6),-(SP)
.L4:
            subq.w  #1,D3
            bgt.b   .L1
            move.w  (A4)+,D3
            beq.b   .L5
            movea.l (A4)+,A3
            bra.b   .L1
.L5:
            bsr.b   sub_408DCF40
.L6:
            move.l  PollProc,D3
            beq.b   .L7
            movea.l D3,A4
            jsr     (A4)
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
.L7:
            movem.l ($624,A2),A0-A1/A4-A6
            movea.l PollStack,SP
            move.l  (SP)+,PollStack
            move.l  (SP)+,DskRtnAdr
            rts
sub_408DCF28:
            bsr.w   sub_408DCE94
            move.b  D2,(4,A1)
            move.b  (A2),D3
            bsr.w   sub_408DCE7E
            bmi.b   sub_408DCF64
            move.b  D0,D3
            bsr.w   sub_408DCE7E
            bmi.b   sub_408DCF64
sub_408DCF40:
            move.b  #$C0,(A1)
            lsl.w   #1,D3
.L1:
            btst    #6,(A0)
            beq.b   .L1
.L2:
            btst    #2,(A0)
            beq.b   .L2
            move.b  #5,(A1)
            moveq   #0,D3
            move.b  #$62,(A1)
            move.w  ($5EC,A2),D3
.L3:
            dbra    D3,.L3
sub_408DCF64:
            lea     ($63C,A2),A3
            moveq   #6,D3
sub_408DCF6A:
            move.b  (A3)+,(A1)
            subq.w  #1,D3
            bne.b   sub_408DCF6A
            rts
sub_408DCF72:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            addq.l  #1,($6EA,A2)
sub_408DCF7E:
            move.b  (4,A0),D0
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            movea.l ($2BC,A2),A3
            lea     (1,A3),A3
            move.b  D0,(A3)+
            move.b  D0,(1,A2)
            move.w  ($5EE,A2),D1
            add.w   D1,D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L5
            move.b  (4,A0),(A3)+
            move.b  (-1,A3),(2,A2)
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   .L5
            move.b  (4,A0),D0
            move.b  D0,(A3)+
            bmi.w   .L7
            move.b  D0,D2
            move.w  ($5EE,A2),D0
            add.w   D0,D0
.L3:
            btst    #0,(A0)
            dbne    D0,.L3
            beq.b   .L5
            move.b  (4,A0),(A3)
            moveq   #3,D1
            and.b   (A3)+,D1
            lsl.w   #8,D1
            movem.l A4-A5,($2FE,A2)
.L4:
            btst    #0,(A0)
            dbne    D0,.L4
.L5:
            beq.w   sub_408DD0C6.L2
            move.b  (4,A0),D1
            move.b  D1,(A3)+
            subq.w  #2,D1
            move.l  ($2E6,A2),D0
            beq.b   .L6
            movea.l D0,A5
            move.b  (A5),D0
            bmi.b   .L6
            andi.b  #$F,D0
            subq.b  #1,D0
            bne.b   .L6
            movea.l ($2BC,A2),A2
            movea.l LAPMgrPtr,A5
            lea     sub_408DD158.L6,A4
            moveq   #1,D0
            jsr     (2,A5)
.L6:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            movem.l ($2FE,A2),A4-A5
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            bne.w   sub_408DD158.L1
            addq.l  #1,($702,A2)
            clr.w   D3
            bra.w   sub_408DD158.L7
.L7:
            moveq   #$7F,D2
            and.b   D0,D2
            cmpi.b  #5,D2
            bgt.w   sub_408DD0C6.L1
            bsr.w   sub_408DD0E2
            bne.b   .L8
            move.b  (A2),D0
            cmpi.b  #$FF,(1,A2)
            seq     D1
            beq.b   .L9
            tst.b   ($5DF,A2)
            bne.b   .L9
            cmp.b   (1,A2),D0
            bne.b   .L8
            st      ($5E1,A2)
.L8:
            rts
.L9:
            cmp.b   (1,A2),D0
            bne.b   .L11
            subq.b  #1,D2
            beq.b   .L16
            subq.b  #3,D2
            beq.b   .L12
            tst.b   ($5E0,A2)
            beq.b   .L10
            addq.l  #1,($722,A2)
.L10:
            subq.b  #1,D2
            seq     ($5E0,A2)
.L11:
            rts
.L12:
            tst.b   D1
            bne.b   .L14
            move.w  ($5F8,A2),D0
.L13:
            dbra    D0,.L13
            moveq   #-$7B,D0
            bsr.b   sub_408DD0C6
.L14:
            move.w  ($5F2,A2),D1
.L15:
            btst    #0,(A0)
            dbne    D1,.L15
            bne.w   sub_408DCF7E
            addq.l  #1,($71E,A2)
            rts
.L16:
            move.w  ($5F8,A2),D0
.L17:
            dbra    D0,.L17
            moveq   #-$7E,D0
sub_408DD0C6:
            move.b  (2,A2),D2
            bra.w   sub_408DCF28
            addq.l  #1,($702,A2)
            bra.b   .L3
.L1:
            addq.l  #1,($70A,A2)
            bra.b   .L3
.L2:
            addq.l  #1,($6FE,A2)
.L3:
            bsr.b   sub_408DD11C
            bra.b   sub_408DD11C
sub_408DD0E2:
            clr.w   D0
            move.w  ($5EE,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.w   sub_408DD158.L3
            bsr.b   sub_408DD158
            bmi.b   sub_408DD158.L2
            tst.b   (4,A0)
            move.w  ($5EE,A2),D1
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   sub_408DD158.L3
            bsr.b   sub_408DD158
            bpl.b   sub_408DD158.L2
            lsl.b   #1,D1
            bmi.b   sub_408DD158.L4
            move.w  ($5FC,A2),D1
.L3:
            dbra    D1,.L3
            bra.b   sub_408DD11C.L3
sub_408DD11C:
            bsr.b   sub_408DD158
            btst    #5,D1
            beq.b   .L1
            bclr    #7,($15F).w
.L1:
            moveq   #-$30,D1
            bsr.b   sub_408DD14E
            moveq   #2,D1
.L2:
            tst.b   (4,A0)
            move.b  #$30,(A1)
            dbra    D1,.L2
            moveq   #-$23,D1
            bsr.b   sub_408DD14E
.L3:
            move.b  #$30,(A1)
            move.w  (SP),(SP)
            move.b  #$20,(A1)
            tst.w   D0
            rts
sub_408DD14E:
            move.b  #3,(A1)
            nop
            move.b  D1,(A1)
            rts
sub_408DD158:
            move.b  #1,(A1)
            nop
            move.b  (A0),D1
            rts
.L1:
            move.b  D0,D1
            moveq   #0,D0
.L2:
            btst    #5,D1
            bne.b   .L5
            addq.l  #1,($706,A2)
            moveq   #-4,D0
            bra.b   sub_408DD11C
.L3:
            addq.l  #1,($6FE,A2)
            moveq   #-3,D0
            bra.b   sub_408DD11C
.L4:
            addq.l  #1,($6F6,A2)
            moveq   #-2,D0
            bra.b   sub_408DD11C
.L5:
            addq.l  #1,($6FA,A2)
            moveq   #-1,D0
            bra.b   sub_408DD11C
.L28:
            bra.w   .L27
.L6:
            bra.b   .L28
.L7:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            movea.l ($638,A2),A5
            movea.l SP,A4
.L8:
            move.w  ($5EE,A2),D0
            subq.w  #1,D1
            bmi.b   .L11
.L9:
            btst    #0,(A0)
            dbne    D0,.L9
            beq.b   .L11
            move.b  (4,A0),D0
            tst.b   (A5)
            bmi.b   .L10
            move.b  (6,A0),-(SP)
.L10:
            subq.w  #1,D3
            bmi.b   .L8
            move.b  D0,(A3)+
            bra.b   .L8
.L11:
            bsr.w   sub_408DD0E2
            move.l  PollStack,($60C,A2)
            move.l  A4,PollStack
            move.l  PollProc,D1
            beq.b   .L12
            movem.l D0/D2-D3/A3/A6,($624,A2)
            lea     (6,A0),A6
            movea.l D1,A0
            move.l  DskRtnAdr,($608,A2)
            jsr     (A0)
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            move.l  ($608,A2),DskRtnAdr
            movem.l ($624,A2),D0/D2-D3/A3/A6
.L12:
            movea.l PollStack,SP
            move.l  ($60C,A2),PollStack
.L13:
            movem.l ($2FE,A2),A4-A5
            tst.w   D0
            bne.b   .L14
            addq.l  #1,($6EE,A2)
.L14:
            tst.w   D0
.L15:
            movea.l ($2BC,A2),A2
            rts
.L27:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            sub.w   D3,D1
.L16:
            move.w  ($5EE,A2),D0
.L17:
            btst    #0,(A0)
            dbne    D0,.L17
            beq.b   .L18
            move.b  (4,A0),(A3)+
            subq.w  #1,D3
            bne.b   .L16
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            beq.b   .L15
            bmi.b   .L19
            addq.l  #1,($6FA,A2)
            moveq   #-1,D0
            bra.b   .L20
.L18:
            addq.l  #1,($6FE,A2)
            moveq   #-3,D0
            bra.b   .L20
.L19:
            addq.l  #1,($706,A2)
            moveq   #-4,D0
.L20:
            bsr.w   sub_408DD11C
            bra.b   .L13
.L21:
            dc.w    $4009,$2004,$E00A,$0006,$7E07,$060C,$000D,$C00E
            dc.w    $DD03,$0002,$080F,$0901,$0A09,0
.L22:
            dc.w    $700B,$210E,$6005,0
.L23:
            dc.w    $0560,$0E41,$03DD,$2100
.L24:
            dc.w    $0035,$0014,$001E,$0082,$0066,$0010,0,$0039
            ds.b    4
.L25:
            dc.w    $006E,$3A00,$0064,$00FF,$00C8,$00FF,$01F4,$00FF
            dc.w    $0190,$72FF,$0046,$2C00,$001E,0,$0064,$5A00
            dc.w    $003C,$FF00,$000A,$4000
.L26:
            dc.w    $4A09,$000A,$1000,$080F,$0101,0
sub_408DD2DE:
            move.w  #$14,($A,A0)
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            rts
sub_408DD2EE:
            movem.l D1-D7/A1,-(SP)
            lea     sub_408DD2EE,A1
            movea.l ROMBase,A0
            cmpi.b  #$75,(9,A0)
            bcs.b   .L2
            move.l  A0,D0
            _StripAddress
            cmpa.l  D0,A1
            bcs.b   .L1
            movea.l D0,A0
            add.l   ($40,A0),D0
            cmpa.l  D0,A1
            bcs.b   .L2
.L1:
            suba.w  #$E,SP
            movea.l SP,A0
            clr.l   ($A,A0)
            move.w  #$FFFF,(4,A0)
            _InsTime
            move.b  (4,A0),D0
            bpl.b   .L3
            _RmvTime
            adda.w  #$E,SP
.L2:
            move.w  TimeDBRA,D0
            movem.l (SP)+,D1-D7/A1
            rts
.L3:
            _RmvTime
            adda.w  #$E,SP
            movem.l D4-D7,-(SP)
            moveq   #6,D0
.L4:
            clr.w   -(SP)
            dbra    D0,.L4
            moveq   #9,D4
            move.l  #$FFFF,D5
.L5:
            move.l  #$3938700,D7
            movea.l SP,A0
            move    SR,-(SP)
            move    #$2700,SR
            _InsTime
            move.l  D7,D6
            move.l  D7,D0
            neg.l   D0
            _PrimeTime
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D7
            movea.l SP,A0
            _InsTime
            move    SR,-(SP)
            move    #$2700,SR
            move.l  D6,D0
            neg.l   D0
            _PrimeTime
            move.w  TimeDBRA,D0
.L6:
            dbra    D0,.L6
            move.w  TimeDBRA,D0
.L7:
            dbra    D0,.L7
            move.w  TimeDBRA,D0
.L8:
            dbra    D0,.L8
            move.w  TimeDBRA,D0
.L9:
            dbra    D0,.L9
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D6
            sub.l   D7,D6
            cmp.l   D6,D5
            bcs.b   .L10
            move.l  D6,D5
.L10:
            dbra    D4,.L5
            move.w  TimeDBRA,D1
            mulu.w  #$FA0,D1
            divu.w  D5,D1
            move.w  D1,D0
            movem.l (SP)+,D4-D7
            adda.w  #$E,SP
            movem.l (SP)+,D1-D7/A1
            rts
sub_408DD3D4:
            movem.l D1-D7/A1,-(SP)
            lea     sub_408DD3D4,A1
            movea.l ROMBase,A0
            cmpi.b  #$75,(9,A0)
            bcs.b   .L2
            move.l  A0,D0
            _StripAddress
            cmpa.l  D0,A1
            bcs.b   .L1
            movea.l D0,A0
            add.l   ($40,A0),D0
            cmpa.l  D0,A1
            bcs.b   .L2
.L1:
            suba.w  #$E,SP
            movea.l SP,A0
            clr.l   ($A,A0)
            move.w  #$FFFF,(4,A0)
            _InsTime
            move.b  (4,A0),D0
            bpl.b   .L3
            _RmvTime
            adda.w  #$E,SP
.L2:
            move.w  TimeSCCDB,D0
            movem.l (SP)+,D1-D7/A1
            rts
.L3:
            _RmvTime
            adda.w  #$E,SP
            movem.l D4-D7,-(SP)
            moveq   #6,D0
.L4:
            clr.w   -(SP)
            dbra    D0,.L4
            moveq   #9,D4
            move.l  #$FFFF,D5
.L5:
            move.l  #$3938700,D7
            movea.l SP,A0
            move    SR,-(SP)
            move    #$2700,SR
            _InsTime
            move.l  D7,D6
            move.l  D7,D0
            neg.l   D0
            _PrimeTime
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D7
            movea.l SP,A0
            _InsTime
            move    SR,-(SP)
            move    #$2700,SR
            move.l  D6,D0
            neg.l   D0
            _PrimeTime
            move.w  TimeSCCDB,D0
            movea.l SCCRd,A1
.L6:
            btst    #0,(A1)
            dbra    D0,.L6
            move.w  TimeSCCDB,D0
.L7:
            btst    #0,(A1)
            dbra    D0,.L7
            move.w  TimeSCCDB,D0
.L8:
            btst    #0,(A1)
            dbra    D0,.L8
            move.w  TimeSCCDB,D0
.L9:
            btst    #0,(A1)
            dbra    D0,.L9
            _RmvTime
            move    (SP)+,SR
            add.l   ($A,A0),D6
            sub.l   D7,D6
            cmp.l   D6,D5
            bcs.b   .L10
            move.l  D6,D5
.L10:
            dbra    D4,.L5
            move.w  TimeSCCDB,D1
            mulu.w  #$FA0,D1
            divu.w  D5,D1
            move.w  D1,D0
            movem.l (SP)+,D4-D7
            adda.w  #$E,SP
            movem.l (SP)+,D1-D7/A1
            rts
            dc.w    $4D50
RsrcEntryltlk_1:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'ltlk' 1 "LTLK" (1732 bytes) - Combo mask
            dc.l    RsrcEntryltlk_0-BaseOfROM       ; Next entry
            dc.l    Rsrcltlk_1-BaseOfROM            ; Data
            dc.b    'ltlk'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'LTLK'                        ; Name
            dc.b    'ter, Inc'
            dc.l    $C0A00000,$000006D0,$00000244   ; Block header
Rsrcltlk_1:
            bra.b   .L1
            dc.b    $60,$00,$01,$1A,$00,$08,$38,$01,$80,$00,$00,$00,$08
            dc.b    '56.0.1  '
            dc.b    $00,$3E
            dc.b    'IOP LocalTalk ltlk v56.0.1  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00
.L1:
            movea.l ExpandMem,A3
            movea.l ($70,A3),A3
            tst.b   D0
            bne.b   sub_408DD5B2.L2
            movem.l D2/A0-A2,($2EE,A3)
            move.w  ($308,A3),($58C,A3)
            moveq   #0,D1
.L2:
            move.w  (A1)+,D2
            beq.b   .L3
            add.w   D2,D1
            move.w  D2,($586,A3)
            move.l  (A1)+,($588,A3)
            lea     ($584,A3),A0
            _IOPMoveData
            add.w   D2,($58C,A3)
            bra.b   .L2
.L3:
            move.b  #3,($590,A3)
            move.w  D1,($591,A3)
            move.w  #$310,($575,A3)
            lea     sub_408DD5B2,A0
            move.l  A0,($580,A3)
            lea     ($56C,A3),A0
            _IOPMsgRequest
            movem.l ($2EE,A3),D2/A0-A2
            rts
sub_408DD5B2:
            movea.l ExpandMem,A3
            movea.l ($70,A3),A3
            tst.b   ($590,A3)
            bne.b   .L1
            moveq   #0,D0
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
.L1:
            moveq   #-1,D0
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
.L2:
            movem.l D2/A0-A2,($2EE,A3)
            move.b  #2,($590,A3)
            move.b  D2,($591,A3)
            move.w  #$210,($575,A3)
            clr.l   ($580,A3)
            lea     ($56C,A3),A0
            _IOPMsgRequest
.L3:
            tst.b   ($577,A3)
            bne.b   .L3
            tst.b   ($590,A3)
            bne.b   .L4
            movem.l ($2EE,A3),D2/A0-A2
            move.l  A2,($2EA,A3)
            jmp     (A0)
.L4:
            moveq   #5,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movem.l ($2EE,A3),D2/A0-A2
            jmp     (A0)
            cmpi.w  #8,D0
            bhi.b   .L6
            lsl.w   #1,D0
            move.w  .L5(PC,D0.w),D0
            jmp     .L5(PC,D0.w)
.L5:
            dc.w    .L6-.L5
            dc.w    .L7-.L5
            dc.w    sub_408DD784.L3-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L6-.L5
            dc.w    .L8-.L5
            dc.w    sub_408DD784.L2-.L5
.L6:
            moveq   #-1,D0
            rts
.L7:
            movem.l D1/D4,-(SP)
            lea     Rsrcltlk_1,A0
            _RecoverHandle
            move.l  A0,-(SP)
            _DetachResource
            movem.l (SP)+,D1/D4
            clr.w   D0
            rts
.L8:
            movem.l D1-D3/A0-A3,-(SP)
            bsr.w   sub_408DD946
            bne.w   .L17
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            move.w  #$100,($584,A2)
            clr.w   ($5B8,A2)
            move.l  #$103,($572,A2)
            move.l  #$1010200,($590,A2)
            move.b  #$10,($576,A2)
            lea     ($590,A2),A0
            move.l  A0,($57C,A2)
            move.l  A0,($578,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L9:
            tst.b   ($577,A2)
            bne.b   .L9
            tst.b   ($590,A2)
            bne.w   .L16
            move.w  #$7F,D0
            bsr.w   sub_408DD784
            tst.l   A0
            beq.w   .L14
            move.w  D1,($586,A2)
            move.l  (A0),($588,A2)
            move.w  #$56AA,($58C,A2)
            lea     ($584,A2),A0
            _IOPMoveData
            move.w  #$301,($590,A2)
            move.w  #$210,($575,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L10:
            tst.b   ($577,A2)
            bne.b   .L10
            tst.b   ($590,A2)
            bne.b   .L14
            move.b  #5,($574,A2)
            move.w  #$210,($575,A2)
            move.b  ($BFE).w,D0
            btst    #1,D0
            beq.b   .L11
            move.w  #$180,($590,A2)
            bra.b   .L12
.L11:
            move.w  #$100,($590,A2)
.L12:
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L13:
            tst.b   ($577,A2)
            bne.b   .L13
            tst.b   ($590,A2)
            bne.b   .L14
            move.w  ($591,A2),($308,A2)
            move.l  #$20510,($5A6,A2)
            move.b  #4,($5AA,A2)
            lea     ($5C4,A2),A0
            move.l  A0,($5AC,A2)
            move.l  A0,($5B0,A2)
            lea     sub_408DD7F8,A0
            move.l  A0,($5B4,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            movem.l (SP)+,D1-D3/A0-A3
            clr.w   D0
            rts
.L14:
            move.l  #$1021000,($574,A2)
            move.w  #$201,($590,A2)
            clr.l   ($580,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L15:
            tst.b   ($577,A2)
            bne.b   .L15
.L16:
            bsr.w   sub_408DD938
.L17:
            movem.l (SP)+,D1-D3/A0-A3
            moveq   #-1,D0
            rts
sub_408DD784:
            subq.w  #4,SP
            move.l  #'iopc',-(SP)
            move.w  D0,-(SP)
            bsr.w   sub_408DD962
            movea.l (SP),A0
            move.l  A0,D0
            beq.b   .L1
            _GetHandleSize
            move.l  D0,D1
.L1:
            movea.l (SP)+,A0
            rts
.L2:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            bsr.b   sub_408DD7C8
            rts
.L3:
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            bsr.b   sub_408DD7C8
            moveq   #3,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movea.l A2,A0
            _DisposPtr
            moveq   #0,D0
            rts
sub_408DD7C8:
            bsr.w   sub_408DD938
            move.b  #3,($5A7,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            move.l  #$1021000,($574,A2)
            move.w  #$201,($590,A2)
            clr.l   ($580,A2)
            lea     ($56C,A2),A0
            _IOPMsgRequest
.L1:
            tst.b   ($577,A2)
            bne.b   .L1
            rts
sub_408DD7F8:
            movea.l ExpandMem,A3
            movea.l ($70,A3),A3
            move    SR,($2C0,A3)
            move    #$2600,SR
            movem.l A4-A5,($2FE,A3)
            move.w  ($5C7,A3),D0
            subq.w  #2,D0
            move.w  D0,($5BA,A3)
            lea     ($30E,A3),A0
            move.l  A0,($5BC,A3)
            move.w  ($5C5,A3),($5C0,A3)
            lea     ($5B8,A3),A0
            _IOPMoveData
            movea.l ($2EA,A3),A2
            lea     (1,A2),A0
            lea     ($30E,A3),A1
            move.l  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.l  A1,($30A,A3)
            move.w  ($5C7,A3),D1
            subq.w  #5,D1
            move.w  (4,A2),D2
            andi.w  #$3FF,D2
            cmp.w   D2,D1
            beq.b   .L1
            addq.l  #1,($706,A3)
            bra.b   .L2
.L1:
            subq.w  #2,D1
            move.w  D1,($306,A3)
            movea.l A0,A3
            lea     .L3,A4
            move.b  (3,A2),D2
            moveq   #1,D0
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            movea.l ExpandMem,A3
            movea.l ($70,A3),A3
            addq.l  #1,($702,A3)
.L2:
            move    ($2C0,A3),SR
            move.b  #1,($5A7,A3)
            clr.b   ($5C4,A2)
            lea     ($5A0,A3),A0
            _IOPMsgRequest
            movem.l ($2FE,A3),A4-A5
            rts
.L3:
            bra.b   .L10
            bra.b   .L11
.L10:
            movem.l A0-A1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($70,A0),A0
            cmp.w   ($306,A0),D3
            bgt.b   .L6
            sub.w   D3,($306,A0)
            movea.l ($30A,A0),A1
            bra.b   .L5
.L4:
            move.b  (A1)+,(A3)+
.L5:
            dbra    D3,.L4
            move.l  A1,($30A,A0)
            move.w  ($306,A0),D1
            moveq   #0,D0
            moveq   #0,D3
            movem.l (SP)+,A0-A1
            rts
.L6:
            move    ($2C0,A0),SR
            movem.l ($2FE,A0),A4-A5
            movem.l (SP)+,A0-A1
            move.b  #$FF,D0
            rts
.L11:
            movem.l A0-A2,-(SP)
            movea.l ExpandMem,A2
            movea.l ($70,A2),A2
            tst.w   D3
            beq.b   .L9
            tst.w   ($306,A2)
            beq.b   .L9
            movea.l ($30A,A2),A1
            move.w  ($306,A2),D0
            cmp.w   D0,D3
            bge.b   .L8
            move.w  D3,D0
            bra.b   .L8
.L7:
            move.b  (A1)+,(A3)+
.L8:
            dbra    D0,.L7
.L9:
            move    ($2C0,A2),SR
            move.b  #1,($5A7,A2)
            clr.b   ($5C4,A2)
            lea     ($5A0,A2),A0
            _IOPMsgRequest
            sub.w   ($306,A2),D3
            movem.l ($2FE,A2),A4-A5
            movem.l (SP)+,A0-A2
            moveq   #0,D0
            rts
sub_408DD938:
            moveq   #$12,D0
            moveq   #1,D1
            movea.l LAPMgrPtr,A1
            jsr     (2,A1)
            rts
sub_408DD946:
            movem.l D1/A1,-(SP)
            movea.l LAPMgrPtr,A1
            moveq   #$11,D0
            moveq   #1,D1
            jsr     (2,A1)
            movem.l (SP)+,D1/A1
            bne.b   .L1
            moveq   #0,D0
.L1:
            tst.w   D0
            rts
sub_408DD962:
            link.w  A6,#-2
            movem.l D1-D4/A1-A3,-(SP)
            move.w  CurMap,(-2,A6)
            moveq   #0,D3
            moveq   #0,D4
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _Get1Resource
            movea.l (SP)+,A2
            tst.w   ResErr
            beq.b   .L1
            suba.l  A2,A2
.L1:
            move.w  SysMap,CurMap
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _Get1Resource
            movea.l (SP)+,A3
            tst.w   ResErr
            beq.b   .L2
            suba.l  A3,A3
.L2:
            subq.w  #4,SP
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            move.l  ($A,A6),-(SP)
            bsr.w   sub_408DDA16
            movea.l (SP)+,A2
            move.l  D0,D3
            move.w  (-2,A6),CurMap
            clr.l   -(SP)
            move.l  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            _GetResource
            movea.l (SP)+,A3
            tst.w   ResErr
            beq.b   .L3
            suba.l  A3,A3
.L3:
            subq.w  #4,SP
            movem.l A2-A3,-(SP)
            move.l  ($A,A6),-(SP)
            bsr.w   sub_408DDA16
            movea.l (SP)+,A2
            move.l  D0,D3
            clr.w   ResErr
            move.l  A2,($E,A6)
            bne.b   .L4
            move.w  #$FF40,ResErr
.L4:
            movea.l A2,A0
            move.l  D3,D0
            movem.l (SP)+,D1-D4/A1-A3
            move.l  (4,A6),($A,A6)
            unlk    A6
            addq.w  #6,SP
            rts
sub_408DDA16:
            link.w  A6,#0
            movem.l D1-D4/A1-A3,-(SP)
            movea.l ($10,A6),A2
            movea.l ($C,A6),A3
            subq.w  #4,SP
            move.l  A2,-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   sub_408DDA8E
            move.l  (SP)+,D3
            cmpi.w  #$8000,D3
            bne.b   .L1
            move.b  #$FF,D3
.L1:
            subq.w  #4,SP
            move.l  A3,-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   sub_408DDA8E
            move.l  (SP)+,D4
            cmpi.w  #$8000,D4
            bne.b   .L2
            move.b  #$FF,D4
.L2:
            cmp.l   D3,D4
            bcs.b   .L3
            exg     A2,A3
            exg     D3,D4
.L3:
            cmpa.l  A2,A3
            beq.b   .L4
            cmpa.w  #0,A3
            beq.b   .L4
            move.l  A3,-(SP)
            _ReleaseResource
.L4:
            move.l  A2,($14,A6)
            movea.l A2,A0
            cmpi.w  #$80FF,D3
            bne.b   .L5
            clr.b   D3
.L5:
            move.l  D3,D0
            movem.l (SP)+,D1-D4/A1-A3
            move.l  (4,A6),($10,A6)
            unlk    A6
            lea     ($C,SP),SP
            rts
sub_408DDA8E:
            link.w  A6,#0
            movem.l D1-D5/A1-A2,-(SP)
            tst.l   ($C,A6)
            beq.w   .L4
            movea.l ($C,A6),A0
            move.l  (A0),D5
            beq.w   .L4
            movea.l ($C,A6),A0
            _GetHandleSize
            move.l  D0,D2
            bmi.b   .L4
            movea.l D5,A2
            cmpi.l  #'DRVR',(8,A6)
            beq.b   .L1
            cmpi.l  #8,D2
            bls.b   .L4
            move.w  (6,A2),D4
            adda.w  D4,A2
            addi.l  #$B,D4
            cmp.l   D4,D2
            bls.b   .L4
            move.l  (A2),D3
            clr.w   -(SP)
            move.l  A2,-(SP)
            bsr.w   sub_408DDB3E
            tst.w   (SP)+
            bne.b   .L5
            bra.b   .L4
.L1:
            move.w  #$12,D4
            cmp.l   D4,D2
            bls.b   .L4
            moveq   #0,D0
            move.b  (0,A2,D4.w),D0
            addq.w  #1,D0
            btst    #0,D0
            beq.b   .L2
            addq.w  #1,D0
            add.w   D0,D4
.L2:
            adda.w  D4,A2
            addi.l  #$B,D4
            cmp.l   D4,D2
            bls.b   .L4
            move.l  (A2),D3
            clr.w   -(SP)
            move.l  A2,-(SP)
            bsr.w   sub_408DDB3E
            tst.w   (SP)+
            bne.b   .L3
            move.w  (A2),D3
            clr.b   D3
            swap    D3
            move.w  #$8000,D3
.L3:
            bra.b   .L5
.L4:
            moveq   #0,D3
.L5:
            move.l  D3,($10,A6)
            move.l  D3,D0
            movem.l (SP)+,D1-D5/A1-A2
            move.l  (4,A6),($C,A6)
            unlk    A6
            addq.w  #8,SP
            rts
sub_408DDB3E:
            link.w  A6,#-$10
            movem.l D1-D4/A1-A2,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            movea.l (8,A6),A2
            move.l  (A2),D3
            lea     (-$10,A6),A0
            move.l  D3,D0
            swap    D0
            lsr.w   #8,D0
            andi.l  #$FF,D0
            clr.w   -(SP)
            _DECSTR68K
            moveq   #0,D0
            move.b  (A0)+,D0
            adda.w  D0,A0
            move.l  D3,D0
            swap    D0
            lsr.w   #4,D0
            andi.l  #$F,D0
            clr.w   -(SP)
            _DECSTR68K
            lea     (-$10,A6),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.w  #1,D0
            move.b  #$2E,(0,A0,D0.w)
            move.l  (A0),D0
            andi.l  #$FFFFFF,D0
            lea     (6,A2),A0
            move.l  (A0),D1
            andi.l  #$FFFFFF,D1
            cmp.l   D0,D1
            beq.b   .L2
.L1:
            moveq   #0,D0
            bra.b   .L3
.L2:
            moveq   #1,D0
.L3:
            move.w  D0,($C,A6)
            movem.l (SP)+,D1-D4/A1-A2
            move.l  (4,A6),(8,A6)
            unlk    A6
            addq.w  #4,SP
            rts
            dc.w    $544F
RsrcEntrylmgr_0:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'lmgr' 0 "Main" (2868 bytes) - Combo mask
            dc.l    RsrcEntryltlk_1-BaseOfROM       ; Next entry
            dc.l    Rsrclmgr_0-BaseOfROM            ; Data
            dc.b    'lmgr'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            dc.b    ' Apple C'
            dc.l    $C0A00000,$00000B40,$0000023C   ; Block header
Rsrclmgr_0:
            bra.b   .L1
            ds.b    5
            dc.b    $08,$38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$30
            dc.b    'lmgr v56.0.2  ; '
            dc.b    $A9,$20
            dc.b    'Apple Computer, Inc. 1984-1991'
            dc.b    $00
.L1:
            link.w  A6,#-$A
            clr.w   (-2,A6)
            clr.l   (-6,A6)
            movea.l ($358).w,A0
            cmpi.w  #$FFD6,($4A,A0)
            bne.b   .L2
            move.w  #1,(-2,A6)
.L2:
            tst.w   ROM85
            bmi.w   sub_408DDD56.L6
            suba.w  #$10,SP
            movea.l SP,A0
            move.w  #1,D0
            _SysEnvirons
            cmpi.w  #$604,(4,A0)
            lea     ($10,SP),SP
            bcs.w   sub_408DDD56.L6
            tst.w   (-2,A6)
            beq.w   sub_408DDD56.L1
            bsr.w   sub_408DE250
            bne.w   sub_408DDD56.L6
            bsr.w   sub_408DE358
            bsr.w   sub_408DDF3E
            clr.l   -(SP)
            move.l  #'STR#',-(SP)
            move.w  #$BFE8,-(SP)
            _GetResource
            suba.w  #$20,SP
            pea     (SP)
            move.w  #$BFEC,-(SP)
            move.w  #1,-(SP)
            jsr     sub_408DE62E
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #$F7,($1A,A0)
            move.w  #$FFD7,($18,A0)
            _Control
            movea.l ($D1C).w,A1
            movea.l (A1),A2
            movea.l (A2),A1
            _Close
            clr.l   (4,A2)
            exg     A1,A0
            _DisposPtr
            exg     A1,A0
            move.w  #$FFF6,($18,A0)
            _Close
            movea.l A0,A2
            moveq   #4,D0
            movea.l LAPMgrPtr,A0
            jsr     (2,A0)
            move.l  A0,-(SP)
            moveq   #2,D0
            jsr     (2,A0)
            movea.l (SP)+,A0
            _RecoverHandle
            tst.w   MemErr
            bne.b   .L3
            _DisposHandle
.L3:
            move.w  SysVersion,D0
            cmpi.w  #$700,D0
            bcc.b   .L4
            clr.l   -(SP)
            move.l  #'INIT',-(SP)
            move.w  #$16,-(SP)
            _GetResource
.L4:
            st      PortBUse
            moveq   #-$B,D0
            _DrvrRemove
            moveq   #-$A,D0
            _DrvrRemove
            moveq   #-$29,D0
            _DrvrRemove
            movea.l ExpandMem,A1
            movea.l ($74,A1),A0
            _DisposPtr
            move.l  MinusOne,LAPMgrPtr
            move.l  (-6,A6),D0
            move.l  A2,(-$A,A6)
            pea     sub_408DDD56
            link.w  A6,#-$A
            move.w  #2,(-2,A6)
            move.l  D0,(-6,A6)
            bra.b   sub_408DDD56.L1
sub_408DDD56:
            move.w  #$A090,D0
            _GetOSTrapAddress
            move.l  A0,-(SP)
            move.w  #$A090,D0
            lea     sub_408DE34E,A0
            _SetOSTrapAddress
            movea.l (-$A,A6),A0
            pea     sub_408DE398.L5
            move.l  (SP)+,($12,A0)
            clr.b   ($1B,A0)
            _Open
            movea.l (SP)+,A0
            move.w  #$A090,D0
            _SetOSTrapAddress
            bsr.w   sub_408DDE36
            bra.w   .L6
.L1:
            bsr.w   sub_408DE250
            bne.w   .L6
            bsr.w   sub_408DE358
            moveq   #1,D2
            moveq   #$10,D0
            cmpi.b  #$7F,D1
            bne.b   .L2
            moveq   #8,D2
            mulu.w  D2,D0
.L2:
            addi.w  #$30A,D0
            _NewPtrSysClear
            bne.w   .L6
            move.w  D2,(A0)
            movea.l ExpandMem,A1
            lea     ($74,A1),A1
            move.l  A0,(A1)
            move.l  D1,-(SP)
            bsr.w   sub_408DE312
            movea.l ExpandMem,A0
            movea.l ($74,A0),A0
            lea     LAPMgrPtr,A1
            movea.l UTableBase,A2
            moveq   #$24,D1
            movea.l (0,A2,D1.w),A2
            movea.l (A2),A2
            movea.l (A2),A2
            move.w  (8,A2),D1
            move.w  (-2,A2,D1.w),D1
            lea     (0,A2,D1.w),A3
            move.l  A3,D0
            _StripAddress
            move.l  D0,(A1)
            moveq   #$10,D0
            jsr     (2,A3)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            pea     (6,A3)
            move.w  #$BFEC,-(SP)
            move.w  #1,-(SP)
            jsr     sub_408DE62E
            move.l  (SP)+,D1
            tst.b   D1
            bne.b   .L3
            bsr.w   InstallPrintAtlk_lmgr_0
            bra.b   .L4
.L3:
            bsr.w   sub_408DDF3E
.L4:
            lea     ($30A,A3),A3
            tst.l   (8,A3)
            bne.b   .L5
            bset    #5,(6,A3)
.L5:
            tst.w   (-2,A6)
            bne.b   .L6
            bsr.b   sub_408DDE36
.L6:
            unlk    A6
            rts
sub_408DDE36:
            move.w  ResLoad,-(SP)
            clr.w   ResLoad
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            pea     sub_408DE398.L4
            _GetNamedResource
            move.l  (SP)+,D0
            beq.b   .L1
            move.l  D0,-(SP)
            subq.w  #2,SP
            move.l  D0,-(SP)
            _GetResAttrs
            bset    #4,(1,SP)
            _SetResAttrs
.L1:
            move.w  (SP)+,ResLoad
            bsr.b   sub_408DDE68
            rts
sub_408DDE68:
            link.w  A6,#-$16E
            movem.l D1-D4/A1-A2,-(SP)
            move.w  ResLoad,(-2,A6)
            clr.w   -(SP)
            move.l  #'AINI',-(SP)
            _CountResources
            move.w  (SP)+,D3
            beq.w   .L9
            moveq   #0,D4
            clr.w   ResLoad
            clr.w   (-4,A6)
.L1:
            clr.l   -(SP)
            move.l  #'AINI',-(SP)
            move.w  D3,-(SP)
            _GetIndResource
            move.l  (SP)+,D0
            beq.b   .L2
            move.l  D0,-(SP)
            pea     (-$68,A6,D4.w)
            pea     (-$6E,A6)
            pea     (-$16E,A6)
            _GetResInfo
            addq.w  #2,D4
            addq.w  #1,(-4,A6)
            cmpi.w  #$32,(-4,A6)
            bge.b   .L3
.L2:
            subq.w  #1,D3
            bne.b   .L1
            move.w  (-2,A6),ResLoad
.L3:
            move.w  (-4,A6),D4
            beq.b   .L9
            subq.w  #1,D4
            moveq   #0,D2
.L4:
            move.w  D4,D2
            add.w   D2,D2
            move.w  D4,D3
            move.w  (-$68,A6,D2.w),D0
.L5:
            move.w  D3,D1
            add.w   D1,D1
            cmp.w   (-$68,A6,D1.w),D0
            bge.b   .L6
            move.w  (-$68,A6,D1.w),(-$68,A6,D2.w)
            move.w  D0,(-$68,A6,D1.w)
            move.w  (-$68,A6,D2.w),D0
.L6:
            subq.w  #1,D3
            bge.b   .L5
            subq.w  #1,D4
            bge.b   .L4
            move.w  (-4,A6),D4
            add.w   D4,D4
            moveq   #0,D3
.L7:
            clr.l   -(SP)
            move.l  #'AINI',-(SP)
            move.w  (-$68,A6,D3.w),-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L8
            movea.l D0,A0
            _HLock
            movem.l D1-D7/A0-A4,-(SP)
            movea.l (A0),A0
            jsr     (A0)
            movem.l (SP)+,D1-D7/A0-A4
.L8:
            addq.w  #2,D3
            cmp.w   D3,D4
            bgt.b   .L7
.L9:
            movem.l (SP)+,D1-D4/A1-A2
            move.l  (4,A6),(4,A6)
            unlk    A6
            lea     0.w(SP),SP
            rts
sub_408DDF3E:
            move.l  D4,-(SP)
            cmpi.b  #$7F,D1
            beq.b   sub_408DDF8E.L1
            moveq   #-1,D4
            bsr.w   sub_408DE18A
            move.l  D1,($312,A3)
            tst.w   D0
            beq.b   .L3
            move.w  #$BFEA,D3
            tst.w   D2
            bne.b   .L1
            move.w  #$BFE9,D3
.L1:
            bsr.b   sub_408DDF8E
.L2:
            bsr.b   sub_408DDF72
            subq.w  #2,SP
            move.w  D3,-(SP)
            clr.l   -(SP)
            _CautionAlert
            addq.w  #2,SP
.L3:
            move.l  (SP)+,D4
            rts
sub_408DDF72:
            moveq   #0,D1
            bsr.w   WritePRAM_lmgr_0
            bsr.w   InstallPrintAtlk_lmgr_0
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            clr.l   ($312,A3)
            move.w  #1,(A3)
            rts
sub_408DDF8E:
            _InitFonts
            _InitWindows
            _TEInit
            clr.l   -(SP)
            _InitDialogs
            clr.l   DeskHook
            rts
.L1:
            moveq   #-1,D4
.L2:
            subq.w  #2,SP
            pea     (6,A3)
            _OpenResFile
            move.w  (SP)+,D2
            moveq   #4,D3
            tst.w   ResErr
            bne.w   .L8
            addq.w  #1,D4
            cmpi.w  #8,D4
            beq.b   .L4
            subq.w  #4,SP
            move.l  #'port',-(SP)
            move.w  D4,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L4
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),D1
            move.w  D2,-(SP)
            _CloseResFile
            bsr.w   sub_408DE18A
            tst.w   D0
            beq.b   .L3
            bsr.w   sub_408DE0BA
            bra.w   .L7
.L3:
            bsr.w   sub_408DE384
            move.l  D1,(8,A3,D0.w)
            bra.b   .L2
.L4:
            move.w  D4,(A3)
            lea     (6,A3),A1
            subq.w  #4,SP
            move.l  #'brdg',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D0
            bne.b   .L5
            move.w  D2,-(SP)
            _CloseResFile
            bsr.w   sub_408DE0BA
            moveq   #5,D3
            bra.b   .L8
.L5:
            move.w  D2,-(SP)
            movea.l D0,A2
            bsr.w   sub_408DDF8E
            movea.l (A2),A0
            movem.l D4-D7/A3-A6,-(SP)
            jsr     (A0)
            movem.l (SP)+,D4-D7/A3-A6
            move.w  D0,D2
            _CloseResFile
            tst.w   D2
            beq.b   .L6
            bsr.w   sub_408DE0BA
            bsr.w   sub_408DDF72
            bra.w   sub_408DDF3E.L3
.L6:
            suba.w  #$7A,SP
            movea.l SP,A0
            move.w  BootDrive,($16,A0)
            clr.w   ($1C,A0)
            clr.l   ($12,A0)
            _HGetVInfo
            move.l  ($5A,A0),($30,A0)
            move.l  #'brdg',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            move.w  ($16,A0),(2,A3)
            lea     (6,A3),A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            clr.l   ($1C,A0)
            _Open
            move.w  ($18,A0),(4,A3)
            lea     ($7A,SP),SP
            bra.w   sub_408DDF3E.L3
.L7:
            moveq   #3,D3
            tst.w   D2
            bne.b   .L8
            moveq   #2,D3
.L8:
            bsr.w   sub_408DDF8E
            suba.w  #$100,SP
            move.l  SP,-(SP)
            move.w  #$BFEC,-(SP)
            move.w  D3,-(SP)
            jsr     sub_408DE62E
            move.l  SP,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            _ParamText
            lea     ($100,SP),SP
            move.w  #$BFEB,D3
            bra.w   sub_408DDF3E.L2
sub_408DE0BA:
            st      PortBUse
            move.l  D1,-(SP)
            move.w  D4,D3
            moveq   #-1,D4
.L1:
            addq.w  #1,D4
            cmp.w   D4,D3
            beq.b   .L3
            bsr.w   sub_408DE384
            tst.l   (0,A3,D0.w)
            beq.b   .L1
            movea.l (0,A3,D0.w),A0
            bsr.b   sub_408DE108
            move.l  A0,-(SP)
            move.l  #'rom ',D0
            _Gestalt
            move.l  A0,D1
            movea.l (SP)+,A0
            move.l  A0,D0
            _StripAddress
            movea.l D0,A0
            move.l  ROMBase,D0
            _StripAddress
            cmpa.l  D0,A0
            bcs.b   .L2
            add.l   D0,D1
            cmpa.l  D1,A0
            bcs.b   .L3
.L2:
            _RecoverHandle sys
            _DisposHandle
            bra.b   .L1
.L3:
            move.l  (SP)+,D1
            rts
sub_408DE108:
            movem.l D0-D3/A0-A3,-(SP)
            moveq   #2,D0
            jsr     (2,A0)
            movem.l (SP)+,D0-D3/A0-A3
            rts
InstallPrintAtlk_lmgr_0:
            move.w  #1,D0
            bsr.b   sub_408DE134
            move.l  A0,D0
            beq.b   .L1
            move.l  #$53432020,D1
            move.w  #$101,D1
            move.w  #$FFFF,D4
            bsr.b   sub_408DE15C
.L1:
            rts
sub_408DE134:
            move.l  D2,-(SP)
            move.w  CurMap,-(SP)
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.w  (SP)+,CurMap
            move.l  (SP)+,D2
            rts
sub_408DE15C:
            tst.w   (-2,A6)
            beq.b   .L1
            cmpi.w  #2,(-2,A6)
            beq.b   .L1
            moveq   #0,D0
            rts
.L1:
            movem.l D2-D4/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A0),A0
            tst.w   D4
            bpl.b   .L2
            moveq   #0,D4
.L2:
            moveq   #1,D0
            jsr     (2,A0)
            movem.l (SP)+,D2-D4/A0/A2-A3
            tst.w   D0
            rts
sub_408DE18A:
            moveq   #0,D2
            clr.w   D0
            move.b  D1,D0
            bsr.b   sub_408DE134
            move.l  A0,D0
            beq.b   .L4
            move.l  D1,D3
            bsr.b   sub_408DE15C
            beq.b   .L2
.L1:
            move.w  D0,D2
            bra.b   .L7
.L2:
            bsr.w   CheckPramVal_lmgr_0
            bne.b   .L1
            cmp.l   D1,D3
            beq.b   .L3
            bsr.w   WritePRAM_lmgr_0
.L3:
            moveq   #0,D0
            bra.b   .L7
.L4:
            move.l  (-6,A6),D0
            beq.b   .L5
            move.l  D0,-(SP)
            bra.b   .L9
.L5:
            suba.w  #$20,SP
            movea.l SP,A1
            bsr.w   sub_408DE398
            tst.w   D0
            beq.b   .L8
            moveq   #0,D2
.L6:
            lea     ($20,SP),SP
.L7:
            tst.w   D0
            rts
.L8:
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D1,-(SP)
            clr.b   (SP)
            _GetResource
            tst.l   (SP)
            bne.b   .L9
            addq.w  #4,SP
            move.w  D2,-(SP)
            move.w  ResErr,D2
            _CloseResFile
            move.w  D2,D0
            moveq   #0,D2
            bra.b   .L6
.L9:
            movea.l (SP)+,A0
            move.l  D1,D3
            bsr.w   sub_408DE15C
            bne.b   .L12
            bsr.b   CheckPramVal_lmgr_0
            bne.b   .L12
            move.l  A0,-(SP)
            cmp.l   D1,D3
            beq.b   .L10
            bsr.w   WritePRAM_lmgr_0
.L10:
            tst.w   (-2,A6)
            beq.b   .L11
            cmpi.w  #2,(-2,A6)
            beq.b   .L11
            move.l  (SP)+,(-6,A6)
            moveq   #0,D0
            bra.b   .L6
.L11:
            _DetachResource
            moveq   #0,D0
.L12:
            tst.l   (-6,A6)
            bne.b   .L6
            move.w  D2,-(SP)
            move.w  D0,D2
            _CloseResFile
            move.w  D2,D0
            bra.b   .L6
CheckPramVal_lmgr_0:
            moveq   #0,D0
            move.b  D3,D1
            tst.w   D4
            bmi.b   .L1
            cmp.l   D1,D3
            beq.b   .L1
            movea.l (A0),A0
            bsr.w   sub_408DE108
            moveq   #-1,D0
.L1:
            tst.w   D0
            rts
sub_408DE250:
            move.b  #$38,D2
            moveq   #-$B,D3
            bsr.b   sub_408DE26E
            bne.b   .L1
            moveq   #-$A,D3
            bsr.b   sub_408DE26E
            bne.b   .L1
            moveq   #0,D2
            moveq   #-$29,D3
            bsr.b   sub_408DE26E
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
sub_408DE26E:
            clr.l   -(SP)
            move.l  #'DRVR',-(SP)
            move.w  D3,-(SP)
            not.w   (SP)
            _Get1Resource
            move.w  CurMap,-(SP)
            move.w  #1,CurMap
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            move.w  D3,-(SP)
            not.w   (SP)
            _Get1Resource
            movea.l (SP)+,A0
            move.w  (SP)+,CurMap
            move.l  A0,-(SP)
            move.l  A0,D0
            beq.b   .L1
            movea.l (A0),A1
            cmp.b   ($18,A1),D2
            bls.b   .L4
.L1:
            tst.l   (4,SP)
            beq.b   .L2
            movea.l (4,SP),A1
            movea.l (A1),A1
            cmp.b   ($18,A1),D2
            bls.b   .L3
.L2:
            addq.w  #8,SP
            moveq   #-1,D0
            rts
.L3:
            addq.w  #4,SP
            bra.b   .L6
.L4:
            move.l  (4,SP),D0
            beq.b   .L5
            move.l  D0,-(SP)
            _ReleaseResource
.L5:
            move.l  (SP)+,(SP)
.L6:
            tst.w   (-2,A6)
            beq.b   .L7
            cmpi.w  #2,(-2,A6)
            beq.b   .L7
            addq.w  #4,SP
            bra.b   .L8
.L7:
            move.l  (SP),-(SP)
            _DetachResource
            move.w  D3,D0
            _DrvrInstall async
            movea.l UTableBase,A0
            not.w   D3
            lsl.w   #2,D3
            movea.l (0,A0,D3.w),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A1),(A0)
            movea.l (A0),A1
            move.b  (A1),(4,A0)
            bclr    #6,(5,A0)
.L8:
            moveq   #0,D0
            rts
sub_408DE312:
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            clr.l   -(SP)
            move.l  #'STR#',-(SP)
            move.w  #$BFE8,-(SP)
            _GetResource
            move.l  (SP),-(SP)
            _DetachResource
            movea.l (SP)+,A0
            move.l  A0,($1F2,A2)
            movea.l (A0),A0
            moveq   #1,D0
            add.b   (2,A0),D0
            lea     (2,A0,D0.w),A0
            add.b   (A0),D0
            addi.b  #$20,D0
            _NewPtrSysClear
            bne.b   .L1
            move.l  A0,($278,A2)
.L1:
            rts
sub_408DE34E:
            move.w  #$605,(4,A0)
            moveq   #0,D0
            rts
sub_408DE358:
            clr.l   -(SP)
            btst    #$E,HWCfgFlags
            beq.b   .L1
            movea.l SP,A0
            move.l  #$400E0,D0
            _ReadXPRam
.L1:
            move.l  (SP)+,D1
            rts
WritePRAM_lmgr_0:
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            movea.l SP,A0
            move.l  #$400E0,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l (SP)+,A0
            rts
sub_408DE384:
            moveq   #0,D0
            cmp.b   (1,A3),D4
            bcc.b   .L1
            move.b  D4,D0
.L1:
            mulu.w  #$10,D0
            addi.w  #$30A,D0
            rts
sub_408DE398:
            move.w  ResLoad,-(SP)
            clr.w   ResLoad
            movem.l D1/A1,-(SP)
            subq.w  #2,SP
            move.l  #'extn',-(SP)
            bsr.w   sub_408DE672
            move.w  (SP)+,D0
            movem.l (SP)+,D1/A1
            move.w  D0,-(SP)
            suba.w  #$7A,SP
            movea.l SP,A2
            move.w  D0,($16,A2)
            move.l  A1,($12,A2)
            clr.w   ($1C,A2)
            tst.b   D1
            bne.b   .L1
            move.w  D3,($1C,A2)
.L1:
            movea.l A2,A0
            clr.w   ($1A,A0)
            addq.w  #1,($1C,A0)
            _GetFileInfo
            bne.b   .L3
            move.l  ($20,A0),D0
            cmpi.l  #'adev',D0
            bne.b   .L1
            clr.w   -(SP)
            move.l  A1,-(SP)
            move.w  ($16,A0),-(SP)
            clr.b   -(SP)
            _OpenRFPerm
            move.w  (SP)+,D2
            move.w  ResErr,D0
            bne.b   .L1
            tst.b   D1
            beq.b   .L2
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D1,-(SP)
            clr.b   (SP)
            _Get1Resource
            moveq   #0,D0
            tst.l   (SP)+
            bne.b   .L3
            move.w  D2,-(SP)
            _CloseResFile
            bra.b   .L1
.L2:
            move.w  ($1C,A2),D3
.L3:
            lea     ($7A,SP),SP
            movem.l D0-D2,-(SP)
            subq.w  #2,SP
            move.w  ($E,SP),-(SP)
            bsr.w   sub_408DE6E6
            move.w  (SP)+,D0
            movem.l (SP)+,D0-D2
            addq.w  #2,SP
            move.w  (SP)+,ResLoad
            rts
.L4:
            dc.b    14,'.AFPTranslator'
            dc.b    $00,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9,$FF,$A9
            dc.b    $FF,$A9,$FF,$A9,$FF,$A9,$FF
.L5:
            dc.b    4,'.MPP'
            dc.b    $00
sub_408DE62E:
            link.w  A6,#0
            subq.w  #4,SP
            move.l  #'STR#',-(SP)
            move.w  ($A,A6),-(SP)
            _GetResource
            movea.l ($C,A6),A1
            clr.b   (A1)
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (A0)+,D0
            move.w  (8,A6),D1
            cmp.w   D0,D1
            bgt.b   .L3
            moveq   #0,D0
.L1:
            subq.w  #1,D1
            beq.b   .L2
            move.b  (A0)+,D0
            adda.l  D0,A0
            bra.b   .L1
.L2:
            move.b  (A0),D0
            addq.w  #1,D0
            _BlockMove
.L3:
            unlk    A6
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
sub_408DE672:
            link.w  A6,#-$4A
            lea     (-$44,A6),A0
            move.w  #1,D0
            _SysEnvirons
            move.w  (-$40,A6),D1
            cmpi.w  #$700,D1
            bcs.b   .L1
            subq.w  #2,SP
            move.w  #$8000,-(SP)
            move.l  (8,A6),-(SP)
            move.w  #1,-(SP)
            pea     (-$46,A6)
            pea     (-$4A,A6)
            moveq   #0,D0
            _AliasDispatch
            move.w  (SP)+,D0
            moveq   #0,D0
            bne.b   .L2
            lea     (-$34,A6),A0
            move.w  (-$46,A6),($16,A0)
            move.l  (-$4A,A6),($30,A0)
            clr.l   ($12,A0)
            move.l  #'atlk',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            move.w  ($10,A0),D0
            moveq   #0,D0
            bne.b   .L2
            move.w  ($16,A0),D0
            bra.b   .L2
.L1:
            move.w  (-$36,A6),D0
.L2:
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #4,SP
            move.w  D0,(SP)
            jmp     (A0)
sub_408DE6E6:
            link.w  A6,#-$44
            moveq   #0,D0
            lea     (-$44,A6),A0
            move.w  #1,D0
            _SysEnvirons
            move.w  (8,A6),D1
            cmp.w   (-$36,A6),D1
            beq.b   .L1
            lea     (-$34,A6),A0
            move.w  D1,($16,A0)
            moveq   #2,D0
            _HFSDispatch
            move.w  ($10,A0),D0
.L1:
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #2,SP
            move.w  D0,(SP)
            jmp     (A0)
            dc.b    '1989]<'
RsrcEntryINIT_18:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'INIT' 18 "INIT 18" (340 bytes) - Combo mask
            dc.l    RsrcEntrylmgr_0-BaseOfROM       ; Next entry
            dc.l    RsrcINIT_18-BaseOfROM           ; Data
            dc.b    'INIT'                          ; Type
            dc.w    18                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'INIT 18'                     ; Name
            dc.b    $46,$44,$4A,$57,$47
            dc.l    $C0A00000,$00000160,$00000234   ; Block header
RsrcINIT_18:
            bra.b   .L1
            ds.b    5
            dc.b    $08,$38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$33
            dc.b    'INIT 18 v56.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1984-1991'
.L1:
            link.w  A6,#-8
            clr.l   (-4,A6)
            move.l  TheZone,D0
            cmp.l   SysZone,D0
            bne.b   .L2
            move.l  D0,(-4,A6)
.L2:
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  A0,ApplZone
            move.l  (A0),HeapEnd
            move.l  ($10,A0),(-8,A6)
            pea     sub_408DE846
            move.l  (SP)+,($10,A0)
            bsr.b   sub_408DE83A
            clr.l   -(SP)
            move.l  #'lmgr',-(SP)
            clr.w   -(SP)
            _Get1Resource
            move.l  (SP)+,D0
            beq.b   .L3
            move.l  D0,-(SP)
            move.l  (SP),-(SP)
            _DetachResource
            movea.l (SP),A0
            movea.l (A0),A1
            jsr     (A1)
            movea.l (SP)+,A0
            _DisposHandle
.L3:
            bsr.b   sub_408DE83A
            cmpi.w  #$FFFF,D0
            beq.b   .L4
            move.w  D0,-(SP)
            _CloseResFile
.L4:
            movea.l SysZone,A0
            move.l  (-8,A6),($10,A0)
            move.l  (A0),D0
            _StripAddress
            movea.l D0,A1
            move.l  (A1),D1
            andi.l  #$FFFFFF,D1
            pea     (0,A1,D1.l)
            movea.l (SP)+,A0
            _SetAppBase
            _InitApplZone
            move.l  ApplZone,D0
            tst.l   (-4,A6)
            bne.b   .L5
            move.l  D0,TheZone
.L5:
            unlk    A6
            lea     RsrcINIT_18,A0
            _RecoverHandle
            _DisposHandle
            rts
sub_408DE83A:
            clr.w   -(SP)
            pea     sub_408DE846.L2
            _OpenResFile
            move.w  (SP)+,D0
            rts
sub_408DE846:
            move.l  (4,SP),D0
            move.l  A2,-(SP)
            movea.l SysZone,A1
            movea.l (A1),A0
            movea.l A0,A2
            addi.l  #$4000,D0
            lea     (0,A0,D0.l),A0
            move.l  D0,D1
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L1
            move.l  A1,D1
            sub.l   A2,D1
            movea.l A1,A0
.L1:
            _SetAppBase
            _InitApplZone
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  A1,ApplZone
            move.l  (A1),HeapEnd
            movea.l (SP)+,A2
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  D1,(SP)
            jmp     (A0)
.L2:
            dc.b    9,'AppleTalk'
            dc.b    '>>[(c)'
RsrcEntryDRVR_40:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 40 ".XPP" (3364 bytes) - Combo mask
            dc.l    RsrcEntryINIT_18-BaseOfROM      ; Next entry
            dc.l    RsrcDRVR_40-BaseOfROM           ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    40                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'.XPP'                        ; Name
            dc.b    'nc. 1989'
            dc.l    $C0A00000,$00000D30,$0000022C   ; Block header
RsrcDRVR_40:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    XPPOpen-RsrcDRVR_40             ; drvrOpen
            dc.w    XPPPrime-RsrcDRVR_40            ; drvrPrime
            dc.w    XPPCtl-RsrcDRVR_40              ; drvrCtl
            dc.w    XPPPrime-RsrcDRVR_40            ; drvrStatus
            dc.w    XPPClose-RsrcDRVR_40            ; drvrClose
            dc.b    4,'.XPP'
            dc.b    $00
.L1:
            dc.b    $38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$35
            dc.b    '.XPP DRVR v56.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1984-1991'
XPPOpen:
            movea.l ROMBase,A0
            move.w  (8,A0),D2
            cmpi.w  #$75,D2
            beq.b   .L2
            movea.l ($D1C).w,A0
            move.l  A0,D1
            addq.l  #1,D1
            bne.b   .L1
            moveq   #$10,D0
            _NewHandleClear async
            bne.w   .L9
            move.l  A0,($D1C).w
.L1:
            movea.l (A0),A2
            tst.l   (A2)
            bra.b   .L3
.L2:
            move.l  sub_408DF580.L9,D0
.L3:
            bne.b   .L8
            moveq   #-$61,D0
            move.b  PortBUse,D1
            bmi.b   .L9
            andi.b  #$F,D1
            subq.b  #1,D1
            bne.b   .L9
            bset    #5,PortBUse
            movea.l A0,A2
            move.l  #$E2,D0
            _NewPtrSysClear
            bne.b   .L9
            cmpi.w  #$75,D2
            beq.b   .L4
            movea.l (A2),A2
            move.l  A0,(A2)
            bra.b   .L5
.L4:
            lea     sub_408DF580.L9,A2
            move.l  A0,(A2)
.L5:
            move.b  RsrcDRVR_40.L1,(7,A1)
            move.b  #$14,D0
            cmpi.w  #$75,D2
            beq.b   .L6
            cmpi.w  #$276,D2
            bne.b   .L7
.L6:
            moveq   #5,D0
.L7:
            move.b  D0,(6,A0)
            move.l  A1,(A0)
            lea     sub_408DEA82,A2
            move.l  A2,($E,A0)
            movea.l LAPMgrPtr,A2
            cmpa.w  #$FFFF,A2
            beq.b   .L8
            lea     (8,A0),A0
            moveq   #$17,D0
            jsr     (2,A2)
.L8:
            moveq   #0,D0
.L9:
            rts
XPPCtl:
            move.w  ($1A,A0),D2
            subq.w  #1,D2
            bne.b   .L1
            rts
.L1:
            moveq   #-$11,D0
            subi.w  #$F5,D2
            blt.w   sub_408DEB6A.L8
            cmpi.w  #9,D2
            bgt.w   sub_408DEB6A.L8
            add.w   D2,D2
            lea     .L2,A3
            adda.w  D2,A3
            movea.w (A3),A3
            lea     RsrcDRVR_40,A2
            adda.l  A2,A3
            jmp     (A3)
.L2:
            dc.w    $0C60,$01A0,$023C,$02CC,$0896,$0802,$061C,$061C
            dc.w    $04D0,$032E
XPPClose:
            bsr.w   sub_408DF51A
            bne.b   .L1
            moveq   #-$18,D0
            rts
.L1:
            movea.l LAPMgrPtr,A2
            cmpa.w  #$FFFF,A2
            beq.b   .L4
            movea.l ROMBase,A1
            cmpi.w  #$75,(8,A1)
            bne.b   .L2
            movea.l sub_408DF580.L9,A1
            bra.b   .L3
.L2:
            movea.l ($D1C).w,A1
            movea.l (A1),A1
            movea.l (A1),A1
.L3:
            lea     (8,A1),A0
            moveq   #$18,D0
            jsr     (2,A2)
.L4:
            bclr    #5,PortBUse
            movea.l ROMBase,A2
            cmpi.w  #$75,(8,A2)
            beq.b   .L5
            movea.l ($D1C).w,A2
            movea.l (A2),A2
            clr.l   (A2)
            bra.b   .L6
.L5:
            lea     sub_408DF580.L9,A2
            clr.l   (A2)
.L6:
            moveq   #0,D0
            rts
sub_408DEA70:
            bsr.w   sub_408DF51A
            bne.w   sub_408DEB6A.L7
            move.b  #5,(2,A2)
            bra.w   sub_408DEDBA
sub_408DEA82:
            move.l  (4,SP),D0
            cmpi.l  #5,D0
            bne.b   sub_408DEAEC
            movea.l ($C,SP),A0
            movem.l D4/A2-A4,-(SP)
            movea.l A0,A4
            bsr.w   sub_408DF4CC
            move.l  D0,D4
            movea.l A1,A3
.L1:
            movea.l ($12,A3,D4.w),A2
            cmpa.w  #0,A2
            beq.b   .L2
            move    SR,-(SP)
            move    #$2600,SR
            cmpi.b  #2,(2,A2)
            bne.b   sub_408DEAEC.L1
            moveq   #0,D0
            move.w  (8,A2),D0
            move.l  D0,-(SP)
            move.l  A4,-(SP)
            movea.l (4,A4),A0
            jsr     (A0)
            addq.w  #8,SP
            tst.w   D0
            bne.b   sub_408DEAEC.L1
            move.b  #6,(2,A2)
            move    (SP)+,SR
            movem.l D3/A3,-(SP)
            bsr.w   sub_408DEDBA
            movem.l (SP)+,D3/A3
.L2:
            subq.w  #4,D4
            bpl.b   .L1
            movem.l (SP)+,D4/A2-A4
            rts
sub_408DEAEC:
            moveq   #0,D0
            rts
.L1:
            move    (SP)+,SR
            bra.b   sub_408DEA82.L2
sub_408DEAF4:
            move.l  A3,-(SP)
            movea.l ABusDCE,A3
            cmpi.b  #4,(7,A3)
            beq.b   .L1
            cmpi.b  #$2D,(7,A3)
.L1:
            movea.l (SP)+,A3
            rts
            movea.l ($1C,A0),A2
            move    SR,-(SP)
            move    #$2600,SR
            movea.l ($82,A2),A1
            move.l  A1,D0
            beq.b   sub_408DEB6A.L4
            cmpi.b  #$FF,($1B,A1)
            bne.b   sub_408DEB6A.L4
            lea     ($42,A2),A1
            cmpi.w  #$FE,($1A,A1)
            beq.b   sub_408DEB6A.L4
            bsr.b   sub_408DEAF4
            bcc.b   .L2
            btst    #1,($1D,A1)
            beq.b   sub_408DEB6A.L4
.L2:
            move.b  #3,(2,A2)
            move    (SP)+,SR
            lea     ($10,A2),A0
            lea     sub_408DEB6A.L7,A3
sub_408DEB4E:
            move.w  ($16,A1),($2E,A0)
            move.l  ($1E,A1),($1E,A0)
            move.w  #$100,D0
            bsr.b   sub_408DEAF4
            bcs.b   sub_408DEB6A
            move.l  A1,($2C,A0)
            move.w  #$102,D0
sub_408DEB6A:
            move.w  D0,($1A,A0)
.L1:
            move.l  A3,($C,A0)
            move.w  #$FFF5,($18,A0)
            _Control async
            beq.b   .L2
            cmpi.w  #$FFE4,D0
            beq.b   .L3
            cmpi.w  #$FFEB,D0
            beq.b   .L3
.L2:
            rts
.L3:
            tst.l   ($C,A0)
            beq.b   .L2
            tst.w   D0
            jmp     (A3)
.L4:
            move    (SP)+,SR
            move.w  #$FBB2,D0
            bra.b   .L8
            move.w  #$242,($1C,A0)
            move.w  #$1210,($1E,A0)
            movea.l ROMBase,A1
            cmpi.w  #$75,(8,A1)
            bne.b   .L5
            movea.l sub_408DF580.L9,A1
            bra.b   .L6
.L5:
            movea.l ($D1C).w,A1
            movea.l (A1),A1
            movea.l (A1),A1
.L6:
            moveq   #0,D0
            move.b  (6,A1),D0
            move.w  D0,($20,A0)
.L7:
            moveq   #0,D0
.L8:
            movea.l ROMBase,A1
            cmpi.w  #$75,(8,A1)
            bne.b   .L9
            movea.l sub_408DF580.L9,A1
            bra.b   .L10
.L9:
            movea.l ($D1C).w,A1
            movea.l (A1),A1
            movea.l (A1),A1
.L10:
            movea.l (A1),A1
            movea.l JIODone,A0
            jmp     (A0)
sub_408DEBF0:
            tst.b   ($1A,A0)
            bpl.b   sub_408DEB6A.L8
            move.w  #$FA,($1A,A0)
            bra.b   sub_408DEB6A.L8
            movea.l ($24,A0),A2
            move.l  ($20,A0),D3
            move.l  ($28,A0),D2
.L1:
            bsr.w   sub_408DF494
            bne.b   sub_408DEBF0
            move.b  #1,(2,A2)
            move.l  D2,($B8,A2)
            move.w  D1,($1C,A0)
            move.l  D3,(8,A2)
            move.b  D3,(7,A2)
            move.l  A0,($82,A2)
            bsr.w   sub_408DF078
            lea     ($42,A2),A0
            move.w  #$FE,D0
            lea     sub_408DEC3E,A3
            bra.w   sub_408DEB6A
sub_408DEC3E:
            lea     (-$42,A0),A2
            bmi.w   sub_408DECD0.L1
            move.b  ($1C,A0),(6,A2)
            lea     ($1C,A0),A3
            move.w  #$20,(A3)+
            move.l  (8,A2),(A3)+
            clr.w   (A3)+
            clr.l   (A3)+
            lea     ($86,A2),A1
            move.l  A1,(A3)+
            move.b  #1,(A3)+
            movea.l ($82,A2),A1
            move.b  ($1E,A1),(A3)
            addq.w  #2,A3
            move.b  ($1F,A1),(A3)+
            lea     ($12,A0),A1
            move.b  #4,(A1)+
            move.b  (6,A2),(A1)+
            move.w  #$100,(A1)+
            lea     sub_408DEC90,A3
            move.w  #$FF,D0
            bra.w   sub_408DEB6A
sub_408DEC90:
            lea     (-$42,A0),A2
            bmi.b   .L1
            move.w  #$FBAF,D0
            cmpi.b  #3,(2,A2)
            beq.b   .L1
            lea     ($92,A2),A1
            move.w  -(A1),D0
            beq.b   sub_408DECD0.L2
            bmi.b   .L1
            move.w  #$FBD2,D0
.L1:
            cmpi.w  #$FBB8,D0
            bne.b   .L2
            move.w  #$FBD3,D0
.L2:
            move.b  (6,A2),($1C,A0)
            move.w  D0,($86,A2)
            move.w  #$FA,D0
            lea     sub_408DECD0,A3
            bra.w   sub_408DEB6A
sub_408DECD0:
            lea     (-$42,A0),A2
            move.w  ($86,A2),D0
.L1:
            move.w  D0,D1
            bsr.w   sub_408DF4F2
            move.w  D1,D0
            bra.b   .L4
.L2:
            move.b  -(A1),(3,A2)
            move.l  (8,A2),D3
            move.b  -(A1),($B,A2)
            move.b  (6,A2),($1C,A0)
            lea     ($E,A2),A3
            move.l  A3,($24,A0)
            bsr.w   sub_408DF388
            lea     ($10,A2),A0
            lea     ($1C,A0),A3
            move.b  (6,A2),(A3)+
            clr.b   (A3)+
            move.l  D3,(A3)+
            clr.w   (A3)+
            clr.l   (A3)+
            clr.l   (A3)+
            move.w  #$1E,(A3)+
            move.w  #$FFFF,(A3)+
            lea     ($12,A0),A3
            move.b  #5,(A3)+
            move.b  (3,A2),(A3)+
            clr.w   (A3)+
            move.w  #$FF,D0
            bsr.w   sub_408DEAF4
            bcs.b   .L3
            move.w  #$F8,D0
.L3:
            suba.l  A3,A3
            bsr.w   sub_408DEB6A
            lea     ($78,A2),A0
            move.w  #1,(A0)+
            lea     sub_408DF33E.L1,A3
            move.l  A3,(A0)+
            move.w  #$1C20,(A0)
            lea     ($74,A2),A0
            _VInstall
            moveq   #0,D0
            move.b  #2,(2,A2)
.L4:
            movea.l ($82,A2),A0
sub_408DED64:
            move.l  A1,-(SP)
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($82,A2),A1
.L1:
            cmpa.l  (A1),A0
            beq.b   .L2
            movea.l (A1),A1
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            move    (SP)+,SR
            movea.l (SP)+,A1
.L3:
            tst.w   ($1A,A0)
            bmi.w   sub_408DF124.L10
sub_408DED86:
            movem.l D1-D3/A0-A3,-(SP)
            move.w  D0,($10,A0)
            move.l  ($C,A0),D1
            beq.b   .L1
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L1:
            movem.l (SP)+,D1-D3/A0-A3
            rts
sub_408DEDA0:
            move.w  ($1C,A0),D1
            bsr.w   sub_408DF458
            bne.w   sub_408DEBF0
            move.b  #5,(2,A2)
            bsr.w   sub_408DF078
            bsr.w   sub_408DF508
sub_408DEDBA:
            lea     ($74,A2),A0
            _VRemove
.L1:
            lea     sub_408DEDD0,A3
            lea     ($86,A2),A0
            lea     ($10,A2),A1
            bra.w   sub_408DEB4E
sub_408DEDD0:
            lea     (-$86,A0),A2
            movea.l A0,A1
            lea     ($10,A2),A0
            cmpi.b  #6,(2,A2)
            beq.b   .L1
            lea     ($1C,A0),A3
            clr.w   (A3)+
            move.l  (8,A2),(A3)+
            clr.w   (A3)+
            clr.l   (A3)+
            move.l  A1,(A3)+
            clr.w   (A1)+
            clr.l   (A1)+
            move.b  #1,(A3)+
            move.b  #1,(A3)+
            move.w  #1,(A3)+
            lea     ($12,A0),A3
            move.b  #1,(A3)+
            move.b  (3,A2),(A3)+
            clr.w   (A3)+
            move.w  #$FF,D0
            lea     .L1,A3
            bra.w   sub_408DEB6A
.L1:
            lea     (-$10,A0),A2
            lea     ($82,A2),A1
.L2:
            move.l  (A1),D1
            beq.b   .L4
            movea.l D1,A1
            cmpi.b  #$FE,($1B,A1)
            beq.b   .L2
            cmpi.b  #$FC,($1B,A1)
            bne.b   .L3
            move.l  A0,D2
            movea.l A1,A0
            movea.l A1,A3
            bsr.w   sub_408DF448
            exg     A1,A3
            movea.l D2,A0
            tst.w   ($10,A3)
            ble.b   .L3
            move.b  ($1C,A3),($1C,A0)
            move.l  ($1E,A3),($1E,A0)
            move.w  ($2E,A3),($2E,A0)
            move.w  #$F9,D0
            lea     .L1,A3
            bra.w   sub_408DEB6A
.L3:
            lea     ($32,A1),A1
            lea     sub_408DEECA,A3
            bra.w   sub_408DEB4E
.L4:
            move.b  (6,A2),($1C,A0)
            move.w  #$FA,D0
            lea     sub_408DEE8A,A3
            bra.w   sub_408DEB6A
sub_408DEE8A:
            lea     (-$10,A0),A2
            movea.l ($82,A2),A0
            move.b  (2,A2),D2
            move.w  (4,A2),D1
            movea.l ($B8,A2),A3
            bsr.w   sub_408DF4F2
            move.l  A3,D3
            beq.b   .L1
            exg     D0,D1
            movem.l D2/A0/A2,-(SP)
            jsr     (A3)
            movem.l (SP)+,D2/A0/A2
            clr.w   D0
.L1:
            subq.b  #6,D2
            beq.b   XPPPrime.L1
            move.l  A0,D1
            beq.w   sub_408DEA70
            bra.w   sub_408DED64.L3
XPPPrime:
            bclr    #7,(5,A1)
.L1:
            rts
sub_408DEECA:
            bpl.w   sub_408DEDD0.L1
            lea     (-$10,A0),A2
            lea     ($82,A2),A1
            move.l  (A1),D1
            beq.b   sub_408DEDD0.L4
            move.l  A0,-(SP)
            movea.l D1,A0
            move.w  #$FBD0,D0
            bsr.w   sub_408DED64
            movea.l (SP)+,A0
            bra.w   sub_408DEDD0.L1
.L1:
            clr.b   ($1F,A0)
            lea     ($1C,A0),A3
            move.w  (A3),D1
            bsr.w   sub_408DF458
            bne.w   sub_408DEBF0
            addq.w  #4,A3
            move.w  #$FBCF,D0
            cmpi.w  #$242,(A3)
            bhi.w   sub_408DEBF0
            move.w  ($C,A2),D1
            addq.w  #1,($C,A2)
            bsr.w   sub_408DF078
            move.w  D1,D0
            lea     ($4E,A0),A1
            move.b  (6,A2),(A1)+
            move.b  #$20,(A1)+
            move.l  (8,A2),(A1)+
            move.w  (A3)+,(A1)+
            move.l  (A3)+,(A1)+
            move.l  A4,-(SP)
            lea     ($64,A0),A4
            move.l  A4,(A1)+
            move.w  (A3)+,D3
            move.l  (A3)+,D2
            bsr.w   sub_408DF03C
            moveq   #2,D2
            cmpi.b  #$FC,($1B,A0)
            bne.b   .L2
            move.w  (A3),D3
            move.w  D3,($22,A4)
            clr.w   (A3)+
            move.l  (A3)+,D2
            clr.w   ($10,A4)
            move.l  A0,($24,A4)
            lea     ($32,A4),A4
            swap    D1
            bsr.w   sub_408DF03C
            swap    D1
            moveq   #6,D2
.L2:
            movea.l (SP)+,A4
            move.b  D1,(A1)+
            move.b  ($1E,A0),(A1)+
            move.w  #$FFFF,(A1)+
            bsr.w   sub_408DF508
            lea     ($32,A0),A0
            lea     ($12,A0),A1
            move.b  D2,(A1)+
            move.b  (3,A2),(A1)+
            move.w  D0,(A1)+
            lea     .L4,A3
            move.w  #$FF,D0
            bsr.w   sub_408DEAF4
            bcs.b   .L3
            move.w  #$F8,D0
.L3:
            bra.w   sub_408DEB6A
.L4:
            bsr.w   sub_408DF124
            move.l  (8,A1),($12,A0)
            move.w  ($1C,A0),D1
            move.w  D0,D2
            bsr.w   sub_408DF458
            cmpi.w  #$FBD2,D0
            beq.b   .L7
            move.w  D2,D0
            cmpi.w  #$FBAF,D0
            bne.b   .L6
            move.w  #$FBD0,D0
.L5:
            bra.w   sub_408DED64
.L6:
            cmpi.w  #$FFA5,D0
            beq.b   sub_408DEFF6
            move.w  #$1C20,($7E,A2)
            cmpi.b  #$FC,($1B,A0)
            bne.b   .L5
            bsr.w   sub_408DF448
            move    SR,-(SP)
            move    #$2600,SR
            st      ($1F,A0)
            tst.w   ($10,A1)
            ble.w   sub_408DF428.L1
            move    (SP)+,SR
.L7:
            rts
sub_408DEFF6:
            suba.l  A3,A3
            move.l  A0,D1
            lea     ($86,A2),A0
            lea     ($10,A2),A1
            bsr.w   sub_408DEB4E
            movea.l D1,A0
            lea     ($32,A0),A0
            lea     sub_408DF014,A3
            bra.w   sub_408DEB6A.L1
sub_408DF014:
            movem.l D0/A0,-(SP)
            cmpi.w  #$FBAF,D0
            beq.b   .L1
            move.w  (-$16,A0),D1
            bsr.w   sub_408DF458
            bne.b   .L1
            lea     ($10,A2),A0
            tst.w   ($10,A0)
            bgt.b   .L1
            _Control async
.L1:
            movem.l (SP)+,D0/A0
            bra.w   sub_408DEECA.L4
sub_408DF03C:
            cmpi.w  #$1210,D3
            bls.b   .L1
            move.w  #$1210,D3
.L1:
            ext.l   D3
            divs.w  #$242,D3
            move.w  D3,D1
            beq.b   .L3
.L2:
            move.w  #$242,(A4)+
            move.l  D2,(A4)+
            addq.w  #2,A4
            clr.l   (A4)+
            addi.l  #$242,D2
            subq.w  #1,D3
            bne.b   .L2
.L3:
            cmpi.w  #8,D1
            beq.b   .L4
            addq.w  #1,D1
            swap    D3
            move.w  D3,(A4)+
            move.l  D2,(A4)+
            addq.w  #2,A4
            clr.l   (A4)+
.L4:
            rts
sub_408DF078:
            movea.l ROMBase,A1
            cmpi.w  #$75,(8,A1)
            bne.b   .L1
            movea.l sub_408DF580.L9,A1
            bra.b   .L2
.L1:
            movea.l ($D1C).w,A1
            movea.l (A1),A1
            movea.l (A1),A1
.L2:
            movea.l (A1),A1
            move    SR,-(SP)
            move    #$2600,SR
            bclr    #7,(5,A1)
            move.l  (A0),(8,A1)
            bne.b   .L3
            clr.l   ($C,A1)
.L3:
            clr.l   (A0)
            move.l  (8,A1),D0
            beq.b   .L4
            bset    #7,(5,A1)
            move    (SP)+,SR
            movem.l D1-D3/A0/A2-A3,-(SP)
            movea.l D0,A0
            moveq   #0,D0
            bsr.w   XPPCtl
            movem.l (SP)+,D1-D3/A0/A2-A3
            moveq   #0,D0
            rts
.L4:
            move    (SP)+,SR
            rts
            lea     ($26,A0),A3
            bsr.b   sub_408DF078
            lea     ($4E,A0),A1
            clr.w   (A1)+
            move.l  ($20,A0),(A1)+
            clr.w   (A1)+
            clr.l   (A1)+
            move.l  A4,-(SP)
            lea     ($64,A0),A4
            move.l  A4,(A1)+
            move.w  (A3)+,D3
            move.l  (A3)+,D2
            bsr.w   sub_408DF03C
            movea.l (SP)+,A4
            move.b  D1,(A1)+
            move.b  ($1E,A0),(A1)
            addq.w  #2,A1
            move.b  ($1F,A0),(A1)+
            lea     ($32,A0),A0
            lea     ($12,A0),A1
            clr.l   (A1)
            move.b  #3,(A1)+
            move.w  #$FF,D0
            lea     sub_408DF11E,A3
            bra.w   sub_408DEB6A
sub_408DF11E:
            bsr.b   sub_408DF124
            bra.w   sub_408DED86
sub_408DF124:
            movea.l ($28,A0),A1
            move.b  ($2E,A0),D3
            lea     (-$32,A0),A0
            tst.w   D0
            bne.b   .L2
            ext.w   D3
            subq.w  #1,D3
            move.w  D3,D2
            mulu.w  #$C,D3
            move.w  (6,A1,D3.w),D1
            cmp.w   (0,A1,D3.w),D1
            bls.b   .L1
            move.w  #$FBD5,D0
            move.w  (0,A1,D3.w),D1
.L1:
            mulu.w  #$242,D2
            add.w   D2,D1
            move.w  D1,($26,A0)
.L2:
            cmpi.w  #$FBB8,D0
            bne.b   .L3
            move.w  #$FBD3,D0
.L3:
            rts
            tst.w   ($20,A0)
            bne.b   .L5
.L4:
            move.w  #$EC65,D0
            bra.w   sub_408DEB6A.L8
.L5:
            st      ($1A,A0)
            clr.l   (8,A0)
.L6:
            movea.l ($22,A0),A1
            move.b  (A1),D1
            beq.b   .L4
            cmpi.b  #$F,D1
            beq.b   .L4
            cmpi.b  #$FF,D1
            beq.b   .L4
            cmpi.b  #$12,D1
            beq.b   .L13
            cmpi.b  #$14,D1
            beq.b   .L12
            move.b  #$FC,($1B,A0)
            lea     ($2C,A0),A3
            cmpi.b  #$21,D1
            beq.b   .L7
            cmpi.b  #$C0,D1
            bcc.b   .L9
            move.b  #$FD,($1B,A0)
            cmpi.b  #$1B,D1
            bne.b   .L9
            subq.w  #6,A3
.L7:
            move.l  (8,A1),D2
            cmpi.l  #$1210,D2
            bls.b   .L8
            move.w  #$1210,D2
.L8:
            move.w  D2,(A3)
.L9:
            bra.w   sub_408DEECA.L1
.L10:
            movea.l ($22,A0),A1
            move.b  (A1),D1
            cmpi.b  #$12,D1
            beq.b   .L14
            cmpi.b  #$13,D1
            beq.b   .L14
            lea     ($2C,A0),A3
            cmpi.b  #$21,D1
            beq.b   .L16
            subq.w  #6,A3
            cmpi.b  #$1B,D1
            beq.b   .L16
.L11:
            move.w  #$FA,($1A,A0)
            bra.w   sub_408DED86
.L12:
            move.b  #$FE,($1B,A0)
            bra.w   sub_408DEDA0
.L13:
            cmpi.w  #$242,($20,A0)
            bhi.w   sub_408DEBF0
            move.b  #$FF,($1B,A0)
            movea.l ($30,A0),A2
            move.l  ($2C,A0),D3
            move.l  ($34,A0),D2
            bra.w   sub_408DEBF0.L1
.L14:
            tst.w   D0
            bne.b   .L11
            lea     ($1B,A0),A1
            cmpi.b  #$FD,(A1)
            beq.b   .L15
            cmpi.b  #$FE,(A1)
            beq.b   .L11
            move.b  #$FD,(A1)
            bra.w   sub_408DEECA.L1
.L15:
            move.l  ($12,A0),D1
            beq.b   .L11
            cmpi.w  #$EC77,D1
            beq.b   .L11
            move.b  #$FE,(A1)
            bra.w   sub_408DEDA0
.L16:
            tst.w   D0
            bne.b   .L20
            moveq   #0,D3
            move.w  (A3)+,D3
            add.l   D3,(8,A0)
            tst.l   ($12,A0)
            bne.b   .L20
            cmp.l   (8,A1),D3
            bcc.b   .L20
            cmpi.b  #$1B,D1
            bne.b   .L19
            tst.b   ($C,A1)
            bpl.b   .L17
            movea.l (A3),A2
            move.b  (-1,A2,D3.w),D1
            cmp.b   ($D,A1),D1
            beq.b   .L20
.L17:
            add.l   D3,(4,A1)
.L18:
            sub.l   D3,(8,A1)
            add.l   D3,(A3)
            bra.w   .L6
.L19:
            bclr    #7,(1,A1)
            beq.b   .L17
            movea.l ($28,A0),A2
            move.l  (A2),D1
            move.l  D1,(4,A1)
            bra.b   .L18
.L20:
            move.l  (8,A0),(8,A1)
            bra.w   .L11
sub_408DF2BA:
            move.w  ($10,A0),D0
            bne.b   .L3
            move.w  #2,($22,A0)
            lea     (-$42,A0),A2
            move.b  ($13,A0),D1
            cmp.b   (3,A2),D1
            bne.b   .L2
            move.w  ($1E,A0),D2
            beq.b   .L1
            move.w  (8,A2),D3
            beq.b   .L1
            cmp.w   D2,D3
            bne.b   .L2
.L1:
            move.b  ($20,A0),D2
            cmp.b   ($A,A2),D2
            bne.b   .L2
            move.w  #$1C20,($7E,A2)
            move.b  ($12,A0),D1
            subq.b  #1,D1
            beq.b   sub_408DF30A
            subq.b  #6,D1
            beq.w   sub_408DF388.L1
            subq.b  #1,D1
            beq.b   sub_408DF33E.L2
.L2:
            _Control async
.L3:
            rts
sub_408DF30A:
            lea     (2,A2),A1
            cmpi.b  #5,(A1)
            beq.b   sub_408DF2BA.L3
            cmpi.b  #6,(A1)
            beq.b   sub_408DF2BA.L3
            move.b  #5,(A1)
            lea     ($86,A2),A1
            move.l  A1,($28,A0)
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            move.w  #$101,($2C,A0)
            move.w  #$FC,D0
            lea     sub_408DF33E,A3
            bra.w   sub_408DEB6A
sub_408DF33E:
            lea     ($32,A0),A0
            _VRemove
.L1:
            lea     (-$74,A0),A2
            move.b  #6,(2,A2)
            bra.w   sub_408DEDBA.L1
.L2:
            move.w  ($14,A0),D1
            move.w  D1,(A2)
            movea.l ($B8,A2),A1
            clr.l   ($12,A0)
            clr.w   ($22,A0)
            clr.b   ($1D,A0)
            clr.b   ($2C,A0)
            move.w  #$FB,D0
            lea     sub_408DF388,A3
            bsr.w   sub_408DEB6A
            move.l  A1,D0
            beq.b   .L3
            tst.w   D1
            beq.b   .L3
            move.w  (4,A2),D0
            jmp     (A1)
.L3:
            rts
sub_408DF388:
            move.w  #2,($22,A0)
            move.w  #$FD,D0
            lea     sub_408DF2BA,A3
            bra.w   sub_408DEB6A
.L1:
            move.w  ($14,A0),D1
            move.w  ($E,A2),D2
            movea.l A0,A3
            lea     ($82,A2),A0
.L2:
            move.l  (A0),D0
            beq.b   .L4
            movea.l D0,A0
            cmpi.b  #$FC,($1B,A0)
            bne.b   .L2
            cmp.w   ($46,A0),D1
            bne.b   .L2
            bsr.w   sub_408DF448
            move.w  ($22,A1),D1
            cmp.w   D1,D2
            bcc.b   .L3
            move.w  D2,D1
.L3:
            move.w  D1,($2C,A0)
            movea.l A1,A0
            move.l  ($1E,A3),($1E,A0)
            move.w  ($2E,A3),($2E,A0)
            move.b  (6,A2),($1C,A0)
            lea     ($32,A0),A1
            subq.w  #1,D1
            ext.l   D1
            divs.w  #$242,D1
            move.w  D1,D2
            mulu.w  #$C,D2
            swap    D1
            addq.w  #1,D1
            move.w  D1,(0,A1,D2.w)
            move.l  A1,($28,A0)
            swap    D1
            addq.w  #1,D1
            move.b  D1,($2C,A0)
            move.b  D1,($2D,A0)
            move.b  #$10,($1D,A0)
            movea.l A3,A1
            move.w  #$FC,D0
            lea     sub_408DF428,A3
            bsr.w   sub_408DEB6A
            movea.l A1,A3
.L4:
            movea.l A3,A0
            _Control async
            rts
sub_408DF428:
            movea.l ($24,A0),A0
            move    SR,-(SP)
            move    #$2600,SR
            tst.b   ($1F,A0)
            beq.b   .L2
            move.w  ($1C,A0),D1
            bsr.b   sub_408DF458
.L1:
            move    (SP)+,SR
            bra.w   sub_408DED64
.L2:
            move    (SP)+,SR
            rts
sub_408DF448:
            moveq   #0,D3
            move.b  ($5E,A0),D3
            mulu.w  #$C,D3
            lea     ($64,A0,D3.w),A1
            rts
sub_408DF458:
            move.l  A1,-(SP)
            bsr.b   sub_408DF4CC
            cmp.b   D0,D1
            bhi.b   .L2
            move.b  D1,D0
            andi.w  #$FC,D0
            movea.l ($12,A1,D0.w),A2
            move.l  A2,D0
            beq.b   .L2
            cmp.w   (4,A2),D1
            bne.b   .L2
            cmpi.b  #1,(2,A2)
            beq.b   .L2
            move.w  #$FBD0,D0
            cmpi.b  #2,(2,A2)
            bne.b   .L1
            clr.w   D0
.L1:
            movea.l (SP)+,A1
            rts
.L2:
            move.w  #$FBD2,D0
            bra.b   .L1
sub_408DF494:
            move.l  A1,-(SP)
            bsr.b   sub_408DF4CC
            move.b  (4,A1),D1
            addq.b  #1,(4,A1)
            asl.w   #8,D1
.L1:
            tst.l   ($12,A1,D0.w)
            beq.b   .L2
            subq.w  #4,D0
            bpl.b   .L1
            move.w  #$FBD4,D0
            bra.b   .L4
.L2:
            move.l  A2,($12,A1,D0.w)
            move.b  D0,D1
            movea.l A2,A1
            moveq   #$5D,D0
.L3:
            clr.w   (A1)+
            subq.w  #1,D0
            bne.b   .L3
            move.w  D1,(4,A2)
.L4:
            movea.l (SP)+,A1
            tst.w   D0
            rts
sub_408DF4CC:
            movea.l ROMBase,A1
            cmpi.w  #$75,(8,A1)
            bne.b   .L1
            movea.l sub_408DF580.L9,A1
            bra.b   .L2
.L1:
            movea.l ($D1C).w,A1
            movea.l (A1),A1
            movea.l (A1),A1
.L2:
            moveq   #0,D0
            move.b  (6,A1),D0
            subq.w  #1,D0
            asl.w   #2,D0
            rts
sub_408DF4F2:
            bsr.b   sub_408DF4CC
.L1:
            cmpa.l  ($12,A1,D0.w),A2
            beq.b   .L2
            subq.w  #4,D0
            bpl.b   .L1
            rts
.L2:
            clr.l   ($12,A1,D0.w)
            moveq   #0,D0
            rts
sub_408DF508:
            move    SR,-(SP)
            move    #$2600,SR
            move.l  ($82,A2),(A0)
            move.l  A0,($82,A2)
            move    (SP)+,SR
            rts
sub_408DF51A:
            bsr.b   sub_408DF4CC
.L1:
            tst.l   ($12,A1,D0.w)
            bne.b   .L2
            subq.w  #4,D0
            bpl.b   .L1
            rts
.L2:
            movea.l ($12,A1,D0.w),A2
            moveq   #0,D0
            rts
            movea.l ROMBase,A2
            cmpi.w  #$75,(8,A2)
            bne.b   .L3
            movea.l sub_408DF580.L9,A2
            bra.b   .L4
.L3:
            movea.l ($D1C).w,A2
            movea.l (A2),A2
            movea.l (A2),A2
.L4:
            lea     ($62,A2),A2
            move.w  ($1C,A0),D3
            bmi.b   .L5
            cmpi.w  #$1F,D3
            ble.b   .L6
.L5:
            moveq   #-$11,D0
            bra.w   sub_408DEB6A.L8
.L6:
            tst.l   (A2)
            bne.b   .L7
            move.l  A0,-(SP)
            lea     sub_408DF580,A0
            move.l  A0,(A2)
            move.l  A0,(4,A2)
            movea.l (SP)+,A0
.L7:
            lsl.w   #2,D3
            move.l  (0,A2,D3.w),D3
            beq.b   .L5
            move.l  D3,-(SP)
            bra.w   sub_408DF078
sub_408DF580:
            move.w  ($1E,A0),D3
            cmpi.w  #5,D3
            bcs.b   .L4
            cmpi.w  #$1F,D3
            bhi.b   .L4
            movea.l ROMBase,A2
            cmpi.w  #$75,(8,A2)
            bne.b   .L1
            movea.l .L9,A2
            bra.b   .L2
.L1:
            movea.l ($D1C).w,A2
            movea.l (A2),A2
            movea.l (A2),A2
.L2:
            lea     ($62,A2),A2
            lsl.w   #2,D3
            cmpi.w  #0,($1C,A0)
            beq.b   .L3
            clr.l   (0,A2,D3.w)
            bra.b   .L6
.L3:
            move.l  (0,A2,D3.w),D0
            bne.b   .L4
            move.l  ($20,A0),D0
            bne.b   .L5
.L4:
            moveq   #-1,D0
            bra.b   .L7
.L5:
            move.l  D0,(0,A2,D3.w)
.L6:
            moveq   #0,D0
.L7:
            move.w  D0,($10,A0)
            move.l  ($C,A0),D1
            beq.b   .L8
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L8:
            rts
.L9:
            ds.b    4
            dc.b    'LPATWT'
RsrcEntryDRVR_10:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 10 ".ATP" (5812 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_40-BaseOfROM      ; Next entry
            dc.l    RsrcDRVR_10-BaseOfROM           ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    10                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'.ATP'                        ; Name
            dc.b    't Apple '
            dc.l    $C0A00000,$000016C0,$00000224   ; Block header
RsrcDRVR_10:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    ATPOpen-RsrcDRVR_10             ; drvrOpen
            dc.w    ATPPrime-RsrcDRVR_10            ; drvrPrime
            dc.w    ATPCtl-RsrcDRVR_10              ; drvrCtl
            dc.w    ATPPrime-RsrcDRVR_10            ; drvrStatus
            dc.w    ATPClose-RsrcDRVR_10            ; drvrClose
            dc.b    4,'.ATP'
            dc.b    $20
.L1:
            dc.b    $38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$35
            dc.b    '.ATP DRVR v56.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1984-1991'
ATPOpen:
            move.l  ($2D8).w,D1
            bgt.b   .L1
            cmpi.l  #$FFFFFFFF,D1
            bne.b   .L1
            moveq   #-$17,D0
            bra.b   .L3
.L1:
            movea.l D1,A3
            moveq   #0,D0
            tst.l   ($1E,A3)
            bne.b   .L3
            move.w  #$BD2,D0
            _NewPtrSysClear
            bne.b   .L3
            bset    #4,PortBUse
            move.l  A0,($1E,A3)
            move.b  RsrcDRVR_10.L1,(7,A1)
            move.w  #$C7E,(A0)
            move.w  #$2008,(2,A0)
            lea     ($872,A0),A2
            move.l  A1,(A2)+
            move.w  ($16C).w,(A2)+
            moveq   #5,D0
            movea.l ROMBase,A3
            cmpi.b  #$76,(9,A3)
            bcs.b   .L2
            move.w  TimeDBRA,D0
            divu.w  #$64,D0
.L2:
            move.b  D0,($BCB,A0)
            mulu.w  #$78,D0
            subi.w  #$8E,D0
            divu.w  #$30,D0
            move.w  D0,($BCC,A0)
            move.l  TimeLM,($886,A0)
            movea.l A2,A0
            addq.w  #4,A2
            move.w  #1,(A2)+
            lea     sub_408DFE2C,A1
            move.l  A1,(A2)+
            move.w  #6,(A2)+
            _VInstall
.L3:
            rts
ATPCtl:
            movea.l ROMBase,A2
            cmpi.b  #$76,(9,A2)
            bcs.b   .L1
            movea.l ($D1C).w,A2
            move.l  A2,D3
            addq.l  #1,D3
            beq.b   .L1
            movea.l (A2),A2
            move.l  (8,A2),D3
            beq.b   .L1
            movea.l D3,A2
            jsr     (A2)
.L1:
            tst.l   ($2D8).w
            bne.b   .L3
            moveq   #-$11,D0
.L2:
            bra.w   sub_408DF804.L7
.L3:
            move.w  ($1A,A0),D2
            subq.w  #1,D2
            bne.b   .L4
            rts
.L4:
            moveq   #-$11,D0
            subi.w  #$F7,D2
            blt.b   .L2
            cmpi.w  #$B,D2
            bgt.b   .L2
            add.w   D2,D2
            lea     .L7,A3
            adda.w  D2,A3
            movea.w (A3),A3
            lea     RsrcDRVR_10,A2
            adda.l  A2,A3
            movea.l ($2D8).w,A2
            movea.l ($1E,A2),A2
            move.b  ($1C,A0),D1
            subi.w  #$C,D2
            bpl.b   .L6
            move.w  #$FBB5,D0
            tst.b   D1
            beq.w   sub_408DF804.L6
            moveq   #$7D,D2
.L5:
            cmp.b   ($4C,A2,D2.w),D1
            dbeq    D2,.L5
            bne.w   sub_408DF804.L6
.L6:
            move.l  ($1E,A0),D3
            andi.b  #$3F,($1D,A0)
            jmp     (A3)
.L7:
            dc.w    $056A,$09F4,$0252,$0450,$037A,$0294,$01FA,$04EA
            dc.w    $099C,$02E8,$0958,$0338
ATPClose:
            movea.l ($2D8).w,A1
            move.l  A1,D0
            beq.b   .L5
            movea.l ($1E,A1),A2
            move.l  ($33E,A1),D0
            btst    #$A,D0
            bne.b   .L4
.L1:
            bsr.w   sub_408E0514
            bne.b   .L1
            moveq   #$C,D2
            lea     (4,A2),A0
            bsr.b   sub_408DF804
.L2:
            tst.w   ($10,A3)
            bgt.b   .L2
            moveq   #$7E,D2
            lea     ($4C,A2),A0
            bsr.b   sub_408DF804
.L3:
            tst.w   ($10,A3)
            bgt.b   .L3
.L4:
            pea     ($878,A2)
            move.l  (SP)+,D0
            _StripAddress
            movea.l D0,A0
            _VRemove
            movea.l A2,A0
            _DisposPtr
            clr.l   ($1E,A1)
            bclr    #4,PortBUse
.L5:
            rts
sub_408DF804:
            clr.w   ($10,A3)
.L1:
            subq.w  #1,D2
            bmi.b   ATPClose.L5
            move.b  (A0)+,D1
            beq.b   .L1
            move.w  #$F7,D0
            bsr.w   sub_408DFD70
            bra.b   .L1
            move.w  #$FBB6,D0
            moveq   #$7D,D2
.L2:
            tst.b   ($4C,A2,D2.w)
            dbeq    D2,.L2
            bne.b   .L6
            bsr.w   sub_408E0514
            bne.b   .L6
            lea     sub_408E0092,A1
            add.w   D2,D2
            adda.w  D2,A1
            add.w   D2,D2
            move.l  A1,($1E,A3)
            move.w  #$F8,D0
            bsr.w   sub_408DFD70
            move.b  ($1C,A3),D1
            bsr.w   sub_408E054C
            tst.w   D0
            bne.b   .L6
            adda.w  D2,A2
            clr.l   ($CA,A2)
            clr.l   ($2C2,A2)
            move.l  D3,($4BA,A2)
            suba.w  D2,A2
            lsr.w   #2,D2
            adda.w  D2,A2
            move.b  D1,($4C,A2)
            suba.w  D2,A2
            move.b  D1,($1C,A0)
            bra.b   .L5
            bsr.w   sub_408E0514
            bne.b   .L6
            move.w  #$F7,D0
            bsr.w   sub_408DFD70
            bsr.w   sub_408E054C
            tst.w   D0
            bne.b   .L6
            clr.b   ($4C,A2,D2.w)
            lea     ($6B2,A2),A1
            moveq   #$1F,D2
.L3:
            cmp.b   (A1),D1
            bne.b   .L4
            clr.b   (A1)
.L4:
            lea     ($E,A1),A1
            dbra    D2,.L3
.L5:
            moveq   #0,D0
.L6:
            movea.l ($872,A2),A1
.L7:
            movea.l JIODone,A0
            jmp     (A0)
ATPPrime:
            bclr    #7,(5,A1)
            rts
            lsl.w   #2,D2
            lea     ($CA,A2),A1
            adda.w  D2,A1
sub_408DF8BC:
            move    SR,-(SP)
            move    #$2600,SR
.L1:
            tst.l   (A1)
            beq.b   .L2
            movea.l (A1),A1
            bra.b   .L1
.L2:
            move.l  A0,(A1)
.L3:
            movea.l ($872,A2),A1
            bclr    #7,(5,A1)
            move.l  (A0),(8,A1)
            bne.b   .L4
            clr.l   ($C,A1)
.L4:
            clr.l   (A0)
            move.l  (8,A1),D0
            beq.b   .L5
            bset    #7,(5,A1)
            move    (SP)+,SR
            movem.l D1-D3/A0/A2-A3,-(SP)
            movea.l D0,A0
            moveq   #0,D0
            bsr.w   ATPCtl
            movem.l (SP)+,D1-D3/A0/A2-A3
            moveq   #0,D0
            rts
.L5:
            move    (SP)+,SR
            rts
            movea.l ($2C,A0),A1
            move.b  ($1C,A1),D1
            beq.b   .L10
            moveq   #$7D,D2
.L6:
            cmp.b   ($4C,A2,D2.w),D1
            dbeq    D2,.L6
            bne.b   .L10
            asl.w   #2,D2
            lea     ($CA,A2),A3
            adda.w  D2,A3
            move    SR,-(SP)
            move    #$2600,SR
.L7:
            move.l  (A3),D0
            beq.b   .L9
            sub.l   A1,D0
            _StripAddress
            tst.l   D0
            beq.b   .L8
            movea.l (A3),A3
            bra.b   .L7
.L8:
            move.l  (A1),(A3)
            move    (SP)+,SR
            movea.l A1,A0
            move.w  #$FBAF,D0
            bsr.w   sub_408DFF5E
            bra.w   sub_408DF804.L5
.L9:
            move    (SP)+,SR
.L10:
            move.w  #$FBB2,D0
            bra.w   sub_408DF804.L6
            move.b  ($1C,A0),D1
            beq.b   .L14
            moveq   #$7D,D2
.L11:
            cmp.b   ($4C,A2,D2.w),D1
            dbeq    D2,.L11
            bne.b   .L14
            asl.w   #2,D2
.L12:
            lea     ($CA,A2),A3
            adda.w  D2,A3
            move    SR,-(SP)
            move    #$2600,SR
            move.l  (A3),D0
            beq.b   .L13
            movea.l D0,A0
            move.l  (A0),(A3)
            move    (SP)+,SR
            move.w  #$FBAF,D0
            bsr.w   sub_408DFF5E
            bra.b   .L12
.L13:
            move    (SP)+,SR
            bra.w   sub_408DF804.L5
.L14:
            move.w  #$FBB2,D0
            bra.w   sub_408DF804.L6
            movea.l ($28,A0),A1
            swap    D1
            move.w  #$FBB4,D0
            move.b  ($2C,A0),D1
            beq.b   .L17
            cmpi.b  #8,D1
            bhi.w   .L21
            bsr.w   sub_408E0514
            bne.b   .L21
            st      ($61,A3)
.L15:
            lea     ($60,A3),A3
            moveq   #-$80,D0
            subq.b  #1,D1
            bne.b   .L16
            or.b    ($1D,A0),D0
.L16:
            move.b  D0,(A3)+
            addq.b  #1,(A3)+
            move.w  ($2E,A0),(A3)+
            move.w  (A1)+,D0
            move.l  (A1)+,D2
            move.w  #$FFFF,(A1)+
            move.l  (A1)+,(A3)+
            lea     (-$68,A3),A3
            swap    D1
            bsr.w   sub_408DFD04
            cmpi.w  #$FFA4,D0
            beq.b   .L20
            swap    D1
            tst.b   D1
            bne.b   .L15
            bsr.w   sub_408E054C
.L17:
            swap    D1
            move.b  ($2D,A0),D2
            sub.b   ($2C,A0),D2
            beq.b   .L19
.L18:
            clr.w   (6,A1)
            lea     ($C,A1),A1
            subq.b  #1,D2
            bne.b   .L18
.L19:
            move.w  ($2E,A0),D0
            move    SR,-(SP)
            move    #$2600,SR
            bsr.b   sub_408DFA38
            bne.w   sub_408DFA5A.L3
            move.l  A0,(8,A1)
            clr.b   (1,A1)
            move.b  ($C,A1),($D,A1)
            bra.w   .L3
.L20:
            bsr.w   sub_408E054C
.L21:
            bra.w   sub_408DF804.L6
sub_408DFA38:
            lea     ($6B2,A2),A1
            moveq   #$1F,D2
.L1:
            cmp.b   (A1),D1
            bne.b   .L2
            addq.w  #2,A1
            bsr.b   sub_408DFA5A
            subq.w  #2,A1
            bne.b   .L2
            cmp.w   (6,A1),D0
            beq.b   .L3
.L2:
            lea     ($E,A1),A1
            dbra    D2,.L1
.L3:
            rts
sub_408DFA5A:
            cmp.l   (A1),D3
            beq.b   .L1
            cmp.w   (2,A1),D3
            bne.b   .L1
            tst.w   (A1)
            beq.b   .L1
            move.l  D3,-(SP)
            tst.w   (SP)+
            addq.w  #2,SP
.L1:
            rts
            move.w  #$FBB4,D0
            move.b  ($2C,A0),D2
            cmpi.b  #8,D2
            bcc.b   sub_408DF8BC.L21
            bsr.w   sub_408E0514
            bne.b   sub_408DF8BC.L21
            moveq   #-$5C,D0
            cmpi.w  #$242,($22,A0)
            bhi.b   sub_408DF8BC.L21
            lea     ($60,A3),A3
            moveq   #-$80,D0
            or.b    ($1D,A0),D0
            move.b  D0,(A3)+
            move.b  D2,(A3)+
            move.w  ($2E,A0),(A3)+
            bsr.w   sub_408DFDC6
            bsr.w   sub_408DFD04
            bsr.w   sub_408E054C
            move.w  ($2E,A0),D0
            move    SR,-(SP)
            move    #$2600,SR
            bsr.b   sub_408DFA38
            bne.b   .L3
            movea.l (8,A1),A3
            move.w  #$FBB1,D0
            move.l  A3,D2
            beq.b   .L4
            move.b  ($1D,A0),D2
            or.b    D2,($1D,A3)
            clr.w   D2
            move.b  ($2C,A0),D2
            lea     ($2C,A3),A3
            cmp.b   (A3),D2
            blt.b   .L2
            move.b  D2,(A3)
            addq.b  #1,(A3)
.L2:
            movea.l -(A3),A3
            mulu.w  #$C,D2
            adda.w  D2,A3
            move.w  ($22,A0),(A3)+
            move.l  ($24,A0),(A3)+
            move.w  #$FFFF,(A3)+
            move.l  ($12,A0),(A3)
            clr.b   (1,A1)
            move.b  ($C,A1),($D,A1)
.L3:
            clr.w   D0
.L4:
            move    (SP)+,SR
.L5:
            bra.w   sub_408DF804.L6
            bsr.w   sub_408DFC68
            move.w  #$FBB7,D0
            moveq   #$B,D2
.L6:
            tst.b   (4,A2,D2.w)
            dbeq    D2,.L6
            bne.b   .L5
            bsr.w   sub_408DFBFE
            bne.b   .L5
            clr.b   D1
            lea     sub_408E0214,A1
            move.l  A1,($1E,A3)
            move.w  #$F8,D0
            bsr.w   sub_408DFD70
            beq.b   .L7
            bsr.w   sub_408E054C
            bra.b   .L5
.L7:
            move.b  ($1C,A3),D1
            bsr.w   sub_408DFC48
            move.l  A0,($10,A2,D2.w)
            lea     ($876,A2),A1
            move.w  (A1),($16,A0)
            bset    #1,($1D,A0)
            addq.w  #1,(A1)
            lsr.w   #2,D2
            move.b  D1,(4,A2,D2.w)
            lea     ($40,A2,D2.w),A1
            clr.b   (A1)
            move.l  A1,-(SP)
            bsr.b   sub_408DFB80
            movea.l (SP)+,A1
            bsr.w   sub_408DFDAA
            bsr.w   sub_408DFD04
            bsr.w   sub_408E054C
            move.b  ($2D,A0),(A1)
            moveq   #0,D0
            rts
sub_408DFB80:
            move    SR,-(SP)
            move    #$2600,SR
            bra.w   sub_408DF8BC.L3
            bsr.w   sub_408DFC68
            bsr.b   sub_408DFBFE
            bne.w   sub_408DF804.L6
            bsr.w   sub_408DFC48
            move    SR,-(SP)
            move    #$2600,SR
.L1:
            lea     ($2C2,A2),A1
            adda.w  D2,A1
            move.w  ($876,A2),D3
            moveq   #0,D0
.L2:
            tst.l   (A1)
            beq.b   .L3
            addq.w  #1,D0
            movea.l (A1),A1
            cmp.w   ($16,A1),D3
            bne.b   .L2
            addq.w  #1,($876,A2)
            bra.b   .L1
.L3:
            move    (SP)+,SR
            cmp.w   ($BCC,A2),D0
            bcs.b   .L4
            bsr.w   sub_408E054C
            move.w  #$FBB7,D0
            bra.w   sub_408DF804.L6
.L4:
            move.w  D3,($16,A0)
            bset    #1,($1D,A0)
            addq.w  #1,($876,A2)
            move.b  ($2D,A0),($30,A0)
            lea     ($2C2,A2),A1
            adda.w  D2,A1
            bsr.w   sub_408DF8BC
            bsr.w   sub_408DFDAA
            bsr.w   sub_408DFD04
            moveq   #0,D0
            bra.w   sub_408E054C
sub_408DFBFE:
            movea.l ($2D8).w,A1
            tst.w   ($340,A1)
            bpl.b   .L3
            cmpi.b  #6,($21,A0)
            bne.b   .L3
            cmpi.b  #$FE,($20,A0)
            bne.b   .L3
            cmpi.w  #1,($14,A0)
            bne.b   .L2
.L1:
            move.l  ($33A,A1),D0
            lsl.l   #8,D0
            move.b  #6,D0
            move.l  D0,($BCE,A2)
.L2:
            move.l  ($BCE,A2),($1E,A0)
            beq.b   .L1
.L3:
            moveq   #-$5C,D0
            cmpi.w  #$242,($22,A0)
            bhi.b   .L4
            bsr.w   sub_408E0514
.L4:
            tst.w   D0
            rts
sub_408DFC48:
            lea     ($1D,A0),A1
            bclr    #4,(A1)
            clr.b   -(A1)
            move.b  ($2C,A0),D0
            beq.b   .L2
            subq.b  #1,D0
.L1:
            bset    D0,(A1)
            subq.b  #1,D0
            bpl.b   .L1
.L2:
            clr.b   ($2E,A0)
            lsl.w   #2,D2
            rts
sub_408DFC68:
            movem.l A0-A2,-(SP)
            movea.l ($2D8).w,A2
            tst.w   ($340,A2)
            bpl.w   .L5
            move.l  ($410,A2),D0
            beq.b   .L1
            movea.l D0,A1
            move.w  #6,D0
            jsr     (A1)
            bne.b   .L5
.L1:
            cmpi.b  #6,($21,A0)
            bne.b   .L5
            cmpi.b  #7,($12,A0)
            bne.b   .L5
            move.w  ($1E,A0),D0
            beq.b   .L2
            cmp.w   ($344,A2),D0
            bcs.b   .L5
            cmp.w   ($346,A2),D0
            bhi.b   .L5
.L2:
            clr.b   ($1C,A0)
            move.b  #$10,($1D,A0)
            move.b  #1,($2E,A0)
            movea.l ($28,A0),A1
            lea     ($356,A2),A0
            moveq   #1,D0
            add.b   (A0),D0
            tst.b   ($352,A2)
            beq.b   .L3
            cmp.w   (A1),D0
            bgt.b   .L3
            move.l  #1,(8,A1)
            move.w  D0,(6,A1)
            movea.l (2,A1),A1
            _BlockMove
            moveq   #0,D0
            bra.b   .L4
.L3:
            clr.w   ($2E,A0)
            move.b  #1,($1C,A0)
            move.w  #$FBB8,D0
.L4:
            movem.l (SP)+,A0-A2
            addq.w  #4,SP
            bra.w   sub_408DF804.L7
.L5:
            movem.l (SP)+,A0-A2
            rts
sub_408DFD04:
            movem.l A0-A1,-(SP)
            btst    #0,($1D,A0)
            sne     ($1D,A3)
            andi.b  #$F8,($60,A3)
            bmi.b   .L1
            btst    #5,($1D,A0)
            beq.b   .L1
            btst    #2,($1D,A0)
            beq.b   .L1
            move.w  D0,-(SP)
            move.b  ($32,A0),D0
            andi.b  #7,D0
            or.b    D0,($60,A3)
            move.w  (SP)+,D0
.L1:
            lea     ($3A,A3),A1
            move.l  A1,($1E,A3)
            addq.w  #2,A1
            lea     ($4F,A3),A0
            move.l  A0,(A1)+
            move.b  #3,($F,A0)
            addq.w  #7,A0
            move.l  D3,(A0)+
            move.w  D3,(A0)+
            move.b  D3,(A0)
            move.w  #8,(A1)+
            lea     ($60,A3),A0
            move.l  A0,(A1)+
            move.w  D0,(A1)+
            move.l  D2,(A1)+
            clr.w   (A1)+
            movem.l (SP)+,A0-A1
            move.w  #$F6,D0
sub_408DFD70:
            movem.l D1-D3/A0-A1,($22,A3)
            move.l  (SP)+,($36,A3)
            lea     sub_408DFD92,A0
            move.l  A0,($C,A3)
            movea.l A3,A0
            move.b  D1,($1C,A0)
            move.w  D0,($1A,A0)
            _Control async
            moveq   #0,D0
            rts
sub_408DFD92:
            movea.l A0,A3
            move.l  ($36,A0),-(SP)
            movem.l ($22,A0),D1-D3/A0-A1
            movea.l ($2D8).w,A2
            movea.l ($1E,A2),A2
            tst.w   D0
            rts
sub_408DFDAA:
            lea     ($60,A3),A3
            moveq   #$40,D0
            or.b    ($1D,A0),D0
            bclr    #4,D0
            move.b  D0,(A3)+
            move.b  ($1C,A0),(A3)+
            move.w  ($16,A0),(A3)+
            move.l  ($1E,A0),D3
sub_408DFDC6:
            move.l  ($12,A0),(A3)
            move.w  ($22,A0),D0
            move.l  ($24,A0),D2
            suba.w  #$64,A3
.L1:
            rts
sub_408DFDD8:
            move.w  D2,D0
            lsl.w   #2,D0
            adda.w  D0,A2
            movea.l ($2C2,A2),A0
            suba.w  D0,A2
            move.l  A0,D0
            rts
sub_408DFDE8:
            move.w  #$FBB8,D0
            bra.w   sub_408DFF5E
sub_408DFDF0:
            cmpi.b  #$FF,($2F,A0)
            beq.b   .L1
            subq.b  #1,($2F,A0)
.L1:
            rts
sub_408DFDFE:
            move.w  D2,D0
            lsl.w   #2,D0
            lea     ($2C2,A2),A1
            adda.w  D0,A1
            move    SR,-(SP)
            move    #$2600,SR
.L1:
            move.l  (A1),D0
            beq.b   .L4
            sub.l   A0,D0
            _StripAddress
            tst.l   D0
            beq.b   .L2
            movea.l (A1),A1
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
.L3:
            move    (SP)+,SR
            tst.w   D0
            rts
.L4:
            move.w  #$FBB2,D0
            bra.b   .L3
sub_408DFE2C:
            lea     (-$878,A0),A2
            move.w  #6,($A,A0)
            move.l  TimeLM,D0
            cmp.l   ($886,A2),D0
            beq.b   sub_408DFDC6.L1
            bset    #7,($BCA,A2)
            beq.b   sub_408DFE50
            move.w  #1,($A,A0)
            rts
sub_408DFE50:
            move.l  D0,($886,A2)
            bsr.w   sub_408E0514
            bne.w   .L13
            moveq   #$C,D2
.L1:
            move    SR,-(SP)
            move    #$2600,SR
.L2:
            subq.w  #1,D2
            bmi.b   .L4
            move.b  (4,A2,D2.w),D1
            beq.b   .L2
            lea     ($40,A2,D2.w),A1
            tst.b   (A1)
            beq.b   .L2
            subq.b  #1,(A1)
            bne.b   .L2
            move.w  D2,D3
            lsl.w   #2,D3
            movea.l ($10,A2,D3.w),A0
            bsr.w   sub_408DFDF0
            bcs.b   .L3
            move.b  ($2D,A0),(A1)
            movea.w D2,A1
            bsr.w   sub_408DFDAA
            move    (SP)+,SR
            bsr.w   sub_408DFD04
            move.w  A1,D2
            bra.b   .L1
.L3:
            move    (SP)+,SR
            clr.b   (4,A2,D2.w)
            move.w  #$F7,D0
            bsr.w   sub_408DFD70
            bsr.w   sub_408DFDE8
            bra.b   .L1
.L4:
            moveq   #$7E,D2
.L5:
            subq.w  #1,D2
            bmi.b   .L12
            move.b  ($4C,A2,D2.w),D1
            beq.b   .L5
            bsr.w   sub_408DFDD8
            beq.b   .L5
.L6:
            subq.b  #1,($30,A0)
            movea.l (A0),A0
            move.l  A0,D0
            bne.b   .L6
.L7:
            bsr.w   sub_408DFDD8
            beq.b   .L5
.L8:
            tst.b   ($30,A0)
            beq.b   .L9
            movea.l (A0),A0
            move.l  A0,D0
            bne.b   .L8
            bra.b   .L5
.L9:
            bsr.w   sub_408DFDF0
            bcs.b   .L11
            move.b  ($2D,A0),($30,A0)
            movea.w D2,A1
            bsr.w   sub_408DFDAA
            move    (SP)+,SR
            bsr.w   sub_408DFD04
            move.w  A1,D2
.L10:
            move    SR,-(SP)
            move    #$2600,SR
            bra.b   .L7
.L11:
            bsr.w   sub_408DFDFE
            move    (SP)+,SR
            bsr.w   sub_408DFDE8
            bra.b   .L10
.L12:
            move    (SP)+,SR
            bsr.w   sub_408E054C
.L13:
            move    SR,-(SP)
            move    #$2600,SR
            moveq   #$20,D2
            lea     ($6B2,A2),A3
.L14:
            subq.w  #1,D2
            bmi.b   .L17
            tst.b   (A3)+
            beq.b   .L16
            subq.b  #1,($C,A3)
            bpl.b   .L15
            addq.b  #1,(A3)
            move.b  ($B,A3),($C,A3)
.L15:
            cmpi.b  #$1E,(A3)
            bne.b   .L16
            movea.l (7,A3),A0
            clr.b   (-1,A3)
            move.l  A0,D0
            beq.b   .L16
            move.w  #$FBB3,D0
            bsr.b   sub_408DFF5E
.L16:
            lea     ($D,A3),A3
            bra.b   .L14
.L17:
            move    (SP)+,SR
            bclr    #7,($BCA,A2)
            rts
sub_408DFF5E:
            move.w  D0,($10,A0)
            movem.l D1-D3/A0-A3,-(SP)
            move.l  ($C,A0),D1
            beq.b   .L1
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L1:
            movem.l (SP)+,D1-D3/A0-A3
            rts
            movea.l ($2C,A0),A0
            cmpi.w  #$F8,($1A,A0)
            bne.b   .L5
            moveq   #$7D,D2
.L2:
            tst.b   ($4C,A2,D2.w)
            beq.b   .L3
            bsr.w   sub_408DFDFE
            beq.b   .L12
.L3:
            dbra    D2,.L2
.L4:
            move.w  #$FBB2,D0
            bra.w   sub_408DF804.L6
.L5:
            moveq   #$B,D2
.L6:
            tst.b   (4,A2,D2.w)
            beq.b   .L7
            move.w  D2,D0
            lsl.w   #2,D0
            move.l  ($10,A2,D0.w),D0
            sub.l   A0,D0
            _StripAddress
            tst.l   D0
            beq.b   .L11
.L7:
            dbra    D2,.L6
            bra.b   .L4
            move.w  ($2E,A0),D1
            moveq   #$B,D2
.L8:
            tst.b   (4,A2,D2.w)
            beq.b   .L9
            move.w  D2,D0
            lsl.w   #2,D0
            movea.l ($10,A2,D0.w),A0
            cmp.w   ($16,A0),D1
            bne.b   .L9
            lea     ($1E,A0),A1
            bsr.w   sub_408DFA5A
            beq.b   .L11
.L9:
            dbra    D2,.L8
.L10:
            move.w  #$FBB2,D0
            bra.w   sub_408DF804.L6
.L11:
            bsr.w   sub_408E0514
            bne.w   sub_408DF804.L6
            move.b  (4,A2,D2.w),D1
            clr.b   (4,A2,D2.w)
            move.w  #$F7,D0
            bsr.w   sub_408DFD70
            bsr.w   sub_408E054C
.L12:
            move.w  #$FBAF,D0
            bsr.w   sub_408DFF5E
.L13:
            bra.w   sub_408DF804.L5
            move.w  ($2E,A0),D0
            bsr.w   sub_408DFA38
            bne.b   .L10
            movea.l (8,A1),A0
            clr.b   (A1)
            move.l  A0,D0
            beq.b   .L14
            clr.w   D0
            bsr.w   sub_408DFF5E
.L14:
            bra.b   .L13
.L15:
            moveq   #5,D3
            jsr     (2,A4)
            bsr.w   sub_408E04A0
            bne.b   .L18
            move.l  D1,D3
            move.w  (-6,A3),D0
            move.b  (-$A,A3),D1
            movea.l ($1E,A2),A2
            bsr.w   sub_408DFA38
            bne.b   .L18
            clr.b   (A1)
            move.l  (8,A1),D0
            beq.b   .L18
            movea.l D0,A0
            move.l  -(A3),($12,A0)
            clr.w   D0
            bra.w   sub_408DFF5E
.L16:
            add.b   D3,D3
            bpl.w   sub_408E0092.L2
            move.w  #5,D3
            jsr     (A4)
            bne.b   .L18
            adda.w  D2,A5
            movea.l ($CA,A5),A5
            move.l  A5,D3
            beq.b   .L17
            move.w  ($22,A5),D3
            movea.l ($24,A5),A3
.L17:
            jsr     (2,A4)
            bsr.w   sub_408E04A0
            beq.w   sub_408E0344.L2
.L18:
            rts
sub_408E0092:
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            subq.w  #4,A2
            move.l  A2,D2
            movea.l ($2D8).w,A2
            sub.l   A2,D2
            addi.w  #$1F8,D2
            moveq   #3,D3
            cmpi.b  #3,-(A3)
            bne.b   .L2
            jsr     (A4)
            bne.b   .L7
            movea.l ($1E,A2),A5
            move.b  (-3,A3),D3
            bpl.b   .L3
            add.b   D3,D3
            bmi.b   .L4
            adda.w  D2,A5
            movea.l ($2C2,A5),A5
            move.l  A5,D0
            beq.b   .L2
            moveq   #3,D3
            jsr     (A4)
            bne.b   .L7
            move.w  (-4,A3),D0
.L1:
            cmp.w   ($16,A5),D0
            beq.b   .L5
            movea.l (A5),A5
            move.l  A5,D3
            bne.b   .L1
.L2:
            clr.w   D3
            jmp     (2,A4)
.L3:
            bra.w   sub_408DFF5E.L16
.L4:
            bra.w   sub_408DFF5E.L15
.L5:
            moveq   #2,D3
            jsr     (A4)
            bne.b   .L7
.L6:
            move.b  (-7,A3),D3
            cmp.b   ($2C,A5),D3
            bcc.b   .L2
            asl.w   #2,D3
            move.w  D3,D0
            add.w   D0,D3
            add.w   D0,D3
            movea.l ($28,A5),A3
            adda.w  D3,A3
            move.w  (A3)+,D3
            movea.l (A3)+,A3
            move.l  A5,-(SP)
            jsr     (2,A4)
            bsr.w   sub_408E04A0
            movea.l (SP)+,A0
            beq.b   sub_408E0214.L2
.L7:
            rts
sub_408E0214:
            moveq   #8,D3
            cmpi.b  #3,-(A3)
            bne.b   sub_408E0092.L2
            jsr     (A4)
            bne.b   sub_408E0092.L7
            movea.l ($1E,A2),A5
            move.b  (-$A,A3),D0
            move.b  (-8,A3),D2
            bpl.b   sub_408E0092.L2
            add.b   D2,D2
            bmi.b   sub_408E0092.L2
            moveq   #$B,D2
            lea     ($10,A5),A5
.L1:
            cmp.b   -(A5),D0
            dbeq    D2,.L1
            bne.b   sub_408E0092.L2
            suba.w  D2,A5
            lsl.w   #2,D2
            adda.w  D2,A5
            movea.l ($C,A5),A5
            move.w  (-6,A3),D0
            cmp.w   ($16,A5),D0
            beq.b   sub_408E0092.L6
            bra.w   sub_408E0092.L2
.L2:
            movea.l ($1E,A2),A2
            lea     ($1E,A0),A1
            exg     D1,D3
            bsr.w   sub_408DFA5A
            exg     D1,D3
            bne.b   sub_408E0092.L7
            move.l  -(A3),D1
            move.w  -(A3),D0
            cmp.w   ($16,A0),D0
            bne.b   sub_408E0092.L7
            move.b  -(A3),D0
            cmpi.b  #7,D0
            bhi.b   sub_408E0092.L7
            ext.w   D0
            mulu.w  #$C,D0
            movea.l ($28,A0),A1
            adda.w  D0,A1
            move.w  (A1),D0
            addq.w  #6,A1
            sub.w   D3,D0
            move.w  D0,(A1)+
            move.l  D1,(A1)+
            lea     ($1C,A0),A1
            move.b  (A3),D3
            swap    D2
            move.b  D3,D2
            swap    D2
            subq.w  #1,A3
            bclr    D3,(A1)
            beq.b   .L4
            addq.b  #1,($2E,A0)
            moveq   #4,D1
            btst    D1,(A3)
            beq.b   .L4
.L3:
            bclr    D3,(A1)
            addq.b  #1,D3
            cmpi.b  #8,D3
            bne.b   .L3
            bset    D1,($1D,A0)
.L4:
            move.b  (-2,A3),D1
            btst    #3,(A3)
            beq.b   .L5
            bsr.w   sub_408E0514
            bne.b   .L5
            movea.l D2,A1
            bsr.w   sub_408DFDAA
            bsr.b   sub_408E0344
            bsr.w   sub_408DFD04
            bsr.w   sub_408E054C
            move.l  A1,D2
.L5:
            tst.b   ($1C,A0)
            bne.b   sub_408E0344.L1
            bsr.w   sub_408E0514
            beq.b   .L6
            swap    D2
            bset    D2,($1C,A0)
            bra.b   sub_408E0344.L1
.L6:
            move.w  ($16,A0),($62,A3)
            lsr.w   #2,D2
            cmpi.w  #$F8,($1A,A0)
            bne.b   .L7
            bsr.w   sub_408DFDFE
            bra.b   .L8
.L7:
            clr.b   (4,A2,D2.w)
.L8:
            bsr.b   sub_408E0344
            btst    #5,($1D,A0)
            beq.b   .L9
            move.l  ($1E,A0),D3
            move.b  #$C0,($60,A3)
            clr.l   ($64,A3)
            clr.w   D0
            bsr.w   sub_408DFD04
.L9:
            cmpi.w  #$F8,($1A,A0)
            beq.b   .L10
            move.w  #$F7,D0
            bsr.w   sub_408DFD70
.L10:
            bsr.w   sub_408E054C
            clr.w   D0
            bra.w   sub_408DFF5E
sub_408E0344:
            move.l  A1,-(SP)
            movea.l ($2D8).w,A1
            move    ($1C,A1),SR
            movea.l (SP)+,A1
.L1:
            rts
.L2:
            movea.l ($1E,A2),A2
            movea.l -(A3),A1
            move.w  -(A3),D0
            btst    #5,(-2,A3)
            beq.b   .L6
            movem.l D0-D4/A1/A3,-(SP)
            move.l  D1,D3
            move.b  (-4,A3),D1
            move.w  D2,D4
            bsr.w   sub_408DFA38
            beq.b   .L7
            adda.w  D4,A2
            tst.l   ($CA,A2)
            suba.w  D4,A2
            beq.b   .L5
            lea     ($6B2,A2),A1
            moveq   #$1F,D2
.L3:
            tst.b   (A1)
            beq.b   .L4
            lea     ($E,A1),A1
            dbra    D2,.L3
            movem.l (SP)+,D0-D4/A1/A3
            rts
.L4:
            move.b  D1,(A1)+
            clr.b   (A1)+
            move.l  D3,(A1)+
            move.w  D0,(A1)+
            clr.l   (A1)+
            clr.w   (A1)
            move.b  (-2,A3),D0
            andi.b  #7,D0
            cmpi.b  #4,D0
            bhi.b   .L5
            moveq   #1,D1
            lsl.b   D0,D1
            subq.b  #1,D1
            move.b  D1,(A1)+
            move.b  D1,(A1)
.L5:
            movem.l (SP)+,D0-D4/A1/A3
.L6:
            bra.w   .L11
.L7:
            movea.l A1,A0
            movem.l (SP)+,D0-D4/A1/A3
            move.l  D1,D3
            move.b  (-4,A3),D1
            clr.b   (1,A0)
            move.b  ($C,A0),($D,A0)
            move.l  (8,A0),D2
            beq.b   .L10
            swap    D1
            move.b  -(A3),D1
            movea.l D2,A0
            movea.l ($28,A0),A1
            move.w  D0,D2
            bsr.w   sub_408E0514
            bne.b   .L10
            move.b  #$80,($60,A3)
            st      ($61,A3)
            move.w  D2,($62,A3)
            bsr.w   sub_408E0344
.L8:
            addq.b  #1,($61,A3)
            move.b  ($61,A3),D0
            sub.b   ($2C,A0),D0
            bge.w   sub_408E054C
            addq.b  #1,D0
            bne.b   .L9
            move.b  ($1D,A0),D0
            or.b    D0,($60,A3)
.L9:
            move.w  (A1)+,D0
            move.l  (A1)+,D2
            addq.w  #2,A1
            move.l  (A1)+,($64,A3)
            lsr.w   #1,D1
            bcc.b   .L8
            tst.w   (-6,A1)
            beq.b   .L8
            swap    D1
            movem.l D0/D2/A1,-(SP)
            move.w  ($62,A3),D0
            bsr.w   sub_408DFA38
            movem.l (SP)+,D0/D2/A1
            bne.w   sub_408E054C
            bsr.w   sub_408DFD04
            swap    D1
            bra.b   .L8
.L10:
            rts
.L11:
            adda.w  D2,A2
            move.l  ($CA,A2),-(SP)
            suba.w  D2,A2
            movea.l (SP)+,A0
            beq.b   .L10
            move.l  A1,($12,A0)
            move.b  -(A3),($2C,A0)
            move.w  D0,($2E,A0)
            lea     ($1D,A0),A1
            move.b  -(A3),(A1)+
            move.l  D1,(A1)
            lea     ($4BA,A2),A3
            adda.w  D2,A3
            cmpm.w  (A1)+,(A3)+
            beq.b   .L12
            tst.w   (-2,A3)
            bne.b   .L10
.L12:
            moveq   #2,D0
.L13:
            cmpm.b  (A1)+,(A3)+
            beq.b   .L14
            tst.b   (-1,A3)
            bne.b   .L10
.L14:
            subq.w  #1,D0
            bne.b   .L13
            sub.w   D3,(A1)
            adda.w  D2,A2
            move.l  (A0),($CA,A2)
            suba.w  D2,A2
            bra.w   sub_408DFF5E
sub_408E04A0:
            bne.b   .L6
            moveq   #0,D1
            lea     (2,A2),A0
            move.b  (7,A2),D0
            move.b  (A0)+,D1
            subq.b  #1,(A0)+
            beq.b   .L4
            movem.l D2-D4,-(SP)
            move.w  (A0)+,D1
            move.w  (A0)+,D4
            beq.b   .L3
            moveq   #8,D2
            clr.w   D3
            bsr.b   sub_408E0508
            addq.w  #3,D3
            rol.w   #1,D3
            moveq   #8,D2
            bsr.b   sub_408E0508
            andi.w  #$3FF,D1
            subi.w  #$15,D1
            beq.b   .L1
            movea.l A3,A0
            suba.w  D1,A0
            move.w  D1,D2
            bsr.b   sub_408E0508
.L1:
            tst.w   D3
            bne.b   .L2
            subq.w  #1,D3
.L2:
            cmp.w   D4,D3
.L3:
            movem.l (SP)+,D2-D4
            bne.b   .L6
            move.l  ($A,A2),D1
            move.b  ($D,A2),D1
            move.b  ($F,A2),D0
            lea     ($18,A2),A3
            bra.b   .L5
.L4:
            lea     ($10,A2),A3
.L5:
            lsl.w   #8,D1
            move.b  D0,D1
            clr.w   D0
.L6:
            rts
sub_408E0508:
            move.b  (A0)+,D0
            add.w   D0,D3
            rol.w   #1,D3
            subq.w  #1,D2
            bne.b   sub_408E0508
            rts
sub_408E0514:
            movea.l ABusDCE,A3
            move.w  ($18,A3),D0
            lea     ($88A,A2),A3
            move.l  D1,-(SP)
            moveq   #8,D1
            move    SR,-(SP)
            move    #$2600,SR
.L1:
            tst.w   ($18,A3)
            beq.b   .L3
            lea     ($68,A3),A3
            subq.w  #1,D1
            bne.b   .L1
            move.w  #$FBB0,D0
.L2:
            move    (SP)+,SR
            move.l  (SP)+,D1
            tst.w   D0
            rts
.L3:
            move.w  D0,($18,A3)
            clr.w   D0
            bra.b   .L2
sub_408E054C:
            clr.w   ($18,A3)
            rts
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF
            dc.b    '. 1989-1990]'
RsrcEntryDRVR_9:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 9 ".MPP" (19636 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_10-BaseOfROM      ; Next entry
            dc.l    RsrcDRVR_9-BaseOfROM            ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    9                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'.MPP'                        ; Name
            dc.b    'SHJMAAGC'
            dc.l    $C0A00000,$00004CC0,$0000021C   ; Block header
RsrcDRVR_9:
            dc.w    $5C00                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    MPPOpen-RsrcDRVR_9              ; drvrOpen
            dc.w    MPPPrime-RsrcDRVR_9             ; drvrPrime
            dc.w    MPPCtl-RsrcDRVR_9               ; drvrCtl
            dc.w    MPPStatus-RsrcDRVR_9            ; drvrStatus
            dc.w    MPPClose-RsrcDRVR_9             ; drvrClose
            dc.b    4,'.MPP'
            dc.b    $20
.L1:
            dc.b    $38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$35
            dc.b    '.MPP DRVR v56.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1984-1991'
.L2:
            dc.w    $317C,$7FFF,$000A,$A065,$4A80,$6B08,$0C80,0
            dc.w    $0200,$6408,$317C,$0001,$000A
.L3:
            rts
            lea     (-$292,A0),A2
            move.b  ($2CE,A2),D0
            clr.b   ($2CE,A2)
            tst.b   D0
            beq.b   .L3
            movea.l ($330,A2),A1
            movea.l (8,A1),A0
MPPCtl:
            movea.l ($14,A1),A2
            btst    #$1E,($33E,A2)
            beq.b   .L2
            move.w  (6,A0),D0
            btst    #9,D0
            bne.b   .L2
            btst    #$A,D0
            beq.b   .L2
            movea.l ($328,A2),A2
            cmpa.w  #0,A2
            beq.b   .L2
            tst.b   ($32F,A2)
            bne.b   .L2
            _StackSpace
            tst.l   D0
            bmi.b   .L1
            cmpi.l  #$200,D0
            bcc.b   .L2
.L1:
            movea.l ($14,A1),A2
            st      ($2CE,A2)
            move.w  #1,($29C,A2)
            rts
.L2:
            move.l  AtalkHk1,D3
            ble.b   .L3
            movea.l D3,A2
            jsr     (A2)
.L3:
            movea.l ($14,A1),A2
            move.w  ($1A,A0),D3
            bmi.w   sub_408E14B4.L7
            cmpi.w  #2,D3
            beq.b   .L5
            cmpi.w  #1,D3
            bne.b   .L4
            rts
.L4:
            moveq   #-$11,D0
            subi.w  #$F2,D3
            bcs.w   MPPStatus.L4
            cmpi.w  #$16,D3
            bgt.w   MPPStatus.L4
            move.b  ($1C,A0),D1
            movea.l ($1E,A0),A1
            cmpi.w  #7,D3
            bgt.w   sub_408E151E.L1
            lea     .L6,A3
            adda.w  D3,A3
            adda.w  D3,A3
            movea.w (A3),A3
            pea     RsrcDRVR_9
            adda.l  (SP)+,A3
            jmp     (A3)
.L5:
            moveq   #0,D0
            rts
.L6:
            dc.w    $07FC,$15B8,$15A4,$1566,$0204,$01A2,$0148,$0808
            bsr.b   .L14
            move.b  D1,($1C,A0)
            bra.b   .L12
.L14:
            moveq   #-$5B,D0
            move    SR,-(SP)
            move    #$2600,SR
            tst.b   D1
            beq.b   .L15
            bmi.b   .L8
            bsr.b   sub_408E0ED8
            beq.b   .L8
            moveq   #$D,D2
.L16:
            tst.b   ($4C,A2,D2.w)
            dbeq    D2,.L16
            bne.b   .L8
            move.b  D1,($4C,A2,D2.w)
            lsl.w   #2,D2
            move.l  A1,($5A,A2,D2.w)
.L7:
            clr.w   D0
.L8:
            move    (SP)+,SR
            rts
.L15:
            move.w  #$1F8,D2
            move.l  A3,D1
            lea     ($292,A2),A3
.L9:
            tst.l   -(A3)
            beq.b   .L10
            subq.w  #4,D2
            bpl.b   .L9
            movea.l D1,A3
            bra.b   .L8
.L10:
            move.l  A1,(A3)
            movea.l D1,A3
            lsr.w   #2,D2
            addi.b  #$80,D2
            move.b  D2,D1
            bra.b   .L7
            moveq   #-$5B,D0
            tst.b   D1
            beq.b   .L12
            bmi.b   .L13
            bsr.b   sub_408E0ED8
            bne.b   .L12
            clr.b   ($4C,A2,D2.w)
.L11:
            clr.w   D0
.L12:
            bra.w   sub_408E14B4.L9
.L13:
            bsr.b   sub_408E0EE4
            tst.w   D2
            bmi.b   .L12
            adda.w  D2,A2
            clr.l   ($96,A2)
            suba.w  D2,A2
            bra.b   .L11
sub_408E0ED8:
            moveq   #$D,D2
.L1:
            cmp.b   ($4C,A2,D2.w),D1
            dbeq    D2,.L1
            rts
sub_408E0EE4:
            moveq   #0,D2
            move.b  D1,D2
            cmpi.w  #$FE,D2
            bhi.b   .L1
            subi.w  #$80,D2
            lsl.w   #2,D2
            adda.w  D2,A2
            tst.l   ($96,A2)
            suba.w  D2,A2
            bne.b   .L2
.L1:
            moveq   #-1,D2
.L2:
            rts
            move.b  ($1D,A0),D3
            swap    D3
            st      D3
            movea.l (2,A1),A3
            move.b  ($E,A3),D1
            bra.b   .L3
            sub.l   D3,D3
            move.b  ($1D,A0),D3
            swap    D3
.L3:
            movea.l ($2AC,A2),A3
            jsr     (A3)
            bra.b   MPPCtl.L12
sub_408E0F24:
            subq.w  #1,D0
.L1:
            move.b  (A0)+,D1
            add.w   D1,D3
            rol.w   #1,D3
            dbra    D0,.L1
.L2:
            rts
sub_408E0F32:
            bra.b   .L1
            bra.w   MPPCtl.L14
.L1:
            tst.b   D3
            bne.b   .L2
            moveq   #-$5B,D0
            tst.b   D1
            beq.b   sub_408E0F24.L2
            bsr.b   sub_408E0EE4
            tst.w   D2
            bpl.b   .L2
            bsr.b   sub_408E0ED8
            bne.b   sub_408E0F24.L2
.L2:
            move.l  ($410,A2),D0
            beq.b   .L3
            movea.l D0,A0
            moveq   #3,D0
            jsr     (A0)
.L3:
            move.l  A1,-(SP)
            addq.w  #2,A1
            movea.l (A1)+,A3
            addq.w  #7,A3
            move.b  D1,(7,A3)
            clr.b   ($2C8,A2)
            moveq   #0,D2
            move.w  ($1A,A2),D2
            tst.w   ($340,A2)
            bmi.b   .L5
            tst.b   D3
            bne.b   .L5
            move.w  (A3),D0
            beq.b   .L4
            cmp.w   D2,D0
            bne.b   .L5
.L4:
            movea.l A3,A0
            addq.w  #8,A0
            move.b  (A0),(A3)
            move.w  -(A0),-(A3)
            subq.w  #2,A0
            lsl.l   #8,D2
            move.b  (A0),D2
            moveq   #1,D3
            moveq   #8,D0
            bra.w   sub_408E105A.L2
.L5:
            tst.b   D3
            bne.b   .L6
            move.w  D2,(2,A3)
            move.b  (A2),(5,A3)
.L6:
            move.b  D3,D0
            swap    D3
            tst.b   D0
            beq.b   .L7
            tst.b   D3
            bne.b   .L7
            subq.w  #2,A3
            bra.b   .L10
.L7:
            movea.l A3,A0
            clr.w   -(A3)
            tst.b   D3
            beq.b   .L10
            moveq   #9,D0
            clr.w   D3
            clr.w   D1
.L8:
            bsr.w   sub_408E0F24
            move.w  (A1)+,D0
            beq.b   .L9
            movea.l (A1)+,A0
            bra.b   .L8
.L9:
            move.w  D3,(A3)
            bne.b   .L10
            subq.w  #1,(A3)
.L10:
            move.b  (6,A3),D1
            moveq   #2,D3
            moveq   #$10,D0
            tst.w   ($340,A2)
            bmi.b   .L12
            move.w  (2,A3),D2
            beq.b   .L11
            cmp.w   (4,A3),D2
            beq.b   .L11
            tst.w   (4,A3)
            bne.b   .L14
            move.w  ($1A,A2),D2
            beq.b   .L11
            cmp.w   (2,A3),D2
            bne.b   .L14
.L11:
            lsl.l   #8,D2
            move.b  D1,D2
            bra.b   sub_408E105A.L2
.L12:
            move.w  (2,A3),D2
            lsl.l   #8,D2
            move.b  D1,D2
            move.w  (2,A3),D1
            bne.b   .L13
            cmpi.b  #$FF,D2
            beq.b   sub_408E105A.L2
            cmpi.b  #$FE,D2
            beq.b   .L14
            clr.w   (A3)
            moveq   #0,D1
            move.w  ($1A,A2),D1
            move.w  D1,(2,A3)
            lsl.l   #8,D1
            add.l   D1,D2
            bra.b   sub_408E105A.L2
.L13:
            cmpi.w  #$FF00,D1
            bcc.b   sub_408E105A.L2
            cmp.w   ($344,A2),D1
            bcs.b   sub_408E105A
            cmp.w   ($346,A2),D1
            bhi.b   sub_408E105A
            cmpi.b  #$FE,D2
            bne.b   sub_408E105A.L2
.L14:
            tst.b   ($19,A2)
            beq.b   .L15
            move.l  ($33A,A2),D2
            bra.b   sub_408E105A.L2
.L15:
            moveq   #-$5D,D0
            addq.w  #4,SP
            rts
sub_408E105A:
            btst    #$1E,($33E,A2)
            bne.b   sub_408E0F32.L14
            lea     ($38C,A2),A1
            move.l  A1,D2
            cmp.w   ($392,A2),D1
            beq.b   .L1
            bsr.w   sub_408E13C4
            bmi.b   sub_408E0F32.L14
.L1:
            move.b  #1,($2C8,A2)
.L2:
            movea.l (SP)+,A1
            move.w  D0,(A1)
            clr.w   D1
            movea.l A1,A0
.L3:
            tst.w   (A0)
            beq.b   .L4
            bmi.b   .L5
            add.w   (A0),D1
            addq.w  #6,A0
            bra.b   .L3
.L4:
            move.w  D1,-(A3)
            subq.w  #3,(A3)
            sub.w   D0,D1
            cmpi.w  #$24A,D1
            bhi.b   .L5
            move.b  D3,-(A3)
            subq.w  #2,A3
            move.b  D2,(A3)
            move.l  A1,($2BA,A2)
            bra.w   sub_408E2378
.L5:
            moveq   #-$5C,D0
.L6:
            bra.w   sub_408E0F24.L2
sub_408E10AE:
            moveq   #6,D3
            jsr     (A4)
            bne.b   sub_408E105A.L6
            move.l  ($410,A2),D0
            beq.b   .L1
            movea.l D0,A5
            moveq   #1,D0
            jsr     (A5)
            bne.b   .L9
.L1:
            moveq   #5,D3
            jsr     (A4)
            bne.b   sub_408E105A.L6
            tst.b   ($335,A2)
            beq.b   .L9
            bra.b   .L3
.L2:
            tst.b   ($335,A2)
            beq.b   .L9
            move.l  ($410,A2),D0
            beq.b   .L3
            movea.l D0,A5
            moveq   #1,D0
            jsr     (A5)
            bne.b   .L9
.L3:
            move.w  (8,A2),D2
            bne.b   .L4
            tst.w   ($340,A2)
            bmi.b   .L6
            bra.b   .L5
.L4:
            move.w  ($1A,A2),D0
            beq.b   .L5
            cmp.w   D2,D0
            bne.b   .L7
.L5:
            move.b  ($C,A2),D0
            cmp.b   (A2),D0
            beq.b   .L8
.L6:
            cmpi.b  #$FF,($C,A2)
            beq.b   sub_408E1134.L1
.L7:
            move.l  ($32C,A2),D0
            beq.b   .L9
            movea.l D0,A5
            RTS5
.L8:
            tst.l   D3
            beq.b   sub_408E1134.L1
            move.w  (4,A2),D2
            andi.w  #$3C00,D2
            beq.b   sub_408E1134.L1
            move.w  ($A,A2),D2
            bsr.w   sub_408E1290
            bra.b   sub_408E1134.L1
.L9:
            moveq   #0,D3
            jmp     (2,A4)
sub_408E1134:
            moveq   #3,D3
            jsr     (A4)
            bne.w   sub_408E105A.L6
            tst.b   ($335,A2)
            beq.b   sub_408E10AE.L9
.L1:
            moveq   #$D,D2
            move.b  (-3,A3),D0
            beq.b   sub_408E10AE.L9
            bpl.b   .L2
            cmpi.b  #$FE,D0
            bhi.b   sub_408E10AE.L9
            moveq   #0,D2
            move.b  D0,D2
            subi.w  #$80,D2
            lsl.w   #2,D2
            lea     ($96,A2),A5
            move.l  (0,A5,D2.w),D2
            beq.b   sub_408E10AE.L9
            movea.l D2,A5
            RTS5
.L2:
            cmp.b   ($4C,A2,D2.w),D0
            dbeq    D2,.L2
            bne.b   sub_408E10AE.L9
            lsl.w   #2,D2
            movea.l ($5A,A2,D2.w),A5
            RTS5
sub_408E117C:
            bsr.w   sub_408E2B44
            movem.l D0-D2/A0-A2,-(SP)
            moveq   #$28,D0
            move.w  #$1F,D1
            swap    D1
            move.w  #$1E,D1
            move.w  #2,D2
            swap    D2
            move.w  #6,D2
            bsr.b   sub_408E11A2
            movem.l (SP)+,D0-D2/A0-A2
            rts
sub_408E11A2:
            move.l  D0,-(SP)
            moveq   #$2A,D0
            _NewPtrSysClear
            movem.l (SP)+,D0
            bne.w   .L6
            movea.l ($2D8).w,A2
            move.l  A0,($3AC,A2)
            movea.l A0,A2
            move.l  #'xBRT',(A2)
            move.w  D0,($A,A2)
            move.w  D1,($C,A2)
            swap    D1
            move.w  D1,(4,A2)
            move.w  D2,(8,A2)
            swap    D2
            move.w  D2,(6,A2)
            moveq   #0,D0
            move.w  (4,A2),D0
            lsl.l   #2,D0
            _NewPtrSysClear
            bne.b   .L5
            move.l  A0,($14,A2)
            moveq   #0,D0
            move.w  (6,A2),D0
            add.w   (8,A2),D0
            addq.w  #6,D0
            move.w  D0,($E,A2)
            mulu.w  ($C,A2),D0
            _NewPtrSysClear
            bne.b   .L4
            move.l  A0,($18,A2)
            moveq   #0,D1
            move.w  ($C,A2),D1
            subq.w  #1,D1
.L1:
            move.l  ($10,A2),(A0)
            move.l  A0,($10,A2)
            adda.w  ($E,A2),A0
            dbra    D1,.L1
            lea     ($1C,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408E1422,A1
            move.l  A1,(6,A0)
            move.w  ($A,A2),D0
            beq.b   .L2
            mulu.w  #$3C,D0
            move.w  D0,($A,A0)
            _VInstall
            tst.w   D0
            bne.b   .L3
.L2:
            rts
.L3:
            movea.l ($18,A2),A0
            _DisposPtr
.L4:
            movea.l ($14,A2),A0
            _DisposPtr
.L5:
            movea.l A2,A0
            _DisposPtr
.L6:
            move.w  #$FFFF,D0
            rts
sub_408E125A:
            bsr.w   sub_408E2B44
            movem.l A0-A1,-(SP)
            movea.l ($2D8).w,A1
            move.l  ($3AC,A1),D0
            beq.b   .L2
            movea.l D0,A1
            move.w  ($A,A1),D0
            beq.b   .L1
            lea     ($1C,A1),A0
            _VRemove
.L1:
            movea.l ($14,A1),A0
            _DisposPtr
            movea.l ($18,A1),A0
            _DisposPtr
            movea.l A1,A0
            _DisposPtr
.L2:
            movem.l (SP)+,A0-A1
            rts
sub_408E1290:
            bsr.w   sub_408E2B44
            movem.l D1-D3/A0-A3,-(SP)
            move.w  D2,-(SP)
            movea.l SP,A0
            movea.l D3,A1
            bsr.b   sub_408E12A8
            addq.w  #2,SP
            movem.l (SP)+,D1-D3/A0-A3
            rts
sub_408E12A8:
            movea.l ($2D8).w,A3
            movea.l ($3AC,A3),A3
            move    SR,-(SP)
            move    #$2600,SR
            jsr     sub_408E1474
            bne.b   .L2
            bset    #7,(4,A2)
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
            addq.w  #6,A2
            adda.w  (6,A3),A2
.L1:
            move.w  (A1)+,(A2)+
            dbra    D1,.L1
            suba.w  (8,A3),A1
            move    (SP)+,SR
            clr.w   D0
            rts
.L2:
            move.l  A1,D1
            lea     ($10,A3),A1
            move.l  (A1),D0
            beq.b   .L6
            movea.l D0,A2
            move.l  (A2),(A1)
            movea.l D1,A1
.L3:
            bset    #7,(4,A2)
            addq.w  #6,A2
            move.w  (6,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L4:
            move.w  (A0)+,(A2)+
            dbra    D1,.L4
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L5:
            move.w  (A1)+,(A2)+
            dbra    D1,.L5
            suba.w  (8,A3),A1
            suba.w  (8,A3),A2
            suba.w  (6,A3),A2
            suba.w  (6,A3),A0
            subq.w  #6,A2
            movea.l D2,A3
            move.l  (A3),(A2)
            move.l  A2,(A3)
            move    (SP)+,SR
            clr.w   D0
            rts
.L6:
            movea.l D1,A1
            move.w  ($A,A3),D0
            bne.b   .L7
            move    (SP)+,SR
            move.w  #$FFFF,D0
            rts
.L7:
            movem.l D2/A0-A1,-(SP)
            move.w  ($20E).w,-(SP)
            move.w  ($20E).w,-(SP)
            move.w  ($20E).w,-(SP)
            movea.l SP,A0
            jsr     sub_408E14B4
            addq.l  #6,SP
.L8:
            movea.l A2,A0
.L9:
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L11
            btst    #7,(4,A2)
            bne.b   .L9
            move.l  (A2),(A1)
.L10:
            movem.l (SP)+,D2/A0-A1
            bra.w   .L3
.L11:
            movea.l A0,A2
            addq.l  #4,A2
            cmpa.l  D2,A2
            bne.b   .L14
.L12:
            movea.l A2,A0
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L13
            move.l  (A2),(A1)
            bra.b   .L10
.L13:
            movea.l A0,A2
            addq.l  #4,A2
            moveq   #0,D1
            move.w  (4,A3),D1
            lsl.l   #2,D1
            movea.l ($14,A3),A0
            adda.l  D1,A0
            cmpa.l  A2,A0
            bne.b   .L12
            movea.l ($14,A3),A2
            bra.b   .L12
.L14:
            moveq   #0,D1
            move.w  (4,A3),D1
            lsl.l   #2,D1
            movea.l ($14,A3),A0
            adda.l  D1,A0
            cmpa.l  A2,A0
            bne.b   .L8
            movea.l ($14,A3),A2
            cmpa.l  D2,A2
            beq.b   .L12
            bra.b   .L8
sub_408E13C4:
            bsr.w   sub_408E2B44
            movem.l D0/D2/A0-A3,-(SP)
            move.w  D1,-(SP)
            movea.l SP,A0
            bsr.b   sub_408E13F0
            tst.w   D0
            beq.b   .L1
            addq.w  #2,SP
            clr.w   D1
            move    #8,CCR
            bra.b   .L2
.L1:
            movem.w (SP)+,D1
.L2:
            movem.l (SP)+,D0/D2/A0-A3
            movem.w D1,($392,A2)
            rts
sub_408E13F0:
            movea.l ($2D8).w,A3
            movea.l ($3AC,A3),A3
            jsr     sub_408E1474
            bne.b   .L2
            move    SR,D0
            move    #$2600,SR
            addq.w  #6,A2
            adda.w  (6,A3),A2
            move.w  (8,A3),D1
            asr.w   #1,D1
            subq.w  #1,D1
.L1:
            move.w  (A2)+,(A1)+
            dbra    D1,.L1
            move    D0,SR
            suba.w  (8,A3),A1
            clr.w   D0
.L2:
            rts
sub_408E1422:
            movea.l ($2D8).w,A3
            movea.l ($3AC,A3),A3
            move.w  ($A,A3),D0
            mulu.w  #$3C,D0
            move.w  D0,($A,A0)
            movea.l ($14,A3),A2
            move.w  (4,A3),D0
            subq.w  #1,D0
.L1:
            movea.l A2,A0
            move    SR,-(SP)
            move    #$2600,SR
.L2:
            movea.l A2,A1
            movea.l (A2),A2
            move.l  A2,D1
            beq.b   .L3
            bclr    #7,(4,A2)
            bne.b   .L2
            move.l  A1,D2
            move.l  (A2),(A1)
            lea     ($10,A3),A1
            move.l  (A1),(A2)
            move.l  A2,(A1)
            movea.l D2,A2
            bra.b   .L2
.L3:
            move    (SP)+,SR
            movea.l A0,A2
            addq.l  #4,A2
            dbra    D0,.L1
            rts
sub_408E1474:
            jsr     sub_408E14B4
.L1:
            movea.l (A2),A2
            move.l  A2,D0
            beq.b   .L4
            move.w  (6,A3),D0
            asr.w   #1,D0
            subq.w  #1,D0
            addq.w  #6,A2
.L2:
            cmpm.w  (A0)+,(A2)+
            dbne    D0,.L2
            bne.b   .L3
            move.w  (6,A3),D0
            suba.w  D0,A2
            suba.w  D0,A0
            subq.w  #6,A2
            clr.w   D0
            rts
.L3:
            move.w  (6,A3),D1
            asl.w   #1,D0
            sub.w   D0,D1
            suba.w  D1,A0
            suba.w  D1,A2
            subq.w  #6,A2
            bra.b   .L1
.L4:
            move.w  #$FFFF,D0
            rts
sub_408E14B4:
            cmpi.w  #2,(6,A3)
            bne.b   .L1
            moveq   #0,D0
            move.w  (A0),D0
            bra.b   .L5
.L1:
            adda.w  (6,A3),A0
            move.l  -(A0),D0
            bpl.b   .L2
            neg.l   D0
.L2:
            cmpi.w  #4,(6,A3)
            beq.b   .L3
            subq.w  #2,A0
.L3:
            moveq   #0,D2
            move.w  (4,A3),D2
            swap    D2
.L4:
            sub.l   D2,D0
            bge.b   .L4
            divu.w  (4,A3),D0
            bvc.b   .L6
            add.l   D2,D0
.L5:
            divu.w  (4,A3),D0
.L6:
            swap    D0
            asl.w   #2,D0
            movea.l ($14,A3),A2
            adda.w  D0,A2
            move.l  A2,D2
            rts
.L7:
            move.l  ($2B4,A2),D1
            beq.b   .L8
            movea.l ($2A4,A2),A3
            jsr     (2,A3)
.L8:
            bra.b   .L9
            move.l  ($2B4,A2),D2
            beq.b   .L9
            movea.l ($2A4,A2),A3
            jmp     (A3)
            moveq   #0,D0
.L9:
            bra.w   MPPStatus.L3
sub_408E151E:
            lea     .L1,A3
            move.l  A3,($2A0,A2)
            jmp     (A3)
.L1:
            subq.w  #7,D3
            bmi.b   .L3
            add.w   D3,D3
            lea     .L2,A3
            adda.w  D3,A3
            move.w  (A3),D3
            lea     .L1,A3
            adda.w  D3,A3
            move.l  A3,-(SP)
            movea.l ($2A8,A2),A3
            rts
.L2:
            dc.w    $0062,$00B0,$01EE,$0162,$00B4,$0094,$011C,$00A2
            dc.w    $0BD4,$1684,$164C,$1672,$F9DA,$1576,$003C,$15E0
            dc.w    $303C,$FFEF,$6000,$00DC
.L3:
            movea.l ($2A8,A2),A3
            moveq   #9,D2
.L4:
            tst.b   (2,A3,D2.w)
            beq.b   .L5
            move.w  D2,D3
            mulu.w  #$12,D3
            lea     ($10,A3,D3.w),A0
            _VRemove
.L5:
            subq.w  #1,D2
            bpl.b   .L4
            rts
            move.l  #$151,D0
            _NewPtrSysClear
            bne.b   .L6
            lea     sub_408E1A72,A1
            movea.l ($2AC,A2),A3
            clr.w   D1
            jsr     (2,A3)
            tst.w   D0
            bne.b   .L7
            move.b  D1,($124,A0)
            move.b  #$A,(A0)
            move.l  A0,($2A8,A2)
.L6:
            rts
.L7:
            move.w  D0,D1
            _DisposPtr
            move.w  D1,D0
            rts
            movea.l ($1C,A0),A0
            move.w  #$FBAF,D0
            bsr.w   sub_408E19C2
            bra.b   .L13
            move.b  ($2B8,A2),($1D,A0)
            move.b  ($1C,A0),($2B8,A2)
            bra.b   .L12
            bra.w   sub_408E16D0.L4
            move.l  A0,D3
            tst.l   ($2B4,A2)
            bne.b   .L14
            move.l  #$98,D0
            _NewPtrSysClear
            bne.b   .L10
            lea     ($1A,A0),A0
            move.l  A0,($2B4,A2)
            btst    #$1E,($33E,A2)
            bne.b   .L8
            movem.l D1/A1/A3,-(SP)
            moveq   #2,D1
            movea.l ($2A4,A2),A1
            addq.w  #4,A1
            movea.l ($2AC,A2),A3
            jsr     (2,A3)
            movem.l (SP)+,D1/A1/A3
            tst.w   D0
            beq.b   .L8
            clr.l   ($2B4,A2)
            move.w  #$FBFB,D0
            bra.b   .L10
.L8:
            movea.l D3,A0
.L14:
            tst.b   ($22,A0)
            beq.b   .L11
            lea     (9,A1),A1
            bsr.w   sub_408E16D0
            bne.b   .L9
            bsr.b   sub_408E16AC
            beq.w   sub_408E16D0.L4
.L9:
            move.w  #$FBFD,D0
.L10:
            bra.b   .L13
.L11:
            bsr.b   sub_408E1650
.L12:
            moveq   #0,D0
.L13:
            movea.l ABusDCE,A1
            movea.l JIODone,A0
            jmp     (A0)
sub_408E1650:
            clr.w   D2
            move.b  (7,A1),D1
            move    SR,-(SP)
            move    #$2600,SR
.L1:
            addq.w  #1,D2
            lea     ($2B0,A2),A3
.L2:
            tst.l   (A3)
            beq.b   .L3
            movea.l (A3),A3
            cmp.b   (7,A3),D1
            bne.b   .L2
            tst.b   D2
            beq.b   .L2
            cmp.b   (8,A3),D2
            beq.b   .L1
            bra.b   .L2
.L3:
            move.b  (A2),(6,A1)
            move.b  D2,(8,A1)
            clr.l   (A1)
            move.l  A1,(A3)
            move    (SP)+,SR
            rts
            move.w  #$FBFC,D0
            bsr.b   sub_408E16AC
            beq.b   sub_408E151E.L13
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($2B0,A2),A0
.L4:
            cmp.l   (A0),D3
            beq.b   .L5
            movea.l (A0),A0
            bra.b   .L4
.L5:
            movea.l D3,A1
            move.l  (A1),(A0)
            move    (SP)+,SR
            bra.b   sub_408E151E.L12
sub_408E16AC:
            movem.l D0-D1/A0-A4,-(SP)
            movea.l A1,A3
            lea     ($2B0,A2),A4
            moveq   #0,D3
.L1:
            tst.l   (A4)
            beq.b   .L2
            movea.l (A4),A4
            movea.l A4,A0
            movea.l A3,A1
            bsr.w   sub_408E1E46
            bne.b   .L1
            move.l  A4,D3
.L2:
            movem.l (SP)+,D0-D1/A0-A4
            rts
sub_408E16D0:
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #0,D3
            moveq   #9,D2
.L1:
            tst.b   (2,A3,D2.w)
            dbne    D2,.L1
            beq.b   .L2
            move.w  D2,D1
            mulu.w  #$12,D1
            movea.l ($C,A3,D1.w),A0
            cmpi.w  #$FD,($1A,A0)
            bne.b   .L3
            movea.l ($1E,A0),A0
            movem.l D2/A1,-(SP)
            bsr.w   sub_408E1E46
            movem.l (SP)+,D2/A1
            bne.b   .L3
            moveq   #-1,D3
.L2:
            movem.l (SP)+,D0-D2/A0-A1
            tst.w   D3
            rts
.L3:
            subq.w  #1,D2
            bmi.b   .L2
            bra.b   .L1
            clr.w   ($2A,A0)
.L4:
            move.w  #$FBB7,D0
            moveq   #9,D2
.L5:
            tst.b   (2,A3,D2.w)
            dbeq    D2,.L5
            bne.w   sub_408E151E.L13
.L6:
            addq.b  #1,($125,A3)
            beq.b   .L6
            move    SR,-(SP)
            move    #$2600,SR
            cmpi.w  #$101,($1A,A0)
            bne.b   .L8
            tst.l   ($3A2,A2)
            beq.b   .L7
            move    (SP)+,SR
            bra.w   sub_408E151E.L13
.L7:
            move.l  A0,($3A2,A2)
.L8:
            move.b  ($125,A3),(2,A3,D2.w)
            mulu.w  #$12,D2
            lea     ($C,A3,D2.w),A2
            move.l  A0,(A2)+
            movea.l A2,A0
            move.w  #1,(4,A0)
            lea     sub_408E18E6,A2
            move.l  A2,(6,A0)
            lsl.w   #3,D1
            andi.w  #$3FF,D1
            move.w  D1,($A,A0)
            lea     ($162).w,A2
.L9:
            tst.l   (A2)
            beq.b   .L10
            movea.l (A2),A2
            cmpa.l  A2,A0
            bne.b   .L9
            move    (SP)+,SR
            bra.b   .L11
.L10:
            move    (SP)+,SR
            _VInstall
.L11:
            movea.l (-4,A0),A2
            cmpi.w  #$FB,($1A,A2)
            bne.b   .L12
            move.w  #1,($A,A0)
            tst.b   ($1D,A2)
            beq.b   .L15
            addq.b  #1,($1D,A2)
            bra.b   .L15
.L12:
            cmpi.w  #$101,($1A,A2)
            movea.l ($2D8).w,A2
            bne.b   .L13
            bsr.w   sub_408E2116
            bra.b   .L14
.L13:
            bsr.b   sub_408E181C
.L14:
            lea     ($126,A3),A1
            movea.l ($2AC,A2),A0
            moveq   #0,D3
            jsr     (A0)
.L15:
            move    SR,-(SP)
            move    #$2600,SR
            movea.l ABusDCE,A1
            bclr    #7,(5,A1)
            movea.l (8,A1),A0
            move.l  (A0),(8,A1)
            bne.b   .L16
            clr.l   ($C,A1)
.L16:
            cmpi.w  #$FB,($1A,A0)
            bne.b   .L17
            move.l  ($22,A0),(A0)
            move.w  ($26,A0),($12,A0)
.L17:
            move.l  (8,A1),D0
            beq.b   .L18
            movea.l D0,A0
            moveq   #0,D0
            bset    #7,(5,A1)
            move    (SP)+,SR
            jsr     MPPCtl
            moveq   #0,D0
            rts
.L18:
            move    (SP)+,SR
            rts
sub_408E181C:
            movea.l ($C,A3,D2.w),A0
            divu.w  #$12,D2
            move.b  (2,A3,D2.w),($13B,A3)
            moveq   #$21,D3
            move.l  ($22,A0),D2
            lsr.l   #8,D2
            cmpi.w  #$FA,($1A,A0)
            beq.b   .L2
            moveq   #0,D2
            st      D2
            move.b  ($19,A2),D0
            beq.b   .L2
            move.b  D0,D2
            tst.w   ($340,A2)
            bpl.b   .L1
            bsr.b   sub_408E18A8
            move.l  ($33A,A2),D2
.L1:
            moveq   #$11,D3
.L2:
            move.l  A1,D0
            lea     ($128,A3),A1
            lea     ($141,A3),A0
            move.l  A0,(A1)+
            move.b  #2,($D,A0)
            move.b  D2,($B,A0)
            lsr.l   #8,D2
            move.w  D2,(7,A0)
            move.b  #2,($F,A0)
            move.w  #7,(A1)+
            lea     ($13A,A3),A0
            move.l  A0,(A1)+
            move.b  D3,(A0)
            addq.w  #2,A0
            move.w  ($1A,A2),(A0)+
            move.b  (A2),(A0)+
            move.b  ($124,A3),D1
            move.b  D1,(A0)
            movea.l D0,A0
            clr.w   D2
            move.b  (A0),D2
            add.b   (1,A0,D2.w),D2
            add.b   (2,A0,D2.w),D2
            addq.b  #3,D2
            move.w  D2,(A1)+
            move.l  A0,(A1)+
            clr.w   (A1)
            rts
sub_408E18A8:
            moveq   #2,D1
            add.b   (A1),D1
            add.b   (-1,A1,D1.w),D1
            cmpi.b  #1,(0,A1,D1.w)
            bne.b   .L1
            cmpi.b  #$2A,(1,A1,D1.w)
            bne.b   .L1
            move.l  A0,-(SP)
            movea.l A1,A0
            lea     ($C0,A3),A1
            move.l  D1,D0
            _BlockMove
            lea     ($356,A2),A0
            adda.w  D1,A3
            lea     ($C0,A3),A1
            suba.w  D1,A3
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            lea     ($C0,A3),A1
            movea.l (SP)+,A0
.L1:
            rts
sub_408E18E6:
            movea.l ($2D8).w,A2
            movea.l ABusDCE,A3
            lea     (-4,A0),A1
            move.l  A1,D2
            movea.l (A1),A1
            subq.b  #1,($1D,A1)
            beq.b   .L7
            bset    #7,(5,A3)
            beq.b   .L2
.L1:
            move.w  #1,($A,A0)
            addq.b  #1,($1D,A1)
            rts
.L2:
            movea.l ($2A8,A2),A3
            moveq   #0,D0
            move.b  ($1C,A1),D0
            bne.b   .L3
            moveq   #1,D0
.L3:
            lsl.w   #3,D0
            move.w  D0,($A,A0)
            move.w  ($1A,A1),D3
            movea.l ($1E,A1),A1
            cmpi.w  #$FD,D3
            bne.b   .L4
            lea     (9,A1),A1
.L4:
            lea     ($C,A3),A0
            sub.l   A0,D2
            ext.l   D2
            cmpi.w  #$101,D3
            bne.b   .L5
            bsr.w   sub_408E2116
            bra.b   .L6
.L5:
            bsr.w   sub_408E181C
.L6:
            lea     ($126,A3),A1
            movea.l ($2AC,A2),A0
            moveq   #0,D3
            jsr     (A0)
            move    SR,-(SP)
            move    #$2600,SR
            movea.l ABusDCE,A1
            bclr    #7,(5,A1)
            bra.w   sub_408E16D0.L17
.L7:
            btst    #7,(5,A3)
            beq.b   .L8
            cmpa.l  (8,A3),A1
            beq.b   .L1
.L8:
            movea.l ($2A8,A2),A3
            move.w  ($1A,A1),D0
            movea.l A1,A0
            movea.l ($1E,A1),A1
            move    SR,-(SP)
            move    #$2600,SR
            tst.w   ($10,A0)
            ble.b   .L13
            cmpi.w  #$101,D0
            bne.b   .L9
            move.w  #$FFA3,D0
            bra.b   .L12
.L9:
            cmpi.w  #$FD,D0
            beq.b   .L10
            cmpi.w  #$FA,D0
            bne.b   .L11
            move.w  #$FBFF,D0
            bra.b   .L12
.L10:
            bsr.w   sub_408E1650
.L11:
            moveq   #0,D0
.L12:
            bsr.b   sub_408E19C2
.L13:
            move    (SP)+,SR
            rts
.L14:
            moveq   #0,D0
sub_408E19C2:
            movea.l ($2A8,A2),A3
            moveq   #9,D2
.L1:
            tst.b   (2,A3,D2.w)
            dbne    D2,.L1
            beq.b   .L6
            move.w  D2,D3
            mulu.w  #$12,D3
            move.l  ($C,A3,D3.w),D1
            sub.l   A0,D1
            exg     D0,D1
            _StripAddress
            exg     D0,D1
            tst.l   D1
            bne.b   .L5
            move.w  D0,($10,A0)
            lea     ($10,A3,D3.w),A1
            tst.w   ($A,A1)
            beq.b   .L2
            exg     A0,A1
            move.w  D0,D1
            _VRemove
            move.w  D1,D0
            movea.l A1,A0
.L2:
            clr.b   (2,A3,D2.w)
            move.l  ($3A2,A2),D1
            beq.b   .L3
            sub.l   A0,D1
            bne.b   .L3
            clr.l   ($3A2,A2)
.L3:
            move.l  ($C,A0),D1
            beq.b   .L4
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L4:
            moveq   #0,D0
            rts
.L5:
            subq.w  #1,D2
            bpl.b   .L1
.L6:
            move.w  #$FBB2,D0
            rts
sub_408E1A2C:
            move.l  A5,D2
            cmpi.w  #$FD,($1A,A5)
            beq.b   .L1
            moveq   #4,D3
            jsr     (2,A4)
            bne.b   .L2
            move.b  -(A3),D0
            movea.l ($2A8,A2),A3
            movea.l D2,A0
            move.b  D0,($26,A0)
            cmp.b   ($25,A0),D0
            beq.w   sub_408E18E6.L14
            move.w  #$FBFE,D0
            bra.w   sub_408E19C2
.L1:
            jsr     (2,A4)
            bne.b   .L2
            movea.l D2,A0
            move.w  #$FBFD,D0
            bra.w   sub_408E19C2
.L2:
            rts
sub_408E1A6C:
            clr.w   D3
            jmp     (2,A4)
sub_408E1A72:
            moveq   #2,D3
            jsr     (A4)
            bne.b   sub_408E1A2C.L2
            movea.l ($2A8,A2),A5
            lea     ($C,A5),A5
            moveq   #9,D2
            move.b  -(A3),D0
            beq.b   sub_408E1A6C
.L1:
            cmp.b   -(A5),D0
            dbeq    D2,.L1
            bne.b   sub_408E1A6C
            suba.w  D2,A5
            mulu.w  #$12,D2
            lea     ($A,A5),A5
            movea.l (0,A5,D2.w),A5
            move.b  -(A3),D2
            cmpi.w  #$FB,($1A,A5)
            bne.b   sub_408E1A2C
            movea.l ABusDCE,A3
            cmpa.l  (8,A3),A5
            beq.b   sub_408E1A6C
            movea.l (A5),A3
            move.w  ($12,A5),D3
            move.l  A5,-(SP)
            jsr     (2,A4)
            movea.l (SP)+,A1
            bne.b   sub_408E1A2C.L2
            subi.b  #$30,D2
            ble.b   sub_408E1A2C.L2
            cmpi.b  #$F,D2
            bgt.b   sub_408E1A2C.L2
            move.l  A3,D1
            movea.l ($2A8,A2),A3
            clr.w   D0
            tst.w   D3
            bpl.b   sub_408E1B26
            clr.w   D2
            movea.l (A1),A0
.L2:
            addq.w  #5,A0
            cmp.l   A0,D1
            ble.b   .L3
            move.b  (A0)+,D0
            beq.b   sub_408E1A2C.L2
            cmpi.b  #$20,D0
            bhi.w   sub_408E1A2C.L2
            adda.w  D0,A0
            cmp.l   A0,D1
            ble.b   .L3
            move.b  (A0)+,D0
            beq.w   sub_408E1A2C.L2
            cmpi.b  #$20,D0
            bhi.w   sub_408E1A2C.L2
            adda.w  D0,A0
            cmp.l   A0,D1
            ble.b   .L3
            move.b  (A0)+,D0
            beq.w   sub_408E1A2C.L2
            cmpi.b  #$20,D0
            bhi.w   sub_408E1A2C.L2
            adda.w  D0,A0
            cmp.l   A0,D1
            blt.b   .L3
            addq.w  #1,D2
            bra.b   .L2
.L3:
            tst.w   D2
            beq.w   sub_408E1A2C.L2
sub_408E1B26:
            movem.l D4/A2/A4-A6,-(SP)
            clr.w   D1
            move.l  ($22,A1),D3
            movea.l (A1),A5
            movea.l A5,A6
.L1:
            movea.l D3,A4
.L2:
            cmpa.l  (A1),A4
            beq.b   .L5
            movea.l A4,A0
            movea.l A5,A2
            moveq   #0,D0
            move.l  D0,D4
            move.b  (A0)+,D0
            swap    D0
            move.b  (A0)+,D0
            move.b  (A2)+,D4
            swap    D4
            move.b  (A2)+,D4
            cmp.l   D0,D4
            beq.b   .L3
            tst.l   D0
            beq.b   .L3
            tst.l   D4
            bne.b   .L4
.L3:
            cmpm.b  (A0)+,(A2)+
            bne.b   .L4
            cmpm.b  (A0)+,(A2)+
            bne.b   .L4
            cmpm.b  (A0)+,(A2)+
            beq.w   .L12
.L4:
            addq.w  #5,A4
            moveq   #0,D0
            move.b  (A4),D0
            add.b   (1,A4,D0.w),D0
            add.b   (2,A4,D0.w),D0
            addq.w  #3,D0
            adda.w  D0,A4
            bra.b   .L2
.L5:
            tst.b   (5,A5)
            beq.w   .L11
            cmpi.b  #$20,(5,A5)
            bhi.w   .L11
            move.b  (5,A5),D0
            tst.b   (6,A5,D0.w)
            beq.b   .L11
            cmpi.b  #$20,(6,A5,D0.w)
            bhi.b   .L11
            add.b   (6,A5,D0.w),D0
            tst.b   (7,A5,D0.w)
            beq.b   .L11
            cmpi.b  #$20,(7,A5,D0.w)
            bhi.b   .L11
            add.b   (7,A5,D0.w),D0
            addq.w  #8,D0
            movea.l A5,A0
            adda.w  D0,A5
            cmpa.l  A0,A6
            bne.b   .L6
            movea.l A5,A6
            bra.b   .L7
.L6:
            move.l  A1,-(SP)
            movea.l A6,A1
            adda.w  D0,A6
            _BlockMove
            movea.l (SP)+,A1
.L7:
            addq.w  #1,D1
.L8:
            subq.b  #1,D2
            bne.w   .L1
            move.l  A6,(A1)
            suba.l  ($22,A1),A6
            move.w  ($26,A1),D0
            sub.w   A6,D0
            movem.l (SP)+,D4/A2/A4-A6
            movea.l A1,A0
            add.w   ($2A,A1),D1
            move.w  D1,($2A,A1)
            cmp.w   ($28,A1),D1
            bpl.b   .L9
            move.w  D0,($12,A1)
            bne.b   .L10
.L9:
            movea.l ABusDCE,A3
            btst    #7,(5,A3)
            beq.w   sub_408E18E6.L14
            cmpa.l  (8,A3),A1
            bne.w   sub_408E18E6.L14
.L10:
            rts
.L11:
            movem.l (SP)+,D4/A2/A4-A6
            rts
.L12:
            addq.w  #5,A5
            tst.b   (A5)
            beq.b   .L11
            cmpi.b  #$20,(A5)
            bhi.b   .L11
            move.b  (A5),D0
            tst.b   (1,A5,D0.w)
            beq.b   .L11
            cmpi.b  #$20,(1,A5,D0.w)
            bhi.b   .L11
            add.b   (1,A5,D0.w),D0
            tst.b   (2,A5,D0.w)
            beq.b   .L11
            cmpi.b  #$20,(2,A5,D0.w)
            bhi.b   .L11
            add.b   (2,A5,D0.w),D0
            addq.w  #3,D0
            adda.w  D0,A5
            bra.w   .L8
.L13:
            bra.b   .L26
            bra.b   .L27
            movea.l ($2B4,A2),A3
            tst.w   (A3)+
            bne.b   .L28
            moveq   #$7C,D3
            jsr     (2,A4)
            bne.b   .L29
            movea.l ($2B4,A2),A0
            tst.b   ($2B8,A2)
            bne.b   .L30
            move.b  (6,A0),D0
            cmp.b   (A2),D0
            bne.b   .L30
            move.w  (4,A0),D0
            cmp.w   ($1A,A2),D0
            beq.b   .L29
.L30:
            move.w  #$F2,(A0)
            suba.w  #$1A,A0
            lea     .L31,A1
            move.l  A1,($C,A0)
            movea.l ABusDCE,A1
            move.w  ($18,A1),($18,A0)
            _Control async
.L29:
            rts
.L28:
            clr.w   D3
            jmp     (2,A4)
.L31:
            clr.w   ($1A,A0)
            rts
.L26:
            bra.b   .L32
.L27:
            lea     ($2B0,A2),A3
            movea.l SysZone,A0
.L35:
            move.l  (A3),D0
            beq.b   .L33
            _StripAddress
            movea.l D0,A1
            cmpa.l  (A0),A1
            bcs.b   .L34
            cmpa.l  BufPtr,A1
            bcc.b   .L34
            move.l  (A1),(A3)
            bra.b   .L35
.L34:
            movea.l A1,A3
            bra.b   .L35
.L33:
            moveq   #0,D0
            rts
.L32:
            move.l  ($2B0,A2),D3
            beq.w   .L25
            move    SR,-(SP)
            move    ($1C,A2),SR
            movem.l A2/A4-A5,-(SP)
            movea.l A0,A4
            tst.b   ($19,A2)
            beq.b   .L15
            tst.w   ($340,A2)
            bpl.b   .L15
            moveq   #0,D0
            lea     ($23,A4),A0
            move.b  (A0)+,D0
            adda.w  D0,A0
            move.b  (A0)+,D0
            adda.w  D0,A0
            cmpi.b  #1,(A0)
            bne.b   .L14
            cmpi.b  #$2A,(1,A0)
            beq.b   .L15
.L14:
            lea     ($356,A2),A1
            bsr.w   sub_408E1E5A
            bne.w   .L24
.L15:
            move.l  D3,D2
            clr.w   D3
.L16:
            movea.l D2,A3
            lea     (9,A3),A3
            lea     ($23,A4),A5
            movea.l A3,A1
            movea.l A5,A0
            bsr.w   sub_408E1E74
            bne.b   .L17
            clr.w   D0
            move.b  (A5)+,D0
            adda.w  D0,A5
            movea.l A3,A1
            move.b  (A1)+,D0
            adda.w  D0,A1
            movea.l A5,A0
            bsr.w   sub_408E1E74
            bne.b   .L17
            move.l  A3,-(SP)
            addq.w  #1,D3
.L17:
            move.l  (-9,A3),D2
            bne.b   .L16
            tst.w   D3
            beq.w   .L24
            lea     ($1F,A4),A1
            lea     ($1E,A4),A5
            move.w  (A5)+,(7,A1)
            move.b  (A5)+,($B,A1)
            move.b  (A5)+,($D,A1)
            move.b  #2,($F,A1)
            move.l  A1,($32,A4)
            movea.l ($2D8).w,A2
            move.b  ($1E,A4),($26,A4)
            clr.w   D2
            clr.w   D1
            lea     ($36,A4),A3
            lea     ($1C,A4),A1
            move.w  #2,(A3)+
            move.l  A1,(A3)+
.L18:
            movea.l (SP),A5
            clr.w   D0
            move.b  (A5),D0
            add.b   (1,A5,D0.w),D0
            move.b  #1,(2,A5,D0.w)
            move.b  #$2A,(3,A5,D0.w)
            addi.w  #9,D0
            add.w   D0,D2
            cmpi.w  #$248,D2
            bgt.b   .L19
            addq.w  #4,SP
            move.w  D0,(A3)+
            subq.w  #5,A5
            move.l  A5,(A3)+
            move.w  ($1A,A2),(A5)
            addq.w  #1,D1
            subq.w  #1,D3
            beq.b   .L19
            cmpi.w  #$F,D1
            bne.b   .L18
.L19:
            clr.w   (A3)+
            ori.w   #$30,D1
            move.b  D1,(A1)
            move.w  D3,D2
            beq.b   .L23
            movea.l (SP),A0
            lea     (-9,A0),A0
            movea.l A0,A5
            move    #$2600,SR
            tst.l   (A0)
            beq.b   .L22
            move.l  A4,-(SP)
            movea.l ($2B0,A2),A4
            move.l  (A0),($2B0,A2)
.L20:
            tst.l   (A0)
            beq.b   .L21
            movea.l (A0),A0
            bra.b   .L20
.L21:
            move.l  A4,(A0)
            clr.l   (A5)
            movea.l (SP)+,A4
.L22:
            asl.w   #2,D2
            adda.w  D2,SP
.L23:
            lea     ($30,A4),A1
            movem.l (SP)+,A2/A4-A5
            move    (SP)+,SR
            move.b  #2,D1
            moveq   #0,D3
            jsr     sub_408E0F32
            bra.b   .L25
.L24:
            movem.l (SP)+,A2/A4-A5
            move    (SP)+,SR
.L25:
            movea.l JIODone,A0
            movea.l ABusDCE,A1
            moveq   #0,D0
            jmp     (A0)
            moveq   #2,D1
            lea     ($30,A4),A1
            movea.l ($2AC,A2),A0
            moveq   #0,D3
            jsr     (A0)
            movea.l ($2B4,A2),A0
            st      ($15,A0)
            rts
sub_408E1E46:
            moveq   #2,D0
            add.b   (A1),D0
            add.b   (-1,A1,D0.w),D0
            move.w  D0,D1
            swap    D0
            move.w  D1,D0
            lea     (9,A0),A0
            bra.b   sub_408E1E62
sub_408E1E5A:
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
sub_408E1E62:
            move.w  #$A03C,D1
            pea     sub_408E1E70
            move.l  ($388,A2),-(SP)
            rts
sub_408E1E70:
            tst.w   D0
            rts
sub_408E1E74:
            moveq   #0,D0
            moveq   #0,D2
            move.l  A0,D1
            move.b  (A0)+,D0
            beq.w   .L6
            subq.w  #1,D0
            bne.b   .L1
            cmpi.b  #$3D,(A0)
            beq.b   .L5
.L1:
            addq.w  #1,D2
            cmpi.b  #$C5,(A0)+
            dbeq    D0,.L1
            move    SR,-(SP)
            movea.l D1,A0
            move.b  (A0),D1
            move    (SP)+,SR
            beq.b   .L2
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.b  (A1)+,D0
            bra.b   .L4
.L2:
            cmpi.b  #1,D2
            beq.b   .L3
            moveq   #0,D0
            move.b  D2,D0
            swap    D0
            move.b  D2,D0
            subi.l  #$10001,D0
            addq.w  #1,A0
            addq.w  #1,A1
            movem.l D1-D2/A0-A1,-(SP)
            bsr.b   sub_408E1E62
            movem.l (SP)+,D1-D2/A0-A1
            bne.b   .L5
            subq.w  #1,A0
            subq.w  #1,A1
.L3:
            cmp.b   D1,D2
            beq.b   .L5
            moveq   #0,D0
            move.b  D2,D0
            subq.b  #1,D0
            cmp.b   (A1),D0
            bcc.b   .L6
            sub.b   D2,D1
            move.b  (A1),D0
            sub.b   D1,D0
            bcs.b   .L6
            adda.w  D0,A1
            move.b  (A0),D0
            sub.b   D1,D0
            adda.w  D0,A0
            move.b  D1,D0
            swap    D0
            move.b  D1,D0
            addq.w  #1,A0
            addq.w  #1,A1
.L4:
            bra.w   sub_408E1E62
.L5:
            rts
.L6:
            move    #0,CCR
            rts
sub_408E1F04:
            move.l  #$82,D0
            _NewPtrSysClear
            bne.b   .L1
            move.l  A0,($380,A2)
            lea     ($6A,A0),A0
            move.l  A0,($3A6,A2)
            lea     sub_408E1F52,A0
            move.l  A0,($86,A2)
            pea     sub_408E1F32
            move.l  (SP)+,($37C,A2)
            move.b  #6,($57,A2)
.L1:
            rts
sub_408E1F32:
            move.l  ($380,A2),D2
            beq.b   .L1
            tst.w   ($340,A2)
            bpl.b   .L1
            movea.l D2,A1
            bset    #7,($384,A2)
            bne.b   .L1
            moveq   #$4F,D0
            _BlockMove
            movea.l D2,A3
            bra.b   sub_408E1F52.L3
.L1:
            rts
sub_408E1F52:
            subq.b  #6,-(A3)
            bne.b   .L1
            tst.w   ($340,A2)
            bpl.b   .L1
            move.l  ($380,A2),D2
            beq.b   .L1
            bset    #7,($384,A2)
            beq.b   .L2
.L1:
            bra.w   sub_408E10AE.L9
.L2:
            movea.l D2,A3
            moveq   #$4F,D3
            jsr     (2,A4)
            bne.b   .L6
            movea.l D2,A3
            subq.b  #6,(A3)
.L3:
            move.l  ($33E,A2),D3
            tst.b   (A3)
            bmi.b   .L6
            cmpi.b  #1,(A3)
            bgt.b   .L6
            lea     (6,A3),A0
            cmpi.b  #$20,(A0)
            bhi.b   .L6
            move.w  (2,A3),D0
            cmp.w   (4,A3),D0
            bhi.b   .L6
            cmpi.w  #$FF00,(4,A3)
            bcc.b   .L6
            lea     ($356,A2),A1
            move.l  ($3A2,A2),D1
            beq.b   .L4
            movea.l D1,A1
            movea.l ($1E,A1),A1
.L4:
            bsr.w   sub_408E1E5A
            bne.b   .L6
            move.w  (2,A3),($348,A2)
            move.w  (4,A3),($34A,A2)
            btst    #$D,D3
            beq.b   .L6
            tst.b   (A3)
            beq.b   .L5
            btst    #4,($384,A2)
            bne.b   .L7
            bra.b   .L6
.L5:
            bclr    #5,($384,A2)
            beq.w   .L18
            btst    #$B,D3
            beq.b   .L7
            cmpi.w  #$FF00,($1A,A2)
            bcs.b   .L7
.L6:
            bclr    #7,($384,A2)
            rts
.L7:
            bclr    #6,($341,A2)
            btst    #5,(1,A3)
            beq.b   .L8
            bset    #6,($341,A2)
.L8:
            bclr    #7,($341,A2)
            btst    #7,(1,A3)
            beq.b   .L9
            bset    #7,($341,A2)
.L9:
            btst    #6,(1,A3)
            bne.b   .L10
            moveq   #6,D0
            lea     ($34C,A2),A1
            movea.l ($378,A2),A0
            jsr     (2,A0)
            moveq   #0,D0
            lea     (6,A3),A0
            move.b  (A0)+,D0
            adda.w  D0,A0
            move.b  (A0)+,D0
            cmp.b   ($353,A2),D0
            bne.b   .L6
            lea     ($34C,A2),A1
            _BlockMove
            moveq   #5,D0
            lea     ($34C,A2),A1
            movea.l ($378,A2),A0
            jsr     (2,A0)
.L10:
            moveq   #0,D0
            lea     (6,A3),A0
            btst    #7,($341,A2)
            bne.b   .L11
            tst.l   ($3A2,A2)
            bne.b   .L12
            tst.b   (A3)
            beq.b   .L15
.L11:
            move.b  (A0)+,D0
            adda.w  D0,A0
            move.b  (A0)+,D0
            adda.w  D0,A0
.L12:
            btst    #$1E,D3
            beq.b   .L13
            btst    #$B,D3
            beq.b   .L15
.L13:
            move.b  (A0),D0
            addq.w  #1,D0
            lea     ($356,A2),A1
            _BlockMove
            lea     ($356,A2),A0
            move.l  ($410,A2),D0
            beq.b   .L14
            movea.l D0,A1
            moveq   #4,D0
            jsr     (A1)
.L14:
            move.l  #$2100BD,D0
            _WriteXPRam
.L15:
            tst.b   (A3)
            bne.b   .L17
            btst    #$1E,D3
            beq.b   .L16
            btst    #$B,D3
            beq.b   .L18
.L16:
            moveq   #0,D0
            move.w  ($A,A2),D0
            lsl.l   #8,D0
            move.b  ($D,A2),D0
            move.l  D0,($33A,A2)
            move.b  #$FE,($19,A2)
            move.b  #$96,($2D0,A2)
.L17:
            st      ($352,A2)
            bsr.w   sub_408E508E
.L18:
            bclr    #7,($384,A2)
            move    ($1C,A2),SR
            moveq   #0,D0
            move.l  ($3A2,A2),D1
            beq.b   .L19
            movea.l D1,A0
            bra.w   sub_408E19C2
.L19:
            rts
            moveq   #-1,D0
            move.b  (A1),D1
            cmpi.b  #$21,D1
            bcs.b   .L20
            clr.b   (A1)
.L20:
            moveq   #3,D1
            move.b  D1,($1C,A0)
            move.b  D1,($1D,A0)
            bra.w   sub_408E16D0.L4
sub_408E2116:
            movea.l ($C,A3,D2.w),A0
            move.l  A1,D0
            lea     ($128,A3),A1
            lea     ($141,A3),A0
            move.l  A0,(A1)+
            moveq   #6,D1
            move.b  D1,($D,A0)
            st      ($B,A0)
            clr.w   (7,A0)
            move.b  D1,($F,A0)
            move.w  #6,(A1)+
            lea     ($13A,A3),A0
            move.l  A0,(A1)+
            move.b  #5,(A0)+
            clr.b   (A0)+
            clr.l   (A0)+
            movea.l D0,A0
            moveq   #1,D0
            add.b   (A0),D0
            move.w  D0,(A1)+
            move.l  A0,(A1)+
            clr.w   (A1)
            bset    #5,($384,A2)
            rts
sub_408E215E:
            movem.l D2-D7/A2-A6,-(SP)
            movea.l ($30,SP),A2
            clr.w   -(SP)
            subq.w  #4,SP
            move.w  #$38,-(SP)
            movea.l SP,A3
            suba.w  #$38,SP
            lea     (1,SP),A1
            move.l  A1,(2,A3)
            st      (A1)+
            move.b  (A2),(A1)+
            move.b  #2,(A1)+
            movea.l A1,A4
            move.w  #$35,(A1)+
            clr.l   (A1)+
            move.w  ($1A,A2),(A1)+
            st      (A1)+
            move.b  (A2),(A1)+
            move.w  #$606,(A1)+
            move.b  #6,(A1)+
            move.b  #5,(A1)+
            clr.w   (A1)+
            clr.w   (A1)+
            clr.b   (A1)+
            lea     ($356,A2),A0
            moveq   #1,D0
            add.b   (A0),D0
            move.w  D0,D1
            _BlockMove
            moveq   #$22,D0
            sub.w   D1,D0
            sub.w   D0,(A3)
            sub.w   D0,(A4)
            movea.l A3,A1
            moveq   #0,D2
            st      D2
            bset    #5,($384,A2)
            bsr.w   sub_408E37F4
.L1:
            tst.b   ($2C8,A2)
            beq.b   .L1
            lea     ($40,SP),SP
            movem.l (SP)+,D2-D7/A2-A6
            rts
sub_408E21DA:
            cmpi.b  #4,-(A3)
            bne.b   .L1
            move.l  A3,D2
            movea.l ($92,A2),A3
            tst.w   ($10,A3)
            bgt.b   .L1
            move.w  #$24A,D3
            lea     ($41,A3),A3
            jsr     (2,A4)
            beq.b   .L2
            rts
.L1:
            clr.w   D3
            jmp     (2,A4)
.L2:
            move.w  #$24A,D0
            sub.w   D3,D0
            beq.b   .L6
            movea.l ($92,A2),A0
            cmpi.b  #1,($41,A0)
            bne.b   .L6
            move.w  D0,($28,A0)
            movea.l D2,A3
            move.b  -(A3),($3E,A0)
            move.b  (2,A2),D0
            moveq   #0,D1
            subq.b  #1,(3,A2)
            beq.b   .L5
            movea.l A0,A1
            lea     (6,A2),A0
            move.w  (A0)+,D1
            sne     ($1D,A1)
            beq.b   .L4
            move.w  D1,-(SP)
            moveq   #9,D0
            clr.w   D3
            clr.w   D1
            bsr.w   sub_408E0F24
            lea     ($41,A1),A0
            move.w  ($28,A1),D0
            bsr.w   sub_408E0F24
            tst.w   D3
            bne.b   .L3
            subq.w  #1,D3
.L3:
            cmp.w   (SP)+,D3
            bne.b   .L6
.L4:
            movea.l A1,A0
            move.b  (-2,A3),D0
            move.w  (-5,A3),D1
.L5:
            move.b  D0,($3C,A0)
            move.w  D1,($38,A0)
            addq.b  #1,($41,A0)
            _Control async
.L6:
            rts
            moveq   #-$5E,D0
            tst.w   ($458,A2)
            beq.b   .L7
            cmpi.b  #$80,D1
            beq.b   .L8
.L7:
            tst.b   D1
            ble.b   .L11
.L8:
            bsr.b   sub_408E22A8
            beq.b   .L11
            moveq   #7,D2
.L9:
            lea     ($24,A2,D2.w),A3
            tst.b   (A3)
            dbmi    D2,.L9
            bpl.b   .L11
            lsl.w   #2,D2
            move.l  A1,($2C,A2,D2.w)
            move.b  D1,(A3)
.L10:
            clr.w   D0
.L11:
            bra.w   MPPStatus.L3
sub_408E22A8:
            moveq   #7,D2
.L1:
            cmp.b   ($24,A2,D2.w),D1
            dbeq    D2,.L1
            rts
            moveq   #-$5E,D0
            moveq   #7,D2
.L2:
            cmp.b   ($24,A2,D2.w),D1
            dbeq    D2,.L2
            bne.b   sub_408E21DA.L11
            st      ($24,A2,D2.w)
            bra.b   sub_408E21DA.L10
            move.l  ($22,A0),D3
            movea.l (2,A1),A0
            moveq   #-$5E,D0
            tst.b   (2,A0)
            ble.b   MPPStatus.L3
            moveq   #0,D2
            move.b  (A0),D2
            move.l  ($33E,A2),D1
            btst    #$F,D1
            beq.b   .L3
            moveq   #-$5F,D0
            btst    #$1E,D1
            beq.b   MPPStatus.L3
            move.l  D3,D2
.L3:
            bsr.b   sub_408E2370
            bra.b   MPPStatus.L3
MPPStatus:
            movea.l ($2D8).w,A2
            btst    #$1E,($33E,A2)
            beq.b   .L1
            moveq   #-$12,D0
            bra.b   .L3
.L1:
            moveq   #-$12,D0
            cmpi.w  #$190,($1A,A0)
            bne.b   .L3
            movea.l ($1C,A0),A1
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($3D0,A2),A3
            moveq   #$F,D0
            moveq   #0,D1
.L2:
            move.l  (A3),(A1)+
            move.l  D1,(A3)+
            dbra    D0,.L2
            move    (SP)+,SR
.L3:
            movea.l ($330,A2),A1
.L4:
            tst.w   ($3B8,A2)
            beq.b   sub_408E2346.L1
            bsr.w   sub_408E2B44
            move.w  D0,($3BA,A2)
            move.l  A1,D0
            lea     sub_408E2346,A0
            _DeferUserFn
            rts
sub_408E2346:
            bsr.w   sub_408E2B44
            movea.l ($2D8).w,A1
            move.w  ($3BA,A1),D0
            movea.l A0,A1
.L1:
            move.l  JIODone,-(SP)
            rts
MPPPrime:
            bclr    #7,(5,A1)
            rts
.L1:
            tst.b   ($2C8,A2)
            bne.b   sub_408E2378.L3
.L2:
            movea.l ($2BE,A2),A0
            moveq   #-$5F,D0
            jmp     (A0)
sub_408E2370:
            clr.b   ($2C8,A2)
            move.l  A1,($2BA,A2)
sub_408E2378:
            movea.l ROMBase,A3
            cmpi.b  #3,(8,A3)
            bne.b   .L1
            movea.l PmgrBase,A3
            move.b  #$10,($E,A3)
            tst.w   ($FE0000).l
.L1:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L2
            _IdleUpdate
.L2:
            move.l  (SP)+,($2BE,A2)
            tst.b   ($335,A2)
            beq.b   MPPPrime.L1
.L3:
            move.l  LAPMgrPtr,D3
            ble.b   .L4
            movea.l D3,A3
            clr.w   D3
            move.b  ($334,A2),D3
            jsr     (A3)
.L4:
            tst.l   ($378,A2)
            bne.b   .L8
            tst.b   ($2C8,A2)
            bne.w   sub_408E2490.L4
            cmpi.b  #$FF,D2
            bne.b   .L5
            tst.b   ($2B8,A2)
            beq.w   sub_408E2490.L4
            bsr.b   sub_408E2422
.L5:
            cmp.b   (A2),D2
            bne.w   sub_408E2490.L4
.L6:
            tst.b   ($2B8,A2)
            beq.b   .L7
            bsr.b   sub_408E2422
.L7:
            movea.l ($2BE,A2),A0
            moveq   #0,D0
            jmp     (A0)
.L8:
            cmp.b   (A2),D2
            bne.b   .L9
            tst.w   ($340,A2)
            bpl.b   .L6
            move.l  D2,D0
            lsr.l   #8,D0
            cmp.w   ($1A,A2),D0
            beq.b   .L6
.L9:
            cmpi.b  #$FF,D2
            bne.b   .L11
            tst.b   ($2B8,A2)
            beq.b   .L10
            bsr.b   sub_408E2422
.L10:
            tst.w   ($458,A2)
            beq.b   .L7
.L11:
            movea.l (2,A1),A0
            ori.b   #$80,(2,A0)
            bsr.b   sub_408E2422
            bra.b   .L7
sub_408E2422:
            movem.l D2/A1-A2/A4-A5,-(SP)
            move    SR,-(SP)
            lea     (1,A2),A3
            moveq   #5,D3
            suba.l  A0,A0
            move    #$2600,SR
            bsr.b   sub_408E2490
            move.b  (A2),(2,A2)
            moveq   #7,D2
            move.b  (3,A2),D0
            bpl.b   .L1
            andi.b  #$7F,(3,A2)
            move.b  #$80,D0
.L1:
            move.w  (4,A2),D1
            andi.w  #$3FF,D1
            subq.w  #2,D1
.L2:
            cmp.b   ($24,A2,D2.w),D0
            dbeq    D2,.L2
            bne.b   .L3
            lsl.w   #2,D2
            movea.l ($2C,A2,D2.w),A5
            lea     .L4,A4
            jsr     (A5)
.L3:
            move    (SP)+,SR
            movem.l (SP)+,D2/A1-A2/A4-A5
            rts
.L4:
            bra.b   .L6
            tst.w   D3
            beq.b   .L7
            sub.w   D3,D1
            bsr.b   sub_408E2490
.L7:
            move.w  D1,D3
            neg.w   D3
            moveq   #0,D0
            rts
.L6:
            sub.w   D3,D1
            bsr.b   sub_408E2490
            beq.b   .L5
            moveq   #-4,D0
.L5:
            rts
sub_408E2490:
            moveq   #0,D0
            move.w  (A1),D0
            sub.w   A0,D0
            bne.b   .L1
            addq.w  #6,A1
            suba.l  A0,A0
            move.w  (A1),D0
            beq.b   .L3
.L1:
            cmp.w   D0,D3
            bcc.b   .L2
            move.w  D3,D0
.L2:
            movem.l D0/A0-A1,-(SP)
            adda.l  (2,A1),A0
            movea.l A3,A1
            _BlockMove
            movem.l (SP)+,D0/A0-A1
            adda.w  D0,A0
            adda.w  D0,A3
            sub.w   D0,D3
            bne.b   sub_408E2490
.L3:
            move.w  D3,D0
            rts
.L4:
            tst.w   ($3B8,A2)
            beq.b   .L6
            bsr.w   sub_408E2B44
            movea.l ($2BA,A2),A1
            bsr.w   sub_408E5200
            beq.b   .L5
            bra.w   MPPPrime.L2
.L5:
            move.l  A1,($2BA,A2)
.L6:
            move.b  D2,($2C4,A2)
            lea     ($2CB,A2),A3
            move.b  (A3)+,D3
            move.b  (A3),D2
            add.b   D2,(A3)+
            bsr.b   sub_408E24FE
            ble.b   sub_408E24FE.L3
            add.b   D3,D3
            addq.b  #1,D3
            andi.w  #$F,D3
            clr.b   (-1,A3)
            bra.b   sub_408E24FE.L4
sub_408E24FE:
            moveq   #0,D0
            moveq   #7,D1
.L1:
            btst    D1,D2
            beq.b   .L2
            addq.w  #1,D0
.L2:
            dbra    D1,.L1
            subq.b  #2,D0
            rts
.L3:
            move.b  (A3),D2
            bsr.b   sub_408E24FE
            bge.b   .L4
            lsr.b   #1,D3
            st      (A3)
.L4:
            move.b  (A3),D2
            add.b   D2,(A3)+
            moveq   #$20,D0
            move.b  D0,(A3)+
            move.b  D0,(A3)
            subq.w  #5,A3
            move.b  D3,(A3)+
            move.b  D3,(A3)+
            movem.l SCCRd,A0-A1
.L5:
            move    SR,-(SP)
.L6:
            move.w  D0,D3
            btst    #4,(A0)
            beq.b   .L10
            bsr.w   sub_408E26C8
            and.b   ($2CA,A2),D0
            andi.w  #$F,D0
            move.w  D0,D3
            beq.b   .L8
.L7:
            bsr.b   sub_408E25CA
            beq.b   .L10
            subq.w  #1,D0
            bne.b   .L7
.L8:
            move    #$2600,SR
            moveq   #3,D0
            addq.w  #3,D3
.L9:
            move.b  #$E,(A1)
            nop
            move.b  #$41,(A1)
            bsr.b   sub_408E25CA
            dbeq    D0,.L9
.L10:
            beq.w   sub_408E25CA.L9
            move.b  #$A,(A1)
            move.b  ($2C4,A2),D2
            tst.b   (A0)
            bmi.w   sub_408E25CA.L9
            move.b  #5,(A1)
            moveq   #-$7C,D0
            move.b  #$62,(A1)
            tst.b   ($2C8,A2)
            beq.b   .L11
            moveq   #-$7F,D0
.L11:
            move.b  #5,(A1)
            nop
            move.b  ($323,A2),(A1)
            move.w  ($2E4,A2),D1
.L12:
            dbra    D1,.L12
            bsr.w   sub_408E279A
            addq.b  #1,D2
            beq.b   sub_408E25CA.L4
            clr.b   ($2C6,A2)
            bsr.w   sub_408E26AC
            tst.b   ($2C8,A2)
            beq.b   .L13
            tst.b   ($2C7,A2)
            beq.b   sub_408E25CA.L8
            bra.b   sub_408E25CA.L6
.L13:
            tst.b   ($2C6,A2)
            st      ($2C6,A2)
            beq.b   sub_408E25CA.L8
            bra.b   sub_408E25CA.L5
sub_408E25CA:
            move.w  ($2E0,A2),D1
            bra.b   .L2
.L1:
            dbra    D1,.L1
            bra.b   .L3
.L2:
            bra.b   .L1
.L3:
            btst    #4,(A0)
            rts
.L4:
            bsr.b   sub_408E25CA
            beq.b   .L8
            cmpi.w  #$72,($2E0,A2)
            bcs.b   .L5
            bsr.b   sub_408E25CA
            beq.b   .L8
.L5:
            bsr.w   sub_408E2710
.L6:
            moveq   #0,D0
            addq.l  #1,($3D8,A2)
.L7:
            move    (SP)+,SR
            movea.l ($2BE,A2),A0
            jmp     (A0)
.L8:
            addq.l  #1,($3F4,A2)
            move    (SP),SR
            bset    #0,($2CC,A2)
            move.b  ($2CA,A2),D0
            add.b   D0,D0
            addq.b  #1,D0
            move.b  D0,($2CA,A2)
            moveq   #-$5F,D0
            subq.b  #1,($2CF,A2)
            beq.b   .L7
            bra.w   sub_408E24FE.L6
.L9:
            sub.w   D0,D3
            subq.w  #4,D3
            blt.b   .L10
            addq.l  #1,($3F8,A2)
            moveq   #-$5F,D0
            subq.b  #1,($2CE,A2)
            beq.b   .L7
            bset    #0,($2CA,A2)
            bset    #0,($2CD,A2)
.L10:
            move    #$2600,SR
            move.b  #$F,(A1)
            moveq   #-$78,D0
            move.b  D0,(A1)
            move.b  #2,($2C9,A2)
            moveq   #0,D0
.L11:
            move    (SP)+,SR
            rts
sub_408E265A:
            movea.l ($2D8).w,A2
            tst.b   ($2C9,A2)
            bne.b   .L1
            btst    #3,D1
            beq.b   sub_408E26AC.L3
            movea.l ($2C2).w,A3
            jmp     (A3)
.L1:
            clr.b   ($2C9,A2)
.L2:
            move.b  #$F,(A1)
            moveq   #8,D0
            move.b  D0,(A1)
            move    ($1C,A2),SR
            bra.w   sub_408E24FE.L5
sub_408E2684:
            bsr.w   sub_408E50FA
            move    SR,-(SP)
            move    #$2600,SR
            tst.b   ($2C9,A2)
            beq.b   sub_408E25CA.L11
            subq.b  #1,($2C9,A2)
            bne.b   sub_408E25CA.L11
            addq.w  #2,SP
            movem.l SCCRd,A0-A1
            bsr.w   sub_408E2958
            addq.l  #1,($3FC,A2)
            bra.b   sub_408E265A.L2
sub_408E26AC:
            movem.l A0-A2,-(SP)
            move.w  ($2DA,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L2
            bsr.w   sub_408E27F4
.L2:
            movem.l (SP)+,A0-A2
.L3:
            rts
sub_408E26C8:
            move.w  ($2C2,A2),D0
            mulu.w  #$305,D0
            addq.w  #1,D0
            move.w  D0,-(SP)
            lsl.w   #8,D0
            move.b  (SP)+,D0
            move.w  D0,($2C2,A2)
            rts
.L1:
            dc.w    $056B,$03D0
sub_408E26E2:
            move.w  ($2D6,A2),D1
.L1:
            btst    #2,(A0)
            dbne    D1,.L1
            beq.b   .L2
            move.b  D3,(4,A1)
.L2:
            tst.w   D1
            rts
sub_408E26F8:
            lea     sub_408E26C8.L1,A3
            moveq   #4,D3
            bsr.w   sub_408E27E4
            move.w  ($2DC,A2),D3
.L1:
            dbra    D3,.L1
            move.b  #$80,(A1)
            rts
sub_408E2710:
            movem.l A0-A1/A4-A6,($30A,A2)
            move.l  DskRtnAdr,-(SP)
            move.l  PollStack,-(SP)
            move.l  SP,PollStack
            movea.l ($31E,A2),A5
            cmpi.w  #$D,($3C8,A2)
            bne.b   .L1
            movea.l SCCRd,A5
            lea     (-$1C,A5),A5
.L1:
            lea     (6,A0),A6
            movea.l ($2BA,A2),A4
            bsr.b   sub_408E26F8
            move.w  (A4)+,D3
            movea.l (A4)+,A3
            move.b  (A3)+,(4,A1)
            subq.w  #1,D3
            move.b  (A2),(A3)
.L2:
            move.w  ($2D6,A2),D0
.L3:
            btst    #2,(A0)
            dbne    D0,.L3
            bne.b   .L4
            bsr.w   sub_408E27DE
            bra.b   .L7
.L4:
            move.b  (A3)+,(4,A1)
            tst.b   (A5)
            bmi.b   .L5
            move.b  (A6),-(SP)
.L5:
            subq.w  #1,D3
            bgt.b   .L2
            move.w  (A4)+,D3
            beq.b   .L6
            movea.l (A4)+,A3
            bra.b   .L2
.L6:
            bsr.b   sub_408E27BA
.L7:
            move.l  PollProc,D3
            beq.b   .L8
            movea.l D3,A4
            jsr     (A4)
            movea.l ($2D8).w,A2
.L8:
            movem.l ($30A,A2),A0-A1/A4-A6
            movea.l PollStack,SP
            move.l  (SP)+,PollStack
            move.l  (SP)+,DskRtnAdr
            rts
sub_408E279A:
            bsr.w   sub_408E26F8
            move.b  D2,(4,A1)
            move.b  (A2),D3
            cmpi.b  #$81,D0
            bne.b   .L1
            move.b  D2,D3
.L1:
            bsr.w   sub_408E26E2
            bmi.b   sub_408E27DE
            move.b  D0,D3
            bsr.w   sub_408E26E2
            bmi.b   sub_408E27DE
sub_408E27BA:
            move.b  #$C0,(A1)
            lsl.w   #1,D3
.L1:
            btst    #6,(A0)
            beq.b   .L1
.L2:
            btst    #2,(A0)
            beq.b   .L2
            move.b  #5,(A1)
            moveq   #0,D3
            move.b  #$62,(A1)
            move.w  ($2D2,A2),D3
.L3:
            dbra    D3,.L3
sub_408E27DE:
            lea     ($322,A2),A3
            moveq   #6,D3
sub_408E27E4:
            move.b  (A3)+,(A1)
            subq.w  #1,D3
            bne.b   sub_408E27E4
            rts
sub_408E27EC:
            movea.l ($2D8).w,A2
            addq.l  #1,($3D0,A2)
sub_408E27F4:
            lea     (1,A2),A3
            move.b  (4,A0),(A3)+
            move.w  ($2D4,A2),D1
            add.w   D1,D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.b   .L6
            move.b  (4,A0),(A3)+
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   .L6
            move.b  (4,A0),D0
            move.b  D0,(A3)+
            bmi.b   .L9
            moveq   #7,D2
.L3:
            cmp.b   ($24,A2,D2.w),D0
            dbeq    D2,.L3
            lsl.w   #2,D2
            move.w  ($2D4,A2),D0
            add.w   D0,D0
.L4:
            btst    #0,(A0)
            dbne    D0,.L4
            beq.b   .L6
            move.b  (4,A0),(A3)
            moveq   #3,D1
            and.b   (A3)+,D1
            lsl.w   #8,D1
            movem.l A4-A5,($2E6,A2)
.L5:
            btst    #0,(A0)
            dbne    D0,.L5
.L6:
            beq.w   sub_408E2902.L2
            move.b  (4,A0),D1
            move.b  D1,(A3)+
            subq.w  #2,D1
            tst.w   D2
            bmi.b   .L8
            movea.l ($2C,A2,D2.w),A5
            lea     sub_408E2994.L6,A4
            tst.w   ($3B8,A2)
            beq.b   .L7
            bsr.w   sub_408E2B44
            bra.w   sub_408E52E8.L4
.L7:
            RTS5
.L8:
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            bne.w   sub_408E2994.L1
            addq.l  #1,($3E8,A2)
            clr.w   D3
            bra.w   sub_408E2994.L7
.L9:
            moveq   #$7F,D2
            and.b   D0,D2
            cmpi.b  #5,D2
            bgt.b   sub_408E2902.L1
            bsr.b   sub_408E291E
            bne.b   .L10
            cmpi.b  #$FF,(1,A2)
            seq     D1
            beq.b   .L11
            tst.b   ($2C5,A2)
            bne.b   .L11
            st      ($2C7,A2)
.L10:
            rts
.L11:
            subq.b  #1,D2
            beq.b   .L17
            subq.b  #3,D2
            beq.b   .L13
            tst.b   ($2C6,A2)
            beq.b   .L12
            addq.l  #1,($408,A2)
.L12:
            subq.b  #1,D2
            seq     ($2C6,A2)
            rts
.L13:
            tst.b   D1
            bne.b   .L15
            move.w  ($2DE,A2),D0
.L14:
            dbra    D0,.L14
            moveq   #-$7B,D0
            bsr.b   sub_408E2902
.L15:
            move.w  ($2D8,A2),D1
.L16:
            btst    #0,(A0)
            dbne    D1,.L16
            bne.w   sub_408E27F4
            addq.l  #1,($404,A2)
            rts
.L17:
            move.w  ($2DE,A2),D0
.L18:
            dbra    D0,.L18
            moveq   #-$7E,D0
sub_408E2902:
            move.b  (2,A2),D2
            bra.w   sub_408E279A
            addq.l  #1,($3E8,A2)
            bra.b   .L3
.L1:
            addq.l  #1,($3F0,A2)
            bra.b   .L3
.L2:
            addq.l  #1,($3E4,A2)
.L3:
            bsr.b   sub_408E2958
            bra.b   sub_408E2958
sub_408E291E:
            clr.w   D0
            move.w  ($2D4,A2),D1
.L1:
            btst    #0,(A0)
            dbne    D1,.L1
            beq.w   sub_408E2994.L3
            bsr.b   sub_408E2994
            bmi.b   sub_408E2994.L2
            tst.b   (4,A0)
            move.w  ($2D4,A2),D1
.L2:
            btst    #0,(A0)
            dbne    D1,.L2
            beq.b   sub_408E2994.L3
            bsr.b   sub_408E2994
            bpl.b   sub_408E2994.L2
            lsl.b   #1,D1
            bmi.b   sub_408E2994.L4
            move.w  ($2E2,A2),D1
.L3:
            dbra    D1,.L3
            bra.b   sub_408E2958.L3
sub_408E2958:
            bsr.b   sub_408E2994
            btst    #5,D1
            beq.b   .L1
            bclr    #7,($15F).w
.L1:
            moveq   #-$30,D1
            bsr.b   sub_408E298A
            moveq   #2,D1
.L2:
            tst.b   (4,A0)
            move.b  #$30,(A1)
            dbra    D1,.L2
            moveq   #-$23,D1
            bsr.b   sub_408E298A
.L3:
            move.b  #$30,(A1)
            move.w  (SP),(SP)
            move.b  #$20,(A1)
            tst.w   D0
            rts
sub_408E298A:
            move.b  #3,(A1)
            nop
            move.b  D1,(A1)
            rts
sub_408E2994:
            move.b  #1,(A1)
            nop
            move.b  (A0),D1
            rts
.L1:
            move.b  D0,D1
            moveq   #0,D0
.L2:
            btst    #5,D1
            bne.b   .L5
            addq.l  #1,($3EC,A2)
            moveq   #-4,D0
            bra.b   sub_408E2958
.L3:
            addq.l  #1,($3E4,A2)
            moveq   #-3,D0
            bra.b   sub_408E2958
.L4:
            addq.l  #1,($3DC,A2)
            moveq   #-2,D0
            bra.b   sub_408E2958
.L5:
            addq.l  #1,($3E0,A2)
            moveq   #-1,D0
            bra.b   sub_408E2958
.L25:
            bra.w   .L24
.L6:
            bra.b   .L25
.L7:
            movea.l ($31E,A2),A5
            cmpi.w  #$D,($3C8,A2)
            bne.b   .L8
            movea.l SCCRd,A5
            lea     (-$1C,A5),A5
.L8:
            movea.l SP,A4
.L9:
            move.w  ($2D4,A2),D0
            subq.w  #1,D1
            bmi.b   .L12
.L10:
            btst    #0,(A0)
            dbne    D0,.L10
            beq.b   .L12
            move.b  (4,A0),D0
            tst.b   (A5)
            bmi.b   .L11
            move.b  (6,A0),-(SP)
.L11:
            subq.w  #1,D3
            bmi.b   .L9
            move.b  D0,(A3)+
            bra.b   .L9
.L12:
            bsr.w   sub_408E291E
            move.l  PollStack,($2F2,A2)
            move.l  A4,PollStack
            move.l  PollProc,D1
            beq.b   .L13
            movem.l D0/D2-D3/A3/A6,($30A,A2)
            lea     (6,A0),A6
            movea.l D1,A0
            move.l  DskRtnAdr,($2EE,A2)
            jsr     (A0)
            movea.l ($2D8).w,A2
            move.l  ($2EE,A2),DskRtnAdr
            movem.l ($30A,A2),D0/D2-D3/A3/A6
.L13:
            movea.l PollStack,SP
            move.l  ($2F2,A2),PollStack
.L14:
            movem.l ($2E6,A2),A4-A5
            tst.w   D0
            bne.b   .L15
            addq.l  #1,($3D4,A2)
.L15:
            tst.w   D0
.L16:
            rts
.L24:
            sub.w   D3,D1
.L17:
            move.w  ($2D4,A2),D0
.L18:
            btst    #0,(A0)
            dbne    D0,.L18
            beq.b   .L19
            move.b  (4,A0),(A3)+
            subq.w  #1,D3
            bne.b   .L17
            move.b  #1,(A1)
            moveq   #-$60,D0
            and.b   (A0),D0
            beq.b   .L16
            bmi.b   .L20
            addq.l  #1,($3E0,A2)
            moveq   #-1,D0
            bra.b   .L21
.L19:
            addq.l  #1,($3E4,A2)
            moveq   #-3,D0
            bra.b   .L21
.L20:
            addq.l  #1,($3EC,A2)
            moveq   #-4,D0
.L21:
            bsr.w   sub_408E2958
            bra.b   .L14
            move.l  A0,-(SP)
            link.w  A4,#-$34
            clr.w   (-2,A4)
            movem.l D4-D7/A5-A6,-(SP)
            suba.w  #$2A,SP
            movea.l SP,A1
            moveq   #$29,D0
.L22:
            move.b  (A0)+,(A1)+
            dbra    D0,.L22
            movea.l SP,A6
            addq.w  #1,($24,A6)
            move.l  ($33E,A2),D6
            suba.w  #$16,SP
            movea.l SP,A1
            bsr.w   sub_408E376C
            tst.w   D0
            bne.b   .L23
            cmpi.w  #3,(A1)
            bcs.b   .L23
            move.w  ($14,A1),(-2,A4)
.L23:
            lea     ($16,SP),SP
            bsr.w   sub_408E380A
            move.w  ($24,A6),D1
            lea     ($2A,SP),SP
            movem.l (SP)+,D4-D7/A5-A6
            unlk    A4
            movea.l (SP)+,A0
            move.w  D1,($24,A0)
            pea     ($418,A2)
            move.l  (SP)+,($26,A0)
            moveq   #0,D0
            bra.w   MPPStatus.L3
            lea     ($33A,A2),A1
            move.l  A1,($1C,A0)
            lea     ($33E,A2),A1
            move.l  A1,($20,A0)
            lea     ($356,A2),A1
            move.l  A1,($24,A0)
            lea     ($344,A2),A1
            move.l  A1,($28,A0)
            lea     ($346,A2),A1
            move.l  A1,($2C,A0)
            lea     ($410,A2),A1
            move.l  A1,($30,A0)
            lea     ($414,A2),A1
            move.l  A1,($34,A0)
            bra.w   sub_408E151E.L12
sub_408E2B44:
            move.l  A0,-(SP)
            movea.l ROMBase,A0
            cmpi.b  #$76,(9,A0)
            bcs.b   .L1
            movea.l ($D1C).w,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L1
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .L1
            move.l  ($C,A0),-(SP)
            movea.l (4,SP),A0
            move.l  (SP)+,(SP)
            rts
.L1:
            movea.l (SP)+,A0
            rts
            move.l  A0,-(SP)
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            pea     ($1C,A0)
            bsr.w   sub_408E553A
            addq.w  #4,SP
            movea.l (SP)+,A0
            bne.b   .L2
            clr.l   ($1C,A0)
            bra.w   MPPStatus.L3
.L2:
            moveq   #-$18,D0
            bra.w   MPPStatus.L3
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            bsr.w   sub_408E55AA
            moveq   #0,D0
            bra.w   MPPStatus.L3
            moveq   #-$32,D0
            cmpi.w  #1,($1C,A0)
            bhi.w   MPPStatus.L3
            lea     ($1E,A0),A3
            moveq   #$12,D0
.L3:
            clr.w   (A3)+
            dbra    D0,.L3
            move.l  A2,($1E,A0)
            move.l  ($330,A2),($22,A0)
            move.b  ($334,A2),($27,A0)
            move.l  ($33E,A2),($28,A0)
            move.b  ($2B8,A2),($2D,A0)
            move.l  ($344,A2),($2E,A0)
            moveq   #0,D0
            move.w  ($1A,A2),D0
            lsl.l   #8,D0
            move.b  (A2),D0
            move.l  D0,($32,A0)
            move.l  ($33A,A2),($36,A0)
            move.b  ($22,A2),($3B,A0)
            move.b  ($23,A2),($3D,A0)
            move.l  ($2A8,A2),D0
            beq.b   sub_408E2C18
            movea.l D0,A3
            move.b  (A3),($3F,A0)
            move.l  ($2B0,A2),($40,A0)
sub_408E2C18:
            movem.l D4/D7/A0-A1,-(SP)
            suba.w  #$16,SP
            movea.l SP,A1
            move.b  ($334,A2),D0
            pea     (A0)
            bsr.w   sub_408E376C
            movea.l (SP)+,A0
            tst.w   D0
            bne.b   .L1
            exg     A0,A1
            moveq   #0,D0
            move.w  ($44,A1),D0
            clr.w   ($44,A1)
            move.b  ($D,A0),($45,A1)
            move.l  ($46,A1),D1
            beq.b   .L1
            lea     ($E,A0),A0
            movea.l D1,A1
            _BlockMove
.L1:
            lea     ($16,SP),SP
            movem.l (SP)+,D4/D7/A0-A1
            tst.l   ($4A,A0)
            beq.b   .L2
            movea.l ($4A,A0),A1
            lea     ($356,A2),A0
            moveq   #$21,D0
            _BlockMove
.L2:
            moveq   #0,D0
            bra.w   MPPStatus.L3
sub_408E2C72:
            movem.l A1-A2,-(SP)
            btst    #8,D6
            bne.b   .L1
            moveq   #4,D0
            bsr.w   sub_408E3966
            moveq   #8,D0
            jsr     (2,A0)
.L1:
            movem.l (SP)+,A1-A2
            rts
sub_408E2C8E:
            btst    #8,D6
            beq.b   .L1
            moveq   #$12,D0
            moveq   #1,D1
            bsr.w   sub_408E3966
            st      PortBUse
            bra.b   .L2
.L1:
            moveq   #$13,D0
            bsr.w   sub_408E3966
            move.b  D1,PortBUse
            cmpi.b  #1,D1
            bne.b   .L2
            st      PortBUse
.L2:
            rts
sub_408E2CB8:
            tst.w   (4,A0)
            beq.b   .L1
            _VRemove
.L1:
            rts
sub_408E2CC2:
            move.w  #$3FC,($A,A0)
            lea     (-$394,A0),A2
            clr.w   ($392,A2)
            rts
MPPClose:
            movea.l A0,A6
            movea.l ($14,A1),A2
            move.l  ($33E,A2),D6
            btst    #$D,D6
            beq.b   .L1
            move.l  A1,-(SP)
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            bsr.w   sub_408E5510
            movea.l (SP)+,A1
.L1:
            movea.l ($14,A1),A2
            move.l  A2,D0
            beq.w   .L16
.L2:
            move    SR,-(SP)
            ori     #$2600,SR
            tst.l   (8,A1)
            beq.b   .L3
            move    (SP)+,SR
            bra.b   .L2
.L3:
            bclr    #5,(5,A1)
            move.l  A1,-(SP)
            moveq   #$7E,D6
            lea     ($96,A2),A1
.L4:
            clr.l   (A1)+
            dbra    D6,.L4
            moveq   #$D,D6
            lea     ($4C,A2),A1
.L5:
            clr.b   (A1)+
            dbra    D6,.L5
            movea.l (SP)+,A1
            move    (SP)+,SR
            move.l  ($33E,A2),D6
            btst    #$D,D6
            beq.w   .L11
            bset    #$A,D6
            or.l    D6,($33E,A2)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #$FFF5,($18,A0)
            _Close
            move.w  #$FFD7,($18,A0)
            move.w  #$F6,($1A,A0)
            move.w  #1,($1C,A0)
            move.w  #7,($1E,A0)
            _Control
            move.w  #6,($1E,A0)
            _Control
            move.w  #5,($1E,A0)
            _Control
            lea     ($32,SP),SP
            btst    #$F,D6
            beq.b   .L6
            btst    #$1E,D6
            bne.b   .L6
            bsr.w   sub_408E125A
.L6:
            moveq   #0,D3
            movea.l ($2A0,A2),A0
            cmpa.w  #0,A0
            beq.b   .L7
            jsr     (A0)
.L7:
            move    SR,-(SP)
            move    #$2600,SR
            move.l  ($2A8,A2),D0
            beq.b   .L8
            movea.l D0,A0
            _DisposPtr
.L8:
            move.l  ($2B4,A2),D0
            beq.b   .L9
            moveq   #$1A,D1
            sub.l   D1,D0
            movea.l D0,A0
            _DisposPtr
.L9:
            btst    #$1E,D6
            bne.b   .L10
            btst    #8,D6
            beq.b   .L10
            lea     sub_408E2E66.L2,A0
            bsr.w   sub_408E2E66
            lea     ($2FE,A2),A0
            lea     ($1BA).w,A3
            move.l  (A0)+,(A3)+
            move.l  (A0)+,(A3)+
            move.l  (A0)+,ExtStsDT
.L10:
            move    (SP)+,SR
.L11:
            move.l  ($92,A2),D0
            beq.b   .L12
            movea.l D0,A0
            _DisposPtr
.L12:
            move.l  ($380,A2),D0
            beq.b   .L13
            movea.l D0,A0
            _DisposPtr
.L13:
            lea     ($292,A2),A0
            bsr.w   sub_408E2CB8
            lea     ($394,A2),A0
            bsr.w   sub_408E2CB8
            bsr.w   sub_408E51C6
            move.b  ($334,A2),D4
            bsr.w   sub_408E2C72
            btst    #$D,D6
            bne.b   .L14
            movea.l UTableBase,A4
            move.w  ($18,A6),D2
            not.w   D2
            lsl.w   #2,D2
            movea.l (0,A4,D2.w),A0
            _HPurge
            clr.l   (0,A4,D2.w)
            bra.b   .L16
.L14:
            bsr.w   sub_408E2C8E
            clr.l   ($2D8).w
            btst    #$1E,D6
            beq.b   .L15
            move.l  ($336,A2),AtalkHk1
.L15:
            btst    #8,HWCfgFlags
            beq.b   .L16
            moveq   #0,D0
            bset    #7,D0
            _SerialPower
.L16:
            movea.l A2,A0
            cmpa.w  #0,A0
            beq.b   .L17
            _DisposPtr
.L17:
            clr.l   ($14,A1)
            moveq   #0,D0
.L18:
            rts
sub_408E2E66:
            movea.l SCCWr,A3
.L1:
            move.w  (A0)+,D0
            beq.b   MPPClose.L18
            move.b  D0,(A3)
            ror.w   #8,D0
            move.b  D0,(A3)
            bra.b   .L1
.L2:
            dc.w    $4A09,$000A,$1000,$080F,$0101,0,$2C54
MPPOpen:
            moveq   #0,D6
            movea.l A0,A6
            moveq   #-$17,D0
            move.l  LAPMgrPtr,D1
            ble.b   .L1
            bra.b   .L2
.L1:
            rts
.L2:
            suba.l  A2,A2
            btst    #9,(6,A6)
            beq.b   .L4
            btst    #$1E,($1C,A6)
            beq.b   .L3
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            tst.b   ($1F7,A3)
            bne.b   .L1
.L3:
            move.l  ($1C,A6),D6
            andi.l  #$E0000000,D6
.L4:
            link.w  A4,#-$34
            movea.l A4,A0
            move.w  #$19,D0
.L5:
            clr.w   -(A0)
            dbra    D0,.L5
            bclr    #6,(5,A1)
            move.w  ($18,A6),D0
            cmpi.w  #$FFF6,D0
            bne.b   .L6
            lea     (-$34,A4),A0
            move.w  #2,($1A,A0)
            move.w  D0,($18,A0)
            _Control async
.L6:
            moveq   #0,D0
            moveq   #0,D2
            btst    #$1E,D6
            beq.b   .L7
            move.b  ($1A,A6),D0
            andi.b  #$7F,D0
.L7:
            move.l  A1,-(SP)
            suba.w  #$16,SP
            movea.l SP,A1
            bsr.w   sub_408E376C
            tst.w   D0
            bne.b   .L9
            move.b  ($D,A1),D2
            btst    #7,($C,A1)
            beq.b   .L8
            bset    #$F,D6
.L8:
            cmpi.w  #3,(A1)
            bcs.b   .L9
            move.w  ($14,A1),(-2,A4)
.L9:
            lea     ($16,SP),SP
            movea.l (SP)+,A1
            tst.l   D7
            bne.b   .L10
            bset    #8,D6
.L10:
            cmpi.w  #$FFF6,($18,A6)
            bne.b   .L12
            bset    #$D,D6
            clr.l   ($2D8).w
            tst.b   PortBUse
            bmi.b   .L11
            move.l  A1,-(SP)
            moveq   #$13,D0
            bsr.w   sub_408E3966
            movea.l (SP)+,A1
            moveq   #-$61,D0
            cmp.b   PortBUse,D1
            bne.w   .L59
.L11:
            moveq   #-$62,D0
            move.b  SPConfig,D1
            andi.b  #$F,D1
            subq.b  #1,D1
            bgt.w   .L59
            st      PortBUse
            btst    #8,D6
            beq.b   .L12
            move.l  A1,-(SP)
            moveq   #$11,D0
            moveq   #1,D1
            bsr.w   sub_408E3966
            movea.l (SP)+,A1
            bne.w   .L59
            bra.b   .L14
.L12:
            moveq   #0,D4
            btst    #$1E,D6
            beq.b   .L13
            move.b  ($1A,A6),D4
.L13:
            move.l  A1,-(SP)
            andi.b  #$7F,D4
            moveq   #4,D0
            bsr.w   sub_408E3966
            moveq   #7,D0
            jsr     (2,A0)
            movea.l (SP)+,A1
            cmpi.w  #$FF9F,D0
            beq.w   .L59
.L14:
            clr.l   ($14,A1)
            move.l  #$45A,D0
            _NewPtrSysClear
            bne.w   .L59
            movea.l A0,A2
            move.l  A2,($14,A1)
            move.l  A1,($330,A2)
            move.l  D7,($378,A2)
            move.l  D6,($33E,A2)
            move.b  RsrcDRVR_9.L1,(7,A1)
            move.b  D2,($353,A2)
            moveq   #0,D0
            move.w  D0,($344,A2)
            subq.w  #2,D0
            move.w  D0,($346,A2)
            suba.w  #$10,SP
            movea.l SP,A0
            move.w  #1,D0
            _SysEnvirons
            move.w  (4,A0),($3AA,A2)
            lea     ($10,SP),SP
            move.w  #$A02E,D0
            _GetTrapAddress
            move.l  A0,($3CC,A2)
            btst    #$D,D6
            beq.b   .L16
            btst    #8,HWCfgFlags
            beq.b   .L15
            moveq   #1,D0
            _SerialPower
.L15:
            move.b  #1,PortBUse
            move.l  A2,($2D8).w
            move.l  A1,ABusDCE
.L16:
            btst    #$1E,D6
            bne.b   .L17
            btst    #$F,D6
            beq.b   .L20
            lea     ($342,A2),A0
            move.l  #$200DE,D0
            _ReadXPRam
            bra.b   .L19
.L17:
            move.l  ($28,A6),D0
            tst.b   D0
            bne.b   .L18
            move.b  ($16D).w,D0
            add.b   ($20F).w,D0
.L18:
            move.b  D0,($1FA).w
            btst    #$F,D6
            beq.b   .L20
            lsr.l   #8,D0
            move.w  D0,($342,A2)
            move.w  ($24,A6),D0
            beq.b   .L19
            swap    D0
            move.w  ($26,A6),D0
            beq.b   .L19
            move.l  D0,($344,A2)
            bset    #$E,D6
            or.l    D6,($33E,A2)
.L19:
            tst.w   ($342,A2)
            bne.b   .L20
            moveq   #0,D0
            move.b  #$FE,D0
            move.l  D0,-(SP)
            move.b  ($16D).w,D0
            add.b   ($20F).w,D0
            move.l  D0,-(SP)
            bsr.w   sub_408E5478
            addq.w  #8,SP
            addi.w  #$FF00,D0
            move.w  D0,($342,A2)
.L20:
            btst    #$1E,D6
            beq.b   .L21
            move.b  ($1A,A6),D0
            andi.b  #$7F,D0
            move.b  D0,($334,A2)
.L21:
            st      ($335,A2)
            move.w  #$80E,($22,A2)
            moveq   #7,D0
.L22:
            st      ($24,A2,D0.w)
            dbra    D0,.L22
            movea.l VIA,A1
            lea     ($1E00,A1),A1
            movea.l ROMBase,A3
            cmpi.b  #3,(8,A3)
            bne.b   .L23
            suba.w  #$1E00,A1
.L23:
            lea     sub_408E38A6.L6,A0
            move.l  A1,($31E,A2)
            move.l  (A0)+,($322,A2)
            move.w  (A0)+,($326,A2)
            move.w  (A0)+,($1C,A2)
            cmpi.b  #$75,(9,A3)
            beq.b   .L24
            cmpi.b  #$76,(9,A3)
            beq.b   .L24
            move.w  #$2300,($1C,A2)
.L24:
            lea     ($2D2,A2),A1
            moveq   #$14,D0
            cmpi.b  #$76,(9,A3)
            bcs.b   .L30
            moveq   #0,D1
            move.w  TimeDBRA,D1
            divu.w  #$64,D1
            movea.l A3,A0
            lea     sub_408E38A6.L7,A3
.L25:
            move.w  (A3)+,D3
            moveq   #0,D2
            move.b  (A3)+,D2
            divu.w  D1,D2
            sub.w   D2,D3
            tst.b   (A3)+
            bmi.b   .L29
            mulu.w  TimeDBRA,D3
.L26:
            divu.w  #$3E8,D3
            cmpi.b  #2,(8,A0)
            bne.b   .L27
            mulu.w  #6,D3
            lsr.l   #3,D3
.L27:
            subq.w  #1,D3
            bpl.b   .L28
            moveq   #0,D3
.L28:
            move.w  D3,(A1)+
            subq.w  #2,D0
            bne.b   .L25
            bra.b   .L31
.L29:
            mulu.w  TimeSCCDB,D3
            bra.b   .L26
.L30:
            _BlockMove
.L31:
            btst    #$D,D6
            beq.b   .L32
            btst    #$F,D6
            beq.b   .L32
            btst    #$1E,D6
            bne.b   .L32
            bsr.w   sub_408E117C
            lea     ($394,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408E2CC2,A1
            move.l  A1,(6,A0)
            move.w  #$3FC,($A,A0)
            _VInstall
.L32:
            btst    #$1E,D6
            bne.b   .L33
            lea     ($292,A2),A0
            move.w  #1,(4,A0)
            lea     sub_408E2684,A1
            move.l  A1,(6,A0)
            move.w  #$14,($A,A0)
            _VInstall
            btst    #8,D6
            beq.b   .L33
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($1BA).w,A3
            lea     ($2FE,A2),A1
            lea     sub_408E27EC,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408E2902.L3,A0
            move.l  (A3),(A1)+
            move.l  A0,(A3)+
            lea     sub_408E265A,A0
            move.l  ExtStsDT,(A1)
            move.l  A0,ExtStsDT
            lea     sub_408E38A6.L5,A0
            bsr.w   sub_408E2E66
            move    (SP)+,SR
.L33:
            bsr.w   sub_408E3856
            bne.w   .L59
            lea     sub_408E1134,A3
            lea     ($4C,A2),A0
            move.l  A3,-(A0)
            lea     sub_408E10AE,A3
            move.l  A3,-(A0)
            lea     ($2C,A2),A0
            move.b  #1,-(A0)
            move.b  #2,-(A0)
            move.w  #$A03C,D0
            _GetTrapAddress
            move.l  A0,($388,A2)
            btst    #$F,D6
            beq.w   .L42
            bsr.w   sub_408E1F04
            btst    #$D,D6
            beq.b   .L34
            lea     ($356,A2),A0
            move.l  #$2100BD,D0
            _ReadXPRam
            cmpi.b  #$20,($356,A2)
            bls.b   .L34
            clr.b   ($356,A2)
.L34:
            move.l  A2,-(SP)
            pea     ($34A,A2)
            pea     sub_408E215E
            bsr.w   sub_408E54C6
            lea     ($C,SP),SP
            btst    #$1E,D6
            bne.b   .L36
            tst.w   ($34A,A2)
            beq.w   .L40
.L35:
            move.w  ($348,A2),($344,A2)
            move.w  ($34A,A2),($346,A2)
            move.w  ($1A,A2),D0
            cmp.w   ($344,A2),D0
            bcs.b   .L39
            cmp.w   ($346,A2),D0
            bhi.b   .L39
            bra.b   .L40
.L36:
            btst    #$E,D6
            beq.b   .L38
            tst.w   ($34A,A2)
            beq.b   .L37
            move.w  #$EC76,D0
            move.w  ($348,A2),D1
            cmp.w   ($344,A2),D1
            bne.w   .L59
            move.w  ($34A,A2),D1
            cmp.w   ($346,A2),D1
            bne.w   .L59
.L37:
            cmpi.w  #$FF00,($1A,A2)
            bcc.b   .L39
            bra.b   .L40
.L38:
            move.w  #$EC70,D0
            tst.w   ($34A,A2)
            bne.b   .L35
            cmpi.w  #$FF00,($1A,A2)
            bcc.w   .L59
            bra.b   .L40
.L39:
            clr.l   ($418,A2)
            suba.w  #$2A,SP
            moveq   #0,D0
            move.w  ($1A,A2),D0
            lsl.l   #8,D0
            move.b  (A2),D0
            move.l  D0,($1C,SP)
            movea.l SP,A0
            movea.l ($378,A2),A1
            moveq   #$A,D0
            jsr     (2,A1)
            lea     ($2A,SP),SP
            clr.w   ($1A,A2)
            clr.b   (A2)
            bsr.w   sub_408E38A6
            bne.w   .L59
.L40:
            btst    #$1E,D6
            beq.b   .L41
            clr.b   ($57,A2)
            bra.b   .L42
.L41:
            cmpi.w  #$FF00,($1A,A2)
            bcc.b   .L42
            lea     ($1A,A2),A0
            move.l  #$200DE,D0
            _WriteXPRam
            lea     ($356,A2),A0
            tst.b   ($352,A2)
            beq.b   .L42
            move.l  #$2100BD,D0
            _WriteXPRam
.L42:
            btst    #9,(6,A6)
            beq.b   .L43
            bsr.w   sub_408E380A
.L43:
            bsr.w   sub_408E3794
            btst    #$D,D6
            beq.b   .L44
            lea     SPValid,A0
            moveq   #-1,D0
            _WriteParam
.L44:
            clr.b   ($335,A2)
            btst    #$1E,D6
            beq.b   .L45
            lea     sub_408E5648.L1,A0
            move.l  A0,($32C,A2)
            tst.b   ($1A,A6)
            bpl.b   .L46
.L45:
            st      ($335,A2)
.L46:
            lea     sub_408E0F32,A0
            move.l  A0,($2AC,A2)
            move.l  #$28B,D0
            _NewPtrSysClear
            bne.b   .L47
            move.l  A0,($92,A2)
            movea.l ($330,A2),A1
            move.w  ($18,A1),($18,A0)
            lea     ($1A,A0),A1
            move.w  #$F6,(A1)+
            move.w  #$400,(A1)+
            lea     ($22,A0),A3
            move.l  A3,(A1)+
            lea     ($31,A0),A1
            move.l  A1,(2,A3)
            move.b  #4,($F,A1)
            lea     ($41,A0),A1
            move.l  A1,(8,A3)
            lea     sub_408E21DA,A1
            move.l  A1,($8A,A2)
            move.b  #4,($58,A2)
.L47:
            btst    #$1E,D6
            beq.b   .L48
            st      ($2B8,A2)
            btst    #$D,D6
            beq.w   .L55
.L48:
            suba.w  #$32,SP
            lea     sub_408E37F4.L1,A0
            move.l  A0,($12,SP)
            movea.l SP,A0
            clr.b   ($1B,A0)
            _Open
            lea     ($32,SP),SP
            tst.w   D0
            bne.w   .L59
            bset    #9,D6
            or.l    D6,($33E,A2)
            suba.w  #$32,SP
            lea     sub_408E37F4.L2,A0
            move.l  A0,($12,SP)
            movea.l SP,A0
            clr.b   ($1B,A0)
            _Open
            movea.l ROMBase,A0
            cmpi.b  #$76,(9,A0)
            bcs.w   .L54
            movea.l ($D1C).w,A0
            cmpa.w  #$FFFF,A0
            bne.b   .L49
            moveq   #$10,D0
            _ResrvMem sys
            moveq   #$10,D0
            _NewHandleClear async
            bne.w   .L59
            move.l  A0,($D1C).w
            bra.b   .L52
.L49:
            _HUnlock
            moveq   #$10,D0
            _ResrvMem sys
            bne.b   .L52
            moveq   #$10,D0
            _NewHandleClear async
            bne.b   .L52
            move.l  A0,D1
            move.l  (A0),D0
            _StripAddress
            move.l  D0,-(SP)
            movea.l ($D1C).w,A0
            move.l  (A0),D0
            _StripAddress
            movea.l (SP)+,A1
            cmpa.l  D0,A1
            bhi.b   .L50
            movea.l D0,A0
            moveq   #$10,D0
            _BlockMove
            movea.l ($D1C).w,A0
            move.l  D1,($D1C).w
            bra.b   .L51
.L50:
            movea.l D1,A0
.L51:
            _DisposHandle
.L52:
            movea.l ($D1C).w,A0
            _HLock
            movea.l (A0),A0
            movea.l (4,A0),A1
            cmpa.w  #0,A1
            bne.b   .L53
            lea     MPPClose.L18,A1
.L53:
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            move.l  ($286,A3),D0
            bne.b   .L54
            move.l  A1,($286,A3)
            lea     sub_408E462A,A1
            move.l  A1,(4,A0)
.L54:
            movea.l SP,A0
            move.w  #$FFD7,($18,A0)
            move.w  #$F6,($1A,A0)
            clr.w   ($1C,A0)
            move.w  #7,($1E,A0)
            lea     sub_408E470E,A1
            move.l  A1,($20,A0)
            _Control
            move.w  #6,($1E,A0)
            lea     sub_408E470E,A1
            move.l  A1,($20,A0)
            _Control
            move.w  #5,($1E,A0)
            lea     sub_408E470E,A1
            move.l  A1,($20,A0)
            _Control
            lea     ($32,SP),SP
            lea     sub_408E1B26.L13,A3
            move.l  A3,($2A4,A2)
            moveq   #7,D3
            bsr.w   sub_408E151E
.L55:
            btst    #$1E,D6
            beq.b   .L56
            lea     ($292,A2),A0
            move.w  #1,(4,A0)
            move.w  #$7FFF,($A,A0)
            pea     RsrcDRVR_9.L2
            move.l  (SP)+,(6,A0)
            _VInstall
            movea.l ($330,A2),A1
            bra.b   .L58
.L56:
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            st      ($1F7,A1)
            move.l  #'rom ',D0
            _Gestalt
            move.l  A0,D1
            movea.l ABusDCE,A1
            move.l  (A1),D0
            _StripAddress
            movea.l D0,A0
            move.l  ROMBase,D0
            _StripAddress
            cmpa.l  D0,A0
            bcs.b   .L57
            add.l   D0,D1
            cmpa.l  D1,A0
            bcs.b   .L58
.L57:
            _RecoverHandle
            lea     sub_408E5626,A1
            move.l  A1,D0
            lea     RsrcDRVR_9,A1
            sub.l   A1,D0
            _SetHandleSize
.L58:
            bset    #$B,D6
            or.l    D6,($33E,A2)
            move.l  ($33E,A2),($1C,A6)
            bsr.w   sub_408E5152
            bne.b   .L59
            moveq   #0,D0
.L59:
            move.w  D0,-(SP)
            tst.w   D0
            bne.b   .L61
            bsr.w   sub_408E2B44
            lea     sub_408E2422,A0
            move.l  A0,($414,A2)
            btst    #$D,D6
            beq.b   .L60
            movem.l D0/A1-A2,-(SP)
            movea.l ($330,A2),A1
            movea.l JIODone,A0
            jsr     (A0)
            movem.l (SP)+,D0/A1-A2
            clr.l   -(SP)
            pea     (A6)
            jsr     sub_408E5428
            lea     (4,SP),SP
.L60:
            bra.b   .L64
.L61:
            cmpi.w  #$FFF6,($18,A6)
            bne.b   .L63
            movea.l UTableBase,A1
            movea.l ($24,A1),A1
            movea.l (A1),A1
            movea.l (8,A1),A0
            move.l  (A0),(8,A1)
            tst.l   (A0)
            bne.b   .L62
            clr.l   ($C,A1)
.L62:
            cmpi.w  #$FF9F,(SP)
            beq.b   .L63
            cmpi.w  #$FF9E,(SP)
            beq.b   .L63
            bsr.w   sub_408E2C8E
            cmpi.b  #1,PortBUse
            bne.b   .L63
            st      PortBUse
.L63:
            cmpa.w  #0,A2
            beq.b   .L64
            move.b  ($334,A2),D4
            bsr.w   sub_408E2C72
            bsr.w   sub_408E125A
            bsr.w   sub_408E51C6
            lea     ($292,A2),A0
            bsr.w   sub_408E2CB8
            lea     ($394,A2),A0
            bsr.w   sub_408E2CB8
            btst    #$1E,D6
            bne.b   .L64
            clr.l   ($2D8).w
            movea.l A2,A0
            _DisposPtr
.L64:
            move.w  (SP)+,D0
            unlk    A4
            rts
sub_408E3626:
            sub.l   D5,D5
            move.b  ($334,A2),D5
            mulu.w  #$10,D5
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            lea     (0,A3,D5.l),A3
            lea     ($310,A3),A3
            move.b  D0,D2
            move.w  #$100,($354,A2)
.L1:
            tst.b   D0
            beq.b   .L3
            btst    #$F,D6
            beq.b   .L2
            cmpi.b  #$FE,D0
            beq.b   .L3
.L2:
            cmpi.b  #$FF,D0
            bne.b   .L4
.L3:
            tst.w   ($354,A2)
            beq.w   .L13
            move.l  #$FF,-(SP)
            andi.w  #$FF,D2
            move.l  D2,-(SP)
            bsr.w   sub_408E5478
            addq.w  #8,SP
            move.b  D0,D2
            bra.b   .L1
.L4:
            btst    #$F,D6
            bne.b   .L6
            btst    #5,(A3)
            beq.b   .L6
            btst    #$1F,D6
            beq.b   .L5
            tst.b   D0
            bpl.b   .L3
            bra.b   .L6
.L5:
            tst.b   D0
            bmi.b   .L3
.L6:
            subq.w  #1,($354,A2)
            moveq   #$13,D4
            btst    #$F,D6
            beq.b   .L7
            asr.l   #1,D4
            bra.b   .L8
.L7:
            tst.b   D0
            bpl.b   .L8
            btst    #5,(A3)
            beq.b   .L8
            moveq   #$77,D4
.L8:
            move.b  D0,($1FA).w
            clr.b   ($2C5,A2)
            clr.b   ($2C7,A2)
            btst    #$1E,D6
            bne.b   .L9
            btst    #8,D6
            beq.b   .L9
            movea.l SCCWr,A1
            move.b  #6,(A1)
            move.b  ($1FA).w,(A1)
.L9:
            st      ($2C8,A2)
            moveq   #0,D2
            move.w  ($342,A2),D2
            lsl.l   #8,D2
            move.b  ($1FA).w,D2
            moveq   #$F,D0
            lea     ($418,A2),A1
.L10:
            cmp.l   (A1)+,D2
            dbeq    D0,.L10
            beq.w   .L3
            movem.l D2/A3,-(SP)
            bsr.b   sub_408E3728
            movem.l (SP)+,D2/A3
.L11:
            tst.b   ($2C8,A2)
            bne.b   .L11
            tst.b   ($2C7,A2)
            bne.w   .L3
            dbra    D4,.L9
            moveq   #$F,D0
            lea     ($418,A2),A1
.L12:
            tst.l   (A1)+
            dbeq    D0,.L12
            move.l  D2,-(A1)
            st      ($2C5,A2)
.L13:
            rts
sub_408E3728:
            tst.w   (-2,A4)
            beq.b   .L1
            clr.b   ($2C8,A2)
            movea.l ($378,A2),A1
            suba.w  #$2A,SP
            move.l  D2,($1C,SP)
            move.w  D4,($20,SP)
            move.l  A2,($22,SP)
            pea     PortBUse
            move.l  (SP)+,($26,SP)
            movea.l SP,A0
            moveq   #9,D0
            jsr     (2,A1)
            lea     ($2A,SP),SP
            clr.w   D4
            move.b  D0,($2C7,A2)
            bra.b   .L2
.L1:
            bsr.w   sub_408E2378
            clr.b   ($2C8,A2)
.L2:
            rts
sub_408E376C:
            move.b  D0,D4
            move.w  #4,D0
            movem.l A1-A2,-(SP)
            bsr.w   sub_408E3966
            movem.l (SP)+,A1-A2
            bne.b   .L1
            moveq   #-1,D0
            move.l  A0,D7
            beq.b   .L1
            move.w  #3,D0
            move.w  #$16,D1
            jmp     (2,A0)
.L1:
            rts
sub_408E3794:
            btst    #$1E,D6
            bne.b   .L1
            lea     sub_408E47A6.L2,A0
            move.l  A0,($8E,A2)
            move.b  #1,($59,A2)
            btst    #$F,D6
            bne.b   .L1
            bsr.b   sub_408E37C0
            lea     ($2).w,A0
            _Delay
            tst.b   ($19,A2)
            bne.b   .L1
            bsr.b   sub_408E37C0
.L1:
            rts
sub_408E37C0:
            clr.w   -(SP)
            subq.w  #4,SP
            move.w  #9,-(SP)
            movea.l SP,A1
            move.w  #$501,-(SP)
            move.w  #$101,-(SP)
            move.w  #6,-(SP)
            move.w  #1,-(SP)
            st      D2
            move.w  D2,-(SP)
            lea     (1,SP),A3
            move.l  A3,($B,A3)
            bsr.b   sub_408E37F4
.L1:
            tst.b   ($2C8,A2)
            beq.b   .L1
            lea     ($12,SP),SP
            rts
sub_408E37F4:
            bsr.w   sub_408E2370
            st      ($2C8,A2)
            rts
.L1:
            dc.b    4,'.ATP'
            dc.b    $20
.L2:
            dc.b    4,'.XPP'
            dc.b    $20
sub_408E380A:
            subq.w  #1,($24,A6)
            bmi.b   .L4
            tst.w   (-2,A4)
            beq.b   .L4
            moveq   #$E,D5
            move.l  ($344,A2),-(SP)
            btst    #$F,D6
            bne.b   .L1
            clr.l   ($344,A2)
            bra.b   .L2
.L1:
            cmpi.w  #$FF00,($1A,A2)
            bcs.b   .L2
            move.l  #$FF00FFFE,($344,A2)
.L2:
            move.w  D5,-(SP)
            bsr.b   sub_408E38A6
            movem.w (SP)+,D5
            bne.b   .L3
            addq.w  #1,($458,A2)
            subq.w  #1,($24,A6)
            bmi.b   .L3
            dbra    D5,.L2
.L3:
            move.l  (SP)+,($344,A2)
.L4:
            rts
sub_408E3856:
            move.w  #$FE,D7
.L1:
            moveq   #0,D0
            move.b  ($1FA).w,D0
            bsr.w   sub_408E3626
            tst.b   ($2C7,A2)
            beq.b   .L3
            btst    #$F,D6
            bne.b   .L2
            moveq   #-$5F,D0
            bra.b   .L4
.L2:
            pea     ($FE).w
            move.w  ($342,A2),D0
            subi.w  #$FF00,D0
            move.l  D0,-(SP)
            bsr.w   sub_408E5478
            addq.w  #8,SP
            addi.w  #$FF00,D0
            move.w  D0,($342,A2)
            dbra    D7,.L1
            moveq   #-$5F,D0
            bra.b   .L4
.L3:
            move.w  ($342,A2),($1A,A2)
            move.b  ($1FA).w,(A2)
            moveq   #0,D0
.L4:
            rts
sub_408E38A6:
            move.w  ($344,A2),-(SP)
            move.w  ($346,A2),D7
            sub.w   (SP),D7
            moveq   #0,D0
            move.w  ($346,A2),D0
            sub.w   (SP),D0
            move.l  D0,-(SP)
.L1:
            move.w  ($342,A2),D0
            sub.w   (4,SP),D0
            move.l  D0,-(SP)
            bsr.w   sub_408E5478
            addq.w  #4,SP
            add.w   (4,SP),D0
            move.w  D0,($342,A2)
            moveq   #0,D0
            move.b  ($1FA).w,D0
            bsr.w   sub_408E3626
            tst.b   ($2C7,A2)
            bne.b   .L3
            tst.b   (A2)
            bne.b   .L2
            move.w  ($342,A2),($1A,A2)
            move.b  ($1FA).w,(A2)
.L2:
            moveq   #0,D0
            bra.b   .L4
.L3:
            dbra    D7,.L1
            moveq   #-$5F,D0
.L4:
            addq.w  #6,SP
            rts
.L5:
            dc.w    $4009,$2004,$E00A,$0006,$7E07,$060C,$000D,$C00E
            dc.w    $DD03,$0002,$080F,$0901,$0A09,$700B,$210E,$6005
            dc.w    0
.L6:
            dc.w    $0560,$0E41,$03DD,$2100,$0046,$0014,$001E,$0082
            dc.w    $007D,$0028,$0014,$0039
            ds.b    4
.L7:
            dc.w    $0066,$3A00,$0064,$00FF,$00C8,$00FF,$01F4,$00FF
            dc.w    $0190,$72FF,$0046,$2C00,$001E,0,$0064,$5A00
            dc.w    $003C,$FF00,$000A,$4000,$6052
sub_408E3966:
            bra.w   sub_408E3A62.L3
            dc.b    $00,$0C,$60,$00,$04,$32,$38,$02,$80,$00,$00,$00,$08
            dc.b    '56.0.2  '
            dc.b    $00,$37
            dc.b    'LAP Manager v56.0.2  ; '
            dc.w    $A920
            dc.b    'Apple Computer, Inc. 1984-1991&x'
            dc.w    $02B6,$266B,$0074,$B653,$6502,$7600,$E94B,$0643
            dc.w    $030A,$4AB3,$3000,$6602,$4E75
            lea     (0,A3,D3.w),A0
            move.b  ($2C8,A2),D0
            bmi.w   sub_408E3A62.L1
            tst.w   ($3B8,A2)
            beq.b   .L1
            btst    #3,(6,A0)
            beq.b   .L1
            bsr.w   sub_408E5200
            bne.w   MPPPrime.L2
.L1:
            cmpi.b  #1,D0
            beq.b   .L9
            move.l  A0,-(SP)
            moveq   #$F,D1
            lea     ($418,A2),A0
            tst.w   ($340,A2)
            bmi.b   .L3
.L2:
            cmp.b   (3,A0),D2
            addq.w  #4,A0
            dbeq    D1,.L2
            bra.b   .L4
.L3:
            cmp.l   (A0)+,D2
            dbeq    D1,.L3
.L4:
            movem.l (SP)+,A0
            bne.b   .L5
            bra.b   .L6
.L5:
            cmpi.b  #$FF,D2
            bne.b   .L9
.L6:
            tst.w   ($458,A2)
            beq.b   .L7
            cmpi.b  #$FF,D2
            beq.b   .L8
            cmpi.w  #$F,D1
            bne.b   .L11
.L7:
            tst.b   (6,A0)
            bmi.b   .L9
            tst.b   ($2B8,A2)
            beq.b   .L9
            cmpi.b  #$FF,D2
            bne.b   .L11
.L8:
            movea.l A0,A3
            lea     sub_408E3A62,A0
            bra.b   .L10
.L9:
            movea.l A0,A3
            movea.l ($2BE,A2),A0
.L10:
            move.l  (SP)+,D1
            move.l  (A3),-(SP)
.L11:
            rts
sub_408E3A62:
            moveq   #-1,D2
            bra.w   sub_408E2378.L4
.L1:
            lea     PortBUse,A1
            cmpa.l  ($2D8).w,A2
            beq.b   .L2
            lea     (7,A0),A1
            move.b  #1,(A1)
.L2:
            st      D0
            bra.b   sub_408E3966.L9
.L3:
            subq.w  #1,D0
            beq.w   sub_408E4418.L2
            move.l  A3,-(SP)
            cmpi.w  #$1A,D0
            bhi.b   .L5
            lea     .L4,A3
            add.w   D0,D0
            adda.w  (-2,A3,D0.w),A3
            move.l  A3,-(SP)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            rts
.L4:
            dc.w    $0034,$0050,$005A,$0070,$008A,$0372,$03FA,$009A
            dc.w    $00C4,$0362,$007C,$0090,$00A0,$00EC,$0110,$0174
            dc.w    $01BC,$01EC,$0200,$04A2,$060C,$02B4,$02E2,$02F6
.L5:
            moveq   #-1,D0
            bra.b   .L7
            bsr.w   sub_408E456C
            tst.l   (0,A3,D0.w)
            bne.b   .L5
            move.l  A0,(0,A3,D0.w)
            move.b  D1,(6,A3,D0.w)
            move.w  D2,(4,A3,D0.w)
.L6:
            moveq   #0,D0
.L7:
            movea.l (SP)+,A3
            rts
            bsr.w   sub_408E456C
            clr.l   (0,A3,D0.w)
            bra.b   .L6
            bsr.w   sub_408E456C
            movea.l (0,A3,D0.w),A0
            lea     PortBUse,A1
            tst.b   D4
            beq.b   .L6
            lea     (7,A3,D0.w),A1
            bra.b   .L6
sub_408E3B12:
            eori.b  #$80,($1FA).w
.L1:
            st      ($2C7,A2)
            bra.b   sub_408E3A62.L6
            bsr.w   sub_408E456C
            btst    #5,(6,A3,D0.w)
            bne.b   .L1
            bra.b   sub_408E3B12
            move.b  ($2B8,A2),D1
            bra.b   sub_408E3A62.L6
            move.w  (2,A3),D1
            lea     (6,A3),A1
            bra.b   sub_408E3A62.L6
            bsr.w   sub_408E4540
            bra.b   sub_408E3A62.L6
            cmpi.b  #$7F,D1
            bne.b   .L3
            tst.w   (2,A3)
            bne.b   .L3
            move.l  D1,-(SP)
            bsr.w   sub_408E4540
            cmpi.b  #$7F,D1
            beq.b   .L2
            move.l  D1,($312,A3)
.L2:
            move.l  (SP)+,D1
.L3:
            bsr.w   sub_408E4558
            bra.b   sub_408E3A62.L6
            cmp.b   (1,A3),D4
            bcc.w   sub_408E3A62.L5
            tst.w   (2,A3)
            bne.b   .L4
            bsr.w   sub_408E4540
            cmpi.b  #$7F,D1
            beq.b   .L4
            move.l  D1,($312,A3)
.L4:
            bsr.w   sub_408E456C
            move.l  (8,A3,D0.w),D1
            bra.w   sub_408E3A62.L6
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  (4,A3),($18,A0)
            _Close
            move.w  (2,A3),($16,A0)
            moveq   #2,D0
            _HFSDispatch
            lea     ($32,SP),SP
            clr.w   (2,A3)
            bra.w   sub_408E3A62.L6
            st      ($1F6,A0)
            move.l  A0,-(SP)
            lea     .L5,A0
            move.l  #'atkv',D0
            _NewGestalt
            movea.l (SP)+,A0
            bra.w   sub_408E3A62.L6
.L5:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            cmpi.l  #'atkv',D0
            beq.b   .L6
            clr.l   (A0)
            move.w  #$EA51,($C,SP)
            bra.b   .L7
.L6:
            moveq   #0,D0
            move.l  RsrcDRVR_9.L1,(A0)
            clr.w   ($C,SP)
.L7:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
sub_408E3BF4:
            movem.l D1-D2/A0,-(SP)
            move.b  SPConfig,D2
            andi.b  #$F,D2
            cmpi.b  #1,D2
            bne.b   .L1
            bsr.w   sub_408E4540
            tst.l   D1
            bne.b   .L1
            moveq   #0,D0
.L1:
            movem.l (SP)+,D1-D2/A0
            rts
            cmp.b   ($1F6,A3),D1
            beq.w   sub_408E3A62.L6
            cmpi.b  #1,D1
            beq.b   .L2
            bsr.b   sub_408E3BF4
            beq.b   .L5
.L2:
            tst.b   ($1F6,A3)
            bpl.b   .L5
            move.b  PortBUse,D0
            bmi.b   .L3
            andi.b  #$F,D0
            cmpi.b  #1,D0
            bne.b   .L5
.L3:
            tst.b   D1
            bpl.b   .L4
            moveq   #-$32,D0
            bra.b   .L6
.L4:
            move.b  D1,($1F6,A3)
            tst.b   D0
            bpl.w   sub_408E3A62.L6
            move.b  D1,PortBUse
            bra.w   sub_408E3A62.L6
.L5:
            moveq   #-$61,D0
.L6:
            bra.w   sub_408E3A62.L7
            tst.b   ($1F6,A3)
            bmi.w   sub_408E3A62.L6
            cmp.b   ($1F6,A3),D1
            beq.b   .L7
            moveq   #-$61,D0
            bra.w   sub_408E3A62.L7
.L7:
            st      ($1F6,A3)
            move.b  PortBUse,D0
            andi.b  #$F,D0
            cmpi.b  #1,D0
            beq.w   sub_408E3A62.L6
            st      PortBUse
            bra.w   sub_408E3A62.L6
            bsr.w   sub_408E3BF4
            bne.b   .L8
            moveq   #1,D1
            bra.w   sub_408E3A62.L6
.L8:
            move.b  ($1F6,A3),D1
            bra.w   sub_408E3A62.L6
            movem.l A1,-(SP)
            movea.l ($1F2,A3),A0
            movea.l (A0),A0
            move.w  (A0)+,D0
            cmp.w   D0,D1
            bgt.w   .L12
            bset    #7,($274,A3)
            bne.w   .L12
            move.w  D1,-(SP)
            moveq   #0,D0
.L9:
            subq.w  #1,D1
            beq.b   .L10
            move.b  (A0)+,D0
            adda.l  D0,A0
            bra.b   .L9
.L10:
            movea.l A0,A1
            lea     ($254,A3),A0
            move.w  #8,(4,A0)
            move.l  A1,($18,A0)
            move.w  (SP)+,D1
            cmpi.w  #1,D1
            bne.b   .L11
            move.l  A0,-(SP)
            pea     (A1)
            movea.l A1,A0
            movea.l ($278,A3),A1
            pea     (A1)
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            movea.l ($2D8).w,A3
            lea     ($356,A3),A3
            move.b  (A3),D0
            add.b   D0,(A1)
            moveq   #1,D0
            add.b   (A0),D0
            adda.w  D0,A1
            move.b  (A3)+,D0
            movea.l A3,A0
            _BlockMove
            move.b  (-1,A3),D0
            adda.w  D0,A1
            movea.l (SP)+,A3
            movea.l (SP)+,A0
            move.b  (A0),D0
            lea     (1,A0,D0.w),A0
            move.b  (A0)+,D0
            add.b   D0,(A3)
            _BlockMove
            movea.l (SP)+,A0
            move.l  A3,($18,A0)
.L11:
            pea     sub_408E3D44
            move.l  (SP)+,($1C,A0)
            move.l  A5,-(SP)
            movea.l CurrentA5,A5
            _NMInstall
            movea.l (SP)+,A5
.L12:
            movem.l (SP)+,A1
            bra.w   sub_408E3A62.L6
sub_408E3D44:
            movea.l (4,SP),A0
            _NMRemove
            movea.l (4,SP),A0
            move.l  (SP)+,(SP)
            clr.l   ($20,A0)
            rts
            movem.l A1-A2,-(SP)
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($27C,A3),A1
            exg     D0,A0
            _StripAddress
            exg     D0,A0
            move.l  (2,A1),(A0)
            move.l  A0,(2,A1)
            tst.l   (A0)
            bne.b   .L1
            move.l  A0,(6,A1)
.L1:
            move    (SP)+,SR
            movem.l (SP)+,A1-A2
            bra.w   sub_408E3A62.L6
            move.l  A1,-(SP)
            lea     ($27C,A3),A1
            exg     D0,A0
            _StripAddress
            exg     D0,A0
            _Dequeue
            movea.l (SP)+,A1
            bra.w   sub_408E3A62.L6
            lea     ($27C,A3),A1
            bra.w   sub_408E3A62.L6
sub_408E3DA0:
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            move    SR,-(SP)
            move    #$2600,SR
            lea     ($27C,A1),A2
            movea.l (8,A6),A0
            tst.l   (A0)
            bne.b   .L2
.L1:
            move.l  (2,A2),D0
            beq.b   .L5
            movea.l D0,A2
            bra.b   .L6
.L2:
            lea     (2,A2),A2
            bra.b   .L4
.L3:
            movea.l D0,A2
            cmpa.l  (A0),A2
            beq.b   .L6
.L4:
            move.l  (A2),D0
            bne.b   .L3
            lea     ($27C,A1),A2
            bra.b   .L1
.L5:
            move    (SP)+,SR
            moveq   #0,D0
            bra.b   .L7
.L6:
            move.l  (A2),(A0)
            movea.l (6,A2),A0
            move    (SP)+,SR
            move.l  ($10,A6),-(SP)
            move.l  A2,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     (A0)
            lea     ($C,SP),SP
.L7:
            movea.l (SP)+,A2
            unlk    A6
            rts
            movem.l A0-A2,-(SP)
            bsr.w   sub_408E4580
            movem.l (SP)+,A0-A2
            bra.w   sub_408E3A62.L7
            lea     ($26,A3),A3
            moveq   #6,D0
.L8:
            tst.b   (A3)
            beq.b   .L9
            cmp.w   (2,A3),D2
            beq.b   .L11
.L9:
            lea     ($C,A3),A3
            subq.w  #1,D0
            bne.b   .L8
.L10:
            suba.w  #$C,A3
            addq.w  #1,D0
            tst.b   (A3)
            beq.b   .L11
            cmpi.w  #6,D0
            bcs.b   .L10
            bra.b   .L14
.L11:
            move.w  D2,(2,A3)
            moveq   #0,D2
.L12:
            cmp.l   (4,A3,D2.w),D1
            beq.b   .L14
            subq.w  #4,D2
            bpl.b   .L12
            moveq   #0,D2
.L13:
            tst.l   (4,A3,D2.w)
            beq.b   .L15
            subq.w  #4,D2
            bpl.b   .L13
.L14:
            bra.w   sub_408E3A62.L5
.L15:
            move.l  A0,(8,A3,D2.w)
            tst.b   (A3)
            bne.b   .L16
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  (2,A3),($18,A0)
            move.w  #$F7,($1A,A0)
            move.w  #$80F3,($1C,A0)
            pea     .L24
            asl.w   #2,D0
            sub.l   D0,(SP)
            move.l  (SP)+,($1E,A0)
            _Control
            lea     ($32,SP),SP
            bne.b   .L14
.L16:
            move.l  D1,(4,A3,D2.w)
            addq.b  #1,(A3)
            bra.w   sub_408E3A62.L6
            lea     ($26,A3),A3
            moveq   #6,D0
.L17:
            tst.b   (A3)
            beq.b   .L18
            cmp.w   (2,A3),D2
            beq.b   .L20
.L18:
            lea     ($C,A3),A3
            subq.w  #1,D0
            bne.b   .L17
.L19:
            bra.w   sub_408E3A62.L5
.L20:
            moveq   #0,D2
.L21:
            cmp.l   (4,A3,D2.w),D1
            beq.b   .L22
            subq.w  #4,D2
            bpl.b   .L21
            bra.b   .L19
.L22:
            clr.l   (4,A3,D2.w)
            subq.b  #1,(A3)
            bne.b   .L23
            move.l  A0,-(SP)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  (2,A3),($18,A0)
            move.w  #$F8,($1A,A0)
            move.w  #$80F3,($1C,A0)
            _Control
            lea     ($32,SP),SP
            movea.l (SP)+,A0
.L23:
            bra.w   sub_408E3A62.L6
            moveq   #0,D2
            bra.b   .L24
            moveq   #1,D2
            bra.b   .L24
            moveq   #2,D2
            bra.b   .L24
            moveq   #3,D2
            bra.b   .L24
            moveq   #4,D2
            bra.b   .L24
            moveq   #5,D2
            nop
.L24:
            mulu.w  #$C,D2
            subq.w  #4,SP
            movea.l SP,A3
            moveq   #4,D3
            jsr     (A4)
            bne.b   sub_408E3F40
            move.l  (SP)+,D0
            beq.b   .L26
            movea.l ExpandMem,A5
            movea.l ($74,A5),A5
            adda.l  D2,A5
            moveq   #0,D2
.L25:
            cmp.l   ($2A,A5,D2.w),D0
            beq.b   .L27
            subq.w  #4,D2
            bpl.b   .L25
.L26:
            moveq   #0,D3
            jmp     (2,A4)
.L27:
            movea.l ($2E,A5,D2.w),A5
            RTS5
sub_408E3F40:
            addq.w  #4,SP
            rts
            move.l  A2,-(SP)
            movea.l A3,A2
            cmpi.b  #1,(A1)
            bne.b   .L4
            move.b  (1,A1),D1
            btst    #0,D1
            bne.b   .L4
            addq.w  #2,A1
            lea     ($6E,A2),A3
            moveq   #5,D0
.L1:
            cmp.w   (A3),D2
            beq.b   .L6
            addq.w  #8,A3
            dbra    D0,.L1
            lea     ($6E,A2),A3
            moveq   #1,D0
.L2:
            tst.w   (A3)
            beq.b   .L3
            addq.w  #8,A3
            addq.w  #1,D0
            cmpi.w  #6,D0
            ble.b   .L2
            bra.b   .L4
.L3:
            move.w  D2,(A3)
            clr.w   (2,A3)
            clr.w   (4,A3)
            clr.w   (6,A3)
            move.l  A0,-(SP)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  D2,($18,A0)
            move.w  #$F7,($1A,A0)
            clr.w   ($1C,A0)
            pea     sub_408E4182.L5
            asl.w   #2,D0
            sub.l   D0,(SP)
            move.l  (SP)+,($1E,A0)
            _Control
            lea     ($32,SP),SP
            movea.l (SP)+,A0
            beq.b   .L5
.L4:
            movea.l (SP)+,A2
            moveq   #-2,D0
            bra.w   sub_408E3A62.L7
.L5:
            movem.l D1/A0,-(SP)
            lea     sub_408E439A,A0
            move.b  #$AA,D1
            bsr.b   sub_408E4014
            movem.l (SP)+,D1/A0
            bmi.b   .L4
.L6:
            cmpi.b  #$AA,D1
            beq.b   .L7
            bsr.b   sub_408E4014
            bmi.b   .L4
            tst.b   (A1)
            bne.b   .L4
            bra.b   .L9
.L7:
            cmpi.b  #5,(A1)
            bne.b   .L4
            cmpi.b  #4,(6,A1)
            beq.b   .L8
            bsr.b   sub_408E403E
            bmi.b   .L4
            bra.b   .L9
.L8:
            move.l  A0,-(SP)
            lea     sub_408E43E4,A0
            bsr.b   sub_408E403E
            movea.l (SP)+,A0
            bmi.b   .L4
            tst.b   (A1)
            beq.b   .L9
            bsr.b   sub_408E4076
            bmi.b   .L4
.L9:
            movea.l (SP)+,A2
            bra.w   sub_408E3A62.L6
sub_408E4014:
            move.l  A1,-(SP)
            lea     ($9E,A2),A1
            moveq   #7,D0
.L1:
            tst.w   (4,A1)
            beq.b   .L2
            addq.w  #8,A1
            dbra    D0,.L1
            bra.b   .L3
.L2:
            move.l  A0,(A1)
            move.w  D2,(4,A1)
            move.b  D1,(6,A1)
            addq.b  #1,(2,A3)
.L3:
            tst.w   D0
            movea.l (SP)+,A1
            rts
sub_408E403E:
            move.l  A2,-(SP)
            lea     ($DE,A2),A2
            moveq   #$F,D0
.L1:
            tst.w   (4,A2)
            beq.b   .L2
            lea     ($C,A2),A2
            dbra    D0,.L1
            bra.b   .L4
.L2:
            move.l  A0,(A2)
            move.w  D2,(4,A2)
            lea     (6,A2),A2
            move.b  (A1)+,D0
            subq.w  #1,D0
.L3:
            move.b  (A1)+,(A2)+
            dbra    D0,.L3
            addq.b  #1,(4,A3)
            addq.w  #1,D0
.L4:
            tst.w   D0
            movea.l (SP)+,A2
            rts
sub_408E4076:
            move.l  A2,-(SP)
            lea     ($19E,A2),A2
            moveq   #7,D0
.L1:
            tst.w   (4,A2)
            beq.b   .L2
            lea     ($A,A2),A2
            dbra    D0,.L1
            bra.b   .L4
.L2:
            move.l  A0,(A2)
            move.w  D2,(4,A2)
            lea     (6,A2),A2
            move.b  (A1)+,D0
            subq.w  #1,D0
.L3:
            move.b  (A1)+,(A2)+
            dbra    D0,.L3
            addq.b  #1,(6,A3)
            addq.w  #1,D0
.L4:
            tst.w   D0
            movea.l (SP)+,A2
            rts
            move.l  A2,-(SP)
            movea.l A3,A2
            lea     ($6E,A2),A3
            moveq   #5,D0
.L5:
            cmp.w   (A3),D2
            beq.b   .L7
            addq.w  #8,A3
            dbra    D0,.L5
.L6:
            movea.l (SP)+,A2
            moveq   #-3,D0
            bra.w   sub_408E3A62.L7
.L7:
            moveq   #0,D0
            moveq   #0,D1
.L8:
            move.b  (A1),D1
            beq.b   .L9
            move.l  A1,-(SP)
            addq.w  #1,D1
            adda.w  D1,A1
            addq.w  #1,D0
            cmpi.w  #3,D0
            blt.b   .L8
.L9:
            cmpi.w  #3,D0
            beq.b   .L10
            cmpi.w  #2,D0
            beq.b   .L11
            cmpi.w  #1,D0
            beq.b   .L12
            cmpi.w  #0,D0
            beq.b   .L6
.L10:
            movea.l (SP)+,A1
            movem.l A2-A3,-(SP)
            lea     ($19E,A2),A2
            lea     (6,A3),A3
            moveq   #7,D0
            moveq   #$A,D3
            bsr.b   sub_408E4182
            movem.l (SP)+,A2-A3
            tst.b   (6,A3)
            beq.b   .L11
            addq.w  #8,SP
            bra.b   .L14
.L11:
            movea.l (SP)+,A1
            movem.l A2-A3,-(SP)
            lea     ($DE,A2),A2
            lea     (4,A3),A3
            moveq   #$F,D0
            moveq   #$C,D3
            bsr.b   sub_408E4182
            movem.l (SP)+,A2-A3
            tst.b   (4,A3)
            beq.b   .L12
            addq.w  #4,SP
            bra.b   .L14
.L12:
            movea.l (SP)+,A1
            movem.l A2-A3,-(SP)
            lea     ($9E,A2),A2
            lea     (2,A3),A3
            moveq   #7,D0
            moveq   #8,D3
            bsr.b   sub_408E4182
            movem.l (SP)+,A2-A3
            tst.b   (2,A3)
            beq.b   .L13
            bra.b   .L14
.L13:
            clr.w   (A3)
            move.l  A0,-(SP)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  D2,($18,A0)
            move.w  #$F8,($1A,A0)
            clr.w   ($1C,A0)
            _Control
            lea     ($32,SP),SP
            movea.l (SP)+,A0
.L14:
            movea.l (SP)+,A2
            bra.w   sub_408E3A62.L6
sub_408E4182:
            cmp.w   (4,A2),D2
            beq.b   .L2
.L1:
            adda.w  D3,A2
            dbra    D0,sub_408E4182
            bra.b   .L4
.L2:
            movem.l D0/A1-A2,-(SP)
            lea     (6,A2),A2
            move.b  (A1)+,D0
            subq.w  #1,D0
.L3:
            cmpm.b  (A1)+,(A2)+
            dbne    D0,.L3
            movem.l (SP)+,D0/A1-A2
            bne.b   .L1
            clr.w   (4,A2)
            clr.l   (A2)
            subq.b  #1,(A3)
            addq.w  #1,D0
.L4:
            tst.w   D0
            rts
            moveq   #5,D2
            bra.b   .L5
            moveq   #4,D2
            bra.b   .L5
            moveq   #3,D2
            bra.b   .L5
            moveq   #2,D2
            bra.b   .L5
            moveq   #1,D2
            bra.b   .L5
            moveq   #0,D2
            nop
.L5:
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            moveq   #$E,D0
            suba.w  D0,A3
            lea     ($1FE,A2),A5
            moveq   #6,D0
.L6:
            move.w  (A3)+,(A5)+
            dbra    D0,.L6
            movea.l A5,A3
            move.w  (-2,A3),D0
            cmp.w   D1,D0
            bge.b   .L7
            move.w  D0,D1
.L7:
            lea     ($6E,A2),A5
            mulu.w  #8,D2
            adda.w  D2,A5
            move.w  (A5),D2
            moveq   #3,D3
            jsr     (A4)
            beq.b   .L8
            rts
.L8:
            move.b  (-1,A3),D0
            btst    #0,(-2,A3)
            bne.b   .L9
            cmpi.b  #3,D0
            beq.b   .L10
            bra.b   .L14
.L9:
            bclr    #4,D0
            cmpi.b  #$E3,D0
            beq.b   .L10
            cmpi.b  #$AF,D0
            bne.b   .L13
.L10:
            lea     ($9E,A2),A5
            lea     ($DE,A2),A2
            move.b  (-3,A3),D0
            moveq   #8,D3
.L11:
            cmp.w   (4,A5),D2
            bne.b   .L12
            cmp.b   (6,A5),D0
            bne.b   .L12
            tst.l   (A5)
            beq.b   .L13
            movea.l (A5),A5
            RTS5
.L12:
            adda.l  D3,A5
            cmpa.l  A2,A5
            blt.b   .L11
.L13:
            bra.w   sub_408E4320
.L14:
            bclr    #4,D0
            cmpi.b  #$E3,D0
            beq.b   .L15
            cmpi.b  #$AF,D0
            bne.b   .L13
.L15:
            tst.w   ($22E,A2)
            bne.b   .L13
            lea     sub_408E4352,A3
            move.l  A3,($220,A2)
            move.b  ($20C,A2),D3
            beq.b   .L17
            btst    #0,D3
            beq.b   .L16
            cmpi.b  #$FF,D3
            bne.b   .L13
            lea     sub_408E4326,A3
            move.l  A3,($220,A2)
.L16:
            bsr.w   sub_408E4358
            tst.w   D3
            beq.b   .L13
.L17:
            lea     ($204,A2),A5
            lea     ($1F8,A2),A3
            move.l  A3,($248,A2)
            move.w  #$11,($246,A2)
            move.l  (A5)+,(A3)+
            move.w  (A5)+,(A3)+
            lea     ($20A,A2),A5
            lea     ($204,A2),A3
            move.w  (A5)+,(A3)+
            move.b  (1,A5),(A3)+
            bset    #0,D3
            move.b  D3,(A3)+
            move.b  (2,A5),D0
            move.b  D0,(A3)+
            bclr    #4,D0
            cmpi.b  #$E3,D0
            bne.b   .L19
            move.w  D1,D3
            cmpi.w  #$A,D1
            ble.b   .L18
            move.w  #3,($204,A2)
            moveq   #0,D3
.L18:
            add.w   D3,($246,A2)
            jsr     (2,A4)
            bra.b   .L20
.L19:
            cmpi.b  #$AF,D0
            bne.b   sub_408E4320
            move.w  #6,($204,A2)
            addq.w  #3,($246,A2)
            move.b  #$81,(A3)+
            move.b  #1,(A3)+
            clr.b   (A3)+
            bsr.b   sub_408E4320
.L20:
            lea     ($214,A2),A0
            lea     ($246,A2),A1
            move.w  D2,($18,A0)
            move.w  #$F9,($1A,A0)
            move.l  A1,($1E,A0)
            _Control async
            rts
sub_408E4320:
            moveq   #0,D3
            jmp     (2,A4)
sub_408E4326:
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            move.b  #$FF,D3
            move.w  ($252,A2),D2
            moveq   #8,D0
            movea.l ($24E,A2),A3
            lea     ($DE,A2),A2
            bsr.b   sub_408E4364
            tst.b   D3
            beq.b   sub_408E4352
            bset    #0,D3
            move.b  D3,($207,A2)
            _Control async
            rts
sub_408E4352:
            clr.w   ($1A,A0)
            rts
sub_408E4358:
            lea     ($9E,A2),A3
            lea     ($DE,A2),A2
            moveq   #8,D0
            suba.w  D0,A3
sub_408E4364:
            adda.w  D0,A3
            cmpa.l  A2,A3
            bge.b   .L2
            cmp.w   (4,A3),D2
            bne.b   sub_408E4364
            tst.l   (A3)
            beq.b   sub_408E4364
            cmpi.b  #$FF,D3
            beq.b   .L1
            cmp.b   (6,A3),D3
            bne.b   sub_408E4364
.L1:
            move.b  (6,A3),D3
            bne.b   .L3
.L2:
            clr.b   D3
.L3:
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            move.l  A3,($24E,A2)
            move.w  D2,($252,A2)
.L4:
            rts
sub_408E439A:
            moveq   #5,D3
            jsr     (A4)
            bne.b   sub_408E4364.L4
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            lea     ($DE,A2),A5
            lea     ($19E,A2),A2
            move.l  (-6,A3),D0
            lsl.l   #8,D0
            move.b  (-2,A3),D0
            move.b  (-1,A3),D3
.L1:
            cmp.w   (4,A5),D2
            bne.b   .L2
            cmp.l   (6,A5),D0
            bne.b   .L2
            cmp.b   ($A,A5),D3
            bne.b   .L2
            tst.l   (A5)
            beq.b   .L3
            movea.l (A5),A5
            RTS5
.L2:
            lea     ($C,A5),A5
            cmpa.l  A2,A5
            blt.b   .L1
.L3:
            bra.w   sub_408E4320
sub_408E43E4:
            subq.w  #4,SP
            movea.l SP,A3
            move.w  #4,D3
            jsr     (A4)
            movem.l (SP)+,D0
            bne.b   sub_408E4364.L4
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            lea     ($19E,A2),A5
            lea     ($1EE,A2),A2
.L1:
            cmp.w   (4,A5),D2
            bne.b   sub_408E4418
            cmp.l   (6,A5),D0
            bne.b   sub_408E4418
            tst.l   (A5)
            beq.b   sub_408E4418.L1
            movea.l (A5),A5
            RTS5
sub_408E4418:
            lea     ($A,A5),A5
            cmpa.l  A2,A5
            blt.b   sub_408E43E4.L1
.L1:
            bra.w   sub_408E4320
.L2:
            tst.w   ($3B8,A2)
            beq.b   sub_408E4460
            bsr.w   sub_408E2B44
            movem.l D0/D4/A3,-(SP)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            move.b  ($334,A2),D4
            bsr.w   sub_408E456C
            btst    #4,(6,A3,D0.w)
            movem.l (SP)+,D0/D4/A3
            beq.b   sub_408E4460
            lea     .L3,A5
            addq.w  #4,SP
            bra.w   sub_408E52E8.L4
.L3:
            bsr.w   sub_408E2B44
            bsr.b   sub_408E4460
            rts
sub_408E4460:
            tst.w   ($340,A2)
            bpl.b   .L4
            btst    #$1E,($33E,A2)
            beq.b   .L1
            moveq   #0,D3
.L1:
            addq.w  #4,SP
            sub.l   D0,D0
            move.w  ($1A,A2),D0
            lsl.l   #8,D0
            move.b  (A2),D0
            move.l  D0,-(SP)
            sub.l   D0,D0
            move.w  (8,A2),D0
            lsl.l   #8,D0
            move.b  ($C,A2),D0
            cmp.l   (SP)+,D0
            beq.w   sub_408E10AE.L2
            cmpi.b  #$FF,D0
            bne.b   .L2
            tst.w   ($458,A2)
            beq.w   sub_408E10AE.L2
            lea     sub_408E10AE.L2,A5
            bsr.w   sub_408E52E8
            cmpa.w  #0,A3
            beq.b   .L3
            movea.l A3,A0
            bsr.w   sub_408E5288
            move.w  #$80,($E,A0)
            pea     .L6
            move.l  (SP)+,(4,A0)
            bsr.w   sub_408E5288
            bsr.w   sub_408E52C4
            bra.b   .L3
.L2:
            lsr.l   #8,D0
            cmp.w   ($344,A2),D0
            bcs.w   sub_408E10AE.L2
            cmp.w   ($346,A2),D0
            bhi.w   sub_408E10AE.L2
            bsr.b   sub_408E451E
.L3:
            rts
.L4:
            move.b  (1,A2),D0
            cmp.b   (A2),D0
            beq.b   sub_408E4522
            cmpi.b  #$FF,D0
            bne.b   sub_408E451E
            tst.w   ($458,A2)
            beq.b   sub_408E4522
            lea     .L6,A5
            bsr.w   sub_408E52E8
            cmpa.w  #0,A3
            beq.b   .L5
            movea.l A3,A0
            bsr.w   sub_408E5288
            move.w  #$80,($E,A0)
            bsr.w   sub_408E5288
            bsr.w   sub_408E52C4
.L5:
            addq.w  #4,SP
            bra.b   sub_408E4522.L3
.L6:
            bsr.b   sub_408E4522
            rts
sub_408E451E:
            move.b  #$80,D2
sub_408E4522:
            moveq   #0,D0
            move.b  ($22,A2),D0
            move.w  D0,D3
            bra.b   .L2
.L1:
            cmp.b   ($24,A2,D0.w),D2
.L2:
            dbeq    D0,.L1
            bne.b   .L3
            lsl.w   #2,D0
            add.w   D3,D0
            move.l  ($24,A2,D0.w),(SP)
.L3:
            rts
sub_408E4540:
            clr.l   -(SP)
            btst    #$E,HWCfgFlags
            beq.b   .L1
            movea.l SP,A0
            move.l  #$400E0,D0
            _ReadXPRam
.L1:
            move.l  (SP)+,D1
            rts
sub_408E4558:
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            movea.l SP,A0
            move.l  #$400E0,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l (SP)+,A0
            rts
sub_408E456C:
            moveq   #0,D0
            cmp.b   (1,A3),D4
            bcc.b   .L1
            move.b  D4,D0
.L1:
            mulu.w  #$10,D0
            addi.w  #$30A,D0
            rts
sub_408E4580:
            move.w  ResLoad,-(SP)
            clr.w   ResLoad
            movem.l D1/A1,-(SP)
            subq.w  #2,SP
            move.l  #'extn',-(SP)
            bsr.w   sub_408E5380
            move.w  (SP)+,D0
            movem.l (SP)+,D1/A1
            move.w  D0,-(SP)
            suba.w  #$7A,SP
            movea.l SP,A2
            move.w  D0,($16,A2)
            move.l  A1,($12,A2)
            clr.w   ($1C,A2)
            tst.b   D1
            bne.b   .L1
            move.w  D3,($1C,A2)
.L1:
            movea.l A2,A0
            clr.w   ($1A,A0)
            addq.w  #1,($1C,A0)
            _GetFileInfo
            bne.b   .L3
            move.l  ($20,A0),D0
            cmpi.l  #'adev',D0
            bne.b   .L1
            clr.w   -(SP)
            move.l  A1,-(SP)
            move.w  ($16,A0),-(SP)
            clr.b   -(SP)
            _OpenRFPerm
            move.w  (SP)+,D2
            move.w  ResErr,D0
            bne.b   .L1
            tst.b   D1
            beq.b   .L2
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D1,-(SP)
            clr.b   (SP)
            _Get1Resource
            moveq   #0,D0
            tst.l   (SP)+
            bne.b   .L3
            move.w  D2,-(SP)
            _CloseResFile
            bra.b   .L1
.L2:
            move.w  ($1C,A2),D3
.L3:
            lea     ($7A,SP),SP
            movem.l D0-D2,-(SP)
            subq.w  #2,SP
            move.w  ($E,SP),-(SP)
            bsr.w   sub_408E53F4
            move.w  (SP)+,D0
            movem.l (SP)+,D0-D2
            addq.w  #2,SP
            move.w  (SP)+,ResLoad
            rts
sub_408E462A:
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            cmpi.w  #$F6,($1A,A0)
            beq.b   .L1
            movea.l ($286,A2),A2
            jmp     (A2)
.L1:
            lea     ($28A,A2),A2
            move.w  ($1C,A0),D3
            bmi.b   .L2
            cmpi.w  #$1F,D3
            ble.b   .L3
.L2:
            moveq   #-$11,D0
            addq.w  #8,SP
            movea.l JIODone,A2
            jmp     (A2)
.L3:
            tst.l   (A2)
            bne.b   .L4
            move.l  A0,-(SP)
            lea     sub_408E46BA,A0
            move.l  A0,(A2)
            move.l  A0,(4,A2)
            movea.l (SP)+,A0
.L4:
            lsl.w   #2,D3
            move.l  (0,A2,D3.w),D3
            beq.b   .L2
            movea.l D3,A2
            move    SR,-(SP)
            move    #$2600,SR
            bclr    #7,(5,A1)
            move.l  (A0),(8,A1)
            bne.b   .L5
            clr.l   ($C,A1)
.L5:
            clr.l   (A0)
            move.l  (8,A1),D0
            beq.b   .L6
            bset    #7,(5,A1)
            move    (SP)+,SR
            movem.l D1-D3/A0/A2-A3,-(SP)
            movea.l D0,A0
            moveq   #0,D0
            movea.l (A1),A2
            move.w  ($C,A2),D1
            jsr     (0,A2,D1.w)
            movem.l (SP)+,D1-D3/A0/A2-A3
            bra.b   .L7
.L6:
            move    (SP)+,SR
.L7:
            addq.w  #8,SP
            jmp     (A2)
sub_408E46BA:
            move.w  ($1E,A0),D3
            cmpi.w  #5,D3
            bcs.b   .L2
            cmpi.w  #$1F,D3
            bhi.b   .L2
            movea.l ExpandMem,A2
            movea.l ($74,A2),A2
            lea     ($28A,A2),A2
            lsl.w   #2,D3
            cmpi.w  #0,($1C,A0)
            beq.b   .L1
            clr.l   (0,A2,D3.w)
            bra.b   .L4
.L1:
            move.l  (0,A2,D3.w),D0
            bne.b   .L2
            move.l  ($20,A0),D0
            bne.b   .L3
.L2:
            moveq   #-1,D0
            bra.b   .L5
.L3:
            move.l  D0,(0,A2,D3.w)
.L4:
            moveq   #0,D0
.L5:
            move.w  D0,($10,A0)
            move.l  ($C,A0),D1
            beq.b   .L6
            movea.l D1,A1
            tst.w   D0
            jsr     (A1)
.L6:
            rts
sub_408E470E:
            movea.l ($2D8).w,A2
            moveq   #-$5D,D0
            tst.b   ($19,A2)
            beq.b   sub_408E46BA.L5
            lea     ($32,A0),A1
            tst.w   ($2A,A0)
            bne.b   .L1
            move.w  ($1C,A0),D0
            move.l  ($33A,A2),D1
            lsl.l   #8,D1
            move.b  #6,D1
            move.l  D1,($1E,A1)
            move.w  #$700,($12,A1)
            cmpi.w  #7,D0
            beq.b   .L1
            addq.w  #1,($2A,A0)
            move.w  #$900,($12,A1)
            cmpi.w  #5,D0
            beq.b   .L1
            move.w  #$800,($12,A1)
.L1:
            move.w  ($2A,A0),($14,A1)
            clr.b   ($1D,A1)
            clr.w   ($22,A1)
            lea     ($64,A0),A2
            move.w  #$242,(A2)
            move.l  ($22,A0),(2,A2)
            move.l  A2,($28,A1)
            move.b  #1,($2C,A1)
            move.b  ($1E,A0),($2D,A1)
            move.b  ($1F,A0),($2F,A1)
            movea.l A1,A0
            lea     sub_408E47A6,A3
            move.l  A3,($C,A0)
            move.w  #$FFF5,($18,A0)
            move.w  #$FF,($1A,A0)
            _Control async
            moveq   #0,D0
            rts
sub_408E47A6:
            lea     (-$32,A0),A1
            bne.b   .L1
            movea.l ($28,A0),A2
            move.b  (8,A2),($28,A1)
            move.w  ($A,A2),D0
            move.w  D0,($26,A1)
            add.w   D0,($2A,A1)
            moveq   #0,D0
.L1:
            movea.l A1,A0
            bra.w   sub_408E46BA.L5
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF,$A9FF
            dc.w    $A9FF
.L2:
            dc.w    $5323,$6706,$4243,$4EEC,$0002,$47EA,$0002,$7604
            dc.w    $4E94,$6670,$3601,$660A,$4EAC,$0002,$6666,$7601
            dc.w    $6024,$363C,$0006,$B243,$6316,$4E94,$6656,$202A
            dc.w    $0410,$670A,$2A40,$7002,$4E95,$670A,$6046,$7600
            dc.w    $4EAC,$0002,$663E,$47EA,$0002,$142B,$0003,$6734
            dc.w    $0C2B,$0008,$0002,$662C,$4842,$3413,$6726,$4A6A
            dc.w    $0340,$6B22,$3542,$001A,$3542,$0344,$3542,$0346
            dc.w    $4842,$1542,$0019
.L3:
            asl.w   #8,D2
            ror.l   #8,D2
            move.l  D2,($33A,A2)
            move.b  #$96,($2D0,A2)
.L4:
            rts
            tst.w   D3
            bgt.b   .L4
            cmpi.w  #$FF00,($1A,A2)
            bcc.b   .L8
            move.b  (7,A3),D0
            lsl.w   #8,D0
            move.b  (8,A3),D0
            tst.w   D0
            beq.b   .L4
            cmpi.w  #$FF00,D0
            bcc.b   .L4
            tst.w   (4,A3)
            beq.b   .L4
            cmp.w   (4,A3),D0
            bcs.b   .L4
            cmp.w   D0,D2
            bhi.b   .L4
            cmp.w   (4,A3),D2
            bcs.b   .L4
            move.w  ($344,A2),D1
            beq.b   .L5
            cmp.w   (4,A3),D1
            bne.b   .L4
            cmp.w   ($346,A2),D0
            bne.b   .L4
            tst.b   ($352,A2)
            beq.b   .L6
            bra.b   .L7
.L5:
            move.w  ($1A,A2),D1
            cmp.w   (4,A3),D1
            bcs.b   .L9
            cmp.w   D0,D1
            bhi.b   .L9
            move.w  (4,A3),($344,A2)
            move.w  D0,($346,A2)
.L6:
            move    ($1C,A2),SR
            bsr.b   sub_408E503E
.L7:
            move.b  #$FE,($19,A2)
            swap    D2
            bra.w   .L3
.L8:
            bset    #4,($341,A2)
            bra.b   .L10
.L9:
            bset    #5,($341,A2)
.L10:
            bsr.b   sub_408E508E
            rts
sub_408E503E:
            movea.l ($2D8).w,A2
            btst    #$B,($340,A2)
            beq.b   .L2
            move.l  ($3A6,A2),D0
            beq.b   .L2
            movea.l D0,A0
            move    SR,-(SP)
            move    #$2600,SR
            tst.w   (A0)
            beq.b   .L1
            move    (SP)+,SR
            bra.b   .L2
.L1:
            move.w  #$101,(A0)
            move    (SP)+,SR
            suba.w  #$1A,A0
            lea     sub_408E5088,A1
            move.l  A1,($C,A0)
            lea     ($356,A2),A1
            move.l  A1,($1E,A0)
            movea.l ($330,A2),A1
            move.w  ($18,A1),($18,A0)
            _Control async
.L2:
            rts
sub_408E5088:
            clr.w   ($1A,A0)
            rts
sub_408E508E:
            cmpi.w  #$600,($3AA,A2)
            bcs.b   .L5
            move.l  ($33E,A2),D0
            btst    #$B,D0
            beq.b   .L1
            btst    #4,D0
            bne.b   .L3
            btst    #5,D0
            bne.b   .L3
.L1:
            btst    #7,D0
            beq.b   .L5
            btst    #6,D0
            bne.b   .L5
            btst    #$1D,D0
            beq.b   .L2
            btst    #$B,D0
            beq.b   .L5
.L2:
            moveq   #1,D1
            bsr.b   sub_408E50E4
            bra.b   .L5
.L3:
            btst    #$1C,D0
            bne.b   .L5
            moveq   #3,D1
            btst    #4,D0
            bne.b   .L4
            moveq   #4,D1
.L4:
            bsr.b   sub_408E50E4
            bset    #$1C,($33E,A2)
.L5:
            rts
sub_408E50E4:
            move.l  ($33E,A2),D0
            btst    #$D,D0
            bne.b   .L1
            rts
.L1:
            movea.l LAPMgrPtr,A0
            moveq   #$14,D0
            jmp     (2,A0)
sub_408E50FA:
            move.w  #$14,($A,A0)
            movea.l ($2D8).w,A2
            tst.b   ($2D0,A2)
            beq.b   .L3
            subq.b  #1,($2D0,A2)
            bne.b   .L3
            move.l  ($410,A2),D0
            beq.b   .L1
            movea.l D0,A1
            moveq   #5,D0
            jsr     (A1)
            bne.b   .L2
.L1:
            moveq   #0,D0
            move.b  D0,($19,A2)
            move.l  D0,($33A,A2)
.L2:
            moveq   #0,D0
            move.l  D0,($344,A2)
            subq.w  #2,($346,A2)
            tst.w   ($340,A2)
            bpl.b   .L3
            clr.b   ($352,A2)
            moveq   #6,D0
            lea     ($34C,A2),A1
            movea.l ($378,A2),A0
            jsr     (2,A0)
            bclr    #$1C,($33E,A2)
.L3:
            rts
sub_408E5152:
            movem.l D0/A0-A1,-(SP)
            move.w  #9,D1
.L1:
            move.l  #$271,D0
            _NewPtrSysClear
            bne.b   sub_408E51C6.L2
            move.l  ($3B0,A2),(A0)
            move.l  A0,($3B0,A2)
            dbra    D1,.L1
            move.w  #$A89F,D0
            _GetTrapAddress
            move.l  A0,D0
            _StripAddress
            move.l  D0,D1
            move.w  #$A1AD,D0
            _GetOSTrapAddress
            move.l  A0,D0
            _StripAddress
            cmp.l   D0,D1
            beq.b   .L2
            move.l  #$766D2020,D0
            _Gestalt
            bne.b   .L2
            move.l  A0,D0
            beq.b   .L2
            move.w  #1,($3B8,A2)
            move.l  #$263,D0
            _NewPtrSysClear
            bne.b   sub_408E51C6.L1
            move.l  A0,($3B4,A2)
            move.w  #$24,D0
            bsr.b   sub_408E51EA
            move.w  #$28,D0
            bsr.b   sub_408E51EA
            move.w  #$A0,D0
            bsr.b   sub_408E51EA
.L2:
            movem.l (SP)+,D0/A0-A1
            moveq   #0,D0
            rts
sub_408E51C6:
            movem.l D0/A0-A1,-(SP)
.L1:
            move.l  ($3B4,A2),D0
            beq.b   .L2
            movea.l D0,A0
            _DisposPtr
.L2:
            lea     ($3B0,A2),A1
            move.l  (A1),D0
            beq.b   .L3
            movea.l D0,A0
            move.l  (A0),(A1)
            _DisposPtr
            bra.b   .L2
.L3:
            movem.l (SP)+,D0/A0-A1
            rts
sub_408E51EA:
            movea.l UTableBase,A0
            move.l  (0,A0,D0.w),D0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            bset    #0,(5,A0)
.L1:
            rts
sub_408E5200:
            movem.l D0/D3/A0/A2,-(SP)
            movea.l ($3B4,A2),A0
            lea     (8,A0),A0
            moveq   #0,D0
.L1:
            move.w  (A1)+,D3
            beq.b   .L3
            add.w   D3,D0
            cmpi.w  #$25B,D0
            bhi.b   .L4
            movea.l (A1)+,A2
            subq.w  #1,D3
.L2:
            move.b  (A2)+,(A0)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            movea.l ($2D8).w,A1
            movea.l ($3B4,A1),A1
            move.w  D0,(A1)
            move.l  A1,(2,A1)
            addq.l  #8,(2,A1)
            movem.l (SP)+,D0/D3/A0/A2
            clr.w   (6,A1)
            rts
.L4:
            movem.l (SP)+,D0/D3/A0/A2
            moveq   #-$5F,D0
            rts
.L5:
            bra.b   .L7
            cmp.w   D3,D1
            ble.b   .L8
            move.w  D3,-(SP)
            sub.w   D1,D3
            move.w  (SP)+,D1
            bra.b   .L9
.L8:
            sub.w   D1,D3
.L9:
            moveq   #0,D0
            move.w  D1,D0
            movea.l A3,A1
            _BlockMove
            adda.w  D1,A0
            adda.w  D1,A3
            moveq   #0,D0
            rts
.L7:
            cmp.w   D3,D1
            bge.b   .L6
            sub.w   D1,D3
            moveq   #-4,D0
            rts
.L6:
            sub.w   D3,D1
            moveq   #0,D0
            move.w  D3,D0
            movea.l A3,A1
            _BlockMove
            adda.w  D3,A0
            adda.w  D3,A3
            moveq   #0,D3
            moveq   #0,D0
            rts
sub_408E5288:
            movem.l A0/A4-A5,-(SP)
            movea.l A0,A1
            lea     ($16,A1),A0
            move.w  ($14,A1),D1
            movea.l (8,A1),A2
            lea     (1,A2),A3
            move    #$2600,SR
            move.w  ($C,A1),D0
.L1:
            move.b  (A0)+,(A3)+
            dbra    D0,.L1
            move.w  ($E,A1),D2
            move.l  ($10,A1),D3
            lea     sub_408E5200.L5,A4
            movea.l (4,A1),A5
            jsr     (A5)
            movem.l (SP)+,A0/A4-A5
            rts
sub_408E52C4:
            move    SR,-(SP)
            clr.w   ($14,A0)
            movea.l ($2D8).w,A2
            move    #$2600,SR
            move.l  ($3B0,A2),(A0)
            move.l  A0,($3B0,A2)
            move    (SP)+,SR
            rts
sub_408E52DE:
            bsr.w   sub_408E5288
            bsr.w   sub_408E52C4
            rts
sub_408E52E8:
            move.l  A5,-(SP)
            lea     (1,A2),A5
            move.l  A3,D0
            sub.l   A5,D0
            movem.l D0-D3,-(SP)
            cmpi.w  #5,D0
            blt.b   .L3
            move.l  ($3B0,A2),D3
            beq.b   .L3
            movea.l D3,A5
            lea     ($16,A5,D0.w),A3
            neg.w   D0
            addi.w  #$25B,D0
            cmp.w   D0,D1
            bhi.b   .L3
            move.w  D1,D3
            jsr     (2,A4)
            movea.w D3,A1
            movem.l (SP)+,D0-D3
            movem.l (SP)+,A0
            bne.b   .L2
            move.w  A1,-(SP)
            movea.l ($3B0,A2),A3
            move.l  D3,($10,A3)
            move.w  D2,($E,A3)
            move.w  D1,($14,A3)
            subq.w  #1,D0
            move.w  D0,($C,A3)
            move.l  A0,(4,A3)
            move.l  A2,(8,A3)
            tst.w   (SP)+
            bne.b   .L2
            move.l  (A3),($3B0,A2)
            lea     ($16,A3),A0
            lea     (1,A2),A1
.L1:
            move.b  (A1)+,(A0)+
            dbra    D0,.L1
            rts
.L2:
            suba.l  A3,A3
            rts
.L3:
            lea     ($14,SP),SP
            moveq   #0,D3
            jsr     (2,A4)
            bra.b   .L2
.L4:
            bsr.w   sub_408E52E8
            cmpa.w  #0,A3
            beq.b   .L5
            move.l  A3,D0
            lea     sub_408E52DE,A0
            _DeferUserFn
.L5:
            rts
sub_408E5380:
            link.w  A6,#-$4A
            lea     (-$44,A6),A0
            move.w  #1,D0
            _SysEnvirons
            move.w  (-$40,A6),D1
            cmpi.w  #$700,D1
            bcs.b   .L1
            subq.w  #2,SP
            move.w  #$8000,-(SP)
            move.l  (8,A6),-(SP)
            move.w  #1,-(SP)
            pea     (-$46,A6)
            pea     (-$4A,A6)
            moveq   #0,D0
            _AliasDispatch
            move.w  (SP)+,D0
            moveq   #0,D0
            bne.b   .L2
            lea     (-$34,A6),A0
            move.w  (-$46,A6),($16,A0)
            move.l  (-$4A,A6),($30,A0)
            clr.l   ($12,A0)
            move.l  #'atlk',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            move.w  ($10,A0),D0
            moveq   #0,D0
            bne.b   .L2
            move.w  ($16,A0),D0
            bra.b   .L2
.L1:
            move.w  (-$36,A6),D0
.L2:
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #4,SP
            move.w  D0,(SP)
            jmp     (A0)
sub_408E53F4:
            link.w  A6,#-$44
            moveq   #0,D0
            lea     (-$44,A6),A0
            move.w  #1,D0
            _SysEnvirons
            move.w  (8,A6),D1
            cmp.w   (-$36,A6),D1
            beq.b   .L1
            lea     (-$34,A6),A0
            move.w  D1,($16,A0)
            moveq   #2,D0
            _HFSDispatch
            move.w  ($10,A0),D0
.L1:
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #2,SP
            move.w  D0,(SP)
            jmp     (A0)
sub_408E5428:
            link.w  A6,#0
            move.l  D3,-(SP)
            move    SR,D1
            ori     #$2600,SR
            movea.l LAPMgrPtr,A1
            moveq   #$19,D0
            jsr     (2,A1)
            moveq   #0,D3
            move.l  (2,A1),D0
.L1:
            beq.b   .L2
            move.l  D0,-(SP)
            addq.w  #1,D3
            movea.l D0,A1
            move.l  (A1),D0
            bra.b   .L1
.L2:
            move    D1,SR
            tst.l   D3
            beq.b   .L4
            subq.w  #1,D3
.L3:
            movea.l (SP)+,A1
            move.l  (8,A6),-(SP)
            move.l  A1,-(SP)
            move.l  ($C,A6),-(SP)
            movea.l (6,A1),A1
            jsr     (A1)
            lea     ($C,SP),SP
            dbra    D3,.L3
.L4:
            move.l  (SP)+,D3
            unlk    A6
            rts
sub_408E5478:
            movem.l D5-D7,-(SP)
            move.w  ($16,SP),D5
            moveq   #2,D7
            bra.b   .L2
.L1:
            lsl.l   #1,D7
.L2:
            moveq   #0,D0
            move.w  D5,D0
            cmp.l   D7,D0
            bcc.b   .L1
            moveq   #0,D0
            move.w  ($12,SP),D0
            move.l  D0,D6
.L3:
            move.l  D6,D1
            move.l  D1,D0
            mulu.w  #$15,D1
            swap    D0
            mulu.w  #$15,D0
            swap    D0
            clr.w   D0
            add.l   D0,D1
            addq.l  #1,D1
            move.l  D1,D0
            move.l  D7,D1
            jsr     sub_408E55D6
            move.l  D0,D6
            moveq   #0,D0
            move.w  D5,D0
            cmp.l   D6,D0
            bcs.b   .L3
            move.l  D6,D0
            movem.l (SP)+,D5-D7
            rts
sub_408E54C6:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            moveq   #3,D5
            bra.b   .L4
.L1:
            move.l  ($10,A6),-(SP)
            jsr     (A4)
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            addq.l  #4,SP
            bra.b   .L3
.L2:
            tst.w   (A3)
            bne.b   .L5
.L3:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D6
            move.l  D6,D0
            sub.l   D7,D0
            moveq   #$1E,D1
            cmp.l   D0,D1
            bhi.b   .L2
.L4:
            move.l  D5,D0
            subq.l  #1,D5
            tst.l   D0
            bne.b   .L1
.L5:
            movem.l (-$14,A6),D5-D7/A3-A4
            unlk    A6
            rts
sub_408E5510:
            link.w  A6,#-4
            moveq   #0,D0
            move.l  D0,(-4,A6)
.L1:
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #2,D1
            move.l  D1,-(SP)
            pea     (-4,A6)
            jsr     sub_408E3DA0
            lea     ($C,SP),SP
            tst.l   (-4,A6)
            bne.b   .L1
            moveq   #0,D0
            unlk    A6
            rts
sub_408E553A:
            link.w  A6,#-4
            movem.l A3-A4,-(SP)
            movea.l (8,A6),A4
            moveq   #0,D0
            move.l  D0,(-4,A6)
            movea.l D0,A3
            move.l  D0,(A4)
.L1:
            move.l  A4,-(SP)
            moveq   #3,D0
            move.l  D0,-(SP)
            pea     (-4,A6)
            jsr     sub_408E3DA0
            tst.w   D0
            lea     ($C,SP),SP
            beq.b   .L4
            moveq   #0,D0
            move.l  D0,(-4,A6)
            move.l  A3,D1
            beq.b   .L3
.L2:
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #4,D1
            move.l  D1,-(SP)
            pea     (-4,A6)
            jsr     sub_408E3DA0
            lea     ($C,SP),SP
            cmpa.l  (-4,A6),A3
            beq.b   .L3
            tst.l   (-4,A6)
            bne.b   .L2
.L3:
            moveq   #-1,D0
            bra.b   .L5
.L4:
            movea.l (-4,A6),A3
            tst.l   (-4,A6)
            bne.b   .L1
            moveq   #0,D0
.L5:
            movem.l (-$C,A6),A3-A4
            unlk    A6
            rts
sub_408E55AA:
            link.w  A6,#-4
.L1:
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #4,D1
            move.l  D1,-(SP)
            pea     (-4,A6)
            jsr     sub_408E3DA0
            lea     ($C,SP),SP
            tst.l   (-4,A6)
            bne.b   .L1
            moveq   #0,D0
            unlk    A6
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408E55D6:
            movem.l D2-D4,-(SP)
            move.l  D1,D2
            swap    D2
            tst.w   D2
            bne.b   .L2
            move.w  D0,D3
            clr.w   D0
            swap    D0
            beq.b   .L1
            divu.w  D1,D0
            move.w  D0,D2
.L1:
            swap    D2
            move.w  D3,D0
            divu.w  D1,D0
            move.w  D0,D2
            move.l  D2,D1
            clr.w   D0
            swap    D0
            bra.b   .L5
.L2:
            move.l  D0,D2
            clr.w   D0
            swap    D0
            swap    D2
            clr.w   D2
            move.l  D1,D3
            moveq   #0,D1
            moveq   #$F,D4
.L3:
            add.l   D2,D2
            addx.l  D0,D0
            add.l   D1,D1
            cmp.l   D3,D0
            blt.b   .L4
            sub.l   D3,D0
            addq.b  #1,D1
.L4:
            dbra    D4,.L3
.L5:
            movem.l (SP)+,D2-D4
            rts
sub_408E5626:
            move.l  A1,-(SP)
            move    SR,-(SP)
            movea.l ($2D8).w,A1
            movea.l ($328,A1),A1
            move    #$2600,SR
            move.l  ($30E,A1),(A0)
            move.l  A0,($30E,A1)
            addq.l  #1,($50,A1)
            move    (SP)+,SR
            movea.l (SP)+,A1
            rts
sub_408E5648:
            movem.l D1/A0,-(SP)
            movea.l ($328,A2),A0
            lea     ($72,A0),A0
            clr.w   D1
            move.b  ($334,A2),D1
            mulu.w  #$40,D1
            add.l   D0,D1
            addq.l  #1,(0,A0,D1.l)
            movem.l (SP)+,D1/A0
            rts
.L1:
            bra.b   .L4
            bra.w   sub_408E5930
.L5:
            clr.w   D3
            jmp     (2,A4)
.L6:
            clr.w   D3
            jsr     (2,A4)
            moveq   #$14,D0
            bra.w   sub_408E5648
.L4:
            movea.l ($328,A2),A3
            move.l  A3,D0
            beq.b   .L5
            move.l  ($50,A3),D0
            sub.l   ($54,A3),D0
            ble.b   .L6
            move    #$2600,SR
            move.l  ($30E,A3),D2
            beq.b   .L6
            movea.l D2,A5
            move.l  (A5),($30E,A3)
            subq.l  #1,($50,A3)
            lea     ($43,A5),A3
            move.w  #$24A,D3
            jsr     (2,A4)
            movea.l ($328,A2),A3
            movea.l D2,A0
            beq.b   .L7
            moveq   #$10,D0
            bsr.w   sub_408E5648
            bra.w   sub_408E5626
.L7:
            cmpi.b  #$FF,($C,A2)
            bne.b   .L8
            move.w  (8,A2),D0
            cmp.w   ($344,A2),D0
            bcs.b   .L8
            cmp.w   ($346,A2),D0
            bhi.b   .L8
            movea.l D2,A0
            bra.w   sub_408E5626
.L8:
            lea     ($72,A3),A1
            moveq   #0,D0
            move.b  ($334,A2),D0
            beq.b   .L9
            asl.l   #6,D0
.L9:
            addq.l  #1,(0,A1,D0.l)
            move.w  #$24A,D0
            sub.w   D3,D0
            moveq   #$10,D1
            add.w   D1,D0
            lea     ($28E,A0),A1
            move.l  A1,($1E,A0)
            move.w  D0,(A1)+
            lea     ($33,A0),A0
            move.l  A0,(A1)+
            clr.w   (A1)+
            lea     (1,A2),A1
.L10:
            move.b  (A1)+,(A0)+
            subq.w  #1,D1
            bne.b   .L10
            movea.l D2,A0
            movem.l D2-D3/A0-A3,(6,A0)
            bset    #0,($284,A3)
            bne.b   .L11
            move    ($1C,A2),SR
            bra.b   sub_408E5758.L13
.L11:
            lea     ($284,A3),A1
            bsr.b   .L12
            rts
.L12:
            addq.w  #2,A1
            clr.l   (A0)
            tst.l   (A1)+
            bne.b   .L2
            move.l  A0,(A1)
            move.l  A0,-(A1)
            bra.b   .L3
.L2:
            move.l  A2,-(SP)
            movea.l (A1),A2
            move.l  A0,(A2)
            move.l  A0,(A1)
            movea.l (SP)+,A2
            subq.w  #4,A1
.L3:
            subq.w  #2,A1
            rts
sub_408E5758:
            move    (SP)+,SR
.L13:
            movem.l (6,A0),D2-D3/A0-A3
            move.l  A2,D1
            movea.l D2,A2
            tst.b   ($3E,A2)
            bne.b   .L3
            move.l  A2,-(SP)
            bsr.w   sub_408E587E
            beq.b   .L1
            movea.l (SP)+,A2
            bra.b   .L3
.L1:
            move.w  ($1A,A2),D3
            sub.l   D2,D2
            move.w  ($1A,A2),D2
            move.w  D2,D0
            lsl.l   #8,D2
            move.b  (A2),D2
            movea.l (SP)+,A2
            move.b  D2,($3E,A2)
            move.w  D0,($3A,A2)
            pea     (A2)
            bsr.w   sub_408E5930
            movea.l (SP)+,A0
            beq.b   .L2
            move.l  A0,D2
            bra.b   .L4
.L2:
            movea.l A2,A1
            movea.l A0,A2
            bra.b   .L10
.L3:
            move.w  ($3A,A2),D3
            bsr.w   sub_408E5930
            beq.b   .L6
.L4:
            moveq   #$18,D0
.L5:
            movea.l D1,A2
            bsr.w   sub_408E5648
            movea.l D2,A0
            bsr.w   sub_408E5626
            bra.w   .L11
.L6:
            movea.l A2,A1
            moveq   #0,D0
            movea.l D1,A2
            move.b  ($334,A2),D0
            movea.l D2,A2
            move.b  ($44,A3,D0.w),D3
            andi.b  #$F,D3
            lsl.b   #2,D3
            move.b  D3,-(SP)
            btst    #6,($44,A3,D0.w)
            beq.b   .L7
            move.b  (8,A1),D0
            btst    #6,($44,A3,D0.w)
            beq.b   .L8
.L7:
            move.b  #4,(SP)
.L8:
            move.b  ($36,A2),D0
            add.b   (SP)+,D0
            cmpi.b  #$40,D0
            bcs.b   .L9
            moveq   #$1C,D0
            bra.b   .L5
.L9:
            move.b  D0,($36,A2)
            lea     (A2),A0
            sub.l   D2,D2
            move.w  (4,A1),D2
            lsl.l   #8,D2
            move.b  (6,A1),D2
            bne.b   .L10
            moveq   #0,D2
            move.w  ($3A,A2),D2
            lsl.l   #8,D2
            move.b  ($3E,A2),D2
.L10:
            move.b  D2,($33,A2)
            move.l  D2,($22,A0)
            clr.w   D0
            move.b  (8,A1),D0
            mulu.w  #$60,D0
            movea.l ($38,A3),A1
            move.w  (8,A1,D0.l),($18,A0)
            movea.l (0,A1,D0.l),A2
            move.w  #$F3,($1A,A0)
            lea     sub_408E58D6,A1
            move.l  A1,($C,A0)
            move.l  A3,($12,A0)
            _Control async
            moveq   #4,D0
            bsr.w   sub_408E5648
.L11:
            move    SR,-(SP)
            move    #$2600,SR
            movea.l ($286,A3),A0
            move.l  A0,D0
            beq.b   .L12
            lea     ($284,A3),A1
            bsr.w   sub_408E58F0
            bra.w   sub_408E5758
.L12:
            bclr    #0,($284,A3)
            move    (SP)+,SR
            rts
sub_408E587E:
            movem.l D0/D2-D3/A0-A1/A5,-(SP)
            move.w  ($3A,A2),D2
            movea.l ($2D8).w,A2
            movea.l ($328,A2),A5
            lea     ($44,A5),A1
            movea.l ($38,A5),A5
            moveq   #7,D0
.L1:
            move.l  (4,A5),D3
            btst    #6,(A1)+
            bne.b   .L2
            btst    #0,D3
            beq.b   .L2
            btst    #1,D3
            bne.b   .L2
            movea.l (A5),A0
            cmp.w   ($344,A0),D2
            bcs.b   .L2
            cmp.w   ($346,A0),D2
            bhi.b   .L2
            movea.l A0,A2
            move    #4,CCR
            bra.b   .L3
.L2:
            lea     ($60,A5),A5
            dbra    D0,.L1
            move    #0,CCR
.L3:
            movem.l (SP)+,D0/D2-D3/A0-A1/A5
            rts
sub_408E58D6:
            movea.l ($12,A0),A3
            tst.l   ($66,A3)
            beq.w   sub_408E5626
            move.l  A0,-(SP)
            movea.l ($66,A3),A0
            jsr     (A0)
            movea.l (SP)+,A0
            bra.w   sub_408E5626
sub_408E58F0:
            movem.l A2-A3,-(SP)
            movea.l (2,A1),A2
            movea.l A2,A3
.L1:
            cmpa.l  A3,A0
            beq.b   .L2
            movea.l A3,A2
            movea.l (A2),A3
            cmpa.l  (6,A1),A2
            bne.b   .L1
            moveq   #-1,D0
            bra.b   .L4
.L2:
            cmpa.l  A2,A3
            bne.b   .L5
            move.l  (A2),(2,A1)
            bne.b   .L3
            clr.l   (6,A1)
.L3:
            moveq   #0,D0
.L4:
            movem.l (SP)+,A2-A3
            rts
.L5:
            move.l  (A3),(A2)
            cmpa.l  (6,A1),A3
            bne.b   .L3
            move.l  A2,(6,A1)
            bra.b   .L3
sub_408E5930:
            movem.l D0-D2,-(SP)
            movea.l ($316,A3),A0
            moveq   #0,D0
            move.l  D0,D2
            move.l  ($31A,A3),D1
            beq.b   .L5
            subq.l  #4,D1
.L1:
            move.l  D0,D2
            add.l   D1,D2
            asr.l   #3,D2
            asl.l   #2,D2
            cmp.w   (2,A0,D2.l),D3
            beq.b   .L6
            bhi.b   .L2
            move.l  D2,D1
            subq.l  #4,D1
            bra.b   .L3
.L2:
            move.l  D2,D0
            addq.l  #4,D0
.L3:
            cmp.l   D0,D1
            bge.b   .L1
            cmp.l   ($31A,A3),D0
            bge.b   .L5
            move.l  D0,D2
            pea     (0,A0,D2.l)
            bsr.b   sub_408E59AE
            tst.w   (2,A2)
            beq.b   .L4
            cmp.w   (2,A2),D3
            bcs.b   .L4
            cmp.w   (A2),D3
            bls.b   .L7
.L4:
            addq.w  #4,SP
.L5:
            move.l  ($31E,A3),D1
            move.w  (0,A0,D1.l),D2
            movea.l ($14,A3),A2
            lea     (0,A2,D2.w),A2
            lea     (0,A0,D0.l),A0
            move    #0,CCR
            bra.b   .L8
.L6:
            pea     (0,A0,D2.l)
            bsr.b   sub_408E59AE
.L7:
            movea.l (SP)+,A0
            ori.b   #4,CCR
.L8:
            movem.l (SP)+,D0-D2
            rts
sub_408E59AE:
            move.w  (0,A0,D2.l),D2
            movea.l ($14,A3),A2
            lea     (0,A2,D2.w),A2
            rts
            dc.w    $756C,$2031

            EVEN
