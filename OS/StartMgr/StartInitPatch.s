            include "Include/ROMHeader.s"

            EXPORT  BOOTBLOCKFLUSHPATCH,DisableMMUPatch,DrawBeepScreenPatch,EnableCachesPatch,InitHWRoutines,INITMEMDISPANDSHUTDOWNMGRS
            EXPORT  InitMemMgrPatch,INITSNDNORAM,INSTALLSONYDRIVERPATCH,POWERDWNPTCH,SetupMiscSCSI,SysErrInitPatch
            EXPORT  WhichCPUPatch

            IMPORT  BOOTBLOCKFLUSHRETURN,CacheFlush,DrawBeepScreen,DrawBeepScreenReturn,GetHardwareInfo,InitIWM
            IMPORT  InitMemMgr,InitMemoryDispatch,InitSCC,InitSCSI,InitShutdownMgr,InstallFPSP
            IMPORT  INSTALLPRIVTRAP,RdXByte,SysErrInit

            SECTION "StartInitPatch",CODE

WhichCPUPatch:
            sub.l   D7,D7
            bset    #CACR_DE_040,D7
            movec   D7,CACR
            movec   CACR,D7
            bclr    #CACR_DE_040,D7
            movec   D7,CACR
            beq.b   .notAn040
            mc68040
            cinva   BC
            mc68030
            moveq   #cpu68040,D7
            rts
.notAn040:
            ; Set EI (enable inst. cache), CI (flush inst cache),
            ; CD (flush data cache) and WA in the 020/030 CACR
            move.w  #(1<<CACR_EI_020_030|1<<CACR_CI_020_030|1<<CACR_CD_030|1<<CACR_WA_030),D7
            movec   D7,CACR
            movec   CACR,D7
            lsl.w   #3,D7
            moveq   #2>>1,D7
            addx.l  D7,D7
            rts
EnableCachesPatch:
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            move.l  #$80008000,D0
            movec   D0,CACR
            bra.b   .L2
.L1:
            move.l  #$3919,D0
            movec   D0,CACR
.L2:
            rts
DisableMMUPatch:
            sub.l   D0,D0
            bset    #CACR_DE_040,D0                 ; Set Data Cache Enable bit on 040s
            movec   D0,CACR
            movec   CACR,D0
            btst    #CACR_DE_040,D0                 ; See if bit exists in CACR
            beq.b   .not040
            mc68040
            cinva   BC                              ; Make sure caches are invalidated
            sub.l   D0,D0                           ; Clear D0
            movec   D0,CACR
            movec   D0,TC
            move.l  #nuBusTTxlat,D0
            movec   D0,DTT0
            move.l  #ioNuBusTTxlat,D0
            movec   D0,DTT1
            bra.b   .not030
            mc68030
.not040:
            move.l  #(1<<CACR_WA_030),D0
            movec   D0,CACR
            movec   CACR,D0
            tst.l   D0
            beq.b   .not030
            lea     .TCOff,A0
            pmove.l (A0),TC
.not030:
            RTS6
.TCOff:
            ds.l    1
SwitchMMUPatch:
            movec   CACR,D1
            sub.l   D0,D0
            bset    #$1F,D0
            movec   D0,CACR
            movec   CACR,D0
            bclr    #$1F,D0
            beq.b   .L1
            movec   D0,CACR
            mc68040
            movec   D0,TC
            pflusha
            mc68030
            movea.l (A0),A2
            move.l  (8,A0),D0
            mc68040
            movec   D0,TC
            cpusha  BC
            mc68030
            bra.b   .L2
.L1:
            movec   CACR,D0
            move.w  D0,D1
            andi.w  #$FEFE,D0
            movec   D0,CACR
            lea     DisableMMUPatch.TCOff,A2
            pmove.l (A2),TC
            pflusha
            pmove.d (A0),CRP
            pmove.l (8,A0),TC
            ori.w   #$808,D1
.L2:
            movec   D1,CACR
            jmp     (A1)
SetupMiscSCSI:
            btst    #$18,D0
            beq.b   .L1
            move.w  #$18,D3
            lsl.w   #2,D3
            move.l  (0,A0,D3.w),SCSIBase
.L1:
            btst    #$19,D0
            beq.b   .L2
            move.w  #$19,D3
            lsl.w   #2,D3
            move.l  (0,A0,D3.w),SCSI2Base
            bra.b   .L4
.L2:
            btst    #9,D0
            bne.b   .L3
            move.l  SCSIHsk,SCSIDMA
.L3:
            btst    #$A,D0
            bne.b   .L4
            move.l  SCSIDMA,SCSIHsk
.L4:
            rts
SETUPSCSITIME:
            movea.l SCSIBase,A0
            btst    #0,AddrMapFlags                 ; TestFor SCSI96_1Exists
            beq.b   .L2
            move.b  D1,($1000,A1)
            move.b  D2,($1200,A1)
.L1:
            btst    #0,($40,A0)
            dbra    D0,.L1
            jmp     (A2)
.L2:
            move.b  D1,($1000,A1)
            move.b  D2,($1200,A1)
.L3:
            btst    #0,($40,A0)
            dbra    D0,.L3
            jmp     (A2)
SysErrInitPatch:
            BSR6    SysErrInit
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            bsr.l   InstallFPSP
.L1:
            rts
InitMemMgrPatch:
            bsr.w   InitMemMgr
            bsr.l   INSTALLPRIVTRAP
            rts
INITMEMDISPANDSHUTDOWNMGRS:
            bsr.l   InitMemoryDispatch
            bsr.l   InitShutdownMgr
            rts
DrawBeepScreenPatch:
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            pea     (-$18,A2)
            _FillRect
            _PenNormal
            rts
.L1:
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            bra.l   DrawBeepScreenReturn
BOOTBLOCKFLUSHPATCH:
            _Read
            bne.b   .L1
            bsr.l   CacheFlush
            cmpi.w  #$4C4B,(A6)
.L1:
            bra.l   BOOTBLOCKFLUSHRETURN
INSTALLSONYDRIVERPATCH:
            btst    #IWMExists,(AddrMapFlags+3).w   ; TestFor IWMExists
            bne.b   .L1
            btst    #SWIMIOPExists-16,(AddrMapFlags+1).w ; TestFor SWIMIOPExists
            beq.b   .L2
.L1:
            move.l  A1,($12,A0)
            _Open
.L2:
            rts
POWERDWNPTCH:
            btst    #0,HWCfgFlags                   ; TestFor hwCbPwrMgr
            beq.b   .L1
            subq.w  #4,SP
            move.b  #$5B,(SP)
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.w  #1,-(SP)
            move.w  #$10,-(SP)
            movea.l SP,A0
            _PMgrOp
            lea     ($10,SP),SP
            movea.l PmgrBase,A0
            bclr    #2,($54,A0)
.L1:
            bsr.w   DrawBeepScreen
            rts
InitHWRoutines:
            bsr.l   InitSCC
            move.w  D2,-(SP)
            bsr.l   InitIWM
            move.w  (SP)+,D2
            bsr.l   InitSCSI
            bsr.b   INITSNDHW
            rts
INITSNDHW:
            movem.l D3-D4/A0-A6,-(SP)
            movea.l UnivInfoPtr,A0
            adda.l  (A0),A0
            move.b  SdVolume,D0
            BSR6    INITSNDNORAM.L4
            movem.l (SP)+,D3-D4/A0-A6
            rts
INITSNDNORAM:
            move.l  A5,D3
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l (8,A0),A2
            move.w  #$10,D1
            BigBSR6 RdXByte,A0
            cmpi.b  #$A8,D1
            beq.b   .L1
            moveq   #5,D1
            bra.b   .L2
.L1:
            move.w  #8,D1
            BigBSR6 RdXByte,A0
.L2:
            andi.b  #7,D1
            bne.b   .L3
            move.b  #5,D1
.L3:
            move.b  D1,D4
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            move.b  D4,D0
            BSR6    .L4
            movea.l D3,A5
            RTS5
.L4:
            movea.l ($30,A0),A3
            move.b  D0,D1
            asl.b   #5,D1
            move.b  D1,($806,A3)
            move.b  ($800,A3),D1
            andi.b  #$F0,D1
            cmpi.b  #$B0,D1
            bne.w   .L6
            move.w  #$7F00,($F06,A3)
            move.w  #$7F,($F26,A3)
            cmpi.b  #9,(-4,A0)
            bne.b   .L5
            mulu.w  #$12,D0
            move.b  D0,($F06,A3)
            clr.b   ($F07,A3)
            clr.b   ($F26,A3)
            move.b  D0,($F27,A3)
.L5:
            move.b  #1,($F09,A3)
            move.b  #1,($F29,A3)
            ori.b   #$80,($803,A3)
            andi.b  #$7F,($803,A3)
            move.b  #2,($80A,A3)
            move.b  #1,($801,A3)
            clr.b   ($F08,A3)
            clr.b   ($F28,A3)
            move.w  #$812F,($F04,A3)
            move.w  #$812F,($F24,A3)
            clr.w   ($F10,A3)
            move.w  #$3C,($F12,A3)
            move.w  #$CC73,($F14,A3)
            move.w  #$C962,($F16,A3)
            clr.w   ($F30,A3)
            move.w  #$3C,($F32,A3)
            move.w  #$CC73,($F34,A3)
            move.w  #$C962,($F36,A3)
            move.b  #$80,($F08,A3)
            move.b  #$80,($F28,A3)
.L6:
            RTS6
            ds.b    694

            EVEN
