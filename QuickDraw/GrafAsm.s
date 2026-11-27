NewHandle:
            moveq   #0,D0
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            bne.b   .L1
            moveq   #2,D0
.L1:
            _NewHandleClear
            bne.b   .L2
            move.l  A0,(SP)
            jmp     (A1)
.L2:
            moveq   #$19,D0
            jsr     ([$1524.w])
JACKSONPOLLOCK:
            _Debugger
RNewHandle:
            _NewHandleClear
            bne.b   NewHandle.L2
            rts
SetHSize:
            moveq   #0,D0
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            _SetHandleSize
            bne.b   NewHandle.L2
            jmp     (A1)
RSetHSize:
            _SetHandleSize
            bne.b   NewHandle.L2
            rts
            ds.b    10
NEWTEMPHANDLE:
            movem.l D1-D3,-(SP)
            move.l  D0,D3
            move.l  ($107C).w,D0
            cmp.l   ($103C).w,D0
            bne.b   .L1
            moveq   #0,D0
            movea.l D0,A0
            bra.b   .L2
.L1:
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            movea.l D0,A0
            beq.b   .L2
            move.l  D3,D0
.L2:
            movem.l (SP)+,D1-D3
            rts
            ds.b    14
NewTempBuffer:
            movem.l D1-D3,-(SP)
            move.l  D0,D3
            move.l  ($107C).w,D0
            cmp.l   ($103C).w,D0
            beq.b   .L5
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            beq.b   .L3
.L1:
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            pea     MemErr
            move.w  #$1E,-(SP)
            _OSDispatch
            movea.l (SP)+,A0
            move.l  D3,D0
.L2:
            movem.l (SP)+,D1-D3
            rts
.L3:
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (4,SP)
            move.w  #$15,-(SP)
            _OSDispatch
            move.l  (SP)+,D3
            addq.w  #4,SP
            tst.l   D3
            ble.b   .L5
.L4:
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            bne.b   .L1
            subi.l  #$1000,D3
            bgt.b   .L4
.L5:
            moveq   #0,D0
            movea.l D0,A0
            bra.b   .L2
DisposeTempBuffer:
            move.l  A0,D0
            beq.b   .L1
            move.l  A0,-(SP)
            pea     MemErr
            move.w  #$20,-(SP)
            _OSDispatch
.L1:
            rts
            ds.b    14
InitGraf:
            link.w  A6,#0
            movem.l D2/A2/A4,-(SP)
            movea.l (8,A6),A4
            move.l  A4,(A5)
            clr.b   QDExist
            jsr     ([$F48.w])
            lea     (-$CA,A4),A0
            lea     (4,A4),A1
.L1:
            clr.w   (A0)+
            cmpa.l  A1,A0
            bne.b   .L1
            move.w  #1,(-$9E,A4)
            lea     (-$90,A4),A4
            move.l  A4,D0
            move.w  #$A,(A4)+
            move.l  #$80018001,(A4)+
            move.l  #$7FFF7FFF,(A4)+
            move.l  A4,D1
            move.l  D0,(A4)+
            move.l  D1,(A4)+
            moveq   #1,D0
            move.l  D0,(A4)+
            move.l  A4,-(SP)
            _ScrnBitMap
            lea     ($E,A4),A4
            moveq   #$1A,D0
            lea     .L7,A0
.L2:
            move.l  (A0)+,(A4)+
            dbra    D0,.L2
            move.l  #$60082,D0
            lea     ($DA0).w,A0
            _ReadXPRam
            bsr.l   CheckDevices
            movea.l MainDevice,A0
            move.l  A0,TheGDevice
            move.l  A0,SrcDevice
            move.l  QDColors,D0
            movea.l D0,A0
            bgt.b   .L4
            subq.w  #4,SP
            move.w  #$7F,-(SP)
            jsr     ([$1660.w])
            moveq   #$40,D0
            _NewPtrSysClear
            move.l  A0,QDColors
            movea.l (SP),A1
            movea.l (A1),A1
            addq.w  #8,A1
            moveq   #$F,D0
.L3:
            move.l  (A1)+,(A0)+
            dbra    D0,.L3
            jsr     ([$1690.w])
.L4:
            movea.l QDColors,A0
            cmpi.w  #$64AF,($2C,A0)
            bne.b   .L5
            move.w  #$8000,($2C,A0)
.L5:
            moveq   #-1,D0
            movea.l PortList,A0
            cmp.l   A0,D0
            bne.b   .L6
            moveq   #2,D0
            jsr     RNewHandle
            move.l  A0,PortList
.L6:
            bsr.l   GetDevPix
            movea.l A0,A4
            movea.l (A5),A1
            lea     (-$7A,A1),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,D2
            andi.w  #$7FFF,D2
            move.w  ($20,A4),D1
            move.w  D2,D0
            ext.l   D0
            divu.w  D1,D0
            move.w  D0,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            jsr     ([$1674.w])
            move.l  TheGDevice,LastTxGDevice
            jsr     ([$11F8.w])
            jsr     ([$F4C.w])
            movem.l (SP)+,D2/A2/A4
            unlk    A6
            rtd     #4
.L7:
            dc.w    0,$4000,$6000,$7000,$7800,$7C00,$7E00,$7F00
            dc.w    $7F80,$7C00,$6C00,$4600,$0600,$0300,$0300,0
            dc.w    $C000,$E000,$F000,$F800,$FC00,$FE00,$FF00,$FF80
            dc.w    $FFC0,$FFE0,$FE00,$EF00,$CF00,$8780,$0780,$0380
            dc.w    $0001,$0001,$77DD,$77DD,$77DD,$77DD,$8822,$8822
            dc.w    $8822,$8822,$AA55,$AA55,$AA55,$AA55,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF
            ds.b    16
NewPort:
            clr.l   -(SP)
            jsr     ([$1160.w])
            clr.l   -(SP)
            jsr     ([$1160.w])
            movea.l ($C,SP),A0
            move.l  (SP)+,($1C,A0)
            move.l  (SP)+,($18,A0)
            move.l  (SP)+,(SP)
            rts
OpenPort:
            move.l  (4,SP),-(SP)
            move.l  (SP),-(SP)
            jsr     NewPort
            jsr     InsPortList
InitPort:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            lea     (2,A2),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            move.l  (A0),(A1)+
            move.l  (4,A0),(A1)+
            jsr     InitShared
            lea     ($20,A2),A1
            clr.l   (A1)+
            clr.l   (A1)+
            moveq   #-1,D0
            move.l  D0,(A1)+
            move.l  D0,(A1)+
            lea     ($3A,A2),A1
            move.l  D0,(A1)+
            move.l  D0,(A1)+
            lea     ($50,A2),A1
            move.l  #$21,(A1)+
            move.l  #$1E,(A1)+
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            ds.b    8
InitShared:
            movea.l (A5),A0
            move.l  A2,(A0)
            clr.w   (A2)
            lea     (-$74,A0),A0
            lea     ($10,A2),A1
            move.l  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (A1)+,-(SP)
            move.l  A0,-(SP)
            jsr     ([$117C.w])
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            move.l  ($1C,A2),-(SP)
            jsr     ([$1170.w])
            lea     ($30,A2),A1
            clr.l   (A1)+
            move.l  #$10001,(A1)+
            move.w  #8,(A1)+
            lea     ($42,A2),A1
            clr.w   (A1)+
            clr.l   (A1)+
            move.w  #1,(A1)+
            clr.w   (A1)+
            clr.l   (A1)+
            lea     ($58,A2),A1
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            rts
            dc.w    0
SetStdProcs:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  JStdTEXT,(A1)+
            move.l  ($1040).w,(A1)+
            move.l  ($1080).w,(A1)+
            move.l  ($10BC).w,(A1)+
            move.l  ($10D8).w,(A1)+
            move.l  ($10F4).w,(A1)+
            move.l  ($1114).w,(A1)+
            move.l  ($1144).w,(A1)+
            move.l  ($11AC).w,(A1)+
            move.l  ($11C4).w,(A1)+
            move.l  ($11B4).w,(A1)+
            move.l  ($11B8).w,(A1)+
            move.l  ($11C0).w,(A1)+
            jmp     (A0)
            ds.b    6
SetStdCProcs:
            move.l  (4,SP),-(SP)
            jsr     ([$11A8.w])
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            lea     ($34,A1),A1
            move.l  ($1DE0).w,(A1)+
            moveq   #5,D0
.L1:
            clr.l   (A1)+
            dbra    D0,.L1
            jmp     (A0)
LocalToGlobal:
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #1,D2
            bra.b   GlobalToLocal.L1
GlobalToLocal:
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #0,D2
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            jsr     ([$1A5C.w])
            movea.l ($18,SP),A1
            move.w  (6,A0),D0
            move.w  (8,A0),D1
            bsr.b   ADDSUB
            movem.l (SP)+,D0-D2/A0-A1
            bra.b   SubPt.L2
ADDSUB:
            tst.w   D2
            beq.b   .L1
            neg.w   D0
            neg.w   D1
.L1:
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            rts
AddPt:
            movem.l D0-D2/A1,-(SP)
            moveq   #0,D2
            bra.b   SubPt.L1
SubPt:
            movem.l D0-D2/A1,-(SP)
            moveq   #1,D2
.L1:
            movea.l ($14,SP),A1
            move.w  ($18,SP),D0
            move.w  ($1A,SP),D1
            bsr.b   ADDSUB
            movem.l (SP)+,D0-D2/A1
            move.l  (SP)+,(SP)
.L2:
            move.l  (SP)+,(SP)
            rts
SetPort:
            movea.l (A5),A0
            move.l  (4,SP),(A0)
            bra.b   SubPt.L2
GetPort:
            movea.l (A5),A0
            movea.l (4,SP),A1
            move.l  (A0),(A1)
            bra.b   SubPt.L2
            ds.b    14
GrafDevice:
            moveq   #0,D0
            jmp     PortWord
            ds.b    10
SetPortBits:
            movea.l (A5),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            tst.w   (4,A0)
            bmi.b   .L2
            movea.l (4,SP),A1
            move.l  (A1)+,(A0)+
            move.w  (A1)+,(A0)+
.L1:
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L2:
            move.l  (SP)+,(SP)
            rts
BackPat:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bmi.b   .L1
            lea     ($20,A0),A0
            movea.l (4,SP),A1
            bra.b   SetPortBits.L1
.L1:
            move.l  (4,SP),-(SP)
            pea     ($20,A0)
            jsr     ([$1A44.w])
            bra.b   SetPortBits.L2
            ds.b    14
PortSize:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($12,A0),D0
            add.w   (6,SP),D0
            move.w  D0,($16,A0)
            move.w  ($10,A0),D0
            add.w   (4,SP),D0
            move.w  D0,($14,A0)
            move.l  (SP)+,(SP)
            rts
MovePortTo:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($12,A0),D0
            move.w  ($10,A0),D1
            jsr     ([$1A5C.w])
            sub.w   (8,A0),D0
            sub.w   (6,SP),D0
            sub.w   (6,A0),D1
            sub.w   (4,SP),D1
            move.l  (SP)+,(SP)
sub_40831924:
            addq.w  #6,A0
OFSRECT:
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            rts
SetOrigin:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),D0
            cmp.l   ($10,A0),D0
            beq.b   .L1
            move.w  (6,SP),D0
            sub.w   ($12,A0),D0
            move.w  (4,SP),D1
            sub.w   ($10,A0),D1
            move.l  ($18,A0),-(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            pea     ($10,A0)
            jsr     ([$1A5C.w])
            bsr.b   sub_40831924
            movea.l (SP)+,A0
            bsr.b   OFSRECT
            jsr     ([$1180.w])
.L1:
            move.l  (SP)+,(SP)
            rts
ClipRect:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($1C,A0),-(SP)
            move.l  (8,SP),-(SP)
            jsr     ([$117C.w])
            bra.b   SetOrigin.L1
            ds.b    12
SetClip:
            movea.l (SP)+,A0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  ($1C,A1),-(SP)
            bra.b   GetClip.L1
GetClip:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  ($1C,A1),-(SP)
            move.l  D0,-(SP)
.L1:
            move.l  A0,-(SP)
            jmp     CopyRgn
SetPt:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,(A1)
            jmp     (A0)
            ds.b    6
EqualPt:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            seq     (SP)
            neg.b   (SP)
            jmp     (A0)
            ds.b    4
InsPortList:
            clr.l   -(SP)
            move.l  PortList,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            pea     ($18,SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            jsr     ([$1580.w])
            move.l  (SP)+,D0
            movea.l PortList,A0
            movea.l (A0),A0
            addq.w  #1,(A0)
            move.l  (SP)+,(SP)
            rts
            ds.b    6
DelPortList:
            movea.l PortList,A0
            movea.l (A0),A0
            tst.w   (A0)
            beq.b   .L1
            subq.w  #1,(A0)
            clr.l   -(SP)
            move.l  PortList,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            pea     ($10,SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            pea     .L1
            clr.l   -(SP)
            jsr     ([$1580.w])
            move.l  (SP)+,D0
.L1:
            move.l  (SP)+,(SP)
            rts
