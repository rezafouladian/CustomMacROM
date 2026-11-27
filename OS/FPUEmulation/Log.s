sub_4089313C:
            tst.l   (A0)
            bmi.w   sub_408909B6
            bsr.b   lognrm
            bra.b   sub_408931B0
lognrm:
            movem.l D3-D7,-(SP)
            move.l  (4,A0),D4
            move.l  (8,A0),D5
            moveq   #0,D3
            bfffo   D4{0:0},D6
            bne.b   .L1
            move.l  D5,D4
            moveq   #0,D5
            moveq   #$20,D3
            bfffo   D4{0:0},D6
.L1:
            lsl.l   D6,D4
            add.l   D6,D3
            move.l  D5,D7
            lsl.l   D6,D5
            neg.b   D6
            addi.b  #$20,D6
            lsr.l   D6,D7
            neg.l   D3
            or.l    D7,D4
            clr.l   (-$74,A6)
            move.l  D4,(-$70,A6)
            move.l  D5,(-$6C,A6)
            move.l  D3,(-$54,A6)
            movem.l (SP)+,D3-D7
            lea     (-$74,A6),A0
            rts
slogn:
            tst.l   (A0)
            bmi.w   sub_408909B6
            clr.l   (-$54,A6)
            move.l  (A0),(-$74,A6)
            move.l  (4,A0),(-$70,A6)
            move.l  (8,A0),(-$6C,A6)
            lea     (-$74,A6),A0
sub_408931B0:
            move.l  (A0),D0
            move.w  (4,A0),D0
            fmove.x (A0),FP0
            cmp2.l  (InstallFPSP+$7D10.w,PC),D0
            bcc.w   .a_60A0
.a_5FC4:
            asr.l   #$8,D0
            asr.l   #$8,D0
            subi.l  #$3FFF,D0
            add.l   (-$54,A6),D0
            lea     (InstallFPSP+$7DB0.w,PC),A0
            fmove.l  D0,FP1
            move.l  #$3FFF0000,(-$74,A6)
            move.l  (-$70,A6),(-$60,A6)
            andi.l  #$FE000000,(-$60,A6)
            ori.l   #$1000000,(-$60,A6)
            move.l  (-$60,A6),D0
            andi.l  #$7E000000,D0
            asr.l   #$8,D0
            asr.l   #$8,D0
            asr.l   #$4,D0
            adda.l  D0,A0
            fmove.x  (-$74,A6),FP0
            move.l  #$3FFF0000,(-$64,A6)
            clr.l   (-$5C,A6)
            fsub.x  (-$64,A6),FP0
            fmovem.x FP2-FP3,-(SP)
.a_6026:
            fmul.x  (A0),FP0
            fmul.x  (InstallFPSP+$7D20.w,PC),FP1
            fmove.x  FP0,FP2
            fmul.x  FP2,FP2
            fmove.x FP1,(-$40,A6)
            fmove.x  FP2,FP3
            fmove.x  FP2,FP1
            fmul.d  (InstallFPSP+$7D40.w,PC),FP1
            fmul.d  (InstallFPSP+$7D48.w,PC),FP2
            fadd.d  (InstallFPSP+$7D50.w,PC),FP1
            fadd.d  (InstallFPSP+$7D58.w,PC),FP2
            fmul.x  FP3,FP1
            fmul.x  FP3,FP2
            fadd.d  (InstallFPSP+$7D60.w,PC),FP1
            fadd.d  (InstallFPSP+$7D68.w,PC),FP2
            fmul.x  FP3,FP1
            adda.w  #$10,A0
            fmul.x  FP3,FP2
            fmul.x  FP0,FP1
            fadd.x  FP2,FP0
            fadd.x  (A0),FP1
            fmovem.x (SP)+,FP2-FP3
            fadd.x  FP1,FP0
            fmove.l D1,FPCR
            fadd.x  (-$40,A6),FP0
            bra.w   sub_40890B12
.a_60A0:
            fmove.x  FP0,FP1
            fsub.s  (sub_408934EA.L62.w,PC),FP1
            fadd.s  (sub_408934EA.L62.w,PC),FP0
            fadd.x  FP1,FP1
.a_60B4:
            fdiv.x  FP0,FP1
            fmovem.x FP2-FP3,-(SP)
            fmove.x  FP1,FP0
            fmul.x  FP0,FP0
            fmove.x FP1,(-$30,A6)
            fmove.x  FP0,FP1
            fmul.x  FP1,FP1
            fmove.d  (InstallFPSP+$7D70.w,PC),FP3
            fmove.d  (InstallFPSP+$7D78.w,PC),FP2
            fmul.x  FP1,FP3
            fmul.x  FP1,FP2
            fadd.d  (InstallFPSP+$7D80.w,PC),FP3
            fadd.d  (InstallFPSP+$7D88.w,PC),FP2
            fmul.x  FP3,FP1
            fmul.x  FP0,FP2
            fadd.d  (InstallFPSP+$7D90.w,PC),FP1
            fmul.x  (-$30,A6),FP0
            fadd.x  FP2,FP1
            fmovem.x (SP)+,FP2-FP3
            fmul.x  FP1,FP0
            fmove.l D1,FPCR
            fadd.x  (-$30,A6),FP0
            bra.w   sub_40890B12
            rts
            bra.w   sub_40890B12.L16
.L1:
            fmove.x (A0),FP0
            fabs.x  FP0,FP0
            fcmp.x  sub_408934EA.L65,FP0
            fbgt.w  .L2
            fmove.l #0,FPSR
            fmove.l D1,FPCR
            fmove.x (A0),FP0
            bra.w   sub_40890B12
.L2:
            fmove.x (A0),FP0
            clr.l   (-$54,A6)
            fmove.x FP0,FP1
            fadd.s  sub_408934EA.L62,FP0
            fmove.x FP0,(-$74,A6)
            move.w  (-$70,A6),(-$72,A6)
            move.l  (-$74,A6),D0
            tst.l   D0
            ble.w   .L3
            cmp2.l  (InstallFPSP+$7D18.w,PC),D0
            bcs.w   .a_5FC4
            cmp2.l  (InstallFPSP+$7D10.w,PC),D0
            bcs.b   .a_6194
            fadd.x  FP1,FP1
            fadd.s  (sub_408934EA.L62.w,PC),FP0
            bra.w   .a_60B4
.a_6194:
            move.l  (-$70,A6),(-$60,A6)
            andi.l  #$FE000000,(-$60,A6)
            ori.l   #$1000000,(-$60,A6)
            cmpi.l  #$3FFF8000,D0
            bge.b   .a_61F6
            fmove.s  (InstallFPSP+$7D98.w,PC),FP0
            move.l  #$3FFF0000,(-$64,A6)
            clr.l   (-$5C,A6)
            fsub.x  (-$64,A6),FP0
            move.l  (-$60,A6),D0
            andi.l  #$7E000000,D0
            asr.l   #$8,D0
            asr.l   #$8,D0
            asr.l   #$4,D0
            fadd.x  FP1,FP1
            fmovem.x FP2-FP3,-(SP)
            fadd.x  FP1,FP0
            lea     (InstallFPSP+$7DB0.w,PC),A0
            adda.l  D0,A0
            fmove.s  (sub_408934EA.L64.w,PC),FP1
            bra.w   .a_6026
.a_61F6:
            fmove.s  (sub_408934EA.L62.w,PC),FP0
            move.l  #$3FFF0000,(-$64,A6)
            clr.l   (-$5C,A6)
            fsub.x  (-$64,A6),FP0
            move.l  (-$60,A6),D0
            andi.l  #$7E000000,D0
            asr.l   #$8,D0
            asr.l   #$8,D0
            asr.l   #$4,D0
            fadd.x  FP1,FP0
            fmovem.x FP2-FP3,-(SP)
            lea     (InstallFPSP+$7DB0.w,PC),A0
            adda.l  D0,A0
            fmove.s  (sub_408934EA.L63.w,PC),FP1
            bra.w   .a_6026
.L3:
            tst.l   D0
            bmi.b   .L4
            fmove.s sub_408934EA.L64,FP0
            fmove.l D1,FPCR
            bra.w   sub_40890882.L5
.L4:
            fmove.s sub_408934EA.L63,FP0
            fmove.l D1,FPCR
            bra.w   sub_408909B6
.L5:
            tst.l   (A0)
            bmi.w   sub_408909B6
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   sub_4089313C
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L60,FP0
            bra.w   sub_40890B12
.L6:
            tst.l   (A0)
            bmi.w   sub_408909B6
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   slogn
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L60,FP0
            bra.w   sub_40890B12
.L7:
            tst.l   (A0)
            bmi.w   sub_408909B6
            bsr.w   lognrm
            tst.l   (8,A0)
            bne.b   .L8
            move.l  (4,A0),D0
            lsl.l   #1,D0
            bne.b   .L8
            move.l  (-$54,A6),D0
            bra.b   .L10
.L8:
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   sub_408931B0
            fmove.l (SP)+,FPCR
            fmul.x  sub_408934EA.L61,FP0
            bra.w   sub_40890B12
.L9:
            tst.l   (A0)
            bmi.w   sub_408909B6
            tst.l   (8,A0)
            bne.b   sub_408934EA
            move.l  (4,A0),D0
            andi.l  #$7FFFFFFF,D0
            bne.b   sub_408934EA
            move.w  (A0),D0
.L10:
            subi.w  #$3FFF,D0
            fmove.l D1,FPCR
            fmove.w D0,FP0
            rts
sub_408934EA:
            move.l  D1,-(SP)
            moveq   #0,D1
            bsr.w   slogn
            fmove.l (SP)+,FPCR
            fmul.x  .L61,FP0
            bra.w   sub_40890B12
