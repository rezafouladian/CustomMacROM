            include "Include/ROMHeader.s"

            EXPORT  INITSCSIHW,INITSCSIMGRPATCH1,INITSCSIMGRPATCH2,INSTALLSCSIINTHND96,SCSIDOCOMPLETEPATCH,SCSIGETPATCH
            EXPORT  SCSIMISCPATCH,SCSISETFLAGSPATCH

            IMPORT  CacheFlush,INITSCSIDONE,INTHND_SCSI96,SCSIExitCleanup,SCSIHW96,SCSIINIT96
            IMPORT  SCSIINTHNDRESUME,SCSISetFlags

            SECTION "SCSIMiscPatch",CODE

SCSIMISCPATCH:
SREADPATCH:
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            bsr.l   CacheFlush
.L1:
            lea     ($16,SP),SP
            move.w  D7,D0
            move.l  (SP)+,D7
            tst.w   D0
            rts
INITSCSIHW:
            movem.l A3-A4,-(SP)
            movea.l SCSIBase,A3
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L1
            movea.l #$F9800024,A4
            bsr.l   SCSIHW96
            btst    #1,AddrMapFlags                 ; TestFor SCSI96_2Exists
            beq.b   .L2
            movea.l SCSI2Base,A3
            movea.l #$F9800028,A4
            bsr.l   SCSIHW96
            bra.b   .L2
.L1:
            bsr.b   INITHW_SCSI80
.L2:
            movem.l (SP)+,A3-A4
            rts
INITHW_SCSI80:
            clr.b   ($10,A3)
            clr.b   ($20,A3)
            clr.b   ($30,A3)
            clr.b   ($40,A3)
            rts
INSTALLSCSIINTHND96:
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L1
            lea     (INTHND_SCSI96.w,PC),A1
.L1:
            btst    #4,($67,A4)
            bra.l   SCSIINTHNDRESUME
SCSI96BUSERRPATCH:
            moveq   #9,D0
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L1
            rts
.L1:
            btst    #3,(A1)
            bne.b   .L2
            moveq   #5,D0
.L2:
            rts
INITSCSIMGRPATCH1:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            moveq   #$E,D0
            _NewPtrSysClear
            bne.l   INITSCSIDONE
            move.l  A0,($6C,A4)
            movea.l A4,A0
.L1:
            bsr.l   SCSISetFlags
            move.l  D0,($64,A4)
            rts
INITSCSIMGRPATCH2:
            movea.l D0,A1
            add.l   D1,D0
            move.l  D0,(A1)
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L1
            bsr.l   SCSIINIT96
.L1:
            subq.w  #4,SP
            movea.l SP,A0
            _GetDefaultStartup
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            tst.w   D1
            bge.b   .L2
            not.w   D1
            subi.w  #$20,D1
            blt.b   .L2
            cmpi.w  #7,D1
            bgt.b   .L2
            move.b  SCSIPoll,D0
            andi.b  #$F8,D0
            or.b    D1,D0
            move.b  D0,SCSIPoll
.L2:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L3
            lea     DOSPINDOWN,A1
            movea.l PmgrBase,A0
            move.l  A1,($16,A0)
            movea.l ($6C,A4),A0
            lea     SLEEPTASK,A1
            move.l  A1,(6,A0)
            move.w  #$10,(4,A0)
            clr.w   ($A,A0)
            _SleepQInstall
.L3:
            rts
SCSISETFLAGSPATCH:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            bset    #0,D0
.L1:
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L2
            bset    #8,D0
.L2:
            btst    #1,AddrMapFlags                 ; TestFor SCSI96_2Exists
            beq.b   .L3
            bset    #9,D0
.L3:
            tst.b   CPUFlag
            bne.b   .L4
            bset    #6,D0
.L4:
            rts
DOSPINDOWN:
            link.w  A6,#-$E
            lea     (-$E,A6),A0
            move.w  #$10,(A0)
            move.w  #1,(2,A0)
            move.w  #$400,(-2,A6)
            pea     (-2,A6)
            move.l  (SP)+,(4,A0)
            move.l  D7,(8,A0)
            _PMgrOp
            tst.w   D0
            bne.b   .L1
            movea.l PmgrBase,A0
            clr.l   ($1E,A0)
            bclr    #2,($54,A0)
.L1:
            unlk    A6
            rts
SLEEPTASK:
            move.l  A1,-(SP)
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #6,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            movea.l SCSIGlobals,A1
            tst.l   ($50,A1)
            bne.b   .L3
.L1:
            movea.l PmgrBase,A1
            movea.l ($16,A1),A1
            jsr     (A1)
.L2:
            moveq   #0,D0
.L3:
            movea.l (SP)+,A1
            rts
SCSIGETPATCH:
            movea.l ($170,A4),A0
            jsr     (A0)
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            movea.l PmgrBase,A0
            move.l  D7,($1E,A0)
            bset    #2,($54,A0)
            bne.b   .L1
            link.w  A6,#-$E
            lea     (-$E,A6),A0
            move.w  #$10,(A0)
            move.w  #1,(2,A0)
            move.w  #$8400,(-2,A6)
            pea     (-2,A6)
            move.l  (SP)+,(4,A0)
            move.l  D7,(8,A0)
            _PMgrOp
            unlk    A6
.L1:
            rts
SCSIDOCOMPLETEPATCH:
            movea.l (SP)+,A2
            move.w  (SP)+,($14,A6)
            bsr.l   SCSIExitCleanup
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            movea.l PmgrBase,A0
            move.l  Ticks,($1E,A0)
.L1:
            jmp     (A2)
            ds.b    470

            EVEN
