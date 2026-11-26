            include "Include/ROMHeader.s"

            EXPORT  ElsieTranslate24To32,ENABLEPARITYPATCH,LoadSegPatch,OPENPATCH,Overpatch,RsrcEntrySERD_0
            EXPORT  RSRCMGRPATCH,SEPARITYPATCH,SHUTRESTARTANNEX,SLOTBUSEXCPTNPTCH,SoundInitPatch,sub_40855EEA_L7
            EXPORT  UnloadSegPatch

            IMPORT  BaseOfROM,BLOCKMOVEPATCH,CallRoutines,Enable60HzInts,EnableParityInts,FLUSHCRANGE
            IMPORT  HMMMMMM,INITGLOBALS,INITMACEDISPATCH,InitSndDispatch,InstallSoundIntHandler,OPENPATCHRTN
            IMPORT  OPENPATCHRTN1,RsrcEntryPACK_5,SoundInitPatchRtn

            SECTION "Part4",CODE

Overpatch:
FINDDEVBASEPATCH:
            move.w  (2,A0),D0
            btst    #2,D0
            beq.b   .L1
            andi.l  #$FF000000,D2
            or.l    D1,D2
.L1:
            rts
SEPARITYPATCH:
            btst    #5,($DD2).w                     ; TestFor RBVExists
            beq.b   .L1
            btst    #7,($DD7).w                     ; TestFor V8ChipBit
            bne.b   .L3
            movea.l VIA,A0
            btst    #6,(A0)
            bne.b   .L3
            bclr    #7,($400,A0)
            move.b  (A0),D1
            bset    #7,($400,A0)
            btst    #7,D1
            bne.b   .L3
            bset    #6,(A0)
            bra.b   .L2
.L1:
            btst    #4,($DD1).w                     ; TestFor RPUExists
            beq.b   .L3
            movea.l VIA2,A0
            move.w  ($202,A0),D1
            btst    #$E,D1
            beq.b   .L3
            clr.b   ($E,A0)
            movea.l UnivInfoPtr,A0
            adda.l  (A0),A0
            movea.l ($50,A0),A0
            st      ($10,A0)
            move.l  (A0),D1
            bset    #$10,D1
            move.l  D1,(A0)
.L2:
            moveq   #1,D1
            rts
.L3:
            moveq   #0,D1
            rts
ENABLEPARITYPATCH:
            BigJsr  Enable60HzInts,A0
            BigJsr  EnableParityInts,A0
            rts
RSRCMGRPATCH:
            tst.b   D3
            beq.b   .L1
            cmp.b   (4,A2),D3
            ble.b   .L2
.L1:
            movea.l UnivInfoPtr,A0
            move.b  ($16,A0),D3
.L2:
            cmpi.b  #4,D3
            bne.b   .L3
            btst    #4,HWCfgFlags
            beq.b   .L3
            moveq   #3,D3
.L3:
            rts
DELSEARCHPATCH:
            move.l  (8,SP),D1
            exg     D0,D1
            jsr     ([$644.w])
            exg     D0,D1
            movea.l ([TheGDevice.w]),A1
            lea     ($C,A1),A1
            move.l  (A1),D2
            rts
DELCOMPPATCH:
            move.l  (8,SP),D1
            exg     D0,D1
            jsr     ([$644.w])
            exg     D0,D1
            movea.l ([TheGDevice.w]),A1
            lea     ($10,A1),A1
            move.l  (A1),D2
            rts
OPENPATCH:
            movem.l (SP)+,D3-D5/A2-A4
            cmpi.b  #$40,($1B,A0)
            beq.b   .L1
            tst.w   FSFCBLen
            bmi.b   .L1
            BigJmp  OPENPATCHRTN,A1
.L1:
            BigJmp  OPENPATCHRTN1,A1
SoundInitPatch:
            movem.l D0-D2/A0-A2/A6,-(SP)
            BigJsr  INITGLOBALS,A1
            BigJsr  InstallSoundIntHandler,A1
            BigJsr  InitSndDispatch,A1
            BigJsr  INITMACEDISPATCH,A1
            movem.l (SP)+,D0-D2/A0-A2/A6
            move.b  #1,D0
            _SwapMMUMode
            move.l  ([BootGlobPtr.w],-$46.w),D1
            add.l   ([BootGlobPtr.w],-$14.w),D1
            move.l  D1,PhysMemTop
            _SwapMMUMode
            cmpi.b  #4,CPUFlag
            blt.b   .L1
            move.w  #$A02E,D0
            BigLea  BLOCKMOVEPATCH,A0
            _SetTrapAddress
.L1:
            jsr     INITOVERPATCH
            BigJmp  SoundInitPatchRtn,A0
VISACONFIGURERAMPATCH:
            cmpi.l  #$FFFFFFFF,D3
            beq.w   sub_4084C106.L1
            move.l  A3,D5
            cmpi.l  #$FFFFFFFF,D4
            beq.b   .L1
            add.l   A4,D5
            move.l  D5,(4,A6)
            move.l  #$FFFFFFFF,(8,A6)
            bra.b   .L2
.L1:
            move.l  D3,D4
            movea.l A3,A4
            suba.l  A3,A3
            move.l  A3,(A6)
.L2:
            swap    D5
            cmpi.w  #$A0,D5
            bhi.b   sub_4084C106.L1
            lsr.w   #4,D5
            move.b  ($4084C0FB.w,PC,D5.w),D3
            cmpi.b  #$FF,D3
            bne.b   .L3
            move.l  #$FFFFFFFF,(A6)
            bra.b   sub_4084C106.L1
.L3:
            movea.l A6,A2
            bsr.b   sub_4084C106
            movea.l A2,A6
            lea     sub_4084C106.L1,A2
            bsr.b   sub_4084C106
            movea.l A2,A5
            movea.l (SP),A2
            bsr.b   sub_4084C106
            move.l  A2,(SP)
            movea.l SP,A2
            subq.w  #2,SP
            bsr.b   sub_4084C106
            exg     A2,SP
            lea     sub_4084C0E6,A3
            bra.b   sub_4084C0E6.L1
sub_4084C0E6:
            movea.l ($34,A0),A2
            lea     (1,A2),A2
            movea.l A5,A3
.L1:
            move.b  (A2),D5
            andi.b  #$1F,D5
            or.b    D3,D5
            move.b  D5,(A2)
            jmp     (A3)
            dc.w    $0020,$4060,$80A0,$FFFF,$C0E0
sub_4084C106:
            cmp.l   A2,D4
            bhi.b   .L1
            move.l  A2,D6
            sub.l   D4,D6
            cmpa.l  D6,A4
            bls.b   .L1
            add.l   A3,D6
            movea.l D6,A2
.L1:
            rts
ElsieTranslate24To32:
            and.l   Lo3Bytes,D0
            bclr    #$17,D0
            bne.b   .L1
            rts
.L1:
            move.w  D1,-(SP)
            swap    D0
            move.w  D0,D1
            lsr.w   #4,D1
            add.w   ($4084C138.w,PC,D1.w*2),D0
            swap    D0
            move.w  (SP)+,D1
            rts
            dc.w    $0080,$0080,$4080,$4080,$4080,$4080,$FDA0,$5080
SHUTRESTARTANNEX:
            cmpi.b  #$D,BoxFlag
            bne.b   .L2
            link.w  A6,#-$78
            lea     (-$38,A6),A0
            move.l  #$30001,($28,A0)
            move.l  #$1001A,($2C,A0)
            clr.b   ($30,A0)
            clr.b   ($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
            clr.l   ($18,A0)
            bset    #1,($1B,A0)
            _sGetTypesRsrc
            bne.b   .L1
            lea     (-$78,A6),A0
            move.w  (-$12,A6),($18,A0)
            move.w  #$80,($1A,A0)
            _Control immed
.L1:
            unlk    A6
.L2:
            moveq   #1,D0
            BigJsr  CallRoutines,A0
            movea.l ROMBase,A0
            rts
SlotMgrPatch1:
            movea.l (SP)+,A2
            move.l  A3,(4,A0)
            move.b  D1,(A2)
            move.b  ($36,A0),(4,A2)
            _sExec
            move.b  #3,(8,A1)
            move.w  (2,A2),(6,A1)
            bpl.b   .L1
            move.w  #$FEC4,(4,A1)
.L1:
            rts
SLOTBUSEXCPTNPTCH:
            movea.l (SP)+,A0
            move.l  (SP),D0
            move.l  A2,($5A,SP)
            move.w  (4,SP),($58,SP)
            clr.w   ($5E,SP)
            lea     ($58,SP),SP
            rte
LoadSegPatch:
            move.l  A2,-(SP)
            movea.l A1,A2
.L1:
            move.w  (A1)+,D2
            move.w  D1,(-2,A1)
            move.w  #$4EF9,(A1)+
            pea     (4,A0,D2.l)
            move.l  (SP)+,(A1)+
            subq.w  #1,D0
            bne.b   .L1
            suba.l  A2,A1
            movea.l A2,A0
            bsr.l   FLUSHCRANGE
            movea.l (SP)+,A2
            rts
UnloadSegPatch:
            movea.l (4,SP),A0
            cmpi.w  #$4EF9,(A0)
            bne.b   .L2
            st      ResLoad
            subq.w  #4,SP
            move.l  #'CODE',-(SP)
            move.w  (-2,A0),-(SP)
            _GetResource
            movea.l (SP)+,A0
            _HUnlock
            movea.l (A0),A0
            movea.l A5,A1
            adda.w  CurJTOffset,A1
            adda.w  (A0),A1
            move.w  (2,A0),D0
            beq.b   .L2
            movem.l D1/A2,-(SP)
            movea.l A1,A2
.L1:
            move.w  (A1),D1
            move.l  (4,A1),D2
            sub.l   A0,D2
            subq.l  #4,D2
            move.w  D2,(A1)+
            move.w  #$3F3C,(A1)+
            move.w  D1,(A1)+
            move.w  #$A9F0,(A1)+
            subq.w  #1,D0
            bne.b   .L1
            suba.l  A2,A1
            movea.l A2,A0
            bsr.l   FLUSHCRANGE
            movem.l (SP)+,D1/A2
.L2:
            move.l  (SP)+,(SP)
            rts
            ds.b    11894
            dc.b    'Copyright '
            dc.w    $A920
            dc.b    '1981-1990 by Apple Computer, Inc.  All rights reserved.'
            dc.b    $00
INITOVERPATCH:
            cmpi.b  #0,MMUType
            beq.b   .L1
            cmpi.b  #1,MMUType
            bne.b   .L2
.L1:
            move.w  #$A89F,D0
            _GetToolBoxTrapAddress
            move.w  #$A05C,D0
            _SetOSTrapAddress
.L2:
            bsr.b   sub_4084F154
            beq.b   .L3
            bsr.b   DrawCopyrightPicture
.L3:
            rts
sub_4084F154:
            btst    #5,($17A).w
            beq.b   .L2
            moveq   #2,D0
            lea     .L3,A0
            moveq   #$3C,D1
            add.l   Ticks,D1
.L1:
            cmp.l   Ticks,D1
            blt.b   .L2
            lea     KeyMap,A1
            adda.w  (2,A0),A1
            move.w  (A0),D2
            btst    D2,(A1)
            beq.b   .L1
            btst    #5,($17A).w
            beq.b   .L2
            tst.l   (A0)+
            dbra    D0,.L1
            rts
.L2:
            moveq   #0,D0
            rts
.L3:
            dc.w    $0001,0,$0006,$0001,$0001,$0002
DrawCopyrightPicture:
            movem.l D3-D4/A2-A4/A6,-(SP)
            suba.w  #$40,SP
            movea.l SP,A6
            movea.l (A5),A2
            bsr.w   BlackoutAndSaveEntries
            pea     (-$74,A2)
            _PaintRect
            bsr.w   GetPictureHandle
            beq.b   NoDrawCopyrightPicture
            move.l  A0,-(SP)
            movea.l (A0),A1
            move.l  (6,A1),-(SP)
            move.l  (2,A1),-(SP)
            movea.l SP,A1
            move.l  A0,-(SP)
            move.l  (-$70,A2),D0
            move.l  A1,-(SP)
            sub.l   (4,A1),D0
            lsr.w   #1,D0
            swap    D0
            lsr.w   #1,D0
            swap    D0
            add.l   D0,(A1)+
            add.l   D0,(A1)
            _DrawPicture
            pea     (-8,A2)
            _PenPat
            move.l  #$20002,-(SP)
            _PenSize
            move.l  SP,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            move.l  SP,-(SP)
            _FrameRect
            move.l  #$10001,-(SP)
            _PenSize
            move.l  SP,-(SP)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            move.l  SP,-(SP)
            _FrameRect
            addq.l  #8,SP
            movea.l (SP)+,A0
            _DisposHandle
NoDrawCopyrightPicture:
            bsr.w   FadeInAndRestoreEntries
WaitForMouse:
            tst.b   MBState
            bmi.b   WaitForMouse
            move.b  BoxFlag,D0
            cmpi.b  #$F,D0
            bne.b   .L1
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            pea     (-$18,A2)
            _FillRect
.L1:
            lea     (-$74,A2),A0
            move.l  A0,-(SP)
            lea     Scratch8,A1
            move.l  A1,-(SP)
            move.l  A1,-(SP)
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            pea     (-$10,A2)
            _PenPat
            move.l  #$30003,-(SP)
            _PenSize
            move.l  #$160016,-(SP)
            _FrameRoundRect
            _PenNormal
            move.l  #$100010,-(SP)
            pea     (-$18,A2)
            _FillRoundRect
            lea     ($40,SP),SP
            movem.l (SP)+,D3-D4/A2-A4/A6
            rts
GetPictureHandle:
            BigLea  HMMMMMM,A1
            move.l  (A1),D0
            _NewHandle
            move.l  A0,-(SP)
            beq.b   .L3
            movea.l (A0),A0
            move.l  (A1)+,D0
            adda.w  (A1),A1
            moveq   #0,D1
.L1:
            bfexts  (A1){D1:9},D2
            bpl.b   .L4
            asr.w   #4,D2
            move.b  (0,A1,D2.w),(A0)+
.L2:
            addq.l  #5,D1
            subq.l  #1,D0
            bgt.b   .L1
.L3:
            movea.l (SP)+,A0
            move.l  A0,D0
            rts
.L4:
            move.b  D2,(A0)+
            addq.l  #4,D1
            bra.b   .L2
BlackoutAndSaveEntries:
            movea.l MainDevice,A0
            movea.l (A0),A0
            tst.w   (4,A0)
            bne.b   NoBlackout
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            _HandToHand
            movea.l A0,A3
            _HandToHand
            movea.l A0,A4
            movea.l MainDevice,A0
            movea.l (A0),A0
            move.w  (A0),($18,A6)
            clr.l   ($C,A6)
            clr.w   ($16,A6)
            lea     ($40,A6),A0
            move.l  A0,($1C,A6)
            clr.w   (4,A0)
            movea.l (A3),A1
            move.w  (6,A1),D3
            move.w  D3,(6,A0)
            lea     (8,A1),A1
            move.l  A1,(A0)
            move.w  #3,($1A,A6)
            movea.l A6,A0
            move.w  #7,D2
.L1:
            movea.l (A3),A1
            lea     (8,A1),A1
            move.w  D3,D0
.L2:
            addq.w  #2,A1
            move.w  (A1),D1
            lsr.w   #1,D1
            move.w  D1,(A1)+
            move.w  (A1),D1
            lsr.w   #1,D1
            move.w  D1,(A1)+
            move.w  (A1),D1
            lsr.w   #1,D1
            move.w  D1,(A1)+
            dbra    D0,.L2
            _Control
            dbra    D2,.L1
NoBlackout:
            rts
FadeInAndRestoreEntries:
            movea.l MainDevice,A0
            movea.l (A0),A0
            tst.w   (4,A0)
            bne.b   NoFadeIn
            bsr.b   CheckForSmallDACs
            movea.l (A3),A0
            lea     (8,A0),A0
            lea     ($40,A6),A1
            move.l  A0,(A1)
            move.w  #$FF,D2
            lsr.w   D4,D2
.L1:
            movea.l (A3),A0
            lea     (8,A0),A0
            movea.l (A4),A1
            lea     (8,A1),A1
            move.w  D3,D0
.L2:
            addq.w  #2,A0
            addq.w  #2,A1
            clr.w   D1
            move.b  (A1),D1
            lsl.w   D4,D1
            addq.w  #2,A1
            add.w   D1,(A0)+
            clr.w   D1
            move.b  (A1),D1
            lsl.w   D4,D1
            addq.w  #2,A1
            add.w   D1,(A0)+
            clr.w   D1
            move.b  (A1),D1
            lsl.w   D4,D1
            addq.w  #2,A1
            add.w   D1,(A0)+
            dbra    D0,.L2
            movea.l A6,A0
            _Control
            dbra    D2,.L1
            movea.l (A4),A1
            lea     (8,A1),A1
            lea     ($40,A6),A0
            move.l  A1,(A0)
            movea.l A6,A0
            _Control
            movea.l A3,A0
            _DisposHandle
            movea.l A4,A0
            _DisposHandle
NoFadeIn:
            rts
CheckForSmallDACs:
            movea.l TheGDevice,A0
            movea.l (A0),A0
            move.w  (A0),D0
            not.w   D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w*4),A1
            movea.l (A1),A1
            suba.w  #$38,SP
            movea.l SP,A0
            move.b  ($28,A1),($31,A0)
            clr.b   ($32,A0)
            clr.b   ($30,A0)
            move.w  #1,($28,A0)
            clr.w   ($2A,A0)
            clr.w   ($2C,A0)
            clr.w   ($2E,A0)
            _sNextTypesRsrc
            move.b  #$20,($32,A0)
            _sReadWord
            move.w  (2,A0),D0
            lea     ($38,SP),SP
            cmpi.w  #9,D0
            beq.b   .L1
            cmpi.w  #$1A,D0
            beq.b   .L1
            moveq   #0,D4
            rts
.L1:
            moveq   #4,D4
            rts
            ds.b    14
RESTOP:
            ds.b    10528
RsrcEntryDRVR_49:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 49 ".netBOOT" (1988 bytes) - Combo mask
            dc.l    RsrcEntryPACK_5-BaseOfROM       ; Next entry
            dc.l    RsrcDRVR_49-BaseOfROM           ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    49                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    8,'.netBOOT'                    ; Name
            ds.b    4
            dc.l    $C0A00000,$000007D0,$000001DC   ; Block header
RsrcDRVR_49:
            dc.w    $4500                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    netBOOTOpen-RsrcDRVR_49         ; drvrOpen
            dc.w    netBOOTPrime-RsrcDRVR_49        ; drvrPrime
            dc.w    netBOOTCtl-RsrcDRVR_49          ; drvrCtl
            dc.w    netBOOTStatus-RsrcDRVR_49       ; drvrStatus
            dc.w    netBOOTClose-RsrcDRVR_49        ; drvrClose
            dc.b    8,'.netBOOT'
            dc.b    $00,$02,$00
netBOOTOpen:
            move.l  A1,-(SP)
            move.l  ($14,A1),D1
            bne.b   .L1
            movea.l A0,A2
            move.l  #$DE,D0
            _NewPtrSysClear
            bne.b   .L2
            move.l  A0,D1
            movea.l (SP),A1
            move.l  A0,($14,A1)
            moveq   #0,D0
            move.w  ($18,A2),D0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            move.l  D0,-(SP)
            jsr     sub_408522A4
            addq.l  #8,SP
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            pea     sub_40851E04
            _GetNamedResource
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A1
            move.l  A3,-(SP)
            movea.l (A1),A3
            move.w  (4,SP),D0
            movea.l A1,A3
            subq.w  #1,D0
            dc.w    $A53D                           ; A-trap $A53D
            bne.b   .L1
            _HLock
            movea.l (A0),A0
            move.l  A3,(A0)+
            move.w  (A3),(A0)+
            movea.l (SP)+,A3
.L1:
            addq.w  #2,SP
            moveq   #0,D0
            addq.l  #4,SP
            rts
.L2:
            movea.l (SP)+,A1
            move.l  ($14,A1),D1
            beq.b   .L3
            movea.l D1,A0
            _DisposPtr
.L3:
            move.w  #$FFE9,D0
            rts
sub_40851E04:
            btst    D3,D7
            movea.l -(A1),SP
            moveq   #$42,D2
            ble.b   netBOOTPrime.L2+1
            moveq   #0,D2
netBOOTClose:
            move.l  ($14,A1),D1
            beq.b   netBOOTStatus
            move.l  A1,-(SP)
            move.w  ($18,A1),D0
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            jsr     sub_40852346
            addq.l  #8,SP
            movea.l (SP)+,A1
            clr.l   ($14,A1)
            tst.l   D0
            beq.b   netBOOTStatus
            moveq   #-$18,D0
netBOOTStatus:
            rts
netBOOTCtl:
            move.w  #$FFBF,D0
            bra.b   netBOOTPrime.L3
netBOOTPrime:
            btst    #3,($17B).w
            beq.w   .L1
            move.w  #$FFBF,D0
            bra.w   .L3
.L1:
            move.l  ($14,A1),D1
            beq.b   .L3
            movem.l A0-A1,-(SP)
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  ($10,A1),-(SP)
            lea     sub_40852050,A2
            move.l  A2,($10,A1)
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            jsr     sub_408523AE
            addq.l  #8,SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
.L2:
            movem.l (SP)+,A0-A1
.L3:
            move.w  D0,($10,A0)
            movea.l JIODone,A3
            jmp     (A3)
sub_40851E88:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .L1
            bsr.b   sub_40851EAE
            bra.b   .L2
.L1:
            bsr.b   sub_40851ECE
.L2:
            rts
sub_40851E9A:
            ori.b   #4,D4
            ori.b   #$AB,D3
            ori.b   #$BC,D1
            ori.b   #$20,-(A0)
            ori.b   #$8B,-(A0)
sub_40851EAE:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40851E9A,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _ReadXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40851ECE:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40851E9A,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _WriteXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40851EEE:
            link.w  A6,#-$32
            lea     DrvQHdr,A0
            moveq   #4,D0
.L1:
            movea.l (2,A0),A1
.L2:
            cmp.w   (6,A1),D0
            beq.b   .L3
            cmpa.l  (6,A0),A1
            beq.b   .L4
            movea.l (A1),A1
            bra.b   .L2
.L3:
            addq.w  #1,D0
            bra.b   .L1
.L4:
            move.w  D0,($12,A6)
            moveq   #$1A,D0
            _NewPtrSys
            beq.b   .L5
            move.w  D0,($12,A6)
            bra.b   .L6
.L5:
            move.l  #$80000,(A0)+
            move.w  #1,(4,A0)
            move.w  #1,($A,A0)
            move.w  ($E,A6),($E,A0)
            move.w  ($10,A6),($C,A0)
            move.l  (8,A6),($10,A0)
            move.w  ($12,A6),D0
            swap    D0
            move.w  ($C,A6),D0
            _AddDrive
.L6:
            unlk    A6
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
sub_40851F5A:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            ble.b   .L2
            subq.l  #1,D0
            moveq   #0,D1
.L1:
            move.b  D1,(A0)+
            dbra    D0,.L1
.L2:
            rts
sub_40851F70:
            movem.l D1-D2/A0-A4,-(SP)
            cmpi.b  #$F,(7,A0)
            bne.w   .L5
            move.w  ($16,A0),D0
            cmpi.w  #4,D0
            bne.w   .L5
            lea     DrvQHdr,A2
            movea.l (2,A2),A1
.L1:
            cmp.w   (6,A1),D0
            beq.b   .L2
            cmpa.l  (6,A2),A1
            beq.w   .L4
            movea.l (A1),A1
            bra.b   .L1
.L2:
            cmpi.w  #1,($A,A1)
            bne.w   .L4
            move.l  ($10,A1),D0
            movea.l A1,A4
            beq.w   .L4
            movea.l D0,A2
            movea.l SysZone,A0
            move.l  A0,TheZone
            move.l  ($10,A0),-(SP)
            lea     sub_40852050,A1
            move.l  A1,($10,A0)
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #3,($1A,A0)
            move.w  (4,A2),($18,A0)
            _Control
            beq.b   .L3
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            bra.w   .L5
.L3:
            movea.l ($1C,A0),A1
            move.l  A1,($352).w
            movea.l ($372).w,A3
            move.l  A1,(2,A3)
            moveq   #2,D0
            move.l  D0,(6,A3)
            clr.l   ($A,A3)
            clr.l   ($E,A3)
            movea.l ($20,A0),A1
            move.w  ($A,A1),($A,A4)
            move.w  (8,A1),(8,A4)
            move.b  (-3,A1),(-3,A4)
            subq.w  #4,A1
            movea.l A1,A0
            _DisposPtr
            clr.l   ($10,A4)
            move.l  (8,A2),($3F2).w
            lea     ($32,SP),SP
            movea.l SysZone,A0
            move.l  (SP)+,($10,A0)
            moveq   #0,D0
            bra.b   .L5
.L4:
            moveq   #-1,D0
.L5:
            movem.l (SP)+,D1-D2/A0-A4
            rts
sub_40852050:
            move.l  (4,SP),D0
            move.l  A2,-(SP)
            movea.l SysZone,A1
            movea.l (A1),A0
            movea.l A0,A2
            addi.l  #$4000,D0
            lea     (0,A0,D0.l),A0
            move.l  D0,D1
            movea.l BufPtr,A1
            suba.w  #$2000,A1
            cmpa.l  A1,A0
            bls.b   .L1
            move.l  A1,D1
            sub.l   A2,D1
            movea.l A1,A0
.L1:
            _SetAppBase
            movea.l SysZone,A1
            move.l  A1,TheZone
            move.l  A1,ApplZone
            move.l  (A1),HeapEnd
            movea.l (SP)+,A2
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  D1,(SP)
            jmp     (A0)
sub_40852098:
            movea.l (4,SP),A0
            clr.l   -(SP)
            move.l  #'DRVR',-(SP)
            move.l  ($12,A0),-(SP)
            _GetNamedResource
            clr.w   D0
            tst.l   (SP)+
            beq.b   .L1
            movea.l (4,SP),A0
            _Open
            move.w  ($18,A0),D0
.L1:
            rts
sub_408520BC:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     sub_40851E88
            moveq   #0,D0
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_408520DE:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            subq.l  #4,SP
            moveq   #$48,D0
            move.l  D0,-(SP)
            jsr     sub_40852496
            move.l  (SP)+,(A3)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.b   .L2
.L1:
            moveq   #1,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     sub_408520BC
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
sub_4085210E:
            link.w  A6,#-$38
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($C,A6),A3
            moveq   #$38,D0
            move.l  D0,-(SP)
            pea     (-$38,A6)
            jsr     sub_40851F5A
            move.w  #$28,(-$10,A6)
            move.w  #1,(-$E,A6)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.w  D0,(-$C,A6)
            move.b  #1,(-8,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     sub_40852506
            move.w  (SP)+,D7
            beq.b   .L1
            move.w  D7,D0
            bra.b   .L2
.L1:
            move.l  ($18,A6),(-$38,A6)
            subq.l  #2,SP
            pea     (-$38,A6)
            jsr     sub_40852512
            move.w  (SP)+,D7
            move.b  (-7,A6),(A3)
            move.b  (-6,A6),(A4)
            movea.l ($14,A6),A0
            move.b  (-5,A6),(A0)
            move.w  D7,D0
.L2:
            movem.l (-$44,A6),D7/A3-A4
            unlk    A6
            rts
sub_40852186:
            link.w  A6,#-$7A
            movem.l D7/A3-A4,-(SP)
            lea     (-$22,A6),A4
            movea.l (8,A6),A3
            moveq   #0,D0
            move.l  D0,(-$7A,A6)
            pea     (-$7A,A6)
            jsr     sub_408520DE
            movea.l (-$7A,A6),A0
            moveq   #1,D0
            cmp.b   (1,A0),D0
            addq.l  #4,SP
            bne.b   .L1
            moveq   #$50,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     sub_40851F5A
            lea     .L8,A0
            move.l  A0,(-$60,A6)
            pea     (-$72,A6)
            jsr     sub_40852098
            move.w  D0,(-$5A,A6)
            lea     ($C,SP),SP
            bra.w   .L3
.L1:
            subq.l  #4,SP
            move.w  #$A06E,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408524B6
            subq.l  #4,SP
            move.w  #$A89F,-(SP)
            jsr     sub_408524AC
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            beq.b   .L2
            move.l  A4,-(SP)
            pea     (-$73,A6)
            pea     (-$74,A6)
            pea     (-$75,A6)
            movea.l (-$7A,A6),A0
            move.b  (1,A0),D0
            ext.w   D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_4085210E
            move.w  D0,D7
            lea     ($14,SP),SP
            bne.b   .L6
            moveq   #$24,D0
            move.l  D0,-(SP)
            pea     (-$72,A6)
            jsr     sub_40851F5A
            move.b  (-$75,A6),(-$50,A6)
            move.b  (-$74,A6),(-$4F,A6)
            move.l  A4,(-$60,A6)
            subq.l  #2,SP
            pea     (-$72,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_4085251E
            move.w  (SP)+,D7
            move.b  (-$75,A6),(1,A3)
            move.b  (-$74,A6),(2,A3)
            addq.l  #8,SP
            bra.b   .L3
.L2:
            moveq   #-$A,D7
            bra.b   .L6
.L3:
            tst.w   D7
            bne.b   .L4
            tst.w   (-$5A,A6)
            bne.b   .L5
.L4:
            tst.w   D7
            bne.b   .L6
            moveq   #-$17,D7
            bra.b   .L6
.L5:
            movea.l (-$7A,A6),A0
            move.b  (1,A0),(A3)
            move.w  (-$5A,A6),(4,A3)
.L6:
            tst.l   (-$7A,A6)
            beq.b   .L7
            move.l  (-$7A,A6),-(SP)
            jsr     sub_408524A2
.L7:
            move.w  D7,D0
            movem.l (-$86,A6),D7/A3-A4
            unlk    A6
            rts
.L8:
            dc.b    7,'.ATBOOT'
            dc.w    0
sub_408522A4:
            link.w  A6,#-4
            movem.l D6-D7/A3,-(SP)
            movea.l ($C,A6),A3
            pea     (-4,A6)
            jsr     sub_408520DE
            tst.w   D0
            addq.l  #4,SP
            bne.b   .L1
            tst.l   (-4,A6)
            bne.b   .L2
.L1:
            moveq   #-$17,D0
            bra.b   .L4
.L2:
            movea.l (-4,A6),A0
            move.b  (3,A0),D7
            move.l  (-4,A6),-(SP)
            jsr     sub_408524A2
            ext.w   D7
            ext.l   D7
            move.l  #$80,D0
            and.l   D7,D0
            bne.b   .L3
            moveq   #-$17,D0
            bra.b   .L4
.L3:
            subq.l  #2,SP
            pea     ($4000).w
            move.w  ($A,A6),-(SP)
            move.l  A3,-(SP)
            jsr     sub_40851EEE
            move.w  (SP)+,D6
            moveq   #0,D0
.L4:
            movem.l (-$10,A6),D6-D7/A3
            unlk    A6
            rts
sub_40852308:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.w #$308,A4
            movea.l (2,A4),A3
            bra.b   .L2
.L1:
            movea.l (A3),A3
.L2:
            cmpa.l  (6,A4),A3
            beq.b   .L3
            cmp.w   (8,A3),D7
            bne.b   .L1
.L3:
            cmp.w   (8,A3),D7
            bne.b   .L4
            subq.l  #2,SP
            move.l  A3,-(SP)
            move.l  A4,-(SP)
            jsr     sub_408524CE
            move.l  A3,-(SP)
            jsr     sub_408524A2
            addq.l  #2,SP
.L4:
            movem.l (SP)+,D7/A3-A4
            rts
sub_40852346:
            link.w  A6,#-$50
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852308
            tst.w   (4,A3)
            addq.l  #4,SP
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.w  (4,A3),(-$38,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     sub_408524E2
            move.w  (SP)+,D7
.L1:
            tst.l   ($DA,A3)
            beq.b   .L2
            move.l  ($DA,A3),-(SP)
            _CloseCPort
            move.l  ($DA,A3),-(SP)
            jsr     sub_408524A2
            moveq   #0,D0
            move.l  D0,($DA,A3)
.L2:
            move.l  A3,-(SP)
            jsr     sub_408524A2
            moveq   #0,D0
            movem.l (-$58,A6),D7/A3
            unlk    A6
            rts
sub_408523AE:
            link.w  A6,#-$82
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            move.w  #$FF,D0
            and.w   (6,A3),D0
            cmpi.w  #2,D0
            beq.b   .L1
            moveq   #-$40,D0
            bra.w   .L8
.L1:
            move.l  A4,-(SP)
            jsr     sub_40852186
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L2
            moveq   #-$40,D0
            bra.w   .L8
.L2:
            move.w  (4,A4),(-$38,A6)
            bne.b   .L3
            moveq   #-$40,D0
            bra.w   .L8
.L3:
            move.w  #1,(-$36,A6)
            moveq   #0,D0
            move.l  D0,(-$44,A6)
            move.l  ($24,A3),(-$2C,A6)
            move.w  ($2C,A3),(-$24,A6)
            move.l  ($2E,A3),(-$22,A6)
            move.l  ($20,A3),(-$30,A6)
            move.l  ($1C,A3),(-$34,A6)
            subq.l  #2,SP
            pea     (-$50,A6)
            moveq   #0,D1
            move.b  D1,-(SP)
            jsr     sub_408524F4
            move.w  (SP)+,D7
            bne.b   .L4
            move.w  #2,(-$68,A6)
            move.w  (4,A4),(-$6A,A6)
            subq.l  #2,SP
            pea     (-$82,A6)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408524F4
            move.w  (SP)+,D7
            move.l  ($3F2).w,(8,A4)
            lea     sub_40851F70,A0
            move.l  A0,($3F2).w
.L4:
            tst.w   D7
            beq.b   .L7
            move.w  D7,(6,A4)
            ble.b   .L5
            moveq   #-$40,D0
            bra.b   .L6
.L5:
            moveq   #-$41,D0
.L6:
            move.w  D0,D7
.L7:
            move.l  (-$28,A6),($28,A3)
            move.w  D7,D0
.L8:
            movem.l (-$8E,A6),D7/A3-A4
            unlk    A6
            rts
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
            moveq   #0,D0
.L9:
            move.l  A1,-(SP)
.L10:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L10
sub_40852496:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     sub_408523AE.L9
sub_408524A2:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     sub_408523AE.L9
sub_408524AC:
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            _GetTrapAddress
            move.l  A0,(SP)
            jmp     (A1)
sub_408524B6:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            move.w  (SP)+,D0
            move.l  A1,-(SP)
            tst.b   D1
            beq.b   .L1
            _GetToolBoxTrapAddress
            bra.b   .L2
.L1:
            _GetOSTrapAddress
.L2:
            move.l  A0,(4,SP)
            rts
sub_408524CE:
            movea.l (4,SP),A1
            movea.l (8,SP),A0
            _Dequeue
            move.w  D0,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
sub_408524E2:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Close
            bra.b   .L2
.L1:
            _Close async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
sub_408524F4:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _Control
            bra.b   .L2
.L1:
            _Control async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
sub_40852506:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sNextTypesRsrc
            move.w  D0,(SP)
            jmp     (A1)
sub_40852512:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _sReadDrvrName
            move.w  D0,(SP)
            jmp     (A1)
sub_4085251E:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            movea.l (SP)+,A0
            bne.b   .L1
            _HOpen
            bra.b   .L2
.L1:
            _HOpen async
.L2:
            move.w  D0,(SP)
            jmp     (A1)
RsrcEntryDRVR_50:
            dc.b    $18,$00,$00,$00,$00,$00,$00,$00 ; Resource 'DRVR' 50 ".ATBOOT" (17796 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_49-BaseOfROM      ; Next entry
            dc.l    RsrcDRVR_50-BaseOfROM           ; Data
            dc.b    'DRVR'                          ; Type
            dc.w    50                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    7,'.ATBOOT'                     ; Name
            ds.b    5
            dc.l    $C0A00000,$00004590,$000001D4   ; Block header
RsrcDRVR_50:
            dc.w    $4400                           ; drvrFlags
            dc.w    0                               ; drvrDelay
            dc.w    $0000                           ; drvrEMask
            dc.w    0                               ; drvrMenu
            dc.w    ATBOOTOpen-RsrcDRVR_50          ; drvrOpen
            dc.w    ATBOOTPrime-RsrcDRVR_50         ; drvrPrime
            dc.w    ATBOOTCtl-RsrcDRVR_50           ; drvrCtl
            dc.w    ATBOOTPrime-RsrcDRVR_50         ; drvrStatus
            dc.w    ATBOOTClose-RsrcDRVR_50         ; drvrClose
            dc.b    7,'.ATBOOT'
            dc.w    $0100
ATBOOTOpen:
            move.l  ($14,A1),D3
            bgt.b   .L1
            move.l  #$272,D0
            _NewPtrSysClear
            move.l  A0,D3
            beq.w   .L5
            move.l  D3,($14,A1)
.L1:
            suba.w  #$32,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     .L7,A1
            move.l  A1,($12,A0)
            _Open
            tst.w   ($10,A0)
            adda.w  #$32,SP
            bgt.w   .L5
            movea.l D3,A3
            move.w  ($18,A0),(A3)
            btst    #3,($17B).w
            bne.w   .L5
            movem.l D2-D7/A0-A6,-(SP)
            moveq   #-$62,D1
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            bgt.b   .L4
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'lmgr',-(SP)
            clr.w   -(SP)
            _GetResource
            move.l  (SP)+,D5
            beq.b   .L3
            bsr.w   sub_40856164
            beq.b   .L2
            move.w  D0,D1
            bra.b   .L4
.L2:
            move.w  #$A090,D0
            _GetOSTrapAddress
            movea.l A0,A5
            move.w  #$A090,D0
            lea     ATBOOTCtl.L2,A0
            _SetOSTrapAddress
.L3:
            suba.w  #$32,SP
            movea.l SP,A0
            clr.b   ($1B,A0)
            lea     .L6,A1
            move.l  A1,($12,A0)
            _Open
            move.w  ($10,A0),D1
            lea     ($32,SP),SP
            tst.l   D5
            beq.b   .L4
            movea.l A5,A0
            move.w  #$A090,D0
            _SetOSTrapAddress
.L4:
            movem.l (SP)+,D2-D7/A0-A6
            tst.w   D1
            bne.b   .L5
            moveq   #0,D0
            rts
.L5:
            move.w  #$FFE9,D0
            rts
.L6:
            dc.b    4,'.MPP'
            dc.b    $00
.L7:
            dc.b    8,'.netBoot'
            dc.b    $00,$0B
            dc.b    'ATBoot Open'
            dc.w    0
ATBOOTClose:
            move.l  ($14,A1),D3
            beq.b   .L3
            movea.l D3,A3
            move.l  ($26A,A3),D0
            beq.b   .L1
            movea.l D0,A0
            _DisposPtr
.L1:
            move.l  (4,A3),D0
            beq.b   .L2
            movea.l D0,A0
            _DisposPtr
.L2:
            movea.l A3,A0
            _DisposPtr
            clr.l   ($14,A3)
.L3:
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  #$FFF6,($18,A0)
            _Close
            lea     ($32,SP),SP
            moveq   #0,D0
ATBOOTPrime:
            rts
            dc.b    12,'ATBoot Close'
            dc.b    $00,$4E,$75
ATBOOTCtl:
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            moveq   #-1,D0
            move.l  ($14,A1),-(SP)
            beq.w   .L1
            move.l  A0,-(SP)
            jsr     sub_40856022
.L1:
            addq.l  #8,SP
            movea.l (SP)+,A0
            move.l  #$400,($28,A0)
            move.w  D0,($10,A0)
            movea.l (SP)+,A1
            movea.l JIODone,A3
            jmp     (A3)
            dc.b    14,'ATBoot Control'
            dc.b    $00
.L2:
            dc.w    $317C,$0605,$0004,$7000,$4E75
sub_408526F0:
            movea.l (4,SP),A0
            move.l  (8,SP),D0
            beq.b   .L1
            bsr.b   sub_40852716
            bra.b   .L2
.L1:
            bsr.b   sub_40852736
.L2:
            rts
sub_40852702:
            ori.b   #4,D4
            ori.b   #$AB,D3
            ori.b   #$BC,D1
            ori.b   #$20,-(A0)
            ori.b   #$8B,-(A0)
sub_40852716:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40852702,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _ReadXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40852736:
            moveq   #0,D0
            btst    #$E,HWCfgFlags
            beq.b   .L2
            lea     sub_40852702,A1
            moveq   #4,D1
.L1:
            move.l  (A1)+,D0
            move.l  D0,D2
            _WriteXPRam
            swap    D2
            adda.w  D2,A0
            dbra    D1,.L1
.L2:
            rts
sub_40852756:
            move.l  A5,D0
            rts
sub_4085275A:
            movea.l (4,SP),A5
            rts
sub_40852760:
            move.l  (4,SP),D0
            lsl.w   #7,D0
            lea     .L1,A0
            add.l   A0,D0
            rts
.L1:
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1210,$1090
            dc.w    $1210,$1090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
            dc.w    $0FFF,$FFE0,$1800,$0030,$1000,$0010,$11FF,$FF10
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1211,$1090
            dc.w    $1211,$1090,$1201,$0090,$1201,$0090,$1203,$0090
            dc.w    $1200,$0090,$1200,$0090,$1200,$0090,$1200,$0090
            dc.w    $1200,$0090,$11FF,$FF10,$1000,$0010,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1300,$3F10,$1000,$0010
            dc.w    $1000,$0010,$1000,$0010,$1000,$0010,$1FFF,$FFF0
            dc.w    $0800,$0020,$0800,$0020,$0800,$0020,$0FFF,$FFE0
.L2:
            dc.w    $0FFF,$FFE0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0,$1FFF,$FFF0
            dc.w    $0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0,$0FFF,$FFE0
sub_4085296E:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($CE,A3)
            jsr     sub_4085275A
            pea     ($CA,A3)
            _InitGraf
            pea     ($D2,A3)
            _OpenPort
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
sub_4085298E:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($D2,A3)
            _CloseCPort
            movea.l (SP)+,A3
            rts
sub_4085299E:
            movem.l D6-D7/A3,-(SP)
            move.w  ($1A,SP),D6
            move.w  ($16,SP),D7
            movea.l ($10,SP),A3
            move.w  (4,A3),D0
            sub.w   (A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D6
            sub.l   D6,D0
            add.w   D0,(A3)
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D7
            sub.l   D7,D0
            add.w   D0,(2,A3)
            move.w  D6,D0
            add.w   (A3),D0
            add.w   D6,D0
            move.w  D0,(4,A3)
            move.w  D7,D0
            add.w   (2,A3),D0
            add.w   D7,D0
            move.w  D0,(6,A3)
            movem.l (SP)+,D6-D7/A3
            rts
sub_408529EE:
            link.w  A6,#-$24
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A3
            lea     (-8,A6),A0
            lea     ($E2,A3),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            moveq   #$10,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            pea     (-8,A6)
            jsr     sub_4085299E
            pea     ($D2,A3)
            _SetPort
            move.l  A4,(-$24,A6)
            move.w  #4,(-$20,A6)
            pea     (-$1E,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            lea     sub_40852760.L2,A0
            move.l  A0,(-$16,A6)
            move.w  #4,(-$12,A6)
            pea     (-$10,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            tst.l   ($10,A6)
            lea     ($C,SP),SP
            beq.b   .L1
            pea     (-8,A6)
            pea     ($B2,A3)
            _FillRect
.L1:
            pea     (-$24,A6)
            pea     (-$16,A6)
            pea     ($D4,A3)
            pea     (-$1E,A6)
            pea     (-$10,A6)
            pea     (-8,A6)
            _CopyMask
            movem.l (-$2C,A6),A3-A4
            unlk    A6
            rts
sub_40852A92:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A3
            moveq   #0,D7
            moveq   #3,D0
            cmp.w   ($13E,A3),D0
            ble.b   .L2
            tst.w   ($13E,A3)
            bne.b   .L1
            moveq   #1,D7
.L1:
            move.w  ($13E,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852760
            movea.l D0,A4
            addq.w  #1,($13E,A3)
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408529EE
            lea     ($10,SP),SP
.L2:
            movem.l (SP)+,D7/A3-A4
            rts
sub_40852AD2:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            lea     (-$12,A6),A4
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,($42,A3)
            pea     ($2C,A3)
            move.l  A4,-(SP)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #$2A,D1
            move.w  D1,-(SP)
            jsr     sub_408565D0
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408564EC
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
sub_40852B1C:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($14,A6),A4
            lea     ($38,A4),A3
            move.l  A4,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            pea     .L1
            jsr     sub_40856614
            move.l  A4,($1E,A3)
            move.b  ($23,A6),($1C,A3)
            move.b  ($27,A6),($1D,A3)
            move.l  ($10,A6),($22,A3)
            move.w  #$DE,($26,A3)
            move.w  ($1A,A6),($28,A3)
            moveq   #0,D0
            move.l  D0,($C,A3)
            subq.l  #2,SP
            pea     ($38,A4)
            move.b  ($1F,A6),-(SP)
            jsr     sub_408564FC
            move.w  (SP)+,D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
.L1:
            dc.w    $012A,0
sub_40852B84:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            lea     ($3E,A3),A0
            movea.l A4,A1
            moveq   #9,D0
.L1:
            move.l  (A1)+,(A0)+
            dbra    D0,.L1
            move.w  (A1)+,(A0)+
            movem.l (SP)+,A3-A4
            rts
sub_40852BB8:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.l ($14,SP),A3
            lea     .L1,A4
            moveq   #$F,D0
            and.w   D7,D0
            ext.l   D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(1,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #4,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(2,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #8,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(3,A3)
            ext.l   D7
            moveq   #$C,D0
            move.l  D7,D1
            asr.l   D0,D1
            moveq   #$F,D0
            and.l   D1,D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(4,A3)
            move.b  #4,(A3)
            movem.l (SP)+,D7/A3-A4
            rts
.L1:
            dc.b    '0123456789ABCDEF'
            dc.w    0
sub_40852C2A:
            link.w  A6,#-$23E
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($1C,A6),A3
            moveq   #0,D0
            movea.l D0,A4
            moveq   #1,D5
            move.w  #$FFFF,(-$16E,A6)
            move.b  #$FF,(-$16C,A6)
            move.b  #$FF,(-$16B,A6)
            move.l  A3,D1
            beq.w   .L6
            move.w  #$FFFF,(A3)
            pea     (-$100,A6)
            moveq   #0,D0
            move.w  ($16,A6),D0
            move.l  D0,-(SP)
            jsr     sub_40852BB8
            pea     (-$23A,A6)
            move.l  ($18,A6),-(SP)
            jsr     sub_40852B84
            subq.l  #4,SP
            pea     ($DE).w
            jsr     sub_40856442
            movea.l (SP)+,A4
            move.l  A4,D0
            lea     ($10,SP),SP
            beq.w   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L2
            moveq   #0,D0
            move.b  ($F,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #1,D1
            move.l  D1,-(SP)
            pea     (-$1D2,A6)
            move.l  A4,-(SP)
            pea     (-$100,A6)
            move.l  ($10,A6),-(SP)
            jsr     sub_40852B1C
            tst.w   D0
            lea     ($20,SP),SP
            bne.w   .L6
            bra.b   .L2
.L1:
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     sub_40852AD2
            addq.l  #8,SP
.L2:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L3
            cmp.w   (-$170,A6),D5
            bgt.b   .L3
            subq.l  #2,SP
            move.l  A4,-(SP)
            move.w  (-$170,A6),-(SP)
            move.w  D5,-(SP)
            addq.w  #1,D5
            pea     (-$16A,A6)
            pea     (-$104,A6)
            jsr     NBPExtract
            move.w  (SP)+,(-$19C,A6)
            beq.b   .L1
.L3:
            tst.w   (-$170,A6)
            ble.b   .L6
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D6
            move.b  ($B,A6),D0
            lsl.b   #4,D0
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D7
            move.l  D6,D4
            move.l  D7,D0
            lsl.l   #2,D0
            move.l  D0,(-$23E,A6)
            bra.b   .L5
.L4:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D4,D0
            cmp.l   D0,D7
            bcc.b   .L5
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D4
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     sub_40852AD2
            addq.l  #8,SP
.L5:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D6,D0
            cmp.l   (-$23E,A6),D0
            bcc.b   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L4
.L6:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L7
            move.l  ($26,A3),(-$16E,A6)
.L7:
            move.l  A4,D0
            beq.b   .L8
            move.l  A4,-(SP)
            jsr     sub_4085645A
.L8:
            move.l  (-$16E,A6),D0
            movem.l (-$256,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40852D92:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l ($C,A6),A3
            move.w  ($30,A3),D0
            cmp.w   (2,A3),D0
            bne.b   .L3
            tst.w   ($3A,A3)
            bne.b   .L3
            move.w  ($38,A3),(A3)
            move.l  (8,A6),($26,A3)
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   ($32,A3),D0
            lsl.l   #2,D0
            move.w  D0,($1E,A3)
            moveq   #4,D0
            cmp.w   ($1E,A3),D0
            ble.b   .L1
            moveq   #4,D0
            bra.b   .L2
.L1:
            move.w  ($1E,A3),D0
            ext.l   D0
.L2:
            move.w  D0,($1E,A3)
.L3:
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_40852DE4:
            link.w  A6,#0
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            tst.l   ($C,A6)
            bne.b   .L2
            tst.l   ($22,A3)
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,($22,A3)
.L1:
            move.l  D7,($16,A3)
            addq.w  #1,($A,A3)
.L2:
            move.l  D7,($12,A3)
            movem.l (-8,A6),D7/A3
            unlk    A6
            rts
sub_40852E1E:
            movem.l D5-D7/A3-A4,-(SP)
            movea.l ($1C,SP),A4
            movea.l ($18,SP),A3
            clr.w   D5
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            move.b  #3,($3E,A3)
            move.b  #1,($3F,A3)
            move.w  (A4),($40,A3)
            clr.b   ($42,A3)
            clr.b   ($43,A3)
            moveq   #0,D0
            move.w  (8,A4),D0
            divs.w  #8,D0
            move.w  D0,D6
            moveq   #0,D0
            move.w  (8,A4),D0
            move.l  D0,D5
            lsr.l   #3,D5
            beq.b   .L1
            addq.w  #1,D6
.L1:
            clr.w   D7
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.w  D7,D0
            move.b  #$FF,($46,A3,D0.l)
            addq.w  #1,D7
.L3:
            cmp.w   D7,D6
            bhi.b   .L2
            tst.w   D5
            beq.b   .L4
            move.w  D6,D0
            subq.w  #1,D0
            moveq   #0,D1
            move.w  D0,D1
            move.b  #$FF,($46,A3,D1.l)
.L4:
            movem.l (SP)+,D5-D7/A3-A4
            rts
sub_40852E9C:
            movem.l D6-D7/A3-A4,-(SP)
            move.w  ($1E,SP),D6
            movea.l ($18,SP),A4
            movea.l ($14,SP),A3
            ext.l   D6
            move.l  D6,D0
            divs.w  #8,D0
            move.w  D0,D7
            bra.b   .L2
.L1:
            move.b  (A3)+,D0
            not.b   D0
            move.b  D0,(A4)+
.L2:
            move.w  D7,D0
            subq.w  #1,D7
            tst.w   D0
            bne.b   .L1
            ext.l   D6
            move.l  D6,D0
            asr.l   #3,D0
            beq.b   .L3
            move.b  (A3),D0
            not.b   D0
            move.b  D0,(A4)
.L3:
            movem.l (SP)+,D6-D7/A3-A4
            rts
sub_40852EDA:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l (8,A6),A3
            pea     ($2C,A3)
            pea     (-$12,A6)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.w  (8,A4),D1
            move.l  D1,D0
            moveq   #8,D1
            jsr     sub_40856390
            addq.l  #8,D0
            moveq   #0,D1
            move.w  (8,A4),D1
            lsr.l   #3,D1
            beq.b   .L1
            moveq   #1,D1
            bra.b   .L2
.L1:
            moveq   #0,D1
.L2:
            add.l   D0,D1
            move.w  D1,-(SP)
            jsr     sub_408565D0
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     sub_408564EC
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
sub_40852F3E:
            link.w  A6,#-$80C
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            move.l  (8,A6),D5
            lea     (-$344,A6),A3
            clr.w   (-$592,A6)
            moveq   #0,D4
            pea     ($140).w
            moveq   #0,D0
            move.l  D0,-(SP)
            pea     (-$140,A6)
            jsr     sub_40856A9E
            jsr     sub_40852756
            move.l  D0,(-$144,A6)
            pea     (-$140,A6)
            jsr     sub_4085296E
            move.w  #$FFFF,(-$80C,A6)
            move.w  #1,(-$80A,A6)
            move.l  A3,(-$808,A6)
            clr.w   (-$804,A6)
            clr.w   (-$802,A6)
            moveq   #0,D0
            move.l  D0,(-$800,A6)
            clr.w   (-$7FC,A6)
            move.l  D0,(-$7FA,A6)
            move.l  D0,(-$7F6,A6)
            move.l  D5,D1
            asr.l   #3,D1
            move.l  D1,(-$7F2,A6)
            move.w  #4,(-$7EE,A6)
            move.w  #1,(-$7EC,A6)
            move.l  D0,(-$7EA,A6)
            moveq   #-1,D1
            move.l  D1,(-$7E6,A6)
            pea     (-$80C,A6)
            jsr     sub_40853292
            subq.l  #2,SP
            jsr     MPPOpen_piMAIN
            move.w  (SP)+,(-$594,A6)
            lea     ($14,SP),SP
            beq.b   .L1
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L1:
            tst.b   ($17,A6)
            beq.b   .L2
            moveq   #$F,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            asl.w   #2,D1
            move.b  D1,(-$58C,A6)
            move.w  #$F0,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            lsr.l   #4,D1
            move.b  D1,(-$58B,A6)
            bra.b   .L3
.L2:
            move.b  #4,(-$58C,A6)
            move.b  #1,(-$58B,A6)
.L3:
            move.w  #$A,(-$592,A6)
            subq.l  #2,SP
            pea     (-$592,A6)
            pea     sub_4085329A
            jsr     DDPOpenSocket
            move.w  (SP)+,(-$594,A6)
            beq.b   .L4
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L4:
            move.b  #1,(A4)
            move.b  #1,(1,A4)
            moveq   #0,D0
            move.l  D0,(4,A4)
            move.w  #$FFFF,(-$590,A6)
            move.b  #$FF,(-$58E,A6)
            move.b  #$FF,(-$58D,A6)
            pea     (-$80C,A6)
            move.l  A4,-(SP)
            moveq   #0,D1
            move.w  ($E,A6),D1
            move.l  D1,-(SP)
            pea     sub_40853286
            moveq   #0,D1
            move.b  (-$58B,A6),D1
            move.l  D1,-(SP)
            moveq   #0,D1
            move.b  (-$58C,A6),D1
            move.l  D1,-(SP)
            jsr     sub_40852C2A
            move.l  D0,(-$590,A6)
            moveq   #0,D0
            move.w  (-$80C,A6),D0
            cmpi.l  #$FFFF,D0
            lea     ($18,SP),SP
            beq.w   .L15
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            beq.w   .L15
            move.w  (-$7D6,A6),(-$7FC,A6)
            move.l  (-$7D0,A6),D0
            subq.l  #1,D0
            move.w  D0,(-$804,A6)
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     sub_40856390
            cmpi.l  #$1FF,D0
            bge.b   .L5
            move.w  (-$7FC,A6),D0
            mulu.w  (-$804,A6),D0
            move.l  D0,-(SP)
            move.l  BufPtr,D0
            moveq   #4,D1
            jsr     sub_40856390
            move.l  D0,D1
            move.l  (SP)+,D0
            cmp.l   D0,D1
            bcc.b   .L6
.L5:
            moveq   #-2,D4
            bra.w   .L16
.L6:
            subq.l  #4,SP
            moveq   #0,D0
            move.w  (-$7D6,A6),D0
            move.l  D0,D1
            move.l  (-$7D0,A6),D0
            jsr     sub_40856368
            move.l  D0,-(SP)
            jsr     sub_40856442
            move.l  (SP)+,(-$800,A6)
            bne.b   .L7
            moveq   #-2,D4
            bra.w   .L16
.L7:
            pea     (-$80C,A6)
            pea     (-$58A,A6)
            jsr     sub_40852E1E
            clr.w   D6
            addq.l  #8,SP
            bra.b   .L9
.L8:
            clr.b   (0,A3,D6.w)
            addq.w  #1,D6
.L9:
            ext.l   D6
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     sub_40856390
            addq.l  #1,D0
            cmp.l   D6,D0
            bgt.b   .L8
            bra.w   .L14
.L10:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            moveq   #0,D0
            move.w  (-$802,A6),D0
            move.l  D0,D1
            add.l   D0,D0
            add.l   D1,D0
            moveq   #0,D1
            move.w  (-$804,A6),D1
            jsr     sub_40856390
            move.w  (-2,A6),D1
            ext.l   D1
            cmp.l   D0,D1
            bgt.b   .L11
            pea     (-$140,A6)
            jsr     sub_40852A92
            addq.l  #4,SP
.L11:
            move.l  D7,D0
            sub.l   (-$7FA,A6),D0
            cmp.l   (-$7F2,A6),D0
            bgt.b   .L12
            move.l  D7,D0
            sub.l   (-$7F6,A6),D0
            move.l  (-$7F2,A6),D2
            move.l  D2,D1
            mulu.w  #$32,D2
            swap    D1
            mulu.w  #$32,D1
            swap    D1
            clr.w   D1
            add.l   D1,D2
            cmp.l   D0,D2
            bge.b   .L14
.L12:
            tst.l   (-$7EA,A6)
            beq.b   .L13
            move.w  (-$7EC,A6),D0
            add.w   D0,(-$7EC,A6)
            move.w  (-$7EE,A6),D0
            muls.w  (-$7EC,A6),D0
            move.l  D0,(-$7F2,A6)
.L13:
            moveq   #0,D0
            move.w  (-$804,A6),D0
            move.l  D0,-(SP)
            pea     (-$544,A6)
            move.l  A3,-(SP)
            jsr     sub_40852E9C
            move.l  D7,(-$7EA,A6)
            move.l  D7,(-$7F6,A6)
            move.l  D7,(-$7FA,A6)
            pea     (-$80C,A6)
            move.l  (-$590,A6),-(SP)
            pea     (-$58A,A6)
            jsr     sub_40852EDA
            lea     ($18,SP),SP
.L14:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L16
            cmp.l   (-$7F2,A6),D5
            bgt.w   .L10
            bra.b   .L16
.L15:
            moveq   #-3,D4
.L16:
            pea     (-$140,A6)
            jsr     sub_4085298E
            move.l  (-$144,A6),-(SP)
            jsr     sub_4085275A
            tst.w   (-$592,A6)
            addq.l  #8,SP
            beq.b   .L17
            subq.l  #2,SP
            move.w  (-$592,A6),-(SP)
            jsr     DDPCloseSocket
            move.w  (SP)+,(-$594,A6)
.L17:
            tst.l   (-$800,A6)
            beq.b   .L18
            tst.l   D4
            beq.b   .L18
            move.l  (-$800,A6),-(SP)
            jsr     sub_4085645A
            bra.b   .L19
.L18:
            movea.l ($18,A6),A0
            move.l  (-$800,A6),(A0)
.L19:
            tst.l   D4
            beq.b   .L20
            move.l  D4,D0
            bra.b   .L23
.L20:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L21
            moveq   #-4,D0
            bra.b   .L23
.L21:
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            bne.b   .L22
            moveq   #-3,D0
            bra.b   .L23
.L22:
            movea.l ($1C,A6),A0
            move.l  (-$590,A6),(A0)
            pea     (-$7DE,A6)
            move.l  ($20,A6),-(SP)
            pea     ($24A).w
            jsr     sub_40856478
            move.l  D4,D0
.L23:
            movem.l (-$824,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40853286:
            eori.w  #$6F6F,D2
            moveq   #$53,D2
            bcs.b   sub_4085329A.L3
            moveq   #$65,D3
            moveq   #0,D1
sub_40853292:
            movea.l (SP)+,A0
            move.l  (SP)+,($B50).w
            jmp     (A0)
sub_4085329A:
            movem.l D4-D7,-(SP)
            cmpi.b  #$A,(-1,A3)
            bne.b   .L4
            cmpi.w  #6,D1
            bmi.b   .L4
            movea.l ($B50).w,A5
            cmpi.b  #1,(3,A2)
            bne.b   .L1
            move.b  (2,A2),D2
            swap    D2
            move.w  ($1A,A2),D2
            bra.b   .L2
.L1:
            move.b  (-4,A3),D2
            swap    D2
            move.w  (-7,A3),D2
.L2:
            swap    D2
            lsl.w   #8,D2
            move.b  (-2,A3),D2
            moveq   #6,D3
            suba.l  D3,SP
            movea.l SP,A3
            jsr     (A4)
            move.w  (SP)+,D0
            move.l  (SP)+,D5
            swap    D5
            tst.w   D3
            bne.w   .L7
            move.b  D0,D3
            cmpi.b  #1,D3
            bgt.b   .L4
            lsr.w   #8,D0
            cmpi.b  #4,D0
            bne.b   .L6
            cmp.l   ($26,A5),D2
            bne.b   .L4
.L3:
            cmp.w   (A5),D5
            bne.b   .L4
            swap    D5
            cmp.w   (8,A5),D5
            bgt.b   .L4
            movea.l (4,A5),A3
            move.l  A3,D6
            move.w  D5,D0
            bsr.w   sub_408533A6
            beq.b   .L5
            moveq   #-1,D0
            move.l  A5,D7
            jsr     sub_40853398
.L4:
            movem.l (SP)+,D4-D7
            moveq   #0,D3
            jmp     (2,A4)
.L5:
            move.l  ($C,A5),D0
            beq.b   .L4
            movea.l D0,A3
            move.w  D5,D0
            bsr.w   sub_408533C2
            move.w  ($10,A5),D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            tst.w   D3
            bgt.b   .L7
            movea.l D6,A0
            move.w  D5,D0
            jsr     sub_408533B8
            moveq   #0,D0
            jsr     sub_40853398
            bra.b   .L7
.L6:
            cmpi.b  #7,D0
            beq.b   .L7
            cmpi.w  #$FFFF,(A5)
            bne.b   .L4
            cmpi.b  #2,D0
            bne.b   .L4
            lea     ($2E,A5),A3
            move.b  D0,(A3)+
            move.b  D3,(A3)+
            swap    D5
            move.l  D5,(A3)+
            move.l  #$24A,D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            move.l  D7,-(SP)
            move.l  D2,-(SP)
            jsr     sub_40852D92
            lea     (8,SP),SP
.L7:
            movem.l (SP)+,D4-D7
            rts
sub_40853398:
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     sub_40852DE4
            lea     (8,SP),SP
            rts
sub_408533A6:
            movem.l D1,-(SP)
            move.w  D0,D1
            lsr.w   #3,D0
            btst    D1,(0,A3,D0.w)
            movem.l (SP)+,D1
            rts
sub_408533B8:
            move.w  D0,D1
            lsr.w   #3,D0
            bset    D1,(0,A0,D0.w)
            rts
sub_408533C2:
            move.l  D0,-(SP)
            mulu.w  ($10,A5),D0
            adda.l  D0,A3
            move.l  (SP)+,D0
            rts
sub_408533CE:
            link.w  A6,#-$34
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($C,A6),A0
            move.l  (A0),(-$34,A6)
            movea.l ($C,A6),A0
            move.l  (4,A0),(-$30,A6)
            movea.l ($C,A6),A0
            move.l  (8,A0),(-$2C,A6)
            movea.l ($C,A6),A0
            move.l  ($C,A0),(-$28,A6)
            movea.l ($C,A6),A0
            move.l  ($10,A0),(-$24,A6)
            movea.l ($C,A6),A0
            move.l  ($14,A0),(-$20,A6)
            movea.l ($C,A6),A0
            move.l  ($18,A0),(-$1C,A6)
            movea.l ($C,A6),A0
            move.l  ($1C,A0),(-$18,A6)
            movea.l ($C,A6),A0
            move.l  ($20,A0),(-$14,A6)
            movea.l ($C,A6),A0
            move.l  ($24,A0),(-$10,A6)
            movea.l ($C,A6),A0
            move.l  ($28,A0),(-$C,A6)
            movea.l ($C,A6),A0
            move.l  ($2C,A0),(-8,A6)
            movea.l ($C,A6),A0
            move.l  ($30,A0),D4
            movea.l ($C,A6),A0
            move.l  ($34,A0),D5
            movea.l ($C,A6),A0
            move.l  ($38,A0),D6
            movea.l ($C,A6),A0
            move.l  ($3C,A0),(-4,A6)
            move.l  ($10,A6),D0
            eor.l   D0,(-$34,A6)
            move.l  ($14,A6),D0
            eor.l   D0,(-$30,A6)
            move.l  ($18,A6),D0
            eor.l   D0,(-$2C,A6)
            movea.l ($1C,A6),A0
            lea     (A0),A3
            movea.l A3,A4
            adda.l  #$400,A4
            move.l  #$FF,D0
            and.l   (-$34,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            move.l  #$FF,D0
            and.l   (-$30,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            move.l  #$FF,D0
            and.l   (-$2C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            move.l  #$FF,D0
            and.l   (-$28,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            move.l  #$FF,D0
            and.l   (-$24,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            move.l  #$FF,D0
            and.l   (-$20,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            move.l  #$FF,D0
            and.l   (-$1C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            move.l  #$FF,D0
            and.l   (-$18,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            move.l  #$FF,D0
            and.l   (-$14,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            move.l  #$FF,D0
            and.l   (-$10,A6),D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            move.l  #$FF,D0
            and.l   (-$C,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            move.l  #$FF,D0
            and.l   (-8,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            move.l  #$FF,D0
            and.l   D4,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            move.l  #$FF,D0
            and.l   D5,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            move.l  #$FF,D0
            and.l   D6,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            move.l  #$FF,D0
            and.l   (-4,A6),D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            adda.w  #$4000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            moveq   #$10,D0
            move.l  (-$34,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            moveq   #$10,D0
            move.l  (-$30,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            moveq   #$10,D0
            move.l  (-$2C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            moveq   #$10,D0
            move.l  (-$28,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            moveq   #$10,D0
            move.l  (-$24,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            moveq   #$10,D0
            move.l  (-$20,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            moveq   #$10,D0
            move.l  (-$1C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            moveq   #$10,D0
            move.l  (-$18,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            moveq   #$10,D0
            move.l  (-$14,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            moveq   #$10,D0
            move.l  (-$10,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            moveq   #$10,D0
            move.l  (-$C,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            moveq   #$10,D0
            move.l  (-8,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            moveq   #$10,D0
            move.l  D4,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            moveq   #$10,D0
            move.l  D5,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A3,D0.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            moveq   #$10,D0
            move.l  D6,D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            moveq   #$10,D0
            move.l  (-4,A6),D1
            lsr.l   D0,D1
            move.l  #$FF,D0
            and.l   D1,D0
            asl.l   #2,D0
            move.l  (0,A4,D0.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            suba.w  #$2000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            moveq   #$18,D0
            move.l  (-$34,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            moveq   #$18,D0
            move.l  (-$30,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            moveq   #$18,D0
            move.l  (-$2C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$28,A6)
            eor.l   D7,(-$30,A6)
            moveq   #$18,D0
            move.l  (-$28,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$24,A6)
            eor.l   D7,(-$2C,A6)
            moveq   #$18,D0
            move.l  (-$24,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$20,A6)
            eor.l   D7,(-$28,A6)
            moveq   #$18,D0
            move.l  (-$20,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$1C,A6)
            eor.l   D7,(-$24,A6)
            moveq   #$18,D0
            move.l  (-$1C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$18,A6)
            eor.l   D7,(-$20,A6)
            moveq   #$18,D0
            move.l  (-$18,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$14,A6)
            eor.l   D7,(-$1C,A6)
            moveq   #$18,D0
            move.l  (-$14,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$10,A6)
            eor.l   D7,(-$18,A6)
            moveq   #$18,D0
            move.l  (-$10,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$C,A6)
            eor.l   D7,(-$14,A6)
            moveq   #$18,D0
            move.l  (-$C,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-8,A6)
            eor.l   D7,(-$10,A6)
            moveq   #$18,D0
            move.l  (-8,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D4
            eor.l   D7,(-$C,A6)
            moveq   #$18,D0
            move.l  D4,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D5
            eor.l   D7,(-8,A6)
            moveq   #$18,D0
            move.l  D5,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            moveq   #$18,D0
            move.l  D6,D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            moveq   #$18,D0
            move.l  (-4,A6),D1
            lsr.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$34,A6)
            eor.l   D7,D6
            adda.w  #$4000,A3
            movea.l A3,A4
            adda.l  #$400,A4
            move.l  (-$34,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$30,A6)
            eor.l   D7,(-4,A6)
            move.l  (-$30,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$2C,A6)
            eor.l   D7,(-$34,A6)
            move.l  (-$2C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$28,A6)
            move.l  (-$28,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$24,A6)
            move.l  (-$24,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$20,A6)
            move.l  (-$20,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$1C,A6)
            move.l  (-$1C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$18,A6)
            move.l  (-$18,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-$14,A6)
            move.l  (-$14,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$10,A6)
            move.l  (-$10,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,(-$C,A6)
            move.l  (-$C,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-8,A6)
            move.l  (-8,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D4
            move.l  D4,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D5
            move.l  D5,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A3,D1.l),D7
            eor.l   D7,D6
            eor.l   D7,D4
            move.l  D6,D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,(-4,A6)
            eor.l   D7,D5
            move.l  (-4,A6),D0
            lsr.l   #8,D0
            move.l  #$FF,D1
            and.l   D0,D1
            asl.l   #2,D1
            move.l  (0,A4,D1.l),D7
            eor.l   D7,D6
            move.l  ($10,A6),D0
            eor.l   D0,D6
            move.l  ($14,A6),D0
            eor.l   D0,D5
            move.l  ($18,A6),D0
            eor.l   D0,D4
            movea.l ($C,A6),A0
            move.l  (-4,A6),D0
            move.l  (A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(A0)
            movea.l ($C,A6),A0
            move.l  D6,D0
            move.l  (4,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(4,A0)
            movea.l ($C,A6),A0
            move.l  D5,D0
            move.l  (8,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,(8,A0)
            movea.l ($C,A6),A0
            move.l  D4,D0
            move.l  ($C,A0),D1
            eor.l   D0,D1
            movea.l (8,A6),A0
            move.l  D1,($C,A0)
            movem.l (-$4C,A6),D4-D7/A3-A4
            unlk    A6
            rts
sub_40853B2A:
            link.w  A6,#0
            movem.l D3-D7/A3-A4,-(SP)
            subq.l  #4,SP
            move.l  #$8000,-(SP)
            jsr     sub_40856436
            movea.l ($C,A6),A0
            move.l  (SP)+,(A0)
            movea.l ($C,A6),A0
            tst.l   (A0)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.w   .L7
.L1:
            moveq   #0,D4
            moveq   #8,D3
.L2:
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A4
            clr.w   D7
            move.w  #$100,D2
.L3:
            move.l  (A3)+,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L3
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($2000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #$18,D5
            moveq   #8,D6
            clr.w   D7
            move.w  #$100,D2
.L4:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L4
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($4000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #$10,D6
            move.b  D6,D5
            clr.w   D7
            move.w  #$100,D2
.L5:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L5
            movea.l (8,A6),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     (0,A0,D0.l),A3
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.l  D4,D0
            move.l  D0,D1
            mulu.w  #$400,D0
            swap    D1
            mulu.w  #$400,D1
            swap    D1
            clr.w   D1
            add.l   D1,D0
            lea     ($6000,A0),A0
            lea     (0,A0,D0.l),A4
            moveq   #8,D5
            moveq   #$18,D6
            clr.w   D7
            move.w  #$100,D2
.L6:
            move.l  (A3),D0
            lsr.l   D6,D0
            move.l  (A3)+,D1
            lsl.l   D5,D1
            or.l    D0,D1
            move.l  D1,(A4)+
            addq.w  #1,D7
            cmp.w   D7,D2
            bgt.b   .L6
            addq.l  #1,D4
            cmp.l   D4,D3
            bgt.w   .L2
            moveq   #0,D0
.L7:
            movem.l (-$1C,A6),D3-D7/A3-A4
            unlk    A6
            rts
sub_40853CC6:
            link.w  A6,#-$40
            movem.l D3-D7/A3-A4,-(SP)
            movea.l ($C,A6),A4
            lea     (-$40,A6),A3
            move.l  ($18,A6),D4
            moveq   #0,D4
            moveq   #0,D5
            move.l  ($18,A6),D0
            asl.l   #3,D0
            move.l  D0,D6
            move.l  #$FFFFFC0,D0
            and.l   ($18,A6),D0
            move.l  D0,($18,A6)
            tst.l   (A4)
            bne.b   .L1
            move.l  A4,-(SP)
            move.l  (8,A6),-(SP)
            jsr     sub_40853B2A
            move.w  D0,D7
            addq.l  #8,SP
            beq.b   .L1
            move.w  D7,D0
            bra.w   .L5
.L1:
            moveq   #0,D7
            moveq   #$10,D3
.L2:
            move.l  D7,D0
            asl.w   #2,D0
            moveq   #0,D1
            move.l  D1,(0,A3,D0.w)
            addq.l  #1,D7
            cmp.l   D7,D3
            bgt.b   .L2
            moveq   #0,D7
.L3:
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  ($10,A6),-(SP)
            move.l  D7,D0
            asl.w   #2,D0
            pea     (0,A3,D0.w)
            jsr     sub_408533CE
            addq.l  #1,D6
            subi.l  #$40,($18,A6)
            addi.l  #$40,($10,A6)
            addq.l  #4,D7
            moveq   #$10,D0
            cmp.l   D7,D0
            lea     ($18,SP),SP
            bgt.b   .L4
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408533CE
            moveq   #4,D7
            addq.l  #1,D6
            lea     ($18,SP),SP
.L4:
            tst.l   ($18,A6)
            bhi.b   .L3
            move.l  (A4),-(SP)
            move.l  D6,-(SP)
            move.l  D5,-(SP)
            move.l  D4,-(SP)
            move.l  A3,-(SP)
            move.l  ($14,A6),-(SP)
            jsr     sub_408533CE
            moveq   #0,D0
            lea     ($18,SP),SP
.L5:
            movem.l (-$5C,A6),D3-D7/A3-A4
            unlk    A6
            rts
sub_40853D9A:
            lea     .L1,A0
            move.l  A0,D0
            rts
.L1:
            dc.w    $64F9,$001B,$FEDD,$CDF6,$7C8F,$F1E2,$11D7,$1514
            dc.w    $8B8C,$18D3,$DDDF,$881E,$6EAB,$5056,$88CE,$D8E1
            dc.b    $49,$14,$89,$59,$69,$C5,$6F,$D5,$B7,$99,$4F,$03,$0F,$BC,$EE
            dc.b    '><&I@!U~X'
            dc.w    $E14B,$3FC2,$2E5C,$F591,$DCEF,$F8CE,$092A,$1648
            dc.w    $BE81,$2936,$FF7B,$0C6A,$D525,$1037,$AFA4,$48F1
            dc.w    $7DAF,$C95A,$1EA6,$9C3F,$A417,$ABE7,$5890,$E423
            dc.w    $B0CB,$70C0,$C850,$25F7,$244D,$97E3,$1FF3,$595F
            dc.w    $C4EC,$6396,$5918,$1E17,$E635,$B477,$354E,$7DBF
            dc.w    $796F,$7753,$66EB,$52CC,$77C3,$F995,$32E3,$A927
            dc.w    $80CC,$AED6,$4E2B,$E89D,$375B,$BD28,$AD1A,$3D05
            dc.w    $2B1B,$42B3,$16C4,$4C71,$4D54,$BFA8,$E57D,$DC7A
            dc.w    $EC6D,$8144,$5A71,$046B,$D822,$9650,$87FC,$8F24
            dc.w    $CBC6,$0E09,$B639,$0366,$D9F7,$6092,$D393,$A70B
            dc.w    $1D31,$A08A,$9CD9,$71C9,$5C1E,$F445,$86FA,$B694
            dc.w    $FDB4,$4165,$8EAA,$FCBE,$4BCA,$C6EB,$FB7A,$94E5
            dc.w    $5789,$D04E,$FA13,$CF35,$236B,$8DA9,$4133,$F000
            dc.w    $6224,$261C,$F412,$F23B,$E75E,$56A4,$3002,$2116
            dc.w    $BAF1,$7F1F,$D098,$72F9,$C1A3,$699C,$F1E8,$02AA
            dc.w    $0DD1,$45DC,$4FDC,$E093,$8D84,$12F0,$6CD0,$F376
            dc.w    $3DE6,$B73D,$84BA,$737F,$B43A,$30F2,$4456,$9F69
            dc.w    $00E4,$EACA,$B58D,$E3B0,$9591,$13C8,$D62E,$FEE9
            dc.w    $9086,$1F83,$CED6,$9874,$2F79,$3CEE,$E857,$1C30
            dc.w    $4836,$65D1,$AB07,$B031,$914C,$844F,$15BF,$3BE8
            dc.w    $2C3F,$2A9A,$9EB9,$5FD4,$92E7,$472D,$2297,$CC5B
            dc.w    $EE5F,$2782,$5377,$B562,$DB8E,$BBCF,$F961,$DEDD
            dc.w    $C59B,$5C60,$1BD3,$910D,$26D2,$06AD,$B285,$14D8
            dc.w    $5ECF,$6B52,$7FEA,$78BB,$5048,$79AC,$ED34,$A884
            dc.w    $36E5,$1D3C,$1753,$741D,$8C47,$CAED,$9D0A,$40EF
            dc.w    $3145,$E221,$DA27,$EB70,$DF73,$0BA3,$183C,$8789
            dc.w    $739A,$C0A6,$9A58,$DFC6,$54B1,$34C1,$AC3E,$242E
            dc.w    $CC49,$3902,$7B2D,$DA99,$8F15,$BC01,$29FD,$38C7
            dc.w    $27D5,$318F,$604A,$AFF5,$F29C,$6818,$C38A,$A2EC
            dc.w    $1019,$D4C3,$A8FB,$936E,$20ED,$7B39,$0B68,$6119
            dc.w    $89A0,$906F,$1CC7,$829E,$9952,$EF4B,$850E,$9E8C
            dc.w    $CD06,$3A90,$6700,$2F8E,$CFAC,$8CB7,$EAA2,$4B11
            dc.w    $988B,$4E6C,$46F0,$66DF,$CA7E,$EC08,$C7BB,$A664
            dc.w    $831D,$17BD,$63F5,$75E6,$9764,$350E,$4787,$0D42
            dc.w    $026C,$A4A2,$8167,$D587,$61B6,$ADAB,$AA65,$64D2
            dc.w    $70DA,$237B,$25E1,$C74A,$A1C9,$01A0,$0EB0,$A5DA
            dc.w    $7670,$F741,$51C0,$5AEA,$933D,$FA32,$0759,$FF1A
            dc.w    $5601,$0AB8,$5FDE,$CB78,$3F32,$EDF8,$AEBE,$DBB9
            dc.w    $39F8,$326D,$D208,$58C5,$9B63,$8BE4,$A572,$C80A
            dc.w    $28E0,$A19F,$4320,$99FC,$3A37,$C3CD,$BF95,$C585
            dc.w    $B392,$C12A,$6AA7,$07D7,$52F6,$6A61,$12D4,$83B1
            dc.w    $9643,$5B5E,$3E75,$802B,$3BA5,$2B33,$A99F,$51A5
            dc.w    $BDA1,$E157,$78C2,$E70C,$FCAE,$7CE0,$D160,$2267
            dc.w    $2AFF,$AC4D,$4A51,$0947,$0AB2,$B83A,$7A04,$E579
            dc.w    $340D,$FD80,$B916,$E922,$E29D,$5E9B,$F562,$4AF4
            dc.w    $4CA9,$D9AF,$6BBD,$2CFE,$E3B7,$F620,$C274,$6E07
            dc.w    $5B42,$B9B6,$A069,$19BC,$F0F2,$C40F,$7221,$7AB5
            dc.w    $14C1,$9DF3,$F380,$2DAE,$E094,$BEB4,$A210,$1AFF
            dc.w    $0529,$575D,$55CD,$B27C,$A33B,$DDB2,$6528,$B37D
            dc.w    $740C,$05DB,$E96A,$62C4
            dc.b    '@x(Fm0'
            dc.w    $D706,$BBF4,$8E2C,$BCE2,$D3DE,$049E,$37FA,$01B5
            dc.w    $E634,$2D88,$6D8D,$7E5A,$2E7E,$D741,$2013,$06E9
            dc.w    $0F97,$E45D,$3EBA,$B8AD,$3386,$1305,$1B25,$0C03
            dc.w    $5354,$71C8,$9B75,$C638,$FBD0,$197F,$11A1,$EF0F
            dc.b    $08,$FB,$F8,$44,$86,$51,$38,$40,$95
            dc.b    'cE/DC]FMU'
            dc.w    $03D8,$764C,$B1B8,$D638,$A70B,$BA2F,$94B3,$D210
            dc.w    $EB66,$92A7,$D409,$C2D9,$6883,$8526,$A6DB,$8A15
            dc.w    $751F,$6C98,$DE76,$9A88,$C9EE,$4668,$1A82,$A373
            dc.w    $0896,$AA49,$4223,$3681,$F62C,$55CB,$9F1C,$5404
            dc.w    $F74F,$B15C,$C06E,$4312,$6FFE,$5D72,$8AA8,$678B
            dc.w    $337C,$D129,$8211,$CEFD,$61B0,$B02F,$00E2,$7716
            dc.w    $BF32,$D884,$6FA3,$56FF,$3584
            dc.b    $27,' T`rax('
            dc.w    $C5AE,$2942,$11CF,$4E81,$528B,$DD54,$57A7,$0D9D
            dc.w    $32BE,$AF55,$B23F,$3F86,$99A0,$DBB4,$AF42,$D744
            dc.w    $DC65,$0C93,$ECF0,$E359,$680B,$046D,$F2EF,$1BF2
            dc.w    $4487,$5951,$46D2,$8BDF,$D42B,$2B0D,$38EA,$AC18
            dc.w    $A09F,$73AF,$8D78,$68AE,$BA06,$C5FF,$A500,$8DB3
            dc.w    $6B2D,$A040,$D9B7,$8583,$C012,$B5FC,$22E3,$2397
            dc.w    $14D5,$A795,$C69A,$B43F,$BCDB,$628D,$4AE0,$187A
            dc.w    $5941,$A949,$1C34,$77CB,$9482,$1453,$0C67,$478A
            dc.w    $1253,$754A,$E323,$7EA8,$C1E7,$9087,$BFAF,$D219
            dc.w    $BBE5,$6085,$00CB,$3E69,$40A4,$3B7D,$5F5B,$B95E
            dc.w    $86F7,$08CD,$C2E1,$02F7,$AD77,$40B5,$DAF1,$8E72
            dc.w    $5492,$740F,$A82C,$3094,$F8E8,$C925,$810A,$89FA
            dc.w    $96C6,$7C43,$75D1,$2F36,$B383,$A461,$C74F,$4426
            dc.w    $906D,$2009,$3EDA,$2C41,$DFD8,$D8E0,$6097,$D08B
            dc.w    $1A03,$5EBB,$EA72,$AD56,$0825,$795B,$1388,$7D6F
            dc.w    $4DFE,$E7D9,$F74E,$EC89,$19A1,$82F0,$B55F,$0B70
            dc.w    $FCD4,$C433,$D7C7,$0305,$C3B8,$9CCC,$826E,$9B0A
            dc.w    $5848,$B3A4,$7130,$633D,$24ED,$3DDC,$E217,$B837
            dc.w    $6E76,$0139,$FDAC,$5CA2,$3769,$6BBE,$5B59,$883B
            dc.w    $AEBB,$21D6,$E605,$53B6,$23CD,$F5F1,$CB80,$4ACF
            dc.w    $04C2,$4C3A,$91B4,$DA45,$E998,$B15F,$7B24,$57A7
            dc.w    $4CBC,$674E,$0B1D,$B0D1,$8A3D,$E9D0,$677B,$382F
            dc.w    $9DC0,$3403,$1701,$1A9B,$1B02,$E5DE,$7DA9,$33C4
            dc.w    $A173,$4D1B,$8B0F
            dc.b    '7n/o$~.'
            dc.b    $EE,$27,$F6,$CF,$A8,$28,$14,$E0,$4D,$15,$5A,$E7,$7E,$25,$92,$48
            dc.b    $3C,$17,$47,$31,$43,$99,$23,$CD,$46,$DF,$1A,$06,$D9,$72,$4F,$69
            dc.b    $E6,$B7,$6B,$70,$FA,$B6,$A5,$36,$FB,$F4,$EE,$09,$51,$EE,$35,$7E
            dc.b    $EC,$87,$4D,$B9,$52,$52,$57,$9C,$1F,$FE,$E4,$0F,$32,$5D,$4B,$30
            dc.b    $09,$BC,$71,$EF,$8A,$FD,$AC,$88,$4B,$4B,$9C,$50,$CC,$F7,$2B,$B8
            dc.b    $8E,$7B,$0B,$97,$4C,$AB,$D3,$CC,$8C,$58,$C9,$61,$C5,$2D,$73,$42
            dc.b    $28,$5A,$FB,$05,$BF,$AA,$76,$62,$27,$76,$E8,$BD,$F9,$C7,$0E,$29
            dc.b    $1E,$FB,$48,$18,$9D,$CA,$F4,$0A,$79,$0F,$29,$8C,$9E,$9F,$1C,$F3
            dc.b    $D3,$65,$8E,$74,$70,$C2,$CE,$3B,$26,$6D,$04,$D3,$DF,$8C,$C7,$80
            dc.b    $8D,$92,$BD,$43,$C9,$A8,$8C,$B4,$90,$5B,$52,$84,$0D,$32,$D8,$FF
            dc.b    $58,$D9,$B2,$7F,$C8,$0E,$D2,$2C,$15,$7A,$63,$6F,$5A,$56,$99,$9E
            dc.b    $18,$F0,$50,$DB,$F2,$42,$67,$51,$29,$A2,$3C,$2A,$1A,$98,$66,$9B
            dc.b    $19,$1E,$88,$15,$40,$D3,$F5,$89,$F3,$D1,$64,$F5,$5C,$13,$CA,$D5
            dc.b    $45,$F3,$AA,$F0,$AB,$5F,$A1,$D0,$B6,$9A,$EC,$49,$08,$A5,$E5,$3A
            dc.b    $A2,$E2,$12,$A2,$54,$9D,$6C,$F6,$0E,$2E,$90,$1E,$6B,$12,$79,$6C
            dc.b    $36,$C8,$C2,$83,$AD,$41,$1D,$21,$63,$07,$D7,$E4,$35,$46,$11,$DE
            dc.b    $74,$A6,$96,$5A,$93,$E4,$34,$26,$60,$26,$C3,$E5,$7F,$F1,$10,$95
            dc.b    $F5,$93,$A9,$8F,$91,$BA,$2E,$B7,$4A,$C3,$65,$EE,$04,$55,$38,$A7
            dc.b    $E9,$1D,$75,$DD,$3E,$CC,$31,$53,$E4,$BB,$77,$E8,$21,$91,$B7,$0E
            dc.b    $44,$06,$91,$D6,$5E,$DE,$16,$5C,$A6,$A3,$78,$C9,$68,$CD,$13,$34
            dc.b    $D0,$CE,$00,$66,$94,$71,$0C,$28,$3A,$E6,$2D,$C8,$7A,$1C,$1E,$F9
            dc.b    $7D,$E0,$AB,$92,$AA,$B2,$46,$79,$2E,$4F,$B9,$FA,$DE,$51,$74,$AC
            dc.b    $1C,$69,$68,$25,$57,$E8,$98,$55,$37,$45,$A6,$6D,$A3,$96,$1F,$4B
            dc.b    $99,$DC,$7F,$3C,$F8,$49,$02,$02,$0C,$6E,$17,$FB,$7C,$C0,$FD,$87
            dc.b    $47,$CB,$8F,$EB,$6A,$84,$58,$CE,$B9,$64,$BC,$F1,$96,$10,$21,$AA
            dc.b    $D6,$50,$C0,$1F,$B3,$AE,$C5,$D1,$75,$86,$4C,$9A,$22,$7F,$E3,$85
            dc.b    $1B,$3C,$B8,$AB,$33,$31,$9A,$4E,$FD,$EB,$C6,$65,$13,$E1,$E9,$E1
            dc.b    $64,$48,$B1,$35,$85,$8F,$DD,$A3,$E2,$36,$D4,$1D,$07,$70,$E1,$9F
            dc.b    $5D,$C1,$27,$3F,$39,$83,$6A,$98,$B1,$A1
            dc.b    '03q:,x'
            dc.b    $81,$0A,$5D,$16,$86,$D5,$06,$01,$50,$05,$C8,$B6,$8F,$BE,$F8,$A6
            dc.b    $C1,$2A,$82,$03,$11,$80,$BA,$4F,$10,$EA,$9F,$76,$CA,$EF,$80,$CA
            dc.b    $3B,$D4,$7C,$47,$55,$BD,$07,$ED,$89,$FA,$C1,$7A,$95,$39,$9E,$2B
            dc.b    $56,$16,$DA,$D2,$6C,$CF,$2A,$41,$A5,$6A,$AD,$B1,$EB,$81,$DB,$5E
            dc.b    $F6,$6C,$E6,$2D,$9B,$9E,$EF,$07,$FC,$66,$62,$10,$BD,$94,$20,$20
            dc.b    $49,$F9,$5C,$39,$62,$19,$A0,$F4,$B0,$F2,$F9,$63,$B2,$97,$EB,$73
            dc.b    $14,$43,$08,$64,$66,$1F,$ED,$0D,$CE,$F8,$3E,$FE,$DC,$C6,$E7,$A4
            dc.b    $31,$8A,$BF,$8E,$38,$22,$F3,$45,$B5,$95,$7B,$5D,$DD,$FC,$15,$93
            dc.b    $BA,$11,$01,$A9,$C3,$F6,$22,$BE,$2A,$ED,$FE,$7C,$C4,$09,$EA,$3D
            dc.b    $9C,$FF,$24,$C4,$D7,$D6,$D5,$6A,$F4,$48,$76,$00,$CE,$42,$5C,$8F
            dc.b    $FA,$BE,$C6,$79,$96,$D0,$CC,$61,$0C,$B2,$A1,$D0,$1D,$AD,$AE,$8C
            dc.b    $7A,$0A,$B5,$D3,$92,$02,$0B,$2E,$45,$30,$32,$55,$88,$8B,$63,$02
            dc.b    $49,$92,$73,$20,$E4,$2E,$98,$A9,$2D,$B7,$08,$17,$DF,$EB,$68,$58
            dc.b    $AA,$20,$31,$86,$A6,$22,$5D,$08,$23,$3F,$66,$BA,$BE,$7E,$48,$53
            dc.b    $BF,$6E,$96,$68,$4E,$E6,$3B,$D6,$3D,$D4,$6E,$C4,$F8,$4B,$2E,$89
            dc.b    $A7,$0C,$A5,$AD,$9D,$F0,$C3,$9E,$2E,$6D,$86,$6D,$FB,$19,$27,$FE
            dc.b    $8A,$A4,$DB,$62,$D2,$F4,$C0,$6E,$25,$8A,$1D,$B2,$F9,$AB,$7E,$0F
            dc.b    $9E,$FB,$CB,$5A,$79,$13
            dc.b    '+j*x4M'
            dc.b    $A3,$08,$07,$7B,$50,$A3,$78,$DA,$3F,$B0,$E5,$A6,$81,$94,$EF,$41
            dc.b    $4F,$AF,$88,$94,$C2,$52,$37,$4B,$69,$45,$17,$3E,$46,$6A,$A6,$60
            dc.b    $44,$2F,$BF,$64,$FC,$91,$85,$FF,$C3,$BC,$8C,$07,$E2,$DC,$11,$19
            dc.b    $6F,$C2,$DE,$9B,$41,$76,$F0,$06,$B9,$DB,$39,$31,$72,$67,$97,$50
            dc.b    $DB,$CA,$65,$52,$04,$79,$B1,$AA,$01,$6B,$7F,$1D,$B1,$AA,$83,$4C
            dc.b    $35,$9B,$12,$15,$07,$69,$59,$33,$5A,$B6,$6F,$C3,$D5,$1F,$7D,$56
            dc.b    $ED,$F2,$74,$F2,$94,$5D,$49,$16,$02,$77,$B2,$DB,$E8,$3E,$92,$EF
            dc.b    $61,$E0,$D5,$DD,$A0,$14,$EE,$C0,$7F,$BB,$0C,$3B,$3E,$BF,$9A,$46
            dc.b    $B8,$EE,$51,$3A,$CF,$C5,$77,$F6,$BC,$D1,$62,$DF,$D9,$07,$95,$B7
            dc.b    $18,$EC,$1A,$38,$95,$68,$A8,$1E,$B7,$7C,$3F,$3C,$47,$9D,$1F,$EC
            dc.b    $76,$C3,$B6,$11,$32,$A7,$33,$BD,$A9,$98,$3A,$D4,$34,$93,$D7,$99
            dc.b    $BB,$9E,$D2,$66,$70,$00,$FA,$DC,$1C,$56,$BE,$48,$43,$09,$4C,$A4
            dc.b    $91,$6F,$F2,$B9,$C4,$A2,$93,$C9,$33,$2D,$42,$28,$EB,$1E,$F4,$BB
            dc.b    $77,$06,$9B,$B6,$5C,$A9,$A0,$2C,$DA,$8F,$16,$91,$D4,$B4,$4F,$0E
            dc.b    $5E,$8C,$E7,$A5,$2B,$9F,$61,$E4,$5F,$49,$2D,$EE,$16,$D9,$D9,$27
            dc.b    $C5,$DA,$71,$1A,$09,$47,$A9,$2A,$C0,$A5,$22,$72,$15,$1B,$10,$01
            dc.b    $1A,$FA,$EA,$5F,$7D,$54,$19,$5D,$E0,$90,$CE,$63,$8D,$C4,$F7,$98
            dc.b    $EA,$81,$D6,$2F,$38,$1D,$14,$D5,$21,$AE,$23,$14,$65,$38,$D3,$E1
            dc.b    $26,$35,$3E,$A7,$48,$E1,$C8,$75,$D3,$7B,$BB,$B4,$E7,$0F,$FB,$E5
            dc.b    $0E,$EF,$28,$9A,$BA,$BA,$99,$7F,$7C,$50,$C2,$D8,$87,$C9,$5B,$90
            dc.b    $9A,$6C,$B9,$FC,$F0,$DD,$E9,$D1,$58,$62,$ED,$71,$56,$04,$55,$04
            dc.b    $67,$EA,$3D,$80,$7B,$E5,$6A,$E7,$AD,$FF,$57,$1C,$54,$E4,$C1,$D2
            dc.b    $B3,$15,$2F,$A2,$FF,$21,$01,$A3,$F3,$7A,$26,$F9,$CC,$CF,$C9,$12
            dc.b    $80,$2C,$67,$CB,$CA,$FC,$24,$32,$24,$FE,$2A,$78,$D8,$B8,$69,$37
            dc.b    $A8,$74,$A2,$F0,$A2,$99,$47,$0D,$8B,$18,$E2,$C8,$C6,$F7,$60,$7E
            dc.b    $0B,$F6,$AD,$BC,$85,$58,$C5,$4E,$74,$CB,$F1,$C2,$14,$0E,$8F,$B1
            dc.b    $4A,$C0,$B8,$45,$00,$C8,$A7,$54,$62,$64,$5F,$CF,$5D,$4A,$B4,$84
            dc.b    $66,$D6,$A3,$E3,$FE,$95,$F5,$7A,$20,$4C,$4D,$B0,$A1,$43,$0D,$C7
            dc.b    $82,$85,$A4,$44,$BD,$88,$5E,$7D,$E9,$AC,$3C,$AF,$EC,$63,$4B,$0A
            dc.b    $39,$C1,$EC,$39,$03,$D5,$8A,$E2,$AB,$4F,$F6,$5B,$71,$B3,$81,$95
            dc.b    $2F,$17,$53,$47,$F6,$E7,$52,$3F,$97,$E9,$F9,$7C,$89,$DF,$94,$13
            dc.b    $DD,$72,$B3,$69,$2C,$97,$40,$CA,$84,$80,$D1,$70,$F7,$0B,$4E,$30
            dc.b    $12,$A0,$56,$B3,$9C,$CC,$15,$1B,$E1,$37,$E6,$CC,$60,$E2,$9D,$6F
            dc.b    $52,$0D,$BC,$8D,$3C,$3C,$1B,$18,$8E,$39,$CA,$23,$AE,$D7,$05,$B8
            dc.b    $31,$89,$DC,$EA,$36,$A8,$F3,$77,$63,$4D,$4A,$51,$EF,$5E,$02,$FD
            dc.b    $F2,$5F,$09,$FA,$FD,$36,$AA,$35,$6C,$71,$9E,$E6,$17,$5A,$E1,$9F
            dc.b    $1E,$3D,$DF,$49,$73,$4E,$B0,$AC,$83,$7F,$35,$97,$F4,$31,$8E,$A1
            dc.b    $53,$32,$D0,$F8,$A5,$16,$46,$93,$19,$FD,$AB,$74,$CD,$1C,$FE,$83
            dc.b    $40,$26,$89,$1F,$59,$51,$7A,$87,$EE,$66,$87,$40,$DE,$44,$FD,$AE
            dc.b    $4C,$55,$FF,$C6,$1B,$70,$F8,$8E,$90,$A1,$03,$ED,$29,$B1,$8B,$9D
            dc.b    $E6,$B9,$AF,$26,$C8,$12,$84,$59,$F1,$CD,$29,$BF,$27,$41,$38,$03
            dc.b    $9B,$F5,$AC,$AB,$05,$40,$44,$43,$CB,$F8,$82,$A0,$10
            dc.b    'ursjFP'
            dc.w    $8811,$D270,$214D,$61E4,$0B55,$2390,$5ED6,$6021
            dc.w    $0C22,$290A,$8568,$D8C7,$5CC9,$B591,$346D,$591E
            dc.w    $B5E5,$1025,$2DAF,$96EB,$65DC,$A61C,$3699,$8318
            dc.w    $6728,$1141,$7664,$DEDA,$D7AC,$337B,$9CB0,$87BA
            dc.w    $2B8F,$735A,$F375,$C66B,$E857,$E3DD,$296B,$3445
            dc.w    $C14B,$C70E,$3D7E,$24FC,$E03B,$86E8,$EB08,$25CF
            dc.w    $FB93,$CED4,$8A9F,$D36D,$F5B4,$3AD8,$10C1,$570F
            dc.w    $82D0,$8EE3,$D9C7,$BD6C,$CD8C,$2B20,$DE98,$E813
            dc.w    $4AE3,$2880,$42B2,$2AB7,$C530,$1A54,$9237,$F343
            dc.w    $8106,$0130,$BE6E,$F900,$4F5B,$5BBD,$F7D7,$0358
            dc.w    $8B0D,$F12C,$05B5,$8DCD,$A842,$5336,$0913,$9A64
            dc.w    $F178,$2706,$6C51,$0504,$57B6,$9CE0,$E91F,$5C75
            dc.w    $9686,$659C,$CE0F,$827C,$240A,$3BC4,$253A,$ED8D
            dc.w    $F4D1,$7D79,$22A4,$849F,$6BF5,$3A13,$DB47,$0FA7
            dc.w    $3FED,$F597,$74B2,$A82D,$2E39,$1B01,$C668,$BA41
            dc.w    $E59E,$696D,$3AEE,$973F,$5F48,$E1E9,$E028,$9023
            dc.w    $7B57,$6467,$E6C7,$E080,$FBA8,$3C77,$1A13,$BF9D
            dc.w    $F688,$2C3E,$B876,$E4EA,$C142,$D824,$0C0F,$31CE
            dc.w    $FD5C,$8BF3,$76DA,$CDEC,$51AB,$4D49,$19C6,$C35F
            dc.w    $2904,$EDBF,$EB08,$DD7C,$0A6F,$74D3,$3B98,$D7D5
            dc.w    $B0C0,$E300,$84FD,$B861,$A6D5,$3BCC,$8C91,$BBB7
            dc.w    $17A6,$575C,$5D74,$F1DD,$F1A4,$4B3D,$5C64,$1508
            dc.w    $DDBB,$76ED,$5317,$52E0,$C463,$1014,$4197,$EB5B
            dc.w    $A202,$4160,$B1F0,$BC94,$6A7C,$AC4B,$70D8,$4AB4
            dc.w    $A424,$9B6A,$C0AC,$35DC,$D9A5,$AA30,$2BC9,$D6EB
            dc.w    $FEEB,$065E,$EAB7,$55B9,$9035,$683A,$010E,$421F
            dc.w    $10D0,$21C6,$A980,$C863,$78C1,$7DEE,$B734,$B1C8
            dc.w    $301F,$C52F,$2D2C,$862B,$FF7D,$A962,$9441,$A3D9
            dc.w    $7F59,$1718,$BD01,$C683,$5582,$B0FE,$00FF,$190C
            dc.w    $9F73,$5BD7,$56EC,$8847,$F2D4,$11C4,$DF51,$B288
            dc.w    $068C,$AE2E,$28B3,$56B6,$3610,$5A12,$3EBA,$6E0F
            dc.w    $8906,$03BC,$6649,$2809,$3C14,$7E48,$8685,$4338
            dc.w    $E49F,$FBE7,$1358,$D571,$E30C,$0816,$12F1,$820A
            dc.w    $C972,$9999,$228F,$A633,$DE9A,$C7D2,$464C,$8452
            dc.w    $73BF,$7B36,$16DB,$1FAF,$02AA,$B99C,$A0B4,$D1D4
            dc.w    $F7D9,$E7A3,$D060,$651B,$50F2,$7272,$AA69,$B3DA
            dc.w    $9753,$EFE4,$0D1E,$9443,$779D,$33FA,$8F1A,$47BA
            dc.w    $8EDD,$F789,$9965,$3F55,$57C2,$C99E,$3526,$44AA
            dc.w    $D554,$1E10,$F3D6,$EE9A,$0BB6,$8D79,$9DD2,$B5AC
            dc.w    $CF7E,$9F21,$5E05,$D054,$2A5F,$F37D,$D6FE,$6691
            dc.w    $6C36,$045D,$1E4A,$9C1E,$EF1B,$3757,$7120,$803C
            dc.w    $CB19,$96CD,$593A,$F968,$A7CE,$22CB,$60EA,$EC7B
            dc.w    $6803,$26A4,$1855,$D2A5,$CA15,$F404,$2FA2,$1806
            dc.w    $CD87,$9EAB,$BEB1,$5840,$95FC,$2AB8,$4071,$38EF
            dc.w    $F83F,$61A1,$C812,$142A,$61C5,$FFA8,$0F8A,$4511
            dc.w    $8A9C,$2965,$7262,$FDE6,$2786,$50F8,$A50A,$D94F
            dc.w    $7CA1,$CA02,$E8C4,$F06F,$E9F5,$5FE8,$1C0B,$858A
            dc.w    $5277,$B4E3,$4DA7,$E9CF,$E7CA,$8AFC,$CCFA,$8FE1
            dc.w    $7E50,$A7BD,$B97A,$530B,$C7DE,$818C,$67E2,$A2D8
            dc.w    $442D,$3646,$1D93,$91F6,$982A,$0193,$3D2B,$2D51
            dc.w    $BF38,$EA87,$B678,$398B,$7909,$5C2C,$0366,$CBAE
            dc.w    $31FB,$6A19,$343D,$FC1A,$42DF,$7856,$AF37,$7FFF
            dc.w    $ACCC,$6350,$26D1,$5D84,$FA46,$E259,$0ECD,$62F2
            dc.w    $F423,$B6BB,$BC32,$9D8F,$4C96,$C464,$374E,$4E69
            dc.w    $838D,$5E9B,$BB94,$02C1,$435A,$BEE5,$2190,$B7DE
            dc.w    $246C,$40FB,$6D99,$6FAD,$D84B,$3495,$E143,$6CB3
            dc.w    $1B07,$CE25,$5B5E,$798E,$49C3,$321D,$8B8E,$3D53
            dc.w    $C3E7,$D303,$D3E4,$DC0D,$936A,$30F5,$6FDC,$C0A2
            dc.w    $4ED7,$4998,$09B9,$2774,$B4B5,$A1E2,$9EE6,$A007
            dc.w    $DCE0,$0E31,$4AAD,$1D82,$E21C,$984E,$9B2F,$E87A
            dc.w    $AD25,$6D17,$EC2E,$AFF1,$116D,$C258,$CEA3,$2B45
            dc.w    $A161,$87FD,$45F9,$C190,$6944,$2EB1,$D275,$4CA0
            dc.w    $A392,$1CC2,$FC29,$6B8D,$1F6E,$4F4D,$7AC8,$DF5A
            dc.w    $F9E1,$0939,$96F8,$DA9F,$87B0,$E6BE,$80E9,$7378
            dc.w    $3340,$1626,$65EF,$5428,$F545,$71CA,$B55D,$AD6B
            dc.w    $4B52,$F632,$B3E5,$D43B,$ED3C,$92F9,$C2AE,$A57F
            dc.w    $6B1D,$0A05,$6E84,$20F7,$634D,$7CC7,$B230,$0535
            dc.w    $9A33,$8976,$1522,$12D1,$644F,$CC27,$A883,$48B0
            dc.w    $8D18,$131C,$D431,$1A4C,$D789,$0D70,$5ABC,$25B2
            dc.w    $3879,$E5F4,$7D56,$246C,$BA27,$6781,$82F7,$4644
            dc.w    $AB3B,$7A15,$7595,$0729,$540D,$23A9,$85D3,$5166
            dc.w    $C55B,$0085,$4F6B,$0B86,$DABD,$75F0,$0711,$F2DF
            dc.w    $D1B8,$BDC5,$EEF4,$8EB5,$929B,$0C96,$08AF,$DE75
            dc.w    $25CB,$FE37,$47E8,$ABDB,$587F,$9AD0,$48F3,$F842
            dc.w    $043E,$8C73,$2070,$2F22,$91A9,$CFD6,$0516,$FA34
            dc.w    $818B,$7720,$14A0,$3E6E,$3200,$83A6,$62E3,$707E
            dc.w    $9C81,$600E,$2C7B,$A44A,$88BE,$59C3,$F0F6,$95C9
            dc.w    $2321,$9392,$39CF,$DBC0,$AE67,$7F19,$B458,$E0C3
            dc.w    $EBFB,$6D37,$05F2,$2F95,$D838,$5E6E,$1A99,$A155
            dc.w    $5BA3,$35ED,$5DB1,$E8B8,$90EC,$3E2E,$0767,$1606
            dc.w    $476F,$848F,$E1AA,$8D0E,$A0C7,$F829,$8704,$FAE6
            dc.w    $BCBD,$97E1,$59D8,$82EF,$B64C,$B0D0,$76AF,$2072
            dc.w    $4D94,$6B27,$2980,$6F16,$8F44,$24D6,$3BD5,$6A3C
            dc.w    $A1A4,$3F4C,$8917,$B2A1,$3556,$EF26,$CAC8,$EC02
            dc.w    $845F,$E6FE,$E650,$4E77,$387C,$142F,$85FC,$B16F
            dc.w    $3DC4,$54FC,$C6D6,$78B0,$A702,$4548,$D6F5,$0A69
            dc.w    $4BAD,$2BA2,$1BE4,$680A,$E09B,$1E3A,$B1F8,$6E36
            dc.w    $6CE6,$9F8D,$324F,$9B5E,$8C89,$395C,$06F0,$BB53
            dc.w    $DA09,$E763,$D196,$DA6A,$0AF1,$0870,$E477,$CB40
            dc.w    $5E22,$EB44,$B890,$D13E,$7442,$0365,$6BD0,$C23B
            dc.w    $1E23,$D9DD,$8BDB,$4375,$0EB7,$0B73,$40EE,$ACA4
            dc.b    $4A,$07,$1D,$E2,$A6,$CA,$2A,$EC,$4E,$0E,$A5
            dc.b    $2B,$49,$27,'aZzr'
            dc.w    $CD62,$01CF,$CEFF,$B3A8,$8EC7,$E735,$918E,$4254
            dc.w    $EE9F,$128C,$8820,$08EA,$E21F,$F474,$0DE5,$BEF6
            dc.w    $8FC4,$ABD7,$A7DB,$5830,$87C6,$0D18,$7E9B,$0B4A
            dc.w    $B3AF,$3775,$8BD3,$730F,$D6B3,$7088,$9A7B,$9655
            dc.w    $F2A8,$30C1,$8696,$4161,$D7AD,$FD3C,$2335,$5C73
            dc.w    $94C1,$C25B,$1ABA,$5ADA,$D0F1,$7D06,$9CF8,$8081
            dc.w    $2E07,$7586,$A91B,$036C,$119E,$7119,$80B9,$0945
            dc.w    $C3D2,$B09D,$B5A0,$DD66,$E1C9,$FC1B,$3094,$A484
            dc.w    $2688,$EA8E,$92A7,$63C0,$A62C,$F637,$2D56,$97EB
            dc.w    $5C66,$025E,$17F4,$672C,$25BB,$ED11,$3691,$52E8
            dc.w    $CC4E,$3FD4,$DDDE,$D33D,$B4C0,$C34E,$4490,$6D93
            dc.w    $50CF,$2DD2,$311C,$7EA6,$6728,$EE1E,$60E9,$57CC
            dc.w    $37B4,$A346,$ED09,$D53F,$4014,$B9AC,$AE41,$D047
            dc.w    $6311,$2CBC,$F146,$B700,$66F2,$9B2B,$6C85,$AE6E
            dc.w    $AB04,$78ED,$526B,$3EA0,$7B7C,$C0FE,$004F,$B260
            dc.w    $FECE,$BD34,$F959,$FBB8,$B947,$101F,$8CC2,$39BA
            dc.w    $BA74,$158F,$F31E,$6936,$DCF5,$3152,$E9DA,$C810
            dc.w    $F023,$D4CB,$3D30,$DBCD,$997E,$4FFA,$B8C5,$F382
            dc.w    $BF08,$E9EF,$E40B,$942F,$74BC,$DC97,$FF99,$79CE
            dc.w    $3CEB,$F179,$29A5,$6068,$A2E4,$6812,$2C5B,$2EBE
            dc.w    $FC86,$7239,$1952,$AD71,$90B7,$1C6D,$C6CD,$AC03
            dc.w    $C539,$BFA2,$F660,$20A5,$C84A,$647B,$69DC,$1691
            dc.w    $5951,$191D,$D438,$6670,$8576,$AF41,$E34D,$88A9
            dc.w    $72E7,$A87E,$D331,$92C6,$286C,$560D,$5D81,$1F51
            dc.w    $0542,$FE85,$C0B6,$2321,$38A3,$817F,$5B0F,$279C
            dc.w    $898C,$62B4,$A317,$6F2E,$34AA,$9595,$E51D,$D29A
            dc.w    $21D5,$B5F4,$F5F3,$24F7,$4880,$C4B2,$9D57,$A54B
            dc.w    $B600,$D7D3,$DFF6,$E29E,$1F93,$36F3,$AD7A,$D9B0
            dc.w    $753F,$340B,$A07F,$3CE9,$554B,$8313,$C7B1,$2A3E
            dc.w    $81F7,$E332,$0F12,$4429,$7D25,$0CB3,$9667,$0F8A
            dc.w    $7661,$33A1,$8AAB,$9D8B,$CA8A,$F06B,$DB13,$CCFF
            dc.w    $AF97,$E8DE,$4110,$1DF9,$4B01,$9125,$71DF,$F81A
            dc.w    $182D,$DE87,$4245,$F7DF,$DEEE,$7F31,$4FBD,$FA16
            dc.w    $019A,$5020,$9354,$464D,$1518,$54E3,$FB64,$9A62
            dc.w    $1CB2,$2805,$BE84,$8A83,$3B49,$CD76,$770D,$AA92
            dc.w    $732A,$BB24,$FDD1,$9E98,$D2E8,$0043,$4789,$A92D
            dc.w    $5858,$7BC9,$490C,$3A78,$7C9D,$453A,$7998,$BA57
            dc.w    $A4B5,$6A7D,$95E3,$9FB9,$27AE,$C7D9,$9887,$4CDC
            dc.w    $53AC,$7C59,$6405,$438D,$C424,$2149,$126D,$2226
            dc.w    $1B71,$CBC2,$338B,$86B6,$C992,$F9FD,$4CFB,$F564
            dc.w    $BC9C,$8D5A,$627D,$5FBB,$D53D,$2B14,$5F68,$98B5
            dc.w    $2221,$250A,$F4D9,$65E1,$3AE0,$48E0,$C1BF,$6E9F
            dc.w    $02A9,$9C2A,$4DF9,$827A,$0CF0,$14E7,$13D7,$180C
            dc.b    'W2/cFP'
            dc.w    $FFAB,$0EFD,$C5E2,$061A,$13D1,$07FA,$55DD,$F7CC
            dc.w    $C1AE,$7A03,$EC48,$7078,$1128,$CFCA,$9340,$BD34
            dc.w    $5153,$9E83,$8EBF,$6522
            dc.b    'a;V_S3'
            dc.w    $1015,$CEC5,$4A79,$EFC3,$5AA6,$A25D,$0982,$2615
            dc.w    $D8D8,$7765,$B75D,$9908,$A8EA,$DF5C,$5133,$1769
            dc.w    $EACB,$CFA7,$04BE,$F26A,$32C8,$0401,$AAD4,$C9E5
            dc.w    $8343,$E51C,$B98F,$D895,$BD66,$8A92,$B89A,$BB2E
            dc.w    $FA0A,$5642,$DE5B,$9B33,$1E37,$6359,$F33A,$FD57
            dc.w    $A71E,$B7F9,$91AA,$4213,$E7CE,$2415,$D0A3,$670D
            dc.w    $CB80,$A1AE,$C43C,$6E9A,$3452,$7F29,$9A9F,$DA8A
            dc.w    $1B88,$A685,$0CF9,$E49D,$E26D,$6AA6,$1F4E,$4CEB
            dc.w    $A090,$3CC1,$7CCC,$43E7,$4620,$0708,$7608,$2BB6
            dc.w    $DAF5,$1132,$7E26,$B08E,$21B5,$EE04,$3967,$D13E
            dc.w    $9DD8,$46DC,$3717,$ACD9,$8A93,$7A2C,$841F,$9452
            dc.w    $4B35,$146D,$5EF1,$EB70,$3B6B,$8490,$78A1,$BDBC
            dc.w    $1DAE,$9AB8,$075E,$A424,$2A42,$3DFC,$7003,$B181
            dc.w    $9694,$D7B1,$949B,$F531,$E64D,$2745,$B591,$C6C2
            dc.w    $0989,$C23B,$25AD,$B2DE,$FD1C,$A88B,$CF50,$374D
            dc.w    $D816,$6830,$5284,$1F00,$3EB1,$99DA,$FC8C,$1E26
            dc.w    $AD7A,$AFBA,$F938,$CCA7,$2912,$D5C0,$1125,$3A79
            dc.w    $28F3,$93ED,$267B,$10F8,$F406,$012A,$EA0F,$60F5
            dc.w    $43A8,$3F20,$0232,$821D,$83EA,$9893,$352A,$890C
            dc.w    $E8DA,$5734,$7A29,$5DE6,$44EE,$6C0F,$7D63,$F1F1
            dc.w    $5A4C,$3E62,$CE92,$5036,$81F7,$CF09,$54DE,$17D4
            dc.w    $4DFD,$0D63,$03FB,$2022,$73C1,$9676,$8E41,$4782
            dc.w    $3D5A,$8C53,$E3CD,$09A1,$042E,$2EFD,$1957,$0EB0
            dc.w    $C3E4,$FBEE,$AB14,$8384,$B2BC,$1205,$4E5C,$778F
            dc.w    $5B97,$DFF2,$E477,$9DFB,$FB59,$A255,$0F76,$9E69
            dc.w    $4162,$4950,$F810,$E1D3,$8515,$19D7,$2F54,$B97E
            dc.w    $93E7,$855E,$599D,$AD4C,$2D58,$F07F,$D1CA,$26A0
            dc.w    $0D2B,$C9EF,$458E,$36A5,$6840,$9CB3,$6F7E,$E7A2
            dc.w    $F6CF,$B3A8,$0EDF,$F3A4,$2CC3,$72CE,$9F69,$DB49
            dc.w    $63A0,$E87D,$7B5D,$B888,$C547,$7171,$3605,$5F60
            dc.w    $A6E5,$1516,$3171,$FF98,$12F4,$4DC8,$CAD7,$751F
            dc.w    $DFAC,$B6CD,$7F31,$0AB7,$D56C,$38E3,$66D0,$41C5
            dc.w    $6A18,$0BF0,$0833,$FAEA,$47EF,$1A6F,$1600,$2174
            dc.w    $A8E1,$5C77,$F52F,$30CA,$D621,$E99F,$E13F,$51B9
            dc.w    $8BF6,$7DF7,$487D,$9510,$4298,$ECBD,$01DD,$A7FF
            dc.w    $BA3E,$083C,$DD3D,$32D8,$E5B6,$D61A,$1CDC,$D2E4
            dc.w    $50D2,$D975,$53FF,$AAF6,$AF68,$7BB4,$6595,$293A
            dc.w    $5160,$C7DD,$5DF2,$86AB,$D2A2,$97C9,$13D5,$BAE1
            dc.w    $156F,$7007,$0A1B,$28BB,$88B0,$4F9C,$DC27,$4AE9
            dc.w    $2349,$64E8,$40A9,$2D17,$6C9C,$B561,$5CE6,$8106
            dc.w    $0BFE,$4037,$BFB7,$8B4B,$67CB,$DE41,$B001,$2519
            dc.w    $C178,$04D1,$EB45,$1C97,$69B2,$FC28,$33E8,$556A
            dc.w    $CD09,$9265,$9579,$C49B,$E9C4,$8ECB,$BB4A,$9F8D
            dc.w    $B16E,$EA73,$D773,$F958,$6011,$D33F,$9E87,$A354
            dc.w    $182C,$B486,$9822,$5296,$A46A,$E5FA,$3C61,$8D5F
            dc.w    $BC81,$5340,$3AD4,$BF66,$EC70,$7EE0,$6234,$7C1B
            dc.w    $5664,$06C7,$C0AB,$5A51,$1A1A,$DC18,$AEC9,$45A9
            dc.w    $10D1,$915B,$6D23,$CB0E,$A5FC,$CEB5,$FFBE,$4899
            dc.w    $FEBB,$DD1C,$B60E,$61EC,$279E,$447B,$570B,$A0BF
            dc.w    $7707,$8778,$6BC0,$1638,$4C4B,$1802,$F0A4,$8087
            dc.w    $8C3B,$E60A,$D3E2,$5467,$5574,$1D0B,$714F,$C59E
            dc.w    $4A0C,$E2AF,$9B8D,$35DF,$49D3,$3143,$38BD,$7603
            dc.w    $6EED,$F794,$2448,$5823,$89D9,$884F,$20F0,$628C
            dc.w    $82F8,$ABAA,$DB28,$D056,$EF19,$1BE2,$EDC8,$2F4E
            dc.w    $F2EB,$2AD5,$9CD6,$0C39,$AA55,$595C,$BE86,$BE12
            dc.w    $A9BF,$F272,$E0A5,$FE5A,$5F82,$4B46,$C256,$C114
            dc.w    $F753,$786C,$3013,$D4FE,$79A7,$652B,$327F,$F64A
            dc.w    $C7C5,$E07A,$99C6,$4E68,$2265,$A92D,$2E7C,$6BC3
            dc.w    $61E9,$0247,$97E0,$8FCC,$80C7,$74D6,$B436,$A5F3
            dc.w    $8FC2,$39A3,$AC46,$F825,$06DB,$79C4,$7583,$05D0
            dc.w    $F1A6,$E37C,$B799,$BCB2,$D430,$5E6E,$90B8,$3B11
            dc.w    $C602,$66DB,$92AF,$CA91,$648A,$C06B,$CC51,$6948
            dc.w    $A143,$23F4,$5844,$7321,$3F0D,$5B64,$7204,$CD83
            dc.w    $D972,$1389,$C9B4,$2CCF,$A375,$EF80,$A2EC,$6D35
            dc.w    $17BA,$C32F,$87E3,$03E5,$1485,$34BE,$00B9,$AE27
            dc.w    $4F1D,$903D,$EE39,$F45D,$052D,$EDD2,$745F,$6F44
            dc.w    $86FA,$C801,$8DB3,$22AC,$B324,$0FC6,$2B96,$33AD
            dc.w    $C88B,$001E,$D93B,$928F,$15FC,$CA5F,$1FEE,$C53E
            dc.w    $780A,$03EB,$C2EA,$8AD0,$5465,$EE0D,$483F,$EDAA
            dc.w    $9DAF,$59F1,$B877,$B015,$595C,$8F9B,$7CB6,$71DB
            dc.w    $EB80,$0ECB,$0421,$C47A,$02B9,$7B8C,$BAB4,$D553
            dc.w    $ADC7,$45BA,$7DDA,$F8B1,$D5CF,$B16C,$5338,$AF82
            dc.w    $D047,$8D81,$8D9B,$344D,$4407,$4BC5,$4CC5,$1188
            dc.w    $000F,$6DA7,$BBE4,$4DD7,$9C4B,$D055,$B062,$B296
            dc.w    $5D41,$6BAC,$9334,$EBBF,$8A9F,$A94F,$D625,$5C6A
            dc.w    $7BF5,$88E4,$A64E,$533C,$B958,$FAF6,$56D5,$1E9D
            dc.w    $5275,$E669,$87E6,$A8A2,$5CC0,$1061,$BFF2,$2B60
            dc.w    $C811,$BAC4,$AC1A,$6832,$A1B3,$D459,$E9C2,$138E
            dc.w    $1B18,$EC64,$C6FD,$1422,$DA98,$9842,$FD30,$3658
            dc.w    $F7DD,$9FA0,$C393,$2695,$9F81,$ABAE,$6039,$62C0
            dc.w    $6416,$6949,$A037,$0B18,$4FF4,$38D2,$996D,$1F00
            dc.w    $3D64,$DB4C,$1E67,$5AD6,$CFD0,$1D47,$901E,$3F57
            dc.w    $C9A5,$41E9,$9208,$8213,$756F,$FF3A,$2151,$0AB8
            dc.w    $8357,$A4B9,$17F3,$DE8B,$3471,$2730,$DEBC,$E78A
            dc.w    $BE2D,$5E20,$CEF7,$C039,$97FB,$F79F,$0BF9,$6197
            dc.w    $8682,$4768,$AEF8,$350B,$2988,$E1EF,$43F0,$2D34
            dc.w    $4B3E,$8E78,$D74A,$676D,$7F76,$F0BE,$2FD3,$1CFD
            dc.w    $7073,$D97C,$011F,$000F,$6E9A,$B3C6,$B66B,$7A09
            dc.w    $4D1D,$17AF,$57BF,$312D,$72A2,$77FF,$4229,$568D
            dc.w    $5F50,$EA26,$1CB0,$E854,$EA95,$E9BB,$2DEF,$E340
            dc.w    $207B,$B41B,$25CA,$FC2E,$14C4,$B602,$F179,$06BD
            dc.w    $3B52,$A135,$0A89,$A094,$ECB7,$7523,$F6C8,$A648
            dc.w    $6F70,$8BB4,$3CFE,$1AE1,$0536,$1680,$58D2
            dc.b    '7g9jssPE'
            dc.w    $15CF,$802A,$40A4,$4540,$9CD8,$18E7,$707D,$6BBB
            dc.w    $D2E0,$D290,$095E,$B3B2,$2117,$66CD,$843F,$8904
            dc.w    $7FB0,$A98F,$3E71,$FAA1,$D1DE,$0D26,$B96E,$5159
            dc.w    $CC04,$F0C3,$CEFA,$3F0E,$6F14,$FC94,$04C1,$F203
            dc.w    $95E7,$11AB,$97ED,$76C1,$CD19,$2620,$199E,$302B
            dc.w    $0711,$36FF,$FBCE,$CB7D,$3212,$8878,$A2AB,$AB24
            dc.w    $579C,$388D,$12DF,$DDD8,$9601,$63C6,$AC90,$22E1
            dc.w    $BE05,$3EAA,$054A,$9E54,$83A1,$1AD1,$0CD5,$6A19
            dc.w    $48B5,$4A9E,$6C52,$B1A9,$C843,$9431,$20AD,$19DB
            dc.w    $E5FB,$AAA7,$661D,$F406,$24B2,$F5AE,$9056,$CA1C
            dc.w    $65CA,$035B,$7D46,$A722,$39E8,$072E,$3C29,$4E84
            dc.w    $2F75,$BCAC,$A303,$162C,$9A4B,$BDF6,$44F3,$6C35
            dc.w    $DC86,$2E92,$F536,$EF4F,$2537,$06E8,$6EF9,$8F68
            dc.w    $A5E5,$D35A,$426B,$5BF1,$5B50,$E33D,$BD31,$C71B
            dc.w    $AAB7,$77E5,$D76F,$98CB,$4A91,$27EC,$28F0,$9A17
            dc.w    $D3A6,$68A3,$870E,$3515,$FD77,$914D,$3AC3,$339D
            dc.w    $E425,$84FA,$BCEC,$F999,$5F10,$0EA8,$3D27,$FBB1
            dc.w    $897E,$DB28,$552A,$C561,$C3E3,$E710,$C993,$326E
            dc.w    $DF51,$1043,$D8D1,$239C,$0DA8,$2B55,$BB08,$2C0C
            dc.w    $DD5C,$2891,$3B5D,$553C,$0F45,$C144,$64CC,$40AD
            dc.w    $79A9,$4101,$937F,$3A97,$5D87,$0C63,$C144,$82EB
            dc.w    $B5C9,$7387,$85F2,$D469,$5466,$C0A6,$C6A5,$B77A
            dc.w    $5838,$7AD9,$2ADA,$B413,$4641,$6985,$7862,$E88B
            dc.w    $8CF7,$71BD,$7C33,$5E0D,$9EBC,$ED66,$8192,$318C
            dc.w    $02FE,$A8A4,$6306,$CD0B,$8070,$08B8,$4FF5,$4912
            dc.b    $EF,$EA,$0F
            dc.b    '2L!Z#R'
            dc.b    $99,$C4,$74,$FE,$F8,$6D,$D7,$1B,$2B,$E5,$CE,$08,$1F,$DC,$46,$B7
            dc.b    $2C,$E0,$86,$F1,$DC,$7E,$4C,$91,$5A,$13,$DC,$50,$72,$81,$33,$F3
            dc.b    $76,$A3,$D6,$F4,$D4,$95,$DE,$6A,$1A,$E1,$42,$9D,$E2,$A4,$27,$F2
            dc.b    $83,$79,$E2,$86,$3D,$8B,$D4,$E0,$07,$CC,$7F,$B8,$24,$F3,$CC,$51
            dc.b    $9A,$E6,$DF,$F9,$84,$B5,$96,$22,$74,$B2,$7E,$72,$1C,$37,$09,$49
            dc.b    $1E,$24,$B5,$C7,$B3,$96,$14,$AE,$98,$62,$56,$DA,$CD,$A5,$BA,$C2
            dc.b    $C2,$F8,$53,$BF,$D9,$FF,$60,$2C,$DD,$D8,$00,$F6,$65,$47,$ED,$CF
            dc.b    $28,$9B,$6C,$43,$63,$85,$02,$CB,$79,$E2,$48,$A7,$C7,$EE,$05,$7E
            dc.b    $E6,$65,$5D,$23,$F4,$1D,$BE,$D6,$3B,$FE,$83,$29,$B6,$8C,$7C,$99
            dc.b    $0C,$AF,$49,$9B,$FC,$DF,$72,$74,$2F,$12,$3A,$30,$A3,$D1,$2F,$76
            dc.b    $EE,$E4,$8E,$AD,$16,$46,$A0,$E2,$0A,$61,$8A,$94,$5B,$09,$E3,$60
            dc.b    $4E,$A2,$C9,$2E,$D3,$74,$5F,$4E,$7B,$67,$5E,$33,$85,$8E,$E9,$18
            dc.b    $C8,$2A,$E0,$01,$89,$E4,$3B,$C2,$FC,$12,$29,$ED,$8E,$4F,$74,$3A
            dc.b    $F7,$A1,$D9,$0A,$44,$D5,$1F
            dc.b    '6Rl+QQHEnc`'
            dc.b    $8E,$1E,$E6,$CB,$68,$53,$3F,$0D,$F3,$FF,$B6,$98,$06,$48,$0E,$D4
            dc.b    $FC,$0B,$8A,$67,$44,$FD,$20,$05,$A4,$14,$39,$AF,$81,$F7,$16,$61
            dc.b    $42,$D2,$3B,$86,$BE,$AB,$77,$24,$80,$4C,$36,$34,$79,$31,$F4,$F9
            dc.b    $4F,$39,$E9,$AD,$0F,$C8,$D4,$EC,$12,$FA,$BD,$D8,$0D,$62,$FF,$78
            dc.b    $70,$1F,$FD,$66,$76,$D6,$9A,$9E,$8D,$43,$A3,$13,$57,$97,$84,$2F
            dc.b    $95,$45,$59,$58,$AF,$12,$73,$14,$99,$DD,$05,$1A,$FA,$E5,$7C,$0F
            dc.b    $7F,$A4,$4D,$09,$CC,$A0,$9E,$30,$A0,$99,$55,$51,$FF,$F0,$DC,$BE
            dc.b    $94,$92,$7D,$18,$31,$11,$BB,$4E,$26,$0E,$DA,$97,$D7,$83,$92,$32
            dc.b    $52,$28,$99,$F4,$7C,$3B,$CD,$FF,$E7,$B8,$9F,$E8,$AB,$9B,$7E,$6F
            dc.b    $8A,$4B,$CF,$2B,$E5,$CD,$A0,$D1,$B1,$F9,$A9,$7A,$16,$C1,$3E,$B2
            dc.b    $69,$DC,$5B,$B0,$72,$D9,$0A,$C6,$A5,$F5,$E5,$DB,$B9,$A2,$F1,$7F
            dc.b    $25,$69,$8C,$82,$B2,$67,$02,$72,$EA,$8F,$D3,$B6,$DF,$3C,$33,$BF
            dc.b    $20,$2C,$2E,$E5,$51,$52,$96,$F5,$00,$81,$D7,$8F,$3C,$9E,$62,$C4
            dc.b    $87,$1C,$EB,$B1,$BB,$13,$72,$46,$C8,$7A,$23,$EB,$14,$B2,$04,$87
            dc.b    $6F,$9D,$74,$42,$08,$08,$AD,$8D,$4D,$FC,$F2,$93,$F1,$22,$C0,$55
            dc.b    $5B,$E9,$32,$5B,$B0,$6B,$4E,$41,$90,$AC,$C9,$A9,$22,$75,$4A,$10
            dc.b    $36,$1A,$B2,$CE,$ED,$63,$6E,$74,$18,$C4,$0C,$BB,$DE,$01,$FE,$11
            dc.b    $AA,$09,$F5,$52,$07,$04,$91,$73,$B6,$66,$6A,$62,$CB,$86,$90,$36
            dc.b    $19,$20,$D9,$16,$4C,$A1,$A1,$FD,$6C,$EA,$08,$1D,$3D,$82,$3C,$3E
            dc.b    $C9,$6A,$AB,$4A,$1B,$73,$80,$6A,$1A,$0F,$67,$A0,$5D,$E7,$FB,$83
            dc.b    $E8,$76,$E7,$75,$9B,$5C,$8F,$37,$28,$06,$2A,$7E,$D6,$46,$30,$20
            dc.b    $B4,$16,$CC,$40,$D3,$B6,$C4,$0B,$BC,$E8,$34,$C7,$B8,$24,$54,$35
            dc.b    $1C,$9C,$4F,$08,$A1,$F4,$09,$FC,$7B,$93,$D0,$31,$40,$88,$82,$B5
            dc.b    $9F,$BA,$AA,$F6,$75,$03,$49,$5C,$D8,$5B,$EF,$D2,$AD,$96,$0F,$39
            dc.b    $4B,$B9,$E0,$5D,$9E,$56,$93,$BD,$BA,$CF,$DB,$76,$5A,$F3,$21,$EA
            dc.b    $EE,$F6,$B4,$AC,$98,$A8,$31,$25,$62,$21,$8D,$5F,$C6,$40,$5D,$E7
            dc.b    $FD,$EB,$D8,$F2,$B7,$77,$C5,$57,$B5,$27,$13,$56,$66,$C0,$9C,$0C
            dc.b    $2F,$41,$B3,$3D,$E1,$15,$E8,$1C,$CD,$6C,$41,$68,$67,$8D,$1E,$54
            dc.b    $58,$F2,$71,$8A,$39,$E4,$40,$BA,$7A,$AF,$24,$DE,$1E,$71,$1F,$69
            dc.b    $EB,$44,$06,$2A,$96,$33,$6C,$99,$54,$38,$5E,$AA,$E2,$26,$BA,$92
            dc.b    $38,$2E,$60,$91,$E9,$57,$B0,$8E,$88,$8C,$F9,$17,$83,$72,$18,$1E
            dc.b    $85,$3F,$12,$44,$D5,$BF,$C3,$FA,$A8,$59,$61,$E3,$5E,$78,$D5,$C9
            dc.b    $2E,$34,$10,$9A,$6A,$5D,$A2,$C8,$8B,$4F,$86,$6E,$BD,$AD,$1A,$00
            dc.b    $05,$49,$75,$94,$F0,$A5,$BC,$23,$DB,$6F,$07,$27,$49,$84,$98,$70
            dc.b    $13,$A6,$4C,$ED,$5F,$E3,$AE,$28,$2C,$CC,$83,$77,$F4,$7B,$88,$E6
            dc.b    $CF,$29,$DE,$DD,$E6,$D1,$46,$C3,$3E,$AA,$2C,$F0,$35,$0D,$C7,$D6
            dc.b    $33,$2A,$D2,$E0,$53,$23,$43,$64,$02,$2B,$F3,$03,$27,$DB,$94,$63
            dc.b    $6D,$05,$EC,$2D,$84,$61,$ED,$06,$6E,$FE,$B5,$3F,$17,$60,$D1,$AE
            dc.b    $C7,$B5,$01,$F8,$59,$17,$97,$3B,$A7,$5E,$03,$C0,$6B,$1D,$26,$65
            dc.b    $9C,$42,$5F,$38,$A9,$19,$2B,$4B,$F7,$BB,$22,$88,$2D,$64,$27,$F7
            dc.b    $24,$D7,$BE,$DC,$0B,$65,$AC,$A8,$37,$90,$E2,$CF,$5C,$47,$3A,$D9
            dc.b    $09,$91,$17,$15,$D0,$5A,$C8,$B3,$65,$D5,$D6,$C2,$01,$CE,$B7,$45
            dc.b    $C3,$DF,$58,$95,$C4,$8B,$E1,$2C,$86,$2D,$0B,$A2,$56,$55,$9D,$96
            dc.b    $4A,$D3,$76,$9D,$9D,$E6,$89,$49,$8C,$32,$A8,$AB,$73,$B3,$68,$02
            dc.b    $FE,$E0,$A5,$7B,$C1,$10,$E3,$43,$82,$A7,$48,$59,$0E,$4D,$AF,$A7
            dc.b    $0A,$30,$EE,$47,$AE,$94,$C1,$33,$55,$7D,$53,$FE,$1D,$35,$FA,$1F
            dc.b    $9A,$50,$BF,$7D,$F8,$E1,$28,$6B,$30,$CB,$5A,$9B,$03,$18,$CB,$F3
            dc.b    $A2,$6D,$81,$53,$21,$74,$50,$07,$3A,$9F,$19,$85,$60,$4A,$38,$F1
            dc.b    $F6,$7C,$A6,$9F,$4E,$AE,$56,$7C,$EF,$EC,$79,$01,$15,$EE,$70,$FB
            dc.b    $CA,$25,$B9,$D7,$32,$E2,$25,$4D,$47,$C6,$CA,$0E,$E4,$07,$47,$2E
            dc.b    $50,$2F,$EA,$B4,$77,$7F,$F6,$0A,$FB,$D0,$64,$5E,$97,$3E,$1C,$04
            dc.b    $71,$7E,$15,$CD,$DA,$D8,$A7,$A4,$DD,$54,$69,$DF,$61,$C3,$14,$84
            dc.b    $C5,$C7,$66,$22,$AC,$68,$3D,$80,$23,$9A,$6B,$71,$D1,$02,$F8,$DA
            dc.b    $7E,$95,$87,$4C,$89,$C9,$DF,$B7,$0C,$00,$85,$CA,$B3,$D4,$11,$19
            dc.b    $A6,$3D,$57,$9C,$EC,$80,$7B,$3C,$DC,$DA,$DD,$8C,$E0,$8A,$35,$D0
            dc.b    $93,$A9,$8B,$5A,$78,$4E,$45,$E1,$3F,$87,$B8,$C5,$48,$F8,$29,$81
            dc.b    $7D,$BD,$6F,$BC,$BF,$70,$7F,$79,$04,$79,$E4,$3A,$11,$B4,$37,$89
            dc.b    $CE,$37,$6D,$CC,$10,$89,$4B,$21,$F5,$A3,$65,$C1,$92,$BC,$78,$A3
            dc.b    $A3,$0C,$9B,$B9,$C0,$B1,$2D,$E9,$2A,$F1,$00,$A5,$34,$58,$1D,$A6
            dc.b    $F9,$FB,$CE,$8B,$41,$CA,$1B,$50,$D4,$1B,$C2,$EF,$E3,$8E,$5C,$29
            dc.b    $C2,$5F,$0D,$B8,$64,$EF,$C6,$90,$63,$B7,$7A,$6D,$43,$98,$B1,$EE
            dc.b    $91,$DE,$95,$1B,$46,$B0,$A4,$D3,$D2,$C5,$2F,$26,$F2,$BE,$F0,$E2
            dc.b    $8F,$85,$42
sub_40855DA2:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l (8,A6),A3
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            move.l  A3,-(SP)
            jsr     sub_408526F0
            moveq   #0,D0
            movea.l (-4,A6),A3
            unlk    A6
            rts
sub_40855DC4:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            subq.l  #4,SP
            moveq   #$48,D0
            move.l  D0,-(SP)
            jsr     sub_4085644E
            move.l  (SP)+,(A3)
            bne.b   .L1
            subq.l  #2,SP
            move.w  MemErr,(SP)
            move.w  (SP)+,D0
            bra.b   .L2
.L1:
            moveq   #1,D0
            move.l  D0,-(SP)
            move.l  (A3),-(SP)
            jsr     sub_40855DA2
            moveq   #0,D0
            addq.l  #8,SP
.L2:
            movea.l (SP)+,A3
            rts
sub_40855DF4:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($14,A6),D6
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            clr.w   D7
            bra.b   .L2
.L1:
            addq.w  #1,D7
.L2:
            cmpi.w  #2,D7
            bge.b   .L3
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            cmpi.l  #'PWD ',(A0)
            beq.b   .L1
.L3:
            cmpi.w  #2,D7
            blt.b   .L5
            tst.l   ($10,A6)
            beq.b   .L4
            move.l  D6,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            move.l  D6,D1
            add.l   ($10,A6),D1
            moveq   #$10,D2
            sub.l   D2,D1
            move.l  D1,-(SP)
            move.l  A4,-(SP)
            jsr     sub_40855DF4
            lea     ($10,SP),SP
            bra.b   .L10
.L4:
            moveq   #-5,D0
            bra.b   .L10
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            moveq   #8,D0
            move.l  D0,-(SP)
            jsr     sub_40856478
            moveq   #0,D0
            bra.b   .L10
.L5:
            clr.w   D7
            bra.b   .L7
.L6:
            addq.w  #1,D7
.L7:
            cmpi.w  #2,D7
            bge.b   .L8
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A3,D0
            movea.l D0,A0
            ext.l   D7
            move.l  D7,D0
            asl.l   #2,D0
            add.l   A4,D0
            movea.l D0,A1
            move.l  (A0),D0
            cmp.l   (A1),D0
            beq.b   .L6
.L8:
            cmpi.w  #2,D7
            blt.b   .L9
            moveq   #0,D0
            bra.b   .L10
.L9:
            moveq   #-5,D0
.L10:
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
sub_40855EA0:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            clr.b   D7
            movea.l A4,A3
.L1:
            tst.b   (A4)+
            beq.b   .L2
            move.b  D7,D0
            addq.b  #1,D7
            cmpi.b  #$1F,D0
            blt.b   .L1
.L2:
            cmpi.b  #$1F,D7
            blt.b   .L3
            moveq   #$1F,D7
.L3:
            move.l  A3,-(SP)
            move.l  ($C,A6),D0
            addq.l  #1,D0
            move.l  D0,-(SP)
            ext.w   D7
            ext.l   D7
            move.l  D7,-(SP)
            jsr     sub_40856478
            movea.l ($C,A6),A0
            move.b  D7,(A0)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
sub_40855EEA:
            link.w  A6,#-$36
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            movea.l ($26A,A3),A0
            move.b  (A0),D0
            ext.w   D0
            move.w  D0,(-$30,A6)
            pea     (-$2A,A6)
            movea.l ($26A,A3),A0
            pea     ($16,A0)
            jsr     sub_40855EA0
            movea.l ($26A,A3),A0
            tst.b   (5,A0)
            addq.l  #8,SP
            bne.b   .L1
            movea.l ($26A,A3),A0
            move.b  #2,(5,A0)
.L1:
            pea     ($1C,A3)
            pea     ($18,A3)
            pea     (4,A3)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (4,A0),D0
            move.l  D0,-(SP)
            pea     (-$32,A6)
            movea.l ($26A,A3),A0
            move.w  ($3E,A0),D0
            ext.l   D0
            move.l  D0,-(SP)
            movea.l ($26A,A3),A0
            moveq   #0,D0
            move.b  (5,A0),D0
            muls.w  #$3C,D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     sub_40852F3E
            move.w  D0,D7
            lea     ($1C,SP),SP
            bne.w   .L6
            moveq   #0,D0
            move.l  D0,(-$36,A6)
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     sub_40856464
            move.l  (SP)+,D0
            moveq   #$40,D1
            sub.l   D1,D0
            move.l  D0,-(SP)
            pea     (8,A3)
            move.l  (4,A3),-(SP)
            pea     (-$36,A6)
            jsr     sub_40853D9A
            move.l  D0,-(SP)
            jsr     sub_40853CC6
            move.w  D0,D7
            lea     ($14,SP),SP
            beq.b   .L2
            move.w  D7,D0
            bra.b   sub_40855EEA_L7
.L2:
            move.l  (-$36,A6),-(SP)
            jsr     sub_4085645A
            subq.l  #4,SP
            move.l  (4,A3),-(SP)
            jsr     sub_40856464
            move.l  (4,A3),-(SP)
            movea.l ($26A,A3),A0
            pea     (6,A0)
            pea     (8,A3)
            jsr     sub_40855DF4
            move.w  D0,D7
            lea     ($10,SP),SP
            beq.b   .L3
            move.l  (4,A3),-(SP)
            jsr     sub_4085645A
            moveq   #0,D0
            move.l  D0,(4,A3)
            move.w  D7,D0
            bra.b   sub_40855EEA_L7
.L3:
            tst.l   (4,A3)
            beq.b   .L4
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #1,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L5
.L4:
            moveq   #-6,D7
.L5:
            tst.w   D7
            beq.b   .L6
            move.w  D7,D0
            bra.b   sub_40855EEA_L7
.L6:
            move.w  D7,D0
sub_40855EEA_L7:
            movem.l (-$3E,A6),D7/A3
            unlk    A6
            rts
sub_40856022:
            link.w  A6,#-8
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($C,A6),A3
            move.w  (2,A3),D7
            tst.l   ($26A,A3)
            bne.b   .L1
            pea     ($26A,A3)
            jsr     sub_40855DC4
            move.w  D0,D7
            addq.l  #4,SP
            beq.b   .L1
            move.w  D7,D0
            bra.w   .L14
.L1:
            move.w  ($1A,A4),D0
            subq.w  #1,D0
            bmi.w   .L11
            cmpi.w  #4,D0
            bgt.w   .L11
            add.w   D0,D0
            move.w  .L3(PC,D0.w),D0
.L2:
            jmp     .L2+2(PC,D0.w)
.L3:
            dc.w    .L4-(.L2+2)
            dc.w    .L5-(.L2+2)
            dc.w    .L7-(.L2+2)
            dc.w    .L9-(.L2+2)
            dc.w    .L10-(.L2+2)
.L4:
            move.l  A3,-(SP)
            jsr     sub_40855EEA
            move.w  D0,D7
            addq.l  #4,SP
            bne.b   .L12
            pea     ($BA,A3)
            move.l  ($20,A4),-(SP)
            move.l  ($24,A4),-(SP)
            jsr     sub_40856478
            bra.b   .L12
.L5:
            tst.l   (4,A3)
            beq.b   .L6
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bra.b   .L12
.L6:
            moveq   #-6,D7
            bra.b   .L12
.L7:
            tst.l   (4,A3)
            beq.b   .L8
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  A3,-(SP)
            moveq   #3,D0
            move.l  D0,-(SP)
            movea.l (4,A3),A0
            jsr     (A0)
            move.w  D0,D7
            lea     ($10,SP),SP
            bne.b   .L12
            move.l  (-8,A6),($1C,A4)
            move.l  (-4,A6),($20,A4)
            bra.b   .L12
.L8:
            moveq   #-6,D7
            bra.b   .L12
.L9:
            moveq   #-$32,D7
            bra.b   .L12
.L10:
            move.l  A3,($1C,A4)
            bra.b   .L12
.L11:
            moveq   #-$32,D7
.L12:
            movea.l ($26A,A3),A0
            moveq   #$40,D0
            and.b   (3,A0),D0
            bne.b   .L13
            movea.l ($26A,A3),A0
            tst.w   ($3E,A0)
            beq.b   .L13
            tst.w   D7
            beq.b   .L13
            move.w  ($26E,A3),D0
            addq.w  #1,($26E,A3)
            cmpi.w  #5,D0
            blt.b   .L13
            movea.l ($26A,A3),A0
            addq.l  #6,A0
            move.l  A0,(-8,A6)
            addq.l  #4,(-8,A6)
            move.l  #'PWD ',(A0)
            movea.l (-8,A6),A0
            move.l  #'PWD ',(A0)
            movea.l ($26A,A3),A0
            clr.w   ($3E,A0)
            movea.l ($26A,A3),A0
            clr.b   ($16,A0)
            clr.w   ($26E,A3)
            move.w  D7,($270,A3)
.L13:
            move.w  D7,D0
.L14:
            movem.l (-$14,A6),D7/A3-A4
            unlk    A6
            rts
sub_40856164:
            bsr.w   InstallDRVRs_DRVR_50
            bne.w   .L4
            bsr.w   ReadPRAM_DRVR_50
            moveq   #1,D2
            moveq   #$10,D0
            addi.w  #$30A,D0
            _NewPtrSysClear
            bne.w   .L4
            move.w  D2,(A0)
            movea.l ExpandMem,A1
            lea     ($74,A1),A1
            move.l  A0,(A1)
            move.l  D1,-(SP)
            movea.l ExpandMem,A0
            movea.l ($74,A0),A0
            lea     LAPMgrPtr,A1
            movea.l UTableBase,A2
            moveq   #$24,D1
            movea.l (0,A2,D1.w),A2
            movea.l (A2),A2
            movea.l (A2),A2
            move.w  (8,A2),D1
            move.w  (-2,A2,D1.w),D1
            lea     (0,A2,D1.w),A3
            move.l  A3,D0
            _StripAddress
            move.l  D0,(A1)
            moveq   #$10,D0
            jsr     (2,A3)
            movea.l ExpandMem,A3
            movea.l ($74,A3),A3
            move.l  (SP)+,D1
            tst.b   D1
            bne.b   .L1
            bsr.w   InstallPrintAtlk_DRVR_50
            bra.b   .L2
.L1:
            bsr.w   sub_408561EC
            bne.b   .L4
.L2:
            lea     ($30A,A3),A3
            tst.l   (8,A3)
            bne.b   .L3
            bset    #5,(6,A3)
.L3:
            moveq   #0,D0
.L4:
            rts
sub_408561EC:
            movem.l D4,-(SP)
            moveq   #-1,D4
            bsr.w   InstallADEV
            move.l  D1,($312,A3)
            tst.w   D0
            beq.b   .L1
            bsr.w   sub_40856208
.L1:
            movem.l (SP)+,D4
            rts
sub_40856208:
            exg     D0,D1
            st      PortBUse
            moveq   #-$B,D0
            _DrvrRemove
            moveq   #-$A,D0
            _DrvrRemove
            movea.l ExpandMem,A1
            movea.l ($74,A1),A1
            move.l  ($1EE,A1),D0
            beq.b   .L1
            movea.l D0,A0
            move.w  #$A9A0,D0
            _SetTrapAddress
.L1:
            movea.l A1,A0
            _DisposPtr
            move.l  MinusOne,LAPMgrPtr
            move.l  D1,D0
            rts
InstallPrintAtlk_DRVR_50:
            move.w  #1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L1
            move.l  #$53432020,D1
            move.w  #$101,D1
            move.w  #$FFFF,D4
            bsr.b   sub_40856270
.L1:
            rts
GetRomAtlk_DRVR_50:
            move.l  D2,-(SP)
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'atlk',-(SP)
            move.w  D0,-(SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  (SP)+,D2
            rts
sub_40856270:
            movem.l D2-D4/A0/A2-A3,-(SP)
            movea.l A0,A3
            movea.l (A0),A0
            tst.w   D4
            bpl.b   .L1
            moveq   #0,D4
.L1:
            moveq   #1,D0
            jsr     (2,A0)
            movem.l (SP)+,D2-D4/A0/A2-A3
            tst.w   D0
            rts
InstallADEV:
            moveq   #0,D2
            clr.w   D0
            move.b  D1,D0
            bsr.b   GetRomAtlk_DRVR_50
            move.l  A0,D0
            beq.b   .L4
            move.l  D1,D3
            bsr.b   sub_40856270
            beq.b   .L2
.L1:
            move.w  D0,D2
            bra.b   .L4
.L2:
            bsr.b   CheckPramVal_DRVR_50
            bne.b   .L1
            cmp.l   D1,D3
            beq.b   .L3
            bsr.w   sub_4085634C
.L3:
            moveq   #0,D0
            nop
.L4:
            tst.w   D0
            rts
CheckPramVal_DRVR_50:
            moveq   #0,D0
            move.b  D3,D1
            tst.w   D4
            bmi.b   .L1
            cmp.l   D1,D3
            beq.b   .L1
            movea.l (A0),A0
            bsr.w   sub_408562CE
            moveq   #-1,D0
.L1:
            tst.w   D0
            rts
sub_408562CE:
            movem.l D0-D3/A0-A3,-(SP)
            moveq   #2,D0
            jsr     (2,A0)
            movem.l (SP)+,D0-D3/A0-A3
            rts
InstallDRVRs_DRVR_50:
            moveq   #-$B,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #-$A,D3
            bsr.b   sub_408562F2
            bne.b   .L1
            moveq   #0,D0
            rts
.L1:
            moveq   #-1,D0
            rts
sub_408562F2:
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'DRVR',-(SP)
            move.w  D3,-(SP)
            not.w   (SP)
            _GetResource
            movea.l (SP)+,A0
            move.l  A0,-(SP)
            move.l  A0,D0
            beq.b   InstallDRVRs_DRVR_50.L1
            move.w  D3,D0
            _DrvrInstall async
            movea.l UTableBase,A0
            not.w   D3
            lsl.w   #2,D3
            movea.l (0,A0,D3.w),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A1),(A0)
            movea.l (A0),A1
            move.b  (A1),(4,A0)
            bclr    #6,(5,A0)
            moveq   #0,D0
            rts
ReadPRAM_DRVR_50:
            clr.l   -(SP)
            btst    #$E,HWCfgFlags
            beq.b   .L1
            movea.l SP,A0
            move.l  #$400E0,D0
            _ReadXPRam
.L1:
            move.l  (SP)+,D1
            rts
sub_4085634C:
            move.l  A0,-(SP)
            move.l  D1,-(SP)
            movea.l SP,A0
            move.l  #$400E0,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l (SP)+,A0
            rts
            move.l  (4,SP),D0
            move.l  (8,SP),D1
sub_40856368:
            move.l  D2,-(SP)
            move.l  D0,D2
            mulu.w  D1,D2
            movea.l D2,A0
            move.l  D1,D2
            swap    D2
            mulu.w  D0,D2
            swap    D0
            mulu.w  D0,D1
            add.w   D1,D2
            swap    D2
            clr.w   D2
            adda.l  D2,A0
            move.l  A0,D0
            move.l  (SP)+,D2
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_40856390:
            jsr     sub_408563A0
            move.l  D1,D0
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563A0:
            movem.l D5-D6,-(SP)
            move.l  D0,D5
            bpl.b   .L1
            neg.l   D0
.L1:
            move.l  D1,D6
            bpl.b   .L2
            neg.l   D1
.L2:
            jsr     sub_408563CE
            tst.l   D5
            bpl.b   .L3
            neg.l   D0
.L3:
            eor.l   D5,D6
            bpl.b   .L4
            neg.l   D1
.L4:
            movem.l (SP)+,D5-D6
            rts
            move.l  (4,SP),D1
            move.l  (8,SP),D0
sub_408563CE:
            movem.l D2-D4,-(SP)
            move.l  D1,D2
            swap    D2
            tst.w   D2
            bne.b   .L2
            move.w  D0,D3
            clr.w   D0
            swap    D0
            beq.b   .L1
            divu.w  D1,D0
            move.w  D0,D2
.L1:
            swap    D2
            move.w  D3,D0
            divu.w  D1,D0
            move.w  D0,D2
            move.l  D2,D1
            clr.w   D0
            swap    D0
            bra.b   .L5
.L2:
            move.l  D0,D2
            clr.w   D0
            swap    D0
            swap    D2
            clr.w   D2
            move.l  D1,D3
            moveq   #0,D1
            moveq   #$F,D4
.L3:
            add.l   D2,D2
            addx.l  D0,D0
            add.l   D1,D1
            cmp.l   D3,D0
            blt.b   .L4
            sub.l   D3,D0
            addq.b  #1,D1
.L4:
            dbra    D4,.L3
.L5:
            movem.l (SP)+,D2-D4
            rts
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _CompactMem
            move.l  D0,(SP)
            nop
.L6:
            moveq   #0,D0
.L7:
            move.l  A1,-(SP)
.L8:
            move.w  D0,MemErr
            rts
            moveq   #0,D0
            bra.b   .L8
sub_40856436:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtr
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_40856442:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSys
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_4085644E:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            _NewPtrSysClear
            move.l  A0,(SP)
            jmp     sub_408563CE.L7
sub_4085645A:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposPtr
            jmp     sub_408563CE.L7
sub_40856464:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _GetPtrSize
            move.l  D0,(SP)
            bpl.b   .L1
            clr.l   (SP)
            jmp     sub_408563CE.L7
.L1:
            jmp     sub_408563CE.L6
sub_40856478:
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _BlockMove
            movea.l D1,A1
            jmp     sub_408563CE.L7
            move.w  ROM85,D0
            bpl.b   .L1
            btst    #5,PortBUse
            beq.b   .L1
            move.w  #$FFD7,D1
            moveq   #0,D0
            bra.b   .L2
.L1:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_408565A8.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            move.w  ($18,A0),D1
            adda.w  #$32,SP
.L2:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.w  D1,(A1)
            move.w  D0,(SP)
            jmp     (A0)
            move.w  #$F5,D0
            bra.w   sub_408564FC.L1
            move.w  #$F4,D0
            bra.w   sub_408564FC.L1
            move.w  #$F3,D0
            bra.w   sub_408564FC.L1
            move.w  #$F8,D0
            bra.w   sub_408564FC.L1
            move.w  #$F7,D0
            bra.w   sub_408564FC.L1
sub_408564EC:
            move.w  #$F6,D0
            bra.w   sub_408564FC.L1
            move.w  #$FD,D0
            bra.w   sub_408564FC.L1
sub_408564FC:
            move.w  #$FB,D0
            bra.w   .L1
            move.w  #$FA,D0
            bra.w   .L1
            move.w  #$FC,D0
            bra.w   .L1
            move.w  #$100,D0
            bra.w   .L1
            move.w  #$FE,D0
            bra.b   .L1
            move.w  #$FE,D0
            bra.w   sub_408565A8
            move.w  #$FA,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8
            move.w  #$FD,D0
            bra.b   sub_408565A8
            move.w  #$FC,D0
            bra.b   sub_408565A8
            move.w  #$FB,D0
            bra.b   sub_408565A8
            move.w  #$100,D0
            bra.b   sub_408565A8
            move.w  #$F9,D0
            bra.b   sub_408565A8
            move.w  #$F8,D0
            bra.b   sub_408565A8
            move.w  #$102,D0
            bra.b   sub_408565A8
            move.w  #$101,D0
            bra.b   sub_408565A8
            move.w  #$FF,D0
            bra.b   sub_408565A8.L1
            move.w  #$FE,D0
            bra.b   sub_408565A8.L1
            move.w  #$F8,D0
            bra.b   sub_408565A8.L1
            move.w  #$F9,D0
            bra.b   sub_408565A8.L1
            move.w  #$F7,D0
            bra.b   sub_408565A8.L1
            move.w  #$FC,D0
            bra.b   sub_408565A8.L1
            move.w  #$FD,D0
            bra.b   sub_408565A8.L1
            move.w  #$FB,D0
            bra.b   sub_408565A8.L1
            move.w  #$FA,D0
            bra.b   sub_408565A8.L1
.L1:
            movea.l (6,SP),A0
            move.w  #$FFF6,($18,A0)
            bra.b   sub_408565A8.L1
sub_408565A8:
            movea.l (6,SP),A0
            move.w  #$FFF5,($18,A0)
.L1:
            movea.l (SP)+,A1
            move.b  (SP)+,D1
            movea.l (SP)+,A0
            move.w  D0,($1A,A0)
            tst.b   D1
            bne.b   .L2
            _Control
            bra.b   .L3
.L2:
            _Control async
.L3:
            move.w  D0,(SP)
            jmp     (A1)
.L4:
            dc.b    4,'.XPP'
            dc.b    $00
sub_408565D0:
            movem.l D1-D2/A0-A2,-(SP)
            movem.l ($18,SP),D1-D2/A0-A2
            pea     (1,A1)
            move.l  (SP)+,(2,A2)
            move.l  A0,(8,A2)
            clr.w   ($C,A2)
            swap    D2
            move.w  D2,(8,A1)
            swap    D2
            move.b  D2,($E,A1)
            asr.w   #8,D2
            move.b  D2,($C,A1)
            move.b  D1,($10,A1)
            swap    D1
            move.w  D1,(6,A2)
            movem.l (SP)+,D1-D2/A0-A2
            move.l  (SP),($14,SP)
            adda.w  #$14,SP
            rts
sub_40856614:
            movem.l D0/A0-A1,-(SP)
            moveq   #$1C,D0
            bsr.b   sub_40856636
            move.w  #$18,D0
            bsr.b   sub_40856636
            move.w  #$14,D0
            bsr.b   sub_40856636
            movem.l (SP)+,D0/A0-A1
            move.l  (SP),($10,SP)
            adda.w  #$10,SP
            rts
sub_40856636:
            movea.l (0,SP,D0.w),A0
            moveq   #0,D0
            move.b  (A0),D0
            addq.l  #1,D0
            movea.l ($20,SP),A1
            add.l   D0,($20,SP)
            _BlockMove
            rts
.L1:
            ds.b    28
.L2:
            ds.b    72
.L3:
            ds.b    26
.L4:
            dc.b    4,'.MPP'
            dc.b    $20,$04,$2E,$41,$54,$50,$20
            ds.b    102
RemoveHdlBlks:
            movem.l A1-A2,-(SP)
            lea     sub_40856636.L1,A1
.L1:
            move    SR,-(SP)
            move    #$2600,SR
            movea.l (A1),A0
            movea.l (A0),A2
            move.l  A0,D0
            beq.b   .L2
            move.l  (A2),(A1)
.L2:
            move    (SP)+,SR
            tst.l   D0
            beq.b   .L3
            _DisposHandle
            bra.b   .L1
.L3:
            movem.l (SP)+,A1-A2
            rts
.L4:
            move.l  (SP)+,D3
            move.w  D0,(SP)
            movea.l D2,A1
            jmp     (A1)
UnlockAndLinkHdl:
            move.l  A1,-(SP)
            _HUnlock
            movea.l (A0),A1
            move    SR,-(SP)
            move    #$2600,SR
            move.l  sub_40856636.L1,(A1)
            lea     sub_40856636.L1,A1
            move.l  A0,(A1)
            move    (SP)+,SR
            movea.l (SP)+,A1
            rts
IsMPPOpen:
            moveq   #0,D1
            move.b  PortBUse,D0
            bmi.b   .L1
            andi.b  #$F,D0
            subq.b  #1,D0
            bne.b   .L1
            moveq   #1,D1
.L1:
            move.b  D1,(4,SP)
            rts
MPPOpen_piMAIN:
            clr.w   -(SP)
            jsr     IsMPPOpen
            clr.w   D0
            tst.b   (SP)+
            bne.b   .L3
            move.b  PortBUse,D1
            bmi.b   .L1
            moveq   #-$61,D0
            bra.b   .L3
.L1:
            move.b  SPConfig,D0
            andi.b  #$F,D0
            subq.b  #1,D0
            ble.b   .L2
            moveq   #-$62,D0
            bra.b   .L3
.L2:
            suba.w  #$32,SP
            movea.l SP,A0
            lea     sub_40856636.L4,A1
            move.l  A1,($12,A0)
            clr.b   ($1B,A0)
            _Open
            adda.w  #$32,SP
.L3:
            move.w  D0,(4,SP)
            rts
sub_408567E4:
            moveq   #4,D3
            cmp.w   D3,D1
            bcc.b   .L1
            move.w  D1,D3
.L1:
            lea     sub_40856636.L3,A5
            move.l  A3,(2,A5)
            move.w  D3,D2
            swap    D2
            move.b  D0,D2
            tst.w   D3
            beq.b   .L2
            jsr     (A4)
            bne.b   .L4
.L2:
            lea     sub_40856636.L2,A3
            moveq   #$B,D3
.L3:
            cmp.b   (0,A3,D3.w),D2
            dbeq    D3,.L3
            bne.b   .L5
            lsl.w   #2,D3
            move.w  D3,(A5)
            movea.l ($18,A3,D3.w),A3
            move.l  A3,D0
            beq.b   .L5
            movea.l (4,A3),A3
            movea.l (A3),A3
            move.w  ($10,A3),D3
            movea.l ($14,A3),A3
            swap    D2
            adda.w  D2,A3
            sub.w   D2,D3
            jsr     (2,A4)
            bne.b   .L4
            bra.b   .L6
.L4:
            rts
.L5:
            moveq   #0,D3
            jmp     (2,A4)
.L6:
            tst.w   D3
            bge.b   .L7
            move.w  #$F3E3,D0
.L7:
            move.l  A2,-(SP)
            lea     sub_40856636.L3,A1
            lea     sub_40856636.L2,A2
            move.w  (A1),D1
            movea.l ($18,A2,D1.w),A2
            movea.l (4,A2),A0
            movea.l (A0),A0
            move.w  ($10,A0),D1
            sub.w   D3,D1
            move.w  D1,($12,A0)
            movea.l (2,A1),A3
            movea.l ($14,A0),A2
            cmp.w   ($10,A0),D2
            ble.b   .L8
            move.w  ($10,A0),D2
.L8:
            subq.w  #1,D2
            blt.b   .L9
            move.b  (0,A3,D2.w),(0,A2,D2.w)
            bra.b   .L8
.L9:
            movea.l (SP)+,A2
            move.w  D0,(2,A0)
            clr.b   (8,A0)
            move.b  (-1,A3),(9,A0)
            move.b  (-2,A3),($F,A0)
            clr.b   ($18,A0)
            move.b  (1,A2),($19,A0)
            move.w  (A1),D2
            move.w  D2,D1
            lsr.w   #2,D1
            lea     sub_40856636.L2,A1
            cmpi.b  #1,(3,A2)
            bne.b   .L10
            move.b  (2,A2),($E,A0)
            clr.w   ($C,A0)
            movea.l ($18,A1,D2.w),A3
            bra.b   .L11
.L10:
            move.b  (-4,A3),($E,A0)
            move.w  (-7,A3),($C,A0)
            tst.w   (-$B,A3)
            movea.l ($18,A1,D2.w),A3
            beq.b   .L11
            tst.w   D0
            bne.b   .L11
            bsr.w   CalcCheckSum
            beq.b   .L11
            tst.b   (9,A3)
            beq.b   .L14
            move.w  #$F3E1,(2,A0)
.L11:
            movea.l (4,A3),A0
            _HUnlock
            tst.b   (8,A3)
            beq.b   .L12
            move.l  A0,D0
            movea.w #$A,A0
            _PostEvent
            bra.b   .L13
.L12:
            st      ($C,A1,D1.w)
.L13:
            move.l  (A3),($18,A1,D2.w)
            movea.l ($A,A3),A0
            jsr     UnlockAndLinkHdl
.L14:
            rts
CalcCheckSum:
            movem.l D1/A1,-(SP)
            clr.w   D3
            lea     (8,A2),A1
            moveq   #9,D1
            bsr.b   sub_40856946
            movea.l ($14,A0),A1
            move.w  ($12,A0),D1
            bsr.b   sub_40856946
            tst.w   D3
            bne.b   .L1
            subq.w  #1,D3
.L1:
            sub.w   (6,A2),D3
            movem.l (SP)+,D1/A1
            rts
sub_40856946:
            clr.w   D0
            subq.w  #1,D1
.L1:
            move.b  (A1)+,D0
            add.w   D0,D3
            rol.w   #1,D3
            dbra    D1,.L1
            rts
sub_40856956:
            lea     sub_40856636.L2,A1
            moveq   #$B,D1
.L1:
            cmp.b   (0,A1,D1.w),D3
            dbeq    D1,.L1
            rts
DDPOpenSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            move.l  A1,D1
            bne.b   .L1
            lea     sub_408567E4,A1
            move.l  A1,D1
.L1:
            movea.l (SP)+,A1
            move.l  D3,-(SP)
            move.b  (1,A1),D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.l  D1,($1E,A0)
            move.w  #$F8,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            tst.w   D0
            bne.b   .L4
            move.b  ($1C,A0),D3
            move.b  D3,(1,A1)
            lea     sub_408567E4,A0
            cmpa.l  D1,A0
            bne.b   .L4
            lea     sub_40856636.L2,A1
            move.w  #$B,D1
.L2:
            tst.b   (0,A1,D1.w)
            dbeq    D1,.L2
            bne.b   .L3
            move.b  D3,(0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            clr.l   ($18,A1,D1.w)
            bra.b   .L4
.L3:
            move.w  #$FFA5,D0
.L4:
            adda.w  #$32,SP
            jmp     RemoveHdlBlks.L4
DDPCloseSocket:
            jsr     RemoveHdlBlks
            move.l  (SP)+,D2
            move.w  (SP)+,D0
            move.l  D3,-(SP)
            move.b  D0,D3
            suba.w  #$32,SP
            movea.l SP,A0
            move.b  D3,($1C,A0)
            move.w  #$F7,($1A,A0)
            move.w  #$FFF6,($18,A0)
            _Control
            adda.w  #$32,SP
            tst.b   D0
            bne.b   .L2
            jsr     sub_40856956
            bne.b   .L2
            clr.b   (0,A1,D1.w)
            clr.b   ($C,A1,D1.w)
            lsl.w   #2,D1
            movea.l ($18,A1,D1.w),A0
            clr.l   ($18,A1,D1.w)
            movea.l A0,A1
.L1:
            move.l  A1,D0
            beq.b   .L2
            movea.l (4,A1),A0
            _HUnlock
            movea.l A1,A0
            _RecoverHandle
            movea.l (A1),A1
            jsr     UnlockAndLinkHdl
            bra.b   .L1
.L2:
            jmp     RemoveHdlBlks.L4
NBPExtract:
            jsr     RemoveHdlBlks
            lea     ($C,SP),A0
            move.w  #$F3E0,D2
            move.w  (A0)+,D1
            beq.b   .L5
            cmp.w   (A0)+,D1
            bhi.b   .L5
            movea.l (A0),A1
.L1:
            subq.w  #1,D1
            beq.b   .L2
            addq.w  #5,A1
            clr.w   D2
            move.b  (A1),D2
            add.b   (1,A1,D2.w),D2
            add.b   (2,A1,D2.w),D2
            addq.b  #3,D2
            adda.w  D2,A1
            bra.b   .L1
.L2:
            movea.l (4,SP),A0
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            addq.w  #1,A1
            moveq   #3,D2
            move.l  (8,SP),D0
.L3:
            movea.l D0,A0
            move.b  (A1),D1
.L4:
            move.b  (A1)+,(A0)+
            subq.b  #1,D1
            bcc.b   .L4
            addi.l  #$22,D0
            subq.w  #1,D2
            bne.b   .L3
.L5:
            movea.l (SP)+,A1
            adda.w  #$10,SP
            move.w  D2,(SP)
            jmp     (A1)
sub_40856A9E:
            link.w  A6,#0
            movem.l D6-D7/A3-A4,-(SP)
            move.l  ($10,A6),D6
            move.l  ($C,A6),D7
            movea.l (8,A6),A4
            movea.l A4,A3
            bra.b   .L2
.L1:
            move.b  D7,(A4)+
.L2:
            move.l  D6,D0
            subq.l  #1,D6
            tst.l   D0
            bhi.b   .L1
            move.l  A3,D0
            movem.l (-$10,A6),D6-D7/A3-A4
            unlk    A6
            rts
            dc.b    $86,$6D,$65,$6D,$73,$65,$74
            ds.b    13
RsrcEntryRSRC_3:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'RSRC' 3 (2052 bytes) - Combo mask
            dc.l    RsrcEntryDRVR_50-BaseOfROM      ; Next entry
            dc.l    RsrcRSRC_3-BaseOfROM            ; Data
            dc.b    'RSRC'                          ; Type
            dc.w    3                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000810,$000001CC   ; Block header
RsrcRSRC_3:
            ds.b    2048
RsrcEntryapad_0:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'apad' 0 "Main" (3140 bytes) - Combo mask
            dc.l    RsrcEntryRSRC_3-BaseOfROM       ; Next entry
            dc.l    Rsrcapad_0-BaseOfROM            ; Data
            dc.b    'apad'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            ds.b    8
            dc.l    $C0A00000,$00000C50,$000001C4   ; Block header
Rsrcapad_0:
            ds.b    3136
RsrcEntryPICT_501:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'PICT' 501 "Decrypt Data" (276 bytes) - Combo mask
            dc.l    RsrcEntryapad_0-BaseOfROM       ; Next entry
            dc.l    RsrcPICT_501-BaseOfROM          ; Data
            dc.b    'PICT'                          ; Type
            dc.w    501                             ; ID
            dc.b    $58                             ; Attributes
            dc.b    12,'Decrypt Data'               ; Name
            dc.l    $C0A00000,$00000120,$000001BC   ; Block header
RsrcPICT_501:
            dc.w    $0112,$007B,$0052,$0093,$0091,$1101,$A000,$82A0
            dc.b    $00,$8E,$01,$00,$0A
            ds.b    4
            dc.b    $02,$D0,$02,$40,$98,$00,$0A,$00,$7B,$00,$50,$00,$93,$00,$98,$00
            dc.b    $7B,$00,$52,$00,$93,$00,$91,$00,$7B,$00,$52,$00,$93,$00,$91,$00
            dc.b    $00,$02,$F7,$00,$02,$F7,$00,$09,$00,$1E,$FD,$00,$01,$30,$30,$FE
            dc.b    $00,$09,$00,$1B,$FD,$00,$01,$30,$30,$FE,$00,$0B,$07,$19,$9C,$73
            dc.b    $ED,$9E,$78,$3C,$D8,$FF,$00,$0B,$07,$19,$B6,$DB,$8D,$9B,$30,$36
            dc.b    $D8,$FF,$00,$0B,$07,$19,$BE,$C3,$0D,$9B,$30,$36,$D8,$FF,$00,$0B
            dc.b    $07,$1B,$30,$DB,$0D,$9B,$30,$36,$D8,$FF,$00,$0B,$07,$1E,$1C,$73
            dc.b    $07,$9E,$18,$3C,$78,$FF,$00,$0A,$FE,$00,$04,$01,$98,$00,$00,$18
            dc.b    $FF,$00,$0A,$FE,$00,$04,$07,$18,$00,$00,$70,$FF,$00,$02,$F7,$00
            dc.b    $02,$F7,$00,$02,$F7,$00,$0B,$00,$0F,$FE,$00,$03,$1F,$00,$C1,$80
            dc.b    $FF,$00,$0A,$06,$19,$80,$00,$00,$19,$80,$C0,$FE,$00,$0B,$07,$19
            dc.b    $B0,$CE,$78,$19,$B6,$F3,$BC,$FF,$00,$0B,$07,$19,$9F,$9B,$6C,$1F
            dc.b    $36,$D9,$B6,$FF,$00,$0B,$07,$19,$9F,$9F,$6C,$1E,$36,$D9,$B6,$FF
            dc.b    $00,$0B,$07,$19,$8F,$18,$6C,$1B,$36,$D9,$B6,$FF,$00,$0B,$07,$0F
            dc.b    $0F,$0E,$6C,$19,$9E,$F1,$B6,$FF,$00,$02,$F7,$00,$02,$F7,$00,$02
            dc.b    $F7,$00,$A0,$00,$8F,$A0,$00,$83,$FF
            dc.b    $00
            dc.b    $00
            ds.b    12
RsrcEntryattx_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'attx' 1 (5124 bytes) - Combo mask
            dc.l    RsrcEntryPICT_501-BaseOfROM     ; Next entry
            dc.l    Rsrcattx_1-BaseOfROM            ; Data
            dc.b    'attx'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00001410,$000001B4   ; Block header
Rsrcattx_1:
            ds.b    7
            dc.b    $0F,$00,$00,$00,$F0,$00,$00,$00,$FF,$00,$00,$0F,$00,$00,$00,$0F
            dc.b    $0F,$00,$00,$0F,$F0,$00,$00,$0F,$FF,$00,$00,$F0,$00,$00,$00,$F0
            dc.b    $0F,$00,$00,$F0,$F0,$00,$00,$F0,$FF,$00,$00,$FF,$00,$00,$00,$FF
            dc.b    $0F,$00,$00,$FF,$F0,$00,$00,$FF,$FF,$00,$0F,$00,$00,$00,$0F,$00
            dc.b    $0F,$00,$0F,$00,$F0,$00,$0F,$00,$FF,$00,$0F,$0F,$00,$00,$0F,$0F
            dc.b    $0F,$00,$0F,$0F,$F0,$00,$0F,$0F,$FF,$00,$0F,$F0,$00,$00,$0F,$F0
            dc.b    $0F,$00,$0F,$F0,$F0,$00,$0F,$F0,$FF,$00,$0F,$FF,$00,$00,$0F,$FF
            dc.b    $0F,$00,$0F,$FF,$F0,$00,$0F,$FF,$FF,$00,$F0,$00,$00,$00,$F0,$00
            dc.b    $0F,$00,$F0,$00,$F0,$00,$F0,$00,$FF,$00,$F0,$0F,$00,$00,$F0,$0F
            dc.b    $0F,$00,$F0,$0F,$F0,$00,$F0,$0F,$FF,$00,$F0,$F0,$00,$00,$F0,$F0
            dc.b    $0F,$00,$F0,$F0,$F0,$00,$F0,$F0,$FF,$00,$F0,$FF,$00,$00,$F0,$FF
            dc.b    $0F,$00,$F0,$FF,$F0,$00,$F0,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $0F,$00,$FF,$00,$F0,$00,$FF,$00,$FF,$00,$FF,$0F,$00,$00,$FF,$0F
            dc.b    $0F,$00,$FF,$0F,$F0,$00,$FF,$0F,$FF,$00,$FF,$F0,$00,$00,$FF,$F0
            dc.b    $0F,$00,$FF,$F0,$F0,$00,$FF,$F0,$FF,$00,$FF,$FF,$00,$00,$FF,$FF
            dc.b    $0F,$00,$FF,$FF,$F0,$00,$FF,$FF,$FF,$0F,$00,$00,$00,$0F,$00,$00
            dc.b    $0F,$0F,$00,$00,$F0,$0F,$00,$00,$FF,$0F,$00,$0F,$00,$0F,$00,$0F
            dc.b    $0F,$0F,$00,$0F,$F0,$0F,$00,$0F,$FF,$0F,$00,$F0,$00,$0F,$00,$F0
            dc.b    $0F,$0F,$00,$F0,$F0,$0F,$00,$F0,$FF,$0F,$00,$FF,$00,$0F,$00,$FF
            dc.b    $0F,$0F,$00,$FF,$F0,$0F,$00,$FF,$FF,$0F,$0F,$00,$00,$0F,$0F,$00
            dc.b    $0F,$0F,$0F,$00,$F0,$0F,$0F,$00,$FF,$0F,$0F,$0F,$00,$0F,$0F,$0F
            dc.b    $0F,$0F,$0F,$0F,$F0,$0F,$0F,$0F,$FF,$0F,$0F,$F0,$00,$0F,$0F,$F0
            dc.b    $0F,$0F,$0F,$F0,$F0,$0F,$0F,$F0,$FF,$0F,$0F,$FF,$00,$0F,$0F,$FF
            dc.b    $0F,$0F,$0F,$FF,$F0,$0F,$0F,$FF,$FF,$0F,$F0,$00,$00,$0F,$F0,$00
            dc.b    $0F,$0F,$F0,$00,$F0,$0F,$F0,$00,$FF,$0F,$F0,$0F,$00,$0F,$F0,$0F
            dc.b    $0F,$0F,$F0,$0F,$F0,$0F,$F0,$0F,$FF,$0F,$F0,$F0,$00,$0F,$F0,$F0
            dc.b    $0F,$0F,$F0,$F0,$F0,$0F,$F0,$F0,$FF,$0F,$F0,$FF,$00,$0F,$F0,$FF
            dc.b    $0F,$0F,$F0,$FF,$F0,$0F,$F0,$FF,$FF,$0F,$FF,$00,$00,$0F,$FF,$00
            dc.b    $0F,$0F,$FF,$00,$F0,$0F,$FF,$00,$FF,$0F,$FF,$0F,$00,$0F,$FF,$0F
            dc.b    $0F,$0F,$FF,$0F,$F0,$0F,$FF,$0F,$FF,$0F,$FF,$F0,$00,$0F,$FF,$F0
            dc.b    $0F,$0F,$FF,$F0,$F0,$0F,$FF,$F0,$FF,$0F,$FF,$FF,$00,$0F,$FF,$FF
            dc.b    $0F,$0F,$FF,$FF,$F0,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $F0,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$00,$FF,$FF,$F0,$FF,$FF,$FF,$F0
            dc.b    $F0,$FF,$FF,$F0,$0F,$FF,$FF,$F0,$00,$FF,$FF,$0F,$FF,$FF,$FF,$0F
            dc.b    $F0,$FF,$FF,$0F,$0F,$FF,$FF,$0F,$00,$FF,$FF,$00,$FF,$FF,$FF,$00
            dc.b    $F0,$FF,$FF,$00,$0F,$FF,$FF,$00,$00,$FF,$F0,$FF,$FF,$FF,$F0,$FF
            dc.b    $F0,$FF,$F0,$FF,$0F,$FF,$F0,$FF,$00,$FF,$F0,$F0,$FF,$FF,$F0,$F0
            dc.b    $F0,$FF,$F0,$F0,$0F,$FF,$F0,$F0,$00,$FF,$F0,$0F,$FF,$FF,$F0,$0F
            dc.b    $F0,$FF,$F0,$0F,$0F,$FF,$F0,$0F,$00,$FF,$F0,$00,$FF,$FF,$F0,$00
            dc.b    $F0,$FF,$F0,$00,$0F,$FF,$F0,$00,$00,$FF,$0F,$FF,$FF,$FF,$0F,$FF
            dc.b    $F0,$FF,$0F,$FF,$0F,$FF,$0F,$FF,$00,$FF,$0F,$F0,$FF,$FF,$0F,$F0
            dc.b    $F0,$FF,$0F,$F0,$0F,$FF,$0F,$F0,$00,$FF,$0F,$0F,$FF,$FF,$0F,$0F
            dc.b    $F0,$FF,$0F,$0F,$0F,$FF,$0F,$0F,$00,$FF,$0F,$00,$FF,$FF,$0F,$00
            dc.b    $F0,$FF,$0F,$00,$0F,$FF,$0F,$00,$00,$FF,$00,$FF,$FF,$FF,$00,$FF
            dc.b    $F0,$FF,$00,$FF,$0F,$FF,$00,$FF,$00,$FF,$00,$F0,$FF,$FF,$00,$F0
            dc.b    $F0,$FF,$00,$F0,$0F,$FF,$00,$F0,$00,$FF,$00,$0F,$FF,$FF,$00,$0F
            dc.b    $F0,$FF,$00,$0F,$0F,$FF,$00,$0F,$00,$FF,$00,$00,$FF,$FF,$00,$00
            dc.b    $F0,$FF,$00,$00,$0F,$FF,$00,$00,$00,$F0,$FF,$FF,$FF,$F0,$FF,$FF
            dc.b    $F0,$F0,$FF,$FF,$0F,$F0,$FF,$FF,$00,$F0,$FF,$F0,$FF,$F0,$FF,$F0
            dc.b    $F0,$F0,$FF,$F0,$0F,$F0,$FF,$F0,$00,$F0,$FF,$0F,$FF,$F0,$FF,$0F
            dc.b    $F0,$F0,$FF,$0F,$0F,$F0,$FF,$0F,$00,$F0,$FF,$00,$FF,$F0,$FF,$00
            dc.b    $F0,$F0,$FF,$00,$0F,$F0,$FF,$00,$00,$F0,$F0,$FF,$FF,$F0,$F0,$FF
            dc.b    $F0,$F0,$F0,$FF,$0F,$F0,$F0,$FF,$00,$F0,$F0,$F0,$FF,$F0,$F0,$F0
            dc.b    $F0,$F0,$F0,$F0,$0F,$F0,$F0,$F0,$00,$F0,$F0,$0F,$FF,$F0,$F0,$0F
            dc.b    $F0,$F0,$F0,$0F,$0F,$F0,$F0,$0F,$00,$F0,$F0,$00,$FF,$F0,$F0,$00
            dc.b    $F0,$F0,$F0,$00,$0F,$F0,$F0,$00,$00,$F0,$0F,$FF,$FF,$F0,$0F,$FF
            dc.b    $F0,$F0,$0F,$FF,$0F,$F0,$0F,$FF,$00,$F0,$0F,$F0,$FF,$F0,$0F,$F0
            dc.b    $F0,$F0,$0F,$F0,$0F,$F0,$0F,$F0,$00,$F0,$0F,$0F,$FF,$F0,$0F,$0F
            dc.b    $F0,$F0,$0F,$0F,$0F,$F0,$0F,$0F,$00,$F0,$0F,$00,$FF,$F0,$0F,$00
            dc.b    $F0,$F0,$0F,$00,$0F,$F0,$0F,$00,$00,$F0,$00,$FF,$FF,$F0,$00,$FF
            dc.b    $F0,$F0,$00,$FF,$0F,$F0,$00,$FF,$00,$F0,$00,$F0,$FF,$F0,$00,$F0
            dc.b    $F0,$F0,$00,$F0,$0F,$F0,$00,$F0,$00,$F0,$00,$0F,$FF,$F0,$00,$0F
            dc.b    $F0,$F0,$00,$0F,$0F,$F0,$00,$0F,$00,$F0,$00,$00,$FF,$F0,$00,$00
            dc.b    $F0,$F0,$00,$00,$0F,$F0
            ds.b    17
            dc.b    $FF
            ds.b    6
            dc.b    $FF
            ds.b    7
            dc.b    $FF,$FF
            ds.b    5
            dc.b    $FF
            ds.b    7
            dc.b    $FF,$00,$FF
            ds.b    5
            dc.w    $FFFF
            ds.b    6
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF
            ds.b    7
            dc.b    $FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$FF
            ds.b    5
            dc.b    $FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF
            ds.b    6
            dc.b    $FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF,$FF,$00,$00,$00,$FF
            ds.b    7
            dc.w    $FF00,0,$FF00,0,$FF00,$00FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF,$FF,$00,$00,$00,$FF,$00,$FF
            ds.b    5
            dc.w    $FF00,$FF00,$FF00,0,$FF00,$FFFF
            ds.b    4
            dc.w    $FF00,$FFFF,$FF00,0,$FFFF
            ds.b    6
            dc.w    $FFFF,0,$FF00,0,$FFFF,$00FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF,$FF,$00,$00,$00,$FF,$FF,$FF
            ds.b    5
            dc.w    $FFFF,$FF00,$FF00,0,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$FFFF,$FF00,$00FF
            ds.b    7
            dc.b    $FF
            ds.b    4
            dc.w    $FF00,$00FF,0,$00FF,0,$00FF,0,$00FF
            dc.b    $FF,$00,$00,$FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF,$00,$FF,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$00,$00,$FF,$00,$FF
            ds.b    5
            dc.b    $FF,$00,$FF,$00,$00,$FF,$00,$00,$FF,$00,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$00,$FF,$FF,$00,$00,$FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF
            ds.b    6
            dc.b    $FF,$FF,$00,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$00,$00,$00
            dc.b    $FF,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$FF,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF,$00,$00,$FF,$00,$00,$FF,$FF,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$00,$FF
            ds.b    7
            dc.b    $FF
            ds.b    5
            dc.b    $FF,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF
            dc.b    $00,$FF,$00,$FF,$00,$00,$00,$FF,$FF,$00,$00,$FF,$00,$00,$00,$FF
            dc.b    $FF,$FF,$00,$FF,$00,$00,$FF
            ds.b    4
            dc.w    $FF00,$00FF,0,$FF00,$FF00,$00FF,$00FF,0
            dc.w    $FF00,$00FF,$00FF,$FF00,$FF00,$00FF,$FF00,0
            dc.w    $FF00,$00FF,$FF00,$FF00,$FF00,$00FF,$FFFF,0
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF
            ds.b    5
            dc.w    $FF00,$FF00,0,$FF00,$FF00,$FF00,$00FF,0
            dc.w    $FF00,$FF00,$00FF,$FF00,$FF00,$FF00,$FF00,0
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FFFF,0
            dc.w    $FF00,$FF00,$FFFF,$FF00,$FF00,$FFFF
            ds.b    4
            dc.w    $FF00,$FFFF,0,$FF00,$FF00,$FFFF,$00FF,0
            dc.w    $FF00,$FFFF,$00FF,$FF00,$FF00,$FFFF,$FF00,0
            dc.w    $FF00,$FFFF,$FF00,$FF00,$FF00,$FFFF,$FFFF,0
            dc.w    $FF00,$FFFF,$FFFF,$FF00,$FFFF
            ds.b    6
            dc.w    $FFFF
            ds.b    4
            dc.w    $FF00,$FFFF,0,$00FF,0,$FFFF,0,$00FF
            dc.w    $FF00,$FFFF,0,$FF00,0,$FFFF,0,$FF00
            dc.w    $FF00,$FFFF,0,$FFFF,0,$FFFF,0,$FFFF
            dc.w    $FF00,$FFFF,$00FF
            ds.b    4
            dc.w    $FFFF,$00FF,0,$FF00,$FFFF,$00FF,$00FF,0
            dc.w    $FFFF,$00FF,$00FF,$FF00,$FFFF,$00FF,$FF00,0
            dc.w    $FFFF,$00FF,$FF00,$FF00,$FFFF,$00FF,$FFFF,0
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF
            ds.b    5
            dc.w    $FFFF,$FF00,0,$FF00,$FFFF,$FF00,$00FF,0
            dc.w    $FFFF,$FF00,$00FF,$FF00,$FFFF,$FF00,$FF00,0
            dc.w    $FFFF,$FF00,$FF00,$FF00,$FFFF,$FF00,$FFFF,0
            dc.w    $FFFF,$FF00,$FFFF,$FF00,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$FFFF,0,$FF00,$FFFF,$FFFF,$00FF,0
            dc.w    $FFFF,$FFFF,$00FF,$FF00,$FFFF,$FFFF,$FF00,0
            dc.w    $FFFF,$FFFF,$FF00,$FF00,$FFFF,$FFFF,$FFFF,0
            dc.w    $FFFF,$FFFF,$FFFF,$FF00,$FFFF,$FFFF,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF,$FFFF,$00FF,$FFFF,$FFFF,$FF00,$FFFF
            dc.w    $FFFF,$FFFF,$FF00,$00FF,$FFFF,$FFFF,$00FF,$FFFF
            dc.w    $FFFF,$FFFF,$00FF,$00FF,$FFFF,$FFFF,0,$FFFF
            dc.w    $FFFF,$FFFF,0,$00FF,$FFFF,$FF00,$FFFF,$FFFF
            dc.w    $FFFF,$FF00,$FFFF,$00FF,$FFFF,$FF00,$FF00,$FFFF
            dc.w    $FFFF,$FF00,$FF00,$00FF,$FFFF,$FF00,$00FF,$FFFF
            dc.w    $FFFF,$FF00,$00FF,$00FF,$FFFF,$FF00,0,$FFFF
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$00,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.w    $FFFF,$FFFF
            ds.b    5
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$00,$FF,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$00,$FF,$00
            dc.b    $FF,$FF,$00,$FF,$00,$00,$00,$FF,$FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$00
            dc.b    $FF,$FF,$00,$00,$FF,$FF,$00,$FF,$FF,$FF,$00,$00,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$00,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$00,$FF,$00
            dc.b    $FF,$FF,$00,$00,$FF,$00,$00,$FF,$FF,$FF,$00,$00,$FF,$00,$00,$00
            dc.b    $FF,$FF,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$00,$00,$00,$FF,$00,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF
            ds.b    6
            dc.b    $FF,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$00,$00,$FF,$FF,$00,$FF,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$00,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$00,$FF,$FF,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$00,$FF,$FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$00
            dc.b    $FF,$00,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$00,$FF,$FF,$00,$00
            dc.b    $FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$00,$FF,$00,$FF,$00,$FF,$00
            dc.b    $FF,$00,$FF,$00,$FF,$00,$00,$FF,$FF,$00,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$00,$FF,$00,$00,$FF,$00,$FF,$FF,$00,$FF,$00,$00,$FF,$00,$00
            dc.b    $FF,$00,$FF,$00,$00,$00,$FF,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF
            ds.b    4
            dc.w    $FFFF,$00FF
            ds.b    5
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$00
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$00,$00,$FF,$FF,$00,$FF,$FF,$FF,$00,$00,$FF,$FF,$00,$FF,$00
            dc.b    $FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$00,$FF,$FF,$00
            dc.b    $FF,$00,$00,$FF,$00,$FF,$00,$FF,$FF,$00,$00,$FF,$00,$FF,$00,$00
            dc.b    $FF,$00,$00,$FF,$00,$00,$FF,$FF,$FF,$00,$00,$FF,$00,$00,$FF,$00
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF,$FF,$00
            dc.b    $FF,$00,$00,$00,$FF,$FF,$00,$FF,$FF,$00,$00,$00,$FF,$FF,$00,$00
            dc.b    $FF,$00,$00,$00,$FF,$00,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$FF,$00
            dc.b    $FF,$00,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$00,$FF,$00,$00,$00
            dc.b    $FF
            ds.b    4
            dc.w    $FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$00FF
            ds.b    4
            dc.w    $FF00,$FFFF
            ds.b    4
            dc.w    $FF00,$00FF
            ds.b    5
            dc.b    $FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$00,$FF
            ds.b    6
            dc.w    $FFFF
            ds.b    7
            dc.b    $FF
            ds.b    15
            dc.b    $FF
            ds.b    6
            dc.b    $FF
            ds.b    7
            dc.w    $FFFF
            ds.b    5
            dc.b    $FF
            ds.b    7
            dc.b    $FF,$00,$FF
            ds.b    5
            dc.b    $FF,$FF
            ds.b    6
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF
            ds.b    7
            dc.w    $FF00,$00FF
            ds.b    4
            dc.b    $FF,$00,$FF
            ds.b    5
            dc.w    $FF00,$FFFF
            ds.b    4
            dc.w    $FFFF
            ds.b    6
            dc.w    $FFFF,$00FF
            ds.b    4
            dc.b    $FF,$FF,$FF
            ds.b    5
            dc.w    $FFFF,$FFFF,0,$00FF
            ds.b    7
            dc.b    $FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF,$FF,$00,$00,$00,$FF,$00,$FF
            ds.b    5
            dc.b    $FF,$00,$FF,$00,$FF,$00,$00,$00,$FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF,$FF,$00,$00,$00,$FF,$FF
            ds.b    6
            dc.b    $FF,$FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF,$FF,$00,$00,$00,$FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF,$FF,$00,$00,$FF
            ds.b    7
            dc.b    $FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF
            dc.b    $FF,$00,$00,$FF,$00,$00,$FF
            ds.b    4
            dc.w    $FF00,$00FF,$00FF,0,$FF00,$00FF,$FF00,0
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$00,$00,$FF,$00,$FF
            ds.b    5
            dc.w    $FF00,$FF00,$00FF,0,$FF00,$FF00,$FF00,0
            dc.w    $FF00,$FF00,$FFFF,0,$FF00,$FFFF
            ds.b    4
            dc.w    $FF00,$FFFF,$00FF,0,$FF00,$FFFF,$FF00,0
            dc.w    $FF00,$FFFF,$FFFF,0,$FFFF
            ds.b    6
            dc.w    $FFFF,0,$00FF,0,$FFFF,0,$FF00,0
            dc.w    $FFFF,0,$FFFF,0,$FFFF,$00FF
            ds.b    4
            dc.w    $FFFF,$00FF,$00FF,0,$FFFF,$00FF,$FF00,0
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF
            ds.b    5
            dc.w    $FFFF,$FF00,$00FF,0,$FFFF,$FF00,$FF00,0
            dc.w    $FFFF,$FF00,$FFFF,0,$FFFF,$FFFF
            ds.b    4
            dc.w    $FFFF,$FFFF,$00FF,0,$FFFF,$FFFF,$FF00,0
            dc.w    $FFFF,$FFFF,$FFFF,$00FF
            ds.b    7
            dc.b    $FF
            ds.b    5
            dc.b    $FF,$00,$FF
            ds.b    4
            dc.w    $FF00,$00FF
            ds.b    4
            dc.w    $FFFF,$00FF,0,$00FF,0,$00FF,0,$00FF
            dc.w    $00FF,$00FF,0,$00FF,$FF00,$00FF,0,$00FF
            dc.b    $FF,$FF,$00,$FF,$00,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF,$00,$00,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$00,$00
            dc.b    $FF,$00,$00,$FF,$00,$FF,$FF,$00,$FF,$00,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$00,$FF,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF
            ds.b    5
            dc.b    $FF,$00,$FF,$00,$00,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$00
            dc.b    $FF,$00,$FF,$00,$00,$FF,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$00,$00
            dc.b    $FF,$00,$FF,$00,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$00,$FF,$00,$FF,$FF,$00,$FF,$00,$00
            dc.b    $FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$00,$00,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF
            ds.b    6
            dc.b    $FF,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF,$00,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$00,$FF
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF
            dc.b    $FF,$00,$FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$FF,$00,$FF,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$00,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$00,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF,$00,$00,$00,$FF,$00,$FF,$FF,$FF,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$00,$00,$FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$00,$00,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$00,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF,$00,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
            dc.b    $FF,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$FF
            dc.b    $FF,$FF,$FF,$00,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$00,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.w    $FFFF,$FF00,$FFFF,$FFFF,$FFFF,$FF00,$FFFF,$FF00
            dc.w    $FFFF,$FF00,$FFFF,$00FF,$FFFF,$FF00,$FFFF,0
            dc.w    $FFFF,$FF00,$FF00,$FFFF,$FFFF,$FF00,$FF00,$FF00
            dc.w    $FFFF,$FF00,$FF00,$00FF,$FFFF,$FF00,$FF00,0
            dc.w    $FFFF,$FF00,$00FF,$FFFF,$FFFF,$FF00,$00FF,$FF00
            dc.w    $FFFF,$FF00,$00FF,$00FF,$FFFF,$FF00,$00FF,0
            dc.w    $FFFF,$FF00,0,$FFFF,$FFFF,$FF00,0,$FF00
            dc.b    $FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF
            ds.b    5
            dc.w    $FFFF,$00FF,$FFFF,$FFFF,$FFFF,$00FF,$FFFF,$FF00
            dc.w    $FFFF,$00FF,$FFFF,$00FF,$FFFF,$00FF,$FFFF,0
            dc.w    $FFFF,$00FF,$FF00,$FFFF,$FFFF,$00FF,$FF00,$FF00
            dc.w    $FFFF,$00FF,$FF00,$00FF,$FFFF,$00FF,$FF00,0
            dc.w    $FFFF,$00FF,$00FF,$FFFF,$FFFF,$00FF,$00FF,$FF00
            dc.w    $FFFF,$00FF,$00FF,$00FF,$FFFF,$00FF,$00FF,0
            dc.w    $FFFF,$00FF,0,$FFFF,$FFFF,$00FF,0,$FF00
            dc.w    $FFFF,$00FF,0,$00FF,$FFFF,$00FF
            ds.b    4
            dc.w    $FFFF,0,$FFFF,$FFFF,$FFFF,0,$FFFF,$FF00
            dc.w    $FFFF,0,$FFFF,$00FF,$FFFF,0,$FFFF,0
            dc.w    $FFFF,0,$FF00,$FFFF,$FFFF,0,$FF00,$FF00
            dc.w    $FFFF,0,$FF00,$00FF,$FFFF,0,$FF00,0
            dc.w    $FFFF,0,$00FF,$FFFF,$FFFF,0,$00FF,$FF00
            dc.w    $FFFF,0,$00FF,$00FF,$FFFF,0,$00FF,0
            dc.w    $FFFF
            ds.b    4
            dc.w    $FFFF,$FFFF
            ds.b    4
            dc.w    $FF00,$FFFF
            ds.b    5
            dc.b    $FF,$FF,$FF
            ds.b    6
            dc.w    $FF00,$FFFF,$FFFF,$FFFF,$FF00,$FFFF,$FFFF,$FF00
            dc.w    $FF00,$FFFF,$FFFF,$00FF,$FF00,$FFFF,$FFFF,0
            dc.w    $FF00,$FFFF,$FF00,$FFFF,$FF00,$FFFF,$FF00,$FF00
            dc.w    $FF00,$FFFF,$FF00,$00FF,$FF00,$FFFF,$FF00,0
            dc.w    $FF00,$FFFF,$00FF,$FFFF,$FF00,$FFFF,$00FF,$FF00
            dc.w    $FF00,$FFFF,$00FF,$00FF,$FF00,$FFFF,$00FF,0
            dc.w    $FF00,$FFFF,0,$FFFF,$FF00,$FFFF,0,$FF00
            dc.w    $FF00,$FFFF,0,$00FF,$FF00,$FFFF
            ds.b    4
            dc.w    $FF00,$FF00,$FFFF,$FFFF,$FF00,$FF00,$FFFF,$FF00
            dc.w    $FF00,$FF00,$FFFF,$00FF,$FF00,$FF00,$FFFF,0
            dc.w    $FF00,$FF00,$FF00,$FFFF,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$00FF,$FF00,$FF00,$FF00,0
            dc.w    $FF00,$FF00,$00FF,$FFFF,$FF00,$FF00,$00FF,$FF00
            dc.w    $FF00,$FF00,$00FF,$00FF,$FF00,$FF00,$00FF,0
            dc.w    $FF00,$FF00,0,$FFFF,$FF00,$FF00,0,$FF00
            dc.b    $FF,$00,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF
            ds.b    5
            dc.w    $FF00,$00FF,$FFFF,$FFFF,$FF00,$00FF,$FFFF,$FF00
            dc.w    $FF00,$00FF,$FFFF,$00FF,$FF00,$00FF,$FFFF,0
            dc.w    $FF00,$00FF,$FF00,$FFFF,$FF00,$00FF,$FF00,$FF00
            dc.w    $FF00,$00FF,$FF00,$00FF,$FF00,$00FF,$FF00,0
            dc.w    $FF00,$00FF,$00FF,$FFFF,$FF00,$00FF,$00FF,$FF00
            dc.w    $FF00,$00FF,$00FF,$00FF,$FF00,$00FF,$00FF,0
            dc.w    $FF00,$00FF,0,$FFFF,$FF00,$00FF,0,$FF00
            dc.w    $FF00,$00FF,0,$00FF,$FF00,$00FF
            ds.b    4
            dc.w    $FF00,0,$FFFF,$FFFF,$FF00,0,$FFFF,$FF00
            dc.w    $FF00,0,$FFFF,$00FF,$FF00,0,$FFFF,0
            dc.w    $FF00,0,$FF00,$FFFF,$FF00,0,$FF00,$FF00
            dc.w    $FF00,0,$FF00,$00FF,$FF00,0,$FF00,0
            dc.b    $FF
            ds.b    4
            dc.b    $FF,$FF,$FF,$FF
            ds.b    4
            dc.b    $FF,$FF,$00,$FF
            ds.b    4
            dc.b    $FF,$00,$FF,$FF
            ds.b    4
            dc.b    $FF,$00,$00,$FF
            ds.b    5
            dc.b    $FF,$FF,$FF
            ds.b    5
            dc.b    $FF,$00,$FF
            ds.b    6
            dc.b    $FF,$FF
            ds.b    7
RsrcEntryRSRC_5:
            dc.b    $00,$20,$00,$00,$00,$00,$00,$00 ; Resource 'RSRC' 5 (4660 bytes) - Combo mask
            dc.l    RsrcEntryattx_1-BaseOfROM       ; Next entry
            dc.l    RsrcRSRC_5-BaseOfROM            ; Data
            dc.b    'RSRC'                          ; Type
            dc.w    5                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00001240,$000001AC   ; Block header
RsrcRSRC_5:
            ds.b    4656
RsrcEntryiopc_1:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'iopc' 1 (13316 bytes) - Combo mask
            dc.l    RsrcEntryRSRC_5-BaseOfROM       ; Next entry
            dc.l    Rsrciopc_1-BaseOfROM            ; Data
            dc.b    'iopc'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00003410,$000001A4   ; Block header
Rsrciopc_1:
            dc.w    $5800,$7C52,$1885,$87BD,$0078,$1900,$790D,$007A
            dc.w    $858C,$AD00,$778D,$40F0,$BD00,$778D,$40F0,$A587
            dc.w    $45CA,$699C,$C980,$2A85,$9CE6,$1852,$18AA,$459C
            dc.w    $69AA,$85AA,$EE18,$00D0,$02E6,$19B9,$0077,$8D40
            dc.w    $F0A4,$87B9,$0077,$8D40,$F0A5,$AA52,$18A8,$45AA
            dc.w    $69CA,$85CA,$E618,$D0AB,$4C34,$6F4A,$5000,$A2FF
            dc.w    $9A9C,$20F0,$9C28,$F09C,$32F0,$9C35,$F09C,$10F0
            dc.w    $9C11,$F08E,$33F0,$8E34,$F020,$BA50,$20D1,$5120
            dc.w    $D153,$A941,$A059,$58A2,$58C9,$41D0,$1BC0,$59D0
            dc.w    $17E0,$58D0,$13BA,$E0FF,$D010,$8E1F,$0320,$ED53
            dc.w    $AE1F,$02F0,$E24C,$EC7F,$FF50,$4E48,$DA5A,$2058
            dc.w    $507A,$FA68,$40AE,$34F0,$7C00,$7D00,$00BA,$BD06
            dc.w    $0189,$10D0,$0160,$BAE8,$F0FC,$BD00,$0180,$F8A9
            dc.w    $108D,$34F0,$1C33,$F058,$AC00,$03A9,$03D9,$0003
            dc.w    $D00C,$5ABE,$FC7D,$7820,$B450,$587A,$A903,$88D0
            dc.w    $ECAC,$0002,$A901,$D900,$02D0,$0C5A,$BEFC,$7D78
            dc.w    $20B7,$5058,$7AA9,$0188,$D0EC,$78A9,$100C,$33F0
            dc.w    $607C,$3E7D,$7C4C,$7DA9,$008D,$604E,$18AA,$6910
            dc.w    $9D00,$4EC9,$5090,$F6A9,$FF8D,$504E,$8D61,$4E8D
            dc.w    $624E,$8D63,$4E60,$AC60,$4E30,$10B9,$004E,$8D60
            dc.w    $4EA9,$0399,$014E,$A900,$990C,$4E60,$AD60,$4E99
            dc.w    $004E,$8C60,$4EB9,$014E,$C901,$F001,$6000,$0099
            dc.w    $0E4E,$B901,$4EC9,$03F0,$118A,$990F,$4EB9,$0C4E
            dc.w    $D00C,$6899,$0D4E,$6899,$0C4E,$B90E,$4E60,0
            dc.w    $B901,$4EC9,$0360,$A9FF,$9900,$4EA9,$0199,$014E
            dc.w    $AD61,$4E30,$0B98,$AC62,$4E99,$004E,$8D62,$4E60
            dc.w    $AD01,$03F0,$078C,$614E,$8C62,$FF51,$4D4E,$60B9
            dc.w    $024E,$8D20,$03B9,$034E,$8D22,$03B9,$044E,$8D23
            dc.w    $03B9,$054E,$8D24,$03B9,$064E,$8D25,$03B9,$074E
            dc.w    $8D26,$03B9,$084E,$8D27,$03B9,$094E,$8D28,$03B9
            dc.w    $0A4E,$8D29,$03A9,$018D,$0103,$8C63,$4EA9,$088D
            dc.w    $35F0,$609C,$0103,$AC63,$4EB9,$024E,$4AF0,$03AD
            dc.w    $2A03,$990B,$4EA9,$0399,$014E,$AD61,$4E30,$0C5A
            dc.b    $A8,$B9,$00,$4E,$8D
            dc.b    'aN OQz'
            dc.b    $B9,$0C,$4E,$F0,$10,$48,$B9,$0D,$4E,$48,$A9,$00,$99,$0C,$4E,$B9
            dc.b    $0E,$4E,$BE,$0F,$4E,$60,$A9,$00,$8D,$84,$4E,$18,$AA,$69,$08,$9D
            dc.b    $64,$4E,$C9,$18,$90,$F6,$A9,$FF,$8D,$7C,$4E,$8D,$85,$4E,$A9,$20
            dc.b    $1C,$33,$F0,$A9,$01,$1C,$32,$F0,$A9,$80,$8D,$12,$F0,$60,$AC,$84
            dc.b    $4E,$30,$10,$B9,$64,$4E,$8D,$84,$4E,$A9,$03,$99,$65,$4E,$A9,$00
            dc.b    $99,$68,$4E,$60,$AD,$84,$4E,$99,$64,$4E,$8C,$84,$4E,$B9,$65,$4E
            dc.b    $C9,$01,$F0,$01,$60,$00,$00,$99,$6A,$4E,$B9,$65,$4E,$C9,$03,$F0
            dc.b    $11,$8A,$99,$6B,$4E,$B9,$68,$4E,$D0,$0C,$68,$99,$69,$4E,$68,$99
            dc.b    $68,$4E,$B9,$6A,$4E,$60,$00,$00,$B9,$65,$4E,$C9,$03,$60,$A9,$01
            dc.b    $99,$FF,$52,$4C,$65,$4E,$AE,$85,$4E,$10,$11,$8C,$85,$4E,$A9,$FF
            dc.b    $99,$64,$4E,$A9,$20,$0C,$33,$F0,$98,$AA,$80,$59,$20,$08,$53,$30
            dc.b    $02,$A2,$21,$8E,$86,$4E,$BD,$64,$4E,$AA,$30,$3B,$38,$B9,$67,$4E
            dc.b    $FD,$67,$4E,$99,$67,$4E,$B9,$66,$4E,$FD,$66,$4E,$99,$66,$4E,$10
            dc.b    $E2,$18,$B9,$67,$4E,$7D,$67,$4E,$99,$67,$4E,$B9,$66,$4E,$7D,$66
            dc.b    $4E,$99,$66,$4E,$38,$BD,$67,$4E,$F9,$67,$4E,$9D,$67,$4E,$BD,$66
            dc.b    $4E,$F9,$66,$4E,$9D,$66,$4E,$8A,$99,$64,$4E,$AE,$86,$4E,$98,$9D
            dc.b    $64,$4E,$AE,$85,$4E,$BD,$66,$4E,$D0,$11,$BD,$67,$4E,$30,$30,$9E
            dc.b    $67,$4E,$8D,$11,$F0,$A9,$FF,$8D,$13,$F0,$60,$30,$19,$A9,$7F,$8D
            dc.b    $11,$F0,$A9,$FF,$8D,$13,$F0,$38,$BD,$67,$4E,$E9,$7F,$9D,$67,$4E
            dc.b    $B0,$03,$DE,$66,$4E,$60,$9C,$11,$F0,$A9,$FF,$8D,$13,$F0,$60,$38
            dc.b    $E9,$7F,$9D,$67,$4E,$A9,$7F,$8D,$11,$F0,$A9,$FF,$8D,$13,$F0,$60
            dc.b    $AD,$10,$F0,$C9,$10,$90,$F9,$AD,$11,$F0,$18,$10,$10,$7D,$67,$4E
            dc.b    $9D,$67,$4E,$B0,$04,$DE,$66,$4E,$60,$BD,$66,$4E,$60,$7D,$67,$4E
            dc.b    $9D,$67,$4E,$90,$F4,$FE,$66,$4E,$60,$AE,$85,$4E,$30,$35,$20,$08
            dc.b    $53,$10,$82,$DA,$BD,$64,$4E,$8D,$85,$4E,$30,$06,$AA,$20,$BD,$52
            dc.b    $80,$05,$A9,$FF,$53,$4B,$20,$1C,$33,$F0,$7A,$A9,$03,$99,$65,$4E
            dc.b    $B9,$68,$4E,$F0,$10,$48,$B9,$69,$4E,$48,$A9,$00,$99,$68,$4E,$B9
            dc.b    $6A,$4E,$BE,$6B,$4E,$60,$00,$00,$A9,$03,$D9,$65,$4E,$F0,$5C,$99
            dc.b    $65,$4E,$A9,$00,$99,$68,$4E,$CC,$85,$4E,$D0,$23,$B9,$64,$4E,$10
            dc.b    $09,$8D,$85,$4E,$A9,$20,$1C,$33,$F0,$60,$AE,$85,$4E,$20,$08,$53
            dc.b    $AC,$85,$4E,$BE,$64,$4E,$8E,$85,$4E,$20,$BD,$53,$4C,$BD,$52,$A9
            dc.b    $21,$8C,$86,$4E,$AA,$30,$24,$BD,$64,$4E,$CD,$86,$4E,$D0,$F5,$B9
            dc.b    $64,$4E,$9D,$64,$4E,$30,$14,$AA,$18,$BD,$67,$4E,$79,$67,$4E,$9D
            dc.b    $67,$4E,$BD,$66,$4E,$79,$66,$4E,$9D,$66,$4E,$60,$A9,$03,$8D,$30
            dc.b    $F0,$A9,$32,$8D,$31,$F0,$A9,$03,$8D,$00,$02,$8D,$00,$03,$20,$F5
            dc.b    $54,$4C,$9E,$58,$00,$00,$80,$FC,$48,$DA,$5A,$20,$00,$54,$20,$FF
            dc.b    $53,$20,$FF,$53,$20,$FF,$53,$7A,$FA,$68,$60,$AD,$91,$4E,$4A,$B0
            dc.b    $33,$D0,$30,$A9,$03,$8D,$9B,$4E,$8D,$95,$4E,$A9,$09,$8D,$9F,$4E
            dc.b    $EE,$8B,$4E,$A2,$15,$A0,$09,$20,$B0,$54,$A0,$05,$A9,$01,$20,$BF
            dc.b    $54,$80,$44,$A0,$0B,$A9,$02,$20,$C2,$54,$A2,$0B,$A0,$0F,$20,$E7
            dc.b    $54,$F0,$E0,$60,$A2,$05,$BD,$96,$4E,$95,$00,$CA,$D0,$F8,$A0,$21
            dc.b    $8A,$88,$F0,$1F,$26,$FF,$54,$4A,$05,$26,$04,$26,$03,$26,$02,$2A
            dc.b    $AA,$26,$01,$EC,$91,$4E,$A5,$01,$ED,$90,$4E,$90,$E6,$85,$01,$8A
            dc.b    $ED,$91,$4E,$88,$D0,$E1,$05,$01,$D0,$BC,$A9,$03,$8D,$91,$4E,$9C
            dc.b    $90,$4E,$A0,$15,$A9,$02,$20,$BF,$54,$A2,$15,$A0,$19,$20,$E2,$54
            dc.b    $D0,$AB,$A0,$0F,$A9,$02,$20,$C2,$54,$AD,$94,$4E,$30,$1C,$A2,$11
            dc.b    $A0,$19,$20,$B0,$54,$A9,$10,$48,$A2,$19,$20,$D1,$54,$90,$05,$A2
            dc.b    $0F,$20,$D1,$54,$68,$3A,$D0,$EF,$80,$C0,$0E,$91,$4E,$60,$20,$B3
            dc.b    $54,$20,$B6,$54,$CA,$BD,$87,$4E,$88,$99,$87,$4E,$60,$20,$C2,$54
            dc.b    $20,$C5,$54,$18,$88,$79,$87,$4E,$99,$87,$4E,$A9,$00,$2A,$60,$A0
            dc.b    $03,$18,$CA,$BD,$87,$4E,$79,$9C,$4E,$99,$9C,$4E,$88,$10,$F3,$60
            dc.b    $20,$E7,$54,$D0,$0D,$20,$EC,$54,$D0,$08,$CA,$BD,$87,$4E,$88,$D9
            dc.b    $87,$4E,$60,$20,$38,$57,$20,$F9,$51,$84,$09,$A9,$62,$85,$0D,$A2
            dc.b    $0F,$86,$0B,$8A,$9D,$A8,$4E,$CA,$D0,$F9,$60,$A2,$02,$AC,$61,$02
            dc.b    $AD,$60,$02,$20,$B4,$55,$A9,$03,$8D,$03,$02,$A9,$04,$8D,$35,$F0
            dc.b    $80,$3C,$A2,$03,$AC,$61,$03,$AD,$60,$03,$20,$B4,$55,$9C,$03,$03
            dc.b    $80,$2C,$A6,$0C,$BD,$A9,$4E,$AA,$E6,$10,$A5,$10,$C9,$10,$B0,$05
            dc.b    $3C,$B9,$4E,$30,$EF,$86,$0C,$FF,$55,$49,$20,$F0,$55,$A9,$03,$A4
            dc.b    $09,$99,$67,$4E,$A9,$00,$99,$66,$4E,$20,$49,$52,$A4,$09,$20,$22
            dc.b    $52,$AD,$03,$03,$D0,$4E,$A4,$09,$20,$43,$52,$D0,$47,$A9,$54,$20
            dc.b    $4E,$55,$24,$07,$30,$0F,$50,$3C,$A5,$0C,$0A,$0A,$0A,$0A,$09,$0C
            dc.b    $8D,$A0,$4E,$64,$08,$20,$10,$56,$46,$06,$A5,$07,$8D,$60,$03,$29
            dc.b    $C2,$C9,$42,$F0,$19,$A9,$80,$04,$06,$A5,$08,$8D,$61,$03,$EE,$03
            dc.b    $03,$A9,$08,$8D,$35,$F0,$A9,$80,$14,$07,$D0,$08,$64,$10,$A9,$04
            dc.b    $24,$07,$D0,$81,$60,$24,$07,$30,$27,$86,$0E,$85,$07,$64,$08,$29
            dc.b    $A0,$30,$1E,$F0,$1B,$14,$07,$A0,$02,$B1,$0D,$85,$0F,$88,$B1,$0D
            dc.b    $A2,$0F,$26,$0F,$2A,$9E,$B9,$4E,$B0,$03,$DE,$B9,$4E,$CA,$10,$F2
            dc.b    $60,$C0,$09,$90,$02,$A0,$08,$84,$08,$B1,$0D,$99,$A0,$4E,$88,$10
            dc.b    $F8,$A4,$09,$4C,$6D,$53,$EA,$EA,$EA,$3A,$D0,$FD,$AD,$32,$F0,$B0
            dc.b    $04,$09,$02,$80,$03,$29,$FD,$EA,$8D,$32,$F0,$A9,$04,$2C,$32,$F0
            dc.b    $60,$18,$20,$FB,$55,$A5,$07,$29,$FB,$09,$02,$85,$07,$A2,$08,$A9
            dc.b    $01,$9D,$63,$03,$CA,$D0,$FA,$9C,$63,$03,$AD,$A0,$4E,$8D,$62,$03
            dc.b    $29,$0F,$F0,$3D,$CA,$D0,$FD,$A0,$01,$A9,$0E,$20,$F6,$55,$20,$01
            dc.b    $57,$90,$2B,$D0,$1A,$A9,$04,$A2,$12,$FF,$56,$48,$2C,$32,$F0,$D0
            dc.b    $11,$CA,$D0,$F8,$A2,$27,$CA,$F0,$18,$2C,$32,$F0,$F0,$F8,$A9,$04
            dc.b    $04,$07,$A2,$01,$A4,$08,$F0,$17,$18,$A9,$43,$20,$F9,$55,$20,$01
            dc.b    $57,$64,$08,$60,$E8,$E0,$06,$A9,$F9,$20,$F8,$55,$90,$F6,$60,$A9
            dc.b    $04,$A2,$EF,$A0,$2C,$2C,$32,$F0,$F0,$08,$88,$D0,$F8,$60,$F0,$E1
            dc.b    $A2,$F1,$E8,$F0,$DC,$2C,$32,$F0,$F0,$F8,$A0,$EF,$C8,$F0,$1A,$2C
            dc.b    $32,$F0,$D0,$F8,$86,$0F,$C4,$0F,$A6,$08,$3E,$63,$03,$90,$DF,$E0
            dc.b    $08,$B0,$BE,$E6,$08,$A2,$F2,$80,$D9,$A6,$08,$DE,$63,$03,$D0,$B1
            dc.b    $E0,$02,$90,$AD,$A9,$02,$14,$07,$A9,$04,$24,$07,$D0,$36,$AD,$A0
            dc.b    $4E,$4A,$4A,$4A,$4A,$C5,$0A,$F0,$2B,$AA,$3C,$B9,$4E,$30,$25,$A0
            dc.b    $FF,$C8,$D9,$A9,$4E,$D0,$FA,$C5,$0B,$D0,$04,$84,$0B,$80,$11,$BD
            dc.b    $A9,$4E,$99,$A9,$4E,$A4,$0B,$8A,$99,$A9,$4E,$A5,$0A,$9D,$A9,$4E
            dc.b    $86,$0A,$86,$0C,$60,$64,$0F,$38,$A9,$04,$20,$F6,$55,$80,$00,$38
            dc.b    $A9,$03,$20,$F6,$55,$18,$F0,$23,$A9,$05,$20,$F5,$55,$24,$0F,$06
            dc.b    $0F,$D0,$E5,$BD,$A0,$4E,$38,$2A,$85,$0F,$E8,$88,$30,$07,$A9,$01
            dc.b    $20,$F7,$55,$80,$DA,$38,$A9,$0E,$20,$F7,$55,$60,$A2,$FF,$A9,$02
            dc.b    $0C,$32,$F0,$2C,$32,$F0,$F0,$0A,$60,$99,$F5,$FF,$57,$47,$55,$E8
            dc.b    $BC,$55,$57,$D0,$F7,$E8,$BD,$55,$57,$D0,$F4,$60,$4D,$07,$00,$45
            dc.b    $13,$00,$29,$0B,$00,$FD,$0C,$00,$09,$0F,$00,$02,$10,$00,$08,$16
            dc.b    $50,$87,$00,$4F,$18,$54,$61,$8D,$9D,$A7,$00,$00,$A9,$02,$8D,$02
            dc.b    $02,$A9,$FF,$04,$11,$D0,$1B,$1C,$E6,$4E,$F0,$05,$A4
            dc.b    'V mSdv'
            dc.w    $AD40,$02C9,$19B0,$0C0A,$AAAD,$C94E,$7C5C,$7D8D
            dc.w    $E74E,$60A9,$CE8D,$4302,$F00A,$6413,$3004,$A9FE
            dc.w    $8002,$A9FF,$8D42,$02A9,$038D,$0202,$6411,$A904
            dc.w    $8D35,$F060,0,$80FC,$80D9,$49E9,$D037,$A901
            dc.w    $1C30,$F0A2,$6BCA,$7411,$D0FB,$A287,$CA9E,$C94E
            dc.w    $D0FA,$A9DA,$A223,$38E9,$069D,$DC05,$CA10,$F7A2
            dc.w    $4086,$14A2,$4086,$50A2,$F086,$5120,$3373,$F008
            dc.w    $A2E9,$8EC9,$4E4C,$A157,$20F9,$5184,$5620,$F951
            dc.w    $8CDB,$4E20,$F951,$8CD8,$4E20,$D950,$8458,$20D9
            dc.w    $5084,$5920,$D950,$845C,$20D9,$5084,$5DA2,$0D20
            dc.w    $6E74,$20DF,$74C9,$07D0,$03CE,$CA4E,$A612,$206E
            dc.w    $74F0,$1920,$DF74,$C903,$9012,$FF58,$46C9,$07F0
            dc.w    $0EEE,$CB4E,$AECB,$4E9D,$F44E,$A512,$9DEB,$4EE6
            dc.w    $12A5,$12C9,$0590,$D8A6,$1220,$6E74,$F013,$20DF
            dc.w    $74C9,$07D0,$0CEE,$CB4E,$A612,$9DF4,$4E8A,$9DEB
            dc.w    $4EE6,$12A5,$12C9,$0990,$DE20,$0766,$A21B,$A900
            dc.w    $E009,$B003,$BDF4,$4E9D,$4402,$CA10,$F1A9,$0020
            dc.w    $A157,$4C2A,$59A9,$E98D,$C94E,$60D0,$10A9,$C8AE
            dc.w    $4102,$E009,$B007,$A902,$2054,$64A9,$004C,$A157
            dc.w    $D011,$A904,$8D44,$02A9,$108D,$4502,$A52F,$8D46
            dc.w    $02A9,$004C,$A157,$D013,$202D,$639C,$CC4E,$AE45
            dc.w    $0230,$06AE,$4402,$8ECC,$4EA9,$004C,$A157,$D013
            dc.w    $9CD6,$4EA2,$03BD,$4402,$9DD2,$4E0C,$D64E,$CA10
            dc.w    $F4A9,$004C,$A157,$D013,$9CD1,$4EA2,$03BD,$4402
            dc.w    $9DCD,$4E0C,$D14E,$CA10,$F4A9,$004C,$A157,$D006
            dc.w    $3A8D,$D74E,$A900,$4CA1,$57D0,$039C,$D74E,$4CA1
            dc.w    $57AC,$D84E,$A90E,$9966,$4EA9,$F199,$674E,$2049
            dc.w    $52AC,$D84E,$2022,$52A5,$11D0,$E6A5,$FF59,$4575
            dc.w    $F00E,$C904,$D003,$2092,$63C6,$75D0,$D720,$0766
            dc.w    $A200,$BCF4,$4EF0,$3886,$74BD,$FD4E,$F003,$4CC0
            dc.w    $59BD,$EB4E,$AAC0,$07F0,$3120,$6E74,$A674,$A920
            dc.w    $2028,$74D0,$18A9,$2420,$4674,$20C4,$64A9,$0120
            dc.w    $E559,$F005,$A674,$9EFD,$4EA5,$11D0,$07A6,$74E8
            dc.w    $E009,$90BE,$2007
            dc.b    'ZL*Y nt'
            dc.b    $A6,$74,$A9,$02,$20,$28,$74,$F0,$E7,$A9,$02,$9D,$FD,$4E,$A9,$02
            dc.b    $9D,$06,$4F,$BD,$33,$4F,$09,$80,$9D,$33,$4F,$80,$C3,$BD,$F4,$4E
            dc.b    $C9,$07,$F0,$CC,$C9,$02,$F0,$C8,$BD,$EB,$4E,$AA,$20,$6E,$74,$A9
            dc.b    3,' (t'
            dc.b    $F0,$BA,$A9,$24,$20,$46,$74,$A9,$02,$20,$E5,$59,$80,$AA,$AC,$D7
            dc.b    $4E,$F0,$1D,$7A,$8C,$DA,$4E,$7A,$8C,$D9,$4E,$8D,$40,$03,$8E,$41
            dc.b    $03,$A9,$03,$20,$54,$64,$A9,$01,$8D,$02,$03,$A9,$08,$8D,$35,$F0
            dc.b    $A9,$18,$8D,$46,$F0,$A9,$86,$8D,$46,$F0,$60,$A9,$00,$8D,$02,$03
            dc.b    $AD,$D9,$4E,$48,$AD,$DA,$4E,$48,$AD,$42,$03,$0D,$43,$03,$60,$D0
            dc.b    $11,$20,$F4,$64,$F0,$10,$C9,$BF,$F0,$52,$C9,$C8,$F0,$04,$C9,$C0
            dc.b    $D0,$15,$AA,$4C,$A1,$57,$A0,$4F,$20,$1A,$67,$F0,$0A,$FF,$5A,$44
            dc.b    $20,$A1,$66,$D0,$05,$A0,$4F,$20,$1A,$67,$20,$25,$66,$AC,$41,$02
            dc.b    $BE,$EB,$4E,$20,$6E,$74,$A9,$06,$20,$46,$74,$A9,$FA,$A2,$05,$20
            dc.b    $99,$66,$A9,$07,$20,$46,$74,$A9,$0F,$8D,$E2,$4E,$A9,$FD,$A2,$02
            dc.b    $20,$99,$66,$A9,$20,$20,$28,$74,$D0,$05,$CE,$E2,$4E,$D0,$ED,$A9
            dc.b    $01,$20,$97,$66,$A6,$12,$9E,$FD,$4E,$9E,$06,$4F,$9E,$33,$4F,$64
            dc.b    $13,$20,$07,$66,$A9,$00,$4C,$A4,$58,$20,$F4,$64,$D0,$30,$A6,$57
            dc.b    $BD,$3C,$4F,$0A,$20,$CC,$5C,$F0,$28,$A4,$5E,$30,$08,$20,$02,$51
            dc.b    $A4,$5F,$20,$02,$51,$A4,$5A,$20,$02,$51,$BE,$0B,$4E,$F0,$02,$A9
            dc.b    $BC,$A4,$5B,$20,$02,$51,$BE,$0B,$4E,$F0,$02,$A9,$BC,$AA,$4C,$A1
            dc.b    $57,$20,$87,$5E,$B0,$D3,$A4,$5E,$30,$06,$20,$02,$51,$20,$DA,$5E
            dc.b    $A4,$5A,$20,$02,$51,$BE,$0B,$4E,$D0,$BF,$20,$15,$5F,$20,$41,$5F
            dc.b    $A4,$44,$A6,$46,$BD,$B8,$05,$30,$07,$09,$40,$9D,$B8,$05,$80,$04
            dc.b    $C6,$44,$F0,$3D,$E8,$88,$D0,$EC,$A9,$01,$85,$4B,$20,$25,$66,$D0
            dc.b    $6E,$A5,$3C,$85,$36,$A4,$3B,$20,$1A,$67,$A9,$09,$85,$4C,$20,$25
            dc.b    $66,$D0,$5C,$A9,$40,$85,$4D,$20,$F1,$67,$B0,$5F,$50,$38,$20,$B8
            dc.b    $6A,$D0,$6E,$A6,$57,$DE,$4C,$4F,$A6,$46,$1E,$B8,$05,$C6,$44,$FF
            dc.b    $5B,$43,$D0,$E2,$BD,$DC,$05,$0A,$85,$16,$A9,$00,$69,$04,$85,$17
            dc.b    $A0,$0B,$B1,$16,$99,$50,$02,$88,$10,$F8,$A4,$5B,$20,$29,$51,$A4
            dc.b    $5F,$30,$03,$20,$29,$51,$4C,$D5,$5A,$30,$43,$20,$B8,$6A,$D0,$0C
            dc.b    $A6,$57,$DE,$4C,$4F,$A6,$46,$A9,$80,$9D,$B8,$05,$C6,$4D,$10,$AA
            dc.b    $A9,$AF,$C6,$4B,$30,$05,$20,$A1,$66,$F0,$84,$4C,$AD,$5A,$F0,$1E
            dc.b    $C9,$B0,$F0,$EE,$A6,$12,$FE,$2A,$4F,$D0,$03,$FE,$21,$4F,$C6,$4C
            dc.b    $30,$E0,$80,$82,$C5,$4E,$F0,$D4,$C9,$70,$D0,$E8,$80,$DD,$20,$F7
            dc.b    $6F,$80,$C9,$64,$43,$20,$F4,$64,$D0,$10,$A6,$12,$A9,$80,$3C,$33
            dc.b    $4F,$F0,$0A,$38,$20,$CC,$5C,$F0,$08,$AA,$4C,$A1,$57,$A9,$D4,$80
            dc.b    $F9,$20,$87,$5E,$B0,$F3,$A4,$5A,$20,$15
            dc.b    '_ )Q A_'
            dc.w    $A544,$8552,$A646,$8008,$EE57,$02D0,$03EE,$5602
            dc.w    $BDB8,$0510,$078A,$A657,$FE4C,$4FAA,$BDDC,$050A
            dc.w    $8516,$A900,$6904,$8517,$A00B,$B950,$0291,$1688
            dc.w    $10F8,$A940,$9DB8,$05E8,$C652,$D0CC,$A45E,$3006
            dc.w    $20DA,$5E20,$2951,$A901,$854B,$2025,$66D0,$7020
            dc.w    $8366,$A53C,$8536,$A43B,$201A,$67A4,$5B20,$0251
            dc.w    $FF5C,$42A4,$5F30,$0320,$0251,$A909,$854C,$2025
            dc.w    $66D0,$4FA9,$4085,$4D20,$F167,$B052,$5025,$2007
            dc.w    $6EF0,$06C5,$4EF0,$3580,$4BA6,$469E,$B805,$C644
            dc.w    $D0E1,$A657,$BD4C,$4FC5,$4090,$05A9,$FF9D,$4C4F
            dc.w    $4CD2,$5B30,$43A0,$FF25,$06D0,$3D20,$B86A,$D00C
            dc.w    $A657,$DE4C,$4FA6,$46A9,$809D,$B805,$C64D,$10B7
            dc.w    $A9AF,$C64B,$3005,$20A1,$66F0,$824C,$CA5B,$F018
            dc.w    $C9B0,$F0EE,$A612,$FE2A,$4FD0,$03FE,$214F,$A64B
            dc.w    $D0E0,$C64C,$30DC,$808B,$20F7,$6F80,$CFA2,$FFA0
            dc.w    $FFAD,$D14E,$F031,$AE40,$02BD,$FA7D,$A45C,$9902
            dc.w    $4E98,$AAB0,$02A6,$5DAD,$CD4E,$9905,$4EAD,$CE4E
            dc.w    $9906,$4EAD,$CF4E,$9907,$4EAD,$D04E,$9908,$4EA9
            dc.w    $0099,$034E,$9904,$4E84,$5F86,$5EA4,$5884,$5B98
            dc.w    $B002,$A559,$855A,$AA9E,$0B4E,$AE40,$02BD,$FD7D
            dc.w    $A204,$2000,$5EAD,$4A02,$8539,$AD4B,$0285,$3AAD
            dc.w    $4E02,$8549,$AD4F,$0285,$4AAD,$5602,$8548,$AD57
            dc.w    $0285,$FF5D,$4147,$AD48,$020D,$4902,$0D4C,$020D
            dc.w    $4D02,$F003,$A9CE,$60A9,$0185,$3785,$3820,$8A67
            dc.w    $D0F4,$A53F,$38E5,$3EC5,$4AA9,$00E5,$49B0,$3EA6
            dc.w    $12A5,$3B38,$FD18,$4FB0,$34BC,$0F4F,$D02F,$0AE5
            dc.w    $3B85,$52A6,$49A5,$4AD0,$01CA,$3A18,$653A,$853A
            dc.w    $8A65,$3985,$3920,$8A67,$D0BC,$A552,$1865,$3B90
            dc.w    $0F64,$38AD,$4A02,$8539,$AD4B,$0285,$3AA9,$0060
            dc.w    $A9FF,$8537,$A65F,$3020,$A00C,$18BD,$084E,$654A
            dc.w    $9D08,$4EBD,$074E,$6549,$9D07,$4E90,$08FE,$064E
            dc.w    $D003,$FE05,$4E88,$D0E2,$A65B,$A002,$18BD,$074E
            dc.w    $654A,$9D07,$4EBD,$064E,$6549,$9D06,$4E90,$03FE
            dc.w    $054E,$88D0,$E718,$A54A,$6547,$8547,$A549,$6548
            dc.w    $8548,$80A9,$9902,$4EA9,$0099,$034E,$9904,$4E99
            dc.w    $0B4E,$BD40,$0299,$054E,$8552,$BD41,$0299,$064E
            dc.w    $0452,$BD42,$0299,$074E,$0452,$BD43,$0299,$084E
            dc.w    $0552,$D002,$A0FF,$6018,$BD08,$4E7D,$044E,$9908
            dc.w    $4EBD,$074E,$FF5E,$407D,$034E,$9907,$4EBD,$064E
            dc.w    $6900,$9906,$4EBD,$054E,$6900,$9905,$4EBD,$024E
            dc.w    $9902,$4E60,$38BD,$084E,$F904,$4E99,$084E,$BD07
            dc.w    $4EF9,$034E,$9907,$4EBD,$064E,$E900,$9906,$4EBD
            dc.w    $054E,$E900,$9905,$4EBD,$024E,$9902,$4E60,$A549
            dc.w    $054A,$F031,$A538,$6438,$D005,$208A,$67D0,$2620
            dc.w    $3363,$BD48,$4F85,$4524,$3730,$1C18,$653D,$8546
            dc.w    $38A5,$40E5,$3D85,$44A5,$49D0,$08A5,$4AC5,$44B0
            dc.w    $0285,$4418,$6038,$6085,$46A5,$3D1A,$8544,$A649
            dc.w    $D0F1,$38E5,$4A90,$EC18,$6545,$8546,$A54A,$8544
            dc.w    $60A6
            dc.b    '_$70- 3^'
            dc.w    $865E,$845F,$A646,$BDDC,$050A,$990A,$4EA9,$0099
            dc.w    $034E,$6904,$9909,$4EA5,$440A,$6544,$A65F,$0A3E
            dc.w    $034E,$0A3E,$034E,$9904,$4E60,$20E3,$5EA6,$5E4C
            dc.w    $5D5E,$A65B,$2437,$301E,$2033,$5E86,$5A84,$5BA5
            dc.w    $460A,$6906,$9909,$4EA5,$440A,$9903,$4EA9,$0099
            dc.w    $0A4E,$9904,$4E60,$201E,$5FA6,$5A4C,$FF5F,$3F5D
            dc.w    $5EA5,$4A38,$E544,$854A,$B002,$C649,$2437,$301F
            dc.w    $A53A,$1865,$4485,$3A90,$02E6,$39A5,$478D,$5702
            dc.w    $1865,$4485,$47A5,$488D,$5602,$6900,$8548,$60A5
            dc.w    $3A38,$E544,$853A,$B002,$C639,$A547,$38E5,$448D
            dc.w    $5702,$8547,$A548,$E900,$8D56,$0285,$4860,$20F4
            dc.w    $64D0,$62A4,$58A9,$01A2,$0820,$005E,$845B,$A45C
            dc.w    $A901,$A20C,$2000,$5E84,$5FAD,$4602,$8561,$AD47
            dc.w    $0285,$42AD,$4402,$D03B,$AD45,$0248,$A902,$A612
            dc.w    $2054,$64A9,$01FA,$F003,$8AA2,$02BC,$5602,$8453
            dc.w    $BC57,$0284,$52A2,$00BC,$F47E,$3017,$E866,$5366
            dc.w    $5290,$F43A,$D0F1,$A612,$A980,$3C33,$4FD0,$0BA9
            dc.w    $D480,$02A9,$CE64,$434C,$A157,$989D,$064F,$B915
            dc.w    $7E85,$60A5,$61D0,$03B9,$207E,$8561,$A642,$D00B
            dc.w    $BE0A,$7E10,$0629,$1FAA,$D001,$E886,$4220,$FC62
            dc.w    $20A1,$66D0,$D0A9,$0185
            dc.b    '7d:d9 '
            dc.w    $8366,$C643,$806E,$A43B,$201A,$67D0,$BAA5,$3A18
            dc.w    $FF60,$3E65,$3F85,$3A90,$02E6,$39A4,$40A9,$FF88
            dc.w    $9962,$00D0,$FA1A,$C540,$9003,$E540,$18AA,$3462
            dc.w    $10F3,$9462,$6542,$C8C4,$4090,$EB64,$46A5,$3F85
            dc.w    $44A4,$5F30,$0B20,$DA5E,$2029,$51A4,$5F20,$0251
            dc.w    $A45B,$300B,$2015,$5F20,$2951,$A45B,$2002,$5120
            dc.w    $2566,$F003,$4CF5,$5F20,$0D70,$D0F8,$E63C,$A53F
            dc.w    $38E5,$4085,$3FD0,$F020,$8A67,$F08D,$20FC,$6264
            dc.b    $43,$A9,$00,$4C,$A4,$58,$20,$F4,$64,$D0,$21,$A9,$02,$A6,$12
            dc.b    ' Td %f'
            dc.b    $D0,$15,$20,$22,$63,$A9,$01,$85,$3F,$AD,$5C,$02,$85,$39,$AD,$5D
            dc.b    $02,$80,$5D,$D0,$02,$A9,$AC,$4C,$A1,$57,$20,$8A,$67,$D0,$F8,$A4
            dc.b    $3B,$20,$1A,$67,$D0,$F1,$20,$25,$66,$D0,$EC,$A5,$3C,$85,$36,$20
            dc.b    $33,$63,$BD,$48,$4F,$85,$45,$A5,$40,$85,$44,$A9,$40,$85,$4D,$80
            dc.b    $03,$20,$F7,$6F,$C6,$4D,$F0,$CD,$20,$F1,$67,$B0,$C6,$30,$F2,$20
            dc.b    $B8,$6A,$F0,$06,$C5,$4E,$F0,$EC,$80,$BD,$A6,$57,$DE,$4C,$4F,$A6
            dc.b    $46,$A9,$80,$9D,$B8,$05,$C6,$44,$D0,$DA,$C6,$3C,$10,$BD,$A5,$3A
            dc.b    $38,$E5,$3F,$85,$3A,$A5,$39,$E9,$00,$85,$39,$B0,$9D,$FF,$61,$3D
            dc.b    $A9,$00,$80,$96,$20,$F4,$64,$D0,$59,$20,$8F,$62,$18,$A4,$58,$A2
            dc.b    $08,$A9,$46,$20,$C2,$62,$84,$5B,$38,$A4,$5C,$A2,$04,$A9,$4E,$20
            dc.b    $C2,$62,$84,$5F,$A9,$CE,$AE,$50,$02,$D0,$37,$AE,$51,$02,$E0,$04
            dc.b    $B0,$30,$AE,$54,$02,$86,$36,$EC,$E8,$4E,$B0,$26,$A4,$12,$BE,$06
            dc.b    $4F,$64,$4F,$E0,$06,$F0,$04,$E0,$05,$D0,$05,$CE,$55,$02,$C6,$4F
            dc.b    $AE,$52,$02,$D0,$0D,$AC,$53,$02,$20,$1A,$67,$D0,$05,$20,$25,$66
            dc.b    $F0,$18,$A2,$03,$9E,$4C,$02,$CA,$10,$FA,$A2,$18,$8E,$46,$F0,$9C
            dc.b    $E9,$4E,$48,$20,$FC,$62,$68,$4C,$A1,$57,$AE,$51,$02,$F0,$3E,$CA
            dc.b    $F0,$22,$CA,$F0,$2A,$A5,$4F,$F0,$34,$64,$53,$A9,$23,$20,$28,$74
            dc.b    $AA,$20,$40,$74,$F0,$03,$8A,$F0,$24,$C8,$D0,$F4,$E6,$53,$D0,$F0
            dc.b    $A9,$AD,$80,$BE,$20,$71,$62,$B0,$B9,$A5,$4F,$F0,$13,$80,$0E,$20
            dc.b    $71,$62,$B0,$AE,$A9,$06,$85,$19,$85,$17,$20,$B8,$6A,$20,$2E,$68
            dc.b    $A6,$5C,$BD,$09,$4E,$85,$17,$BD,$0A,$4E,$85,$16,$A6,$58,$BD,$09
            dc.b    $4E,$BC,$0A,$4E,$8D,$3A,$62,$A2,$01,$86,$53,$8A,$2C,$48,$F0,$2C
            dc.b    $4A,$F0,$2C,$4F,$F0,$30,$2D,$E6,$52,$D0,$F7,$1A,$D0,$F4,$A9,$BE
            dc.b    $80,$B0,$AD,$4F,$F0,$10,$FB,$4A,$AD,$49,$F0,$99,$00,$FF,$26,$FF
            dc.b    $62,$3C,$53,$C8,$90,$EF,$D0,$03,$EE,$3A,$62,$A5,$53,$86,$53,$92
            dc.b    $16,$E6,$16,$D0,$E0,$E6,$17,$A5,$17,$C9,$4E,$D0,$D8,$A4,$5B,$20
            dc.b    $66,$62,$A4,$5F,$20,$66,$62,$A9,$00,$4C,$A7,$61,$30,$08
            dc.b    'Z )QzL'
            dc.b    $02,$51,$60,$E6,$4E,$A9,$41,$85,$4D,$A9,$FF,$85,$40,$A9,$AF,$38
            dc.b    $C6,$4D,$30,$0C,$20,$F1,$67,$B0,$F4,$A5,$2E,$4D,$55,$02,$D0,$ED
            dc.b    $60,$AD,$4C,$02,$0D,$4D,$02,$D0,$0D,$AC,$4F,$02,$C0,$00,$AE,$4E
            dc.b    $02,$8A,$E9,$3E,$90,$0A,$9C,$4C,$02,$9C,$4D,$02,$A2,$3E,$A0,$00
            dc.b    $8E,$4E,$02,$8C,$4F,$02,$98,$18,$69,$07,$29,$F8,$90,$01,$E8,$86
            dc.b    $49,$85,$4A,$60,$08,$48,$A9,$00,$38,$E5,$4A,$99,$0A,$4E,$68,$E5
            dc.b    $49,$99,$09,$4E,$A9,$00,$20,$00,$5E,$A6,$49,$A5
            dc.b    'JFIfJFIfJFIfJ(Zz0'
            dc.w    $0FB0,$06AE,$4E02,$AD4F,$0299,$044E,$8A99,$034E
            dc.w    $60A4,$12BE,$064F,$BCFA,$7EB9,$057F,$8DE8,$4EA2
            dc.w    $FFA9,$2438,$800A,$488A,$E89D,$3C4F,$689D,$484F
            dc.w    $F906,$7FB0,$F186,$57A2,$03A9,$FF9D,$4C4F,$CA10
            dc.w    $FA60,$ADCC,$4EF0,$F060,$A0FF,$A557,$8006,$A8BD
            dc.w    $FF63,$3B3C,$4F30,$16AA,$3C4C,$4F30,$F4BD,$404F
            dc.w    $C53B,$D0EE,$BD44,$4FC5,$3CD0,$E780,$2298,$3001
            dc.w    $AAA5,$3B9D,$404F,$A53C,$9D44,$4FA5,$409D,$4C4F
            dc.w    $A818,$7D48,$4FDA,$AACA,$9EB8,$0588,$D0F9,$FAE4
            dc.w    $57F0,$168A,$A0FF,$C8D9,$3C4F,$D0FA,$BD3C,$4F99
            dc.w    $3C4F,$A557,$9D3C,$4F86,$5760,$ADCC,$4EF0,$08A5
            dc.w    $12F0,$04C5,$13F0,$109C,$E64E,$6411,$A9FF,$1CE7
            dc.w    $4EF0,$034C,$7557,$60AD,$E94E,$F0EB,$8540,$A9FF
            dc.w    $1ACD,$E84E,$B0E1,$8536,$A0FF,$A557,$8006,$A8BD
            dc.w    $3C4F,$301B,$AA3C,$4C4F,$30F4,$A535,$DD40,$4FD0
            dc.w    $EEBD,$4C4F,$D02B,$BD44,$4FC5,$36F0,$D380,$E098
            dc.w    $30B5,$AAA5,$359D,$404F,$A536,$9D44,$4FA5,$409D
            dc.w    $4C4F,$A818,$7D48,$4FDA,$AACA,$9EB8,$0588,$D0F9
            dc.w    $FABD,$444F,$8536,$BD48,$4F85,$458E,$EA4E,$A9FF
            dc.w    $854D,$8DE6,$4E85,$1120,$2566,$D02D,$6411,$20F7
            dc.w    $6FA5,$12F0,$24C5,$13D0,$20A9,$FF85,$1120,$F167
            dc.w    $B014,$FF64,$3A30,$1220,$B86A,$D00D,$AEEA,$4EDE
            dc.w    $4C4F,$A646,$A980,$9DB8,$054C,$9263,$4C9F,$63A4
            dc.w    $155A,$8515,$BD06,$4F48,$BDFD,$4E48,$BDF4,$4E48
            dc.w    $BD0F,$4FA0,$0491,$14BD,$184F,$A005,$9114,$BD21
            dc.w    $4FA0,$0C91,$14BD,$2A4F,$A00D,$9114,$BCEB,$4EB9
            dc.w    $EB7E,$A010,$9114,$BD33,$4F29,$80F0,$02A9,$013A
            dc.w    $A006,$9114,$A200,$20BE,$647A,$BED5,$7E20,$BE64
            dc.w    $7ABE,$DE7E,$20BE,$647A,$BEE3,$7E20,$BE64,$7A84
            dc.w    $1560,$E8BD,$2B7E,$9114,$E8BC,$2B7E,$D0F4,$60A9
            dc.w    $039D,$FD4E,$BDF4,$4EC9,$04D0,$0CA9,$2720,$2874
            dc.w    $D005,$A904,$9DFD,$4EBD,$334F,$0980,$9D33,$4FA9
            dc.w    $2120,$2874,$D008,$BD33,$4F29,$7F9D,$334F,$60D0
            dc.w    $0DAC,$4102,$F00E,$C412,$D00A,$A005,$8475,$A820
            dc.w    $2D63,$9860,$A9C8,$C009,$B0F4,$A9C0,$BEF4,$4EF0
            dc.w    $ED20,$0766,$20B9,$65D0,$E58A,$4513,$F0E0,$8613
            dc.w    $BC06,$4FF0,$0520,$C273,$8054,$7A84,$557A,$8454
            dc.w    $20C4,$64A4,$FF65,$3956,$2022,$52A2,$0DA9,$7320
            dc.w    $8966,$9CE4,$4EAC,$E44E,$EEE4,$4EB9,$E37C,$A612
            dc.w    $9D06,$4F49,$01F0,$2420,$A166,$D01A,$6436,$A9FF
            dc.w    $8540,$20F1,$67B0,$DEAC,$E44E,$A52F,$59E8,$7C39
            dc.w    $ED7C,$F007,$80CF,$A612,$9E06,$4FA4,$545A,$A455
            dc.w    $5A48,$20FC,$6268,$60BD,$F44E,$C904,$D026,$A921
            dc.w    $BC06,$4FC0,$05F0,$0DC0,$07F0,$07BC,$FD4E,$C004
            dc.w    $F002,$A925,$48A9,$2520,$2874,$D004,$68C9,$2560
            dc.w    $68C9,$2160,$A900,$60AC,$4102,$BEEB,$4E20,$6E74
            dc.w    $A920,$2028,$74F0,$0620,$0766,$A9BF,$60AE,$4102
            dc.w    $8612,$A905,$8575,$A902,$2028,$74F0,$2320,$8965
            dc.w    $F003,$2046,$74A9,$0220,$4674,$A456,$206D,$53A2
            dc.w    $01A9,$7E20,$8966,$A908,$8DDD,$4EA9,$F78D,$DC4E
            dc.w    $A612,$A900,$6064,$1264,$75A9,$0620,$4674,$A918
            dc.w    $8D46,$F0A9,$868D,$46F0,$9CDD,$4E9C,$DC4E,$A456
            dc.w    $4C6D,$5368,$FAA4,$5620,$2252,$DA48,$A906,$8DE0
            dc.w    $4EA9,$FA8D,$E14E,$FF66,$38A9,$2620,$2874,$D024
            dc.w    $ADDD,$4E0D,$DC4E,$D001,$60AC,$DB4E,$206D,$53AC
            dc.w    $DB4E,$AEDD,$4EAD,$DC4E,$2049,$529C,$DD4E,$9CDC
            dc.w    $4EA9,$0060,$A200,$A905,$2089,$6668,$FAA4,$5620
            dc.w    $2252,$DA48,$EEE0,$4ED0,$C0EE,$E14E,$D0BB,$2007
            dc.w    $66A9,$B160,$ACDB,$4E4C,$2252,$6476,$A456,$9967
            dc.w    $4E8A,$9966,$4E4C,$4952,$A200,$2089,$66A4,$564C
            dc.w    $2252,$688D,$DF4E,$688D,$DE4E,$A612,$9E18
            dc.b    'Od5 3s'
            dc.w    $D048,$20B9,$65D0,$4320,$8965,$F019,$2046,$74A4
            dc.w    $5620,$2252,$A201,$A97E,$2089,$66A9,$088D,$DD4E
            dc.w    $A9F7,$8DDC,$4E20,$2566,$D020,$A612,$9E0F,$4FA9
            dc.w    $4F9D,$184F,$A000,$201A,$6720,$2566,$D00C,$A200
            dc.w    $A922,$2028,$74F0,$02A2,$B48A,$A612,$9D0F,$4F9D
            dc.w    $184F,$A8F0,$089E,$064F,$4820,$0766,$68AE,$DE4E
            dc.w    $DAAE,$DF4E,$DAAA,$6064,$4E9C,$E94E,$8435,$A9CE
            dc.w    $C050,$B04B,$A612,$BD0F,$4FD0,$44BD,$184F,$8534
            dc.w    $989D,$184F,$FF67,$3738,$E534,$F036,$A000,$B005
            dc.w    $49FF,$1AA0,$0485,$3498,$2046,$74A9,$0120,$2874
            dc.w    $A201,$2040,$74F0,$0EC6,$3430,$19A2,$04CA,$D0FD
            dc.w    $2069,$74A2,$0BCA,$D0EA,$A9B5,$A612,$9D0F,$4F9D
            dc.w    $184F,$AA60,$68FA,$A456,$2022,$52DA,$48A2,$00A9
            dc.w    $0320,$8966,$20C2,$73D0,$E160,$A412,$BE06,$4FBC
            dc.w    $FA7E,$A63A,$A539,$853D,$8013,$8A38,$F909,$7FAA
            dc.w    $A53D,$F90A,$7F90,$0E85,$3D98,$6904,$A8B9,$067F
            dc.w    $D0E8,$A9CE,$60B9,$077F,$853F,$B906,$7F85,$40B9
            dc.w    $087F,$8541,$8A79,$097F,$0A85,$3BA5,$3DA0,$072A
            dc.w    $C53F,$9002,$E53F,$263B,$8810,$F485,$3E38,$C8AA
            dc.w    $E540,$B0FA,$843C,$863D,$A53B,$6541,$853B,$A900
            dc.w    $6064,$18A4,$12BE,$064F,$BDF3,$7CD9,$FD4E,$D026
            dc.w    $A540,$8DE9,$4E8A,$0AAA,$8629,$A54D,$C920,$9013
            dc.w    $A576,$A0FF,$8476,$2506,$F009,$2023,$68B0,$03B8
            dc.w    $A980,$607C,$8E7D,$642A,$642B,$A9BD,$3860,$A436
            dc.w    $B9FE,$7C20,$2874,$FF68,$36AD,$4AF0,$A918,$8D46
            dc.w    $F0A9,$018D,$47F0,$8D46,$F0AD,$4AF0,$A908,$8D47
            dc.w    $F060,$202E,$6864,$30A2,$83A0,$03AD,$4FF0,$300B
            dc.w    $CAD0,$F864,$2B64,$2AA9,$BE80,$22AD,$48F0,$88D0
            dc.w    $EAA9,$FA85,$2AA9,$24A2,$00BC,$C07C,$1AD0,$19E6
            dc.w    $2AD0,$15A9,$DF85,$2BA9,$0585,$2AA9,$BDAE,$4AF0
            dc.w    $A018,$AA8C,$46F0,$3860,$2C4F,$F010,$FBCC,$48F0
            dc.w    $D0D5,$E8E0,$0390,$D269,$DB85,$2BA5,$2A69,$0585
            dc.w    $2A2C,$4FF0,$10FB,$AE48,$F0BD,$007B,$3026,$0A0A
            dc.w    $852C,$BD00,$7B2C,$4FF0,$10FB,$AE48,$F0BC,$007B
            dc.w    $842E,$5D00,$7B30,$0DC4,$4090,$0D20,$E568,$B003
            dc.w    $A900,$3860,$A9BB,$80A5,$2C4F,$F010,$FBAE,$48F0
            dc.w    $BC00,$7B30,$EF84,$2D5D,$007B
            dc.b    'F-f,,O'
            dc.w    $F010,$FBAE,$48F0,$BC00,$7B30,$D984,$2F5D,$007B
            dc.b    'F-f,,O'
            dc.w    $F010,$FBAE,$48F0,$BC00,$7B84,$315D,$007B,$D0BE
            dc.w    $A52D,$C908,$2907,$2A85,$2D45,$36D0,$4BA5,$2C45
            dc.w    $35D0,$FF69,$3545,$A52E,$6545,$8546,$0A69,$0685
            dc.w    $19AD,$48F0,$CDC3,$7CD0,$26AD,$C47C,$AE4F,$F010
            dc.w    $FBCD,$48F0,$D019,$8632,$AE4A,$F086,$33A6,$46BD
            dc.w    $DC05,$0A85,$16A9,$0069,$0485,$173C,$B805,$60AE
            dc.w    $4AF0,$A018,$8C46,$F0A9,$BA38,$6020,$3669,$B003
            dc.w    $A9B0,$3860,$A612,$BDF4,$4EC9,$04F0,$04A9,$BD38
            dc.w    $6020,$2E68,$A9FA,$852A,$A024,$A200,$A9BE,$8533
            dc.w    $A901,$2C4F,$F030,$192C,$4FF0,$3014,$2C4F,$F030
            dc.w    $0FEA,$8AF0,$1A20,$3668,$A200,$A9BD,$8533,$800F
            dc.w    $F029,$AD49,$F05D,$D87C,$D0EB,$E8E0,$04F0,$E6C8
            dc.w    $D0CE,$E62A,$D0CA,$A9DC,$852B,$A905,$852A,$A533
            dc.w    $AE4A,$F0A0,$18AA,$8C46,$F038,$60AD,$48F0,$DDD8
            dc.w    $7CD0,$C2E0,$0390,$BE98,$69D7,$852B,$A52A,$6905
            dc.w    $852A,$A200,$A901,$CAF0,$2E2C,$4FF0,$10F8,$D02B
            dc.w    $AC48,$F084,$2CCA,$F01F,$2C4F,$F010,$F8D0,$1CAC
            dc.w    $48F0,$842D,$C436,$D006,$A42C,$C435,$F011,$203F
            dc.w    $6AB0,$03A9,$FF6A,$34B0,$3860,$A9BE,$80A5,$A9BB
            dc.w    $80A1,$CAF0,$F52C,$4FF0,$10F8,$D0F2,$AC48,$F088
            dc.w    $842E,$C440,$9009,$205C,$6AB0,$03A9,$0038,$60CA
            dc.w    $F0D8,$2C4F,$F010,$F8D0,$D5AC,$48F0,$842F,$CAF0
            dc.w    $C92C,$4FF0,$10F8,$D0C6,$AC48,$F084,$30A0,$18CA
            dc.w    $F0B8,$AD4F,$F010,$F8AE,$48F0,$8C46,$F089,$01D0
            dc.w    $AD86,$31AE,$4AF0,$8633,$8532,$2922,$D0A0,$A52E
            dc.w    $1865,$4585,$46AA,$0A69,$0685,$19BD,$DC05,$0A85
            dc.w    $16A9,$0069,$0485,$173C,$B805,$60A6,$297C,$A47D
            dc.w    $A9B9,$60AE,$4AF0,$A018,$8C46,$F0A9,$7060,$AD48
            dc.w    $F0AD,$4AF0,$A9D0,$A200,$BCCC,$7C1A,$F02A,$2C4F
            dc.w    $F010,$FBCC,$48F0,$D0EE,$E8E0,$0390,$EBA9,$0485
            dc.w    $5264,$1A64,$1BA9,$002C,$4FF0,$10FB,$AE48,$F0BC
            dc.w    $007B,$306B,$C42E,$F04C,$A9B9,$8059,$AE48,$F0BC
            dc.w    $007B,$305B,$C980,$2A85,$1CAE,$48F0,$BD00,$7B59
            dc.w    $007C,$451C,$9216,$651A,$851A,$E616,$AE48,$F0BD
            dc.w    $007B,$5940,$7C45,$FF6B,$331A,$9216,$651B,$851B
            dc.w    $E616,$AE48,$F0BD,$007B,$5980,$7C45,$1B92,$1665
            dc.w    $1CC6,$52F0,$69E6,$162C,$4FF0,$70B3,$A208,$2C4F
            dc.w    $F070,$ACCA,$D0F8,$A9BE,$AE4A,$F0A0,$188C,$46F0
            dc.w    $AA60,$A9B8,$80F2,$AE48,$F0BC,$007B,$30F4,$C980
            dc.w    $2A85,$1CAE,$48F0,$BD00,$7B59,$007C,$451C,$9218
            dc.w    $651A,$851A,$AE48,$F0E6,$18F0,$34BD,$007B,$5940
            dc.w    $7C45,$1A92,$1865,$1B85,$1BE6,$18F0,$28AE,$48F0
            dc.w    $BD00,$7B59,$807C,$451B,$9218,$651C,$E618,$2C4F
            dc.w    $F070,$B3A2,$082C,$4FF0,$70AC,$CAD0,$F880,$97E6
            dc.w    $1980,$C880,$9DAE,$48F0,$BC00,$7B30,$F6E6,$19E6
            dc.w    $162C,$4FF0,$50FB,$AE48,$F0BD,$007B,$30E5,$5900
            dc.w    $7C45,$1AD0,$DEAE,$48F0,$BD00,$7B30,$D659,$407C
            dc.w    $451B,$D0CF,$AE48,$F0BD,$007B,$30C7,$5980,$7C45
            dc.w    $1CD0,$C0A0,$182C,$4FF0,$50FB,$AD48,$F04D,$CF7C
            dc.w    $D008,$AD48,$F04D,$D07C,$F002,$A9B7,$AE4A,$F08C
            dc.w    $46F0,$AA60,$AD4A,$F0A9,$FF6C,$3218,$8D46,$F0A9
            dc.w    $018D,$47F0,$8D46,$F0AD,$4AF0,$A908,$8D47,$F0A5
            dc.w    $2CA0,$0091,$16A5,$2DC8,$9116,$A52E,$1AC8,$9116
            dc.w    $A52F,$0920,$C891,$16A5,$30C8,$9116,$A531,$C891
            dc.w    $16A5,$33C8,$9116,$A532,$C891,$16A9,$018D,$24F0
            dc.w    $A9FF,$8D23,$F0A9,$018D,$21F0,$A519,$8D22,$F0A9
            dc.w    $2F85,$52A2,$00A0,$08A9,$012C,$4FF0,$3017,$88D0
            dc.w    $F8C6,$5210,$F0A9,$BEAE,$4AF0,$A018,$8C46,$F0AA
            dc.w    $60A9,$B880,$F264,$52F0,$11AD,$49F0,$5DDC,$7CD0
            dc.w    $05E8,$E004,$90CF,$A9B9,$80DD,$AD48,$F05D,$DC7C
            dc.w    $D0F4,$E003,$90F0,$A285,$2C4F,$F010,$FBAD,$48F0
            dc.w    $8E20,$F092,$18A5,$4ED0,$12A9,$0FA2,$0020,$8966
            dc.w    $68FA,$A456,$2022,$52DA,$48A9,$0020,$A96D,$D0A7
            dc.w    $A210,$CAF0,$A0AD,$4FF0,$10F8,$8901,$D0A3,$AD48
            dc.w    $F0A0,$0891,$16CA,$F08D,$AD4F,$F010,$F889,$01D0
            dc.w    $90AA,$AD48,$F0C8,$9116,$AD4A,$F0C8,$9116,$8AC8
            dc.w    $9116,$A018,$2922,$F002,$A9B8,$FF6D,$318C,$46F0
            dc.w    $602C,$4FF0,$10FB,$9250,$CAD0,$F62C,$4FF0,$10FB
            dc.w    $9250,$60B9,$C07C,$C8CA,$F0F1,$2C4F,$F010,$FB92
            dc.w    $5080,$F02C,$4FF0,$10FB,$9C42,$F060,$A204,$203C
            dc.w    $6DAD,$4FF0,$A018,$8C46,$F0AE,$4AF0,$2920,$F002
            dc.w    $A9B6,$608E,$23F0,$8C24,$F09C,$21F0,$A619,$8E22
            dc.w    $F0A2,$012C,$4FF0,$10FB,$9250,$8E20,$F0A5,$4ED0
            dc.w    $12A9,$0FA2,$0020,$8966,$68FA,$A456,$2022,$52DA
            dc.w    $48A9,$0080,$00AA,$D01C,$8007,$A200,$AC23,$F058
            dc.w    $78A5,$4ED0,$32AD,$24F0,$F00A,$CC23,$F0D0,$EBE8
            dc.w    $D0ED,$8024,$A902,$2C34,$F0D0,$1DA2,$00AC,$23F0
            dc.w    $2C34,$F0D0,$0ACA,$D0F8,$CC23,$F0D0,$F080,$099C
            dc.w    $20F0,$8D34,$F0A9,$0060,$9C20,$F0A9,$028D,$34F0
            dc.w    $A918,$8D46,$F0AD,$4AF0,$E64E,$A54E,$C902,$9002
            dc.w    $A9BE,$60A6,$297C,$BA7D,$A9B9,$60A9,$188D,$46F0
            dc.w    $A910,$8D47,$F0A0,$018C,$47F0,$8C46,$F0AD,$4AF0
            dc.w    $A208,$A9FF,$8D40,$F0A9,$3F8D,$40F0,$FF6E,$30B2
            dc.w    $1685,$2085,$AA51,$168E,$47F0,$8524,$45AA,$85CA
            dc.w    $C851,$1685,$2845,$CAC9,$802A,$859C,$C8A2,$CF8E
            dc.w    $40F0,$A2F3,$2C4F,$F010,$FB8E,$40F0,$5116,$851F
            dc.w    $459C,$65AA,$85AA,$C851,$1685,$2345,$AA65,$CA85
            dc.w    $CAC8,$5116,$8527,$45CA,$659C,$C980,$2A85,$9CC8
            dc.w    $A2FC,$8E40,$F0A2,$FF8E,$40F0,$5116,$851E,$459C
            dc.w    $65AA,$85AA,$C851,$1685,$2245,$AA65,$CA85,$CAC8
            dc.w    $AECC,$7C8E,$40F0,$AECD,$7C8E,$40F0,$5116,$8526
            dc.w    $45CA,$659C,$C980,$2A85,$9CC8,$5116,$851D,$459C
            dc.w    $65AA,$85AA,$C851,$1685,$2145,$AA65,$CA85,$CAC8
            dc.w    $AECE,$7C8E,$40F0,$5116,$8525,$A42E,$BE00,$778E
            dc.w    $40F0,$45CA,$659C,$C980,$2A85,$9CA2,$03B4,$1DB9
            dc.w    $0078,$B421,$1900,$79B4,$2519,$007A,$A8B9,$0077
            dc.w    $8D40,$F0B4,$1DB9,$0077,$8D40,$F0B4,$21B5,$2585
            dc.w    $87CA,$3015,$2C4F,$F050,$FBB9,$0077,$8D40,$F0A4
            dc.w    $87B9,$0077,$8D40,$F080,$C42C,$4FF0,$10FB,$FF6F
            dc.w    $2FA5,$9C4C,$A400,$BD00,$7819,$0079,$DAAA,$BD00
            dc.w    $778D,$40F0,$FABD,$0077,$8D40,$F0AD,$D07C,$48AD
            dc.w    $CF7C,$48A6,$9CBD,$0077,$48B9,$0077,$8D40,$F0A4
            dc.w    $CAB9,$0077,$48BD,$007A,$1900,$79A6,$AABC,$0077
            dc.w    $5A1D,$0078,$A8B9,$0077,$8D40,$F0A2,$0568,$203F
            dc.b    $6D,$CA,$D0,$F9,$AD,$D1,$7C,$24,$43,$30,$03
            dc.b    'L`m ?mL?m'
            dc.w    $A9F5,$8D44,$F0AD,$4AF0,$A918,$8D46,$F0A9,$108D
            dc.w    $47F0,$A901,$8D47,$F08D,$46F0,$AD4A,$F068,$8555
            dc.w    $6885,$54A2,$61CA,$D0FD,$ADE1,$7C92,$5092,$50A2
            dc.w    $088E,$47F0,$A20A,$203C,$6DA2,$03A0,$1CE6,$5020
            dc.w    $476D,$C650,$B9C0,$7CA0,$0220,$776D,$D00F,$2057
            dc.w    $6DA5,$5448,$A555,$48AD,$E07C,$4C60,$6DA6,$54DA
            dc.w    $A655,$DAAA,$60A5,$4DC9,$2090,$0FA6,$297C,$D07D
            dc.w    $A938,$4C97,$66A9,$244C,$9766,$607A,$8455,$7A84
            dc.w    $54A4,$12BE,$064F,$BDF3,$7CD9,$FD4E,$D006,$8A0A
            dc.w    $AA7C,$E67D,$A9CE,$AAA5,$5448,$A555,$FF70,$2E48
            dc.w    $A545,$1865,$4085,$458A,$60A5,$7B2C,$4FF0,$50FB
            dc.w    $9250,$A57A,$9250,$209B,$6AA5,$7992,$50A5,$7892
            dc.w    $50A5
            dc.b    'wL?m$['
            dc.w    $1010,$A206,$8619,$A248,$9118,$C8D0,$FBE6,$19CA
            dc.w    $D0F6,$6099,$0004,$99B8,$04C8,$D0F7,$60A4,$3CD0
            dc.w    $4F64,$45A4,$3BD0,$4964,$1890,$12AD,$E27C,$2055
            dc.w    $70AD,$E07C,$206A,$70A9,$FF85,$5F80,$33A9,$0024
            dc.w    $5F10,$0C20,$6A70,$ADD3,$7C24,$5B10,$0264,$4320
            dc.w    $5570,$A249,$8619,$A2C8,$A005,$B9C6,$7C91,$1888
            dc.w    $10F8,$A518,$1869,$0685,$1890,$02E6,$19CA,$D0E8
            dc.w    $6418,$A43C,$B9FE,$7C20,$2874,$AD4A,$F0A9,$188D
            dc.w    $46F0,$A910,$8D47,$F0A9,$018D,$47F0,$8D46,$F0AD
            dc.w    $4AF0,$A9FF,$8D40,$F08D,$40F0,$A208,$8E47,$F04C
            dc.w    $3F6D,$A53B,$AA29,$3F85,$7B64,$7AA5,$3C85,$36F0
            dc.w    $02A9,$201D,$007A,$8579,$A561,$2920,$0542,$8578
            dc.w    $457B,$4579,$8DE5,$4EA0,$04B6,$77BD,$0077,$9977
            dc.b    $00,$88,$D0,$F5,$18,$20,$FF
            dc.b    'q-tpd='
            dc.b    $A9,$49,$85,$19,$A2,$B0,$A0,$04,$A9,$FF,$20,$77,$6D,$D0,$B9,$A5
            dc.b    $60,$85,$52,$A2,$06,$A0,$06,$20,$47,$6D,$C6,$52,$D0,$F5,$A0,$00
            dc.b    $A2,$03,$20,$47,$6D,$A6,$3D,$B5,$62,$85,$2E,$A8,$4D,$E5,$4E,$AA
            dc.b    $BD,$00,$77,$85,$77,$B9,$00,$77,$85,$7A,$20,$38,$70,$A0,$03,$A2
            dc.b    4,' Gm$'
            dc.w    $4310,$07A0,$0120,$2B6E,$8017,$A208,$2047,$6DA5
            dc.w    $7AA2,$BFA0,$0220,$776D,$D060,$A00F,$A204,$2047
            dc.w    $6DE6,$3DA5,$3DC5,$4090,$A1AD,$D17C,$2060,$6DD0
            dc.w    $3E20,$F167,$9003,$A8D0,$39A0,$AEA5,$2ED0,$33A0
            dc.w    $ADA5,$2B18,$6920,$852B,$A52A,$6900,$A207,$062B
            dc.w    $2AC9,$0590,$02E9,$0526,$2BCA,$10F4,$A52B,$38E5
            dc.w    $60C9,$FF30,$0DA0,$004A,$C540,$9002,$E660,$984C
            dc.w    $2870,$C660,$A560,$C904,$90F4,$4CF9,$70A5,$6129
            dc.w    $1F85,$77AD,$DB7C,$857B,$A53B,$857A,$A53C,$8579
            dc.w    $D018,$A540,$38E9,$05A8,$A200,$A953,$1888,$F007
            dc.w    $6953,$90F9,$E880,$F520,$9966,$3820,$7470,$A63C
            dc.w    $D020,$A904,$8519,$FF72,$2CA2,$80A0,$01AD,$E07C
            dc.w    $2077,$6DD0,$E8A9,$0485,$19A2,$80A0,$01AD,$E07C
            dc.w    $2077,$6DD0,$D864,$53AC,$E07C,$A904,$853D,$E8D0
            dc.w    $0EE6,$53D0,$0AA9,$ADA0,$188C,$46F0,$4C28,$702C
            dc.w    $4FF0,$10FB,$8C40,$F0D0,$0464,$3D80,$E124,$3DD0
            dc.w    $DDA9,$F58D,$44F0,$A250,$ADE0,$7C20,$3C6D,$A20C
            dc.w    $ADE1,$7C20,$3C6D,$A203,$A014,$E650,$2047,$6DC6
            dc.w    $50B9,$C07C,$203F,$6DA2,$32AD,$E07C,$203C,$6DA2
            dc.w    $0CAD,$E17C,$203C,$6DA2,$03A0,$18E6,$5020,$476D
            dc.w    $C650,$A63D,$B562,$852E,$1A85
            dc.b    'x 8p Wm'
            dc.b    $A2,$16,$AD,$E0,$7C,$20,$3C,$6D,$A2,$0C,$AD,$E1,$7C,$20,$3C,$6D
            dc.b    $A2,$03,$A0,$1C,$E6,$50,$20,$47,$6D,$C6,$50,$B9,$C0,$7C,$A0,$02
            dc.b    $20,$77,$6D,$D0,$47,$20,$57,$6D,$A6,$60,$E6,$3D,$A5,$3D,$C5,$40
            dc.b    $90,$A6,$AD,$E0,$7C,$A4,$3C,$F0,$28,$A2,$04,$20,$3C,$6D,$A2,$F4
            dc.b    $8E,$44,$F0,$A2,$FC,$85,$53,$A2,$18,$A8,$A9,$04,$2C,$4F,$F0,$10
            dc.b    $FB,$D0,$0D,$8C,$40,$F0,$E8,$D0,$F3,$E6,$53,$D0,$EF,$4C,$58,$72
            dc.b    $98,$20,$60,$6D,$D0,$03,$3A,$FF,$73,$2B,$D0,$FD
            dc.b    'L(pL r'
            dc.b    $A0,$03,$88,$F0,$35,$A9,$18,$8D,$46,$F0,$A9,$F5,$8D,$44,$F0,$CD
            dc.b    $4C,$F0,$D0,$29,$A9,$F6,$8D,$44,$F0,$CD,$4C,$F0,$D0,$1F,$A9,$F7
            dc.b    $8D,$44,$F0,$CD,$4C,$F0,$D0,$15,$A9,$C0,$8D,$42,$F0,$A9,$02,$2D
            dc.b    $4D,$F0,$8D,$45,$F0,$4D,$4D,$F0,$F0,$55,$A9,$B3,$60,$AD,$4D,$F0
            dc.b    $A9,$1F,$2D,$4E,$F0,$2C,$4C,$F0,$C9,$17,$F0,$22,$A2,$00,$CA,$F0
            dc.b    $E9,$AD,$48,$F0,$AD,$4D,$F0,$A9,$3F,$2D,$4E,$F0,$89,$20,$D0,$EE
            dc.b    $C9,$17,$F0,$0A,$A9,$17,$8D,$4F,$F0,$AD,$4E,$F0,$80,$E0,$AD,$4C
            dc.b    $F0,$AD,$4E,$F0,$AD,$48,$F0,$AD,$4D,$F0,$A9,$57,$8D,$4F,$F0,$49
            dc.b    $40,$8D,$4F,$F0,$49,$40,$8D,$4F,$F0,$8D,$4F,$F0,$4C,$35,$73,$A9
            dc.b    $05,$48,$A6,$12,$BC,$06,$4F,$B9,$5A,$7F,$A8,$B9,$50,$7F,$C8,$C8
            dc.b    $DD,$18,$4F,$90,$F6,$BE,$4F,$7F,$EC,$E3,$4E,$8E,$E3,$4E,$F0,$1C
            dc.b    $FA,$CA,$30,$3E,$DA,$AE,$E3,$4E,$A9,$18,$8D,$46,$F0,$A0,$10,$BD
            dc.b    $65,$7F,$8D,$43,$F0,$CA,$88,$D0,$F6,$AE,$E3,$4E,$A9,$18,$8D,$46
            dc.b    $F0,$A0,$10,$BD,$65,$7F,$4D,$4B,$F0,$D0,$D5,$CA,$88,$D0,$F4,$A9
            dc.b    $8B,$2D,$4D,$F0,$1D,$65,$7F,$8D,$45,$F0,$4D,$4D,$F0,$D0,$C1,$FA
            dc.b    $AA,$60,$A9,$B3,$60,$A0,$F3,$DD,$74,$2A,$8C,$44,$F0,$A0,$20,$89
            dc.b    $20,$F0,$05,$8C,$47,$F0,$80,$03,$8C,$46,$F0,$09,$F0,$8D,$44,$F0
            dc.b    $A9,$04,$2D,$4F,$F0,$60,$A0,$F3,$8C,$44,$F0,$A0,$20,$89,$20,$F0
            dc.b    $05,$8C,$47,$F0,$80,$03,$8C,$46,$F0,$09,$F0,$8D,$44,$F0,$09,$F8
            dc.b    $8D,$44,$F0,$49,$08,$8D,$44,$F0,$60,$AD,$4C,$F0,$80,$F0,$E0,$01
            dc.b    $D0,$0B,$A9,$04,$8D,$46,$F0,$A9,$82,$8D,$47,$F0,$60,$A9,$F7,$8D
            dc.b    $44,$F0,$A9,$20,$8D,$46,$F0,$AD,$CA,$4E,$F0,$0F,$E0,$05,$D0,$4C
            dc.b    $A9,$02,$8D,$46,$F0,$A9,$84,$8D,$47,$F0,$60,$A9,$02,$8D,$46,$F0
            dc.b    $A9,$84,$8D,$47,$F0,$E0,$02,$D0,$24,$A0,$04,$80,$14,$A9,$FF,$8D
            dc.b    $44,$F0,$49,$08,$8D,$44,$F0,$49,$02,$8D,$44,$F0,$49,$02,$8D,$44
            dc.b    $F0,$A9,$04,$2C,$4F,$F0,$F0,$03,$88,$10,$E2,$A8,$60,$A9,$80,$8D
            dc.b    $46,$F0,$8D,$47,$F0,$8A,$38,$E9,$05,$A8,$B0,$E5,$A9,$00,$60,$A0
            dc.b    $F7,$8C,$44,$F0,$A2,$20,$8E,$47,$F0,$AD,$4F,$F0,$8E,$46,$F0,$A2
            dc.b    $10,$80,$07,$8C,$44,$F0,$88,$AD,$4F,$F0,$29,$04,$C9,$04,$8A,$2A
            dc.b    $AA,$90,$F0,$BD,$BA,$7F,$60,$FF,$77,$00,$96,$97,$9A,$9B,$9D,$9E
            dc.b    $9F,$A6,$A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3,$B4,$B5,$B6,$B7,$B9,$BA
            dc.b    $BB,$BC,$BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3,$D6,$D7,$D9,$DA,$DB,$DC
            dc.b    $DD,$DE,$DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F2,$F3,$F4
            dc.b    $F5,$F6,$F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$96,$97,$9A,$9B,$9D,$9E
            dc.b    $9F,$A6,$A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3,$B4,$B5,$B6,$B7,$B9,$BA
            dc.b    $BB,$BC,$BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3,$D6,$D7,$D9,$DA,$DB,$DC
            dc.b    $DD,$DE,$DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F2,$F3,$F4
            dc.b    $F5,$F6,$F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$96,$97,$9A,$9B,$9D,$9E
            dc.b    $9F,$A6,$A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3,$B4,$B5,$B6,$B7,$B9,$BA
            dc.b    $BB,$BC,$BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3,$D6,$D7,$D9,$DA,$DB,$DC
            dc.b    $DD,$DE,$DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F2,$F3,$F4
            dc.b    $F5,$F6,$F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$96,$97,$9A,$9B,$9D,$9E
            dc.b    $9F,$A6,$A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3,$B4,$B5,$B6,$B7,$B9,$BA
            dc.b    $BB,$BC,$BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3,$D6,$D7,$D9,$DA,$DB,$DC
            dc.b    $DD,$DE,$DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F2,$F3,$F4
            dc.b    $F5,$F6,$F7,$F9,$FA,$FB,$FC,$FD,$FE,$01,$77,$FF,$FF,$C0,$78,$40
            dc.b    $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
            dc.b    $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
            dc.b    $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
            dc.b    $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
            dc.b    '                                                            '
            dc.b    '    00000000000000000000000000000000000000000000000000000000'
            dc.b    '00000000'
            dc.b    $C0,$79,$40,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
            dc.b    $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
            dc.b    $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
            dc.b    $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
            dc.b    $04,$04,$04,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
            dc.b    $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
            dc.b    $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
            dc.b    $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
            dc.b    $08,$08,$08,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
            dc.b    $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
            dc.b    $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
            dc.b    $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
            dc.b    $0C,$0C,$0C,$FF,$7A,$40,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
            dc.b    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
            dc.b    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
            dc.b    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
            dc.b    $01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
            dc.b    $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
            dc.b    $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
            dc.b    $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
            dc.b    $02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
            dc.b    $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
            dc.b    $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
            dc.b    $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
            dc.b    $03,$03,$03,$03,$03,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$C1,$7B,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
            dc.b    $01,$FF,$FF,$02,$03,$FF,$04,$05,$06,$FF,$FF,$FF,$FF,$FF,$FF,$07
            dc.b    $08,$FF,$FF,$FF,$09,$0A,$0B,$0C,$0D,$FF,$FF,$0E,$0F,$10,$11,$12
            dc.b    $13,$FF,$14,$15,$16,$17,$18,$19,$1A,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            dc.b    $FF,$FF,$FF,$FF,$1B,$FF,$1C,$1D,$1E,$FF,$FF,$FF,$1F,$FF,$FF,$20
            dc.b    $21,$FF,$22
            dc.b    '#$%&',$27,$28
            dc.b    $FF,$FF,$FF,$FF,$FF,$29,$2A,$2B,$FF
            dc.b    ',-./012'
            dc.w    $FFFF
            dc.b    '345678'
            dc.w    $FF39
            dc.b    ':;<=>?0|'
            dc.b    16,'@@@@@@@@@@@@@@@@'
            dc.b    $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
            dc.b    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
            dc.b    $0C,$7C,$44,$40,$40,$40,$40,$80,$80,$80,$80,$C0,$C0,$C0,$C0,$0C
            dc.b    '|T@@@@'
            dc.b    $80,$80,$80,$80,$C0,$C0,$C0,$C0,$0C
            dc.b    '|d@@@@'
            dc.b    $80,$80,$80,$80,$C0,$C0,$C0,$C0,$FF
            dc.b    '|t@@@@'
            dc.b    $80,$80,$80,$80,$C0,$C0,$C0,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0
            dc.b    $00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0
            dc.b    $00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0
            dc.b    $00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0
            dc.b    $00,$40,$80,$C0,$00,$40,$80,$C0,$D5,$AA,$96,$DE,$AA,$FF,$FF,$3F
            dc.b    $CF,$F3,$FC,$FF,$D5,$AA,$AD,$DE,$AA,$FF,$FF,$96,$C2,$C2,$C2,$FC
            dc.b    $A1,$A1,$A1,$FE,$A1,$A1,$A1,$FB,$4E,$00,$F6,$04,$06,$03,$05,$07
            dc.b    $01,$22,$02,$02,$02,$00,$20,$FF,$20,$FF,$00,$01,$01,$02,$03,$03
            dc.b    $03,$04,$04,$01,$01,$01,$04,$24,$60,$50,$EC,$6D,$C0,$57,$EC,$6D
            dc.b    $E9,$53,$E9,$53,$E9,$53,$E9,$53,$72,$50,$EC,$6D,$C0,$57,$EC,$6D
            dc.b    $E9,$53,$E9,$53,$E9,$53,$E9,$53,$31,$53,$EC,$6D,$C0,$57,$EC,$6D
            dc.b    $E9,$53,$E9,$53,$E9,$53,$E9,$53,$31,$53,$EC,$6D,$C0,$57,$EC,$6D
            dc.b    $E9,$53,$E9,$53,$E9,$53,$E9,$53,$93,$51,$12,$5A,$24,$55,$E9,$53
            dc.b    $E9,$53,$E9,$53,$E9,$53,$E9,$53,$75,$57,$0D,$55,$E9,$53,$E9,$53
            dc.b    $E9,$53,$E9,$53,$9F,$57,$C6,$57,$C4,$57,$17,$59,$22,$59,$E7,$58
            dc.b    $A4,$58,$26,$5A,$8E,$5F,$B1,$60,$B4,$5B,$9D,$AA,$7D,$73,$5A,$9D
            dc.b    $5A,$CF,$58,$FF,$58,$C4,$57,$B9,$58,$41,$61,$9F,$57,$9F,$57,$9F
            dc.b    $57,$9F,$57,$9F,$57,$9F,$57,$9F
            dc.b    'W&h&h&hOhOh'
            dc.b    $84,$69,$91
            dc.b    'iOh&h&h&h'
            dc.w    $BD6A,$BD6A,$BD6A,$CB6A,$CB6A,$2E6C,$2E6C,$C06A
            dc.w    $BD6A,$BD6A,$BD6A,$0C6E,$0C6E,$0C6E,$0F6E,$0F6E
            dc.w    $926F,$926F,$C06A,$0C6E,$0C6E,$0C6E,$0770,$0770
            dc.w    $0770,$0270,$0270,$0770,$0770,$0270,$0770,$0770
            dc.b    7,'p&p&p&p'
            dc.b    $F9,$70,$F9,$70,$F3,$71,$F3
            dc.b    'q&p&p&p&p'
            dc.w    $0002,$0406,$080A,$0C0E,$0100,$0001,$0002,$0101
            dc.w    $01FF,$FF01,$0101,$0101,$0100,0,$0808,$5065
            dc.w    $65FF,$7E23,$0222,$0202,$0200,0,$0701,$0801
            dc.w    $0AFF,$0E00,$0F00,$1200,$1300,$1400,$15FF,$1600
            dc.w    $1800,$1A00,$1B00,$1E00,$1F00,$0008,$FF09,$000B
            dc.w    $0011,0,$0900,$0B00,$1107,$1901,$1701,$1E03
            dc.w    $0009,$000B,$0011,$0219,$0200,$09FF,$0BFF,$1103
            dc.w    $1906,$0009,$FF0B,$FF11,$0412,$FF19,$0E00,$0700
            dc.w    $1900,$1700,$0017,$0200,$1910,$1710,$0007,$020A
            dc.w    $001C,$001D,0,$0708,$0A00,$1C98,$1D35,$0007
            dc.w    $020A,$001C,$031D,$2000,$0702,$1704,$1C06,$1D40
            dc.w    $0007,$0213,$FF17,$081C,$051D,$A000,$0702,$13FF
            dc.w    $14FF,$1C0B,$1D40,$0007,$0313,$FF14,$FF19,$1017
            dc.w    $101C,$0B1D,$4000,$1F1F,$353E,$471F,$1F28,$1F52
            dc.w    $5960,$595C,$6361,$6A73,$7C85,$909B,0,$0800
            dc.w    $0005,$0D0D,$0D02,$0304,$0506,$FF44,$4444,$001B
            dc.w    $363D,$1B44,$4444,$010C,$0C00,$C000,$0B0B,$10B0
            dc.w    $000A,$0A20,$A000,$0909,$3090,$0008,$0840,$8000
            dc.w    $0002,$0C38,$7F22,$1800,$8001,$0B16,$1060,$010A
            dc.w    $1420,$4001,$0912,$3020,$0108,$1040,$0001,$0002
            dc.w    $0912,$00A0,$0500,$0212,$2400,$400B,$0001,$0808
            dc.w    $0008,0,$FF10,$FF21,$FF32,$FF21,$FF43,$6A7F
            dc.w    $5F02,$0200,$0808,$0844,$3C88,$3C88
            dc.b    '<<<<<<<<<<@'
            dc.b    $1A,$20,$3B,$57,$1B,$97,$19,$19,$2F,$2F,$1B,$1B,$18,$18,$2E,$2E
            dc.b    $41,$18,$20,$3B,$57,$1B,$97,$19,$19,$2F,$2F,$1B,$1B,$18,$18,$2E
            dc.b    $2E,$41,$18,$44,$FC,$00,$FC,$00,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
            dc.b    $FC,$FC,$00,$FA,$44,$3C,$68,$3C,$A8
            dc.b    '9:<?8,:99<@'
            dc.b    $1A,$02,$01,$01,$04,$01,$01,$01,$01,$01,$01,$03,$04,$01,$01,$07
            dc.b    $1B,$7F,$E5,$A2,$FF,$9A,$A9,$41,$A0,$59,$78,$A2,$03,$8E,$1F,$02
            dc.b    $AE,$1F,$02,$D0,$FB,$4C,$28,$50,$5E,$50,$00,$50,$4E,$50,$00,$80
            ds.b    1541
RsrcEntrySERD_61:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'SERD' 61 "IOP Async B" (3092 bytes) - Combo mask
            dc.l    RsrcEntryiopc_1-BaseOfROM       ; Next entry
            dc.l    RsrcSERD_61-BaseOfROM           ; Data
            dc.b    'SERD'                          ; Type
            dc.w    61                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    11,'IOP Async B'                ; Name
            dc.b    $00
            dc.l    $C0A00000,$00000C20,$0000019C   ; Block header
RsrcSERD_61:
            dc.w    $8008,$4CB0,$564C,$C857,$A2AA,$A032,$7400,$E888
            dc.w    $D0FA,$9C05,$029C,$0602,$9C07,$029C,$0503,$9C06
            dc.w    $039C,$0703,$A05E,$A2CE,$A901,$2027,$5FA0,$5DA9
            dc.w    $4BA2,$0E38,$2003,$5FA2,$00A9,$0220,$185F,$A901
            dc.w    $2015,$5FA9,$FE20,$1B5F,$A95F,$A22A,$F001,$1A85
            dc.w    $CD85,$D185,$CA18,$6910,$85CB,$85C9,$1869,$0885
            dc.w    $D21A,$85D3,$A5C9,$8DE8,$029C,$E902,$A908,$8DEA
            dc.w    $029C,$EB02,$A900,$8DEC,$02A9,$BC8D,$ED02,$A9FF
            dc.w    $85C6,$85B8,$A980,$85AB,$A924,$8D28,$F0A5,$D28D
            dc.w    $2AF0,$9C29,$F0A9,$FF8D,$2BF0,$9C2C,$F0A0,$5DA9
            dc.w    $7FA2,$0038,$200C,$5FA0,$5DA9,$B5A2,$0238,$200C
            dc.w    $5FA0,$5DA9,$97A2,$0638,$200C,$5FA0,$5DA9,$3BA2
            dc.w    $0C38,$2003,$5FA0,$5DA9,$43A2,$0A38,$2003,$5FA0
            dc.w    $5CA9,$EBA2,$0A38,$2006,$5FA0,$5CA9,$EBA2,$0C38
            dc.w    $2006,$5FA0,$5CA9,$EBA2,$0E38,$2006,$5FAD,$E602
            dc.w    $8D70,$5EAD,$E702,$8D6E,$5EAD,$E402,$200D,$5EAD
            dc.w    $40F0,$29A0,$85AD,$A901,$0C28,$F0E6,$AAA2,$0AA9
            dc.w    $0120,$185F,$A903,$8D07,$02A9,$040C,$35F0,$8007
            dc.w    $A20A,$1820,$0F5F,$60A9,$0F20,$155F,$0AAA,$7CAE
            dc.w    $5EAD,$29F0,$F0F1,$78A9,$011C,$28F0,$08AD,$29F0
            dc.w    $3A85,$D4A5,$B485,$B328,$F013,$A901,$8D40,$F0AD
            dc.w    $40F0,$2970,$85B3,$F005,$A930,$8D40,$F0A4,$D2A6
            dc.w    $D386,$D284,$D384,$AF64,$AE8E,$2AF0,$9C29,$F0A9
            dc.w    $FF8D,$2BF0,$64B4,$A901,$0C28,$F058,$B2AE,$25B0
            dc.w    $E6AE,$A6B1,$F006,$C5B1,$D002,$A5B2,$A6B7,$F017
            dc.w    $C5C3,$D008,$64C2,$2094,$5C4C,$0359,$C5C4,$D007
            dc.w    $A9FF,$85C2,$4C03,$59AA,$A5D4,$D034,$A5B3,$F030
            dc.w    $24BC,$1004,$64BD,$64BC,$05BD,$85BD,$A5B3,$8910
            dc.w    $F006,$A4B1,$F002,$A6B1,$24C6,$F014,$A5D7,$F003
            dc.w    $4C0D,$59C6,$D7A5,$CE85,$D5A5,$CF85,$D64C,$0D59
            dc.w    $A5CE,$D017,$A5CF,$C910,$D011,$A901,$24BC,$1004
            dc.w    $64BD,$64BC,$05BD,$85BD,$4C0D,$598A,$92CC,$E6CC
            dc.w    $D00B,$A5CD,$1AC5,$CBD0,$02A5,$CA85,$CDE6,$CED0
            dc.w    $02E6,$CFA5,$BBF0,$44A5,$CFC9,$0C90,$3ED0,$06A5
            dc.w    $CEC9,$0090,$36A5,$BAF0,$16A9,$4004,$BED0,$10A5
            dc.w    $AB29,$7F85,$ABA2,$0578,$8E40,$F08D,$40F0,$58A5
            dc.w    $B9F0,$18A9,$8004,$BED0,$12A6,$C478,$86C5,$A904
            dc.w    $2C40,$F0F0,$058E,$42F0,$64C5,$58A5,$D4F0,$063A
            dc.w    $85D4,$4C24,$5820,$EC5C,$4CCF,$5778,$A901,$1C28
            dc.w    $F0A9,$018D,$40F0,$AD40,$F06A,$90F5,$A901,$8D40
            dc.w    $F09C,$40F0,$A903,$8D40,$F0AD,$665E,$8D40,$F0A9
            dc.w    $058D,$40F0,$A5AB,$24C8,$3002,$297F,$29F7,$8D40
            dc.w    $F0A0,$00A2,$00A9,$0120,$275F,$A200,$1820,$0C5F
            dc.w    $A202,$1820,$0C5F,$A206,$1820,$0C5F,$A20E,$1820
            dc.w    $035F,$A20C,$1820,$035F,$A20A,$1820,$035F,$A20A
            dc.w    $1820,$065F,$A20C,$1820,$065F,$A20E,$1820,$065F
            dc.w    $A5BF,$F00A,$A903,$8D05,$02A9,$040C,$35F0,$A5C0
            dc.w    $F00A,$A903,$8D06,$02A9,$040C,$35F0,$A903,$8D07
            dc.w    $02A9,$040C,$35F0,$A910,$2015,$5F80,$F9A9,$FD20
            dc.w    $1B5F,$9CE0,$02AD,$E102,$F003,$4C13,$59AD,$E202
            dc.w    $38E9,$0890,$04C9,$1490,$10CE,$E002,$A903,$8D07
            dc.w    $02A9,$040C,$35F0,$4CD9,$570A,$AA7C,$885E,$ADE6
            dc.w    $028D,$705E,$ADE7,$028D,$6E5E,$ADE4,$0220,$0D5E
            dc.w    $4CD4,$59A5,$BA8D,$EB02,$ADE6,$0285,$C3AD,$E702
            dc.w    $85C4,$ADE8,$0285,$C6AD,$E902,$85C7,$A5B7,$D002
            dc.w    $64C2,$ADEA,$02D0,$1CA5,$B9F0,$18A9,$8014,$BEF0
            dc.w    $12A6,$C378,$86C5,$A904,$2C40,$F0F0,$058E,$42F0
            dc.w    $64C5,$58A5,$BAF0,$1BAD,$EB02,$D016,$A940,$14BE
            dc.w    $F010,$A5AB,$0980,$85AB,$A205,$788E,$40F0,$8D40
            dc.w    $F058,$ADE4,$0285,$B7AD,$E502,$85B8,$ADEA,$0285
            dc.w    $B9AD,$EB02,$85BA,$05B9,$85BB,$A2FF,$A5C6,$2910
            dc.w    $05B1,$D002,$A2FB,$A901,$788D,$40F0,$8E40,$F058
            dc.w    $8E7E,$5E20,$945C,$4CD4,$59A5,$AB80,$04A5,$AB09
            dc.w    $10A8,$A9FF,$85B5,$85B6,$78A9,$018D,$40F0,$AD40
            dc.w    $F06A,$B00E,$A5B5,$D002,$C6B6,$C6B5,$D002,$A5B6
            dc.w    $D0E7,$A905,$8D40,$F08C,$40F0,$584C,$D459,$ADE5
            dc.w    $028D,$6E5E,$ADE4,$028D,$705E,$A5AC,$200D,$5E4C
            dc.w    $D459,$A928,$8D6C,$5EAD,$E402,$29C0,$0904,$8D62
            dc.w    $5EA9,$008D
            dc.b    'r^ I^L'
            dc.w    $D459,$ADE4,$0285,$C84C,$D459,$A940,$14BE,$F010
            dc.w    $A5AB,$0980,$85AB,$A205,$788E,$40F0,$8D40,$F058
            dc.w    $4CD4,$59A9,$4004,$BED0,$10A5,$AB29,$7F85,$ABA2
            dc.w    $0578,$8E40,$F08D,$40F0,$584C,$D459,$ADE4,$0285
            dc.w    $B185,$B2A2,$FFA5,$C629,$1005,$B1D0,$02A2,$FBA9
            dc.w    $0178,$8D40,$F08E,$40F0,$588E,$7E5E,$4CD4,$59AD
            dc.w    $E402,$85B1,$ADE5,$0285,$B280,$D8A9,$FF85,$C24C
            dc.w    $D459,$64C2,$2094,$5C4C,$D459,$A980,$14BE,$F012
            dc.w    $A6C3,$7886,$C5A9,$042C,$40F0,$F005,$8E42,$F064
            dc.w    $C558,$4CD4,$59A9,$8014,$BEA6,$C378,$86C5,$A904
            dc.w    $2C40,$F0F0,$058E,$42F0,$64C5,$584C,$D459,$A980
            dc.w    $04BE,$D012,$A6C4,$7886,$C5A9,$042C,$40F0,$F005
            dc.w    $8E42,$F064,$C558,$4CD4,$59A9,$8004,$BEA6,$C478
            dc.w    $86C5,$A904,$2C40,$F0F0,$058E,$42F0,$64C5,$584C
            dc.w    $D459,$1820,$1E5F,$4CD4,$59A9,$FB20,$1B5F,$A9FF
            dc.w    $85BF,$A5D7,$F018,$ADA6,$02D0,$1138,$A5D5,$EDA5
            dc.w    $0285,$D5A5,$D6ED,$A402,$85D6,$B002,$64D7,$38A5
            dc.w    $CEED,$A502,$85CE,$A5CF,$EDA4,$0285,$CF18,$A5D0
            dc.w    $6DA5,$0285,$D0A5,$D16D,$A402,$C5CB,$9005,$E5CB
            dc.w    $1865,$CA85,$D1A5,$BBF0,$44A5,$CFC9,$0490,$08D0
            dc.w    $3CA5,$CEC9,$00B0,$36A5,$BAF0,$16A9,$4014,$BEF0
            dc.w    $10A5,$AB09,$8085,$ABA2,$0578,$8E40,$F08D,$40F0
            dc.w    $58A5,$B9F0,$18A9,$8014,$BEF0,$12A6,$C378,$86C5
            dc.w    $A904,$2C40,$F0F0,$058E,$42F0,$64C5,$5820,$EC5C
            dc.w    $4CD9,$57A9,$F720,$1B5F,$ADC5,$0285,$DAAD,$C402
            dc.w    $85DB,$64D8,$A5C9,$85D9,$A9FF,$85C0,$2094,$5C4C
            dc.w    $D957,$0878,$A000,$A904,$2C40,$F0D0,$0228,$60A5
            dc.w    $C5F0,$0864,$C58D,$42F0,$C828,$60A5,$C0F0,$FAA5
            dc.w    $B7F0,$04A5,$C2D0,$06A5,$B8F0,$02A5,$C1D0,$EAC8
            dc.w    $B2D8,$8D42,$F0E6,$D8D0,$02E6,$D9A5,$DAD0,$02C6
            dc.w    $DBC6,$DAD0,$02A5,$DBD0,$D064,$C09C,$C002,$28A9
            dc.w    $038D,$0602,$A904,$0C35,$F060,$A5BF,$F049,$A5D7
            dc.w    $D006,$A5CE,$05CF,$F03F,$A5D7,$8DA0,$02A5,$CA8D
            dc.w    $A602,$9CA7,$02A5,$CB8D,$A802,$9CA9,$02A5,$D08D
            dc.w    $AB02,$A5D1,$8DAA,$02A5,$CF8D,$AC02,$A5CE,$8DAD
            dc.w    $02A5,$D58D,$AF02,$A5D6,$8DAE,$02A9,$038D,$0502
            dc.w    $A904,$0C35,$F064,$BF60,$60A2,$0AA9,$0820,$185F
            dc.w    $60A2,$0AA9,$0420,$185F,$609C,$E002,$ADE1,$02F0
            dc.w    $143A,$F01D,$3AF0,$0ECE,$E002,$A903,$8D07,$02A9
            dc.w    $040C,$35F0,$60A5,$AAF0,$EEA2,$0AA9,$0220,$185F
            dc.w    $60A5,$AAD0,$E2A2,$0AA9,$0120,$185F,$6020,$945C
            dc.w    $A904,$2C40,$F0F0,$0898,$D0F3,$A928,$8D40,$F0A9
            dc.w    $088D,$34F0,$60A9,$018D,$40F0,$AD40,$F029,$70F0
            dc.w    $0785,$B4A9,$011C,$28F0,$A930,$8D40,$F0A9,$088D
            dc.w    $34F0,$60AD,$40F0,$29A0,$AA45,$AD86,$ADAA,$24C7
            dc.w    $F017,$AC06,$03D0,$128E,$C503,$A5AD,$8DC4,$03A9
            dc.w    $018D,$0603,$A908,$0C35,$F08A,$8920,$F01F,$64C1
            dc.w    $A5AD,$2920,$F002,$C6C1,$A5B7,$F004,$A5C2,$D006
            dc.w    $A5B8,$F002,$A5C1,$D005,$DA20,$945C,$FA8A,$1000
            dc.w    $A910,$8D40,$F0A9,$088D,$34F0,$6085,$AC29,$0C4A
            dc.w    $4AA8,$B984,$5E85,$B0A5,$AC4A,$4A4A,$4A29,$0F09
            dc.w    $408D,$625E,$A5AC,$0A0A,$0A0A,$29C0,$8D66,$5E09
            dc.w    $018D,$745E,$4A24,$AB10,$0209,$8009,$028D,$685E
            dc.w    $0908,$8D76,$5E85,$ABA0,$0078,$B961,$5E30,$0D8D
            dc.w    $40F0,$B960,$5E8D,$40F0,$C8C8,$80EE,$5860,$0209
            dc.w    $0004,$0002,$0003,$0005,$000A,$500B,$000C,$000D
            dc.w    $010E,$0003,$0005,$A00F,$1000,$1000,$FF01,$0A09
            dc.w    $FFFF,$1F7F,$3FFF,$E659,$D159,$FB59,$915A,$955A
            dc.b    $C6,$5A,$00,$5A,$DA,$5A,$F4,$5A,$FC,$5A,$15
            dc.b    '[.[Q[][d[l['
            dc.w    $875B,$A05B,$BB5B,$D45B,$D957,$B559,$B559,$DB5B
            dc.w    $DB5B,$DB5B,$DB5B,$755C,$755C,$755C,$755C,$755C
            dc.w    $755C,$755C,$755C,$020C
            dc.b    'SerialDriver&Version 1.0 '
            dc.b    $A9,$20
            dc.b    'Apple Computer Inc. 1988l'
            dc.w    0,$6C02,$006C,$0400,$6C06,$006C,$0800,$6C0A
            dc.w    $006C,$0C00,$6C0E,$006C,$1000,$6C12,$006C,$1400
            dc.b    $6C,$16,$00,$6C,$18
            ds.b    915
            ds.b    12
RsrcEntrySERD_60:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'SERD' 60 "IOP Async A" (3092 bytes) - Combo mask
            dc.l    RsrcEntrySERD_61-BaseOfROM      ; Next entry
            dc.l    RsrcSERD_60-BaseOfROM           ; Data
            dc.b    'SERD'                          ; Type
            dc.w    60                              ; ID
            dc.b    $58                             ; Attributes
            dc.b    11,'IOP Async A'                ; Name
            dc.b    $00
            dc.l    $C0A00000,$00000C20,$00000194   ; Block header
RsrcSERD_60:
            dc.w    $8008
            dc.b    'L[-Ls.'
            dc.w    $A255,$A032,$7400,$E888,$D0FA,$9C02,$029C,$0302
            dc.w    $9C04,$029C,$0203,$9C03,$039C,$0403,$A035,$A279
            dc.w    $A900,$20D2,$35A0,$33A9,$F6A2,$0838,$20AE,$35A2
            dc.w    $00A9,$0220,$C335,$A901,$20C0,$35A9,$FE20,$C635
            dc.w    $A935,$A2D5,$F001,$1A85,$7885,$7C85,$7518,$6910
            dc.w    $8576,$8574,$1869,$0885,$7D1A,$857E,$A574,$8D88
            dc.w    $029C,$8902,$A908,$8D8A,$029C,$8B02,$A900,$8D8C
            dc.w    $02A9,$678D,$8D02,$A9FF,$8571,$8563,$A980,$8556
            dc.w    $A934,$8D20,$F0A5,$7D8D,$22F0,$9C21,$F0A9,$FF8D
            dc.w    $23F0,$9C24,$F0A0,$34A9,$2AA2,$0838,$20B7,$35A0
            dc.w    $34A9,$60A2,$0A38,$20B7,$35A0,$34A9,$42A2,$0E38
            dc.w    $20B7,$35A0,$33A9,$E6A2,$0638,$20AE,$35A0,$33A9
            dc.w    $EEA2,$0438,$20AE,$35A0,$33A9,$96A2,$0438,$20B1
            dc.w    $35A0,$33A9,$96A2,$0638,$20B1,$35A0,$33A9,$96A2
            dc.w    $0838,$20B1,$35AD,$8602,$8D1B,$35AD,$8702,$8D19
            dc.w    $35AD,$8402,$20B8,$34AD,$41F0,$29A0,$8558,$A901
            dc.w    $0C20,$F0E6,$55A2,$05A9,$0120,$C335,$A903,$8D04
            dc.w    $02A9,$040C,$35F0,$8007,$A205,$1820,$BA35,$60A9
            dc.w    $0F20,$C035,$0AAA,$7C59,$35AD,$21F0,$F0F1,$78A9
            dc.w    $011C,$20F0,$08AD,$21F0,$3A85,$7FA5,$5F85,$5E28
            dc.w    $F013,$A901,$8D41,$F0AD,$41F0,$2970,$855E,$F005
            dc.w    $A930,$8D41,$F0A4,$7DA6,$7E86,$7D84,$7E84,$5A64
            dc.w    $598E,$22F0,$9C21,$F0A9,$FF8D,$23F0,$645F,$A901
            dc.w    $0C20,$F058,$B259,$255B,$E659,$A65C,$F006,$C55C
            dc.w    $D002,$A55D,$A662,$F017,$C56E,$D008
            dc.b    'dm ?3L'
            dc.w    $AE2F,$C56F,$D007,$A9FF,$856D,$4CAE,$2FAA,$A57F
            dc.w    $D034,$A55E,$F030,$2467,$1004,$6468,$6467,$0568
            dc.w    $8568,$A55E,$8910,$F006,$A45C,$F002,$A65C,$2471
            dc.w    $F014,$A582,$F003,$4CB8,$2FC6,$82A5,$7985,$80A5
            dc.w    $7A85,$814C,$B82F,$A579,$D017,$A57A,$C910,$D011
            dc.w    $A901,$2467,$1004,$6468,$6467,$0568,$8568,$4CB8
            dc.w    $2F8A,$9277,$E677,$D00B,$A578,$1AC5,$76D0,$02A5
            dc.w    $7585,$78E6,$79D0,$02E6,$7AA5,$66F0,$44A5,$7AC9
            dc.w    $0C90,$3ED0,$06A5,$79C9,$0090,$36A5,$65F0,$16A9
            dc.w    $4004,$69D0,$10A5,$5629,$7F85,$56A2,$0578,$8E41
            dc.w    $F08D,$41F0,$58A5,$64F0,$18A9,$8004,$69D0,$12A6
            dc.w    $6F78,$8670,$A904,$2C41,$F0F0,$058E,$43F0,$6470
            dc.w    $58A5,$7FF0,$063A,$857F,$4CCF,$2E20,$9733,$4C7A
            dc.w    $2E78,$A901,$1C20,$F0A9,$018D,$41F0,$AD41,$F06A
            dc.w    $90F5,$A901,$8D41,$F09C,$41F0,$A903,$8D41,$F0AD
            dc.w    $1135,$8D41,$F0A9,$058D,$41F0,$A556,$2473,$3002
            dc.w    $297F,$29F7,$8D41,$F0A0,$00A2,$00A9,$0020,$D235
            dc.w    $A208,$1820,$B735,$A20A,$1820,$B735,$A20E,$1820
            dc.w    $B735,$A208,$1820,$AE35,$A206,$1820,$AE35,$A204
            dc.w    $1820,$AE35,$A204,$1820,$B135,$A206,$1820,$B135
            dc.w    $A208,$1820,$B135,$A56A,$F00A,$A903,$8D02,$02A9
            dc.w    $040C,$35F0,$A56B,$F00A,$A903,$8D03,$02A9,$040C
            dc.w    $35F0,$A903,$8D04,$02A9,$040C,$35F0,$A910,$20C0
            dc.w    $3580,$F9A9,$FD20,$C635,$9C80,$02AD,$8102,$F003
            dc.w    $4CBE,$2FAD,$8202,$38E9,$0890,$04C9,$1490,$10CE
            dc.w    $8002,$A903,$8D04,$02A9,$040C,$35F0,$4C84,$2E0A
            dc.w    $AA7C,$3335,$AD86,$028D,$1B35,$AD87,$028D,$1935
            dc.w    $AD84,$0220,$B834,$4C7F,$30A5,$658D,$8B02,$AD86
            dc.w    $0285,$6EAD,$8702,$856F,$AD88,$0285,$71AD,$8902
            dc.w    $8572,$A562,$D002,$646D,$AD8A,$02D0,$1CA5,$64F0
            dc.w    $18A9,$8014,$69F0,$12A6,$6E78,$8670,$A904,$2C41
            dc.w    $F0F0,$058E,$43F0,$6470,$58A5,$65F0,$1BAD,$8B02
            dc.w    $D016,$A940,$1469,$F010,$A556,$0980,$8556,$A205
            dc.w    $788E,$41F0,$8D41,$F058,$AD84,$0285,$62AD,$8502
            dc.w    $8563,$AD8A,$0285,$64AD,$8B02,$8565,$0564,$8566
            dc.w    $A2FF,$A571,$2910,$055C,$D002,$A2FB,$A901,$788D
            dc.b    $41,$F0,$8E,$41,$F0,$58,$8E
            dc.b    ')5 ?3L'
            dc.b    $7F,$30,$A5,$56,$80,$04,$A5,$56,$09,$10,$A8,$A9,$FF,$85,$60,$85
            dc.b    $61,$78,$A9,$01,$8D,$41,$F0,$AD,$41,$F0,$6A,$B0,$0E,$A5,$60,$D0
            dc.b    $02,$C6,$61,$C6,$60,$D0,$02,$A5,$61,$D0,$E7,$A9,$05,$8D,$41,$F0
            dc.b    $8C,$41,$F0,$58,$4C,$7F,$30,$AD,$85,$02,$8D,$19,$35,$AD,$84,$02
            dc.b    $8D,$1B,$35,$A5,$57,$20,$B8,$34,$4C,$7F,$30,$A9,$28,$8D,$17,$35
            dc.b    $AD,$84,$02,$29,$C0,$09,$04,$8D,$0D,$35,$A9,$00,$8D,$1D,$35,$20
            dc.b    $F4,$34,$4C,$7F,$30,$AD,$84,$02,$85,$73,$4C,$7F,$30,$A9,$40,$14
            dc.b    $69,$F0,$10,$A5,$56,$09,$80,$85,$56,$A2,$05,$78,$8E,$41,$F0,$8D
            dc.b    $41,$F0,$58,$4C,$7F,$30,$A9,$40,$04,$69,$D0,$10,$A5,$56,$29,$7F
            dc.b    $85,$56,$A2,$05,$78,$8E,$41,$F0,$8D,$41,$F0,$58,$4C,$7F,$30,$AD
            dc.b    $84,$02,$85,$5C,$85,$5D,$A2,$FF,$A5,$71,$29,$10,$05,$5C,$D0,$02
            dc.b    $A2,$FB,$A9,$01,$78,$8D,$41,$F0,$8E,$41,$F0,$58,$8E,$29,$35,$4C
            dc.b    $7F,$30,$AD,$84,$02,$85,$5C,$AD,$85,$02,$85,$5D,$80,$D8,$A9,$FF
            dc.b    $85,$6D,$4C,$7F
            dc.b    '0dm ?3L'
            dc.w    $7F30,$A980,$1469,$F012,$A66E,$7886,$70A9,$042C
            dc.w    $41F0,$F005,$8E43,$F064,$7058,$4C7F,$30A9,$8014
            dc.w    $69A6,$6E78,$8670,$A904,$2C41,$F0F0,$058E,$43F0
            dc.w    $6470,$584C,$7F30,$A980,$0469,$D012,$A66F,$7886
            dc.w    $70A9,$042C,$41F0,$F005,$8E43,$F064,$7058,$4C7F
            dc.w    $30A9,$8004,$69A6,$6F78,$8670,$A904,$2C41,$F0F0
            dc.w    $058E,$43F0,$6470,$584C,$7F30,$3820,$C935,$4C7F
            dc.w    $30A9,$FB20,$C635,$A9FF,$856A,$A582,$F018,$AD46
            dc.w    $02D0,$1138,$A580,$ED45,$0285,$80A5,$81ED,$4402
            dc.w    $8581,$B002,$6482,$38A5,$79ED,$4502,$8579,$A57A
            dc.w    $ED44,$0285,$7A18,$A57B,$6D45,$0285,$7BA5,$7C6D
            dc.w    $4402,$C576,$9005,$E576,$1865,$7585,$7CA5,$66F0
            dc.w    $44A5,$7AC9,$0490,$08D0,$3CA5,$79C9,$00B0,$36A5
            dc.w    $65F0,$16A9,$4014,$69F0,$10A5,$5609,$8085,$56A2
            dc.w    $0578,$8E41,$F08D,$41F0,$58A5,$64F0,$18A9,$8014
            dc.w    $69F0,$12A6,$6E78,$8670,$A904,$2C41,$F0F0,$058E
            dc.w    $43F0,$6470,$5820,$9733,$4C84,$2EA9,$F720,$C635
            dc.w    $AD65,$0285,$85AD,$6402,$8586,$6483,$A574,$8584
            dc.w    $A9FF,$856B,$203F,$334C,$842E,$0878,$A000,$A904
            dc.w    $2C41,$F0D0,$0228,$60A5,$70F0,$0864,$708D,$43F0
            dc.w    $C828,$60A5,$6BF0,$FAA5,$62F0,$04A5,$6DD0,$06A5
            dc.w    $63F0,$02A5,$6CD0,$EAC8,$B283,$8D43,$F0E6,$83D0
            dc.w    $02E6,$84A5,$85D0,$02C6,$86C6,$85D0,$02A5,$86D0
            dc.w    $D064,$6B9C,$6002,$28A9,$038D,$0302,$A904,$0C35
            dc.w    $F060,$A56A,$F049,$A582,$D006,$A579,$057A,$F03F
            dc.w    $A582,$8D40,$02A5,$758D,$4602,$9C47,$02A5,$768D
            dc.w    $4802,$9C49,$02A5,$7B8D,$4B02,$A57C,$8D4A,$02A5
            dc.w    $7A8D,$4C02,$A579,$8D4D,$02A5,$808D,$4F02,$A581
            dc.w    $8D4E,$02A9,$038D,$0202,$A904,$0C35,$F064,$6A60
            dc.w    $60A2,$05A9,$0820,$C335,$60A2,$05A9,$0420,$C335
            dc.w    $609C,$8002,$AD81,$02F0,$143A,$F01D,$3AF0,$0ECE
            dc.w    $8002,$A903,$8D04,$02A9,$040C,$35F0,$60A5,$55F0
            dc.w    $EEA2,$05A9,$0220,$C335,$60A5,$55D0,$E2A2,$05A9
            dc.w    $0120,$C335,$6020,$3F33,$A904,$2C41,$F0F0,$0898
            dc.w    $D0F3,$A928,$8D41,$F0A9,$088D,$34F0,$60A9,$018D
            dc.w    $41F0,$AD41,$F029,$70F0,$0785,$5FA9,$011C,$20F0
            dc.w    $A930,$8D41,$F0A9,$088D,$34F0,$60AD,$41F0,$29A0
            dc.w    $AA45,$5886,$58AA,$2472,$F017,$AC03,$03D0,$128E
            dc.w    $6503,$A558,$8D64,$03A9,$018D,$0303,$A908,$0C35
            dc.w    $F08A,$8920,$F01F,$646C,$A558,$2920,$F002,$C66C
            dc.w    $A562,$F004,$A56D,$D006,$A563,$F002,$A56C,$D005
            dc.w    $DA20,$3F33,$FA8A,$1000,$A910,$8D41,$F0A9,$088D
            dc.w    $34F0,$6085,$5729,$0C4A,$4AA8,$B92F,$3585,$5BA5
            dc.b    'WJJJJ)'
            dc.w    $0F09,$408D,$0D35,$A557,$0A0A,$0A0A,$29C0,$8D11
            dc.w    $3509,$018D,$1F35,$4A24,$5610,$0209,$8009,$028D
            dc.w    $1335,$0908,$8D21,$3585,$56A0,$0078,$B90C,$3530
            dc.w    $0D8D,$41F0,$B90B,$358D,$41F0,$C8C8,$80EE,$5860
            dc.w    $0209,$0004,$0002,$0003,$0005,$000A,$500B,$000C
            dc.w    $000D,$010E,$0003,$0005,$A00F,$1000,$1000,$FF01
            dc.b    $0A,$09,$FF,$FF,$1F,$7F,$3F,$FF,$91,$30,$7C,$30,$A6
            dc.b    '0<1@1q1'
            dc.w    $AB30,$8531,$9F31,$A731,$C031,$D931,$FC31,$0832
            dc.b    $0F,$32,$17
            dc.b    '222K2f2'
            dc.b    $7F,$32,$84,$2E,$60,$30,$60,$30,$86,$32,$86,$32,$86,$32,$86
            dc.b    '2 3 3 3 3 3 3 3 3'
            dc.w    $020C
            dc.b    'SerialDriver&Version 1.0 '
            dc.b    $A9,$20
            dc.b    'Apple Computer Inc. 1988l'
            dc.w    0,$6C02,$006C,$0400,$6C06,$006C,$0800,$6C0A
            dc.w    $006C,$0C00,$6C0E,$006C,$1000,$6C12,$006C,$1400
            dc.b    $6C,$16,$00,$6C,$18
            ds.b    915
            ds.b    12
RsrcEntryiopc_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'iopc' 0 (3108 bytes) - Combo mask
            dc.l    RsrcEntrySERD_60-BaseOfROM      ; Next entry
            dc.l    Rsrciopc_0-BaseOfROM            ; Data
            dc.b    'iopc'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00000C30,$0000018C   ; Block header
Rsrciopc_0:
            dc.w    $FF04,$00A9,$0080,$FC48,$5ADA,$20B5,$04FA,$7A68
            dc.w    $4078,$9C35,$F0A9,$018D,$30F0,$A923,$8D31,$F0A9
            dc.w    $108D,$33F0,$AD41,$F0A2,$0074,$00CA,$D0FB,$9C20
            dc.w    $F09C,$28F0,$9C32,$F09C,$35F0,$A228,$BD75,$0B95
            dc.w    $00CA,$10F8,$A905,$8535,$A90A,$8536,$A92D,$8531
            dc.w    $A954,$8530,$A956,$8533,$A9A9,$8532,$A92D,$852D
            dc.w    $A958,$852C,$A956,$852F,$A9AD,$852E,$A9FF,$852B
            dc.w    $20A5,$0AA0,$0BA2,$D4A9,$0220,$C10B,$A005,$A91E
            dc.w    $A20A,$3820,$A30B,$A004,$A9BF,$A202,$3820,$A30B
            dc.w    $A00A,$A955,$A208,$3820,$A30B,$A005,$A976,$A202
            dc.w    $3820,$9D0B,$A907,$8D00,$028D,$0003,$A2FF,$8E34
            dc.w    $F08E,$1F03,$9A4C,$7D05,$AE34,$F0BD,$0A0B,$AA7C
            dc.w    $FE0A,$A902,$8D40,$F0AE,$40F0,$7C49,$0B00,$00BA
            dc.w    $BD06,$0189,$10D0,$0160,$BAE8,$F0FC,$BD00,$0180
            dc.w    $F8A9,$80A4,$3499,$F30A,$78A4,$34BA,$8A99,$F10A
            dc.w    $58A2,$FFB9,$F00A,$A8B9,$F20A,$39F3,$0A8E,$1F03
            dc.w    $F0F1,$FF04,$FF78,$8434,$BEF1,$0A9A,$5860,$0878
            dc.w    $1DF2,$0A9D,$F20A,$2860,$0878,$A634,$3DF2,$0A9D
            dc.w    $F20A,$2860,$A910,$8D34,$F01C,$33F0,$58A5,$2BD0
            dc.w    $1EAC,$0003,$A903,$D900,$03D0,$0F5A,$BEC4,$0B20
            dc.w    $7005,$7AA9,$0099,$0003,$A903,$88D0,$E980,$04A0
            dc.w    $0180,$03AC,$0002,$A901,$D900,$02D0,$0FA9,$0299
            dc.w    $0002,$5ABE,$C40B,$2073,$057A,$A901,$88D0,$E978
            dc.w    $A910,$0C33,$F060,$7C57,$0B7C,$650B,$A200,$A901
            dc.w    $4CB2,$0BA9,$0120,$AF0B,$0AAA,$7C85,$0589,$05A9
            dc.w    $FE20,$B50B,$A001,$BECC,$0BA5,$2BD0,$12BD,$0002
            dc.w    $F024,$C907,$B020,$9E00,$020A,$DAAA,$7CD6,$05BD
            dc.w    $0002,$C904,$F0E7,$C906,$F0E3,$9E02,$02A5,$2B9D
            dc.w    $0102,$A9FC,$8008,$9E02,$029E,$0102,$A9FE,$9D00
            dc.w    $02A9,$0399,$0002,$A904,$0C35,$F04C,$7D05,$E405
            dc.w    $3906,$6C06,$BC06,$9907,$C907,$FA5A,$BC01,$02C0
            dc.w    $02B0,$33C0,$0090,$2F9E,$0102,$B929,$00D0,$1ABD
            dc.w    $0202,$9929,$FF05,$FF9E,$0202,$980A,$A8B9,$3000
            dc.w    $9D03,$02B9,$3100,$9D02,$0280,$189E,$0202,$9D01
            dc.w    $02A9,$FD9D,$0002,$800B,$9E02,$029E,$0102,$A9FF
            dc.w    $9D00,$027A,$A903,$9900,$02A9,$040C,$35F0,$4C7D
            dc.w    $05FA,$5ABC,$0102,$C002,$B014,$C000,$9010,$9E01
            dc.w    $02A9,$0099,$2900,$980A,$AA20,$6906,$8005,$A9FF
            dc.w    $9D00,$027A,$A903,$9900,$02A9,$040C,$35F0,$4C7D
            dc.w    $057C,$2C00,$FA5A,$BC01,$02C0,$02B0,$34C0,$0090
            dc.w    $309E,$0102,$B929,$00F0,$21DA,$B935,$0048,$980A
            dc.w    $AAB5,$30B4,$31FA,$3820,$A90B,$A902,$20AF,$0BA9
            dc.w    $FD20,$B50B,$FA9E,$0002,$800C,$A9FB,$9D00,$0280
            dc.w    $05A9,$FF9D,$0002,$7AA9,$0399,$0002,$A904,$0C35
            dc.w    $F04C,$7D05,$FA5A,$BC01,$02F0,$239E,$0102,$A529
            dc.w    $D053,$A52A,$D04F,$A52B,$D03C,$0878,$DA20,$4107
            dc.w    $FA28,$A901,$0C30,$F0BD,$0202,$852B,$8046,$9E01
            dc.w    $02BD,$0202,$9E02,$02C5,$2BD0,$0F08,$78A9,$011C
            dc.w    $30F0,$203A,$0728,$FF06,$FE64,$2B80,$2AA5,$2B9D
            dc.w    $0102,$A9FA,$9D00,$0280,$1EA5,$2B9D,$0102,$9E02
            dc.w    $02A9,$FC9D,$0002,$800F,$A529,$9D01,$02A5,$2A9D
            dc.w    $0202,$A9FD,$9D00,$027A,$A903,$9900,$02A9,$040C
            dc.w    $35F0,$4C7D,$05A9,$080C,$33F0,$8005,$A908,$1C33
            dc.w    $F0AD,$41F0,$A909,$8D41,$F0A9,$408D,$41F0,$A200
            dc.w    $BD8A,$07A8,$C8F0,$0D8D,$40F0,$E8BD,$8A07,$8D40
            dc.w    $F0E8,$80EC,$A909,$8D41,$F0A9,$808D,$41F0,$A200
            dc.w    $BD8A,$07A8,$C8F0,$0D8D,$41F0,$E8BD,$8A07,$8D41
            dc.w    $F0E8,$80EC,$6004,$4C02,$0003,$C00F,0,$1000
            dc.w    $1001,$00FF,$FA5A,$BD01,$02C9,$0090,$20C9,$03B0
            dc.w    $1C0A,$A8B9,$3900,$9D01,$02B9,$3A00,$9D02,$027A
            dc.w    $A903,$9900,$02A9,$040C,$35F0,$4C7D,$05A9,$FF9D
            dc.w    $0002,$80EB,$FA5A,$A52B,$F03A,$9E00,$02BD,$0102
            dc.w    $C900,$D016,$BD02,$02D0,$0AAD,$30F0,$29E7,$8D30
            dc.w    $F080,$26A9,$180C,$30F0,$801F,$C901,$D016,$BD02
            dc.w    $02D0,$0AAD,$30F0,$299F,$FF07,$FD8D,$30F0,$800C
            dc.w    $A960,$0C30,$F080,$05A9,$FF9D,$0002,$7AA9,$0399
            dc.w    $0002,$A904,$0C35,$F04C,$7D05,$B004,$A008,$A92E
            dc.w    $0878,$9D65,$0BE8,$989D,$650B,$2860,$60B0,$04A0
            dc.w    $08A9,$4008,$789D,$570B,$989D,$580B,$2860,$6090
            dc.w    $3B08,$78E0,$05F0,$0A8D,$5301,$8C54,$01A9,$5280
            dc.w    $088D,$A801,$8CA9,$01A9,$A79D,$F10A,$A000,$B9F0
            dc.w    $0A9D,$F00A,$A88A,$99EF,$0AA0,$0099,$F00A,$989D
            dc.w    $EF0A,$A980,$9DF2,$0A9D,$F30A,$2860,$0878,$BDEF
            dc.w    $0AA8,$BDF0,$0AAA,$99F0,$0A98,$9DEF,$0A28,$60B0
            dc.w    $04A0,$04A9,$CC08,$789D,$FE0A,$989D,$FF0A,$2860
            dc.w    $B004,$A004,$A9CC,$0878,$9D49,$0B98,$9D4A,$0B28
            dc.w    $6090,$0E08,$78A9,$098D,$41F0,$A98A,$8D41,$F028
            dc.w    $6008,$78A9,$098D,$41F0,$A94A,$8D41,$F028,$60DA
            dc.w    $0AAA,$6895,$3A94,$3960,$0878,$B028,$8537,$8638
            dc.w    $A000,$B137,$AAC8,$B137,$9DD5,$0AC8,$B137,$9DD4
            dc.w    $0AC8,$B137,$9DD3,$0AC8,$B137,$FF08,$FC9D,$D20A
            dc.w    $8AA8,$206F,$0928,$60B9,$D60A,$F062,$CCED,$0AD0
            dc.w    $30B9,$D00A,$100F,$8DED,$0AA9,$0099,$D40A,$A920
            dc.w    $1C33,$F028,$60AE,$ED0A,$202D,$0AAC,$ED0A,$A900
            dc.w    $99D4,$0ABE,$D00A,$8EED,$0A20,$5A09,$20E2,$0928
            dc.w    $60AD,$ED0A,$8CEE,$0AAA,$3024,$BDD0,$0ACD,$EE0A
            dc.w    $D0F5,$B9D0,$0A9D,$D00A,$3014,$AA18,$BDD3,$0A79
            dc.w    $D30A,$9DD3,$0ABD,$D20A,$79D2,$0A9D,$D20A,$2860
            dc.w    $A9FF,$99D6,$0AAE,$ED0A,$1011,$8CED,$0AA9,$FF99
            dc.w    $D00A,$A920,$0C33,$F098,$AA80,$5820,$2D0A,$AEED
            dc.w    $0A8E,$EE0A,$BDD0,$0AAA,$303B,$38B9,$D30A,$FDD3
            dc.w    $0A99,$D30A,$B9D2,$0AFD,$D20A,$99D2,$0A10,$E218
            dc.w    $B9D3,$0A7D,$D30A,$99D3,$0AB9,$D20A,$7DD2,$0A99
            dc.w    $D20A,$38BD,$D30A,$F9D3,$0A9D,$D30A,$BDD2,$0AF9
            dc.w    $D20A,$9DD2,$0A8A,$99D0,$0AAE,$EE0A,$989D,$D00A
            dc.w    $AEED,$0ABD,$D20A,$D011,$BDD3,$0A30,$309E,$D30A
            dc.w    $8D11,$F0A9,$FF8D,$13F0,$6030,$19A9,$D509,$FB7F
            dc.w    $8D11,$F0A9,$FF8D,$13F0,$38BD,$D30A,$E97F,$9DD3
            dc.w    $0AB0,$03DE,$D20A,$609C,$11F0,$A9FF,$8D13,$F060
            dc.w    $38E9,$7F9D,$D30A,$A97F,$8D11,$F0A9,$FF8D,$13F0
            dc.w    $60AD,$10F0,$C910,$90F9,$AD11,$F018,$100F,$7DD3
            dc.w    $0A9D,$D30A,$B003,$DED2,$0ABD,$D20A,$607D,$D30A
            dc.w    $9DD3,$0A90,$F4FE,$D20A,$60AE,$ED0A,$302A,$202D
            dc.w    $0A10,$83DA,$9ED6,$0ABD,$D00A,$8DED,$0A30,$06AA
            dc.w    $20E2,$0980,$05A9,$201C,$33F0,$FABD,$D50A,$8537
            dc.w    $BDD4,$0A85,$386C,$3700,0,$0878,$B00D,$ACEC
            dc.w    $0A30,$06B9,$D00A,$8DEC,$0A28,$60AD,$EC0A,$99D0
            dc.w    $0A8C,$EC0A,$B9D1,$0A28,$60A9,$008D,$EC0A,$18AA
            dc.w    $6907,$9DD0,$0A9E,$D60A,$C915,$90F3,$A9FF,$8DE5
            dc.w    $0A8D,$ED0A,$A920,$1C33,$F0A9,$011C,$32F0,$A980
            dc.w    $8D12,$F060,$9E0A,$F1FF,$8000,0,$A980,0
            dc.w    $0054,$8000,$CC04,$CC04,$CC04,$CC04,$CC04,$CC04
            dc.w    0,$0600,$0400,$0400,$0200,$0200,$0200,$0200
            dc.w    $0A00,$0600,$0400,$0400,$0200,$0200,$0200,$0200
            dc.w    $0800,$0600,$0400,$0400,$0200,$0200,$0200,$0200
            dc.w    $0800,$0600,$0400,$0400,$0200,$0200,$0200,$02CA
            dc.w    $04CA,$04CA,$04CA,$04CA,$04CA,$04CA,$04CA,$0440
            dc.w    $0840,$0840,$0840,$0840,$0840,$0840,$082E,$082E
            dc.w    $082E,$082E,$082E,$082E,$082E,$081C,$082F,$0891
            dc.w    $08A2,$0841,$08DE,$04E0,$0408,$0512,$05B3,$0886
            dc.w    $0ADA,$08D1,$08FF,$0B9D,$6C00,$006C,$0200,$6C04
            dc.w    $006C,$0600,$6C08,$006C,$0A00,$6C0C,$006C,$0E00
            dc.w    $6C10,$006C,$1200,$6C14,$006C,$1600,$6C18,0
            dc.w    $0204,$0608,$0A0C,$0E00,$2040,$6080,$A0C0,$E002
            dc.b    34,'Enhanced Communications Controller'
            dc.b    '(Version 1.0A0 '
            dc.w    $A920
            dc.b    'Apple Computer Inc. 1988'
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FFFF,$0C9D,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FFFF,$0D9D
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FFFF
            dc.w    $0E9D,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF83,$0F9D,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00,$FF00
            dc.w    $FF00,$FF00,$FF00,$FF05,$7FFB,$040E,$0404,$0400
            dc.w    $8000,0
RsrcEntryapad_1:
            dc.b    $38,$00,$00,$00,$00,$00,$00,$00 ; Resource 'apad' 1 "Main" (43700 bytes) - Combo mask
            dc.l    RsrcEntryiopc_0-BaseOfROM       ; Next entry
            dc.l    Rsrcapad_1-BaseOfROM            ; Data
            dc.b    'apad'                          ; Type
            dc.w    1                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    4,'Main'                        ; Name
            ds.b    8
            dc.l    $C0A00000,$0000AAC0,$00000184   ; Block header
Rsrcapad_1:
            ds.b    43696
RsrcEntrySERD_0:
            dc.b    $78,$00,$00,$00,$00,$00,$00,$00 ; Resource 'SERD' 0 (6180 bytes) - Combo mask
            dc.l    RsrcEntryapad_1-BaseOfROM       ; Next entry
            dc.l    RsrcSERD_0-BaseOfROM            ; Data
            dc.b    'SERD'                          ; Type
            dc.w    0                               ; ID
            dc.b    $58                             ; Attributes
            dc.b    0                               ; Name
            ds.b    12
            dc.l    $C0A00000,$00001830,$0000017C   ; Block header
RsrcSERD_0:
            dc.w    $600A,0,$5345,$5244,0,$0006,$487A,$0074
            dc.w    $487A,$0058,$487A,$003C,$487A,$0020,$76FA,$3003
            dc.w    $A53D,$A029,$2050,$225F,$20C9,$30D1,$30BC,$0006
            dc.b    $53,$43,$0C,$43,$FF,$F7,$6C,$E6,$4E,$75,$4D
            ds.b    8
            dc.b    $60,$06,$DE,$04,$38,$03,$E2,$03,$B8,$04
            dc.b    '.AIn N'
            ds.b    7
            dc.b    $01,$10,$06,$0A,$04,$20,$03,$CA,$03,$2C,$05
            dc.b    '.AOutM'
            ds.b    8
            dc.b    $36,$06,$B4,$04,$0E,$03,$B8,$03,$88,$04
            dc.b    '.BIn N'
            ds.b    7
            dc.b    $01,$10,$05,$E0,$03,$F6,$03,$A0,$03,$10,$05
            dc.b    '.BOutN'
            dc.b    $FA,$09,$2E,$60,$04,$4E,$FA,$09,$36,$13,$7C,$00,$06,$00,$07,$70
            dc.b    $00,$4E,$75,$72,$04,$74,$08,$60,$3C,$48,$7A,$00,$08,$2F,$38,$06
            dc.b    $F8,$4E,$75,$20,$78,$0B,$18,$20,$08,$6F,$26,$30,$3C,$00,$13,$4E
            dc.b    $A8,$00,$02,$4A,$40,$66,$1A,$0C,$01,$00,$02,$67,$12,$30,$3C,$00
            dc.b    $11,$12,$3C,$00,$02,$61,$FF,$00,$00,$13,$D8,$67,$02,$58,$4F,$4E
            dc.b    $75,$72,$00,$74,$00,$48,$7A,$00,$08,$2F,$38,$06,$F8,$4E,$75,$10
            dc.b    $38,$01,$FB,$E2,$28,$02,$00,$00,$0F,$67,$0A,$55,$00,$67,$06,$70
            dc.b    $9E,$58,$4F,$4E,$75,$30,$38,$02,$90,$E4,$78,$08,$80,$00,$07,$66
            dc.b    $0A,$0A,$00,$00,$02,$67,$0E,$70,$9F,$60,$E6,$61,$FF,$00,$00,$13
            dc.b    $7E,$31,$C0,$02,$90,$4E,$75,$4A,$43,$66,$1C,$20,$38,$0B,$18,$6F
            dc.b    $16,$2F,$08,$20,$40,$30,$3C,$00,$12,$12,$3C,$00,$02,$4E,$A8,$00
            dc.b    $02,$20,$5F,$4A,$40,$67,$0E,$30,$38,$02,$90,$E6,$78,$50,$C0,$E6
            dc.b    $78,$31,$C0,$02,$90,$4E,$75,$4E,$FA,$08,$4A,$45,$F8,$02,$D0,$48
            dc.b    $7A,$06,$76,$48,$7A,$07,$66,$48,$7A,$06,$AC,$48,$7A,$05,$6E,$48
            dc.b    $78,$01,$C2,$48,$7A,$07,$BA,$48,$78,$02,$C6,$61,$FF,$00,$00,$13
            dc.b    $4A,$38,$38,$01,$FC,$60,$30,$4E,$FA,$08,$28,$24,$78,$02,$B6,$45
            dc.b    $EA,$00,$58,$42,$A7,$48,$7A,$07,$2A,$48,$7A,$06,$70,$48,$7A,$05
            dc.b    $32,$48,$78,$01,$B2,$48,$7A,$07,$7E,$48,$78,$02,$BE,$61,$FF,$00
            dc.b    $00,$13,$2E,$38,$38,$01,$FE,$70,$4E,$D0,$80,$A4,$40,$70,$4E,$D0
            dc.b    $80,$A7,$22,$67,$06,$4F,$EF,$00,$20,$4E,$75,$23,$48,$00,$14,$13
            dc.b    $7C,$00,$06,$00,$07,$24,$90,$24,$50,$A0,$29,$47,$EA,$00,$7C,$61
            dc.b    $FF,$00,$00,$13,$12,$20,$5F,$26,$D0,$20,$DF,$58,$48,$26,$D0,$20
            dc.b    $DF,$26,$D0,$20,$DF,$20,$1F,$67,$04,$21,$C0,$01,$3E,$26,$4A,$26
            dc.b    $C9,$36,$C1,$61,$00,$03,$1A,$50,$EA,$00,$14,$50,$EA,$00,$11,$15
            dc.b    $43,$00,$20,$15,$42,$00,$29,$00,$2A,$00,$80,$00,$1E,$60,$04,$1F
            dc.b    $7F,$3F,$FF,$48,$7A,$00,$08,$2F,$38,$06,$F8,$4E,$75,$30,$3C,$C0
            dc.b    $00,$C0,$44,$66,$04,$38,$3C,$CC,$0A,$30,$3C,$0C,$00,$C0,$44,$ED
            dc.b    $58,$15,$7B,$00,$DC,$00,$77,$47,$EA,$00,$21,$49,$FA,$00,$74,$70
            dc.b    $07,$12,$1C,$36,$04,$E3,$7B,$C6,$1C,$86,$1C,$16,$C3,$51,$C8,$FF
            dc.b    $F2,$72,$64,$C2,$1B,$15,$41,$00,$22,$36,$84,$10,$2A,$00,$1E,$02
            dc.b    $00,$00,$80,$81,$2A,$00,$24,$81,$2A,$00,$28,$10,$2A,$00,$28,$15
            dc.b    $40,$00,$1E,$08,$80,$00,$07,$15,$40,$00,$1F,$10,$2A,$00,$26,$E1
            dc.b    $48,$10,$2A,$00,$25,$54,$40,$32,$3C,$90,$00,$C0,$C1,$80,$FC,$8F
            dc.b    $63,$48,$40,$32,$00,$48,$40,$0C,$41,$47,$B1,$6F,$02,$52,$40,$55
            dc.b    $40,$15,$40,$00,$25,$E0,$48,$15,$40,$00,$26,$61,$50,$70,$00,$4E
            dc.b    $75,$04,$0F,$40,$00,$00,$00,$0C,$C0,$00,$0B,$60,$02,$00,$FF,$00
            dc.b    $08,$03,$00,$0C,$C0,$01,$0B,$60,$0A,$02,$09,$04,$FF,$01,$FF,$03
            dc.b    $FF,$05,$FF,$00,$02,$00,$0A,$50,$0B,$0C,$FF,$0D,$FF,$03,$FF,$05
            dc.b    $FF,$01,$0E,$A0,$0F,$10,$00,$10,$00,$01,$FF,$0A,$09,$4C,$F8,$03
            dc.b    $00,$01,$D8,$D0,$EA,$00,$04,$D2,$EA,$00,$04,$4E,$75,$47,$FA,$FF
            dc.b    $CA,$72,$24,$48,$7A,$00,$08,$2F,$38,$06,$F8,$4E,$75,$40,$E7,$48
            dc.b    $E7,$00,$E0,$61,$D8,$00,$7C,$07,$00,$14,$10,$45,$EA,$00,$21,$30
            dc.b    $1B,$4A,$00,$6A,$04,$10,$1A,$E0,$58,$12,$80,$E0,$58,$12,$80,$55
            dc.b    $41,$6E,$EC,$14,$10,$4C,$DF,$07,$00,$B5,$F8,$02,$D0,$67,$06,$11
            dc.b    $C2,$02,$CF,$60,$04,$11,$C2,$02,$CE,$E5,$0A,$5B,$EA,$00,$1C,$46
            dc.b    $DF,$4E,$75,$02,$09,$04,$FF,$01,$FF,$03,$FF,$05,$FF,$08,$0F,$01
            dc.b    $01,$0A,$09,$42,$B8,$01,$3E,$49,$F8,$01,$C2,$4B,$F8,$02,$C6,$4D
            dc.b    $F8,$02,$D0,$76,$08,$60,$12,$49,$F8,$01,$B2,$4B,$F8,$02,$BE,$2C
            dc.b    $78,$02,$B6,$4D,$EE,$00,$58,$76,$00,$48,$7A,$00,$08,$2F,$38,$06
            dc.b    $F8,$4E,$75,$24,$56,$4A,$2A,$00,$7B,$6B,$0C,$08,$AA,$00,$07,$00
            dc.b    $28,$08,$AA,$00,$07,$00,$24,$08,$AA,$00,$03,$00,$28,$61,$2C,$47
            dc.b    $FA,$FF,$A2,$72,$10,$61,$00,$FF,$4C,$47,$EA,$00,$7C,$2A,$9B,$28
            dc.b    $DB,$58,$8C,$28,$DB,$28,$93,$61,$FF,$00,$00,$11,$40,$61,$00,$FD
            dc.b    $48,$61,$FF,$00,$00,$11,$52,$70,$00,$4E,$75,$48,$E7,$C0,$C0,$61
            dc.b    $00,$FF,$0C,$72,$FF,$40,$E7,$00,$7C,$07,$00,$10,$10,$12,$BC,$00
            dc.b    $01,$10,$10,$46,$DF,$E2,$08,$55,$C9,$FF,$EC,$4C,$DF,$03,$03,$4E
            dc.b    $75,$24,$78,$02,$D0,$60,$08,$24,$78,$02,$B6,$24,$6A,$00,$58,$48
            dc.b    $7A,$00,$08,$2F,$38,$06,$F8,$4E,$75,$3F,$28,$00,$06,$2F,$09,$40
            dc.b    $E7,$00,$7C,$07,$00,$41,$E8,$00,$1A,$70,$EE,$22,$0A,$6F,$00,$00
            dc.b    $8A,$32,$18,$55,$41,$66,$0E,$61,$00,$03,$34,$61,$00,$03,$40,$42
            dc.b    $58,$30,$80
            dc.b    '`r]Afp0'
            dc.b    $EA,$00,$18,$42,$2A,$00,$18,$20,$EA,$00,$1A,$60,$60,$24,$78,$02
            dc.b    $D0,$60,$08,$24,$78,$02,$B6,$24,$6A,$00,$58,$48,$7A,$00,$08,$2F
            dc.b    $38,$06,$F8,$4E,$75,$3F,$28,$00,$06,$2F,$09,$40,$E7,$00,$7C,$07
            dc.b    $00,$41,$E8,$00,$1A,$32,$18,$53,$41,$66,$12,$24,$0A,$6F,$08,$42
            dc.b    $6A,$00,$1A,$42,$AA,$00,$2C,$46,$DF,$5C,$4F,$4E,$75,$24,$0A,$6F
            dc.b    $32,$43,$FA,$00,$34,$5F,$41,$6B,$2A,$0C,$41,$00,$13,$62,$24,$D2
            dc.b    $41,$32,$31,$10,$00,$10,$2A,$00,$1E,$4E,$B1,$10,$00,$70,$00,$46
            dc.b    $DF,$22,$5F,$08,$1F,$00,$09,$67,$02,$4E,$75,$2F,$38,$08,$FC,$4E
            dc.b    $75,$58,$4F,$70,$EF,$60,$E8,$00,$28,$00,$34,$00,$5A,$00,$B4,$00
            dc.b    $BA,$00,$DA,$00,$54,$FF,$FA,$00,$94,$00,$A8,$00,$9A,$01,$60,$01
            dc.b    $5A,$01,$26,$02,$1C,$02,$CE,$01,$2C,$03,$CE,$01,$40,$01,$50,$38
            dc.b    $18,$B8,$6A,$00,$2A,$67,$22,$60,$00,$FD,$10,$42,$AA,$00,$2C,$28
            dc.b    $58,$32,$10,$66,$06,$49,$EA,$00,$30,$72,$40,$47,$EA,$00,$06,$26
            dc.b    $CC,$36,$C1,$E4,$49,$36,$C1,$36,$C1,$4E,$75,$1F,$28,$00,$07,$60
            dc.b    $04,$1F,$2A,$00,$17,$4A,$2A,$00,$10,$66,$04,$42,$2A,$00,$1D,$25
            dc.b    $58,$00,$10,$35,$58,$00,$14,$10,$18,$15,$40,$00,$16,$15,$40,$00
            dc.b    $7A,$66,$04,$61,$00,$02,$50,$61,$00,$01,$9E,$10,$1F,$B0,$2A,$00
            dc.b    $17,$67,$06,$15,$40,$00,$17,$67,$16,$4E,$75,$15,$50,$00,$7B,$4E
            dc.b    $75,$08,$AA,$00,$07,$00,$1E,$08,$EA,$00,$06,$00,$19,$60,$0C,$08
            dc.b    $EA,$00,$07,$00,$1E,$08,$AA,$00,$06,$00,$19,$10,$2A,$00,$1E,$60
            dc.b    $14,$46,$EF,$00,$04,$61,$00,$FE,$4A,$00,$7C,$07,$00,$10,$2A,$00
            dc.b    $1E,$08,$C0,$00,$04,$72,$05,$61,$00,$00,$EC,$16,$81,$16,$80,$4E
            dc.b    $75,$24,$3C,$00,$01,$C2,$00,$26,$02,$70,$00,$30,$10,$22,$00,$E2
            dc.b    $49,$D4,$81,$84,$C0,$32,$02,$55,$42,$86,$C1,$30,$83,$30,$3C,$03
            dc.b    $FF,$B4,$40,$63,$06,$42,$6A,$00,$2A,$60,$12,$C0,$6A,$00,$2A,$B4
            dc.b    $40,$67,$18,$02,$6A,$FC,$00,$00,$2A,$85,$6A,$00,$2A,$15,$42,$00
            dc.b    $25,$E0,$4A,$15,$42,$00,$26,$61,$00,$FD,$0A,$4E,$75,$50,$EA,$00
            dc.b    $1D,$4E,$75,$08,$AA,$00,$07,$00,$19,$15,$6A,$00,$7A,$00,$16,$10
            dc.b    $2A,$00,$12,$60,$00,$01,$A8,$08,$EA,$00,$07,$00,$19,$42,$2A,$00
            dc.b    $16,$10,$2A,$00,$13,$60,$EC,$10,$2A,$00,$20,$72,$09,$60,$00,$FF
            dc.b    $78,$35,$50,$00,$78,$4E,$75,$15,$50,$00,$78,$15,$50,$00,$79,$08
            dc.b    $AA,$00,$07,$00,$79,$4E,$75,$24,$78,$02,$D0,$60,$08,$24,$78,$02
            dc.b    $B6,$24,$6A,$00,$58,$40,$E7,$00,$7C,$07,$00,$50,$EA,$00,$1B
            dc.b    'aFf a0g'
            dc.b    $1C,$10,$2A,$00,$76,$42,$2A,$00,$76,$02,$40,$00,$FF,$66,$06,$20
            dc.b    $78,$08,$F4,$4E,$90,$17,$40,$00,$04,$4A,$40,$6B,$06,$70,$00,$46
            dc.b    $DF,$4E,$75,$42,$2A,$00,$1B,$46,$DF,$70,$00,$60,$00,$FE,$38,$26
            dc.b    $78,$01,$D8,$D6,$EA,$00,$04,$4A,$13,$3E,$97,$08,$13,$00,$02,$4E
            dc.b    $75,$4A,$2A,$00,$10,$67,$06,$4A,$2A,$00,$1D,$66,$0C,$4A,$2A,$00
            dc.b    $11,$67,$0A,$4A,$2A,$00,$1C,$67,$04,$70,$01,$4E,$75,$70,$00,$4E
            dc.b    $75,$24,$78,$02,$B6,$24,$6A,$00,$58,$60,$04,$24,$78,$02,$D0,$4A
            dc.b    $2A,$00,$76,$66,$0A,$4A,$2A,$00,$1B,$67,$0C,$61,$C4,$66,$08,$22
            dc.b    $52,$40,$E7,$60,$00,$FF,$78,$12,$BC,$00,$28,$4E,$75,$42,$2A,$00
            dc.b    $1D,$61,$AE,$66,$06,$4A,$2A,$00,$1B,$66,$E4,$4E,$75,$24,$78,$02
            dc.b    $D0,$60,$08,$24,$78,$02,$B6,$24,$6A,$00,$58,$70,$ED,$22,$0A,$6F
            dc.b    $00,$FD,$B4,$25,$49,$00,$8C,$61,$54,$40,$E7,$00,$7C,$07,$00,$B4
            dc.b    $6A,$00,$2C,$67,$1E,$10,$33,$20,$00,$52,$42,$B4,$43,$66,$02,$74
            dc.b    $00,$35,$42,$00,$2E,$61,$30,$46,$DF,$4A,$40,$6A,$DC,$61,$0A,$60
            dc.b    $00,$FF,$48,$50,$EA,$00,$1A,$60,$06,$40,$E7,$00,$7C,$07,$00,$4A
            dc.b    $6A,$00,$16,$67,$0C,$61,$16,$61,$24,$B0,$6A,$00,$0C,$62,$02,$61
            dc.b    $26,$70,$00,$46,$DF,$4E,$75,$2F,$38,$08,$F8,$4E,$75,$26,$6A,$00
            dc.b    $06,$36,$2A,$00,$0A,$4C,$AA,$00,$06,$00,$2C,$4E,$75,$30,$01,$90
            dc.b    $42,$64,$02,$D0,$43,$4E,$75,$4A,$2A,$00,$17,$67,$0C,$08,$AA,$00
            dc.b    $06,$00,$19,$67,$04,$61,$00,$FD,$E2,$4A,$2A,$00,$16,$67,$CC,$08
            dc.b    $AA,$00,$07,$00,$19,$67,$C4,$10,$2A,$00,$12,$4A,$2A,$00,$76,$67
            dc.b    $06,$42,$2A,$00,$76,$4E,$75,$15,$40,$00,$76,$61,$00,$FE,$D2,$67
            dc.b    $F4,$17,$40,$00,$04,$60,$EA,$28,$78,$01,$3A,$21,$DF,$01
            dc.b    '(NqNqa'
            dc.b    $00,$0C,$26,$B9,$CF,$67,$16,$55,$4C,$10,$14,$47,$F8,$02,$D0,$4C
            dc.b    $F8,$03,$00,$01,$D8,$54,$48,$54,$49,$61,$1E,$60,$E2,$2E,$78,$01
            dc.b    $3A,$2F,$38,$01,$28,$4E,$75,$26,$78,$02,$B6,$47,$EB,$00,$58,$60
            dc.b    $04,$47,$F8,$02,$D0,$10,$28,$00,$04,$24,$5B,$26,$6A,$00,$8C,$C0
            dc.b    $2A,$00,$77,$12,$2A,$00,$78,$67,$08,$B0,$01,$66,$04,$10,$2A,$00
            dc.b    $79,$4A,$2A,$00,$10,$67,$14,$B0,$2A,$00,$12,$67,$00,$FE,$BC,$B0
            dc.b    $2A,$00,$13,$66,$06,$50,$EA,$00,$1D,$60,$70,$4A,$2A,$00,$1A,$67
            dc.b    $10,$22,$4B,$61,$00,$FF,$1E,$6A,$62,$42,$2A,$00,$1A,$60,$00,$FE
            dc.b    $36,$61,$00,$FF,$16,$17,$80,$10,$00,$52,$41,$B2,$43,$66,$02,$72
            dc.b    $00,$B2,$42,$66,$08,$08,$EA,$00,$00,$00,$18,$60,$3E,$35,$41,$00
            dc.b    $2C,$4A,$6A,$00,$16,$67,$34,$61,$00,$FF,$00,$96,$40,$B6,$6A,$00
            dc.b    $0E,$64,$28,$4A,$2A,$00,$17,$67,$12,$08,$EA,$00,$06,$00,$19,$66
            dc.b    $04,$61,$00,$FC,$D4,$4A,$2A,$00,$16,$67,$10,$08,$EA,$00,$07,$00
            dc.b    $19,$66,$08,$10,$2A,$00,$13,$61,$00,$FE,$FE,$4E,$75,$26,$78,$02
            dc.b    $B6,$47,$EB,$00,$58,$60,$04,$47,$F8,$02,$D0,$12,$BC,$00,$01,$24
            dc.b    $5B,$26,$6A,$00,$8C,$12,$10,$76,$70,$C2,$03,$83,$2A,$00,$18,$10
            dc.b    $28,$00,$04,$C0,$2A,$00,$77,$14,$2A,$00,$14,$C4,$01,$12,$BC,$00
            dc.b    $30,$C4,$03,$66,$1A,$16,$2A,$00,$78,$67,$10,$B6,$00,$66,$04,$10
            dc.b    $2A,$00,$79,$08,$01,$00,$04,$67,$02,$10,$03,$60,$00,$FF,$3E,$4A
            dc.b    $2A,$00,$1A,$67,$A6,$70,$A7,$22,$4B,$42,$2A,$00,$1A,$60,$00,$FB
            dc.b    $B2,$26,$78,$02,$B6,$47,$EB,$00,$58,$60,$04,$47,$F8,$02,$D0,$24
            dc.b    $5B,$24,$12,$14,$01,$C4,$2A,$00,$15,$67,$1A,$48,$E7,$80,$80,$30
            dc.b    $7C,$00,$0B,$E1,$40,$10,$01,$48,$40,$30,$2B,$00,$18,$52,$40,$A0
            dc.b    $2F,$4C,$DF,$01,$01,$4A,$01,$6B,$30,$E5,$08,$5B,$EA,$00,$1C,$0C
            dc.b    $6A,$00,$50,$00,$70,$65,$08,$70,$80,$72,$0F,$61,$00,$FC,$40,$24
            dc.b    $38,$01,$6A,$B4,$AA,$00,$72,$67,$08,$25,$42,$00,$72,$42,$6A,$00
            dc.b    $70,$52,$6A,$00,$70,$60,$00,$FD,$76,$4A,$00,$6B,$06,$10,$28,$00
            dc.b    $04,$4E,$75,$70,$A6,$4A,$2A,$00,$1A,$66,$00,$FF,$7C,$4E,$75,$61
            dc.b    $00,$F6,$FE,$45,$FA,$F6,$9E,$47,$FA,$00,$70,$60,$28,$61,$00,$F6
            dc.b    $F6,$45,$FA,$F6,$C0,$47,$FA,$00,$92,$60,$1A,$61,$00,$F6,$E2,$45
            dc.b    $FA,$F6,$6A,$47,$FA,$00,$3C,$60,$0C,$61,$00,$F6,$DA,$45,$FA,$F6
            dc.b    $8C,$47,$FA,$00,$5E,$28,$48,$08,$38,$00,$01,$0D,$D1,$67,$16,$20
            dc.b    $3C,$00,$01,$00,$89,$4A,$67,$20,$4F,$10,$1F,$08,$38,$00,$00,$0B
            dc.b    $FE,$66,$02,$24,$4B,$22,$8A,$30,$2A,$00,$08,$20,$4C,$4E,$F2,$00
            dc.b    $04,$4D
            ds.b    8
            dc.b    $60,$04,$DC,$02,$D0,$02,$18,$02,$0C,$04
            dc.b    '.AIn N'
            ds.b    8
            dc.b    $5C,$04,$24,$02,$B0,$01,$F8,$01,$74,$05
            dc.b    '.AOutM'
            ds.b    8
            dc.b    $36,$04,$B2,$02,$A6,$01,$EE,$01,$DC,$04
            dc.b    '.BIn N'
            ds.b    8
            dc.b    $5C,$03,$F4,$02,$80,$01,$C8,$01,$44,$05
            dc.b    '.BOutN'
            dc.b    $FA,$FF,$58,$60,$04,$4E,$FA,$FF,$60,$13,$7C,$00,$03,$00,$07,$70
            dc.b    $00,$4E,$75,$4E,$FA,$FF,$28,$4E,$56,$FF,$C0,$42,$6E,$FF,$F4,$3D
            dc.b    $7C,$00,$01,$FF,$F6,$3D,$7C,$00,$3C,$FF,$F8,$3D,$7C,$FF,$FA,$FF
            dc.b    $E0,$3D,$78,$01,$FC,$FF,$E4,$3D,$7C,$00,$08,$FF,$E2,$41,$F8,$02
            dc.b    $D0,$60,$32,$4E,$FA,$FF,$06,$4E,$56,$FF,$C0,$3D,$7C,$00,$01,$FF
            dc.b    $F4,$3D,$7C,$00,$04,$FF,$F6,$3D,$7C,$00,$3D,$FF,$F8,$3D,$7C,$FF
            dc.b    $F8,$FF,$E0,$3D,$78,$01,$FE,$FF,$E4,$42,$6E,$FF,$E2,$20,$78,$02
            dc.b    $B6,$41,$E8,$00,$58,$2D,$48,$FF,$E8,$2D,$49,$FF,$FC,$42,$A7
            dc.b    '/<SERD?.'
            dc.w    $FFF8,$A80C,$4267,$A9AF,$301F,$6712,$4A9F,$3F00
            dc.w    $362E,$FFE2,$6100,$F624,$301F
            dc.b    'N^Nu-_'
            dc.w    $FFF0,$123C,$0001,$6100,$048C,$661E,$203C,0
            dc.w    $01D0,$A440,$203C,0,$01D0,$A722,$6722,$123C
            dc.w    $0002,$6100,$0470,$303C,$FF94,$3F00,$2F2E,$FFF0
            dc.w    $A9A3,$362E,$FFE2,$6100,$F5E2,$301F
            dc.b    'N^Nu-H'
            dc.w    $FFEC,$2248,$2451,$A029,$156E,$FFF5,$0001,$356E
            dc.w    $FFE0,$0006,$356E,$FFE2,$0008,$256E,$FFE8,$0012
            dc.w    $6100,$0492,$226E,$FFFC,$236E,$FFEC,$0014,$137C
            dc.w    $0003,$0007,$50D2,$206A,$0012,$208A
            dc.b    'B@N^Nu/'
            dc.b    $09,$24,$69,$00,$14,$24,$52,$42,$12,$9E,$FC,$00,$1C,$20,$4F,$11
            dc.b    $7C,$00,$03,$00,$07,$42,$28,$00,$06,$11,$6A,$00,$72,$00,$08,$A0
            dc.b    $87,$4F,$EF,$00,$1C,$15,$7C,$00,$02,$01,$0F,$41,$EA,$00,$16,$A0
            dc.b    $87,$4A,$2A,$00,$21,$66,$FA,$15,$7C,$00,$02,$01,$38,$15,$6A,$00
            dc.b    $01,$01,$39,$41,$EA,$00,$86,$A0,$87,$4A,$2A,$00,$91,$66,$FA,$20
            dc.b    $2A,$00,$0A,$67,$10,$22,$40,$2F,$0A,$30,$3C,$FF,$ED,$20,$78,$08
            dc.b    $FC,$4E,$90,$24,$5F,$36,$2A,$00,$08,$61,$00,$F5,$2A,$20,$6A,$00
            dc.b    $12,$42,$90,$22,$5F,$20,$69,$00,$14,$42,$A9,$00,$14,$A0,$23,$70
            dc.b    $00,$4E,$75,$24,$69,$00,$14,$24,$52,$60,$1C,$20,$38,$02,$D0,$60
            dc.b    $08,$24,$78,$02,$B6,$20,$2A,$00,$58,$24,$40,$6E,$00,$00,$0A,$30
            dc.b    $3C,$FF,$EE,$60,$00,$00,$88,$32,$28,$00,$1A,$55,$41,$66,$1A,$30
            dc.b    $2A,$01,$76,$90,$6A,$01,$78,$64,$04,$D0,$6A,$01,$74,$42,$68,$00
            dc.b    $1C,$31,$40,$00,$1E,$60,$00,$00,$64,$5D,$41,$66,$00,$00,$60,$9E
            dc.b    $FC,$00,$13,$48,$E7,$00,$C0,$41,$EF,$00,$08,$42,$10,$42,$28,$00
            dc.b    $01,$31,$7C,$00,$07,$00,$02,$31,$6A,$01,$BE,$00,$08,$43,$E8,$00
            dc.b    $0C,$21,$49,$00,$04,$A0,$88,$4A,$19,$67,$04,$42,$11,$60,$14,$41
            dc.b    $EF,$00,$08,$10,$BC,$00,$01,$31,$7C,$00,$01,$00,$02,$50,$E8,$00
            dc.b    $0C,$A0,$88,$4C,$DF,$03,$00,$45,$E8,$00,$1C,$47,$EF,$00,$0D,$70
            dc.b    $05,$14,$DB,$51,$C8,$FF,$FC,$4F,$EF,$00,$13,$42,$40,$08,$28,$00
            dc.b    $09,$00,$06,$66,$04,$2F,$38,$08,$FC,$4E,$75,$24,$69,$00,$14
            dc.b    '$R`$ 8'
            dc.w    $02D0,$6008,$2478,$02B6,$202A,$0058,$2440,$6E00
            dc.w    $0012,$303C,$FFEF,$3228,$001A
            dc.b    'SAfDB@Nu2('
            dc.w    $001A,$5341,$6614,$42AA,$000A,$42AA,$000E,$426A
            dc.b    $01,$76,$42,$6A,$01
            dc.b    'xB@Nu0<'
            dc.w    $FFEF,$5F41,$651C,$0C41,$0013,$6216,$47FA,$0022
            dc.w    $D241,$3233,$1000,$48E7,$00C0,$4EB3,$1000,$4CDF
            dc.w    $0300,$0828,$0009,$0006,$6604,$2F38,$08FC,$4E75
            dc.w    $0054,$007C,$002A,$002A,$002A,$00A8,$002A,$002A
            dc.w    $002A,$002A,$002A,$002A,$002A,$002A,$002A,$002A
            dc.w    $002A,$002A,$002A,$002A,$4E75,$6100,$067C,$6722
            dc.w    $226B,$000C,$1368,$001B,$0002,$41E8,$001C,$43E9
            dc.w    $0004,$323C,$000B,$12D8,$51C9,$FFFC,$204B,$A087
            dc.w    $4240,$4E75,$6100,$0652,$6720,$226B,$000C,$137C
            dc.w    $0008,$0002,$3028,$001C,$6100,$03A0,$3340,$0006
            dc.w    $3341,$0004,$204B,$A087
            dc.b    'B@NuBj'
            dc.w    $0176,$426A,$0178,$3028,$0020,$670C,$3540,$0174
            dc.w    $2568,$001C,$0170,$600E,$41EA,$017A,$2548,$0170
            dc.b    $35,$7C,$00,$40,$01
            dc.b    'tB@Nua'
            dc.b    $00,$05,$FE,$67,$34,$22,$6B,$00,$0C,$24,$3C,$00,$01,$C2,$00,$26
            dc.b    $02,$70,$00,$30,$28,$00,$1C,$22,$00,$E2,$49,$D4,$81,$84,$C0,$32
            dc.b    $02,$55,$42,$33,$42,$00,$04,$86,$C1,$31,$43,$00,$1C,$13,$7C,$00
            dc.b    $0D,$00,$02,$20,$4B,$A0,$87,$42,$40,$4E,$75,$40,$E7,$00,$7C,$07
            dc.b    $00,$22,$68,$00,$18,$20,$A9,$01,$6C,$23,$48,$01,$6C,$46,$DF,$4E
            dc.b    $75,$24,$69,$00,$14,$24,$52,$42,$A8,$00,$28,$40,$E7,$00,$7C,$07
            dc.b    $00,$25,$49,$00,$0E,$4A,$EA,$00,$03,$67,$04,$46,$DF,$4E,$75,$46
            dc.b    $DF,$41,$EA,$00,$4E,$45,$E8,$FF,$B2,$4A,$12,$66,$02,$4E,$75,$40
            dc.b    $E7,$00,$7C,$07,$00,$20,$2A,$00,$0E,$66,$08,$42,$2A,$00,$03,$46
            dc.b    $DF,$4E,$75,$46,$DF,$22,$40,$20,$69,$00,$08,$20,$28,$00,$24,$90
            dc.b    $A8,$00,$28,$67,$38,$72,$00,$32,$2A,$01,$BC,$B0,$81,$63,$02,$20
            dc.b    $01,$35,$40,$01,$30,$35,$40,$01,$04,$26,$68,$00,$20,$D7,$E8,$00
            dc.b    $28,$25,$4B,$01,$06,$35,$6A,$01,$BA,$01,$0A,$D1,$A8,$00,$28,$41
            dc.b    $EA,$01,$02,$A0,$88,$41,$EA,$00,$4E,$A0,$87,$4E,$75,$22,$6A,$00
            dc.b    $0E,$42,$AA,$00,$0E,$42,$2A,$00,$03,$42,$40,$2F,$38,$08,$FC,$4E
            dc.b    $75,$20,$38,$02,$D0,$60,$08,$24,$78,$02,$B6,$20,$2A,$00,$58,$24
            dc.b    $40,$6E,$0A,$30,$3C,$FF,$ED,$2F,$38,$08,$FC,$4E,$75,$42,$A8,$00
            dc.b    $28,$25,$49,$00,$0A,$60,$00,$02,$7C,$45,$E8,$FF,$CE,$4A,$12,$66
            dc.b    $02,$4E,$75,$35,$6A,$01,$28,$01,$CA,$57,$EA,$01,$CE,$67,$44,$30
            dc.b    $2A,$01,$26,$35,$40,$01,$C2,$35,$6A,$01,$22,$01,$C6,$32,$2A,$01
            dc.b    $24,$92,$40,$30,$2A,$01,$CA,$B0,$41,$62,$0A,$35,$40,$01,$C0,$42
            dc.b    $6A,$01,$C4,$60,$0A,$35,$41,$01,$C0,$90,$41,$35,$40,$01,$C4,$4A
            dc.b    $2A,$01,$1C,$56,$EA,$01,$CF,$67,$0A,$35,$6A,$01,$2A,$01,$CC,$57
            dc.b    $EA,$01,$CE,$42,$6A,$01,$C8,$42,$2A,$01,$22,$42,$2A,$00,$02,$60
            dc.b    $00,$02,$12,$45,$E8,$FF,$96,$4A,$12,$66,$02,$4E,$75,$30,$7C,$00
            dc.b    $0B,$10,$2A,$01,$36,$E1,$40,$10,$2A,$01,$37,$48,$40,$30,$2A,$00
            dc.b    $06,$A0,$2F,$41,$EA,$00,$6A,$11,$7C,$00,$01,$00,$07,$A0,$87,$4E
            dc.b    $75,$41,$EE,$FF,$C4,$43,$EE,$FF,$C0,$12,$81,$13,$6E,$FF,$F5,$00
            dc.b    $01,$13,$7C,$00,$03,$00,$02,$42,$28,$00,$06,$42,$28,$00,$07,$11
            dc.b    $7C,$00,$01,$00,$08,$11,$7C,$00,$04,$00,$09,$11,$7C,$00,$04,$00
            dc.b    $0A,$21,$49,$00,$0C,$21,$49,$00,$10,$42,$A8,$00,$14,$A0,$87,$66
            dc.b    $1E,$41,$EE,$FF,$C4,$4A,$28,$00,$0B,$66,$FA,$30,$29,$00,$02,$52
            dc.b    $40,$3D,$40,$FF,$E6,$42,$40,$4A,$11,$67,$04,$30,$3C,$FF,$9F,$4A
            dc.b    $40,$4E,$75,$41,$EA,$01,$7A,$25,$48,$01,$70,$35,$7C,$00,$40,$01
            dc.b    $74,$72,$00,$41,$EA,$00,$16,$43,$FA,$00,$F6,$30,$19,$15,$41,$00
            dc.b    $F7,$15,$41,$01,$03,$42,$2A,$00,$F6,$15,$7C,$00,$01,$01,$02,$11
            dc.b    $41,$00,$06,$11,$59,$00,$07,$74,$01,$42,$43,$16,$19,$67,$06,$34
            dc.b    $03,$D4,$6E,$FF,$F6,$11,$42,$00,$08,$34,$19,$11,$42,$00,$09,$11
            dc.b    $42,$00,$0A,$97,$CB,$34,$19,$67,$06,$47,$FA,$FA,$0A,$D6,$C2,$21
            dc.b    $4B,$00,$14,$26,$4A,$D6,$D9,$21,$4B,$00,$0C,$21,$4B,$00,$10,$41
            dc.b    $E8,$00,$1C,$51,$C8,$FF,$BA,$70,$02,$93,$C9,$41,$EA,$00,$A2,$20
            dc.b    $89,$22,$48,$41,$E8,$00,$1C,$51,$C8,$FF,$F6,$25,$49,$01,$6C,$22
            dc.b    $6E,$FF,$F0,$22,$51,$30,$19,$E1,$58,$35,$40,$01,$04,$25,$49,$01
            dc.b    $06,$35,$6E,$FF,$E6,$01,$0A,$41,$EA,$01,$02,$A0,$88,$2F,$2E,$FF
            dc.b    $F0,$A9,$A3,$15,$7C,$00,$03,$01,$38,$15,$6E,$FF,$F5,$01,$39,$41
            dc.b    $EA,$00,$86,$A0,$87,$4A,$2A,$00,$91,$66,$FA,$15,$7C,$00,$01,$01
            dc.b    $0F,$30,$2E,$FF,$E4,$61,$7A,$35,$41,$01,$12,$35,$40,$01,$14,$41
            dc.b    $EA,$00,$16,$A0,$87,$4A,$2A,$00,$21,$66,$FA,$35,$6A,$01,$16,$01
            dc.b    $BA,$35,$6A,$01,$18,$01,$BC,$35,$6A,$01,$1A,$01,$BE,$50,$EA,$00
            dc.b    $02,$41,$EA,$00,$32,$A0,$87,$41,$EA,$00,$6A,$A0,$87,$4E,$75,$00
            dc.b    $07,$00,$03,$00,$0E,$00,$00,$01,$0E,$00,$01,$00,$10,$04,$A4,$01
            dc.b    $1C,$00,$02,$00,$06,$04,$00,$01,$2C,$02,$02,$00,$06,$05,$0E,$01
            dc.b    $32,$00,$00,$00,$04,$00,$00,$01,$38,$00,$03,$00,$10,$03,$C6,$01
            dc.b    $3C,$00,$03,$00,$10,$03,$C6,$01,$4C,$00,$03,$00,$10,$03,$C6,$01
            dc.b    $5C,$32,$00,$02,$41,$C0,$00,$66,$04,$30,$3C,$CC,$0A,$3F,$00,$02
            dc.b    $40,$03,$FF,$54,$40,$32,$3C,$90,$00,$C0,$C1,$80,$FC,$8F,$63,$48
            dc.b    $40,$32,$00,$48,$40,$0C,$41,$47,$B1,$6F,$02,$52,$40,$55,$40,$32
            dc.b    $1F,$4E,$75,$40,$E7,$00,$7C,$07,$00,$4A,$EA,$00,$04,$67,$08,$50
            dc.b    $EA,$00,$05,$46,$DF,$4E,$75,$42,$2A,$00,$05,$46,$DF,$42,$67,$20
            dc.b    $2A,$00,$0A,$67,$00,$00,$AE,$4A,$57,$66,$00,$00,$A8,$4A,$2A,$01
            dc.b    $CE,$66,$00,$00,$A0,$20,$40,$20,$68,$00,$08,$26,$28,$00,$24,$96
            dc.b    $A8,$00,$28,$57,$D7,$67,$00,$00,$8C,$26,$68,$00,$20,$D7,$E8,$00
            dc.b    $28,$30,$2A,$01,$76,$90,$6A,$01,$78,$64,$04,$D0,$6A,$01,$74,$67
            dc.b    $2E,$B0,$43,$63,$02,$30,$03,$32,$2A,$01,$78,$34,$2A,$01,$74,$22
            dc.b    $6A,$01,$70,$96,$40,$53,$40,$16,$F1,$10,$00,$52,$41,$B4,$41,$66
            dc.b    $02,$42,$41,$51,$C8,$FF,$F2,$35,$41,$01
            dc.b    'xJCg.J*'
            dc.w    $01CE,$6628,$302A,$01CA,$6722,$B043,$6302,$3003
            dc.w    $4A2A,$01CF,$670E,$B06A,$01CC,$6308,$302A,$01CC
            dc.w    $50EA,$01CE,$204B,$6100,$012C,$9640,$206A,$000A
            dc.w    $2068,$0008,$2028,$0024,$9083,$4A83,$57D7,$2140
            dc.w    $0028,$4A2A,$0002,$6668,$4A6A,$01CA,$6762,$302A
            dc.w    $0176,$906A,$0178,$6404,$D06A,$0174,$322A,$0174
            dc.w    $9240
            dc.b    'SAgJ0*'
            dc.w    $0174,$906A,$0176,$B041,$6302,$3001,$206A,$0170
            dc.w    $D0EA,$0176,$3400,$6100,$00D4,$672C,$9240,$9440
            dc.w    $D06A,$0176,$B06A,$0174,$6504,$906A,$0174,$3540
            dc.w    $0176,$4A42,$6612,$3001,$670E,$206A,$0170,$6100
            dc.w    $00AC,$6704,$3540,$0176,$4A2A,$0002,$6626,$4A2A
            dc.w    $01CE,$6606,$4A6A,$01C8,$671A,$50EA,$0002,$356A
            dc.w    $01C8,$0120,$4A2A,$01CE,$6704,$50EA,$0122,$41EA
            dc.w    $0032,$A087,$40E7,$007C,$0700,$4A2A,$0005,$670A
            dc.w    $422A,$0005,$46DF,$6000,$FE9E,$202A,$000A,$6712
            dc.w    $303C,$FFE5,$4A2A,$01CE,$6616,$4240,$4A6F,$0002
            dc.w    $660E,$422A,$01CE,$422A,$0004,$46DF
            dc.b    'J_NuB*'
            dc.w    $01CE,$426F,$0002,$226A,$000A,$42AA,$000A,$46DF
            dc.w    $2F0A,$2078,$08FC,$4E90,$245F,$40E7,$007C,$0700
            dc.w    $4A2A,$0005,$670A,$422A,$0005,$46DF,$6000,$FE46
            dc.w    $422A,$0004,$46DF,$4A5F,$4E75,$48E7,$7010,$3600
            dc.w    $2648,$342A,$01C0,$672A,$B443,$6302,$3403,$9642
            dc.w    $254B,$00FA,$356A,$01C2,$00FE,$3542,$00F8,$D6C2
            dc.w    $956A,$01C0,$D56A,$01C2,$41EA,$00F6,$A088
            dc.b    'JCg*2*'
            dc.w    $01C4,$6724,$B243,$6302,$3203,$254B,$00FA,$356A
            dc.w    $01C6,$00FE,$3541,$00F8,$936A,$01C4,$D36A,$01C6
            dc.w    $D441,$41EA,$00F6,$A088,$3002,$671C,$D16A,$01C8
            dc.w    $916A,$01CA,$4A2A,$01CF,$670E,$916A,$01CC,$6408
            dc.w    $422A,$01CF,$50EA,$0122,$4CDF,$080E,$4A40,$4E75
            dc.w    $40E7,$007C,$0700,$202A,$016C,$670A,$2640,$274A
            dc.w    $0018,$2553,$016C,$46DF,$4A80,$4E75,$225F,$2078
            dc.w    $01D8,$5448,$0810,0,$6704,$1F16,$60F6,$4ED1
            dc.w    $2F01,$7202,$6004,$2F01,$7200,$0C00,$0001,$6602
            dc.w    $611E,$0C00,$0002,$660A,$2001,$08C0,$0007,$A685
            dc.w    $600A,$0C00,$0003,$6604,$2001,$A685,$221F,$4E75
            dc.w    $48E7,$2080,$9EFC,$0010,$41EF,$000C,$2F48,$0008
            dc.w    $2F48,$0004,$204F,$7005,$1438,$0290,$8438,$0291
            dc.w    $6A20,$4A01,$671C,$30BC,$0058,$4268,$0002,$A085
            dc.w    $1428,$000C,$7005,$0202,$0007,$0C02,$0007,$6602
            dc.w    $7000,$4FEF,$0010,$4CDF,$0104,$4E75,$0838,0
            dc.w    $0B22,$6704,$1001,$A685,$103C,$0002,$E478,$4E75
            dc.w    $4EA8,$0002,$4A40,$660E,$0838,0,$0B22,$6704
            dc.w    $4200,$A685,$7000,$4E75,$205F,$0838,0,$0B22
            dc.w    $6704,$487A,$FF4C,$7202,$74F7,$7682,$4ED0,$205F
            dc.w    $0838,0,$0B22,$6704,$487A,$FF3C,$7200,$7417
            dc.w    $7642,$4ED0,$285F,$0838,0,$0B22,$6714,$41EA
            dc.w    $0090,$215F,$0006,$317C,$0010,$0004,$4268,$000A
            dc.w    $A28A,$205F,$26D0,$209F,$4ED4,$0838,0,$0B22
            dc.w    $6706,$41EA,$0090,$A48A,$2069,$0014,$A023,$42A9
            dc.w    $0014,$4296,$4E75,$0838,0,$0B22,$6710,$7000
            dc.w    $08C0,$0007,$4A83,$6704,0,$0004,$A685,$4E75
            ds.b    710

            EVEN
