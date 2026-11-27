MakeStkPB:
            movea.l (SP)+,A0
            moveq   #$1F,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            move.l  A0,-(SP)
            movea.l SP,A0
            addq.w  #4,A0
            rts
MountVol:
            move.w  ($16,A0),D2
            movem.l D1-D2/A0-A1,-(SP)
            bsr.b   sub_4080F65E
            movem.l (SP)+,D1-D2/A0-A1
            cmpi.w  #$FF94,D0
            beq.b   .L1
            cmpi.w  #$FFD6,D0
            beq.b   .L1
            rts
.L1:
            move.w  D2,($16,A0)
.L2:
            move.l  ($358).w,D0
.L3:
            beq.b   .L6
            movea.l D0,A1
            tst.w   ($4C,A1)
            bne.b   .L4
            move.w  ($48,A1),D2
            bne.b   .L5
.L4:
            move.l  (A1),D0
            bra.b   .L3
.L5:
            move.l  A0,-(SP)
            bsr.b   MakeStkPB
            move.w  D2,($16,A0)
            _OffLine
            lea     ($40,SP),SP
            movea.l (SP)+,A0
            bne.b   .L2
            bra.b   MountVol
.L6:
            moveq   #-$6C,D0
            rts
sub_4080F65E:
            bsr.w   FSQueueSync
            st      ($34A).w
.L1:
            moveq   #-$32,D0
            move.w  ($16,A0),D2
            ble.b   .L2
            move.w  D2,D0
            bsr.w   GetVCBDrv
            bne.b   .L3
            tst.w   ($48,A2)
            beq.b   .L3
            moveq   #-$37,D0
.L2:
            bra.w   vCheckRemount.L15
.L3:
            bsr.w   FindDrive
            bne.b   .L2
            movea.l A0,A2
            move.l  #$B2,D0
            _NewPtrSysClear
            bne.b   .L2
            lea     ($356).w,A1
            tst.l   (2,A1)
            bne.b   .L4
            move.l  A0,($352).w
            movea.l ($372).w,A1
            move.l  A0,(2,A1)
            moveq   #2,D0
            move.l  D0,(6,A1)
            clr.l   ($A,A1)
            clr.l   ($E,A1)
            lea     ($356).w,A1
.L4:
            jsr     (QStuff.w,PC)
            exg     A0,A2
            move.w  D2,($48,A2)
            move.w  D1,($4A,A2)
            movea.l ($37C).w,A1
            move.l  A1,($54,A2)
            moveq   #0,D0
.L5:
            subq.w  #1,D0
            movem.l D0/A2,-(SP)
            bsr.w   GetVCBRfn
            movem.l (SP)+,D0/A2
            beq.b   .L5
            move.w  D0,($4E,A2)
            cmpa.l  ($352).w,A2
            bne.b   .L6
            move.w  D0,($384).w
.L6:
            moveq   #0,D1
            moveq   #2,D2
            jsr     (GetBlock.w,PC)
            bne.w   vCheckRemount.L20
            movea.l A0,A5
            moveq   #2,D1
            jsr     (RelBlock.w,PC)
            cmpi.w  #$4244,(A5)
            beq.b   .L7
            moveq   #-$39,D0
            cmpi.w  #$D2D7,(A5)
            bne.w   vCheckRemount.L20
.L7:
            moveq   #-$3C,D0
            move.l  ($14,A5),D1
            beq.w   vCheckRemount.L19
            andi.w  #$1FF,D1
            bne.w   vCheckRemount.L19
            lea     (8,A2),A1
            moveq   #$40,D0
            _BlockMove
            movea.l ($362).w,A0
            move.w  ($4E,A2),($16,A0)
            lea     ($3A4).w,A0
            move.w  #8,($1A,A0)
            clr.b   ($1E,A0)
            _Status
            moveq   #-$80,D0
            and.b   ($1E,A0),D0
            move.b  D0,($13,A2)
            bsr.w   TFSVCBTst
            bne.w   sub_40810604.L4
            lea     ($40,A5),A0
            lea     ($5E,A2),A1
            moveq   #$42,D0
            _BlockMove
            move.l  ($1C,A2),D1
            move.l  ($82,A5),D0
            jsr     DivUp
            move.w  D0,($A0,A2)
            move.l  ($92,A5),D0
            jsr     DivUp
            move.w  D0,($A2,A2)
            clr.w   ($18,A2)
            addq.l  #1,($64,A2)
            bsr.w   FindFCB
            bne.w   vCheckRemount.L18
            move.w  D1,($A4,A2)
            move.l  ($82,A5),(8,A1,D1.w)
            move.l  ($82,A5),($C,A1,D1.w)
            moveq   #$C,D0
            lea     ($86,A5),A0
            lea     ($26,A1,D1.w),A1
            _BlockMove
            bsr.w   FindFCB
            bne.w   vCheckRemount.L18
            move.w  D1,($A6,A2)
            move.l  ($92,A5),(8,A1,D1.w)
            move.l  ($92,A5),($C,A1,D1.w)
            moveq   #$C,D0
            lea     ($96,A5),A0
            lea     ($26,A1,D1.w),A1
            _BlockMove
            move.l  ($378).w,($50,A2)
            move.l  ($380).w,($A8,A2)
            move.w  ($A4,A2),D0
            moveq   #3,D1
            move.l  ($68,A2),D2
            movea.l ($A8,A2),A1
            lea     (FXMKeyCmp.w,PC),A3
            bsr.w   AccessBT
            bne.w   vCheckRemount.L17
            move.w  ($A6,A2),D0
            moveq   #4,D1
            move.l  ($6C,A2),D2
            movea.l ($A8,A2),A1
            lea     (CMKEYCMP.w,PC),A3
            bsr.w   AccessBT
            bne.w   vCheckRemount.L17
            bclr    #8,($12,A2)
            beq.w   vCheckRemount.L23
.L8:
            move.l  ($6C0).w,-(SP)
            rts
vCheckRemount:
            move.l  ($358).w,D0
.L1:
            beq.w   .L14
            movea.l D0,A4
            cmpa.l  A4,A2
            beq.b   .L3
            move.w  (8,A4),D0
            cmp.w   (8,A2),D0
            bne.b   .L3
            move.l  ($A,A4),D0
            cmp.l   ($A,A2),D0
            bne.b   .L3
            lea     ($2C,A4),A1
            lea     ($2C,A2),A3
            moveq   #$D,D0
.L2:
            cmpm.w  (A1)+,(A3)+
            dbne    D0,.L2
            bne.b   .L3
            tst.w   (A1)
            beq.b   .L4
.L3:
            move.l  (A4),D0
            bra.b   .L1
.L4:
            bsr.w   sub_408108C6
.L5:
            cmpa.l  ($14,A1,D1.w),A4
            bne.w   .L11
            bsr.w   TFSVCBTst
            beq.b   .L9
            move.w  ($1C,A1,D1.w),D3
            bsr.w   sub_40811A50
            bne.b   .L3
            moveq   #0,D0
            move.l  (0,A1,D1.w),D3
.L6:
            cmp.l   ($12,A5,D0.w),D3
            beq.b   .L7
            bsr.w   sub_40810C92
            bcs.b   .L6
            bra.b   .L3
.L7:
            lea     ($16,A5,D0.w),A3
            btst    #1,(4,A1,D1.w)
            beq.b   .L8
            lea     ($20,A5,D0.w),A3
.L8:
            move.w  (A3)+,D0
            cmp.w   (6,A1,D1.w),D0
            bne.b   .L3
            move.l  (A3)+,D0
            bra.b   .L10
.L9:
            move.l  (0,A1,D1.w),D0
            cmpi.l  #$10,D0
            bcs.b   .L11
            movem.l D2/A0-A1,-(A6)
            move.l  ($3A,A1,D1.w),D0
            lea     ($3E,A1,D1.w),A0
            moveq   #0,D2
            jsr     (CMGetCN.w,PC)
            movea.l A1,A3
            movem.l (A6)+,D2/A0-A1
            bne.b   .L3
            cmpi.b  #2,(A3)
            bne.b   .L3
            move.l  ($1A,A3),D0
            btst    #1,(4,A1,D1.w)
            beq.b   .L10
            move.l  ($24,A3),D0
.L10:
            cmp.l   (8,A1,D1.w),D0
            bne.w   .L3
.L11:
            bsr.w   sub_408108CE
            bcs.w   .L5
            clr.b   ($34A).w
            move.w  ($4E,A4),D1
            lea     (8,A2),A0
            lea     (8,A4),A1
            moveq   #$56,D0
            bsr.w   TFSVCBTst
            bne.b   .L12
            move.w  #$AA,D0
.L12:
            _BlockMove
            move.w  D1,($4E,A4)
            bsr.w   TFSVCBTst
            bne.b   .L13
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D0
            move.l  A4,($14,A1,D0.w)
            move.w  ($A6,A2),D0
            move.l  A4,($14,A1,D0.w)
.L13:
            bsr.w   sub_4080FCA0
            movea.l A2,A0
            movea.l A4,A2
            lea     ($356).w,A1
            jsr     (DequeueTrap.w,PC)
            _DisposPtr
            movea.l ($362).w,A0
            move.w  ($4E,A2),($16,A0)
.L14:
            moveq   #0,D0
.L15:
            tst.w   D0
            bne.b   .L16
            bsr.w   TFSVCBTst
            bne.b   .L16
            btst    #7,($13,A2)
            bne.b   .L16
            bsr.w   sub_4080F52E
            bsr.w   FlushMDB
.L16:
            bra.w   CmdDone
.L17:
            move.w  D0,($392).w
            moveq   #-$3C,D0
.L18:
            bsr.w   DsposFCBs
.L19:
            bsr.w   DsposVBlks
.L20:
            tst.b   ($34A).w
            beq.b   .L22
            bsr.w   DsposVCB
.L21:
            tst.w   D0
            ble.w   CmdDone
            movea.l ($362).w,A0
            bra.w   sub_4080F65E.L1
.L22:
            lea     ($48,A2),A2
            move.w  (A2),D3
            clr.w   (A2)+
            move.w  D3,(A2)+
            addq.w  #4,A2
            clr.l   (A2)+
            clr.l   (A2)+
            bra.b   .L21
.L23:
            move.l  ($6BC).w,-(SP)
            rts
VMTCHECK:
            moveq   #2,D0
            moveq   #0,D2
            movea.l D2,A0
            jsr     (CMGetCN.w,PC)
            bne.b   vCheckRemount.L17
            moveq   #0,D0
            lea     (6,A0),A1
            move.b  (A1)+,D0
            swap    D0
            lea     ($2C,A2),A0
            move.b  (A0)+,D0
            swap    D0
            _CmpString case,marks
            beq.b   .L5
            subq.l  #1,A1
            subq.l  #1,A0
            moveq   #0,D0
            move.b  (A0),D0
            beq.b   .L2
            cmpi.w  #$1B,D0
            ble.b   .L1
            move.b  #$1B,(A0)
.L1:
            moveq   #2,D0
            movea.l A0,A1
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (CMRenameCN.w,PC)
            bne.w   vCheckRemount.L17
            bra.b   .L5
.L2:
            moveq   #0,D0
            move.b  (A1),D0
            beq.w   vCheckRemount.L17
            cmpi.w  #$1B,D0
            ble.b   .L3
            moveq   #$1B,D0
.L3:
            move.b  D0,(A0)+
            subq.w  #1,D0
            addq.l  #1,A1
.L4:
            move.b  (A1)+,(A0)+
            dbra    D0,.L4
.L5:
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            lea     ($26,A1,D1.w),A0
            bsr.w   sub_4080FB84
            move.w  ($A6,A2),D1
            lea     ($26,A1,D1.w),A0
            bsr.w   sub_4080FB84
            moveq   #2,D0
            suba.l  A0,A0
            jsr     (CMGetCN.w,PC)
            bne.w   vCheckRemount.L17
            movea.l ($34E).w,A1
            move.w  ($A6,A2),D1
            move.l  ($C,A1,D1.w),D0
            moveq   #$46,D1
            bsr.w   DivUp
            move.l  D0,D2
            moveq   #$F,D4
            moveq   #0,D3
            moveq   #0,D5
            moveq   #0,D6
            moveq   #0,D7
.L6:
            subq.l  #1,D2
            blt.w   vCheckRemount.L17
            move.w  ($A6,A2),D0
            moveq   #1,D1
            move.l  D2,-(A6)
            jsr     (BTGetRecord.w,PC)
            move.l  (A6)+,D2
            tst.w   D0
            bne.b   .L11
            cmpi.b  #1,(A1)
            bne.b   .L8
            addq.l  #1,D6
            cmpi.l  #2,(2,A0)
            bne.b   .L7
            swap    D7
            addq.w  #1,D7
            swap    D7
.L7:
            cmp.l   (6,A1),D4
            bcc.b   .L6
            move.l  (6,A1),D4
            bra.b   .L6
.L8:
            cmpi.b  #2,(A1)
            bne.b   .L6
            addq.l  #1,D5
            cmpi.l  #2,(2,A0)
            bne.b   .L9
            addq.w  #1,D7
.L9:
            cmp.l   ($14,A1),D4
            bcc.b   .L10
            move.l  ($14,A1),D4
.L10:
            lea     ($4A,A1),A0
            bsr.w   sub_4080FB84
            lea     ($56,A1),A0
            bsr.w   sub_4080FB84
            bra.b   .L6
.L11:
            cmpi.w  #$20,D0
            bne.w   vCheckRemount.L17
            cmp.l   ($26,A2),D4
            bcs.b   .L12
            addq.l  #1,D4
            move.l  D4,($26,A2)
            bset    #0,($13,A2)
            moveq   #-1,D3
.L12:
            cmp.l   ($72,A2),D5
            beq.b   .L13
            move.l  D5,($72,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L13:
            cmp.l   ($76,A2),D6
            beq.b   .L14
            move.l  D6,($76,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L14:
            cmp.w   ($14,A2),D7
            beq.b   .L15
            move.w  D7,($14,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L15:
            swap    D7
            cmp.w   ($70,A2),D7
            beq.b   .L16
            move.w  D7,($70,A2)
            bset    #1,($13,A2)
            moveq   #-1,D3
.L16:
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            move.l  ($C,A1,D1.w),D0
            moveq   #$C,D1
            bsr.w   DivUp
            move.l  D0,D5
            move.w  ($A4,A2),D0
            subq.w  #8,A6
            movea.l A6,A0
            move.w  #$700,(A0)
            clr.l   (2,A0)
            clr.w   (6,A0)
            moveq   #0,D2
            jsr     (BTSEARCH.w,PC)
            addq.w  #8,A6
            moveq   #0,D1
.L17:
            subq.l  #1,D5
            blt.w   vCheckRemount.L17
            move.w  ($A4,A2),D0
            jsr     (BTGetRecord.w,PC)
            bne.b   .L18
            movea.l A1,A0
            bsr.b   sub_4080FB84
            moveq   #1,D1
            bra.b   .L17
.L18:
            cmpi.w  #$20,D0
            bne.w   vCheckRemount.L17
            jsr     (UpdateFree.w,PC)
            bra.w   sub_4080F65E.L8
sub_4080FB84:
            move.l  ($7C0).w,-(SP)
            rts
vBMChk:
            move.l  (SP)+,-(A6)
            bsr.w   CVFlgs
            bne.b   .L1
            jsr     (BLKCHK.w,PC)
            beq.b   .L1
            moveq   #-1,D3
            bset    #2,($13,A2)
.L1:
            move.l  (A6)+,-(SP)
            rts
DsposFCBs:
            movem.l D0-D1/A1,-(SP)
            movea.l ($34E).w,A1
            move.w  ($A4,A2),D1
            beq.b   .L1
            clr.l   (0,A1,D1.w)
.L1:
            move.w  ($A6,A2),D1
            beq.b   .L2
            clr.l   (0,A1,D1.w)
.L2:
            movem.l (SP)+,D0-D1/A1
            rts
DsposVCB:
            move.l  D0,-(SP)
            bsr.w   sub_40810CB8
.L1:
            bne.b   .L2
            clr.l   (0,A1,D1.w)
            clr.l   (4,A1,D1.w)
            bsr.w   sub_40810CC0
            bra.b   .L1
.L2:
            movea.l A2,A0
            lea     ($356).w,A1
            jsr     (DequeueTrap.w,PC)
            cmpa.l  ($352).w,A2
            bne.b   .L3
            clr.l   ($352).w
            clr.w   ($384).w
.L3:
            _DisposPtr
            move.l  (SP)+,D0
            rts
DsposVBlks:
            move.l  A1,-(SP)
            movea.l ($378).w,A1
            jsr     (TrashVBlks.w,PC)
            movea.l ($37C).w,A1
            jsr     (TrashVBlks.w,PC)
            movea.l ($380).w,A1
            jsr     (TrashVBlks.w,PC)
            movea.l (SP)+,A1
            rts
FindFCB:
            bsr.w   sub_408108C6
            bra.b   .L2
.L1:
            tst.l   (0,A1,D1.w)
            bne.b   .L2
            moveq   #-1,D0
            move.l  D0,(0,A1,D1.w)
            moveq   #0,D0
            bra.b   .L3
.L2:
            bsr.w   sub_408108CE
            bcs.b   .L1
            moveq   #-$2A,D0
.L3:
            rts
AccessBT:
            move.l  (SP)+,-(A6)
            movem.l D3/A0,-(A6)
            movea.l ($34E).w,A0
            lea     (0,A0,D0.w),A0
            clr.w   (4,A0)
            clr.w   (6,A0)
            clr.l   ($10,A0)
            move.l  D1,(A0)
            move.l  A2,($14,A0)
            move.l  D2,($1E,A0)
            movea.l A3,A0
            jsr     (BTOPEN.w,PC)
            movem.l (A6)+,D3/A0
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FindDrive:
            move.l  ($6C8).w,-(SP)
            rts
vFindDrive:
            move.l  A0,-(SP)
            move.w  D2,D0
            lea     DrvQHdr,A0
            moveq   #6,D1
            bsr.w   QWordSearch
            bne.b   .L2
            movea.l A0,A3
            move.w  (8,A0),D1
            move.w  ($A,A0),D0
            beq.b   .L1
            moveq   #-$3A,D0
.L1:
            movea.l (SP)+,A0
            rts
.L2:
            moveq   #-$38,D0
            bra.b   .L1
Offline:
            st      NoEject
            bra.w   Eject_2.L1
sub_4080FCA0:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            clr.b   FlushOnly
            bra.b   FlushBuffers.L3
FlushBuffers:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A1,-(A6)
            bsr.w   TFSVCBTst
            bne.b   .L3
            tst.b   FlushOnly
            bne.b   .L1
            bsr.w   CVFlgs
            bne.b   .L1
            bset    #8,($12,A2)
            bsr.w   sub_4080F52E
.L1:
            jsr     FlushMDB
            movea.l ($34E).w,A1
            move.w  ($A6,A2),D1
            bsr.w   sub_40811AA2
            bne.b   .L5
            tst.b   FlushOnly
            bne.b   .L2
            clr.w   ($A6,A2)
.L2:
            move.w  ($A4,A2),D1
            bsr.w   sub_40811AA2
            bne.b   .L5
            tst.b   FlushOnly
            bne.b   .L3
            clr.w   ($A6,A2)
.L3:
            moveq   #0,D1
            st      ($377).w
            movea.l ($378).w,A1
            move.w  ($4E,A2),D0
            jsr     (FlushCache.w,PC)
            movea.l ($380).w,A1
            move.w  ($4E,A2),D0
            jsr     (FlushCache.w,PC)
            movea.l ($37C).w,A1
            move.w  ($4E,A2),D0
            jsr     (FlushCache.w,PC)
            tst.b   FlushOnly
            bne.b   .L4
            bsr.w   DsposVBlks
.L4:
            moveq   #0,D0
.L5:
            movem.l (A6)+,D1-D2/A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
Eject_2:
            clr.b   NoEject
.L1:
            bsr.w   FSQueueSync
            bsr.w   DtrmV3
            bne.b   .L2
            bsr.w   sub_4080FEFA
            bne.b   .L4
            bra.b   .L5
.L2:
            move.w  ($16,A0),D2
.L3:
            bsr.w   FindDrive
            bne.b   .L4
            tst.b   NoEject
            beq.w   .L11
.L4:
            bra.w   CmdDone
.L5:
            lea     ($48,A2),A1
            move.w  (A1),D2
            bne.b   .L6
            move.w  (2,A1),D2
            bpl.b   .L4
            tst.b   NoEject
            bne.b   .L4
            neg.w   D2
            neg.w   (2,A1)
            bra.b   .L3
.L6:
            bsr.w   FindDrive
            bne.b   .L4
            tst.b   NoEject
            bne.b   .L7
            cmpi.b  #8,(-3,A3)
            blt.b   .L7
            st      NoEject
            cmpi.b  #$40,(-3,A3)
            blt.b   .L7
            move.b  #1,NoEject
.L7:
            st      FlushOnly
            bsr.w   sub_4080FE80
            bsr.w   TFSVCBTst
            bne.b   .L8
            clr.b   FlushOnly
            bsr.w   FlushBuffers
            bra.b   .L9
.L8:
            bsr.w   MFSFlush
            bsr.w   sub_408106CA
            bsr.w   DsposVBlks
.L9:
            clr.w   (A1)+
            tst.b   NoEject
            beq.b   .L10
            neg.w   D2
.L10:
            move.w  D2,(A1)+
            tst.b   NoEject
            beq.b   .L11
            movea.l A2,A0
            lea     ($356).w,A1
            bsr.l   DequeueTrap
            bsr.l   QStuff
            tst.b   NoEject
            bmi.w   .L4
.L11:
            lea     ($3A4).w,A0
            lea     ($16,A0),A1
            move.w  D2,(A1)+
            move.w  D1,(A1)+
            move.w  #7,(A1)
            lea     CmdDone,A1
            move.l  A1,($C,A0)
            _Control async
            rts
UnmountVol:
            bsr.w   FSQueueSync
            clr.b   FlushOnly
            bsr.w   DtrmV3
            bne.w   FlushVol.L5
            moveq   #0,D0
            btst    #9,(6,A0)
            bne.w   FlushVol.L1
            movem.l D1-D2/A1,-(SP)
            movea.l ($34E).w,A1
            moveq   #2,D1
.L1:
            move.l  (0,A1,D1.w),D2
            beq.b   .L3
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L3
            cmpi.w  #$D2D7,(8,A2)
            beq.b   .L2
            cmpi.l  #$10,D2
            bcs.b   .L3
            cmpi.w  #$4244,(8,A2)
            bne.b   .L2
            cmpi.l  #'GRT ',D2
            beq.b   .L3
.L2:
            moveq   #-$2F,D0
            bra.b   .L4
.L3:
            add.w   FSFCBLen,D1
            cmp.w   (A1),D1
            bcs.b   .L1
.L4:
            movem.l (SP)+,D1-D2/A1
            tst.w   D0
            bne.b   FlushVol.L5
            bra.b   FlushVol.L1
sub_4080FE80:
            move.l  (SP)+,-(A6)
            movem.l D1-D7/A0-A5,-(A6)
            bsr.w   sub_408108C6
.L1:
            tst.l   (0,A1,D1.w)
            beq.b   .L3
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L3
            bsr.w   TFSVCBTst
            bne.b   .L2
            cmpi.l  #$10,(0,A1,D1.w)
            bcs.b   .L3
.L2:
            bsr.w   sub_40811AA2
            bne.b   .L4
.L3:
            bsr.w   sub_408108CE
            bcs.b   .L1
            moveq   #0,D0
.L4:
            movem.l (A6)+,D1-D7/A0-A5
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
FlushVol:
            bsr.w   FSQueue
            st      FlushOnly
            bsr.b   DtrmV3
            bne.b   .L5
.L1:
            bsr.b   sub_4080FEFA
            bne.b   .L5
            bsr.b   sub_4080FE80
            bne.b   .L5
            bsr.w   TFSVCBTst
            beq.b   .L2
            bsr.w   MFSFlush
            bra.b   .L5
.L2:
            tst.w   ($48,A2)
            beq.b   .L3
            bsr.w   FlushBuffers
            bne.b   .L5
.L3:
            tst.b   FlushOnly
            bne.b   .L4
            bsr.w   DsposVCB
.L4:
            moveq   #0,D0
.L5:
            bra.w   CmdDone
sub_4080FEFA:
            move.l  ($7B8).w,-(SP)
            rts
vCkExtFS:
            move.w  ($4C,A2),D0
            beq.b   .L1
            moveq   #-$3A,D0
.L1:
            rts
DtrmV3:
            move.l  ($7BC).w,-(SP)
            rts
vDtrmV3:
            move.l  ($12,A0),D2
            movea.l D2,A4
            beq.b   DtrmV1
            tst.b   (A4)
            bne.w   AddSPEntry.L6
DtrmV1:
            move.l  ($778).w,-(SP)
            rts
vDtrmV1:
            moveq   #0,D3
            suba.l  A3,A3
            move.w  ($16,A0),D0
            beq.b   .L5
            bmi.b   .L1
            bsr.w   GetVCBDrv
            bra.b   .L3
.L1:
            cmpi.w  #$F000,D0
            ble.b   .L2
            bsr.w   GetVCBRfn
            bra.b   .L3
.L2:
            bsr.w   sub_4080F4FA
.L3:
            beq.b   .L6
.L4:
            moveq   #-$23,D0
            rts
.L5:
            move.l  ($352).w,D0
            beq.b   .L4
            movea.l D0,A2
            movea.l ($372).w,A3
            addq.l  #2,A3
.L6:
            moveq   #0,D0
            move.l  A2,($3EE).w
            btst    #6,($376).w
            bne.b   .L7
            btst    #5,($376).w
            beq.b   .L10
.L7:
            move.l  A4,-(SP)
            movea.l ($386).w,A4
            addq.l  #2,A4
            moveq   #$17,D0
.L8:
            clr.w   (A4)+
            dbra    D0,.L8
            movea.l (SP)+,A4
.L9:
            moveq   #0,D0
            rts
.L10:
            btst    #9,(6,A0)
            beq.b   .L11
            tst.l   ($30,A0)
            bne.b   .L9
.L11:
            movem.l D2/D4/A1/A4,-(SP)
            movea.l ($386).w,A4
            move.w  (-2,A4),D4
            bgt.b   .L16
            moveq   #2,D4
            move.w  ($4E,A2),D2
            move.l  A3,D0
            beq.b   .L12
            move.l  (4,A3),D0
            bra.b   .L13
.L12:
            moveq   #2,D0
.L13:
            bsr.b   AddSPEntry
            bsr.w   TFSVCBTst
            bne.b   .L15
            move.w  BootDrive,D0
            bge.b   .L14
            cmpi.w  #$F000,D0
            bgt.b   .L14
            bsr.w   sub_4080F4FA
            bne.b   .L14
            cmp.w   ($4E,A2),D2
            bne.b   .L14
            move.l  (4,A3),D0
            bsr.b   AddSPEntry
.L14:
            movea.l ($3EE).w,A2
            move.l  ($7A,A2),D0
            beq.b   .L15
            bsr.b   AddSPEntry
.L15:
            clr.w   (0,A4,D4.w)
            moveq   #2,D4
            move.w  D4,(-2,A4)
            move.l  (-6,A4),D0
            beq.b   .L16
            movea.l D0,A1
            jsr     (A1)
.L16:
            move.w  (0,A4,D4.w),D0
            bsr.w   GetVCBRfn
            bne.b   .L17
            movea.l ($372).w,A3
            lea     ($12,A3),A3
            move.l  A2,(A3)
            move.l  (2,A4,D4.w),(4,A3)
            clr.l   (8,A3)
            clr.l   ($C,A3)
            moveq   #0,D0
.L17:
            movem.l (SP)+,D2/D4/A1/A4
            rts
AddSPEntry:
            move.l  D4,-(SP)
            moveq   #2,D4
.L1:
            cmp.l   (SP),D4
            bcc.b   .L4
            cmp.w   (0,A4,D4.w),D2
            bne.b   .L2
            cmp.l   (2,A4,D4.w),D0
            beq.b   .L3
.L2:
            addq.w  #6,D4
            cmp.w   (A4),D4
            bcs.b   .L1
.L3:
            moveq   #0,D0
.L4:
            move.l  (SP)+,D4
            tst.l   D0
            beq.b   .L5
            move.w  D2,(0,A4,D4.w)
            move.l  D0,(2,A4,D4.w)
            addq.w  #6,D4
.L5:
            rts
.L6:
            move.l  ($12,A0),D2
sub_40810056:
            move.l  ($6C4).w,-(SP)
            rts
vDtrmV2:
            movem.l D4-D6/A0-A1,-(SP)
            tst.l   D2
            beq.b   .L5
            movea.l D2,A4
            moveq   #0,D2
            movea.l D2,A3
            move.b  (A4)+,D2
            beq.b   .L5
            moveq   #0,D3
.L1:
            move.b  (0,A4,D3.w),D4
            cmpi.b  #$3A,D4
            beq.b   .L2
            addq.w  #1,D3
            cmp.w   D3,D2
            bne.b   .L1
            bra.b   .L3
.L2:
            sub.l   D3,D2
            subq.w  #1,D2
            movea.l A4,A1
            adda.l  D3,A4
            addq.l  #1,A4
            tst.w   D3
            bgt.b   .L6
.L3:
            bsr.w   DtrmV1
.L4:
            movem.l (SP)+,D4-D6/A0-A1
            tst.w   D0
            rts
.L5:
            moveq   #-$25,D0
            bra.b   .L4
.L6:
            move.l  ($358).w,D0
.L7:
            beq.b   .L9
            movea.l D0,A2
            lea     ($2C,A2),A0
            moveq   #0,D0
            move.b  (A0)+,D0
            swap    D0
            move.w  D3,D0
            _CmpString
            bne.b   .L8
            move.l  A2,($3EE).w
            bra.b   .L4
.L8:
            move.l  (A2),D0
            bne.b   .L7
.L9:
            moveq   #-$23,D0
            bra.b   .L4
            bsr.w   FSQueue
            move.l  ($1C,A0),D0
            bmi.b   .L10
            movea.l ($386).w,A1
            move.l  D0,(-6,A1)
.L10:
            move.w  ($1A,A0),D0
            bclr    #6,($376).w
            btst    #0,D0
            bne.b   .L11
            bset    #6,($376).w
.L11:
            moveq   #0,D0
            bra.w   CmdDone
GetVolInfo:
            bsr.w   FSQueue
            move.w  ($1C,A0),D2
            bgt.b   .L3
            beq.b   .L1
            bsr.w   DtrmV3
            bra.b   .L2
.L1:
            bsr.w   DtrmV1
.L2:
            bne.w   .L22
            bra.b   .L5
.L3:
            moveq   #0,D3
            clr.w   ($16,A0)
            move.l  ($358).w,D1
.L4:
            beq.w   GetVol.L2
            subq.w  #1,D2
            movea.l D1,A2
            beq.b   .L5
            move.l  (A2),D1
            bra.b   .L4
.L5:
            moveq   #$20,D0
.L6:
            move.w  ($A,A2,D0.w),($1E,A0,D0.w)
            subq.w  #2,D0
            bpl.b   .L6
            bset    #6,($27,A0)
            bsr.w   sub_408108C6
.L7:
            cmpa.l  ($14,A1,D1.w),A2
            bne.b   .L8
            bsr.w   TFSVCBTst
            bne.b   .L9
            move.l  (0,A1,D1.w),D0
            cmpi.l  #$10,D0
            bcc.b   .L9
.L8:
            bsr.w   sub_408108CE
            bcs.b   .L7
            bclr    #6,($27,A0)
.L9:
            bclr    #5,($27,A0)
            cmpa.l  ($352).w,A2
            bne.b   .L10
            bset    #5,($27,A0)
.L10:
            suba.l  A3,A3
            tst.w   ($1C,A0)
            bgt.b   .L14
            tst.w   D3
            bne.b   .L14
            move.w  ($16,A0),D1
            bgt.b   .L14
            blt.b   .L11
            moveq   #2,D1
            bra.b   .L12
.L11:
            cmpi.w  #$F000,D1
            bgt.b   .L14
            subi.w  #$8001,D1
.L12:
            movea.l ($372).w,A3
            adda.w  D1,A3
            bsr.w   ExtOffLinCk
            bne.b   .L14
            movem.l A0-A1,-(A6)
            movea.l ($372).w,A1
            move.l  (4,A1,D1.w),D0
            cmpi.l  #2,D0
            beq.b   .L13
            move.l  (8,A1,D1.w),D2
            suba.l  A0,A0
            jsr     (CMGetCN.w,PC)
            bne.b   .L13
            move.w  (4,A1),D0
            movem.l (A6)+,A0-A1
            move.w  D0,($28,A0)
            bra.b   .L14
.L13:
            movem.l (A6)+,A0-A1
.L14:
            tst.w   D3
            bne.b   .L15
            tst.w   ($16,A0)
            blt.b   .L16
.L15:
            move.w  ($4E,A2),($16,A0)
.L16:
            bsr.w   XferVName
            bsr.w   TFSVCBTst
            bne.b   .L17
            move.w  ($A0,A2),D0
            sub.w   D0,($2E,A0)
            move.w  ($A2,A2),D0
            sub.w   D0,($2E,A0)
.L17:
            btst    #9,(6,A0)
            bne.b   .L19
            move.w  #$7C00,D0
            cmp.w   ($2E,A0),D0
            bhi.b   .L18
            move.w  D0,($2E,A0)
            cmp.w   ($3E,A0),D0
            bhi.b   .L18
            move.w  D0,($3E,A0)
.L18:
            bra.b   .L20
.L19:
            move.w  ($4E,A2),($16,A0)
            move.w  (8,A2),($40,A0)
            move.w  ($48,A2),($42,A0)
            move.w  ($4A,A2),($44,A0)
            move.w  ($4C,A2),($46,A0)
            clr.l   ($52,A0)
            move.w  ($14,A2),($54,A0)
            clr.l   ($56,A0)
            move.w  #1,($58,A0)
            bsr.w   TFSVCBTst
            bne.b   .L21
            move.l  ($5E,A2),($48,A0)
            move.w  ($62,A2),($4C,A0)
            move.l  ($64,A2),($4E,A0)
            move.l  ($72,A2),($52,A0)
            move.l  ($76,A2),($56,A0)
            move.l  A0,-(SP)
            lea     ($5A,A0),A1
            lea     ($7A,A2),A0
            moveq   #$20,D0
            _BlockMove
            movea.l (SP)+,A0
.L20:
            move.l  A2,($3EE).w
            bsr.w   TFSVCBTst
            bne.b   .L21
            bsr.w   sub_4080FEFA
            bne.b   .L22
.L21:
            moveq   #0,D0
.L22:
            bra.w   CmdDone
SetVolInfo:
            bsr.w   FSQueue
            bsr.w   DtrmV1
            bne.b   .L3
            bsr.w   CVFlgs
            bne.b   .L3
            bsr.w   ExtOffLinCk
            bne.b   .L3
            move.l  ($1E,A0),($A,A2)
            move.l  ($22,A0),($E,A2)
            move.w  ($26,A0),D0
            andi.w  #$8000,D0
            move.w  ($12,A2),D1
            andi.w  #$7FFF,D1
            or.w    D0,D1
            move.w  D1,($12,A2)
            bsr.w   TFSVCBTst
            bne.b   .L1
            move.l  ($34,A0),($20,A2)
            move.l  ($48,A0),($5E,A2)
            move.w  ($4C,A0),($62,A2)
            move.l  A0,-(SP)
            lea     ($5A,A0),A0
            lea     ($7A,A2),A1
            moveq   #$20,D0
            _BlockMove
            movea.l (SP)+,A0
.L1:
            move.l  ($12,A0),D0
            beq.b   .L2
            movea.l D0,A1
            bsr.b   SetVolName
.L2:
            bsr.w   MarkVCB
            moveq   #0,D0
.L3:
            bra.w   CmdDone
SetVolName:
            movem.l A1-A2,-(SP)
            lea     ($2C,A2),A2
            moveq   #1,D0
.L1:
            cmp.b   (A1),D0
            bgt.b   .L2
            cmpi.b  #$3A,(0,A1,D0.w)
            beq.b   .L2
            cmpi.b  #$1B,D0
            bgt.b   .L2
            move.b  (0,A1,D0.w),(0,A2,D0.w)
            addq.w  #1,D0
            bra.b   .L1
.L2:
            subq.w  #1,D0
            move.b  D0,(A2)
            movem.l (SP)+,A1-A2
            bsr.w   MarkVCB
            rts
CVFlgs:
            moveq   #-$2E,D0
            tst.w   ($12,A2)
            bmi.b   .L1
            moveq   #-$2C,D0
            tst.b   ($13,A2)
            bmi.b   .L1
            moveq   #0,D0
.L1:
            rts
GetVol:
            btst    #9,D1
            bne.w   GetDir
            bsr.w   FSQueue
            move.l  ($352).w,D0
            beq.b   .L2
            movea.l D0,A2
            move.w  ($384).w,($16,A0)
            bsr.b   XferVName
.L1:
            bra.w   CmdDone
.L2:
            moveq   #-$23,D0
            bra.b   .L1
XferVName:
            movem.l A1-A2,-(SP)
            lea     ($2C,A2),A2
            move.l  ($12,A0),D0
            beq.b   .L2
            _StripAddress
            movea.l D0,A1
            moveq   #0,D0
            move.b  (A2),D0
.L1:
            move.b  (A2)+,(A1)+
            dbra    D0,.L1
.L2:
            movem.l (SP)+,A1-A2
            moveq   #0,D0
            rts
SetVol:
            btst    #9,D1
            bne.b   SetDir
            bsr.w   FSQueue
            bsr.w   DtrmV3
            bne.b   .L4
            move.w  ($4E,A2),D0
            tst.w   D3
            bne.b   .L1
            tst.w   ($16,A0)
            bgt.b   .L1
            move.w  ($16,A0),D0
            beq.b   .L2
.L1:
            move.w  D0,($384).w
.L2:
            moveq   #2,D6
            move.l  A3,D7
            beq.b   .L3
            move.l  (4,A3),D6
            move.l  (8,A3),D7
.L3:
            bsr.w   sub_40810474
            moveq   #0,D0
.L4:
            bra.w   CmdDone
SetDir:
            bsr.w   FSQueue
            bsr.w   FndFilName
            beq.b   .L1
            cmpi.w  #$FFDB,D0
            bne.b   .L3
            tst.b   D2
            bne.b   .L3
            moveq   #2,D6
            bra.b   .L2
.L1:
            moveq   #-$78,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            move.l  (6,A5),D6
.L2:
            move.w  ($4E,A2),($384).w
            moveq   #0,D7
            bsr.b   sub_40810474
            moveq   #0,D0
.L3:
            bra.w   CmdDone
GetDir:
            bsr.w   FSQueue
            bsr.w   sub_40810CA8
            moveq   #-$23,D0
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            bsr.w   RetDefInfo
            bsr.w   XferVName
            move.w  ($384).w,($16,A0)
            moveq   #0,D0
.L1:
            bra.w   CmdDone
OpenWD:
            bsr.w   FSQueue
            bsr.w   FndFilName
            beq.b   .L1
            cmpi.w  #$FFDB,D0
            bne.b   .L3
            tst.b   D2
            bne.b   .L3
            bra.b   .L2
.L1:
            moveq   #-$78,D0
            cmpi.b  #1,(A5)
            bne.b   .L3
            move.l  (6,A5),D6
            cmpi.l  #2,D6
            beq.b   .L2
            moveq   #0,D7
            bsr.b   sub_40810498
            bra.b   .L3
.L2:
            move.w  ($4E,A2),($16,A0)
            moveq   #0,D0
.L3:
            bra.w   CmdDone
sub_40810474:
            move.l  A2,($352).w
            moveq   #2,D1
FillWDCB:
            movea.l ($372).w,A1
            move.l  A2,(0,A1,D1.w)
            move.l  D6,(4,A1,D1.w)
            move.l  D7,(8,A1,D1.w)
            move.l  ($1C,A0),D0
            move.l  D0,($C,A1,D1.w)
            addi.w  #$8001,D1
            rts
sub_40810498:
            move.l  ($1C,A0),D3
            moveq   #0,D2
            bsr.w   sub_40810CA8
            bsr.w   sub_40810CB0
.L1:
            bsr.w   sub_40810CB0
            bcc.b   .L3
            tst.l   (0,A1,D1.w)
            bne.b   .L2
            tst.w   D2
            bne.b   .L1
            move.w  D1,D2
            bra.b   .L1
.L2:
            cmpa.l  (0,A1,D1.w),A2
            bne.b   .L1
            cmp.l   (4,A1,D1.w),D6
            bne.b   .L1
            cmp.l   ($C,A1,D1.w),D3
            bne.b   .L1
            addi.w  #$8001,D1
            bra.b   .L4
.L3:
            move.w  D2,D1
            beq.b   .L5
            bsr.b   FillWDCB
.L4:
            move.w  D1,($16,A0)
            moveq   #0,D0
            rts
.L5:
            moveq   #-$79,D0
            rts
CloseWD:
            bsr.w   FSQueue
            moveq   #0,D1
            move.w  ($16,A0),D1
            bsr.w   sub_40810604
            beq.b   .L1
            cmpi.w  #$F000,D1
            bhi.b   .L3
            bra.b   .L4
.L1:
            subi.w  #$8001,D1
            movea.l (0,A1,D1.w),A2
            tst.w   ($4C,A2)
            beq.b   .L2
            move.l  A2,($3EE).w
            add.l   A1,D1
            moveq   #-$3A,D0
            bra.b   .L4
.L2:
            clr.l   (0,A1,D1.w)
.L3:
            moveq   #0,D0
.L4:
            bra.w   CmdDone
GetWDInfo:
            bsr.w   FSQueue
            bsr.b   GetWDCBInfo
            bne.b   .L1
            ext.l   D1
            add.l   A1,D1
            move.l  A2,($3EE).w
            bsr.w   sub_4080FEFA
            bne.b   .L1
            moveq   #0,D0
.L1:
            bra.w   CmdDone
GetWDCBInfo:
            tst.w   ($1A,A0)
            bgt.b   .L2
            moveq   #0,D1
            move.w  ($16,A0),D1
            bsr.w   sub_40810604
            beq.b   .L1
            bsr.w   DtrmV1
            bne.b   .L9
            clr.l   ($1C,A0)
            moveq   #2,D0
            move.l  D0,($30,A0)
            move.w  ($4E,A2),($20,A0)
            move.w  ($4E,A2),($16,A0)
            moveq   #0,D1
            bra.b   .L8
.L1:
            moveq   #-$23,D0
            subi.w  #$8001,D1
            tst.l   (0,A1,D1.w)
            beq.b   .L9
            bra.b   .L7
.L2:
            moveq   #-$23,D0
            moveq   #0,D2
            tst.w   ($16,A0)
            beq.b   .L3
            bsr.w   DtrmV3
            bne.b   .L9
            move.l  A2,D2
.L3:
            move.w  ($1A,A0),D4
            move.l  ($1C,A0),D3
            moveq   #-$23,D0
            bsr.w   sub_40810CA8
            bsr.w   sub_40810CB0
.L4:
            bsr.w   sub_40810CB0
            bcc.b   .L9
            tst.l   (0,A1,D1.w)
            beq.b   .L4
            tst.l   D3
            beq.b   .L5
            cmp.l   ($C,A1,D1.w),D3
            bne.b   .L4
.L5:
            tst.l   D2
            beq.b   .L6
            cmp.l   (0,A1,D1.w),D2
            bne.b   .L4
.L6:
            subq.w  #1,D4
            bgt.b   .L4
.L7:
            bsr.b   sub_408105E2
.L8:
            bsr.w   XferVName
.L9:
            tst.w   D0
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   GetWDCBInfo
            movem.l (SP)+,D3-D7/A1-A6
            move.w  D0,($10,A0)
            rts
sub_408105E2:
            move.l  ($C,A1,D1.w),($1C,A0)
RetDefInfo:
            movea.l (0,A1,D1.w),A2
            move.w  ($4E,A2),($20,A0)
            move.l  (4,A1,D1.w),($30,A0)
            move.w  D1,D0
            addi.w  #$8001,D0
            move.w  D0,($16,A0)
            rts
sub_40810604:
            move.l  D1,-(SP)
            moveq   #-$33,D0
            subi.w  #$8001,D1
            movea.l ($372).w,A1
            cmp.w   (A1),D1
            bcc.b   .L1
            subq.w  #2,D1
            divu.w  #$10,D1
            swap    D1
            tst.w   D1
            bne.b   .L1
            move.l  (SP),D1
            subi.w  #$8001,D1
            tst.l   (0,A1,D1.w)
            beq.b   .L1
            moveq   #0,D0
.L1:
            move.l  (SP)+,D1
            tst.w   D0
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   DtrmV1
            bne.b   .L3
            move.l  ($30,A0),D6
            moveq   #0,D7
            bsr.w   sub_40810498
            bne.b   .L3
            move.w  D1,($16,A0)
.L2:
            moveq   #0,D0
.L3:
            movem.l (SP)+,D3-D7/A1-A6
            move.w  D0,($10,A0)
            rts
            movem.l D3-D7/A1-A6,-(SP)
            movea.l ($36A).w,A6
            bsr.w   DtrmV1
            bne.b   .L3
            move.w  ($4E,A2),($384).w
            move.l  ($30,A0),D6
            moveq   #0,D7
            bsr.w   sub_40810474
            bra.b   .L2
