            include "Include/ROMHeader.s"

            EXPORT  AddMyDrive,DoATBootOpen,myExtFSFilter,myGrowZone,pdbzero,TestPRam_DRVR_49

            SECTION "NetBoot_BootUtils",CODE

TestPRam_DRVR_49:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .L1
            bsr.b   ReadPRAM
            bra.b   .L2
.L1:
            bsr.b   WritePRAM
.L2:
            rts
pRamTable:
            dc.l    $00040004                       ; first four password bytes
            dc.l    $000300AB                       ; next three bytes
            dc.l    $000100BC                       ; last password byte
            dc.l    $00200020                       ; user name (32 bytes)
            dc.l    $0020008B                       ; server name (31 bytes)
ReadPRAM:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     pRamTable,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _ReadXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
WritePRAM:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     pRamTable,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _WriteXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
AddMyDrive:
            link.w  A6,#-$32
            lea     DrvQHdr,A0
            moveq   #4,D0
.L1:
            movea.l (2,A0),A1
.L2:
            cmp.w   (6,A1),D0
            beq.b   .L3
            cmpa.l  (6,A0),A1
            beq.b   .L4
            movea.l (A1),A1
            bra.b   .L2
.L3:
            addq.w  #1,D0
            bra.b   .L1
.L4:
            move.w  D0,($12,A6)
            moveq   #$1A,D0
            _NewPtrSys
            beq.b   .L5
            move.w  D0,($12,A6)
            bra.b   .L6
.L5:
            move.l  #$80000,(A0)+
            move.w  #1,(4,A0)
            move.w  #1,($A,A0)
            move.w  ($E,A6),($E,A0)
            move.w  ($10,A6),($C,A0)
            move.l  (8,A6),($10,A0)
            move.w  ($12,A6),D0
            swap    D0
            move.w  ($C,A6),D0
            _AddDrive
.L6:
            unlk    A6
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
pdbzero:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            ble.b   .L2
            subq.l  #1,D0
            moveq   #0,D1
.L1:
            move.b  D1,(A0)+
            dbra    D0,.L1
.L2:
            rts
myExtFSFilter:
            movem.l D1-D2/A0-A4,-(SP)
            cmpi.b  #$F,(7,A0)
            bne.w   .L5
            move.w  ($16,A0),D0
            cmpi.w  #4,D0
            bne.w   .L5
            lea     DrvQHdr,A2
            movea.l (2,A2),A1
.L1:
            cmp.w   (6,A1),D0
            beq.b   .L2
            cmpa.l  (6,A2),A1
            beq.w   .L4
            movea.l (A1),A1
            bra.b   .L1
.L2:
            cmpi.w  #1,($A,A1)
            bne.w   .L4
            move.l  ($10,A1),D0
            movea.l A1,A4
            beq.w   .L4
            movea.l D0,A2
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  ($10,A0),-(SP)
            lea     myGrowZone,A1
            move.l  A1,($10,A0)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #3,($1A,A0)
            move.w  (4,A2),($18,A0)
            _Control
            beq.b   .L3
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            bra.w   .L5
.L3:
            movea.l ($1C,A0),A1
            move.l  A1,($352).w
            movea.l ($372).w,A3
            move.l  A1,(2,A3)
            moveq   #2,D0
            move.l  D0,(6,A3)
            clr.l   ($A,A3)
            clr.l   ($E,A3)
            movea.l ($20,A0),A1
            move.w  ($A,A1),($A,A4)
            move.w  (8,A1),(8,A4)
            move.b  (-3,A1),(-3,A4)
            subq.w  #4,A1
            movea.l A1,A0
            _DisposPtr
            clr.l   ($10,A4)
            move.l  (8,A2),($3F2).w
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            moveq   #0,D0
            bra.b   .L5
.L4:
            moveq   #-1,D0
.L5:
            movem.l (SP)+,D1-D2/A0-A4
            rts
myGrowZone:
            move.l  (4,SP),D0
            move.l  A2,-(SP)
            movea.l SysZone,A1
            movea.l (A1),A0
            movea.l A0,A2
            addi.l  #$4000,D0
            lea     (0,A0,D0.l),A0
            move.l  D0,D1
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L1
            move.l  A1,D1
            sub.l   A2,D1
            movea.l A1,A0
.L1:
            _SetAppBase
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  A1,ApplZone
            move.l  (A1),HeapEnd
            movea.l (SP)+,A2
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  D1,(SP)
            jmp     (A0)
DoATBootOpen:
            movea.l (4,SP),A0
            clr.l   -(SP)
            move.l  #'DRVR',-(SP)
            move.l  ($12,A0),-(SP)
            _GetNamedResource
            clr.w   D0
            tst.l   (SP)+
            beq.b   .L1
            movea.l (4,SP),A0
            _Open
            move.w  ($18,A0),D0
.L1:
            rts

            EVEN
