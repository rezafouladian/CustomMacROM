            include "Include/ROMHeader.s"

            EXPORT  FMSwapFont,FontManager,FontMetrics,GetFNum,GetFontName,RealFont
            EXPORT  SetFontLock,SetFractEnable,SetFScaleDisable

            IMPORT  SMGRINITFONTS,A,GetDevPix

            SECTION "FontMgr",CODE

FontManager:
InitFonts:
            tst.b   FMExist
            beq.w   .L4
            moveq   #-1,D2
            clr.w   FMgrOutRec
            bsr.w   sub_40827216
            clr.w   ($98E).w
            clr.b   FScaleDisable
            clr.b   FractEnable
            st      FontFlag
            move.w  SPFont,ApFontID
            addq.w  #1,ApFontID
            move.b  #$C,FMDefaultSize
            move.l  WidthTabHandle,D0
            bne.b   .L1
            move.l  #$434,D0
            _NewHandle sys
            bne.w   .L5
            move.l  A0,WidthTabHandle
            moveq   #$30,D0
            _NewHandleClear async
            bne.b   .L1
            move.l  A0,WidthListHand
.L1:
            move.l  ($1204).w,JSwapFont
            moveq   #$14,D0
            move.l  SynListHandle,D1
            ble.b   .L2
            movea.l D1,A0
            _SetHandleSize
            bra.b   .L3
.L2:
            _NewHandle sys
            bne.b   .L5
            move.l  A0,SynListHandle
.L3:
            movea.l (A0),A0
            move.l  D2,(4,A0)
            tst.b   FMExist
            bpl.b   .L4
            clr.b   FMExist
            clr.l   ($99A).w
            clr.l   LastFOND
            bsr.b   InValWidths
            move.l  OneOne,-(SP)
            move.l  OneOne,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            subq.w  #4,SP
            pea     (4,SP)
            _FMSwapFont
            lea     ($14,SP),SP
            move.l  ($99A).w,ScrapEnd
.L4:
            BigJmp  SMGRINITFONTS,A0
.L5:
            moveq   #$19,D0
            _SysError
InValWidths:
            movea.l LastFOND,A0
            move.b  ($903).w,D0
            cmpi.b  #$FF,D0
            beq.b   .L1
            _HSetState
.L1:
            moveq   #-1,D2
            move.l  D2,LastSPExtra
            move.w  D2,FONDID
            movea.l SynListHandle,A0
            _GetHandleSize
            movea.l (A0),A1
            move.l  D0,D1
            divu.w  #$14,D1
            subq.w  #1,D1
.L2:
            movea.l (A1)+,A0
            cmp.l   (A1),D2
            beq.b   .L3
            _DisposHandle
            move.l  D2,(A1)
.L3:
            lea     ($10,A1),A1
            dbra    D1,.L2
            movea.l SynListHandle,A0
            moveq   #$14,D0
            _SetHandleSize
            move.l  WidthListHand,D0
            beq.b   InvalWidthTab
            movea.l D0,A1
            movea.l (A1),A1
            moveq   #$B,D1
.L4:
            move.l  (A1)+,D0
            beq.b   InvalWidthTab
            movea.l D0,A0
            move.l  (A0),D0
            beq.b   .L5
            movea.l (A0),A0
            move.l  D2,($400,A0)
            move.w  D2,($40C,A0)
.L5:
            dbra    D1,.L4
InvalWidthTab:
            moveq   #-1,D2
            bsr.b   sub_408264DE
            move.l  D2,($400,A0)
            move.w  D2,($40C,A0)
            move.w  D2,CurFMInput
            rts
sub_408264DE:
            movea.l WidthTabHandle,A0
            movea.l (A0),A0
            rts
FamSizeInD0:
            moveq   #0,D1
            move.w  (A3),D0
            bne.b   .L1
            move.w  SysFontFam,D0
            move.w  SysFontSize,D1
            bne.b   .L3
.L1:
            move.b  FMDefaultSize,D1
            bne.b   .L2
            moveq   #$C,D1
.L2:
            cmpi.w  #1,D0
            bne.b   .L3
            move.w  ApFontID,D0
.L3:
            swap    D0
            move.w  (2,A3),D0
            bne.b   .L4
            move.w  D1,D0
.L4:
            rts
FMSwapFont:
            lea     FMgrOutRec,A0
            move.l  A0,(8,SP)
            moveq   #-1,D2
            cmp.l   LastSPExtra,D2
            beq.w   .L5
            addq.b  #1,FontFlag
            beq.b   .L1
            bsr.b   InvalWidthTab
            cmpi.b  #9,FontFlag
            beq.w   sub_40827092.L21
            bgt.w   .L8
            move.b  #8,FontFlag
.L1:
            movea.l (4,SP),A0
            lea     CurFMInput,A1
            cmpm.l  (A0)+,(A1)+
            beq.b   .L2
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            bsr.b   FamSizeInD0
            move.l  D0,D2
            lea     CurFMInput,A3
            bsr.b   FamSizeInD0
            movea.l (SP)+,A3
            cmp.l   D2,D0
            bne.w   PurgeOnTheFly.L2
            move.l  (-4,A0),(-4,A1)
.L2:
            cmpm.l  (A0)+,(A1)+
            beq.b   .L3
            move.l  -(A0),D0
            move.l  -(A1),D1
            eor.l   D0,D1
            andi.l  #$FF00FFFF,D1
            bne.b   .L5
            move.l  (A0)+,(A1)+
.L3:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L5
            cmpm.l  (A0)+,(A1)+
            bne.b   .L5
            tst.b   QDExist
            bmi.b   .L6
            movea.l (A5),A0
            move.l  (A0),D0
            beq.b   .L6
            movea.l D0,A0
            move.w  ($48,A0),D1
            cmp.w   ($D3E).w,D1
            bne.b   .L4
            lea     ($50,A0),A1
            lea     ($D36).w,A0
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            movea.l D0,A0
            bsr.w   sub_40826894
            cmp.w   ($D40).w,D0
.L4:
            bne.w   sub_40826894.L5
            movea.l ([A5]),A0
            move.l  LastSPExtra,D0
            cmp.l   ($4C,A0),D0
            beq.b   .L6
            link.w  A6,#-$8A
            clr.w   (-$48,A6)
            clr.w   (-$4A,A6)
            movem.l D3-D7/A2-A4,-(SP)
            movea.l (8,A6),A3
            subq.b  #2,FontFlag
            bra.w   AddD6ScaleD0.L8
.L5:
            bra.w   PurgeOnTheFly.L2
.L6:
            subq.b  #2,FontFlag
.L7:
            movea.l ($99A).w,A0
            tst.l   (A0)
            bne.b   .L8
            move.l  A0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _LoadResource
            cmpi.b  #$FF,FontFlag
            beq.b   .L5
            tst.l   (A0)
            beq.b   .L5
            bsr.w   BuildCharTable
.L8:
            movea.l WidthTabHandle,A0
            move.l  (A0),WidthPtr
            st      FontFlag
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
SetUpScale:
            lea     ($9AA).w,A0
            move.w  (A1)+,(0,A0,D1.w)
            lea     FScaleVFact,A0
            moveq   #0,D0
            move.w  (2,A1),D0
            asl.l   #8,D0
            add.w   D1,D1
            neg.w   D1
            move.l  D0,(0,A0,D1.w)
            rts
DeRefResource:
            tst.l   (A0)
            bne.b   .L1
            move.l  A0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _LoadResource
            cmpi.b  #$FF,FontFlag
            beq.b   .L2
            tst.l   (A0)
            beq.b   .L2
.L1:
            movea.l (A0),A0
            rts
.L2:
            bra.w   sub_40827092.L13
PurgeOnTheFly:
            cmpi.w  #$FFFF,FONDID
            beq.b   .L1
            move.l  ($99A).w,D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (A0),D0
            beq.b   .L1
            movea.l D0,A1
            btst    #0,(A1)
            beq.b   .L1
            _HPurge
.L1:
            rts
.L2:
            link.w  A6,#-$8A
            clr.w   (-$48,A6)
            clr.w   (-$4A,A6)
            movem.l D3-D7/A2-A4,-(SP)
.L3:
            bsr.b   PurgeOnTheFly
            movea.l (8,A6),A0
            lea     (-$10,A6),A1
            moveq   #$10,D0
            _BlockMove
            movea.l A1,A3
            move.b  (4,A3),($9A9).w
            move.w  (6,A3),D0
            cmp.w   ($98E).w,D0
            beq.b   .L4
            bsr.w   SetNewDevice
.L4:
            bsr.w   FamSizeInD0
            move.l  D0,(A3)
            clr.b   (5,A3)
            lea     FontFlag,A4
            cmpi.b  #6,(A4)
            blt.b   .L5
            clr.w   (A3)
.L5:
            tst.b   (A4)
            bpl.b   .L6
            bsr.w   InvalWidthTab
            clr.b   (A4)
.L6:
            move.l  WidthListHand,D0
            beq.b   .L8
            moveq   #-1,D2
            cmp.l   LastSPExtra,D2
            beq.b   .L7
            cmp.w   CurFMInput,D2
            bne.b   .L9
            bra.b   .L8
.L7:
            bsr.w   InValWidths
.L8:
            bra.w   .L22
.L9:
            movea.l D0,A4
            movea.l (A4),A4
            moveq   #-1,D2
            moveq   #-1,D3
            sf      D4
            moveq   #-4,D5
            sf      D6
            moveq   #-1,D7
.L10:
            addq.w  #4,D5
            move.l  (A4),D1
            beq.w   .L16
            movea.l D1,A0
            move.l  (A0),D0
            beq.w   .L14
            move.w  D5,D7
            movea.l D0,A1
            moveq   #3,D1
            movea.l A3,A0
            lea     ($40C,A1),A1
            cmpi.w  #$FFFF,(A1)
            bne.b   .L11
            move.w  D5,D3
.L11:
            cmpm.l  (A0)+,(A1)+
            dbne    D1,.L11
            bne.b   .L15
            st      D6
            move.w  (A1),D0
            cmp.w   FONDID,D0
            beq.b   .L12
            move.b  ($903).w,D0
            movea.l LastFOND,A0
            _HSetState
            movea.l (A4),A0
            _HNoPurge
            move.w  (A1)+,D0
            move.w  D0,FONDID
            movea.l (A1)+,A0
            move.l  A0,LastFOND
            beq.b   .L13
            bsr.w   DeRefResource
            move.b  (A0),GotStrike
            movea.l LastFOND,A0
            _HGetState
            move.b  D0,($903).w
            _HNoPurge
            movea.l WidthListHand,A4
            movea.l (A4),A4
            adda.w  D5,A4
            movea.l (A4),A1
            movea.l (A1),A1
            lea     ($422,A1),A1
            bra.b   .L13
.L12:
            addq.w  #6,A1
.L13:
            move.b  (A1)+,UsedFWidths
            move.b  (A1)+,($9A9).w
            moveq   #0,D1
            bsr.w   SetUpScale
            moveq   #2,D1
            bsr.w   SetUpScale
            movea.l (A4),A0
            movea.l (A0),A1
            movea.l ($400,A1),A1
            move.l  A1,($99A).w
            bra.b   .L19
.L14:
            move.w  D5,D2
.L15:
            addq.w  #4,A4
            cmpi.w  #$2C,D5
            bcs.w   .L10
            st      D4
            subq.w  #4,A4
.L16:
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            cmpi.w  #$FFFF,($40C,A1)
            beq.b   .L22
            exg     D3,D5
            tst.w   D5
            bpl.b   .L18
            move.l  #$434,D1
            _MaxBlock sys
            cmp.l   D1,D0
            ble.b   .L17
            move.l  D1,D0
            move.w  D2,D5
            bpl.b   .L18
            tst.b   D4
            bne.b   .L17
            move.w  D3,D5
            _NewHandle sys
            bne.b   .L22
            bra.b   .L18
.L17:
            move.w  D7,D5
            bmi.b   .L22
.L18:
            movea.l WidthListHand,A4
            movea.l (A4),A4
            lea     (0,A4,D5.w),A4
            move.l  (A4),D1
            beq.b   .L19
            movea.l D1,A0
            tst.l   (A0)
            bne.b   .L19
            _ReallocHandle
            bne.b   .L22
            bra.b   .L18
.L19:
            bra.b   .L21
.L20:
            move.l  -(A4),(4,A4)
.L21:
            subq.w  #4,D5
            bpl.b   .L20
            move.l  WidthTabHandle,D1
            move.l  A0,WidthTabHandle
            _HNoPurge
            move.l  D1,(A4)
            movea.l D1,A0
            _HPurge
            tst.b   D6
            bne.b   .L23
.L22:
            bsr.w   InvalWidthTab
            bsr.w   sub_40826F7E
.L23:
            movea.l ($99A).w,A0
            bsr.w   DeRefResource
            tst.b   FScaleDisable
            bne.b   ByteHScale.L1
            lea     ($9A5).w,A1
            move.b  ($13,A0),(A1)+
            move.b  ($15,A0),(A1)+
            move.b  (7,A0),(A1)+
            move.b  ($17,A0),(A1)
            bra.w   sub_40826894.L6
sub_4082684E:
            move.l  FScaleVFact,D1
ByteHScale:
            ext.w   D0
            swap    D0
            clr.w   D0
            movem.l D0-D3/A0-A1,-(SP)
            _FixMul
            _FixRound
            move.w  (SP)+,D0
            addq.w  #2,SP
            movem.l (SP)+,A0-A1
            move.b  D0,(A1)+
            rts
.L1:
            lea     ($9A5).w,A1
            move.b  ($13,A0),D0
            bsr.b   sub_4082684E
            move.b  ($15,A0),D0
            bsr.b   sub_4082684E
            move.b  (7,A0),D0
            move.l  FScaleHFact,D1
            bsr.b   ByteHScale
            move.b  ($17,A0),D0
            bsr.b   sub_4082684E
            bra.b   sub_40826894.L6
sub_4082688E:
            tst.b   QDExist
            bmi.b   sub_40826894.L4
sub_40826894:
            movea.l (A5),A1
            move.l  (A1),D0
            beq.b   .L4
            movea.l D0,A0
            move.l  (-$7A,A1),D0
            tst.w   (6,A0)
            bpl.b   .L1
            movea.l ([2.w,A0]),A0
            cmp.l   (A0),D0
            beq.b   .L2
            bra.b   .L3
.L1:
            cmp.l   (2,A0),D0
            bne.b   .L4
.L2:
            bsr.l   GetDevPix
.L3:
            moveq   #0,D0
            move.w  ($20,A0),D0
            rts
.L4:
            moveq   #1,D0
            rts
.L5:
            link.w  A6,#-$8A
            clr.w   (-$48,A6)
            clr.w   (-$4A,A6)
            movem.l D3-D7/A2-A4,-(SP)
            movea.l (8,A6),A3
            subq.b  #2,FontFlag
            bsr.w   PurgeOnTheFly
            bsr.w   sub_408264DE
            movea.l ($400,A0),A0
            move.l  A0,($99A).w
.L6:
            bsr.b   sub_4082688E
            move.l  D0,D6
            cmpi.w  #1,D6
            beq.b   .L7
            move.b  ($9A9).w,D0
            andi.b  #$9F,D0
            bne.b   .L7
            _StackSpace
            cmpi.l  #$C00,D0
            blt.b   .L7
            movea.l ($99A).w,A0
            bsr.w   DeRefResource
            btst    #6,(A0)
            beq.b   .L8
.L7:
            bra.w   .L35
.L8:
            bfffo   D6{26:6},D6
            not.w   D6
            andi.w  #7,D6
            move.w  #1,(-$8A,A6)
            lea     (-$88,A6),A1
            clr.l   (A1)+
            clr.w   (A1)+
            moveq   #-1,D0
            move.l  D0,(A1)+
            move.w  D0,(A1)
            tst.b   QDExist
            bmi.b   .L10
            move.l  ([A5]),D0
            beq.b   .L10
            movea.l D0,A0
            move.w  ($48,A0),D0
            andi.w  #$FFF7,D0
            move.w  D0,(-$8A,A6)
            cmpi.w  #$32,D0
            beq.b   .L7
            bclr    #5,D0
            bne.b   .L9
            bclr    #2,D0
            bne.b   .L7
            subq.w  #3,D0
            beq.b   .L7
            bra.b   .L10
.L9:
            pea     (-$88,A6)
            _GetForeColor
            pea     (-$82,A6)
            _GetBackColor
.L10:
            move.l  A3,-(SP)
            moveq   #0,D3
            moveq   #0,D5
            move.w  D6,D7
            move.w  D6,D0
            asl.w   #8,D0
            or.b    (4,A3),D0
            move.b  ($9A9).w,D1
            eor.b   D1,D0
            bsr.w   sub_408264DE
            move.w  ($42C,A0),D2
            move.l  LastFOND,D1
            beq.w   .L18
            movea.l D1,A0
            movea.l (A0),A0
            lea     ($34,A0),A0
            move.w  (A0)+,D1
.L11:
            cmp.w   (A0)+,D2
            blt.b   .L14
            bne.b   .L13
            cmp.w   (A0),D0
            beq.b   .L15
            move.w  (A0),D4
            cmpi.w  #$100,D4
            blt.b   .L13
.L12:
            cmpi.w  #$500,D4
            bge.b   .L13
            addi.w  #$100,D4
            cmp.w   D4,D0
            bne.b   .L12
            move.l  A0,D5
.L13:
            addq.w  #4,A0
            dbra    D1,.L11
.L14:
            tst.l   D5
            beq.b   .L18
            movea.l D5,A0
            move.b  (A0),D7
.L15:
            move.w  (2,A0),D0
            move.w  D0,D5
            bsr.w   LoadNoROM
            bne.b   .L16
            movea.l ($99A).w,A0
            bsr.w   DeRefResource
            move.l  A0,D0
            _StripAddress
            movea.l D0,A0
            move.l  ROMBase,D0
            _StripAddress
            cmpa.l  D0,A0
            blt.b   .L18
            move.w  D5,D0
            bsr.w   sub_4082722A
            beq.b   .L18
.L16:
            move.w  D7,D3
            move.l  A0,($99A).w
            movea.l A0,A2
            bsr.w   BuildCharTable
            movea.l (A2),A0
            cmp.w   D6,D7
            bne.b   .L17
            btst    #1,(A0)
            beq.w   .L31
.L17:
            bclr    #5,(-$89,A6)
            cmpi.w  #2,(-$8A,A6)
            beq.b   .L18
            pea     (-$88,A6)
            _GetForeColor
            pea     (-$82,A6)
            _GetBackColor
            bset    #5,(-$89,A6)
.L18:
            bsr.w   sub_408264DE
            move.l  ($42E,A0),D5
            movea.l SynListHandle,A0
            _GetHandleSize
            divu.w  #$14,D0
            subq.w  #1,D0
            movea.l (A0),A0
.L19:
            movea.l (A0)+,A2
            move.l  (A0)+,D2
            cmp.l   D5,D2
            bne.b   .L22
            tst.l   (A2)
            beq.b   .L22
            movea.l (A2),A3
            move.w  (A3),D2
            lsr.w   #2,D2
            andi.w  #7,D2
            cmp.w   D6,D2
            bne.b   .L22
            movea.l A0,A3
            lea     (-$88,A6),A1
            moveq   #2,D4
.L20:
            cmpm.l  (A3)+,(A1)+
            dbne    D4,.L20
            bne.b   .L22
            movea.l (A2),A0
            btst    #0,(A0)
            beq.b   .L21
            movea.l A2,A0
            _HNoPurge
.L21:
            bra.w   .L31
.L22:
            lea     ($C,A0),A0
            dbra    D0,.L19
            movea.l ($99A).w,A0
            _HGetState
            move.w  D0,D7
            _HNoPurge
            movea.l (A0),A0
            moveq   #0,D5
            tst.b   (1,A0)
            bpl.b   .L23
            bsr.w   sub_408264DE
            move.l  ($42E,A0),D0
            bpl.b   .L23
            subq.w  #4,SP
            move.l  #'fctb',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D5
.L23:
            move.l  D5,(-$52,A6)
            movea.l SP,A3
            movea.l ($99A).w,A0
            cmpi.w  #3,D6
            ble.b   .L24
            tst.w   D3
            beq.w   .L33
            movea.l (A0),A1
            move.w  (A1),D0
            btst    #9,D0
            beq.w   .L33
            move.w  #3,D6
.L24:
            _GetHandleSize
            movea.l (A0),A1
            move.w  ($18,A1),D1
            add.w   D1,D1
            mulu.w  ($E,A1),D1
            move.l  D1,D5
            asl.l   D3,D1
            move.l  D1,D4
            sub.l   D1,D0
            move.l  D0,D2
            lsl.l   D6,D5
            add.l   D5,D0
            move.l  D0,-(SP)
            _PurgeSpace
            move.l  (SP)+,D1
            cmpa.l  D1,A0
            bls.w   .L33
            sub.l   D1,D0
            cmpi.l  #$1000,D0
            bls.w   .L33
            movea.l ($99A).w,A0
            movea.l D1,A2
            move.l  D2,-(SP)
            _HandToHand
            move.l  (SP)+,D2
            tst.w   D0
            bne.w   .L33
            move.l  A2,D0
            _SetHandleSize
            bne.w   .L32
            movea.l A0,A2
            movea.l ($99A).w,A0
            move.w  D7,D0
            _HSetState
            movea.l (A2),A1
            move.w  D6,D0
            asl.w   #2,D0
            bset    #8,D0
            move.w  (-$8A,A6),D1
            andi.w  #$20,D1
            lsl.w   #4,D1
            or.w    D1,D0
            andi.w  #$FFE3,(A1)
            or.w    D0,(A1)
            move.w  ($A,A1),D0
            swap    D0
            bpl.b   .L25
            moveq   #0,D0
.L25:
            move.w  ($10,A1),D0
            add.l   D0,D0
            sub.l   D4,D0
            add.l   D5,D0
            asr.l   #1,D0
            move.w  D0,($10,A1)
            swap    D0
            move.w  D0,($A,A1)
            moveq   #$1A,D0
            movea.l (A0),A0
            adda.l  D4,A0
            adda.l  D0,A0
            adda.l  D5,A1
            adda.l  D0,A1
            sub.l   D0,D2
            move.l  D2,D0
            _BlockMove
            moveq   #1,D4
            lsl.w   D3,D4
            move.w  D4,(-$5C,A6)
            pea     (-$7C,A6)
            move.w  (-$8A,A6),-(SP)
            jsr     ([$1A38.w])
            movea.l ($99A).w,A0
            bsr.w   DeRefResource
            move.w  ($18,A0),D2
            mulu.w  ($E,A0),D2
            asl.l   #4,D2
            lea     ($1A,A0),A0
            movea.l (A2),A1
            lea     ($1A,A1),A1
            moveq   #1,D5
            lsl.w   D6,D5
            moveq   #0,D6
            moveq   #0,D3
.L26:
            bfextu  (A0){D6:D4},D0
            move.l  (0,SP,D0.w*4),D0
            bfins   D0,(A1){D3:D5}
            add.l   D4,D6
            add.l   D5,D3
            subq.l  #1,D2
            bhi.b   .L26
            movea.l A3,SP
            movea.l SynListHandle,A0
            _GetHandleSize
            move.l  D0,D1
            divu.w  #$14,D1
            subq.w  #1,D1
            movea.l (A0),A1
            moveq   #-1,D2
            bra.b   .L28
.L27:
            lea     ($14,A1),A1
.L28:
            movea.l (A1),A3
            cmp.l   (4,A1),D2
            beq.b   .L30
            tst.l   (A3)
            dbeq    D1,.L27
            beq.b   .L29
            move.w  D0,D3
            addi.w  #$14,D0
            _SetHandleSize
            bne.b   .L29
            movea.l (A0),A1
            adda.w  D3,A1
            bra.b   .L30
.L29:
            movea.l (A1),A0
            _DisposHandle
.L30:
            move.l  A2,(A1)+
            bsr.w   sub_408264DE
            move.l  ($42E,A0),(A1)+
            lea     (-$88,A6),A0
            moveq   #$C,D0
            _BlockMove
.L31:
            move.l  A2,($99A).w
            bra.b   .L34
.L32:
            _DisposHandle
.L33:
            movea.l ($99A).w,A0
            move.w  D7,D0
            _HSetState
            bsr.w   sub_408264DE
            movea.l ($400,A0),A0
            move.l  A0,($99A).w
.L34:
            movea.l (SP)+,A3
.L35:
            move.b  ($9A9).w,D1
            lea     ($99E).w,A0
            clr.l   (A0)+
            clr.w   (A0)+
            clr.b   (A0)+
            tst.b   D1
            beq.b   .L38
            moveq   #0,D2
            lea     ($9B6).w,A1
            moveq   #6,D0
            lea     ($99E).w,A0
.L36:
            move.b  (A1)+,D2
            move.b  (A1)+,D3
            move.b  (A1)+,D4
            lsr.w   #1,D1
            bcc.b   .L37
            add.b   D3,(0,A0,D2.w)
            add.b   D4,($9A4).w
.L37:
            dbra    D0,.L36
            btst    #2,($9A9).w
            beq.b   .L38
            lea     ($9A0).w,A0
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
.L38:
            move.l  LastFOND,D0
            beq.w   .L46
            tst.b   FDevDisable
            bne.b   .L39
            tst.b   (6,A3)
            bne.w   .L46
.L39:
            btst    #5,GotStrike
            bne.b   .L46
            btst    #4,GotStrike
            bne.b   .L40
            tst.b   FractEnable
            beq.b   .L46
.L40:
            movea.l D0,A0
            bsr.w   DeRefResource
            tst.w   (6,A0)
            beq.b   .L46
            lea     ($1C,A0),A0
            move.w  (A0)+,D6
            ext.l   D6
            move.b  ($9A9).w,D1
            beq.b   .L45
            btst    #6,GotStrike
            bne.b   .L41
            move.w  (-$4A,A6),D0
            not.w   D0
            and.w   D0,D1
.L41:
            moveq   #7,D0
.L42:
            move.w  (A0)+,D2
            lsr.w   #1,D1
            bcc.b   .L44
            cmpi.w  #$8FFF,D2
            bgt.b   .L43
            bclr    #$F,D2
            neg.w   D2
.L43:
            ext.l   D2
            add.l   D2,D6
.L44:
            dbra    D0,.L42
.L45:
            asl.l   #4,D6
            subq.w  #6,SP
            clr.w   -(SP)
            bsr.w   sub_408264DE
            move.w  ($42C,A0),-(SP)
            move.l  D6,-(SP)
            _FixMul
            move.l  (SP),D6
            _FixRound
            move.w  (SP)+,D0
            tst.b   FractEnable
            bne.b   .L47
            move.b  D0,($9A4).w
.L46:
            moveq   #0,D6
            move.b  ($9A4).w,D6
            ext.w   D6
            swap    D6
.L47:
            bsr.w   sub_408264DE
            cmpi.w  #$FFFF,($40C,A0)
            bne.w   AddD6ScaleD0.L8
            lea     ($404,A0),A1
            clr.l   (A1)+
            move.l  D6,(A1)
            lea     ($14,A1),A1
            move.w  FONDID,(A1)+
            move.l  LastFOND,(A1)
            movea.l ($99A).w,A0
            bsr.w   DeRefResource
            movem.w (A0),D2-D4
            move.w  D4,D5
            sub.w   D3,D5
            move.w  D5,D1
            addq.w  #3,D5
            add.w   D5,D5
            ext.l   D5
            move.w  ($A,A0),D0
            swap    D0
            bpl.b   .L48
            moveq   #0,D0
.L48:
            move.w  ($10,A0),D0
            add.l   D0,D0
            lea     ($10,A0,D0.l),A1
            moveq   #0,D7
            tst.b   FractEnable
            beq.b   .L49
            btst    #1,D2
            bne.b   .L50
            btst    #6,GotStrike
            bne.b   .L49
            move.l  A4,D0
            beq.b   .L49
            movea.l LastFOND,A1
            movea.l (A1),A1
            adda.l  A4,A1
            bsr.w   sub_408264DE
            move.w  ($42C,A0),D0
            move.w  (-4,A1,D5.w),D7
            muls.w  D0,D7
            asl.l   #4,D7
            bra.b   .L51
.L49:
            move.b  (-3,A1,D5.w),D7
            swap    D7
            bra.b   .L51
.L50:
            adda.l  D5,A1
            move.w  (-4,A1,D5.w),D7
            asl.l   #8,D7
.L51:
            cmpi.l  #$10000,FScaleHFact
            sne     D5
            and.b   FScaleDisable,D5
            move.l  D7,D0
            bsr.b   AddD6ScaleD0
            move.l  D0,D7
            bsr.w   sub_408264DE
            bra.b   .L53
.L52:
            move.l  D7,(A0)+
.L53:
            dbra    D3,.L52
            clr.b   UsedFWidths
            tst.b   FractEnable
            beq.w   AddD6ScaleD0.L2
            btst    #1,D2
            beq.b   .L57
.L54:
            moveq   #0,D0
            move.w  (A1)+,D3
            cmpi.w  #$FFFF,D3
            bne.b   .L55
            move.l  D7,D0
            bra.b   .L56
.L55:
            move.w  D3,D0
            asl.l   #8,D0
            bsr.b   AddD6ScaleD0
.L56:
            move.l  D0,(A0)+
            dbra    D1,.L54
            st      UsedFWidths
            bra.b   AddD6ScaleD0.L5
.L57:
            btst    #6,GotStrike
            bne.b   AddD6ScaleD0.L2
            move.l  A4,D0
            beq.b   AddD6ScaleD0.L2
            movea.l WidthTabHandle,A4
            movea.l (A4),A4
            move.w  ($42C,A4),-(SP)
            movea.l D0,A4
.L58:
            moveq   #0,D0
            move.w  (A1)+,D3
            cmpi.w  #$FFFF,D3
            bne.b   .L59
            move.l  D7,D0
            bra.b   .L60
.L59:
            move.w  D3,D0
            mulu.w  (SP),D0
            asl.l   #4,D0
            bsr.b   AddD6ScaleD0
.L60:
            move.l  D0,(A0)+
            dbra    D1,.L58
            addq.w  #2,SP
            st      UsedFWidths
            bra.b   AddD6ScaleD0.L5
AddD6ScaleD0:
            tst.l   D0
            beq.b   .L1
            add.l   D6,D0
            tst.b   D5
            beq.b   .L1
            movem.l D1/A0-A1,-(SP)
            subq.w  #4,SP
            move.l  D0,-(SP)
            move.l  FScaleHFact,-(SP)
            _FixMul
            movem.l (SP)+,D0-D1/A0-A1
.L1:
            rts
.L2:
            moveq   #0,D0
            move.w  (A1)+,D3
            cmpi.w  #$FFFF,D3
            bne.b   .L3
            move.l  D7,D0
            bra.b   .L4
.L3:
            move.b  D3,D0
            swap    D0
            bsr.b   AddD6ScaleD0
.L4:
            move.l  D0,(A0)+
            dbra    D1,.L2
.L5:
            move.w  #$FF,D0
            sub.w   D4,D0
            bra.b   .L7
.L6:
            move.l  D7,(A0)+
.L7:
            dbra    D0,.L6
.L8:
            bsr.w   sub_408264DE
            lea     ($404,A0),A1
            move.l  (A1),D7
            tst.b   QDExist
            bmi.b   .L9
            movea.l (A5),A0
            move.l  (A0),D0
            beq.b   .L9
            movea.l D0,A0
            move.l  ($4C,A0),D7
            move.w  ($48,A0),($D3E).w
            lea     ($50,A0),A0
            lea     ($D36).w,A2
            move.l  (A0)+,(A2)+
            move.l  (A0),(A2)
            move.l  A1,-(SP)
            bsr.w   sub_4082688E
            movea.l (SP)+,A1
            move.w  D0,($D40).w
.L9:
            move.l  D7,LastSPExtra
            sub.l   (A1),D7
            beq.b   .L10
            add.l   D7,(A1)
            suba.w  #$C,SP
            move.w  ($A,A3),-(SP)
            move.w  ($E,A3),-(SP)
            _FixRatio
            subq.w  #4,SP
            move.w  ($9B0).w,-(SP)
            move.w  ($9AC).w,-(SP)
            _FixRatio
            _FixMul
            move.l  D7,-(SP)
            _FixMul
            bsr.w   sub_408264DE
            move.l  (SP)+,D0
            add.l   D0,($80,A0)
.L10:
            moveq   #-1,D0
            move.b  (6,A3),D0
            beq.b   .L11
            lea     (-$46,A6),A0
            move.w  D0,($18,A0)
            move.w  #8,($1A,A0)
            move.l  A3,($1C,A0)
            move.w  (6,A3),($20,A0)
            _Control
.L11:
            movea.l (8,A6),A3
            movea.l A3,A0
            lea     CurFMInput,A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            bsr.w   sub_408264DE
            cmpi.w  #$FFFF,($40C,A0)
            bne.b   .L12
            move.b  UsedFWidths,($422,A0)
            move.b  ($9A9).w,($423,A0)
            lea     ($40C,A0),A1
            bsr.w   FamSizeInD0
            move.l  D0,(A1)+
            addq.w  #4,A3
            move.l  (A3)+,(A1)+
            clr.b   (-3,A1)
            move.l  (A3)+,(A1)+
            move.l  (A3),(A1)
.L12:
            movem.l (SP)+,D3-D7/A2-A4
            move.w  (-$48,A6),D0
            beq.b   .L13
            move.w  D0,CurMap
.L13:
            unlk    A6
            bra.w   FMSwapFont.L7
sub_40826F7E:
            suba.l  A4,A4
            move.w  (2,A3),D5
            move.w  (A3),D3
            suba.w  #$E,SP
            move.w  ($9B4).w,-(SP)
            move.w  #$50,-(SP)
            _FixRatio
            subq.w  #4,SP
            move.w  ($A,A3),-(SP)
            move.w  ($E,A3),-(SP)
            _FixRatio
            _FixMul
            clr.w   -(SP)
            move.w  D5,-(SP)
            _FixMul
            _FixRound
            cmp.w   FONDID,D3
            beq.b   .L2
            movea.l LastFOND,A0
            move.b  ($903).w,D0
            _HSetState
            move.w  D3,D1
            move.w  #$FFFF,ROMMapInsert
            bsr.w   GetFOND
            beq.b   .L1
            movea.l (A0),A1
            move.b  (A1),GotStrike
            _HGetState
            move.b  D0,($903).w
            _HNoPurge
.L1:
            cmpi.b  #$FF,FontFlag
            beq.w   sub_40827092.L12
            move.w  D3,FONDID
            move.l  A0,LastFOND
.L2:
            move.l  LastFOND,D0
            bne.w   sub_408272B0.L3
            cmpi.w  #$200,D3
            bcs.b   OrInSize.L1
            bra.w   sub_40827092.L12
OrInSize:
            andi.w  #$FF80,D3
            or.w    D0,D3
            bsr.w   GetFontHandle
            bvs.w   sub_40827092.L11
            rts
.L1:
            move.w  (SP)+,D0
            bne.b   .L2
            moveq   #1,D0
.L2:
            andi.w  #$7F,D0
            asl.w   #7,D3
            or.w    D0,D3
            move.w  D0,D7
            bsr.w   GetFontHandle
            bvs.w   sub_40827092.L13
            bne.b   .L6
            move.w  D3,D4
            move.w  D7,D0
            cmpi.w  #$40,D0
            bge.b   .L3
            add.w   D0,D0
            bsr.b   OrInSize
            bne.b   .L6
.L3:
            move.w  D7,D0
            lsr.w   #1,D0
            bcs.b   .L4
            bsr.b   OrInSize
            bne.b   .L6
.L4:
            move.w  D4,D3
            moveq   #1,D6
            tst.b   FScaleDisable
            beq.b   .L5
            moveq   #-1,D6
.L5:
            add.w   D6,D3
            andi.w  #$7F,D3
            beq.w   sub_40827092.L8
            move.w  D4,D0
            andi.w  #$FF80,D0
            or.w    D0,D3
            bsr.w   GetFontHandle
            bvs.w   sub_40827092.L13
            beq.b   .L5
.L6:
            move.l  A0,($99A).w
            bsr.w   BuildCharTable
            subq.w  #4,SP
            move.w  (2,A3),-(SP)
            move.w  D3,-(SP)
            andi.w  #$7F,(SP)
            _FixRatio
            move.l  (SP)+,D6
            bsr.w   sub_408264DE
            move.w  D3,($42C,A0)
            move.l  ($99A).w,($400,A0)
            moveq   #0,D5
            bsr.b   sub_40827092
            moveq   #2,D5
sub_40827092:
            suba.w  #$C,SP
            move.w  (8,A3,D5.w),-(SP)
            move.w  ($C,A3,D5.w),-(SP)
            _FixRatio
            subq.w  #4,SP
            lea     ($9B2).w,A0
            move.w  (0,A0,D5.w),-(SP)
            move.w  #$50,-(SP)
            _FixRatio
            _FixMul
            move.l  D6,-(SP)
            _FixMul
            lea     ($9AA).w,A0
            move.l  (SP)+,D0
            addi.l  #$80,D0
            lsr.l   #8,D0
            move.w  D0,(0,A0,D5.w)
            move.w  #$100,(4,A0,D5.w)
            move.l  FPointOne,D1
            tst.b   FScaleDisable
            beq.b   .L5
            moveq   #0,D1
            move.w  D0,D1
            move.w  #$100,D0
.L1:
            cmpi.w  #$200,D1
            bcs.b   .L2
            asl.w   #1,D0
            asr.w   #1,D1
            bra.b   .L1
.L2:
            cmpi.w  #$C0,D1
            bcc.b   .L3
            asr.w   #1,D0
            asl.w   #1,D1
            bra.b   .L2
.L3:
            cmpi.w  #$100,D1
            bcc.b   .L4
            move.w  D0,D2
            add.w   D0,D0
            add.w   D2,D0
            asr.w   #2,D0
            asl.w   #2,D1
            divu.w  #3,D1
            ext.l   D1
.L4:
            move.w  D0,(0,A0,D5.w)
            asl.l   #8,D1
.L5:
            tst.w   D5
            beq.b   .L6
            move.l  D1,FScaleHFact
            bra.b   .L7
.L6:
            move.l  D1,FScaleVFact
.L7:
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            lea     ($424,A1),A1
            move.w  D0,(0,A1,D5.w)
            asr.l   #8,D1
            move.w  D1,(4,A1,D5.w)
            rts
.L8:
            tst.b   FScaleDisable
            beq.b   .L9
            neg.w   D6
            bmi.b   .L13
            bra.b   .L10
.L9:
            neg.w   D6
            bpl.b   .L13
.L10:
            move.w  D4,D3
            bra.w   OrInSize.L5
.L11:
            addq.w  #2,SP
.L12:
            addq.w  #2,SP
.L13:
            addq.w  #4,SP
            move.w  (A3),D3
            moveq   #0,D0
            move.b  FontFlag,D0
            bpl.b   .L14
            bsr.w   InvalWidthTab
            clr.b   FontFlag
            bra.b   .L15
.L14:
            addq.b  #2,FontFlag
            move.w  .L16(PC,D0.w),D0
            jsr     .L16(PC,D0.w)
.L15:
            movea.l (8,A6),A1
            move.w  D3,(A3)
            move.w  (2,A1),(2,A3)
            bra.w   PurgeOnTheFly.L4
.L16:
            dc.w    $000A,$0030,$0040,$0058,$0058,$3238,$0984
.L17:
            moveq   #9,D2
            lsr.w   D2,D1
            subi.w  #$1F,D1
            bpl.b   .L18
            moveq   #0,D1
.L18:
            move.w  D3,D0
            lsr.w   D2,D0
            subi.w  #$1F,D0
            bpl.b   .L19
            moveq   #0,D0
.L19:
            cmp.w   D0,D1
            bne.b   .L13
            move.w  ApFontID,D3
            rts
            cmpi.w  #$4000,D3
            bcs.b   .L20
            andi.w  #$FE00,D3
            rts
.L20:
            moveq   #3,D3
            rts
            move.w  SysFontFam,D1
            bra.b   .L17
.L21:
            link.w  A6,#-$8A
            movem.l D3-D7/A2-A4,-(SP)
            movea.l (8,A6),A3
            bsr.b   sub_408271DC
            bra.w   PurgeOnTheFly.L3
sub_408271DC:
            move.w  CurMap,(-$48,A6)
            move.w  SysMap,CurMap
            moveq   #0,D3
            rts
SetNewDevice:
            tst.w   D0
            beq.b   sub_40827216
            moveq   #-1,D0
            move.b  (6,A3),D0
            moveq   #$32,D1
            suba.l  D1,SP
            lea     ($18,SP),A0
            move.w  D0,(A0)+
            move.w  #8,(A0)+
            lea     ($9B2).w,A1
            move.l  A1,(A0)+
            move.w  (6,A3),(A0)+
            movea.l SP,A0
            _Status
            adda.l  D1,SP
            rts
sub_40827216:
            lea     ($9B2).w,A1
            lea     FPointOne.L1,A0
            moveq   #$1C,D0
            _BlockMove
            rts
.L1:
            move.l  (A0),D0
            move.l  D0,(-$14,A6)
sub_4082722A:
            move.w  #$FFFF,ROMMapInsert
LoadNoROM:
            move.w  D0,-(SP)
            subq.w  #4,SP
            move.l  #'NFNT',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   GetFontHandle.L1
            bsr.w   sub_408264DE
            move.w  #$8000,($42E,A0)
            move.w  (SP)+,($430,A0)
            tst.l   D0
            bra.b   GetFontHandle.L3
sub_40827254:
            move.w  #$FF00,ROMMapInsert
            move.w  D1,-(SP)
            bra.b   GetFontHandle.L2
GetFontHandle:
            move.w  D3,-(SP)
.L1:
            move.w  #$FFFF,ROMMapInsert
            moveq   #0,D0
            move.w  (SP),D0
            bsr.w   sub_408264DE
            move.l  D0,($42E,A0)
.L2:
            move.w  (SP)+,D0
            subq.w  #4,SP
            move.l  #'FONT',-(SP)
            move.w  D0,-(SP)
            _GetResource
            move.l  (SP)+,D0
            beq.b   .L3
            move.l  D0,-(SP)
            subq.w  #4,SP
            move.l  D0,-(SP)
            _MaxSizeRsrc
            cmpi.l  #$24,(SP)+
            scs     D0
            movea.l (SP)+,A0
            bra.b   .L4
.L3:
            movea.l D0,A0
            seq     D0
.L4:
            andi.w  #4,D0
            cmpi.b  #$FF,FontFlag
            bne.b   .L5
            bset    #1,D0
.L5:
            move    D0,CCR
            rts
sub_408272B0:
            movea.l (A2),A0
            lea     ($34,A0),A0
            move.w  (A0)+,D1
.L1:
            cmp.w   (A0)+,D3
            beq.w   sub_40827216.L1
            blt.b   .L2
            addq.w  #4,A0
            dbra    D1,.L1
.L2:
            moveq   #0,D0
            rts
.L3:
            move.w  (SP)+,D5
            movea.l D0,A2
            move.w  D5,D3
            bsr.b   sub_408272B0
            bvs.b   .L13
            bne.b   .L4
            tst.b   FScaleDisable
            bne.b   .L5
            add.w   D3,D3
            bsr.b   sub_408272B0
            bvs.b   .L13
            bne.b   .L4
            move.w  D5,D3
            lsr.w   #1,D3
            bcs.b   .L5
            bsr.b   sub_408272B0
            bvs.b   .L13
.L4:
            bne.b   .L11
.L5:
            movea.l (A2),A0
            lea     ($34,A0),A0
            move.w  (A0)+,D4
            moveq   #0,D1
            move.w  #$7FFF,D2
.L6:
            move.w  D5,D0
            sub.w   (A0),D0
            bpl.b   .L8
            tst.b   FScaleDisable
            beq.b   .L7
            tst.w   D1
            bne.b   .L10
.L7:
            neg.w   D0
.L8:
            cmp.w   D2,D0
            bgt.b   .L9
            move.w  D0,D2
            move.w  (A0),D1
.L9:
            addq.w  #6,A0
            dbra    D4,.L6
.L10:
            move.w  D1,D3
            bsr.b   sub_408272B0
            bvs.b   .L13
            beq.b   .L13
.L11:
            move.l  A0,D0
            movea.l (A2),A0
            lea     ($34,A0),A0
            move.w  (A0)+,D1
.L12:
            cmp.w   (A0),D3
            beq.b   .L15
            addq.w  #6,A0
            dbra    D1,.L12
.L13:
            move.w  D5,-(SP)
            move.w  (A3),D3
            bra.w   OrInSize.L1
.L14:
            dc.w    $0408,$0103,$0302,$0100
.L15:
            moveq   #0,D2
            addq.w  #2,A0
            moveq   #-2,D4
            move.b  (4,A3),D2
.L16:
            move.w  (A0),D6
            cmp.w   D6,D2
            bne.b   .L17
            movea.l A0,A1
            bra.b   .L22
.L17:
            moveq   #-1,D5
            move.w  D2,D7
            not.w   D7
            and.w   D6,D7
            bne.b   .L20
            moveq   #0,D5
            moveq   #7,D7
            and.w   D2,D6
.L18:
            asl.b   #1,D6
            bcc.b   .L19
            add.b   .L14(PC,D7.w),D5
.L19:
            dbra    D7,.L18
.L20:
            cmp.w   D5,D4
            bge.b   .L21
            move.w  D5,D4
            movea.l A0,A1
.L21:
            addq.w  #4,A0
            cmp.w   (A0)+,D3
            dbne    D1,.L16
.L22:
            move.w  (A1)+,D6
            move.w  (-$12,A6),D1
            cmp.w   (A1),D1
            movea.l D0,A0
            beq.b   .L23
            move.l  A0,D4
            move.w  (A1),D0
            bsr.w   sub_4082722A
            bvs.b   .L13
            bne.b   .L23
            movea.l D4,A0
            move.w  (-$14,A6),D6
.L23:
            not.w   D6
            and.b   D6,($9A9).w
            movea.l (A2),A1
            move.w  (6,A1),D1
            beq.b   .L31
            sub.w   (4,A1),D1
            addq.w  #4,D1
            add.w   D1,D1
            move.l  ($10,A1),D0
            beq.b   .L31
            adda.l  D0,A1
            move.w  (A1)+,D2
            bmi.b   .L31
            moveq   #-1,D4
            tst.b   FractEnable
            bne.b   .L24
            not.w   D6
            move.w  D6,-(SP)
            bra.b   .L25
.L24:
            moveq   #0,D0
            move.b  (4,A3),D0
            move.w  D0,-(SP)
.L25:
            move.w  (SP),D0
            cmp.w   (A1),D0
            beq.b   .L29
            not.w   D0
            and.w   (A1),D0
            bne.b   .L28
            moveq   #0,D5
            move.w  (SP),D0
            and.w   (A1),D0
            moveq   #7,D7
.L26:
            asl.b   #1,D0
            bcc.b   .L27
            add.b   .L32(PC,D7.w),D5
.L27:
            dbra    D7,.L26
            cmp.w   D5,D4
            bge.b   .L28
            move.w  D5,D4
            move.l  A1,D6
.L28:
            adda.w  D1,A1
            dbra    D2,.L25
            tst.w   D4
            bmi.b   .L30
            movea.l D6,A1
.L29:
            move.w  (A1)+,(-$4A,A6)
            suba.l  (A2),A1
            movea.l A1,A4
.L30:
            addq.w  #2,SP
.L31:
            bra.w   OrInSize.L6
.L32:
            dc.w    $0103,$0504,$0402,$0200
FPointOne:
            dc.w    $0001,0
.L1:
            dc.b    $00,$50,$00,$50,$00,$01,$01,$01,$08
            ds.b    4
            dc.b    $05,$01,$01,$05,$02,$02,$00,$00,$FF,$00,$00,$01,$01,$01,$01,$00
            dc.b    $77,$7A,$3B,$C9,$35,$30,$19,$80,$AF,$30,$18,$7A,$60,$18,$09,$00
            dc.b    $60,$31,$98,$09,$72,$7B,$BA,$49,$BF,$E0,$9D,$01,$02,$20,$BF,$40
            dc.b    $88,$01,$F1,$FE,$02,$0A,$81,$BC,$04,$07,$03,$9A,$08,$04,$0F,$80
            dc.b    $99,$1F,$C0,$37,$60,$B9,$0F,$04,$03,$DF,$0F,$98,$08,$37,$60,$1F
            dc.b    $C1,$A8,$04,$0F,$80,$02,$02,$9A,$01,$04,$87,$08,$18
GetFontName:
            movea.l (SP)+,A1
            move.l  (SP)+,D2
            move.w  (SP)+,D1
            move.w  #$FF00,ROMMapInsert
            bsr.b   GetFONDMap
            bne.b   .L1
            cmpi.w  #$200,D1
            bcc.b   .L2
            asl.w   #7,D1
            move.w  #$FF00,ROMMapInsert
            subq.w  #4,SP
            move.l  #'FONT',-(SP)
            move.w  D1,-(SP)
            _GetResource
            move.l  (SP)+,D0
            movea.l D0,A0
            beq.b   .L2
.L1:
            move.l  A0,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  D2,-(SP)
            move.w  #$FF00,ROMMapInsert
            _GetResInfo
            bra.b   .L3
.L2:
            movea.l D2,A0
            clr.b   (A0)
.L3:
            jmp     (A1)
GetFONDMap:
            tst.w   D1
            bne.b   .L1
            move.w  SysFontFam,D1
            bra.b   GetFOND
.L1:
            cmpi.w  #1,D1
            bne.b   GetFOND
            move.w  ApFontID,D1
GetFOND:
            subq.w  #4,SP
            move.l  #'FOND',-(SP)
            move.w  D1,-(SP)
            _GetResource
            move.l  (SP)+,D0
            movea.l D0,A0
            rts
RealFont:
            movea.l (SP)+,A1
            move.w  (SP)+,D2
            bne.b   .L2
            tst.w   (SP)
            bne.b   .L1
            move.w  SysFontSize,D2
            bne.b   .L2
.L1:
            moveq   #0,D2
            move.b  FMDefaultSize,D2
            bne.b   .L2
            moveq   #$C,D2
.L2:
            move.w  (SP)+,D1
            clr.w   (SP)
            move.w  #$FFFF,ROMMapInsert
            bsr.b   GetFONDMap
            beq.b   .L4
            movea.l (A0),A0
            lea     ($34,A0),A0
            move.w  (A0)+,D0
            bmi.b   .L6
.L3:
            cmp.w   (A0),D2
            beq.b   .L5
            blt.b   .L6
            addq.w  #6,A0
            dbra    D0,.L3
            bra.b   .L6
.L4:
            cmpi.w  #$200,D1
            bcc.b   .L6
            asl.w   #7,D1
            andi.w  #$7F,D2
            or.w    D2,D1
            bsr.w   sub_40827254
            beq.b   .L6
.L5:
            addq.b  #1,(SP)
.L6:
            jmp     (A1)
TryForName:
            subq.w  #4,SP
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            move.w  #$FF00,ROMMapInsert
            _GetNamedResource
            move.l  (SP)+,D0
            rts
GetFNum:
            move.l  (8,SP),D1
            move.l  (SP)+,(4,SP)
            movea.l (SP)+,A1
            move.l  #'FOND',D0
            bsr.b   TryForName
            bne.b   .L1
            move.l  #'FONT',D0
            bsr.b   TryForName
            bne.b   .L2
            clr.w   (A1)
            bra.b   .L4
.L1:
            st      D1
            bra.b   .L3
.L2:
            sf      D1
.L3:
            move.l  D0,-(SP)
            move.l  A1,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.w  #$FF00,ROMMapInsert
            _GetResInfo
            tst.b   D1
            bne.b   .L4
            move.w  (A1),D0
            lsr.w   #7,D0
            move.w  D0,(A1)
.L4:
            rts
SetFontLock:
            movea.l ($99A).w,A0
            movea.l (SP)+,A1
            tst.b   (SP)+
            beq.b   .L1
            move.l  A0,-(SP)
            move.w  #$FFFF,ROMMapInsert
            _LoadResource
            _HNoPurge
            bclr    #6,($903).w
            bra.b   .L2
.L1:
            _HPurge
            bset    #6,($903).w
.L2:
            jmp     (A1)
SetFScaleDisable:
            movea.l (SP)+,A0
            move.b  (SP)+,FScaleDisable
.L1:
            move.l  MinusOne,LastSPExtra
            jmp     (A0)
SetFractEnable:
            movea.l (SP)+,A0
            move.b  (SP)+,FractEnable
            bra.b   SetFScaleDisable.L1
FontMetrics:
            subq.w  #2,SP
            move.w  #$20,-(SP)
            _CharWidth
            addq.w  #2,SP
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            movea.l ($99A).w,A1
            movea.l (A1),A1
            lea     ($12,A1),A0
            pea     (6,A1)
            bsr.b   ScaleVFVal
            bsr.b   ScaleVFVal
            bsr.b   ScaleVFVal
            movea.l (SP)+,A0
            move.l  FScaleHFact,D1
            lea     ($9AC).w,A1
            bsr.b   ScaleFVal
            movea.l WidthTabHandle,A0
            move.l  A0,(A2)
            movea.l (8,SP),A2
            moveq   #0,D0
            move.b  ($9A3).w,D0
            beq.b   .L1
            addq.w  #1,(A2)
            add.w   D0,(4,A2)
.L1:
            movea.l (A0),A0
            move.l  ($408,A0),D0
            add.l   D0,($C,A2)
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
ScaleVFVal:
            move.l  FScaleVFact,D1
            lea     ($9AA).w,A1
ScaleFVal:
            move.w  (A0)+,D0
            move.l  A0,-(SP)
            tst.b   FScaleDisable
            bne.b   .L1
            move.l  FPointOne,D1
.L1:
            subq.w  #4,SP
            move.l  D1,-(SP)
            subq.w  #4,SP
            clr.w   -(SP)
            move.w  D0,-(SP)
            subq.w  #4,SP
            move.w  (A1),-(SP)
            move.w  (4,A1),-(SP)
            _FixRatio
            _FixMul
            _FixMul
            move.l  (SP)+,(A2)+
            movea.l (SP)+,A0
            rts
BuildCharTable:
            link.w  A6,#-4
            movem.l D3-D7/A2-A5,-(SP)
            movea.l A0,A3
            _GetMaskTable
            movea.l A0,A5
            movea.l (A3),A1
            move.w  (A1)+,D0
            lsr.w   #1,D0
            bcs.b   .L3
            move.w  (A1)+,D0
            moveq   #0,D5
            move.w  (A1),D5
            sub.w   D0,D5
            addq.w  #3,D5
            add.w   D5,D5
            movea.l (A3),A1
            move.w  (A1),D0
            asr.w   #2,D0
            andi.w  #7,D0
            move.w  D0,(-4,A6)
            move.w  ($A,A1),D0
            swap    D0
            bpl.b   .L1
            moveq   #0,D0
.L1:
            move.w  ($10,A1),D0
            addq.l  #8,D0
            add.l   D0,D0
            move.l  D0,D1
            sub.l   D5,D1
            add.l   D5,D0
            move.l  D0,D2
            add.l   D5,D0
            btst    #1,(1,A1)
            beq.b   .L2
            add.l   D5,D0
            add.l   D5,D2
.L2:
            movea.l A3,A0
            _SetHandleSize
            beq.b   .L4
.L3:
            movem.l (SP)+,D3-D7/A2-A5
            unlk    A6
            rts
.L4:
            movea.l (A3),A2
            ori.w   #1,(A2)
            move.w  ($E,A2),D3
            adda.l  D1,A2
            movea.l (A3),A4
            adda.l  D2,A4
            subq.w  #2,D5
.L5:
            move.w  #$FF00,(A4)
            move.w  (A2)+,D7
            move.w  (A2),D6
            sub.w   D7,D6
            beq.w   .L12
            move.w  (-4,A6),D0
            lsl.w   D0,D7
            lsl.w   D0,D6
.L6:
            move.w  D7,D2
            move.w  D7,D0
            lsr.w   #4,D0
            add.w   D0,D0
            movea.l (A3),A1
            lea     ($1A,A1),A1
            adda.w  D0,A1
            andi.w  #$F,D2
            move.w  D2,D1
            add.w   D1,D1
            moveq   #0,D0
            move.w  ($20,A5,D1.w),D0
            swap    D0
            moveq   #$10,D4
            move.w  D4,D1
            sub.w   D2,D1
            add.w   D1,D7
            sub.w   D1,D6
            beq.b   .L9
            bpl.b   .L7
            move.w  D6,D1
            add.w   D4,D1
            add.w   D1,D1
            move.l  (0,A5,D1.w),D2
            and.l   D2,D0
            bra.b   .L9
.L7:
            move.w  D6,D1
            cmp.w   D4,D1
            ble.b   .L8
            move.w  D4,D1
.L8:
            add.w   D1,D1
            move.w  (0,A5,D1.w),D2
            or.w    D2,D0
            sub.w   D4,D6
            add.w   D4,D7
.L9:
            move.l  A1,-(SP)
            move.w  D3,D1
            subq.w  #1,D1
            movea.l (A3),A0
            move.w  ($18,A0),D4
            move.w  (-4,A6),D2
            lsl.w   D2,D4
            add.w   D4,D4
            movea.w D4,A0
            bra.b   .L10
            movea.w ($18,A0),A0
            adda.w  A0,A0
.L10:
            moveq   #0,D4
.L11:
            move.l  (A1),D2
            and.l   D0,D2
            bne.b   .L13
            addq.w  #1,D4
            adda.w  A0,A1
            dbra    D1,.L11
            addq.l  #4,SP
            moveq   #0,D6
.L12:
            clr.w   (A4)+
            bra.b   .L17
.L13:
            cmp.b   (A4),D4
            bcc.b   .L14
            move.b  D4,(A4)
.L14:
            movea.l (SP)+,A1
            move.w  D3,D2
            subq.w  #1,D2
            move.w  A0,D4
            mulu.w  D4,D2
            adda.l  D2,A1
            move.w  D3,D4
            move.w  D3,D1
            subq.w  #1,D1
.L15:
            move.l  (A1),D2
            and.l   D0,D2
            bne.b   .L16
            subq.w  #1,D4
            suba.w  A0,A1
            dbra    D1,.L15
            bra.b   .L12
.L16:
            addq.l  #1,A4
            cmp.b   (A4)+,D4
            bcs.b   .L17
            move.b  D4,(-1,A4)
.L17:
            subq.l  #2,A4
            tst.w   D6
            bgt.w   .L6
            move.b  (A4)+,D0
            sub.b   D0,(A4)+
            subq.w  #2,D5
            bgt.w   .L5
            bra.w   .L3
FMGREND:
            ds.b    6

            EVEN
