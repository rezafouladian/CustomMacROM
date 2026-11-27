            include "Include/ROMHeader.s"

            EXPORT  RsrcEntryPACK_7

            IMPORT  BaseOfROM,RsrcEntryCDEF_0

            SECTION "BinDec",CODE

RsrcEntryPACK_7:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PACK' 7 (1380 bytes) - Combo mask
            dc.l    RsrcEntryCDEF_0-BaseOfROM       ; Next entry
            dc.l    Pkg7-BaseOfROM            ; Data
            dc.b    'PACK'                          ; Type
            dc.w    7                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000570,$000000E4   ; Block header
Pkg7:
            bra.b   .L1
            dc.w    0
            dc.b    'PACK'
            dc.w    7,1
.L1:
            subq.w  #1,(4,SP)
            bpl.b   select1
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
            bgt.b   BDLOOP
            bmi.b   BDNEGVAL
            move.b  #$30,(A1)+
            bra.b   BDFIN
BDNEGVAL:
            move.b  #'-',(A1)+
            neg.l   D0
BDLOOP:
            add.l   D0,D0
            abcd    D5,D5
            abcd    D4,D4
            abcd    D3,D3
            abcd    D2,D2
            abcd    D1,D1
            dbra    D6,BDLOOP
            bsr.b   BD1OUT
            move.b  D2,D1
            bsr.b   BD1OUT
            move.b  D3,D1
            bsr.b   BD1OUT
            move.b  D4,D1
            bsr.b   BD1OUT
            move.b  D5,D1
            bsr.b   BD1OUT
BDFIN:
            move.w  A1,D0
            sub.w   A0,D0
            subq.b  #1,D0
            move.b  D0,(A0)
            movem.l (SP)+,D0-D6/A1
            rts
BD1OUT:
            ror.w   #4,D1
            bsr.b   BD1DIGOUT
            rol.w   #4,D1
BD1DIGOUT:
            tst.w   D6
            bpl.b   BDDOIT
            tst.b   D1
            beq.b   BDSKIPIT
            moveq   #0,D6
BDDOIT:
            ori.b   #$30,D1
            move.b  D1,(A1)+
            sub.b   D1,D1
BDSKIPIT:
            rts
select1:
            move.w  (4,SP),D0
            move.l  (SP),(2,SP)
            addq.w  #2,SP
            subq.w  #1,D0
            bpl.b   select2
            movem.l D1-D3/A0,-(SP)
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D3
            move.b  (A0)+,D2
            beq.b   DBFIN
            cmpi.b  #$2B,(A0)
            beq.b   DBPOSSIGN
            cmpi.b  #$2D,(A0)
            bne.b   DBLOOP
            moveq   #1,D3
DBPOSSIGN:
            addq.l  #1,A0
            subq.b  #1,D2
            beq.b   DBFIN
DBLOOP:
            moveq   #$F,D1
            and.b   (A0)+,D1
            add.l   D0,D0
            add.l   D0,D1
            lsl.l   #2,D0
            add.l   D1,D0
            subq.b  #1,D2
            bne.b   DBLOOP
            tst.b   D3
            beq.b   DBFIN
            neg.l   D0
DBFIN:
            movem.l (SP)+,D1-D3/A0
            rts
select2:
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
