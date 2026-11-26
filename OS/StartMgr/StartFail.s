            include "Include/ROMHeader.s"

            EXPORT  CritErr,PutIcon

            IMPORT  TMRestart

            SECTION "StartFail",CODE

CritErr:
            movem.l D0-D7/A0-A7,seVars
            cmpi.l  #videoMagic,VideoInfoOK
            bne.w   SkipDisplay
            subq.w  #2,SP
            movea.l SP,A0
            _GetVideoDefault
            move.b  (A0)+,D0
            suba.w  #$36,SP
            movea.l SP,A0
            move.b  D0,($31,A0)
            clr.w   ($32,A0)
            move.w  #3,($28,A0)
            move.w  #1,($2A,A0)
            move.w  #1,($2C,A0)
            move.b  #1,($30,A0)
            _sNextTypesRsrc
            bne.b   .L3
            move.l  (4,A0),-(SP)
            move.w  #$80,D3
.L1:
            move.b  D3,($32,A0)
            _sFindStruct
            bne.b   .L2
            move.b  #1,($32,A0)
            _sGetBlock
            movea.l (A0),A1
            cmpi.w  #1,($20,A1)
            beq.b   .L4
            addq.w  #1,D3
            move.l  (SP),(4,A0)
            bra.b   .L1
.L2:
            addq.w  #4,SP
.L3:
            lea     ($38,SP),SP
            bra.w   SkipDisplay
.L4:
            suba.w  #$10,SP
            lea     ($40,SP),A0
            move.w  D3,(A0)
            clr.l   (2,A0)
            clr.w   (6,A0)
            move.l  A0,($1C,SP)
            movea.l SP,A0
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l DeviceList,A2
            movea.l (A2),A2
            move.w  (A2),($18,A0)
            move.w  #2,($1A,A0)
            _Control
            movea.l ($1C,A0),A2
            lea     TinyTable,A3
            move.l  A3,(A2)
            clr.w   (4,A2)
            move.w  #1,(6,A2)
            move.w  #3,($1A,A0)
            _Control
            lea     ($4C,SP),SP
            move.w  ($A,A1),-(SP)
            move.w  ($C,A1),D1
            move.w  (4,A1),D2
            movea.l A1,A0
            _DisposPtr
            move.w  (SP)+,D0
            movea.l ScrnBase,A2
            move.l  ScreenBytes,D3
            movem.l D0-D1/A2,-(SP)
            lsr.w   #1,D0
            subi.w  #$16,D0
            bset    #0,D0
            mulu.w  D2,D0
            adda.l  D0,A2
            lsr.w   #4,D1
            subq.w  #2,D1
            adda.w  D1,A2
            move.l  A2,IconTLAddr
            movem.l (SP)+,D0-D1/A2
            movea.l A2,A3
            lsr.w   #1,D0
            mulu.w  D2,D0
            adda.l  D0,A3
            lsr.w   #4,D1
            adda.w  D1,A3
            lsr.l   #2,D3
            moveq   #1,D0
            _SwapMMUMode
            move.b  D0,-(SP)
            moveq   #-1,D0
.L5:
            move.l  D0,(A2)+
            subq.l  #1,D3
            bhi.b   .L5
            move.b  (SP)+,D0
            _SwapMMUMode
            movea.l A3,A2
            moveq   #$18,D0
            mulu.w  D2,D0
            adda.l  D0,A2
            subq.w  #4,A2
            move.l  D7,D0
            moveq   #8-1,D4
            BSR6    FailData
            movea.l A3,A2
            moveq   #36,D0
            mulu.w  D2,D0
            adda.l  D0,A2
            subq.w  #32/8,A2
            move.l  D6,D0
            moveq   #8-1,D4
            BSR6    FailData
            BSR6    DeadMac                         ; Plot the dead Mac icon
SkipDisplay:
            BigJmp  TMRestart,A0
TinyTable:
            dc.w    $0000,$FFFF,$FFFF,$FFFF         ; White
            dc.w    $0000,$0000,$0000,$0000         ; Black
FailData:
            moveq   #1,D1
            exg     D1,D0
            _SwapMMUMode
            move.b  D0,-(SP)
            exg     D1,D0
FailLoop:
            rol.l   #4,D0
            moveq   #$F,D5
            and.b   D0,D5
            mulu.w  #3,D5
            lea     numFont(PC,D5.w),A1
            moveq   #-$3D,D1
            moveq   #2,D3
chLoop:
            move.b  (A1),D5
            lsr.w   #2,D5
            or.w    D1,D5
            move.b  D5,(A2)
            adda.w  D2,A2
            move.b  (A1)+,D5
            lsl.w   #2,D5
            or.w    D1,D5
            move.b  D5,(A2)
            adda.w  D2,A2
            dbra    D3,chLoop
            moveq   #6,D1
            mulu.w  D2,D1
            suba.l  D1,A2
            addq.w  #1,A2
            dbra    D4,FailLoop
            move.b  (SP)+,D0
            _SwapMMUMode
            RTS6
numFont:
            dc.w    $9642,$69B3,$BBB1,$96ED,$B00E,$9E69,$6660,$EE07
            dc.w    $1E69,$8716,$690E,$DDBB,$9696,$6996,$68E1,$9660
            dc.w    $6616,$1661,$8777,$7816,$6661,$0717,$7007,$1777
DeadMac:
            lea     SadMacIcon,A0
            movea.l IconTLAddr,A2
            moveq   #1,D0
            _SwapMMUMode
            move.b  D0,-(SP)
            moveq   #6,D1
            mulu.w  D2,D1
            adda.l  D1,A2
            subq.w  #4,D2
            moveq   #$1F,D1
.BlastIcon:
            move.l  (A0)+,(A2)+
            adda.w  D2,A2
            dbra    D1,.BlastIcon
            move.b  (SP)+,D0
            _SwapMMUMode
            RTS6
PutIcon:
            moveq   #$F,D3
.UNCOMP1:
            movea.l A2,A0
            moveq   #3,D2
.UILOOP:
            move.w  #$100,D4
            move.b  (A4)+,D4
.MLOOP:
            lsr.w   #1,D4
            beq.b   .DONE
            bcc.b   .IBLACK
            clr.b   (A2)+
            bra.b   .CHECK
.IBLACK:
            move.b  (A4)+,(A2)+
.CHECK:
            dbra    D2,.MLOOP
            adda.w  ScreenRow,A2
            subq.w  #4,A2
            moveq   #3,D2
            bra.b   .MLOOP
.DONE:
            dbra    D3,.UILOOP
            movea.l A0,A1
            moveq   #$1E,D3
.XLOOP:
            adda.w  ScreenRow,A1
            move.l  (A0),D4
            eor.l   D4,(A1)
            movea.l A1,A0
            dbra    D3,.XLOOP
            RTS6
SadMacIcon:
            dc.w    $FFFF,$FFFF,$F800,$003F,$F000,$001F,$F1FF,$FF1F
            dc.w    $F200,$009F,$F200,$009F,$F228,$289F,$F210,$109F
            dc.w    $F228,$289F,$F200,$009F,$F204,$809F,$F203,$009F
            dc.w    $F200,$009F,$F20F,$C09F,$F210,$309F,$F200,$089F
            dc.w    $F200,$009F,$F1FF,$FF1F,$F000,$001F,$F000,$001F
            dc.w    $F000,$001F,$F000,$001F,$F300,$1F9F,$F000,$001F
            dc.w    $F000,$001F,$F000,$001F,$F000,$001F,$FFFF,$FFFF
            dc.w    $F800,$003F,$F800,$003F,$F800,$003F,$FFFF,$FFFF
            ds.b    14

            EVEN
