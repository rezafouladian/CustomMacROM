            include "Include/ROMHeader.s"

            SECTION "TFBPrimaryInit",CODE

TFBPRIMARYINIT:
            dc.w    $6020
.L1:
            dc.w    $DFB8,$FFFF,$E11A,$88B9,$FAFD,$FDFE,$F0BE,$FA37
.L2:
            dc.w    $2047,$0008,$1EE5,$7746,$0502,$0201,$0F41,$05C8
            movem.l D0-D3/A0-A2,-(SP)
            move.w  #1,(2,A0)
            movea.l A0,A3
            moveq   #0,D0
            move.b  (A0),D0
            lsl.w   #4,D0
            or.b    (A0),D0
            ori.w   #$F00,D0
            swap    D0
            lsl.l   #4,D0
            movea.l D0,A2
            movea.l A2,A0
            adda.l  #$8FFFF,A0
            lea     .L1,A1
            moveq   #$F,D0
.L3:
            move.b  (A1)+,(A0)
            subq.w  #4,A0
            dbra    D0,.L3
            movea.l A2,A0
            adda.l  #$80003,A0
            lea     .L2,A1
            moveq   #$F,D0
.L4:
            move.b  (A1)+,D1
            not.b   D1
            move.b  D1,(A0)
            addq.w  #4,A0
            dbra    D0,.L4
            movea.l A2,A0
            adda.l  #$A0007,A0
            clr.b   (A0)
            move    SR,-(SP)
            moveq   #7,D0
            and.b   (SP),D0
            subq.b  #2,D0
            bge.b   .L5
            ori     #$200,SR
            andi    #$FAFF,SR
.L5:
            movea.l A2,A0
            adda.l  #$90003,A0
            moveq   #0,D0
            not.b   D0
            move.b  D0,($19,A0)
            adda.w  #$15,A0
            moveq   #-1,D1
            move.w  #$17F,D0
.L6:
            move.b  D1,(A0)
            dbra    D0,.L6
            moveq   #0,D1
            move.w  #$17F,D0
.L7:
            move.b  D1,(A0)
            dbra    D0,.L7
            move    (SP)+,SR
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  (A3),($31,A0)
            clr.b   ($33,A0)
            move.l  #$423FC,D1
            move.l  #'MAC2',(0,A2,D1.l)
            move.l  #$FFFFFFFF,-(SP)
            addq.w  #4,SP
            move.l  (0,A2,D1.l),D0
            cmpi.l  #'MAC2',D0
            beq.b   .L8
            move.b  #$80,($32,A0)
            bra.b   .L9
.L8:
            clr.b   (0,A2,D1.l)
            move.b  #$81,($32,A0)
.L9:
            _sDeleteSRTRec
            bne.b   .L10
            move.w  #2,(2,A3)
.L10:
            lea     ($38,SP),SP
            move.l  #$AAAAAAAA,D0
            move.l  D0,D1
            not.l   D1
            move.w  #$80,D4
            move.w  #$7FF,D3
            movea.l A2,A1
.L11:
            movea.l A1,A0
            move.w  #$1F,D2
.L12:
            move.l  D0,(A0)+
            dbra    D2,.L12
            exg     D0,D1
            adda.w  D4,A1
            dbra    D3,.L11
            movem.l (SP)+,D0-D3/A0-A2
            rts
            ds.b    6

            EVEN
