            include "Include/ROMHeader.s"

            EXPORT  vCMSetUp,CMDeleteCN,CMGetCN,CMGetOff,CMMoveCN,CMRenameCN
            EXPORT  CMSvcs,CMUpdateCN

            IMPORT  MarkVCBTime,CMFLUSH,CMMAINT,LOCCNODE,LOCCREC,UPDCNAME
            IMPORT  BTDelete,BTGetRecord,BTINSERT,BTUpdate

            SECTION "CMSvcs",CODE

CMSvcs:
CMCreateCN:
            move.l  (SP)+,-(A6)
            movem.l D3-D7/A0-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D1,D5
            move.l  D0,D3
            movea.l A0,A3
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCREC.w,PC)
            bne.w   .L7
            move.l  D3,D0
            movea.l A3,A0
            lea     (A4),A1
            jsr     (CMMAINT.w,PC)
            lea     ($26,A4),A1
            movea.l A1,A0
            move.w  #$32,D0
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            move.b  D5,(A1)
            move.l  TimeLM,D2
            cmpi.b  #1,D5
            bne.b   .L2
            move.l  ($26,A2),D6
            move.l  D6,(6,A1)
            addq.l  #1,($26,A2)
            move.l  D2,($A,A1)
            move.l  D2,($E,A1)
            moveq   #$46,D1
            bra.b   .L3
.L2:
            move.l  D2,($2C,A1)
            move.l  D2,($30,A1)
            move.l  ($26,A2),($14,A1)
            addq.l  #1,($26,A2)
            swap    D5
            move.b  D5,(3,A1)
            swap    D5
            moveq   #$66,D1
.L3:
            move.w  ($A6,A2),D0
            lea     (A4),A0
            jsr     (BTINSERT.w,PC)
            beq.b   .L4
            cmpi.w  #$21,D0
            bne.w   .L7
            moveq   #$31,D0
            bra.w   .L7
.L4:
            move.l  D2,D7
            cmpi.b  #1,D5
            bne.b   .L6
            move.l  D6,D0
            suba.l  A0,A0
            lea     (A4),A1
            jsr     (CMMAINT.w,PC)
            lea     ($26,A4),A1
            move.w  #$16,D0
.L5:
            clr.w   (A1)+
            dbra    D0,.L5
            lea     ($26,A4),A1
            move.b  #3,(A1)
            move.l  D3,($A,A1)
            movea.l A3,A0
            lea     ($E,A1),A1
            jsr     (UPDCNAME.w,PC)
            move.w  ($A6,A2),D0
            move.w  #$2E,D1
            lea     (A4),A0
            lea     ($26,A4),A1
            jsr     (BTINSERT.w,PC)
            beq.b   .L6
            move.l  D0,-(A6)
            move.l  D3,D0
            movea.l A3,A0
            lea     (A4),A1
            jsr     (CMMAINT.w,PC)
            movea.l A1,A0
            move.w  ($A6,A2),D0
            jsr     (BTDelete.w,PC)
            move.l  (A6)+,D0
            cmpi.w  #$21,D0
            bne.b   .L7
            moveq   #$31,D0
            bra.b   .L7
.L6:
            move.l  D3,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.b   .L7
            addq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.b   .L7
            move.b  D5,D0
            move.l  D3,D1
            moveq   #1,D2
            bsr.w   sub_40812F14
            clr.w   D0
            move.l  D6,D1
            move.l  D7,D2
            jsr     (MarkVCBTime.w,PC)
            jsr     (CMFLUSH.w,PC)
.L7:
            lea     ($8C,A6),A6
            movem.l (A6)+,D3-D7/A0-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMDeleteCN:
            move.l  (SP)+,-(A6)
            movem.l D1-D6/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D0,D3
            movea.l A0,A3
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L4
            move.b  (A1),D4
            move.l  (2,A0),D6
            cmpi.b  #1,D4
            bne.b   .L2
            move.l  (6,A1),D5
            cmpi.l  #2,D5
            bne.b   .L1
            moveq   #$33,D0
            bra.b   .L4
.L1:
            tst.w   (4,A1)
            beq.b   .L2
            moveq   #$32,D0
            bra.b   .L4
.L2:
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     (BTDelete.w,PC)
            bne.b   .L4
            cmpi.b  #1,D4
            bne.b   .L3
            suba.l  A0,A0
            move.l  D5,D0
            lea     (A4),A1
            jsr     (CMMAINT.w,PC)
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     (BTDelete.w,PC)
            bne.b   .L4
.L3:
            move.l  D6,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.b   .L4
            subq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.b   .L4
            move.b  D4,D0
            move.l  D6,D1
            moveq   #-1,D2
            bsr.w   sub_40812F14
            clr.w   D0
            jsr     (MarkVCBTime.w,PC)
            jsr     (CMFLUSH.w,PC)
.L4:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1-D6/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMGetCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            jsr     (LOCCNODE.w,PC)
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMGetOff:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D4/A4,-(A6)
            bsr.w   CMSetUp
            move.l  D0,D3
            move.w  D1,D4
            move.l  ($AC,A2),D1
            beq.b   .L1
            cmp.l   D3,D1
            beq.b   .L2
.L1:
            clr.l   ($AC,A2)
            move.l  D3,D0
            suba.l  A0,A0
            jsr     (LOCCREC.w,PC)
            bne.b   .L6
            move.l  D3,($AC,A2)
            clr.w   ($B0,A2)
.L2:
            move.w  ($A6,A2),D0
            move.w  D4,D1
            sub.w   ($B0,A2),D1
            jsr     (BTGetRecord.w,PC)
            beq.b   .L5
            cmpi.w  #$20,D0
            bne.b   .L4
.L3:
            moveq   #$30,D0
.L4:
            clr.l   ($AC,A2)
            bra.b   .L6
.L5:
            cmp.l   (2,A0),D3
            bne.b   .L3
            move.w  D4,($B0,A2)
.L6:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D4/A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMMoveCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D1,D5
            move.l  A1,D6
            move.l  D0,D3
            movea.l A0,A3
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L11
            moveq   #0,D4
            cmpi.b  #1,(A1)
            bne.b   .L1
            move.l  (6,A1),D4
.L1:
            move.l  D5,D0
            movea.l D6,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L11
            cmpi.b  #1,(A1)
            beq.b   .L2
            move.w  #$FF86,D0
            bra.w   .L11
.L2:
            move.l  (6,A1),D7
            tst.l   D4
            beq.b   .L5
            cmpi.l  #2,D4
            beq.b   .L4
            cmp.l   D4,D7
            beq.b   .L4
.L3:
            move.l  (2,A0),D0
            cmp.l   D4,D0
            beq.b   .L4
            cmpi.l  #2,D0
            ble.b   .L5
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L11
            bra.b   .L3
.L4:
            move.w  #$FF86,D0
            bra.w   .L11
.L5:
            move.l  D3,D0
            movea.l A3,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L11
            cmp.l   (2,A0),D7
            bne.b   .L6
            move.l  D2,D7
            bra.w   .L10
.L6:
            move.l  A1,-(SP)
            lea     (A4),A1
            moveq   #1,D0
            add.b   (A0),D0
            _BlockMove
            movea.l (SP)+,A0
            lea     ($26,A4),A1
            move.w  D1,D0
            ext.l   D0
            _BlockMove
            lea     (A4),A0
            move.l  (2,A0),D4
            move.l  D7,(2,A0)
            lea     ($26,A4),A1
            moveq   #$66,D1
            cmpi.b  #2,(A1)
            beq.b   .L7
            moveq   #$46,D1
            move.l  TimeLM,($E,A1)
.L7:
            move.w  ($A6,A2),D0
            jsr     (BTINSERT.w,PC)
            beq.b   .L8
            cmpi.w  #$21,D0
            bne.w   .L11
            moveq   #$31,D0
            bne.w   .L11
.L8:
            move.l  D2,D7
            move.l  (2,A0),D0
            exg     D5,D0
            movea.l D6,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L11
            addq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.w   .L11
            lea     ($26,A4),A1
            move.b  (A1),D0
            move.l  D5,D1
            moveq   #1,D2
            bsr.w   UpdRtCnts
            move.l  D3,D0
            movea.l A3,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.b   .L11
            lea     (A4),A0
            move.w  ($A6,A2),D0
            jsr     (BTDelete.w,PC)
            bne.b   .L11
            lea     ($26,A4),A1
            cmpi.b  #1,(A1)
            bne.b   .L9
            move.l  (6,A1),D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCREC.w,PC)
            bne.b   .L11
            move.l  D5,($A,A1)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.b   .L11
.L9:
            move.l  D4,D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.b   .L11
            subq.w  #1,(4,A1)
            move.l  TimeLM,($E,A1)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bne.b   .L11
            lea     ($26,A4),A1
            move.b  (A1),D0
            move.l  D4,D1
            moveq   #-1,D2
            bsr.w   UpdRtCnts
.L10:
            clr.w   D0
            move.l  D7,D2
            jsr     (MarkVCBTime.w,PC)
            jsr     (CMFLUSH.w,PC)
.L11:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMRenameCN:
            move.l  (SP)+,-(A6)
            movem.l D1/D3-D7/A0-A1/A3-A4,-(A6)
            bsr.w   CMSetUp
            clr.l   ($AC,A2)
            move.l  D0,D3
            movea.l A0,A3
            move.l  A1,D5
            jsr     (LOCCNODE.w,PC)
            bne.w   .L7
            move.l  D2,D4
            move.w  D1,D6
            movea.l A1,A0
            lea     ($26,A4),A1
            move.w  D6,D0
            ext.l   D0
            _BlockMove
            lea     (A4),A1
            move.l  (2,A1),D0
            movea.l D5,A0
            jsr     (CMMAINT.w,PC)
            movea.l A1,A0
            lea     ($26,A4),A1
            move.w  D6,D1
            move.w  ($A6,A2),D0
            jsr     (BTINSERT.w,PC)
            beq.b   .L4
            cmpi.w  #$21,D0
            bne.w   .L7
            lea     (A4),A1
            move.l  (2,A1),D0
            movea.l D5,A0
            moveq   #0,D2
            jsr     (LOCCNODE.w,PC)
            bne.w   .L7
            move.l  D2,D7
            move.l  A0,D6
            lea     ($26,A4),A0
            move.b  (A0),D0
            cmp.b   (A1),D0
            bne.b   .L2
            cmpi.b  #1,D0
            bne.b   .L1
            move.l  (6,A1),D1
            cmp.l   (6,A0),D1
            beq.b   .L3
            bra.b   .L2
.L1:
            move.l  ($14,A1),D1
            cmp.l   ($14,A0),D1
            beq.b   .L3
.L2:
            moveq   #$31,D0
            bra.b   .L7
.L3:
            movea.l D6,A1
            lea     (6,A1),A1
            movea.l D5,A0
            jsr     (UPDCNAME.w,PC)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            bra.b   .L5
.L4:
            move.l  D2,D7
            move.l  D3,D0
            movea.l A3,A0
            move.l  D4,D2
            jsr     (LOCCNODE.w,PC)
            bne.b   .L7
            lea     (A4),A0
            move.w  ($A6,A2),D0
            moveq   #0,D2
            jsr     (BTDelete.w,PC)
            bne.b   .L7
.L5:
            lea     ($26,A4),A1
            cmpi.b  #1,(A1)
            bne.b   .L6
            move.l  (6,A1),D0
            suba.l  A0,A0
            moveq   #0,D2
            jsr     (LOCCREC.w,PC)
            bne.b   .L7
            movea.l D5,A0
            lea     ($E,A1),A1
            jsr     (UPDCNAME.w,PC)
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
.L6:
            clr.w   D0
            move.l  D7,D2
            jsr     (MarkVCBTime.w,PC)
            jsr     (CMFLUSH.w,PC)
.L7:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1/D3-D7/A0-A1/A3-A4
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMUpdateCN:
            move.l  (SP)+,-(A6)
            movem.l D1-D2/A0-A1,-(A6)
            bsr.b   CMSetUp
            move.w  ($A6,A2),D0
            jsr     (BTUpdate.w,PC)
            beq.b   .L1
            cmpi.w  #$20,D0
            bne.b   .L2
            moveq   #$30,D0
            bra.b   .L2
.L1:
            jsr     (MarkVCBTime.w,PC)
            jsr     (CMFLUSH.w,PC)
.L2:
            lea     ($8C,A6),A6
            movem.l (A6)+,D1-D2/A0-A1
            move.l  (A6)+,-(SP)
            tst.w   D0
            rts
CMSetUp:
            move.l  ($770).w,-(SP)
            rts
vCMSetUp:
            suba.w  #$8C,A6
            movea.l A6,A4
            rts
sub_40812F14:
            cmpi.b  #1,D0
            bne.b   .L1
            add.l   D2,($76,A2)
            bra.b   UpdRtCnts
.L1:
            add.l   D2,($72,A2)
UpdRtCnts:
            cmpi.l  #2,D1
            bne.b   .L2
            cmpi.b  #1,D0
            bne.b   .L1
            add.w   D2,($70,A2)
            bra.b   .L2
.L1:
            add.w   D2,($14,A2)
.L2:
            rts
            dc.w    0

            EVEN
