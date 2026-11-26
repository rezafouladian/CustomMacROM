            include "Include/ROMHeader.s"

            EXPORT  CYCLEPHASE_96,DOSCSISELATN_D96,ERROR,SCSI96,SCSIERR_96,SCSIPCTO32BIT
            EXPORT  UNIMPLEMENTED_96

            IMPORT  WaitForIntNoTime,WaitForSCSIIntrp,XFER1BYTE

            SECTION "SCSIMgr96",CODE

SCSI96:
SCSIMGR_96:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.l  A0,-(SP)
            link.w  A6,#-6
            movem.l D2-D7/A2-A5,-(SP)
            movea.l SCSIGlobals,A4
            movea.l ($40,A4),A3
            moveq   #0,D7
            moveq   #0,D4
            move.w  D0,D1
            cmpi.w  #$E,D0
            bcc.b   .L1
            movea.l (0,A4,D0.w*4),A0
            jmp     (A0)
.L1:
            cmpi.w  #$12,D0
            bcc.b   UNIMPLEMENTED_96
            subi.w  #$E,D0
            lea     ($1F0,A4),A0
            movea.l (0,A0,D0.w*4),A0
            jmp     (A0)
StdExit_ScrapMgr:
            movem.l (SP)+,D2-D7/A2-A5
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
sub_40898A68:
            move.b  D7,($61,A4)
            rts
UNIMPLEMENTED_96:
            moveq   #$C,D0
            _SysError
.L1:
            bra.b   .L1
DOSCSISTAT_96:
            andi.w  #$FFF2,($144,A4)
            move.l  A3,-(SP)
            moveq   #0,D1
            movea.l ($1C4,A4),A3
            move.b  ($40,A3),D1
            btst    #1,AddrMapFlags                 ; TestFor SCSI96_2Exists
            beq.b   .L1
            movea.l ($1C8,A4),A3
            or.b    ($40,A3),D1
.L1:
            movea.l (SP)+,A3
            andi.b  #7,D1
            lsl.b   #2,D1
            or.w    D1,($144,A4)
            move.w  ($144,A4),(8,A6)
            bra.b   DOSCSIRESET_96.L3
DOSCSIRESET_96:
            move.l  A3,-(SP)
            movea.l ($1A4,A4),A0
            movea.l ($1C4,A4),A3
            jsr     (A0)
            btst    #1,AddrMapFlags                 ; TestFor SCSI96_2Exists
            beq.b   .L1
            movea.l ($1A4,A4),A0
            movea.l ($1C8,A4),A3
            jsr     (A0)
.L1:
            movea.l (SP)+,A3
            clr.l   ($144,A4)
            move.w  D7,(8,A6)
            bsr.b   sub_40898A68
            moveq   #0,D2
            move.w  TimeDBRA,D2
            lsl.l   #8,D2
            lsl.l   #1,D2
            move.l  D2,D3
            swap    D3
.L2:
            dbra    D2,.L2
            dbra    D3,.L2
.L3:
            moveq   #0,D0
            bra.w   StdExit_ScrapMgr
DOSCSIGET_96:
            bset    #0,($61,A4)
            bne.b   .L2
            move.w  #$42,($144,A4)
            moveq   #0,D0
.L1:
            move.w  D0,(8,A6)
            bra.b   DOSCSIRESET_96.L3
.L2:
            moveq   #7,D0
            bra.b   .L1
DOSCSISELATN_D96:
DOSCSISELECT_D96:
            bset    #0,($61,A4)
            move.w  ($144,A4),-(SP)
            move.w  #$40,(SP)
            moveq   #0,D6
            move.w  (8,A6),D6
            cmpi.w  #$B,D1
            bne.b   .L1
            bset    #$10,D6
            ori.w   #$200,(SP)
.L1:
            move.l  D6,($140,A4)
            btst    D6,($1D0,A4)
            bne.b   .L3
            movea.l ($1C4,A4),A3
            move.l  A3,($40,A4)
            movea.l ($44,A4),A0
            move.l  D6,D0
            bsr.w   sub_40898DC8
            bne.b   .L2
            bset    D6,($1CC,A4)
            bra.b   .L4
.L2:
            btst    D6,($1CC,A4)
            bne.b   .L5
.L3:
            movea.l ($1C8,A4),A3
            move.l  A3,($40,A4)
            movea.l ($48,A4),A0
            move.l  D6,D0
            bsr.w   sub_40898DC8
            bne.b   .L5
            bset    D6,($1D0,A4)
.L4:
            move.w  (SP)+,($144,A4)
            move.l  A0,($13C,A4)
            move.w  D0,($A,A6)
            moveq   #2,D0
            bra.w   StdExit_ScrapMgr
.L5:
            clr.w   (SP)
            move.l  D0,-(SP)
            bsr.w   sub_40898A68
            move.l  (SP)+,D0
            moveq   #2,D6
            bsr.w   ERROR
            move.w  (SP)+,($144,A4)
            move.w  D0,($A,A6)
            moveq   #2,D0
            bra.w   StdExit_ScrapMgr
DOSCSISELATN_S96:
DOSCSISELECT_S96:
            bset    #0,($61,A4)
            move.w  ($144,A4),-(SP)
            move.w  #$40,(SP)
            moveq   #0,D0
            move.w  (8,A6),D0
            cmpi.w  #$B,D1
            bne.b   .L1
            bset    #$10,D0
            ori.w   #$200,(SP)
.L1:
            move.l  D6,($140,A4)
            movea.l ($44,A4),A0
            bsr.w   sub_40898DC8
            bne.b   DOSCSISELECT_D96.L5
            move.w  (SP)+,($144,A4)
            move.l  A0,($13C,A4)
            move.w  D0,($A,A6)
            moveq   #2,D0
            bra.w   StdExit_ScrapMgr
DOSCSICMD_96:
            movea.l ($A,A6),A2
            move.w  (8,A6),D2
            bsr.w   sub_40898E7A
            bne.b   .L2
.L1:
            move.w  D0,($E,A6)
            moveq   #6,D0
            bra.w   StdExit_ScrapMgr
.L2:
            move.l  D0,-(SP)
            bsr.w   sub_40898A68
            move.l  (SP)+,D0
            moveq   #3,D6
            bsr.w   ERROR
            bra.b   .L1
NEWSCSIWBLIND_96:
            moveq   #$2C,D4
            bra.b   NEWSCSIREAD_96.L1
NEWSCSIWRITE_96:
            moveq   #$24,D4
            bra.b   NEWSCSIREAD_96.L1
NEWSCSIRBLIND_96:
            moveq   #$28,D4
            bra.b   NEWSCSIREAD_96.L1
NEWSCSIREAD_96:
            moveq   #$20,D4
.L1:
            movea.l (8,A6),A1
            bra.b   .L3
.L12:
            bset    #4,D4
.L7:
            movea.l ($19C,A4),A0
            jsr     (A0)
            bne.b   .L6
            add.l   D1,(2,A1)
            bclr    #4,D4
.L2:
            lea     ($A,A1),A1
.L3:
            move.w  (A1),D1
            movea.l (2,A1),A2
            move.l  (6,A1),D2
            cmpi.w  #8,D1
            bhi.b   .L5
            add.w   D1,D1
            jmp     .L4(PC,D1.w)
.L4:
            bra.b   .L5
            bra.b   .L7
            bra.b   .L8
            bra.b   .L9
            bra.b   .L10
            bra.b   .L11
            bra.b   .L2
            bra.b   .L13
            bra.b   .L12
.L5:
            moveq   #4,D0
            bra.b   .L6
.L8:
            movea.l ($19C,A4),A0
            jsr     (A0)
            bne.b   .L6
            bra.b   .L2
.L9:
            add.l   D2,(A2)
            bra.b   .L2
.L10:
            movea.l D2,A0
            move.l  (A2),(A0)
            bra.b   .L2
.L11:
            tst.l   D2
            beq.b   .L2
            subq.l  #1,D2
            move.l  D2,(6,A1)
            beq.b   .L2
            adda.l  A2,A1
            bra.b   .L3
.L13:
            moveq   #0,D0
.L6:
            move.w  D0,($C,A6)
            moveq   #4,D0
            bra.w   StdExit_ScrapMgr
DOSCSICOMPLETE_96:
            move.w  D7,-(SP)
            move.l  Ticks,D4
            add.l   (8,A6),D4
.L1:
            btst    #4,($158,A4)
            bne.w   .L6
            btst    #3,($158,A4)
            bne.b   .L4
.L2:
            moveq   #7,D3
            and.b   ($40,A3),D3
            cmpi.b  #3,D3
            bne.w   .L7
            move.b  #$11,($30,A3)
            bsr.w   WaitForSCSIIntrp
            beq.w   .L9
            moveq   #0,D2
            move.b  ($20,A3),D2
            movea.l ($10,A6),A1
            move.w  D2,(A1)
            move.b  ($20,A3),D2
            movea.l ($C,A6),A1
            move.w  D2,(A1)
            move.b  #$12,($30,A3)
            bsr.w   WaitForSCSIIntrp
            beq.w   .L9
.L3:
            clr.l   ($144,A4)
            move.w  (SP)+,($14,A6)
            bsr.w   sub_40898A68
            moveq   #$C,D0
            bra.w   StdExit_ScrapMgr
.L4:
            moveq   #7,D3
            and.b   ($40,A3),D3
            btst    #2,($158,A4)
            beq.b   .L5
            cmpi.b  #6,D3
            beq.b   .L7
            bclr    #2,($158,A4)
            bset    #4,($158,A4)
            bra.b   .L6
.L5:
            btst    #1,($158,A4)
            beq.b   .L7
            cmpi.b  #2,D3
            beq.b   .L7
            bclr    #1,($158,A4)
            bset    #4,($158,A4)
            nop
.L6:
            btst    #7,($40,A3)
            beq.b   .L8
            bsr.w   WaitForSCSIIntrp
            move.b  #1,($30,A3)
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bra.w   .L2
.L7:
            move.w  #5,(SP)
            jsr     ([$1DC.w,A4])
            beq.b   .L8
            move.w  D0,(SP)
.L8:
            cmp.l   Ticks,D4
            bhi.w   .L1
            btst    #4,($158,A4)
            beq.w   .L3
.L9:
            move.w  #2,(SP)
            move.l  (SP),D0
            moveq   #4,D6
            bsr.w   ERROR
            bra.w   .L3
DOSCSIMSGIN_96:
            bsr.w   sub_40898F08
            bne.b   .L2
            movea.l (8,A6),A1
            move.w  D2,(A1)
.L1:
            move.w  D0,($C,A6)
            moveq   #4,D0
            bra.w   StdExit_ScrapMgr
.L2:
            moveq   #$C,D6
            bsr.w   ERROR
            bra.b   .L1
DOSCSIMSGOUT_96:
            move.w  (8,A6),D2
            bsr.w   sub_40898F42
            bne.b   .L2
.L1:
            move.w  D0,($A,A6)
            moveq   #2,D0
            bra.w   StdExit_ScrapMgr
.L2:
            moveq   #$C,D6
            bsr.w   ERROR
            bra.b   .L1
sub_40898DC8:
            move.b  D0,($40,A3)
            swap    D0
            addi.b  #$C1,D0
            move.b  #1,($30,A3)
            move.b  D7,($10,A3)
            move.b  #1,(A3)
            move.b  D0,($30,A3)
            bset    #3,($158,A4)
            cmpi.b  #$C1,D0
            beq.w   .L1
            bset    #2,($158,A4)
            bra.b   .L2
.L1:
            bset    #1,($158,A4)
.L2:
            moveq   #0,D1
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            lsl.l   #1,D1
            move.l  D1,D2
            swap    D2
            moveq   #-1,D3
            moveq   #-1,D4
.L3:
            lsl.l   #8,D4
            move.b  ($60,A3),D4
            move.b  D4,D0
            andi.b  #7,D0
            beq.b   sub_40898E32
            lsl.l   #8,D3
            move.b  ($40,A3),D3
            move.b  D3,D0
            andi.b  #7,D0
            beq.b   sub_40898E32
.L4:
            moveq   #0,D0
            rts
sub_40898E32:
            lsl.l   #8,D3
            move.b  ($40,A3),D3
            move.b  D3,D0
            btst    #7,D0
            dbne    D1,sub_40898DC8.L3
            dbne    D2,sub_40898DC8.L3
            bne.w   .L1
            moveq   #3,D0
            bra.w   .L2
.L1:
            move.b  ($40,A3),D3
            move.b  ($50,A3),D1
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
            bclr    #2,($158,A4)
            bclr    #1,($158,A4)
            btst    #5,D1
            beq.b   sub_40898DC8.L4
.L2:
            moveq   #2,D0
            rts
sub_40898E7A:
            moveq   #7,D3
            and.b   ($40,A3),D3
            cmpi.b  #2,D3
            bne.b   .L9
            ori.b   #$80,($80,A3)
            subq.l  #1,D2
            bra.b   .L2
.L1:
            move.b  (A2)+,($20,A3)
.L2:
            dbra    D2,.L1
            jsr     SCSIPCTO32BIT
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            _SwapMMUMode
            movea.l ($13C,A4),A0
.L3:
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L3
            move.b  (SP)+,D0
            _SwapMMUMode
            move.b  (A2)+,($100,A3)
            bclr    #1,($158,A4)
            beq.b   .L4
            bset    #4,($158,A4)
.L4:
            moveq   #7,D3
            and.b   ($40,A3),D3
            cmpi.b  #2,D3
            beq.b   .L7
.L5:
            moveq   #0,D0
.L6:
            andi.b  #$7F,($80,A3)
            tst.w   D0
            rts
.L7:
            move.l  D7,D0
            move.w  TimeSCSIDB,D0
            lsl.l   #8,D0
            move.l  D0,D2
            swap    D2
.L8:
            moveq   #7,D3
            and.b   ($40,A3),D3
            cmpi.b  #2,D3
            dbne    D0,.L8
            dbne    D2,.L8
            bra.b   .L5
.L9:
            moveq   #5,D0
            moveq   #3,D6
            bsr.w   ERROR
            bra.b   .L6
sub_40898F08:
            moveq   #7,D3
            and.b   ($40,A3),D3
            cmpi.b  #7,D3
            bne.b   sub_40898F34.L1
            move.b  #$10,($30,A3)
            bsr.w   WaitForSCSIIntrp
            beq.b   sub_40898F34
            move.b  ($20,A3),D2
            move.b  #$12,($30,A3)
            bsr.w   WaitForSCSIIntrp
            beq.b   sub_40898F34
            moveq   #0,D0
            rts
sub_40898F34:
            moveq   #2,D0
            bra.b   .L2
.L1:
            moveq   #5,D0
.L2:
            clr.l   ($144,A4)
            tst.l   D0
            rts
sub_40898F42:
            move.b  ($40,A3),D3
            andi.b  #7,D3
            cmpi.b  #6,D3
            beq.b   .L3
            btst    #2,($158,A4)
            beq.b   .L2
            moveq   #0,D1
            move.w  TimeSCSIDB,D1
            lsl.l   #8,D1
            move.l  D1,D2
            swap    D2
.L1:
            btst    #7,($40,A3)
            bne.w   .L2
            move.b  ($60,A3),D0
            andi.b  #7,D0
            bne.b   .L3
            dbra    D1,.L1
            dbra    D2,.L1
            moveq   #2,D0
            bra.b   .L5
.L2:
            moveq   #5,D0
            bra.b   .L5
.L3:
            move.b  D2,($20,A3)
            bclr    #2,($158,A4)
            beq.b   .L4
            bset    #1,($158,A4)
.L4:
            moveq   #0,D0
.L5:
            andi.w  #$FDFF,($144,A4)
            tst.w   D0
            rts
CYCLEPHASE_96:
            btst    #0,($61,A4)
            beq.b   .L2
.L1:
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.w  #1,D0
            beq.b   .L3
            cmpi.w  #0,D0
            beq.b   .L3
            cmpi.w  #2,D0
            beq.b   .L6
            cmpi.w  #6,D0
            beq.w   .L10
            cmpi.w  #7,D0
            beq.w   .L12
            cmpi.w  #3,D0
            bne.b   .L2
            move.w  #$A,D0
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            move.b  ($30,A3),D1
            cmpi.b  #$90,D1
            bne.b   .L4
            tst.b   (A3)
            bne.w   .L13
            tst.b   ($10,A3)
            bne.w   .L13
.L4:
            cmpi.b  #0,D0
            beq.b   .L5
            bsr.w   XFER1BYTE
            bne.b   .L2
            move.b  ($20,A3),D0
            bra.b   .L1
.L5:
            move.b  #$EE,($20,A3)
            bsr.w   XFER1BYTE
            bne.b   .L2
            bra.b   .L1
.L6:
            bclr    #1,($158,A4)
            beq.b   .L8
            move.b  #$EE,($100,A3)
            bset    #4,($158,A4)
            bsr.w   WaitForSCSIIntrp
            beq.b   .L7
            bclr    #4,($158,A4)
            bclr    #3,($158,A4)
.L7:
            bra.b   .L9
.L8:
            move.b  #$EE,($20,A3)
            bsr.w   XFER1BYTE
            bne.b   .L2
.L9:
            bra.w   .L1
.L10:
            bclr    #2,($158,A4)
            beq.b   .L11
            bset    #1,($158,A4)
.L11:
            move.b  #8,($20,A3)
            bsr.w   XFER1BYTE
            bne.w   .L2
            bra.w   .L1
.L12:
            bsr.w   XFER1BYTE
            bne.w   .L2
            move.b  ($20,A3),D0
            bra.w   .L1
.L13:
            jsr     SCSIPCTO32BIT
            move.b  MMU32bit,-(SP)
            moveq   #1,D0
            _SwapMMUMode
            movea.l ($13C,A4),A0
            moveq   #7,D0
            and.b   ($40,A3),D0
            cmpi.w  #0,D0
            beq.b   .L16
.L14:
            btst    #7,($40,A3)
            bne.b   .L15
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L14
            move.w  ($100,A3),D5
            bra.b   .L14
.L15:
            bsr.w   WaitForIntNoTime
            bra.b   .L18
.L16:
            btst    #7,($40,A3)
            bne.b   .L17
            move.l  (A0),D5
            btst    #9,D5
            beq.b   .L16
            move.w  #$EEEE,($100,A3)
            bra.b   .L16
.L17:
            bsr.w   WaitForIntNoTime
.L18:
            move.b  (SP)+,D0
            _SwapMMUMode
            bra.w   .L1
SCSIPCTO32BIT:
            move.l  (SP),D0
            _Translate24To32
            move.l  D0,(SP)
            rts
ERROR:
            movea.l ($1D4,A4),A0
            jsr     (A0)
            rts
SCSIERR_96:
            dc.w    $4E75
            ds.b    12

            EVEN
