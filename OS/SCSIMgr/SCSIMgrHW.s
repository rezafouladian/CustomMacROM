            include "Include/ROMHeader.s"

            EXPORT  DMAPENDINGPATCH,FASTREADOSS,FASTWRITEOSS,PFastReadOSS,PFASTWRITEOSS,SCSIIntHnd
            EXPORT  VFASTREADOSS,VFASTWRITEOSS

            IMPORT  ClearSCSIInt,DisableSCSIInts,EnableSCSIInts

            SECTION "SCSIMgrHW",CODE

SCSIHW:
CLEARIRQ:
            move.b  ($70,A3),D1
            bra.w   ClearSCSIInt
DISENABLE:
            tst.l   D0
            beq.b   .L1
            bra.w   EnableSCSIInts
.L1:
            bra.w   DisableSCSIInts
BUSERRHANDLER:
            subq.w  #1,(-6,A6)
            beq.b   sub_40808A7A
            move.l  D0,-(SP)
            move.w  TimeDBRA,D0
            lsr.w   #4,D0
.L1:
            dbra    D0,.L1
            move.l  (SP)+,D0
            rte
sub_40808A7A:
            move.w  (SP),D0
            bfextu  (6,SP){0:4},D1
            bra.w   sub_40808E80.L1
.L1:
            bne.b   .L2
            lea     ($20,SP),SP
            bra.b   .L3
.L2:
            lea     ($5C,SP),SP
.L3:
            move.w  D7,-(SP)
            pea     .L4
            move.w  D0,-(SP)
            rte
.L4:
            dc.w    $60FF,$0008,$FC04
            ds.b    6
ARB:
            movem.l D1-D2/A0-A3,-(SP)
            move.w  #2,($E,A5)
            moveq   #0,D0
            btst    #1,($67,A4)
            beq.b   .notGDUOSS
            btst    #4,($67,A4)
            beq.b   .notGDUOSS
            move.l  #$FFFFFFFF,($140,A3)
            move.l  ($6C,A4),($80,A3)
            move.b  #1,($20,A3)
            move.w  TimeDBRA,D2
            lsr.w   #6,D2
.delay:
            dbra    D2,.delay
            move.l  ($80,A3),D1
            btst    #$D,D1
            beq.b   .busyGDU
            move.b  ($70,A3),D1
            move.l  #2,($80,A3)
            bra.b   .exit
.busyGDU:
            move.l  #2,($80,A3)
            bra.b   .L4
.notGDUOSS:
            move.b  ($60,A4),(A3)
            move.b  #1,($20,A3)
            btst    #6,($10,A3)
            beq.b   .L4
            movea.l ($194,A4),A0
            jsr     (A0)
            btst    #5,($10,A3)
            bne.b   .L4
            move.b  ($60,A4),D2
            move.b  (A3),D1
            eor.b   D2,D1
            cmp.b   D2,D1
            bhi.b   .L4
            btst    #5,($10,A3)
            beq.b   .exit
.L4:
            bsr.w   sub_40808E6C
            move.b  #4,($20,A3)
            moveq   #3,D0
.exit:
            movem.l (SP)+,D1-D2/A0-A3
            tst.l   D0
            rts
; Sel
Sel:
            movem.l D1-D7/A0-A5,-(SP)
            move.w  #3,($E,A5)
            move.b  #$C,($10,A3)
            move.b  D7,($20,A3)
            movea.l ($194,A4),A0
            jsr     (A0)                            ; Go to the routine
            move.b  D7,($30,A3)
            moveq   #1,D1
            move.b  ($C,A5),D2
            lsl.b   D2,D1
            or.b    ($60,A4),D1
            move.b  D1,(A3)
            move.b  #$F,($10,A3)
            move.b  D7,($40,A3)
            move.l  D7,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            move.b  #7,($10,A3)
            movea.l ($194,A4),A0
            jsr     (A0)
            move.w  ($1E,A5),D2
            mulu.w  TimeSCSIDB,D2
            move.l  D2,D0
            swap    D0
.L1:
            btst    #6,($40,A3)
            dbne    D2,.L1
            dbne    D0,.L1
            bne.b   .L3
            move.b  #4,($10,A3)
            move.w  TimeSCSIDB,D2
            lsr.w   #2,D2
.L2:
            dbra    D2,.L2
            btst    #6,($40,A3)
            bne.b   .L3
            move.w  #$FE26,D0
            move.b  D7,($10,A3)
            bra.b   .L4
.L3:
            movea.l ($194,A4),A0
            jsr     (A0)
            move.b  #2,($10,A3)
            moveq   #0,D0
.L4:
            movem.l (SP)+,D1-D7/A0-A5
            tst.l   D0
            rts
DELAY22:
            movea.l VIA,A0
            tst.b   (vIFR,A0)
            tst.b   (vIFR,A0)
            tst.b   (vIFR,A0)
            rts
; SCSIIntHnd
SCSIIntHnd:
            movem.l D0-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            movea.l ($58,A4),A5
            moveq   #0,D7
            move.l  D7,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            movea.l ($40,A4),A3
            move    SR,-(SP)
            ori     #$700,SR
            move.b  ($50,A3),D0
            btst    #4,D0
            beq.w   .L1
            lsl.w   #8,D0
            move.b  ($40,A3),D0
            move.w  D0,D1
            andi.w  #$F5E2,D1
            cmpi.w  #$1002,D1
            bne.b   .L2
            move.b  (A3),D1
            beq.w   .L1
            move.b  ($60,A4),D0
            eor.b   D0,D1
            beq.w   .L1
            move.b  D7,($40,A3)
            move.b  ($10,A3),D0
            ori.b   #8,D0
            move.b  D0,($10,A3)
            moveq   #7,D0
            bra.b   .L3
.L2:
            move.w  D0,D1
            andi.w  #$F6C2,D1
            cmpi.w  #$9040,D1
            bne.b   .L4
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            moveq   #6,D0
            bra.b   .L3
.L4:
            move.w  D0,D1
            andi.w  #$BDE2,D1
            cmpi.w  #$1060,D1
            bne.b   .L5
            moveq   #5,D0
            bra.b   .L3
.L5:
            move.w  D0,D1
            andi.w  #$F7FF,D1
            cmpi.w  #$1400,D1
            bne.b   .L6
            moveq   #4,D0
            bra.b   .L3
.L6:
            move.w  D0,D1
            andi.w  #$F77F,D1
            cmpi.w  #$1000,D1
            bne.b   .L7
            bra.b   .L1
.L7:
            move.w  D0,D1
            andi.w  #$BCC2,D1
            cmpi.w  #$3840,D1
            bne.b   .L1
            moveq   #2,D0
.L3:
            movea.l ($168,A4),A0
            jsr     (A0)
            movea.l ($16C,A4),A0
            jsr     (A0)
            move    (SP)+,SR
            bra.b   .L8
.L1:
            move    (SP)+,SR
            btst    #4,($67,A4)
            beq.b   .L9
            move.l  ($80,A3),D0
            btst    #7,D0
            beq.b   .L9
            move.w  #$FE27,D0
            movea.l ($174,A4),A0
            jsr     (A0)
            moveq   #-1,D0
            move.l  D0,($140,A3)
.L9:
            movea.l ($16C,A4),A0
            jsr     (A0)
            moveq   #1,D0
            movea.l ($170,A4),A0
            jsr     (A0)
.L8:
            movem.l (SP)+,D0-D7/A0-A5
            rts
; Transfer
Transfer:
            link.w  A6,#-6
            bsr.w   sub_40808F02
            nop
            moveq   #0,D0                           ; Assume no error
            move.l  D2,D1                           ; Make a copy of the count
            beq.b   .exit                           ; Exit if count is zero
            movem.l D2-D6/A1-A5,-(SP)
            lea     ($50,A3),A1
            moveq   #6,D3
            move.l  BusErrVct,(-4,A6)
            move.l  ($1AC,A4),BusErrVct
            lea     ($A4,A4),A0
            movea.l (0,A0,D4.l),A0
            jsr     (A0)
.done:
            move.l  (-4,A6),BusErrVct
            movem.l (SP)+,D2-D6/A1-A5
            tst.w   D0
.exit:
            unlk    A6
            rts
; SlowRead
SlowRead:
            movea.l ($44,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.wait:
            btst    D3,(A1)
            bne.b   .SnRd
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            beq.b   .RdPhaseErr
.SnRd:
            btst    D3,(A1)
            beq.b   .SnRdChk
            move.b  (A0),(A2)+
            dbra    D2,.SnRd
            dbra    D5,.SnRd
            bra.b   .RdDone
.SnRdChk:
            bsr.w   NewPhaseCheck
            bne.b   .SnRd
.RdPhaseErr:
            moveq   #5,D0
            bra.b   .exit
.RdDone:
            btst    #0,($50,A3)
            beq.b   .exit
            btst    #5,($40,A3)
            beq.b   .exit
            btst    #3,(A1)
            bne.b   .RdDone
.exit:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            rts
; SlowWrite
SlowWrite:
            movea.l ($44,A4),A0
            adda.w  ($4C,A4),A0
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L2
            move.l  #$A,($80,A3)
.L2:
            move.b  D7,($50,A3)
            btst    #3,(A1)
            bne.b   .L3
            moveq   #5,D0
            bra.b   .L6
.L3:
            move.l  D2,D1
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.L4:
            btst    D3,(A1)
            beq.b   .L5
            move.b  (A2)+,(A0)
            dbra    D2,.L4
            dbra    D5,.L4
            bra.b   .L6
.L5:
            btst    #3,(A1)
            bne.b   .L4
            moveq   #5,D0
            bra.b   .L9
.L6:
            btst    #4,($67,A4)
            beq.b   .L8
.L7:
            btst    D3,($50,A3)
            bne.b   .L9
            btst    #3,($50,A3)
            bne.b   .L7
.L8:
            btst    D3,($50,A3)
            bne.b   .L9
            btst    #3,($50,A3)
            bne.b   .L8
.L9:
            move.b  D7,($10,A3)
            move.b  D7,($20,A3)
            btst    #4,($67,A4)
            beq.b   .DMAdone2
            move.l  #2,($80,A3)
.DMAdone2:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            rts
VFASTWRITEOSS:
            movea.l (4,A5),A0
            lea     ($20,A0),A0
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,(A0)
            move.l  D2,(4,A0)
            moveq   #1,D0
            movea.l D0,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.b   .L1
            movea.l (8,A0),A2
            move.l  ($C,A0),D2
            move.l  D2,D1
            movea.l ($C0,A4),A0
            jmp     (A0)
.L1:
            rts
sub_40808E6C:
            bset    #0,($7D,A4)
            move.b  D7,($20,A3)
            rts
NewPhaseCheck:
            moveq   #$48,D6
            and.b   ($50,A3),D6
            rts
sub_40808E80:
            bset    #1,($7D,A4)
            move.l  ($68,A4),($140,A3)
            rts
.L1:
            cmpi.b  #7,D1
            beq.b   .L2
            cmpi.b  #$A,D1
            bra.w   sub_40808A7A.L1
.L2:
            lea     ($3C,SP),SP
            bra.w   sub_40808A7A.L3
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFASTWRITEOSS:
            moveq   #0,D0
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            move.l  #8,($80,A3)
            move.b  D7,($50,A3)
            move.l  #$FFFFFFFF,($140,A3)
            move.l  #7,($80,A3)
            move.l  A2,($100,A3)
            move.l  D2,($C0,A3)
            move.b  #$A,($20,A3)
            move.b  #1,($10,A3)
            move.b  D7,($50,A3)
            bset    #0,($7D,A4)
            rts
sub_40808F02:
            moveq   #5,D0
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #1,D0
.L1:
            move.w  D0,(-6,A6)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFASTWRITE:
            rts
vFastWrite:
FASTWRITE:
            movea.l ($48,A4),A0
            adda.w  ($4C,A4),A0
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L2
            move.l  #$A,($80,A3)
.L2:
            move.b  D7,($50,A3)
.L3:
            btst    D3,(A1)
            bne.b   .L4
            btst    #5,($40,A3)
            beq.b   .L3
            btst    #3,(A1)
            bne.b   .L3
            moveq   #5,D0
            bra.w   .L12
.L4:
            move.l  D2,D1
            moveq   #3,D4
            cmp.l   D4,D2
            bhi.b   .L5
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .L11
.L5:
            move.l  A2,D5
            neg.l   D5
            and.l   D4,D5
            sub.l   D5,D2
            bra.b   .L7
.L6:
            move.b  (A2)+,(A0)
.L7:
            dbra    D5,.L6
            move.l  D2,D5
            lsr.l   #5,D5
            bne.b   .L8
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .L11
.L8:
            subq.l  #1,D5
            move.l  D5,D6
            swap    D6
            moveq   #$1F,D4
            and.l   D4,D2
.L9:
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            move.l  (A2)+,(A0)
            dbra    D5,.L9
            dbra    D6,.L9
            bra.b   .L11
.L10:
            move.b  (A2)+,(A0)
.L11:
            dbra    D2,.L10
            swap    D6
            move.w  D5,D6
            addq.l  #1,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
.L12:
            btst    #4,($67,A4)
            beq.b   .L14
.L13:
            btst    D3,($50,A3)
            bne.b   .L15
            btst    #3,($50,A3)
            bne.b   .L13
.L14:
            btst    D3,($50,A3)
            bne.b   .L15
            btst    #3,($50,A3)
            bne.b   .L14
.L15:
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            btst    #4,($67,A4)
            beq.b   .L16
            move.l  #2,($80,A3)
.L16:
            rts
FASTWRITEOSS:
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,-(SP)
            lea     (-$14,SP),SP
            move.l  D0,(SP)
            move.l  D2,(4,SP)
            bsr.w   sub_40809148
            bne.w   .L8
            movea.l SP,A0
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .L8
.L1:
            btst    #5,($40,A3)
            beq.b   .L1
            move.b  D7,($30,A3)
            move.b  #2,($20,A3)
            move.b  #1,($10,A3)
            moveq   #8,D5
            move.l  D5,($80,A3)
            move.b  D7,($50,A3)
.L2:
            btst    D3,($50,A3)
            bne.b   .L3
            btst    #5,($40,A3)
            beq.b   .L2
            btst    #3,($50,A3)
            bne.b   .L2
            moveq   #5,D0
            bra.w   .L6
.L3:
            nop
            bsr.w   sub_40808E80
            moveq   #7,D5
            move.l  D5,($80,A3)
            move.l  (8,A0),($100,A3)
            move.l  ($C,A0),($C0,A3)
            move.b  #$A,($20,A3)
            move.b  #1,($10,A3)
            move.b  D7,($50,A3)
            move.l  (4,A0),($C,A0)
            beq.b   .L4
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .L8
.L4:
            movea.l VIA2,A1
.L5:
            btst    #1,($202,A1)
            beq.b   .L5
            move.l  ($80,A3),D5
            andi.w  #$180,D5
            bne.b   .L8
            tst.l   ($C0,A3)
            bne.b   .L8
            move.b  D7,($20,A3)
            tst.b   ($70,A3)
            tst.l   ($C,A0)
            bne.b   .L3
            move.l  D2,D1
.L6:
            btst    #0,($50,A3)
            beq.b   .L7
            btst    #5,($40,A3)
            beq.b   .L7
            btst    #3,($50,A3)
            bne.b   .L6
.L7:
            move.b  D7,($20,A3)
            move.b  D7,($10,A3)
            moveq   #2,D5
            move.l  D5,($80,A3)
            lea     ($14,SP),SP
            bra.b   .L9
.L8:
            moveq   #9,D0
            bra.b   .L7
            rts
.L9:
            bra.w   VFASTREADOSS.L2
sub_40809148:
            movea.l D0,A0
            movea.l D2,A1
            moveq   #2,D0
            _MemoryDispatch
            rts
            nop
            nop
VFASTREADOSS:
            movea.l (4,A5),A0
            lea     ($20,A0),A0
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,(A0)
            move.l  D2,(4,A0)
            moveq   #1,D0
            movea.l D0,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.b   .L1
            movea.l (8,A0),A2
            move.l  ($C,A0),D2
            move.l  D2,D1
            movea.l ($BC,A4),A0
            jmp     (A0)
.L1:
            rts
.L2:
            bclr    #1,($7D,A4)
            movea.l (SP)+,A0
            movea.l D2,A1
            move.w  D0,-(SP)
            moveq   #3,D0
            _MemoryDispatch
            move.w  (SP)+,D0
            rts
DMAPENDINGPATCH:
            btst    #7,($61,A4)
            bne.b   .L1
            btst    #1,($7D,A4)
.L1:
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
PFastReadOSS:
            moveq   #0,D0
            move.l  #$FFFFFFFF,($140,A3)
            move.l  #7,($80,A3)
            move.l  A2,($100,A3)
            move.l  D2,($C0,A3)
            move.b  #$A,($20,A3)
            move.b  D7,($70,A3)
            bset    #0,($7D,A4)
            rts
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
; PFastRead
PFastRead:
            rts                                     ; Unimplemented
vFastRead:
FastRead:
            movea.l ($48,A4),A0
            adda.w  #$60,A0
.wait:
            btst    D3,(A1)
            bne.b   .start
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            bne.b   .start
            moveq   #5,D0
            bra.w   .exit
.start:
            move.l  D2,D1
            moveq   #3,D4
            cmp.l   D4,D2
            bhi.b   .over3
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .BlRdRmdr
.over3:
            move.l  A2,D5
            neg.l   D5
            and.l   D4,D5
            sub.l   D5,D2
            bra.b   .L5
.L4:
            move.b  (A0),(A2)+
.L5:
            dbra    D5,.L4
            move.l  D2,D5
            lsr.l   #5,D5
            bne.b   .over32
            moveq   #-1,D5
            moveq   #-1,D6
            bra.b   .BlRdRmdr
.over32:
            subq.l  #1,D5
            move.l  D5,D6
            swap    D6
            moveq   #$1F,D4
            and.l   D4,D2
.BlRd32:
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            move.l  (A0),(A2)+
            dbra    D5,.BlRd32
            dbra    D6,.BlRd32
            bra.b   .BlRdRmdr
.BlRdSingle:
            move.b  (A0),(A2)+
.BlRdRmdr:
            dbra    D2,.BlRdSingle
            swap    D6
            move.w  D5,D6
            addq.l  #1,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
.RdDone:
            btst    #0,($50,A3)
            beq.b   .exit
            btst    #5,($40,A3)
            beq.b   .exit
            btst    #3,(A1)
            bne.b   .RdDone
.exit:
            rts
FASTREADOSS:
            move.l  A2,D0
            jsr     ([$554.w])
            move.l  D0,-(SP)
            lea     (-$14,SP),SP
            move.l  D0,(SP)
            move.l  D2,(4,SP)
            bsr.w   sub_40809148
            bne.w   .badAddrError
            movea.l SP,A0
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .badAddrError
.wait:
            btst    D3,($50,A3)
            bne.b   .start
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,($50,A3)
            bne.b   .start
            moveq   #5,D0
            bra.w   .L6
.start:
            nop
            bsr.w   sub_40808E80
            moveq   #7,D5
            move.l  D5,($80,A3)
            move.l  (8,A0),($100,A3)
            move.l  ($C,A0),($C0,A3)
            move.b  #$A,($20,A3)
            move.b  D7,($70,A3)
            move.l  (4,A0),($C,A0)
            beq.b   .L3
            movea.w #1,A1
            moveq   #5,D0
            _MemoryDispatch
            bne.w   .badAddrError
.L3:
            movea.l VIA2,A1
.L4:
            btst    #1,($202,A1)
            beq.b   .L4
            move.l  ($80,A3),D5
            andi.w  #$180,D5
            bne.b   .badAddrError
            tst.l   ($C0,A3)
            bne.b   .badAddrError
            move.b  D7,($20,A3)
            tst.b   ($70,A3)
            move.b  #2,($20,A3)
            move.b  D7,($70,A3)
            tst.l   ($C,A0)
            bne.b   .start
            move.l  D2,D1
.L5:
            btst    #0,($50,A3)
            beq.b   .L6
            btst    #5,($40,A3)
            beq.b   .L6
            btst    #3,($50,A3)
            bne.b   .L5
.L6:
            lea     ($14,SP),SP
            bra.w   VFASTREADOSS.L2
.badAddrError:
            moveq   #9,D0
            bra.b   .L6
            rts
            nop
            nop
            nop
            nop
            nop
            nop
SlowComp:
            movea.l ($44,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.L1:
            btst    #6,(A1)
            bne.b   .L2
            btst    #5,($40,A3)
            beq.b   .L1
            btst    #3,(A1)
            beq.b   .L5
.L2:
            btst    #6,(A1)
            beq.b   .L4
            move.b  (A0),D3
            cmp.b   (A2)+,D3
            beq.b   .L3
            moveq   #6,D0
.L3:
            dbra    D2,.L2
            dbra    D5,.L2
            bra.b   .L6
.L4:
            bsr.w   NewPhaseCheck
            bne.b   .L2
.L5:
            moveq   #5,D0
            bra.b   .L7
.L6:
            btst    #0,($50,A3)
            beq.b   .L7
            btst    #5,($40,A3)
            beq.b   .L7
            btst    #3,(A1)
            bne.b   .L6
.L7:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            moveq   #6,D3
            rts
FastComp:
            movea.l ($48,A4),A0
            adda.w  #$60,A0
            subq.l  #1,D2
            move.l  D2,D5
            swap    D5
.wait:
            btst    #6,(A1)
            bne.b   .BlCmp
            btst    #5,($40,A3)
            beq.b   .wait
            btst    #3,(A1)
            bne.b   .BlCmp
            moveq   #5,D0
            bra.b   .L5
.BlCmp:
            move.b  (A0),D3
            cmp.b   (A2)+,D3
            beq.b   .BlCmp1
            moveq   #6,D0
.BlCmp1:
            dbra    D2,.BlCmp
            dbra    D5,.BlCmp
.RdDone:
            btst    #0,($50,A3)
            beq.b   .L5
            btst    #5,($40,A3)
            beq.b   .L5
            btst    #3,(A1)
            bne.b   .RdDone
.L5:
            swap    D5
            move.w  D2,D5
            addq.l  #1,D5
            sub.l   D5,D1
            moveq   #6,D3
            rts
            ds.b    4

            EVEN
