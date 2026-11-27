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
