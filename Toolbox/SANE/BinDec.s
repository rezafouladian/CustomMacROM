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
.L13:
            link.w  A6,#0
            movem.l D2-D7/A2-A3,-(SP)
            movem.l ($C,A6),D4-D6
            move.l  D6,D0
            _StripAddress
            movea.l D0,A0
            movea.l D5,A1
            moveq   #0,D6
            move.b  (A0),D6
            lea     (0,A0,D6.w),A3
            adda.w  (A1),A0
            move.l  A0,D6
            movea.l D4,A1
            lea     (4,A1),A2
            move.l  D1,D4
            addi.b  #$30,D4
            moveq   #$39,D7
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D5
            clr.l   (A1)
            move.l  #$54E3030,(A2)
            move.w  #$3131,(4,A2)
.L14:
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$20,D0
            beq.b   .L14
            cmpi.b  #$CA,D0
            beq.b   .L14
            cmpi.b  #9,D0
            beq.b   .L14
            cmpi.b  #$2B,D0
            beq.b   .L15
            cmpi.b  #$2D,D0
            bne.b   .L16
            addq.b  #1,(A1)
.L15:
            bsr.b   GetChar_Str2Dec
.L16:
            cmpi.b  #$30,D0
            bcs.b   .L17
            bhi.b   .L18
            bset    #$F,D4
            moveq   #-1,D6
            bsr.b   GetChar_Str2Dec
            bra.b   .L16
.L17:
            cmpi.b  #$2E,D0
            beq.w   GetChar_Str2Dec.L5
            tst.w   D4
            bpl.w   GetChar_Str2Dec.L26
            bra.w   GetChar_Str2Dec.L16
.L18:
            cmpi.b  #$39,D0
            bls.b   .L19
            tst.w   D4
            bpl.w   GetChar_Str2Dec.L23
            bra.w   GetChar_Str2Dec.L10
.L19:
            moveq   #-1,D6
.L20:
            bsr.b   AppendDigit
            bcs.b   .L21
            cmpi.b  #$39,D0
            bls.b   .L20
.L21:
            cmpi.b  #$2E,D0
            bne.w   GetChar_Str2Dec.L10
            bsr.b   GetChar_Str2Dec
            bcs.w   GetChar_Str2Dec.L16
            bra.b   GetChar_Str2Dec.L9
AppendDigit:
            cmpi.b  #$13,D2
            blt.b   .L1
            bgt.b   .L2
            addq.w  #1,D1
.L1:
            addq.l  #1,A2
            move.b  D0,(A2)
            addq.b  #1,D2
            bra.b   GetChar_Str2Dec
.L2:
            or.b    D0,(A2)
            addq.w  #1,D1
GetChar_Str2Dec:
            tst.l   D4
            bpl.b   .L1
            move.b  (A0)+,D0
            beq.b   .L4
            bra.b   .L2
.L1:
            cmpa.l  A0,A3
            blt.b   .L3
            move.b  (A0)+,D0
.L2:
            cmpi.b  #$30,D0
            rts
.L3:
            addq.l  #1,A0
.L4:
            bset    #$10,D4
            tst.l   D6
            bpl.w   .L26
            bra.w   .L16
.L5:
            bsr.b   GetChar_Str2Dec
            beq.b   .L7
            bcs.b   .L6
            cmpi.b  #$39,D0
            bls.b   .L8
.L6:
            tst.w   D4
            bpl.w   .L26
            bra.b   .L10
.L7:
            bset    #$F,D4
            moveq   #-1,D6
            subq.w  #1,D1
            bra.b   .L5
.L8:
            moveq   #-1,D6
            subq.w  #1,D1
            bsr.b   AppendDigit
            bcs.b   .L16
.L9:
            cmpi.b  #$39,D0
            bls.b   .L8
.L10:
            move.l  A0,D6
            subq.l  #1,D6
            cmpi.b  #$45,D0
            beq.b   .L11
            cmpi.b  #$65,D0
            bne.b   .L16
.L11:
            bsr.b   GetChar_Str2Dec
            cmpi.b  #$2B,D0
            beq.b   .L12
            cmpi.b  #$2D,D0
            bne.b   .L13
            bset    #$1F,D2
.L12:
            bsr.b   GetChar_Str2Dec
.L13:
            cmpi.b  #$30,D0
            bcs.b   .L15
            cmpi.b  #$39,D0
            bhi.b   .L15
            moveq   #-1,D6
            andi.w  #$F,D0
            mulu.w  #$A,D5
            add.w   D0,D5
            cmpi.w  #$2000,D5
            bcs.b   .L14
            move.w  #$2000,D5
.L14:
            bra.b   .L12
.L15:
            tst.l   D6
            bpl.w   .L26
.L16:
            subq.l  #1,A0
.L17:
            tst.b   D2
            bne.b   .L18
            tst.w   D4
            bpl.b   .L22
            move.w  #$130,(A2)
            bra.b   .L22
.L18:
            tst.l   D2
            bpl.b   .L19
            neg.w   D5
.L19:
            cmpi.b  #$30,(4,A1,D2.w)
            bne.b   .L21
            subq.b  #1,D2
            cmpi.b  #$13,D2
            beq.b   .L20
            addq.w  #1,D5
.L20:
            bra.b   .L19
.L21:
            move.b  D2,(4,A1)
            add.w   D1,D5
            move.w  D5,(2,A1)
.L22:
            suba.l  ($14,A6),A0
            movea.l ($10,A6),A1
            move.w  A0,(A1)
            movea.l (4,A6),A0
            movea.l (8,A6),A1
            swap    D4
            move.b  D4,(A1)
            movem.l (-$20,A6),D2-D7/A2-A3
            unlk    A6
            lea     ($14,SP),SP
            jmp     (A0)
.L23:
            cmpi.b  #$B0,D0
            beq.w   .L28
            subq.l  #1,A0
            moveq   #$49,D3
            bsr.w   sub_4087A146
            beq.w   .L27
            cmpi.b  #$4E,D0
            bne.b   .L26
            moveq   #$41,D3
            bsr.w   sub_4087A146
            bne.b   .L26
            moveq   #$4E,D3
            bsr.w   sub_4087A146
            bne.w   .L26
            move.l  #$54E3430,(A2)+
            move.w  #$3030,(A2)
            move.l  A0,D6
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$28,D0
            bne.b   .L26
            moveq   #0,D3
.L24:
            bsr.w   GetChar_Str2Dec
            bcs.b   .L25
            cmpi.b  #$39,D0
            bhi.b   .L26
            mulu.w  #$A,D3
            andi.w  #$F,D0
            add.w   D0,D3
            bra.b   .L24
.L25:
            cmpi.b  #$29,D0
            bne.b   .L26
            bsr.b   sub_4087A15E
            ror.w   #8,D0
            ror.b   #4,D3
            bsr.b   sub_4087A15E
            ror.w   #8,D0
            move.w  D0,(A2)
            bra.b   .L29
.L26:
            movea.l D6,A0
            bra.w   .L17
.L27:
            moveq   #$4E,D3
            bsr.b   sub_4087A146
            bne.b   .L26
            moveq   #$46,D3
            bsr.b   sub_4087A146
            bne.b   .L26
.L28:
            move.w  #$149,(A2)
.L29:
            moveq   #-1,D6
            tst.l   D4
            bpl.b   .L30
            move.b  (A0),D0
            bne.w   .L22
            bra.b   .L31
.L30:
            cmpa.l  A0,A3
            bge.w   .L22
.L31:
            bset    #$10,D4
            bra.w   .L22
sub_4087A146:
            bsr.w   GetChar_Str2Dec
            cmpi.b  #$61,D0
            bcs.b   .L1
            cmpi.b  #$7A,D0
            bhi.b   .L1
            subi.b  #$20,D0
.L1:
            cmp.b   D3,D0
            rts
sub_4087A15E:
            move.b  #$F,D0
            and.b   D3,D0
            cmpi.b  #9,D0
            bls.b   .L1
            addq.b  #7,D0
.L1:
            addi.b  #$30,D0
            rts
            ds.b    14
.L2:
            movem.l D2-D5,-(SP)
            link.w  A6,#0
            movea.l ($20,A6),A0
            move.l  (A0),D5
            movea.l ($18,A6),A0
            movea.l ($1C,A6),A1
            move.l  (A1)+,D4
            addq.w  #1,A0
            moveq   #-$50,D2
            moveq   #0,D1
            move.b  (A1)+,D1
            beq.b   .L6
            btst    #$18,D4
            beq.b   .L3
            move.b  #$2D,(A0)+
            bra.b   .L4
.L3:
            btst    #$18,D5
            bne.b   .L5
            move.b  #$20,(A0)+
.L4:
            addq.w  #1,D2
.L5:
            move.b  (A1),D0
            cmpi.b  #$3F,D0
.L6:
            beq.w   sub_4087A2BA.L1
            ori.b   #$20,D0
            cmpi.b  #$69,D0
            beq.w   sub_4087A2BA.L8
            cmpi.b  #$6E,D0
            bne.b   sub_4087A206.L2
            move.b  #$4E,(A0)+
            move.b  #$41,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$28,(A0)+
            move.b  #$29,(3,A0)
            addq.w  #5,D2
            moveq   #0,D3
            cmpi.b  #5,D1
            ble.b   .L7
            moveq   #5,D1
.L7:
            bsr.b   sub_4087A206
            move.l  D3,D0
            bsr.b   sub_4087A206
            asl.b   #4,D3
            or.l    D0,D3
.L8:
            moveq   #4,D0
            bra.b   sub_4087A206.L9
sub_4087A206:
            subq.w  #1,D1
            ble.b   sub_4087A15E.L8
            move.b  (0,A1,D1.w),D3
            cmpi.b  #$39,D3
            ble.b   .L1
            subq.b  #7,D3
.L1:
            andi.b  #$F,D3
            rts
.L2:
            cmpi.b  #$30,(A1)
            bne.b   .L3
            moveq   #1,D1
            moveq   #0,D4
.L3:
            btst    #$18,D5
            bne.w   sub_4087A2BA.L2
            tst.w   D5
            bgt.b   .L4
            moveq   #1,D5
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A29A
            move.w  D1,D3
            ext.l   D3
            subq.l  #1,D3
            bgt.b   .L5
            cmpi.w  #1,D5
            ble.b   .L6
.L5:
            bsr.b   sub_4087A2A8
            move.w  D3,D0
            bsr.b   sub_4087A29A
            move.w  D5,D0
            sub.w   D1,D0
            bsr.b   sub_4087A2BA
.L6:
            addq.w  #2,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$65,(A0)+
            ext.l   D4
            add.l   D4,D3
            blt.b   .L7
            move.b  #$2B,(A0)+
            bra.b   .L8
.L7:
            move.b  #$2D,(A0)+
            neg.l   D3
.L8:
            moveq   #0,D0
.L9:
            lea     sub_4087A2BA.L9,A1
.L10:
            addq.w  #2,D0
            cmp.w   (-2,A1,D0.w),D3
            bcs.b   .L13
            cmpi.b  #8,D0
            blt.b   .L10
.L11:
            divu.w  (-2,A1,D0.w),D3
.L12:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            addi.w  #$30,D3
            move.b  D3,(A0)+
            swap    D3
            ext.l   D3
.L13:
            subq.w  #2,D0
            bgt.b   .L11
            beq.b   .L12
            bra.b   sub_4087A2BA.L6
sub_4087A29A:
            ble.b   .L2
            add.w   D0,D2
            bgt.b   sub_4087A2BA.L1
.L1:
            move.b  (A1)+,(A0)+
            subq.w  #1,D0
            bgt.b   .L1
.L2:
            rts
sub_4087A2A8:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$2E,(A0)+
            rts
.L1:
            addq.w  #1,D2
            bgt.b   sub_4087A2BA.L1
            move.b  #$30,(A0)+
sub_4087A2BA:
            subq.w  #1,D0
            bge.b   sub_4087A2A8.L1
            rts
.L1:
            movea.l ($18,A6),A0
            move.w  #$13F,(A0)
            bra.b   .L7
.L2:
            move.w  D1,D3
            add.w   D4,D3
            ble.b   .L4
            tst.w   D4
            bge.b   .L3
            move.w  D3,D0
            bsr.b   sub_4087A29A
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D4,D0
            bra.b   .L5
.L3:
            move.w  D1,D0
            bsr.b   sub_4087A29A
            move.w  D4,D0
            bsr.b   sub_4087A2BA
            move.w  D5,D0
            ble.b   .L6
            bsr.b   sub_4087A2A8
            bsr.b   sub_4087A2BA
            bra.b   .L6
.L4:
            moveq   #1,D0
            bsr.b   sub_4087A2BA
            bsr.b   sub_4087A2A8
            moveq   #0,D0
            sub.w   D3,D0
            bsr.b   sub_4087A2BA
            move.w  D1,D0
.L5:
            bsr.b   sub_4087A29A
            move.w  D4,D0
            add.w   D5,D0
            bsr.b   sub_4087A2BA
.L6:
            movea.l ($18,A6),A0
            addi.w  #$50,D2
            move.b  D2,(A0)
.L7:
            unlk    A6
            movem.l (SP)+,D2-D5/A0
            lea     ($C,SP),SP
            jmp     (A0)
.L8:
            move.b  #$49,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$46,(A0)
            addq.w  #3,D2
            bra.b   .L6
.L9:
            dc.w    $000A,$0064,$03E8,$2710
            ds.b    10

            EVEN
