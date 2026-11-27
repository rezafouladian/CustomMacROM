            include "Include/ROMHeader.s"

            EXPORT  GestaltTrap_,InitGestalt

            IMPORT  getAddrModePatch,getFPUTypePatch,getPageSizePatch,findLong,newGestalt,A

            SECTION "GestaltFunction",CODE

GestaltTrap_:
            cmpi.w  #$A1AD,D1
            beq.b   .L3
            move.l  A0,-(SP)
            move.l  SP,-(SP)
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            cmpi.w  #$A3AD,D1
            beq.b   .L1
            cmpi.w  #$A5AD,D1
            bne.b   .L4
            move.l  #1,-(SP)
            bra.b   .L2
.L1:
            clr.l   -(SP)
.L2:
            jsr     (newGestalt.w,PC)
            adda.w  #$10,SP
            movea.l (SP)+,A0
            bra.b   .L5
.L3:
            movem.l D3-D7/A2-A4,-(SP)
            jsr     sub_40816548
            movem.l (SP)+,D3-D7/A2-A4
            bra.b   .L5
.L4:
            adda.w  #$10,SP
            moveq   #-$32,D0
            nop
.L5:
            rts
sub_40816548:
            move.l  D0,D3
            subq.l  #4,SP
            move.l  SP,-(SP)
            move.l  D0,-(SP)
            jsr     (findLong.w,PC)
            addq.l  #8,SP
            move.l  (SP)+,D2
            tst.w   D0
            beq.b   .L1
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A1
            movea.l (A1),A0
            movea.l (A0),A1
            lsl.l   #3,D2
            movea.l (4,A1,D2.l),A1
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  D3,-(SP)
            pea     (6,SP)
            jsr     (A1)
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            bra.b   .L2
.L1:
            move.l  #$FFFFEA51,D0
.L2:
            rts
            movea.l (4,SP),A0
            moveq   #0,D0
            move.w  SysVersion,D0
            bra.w   sub_408165F6.L6
            movea.l (4,SP),A0
            movea.l ROMBase,A1
            moveq   #0,D0
            move.w  (8,A1),D0
            bra.w   sub_408165F6.L6
            btst    #1,HWCfgFlags
            beq.w   sub_408165F6.L5
            moveq   #0,D0
            move.w  #$110,D0
            bra.w   sub_408165F6.L6
            movea.l ExpandMem,A1
            movea.l ($5C,A1),A1
            moveq   #0,D0
            move.w  ($10,A1),D0
            bra.w   sub_408165F6.L6
            moveq   #0,D0
            move.b  CPUFlag,D0
            addq.w  #1,D0
            bra.w   sub_408165F6.L6
            move.b  KbdType,D0
            lea     sub_408165F6,A0
            movea.l A0,A1
.L3:
            move.b  (A0)+,D1
            beq.w   sub_408165F6.L5
            cmp.b   D0,D1
            bne.b   .L3
            suba.l  A1,A0
            move.l  A0,D0
            bra.w   sub_408165F6.L6
sub_408165F6:
            btst    D1,(A3)
            btst    D5,D2
            btst    D0,D6
            btst    D3,D4
            btst    D2,D0
            bra.l   getFPUTypePatch
            beq.b   .L3
            movea.l SP,A0
            fnop
            fsave   -(SP)
            move.w  (SP),D0
            movea.l A0,SP
            cmpi.w  #$1F18,D0
            beq.b   .L1
            cmpi.w  #$3F18,D0
            beq.b   .L1
            cmpi.w  #$3F38,D0
            beq.b   .L2
            cmpi.w  #$1F38,D0
            beq.b   .L2
            bra.w   .L5
.L1:
            moveq   #1,D0
            bra.b   .L4
.L2:
            moveq   #2,D0
            bra.b   .L4
.L3:
            clr.b   D0
.L4:
            bra.w   .L6
            moveq   #0,D0
            move.b  MMUType,D0
            cmpi.b  #1,D0
            beq.b   .L8
            cmpi.b  #3,D0
            blt.b   .L9
            subq.w  #1,D0
            bra.b   .L8
.L9:
            moveq   #0,D0
.L8:
            bra.w   .L6
            bra.l   getPageSizePatch
            blt.w   .L10
            cmpi.b  #3,MMUType
            blt.b   .L11
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            lea     ($12,A0),A0
            pmove.l TC,(A0)
            bfextu  (A0){8:4},D1
            moveq   #0,D0
            bset    D1,D0
            bra.b   .L12
.L11:
            move.l  #$8000,D0
.L12:
            bra.w   .L6
.L10:
            bra.w   .L5
            move.l  SysZone,D0
            bra.w   .L6
            movea.l ExpandMem,A1
            movea.l ($5C,A1),A1
            cmpi.l  #'lram',(8,SP)
            bne.b   .L13
            move.l  ($C,A1),D0
            bra.b   .L14
.L13:
            move.l  (8,A1),D0
.L14:
            bra.w   .L6
            movea.l ROMBase,A0
            move.l  ($40,A0),D0
            bra.w   .L6
            moveq   #2,D0
            bra.w   .L6
            moveq   #0,D0
            tst.b   PortBUse
            bmi.b   .L15
            move.b  SPConfig,D1
            andi.b  #$F,D1
            cmpi.b  #1,D1
            bne.b   .L15
            movea.l ABusDCE,A0
            move.b  (7,A0),D0
.L15:
            bra.w   .L6
            moveq   #0,D0
            bra.w   .L6
            bra.l   getAddrModePatch
            ds.b    10
            moveq   #0,D1
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A0
            cmpi.w  #9,($10,A0)
            bne.b   .L16
            bset    #1,D1
.L16:
            move.l  #'hdwr',D0
            _Gestalt
            move.l  A0,D0
            btst    #3,D0
            beq.b   .L17
            bset    #0,D1
            move.l  A0,D0
            btst    #1,D0
            beq.b   .L18
            move.l  #'via2',D0
            _Gestalt
            btst    #6,(A0)
            bra.b   .L19
.L18:
            move.l  A0,D0
            btst    #2,D0
            beq.b   .L17
            move.l  #'rbv ',D0
            _Gestalt
            adda.w  #0,A0
            btst    #6,(A0)
.L19:
            bne.b   .L17
            bset    #2,D1
.L17:
            move.l  D1,D0
            bra.w   .L6
            suba.w  #$E,SP
            movea.l SP,A0
            clr.l   ($A,A0)
            move.w  #$FFFF,(4,A0)
            _InsTime
            moveq   #1,D1
            move.b  (4,A0),D0
            bmi.b   .L20
            addq.l  #1,D1
            add.b   D0,D0
            bmi.b   .L20
            addq.l  #1,D1
.L20:
            _RmvTime
            lea     ($E,SP),SP
            move.l  D1,D0
            bra.w   .L6
            move.l  SCCRd,D0
            bra.w   .L6
            move.l  SCCWr,D0
            bra.w   .L6
            move.l  #'hdwr',D0
            _Gestalt
            tst.w   D0
            bne.w   .L5
            move.l  A0,D0
            btst    #2,D0
            beq.w   .L5
            move.l  VIA2,D0
            bra.w   .L6
            move.l  VIA,D0
            bra.w   .L6
            move.l  #'hdwr',D0
            _Gestalt
            tst.w   D0
            bne.w   .L5
            move.l  A0,D0
            btst    #1,D0
            beq.w   .L5
            move.l  #$50F02000,D0
            bra.w   .L6
            moveq   #0,D0
            bra.w   .L6
            movea.l UnivInfoPtr,A0
            adda.l  ($C,A0),A0
            moveq   #0,D0
            moveq   #0,D1
            move.l  #$FF,D2
.L22:
            btst    #2,(0,A0,D0.w)
            beq.b   .L21
            addq.w  #1,D1
            tst.b   D2
            bpl.b   .L21
            move.l  D0,D2
.L21:
            addq.w  #1,D0
            cmpi.l  #$10,D0
            bne.b   .L22
            move.l  D2,D0
            cmpi.l  #'slt1',(8,SP)
            beq.w   .L6
            move.l  D1,D0
            cmpi.l  #'nubs',(8,SP)
            beq.w   .L6
            cmpi.l  #'slot',(8,SP)
            bne.w   .L5
            moveq   #1,D0
            tst.l   D1
            beq.w   .L6
            bset    #1,D0
            bra.w   .L6
            move.l  #'hdwr',D0
            _Gestalt
            tst.w   D0
            bne.w   .L5
            move.l  A0,D1
            moveq   #0,D0
            btst    #$F,D1
            beq.w   .L6
            bset    #0,D0
            movea.l VIA,A0
            btst    #6,(A0)
            bne.w   .L6
            bset    #1,D0
            bra.w   .L6
            dc.w    $0000,$000A
            moveq   #0,D0
            lea     .L29(PC),A0
            move.l  AddrMapFlags,D1
.L24:
            move.b  (A0)+,D2
            bmi.w   .L23
            move.b  (A0)+,D3
            btst    D3,D1
            beq.b   .L24
            bset    D2,D0
            bra.b   .L24
.L23:
            move.l  UnivROMFlags,D1
            btst    #0,D1
            beq.w   .L6
            bset    #$F,D0
            bra.w   .L6
.L29:
            dc.w    $0002
            dc.w    $0403,$0B05,$0C06,$0D07,$0708,$010B,$030C,$020D
            dc.w    $0E0E,$060F,$0810,$0911,$0512,$0A13,$FFFF
            move.l  (8,SP),D0
            cmpi.l  #'vers',D0
            beq.b   .L25
            cmpi.l  #'tabl',D0
            beq.b   .L26
            cmpi.l  #$D,D0
            beq.b   .L27
            cmpi.l  #7,D0
            bne.b   .L5
            move.l  #'carl',D0
            bra.b   .L28
.L27:
            move.l  #'bbmc',D0
            bra.b   .L28
.L25:
            moveq   #1,D0
            bra.b   .L6
.L26:
            movea.l ExpandMem,A0
            movea.l ($5C,A0),A1
            move.l  (A1),D0
            bra.b   .L6
.L5:
            move.w  #$EA52,($C,SP)
            bra.b   .L7
.L6:
            movea.l (4,SP),A0
            move.l  D0,(A0)
.L28:
            clr.w   ($C,SP)
.L7:
            movea.l (SP)+,A0
            addq.l  #8,SP
            jmp     (A0)
InitGestalt:
            moveq   #$16,D0
            _NewPtrSysClear
            move.l  A0,D0
            beq.w   .L5
            movea.l ExpandMem,A1
            move.l  A0,($5C,A1)
            movea.l A0,A2
            moveq   #8,D0
            _NewHandle sys
            move.l  A0,(A2)
            beq.w   .L5
            movea.l (A0),A1
            move.l  #$7FFFFFFF,(A1)
            move.l  #$12345678,(4,A1)
            move.l  #1,(4,A2)
            move.l  RealMemTop,($C,A2)
            move.l  MemTop,(8,A2)
            jsr     sub_40816ACC
            move.w  D0,($10,A2)
            lea     .L2,A3
            movea.l A3,A2
.L1:
            tst.l   (A3)
            beq.w   .L3
            move.l  (4,A3),D0
            add.l   A2,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            clr.l   -(SP)
            jsr     (newGestalt.w,PC)
            lea     ($C,SP),SP
            addq.l  #8,A3
            bra.b   .L1
.L2:
            dc.w    $6D61,$6368,$FFFF,$FC12,$7379,$7376,$FFFF,$FBDE
            dc.w    $7072,$6F63,$FFFF,$FC24,$6B62,$6420,$FFFF,$FC30
            dc.w    $6174,$6C6B,$FFFF,$FD24,$6670,$7520,$FFFF,$FC56
            dc.w    $6D6D,$7520,$FFFF,$FC94,$7261,$6D20,$FFFF,$FCF2
            dc.w    $6C72,$616D,$FFFF,$FCF2,$7164,$2020,$FFFF,$FD1E
            dc.w    $726F,$6D20,$FFFF,$FD12,$766D,$2020,$FFFF,$FE48
            dc.w    $706F,$7772,$FFFF,$FD46,$7363,$6372,$FFFF,$FDEE
            dc.w    $7363,$6377,$FFFF,$FDF6,$726F,$6D76,$FFFF,$FBEC
            dc.w    $7669,$6131,$FFFF,$FE1E,$7669,$6132,$FFFF,$FE26
            dc.w    $7262,$7620,$FFFF,$FDFE,$7665,$7273,$FFFF,$FF36
            dc.w    $7461,$626C,$FFFF,$FF36,$736E,$6420,$FFFF,$FD5C
            dc.w    $6864,$7772,$FFFF,$FEE8,$736C,$6F74,$FFFF,$FE4E
            dc.w    $736C,$7431,$FFFF,$FE4E,$6E75,$6273,$FFFF,$FE4E
            dc.w    $746D,$6772,$FFFF,$FDC0,$6164,$6472,$FFFF,$FD4C
            dc.w    $612F,$7578,$FFFF,$FBFE,$7067,$737A,$FFFF,$FCB0
            dc.w    $6C6D,$656D,$FFFF,$FCEA,$7072,$7479,$FFFF,$FEB2
            dc.w    0,$000D,$FFFF,$FF36,0,$0007,$FFFF,$FF36
            ds.b    4
            dc.w    $FFFF,$FB56
.L3:
            clr.w   D0
.L4:
            rts
.L5:
            move.w  #$FF94,D0
            bra.b   .L4
sub_40816ACC:
            movea.l ROMBase,A0
            move.b  (8,A0),D0
            bgt.b   .L1
            move.w  #3,D0
            tst.w   HWCfgFlags
            bpl.b   .L2
            move.w  #4,D0
            bra.b   .L2
.L1:
            moveq   #0,D0
            move.b  BoxFlag,D0
            addq.b  #6,D0
.L2:
            rts

            EVEN
