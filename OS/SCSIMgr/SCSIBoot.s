            include "Include/ROMHeader.s"

            EXPORT  SCSIBoots

            IMPORT  SCSIMISCPATCH

            SECTION "SCSIBoot",CODE

SCSIBoots:
SCSILoad:
            btst    #7,HWCfgFlags
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            movem.l D1-D7/A0-A6,-(SP)
            move.b  D0,-(SP)
            moveq   #7,D5
.L2:
            btst    D5,(SP)
            beq.b   .L3
            btst    D5,SCSIDrvrs
            bne.b   .L3
            bsr.b   sub_40807224
            beq.b   .L3
            bclr    D5,(SP)
.L3:
            dbra    D5,.L2
            moveq   #0,D0
            move.b  (SP)+,D0
            movem.l (SP)+,D1-D7/A0-A6
            tst.w   D0
            rts
sub_40807224:
            move.l  D3,-(SP)
            link.w  A6,#-$212
            movea.l SP,A2
            swap    D3
            moveq   #0,D0
            move.b  D3,D0
            move.w  D0,(-$A,A6)
            moveq   #0,D3
            moveq   #1,D2
            move.w  #$200,D4
            bsr.w   sub_4080738A
            bne.w   .L4
            cmpi.w  #$4552,(SP)
            bne.w   .L6
            move.w  (2,SP),D4
            move.w  ($10,SP),D0
            beq.b   .L6
            lea     ($12,SP),A0
            move.l  ($C,SP),D7
.L1:
            move.w  (-$A,A6),D1
            cmp.w   (6,A0),D1
            beq.b   .L2
            addq.l  #8,A0
            subq.w  #1,D0
            bne.b   .L1
            bra.b   .L6
.L2:
            bset    D5,SCSIDrvrs
            move.l  (A0),D3
            move.l  D3,(-4,A6)
            moveq   #0,D2
            move.w  (4,A0),D2
            move.l  D2,(-8,A6)
            move.l  D4,D0
            mulu.w  D2,D0
            _NewPtrSys
            bne.b   .L6
            movea.l A0,A3
            movea.l A0,A2
            bsr.w   sub_4080738A
            bne.b   .L5
            moveq   #1,D3
            move.l  D3,(-$12,A6)
            moveq   #1,D2
            move.w  #$200,D4
            movea.l SP,A2
            bsr.w   sub_4080738A
            bne.b   .L5
            cmpi.w  #1,(-$A,A6)
            bne.b   .L3
            cmpi.w  #$5453,(A2)
            beq.b   .L3
            cmpi.w  #$504D,(A2)
            bne.b   .L3
            move.l  (4,A2),D0
            move.l  D0,(-$E,A6)
            bra.b   .L8
.L3:
            movea.l A2,A0
            jsr     (A3)
.L4:
            moveq   #0,D0
            bra.b   .L7
.L5:
            movea.l A3,A0
            _DisposPtr
.L6:
            moveq   #-1,D0
.L7:
            unlk    A6
            move.l  (SP)+,D3
            tst.w   D0
            rts
.L8:
            cmpi.l  #'Appl',($30,A2)
            bne.b   .L9
            cmpi.l  #'e_Dr',($34,A2)
            bne.b   .L9
            cmpi.l  #'iver',($38,A2)
            bne.b   .L9
            cmpi.l  #'Maci',($10,A2)
            bne.b   .L9
            move.l  (-4,A6),D0
            cmp.l   (8,A2),D0
            bne.b   .L9
            movea.l A3,A0
            move.l  ($60,A2),D1
            bsr.w   sub_40807444
            cmp.l   ($74,A2),D0
            beq.b   .L10
            bra.b   .L5
.L9:
            addq.l  #1,(-$12,A6)
            move.l  (-$12,A6),D3
            cmp.l   (-$E,A6),D3
            bhi.b   .L10
            moveq   #1,D2
            move.w  #$200,D4
            bsr.b   sub_4080738A
            bne.b   .L9
            cmpi.w  #$504D,(A2)
            bne.b   .L9
            bra.b   .L8
.L10:
            moveq   #0,D0
            move.l  D0,(-$12,A6)
.L11:
            addq.l  #1,(-$12,A6)
            move.l  (-$12,A6),D3
            cmp.l   (-$E,A6),D3
            bhi.w   .L5
            moveq   #1,D2
            move.w  #$200,D4
            bsr.b   sub_4080738A
            bne.b   .L11
            cmpi.w  #$504D,(A2)
            bne.b   .L11
            cmpi.l  #'Appl',($30,A2)
            bne.b   .L11
            cmpi.l  #'e_HF',($34,A2)
            bne.b   .L11
            cmpi.b  #$53,($38,A2)
            bne.b   .L11
            bra.w   .L3
sub_4080738A:
            move.l  D7,-(SP)
            moveq   #0,D7
            swap    D2
            move.w  D4,D2
.L1:
            lea     Scratch8,A0
            move.b  #8,(A0)+
            swap    D3
            andi.b  #$1F,D3
            move.b  D3,(A0)+
            swap    D3
            move.w  D3,(A0)+
            move.l  D2,D4
            swap    D4
            move.b  D4,(A0)+
            clr.b   (A0)+
            mulu.w  D2,D4
            suba.w  #$14,SP
            move.l  SP,D6
            subq.l  #2,SP
            move.w  #1,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L5
            move.w  D5,-(SP)
            move.w  #2,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L5
            pea     Scratch8
            move.w  #6,-(SP)
            move.w  #3,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
            bne.b   .L2
            movea.l D6,A0
            move.w  #1,(A0)+
            move.l  A2,(A0)+
            move.l  D4,(A0)+
            move.w  #7,(A0)
            move.l  D6,-(SP)
            move.w  #5,-(SP)
            _SCSIDispatch
            move.w  (SP),D7
.L2:
            pea     Scratch8
            pea     ($9FC).w
            move.l  #$3C,-(SP)
            move.w  #4,-(SP)
            _SCSIDispatch
            tst.w   D7
            beq.b   .L3
            cmpi.w  #5,D7
            beq.b   .L4
.L3:
            move.w  (SP),D7
            cmpi.w  #$A,D7
            bne.b   .L5
.L4:
            move.w  Scratch8,D7
            beq.b   .L5
            cmpi.w  #2,D7
            bne.b   .L5
            bset    #$1F,D7
            bne.b   .L5
            lea     ($16,SP),SP
            bra.w   .L1
.L5:
            bra.l   SCSIMISCPATCH
            ds.b    6
sub_40807444:
            moveq   #0,D0
            moveq   #0,D7
            bra.b   .L2
.L1:
            move.b  (A0)+,D7
            add.w   D7,D0
            rol.w   #1,D0
.L2:
            dbra    D1,.L1
            tst.w   D0
            bne.b   .L3
            subq.w  #1,D0
.L3:
            rts
            ds.b    4

            EVEN
