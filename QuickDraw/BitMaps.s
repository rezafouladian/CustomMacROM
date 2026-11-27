StdBits:
            link.w  A6,#-$F6
            movem.l D3-D7/A2-A4,-(SP)
            jsr     ([$1A3C.w])
            ble.w   .L26
            movea.l ($5C,A3),A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            seq     (-$F6,A6)
            movea.l ($16,A6),A1
            tst.w   (4,A1)
            spl     D7
            or.b    (-$F6,A6),D7
            lea     (-$4E,A6),A2
            jsr     ([$1A08.w])
            lea     ShftTbl,A0
            move.w  (-$2E,A6),D0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            clr.l   (-$AC,A6)
            tst.b   D2
            beq.w   .L6
            movea.l ($12,A6),A0
            lea     (-$9C,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            pea     (-$9C,A6)
            movea.l ($16,A6),A0
            move.l  (6,A0),D0
            neg.w   D0
            swap    D0
            neg.w   D0
            swap    D0
            move.l  D0,-(SP)
            jsr     ([$10A0.w])
            clr.l   -(SP)
            pea     (-$9C,A6)
            jsr     ([$169C.w])
            move.l  (SP)+,D0
            beq.w   .L25
            move.l  TheGDevice,-(SP)
            move.l  D0,TheGDevice
            movea.l D0,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            lea     (-$80,A6),A1
            moveq   #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            clr.w   (-$72,A6)
            movea.l ($12,A6),A0
            lea     (-$7A,A6),A1
            move.l  (A0)+,D1
            move.l  D1,(A1)+
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.w  D0,D5
            sub.w   D1,D5
            ext.l   D5
            moveq   #0,D3
            tst.b   D7
            bne.b   .L2
            lea     ShftTbl,A0
            move.w  (-$60,A6),D2
            move.b  (0,A0,D2.w),D3
.L2:
            lsl.l   D3,D5
            moveq   #$F,D2
            add.l   D2,D5
            asr.l   #4,D5
            ble.w   .L25
            add.w   D5,D5
            move.w  D5,(-$7C,A6)
            move.w  D5,D4
            tst.b   D7
            bne.b   .L3
            ori.w   #$8000,(-$7C,A6)
.L3:
            swap    D1
            swap    D0
            sub.w   D1,D0
            mulu.w  D5,D0
            move.l  D0,D5
            clr.b   (-$F5,A6)
            _NewHandle
            beq.b   .L4
            st      (-$F5,A6)
            move.l  D5,D0
            jsr     ([$1AB4.w])
            cmp.l   D5,D0
            bge.b   .L4
            move.l  (SP)+,TheGDevice
            move.w  #$FF71,QDErr
            bra.w   .L25
.L4:
            move.l  A0,(-$AC,A6)
            _HLock
            movea.l (A0),A0
            move.l  A0,(-$80,A6)
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            pea     (-$4E,A6)
            pea     (-$80,A6)
            move.l  ($12,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (SP)+,($5C,A3)
            move.l  (SP)+,TheGDevice
            lea     (-$80,A6),A0
            lea     (-$4E,A6),A1
            moveq   #$18,D0
.L5:
            move.w  (A0)+,(A1)+
            dbra    D0,.L5
.L6:
            lea     (-$4E,A6),A1
            movea.l (A1),A3
            move.w  (4,A1),D4
            andi.w  #$7FFF,D4
            movea.l ($12,A6),A0
            move.w  (A0),D0
            sub.w   (6,A1),D0
            ble.b   .L7
            add.w   D0,(6,A1)
            mulu.w  D4,D0
            adda.l  D0,A3
.L7:
            move.w  (4,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   .L8
            move.w  D0,($A,A1)
.L8:
            move.w  (2,A0),D0
            sub.w   (8,A1),D0
            ble.b   .L9
            ext.l   D0
            lsl.l   D3,D0
            asr.l   #3,D0
            adda.l  D0,A3
            lsl.l   #3,D0
            asr.l   D3,D0
            add.w   D0,(8,A1)
.L9:
            move.w  (6,A0),D0
            sub.w   (8,A1),D0
            ext.l   D0
            addq.l  #7,D0
            lsl.l   D3,D0
            andi.w  #$FFF8,D0
            asr.l   D3,D0
            add.w   (8,A1),D0
            cmp.w   ($C,A1),D0
            bge.b   .L10
            move.w  D0,($C,A1)
.L10:
            move.w  ($C,A1),D5
            sub.w   (8,A1),D5
            ext.l   D5
            lsl.l   D3,D5
            moveq   #$F,D0
            add.l   D0,D5
            asr.l   #4,D5
            ble.w   .L25
            add.w   D5,D5
            move.w  D5,(4,A1)
            ori.w   #$8000,(4,A1)
            clr.w   (-$40,A6)
            moveq   #8,D6
            move.w  #$90,-(SP)
            tst.l   (8,A6)
            beq.b   .L11
            addq.w  #1,(SP)
.L11:
            cmp.w   D6,D5
            bge.b   .L12
            move.w  #1,(-$3E,A6)
            bra.b   .L13
.L12:
            addq.w  #8,(SP)
.L13:
            tst.b   D7
            bne.b   .L17
            move.w  (-$30,A6),D2
            cmpi.w  #$10,D2
            bne.b   .L17
            ori.w   #$A,(SP)
            bsr.w   PutPicOp
            move.l  #$FF,-(SP)
            bsr.w   PutPicLong
            lea     (-$3E,A6),A0
            cmpi.w  #1,(A0)
            beq.b   .L15
            cmpi.w  #$10,(-$2E,A6)
            bne.b   .L14
            move.w  #3,(A0)
            bra.b   .L15
.L14:
            cmpi.w  #2,(A0)
            beq.b   .L15
            move.w  #4,(A0)
.L15:
            move.w  (-$44,A6),D1
            sub.w   (-$48,A6),D1
            mulu.w  D1,D5
            pea     (-$4A,A6)
            move.w  #$2E,-(SP)
            bsr.w   PutPicData
            bra.b   .L19
.L16:
            dc.w    $0003,$0201,$0103,$0201
.L17:
            bsr.w   PutPicOp
            moveq   #$2E,D0
            tst.b   D7
            beq.b   .L18
            andi.w  #$7FFF,(-$4A,A6)
            moveq   #$A,D0
.L18:
            pea     (-$4A,A6)
            move.w  D0,-(SP)
            bsr.w   PutPicData
            tst.b   D7
            bne.b   .L19
            move.l  (-$24,A6),-(SP)
            bsr.w   PutPicTable
.L19:
            move.l  ($12,A6),-(SP)
            move.w  D6,-(SP)
            bsr.w   PutPicData
            move.l  ($E,A6),-(SP)
            move.w  D6,-(SP)
            bsr.w   PutPicData
            move.w  ($C,A6),D0
            tst.b   (-$F6,A6)
            beq.b   .L20
            btst    #5,D0
            beq.b   .L20
            andi.w  #7,D0
            move.b  .L16(PC,D0.w),D0
.L20:
            move.w  D0,-(SP)
            bsr.w   PutPicWord
            tst.l   (8,A6)
            beq.b   .L21
            move.l  (8,A6),-(SP)
            bsr.w   PutPicRgn
.L21:
            cmpi.w  #$10,(-$30,A6)
            bne.b   .L22
            lea     (-$4E,A6),A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            bsr.w   PUTDIRECTPMDATA
            bra.b   .L23
.L22:
            lea     (-$4E,A6),A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            bsr.w   PutPMData
.L23:
            move.l  (-$AC,A6),D0
            beq.b   .L25
            movea.l D0,A0
            tst.b   (-$F5,A6)
            beq.b   .L24
            jsr     ([$1A78.w])
            bra.b   .L25
.L24:
            _DisposHandle
.L25:
            movea.l (A4),A3
.L26:
            tst.w   ($42,A3)
            blt.b   .L27
            lea     (2,A3),A0
            move.l  A0,(-$84,A6)
            move.l  ($18,A3),(-$E8,A6)
            move.l  ($1C,A3),(-$EC,A6)
            clr.l   (-$F0,A6)
            clr.l   (-$F4,A6)
            jsr     ([$1C78.w])
.L27:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$12
BitsDevLoop:
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.l  ($1E,A0),D0
            bne.b   .MANYVIDI
            move.l  ($16,A6),-(SP)
            move.l  (-$F0,A6),-(SP)
            move.l  (-$84,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  (-$F4,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$E8,A6),-(SP)
            move.l  (-$EC,A6),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .MASKOK1
            movea.l (A5),A0
            move.l  (-$82,A0),(SP)
.MASKOK1:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            rts
.MANYVIDI:
            move.l  SP,(-$D6,A6)
            lea     (-$CA,A6),A1
            move.l  A1,(-$D2,A6)
            movea.l TheGDevice,A0
            move.l  A0,(A1)+
            clr.l   (A1)+
            move.l  A1,(-$CE,A6)
            lea     (-$BA,A6),A2
            move.l  A2,(A1)+
            clr.l   (A1)+
            move.l  A0,(2,A2)
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$84,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            movea.l ($16,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A2
            cmp.l   (A0),D0
            seq     D6
            cmp.l   (A1),D0
            seq     D7
            moveq   #6,D2
            move.b  D6,D5
            and.b   D7,D5
            beq.b   .DIROK
            moveq   #0,D2
            move.l  ([$12.w,A6]),D0
            sub.w   (8,A0),D0
            move.l  ([$E.w,A6]),D1
            sub.w   (8,A1),D1
            cmp.w   D1,D0
            ble.b   .TORT
            addq.w  #2,D2
.TORT:
            swap    D0
            swap    D1
            sub.w   (6,A0),D0
            sub.w   (6,A1),D1
            cmp.w   D1,D0
            ble.b   .DIROK
            addq.w  #4,D2
.DIROK:
            lea     .L46,A4
            adda.w  (0,A4,D2.w),A4
            tst.b   D6
            beq.w   .L17
            movea.l ($12,A6),A1
            lea     (-$8C,A6),A0
            move.l  (A1)+,(A0)
            move.l  (A1)+,(4,A0)
            move.l  (6,A2),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A0)+
            bvc.b   .L5
            jsr     ([$1A58.w])
.L5:
            sub.w   D0,(A0)+
            bvc.b   .L6
            jsr     ([$1A58.w])
.L6:
            sub.w   D1,(A0)+
            bvc.b   .L7
            jsr     ([$1A58.w])
.L7:
            sub.w   D0,(A0)+
            bvc.b   .L8
            jsr     ([$1A58.w])
.L8:
            movea.l DeviceList,A2
            clr.w   -(SP)
.L9:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L10
            clr.b   -(SP)
            pea     (-$8C,A6)
            pea     ($22,A0)
            pea     (-$AC,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L10
            lea     (-$AC,A6),A0
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            move.l  A2,-(SP)
            move.w  #1,-(SP)
.L10:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L9
            movea.l SP,A2
            clr.l   -(SP)
            moveq   #0,D1
.L11:
            movea.l A2,A0
            movea.l D1,A1
.L12:
            tst.w   (A0)
            bmi.b   .L14
            beq.b   .L15
            cmp.l   A1,D1
            beq.b   .L13
            jsr     (A4)
            beq.b   .L14
.L13:
            movea.l A0,A1
.L14:
            lea     ($E,A0),A0
            bra.b   .L12
.L15:
            cmp.l   A1,D1
            beq.b   .L16
            st      (A1)
            move.l  A1,-(SP)
            bra.b   .L11
.L16:
            move.l  SP,(-$CE,A6)
.L17:
            tst.b   D7
            beq.w   .L30
            movea.l ($E,A6),A0
            lea     (-$94,A6),A1
            move.l  (A0)+,(A1)
            move.l  (A0)+,(4,A1)
            movea.l (-$84,A6),A0
            jsr     ([$1A04.w])
            move.l  (6,A0),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A1)+
            bvc.b   .L18
            jsr     ([$1A58.w])
.L18:
            sub.w   D0,(A1)+
            bvc.b   .L19
            jsr     ([$1A58.w])
.L19:
            sub.w   D1,(A1)+
            bvc.b   .L20
            jsr     ([$1A58.w])
.L20:
            sub.w   D0,(A1)+
            bvc.b   .L21
            jsr     ([$1A58.w])
.L21:
            movea.l DeviceList,A2
            clr.w   -(SP)
.L22:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L23
            clr.b   -(SP)
            pea     (-$94,A6)
            pea     ($22,A0)
            pea     (-$AC,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L23
            lea     (-$AC,A6),A0
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            move.l  A2,-(SP)
            move.w  #1,-(SP)
.L23:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L22
            movea.l SP,A2
            clr.l   -(SP)
            moveq   #0,D1
.L24:
            movea.l A2,A0
            movea.l D1,A1
.L25:
            tst.w   (A0)
            bmi.b   .L27
            beq.b   .L28
            cmp.l   A1,D1
            beq.b   .L26
            jsr     (A4)
            beq.b   .L27
.L26:
            movea.l A0,A1
.L27:
            lea     ($E,A0),A0
            bra.b   .L25
.L28:
            cmp.l   A1,D1
            beq.b   .L29
            st      (A1)
            move.l  (2,A1),-(SP)
            bra.b   .L24
.L29:
            move.l  SP,(-$D2,A6)
.L30:
            move.l  TheGDevice,-(SP)
            move.l  SrcDevice,-(SP)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),(-$DA,A6)
            move.l  ($50,A3),(-$DE,A6)
            move.l  ($54,A3),(-$E2,A6)
            move.b  HiliteMode,(-$E4,A6)
            lea     (-$A4,A6),A1
            movea.l ($E,A6),A0
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.l  (A0)+,D7
            move.l  D7,(A1)+
            sub.w   D0,D7
            swap    D0
            swap    D7
            sub.w   D0,D7
            movea.l ($12,A6),A0
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.l  (A0)+,D1
            move.l  D1,(A1)+
            swap    D7
            add.w   D0,D7
            sub.w   D1,D7
            swap    D7
            swap    D0
            swap    D1
            add.w   D0,D7
            sub.w   D1,D7
            movea.l (-$CE,A6),A2
.L31:
            movea.l (-$D2,A6),A4
            move.l  (A2)+,D0
            movea.l D0,A0
            beq.w   .DONE
            move.l  (2,A0),SrcDevice
.L32:
            move.l  (A4)+,D1
            beq.b   .L31
            move.l  D1,TheGDevice
            tst.b   D6
            beq.w   .CLIPOK
            movea.l (-4,A2),A0
            addq.w  #6,A0
            move.l  (A0)+,D0
            move.l  (A0)+,D1
            cmp.l   (-$8C,A6),D0
            bne.b   .DOTRIM
            cmp.l   (-$88,A6),D1
            beq.b   .CLIPOK
.DOTRIM:
            movea.l ($E,A6),A0
            lea     (-$A4,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l ($12,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            sub.w   (-$8A,A6),D0
            ble.b   .L34
            add.w   D0,(-$9A,A6)
            add.w   D0,(-$A2,A6)
.L34:
            swap    D0
            sub.w   (-$8C,A6),D0
            ble.b   .L35
            add.w   D0,(-$9C,A6)
            add.w   D0,(-$A4,A6)
.L35:
            sub.w   (-$86,A6),D1
            bpl.b   .L36
            add.w   D1,(-$96,A6)
            add.w   D1,(-$9E,A6)
.L36:
            swap    D1
            sub.w   (-$88,A6),D1
            bpl.b   .L37
            add.w   D1,(-$98,A6)
            add.w   D1,(-$A0,A6)
.L37:
            tst.l   D7
            beq.b   .CLIPOK
            lea     (-$9C,A6),A0
            lea     (-$A4,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            pea     (-$A4,A6)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            jsr     ([$11E8.w])
.CLIPOK:
            move.b  (-$E4,A6),HiliteMode
            tst.w   (6,A3)
            bpl.w   .DOIT
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            cmp.l   (-$DA,A6),D0
            beq.b   .DOIT
            move.l  D0,(-$DA,A6)
            subq.w  #6,SP
            clr.l   -(SP)
            move.l  (8,A3),D0
            beq.b   .NoPlt
            movea.l D0,A0
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .NoPlt
            move.w  ($18,A0),D2
            move.w  ($16,A0),(2,SP)
            btst    #1,D2
            sne     (SP)
            btst    #0,D2
            beq.b   .NoPlt
            move.w  ($10,A0),-(SP)
            jsr     ([$185C.w])
            bra.b   .NoPlt1
.NoPlt:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
.NoPlt1:
            tst.b   (SP)
            beq.b   .NoPlt2
            move.w  (2,SP),-(SP)
            jsr     ([$1860.w])
            bra.b   .BkDone
.NoPlt2:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
.BkDone:
            lea     ($A,SP),SP
.DOIT:
            move.l  ($16,A6),-(SP)
            move.l  (-$F0,A6),-(SP)
            move.l  (-$84,A6),-(SP)
            pea     (-$9C,A6)
            move.l  (-$F4,A6),-(SP)
            pea     (-$A4,A6)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$E8,A6),-(SP)
            move.l  (-$EC,A6),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .MASKOK
            movea.l (A5),A0
            move.l  (-$82,A0),(SP)
.MASKOK:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            bra.w   .L32
.DONE:
            move.l  (SP)+,SrcDevice
            move.l  (SP)+,TheGDevice
            move.l  (-$DE,A6),($50,A3)
            move.l  (-$E2,A6),($54,A3)
            bset    #7,HiliteMode
            movea.l (-$D6,A6),SP
            rts
.L46:
            dc.w    $0008,$003A,$0024,$0050,$3028,$000A,$B069,$0006
            dc.w    $6F0E,$3028,$000C,$B069,$0008,$6F04
.L47:
            moveq   #0,D0
            rts
XTRUE:
            moveq   #1,D0
            rts
            move.w  (6,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   XTRUE
            move.w  ($C,A0),D0
            cmp.w   (8,A1),D0
            ble.b   XTRUE
            bra.b   BitsDevLoop.L47
            move.w  ($A,A0),D0
            cmp.w   (6,A1),D0
            ble.b   XTRUE
            move.w  (8,A0),D0
            cmp.w   ($C,A1),D0
            bge.b   XTRUE
            bra.b   BitsDevLoop.L47
            move.w  (6,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   XTRUE
            move.w  (8,A0),D0
            cmp.w   ($C,A1),D0
            bge.b   XTRUE
            bra.b   BitsDevLoop.L47
            dc.w    0
CopyBits:
            link.w  A6,#-$10
            movem.l D2/D6-D7/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l ($1A,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A2
            move.l  (-$7A,A4),D6
            move.l  (A2),D7
            cmp.l   D6,D7
            bne.b   .L1
            move.l  ($12,A6),-(SP)
            move.l  (6,A2),-(SP)
            jsr     ([$F54.w])
.L1:
            movea.l ($16,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            move.l  A3,D0
            beq.b   .L3
            btst    #0,D0
            bne.b   .L3
            movea.l A3,A0
            jsr     ([$1A5C.w])
            move.l  (A1),D1
            cmp.l   (A0),D1
            beq.b   .L2
            cmp.l   D6,D1
            bne.b   .L3
            move.l  ROMBase,D0
            cmp.l   (A0),D0
            bne.b   .L3
            bra.w   .L6
.L2:
            move.l  (6,A0),D0
            cmp.l   (6,A1),D0
            beq.w   .L6
.L3:
            cmp.l   D6,D7
            beq.w   .L5
            movem.l D1/A1,-(SP)
            subq.w  #6,SP
            clr.l   -(SP)
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D1/A1
            cmp.l   D6,D1
            beq.b   .L5
            move.l  ($1A,A6),-(SP)
            clr.l   -(SP)
            move.l  ($16,A6),-(SP)
            move.l  ($12,A6),-(SP)
            clr.l   -(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$82,A4),-(SP)
            move.l  (SP),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .L4
            move.l  (-$82,A4),(SP)
.L4:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            bra.w   .L10
.L5:
            move.l  ($1A,A6),-(SP)
            movea.l ($16,A6),A1
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     GoDevLoop
            bra.w   .L10
.L6:
            move.w  (4,A2),D1
            bpl.w   .L8
            tst.w   (6,A3)
            bmi.w   .L8
            move.l  ($68,A3),D0
            beq.w   .L8
            movea.l ($11AC).w,A1
            exg     D0,A1
            cmp.l   ($20,A1),D0
            beq.w   .L8
            move.l  A0,-(SP)
            suba.w  #$12,SP
            moveq   #0,D0
            move.w  D1,D0
            lsl.w   #3,D0
            move.w  ($20,A2),D1
            divu.w  D1,D0
            moveq   #$F,D2
            add.l   D2,D0
            asr.l   #4,D0
            ble.w   .L7
            add.w   D0,D0
            move.w  D0,(4,SP)
            move.l  (6,A2),D1
            move.l  ($A,A2),D2
            move.l  D1,(6,SP)
            move.l  D2,($A,SP)
            swap    D1
            swap    D2
            sub.w   D1,D2
            mulu.w  D2,D0
            _NewHandle
            bne.b   .L7
            move.l  A0,($E,SP)
            _HLock
            movea.l (A0),A0
            move.l  A0,(SP)
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            move.l  ($1A,A6),-(SP)
            pea     ($E,SP)
            move.l  ($12,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (SP)+,($5C,A3)
            move.l  SP,-(SP)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  ($68,A3),D0
            movea.l D0,A0
            movea.l ($20,A0),A0
            jsr     (A0)
            movea.l ($E,SP),A0
            _DisposHandle
.L7:
            lea     ($12,SP),SP
            movea.l (SP)+,A0
            bra.b   .L10
.L8:
            move.l  A2,-(SP)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  ($68,A3),D0
            movea.l ($11AC).w,A0
            beq.b   .L9
            movea.l D0,A0
            movea.l ($20,A0),A0
.L9:
            jsr     (A0)
.L10:
            cmp.l   D6,D7
            bne.b   .L11
            jsr     ([$F4C.w])
.L11:
            movem.l (SP)+,D2/D6-D7/A2-A4
            unlk    A6
            rtd     #$16
            ds.b    4
GoDevLoop:
            link.w  A6,#-$F4
            movem.l D3-D7,-(SP)
            move.l  A1,(-$84,A6)
            move.l  (-$82,A4),(-$E8,A6)
            move.l  (-$82,A4),(-$EC,A6)
            clr.l   (-$F0,A6)
            clr.l   (-$F4,A6)
            jsr     ([$1C78.w])
            movem.l (SP)+,D3-D7
            unlk    A6
            rtd     #$12
COPYCICON:
            bra.b   CopyMask.L1
CopyMask:
            suba.l  A0,A0
.L1:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($14,A6),A1
            move.l  ($18,A6),D0
            move.l  ($C,A6),D1
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  (-$82,A4),D2
            move.l  D2,D3
            move.l  ($1C,A6),-(SP)
            move.l  ($10,A6),-(SP)
            move.l  (8,A6),-(SP)
            clr.w   -(SP)
            move.l  D2,-(SP)
            tst.l   A0
            beq.b   .L2
            move.l  A0,(SP)
.L2:
            movea.l ($14,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            move.l  A3,D4
            beq.b   .L3
            btst    #0,D4
            bne.b   .L3
            movea.l D4,A0
            jsr     ([$1A5C.w])
            move.l  (A0),D4
            cmp.l   (A1),D4
            bne.b   .L3
            move.l  (6,A0),D4
            cmp.l   (6,A1),D4
            bne.b   .L3
            move.l  ($1C,A3),D2
            move.l  ($18,A3),D3
.L3:
            movea.l ($14,A6),A1
            jsr     CMDEVLOOP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$18
CMDEVLOOP:
            link.w  A6,#-$F4
            move.l  A1,(-$84,A6)
            move.l  D0,(-$F0,A6)
            move.l  D1,(-$F4,A6)
            move.l  D2,(-$E8,A6)
            move.l  D3,(-$EC,A6)
            jsr     ([$1C78.w])
            unlk    A6
            rtd     #$12
            ds.b    12
SeedFill:
            movea.l (SP)+,A0
            moveq   #-1,D0
            move.l  D0,-(SP)
            bra.b   CalcMask.L1
CalcMask:
            movea.l (SP)+,A0
            moveq   #-1,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
.L1:
            move.l  A0,-(SP)
            link.w  A6,#-6
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-6,A6)
            move.w  ($10,A6),D5
            ble.w   .L22
            subq.w  #1,D5
            subq.w  #1,($12,A6)
            blt.w   .L22
            move.w  ($10,A6),D0
            add.w   D0,D0
            move.w  ($14,A6),D1
            sub.w   D0,D1
            move.w  D1,(-2,A6)
            movea.l ($18,A6),A2
            moveq   #-1,D0
            move.w  ($12,A6),D3
.L2:
            move.w  D5,D2
.L3:
            move.w  D0,(A2)+
            dbra    D2,.L3
            adda.w  D1,A2
            dbra    D3,.L2
            move.w  ($C,A6),D0
            blt.b   .L4
            mulu.w  ($14,A6),D0
            movea.l ($18,A6),A0
            adda.l  D0,A0
            move.w  ($E,A6),D0
            move.w  D0,D1
            asr.w   #3,D0
            not.w   D1
            bclr    D1,(0,A0,D0.w)
.L4:
            move.l  (8,A6),D6
            move.w  D5,D1
.L5:
            move.w  D6,-(SP)
            dbra    D1,.L5
            movea.l ($1C,A6),A0
            movea.l ($18,A6),A2
.L6:
            sf      D7
            move.w  ($12,A6),D4
            movea.l SP,A1
.L7:
            move.l  D6,D1
            move.w  D5,D3
.L8:
            move.w  (A2),D1
            bne.b   .L9
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            swap    D1
            dbra    D3,.L8
            bra.b   .L13
.L9:
            move.w  (A0)+,D2
            and.w   (A1)+,D1
            or.w    D2,D1
            bra.b   .L11
.L10:
            move.w  D0,D1
.L11:
            move.l  D1,D0
            lsr.l   #1,D0
            and.w   D1,D0
            or.w    D2,D0
            cmp.w   D1,D0
            bne.b   .L10
            cmp.w   (A2),D1
            beq.b   .L12
            st      D7
.L12:
            move.w  D1,(A2)+
            swap    D1
            dbra    D3,.L8
.L13:
            move.l  D6,D1
            move.w  D5,D3
.L14:
            move.w  -(A2),D1
            bne.b   .L15
            subq.w  #2,A0
            subq.w  #2,A1
            swap    D1
            dbra    D3,.L14
            bra.b   .L19
.L15:
            move.w  -(A0),D2
            and.w   -(A1),D1
            or.w    D2,D1
            bra.b   .L17
.L16:
            move.w  D0,D1
.L17:
            move.l  D1,D0
            rol.l   #1,D0
            and.w   D1,D0
            or.w    D2,D0
            cmp.w   D1,D0
            bne.b   .L16
            cmp.w   (A2),D1
            beq.b   .L18
            st      D7
            move.w  D1,(A2)
.L18:
            swap    D1
            dbra    D3,.L14
.L19:
            adda.w  ($16,A6),A0
            adda.w  ($14,A6),A2
            movea.l A2,A1
            suba.w  ($14,A6),A1
            dbra    D4,.L7
            neg.w   ($16,A6)
            neg.w   ($14,A6)
            adda.w  ($16,A6),A0
            adda.w  ($14,A6),A2
            tst.b   D7
            bne.w   .L6
            tst.w   D6
            bpl.b   .L22
            move.w  (-2,A6),D1
            movea.l ($18,A6),A2
            move.w  ($12,A6),D3
.L20:
            move.w  D5,D2
.L21:
            not.w   (A2)+
            dbra    D2,.L21
            adda.w  D1,A2
            dbra    D3,.L20
.L22:
            movea.l (-6,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$18
            ds.b    8
ScrollRect:
            link.w  A6,#-8
            movem.l D6-D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            tst.w   ($42,A3)
            blt.w   .L2
            tst.l   ($C,A6)
            beq.w   .L2
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1668.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            subq.w  #8,SP
            jsr     ([$1160.w])
            move.l  (SP)+,D7
            jsr     ([$1160.w])
            move.l  (SP)+,D6
            move.l  D7,-(SP)
            move.l  ($10,A6),-(SP)
            jsr     ([$117C.w])
            move.l  D7,-(SP)
            move.l  ($18,A3),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1190.w])
            move.l  D7,-(SP)
            move.l  ($1C,A3),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1190.w])
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            jsr     ([$1170.w])
            move.l  D6,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     ([$1180.w])
            movea.l ($10,A6),A0
            move.l  (A0)+,(-8,A6)
            move.l  (A0)+,(-4,A6)
            move.l  ($C,A6),D0
            add.w   D0,(-6,A6)
            add.w   D0,(-2,A6)
            swap    D0
            add.w   D0,(-8,A6)
            add.w   D0,(-4,A6)
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            move.l  D6,-(SP)
            jsr     ([$1190.w])
            pea     (2,A3)
            move.l  (SP),-(SP)
            move.l  ($10,A6),-(SP)
            pea     (-8,A6)
            clr.w   -(SP)
            move.l  D6,-(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1654.w])
            addq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (8,A6),D0
            beq.b   .L1
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            move.l  D0,-(SP)
            jsr     ([$1198.w])
            jsr     ([$1150.w])
.L1:
            movea.l D7,A0
            _DisposHandle
            movea.l D6,A0
            _DisposHandle
            bra.b   .L3
.L2:
            move.l  (8,A6),D0
            beq.b   .L3
            move.l  D0,-(SP)
            jsr     ([$1174.w])
.L3:
            move.l  (SP)+,($5C,A3)
            movem.l (SP)+,D6-D7/A3-A4
            unlk    A6
            rtd     #$C
            ds.b    6
PackBits:
            movem.l D3-D4/A2,-(SP)
            move.w  #$80,D4
            movea.l ($16,SP),A0
            movea.l (A0),A0
            movea.l ($12,SP),A1
            movea.l (A1),A1
            move.w  ($10,SP),D3
            subq.w  #1,D3
            blt.b   .L12
.L1:
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            move.b  (-1,A0),D0
            sub.w   A0,D2
            add.w   D2,D3
            addq.w  #1,D2
            move.b  D2,(A2)
.L3:
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L4
            move.w  D3,D1
.L4:
            move.w  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
            cmp.b   (A0),D0
            bne.b   .L6
            cmp.b   (1,A0),D0
            bne.b   .L6
            bra.b   .L9
.L5:
            move.b  (A0)+,D0
            cmp.b   (A0),D0
            bne.b   .L6
            cmp.b   (1,A0),D0
            beq.b   .L7
.L6:
            move.b  D0,(A1)+
            dbra    D1,.L5
            sub.w   A0,D2
            neg.w   D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
            bra.b   .L12
.L7:
            tst.w   D1
            beq.b   .L6
            sub.w   A0,D2
            add.w   D2,D3
            not.w   D2
            move.b  D2,(A2)
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L8
            move.w  D3,D1
.L8:
            move.l  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
.L9:
            move.b  D0,(A1)+
.L10:
            cmp.b   (A0)+,D0
            dbne    D1,.L10
            beq.b   .L11
            subq.w  #1,D1
            bge.b   .L2
.L11:
            subq.w  #1,A0
            sub.w   A0,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
.L12:
            moveq   #0,D0
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            add.l   D0,(A0)
            movea.l ($12,SP),A2
            move.l  A1,(A2)
            movem.l (SP)+,D3-D4/A2
.L13:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
UnpackBits:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            movea.l (6,SP),A1
            movea.l (A1),A1
            move.w  (4,SP),D2
            ext.l   D2
            add.l   A1,D2
            bra.b   .L3
.L1:
            ext.w   D1
.L2:
            move.b  (A0)+,(A1)+
            dbra    D1,.L2
.L3:
            cmpa.l  D2,A1
            bcc.b   .L5
            move.b  (A0)+,D1
            bpl.b   .L1
            neg.b   D1
            bvs.b   .L3
            ext.w   D1
            move.b  (A0)+,D0
.L4:
            move.b  D0,(A1)+
            dbra    D1,.L4
            bra.b   .L3
.L5:
            move.l  A0,D0
            movea.l ($A,SP),A0
            move.l  D0,(A0)
            movea.l (6,SP),A0
            move.l  A1,(A0)
            bra.b   PackBits.L13
            ds.b    6
PACKWORDS:
            movem.l D3-D4/A2,-(SP)
            move.w  #$80,D4
            movea.l ($16,SP),A0
            movea.l (A0),A0
            movea.l ($12,SP),A1
            movea.l (A1),A1
            move.w  ($10,SP),D3
            lsr.w   #1,D3
            subq.w  #1,D3
            blt.w   .L12
.L1:
            move.w  (A0)+,D0
            bra.b   .L3
.L2:
            move.w  (-2,A0),D0
            sub.w   A0,D2
            asr.w   #1,D2
            add.w   D2,D3
            addq.w  #1,D2
            move.b  D2,(A2)
.L3:
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L4
            move.w  D3,D1
.L4:
            move.w  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
            cmp.w   (A0),D0
            bne.b   .L6
            cmp.w   (2,A0),D0
            bne.b   .L6
            bra.b   .L9
.L5:
            move.w  (A0)+,D0
            cmp.w   (A0),D0
            bne.b   .L6
            cmp.w   (2,A0),D0
            beq.b   .L7
.L6:
            move.w  D0,(A1)+
            dbra    D1,.L5
            sub.w   A0,D2
            neg.w   D2
            asr.w   #1,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
            bra.b   .L12
.L7:
            tst.w   D1
            beq.b   .L6
            sub.w   A0,D2
            asr.w   #1,D2
            add.w   D2,D3
            not.w   D2
            move.b  D2,(A2)
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L8
            move.w  D3,D1
.L8:
            move.l  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
.L9:
            move.w  D0,(A1)+
.L10:
            cmp.w   (A0)+,D0
            dbne    D1,.L10
            beq.b   .L11
            subq.w  #1,D1
            bge.b   .L2
.L11:
            subq.w  #2,A0
            sub.w   A0,D2
            asr.w   #1,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.w   .L1
.L12:
            moveq   #0,D0
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            add.l   D0,(A0)
            movea.l ($12,SP),A2
            move.l  A1,(A2)
            movem.l (SP)+,D3-D4/A2
.L13:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
UNPACKWORDS:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            movea.l (6,SP),A1
            movea.l (A1),A1
            move.w  (4,SP),D2
            ext.l   D2
            add.l   A1,D2
            bra.b   .L3
.L1:
            ext.w   D1
.L2:
            move.w  (A0)+,(A1)+
            dbra    D1,.L2
.L3:
            cmpa.l  D2,A1
            bcc.b   .L5
            move.b  (A0)+,D1
            bpl.b   .L1
            neg.b   D1
            bvs.b   .L3
            ext.w   D1
            move.w  (A0)+,D0
.L4:
            move.w  D0,(A1)+
            dbra    D1,.L4
            bra.b   .L3
.L5:
            move.l  A0,D0
            movea.l ($A,SP),A0
            move.l  D0,(A0)
            movea.l (6,SP),A0
            move.l  A1,(A0)
            bra.b   PACKWORDS.L13
            ds.b    8
