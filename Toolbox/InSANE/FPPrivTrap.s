            include "Include/ROMHeader.s"

            EXPORT  INSTALLPRIVTRAP

            SECTION "FPPrivTrap",CODE

INSTALLPRIVTRAP:
            btst    #4,HWCfgFlags
            beq.b   .L2
            lea     PRIVTRAP881,A0
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            lea     PRIVTRAP040,A0
.L1:
            move.w  #$A097,D0
            _SetOSTrapAddress
.L2:
            rts
PRIVTRAP881:
            cmpi.w  #0,D0
            beq.b   .L1
            cmpi.w  #1,D0
            beq.b   .L3
            cmpi.w  #2,D0
            beq.b   .L4
            move.w  #$FE16,D0
            _SysError
            rts
.L1:
            fnop
            move.l  A0,D1
            fsave   -(SP)
            fmove.l FPSR,D0
            andi.w  #$FF,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            fmove.l FPCR,D0
            and.w   D1,D0
            andi.l  #$FF00,D0
            beq.b   .L2
            lea     .L2,A0
            fmove.l A0,FPIAR
            moveq   #0,D0
            move.b  (1,SP),D0
            bclr    #3,(0,SP,D0.w)
.L2:
            frestore (SP)+
            rts
.L3:
            movea.w #$C0,A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            rts
.L4:
            movea.w #$C0,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            rts
            dc.w    0
PRIVTRAP040:
            cmpi.w  #0,D0
            beq.b   SetExcept040
            cmpi.w  #1,D0
            beq.b   GetTrapVec040
            cmpi.w  #2,D0
            beq.b   SetTrapVec040
            move.w  #$FE16,D0
            _SysError
            rts
GetTrapVec040:
            movea.w #$C4,A1
            move.l  ($1FCC).w,(A0)+
            move.l  (A1)+,(A0)+
            move.l  (A1),(A0)+
            move.l  ($1FD0).w,(A0)+
            move.l  ($1FD4).w,(A0)+
            move.l  ($1FD8).w,(A0)+
            move.l  ($1FDC).w,(A0)+
            rts
SetTrapVec040:
            movea.w #$C4,A1
            move.l  (A0)+,($1FCC).w
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)
            move.l  (A0)+,($1FD0).w
            move.l  (A0)+,($1FD4).w
            move.l  (A0)+,($1FD8).w
            move.l  (A0)+,($1FDC).w
            rts
SetExcept040:
            fnop
            move.l  A0,D1
            fmove.l FPSR,D0
            andi.w  #$FF,D0
            or.w    D1,D0
            fmove.l D0,FPSR
            fmove.l FPCR,D0
            and.w   D0,D1
            andi.l  #$FF00,D1
            bne.b   .L1
            rts
.L1:
            btst    #$F,D1
            beq.b   .L2
            fmove.s #"$7FFFFFFF",FP1
            fbgt.w  .L5
            fnop
            rts
.L2:
            btst    #$E,D1
            beq.b   .L3
            fcmp.s  #"$7FBFFFFF",FP1
            bra.b   .L5
.L3:
            btst    #$D,D1
            beq.b   .L4
            fmove.s #"$7F800000",FP1
            fsub.x  FP1,FP1
            bra.b   .L5
.L4:
            btst    #$C,D1
            beq.b   .L6
            fmove.s #"$7F000000",FP1
            dc.w    $F200,$04E3
.L5:
            fnop
            rts
.L6:
            btst    #$B,D1
            beq.b   .L7
            fmove.s #"$1F000000",FP1
            dc.w    $F200,$04E3,$60E6
.L7:
            btst    #$A,D1
            beq.b   .L8
            fmove.b #1,FP1
            fdiv.b  #0,FP1
            bra.b   .L5
.L8:
            fmove.b #1,FP1
            fadd.s  #"$00800000",FP1
            bra.b   .L5
            ds.b    10

            EVEN
