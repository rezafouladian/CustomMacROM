CrsrCore:
InitCrTable:
            dc.w    $02F0,$0322,$0362,$0AC0,$0AD0,$0310,$052A,$02E2
            dc.w    $05F0,$03C4
CrsrVBLTask:
            tst.b   CrsrNew
            beq.w   .L19
            tst.b   CrsrBusy
            bne.w   .L19
            tst.b   CrsrCouple
            beq.w   .L20
            move.w  ($82A).w,D0
            sub.w   ($82E).w,D0
            move.w  MTemp,D1
            sub.w   RawMouse,D1
            move.w  D0,D2
            bge.b   .L1
            neg.w   D2
.L1:
            move.w  D1,D3
            bge.b   .L2
            neg.w   D3
.L2:
            movea.l MickeyBytes,A0
            cmp.w   D2,D3
            bls.b   .L3
            exg     D2,D3
.L3:
            asr.w   #1,D3
            add.w   D2,D3
            bne.b   .L4
            move.w  #1,(A0)
            clr.w   ($12,A0)
            bra.w   .L15
.L4:
            movem.l D4-D5,-(SP)
            move.w  (A0),D4
            cmp.w   (2,A0),D4
            bge.b   .L5
            addq.w  #1,(A0)
.L5:
            move.w  D3,D5
            move.w  D4,D2
            subq.w  #1,D2
            asl.w   #1,D2
            jmp     .L6(PC,D2.w)
.L6:
            bra.b   .L7
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            add.w   (4,A0),D5
.L26:
            add.w   (6,A0),D5
            move.w  (6,A0),(4,A0)
.L25:
            add.w   (8,A0),D5
            move.w  (8,A0),(6,A0)
.L24:
            add.w   ($A,A0),D5
            move.w  ($A,A0),(8,A0)
.L23:
            add.w   ($C,A0),D5
            move.w  ($C,A0),($A,A0)
.L22:
            add.w   ($E,A0),D5
            move.w  ($E,A0),($C,A0)
.L21:
            add.w   ($10,A0),D5
            move.w  ($10,A0),($E,A0)
.L7:
            move.w  D3,($10,A0)
            move.w  D4,D2
            asr.w   #1,D2
            add.w   D2,D5
            ext.l   D5
            divu.w  D4,D5
            move.w  D3,D4
            sub.w   D5,D3
            add.w   ($12,A0),D3
            cmpi.w  #$FFFF,D3
            bne.b   .L8
            clr.w   D3
.L8:
            asr.w   #1,D3
            move.w  D3,($12,A0)
            add.w   D5,D3
            cmpi.w  #$FF,D5
            bls.b   .L9
            move.b  #$FF,D5
.L9:
            movea.l MickeyBytes,A0
            lea     ($14,A0),A0
            clr.w   D2
.L10:
            addq.b  #1,D2
            cmp.b   (A0)+,D5
            bhi.b   .L10
            muls.w  D2,D3
            muls.w  D3,D0
            divs.w  D4,D0
            bmi.b   .L11
            andi.w  #$7F,D0
            bra.b   .L12
.L11:
            ori.w   #$FF80,D0
.L12:
            muls.w  D3,D1
            divs.w  D4,D1
            bmi.b   .L13
            andi.w  #$7F,D1
            bra.b   .L14
.L13:
            ori.w   #$FF80,D1
.L14:
            movem.l (SP)+,D4-D5
            add.w   D0,($82E).w
            add.w   D1,RawMouse
.L15:
            lea     CrsrPin,A0
            move.l  RawMouse,D0
            bsr.b   ScrnPin
            move.l  D0,RawMouse
            move.l  D0,MTemp
            and.l   MouseMask,D0
            move.l  MouseOffset,D1
            beq.b   .L16
            add.l   D1,D0
            bsr.b   ScrnPin
.L16:
            move.l  D0,Mouse
.L17:
            bsr.w   ERASECURSOR
.L18:
            clr.b   CrsrNew
            clr.b   CrsrObscure
            bsr.w   DRAWCURSOR
            rts
.L19:
            movea.l MickeyBytes,A0
            move.w  #1,(A0)
            clr.w   ($12,A0)
            rts
.L20:
            movea.l MickeyBytes,A0
            move.w  #1,(A0)
            clr.w   ($12,A0)
            bra.b   .L17
ScrnPin:
            cmp.w   (2,A0),D0
            bge.b   .L1
            bsr.b   FindScreen
            move.w  (2,A0),D0
.L1:
            cmp.w   (6,A0),D0
            blt.b   .L2
            bsr.b   FindScreen
            move.w  (6,A0),D0
            subq.w  #1,D0
.L2:
            swap    D0
            cmp.w   (A0),D0
            bge.b   .L3
            swap    D0
            bsr.b   FindScreen
            swap    D0
            move.w  (A0),D0
.L3:
            cmp.w   (4,A0),D0
            blt.b   .L4
            swap    D0
            bsr.b   FindScreen
            swap    D0
            move.w  (4,A0),D0
            subq.w  #1,D0
.L4:
            swap    D0
            rts
FindScreen:
            move.w  D0,D3
            move.l  D0,D1
            swap    D1
            move.l  DeviceList,D2
            bmi.b   .L3
.L1:
            movea.l D2,A3
            movea.l (A3),A3
            tst.w   ($14,A3)
            bpl.b   .L2
            lea     ($22,A3),A1
            cmp.w   (A1)+,D1
            blt.b   .L2
            cmp.w   (A1)+,D3
            blt.b   .L2
            cmp.w   (A1)+,D1
            bge.b   .L2
            cmp.w   (A1)+,D3
            blt.b   .L4
.L2:
            move.l  ($1E,A3),D2
            bne.b   .L1
.L3:
            rts
.L4:
            movea.l CrsrPtr,A0
            movea.l (A0),A0
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            move.w  ($3A,A0),($30,A1)
            move.w  ($4C,A0),($2E,A1)
            bsr.w   ERASECURSOR
            swap    D3
            move.w  D1,D3
            swap    D3
            move.l  D3,MTemp
            move.l  D3,RawMouse
            move.l  D3,Mouse
            move.l  D2,CrsrDevice
            movea.l A3,A1
            jsr     SetCrsrData
            move.w  (A3),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A0
            movea.l (0,A0,D0.w),A3
            movea.l (A3),A0
            moveq   #0,D0
            move.b  ($28,A0),D0
            _AttachVBL
            addq.w  #8,SP
            bra.w   CrsrVBLTask.L18
PinGuts:
            cmp.w   (2,A0),D0
            bge.b   .L1
            move.w  (2,A0),D0
.L1:
            cmp.w   (6,A0),D0
            blt.b   .L2
            move.w  (6,A0),D0
            subq.w  #1,D0
.L2:
            swap    D0
            cmp.w   (A0),D0
            bge.b   .L3
            move.w  (A0),D0
.L3:
            cmp.w   (4,A0),D0
            blt.b   .L4
            move.w  (4,A0),D0
            subq.w  #1,D0
.L4:
            swap    D0
            rts
PinRect:
            move.l  (4,SP),D0
            movea.l (8,SP),A0
            bsr.b   PinGuts
            movea.l (SP)+,A0
            addq.w  #8,SP
            move.l  D0,(SP)
            jmp     (A0)
CURSORSECT:
            movem.l D0/A0-A1,-(SP)
            tst.w   ($D4C).w
            beq.b   .L1
            lea     CrsrRect,A0
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            lea     ($22,A1),A1
            move.w  ($D48).w,D0
            sub.w   (A1),D0
            cmp.w   (A0)+,D0
            blt.b   .L1
            move.w  ($D4A).w,D0
            sub.w   (2,A1),D0
            cmp.w   (A0)+,D0
            ble.b   .L1
            move.w  ($D44).w,D0
            sub.w   (A1),D0
            cmp.w   (A0)+,D0
            bge.b   .L1
            move.w  ($D46).w,D0
            sub.w   (2,A1),D0
            cmp.w   (A0),D0
            bge.b   .L1
            moveq   #1,D0
            bra.b   .L2
.L1:
            clr.w   D0
.L2:
            movem.l (SP)+,D0/A0-A1
            rts
            move.b  #1,CrsrBusy
            move.b  #1,CrsrObscure
            bra.b   ERASECURSOR
            move.b  #1,CrsrBusy
            subq.w  #1,CrsrState
ERASECURSOR:
            move.b  #1,CrsrBusy
            tst.b   CrsrVis
            beq.b   .L1
            bsr.w   UNBLITCURSOR
.L1:
            clr.b   CrsrBusy
            rts
            move.b  #1,CrsrBusy
            clr.b   CrsrObscure
            clr.w   CrsrState
            clr.w   ($D4C).w
            move.b  #1,CrsrBusy
            tst.w   ($D4C).w
            beq.b   .L2
            subq.w  #1,($D4C).w
            bra.b   DRAWCURSOR
.L2:
            addq.w  #1,CrsrState
            clr.b   CrsrObscure
DRAWCURSOR:
            move.b  #1,CrsrBusy
            tst.w   CrsrState
            bmi.b   .L1
            clr.w   CrsrState
            tst.b   CrsrVis
            bne.b   .L1
            tst.b   CrsrObscure
            bne.b   .L1
            bsr.w   BLITCURSOR
.L1:
            clr.b   CrsrBusy
            rts
            tst.w   ($D4C).w
            beq.b   .L6
            movem.l D0/A0,-(SP)
            lea     ($D4A).w,A0
            move.l  ($C,SP),D0
            cmp.w   (A0),D0
            ble.b   .L2
            move.w  D0,(A0)
.L2:
            swap    D0
            cmp.w   -(A0),D0
            ble.b   .L3
            move.w  D0,(A0)
.L3:
            move.l  ($10,SP),D0
            cmp.w   -(A0),D0
            bge.b   .L4
            move.w  D0,(A0)
.L4:
            swap    D0
            cmp.w   -(A0),D0
            bge.b   .L5
            move.w  D0,(A0)
.L5:
            movem.l (SP)+,D0/A0
            bra.b   .L7
.L6:
            move.l  (4,SP),($D48).w
            move.l  (8,SP),($D44).w
.L7:
            addq.w  #1,($D4C).w
            move.b  #1,CrsrBusy
            bsr.w   CURSORSECT
            beq.b   .L8
            bsr.w   ERASECURSOR
.L8:
            clr.b   CrsrBusy
            move.l  (SP)+,(SP)
            move.l  (SP)+,(SP)
            rts
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($18,SP),A2
            movea.l A2,A0
            _HGetState
            move.w  D0,-(SP)
            movea.l A2,A0
            _HLock
            movea.l (A2),A2
            movea.l ([CrsrPtr.w]),A3
            move.l  ($5C,A2),D0
            cmpi.w  #$8001,(A3)
            bne.b   .L9
            cmp.l   ($36,A3),D0
            beq.w   .L18
.L9:
            move.b  #1,CrsrBusy
            move.l  D0,($36,A3)
            lea     ($14,A2),A0
            lea     TheCrsr,A1
            moveq   #$10,D0
.L10:
            move.l  (A0)+,(A1)+
            dbra    D0,.L10
            lea     ($14,A2),A0
            lea     ($16,A3),A1
            moveq   #7,D0
.L11:
            move.l  (A0)+,(A1)+
            dbra    D0,.L11
            move.w  (A2),(A3)
            move.l  (2,A2),-(SP)
            move.l  (2,A3),-(SP)
            jsr     ([$1614.w])
            move.l  (6,A2),-(SP)
            move.l  (6,A3),-(SP)
            jsr     ([$1A14.w])
            move.l  DeviceList,D4
            movea.l D4,A4
.L12:
            movea.l (A4),A4
            tst.w   ($14,A4)
            bpl.w   .L17
            movea.l ($16,A4),A0
            movea.l (A0),A0
            move.w  ($20,A0),D3
            clr.w   ($30,A4)
            move.w  ($E,A2),D0
            beq.b   .L13
            cmp.w   D3,D0
            bne.b   .L13
            move.w  D0,($30,A4)
            move.l  ($A,A2),-(SP)
            move.l  ($A,A3),-(SP)
            jsr     ([$1A14.w])
            bra.b   .L17
.L13:
            cmpi.w  #$8001,(A3)
            bne.b   .L16
            cmpi.w  #2,D3
            ble.b   .L16
            move.w  D3,($30,A4)
            move.l  ($32,A4),($A,A3)
            move.l  TheGDevice,-(SP)
            move.l  D4,TheGDevice
            move.l  CrsrPtr,-(SP)
            jsr     ([$1A4C.w])
            move.l  (SP)+,TheGDevice
            move.w  D3,D0
            moveq   #0,D1
.L14:
            lsr.w   #1,D0
            bcs.b   .L15
            addq.w  #1,D1
            bra.b   .L14
.L15:
            lea     ($864).w,A0
            movea.l ([$36.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D0
            lsl.w   D1,D0
            adda.w  D0,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D1.w*4),A3
            moveq   #0,D0
            jsr     (A3)
            movea.l ([CrsrPtr.w]),A3
.L16:
            move.w  ($30,A4),D0
            add.w   D0,D0
            move.w  D0,($2E,A4)
.L17:
            move.l  ($1E,A4),D4
            movea.l D4,A4
            bne.w   .L12
            bsr.b   GetMainCrsr
            bsr.w   ERASECURSOR
            bsr.w   DRAWCURSOR
.L18:
            clr.b   CrsrBusy
            move.w  (SP)+,D0
            movea.l ($18,SP),A0
            _HSetState
            movem.l (SP)+,D3-D4/A2-A4
            move.l  (SP)+,(SP)
            rts
GetMainCrsr:
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            movea.l CrsrPtr,A1
            movea.l (A1),A1
            move.l  ($32,A0),($A,A1)
            move.l  ($36,A0),($E,A1)
            move.w  ($30,A0),($3A,A1)
            move.w  ($2E,A0),($4C,A1)
            rts
            movea.l ([CrsrPtr.w]),A0
            move.b  #1,CrsrBusy
            move.w  #$8000,(A0)
            movea.l (8,SP),A0
            lea     TheCrsr,A1
            moveq   #$F,D2
            moveq   #0,D1
.L1:
            move.l  (A0)+,D0
            cmp.l   (A1),D0
            beq.b   .L2
            addq.w  #1,D1
.L2:
            move.l  D0,(A1)+
            dbra    D2,.L1
            move.l  ($E,SP),D0
            moveq   #$10,D2
            cmp.w   D2,D0
            bls.b   .L3
            move.w  D2,D0
.L3:
            swap    D0
            cmp.w   D2,D0
            bls.b   .L4
            move.w  D2,D0
.L4:
            swap    D0
            cmp.l   ($884).w,D0
            beq.b   .L5
            addq.w  #1,D1
            move.l  D0,($884).w
.L5:
            clr.b   CrsrBusy
            tst.w   D1
            beq.b   .L6
            bsr.w   ERASECURSOR
            bsr.w   DRAWCURSOR
.L6:
            movea.l (SP)+,A0
            lea     ($E,SP),SP
            jmp     (A0)
            dc.w    0
SetCrsrData:
            movea.l CrsrPtr,A0
            movea.l (A0),A0
            move.l  ($32,A1),($A,A0)
            move.l  ($36,A1),($E,A0)
            move.w  ($30,A1),($3A,A0)
            move.w  ($2E,A1),($4C,A0)
            lea     ($22,A1),A0
            move.l  (A0)+,CrsrPin
            move.l  (A0),($838).w
            movea.l ($16,A1),A0
            movea.l (A0),A0
            move.w  ($20,A0),ChunkyDepth
            move.l  (A0)+,CRSRBASE
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            move.w  D0,CRSRROW
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,ColLines
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,RowBits
            rts
            ds.b    4
AllocCrsr:
            movem.l D0-D6/A0-A4/A6,-(SP)
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            bsr.w   ERASECURSOR
            move.b  #1,CrsrBusy
            move.l  CrsrPtr,D0
            cmp.l   MinusOne,D0
            bne.b   .L2
            clr.b   CrsrObscure
            clr.w   CrsrState
            clr.w   ($D4C).w
            moveq   #$50,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,CrsrPtr
            movea.l (A0),A4
            moveq   #$32,D0
            _ResrvMem
            clr.l   -(SP)
            jsr     ([$160C.w])
            movea.l (SP)+,A0
            move.l  A0,(2,A4)
            _HLock
            moveq   #2,D0
            jsr     RNewHandle
            move.l  A0,(6,A4)
            move.l  #$400,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,($12,A4)
            move.w  #$8000,(A4)
            clr.w   ($3A,A4)
            movea.l (A5),A0
            lea     (-$6C,A0),A0
            lea     TheCrsr,A1
            moveq   #$10,D0
.L1:
            move.l  (A0)+,(A1)+
            dbra    D0,.L1
.L2:
            movea.l CrsrPtr,A4
            movea.l (A4),A4
            move.l  DeviceList,D4
            movea.l D4,A6
.L3:
            movea.l (A6),A6
            tst.w   ($14,A6)
            bpl.w   .L7
            tst.w   ($30,A6)
            bne.b   .L4
            movea.l ($32,A6),A0
            _DisposHandle
            move.l  #$400,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,($32,A6)
            movea.l ($36,A6),A0
            _DisposHandle
            bsr.w   GETLOWHANDLE
            move.l  A0,($36,A6)
.L4:
            movea.l ($16,A6),A0
            movea.l (A0),A0
            move.w  ($20,A0),D3
            cmp.w   ($30,A6),D3
            beq.b   .L7
            move.w  D3,D0
            moveq   #0,D6
.L5:
            lsr.w   #1,D0
            bcs.b   .L6
            addq.w  #1,D6
            bra.b   .L5
.L6:
            cmpi.w  #$8001,(A4)
            bne.b   .L7
            cmpi.w  #2,D3
            ble.b   .L7
            move.l  ($32,A6),($A,A4)
            move.l  TheGDevice,-(SP)
            move.l  D4,TheGDevice
            move.l  CrsrPtr,-(SP)
            jsr     ([$1A4C.w])
            move.l  (SP)+,TheGDevice
            lea     ($864).w,A0
            movea.l ([$36.w,A6]),A1
            movea.l A1,A2
            move.w  #$20,D0
            lsl.w   D6,D0
            adda.w  D0,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D6.w*4),A3
            moveq   #0,D0
            jsr     (A3)
            move.w  D3,($30,A6)
            add.w   D3,D3
            move.w  D3,($2E,A6)
.L7:
            move.l  ($1E,A6),D4
            movea.l D4,A6
            bne.w   .L3
            bsr.w   GetMainCrsr
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            jsr     SetCrsrData
            move.l  (SP)+,TheZone
            clr.b   CrsrBusy
            bsr.w   DRAWCURSOR
            movem.l (SP)+,D0-D6/A0-A4/A6
            rts
GETLOWHANDLE:
            move.l  D1,D0
            _ResrvMem
            bne.b   .L1
            move.l  D1,D0
            _NewHandleClear
            _HLock
            rts
.L1:
            moveq   #$19,D0
            jsr     ([$1524.w])
            _Debugger
            dc.w    0
BLITCURSOR:
            tst.l   CrsrPtr
            bmi.w   .L35
            movem.l D0-D7/A0-A6,-(SP)
            lea     TheCrsr,A2
            lea     ShftTbl,A0
            move.w  ChunkyDepth,D1
            moveq   #0,D7
            move.b  (0,A0,D1.w),D7
            movea.l ([CrsrPtr.w]),A4
            cmpi.w  #$8001,(A4)
            bne.b   .L1
            cmp.w   ($3A,A4),D1
            beq.w   .L10
            cmpi.w  #2,D1
            bgt.w   .L9
            bra.b   .L6
.L1:
            lea     ($16,A4),A0
            movea.l A2,A1
            moveq   #7,D0
.L2:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L3
            dbra    D0,.L2
            cmp.w   ($3A,A4),D1
            beq.w   .L10
.L3:
            movea.l DeviceList,A0
.L4:
            movea.l (A0),A0
            tst.w   ($14,A0)
            bpl.b   .L5
            clr.w   ($30,A0)
.L5:
            move.l  ($1E,A0),D0
            movea.l D0,A0
            bne.b   .L4
.L6:
            lea     ($16,A4),A0
            movea.l A2,A1
            moveq   #7,D0
.L7:
            move.l  (A1)+,(A0)+
            dbra    D0,.L7
            move.w  D1,($3A,A4)
            add.w   D1,D1
            move.w  D1,($4C,A4)
            movea.l A2,A0
            movea.l ([$A.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D5
            lsl.w   D7,D5
            adda.w  D5,A2
            move.w  D7,D0
            cmpi.w  #4,D0
            blt.b   .L8
            addq.w  #2,D0
.L8:
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D0.w*4),A3
            moveq   #0,D0
            jsr     (A3)
.L9:
            lea     ($864).w,A0
            movea.l ([$E.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D5
            lsl.w   D7,D5
            adda.w  D5,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D7.w*4),A3
            moveq   #0,D0
            jsr     (A3)
.L10:
            move.l  ([$A.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A2
            move.l  ([$E.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A3
            moveq   #$10,D5
            move.w  Mouse,D2
            sub.w   CrsrPin,D2
            sub.w   ($884).w,D2
            move.w  D2,D3
            add.w   D5,D3
            cmp.w   D5,D3
            bge.b   .L11
            neg.w   D2
            cmp.w   D5,D2
            beq.w   .L34
            mulu.w  ($4C,A4),D2
            adda.l  D2,A2
            adda.l  D2,A3
            moveq   #0,D2
.L11:
            move.w  ColLines,D4
            cmp.w   D4,D3
            ble.b   .L12
            move.w  D4,D3
.L12:
            moveq   #0,D6
            move.w  ($832).w,D0
            sub.w   ($836).w,D0
            sub.w   ($886).w,D0
            move.w  D0,D1
            add.w   D5,D1
            cmp.w   D5,D1
            bge.b   .L13
            sub.w   D0,D6
            moveq   #0,D0
.L13:
            move.w  RowBits,D4
            cmp.w   D4,D1
            ble.b   .L14
            move.w  D4,D1
.L14:
            movea.l CRSRBASE,A5
            movea.w CRSRROW,A0
            move.w  A0,D4
            mulu.w  D2,D4
            adda.l  D4,A5
            ext.l   D0
            lsl.l   D7,D0
            move.l  D0,D4
            andi.l  #$FFFFFFE0,D4
            move.l  D4,D5
            asr.l   #3,D5
            adda.l  D5,A5
            lea     CrsrRect,A1
            move.w  D2,(A1)+
            move.l  D4,D5
            lsr.l   D7,D5
            move.w  D5,(A1)+
            move.w  D3,(A1)+
            move.w  D5,(A1)
            andi.w  #$1F,D0
            lsl.w   D7,D6
            sub.w   D0,D6
            ext.l   D1
            lsl.l   D7,D1
            move.l  D1,D5
            sub.l   D4,D5
            ble.w   .L34
            subq.w  #1,D5
            lsr.l   #5,D5
            sub.w   D2,D3
            subq.w  #1,D3
            move.l  D5,D2
            addq.l  #1,D2
            lsl.l   #2,D2
            suba.l  D2,A0
            lsl.l   #3,D2
            lsr.l   D7,D2
            add.w   D2,(A1)
            bsr.w   CURSORSECT
            bne.w   .L34
            moveq   #-1,D4
            lsr.l   D0,D4
            moveq   #-1,D2
            andi.w  #$1F,D1
            beq.b   .L15
            lsr.l   D1,D2
            not.l   D2
.L15:
            lea     ($4C,A4),A6
            movea.w (A6),A1
            move.l  ([$12.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A4
            movem.l D3/D5/A0/A5,-(A6)
            moveq   #1,D0
            movem.l A0-A2,-(SP)
            jsr     ([$574.w])
            movem.l (SP)+,A0-A2
            move.b  D0,-(SP)
            movea.l D5,A6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  D4,-(SP)
            cmpi.w  #4,D7
            bge.w   .L19
            tst.w   D5
            bra.b   .L18
.L16:
            and.l   D2,D4
.L17:
            bfextu  (A2){D6:0},D0
            bfextu  (A3){D6:0},D1
            addi.l  #$20,D6
            and.l   D4,D0
            and.l   D4,D1
            move.l  D0,D7
            and.l   D1,D7
            not.l   D1
            move.l  (A5),D4
            move.l  D4,(A4)+
            and.l   D1,D0
            and.l   D4,D1
            or.l    D7,D1
            eor.l   D0,D1
            move.l  D1,(A5)+
            moveq   #-1,D4
            subq.w  #1,D5
.L18:
            bgt.b   .L17
            beq.b   .L16
            move.l  (4,SP),D6
            move.l  (SP),D4
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L18
            bra.w   .L33
.L19:
            bgt.b   .L29
            swap    D4
            addq.w  #1,D5
            add.w   D5,D5
            move.w  D5,D0
            subq.w  #2,D5
            movea.w D5,A6
            moveq   #-1,D7
            lsr.w   #1,D7
            add.w   D0,D0
            suba.w  D0,A1
            asr.w   #3,D6
            adda.w  D6,A2
            adda.w  D6,A3
.L20:
            tst.w   D4
            bne.b   .L21
            move.w  (A5)+,(A4)+
            addq.w  #2,A2
            addq.w  #2,A3
            bra.b   .L24
.L21:
            move.w  (A2)+,D0
            move.w  (A5),D1
            move.w  D1,(A4)+
            tst.w   (A3)+
            bne.b   .L22
            not.w   D0
            and.w   D7,D0
            beq.b   .L23
            eor.w   D1,D0
.L22:
            move.w  D0,(A5)
.L23:
            addq.w  #2,A5
.L24:
            dbra    D5,.L21
            tst.w   D2
            bne.b   .L25
            move.w  (A5)+,(A4)+
            addq.w  #2,A2
            addq.w  #2,A3
            bra.b   .L28
.L25:
            move.w  (A2)+,D0
            move.w  (A5),D1
            move.w  D1,(A4)+
            tst.w   (A3)+
            bne.b   .L26
            not.w   D0
            and.w   D7,D0
            beq.b   .L27
            eor.w   D1,D0
.L26:
            move.w  D0,(A5)
.L27:
            addq.w  #2,A5
.L28:
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L20
            bra.b   .L33
.L29:
            moveq   #-1,D4
            lsr.l   #8,D4
            move.w  D5,D0
            addq.w  #1,D0
            lsl.w   #2,D0
            suba.w  D0,A1
            asr.w   #3,D6
            adda.w  D6,A2
            adda.w  D6,A3
.L30:
            move.l  (A2)+,D0
            move.l  (A5),D1
            move.l  D1,(A4)+
            tst.l   (A3)+
            bne.b   .L31
            not.l   D0
            and.l   D4,D0
            beq.b   .L32
            eor.l   D1,D0
.L31:
            move.l  D0,(A5)
.L32:
            addq.w  #4,A5
            dbra    D5,.L30
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L30
.L33:
            addq.w  #8,SP
            move.b  #1,CrsrVis
            moveq   #0,D0
            move.b  (SP)+,D0
            jsr     ([$574.w])
.L34:
            movem.l (SP)+,D0-D7/A0-A6
.L35:
            rts
            ds.b    10
UNBLITCURSOR:
            tst.l   CrsrPtr
            bmi.b   .L2
            movem.l D1-D4/A0-A2,-(SP)
            movea.l ([CrsrPtr.w]),A0
            movea.l ($12,A0),A1
            move.l  (A1),D0
            jsr     ([$644.w])
            movea.l D0,A1
            lea     ($3C,A0),A0
            movem.l (A0)+,D2-D4/A2
            moveq   #1,D0
            movem.l D2/A1-A2,-(SP)
            jsr     ([$574.w])
            movem.l (SP)+,D2/A1-A2
            movea.l D3,A0
.L1:
            move.l  (A1)+,(A2)+
            dbra    D3,.L1
            move.l  A0,D3
            adda.w  D4,A2
            dbra    D2,.L1
            jsr     ([$574.w])
            clr.b   CrsrVis
            movem.l (SP)+,D1-D4/A0-A2
.L2:
            rts
            ds.b    10
ScrnAddress:
            move.l  ScrnBase,(4,SP)
            rts
            ds.b    8
ScrnSize:
            move.l  (SP)+,D0
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.w  ($26,A0),D1
            sub.w   ($22,A0),D1
            move.w  D1,(A1)
            movea.l (SP)+,A1
            move.w  ($28,A0),D1
            sub.w   ($24,A0),D1
            move.w  D1,(A1)
            movea.l D0,A0
            jmp     (A0)
            ds.b    12
ScrnBitMap:
            move.l  (SP)+,D0
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,D1
            andi.w  #$7FFF,D1
            move.w  D1,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l D0,A0
            jmp     (A0)
            ds.b    14
