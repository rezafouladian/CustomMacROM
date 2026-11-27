            include "Include/ROMHeader.s"

            EXPORT  SmgrInitialize

            IMPORT  CODEENTRY,PATCHSTART,RomanDispTable,utilTable,utilTableBase,A

            SECTION "ScriptMgrInit",CODE

SmgrInitialize:
            link.w  A6,#0
            movem.l D0-D7/A0-A4,-(SP)
            movea.l ExpandMem,A4
            tst.w   ROM85
            blt.w   .L10
            move.l  #$220,D0
            bsr.w   sub_40821B9E
            lea     (CODEENTRY.w,PC),A1
            move.w  (A1),(A0)
            move.l  A0,(6,A4)
            move.l  A0,IntlSpec
            movea.l A0,A4
            moveq   #$58,D0
            bsr.w   sub_40821B9E
            lea     ($38,A0),A1
            move.l  A1,($52,A4)
            move.w  #$FFE4,($56,A4)
            move.w  #$E,($58,A4)
            lea     (utilTableBase.w,PC),A1
            lea     (utilTable.w,PC),A3
            move.w  #$15,D0
.L1:
            move.w  (A1)+,D1
            lea     (0,A3,D1.w),A2
            move.l  A2,(A0)+
            dbra    D0,.L1
            lea     (PATCHSTART.w,PC),A3
            lea     SmgrTable,A2
.L2:
            move.l  (A2)+,D0
            beq.b   .L3
            lea     (0,A3,D0.w),A0
            swap    D0
            move.l  A0,(0,A4,D0.w)
            bra.b   .L2
.L3:
            subq.w  #4,SP
            move.l  #'itlc',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP),D0
            beq.w   .L9
            movea.l D0,A0
            movea.l (A0),A0
            move.b  (4,A0),D0
            move.b  D0,(6,A4)
            move.b  (5,A0),D0
            move.b  D0,(7,A4)
            move.b  (7,A0),D0
            move.b  D0,($A,A4)
            move.l  (8,A0),D0
            move.l  D0,($18C,A4)
            move.w  (A0),D0
            move.w  D0,($26,A4)
            move.w  #$199,($3A,A4)
            _ReleaseResource
            movea.l ExpandMem,A2
            move.l  ($E,A2),D0
            bne.b   .L5
            clr.l   -(SP)
            move.l  #'KCHR',-(SP)
            clr.w   -(SP)
            move.w  #$FFFF,ROMMapInsert
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,D4
            beq.w   .L9
            _GetHandleSize
            cmpi.l  #$800,D0
            bge.b   .L4
            move.l  #$800,D0
.L4:
            addi.l  #$200,D0
            move.l  D0,D3
            _NewPtrSysClear
            bne.w   .L9
            move.l  A0,($E,A2)
            movea.l A0,A1
            movea.l D4,A0
            movea.l (A0),A0
            move.l  D3,D0
            _BlockMove
.L5:
            moveq   #$74,D0
            bsr.w   sub_40821B9E
            movea.l A0,A2
            move.l  A2,($72,A4)
            move.w  #$101,(A2)
            move.l  #'ZSYS',($28,A2)
            lea     SysResName,A0
            move.l  A0,($2C,A2)
            move.w  #3,($A,A2)
            moveq   #$3C,D0
            bsr.w   sub_40821B9E
            move.l  A0,($40,A2)
            move.w  #$C,($44,A2)
            move.w  #$28,($46,A2)
            lea     (RomanDispTable.w,PC),A1
            movea.l A1,A4
            move.w  #$E,D0
            move.l  A2,-(SP)
.L6:
            move.w  (A1)+,D1
            lea     (0,A4,D1.w),A2
            move.l  A2,(A0)+
            dbra    D0,.L6
            movea.l (SP)+,A2
            move.w  #$3FFF,D4
            subq.w  #4,SP
            move.l  #'FOND',-(SP)
            move.w  D4,-(SP)
            _GetResource
            tst.l   (SP)+
            bne.b   .L7
            clr.w   D4
.L7:
            move.w  D4,(8,A2)
            lea     RomanTable,A1
.L8:
            move.l  (A1)+,D0
            beq.b   .L10
            lea     (0,A3,D0.w),A0
            swap    D0
            move.l  A0,(0,A2,D0.w)
            bra.b   .L8
.L9:
            move.w  #$7FFF,D0
            _SysError
.L10:
            movem.l (SP)+,D0-D7/A0-A4
            unlk    A6
            rts
sub_40821B9E:
            _NewPtrSysClear
            beq.b   .L1
            move.w  #$7FFF,D0
            _SysError
.L1:
            rts
            ds.b    6
SmgrTable:
            dc.w    $0016,$057E,$01C0,$3B8E,$01C4,$39EE,$01C8,$3B2E
            dc.w    $01CC,$33FE,$01D0,$32EE,$01D4,$321E,$01D8,$339E
            dc.w    $01DC,$308E,$01E0,$2EDE,$01E4,$2A1E,$01E8,$28EE
            dc.w    $01EC,$282E,$01F0,$299E,$01F4,$05C2,$01F8,$067C
            dc.w    $01FC,$0788
            ds.b    12
PatchTable:
            ori.l   #$1900A06,(0,A5,D0.w)
            ori.b   #0,D0
            ori.b   #0,D0
RomanTable:
            ori.b   #$E,-(A0)
            ori.b   #$16,-(A4)
            ori.b   #$10,(0,A0,D0.w)
            dc.w    0

            EVEN
