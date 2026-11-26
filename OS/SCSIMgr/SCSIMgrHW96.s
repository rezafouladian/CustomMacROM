            include "Include/ROMHeader.s"

            EXPORT  BUSERRHANDLER_96,CLEARIRQ_96,FASTCOMP_96,FASTREAD_96,FASTWRITE_96,INTHND_SCSI96
            EXPORT  RESETBUS_96,SCSIHW96,SLOWCOMP_96,SLOWREAD_96,SLOWWRITE_96,TRANSFER_96
            EXPORT  WaitForIntNoTime,WaitForSCSIIntrp,XFER1BYTE

            IMPORT  ClearSCSIInt,ERROR,SCSIPCTO32BIT

            SECTION "SCSIMgrHW96",CODE

SCSIHW96:
INITHW_SCSI96:
            move.b  #2,($30,A3)
            clr.b   ($30,A3)
            move.b  #1,($30,A3)
            move.b  #$47,($80,A3)
            clr.b   ($B0,A3)
            move.b  #4,($C0,A3)
            btst    #3,($DD2).w                     ; TestFor VIA2Exists
            beq.b   .L3
            btst    #2,AddrMapFlags                 ; TestFor DAFBExists
            beq.b   .L3
            move.l  A0,-(SP)
            movea.l VIA2,A0
            move.b  (A0),D0
            movea.l (SP)+,A0
            btst    #5,D0
            beq.b   .L1
            move.l  #$41,(A4)
            bra.b   .L2
.L1:
            move.l  #$1EC,(A4)
.L2:
            movea.l UnivInfoPtr,A0
            cmpi.b  #$10,($12,A0)
            beq.b   .L3
            btst    #5,D0
            bne.b   .L3
            move.b  #4,($90,A3)
            move.b  #$7E,($50,A3)
            bra.b   .L4
.L3:
            move.b  #5,($90,A3)
            move.b  #$A7,($50,A3)
.L4:
            clr.b   ($70,A3)
            move.b  ($50,A3),D0
            rts
INTHND_SCSI96:
            movem.l D0-D7/A0-A5,-(SP)
            movea.l SCSIGlobals,A4
            moveq   #0,D5
            addq.l  #1,($150,A4)
            movea.l ($1C4,A4),A3
            btst    #7,($40,A3)
            bne.b   .L1
            movea.l ($1C8,A4),A3
            btst    #7,($40,A3)
            beq.b   .L2
.L1:
            move.b  ($40,A3),D5
            swap    D5
            move.b  ($70,A3),D5
            lsl.w   #8,D5
            move.b  ($50,A3),D5
            swap    D5
            move.l  D5,($154,A4)
.L2:
            movem.l (SP)+,D0-D7/A0-A5
            rts
CLEARIRQ_96:
            move.b  ($50,A3),D1
            bra.l   ClearSCSIInt
            rts
TRANSFER_96:
            link.w  A6,#-6
            moveq   #5,D0
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            moveq   #1,D0
.L1:
            move.w  D0,(-6,A6)
            moveq   #0,D0
            move.l  D2,D1
            beq.b   .L2
            movem.l D2-D6/A1-A5,-(SP)
            movea.l A3,A1
            adda.l  #$40000,A1
            move.l  BusErrVct,($1C0,A4)
            move.l  ($1AC,A4),BusErrVct
            lea     ($A4,A4),A0
            movea.l (0,A0,D4.l),A0
            jsr     (A0)
            move.l  ($1C0,A4),BusErrVct
            movem.l (SP)+,D2-D6/A1-A5
            tst.w   D0
.L2:
            unlk    A6
            rts
sub_4089921E:
            move.b  #$10,($30,A3)
            jsr     WaitForIntNoTime
            bne.b   sub_4089923C.L1
            move.b  ($20,A3),(A2)+
            move.b  ($50,A3),D3
            btst    #5,D3
            bne.b   sub_4089923C.L1
            moveq   #0,D0
            rts
sub_4089923C:
            move.b  (A2)+,($20,A3)
            move.b  #$10,($30,A3)
            jsr     WaitForIntNoTime
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            move.l  #$F0,D6
            moveq   #2,D0
            bra.b   .L3
.L2:
            move.l  #$F0,D6
            moveq   #5,D0
.L3:
            bsr.w   ERROR
            moveq   #0,D1
            move.b  #1,($30,A3)
            rts
XFER1BYTE:
            move.b  #$10,($30,A3)
            jsr     WaitForIntNoTime
            rts
SLOWREAD_96:
            btst    #4,($158,A4)
            bne.w   .L15
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.w  #1,D0
            bne.b   sub_4089923C.L2
            moveq   #0,D6
            move.l  D2,D4
            lsr.l   #4,D4
            beq.w   .L8
            subq.l  #1,D4
            move.l  D4,D6
            swap    D6
            jsr     (SCSIPCTO32BIT.w,PC)
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            _SwapMMUMode
            move.l  A2,D0
            _StripAddress
            movea.l D0,A2
            movea.l ($13C,A4),A0
            move.b  #1,($30,A3)
            clr.b   ($10,A3)
            move.b  #$10,(A3)
            andi.l  #$F,D2
.L2:
            move.b  #$90,($30,A3)
.L3:
            btst    #4,($40,A3)
            bne.b   .L4
            btst    #7,($40,A3)
            bne.w   .L9
            moveq   #7,D5
            and.b   ($40,A3),D5
            cmpi.b  #1,D5
            beq.b   .L3
            tst.b   (A3)
            beq.b   .L3
            bra.b   .L9
.L4:
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L3
            nop
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            nop
.L5:
            btst    #7,($40,A3)
            beq.b   .L5
            move.b  ($50,A3),D5
            btst    #5,D5
            bne.b   .L13
            dbra    D4,.L2
            dbra    D6,.L2
            move.b  (SP)+,D0
            _SwapMMUMode
            bra.b   .L8
.L6:
            moveq   #7,D5
            and.b   ($40,A3),D5
            cmpi.b  #1,D5
            bne.b   .L14
            move.b  #$10,($30,A3)
.L7:
            btst    #7,($40,A3)
            beq.b   .L7
            move.b  ($20,A3),(A2)+
            move.b  ($50,A3),D5
            btst    #5,D5
            bne.b   .L16
.L8:
            dbra    D2,.L6
            moveq   #0,D0
            rts
.L9:
            moveq   #$1F,D0
            and.b   ($70,A3),D0
            bra.b   .L11
.L10:
            move.b  ($20,A3),(A2)+
.L11:
            dbra    D0,.L10
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L12
            move.w  ($100,A3),D5
.L12:
            bsr.w   WaitForIntNoTime
.L13:
            move.b  (SP)+,D0
            _SwapMMUMode
            addq.w  #1,D4
            swap    D6
            move.w  D4,D6
            lsl.l   #4,D6
            andi.b  #7,D5
            cmpi.b  #1,D5
            beq.b   .L16
.L14:
            moveq   #5,D0
            bra.b   .L17
.L15:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L16:
            moveq   #2,D0
.L17:
            add.l   D2,D6
            sub.l   D6,D1
            moveq   #5,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
SLOWWRITE_96:
            btst    #4,($158,A4)
            bne.w   .L9
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            bne.w   sub_4089923C.L2
            cmpi.l  #1,D2
            beq.w   sub_4089923C
            move.l  D2,D6
            swap    D6
            andi.l  #$FFFF,D2
            beq.b   .L7
.L2:
            move.l  D2,D4
            move.b  D4,(A3)
            lsr.l   #8,D4
            move.b  D4,($10,A3)
            move.b  #$90,($30,A3)
            nop
            move.l  D2,D4
            lsr.l   #4,D4
            ror.l   #1,D2
            andi.w  #7,D2
            neg.w   D2
            jmp     .L4(PC,D2.w*4)
.L3:
            nop
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
.L4:
            nop
            moveq   #$1F,D0
            and.b   ($70,A3),D0
            beq.b   .L5
            btst    #7,($40,A3)
            bne.b   .L8
            bra.b   .L4
.L5:
            dbra    D4,.L3
            btst    #$1F,D2
            beq.b   .L6
            move.b  (A2)+,($100,A3)
.L6:
            bsr.w   WaitForIntNoTime
            bne.b   .L10
.L7:
            move.l  #$10000,D2
            dbra    D6,.L2
            moveq   #0,D0
            rts
.L8:
            bsr.w   WaitForIntNoTime
            btst    #4,D5
            bne.b   .L7
            moveq   #7,D3
            and.b   D5,D3
            cmpi.b  #0,D3
            beq.b   .L10
            moveq   #5,D0
            moveq   #0,D1
            clr.l   ($144,A4)
            bra.b   .L11
.L9:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L10:
            moveq   #2,D0
.L11:
            lsl.l   #4,D4
            swap    D6
            move.w  D4,D6
            moveq   #$1F,D2
            and.b   ($70,A3),D2
            add.l   D2,D6
            sub.l   D6,D1
            clr.l   ($144,A4)
            moveq   #6,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
FASTWRITE_96:
            btst    #4,($158,A4)
            bne.w   .L8
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            bne.w   sub_4089923C.L2
            cmpi.l  #1,D2
            beq.w   sub_4089923C
            move.l  D2,D6
            swap    D6
            andi.l  #$FFFF,D2
            beq.w   .L6
            move.l  A2,D5
            btst    #0,D5
            bne.w   .L7
.L2:
            move.l  D2,D4
            move.b  D4,(A3)
            lsr.l   #8,D4
            move.b  D4,($10,A3)
            move.b  #$90,($30,A3)
            move.w  D2,D4
            lsr.w   #5,D4
            ror.l   #1,D2
            andi.w  #$F,D2
            neg.w   D2
            nop
            jmp     .L4(PC,D2.w*4)
.L3:
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
            move.w  (A2)+,($100,A1)
.L4:
            dbra    D4,.L3
            nop
            btst    #$1F,D2
            beq.b   .L5
            move.b  (A2)+,($100,A3)
.L5:
            bsr.w   WaitForIntNoTime
            bne.b   .L9
.L6:
            move.l  #$10000,D2
            dbra    D6,.L2
            moveq   #0,D0
            rts
.L7:
            subq.l  #1,D2
            move.b  (A2)+,($20,A3)
            bra.w   .L2
            moveq   #5,D0
            bra.b   .L10
.L8:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L9:
            moveq   #2,D0
.L10:
            swap    D6
            move.w  D4,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            moveq   #$1F,D2
            and.b   ($70,A3),D2
            add.w   D2,D6
            sub.l   D6,D1
            clr.l   ($144,A4)
            moveq   #9,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
FASTREAD_96:
            btst    #4,($158,A4)
            bne.w   .L8
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.b  #1,D0
            bne.w   sub_4089923C.L2
            cmpi.l  #1,D2
            beq.w   sub_4089921E
            move.l  D2,D6
            swap    D6
            andi.l  #$FFFF,D2
            beq.w   .L6
.L2:
            move.l  D2,D4
            move.b  D4,(A3)
            lsr.l   #8,D4
            move.b  D4,($10,A3)
            move.b  #$90,($30,A3)
.L3:
            move.w  D2,D4
            lsr.w   #5,D4
            ror.l   #1,D2
            andi.w  #$F,D2
            neg.w   D2
            nop
            jmp     .L5(PC,D2.w*4)
.L4:
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
            move.w  ($100,A1),(A2)+
.L5:
            dbra    D4,.L4
            nop
            bsr.w   WaitForIntNoTime
            bne.b   .L9
            btst    #$1F,D2
            beq.b   .L6
            bsr.w   sub_408996DA
            beq.b   .L7
            move.b  ($20,A3),(A2)+
.L6:
            move.l  #$10000,D2
            dbra    D6,.L2
            moveq   #0,D0
            rts
            subq.l  #1,D2
            move.b  ($20,A3),(A2)+
            bra.w   .L3
.L7:
            moveq   #9,D0
            bra.b   .L10
            moveq   #5,D0
            bra.b   .L10
.L8:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L9:
            moveq   #2,D0
.L10:
            swap    D6
            move.w  D4,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
            clr.l   ($144,A4)
            moveq   #8,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
sub_408996DA:
            movem.l D1-D2,-(SP)
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            move.l  D1,D2
            swap    D2
.L1:
            moveq   #$1F,D0
            and.b   ($70,A3),D0
            dbne    D1,.L1
            dbne    D2,.L1
            movem.l (SP)+,D1-D2
            rts
RESETBUS_96:
            move.b  #3,($30,A3)
            rts
WaitForIntNoTime:
            moveq   #0,D5
            move.b  ($40,A3),D5
            btst    #7,D5
            beq.b   WaitForIntNoTime
            swap    D5
            move.b  ($70,A3),D5
            lsl.w   #8,D5
            move.b  ($50,A3),D5
            move.l  D5,D0
            swap    D5
            andi.b  #$30,D0
            cmpi.b  #$10,D0
            rts
WaitForSCSIIntrp:
            moveq   #0,D5
            moveq   #0,D3
            move.w  TimeSCSIDB,D3
            lsl.l   #8,D3
            move.l  D3,D0
            swap    D0
.L1:
            move.b  ($40,A3),D5
            btst    #7,D5
            dbne    D3,.L1
            dbne    D0,.L1
            beq.b   .L3
            swap    D5
            move.b  ($70,A3),D5
            lsl.w   #8,D5
            move.b  ($50,A3),D5
.L2:
            swap    D5
            btst    #7,D5
            rts
.L3:
            swap    D5
            move.b  ($70,A3),D5
            lsl.w   #8,D5
            clr.b   D5
            bra.b   .L2
FASTCOMP_96:
            btst    #4,($158,A4)
            bne.w   .L6
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.b  #1,D0
            bne.w   sub_4089923C.L2
            cmpi.l  #1,D2
            beq.w   SLOWCOMP_96
            moveq   #0,D3
            move.l  D2,D6
            swap    D6
            andi.l  #$FFFF,D2
            beq.b   .L5
.L2:
            move.l  D2,D4
            move.b  D4,(A3)
            lsr.l   #8,D4
            move.b  D4,($10,A3)
            move.b  #$90,($30,A3)
            ror.l   #1,D2
            subq.w  #1,D2
.L3:
            move.w  ($100,A3),D0
            cmp.w   (A2)+,D0
            beq.b   .L4
            moveq   #6,D3
.L4:
            dbra    D2,.L3
            bsr.w   WaitForIntNoTime
            bne.b   .L7
            btst    #$1F,D2
            beq.b   .L5
            move.b  ($20,A3),D0
            cmp.b   (A2)+,D0
            beq.b   .L5
            moveq   #6,D3
.L5:
            move.l  #$10000,D2
            dbra    D6,.L2
            move.l  D3,D0
            rts
            moveq   #5,D0
            bra.b   .L8
.L6:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L7:
            moveq   #2,D0
.L8:
            swap    D6
            move.w  D4,D6
            lsl.l   #5,D6
            ext.l   D2
            addq.l  #1,D2
            add.l   D2,D6
            sub.l   D6,D1
            clr.l   ($144,A4)
            move.l  #$F8,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
SLOWCOMP_96:
            btst    #4,($158,A4)
            bne.w   .L14
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.w  #1,D0
            bne.w   sub_4089923C.L2
            moveq   #0,D3
            move.l  D2,D4
            lsr.l   #4,D4
            beq.w   .L10
            subq.l  #1,D4
            move.l  D4,D6
            swap    D6
            jsr     (SCSIPCTO32BIT.w,PC)
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            _SwapMMUMode
            move.l  A2,D0
            _StripAddress
            movea.l D0,A2
            movea.l ($13C,A4),A0
            clr.b   ($10,A3)
            move.b  #$10,(A3)
            andi.l  #$F,D2
.L2:
            move.b  #$90,($30,A3)
.L3:
            btst    #7,($40,A3)
            bne.b   .L11
            btst    #4,($40,A3)
            beq.b   .L3
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L3
            move.w  #7,D5
.L4:
            move.w  ($100,A3),D0
            cmp.w   (A2)+,D0
            beq.b   .L5
            moveq   #6,D3
.L5:
            dbra    D5,.L4
.L6:
            btst    #7,($40,A3)
            beq.b   .L6
            move.b  ($50,A3),D5
            btst    #5,D5
            bne.b   .L12
            dbra    D4,.L2
            dbra    D6,.L2
            move.b  (SP)+,D0
            _SwapMMUMode
            bra.b   .L10
.L7:
            moveq   #7,D5
            and.b   ($40,A3),D5
            cmpi.b  #1,D5
            bne.b   .L13
            move.b  #$10,($30,A3)
.L8:
            btst    #7,($40,A3)
            beq.b   .L8
            move.b  ($20,A3),D0
            cmp.b   (A2)+,D0
            beq.b   .L9
            moveq   #6,D3
.L9:
            move.b  ($50,A3),D5
            btst    #5,D5
            bne.b   .L15
.L10:
            dbra    D2,.L7
            move.l  D3,D0
            rts
.L11:
            bsr.w   WaitForIntNoTime
.L12:
            move.b  (SP)+,D0
            _SwapMMUMode
            addq.w  #1,D4
            swap    D6
            move.w  D4,D6
            lsl.l   #4,D6
            andi.b  #7,D5
            cmpi.b  #1,D5
            beq.b   .L15
.L13:
            moveq   #5,D0
            bra.b   .L16
.L14:
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bsr.w   WaitForIntNoTime
            beq.w   .L1
.L15:
            moveq   #2,D0
.L16:
            add.l   D2,D6
            sub.l   D6,D1
            move.l  #$F5,D6
            bsr.w   ERROR
            move.b  #1,($30,A3)
            rts
BUSERRHANDLER_96:
            move.l  D0,-(SP)
            move.l  SCSIBase,D0
            addi.l  #$100,D0
            cmp.l   ($18,SP),D0
            beq.b   .L1
            addi.l  #$40000,D0
            cmp.l   ($18,SP),D0
            beq.b   .L1
            move.l  SCSI2Base,D0
            addi.l  #$100,D0
            cmp.l   ($18,SP),D0
            beq.b   .L1
            addi.l  #$40000,D0
            cmp.l   ($18,SP),D0
            beq.b   .L1
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  A0,-(SP)
            movea.l SCSIGlobals,A0
            move.l  ($1C0,A0),(4,SP)
            movea.l (SP)+,A0
            rts
.L1:
            subq.w  #1,(-6,A6)
            beq.b   .L3
            move.w  TimeDBRA,D0
            lsr.w   #4,D0
.L2:
            dbra    D0,.L2
            move.l  (SP)+,D0
            rte
.L3:
            addq.l  #4,SP
            move.w  (SP),D0
            bfextu  (6,SP){0:4},D1
            cmpi.b  #7,D1
            beq.b   .L4
            cmpi.b  #$A,D1
            bne.b   .L5
            lea     ($20,SP),SP
            bra.b   .L6
.L4:
            lea     ($3C,SP),SP
            bra.b   .L6
.L5:
            lea     ($5C,SP),SP
.L6:
            move.w  D7,-(SP)
            pea     sub_408999CC
            move.w  D0,-(SP)
            rte
sub_408999CC:
            moveq   #9,D0
            btst    #7,($40,A3)
            beq.b   .L1
            move.b  ($50,A3),D5
            btst    #4,D5
            beq.b   .L1
            moveq   #5,D0
.L1:
            rts
            ds.b    12

            EVEN
