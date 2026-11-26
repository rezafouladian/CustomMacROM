            include "Include/ROMHeader.s"

            EXPORT  SCSIINIT96

            IMPORT  BUSERRHANDLER_96,CLEARIRQ_96,CYCLEPHASE_96,DOSCSISELATN_D96,FASTCOMP_96,FASTREAD_96
            IMPORT  FASTWRITE_96,RESETBUS_96,SCSI96,SCSIERR_96,SLOWCOMP_96,SLOWREAD_96
            IMPORT  SLOWWRITE_96,TRANSFER_96,UNIMPLEMENTED_96

            SECTION "SCSIMgrInit96",CODE

SCSIINIT96:
INITMGR_SCSI96:
            movem.l D0-D7/A0-A5,-(SP)
            moveq   #0,D7
            movea.l SCSIGlobals,A4
            moveq   #$D,D1
            lea     (SCSI96.w,PC),A1
            move.l  A1,D0
            lea     .L4,A1
            movea.l A4,A0
.L1:
            moveq   #0,D2
            move.w  (A1)+,D2
            add.l   D0,D2
            move.l  D2,(A0)+
            dbra    D1,.L1
            lea     (TRANSFER_96.w,PC),A1
            move.l  A1,($19C,A4)
            lea     (RESETBUS_96.w,PC),A1
            move.l  A1,($1A4,A4)
            lea     (BUSERRHANDLER_96.w,PC),A1
            move.l  A1,($1AC,A4)
            lea     (SLOWREAD_96.w,PC),A1
            move.l  A1,($C4,A4)
            lea     (SLOWWRITE_96.w,PC),A1
            move.l  A1,($C8,A4)
            lea     (FASTREAD_96.w,PC),A1
            move.l  A1,($CC,A4)
            lea     (FASTWRITE_96.w,PC),A1
            move.l  A1,($D0,A4)
            lea     (CLEARIRQ_96.w,PC),A1
            move.l  A1,($16C,A4)
            lea     (SLOWCOMP_96.w,PC),A1
            move.l  A1,($D4,A4)
            lea     (FASTCOMP_96.w,PC),A1
            move.l  A1,($DC,A4)
            lea     (SCSIERR_96.w,PC),A1
            move.l  A1,($1D4,A4)
            lea     (CYCLEPHASE_96.w,PC),A1
            move.l  A1,($1DC,A4)
            lea     (UNIMPLEMENTED_96.w,PC),A1
            move.l  A1,($1F4,A4)
            move.l  A1,($1F8,A4)
            move.l  A1,($1FC,A4)
            move.l  D7,D0
            movea.l ($170,A4),A0
            jsr     (A0)
            clr.l   ($154,A4)
            clr.l   ($144,A4)
            clr.l   ($158,A4)
            clr.l   ($1CC,A4)
            clr.l   ($1D0,A4)
            clr.l   ($1C8,A4)
            clr.l   ($13C,A4)
            move.b  ($60,A4),D1
            move.b  #7,D0
.L2:
            lsl.b   #1,D1
            dbeq    D0,.L2
            ori.b   #$47,D0
            move.b  D0,($80,A3)
            move.l  SCSIBase,($1C4,A4)
            move.l  #$F9800024,($44,A4)
            btst    #1,AddrMapFlags                 ; TestFor SCSI96_2Exists
            beq.b   .L3
            move.l  SCSI2Base,($1C8,A4)
            move.l  #$F9800028,($48,A4)
            lea     (DOSCSISELATN_D96.w,PC),A1
            move.l  A1,(8,A4)
            lea     (DOSCSISELATN_D96.w,PC),A1
            move.l  A1,($2C,A4)
.L3:
            move.b  #2,($7E,A4)
            movem.l (SP)+,D0-D7/A0-A5
            rts
.L4:
            dc.w    $008A,$00D0,$017E,$01C0,$0270,$01F4,$01EC,$004E
            dc.w    $01F0,$01E8,$0054,$017E,$036E,$038C
            ds.b    6

            EVEN
