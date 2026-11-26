            include "Include/ROMHeader.s"

            EXPORT  CLKNOMEMPATCH,CLOCKPATCH

            SECTION "ClockPatch",CODE

CLOCKPATCH:
PRAMIO:
            movem.l D0-D2/A1-A2,-(SP)
            andi.b  #$70,D1
            cmpi.b  #$20,D1
            bne.b   .L2
            movea.l (8,A0),A1
            bclr    #$1F,D3
            beq.b   .L1
            bsr.w   sub_408840CE
            bra.b   .L5
.L1:
            bsr.b   sub_40884082
            bra.b   .L5
.L2:
            movea.l (8,A0),A1
            move.l  D3,D0
            swap    D0
            subq.w  #1,D0
            bclr    #$F,D0
            beq.b   .L4
            moveq   #$35,D1
            moveq   #$55,D2
            bsr.w   CLKNOMEMPATCH
.L3:
            move.w  D3,D1
            rol.w   #3,D1
            ror.b   #1,D1
            ror.w   #8,D1
            andi.w  #$7C07,D1
            ori.b   #$38,D1
            move.b  (A3)+,D2
            bsr.w   CLKNOMEMPATCH
            addq.w  #1,D3
            dbra    D0,.L3
            moveq   #$35,D1
            moveq   #-$2B,D2
            bsr.w   CLKNOMEMPATCH
            bra.b   .L5
.L4:
            move.w  D3,D1
            rol.w   #3,D1
            ror.b   #1,D1
            ror.w   #8,D1
            andi.w  #$7C07,D1
            ori.b   #$B8,D1
            bsr.w   CLKNOMEMPATCH
            move.b  D2,(A3)+
            addq.w  #1,D3
            dbra    D0,.L4
.L5:
            movem.l (SP)+,D0-D2/A1-A2
            rts
sub_40884082:
            bsr.w   sub_40884112
            bset    #5,(A1)
            moveq   #1,D4
            bsr.w   sub_4088411C
            moveq   #7,D4
            bsr.w   sub_4088411C
            moveq   #0,D4
            bsr.w   sub_4088411C
            move.w  D3,D4
            bsr.w   sub_4088411C
            bclr    #5,(A1)
            bsr.w   sub_4088417A
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            swap    D3
            subq.w  #1,D3
            bra.b   .L2
.L1:
            bsr.w   sub_4088413E
            move.b  D4,(A3)+
.L2:
            dbra    D3,.L1
            bsr.w   sub_40884156
            move.b  D4,(A3)+
            rts
sub_408840CE:
            bsr.w   sub_40884112
            bset    #5,(A1)
            moveq   #1,D4
            bsr.w   sub_4088411C
            moveq   #8,D4
            bsr.w   sub_4088411C
            moveq   #1,D4
            bsr.w   sub_4088411C
            move.w  D3,D4
            bsr.w   sub_4088411C
            swap    D3
            subq.w  #1,D3
.L1:
            move.b  (A3)+,D4
            bsr.w   sub_4088411C
            dbra    D3,.L1
            bclr    #5,(A1)
            bsr.w   sub_4088417A
            bsr.w   sub_4088413E
            bsr.w   sub_4088413E
            bsr.w   sub_40884156
            rts
sub_40884112:
            moveq   #$50,D5
.L1:
            tst.b   (A1)
            dbra    D5,.L1
            rts
sub_4088411C:
            bset    #4,($1600,A1)
            move.b  D4,($1400,A1)
            bset    #4,(A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bclr    #4,(A1)
            bsr.b   sub_40884112
            rts
sub_4088413E:
            btst    #2,($1A00,A1)
            beq.b   sub_4088413E
            move.b  ($1400,A1),D4
            bset    #4,(A1)
            bsr.b   sub_40884112
            bclr    #4,(A1)
            rts
sub_40884156:
            btst    #2,($1A00,A1)
            beq.b   sub_40884156
            move.b  ($1400,A1),D4
            bset    #4,(A1)
            bsr.b   sub_40884112
            bclr    #5,(A1)
.L1:
            btst    #3,(A1)
            beq.b   .L1
            bclr    #4,(A1)
            bsr.b   sub_40884112
            rts
sub_4088417A:
            bclr    #4,($1600,A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bsr.b   sub_40884112
            bsr.b   sub_40884112
            bset    #5,(A1)
            rts
            moveq   #$35,D1
            moveq   #-$2B,D2
            bsr.b   sub_408841A6
            rts
            moveq   #$35,D1
            moveq   #$55,D2
            bsr.b   sub_408841A6
            rts
sub_408841A6:
            movem.l A0-A1,-(SP)
            movea.l VIA,A1
            movea.l ($54C).w,A0
            jsr     (A0)
            movem.l (SP)+,A0-A1
            rts
CLKNOMEMPATCH:
            movem.l D1/D3-D4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #-7,D3
            and.b   (A1),D3
            moveq   #$78,D4
            and.w   D1,D4
            cmpi.w  #$38,D4
            bne.b   .L1
            move.w  D1,D4
            swap    D1
            move.w  D4,D1
            bsr.b   sub_408841FC
            lsr.l   #8,D1
            tst.w   D1
            bra.b   .L2
.L1:
            tst.b   D1
.L2:
            bmi.b   .L3
            bsr.b   sub_408841FC
            move.w  D2,D1
            bsr.b   sub_408841FC
            bra.b   .L4
.L3:
            bsr.b   sub_408841FC
            bsr.b   sub_40884210
.L4:
            bset    #2,(A1)
            move    (SP)+,SR
            movem.l (SP)+,D1/D3-D4
            rts
sub_408841FC:
            moveq   #7,D4
.L1:
            ror.b   #1,D3
            roxl.b  #1,D1
            roxl.b  #1,D3
            move.b  D3,(A1)
            bset    #1,(A1)
            dbra    D4,.L1
            rts
sub_40884210:
            moveq   #7,D4
            bclr    #0,($400,A1)
.L1:
            move.b  D3,(A1)
            bset    #1,(A1)
            move.b  (A1),D1
            lsr.b   #1,D1
            roxl.b  #1,D2
            dbra    D4,.L1
            bset    #0,($400,A1)
            rts
            ds.b    464

            EVEN
