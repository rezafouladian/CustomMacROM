            include "Include/ROMHeader.s"

            EXPORT  BOOTBLOCKFLUSHPATCH,DisableMMUPatch,DrawBeepScreenPatch,EnableCachesPatch,GetVIAInputs,InitHWRoutines
            EXPORT  INITIOPMGR,INITMEMDISPANDSHUTDOWNMGRS,InitMemMgrPatch,INITSNDNORAM,INSTALLSONYDRIVERPATCH,IOPINTERRUPT
            EXPORT  IOPMGR,IOPMOVEDATA,IOPMsgRequest,MEMORYCTRLINITPATCH,POWERDWNPTCH,RELOADBERRVBR
            EXPORT  SCCIOPByPass,SCCIOPHwInit,SetupMiscSCSI,SysErrInitPatch,TestForFPU,TESTFORIOP
            EXPORT  TESTFORRPU,TESTFORRVIER,TESTFORSCSI96,TestForSCSIDMA,TESTFORVIER,TESTVIERWRAP
            EXPORT  WhichCPUPatch

            IMPORT  BOOTBLOCKFLUSHRETURN,CacheFlush,DequeueTrap,DrawBeepScreen,DrawBeepScreenReturn,GetHardwareInfo
            IMPORT  GotBusError,InitIWM,InitMemMgr,InitMemoryDispatch,InitSCC,InitSCSI
            IMPORT  InitShutdownMgr,InitVIAs,InstallFPSP,INSTALLPRIVTRAP,QStuff,RdXByte
            IMPORT  ROMBERRANDVBRRTN,SCCIOPBYPASSINT,SysErrInit

            SECTION "Part2",CODE

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
            move.b  ($1E00,A1),D2
            lsl.w   #8,D2                           ; Make room for direction bits
            move.b  ($600,A1),D2
            move.b  D2,D1
            and.b   (-$C,A0),D1
            move.b  D1,($600,A1)
            move.b  ($1E00,A1),D1
            move.b  D2,($600,A1)
            lsr.w   #8,D2
            move.b  D2,($1E00,A1)
            lsl.w   #8,D1
            move.b  (A1),D2
            lsl.w   #8,D2
            move.b  ($400,A1),D2
            move.b  D2,D1
            and.b   (-$B,A0),D1
            move.b  D1,($400,A1)
            move.b  (A1),D1
            move.b  D2,($400,A1)
            lsr.w   #8,D2
            move.b  D2,(A1)
.noVIA1:
            swap    D1
            btst    #$B,D0
            beq.b   .noVIA2
            movea.l ($2C,A0),A1
            move.b  ($1E00,A1),D2
            lsl.w   #8,D2
            move.b  ($600,A1),D2
            move.b  D2,D1
            and.b   (-$A,A0),D1
            move.b  D1,($600,A1)
            move.b  ($1E00,A1),D1
            move.b  D2,($600,A1)
            lsr.w   #8,D2
            move.b  D2,($1E00,A1)
            lsl.w   #8,D1
            move.b  (A1),D2
            lsl.w   #8,D2
            move.b  ($400,A1),D2
            move.b  D2,D1
            and.b   (-9,A0),D1
            move.b  D1,($400,A1)
            move.b  (A1),D1
            move.b  D2,($400,A1)
            lsr.w   #8,D2
            move.b  D2,(A1)
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
IOPMGR:
IOPInfoAccess:
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #noErr,D0
            moveq   #0,D1                           ; Zero extend
            move.b  (A0),D1
            cmpi.b  #2,D1
            bhi.b   .paramError
            move.w  .JumpTable(PC,D1.w*2),D2
            move.b  (1,A0),D1
            cmpi.b  #7,D1
            bhi.b   .paramError
            lea     ([IOPMgrVars.w],D1.w*4),A1
            jmp     .JumpTable(PC,D2.w)
.JumpTable:
            dc.w    .InstallIOP-.JumpTable
            dc.w    .GetIOPInfo-.JumpTable
            dc.w    .RemoveIOP-.JumpTable
.paramError:
            moveq   #-$32,D0
            bra.b   .Done
.GetIOPInfo:
            move.l  (A1),(4,A0)
.Done:
            movem.l (SP)+,D3-D4/A2-A4
            rts
.RemoveIOP:
            move.l  (A1),(4,A0)
            clr.l   (A1)
            bra.b   .Done
.InstallIOP:
            tst.l   (A1)
            bne.b   .paramError
            movea.l (4,A0),A4
            move.l  D1,D3
            subq.l  #4,SP
            move.l  #'iopc',-(SP)
            move.w  D3,-(SP)
            _RGetResource
            move.l  (SP)+,D0
            beq.b   .paramError
            movea.l D0,A0
            movea.l (A0),A0
            move    SR,-(SP)
            ori     #$700,SR
            movea.l (A4)+,A2
            movea.l (A4)+,A3
            movea.l (A4),A1
            move.b  #$32,(A1)
            move.w  #$7FFF,D0
            moveq   #-1,D1
.Fill_FF_Loop:
            move.w  D0,(A2)
            move.b  D1,(A3)
            dbra    D0,.Fill_FF_Loop
            move.w  #$7FFF,D0
.ComplementLoop:
            move.w  D0,(A2)
            move.b  (A3),D1
            not.b   D1
            move.w  D0,(A2)
            move.b  D1,(A3)
            dbne    D0,.ComplementLoop
            bne.b   .InitError
            move.w  #$7FFF,D0
.Check_00_Loop:
            move.w  D0,(A2)
            move.b  (A3),D1
            dbne    D0,.Check_00_Loop
            bne.b   .InitError
            movea.l A0,A1
.SegLoop:
            move.b  (A0)+,D0
            beq.b   .LoadDone
            move.w  (A0)+,(A2)
.LoadLoop:
            move.b  (A0)+,(A3)
            subq.b  #1,D0
            bne.b   .LoadLoop
            move.b  (A1)+,D0
            move.w  (A1)+,(A2)
.CheckCodeLoop:
            move.b  (A3),D1
            cmp.b   (A1)+,D1
            bne.b   .InitError
            subq.b  #1,D0
            bne.b   .CheckCodeLoop
            bra.b   .SegLoop
.LoadDone:
            move.w  #$31F,(A2)
            clr.b   (A3)
            movea.l (A4),A1
            move.b  #$36,(A1)
            moveq   #-1,D0
.AliveWaitLoop:
            move.w  #$31F,(A2)
            cmpi.b  #$FF,(A3)
            dbeq    D0,.AliveWaitLoop
            beq.b   .Alive
.InitError:
            move    (SP)+,SR
            bra.w   .paramError
.Alive:
            move.w  #$200,(A2)
            addq.l  #8,A4
            move.b  (A3),(A4)+
            move.w  #$300,(A2)
            move.b  (A3),(A4)
            suba.w  #$11,A4
            move.l  A4,([IOPMgrVars.w],D3.w*4)
            lea     ($14,A4),A0
            lea     (6,A0),A1
            move.b  D3,(A1)+
            move.b  #2,(A1)+
            move.l  #$10C0C00,(A1)+
            lea     ($2C,A4),A2
            move.l  A2,(A1)+
            move.l  A2,(A1)+
            lea     MOVEREQHANDLER,A2
            move.l  A2,(A1)+
            _IOPMsgRequest
            move    (SP)+,SR
            bra.w   .Done
IOPMsgRequest:
            movem.l D3-D4/A2-A3,-(SP)
            moveq   #-$32,D0
            moveq   #0,D2
            lea     (6,A0),A1
            move.b  (A1)+,D2
            cmpi.w  #7,D2
            bhi.b   .L3
            movea.l IOPMgrVars,A2
            movea.l (0,A2,D2.w*4),A2
            move.l  A2,D3
            beq.b   .L2
            move.b  ($10,A2),D3
            move.b  (A1)+,D2
            beq.b   .CheckReqKind
            move.b  ($11,A2),D3
.CheckReqKind:
            cmpi.w  #3,D2
            bhi.b   .L3
            move.w  .JumpTable(PC,D2.w*2),D1
            move.b  (A1)+,D2
.L2:
            beq.b   .paramError
            cmp.b   D3,D2
.L3:
            bhi.b   .paramError
            move.w  D2,D3
            lsl.w   #4,D2
            moveq   #$20,D4
            cmp.b   (A1)+,D4
            bcs.b   .paramError
            cmp.b   (A1)+,D4
            bcs.b   .paramError
            lea     ($28,A2,D2.w),A3
            jmp     .JumpTable(PC,D1.w)
.JumpTable:
            dc.w    .SendXmtMessage-.JumpTable
            dc.w    .SendRcvReply-.JumpTable
            dc.w    .WaitRcvMessage-.JumpTable
            dc.w    .RemoveRcvWaiter-.JumpTable
.SendXmtMessage:
            st      (A1)
            dc.w    $43EB,$0006,$40C2
            dc.w    $007C,$0700,$B1E9,$0002,$670A,$4EBA,$4ADC,$B1E9
            dc.w    $0002,$6640,$46C2,$7000,$1028,$0009,$2268,$000C
            dc.w    $1F3C,$0001,$0043,$0200
.SendAndInterrupt:
            move.w  D3,-(SP)
            lsl.b   #5,D3
            move.l  (8,A2),-(SP)
            movea.l (4,A2),A3
            movea.l (A2),A2
            move.w  (A2),-(SP)
            move.w  D3,(A2)
            bsr.w   CopyToIop
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            move.w  (SP)+,(A2)
            move.b  (SP)+,(A3)
            move.w  D0,(A2)
            move.b  #$E,(A1)
.success:
            moveq   #0,D0
.paramError:
            movem.l (SP)+,D3-D4/A2-A3
            rts
.notAtHead:
            move    D2,SR
            bra.b   .success
.SendRcvReply:
            cmpa.l  (A3),A0
            bne.b   .paramError
            tst.b   (A1)
            bne.b   .paramError
            st      (A1)
            moveq   #0,D0
            move.b  ($A,A0),D0
            movea.l ($10,A0),A1
            move.b  #3,-(SP)
            ori.w   #$300,D3
            bra.b   .SendAndInterrupt
.WaitRcvMessage:
            tst.l   (A3)
            bne.b   .paramError
            st      (A1)
            move.l  A0,(A3)
            bra.b   .success
.RemoveRcvWaiter:
            cmpa.l  (A3),A0
            bne.b   .paramError
            clr.b   (A1)
            clr.l   (A3)
            bra.b   .success
IOPMOVEDATA:
            movem.l A2-A3,-(SP)
            moveq   #-$32,D0
            moveq   #0,D2
            move.b  (A0)+,D2
            cmpi.w  #3,D2
            bhi.b   .L1
            move.w  .L2(PC,D2.w*2),D1
            move.b  (A0)+,D2
            cmpi.w  #7,D2
            bhi.b   .L1
            movea.l IOPMgrVars,A1
            movea.l (0,A1,D2.w*4),A2
            move.l  A2,D2
            beq.b   .L1
            movea.l (4,A2),A3
            movea.l (A2),A2
            moveq   #0,D0
            move.w  (A0)+,D0
            movea.l (A0)+,A1
            move.w  (A2),-(SP)
            move.w  (A0)+,(A2)
            jsr     .L2(PC,D1.w)
            move.w  (SP)+,(A2)
            moveq   #0,D0
.L1:
            movem.l (SP)+,A2-A3
            rts
.L2:
            dc.w    $0034,$0088,$00DC,$0008,$40C2,$007C,$0700,$323C
            dc.w    $021F,$3481,$7001,$1680,$3481,$B013,$67FA,$1019
            dc.w    $670A,$3499,$1699,$5300,$66FA,$60F2,$3481,$4213
            dc.w    $46C2,$4E75
CopyFromIop:
            cmpi.w  #3,D0
            bls.b   .L6
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .L1
            subq.w  #4,D1
            add.w   D1,D0
            jmp     .L1(PC,D1.w*2)
            move.b  (A3),(A1)+
            move.b  (A3),(A1)+
            move.b  (A3),(A1)+
.L1:
            ror.l   #2,D0
            moveq   #7,D1
            and.w   D0,D1
            neg.w   D1
            lsr.w   #3,D0
            jmp     .L3(PC,D1.w*2)
.L2:
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
            move.l  (A3),(A1)+
.L3:
            dbra    D0,.L2
            add.l   D0,D0
            bcs.b   .L7
.L4:
            bpl.b   .L5
            move.b  (A3),(A1)
.L5:
            rts
.L6:
            roxr.l  #2,D0
            bcc.b   .L4
.L7:
            bpl.b   .L8
            move.b  (A3),(A1)+
.L8:
            move.w  (A3),(A1)
            rts
CopyToIop:
            cmpi.w  #3,D0
            bls.b   .L6
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .Aligned
            subq.w  #4,D1
            add.w   D1,D0
            jmp     .Aligned(PC,D1.w*2)
            move.b  (A1)+,(A3)
            move.b  (A1)+,(A3)
            move.b  (A1)+,(A3)
.Aligned:
            ror.l   #2,D0
            moveq   #7,D1
            and.w   D0,D1
            neg.w   D1
            lsr.w   #3,D0
            jmp     .L3(PC,D1.w*2)
.L2:
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
            move.l  (A1)+,(A3)
.L3:
            dbra    D0,.L2
            add.l   D0,D0
            bcs.b   .L7
.L4:
            bpl.b   .L5
            move.b  (A1),(A3)
.L5:
            rts
.L6:
            roxr.l  #2,D0
            bcc.b   .L4
.L7:
            bpl.b   .L8
            move.b  (A1)+,(A3)
.L8:
            move.w  (A1),(A3)
            rts
            cmpi.w  #3,D0
            bls.b   .L10
            move.l  A1,D1
            andi.w  #3,D1
            beq.b   .L10
            subq.w  #4,D1
            add.w   D1,D0
            not.w   D1
.L9:
            move.b  (A3),D2
            cmp.b   (A1)+,D2
            dbne    D1,.L9
            bne.b   .L14
.L10:
            moveq   #3,D1
            and.w   D0,D1
            lsr.w   #2,D0
            beq.b   .L13
            subq.w  #1,D0
.L11:
            move.l  (A3),D2
            cmp.l   (A1)+,D2
            dbne    D0,.L11
            bra.b   .L13
.L12:
            move.b  (A3),D2
            cmp.b   (A1)+,D2
.L13:
            dbne    D1,.L12
.L14:
            sne     (A0)
            bls.b   .L15
            neg.b   (A0)
.L15:
            rts
IOPINTERRUPT:
            movea.l IOPMgrVars,A0
            jmp     ([-4.w,A0])
vIOPInterrupt:
            move.l  (0,A0,D0.w*4),D1
            beq.b   .noIop
            movea.l D1,A0
            movea.l (A0)+,A2
            movea.l (A0)+,A3
            move    SR,D2
            move.b  D0,D2
            move.l  A0,-(SP)
.checkAgain:
            movea.l (A0)+,A1
            move.b  (A1),D1
            lsr.b   #5,D1
            bcs.b   .xmtComp
            lsr.b   #1,D1
            bcs.b   .rcvNew
            lsr.b   #1,D1
            bcs.b   .bypassInt
.IntHandled:
            move    D2,SR
            addq.l  #4,SP
            lsr.l   #8,D0
            bne.w   .RunNonDeferrable
            rts
.noIop:
            cmpi.w  #0,D0
            beq.w   SCCIOPBYPASSINT
            rts
.bypassInt:
            move.l  (A0),D1
            beq.b   .IntHandled
            move    D2,SR
            move.l  D0,(SP)
            movea.l D1,A0
            jsr     (A0)
            move.l  (SP)+,D0
            bra.b   IOPINTERRUPT
.rcvNew:
            move.b  #$26,(A1)
            move.w  #$201,D1
            move.w  #$301,D3
            lea     .RcvFound,A1
            move.b  (5,A0),D0
            lea     ($1C,A0),A0
            move.w  (A2),-(SP)
            bra.b   .SearchStart
.xmtComp:
            move.b  #$16,(A1)
            moveq   #3,D1
            move.w  #$201,D3
            lea     .xmtFound,A1
            move.b  (4,A0),D0
            lea     ($1C,A0),A0
            move.w  (A2),-(SP)
            bra.b   .SearchStart
.L7:
            lea     ($10,A0),A0
            cmp.b   (A3),D1
            dbeq    D0,.L7
            bne.b   .searchDone
            move.w  (A2),D3
            movem.l D0-D3/A0-A1,-(SP)
            subq.w  #1,D3
            move.w  D3,(A2)
            lsr.w   #8,D1
            move.b  D1,(A3)
            move    D2,SR
            jsr     (A1)
            movem.l (SP)+,D0-D3/A0-A1
.SearchStart:
            ori     #$700,SR
            move.w  D3,(A2)
            dbra    D0,.L7
.searchDone:
            move.w  (SP)+,(A2)
            clr.w   D0
            move.b  D2,D0
            movea.l IOPMgrVars,A1
            tst.b   (-$F,A1)
            bne.b   .toCkAgain
            tst.l   (-$C,A1)
            beq.b   .toCkAgain
            st      (-$F,A1)
            lea     (-$24,A1),A0
            movem.l D0/D2/A2,-(SP)
            jsr     ([JDTInstall.w])
            movem.l (SP)+,D0/D2/A2
.toCkAgain:
            move    D2,SR
            movea.l (SP),A0
            bra.w   .checkAgain
.xmtFound:
            lea     (8,A0),A1
            move.l  (A1),D1
            beq.b   .empty
            move.l  A1,-(SP)
            movea.l D1,A0
            subq.l  #2,A1
            jsr     (DequeueTrap.w,PC)
            movea.l ($10,A0),A1
            moveq   #0,D0
            move.b  ($A,A0),D0
            bsr.b   .CopyAndQueue
            movea.l (SP)+,A1
            move.l  (A1),D1
            beq.b   .empty
            movea.l D1,A0
            jmp     ([$61C.w])
.empty:
            rts
.RcvFound:
            move.l  (A0),D1
            beq.b   .empty
            movea.l D1,A0
            movea.l ($C,A0),A1
            moveq   #0,D0
            move.b  (9,A0),D0
.CopyAndQueue:
            beq.b   .CopyDone
            move.w  D3,D1
            lsl.b   #5,D1
            move.w  D1,(A2)
            bsr.w   CopyFromIop
.CopyDone:
            movea.l IOPMgrVars,A1
            lea     (-$E,A1),A1
            tst.l   ($14,A0)
            beq.b   .NoHandler
            jmp     (QStuff.w,PC)
.NoHandler:
            clr.b   ($B,A0)
            rts
.RunNonDeferrable:
            move.l  D0,D3
            lsr.l   #8,D3
            movea.l IOPMgrVars,A1
            lea     (-$E,A1),A1
            lea     (2,A1),A0
            ori     #$700,SR
.RunLoop:
            move.l  (A0),D0
            beq.b   .RunDone
            movea.l D0,A0
            cmp.b   (6,A0),D2
            bne.b   .RunLoop
            move.b  (8,A0),D0
            tst.b   (7,A0)
            bne.b   .ChkMsgNum
            addq.b  #8,D0
.ChkMsgNum:
            btst    D0,D3
            beq.b   .RunLoop
            jsr     (DequeueTrap.w,PC)
            move.l  A0,-(SP)
            bsr.b   .RunLoop
            movea.l (SP)+,A0
            clr.b   ($B,A0)
            move.l  ($14,A0),D0
            beq.b   .RunRTS
            movea.l D0,A1
            jmp     (A1)
.RunDone:
            move    D2,SR
.RunRTS:
            rts
CallCompHandler:
            move    (SP)+,SR
            movea.l D0,A0
            jsr     (DequeueTrap.w,PC)
            clr.b   ($B,A0)
            move.l  ($14,A0),D0
            beq.b   IOPDefTask
            move.l  A1,-(SP)
            movea.l D0,A1
            jsr     (A1)
            movea.l (SP)+,A1
IOPDefTask:
            move    SR,-(SP)
            ori     #$700,SR
            move.l  (2,A1),D0
            bne.b   CallCompHandler
            clr.b   -(A1)
            move    (SP)+,SR
            rts
MOVEREQHANDLER:
            movea.l A0,A2
            movea.l ($C,A0),A0
            move.b  (6,A2),(1,A0)
            jsr     ([$620.w])
            movea.l A2,A0
            move.b  #1,(7,A0)
            jmp     ([$61C.w])
INITIOPMGR:
            movem.l D0/A0-A3,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D0
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .noSCCIOP
            addi.w  #$A8,D0
.noSCCIOP:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .noSWIMIOP
            addi.w  #$A8,D0
.noSWIMIOP:
            tst.w   D0
            beq.b   .noIOPs
            addi.w  #$44,D0
            _NewPtrSysClear
            lea     ($24,A0),A2
            move.l  A2,IOPMgrVars
            move.w  #7,(-$20,A2)
            lea     IOPDefTask,A0
            move.l  A0,(-$1C,A2)
            lea     (-$E,A2),A0
            move.l  A0,(-$18,A2)
            lea     vIOPInterrupt,A0
            move.l  A0,(-4,A2)
            lea     ($20,A2),A2
            btst    #1,($DD1).w                     ; TestFor SCCIOPExists
            beq.b   .SCCIOPdone
            moveq   #0,D0
            movea.l SCCRd,A1
            lea     (SCCIOPBYPASSINT.w,PC),A3
            bsr.b   .InstallIOP
.SCCIOPdone:
            btst    #0,($DD1).w                     ; TestFor SWIMIOPExists
            beq.b   .SWIMIOPdone
            moveq   #1,D0
            movea.l IWM,A1
            suba.l  A3,A3
            bsr.b   .InstallIOP
.SWIMIOPdone:
.Done
            move    (SP)+,SR
            movem.l (SP)+,D0/A0-A3
            rts
.noIOPs:
            lea     .traps,A1
            move.w  (A1)+,D0
            _GetToolBoxTrapAddress
.trapLoop:
            move.w  (A1)+,D0
            beq.b   .SWIMIOPdone
            _SetOSTrapAddress
            bra.b   .trapLoop
.traps:
            dc.w    $A89F,$A086,$A087,$A088,0
.InstallIOP:
            movea.l A2,A0
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            lea     (-$1F,A1),A1
            move.l  A1,(A0)+
            addq.w  #7,A1
            move.l  A1,(A0)+
            subq.w  #4,A1
            move.l  A1,(A0)+
            move.l  A3,(A0)+
            movea.l SP,A0
            _IOPInfoAccess
            addq.l  #8,SP
            lea     ($A8,A2),A2
            rts
SCCIOPByPass:
            movem.l D0/A0-A2,-(SP)
            move.l  #$10089,D0
            clr.b   -(SP)
            movea.l SP,A0
            _ReadXPRam
            bsr.b   sub_40805364
            and.b   (SP)+,D0
            bne.b   .Done
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (4,SP)
            pea     .ByPassMsg
            move.l  #$10301FF,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            movea.l SP,A0
            _IOPMsgRequest
            bne.b   .FlagBypass
.Sync_Loop:
            tst.b   ($B,SP)
            bne.b   .Sync_Loop
.FlagBypass:
            lea     ($1C,SP),SP
            bsr.b   sub_4080536E
.Done:
            movem.l (SP)+,D0/A0-A2
            rts
.ByPassMsg:
            dc.w    $0400,$FF00
SCCIOPHwInit:
            movea.l SCCRd,A1
            move.b  #$32,(-$1C,A1)
            lea     .L3,A0
            move.w  (A0)+,D0
            move.w  (A0)+,(-$1F,A1)
.L1:
            move.b  (A0)+,(-$18,A1)
            dbra    D0,.L1
            move.b  #$36,(-$1C,A1)
            lsr.w   #6,D0
.L2:
            dbra    D0,.L2
            rts
.L3:
            dc.w    $0011,$7FEE,$A981,$8D30,$F0A9,$238D,$31F0,$80FE
            dc.w    $EE7F,$EE7F,$EE7F
sub_40805364:
            move.b  (4,SP),($BFE).w
            moveq   #1,D0
            rts
sub_4080536E:
            beq.b   .L1
            bset    #0,($BFE).w
.L1:
            rts
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.b    'GaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGaryGary'
            dc.w    $4761,$7279

            EVEN
