.L6:
            dc.l    $3FFF0000,$80000000,$00000000  ; 10 ^ 0
.L7:
            dc.w    $8000,0
.L8:
            dc.l    $BFFF0000,$C90FDAA2,$2168C235  ; -PI/2
            dc.l    $00000000                      ; added <4/9/91, JPO>				<T3>
            dc.l    $7FFF0000,$FFFFFFFF,$FFFFFFFF,$00000000 ; added <4/9/91, JPO>			<T3>
.L9:
            dc.l    $092E092E,$092E092E,$092E092E,$092E092E
            dc.l    $080C03EE,$03FAFE40,$081803D2,$03D203D2
            dc.l    $102003EE,$03FAFE40,$101C03D2,$03D203D2
            dc.l    $085603EE,$03FAFE40,$03D803D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $043603EE,$042AFE40,$25C203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $1B5403EE,$0454FE40,$1B5003D2,$03D203D2
            dc.l    $10E203EE,$0406FE40,$10DE03D2,$03D203D2
            dc.l    $21BE03EE,$0412FE40,$21BA03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $213A03EE,$FC56FE40,$213603D2,$03D203D2
            dc.l    $0F0803EE,$FC56FE40,$0F0403D2,$03D203D2
            dc.l    $123403EE,$FC56FE40,$121C03D2,$03D203D2
            dc.l    $16C803EE,$FC56FE40,$16C403D2,$03D203D2
            dc.l    $19A60748,$041EFE40,$198203D2,$03D203D2
            dc.l    $1E0C0748,$041EFE40,$1DF003D2,$03D203D2
            dc.l    $1F700748,$041EFE40,$1F5403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $0460FBEC,$042AFE40,$048C03D2,$03D203D2
            dc.l    $0498FBEC,$042AFE40,$04C403D2,$03D203D2
            dc.l    $04D0FBEC,$042AFE40,$04FC03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $0F8C0748,$0724FE40,$0F7403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $20A40708,$FC56FE40,$209603D2,$03D203D2
            dc.l    $123A0748,$FC56FE40,$122003D2,$03D203D2
            dc.l    $078003EE,$FC56FE40,$079003D2,$03D203D2
            dc.l    $07A403EE,$FC56FE40,$07C403D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $05280528,$05280528,$052803D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $05CA05CA,$05CA05CA,$05CA03D2,$03D203D2
            dc.l    $066C066C,$066C066C,$066C03D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $03D203D2,$03D203D2,$03D203D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
            dc.l    $13F006B4,$06D406E2,$13E003D2,$03D203D2
do_func:
            clr.b   (-$46,A6)
            bfextu  (-$E4,A6){0:6},D0
            cmpi.l  #$17,D0
            bne.b   .L1
            bra.w   sub_408915C0.L11
.L1:
            move.w  (-$E4,A6),D0
            andi.l  #$7F,D0
            cmpi.l  #$38,D0
            bge.b   .L2
            bfextu  (-$E8,A6){0:3},D1
            lsl.l   #3,D0
            add.l   D1,D0
            lea     sub_40890C9C.L9,A1
            adda.w  (0,A1,D0.w*2),A1
            lea     (-$CC,A6),A0
            move.l  (-$80,A6),D1
            andi.l  #$FF,D1
            fmove.l #0,FPCR
            jmp     (A1)
.L2:
            st      (-$4C,A6)
            rts
sub_40891138:
            btst    #7,(A0)
            bne.b   .L1
            bsr.w   sub_408914C0
            bra.w   sub_40890AB4.L4
.L1:
            bsr.w   sub_408914D0
            bra.w   sub_40890AB4.L4
            btst    #7,(A0)
            bne.w   sub_408914D0
            bra.w   sub_408914C0
            btst    #7,(A0)
            bne.w   sub_40891496
            bra.w   .L4
            btst    #7,(A0)
            bne.w   sub_408914B0
            bra.w   sub_408914A8
            btst    #7,(A0)
            bne.w   .L3
            bra.w   .L2
            btst    #7,(A0)
            bne.w   sub_408914C0
            bra.w   .L4
            btst    #7,(A0)
            bne.w   sub_408909B6
            bra.w   .L4
            fmovem.x (A0),FP0
            fcmp.b  #$FF,FP0
            fbgt.w  sub_408931B0.L1
            fbeq.w  sub_40890882.L4
            fmove.l #0,FPSR
            bra.w   sub_408909B6
            btst    #$7,(A0)
            bne.w   sub_408914B0
            bra.w   sub_40891138.L4
            btst    #$7,(A0)
            bne.w   sub_408909B6
            cmpi.w  #$3FFF,(A0)
            bne.w   slogn
            cmpi.l  #$80000000,($4,A0)
            bne.w   slogn
            tst.l   ($8,A0)
            bne.w   slogn
            fmove.b  #$0,FP0
            rts
            btst    #7,(A0)
            beq.w   sub_4089313C
            bra.w   sub_408909B6
            btst    #7,(A0)
            bne.w   sub_408909B6
            cmpi.w  #$3FFF,(A0)
            bne.w   sub_408931B0.L6
            cmpi.l  #$80000000,(4,A0)
            bne.w   sub_408931B0.L6
            tst.l   (8,A0)
            bne.w   sub_408931B0.L6
            fmove.b #0,FP0
            rts
            btst    #7,(A0)
            beq.w   sub_408931B0.L5
            bra.w   sub_408909B6
            btst    #7,(A0)
            bne.w   sub_408909B6
            cmpi.w  #$3FFF,(A0)
            bne.w   sub_408931B0.L9
            cmpi.l  #$80000000,(4,A0)
            bne.w   sub_408931B0.L9
            tst.l   (8,A0)
            bne.w   sub_408931B0.L9
            fmove.b #0,FP0
            rts
            btst    #7,(A0)
            beq.w   sub_408931B0.L7
            bra.w   sub_408909B6
.a_4068:
            dc.w    InstallFPSP+$45C0-.a_4068
            dc.w    .a_40B2-.a_4068
            dc.w    .a_40D8-.a_4068
            dc.w    .a_40AA-.a_4068
            dc.w    .a_40B6-.a_4068
            dc.w    .a_40B2-.a_4068
            dc.w    .a_40B6-.a_4068
            dc.w    .a_40AA-.a_4068
            dc.w    .a_40B2-.a_4068
            dc.w    .a_40B2-.a_4068
            dc.w    .a_40B2-.a_4068
            dc.w    .a_40AA-.a_4068
            dc.w    .a_40AE-.a_4068
            dc.w    .a_40AE-.a_4068
            dc.w    .a_40AE-.a_4068
            dc.w    .a_40AE-.a_4068
            bfextu  (-$E8,A6){0:3},D0
            bfextu  (-$E0,A6){0:3},D1
            bclr    #$2,D0
            bclr    #$2,D1
            lsl.b   #$2,D1
            or.b    D0,D1
            lea     (.a_4068.w,PC),A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
.a_40AA:
            bra.w   InstallFPSP+$39A0
.a_40AE:
            bra.w   InstallFPSP+$392A
.a_40B2:
            bra.w   sub_408909B6
.a_40B6:
            move.b  (-$CC,A6),D1
            move.b  (-$D8,A6),D0
            eor.b   D0,D1
            btst    #$7,D1
            beq.b   .a_40CC
            bset    #$7,(-$7B,A6)
.a_40CC:
            btst    #$7,D0
            beq.w   sub_408914C0
            bra.w   sub_408914D0
.a_40D8:
            move.b  (-$CC,A6),D1
            move.b  (-$D8,A6),D0
            eor.b   D0,D1
            btst    #$7,D1
            beq.b   .a_40EE
            bset    #$7,(-$7B,A6)
.a_40EE:
            tst.b   (-$E0,A6)
            bpl.b   .a_40FC
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.a_40FC:
            fmove.l (-$80,A6),FPCR
            fmove.x  (-$D8,A6),FP0
            rts
.a_410A:
            dc.w    InstallFPSP+$45C6-.a_410A
            dc.w    .a_4154-.a_410A
            dc.w    .a_417A-.a_410A
            dc.w    .a_414C-.a_410A
            dc.w    .a_4158-.a_410A
            dc.w    .a_4154-.a_410A
            dc.w    .a_4158-.a_410A
            dc.w    .a_414C-.a_410A
            dc.w    .a_4154-.a_410A
            dc.w    .a_4154-.a_410A
            dc.w    .a_4154-.a_410A
            dc.w    .a_414C-.a_410A
            dc.w    .a_4150-.a_410A
            dc.w    .a_4150-.a_410A
            dc.w    .a_4150-.a_410A
            dc.w    .a_4150-.a_410A
            bfextu  (-$E8,A6){0:3},D0
            bfextu  (-$E0,A6){0:3},D1
            bclr    #$2,D0
            bclr    #$2,D1
            lsl.b   #$2,D1
            or.b    D0,D1
            lea     (.a_410A.w,PC),A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
.a_414C:
            bra.w   InstallFPSP+$39A0
.a_4150:
            bra.w   InstallFPSP+$392A
.a_4154:
            bra.w   sub_408909B6
.a_4158:
            move.b  (-$CC,A6),D1
            move.b  (-$D8,A6),D0
            eor.b   D0,D1
            btst    #$7,D1
            beq.b   .a_416E
            bset    #$7,(-$7B,A6)
.a_416E:
            btst    #$7,D0
            beq.w   sub_408914C0
            bra.w   sub_408914D0
.a_417A:
            move.b  (-$CC,A6),D1
            move.b  (-$D8,A6),D0
            eor.b   D0,D1
            btst    #$7,D1
            beq.b   .a_4190
            bset    #$7,(-$7B,A6)
.a_4190:
            tst.b   (-$E0,A6)
            bpl.b   .a_419E
            lea     (-$D8,A6),A0
            bra.w   sub_40890B12.L9
.a_419E:
            fmove.l (-$80,A6),FPCR
            fmove.x  (-$D8,A6),FP0
            rts
.a_41AC:
            dc.w    sub_40891984.a_47B2-.a_41AC
            dc.w    sub_40891984.a_47B2-.a_41AC
            dc.w    .a_41EE-.a_41AC
            dc.w    .a_4210-.a_41AC
            dc.w    .a_41F6-.a_41AC
            dc.w    .a_41F6-.a_41AC
            dc.w    .a_41EE-.a_41AC
            dc.w    .a_4210-.a_41AC
            dc.w    .a_4204-.a_41AC
            dc.w    .a_4204-.a_41AC
            dc.w    .a_41EE-.a_41AC
            dc.w    .a_4210-.a_41AC
            dc.w    .a_41F2-.a_41AC
            dc.w    .a_41F2-.a_41AC
            dc.w    .a_41F2-.a_41AC
            dc.w    .a_41F2-.a_41AC
            bfextu  (-$E8,A6){0:3},D0
            bfextu  (-$E0,A6){0:3},D1
            bclr    #$2,D0
            bclr    #$2,D1
            lsl.b   #$2,D1
            or.b    D0,D1
            lea     (.a_41AC.w,PC),A1
            adda.w  (0,A1,D1.w*2),A1
            jmp     (A1)
.a_41EE:
            bra.w   sub_408909B6
.a_41F2:
            bra.w   InstallFPSP+$392A
.a_41F6:
            btst    #$7,(-$D8,A6)
            beq.w   sub_408914C0
            bra.w   sub_408914D0
.a_4204:
            btst    #$7,(-$D8,A6)
            beq.b   sub_40891138.L4
            bra.w   sub_40891496
.a_4210:
            bra.w   InstallFPSP+$39A0
            btst    #$7,(-$CC,A6)
            beq.b   .a_4224
            fmove.s  (sub_40890C9C.L7.w,PC),FP0
            bra.b   .a_422A
.a_4224:
            fmove.b  #$0,FP0
.a_422A:
            fmovem.x (sub_40890C9C.L6.w,PC),FP1
            bra.w   sub_40891984.a_51D4
            fmove.x  (InstallFPSP+$3B50.w,PC),FP1
            bsr.w   sub_40891984.a_51D4
            bra.w   sub_408909B6
            move.l  (-$CC,A6),(-$74,A6)
            move.l  (-$C8,A6),(-$70,A6)
            move.l  (-$C4,A6),(-$6C,A6)
            bset    #$6,(-$70,A6)
            fmovem.x (-$74,A6),FP1
            bsr.w   sub_40891984.a_51D4
            bra.w   InstallFPSP+$39A0
.L2:
            fmove.x sub_408934EA.L43,FP0
            bra.w   sub_40890AB4.L4
.L3:
            fmove.x sub_40890C9C.L8,FP0
            ori.l   #$8000000,(-$7C,A6)
            bra.w   sub_40890AB4.L4
.L4:
            fmove.s #"$7F800000",FP0
            ori.l   #$2000000,(-$7C,A6)
            rts
sub_40891496:
            fmove.s #"$FF800000",FP0
            ori.l   #$A000000,(-$7C,A6)
            rts
sub_408914A8:
            fmove.x sub_40890C9C.L6,FP0
            rts
sub_408914B0:
            fmove.b #$FF,FP0
            ori.l   #$8000000,(-$7C,A6)
            rts
sub_408914C0:
            fmove.b #0,FP0
            ori.l   #$4000000,(-$7C,A6)
            rts
sub_408914D0:
            fmove.s sub_40890C9C.L7,FP0
            ori.l   #$C000000,(-$7C,A6)
            rts
