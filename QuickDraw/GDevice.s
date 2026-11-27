NewGDevice:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            clr.l   ($E,A6)
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            moveq   #$3E,D0
            _ResrvMem
            bne.w   .L3
            moveq   #$3E,D0
            _NewHandleClear
            _HLock
            movea.l A0,A2
            movea.l (A2),A3
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L3
            move.l  A0,(6,A3)
            moveq   #2,D0
            _NewHandleClear
            bne.b   .L3
            move.l  A0,($32,A3)
            moveq   #2,D0
            _NewHandleClear
            bne.b   .L3
            move.l  A0,($36,A3)
            moveq   #$50,D0
            _ResrvMem
            bne.b   .L3
            clr.l   -(SP)
            bsr.l   OpenPixMap
            move.l  (SP),($16,A3)
            movea.l (SP)+,A0
            _HLock
            move.l  (8,A6),D0
            cmpi.l  #$FFFFFFFF,D0
            beq.b   .L2
            cmpi.w  #$80,D0
            beq.b   .L1
            bset    #0,($15,A3)
.L1:
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  A2,-(SP)
            jsr     ([$16B8.w])
.L2:
            move.l  (SP)+,TheZone
            move.l  A2,($E,A6)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #6
.L3:
            move.l  A2,-(SP)
            jsr     DisposGDHandles
            bra.b   .L2
DisposGDevice:
            movea.l (SP)+,A1
            move.l  (SP),-(SP)
            bsr.b   DisposGDHandles
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
DisposGDHandles:
            move.l  A1,-(SP)
            movea.l (8,SP),A1
            movea.l (A1),A1
            move.l  ($16,A1),-(SP)
            move.l  (6,A1),D0
            beq.b   .L1
            movea.l D0,A0
            _DisposHandle
.L1:
            move.l  ($32,A1),D0
            beq.b   .L2
            movea.l D0,A0
            _DisposHandle
.L2:
            move.l  ($36,A1),D0
            beq.b   .L3
            movea.l D0,A0
            _DisposHandle
.L3:
            move.l  (SP)+,D0
            beq.b   .L4
            move.l  D0,-(SP)
            jsr     ([$1610.w])
.L4:
            movea.l (SP)+,A1
            move.l  (SP)+,(SP)
            rts
            ds.b    8
InitGDevice:
            link.w  A6,#-$54
            movem.l D2/A2-A3,-(SP)
            movea.l (8,A6),A0
            _HGetState
            move.w  D0,(-$4E,A6)
            _HLock
            movea.l (A0),A2
            movea.l ($16,A2),A0
            _HGetState
            move.w  D0,(-$50,A6)
            _HLock
            movea.l (A0),A3
            move.l  TheGDevice,(-$54,A6)
            move.w  ($10,A6),(A2)
            move.l  ($C,A6),D0
            cmp.l   MinusOne,D0
            beq.w   .L3
            lea     (-$40,A6),A0
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            move.w  ($10,A6),($18,A0)
            lea     (-$4C,A6),A1
            move.l  A1,($1C,A0)
            cmp.l   ($2A,A2),D0
            beq.w   .L1
            move.l  D0,($2A,A2)
            clr.w   ($30,A2)
            movem.l A0-A1,-(SP)
            move.w  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  ($16,A2),-(SP)
            pea     (4,A2)
            jsr     GetDevPixMap
            movem.l (SP)+,A0-A1
            move.w  #2,($1A,A0)
            move.l  ($C,A6),D0
            move.w  D0,(A1)
            clr.w   (6,A1)
            clr.l   (2,A1)
            _Control immed
            move.w  #5,($1A,A0)
            _Control immed
.L1:
            move.w  ($14,A2),D0
            not.w   D0
            andi.w  #1,D0
            move.b  D0,(A1)
            move.w  #6,($1A,A0)
            _Control immed
            cmpi.w  #0,(4,A2)
            bne.b   .L2
            movea.l ($2A,A3),A0
            _HLock
            movea.l (A0),A0
            clr.w   (4,A1)
            move.w  (6,A0),(6,A1)
            lea     (8,A0),A0
            move.l  A0,(A1)
            lea     (-$40,A6),A0
            move.w  #3,($1A,A0)
            move.l  A1,($1C,A0)
            _Control immed
            movea.l ($2A,A3),A0
            _HUnlock
.L2:
            cmpi.w  #2,(4,A2)
            beq.b   .L3
            move.l  ($2A,A3),-(SP)
            move.l  (6,A2),-(SP)
            moveq   #4,D0
            move.w  D0,($A,A2)
            move.w  D0,-(SP)
            jsr     ([$16E4.w])
.L3:
            cmpi.l  #$FFFFFFFF,($DC8).w
            beq.b   .L4
            moveq   #2,D0
            move.l  (8,A6),-(SP)
            _PaletteDispatch
.L4:
            lea     (6,A3),A0
            lea     ($22,A2),A1
            move.w  ($14,A2),D0
            btst    #$A,D0
            beq.b   .L5
            exg     A0,A1
.L5:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (-$54,A6),TheGDevice
            movea.l ($16,A2),A0
            move.w  (-$50,A6),D0
            _HSetState
            movea.l (8,A6),A0
            move.w  (-$4E,A6),D0
            _HSetState
            movem.l (SP)+,D2/A2-A3
            unlk    A6
            rtd     #$A
            ds.b    12
GetDevPixMap:
            link.w  A6,#-$3A
            movem.l D3-D5/A2-A4,-(SP)
            movea.l ($C,A6),A0
            _HGetState
            move.w  D0,(-$3A,A6)
            _HLock
            movea.l (A0),A2
            move.w  ($14,A6),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w),A3
            movea.l (A3),A1
            lea     (-$38,A6),A0
            move.b  ($28,A1),($31,A0)
            move.b  ($29,A1),($32,A0)
            move.b  ($32,A1),($33,A0)
            _sRsrcInfo
            bne.w   .L6
            move.l  ($2A,A1),D3
            move.l  ($10,A6),D0
            move.b  D0,($32,A0)
            _sFindStruct
            bne.w   .L6
            movea.l (4,A0),A4
            clr.w   D4
            move.b  #4,($32,A0)
            _sReadWord
            bne.b   .L1
            move.w  (2,A0),D4
.L1:
            movea.l (8,A6),A1
            move.w  D4,(A1)
            move.b  #1,($32,A0)
            _sGetBlock
            bne.w   .L6
            movea.l (A0),A1
            add.l   (A1),D3
            move.l  D3,(A2)+
            move.w  (4,A1),D0
            ori.w   #$8000,D0
            move.w  D0,(A2)+
            move.l  (6,A1),(A2)+
            move.l  ($A,A1),(A2)+
            move.w  ($E,A1),(A2)+
            clr.w   (A2)+
            clr.l   (A2)+
            move.l  ($16,A1),(A2)+
            move.l  ($1A,A1),(A2)+
            move.w  ($1E,A1),(A2)+
            move.w  ($20,A1),D5
            move.w  D5,(A2)+
            move.w  ($22,A1),(A2)+
            move.w  ($24,A1),(A2)+
            move.l  ($26,A1),(A2)+
            move.l  A1,(4,A0)
            _sDisposePtr
            move.l  A4,(4,A0)
            cmpi.w  #1,D4
            beq.b   .L3
            cmpi.w  #0,D4
            bne.b   .L4
.L2:
            clr.l   -(SP)
            move.w  D5,-(SP)
            jsr     ([$1660.w])
            move.l  (SP)+,D0
            beq.w   .L5
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  (A2),-(SP)
            jsr     ([$1A14.w])
            jsr     ([$1690.w])
            bra.b   .L5
.L3:
            move.b  #2,($32,A0)
            _sReadPBSize
            bne.b   .L2
            subq.l  #4,(8,A0)
            move.l  (8,A0),D0
            movea.l (A2),A0
            _SetHandleSize
            movea.l (A0),A1
            lea     (-$38,A6),A0
            move.l  A1,(A0)
            _sReadStruct
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            move.l  A4,(4,A0)
            bra.b   .L5
.L4:
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.w  ($24,A0),D0
            mulu.w  ($22,A0),D0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  D0,(A0)
.L5:
            movea.l (A2),A0
            movea.l (A0),A0
            move.w  #$8000,(4,A0)
            addq.w  #4,A2
            clr.l   (A2)+
            nop
.L6:
            movea.l ($C,A6),A0
            move.w  (-$3A,A6),D0
            _HSetState
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$E
            addq.w  #4,SP
            bra.b   .L6
CheckDevices:
            link.w  A6,#-$88
            movem.l D6-D7/A2-A4,-(SP)
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.w  ($14,A0),D0
            btst    #$C,D0
            bne.w   GammaControl.L9
            tst.b   VidType
            beq.w   GammaControl.L9
            clr.l   -(SP)
            move.l  #'scrn',-(SP)
            clr.w   -(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.w   GammaControl.L9
            movea.l DeviceList,A0
            movea.l (A0),A0
            bset    #$C,($14,A0)
            move.l  D0,-(SP)
            movea.l D0,A0
            _HLock
            movea.l (A0),A4
            move.l  A4,(-$88,A6)
            move.w  (A4)+,D7
            lea     (-$78,A6),A0
            move.l  #$30001,($28,A0)
            move.w  #1,($2C,A0)
            move.b  #1,($30,A0)
            clr.b   ($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
.L1:
            lea     (-$78,A6),A0
            _sNextTypesRsrc
            beq.b   .L2
            tst.w   D7
            beq.w   .L9
            bra.b   .L7
.L2:
            move.w  (A4)+,D0
            cmp.w   ($2E,A0),D0
            bne.b   .L7
            move.w  (A4)+,D0
            cmp.b   ($31,A0),D0
            bne.b   .L7
            move.w  ($26,A0),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w),A3
            movea.l (A3),A1
            move.l  ($2A,A1),D0
            cmp.l   (A4)+,D0
            bne.b   .L7
            movea.l DeviceList,A3
            move.w  ($26,A0),D1
.L3:
            movea.l (A3),A1
            cmp.w   (A1),D1
            beq.b   .L4
            move.l  ($1E,A1),D0
            movea.l D0,A3
            bne.b   .L3
            bra.b   .L7
.L4:
            lea     ($A,A4),A4
            move.w  (4,A4),D0
            sub.w   (A4),D0
            cmp.w   ($26,A1),D0
            bne.b   .L7
            move.w  (6,A4),D0
            sub.w   (2,A4),D0
            cmp.w   ($28,A1),D0
            bne.b   .L7
            addq.w  #8,A4
            move.w  (A4)+,D0
            bra.b   .L6
.L5:
            move.l  (A4)+,D1
            adda.w  D1,A4
.L6:
            dbra    D0,.L5
            subq.w  #1,D7
            bmi.b   .L7
            bra.w   .L1
.L7:
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.w  ($28,A0),D1
.L8:
            move.l  ($1E,A0),D0
            beq.w   GammaControl.L8
            movea.l D0,A0
            movea.l (A0),A0
            add.w   D1,($24,A0)
            add.w   D1,($28,A0)
            movea.l ($16,A0),A1
            movea.l (A1),A1
            add.w   D1,(8,A1)
            add.w   D1,($C,A1)
            move.w  ($28,A0),D1
            bra.b   .L8
.L9:
            jsr     ([$F48.w])
            move.b  #1,CrsrBusy
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            move.l  ($22,A0),D0
            sub.w   D0,($832).w
            swap    D0
            sub.w   D0,Mouse
            move.l  Mouse,MTemp
            move.l  Mouse,RawMouse
            movea.l (-$88,A6),A4
            move.w  (A4)+,D7
            subq.w  #1,D7
.L10:
            lea     (-$78,A6),A0
            move.l  #$30001,($28,A0)
            move.w  #1,($2C,A0)
            move.w  (A4)+,($2E,A0)
            clr.b   ($30,A0)
            move.w  (A4)+,D0
            move.b  D0,($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
            _sNextTypesRsrc
            bne.w   .L7
            move.w  ($26,A0),D1
            movea.l DeviceList,A3
.L11:
            movea.l (A3),A0
            cmp.w   (A0),D1
            beq.b   .L12
            move.l  ($1E,A0),D0
            movea.l D0,A3
            bne.b   .L11
            bra.w   .L7
.L12:
            move.l  (A4)+,D0
            movea.l (A3),A1
            move.w  ($14,A1),D0
            and.w   (2,A4),D0
            or.w    (4,A4),D0
            bset    #$A,D0
            bset    #$D,D0
            move.w  D0,($14,A1)
            move.w  ($14,A1),D0
            btst    #$B,D0
            beq.b   .L13
            move.l  A3,MainDevice
            move.l  A3,TheGDevice
            move.l  A3,SrcDevice
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            move.l  D0,ScrnBase
            lea     (-$78,A6),A0
            move.w  (A4),D0
            move.b  #$80,($32,A0)
            _sFindStruct
            move.b  #1,($32,A0)
            _sGetBlock
            movea.l (A0),A1
            move.w  (4,A1),ScreenRow
            move.w  ($16,A1),ScrHRes
            move.w  ($1A,A1),ScrVRes
            move.l  A1,(4,A0)
            _sDisposePtr
.L13:
            move.w  D1,-(SP)
            move.w  (A4)+,-(SP)
            clr.w   -(SP)
            move.l  A3,-(SP)
            jsr     ([$16B8.w])
            addq.w  #4,A4
            move.w  (2,A4),D0
            cmpi.w  #$FFFF,D0
            beq.b   GammaControl.L1
            cmpi.w  #$FFFE,D0
            bne.b   .L14
            lea     (-$84,A6),A1
            clr.l   (A1)
            bsr.b   GammaControl
            bra.b   GammaControl.L1
.L14:
            clr.l   -(SP)
            move.l  #'gama',-(SP)
            move.w  D0,-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   GammaControl.L1
            move.l  D0,-(SP)
            movea.l D0,A0
            _HLock
            lea     (-$84,A6),A1
            move.l  (A0),(A1)
            bsr.b   GammaControl
            movea.l (SP),A0
            _HUnlock
            jsr     ([$148C.w])
            bra.b   GammaControl.L1
GammaControl:
            lea     (-$40,A6),A0
            move.l  A1,($1C,A0)
            move.w  #4,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            rts
.L1:
            movea.l (A3),A1
            movea.l ($16,A1),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            cmpi.w  #2,(4,A1)
            beq.w   .L5
            btst    #0,($15,A1)
            bne.b   .L2
            cmpi.w  #2,D0
            ble.b   .L3
            addi.w  #$20,D0
            bra.b   .L4
.L2:
            move.w  D0,D1
            andi.w  #9,D1
            bne.b   .L3
            addi.w  #$40,D0
            bra.b   .L4
.L3:
            move.w  (A4),D1
            cmpi.w  #$FFFF,D1
            bne.w   .L4
            cmpi.w  #$FFFF,(2,A4)
            beq.b   .L5
.L4:
            clr.l   -(SP)
            move.w  D0,-(SP)
            jsr     ([$1660.w])
            move.l  (SP)+,D0
            beq.b   .L5
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  ($2A,A0),-(SP)
            jsr     ([$1A14.w])
            jsr     ([$1690.w])
            movea.l (SP),A0
            _HLock
            lea     (-$84,A6),A1
            movea.l (A0),A0
            clr.w   (4,A1)
            move.w  (6,A0),(6,A1)
            lea     (8,A0),A0
            move.l  A0,(A1)
            lea     (-$40,A6),A0
            move.l  A1,($1C,A0)
            move.w  #3,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            movea.l (SP),A0
            _HUnlock
            movea.l (A3),A1
            move.l  (6,A1),-(SP)
            moveq   #4,D0
            move.w  D0,($A,A1)
            move.w  D0,-(SP)
            jsr     ([$16E4.w])
.L5:
            addq.w  #4,A4
            movea.l (A3),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            addq.w  #6,A1
            lea     ($22,A0),A0
            move.l  (A4)+,D0
            move.l  D0,(A1)+
            move.l  D0,(A0)+
            move.l  (A4),(A1)
            move.l  (A4)+,(A0)+
            move.w  (A4)+,D6
            bra.b   .L7
.L6:
            lea     (-$40,A6),A0
            lea     (4,A4),A1
            move.l  A1,($1C,A0)
            move.w  (A4)+,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            move.w  (A4)+,D0
            adda.w  D0,A4
.L7:
            dbra    D6,.L6
            dbra    D7,CheckDevices.L10
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            move.l  ($22,A0),D0
            add.w   D0,($832).w
            swap    D0
            add.w   D0,Mouse
            move.l  Mouse,MTemp
            move.l  Mouse,RawMouse
            clr.b   CrsrBusy
            jsr     ([$F4C.w])
.L8:
            jsr     ([$148C.w])
.L9:
            movem.l (SP)+,D6-D7/A2-A4
            unlk    A6
            rts
            ds.b    10
GetGDevice:
            movea.l (SP)+,A0
            move.l  TheGDevice,(SP)
            jmp     (A0)
            ds.b    8
SetGDevice:
            movea.l (SP)+,A0
            move.l  (SP)+,TheGDevice
            jmp     (A0)
            ds.b    8
GetDeviceList:
            movea.l (SP)+,A0
            move.l  DeviceList,(SP)
            jmp     (A0)
            ds.b    8
GetMainDevice:
            movea.l (SP)+,A0
            move.l  MainDevice,(SP)
            jmp     (A0)
            ds.b    8
GetNextDevice:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.l  ($1E,A1),(SP)
            jmp     (A0)
            ds.b    4
TestDeviceAttribute:
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            clr.b   (SP)
            movea.l (A0),A0
            move.w  ($14,A0),D1
            btst    D0,D1
            beq.b   .L1
            addq.b  #1,(SP)
.L1:
            jmp     (A1)
            ds.b    10
SetDeviceAttribute:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.w  ($14,A0),D2
            tst.b   D0
            bne.b   .L1
            bclr    D1,D2
            bra.b   .L2
.L1:
            bset    D1,D2
.L2:
            move.w  D2,($14,A0)
            jmp     (A1)
            dc.w    0
GetMaxDevice:
            link.w  A6,#-8
            movem.l D3/A3,-(SP)
            clr.l   ($C,A6)
            moveq   #0,D3
            movea.l DeviceList,A3
.L1:
            movea.l (A3),A0
            tst.w   ($14,A0)
            bpl.b   .L2
            clr.b   -(SP)
            move.l  (8,A6),-(SP)
            pea     ($22,A0)
            pea     (-8,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L2
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            cmp.w   D3,D0
            ble.b   .L2
            move.w  D0,D3
            move.l  A3,($C,A6)
.L2:
            movea.l (A3),A0
            move.l  ($1E,A0),D0
            movea.l D0,A3
            bne.b   .L1
            movem.l (SP)+,D3/A3
            unlk    A6
            rtd     #4
            ds.b    4
GetDevPix:
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            rts
            dc.w    0
