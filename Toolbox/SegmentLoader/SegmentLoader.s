            include "Include/ROMHeader.s"

            EXPORT  Chain,ExitToShell,GetAppParms,InstallRDrivers,Launch,Loader
            EXPORT  UnloadSeg,vLaunchInit,vSegStack,AppZoneAddr,FlushApplVBLs

            IMPORT  LoadSegPatch,UnloadSegPatch

            SECTION "SegmentLoader",CODE

Loader:
LoadSeg:
            movem.l D0-D2/A0-A1,-(SP)
            bra.b   .L1
            ds.b    6
.L1:
            move.w  ($18,SP),D0
            bsr.b   LoadCode
            beq.b   .L6
            _HGetState
            btst    #7,D0
            bne.b   .L3
            tst.b   SegHiEnable
            beq.b   .L2
            _MoveHHi
.L2:
            _HLock
.L3:
            move.l  (A0),D0
            _StripAddress
            movea.l D0,A0
            movea.l A5,A1
            adda.w  CurJTOffset,A1
            adda.w  (A0),A1
            cmpi.w  #$4EF9,(2,A1)
            beq.b   .L4
            move.w  (2,A0),D0
            beq.b   .L4
            move.w  ($18,SP),D1
            moveq   #0,D2
            bsr.l   LoadSegPatch
            bra.b   .L4
            ds.b    12
.L4:
            movea.l ($14,SP),A1
            subq.l  #6,A1
            move.l  A1,($16,SP)
            movem.l (SP)+,D0-D2/A0-A1
            addq.w  #2,SP
            tst.b   LoadTrap
            beq.b   .L5
            _Debugger
.L5:
            rts
.L6:
            moveq   #$F,D0
            _SysError
            _Debugger
LoadCode:
            st      ResLoad
            subq.w  #4,SP
            move.l  #'CODE',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,D0
            rts
UnloadSeg:
            bra.l   UnloadSegPatch
            ds.b    66
AppZoneAddr:
            _StripAddress
            move.l  ApplZone,-(SP)
            move.l  SysZone,-(SP)
            cmpm.l  (SP)+,(SP)+
            beq.b   .L1
            cmp.l   ApplZone,D0
            bcs.b   .L1
            cmp.l   BufPtr,D0
            bcc.b   .L1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
FlushApplVBLs:
            movea.l ($162).w,A1
.L1:
            move.l  A1,D0
            beq.b   .L2
            movea.l A1,A0
            movea.l (A0),A1
            move.l  (6,A0),D0
            bsr.b   AppZoneAddr
            bne.b   .L1
            _VRemove
            bra.b   .L1
.L2:
            rts
.L3:
            move.l  MemTop,D0
            subi.l  #$5F00,D0
            bra.w   Launch.L9
Chain:
            clr.w   LaunchFlag
            bra.b   Launch.L3
Launch:
            st      LaunchFlag
            movem.l D0-D1/A0-A1,-(SP)
            suba.w  #$32,SP
            move.w  #$FFFF,($1A,SP)
            movea.l UTableBase,A1
            move.w  UnitNtryCnt,D1
.L1:
            move.l  (A1)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            btst    #4,(4,A0)
            beq.b   .L2
            move.w  ($18,A0),($18,SP)
            movea.l SP,A0
            _Control
.L2:
            subq.w  #1,D1
            bne.b   .L1
            lea     ($32,SP),SP
            movem.l (SP)+,D0-D1/A0-A1
.L3:
            movea.l A0,A3
            movea.l (A3)+,A0
            move.w  (A3)+,CurPageOption
            lea     ($910).w,A1
            moveq   #$20,D0
            _BlockMove
            moveq   #0,D3
            cmpi.w  #$4C43,(A3)+
            bne.b   .L4
            addq.w  #4,A3
            move.w  (A3)+,D3
.L4:
            move.w  CurApRefNum,D0
            ble.b   .L5
            move.w  D0,-(SP)
            _CloseResFile
            clr.w   CurApRefNum
.L5:
            movea.l BufPtr,SP
            clr.l   StkLowPt
            tst.w   LaunchFlag
            beq.b   .L7
            move.l  ScrapHandle,D0
            ble.b   .L6
            movea.l D0,A0
            _GetHandleSize
            addq.l  #1,D0
            bclr    #0,D0
            suba.l  D0,SP
            movea.l SP,A1
            movea.l (A0),A0
            move.l  D0,-(SP)
            _BlockMove
.L6:
            _InitApplZone
            tst.l   ScrapHandle
            ble.b   .L7
            move.l  (SP)+,D1
            move.l  D1,D0
            _NewHandle
            move.l  A0,ScrapHandle
            move.l  D1,D0
            movea.l (A0),A1
            movea.l SP,A0
            _BlockMove
            adda.l  D1,SP
.L7:
            subq.w  #2,SP
            pea     ($910).w
            moveq   #0,D0
            btst    #6,D3
            beq.b   .L8
            moveq   #1,D0
.L8:
            move.b  D0,RMGRPerm
            _OpenResFile
            move.w  (SP)+,CurApRefNum
            ble.w   BadOpen
            moveq   #0,D0
            bsr.w   LoadCode
            beq.w   BadOpen
            move.l  A0,SaveSegHandle
            movea.l (A0),A0
            tst.w   CurPageOption
            beq.b   .L10
            bpl.w   FlushApplVBLs.L3
            move.l  MemTop,D0
            subi.l  #$D900,D0
.L9:
            cmp.l   SP,D0
            bge.b   .L10
            movea.l D0,SP
.L10:
            movea.l ($7E0).w,A3
            jmp     (A3)
vSegStack:
            suba.l  (A0)+,SP
            move.l  SP,D0
            andi.w  #$FFFC,D0
            movea.l D0,SP
            movea.l SP,A5
            suba.l  (A0)+,SP
            move.l  A5,CurrentA5
            move.l  SP,CurStackBase
            move.l  SP,StkLowPt
            move.l  (A0)+,D0
            movea.l (A0)+,A1
            move.w  A1,CurJTOffset
            adda.l  A5,A1
            lea     (2,A1),A3
            _BlockMove
            move.l  SaveSegHandle,-(SP)
            _ReleaseResource
            lea     (8,A5),A0
            clr.l   (A0)+
            clr.l   (A0)+
            move.l  ($AEC).w,(A0)+
            clr.w   (A0)+
            movea.l SP,A0
            suba.l  DefltStack,A0
            _SetApplLimit
            movea.l ($6F0).w,A0
            jsr     (A0)
            jsr     (A3)
ExitToShell:
            moveq   #$C,D0
            _PaletteDispatch
            suba.l  A0,A0
            _SetGrowZone
            subq.w  #4,SP
            _LoadScrap
            addq.w  #4,SP
            moveq   #$1F,D0
.L1:
            clr.w   -(SP)
            dbra    D0,.L1
            movea.l SP,A0
            move.w  BootDrive,($16,A0)
            _SetVol
            lea     ($40,SP),SP
            lea     LoaderPBlock,A0
            movea.l A0,A1
            pea     ($2E0).w
            move.l  (SP)+,(A1)+
            clr.l   (A1)+
            _Launch
BadOpen:
            moveq   #$1A,D0
            _SysError
            _Debugger
vLaunchInit:
            btst    #$C,HWCfgFlags
            beq.b   .L1
            clr.l   -(SP)
            frestore (SP)+
.L1:
            moveq   #0,D7
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            moveq   #0,D3
            moveq   #0,D2
            moveq   #0,D1
            moveq   #0,D0
            movea.l ROMBase,A2
            adda.l  #$10000,A2
            movea.l A2,A1
            movea.l A2,A0
            move.l  A2,ResetStackPtr
            clr.l   (A5)
            rts
GetAppParms:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  ($10,A5),(A1)
            movea.l (SP)+,A1
            move.w  CurApRefNum,(A1)
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            lea     ($910).w,A0
            moveq   #$20,D0
            _BlockMove
            rts
InstallRDrivers:
            movem.l D0-D4/A0-A3,-(SP)
            movea.l UTableBase,A3
            move.w  UnitNtryCnt,D3
            moveq   #-1,D4
.L1:
            move.l  (A3)+,D0
            beq.b   .L5
            movea.l D0,A1
            move.l  (A1),D0
            beq.b   .L5
            movea.l D0,A1
            btst    #6,(5,A1)
            beq.b   .L5
            move.l  (A1),D0
            beq.b   .L5
            move.l  ($14,A1),D1
            bsr.w   AppZoneAddr
            bne.b   .L3
            moveq   #$33,D0
            movea.l A1,A0
.L2:
            clr.b   (A0)+
            dbra    D0,.L2
            bset    #6,(5,A1)
            move.w  D4,($18,A1)
.L3:
            clr.l   ($1E,A1)
            move.l  D1,D0
            bsr.w   AppZoneAddr
            bne.b   .L4
            moveq   #0,D1
.L4:
            move.l  D1,($14,A1)
.L5:
            subq.w  #1,D4
            subq.w  #1,D3
            bne.b   .L1
            movem.l (SP)+,D0-D4/A0-A3
            rts
SGLDREND:
            dc.w    0

            EVEN
