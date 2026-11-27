            include "Include/ROMHeader.s"

            EXPORT  GetVIAInputs,MEMORYCTRLINITPATCH,RELOADBERRVBR,TestForFPU,TESTFORIOP,TESTFORRPU
            EXPORT  TESTFORRVIER,TESTFORSCSI96,TestForSCSIDMA,TESTFORVIER,TESTVIERWRAP

            IMPORT  GetHardwareInfo,GotBusError,InitVIAs,ROMBERRANDVBRRTN

            SECTION "UniversalPatch",CODE

UNIVERSALPATCH:
TestForFPU:
            movec   CACR,D1
            bset    #$1F,D1
            movec   D1,CACR
            movec   CACR,D1
            bclr    #$1F,D1
            beq.b   .L1
            movec   D1,CACR
            bra.b   .L2
.L1:
            move.b  #7,D1
            movec   D1,SFC
            moves.w ($22000).l,D1
.L2:
            cmp.b   D1,D1
            RTS6
TESTFORRPU:
            tst.b   (A2)
            tst.b   (A2)
            tst.b   (A2)
            tst.b   (A2)
            st      ($10,A2)
            move.b  (A2),D2
            st      ($10,A2)
            st      (A2)
            clr.b   ($10,A2)
            moveq   #1,D1
            and.b   (A2),D1
            seq     D1
            beq.b   .L1
            st      ($10,A2)
            clr.b   (A2)
            st      ($10,A2)
            moveq   #1,D1
            and.b   (A2),D1
.L1:
            st      ($10,A2)
            move.b  D2,(A2)
            tst.b   D1
            RTS6
TESTFORVIER:
            moveq   #0,D2
TESTVIERWRAP:
            tst.b   (0,A2,D2.l)
            move.b  (A2),D1
            rol.w   #8,D1
            st      D1
            move.b  D1,(A2)
.L1:
            neg.b   D1
            move.b  D1,(A2)
            add.b   D1,D1
            beq.b   .L2
            neg.b   D1
            cmp.b   (0,A2,D2.l),D1
            bne.b   .L2
            cmp.b   (A2),D1
            beq.b   .L1
.L2:
            ror.w   #8,D1
            move.b  #$7F,(A2)
            move.b  D1,(A2)
            lsr.w   #8,D1
            RTS6
TESTFORRVIER:
            move.b  (A2),D1
            rol.w   #8,D1
            st      D1
            move.b  D1,(A2)
.L1:
            neg.b   D1
            move.b  D1,(A2)
            add.b   D1,D1
            beq.b   .L2
            neg.b   D1
            move.b  (A2),D2
            eor.b   D1,D2
            andi.b  #$9F,D2
            beq.b   .L1
.L2:
            ror.w   #8,D1
            move.b  #$7F,(A2)
            move.b  D1,(A2)
            lsr.w   #8,D1
            RTS6
TestForSCSIDMA:
            tst.l   ($80,A2)
            cmp.b   D1,D1
            RTS6
TESTFORSCSI96:
            tst.b   ($C0,A2)
            cmpi.b  #4,($C0,A2)
            RTS6
TestForSCC:
            tst.b   (0,A2,D2.l)
            ror.b   #8,D1
            move.b  #$D,(A2)
            ror.b   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$C,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$D,(A2)
            ror.b   #8,D1
            move.b  #$47,(A2)
            ror.b   #8,D1
            move.b  #$C,(A2)
            ror.b   #8,D1
            move.b  #$44,(A2)
            ror.b   #8,D1
            move.b  #$D,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            ror.b   #8,D1
            move.b  #$C,(A2)
            lsl.l   #8,D1
            move.b  (0,A2,D2.l),D1
            subi.w  #$4744,D1
            ror.l   #8,D1
            move.b  #$C,(A2)
            ror.l   #8,D1
            move.b  D1,(A2)
            ror.b   #8,D1
            move.b  #$D,(A2)
            lsr.l   #8,D1
            move.b  D1,(A2)
            lsr.l   #8,D1
            RTS6
TESTFORIOP:
            move.b  (-$1C,A2),D1
            moveq   #6,D2
            and.b   D1,D2
            swap    D1
            move.w  (-$1F,A2),D1
            ori.b   #2,D2
            move.b  D2,(-$1C,A2)
            tst.l   (-$18,A2)
            move.w  (-$1F,A2),D2
            move.w  D1,(-$1F,A2)
            subq.w  #4,D2
            sub.w   D1,D2
            swap    D1
            andi.b  #$CF,D1
            move.b  D1,(-$1C,A2)
            tst.w   D2
            RTS6
GetVIAInputs:
            moveq   #0,D1                           ; Initialize via info result
            btst    #2,D0                           ; See if VIA1 exists
            beq.b   .noVIA1                         ; If not, skip it
            movea.l (8,A0),A1
            move.b  (vBufA,A1),D2
            lsl.w   #8,D2                           ; Make room for direction bits
            move.b  (vDIRA,A1),D2
            move.b  D2,D1
            and.b   (-$C,A0),D1
            move.b  D1,(vDIRA,A1)
            move.b  (vBufA,A1),D1
            move.b  D2,(vDIRA,A1)
            lsr.w   #8,D2
            move.b  D2,(vBufA,A1)
            lsl.w   #8,D1
            move.b  (vBufB,A1),D2
            lsl.w   #8,D2
            move.b  (vDIRB,A1),D2
            move.b  D2,D1
            and.b   (-$B,A0),D1
            move.b  D1,(vDIRB,A1)
            move.b  (vBufB,A1),D1
            move.b  D2,(vDIRB,A1)
            lsr.w   #8,D2
            move.b  D2,(vBufB,A1)
.noVIA1:
            swap    D1
            btst    #$B,D0
            beq.b   .noVIA2
            movea.l ($2C,A0),A1
            move.b  (vBufA,A1),D2
            lsl.w   #8,D2
            move.b  (vDIRA,A1),D2
            move.b  D2,D1
            and.b   (-$A,A0),D1
            move.b  D1,(vDIRA,A1)
            move.b  (vBufA,A1),D1
            move.b  D2,(vDIRA,A1)
            lsr.w   #8,D2
            move.b  D2,(vBufA,A1)
            lsl.w   #8,D1
            move.b  (vBufB,A1),D2
            lsl.w   #8,D2
            move.b  (vDIRB,A1),D2
            move.b  D2,D1
            and.b   (-9,A0),D1
            move.b  D1,(vDIRB,A1)
            move.b  (vBufB,A1),D1
            move.b  D2,(vDIRB,A1)
            lsr.w   #8,D2
            move.b  D2,(vBufB,A1)
.noVIA2:
            RTS6
MEMORYCTRLINITPATCH:
            btst    #$15,D0
            beq.b   .L5
            movea.l ($54,A0),A3
            move.l  #$124F0810,D4
            moveq   #$1F,D3
            movea.l ($2C,A0),A2
            bclr    #5,($400,A2)
            btst    #5,(A2)
            beq.b   .L1
            move.l  #$138B0810,D4
.L1:
            lea     (A3),A2
.L2:
            move.l  D4,(A2)+
            lsr.l   #1,D4
            dbra    D3,.L2
            moveq   #0,D4
            move.l  D4,(A2)+
            move.l  D3,($A0,A3)
            move.l  D3,($A4,A3)
            move.l  D3,($A8,A3)
            move.l  D3,($AC,A3)
            move.l  D3,($B0,A3)
            move.l  D3,($B4,A3)
            move.l  ($48,A3),D4
            btst    #0,D4
            beq.b   .L3
            moveq   #0,D4
            bra.b   .L4
.L3:
            moveq   #1,D4
.L4:
            move.l  D4,(A2)
            move.l  D3,($B8,A3)
.L5:
            btst    #$16,D0
            beq.b   .L6
            movea.l ($58,A0),A2
            movea.l A2,A3
            adda.l  #$34000,A3
            move.b  (A3),D3
            andi.b  #1,D3
            move.b  D3,(A2)
.L6:
            jmp     (A4)
RELOADBERRVBR:
            adda.l  D3,SP
            lea     (GotBusError.w,PC),A0
            move.l  A0,D0
.L1:
            cmp.l   -(A0),D0
            beq.b   .L2
            tst.l   (A0)
            bne.b   .L1
            lea     BusErrVct,A0
            move.l  D0,(A0)
.L2:
            subq.w  #8,A0
            movec   A0,VBR
.L3:
            moveq   #0,D2
            BSR6    GetHardwareInfo
            btst    #0,D0
            beq.b   .L3
            BSR6    InitVIAs
            bra.w   ROMBERRANDVBRRTN
            ds.b    960

            EVEN
