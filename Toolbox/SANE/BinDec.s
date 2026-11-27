            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_7

            IMPORT  BaseOfROM,RsrcEntryCDEF_0

            SECTION "BinDec",CODE

RsrcEntryPACK_7:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 7 (1380 bytes) - Combo mask
            dc.l    RsrcEntryCDEF_0-BaseOfROM       ; Next entry
            dc.l    RsrcPACK_7-BaseOfROM            ; Data
            dc.b    'PACK'                          ; Type
            dc.w    7                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000570,$000000E4   ; Block header
RsrcPACK_7:
            bra.b   .L1
            dc.w    0,$5041,$434B,$0007,$0001
.L1:
            subq.w  #1,(4,SP)
            bpl.b   sub_40879E54.L3
            move.l  (SP),(2,SP)
            addq.w  #2,SP
            movem.l D0-D6/A1,-(SP)
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            moveq   #$1F,D6
            lea     (1,A0),A1
            tst.l   D0
            bgt.b   .L3
            bmi.b   .L2
            move.b  #$30,(A1)+
            bra.b   .L4
.L2:
            move.b  #$2D,(A1)+
            neg.l   D0
.L3:
            add.l   D0,D0
            abcd    D5,D5
            abcd    D4,D4
            abcd    D3,D3
            abcd    D2,D2
            abcd    D1,D1
            dbra    D6,.L3
            bsr.b   sub_40879E4E
            move.b  D2,D1
            bsr.b   sub_40879E4E
            move.b  D3,D1
            bsr.b   sub_40879E4E
            move.b  D4,D1
            bsr.b   sub_40879E4E
            move.b  D5,D1
            bsr.b   sub_40879E4E
.L4:
            move.w  A1,D0
            sub.w   A0,D0
            subq.b  #1,D0
            move.b  D0,(A0)
            movem.l (SP)+,D0-D6/A1
            rts
sub_40879E4E:
            ror.w   #4,D1
            bsr.b   sub_40879E54
            rol.w   #4,D1
sub_40879E54:
            tst.w   D6
            bpl.b   .L1
            tst.b   D1
            beq.b   .L2
            moveq   #0,D6
.L1:
            ori.b   #$30,D1
            move.b  D1,(A1)+
            sub.b   D1,D1
.L2:
            rts
.L3:
            move.w  (4,SP),D0
            move.l  (SP),(2,SP)
            addq.w  #2,SP
            subq.w  #1,D0
            bpl.b   .L7
            movem.l D1-D3/A0,-(SP)
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D3
            move.b  (A0)+,D2
            beq.b   .L6
            cmpi.b  #$2B,(A0)
            beq.b   .L4
            cmpi.b  #$2D,(A0)
            bne.b   .L5
            moveq   #1,D3
.L4:
            addq.l  #1,A0
            subq.b  #1,D2
            beq.b   .L6
.L5:
            moveq   #$F,D1
            and.b   (A0)+,D1
            add.l   D0,D0
            add.l   D0,D1
            lsl.l   #2,D0
            add.l   D1,D0
            subq.b  #1,D2
            bne.b   .L5
            tst.b   D3
            beq.b   .L6
            neg.l   D0
.L6:
            movem.l (SP)+,D1-D3/A0
            rts
.L7:
            subq.w  #1,D0
            bmi.b   .L8
            beq.b   .L9
            cmpi.w  #1,D0
            beq.b   .L10
            rts
.L8:
            jmp     .L12
.L9:
            jmp     sub_4087A15E.L2
.L10:
            jmp     .L11
            dc.w    0
.L11:
            moveq   #1,D1
            ror.l   #1,D1
            bra.b   .L13
.L12:
            moveq   #0,D1

            include "Toolbox/SANE/Str2Dec.s" ; _cstr2dec, _pstr2dec
            include "Toolbox/SANE/Dec2Str.s" ; _dec2str

            EVEN
