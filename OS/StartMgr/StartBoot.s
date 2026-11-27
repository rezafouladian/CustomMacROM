            include "Include/ROMHeader.s"

            EXPORT  InitEvents,MyBoot,CenterRect

            IMPORT  InitADBDrvr,AddVidDevice,CLOSENETBOOTPATCH,OpensDrvr,EraseMyIcon,FindStartupDevice

            SECTION "StartBoot",CODE

MyBoot:
BootMe:
            bsr.w   FindStartupDevice
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  A0,ApplZone
            move.l  (A0),HeapEnd
            move.b  (6,A6),D1
            cmpi.b  #$44,D1
            beq.b   .L1
            andi.b  #$C0,D1
            cmpi.b  #$C0,D1
            bne.b   .L2
.L1:
            jsr     (2,A6)
.L2:
            move.w  ($7C,A6),D0
            _InitEvents
            move.w  ($7A,A6),D0
            _InitFS
            lea     (-$400,A6),A0
            move.w  BootDrive,($16,A0)
            _MountVol
            bne.w   .L27
            clr.l   ($12,A0)
            clr.w   ($1C,A0)
            _HGetVInfo
            bne.b   .L3
            movea.l ($5E,A0),A4
            move.l  ($5A,A0),D0
            bsr.w   sub_40802142
.L3:
            lea     SysResName,A1
            lea     ($A,A6),A0
            moveq   #$10,D0
            _BlockMove
            subq.w  #2,SP
            clr.l   ResErrProc
            _InitResources
            tst.w   (SP)+
            bpl.b   .L4
            lea     (-$400,A6),A0
            clr.l   ($12,A0)
            _UnmountVol
            jmp     .L27
.L4:
            moveq   #0,D0
            bsr.w   sub_408020AC
            move.l  D0,D5
            bne.b   .L5
            moveq   #0,D7
            bra.b   .L6
.L5:
            movea.l D5,A0
            move.l  (A0),DSAlertTab
.L6:
            _InitFonts
            subq.w  #2,SP
            pea     ($4A,A6)
            _OpenResFile
            move.w  (SP)+,D3
            cmpi.w  #$FFFF,D3
            beq.b   .L9
            subq.w  #4,SP
            clr.w   -(SP)
            _GetPicture
            move.l  (SP)+,D0
            beq.b   .L8
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            movea.l (A0),A0
            move.l  (6,A0),-(SP)
            move.l  (2,A0),-(SP)
            lea     (-$1FE,A6),A0
            tst.w   (4,A0)
            bpl.b   .L7
            movea.l (A0),A0
            movea.l (A0),A0
.L7:
            pea     (6,A0)
            pea     (4,SP)
            bsr.w   CenterRect
            bsr.w   EraseMyIcon
            move.l  A2,-(SP)
            pea     (4,SP)
            _DrawPicture
            addq.w  #8,SP
            moveq   #0,D7
.L8:
            move.w  D3,-(SP)
            _CloseResFile
            tst.b   D7
            beq.b   .L11
.L9:
            lea     ($4A,A6),A1
            moveq   #1,D3
            bsr.w   sub_408020D2
            sne     D7
            bne.b   .L11
            lea     (-$1FE,A6),A2
            tst.w   (4,A2)
            bpl.b   .L10
            movea.l (A2),A2
            movea.l (A2),A2
.L10:
            move.l  #$1560200,-(SP)
            clr.l   -(SP)
            pea     (6,A2)
            pea     (4,SP)
            bsr.w   CenterRect
            move.w  #$40,-(SP)
            pea     ($800,A6)
            move.l  SP,-(SP)
            move.l  A2,-(SP)
            pea     ($E,SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            _CopyBits
            lea     ($E,SP),SP
.L11:
            tst.b   D7
            beq.b   .L12
            bsr.w   EraseMyIcon
.L12:
            moveq   #$28,D0
            bsr.w   sub_408020A4
            subi.l  #$400,BufPtr
            lea     ($2A,A6),A1
            bsr.w   sub_408020D0
            beq.b   .L13
            addi.l  #$400,BufPtr
            bra.b   .L14
.L13:
            jsr     (A1)
            moveq   #-$A,D0
            bsr.w   sub_408020A4
            lea     ($3A,A6),A1
            bsr.w   sub_408020D0
            bne.b   .L14
            jsr     (A1)
            moveq   #-$B,D0
            bsr.w   sub_408020A4
.L14:
            lea     SysResName,A1
            moveq   #-1,D3
            bsr.w   sub_408020D2
            bne.b   .L15
            jsr     (A1)
.L15:
            suba.w  #$38,SP
            movea.l SP,A0
            _sSecondaryInit
            lea     ($38,SP),SP
            BigJsr  InitADBDrvr,A0
            bsr.w   MouseInit
            bsr.w   OpenSlots
            moveq   #2,D0
            bsr.w   sub_408020AC
            beq.b   .L16
            movea.l D0,A0
            move.l  (A0),DSAlertTab
            move.l  A0,-(SP)
            _DetachResource
.L16:
            move.l  D5,-(SP)
            _ReleaseResource
            moveq   #$C,D0
            _NewHandleClear async
            move.l  A0,($AEC).w
            lea     (-$400,A6),A0
            move.w  #$FFFB,($18,A0)
            move.w  #9,($1A,A0)
            move.w  #$FF01,($1C,A0)
            _Control
            _InitApplZone
            _RDrvrInstall
            moveq   #0,D6
.L17:
            movem.l A5-A6,($B36).w
            _FreeMem sys
            subi.l  #$4000,D0
            neg.l   D0
            ble.b   .L18
            addi.l  #$3FF,D0
            andi.w  #$FC00,D0
            movea.l SysZone,A0
            movea.l (A0),A0
            adda.l  D0,A0
            _SetAppBase
            _InitApplZone
.L18:
            moveq   #0,D5
.L19:
            not.b   D5
            beq.b   .L20
            move.b  D5,ROMMapInsert
            move.b  ResLoad,($B9F).w
            subq.w  #4,SP
            move.l  #'INIT',-(SP)
            move.w  D6,-(SP)
            _GetResource
            move.l  (SP)+,D7
            beq.b   .L19
            move.l  D7,-(SP)
            _DetachResource
            movea.l D7,A0
            movea.l (A0),A0
            jsr     (A0)
.L20:
            movem.l ($B36).w,A5-A6
            addq.w  #1,D6
            cmpi.w  #$24,D6
            blt.b   .L17
            pea     (-$200,A6)
            _CloseCPort
            moveq   #$40,D0
            swap    D0
            _PurgeMem sys
            movea.l SysZone,A0
            move.l  #$18000,D0
            move.w  (6,A6),D1
            cmpi.w  #$14,D1
            bls.b   .L21
            move.l  ($86,A6),D0
            btst    #$F,D1
            beq.b   .L21
            btst    #$D,D1
            beq.b   .L21
            subq.w  #4,SP
            move.l  BufPtr,-(SP)
            move.l  ($90,A6),-(SP)
            dc.w    $A84A                           ; A-trap $A84A
            move.l  (SP)+,D0
            add.l   ($8C,A6),D0
            movea.l SysZone,A0
            movea.l (A0),A0
.L21:
            adda.l  D0,A0
            _FreeMem sys
            subi.l  #$4000,D0
            neg.l   D0
            bpl.b   .L22
            moveq   #0,D0
.L22:
            movea.l SysZone,A1
            add.l   (A1),D0
            cmpa.l  D0,A0
            bcc.b   .L23
            movea.l D0,A0
.L23:
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L24
            movea.l A1,A0
.L24:
            _SetAppBase
            _InitApplZone
            movea.l PortList,A0
            moveq   #2,D0
            _SetHandleSize
            movea.l (A0),A0
            clr.w   (A0)
            lea     ($6A,A6),A0
            lea     ScrapTag,A1
            move.l  A1,ScrapName
            moveq   #$10,D0
            _BlockMove
            lea     ($1A,A6),A0
            lea     ($2E0).w,A1
            moveq   #$10,D0
            _BlockMove
            clr.w   CurApRefNum
            lea     (-$400,A6),A0
            clr.l   ($12,A0)
            _GetVol
            move.w  ($16,A0),BootDrive
            move.l  A4,D0
            bsr.w   sub_40802142
            lea     ($5A,A6),A3
            bsr.w   sub_408020BC
            beq.b   .L25
            lea     ($1A,A6),A3
            bsr.w   sub_408020BC
            bne.b   .L26
.L25:
            clr.w   -(SP)
            clr.l   -(SP)
            move.l  A3,-(SP)
            movea.l SP,A0
            _Launch
.L26:
            moveq   #$29,D0
            _SysError
            _Debugger
.L27:
            move.w  BootDrive,D3
            move.w  BtDskRfn,D1
            bsr.b   getDiskInPlace
            cmpi.b  #8,D0
            beq.b   .L28
            move.b  D0,-(SP)
            lea     (-$400,A6),A0
            move.w  BtDskRfn,($18,A0)
            move.w  #7,($1A,A0)
            move.w  D3,($16,A0)
            _Control
            bne.b   .L28
            move.b  (SP)+,D0
            cmpi.b  #8,D0
            bge.w   .L28
            cmpi.w  #$FFFE,BtDskRfn
            bne.b   .L29
.L28:
            move.w  BootMask,D0
            bclr    D3,D0
            move.w  D0,BootMask
.L29:
            bra.w   CLOSENETBOOTPATCH
getDiskInPlace:
            lea     ($30A).w,A0
.L1:
            move.l  (A0),D0
            beq.b   .L2
            movea.l D0,A0
            cmp.w   (6,A0),D3
            bne.b   .L1
            cmp.w   (8,A0),D1
            bne.b   .L1
            move.b  (-3,A0),D0
.L2:
            rts
sub_408020A4:
            tst.b   D7
            beq.b   .L1
            _SysError
.L1:
            rts
sub_408020AC:
            clr.l   -(SP)
            move.l  #'DSAT',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            rts
sub_408020BC:
            lea     (-$400,A6),A0
            clr.w   ($16,A0)
            clr.l   ($1A,A0)
            move.l  A3,($12,A0)
            _GetFileInfo
            rts
sub_408020D0:
            moveq   #0,D3
sub_408020D2:
            lea     (-$400,A6),A0
            moveq   #-1,D2
            lea     ($12,A0),A2
            move.l  A1,(A2)+
            clr.l   (A2)+
            clr.b   (A2)+
            move.b  #1,(A2)+
            pea     ($400,A6)
            move.l  (SP)+,(A2)
            _Open
            bne.b   .L3
            _GetEOF
            bne.b   .L2
            move.l  (A2)+,D4
            moveq   #$40,D6
            asl.w   #3,D6
            sub.l   D6,D4
            tst.w   D3
            bmi.b   .L5
            bne.b   .L4
            movea.l BufPtr,A1
            suba.l  D4,A1
.L1:
            lea     (-$400,A6),A0
            lea     ($20,A0),A2
            move.l  A1,(A2)+
            move.l  D4,(A2)+
            addq.w  #4,A2
            move.w  #1,(A2)+
            move.l  D6,(A2)
            _Read
            bne.b   .L2
            moveq   #0,D2
.L2:
            lea     (-$400,A6),A0
            _Close
.L3:
            move.w  D2,D0
            rts
.L4:
            lea     ($800,A6),A1
            add.l   D6,D4
            moveq   #0,D6
            bra.b   .L1
.L5:
            move.l  D4,D0
            _NewPtrSys
            move.w  D0,D2
            bne.b   .L2
            movea.l A0,A1
            bra.b   .L1
sub_40802142:
            tst.l   D0
            beq.b   .L1
            lea     (-$400,A6),A0
            move.l  D0,($30,A0)
            clr.l   ($12,A0)
            move.l  #'ERIK',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            bne.b   .L1
            _SetVol
.L1:
            rts
            ds.b    12
CenterRect:
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            bsr.b   sub_4080217E
            bsr.b   sub_4080217E
            movea.l D2,A0
            jmp     (A0)
sub_4080217E:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (4,A1),D1
            sub.w   (A1),D1
            sub.w   D1,D0
            asr.w   #1,D0
            add.w   (A0)+,D0
            move.w  D0,(A1)+
            add.w   D1,D0
            move.w  D0,(2,A1)
            rts
            ds.b    6
MouseInit:
            moveq   #$78,D0
            and.b   SPVolCtl,D0
            lsr.b   #3,D0
            cmpi.b  #4,D0
            ble.b   .L1
            andi.b  #$57,SPVolCtl
            ori.b   #$10,SPVolCtl
            moveq   #2,D0
.L1:
            subq.w  #4,SP
            move.l  #'mcky',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            movea.l MickeyBytes,A1
            lea     ($14,A1),A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
.L2:
            rts
            dc.w    0
OpenBDrvrs:
            move.b  ($31,A0),-(SP)
            move.b  ($32,A0),-(SP)
            movem.l D0-D3/A0-A1,-(SP)
            suba.w  #$18,SP
            movea.l SP,A1
            move.l  A1,($14,A0)
            move.l  A0,D3
            subq.l  #2,SP
            movea.l SP,A0
            _GetOSDefault
            move.w  (SP)+,D2
            movea.l D3,A0
            move.b  ($31,A0),(A1)
            move.b  ($32,A0),(1,A1)
            clr.b   ($11,A1)
            clr.b   ($10,A1)
            move.b  D2,($12,A1)
            lsr.l   #8,D2
            move.b  D2,($13,A1)
            move.b  #1,($16,A1)
            move.b  #6,($32,A0)
            _sExec
            lea     ($18,SP),SP
            movem.l (SP)+,D0-D3/A0-A1
            move.b  (SP)+,($32,A0)
            move.b  (SP)+,($31,A0)
            rts
OpenSlots:
            movem.l D0-D4/A0-A1,-(SP)
            suba.w  #$32,SP
            movea.l SP,A1
            clr.b   ($1B,A1)
            suba.w  #$38,SP
            movea.l SP,A0
            clr.b   ($31,A0)
            clr.b   ($33,A0)
            clr.b   D3
.Repeat:
            move.b  D3,($32,A0)
            _sNextsRsrc
            bne.b   .L4
            move.b  ($32,A0),D3
            move.l  (4,A0),D4
            move.b  #7,($32,A0)
            _sReadWord
            bne.b   .L2
            move.w  (2,A0),D0
            btst    #1,D0
            beq.b   .Repeat
.L2:
            move.b  #6,($32,A0)
            _sFindStruct
            bne.b   .L3
            move.b  D3,($32,A0)
            move.l  D4,(4,A0)
            bsr.w   OpenBDrvrs
            bra.b   .Repeat
.L3:
            move.b  D3,($32,A0)
            bsr.w   OpensDrvr
            bne.b   .Repeat
            cmpi.l  #$30001,($28,A0)
            bne.b   .Repeat
            cmpi.w  #1,($2C,A0)
            bne.b   .Repeat
            bsr.w   AddVidDevice
            bra.b   .Repeat
.L4:
            lea     ($6A,SP),SP
            movea.l DeviceList,A0
            movea.l (A0),A0
            bclr    #$C,($14,A0)
            movem.l (SP)+,D0-D4/A0-A1
            rts
            ds.b    8
InitEvents:
            move.w  D0,D2
            moveq   #$16,D0
            mulu.w  D2,D0
            move.l  D0,D1
            _NewPtrSysClear
            lea     EvtBufCnt,A1
            subq.w  #1,D2
            move.w  D2,(A1)
            clr.l   -(A1)
            clr.l   -(A1)
            clr.w   -(A1)
            move.l  A0,-(A1)
.L1:
            not.w   (A0)+
            subq.w  #2,D1
            bne.b   .L1
            move.w  #$FFEF,-(A1)
            clr.w   KeyLast
            rts
            ds.b    6

            EVEN
