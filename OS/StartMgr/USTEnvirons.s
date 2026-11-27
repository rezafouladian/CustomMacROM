USTMAINTEST:
            move.l  ($10,SP),D0
            movea.l (4,SP),A0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_FindSubtest,A0
            addq.l  #8,SP
            movea.l D0,A0
            movea.l ($10,A0),A3
            move.l  ($2A,A5),D0
            movea.l ($26,A5),A1
            movea.l ($22,A5),A0
            move.w  ($12,A1),D2
            moveq   #0,D6
            movem.l D0/D2/A0-A2/A5-A6,-(SP)
            lea     .L1,A6
            jmp     (A3)
.L1:
            tst.l   D6
            beq.b   .L2
            movem.l (SP),D0/D2/A0-A2/A5-A6
            tst.l   ($1A,A5)
            beq.b   .L2
            movea.l ($1A,A5),A3
            jsr     (A3)
.L2:
            movem.l (SP)+,D0/D2/A0-A2/A5-A6
            move.l  D6,D0
            rts
STM_Util:
            dc.w    0,$010C,0,$0176,0,$01A0,0,$0146
            dc.w    0,$01EE,0,$0204,0,$0254
GI_Table:
            dc.w    $0007,$C57E,$0007,$C63E,0,$0296,0,$02EC
            dc.w    $0007,$C71E,$0007,$C73E,$0007,$C75E,$0007,$C77E
            dc.w    $0007,$C79E,$0007,$C7BE,$0007,$C7DE,$0007,$C80E
            dc.w    $0007,$C82E,$0007,$C84E,$0007,$C86E,$0007,$C87E
            dc.w    $0007,$C88E,$0007,$C89E,$0007,$C8AE,$0007,$C8BE
            dc.w    $0007,$C8CE,$0007,$C64E,$0007,$C6AE
UTECmd:
            lea     (-6,SP),SP
            move.l  SP,-(SP)
            move.l  #6,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            move.l  (SP)+,D0
            bne.b   .notInit
            addq.l  #2,SP
            movea.l (SP),A6
            lea     STM_Util,A0
            adda.l  (A0),A0
            jmp     (A0)
.notInit:
            moveq   #0,D1
            move.w  (SP)+,D1
            movea.l (4,SP),A5
            movem.l D3/A3,-(SP)
            move.l  D0,(A5)
            move.l  D1,(4,A5)
            beq.b   .CmdDecode
            suba.l  D1,SP
            move.l  SP,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            move.l  (A5),D0
.CmdDecode:
            lea     STM_Util,A0
            cmpi.l  #$10000,D0
            blt.b   .Branch
            lea     GI_Table,A0
            subi.l  #$10000,D0
.Branch:
            move.l  ($16,A5),-(SP)
            lsl.l   #2,D0
            move.l  (0,A0,D0.l),D0
            jsr     (0,A0,D0.l)
            addq.l  #4,SP
            adda.l  (4,A5),SP
            movem.l (SP)+,D3/A3
            move.l  D0,-(SP)
            move.l  SP,-(SP)
            move.l  #4,-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            moveq   #0,D0
            move.l  (SP)+,D6
            beq.b   .finish
            move.b  #$58,D0
.finish:
            rts
UTEReset:
            move.l  A6,USP
            BSR6    USTINIT
            move.w  #4,(8,A5)
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            move.l  A5,-(SP)
            move.l  USP,A0
            move.l  A0,-(SP)
            movea.l ($16,A5),A0
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            rts
            move.l  (8,SP),D0
            movea.l ($12,A5),A0
.L5:
            cmp.w   (2,A0),D0
            beq.b   .L6
            cmpi.w  #$FFFF,(2,A0)
            beq.b   .L7
            addq.w  #6,A0
            bra.b   .L5
.L6:
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L7
            bsr.w   USTGETANDINSTALL
            moveq   #0,D0
            rts
.L7:
            moveq   #-1,D0
            rts
            movea.l ($12,A5),A0
.L8:
            moveq   #0,D0
            move.w  (2,A0),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L10
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L9
            move.l  A0,-(SP)
            bsr.w   USTGETANDINSTALL
            movea.l (SP)+,A0
.L9:
            addq.w  #6,A0
            bra.b   .L8
.L10:
            moveq   #0,D0
            rts
UTEINSTROMTESTS:
            clr.l   ($1A,A5)
            lea     USTTests,A0
            move.l  A0,D1
.L1:
            movea.l (4,A0),A1
            adda.l  D1,A1
            move.l  (8,A0),D0
            beq.b   .L2
            add.l   D1,D0
.L2:
            movea.l D0,A2
            movea.l ($16,A5),A3
            movem.l D1/A0,-(SP)
            pea     (A2)
            move.l  ($C,A0),-(SP)
            pea     (A1)
            move.l  (A0),-(SP)
            pea     (A3)
            BigJsr  GI_InstallTest,A0
            adda.w  #$14,SP
            movem.l (SP)+,D1/A0
            lea     ($10,A0),A0
            cmpi.l  #$FFFFFFFF,(A0)
            bne.b   .L1
            rts
            movea.l SP,A0
            move.l  (8,A0),-(SP)
            move.l  ($C,A0),-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            moveq   #0,D0
            rts
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            suba.w  ($E,A6),SP
            movea.l SP,A4
            movem.l D3/A3-A4/A6,-(SP)
            move.w  ($C,A6),-(SP)
            pea     (A4)
            move.w  ($E,A6),-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            movem.l (SP)+,D3/A3-A4/A6
            movem.l A6,-(SP)
            move.l  A4,-(SP)
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            moveq   #0,D0
            rts
            link.w  A6,#0
            move.w  ($E,A6),D0
            ext.l   D0
            suba.l  D0,SP
            movea.l SP,A4
            movem.l A4/A6,-(SP)
            move.l  A4,-(SP)
            move.l  D0,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            movem.l (SP)+,A4/A6
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A4-A6,-(SP)
            BSR6    CLKWPOFF
            movem.l (SP)+,A4-A6
            movem.l A6,-(SP)
            pea     (A4)
            move.w  ($C,A6),-(SP)
            move.w  ($E,A6),-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            moveq   #0,D0
            rts
            movea.l (4,SP),A0
            move.l  ($10,SP),D0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_AllocPermMem,A0
            addq.l  #8,SP
            tst.l   D0
            bne.b   .L3
            moveq   #-1,D0
            bra.b   .L4
.L3:
            move.l  ($10,SP),D1
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  (8,SP),D2
            movea.l (4,SP),A1
            movea.l ($14,SP),A2
            pea     (A2)
            move.l  D1,-(SP)
            pea     (A0)
            move.l  D2,-(SP)
            pea     (A1)
            BigJsr  GI_InstallTest,A0
            adda.w  #$14,SP
.L4:
            rts
            movea.l (4,SP),A0
            move.l  ($10,SP),D0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_AllocPermMem,A0
            addq.l  #8,SP
            tst.l   D0
            bne.b   .L5
            moveq   #-1,D0
            bra.b   .L6
.L5:
            move.l  ($10,SP),D1
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            movea.l SP,A0
            movea.l (4,A0),A1
            movea.l ($14,A0),A2
            move.l  ($1C,A0),-(SP)
            move.l  ($18,A0),-(SP)
            pea     (A2)
            move.l  D1,-(SP)
            pea     (A0)
            move.l  (8,A0),-(SP)
            pea     (A1)
            BigJsr  GI_InstallSubtest,A0
            adda.w  #$1C,SP
.L6:
            rts
GetCmdData:
            move.l  (4,SP),D1
            btst    #$14,D7
            beq.b   .L1
            lsl.l   #1,D1
.L1:
            movea.l (8,SP),A0
.L2:
            movem.l D1/A0/A5,-(SP)
.L3:
            BSR6    getchar
            tst.w   D0
            bmi.b   .L3
            btst    #$15,D7
            beq.b   .L4
            move.l  D0,D1
            BSR6    OutChar
            move.l  D1,D0
.L4:
            btst    #$14,D7
            beq.b   .L7
            cmpi.b  #$61,D0
            blt.b   .L5
            andi.b  #$DF,D0
.L5:
            BSR6    CVTASCII
            movem.l (SP)+,D1/A0/A5
            btst    #0,D1
            bne.b   .L6
            lsl.b   #4,D0
            move.b  D0,(A0)
            bra.b   .L8
.L6:
            or.b    D0,(A0)+
            bra.b   .L8
.L7:
            movem.l (SP)+,D1/A0/A5
            move.b  D0,(A0)+
.L8:
            subq.l  #1,D1
            bgt.b   .L2
            rts
SendData:
            bsr.w   sub_4084B95C
            move.l  (4,SP),D1
            move.l  D1,D4
            movea.l (8,SP),A0
.L1:
            move.b  (A0)+,D0
            btst    #$14,D7
            beq.b   .L2
            move.b  D0,D2
            lsr.b   #4,D0
            bsr.w   sub_4084B94A
            BSR6    OutChar
            move.b  D2,D0
            andi.b  #$F,D0
            bsr.w   sub_4084B94A
.L2:
            BSR6    OutChar
            cmpi.l  #4,D4
            ble.b   .L3
            move.l  A0,D0
            andi.b  #3,D0
            bne.b   .L3
            bsr.w   sub_4084B95C
.L3:
            subq.l  #1,D1
            bgt.b   .L1
            moveq   #0,D0
            rts
sub_4084B94A:
            cmpi.b  #$A,D0
            blt.b   .L1
            addi.b  #$37,D0
            bra.b   .L2
.L1:
            addi.b  #$30,D0
.L2:
            rts
sub_4084B95C:
            move.b  #$D,D0
            BSR6    OutChar
            move.b  #$A,D0
            BSR6    OutChar
            rts
USTGETANDINSTALL:
            suba.w  #$18,SP
            move.l  SP,-(SP)
            move.l  D0,-(SP)
            bsr.w   USTGETSUBTEST
            addq.l  #8,SP
            movea.l SP,A0
            movea.l ($16,A5),A1
            movea.l (4,A0),A2
            movea.l (8,A0),A3
            move.l  ($14,A0),-(SP)
            move.l  ($10,A0),-(SP)
            pea     (A3)
            move.l  ($C,A0),-(SP)
            pea     (A2)
            move.l  (A0),-(SP)
            pea     (A1)
            BigJsr  GI_InstallSubtest,A0
            adda.w  #$1C,SP
            lea     ($18,SP),SP
            rts
diagROMentry:
            tst.l   D7
            bne.b   .L1
            movea.l (SP),A6
            move.l  A6,USP
            BSR6    USTINIT
            move.w  #4,(8,A5)
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            move.l  USP,A0
            move.l  A0,-(SP)
            movea.l ($16,A5),A0
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            lea     diagROMentry,A3
            rts
.L1:
            move.l  D7,D0
            lea     .L3,A0
            cmpi.l  #$10000,D0
            blt.b   .L2
            lea     GI_Table,A0
            subi.l  #$10000,D0
.L2:
            move.l  (SP)+,(A5)
            move.l  ($16,A5),-(SP)
            lsl.l   #2,D0
            move.l  (0,A0,D0.l),D0
            jsr     (0,A0,D0.l)
            addq.l  #4,SP
            move.l  D0,D6
            movea.l (A5),A0
            lea     diagROMentry,A3
            jmp     (A0)
.L3:
            ds.b    4
            dc.w    $FFFF,$FC6C,$FFFF,$FC96,0,$0014,0,$0046
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movea.l ($E,A6),A3
            movem.l A6,-(SP)
            move.w  ($12,A6),-(SP)
            pea     (A3)
            move.w  ($C,A6),-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            rts
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A5-A6,-(SP)
            BSR6    CLKWPOFF
            movem.l (SP)+,A5-A6
            movea.l ($10,A6),A3
            movem.l A6,-(SP)
            pea     (A3)
            move.w  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            rts
            ds.b    8
