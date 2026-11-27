            include "Include/ROMHeader.s"

            SECTION "JMFBPrimaryInit",CODE

JMFBPRIMARYINIT:
            dc.w    $4E71
            movem.l D0-D7/A0-A4,-(SP)
            move.w  #1,(2,A0)
            move.l  #$F0000000,D1
            move.b  (A0),D0
            bfins   D0,D1{4:4}
            movea.l D1,A1
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  D0,($31,A0)
            clr.b   ($33,A0)
            clr.b   D6
            _sVersion
            sne     D6
            moveq   #1,D0
            _SwapMMUMode
            move.l  D0,-(SP)
            move.l  #$200000,D1
            bfextu  (0,A1,D1.l){20:3},D4
            cmpi.b  #7,D4
            bne.b   .L2
            bsr.w   GetXtndSense
            cmpi.b  #$14,D0
            bne.b   .L1
            move.b  #4,D4
            bra.b   .L3
.L1:
            move.b  #$F0,D4
            bra.b   .L3
.L2:
            cmpi.b  #0,D4
            bne.b   .L3
            move.b  #7,D4
.L3:
            move.l  (SP)+,D0
            _SwapMMUMode
            move.l  D4,D5
            move.b  #$F0,D3
            subq.w  #8,SP
            move.l  SP,(A0)
            _sReadPRAMrec
            move.b  (3,SP),D1
            sf      D2
            movea.l A1,A3
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D7
            bsr.w   pGetClockType
            cmp.b   (6,SP),D0
            beq.b   .L4
            move.b  D0,(6,SP)
            st      D2
.L4:
            move.w  D7,D0
            _SwapMMUMode
            bfextu  D1{29:3},D0
            cmp.b   D4,D0
            beq.b   .L5
            st      D2
            bra.b   .L8
.L5:
            move.b  D4,D0
            andi.b  #3,D0
            cmpi.b  #0,D0
            bne.b   .L8
            clr.b   (5,SP)
            tst.b   D6
            beq.b   .L6
            cmpi.b  #$84,(2,SP)
            bne.b   .L6
            move.b  #$FF,(5,SP)
.L6:
            move.l  (A0),(4,A0)
            _sPutPRAMRec
            btst    #3,D1
            beq.b   .L7
            bset    #3,D4
.L7:
            cmp.b   (4,SP),D1
            beq.b   .L8
            st      D2
.L8:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,D7
            move.l  #$F4B00,D1
            move.l  #$AAAAAAAA,D5
            move.l  D5,(0,A1,D1.l)
            move.l  MinusOne,-(SP)
            addq.w  #4,SP
            cmp.l   (0,A1,D1.l),D5
            bne.b   .L9
            bset    #5,D4
.L9:
            bset    #7,D4
            tst.b   D6
            beq.b   .L10
            bset    #4,D4
            bra.b   .L11
.L10:
            move.b  D4,D3
            bchg    #3,D3
.L11:
            tst.b   D2
            beq.b   .L12
            move.b  D4,(3,SP)
            move.b  D4,(4,SP)
            move.b  #$80,(2,SP)
            clr.b   (5,SP)
            move.l  SP,(4,A0)
            _sPutPRAMRec
.L12:
            addq.w  #8,SP
            bclr    #4,D4
            bclr    #4,D3
            move.w  D7,D0
            _SwapMMUMode
            lea     pGetClockType.L3,A2
            moveq   #$B,D1
.L13:
            move.b  (A2)+,D2
            tst.b   D6
            bne.b   .L14
            bset    #4,D2
.L14:
            move.b  D2,($32,A0)
            _sDeleteSRTRec
            dbra    D1,.L13
            clr.w   D7
            btst    #0,D4
            beq.b   .L15
            bclr    #2,D4
.L15:
            lea     pGetClockType.L3,A2
            moveq   #$B,D1
.L16:
            move.b  (A2)+,D2
            cmp.b   D3,D2
            bne.b   .L17
            tst.b   D6
            bne.b   .L17
            bclr    #4,D2
            move.b  D2,($32,A0)
            move.l  #1,($18,A0)
            clr.b   ($33,A0)
            _sSetsRsrcState
            clr.l   ($18,A0)
            bra.b   .L19
.L17:
            cmp.b   D4,D2
            beq.b   .L19
            tst.b   D6
            beq.b   .L18
            bset    #4,D2
.L18:
            move.b  D2,($32,A0)
            _sDeleteSRTRec
            addq.w  #1,D7
.L19:
            dbra    D1,.L16
            cmpi.w  #$C,D7
            beq.w   .L55
            move.b  D4,D2
            andi.b  #7,D4
            tst.b   D6
            beq.b   .L21
            move.b  ($31,A0),D3
            subq.w  #2,SP
            movea.l SP,A0
            _GetVideoDefault
            cmp.b   (A0),D3
            bne.b   .L20
            bclr    #4,D2
            cmp.b   (1,A0),D2
            bne.b   .L20
            bset    #4,D2
            move.b  D2,(1,A0)
            _SetVideoDefault
            bclr    #4,D2
.L20:
            addq.w  #2,SP
.L21:
            cmpi.b  #2,D4
            beq.b   .L22
            cmpi.b  #3,D4
            beq.b   .L23
            cmpi.b  #1,D4
            beq.b   .L24
            cmpi.b  #4,D4
            beq.b   .L25
            cmpi.b  #0,D4
            beq.b   .L29
            lea     pGetClockType.L13,A0
            bra.b   .L33
.L22:
            lea     pGetClockType.L12,A0
            bra.b   .L33
.L23:
            lea     pGetClockType.L15,A0
            bra.b   .L33
.L24:
            lea     pGetClockType.L14,A0
            bra.b   .L33
.L25:
            btst    #5,D2
            beq.b   .L27
            btst    #3,D2
            beq.b   .L26
            lea     pGetClockType.L9,A0
            bra.b   .L33
.L26:
            lea     pGetClockType.L11,A0
            bra.b   .L33
.L27:
            btst    #3,D2
            beq.b   .L28
            lea     pGetClockType.L8,A0
            bra.b   .L33
.L28:
            lea     pGetClockType.L10,A0
            bra.b   .L33
.L29:
            btst    #5,D2
            beq.b   .L31
            btst    #3,D2
            beq.b   .L30
            lea     pGetClockType.L5,A0
            bra.b   .L33
.L30:
            lea     pGetClockType.L7,A0
            bra.b   .L33
.L31:
            btst    #3,D2
            beq.b   .L32
            lea     pGetClockType.L4,A0
            bra.b   .L33
.L32:
            lea     pGetClockType.L6,A0
.L33:
            moveq   #1,D0
            _SwapMMUMode
            move.w  D0,-(SP)
            movea.l A1,A3
            adda.l  #$200208,A1
            moveq   #0,D0
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            movea.l A3,A1
            adda.l  #$200000,A1
            movea.l A1,A2
            move.w  #3,D1
            moveq   #0,D0
.L34:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L34
            bsr.w   pGetClockType
            move.l  D0,-(SP)
            movea.l A3,A1
            adda.l  #$200300,A1
            cmpi.w  #0,D0
            bne.b   .L36
            move.w  #2,D1
            moveq   #0,D0
.L35:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L35
            adda.w  #$10,A0
            bra.b   .L38
.L36:
            addq.l  #6,A0
            move.w  #$F,D1
            moveq   #0,D0
.L37:
            move.b  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L37
.L38:
            adda.w  #0,A2
            move.l  (SP)+,D0
            cmpi.w  #0,D0
            bne.b   .L39
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$2000,D1
            move.l  D1,(A2)
.L39:
            move.w  TimeDBRA,D1
.L40:
            dbra    D1,.L40
            move.w  TimeDBRA,D1
.L41:
            dbra    D1,.L41
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #$8000,D1
            move.l  D1,(A2)
            movea.l A3,A1
            adda.l  #$200100,A1
            move.w  #$E,D1
            moveq   #0,D0
.L42:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            dbra    D1,.L42
            move.l  #6,(A1)
            move.l  #7,(A1)
            move.l  (A2),D1
            andi.w  #$F1FF,D1
            ori.w   #8,D1
            move.l  D1,(A2)
            movea.l A2,A4
            movea.l A3,A1
            move.l  #$200204,D1
            clr.l   (-4,A1,D1.l)
            bra.b   .L43
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            bra.b   .L44
.L43:
            move.l  #$FF,(0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            move.l  #$FF,(0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
            clr.l   (0,A1,D1.l)
.L44:
            movea.l A3,A2
            andi.b  #3,D4
            cmpi.b  #0,D4
            beq.b   .L46
            move.w  #$A00,D3
            lsr.w   #2,D3
            subq.w  #1,D3
.L45:
            clr.l   (A2)+
            dbra    D3,.L45
            bra.b   .L48
.L46:
            move.w  #$2000,D3
            lsr.w   #2,D3
            subq.w  #1,D3
.L47:
            move.l  #$FFFFFFFF,(A2)+
            dbra    D3,.L47
.L48:
            movea.l A3,A2
            cmpi.b  #0,D4
            beq.b   .L49
            adda.w  #$A00,A2
            bra.b   .L50
.L49:
            adda.w  #$2000,A2
.L50:
            move.l  #$AAAAAAAA,D5
            move.w  (A0)+,D3
.L51:
            move.w  (A0),D1
.L52:
            move.l  D5,(A2)+
            dbra    D1,.L52
            not.l   D5
            dbra    D3,.L51
            btst    #3,D2
            bne.b   .L54
            move.w  #$39FF,D1
.L53:
            move.l  #$FFFFFFFF,(A2)+
            dbra    D1,.L53
.L54:
            move.l  (A4),D1
            andi.w  #$F1FF,D1
            ori.w   #$40,D1
            move.l  D1,(A4)
            move.w  (SP)+,D0
            _SwapMMUMode
.L55:
            lea     ($38,SP),SP
            movem.l (SP)+,D0-D7/A0-A4
            rts
GetXtndSense:
            movem.l D2-D6,-(SP)
            clr.w   D0
            moveq   #9,D5
            moveq   #4,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D0
            lsl.b   #2,D0
            moveq   #2,D3
            lsl.w   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            move.b  D2,D6
            andi.b  #1,D6
            lsr.b   #1,D2
            or.b    D6,D2
            or.b    D2,D0
            lsl.b   #2,D0
            moveq   #1,D3
            lsl.l   D5,D3
            move.l  (0,A1,D1.l),D4
            andi.w  #$F1FF,D4
            or.l    D3,D4
            move.l  D4,(0,A1,D1.l)
            bfextu  (0,A1,D1.l){20:3},D2
            lsr.l   #1,D2
            or.b    D2,D0
            movem.l (SP)+,D2-D6
            rts
pGetClockType:
            move.l  A0,-(SP)
            movea.l A3,A0
            adda.l  #$200300,A0
            move.l  #$55,(A0)
            move.l  (A0),D0
            andi.w  #$FF,D0
            cmpi.w  #$55,D0
            bne.b   .L1
            move.l  #$AA,(A0)
            move.l  (A0),D0
            andi.w  #$FF,D0
            cmpi.w  #$AA,D0
            bne.b   .L1
            clr.w   D0
            bra.b   .L2
.L1:
            move.w  #$FFFF,D0
.L2:
            movea.l (SP)+,A0
            rts
.L3:
            dc.w    $84A4,$81A1,$86A6,$83A3,$82A2,$8CAC
.L4:
            dc.b    $00,$80,$81,$12,$00,$E0,$01,$00,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$023F
            dc.w    $00FF
.L5:
            dc.b    $00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0160,$02FE,$0031,$0043,$0036,$0003
            dc.w    0,$023F,$0028,$0005,$0005,$005E,$0193,$023F
            dc.w    $00FF
.L6:
            dc.b    $00,$80,$81,$12,$00,$E0,$01,$00,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0103,$0D06,$0001,0
            dc.w    $0003,0,$0114,$0266,$007D,$0043,$0082,$0003
            dc.w    0,$0205,$0062,$0005,$0005,$005E,$0193,$01DF
            dc.w    $00FF
.L7:
            dc.b    $00,$C1,$81,$32,$00,$F8,$00,$60,$01
            ds.b    7
            dc.w    $0D09,$0100,$0604,$0001,$0101,$0D06,$0001,0
            dc.w    $0003,0,$0114,$0266,$007D,$0043,$0082,$0003
            dc.w    0,$0205,$0062,$0005,$0005,$005E,$0193,$01DF
            dc.w    $00FF
.L8:
            dc.w    $0080,$0112,$00E0,$0100,$0100,$001B,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0004,$0D06,$0401,0
            dc.w    $0003,0,$0136,$027E,$0012,$003A,$003A,$0003
            dc.w    0,$01E0,$0021,$0006,$0006,$006E,$014A,$01DF
            dc.w    $00FF
.L9:
            dc.w    $00C1,$0132,$00F8,$00E0,$0100,$006C,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$0136,$027E,$0012,$003A,$003A,$0003
            dc.w    0,$01E0,$0021,$0006,$0006,$006E,$014A,$01DF
            dc.w    $00FF
.L10:
            dc.w    $0080,$0112,$00E0,$0100,$0100,$001B,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0004,$0D06,$0401,0
            dc.w    $0003,0,$00F4,$01FE,$0054,$003A,$0078,$0003
            dc.w    0,$01B0,$0051,$0006,$0006,$006E,$014A,$017F
            dc.w    $00FF
.L11:
            dc.w    $00C1,$0132,$00F8,$00E0,$0100,$006C,$00B0,0
            dc.w    $0C01,$0200,$0703,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$00F4,$01FE,$0054,$003A,$0078,$0003
            dc.w    0,$01B0,$0051,$0006,$0006,$006E,$014A,$017F
            dc.w    $00FF
.L12:
            dc.w    $0080,$0082,$00E0,$0050,$0010,$002F,$00F0,0
            dc.b    $0E,$05,$00,$00,$0F
            ds.b    4
            dc.b    $03,$0D,$06,$04,$01,$00,$00,$00,$03,$00,$00,$01,$00,$01,$FE,$00
            dc.b    $2A,$00,$1E,$00,$32,$00,$03,$00,$00,$03,$00,$00,$26,$00,$06,$00
            dc.b    $02,$00,$04,$02,$60,$01,$7F,$00,$0F
.L13:
            dc.w    $00C0,$0082,$00F8,$0050,$0014,$0011,$002D,0
            dc.w    $0F07,0,$0501,0,$0002,$0D06,$0401,0
            dc.w    $0003,0,$0050,$009E,$000A,$000E,$001A,$0003
            dc.w    0,$03C0,$004E,$0006,$0006,$0004,$00C8,$01DF
            dc.w    $0013
.L14:
            dc.w    $00A0,$0002,$00F0,$0050,$0014,$002B,$003C,0
            dc.w    $0E07,0,$0601,0,$0001,$0D06,$0401,0
            dc.w    $0003,0,$00A0,$013E,$0012,$0026,$0022,$0003
            dc.w    0,$06CC,$0054,$0006,$0006,0,$0178,$0365
            dc.w    $0013
.L15:
            dc.w    $00C0,$2002,$00F8,$0050,$0024,$0005,$0004,0
            dc.w    $0E0B,0,$0301,0,$0001,$0D06,$0401,0
            dc.w    $0003,0,$0090,$011E,$0016,$001E,$0012,$0003
            dc.w    0,$06CC,$004E,$0006,$0006,0,$014C,$0365
            dc.w    $0023
            ds.b    14

            EVEN
