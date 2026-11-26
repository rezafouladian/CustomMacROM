            include "Include/ROMHeader.s"

            EXPORT  ElsieTranslate24To32,ENABLEPARITYPATCH,LoadSegPatch,OPENPATCH,Overpatch,RSRCMGRPATCH
            EXPORT  SEPARITYPATCH,SHUTRESTARTANNEX,SLOTBUSEXCPTNPTCH,SoundInitPatch,UnloadSegPatch

            IMPORT  BLOCKMOVEPATCH,CallRoutines,Enable60HzInts,EnableParityInts,FLUSHCRANGE,HMMMMMM
            IMPORT  INITGLOBALS,INITMACEDISPATCH,InitSndDispatch,InstallSoundIntHandler,OPENPATCHRTN,OPENPATCHRTN1
            IMPORT  SoundInitPatchRtn

            SECTION "Part6",CODE

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

            EVEN
