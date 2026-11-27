            include "Include/ROMHeader.s"

            EXPORT  SMGRPOSTMUNGING,SMGRCALCRECT,SwapIcon,FIXSMGRWORLD,SwapKybd,SMGRINITFONTS

            IMPORT  STDUNLINK,A

            SECTION "ScriptMgrMisc",CODE

SwapIcon:
            movea.l IntlSpec,A0
            movea.l ($1F4,A0),A0
            jmp     (A0)
XSwapIcon:
            link.w  A6,#-8
            movem.l A2-A3,-(SP)
            move.l  MenuList,D0
            beq.w   .L3
            tst.w   MBarHeight
            ble.w   .L3
            movea.l IntlSpec,A3
            move.l  ($A,A3),D0
            btst    #$1F,D0
            bne.b   .L1
            cmpi.b  #1,(4,A3)
            ble.b   .L3
.L1:
            pea     (-4,A6)
            _GetPort
            movea.l WMgrPort,A2
            move.l  A2,-(SP)
            _SetPort
            move.l  ($1C,A2),(-8,A6)
            movea.l (A5),A0
            move.l  (-$82,A0),($1C,A2)
            subq.w  #4,SP
            move.l  #'SICN',-(SP)
            move.w  ($2A,A3),D0
            lsl.w   #2,D0
            movea.l ($72,A3,D0.w),A0
            move.w  ($1E,A0),-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L2
            move.l  D0,-(SP)
            movea.l D0,A0
            _HLock
            lea     ($A0E).w,A1
            move.l  (A0),(A1)
            move.w  #2,(4,A1)
            clr.l   (6,A1)
            move.l  #$100010,($A,A1)
            move.l  A1,-(SP)
            pea     (2,A2)
            pea     (6,A1)
            pea     ($2C,A3)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            movea.l (SP)+,A0
            _HUnlock
.L2:
            move.l  (-8,A6),($1C,A2)
            move.l  (-4,A6),-(SP)
            _SetPort
.L3:
            movem.l (SP)+,A2-A3
            unlk    A6
            rts
SwapKybd:
            movea.l IntlSpec,A0
            movea.l ($1F8,A0),A0
            jmp     (A0)
XSwapKybd:
            link.w  A6,#0
            movem.l D4/A2-A3,-(SP)
            movea.l ExpandMem,A3
            movea.l ($E,A3),A3
            subq.l  #4,SP
            move.l  #'KCHR',-(SP)
            movea.l IntlSpec,A0
            move.w  ($2A,A0),D0
            lsl.w   #2,D0
            movea.l ($72,A0,D0.w),A0
            move.w  ($1C,A0),-(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (SP)+,A2
            move.l  A2,D0
            beq.b   .L3
            movea.l A2,A0
            _HLock
            move.l  (A2),-(SP)
            jsr     sub_4081E00E
            movea.l A2,A0
            _GetHandleSize
            move.l  D0,D4
            movea.l A3,A0
            _GetPtrSize
            cmp.l   D0,D4
            blt.b   .L1
            move.l  D4,D0
            _NewHandle sys
            bne.b   .L2
            _DisposHandle
            movea.l A3,A0
            _DisposPtr
            move.l  D4,D0
            _NewPtrSysClear
            movea.l A0,A3
.L1:
            movea.l (A2),A0
            movea.l A3,A1
            move.l  D4,D0
            _BlockMove
.L2:
            move.l  A3,-(SP)
            jsr     sub_4081E00E
            movea.l A2,A0
            _HUnlock
            moveq   #$38,D0
            _FlushEvents
.L3:
            movem.l (SP)+,D4/A2-A3
            unlk    A6
            rts
sub_4081E00E:
            link.w  A6,#-$E
            movem.l D3,-(SP)
            movea.l ExpandMem,A0
            clr.l   ($A,A0)
            move.l  (8,A6),($E,A0)
            movea.l ROMBase,A0
            tst.b   (8,A0)
            beq.b   .L3
            move.w  HWCfgFlags,D0
            btst    #$A,D0
            beq.b   .L3
            _CountADBs
            move.w  D0,D3
            bra.b   .L2
.L1:
            move.w  D3,D0
            addq.w  #1,D0
            lea     (-$A,A6),A0
            _GetIndADB
            cmpi.b  #2,(-9,A6)
            bne.b   .L2
            movea.l (-4,A6),A0
            clr.w   ($18,A0)
            lea     ($14,A0),A0
            move.l  (A0),(-$E,A6)
            move.l  (8,A6),(A0)
.L2:
            dbra    D3,.L1
            movea.l ExpandMem,A1
            lea     ($16,A1),A1
            tst.b   (A1)
            bne.b   .L3
            st      (A1)
            movea.l (-$E,A6),A0
            _RecoverHandle
            tst.w   MemErr
            bne.b   .L3
            _DisposHandle
.L3:
            movem.l (SP)+,D3
            move.w  #4,D0
            bra.w   STDUNLINK
FIXSMGRWORLD:
            movea.l IntlSpec,A0
            movea.l ($1FC,A0),A0
            jmp     (A0)
XFIXSMGRWORLD:
            movem.l D3/A2-A4,-(SP)
            movea.l IntlSpec,A4
            subq.l  #4,SP
            move.l  #'KSWP',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,($36,A4)
            move.w  #$3FFF,D3
            subq.w  #4,SP
            move.l  #'FOND',-(SP)
            move.w  D3,-(SP)
            _GetResource
            tst.l   (SP)+
            bne.b   .L1
            clr.w   D3
.L1:
            movea.l ($72,A4),A0
            move.w  D3,(8,A0)
            subq.w  #4,SP
            move.l  #'itlc',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (A0),D1
            move.w  D1,($26,A4)
            move.w  D1,($2A,A4)
            move.l  D0,-(SP)
            _ReleaseResource
.L2:
            sf      (4,A4)
            move.w  #$40,D3
.L3:
            move.w  D3,D0
            lsl.w   #2,D0
            move.l  ($72,A4,D0.w),D0
            beq.b   .L4
            movea.l D0,A3
            sf      (4,A3)
            subq.l  #4,SP
            move.l  #'itlb',-(SP)
            move.w  D3,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L4
            movea.l D0,A2
            movea.l (A2),A0
            lea     ($C,A3),A1
            moveq   #$14,D0
            _BlockMove
            move.l  A2,-(SP)
            _ReleaseResource
            st      (4,A3)
            addq.b  #1,(4,A4)
.L4:
            dbra    D3,.L3
            move.w  ($26,A4),D3
            move.w  D3,D0
            lsl.w   #2,D0
            move.l  ($72,A4,D0.w),D0
            beq.b   .L5
            movea.l D0,A3
            tst.b   (4,A3)
            bne.b   .L6
.L5:
            moveq   #0,D3
            movea.l ($72,A4),A3
            move.w  D3,($26,A4)
            move.w  D3,($2A,A4)
.L6:
            movea.l IntlSpec,A0
            move.b  (6,A0),-(SP)
            sf      (6,A0)
            clr.w   -(SP)
            move.w  SysFontFam,-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D3
            beq.b   .L7
            move.w  (8,A3),SysFontFam
            move.w  #$FFFE,CurFMInput
.L7:
            clr.w   -(SP)
            move.w  ApFontID,-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D3
            beq.b   .L8
            move.w  ($A,A3),ApFontID
            move.w  #$FFFE,CurFMInput
.L8:
            movea.l IntlSpec,A0
            move.b  (SP)+,(6,A0)
            move.w  ($2A,A4),-(SP)
            move.l  #$80020004,-(SP)
            _ScriptUtil
            move.w  BootDrive,($34,A4)
            movem.l (SP)+,D3/A2-A4
            rts
SMGRCALCRECT:
            movem.l A2,-(SP)
            movea.l IntlSpec,A2
            move.w  MBarHeight,D0
            lsr.w   #1,D0
            subq.w  #8,D0
            move.w  D0,($2C,A2)
            addi.w  #$10,D0
            move.w  D0,($30,A2)
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetWMgrPort
            movea.l (SP)+,A0
            tst.b   ($18E,A2)
            bne.b   .L1
            move.w  ($16,A0),D0
            sub.w   ($18C,A2),D0
            move.w  D0,($32,A2)
            subi.w  #$10,D0
            move.w  D0,($2E,A2)
            bra.b   .L2
.L1:
            move.w  ($12,A0),D0
            add.w   ($18C,A2),D0
            move.w  D0,($2E,A2)
            addi.w  #$10,D0
            move.w  D0,($32,A2)
.L2:
            movem.l (SP)+,A2
            rts
SMGRINITFONTS:
            movem.l D0/D3/A0/A2-A3,-(SP)
            movea.l IntlSpec,A2
            cmpa.w  #$FFFF,A2
            beq.w   .L5
            move.b  (6,A2),-(SP)
            sf      (6,A2)
            tst.b   (4,A2)
            beq.b   .L4
            move.w  ($26,A2),D3
            move.w  D3,D0
            lsl.w   #2,D0
            movea.l ($72,A2,D0.w),A3
            clr.w   -(SP)
            move.w  SysFontFam,-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D3
            bne.b   .L1
            tst.b   (9,A2)
            beq.b   .L2
.L1:
            move.w  (8,A3),SysFontFam
            move.w  #$FFFE,CurFMInput
.L2:
            clr.w   -(SP)
            move.w  ApFontID,-(SP)
            move.l  #$82020006,-(SP)
            _ScriptUtil
            cmp.w   (SP)+,D3
            bne.b   .L3
            tst.b   (9,A2)
            beq.b   .L4
.L3:
            move.w  ($A,A3),ApFontID
            move.w  #$FFFE,CurFMInput
.L4:
            move.b  (SP)+,(6,A2)
.L5:
            movem.l (SP)+,D0/D3/A0/A2-A3
            rts
SMGRPOSTMUNGING:
            movem.l D0-D2/A0-A4,-(SP)
            movea.l IntlSpec,A4
            movea.l A0,A2
            move.b  (4,A4),D0
            cmpi.b  #1,D0
            ble.b   .L5
            cmpi.w  #1,(A2)
            bne.b   .L1
            subq.w  #2,SP
            move.l  ($A,A2),-(SP)
            pea     ($2C,A4)
            _PtInRect
            tst.b   (SP)+
            beq.b   .L5
            moveq   #-1,D0
            bra.b   .L4
.L1:
            cmpi.w  #3,(A2)
            beq.b   .L2
            cmpi.w  #5,(A2)
            bne.b   .L5
.L2:
            move.l  (2,A2),D1
            move.b  ($E,A2),D1
            andi.w  #$FFFB,D1
            move.l  ($36,A4),D0
            beq.b   .L5
            movea.l D0,A0
            movea.l (A0),A0
.L3:
            move.l  (A0)+,D0
            beq.b   .L5
            cmp.w   D0,D1
            bne.b   .L3
            swap    D0
.L4:
            move.w  D0,-(SP)
            move.l  #$80020004,-(SP)
            _ScriptUtil
            clr.w   (A2)
            move.l  MinusOne,(SP)
.L5:
            movem.l (SP)+,D0-D2/A0-A4
            rts
            ds.b    8

            EVEN
